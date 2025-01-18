Return-Path: <linux-nfs+bounces-9383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A28A15C9A
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jan 2025 13:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D9166B36
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jan 2025 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AD518871D;
	Sat, 18 Jan 2025 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSVNrH+r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04542913
	for <linux-nfs@vger.kernel.org>; Sat, 18 Jan 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737202372; cv=none; b=QLjE/gVC0eOnWRT8RMjKf6wlajGTFp8XALHgNT6tJzxWBd9pVjH32ivsP8Okxjy0tPemxjKorz+LzRrK4NzzVZHtEL4KSsud9OV8pn7Ud69UtmM0W7z5ZUsPwb8s4Z+Gr71pBbqUeX+nRoEiJJaQE+VEuxJG0D3aTRUE8GBFaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737202372; c=relaxed/simple;
	bh=GsDv5RLh568R//WNOmXGZKoijb2DwZGlrperpLq8+Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPKDitGWG6EenP7McCgQJXOtSbn2ljy+akBVKe7RlRXcT6G+lvK40dG4UNMH3ouxVeeDD/krd69y75AC3ry8ZIbwT8aiCM3+37WFseSH4BDFxphq0mIb8Mg8XfImvfv4WAwjGAE0SZnHiJS9qHYM4pXOVl7lDLRqcfmaxAouPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSVNrH+r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737202369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ra5xsyc+E+YUGHCLF7OgsIMhnoOFAEALbXJgja48JGo=;
	b=LSVNrH+rXSP3kmSYA6Y4PrvCQIvD+FTwoULAMdaihJv7kyJmGRJ+bzQSHss3I9/A20y5WE
	0hO3LlsAIKyor/D5TV3J9gulflOsVk+qqpJboD7DoMKTivRXJGPR/PKNO+mkWNPNRZ8Xmv
	TxRzUbKziknGtnUya3f1qCXBIChmd2M=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Q_vN3q-FN2uTS1OIHOHUmg-1; Sat, 18 Jan 2025 07:12:47 -0500
X-MC-Unique: Q_vN3q-FN2uTS1OIHOHUmg-1
X-Mimecast-MFC-AGG-ID: Q_vN3q-FN2uTS1OIHOHUmg
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21648c8601cso53320345ad.2
        for <linux-nfs@vger.kernel.org>; Sat, 18 Jan 2025 04:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737202367; x=1737807167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ra5xsyc+E+YUGHCLF7OgsIMhnoOFAEALbXJgja48JGo=;
        b=KskNdBn76JT2tp4eFVtk6QYPuBMlBV+eN9HKXLNJUe3/dX4F3tdX8ZE/rkSdckKy3Y
         KvNAclR6dq5KZ5YC6/31E7Qw3Ywk5B4zF9RxMbGuOOhlDy9nH/ce2MFd/ikemnhfK61v
         V/qAaXvVu88q+fDyGE2S9ebb24WHJLqeHkTOmpeH2GMz8ubRWBBaRuT/yivp6apILJUr
         mZpmItV0BrJ01GH0oYHFA+yoAjx75engDXSVSb8hV/8GadBvTGA/Tu6dNc9LGeL3n8HO
         f/gFFMYccu4cf2onav5yxofU8m8Zn5nSl6C03aKg/Bta6TjuFuXY7CfGq5imAyg+MKOo
         Cntg==
X-Forwarded-Encrypted: i=1; AJvYcCVA1jRvr9wdWmGqRDB4B5wTamDNqU5QCH5mQLr8QioeTR2gyOI9XuX7kFe/ufFFVkYHjRxpg9PwVKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQpULIeEMlolJyoOYp6bNhicj3xeNy+Bx37GGev4qmHeU6PQK
	kvqVTGEdjrDYS4ihgRAGVv1uXh4ttmQtWi04HFiS4TUSr0OKrigAbx8MZJjlvZl3cb3Mt9swSbG
	XnkcKA3eGZBYWgmpg/GP3NX/llVm7MPUn+X29/4Yv0H3UVIbDcCKUb8HtGQ==
X-Gm-Gg: ASbGnctY9SCwC48z7FUwmRBvYdUha9T8KX0kxZe2iXjo0iNVYD+nYwL34JChyxTPoJO
	iCx9cZy5poXtC+h5wLdk8iVw78wcn7OLkuyKdg8ooEDe+mAxNXkaPGfCWI63cVvdk7DsCIw30Gz
	yspgLL366Bs1Jteb9LAJdXFYdBiX+/lYMkMJeD/XSNcfx7NKEbBxd84LoNcks6aPLtLqWJhH0S4
	xOYLMuEqWWawTljzAZB/gmfTepLBGhAwNkjUZIPQI1a+wzwXXElYAa2bxcT59Ipq/zGyA==
X-Received: by 2002:a17:902:c94d:b0:216:55a1:369 with SMTP id d9443c01a7336-21c3540179amr96511015ad.18.1737202366846;
        Sat, 18 Jan 2025 04:12:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQBWSKfCqVBnzeG8OH+9vgDGbOBUE4cBUwNj8U/WieYWBTgztas4k3YNyJpkM2x0uI5rpWqQ==
X-Received: by 2002:a17:902:c94d:b0:216:55a1:369 with SMTP id d9443c01a7336-21c3540179amr96510795ad.18.1737202366550;
        Sat, 18 Jan 2025 04:12:46 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9efe3sm30711975ad.20.2025.01.18.04.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 04:12:45 -0800 (PST)
Message-ID: <5e623036-4366-4eb6-8da8-a595698c4ca3@redhat.com>
Date: Sat, 18 Jan 2025 07:12:44 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH v3 0/3] version handling fixes for nfsdctl and
 rpc.nfsd
To: Scott Mayhew <smayhew@redhat.com>
Cc: jlayton@kernel.org, yoyang@redhat.com, linux-nfs@vger.kernel.org
References: <20250113231319.951885-1-smayhew@redhat.com>
 <Z4WfveqvKb5s9tc7@aion>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <Z4WfveqvKb5s9tc7@aion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/13/25 6:20 PM, Scott Mayhew wrote:
> On Mon, 13 Jan 2025, Scott Mayhew wrote:
> 
>> Two changes in how nfsdctl does version handling and one for rpc.nfsd.
>>
>> The first patch makes the 'nfsdctl version' command behave according to
>> the man page for w.r.t handling +4/-4, e.g.
>>
>> # utils/nfsdctl/nfsdctl
>> nfsdctl> threads 0
>> nfsdctl> version
>> +3.0 +4.0 +4.1 +4.2
>> nfsdctl> version -4
>> nfsdctl> version
>> +3.0 -4.0 -4.1 -4.2
>> nfsdctl> version +4
>> nfsdctl> version
>> +3.0 +4.0 +4.1 +4.2
>> nfsdctl> version -4 +4.2
>> nfsdctl> version
>> +3.0 -4.0 -4.1 +4.2
>> nfsdctl> ^D
>>
>> The second patch makes nfsdctl's handling of the nfsd version options in
>> nfs.conf behave like rpc.nfsd's.  This is important since the systemd
>> service file will fall back to rpc.nfsd if nfsdctl fails.  Note that the
>> v3 version of this patch also makes 'nfsdctl autostart' fail with an
>> error if no versions and no minor versions are enabled in nfs.conf.
>>
>> The third patch (also new in this v3 posting) makes rpc.nfsd consider
>> the 'minorvers' bit field when determining whether any versions have
>> been enabled.  This takes care of two scenarios:
>> 1) When vers4=y but vers4.0=vers4.1=vers4.2=n
>> 2) When vers2=vers3=vers4=n but any of vers4.0/vers4.1/vers4.2=y
> 
> Test script and results for test patches attached.
That is a petty thorough... all I had to do is change
the it to point to the installed binaries instead
of the ones in the repo. Thanks!

steved.

> 
>>
>> -Scott
>>
>> Scott Mayhew (3):
>>    nfsdctl: tweak the version subcommand behavior
>>    nfsdctl: tweak the nfs.conf version handling
>>    nfsd: fix version sanity check
>>
>>   utils/nfsd/nfsd.c       | 29 +++++++++++---
>>   utils/nfsdctl/nfsdctl.c | 86 +++++++++++++++++++++++++++++++++++------
>>   2 files changed, 98 insertions(+), 17 deletions(-)
>>
>> -- 
>> 2.45.2
>>
>>


