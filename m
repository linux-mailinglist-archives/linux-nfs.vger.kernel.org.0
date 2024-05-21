Return-Path: <linux-nfs+bounces-3299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1126A8CAA77
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 11:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B379D28323A
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 09:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95954F5FA;
	Tue, 21 May 2024 09:04:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE86024A;
	Tue, 21 May 2024 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282247; cv=none; b=d3AmjG3TjKmSW+KxMrsu78lmM1135NvA7geZDOtS5EmMZZujR16QrthpvWMBnueMFfsYNtOo8dRDA0utd6Z+ZeolqpZL4qNMiXBHtK/HdMfp1kKpQuVkfzfM4pbrGegQ9PsPQm8rdjbrGs/pNwKkDC0t8P3Z05aetcBC3Blv/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282247; c=relaxed/simple;
	bh=ryi7S/ox1I8Cop9KJgN9dvwJOG3Cuoopvv1+27JLCaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/PTApyC9U5K90APc0W/saZyIxEQVUi5xO0/bq7wiw5RODYAa0vdTssuqW9gPaEZMizqS7vJokUZg1AFg1FWyQfsqaidP2+X+ixfitEmmOFdKKihRNBCdCJ9A++yWIIgCaFn8G4qtQWaQCdQAESMkDsaZlg3brNDh/8u+Qu9gNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e453dc8a31so5012961fa.2;
        Tue, 21 May 2024 02:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716282244; x=1716887044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSzZjESN38Cg+ZfxMI26Ii7Ck/913zoNxa8ywVqlLbI=;
        b=lnzFPOm7BT9uovPQslICPWDkLrnjykxwYPJb3/aaH81VR+CbmURX2J5vF8W/Zk6xdg
         Xg6VXPXc4Bt32qjWaGVH9q+3Ytb4ssBRGUq8Hmx8UiU2L0QN5lj67t4drTWAvTa0m31z
         mLIvQTZa+1v3kFIA09RU9bckSEPXH7PLScoF7kzcQO+9quKa0ipx18g5DmkEwXVd7tC7
         nC/J02BwcxJNFxpkBOGwdcGHDHu0nyCQ4loHKrTWoewVABwUrVcN34es9SRJNLGWY7D6
         K6IJW/dQYKOsIqhJ08MOkz13MsG+BedS8qj60GA4LwbIh0g5UTt/WTnVh4QHxs7d40jC
         xf4w==
X-Forwarded-Encrypted: i=1; AJvYcCU6z15NHkwYY8SvrYZrBX+vJv9TwT1i/niUEuuN8JR4ndcf7ksnOBrVhJI9AxG7PyH+3b0rDknsurI31MVzslOtA2W5YvluJQETTA==
X-Gm-Message-State: AOJu0YzxGXvxR/v/fl4DtT7OKJS1r/eGrz9bVZsDf6vQl/dT3AQ8jIUc
	pBp1bqvX5W497oswTGzCIoEdzYxIzVPD6Z4KwbmYDWIJE4eElMqJufx1RA==
X-Google-Smtp-Source: AGHT+IHofwI/UfR0PHZHs2Jbdsf70Rpfwb/sOG6wpcx18xhrhrygF80DKEvg4zFxTZwOv0oj2sq41g==
X-Received: by 2002:a2e:b618:0:b0:2dd:87a9:f152 with SMTP id 38308e7fff4ca-2e51fd4a736mr183846221fa.2.1716282244020;
        Tue, 21 May 2024 02:04:04 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fe1ab43casm252217005e9.1.2024.05.21.02.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 02:04:03 -0700 (PDT)
Message-ID: <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
Date: Tue, 21 May 2024 12:04:02 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
To: Chuck Lever III <chuck.lever@oracle.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/05/2024 21:05, Chuck Lever III wrote:
> Hi-
>
> I've tested this with two kinds of systems:
>
> 1. A system with no physical RDMA devices and no start-up
>     scripts to load these modules
>
> 2. A system with physical RDMA devices and with the start-up
>     scripts that load xprtrdma/svcrdma
>
> In both cases, after doing an "rmmod rpcrdma", I can mount
> a "proto=rdma" mount or start the NFS server, and the module
> gets reloaded automatically.
>
> I therefore believe it is safe to delete the code in the
> rdma-core start-up scripts that manually load RPC-related
> RDMA support. Either the sunrpc.ko module does this, or NFS
> user space handles it. There's no need for the rdma-core
> scripting.

I didn't know that rdma-core does this... it really shouldn't, the
mount should (and does) handle it.

I also see that srp(t) and iser(t) are loaded too.. IIRC these are
loaded by their userspace counterparts as well (or at least they
should).

