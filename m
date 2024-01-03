Return-Path: <linux-nfs+bounces-908-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E9F823949
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 00:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1C31C249F0
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 23:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453651F92C;
	Wed,  3 Jan 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4p8LlmT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA41F926
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jan 2024 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704325104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmy5gZosHq/OVBVqCyeEEYATzkEWSXpdih2/x/4mxHU=;
	b=W4p8LlmTHM8OFOEmdGBR/EsJrEEPzBS8XXXSFjaFNjP9lolfRJ3+JzbIwSqewQuEggtIed
	rnpXoLw04Bq5fO/KkwncwPInEbmsoacXnS7LCLqZgphfrxDgy/eNjwNKEp6rvi15CSBOOU
	U+11RryrcsJSODwWGKgsOCug0xo5DO8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-nxUpHz-bMhyFOGohlOyQ6Q-1; Wed, 03 Jan 2024 18:38:23 -0500
X-MC-Unique: nxUpHz-bMhyFOGohlOyQ6Q-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bc1f6f61f8so382678b6e.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jan 2024 15:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704325102; x=1704929902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmy5gZosHq/OVBVqCyeEEYATzkEWSXpdih2/x/4mxHU=;
        b=NWfYaLkiAK1E0gFycYHXY/6djaHoFuOkrI+z20TJLt+XvKnsaof88GHEi2Vi4HQUmH
         q75WdzHgU3CIDscl6qdSBe2kAtszkJs5LGqJeg/J9cNqda/76VPa8r+4+v/Gzd88P4cW
         2UcyBJJb7Onc/wCkVgWO2AfltL7u1UZI4Gct7+3HdqoDUT026n188P/A4of9Yc/sDJL2
         4ydyuT/UmqZDGpV6DsYyBa1N1KjQjnfDLuqlB4U3MzLIKl8+KNRKmYGGxGOFmfPSy7Je
         f86tG/ho7Rb/6MfTcA49V+wy2GR+s1kC24n6RHBN7/NV8D9+38SFRnLQyGB2BtMYtVCp
         Scrw==
X-Gm-Message-State: AOJu0Yx1JT53Tmq+dRtjcePcZluJPfFQagZ1MQE8P4VzfeATIthbCBU0
	wL6dJG3712wlG47721Hki0dBDJXZRyIidL7xZy+8JTe5HVv9Nerhihjb5g5+flPpPMxYVMrxlW+
	m1+5LvNUEn/OK1DiOTS4KV6avOaqgz9GZPWs4
X-Received: by 2002:a05:6808:21a6:b0:3b9:e654:9004 with SMTP id be38-20020a05680821a600b003b9e6549004mr38648487oib.1.1704325102276;
        Wed, 03 Jan 2024 15:38:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGenYGWa61BItsXh6nhbkHV0Xd82DKpGo4o44+1Wj356G8Rdl4GaYOVDQfr+fuBATbtTANHDw==
X-Received: by 2002:a05:6808:21a6:b0:3b9:e654:9004 with SMTP id be38-20020a05680821a600b003b9e6549004mr38648479oib.1.1704325101979;
        Wed, 03 Jan 2024 15:38:21 -0800 (PST)
Received: from [172.31.1.12] ([70.109.152.76])
        by smtp.gmail.com with ESMTPSA id o2-20020a0cecc2000000b0067aab230ed9sm11283824qvq.21.2024.01.03.15.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 15:38:21 -0800 (PST)
Message-ID: <d64bce97-1362-4f73-8ae6-52dc92284861@redhat.com>
Date: Wed, 3 Jan 2024 18:38:20 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gssapi: revert commit f5b6e6fdb1e6
Content-Language: en-US
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: linux-nfs@vger.kernel.org, chuck.lever@oracle.com
References: <20231206213127.55310-1-olga.kornievskaia@gmail.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231206213127.55310-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/6/23 4:31 PM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Revert commit f5b6e6fdb1e6 "gss-api: expose gss major/minor error in
> authgss_refresh()".
> 
> Instead of modifying existing api, use rpc_gss_seccreate() which exposes
> the error values.
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.umich>
Committed... (tag: libtirpc-1-3-5-rc1

steved.
> ---
>   src/auth_gss.c       | 14 ++++++--------
>   tirpc/rpc/auth_gss.h |  2 --
>   2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/src/auth_gss.c b/src/auth_gss.c
> index 3127b92..e317664 100644
> --- a/src/auth_gss.c
> +++ b/src/auth_gss.c
> @@ -184,7 +184,6 @@ authgss_create(CLIENT *clnt, gss_name_t name, struct rpc_gss_sec *sec)
>   	AUTH			*auth, *save_auth;
>   	struct rpc_gss_data	*gd;
>   	OM_uint32		min_stat = 0;
> -	rpc_gss_options_ret_t	ret;
>   
>   	gss_log_debug("in authgss_create()");
>   
> @@ -230,12 +229,8 @@ authgss_create(CLIENT *clnt, gss_name_t name, struct rpc_gss_sec *sec)
>   	save_auth = clnt->cl_auth;
>   	clnt->cl_auth = auth;
>   
> -	memset(&ret, 0, sizeof(rpc_gss_options_ret_t));
> -	if (!authgss_refresh(auth, &ret)) {
> +	if (!authgss_refresh(auth, NULL))
>   		auth = NULL;
> -		sec->major_status = ret.major_status;
> -		sec->minor_status = ret.minor_status;
> -	}
>   	else
>   		authgss_auth_get(auth); /* Reference for caller */
>   
> @@ -624,9 +619,12 @@ _rpc_gss_refresh(AUTH *auth, rpc_gss_options_ret_t *options_ret)
>   }
>   
>   static bool_t
> -authgss_refresh(AUTH *auth, void *ret)
> +authgss_refresh(AUTH *auth, void *dummy)
>   {
> -	return _rpc_gss_refresh(auth, (rpc_gss_options_ret_t *)ret);
> +	rpc_gss_options_ret_t ret;
> +
> +	memset(&ret, 0, sizeof(ret));
> +	return _rpc_gss_refresh(auth, &ret);
>   }
>   
>   bool_t
> diff --git a/tirpc/rpc/auth_gss.h b/tirpc/rpc/auth_gss.h
> index a530d42..f2af6e9 100644
> --- a/tirpc/rpc/auth_gss.h
> +++ b/tirpc/rpc/auth_gss.h
> @@ -64,8 +64,6 @@ struct rpc_gss_sec {
>   	rpc_gss_svc_t	svc;		/* service */
>   	gss_cred_id_t	cred;		/* cred handle */
>   	u_int		req_flags;	/* req flags for init_sec_context */
> -	int		major_status;
> -	int		minor_status;
>   };
>   
>   /* Private data required for kernel implementation */


