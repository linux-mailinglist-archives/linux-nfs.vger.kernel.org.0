Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E9C21BE9B
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2020 22:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgGJUhG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jul 2020 16:37:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56444 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727086AbgGJUhF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jul 2020 16:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594413424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GgT+smPK8ydn2uvNuNUXCThlyQSoQQBLBX5YcnJnuKA=;
        b=dTa+ASxZauGIDB0nSYuYwmcoxFwlmF3uT+V5LhPVrBaBwblOyc+C7bn9eKlPKwqmyUWoJt
        rD41ebihlE4McRRUW1jpSHmQ4GMat0LUmxirvcAdySvkBIqwE5Qa0a5HmM7N4YW4xpzJuV
        Sb4NHMmI7tz33jkkARA67aC76kfks3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-gVVs3nUAM6GU0ErWAU4lRg-1; Fri, 10 Jul 2020 16:37:03 -0400
X-MC-Unique: gVVs3nUAM6GU0ErWAU4lRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 244AB100AA23
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 20:37:02 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-113-242.rdu2.redhat.com [10.10.113.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 012467EF8F;
        Fri, 10 Jul 2020 20:37:01 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 729201A025E; Fri, 10 Jul 2020 16:37:00 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 5/5] nfsdcld: Fix a few Coverity Scan CHECKED_RETURN errors.
Date:   Fri, 10 Jul 2020 16:37:00 -0400
Message-Id: <20200710203700.2546112-6-smayhew@redhat.com>
In-Reply-To: <20200710203700.2546112-1-smayhew@redhat.com>
References: <20200710203700.2546112-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/legacy.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/utils/nfsdcld/legacy.c b/utils/nfsdcld/legacy.c
index 9e9f758..b89374c 100644
--- a/utils/nfsdcld/legacy.c
+++ b/utils/nfsdcld/legacy.c
@@ -51,18 +51,19 @@ legacy_load_clients_from_recdir(int *num_records)
 	char recdirname[PATH_MAX+1];
 	char buf[NFS4_OPAQUE_LIMIT];
 	char *nl;
+	ssize_t n;
 
 	fd = open(NFSD_RECDIR_FILE, O_RDONLY);
 	if (fd < 0) {
 		xlog(D_GENERAL, "Unable to open %s: %m", NFSD_RECDIR_FILE);
 		return;
 	}
-	if (read(fd, recdirname, PATH_MAX) < 0) {
+	n = read(fd, recdirname, PATH_MAX);
+	close(fd);
+	if (n < 0) {
 		xlog(D_GENERAL, "Unable to read from %s: %m", NFSD_RECDIR_FILE);
-		close(fd);
 		return;
 	}
-	close(fd);
 	/* the output from the proc file isn't null-terminated */
 	recdirname[PATH_MAX] = '\0';
 	nl = strchr(recdirname, '\n');
@@ -118,18 +119,19 @@ legacy_clear_recdir(void)
 	char recdirname[PATH_MAX+1];
 	char dirname[PATH_MAX];
 	char *nl;
+	ssize_t n;
 
 	fd = open(NFSD_RECDIR_FILE, O_RDONLY);
 	if (fd < 0) {
 		xlog(D_GENERAL, "Unable to open %s: %m", NFSD_RECDIR_FILE);
 		return;
 	}
-	if (read(fd, recdirname, PATH_MAX) < 0) {
+	n = read(fd, recdirname, PATH_MAX);
+	close(fd);
+	if (n < 0) {
 		xlog(D_GENERAL, "Unable to read from %s: %m", NFSD_RECDIR_FILE);
-		close(fd);
 		return;
 	}
-	close(fd);
 	/* the output from the proc file isn't null-terminated */
 	recdirname[PATH_MAX] = '\0';
 	nl = strchr(recdirname, '\n');
-- 
2.25.4

