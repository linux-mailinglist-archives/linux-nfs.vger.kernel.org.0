Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9641B0C4E
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 15:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDTNNr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 09:13:47 -0400
Received: from mail-co1nam11on2118.outbound.protection.outlook.com ([40.107.220.118]:59809
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbgDTNNq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Apr 2020 09:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gb6S9fCJO7ztksaLUOr86k+aloQWcbp5KG/519oa8jDY+HVFTq5LJt+LCyKwLLFsV9XJlK/WMAMv/HXTSkqNk/wQ3PcQDOS9WHS4Cy2pmPa3Cep0nzzbzkaugW0PTSRblR8K0THf/rdY7y8HFtijMAcV/QzUvdrwVwklrDR59z4H8gR++3ctU7PKW2hiadNk1/9KobMjs3D7XcJbl4uxpppBVpCZ6GqFeKcHxZC8PlN7EcUroDfqUveG6Moqymq9R2Wz8QxbNRZwf77R46RO2N0vvtP/059XvKsLv1xgnSmQzpPMvGHgbDn5gn17G+/CZiAvIJEwf6rq8zYtH8gUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkPfkT9vWD1N+vIZYv47PL/3kmIWiufmb6r0b3Rg7Hk=;
 b=nfl5NNO5s12WVjwYridxWwKrL3f/iGJ/brH76ftOkMLQCv4zgG25nyIQaV7gGsRNSKtwimjOtt93wLawY6gmk1BrH9B6R8iAh+kIgbl7z8EC3zgbamqAiEYAgn9jETOv3cSOCGxMM7puAS3EQd4GgW5QAsxWEW1VnQEFW0g/Ac0cw8IdxImExh1KWxdqb9kHMLVuYmszUTyxiWttvoBQdoXTl4KT2AkOMq4tJ3khU/i45AQp0Yzoa75FFjupHboHagAy0VViPlEDc5GLJOWnf7lpsZLFWld6fKgttfHw0uLaFtSMRtRaIQZkAMKU6NhpUvF9jl0pXhueIbGzN7/9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkPfkT9vWD1N+vIZYv47PL/3kmIWiufmb6r0b3Rg7Hk=;
 b=bU01qqSnw9F1dBh8q6Dnu9x99t5UCI0h1kp0ISiXRvtAJGZZm6UaYYTtAUAWFMvYd3LAEerei/8ZNUQI6bnKZ9r9tiCLry02sB2nvMPK7hCSfqYJXlgwdkULRdZYudwCUHGKj1mO+Gb0FEnqchWy+EF9bCFWjBaLumEa+E12I5o=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3816.namprd13.prod.outlook.com (2603:10b6:610:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Mon, 20 Apr
 2020 13:13:43 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 13:13:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "agruenba@redhat.com" <agruenba@redhat.com>
CC:     "okir@suse.de" <okir@suse.de>,
        "tanxin.ctf@gmail.com" <tanxin.ctf@gmail.com>,
        "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>,
        "akpm@osdl.org" <akpm@osdl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>
Subject: Re: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Thread-Topic: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Thread-Index: AQHWFta2cwgyqFk5TU+ydXFUjCaulaiB7LGAgAAKgYCAAAJHAIAAAU+AgAACkIA=
Date:   Mon, 20 Apr 2020 13:13:43 +0000
Message-ID: <c19f1a6ac3664dca12706400dc425538ccf8f101.camel@hammerspace.com>
References: <1587361410-83560-1-git-send-email-xiyuyang19@fudan.edu.cn>
         <7b95f2ac1e65635dcb160ca20e798d95b7503e49.camel@hammerspace.com>
         <20200420125141.18002-1-agruenba@redhat.com>
         <52a445020247f4dbe810ce757e48cd563a69c4ce.camel@hammerspace.com>
         <CAHc6FU411Eoo_E=aQiR=Vk2Tx6XCZEuiz25NykWY+dd5wKrszg@mail.gmail.com>
In-Reply-To: <CAHc6FU411Eoo_E=aQiR=Vk2Tx6XCZEuiz25NykWY+dd5wKrszg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5949a835-7399-47dd-e98c-08d7e52ca6dd
x-ms-traffictypediagnostic: CH2PR13MB3816:
x-microsoft-antispam-prvs: <CH2PR13MB381637A15E318269A1704C46B8D40@CH2PR13MB3816.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(39830400003)(376002)(366004)(346002)(8676002)(26005)(53546011)(6506007)(186003)(316002)(86362001)(36756003)(81156014)(7416002)(2906002)(54906003)(8936002)(2616005)(6486002)(66476007)(66446008)(64756008)(4326008)(66556008)(91956017)(4744005)(5660300002)(76116006)(66946007)(6916009)(478600001)(6512007)(71200400001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0/e2gifYRgWvNF9nr0mvVE6TU4rtVtIJx00vr7fv3177jAIR21yFPh4ZqmaYG/8NUl85e9Em/rQtE3N8wsCgKd+yXiWpsoAH39NASGM0WwmYnUA6J165292J729VV4+dva2FChMzGvjxufYKrvxy+Nb7o3xr7XWKw2JC0TZ+4rR4AY22cNgfl4DasmyFfkY2Jonna1n/2JpV9oQkVNvqWhF+rEa9cP+erDkJoz4ZW9d0b4FI0QODktJarU/z5enmZxJ+1Hyl+NV5dYkxG6D2Eja4rk7X8LmOT5d1jiOF1a4KLjdXj6piMxRyfSWsJxjg7uTr6UqTxFDSVB9Lw8WqQM468tWJh9R6qfNPHz1RKGx/Bmwe2ZG72xKT/0gKaUylZLfM7IRBkZpHArmPT9ej90LbglCgV7LWiua/Xi9ADgbPj8/a1mdFLv59p4v70Ta
x-ms-exchange-antispam-messagedata: rKfP/UE+NzAcloKdByxB/qMkerNFAjUkQCIetZuDUKr/gNIFJcKsWj5TAv58Q+FHxV2ObMZnckRRMmwi2PBiB0GhmqtYAUYRNACyNLHwZpH3j7OnJI3slY/tngMhfSiBEAiMcm7E9j6hAvfnBM0ICtZGck1f75vi1VPU0bbXbiZvsz6J1Y0LLkAuPNhu8Of+dvlL32JpE2R4Clf3kHgnrVSv5fW5g6zrGd9odju5VYHvK/J889IbsGKtlpHmyXlOBaMamh0Uf3fWex8rD/SiIfOIXwQjhDeKyCms4bbHmxYpjAMiPCvXQ3G8Ct/HC98vgIV37McKFjZ0z6A039+aH7ccuZ5eO1USr03px+ldeHVntT4N+xOxqfq1BMuMQybO+YsaAkZvgIU2m31TojZ/zu0nSZsTZ1l63h49eyU9yTHHG74rqsj7p+jLi1jsH+iGH4jTQA5wmwi4WXQCY0RWQkqXrlDXrrX10TmfsPXoqxTv1MS0XF6na6vN8Y9iOYQ9XdGp+wlODXPwTINNw9gCj/nQb4tGC3VhbxSaEHlg9pjRpWNR4dN4I/qyw+3s9GfGOV6cmti8xUBCfzxS9z8gL4OPFS+xcEO5j4Fcsm9AZUzABWUNFYTFtcIl785ivmLyBSwy/M6lWh3FxsnaZAVFtG6CPzQW66yVBugg/Qrd36M3kJD39BiyKBTzz/O5cUh1TImGoZ8DR3QRRwu2xh1CrN/SCXU1rHQU77a1OGPU0GWTMiZTfxDEjfShWyqAZAHDaxKCzU5M6yBljKIFjPO6h/84HIzH0SZ/F8iAMXC0New=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BAD6163B836DA4E92161A383DDAE58C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5949a835-7399-47dd-e98c-08d7e52ca6dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 13:13:43.4998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6VdOef6fNWoq8Bc6Aj9XYPmB7kFfb7f9JW+wrciQXLbxQoxdci5mrzvo6ZXUXfd5jlQBeuh/LyyyB4Ldf/7hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3816
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDE1OjA0ICswMjAwLCBBbmRyZWFzIEdydWVuYmFjaGVyIHdy
b3RlOg0KPiBPbiBNb24sIEFwciAyMCwgMjAyMCBhdCAyOjU5IFBNIFRyb25kIE15a2xlYnVzdCA8
DQo+IHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiBXZWxsLCB0aGF0IHNob3Vs
ZCBPb3BzIHdoZW4gZWl0aGVyIElTX0VSUihhY2wpIG9yIElTX0VSUihkZmFjbCkNCj4gPiB0cmln
Z2Vycywgc2hvdWxkbid0IGl0Pw0KPiANCj4gWWVzLCBjaGVja3MgbWlzc2luZ3MuIEJ1dCB5b3Ug
Z2V0IHRoZSBpZGVhLg0KPiANCg0KRmFpciBlbm91Z2gg8J+Zgg0KDQpDYW4gSSBleHBlY3QgYW4g
b2ZmaWNpYWwgcGF0Y2ggZnJvbSBlaXRoZXIgeW91IG9yIHRoZSBvcmlnaW5hbA0Kc3VibWl0dGVy
cz8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
