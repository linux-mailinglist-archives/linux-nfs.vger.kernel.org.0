Return-Path: <linux-nfs+bounces-10359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E7A45583
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 07:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3D63A5218
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 06:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173601925A6;
	Wed, 26 Feb 2025 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b80PF8mw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hXtvbTyQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b80PF8mw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hXtvbTyQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713A16DEB1
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550921; cv=none; b=GE6JrITZGTojHvsg1b1BskWIPc/9QeZv2fUdFAhHevJMlUWwWSGM7flTBl5BvnVFoQcJk52uZPmKpqjakoAChhkc9MWA41K6ziGtk3VwmAou0WxoruzKBCX+JNQWT2Caix+eCgvKAk+bE9d1/FhjnR5qFmA2f4IMQlI8SC99wqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550921; c=relaxed/simple;
	bh=BwaHH0WtuFpsmi9pYsYxJgbUYv4LLaSS4+e6w9V1vtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0/jAiYgpYS89UulwTf685aDWWi19OafZyKKUxwx1mxkK7jvIlRHm9Z0nIZZeSjzToqEwze0qPKlXHmH8F4Z9AEU5ISHKpsB99bT5SYq1+9iYF1Psispv5QIaNRbWjiuYcJnE7w//cQMB12iDoM2eeY06SVnTUB+PlZA/6joSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b80PF8mw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hXtvbTyQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b80PF8mw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hXtvbTyQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 70C4421189;
	Wed, 26 Feb 2025 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740550917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhRWC+C/VQZvCd1R8opT/N3JPOj2rnQn+BmQXg9NfKw=;
	b=b80PF8mwoNx4nSzmJsRo1/dBSyT01x9QUUdy0LWW1/HIfho80ixbGRxxh4m8JX8RCQzS1c
	9oieearDbUABFVQ+QYLY+8Pu3OPg5A7V8vvTYukBxAg00lkpJ+NkpGPdp5pBBWKIDVJ3Lb
	/MRCD7QvlnSimw0Nt7Bz0l0UsZx3U+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740550917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhRWC+C/VQZvCd1R8opT/N3JPOj2rnQn+BmQXg9NfKw=;
	b=hXtvbTyQfq4cWnzS/2EPVd/D/H9NJZlB2wsk/aXKT4STohOzYZx7u/CRp3XAFsbx4NqRTX
	hmvxW1QHnuzRbeAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b80PF8mw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hXtvbTyQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740550917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhRWC+C/VQZvCd1R8opT/N3JPOj2rnQn+BmQXg9NfKw=;
	b=b80PF8mwoNx4nSzmJsRo1/dBSyT01x9QUUdy0LWW1/HIfho80ixbGRxxh4m8JX8RCQzS1c
	9oieearDbUABFVQ+QYLY+8Pu3OPg5A7V8vvTYukBxAg00lkpJ+NkpGPdp5pBBWKIDVJ3Lb
	/MRCD7QvlnSimw0Nt7Bz0l0UsZx3U+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740550917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhRWC+C/VQZvCd1R8opT/N3JPOj2rnQn+BmQXg9NfKw=;
	b=hXtvbTyQfq4cWnzS/2EPVd/D/H9NJZlB2wsk/aXKT4STohOzYZx7u/CRp3XAFsbx4NqRTX
	hmvxW1QHnuzRbeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA6701377F;
	Wed, 26 Feb 2025 06:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZVUsIwKzvmcuIAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 26 Feb 2025 06:21:54 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfs/vfs: discard d_exact_alias()
Date: Wed, 26 Feb 2025 17:18:31 +1100
Message-ID: <20250226062135.2043651-2-neilb@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226062135.2043651-1-neilb@suse.de>
References: <20250226062135.2043651-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 70C4421189
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

d_exact_alias() is a descendent of d_add_unique() which was introduced
20 years ago mostly likely to work around problems with NFS servers of
the time.  It is now not used in several situations were it was
originally needed and there have been no reports of problems -
presumably the old NFS servers have been improved.  This only place it
is now use is in NFSv4 code and the old problematic servers are thought
to have been v2/v3 only.

There is no clear benefit in reusing a unhashed() dentry which happens
to have the same name as the dentry we are adding.

So this patch removes d_exact_alias() and the one place that it is used.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/dcache.c            | 46 ------------------------------------------
 fs/nfs/nfs4proc.c      |  4 +---
 include/linux/dcache.h |  1 -
 3 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e3634916ffb9..726a5be2747b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2687,52 +2687,6 @@ void d_add(struct dentry *entry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_add);
 
-/**
- * d_exact_alias - find and hash an exact unhashed alias
- * @entry: dentry to add
- * @inode: The inode to go with this dentry
- *
- * If an unhashed dentry with the same name/parent and desired
- * inode already exists, hash and return it.  Otherwise, return
- * NULL.
- *
- * Parent directory should be locked.
- */
-struct dentry *d_exact_alias(struct dentry *entry, struct inode *inode)
-{
-	struct dentry *alias;
-	unsigned int hash = entry->d_name.hash;
-
-	spin_lock(&inode->i_lock);
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
-		/*
-		 * Don't need alias->d_lock here, because aliases with
-		 * d_parent == entry->d_parent are not subject to name or
-		 * parent changes, because the parent inode i_mutex is held.
-		 */
-		if (alias->d_name.hash != hash)
-			continue;
-		if (alias->d_parent != entry->d_parent)
-			continue;
-		if (!d_same_name(alias, entry->d_parent, &entry->d_name))
-			continue;
-		spin_lock(&alias->d_lock);
-		if (!d_unhashed(alias)) {
-			spin_unlock(&alias->d_lock);
-			alias = NULL;
-		} else {
-			dget_dlock(alias);
-			__d_rehash(alias);
-			spin_unlock(&alias->d_lock);
-		}
-		spin_unlock(&inode->i_lock);
-		return alias;
-	}
-	spin_unlock(&inode->i_lock);
-	return NULL;
-}
-EXPORT_SYMBOL(d_exact_alias);
-
 static void swap_names(struct dentry *dentry, struct dentry *target)
 {
 	if (unlikely(dname_external(target))) {
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index df9669d4ded7..0a46b193f18e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3153,9 +3153,7 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	if (d_really_is_negative(dentry)) {
 		struct dentry *alias;
 		d_drop(dentry);
-		alias = d_exact_alias(dentry, state->inode);
-		if (!alias)
-			alias = d_splice_alias(igrab(state->inode), dentry);
+		alias = d_splice_alias(igrab(state->inode), dentry);
 		/* d_splice_alias() can't fail here - it's a non-directory */
 		if (alias) {
 			dput(ctx->dentry);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4afb60365675..8a63978187a4 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -253,7 +253,6 @@ extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
 extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
 			const struct qstr *name);
-extern struct dentry * d_exact_alias(struct dentry *, struct inode *);
 extern struct dentry *d_find_any_alias(struct inode *inode);
 extern struct dentry * d_obtain_alias(struct inode *);
 extern struct dentry * d_obtain_root(struct inode *);
-- 
2.48.1


