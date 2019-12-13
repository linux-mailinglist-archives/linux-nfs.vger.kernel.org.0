Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3711EC53
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 21:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLMU5b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 15:57:31 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:33731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMU5b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 15:57:31 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MCbZL-1iWCwj47Xf-009dzd; Fri, 13 Dec 2019 21:57:15 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 18/24] nfs: fscache: use timespec64 in inode auxdata
Date:   Fri, 13 Dec 2019 21:53:46 +0100
Message-Id: <20191213205417.3871055-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eSpA+PeGzcN5/q+tSCYMNqYwum00xsr3wrwDajwhj/LcbNxeqj3
 xpZEUffRgySY5dIEMfYLZyJqNTCruiE0MMz9YpW+jOORPjSIStKzr+8z+H6mQz25URpuODB
 e223MW7cvFYZ6dCuCXKvbkvrQb1nYpoztuLlysTOh0wDCnrfnvi2ilsZvdfcRnKOXXny7wU
 mDag+0g9ojpjFZcDv7n6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yxdt9MqnWt4=:OBts36wUuwCQus2XQkhzGl
 pKenNFFAD2FTUrYDyhA0zUblisj/ayGPpSpIezzv4UghyEyenxubcoF0Y3RWMPxVm9ySafB4x
 vLpZl2UwLbcB0u7S/rlBsatGDaEfLaHuA7bDb3u423+pcTA5dNV489y+mISiNaQk6HxstKYdG
 VlN+/20BwC7KlJJnK2esD7qWzG//1shkBYOfcUAgvkRcaTUnHZIDK56Kqh0YzZLkGE/A3p98/
 mK4QWPy4in+qxK0hMjPw10Jo0doBm9saNK8iWLVlEGURKFkfRRY+Oz55hEfEpv/pi1Pey71zZ
 e3D1hYzUbTM2TO3i99t586jcPyPnbdarRFopA++nL3W3wfuSSal+pPUoToKJR3Bj0s2GrjmCF
 yA48A/vJhhaqUdPnCKaeJrbo/Zy7ZyJb+x9kvA29zpWzr2Zm6qX71hjujr73DjD0Y1BtzUF3P
 FvfSAr1TfJj19qQFr2SJ6UTPapu8emgETmyNB7ryIecNwXa+zaWaBUoCB9XUrRXGPYnQC3gnw
 B7204zKLOcSD1ByV/Y9xXZwsXYGWPdupyrbr9UVcTRy9c3YrwXJOtF9dAizbBAjslO+p3HMfu
 kymi02S/6REd3ikGqh6oF15QgH01KDrb1/yCBAovM4WMXHh/a1jBS1vDr4bKzd7oS0IV+fkBJ
 MH0vtZdstx/2/Syy+IVtpy1+n2En+Yk8upOzPQQIil5SVafifFqbP9uGh1hEiQZhAy3MKu9df
 lSPWgHbQ80g8idvOlDQXWx9TL8R0Mp8HUAqxudJRd7p9VXbEw9aeZXtZfx6myuY8ZYLryhhne
 spgQXL7f0P/FfsWb7otpMXRbNmt0e9zc5KvAsS10NNdkM+6CEhQvuZWu9JxZFEpDGD4lfigiW
 s8q1TGli8fGxZvftiCZw==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs currently behaves differently on 32-bit and 64-bit kernels regarding
the on-disk format of nfs_fscache_inode_auxdata.

That format should really be the same on any kernel, and we should avoid
the 'timespec' type in order to remove that from the kernel later on.

Using plain 'timespec64' would not be good here, since that includes
implied padding and would possibly leak kernel stack data to the on-disk
format on 32-bit architectures.

struct __kernel_timespec would work as a replacement, but open-coding
the two struct members in nfs_fscache_inode_auxdata makes it more
obvious what's going on here, and keeps the current format for 64-bit
architectures.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfs/fscache-index.c |  6 ++++--
 fs/nfs/fscache.c       | 18 ++++++++++++------
 fs/nfs/fscache.h       |  8 +++++---
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
index 15f271401dcc..573b1da9342c 100644
--- a/fs/nfs/fscache-index.c
+++ b/fs/nfs/fscache-index.c
@@ -84,8 +84,10 @@ enum fscache_checkaux nfs_fscache_inode_check_aux(void *cookie_netfs_data,
 		return FSCACHE_CHECKAUX_OBSOLETE;
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
-	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
+	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
 
 	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
 		auxdata.change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 3800ab6f08fa..7def925d3af5 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -238,8 +238,10 @@ void nfs_fscache_init_inode(struct inode *inode)
 		return;
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
-	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
+	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
 
 	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
 		auxdata.change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
@@ -263,8 +265,10 @@ void nfs_fscache_clear_inode(struct inode *inode)
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
-	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
+	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
 	fscache_relinquish_cookie(cookie, &auxdata, false);
 	nfsi->fscache = NULL;
 }
@@ -305,8 +309,10 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 		return;
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
-	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
+	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
 
 	if (inode_is_open_for_write(inode)) {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index ad041cfbf9ec..6754c8607230 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -62,9 +62,11 @@ struct nfs_fscache_key {
  * cache object.
  */
 struct nfs_fscache_inode_auxdata {
-	struct timespec	mtime;
-	struct timespec	ctime;
-	u64		change_attr;
+	s64	mtime_sec;
+	s64	mtime_nsec;
+	s64	ctime_sec;
+	s64	ctime_nsec;
+	u64	change_attr;
 };
 
 /*
-- 
2.20.0

