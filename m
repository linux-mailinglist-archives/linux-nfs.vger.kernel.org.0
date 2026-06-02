Return-Path: <linux-nfs+bounces-22215-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aepFAcAEH2p/dQAAu9opvQ
	(envelope-from <linux-nfs+bounces-22215-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:28:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C940630323
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:28:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TaokMivu;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22215-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22215-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3E6630C9291
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1956368D7A;
	Tue,  2 Jun 2026 16:23:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3647372EF7;
	Tue,  2 Jun 2026 16:23:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417423; cv=none; b=IMbacN2p5MlZbqU5NCjRtpaXOaNUk2ETJaUarPwk16l814ezBf371+Qm7bPqH8F6KfbcDKGIsuobc11XuRBF8KI9rFJRoCCOSrT6s+NWAedYHarVEqR3YUbwFvIBIE1/n3JsIhvbJ5Ql/5AukjIAvgZbC7LZPzDCpp7Mn0PGsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417423; c=relaxed/simple;
	bh=+Ubre8QpYtKO3e9ex0dIdwJtPoz/vECXWGeLxuVlxiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKu0wN+II3KwJ1FowtoGRCz1MUD6mQtwU6Z2f4vufqMknuShs6og9WIrLK2sc9C3xH1ma6Ef7xrBtIXqm9xtXXYUJIKXi6yyX4DZ6AWJjhaLLmT2wBXDkp2G3fkfdi3SSKuR4tpmyWb+TbavqqOeCBfP0uWVL1CXD86LcQciGqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaokMivu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2F21F00893;
	Tue,  2 Jun 2026 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417422;
	bh=y9cLzj44jng+XH860E6rPj8qhAmptMmQLurtzyF05hU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TaokMivu3eYc5yfD+kd6thL/ab8BUq62D03Ppud6M9xLilOs+f5vkwuqUvAG2GXtF
	 ekIuiSIUxBjNTmq3sDaZTl0doV6XjHf2ELZYr8QqOxjuYsfPt5PWiCETuclWP/g8yl
	 ZCAfB41VBPoykwBcCCqGe84aZ2+or+2cT9wcPiyZ/emc1v5l1zMegJ/b3iBa/Ksc83
	 +6GpXndEWlnoBdkRSO5lFSzUULWw25RQh4/g6bbdxXUvLOnQSuZubP+Mvs3xISPw4w
	 JU1whZboZ5ga0fudRIZzRNUti+i208GEZowWdp+PgI01bFTDdyc4j03MvkUECJ4zf7
	 dNV2NdeDD7llw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 02 Jun 2026 12:23:21 -0400
Subject: [PATCH v2 9/9] nfsd: unify cleanups in nfsd_cross_mnt() exits
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-nfsd-testing-v2-9-e4ea62e3cd5c@kernel.org>
References: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
In-Reply-To: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@meta.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CuryIm7jNoF/fQtSYpxyaGIXD7K43W0WNnJiGRZWj+c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHwN9AIYtNwy3QGSFjrUHLhTHcyz6ToKXVC1VB
 4HdVhBdhxSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah8DfQAKCRAADmhBGVaC
 Fd0cEACJb6oEd9Cwr6EJQ0UOJiRLZsDF5lzsi2rvkjXl7zpwzPpuojv3H4BOvZkSyHuM3Cp6+Be
 xf5yGVQRPzNROJRVWHFWNYvcmT8NJjrAIowbddWCDY72TOI/QfXh/jpWESmGDCOGn+QfBit43HX
 e6pnERBoxCn1LVQsOaGO0+6RW15SKLBjqPLaCWQJXrgIn9XfF5+mU1d00Y9qS93Jwec+GnXNk49
 eNhY3G1bKM/9Pr6ju7Kk8oG5J+95lygu/p6TcnCiPkqm3uVgR3PzejBM8CWXnAjf4s3v3ictBF7
 9YV5MkeSeo8LjTKQhz80p3nX4D3+9HRSq5cdJqT5C58IzFuWH8zlhK65N+PK0/pRhL4mQFtBlHq
 ki/oXhAxrfJa64xMcIXlCG3JkYWXumPwT873PQQgdfVtohqjl4eEee72dMPIdnycRIjczsmepyS
 YLJpqlph705awEqn2ML9V2RmlKjtMi2XnKTqT2eEa8p4Bm+R1aVH6K4D35i+lpQJsPC2frotKkx
 CqC0JUS9cdc11llezkp8xMSiwsiymWCUIpkhgGO4PzTMnS+5mN4r2KTOi45uf5G3Xai3eimT0EY
 /ImDHTuEl90ZkHLXdb84ixinaBvdtxsrhsvLDCCMhHntcMkVuqoZXRb0ipMiUsn5p12Y/XGRHd7
 DEvg/PIwFL33Aiw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22215-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C940630323

From: Al Viro <viro@zeniv.linux.org.uk>

Instead of having a separate path_put() on each failure exit, as well as
on the normal path, let's move all of those past the point where these
codepaths join.  We want to keep the ordering between path_put() and
exp_put(), so move that one as well.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 95ce15440492..cfac0cc4207c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -137,20 +137,19 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		follow_flags = LOOKUP_AUTOMOUNT;
 
 	err = follow_down(&path, follow_flags);
-	if (err < 0) {
-		path_put(&path);
+	if (err < 0)
 		goto out;
-	}
+
 	if (path.mnt == exp->ex_path.mnt && path.dentry == dentry &&
 	    nfsd_mountpoint(dentry, exp) == 2) {
 		/* This is only a mountpoint in some other namespace */
-		path_put(&path);
 		goto out;
 	}
 
 	exp2 = rqst_exp_get_by_name(rqstp, &path);
 	if (IS_ERR(exp2)) {
 		err = PTR_ERR(exp2);
+		exp2 = NULL;
 		/*
 		 * We normally allow NFS clients to continue
 		 * "underneath" a mountpoint that is not exported.
@@ -160,10 +159,7 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		 */
 		if (err == -ENOENT && !(exp->ex_flags & NFSEXP_V4ROOT))
 			err = 0;
-		path_put(&path);
-		goto out;
-	}
-	if (nfsd_v4client(rqstp) ||
+	} else if (nfsd_v4client(rqstp) ||
 		(exp->ex_flags & NFSEXP_CROSSMOUNT) || EX_NOHIDE(exp2)) {
 		/* successfully crossed mount point */
 		/*
@@ -177,9 +173,10 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		*expp = exp2;
 		exp2 = exp;
 	}
-	path_put(&path);
-	exp_put(exp2);
 out:
+	path_put(&path);
+	if (exp2)
+		exp_put(exp2);
 	return err;
 }
 

-- 
2.54.0


