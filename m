Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC97DC94
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfHANcn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 09:32:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbfHANcn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Aug 2019 09:32:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1C28A3B4E
        for <linux-nfs@vger.kernel.org>; Thu,  1 Aug 2019 13:32:43 +0000 (UTC)
Received: from jumitche.remote.csb (unknown [10.33.36.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D6A45D6B2;
        Thu,  1 Aug 2019 13:32:42 +0000 (UTC)
Message-ID: <1564666361.8625.10.camel@redhat.com>
Subject: [PATCH] nfs-utils: Fix the error handling if the lseek fails
From:   Alice J Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>
Date:   Thu, 01 Aug 2019 14:32:41 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 01 Aug 2019 13:32:43 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The error case when lseek returns a negative value was not correctly handled,
and the error cleanup routine was potentially leaking memory also.

Signed-off-by: Alice J Mitchell <ajmitchell@redhat.com>
---
 support/nfs/conffile.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index b6400be..6ba8a35 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -500,7 +500,7 @@ conf_readfile(const char *path)
 
 	if ((stat (path, &sb) == 0) || (errno != ENOENT)) {
 		char *new_conf_addr = NULL;
-		size_t sz = sb.st_size;
+		off_t sz;
 		int fd = open (path, O_RDONLY, 0);
 
 		if (fd == -1) {
@@ -517,6 +517,11 @@ conf_readfile(const char *path)
 
 		/* only after we have the lock, check the file size ready to read it */
 		sz = lseek(fd, 0, SEEK_END);
+		if (sz < 0) {
+			xlog_warn("conf_readfile: unable to determine file size: %s",
+				  strerror(errno));
+			goto fail;
+		}
 		lseek(fd, 0, SEEK_SET);
 
 		new_conf_addr = malloc(sz+1);
@@ -2162,6 +2167,7 @@ conf_write(const char *filename, const char *section, const char *arg,
 	ret = 0;
 
 cleanup:
+	flush_outqueue(&inqueue, NULL);
 	flush_outqueue(&outqueue, NULL);
 
 	if (buff)
-- 
1.8.3.1

