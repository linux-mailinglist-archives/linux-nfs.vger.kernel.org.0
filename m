Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4D125A6A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 06:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfLSFMy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 00:12:54 -0500
Received: from mail-mw2nam10on2124.outbound.protection.outlook.com ([40.107.94.124]:44589
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbfLSFMy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Dec 2019 00:12:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxgdtYpdoc10NVmykfNSdTrPnPgjLh5FjLCD9ERn98C+C3YhZXMIHOLBBP3npmiEOXU36kRrsf/H5xJa3ReI2wqVoQQmQEXhMhTkuteps4EXlp+QP4G78Mfbjg+bYLe4P8gO73SxNOTIXGVmAi24FB3gig7wO6m4oyKpeWVDQBqJMK6Iock9ZMM7wNLVjek/hHtnjwKwrqWyK2myKVcRrCyYDZ4/Czcr2xjlsxhVcIwz6TLH+o331d9ILyq1pEPD2cWMARWqmalZSyB2Nrn6L6Js0KPux7QV9bZj8mvHcaMP+CYkpZhVdcFS5GTxyfqjKYunwPiQCqTY1wkCiXvr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYSEMHupXYkjnYzraw60pinnZbJKhzeRKziX7ZqX4eY=;
 b=BMhoS05eomkX/4G+/z8NNRPNx3PydGqbq/MqsNG25ITF/RijUB7vC81rW4CB/P9WPJ19Mbj36gWsuoNAZ1AUY07IXnT2bV0z4RyK2KQfIkyjrj9kErG6DW/6koBVXLRX+hGFb8S9RNonpaNBs2t+q8hq1gJUS8oXM8cROWgtWEwmaZDQiq0tGdIMJxc83w2Wq5xiPFlzK8Le3PLUolmg/AYhzBAovjD2hCAhkvOzOUrW6obrVZGy3noGbsw4ZWrMMFzW0yeF/VrKBMFEtNvWmGJNIps1hteeIcTxf9RylqIazz1KewkpJerZMbvir8NagQ/qqtbBuyOns5uItMGdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYSEMHupXYkjnYzraw60pinnZbJKhzeRKziX7ZqX4eY=;
 b=c1jNH06DszH4sGTnIF6ES8a4FvFQJxpyRVOrh/IFHZKqv80IocT0RzoROWgb0oVuB8OKTuKmZu7B508tDlt+/DFHda0gOEbZ+EqwJ+3RSKOS8s5Kh2/Td2Q7TcLHrjojxfmeyPCr/nt1nP3ezRcKFUa+T38xHbpSmoHMR7KbOwE=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1932.namprd13.prod.outlook.com (10.174.183.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Thu, 19 Dec 2019 05:12:11 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 05:12:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support
 NFS4_OPEN_CLAIM_DELEG_CUR_FH
Thread-Topic: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support
 NFS4_OPEN_CLAIM_DELEG_CUR_FH
Thread-Index: AQHVtfUj0Db4D3dPKk6JV7ObGp2xVqfAjyIAgAA0tACAACX5gA==
Date:   Thu, 19 Dec 2019 05:12:10 +0000
Message-ID: <d3299fefa94d6959d848b765ce60e2467ce1b253.camel@hammerspace.com>
References: <87y2v9fdz8.fsf@notabene.neil.brown.name>
         <3afd2d5c631d8e3429e025e204a7b1c95b3c1415.camel@hammerspace.com>
         <87v9qdf2gh.fsf@notabene.neil.brown.name>
In-Reply-To: <87v9qdf2gh.fsf@notabene.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1ffc34f-c621-476b-7595-08d7844200c5
x-ms-traffictypediagnostic: DM5PR1301MB1932:
x-microsoft-antispam-prvs: <DM5PR1301MB1932C75E37842C82BFDED7E9B8520@DM5PR1301MB1932.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39830400003)(136003)(199004)(189003)(186003)(36756003)(508600001)(81156014)(86362001)(81166006)(8676002)(316002)(2906002)(6486002)(64756008)(15974865002)(66446008)(66946007)(2616005)(66556008)(110136005)(4001150100001)(76116006)(91956017)(66476007)(6506007)(71200400001)(26005)(5660300002)(6512007)(8936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1932;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ILGAStX9rbtixJGC8g0bQjbTNWD14JUcPwuR7QxQkghZPwySQo8e3GGOSsn9bjKHffDli9BQKvTE36m4N/5ESfDGkCXo8c4VJ7/sSkUaFpB1rSNsxRQfOOECUtdf9U6Nh2E2iuLugkLrneb14TSyUizR/ICP8b7IeOJESYdi69zjel1obIEdKeVD4nypyaK+Fm/THGAyXUvGiSbdytnl8u8CEDY+pCvEINrKhUCQW5LanVsxqgRU9BuMRUIJ5YsB9JMhmObl9kN6TwxHr6u/m9lNz9eoOb3y9TxnDdQ1JGqkDBKhn6BXkNA5qwD2zlWUJt05Wwv2A9TuKdAOL3QcCZXaxbos9Rbptk28K5CxcbvATNMmtMqzyTxamOUP9AEEMzgvEdydtJrvf+/zJZr6bQDUQgpVOUgyzwE/ygjZPnuKagsOa2eOGrNGu5dDnTrqtl+k6ojcVX1fisqukU5xB7BoQVov2K/74Z18Suz7OJU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC295EFB8357364CB212CB92149785AB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ffc34f-c621-476b-7595-08d7844200c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 05:12:10.8974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHq9BvEWN+0EKU5FCQlZayCS0f+jxFSQEbVHQrocxqAKH2Ye4CamyqPVT7G6EPLnN1aR2NrO9DnhAAg/ZkCM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1932
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTEyLTE5IGF0IDEzOjU2ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgRGVjIDE4IDIwMTksIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gT24gVGh1
LCAyMDE5LTEyLTE5IGF0IDA5OjQ3ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gPiBJZiBh
biBORlN2NC4xIHNlcnZlciBkb2Vzbid0IHN1cHBvcnQgTkZTNF9PUEVOX0NMQUlNX0RFTEVHX0NV
Ul9GSA0KPiA+ID4gKGUuZy4gTGludXggMy4wKSwgYW5kIGEgbmV3ZXIgTkZTIGNsaWVudCB0cmll
cyB0byB1c2UgaXQgdG8gY2xhaW0NCj4gPiA+IGFuIG9wZW4gYmVmb3JlIHJldHVybmluZyBhIGRl
bGVnYXRpb24sIHRoZSBzZXJ2ZXIgbWlnaHQgcmV0dXJuDQo+ID4gPiBORlM0RVJSX0JBRFhEUi4N
Cj4gPiA+IFRoYXQgaXMgd2hhdCBMaW51eCAzLjAgZG9lcywgdGhvdWdoIHRoZSBSRkMgZG9lc24n
dCBzZWVtIHRvIGJlDQo+ID4gPiBleHBsaWNpdA0KPiA+ID4gb24gd2hpY2ggZmxhZ3MgbXVzdCBi
ZSBzdXBwb3J0ZWQsIGFuZCB3aGF0IGVycm9yIGNhbiBiZSByZXR1cm5lZA0KPiA+ID4gZm9yDQo+
ID4gPiB1bnN1cHBvcnRlZCBmbGFncy4NCj4gPiANCj4gPiBORlM0RVJSX0JBRFhEUiBpcyBkZWZp
bmVkIGluIFJGQzU2NjEsIHNlY3Rpb24gMTUuMS4xLjEgYXMgbWVhbmluZw0KPiA+IA0KPiA+ICJU
aGUgYXJndW1lbnRzIGZvciB0aGlzIG9wZXJhdGlvbiBkbyBub3QgbWF0Y2ggdGhvc2Ugc3BlY2lm
aWVkIGluDQo+ID4gdGhlDQo+ID4gWERSIGRlZmluaXRpb24uIg0KPiA+IA0KPiA+IFRoYXQncyBj
bGVhcmx5IG5vdCB0aGUgY2FzZSBoZXJlLCBzbyBJJ2QgY2hhbGsgdGhpcyBkb3duIHRvIGENCj4g
PiBmYWlybHkNCj4gPiBibGF0YW50IHNlcnZlciBidWcsIGF0IHdoaWNoIHBvaW50IGl0IG1ha2Vz
IG5vIHNlbnNlIHRvIGZpeCBpdCBpbg0KPiA+IHRoZQ0KPiA+IGNsaWVudC4NCj4gDQo+IE9rLCBi
dXQgdGhlIFJGQyBzZWVtcyB0byBzdWdnZXN0IGl0IGlzIE9LIHRvIG5vdCBzdXBwb3J0IHRoaXMg
ZmxhZywNCj4gc28NCj4gc3VwcG9zZSBJIGZpeGVkIHRoZSBzZXJ2ZXIgdG8gcmV0dXJuIE5GUzRF
UlJfTk9UU1VQUCBpbnN0ZWFkLg0KPiBUaGUgY2xpZW50IHN0aWxsIHdvdWxkbid0IGhhbmRsZSB0
aGlzIHJlc3BvbnNlIGdyYWNlZnVsbHkuDQo+IA0KDQpORlM0RVJSX05PVFNVUFAgaXMgd3Jvbmcg
dG9vIGFzIHRoZSBPUEVOIG9wZXJhdGlvbiBpcyBjbGVhcmx5DQpzdXBwb3J0ZWQuIFRoZSBvbmx5
IGVycm9yIHRoYXQgbWlnaHQgbWFrZSBzZW5zZSBpcyBORlM0RVJSX0lOVkFMOg0KDQoiMTUuMS4x
LjQuICBORlM0RVJSX0lOVkFMIChFcnJvciBDb2RlIDIyKQ0KDQogICBUaGUgYXJndW1lbnRzIGZv
ciB0aGlzIG9wZXJhdGlvbiBhcmUgbm90IHZhbGlkIGZvciBzb21lIHJlYXNvbiwgZXZlbg0KICAg
dGhvdWdoIHRoZXkgZG8gbWF0Y2ggdGhvc2Ugc3BlY2lmaWVkIGluIHRoZSBYRFIgZGVmaW5pdGlv
biBmb3IgdGhlDQogICByZXF1ZXN0LiINCg0KVGhhdCBzYWlkLCB3aHkgZG8gd2UgY2FyZSBhYm91
dCBzdXBwb3J0aW5nIE5GU3Y0LjEgb24gdGhpcyBzZXJ2ZXI/IEl0DQppcyBjbGVhcmx5IGJyb2tl
bi4NCg0KDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0cHJv
Yy5jDQo+IGluZGV4IGNhYWNmNWU3ZjVlMS4uMTRmOTU4ZDE2NjQ4IDEwMDY0NA0KPiAtLS0gYS9m
cy9uZnMvbmZzNHByb2MuYw0KPiArKysgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBAQCAtMjE3NCw2
ICsyMTc0LDEzIEBAIHN0YXRpYyBpbnQgbmZzNF9vcGVuX3JlY2xhaW0oc3RydWN0DQo+IG5mczRf
c3RhdGVfb3duZXIgKnNwLCBzdHJ1Y3QgbmZzNF9zdGF0ZSAqc3RhDQo+ICBzdGF0aWMgaW50IG5m
czRfaGFuZGxlX2RlbGVnYXRpb25fcmVjYWxsX2Vycm9yKHN0cnVjdCBuZnNfc2VydmVyDQo+ICpz
ZXJ2ZXIsIHN0cnVjdCBuZnM0X3N0YXRlICpzdGF0ZSwgY29uc3QNCj4gbmZzNF9zdGF0ZWlkICpz
dGF0ZWlkLCBzdHJ1Y3QgZmlsZV9sb2NrICpmbCwgaW50IGVycikNCj4gIHsNCj4gCXN3aXRjaCAo
ZXJyKSB7DQo+ICsJCWNhc2UgLU5GUzRFUlJfTk9UU1VQUDogew0KPiArCQkJc3RydWN0IG5mczRf
ZXhjZXB0aW9uIGV4Y2VwdGlvbjsNCj4gKwkJCWlmIChuZnM0X2NsZWFyX2NhcF9hdG9taWNfb3Bl
bl92MShzZXJ2ZXIsDQo+IC1FSU5WQUwsDQo+ICsJCQkJCQkJICAmZXhjZXB0aW9uKSkNCj4gKwkJ
CQlyZXR1cm4gLUVBR0FJTjsNCj4gKwkJfQ0KPiArCQkJLyogZmFsbHRocm91Z2ggKi8NCj4gCQlk
ZWZhdWx0Og0KPiAJCQlwcmludGsoS0VSTl9FUlIgIk5GUzogJXM6IHVuaGFuZGxlZCBlcnJvciAi
DQo+IAkJCQkJIiVkLlxuIiwgX19mdW5jX18sIGVycik7DQo+IA0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkNUTywgSGFtbWVyc3BhY2UgSW5jDQo0MzAwIEVsIENhbWlubyBSZWFsLCBTdWl0ZSAxMDUN
CkxvcyBBbHRvcywgQ0EgOTQwMjINCnd3dy5oYW1tZXIuc3BhY2UNCg0K
