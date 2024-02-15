Return-Path: <linux-nfs+bounces-1969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8789856D6D
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 20:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED00B238D0
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 19:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CAD12BEAF;
	Thu, 15 Feb 2024 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HnZv1doI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OGstO597"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37B3D6D
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024413; cv=fail; b=QFSAa1LU+GryAgBLK8Srq8rtuANAT1UeFqy/sTaNv9nF2SmC3D0w8FS0iH0YlArllZdayqw1rf2W6GMJz8apXWnGyIa4cvIfxH7zuOas86doSUoGl5PyHx+OGpcB88j3vfeYAVUNbZjbVY7+ewc4AZsM4yz8CZ1PNXYByuylDw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024413; c=relaxed/simple;
	bh=h+3kv4+RCgvrAt6eQFrn2WipJc4ekMAzFXy1Twui7sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aGs7ZCmASIts5yIlRKowCEOYEkJqtMfLWpB4VCixXTaRGpciS9+ywqp8JMIsVAecABtFQE+gjmNmegJMS6qwUucbls4beXP0GpFV2g5XFS4W5om8kS1pjs3LIDcqP2eJfVZTy9hZe3qTatIqCfhseogngIQbgRgt+LSkfvPmqnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HnZv1doI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OGstO597; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFT60o006335;
	Thu, 15 Feb 2024 19:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=bxzgUvfVCfjtXC/+r2HecwJBIP7SIexPVtlPVQN3aCw=;
 b=HnZv1doI7/p2HhH00WJUYySgkSL82/rVw3tye1fRInLeccUiEHm4zU55Es/iiIGWpWLq
 nzCOd+eHZI1BB7tpDitbx+pVFGd3bE4HRuikLX0UKiB3z2loauzlorDvbGk/ytG/u6sp
 uzWhRWiS41eXtSyNk1blHE1bm5kuQkMPbyd8F2v5y4yfdGAjGeG5wQ9/9VFdRpDEdouL
 qAXp7JSxge4TWROEUYmihEgcoidoc/gB7JhXLvILGnIzQCqRbMGLPv0FY9xDeDP8brfp
 raUpXHukfPPXMxJDmnlEAOAafFlIzwp3Kd4jJIys1NQc2fO4i6p33rd9tZl+qaCJ2J5Z 1A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w930130mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 19:13:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FIQ9al000639;
	Thu, 15 Feb 2024 19:13:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykb1bhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 19:13:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ehck7Sh50CJyRGoSTwLt4cqMXDEKHJn6ld0/gz/o7dtl3uoIKgmgVlTEBFpcCqEt+rLw4qOVKN/ViJqNzjP8ltV+xdJhhh86rskMlqzscjq1o66DD9BRaTmunXvnCXgyo9/5ZdCqqzalhHD9SNaKUNfjuXbRcUxnky8L3r14yxpt4ESqxpzYXMivvmDOY97p0ocz5urO83WyeXqzAEnNBSfe2qpFY900onMUY2N2K0TBcIMTCsCuq0PY9yCjbzL7gf3O4dSDXXeKjpwueJUHtTBLasayHl1wuKtmIhg7mEh7TJJvGnXvSTFJ6+pAt8eEgFUeX8HQF9ySYuyfDugBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxzgUvfVCfjtXC/+r2HecwJBIP7SIexPVtlPVQN3aCw=;
 b=Eyh6HXIqBVxdavBf2qcs+pYLu8TOMAF3dgmaEGrXYcqvue/cSx9N8B1uUG4tIHhbWaEOCkDOVT12vyfUGtcWRtgcTlGYtu7dtWynEcy6gVFffthml8knSQ0OizBxMeHggNxteZxSBEoLXlLa0RMlzRRNz1X6Y4OU3FgLbGya1Ft4b8sJsCurm931u3WrONZbpXTICmtpA9vawiJ5N2ZWpS54KDxSa/dynwGSrONLW54hPf8Bcr2GrpKhUlYIyxN/Zpi9JRagxxxcIxQXRWdMR3xqtaspO7sn88EsbXHxswgTpdYaovEUO9Nm9bFlIC4hvKiXOBu6jUbI+cc+60V8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxzgUvfVCfjtXC/+r2HecwJBIP7SIexPVtlPVQN3aCw=;
 b=OGstO597NnSjKGi16oWw8IRyNhvE0FrSOWy9gm9+lSZkgR3/qjK9H4Gmljie2PZ1VgGRYGGzC6W1OtqQla5Vaw3hzlj5Kc7G0ub4UMWDIS4C8+hPQp4lHEjyCBNuig6Tt0EmHk/wKY1JdkLYCNfm0ZUpnXQ4nAAN2X+6kEZw3Ys=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5614.namprd10.prod.outlook.com (2603:10b6:a03:3d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 19:13:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 19:13:22 +0000
Date: Thu, 15 Feb 2024 14:13:19 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] NFSD: handle GETATTR conflict with write
 delegation
Message-ID: <Zc5iT7ib+49fVZME@tissot.1015granger.net>
References: <1708021604-28321-1-git-send-email-dai.ngo@oracle.com>
 <1708021604-28321-3-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708021604-28321-3-git-send-email-dai.ngo@oracle.com>
X-ClientProxiedBy: CH0PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:610:77::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: af6ff791-2711-4cf5-621d-08dc2e5a2d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4e7svwSPFwts2DyUHSk9W0NBgKoMycUVErbrGps9vxdwKlyLffzDGl8C7KxP0D0RTvh+J8S7+zFkf+MQbstPf91HCZDeV0ajMMKnqgGyAg7YEFD73UHiTcNV1iMRlPCzUo7wnfCHz+K9gyuEfy3g+0DHk/Z9QR2r8zwb2HnBKdXZMlljRtVqtMjLhxkmZpcEOkpWU48bariUfwmJ3AX6qq5s2KrMKCWjjGq8Xo3bCYm1vs52/7gUktB+8c/TmgrOG33F7N/hlhIdDNxBZG7bAV1f9Xvqu2ZD2H0toOTdV8fMnGnR/ntU2KCbsC8k/Qmwn63wloLXsl0JvJqriCiVi899/fuxdtBP/7Rt1iuxepdPOMRnMt4xPqfOGy0VqXiVLPlE/yfa/ZSCCSiwgCRVKTogLduWq5Sk/HSvhUZ1Y13SBD5JJD718P14god6Fo7IW36SDID7x8yvj3XToXReFR1AGBq21ds+MSX5Dri091wVTWEnOHVqOQ/AeZxnMHkpssWvJ+OIKipnufEo0UoPRr7KyTTZPrG1LSVHn62JCiXnbm7f7t6eoQ+LlV4yBP5U
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(86362001)(83380400001)(38100700002)(66899024)(66946007)(2906002)(30864003)(5660300002)(44832011)(6486002)(6862004)(66476007)(66556008)(41300700001)(4326008)(8936002)(8676002)(6666004)(9686003)(316002)(478600001)(6506007)(26005)(6512007)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a86TDfNhByNXm+ZIxMtE+AMyL1SrAkFRd1kuw5bkdqI9OVE0CfjgaJdHnYa4?=
 =?us-ascii?Q?U65XZhorfu0RQKN0DWFpOknoX1gc/aO2sue7QypP3BZPsw4197f+pjhGjTXK?=
 =?us-ascii?Q?1WaUBJR4RsYKd+mCrk4Oyp3N+ZiF3176EFtZxvGhWJrC6XhTqQTS8IO3H427?=
 =?us-ascii?Q?0i2IRogauLyi5cqZZaMUzGxJ8f5SqQjg0/CjnnXaCe/g4wX1xLd50YrcIjLY?=
 =?us-ascii?Q?lUuaREBEGISy8WITlK1+f6b43odotuvo54b8ac85Iaj3IzXxsZJXVwdldY5D?=
 =?us-ascii?Q?f9VRGWN+gu74P1QUaicepSuqrNh33hqEb0VeGNbYanEGfYYdw2qtBMpmL+A6?=
 =?us-ascii?Q?5a/SX2RrvpaihIbOkX5FglPoa6n6sltw6g3ZgcAXeVoTj+jWh+/Sxq8/MFE8?=
 =?us-ascii?Q?huy9Qlk7gWy+1pfALCckYhbI8HqWq3Y9MPSwG5DnKQAW3jgJmO1Am2G81JLW?=
 =?us-ascii?Q?yxrKCgX3OIQ9biP550n1lWljiB44BosDrnASbzV0EUIM9hbduVHEhExJYKzV?=
 =?us-ascii?Q?XQQ/zqgnQx9guPXreZmdZe+w8kUxD+4C7u9RW+PzVcW6O7bu9RWEESvd+Diq?=
 =?us-ascii?Q?CybAfR5sT5JEHUNh60/kYib9wiP24srN26fQxorAkW2ZbFz19KKrqxlYEsjR?=
 =?us-ascii?Q?QhFAIrQWh1PIwiTG5nHLSCH76xzJu2OGE1BNJYJlyoHJSgxMilsy/6Nxtu9S?=
 =?us-ascii?Q?uodjqTNHF8f3MfeQQJfkZb65Vk01fq/T134xwMld6SnRaROr6v5k4sYSdnPj?=
 =?us-ascii?Q?xD7daHnIke0YdSUXetDP3L0A69vfMvjRUWO9fTpRzz07wOzE52alCwHsJCJn?=
 =?us-ascii?Q?16zOLytdEjbxhqZCPcN7noS8YGHazR9X1WA6PG+NqWr3sKRVGWxgRDuMvxvx?=
 =?us-ascii?Q?H4bisbOErcdQSun0YciwfmOKSdnCvNcsLvLp1bNYpcomlMSGx6BmXBHgf7GN?=
 =?us-ascii?Q?0Jww6Vy+xRv2sFGrOteccLw1qgxgujRmBCdmYutlyi9q8PyGyFOXLrZ5Yqi+?=
 =?us-ascii?Q?JIEf7HfAbE7sL2Ls1c7i+8ogTVLZm7ZA5YUIx0rkR62gD3j4Knmmk48Ggx18?=
 =?us-ascii?Q?nXd8D0s5lhAkdztaZc4f33HdaEsrCHGi9maSgvMNWN0Ur7cA/8/PHiIBQ+98?=
 =?us-ascii?Q?2rcPpsL7kqcJArxIzxOGt9ajD8PQMHUxFRIk6bYh8R5+sagxF15pRaKSZtUG?=
 =?us-ascii?Q?ugyX5uZRPYDcrJyLCDhbCiMa+dEjCSYc/TFrs2Iv1t91v8AccBoldJsSqY2l?=
 =?us-ascii?Q?BFWjJF65kCQVU90IQfzvZ90ja6zwS6QmT/rwqsVVpoqEmBKAzuqmS72HddN/?=
 =?us-ascii?Q?TkzuDrwLE6HGWgsxf7I1501wJTgpo6jnMgl55EPkm3lJgOHr07yS/wLPraMz?=
 =?us-ascii?Q?GLv0ckvYhhll65Il816vAe397bx+rTGhRKTHRwUffS0MzUZlxNm4BwKf7ven?=
 =?us-ascii?Q?jn8Bp3rWIGun49WkieF306MBdwuV9SI/GF1HusuOzehpTXU5pbz0YOeVCOA8?=
 =?us-ascii?Q?H/nwbcOvdk1Un+gWbuQhMOLqlcROFD34c9NQPlhIt0UiJ1g+wD0IYSHWZnP6?=
 =?us-ascii?Q?7pR85Gxet4kFmeDfpYIQLMQ7euTilEiFjQy6GXcNMBH5Bz5PqO7jX4HqTFH1?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qhHKEwaZjfXpJIltsW5KnIy+0TQzgK4wxP6F8BI3OziaR2/BhErpE7nWPoMQWJ1Q0YdpL4KYK7JtuWeAWUsd9jXKZ3VyGQEmZuWSb1T00cymS4E3k2g8qVjESatrSvO+SACVCcwi8bqGdGRaksDd0BilW92lS0cM/bBYCzWi3JI8AIHNMEcxXGYUCV0JgTil5evmZx3WMHe3dwGtMiM66x7ySFKqG24yF1dOCyEq7iy0Eg9VVdLhyckvMshn/AANbgZ6gGeNpJPQq+DbQ4FnU+DnLFPGMDMRlTbHv2kzhnmsNJ8qNIRZ8fPf8rtEgycdrAQMm2vEdL4qvCHJ3aGMxsyfC7nBeWLDJEGGHyqqRQnQewXTOD4YSsci6BXBQXP9NAoQ2oJBKsl0p2tIT2ILml6HuuCb2UrDcdVzX1/zgOEQZ2R4DQe6d1E2rxPfQSDuziA67L0RJVmQyJ7uWmQ98LVbWFJjbW8AbYo/HvQDgs5TUCuPK799R8ea7GK0ajik6doUPSvvZQAOBftY3bg1M0LDlIpvwNv4ggg5WyHdykbuFNhfNP/3NA+Gk1jQ2F8JifMaAc+Ar94qPuUPbz75VMGu9Qbc4oCzlcIFScDjnnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6ff791-2711-4cf5-621d-08dc2e5a2d22
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:13:22.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ka34/8PKlcgpC8BHNVj/VDF1pOzdZ2x6cS/bZf6g3RDGvCP4SbWUk42WQhzawzN7V6bN8LYsBjesZLz0745IkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_18,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150154
X-Proofpoint-GUID: RrwgGUWHO9ofCsSqIvcl0GzXouT3XAXe
X-Proofpoint-ORIG-GUID: RrwgGUWHO9ofCsSqIvcl0GzXouT3XAXe

On Thu, Feb 15, 2024 at 10:26:44AM -0800, Dai Ngo wrote:
> If the GETATTR request on a file that has write delegation in effect
> and the request attributes include the change info and size attribute
> then the request is handled as below:
> 
> Server sends CB_GETATTR to client to get the latest change info and file
> size. If these values are the same as the server's cached values then
> the GETATTR proceeds as normal.
> 
> If either the change info or file size is different from the server's
> cached values, or the file was already marked as modified, then:
> 
>     . update time_modify and time_metadata into file's metadata
>       with current time
> 
>     . encode GETATTR as normal except the file size is encoded with
>       the value returned from CB_GETATTR
> 
>     . mark the file as modified
> 
> If the CB_GETATTR fails for any reasons, the delegation is recalled
> and NFS4ERR_DELAY is returned for the GETATTR.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Hey Dai -

2/2 doesn't apply cleanly to nfsd-next. Can you rebase and send me
a v3 of this series?


> ---
>  fs/nfsd/nfs4state.c | 116 ++++++++++++++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4xdr.c   |  10 +++-
>  fs/nfsd/nfsd.h      |   1 +
>  fs/nfsd/state.h     |  10 +++-
>  4 files changed, 124 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2fa54cfd4882..a1ce38f9b936 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
>  
>  static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>  static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>  
>  static struct workqueue_struct *laundry_wq;
>  
> @@ -1189,6 +1190,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>  	dp->dl_recalled = false;
>  	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>  		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
> +	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
> +			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
> +	dp->dl_cb_fattr.ncf_file_modified = false;
> +	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
>  	get_nfs4_file(fp);
>  	dp->dl_stid.sc_file = fp;
>  	return dp;
> @@ -2896,11 +2901,59 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>  	spin_unlock(&nn->client_lock);
>  }
>  
> +static int
> +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
> +{
> +	struct nfs4_cb_fattr *ncf =
> +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> +
> +	ncf->ncf_cb_status = task->tk_status;
> +	switch (task->tk_status) {
> +	case -NFS4ERR_DELAY:
> +		rpc_delay(task, 2 * HZ);
> +		return 0;
> +	default:
> +		return 1;
> +	}
> +}
> +
> +static void
> +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
> +{
> +	struct nfs4_cb_fattr *ncf =
> +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> +	struct nfs4_delegation *dp =
> +			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
> +
> +	nfs4_put_stid(&dp->dl_stid);
> +	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
> +	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
> +}
> +
>  static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>  	.done		= nfsd4_cb_recall_any_done,
>  	.release	= nfsd4_cb_recall_any_release,
>  };
>  
> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
> +	.done		= nfsd4_cb_getattr_done,
> +	.release	= nfsd4_cb_getattr_release,
> +};
> +
> +static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
> +{
> +	struct nfs4_delegation *dp =
> +			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
> +
> +	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
> +		return;
> +	/* set to proper status when nfsd4_cb_getattr_done runs */
> +	ncf->ncf_cb_status = NFS4ERR_IO;
> +
> +	refcount_inc(&dp->dl_stid.sc_count);
> +	nfsd4_run_cb(&ncf->ncf_getattr);
> +}
> +
>  static struct nfs4_client *create_client(struct xdr_netobj name,
>  		struct svc_rqst *rqstp, nfs4_verifier *verf)
>  {
> @@ -5635,6 +5688,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	struct svc_fh *parent = NULL;
>  	int cb_up;
>  	int status = 0;
> +	struct kstat stat;
> +	struct path path;
>  
>  	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>  	open->op_recall = false;
> @@ -5672,6 +5727,18 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>  		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
>  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> +		path.mnt = currentfh->fh_export->ex_path.mnt;
> +		path.dentry = currentfh->fh_dentry;
> +		if (vfs_getattr(&path, &stat,
> +				(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> +				AT_STATX_SYNC_AS_STAT)) {
> +			nfs4_put_stid(&dp->dl_stid);
> +			destroy_delegation(dp);
> +			goto out_no_deleg;
> +		}
> +		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> +		dp->dl_cb_fattr.ncf_initial_cinfo =
> +			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
>  	} else {
>  		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
>  		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> @@ -8428,6 +8495,8 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>   * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>   * @rqstp: RPC transaction context
>   * @inode: file to be checked for a conflict
> + * @modified: return true if file was modified
> + * @size: new size of file if modified is true
>   *
>   * This function is called when there is a conflict between a write
>   * delegation and a change/size GETATTR from another client. The server
> @@ -8436,21 +8505,21 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>   * delegation before replying to the GETATTR. See RFC 8881 section
>   * 18.7.4.
>   *
> - * The current implementation does not support CB_GETATTR yet. However
> - * this can avoid recalling the delegation could be added in follow up
> - * work.
> - *
>   * Returns 0 if there is no conflict; otherwise an nfs_stat
>   * code is returned.
>   */
>  __be32
> -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
> +				bool *modified, u64 *size)
>  {
>  	__be32 status;
>  	struct file_lock_context *ctx;
>  	struct file_lock *fl;
>  	struct nfs4_delegation *dp;
> +	struct iattr attrs;
> +	struct nfs4_cb_fattr *ncf;
>  
> +	*modified = false;
>  	ctx = locks_inode_context(inode);
>  	if (!ctx)
>  		return 0;
> @@ -8475,12 +8544,39 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
>  				return 0;
>  			}
>  break_lease:
> -			spin_unlock(&ctx->flc_lock);
>  			nfsd_stats_wdeleg_getattr_inc();
> -			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> -			if (status != nfserr_jukebox ||
> -					!nfsd_wait_for_delegreturn(rqstp, inode))
> -				return status;
> +
> +			dp = fl->fl_owner;
> +			ncf = &dp->dl_cb_fattr;
> +			nfs4_cb_getattr(&dp->dl_cb_fattr);
> +			spin_unlock(&ctx->flc_lock);
> +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
> +					TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
> +			if (ncf->ncf_cb_status) {
> +				/* Recall delegation only if client didn't respond */
> +				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> +				if (status != nfserr_jukebox ||
> +						!nfsd_wait_for_delegreturn(rqstp, inode))
> +					return status;
> +			}
> +			if (!ncf->ncf_file_modified &&
> +					(ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
> +					ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
> +				ncf->ncf_file_modified = true;
> +			if (ncf->ncf_file_modified) {
> +				/*
> +				 * Per section 10.4.3 of RFC 8881, the server would
> +				 * not update the file's metadata with the client's
> +				 * modified size
> +				 */
> +				attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
> +				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
> +				setattr_copy(&nop_mnt_idmap, inode, &attrs);
> +				mark_inode_dirty(inode);
> +				ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
> +				*size = ncf->ncf_cur_fsize;
> +				*modified = true;
> +			}
>  			return 0;
>  		}
>  		break;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c719c475a068..7f68277fbfa5 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3507,6 +3507,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  		unsigned long	mask[2];
>  	} u;
>  	unsigned long bit;
> +	bool file_modified = false;
> +	u64 size = 0;
>  
>  	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
>  	WARN_ON_ONCE(!nfsd_attrs_supported(minorversion, bmval));
> @@ -3533,7 +3535,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  	}
>  	args.size = 0;
>  	if (u.attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> -		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
> +		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
> +					&file_modified, &size);
>  		if (status)
>  			goto out;
>  	}
> @@ -3543,7 +3546,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  			  AT_STATX_SYNC_AS_STAT);
>  	if (err)
>  		goto out_nfserr;
> -	args.size = args.stat.size;
> +	if (file_modified)
> +		args.size = size;
> +	else
> +		args.size = args.stat.size;
>  
>  	if (!(args.stat.result_mask & STATX_BTIME))
>  		/* underlying FS does not offer btime so we can't share it */
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 304e9728b929..908eb7e47842 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -365,6 +365,7 @@ void		nfsd_lockd_shutdown(void);
>  #define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
>  #define	NFS4_CLIENTS_PER_GB		1024
>  #define NFSD_DELEGRETURN_TIMEOUT	(HZ / 34)	/* 30ms */
> +#define	NFSD_CB_GETATTR_TIMEOUT		NFSD_DELEGRETURN_TIMEOUT
>  
>  /*
>   * The following attributes are currently not supported by the NFSv4 server:
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 0bbbe57e027d..f894ba6c9a69 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -125,8 +125,16 @@ struct nfs4_cb_fattr {
>  	/* from CB_GETATTR reply */
>  	u64 ncf_cb_change;
>  	u64 ncf_cb_fsize;
> +
> +	unsigned long ncf_cb_flags;
> +	bool ncf_file_modified;
> +	u64 ncf_initial_cinfo;
> +	u64 ncf_cur_fsize;
>  };
>  
> +/* bits for ncf_cb_flags */
> +#define	CB_GETATTR_BUSY		0
> +
>  /*
>   * Represents a delegation stateid. The nfs4_client holds references to these
>   * and they are put when it is being destroyed or when the delegation is
> @@ -746,5 +754,5 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>  }
>  
>  extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> -				struct inode *inode);
> +		struct inode *inode, bool *file_modified, u64 *size);
>  #endif   /* NFSD4_STATE_H */
> -- 
> 2.39.3
> 

-- 
Chuck Lever

