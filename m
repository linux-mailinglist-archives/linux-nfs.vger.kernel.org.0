Return-Path: <linux-nfs+bounces-4130-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B39D490FCE6
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 08:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E7F1F2151D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE03BBED;
	Thu, 20 Jun 2024 06:41:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752DE3CF63
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865674; cv=none; b=HGvLlVk2TRXtHIVNgiLxcqm8C21bkWXa7W/RJQlA5R3L+BB0x5j4r+AhRm3fSrEiHXq0nUjVk6tYusJUn4/snJQCXzxc+FLRSeiqkW/STWe5X0k6P8SXP5nXP4zKi9Q19ZVGSvmgOOEwR3NIfI1Bgx2/wSZ/JWejmdGnu8JYwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865674; c=relaxed/simple;
	bh=dn1uaZqjMQmXs9Dn+vvuBwOJS6befM7aLPfrkjhJjuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtfHUgEob2ZTqhDPqGphdgJb2MYoUDGrg6b0/06kfh3u1HxcXl1eE8tOSTIU+bpYd36WUvFF+Xy9n3sCMMisqiAxVBRkly75aQQiROepJEYaZgwhKgG6HMx3v63lIrVuo2vbUkLFKiGuFQo5Gl9FWh6bsf7nTXCmzTsy0h1mM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec34f0110dso456871fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 23:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865671; x=1719470471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZsT847XYHsryNeSL0kQ3qaW7DZyw8UN2JvAQ68xS3o=;
        b=m5Xh6NRJETyWwM7dfLuHdRlysbSngipVa08oQhC/uEfyrTL7p52fstRLICNL7927Iw
         rPs7/LSm7YBRAEr4nmTZYMkoq3ivZfVFwRpO1ptdReqCdsWWIciQ+dau1frMIxG5uVzi
         S+L6cfemgQr36+5xp6nH+MPqaB7/OAQPqw+fN5cFADemaadmze3Ey5nYlcFz+A1SXpWB
         QHuVL7REzgmILQ3MQL4jvbJ1rOvyCiGlERwTEK9gvNLM/Seqc01CJm+znp6vVz/ksB4I
         2JG08fvIXPnjxHWEvSTt3INxwNTaO5ZSq6H530oMgT1eQiJW9pn1uiVVgxXJg0E763Le
         PqrA==
X-Forwarded-Encrypted: i=1; AJvYcCVrUmmuEhOQIAGXOaE1TjWw9BcFjm/GACFDxZI0R7zmnvKqw6P2ZscjwNYtijSneluIqCuWBGOeZbxXolBjWNEf/F1sEnws4f8F
X-Gm-Message-State: AOJu0Yxbhp+6wllRK4jstjSMsYm/b68aRAMmnnvPHs5DkMCeLjoB9MAM
	uaP4srojdbc7Uhd27Ysb9SwsByKGz34L2So/ntT5AK4YeWphh+rOGovGCOWi
X-Google-Smtp-Source: AGHT+IFF0a7k/pKwiM7k9hGAYeRW4qGSSG6U+decCYUM0NmRwq1V16UCb2O8GQQl5mU4uTHneHPCBg==
X-Received: by 2002:a19:7719:0:b0:52b:bd23:1e9 with SMTP id 2adb3069b0e04-52ccaa4eb27mr2135538e87.1.1718865668381;
        Wed, 19 Jun 2024 23:41:08 -0700 (PDT)
Received: from [10.100.102.74] (46-117-188-129.bb.netvision.net.il. [46.117.188.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c9e27sm13745025e9.23.2024.06.19.23.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:41:08 -0700 (PDT)
Message-ID: <23b020f4-c666-41e2-a919-200cbe425c3c@grimberg.me>
Date: Thu, 20 Jun 2024 09:41:06 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
To: Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
 "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20240618153313.3167460-1-dan.aloni@vastdata.com>
 <d2f48ca233f85da80f2193cd92e6f97feb587a69.camel@hammerspace.com>
 <ae298053-bdee-4a8a-b6a9-e57de79abc97@grimberg.me>
 <5366ff2a4f731dbd93a56e109d6809a5348cf080.camel@hammerspace.com>
 <50f63382-eeb1-4615-a0ac-987afee11902@grimberg.me>
 <ZnO9toGg3ARR3e8V@infradead.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZnO9toGg3ARR3e8V@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/06/2024 8:27, Christoph Hellwig wrote:
> On Wed, Jun 19, 2024 at 05:31:08PM +0300, Sagi Grimberg wrote:
>>> buffered I/O model. So this would allow the user or sysadmin to specify
>>> at file creation time that this file will be used for purposes that are
>>> incompatible with caching.
>> user/sysadmin as in not the client? setting this out-of-band?
>> That does not work where the application and the sysadmin do not know about
>> each other (i.e. in a cloud environment).
>>
>> The use-case that is described here cannot be mandated by the server because
>> the file usage pattern is really driven by the application.
> The way I understood Trond is that it is set on the client, but the
> application or and out of band tool.  Think of the attributes set by
> chattr.
>
>

Got it. thanks.

