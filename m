Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE2F4F2E45
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Apr 2022 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiDEJes (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Apr 2022 05:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343845AbiDEJOl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Apr 2022 05:14:41 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558A433AC
        for <linux-nfs@vger.kernel.org>; Tue,  5 Apr 2022 02:00:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:38ab:c2b8:b3aa:7514])
        by andre.telenet-ops.be with bizsmtp
        id Ex0j270041peDqJ01x0jAA; Tue, 05 Apr 2022 11:00:43 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nbf3K-008QxV-RE; Tue, 05 Apr 2022 11:00:42 +0200
Date:   Tue, 5 Apr 2022 11:00:42 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     trondmy@kernel.org
cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Replace readdir's use of xxhash() with hash_64()
In-Reply-To: <20220331033023.718688-1-trondmy@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2204051056580.2010216@ramsan.of.borg>
References: <20220331033023.718688-1-trondmy@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

 	Hi Trond,

On Wed, 30 Mar 2022, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Both xxhash() and hash_64() appear to give similarly low collision
> rates with a standard linearly increasing readdir offset. They both give
> similarly higher collision rates when applied to ext4's offsets.
>
> So switch to using the standard hash_64().
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Thanks for your patch!

> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -4,10 +4,6 @@ config NFS_FS
> 	depends on INET && FILE_LOCKING && MULTIUSER
> 	select LOCKD
> 	select SUNRPC
> -	select CRYPTO

I'm extremely grateful for this part! ;-)

While updating shmobile_defconfig, I was wondering why I was suddenly
asked about all those crypto drivers...

> -	select CRYPTO_HASH
> -	select XXHASH
> -	select CRYPTO_XXHASH
> 	select NFS_ACL_SUPPORT if NFS_V3_ACL
> 	help
> 	  Choose Y here if you want to access files residing on other

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
