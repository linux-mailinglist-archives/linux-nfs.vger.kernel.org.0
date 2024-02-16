Return-Path: <linux-nfs+bounces-1990-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD4857DBE
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 14:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7731C20951
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D59129A9B;
	Fri, 16 Feb 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IDU1d6tK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c/TlAhV0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D63129A96
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090456; cv=fail; b=hM3+N/9VMBJqpK3tiTDFcya13G6f9VpBbrzA77q58zgEkWlVP0JXYZCU7xrEIG3arGYHVZSavZvKJPwj9A8+ynRBhE98fy1xmd25HpL2m6GX21n4QgrHabeJ9Nz5dWeigXPNkvWA1UqG7k7BsbhIPGvNqkE4C0NT6fY/t03idhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090456; c=relaxed/simple;
	bh=scW9jcw6YG5bd7jiQNrFY9vyxw7PCc1Eqxs8R2JkLrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bWlOPHKVA+heAL5Zren6xCt+kfbgXPQBj5bkRbQ2/RXPXRQzqkMiRMggGJM4MLGn+E14nyfD1ucCcCRxmt0X30sfyIs5octW7fYlAJpyEj7LF94oZ+T5lDW1aQ2rdITROCt0OnFTKFmoHTq9jPJEvXrpg+CZ40OekaxneYjr5mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IDU1d6tK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c/TlAhV0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCrnBh018079;
	Fri, 16 Feb 2024 13:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=WrE4iCRbMsSnjA517afOk8HncqTnXB3An9rG/n1QHWM=;
 b=IDU1d6tKCc+xJ8R1vdvoWIlzDlcZTIUJkyNfCwBUZpK993NbAx40BRGOCvCIra51QuW+
 XK6Rp9uo+lcouTXJ7OWGlr/xeaszGdK9iMYlp/+1R2IZQiwYXvnUfSaMkJ4C9qGrVzlb
 L/Cl1XSzGBbXa8AJNcp+wlAhKw1IIjbEaP3PcdSk1ZgKBtzWMlXhooYIu4RECXkg2vv7
 WZu2yFBeoFGehhLlzjPBBQgT8kizfnGFmJ9+9LXCOgkOpaKb7U9ss/1qzbqky+OTgUHQ
 JnF2NOU5DgGFObjC3fQuPzR4Q6q0hGpETFqEhVO+6kL6IgNb175YkQE5NqowpjlKVzXK kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301n4c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 13:34:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GDUh6I031505;
	Fri, 16 Feb 2024 13:34:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykc4ppf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 13:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iip3abSXrEVEvKtRlgljbwhqtuuOY9zvPhR0coYx0utNk0PWiILDdXlprHc42lPwMy3rplrqMVlbjuf7DlyjpPGDswXRT3KnMRst9N+0jgf1gVGi7kwSfStD6FSXzJ6Ojzr0UHgO8BlOVzelI3pCLJQhRutRuJmW9O1QcPGKiH4UIhWSoq5XI+ezpV6NZyxRU42kP87SZywXm6H8fzB6WZ/WX7S5lBIgru3gm8aVuLHZT8GQ4h0X3ULhXsu2sTXNkDKbP9Nraze9Cx7hms9o2j5KFSJ7F+wtEVwxPk5LU4o/Lntkc03UnSRcEJxRrYNkEJJbzRv4dqMMf6fr2iD1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrE4iCRbMsSnjA517afOk8HncqTnXB3An9rG/n1QHWM=;
 b=Ks4cNM7xE6EuG6ISbYnezz6BchxuVkXsrYQny320fp2sJD/HCR7SmJAyr16/im/4epOAKm4plnl5i9fexNm/MwfWH389I2TLFdyVI2MYlYXI1hMG3p0br6mWrQdnAPUt+r/NhMqsegCapZtG+c4UrxgGzctkBmbhoXOZS4jAb94KQiUKJNNNcVY5bbB7wctgAzwMI0bmWsm9YznwC6tRIokXAoucn++wU5MRvssaPrewjjsS6XX9PRidnLGzlie10OOgXSHXrbS2U5cRjPHaKvs8xuRidYQ2oAQ9fsYYmB4bkto75teEwNI85yZp50dwGDAMXgvuz6zIrqVrm5FTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrE4iCRbMsSnjA517afOk8HncqTnXB3An9rG/n1QHWM=;
 b=c/TlAhV0eAd7UElo3vD+TNHsSjWHjS1SBNtle0rNmIQ1rwBQpPK3r16dtpeiCZFqWd7AEmm0ZENAB49K/tinGXU3F3XEqmVG3Qrj8ImUq0eyLFM5b0ZyxY97gNm1lkbF0v577ArTb+bnHV9H28CUN6h04G2ii3Oj1hNwYf8Xhjc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 13:33:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 13:33:58 +0000
Date: Fri, 16 Feb 2024 08:33:55 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: "trondmy@kernel.org" <trondmy@kernel.org>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Message-ID: <Zc9kQ1Autf6xdcii@tissot.1015granger.net>
References: <20240216012451.22725-1-trondmy@kernel.org>
 <20240216012451.22725-2-trondmy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216012451.22725-2-trondmy@kernel.org>
X-ClientProxiedBy: CH2PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:610:4f::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 733dc817-bfa5-4035-4a07-08dc2ef3eda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dbXYsTP1XbAxYWWLGWXyCzsm2YUm4VM4Bq4mpKDXFnrSYnDjt5HpWvvT2VJgWG+QlZaDOo13WChz4u90R4wXWbUGei4S5DT+UY+URkPZ9gwJg9z3u61R/a4Vor2xyk2+GSwxI+zvmi8RcOcjqE64b3LXXHKcwVEwkPmBnfig/zZcrCQOpzThyKYSEII7KB40zX+wO0YAHtPElsvpTHk5MYtsl/uMFEG/824Z8nHEdGAC8ZeMECNOg+3lm4nGeuUSSd/FP1uhJF8v3COMP0NrJFsR8XLMOdv49nwVqD4RJuKKRqt2iAE8XGgZqRPX2Q6G0N+ahR0/gqz/T1qs75BSdubrBEPKZvoeBeERrEr7X5hmrW4wGyemo4FN+bZaohiuyr+SpelPslpcExMI5M5RE16k6SJM7HXU93HnxXah8F6cTtbmyrPSZB1hhgH/r14SBolYsTqWMKx3QRqviVRdprXSwr3iYtQffbfb2DQ0DCXhkaLCyuI0Me64CZzhLml8cF/HR1Xrl7nUpjjPnImGIbv7dEoMavRcg0kLxBgeneOe0DFx6phXrF7yuDGxyYcP
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(86362001)(38100700002)(83380400001)(26005)(6916009)(44832011)(2906002)(5660300002)(8676002)(4326008)(8936002)(66476007)(66556008)(66946007)(478600001)(41300700001)(6512007)(9686003)(316002)(6506007)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4uhUaKtYzLb64T0RWPbo3BtLH2+C6JKkIt0K9gYD1GRTDc6XBaDRw9zuhYsX?=
 =?us-ascii?Q?dxfDGQUBvn7FFH/IGW7CokEJtooRtug2kmYi4XPlSsVgWSW31GGTrxXyrb5R?=
 =?us-ascii?Q?pk5/HvZORksHOxNH/O8EyzA7EsIrnLNB/ewI4MAQ3wlgqQ1IV6RFF+5NHLY5?=
 =?us-ascii?Q?innmdVz2AvI5jDMgh87PoMYUx3i5WOGtGlI7tJnzl/uMFnSFNaJPwId1/adY?=
 =?us-ascii?Q?xEcj3MMB8lLgipBvro78HLBFtbvfBo6OpS9JMCwDe3svzGPNo5DyJTaDK6TM?=
 =?us-ascii?Q?NSjoOmoN/lmUP7W075+ezrTSRXTh1L/4o1RLtoQF6ITqInP6iuPJKjj1kj0O?=
 =?us-ascii?Q?0r23Y0O1V0M0gNKJ76FGNeSlfmsKgDkVOPDfcxd6tvKXFX6MCbEwZUjHbeji?=
 =?us-ascii?Q?2x1b8CYrk32H//xsNMVUDdl90gAkXVMyF0vX+8Vc92zpyxpDj1jSuLHza9Pi?=
 =?us-ascii?Q?RQz8811vgT32oLKEyl2AMd5ufWknhxl/HR/z7+K69yssmuuW4CfSd4p9Uzwp?=
 =?us-ascii?Q?FT5EiyheZfhT8mbHV9kB9rAGCu2iPKDtZx3hOrny6acl+OeURDM0w6NLckZe?=
 =?us-ascii?Q?5iYcdSyuIGbahijK+bliiRxDUYWkb21NkOTV5fBLq/Agoquaqm2bI5c3Xfti?=
 =?us-ascii?Q?7Pzjp4+/ohPP6FSEUxW1i8HNiPnsTPjCkiRmd7ECLEzwhV7+ZkoSrYy5agDD?=
 =?us-ascii?Q?Xc3JX7ud8bPqss1MZZlzWH5AD9bh2If6NCuwsWqIXEP2+rscL2uOvKII+0Of?=
 =?us-ascii?Q?WJ6OSdC8+RdDf/aNx0Qd32+wH1xcWKR2NeFTbzdaV91k4Wj3XgQAdAev7UqD?=
 =?us-ascii?Q?JngUjvVHEH4ZkMq77PcuvoRhjPlkB31x3C/xqpmnAPVXYXUqJWEWBC9xSfyZ?=
 =?us-ascii?Q?Z1+2j6LlevWTSKzihFCzPeb4zRfRAeJIeKrQQonpgPM+3Xzg6iFox4V4KmRS?=
 =?us-ascii?Q?mUM6LRZblrEn/e19kMBcf9QJuYVQWatKDZfLXewJcUkgGeuUenKFzEKAu75s?=
 =?us-ascii?Q?8V9kXrTxl3mvYeP0KaKxUr/bXKvS90TvKVEwwrGXAoMr9NQvkFykyuU1pmme?=
 =?us-ascii?Q?JLvrl/AmIfBb6ocDJ4sEJwTFlXzECxVD15VW4DJyhNFyo8poSTpmsdNotvZe?=
 =?us-ascii?Q?hEhCbYNPUHXHF59fBtDjARFEf4a8donDR7WAN6IlvORcMWduDa4Eiqvb6xc+?=
 =?us-ascii?Q?KKKQt7dGicR+5+t/UMva0ld9nQ0pHzJIM9D6ceEleR7bRNtke0d3EtBdwhLr?=
 =?us-ascii?Q?CNUZFUPFy6bTnb9PgU5OuAsyD7T3j+xE9vcmHc1mqsBLwFo+8ZOBNR08qgS8?=
 =?us-ascii?Q?UF5hTbM1Xyx6cMiuk1psL0y6B0HgThqLvT9sIehfiyWiDYEBeXInbzmrpKzd?=
 =?us-ascii?Q?tfbASs13DBRsVYTDtHXgfQufDPhJVPZUBqotxjalCIWU4Q/vruNvEOf7r9hD?=
 =?us-ascii?Q?1tFHKflQbzpGB2wPBLa2gqIb3b5s0M89n8TpQZBiIqz33ICrofgNxr2bblrt?=
 =?us-ascii?Q?tkYwcvMmv+HbNFBv2+6b7EUYA1RLVleHvSIVvUUz31e6wOPlkk2xuRrIpsjA?=
 =?us-ascii?Q?tCAeitrahUNlGcc2EwFJOZlqm0X9xHLik0TwC2Daf5btlACHXGQHyqPHYsl7?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8J/7ibyx84DKVPtwayAdmK7dP/1TUbKB901J8KD+C21szUXa5zcXszmecEW/ayIPffzb6+/mSj2rodJZyCM1NkM7q1/j6CM2z61UNUy/7NePeABnslmTiA5bRqXwqVdNoYpXSdMYL1yxRIiS0m45ReUJFyeeckR/uSY5MmDSjiXFKyYZQHsm8rhhXjapDPfwr+/mqs1Rz5B79Ryjf80HXyd+PdkxZ0w/k3SsEAh01oU1C8BTELO8Qpddjh/B1ka5vQERRbVhv1zZ1NQzoXWCpetsjLVkhYmg8HEPnKTmuLlJsXmfF/9SmF7Bm5mAXEl3yBDNGWxDXQ8itZt0yGY3Rto8zyrijiNI/Pq7nVwWoBMyZETsDagYpC8Fvio6KApjV9koi6yudkuXxKak2c0kmw1cw8HbYrywYhiEpuTGLpk82ImsUGXL41yiG6S4ik5aawqkvXQ2GtFt5zdcAKkHVnlQiA8E0dJhJZ1tDkgcfFnJHWNsruogkS4y3owYkyswhd3xncLZ+u+R+jYL2scSFpNU+tGDp2CJQLt5eegjNvuJUircUFb128SoANwy8Bp2MF2uv9HSGOcS7Mswzuv4FMJ8tWYzdPSyOJcgPKhYUVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733dc817-bfa5-4035-4a07-08dc2ef3eda9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 13:33:58.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0niGBf6B1UILKRPzxKKJC5qWAB55uh6uS8XgJB2F7Hflfcn0w+4whJqu1HMYxqVTQbMRSM6qqKnBI3RVGtAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_11,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=930 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160109
X-Proofpoint-GUID: 6zStbLM7DW6ABKKUAYWh83DKtSL4HaKL
X-Proofpoint-ORIG-GUID: 6zStbLM7DW6ABKKUAYWh83DKtSL4HaKL

On Thu, Feb 15, 2024 at 08:24:50PM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Commit bb4d53d66e4b broke the NFSv3 pre/post op attributes behaviour
> when doing a SETATTR rpc call by stripping out the calls to
> fh_fill_pre_attrs() and fh_fill_post_attrs().

Can you give more detail about what broke?


> Fixes: bb4d53d66e4b ("NFSD: use (un)lock_inode instead of fh_(un)lock for file operations")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/nfs4proc.c | 4 ++++
>  fs/nfsd/vfs.c      | 9 +++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 14712fa08f76..e6d8624efc83 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1143,6 +1143,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	};
>  	struct inode *inode;
>  	__be32 status = nfs_ok;
> +	bool save_no_wcc;
>  	int err;
>  
>  	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
> @@ -1168,8 +1169,11 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	if (status)
>  		goto out;
> +	save_no_wcc = cstate->current_fh.fh_no_wcc;
> +	cstate->current_fh.fh_no_wcc = true;
>  	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
>  				0, (time64_t)0);
> +	cstate->current_fh.fh_no_wcc = save_no_wcc;
>  	if (!status)
>  		status = nfserrno(attrs.na_labelerr);
>  	if (!status)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 6e7e37192461..58fab461bc00 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -497,7 +497,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	int		accmode = NFSD_MAY_SATTR;
>  	umode_t		ftype = 0;
>  	__be32		err;
> -	int		host_err;
> +	int		host_err = 0;
>  	bool		get_write_count;
>  	bool		size_change = (iap->ia_valid & ATTR_SIZE);
>  	int		retries;
> @@ -555,6 +555,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	}
>  
>  	inode_lock(inode);
> +	err = fh_fill_pre_attrs(fhp);
> +	if (err)
> +		goto out_unlock;
>  	for (retries = 1;;) {
>  		struct iattr attrs;
>  
> @@ -582,13 +585,15 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
>  						dentry, ACL_TYPE_DEFAULT,
>  						attr->na_dpacl);
> +	fh_fill_post_attrs(fhp);
> +out_unlock:
>  	inode_unlock(inode);
>  	if (size_change)
>  		put_write_access(inode);
>  out:
>  	if (!host_err)
>  		host_err = commit_metadata(fhp);
> -	return nfserrno(host_err);
> +	return err != 0 ? err : nfserrno(host_err);
>  }
>  
>  #if defined(CONFIG_NFSD_V4)
> -- 
> 2.43.1
> 
> 

-- 
Chuck Lever

