Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB5D2BBF42
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 14:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgKUN3v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 08:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgKUN3v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 08:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605965389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=J6xwu6+u1foI6kR1phHej5hvt+QmOmb70x1vccYwCSg=;
        b=f39zYXqAEk8GHyNHiFFDVh6MxIb4EhrGOo0EI69WLCFJzRMzObI0B8h72+jWuaEfhStq5B
        OYAxljNJuoSInNgxMwXh2MRnIpbkFIP+ewsUQZ98D0UwRksU5leXn1/hBKQKVTaNlO8kfB
        VBKrfw7bRYdvBmMZI37pGmNgrqBusQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-_TsHyNcXPkSaVYdUicdiJQ-1; Sat, 21 Nov 2020 08:29:47 -0500
X-MC-Unique: _TsHyNcXPkSaVYdUicdiJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B13C13FF5;
        Sat, 21 Nov 2020 13:29:46 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-41.rdu2.redhat.com [10.10.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38F5A5C1D5;
        Sat, 21 Nov 2020 13:29:46 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, dhowells@redhat.com
Subject: [PATCH v1 13/13] NFS: Ensure proper page unlocking when reads fail with retryable errors
Date:   Sat, 21 Nov 2020 08:29:44 -0500
Message-Id: <1605965384-24936-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The netfs API handles unlock of pages involved in IOs.
However, the current NFS client implementation only utilizes the netfs
API when fscache is enabled.  If fscache is disabled, NFS is then
responsible for unlocking pages involved in READs.  This patch
addresses an issue when fscache is enabled and READs complete with a
retryable error.

Specifically this problem is easily reproduced with the connectathon
'holey' test with NFSv2 and a NFS server that does not support
READ_PLUS.  With such a configuration, the READ_PLUS operation fails
with -ENOTSUPP (-524), and due to commit 8f54c7a4babf
("NFS: Fix spurious EIO read errors"), inside nfs_readpage_release()
the page is removed from the mapping via generic_error_remove_page().
Since fscache was enabled, nfs_readpage_release() skipped unlocking
the page, with the assumption that netfs_subreq_terminated() would
unltimately unlock the page inside netfs_rreq_unlock().  However,
since NFS removed the page from the mapping, netfs_rreq_unlock()
failed to see the page when iterating with xas_for_each, leaving
the page locked.  Sometime later when the page was freed, a bad
page error would result.

Fix the above by ensuring NFS unlocks the page and does not call
netfs_subreq_terminated() when NFS encounters a retryable error
with fscache enabled.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index da44ce68488c..92992f5baf0b 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -123,11 +123,10 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 	if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
 		struct address_space *mapping = page_file_mapping(page);
 
-		if (PageUptodate(page))
-			; /* FIXME: review fscache page error handling */
-		else if (!PageError(page) && !PagePrivate(page))
+		if (!PageUptodate(page) && !PageError(page) && !PagePrivate(page))
 			generic_error_remove_page(mapping, page);
-		if (!nfs_i_fscache(inode))
+		if (!nfs_i_fscache(inode) ||
+		    (nfs_i_fscache(inode) && error && !nfs_error_is_fatal_on_server(error)))
 			unlock_page(page);
 	}
 	nfs_release_request(req);
@@ -182,8 +181,9 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 		nfs_list_remove_request(req);
 		nfs_readpage_release(req, error);
 	}
-	/* FIXME: NFS_IOHDR_ERROR and NFS_IOHDR_EOF handled per-page */
-	nfs_read_completion_to_fscache(hdr, bytes);
+	/* Only call back into fscache if the read was not retried */
+	if (!hdr->error || nfs_error_is_fatal_on_server(hdr->error))
+		nfs_read_completion_to_fscache(hdr, bytes);
 out:
 	hdr->release(hdr);
 }
-- 
1.8.3.1

