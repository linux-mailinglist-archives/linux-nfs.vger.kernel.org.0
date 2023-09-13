Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4479F594
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Sep 2023 01:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjIMXif (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Sep 2023 19:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjIMXif (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Sep 2023 19:38:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C009CE4
        for <linux-nfs@vger.kernel.org>; Wed, 13 Sep 2023 16:38:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DGH7C1000876;
        Wed, 13 Sep 2023 23:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=SiDxLTs2XkJ3p6Zi3zIJwusHawVflElK+dEaUi8I4Ss=;
 b=i2qn9ApdvQ/PLJ2LJxTDBP3cVVSO2vmhJOXn8F9cRYs4/FBQfMKmsVL3B36+ITZDPXG0
 U/k98IEFfU2nBd7WvXPU/23mgICY0oivZ3RL3T17MsLS2IUPycWQ2dt858ZW1rzB0AH8
 bRC7rsXill3MNUQtu60gipMk2FcTZ+MQMu26oX8dyOSAPFqHraLis15HNP/b7jarL0eY
 e8wcXjB4O2rDJj85qvu/jbV8yeEkebhCdCk9g9RQspkqLOTwn7rFfDtACjqYVMnkYMpp
 ty1CvYoJszv7UZTCMcYQCqe/f1HtUasVDt7maTnXZTSbStlbgDBH3QLhxp89gVQxZagP gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7hbg8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 23:38:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DNEZUW007564;
        Wed, 13 Sep 2023 23:38:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f57xtef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 23:38:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DNcQk2004827;
        Wed, 13 Sep 2023 23:38:26 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t0f57xte9-1;
        Wed, 13 Sep 2023 23:38:26 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict with write delegation
Date:   Wed, 13 Sep 2023 16:38:19 -0700
Message-Id: <1694648301-26746-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_18,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=933 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130195
X-Proofpoint-ORIG-GUID: RahC5JrTW8xmnWl0YVBaMUJ3GJ2Ygmoj
X-Proofpoint-GUID: RahC5JrTW8xmnWl0YVBaMUJ3GJ2Ygmoj
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently GETATTR conflict with a write delegation is handled by
recalling the delegation before replying to the GETATTR.

This patch series add supports for CB_GETATTR callback to get the latest
change_info and size information of the file from the client that holds
the delegation to reply to the GETATTR from the second client.

v2:
  . fix kernel test robot report of missing function parameter description
    of nfsd4_deleg_getattr_conflict()

