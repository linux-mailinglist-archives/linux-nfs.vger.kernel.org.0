Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76B6443359
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 17:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhKBQpq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 12:45:46 -0400
Received: from mail-sn1anam02on2093.outbound.protection.outlook.com ([40.107.96.93]:3399
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230357AbhKBQpp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Nov 2021 12:45:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXnd3dy4kEl9kSK4wDyicMaR9u2F1nsIzxtoGVPyAEe8bxf8eoao5EoTy4TIlarbh0KcjHv87KmRv7SAGu/so3d5PyawWXd30gTsBit68cXVxkoqvBd0/qesZ48R25K4cSWeC7vfDUMC+rI5UtjrqQbogYzTPk99PM5ChXlYqAY3s9I3GXZsqVzTIvqAZUc7UyjXmCzw02jwk9aq7qYonov4SWBs+17edKCG6OhOqNFJEhVJI/xvXWOzfRurEisWs7hUcGL5DJbFjL/sLYeV4Vf9TUx4EqteCVREEStu57IWR6+TolN/joRcvp4yGAgBdewrsT8F4WplJtGvEYfYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUerCDTE2ze03ChT39uMAdRnq2a6HKIqVt/eFY80kho=;
 b=lD5k06kEwkY3xrTAoWTHZaxaIkJF5G3Aae9A7Rcb0wstK01lkEK6peOMJa2YLjocBRNaBRmEJKblaAOhGOnwuWLFk7G8IlxB4c8bIy7cIR6QgpjTKfYKW7+5h4DUxxLmsjW6peHKakzJHEiJSMvwPp4KPjAWD5ulFGtDBW+ywZHNd7J32CtzI3bwOI6PaH3TSsg5mUiduvNo4MvbN9UCseCrEzDPg1UZgeYh9GgCqVDFEQivJN6+mTBrRxcIlVecb65tCyBj0+m/uzuwC2+GZiKVw0f0/GAaqkak5EVh7ovWl51SrRKQ14CZsvbcJmFfOQzU9zMUA0EViNGsbdP+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUerCDTE2ze03ChT39uMAdRnq2a6HKIqVt/eFY80kho=;
 b=em0B4rnhRznFGDno6WeOZcafH0F9hPruuMxRJFSWNY05gg7wqFTDl1olCCDuL7FUOdhCiO8sldxMCY9I/RdLLeY8N5L2lh72W2GgvqLcl7fRPTl6z3xFgF2GOjXZqbivBzRxBWabTDgm669XpUuzTAoMw71I9M15KMmg++DTq+I=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3509.namprd13.prod.outlook.com (2603:10b6:610:2a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.8; Tue, 2 Nov
 2021 16:43:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%8]) with mapi id 15.20.4669.010; Tue, 2 Nov 2021
 16:43:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH] xprtrdma: Fix a maybe-uninitialized compiler warning
Thread-Topic: [PATCH] xprtrdma: Fix a maybe-uninitialized compiler warning
Thread-Index: AQHXzlh3SGRbXHO8skq2kgQzcxhtKKvtNIqAgAM/IoA=
Date:   Tue, 2 Nov 2021 16:43:08 +0000
Message-ID: <d29f109c50126168ed83108ed4297c56771070ce.camel@hammerspace.com>
References: <2b32d41cf6a502918a685447cd749c4b1cb0d16d.1635685588.git.bcodding@redhat.com>
         <3EC776BC-8E37-477B-98BB-C9DE163EFA52@oracle.com>
In-Reply-To: <3EC776BC-8E37-477B-98BB-C9DE163EFA52@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9adc854d-6211-48b8-4993-08d99e1fd9eb
x-ms-traffictypediagnostic: CH2PR13MB3509:
x-microsoft-antispam-prvs: <CH2PR13MB3509DD9D5F7003BB738BDE10B88B9@CH2PR13MB3509.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XFKeTtspsWSSs6mPTBGgedhui0D3Wn8JZ3S8epbTSJXcjD78LSnjbx8byRtoq9PWif2cRncujgT3lQtfwRz6pdK8ysBuPQhJIHmOFueGT5hEdwoZEDuJ7d3NeI13gKtgiTpakKU1I83CgiFEen/ifwItMXtTYtV9WTXxXFHkQQ8+YxTVhBrMN45uvNa4bpwMYWjViKhfJ+7hWJmD6cMq2r8r9HfenyrpiIV1S0jfJtgDQVZgr9ebDYbiqe3iJHthWYX9Tt1Hu6Zy/RMg+PO/1KOxaQQE3m8xfnpubkuhyDiim4U9/+ukrk1p90dJol4SPSLnayui/U+XhCofr5ZU1tw0tO5SRN2Ja+2H9YLefv/wOp/8QRSHpWCK1ohBKtU/Ywzn97WFsGL7yhe10/ZJMchRnuUud5fK2VQ0z07GGeMzaWKupleGHJh83pEEEg8uXwoAPhM0tz9muUEzzHORh6jekpyL0i5hwSM0eyHUrdbMyW6h9YTcws6ZJGvKYiHPPXIrh2smxUSYgYsueamHvbyjx+Vbz3REpeapzkcSC9Ug9WCQ1bVnQZ9RziUoWZaJ2DRhb0URZ5bRPgmb8HjfJK1/j4JMYuY8e+OPWXmmof2wsp2bJProHvfO7NpGFaEdRLsWxitmhYP9KfEcu0aTLiH9pLXerHXOcBM4br3a4XH9g/yEAb2btS7plwJXsRg+TWk9diD/v3jZ+rbYuaUulA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(83380400001)(8676002)(76116006)(54906003)(6506007)(66446008)(66946007)(38070700005)(8936002)(71200400001)(508600001)(26005)(6512007)(186003)(4326008)(66476007)(6486002)(316002)(5660300002)(2906002)(4001150100001)(2616005)(122000001)(36756003)(38100700002)(66556008)(86362001)(110136005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1pkVDdqVklYSVNCc1Vab215M0xLNHlXZnVyYXBHZ2RLcmRUc05OM0p0ZHZr?=
 =?utf-8?B?djRVK3dUcE9tQkZEY251em13Q0Z3QjNMZzF1emdWS0ttenNUVFdGbW9FckxF?=
 =?utf-8?B?S09OUlA4bjZ5Z2d5VmZyN0JaRERibFlPbWJyZFJtb3lZeEtoQW54UWc1NzZv?=
 =?utf-8?B?NThyczNSOGQzVFpIanBJUG84dzVwdG9CeFU0ZzBVb2huNGhzZFNPYkt2dUs5?=
 =?utf-8?B?UWM4Uy92SnMweVNpUUN0aEpXQ3ZFV0o3OGZJQmJNalpvOGx0NGREV1prTEVo?=
 =?utf-8?B?bjNNWVFONEZBZkxVTUJhb3BXOWNZdk1xU2JFS0M4MXFmVUhxV0ZhaHVNZ21l?=
 =?utf-8?B?Tk42NE1Yem5XTzFqcWxtbXZhaEFUMjRxQzBYVUhLUXRXUjk1dkRGbkkzeXEr?=
 =?utf-8?B?WmRvRkd0L2w2Q3lRYkVJVUM0RFhaNWJXREJLNnB2QU1oN2FySUg1eTBSblFI?=
 =?utf-8?B?dnB5eVpkZlJvRGdIdWpZWkJRUkpPeVlheVBtYXQ4ZFk3RmZZLzl1aVVNbnFX?=
 =?utf-8?B?WnYxVG5BRmoxVFhOakUzRXMxNmZ2dUFaWTJnYzVXaU5tOWxheTZsd0lLTDR4?=
 =?utf-8?B?L3Y5SWhSVVhFRFZkdUhIc2tYOVBmRW5tMG02VzRSTERIdDBJZ0dGY1ZGMVIy?=
 =?utf-8?B?WTZpOGJhQ2FnZEJYdnpOU3dqMStiMzhyOGJmWkNpVjN1dWlRZUtzTWJIT1Fp?=
 =?utf-8?B?Mms1bklwL2VNckZUL0ptc1FPUXlsS0lEZFNZcGN4ZTRTN2QwRXpxa0xpTlZB?=
 =?utf-8?B?R2k2RHoycm9uOGpJOWYzWHN6MzcvaUFYMEhTY2tPbG9EWW83UnFkSWI2U01K?=
 =?utf-8?B?L2YrbzlxMEs0U1g5bGJKY3NSR1JWY2RISkw1MXBpVXV2Z0JMUnI4dmdlY3I4?=
 =?utf-8?B?UlJCdTg0bkJ6cUtSSEZZRVAzZ284V0JSMUQyVjZHRU84SGluc1d3WGJhSmlj?=
 =?utf-8?B?ZFdiVWlSOXRUbGdkQjJ1Q3JnZDhacXpISEZGRWFWM3picjhTb0V0V2FYbXpM?=
 =?utf-8?B?SXdnMW8rajhFVnFCelUzTVNVeXFqU2xjNXhDWnlSdjFSNkZyRFVuR2g1a0RB?=
 =?utf-8?B?WHJIVVRaMlpYUUJPSkgzT1ZnVFdmeFRidVdCSXFNWE5XR1JsL3NxV1NraFRF?=
 =?utf-8?B?Y1ZXQUZrbzdXb0NBWHYwaTk3TUhDNUN1Y0lkN1pOMFcrdFB2S1dzM3lKT2ZH?=
 =?utf-8?B?VllHTXR3LzNUUm81Vm1NZFllMEhIR04zSFZuZEhMK1hWejBCamZESnlGZVlt?=
 =?utf-8?B?M3Q0bDhob1FEQzFMK1NpM0hpSDVaT094RTRVZDNNLzNCNFFJZjdSNFNxb2F2?=
 =?utf-8?B?bUNBZHNvQnpzdjJyaDM4cTBNS1BscjNxeXpTMWxyMC93aTI2eHJrT2JPSlo3?=
 =?utf-8?B?dUxzblNiT3NIazFzOG9Zand0MFFNd1FNRlRoNXpoYUV0YlhZU2NuT3hxVHBV?=
 =?utf-8?B?dzJSQWdyWXk0b2t3UFBITlRjWGNuckEzL2hsVkQ5WWlHYkNVRGs0dDBBNWw3?=
 =?utf-8?B?MUVuL2grdDNVZzR3SVBzNmlIdUNuNW5WNGVRRkNjcEs3aFdpMURXY1Z6eXVr?=
 =?utf-8?B?OHk2QzdyOFBvNGo3MzZJY2h4SFE3cGNpbFAzUllQbk56T0ZibFBEc01TaWdI?=
 =?utf-8?B?cWFIaVQ1VXRMNFVaN2M4TTdQZkc1K1lYejk3MEljL1dMRWR2QjRMY0ROS2ZQ?=
 =?utf-8?B?S2g5dmIyRDdpQTlYQ1VDdW9CTmRYenhPRFNnRndJanNPRitHdzBia1U4Kyty?=
 =?utf-8?B?RzVicFNVMTNFVTEvOVFPcWpxZC9HZ3ptNTgrdG9xcXAvV2drTE10dTFFMWVO?=
 =?utf-8?B?dGl4OVUzM3U5SUowY21Jd3ZCd2d3RzN3QzFmVnFWNm9BeXAvMW1nM1ozNEs4?=
 =?utf-8?B?RTFLSUJjWkdNZ20zMW5jUDJOaTBGK005M1ZrV2wweUhCQTMrdTdoMG01ZXhU?=
 =?utf-8?B?WStnd3Z1TUw4eS9WZDRzZVpMWS82bzJNanBLQ3lhWkJmZmYyNVZSZHB1TDVN?=
 =?utf-8?B?elpSY0NaUlNSZmtXcHZlOEhmMEJrN1VWL2lNdTVzM2kxNE5EV280WGhyOWZz?=
 =?utf-8?B?UWpEMWZJUHFUTE9WOW5KWWNhVVMzYVpRc3lXelB4SDlKeHVUVUttWmpGbjdM?=
 =?utf-8?B?TWZkdHBsRnFaTDJ4QWZRTUo4SUp2RWdENm9FZFJueERlNlJWYlVXTWJnVmk3?=
 =?utf-8?Q?rdVL7MLEBMwXwasiWEdo6lw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4502D9FDEA52B54F9A92FEEAB431B572@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adc854d-6211-48b8-4993-08d99e1fd9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 16:43:08.4805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSb3LUiLwfH1fZbkVjCR4JJoC+jPqW6en9ZdeMQtpjY3NoCisd59TVEEjbf7cbXylf1abBAh5CH4Yen4c4JOug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3509
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTEwLTMxIGF0IDE1OjA0ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBPY3QgMzEsIDIwMjEsIGF0IDk6MDggQU0sIEJlbmphbWluIENvZGRp
bmd0b24NCj4gPiA8YmNvZGRpbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gVGhpcyBt
aW5vciBmaXgtdXAga2VlcHMgR0NDIGZyb20gY29tcGxhaW5pbmcgdGhhdCAibGFzdCcgbWF5IGJl
IHVzZWQNCj4gPiB1bmluaXRpYWxpemVkIiwgd2hpY2ggYnJlYWtzIHNvbWUgYnVpbGQgd29ya2Zs
b3dzIHRoYXQgaGF2ZSBiZWVuDQo+ID4gcnVubmluZw0KPiA+IHdpdGggYWxsIHdhcm5pbmdzIHRy
ZWF0ZWQgYXMgZXJyb3JzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIENvZGRp
bmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogQ2h1Y2sgTGV2
ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IA0KPiANCj4gPiAtLS0NCj4gPiBuZXQvc3Vu
cnBjL3hwcnRyZG1hL2Zyd3Jfb3BzLmMgfCA0ICsrLS0NCj4gPiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQv
c3VucnBjL3hwcnRyZG1hL2Zyd3Jfb3BzLmMNCj4gPiBiL25ldC9zdW5ycGMveHBydHJkbWEvZnJ3
cl9vcHMuYw0KPiA+IGluZGV4IGY3MDBiMzRhNWJmZC4uZGU4MTNmYTA3ZGFhIDEwMDY0NA0KPiA+
IC0tLSBhL25ldC9zdW5ycGMveHBydHJkbWEvZnJ3cl9vcHMuYw0KPiA+ICsrKyBiL25ldC9zdW5y
cGMveHBydHJkbWEvZnJ3cl9vcHMuYw0KPiA+IEBAIC01MDMsNyArNTAzLDcgQEAgc3RhdGljIHZv
aWQgZnJ3cl93Y19sb2NhbGludl93YWtlKHN0cnVjdCBpYl9jcQ0KPiA+ICpjcSwgc3RydWN0IGli
X3djICp3YykNCj4gPiDCoCovDQo+ID4gdm9pZCBmcndyX3VubWFwX3N5bmMoc3RydWN0IHJwY3Jk
bWFfeHBydCAqcl94cHJ0LCBzdHJ1Y3QgcnBjcmRtYV9yZXENCj4gPiAqcmVxKQ0KPiA+IHsNCj4g
PiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWJfc2VuZF93ciAqZmlyc3QsICoqcHJldiwgKmxhc3Q7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGliX3NlbmRfd3IgKmZpcnN0LCAqKnByZXYsICps
YXN0ID0gTlVMTDsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHJwY3JkbWFfZXAgKmVwID0g
cl94cHJ0LT5yeF9lcDsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGliX3NlbmRf
d3IgKmJhZF93cjsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHJwY3JkbWFfbXIgKm1yOw0K
DQpFcnIuLi4gRGVmaW5pdGVseSBub3Qgc3VmZmljaWVudC4NCg0KZ2NjIGlzIGFic29sdXRlbHkg
Y29ycmVjdCB0byBjb21wbGFpbiBoZXJlLCBiZWNhdXNlIGlmIHJlcS0NCj5ybF9yZWdpc3RlcmVk
IGlzIGVtcHR5LCB0aGVuIHRoZSB3aG9sZSByZXN0IG9mIHRoZSBmdW5jdGlvbiBhZnRlciB0aGF0
DQp3aGlsZSgpIGxvb3AgaXMgaW52YWxpZC4NCg0KPiA+IEBAIC02MDgsNyArNjA4LDcgQEAgc3Rh
dGljIHZvaWQgZnJ3cl93Y19sb2NhbGludl9kb25lKHN0cnVjdCBpYl9jcQ0KPiA+ICpjcSwgc3Ry
dWN0IGliX3djICp3YykNCj4gPiDCoCovDQo+ID4gdm9pZCBmcndyX3VubWFwX2FzeW5jKHN0cnVj
dCBycGNyZG1hX3hwcnQgKnJfeHBydCwgc3RydWN0DQo+ID4gcnBjcmRtYV9yZXEgKnJlcSkNCj4g
PiB7DQo+ID4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGliX3NlbmRfd3IgKmZpcnN0LCAqbGFzdCwg
KipwcmV2Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBpYl9zZW5kX3dyICpmaXJzdCwgKmxh
c3QgPSBOVUxMLCAqKnByZXY7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBycGNyZG1hX2Vw
ICplcCA9IHJfeHBydC0+cnhfZXA7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBycGNyZG1h
X21yICptcjsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgaW50IHJjOw0KPiA+IC0tIA0KPiA+IDIuMzEu
MQ0KPiA+IA0KDQpEaXR0by4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
