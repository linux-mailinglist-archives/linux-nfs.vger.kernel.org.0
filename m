Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429F87D9700
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 13:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbjJ0LyG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 07:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345796AbjJ0LyF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 07:54:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DDBD42;
        Fri, 27 Oct 2023 04:54:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154DAC433C7;
        Fri, 27 Oct 2023 11:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698407639;
        bh=k4x72pmAcWKhsOblkOnlJl9L/LWgQgRP/V4dCm8Nkrc=;
        h=From:Date:Subject:To:Cc:From;
        b=rolCSq+iclKaEE3lupsjzkTrb37Zo+BMucUj/kJPray2Z9RvVeWn3KAEhYflqhMWH
         LCzvVjaoqANtzHcr6Qs34Ce81o0pwO709/kiDjHLvtzUkiEzL+ogcT/1E2nA6QPilb
         AjOWmlMm7UqLUJOlYHsgOZkfyYe/ELCARuYjQl78dCRGq8UpxmfBX9NMQNqgFZWzhq
         9FfkcIKv9rdIknsGP+51oy5TiejBA1+SDiaXzwaOz40KOmsmTRuIKsSwmFGUBC76oC
         vsgsPVJ/R8yj5e9egQ+IdZqcjxgznHzaaCoOTR7Fd8w0OOq4aJNA12vLqEDjA5ABvi
         XbmQCzCLEocxg==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 27 Oct 2023 07:53:44 -0400
Subject: [PATCH] nfsd: ensure the nfsd_serv pointer is cleared when svc is
 torn down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-kdevops-v1-1-73711c16186c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMekO2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyMz3eyU1LL8gmJd42RDixQjM4OkNPNkJaDqgqLUtMwKsEnRsbW1AL0
 hfIBZAAAA
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8113; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=k4x72pmAcWKhsOblkOnlJl9L/LWgQgRP/V4dCm8Nkrc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlO6TWDKFGt2aItV8vP6Yx2qiz9VGesPExuxg+r
 2sB8jL9VIuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTuk1gAKCRAADmhBGVaC
 FRCvD/9ngRuK24ArtunJq3pZ9svQ9qRXpZy1GQL8OI7pQE6zuLFW3LdbZlBY9zy18ZierVgMb1g
 XXBsyTLdGPmj0owywub25CFd6q86+ZR5133qOJaUS/z1Z+b43C2gTk/GCuQRkCjwV+Ds5l+MHAC
 wP63MIypkALaW0e4HjU42wRfIyfBey4VaT8A0tTj9UeuN+jFurpiVcbeHg15Ut7/hGO1TjYCvMp
 jP5HANnhdAjUZcHPBDJofmgpatTa+w9pH5eRUIbRFajSO/fw3432P3dVCGg2QtTZwl+/mXcffCy
 4QTwM3VYDCD+G3YT/Xw4elKIInGcBDsjgHLtHwNa1geFGoG+Q5c+hizjrzqNWT36sh698gum5LW
 xN7UvuBm6ZBVJGn2DYoXotulQAAEyOSJ70wJB2evmR2kg7tZTJ953yK7XKLY2GM2hh1OTnOlIfb
 jSvv9khhMkbvusAojmAxlRkVcAyxP61qhSt3ihQVvsRs4e8Z0gnB4y97U3sgT/EMdPohzJGgBS7
 a04HEbIgy3ekTgAq3FSoEpmV/wSAMq7AS+9c2/aOJkAydbhoRNifxIRdyLvLNvgzw0VbH2ZcVjV
 U2nEqkzUu44LBE2jBsxzq26QM18kpZD+qz0Z9YznO/jaRWhrb5TokmoTfzUO12s8PIxfDjt67bt
 1ez2fu4oIauQ0mw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Zhi Li reported a refcount_t use-after-free when bringing up nfsd.

We set the nn->nfsd_serv pointer in nfsd_create_serv, but it's only ever
cleared in nfsd_last_thread. When setting up a new socket, if there is
an error, this can leave nfsd_serv pointer set after it has been freed.
We need to better couple the existence of the object with the value of
the nfsd_serv pointer.

Since we always increment and decrement the svc_serv references under
mutex, just test for whether the next put will destroy it in nfsd_put,
and clear the pointer beforehand if so. Add a new nfsd_get function for
better clarity and so that we can enforce that the mutex is held via
lockdep. Remove the clearing of the pointer from nfsd_last_thread.
Finally, change all of the svc_get and svc_put calls to use the updated
wrappers.

Reported-by: Zhi Li <yieli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
When using their test harness, the RHQA folks would sometimes see the
nfsv3 portmapper registration fail with -ERESTARTSYS, and that would
trigger this bug. I could never reproduce that easily on my own, but I
was able to validate this by hacking some fault injection into
svc_register.
---
 fs/nfsd/nfsctl.c |  4 ++--
 fs/nfsd/nfsd.h   |  8 ++-----
 fs/nfsd/nfssvc.c | 72 ++++++++++++++++++++++++++++++++++++--------------------
 3 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7ed02fb88a36..f8c0fed99c7f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -706,7 +706,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 
 	if (err >= 0 &&
 	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
+		nfsd_get(net);
 
 	nfsd_put(net);
 	return err;
@@ -745,7 +745,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		goto out_close;
 
 	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
+		nfsd_get(net);
 
 	nfsd_put(net);
 	return 0;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 11c14faa6c67..c9cb70bf2a6d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -96,12 +96,8 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-static inline void nfsd_put(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	svc_put(nn->nfsd_serv);
-}
+struct svc_serv	*nfsd_get(struct net *net);
+void		nfsd_put(struct net *net);
 
 bool		i_am_nfsd(void);
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c7af1095f6b5..4c00478c28dd 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -66,7 +66,7 @@ static __be32			nfsd_init_request(struct svc_rqst *,
  * ->sv_pools[].
  *
  * Each active thread holds a counted reference on nn->nfsd_serv, as does
- * the nn->keep_active flag and various transient calls to svc_get().
+ * the nn->keep_active flag and various transient calls to nfsd_get().
  *
  * Finally, the nfsd_mutex also protects some of the global variables that are
  * accessed when nfsd starts and that are settable via the write_* routines in
@@ -477,6 +477,39 @@ static void nfsd_shutdown_net(struct net *net)
 }
 
 static DEFINE_SPINLOCK(nfsd_notifier_lock);
+
+struct svc_serv *nfsd_get(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
+
+	lockdep_assert_held(&nfsd_mutex);
+	if (serv)
+		svc_get(serv);
+	return serv;
+}
+
+void nfsd_put(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
+
+	/*
+	 * The notifiers expect that if the nfsd_serv pointer is
+	 * set that it's safe to access, so we must clear that
+	 * pointer first before putting the last reference. Because
+	 * we always increment and decrement the refcount under the
+	 * mutex, it's safe to determine this via kref_read.
+	 */
+	lockdep_assert_held(&nfsd_mutex);
+	if (kref_read(&serv->sv_refcnt) == 1) {
+		spin_lock(&nfsd_notifier_lock);
+		nn->nfsd_serv = NULL;
+		spin_unlock(&nfsd_notifier_lock);
+	}
+	svc_put(serv);
+}
+
 static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
 	void *ptr)
 {
@@ -547,10 +580,6 @@ static void nfsd_last_thread(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
 
-	spin_lock(&nfsd_notifier_lock);
-	nn->nfsd_serv = NULL;
-	spin_unlock(&nfsd_notifier_lock);
-
 	/* check if the notifier still has clients */
 	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
 		unregister_inetaddr_notifier(&nfsd_inetaddr_notifier);
@@ -638,21 +667,19 @@ static int nfsd_get_default_max_blksize(void)
 
 void nfsd_shutdown_threads(struct net *net)
 {
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
 	mutex_lock(&nfsd_mutex);
-	serv = nn->nfsd_serv;
+	serv = nfsd_get(net);
 	if (serv == NULL) {
 		mutex_unlock(&nfsd_mutex);
 		return;
 	}
 
-	svc_get(serv);
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
 	nfsd_last_thread(net);
-	svc_put(serv);
+	nfsd_put(net);
 	mutex_unlock(&nfsd_mutex);
 }
 
@@ -663,15 +690,13 @@ bool i_am_nfsd(void)
 
 int nfsd_create_serv(struct net *net)
 {
-	int error;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
+	int error;
 
-	WARN_ON(!mutex_is_locked(&nfsd_mutex));
-	if (nn->nfsd_serv) {
-		svc_get(nn->nfsd_serv);
+	serv = nfsd_get(net);
+	if (serv)
 		return 0;
-	}
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
@@ -731,8 +756,6 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	int err = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	WARN_ON(!mutex_is_locked(&nfsd_mutex));
-
 	if (nn->nfsd_serv == NULL || n <= 0)
 		return 0;
 
@@ -766,7 +789,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 		nthreads[0] = 1;
 
 	/* apply the new numbers */
-	svc_get(nn->nfsd_serv);
+	nfsd_get(net);
 	for (i = 0; i < n; i++) {
 		err = svc_set_num_threads(nn->nfsd_serv,
 					  &nn->nfsd_serv->sv_pools[i],
@@ -774,7 +797,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 		if (err)
 			break;
 	}
-	svc_put(nn->nfsd_serv);
+	nfsd_put(net);
 	return err;
 }
 
@@ -826,8 +849,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 out_put:
 	/* Threads now hold service active */
 	if (xchg(&nn->keep_active, 0))
-		svc_put(serv);
-	svc_put(serv);
+		nfsd_put(net);
+	nfsd_put(net);
 out:
 	mutex_unlock(&nfsd_mutex);
 	return error;
@@ -1067,14 +1090,14 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 {
 	int ret;
+	struct net *net = inode->i_sb->s_fs_info;
 	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv == NULL) {
+	if (nfsd_get(net) == NULL) {
 		mutex_unlock(&nfsd_mutex);
 		return -ENODEV;
 	}
-	svc_get(nn->nfsd_serv);
 	ret = svc_pool_stats_open(nn->nfsd_serv, file);
 	mutex_unlock(&nfsd_mutex);
 	return ret;
@@ -1082,12 +1105,11 @@ int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 
 int nfsd_pool_stats_release(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq = file->private_data;
-	struct svc_serv *serv = seq->private;
+	struct net *net = inode->i_sb->s_fs_info;
 	int ret = seq_release(inode, file);
 
 	mutex_lock(&nfsd_mutex);
-	svc_put(serv);
+	nfsd_put(net);
 	mutex_unlock(&nfsd_mutex);
 	return ret;
 }

---
base-commit: 80eea12811ab8b32e3eac355adff695df5b4ba8e
change-id: 20231026-kdevops-3c18d260bf7c

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

