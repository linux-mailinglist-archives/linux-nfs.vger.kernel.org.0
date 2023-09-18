Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BEF7A4C00
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbjIRPY0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239996AbjIRPYZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:24:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA29109
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:22:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A0BC2BCFE;
        Mon, 18 Sep 2023 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045727;
        bh=BQefnBCIPeA85fMx0S7Kv++X5t/KtrIj+QjAcMjiXhk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HllNR+E/O8CzK2Hf/GuUEgdx4px16H56V00LPUgyBfLOCOt6XndmH+jep9uwZwbL5
         0cm7li/M6cxtmddzTzq38CPnb+cn4a+RNNzgDgb1kVJefQthBIVZBEPhpU8qBw/KEf
         UshGdLLJaWu2xbPgamOoibHbYBUDZ5cr17OprTBcd4rACTaAMxNVv18Pn9Kz96aJZd
         YV/YmrpgTkZ/rii20ncN+pv/99nX3dBPORRKEKNUG+I8tXT/Ryuy8hxqN3cdnHP2Ud
         2Ka75pPK984RJEfpE2c1WqdYk01mWnkCx58AVi3CQk+CCYFcokD/VklADWB1mS2wG9
         Wgubl59Xo2t5A==
Subject: [PATCH v1 50/52] NFSD: Copy FATTR4 bit number definitions from RFCs
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:02:06 -0400
Message-ID: <169504572609.133720.16474496647723355765.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

I'd like to convert nfsd4_encode_fattr() to rotate through the
attrmask using for_each_bit() instead of explicitly testing the
bitmask for each bit value. This means I need the bit numbers, as
defined in the specs, instead of our internal bitmask constants.

As a clean up, use the new spec-derived values to define the WORD#
bitmask constants.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/nfs4.h |  260 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 192 insertions(+), 68 deletions(-)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 730003c4f4af..b23c193523c3 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -389,79 +389,203 @@ enum lock_type4 {
 	NFS4_WRITEW_LT = 4
 };
 
+/*
+ * Symbol names and values are from RFC 7531 Section 2.
+ * "XDR Description of NFSv4.0"
+ */
+enum {
+	FATTR4_SUPPORTED_ATTRS		= 0,
+	FATTR4_TYPE			= 1,
+	FATTR4_FH_EXPIRE_TYPE		= 2,
+	FATTR4_CHANGE			= 3,
+	FATTR4_SIZE			= 4,
+	FATTR4_LINK_SUPPORT		= 5,
+	FATTR4_SYMLINK_SUPPORT		= 6,
+	FATTR4_NAMED_ATTR		= 7,
+	FATTR4_FSID			= 8,
+	FATTR4_UNIQUE_HANDLES		= 9,
+	FATTR4_LEASE_TIME		= 10,
+	FATTR4_RDATTR_ERROR		= 11,
+	FATTR4_ACL			= 12,
+	FATTR4_ACLSUPPORT		= 13,
+	FATTR4_ARCHIVE			= 14,
+	FATTR4_CANSETTIME		= 15,
+	FATTR4_CASE_INSENSITIVE		= 16,
+	FATTR4_CASE_PRESERVING		= 17,
+	FATTR4_CHOWN_RESTRICTED		= 18,
+	FATTR4_FILEHANDLE		= 19,
+	FATTR4_FILEID			= 20,
+	FATTR4_FILES_AVAIL		= 21,
+	FATTR4_FILES_FREE		= 22,
+	FATTR4_FILES_TOTAL		= 23,
+	FATTR4_FS_LOCATIONS		= 24,
+	FATTR4_HIDDEN			= 25,
+	FATTR4_HOMOGENEOUS		= 26,
+	FATTR4_MAXFILESIZE		= 27,
+	FATTR4_MAXLINK			= 28,
+	FATTR4_MAXNAME			= 29,
+	FATTR4_MAXREAD			= 30,
+	FATTR4_MAXWRITE			= 31,
+	FATTR4_MIMETYPE			= 32,
+	FATTR4_MODE			= 33,
+	FATTR4_NO_TRUNC			= 34,
+	FATTR4_NUMLINKS			= 35,
+	FATTR4_OWNER			= 36,
+	FATTR4_OWNER_GROUP		= 37,
+	FATTR4_QUOTA_AVAIL_HARD		= 38,
+	FATTR4_QUOTA_AVAIL_SOFT		= 39,
+	FATTR4_QUOTA_USED		= 40,
+	FATTR4_RAWDEV			= 41,
+	FATTR4_SPACE_AVAIL		= 42,
+	FATTR4_SPACE_FREE		= 43,
+	FATTR4_SPACE_TOTAL		= 44,
+	FATTR4_SPACE_USED		= 45,
+	FATTR4_SYSTEM			= 46,
+	FATTR4_TIME_ACCESS		= 47,
+	FATTR4_TIME_ACCESS_SET		= 48,
+	FATTR4_TIME_BACKUP		= 49,
+	FATTR4_TIME_CREATE		= 50,
+	FATTR4_TIME_DELTA		= 51,
+	FATTR4_TIME_METADATA		= 52,
+	FATTR4_TIME_MODIFY		= 53,
+	FATTR4_TIME_MODIFY_SET		= 54,
+	FATTR4_MOUNTED_ON_FILEID	= 55,
+};
+
+/*
+ * Symbol names and values are from RFC 5662 Section 2.
+ * "XDR Description of NFSv4.1"
+ */
+enum {
+	FATTR4_DIR_NOTIF_DELAY		= 56,
+	FATTR4_DIRENT_NOTIF_DELAY	= 57,
+	FATTR4_DACL			= 58,
+	FATTR4_SACL			= 59,
+	FATTR4_CHANGE_POLICY		= 60,
+	FATTR4_FS_STATUS		= 61,
+	FATTR4_FS_LAYOUT_TYPES		= 62,
+	FATTR4_LAYOUT_HINT		= 63,
+	FATTR4_LAYOUT_TYPES		= 64,
+	FATTR4_LAYOUT_BLKSIZE		= 65,
+	FATTR4_LAYOUT_ALIGNMENT		= 66,
+	FATTR4_FS_LOCATIONS_INFO	= 67,
+	FATTR4_MDSTHRESHOLD		= 68,
+	FATTR4_RETENTION_GET		= 69,
+	FATTR4_RETENTION_SET		= 70,
+	FATTR4_RETENTEVT_GET		= 71,
+	FATTR4_RETENTEVT_SET		= 72,
+	FATTR4_RETENTION_HOLD		= 73,
+	FATTR4_MODE_SET_MASKED		= 74,
+	FATTR4_SUPPATTR_EXCLCREAT	= 75,
+	FATTR4_FS_CHARSET_CAP		= 76,
+};
+
+/*
+ * Symbol names and values are from RFC 7863 Section 2.
+ * "XDR Description of NFSv4.2"
+ */
+enum {
+	FATTR4_CLONE_BLKSIZE		= 77,
+	FATTR4_SPACE_FREED		= 78,
+	FATTR4_CHANGE_ATTR_TYPE		= 79,
+	FATTR4_SEC_LABEL		= 80,
+};
+
+/*
+ * Symbol names and values are from RFC 8275 Section 5.
+ * "The mode_umask Attribute"
+ */
+enum {
+	FATTR4_MODE_UMASK		= 81,
+};
+
+/*
+ * Symbol names and values are from RFC 8276 Section 8.6.
+ * "Numeric Values Assigned to Protocol Extensions"
+ */
+enum {
+	FATTR4_XATTR_SUPPORT		= 82,
+};
+
+/*
+ * The following internal definitions enable processing the above
+ * attribute bits within 32-bit word boundaries.
+ */
 
 /* Mandatory Attributes */
-#define FATTR4_WORD0_SUPPORTED_ATTRS    (1UL << 0)
-#define FATTR4_WORD0_TYPE               (1UL << 1)
-#define FATTR4_WORD0_FH_EXPIRE_TYPE     (1UL << 2)
-#define FATTR4_WORD0_CHANGE             (1UL << 3)
-#define FATTR4_WORD0_SIZE               (1UL << 4)
-#define FATTR4_WORD0_LINK_SUPPORT       (1UL << 5)
-#define FATTR4_WORD0_SYMLINK_SUPPORT    (1UL << 6)
-#define FATTR4_WORD0_NAMED_ATTR         (1UL << 7)
-#define FATTR4_WORD0_FSID               (1UL << 8)
-#define FATTR4_WORD0_UNIQUE_HANDLES     (1UL << 9)
-#define FATTR4_WORD0_LEASE_TIME         (1UL << 10)
-#define FATTR4_WORD0_RDATTR_ERROR       (1UL << 11)
+#define FATTR4_WORD0_SUPPORTED_ATTRS    BIT(FATTR4_SUPPORTED_ATTRS)
+#define FATTR4_WORD0_TYPE               BIT(FATTR4_TYPE)
+#define FATTR4_WORD0_FH_EXPIRE_TYPE     BIT(FATTR4_FH_EXPIRE_TYPE)
+#define FATTR4_WORD0_CHANGE             BIT(FATTR4_CHANGE)
+#define FATTR4_WORD0_SIZE               BIT(FATTR4_SIZE)
+#define FATTR4_WORD0_LINK_SUPPORT       BIT(FATTR4_LINK_SUPPORT)
+#define FATTR4_WORD0_SYMLINK_SUPPORT    BIT(FATTR4_SYMLINK_SUPPORT)
+#define FATTR4_WORD0_NAMED_ATTR         BIT(FATTR4_NAMED_ATTR)
+#define FATTR4_WORD0_FSID               BIT(FATTR4_FSID)
+#define FATTR4_WORD0_UNIQUE_HANDLES     BIT(FATTR4_UNIQUE_HANDLES)
+#define FATTR4_WORD0_LEASE_TIME         BIT(FATTR4_LEASE_TIME)
+#define FATTR4_WORD0_RDATTR_ERROR       BIT(FATTR4_RDATTR_ERROR)
 /* Mandatory in NFSv4.1 */
-#define FATTR4_WORD2_SUPPATTR_EXCLCREAT (1UL << 11)
+#define FATTR4_WORD2_SUPPATTR_EXCLCREAT BIT(FATTR4_SUPPATTR_EXCLCREAT - 64)
 
 /* Recommended Attributes */
-#define FATTR4_WORD0_ACL                (1UL << 12)
-#define FATTR4_WORD0_ACLSUPPORT         (1UL << 13)
-#define FATTR4_WORD0_ARCHIVE            (1UL << 14)
-#define FATTR4_WORD0_CANSETTIME         (1UL << 15)
-#define FATTR4_WORD0_CASE_INSENSITIVE   (1UL << 16)
-#define FATTR4_WORD0_CASE_PRESERVING    (1UL << 17)
-#define FATTR4_WORD0_CHOWN_RESTRICTED   (1UL << 18)
-#define FATTR4_WORD0_FILEHANDLE         (1UL << 19)
-#define FATTR4_WORD0_FILEID             (1UL << 20)
-#define FATTR4_WORD0_FILES_AVAIL        (1UL << 21)
-#define FATTR4_WORD0_FILES_FREE         (1UL << 22)
-#define FATTR4_WORD0_FILES_TOTAL        (1UL << 23)
-#define FATTR4_WORD0_FS_LOCATIONS       (1UL << 24)
-#define FATTR4_WORD0_HIDDEN             (1UL << 25)
-#define FATTR4_WORD0_HOMOGENEOUS        (1UL << 26)
-#define FATTR4_WORD0_MAXFILESIZE        (1UL << 27)
-#define FATTR4_WORD0_MAXLINK            (1UL << 28)
-#define FATTR4_WORD0_MAXNAME            (1UL << 29)
-#define FATTR4_WORD0_MAXREAD            (1UL << 30)
-#define FATTR4_WORD0_MAXWRITE           (1UL << 31)
-#define FATTR4_WORD1_MIMETYPE           (1UL << 0)
-#define FATTR4_WORD1_MODE               (1UL << 1)
-#define FATTR4_WORD1_NO_TRUNC           (1UL << 2)
-#define FATTR4_WORD1_NUMLINKS           (1UL << 3)
-#define FATTR4_WORD1_OWNER              (1UL << 4)
-#define FATTR4_WORD1_OWNER_GROUP        (1UL << 5)
-#define FATTR4_WORD1_QUOTA_HARD         (1UL << 6)
-#define FATTR4_WORD1_QUOTA_SOFT         (1UL << 7)
-#define FATTR4_WORD1_QUOTA_USED         (1UL << 8)
-#define FATTR4_WORD1_RAWDEV             (1UL << 9)
-#define FATTR4_WORD1_SPACE_AVAIL        (1UL << 10)
-#define FATTR4_WORD1_SPACE_FREE         (1UL << 11)
-#define FATTR4_WORD1_SPACE_TOTAL        (1UL << 12)
-#define FATTR4_WORD1_SPACE_USED         (1UL << 13)
-#define FATTR4_WORD1_SYSTEM             (1UL << 14)
-#define FATTR4_WORD1_TIME_ACCESS        (1UL << 15)
-#define FATTR4_WORD1_TIME_ACCESS_SET    (1UL << 16)
-#define FATTR4_WORD1_TIME_BACKUP        (1UL << 17)
-#define FATTR4_WORD1_TIME_CREATE        (1UL << 18)
-#define FATTR4_WORD1_TIME_DELTA         (1UL << 19)
-#define FATTR4_WORD1_TIME_METADATA      (1UL << 20)
-#define FATTR4_WORD1_TIME_MODIFY        (1UL << 21)
-#define FATTR4_WORD1_TIME_MODIFY_SET    (1UL << 22)
-#define FATTR4_WORD1_MOUNTED_ON_FILEID  (1UL << 23)
-#define FATTR4_WORD1_DACL               (1UL << 26)
-#define FATTR4_WORD1_SACL               (1UL << 27)
-#define FATTR4_WORD1_FS_LAYOUT_TYPES    (1UL << 30)
-#define FATTR4_WORD2_LAYOUT_TYPES       (1UL << 0)
-#define FATTR4_WORD2_LAYOUT_BLKSIZE     (1UL << 1)
-#define FATTR4_WORD2_MDSTHRESHOLD       (1UL << 4)
-#define FATTR4_WORD2_CLONE_BLKSIZE	(1UL << 13)
-#define FATTR4_WORD2_CHANGE_ATTR_TYPE	(1UL << 15)
-#define FATTR4_WORD2_SECURITY_LABEL     (1UL << 16)
-#define FATTR4_WORD2_MODE_UMASK		(1UL << 17)
-#define FATTR4_WORD2_XATTR_SUPPORT	(1UL << 18)
+#define FATTR4_WORD0_ACL                BIT(FATTR4_ACL)
+#define FATTR4_WORD0_ACLSUPPORT         BIT(FATTR4_ACLSUPPORT)
+#define FATTR4_WORD0_ARCHIVE            BIT(FATTR4_ARCHIVE)
+#define FATTR4_WORD0_CANSETTIME         BIT(FATTR4_CANSETTIME)
+#define FATTR4_WORD0_CASE_INSENSITIVE   BIT(FATTR4_CASE_INSENSITIVE)
+#define FATTR4_WORD0_CASE_PRESERVING    BIT(FATTR4_CASE_PRESERVING)
+#define FATTR4_WORD0_CHOWN_RESTRICTED   BIT(FATTR4_CHOWN_RESTRICTED)
+#define FATTR4_WORD0_FILEHANDLE         BIT(FATTR4_FILEHANDLE)
+#define FATTR4_WORD0_FILEID             BIT(FATTR4_FILEID)
+#define FATTR4_WORD0_FILES_AVAIL        BIT(FATTR4_FILES_AVAIL)
+#define FATTR4_WORD0_FILES_FREE         BIT(FATTR4_FILES_FREE)
+#define FATTR4_WORD0_FILES_TOTAL        BIT(FATTR4_FILES_TOTAL)
+#define FATTR4_WORD0_FS_LOCATIONS       BIT(FATTR4_FS_LOCATIONS)
+#define FATTR4_WORD0_HIDDEN             BIT(FATTR4_HIDDEN)
+#define FATTR4_WORD0_HOMOGENEOUS        BIT(FATTR4_HOMOGENEOUS)
+#define FATTR4_WORD0_MAXFILESIZE        BIT(FATTR4_MAXFILESIZE)
+#define FATTR4_WORD0_MAXLINK            BIT(FATTR4_MAXLINK)
+#define FATTR4_WORD0_MAXNAME            BIT(FATTR4_MAXNAME)
+#define FATTR4_WORD0_MAXREAD            BIT(FATTR4_MAXREAD)
+#define FATTR4_WORD0_MAXWRITE           BIT(FATTR4_MAXWRITE)
+
+#define FATTR4_WORD1_MIMETYPE           BIT(FATTR4_MIMETYPE - 32)
+#define FATTR4_WORD1_MODE               BIT(FATTR4_MODE	- 32)
+#define FATTR4_WORD1_NO_TRUNC           BIT(FATTR4_NO_TRUNC - 32)
+#define FATTR4_WORD1_NUMLINKS           BIT(FATTR4_NUMLINKS - 32)
+#define FATTR4_WORD1_OWNER              BIT(FATTR4_OWNER - 32)
+#define FATTR4_WORD1_OWNER_GROUP        BIT(FATTR4_OWNER_GROUP - 32)
+#define FATTR4_WORD1_QUOTA_HARD         BIT(FATTR4_QUOTA_AVAIL_HARD - 32)
+#define FATTR4_WORD1_QUOTA_SOFT         BIT(FATTR4_QUOTA_AVAIL_SOFT - 32)
+#define FATTR4_WORD1_QUOTA_USED         BIT(FATTR4_QUOTA_USED - 32)
+#define FATTR4_WORD1_RAWDEV             BIT(FATTR4_RAWDEV - 32)
+#define FATTR4_WORD1_SPACE_AVAIL        BIT(FATTR4_SPACE_AVAIL - 32)
+#define FATTR4_WORD1_SPACE_FREE         BIT(FATTR4_SPACE_FREE - 32)
+#define FATTR4_WORD1_SPACE_TOTAL        BIT(FATTR4_SPACE_TOTAL - 32)
+#define FATTR4_WORD1_SPACE_USED         BIT(FATTR4_SPACE_USED - 32)
+#define FATTR4_WORD1_SYSTEM             BIT(FATTR4_SYSTEM - 32)
+#define FATTR4_WORD1_TIME_ACCESS        BIT(FATTR4_TIME_ACCESS - 32)
+#define FATTR4_WORD1_TIME_ACCESS_SET    BIT(FATTR4_TIME_ACCESS_SET - 32)
+#define FATTR4_WORD1_TIME_BACKUP        BIT(FATTR4_TIME_BACKUP - 32)
+#define FATTR4_WORD1_TIME_CREATE        BIT(FATTR4_TIME_CREATE - 32)
+#define FATTR4_WORD1_TIME_DELTA         BIT(FATTR4_TIME_DELTA - 32)
+#define FATTR4_WORD1_TIME_METADATA      BIT(FATTR4_TIME_METADATA - 32)
+#define FATTR4_WORD1_TIME_MODIFY        BIT(FATTR4_TIME_MODIFY - 32)
+#define FATTR4_WORD1_TIME_MODIFY_SET    BIT(FATTR4_TIME_MODIFY_SET - 32)
+#define FATTR4_WORD1_MOUNTED_ON_FILEID  BIT(FATTR4_MOUNTED_ON_FILEID - 32)
+#define FATTR4_WORD1_DACL               BIT(FATTR4_DACL	- 32)
+#define FATTR4_WORD1_SACL               BIT(FATTR4_SACL	- 32)
+#define FATTR4_WORD1_FS_LAYOUT_TYPES    BIT(FATTR4_FS_LAYOUT_TYPES - 32)
+
+#define FATTR4_WORD2_LAYOUT_TYPES       BIT(FATTR4_LAYOUT_TYPES - 64)
+#define FATTR4_WORD2_LAYOUT_BLKSIZE     BIT(FATTR4_LAYOUT_BLKSIZE - 64)
+#define FATTR4_WORD2_MDSTHRESHOLD       BIT(FATTR4_MDSTHRESHOLD	- 64)
+#define FATTR4_WORD2_CLONE_BLKSIZE	BIT(FATTR4_CLONE_BLKSIZE - 64)
+#define FATTR4_WORD2_CHANGE_ATTR_TYPE	BIT(FATTR4_CHANGE_ATTR_TYPE - 64)
+#define FATTR4_WORD2_SECURITY_LABEL     BIT(FATTR4_SEC_LABEL - 64)
+#define FATTR4_WORD2_MODE_UMASK		BIT(FATTR4_MODE_UMASK - 64)
+#define FATTR4_WORD2_XATTR_SUPPORT	BIT(FATTR4_XATTR_SUPPORT - 64)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)


