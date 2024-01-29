Return-Path: <linux-nfs+bounces-1519-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AEC83FCD5
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA881C21CC2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9512B75;
	Mon, 29 Jan 2024 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ukBMkgxZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kiuHBico";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1J+tHcqL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X/z3QuC7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC712B86
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499437; cv=none; b=n/Y/a/67pVpI9nYqM8clw0qjka61m/pPwvoFSA0TxA02HWfR56F+79BON8Qtt9Dju49gMQ3FQ6eRFiMEBQzhzG//fDp5FDfJ9T/zWOKmJM2SdNqKqYquu6XJLOdrEO9Vpg6Iy+AixLjMlMLRRtDalCi/7uRNM5Vnm9uB7HWJ6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499437; c=relaxed/simple;
	bh=oerZw7ndA4nu6DOMJbFUZscWNiVuF59+BgSKYMC+ryw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJMM1n3+4y8zvqdDPRm3k0Xlb5olVKBHCZbzwfa6jLWHAXmWY7PnFrEW8/JDVX9ZIybtaSm+Uijbs/YOjkiP8U/Akrs1ptW4LOU8ikXiaaISEeKJ48KWE0nS1Z6RoufRwGtBqWzOhhG/KSX4qGx/UMeC4c+MQYSJTZYcqzDUDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ukBMkgxZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kiuHBico; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1J+tHcqL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X/z3QuC7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E192A2229D;
	Mon, 29 Jan 2024 03:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3vObMH8r167VRprrezbv2fatEayplnrFIq2d12qAzI=;
	b=ukBMkgxZhgxjOte9u5Ecie3R/VuiXxBdrYRMUSpfZlDUpv5ulGTFQhwHMuCihGyszkc1ua
	pxf1pDO98Mc++Jbn6e9RuqSh37NHfuFzSQt0Xs3Um5Mrlup3gnoFM1uELn+faI2aC4H7i+
	fdtbiFTXMEEpPITZVq1sFZ08N9TSphM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3vObMH8r167VRprrezbv2fatEayplnrFIq2d12qAzI=;
	b=kiuHBicoMsOWK/zoKYTl2BdEqJ5uZ26eAWzwejYZG6sqgf32yBUFOi0M1f5XEEJpCUxJmb
	S/BRey3dRs08tGAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3vObMH8r167VRprrezbv2fatEayplnrFIq2d12qAzI=;
	b=1J+tHcqLtrfJVwbUEUoxefASnVBMHC3epmz+H7PqSty65W79avvod/FyYbP2MhJ63Uh62e
	gqIXecZqPhFZV4pi+sf/0m7yaKws5GE9sJHjg4amcBUw1ss4YWtqE3cQ/ONzBhlyq6vhi5
	PQUncF8lohKsJDCTMFR4y6f1BJTQ0rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3vObMH8r167VRprrezbv2fatEayplnrFIq2d12qAzI=;
	b=X/z3QuC7/1ZKPu3KHs6LRYk2DeCYcQ/KFy/2o9zHoLbvRqY8dkfjE3UROqJJMHgCesOTTz
	3MZHYEIMGEjVbhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 477DF13867;
	Mon, 29 Jan 2024 03:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9YIxAGcdt2UjKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:37:11 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 04/13] nfsd: avoid race after unhash_delegation_locked()
Date: Mon, 29 Jan 2024 14:29:26 +1100
Message-ID: <20240129033637.2133-5-neilb@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1J+tHcqL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="X/z3QuC7"
X-Spamd-Result: default: False [4.69 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[13.91%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: E192A2229D
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

NFS4_CLOSED_DELEG_STID and NFS4_REVOKED_DELEG_STID are similar in
purpose.
REVOKED is used for NFSv4.1 states which have been revoked because the
lease has expired.  CLOSED is used in other cases.
The difference has two practical effects.
1/ REVOKED states are on the ->cl_revoked list
2/ REVOKED states result in nfserr_deleg_revoked from
   nfsd4_verify_open_stid() and nfsd4_validate_stateid while
   CLOSED states result in nfserr_bad_stid.

Currently a state that is being revoked is first set to "CLOSED" in
unhash_delegation_locked(), then possibly to "REVOKED" in
revoke_delegation(), at which point it is added to the cl_revoked list.

It is possible that a stateid test could see the CLOSED state
which really should be REVOKED, and so return the wrong error code.  So
it is safest to remove this window of inconsistency.

With this patch, unhash_delegation_locked() always sets the state
correctly, and revoke_delegation() no longer changes the state.

Also remove a redundant test on minorversion when
NFS4_REVOKED_DELEG_STID is seen - it can only be seen when minorversion
is non-zero.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2ddbb7b4a40e..dbf9ed84610e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1329,7 +1329,7 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
 }
 
 static bool
-unhash_delegation_locked(struct nfs4_delegation *dp)
+unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
@@ -1338,7 +1338,9 @@ unhash_delegation_locked(struct nfs4_delegation *dp)
 	if (!delegation_hashed(dp))
 		return false;
 
-	dp->dl_stid.sc_type = NFS4_CLOSED_DELEG_STID;
+	if (dp->dl_stid.sc_client->cl_minorversion == 0)
+		type = NFS4_CLOSED_DELEG_STID;
+	dp->dl_stid.sc_type = type;
 	/* Ensure that deleg break won't try to requeue it */
 	++dp->dl_time;
 	spin_lock(&fp->fi_lock);
@@ -1354,7 +1356,7 @@ static void destroy_delegation(struct nfs4_delegation *dp)
 	bool unhashed;
 
 	spin_lock(&state_lock);
-	unhashed = unhash_delegation_locked(dp);
+	unhashed = unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
 	spin_unlock(&state_lock);
 	if (unhashed)
 		destroy_unhashed_deleg(dp);
@@ -1368,9 +1370,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 
 	trace_nfsd_stid_revoke(&dp->dl_stid);
 
-	if (clp->cl_minorversion) {
+	if (dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
 		spin_lock(&clp->cl_lock);
-		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
 		refcount_inc(&dp->dl_stid.sc_count);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
 		spin_unlock(&clp->cl_lock);
@@ -2229,7 +2230,7 @@ __destroy_client(struct nfs4_client *clp)
 	spin_lock(&state_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
-		unhash_delegation_locked(dp);
+		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -5145,8 +5146,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 		goto out;
 	if (deleg->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
 		nfs4_put_stid(&deleg->dl_stid);
-		if (cl->cl_minorversion)
-			status = nfserr_deleg_revoked;
+		status = nfserr_deleg_revoked;
 		goto out;
 	}
 	flags = share_access_to_flags(open->op_share_access);
@@ -6169,7 +6169,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
-		unhash_delegation_locked(dp);
+		unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -8292,7 +8292,7 @@ nfs4_state_shutdown_net(struct net *net)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		unhash_delegation_locked(dp);
+		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
-- 
2.43.0


