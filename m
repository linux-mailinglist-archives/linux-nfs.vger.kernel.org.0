Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1704F091
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2019 23:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFUV6x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jun 2019 17:58:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57818 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUV6x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jun 2019 17:58:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LLn4qA079307
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2019 21:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 to; s=corp-2018-07-02; bh=8vhYhDfhUNukkhHgQ5rS8KEs9Leu2JQC3S006q5hvlk=;
 b=g8bsssdaPg+Bg8oMWywuCSNnLShoPEN6YTvPIsUqfX5oEJ1VLZQ7+ylbAqVqemLMBuCU
 UXYI4oNCDxZL7v/ZNnaByFjcsXFkdZdj4gufMDZu8S1bb6K3gF09jswAOoWmAKXnqg/T
 d9nsKHkGiazQjPyrZ6johBVy9G1BolgogH3/LczzVr3TVdLBHKdY3P6E3wz+1ERgs7Uh
 ULvTXFCquOmp6TTdoCkLzJizhegO2/oPZPafH45MQ8DtiXvXMd5m0uKSISFZSow6gL2z
 pe7ecstJNsMnju/DSbWynCRWEWQXKwvoHs9x8PQeflR4kcYZdNApERK0gsvDCoaZy0uF RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t7809rg51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2019 21:58:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LLw3kd162112
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2019 21:58:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t7rdxy5xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2019 21:58:50 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5LLwnJr028890
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2019 21:58:49 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Jun 2019 14:58:49 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: memory leaks reported during xfstests
Message-Id: <6842E17A-0209-40A2-B71B-14C8361C7166@oracle.com>
Date:   Fri, 21 Jun 2019 17:58:48 -0400
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210166
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For unrelated reasons I've enabled kmemleak in my client's kernel.
While running xfstests, I get these reports on several of the tests.
I've seen them on a few recent kernels as well.

They do not look related to NFS. Anyone know where I should report
this?


[cel@manet ~]$ cat src/xfstests/results/generic/013.kmemleak
EXPERIMENTAL kmemleak reported some memory leaks!  Due to the way =
kmemleak
works, the leak might be from an earlier test, or something totally =
unrelated.
unreferenced object 0xffff88886963c4c0 (size 168):
  comm "mount", pid 3471, jiffies 4296003082 (age 161.789s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000fd30522a>] kmem_cache_alloc+0xc4/0x1cb
    [<0000000008f8eac6>] prepare_creds+0x21/0xc7
    [<000000006e9e3064>] prepare_exec_creds+0xb/0x3a
    [<000000001b408d7e>] __do_execve_file.isra.31+0x103/0x818
    [<000000004096f0a3>] do_execve+0x25/0x29
    [<0000000008a9aa1c>] __x64_sys_execve+0x26/0x2b
    [<00000000599d3d33>] do_syscall_64+0x5a/0x68
    [<00000000005d29f3>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
unreferenced object 0xffff888867a4f708 (size 32):
  comm "mount", pid 3471, jiffies 4296003082 (age 161.789s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004c53b46c>] __kmalloc+0xfc/0x14a
    [<000000002ff13bd8>] lsm_cred_alloc.isra.5+0x24/0x32
    [<000000009eb979ec>] security_prepare_creds+0x21/0x61
    [<0000000086789f15>] prepare_creds+0xb3/0xc7
    [<000000006e9e3064>] prepare_exec_creds+0xb/0x3a
    [<000000001b408d7e>] __do_execve_file.isra.31+0x103/0x818
    [<000000004096f0a3>] do_execve+0x25/0x29
    [<0000000008a9aa1c>] __x64_sys_execve+0x26/0x2b
    [<00000000599d3d33>] do_syscall_64+0x5a/0x68
    [<00000000005d29f3>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
[cel@manet ~]$

--
Chuck Lever



