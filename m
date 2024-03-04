Return-Path: <linux-nfs+bounces-2193-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D629E871050
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA37286DAA
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816D1C6AB;
	Mon,  4 Mar 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hAQOX0Nk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h6VdxyJG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hAQOX0Nk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h6VdxyJG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B83C28
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592478; cv=none; b=WDbyc1/buLhMM2v6gNd1FolBdNnvtutZgkS5TtU6uFUanwN6Y5OU6iMdkqPFdeK9jV9inTY8sWBoPmUIUDXbnB3Wphu/2XVg5GgDSDSPG4nozoNv0ov5XuflhoqqLFJbOcZ9xEFKDd8QB/2pIhtF3Q47YgWbdJ45WsCxfq6KmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592478; c=relaxed/simple;
	bh=wm6k4oTysTrJoRcKvgWjRD6LEyaSk8e5XrdE00SW3ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI8L+Yi74pzLHjHxJu02TgihxfnZzGhkKvdI4EfEAN0OAnc6xau6W5KX6s1WJgNqyG+9guig1BEkeuS0HSI3AYjn0Jx0Tkq6ZzFilvSvWagW/gOkWz6x0Eu2ci0PJXt8upKZ/xLsmpIodYeETxR9haDOWoSc41jjW6n1S23XCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hAQOX0Nk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h6VdxyJG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hAQOX0Nk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h6VdxyJG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91F3734F96;
	Mon,  4 Mar 2024 22:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709592475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eoIE+UN4zBuhf6EatwmMK9QXKjrLqJjK1+U2+HjYP0=;
	b=hAQOX0NkOhWq0n7U/bGj3fnSGMIwXXYvv25OWqR4f8sCu1el1u74jZux5eB3ii6CeU5AIW
	7WZPx6N3+IY3PkvIhd7qm2POA2hIjnsxmTjdMPSq1ns8hvwL7MwNwaXthTjAqflptL0MAq
	WtEW7/37b9GjulM5GMZnXFFAvB6UMXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709592475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eoIE+UN4zBuhf6EatwmMK9QXKjrLqJjK1+U2+HjYP0=;
	b=h6VdxyJG9/cjUisORrdjP2SVX76CK8tEzbqBZS5rM6R+5FOOu2e/FafaxtHcj1fuHM87Eb
	dz4lywZM98NTpWAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709592475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eoIE+UN4zBuhf6EatwmMK9QXKjrLqJjK1+U2+HjYP0=;
	b=hAQOX0NkOhWq0n7U/bGj3fnSGMIwXXYvv25OWqR4f8sCu1el1u74jZux5eB3ii6CeU5AIW
	7WZPx6N3+IY3PkvIhd7qm2POA2hIjnsxmTjdMPSq1ns8hvwL7MwNwaXthTjAqflptL0MAq
	WtEW7/37b9GjulM5GMZnXFFAvB6UMXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709592475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eoIE+UN4zBuhf6EatwmMK9QXKjrLqJjK1+U2+HjYP0=;
	b=h6VdxyJG9/cjUisORrdjP2SVX76CK8tEzbqBZS5rM6R+5FOOu2e/FafaxtHcj1fuHM87Eb
	dz4lywZM98NTpWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEA9713A5B;
	Mon,  4 Mar 2024 22:47:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HRNGJJhP5mU5YgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 22:47:52 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/4] nfsd: drop st_mutex_mutex before calling move_to_close_lru()
Date: Tue,  5 Mar 2024 09:45:24 +1100
Message-ID: <20240304224714.10370-5-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304224714.10370-1-neilb@suse.de>
References: <20240304224714.10370-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hAQOX0Nk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=h6VdxyJG
X-Spamd-Result: default: False [0.69 / 50.00];
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
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
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
X-Spam-Score: 0.69
X-Rspamd-Queue-Id: 91F3734F96
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

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
index 52838db0c46e..13cb91d704fd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7351,7 +7351,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	return status;
 }
 
-static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
+static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
 {
 	struct nfs4_client *clp = s->st_stid.sc_client;
 	bool unhashed;
@@ -7368,11 +7368,11 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
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
 
@@ -7388,6 +7388,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_ol_stateid *stp;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	bool need_move_to_close_list;
 
 	dprintk("NFSD: nfsd4_close on file %pd\n",
 			cstate->current_fh.fh_dentry);
@@ -7412,8 +7413,10 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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


