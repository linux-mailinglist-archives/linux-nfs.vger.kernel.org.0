Return-Path: <linux-nfs+bounces-18614-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHTgGGkafGlgKgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18614-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 03:41:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E543DB6857
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 03:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5E9300CE62
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 02:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE561E1024;
	Fri, 30 Jan 2026 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VlHYyzRm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81751862
	for <linux-nfs@vger.kernel.org>; Fri, 30 Jan 2026 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740901; cv=none; b=oCB4Knzlc0Pw1oMFsGgSxEF9Sayxv+z2FdGiPmEQbXpglZw7TBH/5rEjbvrPMv5JgRM6oMzJd/KggDt2e+cbGRMSbNmsukD80z/P8bGnXmD/PsSUY03xK0AaYtc8oJs6zQU6PAfit7Sg0lzKd918QXKvGB4+1OnM0kHqZIafylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740901; c=relaxed/simple;
	bh=0jR5VOc5ELXms7FbGE5tUA+aaLT56m0NVw0Gv0x2ctg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iAaY1QYUZICdZJ+LjeBz5Nrzb7QFUw88yGBvHpOvEANMXSq94ixapTAhWfw86D/+BJRigNKsd3Lvq2a6mligJlHMNSSgiwjWyZqC804jO36X1xtjyh/iU4JA4Xmxe7CSiH6R34ZIDLLpLxZ1nlg3pVnJVTJDEQ2EmDW/DW2xpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VlHYyzRm; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KGrzVzY9r8tsPpQwPFFlfCUzIFNiJpwbOU8vwhbP9i8=;
	b=VlHYyzRmrBMA5EGgDBfOQjNqAd4y2Ws9JjVI11pwVTr5r6tWJNkP5XPjQhqjC7GoZW2Dvu7E7
	RujsBn8u54arSknUBBCB3VHuoV7I3nI32ysoCetEUJ0WWv9h1g2q1aF7BJTH7KSG6tGJMjvrwv7
	Rgqm8+EibPS4pvdy903iVFE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f2KtG1xSNznTwp;
	Fri, 30 Jan 2026 10:37:42 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F37540363;
	Fri, 30 Jan 2026 10:41:35 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Jan 2026 10:41:34 +0800
Message-ID: <12072fd2-b5ca-40f1-b0cb-d9bc8873caa1@huawei.com>
Date: Fri, 30 Jan 2026 10:41:33 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH 0/6] Fix up NFS client mount option regressions
To: Trond Myklebust <trondmy@kernel.org>, Alkis Georgopoulos
	<alkisg@gmail.com>
CC: <linux-nfs@vger.kernel.org>, yangerkun <yangerkun@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, "zhangyi (F)"
	<yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
	<wangzhaolong1@huawei.com>
References: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com>
 <cover.1764388528.git.trond.myklebust@hammerspace.com>
 <cb5cd472-8989-451d-9da7-7d250027c27e@huawei.com>
 <5d5f6605c0ba8751723b588a4d8e1def37e23c78.camel@kernel.org>
 <584f2b79-0648-4390-9007-16b7adfa7a0a@huawei.com>
 <f8bf92fb35e7bfd4c0b87c108ac7e8d2813899a4.camel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <f8bf92fb35e7bfd4c0b87c108ac7e8d2813899a4.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200013.china.huawei.com (7.202.194.25)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18614-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lilingfeng3@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nfs-client1:email]
X-Rspamd-Queue-Id: E543DB6857
X-Rspamd-Action: no action

Hi Trond,

在 2026/1/30 9:43, Trond Myklebust 写道:
> On Fri, 2026-01-30 at 09:34 +0800, Li Lingfeng wrote:
>> Hi Trond,
>>
>> 在 2026/1/30 0:00, Trond Myklebust 写道:
>>> On Thu, 2026-01-29 at 15:06 +0800, Li Lingfeng wrote:
>>>> Hi Trond,
>>>>
>>>> 在 2025/11/29 12:06, Trond Myklebust 写道:
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>
>>>>> The recent changes to suppress the 'ro' and 'rw' mount options
>>>>> when
>>>>> mounting the same NFS filesystem with different settings are
>>>>> causing
>>>>> confusion with users, and are an unnecessary restriction. They
>>>>> represent
>>>>> a functionality regression.
>>>>>
>>>>> The following patch set reverts the regressions, before
>>>>> applying a
>>>>> different set of fixes to address the original problem, which
>>>>> was
>>>>> one of
>>>>> the NFSv4 mount automounter code failing to propagate the
>>>>> correct
>>>>> mount
>>>>> options.
>>>>>
>>>>> Trond Myklebust (6):
>>>>>      Revert "nfs: ignore SB_RDONLY when remounting nfs"
>>>>>      Revert "nfs: clear SB_RDONLY before getting superblock"
>>>>>      Revert "nfs: ignore SB_RDONLY when mounting nfs"
>>>>>      NFS: Automounted filesystem should inherit
>>>>> ro,noexec,nodev,sync
>>>>> flags
>>>>>      NFS: Fix inheritance of the block sizes when automounting
>>>>>      NFS: Fix up the automount fs_context to use the correct
>>>>> cred
>>>>>
>>>>>     fs/nfs/client.c           | 21 +++++++++++++++++----
>>>>>     fs/nfs/internal.h         |  3 +--
>>>>>     fs/nfs/namespace.c        | 16 +++++++++++++++-
>>>>>     fs/nfs/nfs4client.c       | 18 ++++++++++++++----
>>>>>     fs/nfs/super.c            | 33 +++--------------------------
>>>>> ----
>>>>>     include/linux/nfs_fs_sb.h |  5 +++++
>>>>>     6 files changed, 55 insertions(+), 41 deletions(-)
>>>> After this series of patches was merged, I found that the issue
>>>> described
>>>> in link [1] has appeared again.
>>>>
>>>> [root@nfs-client1 ~]# mount /dev/sda /mnt2
>>>> [root@nfs-client1 ~]# echo "/mnt2 *(rw,no_root_squash,fsid=0)"
>>>>> /etc/exports
>>>> [root@nfs-client1 ~]# systemctl restart nfs-server
>>>> [root@nfs-client1 ~]# mount -t nfs -o ro,vers=4 127.0.0.1:/
>>>> /mnt/sdaa
>>>> [root@nfs-client1 ~]# mount -t nfs -o rw,vers=4 127.0.0.1:/
>>>> /mnt/sdaa
>>>> [root@nfs-client1 ~]# mount -t nfs -o ro,vers=4 127.0.0.1:/
>>>> /mnt/sdaa
>>>> [root@nfs-client1 ~]# mount -t nfs -o rw,vers=4 127.0.0.1:/
>>>> /mnt/sdaa
>>>> [root@nfs-client1 ~]# mount | grep nfs4
>>>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>>>> (ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard
>>>> ,fat
>>>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientadd
>>>> r=12
>>>> 7.0.0.1,local_lock=none,addr=127.0.0.1)
>>>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>>>> (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard
>>>> ,fat
>>>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientadd
>>>> r=12
>>>> 7.0.0.1,local_lock=none,addr=127.0.0.1)
>>>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>>>> (ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard
>>>> ,fat
>>>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientadd
>>>> r=12
>>>> 7.0.0.1,local_lock=none,addr=127.0.0.1)
>>>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>>>> (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard
>>>> ,fat
>>>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientadd
>>>> r=12
>>>> 7.0.0.1,local_lock=none,addr=127.0.0.1)
>>>> [root@nfs-client1 ~]# uname -a
>>>> Linux nfs-client1 6.19.0-rc7+ #178 SMP PREEMPT_DYNAMIC Thu Jan 29
>>>> 14:06:54 CST 2026 x86_64 x86_64 x86_64 GNU/Linux
>>>> [root@nfs-client1 ~]#
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/20241114045303.1656426-1-lilingfeng3@huawei.com/
>>>>
>>>> Thanks,
>>>> Lingfeng.
>>> What does the output of "cat /proc/fs/nfsfs/volumes" show? Does it
>>> show
>>> more than 2 devices associated with that fsid?
>>>    
>> Here is the result of the test:
>>
>> [root@nfs-client1 ~]# mount /dev/sda /mnt2
>> [root@nfs-client1 ~]# echo "/mnt2 *(rw,no_root_squash,fsid=0)"
>>> /etc/exports
>> [root@nfs-client1 ~]# systemctl restart nfs-server
>> [root@nfs-client1 ~]# mount -t nfs -o ro,vers=4 127.0.0.1:/ /mnt/sdaa
>> [root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
>> NV SERVER   PORT DEV          FSID FSC
>> v4 7f000001  801 0:51         0:0                               no
>> [root@nfs-client1 ~]# mount -t nfs -o rw,vers=4 127.0.0.1:/ /mnt/sdaa
>> [root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
>> NV SERVER   PORT DEV          FSID FSC
>> v4 7f000001  801 0:51         0:0                               no
>> v4 7f000001  801 0:52         0:0                               no
>> [root@nfs-client1 ~]# mount | grep nfs4
>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>> (ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fat
>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=12
>> 7.0.0.1)
>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>> (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fat
>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=12
>> 7.0.0.1)
>> [root@nfs-client1 ~]# mount -t nfs -o ro,vers=4 127.0.0.1:/ /mnt/sdaa
>> [root@nfs-client1 ~]# mount -t nfs -o rw,vers=4 127.0.0.1:/ /mnt/sdaa
>> [root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
>> NV SERVER   PORT DEV          FSID FSC
>> v4 7f000001  801 0:51         0:0                               no
>> v4 7f000001  801 0:52         0:0                               no
>> [root@nfs-client1 ~]# mount | grep nfs4
>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>> (ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fat
>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=12
>> 7.0.0.1)
>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>> (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fat
>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=12
>> 7.0.0.1)
>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>> (ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fat
>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=12
>> 7.0.0.1)
>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>> (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fat
>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=12
>> 7.0.0.1)
>> [root@nfs-client1 ~]#
>>
>> There are only 2 devices associated with that fsid.
>>
> Then it is working as expected. It's not the kernel's job to stop
> people from stacking one mount on top of another. If it were, then the
> right place to do that would be in the VFS and not the NFS client.
>
> However the NFS client does try to ensure that mounts of the same
> remote filesystem with the same set of mount options gets mapped to the
> same super block (and hence device). The exception is if you're playing
> with the nosharecache option; in that case you're knowingly asking the
> kernel to ignore that constraint.
For local file systems like ext4, when I attempt to mount a file system
as read-only after it has already been mounted for read and write, I
encounter an EBUSY error (from the `get_tree` callback `ext4_get_tree`).

[root@nfs-client1 ~]# mount -o rw /dev/sdb /mnt3
[root@nfs-client1 ~]# mount -o ro /dev/sdb /mnt3
[ 2524.071442][ T1281] sdb: Can't mount, would change RO state
mount: /mnt3: /dev/sdb already mounted on /mnt3.
[root@nfs-client1 ~]# df -Th | grep sdb
/dev/sdb       ext4       20G   28K   19G   1% /mnt3
[root@nfs-client1 ~]#

Do you think NFS should have a similar restriction, allowing only one
mount per mount point?

Thanks,
Lingfeng.


