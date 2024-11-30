Return-Path: <linux-nfs+bounces-8273-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 583E89DF121
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 15:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA917B212A8
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A8C18CC15;
	Sat, 30 Nov 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lgxek1ut"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4522066
	for <linux-nfs@vger.kernel.org>; Sat, 30 Nov 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732976419; cv=none; b=cWPUqXrx8N++skKdUWJeaZnLcX2IbEBX8XmOgzoAp+BsrPmlZ2OcJkNkKe/ia0DE384wkys5kaFiGS6mX94SaWAYBoyAUQEUEqsyjFWlkVTYOofMq5GL3UbIrAwWCP/Wd1RT1gxL6t5J/TsIn1i56Zm+4ndm3UxZXiNmf3PjPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732976419; c=relaxed/simple;
	bh=TSUSOi/DSgEihSEQ7Do8WegnBB8V7bFSTii7LvflZGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgY9HucQ6S/TOcbLE/7RdEILT3+gVwvyw/Krx33GFJrVfC2mulKQ7K22OhNs8/ZZQaS4wf1eDtrM80Zr65SXi76y/pZzNVC5tVCO5mH2FYh6EPCwHr0Y1Oyx4qqj4WBvDj4trSDvqpZ5fzQ7acKqUh2E8mTfaoPxzSgKohf5EsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lgxek1ut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732976416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hC0vyRQpNHDX+ONFzlbHgHRympXA32wipPciWDC59hw=;
	b=Lgxek1utp0TZwOg6BuLLdl2rzoRf5JAQWYxCLmVBUWRvT50AO2k2GWhWWj8Y7WOC+iMVr1
	OoZcrOPuKDJwtxj19WEcB/zGSJTNzwGR+2p+KtV/vhPC6f/Od5o5KKC1ADkM0U99MAKdML
	7fGYDWRFXLPgomUiGos3IJxY1iZLuD4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-7tWrUO-5NNCmPsWaawv9xw-1; Sat, 30 Nov 2024 09:20:14 -0500
X-MC-Unique: 7tWrUO-5NNCmPsWaawv9xw-1
X-Mimecast-MFC-AGG-ID: 7tWrUO-5NNCmPsWaawv9xw
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a77fad574cso22014395ab.2
        for <linux-nfs@vger.kernel.org>; Sat, 30 Nov 2024 06:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732976412; x=1733581212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hC0vyRQpNHDX+ONFzlbHgHRympXA32wipPciWDC59hw=;
        b=RSqtcV6ql7aq+bnQL+XmI1F0NSay/x5IXwWwnTiuwqdATMzTgrIOke2c6wBYvabOD+
         mt8egzWnNgSI5rSRe75g5PIvZNOzo61rGNer2YUfyxn6e68Sly4lYn9m61+j8ruQpCK6
         Zu+nPcQoyA8yLVC7JNGRjsupLxuw/2FJY2hbmQpMhSy5ZlF0eOFdUnpWVjCYHSTu4lsb
         JmSqoqK1Z0/RidAl5ODid70xt54OhB//X1YjEVK/LEVaUndEmbAdM3780SqsJpNpecFr
         LoOh3Nhq68t73pXbcd3b32RALi6irp5hXS3aNCsAvIMAZnMgf6QMP2eQ5mJ/vT3390BC
         wHLw==
X-Gm-Message-State: AOJu0YzgxSQWGUBM19LCHRnY0pcyfg+8h4nnFpPdIZwBfEtvbWvqpHGU
	g9r6zqq+VKFQGecQWEGp0xbfCNh7SAG73BykdzaA4us0YxQ2cgCFtGSfS/JSla5xcOLSXAU06gd
	3wgO6AHKBLqVRmAH/Sdnh5gou5E1HjrYqkrzx07of/x4ZMg/lo/R/Ux4MM5G3Or2O/A==
X-Gm-Gg: ASbGncsXb5t55rB43fCBpsnvIXUcEhS79TLJsIm4vPJe1kgQGaKzsr3CL11f05Qhrby
	6iEPk1aqitwPIe+M2AMX1ANnSfQV6KIhSFP1AJpo9s2L6LhQo2FHc9a6plPzSMEMbSRdUzM+I27
	bh0lG1mXDsjNHbKWYmZvb1ziaSZXPyrek2ZZVQQGwvG5PJFU/+cCMUwmF5t6fS/lzfdiluGb/9k
	MIf3rIMrPvCWR05RNzO6g+Z+43b3Anzd6A2uSX7c0JVTHHf2Q==
X-Received: by 2002:a05:6e02:1806:b0:3a7:955e:1cc5 with SMTP id e9e14a558f8ab-3a7c552543emr177377505ab.1.1732976412665;
        Sat, 30 Nov 2024 06:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+fceVj/5gsSyAfJP/4w3h9IVRxkU4ETsACJ9fJUTx7VX0Luwi1reklfXZd4iEGsQtAOCoAg==
X-Received: by 2002:a05:6e02:1806:b0:3a7:955e:1cc5 with SMTP id e9e14a558f8ab-3a7c552543emr177377305ab.1.1732976412345;
        Sat, 30 Nov 2024 06:20:12 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7e2046ecfsm4167865ab.2.2024.11.30.06.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 06:20:11 -0800 (PST)
Message-ID: <71ebdfc0-b7c9-44a5-916e-b73911a8fdff@redhat.com>
Date: Sat, 30 Nov 2024 09:20:08 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add guards around [nfsidmap] usages of [sysconf].
To: =?UTF-8?Q?Bogdan-Cristian_T=C4=83t=C4=83roiu?= <b.tataroiu@gmail.com>
Cc: linux-nfs@vger.kernel.org
References: <20240530071725.70043-1-b.tataroiu@gmail.com>
 <d7165359-a031-456e-bfae-a45d0aed5d80@redhat.com>
 <fbd5e08d-3975-48e8-90b6-325628cb1b85@redhat.com>
 <CAC=XK8Nk_odMwvwXrj9suXCayni-pVnzTga0aV9tn-B-3=ia9g@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAC=XK8Nk_odMwvwXrj9suXCayni-pVnzTga0aV9tn-B-3=ia9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/30/24 7:32 AM, Bogdan-Cristian Tătăroiu wrote:
> Hey Steve,
> 
> My apologies for dropping this.
> 
> I'm a bit confused since the man page for sysconf [1] seems to say it
> returns -1 and sets errno to EINVAL (and indeed the patch I originally
> submitted shows the intended behaviour on my musl system).
> 
> The snippet in the newly defined [get_pwnam_buflen] is pretty much
> just what's in the [getpwnam] man page [2] example.
> 
> Maybe the thing you're pointing to is that I have [*size_t* buflen =
> sysconf(_SC_GETPW_R_SIZE_MAX)].
> I guess that should technically be [long buflen] and the result could
> be converted to [size_t] upon return, it's just that the implicit
> conversions make it such that the current code behaves as expected.
> 
> So something like
> 
>       long buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>       if (buflen == -1)
>           buflen = 16384;
>       return (size_t)buflen;
> 
> Does that make more sense?
Yes... it does... would mind posting another patch?

I don't have access to a musl system so I can not
test the change in that world.

tia

steved.
> 
> [1] https://www.man7.org/linux/man-pages/man3/sysconf.3.html
> [2] https://www.man7.org/linux/man-pages/man3/getpwnam.3.html
> 
> Best,
> Bogdan
> 
> On Sat, Nov 9, 2024 at 6:25 PM Steve Dickson <steved@redhat.com> wrote:
>>
>>
>>
>> On 6/17/24 2:51 PM, Steve Dickson wrote:
>>>
>>>
>>> On 5/30/24 2:17 AM, Bogdan-Cristian Tătăroiu wrote:
>>>> sysconf(_SC_GETPW_R_SIZE_MAX) and sysconf(_SC_GETGR_R_SIZE_MAX)
>>>> return -1 on musl, which causes either segmentation faults or ENOMEM
>>>> errors.
>>> Actually sysconf() returns EINVAL not -1 since the return
>>> value is a size_t (unsigned long). So I needed to change
>>>
>>>       size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>       if (buflen == EINVAL) <<< this from -1 to EINVAL
>>>           buflen = 16384;
>>>       return buflen;
>>>
>>> Good with that? Will this work with musl?
>> Just found this on my todo list... Still
>> interest in  have these patch committed?
>>
>> steved.
>>
>>>
>>> steved.
>>>
>>>>
>>>> Replace all usages of sysconf with dedicated methods that guard against
>>>> a result of -1.
>>>>
>>>> Signed-off-by: Bogdan-Cristian Tătăroiu <b.tataroiu@gmail.com>
>>>> ---
>>>>    support/nfsidmap/gums.c             |  4 ++--
>>>>    support/nfsidmap/libnfsidmap.c      |  4 ++--
>>>>    support/nfsidmap/nfsidmap_common.c  | 16 ++++++++++++++++
>>>>    support/nfsidmap/nfsidmap_private.h |  2 ++
>>>>    support/nfsidmap/nss.c              |  8 ++++----
>>>>    support/nfsidmap/regex.c            |  9 +++++----
>>>>    support/nfsidmap/static.c           |  5 +++--
>>>>    7 files changed, 34 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/support/nfsidmap/gums.c b/support/nfsidmap/gums.c
>>>> index 1d6eb318..e94a4c50 100644
>>>> --- a/support/nfsidmap/gums.c
>>>> +++ b/support/nfsidmap/gums.c
>>>> @@ -475,7 +475,7 @@ static int translate_to_uid(char *local_uid, uid_t
>>>> *uid, uid_t *gid)
>>>>        int ret = -1;
>>>>        struct passwd *pw = NULL;
>>>>        struct pwbuf *buf = NULL;
>>>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>> +    size_t buflen = get_pwnam_buflen();
>>>>        buf = malloc(sizeof(*buf) + buflen);
>>>>        if (buf == NULL)
>>>> @@ -501,7 +501,7 @@ static int translate_to_gid(char *local_gid, uid_t
>>>> *gid)
>>>>        struct group *gr = NULL;
>>>>        struct group grbuf;
>>>>        char *buf = NULL;
>>>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>>>> +    size_t buflen = get_grnam_buflen();
>>>>        int ret = -1;
>>>>        do {
>>>> diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/
>>>> libnfsidmap.c
>>>> index f8c36480..e1475879 100644
>>>> --- a/support/nfsidmap/libnfsidmap.c
>>>> +++ b/support/nfsidmap/libnfsidmap.c
>>>> @@ -457,7 +457,7 @@ int nfs4_init_name_mapping(char *conffile)
>>>>        nobody_user = conf_get_str("Mapping", "Nobody-User");
>>>>        if (nobody_user) {
>>>> -        size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>> +        size_t buflen = get_pwnam_buflen();
>>>>            struct passwd *buf;
>>>>            struct passwd *pw = NULL;
>>>>            int err;
>>>> @@ -478,7 +478,7 @@ int nfs4_init_name_mapping(char *conffile)
>>>>        nobody_group = conf_get_str("Mapping", "Nobody-Group");
>>>>        if (nobody_group) {
>>>> -        size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>>>> +        size_t buflen = get_grnam_buflen();
>>>>            struct group *buf;
>>>>            struct group *gr = NULL;
>>>>            int err;
>>>> diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/
>>>> nfsidmap_common.c
>>>> index 4d2cb14f..310c68f0 100644
>>>> --- a/support/nfsidmap/nfsidmap_common.c
>>>> +++ b/support/nfsidmap/nfsidmap_common.c
>>>> @@ -116,3 +116,19 @@ int get_reformat_group(void)
>>>>        return reformat_group;
>>>>    }
>>>> +
>>>> +size_t get_pwnam_buflen(void)
>>>> +{
>>>> +    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>> +    if (buflen == -1)
>>>> +        buflen = 16384;
>>>> +    return buflen;
>>>> +}
>>>> +
>>>> +size_t get_grnam_buflen(void)
>>>> +{
>>>> +    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>>>> +    if (buflen == -1)
>>>> +        buflen = 16384;
>>>> +    return buflen;
>>>> +}
>>>> diff --git a/support/nfsidmap/nfsidmap_private.h b/support/nfsidmap/
>>>> nfsidmap_private.h
>>>> index a5cb6dda..234ca9d4 100644
>>>> --- a/support/nfsidmap/nfsidmap_private.h
>>>> +++ b/support/nfsidmap/nfsidmap_private.h
>>>> @@ -40,6 +40,8 @@ struct conf_list *get_local_realms(void);
>>>>    void free_local_realms(void);
>>>>    int get_nostrip(void);
>>>>    int get_reformat_group(void);
>>>> +size_t get_pwnam_buflen(void);
>>>> +size_t get_grnam_buflen(void);
>>>>    typedef enum {
>>>>        IDTYPE_USER = 1,
>>>> diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
>>>> index 0f43076e..3fc045dc 100644
>>>> --- a/support/nfsidmap/nss.c
>>>> +++ b/support/nfsidmap/nss.c
>>>> @@ -91,7 +91,7 @@ static int nss_uid_to_name(uid_t uid, char *domain,
>>>> char *name, size_t len)
>>>>        struct passwd *pw = NULL;
>>>>        struct passwd pwbuf;
>>>>        char *buf;
>>>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>> +    size_t buflen = get_pwnam_buflen();
>>>>        int err = -ENOMEM;
>>>>        buf = malloc(buflen);
>>>> @@ -119,7 +119,7 @@ static int nss_gid_to_name(gid_t gid, char
>>>> *domain, char *name, size_t len)
>>>>        struct group *gr = NULL;
>>>>        struct group grbuf;
>>>>        char *buf;
>>>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>>>> +    size_t buflen = get_grnam_buflen();
>>>>        int err;
>>>>        if (domain == NULL)
>>>> @@ -192,7 +192,7 @@ static struct passwd *nss_getpwnam(const char
>>>> *name, const char *domain,
>>>>    {
>>>>        struct passwd *pw;
>>>>        struct pwbuf *buf;
>>>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>> +    size_t buflen = get_pwnam_buflen();
>>>>        char *localname;
>>>>        int err = ENOMEM;
>>>> @@ -301,7 +301,7 @@ static int _nss_name_to_gid(char *name, gid_t
>>>> *gid, int dostrip)
>>>>        struct group *gr = NULL;
>>>>        struct group grbuf;
>>>>        char *buf, *domain;
>>>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>>>> +    size_t buflen = get_grnam_buflen();
>>>>        int err = -EINVAL;
>>>>        char *localname = NULL;
>>>>        char *ref_name = NULL;
>>>> diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
>>>> index 8424179f..ea094b95 100644
>>>> --- a/support/nfsidmap/regex.c
>>>> +++ b/support/nfsidmap/regex.c
>>>> @@ -46,6 +46,7 @@
>>>>    #include "nfsidmap.h"
>>>>    #include "nfsidmap_plugin.h"
>>>> +#include "nfsidmap_private.h"
>>>>    #define CONFIG_GET_STRING nfsidmap_config_get
>>>>    extern const char *nfsidmap_config_get(const char *, const char *);
>>>> @@ -95,7 +96,7 @@ static struct passwd *regex_getpwnam(const char
>>>> *name, const char *UNUSED(domain
>>>>    {
>>>>        struct passwd *pw;
>>>>        struct pwbuf *buf;
>>>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>> +    size_t buflen = get_pwnam_buflen();
>>>>        char *localname;
>>>>        size_t namelen;
>>>>        int err;
>>>> @@ -175,7 +176,7 @@ static struct group *regex_getgrnam(const char
>>>> *name, const char *UNUSED(domain)
>>>>    {
>>>>        struct group *gr;
>>>>        struct grbuf *buf;
>>>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>>>> +    size_t buflen = get_grnam_buflen();
>>>>        char *localgroup;
>>>>        char *groupname;
>>>>        size_t namelen;
>>>> @@ -366,7 +367,7 @@ static int regex_uid_to_name(uid_t uid, char
>>>> *domain, char *name, size_t len)
>>>>        struct passwd *pw = NULL;
>>>>        struct passwd pwbuf;
>>>>        char *buf;
>>>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>> +    size_t buflen = get_pwnam_buflen();
>>>>        int err = -ENOMEM;
>>>>        buf = malloc(buflen);
>>>> @@ -392,7 +393,7 @@ static int regex_gid_to_name(gid_t gid, char
>>>> *UNUSED(domain), char *name, size_t
>>>>        struct group grbuf;
>>>>        char *buf;
>>>>        const char *name_prefix;
>>>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>>>> +    size_t buflen = get_grnam_buflen();
>>>>        int err;
>>>>        char * groupname = NULL;
>>>> diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
>>>> index 8ac4a398..395cac06 100644
>>>> --- a/support/nfsidmap/static.c
>>>> +++ b/support/nfsidmap/static.c
>>>> @@ -44,6 +44,7 @@
>>>>    #include "conffile.h"
>>>>    #include "nfsidmap.h"
>>>>    #include "nfsidmap_plugin.h"
>>>> +#include "nfsidmap_private.h"
>>>>    /*
>>>>     * Static Translation Methods
>>>> @@ -98,7 +99,7 @@ static struct passwd *static_getpwnam(const char *name,
>>>>    {
>>>>        struct passwd *pw;
>>>>        struct pwbuf *buf;
>>>> -    size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>> +    size_t buflen = get_pwnam_buflen();
>>>>        char *localname;
>>>>        int err;
>>>> @@ -149,7 +150,7 @@ static struct group *static_getgrnam(const char
>>>> *name,
>>>>    {
>>>>        struct group *gr;
>>>>        struct grbuf *buf;
>>>> -    size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
>>>> +    size_t buflen = get_grnam_buflen();
>>>>        char *localgroup;
>>>>        int err;
>>
> 


