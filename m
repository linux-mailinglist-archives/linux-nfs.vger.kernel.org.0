Return-Path: <linux-nfs+bounces-8450-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5A39E901D
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 11:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22CF2807BD
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F2E216611;
	Mon,  9 Dec 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aK/PGAfW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22D2165E2
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740057; cv=none; b=i4P0F3qLZd0F+eL55wPfs6USvDCrCAtnlC3tkqehtDlLVp+wHZJi+fA2j/hDAOnQD2W4cwAKl0sevb+vEuf5qJfpFsKoUDZ/Wx6RoMDhrDouQvv0475IoZE0p3UlQmKp9kNdWA4Q5JvKVkePIXmWSTNuRIg3A3ucwEif4TWIr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740057; c=relaxed/simple;
	bh=TeLYHMG43cL800Vy3eextdpTj9Rd27Xvjaswt1emzqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CTMSrFWUG8RN2EqoP8H7BDTTl1+avxUEh8XPXZBb3Gw9KB3EJlNseSIewJJ5kHmbd3nBxncIn6koXFTSWxm+uFn+Tg0dZMnCK1G8B3+2nFTN29uPfcxVPliUz2mWbTyDLKw8kcIaa3rAtAv+3WUKRhEwHLG++kSHqhefBCbp+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aK/PGAfW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733740054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SDqIqgUU1e+jNyD5RUHVOTDvEN6uRHkgKA2I1oCW4k=;
	b=aK/PGAfWn5SzL675yoOcs5ETUrf8xlARnuQePT0vqH1CAhR89OKJkLr1KSn064eMc0A8c+
	S2etF5UcKruPvbFmVBagwVtb8nc4M2jgJCYvoAOFB5g8ySOtnyvK72YNsVewLiMNGIKH30
	c9hoq0HFqOEfHLVjxZ/aQoaN5NnN9d0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-tgAxSg8pPt-LSQLy3IVSSg-1; Mon, 09 Dec 2024 05:27:32 -0500
X-MC-Unique: tgAxSg8pPt-LSQLy3IVSSg-1
X-Mimecast-MFC-AGG-ID: tgAxSg8pPt-LSQLy3IVSSg
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6cb7f88e2so58741085a.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Dec 2024 02:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733740052; x=1734344852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SDqIqgUU1e+jNyD5RUHVOTDvEN6uRHkgKA2I1oCW4k=;
        b=WnpxM4RTf6rryatmbN+8t5fgJwYY/vnO+DGS1NyQM6bWiHv/E7+dAwdO2worHQn5Yy
         ZE746B0Mc2GztppJKlGKMd8NFgen30DwCiHxuOnyBuGuT70FKF9vX1t5sOvVmdHem8Mr
         /6TEPfh0RsOw327YXsmxCwdoqLTrgVVwsvo774wnMF+UMEHYe5ct8n56sy79ajLwdTEE
         33Y3hDU7dssPqWVwyV5S7kZEFN7udpIPI3xtH68qk4nISZIxiGsPq1u1riJ9coQnUs/c
         nKrEwzOXo63L2gQ1qANM8dvUyz3FDxo3VgqaQzr900Rpk4NmZTu9lLM+RpQaGWM9QJol
         luRA==
X-Forwarded-Encrypted: i=1; AJvYcCUyl4zeO/ScskBbf9lPTmKNEoTnoIMCMGseLcsTW4mgd/XA2/Gt5MvIdWzRaLSWDiC6WQ2FTOF10Os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4VU4S7pvc2W8IWwqZn/171DjA1PlmLaB/cR/mDq+ZgYZWgVzD
	Z8s1J/uI/CUsPgnfxjmiy2AYW1PO7DdawnFrC6x90p1RskVrbcLb8+5uFckfUf13msPP9dofjtA
	RnRQWuRRfRKj2QaNKOVM2fKOgDYoLMwfUMVjtyW5UaxMp7nSVcuU8JjUgJA==
X-Gm-Gg: ASbGncsLgljvtvxQZYimPjsJE2uOgFOrwJdazpEozZuAk97cRriIhyJA+rG1X5HSWZg
	vSuUDe8tHOMhG0aPU/6H3t/d97Q7aXTAdRE4hvQ6BMZJvesb98vgG944YFABsKS7yq8asrpyOiP
	BE7oMXz8/ccw1+hqUw3uhzWT+aEKE4gR2f4eZXl2rHRKw/h60F12q2OTOw+JRS+jXwJngC4mmcz
	H3pfezpXnNbJSKhPP/q5Z/OkobmoMKO2YmNB/y/ZoOvB5Va4g==
X-Received: by 2002:a05:620a:600a:b0:7b6:d3b3:5757 with SMTP id af79cd13be357-7b6d3b35858mr573027785a.13.1733740052350;
        Mon, 09 Dec 2024 02:27:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa1OIlAk4gLUvnHOduVviuk2Qs0uN8F3rO65JxoIIEoKOM8bAWHDki0lFM1ln/1rDhc2tvWA==
X-Received: by 2002:a05:620a:600a:b0:7b6:d3b3:5757 with SMTP id af79cd13be357-7b6d3b35858mr573023385a.13.1733740051779;
        Mon, 09 Dec 2024 02:27:31 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a671afsm427917885a.62.2024.12.09.02.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 02:27:30 -0800 (PST)
Message-ID: <354319ae-76d7-40d4-a713-3bb569579e5c@redhat.com>
Date: Mon, 9 Dec 2024 05:27:29 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Add guards around [nfsidmap] usages of [sysconf].
To: Bogdan-Cristian Ttroiu <b.tataroiu@gmail.com>,
 Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20241201153637.449538-1-b.tataroiu@gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241201153637.449538-1-b.tataroiu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/1/24 10:36 AM, Bogdan-Cristian Ttroiu wrote:
> From: Bogdan-Cristian Tătăroiu <b.tataroiu@gmail.com>
> 
> sysconf(_SC_GETPW_R_SIZE_MAX) and sysconf(_SC_GETGR_R_SIZE_MAX)
> return -1 on musl, which causes either segmentation faults or ENOMEM
> errors.
> 
> Replace all usages of sysconf with dedicated methods that guard against
> a result of -1.
Committed... (tag: nfs-utils-2-8-2-rc4)

steved.

> ---
>   support/nfsidmap/gums.c             |  4 ++--
>   support/nfsidmap/libnfsidmap.c      |  4 ++--
>   support/nfsidmap/nfsidmap_common.c  | 16 ++++++++++++++++
>   support/nfsidmap/nfsidmap_private.h |  2 ++
>   support/nfsidmap/nss.c              |  8 ++++----
>   support/nfsidmap/regex.c            |  9 +++++----
>   support/nfsidmap/static.c           |  5 +++--
>   7 files changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/support/nfsidmap/gums.c b/support/nfsidmap/gums.c
> index 1d6eb318..e94a4c50 100644
> --- a/support/nfsidmap/gums.c
> +++ b/support/nfsidmap/gums.c
> @@ -475,7 +475,7 @@ static int translate_to_uid(char *local_uid, uid_t *uid, uid_t *gid)
>   	int ret = -1;
>   	struct passwd *pw = NULL;
>   	struct pwbuf *buf = NULL;
> -	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +	size_t buflen = get_pwnam_buflen();
>   
>   	buf = malloc(sizeof(*buf) + buflen);
>   	if (buf == NULL)
> @@ -501,7 +501,7 @@ static int translate_to_gid(char *local_gid, uid_t *gid)
>   	struct group *gr = NULL;
>   	struct group grbuf;
>   	char *buf = NULL;
> -	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
> +	size_t buflen = get_grnam_buflen();
>   	int ret = -1;
>   
>   	do {
> diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
> index f8c36480..e1475879 100644
> --- a/support/nfsidmap/libnfsidmap.c
> +++ b/support/nfsidmap/libnfsidmap.c
> @@ -457,7 +457,7 @@ int nfs4_init_name_mapping(char *conffile)
>   
>   	nobody_user = conf_get_str("Mapping", "Nobody-User");
>   	if (nobody_user) {
> -		size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +		size_t buflen = get_pwnam_buflen();
>   		struct passwd *buf;
>   		struct passwd *pw = NULL;
>   		int err;
> @@ -478,7 +478,7 @@ int nfs4_init_name_mapping(char *conffile)
>   
>   	nobody_group = conf_get_str("Mapping", "Nobody-Group");
>   	if (nobody_group) {
> -		size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
> +		size_t buflen = get_grnam_buflen();
>   		struct group *buf;
>   		struct group *gr = NULL;
>   		int err;
> diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/nfsidmap_common.c
> index 4d2cb14f..1d5b542b 100644
> --- a/support/nfsidmap/nfsidmap_common.c
> +++ b/support/nfsidmap/nfsidmap_common.c
> @@ -116,3 +116,19 @@ int get_reformat_group(void)
>   
>   	return reformat_group;
>   }
> +
> +size_t get_pwnam_buflen(void)
> +{
> +	long buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +	if (buflen == -1)
> +		buflen = 16384;
> +	return (size_t)buflen;
> +}
> +
> +size_t get_grnam_buflen(void)
> +{
> +	long buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
> +	if (buflen == -1)
> +		buflen = 16384;
> +	return (size_t)buflen;
> +}
> diff --git a/support/nfsidmap/nfsidmap_private.h b/support/nfsidmap/nfsidmap_private.h
> index a5cb6dda..234ca9d4 100644
> --- a/support/nfsidmap/nfsidmap_private.h
> +++ b/support/nfsidmap/nfsidmap_private.h
> @@ -40,6 +40,8 @@ struct conf_list *get_local_realms(void);
>   void free_local_realms(void);
>   int get_nostrip(void);
>   int get_reformat_group(void);
> +size_t get_pwnam_buflen(void);
> +size_t get_grnam_buflen(void);
>   
>   typedef enum {
>   	IDTYPE_USER = 1,
> diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
> index 0f43076e..3fc045dc 100644
> --- a/support/nfsidmap/nss.c
> +++ b/support/nfsidmap/nss.c
> @@ -91,7 +91,7 @@ static int nss_uid_to_name(uid_t uid, char *domain, char *name, size_t len)
>   	struct passwd *pw = NULL;
>   	struct passwd pwbuf;
>   	char *buf;
> -	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +	size_t buflen = get_pwnam_buflen();
>   	int err = -ENOMEM;
>   
>   	buf = malloc(buflen);
> @@ -119,7 +119,7 @@ static int nss_gid_to_name(gid_t gid, char *domain, char *name, size_t len)
>   	struct group *gr = NULL;
>   	struct group grbuf;
>   	char *buf;
> -	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
> +	size_t buflen = get_grnam_buflen();
>   	int err;
>   
>   	if (domain == NULL)
> @@ -192,7 +192,7 @@ static struct passwd *nss_getpwnam(const char *name, const char *domain,
>   {
>   	struct passwd *pw;
>   	struct pwbuf *buf;
> -	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +	size_t buflen = get_pwnam_buflen();
>   	char *localname;
>   	int err = ENOMEM;
>   
> @@ -301,7 +301,7 @@ static int _nss_name_to_gid(char *name, gid_t *gid, int dostrip)
>   	struct group *gr = NULL;
>   	struct group grbuf;
>   	char *buf, *domain;
> -	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
> +	size_t buflen = get_grnam_buflen();
>   	int err = -EINVAL;
>   	char *localname = NULL;
>   	char *ref_name = NULL;
> diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
> index 8424179f..ea094b95 100644
> --- a/support/nfsidmap/regex.c
> +++ b/support/nfsidmap/regex.c
> @@ -46,6 +46,7 @@
>   
>   #include "nfsidmap.h"
>   #include "nfsidmap_plugin.h"
> +#include "nfsidmap_private.h"
>   
>   #define CONFIG_GET_STRING nfsidmap_config_get
>   extern const char *nfsidmap_config_get(const char *, const char *);
> @@ -95,7 +96,7 @@ static struct passwd *regex_getpwnam(const char *name, const char *UNUSED(domain
>   {
>   	struct passwd *pw;
>   	struct pwbuf *buf;
> -	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +	size_t buflen = get_pwnam_buflen();
>   	char *localname;
>   	size_t namelen;
>   	int err;
> @@ -175,7 +176,7 @@ static struct group *regex_getgrnam(const char *name, const char *UNUSED(domain)
>   {
>   	struct group *gr;
>   	struct grbuf *buf;
> -	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
> +	size_t buflen = get_grnam_buflen();
>   	char *localgroup;
>   	char *groupname;
>   	size_t namelen;
> @@ -366,7 +367,7 @@ static int regex_uid_to_name(uid_t uid, char *domain, char *name, size_t len)
>   	struct passwd *pw = NULL;
>   	struct passwd pwbuf;
>   	char *buf;
> -	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +	size_t buflen = get_pwnam_buflen();
>   	int err = -ENOMEM;
>   
>   	buf = malloc(buflen);
> @@ -392,7 +393,7 @@ static int regex_gid_to_name(gid_t gid, char *UNUSED(domain), char *name, size_t
>   	struct group grbuf;
>   	char *buf;
>       const char *name_prefix;
> -	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
> +	size_t buflen = get_grnam_buflen();
>   	int err;
>       char * groupname = NULL;
>   
> diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
> index 8ac4a398..395cac06 100644
> --- a/support/nfsidmap/static.c
> +++ b/support/nfsidmap/static.c
> @@ -44,6 +44,7 @@
>   #include "conffile.h"
>   #include "nfsidmap.h"
>   #include "nfsidmap_plugin.h"
> +#include "nfsidmap_private.h"
>   
>   /*
>    * Static Translation Methods
> @@ -98,7 +99,7 @@ static struct passwd *static_getpwnam(const char *name,
>   {
>   	struct passwd *pw;
>   	struct pwbuf *buf;
> -	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +	size_t buflen = get_pwnam_buflen();
>   	char *localname;
>   	int err;
>   
> @@ -149,7 +150,7 @@ static struct group *static_getgrnam(const char *name,
>   {
>   	struct group *gr;
>   	struct grbuf *buf;
> -	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
> +	size_t buflen = get_grnam_buflen();
>   	char *localgroup;
>   	int err;
>   


