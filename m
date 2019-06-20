Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2074CDC8
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2019 14:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfFTMda (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jun 2019 08:33:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57563 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbfFTMd3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jun 2019 08:33:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 940B622050;
        Thu, 20 Jun 2019 08:33:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 20 Jun 2019 08:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pxsbtT
        D4I+NFkZMySMTNns8mBp8RZ6cCxYS2iiNTwuM=; b=vgw6v+a7lbACtF1ZT6psn9
        KPDgE4Md+lW8Cvg73Q/pO8UtWHCOsoA9Jgq7dhv5hWuHUEGQy+eJ/+/Rcf9DVmPy
        JCbWshcyxF4fEMdEp84GfLp0k4kaZm0rbAXvx8HqgzaG5gJbPzSF3lTqOmmVOcEG
        BgvkjsV37URjrTKz8j7nslUY59DXj+zeTkw+BDkl53kCl8q3WVUpl4HVIx7Gn6fq
        cqj1n+4KtRX+VeRVV2t5tveOz9oeENKJoFDHAlmgb6SdExIIiqZu4uIceUi30t26
        ylRgKdsjf/FDCBcnSL/62gfpiabopccMGGfwgQKiGuSF5IOIZ+pADLh5J5lVUrlQ
        ==
X-ME-Sender: <xms:GH0LXXasg00T5FJIxAqFdxo_KwrQ9rphpF-Wby31AWBFlqV2HZom-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtdeggdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucffohhmrghinh
    epfhhrvggvuggvshhkthhophdrohhrghdprhgvqhhuihhrvggurdhpihhnghdpkhgvrhhn
    vghlrdhorhhgnecukfhppeduleefrdegjedrudeihedrvdehudenucfrrghrrghmpehmrg
    hilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghenucevlhhushhtvghrufhi
    iigvpedt
X-ME-Proxy: <xmx:GH0LXa9T_6siyns1-_rWdxLoRvcEQlIg7xJXLYhnRZ62eIcGH4haqA>
    <xmx:GH0LXV3MIP9_Ju5D9CgrYCuXGBNxTuhyNEAMT0L9Xp4QV0t_2TzWwg>
    <xmx:GH0LXaXBwvvXI3uA20oRYbj2Ui9TiDNcx42m1XIyqMukvu6QtDAsAA>
    <xmx:GH0LXfzmX_79OXISxilYsIz3JSMjVsmY_Z2Mm6gdSfkMl7EhAyAzjQ>
Received: from localhost (unknown [193.47.165.251])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9AD24380076;
        Thu, 20 Jun 2019 08:33:27 -0400 (EDT)
Date:   Thu, 20 Jun 2019 15:33:25 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/9] SUNRPC: Cache cred of process creating the rpc_client
Message-ID: <20190620123325.GA24746@splinter>
References: <20190424214650.4658-1-trond.myklebust@hammerspace.com>
 <20190424214650.4658-2-trond.myklebust@hammerspace.com>
 <20190614185237.GA550@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614185237.GA550@splinter>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 14, 2019 at 09:52:37PM +0300, Ido Schimmel wrote:
> On Wed, Apr 24, 2019 at 05:46:42PM -0400, Trond Myklebust wrote:
> > When converting kuids to AUTH_UNIX creds, etc we will want to use the
> > same user namespace as the process that created the rpc client.
> > 
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Hi,
> 
> Since upgrading to v5.2-rc1 I started encountering these memory leaks
> [1]. Bisection using this reproducer [2] points to this patch. Attached
> the full bisection log [3].
> 
> Please let me know if more information is required.

Ping?

> 
> Thanks
> 
> [1]
> unreferenced object 0xffffa35dfaea3000 (size 192):
>   comm "mount", pid 428, jiffies 4294703475 (age 7.578s)
>   hex dump (first 32 bytes):
>     03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000b43bed74>] prepare_exec_creds+0x6/0x40
>     [<00000000422eb980>] __do_execve_file.isra.56+0x124/0x930
>     [<00000000aa848639>] __x64_sys_execve+0x2f/0x40
>     [<000000008d5c43e1>] do_syscall_64+0x43/0xf0
>     [<0000000068b03b0e>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     [<000000001fab781f>] 0xffffffffffffffff
> 
> [2]
> #!/bin/bash
> 
> umount /mnt/share155
> mount -t nfs <nfs-server>:/images/share /mnt/share155
> echo scan > /sys/kernel/debug/kmemleak
> cat /sys/kernel/debug/kmemleak
> 
> [3]
> git bisect start
> # good: [e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd] Linux 5.1
> git bisect good e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
> # bad: [a188339ca5a396acc588e5851ed7e19f66b0ebd9] Linux 5.2-rc1
> git bisect bad a188339ca5a396acc588e5851ed7e19f66b0ebd9
> # good: [2646719a48c21ba0cae82a3f57382a9573fd8400] Merge tag 'kbuild-v5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> git bisect good 2646719a48c21ba0cae82a3f57382a9573fd8400
> # bad: [b970afcfcabd63cd3832e95db096439c177c3592] Merge tag 'powerpc-5.2-1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect bad b970afcfcabd63cd3832e95db096439c177c3592
> # good: [eb85d03e01c3e9f3b0ba7282b2e3515a635decb2] Merge tag 'drm-misc-next-fixes-2019-05-08' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> git bisect good eb85d03e01c3e9f3b0ba7282b2e3515a635decb2
> # good: [dce45af5c2e9e85f22578f2f8065f225f5d11764] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
> git bisect good dce45af5c2e9e85f22578f2f8065f225f5d11764
> # bad: [8e4ff713ce313dcabbb60e6ede1ffc193e67631f] Merge tag 'rtc-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
> git bisect bad 8e4ff713ce313dcabbb60e6ede1ffc193e67631f
> # bad: [45182e4e1f8ac04708ca7508c51d9103f07d81ab] Merge branch 'i2c/for-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> git bisect bad 45182e4e1f8ac04708ca7508c51d9103f07d81ab
> # bad: [5940d1cf9f42f67e9cc3f7df9eda39f5888d6e9e] SUNRPC: Rebalance a kref in auth_gss.c
> git bisect bad 5940d1cf9f42f67e9cc3f7df9eda39f5888d6e9e
> # good: [23146500b32fbee7eaa57c5002fcd64e5d9b32ca] xprtrdma: Clean up rpcrdma_create_rep() and rpcrdma_destroy_rep()
> git bisect good 23146500b32fbee7eaa57c5002fcd64e5d9b32ca
> # good: [2cfd11f16f01c0ee8f83bb07027c9d2f43565473] xprtrdma: Remove stale comment
> git bisect good 2cfd11f16f01c0ee8f83bb07027c9d2f43565473
> # bad: [b422df915cef80333d7a1732e6ed81f41db12b79] lockd: Store the lockd client credential in struct nlm_host
> git bisect bad b422df915cef80333d7a1732e6ed81f41db12b79
> # bad: [ac83228a7101e655ba5a7fa61ae10b058ada15db] SUNRPC: Use namespace of listening daemon in the client AUTH_GSS upcall
> git bisect bad ac83228a7101e655ba5a7fa61ae10b058ada15db
> # bad: [1a58e8a0e5c1f188a80eb9e505bc77d78a31a4ec] NFS: Store the credential of the mount process in the nfs_server
> git bisect bad 1a58e8a0e5c1f188a80eb9e505bc77d78a31a4ec
> # bad: [79caa5fad47c69874f9efc4ac3128cc3f6d36f6e] SUNRPC: Cache cred of process creating the rpc_client
> git bisect bad 79caa5fad47c69874f9efc4ac3128cc3f6d36f6e
> # first bad commit: [79caa5fad47c69874f9efc4ac3128cc3f6d36f6e] SUNRPC: Cache cred of process creating the rpc_client
