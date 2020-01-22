Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87392145F5B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 00:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVXt2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 18:49:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVXt2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 18:49:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00MNWwdd010249;
        Wed, 22 Jan 2020 23:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=3MAGijiyYGyDwKaQPbRI430780giyWmjPat7ynoJQy0=;
 b=CyzckRdjVoV4QyGfG6PlIQdQi5fgaq6T8MCFC9wJbOc6WVh6YCVji2dOlBTYz+/AOD0/
 B2KfaOYKsByVbKuulETnsKvs0D2EoP+k8z0DuWGOwUGqZbY5Gh1fcE2GMHGBPndj000d
 qGZFDHPkrOxD8E75glsTHZl/wufYTNKmeozhV0OBeB5zNSi9zi26MnxaNJqU8FSLlamr
 26CeZQ1KtADqnGAPkCK6QBwhSjLB62LtckGme7R0ypb0uzed3095aujM56BLDK7uNIAX
 B6rP0+Sgw9uaDwSgv42WApOOCi6tDqB0nh/uXu5bXM919kKqQV8N+zfxAbUFSP8zaB/7 gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xktnrex29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 23:49:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00MNn2BN169257;
        Wed, 22 Jan 2020 23:49:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 2xppq2j7cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jan 2020 23:49:19 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id 00MNnIwd170411;
        Wed, 22 Jan 2020 23:49:18 GMT
Received: from userp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 2xppq2j79r-1;
        Wed, 22 Jan 2020 23:49:18 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com,
        linux-nfs@vger.kernel.org
Subject: [PATCH RFC] nfs: optimise readdir cache page invalidation
Date:   Wed, 22 Jan 2020 18:48:53 -0500
Message-Id: <20200122234853.101576-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001220196
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
 fs/nfs/dir.c           | 14 +++++++++++++-
 include/linux/nfs_fs.h |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e180033e35cf..3fbf2e41d523 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -437,7 +437,10 @@ void nfs_force_use_readdirplus(struct inode *dir)
 	if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
 	    !list_empty(&nfsi->open_files)) {
 		set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
-		invalidate_mapping_pages(dir->i_mapping, 0, -1);
+		nfs_zap_mapping(dir, dir->i_mapping);
+		if (NFS_PROTO(dir)->version == 3)
+			invalidate_mapping_pages(dir->i_mapping,
+				nfsi->page_index + 1, -1);
 	}
 }
 
@@ -709,6 +712,9 @@ struct page *get_cache_page(nfs_readdir_descriptor_t *desc)
 int find_cache_page(nfs_readdir_descriptor_t *desc)
 {
 	int res;
+	struct inode *inode;
+	struct nfs_inode *nfsi;
+	struct dentry *dentry;
 
 	desc->page = get_cache_page(desc);
 	if (IS_ERR(desc->page))
@@ -717,6 +723,12 @@ int find_cache_page(nfs_readdir_descriptor_t *desc)
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

