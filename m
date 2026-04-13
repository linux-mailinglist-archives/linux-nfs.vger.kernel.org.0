Return-Path: <linux-nfs+bounces-20826-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HfBNxNg3WmadAkAu9opvQ
	(envelope-from <linux-nfs+bounces-20826-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 23:28:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 468FB3F387B
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 23:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6B630136A7
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13637C904;
	Mon, 13 Apr 2026 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG3luhwG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69F7DA66
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115432; cv=none; b=Kc4o3443cwPOCU4QQBv362KdZ6u1kJgJApQwpKplHRmhkkp1vXv+GVcHgNzTyt8Y9hUWzxHOBEU3Q3CX/b7WrgoqkU4bEmCtP5vQftIg0JwnubaUmfxcX3fHzNorGe+0ZqUSAkw5lRnBAITG1xlB0pgcE3T0R7XBcdzO0cb3wzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115432; c=relaxed/simple;
	bh=SLKFW1oK7vpI1iZS+OdOxV/u33yKByswL81rhW2dWg8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQDMo+Yd92/lCcHemcWwmADEz2vyvQjqJQjle5kQCYq5vZ1z3EXetbmWjucj8mCy5bLvWpBkKQDkwcEUOFX1X9w2bf57ljwseXXSeKjt6G24TI6bjJU/sswbSjeTkPpfECalCg5zE8bTmqdBumo0QmUML/LLKynqxBpXaFQ/sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG3luhwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB27DC2BCAF;
	Mon, 13 Apr 2026 21:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776115432;
	bh=SLKFW1oK7vpI1iZS+OdOxV/u33yKByswL81rhW2dWg8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BG3luhwG+5Wt8KzaJhpTZWlk1YcOc+PXvT/2FX7bHyYozqQjRE9M9/fF9N0lcp8xX
	 yvpXpjqHZG8lSnGe+ZsRPzw3TAccnE61XG4zFgTSQYj4yBVUpIIn1lEo6nIJLB5+mT
	 Sl8r7dS/8hIAxjyA4Tl46YDEjSzzKq8YSLATpAwuXSl86T4HzjvwuZ54DgnhBg2EI4
	 b4m/ZQFCzscy6J1tKZv5rdmC3TeO0jCtEE2clGAoakHbMpDZbDEjk+hhAALiRs/pKM
	 VHTqawoPmXN5/IqsFJLtI464mH83mjt0uVvMuc5LB4i3jzGqveTyqqL85OEWgqf6Xx
	 o1dQcsVYWKhtw==
Message-ID: <041028abe38b53ef0e12ddfd20e5e11ee713a950.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.2: fix COPY attrs in presence of delegated
 timestamps
From: Trond Myklebust <trondmy@kernel.org>
To: Olga Kornievskaia <okorniev@redhat.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Mon, 13 Apr 2026 14:23:50 -0700
In-Reply-To: <20260327165757.28948-1-okorniev@redhat.com>
References: <20260327165757.28948-1-okorniev@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20826-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 468FB3F387B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-27 at 12:57 -0400, Olga Kornievskaia wrote:
> A similar to generic/407 test can be done with a COPY operation
> instead of CLONE (reflink). And it leads to same problem that ctime
> and mtime saved before doing a "cp" operation are the same as after.
>=20
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
> =C2=A0fs/nfs/nfs42proc.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index f77372a78be7..ea420dc94875 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -502,6 +502,12 @@ static ssize_t _nfs42_proc_copy(struct file
> *src,
> =C2=A0
> =C2=A0	nfs42_copy_dest_done(dst, pos_dst, res->write_res.count,
> oldsize_dst);
> =C2=A0	nfs_invalidate_atime(src_inode);
> +	if (nfs_have_delegated_attributes(dst_inode)) {
> +		nfs_update_delegated_mtime(dst_inode);
> +		spin_lock(&dst_inode->i_lock);
> +		nfs_set_cache_invalid(dst_inode,
> NFS_INO_INVALID_BLOCKS);
> +		spin_unlock(&dst_inode->i_lock);

Isn't NFS_INO_INVALID_BLOCKS already set it nfs42_copy_dest_done()?

> +	}
> =C2=A0	status =3D res->write_res.count;
> =C2=A0out:
> =C2=A0	if (args->sync)

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

