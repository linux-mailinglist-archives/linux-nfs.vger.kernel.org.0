Return-Path: <linux-nfs+bounces-52-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6513F7F6B48
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 05:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C3CB20CE0
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 04:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F876848C;
	Fri, 24 Nov 2023 04:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D6110F0
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 20:20:32 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E23E222C73;
	Fri, 24 Nov 2023 00:29:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF9A51340B;
	Fri, 24 Nov 2023 00:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LoonGHfuX2VAegAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 24 Nov 2023 00:29:43 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 01/11] nfsd: hold ->cl_lock for hash_delegation_locked()
Date: Fri, 24 Nov 2023 11:23:13 +1100
Message-ID: <20231124002504.19515-2-neilb@suse.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124002504.19515-1-neilb@suse.de>
References: <20231124002504.19515-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++
X-Spam-Score: 11.70
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: E23E222C73
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Spamd-Result: default: False [11.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.09)[-0.454];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]

The protocol for creating a new state in nfsd is to allocated the state
leaving it largely uninitialised, add that state to the ->cl_stateids
idr so as to reserve a state id, then complete initialisation of the
state and only set ->sc_type to non-zero once the state is fully
initialised.

If a state is found in the idr with ->sc_type == 0, it is ignored.
The ->cl_lock lock is used to avoid races - it is held while checking
sc_type during lookup, and held when a non-zero value is stored in
->sc_type.

... except... hash_delegation_locked() finalises the initialisation of a
delegation state, but does NOT hold ->cl_lock.

So this patch takes ->cl_lock at the appropriate time w.r.t other locks,
and so ensures there are no races (which are extremely unlikely in any
case).
As ->fi_lock is often taken when ->cl_lock is held, we need to take
->cl_lock first of those two.
Currently ->cl_lock and state_lock are never both taken at the same time.
We need both for this patch so an arbitrary choice is needed concerning
which to take first.  As state_lock is more global, it might be more
contended, so take it first.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 40415929e2ae..042c7a50f425 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1317,6 +1317,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 
 	lockdep_assert_held(&state_lock);
 	lockdep_assert_held(&fp->fi_lock);
+	lockdep_assert_held(&clp->cl_lock);
 
 	if (nfs4_delegation_exists(clp, fp))
 		return -EAGAIN;
@@ -5608,12 +5609,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		goto out_unlock;
 
 	spin_lock(&state_lock);
+	spin_lock(&clp->cl_lock);
 	spin_lock(&fp->fi_lock);
 	if (fp->fi_had_conflict)
 		status = -EAGAIN;
 	else
 		status = hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
+	spin_unlock(&clp->cl_lock);
 	spin_unlock(&state_lock);
 
 	if (status)
-- 
2.42.1


