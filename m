Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E1D4E5A56
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Mar 2022 22:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiCWVGU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Mar 2022 17:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiCWVGU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Mar 2022 17:06:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E853122E;
        Wed, 23 Mar 2022 14:04:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6057F1F387;
        Wed, 23 Mar 2022 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648069488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQRFIvMYPa57E8vs5yQx5fBF8QSVW2wkNB0Ft3IVHkg=;
        b=hUPA4AfHH40LrLy7/afNuEXl3ZSmwWmLp5N8L4vWyy4uDG3LZjrrBdJIMAJMH4DsGmEquz
        UQ6MKVTtH91xo15DCiU0edkhR+MBnlWOTPAARbOWUHBVPdofhMHr2EzGNTveoALQa66KJw
        ISUr/uiq9UmAxPsZQ+SHgQlSrdE7pXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648069488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQRFIvMYPa57E8vs5yQx5fBF8QSVW2wkNB0Ft3IVHkg=;
        b=ebx4g8z+Yz2YE2VTtZLhKFXsf1MiAaeq5J9BhH2AkGiRXYd7fdpfHSDMCj/qdFlvyt30vh
        e9x5ncED9Oe8LVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B02F313302;
        Wed, 23 Mar 2022 21:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aD1FGm6LO2KobwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 23 Mar 2022 21:04:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     xkernel.wang@foxmail.com
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Xiaoke Wang" <xkernel.wang@foxmail.com>
Subject: Re: [PATCH] NFS: check the return value of mempool_alloc()
In-reply-to: <tencent_61C566F88A52C1BF198826737AAE0E471806@qq.com>
References: <tencent_61C566F88A52C1BF198826737AAE0E471806@qq.com>
Date:   Thu, 24 Mar 2022 08:04:41 +1100
Message-id: <164806948116.6096.12331736937963571485@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 23 Mar 2022, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> The check was first removed in 518662e ("NFS: fix usage of mempools.")
> as the passed GFP flags is `GFP_NOIO`.
> While now the flag is changed to `GFP_KERNEL` by 2b17d72 ("NFS: Clean
> up writeback code"), so it is better to check it.

no.  GFP_KERNEL is not that different from GFP_NOIO.

mempool_alloc() can only fail with __GFP_DIRECT_RECLAIM is not passed.

Please try to understand the code before you change it.

NeilBrown


> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  fs/nfs/write.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index eae9bf1..831fad9 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -106,8 +106,10 @@ static struct nfs_pgio_header *nfs_writehdr_alloc(void)
>  {
>  	struct nfs_pgio_header *p = mempool_alloc(nfs_wdata_mempool, GFP_KERNEL);
>  
> -	memset(p, 0, sizeof(*p));
> -	p->rw_mode = FMODE_WRITE;
> +	if (p) {
> +		memset(p, 0, sizeof(*p));
> +		p->rw_mode = FMODE_WRITE;
> +	}
>  	return p;
>  }
>  
> -- 
> 
> 
