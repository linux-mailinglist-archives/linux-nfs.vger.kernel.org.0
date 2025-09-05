Return-Path: <linux-nfs+bounces-14063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323EEB456DB
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29523BC54A
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1321D6DA9;
	Fri,  5 Sep 2025 11:50:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cirse-smtp-out.extra.cea.fr (cirse-smtp-out.extra.cea.fr [132.167.192.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004C32275E
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.167.192.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073049; cv=none; b=jfilB7POs/XCs7Wa04FZdX6j5I+gPZCFqK9EGJDEdpGNO7AK3JAx1mMhe4GtJ3TujGMhRuTRIo+iXZgJABWGE21vKfl3uB1nXGquM2eIy0/0ECB6o2c6Pp4nGwFE8di15MfAXjZOzJ40rpP4Xs38aFbdzSirpklj6dZAv+oBawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073049; c=relaxed/simple;
	bh=Gu6fBoko4TI5xEnz9JaxBrLASebYj3HgzPu83iBG40Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kL9SPuODM5lcLjxjTaTcwcK4J13Xo1bHkCHD/spxo8S7G1tPMiao9ojV1iy4gKNAhN/eUTQ3FSVmzQXWSeRc8HEKpXcUuNObmP/Q76v5ZegHKuH3Q42a8BWdL3Qf00SAll6k28n7dyiOmwgyKIm3J9VOrRj0pZCZhUM+KXjj3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cea.fr; spf=pass smtp.mailfrom=cea.fr; arc=none smtp.client-ip=132.167.192.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cea.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cea.fr
Received: from e-emp-b0.extra.cea.fr (e-emp-b0.extra.cea.fr [132.167.198.36])
	by cirse-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP id 585BiYfq018963
	for <linux-nfs@vger.kernel.org>; Fri, 5 Sep 2025 13:44:34 +0200
Received: from pps.filterd (e-emp-b0.extra.cea.fr [127.0.0.1])
	by e-emp-b0.extra.cea.fr (8.18.1.2/8.18.1.2) with ESMTP id 5858YPQa014412
	for <linux-nfs@vger.kernel.org>; Fri, 5 Sep 2025 13:44:34 +0200
Received: from muguet1-smtp-out.intra.cea.fr (muguet1-smtp-out.intra.cea.fr [132.166.192.12])
	by e-emp-b0.extra.cea.fr (PPS) with ESMTP id 48yc2gvxp7-1
	for <linux-nfs@vger.kernel.org>; Fri, 05 Sep 2025 13:44:34 +0200 (MEST)
Received: from I-EXCH-A0.intra.cea.fr (i-exch-a0.intra.cea.fr [132.166.88.224])
	by muguet1-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP id 585BiY0m024323
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nfs@vger.kernel.org>; Fri, 5 Sep 2025 13:44:34 +0200
Received: from I-EXCH-B5.intra.cea.fr (132.166.88.239) by
 I-EXCH-A0.intra.cea.fr (132.166.88.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 5 Sep 2025 13:44:33 +0200
Received: from I-EXCH-B5.intra.cea.fr ([132.166.88.239]) by
 I-EXCH-B5.intra.cea.fr ([132.166.88.239]) with mapi id 15.01.2507.044; Fri, 5
 Sep 2025 13:44:33 +0200
From: BURLOT Alan <Alan.BURLOT@cea.fr>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: nfs4_getfacl error code when directory is not managed by nfs4 acl
Thread-Topic: nfs4_getfacl error code when directory is not managed by nfs4
 acl
Thread-Index: AQHcHlpyV8sTbwU1zUSfDmUeeLyfxQ==
Date: Fri, 5 Sep 2025 11:44:33 +0000
Message-ID: <9b184eb27d7a817a5744c281d00bf61126fb3f05.camel@cea.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-28344.000
x-tm-as-result: No-10--7.588300-8.000000
x-tmase-matchedrid: 53GNlzVSQfQtC1eAkW8MEi0rAbu/h0p4zWee1Tq8TTScU9LnAKOkdsvl
	XMsLszNRV/PvpAMTDp+I47i1GQb7nRj1uEat0f0Xhi2C7dlNKWo6Cu19Vtgyg1neta0u1SLmKWT
	y9F4rvtarIlKVCUxgvN5pHhRZTbY0swRgP3pwMhKgv0YmK8fzs1hyKam0/n7NMLjTaDguNi8cRW
	BUt01WAdD6xLvX4M4IufbuusDOL+I0zI7+eiZZ8AeaHjl8u7Jkdi8q9VnfX1WZKY7DwlCIgt6Kv
	NQiJN/3MnVa/9k0lMA=
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--7.588300-8.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-28344.000
x-tm-snts-smtp: 1C68E7363D33B61E42E6ADEFB8D1DF1538F14BCB819FC178C255D24F76AF45A02000:8
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC4E8AD19102A947BFD50DFF248E4612@cea.fr>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: y-macjVSluwgM-b7wAgRZjSsC_oAaEDf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDExNSBTYWx0ZWRfX057jXwNk6Ig1 wtMm2BhdImT+j2z35V4SsMsIjVMAJRaRr8hKahFwg5qgGr6t6IOugWMPjaOSQtUdIsSsRelaH8u yiSIrYHBK2uiOpwwYcx3Orb4pEuHhcg2rxaoIpTnSBNeazzRznVDOjFAItV8iIYykv44RkC5xFR
 5RAV51BvxDnIco/7tuxjLj42XpfsR/XlJxt/x/0Pr4SdyJLzPv40pYf6qjziI7PshNXA+7MHoMU MV4eFkrElO2PhE3++nDW3ak1+SEZ6GiCF+sFzR0MrVTDpLniM7b79qSbh7z8M6CpUVB6DdHwD4h 7HAKiYKPPMmUFjuZGBNeFyAoeev7DIu+HqW5QzF9kPiAED3qDI9eNYpQE/XH2+fjP9Jw20kbdzd qLX2wiXp
X-Proofpoint-ORIG-GUID: y-macjVSluwgM-b7wAgRZjSsC_oAaEDf

SGVsbG8sDQoNCkkgYW0gdHJ5aW5nIHRvIGFkZCBhIHNtYWxsIHRlc3QgaW4gYSBzY3JpcHQgdG8g
Y2hlY2sgaWYgYSBkaXJlY3RvcnkgaXMNCm1hbmFnZWQgYnkgbmZzNF9zZXRmYWNsIG9yIG5vdC4g
VGhlIHN5c3RlbSBJIHdvcmsgd2l0aCB1c2Ugc29tZXRpbWVzDQpuZnM0X3NldGZhY2wgYW5kIHNv
bWV0aW1lcyBzZXRmYWNsLiBJIHdhbnRlZCB0byB0cnkgYSBxdWlldA0KYG5mczRfZ2V0ZmFjbCAu
YCB0byBjaGVjayBpdC4gQnV0IHdoZW4gSSBkbyANCiAgICA+IGlmIG5mczRfZ2V0ZmFjbCAuID4v
ZGV2L251bGwgMj4mMTsgdGhlbiBlY2hvICJ5ZXAgbmZzNCI7IGVsc2UNCmVjaG8gIm5vIjsgZmkN
Cg0KSSBvYnRhaW4NCiAgICB5ZXAgbmZzNA0KDQpXaXRob3V0IHRoZSAyPiYxLCBJIGhhdmUNCiAg
ICA+IGlmIG5mczRfZ2V0ZmFjbCAuID4vZGV2L251bGw7IHRoZW4gZWNobyAieWVwIG5mczQiOyBl
bHNlIGVjaG8NCiJubyI7IGZpDQogICAgT3BlcmF0aW9uIHRvIHJlcXVlc3QgYXR0cmlidXRlIG5v
dCBzdXBwb3J0ZWQ6IC4NCiAgICB5ZXAgbmZzNA0KDQpXaGVuIEkgdHJ5IHRvIGdyZXAgaXQsIGl0
IGRvZXMgbm90IHdvcmsNCiAgICA+IG5mczRfZ2V0ZmFjbCAuID4vZGV2L251bGwgfCBncmVwIC1x
ICJub3Qgc3VwcG9ydGVkIg0KICAgIE9wZXJhdGlvbiB0byByZXF1ZXN0IGF0dHJpYnV0ZSBub3Qg
c3VwcG9ydGVkOiAuDQoNClRoZSByZXR1cm4gY29kZSBpcyBhbHdheXMgemVybw0KICAgID4gbmZz
NF9nZXRmYWNsIC4gOyBlY2hvICQ/DQogICAgT3BlcmF0aW9uIHRvIHJlcXVlc3QgYXR0cmlidXRl
IG5vdCBzdXBwb3J0ZWQ6IC4NCiAgICAwDQoNCkkgd2FudCBpdCB0byBiZSBxdWlldCB0byBhdm9p
ZCBzaG93aW5nIHNvbWV0aGluZyBpbiB0aGUgdGVybWluYWwuIEkgYW0NCmRvaW5nIGEgc2NyaXB0
IHRvIGVhc2lseSBzZXQgQUNMcyBmb3Igbm9uZSBiYXNoIHBvd2VyIHVzZXIgYW5kIEkgZG8gbm90
DQp3YW50IHRvIHNjYXJlIHRoZW0gd2l0aCBlcnJvciBtZXNzYWdlLg0KDQpBbSBJIG1pc3Npbmcg
c29tZXRoaW5nIGFib3V0IHRoZSByZXR1cm4gY29kZT8gV291bGQgaXQgYmUgcG9zc2libGUgdG8N
CmFkZCBhIC0tdGVzdCBvciAtLWNoZWNrIG9wdGlvbiB0byB0ZXN0IGlmIG5mczQtYWNsIGFyZSBh
Y3R1YWxseSB1c2VkIGluDQp0aGUgZGlyZWN0b3J5Pw0KDQpJIGNhbiBkbyB0ZXN0IGlmIHlvdSB3
YW50LiBEbyB5b3Uga25vdyB3aGljaCByZXBvIGhhcyB0aGUgbGF0ZXN0IHNvdXJjZQ0KY29kZSBp
ZiBJIHdhbnQgdG8gdHJ5IHNvbWV0aGluZyBteXNlbGY/DQoNCkJlc3QgcmVnYXJkcywNCkFsYW4N
Ci0tIA0KQWxhbiBCdXJsb3QsIFBoRA0KQ0VBIFBhcmlzLVNhY2xheQ0KL0NFQS9ERVMvSVNBUy9E
TTJTL1NUTUYvTERFTA0K

