Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C074D9ECD
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 16:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349614AbiCOPfk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346240AbiCOPfi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 11:35:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CECC522E9;
        Tue, 15 Mar 2022 08:34:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FD59Cl029145;
        Tue, 15 Mar 2022 15:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Bwbsr/f91QSg+M4RWVHipYXYwTJs7E+PTCncDKWa6fA=;
 b=Nf9/5UMtTro9zO9wyCxTJkCtfhAvRL7EAqaUIV/SGfMGmwwO2vyP4OC3jrpf+cnFS0Fb
 NGNMj07Y+B8sH21oOzsATwwsCWXxM0iOypw8nfZOashwF3X0H1HZ4Jo1/BYpmnmLS7NM
 J0FingdzCCESfg6RA2MsQyBd3jx2URdfuBb/kW9A20VtvwZYiLU7mpKQE84cBJxmDtpA
 hz/QPG9/jd9+p5k0hR4tl/thkQWgK9qYzKv6Jg5w9gobVNFN9dCWP+Cb0ikf+qF7OUT1
 v57IVd+mAgVSsliePpRTzkz5mSsv1N0MOuaNTFVzKgu/J3o1BCqa9QoIVqN2+aSTIhZF bQ== 
Received: from userp3030.oracle.com ([156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwkdd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 15:34:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FFV55k105239;
        Tue, 15 Mar 2022 15:34:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3030.oracle.com with ESMTP id 3et65pnu8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 15:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDD1LW3jjv3BZp6pPbomMYBM4oD4AXNmuZiQU64kNrWaQIKnnRjxriYu5jwsU6hIzD0cCDojLu7SN9Fi/MXIoM2ptKleBli6qQ76e+FhqfeVK7m4hjSC1mcVHA3esdRgzWT048p1G6F66S1LHI6goiM20XEB+5pDkSkK3poMs4lZlAPpFh3bERiOJB6Rmz0UqXOlpty3fEKu93w76M6qwd5BNTkZhky3hAWQc0sGVvvBQMBB9CCIqMZKiqrv5g+qkKGeAQVUf6ckiY3aFHzIpYoufzNj9JlDIXq60VlmbxcAhD0XRJJi9UBo0IkFwCkv3p3ATsv4nw9Of3pazbtRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwbsr/f91QSg+M4RWVHipYXYwTJs7E+PTCncDKWa6fA=;
 b=dRT2jzFJutoYkIlwKvIfrIkPX7ShKQamC5JKONCrnIaca25GnJIskHkDIDqSlfVLCJDxMKleMfgp8REs6ztaz5YjFREtM/xHS4LOA7exsftupzAyJPeVKrVMf4PEdsgCpontnuInlyOld8RYxTlEMzpPim2khPKM4WG4lkN867vIuF2skLzRPH660H3qRjH0zDw1xJJ1YbuKK7Mc3pYDmThmY9YhR8UeeNU3nVHL2PjXZOepTNzNfTMzWtgtUlatLyGU5UGIlYhf84J9kvI4TzDLVgroyoJZrSNTqTTA7btFCYsH50n2fOFJEtXEtU4z8M+6FAHmJfNJAILnZxsi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwbsr/f91QSg+M4RWVHipYXYwTJs7E+PTCncDKWa6fA=;
 b=mMZ9jYEgQXZtoN3MWtqFwf31ETykGTVMZSEGi9HI2lwnkUYRAqhqdeIUtBrSC4Ms/8k+68qlnc57RqNkDK6G7kNEhHuwY/AM83zU+VBXmwLkPDlzRkbeGm49HPeA1bYEmXC3JTvgHsB1qqzb+E2/zGMolD7ovtXOZuzJQHyeNrc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2745.namprd10.prod.outlook.com
 (2603:10b6:5:b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 15:34:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 15:34:17 +0000
Date:   Tue, 15 Mar 2022 18:34:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] NFSD: prevent integer overflow on 32 bit systems
Message-ID: <20220315153406.GA1527@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44cd49a0-8561-4c06-1072-08da0699441f
X-MS-TrafficTypeDiagnostic: DM6PR10MB2745:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2745230062E05F608B7793B58E109@DM6PR10MB2745.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i99+LZ1S/OnBJoounfLvu3AEYFU3boBE1w4fxrZqw1IjevS/qggA0MLANTusIP9IZfMgsWGvPzQuo3z1JwrkiBVlSDyzkEYsVpvXk31jdcg33scjyFTAiPXlmwjlO2n4nzgtEfifeMcWVm37s8g0p2FzWt5spBFuAv/5rOo0xD+4rRlHlso6Sy6RNSXVXycRvkBzIc9O6aEoNezkziAol36RwZsJqvuJUxdOWa/D9e8H4mAS1ITN7XWHmpdDqqrVqNLK1mJNCdhG1+JGKYCg3PenUz2LhcdYV5TrmXCe8FQerPwE5nckP484ueQXVHUgej8Q8+ZDYiKNKTsunpwl3EDq/+UQOBSG2Y3eWSwaCcxZdaCfJQ0Z42T0hPg1apKo3lHUduBJ/uGPUp8SiWgHnJidU42bg69ad3ikbbyKmzXtSTnX5F/2X15ypgrCnUEx+pikMK8c6OcAhI5tctiXuhZ+82vNaeBzt3wVfg0QWDBvlkKQXkpI5dS6hBvEBS/Des+nWN341D0OJpJ9Pf35hsACLzeN5pemtLVmwACX46HAsKQ+T5ChIc8zIuQBnAEfS63t+eI+xK8UJ6qPAhR/J47c7XhOwj46CIPzslQ3ys6OL1/zEKbrkpKO4pBsoo3hWSkU6XfjBsAZKPwWO2tDYc83RhwPlI1BwhwpZR777IhzrofGSblv8fWzDtA9aFw/xPTCffPOsVB1x8QT6CRlUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(44832011)(38350700002)(508600001)(38100700002)(4744005)(4326008)(6862004)(66556008)(8676002)(66476007)(8936002)(66946007)(33656002)(5660300002)(316002)(2906002)(54906003)(6636002)(52116002)(6512007)(6666004)(6506007)(9686003)(86362001)(1076003)(33716001)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xH6OBuuGHsKvEUhN9JH3I7ekYls695XFhv5zI+xtqeI04lXbUkJJyNVZIuP9?=
 =?us-ascii?Q?H6jjn0z7xHC6em9UqRSprwEcFLJslaJj4H84/WJgdQaaMc31iTZifluXaBFT?=
 =?us-ascii?Q?68aJcXGl2IPmaQD9Q5CehcHXaa9B4AMJxDmczeXOgX0c6xxjWLaNZjLTlLw5?=
 =?us-ascii?Q?M48iSHiTE8qQe3Y+BlFFekKz8ahKvF0zI51woBYNKbt81slDg57xiXdczb7z?=
 =?us-ascii?Q?QziJ26CfmKIySyBKrcXWnpPq9VQt/Sx9/pFyfAp++uqZTy6pCm5Kmi3FeNhE?=
 =?us-ascii?Q?Ur1U7+IBpTAMgNdPqz95YawF618C0bx9a6VG3LCL45mOOy/6Zwt2mTypLW9n?=
 =?us-ascii?Q?64IUDgszdB9Tod32AJL/aXfl1NaFkPPVG4lQDosSPwp0pBcn4ZQ7W4WrS1Uh?=
 =?us-ascii?Q?ZU3gjQfhjlncVBbYZ7UaFY38p2HIPhTt14vgfG71VIeuDVUyLxTXpKDu6aSX?=
 =?us-ascii?Q?1g3rA23XlGWYOMiZZdTPTBT0KY5FZWNINQ3otTD7Z1LMC6FSrGjCnLWFTg2a?=
 =?us-ascii?Q?a/8CzUCXsYh8Rh/i+TDVpDE7bStzcPCYjxIBP7USjHRxHD8CllYQm7/lpWJ/?=
 =?us-ascii?Q?eOLQwH4d9G0Ib12m5hnE86XMrMTuoZOaT3iInBsZrMy4Cu8zqkH0pz2mAB/g?=
 =?us-ascii?Q?c8bzVdAInibTc/xRUqpkP2AR3IJat+E72p1Sniw8Q6/MT5b5oTUpRRqdlBx0?=
 =?us-ascii?Q?8RagCULBVVIdRRPkuzbSyk3QMw2jg42MVNrK/TKUVtCwvh+Xj2w4XnFECmzm?=
 =?us-ascii?Q?mS4tTt8maKFp/52XkRh4pBowJS7rMus55MlieSJmemccI4PZUXDtY+nuSD7+?=
 =?us-ascii?Q?PMWy4WBVpqP/96ucdw0IHTOmXXZIlct/a4GXHiDjaBNNZHwmwFLAVxFqJwit?=
 =?us-ascii?Q?1zZpYw7T8lL6kI5Hzzn3ASGyUCFQ616n+nCee+i1kuBkrCqPTiNRtn3dKY/U?=
 =?us-ascii?Q?zRV2TfD81/vpVHybJ8uP4Vyc+qJE/v82YlwV69I5MqliAKwltI9KRdMCI3oR?=
 =?us-ascii?Q?iWj6Tp5soWU1+bGwLfSImLaL68b3p1IaTj+XILL7RrO1uCOtSdtzJv1+u8cr?=
 =?us-ascii?Q?6BTlRtIsIME/eZhZSIu/Rndb+bAoouGNyxfk5q3g/qvlkOPM5m2mwDO6mGfL?=
 =?us-ascii?Q?VduqDMLHJCroBVvU4XTGhueXdAG/UY+q5Zo1gkv+mmB9Fl8Wyjrn4h8+C5ik?=
 =?us-ascii?Q?hy3SkI5dVg0rxLqa/4QPfz1uMd4vAoaLgT0etPT25hDGiy1eLCIOHVkUhUUE?=
 =?us-ascii?Q?U/GJj/O+pT4hpAKoi9SPechQXNHJX/ZCM1x8LC2fpIypwB+Ck9gvsFMAJoS6?=
 =?us-ascii?Q?FJzqgP0Dxmzz3tCf7LHNjIA5AGeFz4L1gnArVa6Qu8YJ5TSgCFMq00jrryyo?=
 =?us-ascii?Q?XGtDZI1Rn6MiSU99jPxpkyJf5TIrYvvgm3xRIuyfgt5oZ4+LRfaVD5lQkqQ5?=
 =?us-ascii?Q?4lRil6WZ8+9Ar9/Lye+CIXy7l/E8M2y8HSCXT/lJyYgeLtALJPhiLw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cd49a0-8561-4c06-1072-08da0699441f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:34:17.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaKwqNJYoZr70rWwdovcKQ1l1tyh3Yq61kKxPzxD7bOa0oLwqk9Kr1rA04kPFvO0gDwjSZPADTzeZkD2V9BIuv0vUyB2n0/psdmvYNBaxVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2745
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150101
X-Proofpoint-GUID: S5eWYUHocTAy8walgiDZ4EqEcWsyOmVo
X-Proofpoint-ORIG-GUID: S5eWYUHocTAy8walgiDZ4EqEcWsyOmVo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On a 32 bit system, the "len * sizeof(*p)" operation can have an
integer overflow.

c: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: add stable to the CC.  Use SIZE_MAX.

 include/linux/sunrpc/xdr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index b519609af1d0..4417f667c757 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -731,6 +731,8 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
 
 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
 		return -EBADMSG;
+	if (len > SIZE_MAX / sizeof(*p))
+		return -EBADMSG;
 	p = xdr_inline_decode(xdr, len * sizeof(*p));
 	if (unlikely(!p))
 		return -EBADMSG;
-- 
2.20.1

