Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8605A4079
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 02:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiH2Aru (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Aug 2022 20:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiH2Art (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Aug 2022 20:47:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5462B32EC0
        for <linux-nfs@vger.kernel.org>; Sun, 28 Aug 2022 17:47:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27SABWln014994
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 00:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=Z/Ee3RfMUSYvs8kDjQ9CGiHg4EFfXyjyk2vcU+2br7M=;
 b=r7NBcTXaCQEsjsv2II0XS009iVJL1CYq0PthIb94BqVTaeCmK1LD2DONyQV+x/FdJvDc
 eK9HIPC2iD/twrvAbzzECXwviNmX01KQNIdFR88CdZckWAXZDRAXRlbnaIhVeSLQIUZK
 d/oFVLPBC0TraPvped4W49+4hnEy5Z7Unv2kJkX4zeYae3YL8j7NNZG+H6QLBgTNY3QW
 Q6WO79e2A7Etxjwh8+zid0TDPNmLgnA6dwjvpcRF39NCgmJ9octLSpyySZe0ptJiKOXF
 cOio7ErRjxcVaDAVbabhI/CfB7EwYEmL14/ITFyzlluhAp7MdWDhrbdmgVxQDTzD19iG Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0j1d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 00:47:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27SM0eru019484
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 00:47:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q1wrgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 00:47:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27T0hqc4003275
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 00:47:45 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3j79q1wrgs-1;
        Mon, 29 Aug 2022 00:47:45 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] NFSD: memory shrinker for NFSv4 clients
Date:   Sun, 28 Aug 2022 17:47:41 -0700
Message-Id: <1661734063-22023-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-28_16,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=797 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290002
X-Proofpoint-GUID: rJzrsfjyVbazTC5Tn46EfbFehXQgBWWg
X-Proofpoint-ORIG-GUID: rJzrsfjyVbazTC5Tn46EfbFehXQgBWWg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch series implements the memory shrinker for NFSv4 clients
to react to system low memory condition.

The memory shrinker's count callback is used to trigger the laundromat.
The actual work of destroying the expired clients is done by the
laundromat itself. We can not destroying the expired clients on the
memory shrinler's scan callback context to avoid possible deadlock.

By destroying the expired clients, all states associated with these
clients are also released.

v2:
. fix kernel test robot errors in nfsd.h when CONFIG_NFSD_V4 not defined.

---

Dai Ngo (2):
      NFSD: keep track of the number of courtesy clients in the system
      NFSD: add shrinker to reap courtesy clients on low memory condition

 fs/nfsd/netns.h     |  5 ++++
 fs/nfsd/nfs4state.c | 69 ++++++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/nfsctl.c    |  6 +++--
 fs/nfsd/nfsd.h      |  9 +++++--
 4 files changed, 77 insertions(+), 12 deletions(-)
