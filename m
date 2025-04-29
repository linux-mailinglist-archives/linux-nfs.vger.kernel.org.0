Return-Path: <linux-nfs+bounces-11359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2AFAA3C05
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 01:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6905A6F31
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 23:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AFB2DCB4B;
	Tue, 29 Apr 2025 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OmxJB+Mj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2125.outbound.protection.outlook.com [40.107.243.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852C2DAF80
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745968973; cv=fail; b=Poa5DNKiF22VFxaxLR6ERPqhQHAp03otV6ESXQCONlgEUX8efkuEHnSQq94SjTvbnCo6aO9EOuKwp5zuNHCpHQYcTJ86Z3PZSAxHd/dYdyRvylJ1/MtkdMB5kkIBVE4b8n5VcD9lfzYEjcxD7Buh9h4iodMVIc2jVTieU1nYCUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745968973; c=relaxed/simple;
	bh=uVH+4sZwVrEUq5wcdPj2sKRcO+xCFJEluiba8NgAP7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RcthBCcsdv/7TLbh1kzA6p9BTkekWev+NJkh/M1u4i/qEQiI2b6L+t03e61p1mpsnR4shN2g3QbY11CME9A3rkSMOo6JLv9zXXGxsHw0LeeR5JrsR9hQhB4eY2do3nuFxcw3BeskoBPPaSv7zhQ2JBfcWgwoRdvZn9NXzbUWR6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OmxJB+Mj; arc=fail smtp.client-ip=40.107.243.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGqGoa+6tG8Pi3YTGpEUinklbAC7EA0LChr+Ql1wv6vkCR2rLsI7Du9BX7y1xXQgiBIrXWFuSklli74RKPp0bw8mEVcDmRfijCutjyi23jvWsQ0M+WX3v4dDjc3VnO6rdUQSkcpTPs7jCx+B+qxasHuvhM8TucyqM8tKQbo/VnrNFP0cD151VvVau6BQcHi7JZGFSRybfoo23TDyB4kQGezcsAENroCjoQTLd88g6gGgdgT0ult7pjEUNM2yndejQx0M0GwIuo4bgZRKzZ1VB3peu6zGNUrtxUg9Mz8jZ+cm1vlbaVXtBud2GBzfnDNEMBOSWOB/T1SPdU0ZM8vpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVH+4sZwVrEUq5wcdPj2sKRcO+xCFJEluiba8NgAP7U=;
 b=b0se2e8HTm1gaZDV6e6QwcC5oNnNMjarvKhDKi2u3xzpA8+tdrcAL2nulVRAKvTwFWD+seg+z5bEOBIJXAkRjdD+vp3WM/Ugy8SwRkGxAtfR5j7oUOgQMbFUs8jblMyQKmkW0EqU6IgPhdHmNwXFRW0kyfWxpvAv3ymXyKeXWMPgTRe6j8tPMi/bsK35BBOaPbDzmK6iYg+qB6YkEXEiiVmxfSK57jVKGDap+5jYuZ9eVm3RT3a3U0yv/uTaQhLj6Il7tQGpeIURguApDg1zdi1UNJH/L74o6P0xZOyEeE5vM0IQncmQxt0DO7U3lai56aYwR0vajXwcckwJHD59SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVH+4sZwVrEUq5wcdPj2sKRcO+xCFJEluiba8NgAP7U=;
 b=OmxJB+MjeCal+k40h3VdnNlv8+5L3cbdF84CQSW2rNn5M29VJrPvlPrSaADxn/fhDgYY9GHjqRBGziFgMKuslz+VRM7/Q9ovflBLZ9YCLQa4c2CXo+d528JelYqX22t1ArvvZmUi+8XsBQdVW9hzCwimcpBzoolyfpUQLiFIH8w=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4571.namprd13.prod.outlook.com (2603:10b6:610:c0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 23:22:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 23:22:47 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Avoid flushing data while holding directory locks in
 nfs_rename()
Thread-Topic: [PATCH] NFS: Avoid flushing data while holding directory locks
 in nfs_rename()
Thread-Index: AQHbt8hdBAL+TU5G0EK9tsNHSyC1+rO61BwAgAB3fwA=
Date: Tue, 29 Apr 2025 23:22:47 +0000
Message-ID: <c4b94ca894764b5f323fbf92530389f8c8b85894.camel@hammerspace.com>
References:
 <a804c54445a3f028007763e05285d765afcab0f9.1745794273.git.trond.myklebust@hammerspace.com>
	 <2526363b-1f4a-4999-9f9a-8c4c5c6c132d@oracle.com>
In-Reply-To: <2526363b-1f4a-4999-9f9a-8c4c5c6c132d@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH0PR13MB4571:EE_
x-ms-office365-filtering-correlation-id: c4f94981-2929-41b9-c4c5-08dd8774c0c2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDN6a2ZlTG5oaEZlYVRmZlJyTzBSQ1QwRisyN2RteHVRWTNRKzZlUWlaYzg0?=
 =?utf-8?B?dGtkblJReTZwbEtEeEZSbTVWRzVtemRRR3pNc0lFZjFxcHJMMGRZS3ZCejJ1?=
 =?utf-8?B?cmR5SzAySUM5bXA3Uk5kNU8xWkRnT3IzRGFKZHBkaGFLYXZQU0NnRFo4S0M0?=
 =?utf-8?B?Yzd2Z1JEME1ubGVNUnZkbkpSNStKUENUc3BrOXE5akZXTHdBREVpZVpuajBS?=
 =?utf-8?B?YXh5VDlvVW50OFFXdkpodWhJNTdmbHQzaEN5ell1NHlWMWw1Yk42NHdVc0Zl?=
 =?utf-8?B?akhrWVI4K3VuQjgxTnNNamdyMFN5MzZPZGVLSVVBV3U5VzRZdmRwOFpXN1lQ?=
 =?utf-8?B?SkpMOWpQUnlNMjc4M0k1SkxQOGt1MGtIMFlucUJCUEhycDA1WE94Q094bmd0?=
 =?utf-8?B?aGM5N3Q1L2ZveG05Z1lSd1F4eTE1YUlGRmFwczVLM0xQVG1DdnhEb2dYUVRM?=
 =?utf-8?B?RTMrRC93SUUyZEhUaERlbE9wOElDTW41TjZyN3BCR0pDWUdtQ3cyL2lFUFBx?=
 =?utf-8?B?bkpLRDBPMm85OE9qRENOOHhaWHNLaEZ4YmNNN3IwRGpVSE5lRHY0YU41bEdi?=
 =?utf-8?B?RjRoeWVPc3Y3VEI3U3hQMU1acHdpVENIclBOWUJQL0dkQWU4c0hNaUY1aUdH?=
 =?utf-8?B?SXp3RmRXZ1ZScG1zNWdZS3NueEdSTDBhUm54Zk9tbjRYNWN0QVpXbnFxcW11?=
 =?utf-8?B?akNpVVRraWFZUnV5MVVVMVhCcmt4M3M3ZHJCUVFVbkpqcnFZb3ZDSnhyekRF?=
 =?utf-8?B?QXdtNmh2RzA0a0FnUFhBQUNZV0x3U0RlUTcxaHR3bkVEdjFjRFlhSXhyOFNt?=
 =?utf-8?B?WUt6Q2t5RVlpaHFnVWE0OFBQUVB3VytjUkUzakpSQlBSRUEyU3NBRGZZMUp5?=
 =?utf-8?B?YWZZVWNKbXBZZEJtTjliUk9KOW1BMDk3SFlNdXQvemNsNW03bUpScXlJNDRY?=
 =?utf-8?B?YzhFUm84V3E4cGxTYk5zM1BidHRkaE1wY1VLK0lIa2tENkhVS25kSXdSby9H?=
 =?utf-8?B?cTczd0k2cGtKUmh4VGYyNWZwUXVmVElPUmVIOGFLTHFHNkptMTlEWW1KajBi?=
 =?utf-8?B?SWZwWWtPRlV5QkMxZkpYR0k3V0sxY2FDMzFTZmFRSWUyWGpCR2FTc1JMUnhm?=
 =?utf-8?B?bVhUS29rSU5LMmVNTzAxdUNZcXhUZG8rZC84Tzh0MUowek9SSUE4aVVQTEZB?=
 =?utf-8?B?Wjl1R1VRUlBVaks0dDRkcEE3Q3g3UEdCajFZdEc3OSthTmxWWlZjR3V1eGk2?=
 =?utf-8?B?T09XNEw5VHJ0ZUlOWEtMTTc4L2pMeFJUSEZhMXFqWjNRM3dUYVpNZS90WUsy?=
 =?utf-8?B?NWpoZjkwNGJnNTNxQlpEOWUxRVJ1ZGJ5Q0ZZUElyR1REcnUwSGtMSHhhMFdV?=
 =?utf-8?B?L0pxbjIvbTQvMHRVNUhobFRXY3BHd0hNZFpZM0RQUmxna3UzRS9CWDF3Qkg1?=
 =?utf-8?B?dk96dXNUZnhSSGpJMy9VVHpjclpESm9LekZicjFocnhWdnU4OStvZDFxYnc4?=
 =?utf-8?B?SWNSallieUZJVGl2aVhkZ2xTVFlUcE9ZdFowQ3pWVGwza2hhVUFEdStvc09h?=
 =?utf-8?B?QnNWeGFRSGlhYjZDcHFKQnd3c3JiQmRiaDg0bjFlQml6Ym1RK3Zpd1UzZy9R?=
 =?utf-8?B?WnhtOEdIN0pnQ0VkcEozaWhVSVFpampHTlIzbytSbkQyRUZrVllXNVlSYm1C?=
 =?utf-8?B?d2lFd3BNUWdHMkZxZFBCYm9QeFdsZ2lkWHBtcUdyZE02bDhOMHAxTHJFQ3pQ?=
 =?utf-8?B?YTlYcjdwSVMxTWQzQktKa3cwRHBJTWxDQlR3bDJMRjNYYjFhZmFtMitRT2do?=
 =?utf-8?B?ZHFkYW4rcGg4d0wvai83QkdtN3FRMGpHSkx6MTM2OU05NkdBaWI2QUMvUXNn?=
 =?utf-8?B?YzQ0MFRSa0lxSDl0djhHdU0xaG50VE02NGYxYkFUUGg2ZTI1dDJMNEtSbzYr?=
 =?utf-8?B?ZGkxaFJVMnRnaTV3RGxXOU8zdi94N1Y5UFhZTXZUemFvQkpEaHFvUGllTHlE?=
 =?utf-8?B?MkEwYXg2YVhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlp5ZndhN21BUG5WNHZBRHZKRFJVdkh5VUhwWkg0cDFtMlNlMFFNNW9tYTN6?=
 =?utf-8?B?RW1wbFAxaTVmdFlSMkEzQ05ZNXhJOEZDVWtkdDVVeHFlZGNrNDdtbDZPbXVC?=
 =?utf-8?B?dnBUaFM0cXMraWlYNmFITkgyMk5JRGF4bGk4Q1pTK1VZVTRvOTZySmdyRGdW?=
 =?utf-8?B?UWhsNGtFQ3RGb1JJVEhaTTRFTVh5Vnd5MFU2VS9wd2JPWGZtNUZ2M2xYM0lG?=
 =?utf-8?B?TGFuRnJQYXRRT0VEODhNZ1JhRWFldDQwc2E0Z0x4enFGSkJFQmtxdGNWbWd0?=
 =?utf-8?B?cnN3SXM1VEJqOUFFOGVIeVczU3VEQll6eDB5NUcwRUVieDZrSEpxOE4raTJM?=
 =?utf-8?B?STJtaWhmaUNOQnlrbmNYeG5pR2crcHViSjJwa3A1UDk1cWIzLy95UHlKRUYx?=
 =?utf-8?B?b25WYit0dUVaRVlmQnNLSnVQK3cwTWQyNUNBUFZLKzdSdzZpcjVPU0JET1V6?=
 =?utf-8?B?UkFwbzNRK1MvK0F2eFZxWjR1VWdoS1BHS3E5alQwV2NQQTlncElnT1ZRNURl?=
 =?utf-8?B?STNPdUY0K2FvSXZaL1Z6SmI3b2YzTkZTanljdUpWblRNYlVpeGMvRkZCYzJs?=
 =?utf-8?B?c3lnbjdWSFZycVFJWk9yOUVhYnJiZ1FCblV5b0xTK3YyVjAzR2k4ZTFVVk1x?=
 =?utf-8?B?U0hBN25SeWMrd0tPTzdLRzI4dUs4bkFkbkNJWHFjMlhCckVndjczenFYdzhD?=
 =?utf-8?B?c3YrSVIwNGpJKzFpakUybWRoTmtDTEkzQ2EyTEtlV0pGNlhsWERuMGY0Sms4?=
 =?utf-8?B?dUZnMnhVT1BKMWh6cDZ4SzIvL3lBbTE3TnV5NlEvOG9reVl3OWVtUTZQYVdR?=
 =?utf-8?B?SVNFanArUUQ1aURzUmVSNkxBMjhWU1RVSFF4WjFKb05DSEJjSzFiSzQ5WW1T?=
 =?utf-8?B?R0cvVE54aDk2YTNFOHJSSlNLbVcrNkNVU21VN2NHUTJmVG1RYmM2V0lMNmRu?=
 =?utf-8?B?RnlNV3dCeEh1MktpY05PTWxNbGZZSWJpUkd0S3NLWUFBbXBzc2FHdFlmWjFF?=
 =?utf-8?B?SHhpR014Vm9KdU4rTUtxQlY2MnIzYzVKcXZPaW00ZWROKzI2Nkx1N2JLbDNH?=
 =?utf-8?B?aEhSY0JKbnkya1lOU0Y3ZW1oZ0JYMDJCcUpka2xzREJXdDZQeENRUExla1ZQ?=
 =?utf-8?B?OVJzSUhQeWNINUpEeGcyRUU3UUNiZi92Z053QndPb0JTTVBIVDJrRmpDSDBi?=
 =?utf-8?B?RVRJSUlVSGc2UkkwbUYzRnpYZmRSNnNDVDA5NUxVK1VadHdrbk9pVHpuMWNp?=
 =?utf-8?B?YmpPSlgvUytqRFBPRG5jRnA3bnltbWhzYlNWZXM2QXBZWDdXSWxTZWo4YWUw?=
 =?utf-8?B?WkNqMjBabE1LUk5NazMvZE81ZmJaZVVmakFRSGkyaXY4alZ4SVUyWm1TQ1hv?=
 =?utf-8?B?TXYvdEp6dFZCbzV4WVhDTXBMNEh0SmdNVFp0OTUvTmM5WTJNbURxTWEzcno0?=
 =?utf-8?B?eGR0aHhqVVUzUlN0bTBNWFpnbzFSZ0VZOHJRcUJmTmtSQURqRmhpZ0Y5V29B?=
 =?utf-8?B?WjRZWmgrWnVhUnJWSFdHZDFiYnpLTWkxY0hiS3JEWCtzbEJ4eUFiOVdlaEpa?=
 =?utf-8?B?V3cwVDdxVTA0WlhKN2RCaGM1dTFxYnJ3R1hrQk1KK2hubjE0akt6SDJ0UFU0?=
 =?utf-8?B?aEt1a1pDbkdDTmhNNThDcHBZRVVRbDdsUkVyb2NyajJqZjdaT2Y5T2RvbzN4?=
 =?utf-8?B?bUdscExyYWx5NHFPN2lMS1cyaC95eEVSODVReExEeXNmYW12V05YeW9sUlRk?=
 =?utf-8?B?QlFJOXQ1Rk9UTFJlUWNUUU84N1A1QVBwUlpSMDhoRkFjOWdXNWE5Ny82YUY5?=
 =?utf-8?B?cXNLdFRBay82dVQ2OGJwY2sxTkVpcnFqSXdvRzRSdTFpMVhmcjlNbkNSWUZN?=
 =?utf-8?B?bC9YZ2cyNWl6UmZJdGZmNVpGUmYrTzVxd0szY0Qzcll6aXBrOWEyN05lSzA2?=
 =?utf-8?B?M1h3Zmp3UnhvRjNPejg5d2xJM0ZENnFMQndRNC9ldnZVa0ViRjhaaGVKcnF6?=
 =?utf-8?B?TmNGNnhQR2VVMmFRQXI4ZXZSRUg5L1czdHl4T0pOcXRKRUZPYUxUSmxvK3Bi?=
 =?utf-8?B?MmYwSnZNeGxvKzhzR2tCTktpY3BtcjVtNVowbzQvVEhTYS9Wa0cxbVo5Yk9T?=
 =?utf-8?B?Nnk0SWhtL0RwakVyOHR6QlhTUjg0Zysyc0F1dExRMEpCL3dqS1NTdGFlZllt?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <367914EFBF9FAE449E9B1FAEC4016670@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f94981-2929-41b9-c4c5-08dd8774c0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 23:22:47.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekKn6oRLsZephJVCzulyINAxkRXrTa6akInDMbddVH2axcR4HzArXG9gYu/grUPL+T/GMg744l9e1VgqC95Aig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4571

T24gVHVlLCAyMDI1LTA0LTI5IGF0IDEyOjE0IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gNC8yNy8yNSA3OjAxIFBNLCB0cm9uZG15QGtlcm5lbC5vcmfCoHdyb3RlOg0KPiA+IEZyb206
IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiAN
Cj4gPiBUaGUgTGludXggY2xpZW50IGFzc3VtZXMgdGhhdCBhbGwgZmlsZWhhbmRsZXMgYXJlIG5v
bi12b2xhdGlsZSBmb3INCj4gPiByZW5hbWVzIHdpdGhpbiB0aGUgc2FtZSBkaXJlY3RvcnkgKG90
aGVyd2lzZSBzaWxseXJlbmFtZSBjYW5ub3QNCj4gPiB3b3JrKS4NCj4gPiBIb3dldmVyLCB0aGUg
ZXhpc3RlbmNlIG9mIHRoZSBMaW51eCAnc3VidHJlZV9jaGVjaycgZXhwb3J0IG9wdGlvbg0KPiA+
IGhhcw0KPiA+IG1lYW50IHRoYXQgbmZzX3JlbmFtZSgpIGhhcyBhbHdheXMgYXNzdW1lZCBpdCBu
ZWVkcyB0byBmbHVzaCB3cml0ZXMNCj4gPiBiZWZvcmUgYXR0ZW1wdGluZyB0byByZW5hbWUuDQo+
ID4gDQo+ID4gU2luY2UgTkZTdjQgZG9lcyBhbGxvdyB0aGUgY2xpZW50IHRvIHF1ZXJ5IHdoZXRo
ZXIgb3Igbm90IHRoZQ0KPiA+IHNlcnZlcg0KPiA+IGV4aGliaXRzIHRoaXMgYmVoYXZpb3VyLCBh
bmQgc2luY2Uga25mc2QgZG9lcyBhY3R1YWxseSBzZXQgdGhlDQo+ID4gYXBwcm9wcmlhdGUgZmxh
ZyB3aGVuICdzdWJ0cmVlX2NoZWNrJyBpcyBlbmFibGVkIG9uIGFuIGV4cG9ydCwgaXQNCj4gPiBz
aG91bGQgYmUgT0sgdG8gb3B0aW1pc2UgYXdheSB0aGUgd3JpdGUgZmx1c2hpbmcgYmVoYXZpb3Vy
IGluIHRoZQ0KPiA+IGNhc2VzDQo+ID4gd2hlcmUgaXQgaXMgY2xlYXJseSBub3QgbmVlZGVkLg0K
PiANCj4gTm8gb2JqZWN0aW9uIHRvIHRoZSBoaWdoIGxldmVsIGdvYWwsIHNlZW1zIGxpa2UgYSBz
ZW5zaWJsZSBjaGFuZ2UuDQo+IA0KPiBTbyBORlN2MyBzdGlsbCBoYXMgdGhlIGZsdXNoaW5nIHJl
cXVpcmVtZW50LCBidXQgTkZTdjQgY2FuIGRpc2FibGUNCj4gdGhhdA0KPiByZXF1aXJlbWVudCBh
cyBsb25nIGFzIHRoZSBzZXJ2ZXIgaW4gcXVlc3Rpb24gYXNzZXJ0cw0KPiBGSDRfVk9MQVRJTEVf
QU5ZDQo+IGFuZCBGSDRfVk9MX1JFTkFNRSwgY29ycmVjdD8NCj4gDQo+IEknbSB3b25kZXJpbmcg
aG93IGNvbmZpZGVudCB3ZSBhcmUgdGhhdCBvdGhlciBzZXJ2ZXIgaW1wbGVtZW50YXRpb25zDQo+
IGJlaGF2ZSByZWFzb25hYmx5LiBZZXMsIHRoZXkgYXJlIGJyb2tlbiBpZiB0aGV5IGRvbid0IGJl
aGF2ZSwgYnV0DQo+IHRoZXJlDQo+IGlzIHN0aWxsIHJpc2sgb2YgaW50cm9kdWNpbmcgYSByZWdy
ZXNzaW9uLg0KDQpJJ2QgcHJlZmVyIHRvIGRlYWwgd2l0aCB0aGF0IHRocm91Z2ggb3RoZXIgbWVh
bnMgaWYgaXQgdHVybnMgb3V0IHRoYXQNCndlIGhhdmUgdG8uIFRoZSBwcm9ibGVtIHdlIGhhdmUg
cmlnaHQgbm93IGlzIHRoYXQgd2UgYXJlIGZvcmNpbmcgYQ0Kd3JpdGViYWNrIG9mIHRoZSBlbnRp
cmUgZmlsZSB3aGlsZSBob2xkaW5nIHNldmVyYWwgZGlyZWN0b3J5IG11dGV4ZXMNCihhcyB3ZWxs
IGFzIHRoZSBmaWxlc3lzdGVtLWdsb2JhbCBzX3Zmc19yZW5hbWVfbXV0ZXgpLiBUaGF0J3MgdGVy
cmlibGUNCmZvciBwZXJmb3JtYW5jZSBhbmQgc2NhbGFiaWxpdHkuDQoNCj4gDQo+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbT4NCj4gPiAtLS0NCj4gPiDCoGZzL25mcy9jbGllbnQuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAyICsrDQo+ID4gwqBmcy9uZnMvZGlyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDE1ICsrKysrKysrKysrKysrLQ0KPiA+IMKgaW5jbHVkZS9saW51eC9uZnNfZnNfc2IuaCB8wqAg
NiArKysrKysNCj4gPiDCoDMgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvY2xpZW50LmMgYi9mcy9uZnMv
Y2xpZW50LmMNCj4gPiBpbmRleCAyMTE1YzExODljMmQuLjZkNjNiOTU4YzRiYiAxMDA2NDQNCj4g
PiAtLS0gYS9mcy9uZnMvY2xpZW50LmMNCj4gPiArKysgYi9mcy9uZnMvY2xpZW50LmMNCj4gPiBA
QCAtMTEwNSw2ICsxMTA1LDggQEAgc3RydWN0IG5mc19zZXJ2ZXIgKm5mc19jcmVhdGVfc2VydmVy
KHN0cnVjdA0KPiA+IGZzX2NvbnRleHQgKmZjKQ0KPiA+IMKgCQlpZiAoc2VydmVyLT5uYW1lbGVu
ID09IDAgfHwgc2VydmVyLT5uYW1lbGVuID4NCj4gPiBORlMyX01BWE5BTUxFTikNCj4gPiDCoAkJ
CXNlcnZlci0+bmFtZWxlbiA9IE5GUzJfTUFYTkFNTEVOOw0KPiA+IMKgCX0NCj4gPiArCS8qIExp
bnV4ICdzdWJ0cmVlX2NoZWNrJyBib3JrZW5uZXNzIG1hbmRhdGVzIHRoaXMgc2V0dGluZw0KPiA+
ICovDQo+IA0KPiBBc3N1bWluZyB5b3UgYXJlIGdvaW5nIHRvIHJlc3BpbiB0aGlzIHBhdGNoIHRv
IGRlYWwgd2l0aCB0aGUgYnVpbGQNCj4gYm90DQo+IHdhcm5pbmdzLCBjYW4geW91IG1ha2UgdGhp
cyBjb21tZW50IG1vcmUgdXNlZnVsPyAiYm9ya2VubmVzcyIgc291bmRzDQo+IGxpa2UgeW91IGFy
ZSBkZWFsaW5nIHdpdGggYSBzZXJ2ZXIgYnVnIGhlcmUsIGJ1dCB0aGF0J3Mgbm90IHJlYWxseQ0K
PiB0aGUgY2FzZS4gc3VidHJlZV9jaGVjayBpcyB3b3JraW5nIGFzIGRlc2lnbmVkOiBpdCByZXF1
aXJlcyB0aGUgZXh0cmENCj4gZmx1c2hpbmcuIFRoZSBub19zdWJ0cmVlX2NoZWNrIGNhc2UgZG9l
cyBub3QsIElJVUMuDQoNCnN1YnRyZWUgY2hlY2tpbmcgaXMgd29ya2luZyBhcyBkZXNpZ25lZCwg
YnV0IHRoYXQgZG9lc24ndCBjaGFuZ2UgdGhlDQpmYWN0IHRoYXQgaXQgaXMgYSB2aW9sYXRpb24g
b2YgdGhlIE5GU3YzIHByb3RvY29sLiBZb3UgY2FuJ3QgdG8gY2hhbmdlDQp0aGUgZmlsZWhhbmRs
ZSBpbiBtaWQgZmxpZ2h0IGluIGFueSBzdGF0ZWxlc3MgcHJvdG9jb2wsIGJlY2F1c2UgdGhhdA0K
d2lsbCBicmVhayBhcHBsaWNhdGlvbnMuDQoNCj4gSXQgd291bGQgYmUgYmV0dGVyIHRvIGV4cGxh
aW4gdGhpcyBuZWVkIHN0cmljdGx5IGluIHRlcm1zIG9mIGZpbGUNCj4gaGFuZGxlDQo+IHZvbGF0
aWxpdHksIG5vPw0KPiANCj4gDQo+ID4gKwlzZXJ2ZXItPmZoX2V4cGlyZV90eXBlID0gTkZTX0ZI
X1ZPTF9SRU5BTUU7DQo+ID4gwqANCj4gPiDCoAlpZiAoIShmYXR0ci0+dmFsaWQgJiBORlNfQVRU
Ul9GQVRUUikpIHsNCj4gPiDCoAkJZXJyb3IgPSBjdHgtPm5mc19tb2QtPnJwY19vcHMtPmdldGF0
dHIoc2VydmVyLA0KPiA+IGN0eC0+bW50ZmgsDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIu
YyBiL2ZzL25mcy9kaXIuYw0KPiA+IGluZGV4IGJkMjNmYzczNmIzOS4uZDBlMGI0MzVhODQzIDEw
MDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9kaXIuYw0KPiA+ICsrKyBiL2ZzL25mcy9kaXIuYw0KPiA+
IEBAIC0yNjc2LDYgKzI2NzYsMTggQEAgbmZzX3VuYmxvY2tfcmVuYW1lKHN0cnVjdCBycGNfdGFz
ayAqdGFzaywNCj4gPiBzdHJ1Y3QgbmZzX3JlbmFtZWRhdGEgKmRhdGEpDQo+ID4gwqAJdW5ibG9j
a19yZXZhbGlkYXRlKG5ld19kZW50cnkpOw0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4gK3N0YXRpYyBi
b29sIG5mc19yZW5hbWVfaXNfdW5zYWZlX2Nyb3NzX2RpcihzdHJ1Y3QgZGVudHJ5DQo+ID4gKm9s
ZF9kZW50cnksDQo+ID4gKwkJCQkJwqDCoCBzdHJ1Y3QgZGVudHJ5DQo+ID4gKm5ld19kZW50cnkp
DQo+ID4gK3sNCj4gPiArCXN0cnVjdCBuZnNfc2VydmVyICpzZXJ2ZXIgPSBORlNfU0Iob2xkX2Rl
bnRyeS0+ZF9zYik7DQo+ID4gKw0KPiA+ICsJaWYgKG9sZF9kZW50cnktPmRfcGFyZW50ICE9IG5l
d19kZW50cnktPmRfcGFyZW50KQ0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArCWlmIChzZXJ2
ZXItPmZoX2V4cGlyZV90eXBlICYgTkZTX0ZIX1JFTkFNRV9VTlNBRkUpDQo+ID4gKwkJcmV0dXJu
ICEoc2VydmVyLT5maF9leHBpcmVfdHlwZSAmDQo+ID4gTkZTX0ZIX05PRVhQSVJFX1dJVEhfT1BF
Tik7DQo+ID4gKwlyZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiDCoC8qDQo+ID4gwqAg
KiBSRU5BTUUNCj4gPiDCoCAqIEZJWE1FOiBTb21lIG5mc2RzLCBsaWtlIHRoZSBMaW51eCB1c2Vy
IHNwYWNlIG5mc2QsIG1heSBnZW5lcmF0ZQ0KPiA+IGENCj4gPiBAQCAtMjc2Myw3ICsyNzc1LDgg
QEAgaW50IG5mc19yZW5hbWUoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsDQo+ID4gc3RydWN0IGlu
b2RlICpvbGRfZGlyLA0KPiA+IMKgDQo+ID4gwqAJfQ0KPiA+IMKgDQo+ID4gLQlpZiAoU19JU1JF
RyhvbGRfaW5vZGUtPmlfbW9kZSkpDQo+ID4gKwlpZiAoU19JU1JFRyhvbGRfaW5vZGUtPmlfbW9k
ZSkgJiYNCj4gPiArCcKgwqDCoCBuZnNfcmVuYW1lX2lzX3Vuc2FmZV9jcm9zc19kaXIob2xkX2Rl
bnRyeSwNCj4gPiBuZXdfZGVudHJ5KSkNCj4gPiDCoAkJbmZzX3N5bmNfaW5vZGUob2xkX2lub2Rl
KTsNCj4gPiDCoAl0YXNrID0gbmZzX2FzeW5jX3JlbmFtZShvbGRfZGlyLCBuZXdfZGlyLCBvbGRf
ZGVudHJ5LA0KPiA+IG5ld19kZW50cnksDQo+ID4gwqAJCQkJbXVzdF91bmJsb2NrID8gbmZzX3Vu
YmxvY2tfcmVuYW1lDQo+ID4gOiBOVUxMKTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9uZnNfZnNfc2IuaCBiL2luY2x1ZGUvbGludXgvbmZzX2ZzX3NiLmgNCj4gPiBpbmRleCA3MTMx
OTYzN2E4NGUuLjY3MzJjN2UwNGQxOSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L25m
c19mc19zYi5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9uZnNfZnNfc2IuaA0KPiA+IEBAIC0y
MzYsNiArMjM2LDEyIEBAIHN0cnVjdCBuZnNfc2VydmVyIHsNCj4gPiDCoAl1MzIJCQlhY2xfYml0
bWFzazsJLyogVjQgYml0bWFzaw0KPiA+IHJlcHJlc2VudGluZyB0aGUgQUNFcw0KPiA+IMKgCQkJ
CQkJwqDCoCB0aGF0IGFyZQ0KPiA+IHN1cHBvcnRlZCBvbiB0aGlzDQo+ID4gwqAJCQkJCQnCoMKg
IGZpbGVzeXN0ZW0gKi8NCj4gPiArCS8qIFRoZSBmb2xsb3dpbmcgI2RlZmluZXMgbnVtZXJpY2Fs
bHkgbWF0Y2ggdGhlIE5GU3Y0DQo+ID4gZXF1aXZhbGVudHMgKi8NCj4gPiArI2RlZmluZSBORlNf
RkhfTk9FWFBJUkVfV0lUSF9PUEVOICgweDEpDQo+ID4gKyNkZWZpbmUgTkZTX0ZIX1ZPTEFUSUxF
X0FOWSAoMHgyKQ0KPiA+ICsjZGVmaW5lIE5GU19GSF9WT0xfTUlHUkFUSU9OICgweDQpDQo+ID4g
KyNkZWZpbmUgTkZTX0ZIX1ZPTF9SRU5BTUUgKDB4OCkNCj4gPiArI2RlZmluZSBORlNfRkhfUkVO
QU1FX1VOU0FGRSAoTkZTX0ZIX1ZPTEFUSUxFX0FOWSB8DQo+ID4gTkZTX0ZIX1ZPTF9SRU5BTUUp
DQo+ID4gwqAJdTMyCQkJZmhfZXhwaXJlX3R5cGU7CS8qIFY0DQo+ID4gYml0bWFzayByZXByZXNl
bnRpbmcgZmlsZQ0KPiA+IMKgCQkJCQkJwqDCoCBoYW5kbGUNCj4gPiB2b2xhdGlsaXR5IHR5cGUg
Zm9yDQo+ID4gwqAJCQkJCQnCoMKgIHRoaXMgZmlsZXN5c3RlbQ0KPiA+ICovDQo+IA0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K

