Return-Path: <linux-nfs+bounces-10091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A4DA34889
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 16:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2279C3A18FB
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9319B5A9;
	Thu, 13 Feb 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYYsQY6Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71626B087
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461650; cv=none; b=ZrxBSS92Vnf7iPDu1+FgZI6wzEuZ28d9ZrJ+LazBX9C3RPBo9PbpZPz/ojMQ+bjtucR/4Vfy/5Wv4lubDJFeNpk0YMttARmEYo+2QXnv0RBjY/46ZmB9+CNgXlYCIEbDcjR1bH5DXATfszUgOCRx98gaYLHj9NkjDJb/upyKsbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461650; c=relaxed/simple;
	bh=7u1B/OkDLpbFAiSb7+pNWMsgWNhFO/mIWj64LT4A2BE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dOAcWw/lDAE1dma5rnAs8CNej3xw9/BCvKE3sfLf1nptwNaisF8Skz74tQOiP4+TRfPzkwYLl2d40SdSZPSRisdQoxBcfxIsmkZTfJbAKQxRwY89LvnLYiYC7Ie5mXjQhslozEE8OPc4o7wBazC/RqPgV9uJeTsxMe93tXc0tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYYsQY6Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739461648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PNWdxmB35pklYU1YNpnOxi1+WmIoB2TSPli75WZLjIo=;
	b=VYYsQY6QQMwwgZKDeLIea1QEq0y6srcyfPH9n7+ogVMyY6h/c2kE8ns2Hji+uLrgEEFxih
	oMY9odQDhoiwo3rXuxNF0B9Bf2/dBrN81zM98q9/S1rCQ6dklVsqxp/2OOlSnc/r0JU4Xx
	wbv0GOvA+a4/e1g5NzJ+7y/BXcNp34k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-8NvHoL-SNvSV4q9M5FiPWw-1; Thu,
 13 Feb 2025 10:47:26 -0500
X-MC-Unique: 8NvHoL-SNvSV4q9M5FiPWw-1
X-Mimecast-MFC-AGG-ID: 8NvHoL-SNvSV4q9M5FiPWw_1739461645
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D80D180087C
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 15:47:25 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A3AE300018D;
	Thu, 13 Feb 2025 15:47:24 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] nfs-utils: nfsdctl: dont ignore rdma listener return
Date: Thu, 13 Feb 2025 10:47:22 -0500
Message-Id: <20250213154722.37499-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Don't ignore return code of adding rdma listener. If nfs.conf has asked
for "rdma=y" but adding the listener fails, don't ignore the failure.
Note in soft-rdma-provider environment (such as soft iwarp, soft roce),
when no address-constraints are used, an "any" listener is created and
rdma-enabling is done independently.

Fixes: e3b72007ab31 ("nfs-utils: nfsdctl: cleanup listeners if some failed")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 05fecc71..244910ef 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1388,7 +1388,7 @@ static int configure_listeners(void)
 			if (tcp)
 				ret = add_listener("tcp", n->field, port);
 			if (rdma)
-				add_listener("rdma", n->field, rdma_port);
+				ret = add_listener("rdma", n->field, rdma_port);
 			if (ret)
 				return ret;
 		}
@@ -1398,7 +1398,7 @@ static int configure_listeners(void)
 		if (tcp)
 			ret = add_listener("tcp", "", port);
 		if (rdma)
-			add_listener("rdma", "", rdma_port);
+			ret = add_listener("rdma", "", rdma_port);
 	}
 	return ret;
 }
-- 
2.47.1


