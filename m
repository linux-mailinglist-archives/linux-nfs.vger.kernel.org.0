Return-Path: <linux-nfs+bounces-15792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E3C202F4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 14:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D654011E6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4795721CC59;
	Thu, 30 Oct 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sEJM5R/D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xz5bl1/U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047F2EB86D
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829851; cv=fail; b=ee5pjOYiTJKWPaWg78F6eiyLowEQuB11n0j697/BiWdCulegr/7edvVaH4GI1Lv0gqch8XP7RFVVKOw1JYNdWtZe7RPB78ZCUuPO9zp3qSCSu2nTjxcP9Sir7Ml7kLI/t/e9ssxDFtMSnHhQb4DNCa9bfhYz8PrtHx45K15K9tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829851; c=relaxed/simple;
	bh=oF/gCa6WV3RzmPlmxeYRi+IhO5BaVOskLT8hxlEBuAg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BOUTUN7bU7UjOnCfKJHfz31G6kQaVCVOUoqNI5p/0InoV/aLoUVn0qL1KNOO/aAVNYOcNuZhPuhABVhEeDe4xbDmHV5JqRlSLbfKbXw87Kb3F2kcI0XfrKSgmbqyHlTvZdIUNs/ATEhdhsYYEefECkEjnJTe5zbubyLdluzW9R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sEJM5R/D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xz5bl1/U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UD5UAS010055;
	Thu, 30 Oct 2025 13:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yS6nXPQieRKbV1r08VzA78WmkPBzno+U2+Hbp+V2b+c=; b=
	sEJM5R/DtNVwWqvGQu2wclCHTp8y6/ENR0a3h2bBP4jb2UAbX9E+zsk+zQPM1SaG
	oP3KNqT+/woHVD/SWWk6CW8fUyRscJQq4pxyFav3OX2dthakGws4m9vw77JvjVt+
	rlGlj0ZA8Y6ob9b/jwQOMZiZXtw+Jp/CNkR+Xh/muGdXROiLO7cGo04wDUgr3kk/
	xNPs+Wkxkc+BsP55awIMzdpSJAPVy4s24VYol2glAUW69Oz+jR2p32HnLp49R/J8
	4W3ixeZ8alsByfGID0tWLNP1TW5RwFrexzUkKV/Iv2Vztwifvw1+jW1tfIophy3U
	FTIhGxG1fmKKGFz+plBn6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a48gs80sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 13:10:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UCrxXx004155;
	Thu, 30 Oct 2025 13:10:45 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wmm23d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 13:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+mNuUzzMuX2/pVvKrgKuksCapYfyyFiVJH14C3YWKPtOA4ncsL+1VWLV0Epv0zz9gJoPQ+n/X7IQQsqIQroTMxrM9wFeWOUoyzzOPwE8/pCucddXAOt56PEWqzznTywZinemGNRimQdLKnOpDfKZPbslps0/Uzta8p8uGM4CVn3kEDk2ZH1R7eXRnqKJ/dydb5VVisGFi63oMss0EPDLwRNZltxhh7f2jl+LrVA4qOQPOSQdfIVexAvUkrtclLZBzGlZHITb70zjiH5A49mP33X3CTwTCs/UFA4nRbQlv1pC70JPYFro9nNWxy3ntctYKvk49LFp+uxd6XjNH8x1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS6nXPQieRKbV1r08VzA78WmkPBzno+U2+Hbp+V2b+c=;
 b=SRhjZQTZhuN2bx9xLOMpI2VgeKjx7LtAPmJyG0twmUo65yQOep/CF4GuNDfZKCpN2yjhQqVYyiO9GAnxAgh7PpEotYggf5qDiyxHR6RHtcn7QKfCpM0p9DZK+8vEQDHyZFl8Q681KRoIM/0Qe1aIwdpYd3z0NNzxP8osPXeiZTCyZGBBBBcyvkC0KCQeuXNqLTpN3Ur7h8V0L4f78SmkA+Ri9XA4r3CbswXp2GWUCWs+eRI0QjRI5LCIE3CaOwzrC0d/djMdl2CWT0vVZey3GFuuw2Uz0fqjirV97TovJWH+/rPJ8obBeXvCi7EkcyzbcDug5rWTHLdGkYtqJ4dqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS6nXPQieRKbV1r08VzA78WmkPBzno+U2+Hbp+V2b+c=;
 b=Xz5bl1/UjA5YywnY+3OV+0XWmGL4igjWmET8cmht5ZDSJSmyau0aw0UGOQIJyQc1Cmexb9kfeJsRja4ewM5kId9jjIzq2SCrJyRtFDD4yVeW0eD0uuQjwWfUBkC4/vxALauYqbEvkriteeMaeP89r24Zs579JiLQ6gfuCudILUc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 13:10:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 13:10:42 +0000
Message-ID: <c2f48a2f-1934-466e-822e-b64a510b635a@oracle.com>
Date: Thu, 30 Oct 2025 09:10:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: READ_PLUS broken in Linux 6.12, worked in Linux 5.10! Re: [PATCH
 1/1] DIO: add NFSv4.2 READ_PLUS support for nfstest_dio
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>,
        linux-nfs@vger.kernel.org
References: <1759357733-64526-1-git-send-email-dai.ngo@oracle.com>
 <CA+1jF5rAMkb44Pu8XGDnu9WUE54sHVf5TurMsQXfrUrmu0Ojjw@mail.gmail.com>
 <CA+1jF5ovASc6zVHE7HA7MumKnpzvadGw_vyjV+ELttxv5tCCTQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CA+1jF5ovASc6zVHE7HA7MumKnpzvadGw_vyjV+ELttxv5tCCTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:610:33::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc1919e-8e58-44e1-d18a-08de17b5ba86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VytidHZRSmJQaXpRQWxOQThUOWJXd3FsSVpJdE5ZSzVmam9kYWg2Qzk5eEQw?=
 =?utf-8?B?TEl4aW5ZZlZiUkNWbitTSVZrdHh6VzF1TWtQM2VGSnhvRkk5cnBYTGVLZ2Jy?=
 =?utf-8?B?N0FVaitLWUt5QTEyRmdXVnlObG12bTJtbkM3VDZLcGlUdklLdGhuV3RqQldv?=
 =?utf-8?B?RFBEVUV5czdNejJDMEZIOWlyMmt4ZkdPRHhBcWdzUmNVNkQvUVB6UEtOZG13?=
 =?utf-8?B?VGJreHJEeFlJWXVqM0QyRHVpM0E3ZkExTm5ScHdIZzJQZFhuRDRXVm9BSkhS?=
 =?utf-8?B?STljTEQvSW54MHF4T3I5aC9CbUpTVUdjUGxvTDljWHRjcW9xRkNiNmVVbkFi?=
 =?utf-8?B?ZTFPTDE4UG1NQW9EaWt2RkVxWXE3Ny9mb3liNEQvc0sydkVQclZRY3UydkEr?=
 =?utf-8?B?bDFrY2FSRFA5K1V1YlpQOVN3RzJCNWhEcU55eFRlTUtoTWdJcVRYaklxcUJi?=
 =?utf-8?B?VGhHR1dmcFV3c2hhUE82YlkxUUQvOFV6eXFZVnlnTVlTQy9sN3VwS3JOTTNF?=
 =?utf-8?B?RjR4Q2hXVCtYNkNaZE1iOWRSRWVUYmtVNkpxOVRpS0RMUzYraWhFaFR5U1Qr?=
 =?utf-8?B?VnJBcm1JRUdURGgzZXEyME4xbWhOSmFNZjdkcnEyRGVLWFo0OElnNUwzazk1?=
 =?utf-8?B?SWdhb2s5Z1NEM0xRcjVhSmtnUHZMNGVqNE9qVFduSHk1MWY5dGZNQ3BGUG1y?=
 =?utf-8?B?WE5ud1hlb2hvUTU2TUVyeWxIcGNhZ3dlMHYzWGF0cEVxa21uRTZNeG5hUy94?=
 =?utf-8?B?eU1neDM0UEh5ZEh4U2EvNWh6QlVTbFFqNUs3Y3hqK29EYy9oYmlmZEw2cnZr?=
 =?utf-8?B?RHIyTVd5Yk56dXdjZmFpcmVBeXhkY3lqU1dKdnlOL2VYeEpzQ2VxSndHYVly?=
 =?utf-8?B?Wm5VQ091Ykh5Y1pQbEhnSVRjZVp3dUZ5K1M1ajFDWHFacUZqa2owcHhzcEgv?=
 =?utf-8?B?TUNub1FmZVEvSGd4bjZpVnRxdTRzSHFVK09oYjF4VldicFUzV1UwWEtlUVpG?=
 =?utf-8?B?RVluNndmazBhMzJVMUMzVXh6bXY0REdkTWdkV0VDaXpFNWVPMGJ4ZVJEY01k?=
 =?utf-8?B?NWhVMTlzTnVwRkMzc002TTVLQlJ1MzJUUFFrOWYyMTVIMEdUMlk1TUU5MnlC?=
 =?utf-8?B?NjhnZkhpR0QycGVadWRkVjNzVUxzSS94VzR4WFRXMXJsWE9CWWtIbDlHK0o2?=
 =?utf-8?B?UHZpQURoeWc2VDBvbkczK1Rwd0hzZk5pUWxvNzVRR1AzRlhYMGcvZ3VMVnJp?=
 =?utf-8?B?SEQ5TmNhR3Z0L2ZPQkhaRkF4RnZwSGxDY2VqUjlHUVpjZVg2NnhQVjJTdVBP?=
 =?utf-8?B?eEdyWWhkdXZzdzJBNEU0QXUrTGluRzdwNmU2TmREQkdxaDJiQ1g0Ry85L3Z2?=
 =?utf-8?B?QjlCdGtiU1k5elRDaW8vV1l4dzFDVUx6eHNGSXhOSnYrQyt3a0VYZmh1TVlt?=
 =?utf-8?B?am93VEVIWWNMSCs5RkRqYVoxeStpV3BSRk1xb2ZoQkZFN3lia2RrcHdGMXpp?=
 =?utf-8?B?ZlZNbGFZYWtFV3VnN2NEaEw5Rjc4b0tjeEJHWERRNVZnNzJZYVh4Rk5Sd0xz?=
 =?utf-8?B?Vmw1VTY1V0NZaXY4Zmh1eTcrS0JkSGdXSkxjVVUzeGlKcFFhNHQrcEJPNkUw?=
 =?utf-8?B?dVVSZkYxaTRuV3hHK1lJbFlFR1R1ejd1Q1h3WnlVMnJrVTRuWnN5bExTTC9X?=
 =?utf-8?B?OVNHa1FtZkJpYU1yQVVBS01mdityMTJwR2RJczZHV2JVMW8vVjhYWURjazRu?=
 =?utf-8?B?RTZIK2ZWd3VQOU1RbkgzR25RaVlaYjdCakpqUFM4Ynh1ZzdSYS9UcUJmRWpK?=
 =?utf-8?B?WjN6RStMTUM5K2NsczdBMjRuUE5sclBobHpJdGZtaTZmcG0wNUpERjdRVTdQ?=
 =?utf-8?B?c0k3a2R1cnM4ZlVvcjA0WGRlR0k1ZEhNRERobVZVWnFNckE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2p2U1FPMVJwK0ZxaTJzVUFHaC9iVFR4b3hZZUp1K2pEVCsyQldibmlFSVNs?=
 =?utf-8?B?WERwRmlnT21TZWM4U0hQdzhrTVI3TjhhKytPaVlwZmVvVmFRdU5HUi9kU1d0?=
 =?utf-8?B?Y1RDZHpHMjRDbnlQeUFmb0wyTTlReFNRRGlSc21qRXU1SkhaRzRtcGo0VEQw?=
 =?utf-8?B?UmZyOVlyMlUvVmZlYTFJdjNWc25Xa2o5a1g4SWQ2ZnlBOXhtR3cxcDIxL0lR?=
 =?utf-8?B?bEYrTWVzczREb0VhcWxZSW9Jc2o2S01McEl5dnliSWtDWlIwaW1Bd1czdEhm?=
 =?utf-8?B?UFRTVjZFaG03c3drY2IvdGdtZitkU29TSWtZMldsTVJaRWF5S3BqTmtpOU1r?=
 =?utf-8?B?QTc1ZHFLUkV0NjI5bGlreWZtbkhZYnovUDlWb2tLdnEyd1RUZ2ZDcEplTHkz?=
 =?utf-8?B?dUtpcnJCbWF6Y2d1MU9nbUxWeEhRWlRWNW1RaXVyUnBOeGdNQTdJOFl4SlJu?=
 =?utf-8?B?WC9CcE4vT1ljMzBhcVhpTFRUbEU5dHpZSU1ucTZrZVhHZGxJSFZYS1l5ejhN?=
 =?utf-8?B?dVpFaFdBRDJuT0ZhQlRRZmp6ci9KeGxXVnp6VTZhYkozZ0ZremVNemZmRk4z?=
 =?utf-8?B?K2gzeXgrVEhCRGZDOHkrTFE1TDdUUXVDV0dzc25WWDUzNzNBVzdldTk3aFh5?=
 =?utf-8?B?UjA1a0x0MG1FbmF4UXYwVzRtY0QzL2tlSG1ycW5BYVoxc2IxTExNUzdiMUNY?=
 =?utf-8?B?L0hZTGVSdnF1R1diTm93TTFweGpicjhxYVVab2pDaUhvRkZOVjNnWHd6SERk?=
 =?utf-8?B?bW0wam92Ry9aSDdxR0hiYk9UczdIRHl0YjBFOGg2SnU4QURwVEJQc3pkTDRp?=
 =?utf-8?B?bzhxS2daMTEwa1BXKzRna1orMnlOcXZaNFlZWnFybFRpR0lLYk9uaHQvaWcw?=
 =?utf-8?B?OTdUSkFBWFBIOVhGYmtDSzQvcy8rN1RESjhpZDI2SHZOQlc2N0gxaU1ZMFNC?=
 =?utf-8?B?VmQ1aUNkWVhoRnR0WDBDTnptMmRuYjkzaTFRQ1J0TWpvRk1EdGF0UjAxUkx1?=
 =?utf-8?B?ZldqSlNZRllnajRwZ0NydWpYL0JSbHB3SURvV3RGM3I4cStGakdPN1c0NVBK?=
 =?utf-8?B?Zk9XK3M0MjhvaWNESlhEVHdVdy8rVUlRdjVzNFVIdGNrQVQvZ1FMbTZBbFdM?=
 =?utf-8?B?VFF3VmlodnByTjZlci9JeGplT1dDK3Qra2NZaDNCQnI4MmhDTFRiV3NlWHlB?=
 =?utf-8?B?U2JBSHRIU2l4OGYvSk43U0VOQTdPMHQ1S3E5b0ZQUzJYVzg5OHJrNEQ0NU8r?=
 =?utf-8?B?Z2lQcS9OK1VmbWNxZkp0ZWkrUzdkMGVmeW5qQ2NZcytNTmxqdHh6STNwUTFB?=
 =?utf-8?B?anROc1NEcno3KzUzME9zMjZzdUxzdm5OVFdXM0hjc3FxSDV0TGF1YmVCUi9W?=
 =?utf-8?B?UFYwVUxaMmN5UzRCcGNtODZRWkdCRDBqNXhVcEtwVCtyUnJEblRibnV0YzJL?=
 =?utf-8?B?VTE1STFvWVBEb0VyR0VxU0M4WjhRa3JYa0ZkWU5yWXI3ck1CbmN6SkxOQ0c4?=
 =?utf-8?B?azZiSVA2aFR3RDRKV2hrRDN2SDFuOURQT2w4eDBkVTVNUDE2ajVpODVML2Jh?=
 =?utf-8?B?blJPWEJoRWxadHBDZVdib1VjdXdCUHF0cEhIenh3aHNNTnRlOHY0SkUzOUla?=
 =?utf-8?B?Njg2NjlZd1g1c0E5eXUweXJrNUZqVGZpUEpCSGx3b2VCUWlXdTIvL29XdFRW?=
 =?utf-8?B?R3EveDJKTEtoUHY4TE53U3FkamlDd0RLelZ4OTg0VUt6czAvZEkzVFhadzRJ?=
 =?utf-8?B?Q0ZXQTN0THZpWE4wbC9KNFgwa09hcCs3b0Zldkp6bWlJSVpTWTkxM1d5Rloy?=
 =?utf-8?B?cGVJNDhOMjdQaEdKWnpaZy9UN2U2NkpOUXJIdEcvSk9JZHo5NGxhYVJuNWhK?=
 =?utf-8?B?TFo4aWh2UWFBOUVVenhESmlheXNMeElwS0NyL3NDOGFpQU5HVkVEVjV2ZEcz?=
 =?utf-8?B?VzBDTmpXakI4b0JWV2d2VkRwdGlVM2ZLTlErZXV4UFIzbWR0LytnUXNPYUhV?=
 =?utf-8?B?RjEwd3dreVc2WitPTW5ZK0s5RFJaM0kwRkJvTGtqUVJnY3VnUHg2UFc5RklY?=
 =?utf-8?B?cysrT3dJL3pvZm5XWXFMRWxoemNVK2lobWdTV2pCdnJjeWRkMXNRYStRMmxT?=
 =?utf-8?Q?ekyi1IdaKd00NRO02gMW4P6jn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	auqB4vxBoKK0hwtCO+bPT6YuKLjbrqx+zlyqemiDgYcg58BfxJ9xLiodhweAMcKfWfgwhC8QV5pi3/V4csYvyFw34yXsBlHrbRNSCZWiGvwLCwJb1esg6gZ3r33skH4icVQ2fBB+8oAwk+iwyDJ2Rpcnd0JHYj+1HfWK6Q9eV5Vm3XOzHedg4UHXn5UKVH0DDxf1mitWWCwTZqDBjPPsDAZU7jePp3qJ8do/cwZX1Abkhx9Z6WV/9oEA854sa4BLBtpdlqjKNfHyySXj0L8TsFRhcnb8fUUzj6mXw2CtP6AMjvlUDT90UZ4HraiXbg25LUjtJuww3gy+Dmm9c83ISLUVOJYFSjDr4dwZX7TkOIKhVGEuu3Vdd3r4lVwiQUC90gZXh5ecSATmI9FvzApJCs+gIrvrl+2Ek8CtBEG+EGHlmPw9R80J0DpcenrM8avYla8uMASROv3BoF7c7LeZBYpCg/RSKQ9N6hXHS1RJfEAMmm2VFB5rC/BDiN6amfnXKg5sIuJTBFaaR2pYfgWhVBw4EQYOjhv5iBIKfwwfjDJ7De7Yck8FWIiuICMfUsybVmSnb+oiEaI7HaOEuCtDxj0uec0LGyS/PPDs4yGZeL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc1919e-8e58-44e1-d18a-08de17b5ba86
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:10:42.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMsscNTxPmvcJ5wDbOHuQbQ9lTUqt/NvuH01Gr/7z2LPqfp8ym8PWzjsdpnTOIdvnYk6TP8Y6CgtXHH4JIVukw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300107
X-Authority-Analysis: v=2.4 cv=c96mgB9l c=1 sm=1 tr=0 ts=690363d5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=rOd6jeTEAAAA:8
 a=mFC5iSolf3TRAKK7X_IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kfyJvcI4S63vgYPh1728:22
X-Proofpoint-GUID: 1tyt5xDwUFNr7tqqMaAoMyIuuqA1EeGw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwNSBTYWx0ZWRfX7t7Cj/NoKW17
 zyrsrxNvtKc9misuctLt084pr6ZTdQOr+3SlDC5o2kEbT4PA5swaSb8kuXree3g8pXmQz2QpIAX
 7D5LihrX8m/MsvUvN1W0hdHlHFSCZi6gdjsvd2QQBn6QR2PZs83/qYwtUHQgLbBj+p9uePzp+cZ
 Sf3OOxWPUqxDYQcrS0xNyOthw52mDo9k1ABfq0MjXxgqI3hDi5g9yyRI6wBEC2eNwpnihj4cCaL
 JRAft1duSZNJ+Q0y+ztONMqTUp3IUfZbe5S0pXg6pyHYsGu0PdfZM2ZuuSbK/61JhMMG0Otls9F
 kVzUmc8Uqqf++swg0bVaEMfxf8fsaiDi7I6tIh3MgYVKSApByvSr9+OKArLUaZY2cMgxsOjF9ru
 LPf7lJurMnuBXnS1WXLpvREF6S0DAQ==
X-Proofpoint-ORIG-GUID: 1tyt5xDwUFNr7tqqMaAoMyIuuqA1EeGw

On 10/30/25 6:54 AM, Aurélien Couderc wrote:
> On Thu, Oct 2, 2025 at 10:22 AM Aurélien Couderc
> <aurelien.couderc2002@gmail.com> wrote:
>>
>> On Thu, Oct 2, 2025 at 12:29 AM Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> From: Oracle Public Cloud User <opc@dngo-nfstest-client.allregionaliads.osdevelopmeniad.oraclevcn.com>
>>>
>>> Check for nfs_version >= 4.2 and use READ_PLUS instead of READ.
>>
>> FYI READ_PLUS is **BROKEN** for sparse files. It was working in Linux
>> 5.10, but as soon as we switched to Linux 6.12 it reported only data
>> and no holes in sparse files. We're back to Linux 5.10 and cannot
>> upgrade because of this.
> 
> Is there any bug tracker where I can post this Linux NFS server bug?

https://bugzilla.kernel.org, Product "File Systems", Component "NFSD"


-- 
Chuck Lever

