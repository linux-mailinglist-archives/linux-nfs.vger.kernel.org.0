Return-Path: <linux-nfs+bounces-9202-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B72A110A8
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 20:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CE83A446B
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8451C07DC;
	Tue, 14 Jan 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P72VpjvI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ks3lhvj1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C181B85FA
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881340; cv=fail; b=Ln4fJFUAHgxGTewezQx7dvznXmXBJLQ2xiRFG5dzK1JYYVf5IDTAFhTt/2o2psZ3xM+KcwBgHErb0I8NQUlJIVzLp8RtRJFCwgknxXEb2iTqhpHrEYzoxSZteqSvMimBbpfSFQ2RwezhhK7jnMd9N6pnoHj/TlePwo1yqp8OVpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881340; c=relaxed/simple;
	bh=d8zjVLFJm8yGbjrk0ctJhZrnwSSt5Gu7e6f13OsMZfk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FK9mJp06Qp91qrRo+kkvwCKhf82JVvQevr5USYMG3CkXFZlov6mv+COk8A9SH/cb59MSg3/x4U0AUrV/DW3c8LgqfaIat4MSYivlxYN/ReRIQlA3UWQfs6KpmAYTGDtsb4z5YDwsC6lymzzRlMnGebu0K5nRPfeQD7A12RWYhWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P72VpjvI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ks3lhvj1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EIXp6r032536;
	Tue, 14 Jan 2025 19:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RxBXPQuXPPVC/1F+y46N70QSxgzwGUa8aPwVR8+3i/Q=; b=
	P72VpjvIHcM+kt24ax9ZXC6xwSM2IIawsuTLRn5PceDMr6QRg+bGCBls6e9KfTdE
	7IzzI7BoJQljwlapIgWDbuqdJkKpXWtWZaM5o2sXIE36HXve+m3/NC1l1D14qD7/
	5fHaKTmkRuNa5H6PxXjp3Qkga/9ck0JA0ajC45QZqgFopFOW6CFwdXl5YxlYtvv4
	D1q0bxIr1Umzm6CJ2aWAIIFXzgJnhsZU1wvBRGoia+4lJhDwt6mTSEM3Y2wtQURv
	2Zm+j3gY4c0tAombLSG8Epi3vUDHhGOd1ZEluz3j6rYuGRcx6k93Y5FxkGw24dIW
	5i2yrr30VipuPA6dnHNtCA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y6d2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 19:02:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50EHh9Tb036331;
	Tue, 14 Jan 2025 19:02:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f391ndc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 19:02:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAv+k0mgC9h5pOP11UvsVHGRmzktuJVrF1FeUmca7rKbPdQt/FFW7aXasluMpkvOsb6gQPMc1msScy12cG9wCw+1zluWQFj8RSplaNiy7YPRHRQ8ahWZxhOj04tBRCTdjE1H6Xg6UtOHsb/xMhZkdlWGewGEUmpojDtFCzB8EAFz1M8eE0Mw1oAI1pBUbzhixdhhGxVA6TuIPIiE3yl7j8rNLdjmnj0f7Qj3fi+maErz9bOGj5rv7wGRBwkApNuVdP4+A3aQHVwHh/cFxhteEzJuu2xBQy3/1G3Fw16aTXblKwrmzbc0WTDR0BDdShjegtyYaP1z8gkb3AAgbGwWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxBXPQuXPPVC/1F+y46N70QSxgzwGUa8aPwVR8+3i/Q=;
 b=So4OTVyHfGUD6tcrX2lXpEk/0VejYdpCxsV1LBzXC1v3vnYQAKuRdYCAzRJ2guXM+Y1U6ZCxuB5iaBCL1gDoyh4AM2PeeWStdLVN/hEORZuhyyIhJOFi97WtdtCDgp3ONp/X7jpGcjlkRY+rvTMLNrbeYE0U354J+wIdqz72wE8MjfkRSIPkLthEeDoZwpebXW5fkmMTUU5L8DVprKokFFiiHEwxdHUv/DO2cMBc7Plo8uWgdtGMRtpvWYYyRbHKixZA2g+rAFXrN3BVO1OV+sBwJrI6PbmsCasMu89QOkB3aJtpSy7+M6ZCueA8/TbZRTw7GE+31x6nuX0JI1k1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxBXPQuXPPVC/1F+y46N70QSxgzwGUa8aPwVR8+3i/Q=;
 b=Ks3lhvj1cB5nNz3jsZDwZHq3dK8AlHUkcebdcVZzKLy+cZLs7sZfDUZl/yiAP/HO3W186FWxbXtiJ8tEDlez9uI5xPa9PZtJs5HEHLbgcN2oPNqKMe662acluJ4IbAaRA/ay+1pOezKe8ikFVD1vVqX2H8N0PgF+Ay+eEK3pNsk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6879.namprd10.prod.outlook.com (2603:10b6:208:421::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 19:02:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 19:02:06 +0000
Message-ID: <02d46ca4-59fc-4760-a9a0-6d8fe41df1cf@oracle.com>
Date: Tue, 14 Jan 2025 14:02:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd4 laundromat_main hung tasks
From: Chuck Lever <chuck.lever@oracle.com>
To: Rik Theys <rik.theys@gmail.com>
Cc: Christian Herzog <herzog@phys.ethz.ch>,
        Salvatore Bonaccorso <carnil@debian.org>, linux-nfs@vger.kernel.org
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
 <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com>
 <CAPwv0J=oKBnCia_mmhm-tYLPqw03jO=LxfUbShSyXFp-mKET5A@mail.gmail.com>
 <49654519-9166-4593-ac62-77400cebebb4@oracle.com>
 <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
 <cbc55c4a-ac98-4121-b590-13f32a257d65@oracle.com>
 <CAPwv0JmA+29fujmmrugY0AFdtDDqjSvn6RTHzwYNR9a4skXfeQ@mail.gmail.com>
 <75633e31-53ae-4525-ae84-1400ae802359@oracle.com>
 <CAPwv0Jk1UaHqNX27AtR+sPrCdVbckpR5ayQ-u+kZ=w3C+sOsgQ@mail.gmail.com>
 <42da212b-071b-4c20-b7da-97ca02413c5a@oracle.com>
Content-Language: en-US
In-Reply-To: <42da212b-071b-4c20-b7da-97ca02413c5a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0031.namprd14.prod.outlook.com
 (2603:10b6:610:56::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d071cb-f1ba-4b48-0482-08dd34cdf047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGZIWXVnNHA4cEpjajA0a3lyOFdVV24xUDB2Wk1GeUVJWTZDU08zYUdqMTB1?=
 =?utf-8?B?aGpxdk4weWI3RUtnMEw4TXdXTXVNMjNxZVVMQVFtRlZ2bEM5L1crSWFDN1lZ?=
 =?utf-8?B?ZDEyTmhpdVhuUGtyNjlIbFBHWXdqcHg2YnExQ21rN0NsczNoL0R6NllhQTBY?=
 =?utf-8?B?MlpXQk42NG9ITVhWaTBNMWlncEgxZXlVVDEwTWlMeHl0NDN4dmRlck8zbGc4?=
 =?utf-8?B?Ukc0Nm5wQWV3M1FaSXpNbHZZK1NTZ2FzczMxeW9YNDhBN1p0bE91TU01RFR6?=
 =?utf-8?B?NHhIcWlBVU9VZHpnQ2dVckZkSFVxQUZBWGNmV1pxZFFFcGlzTUFnOWFDc1lU?=
 =?utf-8?B?Uk0yTTYwOXpJd3ZoY0VVL2Z5OCtIYk5EQVQzdWU3bkRmcVdUbHRMMjlvRUN4?=
 =?utf-8?B?bGhoZjRFa0RrclowTVp0Y1d3Nlc1bHBWUWdyR3RKQUt0Y3RDS1BqSjN4UHg2?=
 =?utf-8?B?d3dWUTFESVhtS2ZUdDkyb1dsaU4zMlY3U0xGc2lyd3NYMlhiSDVxbUlkYzdP?=
 =?utf-8?B?b2hMeGk4dnJZTG1WZ2JGL0NQVE4xQzB2N2d5T1d0ZjBIZHhHUlkvN3BRVXFU?=
 =?utf-8?B?Q0NubkhDL0d3R1hVRllZVGNyWE44OGdBRHgwN0Nxa2J1bm8xcFNvNkFSMmxK?=
 =?utf-8?B?cHVmTUQ4RnRPQ1gwNEFaUnZRejRXLzllZ2VqZUc0ZlFsN0p6RTNNM2FJV1pt?=
 =?utf-8?B?RCtvWHljZWhLZzFJc1FuZWk1UzZiNmVsMnVKUkVqWUxha1FySVRBdktTWU9G?=
 =?utf-8?B?K1NWN0xEMm1YZmxhM3g3bVNpem16cXUyWnVrd3pMZy83TTNJNGFUeXdzb3Rr?=
 =?utf-8?B?Y0FYbkRYZzFPMHhER0ZKdkFZM2RYL0FiU0YvcXFyaGgxdXRsMVdVNjhpRnBR?=
 =?utf-8?B?bmpmMlNSUUZKVDhWY3VZblg0NVc1WUpPNmNUZWRKVUNrWHFpY2dlUW9HVlBm?=
 =?utf-8?B?bW1sUnFBaEUzc1J6b0tnTDkxSm5XUm1JemNZWlA0YU9ndVduTzJhMWVaUW1q?=
 =?utf-8?B?QUI5Y1JFZmFoVE5PdnFEZ0ZFQTJ4bkNXeUYxRk5Tc3FnamF4TElZZW1IQjNv?=
 =?utf-8?B?bGJhQ2NOQlA1ZDNkbE40dk0wVThLQ01nYThpM1hGd2JHSytsVDNrYUprbmZ6?=
 =?utf-8?B?bXlDVEo4SE1OM0lrd1Axam8zNUNFUmtuV1Q1SmdVYVBGb1JRLzFKZDBGamVG?=
 =?utf-8?B?aUdmN050MmtzMjRPRXRYb04vSjB2cXk4cFl2UDRqRldCYk8wUkVsMFA5SFZY?=
 =?utf-8?B?ZnQ4L3V0a29sMnNJMGNBakZwVU5mN2tWK1BFbDdueExpVC9hWm1FVTJWVjlY?=
 =?utf-8?B?TTE2c2dqMWplbkJyZmV3bFE0bkNPb1J4eHVyVEM4dkN6cXlEc3hUbnh6NjNX?=
 =?utf-8?B?MDBpbzZnS0pPdVdvQlZJaE4yaEhDcFZtWXJNbEdXVUV6Y2VzQytWWlN2LzFJ?=
 =?utf-8?B?QndLMHBRWXp2VE1neW1CQ2sydDNYWFVteW8wWTRJb0V1b0RjbFptNlptWlZt?=
 =?utf-8?B?U1cvbnI5NEdwTk02Wno0ZzlMZWpXTDRHVktYekpKMjRxN243MlMvajc0cm1P?=
 =?utf-8?B?VEtUeDJGOE5qVHQzMnBLSmpac1oxRWtNOHdtNElvTzNIYUFGYTZPZW8za2Mx?=
 =?utf-8?B?TVZzT2xSUE9LS1JhU3ZTS1FmSERxY2VJYnllVEhGajE4VUM4d2lSS082M0Za?=
 =?utf-8?B?Y1U0Smt2SUR4b29tQ1l1RHdPdEM3T1V5ODd0VzUzNkg1RFV5akl3RHJQb2FF?=
 =?utf-8?B?Mk4yZnBvd1pKLzhHK09XOUV2enhHWVVpUWJ3ODdRMGJHbUxsTkg4S0FjSjd3?=
 =?utf-8?B?Qkd3MmprM3dKOUVHOTFVUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21URUUwTDVXY0wydTVIK2NMVWJxSnlHaEhjTW9rQ1RGV2ZVbFZEVTRkM1lz?=
 =?utf-8?B?ZnN0ckhwaTV3bCs2cXIyYnRKazFaWHpzNDFQMFdmKzdEOGhtQy93WnRRK2Ny?=
 =?utf-8?B?U0dwMWI1WmhyL2lmWHQ4djJoMXpvTXUyREdYYWpLaW03WUk5OHhOeEJwU0hw?=
 =?utf-8?B?TW1URDdON3NMRFo2cGRaTzkwcVBTWnBCaTg3dXc0eFB5Z0ZLNDhZQ1BWUlBx?=
 =?utf-8?B?NEZLY1A3dGJTdkZocmpmSlVDeE9mMTU3b0NyNWgyc2g4aGtOWTBlbDE2MktT?=
 =?utf-8?B?Njl4Y0FSelpSWlBVcWlyM05mb1ZjSit6MWNhVWNha09vQkNkeWQ4Z3dRQzRR?=
 =?utf-8?B?cEpueHhKeVVva21DcXl0K0YvL1pjTlp5RjJocXlablYzQ2QxOWt1bStvT2NZ?=
 =?utf-8?B?NmFyMSt4cGQ2RURSMSs0M2RtTGY1MDZDenhOQWh3d3NDVHJkMFQ4L211Rk4x?=
 =?utf-8?B?ZnJvSG8wMy93SXRzVkZXZmtsZjUzdy8yZ25ORGtNUHQreVRSRDRDYXBtWktT?=
 =?utf-8?B?Q3RyNUpjVjhIQnY3WmdaYWFJNFBZOXQ4enIwSzVKWmVsbkw2SStER2tvS3pF?=
 =?utf-8?B?aitOMFdoYUJQS2FuRzNBOWpieTBBOUJiREt3bnFJaEdwRFJuSDZzWHo4elgz?=
 =?utf-8?B?aUpRU3d5U0ZKd3RaVGpEODU2UFIwWkI4VEdsK1N3NC9Zc3FJcHlGODBFeERB?=
 =?utf-8?B?bTBvTmZXUmd3anZiZVNTU3VBOWs5NXJtWEtMQXpWNjgxWkI3Q2FLY2V3c1FN?=
 =?utf-8?B?MEpEU1dGRDJFL1JZSzRVYm9SVzlUT1dveng2ekhlVDdBdzhpdE1pNklZVGRZ?=
 =?utf-8?B?OStVeEp6MXJYTUdwV1NVYzh5cWlRdUpwaFl3RTd1c3FHUHY4eDV6bVlqeUsy?=
 =?utf-8?B?RGxBVkhibEpCcUZ1TnNQVkc5dXVOR0k4VWplYksrMEh5SWJWdHpTTmdKNUF2?=
 =?utf-8?B?SFBveXNZMXdzbFRtM0h2VHZzQS95NHJiSURaTlZlUWRnak1kRWdwQlhVS1hE?=
 =?utf-8?B?U2MyV1M5TkZLY3JDeVdGdjBNNzFocHNwZFYvV1hPV1RuaHpNR2FORjc5QTNT?=
 =?utf-8?B?M0QzMXVHSjh0YWRTcVExZ01SbjNleTZNSUZPQkg1b1VCMVFiMWQ4aVBRdU5G?=
 =?utf-8?B?TXhXNW5yMG5UZWhwVFR2eGhVRFZ3bXIwV2l5d0R4b0Nqclh5TjVzWEl3NzBU?=
 =?utf-8?B?cUxYeUkzdmN3VFcxNTgxRWYzN2JJeEFsa09QbDNjclpQVFZHOWdiZHlvK1BG?=
 =?utf-8?B?eFJ6NlVSRUdDOTNMTTlOZWFMampZdDZHUFZpL1hyaXF1RGdZMUgwczErWkNY?=
 =?utf-8?B?L0N3L0tzZkdyRHVhMGhTOGdaQWgyRW1NZ3phcmtoVXdSRGE0OGZQZFE2dnlC?=
 =?utf-8?B?U3lUaEYwNFJRRVRBb1JjWDFlbFBadTZTdGpSMHhxMTFWYU9ETGRNMDlhZC9C?=
 =?utf-8?B?R3Z1Wk5vM0RYSE5PTVIzc2FaWEZFZ3JKTjdPbTBFaVVsSzN4Znh4d3VCdjBZ?=
 =?utf-8?B?RVlkVFFBRjI5ZlAxSFc1VkNmY3pwanhCVkFpRmlGc05uNVpKV0FrYWludXMx?=
 =?utf-8?B?WGVUb09UNVMrWVhIZWQwWFg4S3hsYndEdWVsUE9ZTDZrN043azQ2L2RrZ0Ry?=
 =?utf-8?B?L0JjVHVKQlZOeVRiYjhsTVg5cjAzN3pQMERmTGNRcnVOOUNZOTZWY3hSTFo2?=
 =?utf-8?B?ZWlKOGhQMmo3QVUxMjh1dWZpaGdOeUloQ1JkU3BuOFJkRU52ay94dmxpMU01?=
 =?utf-8?B?N2ptZEJCWWgzV2ZpQVhlN2x5WEZGVlNtT2xOMWhYdi9QNU8ycHhhNTJmWGEv?=
 =?utf-8?B?VFRMOSs2byt2YVI2TC9yZktreVc2bU00LzZ3WDFRQlFhaG1pc0VmVURhbGtT?=
 =?utf-8?B?YlFCUi9PSUM5VkxObG84SXh4MTliMTZjUlpWU0JBUWx3cFRIQno0WUd1YWxP?=
 =?utf-8?B?SXR3OHdVUGVJREZUSElZa2I5Rkd3SVk5TEtWSFN6Uy9ZQmxVcUtoNTRPalUr?=
 =?utf-8?B?UGZOVm9sYnpJYVJJSG0vc3RSQXhUYTF4N2NBaFFmWnBtaHBZZ0xyUGlPbEI5?=
 =?utf-8?B?OGJ2b3J5YmNRQU9nVU9uSnNuT0xZVDhBSHVQeDIyWnEwZXMzQ3cwa1MvQ1hX?=
 =?utf-8?B?V3JkWnpvUCsxdzRPTWdNQmVVYTNpeTJkbUp6czRqSVM4aU9sdmEzTHNpdW4v?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cO7b5n9RDxbt8FUnwYLVASbVTbX/4e8YkBLwZZkSA52EokTK7dtUZCHswlC1aJ61CBq5BN96uNTpbkonVgCQa9h1D+TEFe9qjXv/7z8kdD9bmjHPkCt3K1/AGbPpzIzYlTz4FeHf/Q2HfvCe9dmMXXKFtlbgSeFd9rDXEJP/4yFqloYmuINUYAIb2cqtueRAP9o6WQPIcVdraxQPCil/NUIY4vNdtdlJDOW6ycVJdH4KXZh+NAHqmgeiNN2kywtasqp+mpa7Ayb6vxyE+t569PDjL6yO/IU8z0LVuyZn1UXj7VDoOWlatHJrHSiwGnD0EvqnIUNAJQZ96FDWLAeQNglpGcL5dLONaHFPGOmrO7k/HTjWM7RAZplLx+eTw4ye3DKIkvdFpYS890mC3/c7Vl168FPPiyvbTwXlR82EY9fAQgSypNchzQWxJ8rmLMOvCf5ut0HtXDSg/Mesk0IfJYs1NbA4cQOR4KzIlv7f/GN4sPCVXDcotjymF7qU+H396sySUQ1ooJvmOu5Rz3QDH5Q5KgFuJs0x6WZ1JBbJCIfY7o3lVBKn+4ezvwEB+yF/lQ/j5/89YM4u2TmupNuwGsyVRG0tga8txatdU/VMdm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d071cb-f1ba-4b48-0482-08dd34cdf047
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:02:06.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TUk35hFu4/aNjMy/PR/tDq/QLDFMufMarDVPd8e2Cy5GrWgxzJGVF75giBlmz4haz+ZWqjiodzastCTh5X+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_06,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140144
X-Proofpoint-ORIG-GUID: lAyr0ef6PH-PUUZXENxzeVfwBrgTYIZi
X-Proofpoint-GUID: lAyr0ef6PH-PUUZXENxzeVfwBrgTYIZi

On 1/14/25 11:10 AM, Chuck Lever wrote:
> On 1/14/25 10:30 AM, Rik Theys wrote:
>> Hi,
>>
>> On Tue, Jan 14, 2025 at 3:51 PM Chuck Lever <chuck.lever@oracle.com> 
>> wrote:
>>>
>>> On 1/14/25 3:23 AM, Rik Theys wrote:
>>>> Hi,
>>>>
>>>> On Mon, Jan 13, 2025 at 11:12 PM Chuck Lever 
>>>> <chuck.lever@oracle.com> wrote:
>>>>>
>>>>> On 1/12/25 7:42 AM, Rik Theys wrote:
>>>>>> On Fri, Jan 10, 2025 at 11:07 PM Chuck Lever 
>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>
>>>>>>> On 1/10/25 3:51 PM, Rik Theys wrote:
>>>>>>>> Are there any debugging commands we can run once the issue happens
>>>>>>>> that can help to determine the cause of this issue?
>>>>>>>
>>>>>>> Once the issue happens, the precipitating bug has already done its
>>>>>>> damage, so at that point it is too late.
>>>>>
>>>>> I've studied the code and bug reports a bit. I see one intriguing
>>>>> mention in comment #5:
>>>>>
>>>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562#5
>>>>>
>>>>> /proc/130/stack:
>>>>> [<0>] rpc_shutdown_client+0xf2/0x150 [sunrpc]
>>>>> [<0>] nfsd4_process_cb_update+0x4c/0x270 [nfsd]
>>>>> [<0>] nfsd4_run_cb_work+0x9f/0x150 [nfsd]
>>>>> [<0>] process_one_work+0x1c7/0x380
>>>>> [<0>] worker_thread+0x4d/0x380
>>>>> [<0>] kthread+0xda/0x100
>>>>> [<0>] ret_from_fork+0x22/0x30
>>>>>
>>>>> This tells me that the active item on the callback_wq is waiting 
>>>>> for the
>>>>> backchannel RPC client to shut down. This is probably the proximal 
>>>>> cause
>>>>> of the callback workqueue stall.
>>>>>
>>>>> rpc_shutdown_client() is waiting for the client's cl_tasks to become
>>>>> empty. Typically this is a short wait. But here, there's one or 
>>>>> more RPC
>>>>> requests that are not completing.
>>>>>
>>>>> Please issue these two commands on your server once it gets into the
>>>>> hung state:
>>>>>
>>>>> # rpcdebug -m rpc -c
>>>>> # echo t > /proc/sysrq-trigger
>>>>
>>>> There were no rpcdebug entries configured, so I don't think the first
>>>> command did much.

The laundromat failure mode is not blocked in rpc_shutdown_client, so
there aren't any outstanding callback RPCs to observe.

The DESTROY_SESSION failure mode is blocking on the flush_workqueue call
in nfsd4_shutdown_callback(), while this failure mode appears to have
passed that call and blocked on the wait for in-flight RPCs to go to
zero (as Jeff analyzed a few days ago).

Next time it happens, please collect the rpcdebug and "echo t" output as
well as the trace-cmd output.


>>>> You can find the output from the second command in attach.
>>>
>>> I don't see any output for "echo t > /proc/sysrq-trigger" here. What I
>>> do see is a large number of OOM-killer notices. So, your server is out
>>> of memory. But I think this is due to a memory leak bug, probably this
>>> one:
>>
>> I'm confused. Where do you see the OOM-killer notices in the log I 
>> provided?
> 
> Never mind: my editor opened an old file at the same time. The window
> with your dump was on another screen.
> 
> Looking at your journal now.
> 
> 
>> The first lines of the file is after increasing the hung_task_warnings
>> and waiting a few minutes. This triggered the hun task on the nfsd4
>> laundromat_main workqueue:
>>
>> Workqueue: nfsd4 laundromat_main [nfsd]
>> Jan 14 09:06:45 kwak.esat.kuleuven.be kernel: Call Trace:
>>
>> Then I executed the commands you provided. Are the lines after the
>>
>> Jan 14 09:07:00 kwak.esat.kuleuven.be kernel: sysrq: Show State
>>
>> Line not the output you're looking for?
>>
>> Regards,
>> Rik
>>
>>>
>>>      https://bugzilla.kernel.org/show_bug.cgi?id=219535
>>>
>>> So that explains the source of the frequent deleg_reaper() calls on your
>>> system; it's the shrinker. (Note these calls are not the actual problem.
>>> The real bug is somewhere in the callback code, but frequent callbacks
>>> are making it easy to hit the callback bug).
>>>
>>> Please try again, but wait until you see "INFO: task nfsd:XXXX blocked
>>> for more than 120 seconds." in the journal before issuing the rpcdebug
>>> and "echo t" commands.
>>>
>>>
>>>> Regards,
>>>> Rik
>>>>
>>>>>
>>>>> Then gift-wrap the server's system journal and send it to me. I 
>>>>> need to
>>>>> see only the output from these two commands, so if you want to
>>>>> anonymize the journal and truncate it to just the day of the failure,
>>>>> I think that should be fine.
>>>>>
>>>>>
>>>>> -- 
>>>>> Chuck Lever
>>>>
>>>>
>>>>
>>>
>>>
>>> -- 
>>> Chuck Lever
>>
>>
>>
> 
> 


-- 
Chuck Lever

