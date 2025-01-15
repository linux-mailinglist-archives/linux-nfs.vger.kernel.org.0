Return-Path: <linux-nfs+bounces-9218-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F0A11EA0
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 10:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBFC162A62
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA752248177;
	Wed, 15 Jan 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6/ycDRd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE0248171
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934809; cv=none; b=oYWhqvQ6NU0FT9ZJiOujjuc/tTgzOTPM+rS7Go7NhL3ZbaqYWkKy8yoI3r5pPRk1+Jard6hVhqBx9qHtU6C8IgzRp9lPehIIjllj6n/z4i+SdIg9dmjKBTMCshJ1Ial2liB2FoSGuzxAAsg09UTyRz6qa2OlWup3sC+DIwV4l0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934809; c=relaxed/simple;
	bh=dM2rP9AdoRQvnjCiLa+Y91lPin676b5df6k8hzKZ2ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ueniG4NZTVMugMi2mjYkPnd5fIouLqAvGUsGQe//Z/j5dMZNKkp3rU8wilU/vjrscpqWnl7Yi/+ETQgKZA0BYE6qLmBluDMdw4qe8INhU1AsdZ3/Gl3Yp3nPggjoxZcTusawlh5xpVebshiY7RHOEXFVla2bypDvRZmjPP7xBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6/ycDRd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736934805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7im3upWu5qtQGZmNz4WjVEuYJhjMy37RLUkGjlBfpLY=;
	b=e6/ycDRdQrI37rOUfxrlxj3EOKq6lAObyVa/OcnYxAj65F4UpZujje/MuSxDLQLvQG19lq
	7yHTIulkJAAzO0xHw6cQ8Nm8/2skpeoXGlzO9Dj38O5VZ5JhmrnJKmyh+sRjeLsDwBL9oe
	uE1Z86PvsGE8JeGmXP+B7nVgjPIOWs4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-co_HOWUoPK2Y_m5eCyrK1w-1; Wed, 15 Jan 2025 04:53:23 -0500
X-MC-Unique: co_HOWUoPK2Y_m5eCyrK1w-1
X-Mimecast-MFC-AGG-ID: co_HOWUoPK2Y_m5eCyrK1w
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2166464e236so193235615ad.1
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 01:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736934802; x=1737539602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7im3upWu5qtQGZmNz4WjVEuYJhjMy37RLUkGjlBfpLY=;
        b=IiSluefYQ/d6L5UZbH39NskygZofFShZ8SeATc/1GLyac6Bypr2uRh4rQ+H/LaBPuJ
         MP/MxQC2XPFWff1Ao/GzegLSlCXeOuEF6eazAXlAOG0hEbqq7k8EzcMEo24lsxNMTzgY
         z6QRUUVJ3atf+voxwSgSUXvjI5uxmIxHmvt/xO2Y1sL9f0ytv+PPThVTnH0E5gJuBEPM
         BUE0XTCdQqc2vfsua2rAUAdjZyLk/CpP1dKVbTtnCgZqEjWSke8u+8avWU/Fou+pyKsC
         ngThu4/J/CoaVyKugpQZuYeXZgSRp8K1k9H1zaB1vYWB6YbGQfpl+rxxwpSVIidd8vhl
         Nwrw==
X-Forwarded-Encrypted: i=1; AJvYcCUNqvaZ9nsXdq9jm552Hl+Ev5Q7fYRS5Cqf9RKhBo29YHIHas/Px6WDBMFyQJHxbzpd0rRXKFyYoes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx82mqJKT6RxdGmJH6TIzF9im42vKHY0oKYjhsevOM4C6tbK0hN
	HdsYXqN5EJBoTboFQYLtCb2GZ+dgXRq/bCeAYSzUJvAmOxPdcIiTdD6CrmixadyoUR5zFm0uqz6
	o4G17enPRzyU5uC8bf3nLotL+ncCyABe09e0uJ5CaK+qLJnL7d7WeiW76wQ==
X-Gm-Gg: ASbGncssX0uo7hW+48LxEoXKhk+LjoSkVMlfJ+SYxtg5n2D5Uuze03zlXxQN7fLpvxD
	dlCCMajZqyOf9DlwkFc76Io/7X/Jey54eHtJWyhA1OengwoeMMH5RIXc+c9cijgKNhq4EQhSIls
	7GnCy0rmXz8JxuY/GFnyumHa8erK9PRzXA64REj+rzdB+Y+B2W46pbeQcCLhbCzdhGTGoumTuty
	A9N4vSz6JORK/HncRUfXODoC1wEw2hs/qYbFsdPvVR9AcYktICbZRBT
X-Received: by 2002:a05:6a21:7886:b0:1db:ff76:99d7 with SMTP id adf61e73a8af0-1e88d2ec11emr51192302637.35.1736934801876;
        Wed, 15 Jan 2025 01:53:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcvPwMZsRljLSfT9xl4EX08r4mDQ1jNpH7IcjWmLdlv+yGKxwPUpl3bduAhGUF5e0NBO3b5Q==
X-Received: by 2002:a05:6a21:7886:b0:1db:ff76:99d7 with SMTP id adf61e73a8af0-1e88d2ec11emr51192282637.35.1736934801568;
        Wed, 15 Jan 2025 01:53:21 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e804sm8696725b3a.129.2025.01.15.01.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 01:53:20 -0800 (PST)
Message-ID: <14ad57c8-c230-43eb-89b3-5e10cc7faa47@redhat.com>
Date: Wed, 15 Jan 2025 04:53:18 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch for broken libnfsimapd static and regex plugins. It appears
 that the makefile does not add nfsidmap_common.c in the sources. . nfs-utils
 (1:2.8.2-1.1~0.1) UNRELEASED; urgency=medium . * Non-maintainer upload. * Fix
 issue with static and regex plugins missing symbol get_grnam_buflen.
To: Joshua Kaldon <joshua@kaldon.com>, linux-nfs@vger.kernel.org
References: <20250111063059.69381-1-joshua@kaldon.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250111063059.69381-1-joshua@kaldon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/11/25 1:30 AM, Joshua Kaldon wrote:
> ---
> The information above should follow the Patch Tagging Guidelines, please
> checkout https://dep.debian.net/deps/dep3/ to learn about the format. Here
> are templates for supplementary fields that you might want to add:
Committed... Please next time add a Signed-off-by tag.

steved.

> 
> Origin: (upstream|backport|vendor|other), (<patch-url>|commit:<commit-id>)
> Bug: <upstream-bugtracker-url>
> Bug-Debian: https://bugs.debian.org/<bugnumber>
> Bug-Ubuntu: https://launchpad.net/bugs/<bugnumber>
> Forwarded: (no|not-needed|<patch-forwarded-url>)
> Applied-Upstream: <version>, (<commit-url>|commit:<commid-id>)
> Reviewed-By: <name and email of someone who approved/reviewed the patch>
> Last-Update: 2025-01-11
> 
> --- nfs-utils-2.8.2.orig/support/nfsidmap/Makefile.am
> +++ nfs-utils-2.8.2/support/nfsidmap/Makefile.am
> @@ -40,15 +40,15 @@ nsswitch_la_SOURCES = nss.c nfsidmap_com
>   nsswitch_la_LDFLAGS = -module -avoid-version
>   nsswitch_la_LIBADD = ../../support/nfs/libnfsconf.la
>   
> -static_la_SOURCES = static.c
> +static_la_SOURCES = static.c nfsidmap_common.c
>   static_la_LDFLAGS = -module -avoid-version
>   static_la_LIBADD = ../../support/nfs/libnfsconf.la
>   
> -regex_la_SOURCES = regex.c
> +regex_la_SOURCES = regex.c nfsidmap_common.c
>   regex_la_LDFLAGS = -module -avoid-version
>   regex_la_LIBADD = ../../support/nfs/libnfsconf.la
>   
> -umich_ldap_la_SOURCES = umich_ldap.c
> +umich_ldap_la_SOURCES = umich_ldap.c nfsidmap_common.c
>   umich_ldap_la_LDFLAGS = -module -avoid-version
>   umich_ldap_la_LIBADD = -lldap $(KRB5_GSS_LIB) ../../support/nfs/libnfsconf.la
>   
> 


