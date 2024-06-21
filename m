Return-Path: <linux-nfs+bounces-4208-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CA8911A2C
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 07:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B47B1F2174F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 05:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B386AFA;
	Fri, 21 Jun 2024 05:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P2flFOck";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="19sTi8bc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qA+C0bUT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sOYa7gY1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10D762C1
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946667; cv=none; b=fFqy2+ZqP8mFGKLrmoR4fMxj8vYoul7LOKXBfFJR4lql3FfgcVPcDrPkj1iaPawS5kXG+epEjDsLCWcxfe43mah/cOHdsX6mSI0QqFzRbslCqPgvRLF3HGBYvtAQh9dbG4EnTruTd932SkUJm+M5L5LhTmevJ6T3V9HZFtFV5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946667; c=relaxed/simple;
	bh=4NU1ArTnpyLK9KHb6W+74x/3aHB9a1+eQtUBG95o8Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REqbeb09eFe+PCMWfF27Tdn/zwSNBAP56UwZkN+LXzNg1hpUfC6zqYugKyQDsdeq+c1BWtWnJD36oHmqsfp3PotAxJVbxzUBvgiuu1HIuRZ9yMV0//cSO0Yuslmg932bMQC01WMKYjb4vNZtwiOECF2wYeJlFLnGEndmsXPVYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P2flFOck; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=19sTi8bc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qA+C0bUT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sOYa7gY1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A8D61FB3F;
	Fri, 21 Jun 2024 05:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718946663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLB6UzN7D0LzGInHbX7qdze7NsDLk5su6IQzFV8bbV8=;
	b=P2flFOckLYTloT+fEqrJnLHvrEHPPpQHcEqn9iV2wE/MwtQHhOsw2EhZ3q7OD7Pr2l4onS
	+ZMn2KkJFVa4NNvbV8l0aLloM1DqxO6/La1fyCnxrDy0FA4HzJ77V66LL9kVcl4PtaAZtB
	aHJbFdDkXuDrKV9/DSaMrUinR1ZMEbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718946663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLB6UzN7D0LzGInHbX7qdze7NsDLk5su6IQzFV8bbV8=;
	b=19sTi8bc5WMEsV97R/l2L0O+jzmagXtEjiN0e5cPRzHP9kDyh1HLgx1mBV2Owd8DWPv/Qv
	IKP05QwUcE6exbDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qA+C0bUT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sOYa7gY1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718946662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLB6UzN7D0LzGInHbX7qdze7NsDLk5su6IQzFV8bbV8=;
	b=qA+C0bUTgzgdA3cvVzv6DWIwGxM905Y6fVQUATZCfjLtUsik5G8V0PcOs6+tUR8P8iX6Nb
	sdpPpK9X1CEGzHcr890OwA/Ytd+kSNYLOx4d2DssKTkKRsapCCoy9AItBRJ1S7bv9fOVY4
	tkSNa3SSrK/9Sgc0/QiuoCP7rftn6Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718946662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLB6UzN7D0LzGInHbX7qdze7NsDLk5su6IQzFV8bbV8=;
	b=sOYa7gY1OwrPv/X44vq1TY4cKtGIrqJVffjgDxkWuI92joBLswcBJTKgIPElIE3xz17IWO
	kAjxw6pj6wwDhvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF77513AAA;
	Fri, 21 Jun 2024 05:10:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eIjrHGMLdWbpagAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 21 Jun 2024 05:10:59 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH 1/3] NFS: Simplify Client NFS_LOCALIO_PROGRAM support
Date: Fri, 21 Jun 2024 14:59:28 +1000
Message-ID: <20240621050857.20075-2-neilb@suse.de>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,brown.name:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6A8D61FB3F
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

From: NeilBrown <neil@brown.name>

This patch is intended to be squashed into
  nfs: implement v3 and v4 client support for NFS_LOCALIO_PROGRAM

It moves all the knowledge of the LOCALIO RPC protocol in
fs/nfs/localio.c and implements just a single version (1) which is used
independently of what NFS version is used.

The #defines for PROGRAM and PROC numbers are moved out of uapi as these
are not part of the UAPI - only Linux internals need to know then.
Other servers might see them but the numbers are chosen so other servers
will reject the any request they see.

For the resulting patch to compile,
 nfs/nfsd: consolidate {encode,decode}_opaque_fixed in nfs_xdr.h

needs to be applied earlier in the series.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/internal.h        |  5 --
 fs/nfs/localio.c         | 99 ++++++++++++++++++++++++++++------------
 fs/nfs/nfs3_fs.h         |  1 -
 fs/nfs/nfs3client.c      | 23 ----------
 fs/nfs/nfs3proc.c        |  3 --
 fs/nfs/nfs3xdr.c         | 67 ---------------------------
 fs/nfs/nfs4_fs.h         |  2 -
 fs/nfs/nfs4client.c      | 23 ----------
 fs/nfs/nfs4proc.c        |  3 --
 fs/nfs/nfs4xdr.c         | 52 ---------------------
 include/linux/nfs.h      |  7 +++
 include/linux/nfs_xdr.h  | 12 -----
 include/uapi/linux/nfs.h |  4 --
 13 files changed, 76 insertions(+), 225 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 15310618f4f0..9251a357d097 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -456,8 +456,6 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 /* localio.c */
 extern void nfs_local_disable(struct nfs_client *);
 extern void nfs_local_probe(struct nfs_client *);
-extern void nfs_init_localioclient(struct nfs_client *clp,
-				   const struct rpc_program *program, u32 vers);
 extern struct file *nfs_local_open_fh(struct nfs_client *, const struct cred *,
 				      struct nfs_fh *, const fmode_t);
 extern struct file *nfs_local_file_open(struct nfs_client *clp,
@@ -474,9 +472,6 @@ extern bool nfs_server_is_local(const struct nfs_client *clp);
 #else
 static inline void nfs_local_disable(struct nfs_client *clp) {}
 static inline void nfs_local_probe(struct nfs_client *clp) {}
-static inline void nfs_init_localioclient(struct nfs_client *clp,
-					  const struct rpc_program *program,
-					  u32 vers) {}
 static inline struct file *nfs_local_open_fh(struct nfs_client *clp,
 					const struct cred *cred,
 					struct nfs_fh *fh,
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 1fa41228b278..85a370bf7b28 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -135,6 +135,58 @@ bool nfs_server_is_local(const struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_server_is_local);
 
+
+static void localio_xdr_enc_getuuidargs(struct rpc_rqst *req,
+					struct xdr_stream *xdr,
+					const void *data)
+{
+	/* void function */
+}
+
+static int localio_xdr_dec_getuuidres(struct rpc_rqst *req,
+				      struct xdr_stream *xdr,
+				      void *result)
+{
+	u8 *uuid = result;
+
+	return decode_opaque_fixed(xdr, uuid, UUID_SIZE);
+}
+
+static const struct rpc_procinfo nfs_localio_procedures[] = {
+	[LOCALIOPROC_GETUUID] = {
+		.p_proc = LOCALIOPROC_GETUUID,
+		.p_encode = localio_xdr_enc_getuuidargs,
+		.p_decode = localio_xdr_dec_getuuidres,
+		.p_arglen = 0,
+		.p_replen = XDR_QUADLEN(UUID_SIZE),
+		.p_statidx = LOCALIOPROC_GETUUID,
+		.p_name = "GETUUID",
+	},
+};
+
+static unsigned int nfs_localio_counts[ARRAY_SIZE(nfs_localio_procedures)];
+const struct rpc_version nfslocalio_version1 = {
+	.number			= 1,
+	.nrprocs		= ARRAY_SIZE(nfs_localio_procedures),
+	.procs			= nfs_localio_procedures,
+	.counts			= nfs_localio_counts,
+};
+
+static const struct rpc_version *nfslocalio_version[] = {
+       [1]			= &nfslocalio_version1,
+};
+
+extern const struct rpc_program nfslocalio_program;
+static struct rpc_stat		nfslocalio_rpcstat = { &nfslocalio_program };
+
+const struct rpc_program nfslocalio_program = {
+	.name			= "nfslocalio",
+	.number			= NFS_LOCALIO_PROGRAM,
+	.nrvers			= ARRAY_SIZE(nfslocalio_version),
+	.version		= nfslocalio_version,
+	.stats			= &nfslocalio_rpcstat,
+};
+
 /*
  * nfs_local_enable - attempt to enable local i/o for an nfs_client
  */
@@ -167,13 +219,12 @@ void nfs_local_disable(struct nfs_client *clp)
 /*
  * nfs_init_localioclient - Initialise an NFS localio client connection
  */
-void nfs_init_localioclient(struct nfs_client *clp,
-			    const struct rpc_program *program, u32 vers)
+static void nfs_init_localioclient(struct nfs_client *clp)
 {
 	if (unlikely(!IS_ERR(clp->cl_rpcclient_localio)))
 		goto out;
 	clp->cl_rpcclient_localio = rpc_bind_new_program(clp->cl_rpcclient,
-							 program, vers);
+							 &nfslocalio_program, 1);
 	if (IS_ERR(clp->cl_rpcclient_localio))
 		goto out;
 	/* No errors! Assume that localio is supported */
@@ -183,38 +234,33 @@ void nfs_init_localioclient(struct nfs_client *clp,
 		clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
 	}
 out:
-	dprintk_rcu("%s: server (%s) %s NFSv%u LOCALIO, nfsd_open_local_fh is %s.\n",
+	dprintk_rcu("%s: server (%s) %s NFS LOCALIO, nfsd_open_local_fh is %s.\n",
 		__func__, rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR),
 		(IS_ERR(clp->cl_rpcclient_localio) ? "does not support" : "supports"),
-		vers, (clp->nfsd_open_local_fh ? "set" : "not set"));
+		(clp->nfsd_open_local_fh ? "set" : "not set"));
 }
-EXPORT_SYMBOL(nfs_init_localioclient);
 
 static bool nfs_local_server_getuuid(struct nfs_client *clp, uuid_t *nfsd_uuid)
 {
 	u8 uuid[UUID_SIZE];
-	struct nfs_getuuidres res = {
-		uuid,
-	};
 	struct rpc_message msg = {
-		.rpc_resp = &res,
+		.rpc_resp = &uuid,
 	};
 	int status;
 
-	/* Indirect call to nfs_init_localioclient() */
-	clp->rpc_ops->init_localioclient(clp);
+	nfs_init_localioclient(clp);
 	if (IS_ERR(clp->cl_rpcclient_localio))
 		return false;
 
 	dprintk("%s: NFS issuing getuuid\n", __func__);
-	msg.rpc_proc = &clp->cl_rpcclient_localio->cl_procinfo[LOCALIOPROC_GETUUID];
+	msg.rpc_proc = &nfs_localio_procedures[LOCALIOPROC_GETUUID];
 	status = rpc_call_sync(clp->cl_rpcclient_localio, &msg, 0);
 	dprintk("%s: NFS reply getuuid: status=%d uuid=%pU\n",
-		__func__, status, res.uuid);
+		__func__, status, uuid);
 	if (status)
 		return false;
 
-	import_uuid(nfsd_uuid, res.uuid);
+	import_uuid(nfsd_uuid, uuid);
 
 	return true;
 }
@@ -237,22 +283,15 @@ void nfs_local_probe(struct nfs_client *clp)
 		nfs_local_disable(clp);
 	}
 
-	switch (clp->cl_rpcclient->cl_vers) {
-	case 3:
-	case 4:
-		/*
-		 * Retrieve server's uuid via LOCALIO protocol and verify the
-		 * server with that uuid is known to be local. This ensures
-		 * client and server 1: support localio 2: are local to each other
-		 * by verifying client's nfsd, with specified uuid, is local.
-		 */
-		if (!nfs_local_server_getuuid(clp, &uuid) ||
-		    !nfsd_uuid_is_local(&uuid, &net))
-			goto unsupported;
-		break;
-	default:
+	/*
+	 * Retrieve server's uuid via LOCALIO protocol and verify the
+	 * server with that uuid is known to be local. This ensures
+	 * client and server 1: support localio 2: are local to each other
+	 * by verifying client's nfsd, with specified uuid, is local.
+	 */
+	if (!nfs_local_server_getuuid(clp, &uuid) ||
+	    !nfsd_uuid_is_local(&uuid, &net))
 		goto unsupported;
-	}
 
 	dprintk("%s: detected local server.\n", __func__);
 	nfs_local_enable(clp, net);
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index efdf2b6519e9..b333ea119ef5 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -30,7 +30,6 @@ static inline int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 struct nfs_server *nfs3_create_server(struct fs_context *);
 struct nfs_server *nfs3_clone_server(struct nfs_server *, struct nfs_fh *,
 				     struct nfs_fattr *, rpc_authflavor_t);
-void nfs3_init_localioclient(struct nfs_client *);
 
 /* nfs3super.c */
 extern struct nfs_subversion nfs_v3;
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 5d478034f5ea..b0c8a39c2bbd 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -130,26 +130,3 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 	return clp;
 }
 EXPORT_SYMBOL_GPL(nfs3_set_ds_client);
-
-#if defined(CONFIG_NFS_V3_LOCALIO)
-static struct rpc_stat		nfslocalio_rpcstat = { &nfslocalio_program3 };
-static const struct rpc_version *nfslocalio_version[] = {
-	[3]			= &nfslocalio_version3,
-};
-
-const struct rpc_program nfslocalio_program3 = {
-	.name			= "nfslocalio",
-	.number			= NFS_LOCALIO_PROGRAM,
-	.nrvers			= ARRAY_SIZE(nfslocalio_version),
-	.version		= nfslocalio_version,
-	.stats			= &nfslocalio_rpcstat,
-};
-
-/*
- * Initialise an NFSv3 localio client connection
- */
-void nfs3_init_localioclient(struct nfs_client *clp)
-{
-	nfs_init_localioclient(clp, &nfslocalio_program3, 3);
-}
-#endif /* CONFIG_NFS_V3_LOCALIO */
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 40b6e4d1e7be..74bda639a7cf 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -1067,7 +1067,4 @@ const struct nfs_rpc_ops nfs_v3_clientops = {
 	.free_client	= nfs_free_client,
 	.create_server	= nfs3_create_server,
 	.clone_server	= nfs3_clone_server,
-#if defined(CONFIG_NFS_V3_LOCALIO)
-	.init_localioclient = nfs3_init_localioclient,
-#endif
 };
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index d2a17ecd12b8..60f032be805a 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2579,70 +2579,3 @@ const struct rpc_version nfsacl_version3 = {
 	.counts			= nfs3_acl_counts,
 };
 #endif  /* CONFIG_NFS_V3_ACL */
-
-#if defined(CONFIG_NFS_V3_LOCALIO)
-
-#define LOCALIO3_getuuidres_sz	(1+XDR_QUADLEN(UUID_SIZE))
-
-static void nfs3_xdr_enc_getuuidargs(struct rpc_rqst *req,
-				struct xdr_stream *xdr,
-				const void *data)
-{
-	/* void function */
-}
-
-// FIXME: factor out from fs/nfs/nfs4xdr.c
-static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
-{
-	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
-	if (unlikely(ret < 0))
-		return -EIO;
-	return 0;
-}
-
-static inline int nfs3_decode_getuuidresok(struct xdr_stream *xdr,
-					struct nfs_getuuidres *result)
-{
-	return decode_opaque_fixed(xdr, result->uuid, UUID_SIZE);
-}
-
-static int nfs3_xdr_dec_getuuidres(struct rpc_rqst *req,
-				struct xdr_stream *xdr,
-				void *result)
-{
-	enum nfs_stat status;
-	int error;
-
-	error = decode_nfsstat3(xdr, &status);
-	if (unlikely(error))
-		goto out;
-	if (status != NFS3_OK)
-		goto out_default;
-	error = nfs3_decode_getuuidresok(xdr, result);
-out:
-	return error;
-out_default:
-	return nfs3_stat_to_errno(status);
-}
-
-static const struct rpc_procinfo nfs3_localio_procedures[] = {
-	[LOCALIOPROC_GETUUID] = {
-		.p_proc = LOCALIOPROC_GETUUID,
-		.p_encode = nfs3_xdr_enc_getuuidargs,
-		.p_decode = nfs3_xdr_dec_getuuidres,
-		.p_arglen = 1,
-		.p_replen = LOCALIO3_getuuidres_sz,
-		.p_timer = 0,
-		.p_name = "GETUUID",
-	},
-};
-
-static unsigned int nfs3_localio_counts[ARRAY_SIZE(nfs3_localio_procedures)];
-const struct rpc_version nfslocalio_version3 = {
-	.number			= 3,
-	.nrprocs		= ARRAY_SIZE(nfs3_localio_procedures),
-	.procs			= nfs3_localio_procedures,
-	.counts			= nfs3_localio_counts,
-};
-
-#endif  /* CONFIG_NFS_V3_LOCALIO */
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index a0a41917dec2..7024230f0d1d 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -538,8 +538,6 @@ extern int nfs4_proc_commit(struct file *dst, __u64 offset, __u32 count, struct
 extern const nfs4_stateid zero_stateid;
 extern const nfs4_stateid invalid_stateid;
 
-extern void nfs4_init_localioclient(struct nfs_client *);
-
 /* nfs4super.c */
 struct nfs_mount_info;
 extern struct nfs_subversion nfs_v4;
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d2f634aa1e1b..84573df5cf5a 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1384,26 +1384,3 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 
 	return nfs_probe_server(server, NFS_FH(d_inode(server->super->s_root)));
 }
-
-#if defined(CONFIG_NFS_V4_LOCALIO)
-static struct rpc_stat		nfslocalio_rpcstat = { &nfslocalio_program4 };
-static const struct rpc_version *nfslocalio_version[] = {
-	[4]			= &nfslocalio_version4,
-};
-
-const struct rpc_program nfslocalio_program4 = {
-	.name			= "nfslocalio",
-	.number			= NFS_LOCALIO_PROGRAM,
-	.nrvers			= ARRAY_SIZE(nfslocalio_version),
-	.version		= nfslocalio_version,
-	.stats			= &nfslocalio_rpcstat,
-};
-
-/*
- * Initialise an NFSv4 localio client connection
- */
-void nfs4_init_localioclient(struct nfs_client *clp)
-{
-	nfs_init_localioclient(clp, &nfslocalio_program4, 4);
-}
-#endif /* CONFIG_NFS_V4_LOCALIO */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 060bc8dbee61..c93c12063b3a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10745,9 +10745,6 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.discover_trunking = nfs4_discover_trunking,
 	.enable_swap	= nfs4_enable_swap,
 	.disable_swap	= nfs4_disable_swap,
-#if defined(CONFIG_NFS_V4_LOCALIO)
-	.init_localioclient = nfs4_init_localioclient,
-#endif
 };
 
 static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index d3b4fa3245f0..1416099dfcd1 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7728,55 +7728,3 @@ const struct rpc_version nfs_version4 = {
 	.procs			= nfs4_procedures,
 	.counts			= nfs_version4_counts,
 };
-
-#if defined(CONFIG_NFS_V4_LOCALIO)
-
-#define LOCALIO4_getuuidres_sz	(op_decode_hdr_maxsz+XDR_QUADLEN(UUID_SIZE))
-
-static void nfs4_xdr_enc_getuuidargs(struct rpc_rqst *req,
-				struct xdr_stream *xdr,
-				const void *data)
-{
-	/* void function */
-}
-
-static inline int nfs4_decode_getuuidresok(struct xdr_stream *xdr,
-					struct nfs_getuuidres *result)
-{
-	return decode_opaque_fixed(xdr, result->uuid, UUID_SIZE);
-}
-
-static int nfs4_xdr_dec_getuuidres(struct rpc_rqst *req,
-				struct xdr_stream *xdr,
-				void *result)
-{
-	// FIXME: need proper handling that isn't abusing nfs_opnum4
-	int error = decode_op_hdr(xdr, LOCALIOPROC_GETUUID);
-	if (unlikely(error))
-		goto out;
-	error = nfs4_decode_getuuidresok(xdr, result);
-out:
-	return error;
-}
-
-static const struct rpc_procinfo nfs4_localio_procedures[] = {
-	[LOCALIOPROC_GETUUID] = {
-		.p_proc = LOCALIOPROC_GETUUID,
-		.p_encode = nfs4_xdr_enc_getuuidargs,
-		.p_decode = nfs4_xdr_dec_getuuidres,
-		.p_arglen = 1,
-		.p_replen = LOCALIO4_getuuidres_sz,
-		.p_statidx = LOCALIOPROC_GETUUID,
-		.p_name = "GETUUID",
-	},
-};
-
-static unsigned int nfs4_localio_counts[ARRAY_SIZE(nfs4_localio_procedures)];
-const struct rpc_version nfslocalio_version4 = {
-	.number			= 4,
-	.nrprocs		= ARRAY_SIZE(nfs4_localio_procedures),
-	.procs			= nfs4_localio_procedures,
-	.counts			= nfs4_localio_counts,
-};
-
-#endif  /* CONFIG_NFS_V4_LOCALIO */
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 64ed672a0b34..a19422141563 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -15,6 +15,13 @@
 #include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
+/* The localio program is entirely private to Linux and is
+ * NOT part of the uapi.
+ */
+#define NFS_LOCALIO_PROGRAM	0x20000002
+#define LOCALIOPROC_NULL	0
+#define LOCALIOPROC_GETUUID	1
+
 /*
  * This is the kernel NFS client file handle representation
  */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 56d23b84efbb..764513a61601 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1002,10 +1002,6 @@ struct nfs3_getaclres {
 	struct posix_acl *	acl_default;
 };
 
-struct nfs_getuuidres {
-	__u8 *			uuid;
-};
-
 #if IS_ENABLED(CONFIG_NFS_V4)
 
 typedef u64 clientid4;
@@ -1823,9 +1819,6 @@ struct nfs_rpc_ops {
 	int	(*discover_trunking)(struct nfs_server *, struct nfs_fh *);
 	void	(*enable_swap)(struct inode *inode);
 	void	(*disable_swap)(struct inode *inode);
-#if IS_ENABLED(CONFIG_NFS_LOCALIO)
-	void	(*init_localioclient)(struct nfs_client *);
-#endif
 };
 
 /*
@@ -1841,9 +1834,4 @@ extern const struct rpc_version nfs_version4;
 extern const struct rpc_version nfsacl_version3;
 extern const struct rpc_program nfsacl_program;
 
-extern const struct rpc_version nfslocalio_version3;
-extern const struct rpc_program nfslocalio_program3;
-extern const struct rpc_version nfslocalio_version4;
-extern const struct rpc_program nfslocalio_program4;
-
 #endif
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index 81eb865d99ef..f356f2ba3814 100644
--- a/include/uapi/linux/nfs.h
+++ b/include/uapi/linux/nfs.h
@@ -33,10 +33,6 @@
 #define NFS_MNT_VERSION		1
 #define NFS_MNT3_VERSION	3
 
-#define NFS_LOCALIO_PROGRAM	0x20000002
-#define LOCALIOPROC_NULL	0
-#define LOCALIOPROC_GETUUID	1
-
 #define NFS_PIPE_DIRNAME "nfs"
 
 /*
-- 
2.44.0


