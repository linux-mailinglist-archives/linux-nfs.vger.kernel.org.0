Return-Path: <linux-nfs+bounces-799-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DFC81DC7F
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 22:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08466B211B2
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA2BEAD9;
	Sun, 24 Dec 2023 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhoQfGkU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F010788;
	Sun, 24 Dec 2023 21:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CDDC433C7;
	Sun, 24 Dec 2023 21:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703453463;
	bh=V3y8H0LCCFvixptpsJ19a+YP7/R9X0uB52si6Uy778I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhoQfGkUjBTljkttuo6xzfiFBCBPrCrulCgOE4WtrxGdlND12xvTWzwlnY7yfU0Rz
	 b8sliqRHJ/VlxfQMIIHIojLaK7jLhObzgW3zWPOscmdTyOCiOEf48qEsv2Y71KVkdD
	 zV0/0us9JWfp+bSKHt1tHEHivMwMajDJb13VExpUy96ybpOXZVlkX7boiDSdtZ1BjK
	 +AfRjS0v2MQJtexT9SjkBsCIao6r3UAxqX5hdQdoC59Y6BBdW2hLLWfo2nboB7LFSb
	 /gV6Z+fPthMIMO6lAh5mBC8QEPCJ/5MRm1FoTzOvAGheXNJoJHZtmf5/FoNL7j180n
	 MgRp+AV/clsGg==
Date: Sun, 24 Dec 2023 21:30:57 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simo Sorce <simo@redhat.com>, Steve Dickson <steved@redhat.com>,
	Kevin Coffman <kwc@citi.umich.edu>, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: fix a memleak in gss_import_v2_context
Message-ID: <20231224213057.GC5962@kernel.org>
References: <20231224082035.3538560-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224082035.3538560-1-alexious@zju.edu.cn>

On Sun, Dec 24, 2023 at 04:20:33PM +0800, Zhipeng Lu wrote:
> The ctx->mech_used.data allocated by kmemdup is not freed in neither
> gss_import_v2_context nor it only caller radeon_driver_open_kms.
> Thus, this patch reform the last call of gss_import_v2_context to the
> gss_krb5_import_ctx_v2, preventing the memleak while keepping the return
> formation.
> 
> Fixes: 47d848077629 ("gss_krb5: handle new context format from gssd")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  net/sunrpc/auth_gss/gss_krb5_mech.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
> index e31cfdf7eadc..1e54bd63e3f0 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_mech.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
> @@ -398,6 +398,7 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
>  	u64 seq_send64;
>  	int keylen;
>  	u32 time32;
> +	int ret;
>  
>  	p = simple_get_bytes(p, end, &ctx->flags, sizeof(ctx->flags));
>  	if (IS_ERR(p))
> @@ -450,8 +451,14 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
>  	}
>  	ctx->mech_used.len = gss_kerberos_mech.gm_oid.len;
>  
> -	return gss_krb5_import_ctx_v2(ctx, gfp_mask);
> +	ret = gss_krb5_import_ctx_v2(ctx, gfp_mask);
> +	if (ret) {
> +		p = ERR_PTR(ret);
> +		goto out_free;
> +	};

Hi Zhipeng Lu,

I think you need to handle the non-error case here:

	return 0;

>  
> +out_free:
> +	kfree(ctx->mech_used.data);
>  out_err:
>  	return PTR_ERR(p);
>  }
> -- 
> 2.34.1
> 

