Return-Path: <linux-nfs+bounces-2303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5964E87CDE2
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 14:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D95C1C20A90
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C07D19BA2;
	Fri, 15 Mar 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNI+vhqK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422B241F9
	for <linux-nfs@vger.kernel.org>; Fri, 15 Mar 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508421; cv=none; b=AufrdKByhA/ytKgE/KQzWrpevxiqHOdxoF0S2F7Dbc2WD+7chDKGdgmM/z2RwhXJdrzNcA2G+Y4UDtmTcB/bhFuwILCvF3QvxR4kGRqSJ/cHcmuYCpfAWQ0hEpK75lQ1lIaEubCwZvnxu5nro4S2nHaWHDLGPP92QY5a3FXdWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508421; c=relaxed/simple;
	bh=ZKcvup9CjzI6ni9sxedkzyg5yMisa5OyPaEbVnCSAu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndbN3ZpPjADS/j5mzdpyscy40uIahl6vn1DIgKldEJ6HhZyL5ptEJ6Fx2ovYwPQWk+mFI3ffUXce9PqReTRPkJ2IK2f7umghugzxsEcmRXqP4Q/EbFkzTrlX9TDqzwThbpWkn01QkA/SmJl5xVv6QU4ksPs0Dh62ZQWJMm9G+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNI+vhqK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710508418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDqaozsatJb+P25MhB/xcxO5fom18E8gDC/xeIBaAfk=;
	b=NNI+vhqKOn8hZpzDCo9mURnCSxApl2POkJ3KmltP67Zl8ZyZAPjS7367ooYRrY6+S7Vo8N
	4oSVI1QYuj1sBqhP2IzCB+gOcWOn+hHICC1VTBNqdRGYovTcYyoQyJOloMabKado9JRCnV
	kDh4edvgzkJmnnXej+rqBglkHDls2qQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-MLaNdDfZOtehoebMFIfgiw-1; Fri, 15 Mar 2024 09:13:37 -0400
X-MC-Unique: MLaNdDfZOtehoebMFIfgiw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6912513fc7bso11193146d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 15 Mar 2024 06:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508416; x=1711113216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDqaozsatJb+P25MhB/xcxO5fom18E8gDC/xeIBaAfk=;
        b=Wc4aTflUC7OPNs/5POJvq2P4hH8eswGDkBS9OkGe7giqCTfJ5U7pUkuyyyVDlmRA46
         k0LUwaEqFxtBBj+2YcvIXX6q6LagXgK/JaAR4gfSftIsX4RtPzD/TdSjLZyiacWOQCOk
         N73slzhVWnrIDJFtS81A8mz885KKtJcs9nSCd/CmlL5cAj4Dj7WTI2IMUYYfbRpcCB7a
         TKq0RAeSAlJeyadTHX0LbLoY9QLYCMWGXXCfhIsI6O4CLpwSi1CwMlx6w2Rw1tDFPHGB
         M14sjTxhd5BBTxoEJj9SC+kzL+lR40APmyE4O2CI6q9JSVskZZoRLb2ZN5icpHNMMN06
         NVoQ==
X-Gm-Message-State: AOJu0Yydw8tPnfzXL/1mnX+P1udxjc5QeSb5VzD/DwHFSRFwN1KkrTaD
	7Az0whqquzu+efgXUshMlZ49FYjo/7vwWFlmpIXo7awqo1IdSm4re5fhKj3q3uKmiCJyQRN5lE+
	1yza4dcsusd1IB5ynZxlGh7AVEdcNmvVcdsHVq3bNdYPCGCT8IkoF9SPkyw==
X-Received: by 2002:a05:6214:459e:b0:68f:1c80:d78e with SMTP id op30-20020a056214459e00b0068f1c80d78emr5119162qvb.0.1710508416267;
        Fri, 15 Mar 2024 06:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXsrgTovN5LPDO9kanSqOmkB8OatQrb90rqA7TQZ2XvfCcRU3fw9ATdHv/xylDzR6wSn/u8Q==
X-Received: by 2002:a05:6214:459e:b0:68f:1c80:d78e with SMTP id op30-20020a056214459e00b0068f1c80d78emr5119145qvb.0.1710508415954;
        Fri, 15 Mar 2024 06:13:35 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.209])
        by smtp.gmail.com with ESMTPSA id gy10-20020a056214242a00b0068f6e1c3582sm1939942qvb.146.2024.03.15.06.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 06:13:35 -0700 (PDT)
Message-ID: <d0123f6e-4687-41a4-8a28-cbe583a6f6f3@redhat.com>
Date: Fri, 15 Mar 2024 09:13:34 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 2/2] gssd: add a "backoff" feature to
 limit_krb5_enctypes()
Content-Language: en-US
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20240228222253.1080880-1-smayhew@redhat.com>
 <20240228222253.1080880-3-smayhew@redhat.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240228222253.1080880-3-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/24 5:22 PM, Scott Mayhew wrote:
> If the NFS server reset the connection when we tried to create a GSS
> context with it, then there's a good chance that we used an encryption
> type that it didn't support.
> 
> Add a one time backoff/retry mechanism, where we adjust the list of
> encryption types that we set via gss_set_allowable_enctypes().  We can
> do this easily because the list of encryption types should be ordered
> from highest preference to lowest.  We just need to find the first entry
> that's not one of the newer encryption types, and then use that as the
> start of the list.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Not Committed!

steved.
> ---
>   utils/gssd/gssd_proc.c | 15 +++++++++++++--
>   utils/gssd/krb5_util.c | 40 +++++++++++++++++++++++++++++++++++++++-
>   utils/gssd/krb5_util.h |  2 +-
>   3 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> index 7629de0b..0da54598 100644
> --- a/utils/gssd/gssd_proc.c
> +++ b/utils/gssd/gssd_proc.c
> @@ -337,6 +337,10 @@ create_auth_rpc_client(struct clnt_info *clp,
>   	rpc_gss_options_req_t	req;
>   	rpc_gss_options_ret_t	ret;
>   	char			mechanism[] = "kerberos_v5";
> +#endif
> +#ifdef HAVE_SET_ALLOWABLE_ENCTYPES
> +	bool			backoff = false;
> +	struct rpc_err		err;
>   #endif
>   	pthread_t tid = pthread_self();
>   
> @@ -354,14 +358,14 @@ create_auth_rpc_client(struct clnt_info *clp,
>   		goto out_fail;
>   	}
>   
> -
>   	if (authtype == AUTHTYPE_KRB5) {
>   #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
> +again:
>   		/*
>   		 * Do this before creating rpc connection since we won't need
>   		 * rpc connection if it fails!
>   		 */
> -		if (limit_krb5_enctypes(&sec)) {
> +		if (limit_krb5_enctypes(&sec, backoff)) {
>   			printerr(1, "WARNING: Failed while limiting krb5 "
>   				    "encryption types for user with uid %d\n",
>   				 uid);
> @@ -445,6 +449,13 @@ create_auth_rpc_client(struct clnt_info *clp,
>   					goto success;
>   			}
>   		}
> +#endif
> +#ifdef HAVE_SET_ALLOWABLE_ENCTYPES
> +		clnt_geterr(rpc_clnt, &err);
> +		if (err.re_errno == ECONNRESET && !backoff) {
> +			backoff = true;
> +			goto again;
> +		}
>   #endif
>   		/* Our caller should print appropriate message */
>   		printerr(2, "WARNING: Failed to create krb5 context for "
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 57b3cf8a..5502e74e 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -1675,7 +1675,7 @@ out:
>    */
>   
>   int
> -limit_krb5_enctypes(struct rpc_gss_sec *sec)
> +limit_krb5_enctypes(struct rpc_gss_sec *sec, bool backoff)
>   {
>   	u_int maj_stat, min_stat;
>   	krb5_enctype enctypes[] = { ENCTYPE_DES_CBC_CRC,
> @@ -1689,6 +1689,17 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
>   	int num_set_enctypes;
>   	krb5_enctype *set_enctypes;
>   	int err = -1;
> +	int i, j;
> +	bool done = false;
> +
> +	if (backoff && sec->cred != GSS_C_NO_CREDENTIAL) {
> +		printerr(2, "%s: backoff: releasing old cred\n", __func__);
> +		maj_stat = gss_release_cred(&min_stat, &sec->cred);
> +		if (maj_stat != GSS_S_COMPLETE) {
> +			printerr(2, "%s: gss_release_cred() failed\n", __func__);
> +			return -1;
> +		}
> +	}
>   
>   	if (sec->cred == GSS_C_NO_CREDENTIAL) {
>   		err = gssd_acquire_krb5_cred(&sec->cred);
> @@ -1718,6 +1729,33 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
>   		set_enctypes = krb5_enctypes;
>   	}
>   
> +	if (backoff) {
> +		j = num_set_enctypes;
> +		for (i = 0; i < j && !done; i++) {
> +			switch (*set_enctypes) {
> +			case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
> +			case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
> +			case ENCTYPE_CAMELLIA128_CTS_CMAC:
> +			case ENCTYPE_CAMELLIA256_CTS_CMAC:
> +				printerr(2, "%s: backoff: removing enctype %d\n",
> +					 __func__, *set_enctypes);
> +				set_enctypes++;
> +				num_set_enctypes--;
> +				break;
> +			default:
> +				done = true;
> +				break;
> +			}
> +		}
> +		printerr(2, "%s: backoff: %d remaining enctypes\n",
> +			 __func__, num_set_enctypes);
> +		if (!num_set_enctypes) {
> +			printerr(0, "%s: no remaining enctypes after backoff\n",
> +				 __func__);
> +			return -1;
> +		}
> +	}
> +
>   	maj_stat = gss_set_allowable_enctypes(&min_stat, sec->cred,
>   				&krb5oid, num_set_enctypes, set_enctypes);
>   
> diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
> index 40ad3233..0be0c500 100644
> --- a/utils/gssd/krb5_util.h
> +++ b/utils/gssd/krb5_util.h
> @@ -26,7 +26,7 @@ int gssd_k5_remove_bad_service_cred(char *srvname);
>   
>   #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
>   extern int limit_to_legacy_enctypes;
> -int limit_krb5_enctypes(struct rpc_gss_sec *sec);
> +int limit_krb5_enctypes(struct rpc_gss_sec *sec, bool backoff);
>   int get_allowed_enctypes(void);
>   #endif
>   


