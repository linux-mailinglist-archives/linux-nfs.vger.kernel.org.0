Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9BE42FD55
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 23:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhJOVV4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Oct 2021 17:21:56 -0400
Received: from mail-mw2nam10on2092.outbound.protection.outlook.com ([40.107.94.92]:32609
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229445AbhJOVVz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 15 Oct 2021 17:21:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZi9XV9Kr7RZm11PmPEKvAkImP7WUrSQLp2ozdNpkpfB9RnHqNfE2kasxzB+QqPYgr3bAvNn/YaEAEcrxp0eDqnq6+jqeEKQ+i2a8K0rh/jV8lW89dUD6AYUZ7lMIigo9nsE7l6AW6lKRNRThvPZNA9Tfw04ReT90so3llRq0+wUoUFnvFcTEeg+EJz5OMpx/ytMtnrkqNotCKRouvp50H4ItfcehqNG/oEoLgEikEW7fypwYZaowX2S/9jhZ33Nv1gS7Qaqtm/tCbj30cK5IiznTprM9vcnkoIIS8VjsSrdyguJkfOJhIuCMkVi9gJKE1Aw3R7UTvDt2r+klRaS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElC5+4YJI1mp/X3Cy4Ewm5ezLt1debXFEioBOVFQPm4=;
 b=G8JcyfyLUn0A13gJKB/egRd5eci3VgEu/qvebHOqFsPRuGfivHYsC6do12xIfhdP0YE9/+nkRiMjfkCMCPxiqn0VUYnjxwPcBg1MlIpiO8piFHcI1JQPBmMN7Sb0keJqXq3MozJTbOAqQbCtwwZjlRTRLfASdthKhTH01o4ADiy80AFk7ZxpzZoWlicaDRMIxXDu7n+2ob+GYbcRm/aHWvzC0C+3WWb/2xbQWGxlht9pmzWqYPCIQz9plK0Rw+9+IZC9BCOe79EjgaUXNhQaD+/9zTK6dyUTxqABHtruVg7Yoie/pavRhbs7OJVDvbqP5i3LwllSRqmeIvi83jPhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElC5+4YJI1mp/X3Cy4Ewm5ezLt1debXFEioBOVFQPm4=;
 b=TJKkeGRKmRXuknW8gKVkXRudfNr5rc81/GShRYPRRToXsUJQc9311owr92PH52bgd2/wLHtTTjunh/1lLkVCQfGYlnrvDUpJyXpmFnoRJMjKMZiosns7ylW5dcn+EN34AkVRjtfs4nceGJNTX+IpDMj3ojYNTl7KE1qoOzl/tbE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3464.namprd13.prod.outlook.com (2603:10b6:610:2f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14; Fri, 15 Oct
 2021 21:19:46 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%7]) with mapi id 15.20.4628.011; Fri, 15 Oct 2021
 21:19:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "legion@kernel.org" <legion@kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "sargun@sargun.me" <sargun@sargun.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] Fix user namespace leak
Thread-Topic: [PATCH] Fix user namespace leak
Thread-Index: AQHXwRUCls3rJyO6tU6m4BcHvce8wqvUI8wjgABuyQA=
Date:   Fri, 15 Oct 2021 21:19:46 +0000
Message-ID: <981ccefced19e68cd55908572de45fb5dc29fe34.camel@hammerspace.com>
References: <20211014160230.106976-1-legion@kernel.org>
         <87o87qxsay.fsf@disp2133>
In-Reply-To: <87o87qxsay.fsf@disp2133>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56121ea7-bd56-40f5-8887-08d99021839e
x-ms-traffictypediagnostic: CH2PR13MB3464:
x-microsoft-antispam-prvs: <CH2PR13MB3464E5A3A58295855FC8F6F3B8B99@CH2PR13MB3464.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0aIYYESjnWlHSw0P1o1H4bxVpk4ei6Zu4hg5RUlsjtAFZPLGiw6mzjabtmNIpAbcZ7dSSEMHFCn2PU11snl0ruP49/8HRoreizZfgBJ3gVpCbx3ed6IXpq4kLyti3WLLktXbAfxkSAfgeMc2amSUQCbGM19lTsSXaWmD/i5So72X6b0dvc5+wO37u2vw+cSiuptHWPKUQqyfhKbrG+E6SX2lVqIqnXcedG4Jc0DDTrkGF+NCrbNF7L8u8Qaz8czr7cGgSAug6iqfWgMMNbCMNdHAOwWJHX4Nd7a912ZY+ZzizE9F/xwIgR85hlhkQ/hpZtFDnjT7VlxlUilUEepunabHAH2HdqhSBRQH88EpHs2SbWKK5EUadLwyRu7GmE9yedID2HiPJpoU04gQHuC4nLFwVVMHw3ZifMLZiWEut+OUzZ0w63ZvjqKMNnmBwA/eunHWi+sh+tyO+mXRTTNKQubVHZ/bZpDBQxVzevk9Mmspi7RFr0Z82roLpxGEVSwuXA0iDLqjsAsQnGx6h2WHlh+/qUpoGlctiCro+btbkd8CtwBasPi10JqqL9GTl8F3z4+pafyrUBzI3+Wo5+cbr2WDeC4I5+/J+8mmaHrxHO0qspZKF3tK89LdcHpaD0Pdl8rECKsXn+dbJ6Ab+Q8dnoW8xplOkK3QSWAdmFoFsNP1vB6i6tovRhbCofZDPCpb4RvSnurMebz09BOvzQU2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(110136005)(66946007)(6486002)(5660300002)(316002)(122000001)(86362001)(8676002)(6512007)(186003)(26005)(2906002)(4744005)(8936002)(66556008)(38100700002)(54906003)(36756003)(91956017)(2616005)(66446008)(4326008)(71200400001)(76116006)(4001150100001)(83380400001)(66476007)(38070700005)(64756008)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZytYdVRNV0ZDYXZuVFU4T1R0NVdLdEpwWkFoNE95V2poZDFmckJteXc5Vis0?=
 =?utf-8?B?M2FUcndXR09neWh4SGt5bk8yTVBzZGVCcVpuOXRhRmlWSXowdng0WjNuN2Rl?=
 =?utf-8?B?T0k1QStxT2p4b0ZrZlhDM0NnVlVxUGtyNzFRalhMNitkQjdxM0QzVTkydVVC?=
 =?utf-8?B?QnJFR0tWTVh1UXdwcld5Z0crM01nOGppOEFvWUprSTd6K25UYUlLazFPNUFy?=
 =?utf-8?B?MHl0am9adDNMUVc0U2ZkaEJuMXh3NVRyM2dERU1VYkRlcVJXOU1oN2JCSitY?=
 =?utf-8?B?M2JaRU96b1RiRTU5N080alh0R3lmMnBRQjhDdW93YWdiQmM0RStEMlZoSG1L?=
 =?utf-8?B?NmlyaDRxeVhEaDFTRUdmaE40MEdwdmk5aU1BQklDL2ZmT3VlTkc5L2dSc1ov?=
 =?utf-8?B?a2pUb2VPZUxzakc4RzYrUE1Vb2tiRWR3bU03SFozblkrYksxV0NOTlBlUWRh?=
 =?utf-8?B?em4wS1BsTVZ2MU55NkJIQWZ6ZmFpaUFtUDA4RDJjVitBamxucXNpZkJ6VGIy?=
 =?utf-8?B?Z3V5OHQ5WUFseVpUeHdCSVFsR0ZzamxTQ3llanJkZzcwMDd4S3RRQW5yNWxY?=
 =?utf-8?B?ZkZVZmlSVnRadEV0aFBxTGZkNWQxQU5jZWtaNENCdDRuZ3RjcUJJZlZtMVI2?=
 =?utf-8?B?dmhRdk5tclRra0Jhcm5OYkVrdWsrV3ZzOXk2cW0xaWlydHovUlFjS1pIL1BV?=
 =?utf-8?B?UVRvenJhRU1Ud1VYQzBkcGpaeWhDWTVMOGFJMEFQcjJSR0tnUnh1THhadVVo?=
 =?utf-8?B?K2dYRElwVFpqSzFWV3VTZit0V1hNVGNlZkt2UFJtSDNyeW9vWWkxREdXT2c3?=
 =?utf-8?B?TWI4OFM1eFdQb01vOXNUamhDMTRvb2RvSlBXVDBXZVc0SGJnWUtYZmo4aCto?=
 =?utf-8?B?eVZtMUFNbENpQVBRcFJZM0pDWHA5VFdENEQ1NzNwa2tldGxSY1R4QWYzRXhU?=
 =?utf-8?B?dWErNmVPVzdXTmhQdnNaYXlFM3liandmUklhcnJpNURXQTRRRkEwdTlXZS9T?=
 =?utf-8?B?ZjNYZVc2aFUyYWxKUTl5Vi9xY00venM4aGc2UFhFY2I4S2lsS1VoYlc0YXk3?=
 =?utf-8?B?L2xIMTIvNFFad09sbFpRYm1mQWlEWGRTb3Z4dzJHR0JUYVd3UlRSTVpYK0Er?=
 =?utf-8?B?TVBqK2hIcXc3VzVyK0UvbXdaZWREYjBHNDdBU3JPM3cyNFVCM3A3aXlsMlFq?=
 =?utf-8?B?Y0VQbWNVOTN0WTZFSUl0UHNqbWpSL0hBd3A5WDh1Q0VvbmhuaGdESklrN1Ir?=
 =?utf-8?B?NzZMSXRwVmYrL1dlczVkQUtxQmhwdXFLNTBEd1JLNUlXQ0NLNVFIMDAwbk5v?=
 =?utf-8?B?U00wN2poaXk5YVEvMXc1cXZ5Q0JoR0Zxd0RUZWR3YUNPcDhNVWEzemN0Y2Zl?=
 =?utf-8?B?N01wc1lzNitnMWI5Qk5hKy9YVUJwaWJld08vd1F4dXlmczdGdzNrTTZuUTZh?=
 =?utf-8?B?aG8vajZGcWFoVmd3cFArN0N2akg2Y3kwTTBKMDJvZi9POEFaSmQ3MlRqdGky?=
 =?utf-8?B?K0dzYnRiaVlTTkxKY3Bsb0NmZGQwNDFJUWxGZVJRRm84enlLTUJhd3NKOWQy?=
 =?utf-8?B?OS9GUkFGT2Fla3dZWnlGNVVoSEFZelpRMVlIWER0NXZ6cUpRQWpLTk5wblAz?=
 =?utf-8?B?OGg1dFpaZDJ1V29lRXZELzlMVzAwa2loMHdpKzRlblFMeXYxQVZhM1d5QWdJ?=
 =?utf-8?B?SDFnaGVMWjJSRTd4NzgvcWFjQjM2QUp1Ny9CaGszYWhqZUpHei9BbGV4M3Bp?=
 =?utf-8?B?ZnF3VWkwTyt3MHllNUI0cGJRdFN2dkdzT08rL2ZVMmdEV1Y2QTVBQmpTR0gv?=
 =?utf-8?B?YzlXSDRHOTZnRFNrbUZJdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EB8E65E715A1143B3EBA59AE95A4D2C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56121ea7-bd56-40f5-8887-08d99021839e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 21:19:46.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEm4eBRtY+zreeDYoLUCEiRD3/ycrb/kbJAuNQpjXK6E6d4+B8NuN05l3djoWHfSQYqmSBWk9oFCW23WYfsLxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3464
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTE1IGF0IDA5OjQzIC0wNTAwLCBFcmljIFcuIEJpZWRlcm1hbiB3cm90
ZToNCj4gQWxleGV5IEdsYWRrb3YgPGxlZ2lvbkBrZXJuZWwub3JnPiB3cml0ZXM6DQo+IA0KPiA+
IEZpeGVzOiA2MWNhMmM0YWZkOWQgKCJORlM6IE9ubHkgcmVmZXJlbmNlIHVzZXIgbmFtZXNwYWNl
IGZyb20NCj4gPiBuZnM0aWRtYXAgc3RydWN0IGluc3RlYWQgb2YgY3JlZCIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogQWxleGV5IEdsYWRrb3YgPGxlZ2lvbkBrZXJuZWwub3JnPg0KPiANCj4gUmV2aWV3
ZWQtYnk6ICJFcmljIFcuIEJpZWRlcm1hbiIgPGViaWVkZXJtQHhtaXNzaW9uLmNvbT4NCj4gDQo+
IG5mcyBmb2xrcyBkbyB5b3Ugd2FudCB0byBwaWNrIHRoaXMgdXA/DQoNCkl0IGlzIGluIG15IHRl
c3RpbmcgYnJhbmNoLA0KDQo+IA0KPiA+IC0tLQ0KPiA+IMKgZnMvbmZzL25mczRpZG1hcC5jIHwg
MiArLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0aWRtYXAuYyBiL2ZzL25mcy9uZnM0
aWRtYXAuYw0KPiA+IGluZGV4IDhkOGFiYTMwNWVjYy4uZjMzMTg2NmRkNDE4IDEwMDY0NA0KPiA+
IC0tLSBhL2ZzL25mcy9uZnM0aWRtYXAuYw0KPiA+ICsrKyBiL2ZzL25mcy9uZnM0aWRtYXAuYw0K
PiA+IEBAIC00ODcsNyArNDg3LDcgQEAgbmZzX2lkbWFwX25ldyhzdHJ1Y3QgbmZzX2NsaWVudCAq
Y2xwKQ0KPiA+IMKgZXJyX2Rlc3Ryb3lfcGlwZToNCj4gPiDCoMKgwqDCoMKgwqDCoMKgcnBjX2Rl
c3Ryb3lfcGlwZV9kYXRhKGlkbWFwLT5pZG1hcF9waXBlKTsNCj4gPiDCoGVycjoNCj4gPiAtwqDC
oMKgwqDCoMKgwqBnZXRfdXNlcl9ucyhpZG1hcC0+dXNlcl9ucyk7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgcHV0X3VzZXJfbnMoaWRtYXAtPnVzZXJfbnMpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBrZnJl
ZShpZG1hcCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBlcnJvcjsNCj4gPiDCoH0NCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
