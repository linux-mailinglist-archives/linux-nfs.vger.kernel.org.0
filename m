Return-Path: <linux-nfs+bounces-4896-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F2B930F11
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3A21C20B90
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0666AB8;
	Mon, 15 Jul 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vAhhQ6AM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tegVgq8X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vAhhQ6AM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tegVgq8X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64031171E60
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029690; cv=none; b=CIx5CjHWyukKKqFBIZNXarcRESlPcxgg+yfe+ugRAJLRNoA/T7UvI9NlpuCjKBtJ9JXyDdpoVK53tSDLDFe3bGMCBBuGGM6DYsZug3dicddnf1TLdQ2KUaMrn1cQ283vpCLnNvQ2Wp52eUDZpw931vw/xy9YzrYai8YIA26wUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029690; c=relaxed/simple;
	bh=XAIt577rdD1BLzIIoxIA3+BIZ6OcaoafplETOQgO6aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m71S9xyKW80OXv+t4y3w2xvjPGhsMFuxuPgVjzRiClmJLC8DaIzHtR3OJVrEvDF6LxBlgR5677bJKAAV++nIVFL85Ji7YKybxA9oPLsLd0NGlcjbPpWaPGHtV4lWJADRoizDVVQc7x3Fp6yOiJsy5PnQ67qszmGUK3hiTtaaQIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vAhhQ6AM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tegVgq8X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vAhhQ6AM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tegVgq8X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 919F61F7B2;
	Mon, 15 Jul 2024 07:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkrXDdPcfKMg2MMMJGfN7MQNt+6lc0RMFe7+No+U/Mg=;
	b=vAhhQ6AMHS6smOxabLafiRrlhSSMW7U43St95soiOeeIVU4f0dJddHFpiRrcu88XeeqjJk
	ONxHYuyK6z8evJlvECf4iFZEIHsgW8dtekcXF4s6nMdF8NCJlqEoGKbSalEIcWGvaFDG9B
	lraNz5Hbv/9cFHY5FT15l0M2tFJiDk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkrXDdPcfKMg2MMMJGfN7MQNt+6lc0RMFe7+No+U/Mg=;
	b=tegVgq8XwMATkHL1L379btEJ2/6DAOmVd+74pCZarjSyUrtI/GE49MS5V9bPZIVuJn8rW4
	EDxdEIq4Cfd3vvAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkrXDdPcfKMg2MMMJGfN7MQNt+6lc0RMFe7+No+U/Mg=;
	b=vAhhQ6AMHS6smOxabLafiRrlhSSMW7U43St95soiOeeIVU4f0dJddHFpiRrcu88XeeqjJk
	ONxHYuyK6z8evJlvECf4iFZEIHsgW8dtekcXF4s6nMdF8NCJlqEoGKbSalEIcWGvaFDG9B
	lraNz5Hbv/9cFHY5FT15l0M2tFJiDk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkrXDdPcfKMg2MMMJGfN7MQNt+6lc0RMFe7+No+U/Mg=;
	b=tegVgq8XwMATkHL1L379btEJ2/6DAOmVd+74pCZarjSyUrtI/GE49MS5V9bPZIVuJn8rW4
	EDxdEIq4Cfd3vvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EA3E137EB;
	Mon, 15 Jul 2024 07:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SNBBNTPUlGbibQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:48:03 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 04/14] nfsd: don't allocate the versions array.
Date: Mon, 15 Jul 2024 17:14:17 +1000
Message-ID: <20240715074657.18174-5-neilb@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *

Instead of using kmalloc to allocate an array for storing active version
info, just declare and array to the max size - it is only 5 or so.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/nfs4state.c |   2 +
 fs/nfsd/cache.h    |   2 +-
 fs/nfsd/netns.h    |   6 +--
 fs/nfsd/nfsctl.c   |  10 +++--
 fs/nfsd/nfsd.h     |   9 +++-
 fs/nfsd/nfssvc.c   | 100 ++++++++-------------------------------------
 6 files changed, 36 insertions(+), 93 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 5b452411e8fd..68c663626480 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1953,6 +1953,8 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 				if (lost_locks)
 					pr_warn("NFS: %s: lost %d locks\n",
 						clp->cl_hostname, lost_locks);
+				nfs4_free_state_owners(&freeme);
+
 				set_bit(ops->owner_flag_bit, &sp->so_flags);
 				nfs4_put_state_owner(sp);
 				status = nfs4_recovery_handle_error(clp, status);
diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index 66a05fefae98..bb7addef4a31 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -10,7 +10,7 @@
 #define NFSCACHE_H
 
 #include <linux/sunrpc/svc.h>
-#include "netns.h"
+#include "nfsd.h"
 
 /*
  * Representation of a reply cache entry.
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 14ec15656320..238fc4e56e53 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -152,8 +152,8 @@ struct nfsd_net {
 	/*
 	 * Version information
 	 */
-	bool *nfsd_versions;
-	bool *nfsd4_minorversions;
+	bool nfsd_versions[NFSD_MAXVERS + 1];
+	bool nfsd4_minorversions[NFSD_SUPPORTED_MINOR_VERSION + 1];
 
 	/*
 	 * Duplicate reply cache
@@ -219,8 +219,6 @@ struct nfsd_net {
 #define nfsd_netns_ready(nn) ((nn)->sessionid_hashtbl)
 
 extern bool nfsd_support_version(int vers);
-extern void nfsd_netns_free_versions(struct nfsd_net *nn);
-
 extern unsigned int nfsd_net_id;
 
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 9b47723fc110..5b0f2e0d7ccf 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2232,8 +2232,9 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
  */
 static __net_init int nfsd_net_init(struct net *net)
 {
-	int retval;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	int retval;
+	int i;
 
 	retval = nfsd_export_init(net);
 	if (retval)
@@ -2247,8 +2248,10 @@ static __net_init int nfsd_net_init(struct net *net)
 		goto out_repcache_error;
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
 	nn->nfsd_svcstats.program = &nfsd_program;
-	nn->nfsd_versions = NULL;
-	nn->nfsd4_minorversions = NULL;
+	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
+		nn->nfsd_versions[i] = nfsd_support_version(i);
+	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
+		nn->nfsd4_minorversions[i] = nfsd_support_version(4);
 	nn->nfsd_info.mutex = &nfsd_mutex;
 	nn->nfsd_serv = NULL;
 	nfsd4_init_leases_net(nn);
@@ -2279,7 +2282,6 @@ static __net_exit void nfsd_net_exit(struct net *net)
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
-	nfsd_netns_free_versions(nn);
 }
 
 static struct pernet_operations nfsd_net_ops = {
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 39e109a7d56d..369c3b3ce53e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -23,9 +23,7 @@
 
 #include <uapi/linux/nfsd/debug.h>
 
-#include "netns.h"
 #include "export.h"
-#include "stats.h"
 
 #undef ifdebug
 #ifdef CONFIG_SUNRPC_DEBUG
@@ -37,7 +35,14 @@
 /*
  * nfsd version
  */
+#define NFSD_MINVERS			2
+#define	NFSD_MAXVERS			4
 #define NFSD_SUPPORTED_MINOR_VERSION	2
+bool nfsd_support_version(int vers);
+
+#include "netns.h"
+#include "stats.h"
+
 /*
  * Maximum blocksizes supported by daemon under various circumstances.
  */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f25b26bc5670..4438cdcd4873 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -116,15 +116,12 @@ static const struct svc_version *nfsd_version[] = {
 #endif
 };
 
-#define NFSD_MINVERS    	2
-#define NFSD_NRVERS		ARRAY_SIZE(nfsd_version)
-
 struct svc_program		nfsd_program = {
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 	.pg_next		= &nfsd_acl_program,
 #endif
 	.pg_prog		= NFS_PROGRAM,		/* program number */
-	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
+	.pg_nvers		= NFSD_MAXVERS+1,	/* nr of entries in nfsd_version */
 	.pg_vers		= nfsd_version,		/* version table */
 	.pg_name		= "nfsd",		/* program name */
 	.pg_class		= "nfsd",		/* authentication class */
@@ -135,78 +132,24 @@ struct svc_program		nfsd_program = {
 
 bool nfsd_support_version(int vers)
 {
-	if (vers >= NFSD_MINVERS && vers < NFSD_NRVERS)
+	if (vers >= NFSD_MINVERS && vers <= NFSD_MAXVERS)
 		return nfsd_version[vers] != NULL;
 	return false;
 }
 
-static bool *
-nfsd_alloc_versions(void)
-{
-	bool *vers = kmalloc_array(NFSD_NRVERS, sizeof(bool), GFP_KERNEL);
-	unsigned i;
-
-	if (vers) {
-		/* All compiled versions are enabled by default */
-		for (i = 0; i < NFSD_NRVERS; i++)
-			vers[i] = nfsd_support_version(i);
-	}
-	return vers;
-}
-
-static bool *
-nfsd_alloc_minorversions(void)
-{
-	bool *vers = kmalloc_array(NFSD_SUPPORTED_MINOR_VERSION + 1,
-			sizeof(bool), GFP_KERNEL);
-	unsigned i;
-
-	if (vers) {
-		/* All minor versions are enabled by default */
-		for (i = 0; i <= NFSD_SUPPORTED_MINOR_VERSION; i++)
-			vers[i] = nfsd_support_version(4);
-	}
-	return vers;
-}
-
-void
-nfsd_netns_free_versions(struct nfsd_net *nn)
-{
-	kfree(nn->nfsd_versions);
-	kfree(nn->nfsd4_minorversions);
-	nn->nfsd_versions = NULL;
-	nn->nfsd4_minorversions = NULL;
-}
-
-static void
-nfsd_netns_init_versions(struct nfsd_net *nn)
-{
-	if (!nn->nfsd_versions) {
-		nn->nfsd_versions = nfsd_alloc_versions();
-		nn->nfsd4_minorversions = nfsd_alloc_minorversions();
-		if (!nn->nfsd_versions || !nn->nfsd4_minorversions)
-			nfsd_netns_free_versions(nn);
-	}
-}
-
 int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change)
 {
-	if (vers < NFSD_MINVERS || vers >= NFSD_NRVERS)
+	if (vers < NFSD_MINVERS || vers > NFSD_MAXVERS)
 		return 0;
 	switch(change) {
 	case NFSD_SET:
-		if (nn->nfsd_versions)
-			nn->nfsd_versions[vers] = nfsd_support_version(vers);
+		nn->nfsd_versions[vers] = nfsd_support_version(vers);
 		break;
 	case NFSD_CLEAR:
-		nfsd_netns_init_versions(nn);
-		if (nn->nfsd_versions)
-			nn->nfsd_versions[vers] = false;
+		nn->nfsd_versions[vers] = false;
 		break;
 	case NFSD_TEST:
-		if (nn->nfsd_versions)
-			return nn->nfsd_versions[vers];
-		fallthrough;
+		return nn->nfsd_versions[vers];
 	case NFSD_AVAIL:
 		return nfsd_support_version(vers);
 	}
@@ -233,23 +176,16 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 
 	switch(change) {
 	case NFSD_SET:
-		if (nn->nfsd4_minorversions) {
-			nfsd_vers(nn, 4, NFSD_SET);
-			nn->nfsd4_minorversions[minorversion] =
-				nfsd_vers(nn, 4, NFSD_TEST);
-		}
+		nfsd_vers(nn, 4, NFSD_SET);
+		nn->nfsd4_minorversions[minorversion] =
+			nfsd_vers(nn, 4, NFSD_TEST);
 		break;
 	case NFSD_CLEAR:
-		nfsd_netns_init_versions(nn);
-		if (nn->nfsd4_minorversions) {
-			nn->nfsd4_minorversions[minorversion] = false;
-			nfsd_adjust_nfsd_versions4(nn);
-		}
+		nn->nfsd4_minorversions[minorversion] = false;
+		nfsd_adjust_nfsd_versions4(nn);
 		break;
 	case NFSD_TEST:
-		if (nn->nfsd4_minorversions)
-			return nn->nfsd4_minorversions[minorversion];
-		return nfsd_vers(nn, 4, NFSD_TEST);
+		return nn->nfsd4_minorversions[minorversion];
 	case NFSD_AVAIL:
 		return minorversion <= NFSD_SUPPORTED_MINOR_VERSION &&
 			nfsd_vers(nn, 4, NFSD_AVAIL);
@@ -568,11 +504,11 @@ void nfsd_reset_versions(struct nfsd_net *nn)
 {
 	int i;
 
-	for (i = 0; i < NFSD_NRVERS; i++)
+	for (i = 0; i <= NFSD_MAXVERS; i++)
 		if (nfsd_vers(nn, i, NFSD_TEST))
 			return;
 
-	for (i = 0; i < NFSD_NRVERS; i++)
+	for (i = 0; i <= NFSD_MAXVERS; i++)
 		if (i != 4)
 			nfsd_vers(nn, i, NFSD_SET);
 		else {
@@ -905,17 +841,17 @@ nfsd_init_request(struct svc_rqst *rqstp,
 	if (likely(nfsd_vers(nn, rqstp->rq_vers, NFSD_TEST)))
 		return svc_generic_init_request(rqstp, progp, ret);
 
-	ret->mismatch.lovers = NFSD_NRVERS;
-	for (i = NFSD_MINVERS; i < NFSD_NRVERS; i++) {
+	ret->mismatch.lovers = NFSD_MAXVERS + 1;
+	for (i = NFSD_MINVERS; i <= NFSD_MAXVERS; i++) {
 		if (nfsd_vers(nn, i, NFSD_TEST)) {
 			ret->mismatch.lovers = i;
 			break;
 		}
 	}
-	if (ret->mismatch.lovers == NFSD_NRVERS)
+	if (ret->mismatch.lovers > NFSD_MAXVERS)
 		return rpc_prog_unavail;
 	ret->mismatch.hivers = NFSD_MINVERS;
-	for (i = NFSD_NRVERS - 1; i >= NFSD_MINVERS; i--) {
+	for (i = NFSD_MAXVERS; i >= NFSD_MINVERS; i--) {
 		if (nfsd_vers(nn, i, NFSD_TEST)) {
 			ret->mismatch.hivers = i;
 			break;
-- 
2.44.0


