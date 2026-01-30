Return-Path: <linux-nfs+bounces-18615-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFJWCJkifGnJKgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18615-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 04:16:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB7B6C48
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 04:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2654A304F359
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 03:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C62FDC5C;
	Fri, 30 Jan 2026 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+3/yiNY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6331314D26
	for <linux-nfs@vger.kernel.org>; Fri, 30 Jan 2026 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742861; cv=none; b=Qr7ZQS40N+ZNB19DqSp2rW1Sc+FcpTq2DrO+wFMAAOSr/qXHdR13l3/a1ru4rhRfXDNvbWaoRQDyzK5BekKHHvyrl1hh8DaCSLURIisPPcXtlGFYMTtfC98wNH4UR6f1EXs0XuK6SMQ5NUr2OlL9Cm49LRBZi6V/H9PN+pKgubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742861; c=relaxed/simple;
	bh=+Kfilr2UVqLfGAePhoiaNaNRbAXGfYZ8uLXksgKmvEk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJZR3F2mUeWabvbjeouny8Xk55Kc04K4hoTpIjdqPqigkb4gvICNse2iaBE4XLY+8RMsVRJIAkfQHBBpfzqXZQOx5kievXHrJWoyMewX6qAbVmVDKrQ2hNe6y98ujPZShUseaL6Z0hS8kDzRRx5Uj5IjLEMoXTk4Y1ye9sZEu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+3/yiNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B032DC4CEF7;
	Fri, 30 Jan 2026 03:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769742861;
	bh=+Kfilr2UVqLfGAePhoiaNaNRbAXGfYZ8uLXksgKmvEk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M+3/yiNYgWMjnTiVoqMdq0tq0JGiNFxss8h4JX8FRTF9DQKRHPGWnu6zBZ5ws3N0Q
	 kSoTGtXBziliWdzbTFyf3896Jtt4P7ijWMfjjncDI9REGgTC0pcKgtcSJaiALmdtjL
	 RsR5A4IfYRFNr1JGvTvEkfhRTP88772iITLVFQzRxqTRTmkVwuix9hr2B63ttq28JY
	 c/QEFSPMzMe2XOFPTPhLhJfyW5u0XmvjvZVsUozTSNdV9xG601uNGNESVco+DZVrDv
	 l0wW9oBj+Le+/575qoHcx/pJT9YTRM20lLOwNmRzyp4x6uHYLu8CNTbIE+iTkRj+Ws
	 yQosbTCIrManQ==
Message-ID: <2c116c2c46972ed095d1d4856af9eb1128736eb7.camel@kernel.org>
Subject: Re: [PATCH 0/6] Fix up NFS client mount option regressions
From: Trond Myklebust <trondmy@kernel.org>
To: Li Lingfeng <lilingfeng3@huawei.com>, Alkis Georgopoulos
 <alkisg@gmail.com>
Cc: linux-nfs@vger.kernel.org, yangerkun <yangerkun@huawei.com>, 
 "chengzhihao1@huawei.com"
	 <chengzhihao1@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	 <houtao1@huawei.com>, wangzhaolong1@huawei.com
Date: Thu, 29 Jan 2026 22:14:19 -0500
In-Reply-To: <12072fd2-b5ca-40f1-b0cb-d9bc8873caa1@huawei.com>
References: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com>
	 <cover.1764388528.git.trond.myklebust@hammerspace.com>
	 <cb5cd472-8989-451d-9da7-7d250027c27e@huawei.com>
	 <5d5f6605c0ba8751723b588a4d8e1def37e23c78.camel@kernel.org>
	 <584f2b79-0648-4390-9007-16b7adfa7a0a@huawei.com>
	 <f8bf92fb35e7bfd4c0b87c108ac7e8d2813899a4.camel@kernel.org>
	 <12072fd2-b5ca-40f1-b0cb-d9bc8873caa1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18615-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nfs-client1:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 73EB7B6C48
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 10:41 +0800, Li Lingfeng wrote:
> Hi Trond,
>=20
> =E5=9C=A8 2026/1/30 9:43, Trond Myklebust =E5=86=99=E9=81=93:
> > On Fri, 2026-01-30 at 09:34 +0800, Li Lingfeng wrote:
> > > Hi Trond,
> > >=20
> > > =E5=9C=A8 2026/1/30 0:00, Trond Myklebust =E5=86=99=E9=81=93:
> > > > On Thu, 2026-01-29 at 15:06 +0800, Li Lingfeng wrote:
> > > > > Hi Trond,
> > > > >=20
> > > > > =E5=9C=A8 2025/11/29 12:06, Trond Myklebust =E5=86=99=E9=81=93:
> > > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > >=20
> > > > > > The recent changes to suppress the 'ro' and 'rw' mount
> > > > > > options
> > > > > > when
> > > > > > mounting the same NFS filesystem with different settings
> > > > > > are
> > > > > > causing
> > > > > > confusion with users, and are an unnecessary restriction.
> > > > > > They
> > > > > > represent
> > > > > > a functionality regression.
> > > > > >=20
> > > > > > The following patch set reverts the regressions, before
> > > > > > applying a
> > > > > > different set of fixes to address the original problem,
> > > > > > which
> > > > > > was
> > > > > > one of
> > > > > > the NFSv4 mount automounter code failing to propagate the
> > > > > > correct
> > > > > > mount
> > > > > > options.
> > > > > >=20
> > > > > > Trond Myklebust (6):
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Revert "nfs: ignore SB_RDONLY when rem=
ounting nfs"
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Revert "nfs: clear SB_RDONLY before ge=
tting
> > > > > > superblock"
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Revert "nfs: ignore SB_RDONLY when mou=
nting nfs"
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 NFS: Automounted filesystem should inh=
erit
> > > > > > ro,noexec,nodev,sync
> > > > > > flags
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 NFS: Fix inheritance of the block size=
s when
> > > > > > automounting
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 NFS: Fix up the automount fs_context t=
o use the
> > > > > > correct
> > > > > > cred
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 fs/nfs/client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++++++++++----
> > > > > > =C2=A0=C2=A0=C2=A0 fs/nfs/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > > > > > =C2=A0=C2=A0=C2=A0 fs/nfs/namespace.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 16 +++++++++++++++-
> > > > > > =C2=A0=C2=A0=C2=A0 fs/nfs/nfs4client.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 18 ++++++++++++++----
> > > > > > =C2=A0=C2=A0=C2=A0 fs/nfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 +++---------------------
> > > > > > -----
> > > > > > ----
> > > > > > =C2=A0=C2=A0=C2=A0 include/linux/nfs_fs_sb.h |=C2=A0 5 +++++
> > > > > > =C2=A0=C2=A0=C2=A0 6 files changed, 55 insertions(+), 41 deleti=
ons(-)
> > > > > After this series of patches was merged, I found that the
> > > > > issue
> > > > > described
> > > > > in link [1] has appeared again.
> > > > >=20
> > > > > [root@nfs-client1 ~]# mount /dev/sda /mnt2
> > > > > [root@nfs-client1 ~]# echo "/mnt2
> > > > > *(rw,no_root_squash,fsid=3D0)"
> > > > > > /etc/exports
> > > > > [root@nfs-client1 ~]# systemctl restart nfs-server
> > > > > [root@nfs-client1 ~]# mount -t nfs -o ro,vers=3D4 127.0.0.1:/
> > > > > /mnt/sdaa
> > > > > [root@nfs-client1 ~]# mount -t nfs -o rw,vers=3D4 127.0.0.1:/
> > > > > /mnt/sdaa
> > > > > [root@nfs-client1 ~]# mount -t nfs -o ro,vers=3D4 127.0.0.1:/
> > > > > /mnt/sdaa
> > > > > [root@nfs-client1 ~]# mount -t nfs -o rw,vers=3D4 127.0.0.1:/
> > > > > /mnt/sdaa
> > > > > [root@nfs-client1 ~]# mount | grep nfs4
> > > > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > > > (ro,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D=
255,
> > > > > hard
> > > > > ,fat
> > > > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys=
,clien
> > > > > tadd
> > > > > r=3D12
> > > > > 7.0.0.1,local_lock=3Dnone,addr=3D127.0.0.1)
> > > > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > > > (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D=
255,
> > > > > hard
> > > > > ,fat
> > > > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys=
,clien
> > > > > tadd
> > > > > r=3D12
> > > > > 7.0.0.1,local_lock=3Dnone,addr=3D127.0.0.1)
> > > > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > > > (ro,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D=
255,
> > > > > hard
> > > > > ,fat
> > > > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys=
,clien
> > > > > tadd
> > > > > r=3D12
> > > > > 7.0.0.1,local_lock=3Dnone,addr=3D127.0.0.1)
> > > > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > > > (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D=
255,
> > > > > hard
> > > > > ,fat
> > > > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys=
,clien
> > > > > tadd
> > > > > r=3D12
> > > > > 7.0.0.1,local_lock=3Dnone,addr=3D127.0.0.1)
> > > > > [root@nfs-client1 ~]# uname -a
> > > > > Linux nfs-client1 6.19.0-rc7+ #178 SMP PREEMPT_DYNAMIC Thu
> > > > > Jan 29
> > > > > 14:06:54 CST 2026 x86_64 x86_64 x86_64 GNU/Linux
> > > > > [root@nfs-client1 ~]#
> > > > >=20
> > > > > [1]
> > > > > https://lore.kernel.org/all/20241114045303.1656426-1-lilingfeng3@=
huawei.com/
> > > > >=20
> > > > > Thanks,
> > > > > Lingfeng.
> > > > What does the output of "cat /proc/fs/nfsfs/volumes" show? Does
> > > > it
> > > > show
> > > > more than 2 devices associated with that fsid?
> > > > =C2=A0=C2=A0=20
> > > Here is the result of the test:
> > >=20
> > > [root@nfs-client1 ~]# mount /dev/sda /mnt2
> > > [root@nfs-client1 ~]# echo "/mnt2 *(rw,no_root_squash,fsid=3D0)"
> > > > /etc/exports
> > > [root@nfs-client1 ~]# systemctl restart nfs-server
> > > [root@nfs-client1 ~]# mount -t nfs -o ro,vers=3D4 127.0.0.1:/
> > > /mnt/sdaa
> > > [root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
> > > NV SERVER=C2=A0 =C2=A0PORT DEV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSID=
 FSC
> > > v4 7f000001=C2=A0 801 0:51=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
> > > =C2=A0no
> > > [root@nfs-client1 ~]# mount -t nfs -o rw,vers=3D4 127.0.0.1:/
> > > /mnt/sdaa
> > > [root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
> > > NV SERVER=C2=A0 =C2=A0PORT DEV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSID=
 FSC
> > > v4 7f000001=C2=A0 801 0:51=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
> > > =C2=A0no
> > > v4 7f000001=C2=A0 801 0:52=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
> > > =C2=A0no
> > > [root@nfs-client1 ~]# mount | grep nfs4
> > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > (ro,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
hard
> > > ,fat
> > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entadd
> > > r=3D12
> > > 7.0.0.1)
> > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
hard
> > > ,fat
> > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entadd
> > > r=3D12
> > > 7.0.0.1)
> > > [root@nfs-client1 ~]# mount -t nfs -o ro,vers=3D4 127.0.0.1:/
> > > /mnt/sdaa
> > > [root@nfs-client1 ~]# mount -t nfs -o rw,vers=3D4 127.0.0.1:/
> > > /mnt/sdaa
> > > [root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
> > > NV SERVER=C2=A0 =C2=A0PORT DEV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSID=
 FSC
> > > v4 7f000001=C2=A0 801 0:51=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
> > > =C2=A0no
> > > v4 7f000001=C2=A0 801 0:52=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
> > > =C2=A0no
> > > [root@nfs-client1 ~]# mount | grep nfs4
> > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > (ro,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
hard
> > > ,fat
> > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entadd
> > > r=3D12
> > > 7.0.0.1)
> > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
hard
> > > ,fat
> > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entadd
> > > r=3D12
> > > 7.0.0.1)
> > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > (ro,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
hard
> > > ,fat
> > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entadd
> > > r=3D12
> > > 7.0.0.1)
> > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
hard
> > > ,fat
> > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entadd
> > > r=3D12
> > > 7.0.0.1)
> > > [root@nfs-client1 ~]#
> > >=20
> > > There are only 2 devices associated with that fsid.
> > >=20
> > Then it is working as expected. It's not the kernel's job to stop
> > people from stacking one mount on top of another. If it were, then
> > the
> > right place to do that would be in the VFS and not the NFS client.
> >=20
> > However the NFS client does try to ensure that mounts of the same
> > remote filesystem with the same set of mount options gets mapped to
> > the
> > same super block (and hence device). The exception is if you're
> > playing
> > with the nosharecache option; in that case you're knowingly asking
> > the
> > kernel to ignore that constraint.
> For local file systems like ext4, when I attempt to mount a file
> system
> as read-only after it has already been mounted for read and write, I
> encounter an EBUSY error (from the `get_tree` callback
> `ext4_get_tree`).
>=20
> [root@nfs-client1 ~]# mount -o rw /dev/sdb /mnt3
> [root@nfs-client1 ~]# mount -o ro /dev/sdb /mnt3
> [ 2524.071442][ T1281] sdb: Can't mount, would change RO state
> mount: /mnt3: /dev/sdb already mounted on /mnt3.
> [root@nfs-client1 ~]# df -Th | grep sdb
> /dev/sdb=C2=A0 =C2=A0 =C2=A0 =C2=A0ext4=C2=A0 =C2=A0 =C2=A0 =C2=A020G=C2=
=A0 =C2=A028K=C2=A0 =C2=A019G=C2=A0 =C2=A01% /mnt3
> [root@nfs-client1 ~]#
>=20
> Do you think NFS should have a similar restriction, allowing only one
> mount per mount point?

Why would we do that?

The above is a reflection of the fact that for ext4, the block device
can only be associated with one filesystem. After you've mounted that
block device in one place, you can't mount it read-only anywhere else.

The only way to create both a read-only and a read-write mount with
ext4 is to use a bind mount to create the read-only mount point.

NFS has no need for that restriction, so what would be the point of
duplicating it? In particular why would we want to break backward
compatibility for people who may already be relying on the current
behaviour?

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

