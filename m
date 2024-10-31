Return-Path: <linux-nfs+bounces-7603-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE19B7BE1
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 14:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D181C1C21270
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFE519E7F9;
	Thu, 31 Oct 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBQMzw2G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B419DF8D
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382019; cv=none; b=iOWoADFidUSnQewmqouQsyHobG65roVyH+hno1LABDrz/DAiSyGclsDdqC5/4kqrRx5okJ1rlzjNtHycitgIxIxmpNN8CCzkbq/7pCvfFFwxg+Kzhd7TVgVrpBcf35SX/sNKVn+5K5Yp1NBvaOsxG+DxjS9TNqlwhyZVPccPGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382019; c=relaxed/simple;
	bh=KJSp9j5RDGGFFwepvlEOC9jeakqGm2ZY03FUCKtrNAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRPY+4SW1pcB+X9CibHYrXNAvcMn2Ap3+fiXA6HfPlbzD1ye0R0dhd93ncqZvh40OXz8r4Yge1+o+i2ZUVodT807ETp1K1zBST4c/z07q/R5Pf18UIUbWJmkdc/asqLIotJHpdRWdz+Ksg+UK0tr7tF2fB1wgI1Z7/1vF6FNd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBQMzw2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0BFC4DDF8;
	Thu, 31 Oct 2024 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730382018;
	bh=KJSp9j5RDGGFFwepvlEOC9jeakqGm2ZY03FUCKtrNAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBQMzw2GfYrXl/B6JIttycrDYG1lSIaH7slTvfNjQzJ6GWv3m0aVS5kAqW5tkMsbl
	 fSPBbIP+dSvs7VfV2NGy4CJzP8HcB+vR8taYmsfo7ixBdFzZCvOhSTF25yZVAQr/vW
	 4+u78UDsM0irGMFfm7UMgBmTnrRc35aFTDiYduWylcXOgTrzK2Ducqi+B6ceZAlkoI
	 hpXkV2BAfBxgBCVXG6+3tAjvw4JJj+Idq7HAvWspGCtcFM3iJDiDVxBzFRr0UL1bDU
	 X/KTztibJ6ndZLF3+W2b9HPIoeBo8MMe1WmePuntlvZ1l14CxM/Jkn0CCjd1bLfWnp
	 tVTn4TLeqc3Eg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 8/8] NFSD: Send CB_OFFLOAD on graceful shutdown
Date: Thu, 31 Oct 2024 09:40:09 -0400
Message-ID: <20241031134000.53396-18-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031134000.53396-10-cel@kernel.org>
References: <20241031134000.53396-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=chuck.lever@oracle.com; h=from:subject; bh=gn+FRGvohSeE1eEJq1Lyjc/CidvyELBnjc094squNxU=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnI4i3mhqG0tF8ayYlErf/zbf/LfWd9e456qwmS viAIgFylVyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyOItwAKCRAzarMzb2Z/ l7lFEACxvE1kIqbRACGmZ/nuDLUR9zabhnd+is5NW/ciTvoHsxy95ATpKzpHbBkgQglvpR0WNFK NZK4tFJdNVitaVvLHju37S2Yyiu2eMp1CerDGthAzpPSx4YOQZ1yf1lKFtzGqQ96cxAd2+4WX0F jJ4GLMNTixApJMtltZk0eJD4SJ6VAeOQwMbAqm8ChXAjGaC14GKbQzOY8iDgYPzPllxwbNikZ8m rc2PPf07mFkeF8LOHIf/mdxbUyY/f5supL8VdMa9gxSPcX3oF1NoqBzkF+57LWujav/kmtabcic HPXqogpO0vKiikxHTjBSM6Bl/rfUA42clpy9XAKsFCSJIJiHoutCNNP/m4ox/k9JYuCwangDGM0 DDkaxODvmtFujmCQCuhnSc34gUDDO8krwbdhti7/QNpntpeFKePsqTAGYlpodVJg5cHvo8Fe6+b FI0/SssDNsRSKXDYtdwfC5xb4w6yF4GJEzJSWxmR/jgjQmnlPQ5i9Nj7T2stHwxQSdoK1a0T4S7 S3BhITOUvEVH39a8SUDL1xLkkJe2nNIN1ql3cJ7TVDAiG4U9x1CjzhONrmXA4y1FQli5nQXkB4c 6RFZaJDIDxPt5wQUFe27Aa4GlntqIwllThn1iZdHAaeCb4Vpsru89FHGssyxBV49wl4oVZ3Fbkq 7sfRKb+fs29Wmiw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

If an async COPY operation happens to be running when the server is
shut down, notify the requesting client that the copy has completed.

Since the nfs4_client is going away, seems like this could introduce
some UAFs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4c964bce6bd7..51b3f85f3791 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -68,6 +68,8 @@ MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
+static void nfsd4_send_cb_offload(struct nfsd4_copy *copy);
+
 static u32 nfsd_attrmask[] = {
 	NFSD_WRITEABLE_ATTRS_WORD0,
 	NFSD_WRITEABLE_ATTRS_WORD1,
@@ -1381,8 +1383,10 @@ void nfsd4_shutdown_copy(struct nfs4_client *clp)
 {
 	struct nfsd4_copy *copy;
 
-	while ((copy = nfsd4_get_copy(clp)) != NULL)
+	while ((copy = nfsd4_get_copy(clp)) != NULL) {
 		nfsd4_stop_copy(copy);
+		nfsd4_send_cb_offload(copy);
+	}
 }
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 
-- 
2.47.0


