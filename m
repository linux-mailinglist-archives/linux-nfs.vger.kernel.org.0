Return-Path: <linux-nfs+bounces-10777-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FA7A6E44B
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D059F1892C9C
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 20:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C757B2F3E;
	Mon, 24 Mar 2025 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FY0WY7DV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0DA17E0
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847890; cv=none; b=oivaY5oi1WnLEb3HL7cVjHcHAYofF0yoTv0SqAD0MDTlXrQ6CMGGQoaCNl08vHduRC90xgPKrUQ93Kbscf4dLwjE1bh98I2U1ITKmUQSx2OF1P05P4zyYaqtLDqfwGVnnJn5YmGH0qgHXXIRnuOzKIP2WfItzHP639SsOpPxC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847890; c=relaxed/simple;
	bh=y004qI4Bk+NrJr12eqVjMmar8arJmbDRpEpQrM3RzKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La+ea3As1TnMywlZi6uRNc3kML0HjbWhOyS6i/QVwfhH6esB5r2HIDddu9vR5h8trgppzaFYGP/Caqv+nOYD2mBM1fszk0Iz5lq6eSwQAOCZ4YvgoktoMPYpoPKj+OjI1tRsOFGQE8KfVW8JpjW+c1PaedDh49Xp1xSt+NMpP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FY0WY7DV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742847887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYgVZHqVlyU6igsdEtt3eTpnlJOD9OeaW9z3UJynfug=;
	b=FY0WY7DVgsLnjOFaNTwtj+8rqJUmTf622AIx61USGHMR19ftVVPF5SrM6o0B8KoXao1NUn
	uuhADk28Rovrxa8jgQU3eVWtqeOVrYMYbdJirpwM32UTJ2Oh3WwtjoFF9YuOYHgl2INKGX
	cMvdbmMSeqh/K3L42+6kgMnXsNJtYpQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-Z6JStmAqNxyqTgzbvSoTsw-1; Mon, 24 Mar 2025 16:24:46 -0400
X-MC-Unique: Z6JStmAqNxyqTgzbvSoTsw-1
X-Mimecast-MFC-AGG-ID: Z6JStmAqNxyqTgzbvSoTsw_1742847885
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6eada773c0eso157005366d6.3
        for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 13:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742847885; x=1743452685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYgVZHqVlyU6igsdEtt3eTpnlJOD9OeaW9z3UJynfug=;
        b=UKVhfm1FPvRlPPX3v4rfImCW+iF0XZGis+Xm5JPx+ufQemDSPJQGnAXEqhKiicr9iE
         8TyZcqq5kDqp3rbYOOKZX4dt/eSxwcu/tKT7ZM6W79wJqzc+Djip/fS9OhY45kFQoeiT
         3Tmo7rDVG+dtEAvLNtjqlho2nms4BUlLFNBMPdZaz5MBoXhhSv4GcQopglccFFk2/dbw
         GhvgV1S4NukAiPykq3u0uzFSu9XDb6D0LIE/6UrizOl+C+XHZuK30bo6OlMbRuHCivVE
         St1S1fXNzjW48I34Z3P8eRfgOWDJzh3tMmeplTXUjw8nwFxsQj2tu1O4u0cbaqrvIU/L
         VZUw==
X-Gm-Message-State: AOJu0Yx44f1ZBOaX8vPeu/AKbBq932k9RpXyGCQp5wUMCDvnYB+JKlk7
	3bncP3u500ugmWyBCtIrsCrlVVpuRA+KRZYUEKDfUlKSxrHNUJK9hynN03/FQoUg1iQP9H4TP0o
	CglwzXNDTcGQoY5l2ee3FEOzUGOm4YlAN6DxxON6RlX4jbney43lF2DYqnS7nORXHphBx
X-Gm-Gg: ASbGncswcouBa/43SGNsCdcqghMxf4/MPhtNrb3OBvr0+6pASSoy6bbDAFbAFsL0/li
	OISUlNcQqm7JdPQGl18Cd2+8fLGOIkyF3DS0j9UOMugpkInFbWOen6rNoEwTBRmOGAa/Tb+MLvd
	4MLZ+9XMHvzkfe6K0XJ71hIRZRzpHRFe/+KqaaHaP/h1H7PdgIOEhJvwUw++db+CuTRG+li1LzB
	3SUkgurZIVKPEvObl0seMnI8dMcUEOISSocO98s4hhRc/gFeYc7Ii5tdiTUQcQcdgEAd3iYDh+O
	FAorj2LWCU55w8Y=
X-Received: by 2002:a05:6214:224e:b0:6d8:9be9:7d57 with SMTP id 6a1803df08f44-6eb3f3aebbfmr253694886d6.37.1742847884563;
        Mon, 24 Mar 2025 13:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx/R4mhgdeMrrVSEcdc7VA/PWqyjOtFBB/2jx4iWEvhmyX/oD7FQyJEgeKlPX/mUpKCC5gGg==
X-Received: by 2002:a05:6214:224e:b0:6d8:9be9:7d57 with SMTP id 6a1803df08f44-6eb3f3aebbfmr253694466d6.37.1742847884124;
        Mon, 24 Mar 2025 13:24:44 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.244.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0ed5csm48086316d6.16.2025.03.24.13.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 13:24:43 -0700 (PDT)
Message-ID: <a44cc4ae-a246-4dc6-85f4-0992d9083d87@redhat.com>
Date: Mon, 24 Mar 2025 16:24:42 -0400
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


