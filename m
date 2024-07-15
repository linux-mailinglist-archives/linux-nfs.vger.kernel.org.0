Return-Path: <linux-nfs+bounces-4903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D898930F21
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DAB1C2096E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04937175A6;
	Mon, 15 Jul 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ecAYK8b6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="73NlEOng";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ecAYK8b6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="73NlEOng"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200106AB8
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029746; cv=none; b=SEmMq6WmA/xrZauC0ckWHXMdoD3YzbP2grWtY41JCTzAGEAEldPR84kiW4whIGeBiZI064/sGaGeUdyvuergzO/svuRQEMSxdDNUA3fXzEtJYV8aVRrw3lmQjUzUqMzdIMWmAGRAvzNCRkHW2ojPzPwLmfpc1wIm28VrmEbADcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029746; c=relaxed/simple;
	bh=Q2cqC3RFZVLQ6NR9srwocSyY/7b/4/ZMMSJrqV6q5Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSldMSuFXDp9LpKY44X1gSAu2naWZIyTlogATcw/QbrmddmkVSWJrSPca0ZoMvI2zelIXfb4Pe9Q+05nk2BSfHYs7/7WvGf0C0rPE7XF68P5Hk0aS8kFYrHOcs+UkIMtocalBm2C5kUu1w9P7III3p4sC+pDQwQqam26+TkYCl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ecAYK8b6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=73NlEOng; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ecAYK8b6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=73NlEOng; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A7DF1F808;
	Mon, 15 Jul 2024 07:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/oi/OgRxfQdh5wWF4wVViRTlYMjE++WKv4N6DBP0wk=;
	b=ecAYK8b6CpmLH72orMCfPb9XJR2VA4wNu5IbSPG4xbWDbZs22AJW6sB5djntTMuf0skVPF
	OTSnD41Urnzl+7K02h/oCHPGV3dU2oV8XdvifSxSuYQdL2tM5F1is+xV6N1AuG3Mgl+1SE
	dSejjCMxQrjjbIalBrqy5Bjc6eQ6qOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/oi/OgRxfQdh5wWF4wVViRTlYMjE++WKv4N6DBP0wk=;
	b=73NlEOng1rcsEkNWvxeShU58KepQt/tyM4tk7pFma0p2Hw9Zn4O2Fdzj26JIPf9O8W4lXM
	a9qgCx7xSu9O89CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ecAYK8b6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=73NlEOng
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/oi/OgRxfQdh5wWF4wVViRTlYMjE++WKv4N6DBP0wk=;
	b=ecAYK8b6CpmLH72orMCfPb9XJR2VA4wNu5IbSPG4xbWDbZs22AJW6sB5djntTMuf0skVPF
	OTSnD41Urnzl+7K02h/oCHPGV3dU2oV8XdvifSxSuYQdL2tM5F1is+xV6N1AuG3Mgl+1SE
	dSejjCMxQrjjbIalBrqy5Bjc6eQ6qOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/oi/OgRxfQdh5wWF4wVViRTlYMjE++WKv4N6DBP0wk=;
	b=73NlEOng1rcsEkNWvxeShU58KepQt/tyM4tk7pFma0p2Hw9Zn4O2Fdzj26JIPf9O8W4lXM
	a9qgCx7xSu9O89CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D17E6137EB;
	Mon, 15 Jul 2024 07:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5OuSIWzUlGY9bgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:49:00 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 11/14] nfsd: don't use sv_nrthreads in connection limiting calculations.
Date: Mon, 15 Jul 2024 17:14:24 +1000
Message-ID: <20240715074657.18174-12-neilb@suse.de>
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
X-Rspamd-Queue-Id: 3A7DF1F808
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
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

The heuristic for limiting the number of incoming connections to nfsd
currently uses sv_nrthreads - allowing more connections if more threads
were configured.

A future patch will allow number of threads to grow dynamically so that
there is no need to configure sv_nrthreads.  So we need a different
solution for limiting connections.

It isn't clear what problem is solved by limiting connections (as
mentioned in a code comment) but the most likely problem is a connection
storm - many connections that are not doing productive work.  These will
be closed after about 6 minutes already but it might help to slow down a
storm.

This patch add a per-connection flag XPT_PEER_VALID which indicates
that the peer has presented a filehandle for which it has some sort of
access.  i.e the peer is known to be trusted in some way.  We now only
count connections which have NOT be determined to be valid.  There
should be relative few of these at any given time.

If the number of non-validated peer exceed as limit - currently 64 - we
close the oldest non-validated peer to avoid having too many of these
useless connections.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/netns.h                 |  4 ++--
 fs/nfsd/nfsfh.c                 |  8 ++++++++
 include/linux/sunrpc/svc.h      |  2 +-
 include/linux/sunrpc/svc_xprt.h |  4 ++++
 net/sunrpc/svc_xprt.c           | 33 +++++++++++++++++----------------
 5 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 238fc4e56e53..0d2ac15a5003 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -128,8 +128,8 @@ struct nfsd_net {
 	unsigned char writeverf[8];
 
 	/*
-	 * Max number of connections this nfsd container will allow. Defaults
-	 * to '0' which is means that it bases this on the number of threads.
+	 * Max number of non-validated connections this nfsd container
+	 * will allow.  Defaults to '0' gets mapped to 64.
 	 */
 	unsigned int max_connections;
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 0b75305fb5f5..08742bf8de02 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -391,6 +391,14 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 		goto out;
 
 skip_pseudoflavor_check:
+	if (test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags) &&
+	    !test_and_set_bit(XPT_PEER_VALID, &rqstp->rq_xprt->xpt_flags)) {
+		struct svc_serv *serv = rqstp->rq_server;
+		spin_lock(&serv->sv_lock);
+		serv->sv_tmpcnt -= 1;
+		spin_unlock(&serv->sv_lock);
+	}
+
 	/* Finally, check access permissions. */
 	error = nfsd_permission(rqstp, exp, dentry, access);
 out:
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 99e9345d829e..0b414af448e0 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -79,7 +79,7 @@ struct svc_serv {
 	unsigned int		sv_xdrsize;	/* XDR buffer size */
 	struct list_head	sv_permsocks;	/* all permanent sockets */
 	struct list_head	sv_tempsocks;	/* all temporary sockets */
-	int			sv_tmpcnt;	/* count of temporary sockets */
+	int			sv_tmpcnt;	/* count of temporary "valid" sockets */
 	struct timer_list	sv_temptimer;	/* timer for aging temporary sockets */
 
 	char *			sv_name;	/* service name */
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 0981e35a9fed..92565133b3b6 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -99,6 +99,10 @@ enum {
 	XPT_HANDSHAKE,		/* xprt requests a handshake */
 	XPT_TLS_SESSION,	/* transport-layer security established */
 	XPT_PEER_AUTH,		/* peer has been authenticated */
+	XPT_PEER_VALID,		/* peer has presented a filehandle that
+				 * it has access to.  It is NOT counted
+				 * in ->sv_tmpcnt.
+				 */
 };
 
 static inline void unregister_xpt_user(struct svc_xprt *xpt, struct svc_xpt_user *u)
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 53ebc719ff5a..a9215e1a2f38 100644
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
2.44.0


