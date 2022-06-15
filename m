Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA1254D00E
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355870AbiFORfD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345533AbiFORfC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 13:35:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09D7FD09
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 10:35:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHXogL022330;
        Wed, 15 Jun 2022 17:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=BkGNZU0Eu6DMGIcYenZPJ9O2Bzfs6eojE/2XJ5bkCvo=;
 b=nlakMsN3btbbZMcnS2sO9504xKX9zePT6o+gT50h/COVoBpfQhDQ9p5474e7ruY65Zx4
 tax0X6zNEmVrWmRZFnWPfaTwwKy1qx8pWJ01oDg+LX27PMahtkRN19dagiwVwwSSU6rx
 GbdhrldtAkPy40KYGy1U6igL/Timg0f6iGzm5XCbU8HVvD5Ori+d/edFBTUC/RStIDJo
 uf9UtI41ChHkUsCWI+EqaVC3lPhJgXd9ItmXqOGO5jHc4LEOOnFWGrKwqbBbB8ubhaXf
 grUtd12rW/rN8g4EUPoGkm7wrOxDo/AM/71C3DOVxIp5KJjkwqDcnUQ66QIZ/+pvISjP eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcs5vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 17:35:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FHFxfs013720;
        Wed, 15 Jun 2022 17:34:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr261pc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 17:34:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25FHRi3s001726;
        Wed, 15 Jun 2022 17:34:59 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr261pbh-1;
        Wed, 15 Jun 2022 17:34:58 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfs4lib.py: enhance open_file to work with courteous server
Date:   Wed, 15 Jun 2022 10:34:54 -0700
Message-Id: <1655314495-17735-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-ORIG-GUID: l5BCs8l--J-KEHKvNl6wWts7n9tShG4G
X-Proofpoint-GUID: l5BCs8l--J-KEHKvNl6wWts7n9tShG4G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enhance open_file to handle NFS4ERR_DELAY returned by the server
in case of share/access/delegation conflict.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.0/nfs4lib.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index 934def3b7333..e0299e8d6676 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -677,7 +677,12 @@ class NFS4Client(rpc.RPCClient):
                           claim_type=claim_type, deleg_type=deleg_type,
                           deleg_cur_info=deleg_cur_info)]
         ops += [op4.getfh()]
-        res = self.compound(ops)
+        while 1:
+            res = self.compound(ops)
+            if res.status == NFS4ERR_DELAY:
+                time.sleep(2)
+            else:
+                break
         self.advance_seqid(owner, res)
         if set_recall and (res.status != NFS4_OK or \
            res.resarray[-2].switch.switch.delegation == OPEN_DELEGATE_NONE):
-- 
2.27.0

