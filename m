Return-Path: <linux-nfs+bounces-6356-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766129723A7
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 22:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1D61F2314D
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 20:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87D818A6B2;
	Mon,  9 Sep 2024 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVUIz7of"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E618A6A8
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913743; cv=none; b=DE84c+cfVpB4b90fInt+z6OcXY2RKBFqBQqEKVsf1OTSt/07B4SlU+cLwpZqUeWw3+Tif7e8w5JH2YrzJrSYQtZk2QyrZMaP0TGzMnjRB8DFm4JKIcEHYgY7gIv6PmMYeU8C78yM0TDF8qz617j5pkcXrh5Fi9+AiavDfc3I5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913743; c=relaxed/simple;
	bh=UzhEB13maOk3tfFQWJ21Cc/FHNVMXVrN/FtLCwHXIH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfjF2hm1E2R4XsebLYib71TJeBkoGyGf3KXCU3UfqCOC+omOr8FJVmSzC4eEQh1oFfqVpNL01N8bf737erG2hwokgZjyUptH3QxP3kpfIeiBQuurMUfLlvDqVS7N2pzcWtEdy14kEKFfppHSWvyUMgnaq3D3b8D14lW01Zckz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVUIz7of; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725913741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ALi3vYYqKPuZewPD1/DqZ7vNgkjolSZ7sXCbGXWONQ=;
	b=AVUIz7ofEy+rjpLYoisL1LhA4p1kM5i4HGhz/fT/pOjX2m295zo9BehIlAxsbXgFEGQZuP
	vKq5d8oUSMEndZOyjIdrWn97ELVpKRFjiFNybLMa+/TpCExAgmB3hYe81L6iY9mSTc1Mvi
	mhFERbFNxwTG0pZfwNp3QEbIF6uD60k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-4MT9WRo_N6W4sYjWTz-KbA-1; Mon,
 09 Sep 2024 16:28:57 -0400
X-MC-Unique: 4MT9WRo_N6W4sYjWTz-KbA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07A801955F2C;
	Mon,  9 Sep 2024 20:28:57 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.160])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C21F13000239;
	Mon,  9 Sep 2024 20:28:56 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 265D01F1B67;
	Mon,  9 Sep 2024 16:28:55 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfsd: enforce upper limit for namelen in __cld_pipe_inprogress_downcall()
Date: Mon,  9 Sep 2024 16:28:54 -0400
Message-ID: <20240909202855.510399-2-smayhew@redhat.com>
In-Reply-To: <20240909202855.510399-1-smayhew@redhat.com>
References: <Zt8BuA4gxVMpBUcW@tissot.1015granger.net>
 <20240909202855.510399-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch is intended to go on top of "nfsd: return -EINVAL when
namelen is 0" from Li Lingfeng.  Li's patch checks for 0, but we should
be enforcing an upper bound as well.

Note that if nfsdcld somehow gets an id > NFS4_OPAQUE_LIMIT in its
database, it'll truncate it to NFS4_OPAQUE_LIMIT when it does the
downcall anyway.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/nfs4recover.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 69a3a84e159e..a2b995ee77f4 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -809,8 +809,8 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 			ci = &cmsg->cm_u.cm_clntinfo;
 			if (get_user(namelen, &ci->cc_name.cn_len))
 				return -EFAULT;
-			if (!namelen) {
-				dprintk("%s: namelen should not be zero", __func__);
+			if (namelen == 0 || namelen > NFS4_OPAQUE_LIMIT) {
+				dprintk("%s: invalid namelen (%u)", __func__, namelen);
 				return -EINVAL;
 			}
 			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
@@ -835,8 +835,8 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 			cnm = &cmsg->cm_u.cm_name;
 			if (get_user(namelen, &cnm->cn_len))
 				return -EFAULT;
-			if (!namelen) {
-				dprintk("%s: namelen should not be zero", __func__);
+			if (namelen == 0 || namelen > NFS4_OPAQUE_LIMIT) {
+				dprintk("%s: invalid namelen (%u)", __func__, namelen);
 				return -EINVAL;
 			}
 			name.data = memdup_user(&cnm->cn_id, namelen);
-- 
2.46.0


