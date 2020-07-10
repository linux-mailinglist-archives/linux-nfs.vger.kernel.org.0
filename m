Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F49021BE99
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2020 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGJUhF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jul 2020 16:37:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46482 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727819AbgGJUhF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jul 2020 16:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594413423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Bd+5oT+q5+zV+4nbqO+g2MuR9O4uN8iXdTW3R18cuA=;
        b=SnxTvh6AfAs98DlHNlGrxxfQaWDBeCSofDoL2EHlrY674y9M8coPUdGhASTZ4CEt16stiW
        LQ3JfrXLHBBsdIDmhMejmD+KNhJGXy59wGXdsZDlncA0DkuWlWHnZXvAHG59wxX/KoZd/7
        +6Tyr8ccQe6ZryFNJ8SHB8w+BwY0y2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-SHXXqZF1NbCXwMnnFQctZw-1; Fri, 10 Jul 2020 16:37:02 -0400
X-MC-Unique: SHXXqZF1NbCXwMnnFQctZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E59D100AA22
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-113-242.rdu2.redhat.com [10.10.113.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32B646FEFB;
        Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 60AD31A01B8; Fri, 10 Jul 2020 16:37:00 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 1/5] nfsdcld: Fix a few Coverity Scan RESOURCE_LEAK errors
Date:   Fri, 10 Jul 2020 16:36:56 -0400
Message-Id: <20200710203700.2546112-2-smayhew@redhat.com>
In-Reply-To: <20200710203700.2546112-1-smayhew@redhat.com>
References: <20200710203700.2546112-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/legacy.c  | 2 ++
 utils/nfsdcld/nfsdcld.c | 1 +
 utils/nfsdcld/sqlite.c  | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/utils/nfsdcld/legacy.c b/utils/nfsdcld/legacy.c
index 3c6bea6..b8ea4ff 100644
--- a/utils/nfsdcld/legacy.c
+++ b/utils/nfsdcld/legacy.c
@@ -60,6 +60,7 @@ legacy_load_clients_from_recdir(int *num_records)
 	}
 	if (read(fd, recdirname, PATH_MAX) < 0) {
 		xlog(D_GENERAL, "Unable to read from %s: %m", NFSD_RECDIR_FILE);
+		close(fd);
 		return;
 	}
 	close(fd);
@@ -135,6 +136,7 @@ legacy_clear_recdir(void)
 	}
 	if (read(fd, recdirname, PATH_MAX) < 0) {
 		xlog(D_GENERAL, "Unable to read from %s: %m", NFSD_RECDIR_FILE);
+		close(fd);
 		return;
 	}
 	close(fd);
diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index be65562..bb8e365 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -331,6 +331,7 @@ cld_check_grace_period(void)
 	if (read(fd, &c, 1) < 0) {
 		xlog(L_WARNING, "Unable to read from %s: %m",
 			NFSD_END_GRACE_FILE);
+		close(fd);
 		return 1;
 	}
 	close(fd);
diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 6666c86..e61e67c 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -380,7 +380,7 @@ sqlite_maindb_init_v4(void)
 				&err);
 	if (ret != SQLITE_OK) {
 		xlog(L_ERROR, "Unable to begin transaction: %s", err);
-		return ret;
+		goto out;
 	}
 
 	/*
-- 
2.25.4

