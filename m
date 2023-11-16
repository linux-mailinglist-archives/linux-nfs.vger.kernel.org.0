Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97CC7EDED8
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 11:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbjKPKsj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 05:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345023AbjKPKsi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 05:48:38 -0500
X-Greylist: delayed 587 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 02:48:33 PST
Received: from fw.sz-a.kwebs.cloud (fw.sz-a.kwebs.cloud [109.61.102.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE091B3
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 02:48:33 -0800 (PST)
Received: from webmail.srv.kwebs.cloud (unknown [172.16.36.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        (Authenticated sender: richard@kojedz.in)
        by mx.kwebs.cloud (Postfix) with ESMTPSA id AC28A14388
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kojedz.in; s=s02;
        t=1700131122; bh=A1fuKc8p4y4svbHp/BbF2AuON58ba7xcCwozEX3px6k=;
        h=Date:From:To:Subject;
        b=i1WmWgVNUNc5+aDoWXoJvw5qMQJ+EImpVaBRi5a1ZRqCT0R8Re5wg2LFQF6qvhRIb
         xYVo/qtN4YIsppPCbp2QXqFEqoXohKtDcFH43lX65iHEWKvmQYBjC6TJkqi5sH49Y1
         6XTkCEn+eQE8PiqiAPs2DR0CzXmY3swNS9QSzRQCfbtD7sKf4w7AOzD8hXitl26Nvx
         OBkE17WYtVTGT2fXTBKxGhFQZ8BSriHJoLFtP++9joLmMECTzSsZp7us/+ZIwzVT9/
         K73JKGI+ROQhWFo65CIzqG6hx4toVoCGfxnbB7blftHI556KP7dE3cgn/AHWnelgoJ
         pLNYpjgNfjrvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kojedz.in; s=s01;
        t=1700131122; bh=A1fuKc8p4y4svbHp/BbF2AuON58ba7xcCwozEX3px6k=;
        h=Date:From:To:Subject;
        b=bR6SX8mQMRf4W/lCZrO16QobHygANd0HcPFyBErvPZyFx1+dg8P1nhJ8Jb2drOYJ0
         yBMFTtRQ7YP+jjmDRsm4awKLTXaIx5Z8vpfWv5E6W5Ohm3gM/DFIfBvPC1eRUBHdBF
         XXOE090B4fbF57hgwsT8eVV/3Y3aKD56m+O4yrC6LTcNRGKiQweB0P9OHAnNPNcYp6
         XKwgVzcCpPuDvWP/jwCuR4YB8IR6/Ffe545MGaHi02ByF7KO+oGYQ4iDm1qJ96GurA
         GWNjW3o8tgDL8fC8HfYvH3UIe5QrUM4qxdFkrc6LlEeLpnauxzhNyjFC+3/wGBAeBa
         54CXA94zKCyFAGBlnoiiagpdHK2XqZwkfIpzGrZnGvTa7wSa3qBDCJn9HK9PQp3PtK
         Vf5DdNVwszupyzoqC5BX0XouuejFZ6NF8hgMoGK6s35NxfGbVfgyLBph89KcURcZMb
         SQ8AyadJNSAm+/rrLPPtBttv0fD47uqIu78zr6WtqtOIS4dIXC1
MIME-Version: 1.0
Date:   Thu, 16 Nov 2023 11:38:42 +0100
From:   richard@kojedz.in
To:     linux-nfs@vger.kernel.org
Subject: nfs client caching issues
Message-ID: <c1091755f4df062e32ffd78674ac3646@kojedz.in>
X-Sender: richard@kojedz.in
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear nfs developers,

We are running gitea in k8s in two pods, the two pods are running on 
different vms. Gitea datadir is mounted as an nfs share, and we 
periodically experience a caching issue, where one of the pods is 
out-of-sync with directory entries:

# kubectl -n ci-cd exec -it gitea-546489b89b-c8j5j -- sh -c 'cd 
git/repositories/.../objects/pack && ls -la'
total 32627
drwxr-xr-x    2 git      git              5 Nov 16 08:59 .
drwxr-xr-x    4 git      git              4 Nov 16 08:59 ..
-r--r--r--    1 git      git          28634 Nov 16 08:59 
pack-f3648f5e8e42d671dee4868d08fe24fa50b47fac.bitmap
-r--r--r--    1 git      git         134744 Nov 16 08:59 
pack-f3648f5e8e42d671dee4868d08fe24fa50b47fac.idx
-r--r--r--    1 git      git       33191104 Nov 16 08:59 
pack-f3648f5e8e42d671dee4868d08fe24fa50b47fac.pack

# kubectl -n ci-cd exec -it gitea-546489b89b-d7lcn -- sh -c 'cd 
git/repositories/.../objects/pack && ls -la'
ls: ./pack-249aee1788eeaca050d1c083e6598d675ba1017e.pack: No such file 
or directory
ls: ./pack-249aee1788eeaca050d1c083e6598d675ba1017e.bitmap: No such file 
or directory
ls: ./pack-249aee1788eeaca050d1c083e6598d675ba1017e.idx: No such file or 
directory
total 25
drwxr-xr-x    2 git      git              5 Nov 16 08:59 .
drwxr-xr-x    4 git      git              4 Nov 16 08:59 ..
command terminated with exit code 1

The second pod has cached directory entries, howewer, they are not 
present. But, if I stat the existing files on the failing pod, it 
succeeds:
# kubectl -n ci-cd exec -it gitea-546489b89b-d7lcn -- sh -c 'cd 
git/repositories/.../objects/pack && stat 
pack-f3648f5e8e42d671dee4868d08fe24fa50b47fac.bitmap'
   File: pack-f3648f5e8e42d671dee4868d08fe24fa50b47fac.bitmap
   Size: 28634     	Blocks: 41         IO Block: 131072 regular file
Device: c0h/192d	Inode: 98069       Links: 1
Access: (0444/-r--r--r--)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
Access: 2023-11-16 08:59:38.176448632 +0000
Modify: 2023-11-16 08:59:38.177839293 +0000
Change: 2023-11-16 08:59:38.203249724 +0000

Seems that the directory metadata is the same on the nodes:
# kubectl -n ci-cd exec -it gitea-546489b89b-c8j5j -- sh -c 'cd 
git/repositories/.../objects/pack && stat .'
   File: .
   Size: 5         	Blocks: 49         IO Block: 131072 directory
Device: 87h/135d	Inode: 15013       Links: 2
Access: (0755/drwxr-xr-x)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
Access: 2023-11-16 09:06:02.594066258 +0000
Modify: 2023-11-16 08:59:38.232154965 +0000
Change: 2023-11-16 08:59:38.232154965 +0000

# kubectl -n ci-cd exec -it gitea-546489b89b-d7lcn -- sh -c 'cd 
git/repositories/.../objects/pack && stat .'
   File: .
   Size: 5         	Blocks: 49         IO Block: 131072 directory
Device: c0h/192d	Inode: 15013       Links: 2
Access: (0755/drwxr-xr-x)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
Access: 2023-11-16 09:06:02.594066258 +0000
Modify: 2023-11-16 08:59:38.232154965 +0000
Change: 2023-11-16 08:59:38.232154965 +0000

Issuing ls on the failing generates getattr for the directory. I assume 
it receives the already cached metadata, then assumes there were no 
changes, and then tries to stat() the cached 3 files with no success.

It is enough to just touch the affected directory even on the other 
node, this makes the failing node to recover, get in sync again.

Both nodes are running Debian stable kernel:
# uname -a
Linux node 6.1.0-13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.55-1 
(2023-09-29) x86_64 GNU/Linux

The nfs server is a TrueNAS server (FreeBSD).

We have default mount options:

# mount | grep nfs4
x.x.x.x:/mnt/main/e-sz-k8s/csi/rgbcpj4nw9tywroxrqw8bpw1zmzyu5mg on 
/var/lib/kubelet/pods/69d3e536-d0a9-4c02-9461-8f14d058ea60/volumes/kubernetes.io~csi/pvc-c76ad5da-9c1b-4692-b768-5469a9517d57/mount 
type nfs4 
(rw,relatime,vers=4.2,rsize=131072,wsize=131072,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=c.c.c.c,local_lock=none,addr=x.x.x.x)

Is it cache configuration issue, or a bug in linux nfs client or freebsd 
nfs server code?

Thanks in advance,
Richard
