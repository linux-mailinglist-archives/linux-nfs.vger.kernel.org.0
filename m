Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE89E346DF2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 00:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhCWXtO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 19:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhCWXtH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 19:49:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F7DF619C2;
        Tue, 23 Mar 2021 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616543343;
        bh=73IUD1ex775GRIOLkVkhFhRaIXgVYqgtUbryJLv3RBw=;
        h=Date:From:To:Cc:Subject:From;
        b=GnFKBWJxIKnz95O+xW2aV0ZoO+k4AppcoqQoxYdGISN46/avmkjUr1OJ+PvHv0j+2
         uWgNXseJrkWz5+3fcH3U20pHkOk1r2rvKM0otZMCqoJb55HRO0QPHywCp4DurK9KLO
         E8z1w8rszrCzPrmmi9/9bxVbqtb34N+ygZmKqLRNFYTcbnl7vZOGPJBnxHEs6cnWN/
         FAaFR/NPi5BEYFPt/0lj8UfVHj5BqqUV795/9cfo//R7e3vXLV/+wnPqIo+mpHuEUy
         dOoYrYuq+CVhVLtM1sQG9Va+lD2sL+s80irx22HvpKfoemVnosCu51bWGRDIxVrFt2
         vFVXdAo0v8e0w==
Date:   Tue, 23 Mar 2021 17:48:58 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] UAPI: nfsfh.h: Replace one-element array with
 flexible-array member
Message-ID: <20210323224858.GA293698@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Use an anonymous union with a couple of anonymous structs in order to
keep userspace unchanged:

$ pahole -C nfs_fhbase_new fs/nfsd/nfsfh.o
struct nfs_fhbase_new {
        union {
                struct {
                        __u8       fb_version_aux;       /*     0     1 */
                        __u8       fb_auth_type_aux;     /*     1     1 */
                        __u8       fb_fsid_type_aux;     /*     2     1 */
                        __u8       fb_fileid_type_aux;   /*     3     1 */
                        __u32      fb_auth[1];           /*     4     4 */
                };                                       /*     0     8 */
                struct {
                        __u8       fb_version;           /*     0     1 */
                        __u8       fb_auth_type;         /*     1     1 */
                        __u8       fb_fsid_type;         /*     2     1 */
                        __u8       fb_fileid_type;       /*     3     1 */
                        __u32      fb_auth_flex[0];      /*     4     0 */
                };                                       /*     0     4 */
        };                                               /*     0     8 */

        /* size: 8, cachelines: 1, members: 1 */
        /* last cacheline: 8 bytes */
};

Also, this helps with the ongoing efforts to enable -Warray-bounds by
fixing the following warnings:

fs/nfsd/nfsfh.c: In function ‘nfsd_set_fh_dentry’:
fs/nfsd/nfsfh.c:191:41: warning: array subscript 1 is above array bounds of ‘__u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
  191 |        ntohl((__force __be32)fh->fh_fsid[1])));
      |                              ~~~~~~~~~~~^~~
./include/linux/kdev_t.h:12:46: note: in definition of macro ‘MKDEV’
   12 | #define MKDEV(ma,mi) (((ma) << MINORBITS) | (mi))
      |                                              ^~
./include/uapi/linux/byteorder/little_endian.h:40:26: note: in expansion of macro ‘__swab32’
   40 | #define __be32_to_cpu(x) __swab32((__force __u32)(__be32)(x))
      |                          ^~~~~~~~
./include/linux/byteorder/generic.h:136:21: note: in expansion of macro ‘__be32_to_cpu’
  136 | #define ___ntohl(x) __be32_to_cpu(x)
      |                     ^~~~~~~~~~~~~
./include/linux/byteorder/generic.h:140:18: note: in expansion of macro ‘___ntohl’
  140 | #define ntohl(x) ___ntohl(x)
      |                  ^~~~~~~~
fs/nfsd/nfsfh.c:191:8: note: in expansion of macro ‘ntohl’
  191 |        ntohl((__force __be32)fh->fh_fsid[1])));
      |        ^~~~~
fs/nfsd/nfsfh.c:192:32: warning: array subscript 2 is above array bounds of ‘__u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
  192 |    fh->fh_fsid[1] = fh->fh_fsid[2];
      |                     ~~~~~~~~~~~^~~
fs/nfsd/nfsfh.c:192:15: warning: array subscript 1 is above array bounds of ‘__u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
  192 |    fh->fh_fsid[1] = fh->fh_fsid[2];
      |    ~~~~~~~~~~~^~~

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/nfsd/nfsfh.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/nfsd/nfsfh.h b/include/uapi/linux/nfsd/nfsfh.h
index ff0ca88b1c8f..427294dd56a1 100644
--- a/include/uapi/linux/nfsd/nfsfh.h
+++ b/include/uapi/linux/nfsd/nfsfh.h
@@ -64,13 +64,24 @@ struct nfs_fhbase_old {
  *   in include/linux/exportfs.h for currently registered values.
  */
 struct nfs_fhbase_new {
-	__u8		fb_version;	/* == 1, even => nfs_fhbase_old */
-	__u8		fb_auth_type;
-	__u8		fb_fsid_type;
-	__u8		fb_fileid_type;
-	__u32		fb_auth[1];
-/*	__u32		fb_fsid[0]; floating */
-/*	__u32		fb_fileid[0]; floating */
+	union {
+		struct {
+			__u8		fb_version_aux;	/* == 1, even => nfs_fhbase_old */
+			__u8		fb_auth_type_aux;
+			__u8		fb_fsid_type_aux;
+			__u8		fb_fileid_type_aux;
+			__u32		fb_auth[1];
+			/*	__u32		fb_fsid[0]; floating */
+			/*	__u32		fb_fileid[0]; floating */
+		};
+		struct {
+			__u8		fb_version;	/* == 1, even => nfs_fhbase_old */
+			__u8		fb_auth_type;
+			__u8		fb_fsid_type;
+			__u8		fb_fileid_type;
+			__u32		fb_auth_flex[]; /* flexible-array member */
+		};
+	};
 };
 
 struct knfsd_fh {
@@ -97,7 +108,7 @@ struct knfsd_fh {
 #define	fh_fsid_type		fh_base.fh_new.fb_fsid_type
 #define	fh_auth_type		fh_base.fh_new.fb_auth_type
 #define	fh_fileid_type		fh_base.fh_new.fb_fileid_type
-#define	fh_fsid			fh_base.fh_new.fb_auth
+#define	fh_fsid			fh_base.fh_new.fb_auth_flex
 
 /* Do not use, provided for userspace compatiblity. */
 #define	fh_auth			fh_base.fh_new.fb_auth
-- 
2.27.0

