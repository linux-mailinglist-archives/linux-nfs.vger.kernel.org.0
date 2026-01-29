Return-Path: <linux-nfs+bounces-18590-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA7iBRoIe2kJAwIAu9opvQ
	(envelope-from <linux-nfs+bounces-18590-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:11:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B560AC760
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E35CF305AF08
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B465379998;
	Thu, 29 Jan 2026 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gnDR5WQG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F837A49F
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670413; cv=none; b=NBIszAFcgNobd2Q0LydrnQSdvWLLEjNrOV1FA6qcGPOqj74Zv5FAu7nVM0j1NLM960oJ5O0BH4ypjqeLzyL3uPgBSOjecZXvzplKuy9EcxQxk4oCgNQ/WORBato6DjNKrDT5r7qWgnJUzhYRE8yxxHqHRgVrsso97oo0O154GEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670413; c=relaxed/simple;
	bh=Aq6yNVPUZ2ySAfjwsJz0qYvL1TAfqyx7JBKHvD/oY68=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tl9NuipvQCUNlPDazVI3QVT+NmRReZjG03l4qOKenQDkdiyBqjUOr06ap4fbflcyU2gUQpoREgui4MiMZoHSrzfd0RyQUxAhhBHLwK1qFHRxVDBEQkZxo8XNl7CyWXtu0VtIQ3BEVuhDydqiJM7dvnJtWBfw8/k7kIh6JkgMnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gnDR5WQG; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QPK2HRrQHIl0h9whx8a1sY0O1BgsMGMdj+gva95r28I=;
	b=gnDR5WQGckkYLm/dCkVsOPiyG+UJnBRj51cBf5JDcu66ywBvmZ7BJsiz1udJoikfSidevwct5
	Iy207fBclVynFOGZMB7ivuTzgf1bMX7qVf6nO+nJXH5MTmU6DDTz+92KJCDt4q9jOExf36rI0yF
	clrov1KbzRJadGwbPY4Pano=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4f1qpg6Kypz12LDG;
	Thu, 29 Jan 2026 15:02:51 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 9939B40538;
	Thu, 29 Jan 2026 15:06:45 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 15:06:44 +0800
Message-ID: <cb5cd472-8989-451d-9da7-7d250027c27e@huawei.com>
Date: Thu, 29 Jan 2026 15:06:44 +0800
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
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <cover.1764388528.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
	TAGGED_FROM(0.00)[bounces-18590-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: 9B560AC760
X-Rspamd-Action: no action

Hi Trond,

在 2025/11/29 12:06, Trond Myklebust 写道:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> The recent changes to suppress the 'ro' and 'rw' mount options when
> mounting the same NFS filesystem with different settings are causing
> confusion with users, and are an unnecessary restriction. They represent
> a functionality regression.
>
> The following patch set reverts the regressions, before applying a
> different set of fixes to address the original problem, which was one of
> the NFSv4 mount automounter code failing to propagate the correct mount
> options.
>
> Trond Myklebust (6):
>    Revert "nfs: ignore SB_RDONLY when remounting nfs"
>    Revert "nfs: clear SB_RDONLY before getting superblock"
>    Revert "nfs: ignore SB_RDONLY when mounting nfs"
>    NFS: Automounted filesystem should inherit ro,noexec,nodev,sync flags
>    NFS: Fix inheritance of the block sizes when automounting
>    NFS: Fix up the automount fs_context to use the correct cred
>
>   fs/nfs/client.c           | 21 +++++++++++++++++----
>   fs/nfs/internal.h         |  3 +--
>   fs/nfs/namespace.c        | 16 +++++++++++++++-
>   fs/nfs/nfs4client.c       | 18 ++++++++++++++----
>   fs/nfs/super.c            | 33 +++------------------------------
>   include/linux/nfs_fs_sb.h |  5 +++++
>   6 files changed, 55 insertions(+), 41 deletions(-)
After this series of patches was merged, I found that the issue described
in link [1] has appeared again.

[root@nfs-client1 ~]# mount /dev/sda /mnt2
[root@nfs-client1 ~]# echo "/mnt2 *(rw,no_root_squash,fsid=0)" >/etc/exports
[root@nfs-client1 ~]# systemctl restart nfs-server
[root@nfs-client1 ~]# mount -t nfs -o ro,vers=4 127.0.0.1:/ /mnt/sdaa
[root@nfs-client1 ~]# mount -t nfs -o rw,vers=4 127.0.0.1:/ /mnt/sdaa
[root@nfs-client1 ~]# mount -t nfs -o ro,vers=4 127.0.0.1:/ /mnt/sdaa
[root@nfs-client1 ~]# mount -t nfs -o rw,vers=4 127.0.0.1:/ /mnt/sdaa
[root@nfs-client1 ~]# mount | grep nfs4
127.0.0.1:/ on /mnt/sdaa type nfs4 
(ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)
127.0.0.1:/ on /mnt/sdaa type nfs4 
(rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)
127.0.0.1:/ on /mnt/sdaa type nfs4 
(ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)
127.0.0.1:/ on /mnt/sdaa type nfs4 
(rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)
[root@nfs-client1 ~]# uname -a
Linux nfs-client1 6.19.0-rc7+ #178 SMP PREEMPT_DYNAMIC Thu Jan 29 
14:06:54 CST 2026 x86_64 x86_64 x86_64 GNU/Linux
[root@nfs-client1 ~]#

[1] 
https://lore.kernel.org/all/20241114045303.1656426-1-lilingfeng3@huawei.com/

Thanks,
Lingfeng.


