Return-Path: <linux-nfs+bounces-4566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D814292476B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 20:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34188B22A4D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3931BB692;
	Tue,  2 Jul 2024 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iqN5I3id";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L6MY8wEB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D351DFE3
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945797; cv=fail; b=DmJxUWtPaXV0LZUzOFjws+zqxB8KHTSEVdcWiHZ2Ue3q27mEzU4DPAabsHnDWk8FXpUqUpqlqeHDuI7fcVlEuR4H4iMsMV5/gTQCKva0Sb+rU0HMCSTLuQrh+e6DO/+Z0/RN5dbS2fJVPg//9khAfBnAgdoXXdtZ3eo+eru7pUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945797; c=relaxed/simple;
	bh=ZLT33IVdYaNEfmnB40Mt3w1jCWS4VdFJS4SLKzdeCUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PXOPQpNfKwyshdDa/nDhBrDQzK1Lzo/7Noi9ysFGRSa9C5BrievYr23reoGKLqNIhsNd7mV8B2ODBScifHzACpbeWJ5+1l4/9n7afTepWGwgkb0bNaieEePpzrPImEtmH8m416qnRVDGos5JkMQAe8mKfIJfCvBG+9SKbF8Z5pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iqN5I3id; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L6MY8wEB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462HfSZi024365;
	Tue, 2 Jul 2024 18:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=ZLT33IVdYaNEfmnB40Mt3w1jCWS4VdFJS4SLKzdeC
	UI=; b=iqN5I3idIf+1TXEQFE1v423MuDKbfV0l9NxZDmW6B9DkbjHk3Q6Kxw71y
	WMa2OcEtDBhzBe/nnkP0GLv9fN+ljUL7jqfVEu7UFymwPpRXju5ySBVbtJ0VeysY
	UczGSjO8LzlFmb5Gyotp4z8X2Bfj4DXeb+OXpSLy9vq9P4lIhclNTa6IDI2vahA8
	7djc0YiFqqnklc/tf+zRKpMXwXU0LMkdULRPhZ8ys6WepvP+fpHXDzUjtEuZIEVy
	LPy8sKuFQCqNYHI1FIyCjcC9p8/tPZlZfO9sj8nsHUnBtNwAIcMT2aiGCxrrZrgv
	v5flZE24qvXNRKSjdTaYc47Q+EuVA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402922xjt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 18:43:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462I09ua035749;
	Tue, 2 Jul 2024 18:43:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q8054m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 18:43:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/Ze3drozSn9nV1puRmxJCAdnrrfamCtsFpT14VtAxY/tkZPDKl61ZZRFQg15odks43X1FGGFCRMnC//njhIZ1WVZOeWteetLYHrhuhFZgA2uAw/h/qtGVkFLk21pJ3ep2e37uQlNm1DaBWuY46T7hp6kmFSrcHGh0CeiDpktuFcK2zqojaCiJNgXyM7NoBDzZmOLsHPX6pZ7B5sFnUcV5qJUYpP6/3zpSCg8BlPEzT7Zd2LsnNmX9h4RgEtzSrG8a1dQ6uFz+B+YcPbHL6ttpiLizFZBMPsLfMSvAh84iwAEnnNfchC1+dszG2Otez0v7y6aY3xSyONUHtZOJFHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLT33IVdYaNEfmnB40Mt3w1jCWS4VdFJS4SLKzdeCUI=;
 b=DIitoSHy9Y/8okAV+oPaeThzrTzpfhHxZnJHho8/t0L85kdyBIWR4LV5WyAGDjXNiHtugfLhApbvVFQa2FeaUslqBC25bSgaeAMHuKxOMhWxHVhbuinWEqbFGUrKtfz54MiiVdS8f9SdQpC27LEAFq2ppT7tXNidQaMyuB5eOy6kFLZT+IQesvQo3UdBz8ZEsMYfrCNhBGzd49xSOaMhdFvhMhAuw9egDkqGgVQzpsLEsy/ZzR8WGtQF6zFlET/wVCiQjRdU6jMBLGuElJy3mCPKnDHzoyMxIbFsChFPAYkSn5whlid26kRplUOuTM3ooOnGT4xGcJRnb/0rc0pf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLT33IVdYaNEfmnB40Mt3w1jCWS4VdFJS4SLKzdeCUI=;
 b=L6MY8wEBr3dy1jKWKy///CE+eX8D9NJD3jJFH51As1g1eFiOKWMciZpapTeJ9HPvpaAHvSPJ6znlQm9JoR5NfHW6s2laN/ypCgPOlsUCeF9WyS686Zq4PZWg25K5QIa4mkaU7yHwxkkk6z4BxNEv+ZgFWHjfWsO32Oy1vP/lJqM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5859.namprd10.prod.outlook.com (2603:10b6:a03:3ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 18:43:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 18:43:00 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<dai.ngo@oracle.com>
Subject: Re: [RFC PATCH 5/6] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Thread-Topic: [RFC PATCH 5/6] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Thread-Index: AQHazK3y32l+VD0JmkKmvfie7HJrrrHjxesA
Date: Tue, 2 Jul 2024 18:43:00 +0000
Message-ID: <8564FF4F-FAAF-4DEB-8DCD-0736154084CF@oracle.com>
References: <20240702151947.549814-8-cel@kernel.org>
 <20240702151947.549814-13-cel@kernel.org>
 <CAN-5tyHKV-DP9FK0s9J+6j2uHMvK_8TKqeMh5=GZ81+424xntw@mail.gmail.com>
In-Reply-To: 
 <CAN-5tyHKV-DP9FK0s9J+6j2uHMvK_8TKqeMh5=GZ81+424xntw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5859:EE_
x-ms-office365-filtering-correlation-id: c0b95a7c-e02a-4ad6-26eb-08dc9ac6ccb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?amdjYWRSYzN2TFNKbG9GK2xTTE9ObHdTdUhnOWxsR0d4TllGRU5EMjdvbjhZ?=
 =?utf-8?B?bEczZnZjRXFONm1udDF2S0lBWERvMi9ISEwrRTNTMGpHN3E5UjE5Tng2QlFz?=
 =?utf-8?B?TUlxaytQYkFQVkVuQkFCcE9hSzVhOFhSM1ZEcC9GNHRCaEJUTFVUWGovWHVl?=
 =?utf-8?B?VzR6WEt2ZnMzeHB1d25Wdm9kelpHK1EvVmpNRXg2VjVkcDliZGdCOVhqcWFo?=
 =?utf-8?B?dXhUNEpGdU1GMkM1RUwyOUFQa0E1dHBGbmtBdnR5cmVZTGNyVVRMcTI1WDhz?=
 =?utf-8?B?MUUzVitrRnFSbjd5L0lhSjJpY0JDaUcrRkNublhDQzhQREowOEtLZUN2VklE?=
 =?utf-8?B?dzhYVHZRTXQ1MDE4M2cxSS9TRU0yNTJKVDd6Zis5VzZjYXFtcGZEWlBaVmxC?=
 =?utf-8?B?WVkrL3NzWlFUT0RwclR6bkxEWUo3MUpPcnVjSmhkRVlmNmVZZlZ2MXdXem41?=
 =?utf-8?B?dmZNUVRKcmtWbmpRdHVQb083R0hSQSsrYkJmcWlGMEM0NFFxMFducmk0enZp?=
 =?utf-8?B?d3MvVC9HQURrVmgxZUQrUU5nTVF1TkpKRlRtbEphSk54ZDNpbzFlK0JwN1Zo?=
 =?utf-8?B?bWI5ajY4TnQ2K3k4MDRTS2kvZWNzZDdTMnVaeXlyQ3hmczRFajhobFYwZG00?=
 =?utf-8?B?eW5WNG4xNEdTK2U0dUdTMGJzaU15V0pkdVFUNnZGN0ZtalhIc3dtNzkwMjNZ?=
 =?utf-8?B?enBYNndzck1makVLdnBPNVF3VlFRNnRXNlNvZjFUL3hIL3psc0tYM2tZSUVm?=
 =?utf-8?B?RjFmK3NpVllPNXhNcjJsZVBDODF5MW1rVlcrZnlqN2VtMCtibExkVjdXY3ZY?=
 =?utf-8?B?d09EWVRLMzJpRXBtNnM4akNGUk05N29Jbm1HdEZTSTNQSTdvS01PRDErRlRR?=
 =?utf-8?B?NzcrSHk3cHRvM0RSVGpoalF5MGZWaVFGaUJieSt5UjBzL3B1bFFPQzNLWU9z?=
 =?utf-8?B?c1lkVmZDVTdSZWdJa0FWOWxsNFM1STVTRWVpb2swM1RmWDFURkcxV1pKMjNB?=
 =?utf-8?B?OTcxdk83S1ppRkxiWWF3ZWJoeUVPdEdKaE04NTJWYjFWNzc3cEtvQTNUeEYw?=
 =?utf-8?B?V2VGNkVFeS9DclNhM20wa1k5aklUQjV2eHNhd0dyUFZXQ1BPVHRlNGtUQlI5?=
 =?utf-8?B?WWJjS21uWkNnMUlVbVp4UVVUc1I0WEhhRnlBUm5BT2ZYeStkZGMwRVdWNC9E?=
 =?utf-8?B?dnVuNUNkalVKVnd6eDh5TUNKbnd6RjYxMWI4RDFhVzBJZUVaZXErU0hkaDJV?=
 =?utf-8?B?OEtjbGVzZ3VOam9qREhWd3U2T0dBaDk2RDU1N3MxY1A2cEtWbml4aUxQYWVr?=
 =?utf-8?B?Y2FyZmFTMXFMM3FlQms2MDZ3T2VqOEpLRXhtZC9ORW56b1ZvT3dERTB1UGVN?=
 =?utf-8?B?cWJINytGQTJwb0cwYkhUUjVuUlZkOTlsZlIrZWxOdFgyVlk5N2c3bVZwSDFr?=
 =?utf-8?B?N2Z2bXRaTWJBazh4QjArWW5QZUk5YisrenVQZGJjOWJoeUR6NXkwWDhKK0ov?=
 =?utf-8?B?eWpEQW15bTg5SjlYcytQT3p6MCtOdGo0dzRFTFhYWGlxU3hKQ1g5L3pLdWha?=
 =?utf-8?B?blExM2RVaEpVMWQ2aThKQ1poRzVWZmVhbUh2T1hxZElGenlHZ284aE9NajFx?=
 =?utf-8?B?U1NBRlBPTGlkb1YwTUhCUm5XZVFmbnRlQ050NnNvSjdWSmRNejNkUWFqM1U1?=
 =?utf-8?B?VjZvdWdiUU5uQ1l2eUVPMmpCZ0tVbjM4TzA5ZkhZYXdZdExsUHlIbWJMc282?=
 =?utf-8?B?SGY1MVd4cHJ1RExtTGtQU2YvYWlkT3Y2U0JGekhBVzdwM1czM1BuWlRJSmVK?=
 =?utf-8?Q?eVMStAFiPsTkeDBMVGI8o3RTqV5kxliQs5DXM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dlE2SXNJNXRwVlNQTDhYcDBxLzI5UGM0VW8rTEpIZ2lYNGsxdVdXRUtBcGFF?=
 =?utf-8?B?OGkzanIwaGU5TGdXT0xTQTExOEp2VVpPd0JDbUc5VTZSMDJjUlFCYWNCdkxa?=
 =?utf-8?B?bHpZUzU0YzBCN0xYZHFPSHpDRWNGZXI2M2dza0VmVXk3elB2QXZWSnpjM0g1?=
 =?utf-8?B?MUhrZ3N6ZTZ0WTJOc2daSlYrazU4STJXTlVxdE5CbVlpY3A3M3hPZ0pjaDlV?=
 =?utf-8?B?VzBFdDdHSEEyWjZyQXRCQzFFQjVwbjZGTWNhRjFKK042MTh4U1BRQkNuMlI0?=
 =?utf-8?B?UU5LaGVueWpnOVhNT011SlFZMXo1WU9KZVlKc3JJcVUwMzZBTW9obXVnUHNn?=
 =?utf-8?B?T05Ydmw1d09KSGVEZGI3YTlzK0RRa2tDYk5tUHZpalRnbEJwS3FpZmx5T3lN?=
 =?utf-8?B?VEQvNnpwYVIyWWNtUWRZL1FmWndLdVJrVDBZSGp5WGZ3dERtR2JvdWlHWHJx?=
 =?utf-8?B?a01YamNxNDZOMVlNbEN2d3VrZnJFS2tZOEtuTnBhU2xUMDQ0Q0hMajVuazZR?=
 =?utf-8?B?MG1SOVJxem9PMDhtZHFqMEJuOUF6V28zMDAvRXBrbWpvaEN3WnBZZmpaaW9q?=
 =?utf-8?B?Uk00SFdNSnphYUgyMGRLdHBMbVFDVFU1V2xuZzM2bk1DYWRFcFkycFRLVkls?=
 =?utf-8?B?UytESGUvM3RwWHkza29ubmc2cy9Hd1ZsQzJ0R2JmNTE3WU04SjFLL09HMDBV?=
 =?utf-8?B?b2pqQW5HdjFkeHlOTmtlNEJsbDRUL3NicCtXeDgzT1AzK3UzQ1VubTRReDcv?=
 =?utf-8?B?VFk3THd2aGM1WSs5bE1iQWw4anV6U1BQVW9sUktFRGdxL3FRSUxXdlloZVBX?=
 =?utf-8?B?NVl0eHczRW5MQ21LL1RYNG5wUTJlNjhzdGx0aDdUNUpTTWVjb0ZDMTd3QlhU?=
 =?utf-8?B?eUNleHIvVnhJVFpjbHNhREllWjdmcDVzYVZLS3Z5MS9xK0ErRjlLcnpOMlFE?=
 =?utf-8?B?ZXRiZEprd3UyakxlV2MrK2xpdE5XVEdQS3dXRlZPWEpwTVVud2JKY1VKTWRW?=
 =?utf-8?B?ZG14SEpQNlc1OXREbVpLSm5zalJVOGVBS1gwYXNGTEZwQ3VCN3FmQjI2dkth?=
 =?utf-8?B?a1hCaGRsM2hHY1V1V2tsMjR4Um5KYk9CbGZJSUpqZVZtb1FnZzUzTEpWc0Fz?=
 =?utf-8?B?eHpQV3htWjZsazc4NlZueTZzdzRDMkFFS0ZKdVI5cUlFak5CSXFOYjNDR1B6?=
 =?utf-8?B?NEl1SUt3QURQdmFNWVRoMmJNWU8zU2MyNGdHeVUreTBFdXdXOXJSRjZIb3FU?=
 =?utf-8?B?SjUrUG5rQkZxU2xKaUpGZkRmRE50TTd3VWFhdHA3YW4yMTFQd1ZtMWRRbVU5?=
 =?utf-8?B?SEdRTHdXdFdRYU0zbW92ZS9ialNEaUlJVXBLdFFsSlkxUmNrZnFhbHBIcVdU?=
 =?utf-8?B?M3JaUElTdWpEaCtiT1dkd1loODlIMWlkaGYya2pudThuKzdwU1BBYW5iTnUx?=
 =?utf-8?B?a3lEbUUydlI4Zkx5WGRtM1VldUlWVE9ValJUZ0I5VEhrQUZ5a1hUdzB2YmF2?=
 =?utf-8?B?SFpicENBNWVRUm4vMUp2NDMrZE4yTS9KM3AwajFNSVNxRTZQS01ueGRVTVE3?=
 =?utf-8?B?VGZuVUNGeE1INXlpT0tDb1JIUWZPSExKbDZEV3daUDUyNWczTWtFS0NQcG9r?=
 =?utf-8?B?VTVXeGZMclhrWlFid2VHV2M2aWFBNmdJQjVmM1dYeFBnRWtlRDVITmo0VTNr?=
 =?utf-8?B?aWRmaEk1L0dHMDZCYmY3TEd1dEl5ZTV4OWZQeWZDQVNmU1VUQklBWC9halhI?=
 =?utf-8?B?M2xSOW93RHNaM0JiMlh2ZDZXK0pGVTdLSElYRGtxNStHTldtbGZ2dG5VQ2pH?=
 =?utf-8?B?SzloS0hJUlJoaHhDaWNRUndsOEk2U1JhaXlET2dvRkQ4bStNM254UWE0czls?=
 =?utf-8?B?eS9xSVkrNmRwZW44ZW5rVFFlMGppN2srMGIxK0IzMEVzUXlmNFN6WjdyaUZT?=
 =?utf-8?B?eUhMZmlQMFpTSUc1bGhCMWRlZENLZEVnVjBSeXB3VVA2MHZuc3BOcm1QbHVI?=
 =?utf-8?B?N01OYzU0WUkrNTl1TlJ0ck1xNnRpRjA1RFpMMjBlNHkvMmdBaEtBTkttY3dr?=
 =?utf-8?B?dHNwTC9qeURrRU8zOG1Xd0FpVktxcXRQeWYzeVJPOE5vSnFLSUdxQUZmSkhO?=
 =?utf-8?B?eGUrTCsvUjBwb01tNG54NEZSRXpyNFVxNjVNUGgveVdWL0JLNHdVekdibVRZ?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F141C2347648EB43806466D5A1CE2DD3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+dGu4IqytIFWv6FWJH9d3LtvXoNxycgiFXrTTNjRL7ZP8YSBnAUI/eCroyWHapRH12cBB8RABIVTFptQ6O0FvZ57bXZj9Y7SgGoO9/rNA8ZheOCqdZ4x4/4eX9dRb7LoVHylj66xoWfnMjSpBt8jrJwAd0kiwfB/ThWCg0JWEz1Tqm/SUJcPrDrHEP6J0pUO6CrMZ1OUq//Q+9emUQKlCWLEU0nJa5Iz/P1XPVJecK0Twk0P/8K+6kWQcsRbP3U05AfzVw9bCoBLisy19bYHziHQqnM9zqNo22NpW59XULKNo5g5JyuqgpU23qY0+ETa85s2Vgn6+bcTIgUQick5DE8sJcd/uYYrHpqImy9jPCWrbAlxXTTstybc9V1Qwc8SvveIUAffC4SLbKgpGfOl88XFArdLR60CxRnlkxUNHcwtayTaU8fkruoD7c6bjp3ZL0AkOSPZGweTC5MD2GIr2sPIGBPVBCHHnywovcUqb833kcqm9Yhm8BmbD7bzzDLiYqfIcM3id3GFE4aJ94blhefiADzTwTp6dbtnzHxaNXaV1JxIpfcA2RyhZR8nGKAdumoZLJ1vWvlNUivduM5VTJPmx0DtC361q5sfCqQj8MU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b95a7c-e02a-4ad6-26eb-08dc9ac6ccb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 18:43:00.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0YKFuae3ZGlYgh4l03iE6fpjc4JAQdxlLIBnxN4o0EyQJS4e1p04QblcRU10Q81LK7S2RaeZqcuq46i9MY+6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_14,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407020136
X-Proofpoint-GUID: x4Ihb9DVMjGYQwtO8Vaj8psNfRP-vBRB
X-Proofpoint-ORIG-GUID: x4Ihb9DVMjGYQwtO8Vaj8psNfRP-vBRB

DQoNCj4gT24gSnVsIDIsIDIwMjQsIGF0IDI6MzDigK9QTSwgT2xnYSBLb3JuaWV2c2thaWEgPGFn
bG9AdW1pY2guZWR1PiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVsIDIsIDIwMjQgYXQgMTE6MjHi
gK9BTSA8Y2VsQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBGcm9tOiBDaHVjayBMZXZlciA8
Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+IA0KPj4gV2UndmUgZm91bmQgdGhhdCB0aGVyZSBh
cmUgY2FzZXMgd2hlcmUgYSB0cmFuc3BvcnQgZGlzY29ubmVjdGlvbg0KPj4gcmVzdWx0cyBpbiB0
aGUgbG9zcyBvZiBjYWxsYmFjayBSUENzLiBORlMgc2VydmVycyB0eXBpY2FsbHkgZG8gbm90DQo+
PiByZXRyYW5zbWl0IGNhbGxiYWNrIG9wZXJhdGlvbnMgYWZ0ZXIgYSBkaXNjb25uZWN0Lg0KPj4g
DQo+PiBUaGlzIGNhbiBiZSBhIHByb2JsZW0gZm9yIHRoZSBMaW51eCBORlMgY2xpZW50J3MgY3Vy
cmVudA0KPj4gaW1wbGVtZW50YXRpb24gb2YgYXN5bmNocm9ub3VzIENPUFksIHdoaWNoIHdhaXRz
IGluZGVmaW5pdGVseSBmb3IgYQ0KPj4gQ0JfT0ZGTE9BRCBjYWxsYmFjay4gSWYgYSB0cmFuc3Bv
cnQgZGlzY29ubmVjdCBvY2N1cnMgd2hpbGUgYW4gYXN5bmMNCj4+IENPUFkgaXMgcnVubmluZywg
dGhlcmUncyBhIGdvb2QgY2hhbmNlIHRoZSBjbGllbnQgd2lsbCBuZXZlciBnZXQgdGhlDQo+PiBj
b21wbGV0aW5nIENCX09GRkxPQUQuDQo+PiANCj4+IEZpeCB0aGlzIGJ5IGltcGxlbWVudGluZyB0
aGUgT0ZGTE9BRF9TVEFUVVMgb3BlcmF0aW9uIHNvIHRoYXQgdGhlDQo+PiBMaW51eCBORlMgY2xp
ZW50IGNhbiBwcm9iZSB0aGUgTkZTIHNlcnZlciBpZiBpdCBkb2Vzbid0IHNlZSBhDQo+PiBDQl9P
RkZMT0FEIGluIGEgcmVhc29uYWJsZSBhbW91bnQgb2YgdGltZS4NCj4+IA0KPj4gVGhpcyBwYXRj
aCBpbXBsZW1lbnRzIGEgc2ltcGxpc3RpYyBjaGVjay4gQXMgZnV0dXJlIHdvcmssIHRoZSBjbGll
bnQNCj4+IG1pZ2h0IGFsc28gYmUgYWJsZSB0byBkZXRlY3Qgd2hldGhlciB0aGVyZSBpcyBubyBm
b3J3YXJkIHByb2dyZXNzIG9uDQo+PiB0aGUgcmVxdWVzdCBhc3luY2hyb25vdXMgQ09QWSBvcGVy
YXRpb24sIGFuZCBDQU5DRUwgaXQuDQo+PiANCj4+IFN1Z2dlc3RlZC1ieTogT2xnYSBLb3JuaWV2
c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+PiBMaW5rOiBodHRwczovL2J1Z3ppbGxhLmtlcm5l
bC5vcmcvc2hvd19idWcuY2dpP2lkPTIxODczNQ0KPj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2
ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+IGZzL25mcy9uZnM0MnByb2Mu
YyB8IDQwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4+IDEgZmls
ZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZm
IC0tZ2l0IGEvZnMvbmZzL25mczQycHJvYy5jIGIvZnMvbmZzL25mczQycHJvYy5jDQo+PiBpbmRl
eCBjNTUyNDdkYThlNDkuLjI0NjUzNGJmYzk0NiAxMDA2NDQNCj4+IC0tLSBhL2ZzL25mcy9uZnM0
MnByb2MuYw0KPj4gKysrIGIvZnMvbmZzL25mczQycHJvYy5jDQo+PiBAQCAtMTc1LDYgKzE3NSwx
MSBAQCBpbnQgbmZzNDJfcHJvY19kZWFsbG9jYXRlKHN0cnVjdCBmaWxlICpmaWxlcCwgbG9mZl90
IG9mZnNldCwgbG9mZl90IGxlbikNCj4+ICAgICAgICByZXR1cm4gZXJyOw0KPj4gfQ0KPj4gDQo+
PiArLyogV2FpdCB0aGlzIGxvbmcgYmVmb3JlIGNoZWNraW5nIHByb2dyZXNzIG9uIGEgQ09QWSBv
cGVyYXRpb24gKi8NCj4+ICtlbnVtIHsNCj4+ICsgICAgICAgTkZTNDJfQ09QWV9USU1FT1VUICAg
ICAgPSA1ICogSFosDQo+PiArfTsNCj4+ICsNCj4+IHN0YXRpYyBpbnQgaGFuZGxlX2FzeW5jX2Nv
cHkoc3RydWN0IG5mczQyX2NvcHlfcmVzICpyZXMsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IG5mc19zZXJ2ZXIgKmRzdF9zZXJ2ZXIsDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IG5mc19zZXJ2ZXIgKnNyY19zZXJ2ZXIsDQo+PiBAQCAtMTg0LDkg
KzE4OSwxMCBAQCBzdGF0aWMgaW50IGhhbmRsZV9hc3luY19jb3B5KHN0cnVjdCBuZnM0Ml9jb3B5
X3JlcyAqcmVzLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgKnJlc3RhcnQp
DQo+PiB7DQo+PiAgICAgICAgc3RydWN0IG5mczRfY29weV9zdGF0ZSAqY29weSwgKnRtcF9jb3B5
ID0gTlVMTCwgKml0ZXI7DQo+PiAtICAgICAgIGludCBzdGF0dXMgPSBORlM0X09LOw0KPj4gICAg
ICAgIHN0cnVjdCBuZnNfb3Blbl9jb250ZXh0ICpkc3RfY3R4ID0gbmZzX2ZpbGVfb3Blbl9jb250
ZXh0KGRzdCk7DQo+PiAgICAgICAgc3RydWN0IG5mc19vcGVuX2NvbnRleHQgKnNyY19jdHggPSBu
ZnNfZmlsZV9vcGVuX2NvbnRleHQoc3JjKTsNCj4+ICsgICAgICAgaW50IHN0YXR1cyA9IE5GUzRf
T0s7DQo+PiArICAgICAgIHU2NCBjb3BpZWQ7DQo+PiANCj4+ICAgICAgICBjb3B5ID0ga3phbGxv
YyhzaXplb2Yoc3RydWN0IG5mczRfY29weV9zdGF0ZSksIEdGUF9LRVJORUwpOw0KPj4gICAgICAg
IGlmICghY29weSkNCj4+IEBAIC0yMjQsNyArMjMwLDkgQEAgc3RhdGljIGludCBoYW5kbGVfYXN5
bmNfY29weShzdHJ1Y3QgbmZzNDJfY29weV9yZXMgKnJlcywNCj4+ICAgICAgICAgICAgICAgIHNw
aW5fdW5sb2NrKCZzcmNfc2VydmVyLT5uZnNfY2xpZW50LT5jbF9sb2NrKTsNCj4+ICAgICAgICB9
DQo+PiANCj4+IC0gICAgICAgc3RhdHVzID0gd2FpdF9mb3JfY29tcGxldGlvbl9pbnRlcnJ1cHRp
YmxlKCZjb3B5LT5jb21wbGV0aW9uKTsNCj4+ICt3YWl0Og0KPj4gKyAgICAgICBzdGF0dXMgPSB3
YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGVfdGltZW91dCgmY29weS0+Y29tcGxldGlv
biwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTkZTNDJfQ09QWV9USU1FT1VUKTsNCj4+ICAgICAgICBzcGluX2xvY2soJmRzdF9z
ZXJ2ZXItPm5mc19jbGllbnQtPmNsX2xvY2spOw0KPj4gICAgICAgIGxpc3RfZGVsX2luaXQoJmNv
cHktPmNvcGllcyk7DQo+PiAgICAgICAgc3Bpbl91bmxvY2soJmRzdF9zZXJ2ZXItPm5mc19jbGll
bnQtPmNsX2xvY2spOw0KPj4gQEAgLTIzMywxMiArMjQxLDE3IEBAIHN0YXRpYyBpbnQgaGFuZGxl
X2FzeW5jX2NvcHkoc3RydWN0IG5mczQyX2NvcHlfcmVzICpyZXMsDQo+PiAgICAgICAgICAgICAg
ICBsaXN0X2RlbF9pbml0KCZjb3B5LT5zcmNfY29waWVzKTsNCj4+ICAgICAgICAgICAgICAgIHNw
aW5fdW5sb2NrKCZzcmNfc2VydmVyLT5uZnNfY2xpZW50LT5jbF9sb2NrKTsNCj4+ICAgICAgICB9
DQo+PiAtICAgICAgIGlmIChzdGF0dXMgPT0gLUVSRVNUQVJUU1lTKSB7DQo+PiAtICAgICAgICAg
ICAgICAgZ290byBvdXRfY2FuY2VsOw0KPj4gLSAgICAgICB9IGVsc2UgaWYgKGNvcHktPmZsYWdz
IHx8IGNvcHktPmVycm9yID09IE5GUzRFUlJfUEFSVE5FUl9OT19BVVRIKSB7DQo+PiAtICAgICAg
ICAgICAgICAgc3RhdHVzID0gLUVBR0FJTjsNCj4+IC0gICAgICAgICAgICAgICAqcmVzdGFydCA9
IHRydWU7DQo+PiArICAgICAgIHN3aXRjaCAoc3RhdHVzKSB7DQo+PiArICAgICAgIGNhc2UgMDoN
Cj4+ICsgICAgICAgICAgICAgICBnb3RvIHRpbWVvdXQ7DQo+PiArICAgICAgIGNhc2UgLUVSRVNU
QVJUU1lTOg0KPj4gICAgICAgICAgICAgICAgZ290byBvdXRfY2FuY2VsOw0KPj4gKyAgICAgICBk
ZWZhdWx0Og0KPj4gKyAgICAgICAgICAgICAgIGlmIChjb3B5LT5mbGFncyB8fCBjb3B5LT5lcnJv
ciA9PSBORlM0RVJSX1BBUlRORVJfTk9fQVVUSCkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgc3RhdHVzID0gLUVBR0FJTjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICpyZXN0YXJ0
ID0gdHJ1ZTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X2NhbmNlbDsNCj4+
ICsgICAgICAgICAgICAgICB9DQo+PiAgICAgICAgfQ0KPj4gb3V0Og0KPj4gICAgICAgIHJlcy0+
d3JpdGVfcmVzLmNvdW50ID0gY29weS0+Y291bnQ7DQo+PiBAQCAtMjUzLDYgKzI2NiwxOSBAQCBz
dGF0aWMgaW50IGhhbmRsZV9hc3luY19jb3B5KHN0cnVjdCBuZnM0Ml9jb3B5X3JlcyAqcmVzLA0K
Pj4gICAgICAgIGlmICghbmZzNDJfZmlsZXNfZnJvbV9zYW1lX3NlcnZlcihzcmMsIGRzdCkpDQo+
PiAgICAgICAgICAgICAgICBuZnM0Ml9kb19vZmZsb2FkX2NhbmNlbF9hc3luYyhzcmMsIHNyY19z
dGF0ZWlkKTsNCj4+ICAgICAgICBnb3RvIG91dF9mcmVlOw0KPj4gK3RpbWVvdXQ6DQo+PiArICAg
ICAgIHN0YXR1cyA9IG5mczQyX3Byb2Nfb2ZmbG9hZF9zdGF0dXMoc3JjLCBzcmNfc3RhdGVpZCwg
JmNvcGllZCk7DQo+PiArICAgICAgIHN3aXRjaCAoc3RhdHVzKSB7DQo+PiArICAgICAgIGNhc2Ug
MDoNCj4+ICsgICAgICAgY2FzZSAtRVJFTU9URUlPOg0KPj4gKyAgICAgICAgICAgICAgIHJlcy0+
d3JpdGVfcmVzLmNvdW50ID0gY29waWVkOw0KPj4gKyAgICAgICAgICAgICAgIG1lbWNweSgmcmVz
LT53cml0ZV9yZXMudmVyaWZpZXIsICZjb3B5LT52ZXJmLCBzaXplb2YoY29weS0+dmVyZikpOw0K
Pj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0X2ZyZWU7DQo+IA0KPiBTZXR0aW5nIGFzaWRlIHRo
ZSBncm91cGluZyB0aGVzZSAyY2FzZXMgdG9nZXRoZXIsIEkgZG9uJ3QgdW5kZXJzdGFuZA0KPiB3
aHkgdGhlIGFzc3VtcHRpb24gdGhhdCBpZiB3ZSByZWNlaXZlZCBhIHJlcGx5IGZyb20gT0ZGTE9B
RF9TVEFUVVMNCj4gd2l0aCBzb21lIHZhbHVlIGJhY2sgbWVhbnMgdGhhdCB3ZSBzaG91bGQgY29u
c2lkZXIgY29weSBkb25lPyBTYXkgdGhlDQo+IGNvcHkgd2FzIGZvciAxTSwgY2xpZW50IHF1ZXJp
ZWQgYW5kIGdvdCBiYWNrIHRoYXQgNTAwTSBkb25lLCBJIGRvbid0DQo+IHRoaW5rIHRoZSBzZXJ2
ZXIgYnkgcmVwbHlpbmcgdG8gdGhlIE9GRkxPQURfU1RBVFVTIHNheXMgaXQncyBkb25lIHdpdGgN
Cj4gdGhlIGNvcHk/IEkgdGhpbmsgaXQgcmVwbGllcyB3aXRoIGhvdyBtdWNoIHdhcyBkb25lIGJ1
dCBpdCBtaWdodCBzdGlsbA0KPiBiZSBpbnByb2dyZXNzPyBTbyBzaG91bGRuJ3Qgd2UgY2hlY2sg
dGhhdCBldmVyeXRoaW5nIHdhcyBkb25lIGFuZCBpZg0KPiBub3QgZG9uZSBnbyBiYWNrIHRvIHdh
aXRpbmcgYWdhaW4/DQoNClRoZSBzZXJ2ZXIgcmVzcG9uZHMgdG8gT0ZGTE9BRF9TVEFUVVMgaW4g
b25lIG9mIHRoZSBmb2xsb3dpbmcgd2F5czoNCg0KMS4gbmZzc3RhdCA9IE5GUzRfT0sNCg0KMWEu
IG9zcl9jb21wbGV0ZSBoYXMgc2l6ZSB6ZXJvLiBUaGlzIG1lYW5zIHRoZSBjb3B5IGlzIHN0aWxs
IGluIHByb2dyZXNzLg0KICAgIG9zcl9jb3VudCBjb250YWlucyB0aGUgbnVtYmVyIG9mIGJ5dGVz
IGNvcGllZCBzbyBmYXIuDQoNCjFiLiBvc3JfY29tcGxldGUgaGFzIHNpemUgb25lLCBhbmQgY29u
dGFpbnMgTkZTNF9PSy4gVGhpcyBtZWFucyB0aGUNCiAgICBjb3B5IG9wZXJhdGlvbiBoYXMgY29t
cGxldGVkLiBvc3JfY291bnQgY29udGFpbnMgdGhlIHRvdGFsDQogICAgbnVtYmVyIG9mIGJ5dGVz
IGNvcGllZC4NCg0KMWMuIG9zcl9jb21wbGV0ZSBoYXMgc2l6ZSBvbmUsIGFuZCBjb250YWlucyBh
biBlcnJvciBzdGF0dXMuIFRoaXMgbWVhbnMNCiAgICB0aGUgY29weSBmYWlsZWQuIG9zcl9jb3Vu
dCBjb250YWlucyB0aGUgdG90YWwgbnVtYmVyIG9mIGJ5dGUNCiAgICB0aGF0IHdlcmUgY29waWVk
IGJlZm9yZSB0aGUgZmFpbHVyZSBvY2N1cnJlZC4NCg0KMi4gbmZzc3RhdCAhPSBORlM0X09LIGdl
bmVyYWxseSBtZWFucyB0aGF0IHRoZSBzZXJ2ZXIgZG9lcyBub3QNCiAgIHJlY29nbml6ZSB0aGUg
Y29weSBzdGF0ZWlkLg0KDQpTbywgeWVzLCB0aGUgY2xpZW50IGNhbiBjaGVjaywgYmFzZWQgb24g
dGhpcyBpbmZvcm1hdGlvbiwgd2hldGhlcg0KaXQgbmVlZHMgdG8gd2FpdCwgcmV0cnksIG9yIGFi
b3J0LiBUaGUgY29kZSBJIGFkZGVkIGlzIG5vdCB0ZXN0ZWQNCnNvIHRoZSBuZXcgbG9naWMgaXMg
bm90IHRvdGFsbHkgY29ycmVjdC4gQW5kIHdlIGNhbiByZWZpbmUgdGhpcw0KbG9naWMgdG8gbWF0
Y2ggb3VyIHByZWZlcnJlZCByZXNwb25zZXMsIGFzIHlvdSBsaXN0ZWQgYWJvdmUuDQoNCg0KPiBB
Z2FpbiBJIGRvbid0IHRoaW5rIHRoaXMgYXBwcm9hY2ggaXMgZ29pbmcgdG8gd29yayBiZWNhdXNl
IG9mIGhvdw0KPiBjYWxsYmFjayBhbmQgdGhlIGNvcHkgdGhyZWFkIGFyZSBoYW5kbGVkIChhcyBv
ZiBub3cpLiBJbg0KPiBoYW5kbGVfYXN5bmNfY29weSgpIHdoZW4gd2UgY29tZSBvdXQgb2YNCj4g
d2FpdF9mb3JfY29tcGxldGlvbl9pbnRlcnJ1cHRpYmxlKCkgd2Uga25vdyB0aGUgY2FsbGJhY2sg
aGFzIGFycml2ZWQNCj4gYW5kIGl0IGhhcyBzaWduYWxsZWQgdGhlIGNvcHkgdGhyZWFkIGFuZCB0
aHVzIHdlIHJlbW92ZSB0aGUgY29weQ0KPiByZXF1ZXN0IGZyb20gdGhlIGxpc3QuIEhvd2V2ZXIs
IG9uIHRoZSB0aW1lb3V0LCB3ZSBkaWRuJ3QgcmVjZWl2ZSB0aGUNCj4gd2FrZSB1cCBhbmQgdGh1
cyBpZiB3ZSByZW1vdmUgdGhlIGNvcHkgZnJvbSB0aGUgbGlzdCB0aGVuLCB3aGVuIHRoZQ0KPiBj
YWxsYmFjayB0aHJlYWQgYXN5bmNocm9ub3VzbHkgcmVjZWl2ZXMgdGhlIGNhbGxiYWNrIGl0IHdv
bid0IGhhdmUgdGhlDQo+IHJlcXVlc3QgdG8gbWF0Y2ggaXQgdG9vLiBBbmQgaW4gY2FzZSB0aGUg
c2VydmVyIGRvZXMgc3VwcG9ydCBhbg0KPiBvZmZsb2FkX3N0YXR1cyBxdWVyeSBJIGd1ZXNzIHRo
YXQncyBvaywgYnV0IGltYWdpbmUgaXQgZGlkbid0LiBTbyBub3csDQo+IHdlJ2Qgc2VuZCB0aGUg
b2ZmbG9hZF9zdGF0dXMgYW5kIGdldCBub3Qgc3VwcG9ydGVkIGFuZCB3ZSdkIGdvIGJhY2sgdG8N
Cj4gd2FpdGluZyBidXQgd2UnZCBhbHJlYWR5IG1pc3NlZCB0aGUgY2FsbGJhY2sgYmVjYXVzZSBp
dCBjYW1lIGFuZA0KPiBkaWRuJ3QgZmluZCB0aGUgbWF0Y2hpbmcgcmVxdWVzdCBpcyBub3cganVz
dCBkcm9wcGVkIG9uIHRoZSBmbG9vci4NCg0KSWYgdGhlIGNsaWVudCByZWNlaXZlcyAiT0ZGTE9B
RF9TVEFUVVMgaXMgbm90IHN1cHBvcnRlZCIgSSB3b3VsZCBzYXkNCml0IHNob3VsZCB0cnkgdGhl
IENPUFkgYWdhaW4gd2l0aCB0aGUgc3luY2hyb25vdXMgYml0IHNldC4gVGhhdCdzIGENCmJyb2tl
biBzZXJ2ZXIsIElNTy4NCg0KDQo+IFdoZW4gd2Ugd2FrZSB1cCBmcm9tIHdhaXRfZm9yX2NvbXBs
ZXRpb25faW50ZXJydXB0aWJsZSgpIHdlIG5lZWQgdG8NCj4ga25vdyBpZiB3ZSB0aW1lZCBvdXQg
b3IgZ290IHdva2VuLiBJZiB3ZSB0aW1lZCBvdXQsIEkgdGhpbmsgd2UgbmVlZCB0bw0KPiBrZWVw
IHRoZSByZXF1ZXN0IGluLg0KDQpGYWlyIGVub3VnaCwgSSB3aWxsIHRyeSB0byByZW1lbWJlciB0
byBmaXggdGhlIGxpc3QgaGFuZGxpbmcuIFRoZQ0Kd2FpdF9mb3JfY29tcGxldGlvbl9pbnRlcnJ1
cHRpYmxlIGRvZXMgcHJvdmlkZSBhIHJldHVybiBjb2RlIHRoYXQNCmVuYWJsZXMgdGhlIGNhbGxl
ciB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZXNlIGNhc2VzLg0KDQoNCj4+ICsgICAgICAgY2Fz
ZSAtRUlOUFJPR1JFU1M6DQo+PiArICAgICAgIGNhc2UgLUVPUE5PVFNVUFA6DQo+PiArICAgICAg
ICAgICAgICAgZ290byB3YWl0Ow0KPj4gKyAgICAgICB9DQo+PiArICAgICAgIGdvdG8gb3V0Ow0K
Pj4gfQ0KPj4gDQo+PiBzdGF0aWMgaW50IHByb2Nlc3NfY29weV9jb21taXQoc3RydWN0IGZpbGUg
KmRzdCwgbG9mZl90IHBvc19kc3QsDQo+PiAtLQ0KPj4gMi40NS4yDQoNCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

