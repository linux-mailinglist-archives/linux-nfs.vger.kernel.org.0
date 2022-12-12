Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608A2649840
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 04:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiLLDda (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Dec 2022 22:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiLLDd2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Dec 2022 22:33:28 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2047.outbound.protection.outlook.com [40.107.114.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A4108F
        for <linux-nfs@vger.kernel.org>; Sun, 11 Dec 2022 19:33:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHoMA4MwqpxD6VNJbwm5B+1SC/iyca3wzvK8gbBib14ffj227zJo+6uVxWDR7H4t7D+GjCUslwk8FpsnSoHdouzWSsvOODklzkjhPEyFsu5qwxcvX3c8NzqyIVt20P/ok2wRqeumEedYpxer1+7W0v1Qu37D5XCdZk/98EIvKd98TPzWGg5NsA83nR4lABct8bOQCvbR6PlprSa3jgDQLabqH73JtFZSyEQHwX/f/hr8LAWBVA2tCRBZoQVVWNfGwNxyIQHJDikHO37v7gXrw8yYbVp7Mnr8+YorsE62+JgrrIfFzv3h9ZB9PY8rCfeS8mkuv7wm6wyViEpCnLSUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIijp4FHpbLlGEWbrg4GZUR1nL1dvChhqaj/ADcSO1A=;
 b=kRtfG1syoqrEZSax6nH6acyryoJ2v9Mty1I0fs5L8Osl6L2gL/hwIynmwaqcUt+DV8xpqFe6MgZySJIbSzM2gU+wczZhv8BNklI6tGz+apFo6mWskt24J83JlAkWDXuDJUA/njGHcmMwG5IZ3RTMEHOjBXROToh10kraD1Jge5H4ZY3FlwfMfOCaf89Pg0NCfbv5enOT0RB5G8TMtcczR/lIanMVUok8hdejQH4mK39gdwqoUJdu7fV1xuCw/Ewx5cktIcG4DxAMe5febAhraX7UVx3WH7+Mpvq0yo8JuYbxiTs+Yfg1tWiuCq+8qlUvXfwpQlKyVLUrbmKEzXhIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIijp4FHpbLlGEWbrg4GZUR1nL1dvChhqaj/ADcSO1A=;
 b=g4NGmeEfSyUe/taEz+J/jDFhT0hWm3fxhPUnKwTo6UyDAP0eMaCL3rlc7VfwxxkN2ubsaCrZVo7zZDrAtt4SZEXAQ08ItA5TZ9eznnGYBvhi+6glzc6BnjWzNyXgClLiO13ArJaIrsqCHHpOJwVnXMfqQggsItb/oH6/iHoKLXA=
Received: from TYAPR01MB4912.jpnprd01.prod.outlook.com (2603:1096:404:12c::17)
 by TY3PR01MB10190.jpnprd01.prod.outlook.com (2603:1096:400:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 03:33:24 +0000
Received: from TYAPR01MB4912.jpnprd01.prod.outlook.com
 ([fe80::abe6:a95f:c66f:1c20]) by TYAPR01MB4912.jpnprd01.prod.outlook.com
 ([fe80::abe6:a95f:c66f:1c20%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 03:33:24 +0000
From:   =?utf-8?B?U0hJTUFNT1RPIEhJUk9TSEko5bO25pys44CA6KOV5b+XKQ==?= 
        <h-shimamoto@nec.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        minoura <minoura@valinux.co.jp>
Subject: RE: [PATCH v2] SUNRPC: serialize gss upcalls for the same uid
Thread-Topic: [PATCH v2] SUNRPC: serialize gss upcalls for the same uid
Thread-Index: AQHZC2W+YGHmcZtW/EanzwyCw8yTfK5nfbWAgAIe2uA=
Date:   Mon, 12 Dec 2022 03:33:24 +0000
Message-ID: <TYAPR01MB4912E93E6B1CBB92AFD5335CFFE29@TYAPR01MB4912.jpnprd01.prod.outlook.com>
References: <20221209003032.3211581-1-h-shimamoto@nec.com>
 <17D036AA-5F8A-497B-9D66-879E9D201BDD@hammerspace.com>
In-Reply-To: <17D036AA-5F8A-497B-9D66-879E9D201BDD@hammerspace.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB4912:EE_|TY3PR01MB10190:EE_
x-ms-office365-filtering-correlation-id: 0cbc118a-11f9-4533-d221-08dadbf1a009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NGLIVo0DeqficA+uSZvPe7gFf3iPMoFJsl2mUlnzuCb/AyiGptjGSjw5/cCcROuxDs5lS1RaRsyeWX7fyyqz1bp4lb6V7TLcTcIpdCN6w5jAXEmwiNBBxlWOKL4kZ+57EKN2XdrNox/OOo00GvqRJ1zP1732r1p2yYooMs660pyL1RgkF0EwvEI0RAkBebMDbu0GGDkZbfUahK4CxnSE9q9dIVPg4+/luwn8RlyOxHTkbrQIw1AF16a3oSJ6+FV6tr91nj43YpTjAM+PPUSG/RSHKWsSDlTwvK4EFCTO+wD/8rxqB9twdB7OwVHbxKuVWqY/pxPm6K8j5SG28NO+XH02ThQ8esuF3SZ+vwKXwiREmsdMSo9HZN35Ay1Fs3BbUCD2y3heBGRpMeyuX+zG8WHBhL7oTRMEYt/LogiOkVjfSDRFhB38FTy206O+q15ONCJieHrX2cSLAR4XvvBe02NZ9DvX6In03wIefb2ukdldVDI4z5JuXvxaJEwvncHz40Rsx1GZeWtQbzOmUFad+YWn7c5/tlxvOb2Sa0Y7cRjumQ7O4izlPyG7qf9TZ/VYt8o/j37x0Ej4vUjMWuFCeUxcymMHVH6HCOluCM2yMncT0XCJGRYuu61SBjn+mD/Hi53Cjywwj/+X5+0dOx8Kx6Oa6zP7gDlgrW3GhRaHBrYGZmIiToDswyA/+tOnCCqhUD5OhclwC5rCuGVv8dZY5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4912.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(85182001)(33656002)(86362001)(38070700005)(82960400001)(122000001)(38100700002)(8936002)(5660300002)(83380400001)(2906002)(41300700001)(52536014)(66446008)(478600001)(8676002)(66476007)(76116006)(4326008)(66946007)(66556008)(64756008)(6916009)(54906003)(316002)(186003)(6506007)(55016003)(7696005)(53546011)(26005)(9686003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnhnV0wvSkhvNXNIV2ZUZ2h0aUFLRjRQTXRwaWQrOGc2aWwvY29WdkRzTTh4?=
 =?utf-8?B?Y1FIMWQwak8zVFZuU2JBN1lKRmNCVFB4cHpxV3ducGMzNDBQNUxpVUl3TDY0?=
 =?utf-8?B?aEJRTU85RE4zRVMzTCsvZVpBcHRRRjV2NERRUGRjZXAwY2phTWhQbjlXYnpI?=
 =?utf-8?B?UFlZdVZYbUNhYjhmV1cyaXhka0tNK3c3QTRXQi9lLzBianhRcExjM3F4ZzZE?=
 =?utf-8?B?REp0bkJ1bWxVeUNzZmozU244WUtXeFBieUdSbWplRS9RWjJGTFR3d2xickd0?=
 =?utf-8?B?MU95cFBzMzNJMCtDZ3hmTFcraUltK2RTQU1HNW9LUk5NN09vb0VaUHE0dEJ5?=
 =?utf-8?B?MXFqVnE0dzJaWVl2T041YjNwczFidEJ5Qk5yamN2d1BMTkdzTmxZTHhVMVVu?=
 =?utf-8?B?OVZVNzZQckdRTGcwRWZweWtScFMwUG45UldYRUJ1cHZkSjJUbTIxUWRyUDdM?=
 =?utf-8?B?eDUvTGhrbzZYMW1ydVZKM2VsejdjQVFMSmNPanpad3FJMlBZVW9vdWlLM3Nm?=
 =?utf-8?B?VkJ0Q3BuZHkwT0FXQmRKMHA5YkR0TVd2aU8ySTNIclJRTGVsRDJiTGhHVTRi?=
 =?utf-8?B?Wnlua2psSGhYWmYrb00xR2lFekNBYlhmcVpwcmFnUzU4MDFuQmRyWHJqQTk0?=
 =?utf-8?B?N0E4ZmRwb01Jb1dCdW9TK0tlZGRlK1B1OFlSSnVxRnpqRlNtUHpvRCtIL2dI?=
 =?utf-8?B?dElhcjJnS1VVL2RRVno3all2aytHOTUzRjRpa1dpRUY3cytDZk1WTlFFdUZt?=
 =?utf-8?B?ekh1bWpoQWtBN2tXbEJWTzdBa25MQ2R6bGtMTXlnbXZyVGQrbmovRDhmTWdn?=
 =?utf-8?B?SjlrMC94dHRKbUtEMTRCODZCVEpxS2oyVUZZUDU0U09kQlVpOWsrM3RHL1di?=
 =?utf-8?B?NWpyb2EwQWo5cUlMRmRjbC8vdE53dlpZclhBTzhSQS8yK0JId09GSmpIUlEz?=
 =?utf-8?B?U0tZdW9nV1lMY3BXWk90bG5YdkUwVGhLSlJnYXRkdkNwRUZEVHNKdEVsanF2?=
 =?utf-8?B?NEZWT0xQUGczL3VZR1lnWGZ5UU1tTVZ1ZlU1Q3ZNQ1E1L2FweXQxbU5nSmU2?=
 =?utf-8?B?b0xxankwTnVXMHZrNGJ0N1BwOWxSaHJuakowSjM1d0diSzZPMUpTUFNNLzky?=
 =?utf-8?B?dGZKR3FKKzBuT2xpSTM0ZFJmdVNKaXA1SzVVTzJiaEZZZDYrSmdlbDBqN2o5?=
 =?utf-8?B?ZEpWL29aZ2hnRXdOaW9heGx6MzVjMWFQZURQZGlDQzBUclVlN2RFbjlud1l2?=
 =?utf-8?B?c2dEeXRZakdia0N3d3dTeTFsK1BlVWczS2p2WkxGcTNFUGdsQWdYYStwekNM?=
 =?utf-8?B?NXlvWWZqb1JpZHhUQUp6TGN1OEdjRUdVbzJ4bnVPNmQvNEFrSjg0Y21jUWVq?=
 =?utf-8?B?MVlYNk5LLzA5dmplbXB2bUhHdFpCQ0Y0S0traWduLzVVekpBVjB6eGpkT29Q?=
 =?utf-8?B?dnlMc3Rpd3hlcFRZYVI4VHpLTkY3L1o2Rk9jamFOVC9zM2lzTDIxRytPOWZk?=
 =?utf-8?B?RlcrOFo1ZjJPMTk2MXl1U21jSUZYRUo0bXR0Q2U0eUpBcHd6L2RBUEQ5eHhx?=
 =?utf-8?B?WkIyQ3h2Mkc0THE4OVBycndmdHp4ODkwUTFMajhxb05nR0ZLYmtDMnVvOGRx?=
 =?utf-8?B?OWVxazBzTlh4eHFScENvZVNvN2RFMGlOYzJUYmI0eGhnUmdsZlQ1Z2xSQzFI?=
 =?utf-8?B?czV0dFVHNUNTbEs5aVFqTHpUdHF5Z2pTdmZJY09ISzlaN0Myc1kwS1lmM0Z2?=
 =?utf-8?B?NGZ2OGRxME1HUE83SzRPT29SV2VvR2FmQjRsditDWUVQazRqTXpjNHNoUVJw?=
 =?utf-8?B?SHR0Ymx1cS9rQW92aENNdWU0cXpJTFZGS01oaFFmazhHTGxZaGVNazg4ZTM0?=
 =?utf-8?B?eGg4RFJQV3Z2WjhQZzBlS2lvVU5iRFMrUG5mK3pWaTNlR3hsZi9Gcmt6aXhs?=
 =?utf-8?B?SE5KTlp2b09JMEtvWnZPQnlseUthSXpuOWY5SHlBYVRtTzBhay9BRzBrNHlo?=
 =?utf-8?B?MFZOWVFnVklla3NiUkM3UnUwK0JzaDRraUtXeXd4aVU4aDkxOEVtclZCLzN5?=
 =?utf-8?B?Mjg1NTJsaTVORWV2ZnZKclhSb2R6cXBEQVpNaWoyVFF1dlAyQllHTEp3cGZP?=
 =?utf-8?Q?EhGgcEI/RPYdpzseRmSOI5jG6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4912.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbc118a-11f9-4533-d221-08dadbf1a009
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 03:33:24.4789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZQp2trF2T6CCvw5CJxyg7Oxiz4JKHKmRQDt8mRMtnOuHz7yL7+Y5lRZhE9RspGNg5vikKyU8Qn+uXPfjUjgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBTVU5SUEM6IHNlcmlhbGl6ZSBnc3MgdXBjYWxscyBm
b3IgdGhlIHNhbWUgdWlkDQo+IA0KPiANCj4gDQo+ID4gT24gRGVjIDgsIDIwMjIsIGF0IDE5OjMw
LCBIaXJvc2hpIFNoaW1hbW90byA8aC1zaGltYW1vdG9AbmVjLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBGcm9tOiBtaW5vdXJhIDxtaW5vdXJhQHZhbGludXguY28uanA+DQo+ID4NCj4gPiBDb21taXQg
OTEzMGI4ZGJjNmFjICgiU1VOUlBDOiBhbGxvdyBmb3IgdXBjYWxscyBmb3IgdGhlIHNhbWUgdWlk
DQo+ID4gYnV0IGRpZmZlcmVudCBnc3Mgc2VydmljZSIpIGludHJvZHVjZWQgYGF1dGhgIGFyZ3Vt
ZW50IHRvDQo+ID4gX19nc3NfZmluZF91cGNhbGwoKSwgYnV0IGluIGdzc19waXBlX2Rvd25jYWxs
KCkgaXQgd2FzIGxlZnQgYXMgTlVMTA0KPiA+IHNpbmNlIGl0IChhbmQgYXV0aC0+c2VydmljZSkg
d2FzIG5vdCAoeWV0KSBkZXRlcm1pbmVkLg0KPiA+DQo+ID4gV2hlbiBtdWx0aXBsZSB1cGNhbGxz
IHdpdGggdGhlIHNhbWUgdWlkIGFuZCBkaWZmZXJlbnQgc2VydmljZSBhcmUNCj4gPiBvbmdvaW5n
LCBpdCBjb3VsZCBoYXBwZW4gdGhhdCBfX2dzc19maW5kX3VwY2FsbCgpLCB3aGljaCByZXR1cm5z
IHRoZQ0KPiA+IGZpcnN0IG1hdGNoIGZvdW5kIGluIHRoZSBwaXBlLT5pbl9kb3duY2FsbCBsaXN0
LCBjb3VsZCBub3QgZmluZCB0aGUNCj4gPiBjb3JyZWN0IGdzc19tc2cgY29ycmVzcG9uZGluZyB0
byB0aGUgZG93bmNhbGwgd2UgYXJlIGxvb2tpbmcgZm9yIGR1ZQ0KPiA+IHRvIHR3byByZWFzb25z
Og0KPiA+DQo+ID4gLSB0aGUgb3JkZXIgb2YgdGhlIG1zZ3MgaW4gcGlwZS0+aW5fZG93bmNhbGwg
YW5kIHRob3NlIGluIHBpcGUtPnBpcGUNCj4gPiAgKHRoYXQgaXMsIHRoZSBvcmRlciBvZiB0aGUg
dXBjYWxscyBzZW50IHRvIHJwYy5nc3NkKSBtaWdodCBiZQ0KPiA+ICBkaWZmZXJlbnQgYmVjYXVz
ZSBwaXBlLT5sb2NrIGlzIGRyb3BwZWQgYmV0d2VlbiBhZGRpbmcgb25lIHRvIGVhY2gNCj4gPiAg
bGlzdC4NCj4gPiAtIHJwYy5nc3NkIHVzZXMgdGhyZWFkcyB0byB3cml0ZSByZXNwb25zZXMsIHdo
aWNoIG1lYW5zIHdlIGNhbm5vdA0KPiA+ICBndWFyYW50ZWUgdGhlIG9yZGVyIG9mIHJlc3BvbnNl
cy4NCj4gPg0KPiA+IFdlIGNvdWxkIHNlZSBtb3VudC5uZnMgcHJvY2VzcyBodW5nIGluIEQgc3Rh
dGUgd2l0aCBtdWx0aXBsZSBtb3VudC5uZnMNCj4gPiBhcmUgZXhlY3V0ZWQgaW4gcGFyYWxsZWwu
ICBUaGUgY2FsbCB0cmFjZSBiZWxvdyBpcyBvZiBDZW50T1MgNy45DQo+ID4ga2VybmVsLTMuMTAu
MC0xMTYwLjI0LjEuZWw3Lng4Nl82NCBidXQgd2Ugb2JzZXJ2ZWQgdGhlIHNhbWUgaGFuZyB3Lw0K
PiA+IGVscmVwbyBrZXJuZWwtbWwtNi4wLjctMS5lbDcuDQo+ID4NCj4gPiBQSUQ6IDcxMjU4ICBU
QVNLOiBmZmZmOTFlYmQ0YmUwMDAwICBDUFU6IDM2ICBDT01NQU5EOiAibW91bnQubmZzIg0KPiA+
ICMwIFtmZmZmOTIwM2NhMzIzNGY4XSBfX3NjaGVkdWxlIGF0IGZmZmZmZmZmYTNiODg5OWYNCj4g
PiAjMSBbZmZmZjkyMDNjYTMyMzU4MF0gc2NoZWR1bGUgYXQgZmZmZmZmZmZhM2I4OGViOQ0KPiA+
ICMyIFtmZmZmOTIwM2NhMzIzNTkwXSBnc3NfY3JlZF9pbml0IGF0IGZmZmZmZmZmYzAzNTU4MTgg
W2F1dGhfcnBjZ3NzXQ0KPiA+ICMzIFtmZmZmOTIwM2NhMzIzNjU4XSBycGNhdXRoX2xvb2t1cF9j
cmVkY2FjaGUgYXQgZmZmZmZmZmZjMDQyMWViYyBbc3VucnBjXQ0KPiA+ICM0IFtmZmZmOTIwM2Nh
MzIzNmQ4XSBnc3NfbG9va3VwX2NyZWQgYXQgZmZmZmZmZmZjMDM1MzYzMyBbYXV0aF9ycGNnc3Nd
DQo+ID4gIzUgW2ZmZmY5MjAzY2EzMjM2ZThdIHJwY2F1dGhfbG9va3VwY3JlZCBhdCBmZmZmZmZm
ZmMwNDIxNTgxIFtzdW5ycGNdDQo+ID4gIzYgW2ZmZmY5MjAzY2EzMjM3NDBdIHJwY2F1dGhfcmVm
cmVzaGNyZWQgYXQgZmZmZmZmZmZjMDQyMjNkMyBbc3VucnBjXQ0KPiA+ICM3IFtmZmZmOTIwM2Nh
MzIzN2EwXSBjYWxsX3JlZnJlc2ggYXQgZmZmZmZmZmZjMDQxMDNkYyBbc3VucnBjXQ0KPiA+ICM4
IFtmZmZmOTIwM2NhMzIzN2I4XSBfX3JwY19leGVjdXRlIGF0IGZmZmZmZmZmYzA0MWUxYzkgW3N1
bnJwY10NCj4gPiAjOSBbZmZmZjkyMDNjYTMyMzgyMF0gcnBjX2V4ZWN1dGUgYXQgZmZmZmZmZmZj
MDQyMGE0OCBbc3VucnBjXQ0KPiA+DQo+ID4gVGhlIHNjZW5hcmlvIGlzIGxpa2UgdGhpcy4gTGV0
J3Mgc2F5IHRoZXJlIGFyZSB0d28gdXBjYWxscyBmb3INCj4gPiBzZXJ2aWNlcyBBIGFuZCBCLCBB
IC0+IEIgaW4gcGlwZS0+aW5fZG93bmNhbGwsIEIgLT4gQSBpbiBwaXBlLT5waXBlLg0KPiA+DQo+
ID4gV2hlbiBycGMuZ3NzZCByZWFkcyBwaXBlIHRvIGdldCB0aGUgdXBjYWxsIG1zZyBjb3JyZXNw
b25kaW5nIHRvDQo+ID4gc2VydmljZSBCIGZyb20gcGlwZS0+cGlwZSBhbmQgdGhlbiB3cml0ZXMg
dGhlIHJlc3BvbnNlLCBpbg0KPiA+IGdzc19waXBlX2Rvd25jYWxsIHRoZSBtc2cgY29ycmVzcG9u
ZGluZyB0byBzZXJ2aWNlIEEgd2lsbCBiZSBwaWNrZWQNCj4gPiBiZWNhdXNlIG9ubHkgdWlkIGlz
IHVzZWQgdG8gZmluZCB0aGUgbXNnIGFuZCBpdCBpcyBiZWZvcmUgdGhlIG9uZSBmb3INCj4gPiBC
IGluIHBpcGUtPmluX2Rvd25jYWxsLiAgQW5kIHRoZSBwcm9jZXNzIHdhaXRpbmcgZm9yIHRoZSBt
c2cNCj4gPiBjb3JyZXNwb25kaW5nIHRvIHNlcnZpY2UgQSB3aWxsIGJlIHdva2VuIHVwLg0KPiAN
Cj4gV2FpdCBhIG1pbnV0ZeKApiBUaGUg4oCYc2VydmljZeKAmSBoZXJlIGlzIG9uZSBvZiBrcmI1
LCBrcmI1aSwgb3Iga3JiNXAuIFdoYXQgaXMgYmVpbmcgcHVzaGVkIGRvd24gZnJvbSB1c2VyDQo+
IHNwYWNlIGlzIGEgUlBDU0VDX0dTUyBjb250ZXh0IHRoYXQgY2FuIGJlIHVzZWQgZm9yIGFueSBv
bmUgb2YgdGhvc2Ugc2VydmljZXMuIFNvIHRoZSBvcmRlcmluZyBvZiBBIGFuZCBCDQo+IGlzIG5v
dCBzdXBwb3NlZCB0byBtYXR0ZXIuIEFueSBvbmUgb2YgdGhvc2UgcmVxdWVzdHMgY2FuIHRha2Ug
dGhlIGNvbnRleHQgYW5kIG1ha2UgdXNlIG9mIGl0Lg0KPiANCj4gSG93ZXZlciBvbmNlIHRoZSBj
b250ZXh0IGhhcyBiZWVuIHVzZWQgd2l0aCBvbmUgb2YgdGhlIGtyYjUsIGtyYjVpIG9yIGtyYjVw
IHNlcnZpY2VzIHRoZW4gaXQgY2Fubm90IGJlIHVzZWQNCj4gd2l0aCBhbnkgb2YgdGhlIG90aGVy
cy4gVGhpcyBpcyB3aHkgY29tbWl0IDkxMzBiOGRiYzZhYyB0aGF0IHlvdSByZWZlcmVuY2VkIGFi
b3ZlIHNlcGFyYXRlcyB0aGUgc2VydmljZXMNCj4gaW4gZ3NzX2FkZF9tc2coKS4NCg0KT25lIHF1
ZXN0aW9uLCBob3cgYWJvdXQgc2ltdWx0YW5lb3VzIHVwY2FsbHMgQVVUSF9HU1MgYW5kIEFVVEhf
VU5JWD8NCkknbSBub3Qgc3VyZSB0aGVyZSBpcyB0aGUgc3VjaCBjYXNlLCBidXQgYW4gZXJyb3Ig
Y291bGQgYmUgdGFrZW4gZm9yIHRoZSBzdWNjZXNzZnVsIGNhc2UsIG5vPyANCg0KVGhhbmtzLA0K
SGlyb3NoaQ0K
