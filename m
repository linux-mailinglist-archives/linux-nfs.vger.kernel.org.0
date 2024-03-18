Return-Path: <linux-nfs+bounces-2369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC8687EA1F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 14:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCE01F227B0
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3845F4779F;
	Mon, 18 Mar 2024 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VkPnAwvM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uTDRE01o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020747F54
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768725; cv=fail; b=sUeGvFkCJVaP4QzqCNzgVGijrwTN50sb+45BpjK2qrkomlcuynncA9xxuW9wlnPhNC70dh1qAplECmd8nLkmlB5xLCF1KkjVFE1vUE/6K/DZcEXKI0P1Tli9lDsWSXFccJkjZZaC/cMZzv9Pbc+9gY4s7R03phIbe59mtGw3j1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768725; c=relaxed/simple;
	bh=+3tlHCKYd3gzsEVmMefWFyCsawahTwgL4Hihpdk9zSY=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=BY4HClYN457tHJSiG4zLc7Q96JGAicbGWX0WewsPPWh04bL8UFagWGZw5cHmXBSbjqbGpf13ZzZu4WqP9h5gNO53yZ3ilbpu61OZOvATTuf2kQQMgb3jWem8qhjul5nHEWL/SZXh5amYahRZGHn58RD1Prqg54CJgx9GWxDiAxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VkPnAwvM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uTDRE01o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IDPQUQ002537
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 13:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=9KafPnXAoS0qh/3iwV9yk57lAL8OsQ6TypBn044/GSY=;
 b=VkPnAwvMPpWxhrkRUJPLiMaRVhBLmr5yjPUNd/AKwBfl7Sx58os5XLP8GKlZ1udjvNNJ
 lGzWd/r0bCruvZbuNbw6loho0Ayjs1y8c73r9aPBhuJw3cHpvS9NCFZAStor8FewRp6k
 0eLzY+hMiIkkkHtIqXJVBCeqyeYQLqGe2agJ8mSPpO3r3sTYZv4N/LYmepa1AJUmtWAh
 h8fWUnBDMtiPKHlEmaCWUR87IQlIoppUkqz+Kh7AbjUpZ2MIDkJMWLiVlESallpue7Vr
 v9vJXjkildqxV8N8oEpNr9CUuPS2bj6QC78IBTON3OkDUikDE70Br82rCa60EiYpLNGt WA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww21130vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 13:32:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42ICeM4W016071
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 13:32:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v58fbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 13:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVFgphK85PLwpCNtqDrBkPB99reE97U2k3bbZ4YHDD9wdgst3mriFYY02W/SGgy94kvyG7hQYxd9Civmo+5VbxqfppmfSPuKinStNNxyh7SL1kOJ1Nuez65dRHwzxOKqyr6iWD+ucwnc6qLeJHdWW/G/GCXzJOOj8ZI5hXcPF0akhRiv4PwfdAny8wptNfFPwc0TTXHeSCaYSJSDM8ag+uaol0U5tw3cfd+lHPtcAhadAOBcfUN+SKCtJPRymDnYIX0mc/PIO5nYV9AY4muxO5Si20pSx829qB/9vXElvrbRtkyj2/dVkvrTGqWs+HiUvn1TvEeLBtI/dWuZ6WZv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KafPnXAoS0qh/3iwV9yk57lAL8OsQ6TypBn044/GSY=;
 b=OGgP+ELTMjYoTnRjlDcX9+1peFmPIvFcReagz+MrhkThkO7NML9l8SiZa13BOMWrSYUNnaXmMEJrFxBBX5Xqd9YQP0uEPj8ji+eqNiU385urQDSChX8/Pfyl0PpWzu1k0QXnve1+E2+nf7hg1+6O9uRadfNXSinQNPLTOEkrLJm8bY59SW2pSVH7ZVQ0RRPDkvGICY/kXBDq8x1L0q4u3vBLnA6Jh9ChLyRRJs4zGohng1t6amrCpIIICN0I3OVXKSoYlYUWMlRpl8KQTg7KxzKKtOIvXU6zenJ08qsq3MVAkNrDJ6FMXmEDYZDIdmuokBYFynZpo2HlUt4LtogwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KafPnXAoS0qh/3iwV9yk57lAL8OsQ6TypBn044/GSY=;
 b=uTDRE01o9kPjV0czZlwmgpNLE+AW7RvzWBsEjU08Vq9OvbFi9ErOJ/AfEFMiurtrGU2q5h9qpzKjOqn5mPxB4ixT9M//PVVkHNJ5UXvJUw7df4L5WyfsyKRXzFHknyEdNISoxEqLOkrHTEci+4SlZdRNozYhRq6jFBYGv4F4MV4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7552.namprd10.prod.outlook.com (2603:10b6:303:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 13:31:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 13:31:58 +0000
Date: Mon, 18 Mar 2024 09:31:56 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZfhCTNJLrrgLTPdM@manet.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW6PR10MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fe4815-6cc4-40a8-eb39-08dc474fc96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	li2ypkidlSF07i3+zlP/ziHEAdCOXkJU8c8SIF/4zOsWMWeFCd9iCPRu5sUY+FM9KSmRy8rvt4k5vh/XmMZA1i8fK3VIqZbUEymQ4jicidxQ7dnnfXmqk6VMtm+m4L5Otq799UBGYJO3vlh32aYhhv+1/e6XZ+Vgbfda+QQPWvvht0B+CLebYPAMcNcwc2vXmXgtnS5nuRMLD1pBccd5ih+UqQliB4lOPr5r4ozrvRTJ7aLyJjLopn2i4CIK58LlvLS1u9eVqoi9ua7EkEZTK0cHBd+QN85guco/U/xez3W2TZz+2f+YtJb27hI8ioSr84BlVUCa6pNT12TW/RFMzA3D2DJ1gtDnnZWYrqjR0+Pe896ay41zV9Tr8T6H+UY+GJpNw0yYS+OwdHais+z6zyWVm2zZm148Jy54qgxRkOniTWEX5nTJ9D/h2Gqtief7RdOlAJmgTUIw9RoyJRKF/3wX6FHG/mx1DV+FcZtV36KMaQMJpiPGQI5f+zGf2MF2S3TT/g1rEcTnJmRNmzHiygeqhbTzX7q5jWOhkOdrCx2lcY6JcbxJGZj5q2C7NKLgN6hmKaakPcVIMRoK1lMmHaosYyZS3IUnQv0iOOowriA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QiqZn8iWehzRzOnKL5vNVS9//sOLZmqmfYwlAowuhQ6v4WmK87gU++4J4QZI?=
 =?us-ascii?Q?H9z+sKy4wWuaJ2xjh1OBp5KJfHdMAwC6hD+uuC2YVPrdzecvr3UsGyKQXt6J?=
 =?us-ascii?Q?YmpyJo71bCcfrzsOmmwUsUpJe3oSdcXgD29q3LGp/c+VNqPfIEmNuNHAvpmk?=
 =?us-ascii?Q?Iy59qIVBeQ2QGzC6SWr9yBqciYFI/Y/qyaj5IUVjl9F/me3PckYKftoyO6r1?=
 =?us-ascii?Q?kbnDtiXTOUFanMvRwkoqxsKNxBZts1q8c5nVC1RU0KB1mbCaqiuhyA1IVNEg?=
 =?us-ascii?Q?hdLUrw3T1kvO7GT37ic/K/23atUH/VkDmnm6Hmk/6vB81ZnC8JgGEOBrQc4m?=
 =?us-ascii?Q?2uOzc50Jh43/7QpmEX2Y4wYOjhBeWW0w+rMJtlwI1f8yZU4yQMosrqY+fs4Z?=
 =?us-ascii?Q?1KmhFnAq3/Vc/DrpZezQIoHH33vSDnF2aqF4n2IGjASeY6od+pkLh9DljJzl?=
 =?us-ascii?Q?jWNxoiB3Yqwb3Kbopz4X4UqgCx3mylqWPeyogiPIeLeFqy42nxuefMRVZg4t?=
 =?us-ascii?Q?LFxXRBDm0GCFre1HlPDui9OmfPvmjaHTzjmHGP+YhDmKPIUVHzce+1QId5A0?=
 =?us-ascii?Q?TeGcAa09E6AbPnIFmoOwPaLCC+G0wVB3JkfjcNw1si2mFSnvN6kS1j11YmNO?=
 =?us-ascii?Q?DzEAzvwUDo1lO/yRI3t12GB+qUm9WTvr2kTp7B9Cc57YJGrb50qJvcQCpNqQ?=
 =?us-ascii?Q?LrxKlrQZWVH4aihC2/poKTxvkWauKO2q0O0a11XAyzmQZjxQDHCWhRShZCUg?=
 =?us-ascii?Q?Nc7PIOmjr2VJdtrMSK+gYEdrzeN1VLzwKQHTnXHWV3RQ5sTwCfGB8jKIiEHl?=
 =?us-ascii?Q?e0jaMQGR1gLhkFprjtnduSCnaGJEkAO/0PzaYtoJGA5oPTbuxWZzQVegfylw?=
 =?us-ascii?Q?CoYOK3AgqqsPu+x1S4qBKoKqIn/MqQVkOng1Cwzd6bcKfIQgNTMjOb5uO4y9?=
 =?us-ascii?Q?QPkVvUAjauFbc3pyMD5xvwUHe437r5NaqcLzERhvshgev95pgXHipyjzeTX3?=
 =?us-ascii?Q?ZdcfRjFuaKvWqeRB/TsUSIcaRtzXhNFF9M9uKjWUt84/SzW+w8wTll6HnsFl?=
 =?us-ascii?Q?ifvGj28CRr3KcBYx7yqIfbm/4WH23krNoHU2arG4z8JNYd8tmba9yDpJZHlj?=
 =?us-ascii?Q?EphipqD/a/T2BBYbaCZtdv5MrLN6RHDS2+4mwmiYwSV6nmHucHK7S6XspSKX?=
 =?us-ascii?Q?UlSNjq6mInPgnbJ645PYOzjI1VRVkl8BhWg7RXgsn8OjxQyuO1zeLUMjLI9W?=
 =?us-ascii?Q?G7EOI5vLOmsDICdHqey/7ftfmQ0s3hiIs3R3Vx0UQcA4SlXfpCiuef48kSNH?=
 =?us-ascii?Q?lMeBjTpOrqUWd4BOqZrgKZJdtQddfjRxmugAY33KXqAs7hQwCmIsJPc32bko?=
 =?us-ascii?Q?IYoIq8SGstoGHWnhd7HzLmopvJ+7o0hvnm5IBPRung5jSUJkMJifTAk/IOtG?=
 =?us-ascii?Q?WKfzcO8+t4nWlA3QwzbxMz6CsKIrhXmFcbp7/boMd1VXcgdjlDilWOam3wxj?=
 =?us-ascii?Q?QDHk4NntwvlIG59/CTM9l03SFY8+aMpzjembMPCl5d6qdlJNgrfnK8CFk52Y?=
 =?us-ascii?Q?riPFrKw2TWevsVfH5j5Kf22zWmTBIhn3dOWHC1cUw+N4DsUtlkAJLxXOB8sr?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8sjbpLTFtvbGMjr+36aa8SZs/Nl2woU9OvoYeP6YtfRP6tDryRp2TOdIIGoEN4qTs1J7H1iTczkQmW5/iuoq1nOU4YX0FplsmbDPt0dEzhQUrtVQCb/CAF63fNR0jbTy09gaXLKwBrast9HJRrDUutSc0wV4DVZ3UnA/+8OY4C4Nyx/CM1KgvP+shllcwe0p5cYdceZp0b7FO7m1VqNpjs0uAJjIhgl6I6pFvFlgsOf7Cwkurq6ehFzZ3uhLIVzptrp6HSGRZs8gnoKOKgvqZTldJsAWlhXRl/9r/FEQIT7YCDmHQtQqLMwUITFg+PYPjM/ne4xieGvkeL9MD2yEFmGjrErDSUAi47JZzypLNuWekkx2DI6B3G2vnZZASfQLI0Idt93nBCR7cAGIyVjju1IDm6UTP2tTPO0iFg3e1S3zjHIRU9bf+q6W+4KSE7JiL/9+/MUgz81UGiAosMsGwokJj5hhFGFcCB3QXdsxpKTEznaQqjzolNGn/7jk8pRXhmJu80CXMA8KjATS+GeYLpbt2Hl45AkFsvZGSQ7335s94s6AFOR2fbn4yg3/tSc/wSa+PQGyEef6LmYpNPXpVwJGAiZ96x5dUZFfsbWPtUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fe4815-6cc4-40a8-eb39-08dc474fc96c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 13:31:58.8085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTKC4tmP7enfcL5IE+oAGB4P6EjMR396pDKZEVqo6o1Gxr25Ac3Ot3M86cyurIYavLAf5Wlb6PFyryLET7VLCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_04,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180100
X-Proofpoint-GUID: 4lJ8oO29AilKI2nB1eFmFBtcfh2aMwCy
X-Proofpoint-ORIG-GUID: 4lJ8oO29AilKI2nB1eFmFBtcfh2aMwCy

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. The backported commits are destined for the
official LTS kernel branches so that distributions can easily
integrate them into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

Here's a status update.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v6.1.y

Additional patches were tested and sent to Greg and Sasha this
week. Sasha has merged them into linux-6.1.y for release soon.

Meanwhile, you can find these patches in the "nfsd-6.1.y" branch in
the above repo.


LTS v5.15.y

This branch was rebased on linux-5.15.152 and has completed
testing. I'm investigating some failures in the ltp net.nfs group
but it looks like these are all related to NFSv4.2.

You can find these patches in the "nfsd-5.15.y" branch in the above
repo.


LTS v5.10.y

This branch was rebased on linux-5.10.213. Testing will commence
once nfsd-5.15.y has been sent to Greg and Sasha.

You can find these patches in the "nfsd-5.10.y" branch in the above
repo.

-- 
Chuck Lever

