Return-Path: <linux-nfs+bounces-15231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86175BD9445
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 14:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A111891E37
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 12:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31BF312839;
	Tue, 14 Oct 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oVP9IXio"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09487312828
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443880; cv=none; b=YC4ubj7PYJNFFWqhwp1ySBkVMkjQLLg8ZR52ETIQSozDyODyk6oteywJjnuGhnNZ/mGAjhK4PDVcvspFxuW3Io7oRhGTyaZ9z/mJcJ9iBNHcCV+3DHWUoxmQ0RA/hC9mmK+ZE0ZCxnAHwWwB8MeyVAgz7VicT2QQo+g/EQWbRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443880; c=relaxed/simple;
	bh=Uk7cyyg2hd/H5uuhJfVC9nvlwg+NURLd9l/mAUcyV/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=IhZH1GvYpXsNSxLUYhm92eI7EzEXYFgipYj0LzivNTiquATupFkIYBkd+O3ajhAcsfSToqujgk0OkZx7vDoWZFxdbQ8WQqEBj5id55Rlne8MaYsSgMHOuXIkadHGbkyTAyRA/Wtf3wDvATZP/p88exV2ZnYzrzhPs+zKxWnnqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oVP9IXio; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251014121115epoutp01219c9a33b19af2e1df27780176045a21~uWmCddbkF1126711267epoutp01n
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 12:11:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251014121115epoutp01219c9a33b19af2e1df27780176045a21~uWmCddbkF1126711267epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443875;
	bh=PXGKebblkuYyVq32XepqRXoghfCKJGEOOFxZca7FgOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVP9IXiobPJGIbz9EacCOAHSnCKNKbX9TBtPASsWhoBdgEe0oMU+HrFuS4ReblZ0t
	 dEPavhOeWgnqnMySP5yAQUtMsDeYs3csraClpoX6hpVmfRZTuVEcXZtA58eKuRbyi3
	 vQV6rZpeJRg/A/Ne5ajjbCCqphVMA7fnmh4zVRfc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251014121114epcas5p4d0d2a74508fa8c2ff7694bfcf2f9da2b~uWmBwq60C1326113261epcas5p4X;
	Tue, 14 Oct 2025 12:11:14 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cmCjs4c82z2SSKb; Tue, 14 Oct
	2025 12:11:13 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251014121113epcas5p3522dd553825deccfb9a1c9c12f071e3a~uWmAVF5dU1718117181epcas5p3R;
	Tue, 14 Oct 2025 12:11:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121108epsmtip16a22dad80f2ca2c63d567898c2d48def~uWl78CnMv1256112561epsmtip1G;
	Tue, 14 Oct 2025 12:11:08 +0000 (GMT)
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
Subject: [PATCH v2 11/16] gfs2: add support in gfs2 to handle multiple
 writeback contexts
Date: Tue, 14 Oct 2025 17:38:40 +0530
Message-Id: <20251014120845.2361-12-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121113epcas5p3522dd553825deccfb9a1c9c12f071e3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121113epcas5p3522dd553825deccfb9a1c9c12f071e3a
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121113epcas5p3522dd553825deccfb9a1c9c12f071e3a@epcas5p3.samsung.com>

Add support to handle multiple writeback contexts and check for
dirty_exceeded across all the writeback contexts

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/gfs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index bd11d5e6cf63..b1e00a64e5ec 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -447,7 +447,7 @@ static int gfs2_write_inode(struct inode *inode, struct writeback_control *wbc)
 		gfs2_log_flush(GFS2_SB(inode), ip->i_gl,
 			       GFS2_LOG_HEAD_FLUSH_NORMAL |
 			       GFS2_LFC_WRITE_INODE);
-	if (bdi->wb_ctx[0]->wb.dirty_exceeded)
+	if (bdi_wb_dirty_limit_exceeded(bdi))
 		gfs2_ail1_flush(sdp, wbc);
 	else
 		filemap_fdatawrite(metamapping);
-- 
2.25.1


