Return-Path: <linux-nfs+bounces-1962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C128568BD
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 17:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345FB1F27EDC
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 16:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3B91350E6;
	Thu, 15 Feb 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i/s8rGhD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U1aOU6K0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999031350E3
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012995; cv=fail; b=AZWCtJKjnhtIpHpPhtGBaWGbwgk+vqNWNx9flwTdg/Q6gyE4ClFvzQlesX7NwojDuY+fwPe7FbpCVo5Wa32ta/IQ+snKANxoZGKrZ4eygiGiZLbJW9kJcnB9eZUf8V9+etyVP9OvpqGh8H3W+Gopin1D8xySHrus2mT/69DKNIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012995; c=relaxed/simple;
	bh=aQsJ1xKzqXNRv1EnZEQ7JiuRUDMEBBth71joKf8BWo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZaawbZILgzZPfScaNY6JTIXs73GZv/KxFD4ySNETPpy7g46mY/VBNXz4ixTQsIPv5RWgmAMBkKREFJsmP/JY8ROr9utG2Io6acBZM5yPKtPD5xtVbz1beiDbwyyxdePjCTefOjwPVO5LBRxL4nwX8nUvpcEAxclK0mUuvSAnVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i/s8rGhD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U1aOU6K0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFT4Zg022498;
	Thu, 15 Feb 2024 16:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=4iO4ung/3WIvGVBBMfHYlpHpUnfm6QqsC/kyvcdcTXw=;
 b=i/s8rGhDmN9096bB7jpXbKdkCN9NqUoUBK68kspnUuLo23up6Ethe+GZ0duu99kJ8v9E
 2/f2eEvBbu0BKhHbheBwbxKsouVf1WcQe5ZOJ/r4ljn04cGf0CxRbgTjT/m5MgD8qYak
 5rw6CoeBs9F2joNHRTunSAwRDwhJIRirc+YdVInari0SH6yK/p8U4v8DtPDzQ5eDPpMu
 g/H2UKGqtLtQ/om9DIh3PRct91G8PDn8nUlxR7ksVM6E0/TXS2AwhrkdoB1WR35pgK6m
 njcLQMlY0/ykYOlAlBKhjtB7fVTYTAKKAZEjsiR+jRU79TZ7vg0mRoCt5hbLxG3GMKC3 +Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db2kdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 16:03:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FEgOCf031478;
	Thu, 15 Feb 2024 16:03:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykaq43r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 16:03:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnj76Y5kD0XXB+cAYwSB4yeOeDatqPgm08b13fhy7P2VBcnP+9YGICm0LBQtbgdMg7N13h95Pw2z4o3DV9FPUtRKdJxado8VQBgIv126EWa8UDxccIqAxe14I5sk5CUzqNs4AY0pP3vLyYgFx6e3UIS5AiQm6u4yJvc2WbObahwQRCBYtjs8c/Flr7eKKXN76gcHVhzcbFZRqCdw1juxyPPcBTUYAEjecOZQpSpaGJ6dIs7AnJxE4/a3ZA/hLI0YK44GrY933riro84UDqpe0rCby8xQMYQpF9KSaIBBvt8CdUeo1KJq2S+x1Yo182lJSp3ZjKksIacVys+BwQNfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iO4ung/3WIvGVBBMfHYlpHpUnfm6QqsC/kyvcdcTXw=;
 b=ii3n16u74aBhUSt0+G3hyLakmgolcYf5+t7tfXF0qCLPxbrP6rGCFZ/FfXkqNrYsDBORFwaKPBeroP+vZeENQZo8JRnqBvm1lHGZtUbJQRaj+ik8wvxYiMCsQ3ljN8kbUV4hPSmtSsTPD9dCnfUe9FLXxhmEyPZnFlqWXL4mJ9nPeIHNxpEu4dXWNu08RRtI4yPD129xIb7S1HxvJcWx+FoqRGZWVUW+9t8eD3dRAY1TIcuwcmvBy9MIJn3Rg7JF7Q+XtWC5RuoYI2ObMSpLvX15r+MD7Guw1eLDjoGFwu5p8Sm7a3goXFOZ5wxR87c+KEqBKLMny+2G5OQ5167Byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iO4ung/3WIvGVBBMfHYlpHpUnfm6QqsC/kyvcdcTXw=;
 b=U1aOU6K0JnMJN6PknPk0kEtb73x2lBKB6iyApvK6CDPFHwz97LxgPHnXV6D1Fl4KiCLYF0l7URGNvxewd1Rn0lOnZbNCCdFihW578K4DxzsZGrzJwNJBlLpTDKt2wuWfwEgDsmAEM3QgUKWblWVe//cp2JkVlnJRAlhlIi1y6c8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6459.namprd10.prod.outlook.com (2603:10b6:510:1ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 15 Feb
 2024 16:02:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 16:02:57 +0000
Date: Thu, 15 Feb 2024 11:02:54 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: "trondmy@kernel.org" <trondmy@kernel.org>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
Message-ID: <Zc41ru02fZ7SSPNU@tissot.1015granger.net>
References: <20240214223501.205822-1-trondmy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214223501.205822-1-trondmy@kernel.org>
X-ClientProxiedBy: CH0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:610:e7::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: a202af45-32a4-4b3e-c4b9-08dc2e3f9391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BDiGy8TmDCDVVKynCRPsoH8dWzGBgYgfBaFL87/e8Xu+Z7p/mFJHcGxYH99XIhwqaa+Lfry4E4dKVWQzve/hLwaWsD6Zrkw4GvSHBZMDmHgDvx5/+RQ7iH2KKIcfkDohg2m7TEq2e7slx7nmEi/QeFijAiBwKaKwkK/sjgbUGEebcl+JDZcZwLgGJzLLgr3rkGWgHfXJZ49qpD4j+vWlU71ZH8Rg8OX8v0NclgIkHdaXwHl7W1UWAGCUW157gIY24fSw4GNXy0gcSZO7LVuTGIdb0hrEhDWD7mkR9iAiflPm44pBURUmcfYx1O5iRwvvrmB0pI8QEqiaVU62rW+XHu5ohHlaHIwf2GqjRlzmeFy69rBR1b/7ChBs1hAD+DUG2PlDiYW4WXUtAp8M6o85kdvaelWZ+3vR/Ek8hPHDFbZlEHlyrVeF3UlIVMBGS0h6F3p1jzAbBJ2Pql29kzVEL53KBraEt+tYuhry1cBnJD2LLx98MXTpE6Yw2k7cHl2hQm67PemaXkf24xu0mOWpKBeu8QzbIz0C/MC056YNe1GeXzYhRaS9pd8LcRQesq9k
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(6506007)(8936002)(86362001)(6916009)(6486002)(478600001)(6666004)(8676002)(2906002)(44832011)(26005)(38100700002)(83380400001)(6512007)(9686003)(66476007)(316002)(4326008)(66556008)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oEenL/jboGbVZviFqOuy9zcDkMt6ulDNejlYQtLTgvZovje1Nv50Soq+AM1O?=
 =?us-ascii?Q?Se81s7KNzOv99B8J9CFHRJBM3WnLnUY3GUIb22qWkhkedxVyOWc1U/nWWPCR?=
 =?us-ascii?Q?H1KppiQRpEZD/MPLtIixfKmMnvnla4WxtlaRSU/JINoSiBOYvZYDOS0pp7zg?=
 =?us-ascii?Q?OeVixcSMwO6RGhsknwKxqSGp1Dnv06Hf+W+ePgpzC/8dlzonB7P8DBF/1Ssn?=
 =?us-ascii?Q?549ovfANDCdlj1fs9O1bmZ3MGRMwRpYOi+PIpcc/jmvTkqSWICD4dpSP9S6m?=
 =?us-ascii?Q?TUB/rjhwNv+G/HMm0o+pAgeWd12CDanvqjhFbdO/nKy0Zt8PntCaTGAOJsqZ?=
 =?us-ascii?Q?I8wCS2uelt2NPz0UEKV9JPKF/gwWUdbGCXB38Q4/D9SI/xnUh0L1pc6deakK?=
 =?us-ascii?Q?RL+8fhzf4H0br6tJ+PWOqHHmlmoi4tAnFG42YHoACnIIWBbAuKzRXCgZmv0F?=
 =?us-ascii?Q?5nrERO3FH/+SytF14zoa35n1BLQ5YKsr4uKX7TjoclvDcBEJ47dGGJfTsou1?=
 =?us-ascii?Q?8ppREGL1ke6+fQo5B5M+lfxqwVApEAThtJcUYFG55vWNk02x+mIpY+5xYoVs?=
 =?us-ascii?Q?6ZwhXm5VfZ2p13CkRo8Cd5CFK+coHGSVX5KZ454/JJpeeRqs0MhvwN2nMvdK?=
 =?us-ascii?Q?I6DS9gVTRvYac9hRwCgENb5MKzQP1g1hD86EdEuJDDeKEyERLsNKzvcquYxT?=
 =?us-ascii?Q?L8w1uQwabnMPJwDv1YbV3HEn7DOnDWG8+wAdQlufM1U4aiK2P238hrAHu5AQ?=
 =?us-ascii?Q?PVoj5TVNFrxdY+V0OCmNpcALei3WbI+fdF+P+fYLpMDRzz1N1J7vSBKf7OJO?=
 =?us-ascii?Q?vzXg3a9M+0KdTmZ42fGXPDky9TM1mtgKt3xHlh4Jw9X4ASVrD5GD+bcFEWvx?=
 =?us-ascii?Q?s5I92ScI36rGwj3SbqgOCqPcRZszx6ADob3ml09bp/gAYOVgoD+aBURn1XXX?=
 =?us-ascii?Q?iE/8/q3/Ukwy4DQkDsO5Vdt3sTbp9xATE5ZaGixuF8IuEJUlOE6bhSGLbSJ2?=
 =?us-ascii?Q?Hd5BtyGICbjDwiz28oBdAjZzXhxKt1XdXCo3Mli/fIReQ9h1vjOW0eEyApQ8?=
 =?us-ascii?Q?3Qai5ZTEJ5uJLmZleHeImI3yCmQMU+yWguJWA42XOu1SSWIPzBj14+S400Qm?=
 =?us-ascii?Q?Yts3hvucCrdwBMoglo3Qp2It1Kcrfqs2WuZsgKl9Os249U22GKTeek/bkPfY?=
 =?us-ascii?Q?hkUJieFN100h7sIOrU8Iz1lAdwxf0hiGXyTZsSE6WnSVciW8viG/POyERsYt?=
 =?us-ascii?Q?4/YhLB2G2Wv7TVBLEmIkDuO9ds38mWRbhZBc6GDmrn5FTOuuHmrIzaZkY1sD?=
 =?us-ascii?Q?xaZITGDMRS3UegqQMZjrL3yYpqhmOe5yaCd/DnObll0k67ZnTgAg6uOh+q+I?=
 =?us-ascii?Q?c89DNURhSuop9MYvcL3GKvlbl1CFy4Pz3gFHVIDIAHYf90Nb+Jt/02Z4cOF+?=
 =?us-ascii?Q?nvJiYCH2m/ivYM0wJ8+Tq524QeuQyCupAsopzIL9Ka/ri0O0kZQTJ4ShLMpi?=
 =?us-ascii?Q?fOpPHocua6MNkSkbI4eXKxdw8F0U8ttE27emlTKawjHrzlaF8KmTM6k7mfVd?=
 =?us-ascii?Q?LGQADiEHbx7tFtSyHadE1gxfVvWkqkjwluBdL7r5lF7sJy96JyTVVNY3ObYJ?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ch431kak9mK5j8mMPpTyZ/NflkaTyHogTQgljxIqcBWL8whyuiMEh/77tPij9ksaMdxYFj+vTylvlE3jUvfNf0UOjD8quP6jNhBO+9Fiu8OILu0410ERyYpyLl342SJMfsCkEfEYhYV4MZDVo/Y/jUYMLwh8YEvux6/pzC8MgSldgCB6ePZ4mKIYyLGVL7yYcSmVAW8DEI12BwWogf5Dx7f73IEi5ei5Fl1PmAv2P/YxyrHxHu9ahvjRlyru6QuXcxRIHSda2LjXhH61sFRFT9esyOtN/pdamyw7e43qziPq9I5x+FXY8gwQRzloPzVH6+rfvZ4gxQzQf02IvWi1AxcLWWc95PdLqGz5LYIT9I+m5N0masS7GElEdnH002HMOiDa3Papav1bPSGsdec9MnOjnVhTGA/r5qtsrY8I4P/I/8TA7qDaiQOM920bgW3Al3sSHxN6DnDJYvMHVdilslCgS51dPRPHrdfSqNycyx4iUvnY9evkjlzjWFFfK46QukDnB7gZ+bqDmc6VUbZO97AtrgY9fwFFkolBrlTTNT2dm7HD/xzP3jQEdDiaXlqaE4ZXMxzgkQ38SXne6OVOQmJWmQjQXAwqd1qrqwQN+Nw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a202af45-32a4-4b3e-c4b9-08dc2e3f9391
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 16:02:57.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhdHHUQvbPfIqFMB2oqY1yfp7rzumqHsS877a4MpFudVryUxcgFPBdHAT9TYIV49b+zvQR0Fk/RR9mEJ6gwGBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=812 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150128
X-Proofpoint-GUID: VBbEBAQ3cQLxQOYlOZzDrXxK_SlasVi0
X-Proofpoint-ORIG-GUID: VBbEBAQ3cQLxQOYlOZzDrXxK_SlasVi0

On Wed, Feb 14, 2024 at 05:35:01PM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The main point of the guarded SETATTR is to prevent races with other
> WRITE and SETATTR calls. That requires that the check of the guard time
> against the inode ctime be done after taking the inode lock.
> 
> Furthermore, we need to take into account the 32-bit nature of
> timestamps in NFSv3, and the possibility that files may change at a
> faster rate than once a second.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

LGTM! Applied to nfsd-next.

I'm open to suggestion for Fixes: / Cc: stable tags, but for now 
I'm leaving those off.


> ---
>  fs/nfsd/nfs3proc.c  |  6 ++++--
>  fs/nfsd/nfs3xdr.c   |  5 +----
>  fs/nfsd/nfs4proc.c  |  3 +--
>  fs/nfsd/nfs4state.c |  2 +-
>  fs/nfsd/nfsproc.c   |  6 +++---
>  fs/nfsd/vfs.c       | 20 +++++++++++++-------
>  fs/nfsd/vfs.h       |  2 +-
>  fs/nfsd/xdr3.h      |  2 +-
>  8 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b78eceebd945..dfcc957e460d 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -71,13 +71,15 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
>  	struct nfsd_attrs attrs = {
>  		.na_iattr	= &argp->attrs,
>  	};
> +	const struct timespec64 *guardtime = NULL;
>  
>  	dprintk("nfsd: SETATTR(3)  %s\n",
>  				SVCFH_fmt(&argp->fh));
>  
>  	fh_copy(&resp->fh, &argp->fh);
> -	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs,
> -				    argp->check_guard, argp->guardtime);
> +	if (argp->check_guard)
> +		guardtime = &argp->guardtime;
> +	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs, guardtime);
>  	return rpc_success;
>  }
>  
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index f32128955ec8..a7a07470c1f8 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -295,17 +295,14 @@ svcxdr_decode_sattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  static bool
>  svcxdr_decode_sattrguard3(struct xdr_stream *xdr, struct nfsd3_sattrargs *args)
>  {
> -	__be32 *p;
>  	u32 check;
>  
>  	if (xdr_stream_decode_bool(xdr, &check) < 0)
>  		return false;
>  	if (check) {
> -		p = xdr_inline_decode(xdr, XDR_UNIT * 2);
> -		if (!p)
> +		if (!svcxdr_decode_nfstime3(xdr, &args->guardtime))
>  			return false;
>  		args->check_guard = 1;
> -		args->guardtime = be32_to_cpup(p);
>  	} else
>  		args->check_guard = 0;
>  
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 14712fa08f76..0294f5cce5dd 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1168,8 +1168,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	if (status)
>  		goto out;
> -	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
> -				0, (time64_t)0);
> +	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
>  	if (!status)
>  		status = nfserrno(attrs.na_labelerr);
>  	if (!status)
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2fa54cfd4882..538edd85b51e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5191,7 +5191,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>  		return 0;
>  	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
>  		return nfserr_inval;
> -	return nfsd_setattr(rqstp, fh, &attrs, 0, (time64_t)0);
> +	return nfsd_setattr(rqstp, fh, &attrs, NULL);
>  }
>  
>  static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index a7315928a760..36370b957b63 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -103,7 +103,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
>  		}
>  	}
>  
> -	resp->status = nfsd_setattr(rqstp, fhp, &attrs, 0, (time64_t)0);
> +	resp->status = nfsd_setattr(rqstp, fhp, &attrs, NULL);
>  	if (resp->status != nfs_ok)
>  		goto out;
>  
> @@ -390,8 +390,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		 */
>  		attr->ia_valid &= ATTR_SIZE;
>  		if (attr->ia_valid)
> -			resp->status = nfsd_setattr(rqstp, newfhp, &attrs, 0,
> -						    (time64_t)0);
> +			resp->status = nfsd_setattr(rqstp, newfhp, &attrs,
> +						    NULL);
>  	}
>  
>  out_unlock:
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 6e7e37192461..cc17eb8633ea 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -476,7 +476,6 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
>   * @rqstp: controlling RPC transaction
>   * @fhp: filehandle of target
>   * @attr: attributes to set
> - * @check_guard: set to 1 if guardtime is a valid timestamp
>   * @guardtime: do not act if ctime.tv_sec does not match this timestamp
>   *
>   * This call may adjust the contents of @attr (in particular, this
> @@ -488,8 +487,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
>   */
>  __be32
>  nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -	     struct nfsd_attrs *attr,
> -	     int check_guard, time64_t guardtime)
> +	     struct nfsd_attrs *attr, const struct timespec64 *guardtime)
>  {
>  	struct dentry	*dentry;
>  	struct inode	*inode;
> @@ -538,9 +536,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	nfsd_sanitize_attrs(inode, iap);
>  
> -	if (check_guard && guardtime != inode_get_ctime_sec(inode))
> -		return nfserr_notsync;
> -
>  	/*
>  	 * The size case is special, it changes the file in addition to the
>  	 * attributes, and file systems don't expect it to be mixed with
> @@ -555,6 +550,17 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	}
>  
>  	inode_lock(inode);
> +	if (guardtime) {
> +		struct timespec64 ctime = inode_get_ctime(inode);
> +		if ((u32)guardtime->tv_sec != (u32)ctime.tv_sec ||
> +		    guardtime->tv_nsec != ctime.tv_nsec) {
> +			inode_unlock(inode);
> +			if (size_change)
> +				put_write_access(inode);
> +			return nfserr_notsync;
> +		}
> +	}
> +
>  	for (retries = 1;;) {
>  		struct iattr attrs;
>  
> @@ -1404,7 +1410,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	 * if the attributes have not changed.
>  	 */
>  	if (iap->ia_valid)
> -		status = nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
> +		status = nfsd_setattr(rqstp, resfhp, attrs, NULL);
>  	else
>  		status = nfserrno(commit_metadata(resfhp));
>  
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 702fbc4483bf..7d77303ef5f7 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -69,7 +69,7 @@ __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
>  				const char *, unsigned int,
>  				struct svc_export **, struct dentry **);
>  __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
> -				struct nfsd_attrs *, int, time64_t);
> +			     struct nfsd_attrs *, const struct timespec64 *);
>  int nfsd_mountpoint(struct dentry *, struct svc_export *);
>  #ifdef CONFIG_NFSD_V4
>  __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
> index 03fe4e21306c..522067b7fd75 100644
> --- a/fs/nfsd/xdr3.h
> +++ b/fs/nfsd/xdr3.h
> @@ -14,7 +14,7 @@ struct nfsd3_sattrargs {
>  	struct svc_fh		fh;
>  	struct iattr		attrs;
>  	int			check_guard;
> -	time64_t		guardtime;
> +	struct timespec64	guardtime;
>  };
>  
>  struct nfsd3_diropargs {
> -- 
> 2.43.0
> 

-- 
Chuck Lever

