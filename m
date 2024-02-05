Return-Path: <linux-nfs+bounces-1765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B984925A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 03:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112271C2182F
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 02:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8898831;
	Mon,  5 Feb 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YA03fI/c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GDSfU9K6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YA03fI/c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GDSfU9K6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB18484
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099768; cv=none; b=g8JU7a739p38yfYxdQyQZLQDWp6n3ZE0IIqIcHgj4r1bWXGl401XOWt1Wrvn9f4CruaNMXbuWrfK3afQzcMgsNFmExDLeJsfW63sTUt3F0f0Yl8Dg7rB5p+AeYAxNPOqrclVFCnciFn9MnOXCPKJvaYkvhpG5P+WYjYrwIIJ8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099768; c=relaxed/simple;
	bh=3vPVUOyOwX0iUAy7thic1cXxzYkzDDpe9veMkSDQ4Bo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=jeKig+4hiY2Fyn9NAKby1QFJI5QNIs9GJJiD0isZEOk385EzGpeNne47rOMtjIApfN7g0KdfxQTtpWNihKkgUQh7/r7II29ASgTnTf/BXJ4XW5Il/oNAbF0RsLWtcKUbPPL8BXqFsGc2d4rxLNBQMBD4uQVCvm2OWK3MNKXID10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YA03fI/c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GDSfU9K6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YA03fI/c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GDSfU9K6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CF1422092;
	Mon,  5 Feb 2024 02:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707099764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IrBQEPGClIBkAF66TeoAlGTkekVk6/4kbaMcJq4GWeY=;
	b=YA03fI/cgAF5Ud+vKmtqd1XEmVgS08fVk51iIVAfPqAsqaz8mrassQEWTNt1gnj9ztSRjB
	V0M3UfD4X9XlrvsTYR3DMyHW2nqZP66uWGQCEqZx6GMKyw1AQQtNPl5Ghq7Qs+B5tvks3m
	cOUyiW7yhvqM+Cy25f6/bXV0KkIA8A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707099764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IrBQEPGClIBkAF66TeoAlGTkekVk6/4kbaMcJq4GWeY=;
	b=GDSfU9K6wBR4D+RV2Ta0NU92gu+UwxPeHhjHIrVxJioVqakg7O//aOuwN4dc2AKvtc/uzw
	g+k+TQyN/pvOrfAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707099764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IrBQEPGClIBkAF66TeoAlGTkekVk6/4kbaMcJq4GWeY=;
	b=YA03fI/cgAF5Ud+vKmtqd1XEmVgS08fVk51iIVAfPqAsqaz8mrassQEWTNt1gnj9ztSRjB
	V0M3UfD4X9XlrvsTYR3DMyHW2nqZP66uWGQCEqZx6GMKyw1AQQtNPl5Ghq7Qs+B5tvks3m
	cOUyiW7yhvqM+Cy25f6/bXV0KkIA8A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707099764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IrBQEPGClIBkAF66TeoAlGTkekVk6/4kbaMcJq4GWeY=;
	b=GDSfU9K6wBR4D+RV2Ta0NU92gu+UwxPeHhjHIrVxJioVqakg7O//aOuwN4dc2AKvtc/uzw
	g+k+TQyN/pvOrfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64259132DD;
	Mon,  5 Feb 2024 02:22:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j8JlB3JGwGXPRAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 05 Feb 2024 02:22:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Dai Ngo <Dai.Ngo@oracle.com>, Olga Kornievskaia <kolga@netapp.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: don't take fi_lock in nfsd_break_deleg_cb()
Date: Mon, 05 Feb 2024 13:22:39 +1100
Message-id: <170709975922.13976.3341850918979137018@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO


A recent change to check_for_locks() changed it to take ->flc_lock while
holding ->fi_lock.  This creates a lock inversion (reported by lockdep)
because there is a case where ->fi_lock is taken while holding
->flc_lock.

->flc_lock is held across ->fl_lmops callbacks, and
nfsd_break_deleg_cb() is one of those and does take ->fi_lock.  However
it doesn't need to.

Prior to v4.17-rc1~110^2~22 ("nfsd: create a separate lease for each
delegation") nfsd_break_deleg_cb() would walk the ->fi_delegations list
and so needed the lock.  Since then it doesn't walk the list and doesn't
need the lock.

Two actions are performed under the lock.  One is to call
nfsd_break_one_deleg which calls nfsd4_run_cb().  These doesn't act on
the nfs4_file at all, so don't need the lock.

The other is to set ->fi_had_conflict which is in the nfs4_file.
This field is only ever set here (except when initialised to false)
so there is no possible problem will multiple threads racing when
setting it.

The field is tested twice in nfs4_set_delegation().  The first test does
not hold a lock and is documented as an opportunistic optimisation, so
it doesn't impose any need to hold ->fi_lock while setting
->fi_had_conflict.

The second test in nfs4_set_delegation() *is* make under ->fi_lock, so
removing the locking when ->fi_had_conflict is set could make a change.
The change could only be interesting if ->fi_had_conflict tested as
false even though nfsd_break_one_deleg() ran before ->fi_lock was
unlocked.  i.e. while hash_delegation_locked() was running.
As hash_delegation_lock() doesn't interact in any way with nfs4_run_cb()
there can be no importance to this interaction.

So this patch removes the locking from nfsd_break_one_deleg() and moves
the final test on ->fi_had_conflict out of the locked region to make it
clear that locking isn't important to the test.  It is still tested
*after* vfs_setlease() has succeeded.  This might be significant and as
vfs_setlease() takes ->flc_lock, and nfsd_break_one_deleg() is called
under ->flc_lock this "after" is a true ordering provided by a spinlock.

Fixes: edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

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
--=20
2.43.0


