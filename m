Return-Path: <linux-nfs+bounces-16802-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2FC95558
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Nov 2025 23:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23FF13412C7
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Nov 2025 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AE6242D60;
	Sun, 30 Nov 2025 22:22:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2F23ABA1
	for <linux-nfs@vger.kernel.org>; Sun, 30 Nov 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764541321; cv=none; b=evhDWa4/dzpzuz52vWZJ+DEJf/bzZjLcwa4K5H1V+pGDLJ433HMAAlGu1fmm+PyZ+5+my0zwBsdwbE5SK1jkRfvKlL4syDoOVR5oiH1TLCPTnlZ3oll0u2lbUatSe0zF+2UDJKcmjrW+e2gmq7uoSCoE13RMfMoFypG29nrhQhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764541321; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tg6/qBEcMhsUpNFUpELkYd0x2H720wCu3IV+TPmuPrebvbcfbUJgHc4gRIp/nmjrv9dvOrSOyGTDuXilA6Oxp0lz1T9agYmsFBQqp8I4xbbAfM1bmFWZmISCM+AUxZ0dnbf3zOpav5bX7O++m+swOOEOnQYwXhwbKkHZ5OmCm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so34494805e9.2
        for <linux-nfs@vger.kernel.org>; Sun, 30 Nov 2025 14:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764541318; x=1765146118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=G4MDD+pJceBsLKljmsFSPcRSV0/llbnV1MmqdC4nsPuw5ueT/uRcluLdXUQ8yD4v+C
         X1s8WX8YVfeapYddTviwZaTJWd3YnA+IxfB30vcxNQrz9kOGKJJpccnXypCTd7rKL1Cl
         X1GY6vAMPHta2fd5fR5fgY2gxteIAfw2hCWl4LYG/x9/ZjGxsa058rQZIK2S4JNarkyK
         +lIhQoBsJR8wtVg30QSsrWiFksng0apVjY4XGh9/4/qSbiUqtiRSaHL8uKUJHpHiOMzT
         OGLx0BU5RRR0LkCpmyumCAbhz+oLPjjUn6AGQmdCvQKrkjma5ETYyQzzTqpLYzrHDLR8
         V7mw==
X-Forwarded-Encrypted: i=1; AJvYcCWwYTIz7TntciqBMtcSkJDsOjjZ5EiiOpg99e5R8A+xA/jmqLlhceTQx/UFA3QGqYkrOe41s2Bdmpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPx3Sm/Enhmx5Ow2ESfjX4Gf1mvOLJdifESrzNPJHz+i7f/dZ
	Uck3Z4siTsKDhQO4b3N0WXDcU6qcSOjZDyO7vF4go15P2cvX3iBBN1Jt
X-Gm-Gg: ASbGncuf5L1f9SrJIQQPFK1h7cAX1M3xg+aJX4nE9OdmBY/TZTq6IO531eoW/hzW2CL
	HZgshbIs0wOUuXUAzARlobaW4lI5ab74em7srkXf3TLJ/aHUEJCxzodMokp6aL9lpz6MKWHstNw
	JyJpc6WxgpwJiCCo+THnNV5f6/0nwHLyrqlnSaR8uBVszRUx0Br//vBjGMw4hXwKdD2P0pv8HGy
	My5i4hxa+WxMbvH9v5m+WtAAksfgKPUPYFQWweIdckuwknTPEVoZHCMZcEqu+QyilD8M1VkFWsO
	iLSFPcYn2iox2ngpGJltF4IJzRF3N6JG69c8Ia4DNwEjBj12gJvvua6S0oHFhBfweKGiMOrucNx
	PGsRtQi+jIuFcj756f4jcJwr4XolyvO/RCd8o3U59VFjX1wInnX1J4vfAVgfXpsCASVmgj58N0P
	T41XYmMzFTXAjPJli8OqYhbIcP/Mg+Myd65/Lb7rs7
X-Google-Smtp-Source: AGHT+IEaDq7D6ajMDVwbhmEysEzsY+1ogXGwoywM0VuEEVuoRMtFYjkQRVWQHiyxGuNw2ezMfnKldQ==
X-Received: by 2002:a05:600c:1c1b:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-47904aebebdmr256111855e9.14.1764541317764;
        Sun, 30 Nov 2025 14:21:57 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790530f0a4sm142367985e9.8.2025.11.30.14.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:21:57 -0800 (PST)
Message-ID: <93c631e9-a07e-4293-a59e-81be85270687@grimberg.me>
Date: Mon, 1 Dec 2025 00:21:55 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] net/handshake: Store the key serial number on
 completion
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, kch@nvidia.com,
 hare@suse.de, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251112042720.3695972-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

