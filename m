Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDACF54D010
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbiFORfE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347502AbiFORfD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 13:35:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19FF11837
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 10:35:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHXrPk032726;
        Wed, 15 Jun 2022 17:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=oj864GkOr/s35FlpHkEPCyGXZqt8gDAWU4uzb2H5cA8=;
 b=wLcs5QOEbaAJEe+AGShm4uRcnv6dwRYMH5wJRT4VO4EkCoGzKXxCxUqs8w56tyzMJEHY
 nQnPUscnJOoNP3JDK0k+1cydrGzMfcWKpo7Squ+TLcsgFwuA/EQXzdPQztAgSQOvabub
 wiliDCwF7xGhFWn4hiryplUjYA41DQ7c3ut/0OEiTC5MA93CHJx6CVcM87vlHCqqzynX
 v0CK0prcI6Zd1df3mmKG+g+SdC6YMfHakzuVi5tU+ebTsENGNQqSHS52ycAJV93GrEtl
 unA5sAkpyEZeqCrvVCIRernP5LUcqRcWH5P54faoNhET5ivNqLcTjj33xXCsA3aVBvlu +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2sb2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 17:35:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FHFxvk013638;
        Wed, 15 Jun 2022 17:34:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr261pc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 17:34:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25FHRi3u001726;
        Wed, 15 Jun 2022 17:34:59 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr261pbh-2;
        Wed, 15 Jun 2022 17:34:59 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] environment.py: enhance open_create_file to work with courteous server
Date:   Wed, 15 Jun 2022 10:34:55 -0700
Message-Id: <1655314495-17735-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655314495-17735-1-git-send-email-dai.ngo@oracle.com>
References: <1655314495-17735-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: 0NCwkKaIkcQjdvIdGCixi2mi8fooQNvV
X-Proofpoint-ORIG-GUID: 0NCwkKaIkcQjdvIdGCixi2mi8fooQNvV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enhance open_create_file to handle NFS4ERR_DELAY returned by the server
in case of share/access/delegation conflict.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.1/server41tests/environment.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index 0b7c976d8582..fb834b28841b 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -483,11 +483,16 @@ def open_create_file(sess, owner, path=None, attrs={FATTR4_MODE: 0o644},
                      deleg_type=None,
                      open_create=OPEN4_NOCREATE,
                      seqid=0, clientid=0):
-    open_op = open_create_file_op(sess, owner, path, attrs, access, deny, mode,
-                            verifier, claim_type, want_deleg, deleg_type,
-                            open_create, seqid, clientid)
-
-    return sess.compound(open_op)
+    while 1:
+        open_op = open_create_file_op(sess, owner, path, attrs, access, deny, mode,
+                       verifier, claim_type, want_deleg, deleg_type,
+                       open_create, seqid, clientid)
+        res = sess.compound(open_op)
+        if res.status == NFS4ERR_DELAY:
+            time.sleep(2)
+        else:
+            break
+    return res
 
 def open_create_file_op(sess, owner, path=None, attrs={FATTR4_MODE: 0o644},
                      access=OPEN4_SHARE_ACCESS_BOTH,
-- 
2.27.0

