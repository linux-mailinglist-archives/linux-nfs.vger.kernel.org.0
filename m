Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E761DADD0
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 15:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394183AbfJQNGQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 09:06:16 -0400
Received: from mail-eopbgr780104.outbound.protection.outlook.com ([40.107.78.104]:54185
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbfJQNGQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 09:06:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzcz+jhDsLbqHd1qhpXCgMEAyYUkE7zAEwxAh+Ie9vTRw9JE7kH2Pk1gcWOvJ23jd8SFGCrLUN4TTuLbyyOIqgAsJNDP8ave9ZO1854tgIMAUt2ZrCL0GdFZrlRDeM3cmLmVW7RsF66Qr6evt3L57AjdF62fDY3AFOprD1Y5ytZQw78huISMSqCrMJgjyKbLJ0/89si3Cm61PLo+rK+7kfQpGDZRcATTEhK5uYgHYUKlHrnWdn4plXr21jjjgeubBK3Z/0GrjY1/zo/NnlfpnBgZ6S5lWzuQCBZEWPQY4sYdCWh1+7em64t/wen1Okb7qVeQ+/wd+WNH8/o3K9pwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AvVBFyY2ljcnEryTMC4i5lTIQpjsBoYSYe/wYNdmDA=;
 b=N3drBlwdtJHeTzNAJTLHLVV6zx7v5N+NLqHla/zdJb8XMkuqJk7QX3fH630fGcMANwM/CSGYxaBNiyOtRdV46kzVGdCJ2LlUL6+ixqLyZ3KbF1IRF8xSPkG0YQNQkg/7WwtiH1I2jf+Xp3w5c2b8tLvoxEb/nju9j2e9X/e/H3vyT8EW9smiNYtJOYDxsinkaQNGg0Dun/WpPysRZk4UJTuvkwq2eb8wCfz08AexC69W0s1fZ0SvbNi5HFuaWowCnY0zLa8ZqYjZeXkv4xrJXMzlfgIX0p4lLjOlUwWgbz7o4WiqfNXjb/M8nDMJm9/89r4oCN0tduVFE9pcghXCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AvVBFyY2ljcnEryTMC4i5lTIQpjsBoYSYe/wYNdmDA=;
 b=aAh0aKAukTjpPCPl4TiLtG+CHD7lFAjXiTlgM9t4J3w+jU89cLl1SonIfNdu8HYk2XiZeTf6rCnQZ0YcGH4IVhQ1G+KQtw+C0GPT5Fp9QXz4X2jTj33DAV8lEpy5twl7OVFXrSC+HinIEElDaANgmFPvXGNT/NTnneQtHxkMBbE=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2107.namprd13.prod.outlook.com (10.174.185.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14; Thu, 17 Oct 2019 13:06:13 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::4c0b:3977:6b2d:6a8c]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::4c0b:3977:6b2d:6a8c%3]) with mapi id 15.20.2367.016; Thu, 17 Oct 2019
 13:06:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 3/3] SUNRPC: Destroy the back channel when we destroy the
 host transport
Thread-Topic: [PATCH 3/3] SUNRPC: Destroy the back channel when we destroy the
 host transport
Thread-Index: AQHVhCyGcepOjY9kxEmj0mEmIWJlC6dd1BkAgAD62YA=
Date:   Thu, 17 Oct 2019 13:06:12 +0000
Message-ID: <f6d731533113a09e8ee4a2894f4ad0432e9fb66e.camel@hammerspace.com>
References: <20191016141546.32277-1-trond.myklebust@hammerspace.com>
         <20191016141546.32277-2-trond.myklebust@hammerspace.com>
         <20191016141546.32277-3-trond.myklebust@hammerspace.com>
         <87sgnspcmh.fsf@notabene.neil.brown.name>
In-Reply-To: <87sgnspcmh.fsf@notabene.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [66.187.232.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d15a6bb9-88ca-4a6d-a9f7-08d75302c959
x-ms-traffictypediagnostic: DM5PR1301MB2107:
x-microsoft-antispam-prvs: <DM5PR1301MB2107F50F7E0B664E80F3F995B86D0@DM5PR1301MB2107.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(66556008)(66446008)(91956017)(76116006)(66066001)(99286004)(8676002)(14454004)(86362001)(2501003)(6116002)(7736002)(2906002)(478600001)(3846002)(305945005)(71200400001)(71190400001)(5660300002)(66946007)(66476007)(256004)(64756008)(316002)(76176011)(81166006)(118296001)(446003)(4326008)(102836004)(6486002)(6436002)(8936002)(26005)(81156014)(6506007)(6246003)(186003)(6512007)(486006)(2616005)(110136005)(54906003)(229853002)(4001150100001)(25786009)(36756003)(476003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2107;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tV9zst4HEx89krjT/8PnwPD01vsv1lAClH4ofZdnP7eexu9R48yB4OMUU5VzIobxJzylaYeVVFXipAcL5ls4BVOxQHhxDxT0ucLzvjisjH5D96WU1PD5abF2L8cuHNV4A81xQEO5xl9VuLjfeBbIntaNXcAq5yY4Cj7iKbY4gb1Dlr/nMDeW3HieoCagobiTYNpw2z3JOZNpaWEM3yTStfuralClh+9ZS2u+5NXvjs8Urcl5EqtQFg09KFwlrT7rmtWAwU4r67r0AL+6KYsKHV9awYL/YHjIZOe8UrBRBE6IbLFXkKEPypzt6nwFJEcVH2IMx+IGWt8QajIxcd0B/+mK7QTvTJNFTB2nBQU+NR2mQBO0hI0N7soSnnyqronB5bvg6LofyiJDx+MraszhvqS5TKRPEFN0z7EY7k7k1VM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B000810D5E0D94DB00C7B766FED3FF3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15a6bb9-88ca-4a6d-a9f7-08d75302c959
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 13:06:12.7921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFRabesrSoALpfvLSwH87fxDYYrk14f0gJo98AyyDsv5s04jIouk0uZYXSA6cFJLm3hjjKWHd1GpkOfpCdx5ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2107
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTE3IGF0IDA5OjA4ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgT2N0IDE2IDIwMTksIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gV2hlbiB3
ZSdyZSBkZXN0cm95aW5nIHRoZSBob3N0IHRyYW5zcG9ydCBtZWNoYW5pc20sIHdlIHNob3VsZA0K
PiA+IGVuc3VyZQ0KPiA+IHRoYXQgd2UgZG8gbm90IGxlYWsgbWVtb3J5IGJ5IGZhaWxpbmcgdG8g
cmVsZWFzZSBhbnkgYmFjayBjaGFubmVsDQo+ID4gc2xvdHMgdGhhdCBtaWdodCBzdGlsbCBleGlz
dC4NCj4gPiANCj4gPiBSZXBvcnRlZC1ieTogTmVpbCBCcm93biA8bmVpbGJAc3VzZS5kZT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20+DQo+ID4gLS0tDQo+ID4gIG5ldC9zdW5ycGMveHBydC5jIHwgNSArKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L25ldC9zdW5ycGMveHBydC5jIGIvbmV0L3N1bnJwYy94cHJ0LmMNCj4gPiBpbmRleCA4YTQ1YjNj
Y2MzMTMuLjQxZGY0YzUwNzE5MyAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvc3VucnBjL3hwcnQuYw0K
PiA+ICsrKyBiL25ldC9zdW5ycGMveHBydC5jDQo+ID4gQEAgLTE5NDIsNiArMTk0MiwxMSBAQCBz
dGF0aWMgdm9pZCB4cHJ0X2Rlc3Ryb3lfY2Ioc3RydWN0DQo+ID4gd29ya19zdHJ1Y3QgKndvcmsp
DQo+ID4gIAlycGNfZGVzdHJveV93YWl0X3F1ZXVlKCZ4cHJ0LT5zZW5kaW5nKTsNCj4gPiAgCXJw
Y19kZXN0cm95X3dhaXRfcXVldWUoJnhwcnQtPmJhY2tsb2cpOw0KPiA+ICAJa2ZyZWUoeHBydC0+
c2VydmVybmFtZSk7DQo+ID4gKwkvKg0KPiA+ICsJICogRGVzdHJveSBhbnkgZXhpc3RpbmcgYmFj
ayBjaGFubmVsDQo+ID4gKwkgKi8NCj4gPiArCXhwcnRfZGVzdHJveV9iYWNrY2hhbm5lbCh4cHJ0
LCBVSU5UX01BWCk7DQo+ID4gKw0KPiANCj4gVGhpcyB3aWxsIGNhdXNlIHhwcnQtPmJjX2FsbG9j
X21heCB0byBiZWNvbWUgbWVhbmluZ2xlc3MuDQoNCkZpeGVkIGluIHYyLg0KDQo+IFRoYXQgaXNu
J3QgcmVhbGx5IGEgcHJvYmxlbSBhcyB0aGUgeHBydCBpcyBhYm91dCB0byBiZSBmcmVlZCwgYnV0
IGl0DQo+IHN0aWxsIHNlZW1zIGEgbGl0dGxlIHVudGlkeSAtIGZyYWdpbGUgbWF5YmUuDQo+IEhv
dyBhYm91dCBhbm90aGVyIGxpbmUgaW4gdGhlIGNvbW1lbnQ6DQo+IA0KPiAgICAqIE5vdGU6IHRo
aXMgY29ycnVwdHMgLT5iY19hbGxvY19tYXgsIGJ1dCBpdCBpcyB0b28gbGF0ZSBmb3IgdGhhdA0K
PiB0bw0KPiAgICAqIG1hdHRlci4NCj4gPz8NCj4gDQo+IEFsc28sIHBvc3NpYmx5IGFkZA0KPiAg
V0FSTl9PTihhdG9taWNfcmVhZCgmeHBydC0+YmNfc2xvdF9jb3VudCk7DQo+IGVpdGhlciBiZWZv
cmUgb3IgYWZ0ZXIgdGhlIHhwcnRfZGVzdHJveV9iYWNrY2hhbm5lbCAtIGJlY2F1c2UgdGhlcmUN
Cj4gcmVhbGx5IHNob3VsZG4ndCBiZSBhbnkgcmVxdWVzdHMgYnkgdGhpcyBzdGFnZS4NCg0KSSBj
b25zaWRlcmVkIGl0LCBidXQgc2luY2UgUkRNQSBkb2Vzbid0IHVzZSB0aG9zZSB2YXJpYWJsZSwg
aXQgd291bGRuJ3QNCnJlYWxseSBiZSBhIHN1ZmZpY2llbnQgY2hlY2suDQoNClRoYW5rcw0KICBU
cm9uZA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
