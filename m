Return-Path: <linux-nfs+bounces-5058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CF493CCB6
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 04:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460761F21881
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F161AACC;
	Fri, 26 Jul 2024 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GCQLaVLv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O3dyNFOO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GCQLaVLv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O3dyNFOO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F981320B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960783; cv=none; b=S5Gnr5ODB/elH1xPfExBmSIA5Ch0mTOgHtHTIlisrPfFuySY9Xlt3q7pxbRZKYygS5GtAXCmC9Yu9pCm+3gpu1D9aFRT1Tj4vBYblrVMXemDZCbalXAgIc41f/nFnjiSYqTVABzJLx25DHyrzBvq0Ufz+hQGBsjNBylb4UomKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960783; c=relaxed/simple;
	bh=oKeEYNTeIiUr+CnYWyzvAy2bPWiK+BTudtJZks5zseE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pk0Ng5lG1rhVnRZDcu2GngbJC07EZNMIUKm1HEBxwaK1bDdxwc/FsIO80U5pOTBywD+YFswJyXVCmnTh9M1Ae4YPh5NKJ3Y6S+kLY5Qli24qr+TT5P+45YcAQBk60w24jjcxPCVIpQ/h4l4EgDnDkIQjjVXjhFQpfqqWrqSRFdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GCQLaVLv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O3dyNFOO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GCQLaVLv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O3dyNFOO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81E5D218CE;
	Fri, 26 Jul 2024 02:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42ueM8I1IdmeN0YkaoHIzfqIeXG64gVPDJ9NM4swI7A=;
	b=GCQLaVLvP9PRZ4LTnTChT23nC8KQoVP5w6Tl2XYkdo0a9qca+zrtunfPDIhqpXREzwgwx2
	dYaTfThxL+D/JJ6Lq13/ZxmEJrnLyI2DIi+T5EUJXXHBHD0TV/NdVCYxFToRFKYLvaUUPl
	yJrRapRT961+MmRyVFZ7rkmMpvDX7DA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42ueM8I1IdmeN0YkaoHIzfqIeXG64gVPDJ9NM4swI7A=;
	b=O3dyNFOOkEfXSE8fcQplubUtu/u26O9aLgjMZPhWXYWo4kIAs1qJqYCBi9H6MJzAkNrGZR
	5Pp3NHcjjdFT+vCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GCQLaVLv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O3dyNFOO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42ueM8I1IdmeN0YkaoHIzfqIeXG64gVPDJ9NM4swI7A=;
	b=GCQLaVLvP9PRZ4LTnTChT23nC8KQoVP5w6Tl2XYkdo0a9qca+zrtunfPDIhqpXREzwgwx2
	dYaTfThxL+D/JJ6Lq13/ZxmEJrnLyI2DIi+T5EUJXXHBHD0TV/NdVCYxFToRFKYLvaUUPl
	yJrRapRT961+MmRyVFZ7rkmMpvDX7DA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42ueM8I1IdmeN0YkaoHIzfqIeXG64gVPDJ9NM4swI7A=;
	b=O3dyNFOOkEfXSE8fcQplubUtu/u26O9aLgjMZPhWXYWo4kIAs1qJqYCBi9H6MJzAkNrGZR
	5Pp3NHcjjdFT+vCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65E6E138A7;
	Fri, 26 Jul 2024 02:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vMEaB0oJo2a5WAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Jul 2024 02:26:18 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/6] nfsd: use nfsd_v4client() in nfsd_breaker_owns_lease()
Date: Fri, 26 Jul 2024 12:21:33 +1000
Message-ID: <20240726022538.32076-5-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240726022538.32076-1-neilb@suse.de>
References: <20240726022538.32076-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 81E5D218CE
X-Spam-Score: -4.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]

nfsd_breaker_owns_lease() current open-codes the same test that
nfsd_v4client() performs.

With this patch we use nfsd_v4client() instead.

Also as i_am_nfsd() is only used in combination with kthread_data(),
replace it with nfsd_current_rqst() which combines the two and returns a
valid svc_rqst, or NULL.

The test for NULL is moved into nfsd_v4client() for code clarity.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 7 ++-----
 fs/nfsd/nfsd.h      | 4 ++--
 fs/nfsd/nfssvc.c    | 6 ++++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index eadb7d1a7f13..c2edd8a21bd4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5274,11 +5274,8 @@ static bool nfsd_breaker_owns_lease(struct file_lease *fl)
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
-	if (!i_am_nfsd())
-		return false;
-	rqst = kthread_data(current);
-	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
-	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
+	rqst = nfsd_current_rqst();
+	if (!nfsd_v4client(rqst))
 		return false;
 	clp = *(rqst->rq_lease_breaker);
 	return dl->dl_stid.sc_client == clp;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 0f499066aa72..e6626b22ab17 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -114,7 +114,7 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-bool		i_am_nfsd(void);
+struct svc_rqst *nfsd_current_rqst(void);
 
 struct nfsdfs_client {
 	struct kref cl_ref;
@@ -155,7 +155,7 @@ extern int nfsd_max_blksize;
 
 static inline int nfsd_v4client(struct svc_rqst *rq)
 {
-	return rq->rq_prog == NFS_PROGRAM && rq->rq_vers == 4;
+	return rq && rq->rq_prog == NFS_PROGRAM && rq->rq_vers == 4;
 }
 static inline struct user_namespace *
 nfsd_user_namespace(const struct svc_rqst *rqstp)
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 89d7918de7b1..f6ce51eb232e 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -642,9 +642,11 @@ void nfsd_shutdown_threads(struct net *net)
 	mutex_unlock(&nfsd_mutex);
 }
 
-bool i_am_nfsd(void)
+struct svc_rqst *nfsd_current_rqst(void)
 {
-	return kthread_func(current) == nfsd;
+	if (kthread_func(current) == nfsd)
+		return kthread_data(current);
+	return NULL;
 }
 
 int nfsd_create_serv(struct net *net)
-- 
2.44.0


