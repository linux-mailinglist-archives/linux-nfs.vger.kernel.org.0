Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8586D33D1
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Apr 2023 22:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjDAUaK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Apr 2023 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAUaK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Apr 2023 16:30:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CEBC669
        for <linux-nfs@vger.kernel.org>; Sat,  1 Apr 2023 13:30:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3315YMeU024533
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=kbGeThlJsMAj6wyhFO47pfSEyOilk1EOpNcAOpnNzwg=;
 b=GkYnxPt0jO+W0qZsR9iDUcY1kgzfedwLHd44rItm6WQhp4j/NWTC/YtC6f09W8DPgrWL
 Cl1607+jVQd18mehNo8dRQcesDYCPZ+/C75WP2O/4h/l3zxJQYV7v+ijKAJrwi/LtJJm
 wulq+1yyJSyqxvAHBwHahCuPyyN55tfrUak3LK1kJh0HwD37bvUhrGq0zlnh7bzVt7Ju
 v3K5RDpBRMpDyz56uPtaNz6qlsEwn4xQolnbBBe4SY0ET0/TfwbbkMc+E+d/Wme7ddzm
 IYVw5My6WcWPeTnao6J2P0ppDA0BcKd/ZVY6uAUSQieuM73Mi7RrGtiS6zjH8kMQq2xv Tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd3rv22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 01 Apr 2023 20:30:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 331JCfOn037728
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:30:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjn9n9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 01 Apr 2023 20:30:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 331KU7FZ035158
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:30:07 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptjn9n87-1;
        Sat, 01 Apr 2023 20:30:07 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     calum.mackay@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [pynfs PATCH v2] DELEG22: Return delegations so clean_diff() works
Date:   Sat,  1 Apr 2023 13:29:45 -0700
Message-Id: <1680380985-22971-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304010187
X-Proofpoint-ORIG-GUID: YXm9XAmGwpfGreF6LupLcosjGzjQoajP
X-Proofpoint-GUID: YXm9XAmGwpfGreF6LupLcosjGzjQoajP
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

WARNING: could not clean testdir due to:
Making sure b'DELEG22-1' is writable: operation OP_SETATTR should return NFS4_OK, instead got NFS4ERR_DELAY

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.0/servertests/st_delegation.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/nfs4.0/servertests/st_delegation.py b/nfs4.0/servertests/st_delegation.py
index ba49cf9..2318ba7 100644
--- a/nfs4.0/servertests/st_delegation.py
+++ b/nfs4.0/servertests/st_delegation.py
@@ -783,3 +783,5 @@ def testServerSelfConflict2(t,env):
     deleg_info = res.resarray[-2].switch.switch.delegation
     if deleg_info.delegation_type == OPEN_DELEGATE_NONE:
         t.fail("Could not get delegation")
+    res = c.compound([op.putfh(fh), op.delegreturn(deleg_info.read.stateid)])
+    check(res)
-- 
2.27.0

