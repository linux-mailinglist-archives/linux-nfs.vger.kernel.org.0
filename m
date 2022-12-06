Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D6643B4B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 03:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiLFCZl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Dec 2022 21:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiLFCZj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Dec 2022 21:25:39 -0500
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 18:25:37 PST
Received: from secgw1.intern.tuwien.ac.at (secgw1.intern.tuwien.ac.at [IPv6:2001:629:1005:30::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0064C1BEAE
        for <linux-nfs@vger.kernel.org>; Mon,  5 Dec 2022 18:25:37 -0800 (PST)
Received: from totemomail (localhost [127.0.0.1])
        by secgw1.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 2B62IVaZ028854
        for <linux-nfs@vger.kernel.org>; Tue, 6 Dec 2022 03:18:31 +0100
Received: from localhost ([127.0.0.1])
          by totemomail (Totemo SMTP Server) with SMTP ID 760
          for <linux-nfs@vger.kernel.org>;
          Tue, 6 Dec 2022 03:18:30 +0100 (CET)
Received: from edge19a.intern.tuwien.ac.at (edge19a.intern.tuwien.ac.at [IPv6:2001:629:1005:30::45])
        by secgw1.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 2B62IUlA028847
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Tue, 6 Dec 2022 03:18:30 +0100
Received: from mbx19d.intern.tuwien.ac.at (2001:629:1005:30::84) by
 edge19a.intern.tuwien.ac.at (2001:629:1005:30::45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 6 Dec 2022 03:18:30 +0100
Received: from [IPV6:2001:629:3200:547:3e97:eff:fe06:513e]
 (2001:629:3200:547:3e97:eff:fe06:513e) by mbx19d.intern.tuwien.ac.at
 (2001:629:1005:30::84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 6 Dec
 2022 03:18:30 +0100
Message-ID: <dc3b95d2-93d0-992f-8f02-75c5bbb3bdff@cvl.tuwien.ac.at>
Date:   Tue, 6 Dec 2022 03:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     <linux-nfs@vger.kernel.org>
From:   Theodor Mittermair <tmittermair@cvl.tuwien.ac.at>
Organization: TU Wien E193-1 CVL
Subject: NFS performance problem (readdir, getattr, actimeo, lookupcache)
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) To
 mbx19d.intern.tuwien.ac.at (2001:629:1005:30::84)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I'm currently analyzing an nfs performance problem and hope to be in the right place to ask about it here, kindly redirect me otherwise.
I initially thought it to be a distribution specific server issue but discovered it to be a nfs client issue according to my current observations.

I created a test directory on the nfs server that as follows:
mkdir -p /nfs/server && mkdir /nfs/server/testdir{0..99} && touch /nfs/server/testdir{0..99}/testfile{0..499} && touch /nfs/server/testdir{0..99}/{500..999}

This should create 100 directories with 1000 files each, for a grand total of 100.000 files.

The nfs server exports that as follows:
/nfs nfs.client.local(rw,sync,no_subtree_check,no_root_squash)

On the nfs server, "time du -shxc /nfs/server" takes around 0.4 seconds and says the total data is around 3.6M.

Now, the following is a shortened excerpt from an nfs client, "..." represent "uninteresting data points similar to last and next".
Note that i reprocuded this issue to different degrees on different hardware and with different servers/clients.
This example had Debian 11 Kernel 5.10.0-19-amd64 for server and Ubuntu 22.04 Kernel 5.15.0-56-generic.
(I tested with other Debian,Ubuntu,Fedora,ArchLinux Clients additionally)

----------------------------------------------------------------
nfs.client.local$ sudo umount /mnt; { sudo mount -t nfs -o 'nfsvers=4.2,rw,sync,acregmin=30,acdirmin=60,acregmax=120,acdirmax=120' nfs.server.local:/nfs/server /mnt ; { for i in {1..256}; do { echo "==== $i >> " ; /usr/bin/time -f "real %e seconds" -- du -shxc /mnt 2>&1; } | sed ':a;N;$!ba;s/\n/ | /g'; done } }; sudo umount /mnt;
==== 1 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 1.53 seconds
==== 2 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 0.35 seconds
==== 3 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 0.27 seconds
...
==== 105 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 0.27 seconds
==== 106 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 0.27 seconds
==== 107 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 24.96 seconds
==== 108 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 0.25 seconds
==== 109 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 0.25 seconds
...
==== 238 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 0.26 seconds
==== 239 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 0.26 seconds
==== 240 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 25.78 seconds
==== 241 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 0.25 seconds
==== 242 >>  | 3,6M	/mnt | 3,6M	insgesamt | real 0.25 seconds
...
----------------------------------------------------------------


What I observer now is that:
1) The very first operation after mounting ([*1]!) takes around 1.53 seconds, which is expected to be slower since there is network involved and no cacheing.
2) The second and operation takes around 0.3 seconds, which is faster than the first because now there is local cache.
3) The 107th (and 240th) operation are each slower, these occur when the cache has become older than the acregmin=30, understandably.
4) However the 107th (and 240th) operation are much much mich slower than the initial first operation took to fill it's cache.

[*1] The fast cache-filling behaviour occures only after a fresh mount (which is why my test tries to ensure a fresh mount) OR for files newly created on the server (e.g. a new directory parallel to the one that was requested previously). I can extend on that if requested, but I am unsure if relevant to the core issue at hand.

I have debugged this issue with tcpdump and noticed the first operation(s) use READDIR while the the later do not (and use single GETADDR instead).

I have toyed around with serveral mount options plenty, but have not found a way to get around this.
However much i might increase actimeo (or it's resulting descendants acregmin,acdirmin,acregmax,acdirmax), the first cache filling seems to be fast but after that its slow when the cache times out.

This in turn makes it hard to choose reasonable values for actimeo (or decendants) because the production system in question uses nfs to serve home directories.
One of the real directories has for example about 4GB in volume and also around 100.000 files.
Others are much larger in volume (400GB) but atleast in similar ranges of file count (500.000).

I initially observed these very-slow-supposed-to-be-cache-filling operations to take longer than the cache timeout, resulting in the cache never really getting valid at all, resulting in very poor performance.
That could be artificially be reproduced for observation in the above example when mounting with actimeo=3, for example:
----------------------------------------------------------------
nfs.client.local$ sudo umount /mnt; { sudo mount -t nfs -o 'nfsvers=4.2,rw,sync,actimeo=3' nfs.server.local:/nfs/server /mnt ; { for i in {1..256}; do { echo "==== $i >> " ; /usr/bin/time -f "real %e seconds" -- du -shxc /mnt 2>&1; } | sed ':a;N;$!ba;s/\n/ | /g'; done } }; sudo umount /mnt;
umount: /mnt: not mounted.
==== 1 >>  | 3.6M	/mnt | 3.6M	total | real 1.34 seconds
==== 2 >>  | 3.6M	/mnt | 3.6M	total | real 0.67 seconds
==== 3 >>  | 3.6M	/mnt | 3.6M	total | real 0.61 seconds
==== 4 >>  | 3.6M	/mnt | 3.6M	total | real 0.54 seconds
==== 5 >>  | 3.6M	/mnt | 3.6M	total | real 61.25 seconds
==== 6 >>  | 3.6M	/mnt | 3.6M	total | real 62.69 seconds
==== 7 >>  | 3.6M	/mnt | 3.6M	total | real 59.70 seconds
...
----------------------------------------------------------------

I _think_ that i have sometimes (randomly?) observed it successfully filling the cache in that or similar scenarios, but was not able to reproduce that in any way on purpose.
Might have been on the production system where a concurrent request managed to fill the cache.

 From what i gathered around the internet and understood, there seem to be heuristics involved when the client decides what operations to transmit to the server.
Also, the timed-out cache seems to be creating what some called a "getattr storm", which i understand in theory.
But why does the first request manage to be smarter about it, since it gathers the same information about the exact same files?
I would be happy if i could maintain the initial-non-cached time (in the examples above 1.5 seconds) but none of "noac","lookupcache=none","actimeo=0" would let me achieve that seemingly.

Is there a way to improve that situation, and if so, how?

best regards
Theodor Mittermair
