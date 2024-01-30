Return-Path: <linux-nfs+bounces-1589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6D84182A
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 02:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA41284D35
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 01:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0A833CE9;
	Tue, 30 Jan 2024 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tZLbRGK8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BoMEYY8b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tZLbRGK8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BoMEYY8b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114B2E646
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577118; cv=none; b=YDKdt8UqgN2TkiRWhvk+im3d6Ou608Toe+ZwLp0TCnoy1tmvKCW6l8D77v6SUw3ALt6Z1U1o/IkzwPz1ubUGDdQx+PiM1z1AWb7wZA+Sfip6ILJUDyTAn1Jg+zojCwS3ENWPfwas5/bDGC813IRo3CNl8FIUEbvWZPVClYmAScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577118; c=relaxed/simple;
	bh=vrsElD97/vrWQgmn7fOVV7mLKgDJsN+V3X63iRQ+1go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPz6Ypsd2x0zPnJt3H1RNOwxi7WPL2vgDlIKMw0sQooGvAyaYNF/s1ZQmvDIpDdXDl8ywgeaATr1XOkcVOiWcygMaZLWEdXawwmWBjsebER5e54LvkGmEBc/4GmA5rB5pfk38y39+8oqvOD9hNBLsIUBNBw5x41O3hCVNhnYS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tZLbRGK8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BoMEYY8b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tZLbRGK8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BoMEYY8b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 207FA1F7ED;
	Tue, 30 Jan 2024 01:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgkmM9AXEOlhhk0eetOLopyxqRC3bGecX92mCg1Hqrc=;
	b=tZLbRGK8pNqYi3pk8INHN/PC9npu8D/vBDUgvso4uXvHVGTdlLaaFpHDEyUs1pSzBXiDF8
	KWhSHqLyz/iN+uGR7UrTIhrjAI5rU+mwcEwj7YFopFcZ2QYAIKe6R8joQT760dlWTugOMU
	jtzkPzRZ+K8SvWCGPjthQQVHW9WjEaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgkmM9AXEOlhhk0eetOLopyxqRC3bGecX92mCg1Hqrc=;
	b=BoMEYY8bmBzsX7I5rR1YQQhHMPbSXaz6QPfpTs3SVoE/7Lb8JjlBIST305ITflDci6io6T
	rtMpBMuf1ILn5IAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgkmM9AXEOlhhk0eetOLopyxqRC3bGecX92mCg1Hqrc=;
	b=tZLbRGK8pNqYi3pk8INHN/PC9npu8D/vBDUgvso4uXvHVGTdlLaaFpHDEyUs1pSzBXiDF8
	KWhSHqLyz/iN+uGR7UrTIhrjAI5rU+mwcEwj7YFopFcZ2QYAIKe6R8joQT760dlWTugOMU
	jtzkPzRZ+K8SvWCGPjthQQVHW9WjEaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgkmM9AXEOlhhk0eetOLopyxqRC3bGecX92mCg1Hqrc=;
	b=BoMEYY8bmBzsX7I5rR1YQQhHMPbSXaz6QPfpTs3SVoE/7Lb8JjlBIST305ITflDci6io6T
	rtMpBMuf1ILn5IAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74B6E12FF7;
	Tue, 30 Jan 2024 01:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RG8+C9ZMuGXBQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jan 2024 01:11:50 +0000
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
Date: Tue, 30 Jan 2024 12:08:27 +1100
Message-ID: <20240130011102.8623-8-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130011102.8623-1-neilb@suse.de>
References: <20240130011102.8623-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tZLbRGK8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BoMEYY8b
X-Spamd-Result: default: False [0.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.69
X-Rspamd-Queue-Id: 207FA1F7ED
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

Change the "show" functions to show some content even if a file cannot
be found.  This is the case for admin-revoked state.
This is primarily useful for debugging - to ensure states are being
removed eventually.

So change several seq_printf() to seq_puts().  Some of these are needed
to keep checkpatch happy.  Others were done for consistency.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 118 ++++++++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 60 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a19575571c05..a05b6ab81ecf 100644
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


