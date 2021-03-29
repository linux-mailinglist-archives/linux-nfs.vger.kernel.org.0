Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715F934CE4E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhC2Ky6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 06:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232732AbhC2Kyl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Mar 2021 06:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617015281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lyuNER0tnmAWlz8o0UjdsaE81EyYtAWD8vYhYdwCO4U=;
        b=blQI2w+4gflA5xMfgCxMHKkuqmpGlno2+Fg8ZWnK5CPulE7UF8JvJGKwExKm3MEDyszHoq
        Ok80yhM4kNUBgPrvsAGBm7HXbMYrIABTSU0MlVZy1Wm0POqi4ehzouG6RZOfdensre5nx2
        Nu0QlApYKI5E75ocx7/Sylk7TJApEuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-gCpNfFXbP6C81hy0Rmv0iQ-1; Mon, 29 Mar 2021 06:54:39 -0400
X-MC-Unique: gCpNfFXbP6C81hy0Rmv0iQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6A47501F8
        for <linux-nfs@vger.kernel.org>; Mon, 29 Mar 2021 10:54:38 +0000 (UTC)
Received: from idlethread.redhat.com (ovpn-113-30.ams2.redhat.com [10.36.113.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E35A619706;
        Mon, 29 Mar 2021 10:54:37 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] exportfs: make root unexportable
Date:   Mon, 29 Mar 2021 12:54:35 +0200
Message-Id: <20210329105435.17431-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If root of the filesystem is exported, it cannot be explicitly
unexported, since unexportfs_parsed, in order to deal with trailing
'/', will leave nlen at 0 for root exported case

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 utils/exportfs/exportfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 9fcae0b3..9b6f4f5a 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -372,7 +372,7 @@ unexportfs_parsed(char *hname, char *path, int verbose)
 	 * so need to deal with it.
 	*/
 	size_t nlen = strlen(path);
-	while (path[nlen - 1] == '/')
+	while ((path[nlen - 1] == '/') && (nlen > 1))
 		nlen--;
 
 	for (exp = exportlist[htype].p_head; exp; exp = exp->m_next) {
-- 
2.21.0

