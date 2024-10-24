Return-Path: <linux-nfs+bounces-7412-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAD49AD9D1
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 04:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4262A1F224A7
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 02:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2145914D428;
	Thu, 24 Oct 2024 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="AqyoJ4TX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2100.outbound.protection.outlook.com [40.107.223.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62D13CFBD;
	Thu, 24 Oct 2024 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736443; cv=fail; b=oq3zZmvvsJVxcIl57TTi6APMXowZ2G4Wmot0NAIcOLIstIQXTcughzyE1lHX6J+6fVu/Sbk0d/cMCTfrtqsdpgzwaZVZD/a6tsyl8s4rPcfrjsMP+zUYudItiD4x6i5Q0ei4b0KAIdsZ38bUTbgj6fiV2F8s0THNE89RNSQtzMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736443; c=relaxed/simple;
	bh=LXBh2tUOl94xrkubzmTlFpi2VU111Ea/Q3HwLSJ9zAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KYtmxDYzBGOy8o6nnk5Q8T1QNq8srQpoPrP8yst/X9hnNCcuXCl2Kj8LfsvL1O94+UbXrFL+Qr1V3CR7nl+5A5WT5YP5VHkll7Y23BJh9br3TSOMnco/mCnPWWt/zWoFPzSbdC705e//19FWsCNmMRCGSPyHq3uBbQ5xFvHUKo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=AqyoJ4TX; arc=fail smtp.client-ip=40.107.223.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePlLzIO3DbQ35eQTSz7K1VUvopFC/NsJit8pveMe+HdJtLp1lZGP4CxJA6YPCl9IdHVhLhIUiDQzvmKJq3kfWIhArGvhOixbaOOhBIcucJPdAw/9VZMhUJgBODwL0p0lsg+f3PnaTqgzC9pkKFz5WHYlx/FbdhGz/4oVPg5jf8BHKv32j6DHG94xBDutBfRp41A+5pXZKsTcd3uDOqu8VoN7ygOCsfQ9Rc9UxZF6xgffIbVEodZJIy9iB0pkbEYlzkgKrOFwD7sKzQvNUzjF0R0p9PR9KYE635YhYjYzX0Cyk6sg3klb5n8j2RTywlqmCPVKQyDvwbjCwTGx4z0/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXBh2tUOl94xrkubzmTlFpi2VU111Ea/Q3HwLSJ9zAw=;
 b=IUHBd22ptSeQYlH6n3KJPm5PJYGEbn4mptWGgDkI8isKJ0yismMfUVr+rUmMVdPjL7CofoBeHm/Gkv5oByGYgkNMheV45BTHobpXF5dJiO3KfZyccyz1Pp1rdBb1MVaMI1wJ4E7Xjg+VZVmvFShzMSdfG8IylxOkAWrGFgwiK7ZBN9LvjCyNMLk0e2x+SFYQtZf49Ka2iWGhYedAWGiVL3K5y/lxJgCm4X/NwILaGI6udXNV/aMpJDL6O8lzik8EatuRtOcIPuMmuSuFtLtaCDEcm50IsY5UeUg+L/DNM3s3bwMejeLKr+DzmfV+EszTgx4K6zH58893svy3F28/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXBh2tUOl94xrkubzmTlFpi2VU111Ea/Q3HwLSJ9zAw=;
 b=AqyoJ4TXa62YZhzhfUnrp+8/cUeo4w1kpYxGMLCLv7Y74envuGTrZFWY35L4U8OhFaznEACyasRdtvQfK/ppuDTcME6ij9+w3rCVfes9wYe1XFCUSuQSCJccWqbEYotyB5HKHTXa9M8d5qMA83LB2tk5ZrGubZG6HnkiuIQ6pAw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV8PR13MB6896.namprd13.prod.outlook.com (2603:10b6:408:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30; Thu, 24 Oct
 2024 02:20:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 02:20:36 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "okorniev@redhat.com"
	<okorniev@redhat.com>, "anna@kernel.org" <anna@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "tom@talpey.com" <tom@talpey.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "liujian56@huawei.com" <liujian56@huawei.com>,
	"neilb@suse.de" <neilb@suse.de>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel tcp
 socket
Thread-Topic: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel
 tcp socket
Thread-Index: AQHbJbtPJ4ryUqLRAUiLTzYVTAhYbA==
Date: Thu, 24 Oct 2024 02:20:35 +0000
Message-ID: <65b652e60d8681b0898efcd6e020f69447b6e606.camel@hammerspace.com>
References: <20241024015543.568476-1-liujian56@huawei.com>
In-Reply-To: <20241024015543.568476-1-liujian56@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV8PR13MB6896:EE_
x-ms-office365-filtering-correlation-id: aa5459da-8084-4683-5bbd-08dcf3d271da
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VnhaRFJ4dE5GU0hsQVV5KzkweEVOU0Z6Q0dpeXIwYmNrbmcrTlZNVElJZWpj?=
 =?utf-8?B?bzlJTnFya2dPNmhOWC9mQ2VrbHBkbVJYNEQ4eWlCdjl6UlhTaHZTM3dtb2tn?=
 =?utf-8?B?R1VUdm40TTgzZkVMdUt5VUpmUitVYW0wbUF3NTh3Z3hRVmZzNmtYVmdBWUk3?=
 =?utf-8?B?S05sL3MyRDVHWHV1MzYwbGFvY0x6LzV3Mm9SbWdKTTdwTXZreitvQmZJSENJ?=
 =?utf-8?B?NmdGZlJsR1dKd3FTclFNWEh2dzRyeTFUajdzLzNuMktKN1hCaXFxdUdqeEl4?=
 =?utf-8?B?VHN6Mi9QTUd4cHJXL1p4MEwxWEZTWjArdUROeEpDb2ZocE9sb1daNzMzbkty?=
 =?utf-8?B?TUs5ZEtkUTQ5R21mZjBlV05CRlFlVGVwN2xGUVFPKy9BSmtEdUNwTWVRdHox?=
 =?utf-8?B?NDI3S01NZExoUlZoM1RGNkVUQk10eFA5T2Q2TmN4TVJkTXBxd05KUGlWRTF3?=
 =?utf-8?B?dnc4K1hNODEvaHNKeWpnQmY3Z25BZ293Mkh3M01YTDQvaUY4MGhkK0NGdUhB?=
 =?utf-8?B?L0ZsTFEwbnhyaFRLYWxjbk0yRWE5a0QxdHJLN0NqTWx4WXF5bVZLeFd2UDJO?=
 =?utf-8?B?K3IyYUJmWmZCVXFvVWFWNmh2elByTVZVNG1SYUlWWXBvdEkzcUM4bTdDVVhI?=
 =?utf-8?B?WS9DVnA5MWMxNEhDMEFmVlJuWlJveGFMM3RxaytMMnFUQlVyOTFBdEJBbGNp?=
 =?utf-8?B?elNqaG1nTVQreW9YdUY3d2czZlpiM1hmc050Z3NBR2pqK0dLOXNmUkRELzk2?=
 =?utf-8?B?S3BJVDJqYW9EQ3oxTC91eU5ZMGJUK2dmY1FhMnhnWERLa21DRVg0Z3U3ZElP?=
 =?utf-8?B?Z3hkVDg3Vm5mWWtqeE5Dd2tCWnZSbnY1K0Jza0YyMFk3R1ZHUG50K282UjNh?=
 =?utf-8?B?dEZRSE1zUmlnN21IOUFyTXgzUFFoRzdQVTRZOVNDOTVRUFlRQUNQUS9EeC93?=
 =?utf-8?B?eU9FcU5PSTVZei9mdXAyRUFuQXF0VkVHR0Z3QXBuWGY4WE9sdXRRUnliOEFj?=
 =?utf-8?B?NStWMnpsRHBZSzdjRFZra0tRUzRzemFWNGpPaGM4UUtpMVR4alo5RWtNdnVK?=
 =?utf-8?B?KzBKbDI1TkVhYkUwVU9oYmVSYUE2OVZ2NjREQXFiQjZHWHA2K0I3eXZQTUNE?=
 =?utf-8?B?UHJFd2YrRlozTm9na0FLd2VlZ09BMUpYejFQQWcxNzcxcTJEL0V6UUtFS012?=
 =?utf-8?B?aWFybHl5WmN3MFBSWE1vWG55ZXhnY2ViL0F3bEx1cHpLVGFCVXJDNE9yQnFU?=
 =?utf-8?B?b0d4U0xzWHM4RnZhamdlUnFkcW9ENW5HbnZUdHJsb2RhUE1yMG92ditKdk55?=
 =?utf-8?B?WGU2d0Iyd2xJYzcwM1BnZ09iSC8xdGpqSkoxRXloVXBKWnBQRklWUklTQWxG?=
 =?utf-8?B?dnFQRnF1MTVBcVVKWDFocXRmVVdVNVY0VnNvRnRLd0JBUWlFT0pJTzVjQlZu?=
 =?utf-8?B?K09LUWUzUm5VSlRUYjN6cEhqdGNSNGs5ZEZJdlBLR2FxanZnSDVNZ3hDTEhB?=
 =?utf-8?B?eVBmMGZVL04vTENCV0o2eExuZUxwcTVvUEFpZFJOUW1iUjgyLytGdlZCZFE2?=
 =?utf-8?B?cGVrcWVvRGR1c0RlelNPOEVtQ1pGeGdVc1VKaHVRVlo0Sm1zY3Y3TlhPaFNY?=
 =?utf-8?B?ZlRuSGxkNFFMdTZReDZoRWRkVER5KzNXRVRjUjFlOXR6Z0NBdkxUZHNrWU9B?=
 =?utf-8?B?c1k0aEhjN0JZanlSZ01LakUyVGRuWDNXRjFHV0FBTFU2dnlGRXk4V3RHVnB5?=
 =?utf-8?B?RllzMmtwc3BKeXdSb0FtM3dITExWZU5BSE5kNzNiLzVTbXhodi8zS01PR1dy?=
 =?utf-8?B?MWRLNmlLVjYyR1BQTUc5NEtNeHBtc0c1R3VPeCtVWDlmanR4SE53ZXZ0UUE2?=
 =?utf-8?Q?bRLdlX/ynViRe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UW9pNEpST0NkSDJmbUhaWWt6citPUEpRbVE1eW1GUGtOcklxWVg0TVhOZEZq?=
 =?utf-8?B?Sjdady9aUnNCdWMyRkhTTk1XWE9tdzVWdTgxVXNhS0J3RnhBVTBMelJhZXp3?=
 =?utf-8?B?VU1vMmpRaVRUaDcxaFVPcTh0d2xzNXQxRGh0eTZtZC9RU1RMRTdaSHdsWGM2?=
 =?utf-8?B?UnVTR0Z4cHU3TXVkMzRTVFBaTmsrRk1wOWVwOU03MzV3Kzl1TTJZS29nbkIz?=
 =?utf-8?B?d1RLMWxGeG15ZmQ1WUtlQ0xxR2FhSHV4NzNhQXlPSGs5SUtMUnFOeG1wNnRs?=
 =?utf-8?B?T2RJbXRYblQrQU9RZjE4cUFzWUJtWHFNSHBZQWFzejZhSHFieHJNWktUcll0?=
 =?utf-8?B?Q09JTm14amRWdG5QQTNhQ1JibVMxVXJCNkRveEd6SWVYUCtXQlpML1l6bjZS?=
 =?utf-8?B?SHZOQkR4bThzckd1TkJPenZ0NEZqaGVoUkV3S3RiVUYwbnhQR2dMN1l2R0hK?=
 =?utf-8?B?eVE5ZjJYaFVRMXdpbVg2TUV6MUNFSWZCTGpJMnR6UkpjMXpLT2crbFlUbkZk?=
 =?utf-8?B?UG9vc2pmaWtiOGdUcHhtVlJJYjg4UXVhS0FOcFpsQUorVHZUZ1NCeGkyZmlm?=
 =?utf-8?B?S2lXNkl3aEhCWnYrUkM4dUJ1VEtqSGtNa0hsUzU3Q0IvQ0hxTFBqT0lyQkZI?=
 =?utf-8?B?QnZaYjYzVzhrWjZCbmEyWWE5Qnd6U1diYjM0NjBSTnh6YkpoSFRsUjVJVFhD?=
 =?utf-8?B?SmNDQ3VBa0VXQ3JSb3Q1NTBONUdqZTdKSnNlZC9tWmZkOVlCWXFwckhpTVRk?=
 =?utf-8?B?cHhTQzh2bDFjYnl2blpObk1qTFZhN2E0V0ovR3pnSk9hMEZtOGJSdHhVL0d0?=
 =?utf-8?B?b3psUjJJby91eXJpOTFXK0FJZHIvNTJKblR0WEhMTXpGLzgvMkNCZ0cxczdi?=
 =?utf-8?B?ZHArbi9xOVpabStsZktlNDk2UVkwNnIxTnJpWXFjOUxtaTZMZlJiT0RFQ2RZ?=
 =?utf-8?B?Q3NFR01BT1QxV3JKK1VqaDBtcTRkL3JhbGs2a3BNQWRXMXlIc2pQYlpBNUd0?=
 =?utf-8?B?MlFTNzBrQkttT1R1d2pWNkN5bmg4U3RlbnFITm51aS9FSlpFM1BzMWd5Qjl6?=
 =?utf-8?B?QWNiWE1aeE1GSWNkRFdwbW9vclJIaWNINjkwWGE2d1EyN0VvVWFld2REUU4w?=
 =?utf-8?B?eVdvZjBZRWpSczVqSDFjcUovcGlXUFRTa0F3NDgvVnVOQ1kvZ2E4RklncXc0?=
 =?utf-8?B?TUdGajlMbDN6emc1SXdSSlFINExSQnl6dmxYVEZHeGlkYVdINHBVRkY1MnJi?=
 =?utf-8?B?UjhWNEcwMldoUkRZQ3JvWjhaSzAvMjU1TGhLK3JtcnY1OWxTbG5zMWQ3SjNu?=
 =?utf-8?B?WWVuMVU4TXU3MWhMUmoxN3FjY1JaVlRHLzA3R1FQS2J5WjQyMDhXN216T3Y2?=
 =?utf-8?B?aGUwNmZnSm53NS9yNi9FS3JuSUh3ZFBrWXFETGpBcGFqdVlrWEhIbFhIN2xz?=
 =?utf-8?B?cnJpU0cwRTZrYkl4aHVtWDJBbHhidktlVkZBcEs1NDFJRytUY1hLYlprczAy?=
 =?utf-8?B?YjBLaGNKRUtWU0tacHZ0MkZrWTViR2pEVWlJVkV6MDY3TXVEWHFBVXd3WWUz?=
 =?utf-8?B?bXhDUE1sSjRqOEZXdWdxclE3OWZ5ZmFrNGFiVWxNQUxXTWw5cXlHeDF0bEdC?=
 =?utf-8?B?UlhUa0VjNDlvMVhqbitoL0YwQ3k5S01iY3J1Q1hqUU5zNkJSWTB1WGNpaXNV?=
 =?utf-8?B?cDNjZ0s0UmRXbThzeFlNQW1xWjBFcHdZTjllVzQzZ1F3aGUweGRGWlJnY1dD?=
 =?utf-8?B?U2l3cjNPaFRhajBscjVqcXNQWmVuZDVZOC9RdUtleENLcDFFNVJvZ1VmVUQ3?=
 =?utf-8?B?cWViZnRtMzlWYVk0NlJBN0lTZjkzS2NpWkp4Z0M5dldZaW1NeGFyN1VlYWRZ?=
 =?utf-8?B?UlJyb3Z4V1BpclJXSXg2aDFseDFYWXpITnpoUXJPYytKLzN1Z0JuUHBvZmNs?=
 =?utf-8?B?Q0R2NHZBQTNRaHV2TTBlYmJLZW16eEk0SzVIYnplS1hlSDc1WmlEUHdGWkNX?=
 =?utf-8?B?ekF3WlQvTEFlM3FGam9XcmdkcWJrOXpMdTVJYVZhOWZtRTdTanRIbW9kbmJL?=
 =?utf-8?B?Nms5eW8rMEtxKzBsVWwzQ2hEVmtBeXhXZFVXb05oNzYxRUttYkhjWitNTVlW?=
 =?utf-8?B?d1lpV0Q1R2owQUwzQjBhbElOWUY5UkMrcUcrZ1hRa2RydlVmRlVmb3hlbjln?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F10993054BDD41469AC6C0A52BAEF765@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5459da-8084-4683-5bbd-08dcf3d271da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 02:20:35.8077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSuyLeVE0hSHzbDfXgBl3bUq+3iQyQSA427KXUNN3c7P54uvj9FVZmOTaTeQ5JGi0F7bnfgFFSh/AdBwm8sVjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6896

T24gVGh1LCAyMDI0LTEwLTI0IGF0IDA5OjU1ICswODAwLCBMaXUgSmlhbiB3cm90ZToNCj4gQlVH
OiBLQVNBTjogc2xhYi11c2UtYWZ0ZXItZnJlZSBpbg0KPiB0Y3Bfd3JpdGVfdGltZXJfaGFuZGxl
cisweDE1Ni8weDNlMA0KPiBSZWFkIG9mIHNpemUgMSBhdCBhZGRyIGZmZmY4ODgxMTFmMzIyY2Qg
YnkgdGFzayBzd2FwcGVyLzAvMA0KPiANCj4gQ1BVOiAwIFVJRDogMCBQSUQ6IDAgQ29tbTogc3dh
cHBlci8wIE5vdCB0YWludGVkIDYuMTIuMC1yYzQtZGlydHkgIzcNCj4gSGFyZHdhcmUgbmFtZTog
UUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNS4wLTENCj4g
Q2FsbCBUcmFjZToNCj4gwqA8SVJRPg0KPiDCoGR1bXBfc3RhY2tfbHZsKzB4NjgvMHhhMA0KPiDC
oHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24uY29uc3Rwcm9wLjArMHgyYy8weDNkMA0KPiDCoHBy
aW50X3JlcG9ydCsweGI0LzB4MjcwDQo+IMKga2FzYW5fcmVwb3J0KzB4YmQvMHhmMA0KPiDCoHRj
cF93cml0ZV90aW1lcl9oYW5kbGVyKzB4MTU2LzB4M2UwDQo+IMKgdGNwX3dyaXRlX3RpbWVyKzB4
NjYvMHgxNzANCj4gwqBjYWxsX3RpbWVyX2ZuKzB4ZmIvMHgxZDANCj4gwqBfX3J1bl90aW1lcnMr
MHgzZjgvMHg0ODANCj4gwqBydW5fdGltZXJfc29mdGlycSsweDliLzB4MTAwDQo+IMKgaGFuZGxl
X3NvZnRpcnFzKzB4MTUzLzB4MzkwDQo+IMKgX19pcnFfZXhpdF9yY3UrMHgxMDMvMHgxMjANCj4g
wqBpcnFfZXhpdF9yY3UrMHhlLzB4MjANCj4gwqBzeXN2ZWNfYXBpY190aW1lcl9pbnRlcnJ1cHQr
MHg3Ni8weDkwDQo+IMKgPC9JUlE+DQo+IMKgPFRBU0s+DQo+IMKgYXNtX3N5c3ZlY19hcGljX3Rp
bWVyX2ludGVycnVwdCsweDFhLzB4MjANCj4gUklQOiAwMDEwOmRlZmF1bHRfaWRsZSsweGYvMHgy
MA0KPiBDb2RlOiA0YyAwMSBjNyA0YyAyOSBjMiBlOSA3MiBmZiBmZiBmZiA5MCA5MCA5MCA5MCA5
MCA5MCA5MCA5MCA5MCA5MA0KPiA5MCA5MA0KPiDCoDkwIDkwIDkwIDkwIGYzIDBmIDFlIGZhIDY2
IDkwIDBmIDAwIDJkIDMzIGY4IDI1IDAwIGZiIGY0IDxmYT4gYzMgY2MNCj4gY2MgY2MNCj4gwqBj
YyA2NiA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCA5MCA5MCA5MCA5MCA5MA0KPiBSU1A6
IDAwMTg6ZmZmZmZmZmZhMjAwN2UyOCBFRkxBR1M6IDAwMDAwMjQyDQo+IFJBWDogMDAwMDAwMDAw
MDBmM2IzMSBSQlg6IDFmZmZmZmZmZjQ0MDBmYzcgUkNYOiBmZmZmZmZmZmEwOWMzMTk2DQo+IFJE
WDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiBmZmZmZmZmZjlm
MDA1OTBmDQo+IFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5
OiBmZmZmZWQxMDIzNjA4MzVkDQo+IFIxMDogZmZmZjg4ODExYjA0MWFlYiBSMTE6IDAwMDAwMDAw
MDAwMDAwMDEgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFIxMzogZmZmZmZmZmZhMjAyZDdjMCBS
MTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAwMDE0N2QwDQo+IMKgZGVmYXVsdF9p
ZGxlX2NhbGwrMHg2Yi8weGEwDQo+IMKgY3B1aWRsZV9pZGxlX2NhbGwrMHgxYWYvMHgxZjANCj4g
wqBkb19pZGxlKzB4YmMvMHgxMzANCj4gwqBjcHVfc3RhcnR1cF9lbnRyeSsweDMzLzB4NDANCj4g
wqByZXN0X2luaXQrMHgxMWYvMHgyMTANCj4gwqBzdGFydF9rZXJuZWwrMHgzOWEvMHg0MjANCj4g
wqB4ODZfNjRfc3RhcnRfcmVzZXJ2YXRpb25zKzB4MTgvMHgzMA0KPiDCoHg4Nl82NF9zdGFydF9r
ZXJuZWwrMHg5Ny8weGEwDQo+IMKgY29tbW9uX3N0YXJ0dXBfNjQrMHgxM2UvMHgxNDENCj4gwqA8
L1RBU0s+DQo+IA0KPiBBbGxvY2F0ZWQgYnkgdGFzayA1OTU6DQo+IMKga2FzYW5fc2F2ZV9zdGFj
aysweDI0LzB4NTANCj4gwqBrYXNhbl9zYXZlX3RyYWNrKzB4MTQvMHgzMA0KPiDCoF9fa2FzYW5f
c2xhYl9hbGxvYysweDg3LzB4OTANCj4gwqBrbWVtX2NhY2hlX2FsbG9jX25vcHJvZisweDEyYi8w
eDNmMA0KPiDCoGNvcHlfbmV0X25zKzB4OTQvMHgzODANCj4gwqBjcmVhdGVfbmV3X25hbWVzcGFj
ZXMrMHgyNGMvMHg1MDANCj4gwqB1bnNoYXJlX25zcHJveHlfbmFtZXNwYWNlcysweDc1LzB4ZjAN
Cj4gwqBrc3lzX3Vuc2hhcmUrMHgyNGUvMHg0ZjANCj4gwqBfX3g2NF9zeXNfdW5zaGFyZSsweDFm
LzB4MzANCj4gwqBkb19zeXNjYWxsXzY0KzB4NzAvMHgxODANCj4gwqBlbnRyeV9TWVNDQUxMXzY0
X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQo+IA0KPiBGcmVlZCBieSB0YXNrIDEwMDoNCj4gwqBr
YXNhbl9zYXZlX3N0YWNrKzB4MjQvMHg1MA0KPiDCoGthc2FuX3NhdmVfdHJhY2srMHgxNC8weDMw
DQo+IMKga2FzYW5fc2F2ZV9mcmVlX2luZm8rMHgzYi8weDYwDQo+IMKgX19rYXNhbl9zbGFiX2Zy
ZWUrMHg1NC8weDcwDQo+IMKga21lbV9jYWNoZV9mcmVlKzB4MTU2LzB4NWQwDQo+IMKgY2xlYW51
cF9uZXQrMHg1ZDMvMHg2NzANCj4gwqBwcm9jZXNzX29uZV93b3JrKzB4Nzc2LzB4YTkwDQo+IMKg
d29ya2VyX3RocmVhZCsweDJlMi8weDU2MA0KPiDCoGt0aHJlYWQrMHgxYTgvMHgxZjANCj4gwqBy
ZXRfZnJvbV9mb3JrKzB4MzQvMHg2MA0KPiDCoHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0K
PiANCj4gUmVwcm9kdWN0aW9uIHNjcmlwdDoNCj4gDQo+IG1rZGlyIC1wIC9tbnQvbmZzc2hhcmUN
Cj4gbWtkaXIgLXAgL21udC9uZnMvbmV0bnNfMQ0KPiBta2ZzLmV4dDQgL2Rldi9zZGINCj4gbW91
bnQgL2Rldi9zZGIgL21udC9uZnNzaGFyZQ0KPiBzeXN0ZW1jdGwgcmVzdGFydCBuZnMtc2VydmVy
DQo+IGNobW9kIDc3NyAvbW50L25mc3NoYXJlDQo+IGV4cG9ydGZzIC1pIC1vIHJ3LG5vX3Jvb3Rf
c3F1YXNoICo6L21udC9uZnNzaGFyZQ0KPiANCj4gaXAgbmV0bnMgYWRkIG5ldG5zXzENCj4gaXAg
bGluayBhZGQgbmFtZSB2ZXRoXzFfcGVlciB0eXBlIHZldGggcGVlciB2ZXRoXzENCj4gaWZjb25m
aWcgdmV0aF8xX3BlZXIgMTEuMTEuMC4yNTQgdXANCj4gaXAgbGluayBzZXQgdmV0aF8xIG5ldG5z
IG5ldG5zXzENCj4gaXAgbmV0bnMgZXhlYyBuZXRuc18xIGlmY29uZmlnIHZldGhfMSAxMS4xMS4w
LjENCj4gDQo+IGlwIG5ldG5zIGV4ZWMgbmV0bnNfMSAvcm9vdC9pcHRhYmxlcyAtQSBPVVRQVVQg
LWQgMTEuMTEuMC4yNTQgLXAgdGNwDQo+IFwNCj4gCS0tdGNwLWZsYWdzIEZJTiBGSU7CoCAtaiBE
Uk9QDQo+IA0KPiAobm90ZTogSW4gbXkgZW52aXJvbm1lbnQsIGEgREVTVFJPWV9DTElFTlRJRCBv
cGVyYXRpb24gaXMgYWx3YXlzIHNlbnQNCj4gwqBpbW1lZGlhdGVseSwgYnJlYWtpbmcgdGhlIG5m
cyB0Y3AgY29ubmVjdGlvbi4pDQo+IGlwIG5ldG5zIGV4ZWMgbmV0bnNfMSB0aW1lb3V0IC1zIDkg
MzAwIG1vdW50IC10IG5mcyAtbw0KPiBwcm90bz10Y3AsdmVycz00LjEgXA0KPiAJMTEuMTEuMC4y
NTQ6L21udC9uZnNzaGFyZSAvbW50L25mcy9uZXRuc18xDQo+IA0KPiBpcCBuZXRucyBkZWwgbmV0
bnNfMQ0KPiANCj4gVGhlIHJlYXNvbiBoZXJlIGlzIHRoYXQgdGhlIHRjcCBzb2NrZXQgaW4gbmV0
bnNfMSAobmZzIHNpZGUpIGhhcyBiZWVuDQo+IHNodXRkb3duIGFuZCBjbG9zZWQgKGRvbmUgaW4g
eHNfZGVzdHJveSksIGJ1dCB0aGUgRklOIG1lc3NhZ2UgKHdpdGgNCj4gYWNrKQ0KPiBpcyBkaXNj
YXJkZWQsIGFuZCB0aGUgbmZzZCBzaWRlIGtlZXBzIHNlbmRpbmcgcmV0cmFuc21pc3Npb24NCj4g
bWVzc2FnZXMuDQo+IEFzIGEgcmVzdWx0LCB3aGVuIHRoZSB0Y3Agc29jayBpbiBuZXRuc18xIHBy
b2Nlc3NlcyB0aGUgcmVjZWl2ZWQNCj4gbWVzc2FnZSwNCj4gaXQgc2VuZHMgdGhlIG1lc3NhZ2Ug
KEZJTiBtZXNzYWdlKSBpbiB0aGUgc2VuZGluZyBxdWV1ZSwgYW5kIHRoZSB0Y3ANCj4gdGltZXIN
Cj4gaXMgcmUtZXN0YWJsaXNoZWQuIFdoZW4gdGhlIG5ldHdvcmsgbmFtZXNwYWNlIGlzIGRlbGV0
ZWQsIHRoZSBuZXQNCj4gc3RydWN0dXJlDQo+IGFjY2Vzc2VkIGJ5IHRjcCdzIHRpbWVyIGhhbmRs
ZXIgZnVuY3Rpb24gY2F1c2VzIHByb2JsZW1zLg0KPiANCj4gVGhlIG1vZGlmaWNhdGlvbiBoZXJl
IGFib3J0cyB0aGUgVENQIGNvbm5lY3Rpb24gZGlyZWN0bHkgaW4NCj4geHNfZGVzdHJveSgpLg0K
PiANCj4gRml4ZXM6IDI2YWJlMTQzNzlmOCAoIm5ldDogTW9kaWZ5IHNrX2FsbG9jIHRvIG5vdCBy
ZWZlcmVuY2UgY291bnQgdGhlDQo+IG5ldG5zIG9mIGtlcm5lbCBzb2NrZXRzLiIpDQo+IFNpZ25l
ZC1vZmYtYnk6IExpdSBKaWFuIDxsaXVqaWFuNTZAaHVhd2VpLmNvbT4NCj4gLS0tDQo+IMKgbmV0
L3N1bnJwYy94cHJ0c29jay5jIHwgMyArKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0c29jay5jIGIvbmV0L3N1
bnJwYy94cHJ0c29jay5jDQo+IGluZGV4IDBlMTY5MTMxNmY0Mi4uOTFlZTM0ODQxNTVhIDEwMDY0
NA0KPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4gKysrIGIvbmV0L3N1bnJwYy94cHJ0
c29jay5jDQo+IEBAIC0xMjg3LDYgKzEyODcsOSBAQCBzdGF0aWMgdm9pZCB4c19yZXNldF90cmFu
c3BvcnQoc3RydWN0IHNvY2tfeHBydA0KPiAqdHJhbnNwb3J0KQ0KPiDCoAlyZWxlYXNlX3NvY2so
c2spOw0KPiDCoAltdXRleF91bmxvY2soJnRyYW5zcG9ydC0+cmVjdl9tdXRleCk7DQo+IMKgDQo+
ICsJaWYgKHNrLT5za19wcm90ID09ICZ0Y3BfcHJvdCkNCj4gKwkJdGNwX2Fib3J0KHNrLCBFQ09O
TkFCT1JURUQpOw0KDQpXZSd2ZSBhbHJlYWR5IGNhbGxlZCBrZXJuZWxfc29ja19zaHV0ZG93bihz
b2NrLCBTSFVUX1JEV1IpLCBhbmQgd2UncmUNCmFib3V0IHRvIGNsb3NlIHRoZSBzb2NrZXQuIFdo
eSBvbiBlYXJ0aCBzaG91bGQgd2UgbmVlZCBhIGhhY2sgbGlrZSB0aGUNCmFib3ZlIGluIG9yZGVy
IHRvIGFib3J0IHRoZSBjb25uZWN0aW9uIGF0IHRoaXMgcG9pbnQ/DQoNClRoaXMgd291bGQgYXBw
ZWFyIHRvIGJlIGEgbmV0d29ya2luZyBsYXllciBidWcsIGFuZCBub3QgYW4gUlBDIGxldmVsDQpw
cm9ibGVtLg0KDQo+ICsNCj4gwqAJdHJhY2VfcnBjX3NvY2tldF9jbG9zZSh4cHJ0LCBzb2NrKTsN
Cj4gwqAJX19mcHV0X3N5bmMoZmlscCk7DQo+IMKgDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K

