Return-Path: <linux-nfs+bounces-12131-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 699F8ACF156
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA9B1702F9
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF31A272E54;
	Thu,  5 Jun 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KgUHcFSu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="loPAsSYO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593D221278
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131685; cv=fail; b=g9Q9n18u3t/udvi3WcaDrXFejuxDBAkHsIeZEvXWrZi16qkqRrsBssP1AU/UJ78xUVrwPiba9qetIiNru+C8BJFfXtewuBoGFz0j9JgIIADFZ7gwbrd05SZFmfjHS7ucPLYHhAjZoU9m4hwXmxZ9XoP7O5WjvV8sqVP7avWL564=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131685; c=relaxed/simple;
	bh=uOk+hkhatBTtXVsHjxLKYz1d3PQsN22YuAQ4pTUZZz4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o407VSOa11nchzwYSdjIv/YHSlEmAER0s8oJTkw6yEa/r2yRZcC42+kP+H6I5F+oA239CIM7305M4G1svR1nnJakxI1AkHPzUGgNqj8lgToLJekG/DmFu42Jt9Kn2hn1LU8EyhiAzxrMKvqoOnCsJV51JkoDupKdPB7KLv6Rshg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KgUHcFSu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=loPAsSYO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555AtWhO007465
	for <linux-nfs@vger.kernel.org>; Thu, 5 Jun 2025 13:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WELSuI9WxBVTUFVdNINyKJLrh9v7Vd2iavCnbnsfLvQ=; b=
	KgUHcFSuN5bIINYz1hP8eaEtIZ02Iackg5Xd357HXtwJP1Y3kUjWj1FqW2Wgj8h+
	/IZwW616wmp+y+SsrkBFJMgnIuiBcArBNtWYjyk9QuVuQNIOqsti1DvL3fIwnsyp
	YcgAvAxF6D3i/vhrZHIy/QMrvA8rV3H8Euo8jmkYckITdoQrJpQtDddOWG0Opouy
	lzvx0UQdPmBjCyGEmkFe1uYT28V8KGLCjpjTDyJdzmyX1KXqYIH1KYnekLsQqwtP
	ivduQAPENS0gP/z1tOQi3ScncIQtVqcUJO9BxEl1960BG8HnAeyDi7QzjzzPt4D5
	C6g9DWstYeOnTaYdXM2Czw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8bp4mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Thu, 05 Jun 2025 13:54:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555DALnI030620
	for <linux-nfs@vger.kernel.org>; Thu, 5 Jun 2025 13:54:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7c3rkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Thu, 05 Jun 2025 13:54:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwyghLmQalHBFfgGjNvDAfhIJlhAvLAfcQmcMziu4hqjaWgWVOl1A/SJbcpUncGkfUbJ5UfSzCafgoK9zvDRSzxI3BB0kkbPfqkmE+/mN73UE1Rz86XoHp2zM7/x5Qv2uO3zPYCI96lEWOc7tsTa0DVgx6l2VtfEFnhs4Bh98DJIdfOHqcYxt+wSSZnam3MlWnbsc6Wqd/XrQt7gOTNQWly6Holau4FG+QEFtt4trw80+4WxHFpvmcgkcVk+3HZG8iw6XoQ3hFtsKlrk+sgJJwY+G8XeNr952dKEcWazaIq+sXsj2yKgD70EBlkRwu72zqSpuiBs7ZI+tC/D0zL8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WELSuI9WxBVTUFVdNINyKJLrh9v7Vd2iavCnbnsfLvQ=;
 b=tUaQYZoUWzJZReIaSqkaXMLvd+ofTear4rDWRlCHGAHloeL9dezxI2Eqvd1glK8m3KEOhewu+vNT7FNgCwBXpX5IAm7IEY3c6ny8Xp5uaXFUHEe4GyiGsveHou8eqcdiTfSTRJNcIPJaUgv9VNsGQDjI124HPKEA0aePaVgG3paArZMNO1mvwIn/iouh2FtuAZoEd5i0AH0fxy4PPZ5Q/swbXnERK8H4aHuefRc3sx1YXWkImwWNcYKs//U+yCnIYLOOLYuwzaBwTw6OGx0rA4XWTzZv/LmlPswvPI2+fqxZoCNXXIaiAr+rZtFiE4uJmjzd//CDzaf7yphYfGa8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WELSuI9WxBVTUFVdNINyKJLrh9v7Vd2iavCnbnsfLvQ=;
 b=loPAsSYOEU4bZej8uAeFl/k6wkyN+vyd/hMowYV8dydk1tbhTxyxTd5ZFLPwgenBzT+YAgIUDBFr7vmxh4bnFTCf7nQln/hQNaOuT7sVWkb7VI7LHG9EPrcWNuts4wh9785rwxxgBLP2pShqMMMkt21/I6DETx7JpJUfp1tYxfY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB7021.namprd10.prod.outlook.com (2603:10b6:806:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 5 Jun
 2025 13:54:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 13:54:39 +0000
Message-ID: <930b2858-fd06-49f0-8896-f2aafdd3e047@oracle.com>
Date: Thu, 5 Jun 2025 09:54:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: linux-nfs@vger.kernel.org
References: <20250513-master-v1-1-e845fe412715@kernel.org>
 <7bbb789d-b3ae-4258-bebf-40ed87587576@redhat.com>
 <16285c94bc3498fb7a612f62e718ae8a53c42c3c.camel@kernel.org>
 <CALXu0UcDcsUWKkSfuvE6E6GZ0qiR=-=QaQ5QFz+kgZ6oT2e0Mg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALXu0UcDcsUWKkSfuvE6E6GZ0qiR=-=QaQ5QFz+kgZ6oT2e0Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: fb841a0a-a587-44fb-bb43-08dda4388377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlhEWE9NclJPeFdhRDRkeHJSZWhxQzUraWtybGVuaXJmai8zQjhXUkxDbXp6?=
 =?utf-8?B?OXZTUHpNVzAxd0V5d3lHR2NnTmdrcXFkNjBpdHc1cytxRHdwVkJGQzZvcWRR?=
 =?utf-8?B?eDFmK0YvVGhxQXZhSFgwRTFGQ21zRlVNVGNTZ2Fqcko2dFFYYnpLaDVDSkFv?=
 =?utf-8?B?OUpUM2VJWlV4S1BBMURqa2V3NHlUekdaRHV4MGRTRzRQb0IwZkJEanphOXlt?=
 =?utf-8?B?MUdNNGR5dVRrNDZIeHJCd2NTM1FCK1JKOXdhS21CdFFTZHN4VTdDbWFQKytm?=
 =?utf-8?B?QUxNMnhsYnNEOUdwckdGc3hyRmZKTk1KR2ZmMGR4VlVlUlc5K1BvWmNSOVNk?=
 =?utf-8?B?M3ZlRGN3MENDNkpwd25nbFZFRHV0Qyt5V3NVRTk4WmtvODJ3SE5CUytRbkFZ?=
 =?utf-8?B?eTFyWmJQZ2R0NG1GZGtkMm9aUis3QkJNeE41VmMvMTBMQmllVy9GdlQzbVg5?=
 =?utf-8?B?MEVBRkRuU08raUNoeWJFVkpIbGtPaXJoQS9KUmNxWDgvMlBLaEJsY1AxbW91?=
 =?utf-8?B?dkZJZWE5QVpIQzBla2pmSDhUNFVWc01DM2hhVS9VWUtRVnpNZUVvdDREWVhi?=
 =?utf-8?B?Z0xmb2pNS2k5QjZia2lQZUFyMTVnTWZBQnRJeCt4ZXdmSTJBQ2RQUGFyZlly?=
 =?utf-8?B?TUhmQjF6RnNMY1llaTM5NmYzbGx3RVBtMGJQYkhPWDRPVGFsZStHK1NIWC9N?=
 =?utf-8?B?YkFGcWphbUI0Rm8rRzUrUnNXK3ZOaDVUT212c0RYU3oxOXplVnl5TVNxTmJH?=
 =?utf-8?B?ZkpmWitEeWM1YVRuWWJmc0VuTjhLZ0ZJTlorQytHQ1dLNlB3U1N4OTZ1WWE0?=
 =?utf-8?B?bjFQR1lxYUZpYjJOR3JxQ3BSZ3lUNkxhMDhtUlQ0ZGVHb1Z4ZUt1L2xrckpK?=
 =?utf-8?B?UElvUVoraU9NNTRZdis5UlVudmFZRStnR0txY0R4ckIzd1NZSjJaRW9sblhI?=
 =?utf-8?B?NWp5OVgxdjl2cjhiVnFOUXNjVVlGWGNTUXRnVko5OWRUQ2R4Mm9BV3NQQnFQ?=
 =?utf-8?B?T0MvSitSQ1p4WjNIbjFzRk9WVUFUb29FVnpmL2s4QUhodlVxTlh4SDVVbFVX?=
 =?utf-8?B?MDJHd2xPeU1wbEVIa2RXL0dPWFNJMjFKQlpRR1JRcGdqMWppYmlYckhaNnhM?=
 =?utf-8?B?UXVlYkFSaWRySW8yMjRLeFErSXp0Tm51dU5KK01xVUhxV3dZd0g5N1hBYmhV?=
 =?utf-8?B?WlNGY1lZMlRGdFgwOW50THlpbXdaSmtrZlNrVFZVZ1pnTVp2V1BXaEMzOWJJ?=
 =?utf-8?B?RE02Ry9vYXMxelNVN2EvU0F6Q2lvWnRJelowWERQQlhYblZZeGNvUldPRU1Z?=
 =?utf-8?B?UE5LaGZHbElEUWRpYVI0ZVN0Mk1abUoveUYxM3A2WGVRek1yZG1yT1N3ZFlU?=
 =?utf-8?B?aTVwV09oOTI3L0I0bDlIMk5nTVdNNHc4VG5VZWE1NGRhZFV2VEtRY1lpY2hv?=
 =?utf-8?B?OFp4WlYrV1FYYU1vdlo2SncrVTlCQlIvOXRycE50U0hxK1pNRnNvV1piUjYy?=
 =?utf-8?B?OVA0M1QyQjlQRTdRVFRiNmxXQjZHRmxyREhNU3FqTUt0dzNTYWtOUkhoMXBV?=
 =?utf-8?B?NGlBMVJVcVNndi9LbEdxKy9qZnp0UDBPWDNudWo1U1luY1l4aFpVRHpKZ3VP?=
 =?utf-8?B?WUY5bUUxM3FBaDNTemtJRzZ6WWtsdE91T2J3Nmp3aS9VcmJQRnRyQkpPVDRB?=
 =?utf-8?B?eTZCUnZVZWFpbEJUUzFsc2tZaGF1YWZYTDhIbEsrRE91ZGN5QTBjbUpsWnZ1?=
 =?utf-8?B?QVJoQVdMSzV2U25EdytDZEJIWlVjbzFVZTd5akZUb3MzWjB5Ym5NdmNyME84?=
 =?utf-8?B?aTJIRlhsR1c5eG9lSTR4SEpnRzhCSnhhOTRqRUVFS1A3NXBKR1BOOEVmVEts?=
 =?utf-8?B?YlVoZTRWci9aQkxIL3pqWW5RejZ2RUw4c1d3Qm9jaGNWQmowSzY4Mkw3VDVl?=
 =?utf-8?Q?s2cgd/JPoyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlRzeGFCWUJzd2RxWkRscTBLUGdxQzJaRzJDbkh6MURPWXJ4YTZRcUUzR3pu?=
 =?utf-8?B?L1gvdktMeFlSNzhRMW5Yb0lnSCtYTTVTUWNuc0p3UlVoQkNaN2hFK0YyNW5o?=
 =?utf-8?B?VENMb0FSdVpaMEt5OWE4T1BDZ05jbEFqUlpOWUxGcEY1NnhzSEZIOTM0bnBo?=
 =?utf-8?B?MG54N1ltYkVNdUVrbEtwTXpRdkZ4N1kvUFl0M2F5SDExUFpKQUt1VFFKNGVI?=
 =?utf-8?B?TDdhNE9NUS9IWHZIK1BMTmZ0d2tOWDI1Sk5hcFB1Qk5SSnZUREZTeWMyOHlJ?=
 =?utf-8?B?cDRHdVFNVlJzTkQxd1FkYThRQmJwaHJWeVFoTk1SeFYyak9pYytLNVp2eW1L?=
 =?utf-8?B?QnN4cUF3RkxTRmg0YWI5NnNkSkZpa1JXR1BPK0gyTWJFakZ6b09OZnZIZURr?=
 =?utf-8?B?UVZJUURCQmxaNVhTaGUvMDljWEVCTU9oeldJbGphYmpYUVZzV05lU2RqVWFZ?=
 =?utf-8?B?OHFFQXBRK3lCWk9EV3pYMlRvNEpKLzZLQy81RDNlYkYxbVBnbEFrRmZVazZG?=
 =?utf-8?B?aWxqN3FDTmNOcmtmajU0cTRQT0dqeXQ2RkNBZ2xqWHZyUk1rNkFLU0hXQk9Q?=
 =?utf-8?B?U2ozVnpsZjBub1dNaEprN29wSHVyMGZmU1RBZHZJZE50Sko5OXRaZjRsbitU?=
 =?utf-8?B?RkZzaEFialZtWEZzVDBUNnROV2VBQmxnZ2xiaW1CbGdDbnhqb1N6U0lseWxQ?=
 =?utf-8?B?b0tQa3o4aUtHRy9sQk1iLzFSaVVqbjhRbVpTeU50VnB1UUZRdTlDUW54bEZs?=
 =?utf-8?B?aWNCdFRoenRZVmNibzA1cm5sZ3JwODF6b0p4amw1dmd2T3U3cTlhb1lkZUxh?=
 =?utf-8?B?dzd2Z0xyNXV2TkMwVzl4NjhDWDdNb1FTODVYWmJKVnIvaXFlN2tCU1FGY1Ra?=
 =?utf-8?B?S3N4TUdsQm5VRit3TS9Qb3dqVXJLZUhic2ticmNvWDZUNk9Xa2wwSEN3b1Fk?=
 =?utf-8?B?OEYvT1lYeVZHQjZ2bWdhcVVzMkZHU0pMajVHcGFkNER0MTRHQ1J1UThIVkdL?=
 =?utf-8?B?SXhMQTlZUEVYVTFrbVErWm5zSGNvSThPQjAyYXhVLzRDVjdMRzZQNmFTdWV1?=
 =?utf-8?B?NEJ3WENRZHBaS2FqNVQ3ZzJiYnQ0ejkxL0xkL3hPbXh3U3FnYSsxREVIN0hq?=
 =?utf-8?B?NnFSSzBOa3NmZjM0U1ZqaDlnbGY0ODExUnlmb2ZCNVdWWFREQVh4ejFKcXVq?=
 =?utf-8?B?WDB1clBaK0YzcE5mMU1wQjNISjhwenFBbFJSYWxRd1hIVnhtSzJWdEt5em1E?=
 =?utf-8?B?eGg1dTVFKzZSVWwwTlBWdlFlRHl4cFAxbzZrbElZa2Z0TWhxd01JTVJnMXJO?=
 =?utf-8?B?YjhGUUZucmlCaDNJejZ6VXpISWtjdUptS2Z1aEVCWnlMR3IyZnpMSC92RS9V?=
 =?utf-8?B?VVBSWEhjeHhwek01aFU4Sk1HTTRlK2NveWM3YXZHUzdEZ1hZUXF3dEdmQnNt?=
 =?utf-8?B?UFpKcUVxa1RnN3hxS2NEN25NYkYrTjRQOVJQd2pBb0VYWE5JS3kyUGRoYSs4?=
 =?utf-8?B?ckIvb3A5OHp0RXNwRWM2d3JCVGwwdW5GQXZUNkRFNGZlYUZpei9sL3J1Y3V0?=
 =?utf-8?B?cFQ1RUJYenlmR0JaQlY5blhsWlVRa0ptazdpRVp2QVJVb1ZvYXNNeFMwaVh5?=
 =?utf-8?B?V2R4ZUludHlreEcvOWRuL2lUZ2JrTFYvYjNkRVVhalJiQW9xTE4wV20vVkhJ?=
 =?utf-8?B?Z2l3a2hGdlBGOUVWQ1VLOXhuTHRGRW9kMlNWUFRiVmxOSWhxbldQT0xhVzBB?=
 =?utf-8?B?ZFh5V05oRlZ4ZmgwUTg0TytWT2VRZ29zR01GaDVyMlQ0dzVxb3BxSnU5eTNh?=
 =?utf-8?B?bXI1NS9VZm5MTHNYUHpjaEttZDJSZVFOZlVjVUhyL1AwL3Y4cGptNEJkZkE0?=
 =?utf-8?B?NzcycW5lQ0s2Rkk5L25uQnl3NDZ1aWF6dW9IZjAyaEhLTDhYV1AwUjVqTlAv?=
 =?utf-8?B?NUMwaEVrdUIvWUo5aDNqU0J3OTkrZ3JvRVBqcGVaaHZNR3ZhcTZLVkQ0K2d0?=
 =?utf-8?B?ZnVLazJKa0R1VncrM0krMTV6UGZwYWdwcHBoVlNZUW1BL3VLVVlJaEV2K2NR?=
 =?utf-8?B?MVl1RTRHb244Rm9lZW9pWGcwV1JCWHZVc21NZDl5ZW1sMXNhSUVERDRJQTcv?=
 =?utf-8?Q?4d0qFDNCIEoDrDOzOAv3eiACO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8zdJKHw6awVYttMRlDo4elTbWeNQ7T7RUm0KTXGDs+HOaEbN1rf5NGUhdL2XdxK+Kt2fCo20O9o+8LnHNsn4TPidD1llAKulp11KuQ1XFd968h72YsAYKb32agSyldb/Z2rjmZsjf9lWLHswEO33o7hsCw5LNbVW6J6IrwhGcc/q3L0R9Z3RHcoUre4l5XVDBdqvz1XcIY4qWSKskGYbJ3DBQ1dsg9EtaZMPQAqGOaQQlU1uXRMRtqxjEu1Y8HpfTgZh5nZ2xcf4D7ls2YwMgenm7YREK1UB/HkVSAX9IM1EU9sEZvJwYGCG8cJim22v3XvCvKOO+v/HBfzqcx6/WL6W+CbdlGrS/YluMrfh4dtnjKt6jn93JbMvpA1ITiCZAOdaxXTVEQGMINMr6LppYwfz74uelvYzWDIV8GbaGhdHPUauYWvCEfSirwQC46EC9WA8dU31ttzwGKvhzmNpyQWInnjoIheGrptMUU26iwpKeBHCPeGGKVLDfp3cE139wBfvRiiZRZf68HcmasFrS8MigJBAi9SUJyofkh8ara4KeaCpdlcaDhT3DdYXg0jKbsvJUeGEDh04qZU4TDqUXsZzOaJ3+m56EaBQwfd9ZEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb841a0a-a587-44fb-bb43-08dda4388377
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 13:54:39.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1nPldPRk5rWLMXFkd2VcHJNwtku5OS/g/hltQudEd1wEGN410OWy3GdPuQy5JZgf6KvcJALCIQCvz+7qfS74g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506050119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDExOSBTYWx0ZWRfX2+IgmGAIm2vV v0lBO//CLWJ6/Qy0YaMMVBzDHe8PRX3UbxwLXfawr43jp+jIIuIunxYrGNwJh9gWpZa+QeRQKwV eQskCg8B3gHwBrIDD3DWgO8rsFRRb/rN+RDocEHd2/KEfQ41gXt3xLBhuWstJWoFeGX3N3zBkC2
 6pUJkwuj3YxMqo2OPt0Xt7Z/MHMy8oIcBLXTmTyiQ9n/KJiehPyW27NDrJf+EwYQ/+PWoLjMVtN RH+YDbhozaqnce+2OZRO6ziNxM0ut3ZwhrCFrLFbFFYlBdxlyMoTLkmPt2M9jjJuwBzjtAONis/ 8IoyOeNYJp6Tijux1KnWZmVKuOvOVcBwLJWtY8ImEykLqElsAHiWb/eCLHRtCstH3LLnrOnZDBa
 l0tC/OYoV+FRxr4pgWjWusvTy6vSLcShX0cheP8w7hXdSvHeg5UQG5eqbk251JUz9mYU+wqS
X-Proofpoint-GUID: n1jM4po9v2VlOSYB2f9A0SVWzHfh_t9j
X-Proofpoint-ORIG-GUID: n1jM4po9v2VlOSYB2f9A0SVWzHfh_t9j
X-Authority-Analysis: v=2.4 cv=H+Dbw/Yi c=1 sm=1 tr=0 ts=6841a1a3 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=h9Emc6KvxQXOYiiz9HAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714

On 6/5/25 4:20 AM, Cedric Blancher wrote:
> On Wed, 4 Jun 2025 at 21:17, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Wed, 2025-06-04 at 14:26 -0400, Steve Dickson wrote:
>>> Hello all,
>>>
>>> On 5/13/25 9:50 AM, Jeff Layton wrote:
>>>> Back in the 80's someone thought it was a good idea to carve out a set
>>>> of ports that only privileged users could use. When NFS was originally
>>>> conceived, Sun made its server require that clients use low ports.
>>>> Since Linux was following suit with Sun in those days, exportfs has
>>>> always defaulted to requiring connections from low ports.
>>>>
>>>> These days, anyone can be root on their laptop, so limiting connections
>>>> to low source ports is of little value.
>>>>
>>>> Make the default be "insecure" when creating exports.
>>>>
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>> In discussion at the Bake-a-thon, we decided to just go for making
>>>> "insecure" the default for all exports.
>>>> ---
>>>>   support/nfs/exports.c      | 7 +++++--
>>>>   utils/exportfs/exports.man | 4 ++--
>>>>   2 files changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>>>> index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0685af3e70ed0b 100644
>>>> --- a/support/nfs/exports.c
>>>> +++ b/support/nfs/exports.c
>>>> @@ -34,8 +34,11 @@
>>>>   #include "reexport.h"
>>>>   #include "nfsd_path.h"
>>>>
>>>> -#define EXPORT_DEFAULT_FLAGS       \
>>>> -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
>>>> +#define EXPORT_DEFAULT_FLAGS       (NFSEXP_READONLY |      \
>>>> +                            NFSEXP_ROOTSQUASH |    \
>>>> +                            NFSEXP_GATHERED_WRITES |\
>>>> +                            NFSEXP_NOSUBTREECHECK | \
>>>> +                            NFSEXP_INSECURE_PORT)
>>>>
>>>>   struct flav_info flav_map[] = {
>>>>     { "krb5",       RPC_AUTH_GSS_KRB5,      1},
>>>> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
>>>> index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301c4ec97b14d003 100644
>>>> --- a/utils/exportfs/exports.man
>>>> +++ b/utils/exportfs/exports.man
>>>> @@ -180,8 +180,8 @@ understands the following export options:
>>>>   .TP
>>>>   .IR secure
>>>>   This option requires that requests not using gss originate on an
>>>> -Internet port less than IPPORT_RESERVED (1024). This option is on by default.
>>>> -To turn it off, specify
>>>> +Internet port less than IPPORT_RESERVED (1024). This option is off by default
>>>> +but can be explicitly disabled by specifying
>>>>   .IR insecure .
>>>>   (NOTE: older kernels (before upstream kernel version 4.17) enforced this
>>>>   requirement on gss requests as well.)
>>>>
>>>> ---
>>>> base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
>>>> change-id: 20250513-master-89974087bb04
>>>>
>>>> Best regards,
>>> My apologies but I got a bit lost in the fairly large thread
>>> What as is consensus on this patch? Thumbs up or down.
>>> Will there be a V2?
>>>
>>> I'm wondering what type documentation impact this would
>>> have on all docs out there that say one has to be root
>>> to do the mount.
>>>
>>> I guess I'm not against the patch but as Neil pointed
>>> out making things insecure is a different direction
>>> that the rest of the world is going.
>>>
>>> my two cents,
>>>
>>>
>>
>> Thumbs down for now. Neil argued for a more measured approach to
>> changing this.
> 
> What about renaming the option to "resvport" / "noresvport"?

I've also wondered about renaming the export option. "secure" is
terribly misleading and quite unspecific.

And agreed, after adding the new name, "secure" would need to remain as
a (perhaps hidden) synonym for a while.


-- 
Chuck Lever

