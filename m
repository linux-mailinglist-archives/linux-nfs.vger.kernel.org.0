Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95361797A40
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Sep 2023 19:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbjIGRe4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Sep 2023 13:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjIGRe4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Sep 2023 13:34:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF891BF9;
        Thu,  7 Sep 2023 10:34:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC6BC433B7;
        Thu,  7 Sep 2023 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694107966;
        bh=Z0Swf39gKfv9hkn4svgJVGt7mG0sIIo6aV9NfKM12M0=;
        h=From:Date:Subject:To:Cc:From;
        b=DpQAevNo6lqqIXAVbvhuYxlD2BrJh1tj7zOmWZYqG3R5EfZLFbpFnV0NRC9Yc0cPq
         6tZUofPY2ozJ/fyeu99WvEx2iroTyZ+TrN8KANU1kyUek9L6F7RdgPXslbIRRcQw+t
         keKlULESmHHjw+7Wm++65ZdBdvvgDgezMbFm0estLutrNUOaPF/1FrwKva2XhVMEp+
         Zhs86B+/OMWZZqWP1oG1AX3Box6OKfEdYJaWPUPJ7YQbU+p3jZYhKQ2iSOZeEwfmbD
         weUJv9vO4SQMOq5PlcEKo4NzFeLwT+uE5V4dDgkCNr47vumW80qsANw+wDXFTai/ZN
         koiEA09ernUtg==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 07 Sep 2023 13:32:36 -0400
Subject: [PATCH RFC] nfs4: add a get_acl stub handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-kdevops-v1-1-c2015c29d634@kernel.org>
X-B4-Tracking: v=1; b=H4sIADMJ+mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSwNz3eyU1LL8gmLdFGNDw1RT86Q00xQjJaDqgqLUtMwKsEnRSkFuzkq
 xtbUAcMRMoV4AAAA=
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z0Swf39gKfv9hkn4svgJVGt7mG0sIIo6aV9NfKM12M0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk+gk+lt5jrE3oHEkdSerBpcCE3DMSd54jCmYP1
 LCb2eYYkDqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPoJPgAKCRAADmhBGVaC
 FemdD/4mgJaNj6vxE9tju9fww0b7KCL0qrlIEIZqsnKgdkEJtlQ0JeZa4OtVox0aS8LULLbwiXI
 v/wCF6pEW8toEUtABR1yAUCV6jnnaJFG7++Y5APyJer1s/oOnjwu7F23HE7l06RyhzkT/m+fTey
 BdEkK3Sc3nfYIsmDhALK2EUeo/s+zcXRrZyKYyquSK/Q8cZhmAEvnNLDLVCFucg0R/AZA7WzZw3
 S6mXHgROPWMTFDh/xsg1O2j+L3VLm2a4rYgYPiNoVNAWfogk1uX0iEPlnXd2FoiQ/IYsIhkFzGR
 iMNZgU+NPFK2riGqNBCz6gA1RnJc550l0ugrBZo6qx/ZA6K0lfuRsntAcwBSE9tH7Pq8LVLaBe9
 UPM0G6hNzfVmrpwzV6yi1SwW5xdXFev5bNXA9ahJUog/MbIgzXb8YaBdhWENAXltJZUQ4Le9NSc
 Te0021OZrNIt6f4w45bfZ0u9C4/lXkT7ND1j/MvSN4TF01HGsq1Cg/OOEiCk/wnI6NWTO/2c5id
 3ebLmFtKUXQBiIoyiRsvl+yGB6vSB7pmk1HLpqKgFJpan+0rpHqkMXSjuaT1CBwj/ulxBExipOS
 GttlPS6/nZK9P7+cXjNOvgf+pMnyc8seEYlDebM4QuKl9Q5mvuCtI1/84a3nClesTkx5dktyn2W
 w2zhXe5+Xt9Irjg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In older kernels, attempting to fetch that system.posix_acl_access on
NFSv4 would return -EOPNOTSUPP, but in more recent kernels that returns
-ENODATA.

Most filesystems that don't support POSIX ACLs leave the SB_POSIXACL
flag clear, which cues the VFS to return -EOPNOTSUPP in this situation.
We can't do that with NFSv4 since that flag also cues the VFS to avoid
applying the umask early.

Fix this by adding a stub get_acl handler for NFSv4 that always returns
-EOPNOTSUPP.

Reported-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I suspect that this problem popped in due to some VFS layer changes. I
haven't identified the patch that broke it, but I think this is probably
the least invasive way to fix it.

Another alternative would be to return -EOPNOTSUPP on filesystems that
set SB_POSIXACL but that don't set get_acl or get_inode_acl.

Thoughts?
---
 fs/nfs/nfs4proc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 794343790ea8..93f3caf4ec08 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10621,6 +10621,12 @@ static void nfs4_disable_swap(struct inode *inode)
 	nfs4_schedule_state_manager(clp);
 }
 
+static struct posix_acl *nfs4_get_posix_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+					    int type)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static const struct inode_operations nfs4_dir_inode_operations = {
 	.create		= nfs_create,
 	.lookup		= nfs_lookup,
@@ -10636,6 +10642,7 @@ static const struct inode_operations nfs4_dir_inode_operations = {
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 	.listxattr	= nfs4_listxattr,
+	.get_acl	= nfs4_get_posix_acl,
 };
 
 static const struct inode_operations nfs4_file_inode_operations = {
@@ -10643,6 +10650,7 @@ static const struct inode_operations nfs4_file_inode_operations = {
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 	.listxattr	= nfs4_listxattr,
+	.get_acl	= nfs4_get_posix_acl,
 };
 
 const struct nfs_rpc_ops nfs_v4_clientops = {

---
base-commit: c0894ef10b846fd4a74a670cbec2483246030e06
change-id: 20230907-kdevops-d311e57bf5d2

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

