Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1DF192177
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 08:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgCYHAG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 03:00:06 -0400
Received: from mail1.windriver.com ([147.11.146.13]:55376 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgCYHAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 03:00:03 -0400
X-Greylist: delayed 11358 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 03:00:00 EDT
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 02P3oXp9021731
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 24 Mar 2020 20:50:33 -0700 (PDT)
Received: from pek-lpggp3.wrs.com (128.224.153.76) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Mar 2020
 20:50:15 -0700
From:   Song liwei <liwei.song@windriver.com>
To:     Trond <trond.myklebust@hammerspace.com>,
        Anna <anna.schumaker@netapp.com>
CC:     Olga <olga.kornievskaia@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LiweiSong <liwei.song@windriver.com>
Subject: [PATCH] nfsroot: set tcp as the defalut transport protocol
Date:   Wed, 25 Mar 2020 11:50:13 +0800
Message-ID: <20200325035013.26697-1-liwei.song@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Liwei Song <liwei.song@windriver.com>

UDP is disabled by default in commit b24ee6c64ca7 ("NFS: allow
deprecation of NFS UDP protocol"), but the default mount options
is still udp, change it to tcp to avoid the "Unsupported transport
protocol udp" error if no protocol is specified when mount nfs.

Fixes: b24ee6c64ca7 ("NFS: allow deprecation of NFS UDP protocol")
Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 fs/nfs/nfsroot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index effaa4247b91..8d3278805602 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -88,7 +88,7 @@
 #define NFS_ROOT		"/tftpboot/%s"
 
 /* Default NFSROOT mount options. */
-#define NFS_DEF_OPTIONS		"vers=2,udp,rsize=4096,wsize=4096"
+#define NFS_DEF_OPTIONS		"vers=2,tcp,rsize=4096,wsize=4096"
 
 /* Parameters passed from the kernel command line */
 static char nfs_root_parms[NFS_MAXPATHLEN + 1] __initdata = "";
-- 
2.17.1

