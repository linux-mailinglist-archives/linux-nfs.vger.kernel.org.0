Return-Path: <linux-nfs+bounces-76-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5567F946E
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 18:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D052810BD
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EC0DDA7;
	Sun, 26 Nov 2023 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gP4Tbau6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZRBCjZ9y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868FFFB
	for <linux-nfs@vger.kernel.org>; Sun, 26 Nov 2023 09:08:36 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQEZAlc027170;
	Sun, 26 Nov 2023 17:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=pYTSz6D9/GnXrrmTa+lt2/GFgI4Dj4zQuSG5jvSm0/o=;
 b=gP4Tbau6yDvL+uIhVynEBbPnvz6gk5c14xReMbNLOZ9nd2hpMsz+eyzbdMNj25syX/TY
 8ZtcDaFQ3TIg6KriLb2czLbKOufopq6wsQxqPk4kRMw1PdMPOJ0Z/X7pvaU027cmGLmV
 u/9rtN14uxTHc3mc5GdrWbkIybPg81/gF66FLb+rqNNGR1u6E0N2QktOEtipBzzwf58o
 KLcJecqRq0r/D9n8FC+REiah3eZQSpd33wB/YBAakQNPgQnXsIX74VPHqz1RqQPSdoQd
 Dl4RAZBcIiORJzRVQJqbdUCG+uUbMaOZr5ci/X8Gcjipk50VaAMp3hT4TEDT+vR5iLXF 4Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8tbsewd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Nov 2023 17:08:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQGKBu1009302;
	Sun, 26 Nov 2023 17:08:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c45hvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Nov 2023 17:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAArbptKBeGqYz1nFX2XbsnKi9/Jv5T9WtLksJnJewejcn5ulIs03tfuxkgl7zEp5uXDeiSyUw54NWQLJXkf9pn/79VWZ0kYh5L/bBWVO5WnsyGHORBeLTK+1wAUA38AN36I8f49JXXSb0S5Mcvpy+GkLnCrSMhJZ8mPqUW8+Olu0lzrVZqP4hlUXqmQsrEypidxZyk29JMgU10vDUn8EWb7wxshwBxwR58CyzyVuvZeUdh9OKvdnK0cboLA9pv8j/3wV1dk4YjowbuBKKzEAX27LUebjp+kL57p0gp83W4cRF6icfFS2Qggi8Fi5cOrFPmBYjaw/Dxttcqg3MnfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYTSz6D9/GnXrrmTa+lt2/GFgI4Dj4zQuSG5jvSm0/o=;
 b=ZfIjdpNTRG8w2ubIYLxkyYTl6N4xzQieH5ST5YlKP7wO1Y8XJkirRaNy/vJxoc2jNjzMwSai5y7lzchefPJ0H1Fq88fd14/rnVbcAOz4WiK957Sjrdx9TaQIdRPzpI+m3XhgVKGu/QQA5zVbIo89/TbWxB0Zo6ZtkW6sUAJKhgSTrtRzdgd9k2IlF73mq5ZNcMcjqVh+/g7Ngcvmvd0smo9hK/gLlvZRMnJelwsVXMJCO1CRneECpbVBSxJ1J5lSk1mzpBLSiQno5g1gQA6TA61FJ8PnpiOQAMd54axatTC1iP/cyxEJBxy35uYaf8N2FNXd+ZbzRbjps9zo1egTrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYTSz6D9/GnXrrmTa+lt2/GFgI4Dj4zQuSG5jvSm0/o=;
 b=ZRBCjZ9y2zj30oJS9vj6YRy8/hVUYImAWN4QnBWBkyutTe3MK5e8grcFfTp0/E2z4SWvh1zdUputY/84GS4GMx3VXi71Dzy4ivM4LjekxjyjlsFjLTxbhd+xsEzc4XBitE/7HMso7naMAy0kOd/DNVW2H3gbFc5HLD4igD3JOng=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7322.namprd10.prod.outlook.com (2603:10b6:8:e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 17:08:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 17:08:07 +0000
Date: Sun, 26 Nov 2023 12:08:02 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: <DOT>foo gets NFSv4 HIDDEN attribute by default by nfsd? Re: How
 to set the NFSv4 "HIDDEN" attribute on Linux?
Message-ID: <ZWN7cghjEZHD92Ad@tissot.1015granger.net>
References: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
 <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
 <CALXu0UerMnjs9y4gQTvy-v-gqSgO2imFbMAZ87LFj1tQqvfjiQ@mail.gmail.com>
 <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org>
 <CALXu0Uf9LiNL7SA57vSq5pMBVBZESWexcRwDR0XMc9fFpPiNkQ@mail.gmail.com>
 <CALXu0UccoNs0A4MjQH7gPboarWyZcRQzsy2zJRxk51LR0hGDVQ@mail.gmail.com>
 <ZWDgvFfkAF8e3MFj@tissot.1015granger.net>
 <afb9281a81c2001588dbaf46e0ac13fc99ffbb41.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb9281a81c2001588dbaf46e0ac13fc99ffbb41.camel@kernel.org>
X-ClientProxiedBy: CH0PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:610:75::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 1305821f-fcc0-426f-f7d2-08dbeea241f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	J+ijDSx/oOJ0CXvuzzm10z7z+eoTTkfsBEfbX/tej6pjXcDNhxo7xyIejTMrpgomD+4PB6xClTYEXF5pC1hR/Z9RuUGZhYwFDsa3biRvbma3gmzvWnHcjQrgfPAyxbD9HPEZQB2Ec6Ngg2WrLxaSd2TUnguCVBxoxzhIrBwJrxUHLPDGIA4dyC3k+MUuBazaUzIDJLpzVRD2zPNu6OO3nYmy01AkRxb1e/OpZkFjuwt9SlY0DHUZgLq/+prZEhwb3DARLSyqgyWKtIIAhYr9vq0Fhi/dXyXobro7A4vdCOEH3+I/xQcJx5FLrP7EniOhMT3gDkRnDZcITU4FlnE8SgtqFi5cRAXB6pLJHSFwtT2Tn5TdVPZQxZHQ20N54lfqsf+alQQZmFKf/jtusHFrsz5Y88hN0bqOEdPrlrhuKNVmEgZb/FM52o862LzN5QavUJQ9T2c2kSNHX03AA8SG7fghdOuZcC/YX0pIcAreCYpBRyKmbrKy0hel4cBpxu2XCw+uW44LGLpJfm+aYKCxp+IdQ7G4tCTBYf9cSVNAv7Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6666004)(8936002)(8676002)(4326008)(6512007)(9686003)(6506007)(54906003)(6916009)(66946007)(66556008)(66476007)(316002)(966005)(6486002)(478600001)(2906002)(38100700002)(41300700001)(4001150100001)(86362001)(26005)(44832011)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rTKJ0tz0kx9CQo4NmLgSdZ1h1BwXv4knhtKibVnoPBPamgnCLROItbN54xe4?=
 =?us-ascii?Q?q/TjysvTgPGxSmp5c3TMO3ZwWsPWitn/yGufkDc/FFZ9ugVsHULl25fgXe7F?=
 =?us-ascii?Q?SUMcjugzL5pwTmE6PaJK1lq/tfUA7kRjEmi7GgSY3LQbTHCOmRjUUBt3Kom3?=
 =?us-ascii?Q?HKC1+VpFNp5f/mKntUys1/jr39XNWoO4kQN2OHqDbdcuZiz045+snJVAsDI6?=
 =?us-ascii?Q?cPIBCWtlWwPz0Z9/Wa340ZGW/cuImP2rZyq15tgzZzOWOt9XV/1bAcwLNN52?=
 =?us-ascii?Q?FY60r1uWrkmyNkbRIMHbPw0hbC/u8xzQpGWwPR9JsmMjYOoIvBqeRPzUrG/C?=
 =?us-ascii?Q?JpLro4S1cKXLfjBY4Bt6Tew6bsoZW4220jopdNiBu5cDVy0DfRjcxsN9EpEr?=
 =?us-ascii?Q?dHSf/xQ0AiClPseUEbYldhk9Qa/XSSlh2csDwCUkBhFAEfCiTgyWoYltNUiM?=
 =?us-ascii?Q?4WFFrWldJ6vOauJgQ7X7wQwMfJOEAD88MuGQUfhnaTaiN3XxOphm/8EpBdzR?=
 =?us-ascii?Q?22ErWJ9/U/xTsW0jWgKy8NzFRNcFcZLoYAyG7vZ6uVd/UmGiXJ/zwAIZo9sc?=
 =?us-ascii?Q?W4FdN3xbiVsSPWSjQV1XJHAfeYvMoGWzDKCVPODQWguGzy/EKjcNTTCfg5LW?=
 =?us-ascii?Q?GG0l8+ssNsEj2FFK11wlWaem3lSMOLRzammV8I/CiPpI0hAtbM7O3I42Miuk?=
 =?us-ascii?Q?v5cmZTUQ0hYQHdBzDz/PPjCNOEBR6Pf/cAr//2g3+BZnT3qsHMl1KBxlk2T9?=
 =?us-ascii?Q?Ou2jYUglwx0NIs6Z99/UAviHAI7P8UUWgMQm8CYnskQcfh8tbXCRRWHxuhPv?=
 =?us-ascii?Q?G2VVgBi/8egS6bPmzLQ84auENHAIhVcqROIw0K6VA0gR9+Q74y+YtvMDUgEG?=
 =?us-ascii?Q?Q8OCnoH9DvD1e26wZjNM9ZkG9eZB+iCCOfKdOEkVT2RZcyh/Fx/PaRe06Z+7?=
 =?us-ascii?Q?0e7aoLpYh/5/eJiOh73kt/DIWl7j9H/I9Z6b8zAr4zqsa2ryNpKNAVF0Ir55?=
 =?us-ascii?Q?PtMZKl2kl4DRfgIea4dUKOTPvh52JMo2bB6fF8TKWR2I3fvP6IOZjtXfb1Jo?=
 =?us-ascii?Q?LbQuEJGCWF//0L/DngvAjNXvFp/K7keQSjnWd6NGHn+2mn0hkkuW4HxNXjVo?=
 =?us-ascii?Q?uXTKSn7+Hm8FCCFpvYG7bq+5U4rB/ZF2WldNi4bu7DmOuodwgMpv6PkZLRqH?=
 =?us-ascii?Q?QTW23lnQQ2EqFZum5Shk9l4xJ+TGts763USczZXdJxCpSMfhQojLmBGzUxeL?=
 =?us-ascii?Q?okJRaGPWFOVWLQzEoFzW43g95r10vSON484q0zp1SCtFgvk8EeP85opyGTRX?=
 =?us-ascii?Q?D5BUur0fizZ4ktpa3XqNue3WJImibpBIGjP26NSNriPuT+AGe65TTSfZagdG?=
 =?us-ascii?Q?e/YDX4bVp98MAJl5pj7Y6c0d4+eoWgO6RQtBR8pV9M0w/9lclOjZb3UdKdG8?=
 =?us-ascii?Q?rWpCHDuNnARs/+lpli/MtEc5ylKZbr9amK/EmDwFMRmuCRtj9/8GVUgH3BmE?=
 =?us-ascii?Q?X8vMYYg8wbPhwJgfRBfmOOIDa6OKwsmQ9z7ZCtxQfY9B4YpQGHalB50QqUV3?=
 =?us-ascii?Q?bzJtAXdHhx/UkOOkqs7SiSCeZvGVeJNRF+XzZO7fRkV+YVNptGAH/3vfY4b1?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	N9BX7K0UiG38WeccXbiAjAesOmdWWYK7iUfa4b6DmLfmD4O6Rm7HAu+kHo8Usdp8IWj+yt3OT49nm263zW5KnkXrlwvALuBahAMt+Q2AwdeyMde9utMEUXH4/rKYkYV/q3qGN4ziwT2HlW30Ehe8oo0LGM0Pz4KgzwooYpyKJSakZ1+6g8stym6Cc+qcJLz2zAiu8nzk4wScX1KIxWptgPC5XIaQvu8iXXhegt+jdqy+CMrbRcIkQMMDIa62lvImgNrd3M9YJGgf/D5XZ+FNqN8L0bLfxqVNWnAQU5JJVK+Jsgm+odBj48qyK1CJqeV1jOF3z60/wLxZRjujBu70bttJflPWzOOIbJx7jjfRdfyZE3v2YFPTQfAOvSiDp+kC9U6UsNCRcVwiLCP0enl3p2SNULwJi8ba73fSwodR1ZjS8B5KVqKPAB1zpKtRyRdZan8A4oFtqaT0peu++hJJxQ0Aj99etoCPytyE0gJgJXXhBCTaDbUENifl/q+5NUMYNJ6qujZz4RUV2Sy2N0o8Iyp5vTKm5PoBMUApAfrvNtDJk7H31Ayb2fmMTMbtKaOgj1Aq0a04wYisZrfFzoqEqN8bEgHeJyeHtxn7+72aar4cadsaLSjgUzAjOnJchw/0wCTmS7MyEPFZah8FPaSTsQnRdR1JreBRT5q2VCA33law2g+7B/R/sdVnqeUeCet0XTrZJC5ivMjMt3iNyFcVhHJZaX+WawAWwtmhU2jHPj9QPW2ipPkwY4uy5klEzfWtn45eVHJo/DdUq6CdR1PdJ80nLrXdiRJv1L1eQ/tM6ppJ/BbgV9Q86cAhJAswhsIk
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1305821f-fcc0-426f-f7d2-08dbeea241f6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 17:08:06.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwXnwZ3kqsaDUVg+6BVlmoIkaPZsTps1wmm93oa3wXsDWteljY4EXhzNnignXyc/v5WJNXywv/n9s9/LHV2RpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_16,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311260127
X-Proofpoint-GUID: OlfwBa93Ojnj1Diq5VGIVCmQLE6N6Le-
X-Proofpoint-ORIG-GUID: OlfwBa93Ojnj1Diq5VGIVCmQLE6N6Le-

On Sat, Nov 25, 2023 at 09:52:36AM -0500, Jeff Layton wrote:
> On Fri, 2023-11-24 at 12:43 -0500, Chuck Lever wrote:
> > On Thu, Nov 23, 2023 at 11:24:10PM +0100, Cedric Blancher wrote:
> > > Also, it is legal for a nfsd to give the DOT files (/.foo) the HIDDEN
> > > attribute by default? Right now on Windows they show up because NFSv4
> > > HIDDEN is not set, and it is annoying.
> > 
> > I suppose an NFS server could do this, but I'm not aware of any
> > other multi-protocol file server (eg, Oracle ZFS or NetApp) that
> > does.
> > 
> > Dot-files are obscured on POSIX systems by the NFS clients and their
> > user space (ls and graphical file navigators). I don't see why the
> > Windows NFS client can't be similarly architected. Or perhaps it
> > could fabricate the HIDDEN attribute for such files itself.
> 
> Question. GETATTR operates on filehandles, which are roughly analogous
> to inode with Linux nfsd:
> 
> $ touch visible
> $ ln visible .hidden
> 
> Is the resulting inode and filehandle now considered HIDDEN or not?
> 
> These kinds of issues are endemic when trying to map MS Windows concepts
> onto Linux (and vice-versa).

The semantics of dot-files and HIDDEN are not the same, truly.

Interestingly, Samba supports a "hide dot files" option:

  https://www.samba.org/samba/docs/using_samba/ch08.html

It also implements a regular expression mechanism for faking HIDDEN
based on filename matching. Apparently the Samba folks don't believe
the difference between a HIDDEN inode and an obscured  directory
entry is important. Or perhaps they do this to work around missing
local file system support for storing the HIDDEN attribute.

I think I still prefer implementing an actual file attribute to
store the setting per-file. HIDDEN seems like a characteristic that
should be controlled by the file owner or the (client) application
that is managing a view of the file's parent directory, and not by a
server's administrator.


-- 
Chuck Lever

