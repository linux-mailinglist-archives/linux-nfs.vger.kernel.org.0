Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5222E44DAD1
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Nov 2021 17:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhKKQ5S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Nov 2021 11:57:18 -0500
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.123]:56854 "EHLO
        xiaomi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229539AbhKKQ5S (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Nov 2021 11:57:18 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Nov 2021 11:57:18 EST
Received: from BJ-MBX02.mioffice.cn (10.237.8.122) by HK-MBX03.mioffice.cn
 (10.56.8.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 12 Nov 2021
 00:39:18 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX02.mioffice.cn
 (10.237.8.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 12 Nov 2021
 00:39:18 +0800
Received: from BJ-MBX01.mioffice.cn ([::1]) by BJ-MBX01.mioffice.cn
 ([fe80::840f:e91a:2517:14d5%9]) with mapi id 15.02.0986.009; Fri, 12 Nov 2021
 00:39:18 +0800
From:   =?gb2312?B?s8zR8w==?= <chengyang@xiaomi.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: nfs hang bugs
Thread-Topic: nfs hang bugs
Thread-Index: AdfXGKZZEGN92FvlTmSq+6WLaIGDTg==
Date:   Thu, 11 Nov 2021 16:39:18 +0000
Message-ID: <dd15ba35692346c1b170f993cb52b164@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkuIEknbSBhbiBzZXJ2ZXIgZW5naW5lZXIgd2hvIGhvbGQgZ2Vycml0IHNlcnZlcnMuIEFuZCB1
c2VzIG5mcyBhcyBteSBoYXJkZGlzay4NClNvbWUgdGltZSBJIGZvdW5kIHdoZW4gSSBydW4gYGdp
dCBwYWNrLXJlZnNgLCBpdCB3aWxsIGhhbmcsIGFuZCBpdCBjYXVzZXMgZGVhZGxvY2sgaW4ga2Vy
bmVsLCBwcmV2ZW50IG90aGVyIGZzIGNvbW1hbmQgdG8gZXhlY3V0ZSBsaWtlIGBsc2ANClByZXR0
eSBtdWNoIGxpa2UgdGhpcywgYnV0IG5vdCB0aGUgc2FtZSBpc3N1ZS4gIGh0dHBzOi8vYWJvdXQu
Z2l0bGFiLmNvbS9ibG9nLzIwMTgvMTEvMTQvaG93LXdlLXNwZW50LXR3by13ZWVrcy1odW50aW5n
LWFuLW5mcy1idWcvDQoNClNpbmNlIEknbSBuZXcgdG8gTkZTLCBJIGRvbid0IGtub3cgd2hhdCBl
bHNlIGNhbiBJIHByb3ZpZGUuIElmIHRoZXJlIGFueXdheSB0byBnZXQgbW9yZSBkZWJ1ZyBpbmZv
cm1hdGlvbiwgcGxlYXNlIGZlZWwgZnJlZSB0byBhc2sgbWUuDQoNCk15IE5GUyBzZXJ2ZXI6IFVi
dW50dSAxNi4wNA0KTXkgTkZTIGNsaWVudDogVWJ1bnR1IDE4LjA0DQoNCg0KYGdpdCBwYWNrLXJl
ZnMgc3RyYWNlYA0Kd3JpdGUoMywgInVzZXJzLzk0LzEwMDMwOTRcbjg4Njc0MTgxN2MxZDgyNCIu
Li4sIDgxOTIpID0gODE5Mg0Kd3JpdGUoMywgImVycy85NS8xMDA2Nzk1XG43ZWM5NWY2YWQ3NzJm
NmQ2MyIuLi4sIDgxOTIpID0gODE5Mg0Kd3JpdGUoMywgInMvOTYvMTAxMTE5NlxuNWUzMTBiZjg0
OTEyNzZhNmE4ZCIuLi4sIDgxOTIpID0gODE5Mg0Kd3JpdGUoMywgIjk4LzEwMDA5OThcbjNlMWYx
NzdmMDQyN2U3YWE3OTA2NSIuLi4sIDgxOTIpID0gODE5Mg0Kd3JpdGUoMywgIi8xMDA0ODk5XG4x
NGU1NzJiMDViM2JiODU3ZDE0ZDk5MCIuLi4sIDM3MjYpID0gMzcyNg0KY2xvc2UoMykgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgID0gMA0KYWNjZXNzKCJob29rcy9yZWZlcmVuY2UtdHJh
bnNhY3Rpb24iLCBYX09LKSA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkN
Cm11bm1hcCgweDdmN2MyZWY1YjAwMCwgMzkwMzExOCkgICAgICAgICA9IDANCnJlbmFtZSgiL2hv
bWUvd29yay9yZXBvc2l0b3JpZXMvbWl1aS9BbGwtVXNlcnMuZ2l0Ly4vcGFja2VkLXJlZnMubmV3
IiwgIi9ob21lL3dvcmsvcmVwb3NpdG9yaWVzL21pdWkvQWxsLVVzZXJzLmdpdC8uL3BhY2tlZC1y
ZWZzIg0KDQpgZ2l0IHBhY2stcmVmcyBrZXJuZWwgc3RhY2tgDQpbPDA+XSBycGNfd2FpdF9iaXRf
a2lsbGFibGUrMHgyNC8weGEwIFtzdW5ycGNdDQpbPDA+XSBfX3JwY193YWl0X2Zvcl9jb21wbGV0
aW9uX3Rhc2srMHgyZC8weDMwIFtzdW5ycGNdDQpbPDA+XSBuZnNfcmVuYW1lKzB4YzUvMHgzMTAg
W25mc10NCls8MD5dIHZmc19yZW5hbWUrMHgzZGMvMHhhODANCls8MD5dIGRvX3JlbmFtZWF0Misw
eDRjYS8weDU5MA0KWzwwPl0gX194NjRfc3lzX3JlbmFtZSsweDIwLzB4MzANCls8MD5dIGRvX3N5
c2NhbGxfNjQrMHg1Ny8weDE5MA0KWzwwPl0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
KzB4NDQvMHhhOQ0KDQoNCmBsc2Agc3RyYWNlOg0KLi4uLi4uDQouLi4uLg0KbW1hcChOVUxMLCAx
NjgzMDU2LCBQUk9UX1JFQUQsIE1BUF9QUklWQVRFLCAzLCAwKSA9IDB4N2Y2MzI1MWIwMDAwDQpj
bG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwDQppb2N0bCgxLCBUQ0dF
VFMsIHtCMzg0MDAgb3Bvc3QgaXNpZyBpY2Fub24gZWNobyAuLi59KSA9IDANCmlvY3RsKDEsIFRJ
T0NHV0lOU1osIHt3c19yb3c9MzMsIHdzX2NvbD0xMTMsIHdzX3hwaXhlbD0wLCB3c195cGl4ZWw9
MH0pID0gMA0Kb3BlbmF0KEFUX0ZEQ1dELCAiLiIsIE9fUkRPTkxZfE9fTk9OQkxPQ0t8T19DTE9F
WEVDfE9fRElSRUNUT1JZKSA9IDMNCmZzdGF0KDMsIHtzdF9tb2RlPVNfSUZESVJ8MDc1NSwgc3Rf
c2l6ZT00MDk2LCAuLi59KSA9IDANCmdldGRlbnRzKDMNCg0KYGxzIGtlcm5lbCBzdGFja2A6DQpb
PDA+XSByd3NlbV9kb3duX3dyaXRlX3Nsb3dwYXRoKzB4MjNkLzB4NGMwDQpbPDA+XSBpdGVyYXRl
X2RpcisweDEyNi8weDFiMA0KWzwwPl0gX194NjRfc3lzX2dldGRlbnRzKzB4YWIvMHgxNDANCls8
MD5dIGRvX3N5c2NhbGxfNjQrMHg1Ny8weDE5MA0KWzwwPl0gZW50cnlfU1lTQ0FMTF82NF9hZnRl
cl9od2ZyYW1lKzB4NDQvMHhhOQ0KDQojLyoqKioqKrG+08q8/rywxuS4vbz+uqzT0NChw9e5q8u+
tcSxo8Pc0MXPoqOsvfbP3tPat6LLzbj4yc/D5rXY1rfW0MHQs/a1xLj2yMu78si61+mho7371rnI
zrrOxuTL+8jL0tTIzrrO0M7Kvcq508OjqLD8wKi1q7K7z97T2sirsr+78rK/t9a12NC5wrahori0
1sahorvyyaK3oqOpsb7Tyrz+1tC1xNDFz6Kho8jnufvE+rTtytXBy7G+08q8/qOsx+vE+sGivLS1
57uwu/LTyrz+zajWqreivP7Iy7Kiyb6z/bG+08q8/qOhIFRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0
YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBYSUFPTUksIHdo
aWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJl
c3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQg
aGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBv
ciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkg
cGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRl
ZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhl
IHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0ISoqKioq
Ki8jDQo=
