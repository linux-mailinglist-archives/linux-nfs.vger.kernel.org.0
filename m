Return-Path: <linux-nfs+bounces-5680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A9C95DAAA
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 04:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC7A1F22878
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CDC15E8B;
	Sat, 24 Aug 2024 02:29:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1737383A2
	for <linux-nfs@vger.kernel.org>; Sat, 24 Aug 2024 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466592; cv=none; b=SwEa8xALwgqqnPhwsr/iU2vc7kLWpq+lXl7z8emnC7WfChx3D/+f3buL56RFZLRR2+GwRNx0ypFTW06yoPR25/N19QVfmKnYp9Gn3NI/AEB4W33yEvGxlXJxbGIM0GuEfVHUKX6m/IhZC6UcN3Kn4tPM4dLtxtzvgEC4X2S6RcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466592; c=relaxed/simple;
	bh=SY5JUJF41HGEN6H7DAyNz6tXaVwdmTVc9hqGDhx8iaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t9DK8zbyOmjbSAJVVdiLbgawIDqA2Yy3/GuEfVVQnrVGIIUt2xE0+mmWDhML6R1NLXGbnYa4AUpNL7fH0M3jay3JJKH4YtttjvAVHxXbRU8Rt68BCRrGPJn3UCUYMhtDX3WXwMKMBtx7WuLnzoS/t6g/0xcTOsiaxREvRA1+DuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WrLV739n3zpVZ3;
	Sat, 24 Aug 2024 10:29:03 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C70D1800A5;
	Sat, 24 Aug 2024 10:29:46 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 24 Aug 2024 10:29:44 +0800
Message-ID: <1ee0b1ae-9328-93b5-f847-7b3c85249c99@huawei.com>
Date: Sat, 24 Aug 2024 10:29:44 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH v1] SUNRPC: Remove BUG_ON call sites
To: Chuck Lever <chuck.lever@oracle.com>, Li Lingfeng
	<lilingfeng@huaweicloud.com>
CC: Donald Buczek <buczek@molgen.mpg.de>, NeilBrown <neilb@suse.de>, Chuck
 Lever <cel@kernel.org>, <brauner@kernel.org>, <linux-nfs@vger.kernel.org>,
	<it+linux@molgen.mpg.de>, Hou Tao <houtao1@huawei.com>, "zhangyi (F)"
	<yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>,
	<chengzhihao1@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <169513768769.145733.5037542987990908432.stgit@manet.1015granger.net>
 <169516146143.19404.11284116898963519832@noble.neil.brown.name>
 <793386f6-65bc-48ef-9d7c-71314ddd4c86@molgen.mpg.de>
 <65ee9c0d-e89e-b3e5-f542-103a0ee4745c@huaweicloud.com>
 <ZsjfuIKIWoapNKH+@tissot.1015granger.net>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <ZsjfuIKIWoapNKH+@tissot.1015granger.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2024/8/24 3:15, Chuck Lever 写道:
> On Fri, Aug 23, 2024 at 11:35:28AM +0800, Li Lingfeng wrote:
>
> 	[ snipped ]
>
>> [   91.319328] Kernel panic - not syncing: Fatal exception
>> [   91.320712] Kernel Offset: disabled
>> [   91.321189] ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> Both of them were introduced by commit 9f28a971ee9f ("nfsd: separate
>> nfsd_last_thread() from nfsd_put()") since this patch changes the behavior
>> of the error path.
>>
>> I confirmed this by fixing both issues with the following changes:
>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> index ee5713fca187..05d4b463c16b 100644
>> --- a/fs/nfsd/nfssvc.c
>> +++ b/fs/nfsd/nfssvc.c
>> @@ -811,6 +811,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cred
>> *cred)
>>          if (error < 0 && !nfsd_up_before)
>>                  nfsd_shutdown_net(net);
>>   out_put:
>> +       if (error < 0)
>> +               nfsd_last_thread(net);
>>          /* Threads now hold service active */
>>          if (xchg(&nn->keep_active, 0))
>>                  svc_put(serv);
>>
>> They have been fixed by commit bf32075256e9 ("NFSD: simplify error paths in
>> nfsd_svc()") in mainline.
>>
>> Maybe it would be a good idea to push it to the LTS branches.
> To be clear, by "push it to LTS" I assume you mean apply bf32075?
>
> I have now applied commit bf32075256e9 ("NFSD: simplify error paths
> in nfsd_svc()") to nfsd-6.6.y, nfsd-5.15.y, and nfsd-5.10.y in my
> kernel.org git repo, for testing.
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>
> I will run these three against the usual NFSD CI today, but feel
> free to try them out yourself and report your results.
I have tested the two use cases I mentioned above on nfsd-5.10.y,
nfsd-5.15.y, and nfsd-6.6.y, and all three versions no longer have issues.
> Now unfortunately 6.1.y is still "special." It appears that commit
> 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> was reverted in that kernel, and the fix you mention here does not
> cleanly apply to v6.1.106. Based on some previous comments on this
> list, I think I need to fix up v6.1 LTS to be like the other three
> kernels, and then apply bf32075.
>

