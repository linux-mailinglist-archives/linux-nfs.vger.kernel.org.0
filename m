Return-Path: <linux-nfs+bounces-20185-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNxZBJcfuGlYZAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20185-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:19:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF929C280
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29F7308183D
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D598F39FCA6;
	Mon, 16 Mar 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdfpoFsK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332939F183;
	Mon, 16 Mar 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674112; cv=none; b=fOd73TVCHYSiwrKsrUVRhHfYnxAyWSt8bHj4guQ58/Ixan2hCX6WRNRy7p/ll5kBGHQXalt7PldTncCuLe2toqa0mkbYblQrA5hnDfeBrJxUMCs2kMkfAjP1+wnS58+ERxIHmErb+MlW08pg45jq/COxRSjMdKCBuKLKl60zKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674112; c=relaxed/simple;
	bh=N3IH110vSVveR9UotqARZCtiLBniRTymPztXiHOEEzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rlyxOdCitzQ3dR1rGAU9xTRDeyFa+QEuQe18fmk+8XYAoXePYNjXr6NxZPtIhCqVXiHdI4guKmmvEopXsrstKANEAdhsKjLO2Hou4EfjMVNi5JncUVf5mkr3ia+6SZPwgw+D71G1Ta1tpG44C6nw0Ia83dTq932x/z4/koVP5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdfpoFsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EEEC2BC87;
	Mon, 16 Mar 2026 15:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674112;
	bh=N3IH110vSVveR9UotqARZCtiLBniRTymPztXiHOEEzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EdfpoFsKjvD0gAz8U869cdsqNUh8O1Lod+4QqT0CaRbZEIa8B7NFAE37gL8NpNQxx
	 ros2MstF/Dkk2oHmEGcHiyxJaCQEf3bUnUv9Npx0ooMFGjg76rl3kL9m/O1fc78ThM
	 fG0EzE5h1G0Q6ppK6JSgUanrw3JJqDhC6rdCKF/v2y4pkB/eDQqtlmpa0xUQvOdX7D
	 9KtVB///Pik+xBArd+ahBUwQ1UOPQevQk/cOX6ei16+CKIf/4e9w267Ckg7axEHT85
	 qfXDRKt9DaOW/+rEPYwxX8jLKjPerIoZTBquujYXm5BptSPbL7pW7r+vQgLyF7+h3n
	 lEgVbGxAwDQrw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:35 -0400
Subject: [PATCH 01/14] nfsd: move struct nfsd_genl_rqstp to nfsctl.c
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-1-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=N3IH110vSVveR9UotqARZCtiLBniRTymPztXiHOEEzM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB56LRrKbhNqVJ8OdfCCgaPqj9zW4G5AQfRxv
 Fq3ZAvMuGOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgeegAKCRAADmhBGVaC
 FcZhD/sFkyyYU55oTQhvjzlnwWt7soz+d5CmTIzVOyBv0Oy1k+cluI3R78oC9Wv9TVSmHOhqjaA
 dmElHoXkY1t/WmGGeom+TMdURoIe4icj7xQ5cklbvv9+UVm4hkRrIFx++HNQEpjaMuCcqpEtQew
 BoEN99pd21qe5Dni3+xmEK4e1eW2UoKtUsb4X/JkOlgBwIP/V4o18MnLp7HW8aMXT1FM1cgf2eN
 OqEsRGhQhJnBHSc7uiDsKMGv/QVWEjBCUd4kdZGh19xZ4gXj6M6er2sDNkR3PHjQD/VgoY61/+a
 vQi+R9SmJmsuESlZegrmeRi30yKNfbg0GEWPqX0QbGMYEep3WN6Vh6emIvMhkbIlt7cKAMOsY/N
 jqWlpUR/bFMnOzhMSLrFl7C91p3MtyKvQsaaGAFLX41BGSpkLl5YdjGY/lBn+bLYvBnT0oYZQ98
 0jaFrGi/EDLrbGLYAwEjCPUL0QYYPub1Y9oSK0sMPlu8Ab+1wljFoJ6PbPcjJ0S9B55/NRPhLDv
 KM01PcWlNd6OF5yLqRfEUMMlDcr5+NW3yP6XGMEP8ahi9RZDoukjbo42U0IZ1fBkXMSZNreB8LA
 IzzekpAjyanu7kwOQHpC+EX3+EcqbcKlWtOgx+AHX95RYfaY/+lwYt2iFXVawng+5ZdOlAFcZPe
 UH28BDJesoGO91g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20185-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69CF929C280
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It's not used outside of that file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 15 +++++++++++++++
 fs/nfsd/nfsd.h   | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 988a79ec4a79af2f9c9406be9740d1922c2b4ec8..dc294c4f8c58a6692b9dfbeb98fedbd649ae1b95 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1412,6 +1412,21 @@ static int create_proc_exports_entry(void)
 
 unsigned int nfsd_net_id;
 
+struct nfsd_genl_rqstp {
+	struct sockaddr		rq_daddr;
+	struct sockaddr		rq_saddr;
+	unsigned long		rq_flags;
+	ktime_t			rq_stime;
+	__be32			rq_xid;
+	u32			rq_vers;
+	u32			rq_prog;
+	u32			rq_proc;
+
+	/* NFSv4 compound */
+	u32			rq_opcnt;
+	u32			rq_opnum[16];
+};
+
 static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 					    struct netlink_callback *cb,
 					    struct nfsd_genl_rqstp *genl_rqstp)
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 7c009f07c90b50d7074695d4665a2eca85140eda..260bf8badb032de18f973556fa5deabe7e67870d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -60,21 +60,6 @@ struct readdir_cd {
 /* Maximum number of operations per session compound */
 #define NFSD_MAX_OPS_PER_COMPOUND	200
 
-struct nfsd_genl_rqstp {
-	struct sockaddr		rq_daddr;
-	struct sockaddr		rq_saddr;
-	unsigned long		rq_flags;
-	ktime_t			rq_stime;
-	__be32			rq_xid;
-	u32			rq_vers;
-	u32			rq_prog;
-	u32			rq_proc;
-
-	/* NFSv4 compound */
-	u32			rq_opcnt;
-	u32			rq_opnum[16];
-};
-
 extern struct svc_program	nfsd_programs[];
 extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;

-- 
2.53.0


