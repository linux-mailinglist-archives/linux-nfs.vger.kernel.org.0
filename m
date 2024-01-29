Return-Path: <linux-nfs+bounces-1527-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B583FCDD
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E419B1F22EDF
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E17611733;
	Mon, 29 Jan 2024 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nxRt8K4x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bYS4lEtx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RDzYBpUJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tSp52rH4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF700111A5
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499485; cv=none; b=uUaUWdf9zld6B6IbdF8YOfgnhV2XYuScK7TwmVthJx2AIo6+5JwIvmPufJyx5BhQcJhCReNoYrlU9469lFnkYJtKHbSjz3PVAmXy7K7ZghRZZGi/28vklrdZQ0NJ+f6xCMcS/Sn+60Nhf8xDUTUs+3ap2FBC9yGyEVBDB/0VM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499485; c=relaxed/simple;
	bh=884cNXnil/o7MkgS0dYtjpCOlVbSknKbSc03uxeImfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maVXlZjczlZaGQnZiQoa8q/nVswr4H6xlT510+3PP65Fgsl93NVF0FnjFruWxVgHK+nCBS5Z8qFvKZtI8w0zIw6G/iDNvEwHbcWuTJh4tLLPEiCp+bSrRUQsdfd2o5s8BuCEmYauISARlRzFfW7MKmMy0BWdxdA0APWzA0sn1ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nxRt8K4x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bYS4lEtx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RDzYBpUJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tSp52rH4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E92392229C;
	Mon, 29 Jan 2024 03:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7CyW9BSSNPjlEkIMAIPy+g7yNalPpjbzjidtLuX62Y=;
	b=nxRt8K4x0HM1X4CoHRJb4khiq3msXFBxYwtGSewckbCJ9m3VkPAUDoaGv7VYJoNX+VldTM
	N+iTyPmAZst5Q+bU2I/N3luyuTtDCVMieQHEy83t4/HOCz49i/LN18J8Wa05m7X0kfZ2aQ
	en4AuWb34Nyw9hrjnQ28GDK7md+srrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7CyW9BSSNPjlEkIMAIPy+g7yNalPpjbzjidtLuX62Y=;
	b=bYS4lEtxXPimuG31ol5DZs8D9ZLNy0YVOTEz0QNm8axuLPK5laOdkdHZu01mRIplUofTM7
	2HIsWbgCMRkiruBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7CyW9BSSNPjlEkIMAIPy+g7yNalPpjbzjidtLuX62Y=;
	b=RDzYBpUJ1dPF/lp0e4goiWm/0r+6U02cy/LkjLe3joIhkfapr2Vy8TuxFgawL0Q7q3XpGk
	fyBJ5g88Lohpno6eO3gpU78KuRT5bKsV3jHaIMOiN55Jr0a1DEp0jnvR3v0ufHYig2d9sG
	dE2K8mjqqaY15IkXZrWfOrspoL4iN9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7CyW9BSSNPjlEkIMAIPy+g7yNalPpjbzjidtLuX62Y=;
	b=tSp52rH4EBriJVR3H1d2yn3ezPCfRbJFPqqxA0EKMxXIwWWPd4N+2kadXHxSneCdzQbj4Z
	gzlpjNRDCvRh/RDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 488FE13867;
	Mon, 29 Jan 2024 03:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BQ+aAJcdt2VSKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:37:59 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 12/13] nfsd: allow delegation state ids to be revoked and then freed
Date: Mon, 29 Jan 2024 14:29:34 +1100
Message-ID: <20240129033637.2133-13-neilb@suse.de>
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
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RDzYBpUJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tSp52rH4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.48 / 50.00];
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
	 BAYES_HAM(-0.01)[51.22%];
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
X-Spam-Score: 3.48
X-Rspamd-Queue-Id: E92392229C
X-Spam-Flag: NO

Revoking state through 'unlock_filesystem' now revokes any delegation
states found.  When the stateids are then freed by the client, the
revoked stateids will be cleaned up correctly.

As there is already support for revoking delegations, we build on that
for admin-revoking.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5dc8f60e18dc..e749d5c0e23a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1335,9 +1335,12 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 	if (!delegation_hashed(dp))
 		return false;
 
-	if (dp->dl_stid.sc_client->cl_minorversion == 0)
+	if (statusmask == SC_STATUS_REVOKED &&
+	    dp->dl_stid.sc_client->cl_minorversion == 0)
 		statusmask = SC_STATUS_CLOSED;
 	dp->dl_stid.sc_status |= statusmask;
+	if (statusmask & SC_STATUS_ADMIN_REVOKED)
+		atomic_inc(&dp->dl_stid.sc_client->cl_admin_revoked);
 
 	/* Ensure that deleg break won't try to requeue it */
 	++dp->dl_time;
@@ -1368,7 +1371,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 
 	trace_nfsd_stid_revoke(&dp->dl_stid);
 
-	if (dp->dl_stid.sc_status & SC_STATUS_REVOKED) {
+	if (dp->dl_stid.sc_status &
+	    (SC_STATUS_REVOKED | SC_STATUS_ADMIN_REVOKED)) {
 		spin_lock(&clp->cl_lock);
 		refcount_inc(&dp->dl_stid.sc_count);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
@@ -1717,7 +1721,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned int sc_types;
 
-	sc_types = SC_TYPE_OPEN | SC_TYPE_LOCK;
+	sc_types = SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1729,6 +1733,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 								  sc_types);
 			if (stid) {
 				struct nfs4_ol_stateid *stp;
+				struct nfs4_delegation *dp;
 
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
@@ -1774,6 +1779,16 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 						spin_unlock(&clp->cl_lock);
 					mutex_unlock(&stp->st_mutex);
 					break;
+				case SC_TYPE_DELEG:
+					dp = delegstateid(stid);
+					spin_lock(&state_lock);
+					if (!unhash_delegation_locked(
+						    dp, SC_STATUS_ADMIN_REVOKED))
+						dp = NULL;
+					spin_unlock(&state_lock);
+					if (dp)
+						revoke_delegation(dp);
+					break;
 				}
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
@@ -4675,6 +4690,7 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
 	struct nfs4_client *cl = s->sc_client;
 	LIST_HEAD(reaplist);
 	struct nfs4_ol_stateid *stp;
+	struct nfs4_delegation *dp;
 	bool unhashed;
 
 	switch (s->sc_type) {
@@ -4692,6 +4708,12 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
 		if (unhashed)
 			nfs4_put_stid(s);
 		break;
+	case SC_TYPE_DELEG:
+		dp = delegstateid(s);
+		list_del_init(&dp->dl_recall_lru);
+		spin_unlock(&cl->cl_lock);
+		nfs4_put_stid(s);
+		break;
 	default:
 		spin_unlock(&cl->cl_lock);
 	}
-- 
2.43.0


