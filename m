Return-Path: <linux-nfs+bounces-13838-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88CDB3000F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 18:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59953AD159
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1B32DCF71;
	Thu, 21 Aug 2025 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQg4Iqjg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764B2DCF5C
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793622; cv=none; b=HPtqUJI2QhQSENlbm3pAaIj9eWAQXuF85pTG6i8YiflhB7ID2M9hZ+m+UwlA7Xnip3r9MGwr+x6r+TM7SRSWk5uA1ugsx30wZQ1l2nS7wBbPjhCzKbH4bx4WvnoiEbO6A0jahpVhCqKHyKYZF4g5QRARh0I97vjs9wp+jcX1e/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793622; c=relaxed/simple;
	bh=+VzcWTmw1zOIurogNqLl2MfgxNCnJ+tfc8p1MNpHJYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+Kyc9DxiOLwLBXWXXfbdgbcBlQEY9B0uvuhDydw4xBM3q+f3fNsV6+lacnIM+QpMNjfLMC9ZSGjSBKCVGcTy7WBuMhs1qGBPiXrggwlcy7U9LdvVi8x3yEVsOrmd/KIFeCtEFhWxYx+JZ8olprL+H1XmVVvu2p9VA0t9jr33HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQg4Iqjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE83C4CEEB;
	Thu, 21 Aug 2025 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755793621;
	bh=+VzcWTmw1zOIurogNqLl2MfgxNCnJ+tfc8p1MNpHJYI=;
	h=From:To:Cc:Subject:Date:From;
	b=WQg4IqjgC+vBKLXayfM8WVwsWXvHVaWblmYHQCY8P1d30BbfSNt+zro+s+qWCMv/l
	 OkI4DkWau6AJ0rQFyT8E68bSNjzmYlv/s9i7b52S2gXEzefpYm5aOj9l/aYbIx7tor
	 KG14vd15n1DK6ih8+vWvM8trGTB6rl/rILqcrLGFihBehb1eXrwNxxzbkceAop1HN5
	 9VYItvT6WLY2ni0TkqlMaEH8l8u1St2dazEQ6YTKVgoaSAdBsUtYFWX5H4HB/8zSGu
	 GV82maSxJi/nPRotSqcheZBBlk6qeyohuhdxKMm82WMIQxvm926qAh5XaaDzSBYTa+
	 J26/wApjuuaNw==
From: Jeff Layton <jlayton@kernel.org>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: remove NFS_WBACK_BUSY()
Date: Thu, 21 Aug 2025 12:27:00 -0400
Message-ID: <20250821162700.216374-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing calls this macro.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/nfs_page.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 9aed39abc94b..afe1d8f09d89 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -122,8 +122,6 @@ struct nfs_pageio_descriptor {
 /* arbitrarily selected limit to number of mirrors */
 #define NFS_PAGEIO_DESCRIPTOR_MIRROR_MAX 16
 
-#define NFS_WBACK_BUSY(req)	(test_bit(PG_BUSY,&(req)->wb_flags))
-
 extern struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
 						  struct page *page,
 						  unsigned int pgbase,
-- 
2.50.1


