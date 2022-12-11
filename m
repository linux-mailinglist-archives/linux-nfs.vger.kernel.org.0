Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1939A64973C
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 00:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiLKXrD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Dec 2022 18:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKXrB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Dec 2022 18:47:01 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2063.outbound.protection.outlook.com [40.107.114.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663B65E4
        for <linux-nfs@vger.kernel.org>; Sun, 11 Dec 2022 15:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgFSXFju/+r0STY1MVmIS5LIOsSrzhEK6pdwbE8ebFlSnhGhC1wQ6HzXdzHuTybmAGcDgaR1bYpTASlyE0o2lzNtb5WFixP85ohnzoVNTtPoe4PFgDshGRQaEspFGUo1nMQ5lYJr6HqRP9BetqASVb4sKywS3segJ3WkZs8TmZKTq04qRRtsba2lrP65rrS/xjk2aqMvuQLSoIe9FMHl5JoFCgNbnozgiG9w5A/t7FlfkHLEe3bRKgHtwFafkfSE3N3/JvaasZ7RfzWLdkYxxi/HqHTvQmhFA2V1JIXOl0sc+Evm10scSSRV5SBosQJnengIMI689NlfPPinupp2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+V2ooPMckPGtKHbmpLodqNIXm9U/K9yZqi1C5VLuKo=;
 b=appMYNDAw+0iWDaIKNlPr2L9t3rQb87aRgoU/Pz2FKZ8zlim855ZwYfcMSGMx976ABjcX64qB/4pqcaGvLPfxWV/IaaQnQ5ZL21Iakd9RP31W3q+PpHNI5V6crLMHJnPud7spihvLPgB6iQ6XFdxcUUPzpFqQ9zYAhBJ+J0qtZKuMdcIOmY1qBzEcyQb7JZG+MNml5AcQgr/3MGZaG5d5myKl3WV6wlfVsON9uuZFGaPqYdv4PXRjv0lsjEX6mG3oGTes9RIQx6B108l7NTT8077QDaE6CHWeyN2Bxcg2YFy09ObmqV/Jy1KKLfzc2f4XIaDueLy7AElVuFr0tvMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+V2ooPMckPGtKHbmpLodqNIXm9U/K9yZqi1C5VLuKo=;
 b=HBJJ4g5M1TMtyOCFVIdjv1ACi3NTeXMWSv9BtREMhlYGML+gCxPAqfvs0fVfQezbzhFAFAvo16ECxXMvHIuufRjpCVjym2XuewpBTqnNtUzvK2ACSWgmFczymDYwUuWCMEgUrMUL/KWkbyQYXPkLth4CeCcDK7XwcWyo7Vm8jVg=
Received: from TYAPR01MB4912.jpnprd01.prod.outlook.com (2603:1096:404:12c::17)
 by OS3PR01MB8368.jpnprd01.prod.outlook.com (2603:1096:604:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 11 Dec
 2022 23:46:52 +0000
Received: from TYAPR01MB4912.jpnprd01.prod.outlook.com
 ([fe80::abe6:a95f:c66f:1c20]) by TYAPR01MB4912.jpnprd01.prod.outlook.com
 ([fe80::abe6:a95f:c66f:1c20%4]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 23:46:52 +0000
From:   =?utf-8?B?U0hJTUFNT1RPIEhJUk9TSEko5bO25pys44CA6KOV5b+XKQ==?= 
        <h-shimamoto@nec.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        minoura <minoura@valinux.co.jp>
Subject: RE: [PATCH v2] SUNRPC: serialize gss upcalls for the same uid
Thread-Topic: [PATCH v2] SUNRPC: serialize gss upcalls for the same uid
Thread-Index: AQHZC2W+YGHmcZtW/EanzwyCw8yTfK5nfbWAgAHde/A=
Date:   Sun, 11 Dec 2022 23:46:52 +0000
Message-ID: <TYAPR01MB4912AC9E9990F9A884352D8CFF1E9@TYAPR01MB4912.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: TYAPR01MB4912:EE_|OS3PR01MB8368:EE_
x-ms-office365-filtering-correlation-id: 3cd79b29-1321-450e-d3f6-08dadbd1fac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yxbr/4wXegIjmbKMsasZmHmMEECM91Xfi/tC9vSGfd/dazzSvPar7w3gwmoCYPkb/0Mo13yWcVi3lgCqeqqeavfbifmyXOo4Zx2fFSCD/3WEOhQoF1DnM1BC3At2rEBM5WLRfyxcOQX6aP/ohXF3+8/7YDpCQE5ODHHNwel//7Ks9ne5kih9dMXimgO3gugz4szpSre8BPD4Iy40z6LPHkWfV1jC7jCJHMt61AOeANpSW+vySj155esAjcaHZYJrPtoGqxe4L7uEJTkojtpZgGrz3+Ckc6WTkqb/bMYv9Ss9te0lavwLINfJH+O9Wtj8FwPt/zx9Bwj5oKPLKQ1GwiU34IDMjuFn4iRcG4HyRmp5fZcRLaj2cfCOhZiSKORIljFiqHeTlCe+Xwcr92n2NZbQjeemaDnKd1a7Ezg/Lag6kDq0/KYbCGhYMOrQn1lYCnPHV4ohPuqYqCzCkME4bdQAMouGxPyj2Bg4VJpmWfGqxfqzTRxzXghC2VLRpl7cA9pi1IOtgyVCVL8Y2tFcvVsIMZN46hq4dhyaY+L3llY3OBhaaYn5csU/OYeCgCGdTDeVuiDso1uVOvEWb3Q0Pah7T5IFXtsle4BiyLbebWR4WrVTN2rMASGLaqnr41Zr9/D0cyI7Ig18F6eq1DCSBUKFjVwqHNUmOER/dKW9JlhhJE+NIyrT/nsn3Y0LsMBHwqJ8fZT7xybXTWTTw8fM9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4912.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199015)(8936002)(64756008)(66556008)(66476007)(66446008)(66946007)(26005)(76116006)(9686003)(85182001)(186003)(2906002)(52536014)(122000001)(33656002)(38100700002)(38070700005)(54906003)(82960400001)(83380400001)(6916009)(316002)(5660300002)(71200400001)(55016003)(478600001)(8676002)(6506007)(4326008)(41300700001)(53546011)(86362001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVd3a0hTanBZVzFjU1FmNjNpWTkwdmxJa3VHWDNhSjgzNDY1cUtWTkJBeXVN?=
 =?utf-8?B?LzN2VXFoaEdPdytZQUtibnVGYnEzc2F3a1hJem40RVZLZXlIdW9IYmdiWjJI?=
 =?utf-8?B?VExPQkpDTmgwbTI1T2VyaGVWQm5JNWpOTXkyaFRrQ3hScEMrZ29IdW1EZGpU?=
 =?utf-8?B?MG9IMDhyVUhhU1Q3VGxoWUQxRFJtYlNyZDBBWFRuQ2MxcnBZUEY4WU1TMVUy?=
 =?utf-8?B?WXhoQ2dKNkJJRGhTVnhiMERRL1lkOUgxeEtleCtCVlc2NWdSNXk5UjFFRWZO?=
 =?utf-8?B?WUtId0ZGa0ZQa2pOUnM4WG81VnlETDhaUEJUZllRaGNlOUtlV3MwSlVWZDVH?=
 =?utf-8?B?SFV1SG9TOThBbWtSZmNROHBSamNSVDlLaTkxdE1VRlFqV1pETVM0Y2JROTEr?=
 =?utf-8?B?Z2JVeHEvVzdwMi94S0Nzb0tiYzlPQUE2Qm1sNnEzeUNyNHF0bi92bWJxMkps?=
 =?utf-8?B?ZTdxSGViTUxNZ0hudFRWUUdEWlhsMVFSKzVlZTI5ajVpRnNHZVBzWUlpZ1J5?=
 =?utf-8?B?SThyZ2I1OENZaDI3UDZHYlVmblFHMXVYVi9ZblczS00vOTdVZXArNXNNcjJj?=
 =?utf-8?B?aXF0Mk5NU0lQQVlkUWNmd0ZIZC9SU1hNNytPM2t2MWsvRUNtODhNdUh2Q3g3?=
 =?utf-8?B?U1ZSK2xBOE5HN3l6N0JqanZYbGprREo3RkwwNHdrNkNvL1kwSEFJMFJnN3B3?=
 =?utf-8?B?b0ErenZnTE9YRTRoSm0raHpRVUFTVG1zRWluQnRKZ2ZyQzB4eStxWkZmWUN2?=
 =?utf-8?B?eVNUUUs2Zm1NT0RwYStpLzcvdEVvTC96KzlWaFh4UGI0MnI5Q05CdFBrTXQ3?=
 =?utf-8?B?QXlyRVpack5HVXdGNE1SSnVBUmdkNy9wcVFSdWM3UHZkdU9JNTRYUTEzU2U3?=
 =?utf-8?B?MW9uV1VXSEwzTFhHZTVra1BITHYraGNLSmwrWUk5NHlyV2hXQ1JGTjVwUUlM?=
 =?utf-8?B?Si9YMmdDbUNvVW02cHBGY21uRmFHbmYwMjhWNDdqZW5LZk1aMHYrZ0plaldo?=
 =?utf-8?B?QXVQT2d3VDNTMExlUFl6c3JkaHFCTG5Uamc5Wk5EeEVrUGpFbEdkbURDenRW?=
 =?utf-8?B?cWNUZHR4SFBLUW9sNCtsYks0OFlPNTVvc1ptcWNlZFJNUHczejdOQUtCZzhW?=
 =?utf-8?B?ZWZrQkphY0Qva01JWThFdThCSzZ6VFh5TGZpU2ZJTlNYZEhuMGlveHBZZGZS?=
 =?utf-8?B?YjJRajdYa1J0VmJsSHpLdUdaRDBBWlJ4eHhzT2dEdm45dERqaW9zeEl4K0di?=
 =?utf-8?B?YXMrWDdkb3FybWdnclVxT011c2x3TjcreExZY1I2K2Z5OGs1Z0hlT1h2d2Jy?=
 =?utf-8?B?THFCQ09GYnZXMG5ic1paZ0d4UytDL3JObzk4K09HSWJPM2RYcTJmUTV4dEZj?=
 =?utf-8?B?ZVFKRXFJcXNucWRXYVhPbFhyOWNYWTdJbXZrb2lQU1QzcWhScFdRSnBKcDht?=
 =?utf-8?B?bUVJZzZwVE1GNi9FU3hTVlBnZWZvZC8rZ1FSdkVjOWxLMDBBSCs5b1B1a0Nv?=
 =?utf-8?B?SzRxTVRPQnJXbWw5K2lUdlpwV0hnOFNqQzQ2QThrMWdDa01YSlM4WVNRQXc0?=
 =?utf-8?B?QW5YTzY0ejFqWFllN0dmMWtNRjV0bHY1eHU3V0VNSjdEdGt1Q2xCcXZjUm5I?=
 =?utf-8?B?QzlXaWtSc054bkVIRlJ4NEtsYTViMTlQbjVjL2ZWV28xTTJHM0VDaTlkallL?=
 =?utf-8?B?ZDJrQkFYanFMT3k2QS9XSUlSOEh4MmVZOGlxWEM5WVdvdm1OUUhGenl6QnJk?=
 =?utf-8?B?TnhBZmFmTzRtdUhENDRZM2RXYUlEQnN6YnJwUmJBTXlUK3EvYWNtS0hnTW1L?=
 =?utf-8?B?Wk1nZEQ0Nk5qaFJFYVJXNllxT3RNV2NjZ3cvNFpQVVk0ZWZaeGwrMlhBYUxo?=
 =?utf-8?B?OHV3eVQvSHp3K09pSlhjSkNKTUhUdTRtbW1mY3E4U0UxdFpjQUJjY3FIOU1G?=
 =?utf-8?B?aGJlM0N3ZnMzWGcrbERwc3IwUFpJZi93NXZoWDA4dStGa1hiUklSMjhYcVdz?=
 =?utf-8?B?c0hVWnAybFdNWTNoaGtTR0ZGbTg3TGJlYzZaeFAzMjY0NnkydU1zZHN0YzBv?=
 =?utf-8?B?czFjOFRoeUx3bDBocnlIRVVpeHAwQkYzc0V0VzRlc0RJTzJYQjBVdENkZzhF?=
 =?utf-8?Q?czo72eIndu58YCS2nUmkLRiEV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4912.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd79b29-1321-450e-d3f6-08dadbd1fac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2022 23:46:52.8303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZZ6FX8x36Elzt56ry21rGU2AyN7CIz3kYU0xjn9ZsBSzaBWmZvavrmOwLnJ4qZMnl5nClSHZwgwyI22NXGkjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8368
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
b3ZlIHNlcGFyYXRlcyB0aGUgc2VydmljZXMNCj4gaW4gZ3NzX2FkZF9tc2coKS4NCg0KVGhhbmtz
IHRvIGRlc2NyaWJlIHRoZSBiZWhhdmlvciwgbm93IEkgc2VlIHRoZSBvcmRlcmluZyBoYWRuJ3Qg
Y2F1c2VkIGEgcHJvYmxlbS4NCkkgaGFkIHRob3VnaHQgdGhlIG9yZGVyaW5nIGlzIHRoZSByb290
IGNhdXNlIHRvIGJlIGZpeGVkLCBidXQgSSBoYXZlIHVuZGVyc3Rvb2QgZml4aW5nIHRoZSByYWNl
IHRvIGNhdXNlIHdyb25nbHkgY2xlYXIgZXJybm8gaXMgZW5vdWdoLg0KDQpUaGFua3MsDQpIaXJv
c2hpDQoNCj4gDQo+ID4NCj4gPiBBY3R1YWwgc2NoZWR1aW5nIG9mIHRoYXQgcHJvY2VzcyBtaWdo
dCBiZSBhZnRlciBycGMuZ3NzZCBwcm9jZXNzZXMgdGhlDQo+ID4gbmV4dCBtc2cuICBJbiBycGNf
cGlwZV9nZW5lcmljX3VwY2FsbCBpdCBjbGVhcnMgbXNnLT5lcnJubyAoZm9yIEEpLg0KPiA+IFRo
ZSBwcm9jZXNzIGlzIHNjaGVkdWxlZCB0byBzZWUgZ3NzX21zZy0+Y3R4ID09IE5VTEwgYW5kDQo+
ID4gZ3NzX21zZy0+bXNnLmVycm5vID09IDAsIHRoZXJlZm9yZSBpdCBjYW5ub3QgYnJlYWsgdGhl
IGxvb3AgaW4NCj4gPiBnc3NfY3JlYXRlX3VwY2FsbCBhbmQgaXMgbmV2ZXIgd29rZW4gdXAgYWZ0
ZXIgdGhhdC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyB3YWl0IGFuZCByZXRyeSBh
dCBnc3NfYWRkX21zZygpIHRvIHNlcmlhbGl6ZQ0KPiA+IHdoZW4gcmVxdWVzdHMgd2l0aCB0aGUg
c2FtZSB1aWQgYnV0IGRpZmZlcmVudCBzZXJ2aWNlIGNvbWVzLg0KPiANCj4gQXMgbG9uZyBhcyBy
cGMuZ3NzZCByZXR1cm5zIG9uZSBjb250ZXh0IGRvd25jYWxsIGZvciBlYWNoIHVwY2FsbCAob3Ig
aXQgYnJlYWtzIHRoZSBjb25uZWN0aW9uIGluIG9yZGVyIHRvDQo+IGZvcmNlIGEgcmV0cmFuc21p
c3Npb24pIHRoZW4gd2Ugc2hvdWxkbuKAmXQgaGF2ZSB0byBzZXJpYWxpc2UgYW55dGhpbmcuDQo+
IA0KPiBIb3dldmVyIHdoYXQgd2UgY291bGQgZG8gdG8gZml4IHRoZSByYWNlIHlvdSBhcHBlYXIg
dG8gYmUgZGVzY3JpYmluZyBpcyB0byBjaGVjayBpZiB0aGUgdXBjYWxsIGhhcyBjb21wbGV0ZWQN
Cj4geWV0IGJlZm9yZSB3ZSBhY2NlcHQgdGhlIG1lc3NhZ2UgYXMgYSBjYW5kaWRhdGUgZm9yIHRo
ZSBkb3duY2FsbC4gVGhhdCBjb3VsZCBiZSBqdXN0IGEgc2ltcGxlIGNoZWNrIGZvcg0KPiAobXNn
LT5jb3BpZWQgIT0gMCAmJiBsaXN0X2VtcHR5KCZtc2ctPmxpc3QpKS4gTWF5YmUgYWRkIGEgaGVs
cGVyIGZvciB0aGF0IGluDQo+IGluY2x1ZGUvbGludXgvc3VucnBjL3JwY19waXBlX2ZzLmg/DQo+
IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IFRyb25kIE15a2xl
YnVzdA0KPiBMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQo+IHRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
