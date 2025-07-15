Return-Path: <linux-nfs+bounces-13091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA2B0696A
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 00:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC11565B67
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 22:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82B2D0275;
	Tue, 15 Jul 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InRkGjMj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA029B8E4
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619973; cv=none; b=DikKFbjFZuqyzOIgIjO2rgqBCTPysvbdcjvk0e3wYt9djE0y89BUtiXasCzgkgVUpQm0oPklH85fFZM7ohY+S/3dbrvPMtwisYY4uuGJrOTML3dbzPVJmkTpBmWngLlfA8l6VTUjBRyBPPdVFQNqcrsKKgmoU9v9EJRVpXO3tns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619973; c=relaxed/simple;
	bh=50AQrTGUx2S/HTs8jem59YF/YjlU+vfVM0BcD+gYVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4tmeL4XYXQjJAcfceKLcLLdFNwlo4PGiODKPZkoENw+ydLZII6RXK6T1LWhp2KTP1PPzu5vrLbbZeaU+6WGPDvu2ZF1NXtIDD9xCv36tcQEctM/gYnO3EbHzVDuP5xiRfP08MnJSIjvsr23yg43sf0PcefM4/TyNGyFegYhEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InRkGjMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E694BC4CEF5;
	Tue, 15 Jul 2025 22:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752619973;
	bh=50AQrTGUx2S/HTs8jem59YF/YjlU+vfVM0BcD+gYVFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=InRkGjMj2f+dSOad1KM4LC6sJbEuY3SmftOH/Vw5stKEOhUFfLCf6bDQfrG+LqOJj
	 MB/dTKZ51anCyP6s+c0Jh0/N5IP5zLGWxHB9sp5gRg2PO6rwfGDS1u/taq9/+soxub
	 a1ydS4GBwBq1cycCyAHYQEGDNePouWnxMCvrICx4RpDLezWr9eI2vqp/No+IENS5rz
	 1Urrt3ef63nDHuwDCnF8YkcBbfxfIsF1KvxbcZ5DwAo1HL5uqDQcTVZmPOTvO33Y+a
	 xkTXAUasTknecRx6MykVG5eJITbok5FhPeFZvmmU+Bnb5p21OHnKJyGl91N6+qdj//
	 dGMK8MxFwFixQ==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>,
	Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS/localio: nfs_close_local_fh() fix check for file closed
Date: Tue, 15 Jul 2025 15:52:48 -0700
Message-ID: <22ed73dbab3897d63f88849ea92db672a267945e.1752618161.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752618161.git.trond.myklebust@hammerspace.com>
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the struct nfs_file_localio is closed, its list entry will be empty,
but the nfs_uuid->files list might still contain other entries.

Acked-by: Mike Snitzer <snitzer@kernel.org>
Tested-by: Mike Snitzer <snitzer@kernel.org>
Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs_common/nfslocalio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 05c7c16e37ab..64949c46c174 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -314,7 +314,7 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 		rcu_read_unlock();
 		return;
 	}
-	if (list_empty(&nfs_uuid->files)) {
+	if (list_empty(&nfl->list)) {
 		/* nfs_uuid_put() has started closing files, wait for it
 		 * to finished
 		 */
-- 
2.50.1


