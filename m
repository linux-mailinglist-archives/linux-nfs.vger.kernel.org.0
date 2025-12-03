Return-Path: <linux-nfs+bounces-16881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE66CA1750
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 20:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDC6F30022ED
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 19:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E586E3358C9;
	Wed,  3 Dec 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGCWX8TC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB569313535;
	Wed,  3 Dec 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779036; cv=none; b=UgMNyUXDOnjVIJ11oy2jvIpmrDBzPn1tabOJMdnSusO8zNH1+nrqEw6ZM2wXKmaqZYJCOhm8inL3BmPRckfpMYU25J8fiKLacZP3cD21SvYH/iZIY+8sbVHfRjonYVnRP9NRM6tuU8Osjyed98NFE8qchesbQtCFmeReaCs+S2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779036; c=relaxed/simple;
	bh=tddEi8aeuTu8My14Vkj5+5KWIdyl31N8SDG9rmhDOHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kWkiDPBoWSzM7FqmLZHXhQbGUit5NE7UxTRly/eU/80xfjv8VxqEFyyMlmsnrQBBq2oua9vs6d/9+qbWjg/Tt5Rr/01xpRT8OS/EtJrBTA+F+b/OJftrwl0JICdmO5XKi3+LqlC/ZelL5MANyL30mIF3PyFz1vIRQZ4kWESA4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGCWX8TC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD881C116B1;
	Wed,  3 Dec 2025 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764779036;
	bh=tddEi8aeuTu8My14Vkj5+5KWIdyl31N8SDG9rmhDOHs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LGCWX8TCiCoVEdc34Sq0wvjGTe9XFp553fK1wo+VUOfCy3bt7Jg6h2ZT7u4wSQjRA
	 g8MHyBxSVQf4GsR7oLQbDUtU1brfP+PXSh8mN20jEM6ANvRz/wQxBnPuwxDdJJmy6v
	 Qic8He5fRSkkQEBaQ6J/AGUIk9my/0dX8yNP5itfKH8YPzSMSsqfBDV0/N9MkVA/ZF
	 xUb5AN0rd2vxyZMzmv2kZ94S33/2SVhFvkuRkzbQpPs+XAM29pYHZPRDSfUhizSgWk
	 j3+4tWKoKgZaT+x05zU4Q7IaSMgzU7WDx5/I9CfVIBk5KUR/Aj2Co4GbAwQjy5WFbE
	 2IAl7L21gTjQw==
Message-ID: <ba1a5563fd66738156a372eed016986952f11fd5.camel@kernel.org>
Subject: Re: [PATCH 2/5] NFS: Request a directory delegation on ACCESS,
 CREATE, and UNLINK
From: Trond Myklebust <trondmy@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>, Anna Schumaker <anna@kernel.org>, 
	linux-nfs@vger.kernel.org
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Date: Wed, 03 Dec 2025 11:23:54 -0500
In-Reply-To: <bfe61da1-3b52-49a4-844d-6f39d7ca4e9d@nvidia.com>
References: <20251104150645.719865-1-anna@kernel.org>
	 <20251104150645.719865-3-anna@kernel.org>
	 <4f5da6d9-ee72-4045-8fe1-c5eacedb4660@nvidia.com>
	 <bfe61da1-3b52-49a4-844d-6f39d7ca4e9d@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jon,

On Wed, 2025-12-03 at 15:56 +0000, Jon Hunter wrote:
>=20
> On 02/12/2025 16:01, Jon Hunter wrote:
> > Hi Anna,
> >=20
> > On 04/11/2025 15:06, Anna Schumaker wrote:
> > > From: Anna Schumaker <anna.schumaker@oracle.com>
> > >=20
> > > This patch adds a new flag: NFS_INO_REQ_DIR_DELEG to signal that
> > > a
> > > directory wants to request a directory delegation the next time
> > > it does
> > > a GETATTR. I have the client request a directory delegation when
> > > doing
> > > an access, create, or unlink call since these calls indicate that
> > > a user
> > > is working with a directory.
> > >=20
> > > Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> >=20
> >=20
> > We use NFS for boot testing our boards and once this commit landed
> > in -=20
> > next a lot of them, but no all, started failing to boot. Bisect is=20
> > pointing to this change.
> >=20
> > We have a custom init script that runs to mount the rootfs and I
> > see=20
> > that it displays ...
> >=20
> > [=C2=A0=C2=A0 10.238091] Run /init as init process
> > [=C2=A0=C2=A0 10.266026] ERROR: mounting debugfs fail...
> > [=C2=A0=C2=A0 10.286535] Root device found: nfs
> > [=C2=A0=C2=A0 10.300342] Ethernet interface: eth0
> > [=C2=A0=C2=A0 10.313920] IP Address: 192.168.99.2
> > [=C2=A0=C2=A0 10.382738] Rootfs mounted over nfs
> > [=C2=A0=C2=A0 10.416010] Switching from initrd to actual rootfs
>=20
> It appears that there are multiple boot issues on -next at the moment
> and the above it not the relevant part for this particular issue.
> Looking further at the logs I am seeing the following errors which
> are related to this change ...
>=20
> [=C2=A0=C2=A0 11.100334] systemd[1]: Failed to open directory
> /etc/systemd/system, ignoring: Unknown error 524
> [=C2=A0=C2=A0 11.119234] systemd[1]: Failed to open directory
> /lib/systemd/system, ignoring: Unknown error 524
> [=C2=A0=C2=A0 11.143487] systemd[1]: Failed to load default target: No su=
ch
> file or directory
> [=C2=A0=C2=A0 11.158620] systemd[1]: Trying to load rescue target...
> [=C2=A0=C2=A0 11.169388] systemd[1]: Failed to load rescue target: No suc=
h file
> or directory
> [=C2=A0=C2=A0 11.188856] systemd[1]: Freezing execution.
>=20
> Thanks
> Jon

Does the following patch fix it for you?

8<---------------------------------------------
From 849bdbd3a2136a86c809ce6a7fa6ae30e9f0728a Mon Sep 17 00:00:00 2001
Message-ID: <849bdbd3a2136a86c809ce6a7fa6ae30e9f0728a.1764778907.git.trond.=
myklebust@hammerspace.com>
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Wed, 3 Dec 2025 11:17:25 -0500
Subject: [PATCH] NFSv4: Handle NFS4ERR_NOTSUPP errors for directory
 delegations

The error NFS4ERR_NOTSUPP will be returned for operations that are
legal, but not supported by the server.

Fixes: 156b09482933 ("NFS: Request a directory delegation on ACCESS, CREATE=
, and UNLINK")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c53ddb185aa3..ec1ce593dea2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4533,12 +4533,17 @@ static int _nfs4_proc_getattr(struct nfs_server *se=
rver, struct nfs_fh *fhandle,
 	status =3D nfs4_do_call_sync(server->client, server, &msg,
 				   &args.seq_args, &res.seq_res, task_flags);
 	if (args.get_dir_deleg) {
-		if (status =3D=3D -EOPNOTSUPP) {
+		switch (status) {
+		case 0:
+			if (gdd_res.status !=3D GDD4_OK)
+				break;
+			status =3D nfs_inode_set_delegation(
+				inode, current_cred(), FMODE_READ,
+				&gdd_res.deleg, 0, NFS4_OPEN_DELEGATE_READ);
+			break;
+		case -ENOTSUPP:
+		case -EOPNOTSUPP:
 			server->caps &=3D ~NFS_CAP_DIR_DELEG;
-		} else if (status =3D=3D 0 && gdd_res.status =3D=3D GDD4_OK) {
-			status =3D nfs_inode_set_delegation(inode, current_cred(),
-							  FMODE_READ, &gdd_res.deleg,
-							  0, NFS4_OPEN_DELEGATE_READ);
 		}
 	}
 	return status;
@@ -4554,10 +4559,14 @@ int nfs4_proc_getattr(struct nfs_server *server, st=
ruct nfs_fh *fhandle,
 	do {
 		err =3D _nfs4_proc_getattr(server, fhandle, fattr, inode);
 		trace_nfs4_getattr(server, fhandle, fattr, err);
-		if (err =3D=3D -EOPNOTSUPP)
-			exception.retry =3D true;
-		else
+		switch (err) {
+		default:
 			err =3D nfs4_handle_exception(server, err, &exception);
+			break;
+		case -ENOTSUPP:
+		case -EOPNOTSUPP:
+			exception.retry =3D true;
+		}
 	} while (exception.retry);
 	return err;
 }
--=20
2.52.0


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

