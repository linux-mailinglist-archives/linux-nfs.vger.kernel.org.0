Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E904838BF
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 23:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiACWNt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 17:13:49 -0500
Received: from mail-bn8nam11on2134.outbound.protection.outlook.com ([40.107.236.134]:13793
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229525AbiACWNs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jan 2022 17:13:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNdHiC+yXFa+6hJ9B8t8KOS515X0cj5X08gONXPLGmLcEzkM7YI5JQhNuIBp0nPZZL9qqBEBf+HQOp5xlYWw52WVnsXdNO5C2lGuOasTTyfqzTt1aLDXxY7gahaxAOj7HRFLoOWUPbo/YEe9uh9bk0z8Gre7U9Zq3sr1Jm/1NS+FqUeg82XkBvNebegLA7tIFByjDMnp3jsoWUtezAVzJD5mmsMCW8VJgwHbaqYE3xiCO5gPR3BSOTHLSdWK7KU61B1J4Sy9UGdYrdcHgZWTVP3HGfl5BABON6Qo69AsS4be10jU73vyh0LbF9Si+jBqvdgZ2TS5HcV3D/VoTu4QEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFl2tFFftWqyEaENExGsMMXDYilNmsDZ/YNT3iv6UHg=;
 b=ESFMpIUc/uLR2hqwg9I5rdTIN15cut0XH2eilvvcAF5KCd+HBwIdiPscEjqSLHWJ1a60IljxkAXUOTXaGSiqHFCLqW5VkhNpnFNEnfs0M8ambpMPaL95J+YgCW/tcxn/Pe9Fq157SGJLNCZBw47MzfAT6JLSfEGvMPEYNrrGFHrwemnK0L7P2SpNtFt0W6hocGkVppwNhuj64EZd0MPmA2iqV8oSY+6r97MdkYXC7qXwB8PshM/t4IBwwe8zMgvHHFAfk4WJ7lmxfh7QSmmX7PsY7SQvY1N1IZxsg7CT8pWjNP3Mh9n8pj0AzxM0sBPsRETx9F2uBkPvhFwD8WUYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFl2tFFftWqyEaENExGsMMXDYilNmsDZ/YNT3iv6UHg=;
 b=gGjSRtCYDJDxt3ObUBSNfSqlUJEXZIKg6hob0OA5NHGjQD1pMurcDifb356zVJuuG+jGOibJg7ThQWj97w8fjP4NXcD/ZsbiA9PAsIkqF9IpNa58SIf5YjzfC45x/jhzfVDPjlC8szIKBsNgSc69M21nczIbZMdGqMMSGbO8dpc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4913.namprd13.prod.outlook.com (2603:10b6:a03:364::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.4; Mon, 3 Jan
 2022 22:13:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.006; Mon, 3 Jan 2022
 22:13:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/5] Support case insensitive filesystems in NFSv4
Thread-Topic: [PATCH 0/5] Support case insensitive filesystems in NFSv4
Thread-Index: AQHX84bH/VRHsN5KMEWL2EjK4fwOv6xR1GCAgAAA4YCAABpqAIAAB5oA
Date:   Mon, 3 Jan 2022 22:13:42 +0000
Message-ID: <9d70f0d2d4adadbc843c6ee7f24edc82403cd67f.camel@hammerspace.com>
References: <20211217203658.439352-1-trondmy@kernel.org>
         <20220103200847.GH21514@fieldses.org>
         <cb2b119e0c95c8d9d783d8b28c7f2bc7973f7598.camel@hammerspace.com>
         <20220103214628.GM21514@fieldses.org>
In-Reply-To: <20220103214628.GM21514@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf1ba103-7e4e-4edd-c783-08d9cf064d9b
x-ms-traffictypediagnostic: BY3PR13MB4913:EE_
x-microsoft-antispam-prvs: <BY3PR13MB49134218606791ED4ABF5E57B8499@BY3PR13MB4913.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZSlwqCgamdgbRJt/CEBZJgJ+0O2Q9JVcCPNtJ6f+ExdL15Vkq6W5/f8DeuPYm+je9fvwe5wM6beBiePS6AkR7SeigXnhIeZUpgp4VpYy9+/zMK/VMtkdo3vXmzSSZ3xyJV/5Wz09MS6pi8ZUSn72ohHtCAdKd7hURUdKFthd1Qd5x5udBY0rj8fM7gE48gsANDoxowZY1u9pqyE2ExYB9W09ag4VafFS3Gho09TsNJaybfPnTH6BsoHyB1uqxS7ZS8PmQCOy5xIRqGMrJyXaQHOgouzBKIvdslveXY0C+X71eupdacMxU5PEKquxRSAPXdPbw7SD5WHuNkgfkVcbkBFa+pQpdiKNHdN0D+B+aJEoLVOibTyLuE+PwrCXvscewOI9Kx58YZp0K0KmhBft5w6TRbSUlEANQ5bReuqDfApsAuoDreyP1qOQkalzTJkpJeslNzNauc8ft6eYnq7MkfXg3UerK1abTC1EZqnbFBXDWfd1SP7lAdPOn6cHv2el10ap3mt1qWG0v3lBGowsmu5S7B80uYZ9KeU1sDHw4l7ETAXjLtfhDvan7qoxtBpOQNmVXl7X2Rn2MSStOpMfspJ7hlR2SQwGnj/9J8g7XLhU52L7xLF998otYVTJYbQXL/rd+KpuP28cDOtPR2FEnd7UUc9ZeZL27aFA8Wu6tPxKZoVRsnkggKMHAcHW31m2tyNi1cG1uVAYzPJrgCHyLXp7LwmXZiVBbXBCPsoXICUjR/d73N1te9afO6v9yxn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(346002)(366004)(136003)(396003)(376002)(8676002)(122000001)(8936002)(5660300002)(26005)(6506007)(2616005)(66446008)(71200400001)(66946007)(36756003)(86362001)(4326008)(66556008)(38100700002)(64756008)(2906002)(186003)(6916009)(508600001)(66476007)(38070700005)(76116006)(83380400001)(6486002)(316002)(54906003)(6512007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUpmeUNoL2U1a3dwQ3VIblhBREp4REJIUm0raHNsa0VRN2Z2U204L3ZJQVNU?=
 =?utf-8?B?VGVpQ2toUXlZNXhHc2ZwVkxjS1FwVDZqdFd6STFKVW80TzArN3NUUDZleVY5?=
 =?utf-8?B?MmN1VENkQzBtMmdUckZGelptcGJXVnRxUHV4WE5meDh6QjJRYVFUMlg5MFA0?=
 =?utf-8?B?cVgzUVhRZWZEMTEwUXBvemVBb0JZNkNqUU0xeUF5SmhUY0xOMkttNWJaamZG?=
 =?utf-8?B?WVdaZ0VvN1RyZGtqVFFPK3BFbWpuTVNmMGwvanYwMjdpdFFUZTE2b3I1aTZW?=
 =?utf-8?B?akZxWTZaVlIzak52Y2hOd3ZWcnlhWlA0MWJjWU1Cc3BjbGViWWd4cDVQTzRj?=
 =?utf-8?B?Q1FmU3RBNE1CTXdPeE9PQlVWRFRGakJyQlh0NDlnYWZ6VUdiUzBNWDVxSWcx?=
 =?utf-8?B?SG5uZG9VaHQyWlhrMUJQRzJJS01RQUx4MmJIbXc4S1NNazhDSkJDWEovLzRB?=
 =?utf-8?B?Uk9DbVNYZm9wenNzNjhZQUVkL2EzQzRZQ1ZhaTJ1NldUUFMva1ZtUFdMbWtr?=
 =?utf-8?B?Tit2WEpNRTVQbkwrU2VXYndTNVR6RVdNUEVPSEVEWnpqODlkZXNWZGpHT2Zv?=
 =?utf-8?B?THo5allJZTg3bVJNQzhBY3RzWU1rM041S05TaWt2RFNjYXhGQ2ttM0VsMXFs?=
 =?utf-8?B?NTFKZWlJZ3padFRlWmZ3b00xUFJJSllQOWZ2ZHloV0dmb2NhWmV3RFdUcEZt?=
 =?utf-8?B?aHNmSG9QUE5ST2duNFpZY1FCWHVFOUJQOXlSOUl6SlpXNTZYemoxYkdxbzhz?=
 =?utf-8?B?bGJqSGpJaEkyU3oxc1RsbWI3RlNmMnViT2Y2czFETmFBTGIwU0Jzd3pMeUov?=
 =?utf-8?B?cFZwMENhOXJyWmd1UUJiZS9qWEpnSzBnOFliMkplTG8ybmZwaVpmV2JlY1Ri?=
 =?utf-8?B?eVgwdWtMWHRleEQ3alNOV3gvanZvR3RLdkFJQnVGWFY5blBjWVg0eUJ3UTBQ?=
 =?utf-8?B?cnNVaWRVdmlReWpBRjVaTWU1M0l1Wm9BdHBEQldqS292MndwREV6ZVI1R1Rx?=
 =?utf-8?B?OTh6RXpQSnpzUHJVQjA1bGFuc2FzYTZGREVXZ1JjOVQ1YzRPamVETU1jTzAr?=
 =?utf-8?B?QjdWNkFKbVc1REF3dW9tdUdYOUh1Q0x0OWlFNEZWbFhuNlA5VEtoQWJuQkgv?=
 =?utf-8?B?VXpXYWRtNkRYdmVuRVlvTTE0MVZGTGpqOEYvTk9NVE1OaE1sQXRVS25ydWNU?=
 =?utf-8?B?WWhRQUhIeE04YkFWUmplUzIvNHVvZkZldFJJK09KdDYwWWE2dmIzM1ZVRGhY?=
 =?utf-8?B?V2NjUG81UHRTcVhNc283ME5rZXl6dytWUlBjSmtOLzRBKzN2ZDV6ZnJCdElu?=
 =?utf-8?B?NU9jcHpEcnlad0RDWmJIWjZ1ZUMxdWlaQzZkaS9NNFlsNlpXdUZKMnR2eXlL?=
 =?utf-8?B?KzVkdDdTNVR0OVpKRzdoM1BwMk9MRHNyR1g1LzNYRm9zVFpPVVdVK3dZUkhN?=
 =?utf-8?B?M05YTnk2ME1yTVRmclN5bnFnZmtQRmVDVlpBUE5OeWZ0L3lGdU95WGtVSVRv?=
 =?utf-8?B?d3NSM3ZZQWIybUV6cWQveGVma1FlckdzdmkrSzByYi9kcTdqYXQrK1pKVUlR?=
 =?utf-8?B?UFlmdUlTcHRqUzNLaUs3RERxV0lBcndZQUpIbkRsejNUMGNidjcwajZwdVl0?=
 =?utf-8?B?TE5ZRGpjTDd6RG1Pc2dtMk45eVRlYWpWTXZwTFo5QlozditlRGwySWFvTUQ1?=
 =?utf-8?B?SVNxVjllNmhKS1RCYkZoVUh2aDJrYXlsVmZiZ0hLSkRKdWU1b1JIUFdzck1s?=
 =?utf-8?B?TmpXanNELzJDWGZpSElVaUFsRlZGcy84Z3E5RGFCN0lSUERMbXBUeGZMUHll?=
 =?utf-8?B?Z1RTRDhpNmlCZHg1UW9uUXdXOW9yYVBWTUxpbU1JU0VDU2EydUFJKzRha1Vn?=
 =?utf-8?B?Mkw5aHVrTmV0WjM2Z3BwQWNLUUtFMjgrL0NhN0NLQzBTbzYybjg1Uk9sNjhk?=
 =?utf-8?B?azAwcG41VnhUQjVhNWxhWGFJRWtEbWJ6ekV6Q0lWRFFuZmQyOHRSbUdVYnUr?=
 =?utf-8?B?RDc0cHAvaGFVM0tnQytTREthekVFanNlSjRWT24yWkxyVHpBN3pIUStjaGxq?=
 =?utf-8?B?SjVsQmFGNEl0NU03SjY2a1pocGJmbmZIbENXYVZHR2kxQVloL0hJNWpxSkth?=
 =?utf-8?B?c2MrTTh5NFF0aHFRb0YvYzNEK1h1YTR5WFUrRFY0V21HU3JZa1hmRXIrSjBF?=
 =?utf-8?Q?u70oO9ewHtIgRqB6Bma3BiE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <435E7C11AE08724F948FDE55B86B4BC8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1ba103-7e4e-4edd-c783-08d9cf064d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 22:13:42.7299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8asEKW7iEkuGgIrP/B3rMNEeGOj/rD8WW5l7sE2Nz2FIFjdaNH3yEfZXiKoETxcxzO7oCRMftadYFpnJhPT+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4913
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTAzIGF0IDE2OjQ2IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gTW9uLCBKYW4gMDMsIDIwMjIgYXQgMDg6MTE6NTdQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMi0wMS0wMyBhdCAxNTowOCAtMDUwMCwg
Si4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBEZWMgMTcsIDIwMjEgYXQgMDM6
MzY6NTNQTSAtMDUwMCwNCj4gPiA+IHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+
IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4N
Cj4gPiA+ID4gDQo+ID4gPiA+IEFkZCBzdXBwb3J0IGZvciBkZXRlY3RpbmcgYW4gZXhwb3J0IG9m
IGEgY2FzZSBpbnNlbnNpdGl2ZQ0KPiA+ID4gPiBmaWxlc3lzdGVtIGluDQo+ID4gPiA+IE5GU3Y0
LiBJZiB0aGF0IGlzIHRoZSBjYXNlLCB0aGVuIHdlIG5lZWQgdG8gYWRqdXN0IHRoZSBkZW50cnkN
Cj4gPiA+ID4gY2FjaGluZw0KPiA+ID4gPiBhbmQgaW52YWxpZGF0aW9uIHJ1bGVzIHRvIGVuc3Vy
ZSB0aGF0IHdlIGRvbid0IGluYWR2ZXJ0ZW50bHkNCj4gPiA+ID4gZW5kIHVwDQo+ID4gPiA+IGNh
Y2hpbmcgb3RoZXIgY2FzZSBmb2xkZWQgYWxpYXNlcyBhZnRlciBhbiBvcGVyYXRpb24gdGhhdA0K
PiA+ID4gPiByZXN1bHRzDQo+ID4gPiA+IGluIGENCj4gPiA+ID4gZGlyZWN0b3J5IGVudHJ5IG5h
bWUgY2hhbmdlLg0KPiA+ID4gDQo+ID4gPiBXaGF0IHNlcnZlciBhbmQgY29uZmlndXJhdGlvbiBh
cmUgeW91IHRlc3RpbmcgdGhpcyBhZ2FpbnN0Pw0KPiA+IA0KPiA+IE91cnMuDQo+IA0KPiBZb3Ug
bWVhbiwgaGFtbWVyc3BhY2U/DQo+IA0KPiA+IFdoeT8NCj4gDQo+IFBhcnRseSBqdXN0IGN1cmlv
dXNpdHkuwqAgUGFydGx5IEkgdGhvdWdodCB3ZSdkIHByZXZpb3VzbHkgYmVlbiB0cnlpbmcNCj4g
dG8NCj4gYWRkIGZlYXR1cmVzIG9uIHNlcnZlciBhbmQgY2xpZW50IHNpZGUgdG9nZXRoZXIgd2hl
biBpdCBtYWtlcyBzZW5zZSwNCj4gaWYNCj4gb25seSB0byBtYWtlIGl0IHBvc3NpYmxlIHRvIHRl
c3Qgd2l0aG91dCBhY2Nlc3MgdG8gcHJvcHJpZXRhcnkNCj4gc29mdHdhcmUuDQo+IA0KPiBJIGRv
bid0IGFjdHVhbGx5IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBvbiB0aGUgcG9saWN5LCBidXQgaWYg
dGhpcw0KPiAqaXMqIGENCj4gY2hhbmdlIGluIHBvbGljeSB0aGVuIGl0J3Mgd29ydGggbWVudGlv
bmluZy4NCj4gDQo+IFRoZXJlIHNob3VsZCBiZSBvdGhlciBleHBvcnRhYmxlIGZpbGVzeXN0ZW1z
IHN1cHBvcnRpbmcgdGhvc2UNCj4gYXR0cmlidXRlcw0KPiBzbyB0aGUgd29yayB0byBleHBvcnQg
dGhlbSBvbiB0aGUgc2VydmVyIHNpZGUgd291bGRuJ3QgYmUgYSB3aG9sZQ0KPiBsb3QuDQo+IChC
dXQgSSBjYW4ndCB2b2x1bnRlZXIuKQ0KPiANCj4gLS1iLg0KPiANCj4gPiA+ID4gDQoNCkkgZG9u
J3Qgc2VlIGhvdyBpdCBjYW4gYmUgY29uc2lkZXJlZCBhIGNoYW5nZSBpbiBwb2xpY3kgb3Igd2h5
IGl0DQptYXR0ZXJzIGlmIGl0IHdhcy4gV2UgYWxyZWFkeSBoYXZlIHBsZW50eSBvZiBmZWF0dXJl
cyBpbiB0aGUgY2xpZW50DQp3aGljaCBhcmUgbm90IHN1cHBvcnRlZCBieSBrbmZzZCwgaW5jbHVk
aW5nIHNldmVyYWwgcE5GUyBmZWF0dXJlcywgcE5GUw0KZHJpdmVycywgTkZTIEFDTCBtb2Rlcywg
ZmlsZXN5c3RlbSBtaWdyYXRpb24gc3VwcG9ydCwgdG8gbmFtZSBidXQgYQ0KZmV3Li4uIGtuZnNk
IGxhZ3MgYmVoaW5kIGluIGFsbCB0aGVzZSBhcmVhcyBmb3IgYSB2YXJpZXR5IG9mIHJlYXNvbnMu
DQoNCkFzIGZvciB0aGVzZSBwYXJ0aWN1bGFyIGZlYXR1cmVzLCB0aGV5IGFyZSBvZiBpbnRlcmVz
dCBmb3IgTGludXgsIG5vdA0KanVzdCBmb3IgaW50ZXJvcGVyYWJpbGl0eSByZWFzb25zLiBXaXRo
IHJlY2VudCBjaGFuZ2VzLCBMaW51eCBoYXMNCnNldmVyYWwgZmlsZXN5c3RlbXMgdGhhdCBlaXRo
ZXIgYXJlIGNhc2UgaW5zZW5zaXRpdmUsIG9yIGNhbiBiZQ0KY29uZmlndXJlZCB0aGF0IHdheSwg
c28gdGhlcmUgc2hvdWxkIGJlIGFuIGludGVyZXN0IGluIGhhdmluZyBrbmZzZA0Kc3VwcG9ydCBp
dC4gSG93ZXZlciBJJ20gbm90IGdvaW5nIHRvIHZvbHVudGVlciBlaXRoZXIsIGJlY2F1c2UgaXQn
cyBub3QNCnNvbWV0aGluZyBJIGNhbiBjb21taXQgbXkgZW1wbG95ZXIncyByZXNvdXJjZXMgdG93
YXJkcyBkb2luZyBhdCB0aGlzDQp0aW1lLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
