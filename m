Return-Path: <linux-nfs+bounces-4404-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA991CDED
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 17:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFB01C20F83
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9982F8175E;
	Sat, 29 Jun 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RdaQVsbe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rw+PgaOh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675A1DFE8
	for <linux-nfs@vger.kernel.org>; Sat, 29 Jun 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675386; cv=fail; b=lIAtJDgz/B5RsqFBdr0r7mdn+EKBxt596avfkmbaErgtY+/6MTwTQAMskOWmvwGe87Zj9J/FaXDin2j/Pu5Wyx/a4WWgx1YXsmDY+180pE3ZFfdQxrap3UOvV6hbxZ5r5IwX3unsCtnl1yxnL8aWFqXcTNK3vSywDdESEXHgj5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675386; c=relaxed/simple;
	bh=wLusXjk7Ie1fKBwaPC3/rPuG0xYuH1s3+tNxa/ke9Gc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Biz7NftwfTx9+MWbvvo19ovVPQrguvXvQ1YzdGJNaHSs1AUpTZEWBxPrtJcKGNxTz9/jkrQU0W/0f9LsQMXnxcDNSZB4XTjTFnVj0/G7uyMNsoYLbbX8ovSGDWwCoRYpNRlS8VrX5puqALC4p8Fj7VHcrf0rpkeIVkz0Ehd1swA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RdaQVsbe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rw+PgaOh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45TFK2Em005086;
	Sat, 29 Jun 2024 15:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=wLusXjk7Ie1fKBwaPC3/rPuG0xYuH1s3+tNxa/ke9
	Gc=; b=RdaQVsbe6BmnGG8ZATYl0S1ru99816HfsVzZ4ucFgqBgtYAgr39VTqU6n
	ollBiDZwZsLZvp0n5MkALMBR19EUyWOagAbdWwZns/jKDLrPmHTbzTHfWdPeQtud
	xdAa2KeZrJ+zNUxSDGH5wV+g1eZgPhdnFhqlecfCDU6ZgR94MsW9exLLjwxPkwid
	9dRKGt+FtRIVF4XocqASmKgWMxPo3XgamANcCxHyLzhqmWEbqDYkTYZVHT1bX348
	0I+u1sJgmYd4cDeQG3ubgNAtp2YqiZ3l9K16Jy4bSYfByl1dFH5DuT4w139aBBtt
	prGZCzPEAJ9AO0YqSBA9cpE9pcC+g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a590epn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 15:36:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45TBQDuF016965;
	Sat, 29 Jun 2024 15:36:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbbs8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 15:36:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l67q/ZXgzqXQ92EMPAMU7gOUEndK52PLV0Q4JNeAPvjKD9K8AecH9PBSthAWbdFe4NpRz0me3vg53ewsQDPVsL4gIOu7xb36NCBuLFyL72vR6er1NCFAaFQjfyYM+G5TXo4dMUqFBJdR///q3RkWANFiuHUdMlx8IZA+cm7l6mlT/pqQeTy0bNkIUGqzhyhLjnIBl7mxqo9BCX4WndXsTGNg43SZby1gbSpwHYBYaZN4VgT5mY9HmT5M8EqUm4JI2e6dAsi3phpbeyUIcheygAq+uMRDCobZkgH3Wy8WJUCSucKlZZh4mALppwIbMvCm8u3+w1hxdu4IKfCxf/vx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLusXjk7Ie1fKBwaPC3/rPuG0xYuH1s3+tNxa/ke9Gc=;
 b=JOGBNMQE8O5vPDGqXggysbsMG7B1hFtGlIW4M6lpKO5kWxTjXrze7UG2ajeskO73Kj1CTxoUAuEo3TVfVjyOFoj5z/i0kylyQDqVmaB6I9O00yQuu9NDfZjsjL55cdCQKD3BgtWHxmRO9pm1Cu8nMXFPuns/KGE3pvC1GWc+TVAreW5pMIcxIMswjUdb10fdSnYT3oyAKQFBtZcaZE0t0rQp+Duu/bHPXrL6SdIfHG1E+tW64Bv4jc7Wyxkln0V1E4iiEhCJC6CugLSTBVJV7+9DQlAug81Bs1VQieZXCTTtVthuFxpHifJCL6XweL34bdUjR2uaEBOX0/6VerNfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLusXjk7Ie1fKBwaPC3/rPuG0xYuH1s3+tNxa/ke9Gc=;
 b=Rw+PgaOh9in72e3uFFrGl83zgw2Posb3dOAqhRgkcfaZ7W8VKxf8saaFN8x8zpEDYWz9/UhuvmeizCGs7vuX7XVh/CQX5wAxFLLvBUUEITG/q1IS6tjCylaTWr+UBP3bu5sHceBwzUFrXL3aShNCeElYzL6lb1nSZ+4dvgXiDf8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6588.namprd10.prod.outlook.com (2603:10b6:930:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sat, 29 Jun
 2024 15:36:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 15:36:10 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust
	<trondmy@hammerspace.com>, Neil Brown <neilb@suse.de>,
        "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v9 00/19] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v9 00/19] nfs/nfsd: add support for localio
Thread-Index: AQHayZ/N552rtzwru0Ghtm/oU3ZYQrHe4NgA
Date: Sat, 29 Jun 2024 15:36:10 +0000
Message-ID: <577D0632-FABE-4D16-93B9-4701C051B418@oracle.com>
References: <20240628211105.54736-1-snitzer@kernel.org>
In-Reply-To: <20240628211105.54736-1-snitzer@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6588:EE_
x-ms-office365-filtering-correlation-id: cd95fac3-8917-4275-c373-08dc985133b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TUxGUGs2TXA0WkVibTZ2b09WdURlSXA3Um1KWWpkejFxc1hVOHRSTm0xa2RY?=
 =?utf-8?B?SmwvTkhYbTlQczhsMk1hU05DZTlEcXdiU0pBUWJ6Z2x2TW1wUGc3SDNLcWZO?=
 =?utf-8?B?T0hSRlg1aGw0bUJhZmZvMkdJMDY5UjQ3bDd5TlJUM1JBcFMzWXZVWUg5QWRz?=
 =?utf-8?B?RXNmV1lHa0o0MGpiVVd4UzMrRFZLSUd0VU8wK3pwMk1wMW5VSGdMek1RaUd1?=
 =?utf-8?B?aG9ZK0pNM0kzKzM3aEtmTU5Ta21MSktHSHdOOXFGYlR0YlBvT3hKZnRLYU41?=
 =?utf-8?B?cWpJM25tODJLRzZNRVlYYlArZUc0b09pNXBXalA3bUFOanZTVkJIN0xuOHF5?=
 =?utf-8?B?U3R2NlNNOGNVcGlTNzJoRVlNRWdOcituUnFXNWl2dG1rVU9ZTFJ1Zk55UWE5?=
 =?utf-8?B?ZlNMNzdYdmIzTWpNQmduRTF3OHJZR0FkUlYzbjVKdGhXRVYxbzJGOXlmcVY5?=
 =?utf-8?B?YnFNcUF3VkVUamtidnh5VkF0QmRlaDExYms3dlV5L2Mxd3hnNFgyVTcwcjBB?=
 =?utf-8?B?aXZSd3lqdEsrMHJtczVrdHBxamt3YUtwTUFPcThiSW5xcjBOUTBxdDdHVVBH?=
 =?utf-8?B?RE5ZdEhFeEwyN1FOVElQSjlCQnBxckwxamVnVnlhRlBwd1kzSGtUekU0YnFP?=
 =?utf-8?B?S2dRTVZJRjJzUXAvNG9YYlRyZi94T01WK0g3OXpjQ25kS0RvMEpUVkZRMXBs?=
 =?utf-8?B?RjZPakRjWC80ZkRHUnZaQkJCeFduL0JoUUhPM00yWXk2NW94V0ZIQTdsbm9p?=
 =?utf-8?B?MWdsL2ZQS3FoYXhxV3JjbmZOQ0dMdWVldnpoMUhlYTQxQjF0SGJXb3ZqT2ZW?=
 =?utf-8?B?Rk94N3dkdzVHWitlV2FFWmVOeDM2M1BTSXBFdWo4NFJ5QU5Bb21RQ0FBc3Fl?=
 =?utf-8?B?K1dIeHRYYnF0SUpUdW1udFdnaHF3dXNCaHozRUpha3NHS0dzVHRmVk1vRUlo?=
 =?utf-8?B?bnN2RThnZFZocGU2S1pDQ2VUckM5VTAzL3RYaTlGZnQzL0cyNklrUXlsemUw?=
 =?utf-8?B?N3BlZUtOUE80c1ZQeHV6SzgraVNYcTVZSDhhUS90VDd6UXhXVGpSdTR1SDYy?=
 =?utf-8?B?ZllLT3JBTTQrMUFGbEdRb1FxRE1GRGtIbC9tNHVUQ2doV2ZER3dIQ3dEQlF4?=
 =?utf-8?B?dURPaGgrRklPekNwckJRTFZiL0JRRFNSeEhKazFRcUVYSWpiQ0ZxcUFDNjhu?=
 =?utf-8?B?SzJMdTlQT2FpczZQd3RsU3pkS0tiZVg4eThYVzBYTjkrbTdpcmE5VDc5VHo0?=
 =?utf-8?B?R2lWZEpKa3hUSTE3TFhjTzZDeGJhTnJEZ2RYLzNVL1dHOVlpZysvTEFvVXBR?=
 =?utf-8?B?L2svRXgxdEhMdTlEVkRFN1F3R0x6Q1A3aEprR2xZMzQzZ3ZXNjFBZjZtNkNS?=
 =?utf-8?B?VWlBeFVaSGNIaU8xUzZSVlh2WGRLdURZbFQ2VzFxSFkvYmU2U1ZkY1BhbGxO?=
 =?utf-8?B?Z0R5SWlRNHFzUHVXd2ovZUovcExLTXJHaEg4cHg4MXUwRmxVTEdaa3JOdWhZ?=
 =?utf-8?B?NmM4dUEzazVIWFVJck5RSi8vMXBwRnZPbzNFV0VsNm40L0RQdFlkbUVpVjYv?=
 =?utf-8?B?cVJ5WDhKMXBlWmdOMDBQTTBkd0lpdDMyYjBRaTRnM2VMR0F0SnlyNWVsSFo4?=
 =?utf-8?B?U2Y0RXgzVmRGVkRBbEtXeHJxNzdRRTdGUm1DeEZOU3VISkxIYjZHclAzeE42?=
 =?utf-8?B?V1h3S0RuaHRFM3E4aHRZTnE5OFF2bWZRejVXM0NMNmI5QzBEZGU2ZG5CMmsw?=
 =?utf-8?B?emo0OGxGQlAvWDZodlhsUUxQWHZkZU5WbXRFaHJLYkl2K1d1bXBwRUVFQVlv?=
 =?utf-8?B?SnJ1V1lHNTIvNExDMWNNQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M3drRTk2VjNhT0Q0Q1FSaXVWTjJLWTI0d3p5RSs0TUU1UXcwcWIveDRaV013?=
 =?utf-8?B?OUhja25nTEFLbFhDdEJSR3ZNOVZ2ckNoT0pqeTJpc0Zld1duVW5wNm55SGYr?=
 =?utf-8?B?Q3ZPc0lHQWxacU1EM1I1YWpoRUxhQm1nWXFjZ0VPN3l5OUh1SHltaWUxQzYx?=
 =?utf-8?B?MS9QVzg3RGhseFkzcllEM2hQekNxVGVzdlY1OXkzMUFqRVRvTTAxaGR0QTFy?=
 =?utf-8?B?cWIyK1RYVm9nVlJqbGFKVlQzUmoyNXpFZFZ3cmpVYk96VnlEU0drR3FvRnN5?=
 =?utf-8?B?dzN6Vk5LWG5sVkphaEVjV2ZwVitjMU1FZGZHTGZ0Z2c3ZjZFeDVVZ3M5cjBt?=
 =?utf-8?B?U1JTRUs1dmRVV3dHcHJQR1BhSG5UZlB4VVF3ME9teDR0Z0lBRm9UWjFpOWsy?=
 =?utf-8?B?UHpxdHlFMVVHYUxCL1I4dnJES0N1clllcU40TENma2VPRzl2aG5VV2dvaUtk?=
 =?utf-8?B?bEc2dk5vTmJCNTJMVGg3ejFuVDJ5d0xiK3dVS0tGN3RVVkxnMVcwNFU0WFdP?=
 =?utf-8?B?Q3lTSzdYV3owUmlYRnJHNzJxK0cxVFgvWG82QWVyQjJjcHdmdGlHRVNIcDli?=
 =?utf-8?B?aFRKeFdPbnY2empacFdxNjc5Rm83SzhxVjBoQTMzZTU1QnNoaGlBOG9iaUdq?=
 =?utf-8?B?QXY5TGF3NVIwemVyV05NdjBVblFhYkVBWExiUWNTNXVrYStHRFhOZUpnRTZh?=
 =?utf-8?B?aFlKU3Z0dUZvN0dCTHJlc0ZFNE9FZ2N5cXB4bERkcXFvNWlmN0EwYjNzZXEy?=
 =?utf-8?B?b3ltd3NUeWhqVEcxd1NER1hTTWhzc2MwYkZDRWpobUV3VVF4Q1Nwc3FJSmlI?=
 =?utf-8?B?bXlPNmZqZjVEeXpycGdpcHhmemFPTEFZc3o5dWlpR1plMmRXMFRVSTVabGg4?=
 =?utf-8?B?cUVvaHprdi93ZjFOd3d5OG40elRQLzM1Q0pPd1dpVllJcVc0bGhHL0lpeDc3?=
 =?utf-8?B?U3luVUFUUVNYTjZlMTIzOUs2di9DK2x2YzFjM0Z5VjY4dkRBVDRUOEpwNVFh?=
 =?utf-8?B?TnBtSWRjYzRLc2MvZE5rVFd0TmVVQU84SVd3WTN4Q1J6UXN2QStSN1E3cnRv?=
 =?utf-8?B?MzlEZnVqOWcxQ2lianFsbG9sVDUwM0ZRUXp4TjhYcGN3V0psdE81YmdNQ2w4?=
 =?utf-8?B?WEkxb1Q1cW9LUjk1T1MvN24zNnR3dWN0bVNGaStDVnp5QlhXRDNCVWhOQ2Yy?=
 =?utf-8?B?UVhveElnU3ZUSjRsUnUvdWZRbW8zeXNLWlJwZnphbGtwYnpHdkJKSnQvQ2Fn?=
 =?utf-8?B?aU83ajdnQ2RHN0Z4MzZqdEd0bEtOQnlGMWp0MGZNRHVubDBZVzNlcTNYQmY4?=
 =?utf-8?B?Uk00M3lvN3Z3M2xzdFhodTJ2cTNiTkF5N205Vnp6TGFEV0twUGh6QTJMdkVr?=
 =?utf-8?B?ejA4V3NrbnNKRXRsem9xSVUxYkZPckJoV2dZNDZpQXQzeU1tcHpROVQwblh5?=
 =?utf-8?B?Q3A2MmJGbmJiQjMwRFg5eHVVT2x5Y0hZWnBhaGRjZm1FYzE0Tm9UODJxRDZy?=
 =?utf-8?B?bG5NZm1jbnBVV1VpSCtCOG5LNXhNNnVsTWpjYmtzdXpYeHRycDkwV1d4bUdr?=
 =?utf-8?B?ak1maTlXV2RaeDg5L1lkNzBWQVE3Q1dQOG13dzkzSlhWZHE0eHJmM2RiQStS?=
 =?utf-8?B?eW15TFh6ckY5YWxwZk5aVnN3NENKUUo2bktxQW04Y2J4MnlSaXpxdENMSUlX?=
 =?utf-8?B?VzIxVEsycjBNeTdXbSsvTURqZW9xSXVUakhhQzU0Qmg1N09uemNudkNDblls?=
 =?utf-8?B?Mk5mRWxtTGUyVm10a2NxbDE2ekl4WnJ6cDFxOStOL2J1NDRQRlgxSTlLUitK?=
 =?utf-8?B?ajFlSHdGdmVIcnNPdmdRVmpZSVFjOU9KS0tnY2EyeW5tdmI1VVlrZkpVZktE?=
 =?utf-8?B?bEhFakw5dmlWTmhXNHkvQ1NXclNtVUxyb3NCU0JjT2IwSEUzQmtSc0FGcDE4?=
 =?utf-8?B?OEFMNjlUNzRtdXdMcUllL3FTVHEvcGszb1NlcFV5aVJ6Y3ZYWU9uSjE5eVha?=
 =?utf-8?B?dTJoVENWK2hHcVh4bEJoZXlZbjJhYTJiVmNJalVYeXpSRUNkWFZ1aEJLZy9v?=
 =?utf-8?B?R2hSTGR4Z2h1MVlqb2tqQTQ1VXF6ME5aK0dPNGYxL3Y4VlBSN0xaNHRsZ2ht?=
 =?utf-8?B?YlJXNlBSZzRSN1RmSXJodjNQMXM2VmZNbnd6MlJYK0I3V1B6b0Y1K0xYbWh3?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77B2EA2AC11063479EB1C9C31D197ED3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kd6T0bHd3+xKCGTKWWkTHgIuVgrwFHMkuuHeJ42pM2DgTaUvRKIybZuPqms+9YWvn6g6VD8JnMGDqxswoy8xYlwPghLfjkwIzqv0anGj91i+ja4DeSW722iv/uPAT04sITQFP9D33p9MGcDzCWGtr02KhMNBygsYMJI/4HaM9VLJVgxDAJTR296y6E9P6NkODIXs14wNx/orHcq6Nwt4wO7x9YJ2PPLLjcgGHD9N+1o2vYO6nkkukZJwkUcRtX42/iYCm7Vw+0ZuS9DVDdn5zLKk8sDg4n1ih//bhE7ZsW7qItdbgF22A/AYEQNiXjzt4CzcOATv/PlStH63mLZi/KqSA0EWvbCNP2zHiIt9MDVspeVA419Fy1E0IdBwGNJe8hcf+P0HGx0QO7bzf2KNNcmvTa0/mY5i2cnf4iCkUb5hWM9ueSIsMkjrVhFozyq6ODxDbWNnp/9Qdu+8RyyMbA/HhuutLuA4HrqPMoKOatdIlJf8W/MVPp3uU2EAOhTjcx7Wywyv2/pawxDYOg3pcNIjX2jJWehgCXImKWwqicgWqiONo+3ldlz93GFHeEv5w/38Cj/QMKqZuBZI530Trjhc0bAY3pesj0HabvDqHNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd95fac3-8917-4275-c373-08dc985133b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2024 15:36:10.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvwyYnjX2I4xkYPeQXmKhmvKmYgArtJDF8UJjKy5FaPPmnmIgqj1fh4f91mH7d0txR4msmpv4211O40CbmjK8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_05,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406290110
X-Proofpoint-GUID: DjyG5Dh4qFeOlVJg7U7x4jDIsdwR2D61
X-Proofpoint-ORIG-GUID: DjyG5Dh4qFeOlVJg7U7x4jDIsdwR2D61

DQoNCj4gT24gSnVuIDI4LCAyMDI0LCBhdCA1OjEw4oCvUE0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gSSdkIHByZWZlciB0byBzZWUg
dGhlc2UgY2hhbmdlcyBsYW5kIHVwc3RyZWFtIGZvciA2LjExIGlmIHBvc3NpYmxlLg0KPiBUaGV5
IGFyZSBhZGVxdWF0ZWx5IEtjb25maWcnZCB0byBjZXJ0YWlubHkgcG9zZSBubyByaXNrIGlmIGRp
c2FibGVkLg0KPiBBbmQgZXZlbiBpZiBsb2NhbGlvIGVuYWJsZWQgaXQgaGFzIHByb3ZlbiB0byB3
b3JrIHdlbGwgd2l0aCBpbmNyZWFzZWQNCj4gdGVzdGluZy4NCg0KQ2FuIHYxMCBzcGxpdCB0aGlz
IHNlcmllcyBpbnRvIGFuIE5GUyBjbGllbnQgcGFydCBhbmQgYW4gTkZTDQpzZXJ2ZXIgcGFydD8g
SSB3aWxsIG5lZWQgdG8gZ2V0IHRoZSBORlNEIGNoYW5nZXMgaW50byBuZnNkLW5leHQNCmluIHRo
ZSBuZXh0IHdlZWsgb3Igc28gdG8gbGFuZCBpbiB2Ni4xMS4NCg0KDQo+IFdvcmtlZCB3aXRoIEtl
bnQgT3ZlcnN0cmVldCB0byBlbmFibGUgdGVzdGluZyBpbnRlZ3JhdGlvbiB3aXRoIGt0ZXN0DQo+
IHJ1bm5pbmcgeGZzdGVzdHMsIHRoZSBkYXNoYm9hcmQgaXMgaGVyZToNCj4gaHR0cHM6Ly9ldmls
cGllcGlyYXRlLm9yZy9+dGVzdGRhc2hib2FyZC9jaT9icmFuY2g9c25pdG0tbmZzDQo+IChpdCBp
cyBydW5uaW5nIHdheSBtb3JlIHhmc3Rlc3RzIHRlc3RzIHRoYW4gaXMgdXN1YWwgZm9yIG5mcywg
d291bGQgYmUNCj4gZ29vZCB0byByZWNvbmNpbGUgdGhhdCB3aXRoIHRoZSBsaXN0aW5nIHByb3Zp
ZGVkIGhlcmU6DQo+IGh0dHBzOi8vd2lraS5saW51eC1uZnMub3JnL3dpa2kvaW5kZXgucGhwL1hm
c3Rlc3RzICkNCg0KQWN0dWFsbHksIHdlJ3JlIHVzaW5nIGtkZXZvcHMgZm9yIE5GU0QgQ0kgdGVz
dGluZy4gQW55IHBvc3NpYmlsaXR5DQp0aGF0IHdlIGNhbiBnZXQgc29tZSBoZWxwIHNldHRpbmcg
dGhhdCB1cD8gKEl0IHJ1bnMgeGZzdGVzdHMgYW5kDQpzZXZlcmFsIG90aGVyIHdvcmtmbG93cyku
DQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

