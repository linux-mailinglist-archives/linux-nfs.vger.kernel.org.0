Return-Path: <linux-nfs+bounces-209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE267FF470
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 17:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2391C209EB
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949FF5466A;
	Thu, 30 Nov 2023 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y6ra0+LW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R7eRO3To"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B510D5;
	Thu, 30 Nov 2023 08:12:44 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUG4Mlb005572;
	Thu, 30 Nov 2023 16:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=dHNr7plyDCY9Qe5HaLDhCIhORerzBDGoOAHksCJY1FI=;
 b=Y6ra0+LWRiPYJRR6Z9PmmPJwDMa+8aQv5R20J8w/h1FjgD25EKdFQom8nxwgwDWEQv6Z
 MnGBHlyLY0mq352P42qtJOhMbtzrUrH2tVskvd613htCng0geoeFAKzlzjD/79/a4hpi
 gBLOhHRhqZk2ov5h2l6e9Y8UgnNdPqQNz/vbrfn/lWik16f4fG+mRFpjb71OAI2dQwVR
 zCUfrwt5MTUHfngkefWtbdtEQBevmQ0rouv6jpMRZvLPur8lmcBnoFokBPO3M00h0AGn
 1UMaahB8n/tWx28dvVjvZWUrhwd19NtV0cdhs6dCNu6NPJ+2MQWONH8iHPstqHyLdQyT 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3upw9eg486-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 16:12:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUFcFeQ026493;
	Thu, 30 Nov 2023 16:11:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7caarmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 16:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLAnTvz4JQQd+rBYgZjwyltGPIFPdxblGLQCXtTHmkjf+3rlRaoybr0xj65qAqX9Fnz3VDErIYxKQn69dzZ3Z+KZLBAE6rV45hSWY2x+BAdGZn8bV4cvNc/w7pe9YXQAqCgKlOUftu6S4gFK9p3z0jiVic9gpMTZmqJkFCsWqtZ601bZvHMTJpLmkl3aYsXH5QbPLOxBlJ/RHrmQifKcSfQ6v/smnT66E7l+jZWTft1Nkv/ScBfKNTwH6LVnjP5Dsuz8wbeQaPe/szCM2oIy8KWsFltIjWE2jAYGFWaGNY2+tiUJ1sdViMq5SDZWZ05cVbKt5AF7PX9gf/q+f4qi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG7PzliW+TOAD3Km/R7pTlsbbrnW9VqbkgwtcwP6wVU=;
 b=Gc2yJk/oiHhgFLmF/2FUNX8MIPkOT0c6tKvg7OlQClxWA/PBHB+qxx6tnG3FruU+VsYCWQaUfklgaQU7vGxgtVqHIbJfLfkCkrCGT8zqv7eEuqpzN7s15zqSqClIyt1Ru+mJbZafLKJiiDGMW2W64p3b2gmBvdfCGbRgulzbqLjSBWTDe3SXcIIMWO6UZqat2zL0b07iY44PBrVFIO/Aik79320X9baWZW6dCcOlTzawdJPnqce8gj93GFy/UkY0yE0TMQlzB43UAJq7W7F52Ls0/B2OtEMzKjxs9NFLHGXmJ2qxcNtTlCX/jniBbrE6I6mh1Ja8pIWQWHpGh9ISGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG7PzliW+TOAD3Km/R7pTlsbbrnW9VqbkgwtcwP6wVU=;
 b=R7eRO3TocMLDRLyHQ8PVut9Eo7YlePj4NLibqhlDPE+a6h5uAeP6uvsS5FzyWW8VzgJnBAIPs1KPXDC/c61fSbNp53uy1iQBm14mX/S9uJ2he57tR+G1JmHbV9Yjl5WJMsFxEiz04krZzD0898s417cS5W8HV+k/xVJV+DKGIn0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 16:11:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 16:11:41 +0000
Date: Thu, 30 Nov 2023 11:11:38 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, neilb@suse.de, netdev@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH v5 2/3] NFSD: convert write_version to netlink command
Message-ID: <ZWi0OkrOsv8j6ev3@tissot.1015granger.net>
References: <cover.1701277475.git.lorenzo@kernel.org>
 <8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>
 <88d91863e36a1e36f7770aa8a7f42853250e3d55.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88d91863e36a1e36f7770aa8a7f42853250e3d55.camel@kernel.org>
X-ClientProxiedBy: CH0PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:610:75::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: d4628201-a7eb-4884-74f7-08dbf1bf09f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BqIQDMSRHHkvJruChDUzVZvAKNjuk/Ns4wJbD2WbzmFyN1oDISipLihdIpmXWsZ5JUJcWhKw/S3/5S2AFkbj6Ld1pO8VeQjMZy9Pxw0agyrPBIVM9m+84VLm7U0hA8fp5uR3wq8M1xqU0KjVHRzA59zkaY8FbZ3a5HnRGidWkAsNPPtswVxY8v7qRo+C2t+3pm2FH9GeiQP1O5rEY/U4ljiRT12kk+o+zhX2jg2khmhlxHjF/HlUEpESm32+RkhFaHMMhhL//ZWo49pL8dyyT9XyRDZYxfV6wUV2zivbwE3VxybHo7vN5dzpE8MgizXTEcN5YCslmzPCyFaOTZPcg6z5U3SC5Gme07W8kwrqbsjY7MhzFTZLQTnqYFK0ZvL/YNoYI+O2bFp/RiiuWu7UrqtXf1ZWILuH0DJ5GD3yCyoowW9HlVA5UqqU6jhDbFcNsGqDKMO8uqJOyi05mVmp/gUH3xBIw2f1Bll8yKX/9vRJabbiIizXCsrt67VHB1oyeg907vu8n78Vk1h7dwHcBN90Ky8J+ltH/+aoqFWQUIXL83OJ/kVbOQ2tuzH1/uQqMPO/g2m/YKW5eLVR1BpoOUi5QeGvx6+NCSNfDQ2zzjQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66476007)(8676002)(316002)(6916009)(66556008)(66946007)(4326008)(8936002)(478600001)(44832011)(6486002)(30864003)(2906002)(86362001)(5660300002)(4001150100001)(38100700002)(6506007)(41300700001)(26005)(9686003)(6512007)(6666004)(83380400001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?3gVDL3ak4CZ/7fPfwBVCgx94Upx/K7M7oiQ44lzR3OPKfgACh5HNJgnLaI?=
 =?iso-8859-1?Q?7oqdbWXhlWrW6We4CSpW9IWjhzfuQKa0tIY5T+8x0JttAzLXokueiyDLMs?=
 =?iso-8859-1?Q?fA2GQ5ujaekbCJ5/VIQc46rOauVzeNofrn7OjeWB/CXoNL/JIbWEbtNx1U?=
 =?iso-8859-1?Q?C4FmZ1PAGDJ5ZCVzPYn//p5eVFEdM88FRkshWXqkjGBow+X+X8LVbwYeNR?=
 =?iso-8859-1?Q?BgNDtz69GQZBMvb74b22u8Y/LStl8+oM0pIvw+cPlLBLXaLon1Ykc/2DjP?=
 =?iso-8859-1?Q?wqrz4EjEtNwLbEzR+EapOIznl8Iy95/Pzi+8r25s7CnLK/o3QFvc34AzX1?=
 =?iso-8859-1?Q?eu5Pqw41/pArcfYIRgoHwquNbFPWBpMreeCeF4cwcJxe7jSuVJttG/HPUB?=
 =?iso-8859-1?Q?e/Dbw6x/jvLZNFtJi16VIJuMii4bxVfX9TAI8k/sjHQqYosm7BiWc1+RGt?=
 =?iso-8859-1?Q?5z3MtOdaECCjajVtw+1Z4nrARtoDtfB8qAyaDoz7o28mi726tlsLQ1xrgB?=
 =?iso-8859-1?Q?AssMCMFS2rqKzCy89TdTQYZbfwPRP7HXAVgw4w7GnDChEysd4QgrCLMJDT?=
 =?iso-8859-1?Q?Oo8pUc4ppxrHZ8GH53TgcrizZyyZR7YABLcBX49v+L29SSW+35+MY9Tvih?=
 =?iso-8859-1?Q?GeZPpl4Pq18s9J5sEbzOuez7qgH1ZvazY9WxXL0y0m9KmEgoovG8MEHfZb?=
 =?iso-8859-1?Q?0GGACmbmCehvOl3mS1HpL2E7PKYtS2KNil3D1ib42/p9Pe0FSodU25BNOP?=
 =?iso-8859-1?Q?fhDTx4okDLbIo4ynAYl+rais87/djxHRNer0cE7Zs+eBeC9CvhhmLRCm5i?=
 =?iso-8859-1?Q?nhm1ouB4zm9+vq+tNq4tLwipxEW4181JqH0fnto8fAAXiubHD2D0xF1sfR?=
 =?iso-8859-1?Q?p1NcXiXrvRkJTWRo3zbgusIdBm7h2/pIvI2POT4R5XTZmwxA6W8wpcwOhR?=
 =?iso-8859-1?Q?JTGb83rInfnBxVF2xKS3xKufQrwH/0+OE8C8wmp7MJPVRamyLus+Gxiwhd?=
 =?iso-8859-1?Q?TwGsQXw1I5sh8rm1BsUhKabQeCDLcZWSUpvS0N3n9SmAFn5rTPMOS2X/TF?=
 =?iso-8859-1?Q?h0LxfdN8DDkYglChFQslLmbamp4XKz80MdPx0qrPwnSq+YiTHLJfpmpPNY?=
 =?iso-8859-1?Q?aqk8kPTZOrbq+KiR9vgSUIIp65AOF0he5vdCDFDgpf9P0JWuxiPVrQZlGw?=
 =?iso-8859-1?Q?d3IdCYaSYUCPaxE5cozct9OUIqTaNZt9/KjSxbvKTEH1dagvS2bNwerYK/?=
 =?iso-8859-1?Q?+vvAwbRVOQedYvJPDKOv5kNKc8wf2c2qnEtpxxoLpuK7MptlBkp1DHdqCZ?=
 =?iso-8859-1?Q?rxMHci0VOlC//zuy6WVvgeCqFPCIJu+CM/JG/ighTfZDbJs4E4T/YQToe+?=
 =?iso-8859-1?Q?N7/FspWU+fXBtbH8zGG8kdUuDX99RdxPZS4IzAsWfaYiWuosjSn1PFiYWh?=
 =?iso-8859-1?Q?kk0ehQTPCeJAdJadpxpzQYvavolpOBolBizmvMvEdW3N/BBfvXukgc9j+J?=
 =?iso-8859-1?Q?n5aPkLxTQEAowhZWnDd9Z76zCatpKuKDfqUBwV8BjlWpjMcBhm9Z0CFH++?=
 =?iso-8859-1?Q?aaHXE7XTifL4Lj+TdxshZHDOpRk38dWVGZsV25EK4jZGIuDC/1R0pUTR8I?=
 =?iso-8859-1?Q?QAErcGtmezVkQ7d7HCWEFa23eiNr5a5XshSkH/rFJYsUBmeGBSQdsTSw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jXCByEKc8B16COZgFKNRT3TxMZarlkz3GraPSL0kV85nH4VkfrZK/OeTZ6+5QiDf1sTjz8LBWIygOsJK0zuony7gISLtli/S4mpZgciApxxNho3HaAxNTLB/bYxX3G8AAB6wBtKxCzabHAHRERAyKrD/70+d8Ism6n/D1N3Sf+16Vhkz1j5s1Fy9MWqm7fIv1aDRntx8O4DTNRLNFDYOPHvUyrCYvk7bTnI+huq4oG+9gjkk5zIjjtvmfvdHFNDa/fC8somx11k3/mM4Kon/7vqcFJPSvhjP9xW5VKKh/m20yhRqmyVhu3s4QrOY4zL1F7aGb3zhGCYm3t4a27T7c9AWItln45CRvv70+F0OUc+pFvgK7fCBRCMaW1AGkwo5I4xKK13Vugf4IGg0FuvOcNStdAM2jPOIwBg1TnjsRgMaO0dU26LH3DRDjhVZZz6GQVQUMI4r8XTvdzNOYhL0mHlf3uHjCxUu48s5FaWut+l/pSKV8uWuGYquaNHXm0W97I4dN2Feuu32qVIV1ND5jVJBQ/LAHp5gTAi1Sm7fqSTKeQjaxb2IdvFSy2TDazeX3O17sYhpkFkXgnMwkAR/Na16cFhAElsK3F8JAfN5f/2bkiJPuRxiwurYJpRE5ehegWTAtVV8uJRTktu6Hg8QccC+6Hsf5J+NXkW7gtlDFaRUQTGSGtb/5ZuQNC7lFGEfVMlpiLKxmHFNhhjRaSyF7dkTypRRgoLCflnJ401xK47oT/fFRoyURpSl2s/4ZRLgApDGDAvV8U2xk/0O2J9E+dZQfaGmPJ+tF8imKhWeGvTyh9mU7eJcwAOTcJaTtKh3xUR/NhP7Mvv0AitY4z+55w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4628201-a7eb-4884-74f7-08dbf1bf09f9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 16:11:41.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znWfGuhBuLfGCQZU0MEZQJvSIYPbMgaGp4RNSUrjX9gEthdGom74N2v2u4fiMUz6e7RIVVO5x4uwdKDQwR7XVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_16,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300118
X-Proofpoint-GUID: jPlKtw8d9FGk3v172VBRzBwLslcRmImS
X-Proofpoint-ORIG-GUID: jPlKtw8d9FGk3v172VBRzBwLslcRmImS

On Wed, Nov 29, 2023 at 01:23:37PM -0500, Jeff Layton wrote:
> On Wed, 2023-11-29 at 18:12 +0100, Lorenzo Bianconi wrote:
> > Introduce write_version netlink command similar to the ones available
> > through the procfs.
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/netlink/specs/nfsd.yaml |  32 ++++++++
> >  fs/nfsd/netlink.c                     |  19 +++++
> >  fs/nfsd/netlink.h                     |   3 +
> >  fs/nfsd/nfsctl.c                      | 105 ++++++++++++++++++++++++++
> >  include/uapi/linux/nfsd_netlink.h     |  11 +++
> >  tools/net/ynl/generated/nfsd-user.c   |  81 ++++++++++++++++++++
> >  tools/net/ynl/generated/nfsd-user.h   |  55 ++++++++++++++
> >  7 files changed, 306 insertions(+)
> > 
> > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> > index c92e1425d316..6c5e42bb20f6 100644
> > --- a/Documentation/netlink/specs/nfsd.yaml
> > +++ b/Documentation/netlink/specs/nfsd.yaml
> > @@ -68,6 +68,18 @@ attribute-sets:
> >        -
> >          name: threads
> >          type: u32
> > +  -
> > +    name: server-version
> > +    attributes:
> > +      -
> > +        name: major
> > +        type: u32
> > +      -
> > +        name: minor
> > +        type: u32
> > +      -
> > +        name: status
> > +        type: u8
> >  
> >  operations:
> >    list:
> > @@ -110,3 +122,23 @@ operations:
> >          reply:
> >            attributes:
> >              - threads
> > +    -
> > +      name: version-set
> > +      doc: enable/disable server version
> > +      attribute-set: server-version
> > +      flags: [ admin-perm ]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - major
> > +            - minor
> > +            - status
> > +    -
> > +      name: version-get
> > +      doc: dump server versions
> > +      attribute-set: server-version
> > +      dump:
> > +        reply:
> > +          attributes:
> > +            - major
> > +            - minor
> > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > index 1a59a8e6c7e2..0608a7bd193b 100644
> > --- a/fs/nfsd/netlink.c
> > +++ b/fs/nfsd/netlink.c
> > @@ -15,6 +15,13 @@ static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WORKER_T
> >  	[NFSD_A_SERVER_WORKER_THREADS] = { .type = NLA_U32, },
> >  };
> >  
> > +/* NFSD_CMD_VERSION_SET - do */
> > +static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_VERSION_STATUS + 1] = {
> > +	[NFSD_A_SERVER_VERSION_MAJOR] = { .type = NLA_U32, },
> > +	[NFSD_A_SERVER_VERSION_MINOR] = { .type = NLA_U32, },
> > +	[NFSD_A_SERVER_VERSION_STATUS] = { .type = NLA_U8, },
> > +};
> > +
> >  /* Ops table for nfsd */
> >  static const struct genl_split_ops nfsd_nl_ops[] = {
> >  	{
> > @@ -36,6 +43,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
> >  		.doit	= nfsd_nl_threads_get_doit,
> >  		.flags	= GENL_CMD_CAP_DO,
> >  	},
> > +	{
> > +		.cmd		= NFSD_CMD_VERSION_SET,
> > +		.doit		= nfsd_nl_version_set_doit,
> > +		.policy		= nfsd_version_set_nl_policy,
> > +		.maxattr	= NFSD_A_SERVER_VERSION_STATUS,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> > +	{
> > +		.cmd	= NFSD_CMD_VERSION_GET,
> > +		.dumpit	= nfsd_nl_version_get_dumpit,
> > +		.flags	= GENL_CMD_CAP_DUMP,
> > +	},
> >  };
> >  
> >  struct genl_family nfsd_nl_family __ro_after_init = {
> > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > index 4137fac477e4..7d203cec08e4 100644
> > --- a/fs/nfsd/netlink.h
> > +++ b/fs/nfsd/netlink.h
> > @@ -18,6 +18,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> >  				  struct netlink_callback *cb);
> >  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
> >  int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
> > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info);
> > +int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
> > +			       struct netlink_callback *cb);
> >  
> >  extern struct genl_family nfsd_nl_family;
> >  
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 130b3d937a79..f04430f79687 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1757,6 +1757,111 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
> >  	return err;
> >  }
> >  
> > +/**
> > + * nfsd_nl_version_set_doit - enable/disable the provided nfs server version
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
> > +	enum vers_op cmd;
> > +	u32 major, minor;
> > +	u8 status;
> > +	int ret;
> > +
> > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_MAJOR) ||
> > +	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_MINOR) ||
> > +	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_STATUS))
> > +		return -EINVAL;
> > +
> > +	major = nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_MAJOR]);
> > +	minor = nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_MINOR]);
> > +
> > +	status = nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_STATUS]);
> > +	cmd = !!status ? NFSD_SET : NFSD_CLEAR;
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	switch (major) {
> > +	case 4:
> > +		ret = nfsd_minorversion(nn, minor, cmd);
> > +		break;
> > +	case 2:
> > +	case 3:
> > +		if (!minor) {
> > +			ret = nfsd_vers(nn, major, cmd);
> > +			break;
> > +		}
> > +		fallthrough;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * nfsd_nl_version_get_doit - Handle verion_get dumpit
> > + * @skb: reply buffer
> > + * @cb: netlink metadata and command arguments
> > + *
> > + * Returns the size of the reply or a negative errno.
> > + */
> > +int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
> > +			       struct netlink_callback *cb)
> > +{
> > +	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
> > +	int i, ret = -ENOMEM;
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +
> > +	for (i = 2; i <= 4; i++) {
> > +		int j;
> > +
> > +		if (i < cb->args[0]) /* already consumed */
> > +			continue;
> > +
> > +		if (!nfsd_vers(nn, i, NFSD_AVAIL))
> > +			continue;
> > +
> > +		for (j = 0; j <= NFSD_SUPPORTED_MINOR_VERSION; j++) {
> > +			void *hdr;
> > +
> > +			if (!nfsd_vers(nn, i, NFSD_TEST))
> > +				continue;
> > +
> > +			/* NFSv{2,3} does not support minor numbers */
> > +			if (i < 4 && j)
> > +				continue;
> > +
> > +			if (i == 4 && !nfsd_minorversion(nn, j, NFSD_TEST))
> > +				continue;
> > +
> > +			hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> > +					  cb->nlh->nlmsg_seq, &nfsd_nl_family,
> > +					  0, NFSD_CMD_VERSION_GET);
> > +			if (!hdr)
> > +				goto out;
> > +
> > +			if (nla_put_u32(skb, NFSD_A_SERVER_VERSION_MAJOR, i) ||
> > +			    nla_put_u32(skb, NFSD_A_SERVER_VERSION_MINOR, j))
> > +				goto out;
> > +
> > +			genlmsg_end(skb, hdr);
> > +		}
> > +	}
> > +	cb->args[0] = i;
> > +	ret = skb->len;
> > +out:
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
> > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
> > index 1b6fe1f9ed0e..1b3340f31baa 100644
> > --- a/include/uapi/linux/nfsd_netlink.h
> > +++ b/include/uapi/linux/nfsd_netlink.h
> > @@ -36,10 +36,21 @@ enum {
> >  	NFSD_A_SERVER_WORKER_MAX = (__NFSD_A_SERVER_WORKER_MAX - 1)
> >  };
> >  
> > +enum {
> > +	NFSD_A_SERVER_VERSION_MAJOR = 1,
> > +	NFSD_A_SERVER_VERSION_MINOR,
> > +	NFSD_A_SERVER_VERSION_STATUS,
> > +
> > +	__NFSD_A_SERVER_VERSION_MAX,
> > +	NFSD_A_SERVER_VERSION_MAX = (__NFSD_A_SERVER_VERSION_MAX - 1)
> > +};
> > +
> >  enum {
> >  	NFSD_CMD_RPC_STATUS_GET = 1,
> >  	NFSD_CMD_THREADS_SET,
> >  	NFSD_CMD_THREADS_GET,
> > +	NFSD_CMD_VERSION_SET,
> > +	NFSD_CMD_VERSION_GET,
> >  
> >  	__NFSD_CMD_MAX,
> >  	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
> > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
> > index 9768328a7751..4cb71c3cd18d 100644
> > --- a/tools/net/ynl/generated/nfsd-user.c
> > +++ b/tools/net/ynl/generated/nfsd-user.c
> > @@ -17,6 +17,8 @@ static const char * const nfsd_op_strmap[] = {
> >  	[NFSD_CMD_RPC_STATUS_GET] = "rpc-status-get",
> >  	[NFSD_CMD_THREADS_SET] = "threads-set",
> >  	[NFSD_CMD_THREADS_GET] = "threads-get",
> > +	[NFSD_CMD_VERSION_SET] = "version-set",
> > +	[NFSD_CMD_VERSION_GET] = "version-get",
> >  };
> >  
> >  const char *nfsd_op_str(int op)
> > @@ -58,6 +60,17 @@ struct ynl_policy_nest nfsd_server_worker_nest = {
> >  	.table = nfsd_server_worker_policy,
> >  };
> >  
> > +struct ynl_policy_attr nfsd_server_version_policy[NFSD_A_SERVER_VERSION_MAX + 1] = {
> > +	[NFSD_A_SERVER_VERSION_MAJOR] = { .name = "major", .type = YNL_PT_U32, },
> > +	[NFSD_A_SERVER_VERSION_MINOR] = { .name = "minor", .type = YNL_PT_U32, },
> > +	[NFSD_A_SERVER_VERSION_STATUS] = { .name = "status", .type = YNL_PT_U8, },
> > +};
> > +
> > +struct ynl_policy_nest nfsd_server_version_nest = {
> > +	.max_attr = NFSD_A_SERVER_VERSION_MAX,
> > +	.table = nfsd_server_version_policy,
> > +};
> > +
> >  /* Common nested types */
> >  /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
> >  /* NFSD_CMD_RPC_STATUS_GET - dump */
> > @@ -290,6 +303,74 @@ struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys)
> >  	return NULL;
> >  }
> >  
> > +/* ============== NFSD_CMD_VERSION_SET ============== */
> > +/* NFSD_CMD_VERSION_SET - do */
> > +void nfsd_version_set_req_free(struct nfsd_version_set_req *req)
> > +{
> > +	free(req);
> > +}
> > +
> > +int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_req *req)
> > +{
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_VERSION_SET, 1);
> > +	ys->req_policy = &nfsd_server_version_nest;
> > +
> > +	if (req->_present.major)
> > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_VERSION_MAJOR, req->major);
> > +	if (req->_present.minor)
> > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_VERSION_MINOR, req->minor);
> > +	if (req->_present.status)
> > +		mnl_attr_put_u8(nlh, NFSD_A_SERVER_VERSION_STATUS, req->status);
> > +
> > +	err = ynl_exec(ys, nlh, NULL);
> > +	if (err < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> > +/* ============== NFSD_CMD_VERSION_GET ============== */
> > +/* NFSD_CMD_VERSION_GET - dump */
> > +void nfsd_version_get_list_free(struct nfsd_version_get_list *rsp)
> > +{
> > +	struct nfsd_version_get_list *next = rsp;
> > +
> > +	while ((void *)next != YNL_LIST_END) {
> > +		rsp = next;
> > +		next = rsp->next;
> > +
> > +		free(rsp);
> > +	}
> > +}
> > +
> > +struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock *ys)
> > +{
> > +	struct ynl_dump_state yds = {};
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	yds.ys = ys;
> > +	yds.alloc_sz = sizeof(struct nfsd_version_get_list);
> > +	yds.cb = nfsd_version_get_rsp_parse;
> > +	yds.rsp_cmd = NFSD_CMD_VERSION_GET;
> > +	yds.rsp_policy = &nfsd_server_version_nest;
> > +
> > +	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_VERSION_GET, 1);
> > +
> > +	err = ynl_exec_dump(ys, nlh, &yds);
> > +	if (err < 0)
> > +		goto free_list;
> > +
> > +	return yds.first;
> > +
> > +free_list:
> > +	nfsd_version_get_list_free(yds.first);
> > +	return NULL;
> > +}
> > +
> >  const struct ynl_family ynl_nfsd_family =  {
> >  	.name		= "nfsd",
> >  };
> > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
> > index e162a4f20d91..e61c5a9e46fb 100644
> > --- a/tools/net/ynl/generated/nfsd-user.h
> > +++ b/tools/net/ynl/generated/nfsd-user.h
> > @@ -111,4 +111,59 @@ void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp);
> >   */
> >  struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
> >  
> > +/* ============== NFSD_CMD_VERSION_SET ============== */
> > +/* NFSD_CMD_VERSION_SET - do */
> > +struct nfsd_version_set_req {
> > +	struct {
> > +		__u32 major:1;
> > +		__u32 minor:1;
> > +		__u32 status:1;
> > +	} _present;
> > +
> > +	__u32 major;
> > +	__u32 minor;
> > +	__u8 status;
> > +};
> > +
> 
> This more or less mirrors how the "versions" file works today, but that
> interface is quite klunky.  We don't have a use case that requires that
> we do this piecemeal like this. I think we'd be better served with a
> more declarative interface that reconfigures the supported versions in
> one shot:
> 
> Instead of having "major,minor,status" and potentially having to call
> this command several times from userland, it seems like it would be
> nicer to just have userland send down a list "major,minor" that should
> be enabled, and then just let the kernel figure out whether to enable or
> disable each. An empty list could mean "disable everything".
> 
> That's simpler to reason out as an interface from userland too. Trying
> to keep track of the enabled and disabled versions and twiddle it is
> really tricky in rpc.nfsd today.

Jeff and Lorenzo, this sounds to me like a useful and narrow
improvement to this interface, one that should be implemented as
part of this patch series.

Ditto for Jeff's review comment on 3/3.


> > +static inline struct nfsd_version_set_req *nfsd_version_set_req_alloc(void)
> > +{
> > +	return calloc(1, sizeof(struct nfsd_version_set_req));
> > +}
> > +void nfsd_version_set_req_free(struct nfsd_version_set_req *req);
> > +
> > +static inline void
> > +nfsd_version_set_req_set_major(struct nfsd_version_set_req *req, __u32 major)
> > +{
> > +	req->_present.major = 1;
> > +	req->major = major;
> > +}
> > +static inline void
> > +nfsd_version_set_req_set_minor(struct nfsd_version_set_req *req, __u32 minor)
> > +{
> > +	req->_present.minor = 1;
> > +	req->minor = minor;
> > +}
> > +static inline void
> > +nfsd_version_set_req_set_status(struct nfsd_version_set_req *req, __u8 status)
> > +{
> > +	req->_present.status = 1;
> > +	req->status = status;
> > +}
> > +
> > +/*
> > + * enable/disable server version
> > + */
> > +int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_req *req);
> > +
> > +/* ============== NFSD_CMD_VERSION_GET ============== */
> > +/* NFSD_CMD_VERSION_GET - dump */
> > +struct nfsd_version_get_list {
> > +	struct nfsd_version_get_list *next;
> > +	struct nfsd_version_get_rsp obj __attribute__ ((aligned (8)));
> > +};
> > +
> > +void nfsd_version_get_list_free(struct nfsd_version_get_list *rsp);
> > +
> > +struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock *ys);
> > +
> >  #endif /* _LINUX_NFSD_GEN_H */
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

