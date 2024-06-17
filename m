Return-Path: <linux-nfs+bounces-3875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC3390A1C1
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253A11C20E84
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8291E1A702;
	Mon, 17 Jun 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOGjn2lO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32318E10
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587516; cv=none; b=iJ6LJfVWDwDjMMBL4VERerhVPVjNUUYa2UjgYwKWw+d7vcs1xLLnjf96s76j9WeEa+ch2EqTzTprOHxQxHbQIK8PVp3ACQDU+TIFnkp5YUMyW0LmLFesKqHv36+11x99cTXZl4cfXbKzu1Uc9ae888LMGiNL6ZjyBJY9dNRJ59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587516; c=relaxed/simple;
	bh=Sav426E9/4lIIZpy7/JpWxrqeGI2pX4ieZuiLepznMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZyt14PK+GHRyBf9Wi2UZQwWnpV2wRcRHt9naZQSwdDzrhsbiO+96wjbNTWIzfLL7kIA/RS+TY3jMgjK9+l1Uj5N5pnGAZl7TheOQs6NBWuLkaUVAI82SQEKrL2A7UvtRbUi/EOCqwFBWGpM2cKWCaMwKqIEDNUlsXr6oooFmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOGjn2lO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155E1C2BBFC
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587516;
	bh=Sav426E9/4lIIZpy7/JpWxrqeGI2pX4ieZuiLepznMk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sOGjn2lOmJ0PXqTq6PywtcBFOS3F3/K3dPECmYLp6EjtrbEZuDd10R5GWpDek1Ygb
	 Y5Lb4fiZbxmX6FT6M2vh25iHOTwV4sVhe1jM2hON/JQuGhem0MJhRdqcpxjS1FTP5i
	 WoKF5Z8oohFBWHN9k9+M5/DG5gzTg9YwQjWo3iCQtI630FcTchCdVi9te7wc3qvVA7
	 jsTC6XqPC1yAsQLSrT6761877TEdTNdPEiDgtqEcZX0zSoFV0aEan1pIN7UpohSlC3
	 Mh2MXGTrjVIIEfOvgUkAxNf5ETsXeW9JNwEvMUILgWzvmRadnkncmltFu/ZbPXSP4d
	 RpJ0chEQ/ScDA==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 16/19] NFSv4: Add support for OPEN4_RESULT_NO_OPEN_STATEID
Date: Sun, 16 Jun 2024 21:21:34 -0400
Message-ID: <20240617012137.674046-17-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-16-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
 <20240617012137.674046-9-trondmy@kernel.org>
 <20240617012137.674046-10-trondmy@kernel.org>
 <20240617012137.674046-11-trondmy@kernel.org>
 <20240617012137.674046-12-trondmy@kernel.org>
 <20240617012137.674046-13-trondmy@kernel.org>
 <20240617012137.674046-14-trondmy@kernel.org>
 <20240617012137.674046-15-trondmy@kernel.org>
 <20240617012137.674046-16-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

If the server returns a delegation stateid only, then don't try to set
an open stateid.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index adf4fc8610f6..5b18aac0b34a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2035,8 +2035,11 @@ _nfs4_opendata_reclaim_to_nfs4_state(struct nfs4_opendata *data)
 				data->o_arg.claim,
 				&data->o_res.delegation);
 
-	if (!update_open_stateid(state, &data->o_res.stateid,
-				NULL, data->o_arg.fmode))
+	if (!(data->o_res.rflags & NFS4_OPEN_RESULT_NO_OPEN_STATEID)) {
+		if (!update_open_stateid(state, &data->o_res.stateid,
+					 NULL, data->o_arg.fmode))
+			return ERR_PTR(-EAGAIN);
+	} else if (!update_open_stateid(state, NULL, NULL, data->o_arg.fmode))
 		return ERR_PTR(-EAGAIN);
 	refcount_inc(&state->count);
 
@@ -2105,8 +2108,13 @@ _nfs4_opendata_to_nfs4_state(struct nfs4_opendata *data)
 				data->o_arg.claim,
 				&data->o_res.delegation);
 
-	if (!update_open_stateid(state, &data->o_res.stateid,
-				NULL, data->o_arg.fmode)) {
+	if (!(data->o_res.rflags & NFS4_OPEN_RESULT_NO_OPEN_STATEID)) {
+		if (!update_open_stateid(state, &data->o_res.stateid,
+					 NULL, data->o_arg.fmode)) {
+			nfs4_put_open_state(state);
+			state = ERR_PTR(-EAGAIN);
+		}
+	} else if (!update_open_stateid(state, NULL, NULL, data->o_arg.fmode)) {
 		nfs4_put_open_state(state);
 		state = ERR_PTR(-EAGAIN);
 	}
-- 
2.45.2


