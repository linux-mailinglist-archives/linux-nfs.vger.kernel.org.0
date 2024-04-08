Return-Path: <linux-nfs+bounces-2709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3689B5D8
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 04:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397401C2037C
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 02:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC21852;
	Mon,  8 Apr 2024 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OOJJLv0t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ccmIl95G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OOJJLv0t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ccmIl95G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D601851
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542359; cv=none; b=J5xvu3mvU5UI1CIk64AS6rHIlu1ElHTXFo/dTT5MNP7qJr6Sxt0vkAYAskMuV3Jnzj3bovciSC6EkQMbw/8JpJDKfl+cqSTKvOsSwMahvrza+S5JThdPIqNvOAY4FvOHOgt+/XZt/TuKX1jWhbWKMW0DoB1zMyrlg/So0icdvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542359; c=relaxed/simple;
	bh=sorDqV8ug6ro+N01MqMUjWywIY+b5V9rlT7XopRjBoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbDJ8nT/JXldBIpfHfG+IlRL4IzMGpXw/5Q4rRMRcdBi4GPxqFqNhjQBOfTEsROKrh305hWADT0ZpILEingyzK16H22Y2jzRirVBH5F6O0X9s3B4jNyLUhFGmNqnMznUoPNod7/QrCJd+flOKQOZDbWb+MsTMSYNZm/HRSq+fUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OOJJLv0t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ccmIl95G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OOJJLv0t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ccmIl95G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A436200A7;
	Mon,  8 Apr 2024 02:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1VGwEIQj5DbuvtD+dn/+0XLYW0kM/lfT2BuU25vIDQ=;
	b=OOJJLv0tp2G5OaScLIoYy8bGdrgyY5WjCJE1YrXEHQ1WBEZlnlFVJh1BAeZ6naQGRYe4Ee
	n1IQ2EtOaRL/nU6xLenQrR5l+T4feeBKVA5apVyO9r4D2m+64LM+K40hD7AOwA9jkMQBhn
	+VyKtPuCHCSWKjTi4SNZrM2pLmLbcUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1VGwEIQj5DbuvtD+dn/+0XLYW0kM/lfT2BuU25vIDQ=;
	b=ccmIl95GpeoCCvgotK3MMfff2HFdD1kw5hntRz0T7JB4+uTFr/KdVbjWXv2gSgqA0oPGGW
	hyCPXV2Sn9tSgxCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1VGwEIQj5DbuvtD+dn/+0XLYW0kM/lfT2BuU25vIDQ=;
	b=OOJJLv0tp2G5OaScLIoYy8bGdrgyY5WjCJE1YrXEHQ1WBEZlnlFVJh1BAeZ6naQGRYe4Ee
	n1IQ2EtOaRL/nU6xLenQrR5l+T4feeBKVA5apVyO9r4D2m+64LM+K40hD7AOwA9jkMQBhn
	+VyKtPuCHCSWKjTi4SNZrM2pLmLbcUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1VGwEIQj5DbuvtD+dn/+0XLYW0kM/lfT2BuU25vIDQ=;
	b=ccmIl95GpeoCCvgotK3MMfff2HFdD1kw5hntRz0T7JB4+uTFr/KdVbjWXv2gSgqA0oPGGW
	hyCPXV2Sn9tSgxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C74CE13796;
	Mon,  8 Apr 2024 02:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1oKVGpFSE2YNEgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Apr 2024 02:12:33 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/4] nfsd: drop st_mutex before calling move_to_close_lru()
Date: Mon,  8 Apr 2024 12:09:18 +1000
Message-ID: <20240408021156.6104-5-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408021156.6104-1-neilb@suse.de>
References: <20240408021156.6104-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]

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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5dbd1a73bc28..4b7fc0644f89 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7371,7 +7371,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	return status;
 }
 
-static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
+static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
 {
 	struct nfs4_client *clp = s->st_stid.sc_client;
 	bool unhashed;
@@ -7388,11 +7388,11 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
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
 
@@ -7408,6 +7408,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_ol_stateid *stp;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	bool need_move_to_close_list;
 
 	dprintk("NFSD: nfsd4_close on file %pd\n",
 			cstate->current_fh.fh_dentry);
@@ -7432,8 +7433,10 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
2.44.0


