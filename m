Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83279EBEF
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Sep 2023 17:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjIMPCV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Sep 2023 11:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbjIMPCU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Sep 2023 11:02:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BCBAF
        for <linux-nfs@vger.kernel.org>; Wed, 13 Sep 2023 08:02:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DCaaIE029777;
        Wed, 13 Sep 2023 15:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=fvWb8tBKW4JpZXLCgu5hY1GQxM67DLFevT1JfcrvUvs=;
 b=nF53ZG67bUlN4D4Z2CZGXUQa6aPcVsV7jicWHqm6uSBEICKjo0MjmREX6osOlSt5jrVX
 zOzj9u87MCUpCgvqZ7qZ+ApPvK7FJDRndRq5Mhd5vnsUsSUmf07cF1goLJVEtLmnSg/X
 LH32ZmLHElMVISzwPWNQJipGwAzm3pe0WkQzk2OdRS8q4mgb4gQzBYlNR+XvupPYnzeQ
 uo29kSaQcSTJH9oIs2YRrq40dHeEnp4t0DM++s4AZQ/+Td0w/D97nJFJS/vaZoA3L2sU
 +DtIh1eUgXMi4aHlkeMXB7Hjs9sanmK4cBvL+1+E0d+W1y8DZKZ239tYw/3ynImCIKm5 XQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7raf7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 15:02:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DEJDeq032950;
        Wed, 13 Sep 2023 15:02:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkgn1cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 15:02:10 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DF21QN037651;
        Wed, 13 Sep 2023 15:02:10 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t0wkgn1bk-1;
        Wed, 13 Sep 2023 15:02:09 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict with write delegation
Date:   Wed, 13 Sep 2023 08:01:57 -0700
Message-Id: <1694617319-27455-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=796 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130123
X-Proofpoint-ORIG-GUID: WwclcBueEmNSBx52qgNhB3TE2EVrJpq-
X-Proofpoint-GUID: WwclcBueEmNSBx52qgNhB3TE2EVrJpq-
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently GETATTR conflict with a write delegation is handled by
recalling the delegation before replying to the GETATTR.

This patch series add supports for CB_GETATTR callback to get the latest
change_info and size information of the file from the client that holds
the delegation to reply to the GETATTR from the second client.

