Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3451500D0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 04:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgBCDsN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Feb 2020 22:48:13 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42673 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgBCDsN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Feb 2020 22:48:13 -0500
Received: by mail-yw1-f68.google.com with SMTP id b81so12418618ywe.9;
        Sun, 02 Feb 2020 19:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EDNDiSp9nE38dUK7CV4IKdLOvyiMIvgC3Y25Ged3MrI=;
        b=cAdGB1BmMN5dF9RpwuFWPYm8V3WgUMgc5TgcchJsw66BmXCoQoLCeLpUHh/Qo6/iAC
         rBTBwOKwjiHPTWbCL80wAH70siLp/qcD5p1b+VFHUlKbe9x3W5aicuXQLtwnqda6yYIl
         FdPUShkbkQHu218tDSVBxicCUIlh/qqkLSshefJKxoqIhBfZZJykHcnwNsmpoKKQfPJO
         bIsOqlTKaDyX/83dfqiK57X1fnAuQrzhTSsyAT5oX0aDWKcI4kN7ziACe2ZbdTcf1p10
         7QZ1UqOJRP/DId1U7w50AXHt2g/IyRus6iKocHtQZG37m7R+kEhVmiP/P3SXaFetL7tg
         qHhg==
X-Gm-Message-State: APjAAAWbeZJbXQvjbZd+ed4Jix836tcQR285EJQvDRL92uxZKc5Zx8/I
        j/BiPNue0/NGWDL/llARyp8=
X-Google-Smtp-Source: APXvYqxKRHzfpXdA0Xnd+3xuvzZMhwrsKhK7ZNEQmiOWjvZoYZtm+fGz9gUtVhYCfZ3h9s6eLYtdsQ==
X-Received: by 2002:a0d:d1c6:: with SMTP id t189mr16533075ywd.393.1580701691171;
        Sun, 02 Feb 2020 19:48:11 -0800 (PST)
Received: from localhost.localdomain (h198-137-20-41.xnet.uga.edu. [198.137.20.41])
        by smtp.gmail.com with ESMTPSA id m137sm8004823ywd.108.2020.02.02.19.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 19:48:10 -0800 (PST)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org (open list:NFS, SUNRPC, AND LOCKD CLIENTS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] NFS: Fix memory leaks
Date:   Mon,  3 Feb 2020 03:47:53 +0000
Message-Id: <20200203034753.20527-1-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In _nfs42_proc_copy(), 'res->commit_res.verf' is allocated through
kzalloc() if 'args->sync' is true. In the following code, if
'res->synchronous' is false, handle_async_copy() will be invoked. If an
error occurs during the invocation, the following code will not be executed
and the error will be returned . However, the allocated
'res->commit_res.verf' is not deallocated, leading to a memory leak. This
is also true if the invocation of process_copy_commit() returns an error.

To fix the above leaks, redirect the execution to the 'out' label if an
error is encountered.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/nfs/nfs42proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 1fe83e0f663e..231204720580 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -334,14 +334,14 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 		status = handle_async_copy(res, dst_server, src_server, src,
 				dst, &args->src_stateid, restart);
 		if (status)
-			return status;
+			goto out;
 	}
 
 	if ((!res->synchronous || !args->sync) &&
 			res->write_res.verifier.committed != NFS_FILE_SYNC) {
 		status = process_copy_commit(dst, pos_dst, res);
 		if (status)
-			return status;
+			goto out;
 	}
 
 	truncate_pagecache_range(dst_inode, pos_dst,
-- 
2.17.1

