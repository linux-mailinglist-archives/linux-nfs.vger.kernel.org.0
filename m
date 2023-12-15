Return-Path: <linux-nfs+bounces-631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013AE814C1F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 16:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7E6281981
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8F7381C3;
	Fri, 15 Dec 2023 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bYFNXdL/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uClre5nB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CAC381AF
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEwnj2013536;
	Fri, 15 Dec 2023 15:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=mIXjoPcWJSbH3XUVOOxkCbJKyB9f51PFptIaUVlkMZA=;
 b=bYFNXdL/FMh8jZGSP0IBBaPojnu/vO1nXk++ScgfyNpolsBPBpu3sLajK5bFwJo1EMdR
 H7MEEJ4tZydY2WzW8zPjpLCFieOsb+qsSoC9tXuM0cyAbb1HxdG1x4l+G5BCQSwZaBpb
 MAMHZcJJtNjwZ0rSsjEYuH1bfawIco9kGfO3FtvYv72+npMZZJ/0ElSMn9nRX+NL3qnL
 P/nnFkGEDgsR/zY4BqHkJKBi+eKQqk+pggXF6MUB61w+qebxinsj3Mn622H6MDG6dt2d
 PraNrSzDGonHxGOrcFOkWNUfLQ1L1+5GU+nM7xocJCiRnPd557hGHFj0rB2U3Rz8lwTT iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9ddtsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:52:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEwkjM039639;
	Fri, 15 Dec 2023 15:52:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepc01y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIqs4ShDTxidNAnI/G9Kud/vvlcRFRY4N9F83pbRpXkHp1SmWZb1fRRlmSwS1xjzXxnj5umuNXzws/YDTysmKYTuHdt1lzlFe7pX4gUtGv9CbtwIlLj1giSVHdZpSNflXiEs/MrKf/cC1x9Dvv01P/iBkZqGUeQNv73v5g8Sf0c9nEzG0qUQJFsbh27d5GADnNvLi9+ErpX9SCUgfuFWC6hav3plKhQYHWzfB5l5Y6kTk6WR0H1x7cOn854SJszBZ3T3x7Iq73N9OZxpYX+EyUCTkLB+oEZounuaLfgR2fWIB3KOshjmBIilbS1+pKzzpNK9iEhqwW3NCqT9akp2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIXjoPcWJSbH3XUVOOxkCbJKyB9f51PFptIaUVlkMZA=;
 b=VMV9lHO+u/SwePzP6itEr2D2/o49sDGZOiqBKyzv8kEHFfLE5J8fiEP19AcWG62dETjtbul8lsGFReNjDnT2quVbwJJUMWGbEwd8FRUmP1k5S5/6kNj/nfRIZlU5VOgDOXXrLCE3krGwRfB9gJShg28alcomolgv9osBVwqBOCMXNandaJux+A2DS1OYrL0fgy40W3DQDuPSDQKlnmCm2bbV0gGNwVJfVikgyMiL7JkzcccuO3p8jH+APWW3P6zVNr17zzStEjeq1RyxBhUVgNXXWNjMS7kH8nOLT5so2U7HvwflMTVCZ3zON06Xnqmk2JDCMFCp5BUV3j2jbQWWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIXjoPcWJSbH3XUVOOxkCbJKyB9f51PFptIaUVlkMZA=;
 b=uClre5nB4AuFrO8fVHXQxfKGPrvPSMT2IoEcex8s9TtevROvVBMRhu4fHqs6l+zhNlADP4JfY3BV3oQRLmnmm5bjRsg2wip4sPyNLW+7E12L/K+hJs5iO7f+81PPicnwmvPCPI1NuY/S4QbVdDDypqAfBM84jeYqJrbir7bDAi0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5793.namprd10.prod.outlook.com (2603:10b6:510:fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 15:52:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 15:52:29 +0000
Date: Fri, 15 Dec 2023 10:52:26 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/2 v2] nfsd: fully close files in the nfsd threads
Message-ID: <ZXx2Oklp51L+fIXp@tissot.1015granger.net>
References: <20231215012059.30857-1-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215012059.30857-1-neilb@suse.de>
X-ClientProxiedBy: CH0PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:610:33::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: d31a4eb8-5d68-47f7-d867-08dbfd85d7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GabFd+IwX3DP0DTZIHsEoR6T08c1f+U260oGbktLalyjHrbG42zZOM6144igPy3CWbSJHiVRQmSFTvh8/lblEIkxnQe/VSZgVPOWN+J8ogVsgU6s7ynq1C20QIJl5QwdNQK2dzwNufHCVOpRJL/Hdaq9uydYtw8CNcZh3cKcDycsP2WKs9LeqL8cRx27O2xIKO+/7Tob9HbmiHKPOOVGINPbaAlyAR15QO75KiElGTP5lr+JN6wVtKEQdYyUm0lNupHqrbz5onsmWls9XOn3YWa0l+Hlwp1QJXTUwcq8hC16CFgyRjAfNt1dJ0yl+MCLabepJG+v/2IOqDI/U6/Y3CEmJ49Re4dTxBFrbj6wEUBdeIG573m8xpHZwG0h+fyv2exCc8dtFVqeqomLZyDgejUCqFzU5YaN6+Waf75+uNfuoS0tsQbIjyqhcRH6O4BjCyG9vWcc3sR7ZJR98bxkSjhHyLlfymkt78HGBoiEeVgZ4lgCuDNOUCNQAaRhff9sQlZOtxaHP2GY7KRJq7FmixoFCblsHsh0ZosiRwG/3JvpxJQnxehAyI4utAs6TZt9VBYDm4B5EnZeSJ/UauHIH10C2mpBFKvebP7yAC7j/GYAIRZKlcbZbT4IxKdFyx0VtVdYz/42bjX0RI79F182J46w/nM/A2aT/uhK11dDAhg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(316002)(86362001)(38100700002)(26005)(83380400001)(478600001)(6486002)(2906002)(4744005)(66556008)(66476007)(54906003)(6916009)(66946007)(9686003)(6666004)(6512007)(6506007)(5660300002)(8936002)(8676002)(4326008)(41300700001)(44832011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SqocZ/D88AURcrW5RqI03FwTEDeDIhU0YS8z2dw6cMZfwXWag/SXphoS+CQ1?=
 =?us-ascii?Q?2LknNAOTE9MBH/LynZZTymMBmfzp1EjQ4vHItJs8mWxTRnTxSQ0b5ltnO7Lm?=
 =?us-ascii?Q?LYlq5SQeRqSgDq+TUToMNb5yw9LE2TFky6H+byuCw8BuZ7zMgNghdmuOc2o4?=
 =?us-ascii?Q?r+bnyaRY5wZmBx+pM1Gw9eXJN+VicbSjpfKHJ2jhouTVzOm6uC/UZnsvpyhV?=
 =?us-ascii?Q?0eUqshsKovYJGmnuqWDqzVKy0vprOr2wH3tB5zQ7uS/5VUzhqy0uOIrPMfFM?=
 =?us-ascii?Q?bOUnKtwC2k+ggoFm5Fp0301OH5H3AdlN5RykGp73qrLTQn4zmcZ6RVLjKeQl?=
 =?us-ascii?Q?UrgvDAnaf4d1Z8Pr1fJS9Sc0XwMWyySAefFPbIbCJKIOst1rj4kMjf0NpDYX?=
 =?us-ascii?Q?ZeeZ8uxKReOf/HDPgHHuKWBddoCrfCywXGR08G2gPQDUFyjVM0hriZOQA3r3?=
 =?us-ascii?Q?rWYf6aUxNgbaVSeR8rKq1M61sP/LMfSMfoP5JWtQYYWBSqnUEB/2IIItjFpT?=
 =?us-ascii?Q?ZX3dyI1TKdheW1Qt/Q6SlC1DBnpxnbqJVbL7l576qJoqr70Qays2XH6Tm3QK?=
 =?us-ascii?Q?/d/p882+JB4v4csFiCWZ2eWKb1z50TJqw1k2LGSX3BNfTnDBE5zYt1vU56Ky?=
 =?us-ascii?Q?qMDEjqNDiX3uEQXHFY5N5ibfVPrj64MzJ7kYFwfisHIiofdX82+k/dfVF/7X?=
 =?us-ascii?Q?/s3d3LUzLBpU8wCo2uoihi4rAoklBczl4S/EEXAVkBH02dv3RfXpo+0T/CiP?=
 =?us-ascii?Q?34IXb7URevnl3ng4Jr4Sheestt9uUS0tvzkfkvlPD/13+CekaHU9DJKK4gcV?=
 =?us-ascii?Q?byFZ1Gvacn5lyVrQnj3dd6vp/5VRcqN6ZiCW3VwrsGopFTkHDF86UyQEv0YE?=
 =?us-ascii?Q?Lym0imCRmRwt4SMai5MAfwAc1ejKYyCmrLHE7I6wbFC6fZ2cNsO4HyYVLCYR?=
 =?us-ascii?Q?cueTwvXuh7yjlq1iagKkiemyynRQs0qnGiJn8WBrAIa9O+RxWEH1UpA5JfpV?=
 =?us-ascii?Q?ONB/DHmsk3eE/qbDrhcN9M6spoS0LeYBaNcKKUAwv3F7qwOC+8EFqlfv7cCD?=
 =?us-ascii?Q?1Xe8KDs2J89T/D6JFbO1CfO9cwxp3S2+cZUlH+b7mBMsCf2GSVtNmyH3JfRl?=
 =?us-ascii?Q?517Z4d7PQSMAC4BoQXvb5X9mOtVgEiIrm+Mjwq0PInpU8Yxyekq337bUfYa5?=
 =?us-ascii?Q?At7EtGaOEvtzy2+5rDUhPEnDESyjfT/ffvmlXUs6kYB65PD39lP0Dx/FTzx0?=
 =?us-ascii?Q?0E/n+DoNtJbIv84LWuKjDRxMqDVibhQYyCr/dQ5jex0WhBx1ccfO348QSXgS?=
 =?us-ascii?Q?qkjGo20q3YJHvo6dWgBgTbpd0Mo3FrqXNSfpSHYMLadI+717osJ7p7OOHwaM?=
 =?us-ascii?Q?D/it9PVgzQ+CW4Vaaj+88su5/KnPgn44ptkYjetnZ6HsbSPI2itgXe6K5jGi?=
 =?us-ascii?Q?t5q8TWRW8qAcDLmy6rSy4hDbRcgfZytClK5WXSZBfs0KA9fXhQW+mvYqdEjW?=
 =?us-ascii?Q?9n329VQ4nq1etTKL448fCj6hUHB/7PGt2yyAWNj4o4d7sjmJc59TdCyVYjm4?=
 =?us-ascii?Q?7h9xmfyrSxri4813Y/Kxy5TnvseXLeDic68TS9a6VpUFpjZh+r02nS4vv2Mw?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h9/MmL/QsGiAs2AplP5tkMguY0VDjGU8trhHEs7sSXmXqsMTYHJWlcPNyJiKbrBWfrZQ2deMYZ7TUsc5YvpUA5rp3voAVTsz+m3g0ZczguloFdOU48YeirLzMAjSv+A6u2rvf59PgDZScLvY1tJJHjlEdA4rMj2tkuTIPp/6QJZbBVDkZr+YllXnbCIXe5lEWVmDYZ34SHVPQOQQXuFHFgWTeyZlxxLYp3Ul3c31sBo7NWR/JKhbpmtuPLRKoKDuuy0nT6GtLJ8bqkZn8p3N9UWhcWKGLc68hTdXOT5hU+iPdAUtMYnaMyi3sm2WgcU+M+PIKZh4A6hSLlaQJ2y3ngDuWokXgBdocTTbvIuaqu3qVsSKaX0sTDAADy6efIJG56sZuvJgYMWHhvj1G1tmRtGP/JOgjmr6yriG5LViNWum/LxKGdn1n9BeAMZunonBiBq32e4Wd3M7jNPfIMNMC0SLlo3TMIqMetusEqgMZqNCGKkb9zHfZwk5Vp2emlb5EUXbJSn7NCk/wAeeuLEKu/Q0FSYKF6O0Hiix4mZU9SkVSub1NmpiMkqVj8HUZ3EY/ia//p+77zVzSzh96EsOdHQiNQH41UARPKG5WIpWeps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31a4eb8-5d68-47f7-d867-08dbfd85d7ea
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 15:52:29.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMf/VYWShNnPgjKY9gq2fKm3jKg5nEsK86ZixFs8Z0WTT5liYsVtz4k8ToEE6T2uQ39M/mHyXKmFAydyu5Ejig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=861 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150109
X-Proofpoint-GUID: QMvpTHdn8eNO4LxC357TlOtL8dpQOSeN
X-Proofpoint-ORIG-GUID: QMvpTHdn8eNO4LxC357TlOtL8dpQOSeN

On Fri, Dec 15, 2023 at 12:18:29PM +1100, NeilBrown wrote:
> This is a revised version of my recent series to have nfs close files
> directly and not leave work to an async work queue.
> 
> This version takes a more cautious approach and only using __fput_sync()
> where there is a reasonable case that it could make a practical
> difference.

Hi Neil, thanks for the revisions and documentation.

Jeff and I would like to see this set spend some time in linux-next
before getting merged. We're just about on the cusp of closing out
nfsd-next for v6.8, so my plan is to apply these to nfsd-next just
as soon as v6.9 opens to give testers and bots plenty of time to
exercise them.


-- 
Chuck Lever

