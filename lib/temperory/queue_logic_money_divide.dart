//     // Queue<String> q1, q2;
//     // Queue<int> q11, q22;

//     Queue q1 = new Queue();
//     Queue q2 = new Queue();
//     for (var m in transactions[0].members) {
//       print(m);
//       int amount = amountOfparticular[nameToId[m.name]] == null
//           ? 0
//           : amountOfparticular[nameToId[m.name]];
//       String name = m.name;
//       if (amount < perPerson) {
//         //dene a paise
//         int rem = perPerson - amount;
//         while (!q1.isEmpty && rem > 0) {
//           String q1Name = q1.first.name;
//           int q1Amount = q1.first.amount;

//           if (q1Amount >= rem) {
//             q1Amount -= rem;
//             //print('map ala km');
//             if (finalHisab.containsKey(q1Name))
//               finalHisab[q1Name].add((KeyValue(name: name, amount: rem)));
//             else {
//               finalHisab[q1Name] = <KeyValue>[];
//               finalHisab[q1Name].add((KeyValue(name: name, amount: rem)));
//             }
//             if (q1Amount != 0) {
//               q1.addFirst(KeyValue(name: q1Name, amount: q1Amount));
//             }
//             rem = 0;
//             break;
//           } else {
//             rem -= q1Amount;
//             // print('map ala km');
//             if (finalHisab.containsKey(q1Name))
//               finalHisab[q1Name].add((KeyValue(name: name, amount: q1Amount)));
//             else {
//               finalHisab[q1Name] = <KeyValue>[];
//               finalHisab[q1Name].add((KeyValue(name: name, amount: q1Amount)));
//             }
//           }
//         }
//         if (rem > 0) {
//           //sarya nu dete bach remaining kuch bachya
//           print('queue 1');
//           q2.add(KeyValue(name: name, amount: rem));
//         }
//       } else {
//         ///leni a amount +ve
//         //print('just queue');
//         q1.add(KeyValue(name: name, amount: amount - perPerson));
//       }
//     }
//   //  finalHisab.values.toList();
//     print('bale bale ');

// List<List<KeyValue>> data = List();

// finalHisab.forEach((k,v) => data.add(v)); 
// //print(data[0][0].name);