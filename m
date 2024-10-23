Return-Path: <linux-nfs+bounces-7376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587239ABBB5
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 04:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DF3283B22
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 02:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF04CDEC;
	Wed, 23 Oct 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eeKndd2k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nUwA2jaV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eeKndd2k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nUwA2jaV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3F847B
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651382; cv=none; b=Wp5LYVd+Mdg68ZAnuck+EX/rdt4VbHbVO0Jv1cYJ78GUL3UZ6Ml9SP3FUf4lB88tkffdNYaiihhLZPlyiySCbjaU1af7QoPh3WLvLd+B+3bjDVq6WM+vP2Pd8H+JZZ1THItY71bZuaOcnK6eMS1/d74JB9wnUKKlr6l9DP9nD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651382; c=relaxed/simple;
	bh=Rn84/pLRmFhXmIUP6uRi1iaA4rK7hQehJ9yaBq/VHCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myQMBueFcF03YjWEUVEnDqMopt0a1Al6HEfIaFdUyE++V+rXKNnPGfrmvHAwDIuCaiFd5n+v5IOKUkfD84meG2KpGZ00CfjH6gR9j7eK0pY8HAbJvBoxfI6qJKibt0Cbg1R0XG7LzmZaVkpleQl0L2DmQS8v06ZP8WJdmXdg7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eeKndd2k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nUwA2jaV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eeKndd2k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nUwA2jaV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2BE81F83F;
	Wed, 23 Oct 2024 02:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729651378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctdBhoJoqhe2atqg/Y55XyUbRucmK/lbMKezvDNLgOc=;
	b=eeKndd2k1+ZGs+JLXMFUO1Jto8wRSfQ6vju4mZ02+tGXqp5p5WVWxmCIoDZeudKBt+ARel
	OH81zRMkW2RPuEXdc1ipcXeiM09ZLh76bzRPoCMs6yOw3/snBWPlN2zpf1rsTplmfJB2+V
	0Us9N8WPjdN4xHfF/3MH37V4iWCFUhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729651378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctdBhoJoqhe2atqg/Y55XyUbRucmK/lbMKezvDNLgOc=;
	b=nUwA2jaVc83wW0tINF3Xw82v5R96XQrTrQcSKanfBGsYZwTCKGzhiXjwThKpSMhcVczMT+
	NMHIYPa7U6l6SPBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eeKndd2k;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nUwA2jaV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729651378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctdBhoJoqhe2atqg/Y55XyUbRucmK/lbMKezvDNLgOc=;
	b=eeKndd2k1+ZGs+JLXMFUO1Jto8wRSfQ6vju4mZ02+tGXqp5p5WVWxmCIoDZeudKBt+ARel
	OH81zRMkW2RPuEXdc1ipcXeiM09ZLh76bzRPoCMs6yOw3/snBWPlN2zpf1rsTplmfJB2+V
	0Us9N8WPjdN4xHfF/3MH37V4iWCFUhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729651378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctdBhoJoqhe2atqg/Y55XyUbRucmK/lbMKezvDNLgOc=;
	b=nUwA2jaVc83wW0tINF3Xw82v5R96XQrTrQcSKanfBGsYZwTCKGzhiXjwThKpSMhcVczMT+
	NMHIYPa7U6l6SPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CCC113A63;
	Wed, 23 Oct 2024 02:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2xLDELBiGGcvOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 23 Oct 2024 02:42:56 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/6] nfsd: return hard failure for OP_SETCLIENTID when there are too many clients.
Date: Wed, 23 Oct 2024 13:37:02 +1100
Message-ID: <20241023024222.691745-3-neilb@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023024222.691745-1-neilb@suse.de>
References: <20241023024222.691745-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A2BE81F83F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

If there are more non-courteous clients than the calculated limit, we
should fail the request rather than report a soft failure and
encouraging the client to retry indefinitely.

The only hard failure allowed for EXCHANGE_ID that doesn't clearly have
some other meaning is NFS4ERR_SERVERFAULT.  So use that, but explain why
in a comment at each place that it is returned.

If there are courteous clients which push us over the limit, then expedite
their removal.

This is not known to have caused a problem is production use, but
testing of lots of clients reports repeated NFS4ERR_DELAY responses
which doesn't seem helpful.

Also remove an outdated comment - we do use a slab cache.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 56b261608af4..ca6b5b52f77d 100644
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
+		return ERR_PTR(-EUSERS);
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
@@ -3121,8 +3120,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	struct dentry *dentries[ARRAY_SIZE(client_files)];
 
 	clp = alloc_client(name, nn);
-	if (clp == NULL)
-		return NULL;
+	if (IS_ERR_OR_NULL(clp))
+		return clp;
 
 	ret = copy_cred(&clp->cl_cred, &rqstp->rq_cred);
 	if (ret) {
@@ -3504,6 +3503,11 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	new = create_client(exid->clname, rqstp, &verf);
 	if (new == NULL)
 		return nfserr_jukebox;
+	if (IS_ERR(new))
+		/* Protocol has no specific error for "client limit reached".
+		 * NFS4ERR_RESOURCE is not permitted for EXCHANGE_ID
+		 */
+		return nfserr_serverfault;
 	status = copy_impl_id(new, exid);
 	if (status)
 		goto out_nolock;
@@ -4422,6 +4426,12 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	new = create_client(clname, rqstp, &clverifier);
 	if (new == NULL)
 		return nfserr_jukebox;
+	if (IS_ERR(new))
+		/* Protocol has no specific error for "client limit reached".
+		 * NFS4ERR_RESOURCE, while allowed for SETCLIENTID, implies
+		 * that a smaller COMPOUND might be successful.
+		 */
+		return nfserr_serverfault;
 	spin_lock(&nn->client_lock);
 	conf = find_confirmed_client_by_name(&clname, nn);
 	if (conf && client_has_state(conf)) {
-- 
2.46.0


