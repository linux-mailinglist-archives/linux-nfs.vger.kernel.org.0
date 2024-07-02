Return-Path: <linux-nfs+bounces-4512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F26491F0A0
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 09:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA2E1F228DB
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 07:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE0B1474D3;
	Tue,  2 Jul 2024 07:59:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F155C1A
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907165; cv=none; b=OS1pbSlfeQaQhv2xT3EPk0QiuWKyG8z/9Y6mLNZ1p+WHHJaMEZoaaxxKZPkr0HlU+KZDqsv9apGE7U8Tp229sjzFFq3cNOxIHSXd7AwhdyUmrQ2Yo9yVlMwFG89FHpeHZ2chmcT9uHjCFSP1j2Pmh+Qv2p0tKv5VieniFJfL9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907165; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwhLEBFb9NX7wOJPlb9LK6A4fqMcov0QrPJ2m9IHsK2Zx/13qFDGTfWdebwruZRtYY45ys1WUqMy4vYXUG6yPUqTT71p4/yGgEXf2IMyekdYQ+xW59++a+JzFMc4f0ke6SIe5RB8IsXDG0bzGYxN2rBHNdtG3MWPfqlCYNJZkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36353a5d2ceso101445f8f.2
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 00:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719907162; x=1720511962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Fnrny2Z/gjVCoq0OE1pFwNIXsmcP1ORM+U52nMw4InDw2V4iR6tcbd5EHgXElIw0c6
         i7qOO7S3Mj0tLb/SFO/1JBjCoZWKJJjNbIcFQuRDVtRSOhtrDDSHiXvsYu+ryb9aPmMP
         utLm2DburQMXUr9bh/uSoatOI19XngGfWCxRHzslsCKuVkpcP95onxIeaKaBk7Dj01+E
         cI6REpatHCZp0cAiLfGpA20yDgByJcQ35UdK+Fib45uo3o/UI70TjOFneuFtEnSfq7ON
         OPomwdgzFNMiWAVrStX8eX2Z1UEII9JS39ZAyU58L8uaK9cAxL6M80hCB6LHKAB30mLZ
         gJ9Q==
X-Gm-Message-State: AOJu0YxVMF/gDdu3bkU3oWZ8J+uIwXNkq3bSu2BL+DTXd2aD+ES4JikL
	wLqpCb/DONSs7K3MtIXD0J8QW+rbT5HNxqy7WouU/6mul31mG+F9
X-Google-Smtp-Source: AGHT+IG/dF1TakGflZ3FaXh1/GZn0YmXnzeW8fLuPHuUXvt8fefjG9bxRFsfRkLQVVgjmdiTGjqdOg==
X-Received: by 2002:a5d:64e2:0:b0:360:8490:74d with SMTP id ffacd0b85a97d-36775730a14mr5589537f8f.5.1719907162212;
        Tue, 02 Jul 2024 00:59:22 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8df0sm12481407f8f.29.2024.07.02.00.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 00:59:22 -0700 (PDT)
Message-ID: <0d860d4c-f3bd-405a-81f3-8722c9edbb80@grimberg.me>
Date: Tue, 2 Jul 2024 10:59:20 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] nfs: fold nfs_page_group_lock_subrequests into
 nfs_lock_and_join_requests
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20240701052707.1246254-1-hch@lst.de>
 <20240701052707.1246254-6-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701052707.1246254-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

