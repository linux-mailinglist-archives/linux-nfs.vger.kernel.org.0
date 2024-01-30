Return-Path: <linux-nfs+bounces-1592-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A0B84182D
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 02:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1E6283EB5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F732C868;
	Tue, 30 Jan 2024 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GHIYYoJE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/dKT6xCe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GHIYYoJE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/dKT6xCe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3522083
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577141; cv=none; b=s3yh7gD8a16G4zfMFr0P5Ijs2W7uJk8Qq/o8JPC8ijnvaOxe3a2d+/cK6nV4ZoUYyMs9HUzxb93Pu9wBULJbMETbeOrRgCtdILys+ZfjHwXCJSPbNz3L61IRedN3RDG/7Y7sjH1OfWYHXyv14BPu6vKA7kTcAtAZ0MCSV+XQygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577141; c=relaxed/simple;
	bh=AuKe5daPhodBuuWWdqfF8pV25sb2w8b20ajbDTf5GI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dr2QFBsotDXIdp+ri9AVE7BODCrRbc5dw3O9Z21a1UEHiqi/HzUpYiSv+1sH9Pv7Ck223R3muZvBmiXBl+gadc6zzd7B+HJAD6oFKNaZ7VAOS0+oRJeYg/OVtStOQ1/6WHMCYHF9TfUHYZpTiIdo+hdXif8iRAoDWdTa+k3tRBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GHIYYoJE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/dKT6xCe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GHIYYoJE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/dKT6xCe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C40341F818;
	Tue, 30 Jan 2024 01:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYs/0/Jn9ze+Og46cFyFuVN5kQRW3f8neEzF8heP0N8=;
	b=GHIYYoJEcVtyzmfLco1F5IQ7E/vaBaZ2Zw2iNl2hOadhPwhB4O3dSIFz/HVIplO2QaG9vn
	ieXLIuF8uggFmZGwdrLdUx/N9Il8xZJEU7rB0+RIl/tOztjfgK5xcu/XLgnK3f2pt5QSjZ
	DTkhGAIEG4/1/b3Ab6rQ/c/ItDG65OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYs/0/Jn9ze+Og46cFyFuVN5kQRW3f8neEzF8heP0N8=;
	b=/dKT6xCejaPeUZtC8AeNQALErf5exXLoe/7yo+PNhfKpEfpfY/ZCjNOVL3lI7nhfpHOUGJ
	+OSH211OHBZWBjAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYs/0/Jn9ze+Og46cFyFuVN5kQRW3f8neEzF8heP0N8=;
	b=GHIYYoJEcVtyzmfLco1F5IQ7E/vaBaZ2Zw2iNl2hOadhPwhB4O3dSIFz/HVIplO2QaG9vn
	ieXLIuF8uggFmZGwdrLdUx/N9Il8xZJEU7rB0+RIl/tOztjfgK5xcu/XLgnK3f2pt5QSjZ
	DTkhGAIEG4/1/b3Ab6rQ/c/ItDG65OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYs/0/Jn9ze+Og46cFyFuVN5kQRW3f8neEzF8heP0N8=;
	b=/dKT6xCejaPeUZtC8AeNQALErf5exXLoe/7yo+PNhfKpEfpfY/ZCjNOVL3lI7nhfpHOUGJ
	+OSH211OHBZWBjAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E5ED12FF7;
	Tue, 30 Jan 2024 01:12:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XT3nNe9MuGXnQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jan 2024 01:12:15 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 10/13] nfsd: allow lock state ids to be revoked and then freed
Date: Tue, 30 Jan 2024 12:08:30 +1100
Message-ID: <20240130011102.8623-11-neilb@suse.de>
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
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.69%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Revoking state through 'unlock_filesystem' now revokes any lock states
found.  When the stateids are then freed by the client, the revoked
stateids will be cleaned up correctly.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ab7f4e25f2a1..4d5b0a798a6a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1717,7 +1717,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned int sc_types;
 
-	sc_types = 0;
+	sc_types = SC_TYPE_LOCK;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1728,8 +1728,36 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
 								  sc_types);
 			if (stid) {
+				struct nfs4_ol_stateid *stp;
+
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
+				case SC_TYPE_LOCK:
+					stp = openlockstateid(stid);
+					mutex_lock_nested(&stp->st_mutex,
+							  LOCK_STATEID_MUTEX);
+					spin_lock(&clp->cl_lock);
+					if (stid->sc_status == 0) {
+						struct nfs4_lockowner *lo =
+							lockowner(stp->st_stateowner);
+						struct nfsd_file *nf;
+
+						stid->sc_status |=
+							SC_STATUS_ADMIN_REVOKED;
+						atomic_inc(&clp->cl_admin_revoked);
+						spin_unlock(&clp->cl_lock);
+						nf = find_any_file(stp->st_stid.sc_file);
+						if (nf) {
+							get_file(nf->nf_file);
+							filp_close(nf->nf_file,
+								   (fl_owner_t)lo);
+							nfsd_file_put(nf);
+						}
+						release_all_access(stp);
+					} else
+						spin_unlock(&clp->cl_lock);
+					mutex_unlock(&stp->st_mutex);
+					break;
 				}
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
@@ -4630,8 +4658,18 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
 	__releases(&s->sc_client->cl_lock)
 {
 	struct nfs4_client *cl = s->sc_client;
+	LIST_HEAD(reaplist);
+	struct nfs4_ol_stateid *stp;
+	bool unhashed;
 
 	switch (s->sc_type) {
+	case SC_TYPE_LOCK:
+		stp = openlockstateid(s);
+		unhashed = unhash_lock_stateid(stp);
+		spin_unlock(&cl->cl_lock);
+		if (unhashed)
+			nfs4_put_stid(s);
+		break;
 	default:
 		spin_unlock(&cl->cl_lock);
 	}
-- 
2.43.0


