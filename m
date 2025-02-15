Return-Path: <linux-nfs+bounces-10134-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 409FDA36BAD
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Feb 2025 04:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3A018961D3
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Feb 2025 03:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3184178F4B;
	Sat, 15 Feb 2025 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OayNvszD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2137.outbound.protection.outlook.com [40.107.236.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F95B211;
	Sat, 15 Feb 2025 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739590569; cv=fail; b=I/8r+HKIB+WRKdHB5gd2cvvqFuEQQGp18xTOC+3gBX0X/By7/MHaFlAxryX41Q68i8k+2W7EMEYmBYHQIC5m4GB8JXpaZAEiD8oMbBhfBcmTkIfxOFAakt8/b7+9tsomRqCSD9MXNaWNdAaogmBclhMo+8gV7HUH2CqtSHDVXsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739590569; c=relaxed/simple;
	bh=cxhAyJ9731dIctFm++oID5r6PTYQkcHk4p8cKzYO8lA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JfPbSrPnsVNUOVK2LM0+/tFneU3nKzlBuh6WmWmNqJjlFRADAkDm+2mh2sUkfRVZvAAW450+Mr+vL2L/uf++qfVWxEiz6RmKC60LtZx5u12pFFRWPMpHELtqibNqaGc4Eiew8379M33qtXeutM2K+U/vsnJP17jRbs5Wr7E+snw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OayNvszD; arc=fail smtp.client-ip=40.107.236.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4B7SBaaxVsTOlg8BuOKqpj0Lj5itArMP1b/p7vd3q5RHM80+vM+bC3wS48dFKP9mFYS7QJ5ZBnOYK27pJmW6Hm7KJQ195Zo3jk2uYwRsmhOv6Ykzzhkkt47u9FyvJFDocTTKKMBzxv+MGDz4eyif/eiQVb2HXxFQDUSoWZHuMpO3oBcSywPgsH3P4T4SB7VynzvtHMOQ0RZ084eWV75MswAwL5C20ZqIwD0kjZeMpLSwCMXYZJSt/0GOVfBsc99hQcGZWCmecR6gu1lwKVK3+YkJB7dgP+ExBTLIMtWo4vaRn/pUGaCOP+ak/LYshZs0/K3sYRwcOFbBG8cOlmPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxhAyJ9731dIctFm++oID5r6PTYQkcHk4p8cKzYO8lA=;
 b=LZ33J7HZrSPq1/X5XSWq2ZFFEO7XMn9RaYWFZsKpW23V1ZRSIKtZqgJSA8l4yARR2+/RKtWaH470gb8PZIujTsUHRsy9Psfx70pQQWYLtfxJOSnute1rHEB7mOkL/OROv30zOFpmp1R2mc36RWk3xqjZyq74xUMOH87pcfMnVeViuv7ggDapXnLjB7VS2OHE/Ov0iwgCt7xESpgwxPfZt22yPawAs5NaUYqz+sZFQSvD5PLHcrIxYh5ifOvf/w7YSamige/yTr6c83zmNPV5RBFZAAojJMj8tCWuMEBApCsX+Fzezujwt9B3IDn/x0EJY0AMFmD6jZ8pMQtJRNmAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxhAyJ9731dIctFm++oID5r6PTYQkcHk4p8cKzYO8lA=;
 b=OayNvszDXCRUqP3TfpPw3VJrotqVOSdpPyQeItDDBMpgJ2nA5G+oFjQV5/md4ZOqBmwuxkKecefjnD5lAgDD02kTj3iqB+3j3wtOySwQblvSRz/F+gHIIZKgVEe7DzL8y/voJp1JRPjPLs2ZvQpf3LnWjjG27uXiWYbtKUFicy8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH4PR13MB6856.namprd13.prod.outlook.com (2603:10b6:610:22c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Sat, 15 Feb
 2025 03:35:59 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8445.016; Sat, 15 Feb 2025
 03:35:59 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "lilingfeng3@huawei.com"
	<lilingfeng3@huawei.com>
CC: "houtao1@huawei.com" <houtao1@huawei.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "yukuai3@huawei.com" <yukuai3@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>, "yi.zhang@huawei.com"
	<yi.zhang@huawei.com>
Subject: Re: Question about sharecache
Thread-Topic: Question about sharecache
Thread-Index: AQHbf1q6Ej9fcI0ZeUmoqIfY8Nj/0g==
Date: Sat, 15 Feb 2025 03:35:59 +0000
Message-ID: <793e66cb7551ccf1d94c64aa886446d858fc678d.camel@hammerspace.com>
References: <1ed195ab-2e9d-40b9-acd9-6989413b6bbf@huawei.com>
In-Reply-To: <1ed195ab-2e9d-40b9-acd9-6989413b6bbf@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH4PR13MB6856:EE_
x-ms-office365-filtering-correlation-id: fe892261-280e-4536-8413-08dd4d71dd08
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlJtT1Brb1RPSTR6b2VSZjlHN1I3TjVnbnV1MjE0OVlRTEpTcHdxVEJxbzhr?=
 =?utf-8?B?dGcwQW1yRzZmcTVrQ0xidE1pNWV1QXd2S0ExTlV2dmFBNjRDRytlYXdmSjBF?=
 =?utf-8?B?d2xKLzRWOUFxeDU3Q3lXSHZzUXE4dk9Pb3d4TDhDV1lBSGJqeHU0aW1SWFdw?=
 =?utf-8?B?RDRqOEtFemMwN2JzK3NmOFZoQ3JCUzY0QmdpSWR2NFlKeWVKNE83Snd6ZWVx?=
 =?utf-8?B?SW1Hb1pURzVpUlFieHh4SFY1VDFHSHJ1K3hENVJDRUxFVXdrUGZRUWh4eGgx?=
 =?utf-8?B?NUVYUkZ1bGxQVWJtM1VHM1ZkYkY3VnVIVURsenJGQTNqRkh3V21WYnEya2t1?=
 =?utf-8?B?OUMzenA0Z2QzZktzOVdHaytSR2FNREpFUFhNbGh2VFR3K2RKdEkyb3VrVjMv?=
 =?utf-8?B?NkI1TXY0T0NpaTd3Q3d4VXZWWlFQYjQ2U254clVNN3NlcWl3VnhFalA4VGdX?=
 =?utf-8?B?U0RlcGEvUCtuc1oyRXZWQUx2aFZCSTNlYzNtUzllVW1VYWVYRTRFMkM4OEpG?=
 =?utf-8?B?MVFPVzJsRktCeElqTUhFT1JNMVoyN3JCcnNDTVNsd3NxTTQ2aXl4MzhjOC92?=
 =?utf-8?B?emFLaW9DVlh2ZnVjNnEvVjNaME1TeVErUVAwTWZVaFpSZXUrckQ5THhjNUlB?=
 =?utf-8?B?WXl5NTY3ZjBTajZYUU02RyttcGQ3Y1NvUTBITS9YOUUzOTVVN09kaC95ZWF1?=
 =?utf-8?B?cHRRYzJyRW1YajlTZHV3d3VkbTRYRnJpd3ZVLzE1dWpra3Boc1lUK2dsVzgr?=
 =?utf-8?B?TkE5dkxCN09uZEVzYkNOcVA0eXpRS21hSDlxeHBMa1hzVk1pbzhYanNFV0NS?=
 =?utf-8?B?ZHQvTnhTUVNYM2VLVlJYTnFqbXdiMUNMY2NkLzRheDR6REZnQU9JcWV5NEo0?=
 =?utf-8?B?MFJBVVN1YUNsVitrN1krVEQzeVRIRFV6eERmQU56WS9RTDU3RjRERFJHWjk3?=
 =?utf-8?B?cllJc1dmcVRNRGR1QkZCQmdtcEhBSHJXeFhjRlVYcFR5SmFiMm11aDViYnRw?=
 =?utf-8?B?WlZHM3Zaa3ZzdS92Z0QvT0RZbVNiS3lraXRrZndRYjVpVkJ4RkRCcjJYdHJO?=
 =?utf-8?B?c2dIcXkyVDF5NmV4QUIyZ3V4VGZheXUxUUZqMi9hZWdHQnNBaTNvY3hKMTEw?=
 =?utf-8?B?OXl3aWJuOTJTWFJZc2dpZm1EU29xMCsyZjZUdHM2cjg5MDVqZGsrSnhvS25N?=
 =?utf-8?B?NTU3dENDSHE5bTZKbUxhaUZnRUVPWm56L3FsbWo0cGFBRHVNSUoxa3JTYjF4?=
 =?utf-8?B?UVZ0Z3JCUEVORmRhcmplblp5K05MWGV0dUEzR2tBa1BzM3dTeXJVbGNxKzdt?=
 =?utf-8?B?dzhsY3FabDN1THpqelFsNGVtRGpjY1pvaXR0ZVZSQUVWL2FXT29VMlV2a1RY?=
 =?utf-8?B?NWNJNFUzRlNPVThZZWFqY0RsVURXK3BXWnhvN3YyT1BmbGxuMmJ3K1lqNXNH?=
 =?utf-8?B?YmtnZFJ3a1NXNG41bjBYTHpJaFp2STFRQ25sQjVZZXpPb3hMVzVFbVgwa2gx?=
 =?utf-8?B?UjlhNTcyd1BVWVR5V0Y3Q1o2YzYzMHFMSFBGS3kzeGFJYTlhWmhGdWh6cUNl?=
 =?utf-8?B?VXphamg2Mkh4M3o4V2d3SzJGK2VqcmRJTkdHVHpIMkhuQzhYUE5DeXVkL2Vz?=
 =?utf-8?B?WE1KaGdKdUFoQk9POXdHY3hIOU8rSWp0K0ZIdmVpZUQyeklCcmtkSG1NT2VZ?=
 =?utf-8?B?ZTVZQ3I1YUlMTTVIWkdxRFNlMXBLSkdkcXZ1ajVhN2crOXdpWG84M0Vhalpy?=
 =?utf-8?B?a3hzRTRacnAvZkJtM3F6b1ZIckNXYXZBV1UwQU1FK0NsR1RkM253cHMxc3Rr?=
 =?utf-8?B?SnF1b1d4eWsxekRBdks1bXphS1dYclJSRXhHVTVkamVRY25DYUw0U3ZjRkZs?=
 =?utf-8?B?cE9kUVZWbmwyV2M4WU9sYVROMGhXVkJUekh3bjEwdk8rS2tXdEwvRWlleEhD?=
 =?utf-8?Q?YfSiXfIGmRGQAJRMULXLlvKS+AGOKuUQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2FsN0NTZ0ZpSTFuTEhBWEEzUjRxQ2FxSXN5WnNkVnR5NkdlVGdXZkZLczIy?=
 =?utf-8?B?Kyszdm5OeVptaXl5c2M3RTFtV1FVVysxbFhWSElFTzN4UDFZRkhrbGZTem05?=
 =?utf-8?B?TFE3MXowa0d0OVFkN0JxSVgvUTcrUUZad2RlbVdRVVd6Y3Izd0J6azJyT2k0?=
 =?utf-8?B?T2dKNkVTWThldTBCeG5uSGp5NDhheVIvQnZUZ3N0THlXVllyNjBZV0V4UW9F?=
 =?utf-8?B?Um0yRnozZkRuS0ZUTjJSSktpS3BabFFBRUIvVlFJTkgzT2RkYkNSRUZvdnpG?=
 =?utf-8?B?Si9KU21Sb2lLWFNqelRFN3dER0lrNHRtMXBKbWRRRUd2TElCRFI2QWsyejho?=
 =?utf-8?B?c05BdFpuOGhtTmFpV2JDbElPNGVvMlJCanlOOENiR3p3bVdGSFVqaHZGVkpD?=
 =?utf-8?B?amprSTlIaEFuL0EvaTBKM3YxbUMvZ3B1U1F4U1NpTVNUbTFjb1BrR3Fnc3hr?=
 =?utf-8?B?cVJZOWh2Mnh3ajNoMXVuclE1R3NIUzgyTjNjV1NmanZ3RjhZMm1VVGF0bnBH?=
 =?utf-8?B?eEErSUxoUlFpRXY0MVIrMHNZQklLMVVGb2diRnB4UmNvem1PVW5OUnZ2cmJ6?=
 =?utf-8?B?NE5RNTA2dkhmdzBNR0ptOXdrYVNnNlFSeHRqelhITGIyZno2N1AvR3Z1VE10?=
 =?utf-8?B?ZkkwbVJoeU5XbjByWDhVVFdSdGM1Sm1Ja1ZBL25jSVRzTW9HYVFvVGgraVVX?=
 =?utf-8?B?ZE9FRjZFZzNjNGRDRWxBNyszMnB5bFhqRmoya29iSjU2TG5VSnF2YUYwUURm?=
 =?utf-8?B?ay9PSmRtTUhRaTB6VDR6TjZqQjlvelBaRlNYYzl3c1RBcmhUeElablo4eVN3?=
 =?utf-8?B?NGZORjJYeHo1cXd4SVJHYVRKeUVuaDFweG9wa1JvOFhLRHlhNmVIRzcvMkRo?=
 =?utf-8?B?ZnpETUd5M1RSVldkQi84clphNzdzVlArem1JcnZBRkxQcytwY1dkdUpWOFlK?=
 =?utf-8?B?R3N1T1h5VTlWSVMzQm02TG1EWks5SVBteXJVdDhIM0x3WHAwWDFzUlZRdkdT?=
 =?utf-8?B?WGJFWnlVZ0hpOGhuZ0ZVK1lvaXZoU3F2ZlZibitzazJKQVNsLytIbmxHRjUy?=
 =?utf-8?B?RGFUb2JodytIUnBUNXAyWTVVWVZOWWsyNG1zb0Fyd2Z1b2N0VlIrU2VSNmVl?=
 =?utf-8?B?c2hUV0VNK0NzbGJXV1FxM21oSWVjWng4dCtUOHQ0eGJmWnZkeHFBTzl5V2RS?=
 =?utf-8?B?aHY5ZXROT1o5SzRydWI5K2dPMHJzbmQwT3NLaHdEVXlhTFNCbkhWdUJqVGEr?=
 =?utf-8?B?ZTkxTnFBSmdXVnpEaktEWGJnN3JZa3lHQ3Bxa28veEloT0FrWlhLaHlBdkxO?=
 =?utf-8?B?dzhqcUcrazZlemNGc2t6WlBrdjdUeWdmS0V0Nitya3VVaDZBVWo2TUdKcUZW?=
 =?utf-8?B?cFEwRll4NmFrVFBtaGNESTFad2hQVHRIRUVLaHgxYXRPdUJibGtJazRyanc4?=
 =?utf-8?B?WElxQmI4cGptb3JQVlRoMnNDQVBYUU4wMlFIMkhOMklKVVZETElqL1pKVTlZ?=
 =?utf-8?B?LzUwbnNkcUZhVjc5T1NJL0NHRzN6Mzc0d2dpanRIR3pIUytDV2FhcCtNL01p?=
 =?utf-8?B?WE5KWmpkNE5aUU1FR3RHc0U1VU02SkVIYndlZXVxaVJUY3pwWnUvTjlJa0sv?=
 =?utf-8?B?UHVPOUxNajF5WWN6a2RNYzZLVXZnakl1M1FpYW11Mm5tWk9zU3NzOEJjdldx?=
 =?utf-8?B?dXN1N3VISDlUcWhlYkowWVVtUTVFYkE3SHRrMVNiZWhwcmVNRVd0N0o3UGZB?=
 =?utf-8?B?L2d5cXhOeTRGUTFCeUlheEhsWDhvWkNRU1JzVmEyQ1NlZGhaOXJLQ211WStl?=
 =?utf-8?B?N1JvTGZ5dTBrK1B4SGZ3Rnl3MlZYVTFYL2VJcUFKdGNGbGp1UlVvblFodXAv?=
 =?utf-8?B?WTVxYzRwU1hRWm80Z1FkZ1YvM2ZTWGcxRk4wS3JhM2wrcWtuUzBqc1pmZFN6?=
 =?utf-8?B?NmNtTnJSUytWYnNUZjR3bWZWak8yNERIbXhVOW5OSUZ0WU9tbS8ySzVVdHFB?=
 =?utf-8?B?dVRaNUFiUnA1QkdxNHpRcXBPSGd3aHYvczMzanhYL0UyOVUwWXM4SVh3Ym5B?=
 =?utf-8?B?em51UFNONFNwcGxBZXEzamJ2dGV5Z2xlS3NUdEsvMFZ5eVVhakhTUlNBdVZE?=
 =?utf-8?B?UzFlM3A3S0tGdW1GSnlseUFCR2xOOEFVSVRaNWJjWExKeVRNT3l3dHpmZmVY?=
 =?utf-8?B?K2VHZUd2ZlpzOElnOXhjdlpvUDlqNHdpV2l1QU4yeHE5OUxWNzE5RFlZTTB4?=
 =?utf-8?B?UEN3NFZjTEljSGNob2pJeTQ4cE5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7AB746A4D5F8F4BB0590F7FF0E14AD6@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe892261-280e-4536-8413-08dd4d71dd08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2025 03:35:59.1177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sFW0Un+pNXJg59vkElzLLJkmfLc/Gv+/HnlepAsllo2h70e2ecPVLgCoKHOE8Q/DlOtxH0x59CO13VNNpqTLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR13MB6856

T24gU2F0LCAyMDI1LTAyLTE1IGF0IDExOjEzICswODAwLCBMaSBMaW5nZmVuZyB3cm90ZToNCj4g
wqANCj4gSGkNCj4gwqBBcyBzaG93biBiZWxvdywgdGhlIHNlcnZlciBoYXMgZXhwb3J0ZWQgdGhy
ZWUgZGlyZWN0b3JpZXMsIHdpdGgNCj4gL21udC9zZGINCj4gwqBiZWluZyBhIG1vdW50IHBvaW50
LiBUaGUgY2xpZW50IGhhcyBtb3VudGVkIHR3byBkaXJlY3RvcmllcywNCj4gdGVzdF9kaXIxIGFu
ZA0KPiDCoHRlc3RfZGlyMi4gV2Ugb2JzZXJ2ZWQgdGhhdCB3aGVuIG1vdW50aW5nIHRlc3RfZGly
MiwgaXQgc2hhcmVzIHRoZQ0KPiDCoHN1cGVyYmxvY2sgb2YgdGVzdF9kaXIxLiANCj4gwqANCj4g
wqBta2ZzLmV4dDQgLUYgL2Rldi9zZGINCj4gwqBtb3VudCAvZGV2L3NkYiAvbW50L3NkYg0KPiDC
oG1rZGlyIC9tbnQvc2RiL3Rlc3RfZGlyMQ0KPiDCoG1rZGlyIC9tbnQvc2RiL3Rlc3RfZGlyMg0K
PiDCoGVjaG8gIi9tbnQvc2RiICoocncsbm9fcm9vdF9zcXVhc2gpIiA+IC9ldGMvZXhwb3J0cw0K
PiDCoGVjaG8gIi9tbnQvc2RiL3Rlc3RfZGlyMSAqKHJ3LG5vX3Jvb3Rfc3F1YXNoKSIgPj4gL2V0
Yy9leHBvcnRzDQo+IMKgZWNobyAiL21udC9zZGIvdGVzdF9kaXIyICoocncsbm9fcm9vdF9zcXVh
c2gpIiA+PiAvZXRjL2V4cG9ydHMNCj4gwqBzeXN0ZW1jdGwgcmVzdGFydCBuZnMtc2VydmVyDQo+
IMKgbW91bnQgLXQgbmZzIC1vIHJ3IDEyNy4wLjAuMTovbW50L3NkYi90ZXN0X2RpcjEgL21udC90
ZXN0X21wMQ0KPiDCoG1vdW50IC10IG5mcyAtbyBybyAxMjcuMC4wLjE6L21udC9zZGIvdGVzdF9k
aXIyIC9tbnQvdGVzdF9tcDINCj4gwqANCj4gwqBBY2NvcmRpbmcgdG8gdGhlIGRlc2NyaXB0aW9u
IG9mICJzaGFyZWNhY2hlIC8gbm9zaGFyZWNhY2hlIiwNCj4gc3VwZXJibG9jaw0KPiDCoHNob3Vs
ZCBiZSBzaGFyZWQgd2hlbiBtb3VudGluZyB0aGUgc2FtZSBleHBvcnQ6DQo+IMKgDQo+IMKgc2hh
cmVjYWNoZSAvIG5vc2hhcmVjYWNoZQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERl
dGVybWluZXMgaG93IHRoZSBjbGllbnQncyBkYXRhIGNhY2hlIGFuZCBhdHRyaWJ1dGUNCj4gY2Fj
aGUgYXJlIHNoYXJlZCB3aGVuwqAgbW91bnRpbmfCoCB0aGUNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzYW1lwqAgZXhwb3J0wqAgbW9yZcKgIHRoYW4gb25jZSBjb25jdXJyZW50bHku
wqAgVXNpbmcgdGhlDQo+IHNhbWUgY2FjaGUgcmVkdWNlcyBtZW1vcnkgcmVxdWlyZeKAkA0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbnRzIG9uIHRoZSBjbGllbnQgYW5kIHByZXNl
bnRzIGlkZW50aWNhbCBmaWxlDQo+IGNvbnRlbnRzIHRvIGFwcGxpY2F0aW9uc8KgIHdoZW7CoCB0
aGXCoCBzYW1lDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVtb3RlIGZpbGUgaXMg
YWNjZXNzZWQgdmlhIGRpZmZlcmVudCBtb3VudCBwb2ludHMuDQo+IMKgDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgSWbCoCBuZWl0aGVywqAgb3B0aW9uIGlzIHNwZWNpZmllZCwgb3Ig
aWYgdGhlIHNoYXJlY2FjaGUNCj4gb3B0aW9uIGlzIHNwZWNpZmllZCwgdGhlbiBhIHNpbmdsZQ0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhY2hlIGlzIHVzZWQgZm9yIGFsbCBtb3Vu
dCBwb2ludHMgdGhhdCBhY2Nlc3MgdGhlDQo+IHNhbWUgZXhwb3J0LsKgIElmIHRoZSBub3NoYXJl
Y2FjaGXCoCBvcOKAkA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRpb27CoCBpc8Kg
IHNwZWNpZmllZCzCoCB0aGVuIHRoYXQgbW91bnQgcG9pbnQgZ2V0cyBhDQo+IHVuaXF1ZSBjYWNo
ZS7CoCBOb3RlIHRoYXQgd2hlbiBkYXRhIGFuZA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGF0dHJpYnV0ZSBjYWNoZXMgYXJlIHNoYXJlZCwgdGhlIG1vdW50IG9wdGlvbnMgZnJvbQ0K
PiB0aGUgZmlyc3QgbW91bnQgcG9pbnQgdGFrZSBlZmZlY3QgZm9yDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3Vic2VxdWVudCBjb25jdXJyZW50IG1vdW50cyBvZiB0aGUgc2FtZSBl
eHBvcnQuDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQXMgb2Yga2VybmVs
IDIuNi4xOCwgdGhlIGJlaGF2aW9yIHNwZWNpZmllZCBieQ0KPiBub3NoYXJlY2FjaGUgaXMgbGVn
YWN5wqAgY2FjaGluZ8KgIGJlaGF2aW9yLg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFRoaXPCoCBpcyBjb25zaWRlcmVkIGEgZGF0YSByaXNrIHNpbmNlIG11bHRpcGxlIGNhY2hlZA0K
PiBjb3BpZXMgb2YgdGhlIHNhbWUgZmlsZSBvbiB0aGUgc2FtZQ0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNsaWVudCBjYW4gYmVjb21lIG91dCBvZiBzeW5jIGZvbGxvd2luZyBhIGxv
Y2FsIHVwZGF0ZQ0KPiBvZiBvbmUgb2YgdGhlIGNvcGllcy4NCj4gwqANCj4gwqBJbiB0aGlzIHNj
ZW5hcmlvLCBpcyBpdCBub3JtYWwgZm9yIHRlc3RfZGlyMSBhbmQgdGVzdF9kaXIyIHRvIHNoYXJl
DQo+IHRoZSBzYW1lIHN1cGVyYmxvY2s/DQo+IA0KDQpUaGF0J3MgdGhlIHdob2xlIHBvaW50LCB5
ZXMuIElmIHlvdSB3YW50IHRvIHNoYXJlIGJvdGggdGhlIG5hbWVzcGFjZXMNCmFuZCBpbm9kZXMg
aW4gb3JkZXIgdG8gZGVhbCB3aXRoIHRoaW5ncyBsaWtlIGhhcmQgbGlua3MsIG9yIG1vdW50cyBv
Zg0Kc3VidHJlZXMgb3IgcGFyZW50cywgdGhlbiB5b3UgaGF2ZSB0byBzaGFyZSB0aGUgc2FtZSBz
dXBlciBibG9jay4NCg0KTkZTdjQgd291bGQgYmUgYSByZWFsIGJlYXIgdG8gZGVhbCB3aXRoIGZv
ciBhcHBsaWNhdGlvbnMgaWYgdGhlIE5GUw0KY2xpZW50IGRpZG4ndCBrbm93IGhvdyB0byBzaGFy
ZSBieXRlIHJhbmdlIGxvY2tzLCBkZWxlZ2F0aW9ucyBhbmQvb3INCnBORlMgbGF5b3V0cyBpbiB0
aGVzZSBzaXR1YXRpb25zLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==

