Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077C71EAF91
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2020 21:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgFAT2D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Jun 2020 15:28:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726901AbgFAT2D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Jun 2020 15:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591039682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ijc4nKoPPBT3Esl9jB0cOkHqx/2EAdM0NeWK28GF3NU=;
        b=AXHEnu6wniGFg/Svp3NeBmoAa0DKVPSQ4d0panQpAfU96MJSYc1DdVRcKYwDtBS6BaZR/B
        +Js2HrwwR8SpRjaNdOB5zJePrc3k9ZflRUoEA0iiGdca5RX6xqFNQp72O3xpSktmXcqxms
        DOaY1FsVHa5ckVlPgbDZ+7H1o8mbWa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-6q9yz4f4NtmWWssQZvkJbw-1; Mon, 01 Jun 2020 15:28:00 -0400
X-MC-Unique: 6q9yz4f4NtmWWssQZvkJbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 966521800D42
        for <linux-nfs@vger.kernel.org>; Mon,  1 Jun 2020 19:27:59 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.74.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B7E7610F2;
        Mon,  1 Jun 2020 19:27:57 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@redhat.com
Subject: [PATCH] nfs4_setfacl: Add file name to error output.
Date:   Tue,  2 Jun 2020 00:57:54 +0530
Message-Id: <20200601192754.5413-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently when a user tries to set acl's recursively and if
the operation fails the user is not aware on which file the error
occured. This patch adds file name to error output.

Example:
nfs4_setfacl -R -s A:dfg:6:RWX /nfsmount
Failed setxattr operation: /nfsmount/test: Operation not permitted
An error occurred during recursive file tree walk.

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 libnfs4acl/nfs4_set_acl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libnfs4acl/nfs4_set_acl.c b/libnfs4acl/nfs4_set_acl.c
index 8a53f05..45e42fa 100644
--- a/libnfs4acl/nfs4_set_acl.c
+++ b/libnfs4acl/nfs4_set_acl.c
@@ -61,13 +61,13 @@ int nfs4_set_acl(struct nfs4_acl *acl, const char *path)
 		goto out_free;
 	} else if (res < 0) {
 		if (errno == EOPNOTSUPP)
-			fprintf(stderr,"Operation to set ACL not supported.\n");
+			fprintf(stderr,"Operation to set ACL not supported: %s\n", path);
 		else if (errno == ENODATA)
-			fprintf(stderr,"ACL Attribute not found on file.\n");
+			fprintf(stderr,"ACL Attribute not found on file: %s\n", path);
 		else if (errno == EREMOTEIO)
 			fprintf(stderr,"An NFS server error occurred.\n");
 		else
-			perror("Failed setxattr operation");
+			printf("Failed setxattr operation: %s: %s\n", path, strerror(errno));
 	}
 
 out_free:
-- 
2.21.1

