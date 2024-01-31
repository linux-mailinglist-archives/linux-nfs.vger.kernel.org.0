Return-Path: <linux-nfs+bounces-1629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB884431B
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 16:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFEF28BA35
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A81272BA;
	Wed, 31 Jan 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oj38w5bz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HSImj4F5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7115186AC5;
	Wed, 31 Jan 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715214; cv=fail; b=Wd0nQkSnULKe8N3lGugzYZCOzmnbTTHrVsVeL0hsGIhIRogzAd+v6Cti+YziZ7AZyyecGfmxSdPSDRSSOu7Gi7Y4X/9wfnjlzxlKR/+JSXe2C4JtCsJ1OnFOmxm+ACmKLmy4hVEzo6JBqtCvhTOKDFg4KTOZOlS9Oa5AD6qoNoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715214; c=relaxed/simple;
	bh=SSypbDMA9WEMmxFrI7zTBfbhVbrZ/K8liZbAUHa772I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=atFrLWElRFW4lZBdmI3agTywj/CZT9Ppl6G5cSvudMfWPImeCQ8cyZ+BkhXeUS4JM0D110buVKq/qkjCA6s/DWS1sreuBFO1wAhXWbs5wtuwDqdK2h/9eyTD0NKfnpNQ+0Ysg3hG3JK1udGGX2bb0nEZ4cPeEcGnH632TEtnwqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oj38w5bz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HSImj4F5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VExU6m009643;
	Wed, 31 Jan 2024 15:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=L/NtXxmpXqxfTsO02nWtOsRE2SYh8l/IIF9AjEIkf0Y=;
 b=oj38w5bzMI0nwVuTqYElpFSiph98pnGaTMtIhPXHVZlgqhDUD8+6rS7nqyLIiiRMePX/
 qjzh0s/KPsUMhV8iGe4dExprXnoNnp/04xE03Ug4eFA53KPJB7xGIu+5rsCPDD/4Nvhz
 BwhTrcVI+IXwC5IWlN5OPOvfAmQ/2jrICFliTlTw6hC4Nh/OWUt93FTS0kN6mjqIht1v
 N1zldeM8tlNYHlnJw13SYxlV0SrGhWoSee6VlktYJwKvJ5tgKcXQFm/Jjo4qqpn8xRIY
 2USlRIgn9i2GUXRKztWYZp9KhD8rvGXO+Pb+31OPTlIDsatIfk1e9mBAerUgphFwm/30 ZQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2jb1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 15:33:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VFVU8c005518;
	Wed, 31 Jan 2024 15:33:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9f034e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 15:33:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu9u0lh9XCSsP6kj8e3xYTbBj3OtzeOZgV9PKudNJh2DX+p2MDRuCpmQ2ev0F6+OS/B3YX+toHia4rkUlEfE59IEKrcB3xmkN+U9/K13kcBcW3wxw44QrX7KKOdGdDSbcgzHPz8ycdCguktL3VYZsi+VDpM7KAU7BbrFu8jey5wM+d1YQS5smWqkZetgUICX723YZJFp8K8HRccNctzQsTaUdqCyVpJZ+vaDOF6+n6sYYWZlfZ+p7CNsqPEjdl5+ouaTb0STKQiGxxX+Z0IXQV4cDdrYyTG+EQADfFoHmbxzRVE5NtmAKWge4Q4kZfrQn77PTzcoexElm5kutjEdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/NtXxmpXqxfTsO02nWtOsRE2SYh8l/IIF9AjEIkf0Y=;
 b=YOVOv297nmJ6UP6/6IdWdAowzJR+UPmpKUBVMBl7E/Cj2l6MDZYl8Av5K2j2G6vtafCuoqtqkJwi0Ff3a4FM/B4h4VHAhZNdxc1DReg78MhbhxIK9Y9AKvF2OYscVkrjKEDI6cDByclTXsAHkP9W0/NoDajfsflQACrPhjwQS8ALBBnPfMSyOLB9CUen9X5OswacUPz2Mk8RXbqVVJ+NszdN4lIpiaybFcqR/kvrsxj0qKAZbYN7JHKLxeRRajEjpaY7DCJLDZFM6dtoxhwvezbGaT0aq3N6Wj+NGw/+ILsOwOgkX7D6gHhdZsG5LoPmj6bMKeByWe+WLBc1vdSPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/NtXxmpXqxfTsO02nWtOsRE2SYh8l/IIF9AjEIkf0Y=;
 b=HSImj4F5KOB1K22MPAaKWwxcL8okyidt4YVVonYBAaieekZDiFyt9irCd9DtwNIHw5G5rg3o1BCA3URZTfORK8/upnNmn0UwSjxgVIqdYAAvM3ZVRVceuNzhnq4jhW5TXruLcKHeDazkZFmajG2XOsA2w9CjCr1SCsp/b7Xi8Fk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5540.namprd10.prod.outlook.com (2603:10b6:303:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 15:32:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 15:32:46 +0000
Date: Wed, 31 Jan 2024 10:32:43 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Simplify the allocation of slab caches in
 nfsd4_init_pnfs
Message-ID: <ZbpoGwFiJvdaJl2j@tissot.1015granger.net>
References: <20240131062227.130725-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131062227.130725-1-chentao@kylinos.cn>
X-ClientProxiedBy: CH2PR14CA0054.namprd14.prod.outlook.com
 (2603:10b6:610:56::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dedcbfd-ad09-4f0a-6234-08dc2271e022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2efsgdrampGOX0oWHcjsfJzjQGsLaV1IylJfLJakd6ZNIq2FLYIsHEapircup77VMUyo1vZLWcGWf13dMz+swxlDy4E8UIUF3Sn7FRySYSrLhcdFaFg7sqiCL1FpCPZ9eLkGzYZqrEyP9KxYL/r0HOz77qoMOyYdqhScBBOu8noQpLfW2dfVPvSNs4qlz7WzCLtjEZQwqVSoZ+czlNIo++Tqom+xhwkotxFgt6+NBny7G5DFLRO6HxtEICh09cesIbc8z0s7TASCioG3kFSHvd1Kkz6eoI3unnB+IvbatrVYfbO0szFI9p4bvmLa8xVx84DtU+GOd++JZSe0b0OSQqAQBEtQx6L5sW/aGFuy+ZZXsUjPJS14lsLp4qjFSb2pIOQv5kA0Xb6wV1LaXTgKT8b0y5hSUttDYArk7Hsz7C9aqSWsUXZ1X3FbuUFHKwiBBGFbPKg65MDWUWW232x4Mqr+DSi7zqpuAZSk3UTS4SunhPrOq9r+HcLk66CnZMvcEvFWMO2TdBkzRtzL3F6Yan49s/4hh1aicr88MZoED5vmvPFitAMwJRfQRjNA1ejr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6486002)(478600001)(9686003)(6512007)(6506007)(86362001)(6666004)(83380400001)(26005)(66476007)(66556008)(66946007)(6916009)(38100700002)(44832011)(2906002)(8676002)(8936002)(5660300002)(316002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ow/z77CzOlVgseeUsaPose1FOOuHHCUlW7QsFUc4Ef5SRIk97T2AGJvhg0zl?=
 =?us-ascii?Q?9bYiEyJWxf32Vy0QsXHoLJubrYlr0LfOuOwGpiewPQaTtygex4Y/g2XlHkc3?=
 =?us-ascii?Q?0ZDZBenvScNAq89L5+1eXRsy4uoAKqToouuRkXvjDt/BT4+2RzOIJoswosnp?=
 =?us-ascii?Q?YhLjUfVNNHZ0yy69dEUQqLNDiaxvunh0YajDJ0FJai291IEWJ6VkjAZdg+tA?=
 =?us-ascii?Q?/VUXwwctmm98J2amKIofunqQ3/dFNTPmts+PatZO4IgJFWv4VMdVY8OK+Txz?=
 =?us-ascii?Q?s3MXtiUK0n9+FElyMl42GVIEIMp1bscqwKTykAuPpdb7sIsuzEnR6xiqVSdR?=
 =?us-ascii?Q?WAOSZ/TFxXb0z1Nc9wV8qBmIY3ZJd/vRF4jgzBNxxa7y7bnxM+E6UPPe1gvK?=
 =?us-ascii?Q?v2+BBhKpYVwD8JizdyDniufAzAAcm3OIZYGw8ci3Rhs27hVIQiW6SrTChmyB?=
 =?us-ascii?Q?+DIvTPRcUh9N0Lspb2f0h8GG9tA5qSsQsncHmcPxqMyqzp6zwGr5nHLGSXjk?=
 =?us-ascii?Q?o3s0s6V+oh2+7L0UyL0BCmfMsb3s4qYjHVRYa29x/Yb/1yPVplupm6ArHl/N?=
 =?us-ascii?Q?G84lc7JDhvmEtiISvfLCJIWHuGJ0cAVswsq9tx6+S3nF8njJGzClb+3cl1Cn?=
 =?us-ascii?Q?3jhhJIbBOO0QPFFt7sBYXK9V/NH+KZzKME0D09wEsCaqt2BjUun5Eb7uw9rd?=
 =?us-ascii?Q?vliiIZFLG5CB1MTvhpric2YoMfo/cr4C6++nU/zEEYh/cp++QaF+VzY0ewNH?=
 =?us-ascii?Q?UqkQL512uNTmi3OhpsbjxFZtR9oQYPKWUJgEuML1QKkwF92dbmO58hXK3KZC?=
 =?us-ascii?Q?WitDymYnm0rGmcCQPA8ZmYeG+HfzmGS/oN+0IWQvgz88V1yxO9Ki4sj6vhL3?=
 =?us-ascii?Q?GsUCyYnbL3ZQIDwASsZCFv2qkgGjamYFxzogVmpJ2Oiyht0y+cLUN1JdtpK/?=
 =?us-ascii?Q?AXprA59NZaGarcX78GC7hBBkVJnd1D2OMTatebQAbUWyfBhiCamSE+0h1KJ9?=
 =?us-ascii?Q?9oF5LXA1ld1GyvVUDnoqxCL36pC+/77ZN5yA8FszTtL6RA+nCCfnIe6Da8JY?=
 =?us-ascii?Q?NTaKorgaM4Oj9WOFlZ7FNrDC7/daMuvTyWpfjembnY6RaRIFIiuxcs/92dMT?=
 =?us-ascii?Q?SUoByqDKnYt1hVtjyUJAInCSBFetu0HwsO1Bhl/G0ah6MY9vkjnaeBkWUvz2?=
 =?us-ascii?Q?cMd7Lw8v3FttZ8aqsadlaPtRk5oHb5vU7/rY8+Ku6IDix7wRheU8JN8spLnx?=
 =?us-ascii?Q?9bkDcfDcDk7by3ngaX6+a8G8IZsoouRK/Ia+ra7RCuqUR4UEjcvq80bEVMpx?=
 =?us-ascii?Q?Tf7Xu1ChJDdMvG0xVY2ZkikZRxz26tC3ldXjYmMyunQfg6RIWrhmlML+Nwkb?=
 =?us-ascii?Q?i/GgzFpfcctON3gDhzhw5ho4X76g+rWKRFUo7VgMdbUD1sRg0TH66zTeSjh7?=
 =?us-ascii?Q?ZHEjUHju7mlgIyQ4J8evXHMhRPbupY+Mru+Y+xcT8y1ornu8QmYvCv32l2I0?=
 =?us-ascii?Q?WC/z+cHs+sO8yFio10GXA0IPvXCwOHP2Mc75I2kHDzr05jd+VMRcqxi+qRcQ?=
 =?us-ascii?Q?jBD1lj656bpTxEEJ1NIMKceV2tbtDQxgh4yHbAhMMWB46eA6ntGLh7gOm2Nl?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sV4RG2RGm692FIgtM3cJX/3/J9I9ftMUX4B58ZgN+MdAImDBZZ/nDxcJX2YqKzCVWnv8ajJKg/gEgsOWLAYEAjQMtqL7bUNuorCcIaQoxBKs5V9xKN1MHrBMyOe2gjJZKb+RqXdzDNLsNgkM5fqo/RY+WtZ9t4oOjbrfdGTb4k0XCdcKfThW5NY9LywMOSDdicYSkUZH87DgteH3GQoABUyqil3Q57+OHW2Xz1e3Px7JJSyRQu7Tf+u5NTFOhuqq6uSZQhM7rBLyRIJ6lmTkE+y4bsgAfOq75C7vEtfynm9psHQcC8n6gBcz34kJxBQgPh7S+gOGXfHhA8CfOtZKutJlm8aovT5OpBeLH3gUejEW8ex5phhv57OgfIs2Vl2LbIe49ef52OvdnflyazO/C/VzKiOxprJ0Rip3rx3sW4Zws1AVONhLc9Ii7rG/L2M1uNbYEu5pnQW4ueeS4kDzm+NmlUXybgdgdbPavnhDdhG5EHoaqH8Q5Havki0RQkbF3Lby9Qp56iihrkf8BNCSzFv3nAHw4KimqbgtmJ8gUNWa6hjYZIB35kCQsfKH+Wc0ZhMleHu2PiCL8+Rw7ZcQHKH0TZd8wGPPYsJx5lj3zNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dedcbfd-ad09-4f0a-6234-08dc2271e022
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:32:46.7486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUWSyemflMk0yuhC5zijdiF6lqURGIn7oZTTte1b7YaHUrjwy/R2LZpGhxcHAfKDRSf/omIDsBG2HZyroSePWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=868 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310120
X-Proofpoint-GUID: PEGKRxM-DcCmOGc5V7IvA_e5IaEVdLXo
X-Proofpoint-ORIG-GUID: PEGKRxM-DcCmOGc5V7IvA_e5IaEVdLXo

On Wed, Jan 31, 2024 at 02:22:27PM +0800, Kunwu Chan wrote:
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  fs/nfsd/nfs4layouts.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 5e8096bc5eaa..4116695e6aa3 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -756,13 +756,11 @@ nfsd4_init_pnfs(void)
>  	for (i = 0; i < DEVID_HASH_SIZE; i++)
>  		INIT_LIST_HEAD(&nfsd_devid_hash[i]);
>  
> -	nfs4_layout_cache = kmem_cache_create("nfs4_layout",
> -			sizeof(struct nfs4_layout), 0, 0, NULL);
> +	nfs4_layout_cache = KMEM_CACHE(nfs4_layout, 0);
>  	if (!nfs4_layout_cache)
>  		return -ENOMEM;
>  
> -	nfs4_layout_stateid_cache = kmem_cache_create("nfs4_layout_stateid",
> -			sizeof(struct nfs4_layout_stateid), 0, 0, NULL);
> +	nfs4_layout_stateid_cache = KMEM_CACHE(nfs4_layout_stateid, 0);
>  	if (!nfs4_layout_stateid_cache) {
>  		kmem_cache_destroy(nfs4_layout_cache);
>  		return -ENOMEM;
> -- 
> 2.39.2

Applied to nfsd-next (for v6.9).


-- 
Chuck Lever

