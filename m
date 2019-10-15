Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89550D7654
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2019 14:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfJOMUA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 08:20:00 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45599 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfJOMUA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Oct 2019 08:20:00 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKLnu-0001Lj-2W; Tue, 15 Oct 2019 13:19:54 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKLnt-0003tA-L7; Tue, 15 Oct 2019 13:19:53 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSv4: add declaration of current_stateid
Date:   Tue, 15 Oct 2019 13:19:53 +0100
Message-Id: <20191015121953.14905-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The current_stateid is exported from nfs4state.c but not
declared in any of the headers. Add to nfs4_fs.h to
remove the following warning:

fs/nfs/nfs4state.c:80:20: warning: symbol 'current_stateid' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/nfs/nfs4_fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 16b2e5cc3e94..330f45268060 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -445,6 +445,8 @@ extern void nfs4_set_lease_period(struct nfs_client *clp,
 
 
 /* nfs4state.c */
+extern const nfs4_stateid current_stateid;
+
 const struct cred *nfs4_get_clid_cred(struct nfs_client *clp);
 const struct cred *nfs4_get_machine_cred(struct nfs_client *clp);
 const struct cred *nfs4_get_renew_cred(struct nfs_client *clp);
-- 
2.23.0

