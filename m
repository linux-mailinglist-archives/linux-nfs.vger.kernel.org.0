Return-Path: <linux-nfs+bounces-7510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F6D9B1404
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 03:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCE01C213C0
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 01:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56615AD2F;
	Sat, 26 Oct 2024 01:32:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2F5661;
	Sat, 26 Oct 2024 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729906322; cv=none; b=DEuuHOG8bNrSDBQmZ73+kvEGZBjzBYGmCW3hThhy1bYDS97CdwixvoTFKRJCKzeCdRRzVAmnAIPaiuGpONpT9ms1kU2BP7LMswy8UmXF9qJuQHoJuBQlUhfxQyBKFhfLj1Gt2DIF2h8Q+tQxW2cVWgumenqmBwSW3NrO6PJVCs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729906322; c=relaxed/simple;
	bh=/R2YWndKMuTsGPtKPr5ksGflR0iw39i3JlMtvf+tlpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gGp8Sacgpu3N0ICvDMNEhEsecUYMGymEQGY0IHlIXCGa/6HxQyRjAyKvfephOevk3x+JJbURWhZBMBTVeuGiCaXDgqut639L8vtU6WZCjOZ0n87pEHRumBLnKn9GupvdBvokOH9No1wbSZI/09AUSukGOxnCBYSQMB44423IZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xb2CT22kwz2DcST;
	Sat, 26 Oct 2024 09:30:29 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id C52981A016C;
	Sat, 26 Oct 2024 09:31:55 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 kwepemg200003.china.huawei.com (7.202.181.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 09:31:54 +0800
Message-ID: <c9e2009c-6e10-45df-b681-df81da2ced2b@huawei.com>
Date: Sat, 26 Oct 2024 09:31:54 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel tcp
 socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>, <trondmy@hammerspace.com>
CC: <Dai.Ngo@oracle.com>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<davem@davemloft.net>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <linux-nfs@vger.kernel.org>,
	<neilb@suse.de>, <netdev@vger.kernel.org>, <okorniev@redhat.com>,
	<pabeni@redhat.com>, <tom@talpey.com>
References: <0e434c61120b5b4a530731260c0f2c72ad02fa6f.camel@hammerspace.com>
 <20241026004837.57278-1-kuniyu@amazon.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <20241026004837.57278-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200003.china.huawei.com (7.202.181.30)



在 2024/10/26 8:48, Kuniyuki Iwashima 写道:
> From: Trond Myklebust <trondmy@hammerspace.com>
> Date: Sat, 26 Oct 2024 00:35:30 +0000
>> On Fri, 2024-10-25 at 14:20 -0700, Kuniyuki Iwashima wrote:
>>> From: "liujian (CE)" <liujian56@huawei.com>
>>> Date: Fri, 25 Oct 2024 11:32:52 +0800
>>>>>>> If not, then what prevents it from happening?
>>>>>> The socket created by the userspace program obtains the
>>>>>> reference
>>>>>> counting of the namespace, but the kernel socket does not.
>>>>>>
>>>>>> There's some discussion here:
>>>>>> https://lore.kernel.org/all/CANn89iJE5anTbyLJ0TdGAqGsE+GichY3YzQECjNUVMz=G3bcQg@mail.gmail.com/
>>>>> OK... So then it looks to me as if NFS, SMB, AFS, and any other
>>>>> networked filesystem that can be started from inside a container
>>>>> is
>>>>> going to need to do the same thing that rds appears to be doing.
>>>
>>> FWIW, recently we saw a similar UAF on CIFS.
>>>
>>>
>>>>>
>>>>> Should there perhaps be a helper function in the networking layer
>>>>> for
>>>>> this?
>>>>
>>>> There should be no such helper function at present, right?.
>>>>
>>>> If get net's reference to fix this problem, the following test is
>>>> performed. There's nothing wrong with this case. I don't know if
>>>> there's
>>>> anything else to consider.
>>>>
>>>> I don't have any other ideas other than these two methods. Do you
>>>> have
>>>> any suggestions on this problem? @Eric @Jakub ... @All
>>>
>>> The netns lifetime should be managed by the upper layer rather than
>>> the networking layer.  If the netns is already dead, the upper layer
>>> must discard the net pointer anyway.
>>>
>>> I suggest checking maybe_get_net() in NFS, CIFS, etc and then calling
>>> __sock_create() with kern 0.
Only maybe_get_net() is enough. sk_kern_sock also needs to identify 
whether it is a kernel socket.
>>>
>>
>> Thanks for the suggestion, but we already manage the netns lifetime in
>> the RPC layer. A reference is taken when the filesystem is being
>> mounted. It is dropped when the filesystem is being unmounted.
>>
>> The problem is the TCP timer races on shutdown. There is no interest in
>> having to manage that in the RPC layer.
> 
> Does that mean netns is always alive when the socket is created
> in svc_create_socket() or xs_create_sock() ?  If so, you can just
> use __sock_create(kern=0) there to prevent net from being freed
> before the socket.
> 
> sock_create_kern() and kern@ are confusing, and we had similar issues
> in other kernel TCP socket users SMC/RDS, so I'll rename them to
> sock_create_noref() and no_net_ref@ or something.

