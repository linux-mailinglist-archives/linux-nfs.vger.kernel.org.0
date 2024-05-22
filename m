Return-Path: <linux-nfs+bounces-3334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44C8CC12F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 14:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC63B23D54
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67E913D61E;
	Wed, 22 May 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KpHOdXxN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2123.outbound.protection.outlook.com [40.107.237.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBD13D615;
	Wed, 22 May 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716380709; cv=fail; b=Fq4qoUP3cOJXCzR2qTWK08ERoEoXyLrguEohTF6nhVaHlG8CTpb7hOOKKmyIIEYXexZO9Xe56Ma1FZ/TnmjiF2FocbqWqe4EgTg5kxWcsGReUYvElPFIAxTTpw7jSAo6BmXtVvZt5hKIu0QyiKJhHrtJPbZiPWCykv9X1JDDak8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716380709; c=relaxed/simple;
	bh=PGOXglHfBO0Ad5V+fsktv416sDU8cnoaO89EBJ2LT44=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lP5jvZwvNtmHFS677Gc1kqEMj5DnsLWmATvCQYtohixZkwvy44KvocIKa2BkSJvTYtAdaiWQHXEX8GkifX3i9OoLBIXykBNqlsojatwPjEvdWM103f0fUA4SmRANPibxDPXY9LIBedT2nu5ZdZiieJBQWZ3Mfk8736aw1oWiYvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KpHOdXxN; arc=fail smtp.client-ip=40.107.237.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAn+RBGCbzOa1ctE+Dw6VzXKBEAPqm5vJY3Kgwbs68+iP/YKtcJp+b4i0jK0s9r84SlICnRzt6wGRwf1Ojjr+7wgwhlSOyLDRyXLiuWdmAK4pfkYFyU14y3WfjZqFySyFnVSakq5SF32zDqR88+mpZDkrYAf5dpaBAIfeNojKnqybdC2dkTkDTSFMcxqQwSzKC3Mz+0BNQiOwJ8rLYh9+1j3Sllt+ZGW7/ql9CYN9UwUn3FWzMMSvCezpywFQPcV2LJUlRh4rGQwHxrHjOGNXkwQb47bINnKO2BLmsR3Xzi0W1YhS1zkCQHBaFvw3+jBydSnwElHpoQDUAanBU/MGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGOXglHfBO0Ad5V+fsktv416sDU8cnoaO89EBJ2LT44=;
 b=FZCDs9OpmbZBgFK2aTNgDqrWqsuwA8+fDhmLOufiYvp3IlcM+DdvlEHUQEtQptn59gsKfSRhObB+8VvVso4bhLjtHIA+EhgrOuEEWpghkhdGyTuYqRQFhg/C3McjweBmpOm0Jh9EvBFI6jCt4jBF88KdEP4/1FcAconVAwG9dfQAnRDH+q5O3ggbXzzyKxrZKndJxpwXEFttDOxVcZkGSv+DYdfAiQibAC0N28nhQiZFKheO2cXwATR3NUIY6/B6NPlNVtWKF0VFGiueMHAuIkPyey9e1yyeFZBmMz+DTalrNwQqw0YXaPFTJ6WkRRI+1k1GZ/Gr6CMFDr7OYIYbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGOXglHfBO0Ad5V+fsktv416sDU8cnoaO89EBJ2LT44=;
 b=KpHOdXxNNTv+OgOSgozI8cWdCd8IFx1KfUzZAFdE2qUkubxmdUIvW/LH46P4SR7TPuFbqKN1E5RqIbuaQwxGXb32ZbCZqe3S9/6SM7lQA4tk0snea8RFldUNMTP81K2/P8ATtYyJWJtR2qDq7Bv1Ne6aObYk5SD5BCZsNN9AHkI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by IA2PR13MB6651.namprd13.prod.outlook.com (2603:10b6:208:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 12:25:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 12:25:05 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "mastichi@gmail.com" <mastichi@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: Fix memory leak in nfs4_set_security_label
Thread-Topic: [PATCH] NFSv4: Fix memory leak in nfs4_set_security_label
Thread-Index: AQHarBwSsfN3QRxZV0yph7pyPtpuAbGjLe0A
Date: Wed, 22 May 2024 12:25:05 +0000
Message-ID: <04bcde52ddd657ef9d9380b6e810671c0e763fb9.camel@hammerspace.com>
References: <20240522074524.23046-1-mastichi@gmail.com>
In-Reply-To: <20240522074524.23046-1-mastichi@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|IA2PR13MB6651:EE_
x-ms-office365-filtering-correlation-id: 8a2e6ae9-6f57-4d3e-05b7-08dc7a5a3666
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0k5V2JOb0QwcXFWWEhqRnFHVHFCTFBQUXNGaWk3clB4VjFBSXAvTHR0emJS?=
 =?utf-8?B?N3gwNi8vbXg1TXowTGYxaVF6NlhHWGFIb3V6SDBDeHZZdTBpTGpaVEhjZlA4?=
 =?utf-8?B?Z001d1FpeE45VDl3NGtzY2NXQktzVnBVellRRlVBT2VsbHgxQzBpYU9NZlM5?=
 =?utf-8?B?TnpUZVU5aTJSWUhoa3ZuZHkxbmxGNXg3bUpEaEJ3SVAySzhORWxzVWNKL3dC?=
 =?utf-8?B?WFpwRk11WEFNTWlwcndlTDVpNlhuNXU5Rno2THBBV2RzNGUxbmtnZWpHeXdZ?=
 =?utf-8?B?dEdyOGpwWTZZRXdBcG5DTDBFdVJzMUNmRjkyVGQ2Njdmc3M2OXBPZVc5eUth?=
 =?utf-8?B?ZFhROFR4QjRLeGE4eUhwZCtickp0VFBPcEl0UG8vY2NJcENibkpmR3lQdTZp?=
 =?utf-8?B?R2REay9DcVFJdHFmTVZxTUVhazVuTU1zOUgySXliYlMzbFRVdHg0OWwvd01P?=
 =?utf-8?B?UlhndVNFRTljOW4wdE85SFpndHBCVjdVUGpxYzNiRTBDSHZRRTNnMFVVZTVI?=
 =?utf-8?B?TmN5Qy9Sc3RoblFtQnJhNEdkMjZBS1hScUZaNHljN2V0eU5XM3Mxc1haTFBO?=
 =?utf-8?B?bTB3U3luNSt1bC9oT2ltY3NtS2hJWEZVMEdrSDd4YnVJcWN2RjNwMkw0b0dR?=
 =?utf-8?B?V0Z1M1J1QVJWUVAyNm9wbFpzZkd5VE5sRFg5cFAwdVBvTmx0NXdRaW8ycTFQ?=
 =?utf-8?B?ekFzWjFOSUErd01WRGVTeEVRNERhanlTN2szSVJYSFl3cWlzcFd5US9RbUFz?=
 =?utf-8?B?YjlzSHA3bEFsZWVURzFWbW9KZmVuSVNaMlREZUV4cTFYSVljOG04SEMzUWVy?=
 =?utf-8?B?UWtpbkxwcm1VajUrb01ld24rOFhMcHRZVUFCNDBia1dyTG12emVOaEdyOHd0?=
 =?utf-8?B?QWp4Ylc4c0lIbzZ5UloyQWFJdDNsajV6cXpvdlc5YzBzWFRuRGxZL0U3aEtS?=
 =?utf-8?B?cmIrUjFLL3pFSmJYcElXc05Td1JUWlFmRm40b1EyakVZRmIzRDl4QTltcTYr?=
 =?utf-8?B?VWQ0UVpFU1FxcVhUcStyZ0ttMnpyZ3hXaFNOMmd2SjhEN0czOUhQeTRPTDdx?=
 =?utf-8?B?T1UySkxYQmxoOVc4Nlo1QkNKMEJvZlhzbVBrSnlJNVZ1S1VLVWg2aC9CTDFG?=
 =?utf-8?B?aGVOWXM1NE9GaDBtd09pZXl3R29vMWZSOU42clAzaFZGZ1ZRUW9WRC9OR1Fm?=
 =?utf-8?B?dCtFR2ZJa3laRUUvL0orbm85WXhqODBURmZlSEFtYkJydWhxUEl0QUlHdnJ3?=
 =?utf-8?B?MXVxb212NEN0MTBpTUxxN0pkU1JVRWI2NmtCcm5SUVZBSTcwYllQYkpFS20x?=
 =?utf-8?B?N2xCOXNyNEdvaUtmNG5tTU1nYTVvZTBVVXJtUHBCbHJuam5QLzJsTk1pQ0Fx?=
 =?utf-8?B?YW5oS3c2eTFKSzlXZFNzNFE3VXU4SDVGUjE3azZhR3QzY2VMU0g1MjRqcXM2?=
 =?utf-8?B?aVBOR25mcDZlaEFUVTJ6cmhFNnNGcDNSMnZtK2h1WkRFZUZwRXZTaUVWNTJh?=
 =?utf-8?B?eVhWVm5uVUY4aE1IRldwWkp3UHYrdWRrWlBNZk5EbmR1akhmRXR5VEk1Q2lJ?=
 =?utf-8?B?MDZvemRRdUVNb1BQT0gyS3B2WURYZjF6SXd4UUdzMit6cU14dWRRS09RY3U5?=
 =?utf-8?B?RFAxandEMU1JTHhGY0duSjhSR25TUjZKWnpOQ08vOTlrN0F5bi8yTXBoYlRu?=
 =?utf-8?B?THE3aWpMOXQ2c2RuV1J0MmFMQTJnU2t6YVVORlNEOUdYbS9UeFcweTg0bmdY?=
 =?utf-8?B?bzR6K1lqK01RWHhoemlrdUtVQWtlYXFNaExURFN4NTRrdlE4WnhwZDVzNlV3?=
 =?utf-8?B?QURISGZqRStFZC9mSUlWQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1V2V1hMWnpxOHIrOVJvUFRNdU5Bem1TNFhJSC9mVTEzUkJmREVVTzJ0SEdU?=
 =?utf-8?B?SzFVaFlZMVM1eHkrTnVGWTFlYmN1MUVvQVVNTlp0U21SUTN5cERzRzRONmlr?=
 =?utf-8?B?OU9aRDlPa1ovQUQxbWdkNHRGeS90UVo5Qm92UUNaL21mQlg3SHRvRHdtUzYz?=
 =?utf-8?B?VHd1ckswVWgrOWE1NzR3dVBHdTNkUjNrS1BSc0dDeGRnUGRlKzViNXBBWlZK?=
 =?utf-8?B?ZTRUTjZjTWVGV0Q1dVY2eVA3Z1Zra1prWFNCR1ZmWjNZc0xRT0FjZ2VQSFhK?=
 =?utf-8?B?c1N4bjhFbWtuN2UxalNuM1lJenRNOE05ZmxRQmJYZ3RpbENXdnh1MkMxRENN?=
 =?utf-8?B?ZytjM3pDTERoY1NyN3l4S1gvampBQTg5RHZ0aDhoNGZvelV6NWY3eHhITXJs?=
 =?utf-8?B?Wm1oVHU0RjhsYzhsU0ZsUVpqSFFGeEc4YzF5UldXOUpNbk16ZXN4emFseUlm?=
 =?utf-8?B?ekNDTk9NZ0Fpb29FUTFXWDBCdXp2bzRsKytmNk81elZiRlVQVFpleTBIOE5s?=
 =?utf-8?B?cWFzWW1GTUtHd2VVKzBFcUJzUnBBeVVXZVRzdmdzM0pEV0k3UGFxN0tYN1ox?=
 =?utf-8?B?SW40ZTMyd0NlQWNnVHhBL3FxKys3TnNmRDVWb09OR3Z6ZjVpcFFoUGxuVXRZ?=
 =?utf-8?B?SEV5czA2QTlnVHl4QVFiYkJqV1ZaTzN1bzBLN1ZSai9paDNaNVcySGNCNTBq?=
 =?utf-8?B?bDUreHhEbk9LYkkzdUxleFdvNzZQdFgweW5KbHc3M2dVdi9vbkUxWG1scGRS?=
 =?utf-8?B?SkxqMUVDYndPcVJtZFNaeWxybFE2YlJEa1YxLys4TGtPYVJPSjJJM0YvMjBK?=
 =?utf-8?B?OGZjZGZHUDYxeDlHS3o1ZnFUcnc1ZWlxOHdNdWJweEZhQlBORng2RllseTJt?=
 =?utf-8?B?c1FBcFUvbnNwdGFWbFgxYXU1cDA0OTE5c3ZNeUVDRk5ZdXdMa2VHYml6ZlA1?=
 =?utf-8?B?TXpzYlVDVlhzL0VsNDZVeVpOWFR5M08xRkI3TnRoVDJQZHpxTUtrcitDWkRm?=
 =?utf-8?B?b29uNkJpSGVoSkVTKzJmelFpOVB1N1NHbCsvMHdpNy94NVJCTGU5SUJIOTgr?=
 =?utf-8?B?ekNHNEZ1cXpaVzVHZHlZaDIrYzJWWDczeENrbVdmYnFSa085TXQ1OWtXOU1T?=
 =?utf-8?B?dHhRRlI4dmlseWF0TnhwWDgramxBT1N0UWMwbkhDa1hrRk9RR21JbEVqcERh?=
 =?utf-8?B?VEV2T0pzdkN6MnREMENnNzcxL0gvcDIwQmN5dXdqZjBmcFRjWDFHanVzZFZv?=
 =?utf-8?B?b1h1TzZlOGEvUlAyU2pLeDc5ZE1kMnJQZlRPaWQ1SE5IbjFjaE9lNGhWN080?=
 =?utf-8?B?ZmQ2SjI3S1hIc0ZhMzN0Z1FPb0tjU2FIVm5aVm1VWUFOdHdWbDhpS2dkdEhS?=
 =?utf-8?B?NFl6NHphdlljN29wWFZRTTJFVnZZVDAzOE9Mb3NQaW9hQktTajRhY0I1QzBQ?=
 =?utf-8?B?R0I3ZnRFaWRBUmlBQkRjZ2dKQWNiUUd3dG5VVFdxQkFtZFovclVUb2d6UTJu?=
 =?utf-8?B?Q2M1Z2Rtck0yT05qSzN4N0phOG5jK1FWeWRFbEQweUt3b0liWlE4SURyY3p4?=
 =?utf-8?B?TGNhMUlKalVqcER1RWZldFVEdTZ4bWN2Mkl1L0FoT0k0N1N1N282bHptTTlp?=
 =?utf-8?B?eDFFY1NKNmxDNkRaMWYyaDN4QmpYb3pMek5neVJqWlhlRWJ2Mk02Z0dyMmI4?=
 =?utf-8?B?SG9GU1VQTmFzYUFWUTZLaE5MNm5FMUNaQWdOcHBSc2lkZVRtc2FKSDI4bm9J?=
 =?utf-8?B?TzdGS3pNMDljYkx1VlNKR0Y4dk5MWjBlSHRKUDR3ZDRmNllVSi9zczNPeHA3?=
 =?utf-8?B?dENDcDBZOVJYNWM3OUl4bmFPT1JwMkV4aHpPTEdBbm1mYnVTZzdOcUZtd3lP?=
 =?utf-8?B?bnJTQlgwc016eE4ydng1UllXN3l2ZDVQa2tteFFOT2ZjVVNyYWhjUTBQTVll?=
 =?utf-8?B?RU5iQ0M0dXZvbU9tMEFCVW8xK2JGYUJwZWFYMXphVlZEMEhTNWdxTzZlUWls?=
 =?utf-8?B?MlpoSUhyYmtrUHVHVk5nOTZ0Z1p6Mm9TTnhsSTh5Q05udjRYVHlyTjBic2FI?=
 =?utf-8?B?VWxnZk50WS9vaUs2SFptWnJNTmxscERKV3plUTgzTHBCcmlUYnNSVnl2Tk1x?=
 =?utf-8?B?Rng4L3F2MXE0TXc0OHJ6alZCUXZSWFV3N2gwODVYd3hqMnZNQWFrTVRld1E1?=
 =?utf-8?B?UDEwNE40T0FMeEh5TjFnSUhVa3o0T2NzNlNGcjUxZXlCQnNISEdxdVFmejdv?=
 =?utf-8?B?ZVk1Z1g3Sjc4c0tjUG8vYmRVZU1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6613171EEF4A2E439EB2276D40FF9084@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2e6ae9-6f57-4d3e-05b7-08dc7a5a3666
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 12:25:05.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPV+9tWCZMvQVe53J28yaEx1KFmiYeqsSjawbfmkm3gWKV5VsbCG8GIP7m/KXZ6l6RKe3LHs7PdttZjmEOutqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR13MB6651

T24gV2VkLCAyMDI0LTA1LTIyIGF0IDEwOjQ1ICswMzAwLCBEbWl0cnkgTWFzdHlraW4gd3JvdGU6
DQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gbWFzdGljaGlAZ21haWwuY29tLiBM
ZWFybiB3aHkgdGhpcyBpcw0KPiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91
dFNlbmRlcklkZW50aWZpY2F0aW9uwqBdDQo+IA0KPiBXZSBsZWFrIG5mc19mYXR0ciBhbmQgbmZz
NF9sYWJlbCBldmVyeSB0aW1lIHdlIHNldCBhIHNlY3VyaXR5IHhhdHRyLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRG1pdHJ5IE1hc3R5a2luIDxtYXN0aWNoaUBnbWFpbC5jb20+DQo+IC0tLQ0KPiDC
oGZzL25mcy9uZnM0cHJvYy5jIHwgMSArDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHBy
b2MuYw0KPiBpbmRleCBlYTM5MGRiOTRiNjIuLmQ0MDAwOTNhMmZmZiAxMDA2NDQNCj4gLS0tIGEv
ZnMvbmZzL25mczRwcm9jLmMNCj4gKysrIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gQEAgLTYyNjgs
NiArNjI2OCw3IEBAIG5mczRfc2V0X3NlY3VyaXR5X2xhYmVsKHN0cnVjdCBpbm9kZSAqaW5vZGUs
DQo+IGNvbnN0IHZvaWQgKmJ1Ziwgc2l6ZV90IGJ1ZmxlbikNCj4gwqDCoMKgwqDCoMKgwqAgaWYg
KHN0YXR1cyA9PSAwKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX3NldHNl
Y3VyaXR5KGlub2RlLCBmYXR0cik7DQo+IA0KPiArwqDCoMKgwqDCoMKgIG5mc19mcmVlX2ZhdHRy
KGZhdHRyKTsNCj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHN0YXR1czsNCj4gwqB9DQo+IMKgI2Vu
ZGlmIC8qIENPTkZJR19ORlNfVjRfU0VDVVJJVFlfTEFCRUwgKi8NCj4gLS0NCj4gMi4zMC4yDQo+
IA0KDQpUaGFua3MhIEZvciBmdXR1cmUgcmVmZXJlbmNlLCBwbGVhc2Ugbm90ZSB0aGUgc2VjdGlv
biBvbiBpbmRlbnRpbmcgaW4NCnRoZSBmaWxlIERvY3VtZW50YXRpb24vcHJvY2Vzcy9jb2Rpbmct
c3R5bGUucnN0IGFzIHlvdXIgcGF0Y2ggYWJvdmUgd2FzDQp3aGl0ZXNwYWNlLWJyb2tlbiBhbmQg
c28gZGlkbid0IGFwcGx5IGNsZWFubHkuDQpTaW5jZSB0aGlzIHdhcyBqdXN0IGEgMS1saW5lciwg
SSd2ZSBmaXhlZCBpdCB1cCBmb3Igbm93LCBzbyBubyBuZWVkIHRvDQpyZXN1Ym1pdC4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

