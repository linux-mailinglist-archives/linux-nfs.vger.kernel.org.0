Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D8068A70
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2019 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfGONZA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jul 2019 09:25:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36433 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbfGONY6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jul 2019 09:24:58 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so34072928iom.3
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2019 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdYU/O8CFhrdiPZEZj0Xlb3lnE3rS8rxH8pxRH42d50=;
        b=U+t7QLG6H8xyaybODmHIVt0382eD96YC69o+wgecnzb6ZzGfH6Qkf3NysCxyE/e9PU
         f3AjV9szERRESIY6gTh/UnbWlmqOsKi6CbTzpSpdXAdf6rEedZdbs9UrdFOc7UNBMVZo
         1P7UOgtFiXjv8olAe2XpgB5A1nPMZS6P+rr70Lacl0QtnJgfZyNLF+iKjwpzMRgaQqnv
         rW8sTEhc7vAfay4LyutBdFEwICVPDM+IfXZOOP4j56lYmRYDF1uVCnzVSKShlV1yrGnO
         Q7fLHk3gGyn0o2SSX6AmdbON1b0cgQ3MVySVpzAPZdKyQrB3mY1CVV1T4NS4IuNu5FHr
         raqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdYU/O8CFhrdiPZEZj0Xlb3lnE3rS8rxH8pxRH42d50=;
        b=HHtEsCA/dvvxGKAESTf1UAkmEeh989XX85OUEvR2IhKYi4MHH3Q2Ey2zLoqjS/gYE8
         ravp/0yuziuMA4DusYbT83apbeqcBEKgzm58Bud7+gWu63uXHWjBbIhVe5/4Pe+MLS4A
         nxyH5v///wczJ3x8BlQv25rd6uyox2tqMD4o/92aL8YI27/s4Uapf/IZlOiZn8fRAZ5H
         fhsY42T4kADAHEFW9GTv1ssjxtLwrRJbq/+UrBZbHmZD/S+3r4aTu77szvFyiaRYr8Zl
         jOjtjOZhvOT5HhOPHaHKe/9kK9kkHhbsQc2WOAPXRMl64o99PEJ5NlsMjZBMaUSOrBUt
         TUsg==
X-Gm-Message-State: APjAAAWOHHzjGA4nfovI6pfnI3mp0Qz9lHslGOHsg0Z0j3djRxVSeWmh
        YeqljfxqyOemQFT1+Z5mlOQljpo=
X-Google-Smtp-Source: APXvYqxlScRMXg9mVST/TUY3bqo3JBl06cE7atpiTsc666rBfVTfrrWxvYRPfzRpeddtTEg+fLpEzQ==
X-Received: by 2002:a05:6638:303:: with SMTP id w3mr15791693jap.103.1563197097173;
        Mon, 15 Jul 2019 06:24:57 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l5sm34354261ioq.83.2019.07.15.06.24.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 06:24:56 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Validate the stateid before applying it to state recovery
Date:   Mon, 15 Jul 2019 09:22:48 -0400
Message-Id: <20190715132248.28498-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the stateid is the zero or invalid stateid, then it is pointless
to attempt to use it for recovery. In that case, try to fall back
to using the open state stateid, or just doing a general recovery
of all state on a given inode.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 95e02a92e932..24b267e0c0d5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -462,6 +462,22 @@ static int nfs4_delay(long *timeout, bool interruptible)
 	return nfs4_delay_killable(timeout);
 }
 
+static const nfs4_stateid *
+nfs4_recoverable_stateid(const nfs4_stateid *stateid)
+{
+	if (!stateid)
+		return NULL;
+	switch (stateid->type) {
+	case NFS4_OPEN_STATEID_TYPE:
+	case NFS4_LOCK_STATEID_TYPE:
+	case NFS4_DELEGATION_STATEID_TYPE:
+		return stateid;
+	default:
+		break;
+	}
+	return NULL;
+}
+
 /* This is the error handling routine for processes that are allowed
  * to sleep.
  */
@@ -470,7 +486,7 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 {
 	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_state *state = exception->state;
-	const nfs4_stateid *stateid = exception->stateid;
+	const nfs4_stateid *stateid;
 	struct inode *inode = exception->inode;
 	int ret = errorcode;
 
@@ -478,8 +494,9 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 	exception->recovering = 0;
 	exception->retry = 0;
 
+	stateid = nfs4_recoverable_stateid(exception->stateid);
 	if (stateid == NULL && state != NULL)
-		stateid = &state->stateid;
+		stateid = nfs4_recoverable_stateid(&state->stateid);
 
 	switch(errorcode) {
 		case 0:
-- 
2.21.0

