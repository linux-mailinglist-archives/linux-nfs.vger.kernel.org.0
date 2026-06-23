Return-Path: <linux-nfs+bounces-22775-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0z0bIskQOmpm0wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22775-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 06:51:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4866B4087
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 06:51:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OEQi3QCe;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22775-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22775-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 502253014103
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 04:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4933DEF2;
	Tue, 23 Jun 2026 04:51:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D653E0B;
	Tue, 23 Jun 2026 04:51:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190278; cv=none; b=WkFpFPRUFiuODfzEx9XXsXN05oWNo2DGWVJxULNBmrO0GUCdTMxxTI51dUK6ZSMGT8XLixyRuUXep/nGt6lezFF7Tx/n2odV1Bp9d8Mn0c9vD6Y9U9ZI5wwMQKhXtgB20usRIlfmkitktc4aspl/7IXIIzDwj3UZx2lO0WrLsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190278; c=relaxed/simple;
	bh=g6pPTdJKHt99oTNfT1bwftlcKqX0DrXYc17sDi3R0MA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jIQY+GbVkMVuMZkm35oR2JWPjSNRYNSrKx7poMUBDxOI7SONxNJh3wKxfvw6lMFVwP00Ura3yU4PsUlxLPeQjWR74H3QH2jvILO2va51LNg35DHDdobpt05D5hxUYDfT+S/iE721KPS8LSNDdYrUB1jbX8XQh2AJZ2nJAO2HepU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEQi3QCe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1701F000E9;
	Tue, 23 Jun 2026 04:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782190277;
	bh=GWTzonBHa9xNPux/c4by1Ldgi1E1+bJfxU46j6hazpE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OEQi3QCem14IMYfeWeZJv2Hh7xWmX6HRZlCBDVMGpFnkj9Y6O0lJg3ggPMjh0uq9C
	 XC4sIQ8zDxMlV0R1Z3c38t02+XMQ4zINxTJjbywdT9SuyHUQuupR5IEVeRPtWZXaQO
	 a3kyBFEoUZoOMqMPXXo47oqbjfIUTUnShS/nP2dH6Fxgcy3yCxMXcPwRbFlfvYSlY+
	 RBiKEWJoXrJWeW1YCBE6GGC07fC0/mZet2/0qggMWXVAyOaWG2kzZN4vKw3AviJD5l
	 5f5KXfK07tF2HThGk3yPEf7KdxuLeonTV9xcIyCiO+6wx1hoZqXhlf+S6/JssNmkOa
	 IsJzoophadT1A==
Message-ID: <2098148dfb9e156dd88242afecdea5d372b7a169.camel@kernel.org>
Subject: Re: [PATCH] NFS: invalidate i_blocks after COMMIT to fix stale
 block count on NFSv4
From: Trond Myklebust <trondmy@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>, anna@kernel.org, 
	linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com, 
	linux-xfs@vger.kernel.org
Date: Tue, 23 Jun 2026 00:51:16 -0400
In-Reply-To: <71d4ac02-d760-49ab-a01c-e7d1a6662a18@linux.alibaba.com>
References: <20260622060038.13731-1-jefflexu@linux.alibaba.com>
	 <2d09ab9a74d1eb21c99454dba8be597612d20efa.camel@kernel.org>
	 <71d4ac02-d760-49ab-a01c-e7d1a6662a18@linux.alibaba.com>
Content-Type: text/markdown; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jefflexu@linux.alibaba.com,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joseph.qi@linux.alibaba.com,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22775-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,alibaba.com:email,hammerspace.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA4866B4087

On Tue, 2026-06-23 at 12:04 +0800, Jingbo Xu wrote:

> +cc [linux-xfs@vger.kernel.org](mailto:linux-xfs@vger.kernel.org)
>=20
> On 6/22/26 9:56 PM, Trond Myklebust wrote:
>=20
> > On Mon, 2026-06-22 at 14:00 +0800, Jingbo Xu wrote:
> >=20
> > > NFSv4 COMMIT compound does not include GETATTR, and
> > > nfs4_commit_done_cb
> > > does not refresh inode attributes. Meanwhile, every WRITE marks
> > > NFS_INO_INVALID_BLOCKS via nfs_post_op_update_inode_force_wcc_locked.
> > >=20
> > > After COMMIT, i_blocks remains stale until the next stat() triggers a
> > > full revalidation. In writeback-heavy workloads where COMMITs happen
> > > without intervening stat() calls, the cached block count can stay
> > > indefinitely wrong.
> > >=20
> > > Mark NFS_INO_INVALID_BLOCKS on successful COMMIT completion so that
> > > the
> > > next nfs_getattr requesting STATX_BLOCKS will issue a GETATTR with
> > > SPACE_USED, fetching the correct value from the server.
> > >=20
> > > This matches NFSv3 behavior where nfs3_commit_done already calls
> > > nfs_refresh_inode with the wcc_data post-op attributes.
> > >=20
> > > Reproduce with xfstests generic/694 on NFSv4.0 loopback:
> > >=20
> > > =C2=A0 Server:
> > > =C2=A0=C2=A0=C2=A0 mount /dev/vdc /data/test
> > > =C2=A0=C2=A0=C2=A0 mount /dev/vdd /data/scratch
> > > =C2=A0=C2=A0=C2=A0 exportfs -o insecure,rw,sync,no_root_squash,fsid=
=3D1
> > > 127.0.0.1:/data/test
> > > =C2=A0=C2=A0=C2=A0 exportfs -o insecure,rw,sync,no_root_squash,fsid=
=3D2
> > > 127.0.0.1:/data/scratch
> > >=20
> > > =C2=A0 Client:
> > > =C2=A0=C2=A0=C2=A0 mount -t nfs -o vers=3D4.0 localhost:/data/test /m=
nt/test
> > > =C2=A0=C2=A0=C2=A0 mount -t nfs -o vers=3D4.0 localhost:/data/scratch=
 /mnt/scratch
> > >=20
> > > =C2=A0 local.config:
> > > =C2=A0=C2=A0=C2=A0 export TEST_FS_MOUNT_OPTS=3D"-o vers=3D4.0"
> > > =C2=A0=C2=A0=C2=A0 export MOUNT_OPTIONS=3D"-o vers=3D4.0"
> > > =C2=A0=C2=A0=C2=A0 export FSTYP=3Dnfs
> > > =C2=A0=C2=A0=C2=A0 export TEST_DEV=3Dlocalhost:/data/test
> > > =C2=A0=C2=A0=C2=A0 export SCRATCH_DEV=3Dlocalhost:/data/scratch
> > > =C2=A0=C2=A0=C2=A0 export TEST_DIR=3D/mnt/test
> > > =C2=A0=C2=A0=C2=A0 export SCRATCH_MNT=3D/mnt/scratch
> > >=20
> > > This fixes xfstests generic/694.
> > >=20
> > > Assisted-by: Qoder:Qwen3.7-Max
> > > Signed-off-by: Jingbo Xu <[jefflexu@linux.alibaba.com](mailto:jefflex=
u@linux.alibaba.com)>
> > > ---
> > > =C2=A0fs/nfs/write.c | 2 ++
> > > =C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > > index d7c399763ad9..88c5c9f7434c 100644
> > > --- a/fs/nfs/write.c
> > > +++ b/fs/nfs/write.c
> > > @@ -1851,6 +1851,8 @@ static void nfs_commit_release_pages(struct
> > > nfs_commit_data *data)
> > > =C2=A0		/* Latency breaker */
> > > =C2=A0		cond_resched();
> > > =C2=A0	}
> > > +	if (status >=3D 0)
> > > +		nfs_set_cache_invalid(data->inode,
> > > NFS_INO_INVALID_BLOCKS);
> > > =C2=A0
> > > =C2=A0	nfs_init_cinfo(&cinfo, data->inode, data->dreq);
> > > =C2=A0	nfs_commit_end(cinfo.mds);
> >=20
> >=20
> > That sounds like an XFS bug, not an NFS bug. COMMIT isn't changing the
> > data contents of the file: it is just ensuring that the existing data
> > is persisted onto disk.
> >=20
>=20
>=20
> Yes the underlying backend filesystem is indeed xfs.
>=20
> I retest it and can confirm that this failure is much likely
> reproducible on NFS upon XFS, while NFS upon EXT4 succeeds for 50
> consecutive test runs.
>=20
> Beside XFS itself also passes the test.
>=20
>=20
> To be honest I'm not familiar with NFS, following is what AI concludes:
>=20
> ```
> Root Cause Timing Sequence: NFSv4.0 Stale i_blocks After syncfs
>=20
>=20
> =C2=A0=C2=A0 Client issues multiple UNSTABLE WRITEs =E2=80=94 each WRITE =
compound includes
> a piggy-backed GETATTR that returns the server's current SPACE_USED. The
> client updates inode->i_blocks from the last completed WRITE's post-op
> attributes.
>=20
> =C2=A0=C2=A0 Server-side delayed allocation =E2=80=94 the export's local =
filesystem
> (ext4/xfs) uses delayed allocation. Metadata blocks (indirect blocks /
> extent tree nodes) are not yet allocated during most WRITE handling;
> they materialize only when the local fs performs its own writeback.
>=20
> =C2=A0=C2=A0 Last WRITE completes before server metadata writeback (~80%
> probability in user's environment) =E2=80=94 the final GETATTR returns
> SPACE_USED =3D 8388608 (data only, no metadata block). Client caches
> i_blocks =3D 8388608.
>=20
> =C2=A0=C2=A0 syncfs triggers COMMIT =E2=80=94 nfs_write_inode(WB_SYNC_ALL=
) calls
> __nfs_commit_inode, which sends a COMMIT RPC to the server.
> =C2=A0=C2=A0 Server executes vfs_fsync_range =E2=80=94 this forces the lo=
cal fs writeback,
> which now allocates the metadata block. Server's true SPACE_USED becomes
> 8388616 (+8 sectors =3D 4 KiB).
>=20
> =C2=A0=C2=A0 COMMIT response carries no file attributes =E2=80=94 per RFC=
 7530 =C2=A716.3.3,
> COMMIT4resok contains only a write verifier. The XDR decoder
> (nfs4_xdr_dec_commit) never calls decode_getfattr.
>=20
> =C2=A0=C2=A0 nfs_commit_release_pages performs no attribute invalidation =
=E2=80=94 it
> neither sends a follow-up GETATTR nor marks NFS_INO_INVALID_BLOCKS. The
> stale cached value persists.
>=20
> =C2=A0=C2=A0 Subsequent stat returns stale i_blocks =E2=80=94 cache_valid=
ity is clean, so
> nfs_getattr serves the cached value 8388608 without revalidation.
>=20
> =C2=A0=C2=A0 After cycle_mount, fresh GETATTR returns 8388616 =E2=80=94 m=
ismatch detected,
> test fails.
> ```
>


I agree with your AI that this may indeed be a consequence of XFS's delayed=
 allocation feature. However that hardly changes the fact that it would be =
a violation of the POSIX rules for how write(), fsync() and stat() are supp=
osed to work in this situation.

My point is that I fail to see why we should degrade the performance of the=
 generic NFS client in order to address a bug in one of the back end filesy=
stems (in this case XFS) being exported.

So strong NACK to this patch from me.

```
--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

```


