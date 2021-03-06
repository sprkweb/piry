# coding: utf-8

$dialogs[:scene1] = $dialogs[:scenePrototype]
$dialogs[:scene1].set do |d|
  
  d.block 1 do
    d.say "Тарона", :header
    d.say "Глава N: Конец истории", :header # Исправить на номер последней главы + 1 после написания книги
    d.say "Сцена 1", :header
    
    d.say "Лес. Закат. Вокруг царит раннее лето, когда еще не очень жарко, но все растения уже давно расцвели и красуются разнообразием цветов. Тишина нарушается только шелестом листьев на слабом ветру да песнями нескольких птиц. В этих местах водятся мало хищников, из-за чего можно было не опасаться быть съеденными. Но вдруг пение разом прекратилось и над верхушками многолетних дубов показались несколько певцов, вспорхнувших из-за подозрительных звуков снизу..."
    d.say "— Эй! — послышался шепот", :phrase
    
    d.options Hash[
      "Кто там?!" => Proc.new do
        d.say "— Кто там?!", :protagonist
        d.say "— Да не кричи ты так! — послышался тот же шепот — Это я. Пошли, скоро закат.", :phrase
      end,
      "Что?" => Proc.new do
        d.say "— Что?", :protagonist
        d.say "— Пошли, скоро закат.", :phrase
      end
    ]
    d.nextBlock = 2
  end
  
  d.block 2 do
    d.say "— Но ты только посмотри...", :protagonist
    d.say "— Сначала надо разведать — перебил он.", :phrase
    d.say "В этой части леса росли самые древние деревья: высокие и широкие, настолько, что и эльф с руками длинной в дюжину обычных не смог бы обхватить их. Росли они друг от друга на порядочном расстоянии, примерно своя же толщина, взятая от трех до семи раз. Но, несмотря на это, над головой нельзя было увидеть хотя бы маленького клочка неба, так как ветви с густой листвой были настолько длинными, что с лихвой покрывали пространство между деревьями. "
    d.say "Мы, лесные эльфы, предпочитали " + "у себя".bold + " строить деревни в похожих местах: сверху надежное укрытие; длинные, толстые и крепкие ветви служат отличной опорой для домов и мостов между ними, а высота защищает от непрошенных гостей."
    d.say "Но увы, это были не наши земли, а некоторое время назад о них вообще никто из наших не знал (да и сейчас только двое). Посему нам приходилось быть настороже."
    d.say "Вдруг мы поняли, что уже несколько минут слышим ритмичные удары о землю (они доносились с северо-запада, мы шли на восток), которые с каждой минутой становились громче, как будто приближаясь."
    
    d.options Hash[
      "Спрятаться в кусты" => Proc.new do
        d.nextBlock = 3
      end,
      "Пойти навстречу звуку" => Proc.new do
        d.nextBlock = 4
      end,
      "Бежать от него" => Proc.new do
        d.nextBlock = 5
      end
      ]
  end
  
  d.block 3 do
    d.say "Мы решили спрятаться в кусты около дороги, так как неизвестно было, несет ли этот звук опасность или нет. Но мой напарник настоял, чтобы мы двигались за кустами вперед, мол, осторожности осторожностями, а идти надо. "
    d.say "Подлесок тут был образован густыми кустарниками высотой примерно полтора роста эльфа, но тем не менее, листья скрывали стебли даже у самых корней, так как росли они, в отличии от многих других кустарников, начиная сразу с нижних ветвей. Земля была покрыта мягким зеленым мхом, что помогало идти безшумно, что мы и сделали."
    d.say "Но звуки все продолжали становиться громче, из-за чего мы часто оглядывались назад. Это и то обстоятельство, что в кустарниках радиус видимого ограничен, сыграло с нами злую шутку. Мой напарник, идущий впереди, оглядываясь, не заметил какой-то овраг под ногами и упал в него. Я вышел из кустов и ахнул."
    d.say "Это был не просто овраг. Создавалось такое ощущение, будто какой-то великан величиной с гору просто выдрал огромный кусок земли, при том недавно, судя по оборванным, еще не успевшим отрасти корням деревьев по краям."
    d.say "На дне была вода, а спуск к ней был довольно крутым, хоть и не отвесным. Углубление, так я назвал это явление, было примерно семнадцати эльфов в видимую глубину (я не мог знать, насколько глубоким было озеро на дне), дюжину глубин в ширину и три ширин в длину. Падение моего товарища остановилось как раз перед самой кромкой воды, поэтому вероятность того, что он не разбился, была."
  
  end
  d.block 4 do
    d.say "Мы решили пойти навстречу звуку и узнать, что его издает."
    d.say "Пока мы шли, я обратил свое внимание с деревьев на подлесок. Он был образован густыми кустарниками высотой примерно полтора роста эльфа, но тем не менее, листья скрывали стебли даже у самых корней, так как росли они, в отличии от многих других кустарников, начиная сразу с нижних ветвей. Я взял на заметку, что он мог бы служить отличным укрытием или хорошим местом для западни."
    # Встреча с энтом +
    # $game.data["knowEnt"] = true
  end
  
  d.block 5 do
    d.say "Мы решили, что такой противоестественный в лесах звук ничего хорошего предвещать не может и побежали. Мы часто оглядывались назад и бежали быстро, поэтому мой напарник не успел вовремя заметить и сбавить ход перед огромным, так скажем, углублением в земле и упал в него."
    d.say "Создавалось такое ощущение, будто какой-то великан величиной с гору просто выдрал огромный кусок земли, при том недавно, судя по оборванным, еще не успевшим отрасти корням деревьев по краям."
    d.say "На дне была вода, а спуск к ней был довольно крутым, хоть и не отвесным. Углубление, так я назвал это явление, было примерно семнадцати эльфов в видимую глубину (я не мог знать, насколько глубоким было озеро на дне), дюжину глубин в ширину и три ширин в длину. Падение моего товарища остановилось как раз перед самой кромкой воды, поэтому вероятность того, что он не разбился, была."
    d.options Hash[
    "Осторожно спуститься" => Proc.new do
      d.nextBlock = 6
    end,
    "Быстро спуститься" => Proc.new do
      d.nextBlock = 7
    end,
    "Не спускаться" => Proc.new do
      d.nextBlock = 8
    end
    ]
  end
  
  d.block 6 do
    d.say "Я стал осторожно спускаться, чтобы не упасть самому. После каждого шага из-под ног сыпалась вниз земля и камни. Я, может медленно, но без вреда для здоровья добрался до спутника и тут же пожалел об этом."
    d.say "Из его ноги не слишком быстро, но верно струей шириной в два пальца из рассеченной камнем ноги текла кровь. Он лежал без  сознания. Я, не мешкая, разорвал свой рукав, сделал из него перевязь, чтобы замедлить течение и дал выпить остатки целебного варева."
    d.say "Струя стала намного уже. Жить будет, но он без сознания, с поврежденной ногой и потому придется нести его первое время, а так же делать множество привалов. Это существенно замедлит разведку."
    $game.data["woundOnTheLeg"] = true
  end
  
  d.block 7 do
    d.say "Нельзя было мешкать, пока товарищ в беде. Я стал спускаться, к счастью, не упав и быстро добрался до него."
    d.say "Из его ноги не быстро, но верно струей шириной в большой палец из рассеченной камнем ноги текла кровь. Он лежал без  сознания. Я, не мешкая, разорвал свой рукав, сделал из него перевязь, чтобы замедлить течение и дал выпить остатки целебного варева."
    d.say "Струя превратилась в капли. Жить будет, но он без сознания, с поврежденной ногой и потому придется нести его первое время, а так же чаще делать привалы. Это немного замедлит разведку."
    $game.data["woundOnTheLeg"] = true
  end
  
  d.block 8 do
    d.say "— Не хорошо бросать товарищей в беде — прогремело c печальной интонацией что-то сзади меня", :phrase
    d.say "Только сейчас я понял, что громкие удары уже некоторое время не были слышны. Я обернулся и ничего, кроме деревьев, не увидел."
    d.say "Через некоторое время осматривания пространства позади себя мой взгляд остановился на чем-то. Это было странное дерево: как будто два ствола соединялись посередине в один, а затем расходились на 3 ветви: одна посередине, самая широкая и две по бокам, причем последние расположены не по диагонали вверх, как это обычно бывает, а почти вертикально вниз. В общих чертах это было очень странное человекоподобное дерево, как я позже узнал, энт."
    $game.data["knowEnt"] = true
  end
  
  d.block 9 do
    d.say "Я решил, что перечить ему не стоит, к тому же я действительно плохо хотел поступить и поэтому осторожно спустился. У друга из рассеченной камнем ноги сильной струей текла кровь."
    $game.data["woundOnTheLeg"] = true
    d.say "Я разорвал свой рукав, сделал из него перевязь, чтобы замедлить течение и дал выпить остатки целебного варева. Тем не менее, струя хоть немного сузилась, все еще была шириной с большой палец. Затем омыл рану в озере, благо вода была там пресная, как в ручье, несмотря на тот факт, что ни одна река ни втекала, ни вытекала из него."
    d.say "Не придумав ничего лучшего, я стал подниматься наверх, чтобы найти лечебных трав. Спустя несколько минут трудного и поспешного подъема (земля рассыпалась под ногами и руками) выбрался наверх и очень удивился, увидев говорящее дерево с нужными мне растениями в руке, если позволите мне ее так назвать. Я поблагодарил, взял травы и спустился к спутнику. Мои руки сами сделали то, чему меня годами учили старцы: смять травы особым образом, чтобы из них как можно сильнее полил сок, собрать его в широкий лист и осторожно смазать рану, дав оставшееся выпить ее владельцу. Кровотечение уже заметно уменьшилось и за его жизнь можно было не бояться."
  end
  
  $game.data["dialog"] = :scene1.to_s
  $game.save $paths["data"] + "/saves/save"
  
  $game.data["knowEnt"] = false
  $game.data["woundOnTheLeg"] = false
  
  d.blocksStart 1
end