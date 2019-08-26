Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBE9D9E5
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 01:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfHZX23 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 19:28:29 -0400
Received: from smtppost.atos.net ([193.56.114.176]:22258 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfHZX23 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 19:28:29 -0400
Received: from mail2-ext.my-it-solutions.net (mail2-ext.my-it-solutions.net) by smarthost3.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 4e32_9550_2168e048_2739_4706_8909_166f550daa28;
        Tue, 27 Aug 2019 01:28:26 +0200
Received: from mail1-int.my-it-solutions.net ([10.92.32.11])
        by mail2-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x7QNSQIp016356
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 27 Aug 2019 01:28:26 +0200
Received: from DEERLM99ETTMSX.ww931.my-it-solutions.net ([10.86.142.105])
        by mail1-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x7QNSQVf011048
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Tue, 27 Aug 2019 01:28:26 +0200
Received: from DEERLM99ETSMSX.ww931.my-it-solutions.net (10.86.142.104) by
 DEERLM99ETTMSX.ww931.my-it-solutions.net (10.86.142.105) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Tue, 27 Aug 2019 01:28:25 +0200
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.104) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Tue, 27 Aug 2019 01:28:24 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/MBCsL0Hdm+8cEvCzXD5/9J+cnAvGNOYVRL2IRovdQ3s+i3zbKlHTE4I7Tv6u8Yb/LgKIuedrRwaMrKSgOyaW/vxjJkMnnHXLSomO6pkCTLISpqqgZGDl0OtxUFK7CwpSBozkzJSxQAsyr4m/iOBk9kklm0E9c/wj5UXMoD26kSoqafn1929aUutFSqfBzr2gxg+PxfH7UrfxLNXN6kVxDGqYVlES5SwmFWCtzqR9KlBCn3s02s2NqbJtRYO5ghGnzh4XbRD8qod8PKcjvijmgBsy0Ta7IEUD0NFTU9EP2KZ3MEIrGSozLE90RVbvf6XFPyBhQ9sInlIeVClWg6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiV9RLW+8xwQaPCyCyacWW9xeD0rsTGFQtsM2K2WKQs=;
 b=fct6W4EtM/t5Oq876pTO63BmdBKqt43JjGltNyoapI8v/HiULXa4A8hbAaBYQCSLCRfXnD+tH6Ag+pH0zDTS3DWcJJ6/rzh4PJllbSC9Lra+pJqbZiyKK+cNJYGodCjTxmnD/mhRRdAS3C9uXuj5WnfBv8qhLNWEN2mHkI3mIKhztN0kyC31yk2J+Srs0M+3Z1TpJh2v06FLYX8a6eulwQ7IcjztiB7oXCBeTpngpJPSKt/AnEXUKULg8zI+ql2HjqwQ8Fts7njM5FDKFBulpiq9MRRPs1Cs4RoH7AjZHgT21ovq84NSi17pSA7Bec08OzYbDK/lqkD/+mThwVrjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com (10.173.88.135) by
 AM5PR0202MB2595.eurprd02.prod.outlook.com (10.173.89.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 26 Aug 2019 23:28:21 +0000
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::411:ed7c:ed00:7bea]) by AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::411:ed7c:ed00:7bea%12]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 23:28:21 +0000
From:   "de Vandiere, Louis" <louis.devandiere@atos.net>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Maximum Number of ACL on NFSv4
Thread-Topic: Maximum Number of ACL on NFSv4
Thread-Index: AdVZ/zHAXlVbOFcuRg6ALmyIfYKMtQAAvtpwAISMAoAAAgBdYAAEV7cAAADj6cAABNvhgAAIJ0pw
Date:   Mon, 26 Aug 2019 23:28:21 +0000
Message-ID: <AM5PR0202MB2564D07CBF6B765EDABAAAB1E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
References: <AM5PR0202MB25641230B578F7D080A67BA4E7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <AM5PR0202MB2564E6F05627D0EF49D043DFE7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu>
 <AM5PR0202MB25644F1290D20A1996C5EED4E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <20190826164600.GD28580@ndevos-x270>
 <AM5PR0202MB2564874D2AD5845AE3CD13DAE7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <CAN-5tyHjQfrFU_iGXKSDSLnR6ywXizAqtU=5et1ESgKLCgHkAA@mail.gmail.com>
In-Reply-To: <CAN-5tyHjQfrFU_iGXKSDSLnR6ywXizAqtU=5et1ESgKLCgHkAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=louis.devandiere@atos.net; 
x-originating-ip: [70.122.228.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60f72241-156b-4c59-29bc-08d72a7d1541
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0202MB2595;
x-ms-traffictypediagnostic: AM5PR0202MB2595:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM5PR0202MB2595B3FED020B8C74798A5FCE7A10@AM5PR0202MB2595.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(40764003)(42274003)(13464003)(199004)(189003)(26005)(5640700003)(8676002)(316002)(2906002)(25786009)(14444005)(256004)(74316002)(305945005)(7736002)(6116002)(3846002)(6246003)(86362001)(71190400001)(71200400001)(486006)(45080400002)(446003)(966005)(66066001)(476003)(99286004)(11346002)(14454004)(102836004)(53546011)(52536014)(66556008)(64756008)(66476007)(6436002)(229853002)(478600001)(33656002)(76116006)(6306002)(9686003)(2351001)(8936002)(53936002)(76176011)(2501003)(5660300002)(6916009)(7696005)(186003)(55016002)(6506007)(81156014)(66946007)(66574012)(66446008)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0202MB2595;H:AM5PR0202MB2564.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tstVE+HVEXTxofwCjhOrJsV2K7sAOjYGCJqKEUQVrAMZU+TVv/uM9hX/5axqIYTR1d/YWdO/cnq6sUCxselGKBpVgxZNPzt3bsRzo8F0zVGryBXJ9o0xdnunJZl1vYno0ItdKs8JOLSRvOGttGeyCaFbY9hmf/nvCm6RJVVGyV+hVFdv90SK0ILJa7cdA1R6JjgnivvzdqXPFvQdfDBDIIHPaEZQf5OraCkoHN9njscT5xdZPmNDsyQFoy3xaE3JV4WUN6xiRnjuk8h9QLeX7GIXDfy+uJxtXlYTLIjpivluaQpyd7f+aEjKuYWblx+H1shSaKLrj/bwO4FuEG3Lp3f92XUtSp74f5Nao1vNZFfDDm0Khns/hQSXBwZCQQnCNInOJkpn6QJZ9VxmRX6JRqgDNbiVUUP8Bh6kOxGTsHc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f72241-156b-4c59-29bc-08d72a7d1541
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 23:28:21.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZbKBNK5qDSAALb9AmchgmSEu2g+nEwNHaCd7sznwzwedKlOse98SM79lcLWawrqhLsSJzsdT1Pb4X2kkwx7HLLzVSWOBNc0BkTI0vqo+wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0202MB2595
X-OriginatorOrg: atos.net
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

VGhhbmsgeW91IE9sZ2EhIFNvbWVob3csIEkgZmFpbGVkIHRvIGxvb2sgaW50byB0aGlzIGZpbGUg
YWx0aG91Z2ggSSBsb29rZWQgaW4gZnMvbmZzLyB3aXRob3V0IHN1Y2Nlc3MgYW5kIEkgdW5kZXJz
dGFuZCB3aHkgbm93Lg0KDQpJJ2QgbGlrZSB0byBzZWUgaXQgaW5jcmVhc2VkIGFuZCBiZSBzY2Fs
YWJsZSBsaWtlIFhGUyBpcywgYnV0IEkgdW5kZXJzdGFuZCBpdCBtaWdodCBpbXBhY3QgbXVsdGlw
bGUgbGlicmFyaWVzLiBTaG91bGQgSSBvcGVuIGEgYnVnL2ZlYXR1cmUgcmVxdWVzdCBzb21ld2hl
cmU/DQoNCkJlc3QsDQpMb3VpcyBkZSBWYW5kacOocmUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxhZ2xvQHVtaWNoLmVkdT4gDQpTZW50OiBN
b25kYXksIEF1Z3VzdCAyNiwgMjAxOSAyOjMxIFBNDQpUbzogZGUgVmFuZGllcmUsIExvdWlzIDxs
b3Vpcy5kZXZhbmRpZXJlQGF0b3MubmV0Pg0KQ2M6IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmcN
ClN1YmplY3Q6IFJlOiBNYXhpbXVtIE51bWJlciBvZiBBQ0wgb24gTkZTdjQNCg0KRnJvbSBmcy9u
ZnNkL2FjbC5oDQovKg0KICogTWF4aW11bSBBQ0wgd2UnbGwgYWNjZXB0IGZyb20gYSBjbGllbnQ7
IGNob3NlbiAoc29tZXdoYXQNCiAqIGFyYml0cmFyaWx5KSBzbyB0aGF0IGttYWxsb2MnaW5nIHRo
ZSBBQ0wgc2hvdWxkbid0IHJlcXVpcmUgYQ0KICogaGlnaC1vcmRlciBhbGxvY2F0aW9uLiAgVGhp
cyBhbGxvd3MgMjA0IEFDRXMgb24geDg2XzY0Og0KICovDQojZGVmaW5lIE5GUzRfQUNMX01BWCAo
KFBBR0VfU0laRSAtIHNpemVvZihzdHJ1Y3QgbmZzNF9hY2wpKSBcDQogICAgICAgICAgICAgICAg
ICAgICAgICAvIHNpemVvZihzdHJ1Y3QgbmZzNF9hY2UpKQ0KDQpJIGRvbid0IGtub3cgaG93IEJy
dWNlIGZlZWxzIGFib3V0IGluY3JlYXNpbmcgdGhhdCBsaW1pdC4gUGVyaGFwcyBoZSdkIGJlIG9w
ZW5lZCB0byBhIHBhdGNoIHRoYXQgaW5jcmVhc2VzIHRoYXQuDQoNCk9uIE1vbiwgQXVnIDI2LCAy
MDE5IGF0IDI6MzAgUE0gZGUgVmFuZGllcmUsIExvdWlzIDxsb3Vpcy5kZXZhbmRpZXJlQGF0b3Mu
bmV0PiB3cm90ZToNCj4NCj4gVGhhbmtzIE5pZWxzLCBJIHRyaWVkIHlvdXIgc3VnZ2VzdGlvbi4g
QWNjb3JkaW5nIHRvIHRoZSBkb2N1bWVudGF0aW9uIChodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaW51eC5kaWUubmV0JTJG
bWFuJTJGOCUyRm1rZnMueGZzJmFtcDtkYXRhPTAyJTdDMDElN0Nsb3Vpcy5kZXZhbmRpZXJlJTQw
YXRvcy5uZXQlN0NlMTg1Zjk5Y2IzYWQ0NzZmZDM5MzA4ZDcyYTViZjZkNSU3QzMzNDQwZmM2Yjdj
NzQxMmNiYjczMGU3MGIwMTk4ZDVhJTdDMCU3QzAlN0M2MzcwMjQ0NDY3ODUzMjQ5NzMmYW1wO3Nk
YXRhPUhaYm5WU3pUS0tDWHBFdjVKTGdaS2VFZ1F4NUJQS2VFczRTWVpxUmhoYmslM0QmYW1wO3Jl
c2VydmVkPTApLCB0aGUgbWF4aW11bSBzaXplIGZvciB0aGUgaW5vZGUgaXMgMjA0OCBieXRlLiBT
byBJIHNldCBpdCB0byB0aGlzIHZhbHVlLCBhbmQgZmFjZWQgdGhlIGV4YWN0IHNhbWUgbGltaXRh
dGlvbi4gT24gdGhlIG90aGVyIGhhbmQsIHdoZW4gSSB1c2VkIHNldGZhY2wgLW0gb24gdGhlIFhG
UyBtb3VudGVkIGRpc2ssIEkgZGlkIG5vdCBmYWNlIGFueSBsaW1pdGF0aW9uIGFuZCBJIHdhcyBh
YmxlIHRvIHNldCB0aG91c2FuZHMgb2YgQUNMcyBvbiBhIHNpbmdsZSBmaWxlLg0KPg0KPiBXaGVu
IEkgZG8gYSBzdHJhY2UsIEkgc2VlIHR3byBkaWZmZXJlbnQgdHlwZXMgb2YgQUNMIHVzZWQgd2hl
biB0aGUgc3lzdGVtIGNhbGxzIHNldHhhdHRyOiBzeXN0ZW0ucG9zaXhfYWNsX2RlZmF1bHQgYW5k
IHN5c3RlbS5uZnN2NF9hY2wuIEkgdHJpZWQgdG8gbG9vayBmb3IgaGFyZGNvZGVkIGxpbWl0cyBh
c3NvY2lhdGVkIHdpdGggc3lzdGVtLm5mc3Y0X2FjbCBidXQgSSBkb24ndCBoYXZlIG11Y2ggZXhw
ZXJpZW5jZSB3aXRoIEMgYW5kIGxpbnV4IGtlcm5lbC4NCj4NCj4gVGhhbmsgeW91IGZvciB5b3Vy
IGhlbHAuDQo+IEJlc3QsDQo+IExvdWlzIGRlIFZhbmRpw6hyZQ0KPg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWVscyBkZSBWb3MgPG5kZXZvc0ByZWRoYXQuY29tPg0K
PiBTZW50OiBNb25kYXksIEF1Z3VzdCAyNiwgMjAxOSAxMTo0NiBBTQ0KPiBUbzogZGUgVmFuZGll
cmUsIExvdWlzIDxsb3Vpcy5kZXZhbmRpZXJlQGF0b3MubmV0Pg0KPiBDYzogbGludXgtbmZzQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogTWF4aW11bSBOdW1iZXIgb2YgQUNMIG9uIE5G
U3Y0DQo+DQo+IE9uIE1vbiwgQXVnIDI2LCAyMDE5IGF0IDAyOjUzOjA1UE0gKzAwMDAsIGRlIFZh
bmRpZXJlLCBMb3VpcyB3cm90ZToNCj4gPiBZZXMsIEkgYXNzdW1lIGl0J3Mgbm90IHZlcnkgZnJl
cXVlbnQgdG8gaGF2ZSBodW5kcmVkcyBvZiBORlN2NCBBQ0xzLiBGb3IgY29tcGxpYW5jZSBhbmQg
b3JnYW5pemF0aW9uYWwgaXNzdWUsIHdlIGNhbm5vdCB1c2UgZ3JvdXBzIGVmZmljaWVudGx5IHRv
IG1hbmFnZSBhY2Nlc3MgdG8gdGhlIHNoYXJlcywgc28gaXQncyB1c2VyLWJhc2VkIGFuZCBjYXNl
IGJ5IGNhc2UuDQo+ID4NCj4gPiBNeSByZWFsIGdvYWwgaXMgdG8gYmUgYWJsZSB0byByZXBsaWNh
dGUgc29tZSBmaWxlcyB0byBhIG5ldyBORlN2NCBzZXJ2ZXIgd2hpbGUgcHJlc2VydmluZyB0aGUg
QUNMcy4gQnkgdXNpbmcgImNwIC1SIC0tcHJlc2VydmU9YWxsIGFjbC1mb2xkZXIvIiwgSSdtIGFi
bGUgdG8gcHJlc2VydmUgdGhlIEFDTHMgd2hlbiB0aGVpciBudW1iZXIgZG9lcyBub3QgZXhjZWVk
IDIwMCwgYWJvdmUgaXQsIEkgc2VlIHRoZSAiRmlsZSB0b28gbGFyZ2UiIGVycm9yIHdoaWxlIHJz
eW5jIGRvZXMgbm90IHdvcmsgYXQgYWxsIChldmVuIGluIHZlcnNpb24gMy4xLjMpLiBUaGF0J3Mg
d2h5IEknbSBkaWdnaW5nIGludG8gdGhpcyBhbmQgY2hlY2tpbmcgd2hhdCBwb3NzaWJseSBjb3Vs
ZCBnbyB3cm9uZy4NCj4NCj4gWW91IG1pZ2h0IGJlIGhpdHRpbmcgYSBsaW1pdCBpbiB0aGUgZmls
ZXN5c3RlbSBvbiB0aGUgTkZTIHNlcnZlci4gVGhlIA0KPiBBQ0xzIGFyZSBzdG9yZWQgaW4gZXh0
ZW5kZWQgYXR0cmlidXRlcy4gRGVwZW5kaW5nIG9uIHRoZSBmaWxlc3lzdGVtLCANCj4geW91IG1h
eSBiZSBhYmxlIHRvIGNvbmZpZ3VyZSBsYXJnZXIgaW5vZGUgc2l6ZXMgKG9yIG90aGVyIHN0b3Jh
Z2UgZm9yIA0KPiB4YXR0cnMpLiBXaXRoIFhGUyB0aGlzIGNhbiBiZSBkb25lIHdpdGggJ21rZnMg
LXQgeGZzIC1pIHNpemU9Li4gLi4uJywNCj4NCj4gSFRILA0KPiBOaWVscw0KPg0KPg0KPiA+DQo+
ID4gVGhhbmsgeW91Lg0KPiA+IEJlc3QsDQo+ID4gTG91aXMgZGUgVmFuZGnDqHJlDQo+ID4NCj4g
Pg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogR29ldHosIFBhdHJp
Y2sgRyA8cGdvZXR6QG1hdGgudXRleGFzLmVkdT4NCj4gPiBTZW50OiBNb25kYXksIEF1Z3VzdCAy
NiwgMjAxOSA4OjQ0IEFNDQo+ID4gVG86IGRlIFZhbmRpZXJlLCBMb3VpcyA8bG91aXMuZGV2YW5k
aWVyZUBhdG9zLm5ldD47IA0KPiA+IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJq
ZWN0OiBSZTogTWF4aW11bSBOdW1iZXIgb2YgQUNMIG9uIE5GU3Y0DQo+ID4NCj4gPiBJJ20gZHlp
bmcgdG8ga25vdyB3aGF0IHRoZSB1c2UgY2FzZSBpcyBmb3IgdGhpcywgYW5kIHdoeSB5b3UgY2Fu
J3QganVzdCBkbyB0aGlzIHdpdGggZ3JvdXAgcGVybWlzc2lvbnMgKHVubGVzcyB5b3UncmUgdGFs
a2luZyBhYm91dCBodW5kcmVkcyBvZiBncm91cCBBQ0xzKS4NCj4gPg0KPiA+IE9uIDgvMjMvMTkg
NTozMSBQTSwgZGUgVmFuZGllcmUsIExvdWlzIHdyb3RlOg0KPiA+ID4gSGksDQo+ID4gPg0KPiA+
ID4gSSdtIGN1cnJlbnRseSB0cnlpbmcgdG8gYXBwbHkgaHVuZHJlZHMgb2YgQUNMcyBvbiBmaWxl
IGhvc3RlZCBvbiBhIE5GU3Y0IHNlcnZlciAobmZzLXV0aWxzLTEuMy4wLTAuNjEuZWw3Lng4Nl82
NCBhbmQgbmZzNC1hY2wtdG9vbHMuMC4zLjMtMTkuZWw3Lng4Nl82NCkuIEl0IGFwcGVhcnMgdGhh
dCB0aGUgbGltaXQgSSBjYW4gYXBwbHkgaXMgMjA3LiBBZnRlciB0aGUgbGltaXQgaXMgcmVhY2hl
ZCwgdGhlIGNvbW1hbmQgIm5mczRfc2V0ZmFjbCAtYSIgcmV0dXJuZWQgdGhlIGVycm9yICJGYWls
ZWQgc2V0eGF0dHIgb3BlcmF0aW9uOiBGaWxlIHRvbyBsYXJnZSIuIFRoZSBzYW1lIHByb2JsZW0g
aGFwcGVucyBpZiBJIHVzZSBhbiBBQ0wgd2l0aCBtb3JlIHRoYW4gMjAwIGxpbmUgaW4gaXQuIEkg
ZGlkIGEgbGl0dGxlIGRlYnVnZ2luZyBzZXNzaW9uIGJ1dCBJIHdhcyBub3QgYWJsZSB0byBjb21l
IHVwIHdpdGggYW4gZXhwbGFuYXRpb24gb24gd2h5IEknbSBmYWNpbmcgc3VjaCBhbiBpc3N1ZS4N
Cj4gPiA+DQo+ID4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgSSBjYW4gYXBwbHkgaHVuZHJlZHMgb2Yg
QUNMcyBvbiBYRlMgd2l0aG91dCBpc3N1ZS4gRG8geW91IGtub3cgaWYgaXQgY291bGQgYmUgYSBi
dWcgd2l0aCB0aGUgbmZzNC1hY2wtdG9vbHMgcGFja2FnZT8NCj4gPiA+IFRoYW5rIHlvdSBmb3Ig
eW91ciBzdXBwb3J0Lg0KPiA+ID4gQmVzdCwNCj4gPiA+IExvdWlzIGRlIFZhbmRpw6hyZQ0KPiA+
ID4+PiBUaGlzIG1lc3NhZ2UgaXMgZnJvbSBhbiBleHRlcm5hbCBzZW5kZXIuIExlYXJuIG1vcmUg
YWJvdXQgd2h5IHRoaXMgPDwNCj4gPiA+Pj4gbWF0dGVycyBhdCBodHRwczovL2V1cjAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaW5rcy51dGV4
YXMuZWR1JTJGcnR5Y2xmJmFtcDtkYXRhPTAyJTdDMDElN0Nsb3Vpcy5kZXZhbmRpZXJlJTQwYXRv
cy5uZXQlN0NlMTg1Zjk5Y2IzYWQ0NzZmZDM5MzA4ZDcyYTViZjZkNSU3QzMzNDQwZmM2YjdjNzQx
MmNiYjczMGU3MGIwMTk4ZDVhJTdDMCU3QzAlN0M2MzcwMjQ0NDY3ODUzMjQ5NzMmYW1wO3NkYXRh
PXIzNDVycVdONEdLVDBtQm1RbU1UbmFDJTJGRkV5VVRpZGpCbEdlQU1SZEVwQSUzRCZhbXA7cmVz
ZXJ2ZWQ9MC4gICAgICAgICAgICAgICAgICAgICAgICA8PA0KPiA+ID4NCg==
