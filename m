Return-Path: <linux-nfs+bounces-51-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381ED7F6B46
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 05:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8D3B20F2D
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 04:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38546A8;
	Fri, 24 Nov 2023 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gBGSt5PO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CCVog4k6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D88D6F
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 20:20:24 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80F63338AD;
	Fri, 24 Nov 2023 00:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700785898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBSMnYSr0eqfko0i5Ej3oZMZHSXC7IdlKH2BFhfaHrE=;
	b=gBGSt5POvMyYL8sn9BUnF+dge+ut9Ht7KkXbujh7a+6qAfRT7bMNoBQjrgt32KcBx7CIbu
	tat2MNvJfHaKJzyIu9TSUZOuY1fXj9AlqO9foTii0aFOh8M9FXPvYnocj4nJ40CWiM23uP
	Z+7oZ/dA/KoX/2Ti97MK0oNywInFqro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700785898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBSMnYSr0eqfko0i5Ej3oZMZHSXC7IdlKH2BFhfaHrE=;
	b=CCVog4k63X8Ne2ex7wP8fGYoTMFdbwJojJOKx+aXLLp00ZAloh28hMaSmaPQadFylzvaLX
	6bJ5VHSjWJPBMEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D4D61340B;
	Fri, 24 Nov 2023 00:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EBepBOjuX2W5egAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 24 Nov 2023 00:31:36 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 06/11] nfsd: allow admin-revoked state to appear in /proc/fs/nfsd/clients/*/states
Date: Fri, 24 Nov 2023 11:28:41 +1100
Message-ID: <20231124002925.1816-7-neilb@suse.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124002925.1816-1-neilb@suse.de>
References: <20231124002925.1816-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 1.70
X-Spamd-Result: default: False [1.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.986];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

Change the "show" functions to show some content even if a file cannot
be found.
This is primarily useful for debugging - to ensure states are being
removed eventually.

Also remove a "Kinda dead" comment which is no longer correct as we
now support write delegations.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 82 ++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 477a9e9aebbd..52e680235afe 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2680,17 +2680,10 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	struct nfs4_stateowner *oo;
 	unsigned int access, deny;
 
-	if (st->sc_type != NFS4_OPEN_STID && st->sc_type != NFS4_LOCK_STID)
-		return 0; /* XXX: or SEQ_SKIP? */
 	ols = openlockstateid(st);
 	oo = ols->st_stateowner;
 	nf = st->sc_file;
 
-	spin_lock(&nf->fi_lock);
-	file = find_any_file_locked(nf);
-	if (!file)
-		goto out;
-
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
 	seq_printf(s, ": { type: open, ");
@@ -2705,14 +2698,19 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 		deny & NFS4_SHARE_ACCESS_READ ? "r" : "-",
 		deny & NFS4_SHARE_ACCESS_WRITE ? "w" : "-");
 
-	nfs4_show_superblock(s, file);
-	seq_printf(s, ", ");
-	nfs4_show_fname(s, file);
-	seq_printf(s, ", ");
+	spin_lock(&nf->fi_lock);
+	file = find_any_file_locked(nf);
+	if (file) {
+		nfs4_show_superblock(s, file);
+		seq_puts(s, ", ");
+		nfs4_show_fname(s, file);
+		seq_puts(s, ", ");
+	}
+	spin_unlock(&nf->fi_lock);
 	nfs4_show_owner(s, oo);
+	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
+		seq_puts(s, ", admin-revoked");
 	seq_printf(s, " }\n");
-out:
-	spin_unlock(&nf->fi_lock);
 	return 0;
 }
 
@@ -2726,30 +2724,31 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	ols = openlockstateid(st);
 	oo = ols->st_stateowner;
 	nf = st->sc_file;
-	spin_lock(&nf->fi_lock);
-	file = find_any_file_locked(nf);
-	if (!file)
-		goto out;
 
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
 	seq_printf(s, ": { type: lock, ");
 
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
+	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
+		seq_puts(s, ", admin-revoked");
 	seq_printf(s, " }\n");
-out:
 	spin_unlock(&nf->fi_lock);
 	return 0;
 }
@@ -2762,27 +2761,28 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 
 	ds = delegstateid(st);
 	nf = st->sc_file;
-	spin_lock(&nf->fi_lock);
-	file = nf->fi_deleg_file;
-	if (!file)
-		goto out;
 
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
 	seq_printf(s, ": { type: deleg, ");
 
-	/* Kinda dead code as long as we only support read delegs: */
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
 	spin_unlock(&nf->fi_lock);
+	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
+		seq_puts(s, ", admin-revoked");
+	seq_puts(s, " }\n");
 	return 0;
 }
 
-- 
2.42.1


