Return-Path: <linux-nfs+bounces-7822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C649C2F10
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 19:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFEE2820A7
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58C213D503;
	Sat,  9 Nov 2024 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WW14b7KM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008CF29CF4
	for <linux-nfs@vger.kernel.org>; Sat,  9 Nov 2024 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176726; cv=none; b=WEZ2o8eEE5P3If2aXpITD7wH/Jx83XvMkM6C4q5CilmETlzb5c4id5O9VVzJPsq4Up8frTbtuooBxDAQOZZvaiSCQL98J4r81UJ7JTj6uQal0uJaX7xKbucA7MTkm7mw3cmeeUcGTWmN73Zpsei7Higg2UZkaduPok3OU+/X5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176726; c=relaxed/simple;
	bh=y7EnbSz1DNu9DrNliA1SXpVxabQmrsisZEhHD2/0CRw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=grkXwtyk6smCW4QzWsc2MkMkyW0Tflw3eX6/r7xcEOfOIMmc9UikDusPYy6RWNiDqTJyFVCDR4uuKY/ZR7obiRaYgNO+7+LwapLjx9gjYuVtON6RwAoizApS0b+nidpvdjIBWDoNcvfLngWozm9zU9mkuaEiAW83csKFVq/j4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WW14b7KM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731176722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YhzSFOTYaXSbZM/SRixUUEocYaYxpT/oj/HxntOCaU=;
	b=WW14b7KMlOVAQNTeDNAtOGYldLy9GQKEkZJ33EnMZEXHZVDrgO6tn1HQ/R4FXtNAJ8k945
	ZCU+Ulx2IxU38fm8btgA4Ft44LG5B0+3s+ZyGpaEvM/JXOikeJ06dC28baEZxapA923BrZ
	I3oDWdjkW4ZCHQbfZ0FaNBID1qi9i6I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-q4NqBlxvOL-sU9DoGiLIBQ-1; Sat, 09 Nov 2024 13:25:21 -0500
X-MC-Unique: q4NqBlxvOL-sU9DoGiLIBQ-1
X-Mimecast-MFC-AGG-ID: q4NqBlxvOL-sU9DoGiLIBQ
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbead8eb2bso46460216d6.3
        for <linux-nfs@vger.kernel.org>; Sat, 09 Nov 2024 10:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731176720; x=1731781520;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YhzSFOTYaXSbZM/SRixUUEocYaYxpT/oj/HxntOCaU=;
        b=ldtzeFKQmexqt0iOOoZJf2ixOTHXdxv9zQ4ZrbgosAIaSYXDcrN7YamYJ4oFQMskx7
         JS83zQh3/HFnCuYLAdoR2/DB41oBVzOJa1z0SE3IikM582GSvHjVoiGD+AcrMfImDfm0
         Nt3L2+bdVwijAtXAt634m2x9f8G6RjJMTlr4fkbtnuK/fXnN6/Xzxp9dUri8114rvaRQ
         5UpKj+WVQRdfzh6ifzOC1FcXc/EVquzNCCdSUzLpo0diVJTZh7QkZ5ZKRTKtWEVJBh7p
         7vEEM/n/mBi7AHRCCrk7XIj/RHnpk4WwFZZsuKYzQN4W676GiPWvwGbWKTl+JizibX6X
         2pFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv0kyJTNNzLBlLyBMALIMfwrZhrCbxlux2ulY7V3yodo9DVKBSAHYKITBeBb8IrKbgfWZK9OqqWV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXuRnFxhPsQpryr0fQYKyzPSk+b6qTGKTVMMeh9nEU8wA1ONrc
	6hj48Euwn8QWDr7BHcWooLayYfK1eeHUkZh3wy7Bvet9V+ccxufwbSRxs7lNfzT/VtReingxZVm
	6j4F6QVFq3PnvaB812RmOHT4fyiRcxoPRcgAeG3AhzPW66Wo3QDQXQNEWRg==
X-Received: by 2002:a05:6214:53c9:b0:6cb:f8e0:18a7 with SMTP id 6a1803df08f44-6d39e166e6cmr78396466d6.9.1731176720649;
        Sat, 09 Nov 2024 10:25:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVRCHByBoqG4diRF7mZ251UyxG3K3XkTrju8AsGEMZCrjQE12vSTE2qqJc3p/fMUOkjtbU/g==
X-Received: by 2002:a05:6214:53c9:b0:6cb:f8e0:18a7 with SMTP id 6a1803df08f44-6d39e166e6cmr78396246d6.9.1731176720206;
        Sat, 09 Nov 2024 10:25:20 -0800 (PST)
Received: from ?IPV6:2603:6000:d605:db00:d7de:cb5e:42f:cca3? ([2603:6000:d605:db00:d7de:cb5e:42f:cca3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ecdcbsm33949436d6.31.2024.11.09.10.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 10:25:18 -0800 (PST)
Message-ID: <fbd5e08d-3975-48e8-90b6-325628cb1b85@redhat.com>
Date: Sat, 9 Nov 2024 12:25:18 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add guards around [nfsidmap] usages of [sysconf].
From: Steve Dickson <steved@redhat.com>
To: =?UTF-8?Q?Bogdan-Cristian_T=C4=83t=C4=83roiu?= <b.tataroiu@gmail.com>,
 linux-nfs@vger.kernel.org
References: <20240530071725.70043-1-b.tataroiu@gmail.com>
 <d7165359-a031-456e-bfae-a45d0aed5d80@redhat.com>
Content-Language: en-US
In-Reply-To: <d7165359-a031-456e-bfae-a45d0aed5d80@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/17/24 2:51 PM, Steve Dickson wrote:
> 
> 
> On 5/30/24 2:17 AM, Bogdan-Cristian Tătăroiu wrote:
>> sysconf(_SC_GETPW_R_SIZE_MAX) and sysconf(_SC_GETGR_R_SIZE_MAX)
>> return -1 on musl, which causes either segmentation faults or ENOMEM
>> errors.
> Actually sysconf() returns EINVAL not -1 since the return
> value is a size_t (unsigned long). So I needed to change
> 
>      size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>      if (buflen == EINVAL) <<< this from -1 to EINVAL
>          buflen = 16384;
>      return buflen;
> 
> Good with that? Will this work with musl?
Just found this on my todo list... Still
interest in  have these patch committed?

steved.

> 
> steved.
> 
>>
>> Replace all usages of sysconf with dedicated methods that guard against
>> a result of -1.
>>
>> Signed-off-by: Bogdan-Cristian Tătăroiu <b.tataroiu@gmail.com>
>> ---
>>   support/nfsidmap/gums.c             |  4 ++--
>>   support/nfsidmap/libnfsidmap.c      |  4 ++--
>>   support/nfsidmap/nfsidmap_common.c  | 16 ++++++++++++++++
>>   support/nfsidmap/nfsidmap_private.h |  2 ++
>>   support/nfsidmap/nss.c              |  8 ++++----
>>   support/nfsidmap/regex.c            |  9 +++++----
>>   support/nfsidmap/static.c           |  5 +++--
>>   7 files changed, 34 insertions(+), 14 deletions(-)
>>
>> diff --git a/support/nfsidmap/gums.c b/support/nfsidmap/gums.c
>> index 1d6eb318..e94a4c50 100644
>> --- a/support/nfsidmap/gums.c
>> +++ b/support/nfsidmap/gums.c
>> @@ -475,7 +475,7 @@ static int translate_to_uid(char *local_uid, uid_t 
>> *uid, uid_t *gid)
>>       int ret = -1;
>>       struct passwd *pw = NULL;
>>       struct pwbuf *buf = NULL;
>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>> +    size_t buflen = get_pwnam_buflen();
>>       buf = malloc(sizeof(*buf) + buflen);
>>       if (buf == NULL)
>> @@ -501,7 +501,7 @@ static int translate_to_gid(char *local_gid, uid_t 
>> *gid)
>>       struct group *gr = NULL;
>>       struct group grbuf;
>>       char *buf = NULL;
>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>> +    size_t buflen = get_grnam_buflen();
>>       int ret = -1;
>>       do {
>> diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/ 
>> libnfsidmap.c
>> index f8c36480..e1475879 100644
>> --- a/support/nfsidmap/libnfsidmap.c
>> +++ b/support/nfsidmap/libnfsidmap.c
>> @@ -457,7 +457,7 @@ int nfs4_init_name_mapping(char *conffile)
>>       nobody_user = conf_get_str("Mapping", "Nobody-User");
>>       if (nobody_user) {
>> -        size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>> +        size_t buflen = get_pwnam_buflen();
>>           struct passwd *buf;
>>           struct passwd *pw = NULL;
>>           int err;
>> @@ -478,7 +478,7 @@ int nfs4_init_name_mapping(char *conffile)
>>       nobody_group = conf_get_str("Mapping", "Nobody-Group");
>>       if (nobody_group) {
>> -        size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>> +        size_t buflen = get_grnam_buflen();
>>           struct group *buf;
>>           struct group *gr = NULL;
>>           int err;
>> diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/ 
>> nfsidmap_common.c
>> index 4d2cb14f..310c68f0 100644
>> --- a/support/nfsidmap/nfsidmap_common.c
>> +++ b/support/nfsidmap/nfsidmap_common.c
>> @@ -116,3 +116,19 @@ int get_reformat_group(void)
>>       return reformat_group;
>>   }
>> +
>> +size_t get_pwnam_buflen(void)
>> +{
>> +    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>> +    if (buflen == -1)
>> +        buflen = 16384;
>> +    return buflen;
>> +}
>> +
>> +size_t get_grnam_buflen(void)
>> +{
>> +    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>> +    if (buflen == -1)
>> +        buflen = 16384;
>> +    return buflen;
>> +}
>> diff --git a/support/nfsidmap/nfsidmap_private.h b/support/nfsidmap/ 
>> nfsidmap_private.h
>> index a5cb6dda..234ca9d4 100644
>> --- a/support/nfsidmap/nfsidmap_private.h
>> +++ b/support/nfsidmap/nfsidmap_private.h
>> @@ -40,6 +40,8 @@ struct conf_list *get_local_realms(void);
>>   void free_local_realms(void);
>>   int get_nostrip(void);
>>   int get_reformat_group(void);
>> +size_t get_pwnam_buflen(void);
>> +size_t get_grnam_buflen(void);
>>   typedef enum {
>>       IDTYPE_USER = 1,
>> diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
>> index 0f43076e..3fc045dc 100644
>> --- a/support/nfsidmap/nss.c
>> +++ b/support/nfsidmap/nss.c
>> @@ -91,7 +91,7 @@ static int nss_uid_to_name(uid_t uid, char *domain, 
>> char *name, size_t len)
>>       struct passwd *pw = NULL;
>>       struct passwd pwbuf;
>>       char *buf;
>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>> +    size_t buflen = get_pwnam_buflen();
>>       int err = -ENOMEM;
>>       buf = malloc(buflen);
>> @@ -119,7 +119,7 @@ static int nss_gid_to_name(gid_t gid, char 
>> *domain, char *name, size_t len)
>>       struct group *gr = NULL;
>>       struct group grbuf;
>>       char *buf;
>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>> +    size_t buflen = get_grnam_buflen();
>>       int err;
>>       if (domain == NULL)
>> @@ -192,7 +192,7 @@ static struct passwd *nss_getpwnam(const char 
>> *name, const char *domain,
>>   {
>>       struct passwd *pw;
>>       struct pwbuf *buf;
>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>> +    size_t buflen = get_pwnam_buflen();
>>       char *localname;
>>       int err = ENOMEM;
>> @@ -301,7 +301,7 @@ static int _nss_name_to_gid(char *name, gid_t 
>> *gid, int dostrip)
>>       struct group *gr = NULL;
>>       struct group grbuf;
>>       char *buf, *domain;
>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>> +    size_t buflen = get_grnam_buflen();
>>       int err = -EINVAL;
>>       char *localname = NULL;
>>       char *ref_name = NULL;
>> diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
>> index 8424179f..ea094b95 100644
>> --- a/support/nfsidmap/regex.c
>> +++ b/support/nfsidmap/regex.c
>> @@ -46,6 +46,7 @@
>>   #include "nfsidmap.h"
>>   #include "nfsidmap_plugin.h"
>> +#include "nfsidmap_private.h"
>>   #define CONFIG_GET_STRING nfsidmap_config_get
>>   extern const char *nfsidmap_config_get(const char *, const char *);
>> @@ -95,7 +96,7 @@ static struct passwd *regex_getpwnam(const char 
>> *name, const char *UNUSED(domain
>>   {
>>       struct passwd *pw;
>>       struct pwbuf *buf;
>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>> +    size_t buflen = get_pwnam_buflen();
>>       char *localname;
>>       size_t namelen;
>>       int err;
>> @@ -175,7 +176,7 @@ static struct group *regex_getgrnam(const char 
>> *name, const char *UNUSED(domain)
>>   {
>>       struct group *gr;
>>       struct grbuf *buf;
>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>> +    size_t buflen = get_grnam_buflen();
>>       char *localgroup;
>>       char *groupname;
>>       size_t namelen;
>> @@ -366,7 +367,7 @@ static int regex_uid_to_name(uid_t uid, char 
>> *domain, char *name, size_t len)
>>       struct passwd *pw = NULL;
>>       struct passwd pwbuf;
>>       char *buf;
>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>> +    size_t buflen = get_pwnam_buflen();
>>       int err = -ENOMEM;
>>       buf = malloc(buflen);
>> @@ -392,7 +393,7 @@ static int regex_gid_to_name(gid_t gid, char 
>> *UNUSED(domain), char *name, size_t
>>       struct group grbuf;
>>       char *buf;
>>       const char *name_prefix;
>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>> +    size_t buflen = get_grnam_buflen();
>>       int err;
>>       char * groupname = NULL;
>> diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
>> index 8ac4a398..395cac06 100644
>> --- a/support/nfsidmap/static.c
>> +++ b/support/nfsidmap/static.c
>> @@ -44,6 +44,7 @@
>>   #include "conffile.h"
>>   #include "nfsidmap.h"
>>   #include "nfsidmap_plugin.h"
>> +#include "nfsidmap_private.h"
>>   /*
>>    * Static Translation Methods
>> @@ -98,7 +99,7 @@ static struct passwd *static_getpwnam(const char *name,
>>   {
>>       struct passwd *pw;
>>       struct pwbuf *buf;
>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>> +    size_t buflen = get_pwnam_buflen();
>>       char *localname;
>>       int err;
>> @@ -149,7 +150,7 @@ static struct group *static_getgrnam(const char 
>> *name,
>>   {
>>       struct group *gr;
>>       struct grbuf *buf;
>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>> +    size_t buflen = get_grnam_buflen();
>>       char *localgroup;
>>       int err;


