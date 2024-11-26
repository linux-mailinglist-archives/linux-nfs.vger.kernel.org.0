Return-Path: <linux-nfs+bounces-8219-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586839D9065
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 03:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AABE280A61
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 02:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16431773A;
	Tue, 26 Nov 2024 02:29:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88D1401C;
	Tue, 26 Nov 2024 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732588142; cv=none; b=N6Cs09Ggoa0p+GDy5MmMO8qsjpdxy84bs0e7Uijjmn/dReXWA7nZsdMFlhpjgpv//+/Ip45G4LWJq3tZTDaBCho5unD03klG4mFvtbd2ycudHBJuPaatYzpDOhak8/5LuAwrSwroVWvh+7Mlfc+Obf6jR2WU+kfyBlwYaXfuA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732588142; c=relaxed/simple;
	bh=kuZYnR/rQMltBu9vu/0/wJU1aXYTLqaVFQgfOmI6f/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=I3MAMIW9SeOiUGtif+XiNNRdunhhuppu2kqIvah2XyzS1Zjof1be3VLTZ2oXh37Jh0HNxxWatSCOqdKzIz5wV1nB2L6RyNwJJ6wAhBfn4HybnW5E363grS2NY2sAtRgs07Sry95FtiE0drSPglnUQamOVDA4W4WbGFzYFE505aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xy605704zz1k0bZ;
	Tue, 26 Nov 2024 10:26:45 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 03A87180044;
	Tue, 26 Nov 2024 10:28:52 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Nov 2024 10:28:49 +0800
Message-ID: <9420a368-8d18-4920-b196-a65cb265a26a@huawei.com>
Date: Tue, 26 Nov 2024 10:28:49 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [bug report] deploying both NFS client and server on the same
 machine triggle hungtask
To: Mark Liam Brown <brownmarkliam@gmail.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <887cd8f6-3e49-410c-8b36-9e617c34ca6f@huawei.com>
 <CAN0SSYwzsVEvopiuJuQTbJkOeGhDtLLFMsetVM2m5zOa0JEwDA@mail.gmail.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
CC: yangerkun <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
	"yukuai (C)" <yukuai3@huawei.com>, <chengzhihao1@huawei.com>, Hou Tao
	<houtao1@huawei.com>
In-Reply-To: <CAN0SSYwzsVEvopiuJuQTbJkOeGhDtLLFMsetVM2m5zOa0JEwDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2024/11/26 1:32, Mark Liam Brown 写道:
> On Mon, Nov 25, 2024 at 1:48 PM Li Lingfeng <lilingfeng3@huawei.com> wrote:
>> Hi, we have found a hungtask issue recently.
>>
>> Commit 7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low
>> memory condition") adds a shrinker to NFSD, which causes NFSD to try to
>> obtain shrinker_rwsem when starting and stopping services.
>>
>> Deploying both NFS client and server on the same machine may lead to the
>> following issue, since they will share the global shrinker_rwsem.
>>
>>       nfsd                            nfs
>>                               drop_cache // hold shrinker_rwsem
>>                               write back, wait for rpc_task to exit
>> // stop nfsd threads
>> svc_set_num_threads
>> // clean up xprts
>> svc_xprt_destroy_all
>>                               rpc_check_timeout
>>                                rpc_check_connected
>>                                // wait for the connection to be disconnected
>> unregister_shrinker
>> // wait for shrinker_rwsem
>>
>> Normally, the client's rpc_task will exit after the server's nfsd thread
>> has processed the request.
>> When all the server's nfsd threads exit, the client’s rpc_task is expected
>> to detect the network connection being disconnected and exit.
>> However, although the server has executed svc_xprt_destroy_all before
>> waiting for shrinker_rwsem, the network connection is not actually
>> disconnected. Instead, the operation to close the socket is simply added
>> to the task_works queue.
>>
>> svc_xprt_destroy_all
>>    ...
>>    svc_sock_free
>>     sockfd_put
>>      fput_many
>>       init_task_work // ____fput
>>       task_work_add // add to task->task_works
>>
>> The actual disconnection of the network connection will only occur after
>> the current process finishes.
>> do_exit
>>    exit_task_work
>>     task_work_run
>>     ...
>>      ____fput // close sock
>>
>> Although it is not a common practice to deploy NFS client and server on
>> the same machine, I think this issue still needs to be addressed,
>> otherwise it will cause all processes trying to acquire the shrinker_rwsem
>> to hang.
> I disagree with that comment. Most small companies have NFS client and
> NFS server on the same machine, the client being used to allow logins
> by users, or to support schroot or containers.
>
> Mark

Sorry for my hasty conclusion.

By the way, nfsd_reply_cache_shrinker triggers this too.

Li


