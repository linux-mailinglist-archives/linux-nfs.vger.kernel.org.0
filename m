Return-Path: <linux-nfs+bounces-2426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF228818F2
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 22:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C2F284D45
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 21:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AB08595A;
	Wed, 20 Mar 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHuL8Cvl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368304F8B2
	for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969083; cv=none; b=Q4AXMR3DcBTxlKjINZRVJD6kTZMlLyVOiVfSUYPbQOk/rue62HomCdgGA7Yxky4w67RrB48tWg6ztr13jXddf0p3Tst9/jWHu6MjqJXHH9z0zvO2+6Sak3WytDbQdTmtHzjlPt+6QgqdcDuo8nnpc8oA9qSiHf5hzTVVPIDKnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969083; c=relaxed/simple;
	bh=5VXi73pty05gRBDvbtPuotRxMtU15c0kqRV4paZvgNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy6RAMdcvcQA+YjCLG2VpGaI9llr2iZsC8Dw4BZNmE9IqLTtpln4LfXOpcyqpu1y8txdmj7uKE/idOSnbqhnt1llTGm+tVG0RBm3J2sMtQMaiAILuMT1L1rouPN8omc5nVqw47qlfZ/pLDQ6AkuwTHRXfF/SV/FpsiE6pHtXf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHuL8Cvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75EBC433F1;
	Wed, 20 Mar 2024 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710969083;
	bh=5VXi73pty05gRBDvbtPuotRxMtU15c0kqRV4paZvgNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHuL8Cvl+5GAlZ7KbleIxLkhG/5QoNjJMxbLyLB+dQYPb+eZPg6aUEFwsLUBT2SIk
	 q0pLcbdeh+AhHHr7SmrsLQcssUfptXvS6CT4zIQ4q2if6tAAleh/ZO+6Zbi8289uMt
	 p5tif3UIvk2eEEqLtpdSG00C0apL+dMSr0s73ruQb3yBvbM/44J7tVnU/lTn3n8jjB
	 d3CGHujCltKj2MrKDB3YG7jA3ux/NDJCtSmRyNxMcNvIcIHAgHPDy7lVCXECKGdFNG
	 JWnJBZSu+D8ja2X4WS08W7h0kiY76535DxN8+vg/Q+VjOuBk7s3XiVd0gNW0Kic9E3
	 HCc+OLCt/Jbgw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 2/2] pNFS/filelayout: Specify the layout segment range in LAYOUTGET
Date: Wed, 20 Mar 2024 17:11:20 -0400
Message-ID: <20240320211120.228954-3-anna@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320211120.228954-1-anna@kernel.org>
References: <20240320211120.228954-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Move from only requesting full file layout segments to requesting layout
segments that match our I/O size. This means the server is still free to
return a full file layout if it wants, but partial layouts will no
longer cause an error.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/filelayout/filelayout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 3fb18b16a5b4..cc2ed4b5a4fd 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -871,8 +871,8 @@ filelayout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
 						      nfs_req_openctx(req),
-						      0,
-						      NFS4_MAX_UINT64,
+						      req_offset(req),
+						      req->wb_bytes,
 						      IOMODE_READ,
 						      false,
 						      GFP_KERNEL);
@@ -895,8 +895,8 @@ filelayout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = fl_pnfs_update_layout(pgio->pg_inode,
 						      nfs_req_openctx(req),
-						      0,
-						      NFS4_MAX_UINT64,
+						      req_offset(req),
+						      req->wb_bytes,
 						      IOMODE_RW,
 						      false,
 						      GFP_NOFS);
-- 
2.44.0


