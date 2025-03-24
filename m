Return-Path: <linux-nfs+bounces-10778-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51843A6E450
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 21:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A6E166466
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 20:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEA619E99A;
	Mon, 24 Mar 2025 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVwSAesU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1741A23A6
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848020; cv=none; b=JHcvE5oEcnEBbH46IkJ9f+t39ikuZtQv0+kVyxc5oS4i701M02psdkZTuKs+q3vtyPYCETdAJB28/kQROua5ATaLhHPbcY7H1hgWLtqTJZyJSZjG2ICCMOTRTwoeZ09LPwN4/QUxmTFs2M+5Yd7XrRGZf28xDjhGtNCND9s+DqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848020; c=relaxed/simple;
	bh=MxUgLv8xDyoLeP+OHM3LfLST/tRa1m/zWy834dn6zWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ybpp/pc4sNt5cocaue4eRAuUw+K8q55FpPykzMGN/OiBq4xb/6JOl2/Cf4oSnTTVIeFinjt+2TTDw6nXJ7J56Ag7Z8IXcDIF8vVTB8TD2jZzBcqC58xhYnF77FZ6+g4/lgDTDxt1NQMzKRbgzCjIpUf0ZX8g9kUbNaPsqhRVDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVwSAesU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742848017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg4I1vfF7yuPbFidJ7dTCuV+pokeQW+LeMy2yDw7L9w=;
	b=bVwSAesUKFS93nJSmZlXLimvGIp4l4/zovFqremcjG3Ydis0o5y52t4j2qHXBqJjDF5qg4
	WwoYrCr4UFjSWMBNSZf0XGcEugERa9oqofdhWxBgRvaqEV3EeX7f6cuxfJUIiIEoxz1oYg
	yOl1/vehe6KNdzBjeUTLnqKhjembfuI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-FqPxYrQqOZW6GazJgeQc3A-1; Mon, 24 Mar 2025 16:26:56 -0400
X-MC-Unique: FqPxYrQqOZW6GazJgeQc3A-1
X-Mimecast-MFC-AGG-ID: FqPxYrQqOZW6GazJgeQc3A_1742848015
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8ea277063so105469656d6.1
        for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 13:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742848015; x=1743452815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg4I1vfF7yuPbFidJ7dTCuV+pokeQW+LeMy2yDw7L9w=;
        b=BArN23jADik0621irF4S0ViOV7QgPYXLHqWsCpICieBCK1nDhleVNDgN1FH9RF05iG
         T7P6BS+uKqHlU1E8beUrKC6GfIQBXSE9ffEuZseF6iVOi5GPdfi4RmbcTfPY6yAnRban
         JoQXrdftrWf/aAXF/t8+CpA2v2P+JEbVwCSv56SeCwbyEVYVyfjkXfle0XTYgruyuGTy
         DlQMhWBlMSaxuTR8Kg/q2wmVnL8cHoc1byYoMejEg157KVxydemQAn4k/N0esmY0GGi1
         XEHHhiFx+Ul2P9uVwGBXef2JMZX5EORu7SX9uBoNDnR5lJu+yStX5pGmHcbPmlBSgNCN
         449w==
X-Gm-Message-State: AOJu0YwzYj4ho/ylxdRjvC9XyFF0zc9EACjfHyZR//kJU+85dBrUBj85
	9bt9rsThvDDs+rEjDZZNebrKT3Gonw6Pw5A2SIuLAlL5u13gXx6lbl/Dsyplt+zzUSl6e2bgSV9
	wQlDHPv2zeQTNRnTuksFzARjyZGcRgqCm1J9M9/fi/5gJxYhyKXa0ShlAIg==
X-Gm-Gg: ASbGncvoVUuFn5wy8eIthwYL3PKrKwJ3O2sS1OMvMy9ANSaCX/KQapO7PUU3TrlCKL8
	RIB6PDSKZ1YK1qWr4LJaXWB8sw/3o6IGSbNpPnJmpacquLgMMLY8RT5hQi/Qc5HhrPnsNfrCWxA
	o6g4RECsMAkkKWBz9x+gMsGWvKQP31u7ppzvdvcEOZUU0qToSm+EBsiHemjShO7NK0x2WZaXVic
	K07NeM6Y2A8LiSS4xrMfQL9iNv8fW+mNq72uul++d9L3q5NWCU1/XBS88phfS4vhNHgaRNXEDn/
	ISD1F3AnwxrcS+Q=
X-Received: by 2002:a05:6214:258c:b0:6e8:e828:8215 with SMTP id 6a1803df08f44-6eb3f32a5f3mr172217376d6.30.1742848015476;
        Mon, 24 Mar 2025 13:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmiGytyLTSWoGusaK3XEkcgUIVVZ6m9GVasoTPMPu5c4XIyoTBm0Ug4kPN1bz/3JCXmK3VVg==
X-Received: by 2002:a05:6214:258c:b0:6e8:e828:8215 with SMTP id 6a1803df08f44-6eb3f32a5f3mr172217126d6.30.1742848014972;
        Mon, 24 Mar 2025 13:26:54 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.244.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efdc416sm48002836d6.94.2025.03.24.13.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 13:26:54 -0700 (PDT)
Message-ID: <f1ecba40-049e-47a0-8ebc-4b73bb48e172@redhat.com>
Date: Mon, 24 Mar 2025 16:26:53 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfs-utils: gssd: do not use krb5_cc_initialize
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250225214607.20449-1-okorniev@redhat.com>
 <20250225214607.20449-3-okorniev@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250225214607.20449-3-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/25/25 4:46 PM, Olga Kornievskaia wrote:
> When gssd refreshes machine credentials, it uses the
> krb5_get_init_creds_keytab() and then to save the received credentials
> in a ticket cache, it proceeds to initialize the credential cache via
> a krb5_cc_initialize() before storing the received credentials into it.
> 
> krb5_cc_initialize() is not concurrency safe. two gssd upcalls by
> uid=0, one for krb5i auth flavor and another for krb5p, would enter
> into krb5_cc_initialize() and one of them would fail, leading to
> an upcall failure and NFS operation error.
> 
> Instead it was proposed that gssd changes its design to do what
> kinit does and forgo the use of krb5_cc_initialize and instead setup
> the output cache via krb5_get_init_creds_opt_set_out_cache() prior
> to calling krb5_get_init_creds_keytab() which would then store
> credentials automatically.
> 
> https://mailman.mit.edu/pipermail/krbdev/2025-February/013708.html
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Committed... (tag: nfs-utils-2-8-3-rc8)

steved.
> ---
>   utils/gssd/krb5_util.c | 103 ++++++++++++++++++++---------------------
>   1 file changed, 50 insertions(+), 53 deletions(-)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 201585ed..560e8be1 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -168,7 +168,8 @@ static int select_krb5_ccache(const struct dirent *d);
>   static int gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
>   		const char **cctype, struct dirent **d);
>   static int gssd_get_single_krb5_cred(krb5_context context,
> -		krb5_keytab kt, struct gssd_k5_kt_princ *ple, int force_renew);
> +		krb5_keytab kt, struct gssd_k5_kt_princ *ple, int force_renew,
> +		krb5_ccache ccache);
>   static int query_krb5_ccache(const char* cred_cache, char **ret_princname,
>   		char **ret_realm);
>   
> @@ -395,16 +396,14 @@ static int
>   gssd_get_single_krb5_cred(krb5_context context,
>   			  krb5_keytab kt,
>   			  struct gssd_k5_kt_princ *ple,
> -			  int force_renew)
> +			  int force_renew,
> +			  krb5_ccache ccache)
>   {
>   	krb5_get_init_creds_opt *opts = NULL;
>   	krb5_creds my_creds;
> -	krb5_ccache ccache = NULL;
>   	char kt_name[BUFSIZ];
> -	char cc_name[BUFSIZ];
>   	int code;
>   	time_t now = time(0);
> -	char *cache_type;
>   	char *pname = NULL;
>   	char *k5err = NULL;
>   	int nocache = 0;
> @@ -457,6 +456,14 @@ gssd_get_single_krb5_cred(krb5_context context,
>   	krb5_get_init_creds_opt_set_tkt_life(opts, 5*60);
>   #endif
>   
> +	if ((code = krb5_get_init_creds_opt_set_out_ccache(context, opts,
> +							   ccache))) {
> +		k5err = gssd_k5_err_msg(context, code);
> +		printerr(1, "WARNING: %s while initializing ccache for "
> +			 "principal '%s' using keytab '%s'\n", k5err,
> +			 pname ? pname : "<unparsable>", kt_name);
> +		goto out;
> +	}
>   	if ((code = krb5_get_init_creds_keytab(context, &my_creds, ple->princ,
>   					       kt, 0, NULL, opts))) {
>   		k5err = gssd_k5_err_msg(context, code);
> @@ -466,61 +473,18 @@ gssd_get_single_krb5_cred(krb5_context context,
>   		goto out;
>   	}
>   
> -	/*
> -	 * Initialize cache file which we're going to be using
> -	 */
> -
>   	pthread_mutex_lock(&ple_lock);
> -	if (use_memcache)
> -	    cache_type = "MEMORY";
> -	else
> -	    cache_type = "FILE";
> -	snprintf(cc_name, sizeof(cc_name), "%s:%s/%s%s_%s",
> -		cache_type,
> -		ccachesearch[0], GSSD_DEFAULT_CRED_PREFIX,
> -		GSSD_DEFAULT_MACHINE_CRED_SUFFIX, ple->realm);
>   	ple->endtime = my_creds.times.endtime;
> -	if (ple->ccname == NULL || strcmp(ple->ccname, cc_name) != 0) {
> -		free(ple->ccname);
> -		ple->ccname = strdup(cc_name);
> -		if (ple->ccname == NULL) {
> -			printerr(0, "ERROR: no storage to duplicate credentials "
> -				    "cache name '%s'\n", cc_name);
> -			code = ENOMEM;
> -			pthread_mutex_unlock(&ple_lock);
> -			goto out;
> -		}
> -	}
>   	pthread_mutex_unlock(&ple_lock);
> -	if ((code = krb5_cc_resolve(context, cc_name, &ccache))) {
> -		k5err = gssd_k5_err_msg(context, code);
> -		printerr(0, "ERROR: %s while opening credential cache '%s'\n",
> -			 k5err, cc_name);
> -		goto out;
> -	}
> -	if ((code = krb5_cc_initialize(context, ccache, ple->princ))) {
> -		k5err = gssd_k5_err_msg(context, code);
> -		printerr(0, "ERROR: %s while initializing credential "
> -			 "cache '%s'\n", k5err, cc_name);
> -		goto out;
> -	}
> -	if ((code = krb5_cc_store_cred(context, ccache, &my_creds))) {
> -		k5err = gssd_k5_err_msg(context, code);
> -		printerr(0, "ERROR: %s while storing credentials in '%s'\n",
> -			 k5err, cc_name);
> -		goto out;
> -	}
>   
>   	code = 0;
> -	printerr(2, "%s(0x%lx): principal '%s' ccache:'%s'\n",
> -		__func__, tid, pname, cc_name);
> +	printerr(2, "%s(0x%lx): principal '%s' ccache:'%s'\n",
> +		__func__, tid, pname, ple->ccname);
>     out:
>   	if (opts)
>   		krb5_get_init_creds_opt_free(context, opts);
>   	if (pname)
>   		k5_free_unparsed_name(context, pname);
> -	if (ccache)
> -		krb5_cc_close(context, ccache);
>   	krb5_free_cred_contents(context, &my_creds);
>   	free(k5err);
>   	return (code);
> @@ -1147,10 +1111,12 @@ gssd_refresh_krb5_machine_credential_internal(char *hostname,
>   {
>   	krb5_error_code code = 0;
>   	krb5_context context;
> -	krb5_keytab kt = NULL;;
> +	krb5_keytab kt = NULL;
> +	krb5_ccache ccache = NULL;
>   	int retval = 0;
> -	char *k5err = NULL;
> +	char *k5err = NULL, *cache_type;
>   	const char *svcnames[] = { "$", "root", "nfs", "host", NULL };
> +	char cc_name[BUFSIZ];
>   
>   	/*
>   	 * If a specific service name was specified, use it.
> @@ -1209,7 +1175,38 @@ gssd_refresh_krb5_machine_credential_internal(char *hostname,
>   			goto out_free_kt;
>   		}
>   	}
> -	retval = gssd_get_single_krb5_cred(context, kt, ple, force_renew);
> +
> +	if (use_memcache)
> +		cache_type = "MEMORY";
> +	else
> +		cache_type = "FILE";
> +	snprintf(cc_name, sizeof(cc_name), "%s:%s/%s%s_%s",
> +		 cache_type,
> +		 ccachesearch[0], GSSD_DEFAULT_CRED_PREFIX,
> +		 GSSD_DEFAULT_MACHINE_CRED_SUFFIX, ple->realm);
> +
> +	pthread_mutex_lock(&ple_lock);
> +	if (ple->ccname == NULL || strcmp(ple->ccname, cc_name) != 0) {
> +		free(ple->ccname);
> +		ple->ccname = strdup(cc_name);
> +		if (ple->ccname == NULL) {
> +			printerr(0, "ERROR: no storage to duplicate credentials "
> +				    "cache name '%s'\n", cc_name);
> +			code = ENOMEM;
> +			pthread_mutex_unlock(&ple_lock);
> +			goto out_free_kt;
> +		}
> +	}
> +	pthread_mutex_unlock(&ple_lock);
> +	if ((code = krb5_cc_resolve(context, cc_name, &ccache))) {
> +		k5err = gssd_k5_err_msg(context, code);
> +		printerr(0, "ERROR: %s while opening credential cache '%s'\n",
> +			 k5err, cc_name);
> +		goto out_free_kt;
> +	}
> +
> +	retval = gssd_get_single_krb5_cred(context, kt, ple, force_renew, ccache);
> +	krb5_cc_close(context, ccache);
>   out_free_kt:
>   	krb5_kt_close(context, kt);
>   out_free_context:


