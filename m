Return-Path: <linux-nfs+bounces-18612-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Mo0GM8KfGkEKQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18612-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 02:35:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CA5B62E9
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 02:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF73E3004068
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 01:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317FC331219;
	Fri, 30 Jan 2026 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="otUc/knw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3B2E093C
	for <linux-nfs@vger.kernel.org>; Fri, 30 Jan 2026 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736906; cv=none; b=BXQrvIOW5RgTOg+NuMLJe0RkcGxJJl34b74Yn1LCnDVOuBkcCAP++NgTCl0g3TX+fqtMUewq0+QDoBqOGAoRgg61cbuNgTcsb6zK19eYlkZqA/SntGy26qjlZ/02sIvCQljoDbJ4vzIcBlQZHYd1+W46zeehquKC5xmla+y9hgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736906; c=relaxed/simple;
	bh=fLG3MyyHJKFnJjMljskdIb4ePX5x7fo0LlvOmAEyjn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XjsBd4QUTyliGm9qj5S9BUjSagNPEjEU3H7IGaS27X6+Zt0JKZ4Bw0IBYmEv2XTXjB2+QuGN3AbM2yauzJHqUZ/Tee+v8KsiTqWwDcKuJCp0zEmwnRDhVwKjdpFSl21emYvA7Ym3R0jnmeQ+J/NOyp2ZzTqFNF2zW18QE+ciOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=otUc/knw; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sNf0cQjyck4WCQU4OXC/lyV5tCo7Qg8H1/ffOEaoWYE=;
	b=otUc/knwn9yBTOXMfQq560v7eVSTEyV1aU59lW9hmRU/1ANVNdWGEnytJFITw0OO/GdS6dN+L
	Nt1bmwzEVf7m2ndkYkBAx8VdfbmRGkSoQLQfJtTuI9jK/HeqDnR93ZA7xJab9gq0qDTbRUIhDQz
	G8cedBufKiCkPHuLTE+DSI0=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4f2JPv713dz1cyT9;
	Fri, 30 Jan 2026 09:31:31 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 75C4F40565;
	Fri, 30 Jan 2026 09:35:00 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Jan 2026 09:34:59 +0800
Message-ID: <584f2b79-0648-4390-9007-16b7adfa7a0a@huawei.com>
Date: Fri, 30 Jan 2026 09:34:59 +0800
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
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <5d5f6605c0ba8751723b588a4d8e1def37e23c78.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200013.china.huawei.com (7.202.194.25)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18612-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 82CA5B62E9
X-Rspamd-Action: no action

Hi Trond,

在 2026/1/30 0:00, Trond Myklebust 写道:
> On Thu, 2026-01-29 at 15:06 +0800, Li Lingfeng wrote:
>> Hi Trond,
>>
>> 在 2025/11/29 12:06, Trond Myklebust 写道:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> The recent changes to suppress the 'ro' and 'rw' mount options when
>>> mounting the same NFS filesystem with different settings are
>>> causing
>>> confusion with users, and are an unnecessary restriction. They
>>> represent
>>> a functionality regression.
>>>
>>> The following patch set reverts the regressions, before applying a
>>> different set of fixes to address the original problem, which was
>>> one of
>>> the NFSv4 mount automounter code failing to propagate the correct
>>> mount
>>> options.
>>>
>>> Trond Myklebust (6):
>>>     Revert "nfs: ignore SB_RDONLY when remounting nfs"
>>>     Revert "nfs: clear SB_RDONLY before getting superblock"
>>>     Revert "nfs: ignore SB_RDONLY when mounting nfs"
>>>     NFS: Automounted filesystem should inherit ro,noexec,nodev,sync
>>> flags
>>>     NFS: Fix inheritance of the block sizes when automounting
>>>     NFS: Fix up the automount fs_context to use the correct cred
>>>
>>>    fs/nfs/client.c           | 21 +++++++++++++++++----
>>>    fs/nfs/internal.h         |  3 +--
>>>    fs/nfs/namespace.c        | 16 +++++++++++++++-
>>>    fs/nfs/nfs4client.c       | 18 ++++++++++++++----
>>>    fs/nfs/super.c            | 33 +++------------------------------
>>>    include/linux/nfs_fs_sb.h |  5 +++++
>>>    6 files changed, 55 insertions(+), 41 deletions(-)
>> After this series of patches was merged, I found that the issue
>> described
>> in link [1] has appeared again.
>>
>> [root@nfs-client1 ~]# mount /dev/sda /mnt2
>> [root@nfs-client1 ~]# echo "/mnt2 *(rw,no_root_squash,fsid=0)"
>>> /etc/exports
>> [root@nfs-client1 ~]# systemctl restart nfs-server
>> [root@nfs-client1 ~]# mount -t nfs -o ro,vers=4 127.0.0.1:/ /mnt/sdaa
>> [root@nfs-client1 ~]# mount -t nfs -o rw,vers=4 127.0.0.1:/ /mnt/sdaa
>> [root@nfs-client1 ~]# mount -t nfs -o ro,vers=4 127.0.0.1:/ /mnt/sdaa
>> [root@nfs-client1 ~]# mount -t nfs -o rw,vers=4 127.0.0.1:/ /mnt/sdaa
>> [root@nfs-client1 ~]# mount | grep nfs4
>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>> (ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fat
>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=12
>> 7.0.0.1,local_lock=none,addr=127.0.0.1)
>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>> (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fat
>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=12
>> 7.0.0.1,local_lock=none,addr=127.0.0.1)
>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>> (ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fat
>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=12
>> 7.0.0.1,local_lock=none,addr=127.0.0.1)
>> 127.0.0.1:/ on /mnt/sdaa type nfs4
>> (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fat
>> al_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=12
>> 7.0.0.1,local_lock=none,addr=127.0.0.1)
>> [root@nfs-client1 ~]# uname -a
>> Linux nfs-client1 6.19.0-rc7+ #178 SMP PREEMPT_DYNAMIC Thu Jan 29
>> 14:06:54 CST 2026 x86_64 x86_64 x86_64 GNU/Linux
>> [root@nfs-client1 ~]#
>>
>> [1]
>> https://lore.kernel.org/all/20241114045303.1656426-1-lilingfeng3@huawei.com/
>>
>> Thanks,
>> Lingfeng.
> What does the output of "cat /proc/fs/nfsfs/volumes" show? Does it show
> more than 2 devices associated with that fsid?
>   

Here is the result of the test:

[root@nfs-client1 ~]# mount /dev/sda /mnt2
[root@nfs-client1 ~]# echo "/mnt2 *(rw,no_root_squash,fsid=0)" >/etc/exports
[root@nfs-client1 ~]# systemctl restart nfs-server
[root@nfs-client1 ~]# mount -t nfs -o ro,vers=4 127.0.0.1:/ /mnt/sdaa
[root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
NV SERVER   PORT DEV          FSID FSC
v4 7f000001  801 0:51         0:0                               no
[root@nfs-client1 ~]# mount -t nfs -o rw,vers=4 127.0.0.1:/ /mnt/sdaa
[root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
NV SERVER   PORT DEV          FSID FSC
v4 7f000001  801 0:51         0:0                               no
v4 7f000001  801 0:52         0:0                               no
[root@nfs-client1 ~]# mount | grep nfs4
127.0.0.1:/ on /mnt/sdaa type nfs4 
(ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1)
127.0.0.1:/ on /mnt/sdaa type nfs4 
(rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1)
[root@nfs-client1 ~]# mount -t nfs -o ro,vers=4 127.0.0.1:/ /mnt/sdaa
[root@nfs-client1 ~]# mount -t nfs -o rw,vers=4 127.0.0.1:/ /mnt/sdaa
[root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
NV SERVER   PORT DEV          FSID FSC
v4 7f000001  801 0:51         0:0                               no
v4 7f000001  801 0:52         0:0                               no
[root@nfs-client1 ~]# mount | grep nfs4
127.0.0.1:/ on /mnt/sdaa type nfs4 
(ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1)
127.0.0.1:/ on /mnt/sdaa type nfs4 
(rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1)
127.0.0.1:/ on /mnt/sdaa type nfs4 
(ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1)
127.0.0.1:/ on /mnt/sdaa type nfs4 
(rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1)
[root@nfs-client1 ~]#

There are only 2 devices associated with that fsid.

Thanks,
Lingfeng.


