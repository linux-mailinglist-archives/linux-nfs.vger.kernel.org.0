Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C5453F32B
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 03:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiFGBDY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 21:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiFGBDY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 21:03:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71F754BC8
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 18:03:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70F4F1F995;
        Tue,  7 Jun 2022 01:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654563801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuSfCY0coUP9lte8BijNwvB0umn0kpaXeJN1kvIRUQw=;
        b=15PTDh7V5bqH0ev9PMyUJ6KI4dLMHACTQaAWGMsy6NboajTbXK+LjJVEbOz/JuzOIHXZjz
        QJTEp4e6gjfRqUuTwQ98ptzgq8T+0/VFy+BeEF1vNiACX4UCDsp8D8bSgEjb/H7gdOs79W
        bNRNQljioUkGUXFi+3g/poKKrBnKK9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654563801;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuSfCY0coUP9lte8BijNwvB0umn0kpaXeJN1kvIRUQw=;
        b=L9lNd+DHU2kXKpedkq6V1wpgLoV5vqaMkI6P8Df5TtBM5SXNuTIrbNbESmZc8IYHqc6bZU
        8TMod2K/rY6CizCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 938F713A5F;
        Tue,  7 Jun 2022 01:03:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0vxpE9ijnmIHFQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Jun 2022 01:03:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 2/5] SUNRPC: Optimize xdr_reserve_space()
In-reply-to: <165445911199.1664.12318094116152634589.stgit@bazille.1015granger.net>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>,
 <165445911199.1664.12318094116152634589.stgit@bazille.1015granger.net>
Date:   Tue, 07 Jun 2022 11:03:16 +1000
Message-id: <165456379661.22243.4266686429763691053@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 06 Jun 2022, Chuck Lever wrote:
> The xdr_get_next_encode_buffer() function is called infrequently.
> On a typical build/test workload, it's called about 1 time in 400
> calls to xdr_reserve_space() (measured on NFSD).
> 
> Force the compiler to remove it from xdr_reserve_space(), which is
> a hot path. This change reduces the size of xdr_reserve_space() from
> 10 cache lines to 4 on my test system.

Does this really help at all?  Are the instructions that are executed in
the common case distributed over those 10 cache line, or are they all in
the first 4?

I would have thought the "unlikely" in xdr_reserve_space() would have
pushed all the code from xdr_get_next_encode_buffer() to the end of the
function leaving the remainder in a small contiguous chunk.

NeilBrown


> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xdr.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index b57cf9df4de8..08a85375b311 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -945,8 +945,13 @@ inline void xdr_commit_encode(struct xdr_stream *xdr)
>  }
>  EXPORT_SYMBOL_GPL(xdr_commit_encode);
>  
> -static __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
> -		size_t nbytes)
> +/*
> + * The buffer space to be reserved crosses the boundary between
> + * xdr->buf->head and xdr->buf->pages, or between two pages
> + * in xdr->buf->pages.
> + */
> +static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
> +						   size_t nbytes)
>  {
>  	__be32 *p;
>  	int space_left;
> 
> 
> 
