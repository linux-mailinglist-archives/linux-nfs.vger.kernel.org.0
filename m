Return-Path: <linux-nfs+bounces-4498-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C53691E439
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3401F2232B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA7167265;
	Mon,  1 Jul 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gtSmFnOw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KJsplNQ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344428F4
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848121; cv=fail; b=T+qTMCVoWyJlEsUNiKJsOvYNMROOcg6vYh4+iiD7+KQUXf6o4T9Ch+EDPV9vNPkYJt75yCm8/UMHONrt6DcuDiFuURky1H1xy89xLnAM8VJSTJnLumlAHAtXv1wf5u78o36PmsWN7peQ2ihQegoJVQlqAkhJ69bbhzzk5Ml2QqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848121; c=relaxed/simple;
	bh=ZeQ5Bc9NGNbrKHADrnjXdiJmFGdWmX03OccflC6AoSU=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=sHbDaN9y3t+unQqSHP1pJHW+vBLsDKlp024iCbR4KNmf1KMYWo5tTCD/K/aCfAqtvk9ZtQtK631xSBoQVTOAy2sbt/AOlHN1BwSQR1vMGskrzDUW7n+QNaJ40BudiPnlBccf4RyayzrozyZnnpqwA87Bo+GJMYOHpC/f3e+Q9tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gtSmFnOw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KJsplNQ2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461EnHxt029759
	for <linux-nfs@vger.kernel.org>; Mon, 1 Jul 2024 15:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=IxkYZikagMSwyVbh1ThPtdyuuZrbbM80PX5ztiSgnbA=; b=
	gtSmFnOwqCfEIgHleL8s0FQNmDWMJwVeri+FWBKEHgDyVwDA8sURvzg0rQoNEpLf
	aURpDmig5W1e5a+ewJkTHzEihMKKynmtphNggGTO09t96bMsYJqTZ5uOZC5TPPeO
	FxriBsXZR7VP88tuKjDERub6QRdbEht/tL+5yN+tFkeeFmBcsUSe7/h/2zYhx2j8
	2KjpNV4gYargehdVSPIQ7ZTEcDVlXpMIFwADh78ujUL9Qt2rzXsR5NzsdlrvLSUH
	nwtPHZ4csHL/1SNOfIQn3H894ycKrVO2lTNiCOXNDBd5sJtFWWVlQPQINTSrzY5C
	u9IoQUZLmHlItEcQQCVV8Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacbprw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 01 Jul 2024 15:35:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 461EV4GI019083
	for <linux-nfs@vger.kernel.org>; Mon, 1 Jul 2024 15:35:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qcyewf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 01 Jul 2024 15:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0VFRVDC7IUsdslS8mx8Z5p1TykJHNGQmEQQDSzs9OVXnw0Q1JKOoiP0i8SNXR/ZV2n0fxOtt3jDafR8bGCXfqEcHkiYRhYku2V0sEDYLWPnvtMhjsBcM28hRpeEiFDlWBgv0y+hWPb+01a19bXnyPgj+No0Gmc+DnRzamoahEbh2XNZV6WApn9Vl265wdn4k1MN94LX95E5FjcJnU+x5mL1T2uggHtdCuAr9ql1b4bDlnj/q4hFyZFPZshlY+TrH4VeynqBAg4Jn/dZLajqkGDn1unVzH+VN0VwhaDbIngLu/zAMcEnp//cNPFwdQl6ZehDVbaAXb1cVuh7Z3eGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxkYZikagMSwyVbh1ThPtdyuuZrbbM80PX5ztiSgnbA=;
 b=ORrUeVdZJ1jrGk/aonk1XWnd0iZZbVZZN9gzKKXvHCdsPLIde32FOI5x/nHmIkVd3v7V8OIwhhvwgXsu41Ke/QxlxedtqNhQdnvMDWz2edqM9I5N55rJhPmCuLWuf18BW0hM5s/yewvgQjhc8lkYivana8uhmQIiEtlQHtNrTAaq22mCOooagPGMEYD00iOwuz8303f2OXcUzU3fjUpItpOZXpPN88+9pigyw6bKJkiMjZbwIBx0j/+3ZKOli715nd1b2pGJbOXWMQqP+UFIQOGCTfdDR5AQCqKPi7GjqJVyFy5bxM2quAfD09MfHClNOC3rcn3C1Sa0gT2Dx4FhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxkYZikagMSwyVbh1ThPtdyuuZrbbM80PX5ztiSgnbA=;
 b=KJsplNQ22S7O0ao0DMXYwk+glZFvkz9fAn+lyRYolxoFEvGEuEHHbck0RONVTCIQFUmtnu5LabDdMEuQaWS9m4ZRyoOfn5meA7v0K8WaAQ0u0EWptFxyb3wLWsTsYnAnKDZXhpLAIOAYBIxD6gvgAQXx8dzCKRBTgXZceR/Gg6w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4224.namprd10.prod.outlook.com (2603:10b6:208:1d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:35:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 15:35:09 +0000
Date: Mon, 1 Jul 2024 11:35:06 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZoLMqqq88vcdhbGJ@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0441.namprd03.prod.outlook.com
 (2603:10b6:610:10e::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4f48fc-73e1-414c-cfeb-08dc99e363e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ccHb2LMhxyl0nsfdATHKRdFUROsBGaC2kHhokYC/MzhQrmnFWTcjndMbFpQh?=
 =?us-ascii?Q?yAiY5Zsx2looH3JXupyFOHPj8Z5NWDCpHuu3PeFu4Xgy2ySPQ3IXF1SbTpi/?=
 =?us-ascii?Q?0Y6vGRtUQghGdaUZzr1mFtxTvpDfPmaslUOH8j0OOlAKhnYs1hpXrywxedqC?=
 =?us-ascii?Q?FmqYY1c8JUJ2uAsTt4jcOfmAAw39P/L5OvuUmUuxvYoXC+VergmQ0OcQ5qix?=
 =?us-ascii?Q?bABHoYecE6x0DnyuBrZZ57QJprhC/G+//7X+QO7JDHAnC4e2Ck2XfBeZTG3t?=
 =?us-ascii?Q?tCPwPjfSONGsannyijYS+CRZAgVm7lnCFxr1MRrPRvgyAFiRbWn4XMnvr2Kg?=
 =?us-ascii?Q?D5Wxir4/Kx3JUJJgoWGP0VesY08r3st9rJBti5hdNqOCzZWi10YRUrU0dHwH?=
 =?us-ascii?Q?sWKR3oQDAETI12Wb9G73fX7Luk2wRVzgxjU0nV3BWsqzNPEtWk8lgI97dEEK?=
 =?us-ascii?Q?GkxkBBKLsjG27LRGkJ1rW9rrbvSEAlzMAxU6kMzjJSSlcNnx1rJM99ibDxng?=
 =?us-ascii?Q?XJ1k5fAEQuz+DwyaFxrHOxZBbs9MvFb4I8TzdlIOW9wdCBBVwMXjeZhkHEKA?=
 =?us-ascii?Q?KojdIXicyJXdunhqRIgqgBmlZ9T4rqCjuyvGLY75v3sAIV41w6hjOKR/XGZU?=
 =?us-ascii?Q?xaOsfO2Ws+troKqE5hGcuCba9fSX5JbIygs+0gfqxPtcVKnRNQZePS4PP3IE?=
 =?us-ascii?Q?cwd1AJmg2+n6JlqToMgZNVDc0SAYbBwM48rj+VHNtm3E16Kq867eFZS/QN0K?=
 =?us-ascii?Q?fsDRDweMjtBAVPZ6F1w+O4cjGE9r5u5fI2CndCZi+EKVtSy7MZuqqDtkX/Is?=
 =?us-ascii?Q?DNZdL3IH+0TYheSVleKAUOHl3/exqT7PEe229hNPeK2H+8Nc1NVmQqNoh031?=
 =?us-ascii?Q?Me1yabKVVRJPtT+Ul053eSBtJNIfiJSV8z9Hhq8q4aYAxy44d7IXBFtoqfUL?=
 =?us-ascii?Q?ZRVDrJnBQENQXxB0DdcMQKU/+fuZkuNfEJe5vn/1Hpvc/HCRw8r4Oeo42lyk?=
 =?us-ascii?Q?NMv7tqDjP7WJcCSUhtaVBsPSHKzpwiMfAr3ehpZizfJ8k5o+ySjD7rxXVVVN?=
 =?us-ascii?Q?2TrLcZAs4/D/Q3PBzvYMizFxJIy9T4cMefV92CtP4zGfe5XbixFpX0rR/xng?=
 =?us-ascii?Q?m/ZGd3k1oWieLqwPuHYfnYwjGWHnaEwBtJ5slXUntnvpvtGXBXqMkkZAh+OU?=
 =?us-ascii?Q?6rmHWWZTMbvtEwsbkryDXdcRSA9f4pO0UI9VFicOTzTo8YwP+pwrS2WJ3WsT?=
 =?us-ascii?Q?PYUM1/zRD3xW+rFIjkgec20y7lU8hB+aWXY2d4boE2dXsipfhJfhSXT6qDKH?=
 =?us-ascii?Q?Mco=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MuNcVBDeGWILOMj94PS7YsgeLkhXRgkq/DxeSelSO3AYQcoUF34Zdz/whmhy?=
 =?us-ascii?Q?/0aY0oqXUOM7Pb6xCRQuo3VdKLwmXL0DuX9OmxY1FgRErCVW8zHIeD8S7N8b?=
 =?us-ascii?Q?UbcltaxXYSY5pinxlosYcKa8o26sjAtNB59vejytd9NPqAikmANsvlFqxXvP?=
 =?us-ascii?Q?uHh7GuI0d5LhKd77vK4SkYEbfbUNLNuZppiRQfm6muawme1AqpLD9Dnisnse?=
 =?us-ascii?Q?uRbOX8BnSIrRqJ2ZwSQA9//VLUg+RR00eD91I2DYCH+JEmcrz29JNdSosq/p?=
 =?us-ascii?Q?j8a37WpLAcuK4f/jnNJChrvjfQ05n+zCvygB1aHBHAtNLbbkaVnB6gRXCiM5?=
 =?us-ascii?Q?/EhxCYT7Y9NxFPGc/tpS+WwpchXI+DVOV/M7z0cCuZxsSUJdB2ybirRvBXVk?=
 =?us-ascii?Q?CPOBjs0uucUXMpCeqhi1xzFozb37rQKXYBQgMtlH20cT7wQtNAKy2u4LZBYW?=
 =?us-ascii?Q?nUaloVVaHfgN90EMqFXvfAeh/C0ge/xrCOfLlRNI68Ab/BlyhOY1HXAoXXqe?=
 =?us-ascii?Q?eWCW9VGLmMavQDsNPkEIqBmdFpvjqurFwI64Tv89P6/SLmh4a5Ei9zf4uD5r?=
 =?us-ascii?Q?1SM36b1Z8tib/l1zSQwrxtFksvEfRwQ/ZKFgR9q9zGfm+i7heEXgi44dS1sK?=
 =?us-ascii?Q?6O+Jz1YZT8a0eu0mxowt3g6cJWuguJm+5sC8halRHE6GCVrmZkgzEeFl30My?=
 =?us-ascii?Q?VTkaBox9+oSKLvFdiOUmxfy/YiK5wXy2wdAz7YUxiWoGBvtnbx7sh+dYQ137?=
 =?us-ascii?Q?grp9/AOj1uMVMw7EAFoZXWdZC17johO5ejUkeEJDQX53JpIeGPBqqhj+OCsl?=
 =?us-ascii?Q?2lE/FgABg5E3VvM/IEF4gx6YS1Yp2qa+odeLP8VUxnswiAACwDkPBt5MW6eG?=
 =?us-ascii?Q?oyY+P3F9nS035ZIu/MXENur6HRfUO04Bfi+75R89VEqa10lrhczKiM/BQFAG?=
 =?us-ascii?Q?gxlGgScZECZH2QckQ4+oGM/bvYPZrBPC7CbK2bqW+sRMFx6VVPagMfa93++w?=
 =?us-ascii?Q?07g1EZ+K6PDR6QMLHpsL9njq10ILbl4P5D51tzB4kpTiQnJfOqh0E2jjNH15?=
 =?us-ascii?Q?qZH7eqAwOnDdpnrvEjWOiIkpY3XoDzFyct2HvDi1Y3oXkWOo0G5RB6ZGd/Na?=
 =?us-ascii?Q?OgI6S/vbw2lu5kcAnVrMtaf1OmdJ+z1jrzsSeXowSK9AYTV67nmUBpXR6dZZ?=
 =?us-ascii?Q?0fyLsTuHNuFWkX88ieSmti6rlKBJOPnhobW7Ctzw4bqujgECfPXDyiVLpVkw?=
 =?us-ascii?Q?zABT/zObfZKQf0yt2KELtwY42qdMqHVErQhxSkBFv5POaRfPqWoAz19wVpk8?=
 =?us-ascii?Q?yXp6UfBxq3lIbwFDL9JRGNQNTm0OT8CTDQsKLEAYYsjMla+wHIgJs81QBljk?=
 =?us-ascii?Q?by95lm971onkARgPYQPcuKsM86hYS/SIJSHLBB5Pq9JljygA5bjQv12wFBBg?=
 =?us-ascii?Q?qneWe3ebBfhn23MxI0y4DWImb6Y9FtL/x9IQ1Mw2JajmL+MQDLEb/VUbyUeF?=
 =?us-ascii?Q?kUxFdv4H/0Qt6ptVUWwSe47pQbKdfZEIonKICpoRBBs8V/H1vcwtK9d+zBIv?=
 =?us-ascii?Q?+saOOjeXpusSs7DkG3JiBCGEpBPmtLUOaZwRfB5m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9M7MltnZWF/2DXsqR2kY3TZP9rZ1H3wfhLxuoHYFOY3YeTnK5XM+IBP9sNmAThyKwPApipsBgWlTTh0bJ3EPdMetEICkhAGLMBGvbRIRqvTUW+Y8+epzzsoXCD1W+hTwTeAwJmHzKPmmdk5WR5Lea7rt93yuXFoSzS58s/KXpfXvbXBcVgQDkENVjxluRymrN10COxS4lTw0eTYwF66ZwS2D28/IHw8UZsNyXISbnF5UDpu8lfnwCu3UEuszOhAET3SkDtUlG950SF+JKCh6ytlcKLwdkGeVeviMbuCBhx+NDoOFGzeJzvzGHafS8OYfzyHyVwk+DhWelxnjhzvpr9VNAyC/eAyoK7O5jMx8RCCFmj/wrG9T8ok0lsKrq3SkhTIaJQIm+sb2IAnD5f1e72P2jnIuGooeN0gI69OK+aGlQ2Z+tJyadQ2KemEThfCmNQMQYC7mdccRaZMIrzdLQGLL0CD0X43G7PZum0jkLkrLQETlq/PGrUOBJpkbPga7cOCgbknjP8s8Ymc4itZXWVzYS8o7InYjV89AdQvazcoHJsGc/akk5hqX/a3krcdQ4MCxoFoZdKMGv9SrKM/cxNBIkQQMTUfPZFpqx5vj4Uo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4f48fc-73e1-414c-cfeb-08dc99e363e4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:35:09.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRvMF3X7CRohA+EaNRZ3tYp/zrl4Bsum5KzSVDPC8z/ssdXX0keCmYzyrd0QQX0+mVCgBqcK84YcMa0A2SDKDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_15,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=893 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010120
X-Proofpoint-GUID: O2FLJeqEdtaiUvVe2ImF1fEBXCQ5A1KN
X-Proofpoint-ORIG-GUID: O2FLJeqEdtaiUvVe2ImF1fEBXCQ5A1KN

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.10.y

The bulk of this work is now in v5.10.220. There were a handful of
missing forward fixes discovered that I've now submitted to stable@
for inclusion in an upcoming release of 5.10.y.

You can find this series in the "nfsd-5.10.y" branch in the above
repo.


Out-of-kernel follow-up work

Amir Goldstein made these review requests:

- Adjust the LTP test fanotify09 to update the comment with the
appropriate 5.15.y version
- Update fanotify_init(2) "FAN_REPORT_TARGET_FID (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_MARK_EVICTABLE (since Linux 5.19)"
- Update fanotify_mark(2) "FAN_RENAME (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_FS_ERROR (since Linux 5.16 and 5.15.???)"
- Update fanotify_mark(2) "FAN_MARK_IGNORE (since Linux 6.0)"

I plan to provide these updates once the NFSD filecache backports
have been completed.


-- 
Chuck Lever

