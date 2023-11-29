Return-Path: <linux-nfs+bounces-179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F73D7FDF56
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 19:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84EC1B21027
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB95374FE;
	Wed, 29 Nov 2023 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NdfyvHhr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hqeXxS/a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE01610F;
	Wed, 29 Nov 2023 10:31:31 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATFmdZC008169;
	Wed, 29 Nov 2023 18:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=aW9KLBBneJjEIiiZd05/QUWu4cRAmLOhir1hjfBQFB4=;
 b=NdfyvHhrxQaVmTD2q4gbzIE6vd7Vu7IU424ECfIxcSWTC4RRCSthQU/KVJohbCB51a+d
 oC17h8WkmuCBZdZPzTNU0M2r5O8KdnBS+jkhCeHfC1O2vg609pjC21ynkXbgie6boJVU
 a/RdcdbonItfXxlkzpGy1Z6BMdCYdNgqnpERPlkwHWvg7HtCjpJEyAu4iXQ9ImkkKbhf
 Xe9e2JzgX8a6UQ928yUiXeq09DSYTe0VWlZ3xyg8tYZ225DCllEXX1agA4RjZdUwgjf/
 vYT3Poo9gpjjUhdhyei4jBEgPzOXgvaw5JNImD2wFye5Xf33WEhlp4CHy/jJ253LZc7O Qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7bf1j1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 18:31:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATHbRIg001408;
	Wed, 29 Nov 2023 18:31:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cf9kph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 18:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6R4ZoRYcxKHQb1WK3X1KXwW9yRaLthDheBiJ9978aCAVsQr3+ENnqAfmKnvFyrqvwlM1WSGBnyz0v8C7X7G+uBa258S98m+12vMnhAUpZBZYhMhz8H+NY5rhLP+XShVz3D9ehJkyx7gNsa76R7m6bJG/yPmwIlcGezR1K0aF+pHvK/JuCcyH/WxJwcH+gFWHBTAylcbxRyQ3JDFIVLUuh7NES/sX7LMQ+hgB/ULfRMFLeF9RApQ2CFy++Jd8NKdEp/owvxQpQE4qaPNucsUVpG5P5xM45lBWyfEN4ZFuyGWi5jA+rEJ+Yh7l18CDbdJgQIdVrCMhqnqL3m8qNqAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aW9KLBBneJjEIiiZd05/QUWu4cRAmLOhir1hjfBQFB4=;
 b=jIRZ+VVSH5WAihsRPjab7N7IWBb28H3H3Tt8zkDkZmeO++zLJ/4BG609DJcKszBDG+AyXKAWSe7BSBAYUzYmWT2nLF+4WWOkxWowNemXKUTsBvrbFJS/qw1LRCtweTRl+lGpMqen4yzVgcqhaZtTwcRG4ajtLIL7HlYxrGnRu+T/XoKv6zof4h0uOLcLYU/1sbOkKNaP/otohUJ0qpHrTQo1zzQcxPQJLu2JnG+jaEeS/ivJhfDmB0l0hBKG2Pz2gvfCroCP4s+LRZ5mjUA35avGA3YIZ+dhrSD1Z16uBxQcT5ApgnM6SbTMh6oEiZ8hYrH4wjOlAUO3CjZSOYDOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW9KLBBneJjEIiiZd05/QUWu4cRAmLOhir1hjfBQFB4=;
 b=hqeXxS/ajkxbEqSc1c/gCBhAP3fdNibKC5sZzwkgtsjehRH9v5Q171Anjpw+U6adf4wcevRzOwO5/lysUDlOJcoVD98SaWK5udIeLLaFowCU1Nm0y3NaV50dfR2CxLM715iWGf6/vuv4rkGtP7spYslbfrmeK2sZVjOQf1Z92Ro=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7817.namprd10.prod.outlook.com (2603:10b6:408:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 18:31:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 18:31:20 +0000
Date: Wed, 29 Nov 2023 13:31:17 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, neilb@suse.de, netdev@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH v5 1/3] NFSD: convert write_threads to netlink command
Message-ID: <ZWeDdSVWcrUxSU7L@tissot.1015granger.net>
References: <cover.1701277475.git.lorenzo@kernel.org>
 <d9461e660b5f47df7b869f0f809485c9b4bf60ea.1701277475.git.lorenzo@kernel.org>
 <ffbbdd1ce7c87b02f75095f0146924d996268957.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffbbdd1ce7c87b02f75095f0146924d996268957.camel@kernel.org>
X-ClientProxiedBy: CH2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:610:20::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: aacae431-3594-42ee-591d-08dbf10961e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	v9v1BR7VR904o12IEY/URZMqLnCqRBqq/rAm+sLpezj7mELJmviOM73CK4QPxHLbrUkPuzb13uVBUQYOkMI4HKxCNoPKB/xmUEeEGtlPPtoAPZPsJJ2MjGE/VnS3BAxx517R9JpFU6H9ml+lXTwhcyM1BhcTwgOKqc4z9K4rGPDnlZPyBGdJN559T3GxZW11UnR4nY4e0KBeofCFFMt1aZVC1FvfdnDzPUyx2HwcqR6NLky4C4z3E6xbD43U2e9ifjJcCJ2cAEEyI9chnBrJ/s7gBMh4ZrOLyDhfp9UqruOvMrBmrf3G5i4mWHmB6JMJj1cAMIw3lnjQfhaivBX/pfHWX0YvjlQzKE1/ywt46Go/xAkOaFsAfuWuZUFMTgAMZxYRLLfWn7dPKpjUa8y6cJ1R3DqxiOYlWZq1D6Bhqtu9mzQ+4HuPciBxnMwHSNipzVw4HG7TjO6fhN7YLqpfxxEJxPR45exu2Q2G/J0xT1jnLT/w3/LGVHQuHhr6DVtAmDZNuSuaty2OWh13zgFrc/ylGTYVK/XngqEZqVbka/jFuhuqoWESAbDEiqZjmX62
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6506007)(6512007)(38100700002)(6486002)(6666004)(30864003)(9686003)(478600001)(5660300002)(83380400001)(41300700001)(2906002)(4001150100001)(66556008)(66946007)(316002)(6916009)(44832011)(8676002)(8936002)(66476007)(4326008)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BnyqhlzI79VGibdguRUw9C1HXfB5omEN1srauS/vub+CFz1f7eJwcS5HcS0z?=
 =?us-ascii?Q?Z1eSe/jNNm7pELjnYbSsk9ebuh0BxbsUc4Uvi+Es/8wST2zZrckNg2QQV69q?=
 =?us-ascii?Q?a760mRVjtTq/dFWCXoggbvX9PXeB4fwSXC0G6SmFBwtV+vnDBE/LPfBxq/ba?=
 =?us-ascii?Q?OChDFZjm/ae6u+83Tm9XFjgv1PvkZ78qyUwdYbrGGjgbpz/rRa7g4nbhlG86?=
 =?us-ascii?Q?57aKJCHeK2hFBUbraCLeSTxLkGarGkuRrDhVEomHYy5r6T+gEP1JPeLiFg2j?=
 =?us-ascii?Q?4ZCk6p4tSIa+BKROHjFXtAKv2PG3XHFvHF9P0y7PjdQl1a3Q4Z2k0AYkspWI?=
 =?us-ascii?Q?5tXDarNlXxpCyACYF4w1SLTMoyZMCNarcBR1oQEsx19ci36CBWgI00dShRHX?=
 =?us-ascii?Q?8nHtuGLswt2AiaB+q9yrWlEBy2vUbCoumAqd9WVA84f9+WxkKtfoKWRR6IKg?=
 =?us-ascii?Q?bbnhgazw3WatOxmZBWfArgHqa2ppg7lY1yRWgebv5qK6fLcRBEk81QAXZiNS?=
 =?us-ascii?Q?ZOQJLu1NyNm+vOTv53AeFhjrYCx4f2gVCx8WJ95ckf7f1qvYaVOSofcrarwH?=
 =?us-ascii?Q?9oX44fUxryxnqF4OZnm9fmh/7Nvgn26oqD8jI20xipFsCE6s/bdt4QHnCexz?=
 =?us-ascii?Q?RgZ/2s6uqcazKZihSy8hZZL01mIjqoJhSVxDY3TgrLZrR8lTRQw44NIU9nol?=
 =?us-ascii?Q?LjNTL8F36O2E8ZBOEP9nLqboXnYFH0kXtXuKVrw4cEAX8Aivce+2evL8A8/w?=
 =?us-ascii?Q?dZHwIj49/spsSibL358ERjAAdnPVyse8fHwy9rxXCI/R1X6OCKOFwXzXO6wG?=
 =?us-ascii?Q?ltkhPoIf1ySY1rr9uEbcdjW2YecOzW1SvSs8DUEPKAgmNjHyDroqVgxu9agv?=
 =?us-ascii?Q?UdQIB+mFvBWU7lAU2T5amWc86BgW83eA2p5Lp2w95CaAJbRMr+5ZRK6QQIdN?=
 =?us-ascii?Q?5gUtI6StGqX5vx4Nsecl2MJF/GbhuPYpA1FP1RSN3P2WXXkr2ELsoK43ronL?=
 =?us-ascii?Q?pyqRg31ixwpbDrtR7xMAvRf2zIugGqT6k8aBYLcG/M8Om8i1xrVIAUmpvQRx?=
 =?us-ascii?Q?Z1KzhtF0kErrZZd2dFuo9wok6BDIUSnfR83eaK2fbSh5yi2xmcP6YUYr2mj8?=
 =?us-ascii?Q?KgA6j3RGaDKQBP5bWf0EMOiZKAa7Nl2SeNTLXgZk8hztZIU5Y+qv6J53EB1c?=
 =?us-ascii?Q?q0D05gqdvO1EZ3lEDFZOzjFxlNkq14gz+QCrhitI++l0ZWJk4HGiO1wlUudf?=
 =?us-ascii?Q?FGBBFV6GEYrWENv9ECJ+OXhLnUBzfy+nQRs3f6KppoxQI9pgxBl11CyZA84j?=
 =?us-ascii?Q?f2IoLKskWUC5V5pjNq69hYX3cr5Eb/Nv8p6aPaAUeQBeTqajKhNx3XsHc+io?=
 =?us-ascii?Q?AnYkRuXxsOC6uXmhFAQkMEuZz4Lv0RRpqG35KUxT7VdFyvD3eV0en7PHUmmv?=
 =?us-ascii?Q?zxpUpSmuwMUg362lizSK1KCKzzt/P0nZBQfK1nW6gaPVwGpyXEt51GOLx6dT?=
 =?us-ascii?Q?qCjks+JuJahhUonog3BPyUcA2CrZz6Xvx2BhbpbZ+PWriJVf7u3EQo1gD/7c?=
 =?us-ascii?Q?RqyNOM1i3M1GJc6y7FsjQBHO8ciEdpdbyfKKeBn5HLz8ft8lrUHuHz64jRNI?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nB0mZ/ekaghBUiOqeNqLBUXjemNwTizL8varqPFGWu2aKkaTLBbfldiLG2OG+oyKurGyOktI1LE8bfKJrkRMInh+SairgkCVA7h1N1hAdhlUvcg/d1BdVCx/9j0ZQ84g4VeAL/uM61QBLhHfyWgrI5Aesx6fJB+KHQnxzJEFpU7pieJ74ZPUlmXN504ztk7RfpyhAotNkUnaxZeCotxWQTyQTK5jcjUWkfY9nGXFwiaN1NNt3J/jGHOwt161YVJCF/iFpCPePh5XXoUc7JQF0tSgJem7uLn83JAE+8mMw6koFnftwAR86kYeJ8GWJdsc9igVzO7l2fwZT+Kk1qnyz3euIAgl3+lj3PHMDPcBgbt1aoaOZiFd11LRYNFzSaUksVhb4fNcMusfswUIi3oJje+rZz+BWGdIiWN8YIFBZuBzlGDoxzKf1+YWfeeCs7rRZLaAriABNmJhX6G3ht9t+u5F4C58dMNF6mvtQFAghScoBH+ja4mTUFrsfozNbmOXoil9bzEQTHxyyVqRPBa3AHzHvPnBAqdeTvbq0d6LamQr11bIN+MujQC0zksCNxJf63NWUC6RCkLJuxadLSCzxu18ZhQ/sYESl5kJMN8pKT5lJERg3qHO4bbQS9sNb3shEHZyfuUfAXTjdlgWtPQFPVZbPWufd1e3rOpdc8ZJmQ13h1uXe8J0PT6UWCpg+scqsk5B4tGliv5xjjO+ltHic4nI+uF00LRS0iypoWtwt+BdkTngzdgWj3wNjnNdl7Az450CyCxchRSw96L3NObIyekbPoo94tjVtOSvtxk1ov4kEqDclV+K+VS+/vPp+/Qih6nCQS49BIbJTEWjSJyT3w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacae431-3594-42ee-591d-08dbf10961e2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 18:31:20.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7K1x5OgUQaQnhkvHvJ4gaa+MC/PKqU8o/PniNP7uS7n70h8tUEpeCYAIobkVAAMg/qUcrCas6/+OUGgrQKEwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_16,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290141
X-Proofpoint-ORIG-GUID: i9szVFqQxsxXkkjQRiJhMgVblbrpftbs
X-Proofpoint-GUID: i9szVFqQxsxXkkjQRiJhMgVblbrpftbs

On Wed, Nov 29, 2023 at 01:13:34PM -0500, Jeff Layton wrote:
> On Wed, 2023-11-29 at 18:12 +0100, Lorenzo Bianconi wrote:
> > Introduce write_threads netlink command similar to the ones available
> > through the procfs.
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/netlink/specs/nfsd.yaml | 23 +++++++
> >  fs/nfsd/netlink.c                     | 17 +++++
> >  fs/nfsd/netlink.h                     |  2 +
> >  fs/nfsd/nfsctl.c                      | 58 +++++++++++++++++
> >  include/uapi/linux/nfsd_netlink.h     |  9 +++
> >  tools/net/ynl/generated/nfsd-user.c   | 92 +++++++++++++++++++++++++++
> >  tools/net/ynl/generated/nfsd-user.h   | 47 ++++++++++++++
> >  7 files changed, 248 insertions(+)
> > 
> > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> > index 05acc73e2e33..c92e1425d316 100644
> > --- a/Documentation/netlink/specs/nfsd.yaml
> > +++ b/Documentation/netlink/specs/nfsd.yaml
> > @@ -62,6 +62,12 @@ attribute-sets:
> >          name: compound-ops
> >          type: u32
> >          multi-attr: true
> > +  -
> > +    name: server-worker
> > +    attributes:
> > +      -
> > +        name: threads
> > +        type: u32
> >  
> >  operations:
> >    list:
> > @@ -87,3 +93,20 @@ operations:
> >              - sport
> >              - dport
> >              - compound-ops
> > +    -
> > +      name: threads-set
> > +      doc: set the number of running threads
> > +      attribute-set: server-worker
> > +      flags: [ admin-perm ]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - threads
> > +    -
> > +      name: threads-get
> > +      doc: get the number of running threads
> > +      attribute-set: server-worker
> > +      do:
> > +        reply:
> > +          attributes:
> > +            - threads
> > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > index 0e1d635ec5f9..1a59a8e6c7e2 100644
> > --- a/fs/nfsd/netlink.c
> > +++ b/fs/nfsd/netlink.c
> > @@ -10,6 +10,11 @@
> >  
> >  #include <uapi/linux/nfsd_netlink.h>
> >  
> > +/* NFSD_CMD_THREADS_SET - do */
> > +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_THREADS + 1] = {
> > +	[NFSD_A_SERVER_WORKER_THREADS] = { .type = NLA_U32, },
> > +};
> > +
> >  /* Ops table for nfsd */
> >  static const struct genl_split_ops nfsd_nl_ops[] = {
> >  	{
> > @@ -19,6 +24,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
> >  		.done	= nfsd_nl_rpc_status_get_done,
> >  		.flags	= GENL_CMD_CAP_DUMP,
> >  	},
> > +	{
> > +		.cmd		= NFSD_CMD_THREADS_SET,
> > +		.doit		= nfsd_nl_threads_set_doit,
> > +		.policy		= nfsd_threads_set_nl_policy,
> > +		.maxattr	= NFSD_A_SERVER_WORKER_THREADS,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> > +	{
> > +		.cmd	= NFSD_CMD_THREADS_GET,
> > +		.doit	= nfsd_nl_threads_get_doit,
> > +		.flags	= GENL_CMD_CAP_DO,
> > +	},
> >  };
> >  
> >  struct genl_family nfsd_nl_family __ro_after_init = {
> > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > index d83dd6bdee92..4137fac477e4 100644
> > --- a/fs/nfsd/netlink.h
> > +++ b/fs/nfsd/netlink.h
> > @@ -16,6 +16,8 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> >  
> >  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> >  				  struct netlink_callback *cb);
> > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
> > +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
> >  
> >  extern struct genl_family nfsd_nl_family;
> >  
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index d6eeee149370..130b3d937a79 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1699,6 +1699,64 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * nfsd_nl_threads_set_doit - set the number of running threads
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	u32 nthreads;
> > +	int ret;
> > +
> > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_WORKER_THREADS))
> > +		return -EINVAL;
> > +
> > +	nthreads = nla_get_u32(info->attrs[NFSD_A_SERVER_WORKER_THREADS]);
> > +	ret = nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> > +
> > +	return ret == nthreads ? 0 : ret;
> > +}
> > +
> > +/**
> > + * nfsd_nl_threads_get_doit - get the number of running threads
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	void *hdr;
> > +	int err;
> > +
> > +	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > +	if (!skb)
> > +		return -ENOMEM;
> > +
> > +	hdr = genlmsg_iput(skb, info);
> > +	if (!hdr) {
> > +		err = -EMSGSIZE;
> > +		goto err_free_msg;
> > +	}
> > +
> > +	if (nla_put_u32(skb, NFSD_A_SERVER_WORKER_THREADS,
> > +			nfsd_nrthreads(genl_info_net(info)))) {
> > +		err = -EINVAL;
> > +		goto err_free_msg;
> > +	}
> > +
> > +	genlmsg_end(skb, hdr);
> > +
> > +	return genlmsg_reply(skb, info);
> > +
> > +err_free_msg:
> > +	nlmsg_free(skb);
> > +	return err;
> > +}
> > +
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
> > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
> > index 3cd044edee5d..1b6fe1f9ed0e 100644
> > --- a/include/uapi/linux/nfsd_netlink.h
> > +++ b/include/uapi/linux/nfsd_netlink.h
> > @@ -29,8 +29,17 @@ enum {
> >  	NFSD_A_RPC_STATUS_MAX = (__NFSD_A_RPC_STATUS_MAX - 1)
> >  };
> >  
> > +enum {
> > +	NFSD_A_SERVER_WORKER_THREADS = 1,
> > +
> > +	__NFSD_A_SERVER_WORKER_MAX,
> > +	NFSD_A_SERVER_WORKER_MAX = (__NFSD_A_SERVER_WORKER_MAX - 1)
> > +};
> > +
> >  enum {
> >  	NFSD_CMD_RPC_STATUS_GET = 1,
> > +	NFSD_CMD_THREADS_SET,
> > +	NFSD_CMD_THREADS_GET,
> >  
> >  	__NFSD_CMD_MAX,
> >  	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
> > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
> > index 360b6448c6e9..9768328a7751 100644
> > --- a/tools/net/ynl/generated/nfsd-user.c
> > +++ b/tools/net/ynl/generated/nfsd-user.c
> > @@ -15,6 +15,8 @@
> >  /* Enums */
> >  static const char * const nfsd_op_strmap[] = {
> >  	[NFSD_CMD_RPC_STATUS_GET] = "rpc-status-get",
> > +	[NFSD_CMD_THREADS_SET] = "threads-set",
> > +	[NFSD_CMD_THREADS_GET] = "threads-get",
> >  };
> >  
> >  const char *nfsd_op_str(int op)
> > @@ -47,6 +49,15 @@ struct ynl_policy_nest nfsd_rpc_status_nest = {
> >  	.table = nfsd_rpc_status_policy,
> >  };
> >  
> > +struct ynl_policy_attr nfsd_server_worker_policy[NFSD_A_SERVER_WORKER_MAX + 1] = {
> > +	[NFSD_A_SERVER_WORKER_THREADS] = { .name = "threads", .type = YNL_PT_U32, },
> > +};
> > +
> > +struct ynl_policy_nest nfsd_server_worker_nest = {
> > +	.max_attr = NFSD_A_SERVER_WORKER_MAX,
> > +	.table = nfsd_server_worker_policy,
> > +};
> > +
> >  /* Common nested types */
> >  /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
> >  /* NFSD_CMD_RPC_STATUS_GET - dump */
> > @@ -198,6 +209,87 @@ nfsd_rpc_status_get_dump(struct ynl_sock *ys)
> >  	return NULL;
> >  }
> >  
> > +/* ============== NFSD_CMD_THREADS_SET ============== */
> > +/* NFSD_CMD_THREADS_SET - do */
> > +void nfsd_threads_set_req_free(struct nfsd_threads_set_req *req)
> > +{
> > +	free(req);
> > +}
> > +
> > +int nfsd_threads_set(struct ynl_sock *ys, struct nfsd_threads_set_req *req)
> > +{
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_SET, 1);
> > +	ys->req_policy = &nfsd_server_worker_nest;
> > +
> > +	if (req->_present.threads)
> > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_WORKER_THREADS, req->threads);
> > +
> > +	err = ynl_exec(ys, nlh, NULL);
> > +	if (err < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> > +/* ============== NFSD_CMD_THREADS_GET ============== */
> > +/* NFSD_CMD_THREADS_GET - do */
> > +void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp)
> > +{
> > +	free(rsp);
> > +}
> > +
> > +int nfsd_threads_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> > +{
> > +	struct ynl_parse_arg *yarg = data;
> > +	struct nfsd_threads_get_rsp *dst;
> > +	const struct nlattr *attr;
> > +
> > +	dst = yarg->data;
> > +
> > +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> > +		unsigned int type = mnl_attr_get_type(attr);
> > +
> > +		if (type == NFSD_A_SERVER_WORKER_THREADS) {
> > +			if (ynl_attr_validate(yarg, attr))
> > +				return MNL_CB_ERROR;
> > +			dst->_present.threads = 1;
> > +			dst->threads = mnl_attr_get_u32(attr);
> > +		}
> > +	}
> > +
> > +	return MNL_CB_OK;
> > +}
> > +
> > +struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys)
> > +{
> > +	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> > +	struct nfsd_threads_get_rsp *rsp;
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_GET, 1);
> > +	ys->req_policy = &nfsd_server_worker_nest;
> > +	yrs.yarg.rsp_policy = &nfsd_server_worker_nest;
> > +
> > +	rsp = calloc(1, sizeof(*rsp));
> > +	yrs.yarg.data = rsp;
> > +	yrs.cb = nfsd_threads_get_rsp_parse;
> > +	yrs.rsp_cmd = NFSD_CMD_THREADS_GET;
> > +
> > +	err = ynl_exec(ys, nlh, &yrs);
> > +	if (err < 0)
> > +		goto err_free;
> > +
> > +	return rsp;
> > +
> > +err_free:
> > +	nfsd_threads_get_rsp_free(rsp);
> > +	return NULL;
> > +}
> > +
> >  const struct ynl_family ynl_nfsd_family =  {
> >  	.name		= "nfsd",
> >  };
> > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
> > index 989c6e209ced..e162a4f20d91 100644
> > --- a/tools/net/ynl/generated/nfsd-user.h
> > +++ b/tools/net/ynl/generated/nfsd-user.h
> > @@ -64,4 +64,51 @@ nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_status_get_rsp_list *rsp);
> >  struct nfsd_rpc_status_get_rsp_list *
> >  nfsd_rpc_status_get_dump(struct ynl_sock *ys);
> >  
> > +/* ============== NFSD_CMD_THREADS_SET ============== */
> > +/* NFSD_CMD_THREADS_SET - do */
> > +struct nfsd_threads_set_req {
> > +	struct {
> > +		__u32 threads:1;
> > +	} _present;
> > +
> > +	__u32 threads;
> > +};
> > +
> > +static inline struct nfsd_threads_set_req *nfsd_threads_set_req_alloc(void)
> > +{
> > +	return calloc(1, sizeof(struct nfsd_threads_set_req));
> > +}
> > +void nfsd_threads_set_req_free(struct nfsd_threads_set_req *req);
> > +
> > +static inline void
> > +nfsd_threads_set_req_set_threads(struct nfsd_threads_set_req *req,
> > +				 __u32 threads)
> > +{
> > +	req->_present.threads = 1;
> > +	req->threads = threads;
> > +}
> > +
> > +/*
> > + * set the number of running threads
> > + */
> > +int nfsd_threads_set(struct ynl_sock *ys, struct nfsd_threads_set_req *req);
> > +
> > +/* ============== NFSD_CMD_THREADS_GET ============== */
> > +/* NFSD_CMD_THREADS_GET - do */
> > +
> > +struct nfsd_threads_get_rsp {
> > +	struct {
> > +		__u32 threads:1;
> > +	} _present;
> > +
> > +	__u32 threads;
> > +};
> > +
> > +void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp);
> > +
> > +/*
> > + * get the number of running threads
> > + */
> > +struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
> > +
> >  #endif /* _LINUX_NFSD_GEN_H */
> 
> Ok, Uncle! I'll relent on the quest for a single netlink command to
> start the server.

I think we can consider a single config/start-up command, but I
don't feel it has to happen as part of this series, unless I'm
missing something critical. It seems like a declarative mechanism
would need some deeper changes in NFSD.


> This patch looks reasonable to me.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks, Jeff!

Before applying these, I'd like an Acked-by from Jakub for the
tools/net/ynl modifications, and at least a fresh sanity check from
Jakub on the changes to the nfsd netlink protocol (though I don't
anything problematic so far).


-- 
Chuck Lever

