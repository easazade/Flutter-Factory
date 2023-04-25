// Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode({required this.val, this.next});
}

ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
  if (list1 == null) return list2;
  if (list2 == null) return list1;

  ListNode dummy = ListNode(val: 0);
  ListNode tail = dummy;

  while (list1 != null && list2 != null) {
    if (list1.val < list2.val) {
      tail.next = list1;
      list1 = list1.next;
    } else {
      tail.next = list2;
      list2 = list2.next;
    }

    tail = tail.next ?? tail;
  }

  tail.next = (list1 != null) ? list1 : list2;
  return dummy.next;
}

ListNode? createSingleLinkedList(List<int> numbers) {
  late ListNode firstNode;
  ListNode? currentNode;

  for (var i = 0; i < numbers.length; i++) {
    final number = numbers[i];
    final newNode = ListNode(val: number);
    if (i == 0) {
      firstNode = newNode;
    }
    if (currentNode != null) {
      currentNode.next = newNode;
    }
    currentNode = newNode;
  }

  return firstNode;
}

void printLinkedList(ListNode list) {
  ListNode? resultList = list;

  final buffer = StringBuffer('[');
  while (resultList != null) {
    buffer.write('${resultList.val}, ');
    resultList = resultList.next;
  }
  buffer.write(']');

  print(buffer.toString());
}
