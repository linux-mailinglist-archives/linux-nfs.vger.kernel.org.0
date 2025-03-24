Return-Path: <linux-nfs+bounces-10776-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C2BA6E441
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 21:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629377A7ACA
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 20:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4AA19E99A;
	Mon, 24 Mar 2025 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpHuCdmG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4CC1C54AA
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847855; cv=none; b=S+j4LZrfRNTKsU243AZL89WI1/vdDhmkf5hTkAMEc2hOhAnTrADeN+/U1hkvrEEQ36do1O7Z36aYzeeQk5K4J+XfREQT2FR6ZExSdh7Dmd+VDBWDtdXl5JObLjd9J0Sy/3AzfjYnnTx/exjtsLNnKl5u4MVeQs8YhX4XRnbcbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847855; c=relaxed/simple;
	bh=y004qI4Bk+NrJr12eqVjMmar8arJmbDRpEpQrM3RzKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBxzNMjkXL0oZ9LNbvpH7hPRYW/dqugC/BTkHIsc/a4/WV+dbIRL0LrruRaxNrik21jFv+vaOPs9uGMjTNSZJSIMRHotxQRhctWbKtQLacW/sZdZae1gicCm4wJPG+bEQql+hLjtHL5ffnIxL+a15xoCUTfSNqm4g+YsYyLvlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpHuCdmG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742847852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYgVZHqVlyU6igsdEtt3eTpnlJOD9OeaW9z3UJynfug=;
	b=IpHuCdmG/OXtXDOSEqRwaES7SS2/NfCmpiVnAB2FDLbsyrXZ+CMoc/O64gFVF3XeHwUl+W
	N39jT5o77PXXj1fHCJD2AAcyfpM0Kghmpu62mdYd8+ZEj/5ctL36zbBcDrj4ezfZIgSWza
	LXMdTC8JKJrCznhP8ALaL82j+4qn8F0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Sf3wzoobOcewNRDJP9tTjA-1; Mon, 24 Mar 2025 16:24:10 -0400
X-MC-Unique: Sf3wzoobOcewNRDJP9tTjA-1
X-Mimecast-MFC-AGG-ID: Sf3wzoobOcewNRDJP9tTjA_1742847850
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e91d8a7165so82459056d6.0
        for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 13:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742847849; x=1743452649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYgVZHqVlyU6igsdEtt3eTpnlJOD9OeaW9z3UJynfug=;
        b=B7IP3vrAfyeBrdjcUdEDxjw6eLM9716skOVVVJP/pdEyDq+QaJLDWo5x4WfJ/16wEp
         9sda1Hftq5S4T2/SH3JzC9NDGa6T0pc+Vw3/waXwXjotqPhEymuyr5AWmbtrSXewYBNO
         UTLB/XIy6vSP07uEDuU0L46ykh+WJ8ujYH7AyoJtgMxbDEPHzT5L9ZdsXGLYUPOVjg+B
         4LNcPrYWXyJ6ednqwSZs84kZYWtwuurRMp/Md9UEyTWa77v/ESuseJ4tF7Fu/UoTGpxU
         i96GEhsETcVm7mBK20mDG8iceLOhLu52dn6C9eA1IgRxpvcssxtWPrFYsaSOVCfRQfOU
         VcIg==
X-Gm-Message-State: AOJu0YyYu9HuHm8m9BS0BqM+ByqVKDUCKDEOYfTKtma8O7HM2A8M0yyI
	McS0mkKVUQwGwrB0WLHSUvX3mQOnz+8T5rAMNW0zw4FKZ1cTaRuHA6GYMK0DveCmy6ZoHXzjdwY
	O54h9lg2MDipWNsQajyzFO8p+aUUq7ypfVzgzowy3xdQi8lFe8ketlOokFjJ3VhBfWeu0
X-Gm-Gg: ASbGncsnUCzjWoex6wzlHxmw6qR9KYa5CWA9dbrn82UMTOWi4b99UWSDqTjS0UgF6dc
	vBweraQT7FMFZ9OwCqTAjgC0klVjV3Fy+6WAmRSotIMxvEjDHqqtxNHBxOqmnYRytpYllMC7g0i
	v1NM9sZcJb3AOUVeze0DaWXof6FJY8fM+umcvsy7lBOKAZYGjI5ZJ/wQKJIKZn+UO09BsaCRgKB
	7uIbRjigWQ9L5gWWdMInZNVUFP5LWHxkLCqS2oB8hot7YNoDYUfViLFWkyxSX1Rx+gLeF/r4cJZ
	+XH4uCG/j4R9vFI=
X-Received: by 2002:a05:6214:268f:b0:6e8:ddf6:d122 with SMTP id 6a1803df08f44-6eb3f294de9mr230954176d6.3.1742847849485;
        Mon, 24 Mar 2025 13:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRF5piWSzHtfCz/5Y6QaxQYB8NqyS7kcRPUN6dfobj4feFs8rqWexmP3oGdWiQoMHUGtPUpg==
X-Received: by 2002:a05:6214:268f:b0:6e8:ddf6:d122 with SMTP id 6a1803df08f44-6eb3f294de9mr230953716d6.3.1742847849006;
        Mon, 24 Mar 2025 13:24:09 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.244.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f51esm48709086d6.26.2025.03.24.13.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 13:24:07 -0700 (PDT)
Message-ID: <5d3ea43b-9af5-42e9-b785-4274f0b941e6@redhat.com>
Date: Mon, 24 Mar 2025 16:24:06 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfs-utils: gssd: unconditionally use
 krb5_get_init_creds_opt_alloc
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250225214607.20449-1-okorniev@redhat.com>
 <20250225214607.20449-2-okorniev@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250225214607.20449-2-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/25/25 4:46 PM, Olga Kornievskaia wrote:
> Modern kerberos API uses krb5_get_init_creds_opt_alloc() for managing
> its options for credential data structure.
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Committed... (tag: nfs-utils-2-8-3-rc8)

steved.
> ---
>   utils/gssd/krb5_util.c | 37 ++++++++++---------------------------
>   1 file changed, 10 insertions(+), 27 deletions(-)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index d7116d93..201585ed 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -397,12 +397,7 @@ gssd_get_single_krb5_cred(krb5_context context,
>   			  struct gssd_k5_kt_princ *ple,
>   			  int force_renew)
>   {
> -#ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
> -	krb5_get_init_creds_opt *init_opts = NULL;
> -#else
> -	krb5_get_init_creds_opt options;
> -#endif
> -	krb5_get_init_creds_opt *opts;
> +	krb5_get_init_creds_opt *opts = NULL;
>   	krb5_creds my_creds;
>   	krb5_ccache ccache = NULL;
>   	char kt_name[BUFSIZ];
> @@ -443,33 +438,23 @@ gssd_get_single_krb5_cred(krb5_context context,
>   	if ((krb5_unparse_name(context, ple->princ, &pname)))
>   		pname = NULL;
>   
> -#ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
> -	code = krb5_get_init_creds_opt_alloc(context, &init_opts);
> +	code = krb5_get_init_creds_opt_alloc(context, &opts);
>   	if (code) {
>   		k5err = gssd_k5_err_msg(context, code);
>   		printerr(0, "ERROR: %s allocating gic options\n", k5err);
>   		goto out;
>   	}
> -	if (krb5_get_init_creds_opt_set_addressless(context, init_opts, 1))
> +#ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
> +	if (krb5_get_init_creds_opt_set_addressless(context, opts, 1))
>   		printerr(1, "WARNING: Unable to set option for addressless "
>   			 "tickets.  May have problems behind a NAT.\n");
> -#ifdef TEST_SHORT_LIFETIME
> -	/* set a short lifetime (for debugging only!) */
> -	printerr(1, "WARNING: Using (debug) short machine cred lifetime!\n");
> -	krb5_get_init_creds_opt_set_tkt_life(init_opts, 5*60);
> +#else
> +	krb5_get_init_creds_opt_set_address_list(opts, NULL);
>   #endif
> -	opts = init_opts;
> -
> -#else	/* HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS */
> -
> -	krb5_get_init_creds_opt_init(&options);
> -	krb5_get_init_creds_opt_set_address_list(&options, NULL);
>   #ifdef TEST_SHORT_LIFETIME
>   	/* set a short lifetime (for debugging only!) */
> -	printerr(0, "WARNING: Using (debug) short machine cred lifetime!\n");
> -	krb5_get_init_creds_opt_set_tkt_life(&options, 5*60);
> -#endif
> -	opts = &options;
> +	printerr(1, "WARNING: Using (debug) short machine cred lifetime!\n");
> +	krb5_get_init_creds_opt_set_tkt_life(opts, 5*60);
>   #endif
>   
>   	if ((code = krb5_get_init_creds_keytab(context, &my_creds, ple->princ,
> @@ -530,10 +515,8 @@ gssd_get_single_krb5_cred(krb5_context context,
>   	printerr(2, "%s(0x%lx): principal '%s' ccache:'%s'\n",
>   		__func__, tid, pname, cc_name);
>     out:
> -#ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
> -	if (init_opts)
> -		krb5_get_init_creds_opt_free(context, init_opts);
> -#endif
> +	if (opts)
> +		krb5_get_init_creds_opt_free(context, opts);
>   	if (pname)
>   		k5_free_unparsed_name(context, pname);
>   	if (ccache)


