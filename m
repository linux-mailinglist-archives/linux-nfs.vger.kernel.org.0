Return-Path: <linux-nfs+bounces-5681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7D895DAB0
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 04:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C61E283E72
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 02:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB5CE56E;
	Sat, 24 Aug 2024 02:38:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015428DD1
	for <linux-nfs@vger.kernel.org>; Sat, 24 Aug 2024 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724467114; cv=none; b=nyWwXvcUQlL8Kh1Qrps0dH+ei9+RYapQTF0+WOwOihJJv2BuUcOFcb9W5KyJEdSFS7InfpcXGJyOOrDDhmiOMSHnKAMmvNRpB4JvnRNSP2+GCCNFM4RvpkksIXiMeIYT+a9DVafJ0nErdPbLvYyW1WRXAhFMowZTTk/y58FI+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724467114; c=relaxed/simple;
	bh=//HahG/SiIYk6BAdH6bVvcdj0cQNl4EphZTGH6pB6b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rFAFFxnu5HEUpOPRxK9rWHDddJx+soSFkx8A26T4iTX13/gTjdyN/OQbjbxMabLdohM+gA4qWCebWQg/cTIVfA5ZrCBCd0/lDlz7CdaUdS0s8KOjiP+d/mvsE5TdfFPj13itIX+rOgONnA5sTJXtfMcRyMg473N4iKU43zyuZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WrLfg2cWjzhY8x;
	Sat, 24 Aug 2024 10:36:27 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FD2B1800F2;
	Sat, 24 Aug 2024 10:38:29 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 24 Aug 2024 10:38:28 +0800
Message-ID: <82a00c5b-6cc7-35be-df92-58e11281fac4@huawei.com>
Date: Sat, 24 Aug 2024 10:38:27 +0800
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
 <ZsjqKNvsW35hLWEQ@tissot.1015granger.net>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <ZsjqKNvsW35hLWEQ@tissot.1015granger.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2024/8/24 3:59, Chuck Lever 写道:
> On Fri, Aug 23, 2024 at 03:15:04PM -0400, Chuck Lever wrote:
>> On Fri, Aug 23, 2024 at 11:35:28AM +0800, Li Lingfeng wrote:
>>
>> 	[ snipped ]
>>
>>> [   91.319328] Kernel panic - not syncing: Fatal exception
>>> [   91.320712] Kernel Offset: disabled
>>> [   91.321189] ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>
>>> Both of them were introduced by commit 9f28a971ee9f ("nfsd: separate
>>> nfsd_last_thread() from nfsd_put()") since this patch changes the behavior
>>> of the error path.
>>>
>>> I confirmed this by fixing both issues with the following changes:
>>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>>> index ee5713fca187..05d4b463c16b 100644
>>> --- a/fs/nfsd/nfssvc.c
>>> +++ b/fs/nfsd/nfssvc.c
>>> @@ -811,6 +811,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cred
>>> *cred)
>>>          if (error < 0 && !nfsd_up_before)
>>>                  nfsd_shutdown_net(net);
>>>   out_put:
>>> +       if (error < 0)
>>> +               nfsd_last_thread(net);
>>>          /* Threads now hold service active */
>>>          if (xchg(&nn->keep_active, 0))
>>>                  svc_put(serv);
>>>
>>> They have been fixed by commit bf32075256e9 ("NFSD: simplify error paths in
>>> nfsd_svc()") in mainline.
>>>
>>> Maybe it would be a good idea to push it to the LTS branches.
>> To be clear, by "push it to LTS" I assume you mean apply bf32075?
>>
>> I have now applied commit bf32075256e9 ("NFSD: simplify error paths
>> in nfsd_svc()") to nfsd-6.6.y, nfsd-5.15.y, and nfsd-5.10.y in my
>> kernel.org git repo, for testing.
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>
>> I will run these three against the usual NFSD CI today, but feel
>> free to try them out yourself and report your results.
>>
>> Now unfortunately 6.1.y is still "special." It appears that commit
>> 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
>> was reverted in that kernel, and the fix you mention here does not
>> cleanly apply to v6.1.106. Based on some previous comments on this
>> list, I think I need to fix up v6.1 LTS to be like the other three
>> kernels, and then apply bf32075.
> OK, I've got a candidate for v6.1.y now, too. See the nfsd-6.1.y
> branch in the above git repo.

I'm getting a compile error when trying to compile nfsd-6.1.y.

The return value of fh_fill_pre_attrs is void, but nfsd_setattr attempts
to assign its return value to a __be32 variable.

I found out that the return type of fh_fill_pre_attrs was changed in
a332018a91c4 ("nfsd: handle failure to collect pre/post-op attrs more
sanely") which hasn't been added to nfsd-6.1.y yet.

Is nfsd-6.1.y not ready yet?

fs/nfsd/vfs.c: In function ‘nfsd_setattr’:
fs/nfsd/vfs.c:536:6: error: void value not ignored as it ought to be
   536 |  err = fh_fill_pre_attrs(fhp);
       |      ^
make[3]: *** [scripts/Makefile.build:250: fs/nfsd/vfs.o] Error 1
make[3]: *** Waiting for unfinished jobs....
   LD [M]  fs/ubifs/ubifs.o
make[2]: *** [scripts/Makefile.build:503: fs/nfsd] Error 2
make[1]: *** [scripts/Makefile.build:503: fs] Error 2
make: *** [Makefile:2009: .] Error 2
>

