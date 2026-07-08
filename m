Return-Path: <linux-nfs+bounces-23163-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c9ZiNBYBTmokBgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23163-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 09:49:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2212E722D2B
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 09:49:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BNDPRIQj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23163-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23163-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B0B8300BC8F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F23F44DB;
	Wed,  8 Jul 2026 07:45:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15383E8C6F
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 07:44:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496708; cv=none; b=nSvBFKggMRBgKREvXgvaq3hdduPlAZ2+cuCSCBoeX3q9767fK7huJSKqcSPcq3IdZeTaSUiq8g1QY/qJUux3FIX5LQzE8GHNuWzDhTe8FgXhHcioXHyPvb+2rGtoNQ8pfI0qlSzlVI487N72RWVqqqlrwoViGlbIHV/SDN++lyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496708; c=relaxed/simple;
	bh=jqj0r3q6L3OIGiTL2BopV2JGyk6NjkqJfJQ4+Ntw4PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c36NBal93pQBIllnyFCX15jkmiwk2wM09bwPUX709yej9rqum9jiebu0jemyYgZlz3NqJeEKrF5ljJsBBiddTCkBfNbeBCoDuCWbJddBO2C5Re7M/th7RrSZtmyW3dXcGSjXXKnwDRit4gEHrMvN6Pt72PQna+d+Wo4OfZGFuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNDPRIQj; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc61541f8cso20878435ad.0
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2026 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496696; x=1784101496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGyQ83WZlsWVe2RfNYRfTvhlBqgal+nfGOTUdmWAiDc=;
        b=BNDPRIQjiFD5DNDBtymah0cgGH0tL62dR/FEk1b+Hy1jELrAORjTXT4+Nss8R1GUI8
         FfJObA64gk+AWGdbVtQGpSOrcK2O1C9oyitFwVvhbOdPXLuCnovOxGMzHsWebcJJ9BM7
         ujZXXOO3oIBgFGk1rCmMwnxG+rzby4/Js0XNU/pi066lKCaRnP5NdXIoNzL9w3S5Ef3d
         mOuNTdti9gcMf0ktSNo31WVP5OYL0mGG2nEKglnMPupnV9hwj2FHP2An95M07Io4GGey
         jANcf6I26WN507e8X9A5VugOeVhNSjjl6MfA1ZvsZdsc4xt80Mtj8D/qufOZDpT4HGNW
         M1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496696; x=1784101496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LGyQ83WZlsWVe2RfNYRfTvhlBqgal+nfGOTUdmWAiDc=;
        b=BYBwHXD+SSx54hqY1bVSizXyJ+Gac44WZjrHN6j49g22w66fbHNd+X22QnwntmUwV1
         IoSQnynaKuEo0qqUfIbIUvWXQMQIHbFM0i00PxpmAWExWQaib80Pnc00IosPJDnGe7ij
         NVbxROIfil/V/CJjZ1ovQxCmdSxfWrb9QITTieexVhigkWjBMU5gWrID24+iuL/9lrrY
         2geDBRSOs49y9OH85K9z5Iyf6Hqz9n0rTysjuwKNS5QWDeakTuHhEeAMDrTTivJR5Ni/
         K17Pgt0kfAkU7tmi1HH0DOCXFC8C8Y4tWx1m6zsagZCn13DnWT8RzgOnkvpL0vgG7TOi
         dDWA==
X-Gm-Message-State: AOJu0Yx00Jm55qigI2Jrw4gF6G4jJWQKffVborx+hw8ukGBzMURZ6Lxv
	D2hgafgKRBzhGfuI9J8viJrndgJWaxAJkHdFJ7WS9kvOMmyCpGsFhKx0
X-Gm-Gg: AfdE7cnr/N55clGWEK1IFmg4HyN4zFHtgzEx7iRrm7Netxyz/Z9Mzb5/BeNfbL5xAx/
	wMnDEufEgdfZLWzYQpELYdT8sav8NJyanwwQr+E7x77WCwP1uPaSsGHMDOeu5fDOrG+dEfIWMiX
	bCLrUE7gGfb59i6AUbAoLFJ0ammGSqE9EtXsaB4zp1Bjbm4710TDgl5WB0Yproi0O/3D/kkWoAx
	8s3u6F1TcA42T5JS5U6x2a0rstLKreoelpr8AoDEMfSJLVjXY2LLyLAHlMit9RkNmUgZjAKRNSr
	IJCrmsdlLHUzYe43xv0gZB/Ji58QkcQaqQTfcXx4LzVfQz5JS4YO37Td75hgIzH88L6Xh7MUCWB
	SXcHk0J9Yg/K+iQwBsjyep7KkQY795vkWKf2oFYBYXjVpmR2Cn8pWOakAxY6TV2BBuUkflrOowx
	gnZpRDo1LDBrAIlQyjjt8T
X-Received: by 2002:a17:902:f788:b0:2ca:f417:396b with SMTP id d9443c01a7336-2ccca8c80b8mr56316115ad.3.1783496696395;
        Wed, 08 Jul 2026 00:44:56 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfe040sm23932035ad.31.2026.07.08.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:44:55 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	hui81.qi@samsung.com,
	j-young.choi@samsung.com,
	peng.yun@samsung.com,
	qian01.li@samsung.com,
	xing1.he@samsung.com,
	jeuk20.kim@samsung.com
Subject: [PATCH 2/2] NFSv4/flexfiles: support loosely coupled data servers
Date: Wed,  8 Jul 2026 16:44:33 +0900
Message-ID: <20260708074433.390161-3-jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708074433.390161-1-jeuk20.kim@samsung.com>
References: <20260708074433.390161-1-jeuk20.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-23163-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tigran.mkrtchyan@desy.de,m:hui81.qi@samsung.com,m:j-young.choi@samsung.com,m:peng.yun@samsung.com,m:qian01.li@samsung.com,m:xing1.he@samsung.com,m:jeuk20.kim@samsung.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jeuk20kim@gmail.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jeuk20kim@gmail.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:mid,samsung.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2212E722D2B

A flexfiles storage device is tightly coupled to the MDS only when the
decoded ds_versions[0].tightly_coupled flag is set (RFC 8435, sections
2.3 and 4.1). The client currently ignores that flag and treats every
data server as tightly coupled, which breaks I/O to loosely coupled DSes.

Two things force that assumption on an NFSv4.1+ DS:

  1) nfs4_set_ds_client() always sets NFS_CS_PNFS on the new client, so
     EXCHANGE_ID is sent with EXCHGID4_FLAG_USE_PNFS_DS.

  2) nfs4_init_ds_session() then calls is_ds_client() and returns -ENODEV
     if the reply does not carry EXCHGID4_FLAG_USE_PNFS_DS.

A loosely coupled DS is just a normal NFS server and does not act in the
pNFS DS role, so the client must not require it to advertise that role.

Thread the ds_versions[0].tightly_coupled flag from the flexfiles driver
down to the DS connect path. When it is false, skip both the NFS_CS_PNFS
flag and the is_ds_client() check. The file layout driver always passes
true because NFSv4.1 file layout data servers use the pNFS DS role.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 fs/nfs/filelayout/filelayoutdev.c         |  2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  3 ++-
 fs/nfs/internal.h                         |  3 ++-
 fs/nfs/nfs4client.c                       |  5 +++--
 fs/nfs/nfs4session.c                      |  5 +++--
 fs/nfs/nfs4session.h                      |  3 ++-
 fs/nfs/pnfs.h                             |  3 ++-
 fs/nfs/pnfs_nfs.c                         | 14 +++++++++-----
 8 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index 7226989ee4d5..d06d303fdcc3 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -280,7 +280,7 @@ nfs4_fl_prepare_ds(struct pnfs_layout_segment *lseg, u32 ds_idx)
 
 	status = nfs4_pnfs_ds_connect(s, ds, devid, dataserver_timeo,
 			     dataserver_retrans, 4,
-			     s->nfs_client->cl_minorversion);
+			     s->nfs_client->cl_minorversion, true);
 	if (status) {
 		nfs4_mark_deviceid_unavailable(devid);
 		ret = NULL;
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 1109462a9699..8be5c730e101 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -399,7 +399,8 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 	status = nfs4_pnfs_ds_connect(s, ds, &mirror->dss[dss_id].mirror_ds->id_node,
 			     dataserver_timeo, dataserver_retrans,
 			     mirror->dss[dss_id].mirror_ds->ds_versions[0].version,
-			     mirror->dss[dss_id].mirror_ds->ds_versions[0].minor_version);
+			     mirror->dss[dss_id].mirror_ds->ds_versions[0].minor_version,
+			     mirror->dss[dss_id].mirror_ds->ds_versions[0].tightly_coupled);
 
 	/* connect success, check rsize/wsize limit */
 	if (!status) {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index acaeff7ddfdf..030b885d41b9 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -250,7 +250,8 @@ extern struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 					     int ds_addrlen, int ds_proto,
 					     unsigned int ds_timeo,
 					     unsigned int ds_retrans,
-					     u32 minor_version);
+					     u32 minor_version,
+					     bool tightly_coupled);
 extern struct rpc_clnt *nfs4_find_or_create_ds_client(struct nfs_client *,
 						struct inode *);
 extern void nfs4_session_limit_rwsize(struct nfs_server *server);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 71c271a1700a..df49efd70641 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -791,7 +791,7 @@ static int nfs4_set_client(struct nfs_server *server,
 struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 		const struct sockaddr_storage *ds_addr, int ds_addrlen,
 		int ds_proto, unsigned int ds_timeo, unsigned int ds_retrans,
-		u32 minor_version)
+		u32 minor_version, bool tightly_coupled)
 {
 	struct rpc_timeout ds_timeout;
 	struct nfs_client *mds_clp = mds_srv->nfs_client;
@@ -838,7 +838,8 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 	if (test_bit(NFS_CS_NETUNREACH_FATAL, &mds_clp->cl_flags))
 		__set_bit(NFS_CS_NETUNREACH_FATAL, &cl_init.init_flags);
 
-	__set_bit(NFS_CS_PNFS, &cl_init.init_flags);
+	if (tightly_coupled)
+		__set_bit(NFS_CS_PNFS, &cl_init.init_flags);
 	cl_init.max_connect = NFS_MAX_TRANSPORTS;
 	/*
 	 * Set an authflavor equual to the MDS value. Use the MDS nfs_client
diff --git a/fs/nfs/nfs4session.c b/fs/nfs/nfs4session.c
index 993f0db7cf5e..175390e5b93f 100644
--- a/fs/nfs/nfs4session.c
+++ b/fs/nfs/nfs4session.c
@@ -626,7 +626,8 @@ int nfs4_init_session(struct nfs_client *clp)
 	return nfs41_check_session_ready(clp);
 }
 
-int nfs4_init_ds_session(struct nfs_client *clp, unsigned long lease_time)
+int nfs4_init_ds_session(struct nfs_client *clp, unsigned long lease_time,
+			 bool tightly_coupled)
 {
 	struct nfs4_session *session = clp->cl_session;
 	int ret;
@@ -652,7 +653,7 @@ int nfs4_init_ds_session(struct nfs_client *clp, unsigned long lease_time)
 	if (ret)
 		return ret;
 	/* Test for the DS role */
-	if (!is_ds_client(clp))
+	if (tightly_coupled && !is_ds_client(clp))
 		return -ENODEV;
 	return 0;
 }
diff --git a/fs/nfs/nfs4session.h b/fs/nfs/nfs4session.h
index d2569f599977..ee2f4baf16a1 100644
--- a/fs/nfs/nfs4session.h
+++ b/fs/nfs/nfs4session.h
@@ -122,7 +122,8 @@ extern int nfs4_setup_session_slot_tables(struct nfs4_session *ses);
 extern struct nfs4_session *nfs4_alloc_session(struct nfs_client *clp);
 extern void nfs4_destroy_session(struct nfs4_session *session);
 extern int nfs4_init_session(struct nfs_client *clp);
-extern int nfs4_init_ds_session(struct nfs_client *, unsigned long);
+extern int nfs4_init_ds_session(struct nfs_client *clp, unsigned long lease_time,
+				bool tightly_coupled);
 
 /*
  * Determine if sessions are in use.
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index eb39859c216c..97ad3366d2b9 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -421,7 +421,8 @@ struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(const struct net *net,
 void nfs4_pnfs_v3_ds_connect_unload(void);
 int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
 			  struct nfs4_deviceid_node *devid, unsigned int timeo,
-			  unsigned int retrans, u32 version, u32 minor_version);
+			  unsigned int retrans, u32 version, u32 minor_version,
+			  bool tightly_coupled);
 struct nfs4_pnfs_ds_addr *nfs4_decode_mp_ds_addr(struct net *net,
 						 struct xdr_stream *xdr,
 						 gfp_t gfp_flags);
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 0ff43dbcb7cd..99e54537edcc 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -881,7 +881,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				 struct nfs4_pnfs_ds *ds,
 				 unsigned int timeo,
 				 unsigned int retrans,
-				 u32 minor_version)
+				 u32 minor_version,
+				 bool tightly_coupled)
 {
 	struct nfs_client *clp = ERR_PTR(-EIO);
 	struct nfs_client *mds_clp = mds_srv->nfs_client;
@@ -971,12 +972,14 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 
 			clp = nfs4_set_ds_client(mds_srv, &da->da_addr,
 						 da->da_addrlen, ds_proto,
-						 timeo, retrans, minor_version);
+						 timeo, retrans, minor_version,
+						 tightly_coupled);
 			if (IS_ERR(clp))
 				continue;
 
 			status = nfs4_init_ds_session(clp,
-					mds_srv->nfs_client->cl_lease_time);
+					mds_srv->nfs_client->cl_lease_time,
+					tightly_coupled);
 			if (status) {
 				nfs_put_client(clp);
 				clp = ERR_PTR(-EIO);
@@ -1004,7 +1007,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
  */
 int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
 			  struct nfs4_deviceid_node *devid, unsigned int timeo,
-			  unsigned int retrans, u32 version, u32 minor_version)
+			  unsigned int retrans, u32 version, u32 minor_version,
+			  bool tightly_coupled)
 {
 	int err;
 
@@ -1027,7 +1031,7 @@ int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
 		break;
 	case 4:
 		err = _nfs4_pnfs_v4_ds_connect(mds_srv, ds, timeo, retrans,
-					       minor_version);
+					       minor_version, tightly_coupled);
 		break;
 	default:
 		dprintk("%s: unsupported DS version %d\n", __func__, version);
-- 
2.43.0


