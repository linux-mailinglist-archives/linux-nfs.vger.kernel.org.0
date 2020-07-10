Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047D621BE98
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2020 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGJUhG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jul 2020 16:37:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47398 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728003AbgGJUhE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jul 2020 16:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594413424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2/NR4kk3V/5MSue4Jd/eO1ySNEoIzIaezmCb0xLGuU=;
        b=NWGmU6NxW9hE8RH0MnseVMj4DP/4LjEmDaePWgq3ScB7zDv00dWv4geXR7NWw2ati7pGj2
        dcLNKmM3ChPIuFEGIf5uRqmMiRWsPMisnT/l/dCMwZFFD4lhY2E2mLyGbzZpHXXiqZr5Tk
        sKwKx2r/36sU2TUvD/ilIN0eI5yWGPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-xtKjjtEnML-8d7G1NT7BVw-1; Fri, 10 Jul 2020 16:37:02 -0400
X-MC-Unique: xtKjjtEnML-8d7G1NT7BVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33DE41B18BC0
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-113-242.rdu2.redhat.com [10.10.113.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1949A6FEC2;
        Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 6B8401A0257; Fri, 10 Jul 2020 16:37:00 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 3/5] nfsdcld: Fix a few Coverity Scan STRING_NULL errors
Date:   Fri, 10 Jul 2020 16:36:58 -0400
Message-Id: <20200710203700.2546112-4-smayhew@redhat.com>
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
 utils/nfsdcld/legacy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/utils/nfsdcld/legacy.c b/utils/nfsdcld/legacy.c
index 1fb74d4..9e9f758 100644
--- a/utils/nfsdcld/legacy.c
+++ b/utils/nfsdcld/legacy.c
@@ -48,7 +48,7 @@ legacy_load_clients_from_recdir(int *num_records)
 	int fd;
 	DIR *v4recovery;
 	struct dirent *entry;
-	char recdirname[PATH_MAX];
+	char recdirname[PATH_MAX+1];
 	char buf[NFS4_OPAQUE_LIMIT];
 	char *nl;
 
@@ -64,6 +64,7 @@ legacy_load_clients_from_recdir(int *num_records)
 	}
 	close(fd);
 	/* the output from the proc file isn't null-terminated */
+	recdirname[PATH_MAX] = '\0';
 	nl = strchr(recdirname, '\n');
 	if (!nl)
 		return;
@@ -114,7 +115,7 @@ legacy_clear_recdir(void)
 	int fd;
 	DIR *v4recovery;
 	struct dirent *entry;
-	char recdirname[PATH_MAX];
+	char recdirname[PATH_MAX+1];
 	char dirname[PATH_MAX];
 	char *nl;
 
@@ -130,6 +131,7 @@ legacy_clear_recdir(void)
 	}
 	close(fd);
 	/* the output from the proc file isn't null-terminated */
+	recdirname[PATH_MAX] = '\0';
 	nl = strchr(recdirname, '\n');
 	if (!nl)
 		return;
-- 
2.25.4

