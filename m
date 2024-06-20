Return-Path: <linux-nfs+bounces-4132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C200910073
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 11:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B01F284385
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E6C1CD2A;
	Thu, 20 Jun 2024 09:35:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2A1802E
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876100; cv=none; b=MPx0oWT+hE/phZcPw0iTsvHPsK1MBtOu8Qwz6eybPJkRnQcaVXD0tJLfs9wyiOAYetPn9i81FN6MRbrMMKobbKq/Y+cSMfYfUkoGu3+U3Hp0F5D0XGlGUdjWaL/IZHaHg2yhVkk6bvWnWJlm1kw+4c5vnTG5LTU/Z7nV9J/xX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876100; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2+1zuM3rReYnZ6aJnwdzmyB0bnRbupW6IAFGfVW/Y9A3UR+6FcASmRfGNxTh1p+ctuzOAXBB5yDVlWEFhDayUMXjQzLqQGnq3TjuCmUKw3JuzgVfoKtrDjA6Zmt+J/yXN3EV69chmNUfz3Qle2V5+nO1uRrDQEOsDDRcCjYnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec18643661so443061fa.0
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 02:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876097; x=1719480897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=tn86uOvDjCPHWqYpripare/mkC5fjZYeXUQzOgAFC7b9CDlfQ947dTDflpqDoc5hWi
         ExLsYAcy8ByPt+dMlORn16gbh7uNSV8iXpojAoB5Gq+T+9rFDFu7bkDw0SPtCH4awzlz
         8JVvFmVZEfB5Xl4FP5LQ2wiPO9f9jayaPbuQ/L4adO9CSSsQ3axpLWMdLFtVJsOtrQSb
         x3b+gBDYugKhyg1wbGrq0qlXCuf+1jmthxLvTpEiE/J5OkaF5WMj1SlxFw/R5T/sZKnA
         TXTUxLZBx47hHfENfOpPdcFwGQr/gpig5AfRrsmHUyc6HPg85+U8zu32XIEKE7Par0IT
         juLA==
X-Forwarded-Encrypted: i=1; AJvYcCVqhGKvS3Dtjhuv0YoUyHspKhxbkyOQgKLpYcN7PSCngFdHSgOVWjv83Cvzsi4HQQt3oGt/WnZiZmi904SAsHxHPWxx5M0Ivx3I
X-Gm-Message-State: AOJu0YxGJq8FWfl1HHtVstdHvbC2DR0unG1nDLHJU//5AKqY0X3i4sO2
	s64A7grhnil99swSknwbZXxq7d9aFvUFXUrmGqeZQhrcBfBUG55L
X-Google-Smtp-Source: AGHT+IECo4gADEuycVyl+VQKljkx9/c42Zc1/OC5INIm8uWTyk4QcMLbQnWZBuqNnek7eLi15xNYkQ==
X-Received: by 2002:a2e:8052:0:b0:2ec:4399:9be1 with SMTP id 38308e7fff4ca-2ec4399a471mr11600991fa.0.1718876096700;
        Thu, 20 Jun 2024 02:34:56 -0700 (PDT)
Received: from [10.100.102.74] (46-117-188-129.bb.netvision.net.il. [46.117.188.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0ca68esm19371975e9.30.2024.06.20.02.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 02:34:56 -0700 (PDT)
Message-ID: <bc3fe638-838b-4d05-a3a0-83a65c77009e@grimberg.me>
Date: Thu, 20 Jun 2024 12:34:54 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs/blocklayout: fput() needed for ENODEV error flow
To: cel@kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: Ben Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20240619135255.176454-2-cel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240619135255.176454-2-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

