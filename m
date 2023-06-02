Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A437A720679
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jun 2023 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjFBPqo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Jun 2023 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjFBPqo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Jun 2023 11:46:44 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D7A197
        for <linux-nfs@vger.kernel.org>; Fri,  2 Jun 2023 08:46:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 010CF32005BC;
        Fri,  2 Jun 2023 11:46:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Jun 2023 11:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685720801; x=1685807201; bh=yUCaJGilLL/NV
        fxyeFwW4/n4il9W/LPwCFx6izGQvHg=; b=nW6Er57gmaYvEZp5u/VGyYUfMpuC6
        SKSowfWH83iclJGU5xgl4RwQHNDcLaSDJCo1En9P+RpmVaHqyaEnCFTiqNGNETHO
        QfJEsLoIOZ8p95x9Zbkf7e19ytyhCePrjq5+Ur1vlI3YLpdqH5ZgdPeEqoROO+Ib
        PnFWcG6Id7k+P4lqBVefLyJ3Gw2oUUP0AG84JUMEcDOVlv9LcAQmynKFNB1TiKVd
        KgciOkk5kZeSTYwn70AT5YflL/Fm0qa50BLHv9xj38+MCNc6A7tIAefoWbkcW4p4
        2oxAgxm3+CIGCVSCZkifuWrrvsuhEKHYzni5zTzktQ2RuMnxeyQEEnVvQ==
X-ME-Sender: <xms:4Q56ZBD87uOQ5YVDT0qjy5VN9URMoeyDgMcstuE7JHCn62_20jCJpg>
    <xme:4Q56ZPjO7UkPvO7uOEenwsfzhMGA-fHSdMtzRvscdYSwsv_lOgIIbu55bpw7MAzLP
    hKRQjgsHZRICOo>
X-ME-Received: <xmr:4Q56ZMlHNPYWPP7lMXHPhRhHT9KYVThWuzNhv0b_EtwIkqMattslQPxCzonxXp_UsoBwai5-cqn-k5LNLPZKQTt8AME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepkedvffeulefggfeghffflefhudffudduveetjedvvdettdffffduvdfgfefg
    udeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpfhhrvggvuggvshhkthhophdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehi
    ughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:4Q56ZLyS8IxoF7ZaWZJ2CezRIXfonxQL3eL3TBkBNjyFKaMwPtm36w>
    <xmx:4Q56ZGQm169t5s4E_7AuWwL31q15NXaJEIemqKK6cJpb0s3sniA8ZA>
    <xmx:4Q56ZObML8gGdJjV3p6Wv9Y1X5WNURsPNW5GSYjg7ioMCZ3t3VnEBg>
    <xmx:4Q56ZJK5qKq2fIg36VzLHBEZYco4CtnTuoReEyochZ-CPszyrYItKw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jun 2023 11:46:40 -0400 (EDT)
Date:   Fri, 2 Jun 2023 18:46:36 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 13/20] lockd: move lockd_start_svc() call into
 lockd_create_svc()
Message-ID: <ZHoO3GRH6h/bcRjm@shredder>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
 <163816148560.32298.15560175172815507979.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163816148560.32298.15560175172815507979.stgit@noble.brown>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 29, 2021 at 03:51:25PM +1100, NeilBrown wrote:
> lockd_start_svc() only needs to be called once, just after the svc is
> created.  If the start fails, the svc is discarded too.
> 
> It thus makes sense to call lockd_start_svc() from lockd_create_svc().
> This allows us to remove the test against nlmsvc_rqst at the start of
> lockd_start_svc() - it must always be NULL.
> 
> lockd_up() only held an extra reference on the svc until a thread was
> created - then it dropped it.  The thread - and thus the extra reference
> - will remain until kthread_stop() is called.
> Now that the thread is created in lockd_create_svc(), the extra
> reference can be dropped there.  So the 'serv' variable is no longer
> needed in lockd_up().

Hi,

I'm seeing the following memory leak [1] after unmounting a network
share. High level bisection shows that it started between v5.16 and
v5.17. Using git bisect [2] I've pinpointed it to this patch.

Can you please look into it? I can easily trigger the issue and test
patches.

Thanks

[1]
unreferenced object 0xffff888123cd4a00 (size 512): 
  comm "mount.nfs", pid 7704, jiffies 4296498183 (age 933.141s) 
  hex dump (first 32 bytes): 
    20 97 05 a1 ff ff ff ff e0 0d 06 a1 ff ff ff ff   ............... 
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N.......... 
  backtrace: 
    [<ffffffff8186012a>] kmalloc_trace+0x2a/0xe0 
    [<ffffffffa0fc02d9>] __svc_create+0x59/0xa10 [sunrpc] 
    [<ffffffffa1345db7>] lockd_up+0xa7/0x4d0 [lockd] 
    [<ffffffffa13370b9>] nlmclnt_init+0xb9/0x3d0 [lockd] 
    [<ffffffffa142555a>] nfs_start_lockd+0x2ca/0x420 [nfs] 
    [<ffffffffa142a0c7>] nfs_init_server.isra.0+0x6e7/0x11e0 [nfs] 
    [<ffffffffa142cd0f>] nfs_create_server+0x16f/0x610 [nfs] 
    [<ffffffffa18a942b>] nfs3_create_server+0x1b/0x1b0 [nfsv3] 
    [<ffffffffa1465a11>] nfs_try_get_tree+0x4d1/0x9c0 [nfs] 
    [<ffffffffa14c0fc4>] nfs_get_tree+0xa94/0x15e0 [nfs] 
    [<ffffffff81a1530d>] vfs_get_tree+0x8d/0x2e0 
    [<ffffffff81aadf0a>] path_mount+0x136a/0x1e90 
    [<ffffffff81aaf998>] __x64_sys_mount+0x298/0x320 
    [<ffffffff82e3aa58>] do_syscall_64+0x38/0x80 
    [<ffffffff8300008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd 

[2]
$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [f443e374ae131c168a065ea1748feac6b2e76613] Linux 5.17
git bisect bad f443e374ae131c168a065ea1748feac6b2e76613
# status: waiting for good commit(s), bad commit known
# good: [df0cc57e057f18e44dac8e6c18aba47ab53202f9] Linux 5.16
git bisect good df0cc57e057f18e44dac8e6c18aba47ab53202f9
# good: [22ef12195e13c5ec58320dbf99ef85059a2c0820] Merge tag 'staging-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good 22ef12195e13c5ec58320dbf99ef85059a2c0820
# bad: [51620150ca2df62f8ea472ab8962be590c957288] cifs: update internal module number
git bisect bad 51620150ca2df62f8ea472ab8962be590c957288
# good: [3fb561b1e0bf4c75bc5f4d799845b08fa5ab3853] Merge tag 'mips_5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good 3fb561b1e0bf4c75bc5f4d799845b08fa5ab3853
# good: [f56caedaf94f9ced5dbfcdb0060a3e788d2078af] Merge branch 'akpm' (patches from Andrew)
git bisect good f56caedaf94f9ced5dbfcdb0060a3e788d2078af
# bad: [cb3f09f9afe5286c0aed7a1c5cc71495de166efb] Merge tag 'hyperv-next-signed-20220114' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux
git bisect bad cb3f09f9afe5286c0aed7a1c5cc71495de166efb
# good: [87c71931633bd15e9cfd51d4a4d9cd685e8cdb55] Merge branch 'pci/driver-cleanup'
git bisect good 87c71931633bd15e9cfd51d4a4d9cd685e8cdb55
# bad: [175398a0972bc3ca1e824be324f17d8318357eba] Merge tag 'nfsd-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect bad 175398a0972bc3ca1e824be324f17d8318357eba
# good: [59d41458f143b7a20997b1e78b5c15d9d3e998c3] Merge tag 'drm-next-2022-01-14' of git://anongit.freedesktop.org/drm/drm
git bisect good 59d41458f143b7a20997b1e78b5c15d9d3e998c3
# bad: [6a2f774424bfdcc2df3e17de0cefe74a4269cad5] NFSD: Fix zero-length NFSv3 WRITEs
git bisect bad 6a2f774424bfdcc2df3e17de0cefe74a4269cad5
# bad: [6a4e2527a63620a820c4ebf3596b57176da26fb3] lockd: move svc_exit_thread() into the thread
git bisect bad 6a4e2527a63620a820c4ebf3596b57176da26fb3
# good: [2a36395fac3b72771f87c3ee4387e3a96d85a7cc] SUNRPC: use sv_lock to protect updates to sv_nrthreads.
git bisect good 2a36395fac3b72771f87c3ee4387e3a96d85a7cc
# good: [d057cfec4940ce6eeffa22b4a71dec203b06cd55] NFSD: simplify locking for network notifier.
git bisect good d057cfec4940ce6eeffa22b4a71dec203b06cd55
# good: [5a8a7ff57421b7de3ae72019938ffb5daaee36e7] lockd: simplify management of network status notifiers
git bisect good 5a8a7ff57421b7de3ae72019938ffb5daaee36e7
# bad: [b73a2972041bee70eb0cbbb25fa77828c63c916b] lockd: move lockd_start_svc() call into lockd_create_svc()
git bisect bad b73a2972041bee70eb0cbbb25fa77828c63c916b
# first bad commit: [b73a2972041bee70eb0cbbb25fa77828c63c916b] lockd: move lockd_start_svc() call into lockd_create_svc()
