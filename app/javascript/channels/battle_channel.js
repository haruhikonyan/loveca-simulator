import consumer from "channels/consumer"

consumer.subscriptions.create("BattleChannel", {
 connected() {
   document.
     querySelector('input[data-behavior="battle_speaker"]').
     addEventListener('keypress', (event) => {
       if (event.key === 'Enter') {
         this.speak(event.target.value);
         event.target.value = '';
         return event.preventDefault();
       }
     });

   // ターン終了ボタンのイベントリスナーを追加
   document.
     querySelector('button[data-behavior="end_turn"]')?.
     addEventListener('click', (event) => {
       const battleId = event.target.dataset.battleId;
       this.endTurn(battleId);
       return event.preventDefault();
     });

   this.setupCardListeners();
 },

 disconnected() {
 },

 received(data) {
   if (data.type === 'board_update') {
     // ボード全体を更新
     const element = document.querySelector('.battle-board');
     element.outerHTML = data.html;
     
     // イベントリスナーを再設定
     this.setupEndTurnButton();
     this.setupCardListeners();
   } else {
     // 既存のメッセージ処理
     const element = document.querySelector('#battle');
     element.insertAdjacentHTML('beforeend', data['message']);
   }
 },

 speak: function(message) {
   return this.perform('speak', { message: message });
 },

 endTurn: function(battleId) {
   return this.perform('end_turn', { battle_id: battleId });
 },

 playCard: function(battleId, sequence, player, position) {
   return this.perform('play_card', {
     battle_id: battleId,
     sequence: sequence,
     player: player,
     position: position
   });
 },

 setupEndTurnButton: function() {
   const button = document.querySelector('button[data-behavior="end_turn"]');
   if (button) {
     button.addEventListener('click', (event) => {
       const battleId = event.target.dataset.battleId;
       this.endTurn(battleId);
       return event.preventDefault();
     });
   }
 },

 setupCardListeners: function() {
   const modal = document.getElementById('position-select-modal');
   let currentCard = null;

   // プレイ可能なカードにクリックイベントを設定
   document.querySelectorAll('[data-behavior="playable_card"]').forEach(card => {
     card.addEventListener('click', (event) => {
       currentCard = event.currentTarget;
       modal.style.display = 'block';
     });
   });

   // モーダル内のボタンにイベントを設定
   document.querySelectorAll('.position-button').forEach(button => {
     button.addEventListener('click', () => {
       if (currentCard) {
         const battleId = document.querySelector('[data-battle-id]').dataset.battleId;
         const sequence = currentCard.dataset.sequence;
         const player = currentCard.dataset.player;
         const position = button.dataset.position;

         this.playCard(battleId, sequence, player, position);
         modal.style.display = 'none';
         currentCard = null;
       }
     });
   });

   // モーダルの外側をクリックした時に閉じる
   modal.addEventListener('click', (event) => {
     if (event.target === modal) {
       modal.style.display = 'none';
       currentCard = null;
     }
   });
 }
});
