Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA501312B2
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 14:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAFNRl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 08:17:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44831 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgAFNRl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 08:17:41 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ioSGE-0006Gv-IX; Mon, 06 Jan 2020 13:17:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Scott Mayhew <smayhew@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] NFS: Add missing null check for failed allocation
Date:   Mon,  6 Jan 2020 13:17:34 +0000
Message-Id: <20200106131734.51759-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the allocation of buf is not being null checked and
a null pointer dereference can occur when the memory allocation fails.
Fix this by adding a check and returning -ENOMEM.

Addresses-Coverity: ("Dereference null return")
Fixes: 6d972518b821 ("NFS: Add fs_context support.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/nfs/nfs4namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 10e9e1887841..de6875a9b391 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -137,6 +137,9 @@ static int nfs4_validate_fspath(struct dentry *dentry,
 	int n;
 
 	buf = kmalloc(4096, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	path = nfs4_path(dentry, buf, 4096);
 	if (IS_ERR(path)) {
 		kfree(buf);
-- 
2.24.0

