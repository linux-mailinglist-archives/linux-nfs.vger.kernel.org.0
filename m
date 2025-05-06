Return-Path: <linux-nfs+bounces-11517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D3EAAC7DC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF001C41946
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF0D278E5D;
	Tue,  6 May 2025 14:25:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62C25229A
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541506; cv=none; b=kk9piwQnMhEN5Xkwh004S83zY8CdAv3PwaO61vSnsJ3hhBSRwH5IRRdqnWVSGHtxYYheoEPmYk/xqq+JMcAUc2Tn+IDMl46TcrY391ofA52s0efhVi75q97tSVqAbWFIHo9unGmKUxB+SyiUnAF1/PSI19I6CYp7aU9IIAQScN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541506; c=relaxed/simple;
	bh=YkW7k8DL877S9Z+krLGfLAMcqy64yXdy3WGZocsuYBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruRHfvPorZwJo0SOkNhRmH6fiINYfXrqpOvxBoogJYdBYGrclB8kiRIs2FJEJsRnNMFH85HkqY/dm7IgDBsLh9uRze2RV/2oikTLLFGjwWKKt/naRjOYtPA5Rg/0gBjsV0kqCm6g7F4/m3ue+nNlRIpyDfq1pnsn7I09xnz/h9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39149bccb69so4488216f8f.2
        for <linux-nfs@vger.kernel.org>; Tue, 06 May 2025 07:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746541503; x=1747146303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvsXPRjapGX+pKhWFSd2fnU9w6GIHChDgJN5j2nseIw=;
        b=a1v5W78/EYY+s/VkX7PgAuR4V8eeqMp5e2RmwfDzXtmXyerAlQ26Ib4rp36DelG0lg
         mh5qwekJlzEatYD927UnvJI9wJrebBRjZ4OqwVb8a7vxhvwpC9f464gZBMxVOCqxVRE5
         wU8TcMY/5eJPZYWccnjsNs2oK306ZZKiEYo97SUnyvFBfHQS8pWuZnqirDpP9Mgp4MwQ
         VlENKdou1wd28UpE2pMeQqabQxe3+gWd02LiY5styi0skgPedkSg3/bn6M48p+4bJAca
         uNpugJ2NcF4/gBTiuyILZ15B4LIdgISZ5tWbi6IC9ucBHCsb7aGc++KLW1DPaUCFRRMd
         8qqw==
X-Forwarded-Encrypted: i=1; AJvYcCUaCVdl5tmmgS69GQHLA/m64sJSWMZwf8tK+y2T7ueWp4vO7f6eFNNi1gTXLLrRqcNX6OjqSojM71k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFJjTdnuaGCUj8QW1k3kTbAw5bayhQPwBbdrK3nmHeX8oG9DU
	dhHwdsWBNMB1TjYSF2Vm1n7dLD+JFFvUMgEZkqWyO0WUfjkMj96X
X-Gm-Gg: ASbGnctBUsar7XjSIW3M9gOSpoXxhzj7Wa+OGicDlVp83Hon2lDm9cKOBhKh4s2Krw9
	9Yp1iezMLK7eKVWnNXCINIpqFenyHF2Ql6dGJGkOhcRM5g98MDXHwOIQj9OQOcJrCbt5mq/7Oke
	sbX/oJD+vwrBmGNGTyEzeBr1zmK8qZknCgKqIXMbSPIGpZmPICYPxVHS31vvr6bK4KipCvnVQu7
	wDLWboFucssEkxn/r8ZODpQMJjDHCj7JUBn28LHOHRx6Et81EaQsrQmiHkJa3PWw2DEnnGeGbsx
	lvLDWobHq1aoZ58GJZZjiI+8Ln++bUquDD5n874PcUTUIqRsIbU5Jgxj5gJxieXNsV5eLzRNCPd
	v06MUbg==
X-Google-Smtp-Source: AGHT+IGKmeZAQSypyqZW/ALp5mTKeLZEf84qATnpNete3X8pOOEiO0723FFVg68oNTOIlqEiebM/kg==
X-Received: by 2002:a05:6000:2a7:b0:38d:badf:9df5 with SMTP id ffacd0b85a97d-3a0ac0da1femr2555157f8f.17.1746541503222;
        Tue, 06 May 2025 07:25:03 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7a46sm13650438f8f.44.2025.05.06.07.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 07:25:02 -0700 (PDT)
Message-ID: <44220569-ce61-4bc9-ab38-e2116e7b5da6@grimberg.me>
Date: Tue, 6 May 2025 17:25:01 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET
 when timestamps are delegated
To: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <Anna.Schumaker@netapp.com>, Thomas Haynes <loghyr@gmail.com>
References: <20250425124919.1727838-1-sagi@grimberg.me>
 <67a837dbebdbc6bb457998b1f61358970f31a4ed.camel@kernel.org>
 <f66fd307-c5d6-40b5-87b7-fc6450cc09f1@grimberg.me>
 <6843f5bd39e7a9237c44c4b8e0099bb234b3a732.camel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6843f5bd39e7a9237c44c4b8e0099bb234b3a732.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>>>    
>>> FWIW, we've been chasing some problems with the git regression
>>> testsuite when attribute delegation is enabled. It would be interesting
>>> to test this patch to see if it changes that behavior.
>> Can you elaborate? didn't notice that git uses the times ATTR_*_SET
>> variant too often.
>>
> Unfortunately, not much.
>
> If you turn on attribute delegation, and then run the git regression
> suite in a highly-threaded configuration, some of the tests fail. I've
> made a couple of stabs at trying to narrow down a the reproducer, but
> no luck so far.
>
> My guess is that it's a client-side bug:
>
> The server is fairly simple here -- if there is an outstanding
> delegation, it asks the delegation holder for attributes via CB_GETATTR
> and then passes those along to the client.
>
> The client however has traditionally relied on the server to provide
> updated attributes, rather than handling timestamps itself, and it
> wouldn't surprise me if it just didn't get all of those places right.

It's running, not failing yet... Which test cases fail?

>
> FWIW, I did try your patch with that test and it didn't help.


