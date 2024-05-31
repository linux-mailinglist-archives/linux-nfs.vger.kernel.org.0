Return-Path: <linux-nfs+bounces-3500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A5A8D5944
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 06:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77851F22D13
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 04:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C6200CB;
	Fri, 31 May 2024 04:24:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E431CD3C
	for <linux-nfs@vger.kernel.org>; Fri, 31 May 2024 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717129453; cv=none; b=hBgjn3gVRbWvUgWnc3QrL3lappIymjwkx+bB00FDNt7uD8Bc3teMyYLb+1dBFi9ms5h8FWvwZLrJ3J2lcdWkP++quCcwmCQzo8Fs/wXmRzlmlI/UlVDo9lxsIkuV9Xak40T7IQYk/6G7tUyI++4SjGwn0peef/W9AlpZe5dxvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717129453; c=relaxed/simple;
	bh=e3ijhfQYSmRemYC/MKSJYbKMeWApntfY0r+p6XCoJ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aY6Z+z/hAADid4UAT+G0qPPB3xnj97WnapHwNd4kknhAGoQGtB6STGxoSm7kAkLv4wo2t8TKKXfRLCmZl6Y+6rf4N0xAPoeM0AgpfGcLrGWLgcwpOD+EXJiU5B4b3Fb7bk7NLCINrUcv+yjpMeo31cIPrjoRLVa15nxrJRkc64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42111cf2706so2134595e9.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 21:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717129450; x=1717734250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3ijhfQYSmRemYC/MKSJYbKMeWApntfY0r+p6XCoJ5A=;
        b=RlAE5aelijoatLD2U/N8HQCfWEAeIfgoKQWQkzCyAf3UOzFKtOx1Ue6065/7TCV9Dv
         GBTDIn1rWdef3nDfbaF+weLL9qC2v2gDgEixWVidwZLTb9sxeYZGzWRb682fmX/z+lGH
         a6O2siBxPNADSCbxoGGsoL3DwKjlyNhPZjIRNccOq4JvkaAyBhzXnTyiZvMdpDyWkWeQ
         /knnSuqwMa1XU0OBwtV7NWWSZnnMWcT2q/XiuCIiQG7OmzzCc+2bNpXdJNKe7AgNlnS5
         eZUop/FAhhI4MKLq7SNLOG0CwIOiXuhyJW8E07XbMXWn5hTW/lqPos5eZ3ILLJ9vljS3
         0btQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtcdXqee+aYsk2IF2ziLN5QdNWf/VqKz7mVe5xLT8YZiH8OOJ0EPskSR6M0bC6DE/nzQ0PwHkcnXi5Hzw3PWeCeHxhWXodIUG/
X-Gm-Message-State: AOJu0YxBWYkzbc0CYc5izn5iS1zWqC5OrhePaZcIXuSvFi9Dgm8chz2I
	ONtf47aKAwmjcHSvxpsGmt6ZVkA/2sOnga6Lw6VMEvZQGbBMLPtZ
X-Google-Smtp-Source: AGHT+IFbR+uk7pszHMnAlhm/XkVjCJNqkk5SPvHlSdSuoYe2L8V6UXorkBZiAWMQLARhcENIBms7wA==
X-Received: by 2002:a05:6000:1052:b0:354:f768:aa00 with SMTP id ffacd0b85a97d-35e0f3066e9mr342369f8f.4.1717129449613;
        Thu, 30 May 2024 21:24:09 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04caea8sm877047f8f.28.2024.05.30.21.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 21:24:09 -0700 (PDT)
Message-ID: <5971979f-65b2-4620-8800-52cea1718bce@grimberg.me>
Date: Fri, 31 May 2024 07:24:07 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
To: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>
Cc: "hch@lst.de" <hch@lst.de>, "dan.aloni@vastdata.com"
 <dan.aloni@vastdata.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <20240521125840.186618-1-sagi@grimberg.me>
 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
 <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
 <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
 <4d2bc7f1-b5c2-469c-9351-772626c707d7@grimberg.me>
 <c1d98e76-1b5c-4d91-a7fe-9412df7c2fab@grimberg.me>
 <e4e181e4a7b2db4b27b6ce3e6bb26b23e514cdb1.camel@hammerspace.com>
 <81fa32fb-c5a3-4af8-a8ca-08905a8b62ef@grimberg.me>
 <ea5efcf6-4414-4a66-ad2e-9e9060bf5dbc@grimberg.me>
 <f3c1ffe903c9b2dd9fcd131bdbab731ea1c4027e.camel@hammerspace.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f3c1ffe903c9b2dd9fcd131bdbab731ea1c4027e.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> Hey Trond,
>> is there anything else you are expecting to see before this is taken
>> to
>> your tree?
>>
> It's already queued in my testing branch:
> https://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=shortlog;h=refs/heads/testing
> I'll probably push that into the linux-next branch over the weekend.
>

Ah, I was looking at your linux-next.

Thanks

