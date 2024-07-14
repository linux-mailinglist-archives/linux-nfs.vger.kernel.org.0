Return-Path: <linux-nfs+bounces-4884-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6FF930A0F
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 15:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894A1B20E64
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49723770EC;
	Sun, 14 Jul 2024 13:28:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039D76050
	for <linux-nfs@vger.kernel.org>; Sun, 14 Jul 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720963706; cv=none; b=IHZbncm4awXtcsG6Ctvxk8+hP1EUzziYobea9h0XBmTfZ8smZWn7PDw8Q+4aPnMAF8E8cvLUFlPLifBVYu3ne7UpcKK3l3y8R6zT7DtEzXV44MynFp3i/LV5Av+/ppznUc02liZX3AbwWMDRV5zdS5T3Zm2zspNr9+Lx4o+Lw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720963706; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tq1UAg6BW3JyRWN08rO1aV1yBIzKPsb8trtqXuKLLcqhPZcFR0ABZBYadEe/uR+Zo6ROuQt7k1PK7gnTOBI5njLwJhpZAC13v1DbK5+NsUhAzxxjV7hIZZqPPf+EsU0skJNzPrxoKHbz+6w08h64X0LtROOcUdAVjmBsIkatnxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4265f823147so4307625e9.3
        for <linux-nfs@vger.kernel.org>; Sun, 14 Jul 2024 06:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720963703; x=1721568503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=F81JttIdcHufixi5JVmCKA4/C7O8wwj/cU1gto91hzvsj/m8IMGBbERSNxNl+dQ7i0
         YZGJu/3e2ZoY4e97j/cYi3mDtcr5hWsdmJk4P0tX+/Wl2M/U7bIjoR75RHQRYLLPw8Dz
         KXdjbRgNtlqSsgFjrMnMeZHyZGWcLhDtKTX4AHsaONiICbeXI33DlNH9wiTi7QUYuGcA
         kQx3Ysjz1ugaxK4MYNpU5OSbDfqLwD0OCkLkt+a5He+EqdpOWQJoXx+Y7EtezrXw5JYt
         6j7M09tGgS4GQy1Ra09y1AU49toCNkY/HMgcRHs5lBk4iU2pAIwaC91GEBt68f/Cr7w1
         NYBw==
X-Forwarded-Encrypted: i=1; AJvYcCX0f2YB0zyx/WYxlJh1enWwvd3Aoz3P+YEIUG8yEeQR2i+MrzmFCR7pTdyc5jmXtSMykDPvSZ7fuKVUbIHwoVrE6uKHtoZK1yPF
X-Gm-Message-State: AOJu0Ywc2YQFPRYDndlnPCRjrdd+QncePaYrqcq2YBOTnk7OYnQVOJF5
	djuw/96uKwmVj0eVjVyZgsGWqNHzcP2JcOR1P2wo4uQZaTuofyUi
X-Google-Smtp-Source: AGHT+IEdq4iSgA2LBuWeZ2snm6ffwpabIWsUgwRo5RKP6kX/NSyvAa+0Y2QopGIZD34BmxI6VsFFBA==
X-Received: by 2002:a05:600c:3b9c:b0:427:9f6f:9bff with SMTP id 5b1f17b1804b1-4279f6f9c1cmr32301425e9.5.1720963702940;
        Sun, 14 Jul 2024 06:28:22 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d74c6sm85668095e9.45.2024.07.14.06.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:28:22 -0700 (PDT)
Message-ID: <811f5f1e-488c-46d6-a592-50df35f65cc5@grimberg.me>
Date: Sun, 14 Jul 2024 16:28:21 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfs: pass explicit offset/count to trace events
To: Christoph Hellwig <hch@lst.de>, trondmy@kernel.org, anna@kernel.org
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20240711071703.65793-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240711071703.65793-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

