Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9F21BE97
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2020 22:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGJUhF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jul 2020 16:37:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47573 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726725AbgGJUhE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jul 2020 16:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594413423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2SzHac3Ct3/Ey8/0VOkLkyClJK2CehQmPHYM2FvcU3Q=;
        b=Lf6WHgKWR/MOwp1GkJEtnX56tx70w/70zxOU/zjDC8G3aM1dkvZ+ZbmXsxxHQLMQXiGCoP
        nkeUQ0pRFwa6bCMyPVRl28x0OH2Y91Df9osXDZbzShxh/A3vqM8BOj/nzpk9G9UyJ8iXXB
        NZNWcaYTuJerEAp8+/Chs3SBQ9Rih8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-GpwdaCizNT2UhuF09mwfyQ-1; Fri, 10 Jul 2020 16:37:02 -0400
X-MC-Unique: GpwdaCizNT2UhuF09mwfyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B718100A68E
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-113-242.rdu2.redhat.com [10.10.113.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F91210013C4;
        Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 6F4861A025A; Fri, 10 Jul 2020 16:37:00 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 4/5] nfsdcld: Fix a few Coverity Scan CLANG_WARNING errors
Date:   Fri, 10 Jul 2020 16:36:59 -0400
Message-Id: <20200710203700.2546112-5-smayhew@redhat.com>
In-Reply-To: <20200710203700.2546112-1-smayhew@redhat.com>
References: <20200710203700.2546112-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/nfsdcld.c | 6 ++++--
 utils/nfsdcld/sqlite.c  | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index bb8e365..9b6d2c3 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -252,11 +252,12 @@ cld_inotify_setup(void)
 		xlog_err("%s: inotify_add_watch failed: %m", __func__);
 		ret = -errno;
 		goto out_err;
-	}
+	} else
+		ret = 0;
 
 out_free:
 	free(dirc);
-	return 0;
+	return ret;
 out_err:
 	close(inotify_fd);
 	goto out_free;
@@ -796,6 +797,7 @@ main(int argc, char **argv)
 			break;
 		default:
 			usage(progname);
+			free(progname);
 			return 0;
 		}
 	}
diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index e61e67c..ef11a54 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -831,7 +831,6 @@ sqlite_prepare_dbh(const char *topdir)
 	switch (ret) {
 	case CLD_SQLITE_LATEST_SCHEMA_VERSION:
 		/* DB is already set up. Do nothing */
-		ret = 0;
 		break;
 	case 3:
 		/* Old DB -- update to new schema */
@@ -868,6 +867,8 @@ sqlite_prepare_dbh(const char *topdir)
 	}
 
 	ret = sqlite_startup_query_grace();
+	if (ret)
+		goto out_close;
 
 	ret = sqlite_query_first_time(&first_time);
 	if (ret)
-- 
2.25.4

