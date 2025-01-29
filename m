Return-Path: <linux-nfs+bounces-9758-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E979A21FFE
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 16:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653B0188599C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198E18F2EA;
	Wed, 29 Jan 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VThQzFw1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ukFR3DRY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681DA4C83;
	Wed, 29 Jan 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738163374; cv=fail; b=j9ra1jGANPmP0jcKMV9RD2C4vKQTsFzq+ArVBksnkHe89FD/s0V6PVckIpycyaDQc+bGqPQSfyDcH2nu6j6MWMT7jnYVPoo8Jy8I/MT2Sh/PoMuuerTGzC82YsZAhTgNBF5tNhu9OKev7qN4fCDdjc6GjWEjQuKHpgs9GqNkTok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738163374; c=relaxed/simple;
	bh=N9/pRSI6jZzHi9mIhNRKDiuQw7NaiYlEUMs37wZLR18=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mCF9A1nJY5+4I26izUKbJgahL1mPGI0dJSRQyFkQNRYg089UpFzQUFZQQwkCCA1kieGwfbCnVx3MBid1MmLy7tXj2Je7EgY1I8prsKJDWX2zrBmgzD1bpbmnDeE64OtSTvqxHR45kx1YfYJDlXrIl1/2TeUDdlpIjO3KW6ACou4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VThQzFw1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ukFR3DRY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEbAHm007542;
	Wed, 29 Jan 2025 15:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vOSY46E2dryMuIgwBAm4aF+FkDc35cBJn1AGArj9lus=; b=
	VThQzFw1JDs/dXsI/XFpaQJ14lxbdz6Orq4pUfLGgK5W7BDqOHxv9JyQ6SvJKQQK
	/sAsaL6sZ7Gd5hxPp6hsAhz3pSTmqwtfb2f2yL3gixbqqLgwuMqVhAYc60iyNO0t
	3tQRe+m57q3PzYG4Kglu8bGIK5PbHHxxTm9wMm9jxXXd7dHROxIQTVDurS4KnP9u
	NbfQEE8RpiiYBjgtQB9VrTeFywKnx1V3xAxZ7/LnHAZDb4RvfaIJ9Vu0EZgJJi8B
	YBvwiG7t9BNE3mmnQde7q1XwgId5aT+6Nz+RaHDJL3sxui9nTyN1iEXz1gN/T+XC
	wjSRvWdUYSKJNobinD+VYQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fp8e030s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:09:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TE4Nfm035852;
	Wed, 29 Jan 2025 15:09:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdfvjq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyydFR0866a3s9nbJTi61Qt9kCKBb5HVsm0GYM5cbyg4AiF7g/dq33M8kMz44fBNPHE3yELApr8t0LqZIcJ2RqeAfPoywrqtKAaNmOX/Zevdi0RkkCiW4nf1Q9p73g1yH5sUAGhd5YUHBzyvo+Asgv/BLB3A2bvNmQlVvPF2FbP6HwwkFo+DbApJ3tnFATe015jVAX7wLg/0cZUDkwPpkhB5k7KUXvifjoaQJJC/YWhK6ORWlzSsel2OVjpKQbeoKDnOtuFhgj7uHbzItZG/RAG1NzbEN/tUyrr6TihZm8wWlF0eRSVtP7YFEQlbBaTS3C58kMAiaEZWps/eojmowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOSY46E2dryMuIgwBAm4aF+FkDc35cBJn1AGArj9lus=;
 b=iIsb32z/6rOXz7eIpQ7UQ9BKmBo3SRmVtxd6SGmVnigi0KgZYiKrQn+fgXvUenS/gCZKGFUVug42vDeXyEksWaxa9aSn5DJnDsaM1iThKsEdkU2tGGkLHPAvpwqy0sySLBUDVcm5bQNdo0wgLex3C/XadEOSJtHUlszQ3v0RXHMcGBo5q2tjVLJqQNPwOQcxpUmGg5OFBuvCo8n3L+eqDme0FUIqJB7Owx7rnC843B/Dcd3++pPYygYxkTeGlytuIzgANUeuPdPt+pp63ZWD+N+Hy8jjdO/CdKNjuJhZDMYbeHYRgdfCwGgHLAf6QFGBQM4KDRxjntmvdfv2wdBCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOSY46E2dryMuIgwBAm4aF+FkDc35cBJn1AGArj9lus=;
 b=ukFR3DRYYJGWPZgNYeZt4elKWLFa9vtu3H+H39CxyN6wZUajBsBKHmwpEY5jV6LXWhKUVi+T5kakWKOj452Y7gXa0Inxn5pU23gOfzU5jev1xzDgnRCtL0AxhxO9LUsseXXmhwdj7Kb3Fa9TzobrfzmC84oo+U0/86vNYuuB8K0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 15:09:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 15:09:16 +0000
Message-ID: <91515715-5804-4e94-ae19-67aaaf36e3d3@oracle.com>
Date: Wed, 29 Jan 2025 10:09:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] nfsd: CB_SEQUENCE error handling fixes and
 cleanups
To: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
 <Z5o5ZBaYgrmrNseU@poldevia.fieldses.org>
 <5760673a9adc597c1b235dd6a1670ed801d2feb1.camel@kernel.org>
 <Z5o93QZJ35z8Zkyh@poldevia.fieldses.org>
 <0722b556a8b01ca4f99e5d3ac5285efc666d69ec.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0722b556a8b01ca4f99e5d3ac5285efc666d69ec.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:610:20::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ab74bf-b118-40e5-81f6-08dd4076e5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajFGU05Bd3o5OTkvaFNRUXk2ZU5SWlY0R21DeFFtajkvR2lCVHAzeHVrREE2?=
 =?utf-8?B?eEdHN0srbzlrQS9zQWc3VHlPR2R4MDl6aUtXaVpwdzQ0QTE3TlNnK2tqbkc3?=
 =?utf-8?B?dGw2ZXh6anNNbE40ampQVkpha293SFNkeDJhNkx0K1lUVjRSRkdLZTBmQklo?=
 =?utf-8?B?dVJ0dDNLTlpXVS84M1lRK25YMlA3QUxYRVlsWnBuYTlKRDUyeVF2UE9ZcTNx?=
 =?utf-8?B?YWwzemd4RWUzd1lKcDNiZWZoOHltU29DOUpmeXJQWUlyL1h1TElmZ25yWjJ0?=
 =?utf-8?B?S3c4QXZ4SW51RmZoRVdFVjBDa25HN0c3aXFGOVN3N1E2ZE84aVV2TkJsZldP?=
 =?utf-8?B?VENDSDJnZFgwQkUyUDdoaEpUalJHSEtRK2tBd2JKR2hJcHdOYVZtZ2xodHRT?=
 =?utf-8?B?Y1dqVlQrVzRSU001WG1OVGtpMDBTajNYbVdLMUgybVJ4dmFQNWpmempKYUxk?=
 =?utf-8?B?SFFqMlBIVWxMRVVVMjExMFBBV1NIeHAyS3haVEk0YjI4ZXFwUG5YdnlaOXFk?=
 =?utf-8?B?VFVDWUUwbFRIbXpYWjZVLzRlVWJpL3JBZ2ZCZ1E5dXNxNmJORGg5di9XY0ln?=
 =?utf-8?B?TUY0UmlRTVJ5bEpLNTBaRFJ4ZEdGV2ptVW8vbDZrc2M3R3dieEtCbi9rQ3lC?=
 =?utf-8?B?dWMwa1dOSUJlTEk2ZUpwNmVKVGZDTTBJaHRMTERTZkR1ZnN1VERJUmJJVEFL?=
 =?utf-8?B?THNwSlN5c3o4clRpZms2VEQwaGhqeDV3VWlYMjQybW1aNHJvM041QzNVa2xB?=
 =?utf-8?B?TWMzVGpRZzJoS0lqM0ZYWW1ubjhDSnRMZGtTeDhDOFZqeGtOMSt6aC9KVng3?=
 =?utf-8?B?aVFwUWdPMWEyRGViSlBFcU1oZXA4S3hWYnhIaG1KTFF3TGhkR3VUdXVSNlBF?=
 =?utf-8?B?bDExdWhoVmYyU0NaYTRRbkg1SDUrU093R3FrRlF6M2JqdzYvQ2pwTlZPK3Vj?=
 =?utf-8?B?dWFxRXBpc2FtMXhXbk5EWHVYRUdZcEZDdkd3dzE0NFN3WTdGSXdPSjVGTDJi?=
 =?utf-8?B?OHFHRkNMN3ZkYVp3S01sWlpTenQySVM5ZmZPdVJnNEVVQUg5RzBjVUV1anFR?=
 =?utf-8?B?Nk5rT3g3cFp0RWhvMjB1RVpCK2VMT2t1UDBwcXE0L0l0TzZ3Z2g1OS9ncDBY?=
 =?utf-8?B?QmZrcHYwUjdvY1k5MGlqMVI0RTZSQU9RSFlkblByZktmQXIvbWd0bHFjSGR1?=
 =?utf-8?B?TEN0VkRQaFJjMWpxVHpEK1M4SVJPcDZFci94bmNhME56SzR1NzhtL01Remph?=
 =?utf-8?B?TEw5U1dJZXB3VWYwSGNiY2FmdEdPVXF4WUU5MTc1Y1NudG1GZHJnMksrRys2?=
 =?utf-8?B?NVVENXZqbEpNR3E4NERuSmRFK0pMbG92SXVSRFEwOGNpS1FMTlUzTzZLMFlJ?=
 =?utf-8?B?RDBITGtlSjJKMGNIbUc5ZXRRK3hKS3Y3clA1ZVhhdjNOU2JQUHN5ZDBzMnU0?=
 =?utf-8?B?bmJlajFzWUFWS0RZd1A0MkIzN25ERnRQRnkvL0U5dnJmWG9mYVRZRnRqMW0v?=
 =?utf-8?B?aWZpQk5ON05nU0xMSW5KUU9ycE9vRmQ4UW4wd0NkbnB5RjBIMXptV0xmZTIr?=
 =?utf-8?B?SXJCT1BGazc1RzBuZ2YvRHk2Z3dKS051SVlpa0NuOFBWYkg0REY1dzE3ZSts?=
 =?utf-8?B?TWFkVE9zZm9wQys2dWlxTEJMbXdoNnhtVG5sWU5PSHphVkJzQjZwRmc0Zk5a?=
 =?utf-8?B?em5RUVVvYktocU14Tm11TDkxSmJaZm5aOFUvYmlDVHpwTXNYdmtkcThpNXZU?=
 =?utf-8?B?ZGJEUjNhNDN5TkVFT3h6Q0x3T2o4VHh5SDh5STlFY1k5VUQvYkgwRVBMSzNt?=
 =?utf-8?B?d0x3NWowRmV4T1RPajF3cEpud2J1ZTZpV2RMNVZVUldPcXZGZHZhWTdZVEZ6?=
 =?utf-8?Q?Dk+l7etEsx0nd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnZUTnM5c0F5dHp5Z2c3Q2NDMXdCWHhFM0ZFc2xuV1JFaDI3WkxCK0cvcC9E?=
 =?utf-8?B?YnFoTGRjY1RnNkVjQ2RocmhUWHBmeWZ0R2xuTXBoYXYrUk1JRlQvd1lzaDln?=
 =?utf-8?B?TXhLckFTdEwyT0lSaW1GSTl0bTNONGhGTkI3bFdBR1dwQzRYTTBISE14eS8z?=
 =?utf-8?B?M0dYYkQrcnV4cjd4YzRUc3doZ1dYbU9VdWxtbjlkNys0UlZTem01MVpST0VZ?=
 =?utf-8?B?cXBZTklWOWdDcHRmeldXTmZHeHk3cHBlZkVnLzJ3SWxLeW5lcFl5Wm9BeGRv?=
 =?utf-8?B?QmF0alF3dnVkT2pnUmhnV3NwYWtsa1dsUW1nTnllNm5jU0NScmRyUWhIdUJS?=
 =?utf-8?B?cXBHVEZmaUVwaXRNcXJUVk13akQ2S3VQZFRRS2ZIdXZYRnVJK3VLa2Y1OHdu?=
 =?utf-8?B?QVEzMkpTMllFcFNTejg5bWNhbzYxU2RFRXhOMFhIU3poK2tGY28ySTNWNzdW?=
 =?utf-8?B?U0E1ZVllS2ZxeEcvOEdWQnd6eFUwanRid0wxd0tPOStOV3E3OEJ6bXltemJM?=
 =?utf-8?B?cStEQkVmKzgrbHlGWFRydkJlSXlTa0RaMGcySDhnWTVPc1hFUURvUnpQcTJK?=
 =?utf-8?B?ZkVJK1JzajNMSC9rRjVQMWlvemVQbW0zR3FFMUNVa0VQbnlMc1FLTUNQejdK?=
 =?utf-8?B?Q2pScEFmS3F3MWdNY1JFWW1GQTZjTWxOeVFua1AwWXZmV0pBZFczZGc1TmNv?=
 =?utf-8?B?VTNuNXAvZ1hvdlIrK1ArSlBzYWdaeUZka05RZm16di9TQVRjSlNmKytaQTNR?=
 =?utf-8?B?S2tVOGs3Mmw3QmhDT2ZnR0F6MEwxUVlVZ3cyb2pyNUlwWG4zVUR4b0hlZUo5?=
 =?utf-8?B?cGNaZERWVStGN3JreFZmUm85TExnU2xiRTBWZ1pvYXl3c25UZWtJNWhtc0NN?=
 =?utf-8?B?NzRxYVMyOG1MK3RBbnlYMEo3RGlSbWd2ZUNiQ3ZkVTgzZTdqdTQvcWNmOWdJ?=
 =?utf-8?B?bUovSWUrQmhIdG44Y2YrSVhaTlBQdHRTbVc3OHJ6bElmVjlzQkExTlVCbmpw?=
 =?utf-8?B?bjVqOEVRdEQwaVZWcnd6dDNvTThTbGFybjlGZTdDVUVWck1RdHFlN2wvckpw?=
 =?utf-8?B?V1pXQVptMVNITVNDYnFMMUdQb3c5MzQ4Q0toc0Y4OUFZUTNEcEsraUFFN2FI?=
 =?utf-8?B?aE94U2U2dHdGcC8zNlR3RUEwQnVHRUVEbzlsQVFHTEVjTG5UVDZTM1pWbnRn?=
 =?utf-8?B?WWdrZmVydkd1VHBhKzhKbXJlaHN2bnd6ZXJmMXlqN0pnbWlBcTV2eE9PNGVJ?=
 =?utf-8?B?bklST1ZhNUNLZHlqOUI2REtNT0tPSkZ0VzlzcFVNMnBFVEJZNHZWbzcwK1kv?=
 =?utf-8?B?Z0I5TCtTTFd0QWFKRElZZlB0ZEtSd3NYVTVQSXRZT1g1UEdhbHRlSitNakxM?=
 =?utf-8?B?VVczZy9nelFDcUcwazB1SUVySk1LWnhJSHlOT1NweHVTeEFDWm0wdWlPcEdN?=
 =?utf-8?B?TVdESjRIREdReFRiT1d5OGNzR0dzQ3doWkRwZllhQzY2SThMTzRXUlZiRGJy?=
 =?utf-8?B?ZEtCb3hOeEJUSDFvZkpXa21HdGxxU3ZGbEM4M0ZuRi9oZ0pEZVBvVXNNbzg4?=
 =?utf-8?B?eURic2pPUkwzZHNkNzRSSUg4MTNSUEV0bnVWbHNBL2NkS0hBVnFQUG5qditv?=
 =?utf-8?B?c0ZXVWZSMkhFclZLalVodFVnWDl6aWk2a1dNa3gwQlhMZnp6UmxIUG5hUm5Q?=
 =?utf-8?B?eS8wem1wKzJHRzQ0Z3hxSGx5WDlraTZQaGk5eEo0TkdjOXpjbjJpWUJyVDQw?=
 =?utf-8?B?T01idWdXSGVpQlI3Sld6Z3Y5N05ZWlFJUm5zNXlZU0NyOE5mOXdPK1lWQk9R?=
 =?utf-8?B?R3hVeG9HZy9FT2svWmd1bFZUZjNROUora0lMTG9qWElJendFTkdFTkxRcGhL?=
 =?utf-8?B?cTZCbHhsWCtpMFMzcjYvVWtnOXJiaTRQZStzWkZBcXdiaWRHRWFQa25OVk1E?=
 =?utf-8?B?WllHTC9ZWVF5VE56ZjVMOE1RNXZTaWRqRWFUSEZyR1pvQUI4WUJ0ZGVMa0Nt?=
 =?utf-8?B?eWxqQlB0OWZMQW13RVdTbW5GMm5mdXAvM2sxbkNPcjlYTHhMQXZhWVBneVFz?=
 =?utf-8?B?aVVEZ1ZDblg5OHgxTGVLVzhwQS9YbE52WTAvUmRiK0NHeTJHSUNZSklYSThl?=
 =?utf-8?B?TkhkMGh0Nk8wMHhzemJuWjl2cG9ENUl1VkZ6clNDNTdVSzlwR3FFczFEeGFT?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0CNu7cw0hTT6U37Mt4dgHQYP1d39JGayA0H/IX0CeTwg4ABEPXJbQJpK+K73Yfh1Ys/Xv/PgjL06xW0wICk8rPTKjtaV7yjVkGM+PHybqK0Isc1+Wa+wrvPbF2lJqgYcZzGMI0U9CX4cVBWLpYE+f8zShAa9j+sbCcgL3TPzFczyu/RNhpD6hEXtlmOKL/m2D37RycBrSY2vD/G6o75LhEg6u9Fwg5kTE8OxOyUisI1D1tlv95QP57t7nfWV3mh6+NTEGHhoFEz6m5ZMj7THiEr8JqRWS/HubCMzUoJz6iRjgMNr3e4+PneXGQq+UfYLNuHOvc39Z2LulGHNNM3e3HiRzJ2uiXZriHT+XsIWG/5s0vgVciMOBaQbH7ecm/xeAImCt2/99fgjnWQ4InEIMSDg8IU2IC+vDpkMsGX3Li3cOabjTtpGeKyESjeJlBoEN7D7/DJt6JZXkiivOBd+1UFIF1qCRQPBPi64jBF05SZQHCrBds/L3jaAFLE3mTHJyqUYK24c/VBtmb62wjexpAZTGIbkscsAtg0wTR9gJ62qgEd/ok/SVhSoKwfWyuGPamoYX8J1jnRmObLWbn/Go521svDyZUKBv2pr6tT+I7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ab74bf-b118-40e5-81f6-08dd4076e5eb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:09:16.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAyYwy+Y+sAGj6JTSQJnaIov4HroP5/QQiafgDupRvDBBwLtF8sWZuF3yjZZlwfk73cQFEy2AKTebhrMG2xPKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290122
X-Proofpoint-ORIG-GUID: LydnHemLFg4x71p0B-H-zcMLbsTr1zCU
X-Proofpoint-GUID: LydnHemLFg4x71p0B-H-zcMLbsTr1zCU

On 1/29/25 10:01 AM, Jeff Layton wrote:
> On Wed, 2025-01-29 at 09:40 -0500, J. Bruce Fields wrote:
>> On Wed, Jan 29, 2025 at 09:27:02AM -0500, Jeff Layton wrote:
>>> On Wed, 2025-01-29 at 09:21 -0500, J. Bruce Fields wrote:
>>>> On Wed, Jan 29, 2025 at 08:39:53AM -0500, Jeff Layton wrote:
>>>>> While looking over the CB_SEQUENCE error handling, I discovered that
>>>>> callbacks don't hold a reference to a session, and the
>>>>> clp->cl_cb_session could easily change between request and response.
>>>>> If that happens at an inopportune time, there could be UAFs or weird
>>>>> slot/sequence handling problems.
>>>>
>>>> Nobody should place too much faith in my understanding of how any of
>>>> this works at this point, but....  My vague memory is that a lot of
>>>> things are serialized simply by being run only on the cl_callback_wq.
>>>> Modifying clp->cl_cb_session is such a thing.
>>>
>>> It is, but that doesn't save us here. The workqueue is just there to
>>> submit jobs to the RPC client. Once that happens they are run via
>>> rpciod's workqueue (and in parallel with one another since they're
>>> async RPC calls).
>>>
>>> So, it's possible that while we're waiting for a response from one
>>> callback, another is submitted, and that workqueue job changes the
>>> clp->cl_cb_session.
>>
>> I think it calls rpc_shutdown_client() before changing
>> clp->cl_cb_session.
>>
> 
> It does, but the cl_cb_session doesn't carry a reference. My worry was
> that the client could call a DESTROY_SESSION at any time.
> 
> Now that I look though, you may be right that that's enough to ensure
> it because nfsd4_destroy_session() calls nfsd4_probe_callback_sync()
> before putting the session reference.
> 
> Still, that is a lot of reliance on these things happening in a
> particular order.
> 
>> (Though I'm not sure whether rpc_shutdown_client guarantees that all rpc
>> processing for the client is completed before returning?)
>>
> 
> FWIW, it does wait for them to be killed:
> 
>          while (!list_empty(&clnt->cl_tasks)) {
>                  rpc_killall_tasks(clnt);
>                  wait_event_timeout(destroy_wait,
>                          list_empty(&clnt->cl_tasks), 1*HZ);
>          }
> 
> I'm not crazy about the fact that it does that synchronously in the
> workqueue job, but I guess not much else can be happening with
> callbacks until this completes.

Bruce, note rpc_shutdown_client() can block indefinitely due to
bugs in NFSD's callback completion handlers. That's one of the
main reasons this is getting attention right not.


>>>>> This series changes the nfsd4_session to be RCU-freed, and then adds a
>>>>> new method of session refcounting that is compatible with the old.
>>>>> nfsd4_callback RPCs will now hold a lightweight reference to the session
>>>>> in addition to the slot. Then, all of the callback handling is switched
>>>>> to use that session instead of dereferencing clp->cb_cb_session.
>>>>> I've also reworked the error handling in nfsd4_cb_sequence_done()
>>>>> based on review comments, and lifted the v4.0 handing out of that
>>>>> function.
>>>>>
>>>>> This passes pynfs, nfstests, and fstests for me, but I'm not sure how
>>>>> much any of that stresses the backchannel's error handling.
>>>>>
>>>>> These should probably go in via Chuck's tree, but the last patch touches
>>>>> some NFS cnd sunrpc client code, so it'd be good to have R-b's or A-b's
>>>>> from Trond and/or Anna on that one.
>>>>>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>> Changes in v2:
>>>>> - make nfsd4_session be RCU-freed
>>>>> - change code to keep reference to session over callback RPCs
>>>>> - rework error handling in nfsd4_cb_sequence_done()
>>>>> - move NFSv4.0 handling out of nfsd4_cb_sequence_done()
>>>>> - Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org
>>>>>
>>>>> ---
>>>>> Jeff Layton (7):
>>>>>        nfsd: add routines to get/put session references for callbacks
>>>>>        nfsd: make clp->cl_cb_session be an RCU managed pointer
>>>>>        nfsd: add a cb_ses pointer to nfsd4_callback and use it instead of clp->cb_cb_session
>>>>>        nfsd: overhaul CB_SEQUENCE error handling
>>>>>        nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
>>>>>        nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
>>>>>        sunrpc: make rpc_restart_call() and rpc_restart_call_prepare() void return
>>>>>
>>>>>   fs/nfs/nfs4proc.c           |  12 ++-
>>>>>   fs/nfsd/nfs4callback.c      | 212 ++++++++++++++++++++++++++++++++------------
>>>>>   fs/nfsd/nfs4state.c         |  43 ++++++++-
>>>>>   fs/nfsd/state.h             |   6 +-
>>>>>   fs/nfsd/trace.h             |   6 +-
>>>>>   include/linux/sunrpc/clnt.h |   4 +-
>>>>>   net/sunrpc/clnt.c           |   7 +-
>>>>>   7 files changed, 210 insertions(+), 80 deletions(-)
>>>>> ---
>>>>> base-commit: a05af3c6103b703d1d38d8180b3ebbe0a03c2f07
>>>>> change-id: 20250123-nfsd-6-14-b0797e385dc0
>>>>>
>>>>> Best regards,
>>>>> -- 
>>>>> Jeff Layton <jlayton@kernel.org>
>>>
>>> -- 
>>> Jeff Layton <jlayton@kernel.org>
> 


-- 
Chuck Lever

