Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766CF1421F8
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2020 04:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgATD1e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Jan 2020 22:27:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56352 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729011AbgATD1e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Jan 2020 22:27:34 -0500
X-IronPort-AV: E=Sophos;i="5.70,340,1574092800"; 
   d="scan'208";a="82292460"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Jan 2020 11:27:32 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 84431406AB15;
        Mon, 20 Jan 2020 11:18:18 +0800 (CST)
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 20 Jan 2020 11:27:28 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local ([fe80::4049:4fec:8ba2:a0e4])
 by G08CNEXMBPEKD05.g08.fujitsu.local ([fe80::4049:4fec:8ba2:a0e4%14]) with
 mapi id 15.00.1395.000; Mon, 20 Jan 2020 11:27:30 +0800
From:   "Su, Yanjun" <suyj.fnst@cn.fujitsu.com>
To:     "ffilzlnx@mindspring.com" <ffilzlnx@mindspring.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "dang@redhat.com" <dang@redhat.com>,
        "calum.mackay@oracle.com" <calum.mackay@oracle.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
Thread-Topic: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
Thread-Index: AdXJsIQXuaZ2SnxFRGWSi1yoPcHO9wFkDDSQ
Date:   Mon, 20 Jan 2020 03:27:30 +0000
Message-ID: <bf92e0f0d4cb42d3803a95a513426d00@G08CNEXMBPEKD05.g08.fujitsu.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.167.226.33]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 84431406AB15.A9407
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgRnJhbmsNCg0KV2UgaGF2ZW4ndCBjb250YWN0ZWQgZm9yIGEgbG9uZyB0
aW1lLiBMZXQncyBzb3J0IG91dCB0aGUgcHJvYmxlbS4gVGhlIGRldGFpbHMg
YXJlIGFzIGZvbGxvd3M6DQoNCldlIHRlc3RlZCB0aGUgcHluZnMgb2YgTkZT
djQuMCBvbiB0aGUgbGF0ZXN0IHZlcnNpb24gb2YgdGhlIGtlcm5lbCg1LjIu
MC1yYzcpLg0KSSBlbmNvdW50ZXJlZCBhIHByb2JsZW0gd2hpbGUgdGVzdGlu
ZyBzdF9sb2NrLnRlc3RPcGVuVXBncmFkZUxvY2suDQpUaGUgcHJvYmxlbSBp
cyBub3cgYXMgZm9sbG93czoNCioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqDQpMT0NLMjQgc3RfbG9jay50ZXN0
T3BlblVwZ3JhZGVMb2NrIDogRkFJTFVSRQ0KICAgICAgICAgICAgT1BfTE9D
SyBzaG91bGQgcmV0dXJuIE5GUzRfT0ssIGluc3RlYWQgZ290DQogICAgICAg
ICAgICBORlM0RVJSX0JBRF9TRVFJRA0KKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCg0KVGhlIGNhc2UgaXMg
YXMgZm9sbG93czoNCkRlZiB0ZXN0T3BlblVwZ3JhZGVMb2NrKHQsIGVudik6
DQogICAgICIiIlRyeSBvcGVuLCBsb2NrLCBvcGVuLCBkb3duZ3JhZGUsIGNs
b3NlDQoNCiAgICAgRkxBR1M6IGFsbCBsb2NrDQogICAgIENPREU6IExPQ0sy
NA0KICAgICAiIiINCiAgICAgYz0gZW52LmMxDQogICAgIEMuaW5pdF9jb25u
ZWN0aW9uKCkNCiAgICAgT3MgPSBvcGVuX3NlcXVlbmNlKGMsIHQuY29kZSwg
bG9ja293bmVyPSJsb2Nrb3duZXJfTE9DSzI0IikNCiAgICAgT3Mub3BlbihP
UEVONF9TSEFSRV9BQ0NFU1NfUkVBRCkNCiAgICAgT3MubG9jayhSRUFEX0xU
KQ0KICAgICBPcy5vcGVuKE9QRU40X1NIQVJFX0FDQ0VTU19XUklURSkNCiAg
ICAgT3MudW5sb2NrKCkNCiAgICAgT3MuZG93bmdyYWRlKE9QRU40X1NIQVJF
X0FDQ0VTU19XUklURSkNCiAgICAgT3MubG9jayhXUklURV9MVCkNCiAgICAg
T3MuY2xvc2UoKQ0KDQpBZnRlciBpbnZlc3RpZ2F0aW9uLCB0aGVyZSB3YXMg
YW4gZXJyb3IgaW4gdW5sb2NrLT5sb2NrLiBXaGVuDQp1bmxvY2tpbmcsIHRo
ZSBsb2Nrb3duZXIgb2YgdGhlIGZpbGUgd2FzIG5vdCByZWxlYXNlZCwgY2F1
c2luZyBhbg0KZXJyb3Igd2hlbiBsb2NraW5nIGFnYWluLg0KDQpXZSBtb2Rp
ZmllZCB0aGUgY2FzZSBhY2NvcmRpbmcgdG8gQ2FsdW0gTWFja2F5J3Mgc3Vn
Z2VzdGlvbiAoc2V0IHRoZSBwYXJhbWV0ZXIgbGtfaXNfbmV3IGluIHRoZSBz
ZWNvbmQgbG9jayB0byBGQUxTRSkNCmFuZCB0aGUgdGVzdCByZXN1bHQgcGFz
c2VkLg0KQ2FuIHlvdSB0ZWxsIG1lIGlmIHRoaXMgbW9kaWZpY2F0aW9uIGlz
IGNvcnJlY3Sjvw0KDQpBbmQgdGhlIHByZXZpb3VzIGRpc2N1c3Npb24gaXMg
aGVyZS4NCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LW5m
cy9tc2c3NjA2MS5odG1sDQoNCgoK
