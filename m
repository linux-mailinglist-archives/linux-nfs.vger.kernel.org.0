Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB0C17AC0
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfEHNft (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbfEHNfs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2FAF2D7FB
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:48 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CF591724D
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:47 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 15/19] Removed a resource leak from mount/nfsmount.c
Date:   Wed,  8 May 2019 09:35:32 -0400
Message-Id: <20190508133536.6077-16-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 08 May 2019 13:35:48 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

mount/nfsmount.c:455: leaked_storage: Variable "mounthost" going
	out of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/nfsmount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/utils/mount/nfsmount.c b/utils/mount/nfsmount.c
index 952a755..3d95da9 100644
--- a/utils/mount/nfsmount.c
+++ b/utils/mount/nfsmount.c
@@ -452,6 +452,7 @@ parse_options(char *old_opts, struct nfs_mount_data *data,
 	nfs_error(_("%s: Bad nfs mount parameter: %s\n"), progname, opt);
  out_bad:
 	free(tmp_opts);
+	free(mounthost);
 	return 0;
 }
 
-- 
2.20.1

