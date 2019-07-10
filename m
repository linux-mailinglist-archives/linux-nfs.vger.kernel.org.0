Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4464C57
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2019 20:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGJSnb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jul 2019 14:43:31 -0400
Received: from smtp3.jd.com ([59.151.64.88]:2126 "EHLO smtp3.jd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfGJSnb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 10 Jul 2019 14:43:31 -0400
Received: from BJMAILD1MBX36.360buyAD.local (172.31.0.36) by
 BJMAILD1MBX48.360buyAD.local (172.31.0.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Thu, 11 Jul 2019 02:43:20 +0800
Received: from BJMAILD1MBX36.360buyAD.local (172.31.0.36) by
 BJMAILD1MBX36.360buyAD.local (172.31.0.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Thu, 11 Jul 2019 02:43:20 +0800
Received: from BJMAILD1MBX36.360buyAD.local ([fe80::2116:e90b:d89d:e893]) by
 BJMAILD1MBX36.360buyAD.local ([fe80::2116:e90b:d89d:e893%24]) with mapi id
 15.01.1415.002; Thu, 11 Jul 2019 02:43:20 +0800
From:   =?utf-8?B?6buE5LmQ?= <huangle1@jd.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd4: fix a deadlock on state owner replay mutex
Thread-Topic: [PATCH] nfsd4: fix a deadlock on state owner replay mutex
Thread-Index: AQHVLRYrJwxAvKxXXkKWwBVCcQfpA6bChWMAgAG9lPU=
Date:   Wed, 10 Jul 2019 18:43:20 +0000
Message-ID: <4dd1fe21e11344e5969bb112e954affb@jd.com>
References: <720b91b1204b4c73be1b6ec2ff44dbab@jd.com>,<20190710000300.GD1536@fieldses.org>
In-Reply-To: <20190710000300.GD1536@fieldses.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.31.14.12]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SXQncyBzYWZlIGJlY2F1c2Ugd2hlbiB3ZSByZWFjaCBtb3ZlX3RvX2Nsb3NlX2xydSgpLCB3ZSBr
bm93IHdlIGFyZSB0aGUNCipsb2dpY2FsKiBsYXN0IGNhbGwgYW1vbmcgYWxsIHJhY2luZyBjYWxs
cywgaXQgaXMgYWN0dWFsbHkgdGhlIHJlYXNvbiB3ZQ0KZG8gdGhlIHdhaXRpbmcgaGVyZSBhdCBm
aXN0IHBsYWNlLiAgTm93IGp1c3QgYmVjYXVzZSBvZiByYWNpbmcsIHdlIGdhaW4NCnRoZSBycF9t
dXRleCBmaXJzdCBhbmQgaGF2ZSBhICpsb3dlciogc2VxaWQgdmFsdWUsIHNvIGl0IGlzIHdoYXQg
d2UgbmVlZA0KZXhhY3RseSB0byBsZXQgdGhlIHNlcWlkIGJ1bXAgd2l0aCBvdGhlciByYWNpbmcg
Y2FsbHMgYmVmb3JlIHdlIGNvbnRpbnVlLA0KdGhhdCBlbnN1cmVzIHBvc3NpYmxlIGZ1dHVyZSBD
TE9TRSBjYWxsIGNvdWxkIGJlIHJlcGxheWVkIGNvcnJlY3RseS4NCg0KDQpPbiBXZWQsIEp1bCAx
MCwgMjAxOSwgYmZpZWxkc0BmaWVsZHNlcy5vcmcgd3JvdGU6DQo+IEkgZG9uJ3QgdW5kZXJzdGFu
ZCB3aHkgdGhhdCdzIHNhZmUuwqAgTWF5YmUgaXQgaXMsIGJ1dCBJIGRvbid0IHVuZGVyc3RhbmQN
Cj4geWV0LsKgIElmIHdlIHRha2UgdGhlIG11dGV4LCBidW1wIHRoZSBzZXFpZCwgZHJvcCB0aGUg
bXV0ZXgsIHNvbWVvbmUgZWxzZQ0KPiBjb21lcyBpbiBhbmQgYnVtcHMgdGhlIHNlcWlkIGFnYWlu
LCB0aGVuIHdlIHJlYWNxdWlyZSB0aGUgbXV0ZXguLi4gd2hhdA0KPiBoYXBwZW5zPw0KPiANCj4g
LS1iLg0K
