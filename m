Return-Path: <linux-nfs+bounces-4209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7909B911A2D
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 07:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCCC282288
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 05:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D986412C801;
	Fri, 21 Jun 2024 05:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gi4m/b0M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yI4PgCXD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gi4m/b0M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yI4PgCXD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A1762C1
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 05:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946672; cv=none; b=jEQcvcTEonthrOqE2xwmLpx1Be0/g2fNMLVZFDeZa1h3hFxNXbW4u/fojtVt8u+Up5+n0odVbHFk1dIZSCSO3DLXXqqc9cW4iSaYugY3ip5uodHqfa6QtIF3cy8bTZm59ivOboL/4L6V4t14NyXi+lLp4WD1tQFR5jdeSSgZdEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946672; c=relaxed/simple;
	bh=ASftAykhJIdU912ync4Joj75gKn3rnFZ1Niri59BviQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhOge3EDArcG6akBnPXOnleD26pfvlBu0vPIb43LONUTsYTXVOG5AL8CS+c1mcrKa2oBP3slkj0+URSuSE4Y4soJMP8H8VUn0jRL9YDH76TJ61ZUmBjUo6dTj8biC273h1JJdJYudUIOeh22TtEAdnFMfwbQaBbuZySkO0Eorp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gi4m/b0M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yI4PgCXD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gi4m/b0M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yI4PgCXD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D47EA1FB3B;
	Fri, 21 Jun 2024 05:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718946668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luiAecsNR/ofoV9Fiae/XBe2lw4Kp9AMQYOS2TTHXgU=;
	b=gi4m/b0MTtWkM3i+B2gDnTGdzhKMgA8vfiUQIoV/evj1DPh8Xin4tS81jzS3xhICbTQS8T
	pXUecmHOL2RsChtyY7JlMmjPK3LSewbfXN9EXBXmKanOW0NJuYXxOmX+PYtL0I8RGrI5ru
	4DMQoDHeLw8NUofuRI78OcdpxwYlLCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718946668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luiAecsNR/ofoV9Fiae/XBe2lw4Kp9AMQYOS2TTHXgU=;
	b=yI4PgCXDjzWxBbHiZC3QnIT96uDnR3wdheRmCwIiEmg2JqB3tOKAc8Rnls/25PIHmG01s6
	dmYATPNbToEPU7Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718946668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luiAecsNR/ofoV9Fiae/XBe2lw4Kp9AMQYOS2TTHXgU=;
	b=gi4m/b0MTtWkM3i+B2gDnTGdzhKMgA8vfiUQIoV/evj1DPh8Xin4tS81jzS3xhICbTQS8T
	pXUecmHOL2RsChtyY7JlMmjPK3LSewbfXN9EXBXmKanOW0NJuYXxOmX+PYtL0I8RGrI5ru
	4DMQoDHeLw8NUofuRI78OcdpxwYlLCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718946668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luiAecsNR/ofoV9Fiae/XBe2lw4Kp9AMQYOS2TTHXgU=;
	b=yI4PgCXDjzWxBbHiZC3QnIT96uDnR3wdheRmCwIiEmg2JqB3tOKAc8Rnls/25PIHmG01s6
	dmYATPNbToEPU7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B85813AAA;
	Fri, 21 Jun 2024 05:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rBAQEGoLdWb0agAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 21 Jun 2024 05:11:06 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH 2/3] NFSD: Simplify server NFS_LOCALIO_PROGRAM support
Date: Fri, 21 Jun 2024 14:59:29 +1000
Message-ID: <20240621050857.20075-3-neilb@suse.de>
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
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.945];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,brown.name:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

From: NeilBrown <neil@brown.name>

This patch is intended to be squashed into
 nfsd: implement v3 and v4 server support for NFS_LOCALIO_PROGRAM

It moves all code for the LOCALIO RPC programs into localio.c with a
little bit in nfssvc.c, and implements just a single version.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/localio.c | 106 +++++++++-------------------------------------
 fs/nfsd/nfsd.h    |  11 -----
 fs/nfsd/nfssvc.c  |  59 ++------------------------
 fs/nfsd/xdr.h     |   6 ---
 4 files changed, 23 insertions(+), 159 deletions(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 6707eec462e6..dee3872a4552 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -18,8 +18,6 @@
 #include "netns.h"
 #include "filecache.h"
 #include "cache.h"
-#include "xdr3.h"
-#include "xdr4.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_FH
 
@@ -262,48 +260,39 @@ static __be32 nfsd_proc_null(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+struct nfsd_getuuidres {
+	uuid_t			uuid;
+};
+
 static __be32 nfsd_proc_getuuid(struct svc_rqst *rqstp)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct nfsd_getuuidres *resp = rqstp->rq_resp;
 
 	uuid_copy(&resp->uuid, &nn->nfsd_uuid.uuid);
-	resp->status = nfs_ok;
 
 	return rpc_success;
 }
 
-#define NFS_getuuid_sz XDR_QUADLEN(UUID_SIZE)
-
 static inline void encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
 {
 	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
 }
 
-static void encode_uuid(struct xdr_stream *xdr, uuid_t *src_uuid)
+static bool nfslocalio_encode_getuuidres(struct svc_rqst *rqstp,
+				      struct xdr_stream *xdr)
 {
+	struct nfsd_getuuidres *resp = rqstp->rq_resp;
 	u8 uuid[UUID_SIZE];
 
-	export_uuid(uuid, src_uuid);
+	export_uuid(uuid, &resp->uuid);
 	encode_opaque_fixed(xdr, uuid, UUID_SIZE);
 	dprintk("%s: uuid=%pU\n", __func__, uuid);
-}
-
-#if defined(CONFIG_NFSD_V3_LOCALIO)
-static bool nfs3svc_encode_getuuidres(struct svc_rqst *rqstp,
-				      struct xdr_stream *xdr)
-{
-	struct nfsd_getuuidres *resp = rqstp->rq_resp;
-
-	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return false;
-	if (resp->status == nfs_ok)
-		encode_uuid(xdr, &resp->uuid);
 
 	return true;
 }
 
-static const struct svc_procedure nfsd_localio_procedures3[2] = {
+static const struct svc_procedure nfsd_localio_procedures[2] = {
 	[LOCALIOPROC_NULL] = {
 		.pc_func = nfsd_proc_null,
 		.pc_decode = nfssvc_decode_voidarg,
@@ -311,86 +300,29 @@ static const struct svc_procedure nfsd_localio_procedures3[2] = {
 		.pc_argsize = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = 1,
+		.pc_xdrressize = 0,
 		.pc_name = "NULL",
 	},
 	[LOCALIOPROC_GETUUID] = {
 		.pc_func = nfsd_proc_getuuid,
 		.pc_decode = nfssvc_decode_voidarg,
-		.pc_encode = nfs3svc_encode_getuuidres,
+		.pc_encode = nfslocalio_encode_getuuidres,
 		.pc_argsize = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_getuuidres),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = 1+NFS_getuuid_sz,
+		.pc_xdrressize = XDR_QUADLEN(UUID_SIZE),
 		.pc_name = "GETUUID",
 	},
 };
 
 static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nfsd_localio_count3[ARRAY_SIZE(nfsd_localio_procedures3)]);
-const struct svc_version nfsd_localio_version3 = {
-	.vs_vers	= 3,
+			      nfsd_localio_count[ARRAY_SIZE(nfsd_localio_procedures)]);
+const struct svc_version nfsd_localio_version1 = {
+	.vs_vers	= 1,
 	.vs_nproc	= 2,
-	.vs_proc	= nfsd_localio_procedures3,
+	.vs_proc	= nfsd_localio_procedures,
 	.vs_dispatch	= nfsd_dispatch,
-	.vs_count	= nfsd_localio_count3,
-	.vs_xdrsize	= NFS3_SVC_XDRSIZE,
-};
-#endif /* CONFIG_NFSD_V3_LOCALIO */
-
-#if defined(CONFIG_NFSD_V4_LOCALIO)
-static bool nfs4svc_encode_getuuidres(struct svc_rqst *rqstp,
-				      struct xdr_stream *xdr)
-{
-	struct nfsd_getuuidres *resp = rqstp->rq_resp;
-	__be32 *p;
-
-	p = xdr_reserve_space(xdr, 8);
-	if (!p)
-		return 0;
-	*p++ = cpu_to_be32(LOCALIOPROC_GETUUID);
-	*p++ = resp->status;
-
-	if (resp->status == nfs_ok)
-		encode_uuid(xdr, &resp->uuid);
-
-	return 1;
-}
-
-static const struct svc_procedure nfsd_localio_procedures4[2] = {
-	[LOCALIOPROC_NULL] = {
-		.pc_func = nfsd_proc_null,
-		.pc_decode = nfssvc_decode_voidarg,
-		.pc_encode = nfssvc_encode_voidres,
-		.pc_argsize = sizeof(struct nfsd_voidargs),
-		.pc_ressize = sizeof(struct nfsd_voidres),
-		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = 1,
-		.pc_name = "NULL",
-	},
-	[LOCALIOPROC_GETUUID] = {
-		.pc_func = nfsd_proc_getuuid,
-		.pc_decode = nfssvc_decode_voidarg,
-		.pc_encode = nfs4svc_encode_getuuidres,
-		.pc_argsize = sizeof(struct nfsd_voidargs),
-		.pc_ressize = sizeof(struct nfsd_getuuidres),
-		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = 2+NFS_getuuid_sz,
-		.pc_name = "GETUUID",
-	},
-};
-
-static DEFINE_PER_CPU_ALIGNED(unsigned long,
-			      nfsd_localio_count4[ARRAY_SIZE(nfsd_localio_procedures4)]);
-const struct svc_version nfsd_localio_version4 = {
-	.vs_vers	        = 4,
-	.vs_nproc	        = 2,
-	.vs_proc	        = nfsd_localio_procedures4,
-	.vs_dispatch	        = nfsd_dispatch,
-	.vs_count	        = nfsd_localio_count4,
-	.vs_xdrsize	        = NFS4_SVC_XDRSIZE,
-	.vs_rpcb_optnl		= true,
-	.vs_need_cong_ctrl	= true,
-
+	.vs_count	= nfsd_localio_count,
+	.vs_xdrsize	= XDR_QUADLEN(UUID_SIZE),
+	.vs_hidden	= true,
 };
-#endif /* CONFIG_NFSD_V4_LOCALIO */
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4f51f95df294..cec8697b1cd6 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -143,17 +143,6 @@ extern const struct svc_version nfsd_acl_version3;
 #endif
 #endif
 
-#if defined(CONFIG_NFSD_V3_LOCALIO)
-extern const struct svc_version nfsd_localio_version3;
-#else
-#define nfsd_localio_version3 NULL
-#endif
-#if defined(CONFIG_NFSD_V4_LOCALIO)
-extern const struct svc_version nfsd_localio_version4;
-#else
-#define nfsd_localio_version4 NULL
-#endif
-
 struct nfsd_net;
 
 enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 48bfd3c6d619..bc69a2c90077 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -38,16 +38,6 @@
 atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
-#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
-static int			nfsd_localio_rpcbind_set(struct net *,
-						     const struct svc_program *,
-						     u32, int,
-						     unsigned short,
-						     unsigned short);
-static __be32			nfsd_localio_init_request(struct svc_rqst *,
-						const struct svc_program *,
-						struct svc_process_info *);
-#endif /* CONFIG_NFSD_LOCALIO */
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static int			nfsd_acl_rpcbind_set(struct net *,
 						     const struct svc_program *,
@@ -92,16 +82,11 @@ unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
 #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+extern const struct svc_version nfsd_localio_version1;
 static const struct svc_version *nfsd_localio_version[] = {
-#if defined(CONFIG_NFSD_V3_LOCALIO)
-	[3] = &nfsd_localio_version3,
-#endif
-#if defined(CONFIG_NFSD_V4_LOCALIO)
-	[4] = &nfsd_localio_version4,
-#endif
+	[1] = &nfsd_localio_version1,
 };
 
-#define NFSD_LOCALIO_MINVERS            3
 #define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(nfsd_localio_version)
 
 static struct svc_program	nfsd_localio_program = {
@@ -111,8 +96,8 @@ static struct svc_program	nfsd_localio_program = {
 	.pg_name		= "nfslocalio",
 	.pg_class		= "nfsd",
 	.pg_authenticate	= &svc_set_client,
-	.pg_init_request	= nfsd_localio_init_request,
-	.pg_rpcbind_set		= nfsd_localio_rpcbind_set,
+	.pg_init_request	= svc_generic_init_request,
+	.pg_rpcbind_set		= svc_generic_rpcbind_set,
 };
 #endif /* CONFIG_NFSD_LOCALIO */
 
@@ -875,42 +860,6 @@ nfsd_svc(int n, int *nthreads, struct net *net, const struct cred *cred, const c
 	return error;
 }
 
-#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
-static bool
-nfsd_support_localio_version(int vers)
-{
-	if (vers >= NFSD_LOCALIO_MINVERS && vers < NFSD_LOCALIO_NRVERS)
-		return nfsd_localio_version[vers] != NULL;
-	return false;
-}
-
-static int
-nfsd_localio_rpcbind_set(struct net *net, const struct svc_program *progp,
-			u32 version, int family, unsigned short proto,
-			unsigned short port)
-{
-	if (!nfsd_support_localio_version(version) ||
-	    !nfsd_vers(net_generic(net, nfsd_net_id), version, NFSD_TEST))
-		return 0;
-	return svc_generic_rpcbind_set(net, progp, version, family,
-			proto, port);
-}
-
-static __be32
-nfsd_localio_init_request(struct svc_rqst *rqstp,
-			const struct svc_program *progp,
-			struct svc_process_info *ret)
-{
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-
-	if (likely(nfsd_support_localio_version(rqstp->rq_vers) &&
-	    nfsd_vers(nn, rqstp->rq_vers, NFSD_TEST)))
-		return svc_generic_init_request(rqstp, progp, ret);
-
-	return rpc_prog_unavail;
-}
-#endif /* CONFIG_NFSD_LOCALIO */
-
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static bool
 nfsd_support_acl_version(int vers)
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 5714469af597..852f71580bd0 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -5,7 +5,6 @@
 #define LINUX_NFSD_H
 
 #include <linux/vfs.h>
-#include <linux/uuid.h>
 #include "nfsd.h"
 #include "nfsfh.h"
 
@@ -124,11 +123,6 @@ struct nfsd_statfsres {
 	struct kstatfs		stats;
 };
 
-struct nfsd_getuuidres {
-	__be32			status;
-	uuid_t			uuid;
-};
-
 /*
  * Storage requirements for XDR arguments and results.
  */
-- 
2.44.0


