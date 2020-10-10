Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7928728A1AE
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Oct 2020 00:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbgJJWHL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Oct 2020 18:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732152AbgJJTk3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Oct 2020 15:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602358828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v7pyKuarLLRaj5zrWRImz6ki1MxllWFtClNsCnkPpu4=;
        b=gquTklY7CoRDvmhx149hBuVsnVd6dHB/NWmpV0mTq7CkLMhIvCGpZTe7AwZfyLrQweRbwh
        MFnXQUguHrB67GbY/83SGkrni6Wxl6lc4cIQr4ILWw4F0aeGOF7Xg5alM1tXxyt+Qrb4/p
        igeYNveYAUOzZSpcIc4RbfryjUOiw6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-4DOrGxCTNKWtjt13WpJ6Sg-1; Sat, 10 Oct 2020 10:03:15 -0400
X-MC-Unique: 4DOrGxCTNKWtjt13WpJ6Sg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19B6D1868403;
        Sat, 10 Oct 2020 14:03:14 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-116-12.rdu2.redhat.com [10.10.116.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEA455C1BB;
        Sat, 10 Oct 2020 14:03:13 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id C37A31A003C; Sat, 10 Oct 2020 10:03:12 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: add missing "posix" local_lock constant table definition
Date:   Sat, 10 Oct 2020 10:03:12 -0400
Message-Id: <20201010140312.136745-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

"mount -o local_lock=posix..." was broken by the mount API conversion
due to the missing constant.

Fixes: e38bb238ed8c ("NFS: Convert mount option parsing to use functionality from fs_parser.h")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/fs_context.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 524812984e2d..009987e69020 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -94,6 +94,7 @@ enum {
 static const struct constant_table nfs_param_enums_local_lock[] = {
 	{ "all",		Opt_local_lock_all },
 	{ "flock",	Opt_local_lock_flock },
+	{ "posix",	Opt_local_lock_posix },
 	{ "none",		Opt_local_lock_none },
 	{}
 };
-- 
2.26.2

