Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876FB18470B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 13:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCMMkF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 08:40:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:35760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMMkF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Mar 2020 08:40:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DFF31AD78;
        Fri, 13 Mar 2020 12:40:03 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/1] nfsd: remove read permission bit for ctl sysctl
Date:   Fri, 13 Mar 2020 13:39:57 +0100
Message-Id: <20200313123957.6122-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It's meant to be read only.

Fixes: 89c905beccbb ("nfsd: allow forced expiration of NFSv4 clients")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

does not really fix anything, it's just confusing to have read
permission bit when not used.

Kind regards,
Petr

 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 65cfe9ab47be..475ece438cfc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2636,7 +2636,7 @@ static const struct file_operations client_ctl_fops = {
 static const struct tree_descr client_files[] = {
 	[0] = {"info", &client_info_fops, S_IRUSR},
 	[1] = {"states", &client_states_fops, S_IRUSR},
-	[2] = {"ctl", &client_ctl_fops, S_IRUSR|S_IWUSR},
+	[2] = {"ctl", &client_ctl_fops, S_IWUSR},
 	[3] = {""},
 };
 
-- 
2.16.4

