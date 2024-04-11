Return-Path: <linux-nfs+bounces-2757-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A545A8A1C50
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 19:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF501F28874
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986C3398A;
	Thu, 11 Apr 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoLjHcev"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73244134A6
	for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852173; cv=none; b=N8fC1/0V/OPghJhsANYjvPOQC6gLQgm7RXO7cAgmWp8cop8y5gU4RWOzFc5qNZpNKsqOHbIIwa+R1Z58dcHmgXeRZYi5WBcKensMsPGZcH9BlkwUYeQkJT0wSEwP6E+lDP8WrlTyvuTiuv3EcE5vtsGOMAJz0B9HFilSrkGRHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852173; c=relaxed/simple;
	bh=wbSHSSi4F0Fk7k7LZKYoWBzeviPqw1MaS1tvtZVdn2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RkCij3invqveedu2nokTJsCDuZD1n5GTJjhwYplitqfy1iy8FkGq4XxfsO1ArbJ6PRkZ47y0aPD/F5bQn79G9LhFn6BCbcfqnwBaG8hKNg+3BnjYgLAEH6wwWPAUv/Bly+cY+sREx07k6WSdgiO+nP9jKZ2Fe2zCvCllrLXkgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoLjHcev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712852170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uck/ANEbrFYSLJ0qt2mHGMKG0QO7O/FVUZqmLouuHuQ=;
	b=IoLjHcevOGN+mkrduDREfH9uE/HaBIuy182/xoTZ137Zo+WSf7H7F5EQKBl+amM0siA6X2
	Rv21dFgr8is13LLI5A3+5FONCRVHZULCtfp+vOwLfc43sej2gan6p4uR8Od4lU1C0irDl1
	H3lX3BR22AjfA0AE46jcK7poSbnkRRw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-vQ1lQyIsNZ-ps_oRgkLcHw-1; Thu, 11 Apr 2024 12:16:08 -0400
X-MC-Unique: vQ1lQyIsNZ-ps_oRgkLcHw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69b147e856aso149766d6.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 09:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852167; x=1713456967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uck/ANEbrFYSLJ0qt2mHGMKG0QO7O/FVUZqmLouuHuQ=;
        b=vWC3hRSkohWBZglVZVVPD89jPIEZWNg5HIhKFi/IhlYbea1cswbUEilHWIK5EUFSRs
         J+CdV3Tkavz5Q6jBkIlexXQAGTjdyCCF1vkqbip2kwN4+P07Nv1Ial/LW6dVBTfV/3yZ
         cVVzCbw3A0cM5JgNA9yWj27TeExBTOe0bRFh68/mFzWWmLo9YBqiNFtbgmB7Kj6D0tAX
         cnHjb7+tiVqNgndvqTH8z2lxnC75UzyB5Fu6Kcp1AN4WuvaO92cm+3tBrj9oUh12GW0g
         bcjcfUJcvNjB34Jez4Oiioi/9J8BR8E1zhQre9vpSw6YC2d5291xSxlJqMrDo1AoT2tl
         FzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbEESMnYYmPFGVHJYAexlUBHKQJ25XnGx9QmSGxU9FBW/v37ckfZCStxwwuUStCXTfvGlCtX6xpuhfFandmXlZ+U9n1C6H9urL
X-Gm-Message-State: AOJu0YzvBOarxYaBvmcdXvrqSyCaShYYaaXFBWffaVUUOQv7jOOrXijI
	veZEA5cgBZV3qFIqaTeJ/mvq1+KOyAAx06rTUih0MTdEso9Xbtr/aZLWr3jAzXdyRp3Q4W6cHa9
	szYqsz2GdDS5SuJ4NLMep5D0BROTc+x5qt2eVAKe3jN7E/yHb+saV3UFz0umSttmZmg==
X-Received: by 2002:a05:6214:2b09:b0:699:2f11:384f with SMTP id jx9-20020a0562142b0900b006992f11384fmr182002qvb.2.1712852166905;
        Thu, 11 Apr 2024 09:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDWKlyjSN9gAKUoc7usYHQwPkvwULM8Tz0qRq8G278D83QgXNbznVRETlkk0ocqELrRDfWmw==
X-Received: by 2002:a05:6214:2b09:b0:699:2f11:384f with SMTP id jx9-20020a0562142b0900b006992f11384fmr181981qvb.2.1712852166475;
        Thu, 11 Apr 2024 09:16:06 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id pr1-20020a056214140100b0069b4ddcbd42sm793365qvb.0.2024.04.11.09.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:16:05 -0700 (PDT)
Message-ID: <e3215ebb-495a-4759-9a84-536d0a68c414@redhat.com>
Date: Thu, 11 Apr 2024 12:16:04 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gssd: use printf format specifiers in printerr
To: Dan McGregor <dan.mcgregor@usask.ca>, linux-nfs@vger.kernel.org
References: <20240401215413.1188898-1-dan.mcgregor@usask.ca>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240401215413.1188898-1-dan.mcgregor@usask.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/1/24 5:54 PM, Dan McGregor wrote:
> The printerr function takes a printf format specifier, tell the compiler
> about that. This adds the ability for GCC to warn about misuses, and
> prevents Clang from warning on the implementation.
> 
> Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
> ---
>   utils/gssd/err_util.h     |  2 +-
>   utils/gssd/gss_names.c    |  4 ++--
>   utils/gssd/gss_util.c     |  2 +-
>   utils/gssd/gssd.c         |  4 ++--
>   utils/gssd/gssd_proc.c    |  8 ++++----
>   utils/gssd/krb5_util.c    | 10 +++++-----
>   utils/gssd/svcgssd_proc.c |  8 ++++----
>   7 files changed, 19 insertions(+), 19 deletions(-)
Committed... (tag: nfs-utils-2-7-1-rc6)

steved.
> 
> diff --git a/utils/gssd/err_util.h b/utils/gssd/err_util.h
> index 6fa9d3d7..61f5a31f 100644
> --- a/utils/gssd/err_util.h
> +++ b/utils/gssd/err_util.h
> @@ -32,7 +32,7 @@
>   #define _ERR_UTIL_H_
>   
>   void initerr(char *progname, int verbosity, int fg);
> -void printerr(int priority, char *format, ...);
> +void printerr(int priority, char *format, ...) __attribute__ ((format (printf, 2, 3)));
>   int get_verbosity(void);
>   char * sec2time(int);
>   
> diff --git a/utils/gssd/gss_names.c b/utils/gssd/gss_names.c
> index 982b96f4..0548c33f 100644
> --- a/utils/gssd/gss_names.c
> +++ b/utils/gssd/gss_names.c
> @@ -65,7 +65,7 @@ get_krb5_hostbased_name(gss_buffer_desc *name, char **hostbased_name)
>   	if (strchr(name->value, '@') && strchr(name->value, '/')) {
>   		if ((sname = calloc(name->length, 1)) == NULL) {
>   			printerr(0, "ERROR: get_krb5_hostbased_name failed "
> -				 "to allocate %d bytes\n", name->length);
> +				 "to allocate %zd bytes\n", name->length);
>   			return -1;
>   		}
>   		/* read in name and instance and replace '/' with '@' */
> @@ -102,7 +102,7 @@ get_hostbased_client_name(gss_name_t client_name, gss_OID mech,
>   	}
>   	if (name.length >= 0xffff) {	    /* don't overflow */
>   		printerr(0, "ERROR: get_hostbased_client_name: "
> -			 "received gss_name is too long (%d bytes)\n",
> +			 "received gss_name is too long (%zd bytes)\n",
>   			 name.length);
>   		goto out_rel_buf;
>   	}
> diff --git a/utils/gssd/gss_util.c b/utils/gssd/gss_util.c
> index a4b27779..7d41a94d 100644
> --- a/utils/gssd/gss_util.c
> +++ b/utils/gssd/gss_util.c
> @@ -304,7 +304,7 @@ gssd_acquire_cred(char *server_name, const gss_OID oid)
>   				target_name, &pbuf, NULL);
>   		if (ignore_maj_stat == GSS_S_COMPLETE) {
>   			printerr(1, "Unable to obtain credentials for '%.*s'\n",
> -				 pbuf.length, pbuf.value);
> +				 (int)pbuf.length, (char *)pbuf.value);
>   			ignore_maj_stat = gss_release_buffer(&ignore_min_stat,
>   							     &pbuf);
>   		}
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index 10c731ab..d7a28225 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -559,9 +559,9 @@ scan_active_thread_list(void)
>   					do_error_downcall(info->fd, info->uid, -ETIMEDOUT);
>   				} else {
>   					if (!(info->flags & UPCALL_THREAD_WARNED)) {
> -						printerr(0, "watchdog: thread id 0x%lx running for %ld seconds\n",
> +						printerr(0, "watchdog: thread id 0x%lx running for %lld seconds\n",
>   								info->tid,
> -								now.tv_sec - info->timeout.tv_sec + upcall_timeout);
> +								(long long int)(now.tv_sec - info->timeout.tv_sec + upcall_timeout));
>   						info->flags |= UPCALL_THREAD_WARNED;
>   					}
>   				}
> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> index 7629de0b..2ad84c59 100644
> --- a/utils/gssd/gssd_proc.c
> +++ b/utils/gssd/gssd_proc.c
> @@ -171,7 +171,7 @@ do_downcall(int k5_fd, uid_t uid, struct authgss_private_data *pd,
>   
>   	if (get_verbosity() > 1)
>   		printerr(2, "do_downcall(0x%lx): lifetime_rec=%s acceptor=%.*s\n",
> -			tid, sec2time(lifetime_rec), acceptor->length, acceptor->value);
> +			tid, sec2time(lifetime_rec), (int)acceptor->length, (char *)acceptor->value);
>   	buf_size = sizeof(uid) + sizeof(timeout) + sizeof(pd->pd_seq_win) +
>   		sizeof(pd->pd_ctx_hndl.length) + pd->pd_ctx_hndl.length +
>   		sizeof(context_token->length) + context_token->length +
> @@ -287,14 +287,14 @@ populate_port(struct sockaddr *sa, const socklen_t salen,
>   
>   	port = nfs_getport(sa, salen, program, version, protocol);
>   	if (!port) {
> -		printerr(0, "ERROR: unable to obtain port for prog %ld "
> -			    "vers %ld\n", program, version);
> +		printerr(0, "ERROR: unable to obtain port for prog %lu "
> +			    "vers %lu\n", (long unsigned int)program, (long unsigned int)version);
>   		return 0;
>   	}
>   
>   set_port:
>   	printerr(2, "DEBUG: setting port to %hu for prog %lu vers %lu\n", port,
> -		 program, version);
> +		 (long unsigned int)program, (long unsigned int)version);
>   
>   	switch (sa->sa_family) {
>   	case AF_INET:
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 57b3cf8a..d7116d93 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -307,9 +307,9 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
>   				score++;
>   
>   			printerr(3, "CC '%s'(%s@%s) passed all checks and"
> -				    " has mtime of %u\n",
> +				    " has mtime of %llu\n",
>   				 buf, princname, realm,
> -				 tmp_stat.st_mtime);
> +				 (long long unsigned)tmp_stat.st_mtime);
>   			/*
>   			 * if more than one match is found, return the most
>   			 * recent (the one with the latest mtime), and
> @@ -344,10 +344,10 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
>   				}
>   				printerr(3, "CC '%s:%s/%s' is our "
>   					    "current best match "
> -					    "with mtime of %u\n",
> -					 cctype, dirname,
> +					    "with mtime of %llu\n",
> +					 *cctype, dirname,
>   					 best_match_dir->d_name,
> -					 best_match_stat.st_mtime);
> +					 (long long unsigned)best_match_stat.st_mtime);
>   			}
>   			free(princname);
>   			free(realm);
> diff --git a/utils/gssd/svcgssd_proc.c b/utils/gssd/svcgssd_proc.c
> index b4031432..7fecd1aa 100644
> --- a/utils/gssd/svcgssd_proc.c
> +++ b/utils/gssd/svcgssd_proc.c
> @@ -102,10 +102,10 @@ do_svc_downcall(gss_buffer_desc *out_handle, struct svc_cred *cred,
>   	qword_addint(&bp, &blen, cred->cr_uid);
>   	qword_addint(&bp, &blen, cred->cr_gid);
>   	qword_addint(&bp, &blen, cred->cr_ngroups);
> -	printerr(2, "mech: %s, hndl len: %d, ctx len %d, timeout: %d (%d from now), "
> +	printerr(2, "mech: %s, hndl len: %zd, ctx len %zd, timeout: %lld (%lld from now), "
>   		 "clnt: %s, uid: %d, gid: %d, num aux grps: %d:\n",
>   		 fname, out_handle->length, context_token->length,
> -		 endtime, endtime - time(0),
> +		 (long long int)endtime, (long long int)(endtime - time(0)),
>   		 client_name ? client_name : "<null>",
>   		 cred->cr_uid, cred->cr_gid, cred->cr_ngroups);
>   	for (i=0; i < cred->cr_ngroups; i++) {
> @@ -232,7 +232,7 @@ get_ids(gss_name_t client_name, gss_OID mech, struct svc_cred *cred)
>   	}
>   	if (name.length >= 0xffff || /* be certain name.length+1 doesn't overflow */
>   	    !(sname = calloc(name.length + 1, 1))) {
> -		printerr(0, "WARNING: get_ids: error allocating %d bytes "
> +		printerr(0, "WARNING: get_ids: error allocating %zd bytes "
>   			"for sname\n", name.length + 1);
>   		gss_release_buffer(&min_stat, &name);
>   		goto out;
> @@ -360,7 +360,7 @@ handle_nullreq(char *cp) {
>   	if (in_handle.length != 0) { /* CONTINUE_INIT case */
>   		if (in_handle.length != sizeof(ctx)) {
>   			printerr(0, "WARNING: handle_nullreq: "
> -				    "input handle has unexpected length %d\n",
> +				    "input handle has unexpected length %zd\n",
>   				    in_handle.length);
>   			goto out_err;
>   		}


