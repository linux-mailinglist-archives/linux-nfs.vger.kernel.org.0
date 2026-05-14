Return-Path: <linux-nfs+bounces-21625-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGeoFf02BmqWgQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21625-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:56:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FBC546DAD
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD4913045093
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54703BF66E;
	Thu, 14 May 2026 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcM0TmFh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F973F4121
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792177; cv=none; b=UKKfHQ620nm1s03+LMndd9lCa51MUhDam7enHDC7s3Ao2+1HX2omiKrv7X4+YKuYs13024DgZOjzRFTkOkGXlnAe+JGoH7fx5cp/5cvHJ2FgMubO3+fVEGcah7ymCIOrsNJ3YN9LEQmEi5PMdE0AwIT0JGY03a5JVoUYhXp37Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792177; c=relaxed/simple;
	bh=+KyMLV1xIdvLdHrV2gCcoTVm2xCMKClbG2/7ekqHGQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvZ92X+X5CTTh3iqVNPSAD+e6dtbEUi3q1solVooazxYwvksN1VECl7p5bg4vbvQnDZQJY7qpmSyR5vG5xhwjivD3O2FS5u6G6zY99l7a5GB4me/CA4ov+ZEZ1QBCRCio0H+V/vGaWABzK/lcWHcEXfsxluM5vAEmLyv4SC4i0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcM0TmFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943CAC2BCC7;
	Thu, 14 May 2026 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792177;
	bh=+KyMLV1xIdvLdHrV2gCcoTVm2xCMKClbG2/7ekqHGQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcM0TmFhOU8i6ewRgcUcV6992eAfiJQBra5epQ4cvdT6WSoJGOjVsDRKJv+rPjtV8
	 GqQoNJyQ1wm9DxmAnlekAmPd7+gUEzmu1gsTD5nXpI3wV1ywMBXBPuYKOrFh5InDEz
	 xM4ZVHKfMQIqaxA5HDTPdqjYFPdyF+V5L4odE8zsY54bLI9fb9hnVethsqdMarRsrS
	 6DateNq997LbimcgmXGm6Sph9kEwxEYbgr0ir1dI/2A9eY719JKJa4dwNhc5hAKzMg
	 H+b4BjAJRJo0vwQrlcwPaVmAX0cDvwIJdb7LqJef240X/+hpDmTWSfgzIfdjYxTpa1
	 ToLNxiicSBIRw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 3/3] lockd: Avoid hashing uninitialized bytes in nlm4svc_lookup_file()
Date: Thu, 14 May 2026 16:56:07 -0400
Message-ID: <20260514205607.348291-5-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514205607.348291-1-cel@kernel.org>
References: <20260514205607.348291-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8FBC546DAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21625-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

file_hash() digests the first LOCKD_FH_HASH_SIZE bytes of
nfs_fh.data when bucketing nlm_files[], independent of fh.size.
Commit 3de744ee4e45 ("lockd: Use xdrgen XDR functions for the
NLMv4 TEST procedure") set .pc_argzero to zero for the converted
procedures and moved file-handle population into
nlm4svc_lookup_file(), which copies only xdr_lock->fh.len bytes
into lock->fh.data.

When an NLMv4 client presents a file handle shorter than
LOCKD_FH_HASH_SIZE, bytes fh.len..31 retain whatever the argument
buffer held from an earlier request.  The same wire handle then
hashes to different buckets across calls; nlm_lookup_file() misses
the existing nlm_file entry, and lock-state lookups fail.

Zero only the tail bytes that file_hash() would otherwise consume.
Handles of LOCKD_FH_HASH_SIZE or larger already populate every byte
that file_hash() reads.

Reported-by: Jeff Layton <jlayton@kernel.org>
Closes: https://lore.kernel.org/r/5229a9746d723a3f830120c0b966510f75badfc2.camel@kernel.org
Fixes: 3de744ee4e45 ("lockd: Use xdrgen XDR functions for the NLMv4 TEST procedure")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h    | 8 ++++++++
 fs/lockd/svc4proc.c | 3 +++
 fs/lockd/svcsubs.c  | 3 +--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 0be0dac59ea2..e418a50c4180 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -52,6 +52,14 @@
  */
 #define LOCKD_DFLT_TIMEO	10
 
+/*
+ * Number of leading bytes of nfs_fh.data that file_hash()
+ * digests when bucketing nlm_files[]. Sized for historical
+ * NFSv2 handles; nfs_fh.data must be initialized at least
+ * this far before lookup, regardless of fh.size.
+ */
+#define LOCKD_FH_HASH_SIZE	32
+
 /* error codes new to NLMv4 */
 #define	nlm4_deadlock		cpu_to_be32(NLM_DEADLCK)
 #define	nlm4_rofs		cpu_to_be32(NLM_ROFS)
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 997f4f437997..78e675470c4b 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -156,6 +156,9 @@ nlm4svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
 		return nlm_lck_denied_nolocks;
 	lock->fh.size = xdr_lock->fh.len;
 	memcpy(lock->fh.data, xdr_lock->fh.data, xdr_lock->fh.len);
+	if (xdr_lock->fh.len < LOCKD_FH_HASH_SIZE)
+		memset(lock->fh.data + xdr_lock->fh.len, 0,
+		       LOCKD_FH_HASH_SIZE - xdr_lock->fh.len);
 
 	lock->oh.len = xdr_lock->oh.len;
 	lock->oh.data = xdr_lock->oh.data;
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 58b87ec52930..a0d1a6fbf61e 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -17,7 +17,6 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/module.h>
 #include <linux/mount.h>
-#include <uapi/linux/nfs2.h>
 
 #include "lockd.h"
 #include "share.h"
@@ -67,7 +66,7 @@ static inline unsigned int file_hash(struct nfs_fh *f)
 {
 	unsigned int tmp=0;
 	int i;
-	for (i=0; i<NFS2_FHSIZE;i++)
+	for (i = 0; i < LOCKD_FH_HASH_SIZE; i++)
 		tmp += f->data[i];
 	return tmp & (FILE_NRHASH - 1);
 }
-- 
2.54.0


