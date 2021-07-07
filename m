Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE853BF1CD
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jul 2021 00:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhGGWEk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 18:04:40 -0400
Received: from mail-bn8nam11on2119.outbound.protection.outlook.com ([40.107.236.119]:64178
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229717AbhGGWEk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Jul 2021 18:04:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dcpl/lVovBo5dkVhJeX9SCHb8Y4B3EFkIShFoTwl0CPsW+O8GJJc21x4VE3DX/goXi4BH+ceyovGCOUpHtIJbkyZegCjlKQdAHiH6K+vMdP4I85+CskT5EF1TuciRU3g+IQNaRuSRLzMHcRByibP3BdgljrMO7xhZKRhxGhfVTfp1cSr3F4jyNFGCkZ5A+EQZooSrIg44hGK/62Bzh2+4QCm8BLGvCcHIMwAyO03XGpIQ9PNor9S9ZnArBDoYASpRJIxoV9Sb9hEYQjyaFQSB4CR8z9ClFfGnz4UcFJ7y2/mVhN9DGIhjJdIoWAlcHtGDzc5uofxsT2mWIs1CvczDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUPbB+lEgsPx/nQoBvq269vjtrPWcv+Tut4fMuFxIlM=;
 b=Gzx77CZ4mLLbkGs+03Qu3tKpoPkabBu/h9PBSv3ekOWSIOWzNhUbVQKiVdGtdxs9y1feE+wtnRjjytweyiCvm/BHdKvBkDTwSVlZ1ZZ7h9NITxnf/2iouHtvKZjk6RI9Qa14oOhnLT5lalqG5aTwxXjNio59EK1PIbYNhttJUGxXaExHLEJgY827rdztexAW/NpwsMl5YG5b74vu1MZUg7Rls6vyRMk/P91X0juoFYrYrbzDFa+I4ewGVZ/RutO5fAADwwO6SaiOVMY2fzgp+jn31xDv/AN1Me3ZJMbnGLoCOBUQTfa3Omn/CYAhGrz6QJwIcJp5LPTugH+5sKAsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUPbB+lEgsPx/nQoBvq269vjtrPWcv+Tut4fMuFxIlM=;
 b=d9UjFP5ca90NEMoX/Sj2+kplklVRT6y5JaRAmC7NFncHXfQmYyCNcVRnielas7YrMJxXmoTgwLCl5ict/S/MDvOVIfLviMyWwV7KvZnncyD9Fr/GI/73Tz917PgKrLVKriHLqFBJ/kw5yCN280B+JVbLCRbT+eP6/jI5vKbOVJU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3333.namprd13.prod.outlook.com (2603:10b6:610:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.9; Wed, 7 Jul
 2021 22:01:57 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%4]) with mapi id 15.20.4308.014; Wed, 7 Jul 2021
 22:01:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "calum.mackay@oracle.com" <calum.mackay@oracle.com>
Subject: Re: nfs_page_async_flush returning 0 for fatal errors on writeback
Thread-Topic: nfs_page_async_flush returning 0 for fatal errors on writeback
Thread-Index: AQHXc2EXZOeJ3vVr8EWnAYtFuSDmlas4EKIA
Date:   Wed, 7 Jul 2021 22:01:56 +0000
Message-ID: <65fbd42ba59e539b1a15f9ea61cfd5664729ebec.camel@hammerspace.com>
References: <6cbd9cf8-49e9-868e-6452-1da2498c1358@oracle.com>
In-Reply-To: <6cbd9cf8-49e9-868e-6452-1da2498c1358@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7576f267-3a29-48ef-f530-08d94192d681
x-ms-traffictypediagnostic: CH2PR13MB3333:
x-microsoft-antispam-prvs: <CH2PR13MB3333A93C7DD66A988DB525FEB81A9@CH2PR13MB3333.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YQa4WvRalzkRzFyIUFrvUAuaNtnxCmwxVMHnW60rgS7UDF6bs8AdaCmBKMiSZy22HGUc/2AUrAFNOu8jSW7wRxRg8NhFl4vknU3yIrt1+A4mPmcUk2Ab738crsDLffPhJu1OmXfCzRKVt/tnrZYDcN1j3kJWjHlsp+whfzcI490SzHU38jBFDTJzgFtQdaVUBy7Ii99hq3o1Ymtl8mLwcw3zBwl0bKzevnw6s0h6Qb/lWSFe4W9NAsWiaK4kzlm3F/4gkcRkJxWnDYqZudAbge2EjsRPkDliwFG7mh/6fktwtgmUwhpunOXozsYUlT8rUv1Rkdkpfw/81wqkzVmN/jKIJ7njtVn6JUgH19ed2frWLeHPgj6xU6lSr5PoowTJQAmzPkMsHikAg3cshlWZQhxIpNU5CsXOjvQ2rVZcF6I0/b5HW2gf+Xi/MP2LsSMyK+KZle4pzOhDx099qqozUD7SF9YwzYtlMzPPcDtcUQQDODsjcfBUm5NrjRSpQfUevpUYaKw3Y/uqAttC4tPRcp+86cyC2wjSFdXMRMoBOA/7QQ5Mz0SlyZtjqyrmL118RDaCXCKWGKz1eyqhhcm7D/RwCI7PHJEdiIu1iVwej50Q9eIzGJXW6f7A2KnkDnBBmAKcW2ke8hOk/PnTufnmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(366004)(346002)(376002)(396003)(2906002)(66446008)(83380400001)(2616005)(316002)(36756003)(64756008)(66556008)(66476007)(5660300002)(6512007)(8676002)(76116006)(478600001)(66946007)(122000001)(71200400001)(38100700002)(26005)(186003)(110136005)(86362001)(6486002)(6506007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU5IbkVBMjd1ZjJia1FtNUNuMWlPbVZmOG5Ia2x3eGpCbnd0M2tNeS9VdU1j?=
 =?utf-8?B?RWtXd0g4djI5OVFtTWpvSUZxTGNrcDF2YVpBZDc1M1JIYTlkSTYrSENCaFpn?=
 =?utf-8?B?R2JzdjRUS2cyNUVlSVFHUFM0ZnhKZWYwVUxja25qQmM4dGdMWkdEV2Jib2Zo?=
 =?utf-8?B?Ump2N3dvV0NlMG1tbU1XaDV3VjJ4b3p5NUlPb0RrU01MYWh1R21HNTl1TC9k?=
 =?utf-8?B?MndFS2U4U0FUQjA5Q3JnTERERkhrY1dYOVF5RUN6N1NwK0Zjd2tVQk1BdElQ?=
 =?utf-8?B?dXBNbGJQYVMwT0VKSGVtenZReHlnRnpSWUhIYlp4NjQxRFNtZ2o4Ry8zclVJ?=
 =?utf-8?B?VDN2YjQxRFp0a0VYbE5VbDZwRERLZXAzb2NOc2hwVUpvbXkxdHptTmdheFM4?=
 =?utf-8?B?SlNCcnpGQkxSSzFwMjNndTdFR25iOEhZd3g0Z2dsQWdiaWVGS3dPNFIvZ1JH?=
 =?utf-8?B?VitxalprQzdkbC83aUlPdGorQzVLMVlBeExKZVh4QmdDTmJSSTRaVDVsbkdx?=
 =?utf-8?B?MVNOM21LazhUa2Y4cE1JUEZ0YTVtOTBXZFdJV2UySHFyVnBYQzhTbVFtWnNM?=
 =?utf-8?B?OHlDQS9EZWl2L0NMbGlHL3NpcEFOUm5TNGpBekdWVVM4VlFOM0phYUdocEJs?=
 =?utf-8?B?UXBkckE2SnJkbjQyUzU4WXgxbVVQY1hKS09VRkhjYUtJKzE5ci80QWJsS3pn?=
 =?utf-8?B?d0Fla21NTkpqaFhmckp1SUJQaTYvaVM5NzB0Nk9uNmN4U1k1RFFLcHNxQlkw?=
 =?utf-8?B?ZmxXS0M0QW1uVU1TQXd1SlhlNk1PSlBJOU16dHpOQnVOTXJnNDdpZVhndEVD?=
 =?utf-8?B?NThFZmVXc25jcjlKMHhvVG1vaThUbVdFR0w2TmFmTUthYVhqRGhlMzd5cFcx?=
 =?utf-8?B?L0cyTXY2QWpnOHVrd1AvM2s2OUlCc00wdktnQjNUK2J2eW92dVlpdHh3SlJp?=
 =?utf-8?B?YlJ4dlVrL3lUMkRiU0V1T2taUTdPSzdtaG13Zi9uNk9lOWZZQmZZM0l3ZjFw?=
 =?utf-8?B?eDJWTk1vNHM4RkxpUnQ0azd0eVZQMlRLYzYvY1BscTVpWHI3UVBnMFZNQ3Rq?=
 =?utf-8?B?N0NGbm95Slg4STdEOXh4eWxuVTdpdlVzd2RsUUxGd2JZTFZYY1gyM1RuN01m?=
 =?utf-8?B?MFRWSGRzbTJoRWg5aTE2SDZoeDhvbi94S3ZpWVZKa2M0QnlubTF0T09Wa09o?=
 =?utf-8?B?NElKbCtxT2ZTUkhqNDQzVEtTTWRjQ0xVckZCSnZUbXZSQnk5aHpkN0VLZWYr?=
 =?utf-8?B?TVNQbWlaRUxSNWJ2Tk0waW1zd2d6c3l1dXFKMkJ4SjJ5MG5CZmxIZVlDUnBF?=
 =?utf-8?B?bjhsQXpYeFB4aXBJUmJQWkVROGcrU01qdEttMlNXM09wY0t3Q21DZkJTRmNJ?=
 =?utf-8?B?Wk5vYTA4M1BoZnhQMXhCNm9oWjJiUDUzSlZEcytCcHJsaUwwY2NyZVF5dTZX?=
 =?utf-8?B?emUrMExDdmt3VjBMaEp0THhWTkFZYitCZTRJRnFQQzRISDRNRlMyalAzVXU5?=
 =?utf-8?B?dXhiZ09idVpORUlKSUhMSjRRbkRNTG9STUVaVTBNVVVEaHkxcGxtb1FzTFJr?=
 =?utf-8?B?Ym9XZWRUNkFSZTMxbFh4L3NiVElJSnBwOWNHdmlzS2RtU283OWZuVFFERTNK?=
 =?utf-8?B?SG9PVTdSNTMzT1hGS1RwaFV1WHlraGJHVVZyY1BQY1FvMkR6T1VaSDQvNlQv?=
 =?utf-8?B?bGltUU9qdWlnY0RyRVNXU2gxWU1SdUNQaVlnUk5QVkVxbVY2UC9JSldoQUlX?=
 =?utf-8?Q?K9g+p7tclFu4Y7gxD6Pl6ifQ1OoS77RZCHxDZTx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD3E2DAE8CC7434AA06F6BE7EBC2D937@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7576f267-3a29-48ef-f530-08d94192d681
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 22:01:56.8312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VixNP8YfK9rgl4rA8hMC1OGoUfW2wl9Z99MS1rKN1E44vGsqBHYMQaign3cIrGHEJ8b6o3cdDpI2pEj+q2Znxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3333
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTA3IGF0IDE5OjUxICswMTAwLCBDYWx1bSBNYWNrYXkgd3JvdGU6DQo+
IGhpIFRyb25kLA0KPiANCj4gSSBoYWQgYSBxdWVzdGlvbiBhYm91dCB0aGVzZSB0d28gb2xkIGNv
bW1pdHMgb2YgeW91cnMsIGZyb20gdjUuMCAmDQo+IHY1LjI6DQo+IA0KPiAxNGJlYmUzYzkwYjMg
TkZTOiBEb24ndCBpbnRlcnJ1cHQgZmlsZSB3cml0ZW91dCBkdWUgdG8gZmF0YWwgZXJyb3JzDQo+
ICgyIA0KPiB5ZWFycywgMiBtb250aHMgYWdvKQ0KPiANCj4gOGZjNzViZWQ5NmJiIE5GUzogRml4
IHVwIHJldHVybiB2YWx1ZSBvbiBmYXRhbCBlcnJvcnMgaW4gDQo+IG5mc19wYWdlX2FzeW5jX2Zs
dXNoKCkgKDIgeWVhcnMsIDUgbW9udGhzIGFnbykNCj4gDQo+IA0KPiBJIGFtIGxvb2tpbmcgYXQg
YSBjcmFzaCBkdW1wLCB3aXRoIGEga2VybmVsIGJhc2VkIG9uIGFuIG9sZGVyLXN0aWxsIA0KPiB2
NC4xNCBzdGFibGUgd2hpY2ggZGlkIG5vdCBoYXZlIGVpdGhlciBvZiB0aGUgYWJvdmUgY29tbWl0
cy4NCj4gDQo+IMKgwqDCoMKgwqDCoMKgIFBBTklDOiAiQlVHOiB1bmFibGUgdG8gaGFuZGxlIGtl
cm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UNCj4gYXQNCj4gMDAwMDAwMDAwMDAwMDA4MCIN
Cj4gDQo+IMKgwqDCoMKgIFtleGNlcHRpb24gUklQOiBfcmF3X3NwaW5fbG9jaysyMF0NCj4gDQo+
ICMxMCBbZmZmZmIxNDkzZDc4ZmNiOF0gbmZzX3VwZGF0ZXBhZ2UgYXQgZmZmZmZmZmZjMDhmMTc5
MSBbbmZzXQ0KPiAjMTEgW2ZmZmZiMTQ5M2Q3OGZkMTBdIG5mc193cml0ZV9lbmQgYXQgZmZmZmZm
ZmZjMDhlMDk0ZSBbbmZzXQ0KPiAjMTIgW2ZmZmZiMTQ5M2Q3OGZkNThdIGdlbmVyaWNfcGVyZm9y
bV93cml0ZSBhdCBmZmZmZmZmZmE3MWQ0NThiDQo+ICMxMyBbZmZmZmIxNDkzZDc4ZmRlMF0gbmZz
X2ZpbGVfd3JpdGUgYXQgZmZmZmZmZmZjMDhkZmRiNCBbbmZzXQ0KPiAjMTQgW2ZmZmZiMTQ5M2Q3
OGZlMThdIF9fdmZzX3dyaXRlIGF0IGZmZmZmZmZmYTcyODQ4YmMNCj4gIzE1IFtmZmZmYjE0OTNk
NzhmZWEwXSB2ZnNfd3JpdGUgYXQgZmZmZmZmZmZhNzI4NGFkMg0KPiAjMTYgW2ZmZmZiMTQ5M2Q3
OGZlZTBdIHN5c193cml0ZSBhdCBmZmZmZmZmZmE3Mjg0ZDM1DQo+ICMxNyBbZmZmZmIxNDkzZDc4
ZmYyOF0gZG9fc3lzY2FsbF82NCBhdCBmZmZmZmZmZmE3MDAzOTQ5DQo+IA0KPiB0aGUgcmVhbCBz
ZXF1ZW5jZSwgb2JzY3VyZWQgYnkgY29tcGlsZXIgaW5saW5pbmcsIGlzOg0KPiANCj4gwqDCoMKg
IG5mc191cGRhdGVwYWdlDQo+IMKgwqDCoMKgwqDCoCBuZnNfd3JpdGVwYWdlX3NldHVwDQo+IMKg
wqDCoMKgwqDCoMKgwqDCoCBuZnNfc2V0dXBfd3JpdGVfcmVxdWVzdA0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbmZzX2lub2RlX2FkZF9yZXF1ZXN0DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzcGluX2xvY2soJm1hcHBpbmctPnByaXZhdGVfbG9jayk7DQo+IA0KPiBhbmQg
d2UgY3Jhc2ggc2luY2UgdGhlIGFzIG1hcHBpbmcgcG9pbnRlciBpcyBOVUxMLg0KPiANCj4gDQo+
IEkgdGhvdWdodCBJIHdhcyBhYmxlIHRvIGNvbnN0cnVjdCBhIHBvc3NpYmxlIHNlcXVlbmNlIHRo
YXQgd291bGQNCj4gZXhwbGFpbiANCj4gdGhlIGFib3ZlLCBpZiB3ZSBhcmUgaW4gKGZyb20gYWJv
dmUpOg0KPiANCj4gwqDCoMKgIG5mc19zZXR1cF93cml0ZV9yZXF1ZXN0DQo+IMKgwqDCoMKgIG5m
c190cnlfdG9fdXBkYXRlX3JlcXVlc3QNCj4gwqDCoMKgwqDCoCBuZnNfd2JfcGFnZQ0KPiDCoMKg
wqDCoMKgwqAgbmZzX3dyaXRlcGFnZV9sb2NrZWQNCj4gwqDCoMKgwqDCoMKgwqAgbmZzX2RvX3dy
aXRlcGFnZQ0KPiANCj4gYW5kIG5mc19wYWdlX2FzeW5jX2ZsdXNoIGRldGVjdHMgYSBmYXRhbCBz
ZXJ2ZXIgZXJyb3IsIGFuZCBjYWxscyANCj4gbmZzX3dyaXRlX2Vycm9yX3JlbW92ZV9wYWdlLCB3
aGljaCByZXN1bHRzIGluIHRoZSBwYWdlLT5tYXBwaW5nIHNldA0KPiB0byBOVUxMLg0KPiANCj4g
SW4gdGhhdCB2ZXJzaW9uIG9mIHRoZSBjb2RlLCB3aXRob3V0IHlvdXIgY29tbWl0cyBhYm92ZSwg
DQo+IG5mc19wYWdlX2FzeW5jX2ZsdXNoIHJldHVybnMgMCBpbiB0aGlzIGNhc2UsIHdoaWNoIEkg
dGhvdWdodCBtaWdodCANCj4gcmVzdWx0IGluIG5mc19zZXR1cF93cml0ZV9yZXF1ZXN0IGdvaW5n
IGFoZWFkIGFuZCBjYWxsaW5nIA0KPiBuZnNfaW5vZGVfYWRkX3JlcXVlc3Qgd2l0aCB0aGF0IHBh
Z2UsIHJlc3VsdGluZyBpbiB0aGUgY3Jhc2ggc2Vlbi4NCj4gDQo+IA0KPiBJIHRoZW4gZGlzY292
ZXJlZCB5b3VyIHY1LjAgY29tbWl0Og0KPiANCj4gOGZjNzViZWQ5NmJiIE5GUzogRml4IHVwIHJl
dHVybiB2YWx1ZSBvbiBmYXRhbCBlcnJvcnMgaW4gDQo+IG5mc19wYWdlX2FzeW5jX2ZsdXNoKCkg
KDIgeWVhcnMsIDUgbW9udGhzIGFnbykNCj4gDQo+IHdoaWNoIGFwcGVhcmVkIHRvIGNvcnJlY3Qg
dGhhdCwgaGF2aW5nIG5mc19wYWdlX2FzeW5jX2ZsdXNoIHJldHVybg0KPiB0aGUgDQo+IGVycm9y
IGluIHRoaXMgY2FzZSwgc28gd2Ugd291bGQgbm90IGVuZCB1cCBpbiBuZnNfaW5vZGVfYWRkX3Jl
cXVlc3QuDQo+IA0KPiANCj4gQnV0IEkgdGhlbiBzcG90dGVkIHlvdXIgbGF0ZXIgdjUuMiBjb21t
aXQ6DQo+IA0KPiAxNGJlYmUzYzkwYjMgTkZTOiBEb24ndCBpbnRlcnJ1cHQgZmlsZSB3cml0ZW91
dCBkdWUgdG8gZmF0YWwgZXJyb3JzDQo+ICgyIA0KPiB5ZWFycywgMiBtb250aHMgYWdvKQ0KPiAN
Cj4gd2hpY2ggY2hhbmdlcyB0aGluZ3MgYmFjaywgc28gdGhhdCBuZnNfcGFnZV9hc3luY19mbHVz
aCBub3cgYWdhaW4gDQo+IHJldHVybnMgMCwgaW4gdGhlICJsYXVuZGVyIiBjYXNlLCBhbmQgdGhh
dCdzIGhvdyB0aGF0IGNvZGUgcmVtYWlucw0KPiB0b2RheS4NCj4gDQo+IA0KPiBJZiBzbywgaXMg
dGhlcmUgYW55dGhpbmcgdG8gc3RvcCB0aGUgcG9zc2libGUgY3Jhc2ggcGF0aCB0aGF0IEkNCj4g
ZGVzY3JpYmUgDQo+IGFib3ZlPw0KPiANCj4gDQo+IHBhdGggSSBzdWdnZXN0IGFib3ZlPyBPciBw
ZXJoYXBzIEknbSBtaXNzaW5nIGFub3RoZXIgY29tbWl0IHRoYXQNCj4gc3RvcHMgDQo+IGl0IGhh
cHBlbmluZywgZXZlbiBhZnRlciB5b3VyIHNlY29uZCBjb21taXQgYWJvdmU/DQo+IA0KDQpJbiBv
cmRlciBmb3IgcGFnZS0+bWFwcGluZyB0byBnZXQgc2V0IHRvIE5VTEwsIHdlJ2QgaGF2ZSB0byBi
ZSByZW1vdmluZw0KdGhlIHBhZ2UgZnJvbSB0aGUgcGFnZSBjYWNoZSBhbHRvZ2V0aGVyLiBJJ20g
bm90IHNlZWluZyB3aGVyZSB3ZSdkIGJlDQpkb2luZyB0aGF0IGhlcmUuIEl0IGNlcnRhaW5seSBp
c24ndCBwb3NzaWJsZSBmb3Igc29tZSB0aGlyZCBwYXJ0eSB0byBkbw0Kc28sIHNpbmNlIG91ciB0
aHJlYWQgaXMgaG9sZGluZyB0aGUgcGFnZSBsb2NrIGFuZCBJJ20gbm90IHNlZWluZyB3aGVyZQ0K
dGhlIGNhbGwgdG8gbmZzX3dyaXRlX2Vycm9yKCkgbWlnaHQgYmUgZG9pbmcgc28uDQoNCldlIGRv
IGNhbGwgbmZzX2lub2RlX3JlbW92ZV9yZXF1ZXN0KCksIHdoaWNoIHJlbW92ZXMgdGhlIHN0cnVj
dA0KbmZzX3BhZ2UgdGhhdCBpcyB0cmFja2luZyB0aGUgcGFnZSBkaXJ0aW5lc3MsIGhvd2V2ZXIg
aXQgc2hvdWxkbid0IGV2ZXINCnJlc3VsdCBpbiB0aGUgcmVtb3ZhbCBvZiB0aGUgcGFnZWNhY2hl
IHBhZ2UgaXRzZWxmLg0KDQpBbSBJIG1pc3JlYWRpbmcgeW91ciBlbWFpbD8NCg0KQ2hlZXJzDQog
IFRyb25kDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
