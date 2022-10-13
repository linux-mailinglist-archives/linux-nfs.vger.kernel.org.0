Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C52E5FDD5F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Oct 2022 17:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJMPof (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Oct 2022 11:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJMPoT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Oct 2022 11:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D570D1119C3
        for <linux-nfs@vger.kernel.org>; Thu, 13 Oct 2022 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665675823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8ziK4NEsPWhN0vELM2VCT6dmtCPFq+C9GZJ2KIpNhfc=;
        b=EKYMlQ4OUibRVTRoXVtUDA0KIB8rRTeemm8id6Cs1DwQqKcGArUS+x2oyc+YvfEggBb2Mk
        LtAIQtZBWsw/LGWh6K3t2YMmEcf5BVJQS4dzGzpx0nhmZb7d/fdGDjb+NsF8hkHxhaVbuq
        Aq/AKGHdaX4dgvmmSczVkXMB8SxxpXE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-qCoXqRC7Pcaile4I1xryqQ-1; Thu, 13 Oct 2022 11:43:39 -0400
X-MC-Unique: qCoXqRC7Pcaile4I1xryqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FBFF803D48;
        Thu, 13 Oct 2022 15:43:39 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.19.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E726C1912A;
        Thu, 13 Oct 2022 15:43:39 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id EBB0B10C30EA; Thu, 13 Oct 2022 11:04:22 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4.2: Fixup CLONE dest file size for zero-length count
Date:   Thu, 13 Oct 2022 11:04:22 -0400
Message-Id: <0219a5efb29a9a960af5e4271cf67c8cb17811b2.1665673367.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When holding a delegation, the NFS client optimizes away setting the
attributes of a file from the GETATTR in the compound after CLONE, and for
a zero-length CLONE we will end up setting the inode's size to zero in
nfs42_copy_dest_done().  Handle this case by computing the resulting count
from the server's reported size after CLONE's GETATTR.

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs42proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index d37e4a5401b1..d07189095f05 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1093,6 +1093,9 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 				&args.seq_args, &res.seq_res, 0);
 	trace_nfs4_clone(src_inode, dst_inode, &args, status);
 	if (status == 0) {
+		/* a zero-length count means clone to EOF in src */
+		if (count == 0 && res.dst_fattr->valid & NFS_ATTR_FATTR_SIZE)
+			count = nfs_size_to_loff_t(res.dst_fattr->size) - dst_offset;
 		nfs42_copy_dest_done(dst_inode, dst_offset, count);
 		status = nfs_post_op_update_inode(dst_inode, res.dst_fattr);
 	}
-- 
2.31.1

