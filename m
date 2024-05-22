Return-Path: <linux-nfs+bounces-3340-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421CC8CC767
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 21:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731AB1C20D16
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA45A134BC;
	Wed, 22 May 2024 19:40:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219587BB01
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406843; cv=none; b=Fqtwy3qGtpxRa3PU14WK/B4oOsJuN+vDoR3hYLaXmMtuS//RWx9OorkMI4HzvWnlz8xHXT3IA0P1i1wC3spdiYVMF3SwRUOWZ0awS54HM+lgF668enuL/JwOmCMskdZqeJ2ZHZdsvhALvItTk6kXKcTSBbyZZhsVGZ/zGuZhdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406843; c=relaxed/simple;
	bh=gDjeJZgaSxzV2bdDDJcyrwo5uymOIFhqW6OF4c5ZMYg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lDT4IRG5/Ts903AjmnigG5xYSyMBtyZK83ZFp8NPwv2Mmaxr6mTIg16oGerYUfGEivOUev5kzcW2Fq1hPhzcMPaKdcY7v3GzB1PAxnB6c1OOIcwG+wPc85Uc5IhBPhe+oIwqJ7YPFvoDmBj0e49/cvFvWCCYlR22nTEwH3QQoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34ef40fae25so283822f8f.1
        for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 12:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716406840; x=1717011640;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYSzCVqGVCN6hRR0v4IyYrc8OYj7KgCuAfX9b8bLwok=;
        b=nKLn+VAKo+7Pco/rAW09/I3dUN3c5R0zwJciJgJbrEFZTWRKmj/B0gvGCk1n+nN/8J
         uS/s+mssVNrZ1+AjyK8yr/sYlQWfTLCBNToR3wfsmUhI+iXCwtZti31K1lqQrnQrMoBs
         /NSJiIyKGTT6x4E3pD0lPAzhPoaDuiRAefPipLT8HgsG1wPGOaH6PNv3FuRewNF+Acuk
         wyjdm4vTrYYCtUXl1uEwdS+LTjhvRlF+dY4sKbJCScbS4da6iGQA+nH4cthtKWP0HcV+
         9E8wVKxKwdCV1HM4HhrG5CqhZishMbKpgoUjM4tFYBCgXtXewzd7BTvbnP85sC5e7jU/
         nCAA==
X-Forwarded-Encrypted: i=1; AJvYcCVWlVOdkDyB3TAFekAhSX4/EfAtWltLGiPY4zq/6cjO3QlCHv/XeSW4+w3lhDltbd/xa+PlC55viFFfnK7/6VLMyVnZxhSO3tGV
X-Gm-Message-State: AOJu0YzoorvoYywV3JSa1qmoxaV46LDxwx5jIrgliZA2GsSCQgPgzicb
	wqvNtHb7dG9IU0GfO3ZLjPmEt2lG/A+b5+Pz3ThB3390jd5zJdm7zuRKLw==
X-Google-Smtp-Source: AGHT+IGNPo+DYbsBldVVh7LHxlzpvSrfdNAGLleuJvBODfJI3Q6q5cqzoZ91RxCMnB55owoviB/0kg==
X-Received: by 2002:a05:600c:4fcd:b0:41c:a98:b217 with SMTP id 5b1f17b1804b1-420fd3975b8mr23156555e9.4.1716406819584;
        Wed, 22 May 2024 12:40:19 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f14436sm3441885e9.17.2024.05.22.12.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 12:40:19 -0700 (PDT)
Message-ID: <c1d98e76-1b5c-4d91-a7fe-9412df7c2fab@grimberg.me>
Date: Wed, 22 May 2024 22:40:17 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
From: Sagi Grimberg <sagi@grimberg.me>
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
Content-Language: he-IL, en-US
In-Reply-To: <4d2bc7f1-b5c2-469c-9351-772626c707d7@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Trond,

>> filehandle is stale? There will have been an unlink() on the symlink at
>> some point in the recent past.
>>
>
> No reason that I can see. However given that this was observed in the 
> wild, and essentially
> a common pattern with symlinks (overwrite a config file for example), 
> I think its reasonable
> to have the vfs at least do a single retry, by simply returning ESTALE.
> However NFS cannot distinguish between first and second retries 
> afaict... Perhaps the
> vfs can help with a ESTALE->ENOENT conversion?

So what do you suggest we do here? IMO at a minimum NFS should retry 
once similar
to nfs4_file_open (it would probably address 99.9% of the use-cases 
where symlinks are
not overwritten in a high enough frequency for the client to see 2 
consecutive stale readlink
rpc rplies).

I can send a patch paired with a vfs ESTALE conversion patch? 
alternatively retry locally in NFS...
I would like to understand your position here.

