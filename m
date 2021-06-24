Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4E3B2464
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 03:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFXBLE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 21:11:04 -0400
Received: from unicom146.biz-email.net ([210.51.26.146]:1546 "EHLO
        unicom146.biz-email.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXBLE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 21:11:04 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 21:11:03 EDT
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((LNX1044)) with ASMTP (SSL) id RXA00137;
        Thu, 24 Jun 2021 09:02:37 +0800
Received: from jtjnmail201620.home.langchao.com (10.100.2.20) by
 jtjnmail201623.home.langchao.com (10.100.2.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 24 Jun 2021 09:02:37 +0800
Received: from jtjnmail201620.home.langchao.com ([fe80::24f6:b8e5:a824:6a6b])
 by jtjnmail201620.home.langchao.com ([fe80::24f6:b8e5:a824:6a6b%17]) with
 mapi id 15.01.2176.014; Thu, 24 Jun 2021 09:02:37 +0800
From:   =?gb2312?B?SmFtZXMgRG9uZyAotq3KwL2tKQ==?= <dongshijiang@inspur.com>
To:     Petr Vorel <pvorel@suse.cz>
CC:     "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        Steve Dickson <SteveD@redhat.com>,
        "libtirpc-devel@lists.sourceforge.net" 
        <libtirpc-devel@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [LTP] [PATCH] fix rpc_suite/rpc:add check returned value
Thread-Topic: [LTP] [PATCH] fix rpc_suite/rpc:add check returned value
Thread-Index: AddolBJx4eueXHxIsE+jfZ2y41B5ZA==
Date:   Thu, 24 Jun 2021 01:02:37 +0000
Message-ID: <92ed4ea616c14205b30f14f0caf26c95@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.72.58.101]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
tUid:   2021624090238d4a36d916cb7c972d836c0fbb51f648e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgUGV0cg0KDQpNeSB0ZXN0IGVudmlyb25tZW50IGlzIGNlbnRvczguMiwga2VybmVsIHZlcnNp
b24gaXMgNC4xOCAoQ2VudE9TLTguMi4yMDA0LXg4Nl82NC1kdmQxLmlzbykNCkZvciBleGFtcGxl
Og0KCXN2Y3IgPSBzdmNmZF9jcmVhdGUoZmQsIDAsIDApOw0KCS8vVGhlbiBjYWxsIGRlc3Ryb3kg
bWFjcm8NCglzdmNfZGVzdHJveShzdmNyKTsNCg0KSWYgInN2Y2ZkX2NyZWF0ZSIgZmFpbHMsIHRo
YXQgaXMsIHRoZSByZXR1cm4gdmFsdWUgaXMgTlVMTCBhbmQgdGhlbiBjYWxsICJzdmNfZGVzdHJv
eSIgd2lsbCByZXBvcnQgYW4gZXJyb3IgIlNlZ21lbnRhdGlvbiBmYXVsdCINCg0KS2luZCByZWdh
cmRzLA0KRG9uZw0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogUGV0ciBWb3JlbCBbbWFp
bHRvOnB2b3JlbEBzdXNlLmN6XSANCreiy83KsbzkOiAyMDIxxOo21MIyNMjVIDA6MDcNCsrVvP7I
yzogSmFtZXMgRG9uZyAotq3KwL2tKSA8ZG9uZ3NoaWppYW5nQGluc3B1ci5jb20+DQqzrcvNOiBs
dHBAbGlzdHMubGludXguaXQ7IEFsZXhleSBLb2RhbmV2IDxhbGVrc2VpLmtvZGFuZXZAYmVsbC1z
dy5jb20+OyBTdGV2ZSBEaWNrc29uIDxTdGV2ZURAcmVkaGF0LmNvbT47IGxpYnRpcnBjLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0K1vfM4jog
UmU6IFtMVFBdIFtQQVRDSF0gZml4IHJwY19zdWl0ZS9ycGM6YWRkIGNoZWNrIHJldHVybmVkIHZh
bHVlDQoNCkhpIERvbmcsDQoNCj4gSGkgUGV0cg0KPiBJIHRoaW5rIHRoaXMgaXMganVzdCBhIHNp
bXBsZSB0ZXN0IG9mIHNvbWUgQVBJcywgYnV0IHNvbWUgdGVzdCBjYXNlcyBhcmUgbm90IHN0YW5k
YXJkaXplZCBhbmQgY2F1c2UgZXJyb3JzIGxpa2UgIlNlZ21lbnRhdGlvbiBmYXVsdCIgZHVyaW5n
IHRlc3RpbmcuIEkgdGhpbmsgaXQgaXMgbmVjZXNzYXJ5IHRvIGZpeCB0aGVzZSBlcnJvcnMgb3Ig
ZGVsZXRlIHRoZXNlIHRlc3RzLg0KDQpTdXJlIHRoaXMgZml4IGNhbiBnZXQgaW4uIEkgc2F3IGlz
c3VlcyB3aXRoIHNvbWUgdGVzdHMgb24gb3BlblNVU0UsIGJ1dCB0aGF0J3MgYSBzZXBhcmF0ZSBw
cm9ibGVtIChJIHdhcyBub3QgYWJsZSB0byBmaW5kIHRoZSBwcm9ibGVtIHRodXMgcmVwb3J0IGl0
Lg0KDQo+IEtpbmQgcmVnYXJkcywNCj4gRG9uZw0KDQo+ID4gKysrIGIvdGVzdGNhc2VzL25ldHdv
cmsvcnBjL3JwYy10aXJwYy90ZXN0c19wYWNrL3JwY19zdWl0ZS9ycGMvcnBjX2MNCj4gPiArKysg
cmVhdGVkZXN0cm95X3N2Y19kZXN0cm95L3JwY19zdmNfZGVzdHJveS5jDQo+ID4gQEAgLTQ2LDYg
KzQ2LDExIEBAIGludCBtYWluKHZvaWQpDQoNCj4gPiAgCS8vRmlyc3Qgb2YgYWxsLCBjcmVhdGUg
YSBzZXJ2ZXINCj4gPiAgCXN2Y3IgPSBzdmNmZF9jcmVhdGUoZmQsIDAsIDApOw0KPiA+ICsNCj4g
PiArCS8vY2hlY2sgcmV0dXJuZWQgdmFsdWUNCj4gPiArCWlmICgoU1ZDWFBSVCAqKSBzdmNyID09
IE5VTEwpIHsNCklNSE8gY2FzdGluZyBpcyBub3QgcmVxdWlyZWQsIHJpZ2h0PyBKdXN0DQoJaWYg
KHN2Y3IgPT0gTlVMTCkgew0KDQpLaW5kIHJlZ2FyZHMsDQpQZXRyDQo=
