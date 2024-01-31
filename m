Return-Path: <linux-nfs+bounces-1630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DE0844321
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 16:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593F31F2B069
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C349512837F;
	Wed, 31 Jan 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l8viqEb1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uR3aE5kj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF25112A164;
	Wed, 31 Jan 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715223; cv=fail; b=mecB7b3IMN2Czi+idN6HXIMUxFhdxPjQzZGXggiU7d8v1HyzF7cC4RUbMUXXSLmLAwRtuclt4iIMxlQwOdRVN34fPyQLjxT8S5H3oAvjm676U333wcn/i154LrM1PxYPIq+fU6XmlV5MBIAowHA6OEoY6SDH43NNEvXaUI9zMZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715223; c=relaxed/simple;
	bh=Zyofv6JXUv5rsGW+5PYtSinT62Yiq/oQFVYjP9RX8GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=poqmq/17TlafI610fw2a2WwPBSyuL710iWJ8fGl2qppZJBbAKqpznXfyZtAkCpyBnKNTUqY0fQP3XJfk3Zqjf82BGw/0JAWzlb+6hj7K7IrH+uRacuz7BpFEsBmNCQPZTfcCTDJPney4ecokWdM43atpY+5ZmZT+EjLhgqi0Tcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l8viqEb1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uR3aE5kj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEx2QW009196;
	Wed, 31 Jan 2024 15:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=h2jjD6w65+MXWw+EKhgVgXj/tgUdrAT/jjobQPAy2oY=;
 b=l8viqEb1nm427qsBjkLuyjFSXkpUPjHUVVxNfdAMYjTgUgCaEYkxvPtT+sOm5aPjG6+5
 wOYXmfgkRnVUapgXTEeRuYKsPtsgMGoM5BQennLlStYe2RdIQHpLI9FiFHMCDFvjyYk8
 xLSm0f143eTKesV+iAPoopJ1Zwdo//Mt6tUj/sNjh0W7BKBhMRD+307kq20UTJM7hamT
 0FSMDlRtIPjWTbQKHgmM37iFjZ09qs+ddjU7BXRNq+vLOXYnrDeyGGUl/XBOrze7mgmp
 fQv/LP7arKX6VQ9Wu2hqwprk70AiaZGQEJWlJcrBWDYBfhh4wQe00QG3OH41kiHx/Z4x zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm424hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 15:33:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VFWELn036070;
	Wed, 31 Jan 2024 15:33:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9ffkw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 15:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rjdq7D7yzZnC4KgrEcoth0QpE6q1QN1ar3mR1SvWev1kM1Klz8dnnT4CdLsRsg2vQaXDB+nb7pEPv/iiFWaUD4JxBffo/tz3dYSbTt3n1Z4BBCmSLqQuW5lAYcJOLKdkdzet3MWdeJiqf8Bs1eey2InELa6nhFVENh5HTO/UrccPgMcDyjK8aBeOD/T/rt0Tr4zP0tdeHaKh8JoA26iC1nWYBjSYMs+97AoZExeWYk5PbOF6WC5jmFjZU0LZE0kctVTrEMOtFIGGHq5YcrTvjDBY1IgENF1HpTG/lHGKhVyyscUACWBRCH+JiIpc4OvH3bD2yhbdpqYOTuQ6V6NG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2jjD6w65+MXWw+EKhgVgXj/tgUdrAT/jjobQPAy2oY=;
 b=L2Z0VZ+92bGgzUjTMTqP5R40DmOj/9jvY8qe5B+zmIXdv3jV9MqJRHukw+pD1EV691YXSFgUpIeeQ9ViDfs+2aWyofl/s5LOako79skjX+HYkum4DRu8Wi5AfG59SvBQwxHk7ZRVmdxB2bdDosczoEkwRbQvjnPhM5f2xxJNQE2KgC9CU/aW38so0VMYZrl+O8TAnU10QsewNPmPl8bMp9BqJfs0MrECae7Dv2TFel/XJEaZ1m5opRcrhOg3AwZ1fYHwJFKXpbluwvfaJ5twrtfqF/jOmiFXfYVyW6hrm8bdiEY9/Aer2H+JtsRSZ0+gOMXSHYjPIIEeMaqJonhfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2jjD6w65+MXWw+EKhgVgXj/tgUdrAT/jjobQPAy2oY=;
 b=uR3aE5kj7tidxyTAKzPfYva9okDLqgJyHUGXM9Wilo/rgmzLRmAoNS2lddQFgXK8UfQjE01XIelAAOjfOkSSjDtG22v+h3IXi+lshwqUKLqq9csayeA7c50VWLjTTY4zCkqAS6+VJtGNeisXILjutemgbSaxBiLcxjcbFL5cLCs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5540.namprd10.prod.outlook.com (2603:10b6:303:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 15:33:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 15:33:17 +0000
Date: Wed, 31 Jan 2024 10:33:14 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Simplify the allocation of slab caches in
 nfsd_file_cache_init
Message-ID: <ZbpoOtZlxt7gWEyI@tissot.1015granger.net>
References: <20240131065653.133965-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131065653.133965-1-chentao@kylinos.cn>
X-ClientProxiedBy: CH2PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:610:53::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cd954e-6928-4b63-7211-08dc2271f238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H0ViKrpW+rJfEI2Pu8cvWtHbSs2W7lUYrFYmGnVwBXTbdnHcOD2wf0zzUul1tr+FLmQcieKGbfWIC9HCXaRfi/y1wx0h98opFL1LJupnzVtG75M9SFzEtEY3v1t5jd6xTiyj6OvTAa87LrbHPWZfdtRcvZpx+nUet8bKIefiuk04LS2OKIhMJmvB2HP9VN6obBPl0PFUHytDJ9nrdqwGzr9bjR2z+yYQxRfvN9Cn3O0lBLvODAiVU1+PO00m4Ffn1SK2JtmEeIipT3V39qMDQtkB8baDyUqzxz8ThBrXqeHy9G7tH3hG2i2Hr6N7TYTYvELLGEVLLRY+ZR2cyk8ZXfArkjG5K2OjU27P+JHerV5Uk6U0DgmqHxBuBONBzKJSkJ50BE8CTyMr1AjDfMFrXgJ3idmQKDBH07aFviQVT8SIWp99hIzN/fKWTulnDwN5NbdCzBqpAWqVYJIO2h0W4A/CbqKS2rOASxIV9yqifL0AZJ+y+I3rLLn90+DIoXP5kUxWmmruqeYNJYIrFVmQqgx/aeIw/uVUbbLpqq+UUiLMW3DGnOeJqrQaJnZoOPMO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6486002)(478600001)(9686003)(6512007)(6506007)(86362001)(6666004)(83380400001)(26005)(66476007)(66556008)(66946007)(6916009)(38100700002)(44832011)(2906002)(8676002)(8936002)(5660300002)(316002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?USQWjHmgXA5OmjK2IX03Z26UmPfy2gUFQUyjp1/a3m8ZGNLxrrBSO35tn3P2?=
 =?us-ascii?Q?SKXExm8tCJH2eaB5tgz0YhVQuKlNvRz8rpkaXiKEdHtnxt6Ync/IsbVfCVbX?=
 =?us-ascii?Q?Bh9Oe4iz+kDy3uiWJHA4xsmMcksnpNxt64PzqPLKPpgBtL3OLsgexIEAboul?=
 =?us-ascii?Q?dUx30M5WOCKSc0RZLU7de78OuKQ+Ve/xG98Wtwhd616gpTjgwj3cEOMEIkaR?=
 =?us-ascii?Q?hOyuuRDn2dugKn8wsfkM/9kk0F0ZkcH2wVL46uYgaushAajoDQSxfmcHNu0F?=
 =?us-ascii?Q?Z9QlR/S9mBnYeyDm3CS0FBVNagOd3kVgsMfA9xvhA09ntGZsmIqEbxizNhW7?=
 =?us-ascii?Q?FUvBv09OwHedOhrhy+i7PHJ0hhmTSKF+S9ZtLKBbSgboVA050a9R5/95SMwV?=
 =?us-ascii?Q?/ZybOEq+P4vH0nFU0+riomer0Loc2rNaczI7BW/K5rXOkWCfsBnQsk3HJevQ?=
 =?us-ascii?Q?EDijuEmld8tO0VYs+IvizI+LXjR6TvIOzOSYMzml5nFJQ6r7Bn/+/lTcTscn?=
 =?us-ascii?Q?gAtynj16X0oku9VzVBFM8VnHt9Uz3uqyaA+B7cpwplZ4ufo7RaHb/JP+Xvtd?=
 =?us-ascii?Q?rPdqNUIejVep+VyNKTPnJVjuhOVQ+ZlqTIyl6xoNAPcTnjoXvSRVtcJuUo/J?=
 =?us-ascii?Q?lrZWg9T7HBIMvIQmV8gDRN2CzMYcqDR4beC1TW22D6i9qCFRPlN2VoeJxTO1?=
 =?us-ascii?Q?lH8xXrBvPEDKp4Pe/dLC5p0IsiWe+mT2NUQMdCQQge4sSU6787sqglWianJL?=
 =?us-ascii?Q?13j+hkNGO0bKLPN2aUGGFmbGPpGd2uSj3JQJLh+ODj+1GKyzJsAy8auakr1y?=
 =?us-ascii?Q?LAYWtMCMXqQBnvDqE+kSTNeZWKS9jCfhq5eerjTxIMlkefKvDPWd2L0IZhcP?=
 =?us-ascii?Q?/cOX+vt61uUKaQBfnsba4ihlKyD9JNjjb7Od+vMA3jkWgPFZuDaRSyCMmoki?=
 =?us-ascii?Q?7ENCH3KI61p2L3rzP5vfjsyUo8HfeOPTDf6xWxiehaFwQ9hIL0hkNaRNvcei?=
 =?us-ascii?Q?hd4LPIyH9iEYx5R1UUuB5Pc/2NJuEcHqzZ8gGcFQRy6l1C9aRf5qeW0VmsLh?=
 =?us-ascii?Q?91vn+LFiTju2rsuPk1940mc0Df4qrx6g7JQ4Usf+Tzedx/Rxe/yaZgb2Mog7?=
 =?us-ascii?Q?oUlG9tQk5+SuQvcIEAyI877sFzbwB+BIEfF0TCBc5yypnLnuK6MYYi2rqQKe?=
 =?us-ascii?Q?Wx5h/pzjfNJ3s7Q6RXGnWnPYbqKBlV3ML9sr1LhFC/J/sxnOGqUPQFnLYuEp?=
 =?us-ascii?Q?FPsM1yBmwd85F7MtELO2fd1MlgSJ0XyJrhWV2nOA4JlFuO/JqUCvilNd+AjP?=
 =?us-ascii?Q?at44fRL+Ze2uWA50arhXnZvAL28ArmbhhxFF1TlGWTLvDHk2VVpPajc06pT+?=
 =?us-ascii?Q?ysnbnWn8jc4f4LEoJX9XmLzifksUNcYruA5w2RNDBnpqwGU47085PYMTkd1Y?=
 =?us-ascii?Q?smfbnjOQTghlTYHNjBP+7PHD197cC0MerIzNgCIajDCPs+vGn5jVbxf8DSLZ?=
 =?us-ascii?Q?jAHltR7AbQ7syMLsVYzFYeHVYoGDNpCdSrZ5kH4okaPE6OV+RYKBHBKmB7LJ?=
 =?us-ascii?Q?jpbCMbiJRtVMslBPBwBRGiSvmFG3zDkxcSRrnZ7qTI1B3yPG7rRIHryG4k2X?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0ZcsNZ/tgt3h8+RK1B1MuH19RkcbXSaxDATLujPgdAz8s3qQf61Lnb5gBoWIQt6MgdOgFf1xKFn8uULYzQrr5bjSPqSFXaQCL16/8GX5px9cyTr7yt9LZitU3jdXZ3aJNhbvZpaYceeos85k/Als+rSuDm5WQ6G8ukGJNY+Y4ESE/6jxQAVnHLsb2/5fUszMR3AsFYpbgEO+ognZ4Qx2i3Iwvt4mPc/21d/gVUW/iTi9aJUeGdzrLJPWBLCcC8oM3RLdi0jnb8MaGgIIQ7GFtdxjBar4ssK5CGD2yDchjizHJzjAPAgj4T3dJ10VEHDYoG53NGUYevERTT+cszmUbyatjmDoeWn3XuSFdlv9gKpqLzr6maYph7LzlSKmTelSZHXgMj5hYkVXjUfctl0wUPQeZUYRUM2SVB4wqIa82qpbpqzZg8JGJkDMNhUllX6dZFQk/2RIbuzP+N21+7fRHFjvsS0QAlSo7dmbI+X43YyVgh3bCYNwUBhBs9GDSbm1XMM2/z9NL4Lq19DZOKKh5bRi9qFrJq7u3o212KwlVG9Uq3/kGLR92AK3qkjluT2YCu1rS+GgQMf/9tCAsor9/1ddtzVho5wvWxGENjW8Qyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cd954e-6928-4b63-7211-08dc2271f238
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:33:17.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwBIhGGVNq+4gze4lyAkNd1HbTRRpBTyv1XZm3nDyWyQMb19lcWwp4AyWzLUl9572ANdUEMv7e7wERiTs3kn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=939 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310120
X-Proofpoint-GUID: kJ8Rbr5519SIEOcEWeiJ4ZoBQhILpCfQ
X-Proofpoint-ORIG-GUID: kJ8Rbr5519SIEOcEWeiJ4ZoBQhILpCfQ

On Wed, Jan 31, 2024 at 02:56:53PM +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  fs/nfsd/filecache.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 8d9f7b07e35b..f3a642fd0eca 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -722,15 +722,13 @@ nfsd_file_cache_init(void)
>  		return ret;
>  
>  	ret = -ENOMEM;
> -	nfsd_file_slab = kmem_cache_create("nfsd_file",
> -				sizeof(struct nfsd_file), 0, 0, NULL);
> +	nfsd_file_slab = KMEM_CACHE(nfsd_file, 0);
>  	if (!nfsd_file_slab) {
>  		pr_err("nfsd: unable to create nfsd_file_slab\n");
>  		goto out_err;
>  	}
>  
> -	nfsd_file_mark_slab = kmem_cache_create("nfsd_file_mark",
> -					sizeof(struct nfsd_file_mark), 0, 0, NULL);
> +	nfsd_file_mark_slab = KMEM_CACHE(nfsd_file_mark, 0);
>  	if (!nfsd_file_mark_slab) {
>  		pr_err("nfsd: unable to create nfsd_file_mark_slab\n");
>  		goto out_err;
> -- 
> 2.39.2

Applied to nfsd-next (for v6.9).


-- 
Chuck Lever

