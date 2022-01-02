Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E179482C67
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jan 2022 18:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiABRf7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Jan 2022 12:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiABRf7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Jan 2022 12:35:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBFAC061761
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 09:35:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9C58B80B4A
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 17:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320A1C36AE7;
        Sun,  2 Jan 2022 17:35:56 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@kernel.org
Subject: [PATCH 07/10] NFSD: Write verifier might go backwards
Date:   Sun,  2 Jan 2022 12:35:55 -0500
Message-Id:  <164114495506.7344.17920348319488852614.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
References:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=887; h=from:subject:message-id; bh=6TXqYgW49mmc1pVTQPpmQTt0CSdUjl86JQjHw3VFstU=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh0eJ7PCPH67lWMCOLiMng/26TaNr0J0pEoVnVouFW pufmttCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdHiewAKCRAzarMzb2Z/lwRFD/ wKWvHiCxNg+IEZFtbq9UmuqCwaGnhQEY7Hs+nb3bLHLf8/qCYLvpALeZbhc0IY+9SOgfl1RuzoHPD5 jrhqg8uH+1dn1Jt6NJhkc+/3m02M2c5e40wf+e8nN0/B/Eic4/P1Ohn79ANAF3vPjHFKU6j1t4sRdx Qj0Ecz75+QRH9YqWqrmBV+lfxMmjM40DrqnswseJBu2O7ZMhhDeAIpecUrNLAmdPQisLNtc8dJ+Pr1 m/KjJ9kM3tw3eVc7tjge8vL1RHB4uXCfnUrW9dWKrvCcVqZAnXy5VAey2lO8OjRMmaEzkNJXGvmZCk eEa5frUHbnTntX9LKI9bktmDvqWOFWfLa40ruxdUp0uHYrjircIMIPP6IsLOOPCWAevZgm6DDJ8F2z igwp7tY/M8PVhAqgcEAJ6KE7cFRP580so+xQFUl874rG9tEEZymf7Z8uav5UpV7FGxzJ7e1QO8MvrR acKQhPqgt+sk4deH2bZNcMsEHU5Wz2lXysRBnHUc8abQfcEc/Z/IRkxF5gfuRRGoXsLefB4JV1nYyR NtDjhzEy1gPGdwWvcBxUfcobhev7TDhjW48EC++M4OjzALF0nQFza/QC0izLCFkQz6z2zRQQpvOeuG mkemTaEXhnBfFfAZqO1ktW012z4vH64vR/IE5hhE4J1A6Bt//QP0Yvkoum+g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When vfs_iter_write() starts to fail because a file system is full,
a bunch of writes can fail at once with ENOSPC. These writes
repeatedly invoke nfsd_reset_boot_verifier() in quick succession.

Ensure that the time it grabs doesn't go backwards due to an ntp
adjustment going on at the same time.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 14c1ef6f8cc7..6eccf6700250 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -363,7 +363,7 @@ void nfsd_copy_boot_verifier(__be32 verf[2], struct nfsd_net *nn)
 
 static void nfsd_reset_boot_verifier_locked(struct nfsd_net *nn)
 {
-	ktime_get_real_ts64(&nn->nfssvc_boot);
+	ktime_get_raw_ts64(&nn->nfssvc_boot);
 }
 
 void nfsd_reset_boot_verifier(struct nfsd_net *nn)

