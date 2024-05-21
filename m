Return-Path: <linux-nfs+bounces-3326-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997F8CB4B2
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 22:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DD1280F46
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21BA47A5C;
	Tue, 21 May 2024 20:30:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3C148859;
	Tue, 21 May 2024 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323405; cv=none; b=mvUv3GQ+XGxqZosq6/xOLYkNpa73IwtpjV27pLlezjr+7XLx7fHmMbmpV/XCGV4OgEmuwSH5Vr6cLLt6v3e4ij3N/9MYPjJfV9ayUMg7X6mULElxIGnLbzUPe2FqzoBjFhOlnm3wl4jsy0d6cs0BOA31C1nRm9kyr95VA+WJp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323405; c=relaxed/simple;
	bh=REPPD3/QxGm/foe008HDatdc3yEaCB2y19sXXcBxzS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5/Nfgr6HZO1sBLuwZ7sCJoE4AUxO6MRxzSepugfPzANLSYqCDhj5DtkmgVJ8ql0/h/Lz/QP+aj9PktKD1ii8mQoH6rJoH+nXmIwbZjGrs6pqGX897kzTzqlWrJBSP+7ftp8dfbO8bfeELhZ1RBAkSdGua6F2q/f/9eJkstVMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354ba9ae540so8373f8f.3;
        Tue, 21 May 2024 13:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716323402; x=1716928202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ+0N0yyVOf0onhV0hCjVY9l0NjY263MvxLGexHvtgc=;
        b=JUr3W7iRL8094MsDvNZowEGNT9CXGKzFyi+6iGHjZM3qcFHv27qj7vA8jAy+yX98lW
         G9LZjLWKnOJr6gshwX3q4yz7hMoBbSgelNKiRXAdCez631ZXjOLUhUkoRDQoWN1eh/eg
         MwEl3iukx/fEDZiNthGyn37pCQsPpoD7pZiN7eP+n7UX0RnmBtPlK2p79b6tDFmW6D+n
         +8X7HZobBzqRjhwZugPcm4+u98rCwc6bLsFTi3YR9Tb4sqIviPPRG9L/cNbx6iz8yAPX
         vIOrywz96S/7aa/BM7qKI0IC5Z33IJeCuWP4xQ9hQUTiL7FxsxWLcsgCfNLqLUNv8I0S
         gImQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRZrbb6BXC8QQBfsHk1r2nND+TY5DnuAZyVwXZtV1ouWQ/SJdmebD962cT5tEoXBdDMYlGqasfcErlZCtEfQL6SAbxFUK+oqgYgXIR83Op34ScLO7g5BboLXorhPfvMMwMAv895A==
X-Gm-Message-State: AOJu0YxIa7mRWuqvWuP6u7hvnDZNcqGGSe+6HPZi/1kPf3GVCR+YPspV
	wCd8ymKjp99yEze3NuNrMvwFECbxRf1wB6MXPEZsounmUjOhqbFW
X-Google-Smtp-Source: AGHT+IHVmNl98Y2krqdLGdn4F0u44B8pmPZRhUU2N+BTQtxbSgG1lIMO8gZO77D+XvLx6WCGSHD/xQ==
X-Received: by 2002:a5d:4492:0:b0:34a:c444:a93b with SMTP id ffacd0b85a97d-354d8db72eemr10878f8f.7.1716323402316;
        Tue, 21 May 2024 13:30:02 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3533b8850b1sm12614485f8f.63.2024.05.21.13.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:30:01 -0700 (PDT)
Message-ID: <0f9ddfe5-67ff-470b-8901-d513dceb757e@grimberg.me>
Date: Tue, 21 May 2024 23:30:00 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
 <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
 <20240521124306.GE20229@nvidia.com>
 <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
 <20240521133727.GF20229@nvidia.com>
 <46c36727-ef93-44ca-9741-df2325d4420c@grimberg.me>
 <20240521152325.GG20229@nvidia.com>
 <e558ee64-48fc-48b9-addd-eab7f9f861ad@grimberg.me>
 <20240521163713.GL20229@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240521163713.GL20229@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/05/2024 19:37, Jason Gunthorpe wrote:
> On Tue, May 21, 2024 at 07:10:53PM +0300, Sagi Grimberg wrote:
>>
>> On 21/05/2024 18:23, Jason Gunthorpe wrote:
>>> On Tue, May 21, 2024 at 05:12:23PM +0300, Sagi Grimberg wrote:
>>>>>>>> I also see that srp(t) and iser(t) are loaded too.. IIRC these are
>>>>>>>> loaded by their userspace counterparts as well (or at least they
>>>>>>>> should).
>>>>>>> And AFIAK, these don't have a way to autoload at all. autoload
>>>>>>> requires the kernel to call request_module..
>>>>>> nvme/nvmet/isert are requested by the kernel.
>>>>> How? What is the interface to trigger request_module?
>>>> On the host, writing to the nvme-fabrics misc device a comma-separated
>>>> connection string
>>>> contains a transport string, which triggers the corresponding module to be
>>>> requested.
>>> But how did nvme-fabrics even get loaded to write to it's config fs in
>>> the first place?
>> Something (/etc/modules-load?) loaded it intentionally.
>> That something knows about a concrete intention to use nvme though...
> This mechanism we are talking about is an add-on to /etc/modules-load
> that only executes if rdma HW is present.

Still does not mean you want to use all the ulps though...

>
> This is why it is a good place to load nvme-fabrics stuff, if you
> don't have rdma HW then you know you don't need it.

Do I want to autoload nvme-fabrics if I have a nvme device? do I want
autoload nvme-tcp if I have an ethernet nic? maybe wlan nic is also a
sufficient reason?

I just don't see why the presence of an rdma device dictates that all 
the ulps
autoload. Does rxe/siw count as rdma HW?

>
> Autoloading is the version where you do 'mount -tnfs -o=rdma' and the
> kernel automatically request_module's nfs and then nfs-rdma based only
> on the command line options.
>
> I'm not sure this is even possible with configfs as the directories
> you need to write into don't even exist until the module(s) are
> loaded, right?

Right. The entry-point of the subsystem needs to be loaded (nvmet is 
loaded by nvmetcli),
the individual transports/drivers are auto-selected.

