Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005225EAF51
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 20:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIZSMT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 14:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIZSMF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 14:12:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC152E6C
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 10:59:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QHY6FX022344;
        Mon, 26 Sep 2022 17:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=9Hr5ko7axdLfMmtJZamJoKiKIhfCLeF7okDO8d96iOc=;
 b=WBUUBOW6wP6UWgfM1U77P7BXr8229WM303+sH64b4ZyzGV2kluBvOB/iXC/p+E8Rs8Cf
 Lzzf0g/y29CRm6COkUa5rHh1qNcHc7QhWdzh5z33E66Rymaft1PfhyDpMlXpXL1SBvHb
 tOnHH/7jUj2vpDi7iOUjaXj9ypAhB3iTDu9nqd59Mylg7z+BJFewFWTu5PLX0wU4aF79
 9jhjjtX4X24gRar6u61qDcrf7Q8Ft1WQ3lhMLv5e6wDun8FDBT9tQ4jkjQGvGNywrWEC
 neOYjRamxm3qc2VeogiLw89zYaTDDBEwUsr82W4f8ijQ5329G3AMDWWE2Ztsb5QgZ45I Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwcfhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 17:59:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28QFKnXZ002708;
        Mon, 26 Sep 2022 17:59:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtprtfq74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 17:59:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28QHxLkU037565;
        Mon, 26 Sep 2022 17:59:21 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jtprtfq6x-1;
        Mon, 26 Sep 2022 17:59:21 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/1] NFSD: fix use-after-free on source server when doing inter-server copy
Date:   Mon, 26 Sep 2022 10:59:15 -0700
Message-Id: <1664215156-9970-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260112
X-Proofpoint-ORIG-GUID: gPtMakSU86T1TMedNOVheyFEakdi6rSA
X-Proofpoint-GUID: gPtMakSU86T1TMedNOVheyFEakdi6rSA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

The v3 version simplifies the check for sc_cp_list empty in
nfs4_free_deleg and nfs4_free_ol_stateid, as Jeff pointed out.

Thanks,

Dai Ngo (1):
NFSD: fix use-after-free on source server when doing inter-server copy

 fs/nfsd/nfs4state.c | 5 +++++
 1 file changed, 5 insertions(+)
