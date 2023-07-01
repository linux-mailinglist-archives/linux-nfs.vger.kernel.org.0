Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2AD744B24
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Jul 2023 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGAVdX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Jul 2023 17:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGAVdX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Jul 2023 17:33:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2136.outbound.protection.outlook.com [40.107.244.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A3510DC;
        Sat,  1 Jul 2023 14:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8v11w3pkRLbtDn/V8+de7rcazOGGAq8GgYE/mlEQ2X1IoMEMZuHBDEwEhMfrahibQ5cSLrOeCX3aOgyHhHWMEyIduGUWTolcjchKXy/7ETW8Vwyeedgk6YnPF22775++Xy+sQSiNpiIhUXFYrjZjE7/+HvjzVtwroUkbGtNBexEV6zktDc0KVVnlahlZfgUzUUCPjjpVJym69Mt6gVbhnq8lg73yHmXx1ISW/748LpzhebuHIQzuHkg7laXLS9yLdIoXTQIffE1640kIlPdaXL+ABbdTBj+uBjEvPzG73l9/Iy7d/x1C0ZLL5uTlTl+nK1oSPRLnfYAOdLe240yzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9qcHg0KW6eduu9KFMlDKv2cDHXwCvbu7P2D5/xq8ug=;
 b=NPO7xHak9//pEPbWuHSXkOiPjaNKLWwB6C3KexrTJJ0vBmjKejNp1DrLTqfPbNDK16OBdxRok8ewN/vw1QQwnASzxQX6b+hb7Szxtt4oONSCO26WB1sWE2L0gOTiT8c+ejHOyJtM/uPkcmDJJHq955VQnvSkiHdLww7YFOG0ebbK0LT/mzi+SGIYNnN4LE3oSlBhRWviHggFdSGl9slCwpu2XU4IteDSn3oIAhHrlJeXjhfxCKZv5HvUUr8Kmzel5MgmZhFgwdHMl29NAvXizCREgJeUINgLovzbiwUCZUacSPo4wS5mbkG1VL+Fom/0zRe+pm3dS/mVQew1Kn9sDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9qcHg0KW6eduu9KFMlDKv2cDHXwCvbu7P2D5/xq8ug=;
 b=g3blRl2PRnj0HsvhAepiqSsMuPBuFzWwsHGrCkztHU5fr9pNbAv9qos7D3rdWWoTC7Cy2dFH5d9f7RyXCCKzL5gYmNMcd6CsKJ+NWXCv3lSK00XHPXEmg0p+klBk3NEju0z2D0XhWIfS7EpkNWoPzopGBg0LeCc18UY+0PNXuwU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA3PR13MB6231.namprd13.prod.outlook.com (2603:10b6:806:2ff::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 21:33:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 21:33:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client updates for Linux 6.5
Thread-Topic: [GIT PULL] Please pull NFS client updates for Linux 6.5
Thread-Index: AQHZrGOliM0J7bMnOUq5DjPIPQa4cA==
Date:   Sat, 1 Jul 2023 21:33:15 +0000
Message-ID: <fc3d657d436e21d86b51fcfa0553c04d217d4b80.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA3PR13MB6231:EE_
x-ms-office365-filtering-correlation-id: fcfc8971-b086-47ba-a3ef-08db7a7ac7a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1QhMugcNanUpmHHlFwhpwIwy6ih91JGnO4Yc/jO5W1QGPyWPdpNnvcfesM3L06RiqyTdiwB2cx7LWIIriGG2IZTL4DFQHExeArAhYn+Fd2AgULeZ3G52sqFoB7XOO6dcc1LwC1yOtJ2vqNGjxfYmRYJ6JxeS1NNgTqUaF9fJiKhWdr7Ek9IEmW4rBMBgtq46N3/S0IUfu0ERGNwSE96gF93lJBiQ8BlRG0EMKwhEU5mMpXG/YOWOYJsXs/Vt8Qe1mQe3PEzFBAUQkckzf1WRL3gVp9wE5bGVPL050IVKNfv6fnX4fL+8/zVPwWkGaFqRG2KE/9aeYsoYNhUQxSSO5M37v0KJLxI6hXOyCrFGa1kxo0Zn6I0EtDFpexq13PG77lifrpDvZG0JSCVWrcFM1IsKfYsw0rcc46cjp0GhK0d8jwR2Cv2/wX7u/AmZnnuNLrT5q7mSfBPGC628RxzrQQGbakIjdgSVLMV3V2Lcc+v0qTwdUcstZ9b4ilSzeLAqZusr8lB+tLPARqptZqzt4/xbvi2DrkLQpvnvk98GeFXeTY2t2Nw3K+QD0BMArungCYuGWvs81M3EUvHGrxfhTA3oVHnmuQ09D+CkTPjyojquJcIABGJGUqWcg4oksgdl/UBEkth9vt1UqKnDbYxiFsx3MX9qRaeum0mw8cgQDZs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(396003)(39830400003)(451199021)(4326008)(316002)(66476007)(86362001)(66446008)(64756008)(66556008)(186003)(6916009)(66946007)(76116006)(6506007)(6512007)(83380400001)(122000001)(2616005)(2906002)(6486002)(38100700002)(15650500001)(71200400001)(5660300002)(478600001)(38070700005)(8676002)(54906003)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3V2WUJ4S2pHbXl6VXVkc1E5YzdtN0ZUaDBGYnM2MDdkNTl5RnRKZi9QTE9Y?=
 =?utf-8?B?T3lNZ01mNWE3bWhvQmo2ckl3RzA4MHk2cTVoTTNVWUtwcURiYlRlV0dyU1Er?=
 =?utf-8?B?OTlaS3FSY3o1STVoaS93UWJjQTE4ZVlQWDVMaFNPWGVUWU5XVCtDeUxjTmVT?=
 =?utf-8?B?UWFFTUYrVzFpRjc0aTFqcXBsL0lYL3BiWXRaelEyVGI3dFR0enZ0WVFBMHlB?=
 =?utf-8?B?TERzbERCWUswbE1CRS9aWnFEZWk5SDEyWGtxS3dVMm1pd3JmazN2QnVqNVFJ?=
 =?utf-8?B?WS9nMjk5NS8rRTlZZ2FQWEpqZkp4emR6aXUwR3pla1ljNGxGZEhzNUkyMXB6?=
 =?utf-8?B?Rk5qem5SUkdKU0g2MVVWbnliT2wreUVPWE9pQ29uMXJ5dzd5OUNUS0YwaVVq?=
 =?utf-8?B?YjQ5TGI2OGVpYnBVd1dGcTMwazl3UlVNQkFwQUp3VklFV2tqa2NyMzhJcTRI?=
 =?utf-8?B?N1IvUnFCUHAwbHF4OC93N1ExWTFqS0RSNWJzN1JZZ3EybHNrY1dtN2hSc3lm?=
 =?utf-8?B?cER3WGR5amUzVjh1MXJIbXZadzlINGZUWlV6MVFCQXBpNGRIenR3ZjFKRUtE?=
 =?utf-8?B?aHlwdTQ1ODFYWlZhRVJsZGtLSVd2WHQvQnlJZWhlb1VxRUFDcnVITnF4V3VI?=
 =?utf-8?B?czhaOVd0VGptWUhwRWFlOWZlbndhVWZsdG5hNkJZVmNVLzdKcVJCNWhjdFk1?=
 =?utf-8?B?enlwcHFzQWJuWTlpTS9hcDNxN3hOaklzdjdoRlpZVVRHSlltOWhIUzVlVStt?=
 =?utf-8?B?VmhkY0l6RUp6NCtTWWRPdHE0alZiaVVpNmJ1anU3WWhXWWVpSDVVZ2xkTVIy?=
 =?utf-8?B?aFpsNzA4WWJubWhubXRxdVJPZmpURUxPRlNzeE1zNXBYdmR2d1BUNWZmVFJX?=
 =?utf-8?B?UVZjenB0TjlUZmFuQUYxa1U0Z0owT3kzUzBJV3NJWXp5aGN3OGF6S2NPa3hv?=
 =?utf-8?B?S2VSTDhCYTdOUXptbG9rVndUbWRDTVd1U201OHF6UVMydlZXOTgwNkxseVpS?=
 =?utf-8?B?TFl6VEdvN2Ixbllta2tIelpOVFlJc0FDeGxiU29ReXBQb1B4b2F6bzIyLzlY?=
 =?utf-8?B?M08veXlGVGZBNytWYnFtQjFyaU00cmRCdUIrSXdEcTZnVUZlWDdQTCt1ekND?=
 =?utf-8?B?WVZkL0twbk9tSTZBd1VvakYxSVdwZnJ4QU5OdGxXc0txSWNpSDZ0K3IrL3Aw?=
 =?utf-8?B?Z2NZVDV6NFFtOHplMVJIQW1iUHhjb3MvbnNFNnV1RHJJZ1hCZExYT2VrY1ZF?=
 =?utf-8?B?UGNHMzJQU0xzTTF1SEgzYkVXMWpVc1NnTDJkWDRHSGZCbnkrWlZaS01nL080?=
 =?utf-8?B?R3ltdXVlb3Q0NS9jVWZkV2Z6eDh6VWRFMFVrU2pWQU91cThldzJMSjU5Q1hG?=
 =?utf-8?B?eXErYmtOUUtFcVFnS1NEd2lHTmNZVlAwcE5ETzhBRFdCejVBRWp2UEYwYTg3?=
 =?utf-8?B?dTduMEN2dmdCTlU3c1JNWC9QMTBnOER0VHYxalpvOTkyOXFYa2hFR2EvaXk4?=
 =?utf-8?B?dDF4Y2Z6VFVvMTZjU1FrUHN5TEg0Mmh0Vnh6aXAwNjFpVy85Qm9KSEhpd0l2?=
 =?utf-8?B?TVBOVWIrc1F1Z1NheUxTcWRPc2dkaGlrV3ZuSndVUUpKZmlXY1ZVMXg2Rndt?=
 =?utf-8?B?SG5LSEx2aTkzQXRtRmNFQk5KOVhwSmRVZXY0MDdFRVVoNjlnMktyNHFPSDNB?=
 =?utf-8?B?M2FKOXBGcTlBalZ2a3NlSGh1anFZek9uemgydmlhNndmbWxmZTMrYmpsd3Ay?=
 =?utf-8?B?NU5FMlZEazdPd09teStucmlzU21hcTV6MDVDNURGclBJL0JuTE5Salg1ejNr?=
 =?utf-8?B?VGdFYjBBV0xZYlg2L0VtNGticFUvc1Y4NWRwQUhiREo2VFgrNjdybHNiSG9k?=
 =?utf-8?B?ekJIZnFTMFFlWWVWNVduNHJBeW43cmQvVm94Smt6eUZLamNDZUNzQ0xPSDho?=
 =?utf-8?B?VzhkQlRoOGpVQU5LL2ZHeE51cWhuamRCWmxQZFg1UE1RcklTKy9MZWRtejB3?=
 =?utf-8?B?U01JWi9yS0xNMHpDL0ZmT0NSS011USsrOUxJYlBQa2dQOXJDeGVyR09WZ1ZM?=
 =?utf-8?B?am1sZWtTeVEwYjh2Z3IwNkhwUHBLY254aXVwby9NOEF6QXpHbmRJYzFadVFa?=
 =?utf-8?B?OG9tdmRaOGlHUzBxLy9KbVZ3ZnZuaEttSkVoMTcyRkVERU5MZ2JXT2FidWor?=
 =?utf-8?B?RnhoOUsxU0p1YU0yVnQvNWRCdzV0MTFtUDBULzhBQzBNUmI3MUNJSWNHVUdN?=
 =?utf-8?B?Y0xqNUdXdFdvMGxHemNOazBlVUh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F340E1ACF7A3E4B958D96687BDCBD4C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfc8971-b086-47ba-a3ef-08db7a7ac7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2023 21:33:15.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KSvd2Bm8MB1Gupnh4jVNL8XcFVxhyrO5hd5yBQ5URqdrCS072i3PNZdLvTfSwFyhKh7w6aOKdOQgugzui+hTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6231
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNDVhM2UyNGY2
NWU5MGEwNDdiZWY4NmY5MjdlYmRjNGM3MTBlZGFhMToNCg0KICBMaW51eCA2LjQtcmM3ICgyMDIz
LTA2LTE4IDE0OjA2OjI3IC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy90cm9uZG15L2xp
bnV4LW5mcy5naXQgdGFncy9uZnMtZm9yLTYuNS0xDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byA1YjRhODJhMDcyNGFmMWRmZDEzMjA4MjZlMDI2NjExN2I2YTU3ZmJkOg0KDQogIFJl
dmVydCAiTkZTdjQ6IFJldHJ5IExPQ0sgb24gT0xEX1NUQVRFSUQgZHVyaW5nIGRlbGVnYXRpb24g
cmV0dXJuIiAoMjAyMy0wNi0yOSAxNDoyNTozNSAtMDQwMCkNCg0KVGhhbmtzLA0KICBUcm9uZA0K
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQpORlMgY2xpZW50IHVwZGF0ZXMgZm9yIExpbnV4IDYuNQ0KDQpIaWdobGlnaHRz
IGluY2x1ZGU6DQoNClN0YWJsZSBmaXhlcyBhbmQgb3RoZXIgYnVnZml4ZXM6DQogLSBuZnM6IGRv
bid0IHJlcG9ydCBTVEFUWF9CVElNRSBpbiAtPmdldGF0dHINCiAtIFJldmVydCAiTkZTdjQ6IFJl
dHJ5IExPQ0sgb24gT0xEX1NUQVRFSUQgZHVyaW5nIGRlbGVnYXRpb24gcmV0dXJuIg0KICAgc2lu
Y2UgaXQgYnJlYWtzIE5GU3Y0IHN0YXRlIHJlY292ZXJ5Lg0KIC0gTkZTdjQuMTogZnJlZXplIHRo
ZSBzZXNzaW9uIHRhYmxlIHVwb24gcmVjZWl2aW5nIE5GUzRFUlJfQkFEU0VTU0lPTg0KIC0gRml4
IHRoZSBORlN2NC4yIHhhdHRyIGNhY2hlIHNocmlua2VyX2lkDQogLSBGb3JjZSBhIGN0aW1lIHVw
ZGF0ZSBhZnRlciBhIE5GU3Y0LjIgU0VUWEFUVFIgY2FsbA0KDQpGZWF0dXJlcyBhbmQgY2xlYW51
cHM6DQogLSBORlMgYW5kIFJQQyBvdmVyIFRMUyBjbGllbnQgY29kZSBmcm9tIENodWNrIExldmVy
Lg0KIC0gU3VwcG9ydCBmb3IgdXNlIG9mIGFic3RyYWN0IHVuaXggc29ja2V0IGFkZHJlc3NlcyB3
aXRoIHRoZSBycGNiaW5kDQogICBkYWVtb24uDQogLSBTeXNmcyBBUEkgdG8gYWxsb3cgc2h1dGRv
d24gb2YgdGhlIGtlcm5lbCBSUEMgY2xpZW50IGFuZCBwcmV2ZW50DQogICB1bW91bnQoKSBoYW5n
cyBpZiB0aGUgc2VydmVyIGlzIGtub3duIHRvIGJlIHBlcm1hbmVudGx5IGRvd24uDQogLSBYRFIg
Y2xlYW51cHMgZnJvbSBBbm5hLg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpBbm5hIFNjaHVtYWtlciAoNik6DQogICAg
ICBORlN2NC4yOiBDbGVhbiB1cDogTW92ZSB0aGUgZW5jb2RlX2NvcHlfY29tbWl0KCkgZnVuY3Rp
b24NCiAgICAgIE5GU3Y0LjI6IENsZWFuIHVwOiBtb3ZlIGRlY29kZV8qeGF0dHIoKSBmdW5jdGlv
bnMNCiAgICAgIE5GU3Y0LjI6IENsZWFuIHVwOiBNb3ZlIG5mczRfeGRyX2VuY18qeGF0dHIoKSBm
dW5jdGlvbnMNCiAgICAgIE5GU3Y0LjI6IENsZWFuIHVwIG5mczRfeGRyX2RlY18qeGF0dHIoKSBm
dW5jdGlvbnMNCiAgICAgIE5GU3Y0LjI6IENsZWFuIHVwIHhhdHRyIHNpemUgbWFjcm9zDQogICAg
ICBORlN2NC4yOiBTRVRYQVRUUiBzaG91bGQgdXBkYXRlIGN0aW1lDQoNCkJlbmphbWluIENvZGRp
bmd0b24gKDEzKToNCiAgICAgIE5GUzogcmVuYW1lIG5mc19jbGllbnRfa3NldCB0byBuZnNfa3Nl
dA0KICAgICAgTkZTOiByZW5hbWUgbmZzX2NsaWVudF9rb2JqIHRvIG5mc19uZXRfa29iag0KICAg
ICAgTkZTOiBPcGVuLWNvZGUgdGhlIG5mc19rc2V0IGtzZXRfY3JlYXRlX2FuZF9hZGQoKQ0KICAg
ICAgTkZTOiBNYWtlIGFsbCBvZiAvc3lzL2ZzL25mcyBuZXR3b3JrLW5hbWVzcGFjZSB1bmlxdWUN
CiAgICAgIE5GUzogYWRkIHN1cGVyYmxvY2sgc3lzZnMgZW50cmllcw0KICAgICAgTkZTOiBBZGQg
c3lzZnMgbGlua3MgdG8gc3VucnBjIGNsaWVudHMgZm9yIG5mc19jbGllbnRzDQogICAgICBORlM6
IGFkZCBhIHN5c2ZzIGxpbmsgdG8gdGhlIGxvY2tkIHJwY19jbGllbnQNCiAgICAgIE5GUzogYWRk
IGEgc3lzZnMgbGluayB0byB0aGUgYWNsIHJwY19jbGllbnQNCiAgICAgIE5GUzogYWRkIHN5c2Zz
IHNodXRkb3duIGtub2INCiAgICAgIE5GUzogQ2FuY2VsIGFsbCBleGlzdGluZyBSUEMgdGFza3Mg
d2hlbiBzaHV0ZG93bg0KICAgICAgTkZTdjQ6IENsZWFuIHVwIHNvbWUgc2h1dGRvd24gbG9vcHMN
CiAgICAgIE5GUzogRG9uJ3QgY2xlYW51cCBzeXNmcyBzdXBlcmJsb2NrIGVudHJ5IGlmIHVuaW5p
dGlhbGl6ZWQNCiAgICAgIFJldmVydCAiTkZTdjQ6IFJldHJ5IExPQ0sgb24gT0xEX1NUQVRFSUQg
ZHVyaW5nIGRlbGVnYXRpb24gcmV0dXJuIg0KDQpDaHVjayBMZXZlciAoOSk6DQogICAgICBORlM6
IEltcHJvdmVtZW50cyBmb3IgZnNfY29udGV4dC1yZWxhdGVkIHRyYWNlcG9pbnRzDQogICAgICBT
VU5SUEM6IFBsdW1iIGFuIEFQSSBmb3Igc2V0dGluZyB0cmFuc3BvcnQgbGF5ZXIgc2VjdXJpdHkN
CiAgICAgIFNVTlJQQzogVHJhY2UgdGhlIHJwY19jcmVhdGVfYXJncw0KICAgICAgU1VOUlBDOiBB
ZGQgUlBDIGNsaWVudCBzdXBwb3J0IGZvciB0aGUgUlBDX0FVVEhfVExTIGF1dGggZmxhdm9yDQog
ICAgICBTVU5SUEM6IElnbm9yZSBkYXRhX3JlYWR5IGNhbGxiYWNrcyBkdXJpbmcgVExTIGhhbmRz
aGFrZXMNCiAgICAgIFNVTlJQQzogQ2FwdHVyZSBDTVNHIG1ldGFkYXRhIG9uIGNsaWVudC1zaWRl
IHJlY2VpdmUNCiAgICAgIFNVTlJQQzogQWRkIGEgVENQLXdpdGgtVExTIFJQQyB0cmFuc3BvcnQg
Y2xhc3MNCiAgICAgIE5GUzogSGF2ZSBzdHJ1Y3QgbmZzX2NsaWVudCBjYXJyeSBhIFRMUyBwb2xp
Y3kgZmllbGQNCiAgICAgIE5GUzogQWRkIGFuICJ4cHJ0c2VjPSIgTkZTIG1vdW50IG9wdGlvbg0K
DQpKZWZmIExheXRvbiAoMSk6DQogICAgICBuZnM6IGRvbid0IHJlcG9ydCBTVEFUWF9CVElNRSBp
biAtPmdldGF0dHINCg0KTmVpbEJyb3duICgyKToNCiAgICAgIFNVTlJQQzogc3VwcG9ydCBhYnN0
cmFjdCB1bml4IHNvY2tldCBhZGRyZXNzZXMNCiAgICAgIFNVTlJQQzogYXR0ZW1wdCB0byByZWFj
aCBycGNiaW5kIHdpdGggYW4gYWJzdHJhY3Qgc29ja2V0IG5hbWUNCg0KT2xnYSBLb3JuaWV2c2th
aWEgKDEpOg0KICAgICAgTkZTdjQuMTogZnJlZXplIHRoZSBzZXNzaW9uIHRhYmxlIHVwb24gcmVj
ZWl2aW5nIE5GUzRFUlJfQkFEU0VTU0lPTg0KDQpRaSBaaGVuZyAoMSk6DQogICAgICBORlN2NC4y
OiBmaXggd3Jvbmcgc2hyaW5rZXJfaWQNCg0KIGZzL2xvY2tkL2NsbnRsb2NrLmMgICAgICAgICAg
ICAgfCAgIDYgKw0KIGZzL25mcy9jbGllbnQuYyAgICAgICAgICAgICAgICAgfCAgMzIgKysNCiBm
cy9uZnMvZnNfY29udGV4dC5jICAgICAgICAgICAgIHwgIDY3ICsrKysrDQogZnMvbmZzL2lub2Rl
LmMgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KIGZzL25mcy9pbnRlcm5hbC5oICAgICAgICAg
ICAgICAgfCAgIDIgKw0KIGZzL25mcy9uZnMzY2xpZW50LmMgICAgICAgICAgICAgfCAgMTMgKy0N
CiBmcy9uZnMvbmZzNDJwcm9jLmMgICAgICAgICAgICAgIHwgIDI1ICstDQogZnMvbmZzL25mczQy
eGF0dHIuYyAgICAgICAgICAgICB8ICA3OSArKy0tLQ0KIGZzL25mcy9uZnM0Mnhkci5jICAgICAg
ICAgICAgICAgfCA2MzEgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
IGZzL25mcy9uZnM0Y2xpZW50LmMgICAgICAgICAgICAgfCAgNDQgKystDQogZnMvbmZzL25mczRw
cm9jLmMgICAgICAgICAgICAgICB8ICAgOSArLQ0KIGZzL25mcy9uZnM0c3RhdGUuYyAgICAgICAg
ICAgICAgfCAgIDMgKw0KIGZzL25mcy9zdXBlci5jICAgICAgICAgICAgICAgICAgfCAgMTggKy0N
CiBmcy9uZnMvc3lzZnMuYyAgICAgICAgICAgICAgICAgIHwgMjM1ICsrKysrKysrKysrKy0tLQ0K
IGZzL25mcy9zeXNmcy5oICAgICAgICAgICAgICAgICAgfCAgMTAgKy0NCiBpbmNsdWRlL2xpbnV4
L2xvY2tkL2JpbmQuaCAgICAgIHwgICAyICsNCiBpbmNsdWRlL2xpbnV4L25mc19mc19zYi5oICAg
ICAgIHwgICA2ICstDQogaW5jbHVkZS9saW51eC9uZnNfeGRyLmggICAgICAgICB8ICAgMyArDQog
aW5jbHVkZS9saW51eC9zdW5ycGMvYXV0aC5oICAgICB8ICAgMiArDQogaW5jbHVkZS9saW51eC9z
dW5ycGMvY2xudC5oICAgICB8ICAxMyArLQ0KIGluY2x1ZGUvbGludXgvc3VucnBjL3hwcnQuaCAg
ICAgfCAgMTggKysNCiBpbmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0c29jay5oIHwgICAzICsNCiBp
bmNsdWRlL3RyYWNlL2V2ZW50cy9zdW5ycGMuaCAgIHwgIDk2ICsrKysrLQ0KIG5ldC9zdW5ycGMv
TWFrZWZpbGUgICAgICAgICAgICAgfCAgIDIgKy0NCiBuZXQvc3VucnBjL2F1dGguYyAgICAgICAg
ICAgICAgIHwgICAyICstDQogbmV0L3N1bnJwYy9hdXRoX3Rscy5jICAgICAgICAgICB8IDE3NSAr
KysrKysrKysrKw0KIG5ldC9zdW5ycGMvY2xudC5jICAgICAgICAgICAgICAgfCAgMjIgKy0NCiBu
ZXQvc3VucnBjL3JwY2JfY2xudC5jICAgICAgICAgIHwgIDM5ICsrLQ0KIG5ldC9zdW5ycGMvc3lz
ZnMuYyAgICAgICAgICAgICAgfCAgIDEgKw0KIG5ldC9zdW5ycGMvc3lzZnMuaCAgICAgICAgICAg
ICAgfCAgIDcgLQ0KIG5ldC9zdW5ycGMveHBydHNvY2suYyAgICAgICAgICAgfCA0MzQgKysrKysr
KysrKysrKysrKysrKysrKysrKystDQogMzEgZmlsZXMgY2hhbmdlZCwgMTU2NiBpbnNlcnRpb25z
KCspLCA0MzUgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IG5ldC9zdW5ycGMvYXV0
aF90bHMuYw0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
