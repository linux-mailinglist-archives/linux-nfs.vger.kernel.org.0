Return-Path: <linux-nfs+bounces-6930-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6201995092
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBAA1F254C3
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35771DF735;
	Tue,  8 Oct 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsPjSDZm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060013959D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395259; cv=none; b=aCK6Ph1F/S2D8gwtcOGNKTeh0P4Lq3VeICSxLiOGywiuOer0bOtZsKDudv/ogCCE0gSVM5wfchw7EFsnrZtlGvNV4Tgccrmg9k022xwzrXFx3F+/zETtDAz5h5isymG8LcCdzoXZQHuEPTtw9H+5VKsnST6Km8ecVYIDk6+sttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395259; c=relaxed/simple;
	bh=0NgbepDpKWWEDAeg8qZaZLrThOVr10jhViRRGfnEelQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fw/LFDoRp3lSYdvFwPsI3cH7JVwM4SkvWBcKekzat3OkenW2w7VpHBIC0ex0kmTiofnmkRQTNQRm2zE1UFkHyIwmjaA/sxYvhk1yHPqaxrzF6Eh3kUT+AI1iKw72RZRN8gLtd/00RLHYaH8Wrwx4Dvvr4dDXUc4ILd8W8XkBRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsPjSDZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A694C4CECC;
	Tue,  8 Oct 2024 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395259;
	bh=0NgbepDpKWWEDAeg8qZaZLrThOVr10jhViRRGfnEelQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsPjSDZmIvdJEztraGV7p9jrxPl2p/2414PpVC3JAWg7O76OHq+E6n0koc4AH4xIC
	 KprlYhHhm2VGuIMnlNqBjM3KZey41B8+iMBBEV92yPV6NaSPxCUAFfCAjJ7L3ItGDy
	 Z/Nnz7Xp0VbGd2SuXuMxfvErKoCVQYEDz1juRTmWD2q5Hhm2WxjMTRp97nuKxlEKVG
	 mfhPgwu6+w8M9BPmFHaMQ8pL2FTDXrCsCzx8UsBDpoXKu7PC2gn+kLIeubn/WTaNyS
	 H6lwTAh/asnEiBgVAVWX3fXaHCObMxvQ+PVql2bklZnKOrbeudNhlZ1aqO9pxZeUe0
	 OOD7sKld0yW4Q==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/9] NFSD: Free async copy information in nfsd4_cb_offload_release()
Date: Tue,  8 Oct 2024 09:47:21 -0400
Message-ID: <20241008134719.116825-13-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008134719.116825-11-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3644; i=chuck.lever@oracle.com; h=from:subject; bh=8QSyr89hxnWWPpw8HGdXacTZ9ztmzRPb0IspVXS3k14=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBTfyT8CVCsA8gwMZRtK95M0Vy/8TRiPfuOeVT n13YXzJ65KJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwU38gAKCRAzarMzb2Z/ l726D/oC49bItz/v56m3ZO7QxDBQN1sEGuph1Fb65HqBZMqvxIrLGGEEv7SZejX23OrdZk8uOUg 8x5HHIaFunLURdmGXfvWvuMp9i2tX2XbZfVaBDagl+0S9kR1LnncP7G+/PTgjfR0SXePcz3DvZ7 ywMfjVOVyRgPj42RuPXlDPjQ+6Cx+9g4wkKiwzE7tgDlakNP4ApYD/E+0YPVaodEtVJY5WbWjF1 09dUBXDbAOYOl2K7Sd73easWAdLiiMGcHL9PKY+GNUs+FGr7BLIKifIhsbI2LsNn+RNr2accCE+ WT0WaS9rKKp/rhCdiGF1BP7tA57q7i6EwaGYt+S3B844cxfFpcxY6MVf415WUN1Ib/o0UGULbAL WDAR/DBSJthmCJsffjx8M5pj32SvoFGROMR7f9QpY2notMz/SOANeeRlVDEv8wwC/ncHYcYLzJP wkBcPdo9EX1kwQJaoe0faDZk/jY67bSpyP99Cx5ZRKc1F0P0dId0bHdPrN0FZOH/z88bPy6vdwQ +UQKnf43s3ftwn9mUp5K+fIHNPhHLI0kzEkn/ducDnRfH4JPEXHYiz25HqZpjn+P0fku0ouDg+D +TNmMH7EugSWwwFqonXbpkPXBhhtKrwCu0YLbqLo9Csf6IGXx7ALxXpVj3B9Vlbvj2vZPBRcn5F 5/VJwIWdd1ic3Wg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 Section 4.8 states:

> A copy offload stateid will be valid until either (A) the client
> or server restarts or (B) the client returns the resource by
> issuing an OFFLOAD_CANCEL operation or the client replies to a
> CB_OFFLOAD operation.

Currently, NFSD purges the metadata for an async COPY operation as
soon as the CB_OFFLOAD callback has been sent. It does not wait for
even the client's CB_OFFLOAD response, as the paragraph above
suggests that it should.

This makes the OFFLOAD_STATUS operation ineffective in the window
between the completion of the COPY and the server's receipt of the
CB_OFFLOAD response. This is important if, for example, the client
responds with NFS4ERR_DELAY, or the transport is lost before the
server receives the response. A client might use OFFLOAD_STATUS to
query the server about the missing CB_OFFLOAD, but NFSD will respond
to OFFLOAD_STATUS as if it had never heard of the presented copy
stateid.

This patch starts to address this issue by extending the lifetime of
struct nfsd4_copy at least until the server has seen the CB_OFFLOAD
response, or its CB_OFFLOAD operation has timed out.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 18 +++++++++++-------
 fs/nfsd/xdr4.h     |  3 +++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b5a6bf4f459f..a3c564a9596c 100644
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
@@ -1598,8 +1600,10 @@ static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
 {
 	struct nfsd4_cb_offload *cbo =
 		container_of(cb, struct nfsd4_cb_offload, co_cb);
+	struct nfsd4_copy *copy =
+		container_of(cbo, struct nfsd4_copy, cp_cb_offload);
 
-	kfree(cbo);
+	cleanup_async_copy(copy);
 }
 
 static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
@@ -1730,13 +1734,10 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 	nfs4_put_copy(copy);
 }
 
+/* Kick off a CB_OFFLOAD callback, but don't wait for the response */
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
@@ -1786,10 +1787,13 @@ static int nfsd4_do_async_copy(void *data)
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
2.46.2


