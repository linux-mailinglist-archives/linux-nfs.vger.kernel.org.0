Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C6741E25D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Sep 2021 21:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346118AbhI3Tqc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Sep 2021 15:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231637AbhI3Tq0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 Sep 2021 15:46:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6376B619E7;
        Thu, 30 Sep 2021 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633031083;
        bh=vbndCvgxr5inIoF1r22kWoImjoNLqs4shUtFiY+30Ck=;
        h=From:To:Cc:Subject:Date:From;
        b=d7w0qNQ408s3OOfYsvKekRAmCQkAiJRvWuULggRtbszcPSJlbSbFWfU4q+byajlBD
         c1Imch3OHD7OuslyoxciSclMa2JCa8/68fqMFkdm9TsrwAI4geTEq73MuY1DlTaJXx
         Ui4UjRuWNwEeqqGWBpoByZeaOb+OV3V9HDZrmaw6VTnfLZO5KA80baYGMRADYfDWX9
         IRC+EJY1UaNa429SSdXfQFdMYMPRtU6eShl1j7kCBUdsPq5Ftb5nXnBVVZrZ7kGSVQ
         sAmeaIa7PgegqBvNEaNVxoTQ8LShFKsMtzwKohTO0MatqASc2kp28b0iUJAdFHhUAu
         sR1X5fo6EdMQw==
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd4: Handle the NFSv4 READDIR 'dircount' hint being zero
Date:   Thu, 30 Sep 2021 15:44:41 -0400
Message-Id: <20210930194442.249907-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

RFC3530 notes that the 'dircount' field may be zero, in which case the
recommendation is to ignore it, and only enforce the 'maxcount' field.
In RFC5661, this recommendation to ignore a zero valued field becomes a
requirement.

Fixes: aee377644146 ("nfsd4: fix rd_dircount enforcement")
Cc: <stable@vger.kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4xdr.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..cf030ebe2827 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3544,15 +3544,18 @@ nfsd4_encode_dirent(void *ccdv, const char *name, int namlen,
 		goto fail;
 	cd->rd_maxcount -= entry_bytes;
 	/*
-	 * RFC 3530 14.2.24 describes rd_dircount as only a "hint", so
-	 * let's always let through the first entry, at least:
+	 * RFC 3530 14.2.24 describes rd_dircount as only a "hint", and
+	 * notes that it could be zero. If it is zero, then the server
+	 * should enforce only the rd_maxcount value.
 	 */
-	if (!cd->rd_dircount)
-		goto fail;
-	name_and_cookie = 4 + 4 * XDR_QUADLEN(namlen) + 8;
-	if (name_and_cookie > cd->rd_dircount && cd->cookie_offset)
-		goto fail;
-	cd->rd_dircount -= min(cd->rd_dircount, name_and_cookie);
+	if (cd->rd_dircount) {
+		name_and_cookie = 4 + 4 * XDR_QUADLEN(namlen) + 8;
+		if (name_and_cookie > cd->rd_dircount && cd->cookie_offset)
+			goto fail;
+		cd->rd_dircount -= min(cd->rd_dircount, name_and_cookie);
+		if (!cd->rd_dircount)
+			cd->rd_maxcount = 0;
+	}
 
 	cd->cookie_offset = cookie_offset;
 skip_entry:
-- 
2.31.1

