Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AC573C336
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jun 2023 23:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjFWVsf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jun 2023 17:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjFWVsb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jun 2023 17:48:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA52B26BD;
        Fri, 23 Jun 2023 14:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA1960A38;
        Fri, 23 Jun 2023 21:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F706C433C8;
        Fri, 23 Jun 2023 21:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687556901;
        bh=YyV6B6bNatDDFo2tW2JAoKmXfyIqLGPJxf2ibpnit1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYst5Xp7ILlkRwqwQWL4jvYYvRxPM2aJb0macvvkZ4++vwx+tPHjr0dzZuUki8e2g
         zHP9VqmWZwUcjwZd6wNhKnuI7h1YmWes1WS3aQDTIePXtQPWfnXiRQXaPm9TPrQGpa
         44KOsxybvdjFy6UTSOAdqz8X593r9hkZ3Inay+Ptm+mR6ZVqK5+y1hBA0XZYDV/5TK
         3CH975FR3ieOzoR1/g3Hyp0Gs47ImHYoMARFc5aC65Qd1XSlt0IR2v+C6XJ6TECMst
         5aNUlr5Nhz51r7ffB8+XukOtJlJjFoYpZXU8EF0UhR8KYKQuDHvNZw2Z6ZjuQSbDrI
         xAivVG3cX2taA==
Date:   Fri, 23 Jun 2023 17:48:19 -0400
From:   Chuck Lever <cel@kernel.org>
To:     tavianator@tavianator.com
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/nfsd: Fix creation time serialization order
Message-ID: <ZJYTI5ws3jNhDS25@manet.1015granger.net>
References: <4154eb6503988c2096f5d30af26d06863fb5d973.1687554467.git.tavianator@tavianator.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4154eb6503988c2096f5d30af26d06863fb5d973.1687554467.git.tavianator@tavianator.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 23, 2023 at 05:09:06PM -0400, tavianator@tavianator.com wrote:
> From: Tavian Barnes <tavianator@tavianator.com>
> 
> In nfsd4_encode_fattr(), TIME_CREATE was being written out after all
> other times.  However, they should be written out in an order that
> matches the bit flags in bmval1, which in this case are
> 
>     #define FATTR4_WORD1_TIME_ACCESS        (1UL << 15)
>     #define FATTR4_WORD1_TIME_CREATE        (1UL << 18)
>     #define FATTR4_WORD1_TIME_DELTA         (1UL << 19)
>     #define FATTR4_WORD1_TIME_METADATA      (1UL << 20)
>     #define FATTR4_WORD1_TIME_MODIFY        (1UL << 21)
> 
> so TIME_CREATE should come second.
> 
> I noticed this on a FreeBSD NFSv4.2 client, which supports creation
> times.  On this client, file times were weirdly permuted.  With this
> patch applied on the server, times looked normal on the client.
> 
> Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
> Link: https://unix.stackexchange.com/q/749605/56202
> Signed-off-by: Tavian Barnes <tavianator@tavianator.com>

I'm not especially familiar with this area of the protocol, but this
looks correct at first glance. I've applied this to nfsd-fixes for
v6.5.

Out of interest, what type of filesystem does your server export?


> ---
>  fs/nfsd/nfs4xdr.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 76db2fe29624..3037c5b0623e 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3354,6 +3354,13 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  		p = xdr_encode_hyper(p, (s64)stat.atime.tv_sec);
>  		*p++ = cpu_to_be32(stat.atime.tv_nsec);
>  	}
> +	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
> +		p = xdr_reserve_space(xdr, 12);
> +		if (!p)
> +			goto out_resource;
> +		p = xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
> +		*p++ = cpu_to_be32(stat.btime.tv_nsec);
> +	}
>  	if (bmval1 & FATTR4_WORD1_TIME_DELTA) {
>  		p = xdr_reserve_space(xdr, 12);
>  		if (!p)
> @@ -3374,13 +3381,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  		p = xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
>  		*p++ = cpu_to_be32(stat.mtime.tv_nsec);
>  	}
> -	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
> -		p = xdr_reserve_space(xdr, 12);
> -		if (!p)
> -			goto out_resource;
> -		p = xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
> -		*p++ = cpu_to_be32(stat.btime.tv_nsec);
> -	}
>  	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
>  		u64 ino = stat.ino;
>  
> -- 
> 2.41.0
> 
