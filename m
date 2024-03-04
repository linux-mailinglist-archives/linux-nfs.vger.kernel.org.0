Return-Path: <linux-nfs+bounces-2197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707EE8710EA
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 00:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCD31F22EC4
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F247CF1D;
	Mon,  4 Mar 2024 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="eAzxfKcM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8D7C0A1
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593686; cv=fail; b=f911OjvY9RtnIWbebNPWqNmgtSW+fAJJYffLfBQNLv5OMudxxCAJZFQJ+KKUdNMJt4w3Rn7Fu5+UAq7voY0X7nc7v/ESxNsnFgeEW/DMfhFcl+NA8JJfFZ2a27tOe2F1dAirgCSmVHEp0z5nLtBMD3ALAwH9Yrbq58ZDpCszIqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593686; c=relaxed/simple;
	bh=2tf7rMsQTGTZXPpZKmOJmzsbrPNrgIVakop2YNmr/8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kLFktWRpJysKQplVtKLE6twA6JFlQsEQv5EppwCyOLG7v3hhu1rG5umcP6jEC1Q60JYcJjDER55HwBYeZ9niyT9IeKBtWO1/jDWWGNLO5rjGGZ78j09Pt/Azjd9mfC9Foo+OTtNDX9ldF5aCF2tOng34U0HOUl+kg/LFoK7F6VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=eAzxfKcM; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa8j52IJvROXHPkk7wFQ/ocHWWbOCYKFgUnHJjjcQu2syaMmA1w8tavpYMH3CVx+4YrPNjMIba+9xt/cEukoKuQzsabfhhsjNtaIYenbIzps4fphtBUfcWHex1KKldtHaJU0zj7CT6XjKc7mMov8JnwZsv3Lh3H6Tg0HRJePq2T7aLbkj+TREj4nA6Q2TJOqnBIs/uV4npvnw8ECLwBA7gUM9HKBjAFacl7DtgUUvHCH1xrodM1qi43RVHSaWUOvvgZrpXy+YfF7Eo5N75ZppOhXF/ZbsDS8v3RJ0R2eIbK4tvGuJmOyN0RSmgXS/FWUtIBidWWEHqgioc8CgAnhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tf7rMsQTGTZXPpZKmOJmzsbrPNrgIVakop2YNmr/8M=;
 b=UYm3Qq2pevaGmK4HG6svVz5Yijq2jVm/q15hXfNlSlcMoABLzbFd2uU3SU+Jh6pu3FHovf06YbV9AGYEtFhMHWUQn6+v8TAVn19gTUefpW8btZ8SveOUQk2CDCUDs4emDhOlyfNQQHNuwDLrFXOmIpQXIyCwmYo9Zmqb29PdA+CwER6ra4Jp1LpsNY9FjrSDgEaclJX2AmhK6n9rVgEtB0BGO94JMKyPMI7n83MRdSZpI3iSrEoOAJs465OCfozmV7uCLGvGIEDMRw/GsLHtXsoYs7BOZsRG4r7HuG9Nqa8Z/uyANT+d6RUKnBsyO12BtS4zZ7Zn0lkMEXQF2nncPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tf7rMsQTGTZXPpZKmOJmzsbrPNrgIVakop2YNmr/8M=;
 b=eAzxfKcM606UN7TIGhMrOKJmtDaJ4a3jPe1wpkocj5v0EAlS6zq+pvsh5r0v5BlU2fOzPhngRlpL4xfbjqcf6ZoWFCUGGeXSsE6SSvTynEdpJHr0iRXK49kY+fS8B6FpCg9wPg14jibHHAL/FOl3Cql2vctr4svBZzwVdJVh9dc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3992.namprd13.prod.outlook.com (2603:10b6:208:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 23:08:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 23:08:00 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "aglo@umich.edu" <aglo@umich.edu>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: enable nconnect for RDMA
Thread-Topic: [PATCH] NFS: enable nconnect for RDMA
Thread-Index: AQHaao700wwSMs79JkKaeR4gJTgTt7EmXegAgAGZx4CAAAi2AIAAPBaA
Date: Mon, 4 Mar 2024 23:08:00 +0000
Message-ID: <c88bda54d8eb5a78a94b426e23cc8048d804927c.camel@hammerspace.com>
References: <20240228213523.35819-1-trondmy@kernel.org>
	 <ZeTC2h59TXUTuCh_@manet.1015granger.net>
	 <CAN-5tyH2dkLbt9dMau46ebrU=PfvLgo2=mr8u3_C1gUnAGM_ow@mail.gmail.com>
	 <51189037-DD10-4806-8596-D4374067FDFB@oracle.com>
In-Reply-To: <51189037-DD10-4806-8596-D4374067FDFB@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3992:EE_
x-ms-office365-filtering-correlation-id: acca45da-7c41-42b1-631c-08dc3c9ff023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RLMkOphFBuJQf4PiavtolmH6b4HvAGW40Nkn8zf4tuAL5tKTjlP1HMxkFTVo5oo2R+HYnh99BCEg1ioF5ZV3GDeQkKWw7JeHFNAKtygczTlMTlXm1VI3tvOl0i8va7+x4acw9PWBa9dZ1jnJni7zvMYIW8qIDGx7inUkzRkhSKrZh5keds7fgX2pwM8fDgj18aT9HEl3pn1b5aZ1ZFGgJInGW5S1r0qwqClYlpJpE6UoaFaa4Bn0hFDv01FmqnPQTLyDHX8Q4bwjORJ+IeAPLcLlasA7WdwSPceMTYRNieSIvIU6A2W7rnmYNsZsN34bK7HnpAWGgkX8WffHZaITcMLSxINmg6lOFvSLtIQD/DxRAT1jYRzOx3eX0qL4fZFJV1uNZd1xUStj+8vvaqGYz7ZKsUc4vAjVSb6u2z/4jKzJ8RBoUHWP7OrRyYkEg0Vs9aGLDUpHMcXtnF78jUXqR1tQKru/OzONv2AJYxrYLV1/eNhqVR3mMrzy0HhZ2Eql8RgP6XlGWaFy+4yRj3a79eB+kmkwaXZA/WRO92bd0fBzfabN/u+au3ipAyfHGgiK+l+elkM4xgySe4LSBqbz3voM8sYnv6qOHGjgY3hiGghvfwj1tAanQEHSIT2RQ00rba8m+sbO7TmFD/Yow/3WmlZXQLT2/LRU71JuOLnhdiGkXapvOvAM4V+RMvhZSw0H/VjrdTaOn0p2Nhg9By0iXJPPwxuNf79jibYvz7fQAvE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFlEVmJueE04bUtKTXAvelBFSWhTdjVuRkJJZ1pZZk1YOCtOVG44Z2VzT3Mz?=
 =?utf-8?B?TnBBekVpVGgvNGpHK1VuaHVnT2MwL0V5bmZSeWZuOHJpWkJpdk52U1FnbEVR?=
 =?utf-8?B?WEdIbEhzZGttN1oxeEJsM3JRd3pCNlB6b0d1QkhjRlpHOW45cWxJZHNZUERS?=
 =?utf-8?B?NDdzQnlXaWM3SnVPSWt3UTBqWnlnQzVKTXR3ZHA1dUZPa0h2ZDJIQmtUREVB?=
 =?utf-8?B?b0MybURIckREcm91M1Yvb01MZFowVWdWeVVvakVBb1ZSNk9pdFFmYk9Zd2xo?=
 =?utf-8?B?bnV4UHpERzJKbDRkZFJ6Z3Z0KzB4M3poemdZT0FEc2VXV2JNaytZbjFUTklq?=
 =?utf-8?B?QkNNVVFEbStFdFVkWWVMTW5oYzdXaUIyMCtDbERXNk1KTFZPY1JMNnphSzJW?=
 =?utf-8?B?aGlNZVVBc3labkhlTVV3RXFzN3pWd1RFbDNOVzZwMGQ4VWY1ejlWZXRWUnQ1?=
 =?utf-8?B?ZjNRaFFTRlBXMzg4ZHRXcHdvVkRjTDlEVXdRZkU5eFFlSUQwVlBkTnF4ajdL?=
 =?utf-8?B?M2ttNldrQWpwR01JUFVCaS9xV011YXZESmdPZ05yZTJ4b1dsekpralZGb3R1?=
 =?utf-8?B?c3p0aEJML2ZSWnRITkVBSU4zTGN1RlUzM0RzSVdmeDVxdjFlSGVJRDNTVlVp?=
 =?utf-8?B?b1YxdnNuVDR0cHNRT1l5eUw0S3dpbW9hUWFERHhKMFFRNXE5RGZXVEFnR284?=
 =?utf-8?B?ZmtjM0dzTERZckZqNUwrZmM0UGtsQVQ1cHMvMnI5Zk5Rcm9zM3g0Z3hSa0VR?=
 =?utf-8?B?anZSS1Q4V3ZXRG5GTElFc1J1aDloYnAyeGllNWlyQ0lDMjI4bjY0RjdHV2VC?=
 =?utf-8?B?ZlJlV3I5aGV4OUhEbmI3Tm8xSDUrWUxQaGdmRkVrVDllTDMwc2k3Q3dzOFIx?=
 =?utf-8?B?dHFSOGFqY3ZsaDJOYmFhczdoMXBuZTJ6WW9HVE1VVnVBa1B3QUI0RXBZczVx?=
 =?utf-8?B?aDZ6eGVKUXBUcFVIMEdWN2U4aTNQSVljWG9LTXlRR2tYVTZVcVdQc00xa1Fq?=
 =?utf-8?B?YVVmVTJaQW80c3ppcE9sQzkxMnJ4cCsrQ1ZjRjE2MEdUQ1VhT2VPYUJPZnVI?=
 =?utf-8?B?Z09MTThjbGMwd29ZdXFhRHk4VjVFRm5mbUFWZ0ZOK3hrZ2VNQ0tPRG1BWDhk?=
 =?utf-8?B?em5nczRjeXEvWmFLSE5WUFd0NW5JUmxtRzRFV1kxNmM1bDVob21PV1YwVGVL?=
 =?utf-8?B?T3Y1Ui9MQjI5WnBBZytWZTFoeFRLTlV6Q3BaVnhCNEk2eEpkdm9pU0JFVXFF?=
 =?utf-8?B?T05OZVBqMXVKWXprQ2tSQ0orNkdGSU9VR2NIMlRJQXBUbU5vWi9aM1F5WVdS?=
 =?utf-8?B?ZEpTN21ydWZwcWd3NmZLTVlBMWoxMkZBSVQ0QnFnRUF6Mk5ZY09MR2lPeDA5?=
 =?utf-8?B?WnY2MDdaR1JwTFV2STNnelJGK1ZodTZ4Z1RJYnJOTUxxVFhqU1RxaHhEb29u?=
 =?utf-8?B?NW9yRkphQzkvaGNlN3JsdWhXelVmUzR4YmZJLzRpdnVDcUh0dnBtSnBKYTM2?=
 =?utf-8?B?MXpFV2tQTzZNSFVkb0NPT0JJM2tMTDhqREl5OXpKcDFBRko5bHd0M3MydTBS?=
 =?utf-8?B?bVdlQ3VYNnhMRVZjMlJZaXB6VXdtcmxzaUhlWUN2NHJTKzVsZVFxbkJLdmVr?=
 =?utf-8?B?bjU4Q1M1MldMZit1aTdabzJRUHluNXo4L1dTNWVwQkZweVc3TWt3Ty9VNUM2?=
 =?utf-8?B?VkZsa0UvcDV5YlNzNi9iOEVjbVFQRVBzK0MwSzBmR0tqMXduR3IrMjNnOHJB?=
 =?utf-8?B?OE9uUEx4V3RJdERuY29XbERIRzNPVDM2bUJxWWVKV1M2ZGN2UThpSURLRncy?=
 =?utf-8?B?VXp1WWV4N0VsNmxmOENPU1F1N20rT2FrRTdjQktQMzlMOHI3bnphSWtOdy9Y?=
 =?utf-8?B?bWp1bUhKUmZmZmdRRkt3K0VNdXcvblFCcUwwYmgzMy9TbTArU3RmTXFVa2lZ?=
 =?utf-8?B?bVpXdGlMOUhlL3Jnb3Q1OXFSdWUycWU0R281QmlIWE16YVZ1ejVrbUhuREJs?=
 =?utf-8?B?U2lLQ3RGazRkdndIUTVDbDV6ZXgwMFRIMGtRZ2tZTlJHaExkN0w3TFB5UFI2?=
 =?utf-8?B?NW1XMlJITmh1UU9WdWMyOEVGWDN3TFRhSjhkdFZSSGt4WmVjNXhCam5FTGlh?=
 =?utf-8?B?cHB1dCs3cVA0ZDRhbUVONG42NFdTUTl4M0RvUU5YVHVreGtDbjJkN2xPZWx5?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEBB44CF630B6A499B52B4564C6FED4F@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: acca45da-7c41-42b1-631c-08dc3c9ff023
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 23:08:00.5951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAJzfSiW/y7sUSnH4xOHKEqZVrjoV2eQu9N0RohJo3RyRM3F0ga0BenWpRkNiLsalqzrmkwOmKuIj4TXLVtgxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3992

T24gTW9uLCAyMDI0LTAzLTA0IGF0IDE5OjMyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBNYXIgNCwgMjAyNCwgYXQgMjowMeKAr1BNLCBPbGdhIEtvcm5pZXZz
a2FpYSA8YWdsb0B1bWljaC5lZHU+DQo+ID4gd3JvdGU6DQo+ID4gDQo+ID4gT24gU3VuLCBNYXIg
MywgMjAyNCBhdCAxOjM14oCvUE0gQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+
DQo+ID4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9uIFdlZCwgRmViIDI4LCAyMDI0IGF0IDA0OjM1
OjIzUE0gLTA1MDAsDQo+ID4gPiB0cm9uZG15QGtlcm5lbC5vcmfCoHdyb3RlOg0KPiA+ID4gPiBG
cm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+
ID4gPiA+IA0KPiA+ID4gPiBJdCBhcHBlYXJzIHRoYXQgaW4gY2VydGFpbiBjYXNlcywgUkRNQSBj
YXBhYmxlIHRyYW5zcG9ydHMgY2FuDQo+ID4gPiA+IGJlbmVmaXQNCj4gPiA+ID4gZnJvbSB0aGUg
YWJpbGl0eSB0byBlc3RhYmxpc2ggbXVsdGlwbGUgY29ubmVjdGlvbnMgdG8gaW5jcmVhc2UNCj4g
PiA+ID4gdGhlaXINCj4gPiA+ID4gdGhyb3VnaHB1dC4gVGhpcyBwYXRjaCB0aGVyZWZvcmUgZW5h
YmxlcyB0aGUgdXNlIG9mIHRoZQ0KPiA+ID4gPiAibmNvbm5lY3QiIG1vdW50DQo+ID4gPiA+IG9w
dGlvbiBmb3IgdGhvc2UgdXNlIGNhc2VzLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA+IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tPg0KPiA+ID4gDQo+ID4gPiBObyBvYmplY3Rpb24gdG8gdGhpcyBwYXRjaC4NCj4gPiA+IA0K
PiA+ID4gWW91IGRvbid0IG1lbnRpb24gaGVyZSBpZiB5b3UgaGF2ZSByb290LWNhdXNlZCB0aGUg
dGhyb3VnaHB1dA0KPiA+ID4gaXNzdWUuDQo+ID4gPiBPbmUgdGhpbmcgSSd2ZSBub3RpY2VkIGlz
IHRoYXQgY29udGVudGlvbiBmb3IgdGhlIHRyYW5zcG9ydCdzDQo+ID4gPiBxdWV1ZV9sb2NrIGlz
IGhvbGRpbmcgYmFjayB0aGUgUlBDL1JETUEgUmVjZWl2ZSBjb21wbGV0aW9uDQo+ID4gPiBoYW5k
bGVyLA0KPiA+ID4gd2hpY2ggaXMgc2luZ2xlLXRocmVhZGVkIHBlciB0cmFuc3BvcnQuDQo+ID4g
DQo+ID4gQ3VyaW91czogaG93IGRvZXMgYSBxdWV1ZV9sb2NrIHBlciB0cmFuc3BvcnQgaXMgYSBw
cm9ibGVtIGZvcg0KPiA+IG5jb25uZWN0PyBuY29ubmVjdCB3b3VsZCBjcmVhdGUgaXRzIG93biB0
cmFuc3BvcnQsIHdvdWxkIGl0IG5vdyBhbmQNCj4gPiBzbw0KPiA+IGl0IHdvdWxkIGhhdmUgaXRz
IG93biBxdWV1ZV9sb2NrIChwZXIgbmNvbm5lY3QpLg0KPiANCj4gSSBkaWQgbm90IG1lYW4gdG8g
aW1wbHkgdGhhdCBxdWV1ZV9sb2NrIGNvbnRlbnRpb24gaXMgYQ0KPiBwcm9ibGVtIGZvciBuY29u
bmVjdCBvciB3b3VsZCBpbmNyZWFzZSB3aGVuIHRoZXJlIGFyZQ0KPiBtdWx0aXBsZSB0cmFuc3Bv
cnRzLg0KPiANCj4gQnV0IHRoZXJlIGlzIGRlZmluaXRlbHkgbG9jayBjb250ZW50aW9uIGJldHdl
ZW4gdGhlIHNlbmQgYW5kDQo+IHJlY2VpdmUgY29kZSBwYXRocywgYW5kIHRoYXQgY291bGQgYmUg
b25lIHNvdXJjZSBvZiB0aGUgcmVsaWVmDQo+IHRoYXQgVHJvbmQgc2F3IGJ5IGFkZGluZyBtb3Jl
IHRyYW5zcG9ydHMuIElNTyB0aGF0IGNvbnRlbnRpb24NCj4gc2hvdWxkIGJlIGFkZHJlc3NlZCBh
dCBzb21lIHBvaW50Lg0KPiANCj4gSSdtIG5vdCBhc2tpbmcgZm9yIGEgY2hhbmdlIHRvIHRoZSBw
cm9wb3NlZCBwYXRjaC4gQnV0IEkgYW0NCj4gc3VnZ2VzdGluZyBzb21lIHBvc3NpYmxlIGZ1dHVy
ZSB3b3JrLg0KPiANCg0KV2Ugd2VyZSBjb21wYXJpbmcgTkZTL1JETUEgcGVyZm9ybWFuY2UgdG8g
dGhhdCBvZiBORlMvVENQLCBhbmQgaXQgd2FzDQpjbGVhciB0aGF0IHRoZSBuY29ubmVjdCB2YWx1
ZSB3YXMgZ2l2aW5nIHRoZSBsYXR0ZXIgYSBtYWpvciBib29zdC4gT25jZQ0Kd2UgZW5hYmxlZCBu
Y29ubmVjdCBmb3IgdGhlIFJETUEgY2hhbm5lbCwgdGhlbiB0aGUgdmFsdWVzIGV2ZW5lZCBvdXQg
YQ0KbG90IG1vcmUuDQpPbmNlIHdlIGZpeGVkIHRoZSBuY29ubmVjdCBpc3N1ZSwgd2hhdCB3ZSB3
ZXJlIHNlZWluZyB3aGVuIHRoZSBSRE1BDQpjb2RlIG1heGVkIG91dCB3YXMgYWN0dWFsbHkgdGhh
dCB0aGUgQ1BVIGdvdCBwZWdnZWQgcnVubmluZyB0aGUgSUINCmNvbXBsZXRpb24gd29yayBxdWV1
ZXMgb24gd3JpdGVzLg0KDQpXZSBjYW4gY2VydGFpbmx5IGxvb2sgaW50byBpbXByb3ZpbmcgdGhl
IHBlcmZvcm1hbmNlIG9mDQp4cHJ0X2xvb2t1cF9ycXN0KCkgaWYgd2UgaGF2ZSBldmlkZW5jZSB0
aGF0IGlzIHNsb3csIGJ1dCBJJ20gbm90IHlldA0Kc3VyZSB0aGF0IHdhcyB3aGF0IHdlIHdlcmUg
c2VlaW5nLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

