Return-Path: <linux-nfs+bounces-10579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37838A5E7F9
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 00:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B51E18809CF
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338221F0E5B;
	Wed, 12 Mar 2025 23:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="YJ/BCiVv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2132.outbound.protection.outlook.com [40.107.220.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566D1F1515
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820613; cv=fail; b=eGEDSbS7ISpX9HqVodR5rmMeMrXV22UqmupvkObOQa+8fSxSdm0vkSyUX6E4kn0bXdE/N8zFjOTol7EXjl1XhM/i7VcDWVX2NlR49h7cx2WUpqpUgGSPGshC/JEWZr4wkYGa6xseZosFuHN6HuiQH56JIuFEQ8fQPqutJTMMeSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820613; c=relaxed/simple;
	bh=HJ2cFmrywpY8p6OJq8jPuwBGQ402/1E0qCm7q2K7EWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AU2HpA19QjRv5V0ivPo/kirO5cHS0BYtn8SiDGIM7Ftr4c9aI9cRQs9l8R7r/ciTe96wXBRjp3JJE6A7CYdj5SbgXDX4ohUF6PAqhWOq7anrIqqaDoqzfNQMIcM+Dph6QgEdASnanFGXHyQbddDO+m7wAczsohG/27cSNkEdpos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=YJ/BCiVv; arc=fail smtp.client-ip=40.107.220.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTgGzrdlNBviIWvL8rCkZBcf8L9uSVmmRxjEScc5FmgMJi+HJM9Fqygi3XEpuARaVTS6rEq4yOWYPIJiZEZ3xJKzZisMNoYxphKIfATS7ENXW0T0m9n0hFpaWIQD6TJM+ZxtEoPvXX67Xl237pGyJK2Iq8squKehdW+WzkO7EveuYNM+TCFsjEOy4hm2IHVWdpVMcny17IbWvHHVNUlseOyIhvnPeTQFibRYfatS8hkIgGGSaru/7Q8xLhkIOjKF0++wrwmDH5tcc9Ip7mTMnQuKKFfll4/5xcsTmD+NMH8C3tOoNKs5a8YJP5fzLhCHnj8lp+Pp3lZm3DtIqaKk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJ2cFmrywpY8p6OJq8jPuwBGQ402/1E0qCm7q2K7EWY=;
 b=js5eYt8hf1iPZmVq5oon8a0OsDE5fLvLxubmQ1+YvUZbcV4JvHAepXhEI6HINGRwlmQ9QCgkjZ8qEL6WhYvuvCrtG0UBYN6yod1AlZ0LPsrlycdwbR5huPhyirSZinNogO2zDZq1T9wwxf76aFFYxT/y0jIUAqddEiwa/U9c6RAZJdTRPGC4oHn/zNbOtMEKIhoXGx2aGvZQ1xK0gZaziBuGhWRUCDLnAWuus1vE46qwR2jUuDW4FQKzvn+UWvztJndb+nD+t6QXhg35UvB4dj59adM9IYFDUhVAVdtvOKXEb73DF6edALRX1kFrmo/dNJd/lH1F2bdUnZGBOnJRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ2cFmrywpY8p6OJq8jPuwBGQ402/1E0qCm7q2K7EWY=;
 b=YJ/BCiVv1aC36ArDMKfzuGmJ2Al9a8LHugo2fVHnMmXQIftMs15c4Yn2kyoBqb2vD1tTAylD4zDnHd+L3Qa3WoseUUVyBni+Sh81kBTAb6+ROxZgkvgaayOxIybjIKV3AVrsIeBZljZB4wMYRL3sbTcPK7av5NWvNYFp1z+sTUQ=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by MW5PR13MB5994.namprd13.prod.outlook.com (2603:10b6:303:1c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 23:03:28 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:03:28 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "bcodding@redhat.com" <bcodding@redhat.com>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFS: New mount option force_rdirplus
Thread-Topic: [PATCH 1/1] NFS: New mount option force_rdirplus
Thread-Index: AQHbk4d0DIHEOdRfXkyblppsFp2iiLNwGqAAgAACioCAAAGzAA==
Date: Wed, 12 Mar 2025 23:03:28 +0000
Message-ID: <da7442531a2d3be2d8b38312f9f4c6f772c9b96f.camel@hammerspace.com>
References: <cover.1741806879.git.bcodding@redhat.com>
	 <4a471ab1bdea1052f45d894c967d0a6b6e38d4a6.1741806879.git.bcodding@redhat.com>
	 <ef4218cd2eb30558692857d02ea1518e1e06684f.camel@hammerspace.com>
	 <918EAA33-67C3-4E8A-9B20-1A019646713B@redhat.com>
In-Reply-To: <918EAA33-67C3-4E8A-9B20-1A019646713B@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|MW5PR13MB5994:EE_
x-ms-office365-filtering-correlation-id: 7d65c798-2537-4240-9b35-08dd61ba19d5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2JmakZ2YXhxbGdaWWZDV0p0SUFnSzcxeGgwTW5idWN5eHhnSzNTQjA3dzJv?=
 =?utf-8?B?dHI1bTI1K0RlZXNwTnBOVWRxaHVuU0FUVWgyYU5KN2dxMkJCOXE3UHpTeStU?=
 =?utf-8?B?STZ3UlVLRHBRSGJ4dlZ4bWU1V0dtOWxVQ3NzU1Q1M2xBbXUwb1FXZmZMbmk1?=
 =?utf-8?B?aldDYVNVZG5FY2krSnRKMWZkUkt0MENDcU9uNnBtckk1RlBNRzZLdENwR01G?=
 =?utf-8?B?ZUM0WkQrV1NnSHVUNmN3aWhTMmV6d0RjNWdMNDkzWlZGMytMNFVmT2dJS1Bq?=
 =?utf-8?B?a1M1WEpmSTFCMTlydVRJTFNrSUttY2hKd21qODJFQUNzVU5IM1d6eE1WRmUz?=
 =?utf-8?B?ZkUyUzBPV0VVdjY1NnRlbUtDZkZrczZzbFBYUHhPTTk2bGJCTGVOVEQ5c1lv?=
 =?utf-8?B?MUw0Y0ZselBEY1BicjcyRU1xeEdnTkFEcWhHL1FuQ2VhRzNyTk5QdVo2REZz?=
 =?utf-8?B?c1lmQzJobUhHblR4c0twaWFJNWp0WTlaYjdZblVSOS9QMHY2UGdwNmxRd2xj?=
 =?utf-8?B?MDNsYmJVTEU1a2wxMHREd1drNWVrMjQ5YXprT3VoUGtiZnZ1VEc5MmRKZUhw?=
 =?utf-8?B?WGJxVHdIQjdIeFFJUjBCYWZrZDg1YTlQWTk2Q0hGZzdXc3hsbW1oeGRQYktJ?=
 =?utf-8?B?eXFhVVVvekVTODFtT0tGbERZYmdUOVh4QTlZVWlaMWlNMmhTbzRWQzE1WXdy?=
 =?utf-8?B?bWlKVWpXTjdjazdnWEhjK3hZNDFoK0E0RE1QQnYrTWY0VG8zb2p1a3JYeDRk?=
 =?utf-8?B?cUpnSDR0dkFOTlFGaXJtanIvQi9tMGJMdUl5djZrYWFha2NPcWhEb3VncnJV?=
 =?utf-8?B?b2ZWRDkzc1JBMTZyZjZSQWM4enpDa1BxbGFiNlBLakxQR0lIMHFESHZMQ2gy?=
 =?utf-8?B?ZGUxTlBzY09SckFkcnQyVDlZeDY0Wk4xc3hoUmZnZFR4U0FxckhMcjRTSVk0?=
 =?utf-8?B?ZFFrVWEwelI3SWRXUGdHNlZOMis4Mk9vSFN5dEEvVklhSzhUeGJuQ3BMTDYv?=
 =?utf-8?B?U3JJZEM0ckpEdittV2l5dmdwaEN3VmswT3lnTmZjVDJ6R2oxRE50MkRsV3Vm?=
 =?utf-8?B?YWM4WEtrMitXdVhhUmJPai9NdmdweTRSdnBIWTd2dG1HN1dHamFtK2QrN0o5?=
 =?utf-8?B?SkN3Z3BVS3ZUYXJCYzBiRHpaZmlobi9ZVno3VVlGSnU3ZndPSUhsUjkwbi9N?=
 =?utf-8?B?dkg5ZzJCa3NoVmFZKzhIRld1eHJBaU93THd1VmtuMk5Keng2eFdYdlFzVXp1?=
 =?utf-8?B?blZtUmRhcFBPQVVUQnVYcmVhUmozSGVBWUQ1azdhOWpMNmN4MFRIVTlFaGpo?=
 =?utf-8?B?d1hTeWZxcVZyeThpT2hYeFUrWk82OSthczI0OVFZTjlIaFJLa3pESGp0SFVt?=
 =?utf-8?B?T0NraTQ0N1dVSEk2YkRzcjZoQmxQYmhlQ1FLSjdzT2c5bzZ1Y1U4S0x5UWYr?=
 =?utf-8?B?MTZKSEpoZnRiNmhMdTh1MGMxMFZ6M3BJSitJUURwcnRhNy91b012VW05cDhn?=
 =?utf-8?B?aE5xSWgrdWxjZDVlajgwMmxmK0JCYkF2dHlyMVlqcVY2Qy9tTFlBcjYrbjlE?=
 =?utf-8?B?aDd6YnFJWG5mZjg2Um5NOW9lek1iQysxMkhjTVdORlNlQTZvcWxnbzBuQkFC?=
 =?utf-8?B?WXVsZEN2NEhIc2dUZUZaTlN2WHF3OTFRdVpSR2JGekJmbXZMWmtpSVIzbmNz?=
 =?utf-8?B?MVBTcXZyUzhNWnp1RU9RT3hLZ3Z1dVhCY3h0V21XSE1BbW90UEh3S0paN2lQ?=
 =?utf-8?B?NFY2OW4wUDlqWXdtMnJ1MmJkSVNHbURVc2I0UFhubHlxSUxHbGxnSkZRaUNK?=
 =?utf-8?B?QjFZOHg1QlA3NTVQWmZRYXowSGVFSExpVUxSTnJMWnpJRW5ZaW9zV0ZCdkE2?=
 =?utf-8?B?cjQrajZYYmdBMXgwZjFBOWNyTkQ1TE9oa1ZTRVFGS0E2SDB4ZVRweDFuOFZj?=
 =?utf-8?Q?drykhnp4N1atzBpSUdRWnPWZQSYRdXjN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFN3Q0RaUGZCWDVkeVdYS0VtZEpPMmpYclVQTUV5RUxLaG1qd3lGTkNwMlNS?=
 =?utf-8?B?V3NoS2VBUG56TTVrREQ5czNiT0k5Nm1pSld0cWVNeCt6NllTWVp6c0dGa25X?=
 =?utf-8?B?a3ZLTEtEY1dLOC9ldTRxcm82bFZHR2FFVFdEME0yNzdWTTZncTUyTDNUUjJW?=
 =?utf-8?B?eFhLSWpFMXhsQkNtS1lMc0ZNUzBSR054UzV3NlliUmFuT1F5WTllZ3dNMVNl?=
 =?utf-8?B?ZTF3NXphMWxCSHVSTVovZFd2UmRoR3BuTnZSL20yeG4wUFNzY1k1RHp2RytJ?=
 =?utf-8?B?K1RoSFo2T2VwSndXaFNsWWZtTVNqSjM2c09pREtVc1E0VFVFaWdyUFFpVTA2?=
 =?utf-8?B?MUpNQVViQmdOa25BYUJ2MzdsUmdOYWRjakd1K1B2L1BLbTEya0xCVDFhczB5?=
 =?utf-8?B?NC9aVUxBaXVub2QzNmgzZ0lYamZiS3NiNVEvWldDYlpaRUZOZ3ZoMnF4b2JP?=
 =?utf-8?B?TTVoY2ZGY0tsVDBwdi81d1Z5ZGhPYVEyMHkralhTZjdqSDliczBOT29mNCtS?=
 =?utf-8?B?aHV5dEtpTFF3RS9lOWNidDJDK2NqUDYyK0I1VW81K29ndHpiZERsZEJKQlpR?=
 =?utf-8?B?R1hUcEtwT09uVVBDbFRuSnFRTmViUFJEM01zcEt5aXExVzV4dlE2UEFUbzcz?=
 =?utf-8?B?K096ckQ1MHpVMS9COVNUKytvNnFZaTFPb0dWQXZLUERaa01uUTRTeTJOVTk4?=
 =?utf-8?B?ZEIrM2lPRFkzK0h2UllBTUV5amE1bUhCNXVQa3pNVWxTOVhwVkpBeWpYclpR?=
 =?utf-8?B?UEtidHZUQ0lNam1sa1d5dER4Z2xmS05oUTYwU1NZNDNYVlpFbjBMeG1Wb3l5?=
 =?utf-8?B?MUVvV0lBeGYzQ1lYTkhMaEZ3WDFxb21HNnFqc2VBampYWGhnZjNnandQOFRN?=
 =?utf-8?B?V1JvWjFuL3JFekFhL2ZmZGtldHFCc0ZwY3BMZXlKWVZ5MHZ1Ums1elZnV3lO?=
 =?utf-8?B?bkVmVVNvZUJnVTIwZUExNnlpYUFKY21CcmNKT3c3Nk9OYTI5ZmZTOFpYS0hG?=
 =?utf-8?B?Z1hVeFJ6L3paQWZrYzNwVVB0QWUzaU5rYmxqa2l2bFd3Q0NRSi9SYnVUb0Q3?=
 =?utf-8?B?Wmtvb3RUV3BVdW9lQjh3Y0J1RXdjdTJNeWFINVRTMklqcGxYN1JnOXRYSXpu?=
 =?utf-8?B?RjBQVjFtZi9rS2w3b2tCc0hUb2pEL0VLYW9zcFRpNDQwdzRteThlVlE1L0Ju?=
 =?utf-8?B?b3M3U2NuMGVoTlZ1a2hQRnRnODRtenYwQ1pPbUJvWGd5ZHJYY0dqU2hUQjhv?=
 =?utf-8?B?S1I4dGJkSmRXNDVCdTlxVHVvZC9xZ0ZPRmFock1xWTRQbHhLR0NQRlpNcnRP?=
 =?utf-8?B?R3BPUzNJM01oMXF4ZDRuM21NYkYwOW9LUFJvVUVVczVGSFo4ZnlpREhBS01l?=
 =?utf-8?B?NHE5b3Q3QmlBZHZsOTR3SXBWTENVVzRnaDYrTWNpdzNlNEoyaWM1MjM0T0RY?=
 =?utf-8?B?d2txcnNaSTlMempIM1BDRzB2dFVQYnU0NzFJNUtjajRYSDdCc0dWcHcya3JU?=
 =?utf-8?B?aHJBeWYxMGR1czNVNEVrWXUxWjd5OFBLUjVCUENCQWtZeWpaamN0TWNDR2J2?=
 =?utf-8?B?YURVeHZJV0hUS1l6SnJLMVZyQU5PdWlBdC9lUkEvNTFRMk43NjhvSmwvWDA1?=
 =?utf-8?B?dXJCMWV2MW1ic1gwWWhIZHZLYlAxSG9sdm5vZzZ6akh3bmlJR3VYRVhMT3dT?=
 =?utf-8?B?VEpGMGpEU0tQV21lRUxzY3o5aGN5L2g5SUNLUnJ6bVdyL09Gcmc0N21QUmJq?=
 =?utf-8?B?SjNNZUU3bEdzSjdBNGVxUi9xVURiMnBlc3ZWT0tPZEh0S0gzUlVZV0FOcXBv?=
 =?utf-8?B?T0JjSHJBN2NzNStOUS9pWFE0K2ZsVjdVUW9OaHNxT3hXWkFwR1NnUW1FTVE4?=
 =?utf-8?B?NGs2Zk1nMG5YWFp1TWZnOVMvdzdqMHhlK1puWUU1RDhuYW1qRFIvTTdBRDlr?=
 =?utf-8?B?Z3BCTi91VG8rNjVLazRoSWxOUTRkbStRWFNqcDhnbU1VLzhIb085dnZVd2pu?=
 =?utf-8?B?bm5mM1NPYVQxYmFPQ2w1UlFFOTVDTmp5azYzT0w4Yll5ejNNT1BzVjJjY0hQ?=
 =?utf-8?B?emVYMVY4ZHhyK1RKN0hZRXVjNUZaODRjU1RQdDFEam5jSE5pd2pLUnhTTEtE?=
 =?utf-8?B?TGZ3N2EyeWNDVm5pWVh3VFprK0RhOHZWdTVuOXBTcUp5Nmk4Yy82S2Uxd0xm?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C0E1A6B24B4D94896D720D65CA9C3EA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR13MB5073.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d65c798-2537-4240-9b35-08dd61ba19d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 23:03:28.1535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5lLh44iY30aqe4A88uuiOldsugpcFbnaBfYIsxLodg8WnXqSbNAz4WsnBMIVGIx6o2V1geKwupXBg2DsMK2Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5994

T24gV2VkLCAyMDI1LTAzLTEyIGF0IDE4OjU3IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxMiBNYXIgMjAyNSwgYXQgMTg6NDgsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gV2VkLCAyMDI1LTAzLTEyIGF0IDE1OjQ2IC0wNDAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gVGhlcmUgYXJlIGNlcnRhaW4gdXNlcnMgdGhhdCB3aXNoIHRv
IGZvcmNlIHRoZSBORlMgY2xpZW50IHRvDQo+ID4gPiBjaG9vc2UNCj4gPiA+IFJFQURESVJQTFVT
IG92ZXIgUkVBRERJUiBmb3IgYSBwYXJ0aWN1bGFyIG1vdW50LsKgIEFkZCBhIG5ldw0KPiA+ID4g
a2VybmVsDQo+ID4gPiBtb3VudA0KPiA+ID4gb3B0aW9uICJmb3JjZV9yZGlycGx1cyIgdG8gY2Fy
cnkgdGhhdCBpbnRlbnQuDQo+ID4gDQo+ID4gQ291bGQgd2UgcGVyaGFwcyBjb252ZXJ0IHJkaXJw
bHVzIHRvIGJlIGEgc3RyaW5nIHdpdGggYW4gb3B0aW9uYWwNCj4gPiBwYXlsb2FkPyBEb2VzIHRo
ZSAiZnNfcGFyYW1fY2FuX2JlX2VtcHR5IiBmbGFnIGFsbG93IHlvdSB0byBjb252ZXJ0DQo+ID4g
cmRpcnBsdXMgaW50byBzb21ldGhpbmcgdGhhdCBjYW4gYmVoYXZlIGFzIGN1cnJlbnRseSBpZiB5
b3UganVzdA0KPiA+IHNwZWNpZnkgJy1vcmRpcnBsdXMnLCBidXQgdGhhdCB3b3VsZCBhbGxvdyB5
b3UgdG8gc3BlY2lmeSAnLQ0KPiA+IG9yZGlycGx1cz1mb3JjZScgaWYgeW91IHdhbnRlZCB0byBh
bHdheXMgdXNlIHJlYWRkaXJwbHVzPw0KPiANCj4gWWVzLCBJIHRoaW5rIHRoYXQncyBwb3NzaWJs
ZS7CoCBJIG9yaWdpbmFsbHkgc3RhcnRlZCBkb3duIHRoYXQgcm91dGUsDQo+IGJ1dA0KPiBhYmFu
ZG9uZWQgaXQgYWZ0ZXIgaXQgYXBwZWFyZWQgdG8gYmUgYSBiaWdnZXIgY29kZSBkaWZmIGJlY2F1
c2UgeW91DQo+IGhhdmUgdG8NCj4gcmUtZGVmaW5lIHRoZSBub3JkaXJwbHVzIG9wdGlvbiB3aGlj
aCB3ZSBnZXQgZm9yIGZyZWUgd2l0aA0KPiBmc3BhcmFtX2ZsYWdfbm8uDQo+IA0KPiBJIGNhbiBz
ZW5kIGEgdjIgdGhhdCB3YXkgaWYgaXQncyBwcmVmZXJyZWQuDQoNClRvIG1lIHRoYXQgc2VlbXMg
dGlkaWVyLCBhbmQgZWFzaWVyIHRvIHJlbWVtYmVyLiBJdCBhbHNvIGFsbG93cyB5b3UgdG8NCmFs
aWFzIG5vcmRpcnBsdXMgYXMgYSAncmRpcnBsdXM9bm9uZScgb3B0aW9uLCBzaG91bGQgdGhhdCBi
ZSBkZXNpcmFibGUuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K

