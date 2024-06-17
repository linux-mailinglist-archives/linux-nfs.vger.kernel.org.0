Return-Path: <linux-nfs+bounces-3939-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ACD90BB65
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 21:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32451C21E77
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673CF16B3BA;
	Mon, 17 Jun 2024 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBJzTJBf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457ECD53E
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653917; cv=none; b=sJItuB3o6h7xl28mhjmMqPKrBjSD8yZGOjsAqXm0t44stAxJDCkjFG0CXpy4whQbNr9L0TTBIr/dvh6XfCEqPoLLyVLa5G1CROdSFiLXl2mScIKPFjhhgU2GA7aiSyjtLBtR7KTtGenBMVqwuGD7W0gA9Xn1sKeG/EPggl1qWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653917; c=relaxed/simple;
	bh=cIbAgHbQUZQyZSQe4mm3m9Ma9bYPu/H+yUmWPvRAwVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pjAV11pD9uFO91oox1+wqmKeE10/RYfRU0NW+4HQf7cGW8CM6vbMFpfAGHRoiA/5+3HQW8OwonBBvC8tT+r9dHLw3mj5KvcyKKiw9i1m5Ii616Ir1H5fNSPlHh5e/mYu6nM4BF4nJRbYRbzd6u9+ljLUzwv/48DvpmW/VVh7AOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBJzTJBf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718653914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0W4DsXeIU7lYx8OSMnrszIWYGUQ78DdDMqlnUUftYd0=;
	b=TBJzTJBfeDBxMM2jDOlXO+9o312bHhucUohANSvVNad+IXCdPi6I43EeFddKFZBMQfq7vG
	MXuGdZEcnQ+eYfTeJQ+Qh17I5F9uoa/w8l54Vh1sXpnT0yA7peTb+6bwTgpFFuE0DB/0gd
	xVb4BIutrSvsO4qwjmvTWYChzlngr00=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-nw6lOQAHNxWRoMIRoeqpoQ-1; Mon, 17 Jun 2024 15:51:52 -0400
X-MC-Unique: nw6lOQAHNxWRoMIRoeqpoQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-797a903cf8fso100491985a.2
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 12:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718653911; x=1719258711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W4DsXeIU7lYx8OSMnrszIWYGUQ78DdDMqlnUUftYd0=;
        b=axWVdqfwBpeh0Auoe5lim1wzRWJQFAsSdgzCQcLb3Hy0Mu56Md/CiyEDJ1aQ4bCxFX
         EVY2X9ZrfRjrwst37bE+qjrjQearEEXsKIc4wAofTql0WMNg64Lu07eB+Co2bHLAAWcH
         Za5edn8ngHCMwW+mgvfjHZsTS1LGhEbmGv5koqQzDdJUKm6c6eODj7W1qR47ixV2Vhoo
         ijPx6tcTlNW05VbIUkkWLHxQKhauj+YxQo/1dcknN/m6qVv7KJ1/OODA0NesAS6qkzgz
         81Yc6aTetPl9Vfubg5ajO+zZOh6i4cuTqndKfv5tAE09Y/uM/up3uhK+lfj0qxpx6sL0
         uoPA==
X-Forwarded-Encrypted: i=1; AJvYcCVQWIvCeM0hk+zd/xyFFPUp9yLXkKh7AkMPyW+tPFwOEt3JDYubn4ThqdmXLRC7c2TuOd0X0obJ3tKHDtl6EbMNWg9GGSXTawxu
X-Gm-Message-State: AOJu0Ywv0RRTcGLt7SNMTpUNEAoTSjMtcNFXi8tjMl3zPvbBjbP6xZrq
	HfG1UtgEzGeLXLQdTgRsn6BMDgklEQidQ8KbJZT/vChneEEc37uNQnw4FHmdg7LK+gQn3vpKoNL
	MM/t558z3rtis4RaqK+LzhjzHM4i1CXxDS9supDUm+lbT2GAmCA6ycZjIV93yijv7GA==
X-Received: by 2002:a05:6214:2303:b0:6b2:c5f1:425a with SMTP id 6a1803df08f44-6b2c5f145c1mr72154726d6.6.1718653910682;
        Mon, 17 Jun 2024 12:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/QsfEjHtJ1wC/mSiUL6vnZIoqNLrBt/npKzz0yYHPHgzYVUuVUmhT9tAeEUCXjTbFhN9Htg==
X-Received: by 2002:a05:6214:2303:b0:6b2:c5f1:425a with SMTP id 6a1803df08f44-6b2c5f145c1mr72154546d6.6.1718653910312;
        Mon, 17 Jun 2024 12:51:50 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:165d:3a00:4ce9:ee1f? ([2603:6000:d605:db00:165d:3a00:4ce9:ee1f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4a9csm58493916d6.80.2024.06.17.12.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 12:51:49 -0700 (PDT)
Message-ID: <d7165359-a031-456e-bfae-a45d0aed5d80@redhat.com>
Date: Mon, 17 Jun 2024 14:51:48 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add guards around [nfsidmap] usages of [sysconf].
To: =?UTF-8?Q?Bogdan-Cristian_T=C4=83t=C4=83roiu?= <b.tataroiu@gmail.com>,
 linux-nfs@vger.kernel.org
References: <20240530071725.70043-1-b.tataroiu@gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240530071725.70043-1-b.tataroiu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/30/24 2:17 AM, Bogdan-Cristian Tătăroiu wrote:
> sysconf(_SC_GETPW_R_SIZE_MAX) and sysconf(_SC_GETGR_R_SIZE_MAX)
> return -1 on musl, which causes either segmentation faults or ENOMEM
> errors.
Actually sysconf() returns EINVAL not -1 since the return
value is a size_t (unsigned long). So I needed to change

     size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
     if (buflen == EINVAL) <<< this from -1 to EINVAL
         buflen = 16384;
     return buflen;

Good with that? Will this work with musl?

steved.

> 
> Replace all usages of sysconf with dedicated methods that guard against
> a result of -1.
> 
> Signed-off-by: Bogdan-Cristian Tătăroiu <b.tataroiu@gmail.com>
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
> index 4d2cb14f..310c68f0 100644
> --- a/support/nfsidmap/nfsidmap_common.c
> +++ b/support/nfsidmap/nfsidmap_common.c
> @@ -116,3 +116,19 @@ int get_reformat_group(void)
>   
>   	return reformat_group;
>   }
> +
> +size_t get_pwnam_buflen(void)
> +{
> +	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +	if (buflen == -1)
> +		buflen = 16384;
> +	return buflen;
> +}
> +
> +size_t get_grnam_buflen(void)
> +{
> +	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
> +	if (buflen == -1)
> +		buflen = 16384;
> +	return buflen;
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


