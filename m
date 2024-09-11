Return-Path: <linux-nfs+bounces-6393-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED348975AF5
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 21:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983CB1F23EF8
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 19:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2931BBBC1;
	Wed, 11 Sep 2024 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzFL0yxA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62F1BB6A6
	for <linux-nfs@vger.kernel.org>; Wed, 11 Sep 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083807; cv=none; b=g7dgVQQK04e7rVvtnwLSGhZgVnMkFLstb7YOEpDrykcW3351qGSZj34F5Yz2kEMLA9vHBanNlrhgSTuM8u27c0oBxQwA4corqI44GwKnLhpBULbia5rP+jjIRV4V5fcUaPe/9uGfVzAiMg05fiN+CH7GhzIgIkT3zaaKwqcB4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083807; c=relaxed/simple;
	bh=YX7ObtXJ2YjTVLS7KdkFBLKT+i/Pn28RHIFNRG4BOIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUNVP6JzlfPnoPH20eO+7mZIjm47W1KTk5CRetGn5hCXzWDvKp+M29a74lv1jC8jrcKRUpsXGcy4n4keIjF2azt3RE9L+RMJk4tX4gKtMLNZyGyj5xHa8T7svz+ACQPuMSKYNy917GAlCdfnjwtxyMROaPtGsz/2jMhKYK20E+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzFL0yxA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726083805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPLgX1Q9d4+4urj+73qqK9akNSzqf2/CnGKfFlJlHGY=;
	b=NzFL0yxAS1qe9OiASM2A3bpdZpHwcrOLX6QuyPZnOKfPdeBb438+J4QyBQc7DKEMATmzH9
	ttb/e6YRIwwCFU/ncggF2lpFlULYb/RbhSrro5gS2hmHRRigFL6xus/mSVG6/Ki3D0pHqC
	repKVG4dXphCca/Lifzm0QeZqKgxb7I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-PEnLAncROZasySFNq4XPUg-1; Wed,
 11 Sep 2024 15:43:20 -0400
X-MC-Unique: PEnLAncROZasySFNq4XPUg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39A3A19560A2;
	Wed, 11 Sep 2024 19:43:17 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C53BB1956086;
	Wed, 11 Sep 2024 19:43:12 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Ahring Oder Aring <aahringo@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev,
	ocfs2-devel@lists.linux.dev
Subject: [PATCH v1 2/4] gfs2/ocfs2: set FOP_ASYNC_LOCK
Date: Wed, 11 Sep 2024 15:42:58 -0400
Message-ID: <fc4163dbbf33c58e5a8b8ee8cb8c57e555f53ce5.1726083391.git.bcodding@redhat.com>
In-Reply-To: <cover.1726083391.git.bcodding@redhat.com>
References: <cover.1726083391.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Both GFS2 and OCFS2 use DLM locking, which will allow async lock requests.
Signal this support by setting FOP_ASYNC_LOCK.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/gfs2/file.c  | 2 ++
 fs/ocfs2/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 08982937b5df..b9ed2602287d 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1586,6 +1586,7 @@ const struct file_operations gfs2_file_fops = {
 	.splice_write	= gfs2_file_splice_write,
 	.setlease	= simple_nosetlease,
 	.fallocate	= gfs2_fallocate,
+	.fop_flags	= FOP_ASYNC_LOCK,
 };
 
 const struct file_operations gfs2_dir_fops = {
@@ -1598,6 +1599,7 @@ const struct file_operations gfs2_dir_fops = {
 	.lock		= gfs2_lock,
 	.flock		= gfs2_flock,
 	.llseek		= default_llseek,
+	.fop_flags	= FOP_ASYNC_LOCK,
 };
 
 #endif /* CONFIG_GFS2_FS_LOCKING_DLM */
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ccc57038a977..a642f1adee6a 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2793,6 +2793,7 @@ const struct file_operations ocfs2_fops = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ocfs2_fallocate,
 	.remap_file_range = ocfs2_remap_file_range,
+	.fop_flags	= FOP_ASYNC_LOCK,
 };
 
 WRAP_DIR_ITER(ocfs2_readdir) // FIXME!
@@ -2809,6 +2810,7 @@ const struct file_operations ocfs2_dops = {
 #endif
 	.lock		= ocfs2_lock,
 	.flock		= ocfs2_flock,
+	.fop_flags	= FOP_ASYNC_LOCK,
 };
 
 /*
-- 
2.44.0


