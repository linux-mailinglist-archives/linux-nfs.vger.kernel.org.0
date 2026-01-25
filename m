Return-Path: <linux-nfs+bounces-18446-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD0RKp0LdmkNLAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18446-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 13:25:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E14B80865
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 13:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50269300E604
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 12:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32BF31BC8D;
	Sun, 25 Jan 2026 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToMF82kO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DF31B832;
	Sun, 25 Jan 2026 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343867; cv=none; b=lps9TYBQkYNMfYavBkB+ni1b7Y0KpLoXCiuecT8iMZ+5bvSF8sTWISnSdDiDZTwF5RqzLkpXnjyjnUaKZIsA1gQJNg3D9oP4mscI8oWU9ORWqWvsOQhEfYurySY79FuMLSl83msV/uP1yRblsRSJASDCsz5cSYURIgvd+WKCWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343867; c=relaxed/simple;
	bh=eHrRDbXulGw1DGJlTJrcvKl0Qy2dxyb4zrCEW8M0DmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbeFe7MkHRqYYxMsE/t74QjN09e1HBPXNoe0BGz3+wFO5XefpC6ej+ntK/nu+0r4Cb9QWBEVyfG+v9RY1UecrkCiUm881kKNv+Pb/MOof0mGCnG4gcWMjdLGfpczttmtnJM7VYFtivBu5xhNdEqKy65stJQJeTKKmgJEsyI2hcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToMF82kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE411C19425;
	Sun, 25 Jan 2026 12:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769343867;
	bh=eHrRDbXulGw1DGJlTJrcvKl0Qy2dxyb4zrCEW8M0DmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ToMF82kOvk1sZStpe9aCdcR8Nkpm28u+vSzDNAsDV9KsXbDEuoFBg3z78QkZ+/19t
	 sZ4RVxyTMOCI6EER08dyIEzboDbDLa+Hr2s3TCMZe3kAuugu+sFDEZjVnUl6KIbv9O
	 oxcv1VjLaDMOMJH3oYEewo4DpFvlwMXH89boD0A0jBHWNL6Jpun+z1Y+i1OURmtJRC
	 lMLUzELqBSLfoJCw2u14HuHmHibrd4uAh60RrK0JWlgiZAiDrSboe40W1+lQouFi78
	 2cCv5EFwEt6A8xM1S5v088vtleLOtEs69WQ1GBI/iJYaAFzcxF5TsrxzhQEAYVRbLr
	 JxqAir+Tfj55w==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 25 Jan 2026 07:24:14 -0500
Subject: [PATCH v2 2/2] nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-delegts-v2-2-cd004157fb46@kernel.org>
References: <20260125-delegts-v2-0-cd004157fb46@kernel.org>
In-Reply-To: <20260125-delegts-v2-0-cd004157fb46@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eHrRDbXulGw1DGJlTJrcvKl0Qy2dxyb4zrCEW8M0DmA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpdgt4xEo0cUYCY4Z/PuP3RYOERt27AbunodEH6
 KPM/AYvQKuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXYLeAAKCRAADmhBGVaC
 FZDmD/99bnA7ZskNg1lbih/bkb2TvwH6/1QhqfFJniezt89DiH0MvLbaXOkJUBdQLirDaL89GIQ
 JUje+rhfvsA46eTizyTPOmP1c7C5QhS3SMShbpbuZlwQjX70RRAUNughO9fPRqfgpwERfWlaK+R
 Of+g1t5H2C8fYEcwrdB4uJUE9fJhqe1VaX7OyW2/us2tkJjRot9pw54YgZh9Q5IGH57YhWJFPO3
 mUbxgoMcLJ8AjyOzjbzxskAYjgafeP+Zi9eagC11NpMcAXZP6KNBPAYXKNc9onYN2mK5SsyLpwE
 ibi/ddOe3SsLjLUiKCGKacCGFWfzz4Nw+rqyGG6tz2HpUf8xvxOkaLJ53MAlxxVXrQRrX8hVA3A
 JrajlZzx7v9vI4P0us2SOFXB1hiGsYhgvSVikY0sh5yxeJBCJHZooU30+g7f7FJ0qh52376wPoO
 Z6SbQry/LrShFHUlvuNDR2TjzaXX/TA7AKoDds3cuxhBk2RFJM/LCzXEVzzQuLkCrsIykamCosV
 6PzCKYzmHkMV5lJSIldX8I/H//nhU75yBgotBb0QX3gO82+aSDQwKDKEPB3/9QswfA9cfwjtWq9
 JRqELH7Lu/YQIiwOC1adZYkm1cy0vgL8hepPt9x9JH17zCzrGKUuDACPzQ/CMmTrVeLe9dmHU5f
 GEao/Y4h4K4AknA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18446-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E14B80865
X-Rspamd-Action: no action

Now that there is a runtime debugfs switch, eliminate the compile-time
switch and always build in support for delegated timestamps.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/Kconfig     | 10 ----------
 fs/nfsd/nfs4state.c |  7 -------
 2 files changed, 17 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 4fd6e818565ea24e4e16844a3f82e808dbc558f8..fc0e87eaa25714d621aa893c99dabe4ce34228df 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -177,16 +177,6 @@ config NFSD_LEGACY_CLIENT_TRACKING
 	  and will be removed in the future. Say Y here if you need support
 	  for them in the interim.
 
-config NFSD_V4_DELEG_TIMESTAMPS
-	bool "Support delegated timestamps"
-	depends on NFSD_V4
-	default n
-	help
-	  NFSD implements delegated timestamps according to
-	  draft-ietf-nfsv4-delstid-08 "Extending the Opening of Files". This
-	  is currently an experimental feature and is therefore left disabled
-	  by default.
-
 config NFSD_V4_POSIX_ACLS
 	bool "Support NFSv4 POSIX draft ACLs"
 	depends on NFSD_V4
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 95f2e87141a7ab5dd3da6741859bdcae28a8c6c0..e2f29ba490c6335e2cb6c3a411770b3a19755095 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6047,19 +6047,12 @@ nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *nf)
 	return 0;
 }
 
-#ifdef CONFIG_NFSD_V4_DELEG_TIMESTAMPS
 static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
 {
 	if (!nfsd_delegts_enabled)
 		return false;
 	return open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
 }
-#else /* CONFIG_NFSD_V4_DELEG_TIMESTAMPS */
-static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
-{
-	return false;
-}
-#endif /* CONFIG NFSD_V4_DELEG_TIMESTAMPS */
 
 static struct nfs4_delegation *
 nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,

-- 
2.52.0


