Return-Path: <linux-nfs+bounces-18324-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E5kJpFzcmlpkwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18324-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 19:59:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662F6CD10
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 19:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B6C93006B30
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F2338A704;
	Thu, 22 Jan 2026 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzevswLG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944E2FD69F;
	Thu, 22 Jan 2026 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108365; cv=none; b=tOs1SDlPuc3obu9yKURv9fA6rodHOFxrnteusqLu/HMGD3ng5zemMWfMX+zL+lmigA24O08p1to3BVxFlJYyJjs8MlceHdTjkZMRuv14CTMH6jiuu91ls/qykRd1bhgcXzY/0ClvtmpJDu60VdqipelqidIAR++f9letgOQ2AFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108365; c=relaxed/simple;
	bh=eHrRDbXulGw1DGJlTJrcvKl0Qy2dxyb4zrCEW8M0DmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OshP9Tib8SNfQmkggYjjtTgQA5RbwQwjViVCkOvxvykmZOfCUV3gsVmS4IHDf4ierCWL2XKPJV0G9A3sdUgLfUp0INVKtbp73xrAvewD+gWW2uureKSSnWf2dXkDFmdkLa2/ZzOF6agLWLsWuzs7pj1ZEYGe29ojkSoYCWpY7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzevswLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A63C19425;
	Thu, 22 Jan 2026 18:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108365;
	bh=eHrRDbXulGw1DGJlTJrcvKl0Qy2dxyb4zrCEW8M0DmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gzevswLGp16QUrW8zYDxOzpOewrp1GfGndUNwbn2lzLDPOLfnH95QSurC1OpQNDk6
	 H7EHOg9XjNd82qRv7jj282H62gmxbv9Yo6y7b0CKWZ9qqIvaWR/gJwIIe3n5FjWmSt
	 M84MnQIsio5cW9H5thBxWNq9cVjABIuWRo6bu4x0oyTaXlIF/ZDa1c1Lbuah7IoXE0
	 JOn+3Loc/+4VwDqfEKSSM2BxhtXfiJrArF0Ac9aI6GV7TTESKJwnQR+oMOlqnz0By5
	 /C+KWokRaDvictcUwj4IWRiDfflUF3QFe78wEATOAtrSWcWbPLdtSt3zhb5gl4K5xm
	 gKKJG9deuYlvw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 22 Jan 2026 13:59:16 -0500
Subject: [PATCH 2/2] nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig option
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-delegts-v1-2-40fbb180556c@kernel.org>
References: <20260122-delegts-v1-0-40fbb180556c@kernel.org>
In-Reply-To: <20260122-delegts-v1-0-40fbb180556c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eHrRDbXulGw1DGJlTJrcvKl0Qy2dxyb4zrCEW8M0DmA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpcnOKeiOxDOBYjvPD+GuZotrHoxfaSat07JZgK
 k7qjQ7gJjyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXJzigAKCRAADmhBGVaC
 FRCUEACsjppKuQXiQaWLE3JGf3x7mekwycq/pHKj6b3TvSoYzEq/2jDw+fLc/7E3gs7VtS2WNKX
 RivXpJV3+8+um/izU83gUoqJwNkGNYKLflwryi3bDxNW5i6THCmYU1iw7++5EJ/2QwpA8NVc8o0
 8xKCCQ4s+J33Y4JI5iz7qrfxGVn7nraLBPdyMMT0mE0bv+fKAXpyLS0P6bQJk67CpSECnJcubfL
 V5J2EsLTq+Y8t+UWzKxqQMl3D+oZrer/YDIut193DvdJUP8vG9Bqyp8RQK6NJ4e+0Wy6WGVSTC4
 hHieZgwKXFYduCjQyfLxEfYrIv4N/EfS/JffMRi0OCv08RSdA6Dx2KS16bQdBTOAXF2jCQoXkLZ
 TcwF+xl76izsFquARxUMEk1opGYs279SOPAmE+LEAFMuRISPIhICtbmZlTFBe4vhBn+MNaFF/hg
 R5UTipA+9CUJoBytVXDUwmQBPxD+s0M5bOBdLkKJGMVp11Uw8xCIuzZD/DqrfUU9ykAFjY4dps3
 QYqh517OL2mupiyUhH0+1Y5GEZZG2POGCjPpnGIwTs+hITJtS88W1c8y8s7XfF1ri7w5LVNH+KE
 iV9b415y9IkCqx5JGrXt942pzjlZCHHt6zW4ZhvFstNZPxmCthsZJ4T0qdlBFFixRGJxeurUMft
 2U0vteQUjJKe6Jw==
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
	TAGGED_FROM(0.00)[bounces-18324-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4662F6CD10
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


