Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6651B4434A0
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 18:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhKBRjB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 13:39:01 -0400
Received: from mail-dm6nam10on2096.outbound.protection.outlook.com ([40.107.93.96]:33632
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229684AbhKBRjB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Nov 2021 13:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsJ8JjAGuyyk+lI5gjzFV0ZbxmcbKGitlDfFNOraL2prs1m2+KwQ6EfqCGh/faGA3icmTva3Ceedk2yb1AfYKqq90jXWNF7fR+O9nygVaCBiaqVGjy7OxjTdfA0tarxw42nd9XGkBZHEFCE3eQ5ApNzw+Ir31n7t2CxLWn9KEOiVuO7HtyYgldgb/AVL/r4nJtQ3eeIG0VeUJ63gv695n55zAnT64YI5T/xN1+43Tb0SHkeI2kSMjbceeOq7FBNQihtSAFLyaOgvGMzb1GV5GZsKFEm+Pt0oLq4vAIiFj7tUjxzJQs6wmotbjYa/MY1TNCQm6OwCJoXV4p/31ZgMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjAUMOA18bLD0dzqWHx0Vu76qkyGmxCeudYQ84af43w=;
 b=BXVXcb9MfupkeApW2YhZqOZwPLT789X7MtwujTdb2CeccfRHwnt7ODsec4q/d5Pu6MHgs1u33gwdp5+GekLVF++9JfJ6qFKp43Qap4RquGqcGKM/W6yrzAl0jC5lICsR2IfBYVNzjdHdhsbwfWpKYzsEzYeVlqzVd7q+q683yl4AFJZ9oY97zFlqPDqz9j3sXS6DLCcVCGcYtNJCWpb7aE6vL0lmueXbVvTlmPJxUsVvw+o1EeuE4u7f3iPNRK/skU1bzyHKkTx3n/nekydak2wwnCmlrraCFEclHHRMgBn/YxQxK0yadGB/CM0r8WJBF112UiVwx6azUoEctLyZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjAUMOA18bLD0dzqWHx0Vu76qkyGmxCeudYQ84af43w=;
 b=MGaZirFE3NsLE/igKn7Qz1fH9je0LsCkqJESQ5z7J1Zom77oUv538/VlkSYJVYZ995Gt+OZtpeQEsLyZkluGuLo4kYCJPhLCNY3/FeFNIHkCLqHFsIjr32lSAOBJ6WTucheJI6EC7x/TOWStIFJVM1uh7hFNsm5ifgTQB0sp4vk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3400.namprd13.prod.outlook.com (2603:10b6:610:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.6; Tue, 2 Nov
 2021 17:36:24 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%8]) with mapi id 15.20.4669.010; Tue, 2 Nov 2021
 17:36:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH] xprtrdma: Fix a maybe-uninitialized compiler warning
Thread-Topic: [PATCH] xprtrdma: Fix a maybe-uninitialized compiler warning
Thread-Index: AQHXzlh3SGRbXHO8skq2kgQzcxhtKKvtNIqAgAM/IoCAAANCgIAAC4IA
Date:   Tue, 2 Nov 2021 17:36:23 +0000
Message-ID: <766c8a27f5d17495a8c79df64310a6caa284b7db.camel@hammerspace.com>
References: <2b32d41cf6a502918a685447cd749c4b1cb0d16d.1635685588.git.bcodding@redhat.com>
         <3EC776BC-8E37-477B-98BB-C9DE163EFA52@oracle.com>
         <d29f109c50126168ed83108ed4297c56771070ce.camel@hammerspace.com>
         <72A2B417-F76C-4896-AD91-77226C25BF74@oracle.com>
In-Reply-To: <72A2B417-F76C-4896-AD91-77226C25BF74@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de356123-147f-43f4-92ca-08d99e274a89
x-ms-traffictypediagnostic: CH2PR13MB3400:
x-microsoft-antispam-prvs: <CH2PR13MB34001C5434075A0B0576BF73B88B9@CH2PR13MB3400.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1pW75Zzg2mjntyYR9sEwCLvC5eQ1JvsKoehi8U1x4YjQkQgsk8O4CiFLECTpvW3YzRlK1SpT7BgKemBy3YjwDaWtHwIGaWoU1xSD7yK6YTh0r3a/TObApmlEW+xzG30VtWhoBHbEs4gHp6sPapPHnFbavN10CsyvVO2bhHR6/91x//EvJM7QNog2LdpkM/fpV82HtX3sXaxnMSyo30aeS100xTDv6g5FRDSmmZ8sV8VdDYfnKst6TlOHiE8jIabWRhPE7gtC1tVsLO3BKxYIhGZVdQh02x6PsIyYJ+tDeZ6wWUtGg+MIPjAN8yo6JpcfdHCD6qrAH90uDqhau9c/dgR/noYaMfYARDGyINx6WFbi2oWrAv+v+4jPcTKaLELTTTbYE6hcv17duj/utZOyiJSn66lNjrCuiisuTZyWSt4umn857B0wR8clY55mpZPQc9U209hBYMjIeSwDW7bKLkHKgKI5uAqBAcSuAzBQsFY8zXGHfTG+nHH7670SWMnvmEkwgCjLBV5bp/pc56DrMkTWPr/U7avOUntoh+jYhvOE5rdKzEO8ea5IXp8lkfLcgmVF11/j5T1IekeO5pD4D+lIje0dBWITced0LRXDjcleCChKRsld+kbA2AB7B8+z1+BkuDOEs5dJ3YQV9lbPrzEC2LYQnfNoGBEOxXAJqbH10wqmM0ODAlD9aMNjjf546DfrkoZVQIzDgv+ebm5amNuH2+HWnXFZZgfl3uQmAKYiLkSl/QhvVqSe5rlURueXI/DKAvpG3duMXDi5lnYn813oFkGPkpMFQrql7osPB3c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(54906003)(71200400001)(4001150100001)(6506007)(15974865002)(66946007)(66556008)(8936002)(66476007)(6916009)(316002)(66446008)(64756008)(53546011)(8676002)(122000001)(83380400001)(38100700002)(4326008)(186003)(36756003)(86362001)(5660300002)(38070700005)(26005)(6512007)(508600001)(76116006)(2616005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHJxZUs1R1doNXpHOVIrTDJycjQ3QUNpNFRnSG1tL0V3NG9iV3NwcnRPRFpa?=
 =?utf-8?B?YisrbzN4MlVad0NRbzI0bklvaUlHclY2NVV4UmJ3d2dvZmNsQXN4Tm12NDFC?=
 =?utf-8?B?c2lYNXdQSkZvVDhhV3Q4Nll0YzJ1NUJmaWZmUDVscDRON1pTYTRHcHptRUJY?=
 =?utf-8?B?N3k5QjVUdWJia3MvWnQ5bmsvOXV3QkxkUnlCQVcvQm83N2Uvd2lDS1RpWkdF?=
 =?utf-8?B?dVd2VWx5TDJKRVBMSGFGSDBqMW50K2JXZENaTFVEMU1oSHlJUHk2a1dZVVJC?=
 =?utf-8?B?blVlNUpBKzRhSm5lVzc4Rlp0VUNNZVFSQTNWRTRaWE5jT2lPM2hyMVRmSlAw?=
 =?utf-8?B?dnF5a0dJM0JyTjFScU1YMFRGNjFnOFUyU3BTOG9PUEdSVllWWkt6VjZmRkFZ?=
 =?utf-8?B?ZnJHUXpsa01XMmVrVlVjMjFJQm92dkxpODVxSXhxMGlnTHBqMFExKzJmb2hw?=
 =?utf-8?B?b1h6OHFHNkVLc3dGQ1pwY0hNZUUrYTY3NEZTZ1N5eTRiZDgwVWQybE1iSTlm?=
 =?utf-8?B?SnRYSmZ5SDdWNFUrbFA2RXNuYmFpY0ZWTm4wcURQSG9XSjc4MTQ0NVZVNHJF?=
 =?utf-8?B?OVV1WXZJL21sZWlNWE05YlNYWEJWdTVHZ1pvNDBIY0JSUFBjc09MM3VCWUZF?=
 =?utf-8?B?WE1FbVp5VWRwd0JXamg0amJyWHB6clQ3YlRuMGpvMjkwVkZ5WElJRGhKemVO?=
 =?utf-8?B?U0xqbERSdjF6QlFrWnpqQ3JWMS84am1takoxd1lNbHRNNE1TWVFhQkl3em4r?=
 =?utf-8?B?Mk1WS01OMXBTTGVydmZtRDVXMTlsVDBUMkMzTTkxU1ZoSnB4b2dGeFgxTnFP?=
 =?utf-8?B?UzhmR3lmdGdYWmYwaUtrMVErVmo1WTNza203Q2l3NS9HZ213b2JaK2x2d3Ja?=
 =?utf-8?B?Und6aHV0dTk5Zld0ek90M29kWkg3Y1pQbnExK2QyOWFWOFdRTWZZcDU0dHdL?=
 =?utf-8?B?TU13Tk9TcFlTNk1reHJCdURCR3RNaytJK2hNSFhmK1JsdTZteWdTeFlFUmR1?=
 =?utf-8?B?b3g5b05WYllrRW5zSk9kRnFtUmhwd1FXZHFxOXliNVVGTVExWmZFRS9GWW0x?=
 =?utf-8?B?N29mRzFIV29VUXkySm1HczFmcVJCT1ZnczYwYWpaSkswN3NrL2VKU2NmaWtx?=
 =?utf-8?B?R292K0dvaXUrcTZhTUtEK2lGYm5iTUZKWTJ1c1pqT2x4OTlhT0c1SmpWNmVz?=
 =?utf-8?B?cEJrNmcrNXdGZGFyd1lTOGZuMS9OVlRISjdxWnU4MFNMS1ltaTR0NU04UnZM?=
 =?utf-8?B?R2hCb1JCRHNReVhjdGh6OXpGNmcyU042cDVmUXpLZjRWdVRQRXZpbStqSVRJ?=
 =?utf-8?B?bUJwVWxmQXQwVzlmbjRCbnBmUGJERjRCWnM4NlREQjNVSzl3cDlZSmVqQWcv?=
 =?utf-8?B?VzFEWTF2N3UxYlNEczVSZzZaM0M1ZFBGVXpBZUZ6K2xGYnlha3dtUkFramlU?=
 =?utf-8?B?QVdRN3diL1BTczAvZUdwbzcyL1dqbGlMWXNtRzZIUTdvSC9heWsxb1hvcUd5?=
 =?utf-8?B?ZDE3OWNOSDBQejg4azNOU2E3WU1ucGEwNFJDOHNQWXNnQVYrczlkN0NjaUtn?=
 =?utf-8?B?SFptT0JwWHRqMGxhWk1LcCs4ZzczdGVSa3ZWQmpLUFpWUktuN1oyem5RODRM?=
 =?utf-8?B?WVBDQkFMNDNMSlFUV2FvZE85YkxKa3lORi9XNnhYc1hYNHlJaDlQK3Z5SVhz?=
 =?utf-8?B?T3F6aE1tTXVaMVliV1kxbTJkQUJiYkxFbWwxRkdFRTBHcEx2OHlSWC96WWJr?=
 =?utf-8?B?bU53b3pGdEhvMTJmcEV4aEhCUFNzRWthNzVTUFBEV2lBT2lSSTVONWpkaG9q?=
 =?utf-8?B?OG9IbFZ4YjMrVE5JbE5qNi9nN3NZM0pOWjBCRkJRTnF3bklTZ1lsQ3hYcUE5?=
 =?utf-8?B?WG04T2dkNmFha285UFArK0xKeEJYQlBqRDhWZTJib1EzMDNpbzFPRFFhaEEz?=
 =?utf-8?B?UXAwcGF1R3JPVFl4Mm5TMVdLdUZoY0hQN2NzWFpRYjNxalV6YkZtWUgrZWVG?=
 =?utf-8?B?aUV1NHpVaDdWakcxTUhmTkJFZW9abk5PelVRRWJLZVFLVlJpZTI3ZUJNd21U?=
 =?utf-8?B?SCtNSHhOb3lTQzNrbzJaeEJvWGVNYW5TcUdaZXI2dy91d2pYZHhpVmtvMTdB?=
 =?utf-8?B?SEx5SHA0eHh1VDg0ZHBNTEo2cTN1aElQZHFXT1V1RmdBWkZ1MEFTb1ZyTi9F?=
 =?utf-8?Q?ptjTK/E41hkU0nctz9P4JK4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <949D0AF2E76E0746972E6426A0AB6D21@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de356123-147f-43f4-92ca-08d99e274a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 17:36:23.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mP/gHF74gg48tNVl5QeDn6ErPkF5/cmuxPLrTXmV42Dm1CjnBjrlS3dVfV5aoF5ngUoBasADr3jDKl/nXsTfsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3400
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTAyIGF0IDE2OjUwICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBOb3YgMiwgMjAyMSwgYXQgMTI6NDMgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gU3Vu
LCAyMDIxLTEwLTMxIGF0IDE1OjA0ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiANCj4gPiA+IA0KPiA+ID4gPiBPbiBPY3QgMzEsIDIwMjEsIGF0IDk6MDggQU0sIEJlbmphbWlu
IENvZGRpbmd0b24NCj4gPiA+ID4gPGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+ID4g
PiANCj4gPiA+ID4gVGhpcyBtaW5vciBmaXgtdXAga2VlcHMgR0NDIGZyb20gY29tcGxhaW5pbmcg
dGhhdCAibGFzdCcgbWF5IGJlDQo+ID4gPiA+IHVzZWQNCj4gPiA+ID4gdW5pbml0aWFsaXplZCIs
IHdoaWNoIGJyZWFrcyBzb21lIGJ1aWxkIHdvcmtmbG93cyB0aGF0IGhhdmUNCj4gPiA+ID4gYmVl
bg0KPiA+ID4gPiBydW5uaW5nDQo+ID4gPiA+IHdpdGggYWxsIHdhcm5pbmdzIHRyZWF0ZWQgYXMg
ZXJyb3JzLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQ29kZGlu
Z3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6IENo
dWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+
ID4gLS0tDQo+ID4gPiA+IG5ldC9zdW5ycGMveHBydHJkbWEvZnJ3cl9vcHMuYyB8IDQgKystLQ0K
PiA+ID4gPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydHJkbWEvZnJ3cl9v
cHMuYw0KPiA+ID4gPiBiL25ldC9zdW5ycGMveHBydHJkbWEvZnJ3cl9vcHMuYw0KPiA+ID4gPiBp
bmRleCBmNzAwYjM0YTViZmQuLmRlODEzZmEwN2RhYSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvbmV0
L3N1bnJwYy94cHJ0cmRtYS9mcndyX29wcy5jDQo+ID4gPiA+ICsrKyBiL25ldC9zdW5ycGMveHBy
dHJkbWEvZnJ3cl9vcHMuYw0KPiA+ID4gPiBAQCAtNTAzLDcgKzUwMyw3IEBAIHN0YXRpYyB2b2lk
IGZyd3Jfd2NfbG9jYWxpbnZfd2FrZShzdHJ1Y3QNCj4gPiA+ID4gaWJfY3ENCj4gPiA+ID4gKmNx
LCBzdHJ1Y3QgaWJfd2MgKndjKQ0KPiA+ID4gPiDCoCovDQo+ID4gPiA+IHZvaWQgZnJ3cl91bm1h
cF9zeW5jKHN0cnVjdCBycGNyZG1hX3hwcnQgKnJfeHBydCwgc3RydWN0DQo+ID4gPiA+IHJwY3Jk
bWFfcmVxDQo+ID4gPiA+ICpyZXEpDQo+ID4gPiA+IHsNCj4gPiA+ID4gLcKgwqDCoMKgwqDCoCBz
dHJ1Y3QgaWJfc2VuZF93ciAqZmlyc3QsICoqcHJldiwgKmxhc3Q7DQo+ID4gPiA+ICvCoMKgwqDC
oMKgwqAgc3RydWN0IGliX3NlbmRfd3IgKmZpcnN0LCAqKnByZXYsICpsYXN0ID0gTlVMTDsNCj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHJwY3JkbWFfZXAgKmVwID0gcl94cHJ0LT5yeF9l
cDsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IGliX3NlbmRfd3IgKmJhZF93
cjsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHJwY3JkbWFfbXIgKm1yOw0KPiA+IA0K
PiA+IEVyci4uLiBEZWZpbml0ZWx5IG5vdCBzdWZmaWNpZW50Lg0KPiA+IA0KPiA+IGdjYyBpcyBh
YnNvbHV0ZWx5IGNvcnJlY3QgdG8gY29tcGxhaW4gaGVyZSwgYmVjYXVzZSBpZiByZXEtDQo+ID4g
PiBybF9yZWdpc3RlcmVkIGlzIGVtcHR5LCB0aGVuIHRoZSB3aG9sZSByZXN0IG9mIHRoZSBmdW5j
dGlvbiBhZnRlcg0KPiA+ID4gdGhhdA0KPiA+IHdoaWxlKCkgbG9vcCBpcyBpbnZhbGlkLg0KPiAN
Cj4gVGhlIGNhbGxlcnMgZW5zdXJlIHJsX3JlZ2lzdGVyZWQgaXMgbm90IGVtcHR5Lg0KPiANCj4g
VGhpcyB1c2VkIHRvIGJlIHByZWZlcnJlZDogZG9uJ3QgYWRkIGNvZGUgdG8gY2hlY2sgY29uZGl0
aW9ucw0KPiB0aGF0IGFyZSBrbm93biB0byBiZSB0cnVlLiBJZiB0aGF0IHBvbGljeSBpcyBkaWZm
ZXJlbnQgbm93LA0KPiB0aGVuIHllcywgdGhpcyBjb2RlIHdpbGwgaGF2ZSB0byBiZSByZXN0cnVj
dHVyZWQuDQo+IA0KDQpJZiB0aGF0J3MgdGhlIGNhc2UsIHRoZW4gcGxlYXNlIGNoYW5nZSB0aG9z
ZSB0d28gIndoaWxlKCkge30iIGJsb2Nrcw0KaW50byAiZG8geyB9IHdoaWxlKCk7IiBzbyB0aGF0
IHdlIGF2b2lkIHRoZSBhcHBhcmVudGx5IHVubmVjZXNzYXJ5DQpmaXJzdCBjaGVjayBmb3Igd2hl
dGhlciB0aGUgbGlzdCBpcyBlbXB0eS4gVGhhdCB3b3VsZCBiZSB0aGUgcmVhbCBmaXgNCmhlcmUs
IGFuZCBvbmUgdGhhdCBjbGVhcmx5IGRvY3VtZW50cyB0aGUgZXhwZWN0YXRpb24uDQoNCj4gDQo+
ID4gPiA+IEBAIC02MDgsNyArNjA4LDcgQEAgc3RhdGljIHZvaWQgZnJ3cl93Y19sb2NhbGludl9k
b25lKHN0cnVjdA0KPiA+ID4gPiBpYl9jcQ0KPiA+ID4gPiAqY3EsIHN0cnVjdCBpYl93YyAqd2Mp
DQo+ID4gPiA+IMKgKi8NCj4gPiA+ID4gdm9pZCBmcndyX3VubWFwX2FzeW5jKHN0cnVjdCBycGNy
ZG1hX3hwcnQgKnJfeHBydCwgc3RydWN0DQo+ID4gPiA+IHJwY3JkbWFfcmVxICpyZXEpDQo+ID4g
PiA+IHsNCj4gPiA+ID4gLcKgwqDCoMKgwqDCoCBzdHJ1Y3QgaWJfc2VuZF93ciAqZmlyc3QsICps
YXN0LCAqKnByZXY7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGliX3NlbmRfd3IgKmZp
cnN0LCAqbGFzdCA9IE5VTEwsICoqcHJldjsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0
IHJwY3JkbWFfZXAgKmVwID0gcl94cHJ0LT5yeF9lcDsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAg
c3RydWN0IHJwY3JkbWFfbXIgKm1yOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpbnQgcmM7DQo+
ID4gPiA+IC0tIA0KPiA+ID4gPiAyLjMxLjENCj4gPiA+ID4gDQo+ID4gDQo+ID4gRGl0dG8uDQo+
ID4gDQo+ID4gLS0gDQo+ID4gVHJvbmQgTXlrbGVidXN0DQo+ID4gTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KPiA+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCj4gDQo+IC0tDQo+IENodWNrIExldmVyDQo+IA0KPiANCj4gDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpDVE8sIEhhbW1lcnNwYWNlIEluYw0KNDk4NCBFbCBDYW1pbm8gUmVhbCwgU3VpdGUg
MjA4DQpMb3MgQWx0b3MsIENBIDk0MDIyDQrigIsNCnd3dy5oYW1tZXIuc3BhY2UNCg0K
