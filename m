Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78FC63A90A
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Nov 2022 14:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiK1NL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Nov 2022 08:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiK1NLf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Nov 2022 08:11:35 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4CFAC6
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 05:11:32 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s4so6570639qtx.6
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+A0+PhVNRh1EHZKtQmwuRNhwd7HEUNg/hhkAPd8z9Y=;
        b=RVyzKLmDRcH1glPPZwE/HMNkKq405jO/C90MLBXUuexjG8XUs4MW/S7HviMUerHTNE
         lgStqxHw072GnoTGPep5RxuuCA8M8YGHz5JvYOuiaSokWeC//HffCxreGqkn3aiCW1dn
         q7AvyHDuyjT2OPTCMUnLM2TPu4k6Wo4UolqhOAnm9fMXKdO8+HavZUCiqssd6NE97MoR
         GxNT79DCAKW+UzcSaSO6SGoP7E28sWMUTvCyks1w1ayz7lOoLmobg4HHtzB3zCIed1cS
         w+hfq6vzEi+PrcKZ7UhyQD6JMREgyz+umuTyNBLBbJqSCSot1GiCeuUBv1iJS/AcybBT
         sQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j+A0+PhVNRh1EHZKtQmwuRNhwd7HEUNg/hhkAPd8z9Y=;
        b=E0+J1It4xDWAGBHNTGSO4WPwCWrM64qBoMG+ogM94mcz+elQpBINkqLiIroI8Gf4Qd
         f7ekDEFd7FdreEh2YO4CZdYWDSJPaXOZkzsqwNrnHBof/VSNwvaEAnfu3iofM7CodXgK
         8dsI4xxkW0PSfpbhq4O5hcd5yqV8rgqdxfFg/P50VKE+Uj7uNOxH7pLR8BVZR2a0OD8+
         xUc0XqufrXKp0wya5IAoGaHmBOyIDaXZfqMTbcPO2imVlJCTlb8PXIP3LM4yRaCaWkW0
         Aqvcb06UpxCydhBNcgT4rWF7I3nu1jzOacUcs/gIKjVLWo3LbmkuL/O2uQINUE/t7TT7
         IcZg==
X-Gm-Message-State: ANoB5plJw2Uz2j+cb12vLn38Bd1UOmmrB2iX3hVDSbHsP/wuQBn2YewB
        cW0FIWC9Quu624sNj9jgifFpNoEnlQ5xKsxL
X-Google-Smtp-Source: AA0mqf663DBxdmS3tkRmYmrwTbUtfi3vFPIa+7hYGYSkj/sWIES0G2AWkcu8L37B3yqwhechp79Tng==
X-Received: by 2002:a05:622a:1e99:b0:3a6:6b00:f30c with SMTP id bz25-20020a05622a1e9900b003a66b00f30cmr14792908qtb.333.1669641091448;
        Mon, 28 Nov 2022 05:11:31 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id ay7-20020a05620a178700b006fb0e638f12sm8372206qkb.4.2022.11.28.05.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:11:29 -0800 (PST)
Message-ID: <3e33c1ba057d39f145bb935b6f92f17dc9cbd207.camel@poochiereds.net>
Subject: Re: [PATCH 1/4] SUNRPC: Don't leak netobj memory when
 gss_read_proxy_verf() fails
From:   Jeff Layton <jlayton@poochiereds.net>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 28 Nov 2022 08:11:28 -0500
In-Reply-To: <166949611830.106845.15345645610329421030.stgit@klimt.1015granger.net>
References: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
         <166949611830.106845.15345645610329421030.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2022-11-26 at 15:55 -0500, Chuck Lever wrote:
> Fixes: 030d794bf498 ("SUNRPC: Use gssproxy upcall for server RPCGSS authe=
ntication.")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: <stable@vger.kernel.org>
> ---
>  net/sunrpc/auth_gss/svcauth_gss.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
> index bcd74dddbe2d..9a5db285d4ae 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -1162,18 +1162,23 @@ static int gss_read_proxy_verf(struct svc_rqst *r=
qstp,
>  		return res;
> =20
>  	inlen =3D svc_getnl(argv);
> -	if (inlen > (argv->iov_len + rqstp->rq_arg.page_len))
> +	if (inlen > (argv->iov_len + rqstp->rq_arg.page_len)) {
> +		kfree(in_handle->data);

I wish this were more obvious in this code. It's not at all evident to
the casual reader that gss_read_common_verf calls dup_netobj here and
that you need to clean up after it. At a bare minimum, we ought to have
a comment to that effect over gss_read_common_verf. While you're in
there, that function is also pretty big to be marked static inline. Can
you change that too? Ditto for gss_read_verf.


>  		return SVC_DENIED;
> +	}
> =20
>  	pages =3D DIV_ROUND_UP(inlen, PAGE_SIZE);
>  	in_token->pages =3D kcalloc(pages, sizeof(struct page *), GFP_KERNEL);
> -	if (!in_token->pages)
> +	if (!in_token->pages) {
> +		kfree(in_handle->data);
>  		return SVC_DENIED;
> +	}
>  	in_token->page_base =3D 0;
>  	in_token->page_len =3D inlen;
>  	for (i =3D 0; i < pages; i++) {
>  		in_token->pages[i] =3D alloc_page(GFP_KERNEL);
>  		if (!in_token->pages[i]) {
> +			kfree(in_handle->data);
>  			gss_free_in_token_pages(in_token);
>  			return SVC_DENIED;
>  		}
>=20
>=20

--=20
Jeff Layton <jlayton@poochiereds.net>
