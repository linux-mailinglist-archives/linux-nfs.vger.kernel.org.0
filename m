Return-Path: <linux-nfs+bounces-10932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3D1A741A4
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 00:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B30C3B3B6F
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Mar 2025 23:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F38F1A5BA6;
	Thu, 27 Mar 2025 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xowgWOrI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DaQKh6iT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xowgWOrI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DaQKh6iT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B418C345
	for <linux-nfs@vger.kernel.org>; Thu, 27 Mar 2025 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743119659; cv=none; b=gjqvBQUIuiLvFKS8QUKscvXXWbVM/utLk+3XiM0IfhPUhJy1qszsxbbsWC1NBKgAWEjhLTQAXKsoJ/2neEMtUFuaRhOPsucH9ZqOVbqd8Cs1fsYNBHSuTrfER0zd4tUQwxjvT2gtijJYLcPUTc8rQon08Ab1AKu6ZQUULk+fP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743119659; c=relaxed/simple;
	bh=f2OvPW+VC60VX4XxNJnVyQ3+Fv5AfXZJtAWxm6lHWdU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MuEYGQxqkbk3oIylpYwxnuYP0SsID11nCm2iVpKJ1eDZ/N1UJ7GsFPy7zmBeCKJ+MDyRbXxrLcPuVkCkhyZCJvrMxBFcLK6V4O7F7cP2QkbzCX+csykN9EEbNU8htQvHkiWpp6G87IyT0uXP9cte/pSWgHY/VjKJNkxz0Pj2Wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xowgWOrI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DaQKh6iT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xowgWOrI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DaQKh6iT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 857B01F388;
	Thu, 27 Mar 2025 23:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743119653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGOTBfvzWKQRD24Pi3f+RERipMh+QDAhxuflcAg8GUs=;
	b=xowgWOrIEZaNKjazZBLgeOPclchanXlXdg4ts75k4Go+PkZcnzx05Va6UMM4KT1QkrTGb2
	q+uWZMKNQCc59BnO74687nBPAakOlX8Frw0ftEzbl1IIb7wXTDsShyHqOx46ARX7X+W/Mv
	ZA/0KdfS9ju8Ju/MuYcj6La22rgS7+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743119653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGOTBfvzWKQRD24Pi3f+RERipMh+QDAhxuflcAg8GUs=;
	b=DaQKh6iTHEqy7CHzKt21/ThEyEibolSICXt+ekeoNgp8RFTPU/vOodj9DR4xrxudsR6QOF
	orMUlcBuaIAewmDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743119653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGOTBfvzWKQRD24Pi3f+RERipMh+QDAhxuflcAg8GUs=;
	b=xowgWOrIEZaNKjazZBLgeOPclchanXlXdg4ts75k4Go+PkZcnzx05Va6UMM4KT1QkrTGb2
	q+uWZMKNQCc59BnO74687nBPAakOlX8Frw0ftEzbl1IIb7wXTDsShyHqOx46ARX7X+W/Mv
	ZA/0KdfS9ju8Ju/MuYcj6La22rgS7+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743119653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGOTBfvzWKQRD24Pi3f+RERipMh+QDAhxuflcAg8GUs=;
	b=DaQKh6iTHEqy7CHzKt21/ThEyEibolSICXt+ekeoNgp8RFTPU/vOodj9DR4xrxudsR6QOF
	orMUlcBuaIAewmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 770EA1376E;
	Thu, 27 Mar 2025 23:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vq7FCyPl5Wd7fgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Mar 2025 23:54:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org,
 Dai.Ngo@oracle.com, tom@talpey.com, "Olga Kornievskaia" <okorniev@redhat.com>
Subject:
 Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
In-reply-to: <20250322001306.41666-4-okorniev@redhat.com>
References: <20250322001306.41666-1-okorniev@redhat.com>,
 <20250322001306.41666-4-okorniev@redhat.com>
Date: Fri, 28 Mar 2025 10:54:08 +1100
Message-id: <174311964828.9342.15055420092560166796@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
> NLM locking calls need to pass thru file permission checking
> and for that prior to calling inode_permission() we need
> to set appropriate access mask.
>=20
> Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/vfs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 4021b047eb18..7928ae21509f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred, struct svc_ex=
port *exp,
>  	if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
>  		return nfserr_perm;
> =20
> +	/*
> +	 * For the purpose of permission checking of NLM requests,
> +	 * the locker must have READ access or own the file
> +	 */
> +	if (acc & NFSD_MAY_NLM)
> +		acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> +

I don't agree with this change.
The only time that NFSD_MAY_NLM is set, NFSD_MAY_OWNER_OVERRIDE is also
set.  So that part of the change adds no value.

This change only affects the case where a write lock is being requested.
In that case acc will contains NFSD_MAY_WRITE but not NFSD_MAY_READ.
This change will set NFSD_MAY_READ.  Is that really needed?

Can you please describe the particular problem you saw that is fixed by
this patch?  If there is a problem and we do need to add NFSD_MAY_READ,
then I would rather it were done in nlm_fopen().

Thanks,
NeilBrown


>  	/*
>  	 * The file owner always gets access permission for accesses that
>  	 * would normally be checked at open time. This is to make
> --=20
> 2.47.1
>=20
>=20


