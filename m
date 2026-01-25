Return-Path: <linux-nfs+bounces-18445-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMXlLYgLdmkNLAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18445-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 13:24:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3C38085E
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 13:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 761D93008E16
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D115031AF25;
	Sun, 25 Jan 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEURFtES"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5AC31AABC;
	Sun, 25 Jan 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343866; cv=none; b=C1UqEpBvzzs+Ra7P9t2sXVJ2Aps19v3ym3n5CGikukwF5g/AEG8lkt69FCdN6VEB4z8HS+HRNPqGtJEYRHlKwgCNqGcCEIqxjZBbU+Y++AD8beejijixGnwYAqu2PUmXGjKaDXKiotvRpUoBGHjKDYVvBN2SRaTFYcB2MQJ4GNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343866; c=relaxed/simple;
	bh=gnv726bieIdTlpxb8y9dA7re2w8a8XFyqdfDIFSEzHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7c84d2nASTLPE8TMPA8j+f92OG2Y9pDgeY/KWY68Jmc98Qj0EZtI7pJVNZu54y0WU0pGBum0yBrmZ4xfwUCJRgf/29nmtz8JCanmWzWA6DWncJ1VFaPa/CMQ67boqY6RzMP95VYMUMt9U44YKsK8a0Q+0qDxV00SnEr2POFmIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEURFtES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A88C2BC86;
	Sun, 25 Jan 2026 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769343866;
	bh=gnv726bieIdTlpxb8y9dA7re2w8a8XFyqdfDIFSEzHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vEURFtESdsmxlAeUG3gPVInNSecoCfaYayLHlBtgID2EzMX89tGwdHiDs6FAbrVZD
	 xA0cXxsk7ovvYL4MeYEtqsvEndg2e2DtZzzXy3DnG4B3Xf+IawWmaeFFLuVc+qyOAh
	 d0ANQav+meFU7NLU6Lq+UcE1Bwf6zhMEOduQ3GUhS4gQLG+KlU5vWtNwaA7XYABcP/
	 6fwb3scfeFE8wxPqV4+ee4yodo92idVC0WXwKT1Bgo+Crm/hOlHJlV8IiowRHI207O
	 jqS4bID4uQozT/m94/U6/0AiiSpSLyV2dHsBRUvSYDBGqh+bSXLNQR6GzbSWNDiFt/
	 enhlA423Ti3ng==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 25 Jan 2026 07:24:13 -0500
Subject: [PATCH v2 1/2] nfsd: add a runtime switch for disabling delegated
 timestamps
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-delegts-v2-1-cd004157fb46@kernel.org>
References: <20260125-delegts-v2-0-cd004157fb46@kernel.org>
In-Reply-To: <20260125-delegts-v2-0-cd004157fb46@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2421; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gnv726bieIdTlpxb8y9dA7re2w8a8XFyqdfDIFSEzHI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpdgt4zP52FhTzbbyMvLUHQnH3ZXG0FFd/IB7BR
 of4xMBgPLSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXYLeAAKCRAADmhBGVaC
 Fbs8EACyGS3K6Z0gdhTWiIK4JJGmW9ESMZmgzgjux6uIRqLY4HByur9G0IDRYeISrFDYGYQ2/Le
 XLqDkFwXsn0snYbzD1H8oUJ1XbUKkHUKj/cdk7LzJxEppnaUaWB/EH0zPdMWoE5C+s8ZwIj2Ke6
 C2XyFS9t/xUGNz+rx5ly/2RE/lqXCTJ5MShzZXsdB3lVhmeQlji+vqTTUiLpI5o9LxmkUkuV7lR
 ReeBkSdPRLfBE+kLh6S/fSPKQKW1acRYg1xayJLuZ3MGO4Oum/H/g13ivB1+Y1dLw4xCtZsrGBW
 cflf50/RJm4Yoilxy8SJj4NWpOhBgauaUjmvF080yfp0HG1Ye2nz/o9VkW0d2/lR2zAU6K/Zy7x
 e3UUciK9HZ9BUPzvGKs5ybo/foW4KswIrE1lFxGPtNA1V6mlDJIdjJELPr7S71zDDToKtl4dZgb
 2rP+ho07td45GyxTDnM7KvEv7xNlpVXyQ+N6dItLnAPlsgLTsuRQaDznfcYZDJP/ObWjAwaEV1t
 My+3NvokqNYd0Oh+yT+SL0kH4zkPvQm7Hc2Yju0H3nSqArY6HZGp/++gCQsPPiW8xg+30qr6z7b
 0d8LXU8C1V/X84Tz3lDIjbZ6hcFw+0lc/64EJwsvQl6rlNuMQfvZTHSumAfnmgdqzV3WM3uSAAm
 MP0n2WCD3cX+zuQ==
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
	TAGGED_FROM(0.00)[bounces-18445-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 7A3C38085E
X-Rspamd-Action: no action

The delegated timestamp code seems to be working well enough now that we
want to make it always be built in. In the event that there are problems
though, we still want to be able to disable them for debugging purposes.
Add a switch to debugfs to enable them at runtime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/debugfs.c   | 4 ++++
 fs/nfsd/nfs4state.c | 4 ++++
 fs/nfsd/nfsd.h      | 1 +
 3 files changed, 9 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 7f44689e0a53edbfd6ade9dda6af4052976a65d3..386fd1c54f5277fd9b9544caa5220e234915264d 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -140,4 +140,8 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("io_cache_write", 0644, nfsd_top_dir, NULL,
 			    &nfsd_io_cache_write_fops);
+#ifdef CONFIG_NFSD_V4
+	debugfs_create_bool("delegated_timestamps", 0644, nfsd_top_dir,
+			    &nfsd_delegts_enabled);
+#endif
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 583c13b5aaf3cd12a87c7aae62fe6a8223368f55..95f2e87141a7ab5dd3da6741859bdcae28a8c6c0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -76,6 +76,8 @@ static const stateid_t close_stateid = {
 
 static u64 current_sessionid = 1;
 
+bool nfsd_delegts_enabled __read_mostly = true;
+
 #define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
 #define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
 #define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
@@ -6048,6 +6050,8 @@ nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *nf)
 #ifdef CONFIG_NFSD_V4_DELEG_TIMESTAMPS
 static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
 {
+	if (!nfsd_delegts_enabled)
+		return false;
 	return open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
 }
 #else /* CONFIG_NFSD_V4_DELEG_TIMESTAMPS */
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index a2e35a4fa105380c2d99cb0865003e0f7f4a8e8d..7c009f07c90b50d7074695d4665a2eca85140eda 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -160,6 +160,7 @@ static inline void nfsd_debugfs_exit(void) {}
 #endif
 
 extern bool nfsd_disable_splice_read __read_mostly;
+extern bool nfsd_delegts_enabled __read_mostly;
 
 enum {
 	/* Any new NFSD_IO enum value must be added at the end */

-- 
2.52.0


