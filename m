Return-Path: <linux-nfs+bounces-18613-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHlmL9gMfGkEKQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18613-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 02:43:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C9B63B0
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 02:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08D3E300D32F
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jan 2026 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6628A32FA2D;
	Fri, 30 Jan 2026 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue6D6KLG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7A32B998
	for <linux-nfs@vger.kernel.org>; Fri, 30 Jan 2026 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737417; cv=none; b=WkXLndADmrGJdG068yMZU3rtU3HUWQi1YFktqjpR8GOR/CnXrUzMmRDbpeDaSWG17jvUId/X49RaFfMi+sLqAix04VuLt6wPmW3GuRu7IWgK+HqZuYrULO4GFHKADZ4ZiE5XvpzjUNn05vJue2gwh2wIHJYrwwDBSTtYHg5eRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737417; c=relaxed/simple;
	bh=OdSrZEbMdjXcTzz6Kkd36ESzHwHW6bysvHaUC0N+kP8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ejKfnH0gOdCdS7xfGRDC06wnC5vZsktGlbuKfl7qhCKNe/1/+o4sEj/a+I41ls4f9pm8a7DrJHm1drua1mxkG/iOS2jl9P6fq3s2shOjKNcZJRkCvny0iianAm/vHcIXnpPhtqO1y3lClJL2WFdK3wKtd46XAuQwTaMJvpQyN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue6D6KLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B539C4CEF7;
	Fri, 30 Jan 2026 01:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769737416;
	bh=OdSrZEbMdjXcTzz6Kkd36ESzHwHW6bysvHaUC0N+kP8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ue6D6KLG0ZrZdxsHjpqJV9gjqoBBmjNjOxTqKZZCiDZmKiars2lEPDzkpi1EKZBT1
	 5UaH02rbXAD6a++GfbiWpQUAmURnLhWo6VV/DbBEoLQOf1IJVghQAcp4IooqMiUTAt
	 bkDYpS7fNuYTpRcoz4N99vkyuIQRWvW68QfQjzsW2fFbTZZpvmpEvJOaP6SsIMT5n3
	 ITWH5tW165RTEo/KTu8kbxH9/Y69i97uBlgpXHXdQLhp+Z9Dhs92c0TQ0HZYE/7us2
	 mVZqDfVLMYCSGn//i8G9XElcXPmFMEGxI2076KfH+S4/pIa1IsZogMZF6jylRQ1iGF
	 5EGvRtlhSBLfg==
Message-ID: <f8bf92fb35e7bfd4c0b87c108ac7e8d2813899a4.camel@kernel.org>
Subject: Re: [PATCH 0/6] Fix up NFS client mount option regressions
From: Trond Myklebust <trondmy@kernel.org>
To: Li Lingfeng <lilingfeng3@huawei.com>, Alkis Georgopoulos
 <alkisg@gmail.com>
Cc: linux-nfs@vger.kernel.org, yangerkun <yangerkun@huawei.com>, 
 "chengzhihao1@huawei.com"
	 <chengzhihao1@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	 <houtao1@huawei.com>, wangzhaolong1@huawei.com
Date: Thu, 29 Jan 2026 20:43:35 -0500
In-Reply-To: <584f2b79-0648-4390-9007-16b7adfa7a0a@huawei.com>
References: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com>
	 <cover.1764388528.git.trond.myklebust@hammerspace.com>
	 <cb5cd472-8989-451d-9da7-7d250027c27e@huawei.com>
	 <5d5f6605c0ba8751723b588a4d8e1def37e23c78.camel@kernel.org>
	 <584f2b79-0648-4390-9007-16b7adfa7a0a@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-18613-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nfs-client1:email,hammerspace.com:email]
X-Rspamd-Queue-Id: 044C9B63B0
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 09:34 +0800, Li Lingfeng wrote:
> Hi Trond,
>=20
> =E5=9C=A8 2026/1/30 0:00, Trond Myklebust =E5=86=99=E9=81=93:
> > On Thu, 2026-01-29 at 15:06 +0800, Li Lingfeng wrote:
> > > Hi Trond,
> > >=20
> > > =E5=9C=A8 2025/11/29 12:06, Trond Myklebust =E5=86=99=E9=81=93:
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > >=20
> > > > The recent changes to suppress the 'ro' and 'rw' mount options
> > > > when
> > > > mounting the same NFS filesystem with different settings are
> > > > causing
> > > > confusion with users, and are an unnecessary restriction. They
> > > > represent
> > > > a functionality regression.
> > > >=20
> > > > The following patch set reverts the regressions, before
> > > > applying a
> > > > different set of fixes to address the original problem, which
> > > > was
> > > > one of
> > > > the NFSv4 mount automounter code failing to propagate the
> > > > correct
> > > > mount
> > > > options.
> > > >=20
> > > > Trond Myklebust (6):
> > > > =C2=A0=C2=A0=C2=A0 Revert "nfs: ignore SB_RDONLY when remounting nf=
s"
> > > > =C2=A0=C2=A0=C2=A0 Revert "nfs: clear SB_RDONLY before getting supe=
rblock"
> > > > =C2=A0=C2=A0=C2=A0 Revert "nfs: ignore SB_RDONLY when mounting nfs"
> > > > =C2=A0=C2=A0=C2=A0 NFS: Automounted filesystem should inherit
> > > > ro,noexec,nodev,sync
> > > > flags
> > > > =C2=A0=C2=A0=C2=A0 NFS: Fix inheritance of the block sizes when aut=
omounting
> > > > =C2=A0=C2=A0=C2=A0 NFS: Fix up the automount fs_context to use the =
correct
> > > > cred
> > > >=20
> > > > =C2=A0=C2=A0 fs/nfs/client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++++++++++----
> > > > =C2=A0=C2=A0 fs/nfs/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 3 +--
> > > > =C2=A0=C2=A0 fs/nfs/namespace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 16 +++++++++++++++-
> > > > =C2=A0=C2=A0 fs/nfs/nfs4client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 18 ++++++++++++++----
> > > > =C2=A0=C2=A0 fs/nfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 +++--------------------------
> > > > ----
> > > > =C2=A0=C2=A0 include/linux/nfs_fs_sb.h |=C2=A0 5 +++++
> > > > =C2=A0=C2=A0 6 files changed, 55 insertions(+), 41 deletions(-)
> > > After this series of patches was merged, I found that the issue
> > > described
> > > in link [1] has appeared again.
> > >=20
> > > [root@nfs-client1 ~]# mount /dev/sda /mnt2
> > > [root@nfs-client1 ~]# echo "/mnt2 *(rw,no_root_squash,fsid=3D0)"
> > > > /etc/exports
> > > [root@nfs-client1 ~]# systemctl restart nfs-server
> > > [root@nfs-client1 ~]# mount -t nfs -o ro,vers=3D4 127.0.0.1:/
> > > /mnt/sdaa
> > > [root@nfs-client1 ~]# mount -t nfs -o rw,vers=3D4 127.0.0.1:/
> > > /mnt/sdaa
> > > [root@nfs-client1 ~]# mount -t nfs -o ro,vers=3D4 127.0.0.1:/
> > > /mnt/sdaa
> > > [root@nfs-client1 ~]# mount -t nfs -o rw,vers=3D4 127.0.0.1:/
> > > /mnt/sdaa
> > > [root@nfs-client1 ~]# mount | grep nfs4
> > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > (ro,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
hard
> > > ,fat
> > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entadd
> > > r=3D12
> > > 7.0.0.1,local_lock=3Dnone,addr=3D127.0.0.1)
> > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
hard
> > > ,fat
> > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entadd
> > > r=3D12
> > > 7.0.0.1,local_lock=3Dnone,addr=3D127.0.0.1)
> > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > (ro,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
hard
> > > ,fat
> > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entadd
> > > r=3D12
> > > 7.0.0.1,local_lock=3Dnone,addr=3D127.0.0.1)
> > > 127.0.0.1:/ on /mnt/sdaa type nfs4
> > > (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,=
hard
> > > ,fat
> > > al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,cli=
entadd
> > > r=3D12
> > > 7.0.0.1,local_lock=3Dnone,addr=3D127.0.0.1)
> > > [root@nfs-client1 ~]# uname -a
> > > Linux nfs-client1 6.19.0-rc7+ #178 SMP PREEMPT_DYNAMIC Thu Jan 29
> > > 14:06:54 CST 2026 x86_64 x86_64 x86_64 GNU/Linux
> > > [root@nfs-client1 ~]#
> > >=20
> > > [1]
> > > https://lore.kernel.org/all/20241114045303.1656426-1-lilingfeng3@huaw=
ei.com/
> > >=20
> > > Thanks,
> > > Lingfeng.
> > What does the output of "cat /proc/fs/nfsfs/volumes" show? Does it
> > show
> > more than 2 devices associated with that fsid?
> > =C2=A0=20
>=20
> Here is the result of the test:
>=20
> [root@nfs-client1 ~]# mount /dev/sda /mnt2
> [root@nfs-client1 ~]# echo "/mnt2 *(rw,no_root_squash,fsid=3D0)"
> >/etc/exports
> [root@nfs-client1 ~]# systemctl restart nfs-server
> [root@nfs-client1 ~]# mount -t nfs -o ro,vers=3D4 127.0.0.1:/ /mnt/sdaa
> [root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
> NV SERVER=C2=A0 =C2=A0PORT DEV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSID FSC
> v4 7f000001=C2=A0 801 0:51=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0no
> [root@nfs-client1 ~]# mount -t nfs -o rw,vers=3D4 127.0.0.1:/ /mnt/sdaa
> [root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
> NV SERVER=C2=A0 =C2=A0PORT DEV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSID FSC
> v4 7f000001=C2=A0 801 0:51=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0no
> v4 7f000001=C2=A0 801 0:52=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0no
> [root@nfs-client1 ~]# mount | grep nfs4
> 127.0.0.1:/ on /mnt/sdaa type nfs4=20
> (ro,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard=
,fat
> al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clienta=
ddr=3D12
> 7.0.0.1)
> 127.0.0.1:/ on /mnt/sdaa type nfs4=20
> (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard=
,fat
> al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clienta=
ddr=3D12
> 7.0.0.1)
> [root@nfs-client1 ~]# mount -t nfs -o ro,vers=3D4 127.0.0.1:/ /mnt/sdaa
> [root@nfs-client1 ~]# mount -t nfs -o rw,vers=3D4 127.0.0.1:/ /mnt/sdaa
> [root@nfs-client1 ~]# cat /proc/fs/nfsfs/volumes
> NV SERVER=C2=A0 =C2=A0PORT DEV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSID FSC
> v4 7f000001=C2=A0 801 0:51=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0no
> v4 7f000001=C2=A0 801 0:52=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0no
> [root@nfs-client1 ~]# mount | grep nfs4
> 127.0.0.1:/ on /mnt/sdaa type nfs4=20
> (ro,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard=
,fat
> al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clienta=
ddr=3D12
> 7.0.0.1)
> 127.0.0.1:/ on /mnt/sdaa type nfs4=20
> (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard=
,fat
> al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clienta=
ddr=3D12
> 7.0.0.1)
> 127.0.0.1:/ on /mnt/sdaa type nfs4=20
> (ro,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard=
,fat
> al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clienta=
ddr=3D12
> 7.0.0.1)
> 127.0.0.1:/ on /mnt/sdaa type nfs4=20
> (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard=
,fat
> al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clienta=
ddr=3D12
> 7.0.0.1)
> [root@nfs-client1 ~]#
>=20
> There are only 2 devices associated with that fsid.
>=20

Then it is working as expected. It's not the kernel's job to stop
people from stacking one mount on top of another. If it were, then the
right place to do that would be in the VFS and not the NFS client.

However the NFS client does try to ensure that mounts of the same
remote filesystem with the same set of mount options gets mapped to the
same super block (and hence device). The exception is if you're playing
with the nosharecache option; in that case you're knowingly asking the
kernel to ignore that constraint.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

