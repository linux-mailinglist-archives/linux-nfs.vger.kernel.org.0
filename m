Return-Path: <linux-nfs+bounces-1593-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D65784182E
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 02:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6570284CFB
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 01:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD0F2E40C;
	Tue, 30 Jan 2024 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vMRoEX+/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qvBOgY4o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vMRoEX+/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qvBOgY4o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C722083
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577148; cv=none; b=McBJmcuDJqb8wCPcBBh5zDWU5oJAlWz3FuvQkcE2YxuSRzTr4i/T96rw5DetAl9IHwkNOmg9Ao9rDcTwE+scd9lKeH3ApPUdsPwNY00eHBTw/taAGHRCQ556FNr5Ujrw8MZhMF/spnzmmMnFIYRCQmymHN2pmKzN8hdbTtEKd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577148; c=relaxed/simple;
	bh=a+8BziXoWR7rFKkRUEDnUodGo6E6U1Xqo0vARz6f30Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPF0SN9XFuZtnsTNogB/YOi+uhfBT2UFWH7EhNSr5iNqUa2PgfUQw3VV/IQ4kYg2dX8NHlLVGhaO539Mm00KK7jW/Epl1sotuEn2EBuS4a63iFRcU6nvxyRYFXa/TJBlDo6fmOnKMsE+xTEQeygGROHklzcZtx0cIjddapo2td8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vMRoEX+/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qvBOgY4o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vMRoEX+/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qvBOgY4o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C227C220DC;
	Tue, 30 Jan 2024 01:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttAT5y/nztbR82kvRMkYnQLINuQYmY8MtArg2GUwnTA=;
	b=vMRoEX+/SEJz4t+U9N9FBMeTyBNokSdXQiDG4decuJXxt0Ii6MnO3RVFQjQvbYNyoG6eka
	ybLJ6uzhkXo3UvFSGdIUzcpyiTuRmwKkzgA2FHEIQD8MejqMULbvLj1gAYtDg82MjzzJV9
	UNFdvQKWntzHFhfmNohhrFS5J3Kd77o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttAT5y/nztbR82kvRMkYnQLINuQYmY8MtArg2GUwnTA=;
	b=qvBOgY4oxkxTzT2lVOFwXb91s2isciLOVL2+NethQZGJsZQ8D0PC45vHz7hz1hGo9tfxRQ
	y7CW2Ly2ICgYHYDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttAT5y/nztbR82kvRMkYnQLINuQYmY8MtArg2GUwnTA=;
	b=vMRoEX+/SEJz4t+U9N9FBMeTyBNokSdXQiDG4decuJXxt0Ii6MnO3RVFQjQvbYNyoG6eka
	ybLJ6uzhkXo3UvFSGdIUzcpyiTuRmwKkzgA2FHEIQD8MejqMULbvLj1gAYtDg82MjzzJV9
	UNFdvQKWntzHFhfmNohhrFS5J3Kd77o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttAT5y/nztbR82kvRMkYnQLINuQYmY8MtArg2GUwnTA=;
	b=qvBOgY4oxkxTzT2lVOFwXb91s2isciLOVL2+NethQZGJsZQ8D0PC45vHz7hz1hGo9tfxRQ
	y7CW2Ly2ICgYHYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2863E12FF7;
	Tue, 30 Jan 2024 01:12:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tIE8NPVMuGXuQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jan 2024 01:12:21 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 11/13] nfsd: allow open state ids to be revoked and then freed
Date: Tue, 30 Jan 2024 12:08:31 +1100
Message-ID: <20240130011102.8623-12-neilb@suse.de>
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
X-Spam-Level: **
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vMRoEX+/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qvBOgY4o
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.43 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.06)[61.46%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 2.43
X-Rspamd-Queue-Id: C227C220DC
X-Spam-Flag: NO

Revoking state through 'unlock_filesystem' now revokes any open states
found.  When the stateids are then freed by the client, the revoked
stateids will be cleaned up correctly.

Possibly the related lock states should be revoked too, but a
subsequent patch will do that for all lock state on the superblock.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4d5b0a798a6a..daf61f26e609 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1717,7 +1717,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned int sc_types;
 
-	sc_types = SC_TYPE_LOCK;
+	sc_types = SC_TYPE_OPEN | SC_TYPE_LOCK;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1732,6 +1732,22 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
+				case SC_TYPE_OPEN:
+					stp = openlockstateid(stid);
+					mutex_lock_nested(&stp->st_mutex,
+							  OPEN_STATEID_MUTEX);
+
+					spin_lock(&clp->cl_lock);
+					if (stid->sc_status == 0) {
+						stid->sc_status |=
+							SC_STATUS_ADMIN_REVOKED;
+						atomic_inc(&clp->cl_admin_revoked);
+						spin_unlock(&clp->cl_lock);
+						release_all_access(stp);
+					} else
+						spin_unlock(&clp->cl_lock);
+					mutex_unlock(&stp->st_mutex);
+					break;
 				case SC_TYPE_LOCK:
 					stp = openlockstateid(stid);
 					mutex_lock_nested(&stp->st_mutex,
@@ -4663,6 +4679,13 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
 	bool unhashed;
 
 	switch (s->sc_type) {
+	case SC_TYPE_OPEN:
+		stp = openlockstateid(s);
+		if (unhash_open_stateid(stp, &reaplist))
+			put_ol_stateid_locked(stp, &reaplist);
+		spin_unlock(&cl->cl_lock);
+		free_ol_stateid_reaplist(&reaplist);
+		break;
 	case SC_TYPE_LOCK:
 		stp = openlockstateid(s);
 		unhashed = unhash_lock_stateid(stp);
-- 
2.43.0


