function counting (){
  // item-priceのエリア（価格）と販売手数料と利益表示を連動させる。
  const articleText  = document.getElementById("item-price");

  articleText.addEventListener("keyup", () => {
    const price = articleText.value
    // 手数料設定
    const fee = 0.1
    // 販売手数料のIDを特定
    const addTaxPrice = document.getElementById("add-tax-price");
    // 販売利益表示のIDを特定
    const profit = document.getElementById("profit");
    // 販売手数料 (10%) 表示
    addTaxPrice.innerHTML = `${price*fee}`;
    // 販売利益表示
    profit.innerHTML = `${price*(1-fee)}`;
  });
}

window.addEventListener('load', counting);