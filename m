Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC481AB262
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2020 22:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436830AbgDOUOx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Apr 2020 16:14:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34209 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2441994AbgDOUOx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Apr 2020 16:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586981691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=Efur/vY4xwn/kIgQfIM5xCo7lZEU9KQjeM4hi3ie3uA=;
        b=GsH7iYmJGpaGrcFvnICYBKq0rBZw+tvXmtTc/pBlTZaohLvirsIr1KdKppl+ZpD75tToCf
        HyBFeVWJm/Q+AqBxhqJjq+jBJ7UOYwbhw/YIRXDtk1GTYl1VUDQ9EK6QSbeXMx6+SmwIvU
        bAuioZQCNNtYUORfoVMAj1XGE3TZHgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-g6XCC-80O5STmKUegHqq7w-1; Wed, 15 Apr 2020 16:14:47 -0400
X-MC-Unique: g6XCC-80O5STmKUegHqq7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ABFA18FF661
        for <linux-nfs@vger.kernel.org>; Wed, 15 Apr 2020 20:14:46 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-216.rdu2.redhat.com [10.10.112.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9283A63D6;
        Wed, 15 Apr 2020 20:14:45 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     dhowells@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Fix fscache super_cookie allocation
Date:   Wed, 15 Apr 2020 16:14:42 -0400
Message-Id: <1586981683-3077-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1586981683-3077-1-git-send-email-dwysocha@redhat.com>
References: <1586981683-3077-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit f2aedb713c28 ("NFS: Add fs_context support.") reworked
NFS mount code paths for fs_context support which included
super_block initialization.  In the process there was an extra
return left in the code and so we never call
nfs_fscache_get_super_cookie even if 'fsc' is given on as mount
option.  In addition, there is an extra check inside
nfs_fscache_get_super_cookie for the NFS_OPTION_FSCACHE which
is unnecessary since the only caller nfs_get_cache_cookie
checks this flag.

Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 2 --
 fs/nfs/super.c   | 1 -
 2 files changed, 3 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 8eff1fd806b1..f51718415606 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -118,8 +118,6 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 
 	nfss->fscache_key = NULL;
 	nfss->fscache = NULL;
-	if (!(nfss->options & NFS_OPTION_FSCACHE))
-		return;
 	if (!uniq) {
 		uniq = "";
 		ulen = 1;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 59ef3b13ccca..cc34aa3a8ba4 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1189,7 +1189,6 @@ static void nfs_get_cache_cookie(struct super_block *sb,
 			uniq = ctx->fscache_uniq;
 			ulen = strlen(ctx->fscache_uniq);
 		}
-		return;
 	}
 
 	nfs_fscache_get_super_cookie(sb, uniq, ulen);
-- 
1.8.3.1

