Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 184B713195F
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgAFU1p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:45 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46456 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFU1o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:44 -0500
Received: by mail-yb1-f195.google.com with SMTP id k128so11631195ybc.13
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCS3ND5K0LSGjGrE+PmH6QLpz2D5+xDXwsHW2kduECw=;
        b=Y0EZdxAko6SewWSg+iqvf3INxGDYr/NnX5DtpVVMC04IhNwiWysiIHS43ihcDKD9Au
         ILTq8fXd/yiumNhyIpyzMNOu9DyS+zTIgEHfjeT6Rf6KmoCZ5bLZvK+eUsbc8hOHP9Vu
         IfYdQAiQVe/F5/Pg5GLyPqGahfPa1IElBUyHo6BxLfziqtOfbydf69oE/KVCNJAeNhNl
         9TbTTWQazbGn1B68lzAo7R7efJJgU6amVWzcVYcr8dFodKSu7s+mAz7aJPW7pUAFuibn
         WVxgt5IH//iZACTr3V9UAOFK3Hi6ZdNEhbKZRQgj73mlXAMWAyKELQUxLESxyAnXaW3w
         CZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCS3ND5K0LSGjGrE+PmH6QLpz2D5+xDXwsHW2kduECw=;
        b=rovrrR1FIU1WBCVpzU5Op9vete1p9+4KwVrS8wMz6Vc3y55unHZh34UkUi96m+6bEX
         XdOee7GiR2py95/bM9BVSfTeKy5MkTh0MuMi7WLwaZeNVylQ/+U+MdaHRouTzsULDiR6
         H67sLVS6qZonbp1bwjA2MbMPXaUvZmZpKqZXF54pOOm9IhMrWX048vb3nFuIFuio4jQ0
         afRY1LVbEwwKo872/1lBxQvOKCz/0N2QF+3sHqbws8Q2S/8d+Xmgng82UgSzcd2PmZDH
         3wGEigfumq09Jr//NYhpWWwRft+LkWaKZyaNphvQWRKSO57/3tZgiWiXeYIuwmpDVzxi
         o2TA==
X-Gm-Message-State: APjAAAWpK5S9O4LdPEiA8Pu2Pr+VJpWcNOHIOpCA9sZAqOnXD0sQkdK3
        5yoL0zH2lO3S21YRui6Mj+oIl/bPaQ==
X-Google-Smtp-Source: APXvYqyQuffDkcmfqj5BObfvxe3qfo+Ig0QbFhrslt+4ZzmyOnI5FK8G9YMRT8XOtLuWWuKcKd25zg==
X-Received: by 2002:a5b:409:: with SMTP id m9mr25179991ybp.423.1578342463570;
        Mon, 06 Jan 2020 12:27:43 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:43 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 14/15] NFS: When resending after a short write, reset the reply count to zero
Date:   Mon,  6 Jan 2020 15:25:13 -0500
Message-Id: <20200106202514.785483-15-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-14-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
 <20200106202514.785483-5-trond.myklebust@hammerspace.com>
 <20200106202514.785483-6-trond.myklebust@hammerspace.com>
 <20200106202514.785483-7-trond.myklebust@hammerspace.com>
 <20200106202514.785483-8-trond.myklebust@hammerspace.com>
 <20200106202514.785483-9-trond.myklebust@hammerspace.com>
 <20200106202514.785483-10-trond.myklebust@hammerspace.com>
 <20200106202514.785483-11-trond.myklebust@hammerspace.com>
 <20200106202514.785483-12-trond.myklebust@hammerspace.com>
 <20200106202514.785483-13-trond.myklebust@hammerspace.com>
 <20200106202514.785483-14-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we're resending a write due to a short read or write, ensure we
reset the reply count to zero.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/read.c  | 2 ++
 fs/nfs/write.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 12deb3bdb2a0..34bb9add2302 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -281,6 +281,8 @@ static void nfs_readpage_retry(struct rpc_task *task,
 	argp->offset += resp->count;
 	argp->pgbase += resp->count;
 	argp->count -= resp->count;
+	resp->count = 0;
+	resp->eof = 0;
 	rpc_restart_call_prepare(task);
 }
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 985ddff46051..2c2020546e24 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1656,6 +1656,8 @@ static void nfs_writeback_result(struct rpc_task *task,
 			 */
 			argp->stable = NFS_FILE_SYNC;
 		}
+		resp->count = 0;
+		resp->verf->committed = 0;
 		rpc_restart_call_prepare(task);
 	}
 }
-- 
2.24.1

