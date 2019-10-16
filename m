Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2A9D8522
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 03:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbfJPBAd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 21:00:33 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30014 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbfJPBAd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Oct 2019 21:00:33 -0400
X-IronPort-AV: E=Sophos;i="5.67,301,1566835200"; 
   d="scan'208";a="77023489"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Oct 2019 09:00:31 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 14C874CE14F4;
        Wed, 16 Oct 2019 09:00:10 +0800 (CST)
Received: from G08CNEXMBPEKD03.g08.fujitsu.local ([10.167.33.86]) by
 G08CNEXCHPEKD03.g08.fujitsu.local ([10.167.33.85]) with mapi id
 14.03.0439.000; Wed, 16 Oct 2019 09:00:26 +0800
From:   "Su, Yanjun" <suyj.fnst@cn.fujitsu.com>
To:     "trondmy@gmail.com" <trondmy@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: About patch NFS: Fix O_DIRECT accounting of number of bytes
 read/written
Thread-Topic: About patch NFS: Fix O_DIRECT accounting of number of bytes
 read/written
Thread-Index: AdWDupUDFq5cvVv1QGGoMCLng+/bzA==
Date:   Wed, 16 Oct 2019 01:00:30 +0000
Message-ID: <9608C5E5429A7846A89FDA46D5296B97334E3824@G08CNEXMBPEKD03.g08.fujitsu.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.167.226.33]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 14C874CE14F4.AEBB8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgdHJvbmQsDQpCZWNhdXNlIE15IG1haWwgc3lzdGVtIGNhbnQgcmVjZWl2
ZSBuZnMgbWFpbCBsaXN0oa9zIG1haWxzLCBJIHJlcGx5IHlvdXIgcGF0Y2gg
aGVyZS4NCkkgaGF2ZSBzb21lIHF1ZXN0aW9uIGZvciB0aGUgcGF0Y2guDQoN
Cj5Oby4gQmFzaWMgT19ESVJFQ1QgZG9lcyBub3QgZ3VhcmFudGVlIGF0b21p
Y2l0eSBvZiByZXF1ZXN0cywgd2hpY2ggaXMNCj53aHkgd2UgZG8gbm90IGhh
dmUgZ2VuZXJpYyBsb2NraW5nIGF0IHRoZSBWRlMgbGV2ZWwgd2hlbiByZWFk
aW5nIGFuZA0KPndyaXRpbmcuIFRoZSBvbmx5IGd1YXJhbnRlZSBiZWluZyBv
ZmZlcmVkIGlzIHRoYXQgT19ESVJFQ1QgYW5kIGJ1ZmZlcmVkDQo+d3JpdGVz
IGRvIG5vdCBjb2xsaWRlLg0KRG8geW91IG1lYW4gb3RoZXIgZnMgYWxzbyBj
YW50IGd1YXJhbnRlZSBhdG9taWNpdHkgb2YgT19ESVJFQ1QgcmVxdWVzdCBv
ciBqdXN0IG5mcz8NCg0KPklPVzogSSB0aGluayB0aGUgYmFzaWMgcHJlbWlz
ZSBmb3IgdGhpcyB0ZXN0IGlzIGp1c3QgYnJva2VuIChhcyBJDQo+Y29tbWVu
dGVkIGluIHRoZSBwYXRjaCBzZXJpZXMgSSBzZW50KSBiZWNhdXNlIGl0IGlz
IGFzc3VtaW5nIGENCj5iZWhhdmlvdXIgdGhhdCBpcyBzaW1wbHkgbm90IGd1
YXJhbnRlZWQuDQpTbyB0aGUgZ2VuZXJpYy80NjUgb2YgeGZzdGVzdHMgY2Fu
oa90IGFwcGx5IHRvIG5mcyBmb3Igbm93LCBhbSBJIHJpZ2h0Pw0KDQo+QlRX
OiBub3RlIHRoYXQgYnVmZmVyZWQgd3JpdGVzIGhhdmUgdGhlIHNhbWUgcHJv
cGVydHkuIFRoZXkgYXJlIG9yZGVyZWQNCj53aGVuIGJlaW5nIHdyaXR0ZW4g
aW50byB0aGUgcGFnZSBjYWNoZSwgbWVhbmluZyB0aGF0IHJlYWRzIG9uIHRo
ZSBzYW1lDQo+Y2xpZW50IHdpbGwgc2VlIG5vIGhvbGVzLCBob3dldmVyIGlm
IHlvdSB0cnkgdG8gcmVhZCBmcm9tIGFub3RoZXINCj5jbGllbnQsIHRoZW4g
eW91IHdpbGwgc2VlIHRoZSBzYW1lIGJlaGF2aW91ciwgd2l0aCB0ZW1wb3Jh
cnkgaG9sZXMNCj5tYWdpY2FsbHkgYXBwZWFyaW5nIGluIHRoZSBmaWxlLg0K
QXMgeW91IHNheSwgbmZzIGJ1ZmZlcmVkIHdyaXRlIGFsc28gaGFzIHRoZSBo
b2xlIHByb2JsZW0gd2l0aCBtdWx0aXBsZSByL3cgb24gZGlmZmVyZW50IGNs
aWVudHMuDQpJIHdhbnQgdG8ga25vdyBpZiB0aGUgcHJvYmxlbSBleGlzdHMg
aW4gb3RoZXIgbG9jYWwgZnMgc3VjaCBhcyB4ZnMsZXh0ND8NCg0KVGhhbmtz
IGluIGFkdmFuY2UuDQoKCg==
