Return-Path: <linux-nfs+bounces-7378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD059ABBB8
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 04:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907C62837E0
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 02:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA6443AB9;
	Wed, 23 Oct 2024 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iJ7+22FU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FbIEeER9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iJ7+22FU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FbIEeER9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A4847B
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 02:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651393; cv=none; b=uYuPU4WrhmH+LQ/CJefo7uzVPZ1WYLLTNgahsXjFMpM0FXnrQ8QPtKWthWqzeqRmAqbLsaa9SEyhzkT8v0bEpMeQvzb3tfqhpnwhyJVi/BXafNLyEg8XzoRZSClcVoxtmA2fkM5dzNxJHchMn8wzKjcBiHFdJZ6BtRu16HYJFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651393; c=relaxed/simple;
	bh=Hf2lh8gPchUA5ZuvI1/v/TQLy/uYvyGzWfS9HUwsxyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRxmXRQkrGejxwMkpXru1C3pd/W1UVVC6u22Y8IUgV04Haw3JgT8K4kdxEUtR2DCLnMT+ECtjeVXac7r+AXy2H3TYuwMWdDWgmD0/25JMUFzO7R9oHOtVvRvEVHzw+QlHauj9qohZ55PdfwzwB516YAe7N/FE55fTf6QCTglkgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iJ7+22FU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FbIEeER9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iJ7+22FU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FbIEeER9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBB101F83F;
	Wed, 23 Oct 2024 02:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729651389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7q8pw9d8BhjkTU/EPZvKyv6t8TQLrHQQsLfVtRA+Gg=;
	b=iJ7+22FURCfaW0F3KbtmWOsrV/8QIvNc46VHTwuAwf9Ia1pdt0N+XlIzp1pOhWXuYl2RAT
	fKveVhzDqqQF3iVPOBcP8yJA+2zLzyKl3EnXMmZZioayHblQ+0OWJDRpoREgc3kPlvTg0V
	Qj2vNoBvXzX9sPQjk4i8aJIuN2V+2tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729651389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7q8pw9d8BhjkTU/EPZvKyv6t8TQLrHQQsLfVtRA+Gg=;
	b=FbIEeER96lXfj/ZWUq70W9QMhZeLDjuoR88EvlPNcGLGqi68pmgXPybgqUTHEwUUmxM4vX
	/oqWbc06+MsotjAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729651389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7q8pw9d8BhjkTU/EPZvKyv6t8TQLrHQQsLfVtRA+Gg=;
	b=iJ7+22FURCfaW0F3KbtmWOsrV/8QIvNc46VHTwuAwf9Ia1pdt0N+XlIzp1pOhWXuYl2RAT
	fKveVhzDqqQF3iVPOBcP8yJA+2zLzyKl3EnXMmZZioayHblQ+0OWJDRpoREgc3kPlvTg0V
	Qj2vNoBvXzX9sPQjk4i8aJIuN2V+2tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729651389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7q8pw9d8BhjkTU/EPZvKyv6t8TQLrHQQsLfVtRA+Gg=;
	b=FbIEeER96lXfj/ZWUq70W9QMhZeLDjuoR88EvlPNcGLGqi68pmgXPybgqUTHEwUUmxM4vX
	/oqWbc06+MsotjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B47CF13A63;
	Wed, 23 Oct 2024 02:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id POd1GrtiGGc+OgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 23 Oct 2024 02:43:07 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/6] nfsd: don't use sv_nrthreads in connection limiting calculations.
Date: Wed, 23 Oct 2024 13:37:04 +1100
Message-ID: <20241023024222.691745-5-neilb@suse.de>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The heuristic for limiting the number of incoming connections to nfsd
currently uses sv_nrthreads - allowing more connections if more threads
were configured.

A future patch will allow number of threads to grow dynamically so that
there will be no need to configure sv_nrthreads.  So we need a different
solution for limiting connections.

It isn't clear what problem is solved by limiting connections (as
mentioned in a code comment) but the most likely problem is a connection
storm - many connections that are not doing productive work.  These will
be closed after about 6 minutes already but it might help to slow down a
storm.

This patch adds a per-connection flag XPT_PEER_VALID which indicates
that the peer has presented a filehandle for which it has some sort of
access.  i.e the peer is known to be trusted in some way.  We now only
count connections which have NOT been determined to be valid.  There
should be relative few of these at any given time.

If the number of non-validated peer exceed a limit - currently 64 - we
close the oldest non-validated peer to avoid having too many of these
useless connections.

Note that this patch significantly changes the meaning of the various
configuration parameters for "max connections".  The next patch will
remove all of these.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/callback.c               |  4 ----
 fs/nfs/callback_xdr.c           |  1 +
 fs/nfsd/netns.h                 |  4 ++--
 fs/nfsd/nfsfh.c                 |  2 ++
 include/linux/sunrpc/svc.h      |  2 +-
 include/linux/sunrpc/svc_xprt.h | 15 +++++++++++++++
 net/sunrpc/svc_xprt.c           | 33 +++++++++++++++++----------------
 7 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 6cf92498a5ac..86bdc7d23fb9 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -211,10 +211,6 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 		return ERR_PTR(-ENOMEM);
 	}
 	cb_info->serv = serv;
-	/* As there is only one thread we need to over-ride the
-	 * default maximum of 80 connections
-	 */
-	serv->sv_maxconn = 1024;
 	dprintk("nfs_callback_create_svc: service created\n");
 	return serv;
 }
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index fdeb0b34a3d3..4254ba3ee7c5 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -984,6 +984,7 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 			nfs_put_client(cps.clp);
 			goto out_invalidcred;
 		}
+		svc_xprt_set_valid(rqstp->rq_xprt);
 	}
 
 	cps.minorversion = hdr_arg.minorversion;
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 26f7b34d1a03..a05a45bb1978 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -129,8 +129,8 @@ struct nfsd_net {
 	unsigned char writeverf[8];
 
 	/*
-	 * Max number of connections this nfsd container will allow. Defaults
-	 * to '0' which is means that it bases this on the number of threads.
+	 * Max number of non-validated connections this nfsd container
+	 * will allow.  Defaults to '0' gets mapped to 64.
 	 */
 	unsigned int max_connections;
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 40ad58a6a036..2f44de99f709 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -383,6 +383,8 @@ __fh_verify(struct svc_rqst *rqstp,
 		goto out;
 
 skip_pseudoflavor_check:
+	svc_xprt_set_valid(rqstp->rq_xprt);
+
 	/* Finally, check access permissions. */
 	error = nfsd_permission(cred, exp, dentry, access);
 out:
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e68fecf6eab5..617ebfff2f30 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -81,7 +81,7 @@ struct svc_serv {
 	unsigned int		sv_xdrsize;	/* XDR buffer size */
 	struct list_head	sv_permsocks;	/* all permanent sockets */
 	struct list_head	sv_tempsocks;	/* all temporary sockets */
-	int			sv_tmpcnt;	/* count of temporary sockets */
+	int			sv_tmpcnt;	/* count of temporary "valid" sockets */
 	struct timer_list	sv_temptimer;	/* timer for aging temporary sockets */
 
 	char *			sv_name;	/* service name */
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 0981e35a9fed..35929a7727c7 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -99,8 +99,23 @@ enum {
 	XPT_HANDSHAKE,		/* xprt requests a handshake */
 	XPT_TLS_SESSION,	/* transport-layer security established */
 	XPT_PEER_AUTH,		/* peer has been authenticated */
+	XPT_PEER_VALID,		/* peer has presented a filehandle that
+				 * it has access to.  It is NOT counted
+				 * in ->sv_tmpcnt.
+				 */
 };
 
+static inline void svc_xprt_set_valid(struct svc_xprt *xpt)
+{
+	if (test_bit(XPT_TEMP, &xpt->xpt_flags) &&
+	    !test_and_set_bit(XPT_PEER_VALID, &xpt->xpt_flags)) {
+		struct svc_serv *serv = xpt->xpt_server;
+		spin_lock(&serv->sv_lock);
+		serv->sv_tmpcnt -= 1;
+		spin_unlock(&serv->sv_lock);
+	}
+}
+
 static inline void unregister_xpt_user(struct svc_xprt *xpt, struct svc_xpt_user *u)
 {
 	spin_lock(&xpt->xpt_lock);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 43c57124de52..ff5b8bb8a88f 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -606,7 +606,8 @@ int svc_port_is_privileged(struct sockaddr *sin)
 }
 
 /*
- * Make sure that we don't have too many active connections. If we have,
+ * Make sure that we don't have too many connections that have not yet
+ * demonstrated that they have access the the NFS server. If we have,
  * something must be dropped. It's not clear what will happen if we allow
  * "too many" connections, but when dealing with network-facing software,
  * we have to code defensively. Here we do that by imposing hard limits.
@@ -625,27 +626,26 @@ int svc_port_is_privileged(struct sockaddr *sin)
  */
 static void svc_check_conn_limits(struct svc_serv *serv)
 {
-	unsigned int limit = serv->sv_maxconn ? serv->sv_maxconn :
-				(serv->sv_nrthreads+3) * 20;
+	unsigned int limit = serv->sv_maxconn ? serv->sv_maxconn : 64;
 
 	if (serv->sv_tmpcnt > limit) {
-		struct svc_xprt *xprt = NULL;
+		struct svc_xprt *xprt = NULL, *xprti;
 		spin_lock_bh(&serv->sv_lock);
 		if (!list_empty(&serv->sv_tempsocks)) {
-			/* Try to help the admin */
-			net_notice_ratelimited("%s: too many open connections, consider increasing the %s\n",
-					       serv->sv_name, serv->sv_maxconn ?
-					       "max number of connections" :
-					       "number of threads");
 			/*
 			 * Always select the oldest connection. It's not fair,
-			 * but so is life
+			 * but nor is life.
 			 */
-			xprt = list_entry(serv->sv_tempsocks.prev,
-					  struct svc_xprt,
-					  xpt_list);
-			set_bit(XPT_CLOSE, &xprt->xpt_flags);
-			svc_xprt_get(xprt);
+			list_for_each_entry_reverse(xprti, &serv->sv_tempsocks,
+						    xpt_list)
+			{
+				if (!test_bit(XPT_PEER_VALID, &xprti->xpt_flags)) {
+					xprt = xprti;
+					set_bit(XPT_CLOSE, &xprt->xpt_flags);
+					svc_xprt_get(xprt);
+					break;
+				}
+			}
 		}
 		spin_unlock_bh(&serv->sv_lock);
 
@@ -1039,7 +1039,8 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 
 	spin_lock_bh(&serv->sv_lock);
 	list_del_init(&xprt->xpt_list);
-	if (test_bit(XPT_TEMP, &xprt->xpt_flags))
+	if (test_bit(XPT_TEMP, &xprt->xpt_flags) &&
+	    !test_bit(XPT_PEER_VALID, &xprt->xpt_flags))
 		serv->sv_tmpcnt--;
 	spin_unlock_bh(&serv->sv_lock);
 
-- 
2.46.0


