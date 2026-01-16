Return-Path: <linux-nfs+bounces-18032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293BD37938
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 18:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F10430200A6
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89C618E1F;
	Fri, 16 Jan 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AB8GIN4X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KZlEPWJS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4F346A0A
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583736; cv=fail; b=Z1YvCwu5Y1079xfKc/vKHShiayIbH9c7ajlrS6s8JA+TcKVRWCzCyYB1hXBRu7yMgsk0DOhgSXMfHPgE3r/GLq/aDeW2rx8W0DC2RI1PQz7a1tfWRqjeDkLD3vo0hZKFajkPbs6mm5O2nM/wmu3v2irlhRU/WzWpuGMrU7TxleI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583736; c=relaxed/simple;
	bh=jBcaG7CfBEQSATVCrAHpi9iVTLeUeKC250fwNMZOwWA=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=j2JsNoGghT9u03HelKUKnenPXWm66hij+1xtP74MbYZVLogu/qSno5gS/KzY2R1tBQaDBI/Eqcng/kPN9v9hkAXY6qWC21iy5F3RoznCtbTvvWacqNomrGDXWsgpLYaEMoG7BiKCrCuj7U/lWwVRMBYHepJibp5sbuN7ztgrWt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AB8GIN4X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KZlEPWJS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GDk0aK1430046;
	Fri, 16 Jan 2026 17:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Lyuge4Is+f4jBTDV
	uLb+TLtwDBkOUGnEChUdymwn8ao=; b=AB8GIN4XIRnRUW3jCbGvvgtDJBJjrTcZ
	R/BA/Q/xomNKu8WwqMdyX5o90tIfGJnxwkhF+zqLn5AgFygC00r1hkfYlttkbnZa
	S1NPapIsle/ZXnTcqts7jlW9huXzlLE+CVlVZALE1yFsBZ3oOE05g6pYkMFazEvL
	AgudLfhECRFQwL0Kax0hr2aEZmljr8KgLJfQoJGotOjSVQvt5j9ktrhwep96dW4r
	zxgn8dFZ7wIswmX2Yz+pAKVyJlojLhX3SwCtRei3NsLxrn69a98zYXQxwMS+WyPD
	JLA/0+/EU0dLJWnPlQYQ9aHNOjPzbucCWfDAh9qW7bcrJ9nBNmd4xg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre42ay2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 17:15:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GFXUmX029152;
	Fri, 16 Jan 2026 17:15:31 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7px4pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 17:15:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnRexgI3t/SO5pD4bRvqkK5vHfIvhun42bqCPLnR/dtnCWYeDYS4hdyfdpXbdIAUjoKfcJS0RzVQGDbXtds7T7J/XMtCbn+61jSEsjbHQzwQBGdfoZsI5cTMXmRQXKkzF0koYmlL06o0knBFfbVXF7mKoq/IjuH94NmCDpuOWygAvQJgPL757snC5i6UbfDpBFmn2fYjBYVhDcv3Fc1Rso6nupxfNLnPwZjeU/b8MTg0+X4w+kvahDkRW3aoRb9lhOZZUjSIpWMZfNJFf2tSKy6ZfFSKyGve/0Gs9HvR4KXgis/7iYAb/0O2LfyywkvXlo4mmVuwECpdWmqkxA65MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyuge4Is+f4jBTDVuLb+TLtwDBkOUGnEChUdymwn8ao=;
 b=IaMKt08G18aKBUfCqI92FnInMthMKBqZ5tcg7i0QM+c4et8lJi1KrX3mDbkO1UF9hcP0PD2tdVVBGtjEX3IY5teyeBhECK8pjUfZrXCR3eVyZnN/M5ut/qUTiNQ/Xzn2ysBizUmn2yV3eT0tYEeD2llSRKAYUieWmaBqFaqkZ0yqrtIMRLUG4eFyFJCUVSfqjA4CmdjyiUsMdWLJM7ZBteCO2jL4qtnR7xCVq3xV6oZvaTLRjANTJwo+IX4U5bcqw1FaVp2m50Y/Epq1P5Fx2c1grDW/+75S0EMOD4iqRJtou8NwjmBezzYDu7lixbqjeswiAnIU4xCepjJQEVQUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyuge4Is+f4jBTDVuLb+TLtwDBkOUGnEChUdymwn8ao=;
 b=KZlEPWJSFAA5E98v2XQ8mnQUJhxGP63oLjksiAIR4sOPC4Xc2vmsP3qk5uwdRNTUDwWAcoPjxIEB8wwvp6Wd0PUj9mIoqbAY9rYh6vSDYWxqJRIHqYXuY4lX1W661QqEv0MNfTBMp55/Kkx/TByZfoP6ZT29mtuoYxRI6rTBvSU=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH3PPF2A078470E.namprd10.prod.outlook.com (2603:10b6:518:1::791) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Fri, 16 Jan
 2026 17:15:28 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 17:15:28 +0000
Message-ID: <45f16856-b71d-4844-bf11-fc9aa5c2feed@oracle.com>
Date: Fri, 16 Jan 2026 09:15:26 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Chuck Lever <cel@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Dai Ngo <dai.ngo@oracle.com>
Subject: Bug in nfsd4_block_get_device_info_scsi in nfsd-testing branch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0049.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::6) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH3PPF2A078470E:EE_
X-MS-Office365-Filtering-Correlation-Id: eac00029-82d2-4517-ed16-08de5522d875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFpmNi9aVXk1ZlFBSjMxQlNpSzRLNlBMRk1KMzVpZVFjWUVvU1kvOEFQUlRw?=
 =?utf-8?B?SjRkWXpSTkZxT3krSGlJcnJjL3B0VWU3K2NZUC9PVDhUemt4YWZFNXIvQlNS?=
 =?utf-8?B?VUtqbmxXaTJsOVJzdlJmZjJUVFZyMmlsdklhNDRHZ05vNzZkQ0xXUGRBbThv?=
 =?utf-8?B?eHZKNXVsQmppTVpMMkxvRDdrTjdGNXRheko3RkpEd2dadVVGWjFRT0lZZmRV?=
 =?utf-8?B?SlJxZXVSdlVFRUlFa3p5VXJ4dE9BTjducmppL25ZNE9YeHlTenJRdkxOTmxm?=
 =?utf-8?B?YlBabXdyaklLWUljcmpOakZTYjZPQ3dnL2Ezc2svVkJCZmZ6VlNURzlFclRi?=
 =?utf-8?B?M1JRVWZ0UVpEQWVqZGtMSFdQSEgwWWhWSnBRc3VUSmlJM1JaR3hienpzakRI?=
 =?utf-8?B?Ym4wM0djK0xYZVQ4TWZ5SzJkcGxQdW13NUNYMkF0dTU5MFVxYndNb3hjRGJV?=
 =?utf-8?B?T0VkTkJlMTVDK3IvK2VmT3JSREk2VGZFRnNnTkdMME5tVlZZZDBUdXlJUDNK?=
 =?utf-8?B?Zm5DSXk5bm9lMDJzS0Jvc29pY1hNWThNdnQraUppQkJYeUlFcHJlOXROQjho?=
 =?utf-8?B?Sm44VjlkVGVEOUNDcDVRakc4ZDBhNmdkN08wektOSU1Zb0piem5KU2FLZmlB?=
 =?utf-8?B?Y1ZNelZuaWE3clhCZ3N1Ny9QL0ZWbWtXWHdqQU5mSUtsSVN5K1N3U1YvbktX?=
 =?utf-8?B?Ym5zcUpFei9tTzQ4MDJVNFJBMEp6TFFVdXhhL0s0SGpMZE1TZi96S0dVTUJL?=
 =?utf-8?B?VGVIQUZId2NTTi9lWmxCU3Y2Z1J6Rnp5U3pjNnNvSE9PNlViU2tYR3hWSVJO?=
 =?utf-8?B?Vk05NTNlOTBUbEJrNStIK2RrY2l5eldnL2grbDQvUDM4RDRPYU96REdSRnNr?=
 =?utf-8?B?cnVCMEw4eGdLYUdoNlJjbklsM09rdlY3b1FPMXVsVG5QOGtMUkNIdjR2elVW?=
 =?utf-8?B?RXE4dFdWZ2V0RXoxSDVrNGtOd1BOYXFuSmtmSFd4VStTL1JmbWdFWi9TNHNo?=
 =?utf-8?B?MzVORURXL3NDMHlpNi90Nml2UHZ4bVpaeloxalhTTTZCbTl5SUtvc3BKT2hS?=
 =?utf-8?B?Rjh1L1pkbkFyMWpSektObFdySHA1cnh4QXcrdnZVOVJCeW1lZ1FYbjNmZ3dw?=
 =?utf-8?B?RTJhQ1dvQWZ1RngzZ2dqN2RMSzV6cnJhdDZibmNCNDBQeFRuMVhRZjdudDFD?=
 =?utf-8?B?eSt4NElpTUJJR095M0twYVpkRVlUekR0a1Ywbi92VGpwNWdXYXEzSzBLNGpQ?=
 =?utf-8?B?MXJpWWM1a3Q0L0s4UjhueGlCYnNjUVJrZlRVdDRhQVk4Y3hxVnRYRmJpalBN?=
 =?utf-8?B?L0NhU0UvcWw5MXYzM0pRR0JINUY3eTZuUkpxay9BWUVSbGJmbVZ2cG9LRTdn?=
 =?utf-8?B?Wm9lSDNZWlpyZCtPZFJtenkwMzNlcjVqWHpPTVliQ0hhZFl1Tm9WeXE2RGdB?=
 =?utf-8?B?L2VMcGtSOWg5eHRxUmNrcG5URjQ5TGVjWkVEOXpsMHFMdVpEN1U4Q1JIMk9S?=
 =?utf-8?B?bm1SaFRTTDVYa3M4NldNTlRLWmlJN2N2VTMya0ViM2p3R0xIeW1NMUw5bk9Y?=
 =?utf-8?B?YzIwOWJjS2JJekovcU40ZURTSlZoa0NQQXBXYXl0V0NSU1E4RlJhQXI1TTZh?=
 =?utf-8?B?REpQdDJKZ1EzNVdZUlNRcVphZTdQM1g3WXlmdFFkazlQcTR4U3g1aFFscHJO?=
 =?utf-8?B?ZjNocmhDanpSNndMaUV6b0ZWaXRNSEkvUVRqcFd5QUZXRXA3dWQwb0U4VW8y?=
 =?utf-8?B?QzdidXRWL0hnZmYwOXN1bVJKd2FqeU9sSUwvalBFZmh6MVRaNlNpK2JiN3Vo?=
 =?utf-8?B?Q0xudDhpaHh4YkZhc0JiemtnTGdudnJvNm9OQi91L3NtOG9BRHdFcHJEYjJZ?=
 =?utf-8?B?cHArR1VUbW5jRjlURHppSHJhNUl2M1FSZkRpa2kvaC9USFhtMDR4a1V0RDZH?=
 =?utf-8?B?R1RTakpncHN1VElIbENkQ0VuclRqOEd0TFROeDl3VkhWR2NKeDRkK0xraWln?=
 =?utf-8?B?cjlDWlhDbUNza1NsbGFIUUF3Z216ajRJcXRpWHgxTzN5TkdMb3dxWjFJZEpv?=
 =?utf-8?B?dEVtclBxdTlZVVpVNmlNc2l0ZDQ4MUhrQUc2TGFwTDZOYWZDYnFOL2VWVjNI?=
 =?utf-8?Q?VPK4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXpMWWFpcUUwNnhzMTF0M3h5bE9VaklGVGxBSnBDQlQvblJDZThzM1hmdldt?=
 =?utf-8?B?bFpFd2x2Wm9TeEhkR1VuelQzRVY3MDd6bVc0eHZOUTNMQU5YTFVzdWlVVFVl?=
 =?utf-8?B?NWl5a3ArdkZwNi9nK3hGSkZrcXNiWEdoYVRydkFtYm9DZ0lyZm9qMlNocHZh?=
 =?utf-8?B?RTZqd1U4NUlNWEE4b0R2Smw5Z09VdDFzOVVZNWRTUUxQSm9yOHlnYVBDdnB0?=
 =?utf-8?B?UUorajk4eC8wNzNleE5ScWtvdmFoaVFuQUZNZ3ZZaVpaejJzNVpVUy9GWllL?=
 =?utf-8?B?Sml5TVJtMVpsbjdkZmYwbTc0TXljQzFZN3JrMFpubWJGSkdvOXltVTJydmhi?=
 =?utf-8?B?bC80Z2FTMFl0aG14QmtSeERWbTNHb1V4MVVOeUVoZ2w2ZnNPV1hlQzZKa2lD?=
 =?utf-8?B?dzUzYUhoRlhscERLL2hnTWdrRHdwaTlISnN1RDhXenFvUmdma2xsdTB6aGFq?=
 =?utf-8?B?WXN4N2JZWUxsZVBDUVVxRlE0OENmbmo5d0lIdldtU2krdCsvMjR5N1p2WEx6?=
 =?utf-8?B?eTd0VG9qdGZ5Nmw2SWIwcWlIbjkwMUNXUlc3V3l4MXlhbUpDOHFyajJoOTI0?=
 =?utf-8?B?ckN1TTUyNGRYb01yNE14VjV1aldVdkM2WmxPSHVIUjA5dGROTEdlVWRVUVJ6?=
 =?utf-8?B?UnZqQUp0dGJNbCtDSDFLbmc0Ymo4amFscHdMdEJITXlHWW5VUFBqUTRYdVYw?=
 =?utf-8?B?ZUl1M0lyQ1B2MXVoVTBJSmhUTGM0MTI0ZHpYV3BVYzBXS1RoZW8rT3pZSTlk?=
 =?utf-8?B?MjNSZ3doQ0ZXcmZwOXVEdmpTN2hkT0NrVkIrV3BMU1RTc2MvbWFZUHRwRlpm?=
 =?utf-8?B?TWQ0SG9WK0RsejY0bjVHTGEzMlZDZkRqbnlKWXJWNlJXYXRlWk01YUdBVDBi?=
 =?utf-8?B?VXltcTVnSWJySUVVZTZubE5GTkQ5QVVNVEhVekQrT2R5VFoxcndtZW9veHFu?=
 =?utf-8?B?U3BCU1c1dUVHUThsOUoxZHlDSFNrRTRNQ2xGNDdHYmlHZld4ZGo0TVhkaWF2?=
 =?utf-8?B?NGhSb3BwWnNXK3FIMmYwZHQ0eldZSTlFbGFRcmpGdnBkdWwwenc1ZHVLTGY2?=
 =?utf-8?B?VHNyTnZsTEE5eU9pUUg1cXNMUFM4bkErVDBQd1ZJQTlYcnRndHV3STI5MjRD?=
 =?utf-8?B?K2plOThWTHpiSWgwbEJ2K2w3K2ZrRHZuVWs2MzJDRHVxR0FjYVVPZWFXc3Bx?=
 =?utf-8?B?VCtqMS9Jbk5taURmSkNtT2tDYU9aOUZhU3RHK3dNZ1pwWW5USFBKZTF5bENM?=
 =?utf-8?B?VENhM0ZRUnVMWnpDN2JDV01icWxEbTdRUjlWYWxZWWUwWVF2NVc5SVY0eUJI?=
 =?utf-8?B?dGdWQlE4M1RaRUZ4MXNReG5iOEF5ZUZYUFY1MGoxa0hNUVBQY0hZY0haenZI?=
 =?utf-8?B?bGoxRVFQdUtxTWNIMmcyenRhQTE2aE1WVE1mamE2WHpDc1RyZUtrQ1FMTlQ1?=
 =?utf-8?B?U3VrbldHVVdldWVsNTBTRkhPV3VtOHhMa2luTWRtWUIzZStGRE0ybWp5ODMy?=
 =?utf-8?B?UzJQWCtqSGg3MS93TDRpeWMyN1dxNFFNa25ZM2tUNmlrK01oSmRQTUFUbi9v?=
 =?utf-8?B?NlVSUjdVNVlSSVhWT094dTZWdWpTYlZrSk96bEJid3hUUDQ3c0hTSUlYaTNB?=
 =?utf-8?B?RE5oSFF3ZENEU1krSFM3RDBhY0U0UWxtUzBPd2VRZFZCdUtNY0pPTUw2dHZy?=
 =?utf-8?B?d1hZV0lzQW1yTFhUMGlpMitZOWZ1dDZMd0Q4elNLNzZHVlBjWFRPd2FsRjFn?=
 =?utf-8?B?RmZCRnJvYVU0QnZxTjNFV3h1MXZDOTJZSjZ3UE1nWnNub1liYzd1bnE2Vm5M?=
 =?utf-8?B?UE51SFFBQXFESkVjRk5hY0lCM3NuL2dsek5IWFNsTHp3OW1sN3VPQXk2dmZT?=
 =?utf-8?B?U3E3SHpVSnpHRnEwY1pwZTRDVGt1d1cxWjg3cEYxaDd3bnZ0M1VNTzU3S1oz?=
 =?utf-8?B?cVliZWJkOFpxN1BKWTFFTDVKd3pBRzJFNUl4UlRwSlFsaVNUcC9vWS8yVitE?=
 =?utf-8?B?MHRWSGNFOHBBODNlY0g0c0xrK283WVA0K2tEMm94YkdZTkZwUkhSbEpDUTBu?=
 =?utf-8?B?UGhBL0lkZlI1QkUzSVZnazl5bGhwQXYrQm0zOVdlNmc3WVU4WTgwR3JiTHJQ?=
 =?utf-8?B?Z1MwWlQrdkM3Rys4YnBoa1B3V3VJbWJwcHFnYmgxY1A3TStTOFdaZzhnU0xU?=
 =?utf-8?B?SFRNNmd0cStYV3d5YVpoUVFpYXVDcnJDS0ZBM2lpanUyTGsycDdtWjBYYWlG?=
 =?utf-8?B?S0FoWEtVWWV1OUJUQ0tERy8rejNwMUlRUmRuTk9qZjZXbVhBbzBvUzhsSno2?=
 =?utf-8?B?a0ZJU2c5Ni9yU0t1MHpMd0I5aTcrUEhOZ1E5alRlL2wzd20yZk1ZZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H7GiIMQegltbQEDytcsDcilAzlpLxQjeEkmpZyEcjdeeJVpr9Quh54ML1B3pfGejRoxaczJ6ihyxJa8PoG5J46QMrfei9ogl6F7QLD8xNcLU0Vim8Skvp0Ry/qMfhjq03Hi4TsI68A3L0WPjGm8dD+lLBsO0jydGYRxoRQij0FHGAsqyVCYmDaZ2tIGG8kuSUFZGTDedhuxdV0RgL2Rg2z8iJeHSygtXiNKH4VNEGCAjo1UmkcoQ4Ldh0O9/66MxBI+tUf2gV6jKAE4ldOsWLnuODj0T9Sn6jnCrb2sRtxYdxVPy+GREAxvKvoYbBlzB6HjBCNcrFX5dmlKykYJnsl/HeL72EgPEf0vXqtfiwsWxkpnHtDYVp5Wg4jNLdvAODh4ecqfpRwKBMDN+dNU5yygUkxIi/3si2243BOLZu0N7wtlzQUGzQoCQ0cfwKBMgdIEABsuwrUhOKiQ7K/a0XSI6KOr7wLzbT87SOUGbE+7vPen5d9TLxUHvjXmKPYlP6iC9AvVQXbnNd7eNw7EPj3rhIEBzIh+n7VbaN+fqZj7xBFG8XRsytIJZv/kBtn9PKg9L8s/0aKbenxcSEhABVjr3sUH253wEd6QtoEUPgsU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac00029-82d2-4517-ed16-08de5522d875
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 17:15:28.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmdD6+lpwSxlkNn1vRCEgfmiiGy4uf81CN88CE2RgZz4RaqKZfqKN13QiLarE5l8fS1u46hT8C8mTw6ZM6GOHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF2A078470E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=966 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601160126
X-Proofpoint-ORIG-GUID: JZvEqFdZTPrNTSDxQwZJOCWYu8sbhE9Y
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=696a7235 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mk0nw1Wwslowqo8vS5gA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEyNSBTYWx0ZWRfX6cjc+7yDEDR/
 /XYIN5yt7ppYaqEqVM2F2fiWsCBNczHDHcxBtKw8FtyhKaLjBxv+wbuFTGjYA7n5BHcZZP0e0RD
 y7qwo4vyhF1iPvtn8edgfqEn6mcJ5/tWQIbPdlOGnxoa0jFGKGX8PCPriwqxhfk05ifLy0o9sOU
 fV9ObeY7AnB7YWQrCiL+8kLrQTwT2PWRV+5ppp4dCgh3PsQj05D475wbc4NqBwnx+bqIhMV9me2
 cB3WlZp8JpPBpGo220pWKkx159yVwhc3VVFdSbXS/ErLUg88BhHKbpD9C3sffbzCbzOTjdgae7a
 pOVf60MtW14m5V2X6eWPhEMCZEYKDMzymw9dD4n5n1Urik9j1lx7mx48d5/UOw74lbTN2lNg38b
 mILn332DiCG73e5naPG7ktnL1GIB93rPKdxmzN/VBqbqgWjIitUiy4lg1bDPqYpphuEGMUIH1l8
 Ql3/sBeXCGROMhdUcG+SOF7wKkCiSJH7lA1clk0o=
X-Proofpoint-GUID: JZvEqFdZTPrNTSDxQwZJOCWYu8sbhE9Y

Hi Chuck,

After the entry in the xarray was marked with XA_MARK_0, xa_insert
will not update the entry when nfsd4_block_get_device_info_scsi is
called again leaving the entry with XA_MARK_0.

When the server needs to fence the client again, since the entry
still has XA_MARK_0, it skips the fence operation.

-Dai
  


