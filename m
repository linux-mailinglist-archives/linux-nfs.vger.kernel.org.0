Return-Path: <linux-nfs+bounces-59-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B137F6B63
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 05:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925DF280FA6
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 04:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221F6156CB;
	Fri, 24 Nov 2023 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hjZjza9C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="thqP9SFu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C493C10E6
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 20:33:12 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 151CC5BE92;
	Fri, 24 Nov 2023 00:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700785919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+Jy2Um2n8HBnWnrSA4EkYdCGq6uSt4dpWmuxWAoARU=;
	b=hjZjza9CJ8wjO8V3mLGEAuCplUxIET2cRZHhIlChvuyzFxfkozOa6mbYw5VvK7BVSsvkXd
	t2aoFyhWVa4Fn+NDNtCkFFNQ1CQMHPvJ/U/SPioJ4HJX7Yi6nPx5ZuVosWeHy+Jl+J/ewl
	hpsoNsVXj5UkADyMvGP5f2KcG7SanA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700785919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+Jy2Um2n8HBnWnrSA4EkYdCGq6uSt4dpWmuxWAoARU=;
	b=thqP9SFuf1TNPJAsYjNkiVqDNbOHiZ9Vipy/C2L8tAeezr6uRW53ou0+I2MVVFgZEaEZJf
	RLamXxDxVwhpLTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F30DD1340B;
	Fri, 24 Nov 2023 00:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E4khKvzuX2XJegAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 24 Nov 2023 00:31:56 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 09/11] nfsd: allow open state ids to be revoked and then freed
Date: Fri, 24 Nov 2023 11:28:44 +1100
Message-ID: <20231124002925.1816-10-neilb@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 4.70
X-Spamd-Result: default: False [4.70 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-0.987];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

Revoking state through 'unlock_filesystem' now revokes any open states
found.  When the stateids are then freed by the client, the revoked
stateids will be cleaned up correctly.

Possibly the related lock states should be revoked too, but a
subsequent patch will do that for all lock state on the superblock.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0f52e10fbdfb..8712eb81123f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1708,7 +1708,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned int sc_types;
 
-	sc_types = NFS4_LOCK_STID;
+	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1723,6 +1723,22 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
+				case NFS4_OPEN_STID:
+					stp = openlockstateid(stid);
+					mutex_lock_nested(&stp->st_mutex,
+							  OPEN_STATEID_MUTEX);
+
+					spin_lock(&clp->cl_lock);
+					if (stid->sc_status == 0) {
+						stid->sc_status |=
+							NFS4_STID_ADMIN_REVOKED;
+						atomic_inc(&clp->cl_admin_revoked);
+						spin_unlock(&clp->cl_lock);
+						release_all_access(stp);
+					} else
+						spin_unlock(&clp->cl_lock);
+					mutex_unlock(&stp->st_mutex);
+					break;
 				case NFS4_LOCK_STID:
 					stp = openlockstateid(stid);
 					mutex_lock_nested(&stp->st_mutex,
@@ -4692,6 +4708,13 @@ static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
 	bool unhashed;
 
 	switch (s->sc_type) {
+	case NFS4_OPEN_STID:
+		stp = openlockstateid(s);
+		if (unhash_open_stateid(stp, &reaplist))
+			put_ol_stateid_locked(stp, &reaplist);
+		spin_unlock(&cl->cl_lock);
+		free_ol_stateid_reaplist(&reaplist);
+		break;
 	case NFS4_LOCK_STID:
 		stp = openlockstateid(s);
 		unhashed = unhash_lock_stateid(stp);
-- 
2.42.1


