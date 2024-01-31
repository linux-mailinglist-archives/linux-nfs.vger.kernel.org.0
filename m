Return-Path: <linux-nfs+bounces-1628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785DC844317
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 16:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C9E280A97
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AF1272BA;
	Wed, 31 Jan 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k75f1Q31";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FXsr3RA4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE484A51
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715154; cv=fail; b=nDCDhxiX1x9JeTHeLojblfPqHxvCIPTQFAcEpLzSzDdK6bU+9+e63ljDn33n+pSujSuXQKwCkYjioBpKrIwClQijUwfGawD+pOQ0oeTKqofKO31pHWt5vHnUsYPYEtPMQbL2NoEb4LMi1yDmXXFmhqlWyA+to/EBZpWz7HdGA+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715154; c=relaxed/simple;
	bh=lBjwnRc/+lGSJKX+XyEe0vs/NL2m7y7JDqutj84KwUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxY26V9tywkkA3JNKTb8EGaCkZyF8tOEO/g9aivAdvR/TB8+z3sv52DWriTCmYQtvNK2sqUDK3Mhglw5ie66SxQOo3mY5y+Y1Vg0qI4XWsJhyBqLNFqktDaPxLb+EZ6NnOxpy1DCYo6tro/FoS07ZMHfy/JBvBInzepmvg9OEOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k75f1Q31; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FXsr3RA4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEwqPn005461;
	Wed, 31 Jan 2024 15:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=uVVE4wTqHJhARiEYEwn5RsPaurziEN4z/wtx3LnViPU=;
 b=k75f1Q31gkmlVw8GnI7Bnc7rv4fVpxAl1VBYi4MUjm8l09MLEP3hMJ2sKa9coXhoA+E+
 EzrwMj8+wp2hocWMEhvZjn7eM0NEmnpfORkbouuj02aub4ZEbwlXRDS//RM+vjobuh+B
 kiNX6FQKo44k9RAALkg+nfAoQlqt3Ab2OinRkilzPTh4Z+BFiPGxocIF9TBpRW4Z9yme
 2CeoHfP/97MoRXJy+/avASHQTah/6VBfpAPVWBIOoPdpqu7dALcHZIF3P715GNLpJq1N
 W9FcelH9+2Id765y6rtxPR24y2HYo2g1WFJAwJpM88AJllHwCU7jNY0dHUIgYe3nkhYl zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdt48j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 15:32:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VFWF5S016261;
	Wed, 31 Jan 2024 15:32:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9f875u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 15:32:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7mDOhA1xGJTr/TnVdxAPPJsdGSnoIiRyNll3Q9Of5F/62cNcnSc2IN9J/X1PNtb/WLqKLWK9nHqPzXmvWycxAPHHo/SO5rynf7t0kcy7paQVvZnUZOG+gFJpveNJ/M67YHWI9cuB7hp3dQaqZjOvp1Tgkin/BcyvBi9EykEEYuMn9ENBMxULUjD1ZoUmbRbHAMPU21gWnF1rQF2NHHOMyHBnXeV0HeNF3yqCLcwElkKNkDo+G9rRGgzMRA9tF8Q+Iui2L/amVzsZQ/l1KBIRMPSBJqplB7/1S29+zGA6s3h6Rq+dksCTQX7VMQRSeonT8vOKVfwtO+GFbGUjAmq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVVE4wTqHJhARiEYEwn5RsPaurziEN4z/wtx3LnViPU=;
 b=Z8CYR1kLCQnrzFXcjR798a9Q1y6gt5CByEDKH/iXzOTYqnQzG0xlivi9+TgnAtIyahf9B/+gInLGkC2TgXnG39oI6qIwy8HsVET+94XqIFfSCrIUa6IQWf3fd+M7B1q5O9O9F54LzKYpSIdmIRqvgmq1OuTBitp359BhMm0W3VZ6N5Cs9AIPse8wBkAFR3fQc+19/IIJabr4Ftos/11500IJIL7r1gg/Vq7T6yuwbebHwl3bbPVVyAxFlKNT4FjDYvVpe4XC/YssrL4LLVlmzwxiGgIVwD8xcZiWXJO3NnNDGxs8Bb24MLTcURkwaR1xf4iW6TBuPaZNveujsGE+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVVE4wTqHJhARiEYEwn5RsPaurziEN4z/wtx3LnViPU=;
 b=FXsr3RA4jY2ebIU9qtGqIpmYXvau76mz5lgG3wn8lJNlqx0Umj0eSiZeKjgJ+YA3wqDrDX/yhb2XYRKzMD4JCxhphsWTvNty6WDLfXS6NeHhYg/2u/g5wy5QPRDDddvTlUPeHf7MSFKCdpEAqyS+YYVaOhnc/rorkRruSfe7UdY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5163.namprd10.prod.outlook.com (2603:10b6:610:dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.25; Wed, 31 Jan
 2024 15:32:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 15:32:15 +0000
Date: Wed, 31 Jan 2024 10:32:12 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] nfsd: don't call locks_release_private() twice
 concurrently
Message-ID: <Zbpn/DjauPliPh/t@tissot.1015granger.net>
References: <170666026049.21664.14325649754684255655@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170666026049.21664.14325649754684255655@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:610:e5::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: fd45e517-3473-4807-85f5-08dc2271cd38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o3Uz4McCONDLd8wLdCWdhGgM9MPD8Jg2aq4cso5F3KPhS0KtJDn+qDkb7vQwPkklwl8GlX/7peuOzZ+je9qDNtnVTLSkwazapL9gd9jOdzB5wyY08tInsgYSRr4j4ZsMVxrX2g6zRZ4SE639JPHYzKEU9Zxv0ARTMj1U4f1wlXJj537ddqqKxAd4MTqMteNAuv0m1MV2G8TUccLX9EQYYr9v6zmqTpOB2Rt2BHg2XVeSkoXPPHBRcpVXft5I1lUTBtPfSwutoW6ErTfikMMB3/3x1oI3cP+I8fJjkY44xu+lbygFrxvExf4rfMCRJD6JdGFOEUClLkO7uoUrWMukOcmVUpSzNwwSVCGIz7yaWWfwUhWosfwnGn/vYZ/uyLbwAvnIlvkltt5cMcS3cfR77I1kfBkN/ISsRYCAlS/BepkX36TzFcxboEHQIoupiAUbslqxttVtLzDVNEyGGD9L5CTfJR+CeNI1c3W2jYzgQ/t5/7se2jMYElw+Yuyx5YSpGsqAF8r3hEtZrWvM7vYCSTbacYDzLv8c+QJGChabpWKca5wrIv4Zdrpxq8mULjiS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(66946007)(4326008)(8676002)(8936002)(2906002)(5660300002)(44832011)(86362001)(54906003)(66476007)(316002)(66556008)(6916009)(38100700002)(6506007)(6512007)(9686003)(478600001)(6486002)(6666004)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZoqqsrL1nmRaE7PCuopC1QgZqzanHeJNiDhgZYp8zdM6h2hdoJm+zA1ZT+3W?=
 =?us-ascii?Q?QID4I3Ur44rchDpZX0Y26ixZZyhvVxmdP1lNE0dYDE0spTqU+LUavIyg8E31?=
 =?us-ascii?Q?MRdGopxtWrYAD0EzFbaftk3iNO427xncOst2MLO1reOif5vWG7p7PsWYFjBG?=
 =?us-ascii?Q?2OCr5un6W/WWGhih3Qpcwu0u+iXb+HdgPgh6JtoAA/hZsNASOD3NhxZh8W2I?=
 =?us-ascii?Q?45lQUrt+wZa1o+3qiIH7H3B0jxecherdFOnQ/duFtvc8EtNS7apRy8t3+6xy?=
 =?us-ascii?Q?8ZGf+eCGHL2Np6GMmzKQiqamHhhkKxngLU7mR4+B71PTb+KPQ8HtPw2MSv1m?=
 =?us-ascii?Q?nCcwWKHrxRtOy0szN3u6jPQP7GsNuqSb+Rb6QDZCOWwDPrGrlWz/558dq334?=
 =?us-ascii?Q?OXMhwZpZTfS6VZa95dZNzR4wc7eQmFKkFnt94eN4SNe1iszuOU8RhalIDd7j?=
 =?us-ascii?Q?3eYjO13nVqsq88r1SLe0VHWEAiSy57Mn3wZAP2Z4he2PyzgSHmkfKwrEd7TI?=
 =?us-ascii?Q?amSl/0oQe7vN8+28JpHjPa362pfDIMIM1j7WDmaICa3RMK2rphAkJNQKYVnd?=
 =?us-ascii?Q?49+sn2Rlh6Li4h6Sr6nKHhL5dcjIXtExio3BpEV4qcFFi1jz76fNbOooPoGS?=
 =?us-ascii?Q?l0ePahP8BvgEA8jnJ4sL/Twnf9FjbL++K8gW078tVtANk0iRuLDWsCwBeojw?=
 =?us-ascii?Q?sZNYtQcqkPsc8EiXNBVbWdXJp/bilEhJh4XWAamhUS9x+8+k4uVorACWteTo?=
 =?us-ascii?Q?swGoYLh08kKzMOcbd9ljTc9DeYgBGFEAnsAZJNtwM9Ds3PkeCDWIXQqhgeJL?=
 =?us-ascii?Q?skiIHsIikqqlpy+gBVZh9ejAzcfP1/7wgsCZqsxUVYJ5uv57NbPQVDofsBdz?=
 =?us-ascii?Q?EXtPqvvEwM8k+GB7efMSk4VRQp7h9hi2ebMpHBjFiB2jmbFjpFN1Dp3gCyZW?=
 =?us-ascii?Q?XEm7VDzi75KVT+0WZzc2wFDtMdFZTP80MdMW3feQR6luUl5wPD54rgfJCUng?=
 =?us-ascii?Q?CFWYrKc8z4lzKPHt0DnILxzlXOlyc6jzkZDcksEVwOoUAr1ZZlPdJsbvvTL5?=
 =?us-ascii?Q?TrdkjHJQyUMdp8wKFeGuwZ/pU312TQF7PxEBJXp1mJsuKggbj9Wxc/+JN3rU?=
 =?us-ascii?Q?D6goKqdGvF1ECUDG3zZr6IyUMqA1ORSR2Q+nzsYNeYsP77SWGOtZFrHgZM1O?=
 =?us-ascii?Q?+15zdOTyXH/QigpKfkude1bb94ddzb7tZTQtbfXyAcUckpnsnJSdcEZTkkFX?=
 =?us-ascii?Q?dMSJ4XRLYvwlYg9qYjRUz7ZhJWi+Th1bPY4w4M3rjVSYcvn6/TIdnHbmuyhO?=
 =?us-ascii?Q?nz4q0I+PUF2GGpswVQhRRDhtnkpsZ0ABF0Vg8u8ZE4hVdsVx3uYBK0wYCdUB?=
 =?us-ascii?Q?c/clWL2hryRindCgi1CFG+AXn40RDVsIYTW9kPSysioY3HW9hilJyvkidXeW?=
 =?us-ascii?Q?LmP0b5VKdNr+h+hhyE0CJieAWEYfAirJ0r8b1yvYJONwG/vzqg7hUU0zr6PM?=
 =?us-ascii?Q?tKS+KJlKrdhkOAMKXEh0eRSNzf0M40qoGdbeK1b5mq9fuxiBLao+PRQ+QoaH?=
 =?us-ascii?Q?/vNBucSXQpTT5dcLzDTKmYQhykTtrB6SU6QMZRJf0lwDFyHZrpT3J6Bbe9eW?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/4M7pE4hKYC0Ag9BK63Thy9la8CEQde0c4N40RuOEn8OsJdtXHQ9CgugCf08VMl3rjCUrsExEwfLDzivoNQR9YF7HPVzlq09TcJY1ka2GYe9/CjMSJhwktaFkZIm/ESCtwLoO6TnSooE4KHJ4wA5vG4IuJ9bP4tJ2guYG4t2V60wgfsVhrbAGKkVmstFJ9jUba3gggfhVHpsSXkr23DkOxJS+XSiasqmSpKdzaPPydTmmY4XHeJTFKH+BWE8No8BxAHyDK2HCt8Bx7rh1P0qG4yGi+S+ixL401/+nAlC1CBmKKp3p0CfYZ90G31KUUYD47slnpu3VT8fWo9jfVi+W+GLylw8XMpgVm3fZSZNZA7DClAnRTv3CjSGU2RV5+kCOZ9sToIpbcUYVx3/QVk7170doJemeEWKJkQxyj/CNPjBhXlLE8YGSf/jOI3DtALV+1r7I5+F1GMyaynPFVF34E91BgXKTOHn0Wh08JaUbhOR94ExQjRtli+YePcbH29Pu2bYFVxPLS2NZcCfrn+gzF/ByLrNkoMQOrdOLXEJ85aA4298GRiX3dbPUsGG5i4TRn/Xt6XsZF95eD/h2NEJJNebuYTe5kIWs+WVYdPr01Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd45e517-3473-4807-85f5-08dc2271cd38
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:32:15.1134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eD9bkDdp0Y3q9TBxy1xdQU3iJuxIHryjV9Qge7BY6ZcbYs5/6xcPO6aEDIIreAZ8pAwgJc92pKpUKWgaxQeLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=828 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310119
X-Proofpoint-ORIG-GUID: LaM7NIsUVrLrLjy6rhA7uHQ18JOcJgYm
X-Proofpoint-GUID: LaM7NIsUVrLrLjy6rhA7uHQ18JOcJgYm

On Wed, Jan 31, 2024 at 11:17:40AM +1100, NeilBrown wrote:
> 
> It is possible for free_blocked_lock() to be called twice concurrently,
> once from nfsd4_lock() and once from nfsd4_release_lockowner() calling
> remove_blocked_locks().  This is why a kref was added.
> 
> It is perfectly safe for locks_delete_block() and kref_put() to be
> called in parallel as they use locking or atomicity respectively as
> protection.  However locks_release_private() has no locking.  It is
> safe for it to be called twice sequentially, but not concurrently.
> 
> This patch moves that call from free_blocked_lock() where it could race
> with itself, to free_nbl() where it cannot.  This will slightly delay
> the freeing of private info or release of the owner - but not by much.
> It is arguably more natural for this freeing to happen in free_nbl()
> where the structure itself is freed.
> 
> This bug was found by code inspection - it has not been seen in practice.
> 
> Fixes: 47446d74f170 ("nfsd4: add refcount for nfsd4_blocked_lock")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a66d66b9f769..12534e12dbb3 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -318,6 +318,7 @@ free_nbl(struct kref *kref)
>  	struct nfsd4_blocked_lock *nbl;
>  
>  	nbl = container_of(kref, struct nfsd4_blocked_lock, nbl_kref);
> +	locks_release_private(&nbl->nbl_lock);
>  	kfree(nbl);
>  }
>  
> @@ -325,7 +326,6 @@ static void
>  free_blocked_lock(struct nfsd4_blocked_lock *nbl)
>  {
>  	locks_delete_block(&nbl->nbl_lock);
> -	locks_release_private(&nbl->nbl_lock);
>  	kref_put(&nbl->nbl_kref, free_nbl);
>  }
>  
> -- 
> 2.43.0

Applied to nfsd-next (for v6.9).


-- 
Chuck Lever

