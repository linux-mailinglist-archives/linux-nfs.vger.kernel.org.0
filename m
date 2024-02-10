Return-Path: <linux-nfs+bounces-1891-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81443850501
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Feb 2024 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A621C21067
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Feb 2024 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB26364BF;
	Sat, 10 Feb 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LhxLqCok";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qF2ZiLAZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E472B9C2
	for <linux-nfs@vger.kernel.org>; Sat, 10 Feb 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707580469; cv=fail; b=IckqJmu3GVRir6s/yjI86LNbfNgz56iycIGwDLm5VCcRtDE40K0qTNrLPVZZ0Ue/YmwlE2ah5BnQdotwGn5hNpTex06BQQehQt60cgcqqXf5Rh138ZiKRUMCEXW+YDYuukxnDh0q8MbDrePqKSW0L3C1eiNb16ePno4JEK/sufc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707580469; c=relaxed/simple;
	bh=GH4ku2t8iy69mJvODwyre3ea+Ski+TfJgM8KpPv7uik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t6zwlWDoualnWzS3reuA36NjgbbvQ+I1UKdkH/S1DYJWnSvERuSZcy9D8QZrsPJ5p4gFxlWL1siAdgwxBK7pEMIK5W4MgKdAJa0iKAOGOebm+Gx+oAhDL9I+/vzy530/uzV8z7XYg35gY3aCwHSKp7QWtkpBcqPiwKKfKTcfi3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LhxLqCok; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qF2ZiLAZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41AF4xLk019905;
	Sat, 10 Feb 2024 15:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=JABwAJeNCxsbRNtTR/+wK7mqn88tM95yP8pN5FyKIU0=;
 b=LhxLqCok9USs+P773Zc9qtDylUQ8Y+X/p3dJeqHy54W2ReKAC21OLsb7ibNOX7BxqgRq
 Eo+84sAOE0gQwEA5/z1ReyOjf2KvRTJGP46qta4iHQWFNiTmGk/WnR950tAKkYdAjvyC
 k2HUhl9LssjmcxLUafl5BiKUXto1tWNGUgLmx7RLHQg5ttIbbY/N99liSzwBIY/C+ShI
 aiyqtCZICcK2N6p75j8S836jy9Z+xvbJI+hRTmPnN7ocWOYl7yf17C9wg6UebQHJFqVc
 5JxC9L9iH8qOKwOUFMndkLW915AqokuQTeCng5CKk2I46P0Ovnp6QvFwDoB18/w9N8vy ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w6bfa0103-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Feb 2024 15:54:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41ACMhDg031501;
	Sat, 10 Feb 2024 15:54:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk4005g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Feb 2024 15:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ergvrcO48csapEPSmahuL+9wQDWFnJVwatURupcud/eamsZAy3N1ZcBT/k9YZytFeXzsFbzUaIDhyx42pvUFLmuczjcYxnrEpbDprlMa95KVIxndppFbu9eqGnV2TLXx3DRqPYAxjWpEQfUHwz4u3TeNUVzIdxmqcTjmy+lZG4bI5lsK9Fu1UpoDbzKy/0rt+f/sEeVILvyYQ5Yh4DJ7jfmPIro2Vd48Jv1CtnqrkRuMCetaPLc10/pakvs44tOCyE3CvGF4fCVSmkBIa4Cv8U6UIXTw3D64N9qWuYqMSGWsCp0s2swSonHYKL0+O2BcD/xBhGccIStuNgjDRtaUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JABwAJeNCxsbRNtTR/+wK7mqn88tM95yP8pN5FyKIU0=;
 b=iF85tYG+zs3+5zGD6CByrNDaLpRKDT+c26aXxKvifE1jAKei1oT5I6Gr+/iQYglBfKGki3HNuuuTLuEBZboBqJNRz5Xcoa4Y7NcaysCZ9pJ3XKAXgxugiaHdMz5Jxxr2myHuAa8nc2bqCPuqe/0jyeMgOJphPsr7UVOApamfMZvY7kCtvxpPNK2WwwOpBaJb+6VbWHzk06djQXGI09IgPy/iIG2RZqW9snZ1dXkrRG0B3H41fRAi8PvCYflRfuqWf7TS5cXB0zf08bEXbmZe10N2hgYdq1hxGRW08SkJZp7OTCZRhRysyActBev3bitUxP/dvrN3Xxnil1rHLlWtMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JABwAJeNCxsbRNtTR/+wK7mqn88tM95yP8pN5FyKIU0=;
 b=qF2ZiLAZBECKL/ipEpZFkM2YPyjb+CqZfcpB/BrJM36ePxKt2aGd0ELYdmdsCiuO/irJ00fr+2M3n8Wskm+bcvCGow8yb6tXqCEhJLpT/AdSVgqs3c/0Ae1Y8seCo8vtpLzKmcznlf7CQC6wfRQHsVg5e9JhmYuwhrQ9OGAvddI=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by BLAPR10MB4932.namprd10.prod.outlook.com (2603:10b6:208:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Sat, 10 Feb
 2024 15:54:15 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::f88a:f9eb:fad1:6751]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::f88a:f9eb:fad1:6751%7]) with mapi id 15.20.7270.033; Sat, 10 Feb 2024
 15:54:15 +0000
Date: Sat, 10 Feb 2024 10:54:12 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: gaurav gangalwar <gaurav.gangalwar@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS4.0 rdma with referal
Message-ID: <ZcecJNwQnXPpJ3fT@tissot.1015granger.net>
References: <CAJiE4OkE5=6Jw3kf+vrfDYsR5ybJDKUffWGXAQd2R2AJO=4Fwg@mail.gmail.com>
 <CAJiE4Okdie0u0YCxHj6XsQOcxTYecqQ=P-R=iuzn-iipphkwHQ@mail.gmail.com>
 <04BECFE4-7BC0-40CE-90DE-9EEF0DB973BF@oracle.com>
 <CAJiE4Ok5FLgk0Asq92m7HhDwAgbiTuWo57ff=i_zaOxhnV6YvA@mail.gmail.com>
 <CAJiE4Om+HWMCuQYsxsaOCnTAZAuLxA4B+3phqeTJNT81gp_mJw@mail.gmail.com>
 <CAJiE4OnNpnJb7EYfujgcRbaUPqruo2j3hOdmmt3LHNHEJ8bw6g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJiE4OnNpnJb7EYfujgcRbaUPqruo2j3hOdmmt3LHNHEJ8bw6g@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0375.namprd03.prod.outlook.com
 (2603:10b6:610:119::25) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|BLAPR10MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d3a484-9d63-4039-5e57-08dc2a508848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bLhF9mRp1ob3OtbVcCJst5nXcD4c5VI5xCIb9hOTU0PoYPqOwGFqvkJrerEN3PXc32XgbMRePrpBrmTbF+UdcMV7CwnPXqmZ/UGQtEqY1PYb0CoFRa+qw0s0Ja4BHaxuxs1uAeESC5FLj6wcdOd6XxHObU6jbZjjO0zsvHmQP31Fb6Ap2yJ7IFziWaYBgzyvmOozOUVyrwxPUXO/H0kWyw8I31Ct8ewS82MglFW92Gm8wISxQI5DIjDBXb51HWx88SU2IFYS4Ow778s/6Lyv1teERunJ4kkaVBIxCDPiunLory9F7bZmOn9Khi8a0ANjHBag7XC0vz6mak2fl5ujfrM4HcgEGSzB2uymCN4FjIxCilWopfP/jhV6MpdAx3AyQ7yLOtXq58bSDjDOFqEnPY49Xpuf0Z9wJYWViLk1IMM3YJRziijjTyYVeK5z2VmCrUZU4wjtj677ArkC3MHNwJOc+4LC1M/YYAG0JKtA2ub304VBJ7O71FWoJwEfv1yLd8ZKfVijxp78miIhmvOunk/6NVNgyOG5QP7QBAHzlbXXrevLtb17rbYoLsP+JwMJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(8936002)(44832011)(4326008)(8676002)(5660300002)(83380400001)(26005)(38100700002)(86362001)(6916009)(316002)(66946007)(66556008)(66476007)(6506007)(6666004)(6512007)(9686003)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IjbjCy+iJSnspzTB1dGCix95vyIaA1xFJQdnxnfTTjQwTLBnzw8IRWeyCEEA?=
 =?us-ascii?Q?3abKLknjWA6MPVRbcLAzrJBrjwpezwzH4ZekYlOpg25wQVjk8px+M0d9PUED?=
 =?us-ascii?Q?DdRT4UlN4hPHNNZoHnzUJvn/bwG57WnagyXTXQLvfroQk7dLRyVDZDKGzcMF?=
 =?us-ascii?Q?O+FQSI53VkniahFjnJL8T/1B41Zfh7k7TM7TtNi06XzZiDKTDKH62EIU3gcm?=
 =?us-ascii?Q?jqjwr5Dw7CLxrq9CuEAlxPXatF8i1Gw30JUYIw0gng4cJc4rGrTwHy9Z1SrF?=
 =?us-ascii?Q?If6WHdn3JEapUsm2MNtAhWl7KhLDdiIU5bO8Q17wgJiV+MvGeXEv9DFtSd1n?=
 =?us-ascii?Q?A7dLAtc+kjr0gfGPaWu7Scy43+Dn9IE9974wmKwAFPGRR+a9hCITBxSNT1+J?=
 =?us-ascii?Q?WkRSfJZyUF0ZcLTBqQbbSX9nAkJGmGi+xSBEwNJdoZoTHNpLj7tb1dTrPXdL?=
 =?us-ascii?Q?Qw6lMW2zH4UituNho+Dn47lxgFvuLHs0HZLhLQ7FSdxwv4DGG/ZPmF2MVf+G?=
 =?us-ascii?Q?FD7dKnDoGfXANDbtEapCRf+F3pP1oCwzfXrMsIOuyi2vD60J5r6kSfV+e8lg?=
 =?us-ascii?Q?e7OoQeGAOihszif3IS2sdcEuKOeFhngoggBqjElgxbVbIYcevVBny/uhixfM?=
 =?us-ascii?Q?+QRmdm29N6Vktx7bgP1WTPEQoKCq94Dx6k0Jg6qwmKq7Xfgpb9h7+JJoY00T?=
 =?us-ascii?Q?zTZSFiBc7uF+qHkxVEHpgGc9gN+HXkPS1kSnWgHqjJma8tsCtxHtdLrui5Pk?=
 =?us-ascii?Q?JaoVnjODxE6GKb6FUmYk5U/uC0OS1MZcXBrrg3hTCdieIfL77WJSAWHqVdha?=
 =?us-ascii?Q?87XqCpLlVAsmkfA3iE9iX2dvjsqgVM5giTs9t194Lv86cG3/sCd6ymP+Z2qk?=
 =?us-ascii?Q?ejuFUwpZRVaYew2WiK1/ZbQOKcVsAFVg0b7IT2mW58/ZlSPKjY76lc2qytoI?=
 =?us-ascii?Q?cihiyRthfXMwn9x8cswgO7CzPpemWIIJHA7l5plaecD4ErDOmnS2JsHdOkaY?=
 =?us-ascii?Q?/mgE09AZpeAFX0VS7T+M7S3Y1X/qeLMqHercrn/FC91x7EhYueqO7lgwLFNl?=
 =?us-ascii?Q?W9gUfdjwiMLYF5aTvuPhBg6pxeT2mQWKaql4+6CT3hXxcNGpHPQSCOYa/CXW?=
 =?us-ascii?Q?bwZY798AYuYbtHKUWJJCD512RNrVFAxpXLnPGeJ4qkpCg2UgMt4kYa8Oyx68?=
 =?us-ascii?Q?/QoiRd1lPGkGXP2/LKr3Pju2fouQE4YFkFEpix2hKnvjByPW+9Co4k695To9?=
 =?us-ascii?Q?kX/0GrAhe+S0Bv9XZdJZg21ONvQwGii48YUSVxCBcLJic/toBzDgT20TTJTy?=
 =?us-ascii?Q?bL32xAwd4qXrYuXclhzBc6T9aauQdjQsBw+603PrnVAaKTx9mSDfNCFs1MXP?=
 =?us-ascii?Q?7NXULJJr2jbuGG8yg/OxYQLQrSHtHZC9uYnM6HGqHFnmPHuw5Tr6Skob4mYh?=
 =?us-ascii?Q?HDvmTgIJKO4OqID2bWAwVczKV9sezYVFbOylf1erIT/4gurkpx+kLbG3oVru?=
 =?us-ascii?Q?IY3o4s/LLUgOPIrohMS34d0ttL4bmgnQuTdui0M4wvGhVrsw535vkg0AWCnJ?=
 =?us-ascii?Q?C2EX+fDSjfRyiH7WACOE/P4IJvVvpmczWez1DJQmbVyGhEk+Aj86D9VatuOS?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5cec09A4xtJiTULqFis1NgdYE9XDpLYN0O0YJALsuuFO7B7PxXdpKUbsvdRVlMucU5U1sbi16b/mW6DJztGp/zcfnz3Qpp2RSA1pH10Mjy59GQAZEAYmmn0B50npmDyKTrAHU+i9sF0PkbxgVbr2C3GYn7EskjiHAUrd3maReqAjC8TElZG/OXJYrZjMcUiK/z9uXujyNaCRT9+t5Gp4EngeMYkr09a9Rh7Rdb/CihUKUvVDVumfDc9J1nNXDt/Z6ghFnJ1mZgXQl/dVu1em+VNkcHmETLbh1PVfsDb8M12L1lqtGZBpTu78zABPv+JhKvl5fgj0hoI8XDs7FgLE8t3eJtUf/vPoAMq+3vtEEMCp/Rx7XTlU4WR7KMUZHL5Sw3UdIGNILEdm8tSNq0udrW8ZjqC1YCTmIIDY12oRLVfCcOtX09NaKKPVRWgjRGtnCMcCAyezTXBaDOOR/4fqZaM6uMNAjjrOQK5DA91ErSXxngLN6xHrRl2dw99o8Xr6xnfn17dEQB1DCXZwRfgMbGSDXYtiYiIjBtpf4oZM9jEv8XtZf+L7CdyvbeftQwZw0WRPqxnfGKAxne2EusvjVZg2SywMfuBpxvnyUkM0cQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d3a484-9d63-4039-5e57-08dc2a508848
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 15:54:15.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMSbk8msNl1tTB84jpw5LXLZqqtxu/3EWJui3GCoKQY515zL/P25NayE9ar7tQYp5DjxSUxmLHa+VASEKwtezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-10_14,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402100134
X-Proofpoint-GUID: 6mzcl9K0ThoKvBuW4WFqIUE6R0xyDJAB
X-Proofpoint-ORIG-GUID: 6mzcl9K0ThoKvBuW4WFqIUE6R0xyDJAB

On Sat, Feb 10, 2024 at 06:07:50PM +0530, gaurav gangalwar wrote:
> Thanks for the response.
> I was checking the nfs_follow_referral code, I think we already have this
> patch to fix the same issue
> I copied http link in previous reply, it got bounced back, so I copied the
> commit message in plain text.
> 
> > commit 530ea4219231e62341f79a5517d7b4f12ec3b74f
> > Author: Chuck Lever <chuck.lever@oracle.com>
> > Date:   Mon Dec 4 14:13:38 2017 -0500
> >
> >     nfs: Referrals should use the same proto setting as their parent
> >
> >     Helen Chao <helen.chao@oracle.com> noticed that when a user
> >     traverses a referral on an NFS/RDMA mount, the resulting submount
> >     always uses TCP.
> >
> >     This behavior does not match the vers= setting when traversing
> >     a referral (vers=4.1 is preserved). It also does not match the
> >     behavior of crossing from the pseudofs into a real filesystem
> >     (proto=rdma is preserved in that case).
> >
> >     The Linux NFS client does not currently support the
> >     fs_locations_info attribute. The situation is similar for all
> >     NFSv4 servers I know of. Therefore until the community has broad
> >     support for fs_locations_info, when following a referral:
> >
> >      - First try to connect with RPC-over-RDMA. This will fail quickly
> >        if the client has no RDMA-capable interfaces.
> >
> >      - If connecting with RPC-over-RDMA fails, or the RPC-over-RDMA
> >        transport is not available, use TCP.
> 
> 
> As per code, with CONFIG_SUNRPC_XPRT_RDMA we should always try with RDMA
> first and fallback to TCP if it fails, Is it not valid anymore?

This is ancient history for me, so pardon any memory lapses.

This logic should cause the NFS client to try NFS/RDMA first when
following an NFSv4 referral. So if that isn't working for you, you
will need to debug the problem with your hardware and fabric.


-- 
Chuck Lever

