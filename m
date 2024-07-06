Return-Path: <linux-nfs+bounces-4685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44577929541
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 23:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E40D1C20A5D
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 21:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6301CF8B;
	Sat,  6 Jul 2024 21:40:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D521CD31
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720302008; cv=none; b=ARWIzAQo6i2OwqUpCKLlV65/Q9kEjRNZ5qrYOrLBNny7cGb4OxbJu5sihjpTgBgK1/eN7xOiln53KX7i2SP5SwJufiXz+iXzdgV8BA1tEIyp27lZUQmEl8clpqpwEJKJwkxWF1iAdI+sPZxKalVTtSOOC+D1FbWHY0pU4TTkQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720302008; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+qLRYavOmb0ySm1CmU2FyZ/2Ws90hHaqC3s27yaSZ0cqc4uBb45o52WHWKoR0ck9g3g/NNyBZ7FjxLoVjR2KXonc9UqDTOeCvFMsIrCK/54afDoTXSn1cPSuQ1oPuDh3ZxltcIB1b2gLDuuKWDBKuL5iWcqzTEiSPcCeLmO+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4265dd11476so1133245e9.1
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jul 2024 14:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720302005; x=1720906805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=biJpDtL57S2ZniUyYtAQQq+f3fxgZX/i/dgiYfTNZC42rny/Jg0VesZhXTtnfaRL24
         HJsoC4o23csFbMGTrWotAvPu/bdrzl5+mMaC2OwcVH0PogmioGgIKC+LXdKAkRYqVcOp
         8XJ/iBwBpFngBCUoOY41+mZfjITmVZHElWqFt8D1Ktqh36HQc4WC/mcz6q6OXiRiv94g
         vkaY/GdbdkeWOngE2/PimvDQXbtLi6zp60X0u3yyjDk3vr9We2aQog7udk0bAtiqIeNk
         NuRQ1PvNJGU0kD7L3jrI7V7o5TDCQECLPl5hsW4blI2hrKmzJ1+5ZvHuzdODJT6V6gD0
         T40w==
X-Gm-Message-State: AOJu0Yy8Rt2L79+9UaA+/KgMfAfb2X4XIDhF4UQfbp/+8fKVVcRU5rDn
	hWhgZJHjNj+Ap0dbE4CbJclQIZsMkqbW33tvGQxJxIQcZIUZ8m/ORfoTojZv
X-Google-Smtp-Source: AGHT+IGkEtO54B+3ReCDSqVIsybKxnDiaxLeBXKUf3x50Rf7Z8EFDFOdqOtXaMtFBTzQDaBRQ8xGFQ==
X-Received: by 2002:a05:600c:1c9f:b0:425:7ac6:96f7 with SMTP id 5b1f17b1804b1-4264a35297dmr56139645e9.0.1720302004812;
        Sat, 06 Jul 2024 14:40:04 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca6dbsm109757665e9.38.2024.07.06.14.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 14:40:04 -0700 (PDT)
Message-ID: <41bce6f7-d62e-4a02-a3e1-5dd433fa7646@grimberg.me>
Date: Sun, 7 Jul 2024 00:40:03 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs/blocklayout: add support for NVMe
To: Christoph Hellwig <hch@lst.de>, trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240705165141.2248305-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240705165141.2248305-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

