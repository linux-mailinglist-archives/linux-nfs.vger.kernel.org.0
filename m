Return-Path: <linux-nfs+bounces-7552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDD09B4BC4
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 15:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ADD9B234FA
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CC0206943;
	Tue, 29 Oct 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a9Jry3Le";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yxj0WLv6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AA205AC8
	for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211072; cv=fail; b=mRqosKhj2641lMQL5om9dj1GOth7+LQDwU+j9d91a7cod4tiHdCYMROEBLkKJy/iuKZAC3YL2n5AcqAFfY5gaG5E0JJqDYfUR6vtxnBw+3mdm9vF6ACxoh6QAH29K//UaazBI/DOMr72iNPW17RFVDVyYbuO7vYVEUwGcqTbOHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211072; c=relaxed/simple;
	bh=iSTnFEopuzYBcbrGcjcgb0Z+K6tatwEuhn6SDXte+k8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1i83DqnieRnCS4MEuHrbJXbRU9X/CyMIpxdkINCU10UYTBzFZXWgw+xiP9uE/M/wAuuxLmXaC/VEAKvX90IvFHd7IdpAZNsilrQ4ltO7WX+iirxdyloTrdMqTox4i7Gmt59LUfSlRT5/8+THNauAviEn5mhDy0qaIIItp5YEvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a9Jry3Le; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yxj0WLv6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCbqH3031331;
	Tue, 29 Oct 2024 14:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iSTnFEopuzYBcbrGcjcgb0Z+K6tatwEuhn6SDXte+k8=; b=
	a9Jry3Le7cZ4kpokiq3Kt3NvQYHrXUK6oisg+RDAA9SczxMrPnPcB2/mjDUbrzpm
	1yXGwlyb94059eMvCN5pcN+FUh+osiBsolr2KJlrWDw5XFUyc0T8TqBhpO3+5eDt
	Oapj47cZpqSmBxszozorlzaMbfIUsZCQoZIWzove+bV033BgKOdLaNou/HQa6+bM
	fHsUeOXUXZyW3zCBqObX+YAHTtm615xGvy1NJq+tEGSkY+pYlReq7vtNVJ5PpL5L
	hxVpLrmA58JKKR0hS2hRQ/kTx5CRSdIdXTAc1h9QgicsiYdPskvcFPvNMT5012Rt
	cJz/CoKtntlMlMe3CONUFA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwdgn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 14:11:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TDxtfV004804;
	Tue, 29 Oct 2024 14:11:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2ua8q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 14:11:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hyj+FmyDTFG68xaqjOc/dDXV8AXIQMgWl7X65/SZyXuOfdo7fideIUDvOSs21BYsaDWev5ZqOPu+D0IUzY+csp6h1cZkhvq4vIJuWrmzGNkl5Ukk9yu11fJtU01xBdNnqfKiWcvPmyAxpuOzYtbcY6Qr1+DHdXGAWfVg/ojDRshICl4mblYHNcEQW/nU1d8+D3jgCeMfy5iQD7iMrEGOg/i5P+zvzKIGwK6uTwg/FF6hmJEjZy/6RpomxKl+GqvnyjJlPTeOXRMp1p3izl+SJQPUf4VKYz9CUlArCyXxLCfkugUe6KJgYcOI0g9Ypa6utrfduD2LxnziawIudifdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSTnFEopuzYBcbrGcjcgb0Z+K6tatwEuhn6SDXte+k8=;
 b=g6esAMxwn2q5zDhnj4/fhzv/ijwAmgitbnlhgmOu+iV6J51l9XtewV2zLY82ydM5yHvdHc8SfX2CyrmyZ8+78LQcG6fqXcS436BB6Lquiifm1Tvk7z8r6M82aJml/SzwETN3B0LipjEkAU/fHejGeWN66Adfc883JU2KiD0zLnIVe+QYMmcF9zkOoF15yUh9sQLgI9hyEO2DLNEVOfIe6wTNMoItNVtOaJ0VcTr/OVGfXpAGKj9hH1n8lmSH/SqLkbTe9PF67ZCXp2PwoCVBNGQsuaxKx8KLyRXZEUTOe98g8Po0ham19SOi0DQpTw5d4qs/xTfL/i5qG6K2LV1yKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSTnFEopuzYBcbrGcjcgb0Z+K6tatwEuhn6SDXte+k8=;
 b=Yxj0WLv6vFVvFmoQPzpYMyJadnMzKQe9aCT8hz2TJF/C+WtfKD4m8Ta9K6RbNyjJYPFwDQQPRJRGpAWNa6k+A/DOxgM5bFTw6TNgNmJemBf9CgEu73ruQex+Ma7EWHcSMvyF1LtzRn9fwDSskkQZ+pm5y17Tv4pYNLHmzwnofSA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6627.namprd10.prod.outlook.com (2603:10b6:510:20a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 14:11:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 14:11:03 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Martin Wege <martin.l.wege@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Thread-Topic: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Thread-Index: AQHbJWR3BlJOXtfJrUiYxWPBjvAIV7KdyhAAgAAD4YA=
Date: Tue, 29 Oct 2024 14:11:03 +0000
Message-ID: <7FB2B261-48F9-4DA0-B4B5-E8E30EC31CD9@oracle.com>
References: <20241023152940.63479-1-snitzer@kernel.org>
 <20241023155846.63621-1-snitzer@kernel.org>
 <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com>
In-Reply-To:
 <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6627:EE_
x-ms-office365-filtering-correlation-id: 540138d8-7a3d-4fd9-9458-08dcf82385df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2ZQU3lXb1UxTkRWckxpTS9zNkxHdGJLT1YwbHVWMDBhdWhWUm03WHhHNEFk?=
 =?utf-8?B?bDIwRWQ0SzNSbnFMdDlVRUhyaGJxZjBlM2VRUnozNTNtZlpNdHFVL0FyTmQ5?=
 =?utf-8?B?TjE4QXVJZDVmRGpuNmd4blhOYWk5emZBNnJhWXk1SC8vVVY3ekkxc3ExUWc4?=
 =?utf-8?B?UVRRdmNuUFBiK1d3NUJFdTM2V1ZDWjNReE9hbmo1NXBaQ1NNY3BMRHErd1BQ?=
 =?utf-8?B?VnpRYjdDeHhlTHduK2JZVVViQzIyQ2t5OHI3V0xRSjdNenZlUEFiU2dvM1Vq?=
 =?utf-8?B?UUY1UEJDUmoxMC8xY0Z0MTZvcGNtYWpMOFVGallRdFAwQXB0N1ZCWTN3WGx6?=
 =?utf-8?B?VjRGTGxrY0Z2d1FOQnBtSUFjZm5CakVpQnljbUN0WE45RmdwRllVNDBGdlZM?=
 =?utf-8?B?eHF2QUpEWjR0SXArS3pqOUFHRFBXZXc3d3duZXZCc3RFRzd6VTMrY1psbnZm?=
 =?utf-8?B?djI0eGNyYjBaeE8wenZYeEZlUytaZVhRUGFqM1JZbGlEUzZEejhVbWhoRnRp?=
 =?utf-8?B?L1MyMlhiaFlKeEVtRFJtVnpZYVRBTkdGT3gvK1FtNW81azZFTkhVeE1KRmZL?=
 =?utf-8?B?cWZPdEtkWjlrQXdhRmFYS2ovQlFBTGhmdlQvd1Y0TEwyZHRSWjgxOTkvcDZT?=
 =?utf-8?B?Y0JLMXhRNnJIUko0MmdyalU0ektQWUpBMXhjeERKbVBUT2dwTjhTR2NmSVZL?=
 =?utf-8?B?STZGcWpCcU5EQklrSXRkNTJXTHRkQ3VrK2dDZmY2dGxocW9pbGRlc3ZyMUh6?=
 =?utf-8?B?VGI0VmkwSlBDOVI2cDJxQ0VhRW1FQ01jM1d2bVlSL3RsVjhpeFNHNTZieVg0?=
 =?utf-8?B?a1JVamFGUGpRWFVrVkNsWlJ0am1qNVBqQmVJb2w0SGw1ZXZOVUdJUTZCZC9j?=
 =?utf-8?B?emZjQW9MeHpUM3JqdE0wbGxlM1FUTnBrdjErU0VUdElXdDJSUXBzM0tnaHov?=
 =?utf-8?B?TmZXM01la2xtVGRCNFkyb0Jwa0VQRU4zZ0ZEOHBteXZzN1hjM3hVUXdCaWxj?=
 =?utf-8?B?bTlIQUpnaE8yM2swNTA5bXQzOGFnandaWE8reDJpZHVsY1V6SXVQdGNZdzdw?=
 =?utf-8?B?ekIrbEZQZkFvMGlqTXBmS01UOThQbmZHV0NYVHRIR0RnV0RlYk5ycmlCdklo?=
 =?utf-8?B?MjFLWnVxa2NLRVBTSEV4WDFQb2NoeDVkV0YyTkhadVJPM21xcDNLNHRrQnRZ?=
 =?utf-8?B?V0ZqS3FYMmVGTGh5YlNNMUc2TUt5RlZKVDNkYk0rN0U1NXJCdTBPWUNRWjVC?=
 =?utf-8?B?ZUpzQ08wR3RvTUZ4QWswZU1mOXVvWFlFOGxDV0ZGWmxHenBWYUJjYWhQVml6?=
 =?utf-8?B?NlJsZEJiOS90czNObWpIY2MrY3JtT0lMWjZibmdkbGNOY3NDWHlzSWcranoy?=
 =?utf-8?B?cXMxTUVLUGlkaE0vZWM0ejVUMzZ1NUdGVjZRVURwcXV1UTM3YU9HU1B5UGor?=
 =?utf-8?B?TElDV0JMaDJiaEtHU3FCaHZWcFNtY2JNSkhpWmRRZmVnUUd5ci95SGlBZnRi?=
 =?utf-8?B?MndQWWpnNE5iamY3cVprb1Uyb2MvV0tBL3Q1eXVyWkV6TEpXK2RuZDd2N1l4?=
 =?utf-8?B?Q0VHN1BrN2pNcG9qQmdCYTg4UHpPREdaYmZZZVovcW9ObzRXaHZIdGcvaU9H?=
 =?utf-8?B?aHh4R3REdjhCZXJycFQ5c0NFVjNacThucXdQVHdCbDJwQWRPMUovSWhkWFNo?=
 =?utf-8?B?bFpsazA0MjNBbEQ2MUE2bHpNNlZlVjIrVEJmMFpMVGx6VHJkTUVvbUhXTGht?=
 =?utf-8?B?YWU4TWtMM0Z0cTg5dktYZEx0cWZxK3puT3AwY0VseWE5Um5YcXNZZW5pK3pu?=
 =?utf-8?Q?4CEs04HjAG+26VPTj5VPBcJlHInSTIRAXDr0E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UStHY2xYOXVpeUl4ck5rYURHZVFTUnNhdUVKazd5ZkRCV2tMVytTc09ZbjU2?=
 =?utf-8?B?K0ZscjZ0bHVQVzROc0dhdDVma0NHTGtoSGxuWm1ZeG1tajgzRXVMcWhHV0px?=
 =?utf-8?B?bXdsTnNOY2RXd3g1VEFsRE5yYkJYRHhwNVFIMldqM1RCaWozK0VtR3JySmdz?=
 =?utf-8?B?blRYMXRWbm5wTXFVRU5VQVpmbnpHajJtZGZxVjhPYkpGdjBaQ2I1MGVMbDAx?=
 =?utf-8?B?MGVmU3djZlJ6NS9xNm1aNzByOHFkeHNvY1ZNTFV6bjhENTJaNDh4OGQ1RVlt?=
 =?utf-8?B?akdhenJEVEZOS2FpMEdVTFB0cnhrcSt0WGZIMUhnWnpFYVNDTG1DNVZUcW52?=
 =?utf-8?B?bUM4TXhiUlhvNlFzdkJJQUx5cWZCNUJta0x4NVNUYkw3UkNvVXBFWmJSOE5C?=
 =?utf-8?B?YkhtOFZDbTRpbWVrUkh1OHpNSlljSXAvMUFWOEdEYXNlZGRNMVdtZ1hWQUUz?=
 =?utf-8?B?VmhUbEdINCsyRktwK3RjL3NVQ2pFNkh3RDZsKzhFeDRpNkthRytuZ0dRTEd1?=
 =?utf-8?B?VVhDNkQ4ZENaSXdlRFRaR0Z1Y1c4ZnhPa3h1M3ZGV3NqRG10c2w2SWVnMkQ0?=
 =?utf-8?B?SzF0TWttU2FqREs1dDAwb1pqdzVTb1Z0ejh5RWwyb3RDNmtQdXJ0cVJlajlv?=
 =?utf-8?B?VGk3R2tzRHpiS2xTaGdBMjZSNzhHOXJTVDlENitBSzJMdkNYdHM5VXp6ZktU?=
 =?utf-8?B?SDh1U0MrZjJPdVBGcWJQSnpLUEt0cUhKUDdyVTZxMjRtSnc4R2tjM3Exa01a?=
 =?utf-8?B?Qm5US3VLK1RYd0x1VjdRa3ZTL2I1YkZYakNrZXk1dmF5Rm90Qjh5WENLY21i?=
 =?utf-8?B?TnJnV1poWitMYVpaaWE5dVhrWEljUUxaZU1uUkhONzF0K1ZOUEd2ZnJLbnho?=
 =?utf-8?B?VTAwakh5ODFBM3dMclFqNHU0VjYyMElKNVU1MEs5Vlk1eTdBOEFYZ1ZvY25y?=
 =?utf-8?B?Mk5MQUtpbk5vT0xJQUxlVDMxcDRWRGlhNGUxbEtmdHI2dlZ6Wkwvb1BjY2VL?=
 =?utf-8?B?K1RRY2p6YjZITlB5azlmWlIxTWxkUUlRSHRYSVBWbkNkdTBmK09XbnZEbHBn?=
 =?utf-8?B?dTkraGkyMFJHMjJxNTdDS0pOdm5IYys4TFgwWE9HcisrY3BnMGFCK0tqdkFq?=
 =?utf-8?B?clArYklkL3A4VUhlS25vZUJ6Vm9lelcrVXY3QStCUWF6Myt0YWZhZWlaTTlC?=
 =?utf-8?B?TFhTRHFCYUYzRjZMRnprNGttQ2M2VUlhSWdHaUw2blpSdjlBckZtTERJb0t3?=
 =?utf-8?B?M0VudmNxVUVhZ3pqZHpnS1ZURUNTTzMrMFp1MHVtekVIY21pT2tNdTRBbmdO?=
 =?utf-8?B?WUpFcHpOVGtVVUUvT2xmVmlVK3NUaURiSVpmbzgwTVM2MlM5eDIzNGVLclRo?=
 =?utf-8?B?TlJ5d2NLZnYyMUh4dXM2OGErOWtkOXlzSUo5ZFZzS0s0M28yb3JwOFpBTUZz?=
 =?utf-8?B?TlRCWWorZFQzQzh1YlkzY3BxVk1GbzBZN084ZVhZZGw5ZEVjVWp5TS9NTHUv?=
 =?utf-8?B?NjgrT05FaXRpcWVjZHJXNVVib1Rvb1M5TVBiZDhUdVlIbWtFZlpFWkF3ejUy?=
 =?utf-8?B?TmZHWlFVQWNhOUVpMzYzQ3kvdWZKMUFvc1laUk8rOHNrNVUrcklmZ3JmKy9C?=
 =?utf-8?B?YUtSL3dBdElQQnZ6cmxrWmVMWWFLd3BrdEUwM3krVXhLdFRta2tDSE1GWEZp?=
 =?utf-8?B?aVgwUWw1QUNHaW03RElHZHNpc0kzWW1IbFZxWUFJdXFKQ2IyY0M3NnR5eXVM?=
 =?utf-8?B?NlZuOTc4bVI1Qmt1bm1CTmVtR28yQTJZNE9qM29ZNjQwZFR2NENselk3aGlw?=
 =?utf-8?B?VnhEcEliZ0lQdzNyeW8vRWdOWmZicnphS1pDVjViTUxZdzVZcmpiWlBZcVNL?=
 =?utf-8?B?ZHVMYkk0MkMzYXNoL2s2QmVBWjM4S0ZPcXNMZFZZRHBndkQ5OGxGaVZhUm81?=
 =?utf-8?B?OWxGVTJ3bEpRYUs5NmoxbXQ3bmVqZExxVDl3TmJid2E2bGsyajY4L29rbWtO?=
 =?utf-8?B?eFZ2dmRycTZIdEg2RmRBRDRUWTNMVlZSWWJJZ2dTcThwK1MwVEVzcm4yVnhj?=
 =?utf-8?B?YnhrdGcyTzcrRndxeDZ2cVhOVWdEbGhVODdnQ3RzY2tNZ2owemhjbzMrVTdz?=
 =?utf-8?B?dXEyWWlmMlJPTnFVVHlScG9oa2p1WXY3SkpEYnJsMUZPZ09sblg3QTFLYWpC?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BF8770FFDB6264CBE349E4071071CE8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g3acpbMN+NZsndD2DYTUnVb7ErZb0FfVS+A31bkuywrwW+BsCdVNF+fHTFUDs+0tiZeK5VavKDSBArgavqnHGbePYeD5Ajv4hjbXMAtogbHs/D/lubLvsoTWdio5VyDvTG81c7/5VGRFpMDBxWxYh5LLFzCbcfSnCoqMj0lQxkC8cebKdLw1Ai2jxkXeHsHibyoI7f49qfhxvxUmMP+UbUOvYP9/DjWAAxSJOW9ITBek3TJaO7igNFSf0Ecqc8juIf+cHjbYO1IsGPAdibAHVJ4Fs5H6I3VTk6jZbMgVTA/JtCbR1hC/ibebYiLd3tVAIqPSkRM290aOMMbyDZ/svIa3bwaiZuLRauxxouKySfK8ypYWhibg0Hm8gAGdoPAnECVnGgMbFDqUnQWmmDm32DBimXDmGufZHQO0W1AxB2lJ+BhiOu7f0CtiLc9CPu0UESeoF/a2iMZ/j8d6jtxM24zM0e9l1qRB9Mz3R4tX7PKnQZ8SFbIFkpE5hb6/PbnLRGXInnc+yWLZ8YdAKQp7BSPj7CVkfucO8c9D3fxsOamXOa7Z+1QhRID7rmQ4CSuns3nlDPk2if89MjuMUr+OE9m5QZTQUKdJuNPt4mct6yw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540138d8-7a3d-4fd9-9458-08dcf82385df
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 14:11:03.2971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nR9kjAJgjVu12m2oCbV2sCr/JsqtV24frArMSlpORfLJJc/CHf0wm+NQl2i4fJmZSSr/sG6jXr8cC475jzEJmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_09,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=504 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290108
X-Proofpoint-ORIG-GUID: iZN-dn0WYSanwYNgOASkln9SmNoIAnr-
X-Proofpoint-GUID: iZN-dn0WYSanwYNgOASkln9SmNoIAnr-

DQoNCj4gT24gT2N0IDI5LCAyMDI0LCBhdCA5OjU34oCvQU0sIE1hcnRpbiBXZWdlIDxtYXJ0aW4u
bC53ZWdlQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE9jdCAyMywgMjAyNCBhdCA1
OjU44oCvUE0gTWlrZSBTbml0emVyIDxzbml0emVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+
PiBXZSBkbyBub3QgYW5kIGNhbm5vdCBzdXBwb3J0IGZpbGUgbG9ja2luZyB3aXRoIE5GUyByZWV4
cG9ydCBvdmVyDQo+PiBORlN2NC54IGZvciB0aGUgc2FtZSByZWFzb24gd2UgZG9uJ3QgZG8gaXQg
Zm9yIE5GU3YzOiBORlMgcmVleHBvcnQNCj4+IHNlcnZlciByZWJvb3QgY2Fubm90IGFsbG93IGNs
aWVudHMgdG8gcmVjb3ZlciBsb2NrcyBiZWNhdXNlIHRoZSBzb3VyY2UNCj4+IE5GUyBzZXJ2ZXIg
aGFzIG5vdCByZWJvb3RlZCwgYW5kIHNvIGl0IGlzIG5vdCBpbiBncmFjZS4gIFNpbmNlIHRoZQ0K
Pj4gc291cmNlIE5GUyBzZXJ2ZXIgaXMgbm90IGluIGdyYWNlLCBpdCBjYW5ub3Qgb2ZmZXIgYW55
IGd1YXJhbnRlZXMgdGhhdA0KPj4gdGhlIGZpbGUgd29uJ3QgaGF2ZSBiZWVuIGNoYW5nZWQgYmV0
d2VlbiB0aGUgbG9ja3MgZ2V0dGluZyBsb3N0IGFuZA0KPj4gYW55IGF0dGVtcHQgdG8gcmVjb3Zl
ci9yZWNsYWltIHRoZW0uICBUaGUgc2FtZSBhcHBsaWVzIHRvIGRlbGVnYXRpb25zDQo+PiBhbmQg
YW55IGFzc29jaWF0ZWQgbG9ja3MsIHNvIGRpc2FsbG93IHRoZW0gdG9vLg0KPj4gDQo+PiBBZGQg
RVhQT1JUX09QX05PTE9DS1NVUFBPUlQgYW5kIGV4cG9ydGZzX2xvY2tfb3BfaXNfdW5zdXBwb3J0
ZWQoKSwgc2V0DQo+PiBFWFBPUlRfT1BfTk9MT0NLU1VQUE9SVCBpbiBuZnNfZXhwb3J0X29wcyBh
bmQgY2hlY2sgZm9yIGl0IGluDQo+PiBuZnNkNF9sb2NrKCksIG5mc2Q0X2xvY2t1KCkgYW5kIG5m
czRfc2V0X2RlbGVnYXRpb24oKS4gIENsaWVudHMgYXJlDQo+PiBub3QgYWxsb3dlZCB0byBnZXQg
ZmlsZSBsb2NrcyBvciBkZWxlZ2F0aW9ucyBmcm9tIGEgcmVleHBvcnQgc2VydmVyLA0KPj4gYW55
IGF0dGVtcHRzIHdpbGwgZmFpbCB3aXRoIG9wZXJhdGlvbiBub3Qgc3VwcG9ydGVkLg0KPiANCj4g
QXJlIHlvdSBhd2FyZSB0aGF0IHRoaXMgdmlydHVhbGx5IGNhc3RyYXRlcyBORlN2NCByZWV4cG9y
dCB0byBhIHBvaW50DQo+IHRoYXQgaXQgaXMgbm8gbG9uZ2VyIHVzYWJsZSBpbiByZWFsIGxpZmU/
DQoNCiJ2aXJ0dWFsbHkgY2FzdHJhdGVzIiBpcyBwcmV0dHkgbmVidWxvdXMuIFBsZWFzZSBwcm92
aWRlIGENCmRldGFpbGVkIChhbmQgbGVzcyBob3N0aWxlKSBhY2NvdW50IG9mIGFuIGV4aXN0aW5n
IGFwcGxpY2F0aW9uDQp0aGF0IHdvcmtzIHRvZGF5IHRoYXQgbm8gbG9uZ2VyIHdvcmtzIHdoZW4g
dGhpcyBwYXRjaCBpcw0KYXBwbGllZC4gT25seSB0aGVuIGNhbiB3ZSBjb3VudCB0aGlzIGFzIGEg
cmVncmVzc2lvbiByZXBvcnQuDQoNCg0KPiBJZiB5b3UgcmVhbGx5IHdhbnQgdGhpcywNCj4gdGhl
biB0aGUgb25seSB3YXkgZm9yd2FyZCBpcyB0byBkaXNhYmxlIGFuZCByZW1vdmUgTkZTIHJlZXhw
b3J0DQo+IHN1cHBvcnQgY29tcGxldGVseS4NCg0KIk5vIGxvY2tpbmciIGlzIGFscmVhZHkgdGhl
IHdheSBORlN2MyByZS1leHBvcnQgd29ya3MuDQoNCkF0IHRoZSBtb21lbnQgSSBjYW5ub3QgcmVt
ZW1iZXIgd2h5IHdlIGNob3NlIG5vdCB0byBnbyB3aXRoDQp0aGUgIm9ubHkgbG9jYWwgbG9ja2lu
ZyBmb3IgcmUtZXhwb3J0IiBkZXNpZ24gaW5zdGVhZC4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0K
DQo=

