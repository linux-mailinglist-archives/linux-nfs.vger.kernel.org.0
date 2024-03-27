Return-Path: <linux-nfs+bounces-2499-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B17B88EAC7
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 17:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E331F33005
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9412E137C38;
	Wed, 27 Mar 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h4K8kdEi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kkph/2Vr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889A132802
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555568; cv=fail; b=ilqN3lK5PYveuLoqRCWsx0O/mH6yOwRpuR1OYRo83zSc7bzzpxqfilIvqXFe5Ia5Oqi8uUSXFHivzslk6gzC4TG7N9MCfbbugsbE4fWJfTgCg/B2ZnpWKVHpEkgeUTayvluZLj9riq2J3RunmqrAFMJ/SXmbT3w7IcFyrP/nRKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555568; c=relaxed/simple;
	bh=WZrJ72shl3qa5x3YsvimaeJTL4AhXOfkK8CgDzkU2R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HjjyQcLQvvIMoL3iUFwRVxX9m6BJkdpDHi2nMYKn+42QjD+j3BOzW1l7IAsc4Z2pSVkFO1yEukzjBZNcCuOQbEetyor0aw6nipnlR3l9r0BNPNcYqt05EVG8GSLCKmCFGoQN56aI1CzCS2DtLvwOYJbiw+sLIhq+4TMas4/lSkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h4K8kdEi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kkph/2Vr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42REiZ8J007210;
	Wed, 27 Mar 2024 16:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=tsfdKA4AUAVOP7GcZmlY+0sv0QO2YFOSYyUqUifZ25E=;
 b=h4K8kdEiXsIzpqeGw3zpzuMlXHmoKYoHXn2kK2WY/xX2VB+jve9lB7ZiVDjXeS84fjZL
 q0Lq4qmfRR3RiA9TRurkUAe3mFAZBfhTAA2ms8uQZ2BoWMkFXcOswjq+CIBIwQ/X1U21
 kSFpeuKyVjyJe/XekSgCgr3iicaRoFtvdjxOQYL1VRPN21I8bFd+BVw4arK3nyYFeAm/
 6Hm8rGHIwX6FuZV7yihDb1xVgs4dmZYfEjxhupEAkiTL9HVxcEZ7ie5YtrVk2pht/X9Z
 zk/gBJ84piBwgKKvj60+PnNiTNVB0Pygd3++h/9U3oPNSbEZspFj+H+Q62c12fHwdTYe IQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct7534-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 16:05:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42RFVanK019259;
	Wed, 27 Mar 2024 16:05:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhf0hh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 16:05:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic5XJAQFcZdviYn+Cuyli7cjmwC10Jjxr7sYrkpH8D4ZUk4BkI0dxki22r5m/uZo48MBytCz5lreA5rb0ZyjL11XDjqehJrWPJf6RcYy8CCSr+fi1cWjlrYIdAm+f0KQlUt4AwCLac6U5sZOxx1THZRkjtI8fkPW9fHSiUhOYOYHUf2XeN0y22il2JgKChxbiZxqntW4HJMHob4MPOQiP2LIf+Adna7a1yFMMCEjzB33w5T4VGhipY1Rk5OPfEpGr7ObfJVErhLWoOtJNv6QZOaweTXqb92yyfBc7/TxQjONOb1uwwkDwBtNQ4jLnJFO6aNCeR1MTAqrYlkyRVv4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsfdKA4AUAVOP7GcZmlY+0sv0QO2YFOSYyUqUifZ25E=;
 b=ZY8lwPtYwhuTcjNlIul4m/chBLXmEmV07nctGw1NJK+QQRFoCfBIqcHk4sYhUGTuca8v8WMTiz8QmpRyA+syQA5vwaNLG9Pl5Qqc3wHbHPbhxzCkkAUEoC/dF1V/PjkledAoOoDeg/f32h9/Lc5lkmwlyiKYVRmE8YXwD0FhJ+j7ckj6377KcCxM+v6Uls20PLoOg0nmjBSjOjitkaZnruyR3F4ihl8FCa9ASQ+nyHJ6VepeqxENTick/iBFQQ/8a4cnz9gsNN21o2iZGxeekqu4mHkHNTuNjMkG5ePWV3cB+lIFfM+mujh2jsmIxB8NfK2YIYnPONoGFg/zYBBm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsfdKA4AUAVOP7GcZmlY+0sv0QO2YFOSYyUqUifZ25E=;
 b=Kkph/2VrZeKMIgRG6V/GvpTQhGl3TZCq4bH1PIX1Hasj6Q7ePbxvgOcIiTLhffXSE42G7U2rzshxirwjK2KDRPdO+yIdOQpVxdyxZT8AMhMTmtKlqk8Xglqd3BbAFAOiyJTxNxzawrFBrz8i3HbWWqeijDA26x6p+krAUD594Fk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 16:05:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 16:05:42 +0000
Date: Wed, 27 Mar 2024 12:05:39 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: trace export root filehandle event
Message-ID: <ZgRD066XLhoQRXS+@tissot.1015granger.net>
References: <20240327152737.1411-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327152737.1411-1-chenhx.fnst@fujitsu.com>
X-ClientProxiedBy: CH0PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:610:77::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 521037cf-fbbb-43c5-24a7-08dc4e77c0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3DoLXKX5YKNXj5M90VlXR4rlPMmZimFTrPmtq0LpBK7QuDdL2brxqN9W8o28X9sOh7AafIx4riYwp56wBLXiElf0JDuwk6qivEUjvrb/7SatWTkILyO+bLrU/qw9iRYywE5Mmwbb77YquwhEzzEqzF3P/LKB5uKagX8MuYosoq8zquypN1p5yJuBvEfuvCX9MiGl6MYpN/Cj01L+Yej1bzvAtq+Uonpna63Fs0NLMKV2+zazy6ABRp6KN+iLMXmDr/8D5bhusN+RcgSnYhIxglubZcXt//2f+tQfZD63t2nG5IvUDb473ZwUQtqXUqdzfwGYlbRxSWBS0EYHAKDrTCna4fNnmeZ7uL4WyCHo+2mqJlhox8PlO5eevFftMzAsm+RWKljYmVn8GIHvpMRYk33RPAcqC2KOJGDKtmKnmJ7g1D8gZaIfFqCyPnrMq1cfg8ml6aQGnNwkr7BPN6WduM3wZqme849d2GD76LV/P61XNkGZSVlzAPp0L9Nf62gSIiVc7t8JC9IbXl6/W7H5ejCig7w462wkoaE5yaV/H/rtzGtar8DsF6zOVYN+w+vWhSP4aCEXTg5VFmmSpthVmB4d6DHMprDlWZf+A24exQsacGMXRB58fTRrpEhLUZRL8PaA7ptNeEOgW1lBzJpLKWtitl64sHFRi8Y5jM6zBeQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cz46zPFA6HXcyo4jiaNESEz0sXSF4+50meOPD1uMkqGKMZSKwkRnJmulQMeC?=
 =?us-ascii?Q?J9OfaSbvy2eloQxBfOi/TuzAphajThv2juZ/XXl49JH498DG3bn21iTd+y7r?=
 =?us-ascii?Q?9dYop1Qtt5TYzoiZMcwSQlz7KAOKa0N+WhVdTJMX6bfhmMHDXbpbywXT9vRb?=
 =?us-ascii?Q?OdAxMwIz3pMvynjGzomyCdduD7DfJo9Sk+flWErb16QtbsfEiqWaH5Ru2qr5?=
 =?us-ascii?Q?dpns4SqFmF8WjYIuTPXErAFtOnQIKiDDRezm6F2kbuIwy+r+/zqEQ7BkpTps?=
 =?us-ascii?Q?MRl9cMMR5YrhPuYihKTmaiEQj2yQXQwB8y2zj25wKPfyVgOT8vtLOdBCfq3x?=
 =?us-ascii?Q?cU3oBU0VHQK0YO44TDj007p6DZ/NSYsXsEi1z+QcewkpSagWjyIiGqwBTuMh?=
 =?us-ascii?Q?nll1NY6tGkYrduP1Ym6kXX7AXboJ7mWZKC3wn3ARr1/8xe/GowKynHEc6ZyY?=
 =?us-ascii?Q?7tvRG4EkNwM/AViNn5YjSSkCn0Pu32gPVt9MQtxH92EcyLzu1MWTGoCpCZni?=
 =?us-ascii?Q?a931SZDV6IC+TgOuGHucSg5MKLprHxl9FAI7Krqt5/vTgnHWnECY9GwvuPqg?=
 =?us-ascii?Q?vnl/T6APnQ0TjuKkQU/Vn9rTppUIlVZs+J9EJA7KdbEtpMRns+JVe0b/JqJi?=
 =?us-ascii?Q?yKvZ0r5wQChY6luw/CEkxIA7HQD7l/lRIixDkB+qmll+eMrLDs082Pj1AXwC?=
 =?us-ascii?Q?0E120qS/qgG9YxmJUCLddwVOWLACSiGirKZbPFmKEEGfqwqkwz2pgD+2cBYY?=
 =?us-ascii?Q?OEXxRSPGhihizCOw9PeIsx4GG2kOLgt45NxbqvDu2J0yCE/2kkPfPLsDNbWR?=
 =?us-ascii?Q?7Nz3LcrRzvztWHtGnwJ9yLhPOufFSp57CMoy3+S544EAvJ8wI6xNkilq5DVe?=
 =?us-ascii?Q?73sx4a68unLkG9YkvJkg5bQGzCTJ+uJi1IDUgujguSGs4OpZbKD6ef5U3Wed?=
 =?us-ascii?Q?fnOMvzI4LxH32y0eQmbv7RMfMbx0iqpGyHGCrXrL4XtqaEGANr6Sl9HUw/YC?=
 =?us-ascii?Q?rJQc+AndaOey0FEjHabBDfM9YH/+gvwHEVQY8dEWzrVRwGXbbYaG0sx+dXfg?=
 =?us-ascii?Q?jLg9hvkdwDJJTdBxFze7nHAmJwOsK1TALqwbBG2d5WDBdUaUTNHQaY4S3ZDe?=
 =?us-ascii?Q?xYJRVFYWiUFUuE8rxCmYuU0cGCgrAjRpc8dY0vNhgswm5s2jYuLiw5f+IIy9?=
 =?us-ascii?Q?F6LLJPEyhMH5lU69LSnr1hfHRnGgkWYAlBvsxUegJwZBa3m6JdGe1AF+GUAH?=
 =?us-ascii?Q?YKYZLb3Xo2uMrYLBWyS543a0z4wtvkjUZ2ovdnaWblzIjHWXtlh2JAN/YG6n?=
 =?us-ascii?Q?7sn8+amWU+3Ql52n7HVBdqGA4uLRvy5BQ0dMA56v7MPlcZSEq8x+qXHcDLwn?=
 =?us-ascii?Q?KogGaxrayM7TCHW7yEWmxk53QOnE3tKDXaovgaUE5JoKorpIDkikhrlB7+d5?=
 =?us-ascii?Q?IDC4/j+WWRrWXK/TOG4Axi2M7NWK6As+pciuSGDz8Phaljq0M6NoYa2BRCos?=
 =?us-ascii?Q?G8AHYdRHStPV6gJoFfa/goZUL6WWCXKtpO+34mYsY6rjC2MtWUK/zGpdhdtG?=
 =?us-ascii?Q?PE9uc1Slt82vvKKDO2qUe4WmQUCgfet6T/0os8YTXHwNGLEyXZrR+luyedcy?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NQZGHM22mr5wvVepT7agXbPLV58SHPC80gCtwTxJldEqCfZ+AjBO8xZGRW2yDWpt7ZU0nrFnrBh6fHfnDJuyVlX7pUuTz852gj3Nfujk0vuzh6VfYPiD3ALbmAbp9tBMPhd6ESpcmsFUKPY0ZyGZnV6L8E12bchr0uWL1mNlKUh0gtofqDag2OC/AF5rsng0scO6qQLza0KY1ttR1V64oOj443cSbBHiLnUlfB6lWHWUQh3Ze0ZGFpfQ2BDt6wjzE4V2hQgknI94mHsEl1ErbsHLLvFsBjR9yhHSpkCt/hNPosqkn1STTahNV+rrWa7rKuHaG62KJBaxlLyQyrFkpvOtupxpjsNhuM4rzQgZeFuawGb+hEhmvPy4S6ivljeHFTN7deDcFh6txzwBgMPSln4V6QAF8SwGvRseJspr49CqSPwXO8ulymUku3ifK66qCVdhFkTrJrHq3drCoC8E4l6sHEdKgfE02lMAc4snRJULnexezwWNGjw9s7m2PuF8E30kXfaSOMAzc6dTbvwDhfLwglZtdvCejDc6jT/GTg/OEPCcftc4qdEocoLxdeVoMv53UxwWdSWgdiWt632y9TKt9K2p2piNy+GZfN0G9tA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521037cf-fbbb-43c5-24a7-08dc4e77c0d9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:05:42.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flGzPiyHw9fGqUtNssAD9e8sFvz5bFO2PhVurI5bg+dvzLAKB1YPd0Yo5LymPCzjn3f42VCTaopL+Ukp21rEpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_12,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270111
X-Proofpoint-GUID: oIDFjh_pDBvtLp5jGAEX54uC7D56ZYoV
X-Proofpoint-ORIG-GUID: oIDFjh_pDBvtLp5jGAEX54uC7D56ZYoV

On Wed, Mar 27, 2024 at 11:27:37PM +0800, Chen Hanxiao wrote:
> Add a tracepoint for obtaining root filehandle event
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  fs/nfsd/export.c |  4 +---
>  fs/nfsd/trace.h  | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 7b641095a665..690721ba42f3 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1027,15 +1027,13 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
>  	}
>  	inode = d_inode(path.dentry);
>  
> -	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
> -		 name, path.dentry, clp->name,
> -		 inode->i_sb->s_id, inode->i_ino);
>  	exp = exp_parent(cd, clp, &path);
>  	if (IS_ERR(exp)) {
>  		err = PTR_ERR(exp);
>  		goto out;
>  	}
>  
> +	trace_nfsd_exp_rootfh(name, path.dentry, clp->name, inode, exp);

Converting the above dprintk to a tracepoint seems sensible.

I'd like to hear comments from others about whether the new
tracepoint records a useful set of information. We don't need to
record the memory address of the dentry, for example. Recording the
net namespace might be useful, though.


>  	/*
>  	 * fh must be initialized before calling fh_compose
>  	 */
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 1cd2076210b1..a11b348f5d6d 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -396,6 +396,45 @@ TRACE_EVENT(nfsd_export_update,
>  	)
>  );
>  
> +TRACE_EVENT(nfsd_exp_rootfh,
> +	TP_PROTO(
> +		const char *name,
> +		const struct dentry *dentry,
> +		const char *clp_name,
> +		const struct inode *inode,
> +		struct svc_export *exp
> +		),
> +	TP_ARGS(name, dentry, clp_name, inode, exp),
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(const void *, dentry)
> +		__string(clp_name, clp_name)
> +		__string(s_id, inode->i_sb->s_id)
> +		__field(unsigned long, i_ino)
> +		__array(unsigned char, uuid, 16)
> +		__field(const void *, ex_uuid)
> +	),
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->dentry = dentry;
> +		__assign_str(clp_name, clp_name);
> +		__assign_str(s_id, inode->i_sb->s_id);
> +		__entry->i_ino = inode->i_ino;
> +		__entry->ex_uuid = exp->ex_uuid;
> +		if (exp->ex_uuid)
> +			memcpy(__entry->uuid, exp->ex_uuid, 16);
> +	),
> +	TP_printk(
> +		"path=%s dentry=%p domain=%s sid=%s/inode=%ld uuid=%s",
> +		__get_str(name),
> +		__entry->dentry,
> +		__get_str(clp_name),
> +		__get_str(s_id),
> +		__entry->i_ino,
> +		__entry->ex_uuid ? __print_hex_str(__entry->uuid, 16) : "NULL"
> +	)
> +);
> +
>  DECLARE_EVENT_CLASS(nfsd_io_class,
>  	TP_PROTO(struct svc_rqst *rqstp,
>  		 struct svc_fh	*fhp,
> -- 
> 2.39.1
> 

-- 
Chuck Lever

