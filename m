Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A34FA9D
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2019 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfFWHc3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jun 2019 03:32:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51179 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfFWHc3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jun 2019 03:32:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 31D8F21E56;
        Sun, 23 Jun 2019 03:32:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 23 Jun 2019 03:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FABXvf
        lUL4aIVjrhxX5OHfdaCppukYpxcLhDibROd+s=; b=QSQIaKGECLh76E0sHmeukN
        EfNCb7hwHqKLhR16NzILsAtr3YNfO3HTvllo40O9/bm/KGHBxMVdMM4nMHpuQp0O
        KGvsqVZ1iDlZ3OTiYXnTY7IeHNyKfc+X/thkwKirUtMgFiJmfkquVmyYTBnFcavU
        pGyiPsv3rytRdB+i8hOSzNVHbsqYW0EvLakAz79gj06+JU8DHPzVCh3mrpVWYkfD
        KYPuCFR1rPXNlEt08y0nalAe/t0svcSRwySMqTfrdaPmNjtHISCpzh54ZlCxXzqO
        MMzAgA+h2stBioKtZDZ7GQssoL1ykriLhXtxIR/ZY6DADDUw0WaeO3fmNN8ltbSg
        ==
X-ME-Sender: <xms:CysPXU6y5EHyQhcd07x1xqBd4YjW3USDKZ-NDJgTPBhWTko7mE2HHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtdelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphepudelfedrgeejrdduieehrddvhedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:CysPXeFRQlkg0ppP8PLKYpHIcZvHIJ_IeZAwF0bcjPgKjlo2CsPT2A>
    <xmx:CysPXawUgi-ekGmkl9SEQBuG9SffenC1d1jmUbO-7tXrhgoL-ONbjg>
    <xmx:CysPXW17dp8ODZMDyEJgK7McGEyhxYqk7o--49MiIo2SqpdXWilObQ>
    <xmx:DCsPXZONxSVcLWHKjvT1McQ0gcfTcVXgLxVBFqGGoFBX0hHwBTsa4w>
Received: from localhost (unknown [193.47.165.251])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4CD7C380075;
        Sun, 23 Jun 2019 03:32:27 -0400 (EDT)
Date:   Sun, 23 Jun 2019 10:32:25 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: memory leaks reported during xfstests
Message-ID: <20190623073225.GA21489@splinter>
References: <6842E17A-0209-40A2-B71B-14C8361C7166@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6842E17A-0209-40A2-B71B-14C8361C7166@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 21, 2019 at 05:58:48PM -0400, Chuck Lever wrote:
> For unrelated reasons I've enabled kmemleak in my client's kernel.
> While running xfstests, I get these reports on several of the tests.
> I've seen them on a few recent kernels as well.
> 
> They do not look related to NFS. Anyone know where I should report
> this?

Most likely fixed by:
https://patchwork.kernel.org/patch/11006849/

See this report:
https://lore.kernel.org/linux-nfs/20190614185237.GA550@splinter/#t

> 
> 
> [cel@manet ~]$ cat src/xfstests/results/generic/013.kmemleak
> EXPERIMENTAL kmemleak reported some memory leaks!  Due to the way kmemleak
> works, the leak might be from an earlier test, or something totally unrelated.
> unreferenced object 0xffff88886963c4c0 (size 168):
>   comm "mount", pid 3471, jiffies 4296003082 (age 161.789s)
>   hex dump (first 32 bytes):
>     03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000fd30522a>] kmem_cache_alloc+0xc4/0x1cb
>     [<0000000008f8eac6>] prepare_creds+0x21/0xc7
>     [<000000006e9e3064>] prepare_exec_creds+0xb/0x3a
>     [<000000001b408d7e>] __do_execve_file.isra.31+0x103/0x818
>     [<000000004096f0a3>] do_execve+0x25/0x29
>     [<0000000008a9aa1c>] __x64_sys_execve+0x26/0x2b
>     [<00000000599d3d33>] do_syscall_64+0x5a/0x68
>     [<00000000005d29f3>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> unreferenced object 0xffff888867a4f708 (size 32):
>   comm "mount", pid 3471, jiffies 4296003082 (age 161.789s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000004c53b46c>] __kmalloc+0xfc/0x14a
>     [<000000002ff13bd8>] lsm_cred_alloc.isra.5+0x24/0x32
>     [<000000009eb979ec>] security_prepare_creds+0x21/0x61
>     [<0000000086789f15>] prepare_creds+0xb3/0xc7
>     [<000000006e9e3064>] prepare_exec_creds+0xb/0x3a
>     [<000000001b408d7e>] __do_execve_file.isra.31+0x103/0x818
>     [<000000004096f0a3>] do_execve+0x25/0x29
>     [<0000000008a9aa1c>] __x64_sys_execve+0x26/0x2b
>     [<00000000599d3d33>] do_syscall_64+0x5a/0x68
>     [<00000000005d29f3>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [cel@manet ~]$
> 
> --
> Chuck Lever
> 
> 
> 
