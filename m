Return-Path: <linux-nfs+bounces-7599-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F89B7BDC
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 14:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EAE1C21150
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E91A19F111;
	Thu, 31 Oct 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omDvX5Au"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9B19F108
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382015; cv=none; b=MEJSFdhM1Tpl7PROms52Rv5eYZwi3/k3PFOhbRvyWtUeAgJgdb931qNivjyAB77KANEck+AEQoSrjHjH7vYJXhI61CRQNxgleh50kRdu4DNMEResR1mcKklsODq/UymMfvecVqOWcyFf/JuaiUsSdHTSFPegOi6hBzRYTHOppKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382015; c=relaxed/simple;
	bh=J+NsoUvZCq9snDkoyG4wmvIivL3WvLvUOk4S3rCsU9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H260jZo6aePiP/ablWO7nhidsKhpuCum5UXg/5Z3p6KyYmc8MJaVB27V6bVLFt0MXA7iEJHtvIDSiWl0cfnNXchWvJTtiP+eYwJvI91+HAMKbTcAhzzTax9arvLiu490ve2ZEBJ0E1FfFMFoeIA1Q3RfsPB2C8f5SzoI99wJlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omDvX5Au; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191C8C4DDE6;
	Thu, 31 Oct 2024 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730382013;
	bh=J+NsoUvZCq9snDkoyG4wmvIivL3WvLvUOk4S3rCsU9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omDvX5AujhsnVXioc9yrr3QJmKkQW/+W+nrEa84uQpCRRkn6oqA7m4GpdMMox8T0M
	 j3Cpc01PMp1HNf728jHNiGDpkYjSQ3EKQUdDE59xnHpGhTPqwKdr6w/hfjq2UsEAff
	 +t4GzRHDKMcoP6LyJ16tkOIDUAcXSAtNZoMPsIhxrvbyWXSsclBzjtG7dUfpspSYS1
	 ILwQMPg7ZIh6vAdj35NY11OCDXaY636Y9HTeo1KOSgpjwPYp05cwiL5ETI1iQb0cqW
	 42xMBDbz8yKwr6N4YRar0/uCisXEp/QNUj0n/k7p+MEHCU7bXBl2+uF0pXhlKQiawN
	 i0n6g8Dl+3vEQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 3/8] NFSD: Free async copy information in nfsd4_cb_offload_release()
Date: Thu, 31 Oct 2024 09:40:04 -0400
Message-ID: <20241031134000.53396-13-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031134000.53396-10-cel@kernel.org>
References: <20241031134000.53396-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3584; i=chuck.lever@oracle.com; h=from:subject; bh=DLreE/k52prrqwxP+NA2902w5TLm3ZQvn0lPUwNXj7M=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnI4i2pHuPB1+pXbgYvOWWBLmwkSbL8YLD++r7a EEpnnHXoN2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyOItgAKCRAzarMzb2Z/ lwFoD/9jvZw+pk28DMqPRfaYcNC7OY45dsFMX8SxsaporJ/gargc2eA4CleBYnpO294MmQD0a/l qKgPN7yB1++UR0t0gGl/UTUo31q4OUv3/U4vKdX3IpPjlxnLJh3SFBbvzQU+j/kFquB2HD1/bmY +00heU3Bz3ly+pLAeZCrvj3SWK7cdUL8RMBy5PEanu6UuKqhuKLg6td/RFgenQGJMbeA+bWHMgh 1jaNHk30qDntTVHSLhrklc/oshVxKB/l807zZkckudvonts2Ps7B+CdxgTourtOQIn2duP1g2Pm zWzuCw4hzre1zMcP8nLNRKR7tVEXzydAL3/yrpXYXE9RiBmKn2+fLWt2pvZ/ix1CVcA6QFPh+WZ lawA38PDIMafU1jIs/W5ymKDUrgW738zmU7gzKRac3dzbye9jfPOvJ+Fa22BLWYQ2xvf31/UjmR 2e3dOF/OO03/9cQwj16X2No38fnT4UCuG74yT7le9FJCdub1N2/RQ09MSQUaVDuSGJZTTf5YgV8 4XJJAOAtLl5HzKnHk8VUDUHqOR4UAccrLk8FDY1A5x8ZAMAWOGFfiXIn7Av9elRAO4xpUKVzuPD SDOl9vmyBW8dUIEKt15lmQiXnoBqzSAqrn+lKNgmIaO6/rVL2a54JZ0z1EnqBrUKifw/hL2VtHQ VnvNZlJfaP7G1qw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 Section 4.8 states:

> A copy offload stateid will be valid until either (A) the client
> or server restarts or (B) the client returns the resource by
> issuing an OFFLOAD_CANCEL operation or the client replies to a
> CB_OFFLOAD operation.

Currently, NFSD purges the metadata for an async COPY operation as
soon as the CB_OFFLOAD callback has been sent. It does not wait even
for the client's CB_OFFLOAD response, as the paragraph above
suggests that it should.

This makes the OFFLOAD_STATUS operation ineffective during the
window between the completion of an asynchronous COPY and the
server's receipt of the corresponding CB_OFFLOAD response. This is
important if, for example, the client responds with NFS4ERR_DELAY,
or the transport is lost before the server receives the response. A
client might use OFFLOAD_STATUS to query the server about the still
pending asynchronous COPY, but NFSD will respond to OFFLOAD_STATUS
as if it had never heard of the presented copy stateid.

This patch starts to address this issue by extending the lifetime of
struct nfsd4_copy at least until the server has seen the client's
CB_OFFLOAD response, or the CB_OFFLOAD has timed out.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 17 ++++++++++-------
 fs/nfsd/xdr4.h     |  3 +++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8229bbfdd735..39e90391bce2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -57,6 +57,8 @@ module_param(inter_copy_offload_enable, bool, 0644);
 MODULE_PARM_DESC(inter_copy_offload_enable,
 		 "Enable inter server to server copy offload. Default: false");
 
+static void cleanup_async_copy(struct nfsd4_copy *copy);
+
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 static int nfsd4_ssc_umount_timeout = 900000;		/* default to 15 mins */
 module_param(nfsd4_ssc_umount_timeout, int, 0644);
@@ -1602,8 +1604,10 @@ static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
 {
 	struct nfsd4_cb_offload *cbo =
 		container_of(cb, struct nfsd4_cb_offload, co_cb);
+	struct nfsd4_copy *copy =
+		container_of(cbo, struct nfsd4_copy, cp_cb_offload);
 
-	kfree(cbo);
+	cleanup_async_copy(copy);
 }
 
 static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
@@ -1736,11 +1740,7 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 
 static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 {
-	struct nfsd4_cb_offload *cbo;
-
-	cbo = kzalloc(sizeof(*cbo), GFP_KERNEL);
-	if (!cbo)
-		return;
+	struct nfsd4_cb_offload *cbo = &copy->cp_cb_offload;
 
 	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
 	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
@@ -1790,10 +1790,13 @@ static int nfsd4_do_async_copy(void *data)
 	}
 
 do_callback:
+	/* The kthread exits forthwith. Ensure that a subsequent
+	 * OFFLOAD_CANCEL won't try to kill it again. */
+	set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags);
+
 	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
 	trace_nfsd_copy_async_done(copy);
 	nfsd4_send_cb_offload(copy);
-	cleanup_async_copy(copy);
 	return 0;
 }
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 2a21a7662e03..dec29afa43f3 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -699,6 +699,9 @@ struct nfsd4_copy {
 	struct nfsd42_write_res	cp_res;
 	struct knfsd_fh		fh;
 
+	/* offload callback */
+	struct nfsd4_cb_offload	cp_cb_offload;
+
 	struct nfs4_client      *cp_clp;
 
 	struct nfsd_file        *nf_src;
-- 
2.47.0


