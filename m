Return-Path: <linux-nfs+bounces-2302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF3887CDDC
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 14:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C18281E90
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49893241F9;
	Fri, 15 Mar 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaDnaBRX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556661BF3C
	for <linux-nfs@vger.kernel.org>; Fri, 15 Mar 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508393; cv=none; b=En49/j4B6PTu0fHfF4Tc2vy9FTFogzJKtgh09bQUNdrdSW4eQqpVUj+JGKzAViAlIyh4B8joXhTuVYpT6/QVubVWch0eA4h03S4iNR/pIrecqEHmk8Nb2YDyy3NDUBps9a2e1kwxUI4ybPP7GNVbDWBl1MJjiF5xXeTKxCt7aQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508393; c=relaxed/simple;
	bh=iiW6Dmlm0zy6u7/gmBqVeBvxmz/37vqs3dRmMlYho2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXzgb+L4wYIPsFs2ivARpOIt/Y7fjwVZ1j/LyBgtaW9BvnhVy5RjAuTm8zPANTWSmF9BWgFTL85NGNZ85Slr2duwOHC0w/qFesF4dA2EIKqon8jrRN7oNtuf40mUlhRcPwvATljNsuH2Qio4XOffVGh2RDLJrJBjIHD+fALaWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaDnaBRX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710508390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUJo1a9lSp+0/b8J/or6/V7ndrwKd0BaSxmySN2nPK0=;
	b=EaDnaBRXa4oDEQQN3aXR7KKeRm3KJoWgU8Y8pkNZ8SmViHDr8ob39VFWywqQsloLsXVBw0
	bIF42rJlqtMecYnP/XfVi/z1GNnO/LkTSvWLnv8m+Xrw/hz/6AakoxdASIwQq5wVdJoSwd
	yFICo2LQMzsGNxZbT8ILQZ1ZHrmyqkQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-nUDlQTAiNNqVBRW8bCqW-w-1; Fri, 15 Mar 2024 09:13:09 -0400
X-MC-Unique: nUDlQTAiNNqVBRW8bCqW-w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69120b349c9so6011106d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 15 Mar 2024 06:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508387; x=1711113187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUJo1a9lSp+0/b8J/or6/V7ndrwKd0BaSxmySN2nPK0=;
        b=MWCAI1MO4SqxcNIZuMkcJsA8c07DBMKwhf1hOaHxNE196QPWgvG358GtoujAhbnOr/
         DqCOruiR8sclkrQKtWHWnEI4HOC5C7ghJpkptGGOEfyL8uB+bhrLKElpUydY/Vv66Nfb
         du0dkpzlFDZ7/0DxJmq66s5krbfKlCkyNjyOocSCgADmF2y6D5RE03gQPRgjOiCWiWLi
         g0/l0rX7sVw40JR4iML9QjoVjeBsEAPVz5hWBWzIIMB3MVEYM7scVA3/NfsB1Vy6Qcsr
         CiGEAl9vcJzgzTSBtdVzgXyrtbsorJhvowNJsPh/hxsVXQa1iTqCict6skPsqNmWVbPZ
         UaIQ==
X-Gm-Message-State: AOJu0YxpSLdNXCPXPrwkWC1rPWzms8cgxMTtG0ok/mRdBtwB1G2xsKZL
	eNsV8gCakPO3GkDS77iB/MpVz69BOeeYb3PzrmiJOtW1bL3Pm/PrUeL+IbMI+xYFJPsFDKT6nCZ
	RP/owUlPj6Szho3DAVAaRUOxSPKQ8YqKH1IwUOJhoiKjx5SEMWsx4Ae5c6dp0lJ96Sg==
X-Received: by 2002:a05:6214:2b9d:b0:690:cdd5:ea47 with SMTP id kr29-20020a0562142b9d00b00690cdd5ea47mr5108926qvb.4.1710508386743;
        Fri, 15 Mar 2024 06:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5YcZN46qyERFUrWVeVZozxpsp8UyKeh6LDMurqKA6vj0lgbD2AC4Sy9ghem67sOnlRr1Vsw==
X-Received: by 2002:a05:6214:2b9d:b0:690:cdd5:ea47 with SMTP id kr29-20020a0562142b9d00b00690cdd5ea47mr5108908qvb.4.1710508386401;
        Fri, 15 Mar 2024 06:13:06 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.209])
        by smtp.gmail.com with ESMTPSA id gy10-20020a056214242a00b0068f6e1c3582sm1939942qvb.146.2024.03.15.06.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 06:13:05 -0700 (PDT)
Message-ID: <1ed2ceb0-5ba5-4e33-adf0-0b345320dc2e@redhat.com>
Date: Fri, 15 Mar 2024 09:13:05 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 1/2] gssd: add support for an "allowed-enctypes"
 option in nfs.conf
Content-Language: en-US
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20240228222253.1080880-1-smayhew@redhat.com>
 <20240228222253.1080880-2-smayhew@redhat.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240228222253.1080880-2-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/24 5:22 PM, Scott Mayhew wrote:
> Newer kernels have support for newer krb5 encryption types, AES with
> SHA2 and Camellia.  An NFS client with an "old" kernel can talk to
> and NFS server with a "new" kernel and it just works.   An NFS client
> with a "new" kernel can talk to an NFS server with an "old" kernel, but
> that requires some additional configuration (particularly if the NFS
> server does have support for the newer encryption types in its userspace
> krb5 libraries) that may be unclear and/or burdensome to the admin.
> 
> 1) If the NFS server has support for the newer encryption types in the
>     userspace krb5 libraries, but not in the kernel's RPCSEC_GSS code,
>     then its possible that it also already has "nfs" keys using those
>     newer encryption types in its keytab.  In that case, it's necessary
>     to regenerate the "nfs" keys without the newer encryption types.
>     The reason this is necessary is because if the NFS client requests
>     an "nfs" service ticket from the KDC, and the list of enctypes in
>     in that TGS-REQ contains a newer encryption type, and the KDC had
>     previously generated a key for the NFS server using the newer
>     encryption type, then the resulting service ticket in the TGS-REP
>     will be using the newer encryption type and the NFS server will not
>     be able to decrypt it.
> 
> 2) It is necessary to either modify the permitted_enctypes field of the
>     krb5.conf or create a custom crypto-policy module (if the
>     crypto-policies package is being used) on the NFS *client* so that it
>     does not include the newer encryption types.  The reason this is
>     necessary is because it affects the list of encryption types that
>     will be present in the RPCSEC_GSS_INIT request that the NFS client
>     sends to the NFS server.  The kernel on the NFS server cannot not
>     process the request on its own; it has to upcall to gssproxy to do
>     that... and again if the userspace krb5 libraries on the NFS server
>     have support for the newer encryption types, then it will select one
>     of those and the kernel will not be able to import the context when
>     it gets the downcall.  Also note that modifying the permitted_enctypes
>     field and/or crypto policy has the side effect of impacting everything
>     krb5 related, not just just NFS.
> 
> So add support for an "allowed-enctypes" field in nfs.conf.  This allows
> the admin to restrict gssd to using a subset of the encryption types
> that are supported by the kernel and krb5 libraries.  This will remove
> the need for steps 1 & 2 above, and will only affect NFS rather than
> krb5 as a whole.
> 
> For example, for a "new" NFS client talking to an "old" NFS server, the
> admin will probably want this in the client's nfs.conf:
> 
> allowed-enctypes=aes256-cts-hmac-sha1-96,aes128-cts-hmac-sha1-96
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed (tag: nfs-utils-2-7-1-rc5)

steved.
> ---
>   nfs.conf               |  1 +
>   utils/gssd/gssd.c      |  6 +++
>   utils/gssd/gssd.man    |  9 ++++
>   utils/gssd/krb5_util.c | 95 +++++++++++++++++++++++++++++++++++++++---
>   utils/gssd/krb5_util.h |  1 +
>   5 files changed, 106 insertions(+), 6 deletions(-)
> 
> diff --git a/nfs.conf b/nfs.conf
> index 323f072b..23b5f7d4 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -23,6 +23,7 @@
>   # use-gss-proxy=0
>   # avoid-dns=1
>   # limit-to-legacy-enctypes=0
> +# allowed-enctypes=aes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128,camellia256-cts-cmac,camellia128-cts-cmac,aes256-cts-hmac-sha1-96,aes128-cts-hmac-sha1-96
>   # context-timeout=0
>   # rpc-timeout=5
>   # keytab-file=/etc/krb5.keytab
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index ca9b3267..10c731ab 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -1232,6 +1232,12 @@ main(int argc, char *argv[])
>   
>   	daemon_init(fg);
>   
> +#ifdef HAVE_SET_ALLOWABLE_ENCTYPES
> +	rc = get_allowed_enctypes();
> +	if (rc)
> +		exit(EXIT_FAILURE);
> +#endif
> +
>   	if (gssd_check_mechs() != 0)
>   		errx(1, "Problem with gssapi library");
>   
> diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
> index 2a5384d3..c735eff6 100644
> --- a/utils/gssd/gssd.man
> +++ b/utils/gssd/gssd.man
> @@ -346,6 +346,15 @@ flag.
>   Equivalent to
>   .BR -l .
>   .TP
> +.B allowed-enctypes
> +Allows you to restrict
> +.B rpc.gssd
> +to using a subset of the encryption types permitted by the kernel and the krb5
> +libraries.  This is useful if you need to interoperate with an NFS server that
> +does not have support for the newer SHA2 and Camellia encryption types, for
> +example.  This configuration file option does not have an equivalent
> +command-line option.
> +.TP
>   .B context-timeout
>   Equivalent to
>   .BR -t .
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 6f66ef4f..57b3cf8a 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -129,6 +129,7 @@
>   #include "err_util.h"
>   #include "gss_util.h"
>   #include "krb5_util.h"
> +#include "conffile.h"
>   
>   /*
>    * List of principals from our keytab that we
> @@ -155,6 +156,8 @@ static pthread_mutex_t ple_lock = PTHREAD_MUTEX_INITIALIZER;
>   
>   #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
>   int limit_to_legacy_enctypes = 0;
> +krb5_enctype *allowed_enctypes = NULL;
> +int num_allowed_enctypes = 0;
>   #endif
>   
>   /*==========================*/
> @@ -1596,6 +1599,68 @@ out_cred:
>   }
>   
>   #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
> +int
> +get_allowed_enctypes(void)
> +{
> +	struct conf_list *allowed_etypes = NULL;
> +	struct conf_list_node *node;
> +	char *buf = NULL, *old = NULL;
> +	int len, ret = 0;
> +
> +	allowed_etypes = conf_get_list("gssd", "allowed-enctypes");
> +	if (allowed_etypes) {
> +		TAILQ_FOREACH(node, &(allowed_etypes->fields), link) {
> +			allowed_enctypes = realloc(allowed_enctypes,
> +						   (num_allowed_enctypes + 1) *
> +						   sizeof(*allowed_enctypes));
> +			if (allowed_enctypes == NULL) {
> +				ret = ENOMEM;
> +				goto out_err;
> +			}
> +			ret = krb5_string_to_enctype(node->field,
> +						     &allowed_enctypes[num_allowed_enctypes]);
> +			if (ret) {
> +				printerr(0, "%s: invalid enctype %s",
> +					 __func__, node->field);
> +				goto out_err;
> +			}
> +			if (get_verbosity() > 1) {
> +				if (buf == NULL) {
> +					len = asprintf(&buf, "%s(%d)", node->field,
> +						       allowed_enctypes[num_allowed_enctypes]);
> +					if (len < 0) {
> +						ret = ENOMEM;
> +						goto out_err;
> +					}
> +				} else {
> +					old = buf;
> +					len = asprintf(&buf, "%s,%s(%d)", old, node->field,
> +						       allowed_enctypes[num_allowed_enctypes]);
> +					if (len < 0) {
> +						ret = ENOMEM;
> +						goto out_err;
> +					}
> +					free(old);
> +					old = NULL;
> +				}
> +			}
> +			num_allowed_enctypes++;
> +		}
> +		printerr(2, "%s: allowed_enctypes = %s", __func__, buf);
> +	}
> +	goto out;
> +out_err:
> +	num_allowed_enctypes = 0;
> +	free(allowed_enctypes);
> +out:
> +	free(buf);
> +	if (old != buf)
> +		free(old);
> +	if (allowed_etypes)
> +		conf_free_list(allowed_etypes);
> +	return ret;
> +}
> +
>   /*
>    * this routine obtains a credentials handle via gss_acquire_cred()
>    * then calls gss_krb5_set_allowable_enctypes() to limit the encryption
> @@ -1619,6 +1684,10 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
>   	int num_enctypes = sizeof(enctypes) / sizeof(enctypes[0]);
>   	extern int num_krb5_enctypes;
>   	extern krb5_enctype *krb5_enctypes;
> +	extern int num_allowed_enctypes;
> +	extern krb5_enctype *allowed_enctypes;
> +	int num_set_enctypes;
> +	krb5_enctype *set_enctypes;
>   	int err = -1;
>   
>   	if (sec->cred == GSS_C_NO_CREDENTIAL) {
> @@ -1631,12 +1700,26 @@ limit_krb5_enctypes(struct rpc_gss_sec *sec)
>   	 * If we failed for any reason to produce global
>   	 * list of supported enctypes, use local default here.
>   	 */
> -	if (krb5_enctypes == NULL || limit_to_legacy_enctypes)
> -		maj_stat = gss_set_allowable_enctypes(&min_stat, sec->cred,
> -					&krb5oid, num_enctypes, enctypes);
> -	else
> -		maj_stat = gss_set_allowable_enctypes(&min_stat, sec->cred,
> -					&krb5oid, num_krb5_enctypes, krb5_enctypes);
> +	if (krb5_enctypes == NULL || limit_to_legacy_enctypes ||
> +			allowed_enctypes) {
> +		if (allowed_enctypes) {
> +			printerr(2, "%s: using allowed enctypes from config\n",
> +				 __func__);
> +			num_set_enctypes = num_allowed_enctypes;
> +			set_enctypes = allowed_enctypes;
> +		} else {
> +			printerr(2, "%s: using legacy enctypes\n", __func__);
> +			num_set_enctypes = num_enctypes;
> +			set_enctypes = enctypes;
> +		}
> +	} else {
> +		printerr(2, "%s: using enctypes from the kernel\n", __func__);
> +		num_set_enctypes = num_krb5_enctypes;
> +		set_enctypes = krb5_enctypes;
> +	}
> +
> +	maj_stat = gss_set_allowable_enctypes(&min_stat, sec->cred,
> +				&krb5oid, num_set_enctypes, set_enctypes);
>   
>   	if (maj_stat != GSS_S_COMPLETE) {
>   		pgsserr("gss_set_allowable_enctypes",
> diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
> index 7ef87018..40ad3233 100644
> --- a/utils/gssd/krb5_util.h
> +++ b/utils/gssd/krb5_util.h
> @@ -27,6 +27,7 @@ int gssd_k5_remove_bad_service_cred(char *srvname);
>   #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
>   extern int limit_to_legacy_enctypes;
>   int limit_krb5_enctypes(struct rpc_gss_sec *sec);
> +int get_allowed_enctypes(void);
>   #endif
>   
>   /*


