Return-Path: <linux-nfs+bounces-1525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1627483FCDB
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C374F282C26
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548D410940;
	Mon, 29 Jan 2024 03:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0TrPQqn/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5rHQTZD9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0TrPQqn/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5rHQTZD9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD910957
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499473; cv=none; b=AI88QJ8zqgx7nAo+IUXQGMhcin4RX2K/F77zRlIk7qVjyqwtNzbcrOZJ3hkbFkqLoM7S4a4fyRAgYOcAtEUZU615NIrC6DZvkqxQKdvwmNZL2h2pzTt4ltSOv2jfZAsClzvqmmGcMErWGOEaU4UKkjkzVVvkTgakgaer9DcZ3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499473; c=relaxed/simple;
	bh=q7KaIxyb20dvgA8YO57YU86t6JtIP/76IlMH8dbmoTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTRYGFYJj9W6Swc5zswgRpSpM8nUXLM5nxuJ/NFBDIC05YKJDhiMBxtXvbcvCvpPQWzwAkcSvgVnZ7J5851bb9NjXGHj2RzPZPYkxE6+kB6VpbdpmrQ53hTWdAC5mkiEAxGmqG7jsKy59XS7M7tfN4oIDD5HTGp0Rx0vXw0HwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0TrPQqn/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5rHQTZD9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0TrPQqn/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5rHQTZD9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1947D222A0;
	Mon, 29 Jan 2024 03:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+T4zkfJrWW4gl+ixRVB3PT9p/VAAJKcjQa6WI/+FEdI=;
	b=0TrPQqn/NdwN61VaBiEMwTa3DrOdguCxLrzDdJhGpHdI7ZHab5TBaSfyeGKpW7Vc0p6mfL
	jNj7nvOQpWUT0ZV7fAayY3YJAau4XDIbjacHQ7DS6y9l+vcT4JS3nbpXdLxlON0ebOuyWC
	LLKVd+5G5v2MxuDAEsvCu01QTWHwU9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+T4zkfJrWW4gl+ixRVB3PT9p/VAAJKcjQa6WI/+FEdI=;
	b=5rHQTZD9Yafwy4QnHfSQIJ6+/EDXabjQhfN+S31pMbml01w0CN1+7U8u1ie6MJw5jKXlUq
	HzXqr38aLJC1v7AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+T4zkfJrWW4gl+ixRVB3PT9p/VAAJKcjQa6WI/+FEdI=;
	b=0TrPQqn/NdwN61VaBiEMwTa3DrOdguCxLrzDdJhGpHdI7ZHab5TBaSfyeGKpW7Vc0p6mfL
	jNj7nvOQpWUT0ZV7fAayY3YJAau4XDIbjacHQ7DS6y9l+vcT4JS3nbpXdLxlON0ebOuyWC
	LLKVd+5G5v2MxuDAEsvCu01QTWHwU9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+T4zkfJrWW4gl+ixRVB3PT9p/VAAJKcjQa6WI/+FEdI=;
	b=5rHQTZD9Yafwy4QnHfSQIJ6+/EDXabjQhfN+S31pMbml01w0CN1+7U8u1ie6MJw5jKXlUq
	HzXqr38aLJC1v7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76EB213867;
	Mon, 29 Jan 2024 03:37:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AKjWC4sdt2VHKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:37:47 +0000
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
Date: Mon, 29 Jan 2024 14:29:32 +1100
Message-ID: <20240129033637.2133-11-neilb@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="0TrPQqn/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5rHQTZD9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.46 / 50.00];
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
	 BAYES_HAM(-0.03)[56.62%];
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
X-Spam-Score: 3.46
X-Rspamd-Queue-Id: 1947D222A0
X-Spam-Flag: NO

Revoking state through 'unlock_filesystem' now revokes any lock states
found.  When the stateids are then freed by the client, the revoked
stateids will be cleaned up correctly.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 900d295bd570..a5c17dab8bdb 100644
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
@@ -4629,8 +4657,18 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
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


