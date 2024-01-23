Return-Path: <linux-nfs+bounces-1292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406148390CE
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 15:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E355B28DD3D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C63F5FB83;
	Tue, 23 Jan 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VdZdlV7V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C1jolX6N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48F15FB80
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018694; cv=fail; b=qNxi+RKbFsoPfKy349wTT27iGR3pipfQv0Qyzb9B/uPNZ2EnYZ/yJCwSsuAPSvftU9QZdkOpApoxX7lJT+7ullU1uRdIO22AhNus1vzo2GkK04l9ovjGJI4MTIRWwyELixe+7SIIvu/w0eB0Rvjtj0vLL0dcvWRgwr14jpTDb9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018694; c=relaxed/simple;
	bh=79Oa/K0dH7flAGdFzFRQ/by0mZnUs+kb7tc5obBREzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=agUyek1AStHU6jb1J8eDSC/qsmWDJFYCJsm/EmQPr40TXykHFqyIb6AMurWFZZLBs7czTVAtsZhobSfyqhKnG5bqHE3JBU24cWdP4NCdlJ04dpE73NfL07xZI7krTAJfsVnTIHJDrtn8kKjPt5+XEKlOSyNnYZ4YaM0b1+jO4oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VdZdlV7V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C1jolX6N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NE3uPO022551;
	Tue, 23 Jan 2024 14:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=YtoK7CjjjoeOnsOdVYUjLmEkkkCO5qsGUvI4Br2TY1c=;
 b=VdZdlV7Vl7c+vGMMWFbpKwIF9mCZ1BNxUH0u+dmQ1mDjiK4XPY2/OcdhrBFjikANgnTx
 gNm5xJphMNXAKwDqFhjhHC9H1afuftCFkbwOlNH1jct0ZrYM1lQLIKocKQwHQKh0oXW9
 FnV5hknxOuWNE4uU4CeNO1vGYsd9s2l6Q26Yojuo8lt0Wn6nkapVfsS7LQ06Ohkn0Vkx
 swn5M57FLtGL0UgL8k3FPLAn9kwvddtR+wsPkKUtKB8knjv7L+gR7oMDp3mXoMiQ5scX
 jT7/+Sdbth33qfdCEVDBrMSss6lBnKs8ewVNdSKIYn6Id79hOg0AQj+vB0oyOWesxDTv LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cxx7xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 14:04:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NDhDYX013091;
	Tue, 23 Jan 2024 14:04:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs370u4sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 14:04:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFP9zxt+5TlojW9DvHAstE6eOzlkrIX86AtrUcXspdGItsvFsapWK2ht0u5Ghb7Zuk/Zwnc1GXUkDjWI6/SflTzcBkmdM4GUsvH5WYc7EZAzAI0XCGD0/+gL+eBq+kGR0k0nK2avcHkjMKA6NVU6TnznTRH8dofTXsBL457kZ+H6AdhcZeI0YjJ530kkxyPGKREqgNOuEqVT49lz29bhF77EqxHgjRL6yv4H2Alb24w0h3vDUKTveAu+ctz5S5o53Hvi9+45rnhsN5v8ZfFJXI2yYA1RWH2SnOnRo4xTGk4RZCIodD9SvrbY3EFmFHKMtl7zMLmmGrZ+/tX6Fl2tyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtoK7CjjjoeOnsOdVYUjLmEkkkCO5qsGUvI4Br2TY1c=;
 b=lWUPPIDIDonwa0Kh5OHYZIVhunPAywkkra97E/gsF5gjy3TeiAaOrOKx03Gu+Z/H0YSvTFkZYfkdzQMbCcTCiHXESP3FzF/3y9DvKS4FJQsNwu07jZ3lvG2E5G3pkqP6kgdr4rq5Pc2ufQFIAzfaauhm9c998rswsf5TttjD4gYnM8R9ecLAymF/r3pA78B8PDBPt0xpDqN7YT8T9YP8aKzoYK3pysWgaz4tmVVFMcrx4a5AO1iPCS2iAe3GjK3kB1OZ5nxtfkBvhlivdlNNsY6/Tfwqwyd5SXwNcBaBysY4Paw9plxxsQxr2u6wtm1uH0jQlYDbE7yHaRqRRXYkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtoK7CjjjoeOnsOdVYUjLmEkkkCO5qsGUvI4Br2TY1c=;
 b=C1jolX6NfJ83q6EiIoESJ3b5B5aLfbXlxWYjCX1LNB0z93sPHBwvUOzqN1xBFGoIk7FWmTeVV3qU1RKcfzXygyK/DTIz7VyUolE72G0mFrwEQ2XgP1eA9ZREJ1m6Vl362REyeFYarA3jUnfDkgm+QsYcRU5nZ/npQXBB8m+KOO0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5718.namprd10.prod.outlook.com (2603:10b6:a03:3ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 14:04:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 14:04:36 +0000
Date: Tue, 23 Jan 2024 09:04:33 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, bcodding@redhat.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH  1/1] NFSv4.1: Assign the right value for initval and
 retries for rpc timeout
Message-ID: <Za/HcfyiuUi/Wpyf@tissot.1015granger.net>
References: <20240123053509.3592653-1-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123053509.3592653-1-samasth.norway.ananda@oracle.com>
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a775a9-7c71-40b2-1bff-08dc1c1c3b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EwwCE+l+gKXQrrX16sfS0tkHecQQLOxl3ZK0z+l8XGHBcfGbJL6qeRvI6/LxENMndEE65NFZ7b3kHwBsbzO0FSs7caJvl5kdbb1H4v+3soNxrLmjI7dGL1YxJUm4z7Wo6u5P5b2Of54UTJIghbH1kuPAcFHUqjMn+7eQDQKaXLWXOheB/gApH0zZVUo+V4E6on9ZZsThd4AOLkOQDYXbhmz4eO9FL2odjDwqkIMJxUaPO7hi/UiJ+QjO8cfvap73Uo+Vt0Ohg04NFXTUR7UDMrhd+9oUYV82JYwnAjXIQgd+YvuHI5+i3BexUxH4GJZjceegWmZ+aALMz3EdhsMxgsLuIx6jszOScWE7L7XK8AYvUXNwT1n7N2x7rPZ8uJvWa8zbjWs97Miv9ZNVaY6oD+N9TIDsFA99hl+RT7kdkVx9H8b3boNk245JGISNbcWqjWOPzDe42cj8gy2HyMfZHgbziCmHaThpIlSXRIIhAl8WI6SiuGgpuTk283Rubsu6P93tCSS+4BHrDIgeB1g2u1ZEaqFjwqxLr+rxJaI4YLYtbJ/s5Ix/nasnJToNtt2Z
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6506007)(66556008)(478600001)(6512007)(66946007)(66476007)(9686003)(6666004)(8936002)(8676002)(316002)(6486002)(26005)(83380400001)(2906002)(4326008)(5660300002)(6636002)(6862004)(44832011)(41300700001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7uU0f2HKiGy5c29+YG/A97tfNjI/+rapYBQ8q9g09KmlfpCTZHcOY0RSUY1l?=
 =?us-ascii?Q?+V0+dNBaalbHRgS1HWCgzfPVFI0BQ9Pu32uC0O0a2xzkeDRVQtBtFSibX8ZZ?=
 =?us-ascii?Q?ic2q02V7hUNVk6QX0TUzwrN1kaG7fd2vjQs51ZqvXrCZG4cquL1rfyzs5q1S?=
 =?us-ascii?Q?h8Qkb5cX52mTUAIZXXfETnVCVN+WbWAiIyLKg5zdEoaMobJv0iLTF/l5Cm5Y?=
 =?us-ascii?Q?Fh8GsAZNDYnyhpk1Nm7QB+jMhOI+bUhndquEe/rtzmB/hyTbN5VJstSfGA4y?=
 =?us-ascii?Q?Js39ufBW+AfnAyAFZ7H3+vQYQj+rl+SxG72tC5EryaUrItygkQ1TeaqxHVb6?=
 =?us-ascii?Q?XJlW18EAyH81gtOELWME6yVU2ki+6Fiy3KiSJ/rJP7BhBCVtckyEtD0Xi/u9?=
 =?us-ascii?Q?Bg4wCWKlsR8dUlh2P4Da0G9aoiX6mc77P3Q5qQoxIgI+icBbkkBiF+17y570?=
 =?us-ascii?Q?N5rD+/VgLTHy8CZEW9Yr7toCtDKywQhnGBvno6FweOXh0ybPbplORj5Q80FV?=
 =?us-ascii?Q?6T7g4qP33GIZpoBPwL6RFtTbBJMS3WHKTaOHdB7FsvsPAflsfM+AHrFx7B26?=
 =?us-ascii?Q?Na38gq0z+VB58Pf7zET2AdYQmM/yuNiLu+rT+nhWorGZOVS/suck5qb57oT7?=
 =?us-ascii?Q?zDpbna1GezJvJR2bnxZxpE+vFozQ5f4rinSJ/GCv9Ay2/fG00KZHYH5tf9qM?=
 =?us-ascii?Q?5eMRBbvGFH1nDKu74V9ENIeedoMZhV2eK7zzqWX2phtNUFhBZkRxvslO3jF6?=
 =?us-ascii?Q?fM5zrYXWGTri7aTBbWEPmWY6zWKQECpIw+0+1nWDpkexUEBqZYRD788Cxdy2?=
 =?us-ascii?Q?iyEFsalb3VW612dpsxb4A+CARokNfCCak8rjPLmiishDtObxNpHUbAbZPUlM?=
 =?us-ascii?Q?ZJlBdJLdHg3Wh6WI8V+JYpOVdt6Nnp1raqq4y7cqY26woIsIkat6wy9PYU6A?=
 =?us-ascii?Q?2PerG9Q+J+9gJLd9k3hOSYh4Q9MhmV4bTLF53r9s2nTuYGYZQH+OfB6eTCju?=
 =?us-ascii?Q?1r2sk6IK4R+qbMhWxdGzrYb8Q0BtRuoN04IEBv09hephXk/oe+jc4QzErB6f?=
 =?us-ascii?Q?wld0BcinvX85KysltKboD6jQmt+DvVT1We3hRYzeOYtMPiYSrQaZpeVIaoGQ?=
 =?us-ascii?Q?XaQqydXJsmmqb3Hm/gFpP15KwuckpTqYSCf2FJUtjWLrAhrXM4uvJc6Dh3Hs?=
 =?us-ascii?Q?jm77ulbdO2CuvMC791a5Smj8SOyWuobGiivxFG8AJRVzZ3MhoneTWgN9rEYg?=
 =?us-ascii?Q?9bYsjyTwduJ9ftE1QGb87M2/zJGXuMvMsySzVhw7GKNO+E2ygJzWraBRnyNI?=
 =?us-ascii?Q?vCBek6ZdLzyG7D/At/efw76Dsv7f/+9K0r6OFWUl3mNJAgLpen9w9dI6OWuE?=
 =?us-ascii?Q?0A1lqfrGECuagEMQh3AqNgc8jchh0g+5TNx4gNFMM6xne/M+vDhJ3t94OGA8?=
 =?us-ascii?Q?bDjo2at4gz4JBETBrmBMhR+tKA9ZG84BZiY1auzhm9HRBX9pmwjZfaTCD6ZH?=
 =?us-ascii?Q?2C09EFaHSCqq/R6P0PgdlTFG6HDZNahIzYNes+rtvgG0gSmu2941YaZv4yP6?=
 =?us-ascii?Q?v3FBGmW9+eoapcRLRXqLMDqFUkZfoCl95JLFspiAYWNrQkK4EXq0iKoc1aHt?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CYH6qmIAN1P6pooH2+OAzrK6+HxArpDpglNJBUVDwuPHW0RxBTSTN6RI2WOKbORPEnjKNjDpLyPdgWqBebZWzyZky1+/gQyXMFmDKSrOJwNHMIENRPveA8vgwoQetT6Z/tDkhSYmn+hXzOC1IugYS5A3p9B2Dr7qScjI2HtN5jN6AyW8vT+N7BqUbcDeUG/u/DiJ1QdEISuDxbAzF7N/ICg4ksP8jwqYkJtSxPotbzlEGeQvqGMqoZu8VqRlv2v/z5oKyAHURn0I+Yi5w5ef3nLeF7nTXSu2oFz3IzIt9yaF6wtPvH+LBpx+0lx+zZT0UF11jxOMbD/fQrAyWBV4moA2tnEQmMp4lPEoEzC2dTadRMFjGlvqEM8deTg1fZ4OcsiTGIdzcVaJr/tJpCKXMOo9I2/FegTmddUBcSlijSKIkkgIt4EKKTC2fKIxMxNto6NAIhigR0VBz9gA8K16x+tvK/cKe/f8DMd276AlsPD0UoqH2TYxllEu214nez64yfC9ZmrhzOJPM8SjWeLVTdBhN652ObgjMyrubL3rsVj3UOlo17haEzgNf96R0HLx9DhiknO0KpZLl1efMP7nZSOIYfrmJttQV7taJq+FgBs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a775a9-7c71-40b2-1bff-08dc1c1c3b5a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:04:36.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Fo/9NjEzmMuFYRXY+Q7YZlHR31Y21CW0xGYdVmD66sHS9DgP7CKEsCVEg1pt9MnFdkiSL6pFbioaUqBrRZpww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_06,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230103
X-Proofpoint-ORIG-GUID: lwDqivusEZ8TfDjEZnz3mT-RMYEGmAaR
X-Proofpoint-GUID: lwDqivusEZ8TfDjEZnz3mT-RMYEGmAaR

On Mon, Jan 22, 2024 at 09:35:09PM -0800, Samasth Norway Ananda wrote:
> Make sure the rpc timeout was assigned with the correct value for
> initial timeout and max number of retries.
> 
> Fixes: 57331a59ac0d ("NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  net/sunrpc/svc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index f60c93e5a25d..b969e505c7b7 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1598,10 +1598,10 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
>  	/* Finally, send the reply synchronously */
>  	if (rqstp->bc_to_initval > 0) {
>  		timeout.to_initval = rqstp->bc_to_initval;
> -		timeout.to_retries = rqstp->bc_to_initval;
> +		timeout.to_retries = rqstp->bc_to_retries;
>  	} else {
>  		timeout.to_initval = req->rq_xprt->timeout->to_initval;
> -		timeout.to_initval = req->rq_xprt->timeout->to_retries;
> +		timeout.to_retries = req->rq_xprt->timeout->to_retries;
>  	}
>  	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
>  	task = rpc_run_bc_task(req, &timeout);
> -- 
> 2.42.0
> 
> 

-- 
Chuck Lever

