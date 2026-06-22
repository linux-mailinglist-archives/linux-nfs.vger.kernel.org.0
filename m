Return-Path: <linux-nfs+bounces-22762-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DIaqAnNAOWpOpQcAu9opvQ
	(envelope-from <linux-nfs+bounces-22762-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 16:02:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 553546B0204
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 16:02:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AFxBufpd;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22762-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22762-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B0193073731
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BA23B47C4;
	Mon, 22 Jun 2026 13:56:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F23B2FF6;
	Mon, 22 Jun 2026 13:56:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136566; cv=none; b=DaW4tLGcmDUfK+6Kd0HbQOFEjVhe/NpqUVGs0I5VYziZrHwx6PbrT5O434Ml/5cuIPFq59rXOZW+TEkZn1JV0nsiS9+daQ9OaRbvI3XxnwUztelvq84qVL/TQElGfcJeyaqhNC6r1Xy+GeasSq5Aa9YsqtqZtGPWF7hXdtKR8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136566; c=relaxed/simple;
	bh=LKr+YPJtrjomGYwWg3kf0WOf3aBNZci9gU1urRCALJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lh66Jc7IX1vxRJY0WRIflK7Ins/GGgoD6Zfw7PjaXToG/3BWNbdFzT7jo6yZ6psqo+YXil1mWTMrvNdrmRnp3VgpB4WTSG1b6XT+xv5VT7wGXGM6F+t7+j3x96BuLjfSbWrLLt8A1zdTL3K7AnrjNj9jQvl5F54C3k2bFqpfgdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFxBufpd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0D61F000E9;
	Mon, 22 Jun 2026 13:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782136564;
	bh=F6e/r1oTclgPS+kw+4oDjkxzumrdY03nm4aIFJVo8y0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AFxBufpdPStXiVDRkukjHH7bi5topOnA+1/jLR7mO+iqzK+BH12O7X5F1p5zBXdlG
	 SVFmG2B43Q8qIUXghi4bUTH+0addKlkCXL4NB0WgUYZv2XgnFtLSyyUKkQuR3/KeEb
	 URacgQETb+oDkvJW51U333UI+ScdSkKnT2AT6bSa2vYW9kliazjo9mrHbYuQ3116Ca
	 Q7r1O057M/hH9XCze541Qg3xYBVzH9pLKt2kqDCUYdORXlQ+C+GBEM3UnAJeCoEIDV
	 fQIGHFGbneeof77EoVg9LL61voaMERocMhpNyD1FcU7IwNnI4Gcd9TfBnN0h/YvQYp
	 taNxIE8JTgUxw==
Message-ID: <2d09ab9a74d1eb21c99454dba8be597612d20efa.camel@kernel.org>
Subject: Re: [PATCH] NFS: invalidate i_blocks after COMMIT to fix stale
 block count on NFSv4
From: Trond Myklebust <trondmy@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>, anna@kernel.org, 
	linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
Date: Mon, 22 Jun 2026 09:56:03 -0400
In-Reply-To: <20260622060038.13731-1-jefflexu@linux.alibaba.com>
References: <20260622060038.13731-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jefflexu@linux.alibaba.com,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joseph.qi@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22762-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 553546B0204

On Mon, 2026-06-22 at 14:00 +0800, Jingbo Xu wrote:
> NFSv4 COMMIT compound does not include GETATTR, and
> nfs4_commit_done_cb
> does not refresh inode attributes. Meanwhile, every WRITE marks
> NFS_INO_INVALID_BLOCKS via nfs_post_op_update_inode_force_wcc_locked.
>=20
> After COMMIT, i_blocks remains stale until the next stat() triggers a
> full revalidation. In writeback-heavy workloads where COMMITs happen
> without intervening stat() calls, the cached block count can stay
> indefinitely wrong.
>=20
> Mark NFS_INO_INVALID_BLOCKS on successful COMMIT completion so that
> the
> next nfs_getattr requesting STATX_BLOCKS will issue a GETATTR with
> SPACE_USED, fetching the correct value from the server.
>=20
> This matches NFSv3 behavior where nfs3_commit_done already calls
> nfs_refresh_inode with the wcc_data post-op attributes.
>=20
> Reproduce with xfstests generic/694 on NFSv4.0 loopback:
>=20
> =C2=A0 Server:
> =C2=A0=C2=A0=C2=A0 mount /dev/vdc /data/test
> =C2=A0=C2=A0=C2=A0 mount /dev/vdd /data/scratch
> =C2=A0=C2=A0=C2=A0 exportfs -o insecure,rw,sync,no_root_squash,fsid=3D1
> 127.0.0.1:/data/test
> =C2=A0=C2=A0=C2=A0 exportfs -o insecure,rw,sync,no_root_squash,fsid=3D2
> 127.0.0.1:/data/scratch
>=20
> =C2=A0 Client:
> =C2=A0=C2=A0=C2=A0 mount -t nfs -o vers=3D4.0 localhost:/data/test /mnt/t=
est
> =C2=A0=C2=A0=C2=A0 mount -t nfs -o vers=3D4.0 localhost:/data/scratch /mn=
t/scratch
>=20
> =C2=A0 local.config:
> =C2=A0=C2=A0=C2=A0 export TEST_FS_MOUNT_OPTS=3D"-o vers=3D4.0"
> =C2=A0=C2=A0=C2=A0 export MOUNT_OPTIONS=3D"-o vers=3D4.0"
> =C2=A0=C2=A0=C2=A0 export FSTYP=3Dnfs
> =C2=A0=C2=A0=C2=A0 export TEST_DEV=3Dlocalhost:/data/test
> =C2=A0=C2=A0=C2=A0 export SCRATCH_DEV=3Dlocalhost:/data/scratch
> =C2=A0=C2=A0=C2=A0 export TEST_DIR=3D/mnt/test
> =C2=A0=C2=A0=C2=A0 export SCRATCH_MNT=3D/mnt/scratch
>=20
> This fixes xfstests generic/694.
>=20
> Assisted-by: Qoder:Qwen3.7-Max
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> =C2=A0fs/nfs/write.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index d7c399763ad9..88c5c9f7434c 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1851,6 +1851,8 @@ static void nfs_commit_release_pages(struct
> nfs_commit_data *data)
> =C2=A0		/* Latency breaker */
> =C2=A0		cond_resched();
> =C2=A0	}
> +	if (status >=3D 0)
> +		nfs_set_cache_invalid(data->inode,
> NFS_INO_INVALID_BLOCKS);
> =C2=A0
> =C2=A0	nfs_init_cinfo(&cinfo, data->inode, data->dreq);
> =C2=A0	nfs_commit_end(cinfo.mds);

That sounds like an XFS bug, not an NFS bug. COMMIT isn't changing the
data contents of the file: it is just ensuring that the existing data
is persisted onto disk.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

