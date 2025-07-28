Return-Path: <linux-nfs+bounces-13281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1CB13612
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 10:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DF518988C7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 08:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63DD21D5B5;
	Mon, 28 Jul 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P9ptrwub";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PJFtEgQz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030D2E36E6
	for <linux-nfs@vger.kernel.org>; Mon, 28 Jul 2025 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690075; cv=fail; b=CPddpboJzx5II+ELchI1FUGdMIiAWX7AVzHc6MS2cl2mfIbaCO0MrtXbjrB/VsSsHFFIOFZQQdiZj0q3lKHQs9Dp4vDENisNkM1TQLilM54T+A0Tv7UPX8qch0Zor5E7GlV+qEdAlUNDxyqrFRZubCrJGtXhJTs0El0rAmn8FYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690075; c=relaxed/simple;
	bh=clxBCXJFbyd53I2PpFoX91pMLBP1/55bwD7JLfocKPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h2PdD5JGqYETBKG6WGRVL8msb6aGhTZlWXeGHuErjGkSntqtztMOD4wp542YaSlHz66XfG3azAgQUaiDspPpzp1vSjKVw77lEGFkP0hBJxwNCOHH7wjpAbiPEYMWmkJGUVXWMNkcyuyLWPKPhT+qAR9zzJhG/Hy3Ggk4bRf6EKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P9ptrwub; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PJFtEgQz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S7g65J027184;
	Mon, 28 Jul 2025 08:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PTEAO+HzEA6Ihw5OT4tZK3RuGq/OLa5Hgzkd0Qk+UTk=; b=
	P9ptrwubjIymbklUmN3YqoKdm443iLz+Dqt7aQLWs3eQAZm84vYduNgSmTe71Fbi
	QXFgyn2dgqvVtyYjiNCH7eez5fhmFHF0Jm1enCY4dpQb3iYuFosqkuwnKo6nlTp3
	8PO1Kr6Os+03LA/txvNRPJtNepaSkFaB3NhpdYOwivAxUGiD2NmrxTztk0yyI6ko
	j9qaaLiD9g+JPvWel03c+r3L43fbFstexClM+AYDkp06DAOp8yggE4WEjqR3EkTS
	ln6TyqQ7elAlw2eicBZBBSPb/3PHUwyYdqtsDzrfAH580ZGnDehUHXX4+5dPfyjm
	rumgqwOhn4wzajPLMm87xQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wjmpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 08:07:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56S756Tm034491;
	Mon, 28 Jul 2025 08:07:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf8f2q8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 08:07:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9SZ634AlBzTmcxgQqdGM78b/LRuqvIpesohRsTuGp9zzMAENVDeHx2o+ljhRuI0KpUgtpqj3IVqNDDLcMAugHiJywQiz0iFCNVY4yhTQuNSZeBGNeYgwE1O4h/TxrarbYQ6YnqElDn602TlQkXJloOstiZXZG1j340jX2/R6UKBG2HvN6PyCdeEzzg4S/VMTkEPWATtVjHmB6O33KUYix38F84UL7n683BZwEDMNflWzOwbxiZFPlRwJiWjVKfKDx65nipaPz3p5NYGGu0MaujCBN6zUbnltWNmIMJRy7NbsX0/Qp9fM0nQwojdBqM3VvrZTi9p9LKtyX3Z+K9pFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTEAO+HzEA6Ihw5OT4tZK3RuGq/OLa5Hgzkd0Qk+UTk=;
 b=WnxggAKbgRoicxBnXPxcaHDfKVW93mJUdw/+7PmAr3sPo5NVoUSep9/eONeu2IOv9kBKrAztpP5mS5mmItbl29USv0sXFrfREzfLdJrfmlqERiY9UEA9VEYZOWePf4om4h1HbPLrupq1KHbmR5/SWPQAJTA1VUkB/UeIdPDo3OFqZ7YZn/oEhuSSmmELxaX92hw3xXdKWPdTbFM9L8zhDaMFad0Nz90La9i1WPrxQkQKK8L9j9K0cgXctxMszE7M0/P3sdSlMsMBssE/fqP0t0o7BvUx9dVTDhuhX+VYS9d/LX7HaICXDDsnotaj1QHZ0/qHUXMTOcrRjKBsdhFrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTEAO+HzEA6Ihw5OT4tZK3RuGq/OLa5Hgzkd0Qk+UTk=;
 b=PJFtEgQzlxsMbC9otwQpSwX9mP4YfYpDMzlQjFzHhw6CS4Qof8Ly4eGzUBTa5SUhoMNXY4psCgwWUgbHTRlbV8U2F5nLFIuf3Dp7+qUq8M2hB2mBruOYAgg/U/bm3oHqUwo5a1sLMqfIP5N4NtE5HnzmJf0SYtWAMSeS8cTHbSA=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by SJ0PR10MB5664.namprd10.prod.outlook.com (2603:10b6:a03:3e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 08:07:26 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 08:07:26 +0000
Message-ID: <b0393ddb-fca7-48b9-832f-ed17ccec1f19@oracle.com>
Date: Mon, 28 Jul 2025 13:37:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
To: NeilBrown <neil@brown.name>
Cc: Mark Brown <broonie@kernel.org>, trondmy@kernel.org,
        linux-nfs@vger.kernel.org, Aishwarya.TCV@arm.com, ltp@lists.linux.it,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>
References: <> <c5d1eb2b-2697-4413-983c-0650eab389e9@oracle.com>
 <175359184844.2234665.17719114991555307336@noble.neil.brown.name>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <175359184844.2234665.17719114991555307336@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|SJ0PR10MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f79fd5-7797-47c6-ca2b-08ddcdadca1a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V2FpOTZvQllTZ2ZVQk1qVExERHhDbzRxVlJmTFpUU1BLRDhBVmNjT3o3ZHpG?=
 =?utf-8?B?Y015aG56WDExVmlsNnM4Mmw5c0JBZHkreWNFc3YxVEw4WDlEdW1JYU9MSlcr?=
 =?utf-8?B?ZEMwS3AxRzJVZS9RTWFwQlljbkxKRGRNNW1vazcwRm1hWjV3U1JTaVh4SS9J?=
 =?utf-8?B?L05JUWpCb2hGYjIxa1FDUFdFNjB5QXUzSFlPNzdWdDZCeGNhT3VzTHd1ZGFI?=
 =?utf-8?B?VWxXTWc4cTBTQjJwck9LTGVVQ1pHTjRMbDdoci92TlBDNlFaN3pvWXFOMWdY?=
 =?utf-8?B?TnM5bGtNZU9nRDhvdk1rYWYzRnFRa2h1MURyeVdBd09GemFRaVJuOG1IRUJW?=
 =?utf-8?B?Qk5ZaDZWYW9yVVpSdmVFdnZkVHN5aHVlTEQxZ3A2Mk9rMExWQmUxNEJPRURG?=
 =?utf-8?B?R3JZYmNZWmVJMjdBV3NPc09zL0I5VGcvN0svWnl1WXEvc1F6dVlLSzdLSWhp?=
 =?utf-8?B?enRWN2VDcTNFZ1hKdUpKTnpId2V2QnNFR2lFblpSQ3Y3dldiZTdYMHFmVjVk?=
 =?utf-8?B?SEtTREJ0SWNHMlU4cjFqQmp3Sm9seEp6ZjJZdE84ZUlTUjZKUzRkZjVEOGpr?=
 =?utf-8?B?QXJwMlZpR1hmVThmWFl2eFZlQWE0TGt0OXpQcSs0Z2M0UVJaSG9MVGFPRm1y?=
 =?utf-8?B?RjN6bVgwdzNCYVlibloxR255Y2NVQmlQeXVDTGltQVgvQkQxdVhjSVlKMWFG?=
 =?utf-8?B?a3hZYmQvZVFjR3hHeVkyV3h4OUZMMmlIY2g5Z2I4YW1aTGVvYkpwWlBzdUdV?=
 =?utf-8?B?SHJqV2MxSzN0TnFaQ2xuVnpkRDJKK3RPRFRuVXY0WnBzSnFhQXc3N3hOeEtQ?=
 =?utf-8?B?T0F1a1ZWZVJueUIzV2hlUFV2M3BIeUZRaFZBcDN4dDMzdG9JR0M1ZTNsbGlr?=
 =?utf-8?B?ZFhyY3ZiS3FZcUFybG1heTFYQWtGSHdvcVIvR1BoVHY5ZHJ0UE1iOTBuSG56?=
 =?utf-8?B?bFl6VENLanR3SHVuTWxkRkRrNGkzME9sOFhDQWIwUEhXY2x6aURKY1BzL1BM?=
 =?utf-8?B?bDdTWk0rdWlCVTl2eUdRb1N4SVFyN3NPQ0o0dDJvZTVNZmhZRWdNVVo2UTdC?=
 =?utf-8?B?MmpwQWd5UDNTUUYrOVp5NS9iK1hrK2s2NzIva2dxY2UvWmNsdnJZRkhGbGY0?=
 =?utf-8?B?ajdCKzZYT2x3YUt4bThBTk00bEttMmVUOFZqZEM5ampEaFN0NC9rVTFmd1NB?=
 =?utf-8?B?WUZJSlJ4SlpIbkR5YW03UkRRQWN5OENNOXB1bXEzMUNsYU5VRE9EcmNrcyt4?=
 =?utf-8?B?VE54bllXRm8ybGtIM2JCcXpEUjY0Z2hmRmcxcml4OTJsL0E2ckw2VUNodkIr?=
 =?utf-8?B?NDNRVzlMU2dWOE92QkkzcmN2ck43VXZMMG5vc0k0N2hVZEVGeS9DZU1pS0Vp?=
 =?utf-8?B?UTVmekRTOUYrSitzcW9tRVpyMHI3NC8xVmFrb3dZc2xTRTJ3eGU0c25HYXJY?=
 =?utf-8?B?M0w4WWkxa3ByUEJESWJFeVVJYTZSMmxBdHdiUkU3dTRBY3Azc0tzdEY5eU5m?=
 =?utf-8?B?NkhYOUx5Mnpmck1RV1lPQjZVc3lFaEUwckt3Vzd0UFR0NmhxS0V3SmhKSG9M?=
 =?utf-8?B?VWlUVlUwcDVvYVdaZkdDMS80aVZPUXAvUXB4RUZjWUNRYXh0a3k5QS92cVVx?=
 =?utf-8?B?cDNqRE9QL2F0U0NGT3U2QkNldWVIcmRoRU5ScDB1bHJyOVlicC9LeHUyeXNk?=
 =?utf-8?B?RXZlZFU3Q1g2MEUwZjlqU2RxN1M4b3BwZ2s2NnhyZUZxTktmVEhBNFdaWDVD?=
 =?utf-8?B?UlFGaTYxS3NXcXJTZG9nRndNZ205U01XYmovNERVM0J2bjNsK3Q2bFZ1Um5w?=
 =?utf-8?B?TDYxNlprREV6OGt1UkZDV2d5QlJzWU45SDREL1B5a204R2xkMGxPUzN6bS9E?=
 =?utf-8?B?cTNFS3VoSncyM1JlaThya3pHUnZBeU9OUEhVL0V5a1NzT0FQRWpFS3k3dVdD?=
 =?utf-8?Q?nXbNDWQSyBY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RDFMYlIvazE4ZXUwZ0NMVWNjYmZ6dmpLZUZFS0ZGbU1PblIreU5STExKSnVv?=
 =?utf-8?B?WW0vUUhnWUxqZEp2WGJoRDNRZ2N2N1poSHpDU3BLaE90OFNybFQ1TWo0UlAz?=
 =?utf-8?B?eE9kVmlUaDZnbkFNUjB6S3dqOGd4ck1GVGk1cEhRdFpkbzYvbUFNMmhUY1dT?=
 =?utf-8?B?d3ZCa0RYZGpseERMbHBGdjkxR1U0NWU2V0tkVVhtaXcyVGN5MVlTWHNBVkw3?=
 =?utf-8?B?bWdTczZFRjBka2RVSU9DYlVaL2UrVWRwblhBSWlnTVdkandqcmdRQlJvQTBV?=
 =?utf-8?B?V1I0UnkzaUlKcnJTQngzS2htRnI2Y21XWGpXc2lWV0k2ZUR4enhBcUZNK3d3?=
 =?utf-8?B?NnJnQXpnZGd0YWVvUnp2U1pNUEFmK2p5dWJyS09McEhGK3F3LzlNdk9vaitJ?=
 =?utf-8?B?NTFxVjhLdWt6N1U5VU1RTTZrRXFuTHR0OGlEdWpCVXFBSklnYjRPNm80VGZY?=
 =?utf-8?B?aHZRMjhpV0dtS2VPcUtJVVpTc1dQd0htZHJ1T0FvZDNQRzFycVdEdy9URUk4?=
 =?utf-8?B?cVNkekwwWXhmUXVBVEJKMWVXUElVaE5veFl2YTQrdHRJbDFKTEI2ZTJKTDEw?=
 =?utf-8?B?emZFNFVYMWkwTERPZzJCampsVVhRWFhSRGhBeitRTjUyOEpJVmlzNGgvNTBH?=
 =?utf-8?B?dXN5czd1U1I5YjdVSWhmKzAyV2NJWWpJbG9lVWVFd3JRSTcxMlg3U2xaTUpJ?=
 =?utf-8?B?SVFLaTdkck5vTW5rMU9UTjZ1UnVhZjJyQ09ROEJtV1ROSk41d0JPMnIyOS9h?=
 =?utf-8?B?MElvZlZyZkVPbDNLc01pYWNEQ1ZuRkJHZTcwOTBhN1BEMTJrVk1maENzMC9P?=
 =?utf-8?B?OXdSeHZQQ3VQVHh1MUJUNkNxaXVveUoxMVdtcFdqdk1mdzhwc0xKOXVXTG9U?=
 =?utf-8?B?N0hrcGlJY2tIMEp3dlB4czJtM0QxT3BoRy8weklsenRYZWdnSHBUQ3JiRnJq?=
 =?utf-8?B?U1ZnemZYWjNzWkVCbkcwdkw5TGc4NnhXa3VJSW53RnU2eWFQMG5VUlhwdHFB?=
 =?utf-8?B?SnI2TnYxak9IZ2Y1S0xSMjFsekRQSjBJakZJa3hmcnVzQnljUmN2aXcyNDZk?=
 =?utf-8?B?a3Rxd2N6dnlQckJJVUVlVVBaQk1PbXZUVW5neHN6anRvamhPTmxjaVZ0dTk5?=
 =?utf-8?B?MzBENEVwanVxZWhXcGw2T0wrTDBrVU5Oa0Nyd09SSHZ5WnVzRGNtcGgzdmpK?=
 =?utf-8?B?RUJYTWthR0J6b3M2RktOMWVBZEZLejlCRVhWK3FEUUpxV0hlRUFIWktXQWhu?=
 =?utf-8?B?MHp3WTEzVHpPVWR6MUFYRnA1ODNTUktaZEdRd3VLQml6MEk3K0RjRHpFcjEr?=
 =?utf-8?B?Wk1DajFRZ3hENHVTQ3dwMk5UUlQxZGFUNzJ0QmRWSWVNRG9MUzROUWdCc2x1?=
 =?utf-8?B?N0lKYVVQUnZSTkJBSjdmUXlFd0p1Ym5Kbi9zc1RBdjVERmRvekcwOGNtMy9D?=
 =?utf-8?B?NSt5Y05MZmkyeXcrSksrbkFBVVlJS1ROQVJ4Z3NITlNCdzJvSTlSOU1pcDRF?=
 =?utf-8?B?c0RRWlJLYUFycmJRS2VIQWcwamVWc1M4a0hkdWt1ZmlJb3E5WDVxeCtRaEp3?=
 =?utf-8?B?ZkExOHlkLzM0MHVKM0cyclk3RjhBUEpWR1lCTHFLM3RPZTdveHZRQ3haajcw?=
 =?utf-8?B?VjNUVVhMZFBCUTFiSE1JNm5hbUFNT0tySlI3b1NYaXlXOHlJTlBBbkErb0d3?=
 =?utf-8?B?dExpS21XYXBUUkNOam5NejlJMVdUMGt6d2x1TWpna3ltYXI0TEZZZ24rUG9W?=
 =?utf-8?B?L0JRK29ib21YcWMzdWc4U2JFSUtlYXk5aC9jbDVTSWxtMG91NkYzRCtkUGdD?=
 =?utf-8?B?VHVhRWZQTGlhL09pUGc5R1pWaitZT2ZwdzBwQXhnSEI2dmFDU1daWlMzZjNJ?=
 =?utf-8?B?cG5SMUcrakYybnB3S1hqemJmOVEwVFA1YnpmSzZjb2xRVzFDVUQzaWZNQkxs?=
 =?utf-8?B?N2RaQjdlaXY2d09wdEpxYnhXWUxJZlFjcTFNUjlHTE9OYjh5YVhENU5Xa2dU?=
 =?utf-8?B?ZkxnbEh1ZkVXSUJ1dkRTYjlVYW1GVkVGYXRDMlY1K1FyTkhRTEdZdjdhNnB1?=
 =?utf-8?B?cjRSV1VLaDBEWFZ0WkNxQWorZDNveWd1R045R0QxNDFvLzJwTVR0WXUyejA2?=
 =?utf-8?B?M3JiTXZ0cjk5R1kvZGxBVGtJbGx1VkdiKzdsU2d3T1o2bmtPM2d0U2FrUjJv?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6EE6VB8ySTLthAhTwBqiWKf7hMpAx65aovm3YV6ytKHuKONuX8oar+prFFgZ4kasQHdzjBFcCVudIqchKoSWK5tPoGW8b13cKNEtjyj8CbJrJh9/3+4WxUgKiq8yNhFjjsU96lc9EAYtU0PXL3gKJ7jXopk784JaFddZo+E4yuzhhxBK49MjdraEjjrD4HezYClNjlTFCPPoNAg8sqhDN1x6XJFg1rZR6IrFIuMDxeSwWnaSRk3hoziFquTkn6ufMYr1yvIhu/V5HsLUyfDhOHAXUFPSWzdnMB8jfidtcbcGfrEkV/vrxMw6Ct2tLklHLI/QfJPrnbi5OGxLGpA5xjGul6WCx9bousw8t3m7fMUP6tPbbK+MbBGyANCnY1F0Jyjt5EHxCIic2PssNBgjwcHXkBopmW0Zf2lWG0Z83iFx/s4wd03XL1plzuH5gfLPssoDcZ1cPCAyAulf47A5D2z7mN6IFNrW/XHBVhz6mA6HPLJlGxWIAT4T+t/8zNvLlJ6PnjIkjrZbbFgOwoX0jsttXDlvaHT0USduHYUEY/xgBWLMsw+HrKckPnv7ZCnvJk04/nifZCiuOfm6iMFZLjolsSwJdfmYJPCOwu4Ayz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f79fd5-7797-47c6-ca2b-08ddcdadca1a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 08:07:26.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nx2sp9SBSI7KxWaUKb9hfgsNCcI+WRnkjhPaI98v3zI+jhZpuWKb7pcAi4iu+AUDjfHXo3GGAWsQO6+Bw3wnmIx1hh+OHAl/fOgmv9IOew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5664
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507280059
X-Proofpoint-ORIG-GUID: fTy66t71C-m4OX53vkOMsNx_T_7zArC1
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=68872fc3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=SEtKQCMJAAAA:8 a=5jrjlxtd499gjKm0tpEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA1OSBTYWx0ZWRfXwEbRRs6S8p/6
 0B2w5oP+TUA/Btvk4nv2QQwdNceED7ZIAGeqZCYwUTHhoss2OdPe8328dnk8yov+ExMDPuCa3EJ
 bS5n4U9RXkTRMlXjL7r2Z2ZYqHFs9pnt1eGhizaF8+ASQdOPp24fFbZJJ6bSwuPEPg2JnZUFJ+E
 G/UI6s4at1DvDne3Bg+J39Oc36DAt6wbJG20l/RQ3gQZax33iBVFnIyrE3Bd8ST9dS2GmABv9S9
 rJjFp9T3mCH5wDeNicwRG2C4lfP1yEsb26YtYHo2U09iRQkJPHRqeSxRBdl+/cn66q/kHlEKs0X
 Nc/UWGWYOQwVGSe9L1rkQ/PhNSZM2UU/dBrCsS6oF13cp7oWGkz6giFQ+41UzaJWqgYw44y7GA7
 JSpXeHF+CewqrxSDK1BHTRZ9TvABfE3OHWiWDsBCLT2H6rk8oZWzPh1zh4ydgigot6XUHRmd
X-Proofpoint-GUID: fTy66t71C-m4OX53vkOMsNx_T_7zArC1


On 27/07/25 10:20 AM, NeilBrown wrote:
> On Fri, 25 Jul 2025, Harshvardhan Jha wrote:
>> On 23/07/25 1:37 PM, NeilBrown wrote:
>>> On Wed, 23 Jul 2025, Harshvardhan Jha wrote:
>>>> On 08/04/25 4:01 PM, Mark Brown wrote:
>>>>> On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>
>>>>>> Once a task calls exit_signals() it can no longer be signalled. So do
>>>>>> not allow it to do killable waits.
>>>>> We're seeing the LTP acct02 test failing in kernels with this patch
>>>>> applied, testing on systems with NFS root filesystems:
>>>>>
>>>>> 10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-1-g60fe84aaf
>>>>> 10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1 #1 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
>>>>> 10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>>>>> 10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per run is 0h 01m 30s
>>>>> 10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>>>>> 10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
>>>>> 10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct acct_v3'
>>>>> 10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
>>>>> 10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
>>>>> 10280 05:03:10.064653  acct02.c:193: TINFO: == entry 1 ==
>>>>> 10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm != 'acct02_helper' ('acct02')
>>>>> 10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode != 32768 (0)
>>>>> 10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid != 2466 (2461)
>>> It seems that the acct02 process got logged..
>>> Maybe the vfork attempt (trying to run acct02_helper) got half way an
>>> aborted.
>>> It got far enough that accounting got interested.
>>> It didn't get far enough to update the ppid.
>>> I'd be surprised if that were even possible....
>>>
>>> If you would like to help debug this, changing the
>>>
>>> +       if (unlikely(current->flags & PF_EXITING))
>>>
>>> to
>>>
>>> +       if (unlikely(WARN_ON(current->flags & PF_EXITING)))
>>>
>>> would provide stack traces so we can wee where -EINTR is actually being
>>> returned.  That should provide some hints.
>>>
>>> NeilBrown
>> Hi Neil,
>>
>> Upon this addition I got this in the logs
> Thanks for testing.  Was there anything new in the kernel logs?  I was
> expecting a WARNING message followed by a "Call Trace".
>
> If there wasn't, then this patch cannot have caused the problem.
> If there was, then I need to see it.
>
> Thanks,
> NeilBrown

This is what the dmesg contains:

[  678.814887] LTP: starting acct02
[  679.831232] ------------[ cut here ]------------
[  679.833500] WARNING: CPU: 6 PID: 88930 at net/sunrpc/sched.c:279
rpc_wait_bit_killable+0x76/0x90 [sunrpc]
[  679.837308] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs
netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd
grace loop nft_redir ipt_REJECT xt_comment xt_owner nft_compat
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib rfkill nft_reject_inet
nf_reject_
ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 ip_set cuse vfat fat intel_rapl_msr
intel_rapl_common kvm_amd ccp kvm drm_shmem_helper irqbypass i2c_piix4
drm_kms_helper pcspkr pvpanic_mmio i2c_smbus pvpanic drm fuse xfs
crc32c_generic
 nvme_tcp nvme_fabrics nvme_core nvme_keyring nvme_auth sd_mod
virtio_net sg net_failover virtio_scsi failover ata_generic pata_acpi
ata_piix ghash_clmulni_intel libata sha512_ssse3 virtio_pci sha256_ssse3
virtio_pci_legacy_dev sha1_ssse3 virtio_pci_modern_dev serio_raw
dm_multipath btrfs
 blake2b_generic xor zstd_compress raid6_pq sunrpc dm_mirror
dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls
cxgb3i cxgb3 mdio libcxgbi libcxgb
[  679.837524]  qla4xxx iscsi_tcp libiscsi_tcp libiscsi
scsi_transport_iscsi iscsi_ibft iscsi_boot_sysfs qemu_fw_cfg aesni_intel
crypto_simd cryptd [last unloaded: kheaders]
[  679.873316] CPU: 6 UID: 0 PID: 88930 Comm: acct02_helper Kdump:
loaded Not tainted 6.15.8-1.el9.rc2.x86_64 #1 PREEMPT(voluntary)
[  679.877769] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.6.4 02/27/2023
[  679.880782] RIP: 0010:rpc_wait_bit_killable+0x76/0x90 [sunrpc]
[  679.883189] Code: 01 b8 00 fe ff ff 75 d5 48 8b 85 48 0d 00 00 5b 5d
48 c1 e8 08 83 e0 01 f7 d8 19 c0 25 00 fe ff ff 31 d2 31 f6 e9 8a e6 c4
d4 <0f> 0b b8 fc ff ff ff 5b 5d 31 d2 31 f6 e9 78 e6 c4 d4 0f 1f 84 00
[  679.889976] RSP: 0018:ffffaf47811a7770 EFLAGS: 00010202
[  679.892196] RAX: ffff97be48e00330 RBX: ffffaf47811a77c0 RCX:
0000000000000000
[  679.894978] RDX: 0000000000000001 RSI: 0000000000002102 RDI:
ffffaf47811a77c0
[  679.897786] RBP: ffff97be61588000 R08: 0000000000000000 R09:
0000000000000000
[  679.900600] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000002102
[  679.903432] R13: ffffffff96408ea0 R14: ffffaf47811a77d8 R15:
ffffffffc07568e0
[  679.906233] FS:  00007fc2563f8600(0000) GS:ffff97c5c890f000(0000)
knlGS:0000000000000000
[  679.909289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  679.911736] CR2: 00007fc2561fba70 CR3: 00000003bce3a000 CR4:
00000000003506f0
[  679.914555] Call Trace:
[  679.915918]  <TASK>
[  679.917215]  __wait_on_bit+0x31/0xa0
[  679.918932]  out_of_line_wait_on_bit+0x93/0xc0
[  679.920914]  ? __pfx_wake_bit_function+0x10/0x10
[  679.922944]  __rpc_execute+0x109/0x310 [sunrpc]
[  679.925024]  rpc_execute+0x137/0x160 [sunrpc]
[  679.927020]  rpc_run_task+0x107/0x170 [sunrpc]
[  679.929032]  nfs4_call_sync_sequence+0x74/0xc0 [nfsv4]
[  679.931319]  _nfs4_proc_statfs+0xc7/0x100 [nfsv4]
[  679.933520]  ? srso_return_thunk+0x5/0x5f
[  679.935391]  nfs4_proc_statfs+0x6b/0xb0 [nfsv4]
[  679.937367]  nfs_statfs+0x7e/0x1e0 [nfs]
[  679.939138]  statfs_by_dentry+0x67/0xa0
[  679.940887]  vfs_statfs+0x1c/0x40
[  679.942596]  check_free_space+0x71/0x110
[  679.944433]  acct_write_process+0x45/0x180
[  679.946313]  acct_process+0xff/0x180
[  679.948003]  do_exit+0x216/0x480
[  679.949799]  ? srso_return_thunk+0x5/0x5f
[  679.951621]  do_group_exit+0x30/0x80
[  679.953329]  __x64_sys_exit_group+0x18/0x20
[  679.955217]  x64_sys_call+0xfdb/0x14f0
[  679.956971]  do_syscall_64+0x82/0x7a0
[  679.958717]  ? srso_return_thunk+0x5/0x5f
[  679.960550]  ? ___pte_offset_map+0x1b/0x1a0
[  679.962434]  ? srso_return_thunk+0x5/0x5f
[  679.964261]  ? __alloc_frozen_pages_noprof+0x18d/0x340
[  679.966389]  ? srso_return_thunk+0x5/0x5f
[  679.968183]  ? srso_return_thunk+0x5/0x5f
[  679.969945]  ? __mod_memcg_lruvec_state+0xb6/0x1b0
[  679.971977]  ? srso_return_thunk+0x5/0x5f
[  679.973690]  ? __lruvec_stat_mod_folio+0x83/0xd0
[  679.975671]  ? srso_return_thunk+0x5/0x5f
[  679.977392]  ? srso_return_thunk+0x5/0x5f
[  679.979079]  ? set_ptes.isra.0+0x36/0x90
[  679.980771]  ? srso_return_thunk+0x5/0x5f
[  679.982375]  ? srso_return_thunk+0x5/0x5f
[  679.984052]  ? wp_page_copy+0x333/0x730
[  679.985648]  ? srso_return_thunk+0x5/0x5f
[  679.987220]  ? __handle_mm_fault+0x397/0x6f0
[  679.988818]  ? srso_return_thunk+0x5/0x5f
[  679.990411]  ? __count_memcg_events+0xbb/0x150
[  679.992111]  ? srso_return_thunk+0x5/0x5f
[  679.993689]  ? count_memcg_events.constprop.0+0x26/0x50
[  679.995590]  ? srso_return_thunk+0x5/0x5f
[  679.997177]  ? handle_mm_fault+0x245/0x350
[  679.998807]  ? srso_return_thunk+0x5/0x5f
[  680.000339]  ? do_user_addr_fault+0x221/0x690
[  680.002042]  ? srso_return_thunk+0x5/0x5f
[  680.003553]  ? arch_exit_to_user_mode_prepare.isra.0+0x1e/0xd0
[  680.005643]  ? srso_return_thunk+0x5/0x5f
[  680.007202]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  680.009025] RIP: 0033:0x7fc2560d985d
[  680.010510] Code: Unable to access opcode bytes at 0x7fc2560d9833.
[  680.012660] RSP: 002b:00007ffde591df68 EFLAGS: 00000246 ORIG_RAX:
00000000000000e7
[  680.015355] RAX: ffffffffffffffda RBX: 00007fc2561f59e0 RCX:
00007fc2560d985d
[  680.017749] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI:
0000000000000080
[  680.020292] RBP: 0000000000000080 R08: 0000000000000000 R09:
0000000000000020
[  680.022729] R10: 00007ffde591de10 R11: 0000000000000246 R12:
00007fc2561f59e0
[  680.025174] R13: 00007fc2561faf20 R14: 0000000000000001 R15:
00007fc2561faf08
[  680.027593]  </TASK>
[  680.028661] ---[ end trace 0000000000000000 ]---


Thanks & Regards,
Harshvardhan

>
>> <<<test_start>>>
>> tag=acct02 stime=1753444172
>> cmdline="acct02"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> tst_kconfig.c:88: TINFO: Parsing kernel config
>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>> tst_tmpdir.c:316: TINFO: Using /tmpdir/ltp-w1ozKKlJ6n/LTP_acc4RRfLh as
>> tmpdir (nfs filesystem)
>> tst_test.c:2004: TINFO: LTP version: 20250530-105-gda73e1527
>> tst_test.c:2007: TINFO: Tested kernel:
>> 6.15.8-1.bug38227970.el9.rc2.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 25
>> 02:03:04 PDT 2025 x86_64
>> tst_kconfig.c:88: TINFO: Parsing kernel config
>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>> tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
>> tst_kconfig.c:88: TINFO: Parsing kernel config
>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>> acct02.c:61: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
>> acct02.c:238: TINFO: Verifying using 'struct acct_v3'
>> acct02.c:191: TINFO: == entry 1 ==
>> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('acct02')
>> acct02.c:131: TINFO: ac_exitcode != 32768 (0)
>> acct02.c:139: TINFO: ac_ppid != 88929 (88928)
>> acct02.c:181: TFAIL: end of file reached
>>
>> HINT: You _MAY_ be missing kernel fixes:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d9570158b626
>>
>> Summary:
>> passed   0
>> failed   1
>> broken   0
>> skipped  0
>> warnings 0
>> incrementing stop
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=1 termination_type=exited termination_id=1 corefile=no
>> cutime=0 cstime=20
>>
>> <<<test_end>>>
>>
>>
>> Thanks & Regards,
>>
>> Harshvardhan

