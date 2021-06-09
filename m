Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8193A1B94
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 19:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFIRQM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 13:16:12 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:37217
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230152AbhFIRQM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Jun 2021 13:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRue2puYoTc11lgcPFvEwunGqXrvh4I6jVrGq/OaAVw2xT+LwHIs8fZaB9YMqUqX8FohR++jmNYi9q5BNwjJvvdAhsngcpEa2SMoJlYPhuPC3W/pSgxcW11qOA8jNlaW1F4p1PVCUl2yaBmNRg0n9aaqlMN3qIc9lJjl4l9OVMkX5iOCpMBZ3bcgs3cg/EUNSfvZYYvivX4OgZ05uKWHkjG7qAKQMNINoHwt4sWuXrLN9IEkuO3v/IGzBZNEi7A2+WCg7vStSqXPgBmQIwUmix2D4nj6Uzbt4f04qVesjkH+oRnbq5S5bwGmIsUxKrn3CckR+8bU4Nri8vQydFt72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/dj/Fjk66vtslrfMb9gtOvC7XU2C/s4eIfwlv5VBh0=;
 b=oBJ9hA3uQlMApDIyI7XqH9Z34ZKCah7jacCz4gFsLw+D3X788He0e7wvYMSJhhEvV3PshhPUyRx6flJlTO1xwg1+zVZzqeXqMA7sUlXEIe+et+zoRddFwSU0ynyhrvq44ocjjVVSMVvNDRziXewz4ba4XNOF869hln9ltiMuQwBzLVIruztZPEjajTefKO5Vdy/tzYM9P9oft2jhpD3FNxdG3Y42Z9UEHCH/mkZUg9DhPG8Oaaaz1OhaGgejdlq1OSwNJeZIYwScaRFQ773QYIz1zvgm8Uel2/9hfzn7h9uySRW3OVgxt43IiWCRpFBE4eYJucY/+lolz8oVRKtv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/dj/Fjk66vtslrfMb9gtOvC7XU2C/s4eIfwlv5VBh0=;
 b=TfifVeUxUhlOkmAz72uj4BM21H1jL7vf8lT2tr1p+aK1x6VzwHgRUrY2ixpESc9DgDNIClG1l7JrrxKKqdBT/jgb5rgL0m6cPcIdL7NLlIm+g+xOgfaa6SxE6xsAq00vQ84voRHs52zpnBBSbT8N0aV8QRGEImXj14r5qujggT0=
Received: from CO1PR05MB8101.namprd05.prod.outlook.com (2603:10b6:303:fa::14)
 by CO2PR05MB2504.namprd05.prod.outlook.com (2603:10b6:102:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9; Wed, 9 Jun
 2021 17:14:15 +0000
Received: from CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002]) by CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002%7]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 17:14:15 +0000
From:   Michael Wakabayashi <mwakabayashi@vmware.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Benjamin Coddington <bcodding@redhat.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <SteveD@redhat.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgAGJKICAAZPoloAADT6AgAAH7wqAABF6AIAAETsAgAAJXACAG0yW/4AAkD6AgADZOSOAAJ1cAIAAAq4AgAAlyhY=
Date:   Wed, 9 Jun 2021 17:14:15 +0000
Message-ID: <CO1PR05MB810131AFEF9FEA2BE2E708AAB7369@CO1PR05MB8101.namprd05.prod.outlook.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com>
 <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
 <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
 <43b719c36652cdaf110a50c84154fca54498e772.camel@hammerspace.com>
 <CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com>
 <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
 <CO1PR05MB81011A1297BCA22C772AF836B7369@CO1PR05MB8101.namprd05.prod.outlook.com>
 <FCDAEE4A-33CB-4939-8001-DAAFD7BC8638@redhat.com>,<CAN-5tyF4fsfeuzcbXzyWNfQ3wSx2WDxMtyk+dPUdd7H4nJ8hug@mail.gmail.com>
In-Reply-To: <CAN-5tyF4fsfeuzcbXzyWNfQ3wSx2WDxMtyk+dPUdd7H4nJ8hug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [67.161.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 579d14f7-ee73-42ce-0352-08d92b6a0229
x-ms-traffictypediagnostic: CO2PR05MB2504:
x-microsoft-antispam-prvs: <CO2PR05MB2504D9683A084AED7682F821B7369@CO2PR05MB2504.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Xifhb4CLgFINdZYnFB9suXr6WxQmc7V4vFQ+Lgl+GlM3P/P8A/L64rs1+EV8rE+DXlFyLIygx4b83jg2LMuWQTO+uB5t38NRi43m3XCEGT/NpGj1e/6JAPKyOmso0gDCGgIWN28qhHXMpvO2lydxfU6PF1ky7R5EcGXtu6llKCEcn34EmNSmYw1SOx1vTX1YlVBOz7EJ0dWDzs2kBfs4Q+Oy6z21tDdlUpq19LekrVVqtuVumwyMpORiiV/7qNekDcfWtAmvmaZRDYoKT6tM8/g0BsQFTOFXKg7exKtY6fQyot6gjp4s80Znrcim7fxmq3i7Ypbdo3v6U5b7zg6gZpYJx70308Tj1jQFGxqnuqHHuW4U4W/pyEuLe4dufOkYDURpN8avoELPr2TX0yT83UB+XcQjgdKwp/rZ932hJTAAWaiThYfyx1YQmHLCXyQexkyGZ5iVm7iOqtI3pL5ms3O/WLlGBFXslrwfvuX87lSbvSfYIEjgNYD42CjgZJejDxXaKrnjCHJ+mNtWkCES/YQuCEsDtOgHY0OH4hpvx5iteX24/qs9s/nOJDM5BzL1KhHmlP9yRsnEyyQXvhHAN6S4KnpMoJ2cYK9dJ6BvXE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8101.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(66476007)(64756008)(66556008)(66446008)(54906003)(66946007)(76116006)(316002)(7696005)(91956017)(8936002)(5660300002)(52536014)(26005)(2906002)(110136005)(71200400001)(478600001)(86362001)(33656002)(4326008)(9686003)(8676002)(38100700002)(122000001)(55016002)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODZrNmFUWU0rNEExZGxhR1ZaRU93OVhXUk1pVkVVUDRMeTFqMGJyNmZCcWF6?=
 =?utf-8?B?anliaHFhdHpvMUNBZ3VtbzNhRi94ZTNDdERzRkRpOUN0QkZKS3B5Q0c2bWpj?=
 =?utf-8?B?OUhWQjVhMFM4eDFrdUVrcDFNQUJDZzVzWDcyanZOUFNENjlVdXZGenJCOEpL?=
 =?utf-8?B?eVVCTFpWMzhNNjdJUUVGbXlxcHpSczMwQ1JXWGlzYkw4bnFFYTN1ek9yZjlI?=
 =?utf-8?B?V0RoeE9meWZ1QWd0WmIwTFhCbENDZ0Jpay82WEFvUGlpdE9SQkxiNjJHTTVk?=
 =?utf-8?B?c3VTT3g2cndQc1hPVmFWMW9ZdUdiT1RlNzU2WkRmaGRJanM2Z3cySUdrMVJZ?=
 =?utf-8?B?OHNkTjNiMDRpQXN1NUVaMmRUVkRERTU2Uld3MkM0cFl2U01xclI0OGF2dlF3?=
 =?utf-8?B?UTE2Mis4OEp4RVYrYzRhMGRsYy8zYk1DZXFKdFVobjdpZ1Y2Y3FLaXYrRVZG?=
 =?utf-8?B?Zm9CUXdSMGZHVnEzQ0VYOGNrYWxIMXlpdjBzVjFHYmZyVnVTN25LOXEveCtP?=
 =?utf-8?B?UkF5TUlEUTlqY0IrY0dPbUJWRmJHRDU5bFo2dWUwMy9BR05kV25Kb2tZd0s4?=
 =?utf-8?B?cEloOGJPU29SbnV2NGFjZTd3SWMzRUdaL2xwam9FY0ZBUVBqSVFINHE0RWF5?=
 =?utf-8?B?VVQxeUJyNU5XQkNIZG5OcTNUb2ZKUHJPOHhsa0dlb2ZSZXJZOTFnYzZIQjBH?=
 =?utf-8?B?YWNEVlVwREg5VVBaVnowYVloV0VzOXhZajZEZjRjbUVrQzlBMVBONnFtUDFy?=
 =?utf-8?B?NWF4UWlJUEdWZlNzWTBmTFR2MVVSNXV2N2tjci9ROUVoMVZWNWpaL0ZYRmFv?=
 =?utf-8?B?N2V2ZHN2OFAvM0hqQTAzdlBaUzJNcXNSYlRiTHFqTHFzUHVMdUpCWlZaUlVL?=
 =?utf-8?B?RzhEekVReGwrc3RpYnNpSjAxOFc0RTgzZ0JkNStzTVpRTXMrRnovaGZuUUR1?=
 =?utf-8?B?aHN2M3NRcGpQUEEvaEZXaCsrcFFSUnNXUFFJWFBkajZqck5tSThDWVJqR2tU?=
 =?utf-8?B?Uy9EQ1cvSnU1RDRpZ1cwU3NRb1hObm9xQm44bUZvY1ZtUXg0UFA5NmFpdmR2?=
 =?utf-8?B?N3JyKzVVb1VpM0YrK3YzUFoxQXdvbU1aVGRiVnFlMlNZaWo5dm5FWGRJYkM2?=
 =?utf-8?B?K1FXVUdHeWpMREYxdGxxcUtGKy81WnR2RjVCZ204ZXVmVVZNdVFscjZhdlkz?=
 =?utf-8?B?dk1HbmdJVnRTbHhsZ1hsSC8wQVhWSlUvTXVhVjZSNEp5QXJkdTJlQVd4dWZ2?=
 =?utf-8?B?NTN3eUJaVGRhdnNwUDF6a0RMUDNJcFVpc2JoaGZ5MWtLQVlzOFZkUG0xV0ts?=
 =?utf-8?B?bGx0Wi9KQ1RVeXZuUnEwK2NQYlVEaGJPa0djblp2NVhLcGRNOHVzd0Y0VkVR?=
 =?utf-8?B?RmtLSVFrU1hQdjBXa3l6RUZIUVhsbHFncjlxRTJhK3Z0RW1aOUl4am4xc0x1?=
 =?utf-8?B?ejVERjBZZ1pYdDJJeC92b09SeVJac3NtVSt4citiWlIxYmhpSk8wR2V6OVc2?=
 =?utf-8?B?UUVxS1lGT0JWcVA2TklXVXJqZXBXNjAvbXRLa3hFM3g4MzdqVm1HbHVGWnM0?=
 =?utf-8?B?ajhRb3VGclBPVUlZK1UvTkt2K0ROOFhzZG1wSTlNZm9XR3FOalFuTjVPNUtI?=
 =?utf-8?B?ejN3QW1yQjA5R2wxVDhpQUU2VUJFK3pCT3M3NEZhNE5BL2dUU1NycDhFK3pI?=
 =?utf-8?B?SVp1VDFVWTlrZ24vV255Qmk4ZHFJWTY5MUUzOVA0NGpnYlNmMzJPOWl4c3BE?=
 =?utf-8?Q?j32YKFaRhAdEAcAvpA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579d14f7-ee73-42ce-0352-08d92b6a0229
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 17:14:15.1360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/y8JgiS7c4KvIzHT0H36ACtVr2OOE8h7pE/BCC3SuA2uJgCDVZER5rX93U8GjAJaJWlPGnyVsLT+Qqb+ScNlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR05MB2504
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBJIHRoaW5rIHdlIGFyZSBzdGlsbCBub3QgdW5kZXJzdGFuZGluZyB3aGF0IG5ldHdvcmsgc2V0
dXAgdGhhdCBpcwo+IGhhcHBlbmluZyB0aGF0IGxlYWRzIHRvIGEgY2xpZW50IHNlbmRpbmcgYSBT
WU4gKHdoaWNoIGlzIGluY29ycmVjdCkgdG8KPiB3aGF0IGlzIHN1cHBvc2VkIHRvIGJlIGFuIHVu
cmVhY2hhYmxlIHNlcnZlciBpbnN0ZWFkIG9mIHRpbWluZyBvdXQKPiBmYXN0IChiZWNhdXNlIHRo
ZXJlIHNob3VsZG4ndCBiZSBhbiBBUlAgZW50cnkpLgo+IAo+IE1pa2UsIGNhbiB5b3Ugc2hvdyB5
b3VyIGFycCBjYWNoZSBpbmZvIChhcnAgLW4pIGR1cmluZyB5b3VyIHJ1bj8KCkhlcmUncyBteSBy
dW46CihOb3RlOiDigIsxMC4xNjIuMTU5LjI1MyBpcyB0aGUgZ2F0ZXdheSBmb3IgdGhlIGRlZmF1
bHQgcm91dGUuKQoKcm9vdEBtaWtlcy11YnVudHUtMjEtMDQ6L3RtcC9kYmcjIGRhdGU7IGFycCAt
bjsgZGF0ZTsgY2F0IG1vdW50X2hhbmcuc2g7IGRhdGU7IC4vbW91bnRfaGFuZy5zaDsgZGF0ZTsg
YXJwIC1uCgpXZWQgSnVuICA5IDE3OjAwOjA3IFVUQyAyMDIxCkFkZHJlc3MgICAgICAgICAgICAg
ICAgICBIV3R5cGUgIEhXYWRkcmVzcyAgICAgICAgICAgRmxhZ3MgTWFzayAgICAgICAgICAgIElm
YWNlCjEwLjE2Mi4xNTkuMjUzICAgICAgICAgICBldGhlciAgIDAwOjAwOjBjOjlmOmZhOjNjICAg
QyAgICAgICAgICAgICAgICAgICAgIGVuczE5MgoKV2VkIEp1biAgOSAxNzowMDowNyBVVEMgMjAy
MQojIS9iaW4vc2ggLXgKbW91bnQgLW8gdmVycz00IC12IC12IC12IDIuMi4yLjI6L2Zha2VfcGF0
aCAvdG1wL21udC5kZWFkICYKZWNobyBQSURfT0ZfREVBRF9CR19NT1VOVD0kIQpzbGVlcCA1Cm1v
dW50IC1vIHZlcnM9NCAtdiAtdiAtdiAxMC4xODguNzYuNjc6L2dpdCAvdG1wL21udC5hbGl2ZQoK
V2VkIEp1biAgOSAxNzowMDowNyBVVEMgMjAyMQorIGVjaG8rIG1vdW50IC1vIHZlcnM9NCAtdiAt
diAtdiAyLjIuMi4yOi9mYWtlX3BhdGggL3RtcC9tbnQuZGVhZAogUElEX09GX0RFQURfQkdfTU9V
TlQ9NzY3NzAzClBJRF9PRl9ERUFEX0JHX01PVU5UPTc2NzcwMworIHNsZWVwIDUKbW91bnQubmZz
OiB0aW1lb3V0IHNldCBmb3IgV2VkIEp1biAgOSAxNzowMjowNyAyMDIxCm1vdW50Lm5mczogdHJ5
aW5nIHRleHQtYmFzZWQgb3B0aW9ucyAndmVycz00LGFkZHI9Mi4yLjIuMixjbGllbnRhZGRyPTEw
LjE2Mi4xMzIuMjMxJworIG1vdW50IC1vIHZlcnM9NCAtdiAtdiAtdiAxMC4xODguNzYuNjc6L2dp
dCAvdG1wL21udC5hbGl2ZQptb3VudC5uZnM6IHRpbWVvdXQgc2V0IGZvciBXZWQgSnVuICA5IDE3
OjAyOjEyIDIwMjEKbW91bnQubmZzOiB0cnlpbmcgdGV4dC1iYXNlZCBvcHRpb25zICd2ZXJzPTQs
YWRkcj0xMC4xODguNzYuNjcsY2xpZW50YWRkcj0xMC4xNjIuMTMyLjIzMScKbW91bnQubmZzOiBt
b3VudCgyKTogQ29ubmVjdGlvbiB0aW1lZCBvdXQKbW91bnQubmZzOiBDb25uZWN0aW9uIHRpbWVk
IG91dAptb3VudC5uZnM6IG1vdW50KDIpOiBDb25uZWN0aW9uIHRpbWVkIG91dAptb3VudC5uZnM6
IENvbm5lY3Rpb24gdGltZWQgb3V0Cm1vdW50Lm5mczogbW91bnQoMik6IENvbm5lY3Rpb24gdGlt
ZWQgb3V0Cm1vdW50Lm5mczogQ29ubmVjdGlvbiB0aW1lZCBvdXQKCldlZCBKdW4gIDkgMTc6MDc6
NDAgVVRDIDIwMjEKQWRkcmVzcyAgICAgICAgICAgICAgICAgIEhXdHlwZSAgSFdhZGRyZXNzICAg
ICAgICAgICBGbGFncyBNYXNrICAgICAgICAgICAgSWZhY2UKMTAuMTYyLjE1OS4yNTMgICAgICAg
ICAgIGV0aGVyICAgMDA6MDA6MGM6OWY6ZmE6M2MgICBDICAgICAgICAgICAgICAgICAgICAgZW5z
MTkyCjEwLjE2Mi4xNTkuMjUyICAgICAgICAgICBldGhlciAgIDAwOmRlOmZiOmE2OjU2OjdjICAg
QyAgICAgICAgICAgICAgICAgICAgIGVuczE5Mgpyb290QG1pa2VzLXVidW50dS0yMS0wNDovdG1w
L2RiZyMK
