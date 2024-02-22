Return-Path: <linux-nfs+bounces-2049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E285FC26
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 16:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03B81F22674
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC90134CDC;
	Thu, 22 Feb 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Y8eeQb//"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2102.outbound.protection.outlook.com [40.107.237.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138FB1474AC;
	Thu, 22 Feb 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615216; cv=fail; b=I8BjaNZY5pwz1s0jBuR8Gb2d+PS0hBvyYUkQD0te2V+1SslAApz21IakOyBs2+aEZlS7Tm+M5vv/j3IDqWKwTAN716bsNSEk9/dZCHJv7IqpP2bGHxoFJIZtVu8iKWJ1zj1e7vT3BLWpPGi71En95/pzl+MsQ1TJ/RQDqBaKpFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615216; c=relaxed/simple;
	bh=2JiwPU5lMEC4g6FVBtQQZwC/yDCpGHFsM8xwX1sYdxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XVbZfrBZZ4qMqw3ZmD3iFZYL4j+fU3WvwOThIde2ZzsraEVSqcz8JqSpOpKRIa5PiYlYlg9wPepqHX90QZCovPlczJCeh83mWRGVOL6lH7Dd4+0SPtEjpl6UzWiZt/QOY+sTpjnMO/NeWEJZYjaaKz0nrSW0P9pFHn4n1q8Pj0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Y8eeQb//; arc=fail smtp.client-ip=40.107.237.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFsD7bWOhaB/4LP7aksSdRlsZLy0p3KmrwXqXWdrwCxMuUgfzHMRl1LLqmqHI76AMNdmKlrzAaBJy4UejclFo+j3V1K+el1ghbCHTlVcCf4wfZhc39aBRAVVyV1dlP1clNRBivHk631YVlhyTXFj5XzdUkOwGOyfD97YLplMCUFp/UNrmMOjHcCve6PPq+RlarxsvZ3SjsCqkBbFYH2ChUDOZDK/Tjb7EaXezgDZmOIfESIJoMqr7G3Ixzi6fuAHA7U7WPCS1FdTM3C58xJpeNL7mdm0lXOu7HFyLU2njvlSBJTD3XuyWKRZR9NpQkbGeUEIIqwzDYdcFPwi0ThmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JiwPU5lMEC4g6FVBtQQZwC/yDCpGHFsM8xwX1sYdxY=;
 b=aKn07JQ1bVGxtubOLkIFh6u2GMs11LdCr5uwwoHzkPpXOLN7OrzfT9x5Qsdp6iEoXnfD/+HbOE52gPcBg+vZDsYWhwBnt3tSgdcIF8FUmGUuK0e3tYtHqWN/DB9aSHutecJQ/jCmvQA057LEM26xWnoPTbsHSM6ZgJnAvHUegfvDbQCnJIoeFjFzeuiWFw3XAWMVteE3ptcIYauezIXm1VCh2rBBuATIA90r9xPPvonS9APBk2uErnPq/gEGaXa/+ttThx5PuhIcJy9sPIAYtnPtw0xaNiN+lmXiDu8+Yt5GXa6dYWXu2zhfZVSRw5xTH0mlxwgzFevjLyffnGs1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JiwPU5lMEC4g6FVBtQQZwC/yDCpGHFsM8xwX1sYdxY=;
 b=Y8eeQb//p3sLI4nCuB5/3snIMAb7iGxL8QkWAIbLiWmQigCrTe0EVWjeCDtb6gTBS2+Yk0m01TMXPz2geXpfGncFEcShR5O66TD5SsdFb3WBAwa0F+LImGEhCkz2v2ycuhvzzerD+AMfsGNchQVhO5M+HAtX2cIelR7WryS/K/I=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4672.namprd13.prod.outlook.com (2603:10b6:5:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 15:20:10 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 15:20:10 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, "zhitao.li@smartx.com"
	<zhitao.li@smartx.com>, "kolga@netapp.com" <kolga@netapp.com>,
	"anna@kernel.org" <anna@kernel.org>, "tom@talpey.com" <tom@talpey.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>
CC: "huangping@smartx.com" <huangping@smartx.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
Thread-Topic: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
Thread-Index: AQHaZJ7Q0fUwEoXw10Oowo706qnhILEU0AGAgAFkuACAAEdGAA==
Date: Thu, 22 Feb 2024 15:20:09 +0000
Message-ID: <16d8c8e88490ee92750b26f2c438e1329dea0061.camel@hammerspace.com>
References:
 <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
	 <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>
	 <1179779e2f74e3e5cb2be30cf89e6362aaab706d.camel@kernel.org>
In-Reply-To: <1179779e2f74e3e5cb2be30cf89e6362aaab706d.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS7PR13MB4672:EE_
x-ms-office365-filtering-correlation-id: 1634e068-6f03-43ad-b5b4-08dc33b9c229
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Pb8YN7CxgKOBgtYoLIy4bCXXj5JdQXqgStTLoejOKWYh1GvUeCIcgNZ+SMcbPcCKHHc4LcoV2EPvbgcuPOeIQuFI1qQRjFoFcmD4Vk5Z2UGJ0NInRfSh9C9z0aJOot9eIvvDZkprkN/Lozilllzyukb2cBc4fO/ftGbdsI5LpSVG9XoCVwzdcgxkV5szG4ZRF5Su7YbZtYW13DmdwAEXJyVuOB+SRT7LFXJFYH9O2OHen5JihT4JIuv//3ne/EA57hC3CTaBVuKXTmbZQAB2ALIFipoHGuE/wG1kj6Nk5Tsa8dXgZIBMz+4DUIzW/H4vLONApbxSM8g/kM6EsSPR7zC1V61JpNOP8/MTPD9D0rBkZLhG0KCd5R5lGcu1bpeEungGoqwYWK0tF8KTVqFY27qVParlc2pjQc6ii0J0pQer/KO+h9ZofcO8OnNx2TzuyROq6cZlSLqtbEF1OQmgOuXWAC4ggSNVR5q3g0zkmUXWrG0mG/LUtLHBslNQNBXdJBhVxbRELKumXaUkWovb9dMZp96JWBtBTS3gPsTMzbnKaAJ4+4oIo3/9bSbrNCbSdcOSyi/vV7byBQURrNZnGEKxBpn14iUsEfHiQJj74zLhZJyRTenOLW7g9XHi8sNI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230473577357003)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWxyOEVaQ1pYQWNUTHVJc0hhakVqNjFZbjcxc0ZiQ0xHcTdNQzZOZGhiL1N3?=
 =?utf-8?B?K1RsZERYY0RFWXg0enpMeWExUmtMbHh1S01HeVhsQnoyUjFJY2hoblZQYllj?=
 =?utf-8?B?cnRxUkt5Y08yN3UrVGFVNG53bFhML3ljMHYzNEFoMG8wOTZkZmpWSUhiVGRI?=
 =?utf-8?B?MlZmL3VGdElWc1BKMWpqRmNkYnUvK2xsQ3NJajRUNlV0UFU3REFZdEdCbHJ1?=
 =?utf-8?B?dmsvQUNWM2gwak84MUI0L09HZVFpZm5UbHppZXBHUjVXVENzV01DazhrcDRt?=
 =?utf-8?B?TDNrRFpYSDYyZ3pnellOTDVXc0NBSGdaZlpkZ2puTkU3aE9XRTdZd0h4OW50?=
 =?utf-8?B?NXJkOXBFQzhTNmcyczFOY0JpOEptL3RqMFJrOEF2SjV1M1Nob3lTaGhYK3la?=
 =?utf-8?B?Vi80VGJVS3hZTi9GWHdQYUpqWWQzY3RYRUMyRlpNVEVHMXU1MGREWDlOdmU4?=
 =?utf-8?B?Z0JuRnVwRER3N0NEQU4rRU5RYzNzWllWaWpxUWtjYkJwVXpXMnh5cC8yYzdH?=
 =?utf-8?B?RnlqeW9hNGtqZ3phNmpBalZoK0dOcmRRK2NBNXB6Znk3Tk9pRTFGUXQzbWow?=
 =?utf-8?B?MDVPVVZWUzFISlJWYVdHRzloeDl0em53ZGl5clUxZG5iV1pNWnpzRmh4cDVU?=
 =?utf-8?B?R1oyczhvbjBTTFNMWVRxdk1pSU9sTHc1ZGhrYnZtN1RXZk1TNStzYjJpWjFo?=
 =?utf-8?B?ekdJTCtPYWRYRm0xUW5GOXRJMlU3d3l3ejErTnd0MjRxQTBsZ3lFSXAxK3lP?=
 =?utf-8?B?ZUEyVGJCdHpXbTh2b3FKSW4vZi9qSDZWUjZYYVAzR2VZbUFQRXA2Ym4wMjJD?=
 =?utf-8?B?UlpZa2dVNE9PcUc5RTRJZVBtM3ZzL1RkSTV1MmJPZnR1bjF0a283emRqVFI5?=
 =?utf-8?B?YVY3NXRVQy8wRnh3ZmxyM2IvS0JpUytmS3RCejNzcFY4NkhxYktLYW1tWmFh?=
 =?utf-8?B?amdWb1psa09Kei9xVlEvYjEzcGNTaVZvR3hoOXRLRHlzWW1XNEJGMEluR2RH?=
 =?utf-8?B?RDNCUFZEWFhOOXdvU3dqVFNNSldOWkx6bjM5SU50VldaWW9NelRyMTVVdUd4?=
 =?utf-8?B?b09Qb1JIM2ttRjhQL05POHRIZGhmQU92eHN6T3FSRG40c05hT1pxQWZMWmR3?=
 =?utf-8?B?UGlpRXFKRmJVRFp3QWQ0NmhVNzRpY3RvTTdmWC9SVDhyNVFPZ3l6ZmwxdzRU?=
 =?utf-8?B?VjQzNkpDdnA3MFhQUzN4QUJlOHZVYXNnV0Z2dEJNdytuR1c4UjBYTXEyb04v?=
 =?utf-8?B?Mk5FYmxtUW1VNEM5cnVhUG0yWmRLQWFCQlJ5QjVuaDlsTGVIOHZpbmVaMXZZ?=
 =?utf-8?B?V1JEOFJzcVMwekVlbjRnYjBsZFRyRkRST3JINHNETHJ2bDlkbXZ2UUc0bHFK?=
 =?utf-8?B?c0hzNUJaWHVIZ0Z6NXgvMDE2WG1tKzdwUUVURXdlVkx5dk9qa1E0MWYxL0lD?=
 =?utf-8?B?U3hSRlI5ZWxpaDJNSWk0OWtkUThiTlk5R0pMOWFpcFFPQ01wV3ExbjVLa1RR?=
 =?utf-8?B?SFNjWlNEN3F6Z09HblMzbFlNeDR5UzQzalBPdTNETjBlODZMMSt0aTExODkz?=
 =?utf-8?B?eS9BbXZYRTR0QUpJT3FRSWdsODRTN2haR2crek9UbXFZS3V3T0ErcW1UOGpG?=
 =?utf-8?B?Z3JoeXRGVkhhN2pjNXlCdFdQYkFIb3UzZFBGcDNzKzFUNkNsTHhVN0VjM1o5?=
 =?utf-8?B?Z3RMbTZVUG8xbWVvcXlTcGNSb0wzMlc5OVdHK2Z5eGRzUW5meVh0Vm54K0Vh?=
 =?utf-8?B?cmVzVldGaDQxcys3aHBpWXdRcWxJaTZSbDJnZGd1bTArOVVCVkREZkxyWTlt?=
 =?utf-8?B?MzVMazhCdjFROW43ZE9CT0x6Wld2OWw5K3poTVFYZVVVTVhleTFEMjN3MFBC?=
 =?utf-8?B?ZUdhZmx1V3hIYzRiNEppbDJsSHBKNmdIclRGakZLcHdxeXhzRUROWjFKUHda?=
 =?utf-8?B?aTA1bjJCY0hVc1ZCNmZWQytNMmFBVDJDK3ZKRDhVK2RZNEE1THpWdll6V0Ru?=
 =?utf-8?B?aE81NDR5VDB0cUgydkI0ZERyTE9ybjJRYVNHRUJmRmQxQ0s4TkFoaEVDTXVu?=
 =?utf-8?B?SVpNWUVSTUZ5VTQxWW15aHZkTDFmVmtBWTc1eTlZQ1dZeEdFNHN1aTV1M1Q3?=
 =?utf-8?B?UnptRDlEeVl3M0U4WHVWRy8wcUpYZEd2MmkrTEZSOHlQVWVTMzZINDZQRmFS?=
 =?utf-8?B?SE55NTVjOVZFT1pnaW9FNXUvaWlhMUVwTVZoYW9INWtKcHdTVkc0QnF1QW5B?=
 =?utf-8?B?dk1aL0VXOWd6R2tCY1daZXRrZktRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1936BCB4115DE045BCD8944AE6516189@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1634e068-6f03-43ad-b5b4-08dc33b9c229
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 15:20:09.9197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ER4a/q/pxdIV1Qg5HKf2yDxzFB0ixhLaT3ySN2DMHuG3vURZCgbXixsxvQTCz7DFq6FQ0Ko5SlPapEAZkE2DNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4672

T24gVGh1LCAyMDI0LTAyLTIyIGF0IDA2OjA1IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gV2VkLCAyMDI0LTAyLTIxIGF0IDEzOjQ4ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gV2VkLCAyMDI0LTAyLTIxIGF0IDE2OjIwICswODAwLCBaaGl0YW8gTGkgd3JvdGU6
DQo+ID4gPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHpoaXRhby5saUBzbWFydHgu
Y29tLiBMZWFybiB3aHkNCj4gPiA+IHRoaXMNCj4gPiA+IGlzIGltcG9ydGFudCBhdCBodHRwczov
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27CoF0NCj4gPiA+IA0KPiA+ID4g
SGksIGV2ZXJ5b25lLA0KPiA+ID4gDQo+ID4gPiAtIEZhY3RzOg0KPiA+ID4gSSBoYXZlIGEgcmVt
b3RlIE5GUyBleHBvcnQgYW5kIEkgbW91bnQgdGhlIHNhbWUgZXhwb3J0IG9uIHR3bw0KPiA+ID4g
ZGlmZmVyZW50IGRpcmVjdG9yaWVzIGluIG15IE9TIHdpdGggdGhlIHNhbWUgb3B0aW9ucy4gVGhl
cmUgaXMgYW4NCj4gPiA+IGluZmxpZ2h0IElPIHVuZGVyIG9uZSBtb3VudGVkIGRpcmVjdG9yeS4g
QW5kIHRoZW4gSSB1bm1vdW50DQo+ID4gPiBhbm90aGVyDQo+ID4gPiBtb3VudGVkIGRpcmVjdG9y
eSB3aXRoIGZvcmNlLiBUaGUgaW5mbGlnaHQgSU8gZW5kcyB1cCB3aXRoDQo+ID4gPiAiVW5rbm93
bg0KPiA+ID4gZXJyb3IgNTEyIiwgd2hpY2ggaXMgRVJFU1RBUlRTWVMuDQo+ID4gPiANCj4gPiAN
Cj4gPiBBbGwgb2YgdGhlIGFib3ZlIGlzIHdlbGwga25vd24uIFRoYXQncyBiZWNhdXNlIGZvcmNl
ZCB1bW91bnQNCj4gPiBhZmZlY3RzDQo+ID4gdGhlIGVudGlyZSBmaWxlc3lzdGVtLiBXaHkgYXJl
IHlvdSB1c2luZyBpdCBoZXJlIGluIHRoZSBmaXJzdA0KPiA+IHBsYWNlPyBJdA0KPiA+IGlzIG5v
dCBpbnRlbmRlZCBmb3IgY2FzdWFsIHVzZS4NCj4gPiANCj4gDQo+IFdoaWxlIEkgYWdyZWUgVHJv
bmQncyBhYm92ZSBzdGF0ZW1lbnQsIHRoZSBrZXJuZWwgaXMgbm90IHN1cHBvc2VkIHRvDQo+IGxl
YWsgZXJyb3IgY29kZXMgdGhhdCBoaWdoIGludG8gdXNlcmxhbmQuIEFyZSB5b3Ugc2VlaW5nIEVS
RVNUQVJUU1lTDQo+IGJlaW5nIHJldHVybmVkIHRvIHN5c3RlbSBjYWxscz8gSWYgc28sIHdoaWNo
IG9uZXM/DQoNClRoZSBwb2ludCBvZiBmb3JjZWQgdW1vdW50IGlzIHRvIGtpbGwgYWxsIFJQQyBj
YWxscyBhc3NvY2lhdGVkIHdpdGggdGhlDQpmaWxlc3lzdGVtIGluIG9yZGVyIHRvIHVuYmxvY2sg
dGhlIHVtb3VudC4gQmFzaWNhbGx5LCBpdCB0cmlnZ2VycyB0aGlzDQpjb2RlIGJlZm9yZSB0aGUg
dW5tb3VudCBzdGFydHM6DQoNCnZvaWQgbmZzX3Vtb3VudF9iZWdpbihzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiKQ0Kew0KICAgICAgICBzdHJ1Y3QgbmZzX3NlcnZlciAqc2VydmVyOw0KICAgICAgICBz
dHJ1Y3QgcnBjX2NsbnQgKnJwYzsNCg0KICAgICAgICBzZXJ2ZXIgPSBORlNfU0Ioc2IpOw0KICAg
ICAgICAvKiAtRUlPIGFsbCBwZW5kaW5nIEkvTyAqLw0KICAgICAgICBycGMgPSBzZXJ2ZXItPmNs
aWVudF9hY2w7DQogICAgICAgIGlmICghSVNfRVJSKHJwYykpDQogICAgICAgICAgICAgICAgcnBj
X2tpbGxhbGxfdGFza3MocnBjKTsNCiAgICAgICAgcnBjID0gc2VydmVyLT5jbGllbnQ7DQogICAg
ICAgIGlmICghSVNfRVJSKHJwYykpDQogICAgICAgICAgICAgICAgcnBjX2tpbGxhbGxfdGFza3Mo
cnBjKTsNCn0NCg0KU28geWVzLCB0aGF0IGRvZXMgc2lnbmFsIGFsbCB0aGUgd2F5IHVwIHRvIHRo
ZSBhcHBsaWNhdGlvbiBsZXZlbCwgYW5kDQppdCBpcyB2ZXJ5IG11Y2ggaW50ZW5kZWQgdG8gZG8g
c28uDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

