Return-Path: <linux-nfs+bounces-3704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BFE905EC9
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 00:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCD0283D1C
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 22:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96912C801;
	Wed, 12 Jun 2024 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jK/qHLGv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954012C470
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232783; cv=none; b=h2uz/dz3Nn/6lnXoqi8RP/VoH+iK+KaG1/JPN58nJsvqy0P9Tgluf8kWKlbNuVcM8u1yUobiZgubCAgndIWNI5k/0hHz3ABVrvJTmBBBZcbUtnIVeV3u39c7ZlfMPPghpnP/gmPVI0XMZSqs9cint4xKUALh59+JY7+JkNCvjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232783; c=relaxed/simple;
	bh=L3qaXQNUUVxh4Q0Q3RMUhGqp7sJ7EFx4+fzYvA3H52A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnhABadrxbBGOFToVx7B8LkVH78mkG5MUei6ePJj+BDmVyp1ds4KlQFsDj0AsFMdegpc5X3YPQqpAzTqNI+n+SH0fYpM70/Ams3QApC73bQSnz5L56hJGGE8S8AslywrOSorzShcwC+QZBimQin3/5dSclXZpi85WJ8laDbi9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jK/qHLGv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6f38b6278so475265ad.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718232780; x=1718837580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCKGfocKzBU0+xeBiPtl1Ex5TwQcMh3k2EBSdA3xSn0=;
        b=jK/qHLGvI0kV5kxk0TrIxYpm7MMWZSt3v741kn091VcRmXCARzl9rtz9vI0V4zfu7H
         GR7OsA8rw93QhkXvQIEMPEP+ta1DBYG5sB4JUmu07Tv/2GANeCt1pLwqhfXTP0ahkAD5
         ZTQg4WCW4uehb5S/Ej6DidDnexG6/OhTOov6AbzeQ+7JnKgZpxmW153617GINF5uGI3M
         bvEbqQdnnimNSgV49Rv813WRNApxGQj6/2ZP1jfsA74AzF066dcloIIa4indI8oXIvGP
         goAx3kwz5WfjuKZAE4S35MwK1J/RTxvBGAzcxGcOoDyJZ9mlG1dAmdToy+7D2b5ryiAm
         rhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718232780; x=1718837580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCKGfocKzBU0+xeBiPtl1Ex5TwQcMh3k2EBSdA3xSn0=;
        b=bvmzCDVdnuil409HN3nQK+pr+XFe7u5TDWJ8CNPU/B6Ps4+IKIf2J/rgPCIv9rP/98
         zVz6z50h/PcEWmad7dKw+CyubcGrDAEJCLezvmaU//fXusc+373MT1K+PhNrCXt9jui6
         wPNEMKJz9p16nxLrXU8eQlsKBkcb6tXoAfPKiw12RJ89815Qns4gIwcHmfyO5vGy8Tgl
         prJA504zoBud6CjLgGtgZKurBoiXixuMhWPhPtYCZc7mUD9wzZJEs0EyC2h+n2R3rrGz
         PAr/hWMX1cSOfPveTx+mdcIkFOH4UkucAPZ5bqhqoByvDaUjlnVvY5HhhgCKxXIZ91Ku
         snkA==
X-Forwarded-Encrypted: i=1; AJvYcCVO0pyTE3y5UMZHWLKStgICeOiSnsLpz9nhHbr0VL1d/xniey9hXAE3NdSgsGqjvSBMotDpuzdaAKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+76mQ8kWo30c5T7fx2cybzWqvwhOuvn1djs1xWh8WqrYDNGFc
	5Si3xzq1dev21xJMOiT2oKVDRoYVT6f+k+3JBCgEUsq9lmfOdhwuWdHUIyFjJoA=
X-Google-Smtp-Source: AGHT+IH5UZSMoyLCwmMYbQsnXovMsmtOxcZgzfit4qNG1yAnUakar4EveGlx5xiJfFg6llU0rCt4rg==
X-Received: by 2002:a05:6a20:5647:b0:1af:acda:979d with SMTP id adf61e73a8af0-1b8a9b4e85fmr2859600637.1.1718232780575;
        Wed, 12 Jun 2024 15:53:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d2c5sm73821b3a.105.2024.06.12.15.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 15:53:00 -0700 (PDT)
Message-ID: <7e58e73d-4173-49fe-8f05-38a3699bc2c1@kernel.dk>
Date: Wed, 12 Jun 2024 16:52:57 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: paulmck@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, linux-block@vger.kernel.org,
 kernel-janitors@vger.kernel.org, bridge@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nicholas Piggin <npiggin@gmail.com>, netdev@vger.kernel.org,
 wireguard@lists.zx2c4.com, linux-kernel@vger.kernel.org,
 ecryptfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-can@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 Vlastimil Babka <vbabka@suse.cz>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240612143305.451abf58@kernel.org>
 <baee4d58-17b4-4918-8e45-4d8068a23e8c@paulmck-laptop>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <baee4d58-17b4-4918-8e45-4d8068a23e8c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/24 4:37 PM, Paul E. McKenney wrote:
> [PATCH 09/14] block: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
> 	I don't see a kmem_cache_destroy(), but then again, I also don't
> 	see the kmem_cache_create().  Unless someone can see what I am
> 	not seeing, let's wait.

It's in that same file:

blk_ioc_init()

the cache itself never goes away, as the ioc code is not unloadable. So
I think the change there should be fine.

-- 
Jens Axboe


