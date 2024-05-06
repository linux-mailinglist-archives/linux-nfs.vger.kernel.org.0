Return-Path: <linux-nfs+bounces-3178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E18BD606
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 22:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314422834FA
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 20:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A541745D9;
	Mon,  6 May 2024 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YIrebcZT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eAIjy8ak"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4101156F46
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025979; cv=fail; b=G6BucKKqryq+UcFQT1JBL4G4SmgRJMeZkuLK931I+ZBzSpR918QeYZ/djcQcejQA1bEyfBG+b+t4/ZS5O+6KzkLQEeGIdRB5Xh1R2GwBoIq8ixvd162Rf5fEW4qZHnKP1aPGwOmix0gEVoSwIWIoL5f78Mz/1GRtWvnJWASEcbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025979; c=relaxed/simple;
	bh=lgFfmmRdM115Y9fK3ZNdtPDALx/mUdEP5OC6A7CnK7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HgMtFs3oBEBO85PGZ27K63HS8HuAZUa8qobaDtL5TpzG/3jbHUBSa1WnG3O/OoHNWjegKoSKkUN0vUYvjbnf5bnKzgJSbUiSrcBrfZLuWMlXPZWMyvt90PxX7UFZfc39xiaimGJ8EOiiUhBnRu4z0lxUTgIGREM/YD9yhkEuEjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YIrebcZT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eAIjy8ak; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446IF7J8007305;
	Mon, 6 May 2024 20:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=cCM6yQf4vLS9xA1YS40+2OClD6kvbv+a/E+CjlPP7Jg=;
 b=YIrebcZTqO5qFGssvALJ+NvkPOWJ81x/dl8VpaxR2rnD+tHaWPsZWjgpJfFypD2AChU9
 wm4J6t23I11fBJLeXvQDHgQeYbm3llk0mQ8L6o+t/ZD0dGk3di6Yc5aqSBQjx6oglAQ2
 I8qKpLPrero/rq9Nz/VmZsChI+jETFJwf9W72lvNemxXF58/AqatD387Q7u4mgk16cCQ
 EDr5IcVKAcvBHMUbLVasZpf6+8YdXuGTjh/j0w2qABIZuBIFdt3XVrzH332ceAd2y0TP
 aA9dRjg4gw3Nkoa0gc+EMnx06WK7Smlswt3hnwJ8mJiE+IGH1/SeVIF9lD9/EbAdanTi pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcwbuedj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 20:06:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446JZuQS027603;
	Mon, 6 May 2024 20:06:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfdb7kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 20:06:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXrji649suQfbRxOqsoGjpn8zVuO/g26BEU0R3NsP84SbfyMFE8tYkLBbZyWcs0WF9THmN1eIGxaEyNz8Eo2D67QsdP5hIFsGNUlvx+ZONCe/+nyW+UBdasR015cm8f7z4JqCuEtPQWIGf+wCJgiuiGo4oP8Lyp5+TBFtVbn0QYhRBAmTBszm/gICqNP+4At720u0e8k3p/AzoCqn5oxNQa41jIYJqC+2vJYg3Unfz0azFlAFFBBKrhIS4z76Xm6I8WJ3VmLeTLNQ3PseEy/AvpWr/OFy2Okz79pIyyYqY8BceKgHDAhimm3rbMCfu/cW6RdZaOsZIdxk5FIUon1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCM6yQf4vLS9xA1YS40+2OClD6kvbv+a/E+CjlPP7Jg=;
 b=m2yIoHgCF2UshDeTupjbOfpmxcyzk/gFNhAUK7CaKc2KQ3U+MUqHRJ5btzkT/bdWnqC2OK+DW+IRDk5m6P3VTEyup6/TPGjS2NfeRhxSRKBl6mnIT8A9nQaEtQwLiSawLotTsopj5Y0n+S3WTqdSb32/KMljCws005NKfL2FfLiK8FaZBeXoYxwxtuJ6k7j4P8uajbbWHzoZlkWRykEQwGOpToldRLqddyVZIVrR3ZXCjiFwiygjd6v1G/myLjbrRT3o3VqnLQGcZNEmyqueotu7+SXOu18ARjPQqpo2eANao3raApcbXei7CoWvLCE+uE/ktLVHqKWCkQ6rsobptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCM6yQf4vLS9xA1YS40+2OClD6kvbv+a/E+CjlPP7Jg=;
 b=eAIjy8ak66rwMTYzXX1IEu0tne+qAYrFqP8dfNLxbvn1j5a0S/TMdHCPk0s5WU5TuTIyvMgqmkdCWfbN52UgfxzBwWRuxrMV4xJWKG/j8oACd9tRUIcW1b5OLb8fvJC+OqEe+BzgV9IEDS1moRD8Kl+J1n2rQfTL9BKe8FAGy5w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4145.namprd10.prod.outlook.com (2603:10b6:a03:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 20:06:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 20:06:09 +0000
Date: Mon, 6 May 2024 16:06:06 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Sagi Grimberg <sagi.grimberg@vastdata.com>,
        Dan Aloni <dan.aloni@vastdata.com>
Subject: Re: [PATCH v3] rpcrdma: fix handling for RDMA_CM_EVENT_DEVICE_REMOVAL
Message-ID: <Zjk4LuOnti/ouaVw@tissot.1015granger.net>
References: <20240506093759.2934591-1-dan.aloni@vastdata.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506093759.2934591-1-dan.aloni@vastdata.com>
X-ClientProxiedBy: CH0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:610:b3::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: c8221326-5638-44e0-a492-08dc6e07f87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Uhu8KGYvcLq3sSIF6aL7ZM05g6uWwNaVAGIxZMTyZRkrIOOWKxSSAYDwxnfh?=
 =?us-ascii?Q?VqNenrvzCjczs3BpHMyULKTalAkyUSH8EaqHvXu9gpnRjrKgEbu2gPeDyYNT?=
 =?us-ascii?Q?DucKou1xK/KgpV7mzhsFaYExuLl6h5rvL6qntGOK9rKByIyQr4cx+Lwsaqrd?=
 =?us-ascii?Q?bojuLj2lIIeMDgdggRt6zBPqD6A9RXRdz1D3A/ZLA737NQftWJEVapEmDr+6?=
 =?us-ascii?Q?tAqcXqa9GTm/XnXfCIxYZcNLn6h1l/ro+Weu81Hbag2xLwD2XpF9ILP+9w0X?=
 =?us-ascii?Q?DJELVFGkITqs8MMKHHAB8/Ezj1QBGkZNONShy1IRYneGx+lP2A5Oc45/P4um?=
 =?us-ascii?Q?NofC64fZi6a7GoyW659Wbltvwn+x+BeUL99V7zwMU63XBzpUmG7UZwbrSewj?=
 =?us-ascii?Q?ctlf5Bs45+pW6fDeyQ+t/O8slfJ8+L8FwmNrPcdeTKeLyEThEbBP2xyVR33h?=
 =?us-ascii?Q?9oFnbNpJO25mMmUS2JTVktjl6o4dBH2nwXYz/G6oS4RMCdG8pAwheCmnCuyu?=
 =?us-ascii?Q?Ht/MoWJ52Glz/dXb8Lo/Q9TxiEeKJk+p7kZfnKo20TzIMYiyK2aTDmcfh2Jr?=
 =?us-ascii?Q?djuyoDi+JL+XymruciLJqcNgqOi/lAihgAGAprw1vSxLZ6H3EbjIpz+bmguo?=
 =?us-ascii?Q?Dx3cdDD7Bapj+PooDq8wApZjGK9OnW6q00rNvDnVm0rrTvMzK0Vw5MO4V78b?=
 =?us-ascii?Q?NNo3bPIDJ/OWlXlB4I+OdsXY8lTufFy4yzGin5PgRz2gUISttqdPEH8NtHl0?=
 =?us-ascii?Q?SD/xx5fl7yHRa8lGxUzIjP8BkU+ZqEqCTktVZD4BE6QsISFihYSBaVhVXeOA?=
 =?us-ascii?Q?F0TEAnYcHiWCRbhWEENXIMlq+G9UfnHVP25Af3hHA1Ux1RWwcsMb0GScct5w?=
 =?us-ascii?Q?Ns3jUL6G8+IEES/BpUutZO2q9VxLmyZkyZCbqmXGkQIa9AlHb9t8NTZlll9N?=
 =?us-ascii?Q?cwtjYbnOx6T4MhnIpiqEmLw1fjKnl8eiVZNVFcAvBiJ23InB4cleZ2KqgImo?=
 =?us-ascii?Q?G9nkuzqeIrk4e/u+RizaJulIY8zmcTNg96IQVHXn3zpXLtRicLLfbuXtr+yq?=
 =?us-ascii?Q?9dc0R7sNvZlFcRZTHscdaWuJDE8PqPSnLzbxQTX1GMBKfet11DoCIEp5yNCL?=
 =?us-ascii?Q?nV/sW86hR7RKxv/qp+YbtKGLfwWqGEvYfCwSsUz5I2ub/q3bykEa/3DpHBVJ?=
 =?us-ascii?Q?jq5bc7LzWZUzrkH1J9FYmiCEl/eKNiIWIb0HLvNPicAMKgpx9Q5swgvq0QdB?=
 =?us-ascii?Q?aGw4X87BcE33IPxdmhkw7oJckMheL2afdEWQIOsPwA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dcaEYCc+tv0EFC6mq79FgrP8KSZK5D8moZC9/HQ67uIUqah9G7jv0d9zn8p5?=
 =?us-ascii?Q?yMUxEKDIgB/1nMREHWJx6nqY4ZnfXUoHHCpLEEoa51Z2No5xdpeaNBmxM8B0?=
 =?us-ascii?Q?Qxsa6mkDTKx8IAY7B6tNzrzQv4mXt9D7klhOjmbSpYEPKvk9TTGW7BQnLT89?=
 =?us-ascii?Q?rc35OOmvxjp3nTEu7PwAcN7BM43CUNE+0S39RBME1aga89f6UnJTIutTafdK?=
 =?us-ascii?Q?UQAzUPq3O8ybjWv4IOTLsoMzpKIuPD/5+DrQLiLcYxSE3+c/LJ9yj2mrnrDM?=
 =?us-ascii?Q?l25yiGaBu33mExQc8Z+nQ//SGsQlV0H4w+UOj1h/jc+vgkJ5Qv0srsnS3vb/?=
 =?us-ascii?Q?qMhPWEhYkhP4P143dbbetZdip8exUU3TFq/+Mdx06XJBEaYXP0kG4Is+LEDr?=
 =?us-ascii?Q?RKDdHM6rg13QA6tL8eRXYC8DxOYWG205Jxk40VZrXfXf4IeN7B8TyOvUCMtd?=
 =?us-ascii?Q?rpHAIuU8NoUVQAvcyDpBsL0y+u87CxcP8PNj7wNfe5vnolyV+LLkzHpP4RNk?=
 =?us-ascii?Q?urrGmOP4/pvVLlrFkYp8eWGPVzQKhLPsEjuus5QYtk8YcemPtWA7rJBA8Jfs?=
 =?us-ascii?Q?EfQykW1DbIJifCfmSmd9u1Gz48zSzhXBFV6NMZBmpkytxpM5bRguPZBhZH+2?=
 =?us-ascii?Q?LKcX1Bh9+i3pF9DfOE6BW7XZ4XTu72PZ1tQ9AcvBQgAsQArJT332ogHOCRIC?=
 =?us-ascii?Q?i0IZHwI4uZwfkf1wf/D+K5ks1R1lxWCEVNFFEHYibOp322KzykpItrw5Yo8s?=
 =?us-ascii?Q?wFhITSZRXbQPdgTUmxmDfY4hp++eZkFcxbT5M5rT6iaTpwGjGGRhogpHAtQg?=
 =?us-ascii?Q?cG6Nyrs8CIcjxo1d0BQ0zcnMr/t4DMjRt18RlpcnGYdc+vXmV/hp4UI89zxs?=
 =?us-ascii?Q?WxNITmsJ+lQ/D7JBS3qT/20HtZ8pQ2XuuDZsykc4lqBeOH5Rns/sJimC6DNO?=
 =?us-ascii?Q?um1DMMaOFi9Tq07gyDISqrO1W0sPjPAAKk8XJrOc5TJfepbiCAqYGAlK46vo?=
 =?us-ascii?Q?FOsqoSrnL+0VKGDXO5Rxe2PGQ/IsbYDcmdhqPS5LbX0QErjYJZOOhM/4rIZh?=
 =?us-ascii?Q?4yjyxMKt/SFSnWHMu5o7L/RPKbb2OSMwBK1kBVT8VEKcGSm3C2QpARYCKUw1?=
 =?us-ascii?Q?BTHOEYnSNqOZpfJgF9bOD3Z0ORizEO7i4CIReBcmA3qOpcTfjXmKw14gAMBG?=
 =?us-ascii?Q?IhmuDVoeGzMnHfq3uwUf+U2bQeJeUb+NgQMppilrBqmDSPVZbRKS3mEA+6TP?=
 =?us-ascii?Q?WniKynPcSR/jQKpvZOx5WVsOSVm9CHWmpS1/neCgnzHruY9dC8jq/STJeaOn?=
 =?us-ascii?Q?Wq3uST14mgeSrDkqg0+trdrRZeKnzQOk6ryOlPzJoEMD6O+bLwORQGHrcYg9?=
 =?us-ascii?Q?IY3BxWGp9g36GBn2k1ixdEnPyOSz/CUvE6y1k2nuPlT3xsTZNBDbFy62tvbe?=
 =?us-ascii?Q?ArNfRtFb4LEa2Q0Z44Di2/bxbrRGJTkWiwqvNfJMGzNR7fC2zJFYFBvhziQ6?=
 =?us-ascii?Q?2JJ+csxylrEWNEJfCkA2hY4/pTasDfTCnBl5GHJmVEr57wBuDmMFGmNnTea6?=
 =?us-ascii?Q?oqCaHbNfOfd30ZnCoRRUr3pnFBOvuQnXEif2xEZa0/hNq0/jedbJpVdHTtqq?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p+ymbvJrxakhpRbCGDGlaju4g28uTOewVisiClYeHsEUvjdinlHByy7+ED7GuaaSAo+JJBRtrWH3Bs0/34vMM8znuvLmp9gZsro6uK/K0SfBOWXEXv4ziTMYl+6LW/EKpI7AXzv+fEkjk9fEc4WMW2RciR40q4U5qpPZxvvfnic2bSD9d3/qtiE8FaQone201nkbjqGaj4e9v0GfMd3A4CEhjtNnvcMNIFXmMT4YrwHj0+3YSn+CUMleFjpaEE1r8QvE0MOa2lJjpf3OdRyp0bOJczuqL9Tw3gZj7F1XRk0LiXtCH4+DXOntGLxMvZ/63J8ywQx3+niIfYN75A/umHShoIhRg0Dx7nwm14xwbSJybAQazLabGO4pTIZmSeWGnSYrXHfTfBgVfnx7z6/wljOXKQu2YlVqsvs94NcgoG/xvC4pPssRzOnut42Vg8tWSa2UkOQZrkaYBSTDkvtDG1WfcWbz00GJZjNbKhjajwWUL1OXDjZ0WhLY5HSKLZ+PEwSxlMHtbbE9wW3vxnFluIE7jsy0n51jzI0eBroARJT8JfUuMb72lAA5Y/eh5AjI/RzqOuRITZllh60122ZqKcU6gAXir1D2XUJqftO3M7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8221326-5638-44e0-a492-08dc6e07f87e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 20:06:09.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/Qa7HnN9eoQWHKTcNnHLpNcoKK1sPPSz2lupk1sWYSAbBWB9V0y+gzma/la9y0JpjMaR7dBx64yXham0Fvueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_14,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060145
X-Proofpoint-GUID: T0RzL3vf42RmX7NGL4BWE5iFyNLD9M3o
X-Proofpoint-ORIG-GUID: T0RzL3vf42RmX7NGL4BWE5iFyNLD9M3o

On Mon, May 06, 2024 at 12:37:59PM +0300, Dan Aloni wrote:
> Under the scenario of IB device bonding, when bringing down one of the
> ports, or all ports, we saw xprtrdma entering a non-recoverable state
> where it is not even possible to complete the disconnect and shut it
> down the mount, requiring a reboot. Following debug, we saw that
> transport connect never ended after receiving the
> RDMA_CM_EVENT_DEVICE_REMOVAL callback.
> 
> The DEVICE_REMOVAL callback is irrespective of whether the CM_ID is
> connected, and ESTABLISHED may not have happened. So need to work with
> each of these states accordingly.
> 
> Fixes: 2acc5cae2923 ('xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed')
> Cc: Sagi Grimberg <sagi.grimberg@vastdata.com>
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
> ---
>  net/sunrpc/xprtrdma/verbs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 4f8d7efa469f..432557a553e7 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -244,7 +244,11 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
>  	case RDMA_CM_EVENT_DEVICE_REMOVAL:
>  		pr_info("rpcrdma: removing device %s for %pISpc\n",
>  			ep->re_id->device->name, sap);
> -		fallthrough;
> +		switch (xchg(&ep->re_connect_status, -ENODEV)) {
> +		case 0: goto wake_connect_worker;
> +		case 1: goto disconnected;
> +		}
> +		return 0;
>  	case RDMA_CM_EVENT_ADDR_CHANGE:
>  		ep->re_connect_status = -ENODEV;
>  		goto disconnected;
> -- 
> 2.39.3
> 

Hi Anna,

Please apply this patch with:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

