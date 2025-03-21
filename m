Return-Path: <linux-nfs+bounces-10749-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAE0A6BE3F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 16:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8C14638D3
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8011C1E0DD1;
	Fri, 21 Mar 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLmE4U+z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6DC1DF721
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570468; cv=none; b=Obo1DCqvk6Rr26BUI/gRVaskyJUWSZNfO/HaOuiRRPokQkLFu1rHdp4cS9c6qoABmOFmjRsFsbk6DGQzOa3ud3Lbgs+qdJ/fh3+aiigRRrWeqdj+Zka704412WpjXFQFLbxNA8sxQtVjxgTHZiXLnkKtK94V10Nnl0APId81kYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570468; c=relaxed/simple;
	bh=VT8B0H3UBNpAVD6YZld9Ygkj9dKbicilQ4bPR/E3oJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpOPSnGNjtJE3gPKTt2ZJYq0ERfo0a+sBxgu7u1JFqN/H7CeJvQ1mKqXHZKECLbDQ1H0XpFRXGaf16GGBcVHCv87/t31h5ypgYurF4Fj8WIKSaHzf4cEVo2u536nQ5FM21+o8mGqNF3wQAOsq4UJBqBQ93XYooLdTKoqV+/iBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLmE4U+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C7FC4CEEE;
	Fri, 21 Mar 2025 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742570468;
	bh=VT8B0H3UBNpAVD6YZld9Ygkj9dKbicilQ4bPR/E3oJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLmE4U+zZRD8TNQk5fEdYaLz+uX1QrKywNSWs2MqYDz6a001rDmohYWok21UiuFk5
	 RkmqzgSD8j6oZkcy7j31+6BDnZoSvQ/jBpOHm6Pw2997RNY2l7PN+nMQpDYu69eP4A
	 DDcH4S+kZy7USgJIaryM0zIIFuOpGjADn/YhTlo7XBL1fYwXeGLa0hct3osNEaa4OB
	 HqnOWSj9/CzRq2xvdoVDIPQJ/iAPVLleor70hKYNVOKLmmP4JJYUtyRSiI4l/w9Ap8
	 1VzQrhgLej10MK1xdWUYAyj2hnN4kO+yVGO0IQUavSZmUFbjbMoXB2T6R/DMPZfv9T
	 Berytb1T2LYqw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 4/4] pNFS/flexfiles: Report ENETDOWN as a connection error
Date: Fri, 21 Mar 2025 11:21:04 -0400
Message-ID: <cae600abf6bd2953a8a54bcf3191a00569de70df.1742570192.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742570192.git.trond.myklebust@hammerspace.com>
References: <cover.1742570192.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the client should see an ENETDOWN when trying to connect to the data
server, it might still be able to talk to the metadata server through
another NIC. If so, report the error.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index f89fdba7289d..61ad269c825f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1274,6 +1274,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
-- 
2.49.0


