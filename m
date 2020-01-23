Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1D814608A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 02:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAWBpt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 20:45:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35842 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWBpt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 20:45:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N1gwx0122681;
        Thu, 23 Jan 2020 01:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=/nezUOM6YzB9RZ8fZQbuDG+lEkhhFVDIxYy6fgGWYKU=;
 b=OY84nF9ffuv7P05TSIDkfOKz7PQS1IdVl0KIbm/+L3pvgu3M5Bpa8//f+d1D/yOwBq5z
 glOR3zqautBPUs9Z0CrpOXRgzBltoaKfDTc6C0qirm+OeRVbYL46t3lM4rIeRCKr9yRZ
 3TAA92Fj2gVd3PrW5FydsAhAs+6+zRudVgQoUTlpI5N/vQvJyPrSnG/E9fDu2a77JW3o
 IXfID4dlNPVMMzNBBt3vxhqnHBSr6bdI/tMF28HNfgKhP9pfs5LDiLyAvnz3HGYL0Q5t
 6JZZp+QVrYuRasVoZPPCYOW0ynkmOXj5DkEgLnPwAjT9nEA7cHtMKUtCrKhKlrjuDxw6 GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xkseuqhkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 01:45:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N1iC16160753;
        Thu, 23 Jan 2020 01:45:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2xpt6n4pbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jan 2020 01:45:42 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id 00N1jgVu164128;
        Thu, 23 Jan 2020 01:45:42 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 2xpt6n4pas-1;
        Thu, 23 Jan 2020 01:45:42 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfs: optimise readdir cache page invalidation
Date:   Wed, 22 Jan 2020 20:45:39 -0500
Message-Id: <20200123014539.13991-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230012
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When the directory is large and it's being modified by one client
while another client is doing the 'ls -l' on the same directory then
the cache page invalidation from nfs_force_use_readdirplus causes
the reading client to keep restarting READDIRPLUS from cookie 0
which causes the 'ls -l' to take a very long time to complete,
possibly never completing.

Currently when nfs_force_use_readdirplus is called to switch from
READDIR to READDIRPLUS, it invalidates all the cached pages of the
directory. This cache page invalidation causes the next nfs_readdir
to re-read the directory content from cookie 0.

This patch is to optimise the cache invalidation in
nfs_force_use_readdirplus by only truncating the cached pages from
last page index accessed to the end the file. It also marks the
inode to delay invalidating all the cached page of the directory
until the next initial nfs_readdir of the next 'ls' instance.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

---
 fs/nfs/dir.c           | 13 ++++++++++++-
 include/linux/nfs_fs.h |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e180033e35cf..16e3208c27d6 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -437,7 +437,9 @@ void nfs_force_use_readdirplus(struct inode *dir)
 	if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
 	    !list_empty(&nfsi->open_files)) {
 		set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
-		invalidate_mapping_pages(dir->i_mapping, 0, -1);
+		nfs_zap_mapping(dir, dir->i_mapping);
+		invalidate_mapping_pages(dir->i_mapping,
+			nfsi->page_index + 1, -1);
 	}
 }
 
@@ -709,6 +711,9 @@ struct page *get_cache_page(nfs_readdir_descriptor_t *desc)
 int find_cache_page(nfs_readdir_descriptor_t *desc)
 {
 	int res;
+	struct inode *inode;
+	struct nfs_inode *nfsi;
+	struct dentry *dentry;
 
 	desc->page = get_cache_page(desc);
 	if (IS_ERR(desc->page))
@@ -717,6 +722,12 @@ int find_cache_page(nfs_readdir_descriptor_t *desc)
 	res = nfs_readdir_search_array(desc);
 	if (res != 0)
 		cache_page_release(desc);
+
+	dentry = file_dentry(desc->file);
+	inode = d_inode(dentry);
+	nfsi = NFS_I(inode);
+	nfsi->page_index = desc->page_index;
+
 	return res;
 }
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index c06b1fd130f3..a5f8f03ecd59 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -168,6 +168,9 @@ struct nfs_inode {
 	struct rw_semaphore	rmdir_sem;
 	struct mutex		commit_mutex;
 
+	/* track last access to cached pages */
+	unsigned long		page_index;
+
 #if IS_ENABLED(CONFIG_NFS_V4)
 	struct nfs4_cached_acl	*nfs4_acl;
         /* NFSv4 state */
-- 
1.8.3.1

