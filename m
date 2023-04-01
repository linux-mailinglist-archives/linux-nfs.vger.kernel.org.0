Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9DC6D33CA
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Apr 2023 22:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjDAUYF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Apr 2023 16:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDAUYE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Apr 2023 16:24:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C6BC669
        for <linux-nfs@vger.kernel.org>; Sat,  1 Apr 2023 13:24:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 331J0SQ9015659
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=TpNP+V4U6g7Q4GWo1+tboTvxZlYHimfUiWpAlgN6oOg=;
 b=09K3JenYIz1CykBNAMqBICJuibPtSYV1bG9cfbGk3cajWdmuXYJ5py2ReAZX3YKDa3JR
 o+oYMqdKNP0VVYlf1vfyVBgpgDkuYqZl8ckJ7ofX5MUpL8zMuEMBU+wycODqKGSy7/O5
 3WpkOcjNVnzd8dkprcm49WXP3pck2ncfbW6KtTp/vLvJzf/ykCaAJYn6IpYf8ihsN+1N
 GgtMRTnO7lOWFClaf5zDr8ZI41PVFlFNTvN7733cjUB+dr58u49U7sr7fKgtGXKAjnbS
 8DDj0l3TQ5Lsjqm6yW67/mrUXHHvZaC/9zhIGBqDH9nlAaxoeTCYc9sYiZS7lAVVuPAP cA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7trtm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 01 Apr 2023 20:24:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 331JK5x7017868
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:24:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp39bhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 01 Apr 2023 20:24:02 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 331KNqNY026021
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:24:02 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptp39bhe-1;
        Sat, 01 Apr 2023 20:24:02 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     calum.mackay@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [pynfs PATCH] DELEG22: Return delegations so clean_diff() works
Date:   Sat,  1 Apr 2023 13:23:52 -0700
Message-Id: <1680380632-22522-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304010187
X-Proofpoint-ORIG-GUID: 4zRSjfxgQ2cdf1yy4PXx6ntJPlZIh0DY
X-Proofpoint-GUID: 4zRSjfxgQ2cdf1yy4PXx6ntJPlZIh0DY
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: root <root@nfsvmd07.us.oracle.com>

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

