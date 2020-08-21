Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5724DB7C
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Aug 2020 18:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHUQl2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Aug 2020 12:41:28 -0400
Received: from mail-eopbgr750110.outbound.protection.outlook.com ([40.107.75.110]:50754
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728648AbgHUQlK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 Aug 2020 12:41:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk6R0CxMqT8304Dy77jm40EV1ymee2hX3ygGvmeZFTqC8+j+B1ZbsFDlLq3XpE1qiPeHFDViYCr3d1CeT2Azu2KJ6ikVg7aE2ku35DkYZwB6iy6yuTuau3V+Xx9IIH4KyomwK53Vx/PONf+ka8S1Zr3yeiUwLhIBm4bug0jp7lHse/9fuPe8frHmBDQog0MPofTK1UJEuZmZ73cbV03veEJiAqPRy7hqJ+TcOjhjyyBNNcw8PyNZM9dPz0je4tFB+/kkzmDSGuXyTGo+sW58VyeGXIgczL12ebsLhD7+wMucRvCsmFdR5pw9UFF0BV7XvqeMRA8KKwfSydvDnQcv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koxWro3uOaWNMimJ1fvJjmXwMBaVO49Ks6ggkYow7ds=;
 b=QrXHICYqzIE8eV8aM0FZjtY25v9v+xdluhlK/BGNPrCkZlaSGxjH9YfX613KTCCQvnhQaaHTq/iSaeZ1DLDqhCp8/Gn7XRa6AIsyoeC+3SRYsXcyRRWWww7c/MIcrjKOmNaXtIavJOMqmZJ9NpLDhEBwKq/mwO0KZ+PUeZfMijKgAxZcqKhy1Uuuu3Ln7M9sbJ+rKCi+ZxwoUpLz9caTxt8L5ZCzOSvS+Xebv5XJ5MwBMuVkmtiWnl7frJiotte9MgiKLF7aAdlCCuwSnZa4P4oZjlf//AQaz9ipLOZfToW1YgYHqPpHV2YFzipwCVvnzwRJU048P6WV3esPVQ/eQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koxWro3uOaWNMimJ1fvJjmXwMBaVO49Ks6ggkYow7ds=;
 b=MLtw0j4J9tTd5I4+JnME/6roVhH+SVgc9/o0Ja6aqlSZ3746SuXeV2tQKGJnmIJJtYu/XMYLmumywZqZ01wwBECjgDOyB5GNIIwii5+Zrccw0s1cUhXwtaAMn0viCuOdCeiYb6O0hC8nKaucJM8939ZvPhotnfFbhJIJ42SkzU8=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3848.namprd13.prod.outlook.com (2603:10b6:610:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.13; Fri, 21 Aug
 2020 16:41:05 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756%3]) with mapi id 15.20.3326.010; Fri, 21 Aug 2020
 16:41:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "fllinden@amazon.com" <fllinden@amazon.com>,
        "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v3 12/13] NFSv4.2: hook in the user extended attribute
 handlers
Thread-Topic: [PATCH v3 12/13] NFSv4.2: hook in the user extended attribute
 handlers
Thread-Index: AQHWSa8kipls3pR5X0aknbtJ2yoJ/alCe3yAgACaaACAAAp0gA==
Date:   Fri, 21 Aug 2020 16:41:04 +0000
Message-ID: <62aa76de0ea316c029b7f9c22cf36c92b8cba2d9.camel@hammerspace.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
         <20200623223904.31643-13-fllinden@amazon.com>
         <CADJHv_tVZ3KzO_RZ18V=e6QBYEFnX5SbyVU6yhh6yCqYMmvmRQ@mail.gmail.com>
         <20200821160338.GA30541@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20200821160338.GA30541@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21243e7e-68b8-4d53-7879-08d845f0ff5a
x-ms-traffictypediagnostic: CH2PR13MB3848:
x-microsoft-antispam-prvs: <CH2PR13MB38483CFF7EB9748F11AFB6BBB85B0@CH2PR13MB3848.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nAvyU50wHID+KtZEg5qgG/rNcPPsb58kPhWMvbJG/MH/VTy2KjPvjEThZcZoNO+BJ1uMft8dkJmGnXYIybj7ZLESzOCDZ+vQvv4FJnHtQwydBSdmusc1ye6OitNNs7VpKSvZc5tkAcxACNPpauebwDLoQPAvyMNnxFR+VfogDVINqTv3x3wfcBwPuvei9iMA5AQTm5Ty5BlpyLd+CSsePABMGQ/4Cnk8xSZOX+4on5TfIT9IrTE3CavZLfOZFJyztUl19Xsv/tsXDtoM7MUbCuP0Ha1o5zNpC2u8ulHYm7nYVprMIh15hp1GkaKfIZGii8x3Qu4sb18iDzW3FbIfmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39840400004)(376002)(396003)(316002)(2906002)(478600001)(6506007)(186003)(2616005)(6486002)(36756003)(53546011)(66446008)(66946007)(6512007)(66556008)(86362001)(5660300002)(8936002)(110136005)(64756008)(76116006)(66476007)(71200400001)(8676002)(4326008)(54906003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lqI81HcFarkXq2qf9wrjlVEkdTtrJvsmEVE4UMeykWaQMaW+MASDNnzNdRhgK7EJPhpdWoAWotTQ5t6SlhEhfawKxM2Mm2n5/c/2E18FqUDsTZ5hDuVxbS+0ktJ57FVDLGd3ocKxc9lpPwP8/t4S9CiODodrrxcl27PMDZuUfH2PFZegu8M+zJ51nH0UYViITBysSvizAFnyaGhfsbSXHmxF36nGg+a3Im6RLm8wBelkjR+ae7/Q8iKfqBiHDHyK6TI39yHHu+y+MXAt5+kTYTSGV99TJhSsvCRa0ozC2p0cTx0J4ahgGJ6OU3PogXV1Ehq0oW4eIcnZBwUHCwOKIby1WigpK5Fb+8bwDS2utWny5UIZblX8gGX2euK8AiXt5vxS3Z/01fCCAEtrlKxf3ZFHTmZtEa8Bvg+JXis1QNkmmKsRWXHjuQAiZSyLoE8RnHMLrcQmL00wIg3j7xzTPC1y/wXQ6sr+MTeDLBy9YPF8ooz4tZdHp9JHkj0oxzmQfxKoOGcdwdElBWm9moHyRy19ORcLik8+pnLILW7xSSHvDceBI2jnaYeLEMnHQiJecmLfEXbZ4LIXRg23AredVtQuqrGsRRb+JE83PMudJgdf9SDMlQIP0SkyFtzh+QPGvxs4GDzKyNfXMNphOswv+Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <744422FDCD74B843B7C6106391857327@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21243e7e-68b8-4d53-7879-08d845f0ff5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 16:41:04.9733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EBfZEXIKFTSGWYZXcHL592pOHueJfsck1ykN2p6MCx9sB1X5TGUpVvgVToNRjg0n570YA3efOpxLnuJBWSG2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3848
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTA4LTIxIGF0IDE2OjAzICswMDAwLCBGcmFuayB2YW4gZGVyIExpbmRlbiB3
cm90ZToNCj4gT24gRnJpLCBBdWcgMjEsIDIwMjAgYXQgMDI6NTA6NTlQTSArMDgwMCwgTXVycGh5
IFpob3Ugd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gT24gV2VkLCBKdW4gMjQsIDIwMjAgYXQg
Njo1MSBBTSBGcmFuayB2YW4gZGVyIExpbmRlbg0KPiA+IDxmbGxpbmRlbkBhbWF6b24uY29tPiB3
cm90ZToNCj4gWy4uLl0NCj4gPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGlub2RlX29wZXJhdGlv
bnMgbmZzNF9kaXJfaW5vZGVfb3BlcmF0aW9ucyA9DQo+ID4gPiB7DQo+ID4gPiBAQCAtMTAxNDYs
MTAgKzEwMjU0LDIxIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgeGF0dHJfaGFuZGxlcg0KPiA+ID4g
bmZzNF94YXR0cl9uZnM0X2FjbF9oYW5kbGVyID0gew0KPiA+ID4gICAgICAgICAuc2V0ICAgID0g
bmZzNF94YXR0cl9zZXRfbmZzNF9hY2wsDQo+ID4gPiAgfTsNCj4gPiA+IA0KPiA+ID4gKyNpZmRl
ZiBDT05GSUdfTkZTX1Y0XzINCj4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHhhdHRyX2hhbmRs
ZXIgbmZzNF94YXR0cl9uZnM0X3VzZXJfaGFuZGxlciA9DQo+ID4gPiB7DQo+ID4gPiArICAgICAg
IC5wcmVmaXggPSBYQVRUUl9VU0VSX1BSRUZJWCwNCj4gPiA+ICsgICAgICAgLmdldCAgICA9IG5m
czRfeGF0dHJfZ2V0X25mczRfdXNlciwNCj4gPiA+ICsgICAgICAgLnNldCAgICA9IG5mczRfeGF0
dHJfc2V0X25mczRfdXNlciwNCj4gPiA+ICt9Ow0KPiA+ID4gKyNlbmRpZg0KPiA+ID4gKw0KPiA+
IA0KPiA+IEFueSBwbGFuIHRvIHN1cHBvcnQgWEFUVFJfVFJVU1RFRF9QUkVGSVggPw0KPiA+IA0K
PiA+IFRoYW5rcy4NCj4gDQo+IFRoaXMgaXMgYW4gaW1wbGVtZW50YXRpb24gb2YgUkZDIDgyNzYs
IHdoaWNoIGV4cGxpY2l0bHkgcmVzdHJpY3RzDQo+IGl0c2VsZg0KPiB0byB0aGUgInVzZXIiIG5h
bWVzcGFjZS4NCj4gDQo+IFRoZXJlIGlzIGN1cnJlbnRseSBubyBwb3J0YWJsZSB3YXkgdG8gaW1w
bGVtZW50IHRoZSAidHJ1c3RlZCINCj4gbmFtZXNwYWNlDQo+IHdpdGhpbiB0aGUgYm91bmRhcmll
cyBvZiB0aGUgTkZTIHNwZWNpZmljYXRpb24ocyksIHNvIGl0J3Mgbm90DQo+IHN1cHBvcnRlZC4N
Cj4gDQoNCkNvcnJlY3QuICd0cnVzdGVkJyBpcyBqdXN0IGFub3RoZXIgd2F5IHRvIGltcGxlbWVu
dCBwcml2YXRlIHByb3RvY29scy4NClRob3NlIGFyZSB1bmFjY2VwdGFibGUgaW4gYSBzaGFyZWQg
ZmlsZXN5c3RlbSBlbnZpcm9ubWVudC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=
