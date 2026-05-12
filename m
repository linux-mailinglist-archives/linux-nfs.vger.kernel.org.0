Return-Path: <linux-nfs+bounces-21571-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONzrNjhuA2rF5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21571-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEAC52723E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 579FA30690CB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A220A36B043;
	Tue, 12 May 2026 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOXnKCuP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F916343D9D
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609667; cv=none; b=gEleQtrGcVpYfobe/bUnA0cKwU6WGymhwCbhudQw94cTbfQ3YtmMVuzQflc1uMe6RktwLd9b104R4/m9l9JarHGv2UrM1zO/xLBkRhJdiFcN60elm5ptnQjqefbpFlCl917DcA6PHZvyAGwoOs56Zah4yZW2GXuuFoeK7t92kAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609667; c=relaxed/simple;
	bh=uwpoMd7eqQC9Z+0+52vhv8E7rEgPf9PKO8fPEjyWM3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkrCQgvMrS5r2BD3PV+pAQCl12rrkYr7vbVfiBHwPFutAJ/XisQHTHTRmh7fOG1rqHrFbIoTZI17fx0Lh/yNwGJ+/gnfg4PsmsCIkLDrBMC8t/O2umpROaKU70pYHrx/9Mv9tq+bxELbttXjS5hwGwh1GkerAThFwM01XCvXDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOXnKCuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7F4C2BCC7;
	Tue, 12 May 2026 18:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609667;
	bh=uwpoMd7eqQC9Z+0+52vhv8E7rEgPf9PKO8fPEjyWM3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DOXnKCuPdqH1dajJMZZZu1uBb2OG1Wsgst141jLOWk7Ch3yrMx3p5ZGdV56vaGb7J
	 9m8Hh/4FTLg2KF5+RrCnM+g2muG/D5FzpJ8T+EPdolHAX3HdpsdcGdVsC+W8akGJwq
	 9fCfCKbqQjoDefjfGZX5A6TkmPzYHy/dufhQLRmbyjoURSPmtbeIQaaaUN3NEEqMqH
	 jXeAsEfyjZLDZxc5J2Tsrqr3GbNt/WP/VuaWWidhnsErNgXSIsmvSrjaRudPe1/aUB
	 Ddx0ZSGTwiyhn9kLtLYkb2igxuSiafMj7Oey/ARVnWlArxe1S31WJ7/JMzoD2a3cpY
	 oUvNSGtVchK9g==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:06 -0400
Subject: [PATCH 31/38] lockd: Convert NLMv3 server-side undefined
 procedures to xdrgen
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-31-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3702;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=aSq4GIYpiOry0xBdEmnbDmC+gE5jlL7PGbg3OZiSiAU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23m3BB2biMPXdeYr/n6TTQvw34pFswS6Y2ef
 buFb/2S9bKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 l3cTD/9BEkZMUeD5pBgtZUGsOhH2WcBeFREU6FKESyXTtji8Dp483MZzZ1T5s9iocclDwEAvnkY
 FauIkiNLimt5+XS0FpEv8y3YJXXvQBnPQWr8smhq/kBvm49dMEqNWO5oRz8yL7+MFjhWP9MQRA3
 QgC3S1eEiZ0x8/Z2Q6Ud/n1JxwQgd+oJx9x9TdZq+AP+uoOMzfwrPICGjKb3N5anWsr7XVT/cbR
 eu/CgYA8qHJ5HD47OSe7JOT/+sZE4LRBIg50mpzfF+T/dyEzRJULguxqE5o0lx3Y+7CcY4eBrj9
 dM8IBU6CH8ABNRVzmv2l/vdtzViL/Oe3t8undaZ43rFQLaE2B4ZE4ZWLV2sp7Uc/D4N0cyls/Hn
 +qM65dPJc13IOY6xFrg8gvokYySb5Hopj38RhLWG+LVmYzxTyRAe/6tWVT+py7XeZ78vvApX8uZ
 YUw+K0AJNhNUMhiF8I2lInm6TnGF/KpsMeorjPFEov+WOlf/TMYZWMHMsf4UVzcoJgGwOlfUkzo
 mc3W00m/118ofmfCRoNn6xEKgOD46m+utzRVzJQ9BL6bqCWDdkBL6J8+jJBWeJZHhioUtc98Z5j
 whkN9XthOYyo6SYG8DV3JMA0SzFVWuF0ofAnVSfTef8fJs7+LY1YeT7rwMyK9txQg+n2mMH4Ltz
 8ZCMNlwFgPrHDhQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: BEEAC52723E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21571-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Complete the xdrgen migration of NLMv3 server-side
procedures by converting the three unused procedure slots
(17, 18, and 19). These slots already returned
rpc_proc_unavail; they are converted here only to retire
the last users of the hand-coded nlmsvc_decode_void and
nlmsvc_encode_void helpers.

The three undefined procedure entries now use the xdrgen
functions nlm_svc_decode_void and nlm_svc_encode_void. The
nlmsvc_proc_unused function is also moved earlier in the
file to follow the convention of placing procedure
implementations before the procedure table.

The pc_argsize, pc_ressize, and pc_argzero fields are now
set to zero since no arguments or results are processed.
Setting pc_xdrressize to XDR_void reflects that these
procedures return no reply payload; the previous value of
St over-reserved a status word in the reply buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 66 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index e0328dc89deb..79c410a75156 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -1067,6 +1067,18 @@ static __be32 nlmsvc_proc_sm_notify(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+/**
+ * nlmsvc_proc_unused - stub for unused procedures
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_proc_unavail:	Program can't support procedure.
+ */
+static __be32 nlmsvc_proc_unused(struct svc_rqst *rqstp)
+{
+	return rpc_proc_unavail;
+}
+
 /*
  * SHARE: create a DOS share or alter existing share.
  */
@@ -1174,12 +1186,6 @@ nlmsvc_proc_free_all(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-static __be32
-nlmsvc_proc_unused(struct svc_rqst *rqstp)
-{
-	return rpc_proc_unavail;
-}
-
 /*
  * NLM Server procedures.
  */
@@ -1363,34 +1369,34 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_name	= "SM_NOTIFY",
 	},
 	[17] = {
-		.pc_func = nlmsvc_proc_unused,
-		.pc_decode = nlmsvc_decode_void,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "UNUSED",
+		.pc_func	= nlmsvc_proc_unused,
+		.pc_decode	= nlm_svc_decode_void,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= 0,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNUSED",
 	},
 	[18] = {
-		.pc_func = nlmsvc_proc_unused,
-		.pc_decode = nlmsvc_decode_void,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "UNUSED",
+		.pc_func	= nlmsvc_proc_unused,
+		.pc_decode	= nlm_svc_decode_void,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= 0,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNUSED",
 	},
 	[19] = {
-		.pc_func = nlmsvc_proc_unused,
-		.pc_decode = nlmsvc_decode_void,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "UNUSED",
+		.pc_func	= nlmsvc_proc_unused,
+		.pc_decode	= nlm_svc_decode_void,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= 0,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNUSED",
 	},
 	[NLMPROC_SHARE] = {
 		.pc_func = nlmsvc_proc_share,

-- 
2.54.0


