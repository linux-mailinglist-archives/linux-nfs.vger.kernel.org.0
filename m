Return-Path: <linux-nfs+bounces-1522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6B383FCD8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67865B22C79
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40FA10940;
	Mon, 29 Jan 2024 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l4i3sb2Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+RAEHPZ5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l4i3sb2Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+RAEHPZ5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330410949
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499455; cv=none; b=OGVOdkA5lxLn/B0tNcqelKqpvvXS8jDmprFHvjzgkJ3ltknFMBbupcTwWXNlSkbtHbkJ8yn/pMYTfvVfVxn3sIx/ZrhrkzOh6bh/Onb7MHtE5OxeE5NORRPdHZkxd2Qr/4DmxsX+z83ADSOf9/oaMKDDXSGucgVoXEfgWUaVoEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499455; c=relaxed/simple;
	bh=38Rd237eyAKnEYSI4CA970ErootnxVhndbpP/jHfH/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGECYsxkYle8RYoCZRXiUYbyG5a+1FByMe9s/cno/919Z6aer1iMgSCiJK9BF9O/JfwdE9pH7H65bmtFBQiuZG471S09cAbASgUH3tqdOr3+7hd8cQzGHbPa/UVrLSaQJRuRu3V3uxNNgNDKbGdbwSa4e2B+EqIbGNHIARUydOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l4i3sb2Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+RAEHPZ5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l4i3sb2Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+RAEHPZ5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 673611F7C4;
	Mon, 29 Jan 2024 03:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4AOGebEjlbVsxHEeWNZKWr+kfcn6aDtC+d+KXy1/pU=;
	b=l4i3sb2QMRosZPgU5CdopOSiD7jC972xmTqEjmcaTudn8ALRuXyNoGP4DisyoRUOCwnd65
	Lcxg4poYb9O1RmDn1BuMVp+IwaUqueIWqVoTl5HWmkkhzhXRcdxK2XWlMrPEOBztjaDLv/
	FWgz7COyFttwhYGGYB1ZrtWmxICi3ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4AOGebEjlbVsxHEeWNZKWr+kfcn6aDtC+d+KXy1/pU=;
	b=+RAEHPZ5yidjxFOy6So91v70KanuZoPp1EE79ovbTPEjPKFLE1Zv5dx1FY/Dqzhe6RtUzE
	D/d4ay340lIEDODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4AOGebEjlbVsxHEeWNZKWr+kfcn6aDtC+d+KXy1/pU=;
	b=l4i3sb2QMRosZPgU5CdopOSiD7jC972xmTqEjmcaTudn8ALRuXyNoGP4DisyoRUOCwnd65
	Lcxg4poYb9O1RmDn1BuMVp+IwaUqueIWqVoTl5HWmkkhzhXRcdxK2XWlMrPEOBztjaDLv/
	FWgz7COyFttwhYGGYB1ZrtWmxICi3ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4AOGebEjlbVsxHEeWNZKWr+kfcn6aDtC+d+KXy1/pU=;
	b=+RAEHPZ5yidjxFOy6So91v70KanuZoPp1EE79ovbTPEjPKFLE1Zv5dx1FY/Dqzhe6RtUzE
	D/d4ay340lIEDODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C456913867;
	Mon, 29 Jan 2024 03:37:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S5LSHnkdt2UzKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:37:29 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 07/13] nfsd: allow state with no file to appear in /proc/fs/nfsd/clients/*/states
Date: Mon, 29 Jan 2024 14:29:29 +1100
Message-ID: <20240129033637.2133-8-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129033637.2133-1-neilb@suse.de>
References: <20240129033637.2133-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l4i3sb2Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+RAEHPZ5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 673611F7C4
X-Spam-Flag: NO

Change the "show" functions to show some content even if a file cannot
be found.  This is the case for admin-revoked state.
This is primarily useful for debugging - to ensure states are being
removed eventually.

So change several seq_printf() to seq_puts().  Some of these are needed
to keep checkpatch happy.  Others were done for consistency.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 118 ++++++++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 60 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8db224906864..ef4ec23f7c0d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2554,9 +2554,9 @@ static struct nfs4_client *get_nfsdfs_clp(struct inode *inode)
 
 static void seq_quote_mem(struct seq_file *m, char *data, int len)
 {
-	seq_printf(m, "\"");
+	seq_puts(m, "\"");
 	seq_escape_mem(m, data, len, ESCAPE_HEX | ESCAPE_NAP | ESCAPE_APPEND, "\"\\");
-	seq_printf(m, "\"");
+	seq_puts(m, "\"");
 }
 
 static const char *cb_state2str(int state)
@@ -2597,14 +2597,14 @@ static int client_info_show(struct seq_file *m, void *v)
 		seq_puts(m, "status: unconfirmed\n");
 	seq_printf(m, "seconds from last renew: %lld\n",
 		ktime_get_boottime_seconds() - clp->cl_time);
-	seq_printf(m, "name: ");
+	seq_puts(m, "name: ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
 	if (clp->cl_nii_domain.data) {
-		seq_printf(m, "Implementation domain: ");
+		seq_puts(m, "Implementation domain: ");
 		seq_quote_mem(m, clp->cl_nii_domain.data,
 					clp->cl_nii_domain.len);
-		seq_printf(m, "\nImplementation name: ");
+		seq_puts(m, "\nImplementation name: ");
 		seq_quote_mem(m, clp->cl_nii_name.data, clp->cl_nii_name.len);
 		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
@@ -2671,7 +2671,7 @@ static void nfs4_show_superblock(struct seq_file *s, struct nfsd_file *f)
 
 static void nfs4_show_owner(struct seq_file *s, struct nfs4_stateowner *oo)
 {
-	seq_printf(s, "owner: ");
+	seq_puts(s, "owner: ");
 	seq_quote_mem(s, oo->so_owner.data, oo->so_owner.len);
 }
 
@@ -2689,20 +2689,13 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	struct nfs4_stateowner *oo;
 	unsigned int access, deny;
 
-	if (st->sc_type != SC_TYPE_OPEN && st->sc_type != SC_TYPE_LOCK)
-		return 0; /* XXX: or SEQ_SKIP? */
 	ols = openlockstateid(st);
 	oo = ols->st_stateowner;
 	nf = st->sc_file;
 
-	spin_lock(&nf->fi_lock);
-	file = find_any_file_locked(nf);
-	if (!file)
-		goto out;
-
-	seq_printf(s, "- ");
+	seq_puts(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
-	seq_printf(s, ": { type: open, ");
+	seq_puts(s, ": { type: open, ");
 
 	access = bmap_to_share_mode(ols->st_access_bmap);
 	deny   = bmap_to_share_mode(ols->st_deny_bmap);
@@ -2714,14 +2707,17 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 		deny & NFS4_SHARE_ACCESS_READ ? "r" : "-",
 		deny & NFS4_SHARE_ACCESS_WRITE ? "w" : "-");
 
-	nfs4_show_superblock(s, file);
-	seq_printf(s, ", ");
-	nfs4_show_fname(s, file);
-	seq_printf(s, ", ");
-	nfs4_show_owner(s, oo);
-	seq_printf(s, " }\n");
-out:
+	spin_lock(&nf->fi_lock);
+	file = find_any_file_locked(nf);
+	if (file) {
+		nfs4_show_superblock(s, file);
+		seq_puts(s, ", ");
+		nfs4_show_fname(s, file);
+		seq_puts(s, ", ");
+	}
 	spin_unlock(&nf->fi_lock);
+	nfs4_show_owner(s, oo);
+	seq_puts(s, " }\n");
 	return 0;
 }
 
@@ -2735,30 +2731,29 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	ols = openlockstateid(st);
 	oo = ols->st_stateowner;
 	nf = st->sc_file;
-	spin_lock(&nf->fi_lock);
-	file = find_any_file_locked(nf);
-	if (!file)
-		goto out;
 
-	seq_printf(s, "- ");
+	seq_puts(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
-	seq_printf(s, ": { type: lock, ");
+	seq_puts(s, ": { type: lock, ");
 
-	/*
-	 * Note: a lock stateid isn't really the same thing as a lock,
-	 * it's the locking state held by one owner on a file, and there
-	 * may be multiple (or no) lock ranges associated with it.
-	 * (Same for the matter is true of open stateids.)
-	 */
+	spin_lock(&nf->fi_lock);
+	file = find_any_file_locked(nf);
+	if (file) {
+		/*
+		 * Note: a lock stateid isn't really the same thing as a lock,
+		 * it's the locking state held by one owner on a file, and there
+		 * may be multiple (or no) lock ranges associated with it.
+		 * (Same for the matter is true of open stateids.)
+		 */
 
-	nfs4_show_superblock(s, file);
-	/* XXX: open stateid? */
-	seq_printf(s, ", ");
-	nfs4_show_fname(s, file);
-	seq_printf(s, ", ");
+		nfs4_show_superblock(s, file);
+		/* XXX: open stateid? */
+		seq_puts(s, ", ");
+		nfs4_show_fname(s, file);
+		seq_puts(s, ", ");
+	}
 	nfs4_show_owner(s, oo);
-	seq_printf(s, " }\n");
-out:
+	seq_puts(s, " }\n");
 	spin_unlock(&nf->fi_lock);
 	return 0;
 }
@@ -2771,25 +2766,25 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 
 	ds = delegstateid(st);
 	nf = st->sc_file;
-	spin_lock(&nf->fi_lock);
-	file = nf->fi_deleg_file;
-	if (!file)
-		goto out;
 
-	seq_printf(s, "- ");
+	seq_puts(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
-	seq_printf(s, ": { type: deleg, ");
+	seq_puts(s, ": { type: deleg, ");
 
-	seq_printf(s, "access: %s, ",
-		ds->dl_type == NFS4_OPEN_DELEGATE_READ ? "r" : "w");
+	seq_printf(s, "access: %s",
+		   ds->dl_type == NFS4_OPEN_DELEGATE_READ ? "r" : "w");
 
 	/* XXX: lease time, whether it's being recalled. */
 
-	nfs4_show_superblock(s, file);
-	seq_printf(s, ", ");
-	nfs4_show_fname(s, file);
-	seq_printf(s, " }\n");
-out:
+	spin_lock(&nf->fi_lock);
+	file = nf->fi_deleg_file;
+	if (file) {
+		seq_puts(s, ", ");
+		nfs4_show_superblock(s, file);
+		seq_puts(s, ", ");
+		nfs4_show_fname(s, file);
+	}
+	seq_puts(s, " }\n");
 	spin_unlock(&nf->fi_lock);
 	return 0;
 }
@@ -2802,16 +2797,19 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
 	ls = container_of(st, struct nfs4_layout_stateid, ls_stid);
 	file = ls->ls_file;
 
-	seq_printf(s, "- ");
+	seq_puts(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
-	seq_printf(s, ": { type: layout, ");
+	seq_puts(s, ": { type: layout");
 
 	/* XXX: What else would be useful? */
 
-	nfs4_show_superblock(s, file);
-	seq_printf(s, ", ");
-	nfs4_show_fname(s, file);
-	seq_printf(s, " }\n");
+	if (file) {
+		seq_puts(s, ", ");
+		nfs4_show_superblock(s, file);
+		seq_puts(s, ", ");
+		nfs4_show_fname(s, file);
+	}
+	seq_puts(s, " }\n");
 
 	return 0;
 }
-- 
2.43.0


