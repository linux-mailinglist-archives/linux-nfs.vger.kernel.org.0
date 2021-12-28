Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D995480A5B
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Dec 2021 15:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhL1Oln (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Dec 2021 09:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbhL1Oln (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Dec 2021 09:41:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E81C06173F;
        Tue, 28 Dec 2021 06:41:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA1B16123F;
        Tue, 28 Dec 2021 14:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB26C36AEB;
        Tue, 28 Dec 2021 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640702502;
        bh=ibtw+293hOPMTtlYTNJVL2tSBX5rDRHmV6BWFQ3UsQs=;
        h=From:To:Cc:Subject:Date:From;
        b=dVhcTZ9sZQ4HjpPTtjboSe4x3uNuwPEZHxSDd9BcB3O3e1mAc4J6/zOT2M+2hunff
         /zTNJWQR3tCEGeR7cEN/bOcQtjrgFQbmb7u0UkE9h4O3wPYhPqPTJ66pB2VzoxHIGR
         PvI1EorvBfalnZteK0DinQP5gslkG2V/ZhQdOTZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: use default_groups in kobj_type
Date:   Tue, 28 Dec 2021 15:41:38 +0100
Message-Id: <20211228144138.389888-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; h=from:subject; bh=ibtw+293hOPMTtlYTNJVL2tSBX5rDRHmV6BWFQ3UsQs=; b=owGbwMvMwCRo6H6F97bub03G02pJDImnleT5rgvaaqb9S/+vFPfGtkCbs3rGjK0hb48v+5klUnDt jTx3RywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExEv5BhwXLtkwd3NCtdu5h8QvWEGv 96RWGZBQyz2VYvuu/VUPG/4tHPDw5NE1vfurZWAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the NFS code to use default_groups field which has been the
preferred way since aa30f47cf666 ("kobject: Add support for default
attribute groups to kobj_type") so that we can soon get rid of the
obsolete default_attrs field.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 8cb70755e3c9..a6f740366963 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -142,10 +142,11 @@ static struct attribute *nfs_netns_client_attrs[] = {
 	&nfs_netns_client_id.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(nfs_netns_client);
 
 static struct kobj_type nfs_netns_client_type = {
 	.release = nfs_netns_client_release,
-	.default_attrs = nfs_netns_client_attrs,
+	.default_groups = nfs_netns_client_groups,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.namespace = nfs_netns_client_namespace,
 };
-- 
2.34.1

