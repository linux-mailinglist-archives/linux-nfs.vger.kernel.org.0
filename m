Return-Path: <linux-nfs+bounces-20213-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCbkEvoguGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20213-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE6929C460
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2460F300B9FA
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3313A1E69;
	Mon, 16 Mar 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCmxJEHC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9B3A6B8B
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674228; cv=none; b=Co1a3KpWP1Y/wvOxziIMa8+EKUu7JlQiA0f8kzi1yettxDvvTdnXVs0+IgbVUivIfSvaCipz0V+xHMrAxtH5cm6iateZ28Oag4Xcfjy5CBhV9TXEqeCfSr+90xr8Iwz9j5Ff13SjOmQSwVleovNwrn89ii0T5COxGXNijLhFn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674228; c=relaxed/simple;
	bh=bKv+cshBkzHMBcAlXjQHspzml9x6X9bwzMVe68meMSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hlG+rM0DgvVYjgvuKYB4W39aCojwecAMv3xLn8E+MhCJG75hb4hRE9ctZ4BBTUyDO+tx9gHkw3FFwn1pKfIeUpYjp4g657NJJCmfRuJqsDRc491ZGJOxOEql3mhIhYWsOSwLY/lzCrvoNDp52+4z9LrSwU+5cSbnCfss36s9l5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCmxJEHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99E8C2BCB2;
	Mon, 16 Mar 2026 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674228;
	bh=bKv+cshBkzHMBcAlXjQHspzml9x6X9bwzMVe68meMSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cCmxJEHCaBvLJZVF/CZy2ge1V/8kPCuH7jG0eu2YaXIKg5jdOFCdHLwHHdTZtk+6o
	 UDWkSA4AA33FMutUoTNdEUrNOGt2+sjpXPT0hjg3hUW+AbIY/E54LoxXHEYEtCkG6C
	 25qP08Gn/9uihBgyliluRwWMIc1/MUg51ypQDlJOYH7QdV9t7CMvXfSMdf2JKZE+kv
	 0fDeATqlabjN9R2hoGtiF2M+SIyufYJTvcvihqBggJVnGsTSR762NjByPTUEMcMYki
	 xXR5spI3CNs2TEIAhd2DLUHAr0CUcvUjT7zAEsPcl3676OQAk7fpF+3hBkaHrJCxgh
	 9rQ9avEEBBriQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:52 -0400
Subject: [PATCH nfs-utils 14/17] nfsd/sunrpc: add cache flush command and
 attribute enums
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-14-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bKv+cshBkzHMBcAlXjQHspzml9x6X9bwzMVe68meMSk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7j95xMXD3ezeYjzXLKaYMttUXKJ461js4EU
 LWpI1knm8OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4wAKCRAADmhBGVaC
 FdQtEAC8V1543bPHjKUJRR29d5bSsFoev4EpqJvxrDn/chibYd4yR29lw24vHmDuMigH7g1qUlq
 d9aKuY8NKP61Ih8ywWOqf7ZaCkNn6w0fJbH+LfIo5xy0yj2J8g8tTCbpzptDkKHlzGu1tOPfRud
 D6124BFwg6gLzquB5nhTG1RE3trxqwSAqSeKcQazvlKRZiyhBHVAF33h1rCsKPzZbpHhPO4I2G1
 BbCsucAl80CS8Zd8pobJjVD12iHgR3dS3c+Hzy1459ZneV/a4HB8ZLDboApnH3olID5G8Dk/duR
 P/tfcfmkGczag2PYqXEhTnOiHgzzUjYVoejsk5/p3bKrWgJFI6Aqxsf6TTt4roYfJzoIa6RVXiv
 sEfikziz9kjdIZrzhBNP+xG8lKf5jPdC4SUnjIFE6kxbs2zXLZa8Y0584riRHzKFhs3XN6xPXtA
 75S4Bq/dOJVzUieYZlrSjj7h6rH+1n7diJLnEctesS0PdJ+pkpWPxPEOmuPfSsKd3xaVBMcEIhY
 9Y4lvrRWX5HaOObbxgF/LzCT8ZatgYkRrK5kaFpTyeKJY2bsklpFLmFh46shZx02frTXR375Td3
 oUDtesFxMwA/r1hnJPvAC0e7YV3QgjK03ClkzBL19WgA28HMAf8N616bgY7796aB2uHOgEcyTWL
 Tllt+GJMIm+Heog==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20213-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CE6929C460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add NFSD_CMD_CACHE_FLUSH and SUNRPC_CMD_CACHE_FLUSH command enums,
along with their corresponding NFSD_A_CACHE_FLUSH_MASK and
SUNRPC_A_CACHE_FLUSH_MASK attribute enums, to the UAPI netlink headers.

These correspond to new kernel netlink commands that allow userspace to
flush nfsd and sunrpc caches via generic netlink instead of writing to
/proc/net/rpc/*/flush. The mask attribute allows selective per-cache
flushing; omitting it flushes all caches in the family.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/include/nfsd_netlink.h   | 8 ++++++++
 support/include/sunrpc_netlink.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/support/include/nfsd_netlink.h b/support/include/nfsd_netlink.h
index e96cc1d23366bce13624084fd476dda65aef140a..08b8a77179f88f596d482d7a2ec5c19ee98b2e77 100644
--- a/support/include/nfsd_netlink.h
+++ b/support/include/nfsd_netlink.h
@@ -198,6 +198,13 @@ enum {
 	NFSD_A_EXPKEY_REQS_MAX = (__NFSD_A_EXPKEY_REQS_MAX - 1)
 };
 
+enum {
+	NFSD_A_CACHE_FLUSH_MASK = 1,
+
+	__NFSD_A_CACHE_FLUSH_MAX,
+	NFSD_A_CACHE_FLUSH_MAX = (__NFSD_A_CACHE_FLUSH_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -213,6 +220,7 @@ enum {
 	NFSD_CMD_SVC_EXPORT_SET_REQS,
 	NFSD_CMD_EXPKEY_GET_REQS,
 	NFSD_CMD_EXPKEY_SET_REQS,
+	NFSD_CMD_CACHE_FLUSH,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
diff --git a/support/include/sunrpc_netlink.h b/support/include/sunrpc_netlink.h
index 52c9aa3f19b6a218ec7d0518b58062beff11c774..8deef0fa11d4382a077ea2e8a4c55856376f1731 100644
--- a/support/include/sunrpc_netlink.h
+++ b/support/include/sunrpc_netlink.h
@@ -60,12 +60,20 @@ enum {
 	SUNRPC_A_UNIX_GID_REQS_MAX = (__SUNRPC_A_UNIX_GID_REQS_MAX - 1)
 };
 
+enum {
+	SUNRPC_A_CACHE_FLUSH_MASK = 1,
+
+	__SUNRPC_A_CACHE_FLUSH_MAX,
+	SUNRPC_A_CACHE_FLUSH_MAX = (__SUNRPC_A_CACHE_FLUSH_MAX - 1)
+};
+
 enum {
 	SUNRPC_CMD_CACHE_NOTIFY = 1,
 	SUNRPC_CMD_IP_MAP_GET_REQS,
 	SUNRPC_CMD_IP_MAP_SET_REQS,
 	SUNRPC_CMD_UNIX_GID_GET_REQS,
 	SUNRPC_CMD_UNIX_GID_SET_REQS,
+	SUNRPC_CMD_CACHE_FLUSH,
 
 	__SUNRPC_CMD_MAX,
 	SUNRPC_CMD_MAX = (__SUNRPC_CMD_MAX - 1)

-- 
2.53.0


