Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF02EC351
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jan 2021 19:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbhAFSlD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jan 2021 13:41:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbhAFSlD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jan 2021 13:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609958377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wGa6C62NULYcyHVVQc8PrGaCEFTX+WbQlaNUoEeUCG4=;
        b=Cog7ajqwEQuXl++28zRMBeXYoHh2PPQSzstjyoSwxBY4Y+nJ/F8nasFhUzyawXyeQZnHQW
        FnDrI+v534B7QQvPHkTWN2RUC47S52hV/+KJCIGi3DSH4IcJQBSXwYk7JW8krgvKOZrrO9
        c2btkbAW7yMs7W3CFq+9msOg4Sm9jCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-kjyBEE46OWe82YrIXOi5SQ-1; Wed, 06 Jan 2021 13:39:35 -0500
X-MC-Unique: kjyBEE46OWe82YrIXOi5SQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFD8A1005513
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jan 2021 18:39:34 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-139.phx2.redhat.com [10.3.113.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D7711000232
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jan 2021 18:39:34 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] mount: parse default values correctly
Date:   Wed,  6 Jan 2021 13:40:28 -0500
Message-Id: <20210106184028.150925-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 88c22f92 converted the configfile.c routines
to use the parse_opt interfaces which broke how
default values from nfsmount.conf are managed.

Default values can not be added to the mount string
handed to the kernel. They must be interpreted into
the correct mount options then passed to the kernel.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1912877

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/configfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
index 7934f4f..e865998 100644
--- a/utils/mount/configfile.c
+++ b/utils/mount/configfile.c
@@ -277,8 +277,10 @@ conf_parse_mntopts(char *section, char *arg, struct mount_options *options)
 		}
 		if (buf[0] == '\0')
 			continue;
+		if (default_value(buf))
+			continue;
+
 		po_append(options, buf);
-		default_value(buf);
 	}
 	conf_free_list(list);
 }
-- 
2.29.2

