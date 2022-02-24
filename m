Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A784C2E0F
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 15:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiBXOQc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 09:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiBXOQ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 09:16:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 898A329A555
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 06:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645712157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2iMQBL7n6jOsKk0gBixWydXv+tyxVvEIlZv4EN73YSE=;
        b=cexSPdZJtZOWMAafkFN3RkZ84qkgKAZ7ad3ASLNP1paQf/swIvYI97T+j5l4WUh52lJJ8H
        3slnR+k2lm9LH9ZjedaVB3QAakDAtZrg0vofSeEgYresg2CHcxq2Hy6YoPWz3Zy7SN7PhN
        Sh9cGP3prDSwEB85CdP4rZeQwnN+RhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-74AtA2ubMzGkNR_JhH46fQ-1; Thu, 24 Feb 2022 09:15:56 -0500
X-MC-Unique: 74AtA2ubMzGkNR_JhH46fQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 733E81854E26;
        Thu, 24 Feb 2022 14:15:55 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 394BF5C3E0;
        Thu, 24 Feb 2022 14:15:55 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 04/21] NFS: Calculate page offsets algorithmically
Date:   Thu, 24 Feb 2022 09:15:54 -0500
Message-ID: <EA90387C-B33D-4C81-BB80-8C0AB3251E5E@redhat.com>
In-Reply-To: <20220223211305.296816-5-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 23 Feb 2022, at 16:12, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Instead of relying on counting the page offsets as we walk through the
> page cache, switch to calculating them algorithmically.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 8f17aaebcd77..f2258e926df2 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -248,17 +248,20 @@ static const char *nfs_readdir_copy_name(const 
> char *name, unsigned int len)
>  	return ret;
>  }
>
> +static size_t nfs_readdir_array_maxentries(void)
> +{
> +	return (PAGE_SIZE - sizeof(struct nfs_cache_array)) /
> +	       sizeof(struct nfs_cache_array_entry);
> +}
> +

Why the choice to use a runtime function call rather than the compiler's
calculation?  I suspect that the end result is the same, as the compiler
will optimize it away, but I'm curious if there's a good reason for 
this.

Ben

