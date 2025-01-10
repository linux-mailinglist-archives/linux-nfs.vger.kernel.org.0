Return-Path: <linux-nfs+bounces-9051-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA2A0845E
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 02:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E3418802AB
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 01:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3152066EB;
	Fri, 10 Jan 2025 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="dtqofj5t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF819D07A
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471047; cv=fail; b=laIfaoAVfe2jLxUUBcLk68kTOSVg4pXsGVRnkq2QDqP4+v8pQtzmqQvQVUMHhyXzj/u9JOdhyTTkeLwZliNLSi2t+bR921j74iUAS7rL7QCPlsNcMYp9/0xuAVwxHTDwPICuHDyVMdLcrExtDrrtDemQvdS49xCXysRQADlzJwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471047; c=relaxed/simple;
	bh=scKDbCuAa8TAyAqu9si/6V4wPv62cV4WGY65iIyQgig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7X8Nvyg6l9tzbmpf82OyAhh3bWn151zvgeCM+jDz5X3fsHfELS+wmvUh9vOUowG9WVMN/p1H4zEU1DWLOyea/5QGCAXloNowwfjGg5ISU7hdZiEArT23NlDwsi2qRcBJOo5kWax/xVcmyuojDPuoXkxfik6L2G45FZqccAMhiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=dtqofj5t; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKE24CPGMEF8qPEaNaS3kdM1SSBSC8xCnUElE7GpRFqhfdjnCCmau6ykH0tWuBkkixKNQ3x1ktkiXp0V4DxYudWwbNQvZd1fz5dmtbnxwxGfT1+pPpJDtTAvWowtxqASTVcrMmArUFfCdW2HlyWfVg2Ch2P3tTc8BAFOcuqcOCAeg2dB0hGdUGQPuNDZqQftc2Oe4sJn9b6918+0lZnbjFUk2eFk4mXBCYCMUAXUW9CdKP05lNX6HW0dCxIToqVawHBusExMWBC5IEN9kTDURZm55IwXFH2rk/A8dyfoREvYPMQLnEvRj013jyI3VpKOw4R3qFohOVj5iKZVIUB7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scKDbCuAa8TAyAqu9si/6V4wPv62cV4WGY65iIyQgig=;
 b=k4dzlReFopODZsJlyuZmBv23D1KxltS2Ub5ValJgEsDfHT5KnnpGbG1+OwxGOSvr4/s0RyX1NtjYLJQxVDGDfSUVHzgcIvDOnqWc+/RFkVslM7BQ/L1SUqB5inR7hdmDqFfVZSaFoHxxvQgUozDWjhFrUQ6BfZcvfvwoIS5jExQVykL5IedSA0MMUY+eJjufvfZBi0iE1ckIxnRhfJNaDKBHOUufXuWI4/SlPdX1MSKeKOLqgt7+AImSMt77/pdtbT4yD906S6E4REY6BvtrrwT6I9ayozUhshckXORAxXxYiM82C2qQgJAqRczOXIkkFtg8a8+fWnzdOTmilatMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scKDbCuAa8TAyAqu9si/6V4wPv62cV4WGY65iIyQgig=;
 b=dtqofj5tnxVMt4oJrmfdFhYgXHmow7p6P6X7IbwftbiKOSP2mHnKIAu9ZTOl0XAW/yqID0GCkAIvFhF5RgSOBnxa9BhFW7iaB4M54FPsdl4HaaoFf0rLHX0mq7XqtoLtR5U4qcMADGpwuodo6jyNdct/i2fEbvt2ulQQ6ad7fFk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN0PR13MB6801.namprd13.prod.outlook.com (2603:10b6:208:4be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 01:04:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 01:04:00 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Needed: ADB (WRITE_SAME) support in Linux nfsd
Thread-Topic: Needed: ADB (WRITE_SAME) support in Linux nfsd
Thread-Index: AQHbYJaq3MygkbCfP0CN7hucB1iK17MLa3AAgAAHR4CAABYkgIADrQeA
Date: Fri, 10 Jan 2025 01:04:00 +0000
Message-ID: <978d12deaa44ee896d0f1cf42f6745c2b9c9ee6e.camel@hammerspace.com>
References:
 <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
	 <e3d4839b-0aa0-42f5-b3d1-4fd2d150da75@oracle.com>
	 <CALWcw=G-TV19UPmL=oy-HE9wc0q-VpHBVyuYcVQ8b9OQq-8Lqg@mail.gmail.com>
	 <5c928bae-38e4-490a-a9e7-f52b27a462c9@oracle.com>
In-Reply-To: <5c928bae-38e4-490a-a9e7-f52b27a462c9@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN0PR13MB6801:EE_
x-ms-office365-filtering-correlation-id: 2f50fd8d-7ffd-43eb-4c56-08dd3112aae3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mmp0SlRpYWM4b3E1d29xaHlNaW9NcU1vT1ljQ05ZMDF5NXhJWENCcGVEUzMv?=
 =?utf-8?B?ZklnQXhVY2t5a2RYY0JoYndQdmxoL0FDTnZuOTRDUEFFdmczdmtxNTYwait1?=
 =?utf-8?B?aFJ4S0sxcGhXL2xuaFR2cEpjWTRqOE1vR0F2NUpLbHQ1aEptSE1aelFOV25u?=
 =?utf-8?B?LzZkeW80dEpJOTBkUm0veVlQdjhpNUlHZlYxYVZzS054YjZmU0U1YnhvcTVi?=
 =?utf-8?B?b09JK29Qb0F5RTY1R2k5OVlPWVp1cEVDbjIxTFUvQmpHTktBdWRvcGRhOFFC?=
 =?utf-8?B?VWxYcVIveGpaYVB3UU1acHVtSERaMXoxRTZJbWdqMXNpK1VsU2lYRGRpYVpB?=
 =?utf-8?B?bDdsanBEK0p3Q1c0RDdhRkwvL0NZNXVoZVBGNmM1L0V4LzJWeUxSVWl4ZWty?=
 =?utf-8?B?VUs3Rmx3OW9xU0I0UFVab3NQditPdm03M2FDMStqR3AzVnQya2VEaktOditB?=
 =?utf-8?B?OXVZVTE4ZHhyUHpQbUY5VWJMcDQyaUx1eHN3WXVkWHZ0WmZpdjhhV0lwQ00z?=
 =?utf-8?B?dUcrcWV0YTQwK05lWlE0WkRaY2M4eW5DcjlwM01VTVEranFIUENIVnpGRk5T?=
 =?utf-8?B?MUdxS2kvTHd3S1Z5dWF5UWsxU2RrQTgra0tjN2dvOXU1OWRxYUlJZm5MNDBh?=
 =?utf-8?B?SHhXd1JDbDVFUmJJS1RuWWFxWm1OK1M1elJnbmhLbGpodE1aKzY3WG1saVFk?=
 =?utf-8?B?UHU3SlRTc0tLNjl1YlRwTlN4Y3pnZDdBcXZNTWwzZXd5dXdCUDU0SEVsNk1i?=
 =?utf-8?B?Uit1dTR2ejlRN3lqMXkrdzlmU0lDUFZ2UjdMMVJZKzUwQnF4QVdGODFvR3FQ?=
 =?utf-8?B?M29aNzZ2dFVDSVZsS3ZReitDWk9mNDNUQTZJS21DSXNFc2Q3SXhOSHhlRFhS?=
 =?utf-8?B?OWlTckwzWWhqdytwNEkyOGpSWE9SSnVYdjczaWRLQk01NnRxSzY3eUxxOG1U?=
 =?utf-8?B?Nk5hbXZjQXlmNzFTSHhybSt3V1Y5VGdIMHZYUWZSMnV0OHNCYWdVaUlVY2xq?=
 =?utf-8?B?eERpcXB1OUVxeEwyZHRGdUZiVHNnL3p6dmYzaEN6enQ5d2RESmVKN1hHdjlZ?=
 =?utf-8?B?Q3RTWG1vM3F0QitsRkMxdUJMYWRvNEtNS3Ywbit5NHZWR2pMaHdDWDFyVTBX?=
 =?utf-8?B?LzhVa1pLc1hFOWFkT3E2TUNpTUlBQUhONy84MloyZUNWVW9uMWJVNnVoVGR0?=
 =?utf-8?B?MU45cSswVG5meXZDbnYyYmp5UzJXU1Y2cEszUHBReDlNdnloVGFGSDBvRlBZ?=
 =?utf-8?B?eXZxOXZhb012eVYvN3k4YlRnNWRDaHBiY0VyWmo2R2lyZU1vd1NFZGRvdXpN?=
 =?utf-8?B?ZmJBL080dVgrL09pd1p1ZEtYQ2ZEZHJWaURoTzEyUEtrMXZoTGttajNFSWlX?=
 =?utf-8?B?dGZvUFJCSExLTG9ncWFTY3ZhZ3JXQ3RYZEFPZmNIamNQdEhSd2puNXBCSUF6?=
 =?utf-8?B?Nkw3RE84dWlRbG9EZmtkY2xYdng4QURyN3A0cXBNeFJSQTNTVHdOa2dTYXlL?=
 =?utf-8?B?YW4xVG1yempjT2Rha3Z4TTJNZEh2ak9UMjBvakpKbFNrRjE0RUozdUxaOEZo?=
 =?utf-8?B?cUVlajRpUjRsWXMyc3JzWUovL1A5LytsL3N3amxCaEpUeVR5V3YzVUtKL2k3?=
 =?utf-8?B?YkF1b3BoS3U0LzVUZkZPdUY0T0NSWDV4ZjZsdVpwSzlYRU05OUhOTDZKamx3?=
 =?utf-8?B?K2NoMjRXc3JMYUhEKzBzMHUrQ29WejhrRzJ0YXlKYVhVbTl3TGxKU2dHdisy?=
 =?utf-8?B?eDlqV0pTRGovYzgzMU5sVXg2Q0NFK1VaNko5TUo3cUl5SjN6L2FzWGxhNDcr?=
 =?utf-8?B?NmQrUkZ5YkREL2kyL3JvQTQwSVBkWDBxa24rOUt1czQ1UTNMaUlLSDJUelhL?=
 =?utf-8?B?aUZuazNidmJjL3BBZVM3TWxSbVB3eThkOUxZN243bzl2eXNFQTBsTmMybXFO?=
 =?utf-8?Q?P3RNDQaARZS6hdIonlw4qw5HG+lP4M+x?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVVFZFpnOTRqeXZpMTRvbXIycGxCTWR3QzM5eEVKeGxZYWRnMFR4eXcvMm9a?=
 =?utf-8?B?OVg3WFdFQTh2NzM4ai9iM0U2akl4eEtLZ1ZuTFg1UklsdXFqMWJ2U1VpcUhT?=
 =?utf-8?B?Y0NRS3lNRFFEZHNrRXhhc3RIMDVqVFVNN2Q1SFFSUFV3dkR4KzB0VXA0Z0xJ?=
 =?utf-8?B?aHo4dWxIRTlyaXcwZzE0b2IrMzF0YkdYMFE0TU1VVFEyVXUyQm5SejRaZzJu?=
 =?utf-8?B?dTFXMnBmdU5XUHBrWTVtTFZjYUJyQU9SdTNKZ2NUVWhIbTlxdXJFNHM4QzFa?=
 =?utf-8?B?S1JPWGc5WUcyVnRZcUw0N2RuVTAzVkgzdmRMRXRiU1ZRM1hCcS9Zb0JTem5D?=
 =?utf-8?B?dDd3T3A0TldHZHFnbU1QRDdvd2lKczdzKzF1RWhucDVWUVI5c2JLdzNSbTB6?=
 =?utf-8?B?Vm9EMFZBd2Fsd2UyclNmQ2lucVBRdHl1aVJlY2QyT0dkb3AzamZYKy9CUzIv?=
 =?utf-8?B?S20wMGNDMUNBVVl5VzJaTkg0MlFhQ2tISU1sV2ZZdGhRMi9idDVweWd5YUJB?=
 =?utf-8?B?UndUVzNkSEhneW9HMDNSd2VZeDRBRWEzL2hhVldtUEo1UC8vN3QvWFgrYjZL?=
 =?utf-8?B?SGxqN0E1UkF0N0x5YXIvUTZmNkNoblU4ZVpxaFExVXFLWjJxZzJxcjgwZFB4?=
 =?utf-8?B?R0NWWDRxYlVVaTkxWlppajljekk1OFlkbjBtNGJ6eXBEOHVBdEhlM2V1L2JU?=
 =?utf-8?B?LzVvS09lZUx1M0pxeFB2M0dHVmpvSyt1OG1YNHl1TVRKbjBXZlpPbHd2MEdW?=
 =?utf-8?B?MW5KQlA0dXJDRmUvNDB2dWdoNUNDcUpLbkVwcGRtcFRkNVk1Wnh1V1FBb0pS?=
 =?utf-8?B?TFh2NkxJd0JvTXBhSmlJMnVsS3d0ajQ4Z2RmR29ydDVKZzM5VGZkMG5jclV6?=
 =?utf-8?B?bFNQQ0w1ZTU1Z2FqMlF0OWxPcFl0RVpDNzl0RFp2MGhBT2lCa0N3WEMwSldw?=
 =?utf-8?B?VC9EWlVQeEgveTlYazI4cC9tVmg3VXBFaHRMMDZQWWRkOEhKZ3hnU2xLV2w2?=
 =?utf-8?B?RHZreFljSVgwRW9QWCtqUmhVeVYzTDA1VXlSTjBPM0tIenBSalZ3TUcwN1Zr?=
 =?utf-8?B?enZjM2dzU3o1SnAyY0Y2NHFmWDNOelNNdVpNSUFEN0lTeVZtK01nMTYxUzNs?=
 =?utf-8?B?SWRkQ0dRcXVmMW5mdWRFZzExVEViWEVRdUFhVTRob0JrLzVzRml2ZWg4bE91?=
 =?utf-8?B?VG5OMVpQKzZxVXBNRG5DNTlkaGUxZ2JPaHJGZzFmZER5YkRxWVJlVzcyVlQx?=
 =?utf-8?B?Zi9PWUtLd1BpU3NQV1VXZTV0eXJEbE96VXU2cGtQZ3pkdVpYUGVEL0F6Wm02?=
 =?utf-8?B?MGQ4V29lQVFOakpucFRPekQ5MUZpNnpBdFo1Z21CR2R3NVZFZDdjNkdmdE5J?=
 =?utf-8?B?YWRXSVFHcE9CcVVvRjR1ZDZNSDBHYlA2VTNSa25zSi9SbzNITVpQTXhwZDJx?=
 =?utf-8?B?eHRjdnJwbHE0Ung5Sll0UTBraGwzZUVhd1ZkU1daZmIvQWRBVnFOZFV5MHZP?=
 =?utf-8?B?S1FWV2l1ZFVvaFVVYU1ua1FRVi9lQlhOMWJaL2ZYY0RsVXFPMWVHTmxSb2hQ?=
 =?utf-8?B?bUlLWExoNzBTaEc2dGo1U0FFRHd4WnpNdG84bmZHeThvbjNNVjN1UFpseGV1?=
 =?utf-8?B?UVZoYzZDODFTTlMvcGhjTHF6RjF5M2hUNk1OWUQzOVcwMzFPUCtmUzU2bDFL?=
 =?utf-8?B?aXZ4NUxHZTY5TnZjQURYSml6bThHOFZIL0JVWjFDckcwaTErL1BVTFRlSENY?=
 =?utf-8?B?MTBvaWJ4QW0zNTFaZE5yQ3JNVllLUkpXRml0dVl5bHIrWjJ4ZTNLekxDcGYw?=
 =?utf-8?B?eVlFdGZrdVhQUERqMEZhQ0ZnVk5UUlpwT29sNUMxREhnc1YrdlJPWHBBZjB5?=
 =?utf-8?B?R3Yyam1jaEk4bUJWdDlVL3RQVytYbkhLQmtqTUd6T2FmMTFTbGlSMnFGSWZK?=
 =?utf-8?B?QldTUUM2RnA3a0dOYnU5bnZRZ3RGV3R5bGdXcEl3NERaSjRKclZuRi9iK2la?=
 =?utf-8?B?anNoQjlZQXk1RGQvdmltZ1NhUG9vQmpCL0xLZHpNUHRFS2ZxamhXN1B3M1hl?=
 =?utf-8?B?NU1oTFB2YVJFenRubXdQeXJKUUxLTHZDUXB0dUZoakM3Umw3dGg0UG1PTG1L?=
 =?utf-8?B?RHRYbS9JK24zL0d4b1U1U0FyL1FOWWlOTVJXbWxrNCtsc2lqZzFmbVVpNnBq?=
 =?utf-8?B?MXNqVHZLTHFZbnREY2VFN3ZGam1WREQ2K1N3Q1FKT05QajJaWkpRR0RidURI?=
 =?utf-8?B?V0RIVkRuYndON0d6UnZ6ckMrZ1VnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5542323737D68744A277B353389A3012@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f50fd8d-7ffd-43eb-4c56-08dd3112aae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 01:04:00.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hplwLfkCdk4EOjWD4fn/PdRihmFVeOY0AAw7jl3gXQAGcbzt0mGIFcdQyh5NvF3btKiebBZ2xAarxtgaoDu0gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR13MB6801

T24gVHVlLCAyMDI1LTAxLTA3IGF0IDExOjU1IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gMS83LzI1IDEwOjM2IEFNLCBUYWtlc2hpIE5pc2hpbXVyYSB3cm90ZToNCj4gPiBPbiBUdWUs
IEphbiA3LCAyMDI1IGF0IDQ6MTDigK9QTSBBbm5hIFNjaHVtYWtlcg0KPiA+IDxhbm5hLnNjaHVt
YWtlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSBUYWtlc2hpLA0KPiA+ID4N
Cj4gPiA+IE9uIDEvNi8yNSA2OjU2IFBNLCBUYWtlc2hpIE5pc2hpbXVyYSB3cm90ZToNCj4gPiA+
ID4gRGVhciBsaXN0LA0KPiA+ID4gPg0KPiA+ID4gPiBob3cgY2FuIHdlIGdldCBBREIgKFdSSVRF
X1NBTUUpIHN1cHBvcnQgaW4gKERlYmlhbikgTGludXggbmZzZCwNCj4gPiA+ID4gYW5kIGFuDQo+
ID4gPiA+IGlvY3QoKSBpbiBMaW51eCBuZnNkIGNsaWVudCB0byB1c2UgaXQ/DQo+ID4gPg0KPiA+
ID4gVGhhbmtzIGZvciB0aGUgcmVxdWVzdCEgSnVzdCBzbyB5b3UncmUgYXdhcmUgb2YgdGhlIHBy
b2Nlc3MsIHRoaXMNCj4gPiA+IGVtYWlsIGxpc3QgaXMgZm9yIHVwc3RyZWFtIExpbnV4IGtlcm5l
bCBkZXZlbG9wbWVudC4gSWYgd2UgZGVjaWRlDQo+ID4gPiB0byBnbyBhaGVhZCB3aXRoIGFkZGlu
ZyBXUklURV9TQU1FIHN1cHBvcnQgaXQnbGwgYmUgdXAgdG8gRGViaWFuDQo+ID4gPiBsYXRlciB0
byBlbmFibGUgaXQgKHRoYXQgcGFydCBpcyBvdXQgb2Ygb3VyIGhhbmRzLCBhbmQgaXNuJ3QgdXAN
Cj4gPiA+IHRvIHVzKS4NCj4gPg0KPiA+IEkgYXNzdW1lIFdSSVRFX1NBTUUgd2lsbCBub3QgaGF2
ZSBhIHNlcGFyYXRlIGJ1aWxkIGZsYWcsIHJpZ2h0Pw0KPiA+DQo+ID4gPg0KPiA+ID4gPg0KPiA+
ID4gPiBXZSBoYXZlIGEgc2V0IG9mIGN1c3RvbSAiYmlnIGRhdGEiIGFwcGxpY2F0aW9ucyB3aGlj
aCBjb3VsZA0KPiA+ID4gPiBncmVhdGx5DQo+ID4gPiA+IGJlbmVmaXQgZnJvbSBzdWNoIGFuIGFj
Y2VsZXJhdGlvbiBBQkksIGJvdGggZm9yIGltcGxlbWVudGluZw0KPiA+ID4gPiAiemVybw0KPiA+
ID4gPiBkYXRhIiAoZmlsbCBibG9ja3Mgd2l0aCAwIGJ5dGVzKSwgYW5kIGZpbGwgYmxvY2tzIHdp
dGgNCj4gPiA+ID4gaWRlbnRpY2FsIGRhdGENCj4gPiA+ID4gcGF0dGVybnMsIHdpdGhvdXQgc2Vu
ZGluZyB0aGUgc2FtZSBwYXR0ZXJuIG92ZXIgYW5kIG92ZXIgYWdhaW4NCj4gPiA+ID4gb3Zlcg0K
PiA+ID4gPiB0aGUgbmV0d29yayB3aXJlLg0KPiA+ID4NCj4gPiA+IEhhdmluZyBzYWlkIHRoYXQs
IEknbSBub3Qgb3Bwb3NlZCB0byBpbXBsZW1lbnRpbmcgV1JJVEVfU0FNRS4gSQ0KPiA+ID4gd29u
ZGVyIGlmIHdlIGNvdWxkIHNvbWVob3cgdXNlIGl0IHRvIGJ1aWxkIHN1cHBvcnQgZm9yDQo+ID4g
PiBmYWxsb2NhdGUncyBGQUxMT0NfRkxfWkVST19SQU5HRSBmbGFnIGF0IHRoZSBzYW1lIHRpbWUu
DQo+ID4NCj4gPiBObywgSSBhbSBhc2tpbmcgcmVhbGx5IGZvciBXUklURV9TQU1FIHN1cHBvcnQg
dG8gd3JpdGUgaWRlbnRpY2FsDQo+ID4gZGF0YQ0KPiA+IHRvIG11bHRpcGxlIGxvY2F0aW9ucy4g
TGlrZQ0KPiA+IGh0dHBzOi8vbGludXguZGllLm5ldC9tYW4vOC9zZ193cml0ZV9zYW1lDQo+ID4g
V3JpdGluZyB6ZXJvIGJ5dGVzIGlzIGp1c3QgYSBzdWJzZXQsIGFuZCBub3Qgd2hhdCB3ZSBuZWVk
Lg0KPiA+IFdSSVRFX1NBTUUNCj4gPiBpcyBpbnRlbmRlZCBhcyAiYmlnIGRhdGEiIGFuZCBkYXRh
YmFzZSBhY2NlbGVyYXRvciBmdW5jdGlvbi4NCj4gPg0KPiA+ID4NCj4gPiA+IEknbSBhbHNvIHdv
bmRlcmluZyBpZiB0aGVyZSB3b3VsZCBiZSBhbnkgYWR2YW50YWdlIHRvIGxvY2FsDQo+ID4gPiBm
aWxlc3lzdGVtcyBpZiB0aGlzIHdlcmUgdG8gYmUgaW1wbGVtZW50ZWQgYXMgYSBnZW5lcmljIHN5
c3RlbQ0KPiA+ID4gY2FsbCwgcmF0aGVyIHRoYW4gYXMgYW4gTkZTLXNwZWNpZmljIGlvY3RsKCks
IHNpbmNlIHNvbWUgc3RvcmFnZQ0KPiA+ID4gZGV2aWNlcyBoYXZlIGEgV1JJVEVfU0FNRSBvcGVy
YXRpb24gdGhhdCBjb3VsZCBiZSB1c2VkIGZvcg0KPiA+ID4gYWNjZWxlcmF0aW9uLiBCdXQgSSBo
YXZlbid0IGNvbnZpbmNlZCBteXNlbGYgZWl0aGVyIHdheSB5ZXQuDQo+ID4NCj4gPiBHZXR0aW5n
IGEgbmV3LCBnZW5lcmljIHN5c2NhbGwgaW4gTGludXggdGFrZXMgMy01IHllYXJzIG9uIGF2ZXJh
Z2UuDQo+ID4gQnkNCj4gPiB0aGVuIG91ciBwcm9qZWN0IHdpbGwgYmUgZmluaXNoZWQsIG9yIHJl
bmV3ZWQgd2l0aCBuZXcgZnVuZGluZywgYnV0DQo+ID4gYWxsIHdpdGhvdXQgZ2V0dGluZyBhIGJv
b3N0IGZyb20gV1JJVEVfU0FNRSBzdXBwb3J0IGluIE5GUy0NCj4NCj4gRm9yIGNvbXBhcmlzb246
DQo+DQo+IEFkZGluZyBXUklURV9TQU1FIHRvIHRoZSBMaW51eCBORlMgY2xpZW50IGFuZCBzZXJ2
ZXIgaW1wbGVtZW50YXRpb24NCj4gaXMNCj4gb24gdGhlIHNhbWUgb3JkZXIgb2YgdGltZSAtLSBh
IHllYXIgKG9yIHBlcmhhcHMgbGVzcyksIHRoZW4gZ2V0dGluZw0KPiBpdA0KPiBpbnRvIERlYmlh
biBzdGFibGUgd2lsbCBiZSBtb3JlIHRoYW4gMSB5ZWFyLCBwcm9iYWJseSAyIG9yIDMgKGF0IGEN
Cj4gZ3Vlc3MpLg0KPg0KPiBBIGJldHRlciBhcHByb2FjaCB3b3VsZCBiZSBmb3IgeW91ciB0ZWFt
IHRvIGltcGxlbWVudCB3aGF0IHRoZXkgbmVlZCwNCj4gdXNlIGl0IGZvciB5b3VyIHByb2plY3Qg
KGllLCBjdXN0b20gYnVpbGQgeW91ciBrZXJuZWxzKSwgdGhlbg0KPiBjb250cmlidXRlDQo+IGl0
IHRvIHVwc3RyZWFtIHNvIG90aGVycyBjYW4gdXNlIGl0IHRvby4gVGhhdCB3b3VsZCBkZW1vbnN0
cmF0ZSB0aGVyZQ0KPiBpcw0KPiByZWFsIHVzZXIgZGVtYW5kIGZvciB0aGlzIGZhY2lsaXR5LCBh
bmQgeW91ciBjb2RlIHdpbGwgaGF2ZSBnYWluZWQNCj4gc29tZQ0KPiBtaWxlcyBpbiBwcm9kdWN0
aW9uLg0KPg0KPiBZb3UgY291bGQgaGlyZSBhIGNvbnN1bHRhbnQgdG8gaW1wbGVtZW50IGl0IGZv
ciB5b3Ugb24gYSB0aW1lIGZyYW1lDQo+IHRoYXQNCj4gaXMgeW91ciBjaG9vc2luZy4NCj4NCj4g
VXBzdHJlYW0gcHJpb3JpdGl6ZXMgZWNvbm9teSBvZiBtYWludGVuYW5jZSBvdmVyIGNvZGUgdmVs
b2NpdHk7DQo+IG1lYW5pbmcsDQo+IGhvdyBxdWlja2x5IGEgZmVhdHVyZSBjYW4gYmUgcHJvdG90
eXBlZCBhbmQgcHJvZHVjdGl6ZWQgaXMgbGVzcw0KPiBpbXBvcnRhbnQgdG8gdXMgdGhhbiBob3cg
bXVjaCB0aGUgZmVhdHVyZSB3aWxsIGNvc3QgdXMgdG8gbWFpbnRhaW4gaW4NCj4gdGhlIGxvbmcg
cnVuLg0KPg0KPiBXaXRoIG15IE5GU0QgY28tbWFpbnRhaW5lciBoYXQgb246IEkgd291bGQgYWNj
ZXB0IGEgV1JJVEVfU0FNRQ0KPiBpbXBsZW1lbnRhdGlvbiwgYnV0IGl0IHdvdWxkIGhhdmUgdG8g
Y29tZSB3aXRoIHRlc3RzIC0tIHB5bmZzIGFuZA0KPiB4ZnN0ZXN0cyBhcmUgdGhlIHVzdWFsIHRl
c3QgaGFybmVzc2VzIHRoYXQgY2FuIGFjY29tbW9kYXRlIHRob3NlLg0KPg0KPiBJbiBhZGRpdGlv
biwgTkZTRCBpcyByZXNwb25zaWJsZSBvbmx5IGZvciB0aGUgbmV0d29yayBwcm90b2NvbC4gVGhl
DQo+IGxvY2FsIGZpbGUgc3lzdGVtIGltcGxlbWVudGF0aW9ucyBoYXZlIHRvIGhhbmRsZSB0aGUg
aGVhdnkgbGlmdGluZy4NCj4gSXQncyBub3QgY2xlYXIgdG8gbWUgd2hhdCBpbmZyYXN0cnVjdHVy
ZSBpcyBhbHJlYWR5IGF2YWlsYWJsZSBpbg0KPiBMaW51eA0KPiBmaWxlIHN5c3RlbXM7IHRoYXQg
d2lsbCB0YWtlIHNvbWUgcmVzZWFyY2guIChJIHRoaW5rIHRoYXQgaXMgd2hhdA0KPiBBbm5hIHdh
cyBoaW50aW5nIGF0KS4NCj4NCg0KVGhpcyBmdW5jdGlvbmFsaXR5IHNob3VsZCBiZSBwb3NzaWJs
ZSB0byBpbXBsZW1lbnQgdXNpbmcgdGhlDQpjbG9uZV9yYW5nZSBpb2N0bCgpIG9uIHRoZSBzZXJ2
ZXIgb3Igb24gdGhlIGNsaWVudCBmb3IgdGhhdCBtYXR0ZXIuDQoNClllcywgeW91J2xsIGhhdmUg
dG8gdXNlIG11bHRpcGxlIGNsb25lX3JhbmdlIGNhbGxzLCBidXQgeW91IGNhbiB1c2UgYQ0KZ2Vv
bWV0cmljIHNlcmllcyB0byBkbyBpdCBlZmZpY2llbnRseSAoaS5lLiB3cml0ZSBwYXR0ZXJuLCBj
bG9uZQ0KcGF0dGVybiwgY2xvbmUgMipwYXR0ZXJuLCBjbG9uZSA0KnBhdHRlcm4sIGV0Yy4uLi4p
Lg0KDQpJdCdzIG5vdCBoYXJkIHRvIGRvLCBhbmQgdGhlIGFkdmFudGFnZSBpcyB0aGF0IGl0IGNh
biB3b3JrIGZvciBhbGwNCmZpbGVzeXN0ZW1zIHRoYXQgaW1wbGVtZW50IGNsb25lX3JhbmdlLiBZ
b3UnZCBub3QgYmUgbGltaXRlZCB0byBqdXN0DQp1c2luZyBORlMgd2l0aCBhIHNwZWNpYWwgV1JJ
VEVfU0FNRSBpb2N0bC4gRnVydGhlcm1vcmUsIGRvaW5nIGl0IHRoaXMNCndheSBpcyBzcGFjZS1l
ZmZpY2VudCBvbiBtb3N0IGZpbGVzeXN0ZW1zLg0KDQotLQ0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K

