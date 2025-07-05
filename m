Return-Path: <linux-nfs+bounces-12905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4E6AF9E73
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Jul 2025 08:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC57484318
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Jul 2025 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4096C2E3712;
	Sat,  5 Jul 2025 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVmJhYtp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514328F4;
	Sat,  5 Jul 2025 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751696176; cv=none; b=NB90A+vQ3n/A9B2QiFyeI123ka5Hrvb50KSM28pFidiZ8sJeJ5VdS8MKULg1VK/eBmtspE70/kfg6VS71N235dCOp2D1pTrlndLlKhSE9Hr6SEaKRzmmWwKNDV1MoZQ37pURpCsaPGL0iHQuO94xPZhNqi+M0tx1xJgS/P4i+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751696176; c=relaxed/simple;
	bh=LF1jiRasVpDsHCFv5RnCFTT28flPBjHzekp2MX6K3+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn5PqwlPt85gQQDpRd1ouMecdTJWPEhC41xPIc8w5CM1EQVLdqUEc8EbRVmAl3C2ouprKjp3CfDBhdcj07CnPWZ1W4ppv/ZUktMqhWcapXLnJ+tm1i1rE96L+yC4NPCqCO1ia73PtP8Ph/2vj4dtHUw8AzvqMDrwGo/xzKjW7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVmJhYtp; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so17445081fa.1;
        Fri, 04 Jul 2025 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751696172; x=1752300972; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF1jiRasVpDsHCFv5RnCFTT28flPBjHzekp2MX6K3+w=;
        b=UVmJhYtpeADP4m3gTTC4wIFUY5t/ElqDFMDm9QBZjgUk9sU6cvc2AbUb9Jd5NwITMX
         3bc/hkAChBorcekexgQDU7OY9eFRr8dhmKmUcqgDkWaOjebDeLU4G2NmqFs95YqCzN73
         kQ3AuOl3s6RSAmFxccLqMV4dORuPYtPklmXqqzHWjg8RUbJhEF0KH4pBJBnE4oV7ro+e
         0ESBY9Vq3K7Xh/YBpwt+7xuKs+95tPBusu0VupD/Rwni/GRQ15Vfyabjx+kHpkYm7y6Y
         i960iNawkfjdWvZvWrqlxXX89++eb89ERFoeZN5KZRdOGueVmpGNp6wwOiTx21wCAdej
         S9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751696172; x=1752300972;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF1jiRasVpDsHCFv5RnCFTT28flPBjHzekp2MX6K3+w=;
        b=Nz4kKTzbYXhphUuPi6ZNgh40qNm4VOCmhFynSQlW1JNuukCS5DmtRdEuVH/Oiz0BT6
         AO2rgs1ubv8D/zGveySO9NwLL3DYZDb4W1kHqaYBAtyE60oT+Q0MWOlqxEiWfJGsqK26
         NdGN7DxxjRP8gKAC9lWGvrkq8Ix20QnbzW5Wxtdua3uXc7PZ8rVxCojsYRFIrqZzCyDU
         /VmjKAGqDwJorKnM6mzJyhu4/qBBqZgG0Ae8lO9FsR5/t9MCMW1kYJiDLl+pT2QtLFju
         l0G9xFKAH6HIi4SOKsHGe2Dql4NZctG/WU30nz98bhhp55MYh1sPniy/vh3ZnbqrXqDn
         9Ctw==
X-Forwarded-Encrypted: i=1; AJvYcCXj8ded9iI0k5YkuLT+0S/ZUl//Er9mo4Whu514iAgV/sdLcNKWwaQVlqC88uS7AKJVEO4nvVy0teSOdGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bwS1tPlo76VMMdsdGk2dx1hZcqxKqJ+VKjUK5LW+MT93R03w
	xpExVDqLzq83qH/kdLlKVLbl3TQ/Rvr009MKv/XtDB76tU/vp9GLSvxD
X-Gm-Gg: ASbGncunue5dqG8gPAlAoupXZMKp37QF/DyycFDMQHX1iWu4YxEueYQat3LP/sLIqXr
	ucC3eyHPVjoobwCsSVudzSfyZ9WrOzpSmUpasRJ4vbcYFWjeb68JRV/Q8oJxJdVmx1uefmP5rCL
	5TiiPaIov+ksFtpuaxafNV+9MT3Fhs4gnapLiya9D0PlnvISGwVkLnZrZssGxUHcFO2+BO4kGC1
	BWwUZm0i79Cc7rXQMNj84BkbYMPPvbodADG9GcuWLYilX3073tCJCw+zMN34ckxWqf1iZQIxPJb
	bUrMwPNhhtp8dPSZLEtXdHNzbDN5U/Ov6CReAwyeb7XrW+DSx/0SgorJRGBTY1orM4br/ypKTns
	JGMk0roE4EGg=
X-Google-Smtp-Source: AGHT+IGTOe06lLadUO5wP/zEqqBonfrCzWyQsWr8bdiOWnM8sH9bGGRfkG+o/Fg6av04gGMVK1aiVA==
X-Received: by 2002:a05:651c:1183:b0:32a:e7b9:1dc9 with SMTP id 38308e7fff4ca-32e1bff32e0mr15160521fa.3.1751696172217;
        Fri, 04 Jul 2025 23:16:12 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.70.88])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1b11eaedsm4434731fa.66.2025.07.04.23.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 23:16:11 -0700 (PDT)
Date: Sat, 5 Jul 2025 09:16:10 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>, 
	Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konstantin Evtushenko <koevtushenko@yandex.com>, Sergey Bashirov <sergeybashirov@gmail.com>
Subject: Re: [PATCH 2/2] NFSD: Fix last write offset handling in layoutcommit
Message-ID: <2swioqrkdxgo3clt77vfc3iyta5diffsoecbqes7pisalsdm4v@d35b4pfsik76>
References: <20250704114917.18551-1-sergeybashirov@gmail.com>
 <20250704114917.18551-3-sergeybashirov@gmail.com>
 <f1fdddde-2450-4a2c-a1e8-ee6a3ff81090@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1fdddde-2450-4a2c-a1e8-ee6a3ff81090@oracle.com>
User-Agent: NeoMutt/20231103

Hi Chuck,

Thanks for your kind guidance, it really helps to understand the
process of code contribution better! I'm on vacation next week,
will rework and resubmit updated patches when I get back.

--
Sergey Bashirov

