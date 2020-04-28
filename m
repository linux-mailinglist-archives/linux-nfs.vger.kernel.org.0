Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045151BCA27
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2020 20:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgD1SrN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 14:47:13 -0400
Received: from mail-mw2nam12on2125.outbound.protection.outlook.com ([40.107.244.125]:6905
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730793AbgD1SrM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Apr 2020 14:47:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xime+zlLF52+qZRI3LDeKQazJif2VEBZfxeYhtKN/FFUItkkC9YhxPi2TvoHXiTNzb1Usfst9XgqtUFMWwGFqknMv+Wn/kD7cdiQHVQEtbCpIFzcnKNCdRcQTRaoX+zZCL/Ig0IgQqlcrDqIBCkONMsg5Ty3Yqor9eKFxtQjIjsEhkrv5Q1y6l88tBDoOiD7+ObL9ObytZv+jNunxEr9EoPDsGY66DE6LxL3gW24YJQp6xtGrWgBwiVpRMG5S41HI3kkL1oR7BUZkNIUv0Nh1Zx6oTQmG3lN0QPiulyDoXtfBSH4p+xwwSADIEN8zyoaG73I+ZyN5DiMqlIhnF2QJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10QrEVEHC9GO/af99mTGJDCxCuH+Mf0rh+EvxMi2ZLM=;
 b=mnPLjn6TjPD+NCXQMIPQkkHtF1g1dK4ikgt7sCpgCo7gimTA7+FQEI6BJeu7NT/Uq8Lc+33EPW5rGyxiZgrLI1aQ3cUzjda+UZFzqAVlm3TtDk5Pp24UM7ReVg/rzfgBeb6ZWjHuW2tEEGGYQVpxPJK8j9eUH/u3TYSFKDuNFpN9v4nja5fXqVPLkXRTlfwADcJmHwMPVFrtVfqTcC/xIRFQZOrVJ0dskW2nFe9rgOTmjpH4/FQ/t33ufR/VDRG3LV7fG1Th3/mXvYtl7t1A6Ud/qeUDOvkYnKv+k0juztwSQWWKbdEOUxlLB84c06e+sEiPmJkXyax2tb1iLvBMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10QrEVEHC9GO/af99mTGJDCxCuH+Mf0rh+EvxMi2ZLM=;
 b=Fe7wUeCbegDteq2DKolJN3KvPluCg6Zv/Fp4gRlCynxjO5+rixTY5LvWNukqpTN1C8Z43p58nZ+1yprX2IMih55aaLJcdbnWg81qLqPQEYIUj3U9ofvsGu1p7hKOZwQAnDTiWI8X2AAGucGWNbOaI3ZKgSwfY42xh74kpUCHnyU=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3880.namprd13.prod.outlook.com (2603:10b6:610:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.9; Tue, 28 Apr
 2020 18:47:09 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2958.014; Tue, 28 Apr 2020
 18:47:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
Thread-Topic: handling ERR_SERVERFAULT on RESTOREFH
Thread-Index: AQHWHYjzjBZLlmadoEGcRGdAsbmgTaiO38OA
Date:   Tue, 28 Apr 2020 18:47:09 +0000
Message-ID: <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
In-Reply-To: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 553707c6-ee3c-4a97-058f-08d7eba48e98
x-ms-traffictypediagnostic: CH2PR13MB3880:
x-microsoft-antispam-prvs: <CH2PR13MB3880661D8F584C31BE7113C3B8AC0@CH2PR13MB3880.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0387D64A71
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: geWGYJL11qDvdH2Jww2GJgbOqIFIDTHHf5Zknr56qPE4lAlstk0R5vgo3poNdU3BQ6ZA7gG4sTTV3eaZxgpvsMoYtCUgNsR1tnZjNKyYynWtm6xec14Pg4I2OCdihctTWXHNomxP91KevOAYofrjJr2xLP0ozSdo8h1kjgf7S7uBO0UHZBeJjo6lZ8EhjGOhuxfImbUE8FEgYXpxsQndtSGjwfVSa97xva3WUY5KxAQj3vg4xSJxmljwRgn/5eRRH4CR+g/s32Ib93TLZA769Bq7YYUikbe4262cIdEEW3OavdnG4vRDcGZrIwEG7MUXClN09ZrxFqdRNh5LTdO8OC7RZuHTWM9ZkhfIW+j6iw8UK0lYvPPmfwts60GxHv48pYXk9Q7IopHQti/01OZSX+curRUL8LMSXv3izEfbbmP4Fkd7+AjIT3m5wU8jvS+g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(366004)(39830400003)(64756008)(66476007)(2906002)(478600001)(66556008)(8936002)(66446008)(86362001)(5660300002)(76116006)(8676002)(91956017)(66946007)(4744005)(71200400001)(6506007)(2616005)(36756003)(110136005)(316002)(186003)(26005)(6512007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BbgdXFXJxwKkT//+2GSlZ7sVRKb7JGfmhAyHKargEbe5UArAMsaQk+101MnMUUlX804FpZCy5iSJWHsuWynZTsa6I/n7mvI2vni+i26oGpc7+o+9JwNBCW4VeeF1vRWMmHUTiNgTOD0y5S/aEOyeiAyFoRmcNvuSMFvDcrpvAkrIEvInUEAn1RqTC1i3eujkii+XO5LPokD1fx9CNjyahd5QMNAJzztdXThqlqslYUI6bvnOrSz51HGmUoxWXUZ1amrab+OjZIFAD+sHC4tq82m24+30LTEiW892RMAU7n6ntUI+oLv2/14A0OTx2KOPeErHTIi1ns2oTvDgGB75G4ofEixW/u0k5yYthY7T+b2XXVp2dMHco0+BBP165JPn2TdnApsH3H5/KaXWyzd4Zc05+HEZchHZNhI/XDdlpkiaRY/V2c0A6ApzuYliQHVoSo2JmvT6zLXyHO7jeQBa/LMa6WwgFIT1JyEFGe2ch2Y5yzDqvbLcPXMr5mmFG4RZvWDtcxZp06MYIvzjKIC5RhxIN+ts28U9J6EsnMR1Q204BC3cFZtXMHe6ad+dD0QRODFWp+ewQUjwha5+cDwM8WtxfppnMWfN5zsvdgLBgIWamY5K8ZZWyd08E4rc7AZe221n97CuF231jCG+UrhEYpbodrVtcTISoaJBvHhj3rwS/yGa5Ya0ZpsiqZr0+8dRoyRJHlVpustOpuBWL9hkGKS7Bs8udMfwkFL1/+nhJSa45rJ/VMnTNnyvCr2BLRtKvhP69Jdl/urzjwNUioIuf0xUmsGSYKmpVj3ENUTO5l4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <549CB88111613549B21EB490D6C39ADD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553707c6-ee3c-4a97-058f-08d7eba48e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 18:47:09.4986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGuAcaOlLfcSx0KNvNNmuVp2+fVrE/l2zuPU2YinPdbBuvTynSnkqbqFPZXgNYUEIVhQ49Cpw3Tdp4r6+GtEUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3880
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gVHVlLCAyMDIwLTA0LTI4IGF0IDE0OjE0IC0wNDAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gSGkgZm9saywNCj4gDQo+IExvb2tpbmcgZm9yIGd1aWRhbmNlIG9u
IHdoYXQgZm9sa3MgdGhpbmsuIEEgY2xpZW50IGlzIHNlbmRpbmcgYSBMSU5LDQo+IG9wZXJhdGlv
biB0byB0aGUgc2VydmVyLiBUaGlzIGNvbXBvdW5kIGFmdGVyIHRoZSBMSU5LIGhhcyBSRVNUT1JF
RkgNCj4gYW5kIEdFVEFUVFIuIFNlcnZlciByZXR1cm5zIFNFUlZFUl9GQVVMVCB0byBvbiBSRVNU
T1JFRkguIEJ1dCBMSU5LIGlzDQo+IGRvbmUgc3VjY2Vzc2Z1bGx5LiBDbGllbnQgc3RpbGwgZmFp
bHMgdGhlIHN5c3RlbSBjYWxsIHdpdGggRUlPLiBXZQ0KPiBoYXZlIGEgaGFyZGxpbmUgYW5kICJs
biIgc2F5aW5nIGhhcmRsaW5rIGZhaWxlZC4NCj4gDQo+IFNob3VsZCB0aGUgY2xpZW50IG5vdCBm
YWlsIHRoZSBzeXN0ZW0gY2FsbCBpbiB0aGlzIGNhc2U/IFRoZSBmYWN0DQo+IHRoYXQNCj4gd2Ug
Y291bGRuJ3QgZ2V0IHVwLXRvLWRhdGUgYXR0cmlidXRlcyBkb24ndCBzZWVtIGxpa2UgdGhlIHJl
YXNvbiB0bw0KPiBmYWlsIHRoZSBzeXN0ZW0gY2FsbD8NCj4gDQo+IFRoYW5rIHlvdS4NCg0KSSBk
b24ndCByZWFsbHkgc2VlIHRoaXMgYXMgd29ydGggZml4aW5nIG9uIHRoZSBjbGllbnQuIEl0IGlz
IHZlcnkNCmNsZWFybHkgYSBzZXJ2ZXIgYnVnLg0KDQpUaGFua3MNCiAgVHJvbmQNCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
