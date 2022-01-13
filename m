Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58F548DE25
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jan 2022 20:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiAMTgK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 14:36:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230046AbiAMTgK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jan 2022 14:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642102569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xTM5H7Yr3n+FqYmH7naxAJYGN/Y/i8EUrbNvuS6lOrY=;
        b=AnxMYLMiadFn5dR4kYZkn4uLJI18uiq7+avLy7i0dAka6II3s5b7AVuJYWPOHH9piDnLRi
        jT4/SJFip5SeE6yr41lTeYsCm0pp6Ol2pNYwWmQR5j3XhaAIdSnX5D3sbWIfBH8eknwnMq
        k+LqaRf3XD+KK9BlaZFi6oSB3WxcW3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-o2byMmwpMoyqFdTWYK5TZQ-1; Thu, 13 Jan 2022 14:36:08 -0500
X-MC-Unique: o2byMmwpMoyqFdTWYK5TZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 116866415E;
        Thu, 13 Jan 2022 19:36:07 +0000 (UTC)
Received: from bearskin.sorenson.redhat.com (unknown [10.2.16.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ECFA60C9F;
        Thu, 13 Jan 2022 19:36:06 +0000 (UTC)
From:   Frank Sorenson <sorenson@redhat.com>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org, sorenson@redhat.com
Subject: [PATCH] libtirpc: Fix use-after-free accessing the error number
Date:   Thu, 13 Jan 2022 13:36:05 -0600
Message-Id: <20220113193605.3361579-1-sorenson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Free the cbuf after obtaining the error number.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 src/clnt_dg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/clnt_dg.c b/src/clnt_dg.c
index e1255de..b3d82e7 100644
--- a/src/clnt_dg.c
+++ b/src/clnt_dg.c
@@ -456,9 +456,9 @@ get_reply:
 		 cmsg = CMSG_NXTHDR (&msg, cmsg))
 	      if (cmsg->cmsg_level == SOL_IP && cmsg->cmsg_type == IP_RECVERR)
 		{
-		  mem_free(cbuf, (outlen + 256));
 		  e = (struct sock_extended_err *) CMSG_DATA(cmsg);
 		  cu->cu_error.re_errno = e->ee_errno;
+		  mem_free(cbuf, (outlen + 256));
 		  release_fd_lock(cu->cu_fd_lock, mask);
 		  return (cu->cu_error.re_status = RPC_CANTRECV);
 		}
-- 
2.31.1

