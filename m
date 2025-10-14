Return-Path: <linux-nfs+bounces-15225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACF4BD942A
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595A4402F54
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A032E2657;
	Tue, 14 Oct 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j4EoRb05"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E248A312829
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443850; cv=none; b=kxYthZVy1G76nDLNO4aRlzXVoYyTvIbcVACi01TqRmh/r/qDQ9eKd9dDWf3ok1P90S6Foz09HmjBbPVHmHNFvA8dsJC7/2D8YyOQ6zG7+bHChOeZEx+8gu9Gh4M+FKkepTafQO+PwqReb+/1IxTW5at//Nhc5EKPTyNVUf52YzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443850; c=relaxed/simple;
	bh=J+pOFwFHc5MdTbyOWG6elVAn+TzaOGlfdoY3exz5yDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Y2vUw9WOOoWBL9h7VhXBEmCASwjsrx2dqsJpArM5oDDssKXiEnXyXCU8uPoVbDRf52tolYofHAV9Nv+WK5oqlnak58s6pSaBsXdY7YkyZECV5PmtYlfUAH/E/krJK3wQkxW1RB7y5GC9sokCm/3c/FtnkpxTP9W2HerE3I9uJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j4EoRb05; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251014121039epoutp02b771d90e94744fca315f906a02854e04~uWlhBOrzg2268022680epoutp026
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 12:10:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251014121039epoutp02b771d90e94744fca315f906a02854e04~uWlhBOrzg2268022680epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443839;
	bh=O2U42LWZMM8201UpxKxW6f/AsVjv4jB1OSfEppuAbYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4EoRb052CyFlWparM6vJ+IGSCEWjIS6wVo+S87KDQqDA0Ocmw/12pWxJHIIh31zH
	 Esi8h9OyxeOyR15xYVX5wm7qtnvdwsg04HJRPmJ/1moWx5u2peXU8xFWHwP0Tb4pM0
	 +fUQ0OawY0mVdzW1x06h3YX1hssKOUzItdHKdfpU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251014121038epcas5p4685b828d668366916b45d174d16a3637~uWlgJt7Oo0610406104epcas5p4-;
	Tue, 14 Oct 2025 12:10:38 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cmCj93Ktwz6B9m6; Tue, 14 Oct
	2025 12:10:37 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121036epcas5p17c607955db032d076daa2e5cfecfe8ea~uWleqppMN1447514475epcas5p1j;
	Tue, 14 Oct 2025 12:10:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121032epsmtip1fbff11e9fef5c6232ce81ec58fd0763b~uWlaFqXYA1256112561epsmtip1p;
	Tue, 14 Oct 2025 12:10:31 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 05/16] writeback: modify bdi_writeback search logic to
 search across all wb ctxs
Date: Tue, 14 Oct 2025 17:38:34 +0530
Message-Id: <20251014120845.2361-6-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121036epcas5p17c607955db032d076daa2e5cfecfe8ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121036epcas5p17c607955db032d076daa2e5cfecfe8ea
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121036epcas5p17c607955db032d076daa2e5cfecfe8ea@epcas5p1.samsung.com>

Since we have multiple cgwb per bdi, embedded in writeback_ctx now, we
iterate over all of them to find the associated writeback.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fs-writeback.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 56c048e22f72..93f8ea340247 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1090,7 +1090,8 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 {
 	struct backing_dev_info *bdi;
 	struct cgroup_subsys_state *memcg_css;
-	struct bdi_writeback *wb;
+	struct bdi_writeback *wb = NULL;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 	struct wb_writeback_work *work;
 	unsigned long dirty;
 	int ret;
@@ -1114,7 +1115,11 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 	 * And find the associated wb.  If the wb isn't there already
 	 * there's nothing to flush, don't create one.
 	 */
-	wb = wb_get_lookup(bdi->wb_ctx[0], memcg_css);
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		wb = wb_get_lookup(bdi_wb_ctx, memcg_css);
+		if (wb)
+			break;
+	}
 	if (!wb) {
 		ret = -ENOENT;
 		goto out_css_put;
-- 
2.25.1


