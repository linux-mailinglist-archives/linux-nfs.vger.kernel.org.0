Return-Path: <linux-nfs+bounces-8211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219C59D842E
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2024 12:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7432849AE
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Nov 2024 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA899195985;
	Mon, 25 Nov 2024 11:17:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E941957F4;
	Mon, 25 Nov 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533442; cv=none; b=iLzJgcUXSTuG4nDdt68p3ainIz48sMV5x0WudVWA+7pW0WwkxLqMWULqkxqPDjzNGbepVtAtjfTzraZhhDHUya3RfWJGEDBlib1GWGHguN/qrnq5dGYs6o4o0uRse2haq44zYwJ2suVU0UY/TDpaXo25ns127oXJciuqkj6qSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533442; c=relaxed/simple;
	bh=t9f0IJVRvpgoAynSVDmk0FH/l1uYvOSxS687jMDVYdc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=TiBsCw6C9xIqfg/Qm0GuviOSGg2PrRYOlEVa7caBu3ev9JDmbh2/rMYtgU8gVaIbwm2clpUDdxU6oMzaklzrr6NwApxnGXlt5WhyNtMEe6Zi/p09oMHD6wwicoUVpTs1LInOt5Q5ro4oXv1m+YZJmbqvEXFMWfsWowjUMClxq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Xxjmz4lqSzRhnR;
	Mon, 25 Nov 2024 19:15:47 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 73FCB180105;
	Mon, 25 Nov 2024 19:17:15 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 19:17:14 +0800
Message-ID: <887cd8f6-3e49-410c-8b36-9e617c34ca6f@huawei.com>
Date: Mon, 25 Nov 2024 19:17:13 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
From: Li Lingfeng <lilingfeng3@huawei.com>
Subject: [bug report] deploying both NFS client and server on the same machine
 triggle hungtask
To: <Dai.Ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, NeilBrown <neilb@suse.de>, <okorniev@redhat.com>,
	<tom@talpey.com>, <trond.myklebust@hammerspace.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yu Kuai
	<yukuai1@huaweicloud.com>, Hou Tao <houtao1@huawei.com>, "zhangyi (F)"
	<yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>,
	<chengzhihao1@huawei.com>, Li Lingfeng <lilingfeng3@huawei.com>, Li Lingfeng
	<lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi, we have found a hungtask issue recently.

Commit 7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low
memory condition") adds a shrinker to NFSD, which causes NFSD to try to
obtain shrinker_rwsem when starting and stopping services.

Deploying both NFS client and server on the same machine may lead to the
following issue, since they will share the global shrinker_rwsem.

     nfsd                            nfs
                             drop_cache // hold shrinker_rwsem
                             write back, wait for rpc_task to exit
// stop nfsd threads
svc_set_num_threads
// clean up xprts
svc_xprt_destroy_all
                             rpc_check_timeout
                              rpc_check_connected
                              // wait for the connection to be disconnected
unregister_shrinker
// wait for shrinker_rwsem

Normally, the client's rpc_task will exit after the server's nfsd thread
has processed the request.
When all the server's nfsd threads exit, the client’s rpc_task is expected
to detect the network connection being disconnected and exit.
However, although the server has executed svc_xprt_destroy_all before
waiting for shrinker_rwsem, the network connection is not actually
disconnected. Instead, the operation to close the socket is simply added
to the task_works queue.

svc_xprt_destroy_all
  ...
  svc_sock_free
   sockfd_put
    fput_many
     init_task_work // ____fput
     task_work_add // add to task->task_works

The actual disconnection of the network connection will only occur after
the current process finishes.
do_exit
  exit_task_work
   task_work_run
   ...
    ____fput // close sock

Although it is not a common practice to deploy NFS client and server on
the same machine, I think this issue still needs to be addressed,
otherwise it will cause all processes trying to acquire the shrinker_rwsem
to hang.

I don't have any ideas yet on how to solve this problem, does anyone have
any suggestions?

Thanks.


