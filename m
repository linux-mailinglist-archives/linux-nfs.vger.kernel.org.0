Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951643D8575
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jul 2021 03:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhG1BgM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Jul 2021 21:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234193AbhG1BgM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Jul 2021 21:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627436171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=46KRT3+cfMESgew4s04fAx3fjFLM6xmwbFU2jMxBNo8=;
        b=Qd8Ia8wwDYYNgczC+r97uIsoS5GjPOBp+h0wGugdQ3PqbEyc27qZcoYNcWgTClNdlRvj2z
        j1gHlIuh0vPmFxE5o6nWMbEVvgGw+c/5oj1byVDGS0Re6Pi860KDV4tt0IL9QVsfYeBWr+
        86CN4R6vKCJWPR/yyqb/M4u3uL9m8eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-8PNq777QNcmC2BSSDfiksA-1; Tue, 27 Jul 2021 21:36:10 -0400
X-MC-Unique: 8PNq777QNcmC2BSSDfiksA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A97D1936B65
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jul 2021 01:36:09 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-115-162.phx2.redhat.com [10.3.115.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB05B18432
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jul 2021 01:36:08 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsdcltrack: Use uint64_t instead of time_t
Date:   Tue, 27 Jul 2021 21:36:08 -0400
Message-Id: <20210728013608.167759-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

With recent commits (4f2a5b64,5a53426c) that fixed
compile errors on x86_64 machines, caused similar
errors on i686 machines.

The variable type that was being used was a time_t,
which changes size between architects, which
caused the compile error.

Changing the variable to uint64_t fixed the issue.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/nfsdcltrack/nfsdcltrack.c | 2 +-
 utils/nfsdcltrack/sqlite.c      | 2 +-
 utils/nfsdcltrack/sqlite.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/nfsdcltrack/nfsdcltrack.c b/utils/nfsdcltrack/nfsdcltrack.c
index 0b37c094..7c1c4bcc 100644
--- a/utils/nfsdcltrack/nfsdcltrack.c
+++ b/utils/nfsdcltrack/nfsdcltrack.c
@@ -508,7 +508,7 @@ cltrack_gracedone(const char *timestr)
 {
 	int ret;
 	char *tail;
-	time_t gracetime;
+	uint64_t gracetime;
 
 
 	ret = sqlite_prepare_dbh(storagedir);
diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
index cea4a411..cf0c6a45 100644
--- a/utils/nfsdcltrack/sqlite.c
+++ b/utils/nfsdcltrack/sqlite.c
@@ -540,7 +540,7 @@ out_err:
  * remove any client records that were not reclaimed since grace_start.
  */
 int
-sqlite_remove_unreclaimed(time_t grace_start)
+sqlite_remove_unreclaimed(uint64_t grace_start)
 {
 	int ret;
 	char *err = NULL;
diff --git a/utils/nfsdcltrack/sqlite.h b/utils/nfsdcltrack/sqlite.h
index 06e7c044..ba8cdfa8 100644
--- a/utils/nfsdcltrack/sqlite.h
+++ b/utils/nfsdcltrack/sqlite.h
@@ -26,7 +26,7 @@ int sqlite_insert_client(const unsigned char *clname, const size_t namelen,
 int sqlite_remove_client(const unsigned char *clname, const size_t namelen);
 int sqlite_check_client(const unsigned char *clname, const size_t namelen,
 				const bool has_session);
-int sqlite_remove_unreclaimed(const time_t grace_start);
+int sqlite_remove_unreclaimed(const uint64_t grace_start);
 int sqlite_query_reclaiming(const time_t grace_start);
 
 #endif /* _SQLITE_H */
-- 
2.31.1

