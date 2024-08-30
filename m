Return-Path: <linux-nfs+bounces-6029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87C965554
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 04:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0731C22527
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF944D8A1;
	Fri, 30 Aug 2024 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ki6c752f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q1a2BArn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ki6c752f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q1a2BArn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69376380
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985594; cv=none; b=OutuDNMcPwYAvoKr7LRLT00MAdNQE4/QfRA/CxiZZiuRW2ZMU+mQ31FYG9dlN2QAk3jrDw5F9vc3nK76W2RRdTybM3uu/gXfkLWdiyphKGm2QLfccaMcVJNmzY4zBo9Og3K/lDdT/MbSk1XACNbNQpqNoumm+H5L8+Y0T3XVx2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985594; c=relaxed/simple;
	bh=6YE9GUlzErZqMUq/cDudZ5Rid9wFgbt27/XbDz+aGPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5AwJCQEnf8zlsFtM1RLm/64yck27a0+RDWN933m1au3KyOP7NCmEdzVvDT8cLG9ZLPYPHP34C1IouLSQuYK8/o9TxcV96gD0HAWj2+sLdvIgiPoi6EvbvWVkpoR16t5+T/jY7UnN+yooB1PmmKn5ymoCJvpnJdX62bNJ2ZnJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ki6c752f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q1a2BArn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ki6c752f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q1a2BArn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D72131F791;
	Fri, 30 Aug 2024 02:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWkiBtKA/cWamN/d+vca5lupntPHjjLAPN3z8BFO7jU=;
	b=Ki6c752fmNiaY+fU84AtzMLFaCXvvjaI0nOzd7oHHb+9BVzdoGZBKu4cNIAziVDvw6v2iA
	Xx/gAaGnuLqr9wXJ9fo2eZZtQR8bHVcJCv/3xzJeVD2/28crsyrp3AcNm6PyytVk5Sd3OF
	ZMHxx/UaCRsQAiKOKfogOTd6aV/s8FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWkiBtKA/cWamN/d+vca5lupntPHjjLAPN3z8BFO7jU=;
	b=q1a2BArnKS8nj6Pzc4wMd5yLpDc/23ZmKInkeOwmxSg2gzgwTLqxnVGzTd6fzzthaIhZug
	w6lugtD+Or5o6UBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ki6c752f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q1a2BArn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWkiBtKA/cWamN/d+vca5lupntPHjjLAPN3z8BFO7jU=;
	b=Ki6c752fmNiaY+fU84AtzMLFaCXvvjaI0nOzd7oHHb+9BVzdoGZBKu4cNIAziVDvw6v2iA
	Xx/gAaGnuLqr9wXJ9fo2eZZtQR8bHVcJCv/3xzJeVD2/28crsyrp3AcNm6PyytVk5Sd3OF
	ZMHxx/UaCRsQAiKOKfogOTd6aV/s8FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWkiBtKA/cWamN/d+vca5lupntPHjjLAPN3z8BFO7jU=;
	b=q1a2BArnKS8nj6Pzc4wMd5yLpDc/23ZmKInkeOwmxSg2gzgwTLqxnVGzTd6fzzthaIhZug
	w6lugtD+Or5o6UBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51CC0136A4;
	Fri, 30 Aug 2024 02:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bl1aAvUw0WYHGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 02:39:49 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 23/25] nfs: implement client support for NFS_LOCALIO_PROGRAM
Date: Fri, 30 Aug 2024 12:20:36 +1000
Message-ID: <20240830023531.29421-24-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240830023531.29421-1-neilb@suse.de>
References: <20240830023531.29421-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D72131F791
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Mike Snitzer <snitzer@kernel.org>

The LOCALIO auxiliary RPC protocol consists of a single "UUID_IS_LOCAL"
RPC method that allows the Linux NFS client to verify the local Linux
NFS server can see the nonce (single-use UUID) the client generated and
made available in nfs_common for subsequent lookup and verification
by the NFS server.  If matched, the NFS server populates members in the
nfs_uuid_t struct.  The NFS client then transfers these nfs_uuid_t
struct member pointers to the nfs_client struct and cleans up the
nfs_uuid_t struct.  See: fs/nfs/localio.c:nfs_local_probe()

This protocol isn't part of an IETF standard, nor does it need to be
considering it is Linux-to-Linux auxiliary RPC protocol that amounts
to an implementation detail.

Localio is only supported when UNIX-style authentication (AUTH_UNIX, aka
AUTH_SYS) is used (enforced by fs/nfs/localio.c:nfs_local_probe()).

The UUID_IS_LOCAL method encodes the client generated uuid_t in terms of
the fixed UUID_SIZE (16 bytes).  The fixed size opaque encode and decode
XDR methods are used instead of the less efficient variable sized
methods.

Having a nonce (single-use uuid) is better than using the same uuid
for the life of the server, and sending it proactively by client
rather than reactively by the server is also safer.

[NeilBrown factored out and simplified a single localio protocol and
proposed making the uuid short-lived]

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Co-developed-by: NeilBrown <neilb@suse.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/client.c  |   6 ++-
 fs/nfs/localio.c | 132 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index a890319d4fab..4903f5ff5758 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -433,8 +433,10 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 			list_add_tail(&new->cl_share_link,
 					&nn->nfs_client_list);
 			spin_unlock(&nn->nfs_client_lock);
-			nfs_local_probe(new);
-			return rpc_ops->init_client(new, cl_init);
+			new = rpc_ops->init_client(new, cl_init);
+			if (!IS_ERR(new))
+				 nfs_local_probe(new);
+			return new;
 		}
 
 		spin_unlock(&nn->nfs_client_lock);
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 9d8a1436f3c6..55622084d5c2 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -50,17 +50,77 @@ static void nfs_local_fsync_work(struct work_struct *work);
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
+static inline bool nfs_client_is_local(const struct nfs_client *clp)
+{
+	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+}
+
 bool nfs_server_is_local(const struct nfs_client *clp)
 {
-	return test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags) != 0 &&
-		localio_enabled;
+	return nfs_client_is_local(clp) && localio_enabled;
 }
 EXPORT_SYMBOL_GPL(nfs_server_is_local);
 
+/*
+ * UUID_IS_LOCAL XDR functions
+ */
+
+static void localio_xdr_enc_uuidargs(struct rpc_rqst *req,
+				     struct xdr_stream *xdr,
+				     const void *data)
+{
+	const u8 *uuid = data;
+
+	encode_opaque_fixed(xdr, uuid, UUID_SIZE);
+}
+
+static int localio_xdr_dec_uuidres(struct rpc_rqst *req,
+				   struct xdr_stream *xdr,
+				   void *result)
+{
+	/* void return */
+	return 0;
+}
+
+static const struct rpc_procinfo nfs_localio_procedures[] = {
+	[LOCALIOPROC_UUID_IS_LOCAL] = {
+		.p_proc = LOCALIOPROC_UUID_IS_LOCAL,
+		.p_encode = localio_xdr_enc_uuidargs,
+		.p_decode = localio_xdr_dec_uuidres,
+		.p_arglen = XDR_QUADLEN(UUID_SIZE),
+		.p_replen = 0,
+		.p_statidx = LOCALIOPROC_UUID_IS_LOCAL,
+		.p_name = "UUID_IS_LOCAL",
+	},
+};
+
+static unsigned int nfs_localio_counts[ARRAY_SIZE(nfs_localio_procedures)];
+static const struct rpc_version nfslocalio_version1 = {
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
  * nfs_local_enable - enable local i/o for an nfs_client
  */
-static __maybe_unused void nfs_local_enable(struct nfs_client *clp)
+static void nfs_local_enable(struct nfs_client *clp)
 {
 	spin_lock(&clp->cl_localio_lock);
 
@@ -87,11 +147,74 @@ void nfs_local_disable(struct nfs_client *clp)
 	spin_unlock(&clp->cl_localio_lock);
 }
 
+/*
+ * nfs_init_localioclient - Initialise an NFS localio client connection
+ */
+static struct rpc_clnt *nfs_init_localioclient(struct nfs_client *clp)
+{
+	struct rpc_clnt *rpcclient_localio;
+
+	rpcclient_localio = rpc_bind_new_program(clp->cl_rpcclient,
+						 &nfslocalio_program, 1);
+
+	dprintk_rcu("%s: server (%s) %s NFS LOCALIO.\n",
+		__func__, rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR),
+		(IS_ERR(rpcclient_localio) ? "does not support" : "supports"));
+
+	return rpcclient_localio;
+}
+
+static bool nfs_server_uuid_is_local(struct nfs_client *clp)
+{
+	u8 uuid[UUID_SIZE];
+	struct rpc_message msg = {
+		.rpc_argp = &uuid,
+	};
+	struct rpc_clnt *rpcclient_localio;
+	int status;
+
+	rpcclient_localio = nfs_init_localioclient(clp);
+	if (IS_ERR(rpcclient_localio))
+		return false;
+
+	export_uuid(uuid, &clp->cl_uuid.uuid);
+
+	msg.rpc_proc = &nfs_localio_procedures[LOCALIOPROC_UUID_IS_LOCAL];
+	status = rpc_call_sync(rpcclient_localio, &msg, 0);
+	dprintk("%s: NFS reply UUID_IS_LOCAL: status=%d\n",
+		__func__, status);
+	rpc_shutdown_client(rpcclient_localio);
+
+	/* Server is only local if it initialized required struct members */
+	if (status || !clp->cl_uuid.net || !clp->cl_uuid.dom)
+		return false;
+
+	return true;
+}
+
 /*
  * nfs_local_probe - probe local i/o support for an nfs_server and nfs_client
+ * - called after alloc_client and init_client (so cl_rpcclient exists)
+ * - this function is idempotent, it can be called for old or new clients
  */
 void nfs_local_probe(struct nfs_client *clp)
 {
+	/* Disallow localio if disabled via sysfs or AUTH_SYS isn't used */
+	if (!localio_enabled ||
+	    clp->cl_rpcclient->cl_auth->au_flavor != RPC_AUTH_UNIX) {
+		nfs_local_disable(clp);
+		return;
+	}
+
+	if (nfs_client_is_local(clp)) {
+		/* If already enabled, disable and re-enable */
+		nfs_local_disable(clp);
+	}
+
+	nfs_uuid_begin(&clp->cl_uuid);
+	if (nfs_server_uuid_is_local(clp))
+		nfs_local_enable(clp);
+	nfs_uuid_end(&clp->cl_uuid);
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe);
 
@@ -121,7 +244,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		case -ENOMEM:
 		case -ENXIO:
 		case -ENOENT:
-			nfs_local_disable(clp);
+			/* Revalidate localio, will disable if unsupported */
+			nfs_local_probe(clp);
 		}
 		return NULL;
 	}
-- 
2.44.0


