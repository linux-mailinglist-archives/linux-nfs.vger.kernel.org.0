Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB664904E
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Dec 2022 20:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLJTEv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Dec 2022 14:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLJTEt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Dec 2022 14:04:49 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2107.outbound.protection.outlook.com [40.107.93.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3CE7652
        for <linux-nfs@vger.kernel.org>; Sat, 10 Dec 2022 11:04:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEy/SjsdiGmKjl/u8Vh2v14mnUinNXmldDFZ2aNjB/Le8nrIGiF+JEwTBjjwIDBrACIHdxE8rvqyIq4GOhIhJYNV83qLSqBGLbOgqBaSVdF0H6RHTNwxZyC/Hpvii/+X+rLWRePX4fJ0E+sqs9y3c7QZhEaPgGYMHo+uyyMu6TQo3cQaDlWmOrIm+zXxTIyhmGOGJ1EI6Pdr5WNAdYq/QlhR7xUIeFqiyme5B0zJdWHmzONbVrMIpMLOp62+/jprReqaz0793faPbrMocU7EFxGGY6ZSnA2twzSpE0nGtIeNlJpxopLX1wmBOQa5oVy1TH1w2N6EeYlD5xNZk3P2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiGxezbyAc1GJXFkykECv+9wS5bO+Kye6meWmO3xDmw=;
 b=eG2U6om/ZH44HilftaSZX4yp0n0fhdwC0AXxWAxkMpavsQtiWMr51i0pbRv5qCyC4ucGctyPyooNVtjSXFgMwhnv2l6V+gvUJdf6mIKJFkszOCDxvNWx3C+X3BlVMYyoWmYIm8W9i42TFsNwKJ5EA1i0925tc9DLk6wosToQB4WfI+Co8Pg9KqPQGpfuMF8Vf+XKs9ZoOoHIhLZ7hucGikTr8b8R8cHgzD7OWwP0+7GtoDhG8rUKFPzTEMmApuzoF8/NXeSklS4sYMX1tknXjmoMP4eSVvCVNgRnUJwZ+0p5pWoIIpTh6PrlpJWgIes6dWsxujsDqmB0z8hKXUyaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiGxezbyAc1GJXFkykECv+9wS5bO+Kye6meWmO3xDmw=;
 b=C4gtD5RL9P68RI81JZyL+dibP+KEwqb6c2TPEHBlHXJmzeWhNfExGMAkBqzW+bBrcKT/969uBc9Gsy4gcoU9r4gWjqyw9tp2i2cd27izbIuTCEznNErzWWBruW5kr//EWA0dtyyyzyeVdiPrpR+PUoxl3T1d49XWEKkQZCvbxiA=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 BY5PR13MB4422.namprd13.prod.outlook.com (2603:10b6:a03:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 10 Dec
 2022 19:04:39 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::c88f:541d:a384:90bd]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::c88f:541d:a384:90bd%6]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 19:04:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Hiroshi Shimamoto <h-shimamoto@nec.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        minoura <minoura@valinux.co.jp>
Subject: Re: [PATCH v2] SUNRPC: serialize gss upcalls for the same uid
Thread-Topic: [PATCH v2] SUNRPC: serialize gss upcalls for the same uid
Thread-Index: AQHZC2W+12NqjQx7c0asm/BWMZGht65nfagA
Date:   Sat, 10 Dec 2022 19:04:39 +0000
Message-ID: <17D036AA-5F8A-497B-9D66-879E9D201BDD@hammerspace.com>
References: <20221209003032.3211581-1-h-shimamoto@nec.com>
In-Reply-To: <20221209003032.3211581-1-h-shimamoto@nec.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|BY5PR13MB4422:EE_
x-ms-office365-filtering-correlation-id: 35701d5e-b115-4339-2449-08dadae16356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLGR9gQyKexd6qzQZbP0mbaQzfDfEInsbKG01t6Inrb7hnyukvWFIUJCmNfChJ7+bm0qU0mvdD+eUc0gd7SyB+oHP+8OU7gVQ7+4ioYXtCqZjpJsJcP3JPNLm2wrappDHfL7oVVfc9oRmblh3IxWnxCg1zSKYSNMClBDTMBI6wA/i3FgArirS+PfgdjDWF3E2zhsqrDj0/Wu75/zwu0UN2+a26WmRx1qyyjdCpJtbTxu2fVzD9BkjDHo9/FgByFRD5tHuJVyX+suhMcOPBcoUit9PncyXJZ3BlY5IqBREWhzXp56MLCLV9SgqDST1AkGnS+kLsv48Od7PlSCiOCfNmvHGQ34A4F2YoSvPQ8cJuKplQJ4+3G8hBD3bqWzblcvr7smUSWiDd+2W5LOMAmopl/vwxT2+J2JU75h/4+qXllFJEnj1F49Q+/Z5Zv0BeaU65xRx6+NcK9ZoIxjYvl7CkDMKfw1LAGnHmRSAgusUpX/FwOTcx/u3HzDuVCPDBAQ42VU42hluXl216VJRcMwCq5A+/OJKUBQrn/YvN0ENHNHjvB3Ctziz97YP4gdZdwTjdGiux3fADPF4LvQafUpBLiPpbmIb8JnJhKgdVS0Wy+uJSmcmHFFlMvZkyc1PIRMgNcPT7XF0W30SxuJmFOgynrOvD9UP/dXmIK7ONiMFRtAKmm5nQqgV61VO/y0ZkrVdCP+bdsofyRVU0atZJAjsJDsyXxhd9Tu0JAyPd/YxHs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39830400003)(136003)(451199015)(316002)(6916009)(54906003)(71200400001)(53546011)(6506007)(26005)(6512007)(36756003)(2906002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(2616005)(91956017)(66476007)(33656002)(76116006)(66446008)(8676002)(64756008)(66946007)(66556008)(8936002)(4326008)(5660300002)(41300700001)(86362001)(478600001)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3JhNnNzRDYzZnhray9jOVVweDJ3dUtGVWxFMGVzMVgvVUEzUVFOYXgwdGpI?=
 =?utf-8?B?NEJ3cktpVnBWYXlBZC84OXJ3U0lYcUh1UDluVHpvOVJFMlBPQ054RDByTi83?=
 =?utf-8?B?bm9seDVWSkg0N3pZSGk3amlkYUhpWHNROXgvSWRRTURZZ2doSG1VeTE0K0Mx?=
 =?utf-8?B?TVp1bHN4TXptaDdIaTUydkF1Q3BlTVpCRnZJOVBUMHEweXJJTytjLzVRZTlv?=
 =?utf-8?B?R0I4Z2NjNWZ1ZXp1RWxtWThmOUdPYm0zMGFjYkZXRG41VVduc1ExRDVrZDBS?=
 =?utf-8?B?UUkyY3pIZHNRL2JmMmsrV2xsQjk3aWNpeElHOGRjSHVsaGdzL2lZMGJaRkhw?=
 =?utf-8?B?RnZyRWdhT1V3bklUN2xQdTRuLzZvTnJwZ3dmLzJLVSs0ZU1jR2dwMStFZkpu?=
 =?utf-8?B?REpXZkdCR2xxM1RuL054VXh5SE9mcU9SOXczOFR0YWtMdHVDcWJOb2hobkg0?=
 =?utf-8?B?U2I2YWRvWU41UVdWTGozcHU3WklRSkdTTmx0UkFNY3pMQk8vR3ZHTDhBRGRF?=
 =?utf-8?B?Ny9jMng5M2dWN2Y4RnZianNVdk5nYTZldzhDR1luQ01sWHRrNWJmY09JdnQ3?=
 =?utf-8?B?TjFDcVY0VjFYUTA3cCtFMVNhbVlpZVRhd1BMYXNtaCt0ejlVbHdWT1luQ2Zs?=
 =?utf-8?B?VTA4WnJ4Zkk3ZEFtZWgxWlZLdWNtVjFxdEpPT3NSZU5WTm1wcUhTNGJOWitz?=
 =?utf-8?B?UUcxaDhFNE8yRGh4TGsvVHRrL1BCbm1ORitycmhNeEFSMkpjRHg1Y2YwNTZK?=
 =?utf-8?B?eVEzZXFGMnRFcGVvUEtiYWkyMzdpbnFMZEhDZGxCbzJPM1FMMVRvTkVzQ1Bz?=
 =?utf-8?B?MWs5eUF4V3pqSm1VZWZyeFBuVm41a3NwVVF2TFJhTkEvT2NWRlFVUmR3RXVG?=
 =?utf-8?B?Q0FqUzV6NG9OZzdaYTh6Y0dyd0dLMGwxRnBGNUQyK25lQ2t6Rnl0bjBZRlY1?=
 =?utf-8?B?TDZVcjZRaGdFcmFZSEl5RW1jY2VYc2pnMFMvS3NFMkJBM1h5Y3l5UkoxdlpZ?=
 =?utf-8?B?YXdTZ2ZZYUNJcDMyeEFjOHhVc0FXYzdpTktmVUYwaUJURlhxWk1OMkNtaWlX?=
 =?utf-8?B?am5idVNqRkhwVE5OZG5UclMvNmtyTmk0QzJOQW9XMjN6alVpRW1ET3ZhNFFl?=
 =?utf-8?B?blZ5YVVzanpEWGFTYlNKNnU5Z3JKSVlzTHNpUVJqcHFsMVZkQ0dGL1JNdDBJ?=
 =?utf-8?B?WXFMNWNGQlJvV0NaSS8zOVhxZWlBeE4yQlk3WVVLZXB4UStkNGZ4Ky9WMVRI?=
 =?utf-8?B?MGd4RGIxcnZNdC96ZlB1L2dILzhHS2h1ZTJtSmV2S2VUbzlTVnZ6RnJ3OXhM?=
 =?utf-8?B?eENyYm5qTW13a2hsMXpQaHg2TDVTSFd3V2xLclhRRXlwMktRMlpnekdWWW1s?=
 =?utf-8?B?SkhJdnk4V2ZsY2tUMnhUNS9PUlZMUjA2WDYranFJK0NDWlpXbitjRE1qUCtC?=
 =?utf-8?B?aWtVZUJvV1BrS2hnK3pZOU90V2tIMjFjUExKR2JyNzZBekZEMnorQVVkMlRM?=
 =?utf-8?B?WVhHRVMwTGFodDVNbHV4TlFpWDNFTWxzQjZOZ3ZNS05teDc2RGVwekFKTzhp?=
 =?utf-8?B?MXpJdG1FWWpMalJaTHRCS1RFVm9xYnR4TlJtelhDWnFjQkI5OVVYcU0weVdj?=
 =?utf-8?B?dWRZQzZNR1c5cEgxc2JmNzIyaHVmSW5Rb0toNk5qeUJHNWo3Q1hTQ2N5SDJu?=
 =?utf-8?B?Mk4ySTA1VWlib3VoSG9GVmhXTzdhTHlpaWtRZUpsR0I3RkpOYnE5QjRSMTRW?=
 =?utf-8?B?bkhrYXcrUWFuazI4MHM1bE5nQWY0ZkxoVkpEMFBMZ3hvMkFxMC91d2ppaklK?=
 =?utf-8?B?bC9RNExheUdsamdOVkVVRlRkRmJwVDNicHVoeFloRWxoSGh0WmFUS28xUkI2?=
 =?utf-8?B?SzlOdGNxdk5BSHJqYk5Jb0gwbTZCUXJvZHQ1a3k1S0ZJM2JPOTVld2ZoSTda?=
 =?utf-8?B?Zno5UFpRTmtKakFEaWs4SVJPcVd2amwyMWNma0pnZENuMmptbE9aYndzRjUy?=
 =?utf-8?B?TkFYMFpNanZoY1Z3WXNrRG5mT3ZBRnJ5RVRFZmQxNGlVTnQxQUFVQnpUOVBZ?=
 =?utf-8?B?dzdpRjB5ZDY5QU9Xa05RS0lOQUNSekE4TDcyV0JOdTNQTGdUTlg5ZGFlM2ZF?=
 =?utf-8?B?VWxDRU1rZjV5UW00Kzh5Z0VKYk1IajhjNzFnUmMvMUhBZkxZL1o5V0FtcStW?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2254DED39F17C648BEF7B63B1A4C66D8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35701d5e-b115-4339-2449-08dadae16356
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2022 19:04:39.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFEXmFUO2zkZG3MuJo1fvmwYKSPDRAe1TJrFt0HK2hNI70cIEiRyPmfEKjGgfKli7Ak0O0wyHpRCCeybO/wtPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRGVjIDgsIDIwMjIsIGF0IDE5OjMwLCBIaXJvc2hpIFNoaW1hbW90byA8aC1zaGlt
YW1vdG9AbmVjLmNvbT4gd3JvdGU6DQo+IA0KPiBGcm9tOiBtaW5vdXJhIDxtaW5vdXJhQHZhbGlu
dXguY28uanA+DQo+IA0KPiBDb21taXQgOTEzMGI4ZGJjNmFjICgiU1VOUlBDOiBhbGxvdyBmb3Ig
dXBjYWxscyBmb3IgdGhlIHNhbWUgdWlkDQo+IGJ1dCBkaWZmZXJlbnQgZ3NzIHNlcnZpY2UiKSBp
bnRyb2R1Y2VkIGBhdXRoYCBhcmd1bWVudCB0bw0KPiBfX2dzc19maW5kX3VwY2FsbCgpLCBidXQg
aW4gZ3NzX3BpcGVfZG93bmNhbGwoKSBpdCB3YXMgbGVmdCBhcyBOVUxMDQo+IHNpbmNlIGl0IChh
bmQgYXV0aC0+c2VydmljZSkgd2FzIG5vdCAoeWV0KSBkZXRlcm1pbmVkLg0KPiANCj4gV2hlbiBt
dWx0aXBsZSB1cGNhbGxzIHdpdGggdGhlIHNhbWUgdWlkIGFuZCBkaWZmZXJlbnQgc2VydmljZSBh
cmUNCj4gb25nb2luZywgaXQgY291bGQgaGFwcGVuIHRoYXQgX19nc3NfZmluZF91cGNhbGwoKSwg
d2hpY2ggcmV0dXJucyB0aGUNCj4gZmlyc3QgbWF0Y2ggZm91bmQgaW4gdGhlIHBpcGUtPmluX2Rv
d25jYWxsIGxpc3QsIGNvdWxkIG5vdCBmaW5kIHRoZQ0KPiBjb3JyZWN0IGdzc19tc2cgY29ycmVz
cG9uZGluZyB0byB0aGUgZG93bmNhbGwgd2UgYXJlIGxvb2tpbmcgZm9yIGR1ZQ0KPiB0byB0d28g
cmVhc29uczoNCj4gDQo+IC0gdGhlIG9yZGVyIG9mIHRoZSBtc2dzIGluIHBpcGUtPmluX2Rvd25j
YWxsIGFuZCB0aG9zZSBpbiBwaXBlLT5waXBlDQo+ICAodGhhdCBpcywgdGhlIG9yZGVyIG9mIHRo
ZSB1cGNhbGxzIHNlbnQgdG8gcnBjLmdzc2QpIG1pZ2h0IGJlDQo+ICBkaWZmZXJlbnQgYmVjYXVz
ZSBwaXBlLT5sb2NrIGlzIGRyb3BwZWQgYmV0d2VlbiBhZGRpbmcgb25lIHRvIGVhY2gNCj4gIGxp
c3QuDQo+IC0gcnBjLmdzc2QgdXNlcyB0aHJlYWRzIHRvIHdyaXRlIHJlc3BvbnNlcywgd2hpY2gg
bWVhbnMgd2UgY2Fubm90DQo+ICBndWFyYW50ZWUgdGhlIG9yZGVyIG9mIHJlc3BvbnNlcy4NCj4g
DQo+IFdlIGNvdWxkIHNlZSBtb3VudC5uZnMgcHJvY2VzcyBodW5nIGluIEQgc3RhdGUgd2l0aCBt
dWx0aXBsZSBtb3VudC5uZnMNCj4gYXJlIGV4ZWN1dGVkIGluIHBhcmFsbGVsLiAgVGhlIGNhbGwg
dHJhY2UgYmVsb3cgaXMgb2YgQ2VudE9TIDcuOQ0KPiBrZXJuZWwtMy4xMC4wLTExNjAuMjQuMS5l
bDcueDg2XzY0IGJ1dCB3ZSBvYnNlcnZlZCB0aGUgc2FtZSBoYW5nIHcvDQo+IGVscmVwbyBrZXJu
ZWwtbWwtNi4wLjctMS5lbDcuDQo+IA0KPiBQSUQ6IDcxMjU4ICBUQVNLOiBmZmZmOTFlYmQ0YmUw
MDAwICBDUFU6IDM2ICBDT01NQU5EOiAibW91bnQubmZzIg0KPiAjMCBbZmZmZjkyMDNjYTMyMzRm
OF0gX19zY2hlZHVsZSBhdCBmZmZmZmZmZmEzYjg4OTlmDQo+ICMxIFtmZmZmOTIwM2NhMzIzNTgw
XSBzY2hlZHVsZSBhdCBmZmZmZmZmZmEzYjg4ZWI5DQo+ICMyIFtmZmZmOTIwM2NhMzIzNTkwXSBn
c3NfY3JlZF9pbml0IGF0IGZmZmZmZmZmYzAzNTU4MTggW2F1dGhfcnBjZ3NzXQ0KPiAjMyBbZmZm
ZjkyMDNjYTMyMzY1OF0gcnBjYXV0aF9sb29rdXBfY3JlZGNhY2hlIGF0IGZmZmZmZmZmYzA0MjFl
YmMgW3N1bnJwY10NCj4gIzQgW2ZmZmY5MjAzY2EzMjM2ZDhdIGdzc19sb29rdXBfY3JlZCBhdCBm
ZmZmZmZmZmMwMzUzNjMzIFthdXRoX3JwY2dzc10NCj4gIzUgW2ZmZmY5MjAzY2EzMjM2ZThdIHJw
Y2F1dGhfbG9va3VwY3JlZCBhdCBmZmZmZmZmZmMwNDIxNTgxIFtzdW5ycGNdDQo+ICM2IFtmZmZm
OTIwM2NhMzIzNzQwXSBycGNhdXRoX3JlZnJlc2hjcmVkIGF0IGZmZmZmZmZmYzA0MjIzZDMgW3N1
bnJwY10NCj4gIzcgW2ZmZmY5MjAzY2EzMjM3YTBdIGNhbGxfcmVmcmVzaCBhdCBmZmZmZmZmZmMw
NDEwM2RjIFtzdW5ycGNdDQo+ICM4IFtmZmZmOTIwM2NhMzIzN2I4XSBfX3JwY19leGVjdXRlIGF0
IGZmZmZmZmZmYzA0MWUxYzkgW3N1bnJwY10NCj4gIzkgW2ZmZmY5MjAzY2EzMjM4MjBdIHJwY19l
eGVjdXRlIGF0IGZmZmZmZmZmYzA0MjBhNDggW3N1bnJwY10NCj4gDQo+IFRoZSBzY2VuYXJpbyBp
cyBsaWtlIHRoaXMuIExldCdzIHNheSB0aGVyZSBhcmUgdHdvIHVwY2FsbHMgZm9yDQo+IHNlcnZp
Y2VzIEEgYW5kIEIsIEEgLT4gQiBpbiBwaXBlLT5pbl9kb3duY2FsbCwgQiAtPiBBIGluIHBpcGUt
PnBpcGUuDQo+IA0KPiBXaGVuIHJwYy5nc3NkIHJlYWRzIHBpcGUgdG8gZ2V0IHRoZSB1cGNhbGwg
bXNnIGNvcnJlc3BvbmRpbmcgdG8NCj4gc2VydmljZSBCIGZyb20gcGlwZS0+cGlwZSBhbmQgdGhl
biB3cml0ZXMgdGhlIHJlc3BvbnNlLCBpbg0KPiBnc3NfcGlwZV9kb3duY2FsbCB0aGUgbXNnIGNv
cnJlc3BvbmRpbmcgdG8gc2VydmljZSBBIHdpbGwgYmUgcGlja2VkDQo+IGJlY2F1c2Ugb25seSB1
aWQgaXMgdXNlZCB0byBmaW5kIHRoZSBtc2cgYW5kIGl0IGlzIGJlZm9yZSB0aGUgb25lIGZvcg0K
PiBCIGluIHBpcGUtPmluX2Rvd25jYWxsLiAgQW5kIHRoZSBwcm9jZXNzIHdhaXRpbmcgZm9yIHRo
ZSBtc2cNCj4gY29ycmVzcG9uZGluZyB0byBzZXJ2aWNlIEEgd2lsbCBiZSB3b2tlbiB1cC4NCg0K
V2FpdCBhIG1pbnV0ZeKApiBUaGUg4oCYc2VydmljZeKAmSBoZXJlIGlzIG9uZSBvZiBrcmI1LCBr
cmI1aSwgb3Iga3JiNXAuIFdoYXQgaXMgYmVpbmcgcHVzaGVkIGRvd24gZnJvbSB1c2VyIHNwYWNl
IGlzIGEgUlBDU0VDX0dTUyBjb250ZXh0IHRoYXQgY2FuIGJlIHVzZWQgZm9yIGFueSBvbmUgb2Yg
dGhvc2Ugc2VydmljZXMuIFNvIHRoZSBvcmRlcmluZyBvZiBBIGFuZCBCIGlzIG5vdCBzdXBwb3Nl
ZCB0byBtYXR0ZXIuIEFueSBvbmUgb2YgdGhvc2UgcmVxdWVzdHMgY2FuIHRha2UgdGhlIGNvbnRl
eHQgYW5kIG1ha2UgdXNlIG9mIGl0Lg0KDQpIb3dldmVyIG9uY2UgdGhlIGNvbnRleHQgaGFzIGJl
ZW4gdXNlZCB3aXRoIG9uZSBvZiB0aGUga3JiNSwga3JiNWkgb3Iga3JiNXAgc2VydmljZXMgdGhl
biBpdCBjYW5ub3QgYmUgdXNlZCB3aXRoIGFueSBvZiB0aGUgb3RoZXJzLiBUaGlzIGlzIHdoeSBj
b21taXQgOTEzMGI4ZGJjNmFjIHRoYXQgeW91IHJlZmVyZW5jZWQgYWJvdmUgc2VwYXJhdGVzIHRo
ZSBzZXJ2aWNlcyBpbiBnc3NfYWRkX21zZygpLg0KDQo+IA0KPiBBY3R1YWwgc2NoZWR1aW5nIG9m
IHRoYXQgcHJvY2VzcyBtaWdodCBiZSBhZnRlciBycGMuZ3NzZCBwcm9jZXNzZXMgdGhlDQo+IG5l
eHQgbXNnLiAgSW4gcnBjX3BpcGVfZ2VuZXJpY191cGNhbGwgaXQgY2xlYXJzIG1zZy0+ZXJybm8g
KGZvciBBKS4NCj4gVGhlIHByb2Nlc3MgaXMgc2NoZWR1bGVkIHRvIHNlZSBnc3NfbXNnLT5jdHgg
PT0gTlVMTCBhbmQNCj4gZ3NzX21zZy0+bXNnLmVycm5vID09IDAsIHRoZXJlZm9yZSBpdCBjYW5u
b3QgYnJlYWsgdGhlIGxvb3AgaW4NCj4gZ3NzX2NyZWF0ZV91cGNhbGwgYW5kIGlzIG5ldmVyIHdv
a2VuIHVwIGFmdGVyIHRoYXQuDQo+IA0KPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgd2FpdCBhbmQg
cmV0cnkgYXQgZ3NzX2FkZF9tc2coKSB0byBzZXJpYWxpemUNCj4gd2hlbiByZXF1ZXN0cyB3aXRo
IHRoZSBzYW1lIHVpZCBidXQgZGlmZmVyZW50IHNlcnZpY2UgY29tZXMuDQoNCkFzIGxvbmcgYXMg
cnBjLmdzc2QgcmV0dXJucyBvbmUgY29udGV4dCBkb3duY2FsbCBmb3IgZWFjaCB1cGNhbGwgKG9y
IGl0IGJyZWFrcyB0aGUgY29ubmVjdGlvbiBpbiBvcmRlciB0byBmb3JjZSBhIHJldHJhbnNtaXNz
aW9uKSB0aGVuIHdlIHNob3VsZG7igJl0IGhhdmUgdG8gc2VyaWFsaXNlIGFueXRoaW5nLg0KDQpI
b3dldmVyIHdoYXQgd2UgY291bGQgZG8gdG8gZml4IHRoZSByYWNlIHlvdSBhcHBlYXIgdG8gYmUg
ZGVzY3JpYmluZyBpcyB0byBjaGVjayBpZiB0aGUgdXBjYWxsIGhhcyBjb21wbGV0ZWQgeWV0IGJl
Zm9yZSB3ZSBhY2NlcHQgdGhlIG1lc3NhZ2UgYXMgYSBjYW5kaWRhdGUgZm9yIHRoZSBkb3duY2Fs
bC4gVGhhdCBjb3VsZCBiZSBqdXN0IGEgc2ltcGxlIGNoZWNrIGZvciAobXNnLT5jb3BpZWQgIT0g
MCAmJiBsaXN0X2VtcHR5KCZtc2ctPmxpc3QpKS4gTWF5YmUgYWRkIGEgaGVscGVyIGZvciB0aGF0
IGluIGluY2x1ZGUvbGludXgvc3VucnBjL3JwY19waXBlX2ZzLmg/DQoNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0K
