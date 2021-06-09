Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481E93A1E09
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 22:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFIUVu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 16:21:50 -0400
Received: from mail-dm6nam08on2051.outbound.protection.outlook.com ([40.107.102.51]:60289
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229519AbhFIUVu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Jun 2021 16:21:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEwrINfQg7S2wq531gVrGfAbEi0HRd3fAdY4Hs/kUE7nNVHtG0tR9RoDDDopAnQFN5YGhP14yMdUvWek9vbo45aOaaqD2LdKDM8YkL5M6t6SNfepGFRgqY/Qx01w18cawbN+jeFdL9Jg9YolL0x/bJv9EwGaFgjJynkca9kxx8sskTF8dun9oEFuB6bmvmpIhBHxrKfJ4OrOxEYfroTCCVYSvWyju6GpgfGHZS99T4Gc0xZ8fE3nnXOeD4h9PY1lZ4bVZn66jsEJ2Lh5Zat9VpUsRMhaSR6Q44scIkC4wweKeZs4wopqIs5FIUXZeH0+izqBbRE47feRtD9ASw+4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2VKmi2T+3MSgWEOW8cDTZhuAfav7IqyIZokYXSroWU=;
 b=cmznhROFv88IeUNMp0FxkiUgYRR3YSKZOO8H91Hd8CoX3x6HqkiLMh5eEeE/Rjg99/3xplrvZ62asZm6Nj9PzP/saRoq5yBxF9GgJJ80tFVarTwEBBExtRrc/jWhe1A6GRajlgjb4XcgwgEtVgx95pa9fudSTFmW2xk5qqb94xtXj/JjwJ7/PYfaI3FrSxXx4DPCO4hr1BaQNN47QzKmZ2tgAJtskhX8ytylJcqMkwFyoE+2ubdIPyXsvGFPeiMCYvOn+UwaLoTzJmTBbtcjbpSRMM2K1If+hqiVaec1mNBfIjeZu77QLMnaplroamceGFgcfwA/C8y0j+lznZ6/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2VKmi2T+3MSgWEOW8cDTZhuAfav7IqyIZokYXSroWU=;
 b=Gxm+ZfEfQV3+J5d5xHveKY7dZpxEb6Dt7ADPj1hFW7e9oyz8+CiefEnNvuEB1hKcECLMneaP5wxC5twUoEkW250MC7GFXESSeXEmxDKcTlMZFrGzd8sUO57NfqaVRn+z8uy6dBT79qNjgKGEB5Pma3ZPZqiRtg2dwlIQnVjTPLI=
Received: from CO1PR05MB7925.namprd05.prod.outlook.com (2603:10b6:303:f1::22)
 by MWHPR05MB3517.namprd05.prod.outlook.com (2603:10b6:301:41::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.19; Wed, 9 Jun
 2021 20:19:53 +0000
Received: from CO1PR05MB7925.namprd05.prod.outlook.com
 ([fe80::5d82:70cd:f77c:d9a9]) by CO1PR05MB7925.namprd05.prod.outlook.com
 ([fe80::5d82:70cd:f77c:d9a9%7]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 20:19:53 +0000
From:   Alex Romanenko <alex@vmware.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Michael Wakabayashi <mwakabayashi@vmware.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: RE: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgAGJKICAAZPoloAADT6AgAAH7wqAABF6AIAAETsAgAAJXACAG0yW/4AAkD6AgADZOSOAAJIEAIAAVdBg
Date:   Wed, 9 Jun 2021 20:19:52 +0000
Message-ID: <CO1PR05MB7925DC61979C2611A3E23721BF369@CO1PR05MB7925.namprd05.prod.outlook.com>
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
 <CAN-5tyFZNzyr0FBUeuOc92xiaq+52G1uyfuP3mAZbGxR+v1Rfg@mail.gmail.com>
In-Reply-To: <CAN-5tyFZNzyr0FBUeuOc92xiaq+52G1uyfuP3mAZbGxR+v1Rfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fec1802a-0f5d-4e33-2441-08d92b83f0df
x-ms-traffictypediagnostic: MWHPR05MB3517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR05MB351718596907F76A82D09F5ABF369@MWHPR05MB3517.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKuDR7Sjcuix9HYd3wz9w3PwSUYnlehCUCo3zjRoWgoXUodwSHMN4qPucBZA3JUlwUVghEKvddxyX4rfi38zqk6o90x/bcqQftTRqXvtwEd/6tg8ovGLrIEdQZTCepCfwhx1OIBphjmIemA601qTEI+zpmXo9xjmhiyHL2GwgsfhzO2ZO6XXpXy2/01qx88hsIT1NoW5QL1qmFM2LsSYQYNegBs8ByTQe6KkCFi8pGsoYR0MwSlrv4NYJU1mbuOueU2h5MVId3d8C15TRfT+gFXNIVsFGwclRv0KHayX03R49Q9LYVHoeK2qOAVq88NOjc+wGz1AvzEuzFmSPm+7+m1n9iJJ8pSoE6n4Gkx+CSNygbqHG5d93L1cREFYnPmMtPNL9w/h1Ws7yG+K+jO+Z2GTTFRxVzA7SCQnebh/kfHTMwoWMv9YdoikPUpxx5d1lNQ4Yh5mB5Ri1cEy/hoSu/KB5eRpJHnSyT9okq64z7EF/NhKKl64FIO6Nir85rzHN777qLB8bBF5C8aTeeTEnOi66mEbRzWEfQC22jnDU9ZQHKneHEcgZh/gZbc79laErIeJCXTXPG7OTJpDXQFelVy6MF6ugx0izZjeMT6rBeCe0jqdcUcGKa2zyr6pV2S8AXjLsnSKYVhP1FYH+M0kNDk4sk+P2zsnlPeVlStQJ2y/ugi69gE1elfbTK/WmabqywWityNJf+eYpJSY0GlaNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB7925.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(71200400001)(186003)(6636002)(5660300002)(316002)(110136005)(86362001)(54906003)(7696005)(66446008)(64756008)(4326008)(66476007)(52536014)(66556008)(122000001)(66946007)(76116006)(38100700002)(33656002)(55016002)(8936002)(478600001)(83380400001)(66574015)(9686003)(2906002)(4744005)(6506007)(8676002)(966005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K013MEg5VFpneGlRWHJBMU05UUdtV3ZwMkpPUUpSTnhMcld3RDNoN1VINGZj?=
 =?utf-8?B?T2ZtaGF4aUtTRkd5WUplRmxCeXlEY3V3RGdmTS9XNXpqanQrTkxOaXRGQWZt?=
 =?utf-8?B?L21FZkJNcmZ3ZU9FZHFyeVF3ODc4RjIxM1F6dGJCc1pRMkNVODRnOGIxdjNa?=
 =?utf-8?B?TFNaWjdicHh4blk0VjhaY0QrN0pGdWFwR0dhV3hlb0tCVGxVY2pib1l6T05K?=
 =?utf-8?B?YzJUK2tNV2gyWkRybjlvZ2VRbXFQRjBmTkl5UXdHc2VFbGszTS9MWmZuTzBt?=
 =?utf-8?B?VnpJTVlhZ3g2QzdlRHYxYThLU1VmenhFU2VCaVl3ZU5VVGFZTUF6SjJqNG5B?=
 =?utf-8?B?QnBBWHBUNUFoL21ha0dGZ1VzWXdXa2EyNDRvUlRMaTRNNm1kVmxWaGhMWHlu?=
 =?utf-8?B?VjNYY1FRUVZVUlRWbU1mdTVzd3VnNjVRaWxQZWRoVDJndEM1M0IrSlNjZG1x?=
 =?utf-8?B?NnlSUHdxSWZoNEN6dDYxcVZCbTdTMEIrNFVKWDZ5RHcrdWMzZzBJTXR6RlFj?=
 =?utf-8?B?SSt1ZUlRZ1dBc1FXK21Nblh6dHhkWXA4YTdFWkFLckN0UVV3ZlVWbHlQb1Bq?=
 =?utf-8?B?aE1Ga2l5RUd6WkJnek5WVUUrRFVxREJvcG95d2F3VlAybjR1S0o3SjErRERK?=
 =?utf-8?B?azh4bTFxVXVKcU93cXBKWEd3cStrS0ZCRFlRYURXemE2anJYcDZxd3J2bm1X?=
 =?utf-8?B?VGFCVFFwQnBBMWh1Y3NrWmdCQ1Z0SGNtSkNubVk5U2hWUUZzNGU2cGhiQUF2?=
 =?utf-8?B?dWFkR3BNZkFacGk0QXc0RXJOenRTWFlpRGdaS2p1b1ptcldhM3RXOC9nNjZF?=
 =?utf-8?B?eWpmNlNhdy9ObnpjQ1NRd2xodjBndkRCNTVISmNKZnE1NkZoWEdpeGZlUXdE?=
 =?utf-8?B?OUQrSkJ6RWRXcEhLMmdvZnRHUWxCUEx5RzNPbzFqbnpyN2ZjTHJZeWlmbVRz?=
 =?utf-8?B?dXRicUNEaGQybXMreVdYQmtmL29mQ1F1cFl1OS9GejJUTnJOUW9FVWZ4MGo0?=
 =?utf-8?B?emZUODJ0M1E4alpOUlV3QmpDNTJCVVZ5YkthYUlDbU9uZGJCSDVBM3B6aE5a?=
 =?utf-8?B?Y0NwUU52dksxRlhQTTBWeDJITjNULzFYeWhscjVudXI0MWZVeXpiVGNjQ01X?=
 =?utf-8?B?cmRGdHpDUm1LanZ6RDU3ZURIMHhCTDI2R0FrdStmN2Q1Q240dTZIWTQwSWpF?=
 =?utf-8?B?YXhuTll4QlRCaDRFQjlxekhPZDNlUE1pckE0MytCdUpJaCt1UEd0cW9ZcHVz?=
 =?utf-8?B?d2h1aks3d25Nd1p3OXlJYmIzZmsvNHFmN1J5d0JhQVByWmJGV0tzZUdZWVNS?=
 =?utf-8?B?VktSYjRLaElOVTUxWXd2bDJZNUpPZ2h2ZzR0b2ptMnJWcy9Lb1ZZd1ZxWTlW?=
 =?utf-8?B?TUlPQkpiWUJHR2pPSHZHNVV6bDVNNWZoY1BRaTVxM1FsamtaR1YvUUIvK2ZS?=
 =?utf-8?B?R2R4K0Q0bTUwTTBUVERSZTMvVmkzeWFQNElHbUl1NUhxR3ZWVmNpU1NCMzMw?=
 =?utf-8?B?dzhKQTVyOFpadzQ0V3duNmNhMjQzdXFaRVFqR0owTmxvRWtKM0pEYmN4NUZi?=
 =?utf-8?B?MnYxQnpMZXEzNm1mMEZEdTVzNVQ3UjFTMGYvTG5QUDViTzBNMEpub1MveU1y?=
 =?utf-8?B?NVU2OCs4M3paYmltY3lMQ2ozQ1B5MEJZM085NVFWbHVZZkNrd3FDaUlXQnZO?=
 =?utf-8?B?Z01PRGJJV2xqRGlzQUh4TXdYcTZaTUh6cExUU0hpN1ZjbTUvdHdTVURkN3Bq?=
 =?utf-8?Q?2EnniQNAvjEYsUmbLM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB7925.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec1802a-0f5d-4e33-2441-08d92b83f0df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 20:19:53.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unsp7xx23aPkrAnkq8HALOriXaeJU2dA9kdpCq0GcZfGxag0HaPdDxLS2kB+oQM7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3517
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBUaGVyZSBhcmUgbm8gU1lOcyB0byAyLjIuMi4yIGluIG15IHRyYWNlcy4gU28gc29tZXRoaW5n
IGRpZmZlcmVudA0KPiBhYm91dCBuZXR3b3JrIGluZnJhc3RydWN0dXJlcyB3aGVyZSBpbiB5b3Vy
IGNhc2UgZm9yIHNvbWUgcmVhc29uIHlvdQ0KPiBhcmUgc2VuZGluZyBzb21ldGhpbmcgdG8gMi4y
LjIuMiBhbmQgdGhlIG9ubHkgcmVhc29uIEkgY2FuIHRoaW5rIG9mIGlzDQo+IHRoYXQgeW91IGhh
dmUgc29tZXRoaW5nIGluIHRoZSBBUlAgY2FjaGUgYW5kIEkgZG9uJ3QuIEFuZCBBbGV4IHllcyBJ
DQo+IGRvIGhhdmUgYW4gQVJQIGVudHJ5IGZvciBteSBkZWZhdWx0IGdhdGV3YXkgYnV0IG5vIHRo
ZXJlIGlzIG5vIFNZTg0KPiBzZW50IHRvIHRoZSBzZXJ2ZXIgZnJvbSBhIGRpZmZlcmVudCBzdWJu
ZXQuDQoNCg0KSGkgT2xnYSwNClRoYW5rcyBmb3Igd29ya2luZyB3aXRoIHVzIG9uIHRoaXMgaXNz
dWUuDQpJIHRoaW5rIHdlIG1pZ2h0IGhhdmUgZmlndXJlZCBvdXQgdGhlIGRpZmZlcmVuY2UuIDIu
Mi4yLjIgaXMgaW5hY2Nlc3NpYmxlDQpwdWJsaWMgaW50ZXJuZXQgYWRkcmVzcy4gRG9lcyB5b3Vy
IG5ldHdvcmsgaGF2ZSBhIHJvdXRlIHRvIHRoZSBpbnRlcm5ldD8NClRoYXQgc2FpZCwgZm9yIHRo
ZSBTWU4gdG8gYmUgc2VudCB0aGUgY2xpZW50J3MgbmV0d29yayBuZWVkcyB0byBoYXZlIGEgcm91
dGUNCnRvIHRoZSBzZXJ2ZXIncyBuZXR3b3JrLiBTbywgcGVyaGFwcyB5b3UgY2FuIHRyeSBhIHRl
c3Qgd2l0aCBhbiBJUCB0aGF0IHlvdQ0Ka25vdyB5b3VyIGNsaWVudCBuZXR3b3JrIGhhcyBhIHJv
dXRlIGZvciwgYnV0IGlzIGRvd24vdW5yZWFjaGFibGUuDQoNClAuUy4gV2UgZG8gc2VlIHRoYXQg
VHJvbmQgcHV0IG91dCBhIHBvc3NpYmxlIHBhdGNoIGZvciB0aGUgaXNzdWU6DQpodHRwczovL21h
cmMuaW5mby8/bD1saW51eC1uZnMmbT0xNjIzMjYzNTk4MTg0Njcmdz0yDQo=
