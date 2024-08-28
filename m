Return-Path: <linux-nfs+bounces-5895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C6896352C
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 01:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9261C21320
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 23:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380CC1AC45F;
	Wed, 28 Aug 2024 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YzmMHZAZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K8hONYFH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YzmMHZAZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K8hONYFH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79656158DCD
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886398; cv=none; b=Tg0xhLfx/9SXBaKdnxdOogixI9vYv1xjPp9wGhFBxgdwOspeCOHAoonopFmYc4S4ZFMt8sD8bL3PIbwZcpTlm4lh52dR823j4XJVeqKL3ZYeBK3bY0JpKswmQGYya2g2JDmrmXqGBNk/RlyMWPh1o6wftw0/KEGFIfsYCDYQUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886398; c=relaxed/simple;
	bh=xM3gXQnLFAlr0l/Aw1U4Bisez0AM6cSB20fAGYPDn0o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=quwXmBl0yJnHUvn/7yD+f8C9IYWoUeqcQTz5C7PQEIcueEgo9xmZoh2/ntzIYdnJWyfzRtNeNLsRoMCFhlHD7bwp/7qq+KWbqazt6O0gJad82qGiCEYHHWOy1g+YvFirSZKcTsvln2eFkGLjZwcvFZFolGzXCs9ZygYHCWHD7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YzmMHZAZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K8hONYFH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YzmMHZAZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K8hONYFH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96D181FCE7;
	Wed, 28 Aug 2024 23:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724886394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dTYcB/owmi2yQXYEj3eH4cZFRJZRUhLWVxsyue1hRjc=;
	b=YzmMHZAZKuoJDvS6LySeC+aVGzm86I0vd7SnHaMBUqZMa6x9OiyDYw2tdLA37wC4XtalEd
	wuX6a2q2oLr41SCSAYE+WoCZIVZIMBAdPiNzt3thD7brgAiXx0hMzDAf4cNt1NBeYDnzln
	uxNGWGF2Hxk8dhgZbd2diRvUmHgwYHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724886394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dTYcB/owmi2yQXYEj3eH4cZFRJZRUhLWVxsyue1hRjc=;
	b=K8hONYFHbI8BFUdWng10CJvCL+P9VZAVIAaij5NF69bb5r53FmQV4JNWZseFhfMAeJrmYP
	h/lT7FjHviaY+FCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YzmMHZAZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K8hONYFH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724886394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dTYcB/owmi2yQXYEj3eH4cZFRJZRUhLWVxsyue1hRjc=;
	b=YzmMHZAZKuoJDvS6LySeC+aVGzm86I0vd7SnHaMBUqZMa6x9OiyDYw2tdLA37wC4XtalEd
	wuX6a2q2oLr41SCSAYE+WoCZIVZIMBAdPiNzt3thD7brgAiXx0hMzDAf4cNt1NBeYDnzln
	uxNGWGF2Hxk8dhgZbd2diRvUmHgwYHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724886394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dTYcB/owmi2yQXYEj3eH4cZFRJZRUhLWVxsyue1hRjc=;
	b=K8hONYFHbI8BFUdWng10CJvCL+P9VZAVIAaij5NF69bb5r53FmQV4JNWZseFhfMAeJrmYP
	h/lT7FjHviaY+FCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 110261398F;
	Wed, 28 Aug 2024 23:06:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u+AhLnitz2Z9TwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 28 Aug 2024 23:06:32 +0000
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
 Dai Ngo <Dai.Ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH nfsd-fixes] nfsd: fix nfsd4_deleg_getattr_conflict in presence
 of third party lease
Date: Thu, 29 Aug 2024 09:06:28 +1000
Message-id: <172488638886.4433.12153470259536099118@noble.neil.brown.name>
X-Rspamd-Queue-Id: 96D181FCE7
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO


It is not safe to dereference fl->c.flc_owner without first confirming
fl->fl_lmops is the expected manager.  nfsd4_deleg_getattr_conflict()
tests fl_lmops but largely ignores the result and assumes that flc_owner
is an nfs4_delegation anyway.  This is wrong.

With this patch we restore the "!=3D &nfsd_lease_mng_ops" case to behave
as it did before the changed mentioned below.  This the same as the
current code, but without any reference to a possible delegation.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 07f2496850c4..f6a67ef27435 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8859,7 +8859,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, s=
truct dentry *dentry,
 			 */
 			if (type =3D=3D F_RDLCK)
 				break;
-			goto break_lease;
+
+			nfsd_stats_wdeleg_getattr_inc(nn);
+			spin_unlock(&ctx->flc_lock);
+
+			status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+			if (status !=3D nfserr_jukebox ||
+			    !nfsd_wait_for_delegreturn(rqstp, inode))
+					return status;
+			return 0;
 		}
 		if (type =3D=3D F_WRLCK) {
 			struct nfs4_delegation *dp =3D fl->c.flc_owner;
@@ -8868,7 +8876,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, st=
ruct dentry *dentry,
 				spin_unlock(&ctx->flc_lock);
 				return 0;
 			}
-break_lease:
 			nfsd_stats_wdeleg_getattr_inc(nn);
 			dp =3D fl->c.flc_owner;
 			refcount_inc(&dp->dl_stid.sc_count);
--=20
2.44.0


