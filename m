Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB221BE9A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2020 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgGJUhG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jul 2020 16:37:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42672 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgGJUhF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jul 2020 16:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594413424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGBjYBBnrmlbW76UC/Zf/TpBSoipVj9Ds1NUss7ASjM=;
        b=CAbpOjh+YN3lE3TadSGLQjkFkQmm9x9h22U5fMSFY0ZtYVci5+k4f+R8RFTeH8Lxv4/fsA
        +NGnZL+0/QMaAZLVBUmaiJbUmYLUslklfgRlRO9WQbD7JRla0nckV0FZT6muXGrCZk5uGr
        dHDhc7U2wz0DKcbHRNy/ffrMdMWxm1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-Gsv9TsmXOJuYUNuvuPGekQ-1; Fri, 10 Jul 2020 16:37:02 -0400
X-MC-Unique: Gsv9TsmXOJuYUNuvuPGekQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32D3D800597
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-113-242.rdu2.redhat.com [10.10.113.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1956B7EF92;
        Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 67B3B1A0254; Fri, 10 Jul 2020 16:37:00 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 2/5] nfsdcld: Fix a few Coverity Scan TOCTOU errors
Date:   Fri, 10 Jul 2020 16:36:57 -0400
Message-Id: <20200710203700.2546112-3-smayhew@redhat.com>
In-Reply-To: <20200710203700.2546112-1-smayhew@redhat.com>
References: <20200710203700.2546112-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Calling stat() on recdirname so that we can see if it's a directory is
unnecessary anyways, since opendir() will report an error if it's not.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/legacy.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/utils/nfsdcld/legacy.c b/utils/nfsdcld/legacy.c
index b8ea4ff..1fb74d4 100644
--- a/utils/nfsdcld/legacy.c
+++ b/utils/nfsdcld/legacy.c
@@ -50,7 +50,6 @@ legacy_load_clients_from_recdir(int *num_records)
 	struct dirent *entry;
 	char recdirname[PATH_MAX];
 	char buf[NFS4_OPAQUE_LIMIT];
-	struct stat st;
 	char *nl;
 
 	fd = open(NFSD_RECDIR_FILE, O_RDONLY);
@@ -69,15 +68,6 @@ legacy_load_clients_from_recdir(int *num_records)
 	if (!nl)
 		return;
 	*nl = '\0';
-	if (stat(recdirname, &st) < 0) {
-		xlog(D_GENERAL, "Unable to stat %s: %d", recdirname, errno);
-		return;
-	}
-	if (!S_ISDIR(st.st_mode)) {
-		xlog(D_GENERAL, "%s is not a directory: mode=0%o", recdirname
-				, st.st_mode);
-		return;
-	}
 	v4recovery = opendir(recdirname);
 	if (!v4recovery)
 		return;
@@ -126,7 +116,6 @@ legacy_clear_recdir(void)
 	struct dirent *entry;
 	char recdirname[PATH_MAX];
 	char dirname[PATH_MAX];
-	struct stat st;
 	char *nl;
 
 	fd = open(NFSD_RECDIR_FILE, O_RDONLY);
@@ -145,15 +134,6 @@ legacy_clear_recdir(void)
 	if (!nl)
 		return;
 	*nl = '\0';
-	if (stat(recdirname, &st) < 0) {
-		xlog(D_GENERAL, "Unable to stat %s: %d", recdirname, errno);
-		return;
-	}
-	if (!S_ISDIR(st.st_mode)) {
-		xlog(D_GENERAL, "%s is not a directory: mode=0%o", recdirname
-				, st.st_mode);
-		return;
-	}
 	v4recovery = opendir(recdirname);
 	if (!v4recovery)
 		return;
-- 
2.25.4

