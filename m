Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAA57D8CE9
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 03:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjJ0B4m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 21:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbjJ0B4l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 21:56:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87AEAB
        for <linux-nfs@vger.kernel.org>; Thu, 26 Oct 2023 18:56:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 702BE21C08;
        Fri, 27 Oct 2023 01:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698371797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZoEVGAM/kH9XPvUMzNhmj0SyiXtYsN9ufv+LSfLrSS0=;
        b=dN24NfsQjLUSxjOzUuwVMZY2wlULQm32j5OfYg3vgDzkEnyfzPqyy659L1sgkyJmyJ5gNx
        867Ic58IPo1LuIJrrA+Xm2E36mroqcy74SSuEiLECFkwvpoQv+ASG/wvDHh+Fa1inZoFRe
        Yv9qQbjeDECuE+GIxb05FeUnmxPGtzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698371797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZoEVGAM/kH9XPvUMzNhmj0SyiXtYsN9ufv+LSfLrSS0=;
        b=hSNwGx7hcPRkvd4gvsg9rzbGizEcY8w3QyF71CrHOPSgK+nK9dvlm3NyvCb53GHAunWlEn
        uAdWbnWB7BL01mCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE5B2133F5;
        Fri, 27 Oct 2023 01:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i2EFKdIYO2X+CQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Oct 2023 01:56:34 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/6] nfsd: allow admin-revoked state to appear in /proc/fs/nfsd/clients/*/states
Date:   Fri, 27 Oct 2023 12:45:30 +1100
Message-ID: <20231027015613.26247-3-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027015613.26247-1-neilb@suse.de>
References: <20231027015613.26247-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Change the "show" functions to show some content even if a file cannot
be found, and call them for the ADMIN_REVOKED versions of state id.
This use primarily useful for debugging - to ensure states are being
removed eventually.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 78 ++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f3ba53a16105..e15d35c57991 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2679,17 +2679,10 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
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
@@ -2704,14 +2697,17 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
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
 	seq_printf(s, " }\n");
-out:
-	spin_unlock(&nf->fi_lock);
 	return 0;
 }
 
@@ -2725,30 +2721,29 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
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
 	seq_printf(s, " }\n");
-out:
 	spin_unlock(&nf->fi_lock);
 	return 0;
 }
@@ -2761,27 +2756,27 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 
 	ds = delegstateid(st);
 	nf = st->sc_file;
-	spin_lock(&nf->fi_lock);
-	file = nf->fi_deleg_file;
-	if (!file)
-		goto out;
 
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
 	seq_printf(s, ": { type: deleg, ");
 
 	/* Kinda dead code as long as we only support read delegs: */
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
+	seq_puts(s, " }\n");
 	return 0;
 }
 
@@ -2813,10 +2808,13 @@ static int states_show(struct seq_file *s, void *v)
 
 	switch (st->sc_type) {
 	case NFS4_OPEN_STID:
+	case NFS4_ADMIN_REVOKED_STID:
 		return nfs4_show_open(s, st);
 	case NFS4_LOCK_STID:
+	case NFS4_ADMIN_REVOKED_LOCK_STID:
 		return nfs4_show_lock(s, st);
 	case NFS4_DELEG_STID:
+	case NFS4_ADMIN_REVOKED_DELEG_STID:
 		return nfs4_show_deleg(s, st);
 	case NFS4_LAYOUT_STID:
 		return nfs4_show_layout(s, st);
-- 
2.42.0

