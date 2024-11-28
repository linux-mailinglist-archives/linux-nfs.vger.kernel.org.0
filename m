Return-Path: <linux-nfs+bounces-8249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE2E9DB976
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 15:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DD6281A8C
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F291A00F8;
	Thu, 28 Nov 2024 14:17:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1BC19DF8D;
	Thu, 28 Nov 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803435; cv=none; b=me3aNaacs6RM8uJ6/ISHb8qE7ctQJVBR8clqmBNbb6PGN50iloIrk2e6GQoD/ZdYu14FzMaimxIDqEgbk7zIqrLa1+ekkFJea+zzQFY7hp5XcRdZHBEea8I9KPf4Sa9U4FNcRKyr+BSZKSaov92bx0SeCjJdTnNAyVBXWaJtEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803435; c=relaxed/simple;
	bh=eMCzgYyVVInLtzfrUJSlXsuVcSM0D0k4/8B7AWfG09I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UnQN3Sv6Np+9AWlURa+j33Ek+PGzvf7sx22ILSTc9Cgl+ds1rCj1UR3avNZ2EgFRDB+F5wwr+WTU33euUfsU8rlg1MriHBkym3YGtXwz2XV087QS4Rbw3f93Sosyf5M/MK66rXgLejFm5+UQk0ZjDDVoEvAKQTlFF5ka1gccwbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Xzdcz4qzRzRhmb;
	Thu, 28 Nov 2024 22:15:31 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id D375E1800A1;
	Thu, 28 Nov 2024 22:17:02 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Nov 2024 22:17:01 +0800
Message-ID: <728568ef-4563-4860-9490-e53aa4f6dd76@huawei.com>
Date: Thu, 28 Nov 2024 22:17:01 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfs: pass flags to second superblock
To: Anna Schumaker <anna@kernel.org>
CC: <trondmy@kernel.org>, <trond.myklebust@hammerspace.com>,
	<jlayton@kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai1@huaweicloud.com>,
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<lilingfeng@huaweicloud.com>
References: <20241114044738.1582373-1-lilingfeng3@huawei.com>
 <CAFX2Jfk=FUNYecYT15_FQSKv6ajcWuM-724hUeryTJc7auhCHg@mail.gmail.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <CAFX2Jfk=FUNYecYT15_FQSKv6ajcWuM-724hUeryTJc7auhCHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi Anna,

We found that this modification clears the flags (SB_BORN/SB_ACTIVE/
SB_POSIXACL) already set in the superblock, which would cause problems.
We will redesign a solution to address the original issue.
Sorry for the noise.

Thanks,
Li

在 2024/11/26 6:34, Anna Schumaker 写道:
> Hi Li,
>
> On Wed, Nov 13, 2024 at 11:33 PM Li Lingfeng <lilingfeng3@huawei.com> wrote:
>> During the process of mounting an NFSv4 client, two superblocks will be
>> created in sequence. The first superblock corresponds to the root
>> directory exported by the server, and the second superblock corresponds to
>> the directory that will be actually mounted. The first superblock will
>> eventually be destroyed.
>> The flag passed from user mode will only be passed to the first
>> superblock, resulting in the actual used superblock not carrying the flag
>> passed from user mode(fs_context_for_submount() will set sb_flags as 0).
>>
>> Since the superblock of NFS does not carry the ro tag, the file system
>> status displayed by /proc/self/mountstats shows that NFS is always in the
>> rw state, which may mislead users.
>>
>> Pass sb_flags of the fc which carry flags passed by user to second
>> superblock to fix it.
>>
>> Fixes: 281cad46b34d ("NFS: Create a submount rpc_op")
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfs/nfs4super.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
>> index b29a26923ce0..9a3b73a33fbf 100644
>> --- a/fs/nfs/nfs4super.c
>> +++ b/fs/nfs/nfs4super.c
>> @@ -233,6 +233,7 @@ static int do_nfs4_mount(struct nfs_server *server,
>>          if (IS_ERR(dentry))
>>                  return PTR_ERR(dentry);
>>
>> +       dentry->d_sb->s_flags = fc->sb_flags;
> I'm seeing a handful of new xfstests failures that I bisected to this
> patch: generic/157, generic/184, generic/306, generic/564, and
> generic/598.
>
> I'm seeing this on NFS v4.1 and v4.2, and it looks like each one of
> these failures is due to a new -EIO error being generated. Any
> thoughts about what could be causing this?
>
> Thanks,
> Anna
>
>
>>          fc->root = dentry;
>>          return 0;
>>   }
>> --
>> 2.31.1
>>
>

