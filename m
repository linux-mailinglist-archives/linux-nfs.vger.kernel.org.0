Return-Path: <linux-nfs+bounces-4686-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB87929542
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 23:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA141C20A96
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 21:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FAE1CD31;
	Sat,  6 Jul 2024 21:40:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4547E18C22
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720302039; cv=none; b=JqY9Nvj92h++tH3JgmD4c8JtHjb7bZbLPtRzm+HZgbg39ypCyhECliHddQq5EBMwLvvczBBSXkk8H8JnVtDshGNKsoA2mUBGF5BUPSloo4byV7KLkFer43BOgQforFU4gg9WzWjuyTMVlSS1PNNCTtZQQ+2F+6h4GgU/5G42Rnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720302039; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5g0qz31yVY7SL/9HsUH4ryYHELZstT7wKBhvGaOJXXwC3k0BAWBepirSRX+nMMGAa79c3aAypPjh6GNRbYqU2FCOMForraL3gJt8uMKSOhABBztUsbqsJZ1rQNNOFd93u+3TfiNdEmodUGNGbtuEd6w6rLlkYBPLu+xjTEyLqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so3006595e9.1
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jul 2024 14:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720302036; x=1720906836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OIjQwKbLSNa4hoygzEM0pezHDRGfBn4kcgke70KeFm10LGM/ITNBZ43Wfjb5j1X+Qf
         k91TnwNX6oNHoZatZqbV7gaKGcqagLihK+eejDlA+W8NlODcyBG/xt1Y/jvLeDJditfi
         ds+7arB/g81CpEAPKJLDZnzpQzDxKrUF5wHlLI2DJa17OKWH6M1F1O8Lpewp04muiqsp
         mQNkXw15ds5nwrXWlfdJJJHmeGGsHo5iH7JHGGtdJZDhow4UBtsPbWbwIyLLUkr86yqm
         YU2vwCGow4JKn0AJTa9sB92aPT7g4Vi2W2a6BFls/ZvFNb8moDdUjr5ORvDHOEWzG1ZX
         KMhA==
X-Gm-Message-State: AOJu0YzIC8UlnaikPj5LFW/k85A3281dNbS3g8ZocZdfX3P/mOuIjQ6p
	dl0xgt25x00EkFPKEYM0o3vkftg0RfIqyew1Y1anQ+FbtRxg3+Hw
X-Google-Smtp-Source: AGHT+IFU8OXHetTIw90+ept+Yg6Csqmo55sASrs0jqX8TMQogALwWMr3/VjIevxAq7vpiZKTBs0IYQ==
X-Received: by 2002:a05:600c:1ca0:b0:425:73b8:cc4d with SMTP id 5b1f17b1804b1-4264a3d7fadmr54850315e9.1.1720302036228;
        Sat, 06 Jul 2024 14:40:36 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28d3dasm109387135e9.46.2024.07.06.14.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 14:40:35 -0700 (PDT)
Message-ID: <fb969e3c-e7c7-454e-82c9-9dda1cd8ee51@grimberg.me>
Date: Sun, 7 Jul 2024 00:40:34 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: remove nfs_page_length
To: Christoph Hellwig <hch@lst.de>, trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
References: <20240705053838.2043203-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240705053838.2043203-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

