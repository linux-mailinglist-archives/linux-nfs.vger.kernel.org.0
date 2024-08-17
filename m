Return-Path: <linux-nfs+bounces-5432-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACC59559D1
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 23:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0A11C20CEC
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048A155391;
	Sat, 17 Aug 2024 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="lppJQWCP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715927BB0A
	for <linux-nfs@vger.kernel.org>; Sat, 17 Aug 2024 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723929459; cv=none; b=bGf4FjDAuIiRjIUmkN517H2DaBjJwIthZpqzcxYXgjC2oe1kMFMjkRzX7o3Y9ZsILAoNfRFchUtFkFQGZCnH+lelNQwXpKzyZp5AvY9CxWIjaYDTxKh04/tQy621Ncid/f8d9tVKBiF8ihSYpWghgIqB0elSD1ASCLKdegMXoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723929459; c=relaxed/simple;
	bh=t3rvDnO7fX+n5iehy8S2ishviq6i/2esDfQRovIDAKs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PBZj1dzYVfvO/ynNQtvE1c9WsD+ZNh3TkspIVYJfgUuc8x52TLbzx2vwOnwgAQKchwNDalIOCid/Gw9IFs3xtpH1hnVRQwPe86PeCjdNJY7GSvc/tmmVITG1fJJEH3wSOwkhPq28GDjBT6s/HEe/x/gCQZ+2tAQF7S+UNQdrumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=lppJQWCP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428163f7635so25712295e9.2
        for <linux-nfs@vger.kernel.org>; Sat, 17 Aug 2024 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723929455; x=1724534255; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlOuZvyYI02m8rApw3+B2vEhpdkz/PwxBJHifhLBStE=;
        b=lppJQWCPcpshq8T0IPKt72NiJo83JBrecdIvYWDtnjlm+mtpJdjO4rch460/vVOjvM
         rCEBFmpuyXzblyTxa8ihuVD28jXyt7YVuxKdftHrDETdT2olTOljiCwWwVziDzHK41wn
         XMNGwDUwFRasujlXJQH3c6Ww5PqM6Uf2SJ2jzIzHnJ9eLicH6fg1vrUpAg6X/QDvGLD1
         auf8CsRZrFRa1G6xXQdL3r790HHitLjFdgBpYCuq9r+o4rLpCr2Vg2oArMRZveD4Q03o
         K4TSue/KaoldoGtni9nrxBUjSJ1gbIwV+dbxQAc+lrjbBoftvv7YLBOnXjxLkt5MjF/h
         YqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723929455; x=1724534255;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlOuZvyYI02m8rApw3+B2vEhpdkz/PwxBJHifhLBStE=;
        b=an7ia09yP4Y7plxQGmOFc9my8LteSwewx/zqI6ACelalc+9/ANr5VkF8ZPT1ok7PLw
         lON/d99h+phZvnNB595/FODaIf6wVm8Likr9eVHsA7XfFwhI6DI6s1hi2oJHDtPvHOQU
         qXDVfOy6Q+M8e9CfWQoxapgE19Gb76pTmZkAlY5T5pmbYkT1LfdKiNyjXXqBx0iTl7Jl
         2FV6QmHveqPLR0MWuy5XJT/O4QkwPkbReGL4yGlV0+BGrEgkyWXERG0G1rehUn+5L27e
         wDgpu1A0p2lGqTCZ0HsLMAS5dQ2wU5lKrKdwlIwkMiAu54CJM3Yg7mWy+Ii9erB/NqXw
         zkRA==
X-Forwarded-Encrypted: i=1; AJvYcCU/3HNQWie8EURj79YApkw0dpinYp+8f518KY904Ltm3EnxMT2zMac6xqGjCt6dcd784Y0dkpoX4b2nP3+xJKsO062NT7B3T8SI
X-Gm-Message-State: AOJu0Yya/fMZ8sgCH7ec4ELVjaWLq7wNt3BEmzgnGc26QR/+NIgTJHp5
	Lv0eJJKHAchBiLg6Qv4NUPkR29mOor5cQpvSeqHKorkp6GoldcGz/fhLAL/NJkM=
X-Google-Smtp-Source: AGHT+IGiQ+Tmiu5bRgdWvEF5qWEJRLGyLG8pqr96rQC5WW+Azb9B81qMu6p9UUbdzuVdRqrgE+JkBg==
X-Received: by 2002:adf:ed01:0:b0:368:68d3:32b3 with SMTP id ffacd0b85a97d-37194649a85mr4611119f8f.26.1723929453528;
        Sat, 17 Aug 2024 14:17:33 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a92:ee01:29b1:1427:611b:84f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897128sm6607098f8f.81.2024.08.17.14.17.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2024 14:17:33 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] NFS/flexfiles: Replace one-element array with
 flexible-array member
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20690564a768f4c7e6ff9c3a7a520b9f36abef1d.camel@hammerspace.com>
Date: Sat, 17 Aug 2024 23:17:21 +0200
Cc: "kees@kernel.org" <kees@kernel.org>,
 "bcodding@redhat.com" <bcodding@redhat.com>,
 "anna@kernel.org" <anna@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "kolga@netapp.com" <kolga@netapp.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <4CB2BE7E-5979-4424-A331-A5162190A102@toblux.com>
References: <20240817142022.68411-2-thorsten.blum@toblux.com>
 <20690564a768f4c7e6ff9c3a7a520b9f36abef1d.camel@hammerspace.com>
To: Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 17. Aug 2024, at 22:40, Trond Myklebust <trondmy@hammerspace.com> wrote:
> On Sat, 2024-08-17 at 16:20 +0200, Thorsten Blum wrote:
>> Replace the deprecated one-element array with a modern flexible-array
>> member in the struct nfs4_flexfile_layoutreturn_args.
>> 
>> Adjust the struct size accordingly.
>> 
>> There are no binary differences after this conversion.
>> 
>> Link: https://github.com/KSPP/linux/issues/79
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
>> fs/nfs/flexfilelayout/flexfilelayout.h | 2 +-
>> 2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
>> b/fs/nfs/flexfilelayout/flexfilelayout.c
>> index 39ba9f4208aa..fc698fa9aaea 100644
>> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
>> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
>> @@ -2224,7 +2224,7 @@ ff_layout_prepare_layoutreturn(struct
>> nfs4_layoutreturn_args *args)
>>  struct nfs4_flexfile_layoutreturn_args *ff_args;
>>  struct nfs4_flexfile_layout *ff_layout =
>> FF_LAYOUT_FROM_HDR(args->layout);
>> 
>> - ff_args = kmalloc(sizeof(*ff_args), nfs_io_gfp_mask());
>> + ff_args = kmalloc(struct_size(ff_args, pages, 1),
>> nfs_io_gfp_mask());
>>  if (!ff_args)
>>  goto out_nomem;
>>  ff_args->pages[0] = alloc_page(nfs_io_gfp_mask());
>> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h
>> b/fs/nfs/flexfilelayout/flexfilelayout.h
>> index f84b3fb0dddd..a269753f9a46 100644
>> --- a/fs/nfs/flexfilelayout/flexfilelayout.h
>> +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
>> @@ -115,7 +115,7 @@ struct nfs4_flexfile_layoutreturn_args {
>>  struct nfs42_layoutstat_devinfo
>> devinfo[FF_LAYOUTSTATS_MAXDEV];
>>  unsigned int num_errors;
>>  unsigned int num_dev;
>> - struct page *pages[1];
>> + struct page *pages[];
>> };
>> 
>> static inline struct nfs4_flexfile_layout *
> 
> NACK. There is no advantage to using a flexible array here. Indeed,
> you're replacing something that is correctly dimensioned (we only ever
> use 1 page), and that can be easily bounds checked by the compiler with
> something that has neither property.

I see. Why is it an array then and not just a pointer to a struct?

Thanks,
Thorsten

