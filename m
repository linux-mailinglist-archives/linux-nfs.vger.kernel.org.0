Return-Path: <linux-nfs+bounces-1764-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F33C849217
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 01:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1951C2146D
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688908F47;
	Mon,  5 Feb 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0DyG/GPp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5kdVo748";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yGb5kFvd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZerP7Vjd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF68F40
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707094601; cv=none; b=QqSLfTXXCst63IsiwQQPzjoN6CFIS7rQdGZ+B6V+xyKzcWu1SeHtAPQt4kdzJwi7c+LbJda5yH4Y57GVg47hTtKAEhD6DgK8SDKbM93JvJaoRLaimAtPT1bhfxdb381LtCromUB5EPZxxW5FzIVHAGnKUgGK2otEhbNKzVTuN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707094601; c=relaxed/simple;
	bh=81SArmqbjUSW6oEYEdcYL9TeUSzQy5SQ1KtYakK9/Jw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=I5cOuXrwVj8Y7uSALzRCbw2NDcvRXwiMJNNP5cRBpQwdO9o46io7O+GV4rarU6OOuQ5TAYYG18xTPl2+Lx+FyZ3Dfa3Hc6xh6NQ4lIsJV+GoMgSmzoEPK6klgf3XGchkWFrj9+SyLj+zgaT6csoYx1lRq7jf4fR7ogDuMY8GNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0DyG/GPp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5kdVo748; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yGb5kFvd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZerP7Vjd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D74EA1F845;
	Mon,  5 Feb 2024 00:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707094597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIj8RZksKgbSeX8P8eS+qiAgf3wlE+kTx8RenTX9UCU=;
	b=0DyG/GPprqRqn5IhJBe2QX2l8m2mKLxq5zSt+OEKGCt8u+0fMrEBFXhmKxQ6fljXaj1ZHb
	kNpiJf3+QDZvxTcIyopY/WZPKVXBl36m8Rrdvts14pq/RFEi689aB+u7KxeKBs/SNYzR+N
	0Em71umhdzTCWgIipETHUupgo50WE6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707094597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIj8RZksKgbSeX8P8eS+qiAgf3wlE+kTx8RenTX9UCU=;
	b=5kdVo748QaXQZiz4qww/Px+kE8zCUg0Q1LgcsirrenjZi7yO2uJnwlgt+82GKtghGXxieh
	VIvk47kLL+4LRlAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707094596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIj8RZksKgbSeX8P8eS+qiAgf3wlE+kTx8RenTX9UCU=;
	b=yGb5kFvd+oZGRo+5SwO8IPktrIybY73Gbj1xsN0KuSJNpArlFwjwkKYik5vOTeZAqFYWCB
	uyTkm71QZvuGPM8XuUBtGCSZBxaO5zad57UeOi01c5p28x6P19/n+RhfO5e7huOccwCHdn
	AroHRf1VOQJhDMQkUG8eaCqBIVKZurw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707094596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIj8RZksKgbSeX8P8eS+qiAgf3wlE+kTx8RenTX9UCU=;
	b=ZerP7Vjd3Qr7ZKjWhhJPlk2i1SCWrXyzj5dgfASr5OElNGwX4WbHe2dWdDynM0PGWYHvKr
	eYEdQeYFnT7FSYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE98F132DD;
	Mon,  5 Feb 2024 00:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3OuCKEMywGWjNQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 05 Feb 2024 00:56:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: deadlock in RELEASE_LOCKOWNER path
In-reply-to: <4270586C-9776-4DBF-BFB6-A36B79B1AFEA@oracle.com>
References: <4270586C-9776-4DBF-BFB6-A36B79B1AFEA@oracle.com>
Date: Mon, 05 Feb 2024 11:56:32 +1100
Message-id: <170709459274.13976.2354054478600894934@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yGb5kFvd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZerP7Vjd
X-Spamd-Result: default: False [-5.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 TO_DN_ALL(0.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D74EA1F845
X-Spam-Level: 
X-Spam-Score: -5.31
X-Spam-Flag: NO

On Mon, 05 Feb 2024, Chuck Lever III wrote:
> Hi Neil-
>=20
> I'm testing v6.8-rc3 + nfsd-next. This series includes:
>=20
>    nfsd: fix RELEASE_LOCKOWNER
>=20
> and
>=20
>    nfsd: don't call locks_release_private() twice concurrently
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.8.0-rc3-00052-gc20ad5c2d60c #1 Not tainted
> ------------------------------------------------------
> nfsd/1218 is trying to acquire lock:
> ffff88814d754198 (&ctx->flc_lock){+.+.}-{2:2}, at: check_for_locks+0xf6/0x1=
d0 [nfsd]
>=20
> but task is already holding lock:
> ffff8881210e61f0 (&fp->fi_lock){+.+.}-{2:2}, at: check_for_locks+0x2d/0x1d0=
 [nfsd]
>=20
> which lock already depends on the new lock.

I should have found this when I was checking on flc_lock...  sorry.

I think this could actually deadlock if a lease was being broken on a
file at the same time that some interesting file locking was happening
...  though that might not actually be possible as conflicting locks and
delegations rarely mix.  Still - we should fix it.

One approach would be to split flc_lock into two locks, one for leases
and one for posix+flock locks.  That would avoid this conflict, but
isn't particularly elegant.

I'm not at all certain that nfsd_break_deleg_cb() needs to take fi_lock.
In earlier code it needed to walk ->fi_delegations and that would need
the lock - but that was removed in v4.17-rc1~110^2~22.

The only remaining possible need for fi_lock is fi_had_conflict.
nfsd_break_deleg_cb() take the lock when setting the flag, and
nfsd_set_delegation() takes the lock when testing the flag.  I cannot
see why the strong exclusion is needed.

We test fi_had_conflict early in nfsd_set_delegation as an optimisation,
and that makes sense.
Test it again after calling vfs_setlease() to get the lease makes sense
in case there was some other grant/revoke before the early test and the
vfs_setlease().  But once vfs_setlease has succeed and we confirmed no
conflict yet, I cannot see why we would abort the least.  If a revoke
came in while nfsd_set_deletation() is running the result doesn't need
to be different to if a revoke comes in just aster nfsd_set_delegation()
completes....  Does it?

So I think we can drop the lock frome break_deleg_cb() and make the
importance of fi_had_conflict explicit by moving the test out of the
lock.
e.g.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 12534e12dbb3..8b112673d389 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5154,10 +5154,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	 */
 	fl->fl_break_time =3D 0;
=20
-	spin_lock(&fp->fi_lock);
 	fp->fi_had_conflict =3D true;
 	nfsd_break_one_deleg(dp);
-	spin_unlock(&fp->fi_lock);
 	return false;
 }
=20
@@ -5771,13 +5769,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct n=
fs4_ol_stateid *stp,
 	if (status)
 		goto out_unlock;
=20
+	status =3D -EAGAIN;
+	if (fp->fi_had_conflict)
+		goto out_unlock;
+
 	spin_lock(&state_lock);
 	spin_lock(&clp->cl_lock);
 	spin_lock(&fp->fi_lock);
-	if (fp->fi_had_conflict)
-		status =3D -EAGAIN;
-	else
-		status =3D hash_delegation_locked(dp, fp);
+	status =3D hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
 	spin_unlock(&clp->cl_lock);
 	spin_unlock(&state_lock);


fi_had_conflict is set under flc_lock, and vfs_setlease() will take
flc_lock, so while the set and test may appear lockless, they aren't.

I'll do some basic testing and send a proper patch for your
consideration.

Thanks
NeilBrown

