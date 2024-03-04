Return-Path: <linux-nfs+bounces-2155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5912A86F94E
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 05:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A901F215C5
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 04:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A317F3;
	Mon,  4 Mar 2024 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pjwBwcFz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gLiFqBo1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pjwBwcFz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gLiFqBo1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C317C8
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527429; cv=none; b=u1uAf9whlu0Op3VRIeIQ8xExY6eEzMGpUd+rELrcuEKgcjguU/JAYimKfEWl1wvRxK3QsmqLJV4pKpBXGHC39CiIdFRSTFpWFnLdvpDBjRn3PW6yNxnODLOSMLUMrbnQLAYuxpcAOGyhqzRcZ/nLy552gYTeiNWrETbXD9c9Qz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527429; c=relaxed/simple;
	bh=Kh7InTreTKweygAPNXuQQZl7mekOE/h9RnUDVgLtI0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfhZQRxEWgUcE7tycEl/smeokDJVPR7ToJ2ocJKxrso2NRw4BQHrlNPIVW2QFErlGLoc6CjBO462iXoIyKbX4S+ofNcViz5hBLYsAt5aU3LS9o858Mp0vze0UrJGpMKjKxsIgLa2mrHULM4Q/eSTTtLt7WFpZUbboSYzzGPLFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pjwBwcFz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gLiFqBo1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pjwBwcFz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gLiFqBo1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 06CA0680B5;
	Mon,  4 Mar 2024 04:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNdvfkDA44vBJM4WuAy2w8MWhAb5nBVyQ1ngqt5037k=;
	b=pjwBwcFzazXpH8qxxDARi5U+vQaOI3MimfZnIHuZhQtogwma414rgOJItx2orXmg+M0r6L
	bkVuy6pVFcDcHedWTjy/U6JNutswGclQLYNeQEyW6XFGel6Hn/MxxkCQ0bP+ZKLAkhMxDT
	ikH4n3Dis5x2F8P0Vg0VJ/aGO8Or84o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNdvfkDA44vBJM4WuAy2w8MWhAb5nBVyQ1ngqt5037k=;
	b=gLiFqBo19p6OPhcNbCUrr0cyeUJaPJCJlzdDpYYdjGybY/wHLc/t2Wgs7RWERbIfH42KZf
	1cPvpdReZLEA/LBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNdvfkDA44vBJM4WuAy2w8MWhAb5nBVyQ1ngqt5037k=;
	b=pjwBwcFzazXpH8qxxDARi5U+vQaOI3MimfZnIHuZhQtogwma414rgOJItx2orXmg+M0r6L
	bkVuy6pVFcDcHedWTjy/U6JNutswGclQLYNeQEyW6XFGel6Hn/MxxkCQ0bP+ZKLAkhMxDT
	ikH4n3Dis5x2F8P0Vg0VJ/aGO8Or84o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNdvfkDA44vBJM4WuAy2w8MWhAb5nBVyQ1ngqt5037k=;
	b=gLiFqBo19p6OPhcNbCUrr0cyeUJaPJCJlzdDpYYdjGybY/wHLc/t2Wgs7RWERbIfH42KZf
	1cPvpdReZLEA/LBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64D3013A9F;
	Mon,  4 Mar 2024 04:43:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lqONAn9R5WVvNwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 04:43:43 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/4] nfsd: drop st_mutex_mutex before calling move_to_close_lru()
Date: Mon,  4 Mar 2024 15:40:22 +1100
Message-ID: <20240304044304.3657-5-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304044304.3657-1-neilb@suse.de>
References: <20240304044304.3657-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pjwBwcFz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gLiFqBo1
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 06CA0680B5
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

move_to_close_lru() is currently called with ->st_mutex held.
This can lead to a deadlock as move_to_close_lru() waits for sc_count to
drop to 2, and some threads holding a reference might be waiting for the
mutex.  These references will never be dropped so sc_count will never
reach 2.

There can be no harm in dropping ->st_mutex before
move_to_close_lru() because the only place that takes the mutex is
nfsd4_lock_ol_stateid(), and it quickly aborts if sc_type is
NFS4_CLOSED_STID, which it will be before move_to_close_lru() is called.

See also
 https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
where this problem was raised but not successfully resolved.

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 47e879d5d68a..05181b4a3ce8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6998,7 +6998,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	return status;
 }
 
-static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
+static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
 {
 	struct nfs4_client *clp = s->st_stid.sc_client;
 	bool unhashed;
@@ -7015,11 +7015,11 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
 		list_for_each_entry(stp, &reaplist, st_locks)
 			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
 		free_ol_stateid_reaplist(&reaplist);
+		return false;
 	} else {
 		spin_unlock(&clp->cl_lock);
 		free_ol_stateid_reaplist(&reaplist);
-		if (unhashed)
-			move_to_close_lru(s, clp->net);
+		return unhashed;
 	}
 }
 
@@ -7035,6 +7035,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_ol_stateid *stp;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	bool need_move_to_close_list;
 
 	dprintk("NFSD: nfsd4_close on file %pd\n", 
 			cstate->current_fh.fh_dentry);
@@ -7057,8 +7058,10 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 */
 	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
 
-	nfsd4_close_open_stateid(stp);
+	need_move_to_close_list = nfsd4_close_open_stateid(stp);
 	mutex_unlock(&stp->st_mutex);
+	if (need_move_to_close_list)
+		move_to_close_lru(stp, net);
 
 	/* v4.1+ suggests that we send a special stateid in here, since the
 	 * clients should just ignore this anyway. Since this is not useful
-- 
2.43.0


