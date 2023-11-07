Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4190E7E403A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Nov 2023 14:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjKGNlw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Nov 2023 08:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjKGNlv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Nov 2023 08:41:51 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22A2B0;
        Tue,  7 Nov 2023 05:41:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SPpqv0sL9z9y5D8;
        Tue,  7 Nov 2023 21:25:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDHdmBmPkplW202AA--.56782S3;
        Tue, 07 Nov 2023 14:41:21 +0100 (CET)
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
Subject: [PATCH v5 01/23] ima: Align ima_inode_post_setattr() definition with LSM infrastructure
Date:   Tue,  7 Nov 2023 14:39:50 +0100
Message-Id: <20231107134012.682009-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDHdmBmPkplW202AA--.56782S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45Zw48Zw4xCry5ur1DAwb_yoW5Xw1xpa
        95G3WDG34ruFW8Wr95Aa17A3yF9FyUWFy7W3yFg3yIyFnxtr12qFn3Kry3Cry5CrW8Kr90
        qF1jgrs8Cw1ayrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1cdbUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5YbcAAAsH
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Change ima_inode_post_setattr() definition, so that it can be registered as
implementation of the inode_post_setattr hook (to be introduced).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/attr.c                             | 2 +-
 include/linux/ima.h                   | 4 ++--
 security/integrity/ima/ima_appraise.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index bdf5deb06ea9..9bddc0a6352c 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -502,7 +502,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
-		ima_inode_post_setattr(idmap, dentry);
+		ima_inode_post_setattr(idmap, dentry, ia_valid);
 		evm_inode_post_setattr(dentry, ia_valid);
 	}
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 86b57757c7b1..910a2f11a906 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -186,7 +186,7 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
-				   struct dentry *dentry);
+				   struct dentry *dentry, int ia_valid);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
 extern int ima_inode_set_acl(struct mnt_idmap *idmap,
@@ -206,7 +206,7 @@ static inline bool is_ima_appraise_enabled(void)
 }
 
 static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
-					  struct dentry *dentry)
+					  struct dentry *dentry, int ia_valid)
 {
 	return;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 870dde67707b..36c2938a5c69 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -629,6 +629,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
  * ima_inode_post_setattr - reflect file metadata changes
  * @idmap:  idmap of the mount the inode was found from
  * @dentry: pointer to the affected dentry
+ * @ia_valid: for the UID and GID status
  *
  * Changes to a dentry's metadata might result in needing to appraise.
  *
@@ -636,7 +637,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
  * to lock the inode's i_mutex.
  */
 void ima_inode_post_setattr(struct mnt_idmap *idmap,
-			    struct dentry *dentry)
+			    struct dentry *dentry, int ia_valid)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct integrity_iint_cache *iint;
-- 
2.34.1

