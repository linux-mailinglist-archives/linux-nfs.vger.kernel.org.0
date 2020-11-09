Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C003D2AC793
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 22:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgKIVqp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 16:46:45 -0500
Received: from mail-mw2nam12on2109.outbound.protection.outlook.com ([40.107.244.109]:45153
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbgKIVqp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Nov 2020 16:46:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/JuUqG84O2wiZWv5fYUQcKn/94Vu9BkysmVUuuEktBI6BtfAimxO5JxDryoFWf5X751V7eakc/uKNIN2b3ZwR6bAMRIznjVXXY1eZpMjCgr1y0BwiPjxYLqDOPR6ChNXpfvl50YDeVH3DiduoyPFlbWHROX3v6dUbxHzdJ3bbjZuuxFNJF01gEusNoyv8W5c4QNqmJVjnNzPHDlYrP93N8qDGrrSpeIUByEDzX789CXqM1gQZDZpcEB0bA1dujFrbxYKVoLk+xBblZ+38kjqa/XR89znMeqfolMHxSMITSO34/hA/DJSonXf4wt6fo7fOjLLwo0al/hKwO+N4gOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObQL5w/7phAIVBD/cwbJaS9z4d9d2YrxSgr2OOZHmEE=;
 b=mjkmeHREaxi1PEmwLwcbGUNpamoGvQQAW33MTg1tA5lQdY1f4XrIqsJ7uOhaN0QyWoNc43C2WJA/R9jE9DxDnDoZq8hLVVvtYjZl9u5a10bEoDA5297dTOp3gOj8jp/p5ujz2bW0bOaLz5FLcfL1T5q3JasMBKIFlQrixg+7b55RWrgdEPNbx6FCLGWU7W0DI8J3MaCPs+nCuEvqTq4+Xei5eld1XNxtk08FFz0E34iSvzU1DY7dakjZ/cTxmliP6yaHieszEh/NPXs4vsTNfrXRM2DCxcaq/TMygMy0Z6fkn5MGSfwNMLMTzy6ZWOaHYokgQZpni/tRQ6C5JwkMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObQL5w/7phAIVBD/cwbJaS9z4d9d2YrxSgr2OOZHmEE=;
 b=Jvx3P/rMhY49W5ggjhXXnP2EgV1lxfYJArUqaVQ2U4sOWOvCL6pQe5g8oa0im7+2hgvcovqhjTYbL2pJZsbFduWC8MWrpL7/zbQ83ipicu2aCc54xBqoJYWVR3AMWM/zBIAJzpwRu4pZNa7hqg98rxkzTchMGu5T2pwh7eOSPWE=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3230.namprd13.prod.outlook.com (2603:10b6:208:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.15; Mon, 9 Nov
 2020 21:46:39 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Mon, 9 Nov 2020
 21:46:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a
 cookie in an empty page cache
Thread-Topic: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a
 cookie in an empty page cache
Thread-Index: AQHWtRA6iwOeaceJLkybCI7SueOQ/6nAV/UAgAABg4A=
Date:   Mon, 9 Nov 2020 21:46:38 +0000
Message-ID: <d31c1ca31e734d7566f3da6d1c1d651abc4101f7.camel@hammerspace.com>
References: <20201107140325.281678-1-trondmy@kernel.org>
         <20201107140325.281678-2-trondmy@kernel.org>
         <20201107140325.281678-3-trondmy@kernel.org>
         <20201107140325.281678-4-trondmy@kernel.org>
         <20201107140325.281678-5-trondmy@kernel.org>
         <20201107140325.281678-6-trondmy@kernel.org>
         <20201107140325.281678-7-trondmy@kernel.org>
         <20201107140325.281678-8-trondmy@kernel.org>
         <20201107140325.281678-9-trondmy@kernel.org>
         <20201107140325.281678-10-trondmy@kernel.org>
         <20201107140325.281678-11-trondmy@kernel.org>
         <20201107140325.281678-12-trondmy@kernel.org>
         <20201107140325.281678-13-trondmy@kernel.org>
         <20201107140325.281678-14-trondmy@kernel.org>
         <20201107140325.281678-15-trondmy@kernel.org>
         <20201107140325.281678-16-trondmy@kernel.org>
         <20201107140325.281678-17-trondmy@kernel.org>
         <20201107140325.281678-18-trondmy@kernel.org>
         <20201107140325.281678-19-trondmy@kernel.org>
         <20201107140325.281678-20-trondmy@kernel.org>
         <20201107140325.281678-21-trondmy@kernel.org>
         <20201107140325.281678-22-trondmy@kernel.org>
         <86F25343-0860-44A2-BA40-CFB640147D50@redhat.com>
In-Reply-To: <86F25343-0860-44A2-BA40-CFB640147D50@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69738481-919d-4d02-0282-08d884f8f047
x-ms-traffictypediagnostic: MN2PR13MB3230:
x-microsoft-antispam-prvs: <MN2PR13MB323033BDCD2BE14BA7FD21F7B8EA0@MN2PR13MB3230.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mfqSfdaWbQr3iogS/pWQMaylQH9WJ6ysIayVoLIzU4JDcsrfqmZpxJ/vefOz/m5N5BLJDfBBXprNyKs/65RHod96VIBujOTnWxAI7Ic8GHWtaL2BrE148jAAdvrjHRMi1cMZT7L3y9OvtgbOVM5CPJc8RqOaFLyS0B6wjDY89nJPXbEnoGmn3DTP5O9yzmeVdS7sgDnRTGQpzonMIjrXdkGuVOrtI3Uzsp6MVQqEqRCCGnGq/CXr7BxTP6v8vehYlmwJ+ZCIAVb6kqP8PCXS1Ae1ewyXtfX8d65jMuO9D50K7lmEGN81FG6PdjjYObmhL0awDTZ/3JQUp++KyBNUKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39830400003)(366004)(6506007)(5660300002)(8676002)(36756003)(186003)(316002)(83380400001)(86362001)(53546011)(6486002)(66476007)(66556008)(8936002)(91956017)(2616005)(64756008)(66446008)(6512007)(4326008)(66946007)(76116006)(6916009)(2906002)(26005)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Myoybbg9EJyNfSLFY9tfrlCO/XNkY7nD6W87Rkivl+apyjXCYTc9k5Fv2jhyxI6aPhp9/mmToVmgUJrMDNJV8tmzuhIyN9Mr0ZGxCmjSMp0Tgecvn4OTOUlHJYQySdPU43/PJN1BzHS6vg9FkQpSLIEEON+dNPSJEYLEtA9w0dFu3J4icgMayw5K7exkYE988S3YNX9nKjLQEjjt+1IZS/oQpnADkT7my65A3GvodAM9Yq2atrMd08kpEktYDJ4Exs9T7X+DKxPneqaTRo0Z6PRPcbb7+ppvb7snxSIrhDtnsqLMbY5Fqhi/FrP+I2Gj31/7Q2ELx3tAtYXau/pfhkIw9DthDcQeUMyi/NmMQJu2Zbc7GhLCToJzXA+MreaKjwDOutZfR6VUr376pIiGhJo70dIGclPHtIjKC8uks0CtbzHavV8n2J9AhQBM3ZaN4xvK4En72nD+FyoyaeKKuFYWRVQheQxqIYOHPOUe7b/IZUEU+Z5Qg0gNJ6xOOU/u6q3a0B+zBvoOFSYLS7o04c5mzDSOT+iqpY/5pczrErDWX1dzlbbBrSQsbEYIjL5GktHsi3J4TLbOKLSvvoWSSz+m+HFlKrtyX99UzLMan2bM1DHlhkrAJ5wqEwKnEK3JdH+UupcCMZ2MNTbmfARgQA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F0A4616ECD8654CB0B8405E919BCF84@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69738481-919d-4d02-0282-08d884f8f047
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 21:46:38.8895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMySYr7A0x6F1Oox0A0M1/MZZEOaSYeRGLTbbqS8+bj1SAIEcQtfNokqdVfz0/+dabcbeaNjJh2d+qH0rZnAKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3230
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTA5IGF0IDE2OjQxIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA3IE5vdiAyMDIwLCBhdCA5OjAzLCB0cm9uZG15QGtlcm5lbC5vcmfCoHdyb3Rl
Og0KPiANCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20+DQo+ID4gDQo+ID4gSWYgdGhlIGRpcmVjdG9yeSBpcyBjaGFuZ2luZywgY2F1c2lu
ZyB0aGUgcGFnZSBjYWNoZSB0byBnZXQgDQo+ID4gaW52YWxpZGF0ZWQNCj4gPiB3aGlsZSB3ZSBh
cmUgbGlzdGluZyB0aGUgY29udGVudHMsIHRoZW4gdGhlIE5GUyBjbGllbnQgaXMgY3VycmVudGx5
DQo+ID4gZm9yY2VkDQo+ID4gdG8gcmVhZCBpbiB0aGUgZW50aXJlIGRpcmVjdG9yeSBjb250ZW50
cyBmcm9tIHNjcmF0Y2gsIGJlY2F1c2UgaXQgDQo+ID4gbmVlZHMNCj4gPiB0byBwZXJmb3JtIGEg
bGluZWFyIHNlYXJjaCBmb3IgdGhlIHJlYWRkaXIgY29va2llLiBXaGlsZSB0aGlzIGlzDQo+ID4g
bm90DQo+ID4gYW4gaXNzdWUgZm9yIHNtYWxsIGRpcmVjdG9yaWVzLCBpdCBkb2VzIG5vdCBzY2Fs
ZSB0byBkaXJlY3Rvcmllcw0KPiA+IHdpdGgNCj4gPiBtaWxsaW9ucyBvZiBlbnRyaWVzLg0KPiA+
IEluIG9yZGVyIHRvIGJlIGFibGUgdG8gZGVhbCB3aXRoIGxhcmdlIGRpcmVjdG9yaWVzIHRoYXQg
YXJlDQo+ID4gY2hhbmdpbmcsDQo+ID4gYWRkIGEgaGV1cmlzdGljIHRvIGVuc3VyZSB0aGF0IGlm
IHRoZSBwYWdlIGNhY2hlIGlzIGVtcHR5LCBhbmQgd2UNCj4gPiBhcmUNCj4gPiBzZWFyY2hpbmcg
Zm9yIGEgY29va2llIHRoYXQgaXMgbm90IHRoZSB6ZXJvIGNvb2tpZSwgd2UganVzdCBkZWZhdWx0
DQo+ID4gdG8NCj4gPiBwZXJmb3JtaW5nIHVuY2FjaGVkIHJlYWRkaXIuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tPg0KPiA+IC0tLQ0KPiA+IMKgZnMvbmZzL2Rpci5jIHwgMTcgKysrKysrKysrKysrKysrKysN
Cj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2ZzL25mcy9kaXIuYyBiL2ZzL25mcy9kaXIuYw0KPiA+IGluZGV4IDIzODg3MmQxMTZm
Ny4uZDdhOWVmZDMxZWNkIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9kaXIuYw0KPiA+ICsrKyBi
L2ZzL25mcy9kaXIuYw0KPiA+IEBAIC05MTcsMTEgKzkxNywyOCBAQCBzdGF0aWMgaW50IGZpbmRf
YW5kX2xvY2tfY2FjaGVfcGFnZShzdHJ1Y3QgDQo+ID4gbmZzX3JlYWRkaXJfZGVzY3JpcHRvciAq
ZGVzYykNCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJlczsNCj4gPiDCoH0NCj4gPiANCj4g
PiArc3RhdGljIGJvb2wgbmZzX3JlYWRkaXJfZG9udF9zZWFyY2hfY2FjaGUoc3RydWN0IA0KPiA+
IG5mc19yZWFkZGlyX2Rlc2NyaXB0b3IgKmRlc2MpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IGRlc2MtPmZpbGUtPmZfbWFwcGluZzsN
Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW5vZGUgKmRpciA9IGZpbGVfaW5vZGUoZGVzYy0+
ZmlsZSk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IGR0c2l6ZSA9IE5GU19TRVJW
RVIoZGlyKS0+ZHRzaXplOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGxvZmZfdCBzaXplID0gaV9zaXpl
X3JlYWQoZGlyKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgLyoNCj4gPiArwqDCoMKgwqDC
oMKgwqAgKiBEZWZhdWx0IHRvIHVuY2FjaGVkIHJlYWRkaXIgaWYgdGhlIHBhZ2UgY2FjaGUgaXMg
ZW1wdHksDQo+ID4gYW5kDQo+ID4gK8KgwqDCoMKgwqDCoMKgICogd2UncmUgbG9va2luZyBmb3Ig
YSBub24temVybyBjb29raWUgaW4gYSBsYXJnZQ0KPiA+IGRpcmVjdG9yeS4NCj4gPiArwqDCoMKg
wqDCoMKgwqAgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gZGVzYy0+ZGlyX2Nvb2tpZSAh
PSAwICYmIG1hcHBpbmctPm5ycGFnZXMgPT0gMCAmJg0KPiA+IHNpemUgPiANCj4gPiBkdHNpemU7
DQo+IA0KPiBpbm9kZSBzaXplID4gZHRzaXplIGlzIGEgbGl0dGxlIGhhbmQtd2F2eS7CoCBXZSBo
YXZlIGEgbG90IG9mDQo+IGN1c3RvbWVycyANCj4gdHJ5aW5nIHRvDQo+IHJldmVyc2UtZW5naW5l
ZXIgbmZzX3JlYWRkaXIoKSBiZWhhdmlvciBpbnN0ZWFkIG9mIHJlYWRpbmcgdGhlIGNvZGUsIA0K
PiB0aGlzDQo+IGlzIHN1cmUgdG8gZHJpdmUgdGhlbSBjcmF6eS4NCj4gDQo+IFRoYXQgc2FpZCwg
aW4gdGhlIGFic2VuY2Ugb2YgYW4gZWFzeSB3YXkgdG8gbWFrZSBpdCB0dW5hYmxlLCBJIGRvbid0
IA0KPiBoYXZlDQo+IGFueXRoaW5nIGJldHRlciB0byBzdWdnZXN0Lg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IEJlbmphbWluIENvZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQoNCg0KUmlnaHQu
IEl0IGlzIGEgaGV1cmlzdGljLCBidXQgSSB3b3VsZCBleHBlY3QgdGhhdCB0aGUgZGlyZWN0b3J5
IHNpemUgaXMNCmdvaW5nIHRvIGJlIHNvbWV3aGF0IHByb3BvcnRpb25hbCB0byB0aGUgbnVtYmVy
IG9mIFJQQyBjYWxscyB3ZSBuZWVkIHRvDQpwZXJmb3JtIHRvIHJlYWQgaXQuIFRoYXQgbnVtYmVy
IGFnYWluIGlzIHNvbWV3aGF0IHByb3BvcnRpb25hbCB0byB0aGUNCmR0c2l6ZS4NCg0KSU9XOiBU
aGUgZ2VuZXJhbCBpZGVhIGlzIGNvcnJlY3QuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
