Return-Path: <linux-nfs+bounces-2735-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E57F89E17B
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 19:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D7F1C2104F
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D9155745;
	Tue,  9 Apr 2024 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RP5ZAuS4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KRsRUzmA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90515539C
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683506; cv=fail; b=NHOFqTakDeMP3jEcbHScctQYjaniNXyGf5oPK09ZpY4sCVHZ14D982j+JCdEaQ30ar6rScRL3aCfIrFscin6F+pLQbeyg6uCp3pWK1AkHhCt042BwF7Ve6y4KfCG7e16cfAgfQh/dvJDXfSlZLnYkiAvkJDAy43ry8FHKYy3Klc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683506; c=relaxed/simple;
	bh=WHLghnwEvKSZ0STpd8SKVqKcjac0One21B2DM1q0ljE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DIXVrUa0o6GbfjPtXssQz9QqACT5wVOA79NTjvf7s03T2mpymaV7PKCcd1pOYi0SUe8pjBBeHeyAPl6fUhMfrFbVJ1Xkt/Wz3O0KigZqn3m9xg3VIK08inGaFTQVCrraN79u0UfkSvhMPBaGq+Uf5ZesK0ICDZZdkaimfendBpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RP5ZAuS4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KRsRUzmA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYsfj004421;
	Tue, 9 Apr 2024 17:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=2W73BsNL0y5fsdEblG7trH5WzjzD7SCIyqi5uhU18wI=;
 b=RP5ZAuS4IaNuYxssGB9KZPXGwcN1h5QxcIazBPhm4cYd+jZMvU9/iC3uwP8WQnRcycKS
 X9Srh77Zz7NEVOBPPec/FoIcmkkY5c89XuhnvBvlWPNRp9Vpir/htEgCLbfOlZzGcw2a
 vhXdhr/Rno6sl5n/0eA/EnZYA9lIjpVj/gWZEuqpCDEkftNTBQCRdB/mydRuP8VZJsx1
 s1SbRjI/e50ZPHIZfBH0YhcXlWrvx0OW8MNRkXUfbLbfWxtgvIaky80wJEJR7C5kMjJi
 G1lmsEMpxOWIwrVlE7bGG3n1IDRYsctKjBQORzspGyTfG+BaR5XxRAkVOehi/JIYYm5g 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvdhpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 17:24:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439GTZEJ010569;
	Tue, 9 Apr 2024 17:24:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu71eu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 17:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNehmypl3BOz7mFqNJdkj2fAC442i5yUD7LNjIH9vLDdU4Lta4qkZP0g1sIclgFGAYKyzI9o1S/UDSv4LPwa1L+3JWWqRj0DYdVak9TEm0fDJF44Kx7XeduyXbZBWZSted2fVkBwaW+XF8vQoMUWrfIUBRg7F5zYJ4BUqgw3wvPolGeNVW46Jp+aL6sbCejjLz4RqDkRY9L5tcKhGNWvNkG0YDCV/dytN8/EIgYAX5gllNYQ61d0uc/Oyq+DB9c9dTdGrkgfEMLMVA46an5538zoIdHpqq3v7BGH0q6kgMoaKak7pyNbqqm/C/R6sOne1BeF0PeHJg92CWvYkxo2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W73BsNL0y5fsdEblG7trH5WzjzD7SCIyqi5uhU18wI=;
 b=XmGms8O9bIGyN0++vunWvYA1iqC6xnBL0AsW9B+cDrw72YvbU3P/gU0PYgsIFY9YzcosBC7kBWWsd2QNCYANht54SBTZnNWs9GTgMyiWK3Ia2LuRmu0qlpIjkV0R2cbkhmJy6XQ7fBTt9u2KDD2d6dwaI/UStKAaiJph4ppZYB5NBDR79i6VfKkA3xTsut3i/NLkmijOv6NPevxA8dAfwD4Eaod45aHnRnT3XJ8Lll5Lvbcxhk9YqLdSWrlDPElj7QSvYXlG16OQzgn16WLkoM+36JRoCWSbGkokzagO1PidCsWmSAUVqW6A0Li7DuBHwFX6EHpGR3jccikwcuVjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W73BsNL0y5fsdEblG7trH5WzjzD7SCIyqi5uhU18wI=;
 b=KRsRUzmA//YqqG7wh+P3HJlfG+77UmktcDCx79Iv1PHOJV+aVAjZwmzpa6QUgnssDO5jDaLCbbU8YcgRnwwnnP8O0o+4eF3TdVGGyRYMY7R5xaUE7rTvj0t4fh7UX2S8Wm6EyRoNvdR/cIVJ7Rfvy3j0RkPFQsrsoL/6x2zLkyA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5884.namprd10.prod.outlook.com (2603:10b6:303:180::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 17:24:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 17:24:54 +0000
Date: Tue, 9 Apr 2024 13:24:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Steve Dickson <steved@redhat.com>
Cc: Matt Turner <mattst88@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs-utils' .service files not usable with nfsv4-server.service
Message-ID: <ZhV55Pbv7DqhaNMs@tissot.1015granger.net>
References: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
 <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
 <CAEdQ38FOP0_g0FK5DYz954OwfJjLUf2pjQL1CX=VNC60kd8HEw@mail.gmail.com>
 <50d1fcab-ba94-405e-896a-5bbae128998b@redhat.com>
 <3138D81C-EAD9-41CD-A32D-DEA4AA002CEE@oracle.com>
 <1521cdb1-db67-4e7e-9dc2-c463d9df53fd@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521cdb1-db67-4e7e-9dc2-c463d9df53fd@redhat.com>
X-ClientProxiedBy: CH0PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:610:77::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5884:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gvXv8pPvvfloEk5IgDJ4xUTC3UJLN5lA7P7PMKIinOU6suWmkBfmfNC46TvlEBex1Ai7Cn/+R/cgr+vVp/WzwYYnppUwTGoLtJrdvu7Jk2VCTuemUv5VpeTYlYoQHnuQCJPZfTjM1h7tHZOhwg1cDHwrwCLZmJORUrtWMllU81q6cmPrJwsP99B4eaYlsNfP5D1hxTdfTbaxJKH74+UjoLpAI6X28zOdXcYGFslprSNddMJq6xLWtmhjMX0L8MxeZCFjqPMMsbtix2trIEBoIrX0t39WojWqpSLyNhQO6gcT7+2PzZKb4N/0nC+i4fPi8FMjTIeBGK7b6mLg0juC9ARga+ElCbXCer6JODFKTIvLC2PAqSCOpf8IXyCmP4E4CHm2dKoWDktK2K7GcTLc73bmDYEKKLp3dD73mPJYdIadYGHxSLL7PnzbUByBKktKVlU57Bd/UeY0kLb6lGUmw31x91tN/c6gV9OE6b+Do/9INkvzU/IK1tmy4ut6Bm3L5J9IAmWZRemPBOkrSGlLWuY4tm3n1cC3BMP7zey4nmp/M0SMqXhfc45eyjcaaGwYk7jvYZlz3JetOVvq//wgNtkUY+su+skpTTU9o918vMO8KJ49y4TO9VQbzkkE8olmK00NZ4AqIOkOjsVidKBCfpQcseiuFxjGk7hg+QtKPko=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zc1nadgGBbt+js+X5OhkbzB6Voxa9paxpLpObES0DgJAmPt7jGJFCwJahSB/?=
 =?us-ascii?Q?/Yk+P8XDpV/YJrASXBUt1ny2ELp/HgqTAYFgd1Ot2qAtDeRAEwW21Wy7LgON?=
 =?us-ascii?Q?Js2mrHxxj5CTWomasrj6JfPEDFlFDkvp746NZ29wWCH6u1oMM6KsuuwbywZl?=
 =?us-ascii?Q?UlERFb+J4+HLqzRpU6Q1yVjZZnb415GsYnB5uiDRzYxhpcye6txmhrYnpLDE?=
 =?us-ascii?Q?nmUoxi3t5J4wmHosqm9ri80yurws7nwte6m4NNyRObPqeZzVxU7WzPxrF65y?=
 =?us-ascii?Q?moUI+iLWi9i/wdAFOwLdT4QIZACo8SAhEvt7MPaS+QUASBJcCZKDZpXob+VY?=
 =?us-ascii?Q?laGEDlD0OqjcGm6ZjBFCliR02Ru9hrJrTIgNlXf9PIuxT9lmjnT42cXxFHKs?=
 =?us-ascii?Q?VkJrQ6Z7s1mjGPc13nvaYa1bDC3nWe775SOqld+JB9VuafyO2twSHMqElF4E?=
 =?us-ascii?Q?8Q2KgILYoiffNHJ0ClMGfGFZ+AAULKE5sNUsfmUxuBR95PPwZlL7SdUb4PXL?=
 =?us-ascii?Q?SGiovBbB8+iUa0G2WNrRAOL1j6J6z5mtpvQhFfdbnuYyq7vUetCMPpttzSBw?=
 =?us-ascii?Q?yUrt6yYxdorQt6LjVFQzjCtdK//Iphf0IissIAycpvC+Fj2xyi1hGHcBXUbK?=
 =?us-ascii?Q?jQlBXqwuoxlrCyJOaVQ2xerCDUA3PD44frsEQdvSPeNAQ+IH/IVriy/uFsaN?=
 =?us-ascii?Q?6elwKrhQIwXT/fPpLX0Sp4KJpy9IKOIl6XXsxWp9NpfHc2NcehBrWFJP+lkp?=
 =?us-ascii?Q?mtPAFYeiYvw30iMSQZLYq25JyNP9KCxelX6cXiWTyrcWijFOLGg9hGKryxHP?=
 =?us-ascii?Q?i/jL7FMZX3Uh6sWGtm9WgZ736+uWLt/6kv76Yg4SsGoMhiBLcqz14vcW0gId?=
 =?us-ascii?Q?vJFVxJwjqRih9NB0BKVGXjkRoejMi3vYQly4Qsl5M6nQ7nDEBEytPUUDBPHb?=
 =?us-ascii?Q?THCInGdetmJeeOKhqhWVUS50EPLTeJbIokWDXZsAu9XuTqvFYrz6tIVQDgU6?=
 =?us-ascii?Q?Aa+BQR/Y62aRASLtWjE9OtV0q3ns6pgSkX8q1VuCo7G667VN3poNWdIcLRoK?=
 =?us-ascii?Q?AHnp5igpQG9sQuxboKa2lK8Kp4HauyWaVHouYh1FnsVnfI+8vTRQORzYRTdT?=
 =?us-ascii?Q?jY5KzJReXrs/Hx0zkHaGAUY8g2GB4377kTMtXJgQCD19+DWfq/FLMDY3fhpp?=
 =?us-ascii?Q?yccFi7hSb0ubZ7x9JSApqwevCC3nFspAymBVKp3kx4kBqhb+pDBoNy1gAfPG?=
 =?us-ascii?Q?a6kaU92HVYS8p1Y3O5MsGfltwTZXyZO/8KGnF8hKrs9lYQ4xjHyUgKg7yVdG?=
 =?us-ascii?Q?8r7CO63/4Z3iLvBTfVL4MU8/75bHAPc7ZMdL/nCog4AGsRwwndI78mNc7omu?=
 =?us-ascii?Q?jQ5BKaAQ35pW18IA2ucdf24mpaAR1daU/2amj/pULuaUx0H6GZ740zftAxsa?=
 =?us-ascii?Q?PrAKneIqT+0ngQ8h7Imkf25EIlWhfuhc9TRH7Tp2kMHbES1TaCo+uI6jdHSZ?=
 =?us-ascii?Q?Sc6oWeEcK+t3wVMDpZ13dbgWkloM5Hpa5oTMbkXXtrTgiOIp59a+aELCHElZ?=
 =?us-ascii?Q?f4KITVQWb1yLcYxoUv7EoYZSEx1R5OUV/8FrXOUwbM7x5uSUXQgE9V+akMVW?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J/CynuoQf0wRBwS/kQVYKlniAomsCAx2c/v5UVznNLJOHDhMlIcENUVccKDw/2G2mOQ7TsDbNX7BSs/FC6n3woDgGXMlIprxuLKVtbTWErmP84yHeMQRBZ4QtwdiKLE8bkAsNfhVOqqUSrB7FRn5uaFvpvozjICODdtJITg1/EHo6R4Q9vSNb1ncqSjrheBBOK9GGAWA9V2qFujn8TOKKg2s2g5l/dp1cDbWCo3zq+EfFAPQu3XkX/Gw24DjzYDqb58+cGjhOl0RY+HUfcb0Wc+7kvavjem/r7IEP+Hzj0yhp0ZU43sscwqQBO/zi5NHcpphuaB6MihNSgq1IdQOfSvaeooiTxJzXpdLOzMYWkl8znX/TeAMAU0WsuuVE26YvnjlGMB2a/1Kg+9Y21E1kKNlfSV2LLcnVBTkRZ4nEZDBwXD+PNRiL5IoCHLtA/cNRedQQgqFy2n2SQRJdRmsO6I37C+RIgLl91pCuhfUu9eDruKgWVHrU6irzG222uFqE0Lmi2In4PeeCMYL3LT8LvSZcdvOb8UltfsE1XxqJUMOQXFWF7ew3gfmuk3ZpnQcJFODh72/hJEnGGwJ7S4gpWCDPBM6korsEYAyljJzvzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30824afc-fc43-47a2-b623-08dc58b9f8d1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 17:24:54.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFYqw+CXjVxPoq+0QGY2tY17pokaRhV5DZURfcoz9N8l+LVAAF5aDEjXeR/rpw7b53rDRFlZ8Gvb8X6POpgokw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090114
X-Proofpoint-ORIG-GUID: FXTe4esh9Zfa-k3keJ0IcBTFXNxdn71a
X-Proofpoint-GUID: FXTe4esh9Zfa-k3keJ0IcBTFXNxdn71a

On Sun, Apr 07, 2024 at 02:36:44PM -0400, Steve Dickson wrote:
> On 4/7/24 12:29 PM, Chuck Lever III wrote:
> > The nfs-server unit should be made to do the right thing
> > no matter what is installed on the system and no matter what
> > is in /etc/nfs.conf. I don't see why screwing with the
> > distro packaging is needed?
> nfs-server.service and nfsv4-server.service were never
> meant to be compatible... One or the other... Maybe
> that was the mistake.

I remember being uncomfortable with the addition of a second
"NFS server" unit. If the logic to disable the NFSv3
components when not in use can fit into nfs-server.service,
that would be a better solution, IMO.

-- 
Chuck Lever

