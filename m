Return-Path: <linux-nfs+bounces-11769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5694CAB9B6D
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 13:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AAE16B1E4
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDD322259B;
	Fri, 16 May 2025 11:47:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D498422F743;
	Fri, 16 May 2025 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396043; cv=none; b=TWvmpo1a9TkFhjxT3lMorENu3k1rYklCz5ExUMUsSjb2qfnJt4NJyoHTDq6f3AMXExOvAaL4h4ifMIhOhubxn+FnknUdGHXomo7+cM9sEZdMjujOGhqy0e3wf7KLdEclxovI+XIC4Wux7iE2xfxIN/wXmy1dqlJ040LMuYKkyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396043; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPurAAuIUrEMWCEuMBx09ZUJLpAzrSfJWDH2L/EYDwcQ4ZnOlaSPC2xsf9Qm3nPKdYeku8XbsvTB4uzGeYycIMPCONDpv2mI6gmAqoCPBIuwEvfoXachc6OVvAx8oIa0YnXFFdxLs53U5mmaYoGzfCpal/xPzW/F9dUAkLnXGcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a363ccac20so151569f8f.2;
        Fri, 16 May 2025 04:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747396040; x=1748000840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ASUI+gm0qp8QNvT0rlZGno80E9m5ojGf4zxQunTD2dMCMP3t+F3d+6BDcbYOCjyVQJ
         RamN0CQEOKjb6uHOpWNvZDF6umKNwo3cGVySobIbacwHUshy8wGbef3QVVgabkqUSgxj
         wKZuJoxRNU6hCKV3JwPSi5mUQmvwpCWf4M1O3XeE361dFv6PgOnS/1tVCxdAli7MWyvS
         HDpl8To5Txm/2iRrgA7M+sOgSb/hBJKP/hc7A3jWiKNnAHeTAZVsIMUmdKTLZ10Xyqm+
         3A8fOCJdITUUsGHwofS6lB48UufzvbnIVaw1ut+7qchE5fJPZ7T2QCymaHiIcC9PRT+1
         z66g==
X-Forwarded-Encrypted: i=1; AJvYcCWSCRc9By3g0qa2IMMhTvgzqlajdyNrZWxvehaQFpCBlQ1M+nGA6xn+xXjDufe9V9F8LdZn/JO4XQ==@vger.kernel.org, AJvYcCXu55OQpF9M2HoybuIYoGC8YWNRdY9wp8u7ddHccfPnJq+uLrXE6iZEHkc/0zXTUoVM9C4Z/bscHX4j@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCLb91lHsYBhV/W9fYGEZFGYJ9p96L9h7EdNNO3o5fywDrEZo
	lLhfa+ZEAeV61Nm9ac9u3jyzwfsK5UjgVqFxbictXH8S1pvuGPrAVowW
X-Gm-Gg: ASbGncubdZoVC82S++S4ZYRAhCJjLphns5lDjLT+qoOZLwf7RFfaP8MrvlsUhWh0NCJ
	ElDBGhy9utFznO7V1EQ9wa9aa5Zuum1mzidXIAcbScjS7MfpGGdr7d/NHxOD7gVg2N1Ny2CYJXG
	xahSBLHf9TW8E1j7cL46kEdkG2a7S9WCD1RcI3q9b7fUzYUe36vbr7llUm3HA4xB/XvMb3QGaY4
	yRctpDVyqL2BrSPZJ2J+NHEQycn6+dt2o6RF/UADyynoc1t16Hu7zXznDx/xFXRHGy4znEdp4CS
	2J0jqgeCL2f9mo5TxiFyP5djAbYrYsrKaTNX/6rIdt/RH6mJ6xvgJUId5g3SN39IcYOREO9/DkV
	VENF/xcP1
X-Google-Smtp-Source: AGHT+IHg2tHHiKueKs6xvAo7xLj09H6Qy+ABxe4CoeV7u4nYMJWg0MKaXFmFUVLriDrlyx5PEMiYUA==
X-Received: by 2002:a05:6000:188d:b0:3a0:b294:cceb with SMTP id ffacd0b85a97d-3a35c84f659mr2970619f8f.54.1747396040098;
        Fri, 16 May 2025 04:47:20 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d263sm2593376f8f.3.2025.05.16.04.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 04:47:19 -0700 (PDT)
Message-ID: <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me>
Date: Fri, 16 May 2025 14:47:18 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 keyrings@vger.kernel.org
References: <20250515115107.33052-1-hch@lst.de>
 <20250515115107.33052-3-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250515115107.33052-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

