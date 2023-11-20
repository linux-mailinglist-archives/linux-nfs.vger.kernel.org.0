Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6127F1AB5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 18:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjKTRib (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 12:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjKTRiI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 12:38:08 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB82E185;
        Mon, 20 Nov 2023 09:37:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SYvWP3rr3z9y0NT;
        Tue, 21 Nov 2023 01:24:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAHuGEqmVtlz4kHAQ--.4148S4;
        Mon, 20 Nov 2023 18:37:25 +0100 (CET)
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
Subject: [PATCH v6 12/25] security: Introduce file_post_open hook
Date:   Mon, 20 Nov 2023 18:33:05 +0100
Message-Id: <20231120173318.1132868-13-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAHuGEqmVtlz4kHAQ--.4148S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4rWFWkJrW5WFyfCrW3ZFb_yoWrZF48pF
        ZYy3WUGrW8GFy7Wrn7Aanrua4ag39agrWUWrZ5W3s0yFn2qrnYgFs0yr1Ykr15JrZ5JFyI
        q3W2grW3Cr1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
        v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07jx
        DGOUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5apegABs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation to move IMA and EVM to the LSM infrastructure, introduce the
file_post_open hook. Also, export security_file_post_open() for NFS.

Based on policy, IMA calculates the digest of the file content and
extends the TPM with the digest, verifies the file's integrity based on
the digest, and/or includes the file digest in the audit log.

LSMs could similarly take action depending on the file content and the
access mask requested with open().

The new hook returns a value and can cause the open to be aborted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/namei.c                    |  2 ++
 fs/nfsd/vfs.c                 |  6 ++++++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 17 +++++++++++++++++
 5 files changed, 32 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..fb93d3e13df6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3620,6 +3620,8 @@ static int do_open(struct nameidata *nd,
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
+	if (!error)
+		error = security_file_post_open(file, op->acc_mode);
 	if (!error)
 		error = ima_file_check(file, op->acc_mode);
 	if (!error && do_truncate)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fbbea7498f02..b0c3f07a8bba 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -877,6 +877,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		goto out;
 	}
 
+	host_err = security_file_post_open(file, may_flags);
+	if (host_err) {
+		fput(file);
+		goto out;
+	}
+
 	host_err = ima_file_check(file, may_flags);
 	if (host_err) {
 		fput(file);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index c3199bb69103..e2b45fee94e2 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -189,6 +189,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
 	 struct fown_struct *fown, int sig)
 LSM_HOOK(int, 0, file_receive, struct file *file)
 LSM_HOOK(int, 0, file_open, struct file *file)
+LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
 LSM_HOOK(int, 0, file_truncate, struct file *file)
 LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
 	 unsigned long clone_flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index 922ea7709bae..c360458920b1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -409,6 +409,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
 int security_file_open(struct file *file);
+int security_file_post_open(struct file *file, int mask);
 int security_file_truncate(struct file *file);
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
 void security_task_free(struct task_struct *task);
@@ -1065,6 +1066,11 @@ static inline int security_file_open(struct file *file)
 	return 0;
 }
 
+static inline int security_file_post_open(struct file *file, int mask)
+{
+	return 0;
+}
+
 static inline int security_file_truncate(struct file *file)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 8aa6e9f316dd..fe6a160afc35 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2954,6 +2954,23 @@ int security_file_open(struct file *file)
 	return fsnotify_perm(file, MAY_OPEN);
 }
 
+/**
+ * security_file_post_open() - Evaluate a file after it has been opened
+ * @file: the file
+ * @mask: access mask
+ *
+ * Evaluate an opened file and the access mask requested with open(). The hook
+ * is useful for LSMs that require the file content to be available in order to
+ * make decisions.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_file_post_open(struct file *file, int mask)
+{
+	return call_int_hook(file_post_open, 0, file, mask);
+}
+EXPORT_SYMBOL_GPL(security_file_post_open);
+
 /**
  * security_file_truncate() - Check if truncating a file is allowed
  * @file: file
-- 
2.34.1

