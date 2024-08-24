Return-Path: <linux-nfs+bounces-5675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BF95DA4C
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 03:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586301C20F67
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 01:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81147A35;
	Sat, 24 Aug 2024 01:03:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21986FC3
	for <linux-nfs@vger.kernel.org>; Sat, 24 Aug 2024 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724461410; cv=none; b=YsS/Ma0hJRzyELl27BKo2mGe3zJROGP9cbuqbbAYqPzW4AZKrnY0KFTTzKqBiF+9fITOkweIacwUeZRAAKqtcMLRLEug2Iz3wrxgZRB8ftAim4YquknDf949UlFEw+FfIFsoVQRYIxdNWpgNq2BqAQKicEtvzH7L1mxTh2c4YL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724461410; c=relaxed/simple;
	bh=Z99l6AIHKsV+GJZJMS9BY5L4EgULiBC4WVWR9mMfGWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEvON94fp+8Efbet8Au/b7ABhAGHU8ft5L9QC0KuuXfXVfxqy6iRLUdKUzxwcyXbgeXCmQb06bpCS7DRjklCykWILVPDZ3N2IYHV4eVyDjDj09g7cSZfggn1N7az8MlsXvnsW3qqU3Il26k8DcQK6pCYKlGunRypMyepjz1a5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WrJb16sZTz4f3jR7
	for <linux-nfs@vger.kernel.org>; Sat, 24 Aug 2024 09:03:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4AD4D1A0359
	for <linux-nfs@vger.kernel.org>; Sat, 24 Aug 2024 09:03:24 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIJYMclmQHsrCg--.17227S3;
	Sat, 24 Aug 2024 09:03:22 +0800 (CST)
Message-ID: <0a9d43d6-83f3-055c-5e87-9405685c15a3@huaweicloud.com>
Date: Sat, 24 Aug 2024 09:03:20 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH v1] SUNRPC: Remove BUG_ON call sites
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Donald Buczek <buczek@molgen.mpg.de>, NeilBrown <neilb@suse.de>,
 Chuck Lever <cel@kernel.org>, brauner@kernel.org, linux-nfs@vger.kernel.org,
 it+linux@molgen.mpg.de, Hou Tao <houtao1@huawei.com>,
 "zhangyi (F)" <yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>,
 chengzhihao1@huawei.com, "yukuai (C)" <yukuai3@huawei.com>,
 lilingfeng3@huawei.com
References: <169513768769.145733.5037542987990908432.stgit@manet.1015granger.net>
 <169516146143.19404.11284116898963519832@noble.neil.brown.name>
 <793386f6-65bc-48ef-9d7c-71314ddd4c86@molgen.mpg.de>
 <65ee9c0d-e89e-b3e5-f542-103a0ee4745c@huaweicloud.com>
 <ZsjfuIKIWoapNKH+@tissot.1015granger.net>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <ZsjfuIKIWoapNKH+@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzIJYMclmQHsrCg--.17227S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyDKF47GryxWF4rGrW7Jwb_yoW8tFW7pr
	s5AFZ5KrZ8Jr1rXr4Uu3W5Za45Jw4DGas8Wr15GF1Sya15Wr1qqr40gwn0gF1DCr48JF17
	tF1UXrnruw1kZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


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
Yes. And I've applied this patch to my own 5.10 repo and tested it.
>
> I have now applied commit bf32075256e9 ("NFSD: simplify error paths
> in nfsd_svc()") to nfsd-6.6.y, nfsd-5.15.y, and nfsd-5.10.y in my
> kernel.org git repo, for testing.
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>
> I will run these three against the usual NFSD CI today, but feel
> free to try them out yourself and report your results.
>
> Now unfortunately 6.1.y is still "special." It appears that commit
> 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> was reverted in that kernel, and the fix you mention here does not
> cleanly apply to v6.1.106. Based on some previous comments on this
> list, I think I need to fix up v6.1 LTS to be like the other three
> kernels, and then apply bf32075.
>


