Return-Path: <linux-nfs+bounces-8315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848119E1154
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 03:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495CC281822
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 02:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653C351016;
	Tue,  3 Dec 2024 02:33:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563E38DDB;
	Tue,  3 Dec 2024 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193181; cv=none; b=cZL+9xpIfd/IesgKN1gFsayFf+Syq+jaCi6EcDyo4UtUAsl2afoqAx8y9l1Gf4ODBsdrxcInB+UjTwU0lHxkmR2SKka/OCfUWmXsnf1AxGmI6fXgaaKhcxlN3nAC1fUiP0xEiLFO20y04XRH3lDfN405c+mfiloKgQjioaS01KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193181; c=relaxed/simple;
	bh=+9LVcEwIo6QDQUbVZLllWmynl+/S10V4KlESp46uoOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pkFLU3GqxctG0RBNwtZmLlcN+bMC8UpNC2Gvt/qa/uKGtf/V5nf01/K1cYfvrqavpkZqH3h0tGxk5oWUqkSU9yI73AFS1RYSQ2zB1PCergWSO6LXo2VIeZlQ8Q4h6XxKNU6fT7R8WQ1wJ0ZPm3jaHY7BeOXNDU/q6Y5cn+Riepg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y2Pkd45qsz1V5Sx;
	Tue,  3 Dec 2024 10:30:01 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 510BD1802D0;
	Tue,  3 Dec 2024 10:32:56 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Dec 2024 10:32:55 +0800
Message-ID: <88a5ad9b-03c0-43e3-8297-e30cd2b5d713@huawei.com>
Date: Tue, 3 Dec 2024 10:32:54 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [bug report] deploying both NFS client and server on the same
 machine triggle hungtask
To: Chuck Lever III <chuck.lever@oracle.com>
CC: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey
	<tom@talpey.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>, Hou Tao
	<houtao1@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, yangerkun
	<yangerkun@huawei.com>, "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
	Li Lingfeng <lilingfeng@huaweicloud.com>
References: <887cd8f6-3e49-410c-8b36-9e617c34ca6f@huawei.com>
 <8b155d3c-62b4-4f16-ab00-e3d030148d29@huawei.com>
 <D4E120A4-D877-48CC-AE40-D55DBB6265D0@oracle.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <D4E120A4-D877-48CC-AE40-D55DBB6265D0@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2024/12/3 0:05, Chuck Lever III 写道:
>
>> On Nov 28, 2024, at 2:22 AM, Li Lingfeng <lilingfeng3@huawei.com> wrote:
>>
>> Besides nfsd_file_shrinker, the nfsd_client_shrinker added by commit
>> 7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low memory
>> condition") in 2022 and the nfsd_reply_cache_shrinker added by commit
>> 3ba75830ce17 ("nfsd4: drc containerization") in 2019 may also trigger such
>> an issue.
>> Was this scenario not considered when designing the shrinkers for NFSD, or
>> was it deemed unreasonable and not worth considering?
> I'm speculating, but it is possible that the issue was
> introduced by another patch in an area related to the
> rwsem. Seems like there is a testing gap in this area.
>
> Can you file a bugzilla report on bugzilla.kernel.org <http://bugzilla.kernel.org/>
> under Filesystems/NFSD ?

Hi Chuck,

I have uploaded the dmesg log and some information from the vmcore here:
https://bugzilla.kernel.org/show_bug.cgi?id=219550

Thanks,

Li

>
>> 在 2024/11/25 19:17, Li Lingfeng 写道:
>>> Hi, we have found a hungtask issue recently.
>>>
>>> Commit 7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low
>>> memory condition") adds a shrinker to NFSD, which causes NFSD to try to
>>> obtain shrinker_rwsem when starting and stopping services.
>>>
>>> Deploying both NFS client and server on the same machine may lead to the
>>> following issue, since they will share the global shrinker_rwsem.
>>>
>>>      nfsd                            nfs
>>>                              drop_cache // hold shrinker_rwsem
>>>                              write back, wait for rpc_task to exit
>>> // stop nfsd threads
>>> svc_set_num_threads
>>> // clean up xprts
>>> svc_xprt_destroy_all
>>>                              rpc_check_timeout
>>>                               rpc_check_connected
>>>                               // wait for the connection to be disconnected
>>> unregister_shrinker
>>> // wait for shrinker_rwsem
>>>
>>> Normally, the client's rpc_task will exit after the server's nfsd thread
>>> has processed the request.
>>> When all the server's nfsd threads exit, the client’s rpc_task is expected
>>> to detect the network connection being disconnected and exit.
>>> However, although the server has executed svc_xprt_destroy_all before
>>> waiting for shrinker_rwsem, the network connection is not actually
>>> disconnected. Instead, the operation to close the socket is simply added
>>> to the task_works queue.
>>>
>>> svc_xprt_destroy_all
>>>   ...
>>>   svc_sock_free
>>>    sockfd_put
>>>     fput_many
>>>      init_task_work // ____fput
>>>      task_work_add // add to task->task_works
>>>
>>> The actual disconnection of the network connection will only occur after
>>> the current process finishes.
>>> do_exit
>>>   exit_task_work
>>>    task_work_run
>>>    ...
>>>     ____fput // close sock
>>>
>>> Although it is not a common practice to deploy NFS client and server on
>>> the same machine, I think this issue still needs to be addressed,
>>> otherwise it will cause all processes trying to acquire the shrinker_rwsem
>>> to hang.
>>>
>>> I don't have any ideas yet on how to solve this problem, does anyone have
>>> any suggestions?
>>>
>>> Thanks.
>>>
> --
> Chuck Lever
>
>

