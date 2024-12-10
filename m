Return-Path: <linux-nfs+bounces-8514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7148E9EB858
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 18:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22C716468D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7E8634E;
	Tue, 10 Dec 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="LO5tUhPA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2127.outbound.protection.outlook.com [40.107.237.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B186327;
	Tue, 10 Dec 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852005; cv=fail; b=iW+9+vWw8Qul5lc/ELxq9+31VuStdouI7HXABFDyi15VQyROPw8SzBLPzaf4oMfpjDW1ppGXtJZB1FDOy2PrEv7t/bOTeT3X6JTmYpk0vpt8MScnDXb3igH0vsHDxFR4PI0NGQX2o5kiSm9eycNiR2+3zSpacRrTL/d27BmhVik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852005; c=relaxed/simple;
	bh=MLDqHAnodwZqEZRVwNMCvaRrS2uRRJDO9glvCMHACtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soWD3Gpc7aXsaKW+SyCGABgC4V00Q3kNsrPryq1CaL2MtOdzf5zkP1/fXHz450W0lACCwqLB954Zq2mgQ1DGU/yfcc7sjVbLafnjWUbLl7vaLHDtJl/hmcTDYebB+rHsgl6Vo2ZrB3cUvthar0Vv9cCQ7hUjTTvEQ+HPUQxcfiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=LO5tUhPA; arc=fail smtp.client-ip=40.107.237.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEZZxY+1JaaPyAd9X1lT1/KO0k4OSqeLsHRoNvx15se+GObNxzHgp+vw3OOeU1THfQ6ogv7KG8dZo1kTGWFArpUU/DifOjoQT5x4YdUX62epAAFq2YoX+JQvKYlKPhxaBWyF/ij96zBK5L6eI7cSoX5zz04utchpWoYsgq9vYJ1/esiNrs9C/OwobBHLLPmDaXk+oUgweS4r5dPl+754fxqllu+EVcQJxau5zwA1fhJTXHUGy9RbGQBUlbMA5RqAPiCg+Bzj5GqlIhFNGn5iAurAoWDO527YNaF4rGo+KB1aREGzBEwVIWrIFviH56fDAQ6WYAumOqCTr/+Qdmygyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLDqHAnodwZqEZRVwNMCvaRrS2uRRJDO9glvCMHACtI=;
 b=l95oYLTKlVJDhLSB7VWHOeNQgFlF9OT8lrVtZVQY++yE+u8O6XsdMVOIBP/eEWr7FCOIS5zEk66x2xCPNmIMItNKJpE6KqYmriiGEccybVEMGg91/A8gxlHF2MxP5OfLwUgEwgl+sqEFm2Ho2TljCrxenxAgylfiJwlVcKGxvPQZ8rW+KTEjiaoaYcNf/aj1R/k9K8NMlunA7EJuJ8J0hNthWYVyfd93oEKwe+NZ3HTTycRR909yena1yHCNodPW1JzuK6CDDPr8H3qA12eQ/ofFSQfpcweyxRF9yZoakkCHIDiXGvWfVeI18ku5F00RBYqhr5uhChGeAyOpPX+H6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLDqHAnodwZqEZRVwNMCvaRrS2uRRJDO9glvCMHACtI=;
 b=LO5tUhPAUQajtvhFYssp2MCeWK6ZGJ9VbADtm29lwFUnuLlSgaIX5ak92kS+pyOOsiV1ZWBXLi5fUsWJAN9ryWG22G/h8sxQ3zijoWchT3ijmTvICFFoJh/xOGRewep8A0uSwWcnv/9t+lvy0cV4yyKlN3a1A6g80otolQ3lNoU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3698.namprd13.prod.outlook.com (2603:10b6:a03:226::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 17:33:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 17:33:14 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "njha@janestreet.com" <njha@janestreet.com>, "bcodding@redhat.com"
	<bcodding@redhat.com>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs: propagate fileid changed errors back to syscall
Thread-Topic: [PATCH] nfs: propagate fileid changed errors back to syscall
Thread-Index: AQHbSvy5Xwa8W8+PrkG2iSVmBzvfng==
Date: Tue, 10 Dec 2024 17:33:14 +0000
Message-ID: <16e5f609599e29b49c81a1a8edd721a5daabc1bb.camel@hammerspace.com>
References: <Z1cra8/5H5HvJ5Sw@igm-qws-u22929a.delacy.com>
	  <C71642EC-B9F9-4A7D-AD11-D169268460FE@redhat.com>
	 <20241210A1712306692debd.njha@janestreet.com>
In-Reply-To: <20241210A1712306692debd.njha@janestreet.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY5PR13MB3698:EE_
x-ms-office365-filtering-correlation-id: d144a693-185e-43a7-2171-08dd1940b9f4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWsxbmg4ZkRsNGtlcDdlcGFjeTd1dHAxaDlzVkhZMDFsOTRRSUF3ZmdKZGUw?=
 =?utf-8?B?azE3LzMxR1NUdTFMQzJ3UURobVk3aDVHME00OWpJcnEvSzJUQWlnWGV3RVRV?=
 =?utf-8?B?V2syWWg3RHN1Znd3WWtOVzZBSkhFeDUyS0wybHZ6am1vQ3Frc2xJNk5MOTha?=
 =?utf-8?B?ZEFXNTdTRXhSaXZrbjB3c0d3RzNmVXM3bjN5NkJqQTN4eDJoOFEreHFMRkFy?=
 =?utf-8?B?clF2NzZsUVN5RGx5YWJOck54ZUNTaW5ZM2l0TzM2NExjSC9SbFZ5a05iWW9t?=
 =?utf-8?B?R2F0N2FFZkMxVjB0enAyNGE3NnhSNi94MHp3VmY5MlhQcms0eUtucGk4ZWlw?=
 =?utf-8?B?dklaQTZxSC9BZDNKcGhmYmRSaTJ0UVlQelc5amtmVk81TWgwbE1Xcncwamhm?=
 =?utf-8?B?QndQOUZ5aWo1MUlLN3pVQjR1UHlBdi9ILy9XRjRVeFJVOWt4WWdIMnJZQkZR?=
 =?utf-8?B?QVBYLzVhc0cvTmREcW0vVnp3VEdaRHkzV3lKUENjNEVVRll1MmdMUHZrR21i?=
 =?utf-8?B?OGZoKzZ2OExLcjNETEg3eXZTRTM4bGUvQmpHWTNweTArZS9EZENFZFM2U2cz?=
 =?utf-8?B?bFZ5dTRYTVpKTnNqVU1aUUFVUUZEeVpaTzQwOVhVbGdtSDAyYWttWWpJTkRE?=
 =?utf-8?B?aWpLSjQxWXcxZkt2cVJDMEoyYkpGRWM3WDd4QkFPYlJZRzdsazk1K3VjQWVU?=
 =?utf-8?B?WTNYSTNGYWc3eTJjd1AyaCthK1d4WVBmeFFKcFVCUGpBdHhlZHVwU2JZc3hB?=
 =?utf-8?B?bTJRT2ljYUNpWmRtZndabnJJL1dtOENoNDg5RyswVG1hSFlXTDIrYmdqR1gw?=
 =?utf-8?B?VWo5WmdVY0pGTHl4d1RuYi9ROFZZYmw4U3pQcVh2Wis3SE1PQnEyUHp5YW5Y?=
 =?utf-8?B?VTBUejIvUzR6ZkZScTV3cVVMNkdKV1YwaEVKeUUyTFFUZlhyN3ZOZEErdFFT?=
 =?utf-8?B?eGFZM25tZU9FTWhCSnRPYmpNOFhPV3hScXBKQjFtYlgwRU1HZGw2RTJ4NDZR?=
 =?utf-8?B?bjB0alUvSCttRVYxOXRNQUp4RFdPODBMeVFTYW44L0hlVzdoZmtQUHNUOW1v?=
 =?utf-8?B?N1RSRGY3VHdaeEJrQTY0TVpKUDRtV2hROUwweVAwaWhnRmhuWWZGNVFHc3V4?=
 =?utf-8?B?eWduQS9SUiswaEZaTU5MQ0k3dUNycnlqeFFNSzBhaExjMjFNcDhDdUNGa09j?=
 =?utf-8?B?dFpKUjBoSSs0UEdWZ2d4TTVsTGl3OE5YbEtQb3NvblFsdE1jTHg0VWxZODlY?=
 =?utf-8?B?UXkwNGFmUVN3VndWWVF1MCtJS2lrN281TDJ1aC8zR0x4T2NkbUpZcXpIeW1y?=
 =?utf-8?B?RjhMTVJlU3pQNXM4dHVCb1hoWnBrM0pCcVIxQlhGWmJ6cDFjRlZQeE83ZkdU?=
 =?utf-8?B?Ulo5cmJpYVFzRGhJLzBCK1FRNWxWR0IrSkt1S2dLcDhIMkpJTHhVTkROVHRz?=
 =?utf-8?B?VGpoM2dMMVNha0JWSE9KaW81Nk9Ec216dEdxdmFZWmZQdmlDT0NiY1U0VXJa?=
 =?utf-8?B?bVRlL3NFUmdDQ0drQUk5Q0szQmJna2ovVUgvblFXZ3F1N3F6NmFyaFpSSE9p?=
 =?utf-8?B?NkxYcVhLWXhVdEhDenU1dlFTblRyeE5JYVpVbmQvOW5ndkRFNkNpaFUwTW9V?=
 =?utf-8?B?QzNGbFBNbnhCNnlKcmtlYU5PV2o5SGpQaEFwTkhOWEpMK29adzg0SDlsKzRR?=
 =?utf-8?B?aDhPTUQ2OUU3Y3FiS21uQnJnT0x3cE11QTlVL0h2QWNFNW8rUkZWYmgrWlhh?=
 =?utf-8?B?UkphNEVKdTJwNGpkSExrZUhTZjNNRUtxOUkvb2swWTFPd0JIKzkwVy9wbSt3?=
 =?utf-8?B?aTcwaVppWHRtM2kwRGVNdGJwWWhyV3lsUTh6NGdRSnc0eUhScFpLL2VQa1hJ?=
 =?utf-8?B?cERQc0pYNmFjSTRYc29hbExsOHNwSElyRmczdXAzZEV3c1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjZma3l5ZG41SFJLV2hMa1VOeHhLRTlYeU1DL1JSTm9zVm1laERDVy9IdDVM?=
 =?utf-8?B?bDlyU0dTSHhMR1ViYk5XTUhxYzZLcWlvS203RzJNNDhPeDdGQmlkaHV6S2FZ?=
 =?utf-8?B?aUFXVXZQcGQyejd1NWRNbUlDOUJwRmNVNVVQTUJqWHdlb0tiTkRPYTN5SjVD?=
 =?utf-8?B?anRyMDRlNHczN0Q3U0pHaE5ySjIxRUJ6eWhyM1NJZXNxTzQva09BeFVmUHV5?=
 =?utf-8?B?Sm4vSUZxL1E2WStYRysvWFE0eDF2TEtZeTZLUEtwMnJ1dmgvcW1aeWhnbEsw?=
 =?utf-8?B?NUtPL21Wbm96amIzSXFETmhKSkRmTjdNVldDR2dPT2dRZU1NVEx1U1RMNXR3?=
 =?utf-8?B?Y3pTaEM1RFNHQms1UzBlbDlweUUxbGhFS29PaEVwSW44SGc0NjBXQ2RoSzBX?=
 =?utf-8?B?NExscklwM1k5TTB0N0VTSXVrT21uTi9qbHRrc1BTQURUYnF3WXFuWDJkZG5U?=
 =?utf-8?B?V0FhcmwzR2kyQjBnOXJTcXJOM2hJVDJETmhmZEVQamdDLzN6RnBJOFlEbHFO?=
 =?utf-8?B?VW0veS9NcHk3QkhrVHdhQ29rU1NleE5YdVBoaUoyQjl5eWtnODcwbm92LzNR?=
 =?utf-8?B?cGM0Nkhubk1aYU9pckV5eUt5NjBHSnZRU0dMeHpjMFBySGsvNXpzRGRVTkNv?=
 =?utf-8?B?bFpUZDZ4cDV5VlBlbGxqMUZoYzB5RGR4MkZRTXRSSTdWbm5jQ1JNRnZ0VEo1?=
 =?utf-8?B?MkU2WW9kTnZxUkt4OTJXWDVGVjE5UllISXBSYVR4NjR3a0xac3RHdFFDbkVK?=
 =?utf-8?B?bXFYenVia1hiaDZxSTRUOHUzRUtMRDZ4VUVEUlZVR3Z5UzIxTlZ5bTdYNkxl?=
 =?utf-8?B?Y1RzbStmakJXV25Qa050NWV6YWIzUG42L0g3bk1ENUxJWkRBVzRUNU0zTW1i?=
 =?utf-8?B?cjFWSll0cy9MdDNoK3p5cHVCRmkyVzZLY1pwTjFxSG40dnAzclNQK1pKZEU3?=
 =?utf-8?B?YnRSZk5zQmdSZkkzV2k0blJrdHlzSFYwOVZuUi9jbHZrMG1jdk9saHFQZDhC?=
 =?utf-8?B?VkxVZ2E4cTJDLzN5L05NWklIRXlXRTJHZkcvd2VMWk8vNnZsUUJWZk9RUFZo?=
 =?utf-8?B?ZWVLbHVZUFM4NmFKcnpOUUxvSWFqZjB3OTVQaE5JM1J4RlJiMmVoWE1WdWdO?=
 =?utf-8?B?ZkozODc4QnFTaUZKY2RKc3hjYXZFd0JOVDhZanN2Mk9pNTVQcm1SOEloU3Q1?=
 =?utf-8?B?NXBSeFllNktWWXZ2bUYvU1dJMnF1aDhSdGZyYnN0Y1gxdlBmMWMzcGx5R0lq?=
 =?utf-8?B?bXFPUzNZemlxajF6dFEyVHNTT1hMcDZ5b0x2eDJIZ0Q4cXJOQjBKWk5xbnRF?=
 =?utf-8?B?ci95NkF6YXY2VzQ5NWVXOVZ4anVpWS8raWJEZ2ExeXl5bFhRanNQalU4OUxr?=
 =?utf-8?B?MkJTNnFNOGJodUEyVW9PdVJFeFl5SmlNbzFFN2xMQkZYd0k0bWF2TFBQVjlw?=
 =?utf-8?B?S3piM3BBYUZEVHIwU3RHL3NINE1vVHppdkMyWGxoZFh2S0duZFZUdzhHYmhP?=
 =?utf-8?B?dUF4NVkvcjJiQndiNnpiK0JNRWRiNEgxRis5TjEyeFVyc1BkNDhEWmtxRGFP?=
 =?utf-8?B?TExNT3F6UkF3S1hDVndLT08zTTh5YUZ3aWlXa3FUcUdpZGtqUmRDc1A4amhM?=
 =?utf-8?B?UFJTQmtiTjZoWVlFRTRWcjlTZWxaT1JPSWVtZWZqZkNTSWJOdGRiWHJhazRQ?=
 =?utf-8?B?eUJSbjJGVndRZVc4VzFCMFNvdUFsblQwY3gwci9lRWsyRExPWmVwK1NNZ3Bj?=
 =?utf-8?B?RXNpa2MwREkvS0FNbWNWS2Ezc0JKK1J6UXR3YWtUcWVQVWVtNDVhQ1p1TlFx?=
 =?utf-8?B?UXRqY2I1ZVYvaGM2QmRCdjcvNkVoWExOYTNkRFUxL2ZTVmhUa3V6U1duZ1Jp?=
 =?utf-8?B?VlNpVTZWT3BIWW9LVG1ZNzAwbjFGOXB3WDlsWGsyMHJjTEx0QlNmTnErVnNQ?=
 =?utf-8?B?U3Y4UXRwTDJ4SU1Benl2YzJKS2VPT0ZRZTc4c200RVZNVURBNUxkaVA2SGo5?=
 =?utf-8?B?LzFZSHJQeTJVMTEvc1owSnMwdkFpRXk3eXdUVVlDOUxXMVJEUUhhWXQrM1B1?=
 =?utf-8?B?cUhVZ1VOTncxV0NzN2Nqdm5ha0hUT1QxM2tBNFpjN3RSUi9uZGZaRzcxR1Nx?=
 =?utf-8?B?dkNrQmpqY3h1TWdUUkZOZGgxQURnTU5CanA0TzJqZjZiQ1pkaWpZVXFxR0w2?=
 =?utf-8?B?bUpZRFZCVm45UTNZdlhMOENIRWM1NEZmZFlSbUpYeWpwU1RPbE4xWHJWNkkz?=
 =?utf-8?B?VGU3QjZaWnpkbFVNWkNwcGUxTDFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3CAE60D196FC4428F53CD0D7C9FC6E6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d144a693-185e-43a7-2171-08dd1940b9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 17:33:14.4747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNI/MID9GT+mp9mT59QYU1LqrVdtI/1b+BS5kLrI7EAOV0k67bjwSZ4NNYUQ6lR42cJ7FFqi/SUAcn7y0mhf7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3698

T24gVHVlLCAyMDI0LTEyLTEwIGF0IDEyOjEyIC0wNTAwLCBOaWtoaWwgSmhhIHdyb3RlOg0KPiBP
biBUdWUsIERlYyAxMCwgMjAyNCBhdCAwNzoxMTo0M0FNIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5n
dG9uIHdyb3RlOg0KPiA+IE9uIDkgRGVjIDIwMjQsIGF0IDEyOjM5LCBOaWtoaWwgSmhhIHdyb3Rl
Og0KPiA+IA0KPiA+ID4gSGVsbG8hIFRoaXMgaXMgdGhlIGZpcnN0IGtlcm5lbCBwYXRjaCBJIGhh
dmUgdHJpZWQgdG8gdXBzdHJlYW0uDQo+ID4gPiBJJ20NCj4gPiA+IGZvbGxvd2luZyBhbG9uZyB3
aXRoIHRoZSBrZXJuZWwgbmV3YmllcyBndWlkZSBidXQgYXBvbG9naWVzIGlmIEkNCj4gPiA+IGdv
dA0KPiA+ID4gYW55dGhpbmcgd3JvbmcuDQo+ID4gPiANCj4gPiA+IEN1cnJlbnRseSwgaWYgdGhl
cmUgaXMgYSBtaXNtYXRjaCBpbiB0aGUgcmVxdWVzdCBhbmQgcmVzcG9uc2UNCj4gPiA+IGZpbGVp
ZHMgaW4NCj4gPiA+IGFuIE5GUyByZXF1ZXN0LCB0aGUga2VybmVsIGxvZ3MgYW4gZXJyb3IgYW5k
IGF0dGVtcHRzIHRvIHJldHVybg0KPiA+ID4gRVNUQUxFLg0KPiA+ID4gSG93ZXZlciwgdGhpcyBl
cnJvciBpcyBjdXJyZW50bHkgZHJvcHBlZCBiZWZvcmUgaXQgbWFrZXMgaXQgYWxsDQo+ID4gPiB0
aGUgd2F5DQo+ID4gPiB0byB1c2Vyc3BhY2UuIFRoaXMgYXBwZWFycyB0byBiZSBhIG1pc3Rha2Us
IHNpbmNlIGFzIGZhciBhcyBJIGNhbg0KPiA+ID4gdGVsbA0KPiA+ID4gdGhhdCBFU1RBTEUgdmFs
dWUgaXMgbmV2ZXIgY29uc3VtZWQgZnJvbSBhbnl3aGVyZS4NCj4gPiA+IA0KPiA+ID4gQ2FsbHN0
YWNrIGZvciBhc3luYyBORlMgd3JpdGUsIGF0IHRpbWUgb2YgZXJyb3I6DQo+ID4gPiANCj4gPiA+
IMKgwqDCoMKgwqDCoMKgIG5mc191cGRhdGVfaW5vZGUgPC0gcmV0dXJucyAtRVNUQUxFDQo+ID4g
PiDCoMKgwqDCoMKgwqDCoCBuZnNfcmVmcmVzaF9pbm9kZV9sb2NrZWQNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgIG5mc193cml0ZWJhY2tfdXBkYXRlX2lub2RlIDwtIGVycm9yIGlzIGRyb3BwZWQgaGVy
ZQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgbmZzM193cml0ZV9kb25lDQo+ID4gPiDCoMKgwqDCoMKg
wqDCoCBuZnNfd3JpdGViYWNrX2RvbmUNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIG5mc19wZ2lvX3Jl
c3VsdCA8LSBvdGhlciBlcnJvcnMgYXJlIGNvbGxlY3RlZCBoZXJlDQo+ID4gPiDCoMKgwqDCoMKg
wqDCoCBycGNfZXhpdF90YXNrDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBfX3JwY19leGVjdXRlDQo+
ID4gPiDCoMKgwqDCoMKgwqDCoCBycGNfYXN5bmNfc2NoZWR1bGUNCj4gPiA+IMKgwqDCoMKgwqDC
oMKgIHByb2Nlc3Nfb25lX3dvcmsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIHdvcmtlcl90aHJlYWQN
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIGt0aHJlYWQNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIHJldF9m
cm9tX2ZvcmsNCj4gPiA+IA0KPiA+ID4gV2UgcmFuIGludG8gdGhpcyBpc3N1ZSBvdXJzZWx2ZXMs
IGFuZCBzZWVpbmcgdGhlIC1FU1RBTEUgaW4gdGhlDQo+ID4gPiBrZXJuZWwNCj4gPiA+IHNvdXJj
ZSBjb2RlIGJ1dCBub3QgZnJvbSB1c2Vyc3BhY2Ugd2FzIHN1cnByaXNpbmcuDQo+ID4gPiANCj4g
PiA+IEkgdGVzdGVkIGEgcmViYXNlZCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggb24gYW4gZWw4IGtl
cm5lbA0KPiA+ID4gKHY2LjEuMTE0KSwNCj4gPiA+IGFuZCBpdCBzZWVtcyB0byBjb3JyZWN0bHkg
cHJvcGFnYXRlIHRoaXMgZXJyb3IuDQo+ID4gPiANCj4gPiA+ID4gOC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTg8DQo+ID4gPiANCj4gPiA+IElm
IGFuIE5GUyBzZXJ2ZXIgcmV0dXJucyBhIHJlc3BvbnNlIHdpdGggYSBkaWZmZXJlbnQgZmlsZSBp
ZCB0bw0KPiA+ID4gdGhlDQo+ID4gPiByZXNwb25zZSwgdGhlIGtlcm5lbCBjdXJyZW50bHkgcHJp
bnRzIG91dCBhbiBlcnJvciBhbmQgYXR0ZW1wdHMNCj4gPiA+IHRvDQo+ID4gPiByZXR1cm4gLUVT
VEFMRS4gSG93ZXZlciwgdGhpcyAtRVNUQUxFIHZhbHVlIGlzIG5ldmVyIHN1cmZhY2VkDQo+ID4g
PiBhbnl3aGVyZS4NCj4gPiANCj4gPiBIaSBOaWtoaWwgSmhhLA0KPiA+IA0KPiA+IFdpbGwgdGhp
cyBjYXVzZSB1cyB0byByZXR1cm4gLUVTVEFMRSB0byB0aGUgYXBwbGljYXRpb24gZXZlbiBpZiB0
aGUNCj4gPiBXUklURQ0KPiA+IHdhcyBzdWNjZXNzZnVsPw0KPiA+IA0KPiA+IEJlbg0KPiA+IA0K
PiANCj4gSGkgQmVuLA0KPiANCj4gSG1tLi4gSSdtIG5vdCBzdXJlIGhvdyB0byBhbnN3ZXIgdGhh
dCBxdWVzdGlvbiBleGFjdGx5LiBBIGZpbGVpZCBpcw0KPiBvbmx5DQo+IG1pc21hdGNoZWQgYmV0
d2VlbiBhIHJlcXVlc3QgUlBDIGFuZCByZXNwb25zZSBSUEMgd2hlbiBzb21ldGhpbmcNCj4gcmVh
bGx5DQo+IHdlaXJkIGlzIGdvaW5nIG9uIChpLmUuIGEgYnVnIGluIHRoZSBORlMgc2VydmVyKSwg
c28gaXQncyBoYXJkIHRvDQo+IHJlYXNvbg0KPiBhYm91dCBpZiBhIFdSSVRFIHdhcyBzdWNjZXNz
ZnVsIG9yIG5vdC4NCj4gDQo+IFRoZSBgcmV0dXJuIC1FU1RBTEVgIHdhcyBhbHJlYWR5IGluIHRo
ZSBrZXJuZWwgY29kZSwgYnV0IHRoaXMNCj4gcGFydGljdWxhcg0KPiBjb2RlcGF0aCBzZWVtcyB0
byBoYXZlIGFjY2lkZW50YWxseSBkcm9wcGVkIHRoYXQgZXJyb3IuDQo+IA0KPiBOaWtoaWwNCj4g
DQoNCkknbSBub3Qga2VlbiBvbiB0YWtpbmcgYW55IGNsaWVudCBjaGFuZ2VzIHRvIHBhcGVyIG92
ZXIgd2hhdCBhcHBlYXJzIHRvDQpiZSBhIG1ham9yIHNlcnZlciBidWcuIFdlIHNpbXBseSBjYW4n
dCBzdXBwb3J0IGJyb2tlbiBzZXJ2ZXJzIHRoYXQNCnJldXNlIGZpbGVoYW5kbGVzIGFjcm9zcyBm
aWxlcy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

