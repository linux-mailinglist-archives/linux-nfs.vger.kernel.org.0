Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7FD6F776B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 22:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEDUuM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 16:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjEDUuB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 16:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8FC11D80
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 13:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25E3D639C5
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 20:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F119C433D2;
        Thu,  4 May 2023 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683233236;
        bh=myqIA0BbvrYLcP6QStGiaNN5xaenVGZ7FwTcgCHdxh4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FV3LrDJilAvDIxnPHKpm00WaRUVVDsyNhfA9h+uFKPXiSpV46e77sJYC/u2YlY5Q/
         RH7b0NMWOeN2xI1eIHCT5Q2DHl9AG8pARC4vmLvFBZdT99q0B9AzTdEdbdSWygCGPf
         T1jr+S1wpD3f8WJwxZ9QxOcniHQw82oHT9SjRygcL0n2PJe+9mtrePKWxFdgk62nEo
         KXIkBrt4+ZrZhKgw/WP/8+1ZQEmKWDC/kZzLphIVBV1k6PGsFHfidLKLdOvFgE2YHq
         frrZiMwdZlAbDxCAnSZHjmETQ6f9M7ILFCdyKJPcbHBpIQEwifQqNhj5drzxQb0yFf
         Kh9bh0WvvLN5A==
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 04 May 2023 16:47:15 -0400
Subject: [PATCH 5/6] NFSv4.2: Clean up xattr size macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-xattr-ctime-v1-5-ac3fc5a00942@Netapp.com>
References: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
In-Reply-To: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5187;
 i=Anna.Schumaker@Netapp.com; h=from:subject:message-id;
 bh=x0I57N3cKS5WzOUXTzceP0S6UCKe81kc1ZVKdNqosZ0=;
 b=owEBbQKS/ZANAwAIAdfLVL+wpUDrAcsmYgBkVBnRntTWGJnIsaQRFbAwKH48ppWJ/pi7Dy9wt
 3U0YbdJ4vuJAjMEAAEIAB0WIQSdnkxBOlHtwtTsoSnXy1S/sKVA6wUCZFQZ0QAKCRDXy1S/sKVA
 68PTEADc/qTTfkOpOeIP1Ry51B/1+8V74EyRQHMItTW5awpoRorz0AIAXgawrmagH0yMM5kvIQh
 yr41Rmtsm9iEyyz372GKEcQlEi7gZ+69ED8LN2QCix90i2iEFoN/qeE6glDUfFr1Jpf+TW/eJJT
 SPqRVeoKQdSCg7eMetaRiQmFtj0UexS0kUbdURxDTdu7pMkYeiaSzXvy8vtpt3Et0/7sTV4Ffji
 Nd/pOwkgF0BhbB6qr+icSNIhRYcTBZdFEhwt4Tsr9ISZwdqFxowOMCQS3LHBR5zCtD60UJmmyuf
 DMSsco1PJupw9Y+ZrMu9yniUrI/4/gTxLLPBJ5/lT11WGbzMKnf1mvUq+nSph/3t62Jc/zWzkWx
 rQMInNTLHB7hCBhupb7ECFpfVx9sgAeUdCZDeqdq3c7OCF3t6Jw/7xf2/Pwt5D5CLs3Tn0UMooW
 QFiuSheE6Gg3oA/gApHy5fIE6Q8oqQIUoZ81/WFoHvMAqbYLsnxWBr4KPuLKV8wYWdrqbyozC7Y
 CxdSzWUVgqZCFcFHmt3kp/jgWqz69Wx56BCEauoHyETtNJMzYYSQuyC/3E9kKKioVF53tLX/FmG
 8JJ/nJtMLZ24gN2Hud0GNwq/zKzm9Ta2Zfeg+qcD4ywwOrPjWNLiiUejQsfeEwdjbgilbqPWALH
 J9BJniHTl7iFqzw==
X-Developer-Key: i=Anna.Schumaker@Netapp.com; a=openpgp;
 fpr=9D9E4C413A51EDC2D4ECA129D7CB54BFB0A540EB
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Fold them into the other NFS v4.2 operations in the right spots and
adjust spacing to keep the same style.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 96 +++++++++++++++++++++++++++----------------------------
 1 file changed, 47 insertions(+), 49 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 1d74135715c5..215b8700e504 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -7,6 +7,9 @@
 
 #include "nfs42.h"
 
+/* Not limited by NFS itself, limited by the generic xattr code */
+#define nfs4_xattr_name_maxsz   XDR_QUADLEN(XATTR_NAME_MAX)
+
 #define encode_fallocate_maxsz		(encode_stateid_maxsz + \
 					 2 /* offset */ + \
 					 2 /* length */)
@@ -89,6 +92,18 @@
 					2 /* dst offset */ + \
 					2 /* count */)
 #define decode_clone_maxsz		(op_decode_hdr_maxsz)
+#define encode_getxattr_maxsz		(op_encode_hdr_maxsz + 1 + \
+					 nfs4_xattr_name_maxsz)
+#define decode_getxattr_maxsz		(op_decode_hdr_maxsz + 1 + pagepad_maxsz)
+#define encode_setxattr_maxsz		(op_encode_hdr_maxsz + \
+					 1 + nfs4_xattr_name_maxsz + 1)
+#define decode_setxattr_maxsz		(op_decode_hdr_maxsz + decode_change_info_maxsz)
+#define encode_listxattrs_maxsz		(op_encode_hdr_maxsz + 2 + 1)
+#define decode_listxattrs_maxsz		(op_decode_hdr_maxsz + 2 + 1 + 1 + 1)
+#define encode_removexattr_maxsz	(op_encode_hdr_maxsz + 1 + \
+					 nfs4_xattr_name_maxsz)
+#define decode_removexattr_maxsz	(op_decode_hdr_maxsz + \
+					 decode_change_info_maxsz)
 
 #define NFS4_enc_allocate_sz		(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
@@ -186,55 +201,38 @@
 					 decode_putfh_maxsz + \
 					 decode_clone_maxsz + \
 					 decode_getattr_maxsz)
-
-/* Not limited by NFS itself, limited by the generic xattr code */
-#define nfs4_xattr_name_maxsz   XDR_QUADLEN(XATTR_NAME_MAX)
-
-#define encode_getxattr_maxsz   (op_encode_hdr_maxsz + 1 + \
-				 nfs4_xattr_name_maxsz)
-#define decode_getxattr_maxsz   (op_decode_hdr_maxsz + 1 + pagepad_maxsz)
-#define encode_setxattr_maxsz   (op_encode_hdr_maxsz + \
-				 1 + nfs4_xattr_name_maxsz + 1)
-#define decode_setxattr_maxsz   (op_decode_hdr_maxsz + decode_change_info_maxsz)
-#define encode_listxattrs_maxsz  (op_encode_hdr_maxsz + 2 + 1)
-#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + 1)
-#define encode_removexattr_maxsz (op_encode_hdr_maxsz + 1 + \
-				  nfs4_xattr_name_maxsz)
-#define decode_removexattr_maxsz (op_decode_hdr_maxsz + \
-				  decode_change_info_maxsz)
-
-#define NFS4_enc_getxattr_sz	(compound_encode_hdr_maxsz + \
-				encode_sequence_maxsz + \
-				encode_putfh_maxsz + \
-				encode_getxattr_maxsz)
-#define NFS4_dec_getxattr_sz	(compound_decode_hdr_maxsz + \
-				decode_sequence_maxsz + \
-				decode_putfh_maxsz + \
-				decode_getxattr_maxsz)
-#define NFS4_enc_setxattr_sz	(compound_encode_hdr_maxsz + \
-				encode_sequence_maxsz + \
-				encode_putfh_maxsz + \
-				encode_setxattr_maxsz)
-#define NFS4_dec_setxattr_sz	(compound_decode_hdr_maxsz + \
-				decode_sequence_maxsz + \
-				decode_putfh_maxsz + \
-				decode_setxattr_maxsz)
-#define NFS4_enc_listxattrs_sz	(compound_encode_hdr_maxsz + \
-				encode_sequence_maxsz + \
-				encode_putfh_maxsz + \
-				encode_listxattrs_maxsz)
-#define NFS4_dec_listxattrs_sz	(compound_decode_hdr_maxsz + \
-				decode_sequence_maxsz + \
-				decode_putfh_maxsz + \
-				decode_listxattrs_maxsz)
-#define NFS4_enc_removexattr_sz	(compound_encode_hdr_maxsz + \
-				encode_sequence_maxsz + \
-				encode_putfh_maxsz + \
-				encode_removexattr_maxsz)
-#define NFS4_dec_removexattr_sz	(compound_decode_hdr_maxsz + \
-				decode_sequence_maxsz + \
-				decode_putfh_maxsz + \
-				decode_removexattr_maxsz)
+#define NFS4_enc_getxattr_sz		(compound_encode_hdr_maxsz + \
+					 encode_sequence_maxsz + \
+					 encode_putfh_maxsz + \
+					 encode_getxattr_maxsz)
+#define NFS4_dec_getxattr_sz		(compound_decode_hdr_maxsz + \
+					 decode_sequence_maxsz + \
+					 decode_putfh_maxsz + \
+					 decode_getxattr_maxsz)
+#define NFS4_enc_setxattr_sz		(compound_encode_hdr_maxsz + \
+					 encode_sequence_maxsz + \
+					 encode_putfh_maxsz + \
+					 encode_setxattr_maxsz)
+#define NFS4_dec_setxattr_sz		(compound_decode_hdr_maxsz + \
+					 decode_sequence_maxsz + \
+					 decode_putfh_maxsz + \
+					 decode_setxattr_maxsz)
+#define NFS4_enc_listxattrs_sz		(compound_encode_hdr_maxsz + \
+					 encode_sequence_maxsz + \
+					 encode_putfh_maxsz + \
+					 encode_listxattrs_maxsz)
+#define NFS4_dec_listxattrs_sz		(compound_decode_hdr_maxsz + \
+					 decode_sequence_maxsz + \
+					 decode_putfh_maxsz + \
+					 decode_listxattrs_maxsz)
+#define NFS4_enc_removexattr_sz		(compound_encode_hdr_maxsz + \
+					 encode_sequence_maxsz + \
+					 encode_putfh_maxsz + \
+					 encode_removexattr_maxsz)
+#define NFS4_dec_removexattr_sz		(compound_decode_hdr_maxsz + \
+					 decode_sequence_maxsz + \
+					 decode_putfh_maxsz + \
+					 decode_removexattr_maxsz)
 
 /*
  * These values specify the maximum amount of data that is not

-- 
2.40.1

