Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06D6F4231
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 13:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjEBLB5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 07:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjEBLB4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 07:01:56 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495364EE7
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 04:01:54 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9536df4b907so759488366b.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 May 2023 04:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683025313; x=1685617313;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4RMcwMci4s4oLz9zs2yZPKhsmNqvP/Guus+5ZfQuvs=;
        b=BsdpFpidsipgUB1BvnbwdNlRyVgbg7jWjdkeifkNKjTlT3gEIQSCVVTJYtC0n/xs2m
         +45yRgT8E7U2Tk7VuAUfsEgNSAqYNkB0dJskC1Zrp+5Y4ofpY2QqQCpb3TdS2L0iP5X9
         ptTNUiOXm7PzcWKeo2dR/3pmovZ+hbs6HDcc1E8F007lhsgfS5YbjXv+XJNesovJe/XE
         IjKgwr9QPOAESKHzJKroDCC6np7jXAh+zcVW5xazm/9aSWpdfYQOZgY+GjjuaB/sABqs
         NhF79QTKvyTuebxUl0yriiVTAKgSF7YmDmL+2nHNFlOmNidvaFvtZtdGcygbHDIzVM/m
         I6Rw==
X-Gm-Message-State: AC+VfDwxAAmsU8nmonpNuS5MOu6O470TKCJ7jLMtq8fciwzwhwTQoz81
        C4tlWRBRaCupCV4uOi++F2Xue4QtFq4=
X-Google-Smtp-Source: ACHHUZ4FHw/kKxOoadgRHYpdTyDFWaNQabV2xTDHiq7R9BXa7CLkus6ryGag4rWMm/QH8sdDNx9qOQ==
X-Received: by 2002:a17:907:7fab:b0:95f:2065:83be with SMTP id qk43-20020a1709077fab00b0095f206583bemr19280137ejc.76.1683025312551;
        Tue, 02 May 2023 04:01:52 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906074b00b0094f3c281b34sm15882752ejb.196.2023.05.02.04.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:01:52 -0700 (PDT)
Message-ID: <3e34a2dc-7d72-b719-248f-e78361db8a5b@kernel.org>
Date:   Tue, 2 May 2023 13:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept
 methods
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
        Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
 <167319546521.7490.43383592461162363.stgit@bazille.1015granger.net>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <167319546521.7490.43383592461162363.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 08. 01. 23, 17:31, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> To navigate around the space that svcauth_gss_accept() reserves
> for the RPC payload body length and sequence number fields,
> svcauth_gss_release() does a little dance with the reply's
> accept_stat, moving the accept_stat value in the response buffer
> down by two words.
> 
> Instead, let's have the ->accept() methods each set the proper
> final location of the accept_stat to avoid having to move
> things.

Hi,

I bisected to this (4bcf0343e8) as it breaks nfs3-only servers in 6.3. 
I.e. /etc/nfs.conf containing:
[nfsd]
  vers4=no

The client sees:
   mount("10.0.2.15:/tmp", "/mnt", "nfs", 0, 
"vers=4.2,addr=10.0.2.15,clientad"...) = -1 EIO (Input/output error)
   write(2, "mount.nfs: mount system call fai"..., 45
   mount.nfs: mount system call failed for /mnt

And the kernel says:
   nfs4_discover_server_trunking unhandled error -5. Exiting with error EIO

I reported in downstream as:
https://bugzilla.suse.com/show_bug.cgi?id=1210995

It cannot be reverted cleanly on the top of 6.3.

Any ideas?

Thanks.

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/linux/sunrpc/svc.h        |   19 +++++++++++++++++++
>   net/sunrpc/auth_gss/svcauth_gss.c |   21 ++++++++++-----------
>   net/sunrpc/svc.c                  |    2 --
>   net/sunrpc/svcauth_unix.c         |    6 ++++++
>   4 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index f40a90ca5de6..392d2d2620fa 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -544,4 +544,23 @@ static inline void svcxdr_set_auth_slack(struct svc_rqst *rqstp, int slack)
>   	WARN_ON(xdr->p > xdr->end);
>   }
>   
> +/**
> + * svcxdr_set_accept_stat - Reserve space for the accept_stat field
> + * @rqstp: RPC transaction context
> + *
> + * Return values:
> + *   %true: Success
> + *   %false: No response buffer space was available
> + */
> +static inline bool svcxdr_set_accept_stat(struct svc_rqst *rqstp)
> +{
> +	struct xdr_stream *xdr = &rqstp->rq_res_stream;
> +
> +	rqstp->rq_accept_statp = xdr_reserve_space(xdr, XDR_UNIT);
> +	if (unlikely(!rqstp->rq_accept_statp))
> +		return false;
> +	*rqstp->rq_accept_statp = rpc_success;
> +	return true;
> +}
> +
>   #endif /* SUNRPC_SVC_H */
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
> index 560fb8a2803d..333873abb7d9 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -1220,7 +1220,7 @@ svcauth_gss_legacy_init(struct svc_rqst *rqstp,
>   	if (!svcauth_gss_proc_init_verf(sn->rsc_cache, rqstp, &rsip->out_handle,
>   					&rsip->major_status, GSS_SEQ_WIN))
>   		goto out;
> -	if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
> +	if (!svcxdr_set_accept_stat(rqstp))
>   		goto out;
>   	if (!svcxdr_encode_gss_init_res(&rqstp->rq_res_stream, &rsip->out_handle,
>   					&rsip->out_token, rsip->major_status,
> @@ -1348,7 +1348,7 @@ static int svcauth_gss_proxy_init(struct svc_rqst *rqstp,
>   	if (!svcauth_gss_proc_init_verf(sn->rsc_cache, rqstp, &cli_handle,
>   					&ud.major_status, GSS_SEQ_WIN))
>   		goto out;
> -	if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
> +	if (!svcxdr_set_accept_stat(rqstp))
>   		goto out;
>   	if (!svcxdr_encode_gss_init_res(&rqstp->rq_res_stream, &cli_handle,
>   					&ud.out_token, ud.major_status,
> @@ -1640,16 +1640,18 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
>   	case RPC_GSS_PROC_DESTROY:
>   		if (!svcauth_gss_encode_verf(rqstp, rsci->mechctx, gc->gc_seq))
>   			goto auth_err;
> +		if (!svcxdr_set_accept_stat(rqstp))
> +			goto auth_err;
>   		/* Delete the entry from the cache_list and call cache_put */
>   		sunrpc_cache_unhash(sn->rsc_cache, &rsci->h);
> -		if (xdr_stream_encode_u32(&rqstp->rq_res_stream, RPC_SUCCESS) < 0)
> -			goto auth_err;
>   		goto complete;
>   	case RPC_GSS_PROC_DATA:
>   		rqstp->rq_auth_stat = rpcsec_gsserr_ctxproblem;
>   		svcdata->verf_start = xdr_reserve_space(&rqstp->rq_res_stream, 0);
>   		if (!svcauth_gss_encode_verf(rqstp, rsci->mechctx, gc->gc_seq))
>   			goto auth_err;
> +		if (!svcxdr_set_accept_stat(rqstp))
> +			goto auth_err;
>   		rqstp->rq_cred = rsci->cred;
>   		get_group_info(rsci->cred.cr_group_info);
>   		rqstp->rq_auth_stat = rpc_autherr_badcred;
> @@ -1706,7 +1708,6 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
>   static __be32 *
>   svcauth_gss_prepare_to_wrap(struct svc_rqst *rqstp, struct gss_svc_data *gsd)
>   {
> -	struct xdr_buf *resbuf = &rqstp->rq_res;
>   	__be32 *p;
>   	u32 verf_len;
>   
> @@ -1721,13 +1722,11 @@ svcauth_gss_prepare_to_wrap(struct svc_rqst *rqstp, struct gss_svc_data *gsd)
>   	p += 1;
>   	verf_len = ntohl(*p++);
>   	p += XDR_QUADLEN(verf_len);
> -	/* move accept_stat to right place: */
> -	memcpy(p, p + 2, 4);
> -	/* Also don't wrap if the accept stat is nonzero: */
> -	if (*p != rpc_success) {
> -		resbuf->head[0].iov_len -= 2 * 4;
> +
> +	/* Also don't wrap if the accept_stat is nonzero: */
> +	if (*rqstp->rq_accept_statp != rpc_success)
>   		return NULL;
> -	}
> +
>   	p++;
>   	return p;
>   }
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 3c194e6f8f5e..c2ed8b06fadb 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1314,8 +1314,6 @@ svc_process_common(struct svc_rqst *rqstp)
>   	trace_svc_process(rqstp, progp->pg_name);
>   
>   	aoffset = xdr_stream_pos(xdr);
> -	rqstp->rq_accept_statp = xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT);
> -	*rqstp->rq_accept_statp = rpc_success;
>   
>   	/* un-reserve some of the out-queue now that we have a
>   	 * better idea of reply size
> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index b101700d155c..62dfc8cdf8c5 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -775,6 +775,8 @@ svcauth_null_accept(struct svc_rqst *rqstp)
>   	if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
>   					  RPC_AUTH_NULL, NULL, 0) < 0)
>   		return SVC_CLOSE;
> +	if (!svcxdr_set_accept_stat(rqstp))
> +		return SVC_CLOSE;
>   
>   	rqstp->rq_cred.cr_flavor = RPC_AUTH_NULL;
>   	return SVC_OK;
> @@ -866,6 +868,8 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
>   						  RPC_AUTH_NULL, NULL, 0) < 0)
>   			return SVC_CLOSE;
>   	}
> +	if (!svcxdr_set_accept_stat(rqstp))
> +		return SVC_CLOSE;
>   
>   	rqstp->rq_cred.cr_flavor = RPC_AUTH_TLS;
>   	return SVC_OK;
> @@ -960,6 +964,8 @@ svcauth_unix_accept(struct svc_rqst *rqstp)
>   	if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
>   					  RPC_AUTH_NULL, NULL, 0) < 0)
>   		return SVC_CLOSE;
> +	if (!svcxdr_set_accept_stat(rqstp))
> +		return SVC_CLOSE;
>   
>   	rqstp->rq_cred.cr_flavor = RPC_AUTH_UNIX;
>   	return SVC_OK;
> 
> 
> 

-- 
js
suse labs

