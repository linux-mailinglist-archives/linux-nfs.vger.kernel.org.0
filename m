Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED784D98C4
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 11:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbiCOKbm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245482AbiCOKbi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 06:31:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925554EA2B;
        Tue, 15 Mar 2022 03:30:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F8VHN7019883;
        Tue, 15 Mar 2022 10:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=9+tsiUnhqgNO5ONd+hBRgoeTSQbpJJhOqp6Qo4wSKKw=;
 b=W2fIlFn5sk93Pkv6s6sTTLLUswJuu9rVGIPMKLfxpWXH+dojXPyJCIq9xUOZ8m+IcSp8
 lIovThiWAnfM+DRT7EUHK9P/oUqbe9dpYldEfTgQdmTuu2DFMTDrUqXUmz2qKQLtFyAj
 tPXNxqZk2zQDKeZ/2Ccwl7b4bXkV5sXzBFhoC+Fp7u5gmdsf+k3HYRLS+3wC4GLfRW5e
 3BgaUMPloGMGSbKjCRrjVGqob8YDecDJHm8p0nH0DC3D7sOIuzVzlsZFbbxI/QBf8iSQ
 I9z3MthAoHN70QhUVBbFPQiFb+FepANSdkYmitvvM1ATwxWangC+aH5wu1I+ooiN5ejM 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwjmtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 10:30:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FAUNXK067808;
        Tue, 15 Mar 2022 10:30:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3020.oracle.com with ESMTP id 3et657gqdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 10:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjdCxeIUE9Zvy5jr3zhs5EER6vlf8ms7NT349VAsgE6/5OM67aH4LgIHRwEpnlzr+D7hhvF1gyqkgTz1wnV/luZd/DK9hTPxAT7o+jLThFgGI4az9pYY+6QTKMldFMLWTU6JasXiN6RuZl4GBfZJmzOrsqiUk+H7ajx1Y5I5FLwyCTwdpkMIlz2aBfc26Wrm8fE5+Er7+JO6qcoFwHqB0dPHeOu/meflu3AV0HztFVf5dhNzO2TbKWI9m8pU+NRk80Wg+MvUmhvWL+OosgiEy9fsABimj7lYZLO4kHWDBpl2hFPQbCjdrnd6WLanRv63oi852MqKyelt8snsd6ENXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+tsiUnhqgNO5ONd+hBRgoeTSQbpJJhOqp6Qo4wSKKw=;
 b=lh+aFGF2NynRsi32qz0ZAJ4jxXAaytGkAzyPfUwkipxIaBhXMSEtOQOx9V997RdCoZFXnhdEe8UfAgvdVvb2YUGttn4bF3Z3IVP5sbVmycGrc0SfAEDWXBCjRfiQoQb/JHrRwDgz0p5a6xT2Eu6/uIJstfL23HkVwzBDOH1jDi0ghSjt7QDZWqRBIkbQDuKZ8l2gdK9t8bUpVt6xSutJx8SYckzdpN4XIKou01+iI0sUahepG20EnzeyIa1UEgsAEEygspuzBg3YBeYqMDw5kwkbgnHSsuiaKDK2wtNkGcyx66AfVBwMVFVMLkbphYTE6Bt/x4Unxi61jHphmXqG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+tsiUnhqgNO5ONd+hBRgoeTSQbpJJhOqp6Qo4wSKKw=;
 b=WmOcr0xlJsbC/Sk7OVAeZUKuwlMkLGVcFcD7xeR4RKNObVaAO0nRsFc1Spnf+xFHsnezYjp8mOS3VVcylb1X8p4OparFwhjizK61iyFtGbuKHFRi7QETu+4nP0cquGVPYYA4yiJ/oPIWFfWOPk6y79rbj82aaEqIu9Sth7dsWrw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5016.namprd10.prod.outlook.com
 (2603:10b6:408:12e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 10:30:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 10:30:22 +0000
Date:   Tue, 15 Mar 2022 13:30:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] NFSD: prevent underflow in nfssvc_decode_writeargs()
Message-ID: <20220315103009.GA11710@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: VI1PR07CA0133.eurprd07.prod.outlook.com
 (2603:10a6:802:16::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5357f72-ba13-4af1-15e7-08da066ecfa3
X-MS-TrafficTypeDiagnostic: BN0PR10MB5016:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5016C4F51A6DF991A98604B08E109@BN0PR10MB5016.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9mKqNHpxZOk1DpwiPbOSAnwvKmPLH8FSLvNF2pvCiaLJYv6c1AH0eWUp/oKVLRsLdhD2nuuPci9+/MY10bB4BFkBPDRWgpPbCT6AbVM7by7XCiJEEilclNv4LFpz8CGe/VN+r8b+BqNQ9hvdwjOxb8uAnVyrmOcDjIe0QvWpf38tUKWczyTrgD/6/Agyv+b4EOeTtZyS2uTiSPkKo06RPOS6K+jg1QV/44rTY0CrIodjERBNtmTBCdYzOTAATGurSXrGu0VYxZyei30Uo4Xsl3YEM8q0lSRVWyOR33Nk1UoLQ9AtEDQG9toklCEuyA9xXDtVyJMRyy1Kk62WVyZTIbCX19ptBO4Rn7+JU+LoVHyefn45xDDzgrH3aZDx2cn1nmim8jThArObLs9xqthzMlUSE8rrHyWLcTyB3pnZhXKqYtGzBzuamytXPzPSz1aELLcT8Y4CGp3Bvteag6JY+va3GI1bRIPftxOIDYI3piZxIGLjtn3XgjFuDwvlEnGv0ndELAkD49bgj0xGABD1uMME6dPhkklAoMzKfmiHnatalhVI9dEdbnF9afg/1HNYySZwwRziQHZNK7W3EBwkmQbz144Whw+E7a4zdx63c0LeSHI8BbUy3jWLiB0mzdOfPHbuWHkMCXB1pqh+QfDkQQVb74xgDqDzzWvFMXrqL+ZZC2KNP7wJKMY1rqB8WugwbLk8JyOd7bprMZQ2+gxRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(316002)(6862004)(83380400001)(2906002)(450100002)(86362001)(4326008)(8676002)(66946007)(6512007)(1076003)(66476007)(66556008)(6506007)(52116002)(38100700002)(508600001)(6666004)(8936002)(6636002)(9686003)(6486002)(44832011)(26005)(5660300002)(33656002)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GvhZb3W0KtQT896kyArqHOrcAR25XAKTXhqKYlD4vdBOo6S/I9yUz7ysHsuT?=
 =?us-ascii?Q?pm/Pon0SrOvRyJfceRPuZEp/CLdUc/24VGvQu53RDaKcFzNp1H3s2VePp8Jd?=
 =?us-ascii?Q?4vFEfL4xyKrhqwvlYzRmnoCu32nHgrz94IZwQOUZ4z4S2gmgPMSL42VsfbfS?=
 =?us-ascii?Q?TxqzwTMoeIyvrOEpildVD3r0TKaYWak1UC5D3vNL2tOGcMVgLOZoTH+N5Nw3?=
 =?us-ascii?Q?demYwbff8ew+AkWUL50nm0BcuwHk/hTYSkj83S+yQ9csHrB8zXBirL48+4xA?=
 =?us-ascii?Q?YGiiUzXT4ckjqVBxt0/yMDY6zD5ivP42QQb2SejPUytUsh+0mDEkJwepuzPm?=
 =?us-ascii?Q?leQ2v8LgoGO8nMY4Rrg/b+62PYznX80Xiu9AUfRsvFHuTlynDepEerP7HCVR?=
 =?us-ascii?Q?t2wY28M0JnDSEeKXi0aJ4LLYYSX6bOhjRNQViJUidsCWVZI0FVXX9tegeuEA?=
 =?us-ascii?Q?uu9HC+8IKRgf/k66oEERka3kzwmJOMPeoYRHuwbwOmCKPBLUxMFEdgIp/UhG?=
 =?us-ascii?Q?xwM6d/rnMmRmETHMMeHfXwHhr3DcfXrdEz/MJ+BSaJ3kC4EvFI/6Mz7C+iZ5?=
 =?us-ascii?Q?/pohGk1FdveUdzr2EdlTou5VHneDpkhZuc++n1Aczx9xakHEWaH5bnuFmDIC?=
 =?us-ascii?Q?B/x9jsHqlNsUrogR0Ht4DN/jL8gJ71BfjGLApMOhGQwDRHxEzsBMifp9CQ9d?=
 =?us-ascii?Q?HRef6H+PezdqZHcXroB+Wh/JlH4TrxctRXhQtFhzn8KUVW8le96xZbUO7xTE?=
 =?us-ascii?Q?3qanEdYOV5o+BDzR1PqzeRTCZPKXmNMRSCDBCEpYQZWd5ZTmovX3oL2WqQNp?=
 =?us-ascii?Q?2+FDeMpNHoGMPfRvU/jXLqMALe4naOvR3MuRpGLCdGDiXkR0YRnzg9IH6wxf?=
 =?us-ascii?Q?aDdynQ+6RMWuck1+ZLi86LspuswaCaJ3kNWqt1siVIH3hoqGth6c8bP3hsl/?=
 =?us-ascii?Q?w0bHz3dVh9eZ5h6nQW0ON6RxPaZ657AkvJ/oD7pMerYncgEk6rJ0tNHFQuOc?=
 =?us-ascii?Q?3FUeX9XrFNepaElwRavL9nCLqoY9EwOT4c7ki/2LgWGd+UhgtfNeX/3HcoKw?=
 =?us-ascii?Q?8Nv5H84rdADCw9osD92SY16QZfdeH3PEfWi0YUrihJagdIxWXod97HvLCkIZ?=
 =?us-ascii?Q?oS0MS6GqnrMyILtKvQ0XlkjBx+qrpRO7Gs2k0c0WgLE1QoUS0AHZ5fevIHHQ?=
 =?us-ascii?Q?+WZ3jXaErycTL3cVcu/0GnPpOpGfVZ9sjLpkFBY3MWC86V9cHKscd16RrZbD?=
 =?us-ascii?Q?mXAzFRKMlvL+B6LmDDGRHUpoFQOtsyWz/Oig/j2PrqPK1pr/iE/ku1IHPx8r?=
 =?us-ascii?Q?OCRnASDBKLXkl4K2yb1/Bb3XUWglp82EfKwFKRso/1WQwztsOljiLqTx93Wh?=
 =?us-ascii?Q?rzMDQOcUgjbYHq7KfIrG9bxyIs1hxJulQOxzgxxqoBJ3b9amyC3TvmzXMjYy?=
 =?us-ascii?Q?4FlgSQupee1gNbvkkCRUkazNnEj+xfL16SOP9AcW+kfJ8wh3Whffow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5357f72-ba13-4af1-15e7-08da066ecfa3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 10:30:22.7649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEZchRt1H+YNDyrV6HOdqhS5p+Re1XFUAO6ixULL+ioXdO+b6rskBbOuiUXGSak9lfpWp8eHvpWHHd2gOFZ61A0dXLn0uRSae5tRmuqLnJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5016
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150068
X-Proofpoint-GUID: EhcHaFd3xm85XXlQt263ERU9S2pGkiLO
X-Proofpoint-ORIG-GUID: EhcHaFd3xm85XXlQt263ERU9S2pGkiLO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Smatch complains:

	fs/nfsd/nfsxdr.c:341 nfssvc_decode_writeargs()
	warn: no lower bound on 'args->len'

Change the type to unsigned to prevent this issue.

Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: change the type to unsigned instead of adding a check for negatives

 fs/nfsd/nfsproc.c | 2 +-
 fs/nfsd/xdr.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 18b8eb43a19b..fcdab8a8a41f 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -230,7 +230,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 	unsigned long cnt = argp->len;
 	unsigned int nvecs;
 
-	dprintk("nfsd: WRITE    %s %d bytes at %d\n",
+	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
 		SVCFH_fmt(&argp->fh),
 		argp->len, argp->offset);
 
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 528fb299430e..852f71580bd0 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -32,7 +32,7 @@ struct nfsd_readargs {
 struct nfsd_writeargs {
 	svc_fh			fh;
 	__u32			offset;
-	int			len;
+	__u32			len;
 	struct xdr_buf		payload;
 };
 
-- 
2.20.1

