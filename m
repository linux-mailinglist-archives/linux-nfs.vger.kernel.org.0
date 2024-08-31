Return-Path: <linux-nfs+bounces-6074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2039672E5
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 19:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6C21F2225E
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B602033A;
	Sat, 31 Aug 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PykAn3Mz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8210A3D
	for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725126993; cv=none; b=JYTkOi33zzwMbuaEVnsDfG70QHdg80kuMIfbphJi4iH/ADxg3BrUEN8wslvhPGi1M0zycm4ECZYWzw2mzETdaslKrm55UYr8VHnUeyHTYPTwFrRM6NtpnAbJaF7ewWJly+/ypt+CVK5lisiCCbxAsHUBB3p4x+zIEXKEN6J54Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725126993; c=relaxed/simple;
	bh=p9ymPWFVr3Bt838y6HM59EM0grU5gPEhh5j1DD9x01g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEgI74IxvJjmqq2S3qBgpOtVVn3I0IUd4LuAZZm9UeduS61q6rmk8jRFPWR0t1dwRfe2bZnDKZ4WWMRTE6/X1r7qYHEYcyPou3wKsEolkYc8ZwCVmMWcbZSEYH6Cm12vc+eZB8KlGJMkRaOR8gU1dUZLzdK4aYVHnM3DlGuGoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PykAn3Mz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725126989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2BjMSZhsIW1WTAu+b/uVoLltnczgbqY2Te3XiWlxuA=;
	b=PykAn3MzCSwVSZ221Lm5hXLHkImlFnWApn4Uo8G7sEANPAJ24h66m0v3BZAYt+jxiWqmfS
	oAjhOaH0w8nE1JuU1uYsxxd2EqlvkYgzyV6oB4zzZ8Vn20bPcnNg//EHrO+bDRTdVww1Ag
	kFsCra0xW7Aq+yPdbCPRteZtDthU6ro=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-skx_DP1VPMKJlZ2bhlGYNA-1; Sat, 31 Aug 2024 13:56:28 -0400
X-MC-Unique: skx_DP1VPMKJlZ2bhlGYNA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3df36bd88easo120991b6e.1
        for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 10:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725126987; x=1725731787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2BjMSZhsIW1WTAu+b/uVoLltnczgbqY2Te3XiWlxuA=;
        b=WTFkr5vdmhMP6UJhnjcNFgzvCZgpIgxyqJ4kOSA/PqwYN7EMGrsJmWKB74AiZdgAlQ
         zg1IaxTEdls9Tk9VrV59m3rPyaBRplpifHeJDGzUC+k5i9wylQIqcD7H6d4CTXHcvpcO
         kIVW7HzKUaQmBV8OZfJIUSb5f7Tf+BwAvtc7LYfXMmchgv4lCZKT+BGzKu707B9CnTj0
         UUiZoBBmIPXHM/4SlvKJS48SQg2TsEYH/7fPoFr1wDTxFdxvpDMnJB5t3QR3CTWk+G2F
         IZvA9cLqLa9oDaOqBEcFN6O1mV4KHrjqn2QGpam+FBPw3YRPSMa4H+HCB9Q02Dd9KCTm
         USaw==
X-Forwarded-Encrypted: i=1; AJvYcCUp2umNOPKTRRj+iM1C02QdLCresfeNoV6ZScLY3cgWbQofpyTyYQu8zfTNhkPRdK2vO78gSQJJBS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUICIQtTGq66IO5Ogf2+Y9+m13lkYfwRK1rIG0zEzQJbPIfFtS
	13rl/6CfPzopcVFmLnDAZm+G0kNdYIE+wBlw6DQQNl05YMQ2nDzlDOhZdMkVISP4A4YHTZdKzmp
	bgV13AvErmtPljcnioNSujeb+GJXXPIEhBH3aRE1F23Mwu/HQwvc1s4y81A==
X-Received: by 2002:a05:6808:1809:b0:3d9:273b:169d with SMTP id 5614622812f47-3df05e88001mr10953417b6e.44.1725126987232;
        Sat, 31 Aug 2024 10:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcvLsXKxt5ErDwDw0Ua3uEBSjirpB/MdV8dn06IOKSD6Wi1JRzEJnlv2w6YnLZFcR3vs8KaQ==
X-Received: by 2002:a05:6808:1809:b0:3d9:273b:169d with SMTP id 5614622812f47-3df05e88001mr10953400b6e.44.1725126986926;
        Sat, 31 Aug 2024 10:56:26 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.250.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d94e7dsm25419071cf.80.2024.08.31.10.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 10:56:26 -0700 (PDT)
Message-ID: <09fc607e-9d48-4fc6-91df-0fe31a3a6164@redhat.com>
Date: Sat, 31 Aug 2024 13:56:25 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rpcbind 0/4] Update systemd/rpcbind.service.in
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net, Josue Ortega <josue@debian.org>,
 NeilBrown <neilb@suse.de>, Thomas Blume <Thomas.Blume@suse.com>,
 Yann Leprince <yann.leprince@ylep.fr>
References: <20240823002322.1203466-1-pvorel@suse.cz>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240823002322.1203466-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/22/24 8:23 PM, Petr Vorel wrote:
> Hi,
> 
> NOTE I'm not systemd expert, others may understand more.
> 
> But trying to upstream various hardenings options which we have been
> using since 2021. Adding EnvironmentFile I tested locally today.
> systemd-tmpfiles-setup.service should be also safe.
> 
> Kind regards,
> Petr
> 
> Josue Ortega (1):
>    man/rpcbind: Add Files section to manpage
> 
> Petr Vorel (3):
>    systemd/rpcbind.service.in: Add few default EnvironmentFile
>    systemd/rpcbind.service.in: Add various hardenings options
>    systemd/rpcbind.service.in: Want/After systemd-tmpfiles-setup
> 
>   man/rpcbind.8              |  8 ++++++++
>   systemd/rpcbind.service.in | 16 +++++++++++++++-
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
Committed... (tag: rpcbind-1_2_8-rc1)

steved.


