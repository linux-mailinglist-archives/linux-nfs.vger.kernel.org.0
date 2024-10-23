Return-Path: <linux-nfs+bounces-7409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391149AD75B
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 00:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95E11F233B9
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 22:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835D1E1311;
	Wed, 23 Oct 2024 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WWBaAy7i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LgDZ2Noq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WWBaAy7i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LgDZ2Noq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301513B7BE
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721455; cv=none; b=lwp7orh/QPsL3BD95DW4j1gJ/Y9SE32UG14mjGf2Pxp6EB+TjGn8UpsJjhbfnjJLC0ZO2FTnHzecadQb2GpLlzeGLqm4yl7kr1pH4KniopKL9mMEddR2smDi+leh1hhhW9yXrcjsqJNbqdaxfPiDvdFaxJRj7A0Gx4JcCYUKyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721455; c=relaxed/simple;
	bh=alL2Cv4Hl+ZEYVzGiS/M4OzbiV/lEZskfpw2qNbgxgk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=Vwk8xhhqz8X7rbc77Ka2wlU9H/hdPLTLBqyO4hsWIVK0upc6kCqB/cnA3De2f1u51qeGr4maCFWznMuVuarOzKA/vceCul3b4N4krXDDAmwTPh3izjzjPnKjDV2w9pDZ7h25fizJSJZw5w1YwtYzpZBpraaOBzq9OqZqosnA2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WWBaAy7i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LgDZ2Noq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WWBaAy7i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LgDZ2Noq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E04DA21C1B;
	Wed, 23 Oct 2024 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729721451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sN6yLlFNJDr+xeexiS/wv7nX6gmXjqreE33xqvnlPGU=;
	b=WWBaAy7icGKDZHbkJUwt41iSBX+Qe0GL5PzhAzu6j3pheFMQYshTDV5SCJ5ckQ6qVm4aKf
	UzUfRi9+hhE2lNXfELZvbd+AtEJajgK3S6aO/JDU1SfSGvXgdRWkXJQCp+EUQGI4L43OMF
	Y/YaiPrBKL2piAy5fe/DA+ZOXRN2a/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729721451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sN6yLlFNJDr+xeexiS/wv7nX6gmXjqreE33xqvnlPGU=;
	b=LgDZ2NoqA9rWYNDdWtUzQ5rbBFUGWunGZndeYoxa2U34Rlabx/Ws5KNPIF0udNYhTKXyQ0
	QKoRU1Mujy133WCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729721451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sN6yLlFNJDr+xeexiS/wv7nX6gmXjqreE33xqvnlPGU=;
	b=WWBaAy7icGKDZHbkJUwt41iSBX+Qe0GL5PzhAzu6j3pheFMQYshTDV5SCJ5ckQ6qVm4aKf
	UzUfRi9+hhE2lNXfELZvbd+AtEJajgK3S6aO/JDU1SfSGvXgdRWkXJQCp+EUQGI4L43OMF
	Y/YaiPrBKL2piAy5fe/DA+ZOXRN2a/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729721451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sN6yLlFNJDr+xeexiS/wv7nX6gmXjqreE33xqvnlPGU=;
	b=LgDZ2NoqA9rWYNDdWtUzQ5rbBFUGWunGZndeYoxa2U34Rlabx/Ws5KNPIF0udNYhTKXyQ0
	QKoRU1Mujy133WCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C747113AD3;
	Wed, 23 Oct 2024 22:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hf6gHml0GWfTFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 23 Oct 2024 22:10:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 okorniev@redhat.com, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Subject:
 [PATCH v2] nfsd: Don't fail OP_SETCLIENTID when there are too many clients.
Date: Thu, 24 Oct 2024 09:10:42 +1100
Message-id: <172972144286.81717.3023946721770566532@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,noble.neil.brown.name:mid]
X-Spam-Flag: NO
X-Spam-Level: 


Failing OP_SETCLIENTID or OP_EXCHANGE_ID should only happen if there is
memory allocation failure.  Putting a hard limit on the number of
clients is really helpful as it will either happen too early and prevent
clients that the server can easily handle, or too late and allow clients
when the server is swamped.

The calculated limit is still useful for expiring courtesy clients where
there are "too many" clients, but it shouldn't prevent the creation of
active clients.

Testing of lots of clients against small-mem servers reports repeated
NFS4ERR_DELAY responses which doesn't seem helpful.  There may have been
reports of similar problems in production use.

Also remove an outdated comment - we do use a slab cache.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d585c267731b..0791a43b19e6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2218,21 +2218,16 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net *nn)
 	return 1;
 }
 
-/* 
- * XXX Should we use a slab cache ?
- * This type of memory management is somewhat inefficient, but we use it
- * anyway since SETCLIENTID is not a common operation.
- */
 static struct nfs4_client *alloc_client(struct xdr_netobj name,
 				struct nfsd_net *nn)
 {
 	struct nfs4_client *clp;
 	int i;
 
-	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) {
+	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients &&
+	    atomic_read(&nn->nfsd_courtesy_clients) > 0)
 		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
-		return NULL;
-	}
+
 	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
 	if (clp == NULL)
 		return NULL;
-- 
2.46.0


