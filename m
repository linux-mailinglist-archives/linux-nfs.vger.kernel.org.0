Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E549818973
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2019 14:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfEIMGr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 May 2019 08:06:47 -0400
Received: from mail-eopbgr780074.outbound.protection.outlook.com ([40.107.78.74]:11971
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfEIMGr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 9 May 2019 08:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTHMGWqmXf80FrNEJ0ydieuBMw7n0HSkV4F2NoGkBAU=;
 b=mNMmIXpEthHa+I6PZ8iDh2SDuvZp/i+CV3cGRymV/LFZt82LkvuWi+9n8uIo9UBn4xZcwO2jb4Tjj4GnlMRtTVUFvOtdCaVffAZHLEhDA7Z/zWyaajAHqD1czj+2maDaCPFJNvghXkegJQxUdaBL3gSQFWkUpTB/r2Pr1/f/47k=
Received: from BN8PR06MB6228.namprd06.prod.outlook.com (20.178.217.156) by
 BN8PR06MB6164.namprd06.prod.outlook.com (20.178.213.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 12:06:44 +0000
Received: from BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::7d92:449d:f9a5:fee2]) by BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::7d92:449d:f9a5:fee2%3]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 12:06:44 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com" 
        <syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "rbergant@redhat.com" <rbergant@redhat.com>
Subject: Re: WARNING: locking bug in nfs_get_client
Thread-Topic: WARNING: locking bug in nfs_get_client
Thread-Index: AQHVBfyRNa/IsYWUv0STpJf4EP3ppqZin14AgAAL7ACAAAgRgA==
Date:   Thu, 9 May 2019 12:06:44 +0000
Message-ID: <f8351c27150e652dbc1daa94b5afe9ad9588d6db.camel@netapp.com>
References: <000000000000c3e9dc0588695e22@google.com>
         <C6C33F7F-8CD2-4E0F-82BA-5443133FBB54@redhat.com>
         <FE8462BD-2B07-4AC1-A739-E3D429DDA134@redhat.com>
In-Reply-To: <FE8462BD-2B07-4AC1-A739-E3D429DDA134@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [23.28.75.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91113371-3073-4079-72ee-08d6d476cdf5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN8PR06MB6164;
x-ms-traffictypediagnostic: BN8PR06MB6164:
x-microsoft-antispam-prvs: <BN8PR06MB61644AABD6BC14F978615EBDF8330@BN8PR06MB6164.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39860400002)(189003)(199004)(8936002)(6436002)(66446008)(64756008)(66556008)(66476007)(14454004)(66946007)(7736002)(91956017)(76116006)(73956011)(6486002)(256004)(5660300002)(66066001)(26005)(6512007)(6506007)(476003)(446003)(54906003)(2616005)(53546011)(25786009)(5024004)(14444005)(11346002)(81166006)(1730700003)(81156014)(305945005)(186003)(8676002)(102836004)(2906002)(86362001)(2501003)(36756003)(3846002)(4326008)(76176011)(58126008)(5640700003)(6116002)(478600001)(6916009)(99286004)(71190400001)(68736007)(316002)(118296001)(71200400001)(72206003)(6246003)(486006)(53936002)(2351001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB6164;H:BN8PR06MB6228.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p2hPr0Ud2syURkJEY2QhgDBxFOS2iWJeuny4Ybxz9LMEa9imAigt5+xAPyO4SvLXCluCAUPDBs+rrN48Lb+jC1103vkiDCRqy06ee+M6tYRntsSALkepBm4Y2vyqaHpwt88oC7Jyz+hPUxzD9L+flpzsbzgftNcF7nlZD/S3VL6Ga8nZQFn7bSC+xCK7/MXjY8+UDZf3J0XWo0oWW5mWckntq8riAktO/SfuP/CUIsGKjzs5WLtvtX4ofj+XsyvNyHDGNUNPL95uE7+wGNO6zMTqdTxieMum3NkPlP7H81PyztbBl43hhRJah5Hy6/GCappM/VR/GLOOUXK7Njf4Q4hRHamMPWOHZSdfQHSQ2vLmN6ptCIntGLS3utPU6C02kP+bJqiRCoM2mU7F0bEY8BU3Z9oUoLXkgHXIDryfuQo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11B36E6EF59C2E40995F64F73D969AB0@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91113371-3073-4079-72ee-08d6d476cdf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 12:06:44.4281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB6164
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTA5IGF0IDA3OjM3IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBOZXRBcHAgU2VjdXJpdHkgV0FSTklORzogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFp
bC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4NCj4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBy
ZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4g
DQo+IA0KPiANCj4gSSB0aGluayBuZnNfZ2V0X2NsaWVudCBhbmQgbmZzX21hdGNoX2NsaWVudCBj
b3VsZCB1c2UgYSByZWZhY3Rvci4uIGJ1dA0KPiB0aGUNCj4gdHJpdmlhbCBmaXggaXM6DQoNClRo
YW5rcywgQmVuISBJJ2xsIGdvIHdpdGggdGhpcyBmaXggZm9yIG5vdywgYW5kIHdlIGNhbiBhbHdh
eXMgY2xlYW4gdXAgdGhlDQpmdW5jdGlvbiBsYXRlci4NCg0KQW5uYQ0KDQo+IA0KPiA4PC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gIEZyb20gNGVmMmZjNTkxMmM1OTgw
ODkwZTc4MWY4YzBkOTQxMzMwMjU0YzEwMCBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gTWVz
c2FnZS1JZDoNCj4gPDRlZjJmYzU5MTJjNTk4MDg5MGU3ODFmOGMwZDk0MTMzMDI1NGMxMDAuMTU1
NzQwMTQ2Ny5naXQuYmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gIEZyb206IEJlbmphbWluIENvZGRp
bmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQo+IERhdGU6IFRodSwgOSBNYXkgMjAxOSAwNzoy
NToyMSAtMDQwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIE5GUzogRml4IGEgZG91YmxlIHVubG9jayBm
cm9tIG5mc19tYXRjaCxnZXRfY2xpZW50DQo+IA0KPiBOb3cgdGhhdCBuZnNfbWF0Y2hfY2xpZW50
IGRyb3BzIHRoZSBuZnNfY2xpZW50X2xvY2ssIHdlIHNob3VsZCBiZQ0KPiBjYXJlZnVsDQo+IHRv
IGFsd2F5cyByZXR1cm4gaXQgaW4gdGhlIHNhbWUgY29uZGl0aW9uOiBsb2NrZWQuDQo+IA0KPiBG
aXhlczogOTUwYTU3OGM2MTI4ICgiTkZTOiBtYWtlIG5mc19tYXRjaF9jbGllbnQga2lsbGFibGUi
KQ0KPiBSZXBvcnRlZC1ieTogc3l6Ym90KzIyOGE4MmIyNjNiNWRhOTE4ODNkQHN5emthbGxlci5h
cHBzcG90bWFpbC5jb20NCj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNv
ZGRpbmdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgZnMvbmZzL2NsaWVudC5jIHwgMiArLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2ZzL25mcy9jbGllbnQuYyBiL2ZzL25mcy9jbGllbnQuYw0KPiBpbmRleCAwNmU4
NzE5NjU1ZjAuLmRhNzRjNGM0YTI0NCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL2NsaWVudC5jDQo+
ICsrKyBiL2ZzL25mcy9jbGllbnQuYw0KPiBAQCAtMjk5LDkgKzI5OSw5IEBAIHN0YXRpYyBzdHJ1
Y3QgbmZzX2NsaWVudCAqbmZzX21hdGNoX2NsaWVudChjb25zdA0KPiBzdHJ1Y3QgbmZzX2NsaWVu
dF9pbml0ZGF0YSAqZGF0DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZu
bi0+bmZzX2NsaWVudF9sb2NrKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZXJyb3IgPSBu
ZnNfd2FpdF9jbGllbnRfaW5pdF9jb21wbGV0ZShjbHApOw0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICBuZnNfcHV0X2NsaWVudChjbHApOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBzcGlu
X2xvY2soJm5uLT5uZnNfY2xpZW50X2xvY2spOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoZXJyb3IgPCAwKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBF
UlJfUFRSKGVycm9yKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl9sb2NrKCZubi0+
bmZzX2NsaWVudF9sb2NrKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBhZ2FpbjsN
Cj4gICAgICAgICAgICAgICAgIH0NCj4gDQo+IC0tDQo+IDIuMjAuMQ0K
