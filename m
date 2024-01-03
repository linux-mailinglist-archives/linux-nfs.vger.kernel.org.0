Return-Path: <linux-nfs+bounces-878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3D1822FBD
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 15:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CD4B2199E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA2A1A5A4;
	Wed,  3 Jan 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eDqzDo+r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="enRsMgSy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF041A703;
	Wed,  3 Jan 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403E6B9Q008066;
	Wed, 3 Jan 2024 14:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=ty31OxzFEIIXfu02ZAM494AIgjAh/oo9t4NUz5l5uJc=;
 b=eDqzDo+rChclGgMGLkyrkL6VPlu2bohX/lOqgc2fQBNsajqIF1tNqgQlSbFfuNfvBE03
 KEao9g6tqhFbI4zsmRnbFhj9nwR1kIERN+U0eFfPUAo5/xtjOhtknQswTj+VRVMIiMw6
 x+QznMHHoFuglLyXDCBck/UDVvH+ag6oHF+JteUsgI3Ps84mUU4mBqihbFbCba38Riy/
 8N+zH2lfom1JlHhRwSflzewJsc4rm8cb7yjlMmUGZQBYtnvdIYBI3XDO+nGiO7WQtHiG
 grNMAEP/AAQttsgTufIG5q8gtB3dISraxkVXVAOXmIK1z/EaZsqStPzqzDrNlFjY3UfF eQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3va9t255yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jan 2024 14:42:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 403EYUWJ012040;
	Wed, 3 Jan 2024 14:42:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vd931tbj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jan 2024 14:42:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4a5CfJmY5LlZTe2/vNzZLBYCqwYIKELgoHG1fjzY9Qrg9WXPSDSYlYKSatE3btr3gyqe62eWfd0KIOFsHTflCFqVt8GZJSmbtQ3Id8MVNrSnDpvmAKPvNAchba2EXdveb3rBvxa8oPeKdCgADyCJljUXNXbBXTNV9HbaBs3H43xIyRNGsBq59nW1FKTfrPA+A1PMxwQI+1JrG+aXjKLLwf+vavF9fSwxLvl7rxFyFoXGZ7Ok4k0trPncNN63nE+OA5d1uhGeWgxNDATxb/6FCDjYubhwabivo8zjVKrwwXzJd8Mx1wr1ZaHCCyxwQ4pYJkowfHF1mu0nimziOOOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty31OxzFEIIXfu02ZAM494AIgjAh/oo9t4NUz5l5uJc=;
 b=g8J5bvofE3kAAHoQv7q7eUSot0dCstKYXK74Sk5ypDKJsW/8yfe7JuyFV2/W4Vj+mnqtXdV4R8pqlG2sG1k6y+xMNqFeecOexerNV2ZVpds+9mVszmi85tCqWGHv8v6/sOO2yKzLk9vO5cwyxcv9q5S5nYipw4XPDC1HXXT+6YIZVvOMbWiJuqLmJxUCRJn/FK+kK7n7CwUd58yXNzVDOmLUjVFs+9lPTDErPBjEw7XX/HGwTZjNDSe4uFAcA9EHn0DUDiSUjyNmQhefNeG4TWahNsHZx1EDyukVNx0WEM2HYsyfuEKIs3/XUziKsf1ie+rHzk0A3CB88q9flWiVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty31OxzFEIIXfu02ZAM494AIgjAh/oo9t4NUz5l5uJc=;
 b=enRsMgSyiCvx7EAKPusmkh81pMYNBgt90spCR4gT08Lki0oG9yr0jheTsTgMMs9B0sB5kFwWH7TnAVtc8DkGjqdbfrVlG/31B4wK1bY3o0gEQqDK2HNiM8dXEwkqrm5F0jHp793uA3E2eET2u+/X+rkVP2KneODqsQSMKtBKOdQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7068.namprd10.prod.outlook.com (2603:10b6:8:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 14:42:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 14:42:20 +0000
Date: Wed, 3 Jan 2024 09:42:16 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <nnn@google.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] xprtrdma: removed asm-generic headers from verbs.c
Message-ID: <ZZVySJF2rXI/qJQx@tissot.1015granger.net>
References: <20240102-verbs-v2-1-710de1867c77@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102-verbs-v2-1-710de1867c77@google.com>
X-ClientProxiedBy: CH0P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee37611-c914-41f3-314f-08dc0c6a30c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X7yeAcQPDxaY3Rvu3to3cSsQxhTwDnyxpBYUE+JWq4hKWG76qsDYHzI3BtJorc2yWOAuqbd3NNHtfEQPax6XLj9GvMvJty1OlZqoG9GeW5Mi3mu6vgKkjL8Sq8Dz05bXFl4KI1w1auICeundQ9n7Mrtqj/eiSs2/L8ob6HXfI2ceTc2rjpXGHTrZCBZBJ4RP6KyIi4oYQMBkQ60jj+jz5eXA4Ybnp5j25RmfgKcCfUC18cUU8/iedBUq4CsKDhLH2EMVVOmPPVaqVjrzH/ZlJF8Tdm0WY4J/8cacMK+wHmSq47FqUr6JBEJeFqT2upJAypucCzknVN8WO+QEICSxl2zKwGVK/N4fRnrmK2w221tBOKXUuDdSrILq4AOVpK2o2V5HuX7CTFjkjOTNg5VJIunR4BJIDF4ZJTbc77LnG1hU0fCwLv3QpeQYO/qbgC5Nm1z5Ko2ysjdsNFrL4gdWMEulhOAbYLFbWYvoJS1iTKlpUSXoxGMxquJHyWDXJY7lf2C41N4kEcPqWQvkdHM3XZ+V3d4iMKx9HgPFfuE+gt651t8kHzToKpJlbmvsY4H53x/4vqFO0tzzfCwRtyh4bdHHzKjHc/IoSPXz5r5EHiU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(7416002)(5660300002)(38100700002)(44832011)(26005)(6486002)(966005)(478600001)(6916009)(83380400001)(66946007)(66556008)(66476007)(6512007)(6506007)(9686003)(41300700001)(6666004)(8676002)(8936002)(86362001)(4326008)(316002)(54906003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l7+iNuyS/cBsrb7YBOE34f6rseslaRKBosHEbffUShKsppbq3bndXQOmTBx+?=
 =?us-ascii?Q?Vx3JExUMK7YRMBsi96RPYilmsA1Xvj9GInv+rQA6icSPog5bylHqUF2+BWqu?=
 =?us-ascii?Q?M5eV+X8TjI6MT1HNFaIcClms9lLTTPq8RMEJNzijQrQ16lRUYx5wyptK8YLf?=
 =?us-ascii?Q?sUy+oyFpmFLTCTN/bNQYsgEt3zlcWsUaI46XJNLUXRoFjGEsyHxg7UBTqw4L?=
 =?us-ascii?Q?X/RTr0VYOVjI6xVTwfZxVhThL6PV5BgXJw0VGQq3KUFjy0yFF8PYEHtsR5RI?=
 =?us-ascii?Q?GFm4lzXQ+rGtKSAX0XDWZ8D2tXtjY/JWsjNLiEwzYoVbw6hT96AUiO8NUo3k?=
 =?us-ascii?Q?x84pjXkQvPMPF+PBPavLw/0t1CnnZmDx6u4npOSSWsnfdtm1Q8RPFjpo8RAr?=
 =?us-ascii?Q?ZN89HDpIppRXmAthFfL2++7tW3z+U17PdGyKtlFcnu85XqfGIIrPzRY2kTEd?=
 =?us-ascii?Q?EehnQfxR6o8cVQkStsEG9+AgyDkepDzrlMsNmI2M9P1xzyLM+YmT18Ptba+8?=
 =?us-ascii?Q?qWFy/kLKACIpB9kaA6zBmbK7uJKFPF6gYrsK50w6SN0IIoqSSFF5SFSy3QF3?=
 =?us-ascii?Q?7/FDLRKzk+sKfz8P5PU/vWwvkW2tnD1NEYmLuB5k7OGOxAweczaxBCJlHq77?=
 =?us-ascii?Q?T1uvnby2ezFiDsoxMf/6SqA6nnx6WnuEeGVUVIqv/V8lrXMcdnP/rQalU881?=
 =?us-ascii?Q?g/JHHjZ4woX/MTh08N1qi47GCAPmp2zZP8jsevY0kmIETwjOy8iFG7Bz7V3M?=
 =?us-ascii?Q?YPz9LYqPazxh1TTugruIAA1Zp0A4Yuhj+iumDY9nV523D0kUt/GKr1jGZBs0?=
 =?us-ascii?Q?xuxoB8LBB2tDwW5mrc376eCLFx/O1Ae9MLBjdxO8XFA1W32M+GNvjOqBioQ3?=
 =?us-ascii?Q?XcCQfx9D9R61WzrgXsH7TIyN2I27eK00qzfSkzRjTt6qUlBowvhqRnObafhl?=
 =?us-ascii?Q?2zqcAlQzV0Le3naEQ0e8DZ3LntjWr+jgXTYGLZwWpvwLOVayRh5jyoTtxajc?=
 =?us-ascii?Q?o+QFxHoXEJOFplcrqLYeYQA2l9eMorXNu3/Yyv2D/ddyDgikeeXF/L/uUP6D?=
 =?us-ascii?Q?Hc1I+wNKY7Cjgd1TmhrXLakY4IcIAqaIrM4rytqV9ymJtfuHfq+wZGdvdWMO?=
 =?us-ascii?Q?oBhj3OxPq8rwhM2C+FZJ9F6Vb64fCuTapKCJzWM9MihVPUik7WC0tRrocejK?=
 =?us-ascii?Q?lun5lcsZ6XRlQGemuvlP0lKNoRvJ2aWUlviISjCB5XiVwAQx3kqzQ1MiFBE8?=
 =?us-ascii?Q?wWVkRzpO3RceufT6PGA0pXo/izk3t/4VrdHuED8SKkGC7PJyH7OwSaPUxOJu?=
 =?us-ascii?Q?OwmlHv9AxWcuam/ESL1UmE8IuZUJjlCaJ8JmvExmZjrcIm5V1p8FlS2lPo+x?=
 =?us-ascii?Q?ZjJqBzWXytf/0KjNfTb4lUlGhAIxP5LPfVJxpY5e+CeL6FzZzxWqKUnivWPt?=
 =?us-ascii?Q?om5aK3G9Vizaq9Y7y8NlJ7F2I2oLs6FPG9JII1fCMQ3VW77xdpsbzUeIU9P0?=
 =?us-ascii?Q?tndEPFb8dIojjMZaF4wWBMpZjJv2qWaKtvDnl8MXFCOtMsczUwgp9HNrZS8A?=
 =?us-ascii?Q?wBhp8Nw2ZfgDfKrZ67+VTPE22edbNNEeLYQBd0GQ8qvqutwQw8EjqDTSHqVy?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kmt/fG3tzwAVEjWRQwgr7QLAmYI+sjM8C5jDUluOXK0DujDOvEJ2U0nLPBoj94MY3lawUH9rIIrOBCvwKZkdFkSqRUpVheR4vPDG4zMOHryaINiLjPh05pUjZkVQQhFq3k877omBY4u+3QK7PHw0W9CST2gvdaxB06EkAtW3NQBCrbq6HS4e3E8JP1aPLFWKECh88DZzzIR6aGCq/ezV4U8hVgVyA7iTOininCxVbch6lSNsY0Q6XoTG6ks/LFOXXTxYwqv2h9EeK9/Eil/EmydfuIKiMNqnATmLDOsOLI3nKnNp85CBcJXiWS4x3ifpJq2DfG0nSiWNOeqio/tUfzB0xiFeVy2PS7Y0/HX4auAPznqJhKaEMugCHdIMejRRYBRFDADsUeUx7KvmXLD6bojXQ0cSfp6gbCtEg88MR1RadVymBApDsZW1bFKO8ayFi0mYOtWRPYITtoVecBe4cGc8FsTQOv2GilB3ujjXdcqMgD7qJmNOgQzvJoJdAqcHt/eQyTYvNX1YfEu7soF3/O/iPIMYW4/YawS4+3KajjEJ2Tk4PRGYEibH4YpYxdmhNu64WLV1gmwkjYSJdOWg5fb0UJWunu3CufuQQKkPZ7o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee37611-c914-41f3-314f-08dc0c6a30c5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 14:42:20.6778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6sw0Y/6GAsEWB5ksEsRXilhh87+cDayiI7UvDrmvW8oB2nIIc/KCso5btuuTVKt0mNIzPzljE2m4ryIWNWk3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_07,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401030120
X-Proofpoint-GUID: B5ZDvTmzExakSGF31s3aWSKP9_N2OrWf
X-Proofpoint-ORIG-GUID: B5ZDvTmzExakSGF31s3aWSKP9_N2OrWf

On Tue, Jan 02, 2024 at 05:22:18PM -0500, Tanzir Hasan wrote:
> asm-generic/barrier.h and asm/bitops.h are already brought into the
> file through the header linux/sunrpc/svc_rdma.h and the file can
> still be built with their removal. They have been replaced with the
> preferred linux/bitops.h and asm/barrier.h to remove the need for the
> asm-generic header.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> Changes in v2:
> - Added asm/barrier.h and linux/bitops.h to not conflict with rule 1 of
>   submit-checklist
> - Link to v1: https://lore.kernel.org/r/20231226-verbs-v1-1-3a2cecf11afd@google.com
> ---
>  net/sunrpc/xprtrdma/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 28c0771c4e8c..b4c1d874fc7e 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -49,14 +49,14 @@
>   *  o buffer memory
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
>  #include <linux/sunrpc/addr.h>
>  #include <linux/sunrpc/svc_rdma.h>
>  #include <linux/log2.h>
>  
> -#include <asm-generic/barrier.h>
> -#include <asm/bitops.h>
> +#include <asm/barrier.h>
>  
>  #include <rdma/ib_cm.h>
>  
> 
> ---
> base-commit: fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
> change-id: 20231226-verbs-30800631d3f1
> 
> Best regards,
> -- 
> Tanzir Hasan <tanzirh@google.com>
> 

-- 
Chuck Lever

