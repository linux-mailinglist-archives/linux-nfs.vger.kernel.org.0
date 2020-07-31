Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8800234BC4
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jul 2020 21:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgGaTtL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jul 2020 15:49:11 -0400
Received: from mail-bn7nam10on2125.outbound.protection.outlook.com ([40.107.92.125]:16097
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbgGaTtL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 31 Jul 2020 15:49:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5OKGDNlwuza8K/NTwdiuqnDatwUhqC5RgcSSCtVlydaemm3qlpgT5DGqjeCcNw4SHLYo16Vm5PFhjA30gKCgNb+DzES+sSb8s5mmW80HqR6Uy/EXSY0vR0Hv6JPSo7Ih4AiE/ZXbDKYaBadQzHrsrI8ROlf/KQw65wIYffCAavsWIk7sjWIPXiwMx9Ia8u3JGfzNLGP2nSuGqBrLJuma/EwFCDJH0BxCTIf34FtoacvHEeAbqqah6h/V4hj/zD0nFu9f8nkDXVfL3Yp3e0oj7IlQf+XQin3enEvJjf8zAq5x/mMrbCF+iYf0IdxeR/Z6WTxlpjtYqPex2X12PMduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbGK+Dw3oHVHWjX7jzosq8nDDVGvo8IfIHT1KxG2Nbw=;
 b=bNp3tod4S5nU/DoBn35CEktP4Zj7BCwjoIsKIlSQcg40fAPcd41yEXjirPlEONDRvEdL0ER7PV1PAMf3q4GOTdX0r10psJDBgSjJYBs4Jv408TSqO/Y3uiNtug8/nia4AxwaXvwErMkMONJZxEY43CHJkFCih/yCGV/xKyIMDmbu5rFyE5ct8HVTwFH0tGUSHtks5rKyUNQMu2WNMQUZZaiEX+tFZTSWpZj5wcoBueLLLVYmYexmquhOudqDiwAWDLa9fMNXsi9eGGjSzKFFIQkDmoXuza/cDnMdlRFskTX096mmeI0HBU/AET6+Um9gBotsZowoKp7wOo4rEZXyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbGK+Dw3oHVHWjX7jzosq8nDDVGvo8IfIHT1KxG2Nbw=;
 b=D8KT3yzfuIjmz5QyC3WNlCmujVJ4e/FyaZMKyLx669ASeAYLAx+8A14EA7t5ejT7VUfO6quUlBx6GhxpX8DMW92Q0BWmN/WY3TmdmTPdPwWLwwzTWXRaZhrIz2Ecl+uOULbxIti77oCXS7DOc4EVbhnDnLrUr/snhV0RRSw4JOE=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3334.namprd13.prod.outlook.com (2603:10b6:610:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9; Fri, 31 Jul
 2020 19:49:07 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756%3]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 19:49:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/2] nfs: ensure correct writeback errors are returned on
 close()
Thread-Topic: [PATCH 1/2] nfs: ensure correct writeback errors are returned on
 close()
Thread-Index: AQHWZ2KCzX0RO9Uux0q5FOOKww0hCqkiD3OAgAAHo4CAAAFwgA==
Date:   Fri, 31 Jul 2020 19:49:07 +0000
Message-ID: <3a4005cd87cb0478033eb02546a5066555e2da6d.camel@hammerspace.com>
References: <20200731174614.1299346-1-smayhew@redhat.com>
         <20200731174614.1299346-2-smayhew@redhat.com>
         <cbd94bd68cbdefd06591ae7ba4d57fdd8b619ebf.camel@hammerspace.com>
         <20200731194357.GJ4452@aion.usersys.redhat.com>
In-Reply-To: <20200731194357.GJ4452@aion.usersys.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d2a9910-7fd0-4745-caf0-08d8358ac944
x-ms-traffictypediagnostic: CH2PR13MB3334:
x-microsoft-antispam-prvs: <CH2PR13MB3334D8605B907319F8BBF42FB84E0@CH2PR13MB3334.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: csaIgm0DhC4Cz6ayWEsHDBpUheWU7DHXYjdRnM8tUT1pGi0kS95clc1kzI0H/Dldd+cfzsU8Re7NWX4NL20dSpTHOVTf+3X+JC8RIowiIFhwJSnMhTQtVaBIN8XBxfEv/leuTW+QcOW4Qp8pBUaFyoNoJoaqTkqoSodk2S+X/d64VoyGenigEOUV/V5HzT5tJbeYyYLsjfn5YLser9tlMWkeBNsN6krOAO1o+sV7uqxYkTqdmgjv8srieXOKNqCeDTArshmrnSX1C8L3i7HFqe6c+F2+A91jRNb0YDr+WOPUNvq4liGO6Pi3d4ioYu6CxsxV0Ivr62hw1rnwrn9mfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39840400004)(366004)(396003)(136003)(4326008)(8676002)(6486002)(86362001)(8936002)(83380400001)(6916009)(6512007)(316002)(36756003)(91956017)(5660300002)(66446008)(64756008)(66556008)(26005)(186003)(6506007)(54906003)(66946007)(2616005)(76116006)(478600001)(2906002)(66476007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4N0JwrBOvxJaUU4d4MpeKcFPb8qwQCWz23b9WqTqSWdadhvybz8dncN2fuVBaImNHpdgTej9cpzNg9dmXP5GJ0Rb60KsSSYjZiL0W+24WEPK0te39VunHw2VritxJfFsg+XBnsp02WEC0fBdCf/QUbsgF4cCnHCH1qmSh4r2K5eoccUauNFlx/26YmfbbQnbPKUI2itTW83L4reQ9l99a90ZBFZEn24xY/xjGd0iMrPBny7ZYqVgpcGrmPsSRlbqEU3VGb8dISd1/SblKxGiPI3YGIJ2fNytQiVYSNmDHCZs33GSGnt7CtEG9xzCCUQMctSLXPqAV442Oduh+8laAvH2XNCcBjul5WtBxq+XCFGFZltBnQcno4TRmeLOsCGugdirYzWOvFRsXVTLALnVCq5R0C8u2BMIM0i663LdUoNQOwhpXd2mgFCYJ7sSpkImd9D9QaVkHU86Xv9W+iYREO5qpegBRCQtp2wMQQlyQT+zVehjQ2VTGSZKcNlNgdpybXHNArfarjNRkW8Z9XaJ7r4IQm8PlWb4lP722ZwyJ542lH310qviHeTBJxYqF/F15bdAuMDfZTEKsHrGsx8wLfnAtOMb2GgdiA5lP1oWQ9adUpy5Oui9AfnVKDG3/I58qnHl2PJrAh6RSAC2maKs3g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA9FE08790B28F40B7D61E94E7BE1D00@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2a9910-7fd0-4745-caf0-08d8358ac944
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 19:49:07.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4kzSsgV6Qf5AdeMblPi8egmnyQs/Swh7+JL27lye57yJwcktkmGKmCSAj+s1H51L7ILu6JguwId4rsSLl34fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3334
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTMxIGF0IDE1OjQzIC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+
IE9uIEZyaSwgMzEgSnVsIDIwMjAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gT24g
RnJpLCAyMDIwLTA3LTMxIGF0IDEzOjQ2IC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+ID4g
PiBuZnNfd2JfYWxsKCkgY2FsbHMgZmlsZW1hcF93cml0ZV9hbmRfd2FpdCgpLCB3aGljaCB1c2Vz
DQo+ID4gPiBmaWxlbWFwX2NoZWNrX2Vycm9ycygpIHRvIGRldGVybWluZSB0aGUgZXJyb3IgdG8g
cmV0dXJuLg0KPiA+ID4gZmlsZW1hcF9jaGVja19lcnJvcnMoKSBvbmx5IGxvb2tzIGF0IHRoZSBt
YXBwaW5nLT5mbGFncyBhbmQgd2lsbA0KPiA+ID4gdGhlcmVmb3JlIG9ubHkgcmV0dXJuIGVpdGhl
ciAtRU5PU1BDIG9yIC1FSU8uICBUbyBlbnN1cmUgdGhhdCB0aGUNCj4gPiA+IGNvcnJlY3QgZXJy
b3IgaXMgcmV0dXJuZWQgb24gY2xvc2UoKSwgbmZzeyw0fV9maWxlX2ZsdXNoKCkgc2hvdWxkDQo+
ID4gPiBjYWxsDQo+ID4gPiBmaWxlX2NoZWNrX2FuZF9hZHZhbmNlX3diX2VycigpIHdoaWNoIGxv
b2tzIGF0IHRoZSBlcnJzZXEgdmFsdWUNCj4gPiA+IGluDQo+ID4gPiBtYXBwaW5nLT53Yl9lcnIu
DQo+ID4gPiANCj4gPiA+IEZpeGVzOiA2ZmJkYTg5YjI1N2YgKCJORlM6IFJlcGxhY2UgY3VzdG9t
IGVycm9yIHJlcG9ydGluZw0KPiA+ID4gbWVjaGFuaXNtDQo+ID4gPiB3aXRoDQo+ID4gPiBnZW5l
cmljIG9uZSIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTY290dCBNYXloZXcgPHNtYXloZXdAcmVk
aGF0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGZzL25mcy9maWxlLmMgICAgIHwgMyArKy0NCj4g
PiA+ICBmcy9uZnMvbmZzNGZpbGUuYyB8IDMgKystDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQg
YS9mcy9uZnMvZmlsZS5jIGIvZnMvbmZzL2ZpbGUuYw0KPiA+ID4gaW5kZXggZjk2MzY3YTI0NjNl
Li5lZWVmNjU4MDA1MmYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9uZnMvZmlsZS5jDQo+ID4gPiAr
KysgYi9mcy9uZnMvZmlsZS5jDQo+ID4gPiBAQCAtMTQ4LDcgKzE0OCw4IEBAIG5mc19maWxlX2Zs
dXNoKHN0cnVjdCBmaWxlICpmaWxlLCBmbF9vd25lcl90DQo+ID4gPiBpZCkNCj4gPiA+ICAJCXJl
dHVybiAwOw0KPiA+ID4gIA0KPiA+ID4gIAkvKiBGbHVzaCB3cml0ZXMgdG8gdGhlIHNlcnZlciBh
bmQgcmV0dXJuIGFueSBlcnJvcnMgKi8NCj4gPiA+IC0JcmV0dXJuIG5mc193Yl9hbGwoaW5vZGUp
Ow0KPiA+ID4gKwluZnNfd2JfYWxsKGlub2RlKTsNCj4gPiA+ICsJcmV0dXJuIGZpbGVfY2hlY2tf
YW5kX2FkdmFuY2Vfd2JfZXJyKGZpbGUpOw0KPiA+ID4gIH0NCj4gPiA+ICANCj4gPiA+ICBzc2l6
ZV90DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRmaWxlLmMgYi9mcy9uZnMvbmZzNGZp
bGUuYw0KPiA+ID4gaW5kZXggOGU1ZDYyMjNkZGQzLi43N2JmOWMxMjczNGMgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9mcy9uZnMvbmZzNGZpbGUuYw0KPiA+ID4gKysrIGIvZnMvbmZzL25mczRmaWxlLmMN
Cj4gPiA+IEBAIC0xMjUsNyArMTI1LDggQEAgbmZzNF9maWxlX2ZsdXNoKHN0cnVjdCBmaWxlICpm
aWxlLCBmbF9vd25lcl90DQo+ID4gPiBpZCkNCj4gPiA+ICAJCXJldHVybiBmaWxlbWFwX2ZkYXRh
d3JpdGUoZmlsZS0+Zl9tYXBwaW5nKTsNCj4gPiA+ICANCj4gPiA+ICAJLyogRmx1c2ggd3JpdGVz
IHRvIHRoZSBzZXJ2ZXIgYW5kIHJldHVybiBhbnkgZXJyb3JzICovDQo+ID4gPiAtCXJldHVybiBu
ZnNfd2JfYWxsKGlub2RlKTsNCj4gPiA+ICsJbmZzX3diX2FsbChpbm9kZSk7DQo+ID4gPiArCXJl
dHVybiBmaWxlX2NoZWNrX2FuZF9hZHZhbmNlX3diX2VycihmaWxlKTsNCj4gPiA+ICB9DQo+ID4g
PiAgDQo+ID4gPiAgI2lmZGVmIENPTkZJR19ORlNfVjRfMg0KPiA+IA0KPiA+IEkgZG9uJ3QgdGhp
bmsgdGhpcyBvbmUgaXMgY29ycmVjdC4gVGhlIGNvbnRyYWN0IHdpdGggUE9TSVggaXMgdGhhdA0K
PiA+IHdlDQo+ID4gYWx3YXlzIGRlbGl2ZXIgdGhlIGVycm9yIG9uIGZzeW5jKCkuIElmIHdlIGNh
bGwNCj4gPiBmaWxlX2NoZWNrX2FuZF9hZHZhbmNlX3diX2VycigpIGhlcmUgaW4gbmZzX2ZpbGVf
Zmx1c2goKSwgdGhlbiB0aGF0DQo+ID4gbWVhbnMgd2UgZWF0IHRoZSBlcnJvciBiZWZvcmUgaXQg
Y2FuIGdldCBkZWxpdmVyZWQgdG8gZnN5bmMoKS4NCj4gDQo+IEkgd2FzIGxvb2tpbmcgYXQgY2Fs
bGVycyBvZiB0aGUgZmx1c2ggZl9vcCBhbmQgdGhlIG9ubHkgb25lIEkgc2F3IHdhcw0KPiBmaWxw
X2Nsb3NlKCksIHNvIEkgYXNzdW1lZCB0aGF0IHRoZXJlIHdvdWxkbid0IGJlIGFueSBvdGhlciBj
YWxscyB0bw0KPiBmc3luYygpIGZvciB0aGF0IHN0cnVjdCBmaWxlLi4uIEkgZ3Vlc3MgdGhhdCdz
IG5vdCB0aGUgY2FzZSBpZiB0aGUNCj4gZmlsZQ0KPiBkZXNjcmlwdG9yIHdhcyBkdXBsaWNhdGVk
IHRob3VnaC4NCj4gDQo+IFdvdWxkIGEgc29sdXRpb24gdXNpbmcgZmlsZW1hcF9zYW1wbGVfd2Jf
ZXJyKCkgJg0KPiBmaWxlbWFwX2NoZWNrX3diX2VycigpDQo+IGJlIGFjY2VwdGFibGUgKGxpa2Ug
aW4gdGhlIDJuZCBwYXRjaCk/DQo+IA0KDQpJIHRoaW5rIHRoYXQgd291bGQgYmUgbW9yZSBhcHBy
b3ByaWF0ZSwgeWVzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
