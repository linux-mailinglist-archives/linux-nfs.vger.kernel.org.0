Return-Path: <linux-nfs+bounces-8243-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40189DB31F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 08:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A914D281AD8
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 07:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9FC146A73;
	Thu, 28 Nov 2024 07:22:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE07A13A;
	Thu, 28 Nov 2024 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778532; cv=none; b=pjz1FsBU2RSTIuGQjTnc3zvfHj6iVxjVhO1Km/N1D/L9aEuJGGse/6uQ/YaFlAfAvqmB5oMI9Im3hasUNS7vDwbSJk2Dn4dluK6aMIx32Y/XvODRW9YCC64DiPM1bYtJm4Yc9txNM4A6/veVDzE/H6uaBD++9z3QcQV74vgX12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778532; c=relaxed/simple;
	bh=g5jmakzobWLhu8HLJiQ+Veek3J25Pbm+IxAJbAsOna8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ir1GAzKZxFsULIhGizTEIsasI2vWuogI2X8ynbkKoLNAsl0CZ4KGubboZ7YeS0p5noGE5dqgdgBQ/vsZWPuUu6SotVvCbeKhPESAdCVjSxE/REgQ7k13ndktajeniqBMcJ5k9TGfhsQ8fq/UVSOeGBwajY6dVimz1Li0Q8SFhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XzSNj4NzGz11LtJ;
	Thu, 28 Nov 2024 15:19:17 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 65B1814037D;
	Thu, 28 Nov 2024 15:22:06 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Nov 2024 15:22:05 +0800
Message-ID: <8b155d3c-62b4-4f16-ab00-e3d030148d29@huawei.com>
Date: Thu, 28 Nov 2024 15:22:04 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [bug report] deploying both NFS client and server on the same
 machine triggle hungtask
To: <Dai.Ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, NeilBrown <neilb@suse.de>, <okorniev@redhat.com>,
	<tom@talpey.com>, <trond.myklebust@hammerspace.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yu Kuai
	<yukuai1@huaweicloud.com>, Hou Tao <houtao1@huawei.com>, "zhangyi (F)"
	<yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>,
	<chengzhihao1@huawei.com>, Li Lingfeng <lilingfeng@huaweicloud.com>
References: <887cd8f6-3e49-410c-8b36-9e617c34ca6f@huawei.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <887cd8f6-3e49-410c-8b36-9e617c34ca6f@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Besides nfsd_file_shrinker, the nfsd_client_shrinker added by commit
7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low memory
condition") in 2022 and the nfsd_reply_cache_shrinker added by commit
3ba75830ce17 ("nfsd4: drc containerization") in 2019 may also trigger such
an issue.
Was this scenario not considered when designing the shrinkers for NFSD, or
was it deemed unreasonable and not worth considering?

在 2024/11/25 19:17, Li Lingfeng 写道:
> Hi, we have found a hungtask issue recently.
>
> Commit 7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low
> memory condition") adds a shrinker to NFSD, which causes NFSD to try to
> obtain shrinker_rwsem when starting and stopping services.
>
> Deploying both NFS client and server on the same machine may lead to the
> following issue, since they will share the global shrinker_rwsem.
>
>     nfsd                            nfs
>                             drop_cache // hold shrinker_rwsem
>                             write back, wait for rpc_task to exit
> // stop nfsd threads
> svc_set_num_threads
> // clean up xprts
> svc_xprt_destroy_all
>                             rpc_check_timeout
>                              rpc_check_connected
>                              // wait for the connection to be 
> disconnected
> unregister_shrinker
> // wait for shrinker_rwsem
>
> Normally, the client's rpc_task will exit after the server's nfsd thread
> has processed the request.
> When all the server's nfsd threads exit, the client’s rpc_task is 
> expected
> to detect the network connection being disconnected and exit.
> However, although the server has executed svc_xprt_destroy_all before
> waiting for shrinker_rwsem, the network connection is not actually
> disconnected. Instead, the operation to close the socket is simply added
> to the task_works queue.
>
> svc_xprt_destroy_all
>  ...
>  svc_sock_free
>   sockfd_put
>    fput_many
>     init_task_work // ____fput
>     task_work_add // add to task->task_works
>
> The actual disconnection of the network connection will only occur after
> the current process finishes.
> do_exit
>  exit_task_work
>   task_work_run
>   ...
>    ____fput // close sock
>
> Although it is not a common practice to deploy NFS client and server on
> the same machine, I think this issue still needs to be addressed,
> otherwise it will cause all processes trying to acquire the 
> shrinker_rwsem
> to hang.
>
> I don't have any ideas yet on how to solve this problem, does anyone have
> any suggestions?
>
> Thanks.
>

