Return-Path: <linux-nfs+bounces-18465-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG4cMslZd2maeQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18465-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 13:10:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31758880AD
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E5553042B74
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5533508F;
	Mon, 26 Jan 2026 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0s9R5zF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF9335080;
	Mon, 26 Jan 2026 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429424; cv=none; b=OXvMgtTxyzYOhARTCV1eVgllVNQp0eJglordKtjRIGpBM8Cx4VCpI0Sa9caQ+SqIaKSLWkguU81RFDt0OxwlAyAZK8SXBegZyrES1rFTw/DGzjnoPLPs6KQJA3PIw+09Gj+F7Buz1iw3ipPxEPbMZN8oHorc+xDy0RAsCjvqWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429424; c=relaxed/simple;
	bh=Z2vuFJFnrfkKh0zztMX68YS10QQimek5pSgWpfy6byo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sITsQtn6W6L+Z93ZcuVmjM4348HLCsPIP9xEWJ0dbEOJj9EhcJDGXEsD2KtqbEptXSQENQvsEHFT2DmwzUN8LV+fAZyii79ux9VaO9ql9u10ycd7ylCJCO+PveKLZgLjQJsJL1ei+/NtvVAKAnese2KsdKzjSwigNC21PE+e4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0s9R5zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AFFC2BC86;
	Mon, 26 Jan 2026 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769429424;
	bh=Z2vuFJFnrfkKh0zztMX68YS10QQimek5pSgWpfy6byo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B0s9R5zFW/S5QkGEu98U7nHJw6gEGRFBkgkNIA1UqLuRvVFUehcuKG32W+rVjRetR
	 nx7x4y589y5gQRkDlXHYVwn8cZSF9Zy+YfWmfPF6yw8Hiuj3L85kOfUv7ucetoWEQP
	 qkVX70l5qQlVdgiKFvWlcodKEHoeyXhNsART06uC0SkX9WE3gvPygc7zick7X1admz
	 ZOg1VfDmVr70L0mYU9tMOt/dJ9MUPbOduK94Od9T8YevnQO0Bj1TMqwIg/h++cCubM
	 XUz11SbzpL9LOUVrdM+CucP/m3GtgfDsHJ6Gn+e5LUUT2RTab9+1ZEHEKVMtk/wPdg
	 VFkyS5DA73WzQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Jan 2026 07:10:13 -0500
Subject: [PATCH v3 1/2] nfsd: add a runtime switch for disabling delegated
 timestamps
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-delegts-v3-1-079f29927b83@kernel.org>
References: <20260126-delegts-v3-0-079f29927b83@kernel.org>
In-Reply-To: <20260126-delegts-v3-0-079f29927b83@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2593; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z2vuFJFnrfkKh0zztMX68YS10QQimek5pSgWpfy6byo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpd1mtYJ+bOHCMfUp8eKqMxs1ME2TpiZjErHilX
 J4i3PHJ7c6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXdZrQAKCRAADmhBGVaC
 FRdQEADDBo1a2FOLWph9Apxc174orJTY2+Q+jOowHn/KXIjHcXgd37ZUI1mQmpeQjUFCqBDz0jp
 qR3cPwSumq19dY7w/qBr4JehiJq6B1To1WvC/UMO8CXF1QfnADNiD0hbUuKC4bkBNEGtYjwH0cQ
 h3iCZZKqPHiscVbdUdy5ESl/GN1dLVoy0CtB7yPJ0elqHp4X1QREXrNYnThh742e0xXzchrYKpN
 DqY51m3cZrCA/IU223De1iQMxdDGmhjhNPdREnE7qWqU5Jo6KIQ52ySKH7PE/9F7tCS7hHzf9fn
 gvgizdMscn7+gp1kzKoRXsnqcbkRUTJbqA0tHQE+Yg48c2HM9D93tPBoJxvEsMlIbzlvq55jqJP
 jR/wCPeT/DvDX34JzIZvgsValhHgqGsAMhNZ3r1TTP7m4AJE8RqlnF2a3DHefANlQ6vy6fm28o2
 zSlY9XEZ7yp3T1pD2sb7mrH2TeJMtIOWmqRgJP2bEwEZZ9wHKtcdeg2pnhY4PjVoQj00gLNLRmH
 Qog9Z0eRKtUwSUf2Etb4yzEhr3lSkmLw39Ib1yFtJEtuckD78WyjKYXKcYV0D4jSB6ys2rvN4Gn
 DMi7gS8L9xwvgbG7W+J1CUFFknTHbzpFILH6FHrQnkCeOdFd+8qFc1hdtJ4CARfNnGqlIfg3tme
 xhNNSl4D99U4S8w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18465-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31758880AD
X-Rspamd-Action: no action

The delegated timestamp code seems to be working well enough now that we
want to make it always be built in. In the event that there are problems
though, we still want to be able to disable them for debugging purposes.
Add a switch to debugfs to enable them at runtime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/debugfs.c   | 4 ++++
 fs/nfsd/nfs4state.c | 8 ++++++++
 fs/nfsd/nfsd.h      | 1 +
 3 files changed, 13 insertions(+)

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
index 583c13b5aaf3cd12a87c7aae62fe6a8223368f55..2251ff43aac8ef8a3d01d7094d40f9b2604763d6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -76,6 +76,8 @@ static const stateid_t close_stateid = {
 
 static u64 current_sessionid = 1;
 
+bool nfsd_delegts_enabled __read_mostly = true;
+
 #define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
 #define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
 #define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
@@ -6046,8 +6048,14 @@ nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *nf)
 }
 
 #ifdef CONFIG_NFSD_V4_DELEG_TIMESTAMPS
+/*
+ * Timestamp delegation was introduced in RFC7862. Runtime switch for disabling
+ * this feature is /sys/kernel/debug/nfsd/delegated_timestamps.
+ */
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


