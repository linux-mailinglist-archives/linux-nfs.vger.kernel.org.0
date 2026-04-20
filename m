Return-Path: <linux-nfs+bounces-20972-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCTqBrJp5mnBvwEAu9opvQ
	(envelope-from <linux-nfs+bounces-20972-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 20:00:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9191243261C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 20:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0337030F3CC2
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 16:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649C6220687;
	Mon, 20 Apr 2026 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypm2zXH2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6F34572B
	for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701746; cv=none; b=AbdNhLQuvkzKALugyQs25m3BsyAlFVQD+EU1+9pmqzppdh6fkneG6h8gPwGUT/rzSextIa7AMCql+atsn0uweOOI2Y2uXG5oYIFXVaNaClcPz/vrPk87wjXpAxhgWU2b+d33jKz1JSM7m9jAwf9bsrnKBrdIiJ3ognDON7ChCOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701746; c=relaxed/simple;
	bh=pkNs9ufU9d5igR8vL4G2lwcpOYnB6L/BL8aGV0bgNec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RvvkCI0XwsA38fw5ZZirsLGTq2DCu2g1yc6XCi23Eo2XMsmjPMreRKOClfcRJGn62jWDCopua6oLulWMISOgL5yWClBlWt5SGp2+GeIE8VxMpKO4nKYLVvhX9tfSYRRfA2Dh5pl5OOV7GgLr7wMKjMatv19ykBMqEUIGn67nURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypm2zXH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D26C2BCB4;
	Mon, 20 Apr 2026 16:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776701746;
	bh=pkNs9ufU9d5igR8vL4G2lwcpOYnB6L/BL8aGV0bgNec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ypm2zXH2UFfTgUiTs6pM2kBdFlbd7Ij1vMmHE1JTaNB+n8ox69ydJ8iRcnbnnHmEx
	 3NWfYiIA7ft8AbdCZYzoZh+wrDX+cnT2dLzGExJ7/ALOzbwWdRW6twevZfo5FQb3qB
	 hLO3A9FSiwPXQU4vk5EMt6kk9IOw5pYG95XoejdeAz9MDoY+PsiW9Ma8/vKkSDVE3q
	 tqdGW0lPun1DLdmwtGrkjjLKy72cwb6ZDEaD8ahTXiHpfUpIy2wRprjcDk64LryW7E
	 tMA2KfBgD8+tNTkNKY26IhXEAaXsSpMkLstTMkIo/hRcgo+/tnve51KXnqBCgOB2Nx
	 GxabtJdL95Z9g==
Message-ID: <94e8705dcd4c4cee52e6c234a533fd4968ec4fb9.camel@kernel.org>
Subject: Re: [PATCH RESEND] nfs: force drop_nlink if we have a delegation
 during REMOVE
From: Trond Myklebust <trondmy@kernel.org>
To: Roberto Bergantinos Corpas <rbergant@redhat.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Mon, 20 Apr 2026 12:15:44 -0400
In-Reply-To: <20260420114331.700769-1-rbergant@redhat.com>
References: <20260420114331.700769-1-rbergant@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20972-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 9191243261C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-20 at 13:43 +0200, Roberto Bergantinos Corpas wrote:
> commit bd4928ec799b ("NFS: Avoid changing nlink when file removes and
> attribute updates race") avoids races on attribute cache with any
> inflight RPC that may modify inode attributes (and gencount) during
> i.e. REMOVE.
>=20
> However it does not take into account that REMOVE may trigger
> a delegation return which also advances gencount (via the attribute
> refresh during delegation return), and in that case the gencount
> mismatch is not due to an inflight RPC that already reflected the
> removal.
>=20
> If nlink is 1 and we have a delegation before REMOVE, we should force
> the drop to ensure the VFS delivers the expected FS_DELETE_SELF
> notification.
>=20
> This fixes LTP/inotify04 failure after bd4928ec799b.
>=20
> Fixes: bd4928ec799b ("NFS: Avoid changing nlink when file removes and
> attribute updates race")
> Reviewed-by: Olga Kornievskaia <okorniev@redhat.com>
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> ---
> =C2=A0fs/nfs/dir.c | 11 ++++++-----
> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 2402f57c8e7d..bc6bbf434a21 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1937,13 +1937,13 @@ static int nfs_dentry_delete(const struct
> dentry *dentry)
> =C2=A0}
> =C2=A0
> =C2=A0/* Ensure that we revalidate inode->i_nlink */
> -static void nfs_drop_nlink(struct inode *inode, unsigned long
> gencount)
> +static void nfs_drop_nlink(struct inode *inode, unsigned long
> gencount, bool force)
> =C2=A0{
> =C2=A0	struct nfs_inode *nfsi =3D NFS_I(inode);
> =C2=A0
> =C2=A0	spin_lock(&inode->i_lock);
> =C2=A0	/* drop the inode if we're reasonably sure this is the last
> link */
> -	if (inode->i_nlink > 0 && gencount =3D=3D nfsi->attr_gencount)
> +	if (inode->i_nlink > 0 && (force || gencount =3D=3D nfsi-
> >attr_gencount))
> =C2=A0		drop_nlink(inode);
> =C2=A0	nfsi->attr_gencount =3D nfs_inc_attr_generation_counter();
> =C2=A0	nfs_set_cache_invalid(
> @@ -1961,7 +1961,7 @@ static void nfs_dentry_iput(struct dentry
> *dentry, struct inode *inode)
> =C2=A0	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
> =C2=A0		unsigned long gencount =3D READ_ONCE(NFS_I(inode)-
> >attr_gencount);
> =C2=A0		nfs_complete_unlink(dentry, inode);
> -		nfs_drop_nlink(inode, gencount);
> +		nfs_drop_nlink(inode, gencount, false);
> =C2=A0	}
> =C2=A0	iput(inode);
> =C2=A0}
> @@ -2556,10 +2556,11 @@ static int nfs_safe_remove(struct dentry
> *dentry)
> =C2=A0	trace_nfs_remove_enter(dir, dentry);
> =C2=A0	if (inode !=3D NULL) {
> =C2=A0		unsigned long gencount =3D READ_ONCE(NFS_I(inode)-
> >attr_gencount);
> +		bool force_drop =3D
> nfs_have_read_or_write_delegation(inode) && inode->i_nlink =3D=3D 1;
> =C2=A0
> =C2=A0		error =3D NFS_PROTO(dir)->remove(dir, dentry);
> =C2=A0		if (error =3D=3D 0)
> -			nfs_drop_nlink(inode, gencount);
> +			nfs_drop_nlink(inode, gencount, force_drop);
> =C2=A0	} else
> =C2=A0		error =3D NFS_PROTO(dir)->remove(dir, dentry);
> =C2=A0	if (error =3D=3D -ENOENT)
> @@ -2852,7 +2853,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct
> inode *old_dir,
> =C2=A0			new_dir, new_dentry, error);
> =C2=A0	if (!error) {
> =C2=A0		if (new_inode !=3D NULL)
> -			nfs_drop_nlink(new_inode, new_gencount);
> +			nfs_drop_nlink(new_inode, new_gencount,
> false);
> =C2=A0		/*
> =C2=A0		 * The d_move() should be here instead of in an
> async RPC completion
> =C2=A0		 * handler because we need the proper locks to move
> the dentry.=C2=A0 If

The right way to go about this is to push the setting of gencount from
nfs_safe_remove() down into the version-specific layer so that you can
order it correctly with the delegation return and call to
_nfs4_proc_remove().

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

