Return-Path: <linux-nfs+bounces-4210-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC8911A2E
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 07:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB09282273
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 05:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1031712D1EA;
	Fri, 21 Jun 2024 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0TakkWfx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xOfTaiaL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tI+zpjF2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OVmvkBC9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EC86AFA
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 05:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946685; cv=none; b=fq5J5ocBjbiuf/+OPY9/I/xGhWf4pP6jU423d4t008FUwnmfwWQ8TmhQKwajECFqq1bDoQx56sA18kGPSHiSs6enJEudcN3l1p1H8zGB0o1xai4DB0T7mKo3usDGsUgBnbICWPkVniz3ABOKJKVsy2Q7slFyEMCKine9gkrVrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946685; c=relaxed/simple;
	bh=er5HP2hv5qLOKNvpCdTD/MfGAX3HHDlhj3qTkHi9xDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWDsbLIoh2cJmZLWM1GoeptJK9wvxcsGQ8/lri2u50HCfc1eF7uanhpCPDPolJ2LdWFbIojJBe3wJvGk/AmUcxqjjqpk3qhGKB3i/T4/OPnuVhiZ4UeInuObWxgN3kE+BqQTUyc0GFpey1l3ctyJSZxmdnE4elGa2A/C2NARFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0TakkWfx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xOfTaiaL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tI+zpjF2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OVmvkBC9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B48BB1FB3B;
	Fri, 21 Jun 2024 05:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718946681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHXtQbrASkFWpPDXYtWoW3m48BU+NN+MmPcbgKNKTGk=;
	b=0TakkWfxsmF6GLExg3lJKHi7pXwI7g6VdVwJE3mfAyq+qwt8wAqTL96qvstZaGUlTEHKLz
	TSsuHQ2H28cQMi3nolP7HcFe2a3sl7zUm5PzWstwv3kAkLZ6/aIVmfOyjLLgR1DPn/3LFh
	OvGcPyxpCOwImn7o9gQsPHKoylzS3Qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718946681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHXtQbrASkFWpPDXYtWoW3m48BU+NN+MmPcbgKNKTGk=;
	b=xOfTaiaLJA3IkGtowHHlIOtvIQ4CIuOeFLpzLsmT44P8+mdHeOHF2TdmfTnqKBVAux4OZA
	oRINbTvCsKYmJwAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tI+zpjF2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OVmvkBC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718946679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHXtQbrASkFWpPDXYtWoW3m48BU+NN+MmPcbgKNKTGk=;
	b=tI+zpjF2C/Lwf02sx3JGxfiow984OMUxdBhvRsU2x2boJ71xKIuIdmb+OlV/YfqjdGsTpn
	yZnYQ2ka73mu7tHXbj0bimMfwLGVtOnzyXXembolgDLPqoe5VSu0qokoBd+gpvsyC06svG
	e2sf3aBpr2uM9bIsJ1PQScXADvlBYTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718946679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHXtQbrASkFWpPDXYtWoW3m48BU+NN+MmPcbgKNKTGk=;
	b=OVmvkBC9K1uKnhyjgUeQnkGcd2GZF6AzTMQVpwb1ywjr1xxu4ot82o3oZlwCB2F1zWIQdD
	9JiCI6QouUk72MBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E39C13AAA;
	Fri, 21 Jun 2024 05:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RtIALXQLdWb7agAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 21 Jun 2024 05:11:16 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH 3/3] SUNRPC: replace program list with program array
Date: Fri, 21 Jun 2024 14:59:30 +1000
Message-ID: <20240621050857.20075-4-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240621050857.20075-1-neilb@suse.de>
References: <20240621050857.20075-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,brown.name:email,suse.de:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B48BB1FB3B
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

From: NeilBrown <neil@brown.name>

A service created with svc_create_pooled() can be given a linked list of
programs and all of these will be served.

Using a linked list makes is cumbersome when there a several programs
that can be optionally selection with CONFIG settings.

So change to use an array with explicit size.  svc_create() is always
passed a single program.  svc_create_pooled() now must be used for
multiple programs.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfsctl.c           |  2 +-
 fs/nfsd/nfsd.h             |  2 +-
 fs/nfsd/nfssvc.c           | 69 ++++++++++++++++++--------------------
 include/linux/sunrpc/svc.h |  7 ++--
 net/sunrpc/svc.c           | 68 +++++++++++++++++++++----------------
 net/sunrpc/svc_xprt.c      |  2 +-
 net/sunrpc/svcauth_unix.c  |  3 +-
 7 files changed, 80 insertions(+), 73 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e5d2cc74ef77..6fb92bb61c6d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2265,7 +2265,7 @@ static __net_init int nfsd_net_init(struct net *net)
 	if (retval)
 		goto out_repcache_error;
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
-	nn->nfsd_svcstats.program = &nfsd_program;
+	nn->nfsd_svcstats.program = &nfsd_programs[0];
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index cec8697b1cd6..c3f7c5957950 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -80,7 +80,7 @@ struct nfsd_genl_rqstp {
 	u32			rq_opnum[NFSD_MAX_OPS_PER_COMPOUND];
 };
 
-extern struct svc_program	nfsd_program;
+extern struct svc_program	nfsd_programs[];
 extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;
 extern spinlock_t		nfsd_drc_lock;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index bc69a2c90077..1df9e18c510b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -36,7 +36,6 @@
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
 atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
-extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static int			nfsd_acl_rpcbind_set(struct net *,
@@ -89,16 +88,6 @@ static const struct svc_version *nfsd_localio_version[] = {
 
 #define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(nfsd_localio_version)
 
-static struct svc_program	nfsd_localio_program = {
-	.pg_prog		= NFS_LOCALIO_PROGRAM,
-	.pg_nvers		= NFSD_LOCALIO_NRVERS,
-	.pg_vers		= nfsd_localio_version,
-	.pg_name		= "nfslocalio",
-	.pg_class		= "nfsd",
-	.pg_authenticate	= &svc_set_client,
-	.pg_init_request	= svc_generic_init_request,
-	.pg_rpcbind_set		= svc_generic_rpcbind_set,
-};
 #endif /* CONFIG_NFSD_LOCALIO */
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
@@ -111,23 +100,9 @@ static const struct svc_version *nfsd_acl_version[] = {
 # endif
 };
 
-#define NFSD_ACL_MINVERS            2
+#define NFSD_ACL_MINVERS	2
 #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
 
-static struct svc_program	nfsd_acl_program = {
-#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
-	.pg_next		= &nfsd_localio_program,
-#endif /* CONFIG_NFSD_LOCALIO */
-	.pg_prog		= NFS_ACL_PROGRAM,
-	.pg_nvers		= NFSD_ACL_NRVERS,
-	.pg_vers		= nfsd_acl_version,
-	.pg_name		= "nfsacl",
-	.pg_class		= "nfsd",
-	.pg_authenticate	= &svc_set_client,
-	.pg_init_request	= nfsd_acl_init_request,
-	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
-};
-
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
 
 static const struct svc_version *nfsd_version[] = {
@@ -140,25 +115,44 @@ static const struct svc_version *nfsd_version[] = {
 #endif
 };
 
-#define NFSD_MINVERS    	2
+#define NFSD_MINVERS		2
 #define NFSD_NRVERS		ARRAY_SIZE(nfsd_version)
 
-struct svc_program		nfsd_program = {
-#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
-	.pg_next		= &nfsd_acl_program,
-#else
-#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
-	.pg_next		= &nfsd_localio_program,
-#endif /* CONFIG_NFSD_LOCALIO */
-#endif
+struct svc_program		nfsd_programs[] = {
+	{
 	.pg_prog		= NFS_PROGRAM,		/* program number */
 	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
 	.pg_vers		= nfsd_version,		/* version table */
 	.pg_name		= "nfsd",		/* program name */
 	.pg_class		= "nfsd",		/* authentication class */
-	.pg_authenticate	= &svc_set_client,	/* export authentication */
+	.pg_authenticate	= svc_set_client,	/* export authentication */
 	.pg_init_request	= nfsd_init_request,
 	.pg_rpcbind_set		= nfsd_rpcbind_set,
+	},
+#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
+	{
+	.pg_prog		= NFS_ACL_PROGRAM,
+	.pg_nvers		= NFSD_ACL_NRVERS,
+	.pg_vers		= nfsd_acl_version,
+	.pg_name		= "nfsacl",
+	.pg_class		= "nfsd",
+	.pg_authenticate	= svc_set_client,
+	.pg_init_request	= nfsd_acl_init_request,
+	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
+	},
+#endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	{
+	.pg_prog		= NFS_LOCALIO_PROGRAM,
+	.pg_nvers		= NFSD_LOCALIO_NRVERS,
+	.pg_vers		= nfsd_localio_version,
+	.pg_name		= "nfslocalio",
+	.pg_class		= "nfsd",
+	.pg_authenticate	= svc_set_client,
+	.pg_init_request	= svc_generic_init_request,
+	.pg_rpcbind_set		= svc_generic_rpcbind_set,
+	}
+#endif /* IS_ENABLED(CONFIG_NFSD_LOCALIO) */
 };
 
 bool nfsd_support_version(int vers)
@@ -696,7 +690,8 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
+	serv = svc_create_pooled(nfsd_programs, ARRAY_SIZE(nfsd_programs),
+				 &nn->nfsd_svcstats,
 				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index a7d0406b9ef5..7c86b1696398 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -66,9 +66,10 @@ enum {
  * We currently do not support more than one RPC program per daemon.
  */
 struct svc_serv {
-	struct svc_program *	sv_program;	/* RPC program */
+	struct svc_program *	sv_programs;	/* RPC programs */
 	struct svc_stat *	sv_stats;	/* RPC statistics */
 	spinlock_t		sv_lock;
+	unsigned int		sv_nprogs;	/* Number of sv_programs */
 	unsigned int		sv_nrthreads;	/* # of server threads */
 	unsigned int		sv_maxconn;	/* max connections allowed or
 						 * '0' causing max to be based
@@ -329,10 +330,9 @@ struct svc_process_info {
 };
 
 /*
- * List of RPC programs on the same transport endpoint
+ * RPC program - an array of these can use the same transport endpoint
  */
 struct svc_program {
-	struct svc_program *	pg_next;	/* other programs (same xprt) */
 	u32			pg_prog;	/* program number */
 	unsigned int		pg_lovers;	/* lowest version */
 	unsigned int		pg_hivers;	/* highest version */
@@ -414,6 +414,7 @@ void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *prog,
+				     unsigned int nprog,
 				     struct svc_stat *stats,
 				     unsigned int bufsize,
 				     int (*threadfn)(void *data));
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 965a27806bfd..d9f348aa0672 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -440,10 +440,11 @@ EXPORT_SYMBOL_GPL(svc_rpcb_cleanup);
 
 static int svc_uses_rpcbind(struct svc_serv *serv)
 {
-	struct svc_program	*progp;
-	unsigned int		i;
+	unsigned int		p, i;
+
+	for (p = 0; p < serv->sv_nprogs; p++) {
+		struct svc_program *progp = &serv->sv_programs[p];
 
-	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
 		for (i = 0; i < progp->pg_nvers; i++) {
 			if (progp->pg_vers[i] == NULL)
 				continue;
@@ -480,7 +481,7 @@ __svc_init_bc(struct svc_serv *serv)
  * Create an RPC service
  */
 static struct svc_serv *
-__svc_create(struct svc_program *prog, struct svc_stat *stats,
+__svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stats,
 	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
 {
 	struct svc_serv	*serv;
@@ -491,7 +492,8 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
 	if (!(serv = kzalloc(sizeof(*serv), GFP_KERNEL)))
 		return NULL;
 	serv->sv_name      = prog->pg_name;
-	serv->sv_program   = prog;
+	serv->sv_programs  = prog;
+	serv->sv_nprogs    = nprogs;
 	serv->sv_stats     = stats;
 	if (bufsize > RPCSVC_MAXPAYLOAD)
 		bufsize = RPCSVC_MAXPAYLOAD;
@@ -499,17 +501,18 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
 	serv->sv_max_mesg  = roundup(serv->sv_max_payload + PAGE_SIZE, PAGE_SIZE);
 	serv->sv_threadfn = threadfn;
 	xdrsize = 0;
-	while (prog) {
-		prog->pg_lovers = prog->pg_nvers-1;
-		for (vers=0; vers<prog->pg_nvers ; vers++)
-			if (prog->pg_vers[vers]) {
-				prog->pg_hivers = vers;
-				if (prog->pg_lovers > vers)
-					prog->pg_lovers = vers;
-				if (prog->pg_vers[vers]->vs_xdrsize > xdrsize)
-					xdrsize = prog->pg_vers[vers]->vs_xdrsize;
+	for (i = 0; i < nprogs; i++) {
+		struct svc_program *progp = &prog[i];
+
+		progp->pg_lovers = progp->pg_nvers-1;
+		for (vers = 0; vers < progp->pg_nvers ; vers++)
+			if (progp->pg_vers[vers]) {
+				progp->pg_hivers = vers;
+				if (progp->pg_lovers > vers)
+					progp->pg_lovers = vers;
+				if (progp->pg_vers[vers]->vs_xdrsize > xdrsize)
+					xdrsize = progp->pg_vers[vers]->vs_xdrsize;
 			}
-		prog = prog->pg_next;
 	}
 	serv->sv_xdrsize   = xdrsize;
 	INIT_LIST_HEAD(&serv->sv_tempsocks);
@@ -558,13 +561,14 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
 struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
 			    int (*threadfn)(void *data))
 {
-	return __svc_create(prog, NULL, bufsize, 1, threadfn);
+	return __svc_create(prog, 1, NULL, bufsize, 1, threadfn);
 }
 EXPORT_SYMBOL_GPL(svc_create);
 
 /**
  * svc_create_pooled - Create an RPC service with pooled threads
- * @prog: the RPC program the new service will handle
+ * @prog:  Array of RPC programs the new service will handle
+ * @nprogs: Number of programs in the array
  * @stats: the stats struct if desired
  * @bufsize: maximum message size for @prog
  * @threadfn: a function to service RPC requests for @prog
@@ -572,6 +576,7 @@ EXPORT_SYMBOL_GPL(svc_create);
  * Returns an instantiated struct svc_serv object or NULL.
  */
 struct svc_serv *svc_create_pooled(struct svc_program *prog,
+				   unsigned int nprogs,
 				   struct svc_stat *stats,
 				   unsigned int bufsize,
 				   int (*threadfn)(void *data))
@@ -579,7 +584,7 @@ struct svc_serv *svc_create_pooled(struct svc_program *prog,
 	struct svc_serv *serv;
 	unsigned int npools = svc_pool_map_get();
 
-	serv = __svc_create(prog, stats, bufsize, npools, threadfn);
+	serv = __svc_create(prog, nprogs, stats, bufsize, npools, threadfn);
 	if (!serv)
 		goto out_err;
 	serv->sv_is_pooled = true;
@@ -602,16 +607,16 @@ svc_destroy(struct svc_serv **servp)
 
 	*servp = NULL;
 
-	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
+	dprintk("svc: svc_destroy(%s)\n", serv->sv_programs->pg_name);
 	timer_shutdown_sync(&serv->sv_temptimer);
 
 	/*
 	 * Remaining transports at this point are not expected.
 	 */
 	WARN_ONCE(!list_empty(&serv->sv_permsocks),
-		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
+		  "SVC: permsocks remain for %s\n", serv->sv_programs->pg_name);
 	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
-		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
+		  "SVC: tempsocks remain for %s\n", serv->sv_programs->pg_name);
 
 	cache_clean_deferred(serv);
 
@@ -1156,15 +1161,16 @@ int svc_register(const struct svc_serv *serv, struct net *net,
 		 const int family, const unsigned short proto,
 		 const unsigned short port)
 {
-	struct svc_program	*progp;
-	unsigned int		i;
+	unsigned int		p, i;
 	int			error = 0;
 
 	WARN_ON_ONCE(proto == 0 && port == 0);
 	if (proto == 0 && port == 0)
 		return -EINVAL;
 
-	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
+	for (p = 0; p < serv->sv_nprogs; p++) {
+		struct svc_program *progp = &serv->sv_programs[p];
+
 		for (i = 0; i < progp->pg_nvers; i++) {
 
 			error = progp->pg_rpcbind_set(net, progp, i,
@@ -1216,13 +1222,14 @@ static void __svc_unregister(struct net *net, const u32 program, const u32 versi
 static void svc_unregister(const struct svc_serv *serv, struct net *net)
 {
 	struct sighand_struct *sighand;
-	struct svc_program *progp;
 	unsigned long flags;
-	unsigned int i;
+	unsigned int p, i;
 
 	clear_thread_flag(TIF_SIGPENDING);
 
-	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
+	for (p = 0; p < serv->sv_nprogs; p++) {
+		struct svc_program *progp = &serv->sv_programs[p];
+
 		for (i = 0; i < progp->pg_nvers; i++) {
 			if (progp->pg_vers[i] == NULL)
 				continue;
@@ -1328,7 +1335,7 @@ svc_process_common(struct svc_rqst *rqstp)
 	struct svc_process_info process;
 	enum svc_auth_status	auth_res;
 	unsigned int		aoffset;
-	int			rc;
+	int			pr, rc;
 	__be32			*p;
 
 	/* Will be turned off only when NFSv4 Sessions are used */
@@ -1352,9 +1359,12 @@ svc_process_common(struct svc_rqst *rqstp)
 	rqstp->rq_vers = be32_to_cpup(p++);
 	rqstp->rq_proc = be32_to_cpup(p);
 
-	for (progp = serv->sv_program; progp; progp = progp->pg_next)
+	for (pr = 0; pr < serv->sv_nprogs; pr++) {
+		progp = &serv->sv_programs[pr];
+
 		if (rqstp->rq_prog == progp->pg_prog)
 			break;
+	}
 
 	/*
 	 * Decode auth data, and add verifier to reply buffer.
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index d3735ab3e6d1..16634afdf253 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -268,7 +268,7 @@ static int _svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 		spin_unlock(&svc_xprt_class_lock);
 		newxprt = xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
 		if (IS_ERR(newxprt)) {
-			trace_svc_xprt_create_err(serv->sv_program->pg_name,
+			trace_svc_xprt_create_err(serv->sv_programs->pg_name,
 						  xcl->xcl_name, sap, len,
 						  newxprt);
 			module_put(xcl->xcl_owner);
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 04b45588ae6f..8ca98b146ec8 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -697,7 +697,8 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
 	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	ipm = ip_map_cached_get(xprt);
 	if (ipm == NULL)
-		ipm = __ip_map_lookup(sn->ip_map_cache, rqstp->rq_server->sv_program->pg_class,
+		ipm = __ip_map_lookup(sn->ip_map_cache,
+				      rqstp->rq_server->sv_programs->pg_class,
 				    &sin6->sin6_addr);
 
 	if (ipm == NULL)
-- 
2.44.0


