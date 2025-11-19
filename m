Return-Path: <linux-nfs+bounces-16569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45133C70A3B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 19:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59AC94E2F4A
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA40D346E6B;
	Wed, 19 Nov 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqesVCSN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D25D28jr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96F2F49FD
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576552; cv=none; b=LnEuUSS3OczfipAUqnYi3+utbR2/7HXi1SmQ4GkREAUoR3coPlj7aFy1qbLoUBb4lQvRW+8L4GSjhV6qXelIXtyxaEC7qH8Wljhs1yF0YAy++QhLbTG+KFeTH7DfkBt3k2nDORkRybnUs6MiFZtt8Pk9R524jax2ocg5M70lWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576552; c=relaxed/simple;
	bh=Ikw1vDKn0yD5/0kvF8xD28xFpH2fvirwxuPQijfa+DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGJt4xJEF/o31+z/dDaejW/JiIuafQ/w+zx+pJPNlJ7efgMoBu7VvIGmD2PMjcOOWW6EOp1P7FifG8xOGCUW456anjv85DEA8hu/m5ZVIA2EoYq8w/jPBEPQ6jejTTidMtu2ve/9YRLb7a2kK7jOeya+nEBi6WTT+ecFr52uvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqesVCSN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D25D28jr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763576541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOI5ClHdz0tcg1kFoaIxC269EChhhXLbWFbrf4AZK3k=;
	b=IqesVCSNq74fgpBoAUPDK8LVzDyA5kw31IXi3QbTSsFV63NkEkloXl9amlXqIU1MBc75k/
	T51iH7Txpy6j4IGB3HTI90gGnVXWp9cxjCqQlv42ANlQ5UsUbWPtzI1QhWNdMBzehy+GIq
	pWiZ46UbR8v2hU5BiSNdPV39GJ/3vvQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-DDjuIf78MXa3JbnUWbNJaQ-1; Wed, 19 Nov 2025 13:22:20 -0500
X-MC-Unique: DDjuIf78MXa3JbnUWbNJaQ-1
X-Mimecast-MFC-AGG-ID: DDjuIf78MXa3JbnUWbNJaQ_1763576539
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e19c8558so6559485a.2
        for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 10:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763576538; x=1764181338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOI5ClHdz0tcg1kFoaIxC269EChhhXLbWFbrf4AZK3k=;
        b=D25D28jr9FJfXu+ofh5mRaOxrzwfI6a7wwH/vAIEzsr4QWnuPt5N9pGQfLDIUvI/ql
         zrmUIxQDHuImRaRl/+muZ63a/9Ta4gOI9BXSKeFyC5btuUqel83dDyV0fzEJzNodQZFj
         egaYzmvozmZfof9oxSe2n2OmV9IfsFlMRQbOBuBLQTOfHDfS8tAMbGqGEa4uEJL0ACxd
         YGFYPnoRyyYh89zE6WeuXp9Wt0P9CeaYpyfjx2GLzAlC6cF0sjr6EiMgLeqS6n4tLNr2
         I87VI3UvnyPt9ipUrB7txg61uaprcKipees+eRzcHjKItMUFJM+rGB3U6Wx8ENDlxYbj
         6mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763576538; x=1764181338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOI5ClHdz0tcg1kFoaIxC269EChhhXLbWFbrf4AZK3k=;
        b=bj7eHsPm5rYvmBWBIZHIswEsqua20OElTvGmoNErAk6GALdAkWLRZGZq2eYPGJkeaO
         yh4tpC902hflksK2AhxPvftUjRDfW1wcae5hOC+hCrigsjARmO+wKAktA0keR8AL3Dr6
         IwTMqWIKOYqcuf1VYEttiPzFVYT8iPQbDkKklp0E/h48NmAcijmuWj2roaRShzlOE0+B
         iEXTU/r9z1Kc4GKt8CGzMAhevjnRUpluoNtf6K33Lg1RKFXJTswypSb+zGXgIelQFclg
         7LkgogKtyznxEd0SBdu3/IYUS14SmKoyhn7AInK6BfOFHhtLApZQc1DSJQJoiLxS2un0
         CSzg==
X-Gm-Message-State: AOJu0YxFfIEF4/XsK8C51VM2ZpPgHV/z1JENcMskEBzv+Q2Kn6axX4iF
	kUoG9XcUI2WELlXU4akEJ+XYTB+mVXA+6ia8IXtcggyJxQ1DuUiiZBiXcRh90WDKKfzPnA+KhKy
	ENJLjdsy1nRChJatyDgy7w1/6B2+Tc9rT/7cmjcbnpegzQaR0N3pD1L/eYnEIaYNzQL520w==
X-Gm-Gg: ASbGncs81tpcQZSJjrWn/cL6M5Qq3zM3Ly+bDeowxjeRTMiXsX5rcCAZr3cDO1B6eVe
	HBUQmOfuU1JwhWCNiVoGpw0w/7gpXbJnQSPvCFOzdUxFlB2wZKeRd3afIz/g5yAxWh4P1B8OIG5
	iQ4nPYsEQxIGuU8GavfoSEfLIQG3C9rODovk/YpWVLSl6kZ24YGnu4qMYIgGVWXlsWvv2KuArjx
	gQ6XsKuFkfMmb3ODd72gv4x+YLZfytFIFSw2y3pTSZoahEg9r7WawgF1Fnjozom70GbM9hEzMhH
	d4DDDVZDSXPTOKy6nOLBjm6LGJQFrW1pj7xNRjMUmHxbgo2xzZIwHSswcBiSMCGWlTGMG3/TWIb
	oO6M9ukeyCA==
X-Received: by 2002:a05:620a:711b:b0:8b2:62f9:9fd8 with SMTP id af79cd13be357-8b327499f45mr44227085a.61.1763576538386;
        Wed, 19 Nov 2025 10:22:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6Y0NXf6c7WeJmALN3e6amRiQV8WQUEQdCKFRA1gCVhQG685+8wbQRpJbgjFoHGFxDep54Tg==
X-Received: by 2002:a05:620a:711b:b0:8b2:62f9:9fd8 with SMTP id af79cd13be357-8b327499f45mr44223685a.61.1763576537935;
        Wed, 19 Nov 2025 10:22:17 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.237])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2e519bb84sm901224385a.34.2025.11.19.10.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 10:22:17 -0800 (PST)
Message-ID: <e5e8219d-944c-4f64-af49-9a1fc539dde6@redhat.com>
Date: Wed, 19 Nov 2025 13:22:15 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] gssd: protect kerberos ticket cache access
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20251027153812.80887-1-okorniev@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20251027153812.80887-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/25 11:38 AM, Olga Kornievskaia wrote:
> gssd_get_single_krb5_cred() is a function that's will (for when needed)
> send a TGT request to the KDC and then store it in a credential cache.
> If multiple threads (eg., parallel mounts) are making an upcall at the
> same time then getting creds and storing creds need to be serialized due
> to do kerberos API not being concurrency safe.
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Committed... (tag: nfs-utils-2-8-5-rc1)

steved.> ---
>   utils/gssd/krb5_util.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 09625fb9..137cffda 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -456,12 +456,14 @@ gssd_get_single_krb5_cred(krb5_context context,
>   	krb5_get_init_creds_opt_set_tkt_life(opts, 5*60);
>   #endif
>   
> +	pthread_mutex_lock(&ple_lock);
>   	if ((code = krb5_get_init_creds_opt_set_out_ccache(context, opts,
>   							   ccache))) {
>   		k5err = gssd_k5_err_msg(context, code);
>   		printerr(1, "WARNING: %s while initializing ccache for "
>   			 "principal '%s' using keytab '%s'\n", k5err,
>   			 pname ? pname : "<unparsable>", kt_name);
> +		pthread_mutex_unlock(&ple_lock);
>   		goto out;
>   	}
>   	if ((code = krb5_get_init_creds_keytab(context, &my_creds, ple->princ,
> @@ -470,10 +472,10 @@ gssd_get_single_krb5_cred(krb5_context context,
>   		printerr(1, "WARNING: %s while getting initial ticket for "
>   			 "principal '%s' using keytab '%s'\n", k5err,
>   			 pname ? pname : "<unparsable>", kt_name);
> +		pthread_mutex_unlock(&ple_lock);
>   		goto out;
>   	}
>   
> -	pthread_mutex_lock(&ple_lock);
>   	ple->endtime = my_creds.times.endtime;
>   	pthread_mutex_unlock(&ple_lock);
>   


