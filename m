Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B73A1794
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhFIOnP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 10:43:15 -0400
Received: from mail-dm6nam11on2118.outbound.protection.outlook.com ([40.107.223.118]:17281
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232850AbhFIOnP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Jun 2021 10:43:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXo1yAirm83enYexPW7lFp9eOviUnxy2LZhJWpE2x7UYD5lNpiD7OfZ5qZv4SQwcxcR1hkGXoxVgUmbS/GkMWhab8BHgxJa8Q8IFxGZ42i8ZX1Hr9i2Aq/eOuP5brMm3mZqGuh0O/tK51tbgW6a9ZMvdLCdCfnKZ7sTJaomOE/uFGdVdUpchiqqWMdbP2BHWCre+pmMeVG4OlCwqMEF2uFnsxjmr1pwivqIoEVAhR4D4o6CNy+umOxaJ7UUq9foVi+60hPGnXPlGl/le1BNz7cndv9vbvSE77fW9ofhExL441SvHDjM/kSkdemQtG3Kd5aqLfZirFLjZFJ5GMzE+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp9nsw0395dEIWoluuT8QCmBqqqXg0ismxXMUq2FiHo=;
 b=EbBMgAvbkG1o2UHNsVQkM5fOM4X895xD2cCo4IENeBxiV5ghXoxIg4WlMyCAzItEQHxS8HceZFcKLgVwgI7rcqPQkw91ICYjtvSGJyb5rRqEuZjuNw36MLmYHEttuQNqi3QWn4HmXH85tGPylu9H3i0NQsZVQRA9SLnPKu+QfhiQlX2BIOKLggePOWF8VAOt/5mmrzP5hbkRYjm1IyJ1lErpTjX8ScQZ7mFgPdkwSO7EPIwBEcFCTPXShPSEd3wC4+62znrBoO1E94iWIPPoirCgbPo+56UXaTm9qXJwqg2tqUnAB4gcs2tH4z+TE4lERuUGGy2Xyfxt1NscyRnSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp9nsw0395dEIWoluuT8QCmBqqqXg0ismxXMUq2FiHo=;
 b=bhKynPLtbsF8poY1UB7nUWBuIf+RxSckvB1ctUDBXbRupLco8gFmuh0si6bbPorNmBOoleR8Nf1HzKjalMGW/SfJoBCCI7DyfgdwwbrOlqZ9Ve4ymGAwyRr5i6CV3+cUdQ3SxcBgczUt1jROm+AA7kT2D96KnofLSkzpQRxfaHA=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB0986.namprd13.prod.outlook.com (2603:10b6:3:79::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.9; Wed, 9 Jun 2021 14:41:18 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.009; Wed, 9 Jun 2021
 14:41:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "mwakabayashi@vmware.com" <mwakabayashi@vmware.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgAGJKICAAaE+IIAAD42AgAAJxACAABE5gIAACV4AgBto8YCAAHPjgIAA35YAgACW/wCAAAK2AA==
Date:   Wed, 9 Jun 2021 14:41:18 +0000
Message-ID: <752114495b47624b022bb7de366c6b1771d0599a.camel@hammerspace.com>
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
         <FCDAEE4A-33CB-4939-8001-DAAFD7BC8638@redhat.com>
In-Reply-To: <FCDAEE4A-33CB-4939-8001-DAAFD7BC8638@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a9f893d-6e64-49dc-ddfa-08d92b54a436
x-ms-traffictypediagnostic: DM5PR13MB0986:
x-microsoft-antispam-prvs: <DM5PR13MB098684621BA219E71E098F42B8369@DM5PR13MB0986.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u9+6NCTyicZ7+YoXUdayjdI8mx3cB5OWZdZxNSuqJ2kEXnDk1jUGZzhMrmJ5jqQg6W/ZOEv/AwIi6wHtVuKuciIPpyu1zmTwEFtoFwm05FbbK50s4HSvCfoCdyJephzSwpi/cDY4lmhIfXxezgAcw8jW4WeDwXGTQ987LxxfYJKo/IsyuqwBJcX+BVyE+brpbe7PTIcbDP5btji8Km1Qkg9OxY1sehc+GUEjotLZWjMB35H5tibifbi5Z/LH6AsJu1/3yYaCpVN9qhaoRozJB621WmysbO7UIESXc1/rNQI3NAS8jdWb+AfisVY+JJ7H/dYUuiZeVWGq4m0+QFAmibkUL+rFQECREP48CtwuKMLprJX1jYyG54OCwbT0IJeqZDYCGUn9FyLIfBlOh21mf2Bqq7Ol+YEzncbRdlWMmdc9AFwyoVzCfWxGGHvBWoMO7j/GvDinbQOwHRVG/HdWs6MOAF/WriOyk7a/KbrTWneO9kpS+bl6/YJAiMh/Luah6xlzpQ5LysQvGyU8h4WWuDCmLgXTs+mIKhVhYWuyb5baHCHi8ElmpilVP3RpMmq6T8Qv2kvCgxcEd7CuQAbzxCYXooVxO6bwXafuKfVp8sHOTkIVAJshyeBjiCJnpx7OnneJ8ogmtxmhvqzDXrRE0Fc/xgNY3RY5rcJUggMvdfaT/X0hivZS8I3qzk625IyMbPVTJ2QXSlbRMNWgHkrYsZaHQWxUcVh4m0zQk2b/wK0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39830400003)(136003)(478600001)(8676002)(53546011)(54906003)(86362001)(6512007)(316002)(6506007)(76116006)(66446008)(66946007)(66476007)(66556008)(966005)(5660300002)(91956017)(186003)(8936002)(64756008)(26005)(71200400001)(122000001)(6486002)(38100700002)(83380400001)(36756003)(2906002)(2616005)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnJEQ0s3a1FFL2QwdWlsOWpGR2h1MzNJSy9RbU9pVmxPOGRZVFZ5TmoyeGoy?=
 =?utf-8?B?MmZ0dHlOQkhFRGMySGtBSlkrdjgxa2ZoaEVmWFNvWUNIM0kzT0RvbVYvUWRF?=
 =?utf-8?B?djI4YWszWWFZWWN6RzlLYm4xcWJhelptbzdMck9iemN5QzM5UlFWOWpac2NG?=
 =?utf-8?B?eGhFZVBPejA3Um9adGpWbWpYUlRQS1c2eTA4aDhBY1A3TGtzb1E3QnphUzlk?=
 =?utf-8?B?TnNUajdSYzUzRmhONk5na3VWNTk5b2QyNW1ZcGYrb0VadSttVGJwdWJRUVV1?=
 =?utf-8?B?R0RMbjN5UnNQZjUzVlFTREYyK3lWcUc5ak9CY1FPaklZL2JEZnNMMWRhb2Ur?=
 =?utf-8?B?bDlmYmJMY0lVWmlCam5MSUtwc0R4M2FsNzBEdEFJK1JxOTJDY0VXRjZubjVJ?=
 =?utf-8?B?TEhJcWpLR21oVnZjUERMR243ZVltTVNZNmh5SWI0LzFjL2ZWeWoyUldSN1Fv?=
 =?utf-8?B?WjZ6dHV2bWZiMjlOQ2ZxWXhsVzlPQ0I1aWtQeTBKQ0Irdk9DQjFDSWdHOGg5?=
 =?utf-8?B?OTVRUmhhRzRTbVFTOVRvdEhBajhmV3hRbG5vWHZYMENjaGZ4cGkyRHZaeEV6?=
 =?utf-8?B?RWVRK1NsdUZKalB1SGk0VFR5bnpkYlQyYlB1WDNSVzVQUHlqRzN1b2tzb204?=
 =?utf-8?B?WW1Zb2tKMlZZOVpWQVRRM1ZaZ1oxekJ1bVZwNHQvOWNJZUxLTEhJSFhSYk9w?=
 =?utf-8?B?MlE4YWFqMGtITm5WejBzVlo5R1R4RVI5RkducHZzc2JIVzErb0x5T3p3aFRy?=
 =?utf-8?B?SEpkQUdZSGxCdlJtdUhOaHRpYmgySXVMQllSeVVBZGc5YWhkY2xlZHI3QStk?=
 =?utf-8?B?OUhtVjA0STVLVjJoT2cyNWdiTVBsZGZMK0ZtdjZNUzVvb0hYVUR2Q0g4Z2Jx?=
 =?utf-8?B?aVF1cWNSUXc5RE9MZFZieHNSMW9yVVJpVFdWQjFlOVZOckZOVUFkL2NGbnBU?=
 =?utf-8?B?d0xFOVhXSkxBWmZTYkppTXlEMHNGTUNweTlCVzRFV000OGMvZTB5MktKVCth?=
 =?utf-8?B?S2hzbWY0b1JPQ0RZWGQwMHBOZmJLQzBUYmZPUzE4RUd4WSs5MmFsSHUrbEpQ?=
 =?utf-8?B?NkxIY3RzeDY5dGthei8rOTZwVktTT3JTbStWSk92NHlMekRwSEw1RmVYZzFr?=
 =?utf-8?B?R3VQb29Da2FWbU5iZks4TlNId3ZMelBZM0lQYnd3em5RNkNzTVhHZ2hUOTQ2?=
 =?utf-8?B?cXdQQWxnSVI5K3FLakFPR3FSUnFOOGYwdjRTVjlrWDNYSk5ZdlV1SmhQSjU2?=
 =?utf-8?B?UnZiYjM1ZWRSRm1FNmhiM1BPVXpqUkxFbTg5aldaSTY4NDNvYVZiaUtZdmlC?=
 =?utf-8?B?VmRPOHJodEdGRjNzejgzQ2JlLytVNjJsS1dzbmlvTFRBRko1d2JWOUlwVEZT?=
 =?utf-8?B?NWhBdzZuSnhlSHVzSlZzN0VIUlNMVHpiNWEya0QrOGM5Z09iZjFnWGFZN2RP?=
 =?utf-8?B?NDVyVEFvbzJHWWNZMStJdzB1c2IybkIxNkRrNmRDUVVzd3FBcld5TC82aE42?=
 =?utf-8?B?bzd1eVlsNlY5ODRYUEMrbGJGVkpuMnJsdUJoU0d6VkxRY1NnOVlwcHVqMS9y?=
 =?utf-8?B?MzF3V3cvWi9HZnFFU2ZGcEdvcVhlak9aUFZqZE9haGl4K1JnWTJMU3Jaekwx?=
 =?utf-8?B?THZWZDRXYllCUEVjUHhaeDJ4dk9Pd1cva3RPckZEV0VZZnl2Z1ppK3pwLzIr?=
 =?utf-8?B?SXI5V1JyOTFnMnM1R05VTG9GZmtvaXJVeDZOR0Q5WG96d0JtUEMwY0dZS0VO?=
 =?utf-8?Q?k7BbfxXygfUO6uRKaCsMYn9g1CHqqonO2R9imPz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B7254CF4280974EB63ADDB42F4948B9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9f893d-6e64-49dc-ddfa-08d92b54a436
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 14:41:18.0219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5Kwwl0EGb6lzzLYq9FISF5B3iAdbb2ob2oZA/OXWjv3DmpweQjpWukdfMbGRns542y5CdnQjBLX6Qh5XQGJxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0986
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTA5IGF0IDEwOjMxIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiANCj4gSXQncyBub3QgZGlzcHV0ZWQgdGhhdCBtb3VudHMgd2FpdGluZyBvbiB0aGUg
dHJhbnNwb3J0IGxheWVyIHdpbGwgYmxvY2sNCj4gb3RoZXIgbW91bnRzLg0KPiANCj4gSXQgbWln
aHQgYmUgYWJsZSB0byBiZSBjaGFuZ2VkOsKgIHRoZXJlJ3MgdGhpcyB0b3JjaDoNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbmZzLzg3Mzc4b21sZDQuZnNmQG5vdGFiZW5lLm5laWwu
YnJvd24ubmFtZS8NCj4gDQoNCk5vLg0KDQo+IC4ub3IgdGhlcmUgbWF5IGJlIGFub3RoZXIgd2F5
IHdlIGRvbid0IGhhdmUgdG8gd2FpdCAuLg0KPiANCg0KT0suIFNvIGxldCdzIGxvb2sgYXQgaG93
IHdlIGNhbiBzb2x2ZSB0aGUgcHJvYmxlbSBvZiB0aGUgaW5pdGlhbA0KY29ubmVjdGlvbiB0byB0
aGUgc2VydmVyIHRpbWluZyBvdXQgYW5kIGNhdXNpbmcgaGFuZ3MgaW4NCm5mczQxX3dhbGtfY2xp
ZW50X2xpc3QoKSwgYW5kIGxlYXZlIGFzaWRlIGFueSBvdGhlciBjb3JuZXIgY2FzZQ0KcHJvYmxl
bXMgKHN1Y2ggYXMgdGhlIHNlcnZlciBnb2luZyBkb3duIHdoaWxlIHdlJ3JlIG1vdW50aW5nKS4N
Cg0KSG93IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmcgKGNvbXBpbGUgdGVzdGVk
IG9ubHkpIHBhdGNoPw0KDQo4PC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tIDMwODMzZjc4YjViNGM3NzgwYzkxZjcwNWIwODY3ZWY1
NDkyYTllZWQgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBUcm9uZCBNeWtsZWJ1c3Qg
PHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQpEYXRlOiBXZWQsIDkgSnVuIDIwMjEg
MTA6MDQ6NDYgLTA0MDANClN1YmplY3Q6IFtQQVRDSF0gTkZTdjQ6IEluaXRpYWxpc2UgY29ubmVj
dGlvbiB0byB0aGUgc2VydmVyIGluDQogbmZzNF9hbGxvY19jbGllbnQoKQ0KDQpTZXQgdXAgdGhl
IGNvbm5lY3Rpb24gdG8gdGhlIE5GU3Y0IHNlcnZlciBpbiBuZnM0X2FsbG9jX2NsaWVudCgpLCBi
ZWZvcmUNCndlJ3ZlIGFkZGVkIHRoZSBzdHJ1Y3QgbmZzX2NsaWVudCB0byB0aGUgbmV0LW5hbWVz
cGFjZSdzIG5mc19jbGllbnRfbGlzdA0Kc28gdGhhdCBhIGRvd25lZCBzZXJ2ZXIgd29uJ3QgY2F1
c2Ugb3RoZXIgbW91bnRzIHRvIGhhbmcgaW4gdGhlIHRydW5raW5nDQpkZXRlY3Rpb24gY29kZS4N
Cg0KUmVwb3J0ZWQtYnk6IE1pY2hhZWwgV2FrYWJheWFzaGkgPG13YWthYmF5YXNoaUB2bXdhcmUu
Y29tPg0KRml4ZXM6IDVjNmU1YjYwYWFlNCAoIk5GUzogRml4IGFuIE9vcHMgaW4gdGhlIHBORlMg
ZmlsZXMgYW5kIGZsZXhmaWxlcyBjb25uZWN0aW9uIHNldHVwIHRvIHRoZSBEUyIpDQpTaWduZWQt
b2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+
DQotLS0NCiBmcy9uZnMvbmZzNGNsaWVudC5jIHwgODIgKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyks
IDQwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRjbGllbnQuYyBiL2Zz
L25mcy9uZnM0Y2xpZW50LmMNCmluZGV4IDQyNzE5Mzg0ZTI1Zi4uMjg0MzFhY2QxMjMwIDEwMDY0
NA0KLS0tIGEvZnMvbmZzL25mczRjbGllbnQuYw0KKysrIGIvZnMvbmZzL25mczRjbGllbnQuYw0K
QEAgLTE5Nyw4ICsxOTcsMTEgQEAgdm9pZCBuZnM0MF9zaHV0ZG93bl9jbGllbnQoc3RydWN0IG5m
c19jbGllbnQgKmNscCkNCiANCiBzdHJ1Y3QgbmZzX2NsaWVudCAqbmZzNF9hbGxvY19jbGllbnQo
Y29uc3Qgc3RydWN0IG5mc19jbGllbnRfaW5pdGRhdGEgKmNsX2luaXQpDQogew0KLQlpbnQgZXJy
Ow0KKwljaGFyIGJ1ZltJTkVUNl9BRERSU1RSTEVOICsgMV07DQorCWNvbnN0IGNoYXIgKmlwX2Fk
ZHIgPSBjbF9pbml0LT5pcF9hZGRyOw0KIAlzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwID0gbmZzX2Fs
bG9jX2NsaWVudChjbF9pbml0KTsNCisJaW50IGVycjsNCisNCiAJaWYgKElTX0VSUihjbHApKQ0K
IAkJcmV0dXJuIGNscDsNCiANCkBAIC0yMjIsNiArMjI1LDQ0IEBAIHN0cnVjdCBuZnNfY2xpZW50
ICpuZnM0X2FsbG9jX2NsaWVudChjb25zdCBzdHJ1Y3QgbmZzX2NsaWVudF9pbml0ZGF0YSAqY2xf
aW5pdCkNCiAJaW5pdF93YWl0cXVldWVfaGVhZCgmY2xwLT5jbF9sb2NrX3dhaXRxKTsNCiAjZW5k
aWYNCiAJSU5JVF9MSVNUX0hFQUQoJmNscC0+cGVuZGluZ19jYl9zdGF0ZWlkcyk7DQorDQorCWlm
IChjbF9pbml0LT5taW5vcnZlcnNpb24gIT0gMCkNCisJCV9fc2V0X2JpdChORlNfQ1NfSU5GSU5J
VEVfU0xPVFMsICZjbHAtPmNsX2ZsYWdzKTsNCisJX19zZXRfYml0KE5GU19DU19ESVNDUlRSWSwg
JmNscC0+Y2xfZmxhZ3MpOw0KKwlfX3NldF9iaXQoTkZTX0NTX05PX1JFVFJBTlNfVElNRU9VVCwg
JmNscC0+Y2xfZmxhZ3MpOw0KKw0KKwkvKg0KKwkgKiBTZXQgdXAgdGhlIGNvbm5lY3Rpb24gdG8g
dGhlIHNlcnZlciBiZWZvcmUgd2UgYWRkIGFkZCB0byB0aGUNCisJICogZ2xvYmFsIGxpc3QuDQor
CSAqLw0KKwllcnIgPSBuZnNfY3JlYXRlX3JwY19jbGllbnQoY2xwLCBjbF9pbml0LCBSUENfQVVU
SF9HU1NfS1JCNUkpOw0KKwlpZiAoZXJyID09IC1FSU5WQUwpDQorCQllcnIgPSBuZnNfY3JlYXRl
X3JwY19jbGllbnQoY2xwLCBjbF9pbml0LCBSUENfQVVUSF9VTklYKTsNCisJaWYgKGVyciA8IDAp
DQorCQlnb3RvIGVycm9yOw0KKw0KKwkvKiBJZiBubyBjbGllbnRhZGRyPSBvcHRpb24gd2FzIHNw
ZWNpZmllZCwgZmluZCBhIHVzYWJsZSBjYiBhZGRyZXNzICovDQorCWlmIChpcF9hZGRyID09IE5V
TEwpIHsNCisJCXN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlIGNiX2FkZHI7DQorCQlzdHJ1Y3Qgc29j
a2FkZHIgKnNhcCA9IChzdHJ1Y3Qgc29ja2FkZHIgKikmY2JfYWRkcjsNCisNCisJCWVyciA9IHJw
Y19sb2NhbGFkZHIoY2xwLT5jbF9ycGNjbGllbnQsIHNhcCwgc2l6ZW9mKGNiX2FkZHIpKTsNCisJ
CWlmIChlcnIgPCAwKQ0KKwkJCWdvdG8gZXJyb3I7DQorCQllcnIgPSBycGNfbnRvcChzYXAsIGJ1
Ziwgc2l6ZW9mKGJ1ZikpOw0KKwkJaWYgKGVyciA8IDApDQorCQkJZ290byBlcnJvcjsNCisJCWlw
X2FkZHIgPSAoY29uc3QgY2hhciAqKWJ1ZjsNCisJfQ0KKwlzdHJsY3B5KGNscC0+Y2xfaXBhZGRy
LCBpcF9hZGRyLCBzaXplb2YoY2xwLT5jbF9pcGFkZHIpKTsNCisNCisJZXJyID0gbmZzX2lkbWFw
X25ldyhjbHApOw0KKwlpZiAoZXJyIDwgMCkgew0KKwkJZHByaW50aygiJXM6IGZhaWxlZCB0byBj
cmVhdGUgaWRtYXBwZXIuIEVycm9yID0gJWRcbiIsDQorCQkJX19mdW5jX18sIGVycik7DQorCQln
b3RvIGVycm9yOw0KKwl9DQorCV9fc2V0X2JpdChORlNfQ1NfSURNQVAsICZjbHAtPmNsX3Jlc19z
dGF0ZSk7DQogCXJldHVybiBjbHA7DQogDQogZXJyb3I6DQpAQCAtMzcyLDggKzQxMyw2IEBAIHN0
YXRpYyBpbnQgbmZzNF9pbml0X2NsaWVudF9taW5vcl92ZXJzaW9uKHN0cnVjdCBuZnNfY2xpZW50
ICpjbHApDQogc3RydWN0IG5mc19jbGllbnQgKm5mczRfaW5pdF9jbGllbnQoc3RydWN0IG5mc19j
bGllbnQgKmNscCwNCiAJCQkJICAgIGNvbnN0IHN0cnVjdCBuZnNfY2xpZW50X2luaXRkYXRhICpj
bF9pbml0KQ0KIHsNCi0JY2hhciBidWZbSU5FVDZfQUREUlNUUkxFTiArIDFdOw0KLQljb25zdCBj
aGFyICppcF9hZGRyID0gY2xfaW5pdC0+aXBfYWRkcjsNCiAJc3RydWN0IG5mc19jbGllbnQgKm9s
ZDsNCiAJaW50IGVycm9yOw0KIA0KQEAgLTM4MSw0MyArNDIwLDYgQEAgc3RydWN0IG5mc19jbGll
bnQgKm5mczRfaW5pdF9jbGllbnQoc3RydWN0IG5mc19jbGllbnQgKmNscCwNCiAJCS8qIHRoZSBj
bGllbnQgaXMgaW5pdGlhbGlzZWQgYWxyZWFkeSAqLw0KIAkJcmV0dXJuIGNscDsNCiANCi0JLyog
Q2hlY2sgTkZTIHByb3RvY29sIHJldmlzaW9uIGFuZCBpbml0aWFsaXplIFJQQyBvcCB2ZWN0b3Ig
Ki8NCi0JY2xwLT5ycGNfb3BzID0gJm5mc192NF9jbGllbnRvcHM7DQotDQotCWlmIChjbHAtPmNs
X21pbm9ydmVyc2lvbiAhPSAwKQ0KLQkJX19zZXRfYml0KE5GU19DU19JTkZJTklURV9TTE9UUywg
JmNscC0+Y2xfZmxhZ3MpOw0KLQlfX3NldF9iaXQoTkZTX0NTX0RJU0NSVFJZLCAmY2xwLT5jbF9m
bGFncyk7DQotCV9fc2V0X2JpdChORlNfQ1NfTk9fUkVUUkFOU19USU1FT1VULCAmY2xwLT5jbF9m
bGFncyk7DQotDQotCWVycm9yID0gbmZzX2NyZWF0ZV9ycGNfY2xpZW50KGNscCwgY2xfaW5pdCwg
UlBDX0FVVEhfR1NTX0tSQjVJKTsNCi0JaWYgKGVycm9yID09IC1FSU5WQUwpDQotCQllcnJvciA9
IG5mc19jcmVhdGVfcnBjX2NsaWVudChjbHAsIGNsX2luaXQsIFJQQ19BVVRIX1VOSVgpOw0KLQlp
ZiAoZXJyb3IgPCAwKQ0KLQkJZ290byBlcnJvcjsNCi0NCi0JLyogSWYgbm8gY2xpZW50YWRkcj0g
b3B0aW9uIHdhcyBzcGVjaWZpZWQsIGZpbmQgYSB1c2FibGUgY2IgYWRkcmVzcyAqLw0KLQlpZiAo
aXBfYWRkciA9PSBOVUxMKSB7DQotCQlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBjYl9hZGRyOw0K
LQkJc3RydWN0IHNvY2thZGRyICpzYXAgPSAoc3RydWN0IHNvY2thZGRyICopJmNiX2FkZHI7DQot
DQotCQllcnJvciA9IHJwY19sb2NhbGFkZHIoY2xwLT5jbF9ycGNjbGllbnQsIHNhcCwgc2l6ZW9m
KGNiX2FkZHIpKTsNCi0JCWlmIChlcnJvciA8IDApDQotCQkJZ290byBlcnJvcjsNCi0JCWVycm9y
ID0gcnBjX250b3Aoc2FwLCBidWYsIHNpemVvZihidWYpKTsNCi0JCWlmIChlcnJvciA8IDApDQot
CQkJZ290byBlcnJvcjsNCi0JCWlwX2FkZHIgPSAoY29uc3QgY2hhciAqKWJ1ZjsNCi0JfQ0KLQlz
dHJsY3B5KGNscC0+Y2xfaXBhZGRyLCBpcF9hZGRyLCBzaXplb2YoY2xwLT5jbF9pcGFkZHIpKTsN
Ci0NCi0JZXJyb3IgPSBuZnNfaWRtYXBfbmV3KGNscCk7DQotCWlmIChlcnJvciA8IDApIHsNCi0J
CWRwcmludGsoIiVzOiBmYWlsZWQgdG8gY3JlYXRlIGlkbWFwcGVyLiBFcnJvciA9ICVkXG4iLA0K
LQkJCV9fZnVuY19fLCBlcnJvcik7DQotCQlnb3RvIGVycm9yOw0KLQl9DQotCV9fc2V0X2JpdChO
RlNfQ1NfSURNQVAsICZjbHAtPmNsX3Jlc19zdGF0ZSk7DQotDQogCWVycm9yID0gbmZzNF9pbml0
X2NsaWVudF9taW5vcl92ZXJzaW9uKGNscCk7DQogCWlmIChlcnJvciA8IDApDQogCQlnb3RvIGVy
cm9yOw0KLS0gDQoyLjMxLjENCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
