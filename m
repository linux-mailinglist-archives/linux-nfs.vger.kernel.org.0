Return-Path: <linux-nfs+bounces-20907-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB7IM9on4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20907-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3905E413A87
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C9530E4C7E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E212333426;
	Thu, 16 Apr 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfBw539x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF29F334C3D
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363302; cv=none; b=pvU90MOxT+prG15rIrbYupxL/koP01+HNU5KsP6M3mRjAzJQo2/9A6JilZSB6P3ITSm4WMehdtP+D7Now58II/48TFT+Rzttk7y/OZnCq4RHZ3Dx6MO76+FWXF5e3rNwJv95bhiEDHxGfGpXB28GG12oDTree119wWbb9wGcZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363302; c=relaxed/simple;
	bh=l0qSI8RFhWgb5M/l9SuTySYU7H476Am5bdew1GKj9XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBKG7YxKNxTFikouIrENVOy+xGv+OJdGcTwXHwnPA4l/AgN/ucfH5NAzrcXRUHHkOCj2j+p6qXhnsPI8vQFngkrw7Crmu8G+dpkvILMIWzVbwW5LL7L9PEdZSpEBfxjSTzXpGz24SEYESiEZUMUO3vd3zeIxaWn6DfzXai00+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfBw539x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70350C2BCAF;
	Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363302;
	bh=l0qSI8RFhWgb5M/l9SuTySYU7H476Am5bdew1GKj9XI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mfBw539x8FgX+FxV3S/GvcpXg4f4+zNGVbPAeVSwzCsAFaOUC1tiQzxykX0FJsrnW
	 VwEAyEfc/AKmOTvUpkTRGOFgpgzxC05rKF6Qpxi+CK5wb7i+TOPmuLwweqxqdhh4X2
	 JwfDlOZjloMlsR6k7GZ2WTQp3qdihrG/zjSQFTiJF4UULJs6bWR/DPZ/PLf3t00uty
	 DPFLhAmzhMVB8ihgdTBFIjVU2TktDhXwEFWrqxXODIgkjRpi/1Wk9Tmp6NQkqv70QJ
	 MWzW23Fd8KH0khj7ZYsFDcO4hRiZ4uMYhlIFyfS8RapqjCBrx6xMYlTQ0hIzg1/NVz
	 En4ncRohdGM+A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:37 -0700
Subject: [PATCH pynfs v2 05/25] server41tests: pass_warn() when server
 doesn't support dir delegations
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-5-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2326; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=l0qSI8RFhWgb5M/l9SuTySYU7H476Am5bdew1GKj9XI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScfSu8Jf1st1f1unsvGsb7jcQ86zef0/cBZi
 qMK/pr04+SJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnHwAKCRAADmhBGVaC
 FQtDD/9dRCnegBLJtzlTr0aX7Q3S+PbnH2dezH4GZU+HW13IloNlQmHXKnzvolYC7uPh0c6mlod
 VuxBBywAOB4i8AYBP5TNO2SV/mx103Qp6O6mTKRjTy58Dn2T8lwuSWNRVGBHhnN3yi1SkDLUes3
 5kuQH0d3ImVZq05TLtInbtAIusLYTI6EyV6X28OfVniJqFAldeE6XPsdvFFamB7eRa3mMSDCmx9
 vncrGFvyOJBWrRfswP42zntyqxkwVFek7HzGmsqAZTJWEVfnRKE9jwtInmcYE94EHCXxzk3OGz1
 qpteKc1LR+m3VSa9eGGASTVOTXAYeoX36pR99i3BgMFiJvYo+13jsPWN+NPM+QfWfndmXaQjsvj
 2Mydui7QOz+m2VTciyqZcyh/w9S3aoYOAmtX65OGLUPEbSq20R150Yyc78Nil38ZG9+zP9U7Php
 4igyQh6gKec9J9vLsRzoBBxOzkwOmGr/R4hbgSR/+fGbSZX9BahYIk2GFSwPlk6z6JaBoVWtd/l
 MQeyiFfEDU/+UPdgsLFVo4gYn83QtcMZROr/spHhXZjabhMRKHT0MJ3OHRPkjnw2Ql3QdBkaBQm
 PRpksBdSY6kbMgXc6hfgtby9d+DDl4pL2v9GrWEVSNZrdIBkqcW1YCf+BAbxKNhMTm3BvadoV5/
 r7GA/l6o5H3fZSA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20907-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3905E413A87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of just failing the test when GET_DIR_DELEGATION isn't supported
or the server doesn't hand out a directory delegation, have it pass with
a warning instead. This should make it safe to keep the directory
delegation tests in the "all" group.

Also, when receiving a directory delegation, vet that it got the
requested notifications. Just pass_warn() if it didn't.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index e062cbe27bff..e5de20c52ba4 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -65,14 +65,29 @@ def _getDirDeleg(t, env, notify_mask, cb):
     check(res)
     fh = res.resarray[-1].object
 
-    ops = [ op.putfh(fh), op.get_dir_delegation(False,
-                                                nfs4lib.list2bitmap(notify_mask),
+    mask_bm = nfs4lib.list2bitmap(notify_mask)
+    ops = [ op.putfh(fh), op.get_dir_delegation(False, nfs4lib.list2bitmap(notify_mask),
                                                 zerotime, zerotime,
                                                 nfs4lib.list2bitmap([]),
                                                 nfs4lib.list2bitmap([]))]
     res = sess1.compound(ops)
-    check(res)
+    check(res, [NFS4_OK, NFS4ERR_NOTSUPP])
+    if (res.status == NFS4ERR_NOTSUPP):
+        t.pass_warn("Server doesn't support GET_DIR_DELEGATION")
+
+    nf = res.resarray[-1].gddr_res_non_fatal4
+    if nf.gddrnf_status == GDD4_UNAVAIL:
+        t.pass_warn("Server reported that delegation on new dir was unavailable.")
+    elif nf.gddrnf_status != GDD4_OK:
+        t.fail("Server returned unknown non-fatal status code.")
+
     deleg = res.resarray[-1].gddrnf_resok4.gddr_stateid
+    if NOTIFY4_GFLAG_EXTEND in notify_mask and \
+       nf.gddrnf_resok4.gddr_notification != mask_bm:
+        ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+        res = sess1.compound(ops)
+        t.pass_warn("Server didn't offer the necessary directory notifications for this test")
+
     return (sess1, fh, deleg)
 
 def testDirDelegSimple(t, env):

-- 
2.53.0


