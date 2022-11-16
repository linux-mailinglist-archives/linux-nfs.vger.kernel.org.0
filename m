Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48B862C28C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Nov 2022 16:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiKPP3a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 10:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiKPP32 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 10:29:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2629E15
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 07:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668612513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O1ntjw5lJkZk5tstBNlEfJG7WqcW0ZDZzgQ9XTtE5Jw=;
        b=HipnvziuRm0oLxLpsd5lkS8nd3bHbjsqqmksS/NaYyQ1MBI0TqUlhVLmVl7pWHlREMmbCS
        ++JgyPLZDkZR5CFakzFx3NJKfzcUy6tVrzWTGvhYgXudpyYkU3qxus0Wmlw2XWuEKQ/obm
        h7ej/Br6DcemIblrV4rCSnIVyo46Qnc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-glpAAsCmMxKmhFRDzBXWLw-1; Wed, 16 Nov 2022 10:28:32 -0500
X-MC-Unique: glpAAsCmMxKmhFRDzBXWLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C97073810794
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 15:28:31 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0D96C1912A
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 15:28:31 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: pass range end to vfs_fsync_range() instead of count
Date:   Wed, 16 Nov 2022 10:28:36 -0500
Message-Id: <20221116152836.3071683-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

_nfsd_copy_file_range() calls vfs_fsync_range() with an offset and
count (bytes written), but the former wants the start and end bytes
of the range to sync. Fix it up.

Fixes: eac0b17a77fb ("NFSD add vfs_fsync after async copy is done")
Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi all,

This is just a quick drive-by patch from scanning through various flush
callers for something unrelated. It looked like this instance passes a
count instead of the end offset and it was easy enough to throw up a
patch. Compile tested only, feel free to toss it if I've just missed
something, etc. etc.

Brian

 fs/nfsd/nfs4proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8beb2bc4c328..3c67d4cb1eba 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1644,6 +1644,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
 	u64 src_pos = copy->cp_src_pos;
 	u64 dst_pos = copy->cp_dst_pos;
 	int status;
+	loff_t end;
 
 	/* See RFC 7862 p.67: */
 	if (bytes_total == 0)
@@ -1663,8 +1664,8 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
 	/* for a non-zero asynchronous copy do a commit of data */
 	if (nfsd4_copy_is_async(copy) && copy->cp_res.wr_bytes_written > 0) {
 		since = READ_ONCE(dst->f_wb_err);
-		status = vfs_fsync_range(dst, copy->cp_dst_pos,
-					 copy->cp_res.wr_bytes_written, 0);
+		end = copy->cp_dst_pos + copy->cp_res.wr_bytes_written - 1;
+		status = vfs_fsync_range(dst, copy->cp_dst_pos, end, 0);
 		if (!status)
 			status = filemap_check_wb_err(dst->f_mapping, since);
 		if (!status)
-- 
2.37.3

