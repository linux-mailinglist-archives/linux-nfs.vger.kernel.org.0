Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E427D91F6
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjJ0Ijk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 04:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjJ0Ijc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 04:39:32 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E32D5E;
        Fri, 27 Oct 2023 01:39:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SGwjZ47jxz9y4SR;
        Fri, 27 Oct 2023 16:26:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCX8JGqdjtlDvIBAw--.29710S10;
        Fri, 27 Oct 2023 09:38:52 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 08/23] evm: Align evm_inode_post_setxattr() definition with LSM infrastructure
Date:   Fri, 27 Oct 2023 10:35:43 +0200
Message-Id: <20231027083558.484911-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
References: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCX8JGqdjtlDvIBAw--.29710S10
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4rCrWDuF4fAFy8XF1xAFb_yoW5urWkpF
        Z8Ka4DCw1rJFyUWr9YyF48ua4v9ayrWryjy3yDKw1IyFnxtr92qrWxJr1j9ryrJr48GFnY
        qa1avrs5K3W3X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5GTmQAAsv
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Change evm_inode_post_setxattr() definition, so that it can be registered
as implementation of the inode_post_setxattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/evm.h               | 8 +++++---
 security/integrity/evm/evm_main.c | 4 +++-
 security/security.c               | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 7c6a74dbc093..437d4076a3b3 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -31,7 +31,8 @@ extern int evm_inode_setxattr(struct mnt_idmap *idmap,
 extern void evm_inode_post_setxattr(struct dentry *dentry,
 				    const char *xattr_name,
 				    const void *xattr_value,
-				    size_t xattr_value_len);
+				    size_t xattr_value_len,
+				    int flags);
 extern int evm_inode_removexattr(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
@@ -55,7 +56,7 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
 					  const char *acl_name,
 					  struct posix_acl *kacl)
 {
-	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
+	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
 }
 
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
@@ -114,7 +115,8 @@ static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
 static inline void evm_inode_post_setxattr(struct dentry *dentry,
 					   const char *xattr_name,
 					   const void *xattr_value,
-					   size_t xattr_value_len)
+					   size_t xattr_value_len,
+					   int flags)
 {
 	return;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 779ec35fb39f..2e8f6d1c9984 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -731,6 +731,7 @@ bool evm_revalidate_status(const char *xattr_name)
  * @xattr_name: pointer to the affected extended attribute name
  * @xattr_value: pointer to the new extended attribute value
  * @xattr_value_len: pointer to the new extended attribute value length
+ * @flags: flags to pass into filesystem operations
  *
  * Update the HMAC stored in 'security.evm' to reflect the change.
  *
@@ -739,7 +740,8 @@ bool evm_revalidate_status(const char *xattr_name)
  * i_mutex lock.
  */
 void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
-			     const void *xattr_value, size_t xattr_value_len)
+			     const void *xattr_value, size_t xattr_value_len,
+			     int flags)
 {
 	if (!evm_revalidate_status(xattr_name))
 		return;
diff --git a/security/security.c b/security/security.c
index f508101bf465..b2dd521a206d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2360,7 +2360,7 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return;
 	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
-	evm_inode_post_setxattr(dentry, name, value, size);
+	evm_inode_post_setxattr(dentry, name, value, size, flags);
 }
 
 /**
-- 
2.34.1

