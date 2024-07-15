Return-Path: <linux-nfs+bounces-4901-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6213F930F1E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844C21C2096E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21826AB8;
	Mon, 15 Jul 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="At1fCskP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+p/x5r5E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="At1fCskP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+p/x5r5E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5404E1836C1
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029726; cv=none; b=fRFrMSLSinNuKby41qqeI6pd5+o+xrjH51+OxCXsX5ifnsflYbnSpy6ZpqXVX9t7OzRNOUzijp2mMddokmp8YfvhZa5B+/xhe7ASIGEp7RHRTCkZHSbSJO7x3Ti/iU37wqR2qrCkJ83pvCW7smvT+BLYxDRr7/fkGTorLIZ/8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029726; c=relaxed/simple;
	bh=f5BbXpNPQnWu/8Nlp5XWOowsugkJkccRpkGNU2TtxWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERLLaxuNrjJ69nQR/EtCNX5YRKytr5sfLwuEcuhr+YCG5161KltU/xZ2sy3iwjt5CDWto8Ju4h/R9WT+Z7zyVFYA/xl1sRkBQmqLQ6U0TzxJs8ITKm5oyWUXlig8RJ0y7tqY6l9wNvC3/tXuJmR9SpnVWiJzJ+ayknXKOiboSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=At1fCskP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+p/x5r5E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=At1fCskP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+p/x5r5E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E3531F7FA;
	Mon, 15 Jul 2024 07:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S26RsZliLAWJR8QysfTpg9Wsa/I9wXuD3pM8/jzFvH0=;
	b=At1fCskPwembE8J2PwSqMZC+zFMs/Vo/z+wizWomHckQu9WwKhvj1rSWgNyEOwXfKm3wG3
	wqFi85qisVK8S/gcCNhUkt3nKA2aY6YB3mUzjSw+i0y+yGfg2wLH3i90WAYZuMwenKMQAY
	MG8wFYafVI2ilgJfLpgis2JtTyCuQfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S26RsZliLAWJR8QysfTpg9Wsa/I9wXuD3pM8/jzFvH0=;
	b=+p/x5r5Eyp7l6nfseTgNP4j/t2aMk0HFhnRW1xFXZmOTqnHU7HdliJITVWiHkdW+CSRXMF
	9jEYB9XlHQmEOcCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=At1fCskP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="+p/x5r5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S26RsZliLAWJR8QysfTpg9Wsa/I9wXuD3pM8/jzFvH0=;
	b=At1fCskPwembE8J2PwSqMZC+zFMs/Vo/z+wizWomHckQu9WwKhvj1rSWgNyEOwXfKm3wG3
	wqFi85qisVK8S/gcCNhUkt3nKA2aY6YB3mUzjSw+i0y+yGfg2wLH3i90WAYZuMwenKMQAY
	MG8wFYafVI2ilgJfLpgis2JtTyCuQfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S26RsZliLAWJR8QysfTpg9Wsa/I9wXuD3pM8/jzFvH0=;
	b=+p/x5r5Eyp7l6nfseTgNP4j/t2aMk0HFhnRW1xFXZmOTqnHU7HdliJITVWiHkdW+CSRXMF
	9jEYB9XlHQmEOcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 362AA137EB;
	Mon, 15 Jul 2024 07:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LZT0NljUlGYhbgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:48:40 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 09/14] nfsd: return hard failure for OP_SETCLIENTID when there are too many clients.
Date: Mon, 15 Jul 2024 17:14:22 +1000
Message-ID: <20240715074657.18174-10-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E3531F7FA
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /

If there are more non-courteous clients than the calculated limit, we
should fail the request rather than report a soft failure and
encouraging the client to retry indefinitely.

If there a courteous clients which push us over the limit, then expedite
their removal.

This is not known to have caused a problem is production use, but
testing of lots of clients reports repeated NFS4ERR_DELAY responses
which doesn't seem helpful.

Also remove an outdated comment - we do use a slab cache.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..88936f3189e1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2212,21 +2212,20 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net *nn)
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
+	if (atomic_read(&nn->nfs4_client_count) -
+	    atomic_read(&nn->nfsd_courtesy_clients) >= nn->nfs4_max_clients)
+		return ERR_PTR(-EREMOTEIO);
+
+	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients &&
+	    atomic_read(&nn->nfsd_courtesy_clients) > 0)
 		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
-		return NULL;
-	}
+
 	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
 	if (clp == NULL)
 		return NULL;
@@ -3115,8 +3114,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	struct dentry *dentries[ARRAY_SIZE(client_files)];
 
 	clp = alloc_client(name, nn);
-	if (clp == NULL)
-		return NULL;
+	if (IS_ERR_OR_NULL(clp))
+		return clp;
 
 	ret = copy_cred(&clp->cl_cred, &rqstp->rq_cred);
 	if (ret) {
@@ -3498,6 +3497,8 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	new = create_client(exid->clname, rqstp, &verf);
 	if (new == NULL)
 		return nfserr_jukebox;
+	if (IS_ERR(new))
+		return nfserr_resource;
 	status = copy_impl_id(new, exid);
 	if (status)
 		goto out_nolock;
@@ -4416,6 +4417,8 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	new = create_client(clname, rqstp, &clverifier);
 	if (new == NULL)
 		return nfserr_jukebox;
+	if (IS_ERR(new))
+		return nfserr_resource;
 	spin_lock(&nn->client_lock);
 	conf = find_confirmed_client_by_name(&clname, nn);
 	if (conf && client_has_state(conf)) {
-- 
2.44.0


