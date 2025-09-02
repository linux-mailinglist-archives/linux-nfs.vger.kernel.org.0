Return-Path: <linux-nfs+bounces-13974-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444D8B40229
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 15:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854C1162FC2
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8D299AB5;
	Tue,  2 Sep 2025 13:08:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF5291C13;
	Tue,  2 Sep 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818535; cv=none; b=uwRQ4XFzAMaD489xF2/vXFhXwZ+opB4KyMjIiGOe0JDHaEiEjO+CJd947QQ4j4K3qQhydloWaNrOpv6Nihh9DDcC4wJwC/RpLuCl4zFm8B/bobZw+/nHvsq9TwqFLCRcYkaaez+5xydk3s7MWhRWDYRHIi+pBBE5ngqUwuMBPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818535; c=relaxed/simple;
	bh=JxV5/OdDcxZAxRnBP3X4CLPpKWTZrpzXcjSt/hD7nAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WzNec9DsfowsTMzDWY8uiGul0a8lMTKNLQINSdeCjcrRvV2vfiygSTwL1ekUmfz3IH6E1XTu1oXBDVDepbVsE0GsfrU7EdPMDtl18MHtp2YuP1tOFYdOdu+ETlxwxOPeY5JrmzGZwXtgAXwuOIg7km0aGN3Oqije8nCjYU1R0fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cGQtX6qZcz1T4Z6;
	Tue,  2 Sep 2025 21:04:20 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id CFE04180064;
	Tue,  2 Sep 2025 21:08:49 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Sep 2025 21:08:48 +0800
Message-ID: <a35d7d19-c2ee-4d32-ae12-6d8493dbac0b@huawei.com>
Date: Tue, 2 Sep 2025 21:08:48 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: remove long-standing revoked delegations by force
To: Benjamin Coddington <bcodding@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>, <chuck.lever@oracle.com>,
	<neil@brown.name>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai1@huaweicloud.com>,
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<lilingfeng@huaweicloud.com>, <zhangjian496@huawei.com>
References: <20250902022237.1488709-1-lilingfeng3@huawei.com>
 <a103653bc0dd231b897ffcd074c1f15151562502.camel@kernel.org>
 <1ece2978-239c-4939-bb16-0c7c64614c66@huawei.com>
 <BF48C6D1-ED2E-4B9C-A833-FF48D9ACC044@redhat.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <BF48C6D1-ED2E-4B9C-A833-FF48D9ACC044@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200013.china.huawei.com (7.202.194.25)

Hi, Ben

在 2025/9/2 20:43, Benjamin Coddington 写道:
> On 2 Sep 2025, at 8:10, Li Lingfeng wrote:
>
>> Our expected outcome was that the client would release the abnormal
>> delegation via TEST_STATEID/FREE_STATEID upon detecting its invalidity.
>> However, this problematic delegation is no longer present in the
>> client's server->delegations list—whether due to client-side timeouts or
>> the server-side bug [1].
> How does the client timeout TEST_STATEID - are you mounting with 'soft'?
I have never actually encountered a timeout; on 5.10, I triggered it by
forcibly injecting a timeout error.

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6509,6 +6509,10 @@ static void nfs4_delegreturn_prepare(struct 
rpc_task *task, void *data)
                         &d_data->args.seq_args,
                         &d_data->res.seq_res,
                         task);
+
+       printk("%s force inject err\n", __func__);
+       task->tk_rpc_status = -ETIMEDOUT;
+       rpc_exit(task, -ETIMEDOUT);
  }
> We should find the server-side bug and fix it rather than write code to
> paper over it.  I do think the synchronization of state here is a bit
> fragile and wish the protocol had a generation, sequence, or marker for
> setting SEQ4_STATUS_ bits..
I was able to reproduce a server-side bug by adding delays (without using
fault injection). The server-side bug is detailed in reference [1].
I would appreciate it if you could provide any suggestions for 
modifications.
>>> Should we instead just administratively evict the client since it's
>>> clearly not behaving right in this case?
>> Thanks for the suggestion. While administratively evicting the client would
>> certainly resolve the immediate delegation issue, I'm concerned that approach
>> might be a bit heavy-handed.
>> The problematic behavior seems isolated to a single delegation. Meanwhile,
>> the client itself likely has numerous other open files and active state on
>> the server. Forcing a complete client reconnect would tear down all that
>> state, which could cause significant application disruption and be perceived
>> as a service outage from the client's perspective.
>>
>> [1] https://lore.kernel.org/all/de669327-c93a-49e5-a53b-bda9e67d34a2@huawei.com/
> ^^ in this thread you reference v5.10 - there was a knfsd fix for a
> cl_revoked leak "3b816601e279", and there have been 3 or 4 fixes to fix
> problems and optimize the client walk of delegations since then.  Jeff
> pointed out that there have been fixes in these areas.  Are you finding this
> problem still with all those fixes included?
As shown in [1], the problem can be reproduced at master(commit 
b320789d6883),
I think all those fixes are included.

Thanks,
Lingfeng

>
> Ben
>
>

