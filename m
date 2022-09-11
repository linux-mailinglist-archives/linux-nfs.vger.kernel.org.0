Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C615B4DA0
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Sep 2022 12:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiIKKs1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Sep 2022 06:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiIKKsI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Sep 2022 06:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1693D5A3
        for <linux-nfs@vger.kernel.org>; Sun, 11 Sep 2022 03:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662893283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eodlC31cHOc8M28DmKDb4+RU31tvFzRwrPe+AFUsTxs=;
        b=c3R0r5NBx4K2exLGbKMIXwW8bp+YfRPAmsND9WXcqpj2wWXXy3Bx++iHsuQjI533jyDeS0
        GRQKG/2uPsXb1DhN9W+r0ojcd0U6pdcj9TnHoIrAmOVPYhCkjQLYYbYNxCsPsE/UcXEG55
        m2tcnVO1uge4ew81SRfYhr2IR166FeQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-yfn86ZXJPZWHcu0yCWdiXw-1; Sun, 11 Sep 2022 06:47:59 -0400
X-MC-Unique: yfn86ZXJPZWHcu0yCWdiXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CD47801231;
        Sun, 11 Sep 2022 10:47:59 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C232C15BBA;
        Sun, 11 Sep 2022 10:47:58 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Olga Kornievskaia" <aglo@umich.edu>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Chuck Lever III" <chuck.lever@oracle.com>
Subject: Re: Is this nfsd kernel oops known?
Date:   Sun, 11 Sep 2022 06:47:56 -0400
Message-ID: <D926876C-F932-40BA-B029-CF6AFC736A0B@redhat.com>
In-Reply-To: <Yxz+GhK7nWKcBLcI@ZenIV>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com> <Yxz+GhK7nWKcBLcI@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10 Sep 2022, at 17:14, Al Viro wrote:

> similar to one that used to be in copy_page_to_iter().  Could you try
> the following:

Yes, this fixes up generic/551.  No crash or corruption.  I'll send it
through a full run of xfstests as well.

Ben

>
> nfsd_splice_actor(): handle compound pages
>
> pipe_buffer might refer to a compound page (and contain more than a 
> PAGE_SIZE
> worth of data).  Theoretically it had been possible since way back, 
> but
> nfsd_splice_actor() hadn't run into that until copy_page_to_iter() 
> change.
> Fortunately, the only thing that changes for compound pages is that we
> need to stuff each relevant subpage in and convert the offset into 
> offset
> in the first subpage.
>
> Hopefully-fixes: f0f6b614f83d "copy_page_to_iter(): don't split 
> high-order page in case of ITER_PIPE"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 9f486b788ed0..b16aed158ba6 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -846,10 +846,14 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, 
> struct pipe_buffer *buf,
>  		  struct splice_desc *sd)
>  {
>  	struct svc_rqst *rqstp = sd->u.data;
> -
> -	svc_rqst_replace_page(rqstp, buf->page);
> -	if (rqstp->rq_res.page_len == 0)
> -		rqstp->rq_res.page_base = buf->offset;
> +	struct page *page = buf->page;	// may be a compound one
> +	unsigned offset = buf->offset;
> +
> +	page += offset / PAGE_SIZE;
> +	for (int i = sd->len; i > 0; i -= PAGE_SIZE)
> +		svc_rqst_replace_page(rqstp, page++);
> +	if (rqstp->rq_res.page_len == 0)	// first call
> +		rqstp->rq_res.page_base = offset % PAGE_SIZE;
>  	rqstp->rq_res.page_len += sd->len;
>  	return sd->len;
>  }

