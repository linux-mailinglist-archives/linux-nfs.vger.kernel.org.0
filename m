Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C553A5965
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jun 2021 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhFMPin (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Jun 2021 11:38:43 -0400
Received: from mail-bn1nam07on2099.outbound.protection.outlook.com ([40.107.212.99]:20110
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231887AbhFMPim (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 13 Jun 2021 11:38:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR+wkOOop+mnYpEl8G1yuCcgElAoqA3njdOK+6jnjybPRlvFmTPLrpXI9MbsvoGbkKKaq9Ya/RXxgUiRaiI4poty9L4NLMjDBwfNwEDYwaJToaH3nYEW7nR7og0G3smq2Fea6WvpfzQXZBrZIMgsWN1wlH9B35nJ4EdRpOnasBmytooFy+mwq3LMs6jUPZA8EZ+yzEC62JF2KPC0ahHSwM9LGuqcDEpqWdz9nCz2sg18HtJVPiO7TZlVTrCaVXEQXcv4dobIHBORhAlkgFfnQTsu6kMFtXKMfP4Po3DZMnmt7BLPhdzOTAh9CvGJpZ/jr6fvzuXNHoeHoUC7UYwZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTuuUa33izrGR9p1cdU0h9JlwjfLoSNUvq0lrBh1yXg=;
 b=ITF0EuGnsbK6ddfgcIeZlLdXJAUx994NCciM8X/icG+ke84bXaiqcK75fEnTj/Czpu2319PVWK5uLskMk6QqUDu1UsWRF1ZNvQQkKZy5DS+QKY9oTSffQod/YIg3vS1JyRF437ATR3J0LCbpndySpwnZ/vhnVZSprofIkj00cSkwT1vgJJDqaTKzT16LojcwYWHDU6vemmxp6jLZZ4rCu7cRsNMgKnhtdmjzHCApLyq8pLOV7cXlnbuZcvh3vNtjTM80Nfbhy2AvsZoOuDBApOar8SSzn9NRcrCk+19uAkhb9YeGfTGmY6CGkhmMx61T/RbXDYYveAcQOVbTehrsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTuuUa33izrGR9p1cdU0h9JlwjfLoSNUvq0lrBh1yXg=;
 b=YS5/+6N3axZQ9a4GN8Hp0OViN3DUU+GI5GHtX3je41DQD63ephwQ3tADtLXuKOvtxK/Bvx+sGPvE3eCb69w+XWNnTb2WchgoWSvsHmEYvyBtxVWK0tV+xsww6UwcJb0tWqh/1q3Aqb5hP+VEroIaTIm6kT3pF8CB7zLsSYp3fMo=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DS7PR13MB4624.namprd13.prod.outlook.com (2603:10b6:5:3ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.13; Sun, 13 Jun
 2021 15:36:38 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.014; Sun, 13 Jun 2021
 15:36:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for 5.13
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for 5.13
Thread-Index: AQHXYGnmfI6+mUWNKUuM98ePgglyKw==
Date:   Sun, 13 Jun 2021 15:36:38 +0000
Message-ID: <a163fa3530e0c39ae83bdbee68dd189b1d15fe27.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55f38ac7-7b7b-47e6-6b4a-08d92e8108cd
x-ms-traffictypediagnostic: DS7PR13MB4624:
x-microsoft-antispam-prvs: <DS7PR13MB4624A55CE512DDBDDA583E17B8329@DS7PR13MB4624.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5DKbbXr2RXrGikJ9/6enlvzrD8g2MfNPVDCKFedXeN3QH0TbYKHosQcsScpme1oibdziDjeIIq34JG1ChgTXIJM4TIwM7yipX2DeErPIwXw/Bw93hmlo9aMd5dloL/eb4kSvlbFBA5SG4W/C7vwil7+Tw9of0eibxe4MXf1FUC1BtEZzLbDu6eB+nb4jNAzT9yymeK08NhsiWhPABRWdAJPfpjOQ/EBb7Tvh8Yz6fejBNyE0cEj0uf12lNqhVmhN5dfKaoCIkCDeS5ulE9gRrBWvQN/PNLYsOgUVXJi65iejyWP7Md8nRSQ40HYFb0ezfLNTVYp4CLLZncDKyYyCoA8CiVdNunpmfj0ML07kvMsrBAkClBu0QTybbHpsKUTOYolddxN7xDrKWd49dVMpSjMC862cNzAyz/Fi5mhiABv2ZfaDuMsEH4U4EwbOruDmqD5uZU42PJ0pHwEstYm55HTOUx/80Uyl+Cp/yf2YdXUvamRDc3bRNeWQDRPDLmJabYmBUuSnySK00HxlCVq/HVk8w4PvfY2i85q246Sl17JvzSVlnPoKO9mHyV5teRWi+SwT5tKCTNv/K3oSg9WQsx6FMhg8/14PsfdJnVJdBuU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(508600001)(6506007)(36756003)(64756008)(83380400001)(5660300002)(8676002)(186003)(6916009)(38100700002)(4326008)(66446008)(54906003)(2906002)(26005)(122000001)(8936002)(66556008)(66946007)(76116006)(6486002)(6512007)(91956017)(86362001)(71200400001)(66476007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlIzeVpmRVhaVFgxTStHZ2Y0ZVBIZExqd2tyR0JtbWhnWklVdS95bXF0elNy?=
 =?utf-8?B?Q2NqYk5yMDdSdHBWR0ZHdFhvZFRqRktjNXhhODYyYndDeURMNjFKRzdiV3o1?=
 =?utf-8?B?MVVEMUdicndFNGZoVUZFSERqTndpeVk1NXRFeGQzTWFRdnVsL0R4WVlBR0dJ?=
 =?utf-8?B?Sm5wRGZvUFJtblFvMlR0REtPaWVSRERNRFBDUEpFYUM3VkFYN0dUV0dJZlY3?=
 =?utf-8?B?akU2eVZ0R01uRkxMaDFjSi80TmhSbWhZalZJMU53U3BLOHpvY1V1enBnNWMz?=
 =?utf-8?B?REJSM2MvTFQwS2NLdktjeWM3WENzSEFwR2VYemdNakF2R2xUckxXNU5uUTJN?=
 =?utf-8?B?OXVVT3lqSHFUa2xrNXhXTkVRZW01cDlMWk1zN0NGSWVZelRodjJFSnBJckkw?=
 =?utf-8?B?Q2JBYkFkK1RhbXVHZjRCR254NDRVNCsrQVVZdjFUd2tYbU5uMVZSR2s5L09E?=
 =?utf-8?B?V1IrbHhvMzR2TDY5VTJjdGJySVhmYmVvYkh2ZlFRaW51YUhiTTByRENZL1hV?=
 =?utf-8?B?eTVJaGEwTFNCZ3B0Ly9hbTRDUWNxeTlqYm1WZnhFaVNBeVZDNFJjVDRWRTBO?=
 =?utf-8?B?eHZKRG01MlZHWjhzY3dnd0xpdWFHRTU3bE1aMG1VS2xzRDlYVld0bVlqNVlo?=
 =?utf-8?B?aXJrcjY1WlpQQ2FmeUcxK29HTDZVNk8yb21WMnJjTTJMNitySGt2Z1lHU211?=
 =?utf-8?B?K1dxbXBpTTdFZldNSGhDUytmVVhoNEhFcmhLekpKQ05ncnNNRHRycVQ5eHFP?=
 =?utf-8?B?aDZtcC9UdlFJempaaHNwRFVuOXp4cHVTQzlWa3oyVnB0Y2wwZ2tERnUrbDQx?=
 =?utf-8?B?QndVMW05VVVvVjRueTZDNVVwMm1YeVJyOER0MWpwVXRWbjBhSnJYYUN1UFAr?=
 =?utf-8?B?Ty91V2I5U0RWNEZ5VnYvYjE5SkZEVDJ3ZTdNL1BSdDNMUi90ckx6VU9xbGJI?=
 =?utf-8?B?V0w2MExHd2t0WE1pa0VMWDQ4N2xQWENHTjR5Y2hCVkVQZ1djOE11V0NEbW5r?=
 =?utf-8?B?RllPS3hQM1pkN1JEZWZPYlh1M2ZGRlpUR2cyT2xkQVIzdkMyOEpWRldBemZI?=
 =?utf-8?B?KyszTTBhOGtEanMwQkdtbnM4UTdCMjJuRW5MYnB3K1Y4UEpWYmJZcEZmT0o5?=
 =?utf-8?B?Q3B4dmI5dUIxajBuRmxSTzViczhSWFJ5ajNoUzRHMURYajRmMWh2WWVyOFgx?=
 =?utf-8?B?YVBCYk9aRGlYajBwT0ZvQWRtTlpSRkNzZmk4N2pVN1U2YWwrWnh0T2VuNDJS?=
 =?utf-8?B?NUJQcWFuQnROd21VRGFIOHAvMUhlekw4cE5FRGJFV0VoeHpBbTdRcnJJTGU0?=
 =?utf-8?B?RUl1Zk5BSEJOaVNONkJxY050aHFWd05OQU5oSzVlZkxXV3RwcnQ5RmpSNGdu?=
 =?utf-8?B?T3UzaVFZbHRobDkvdm11bEJxWmZwS05XajlIdzB4RGNzQTlYTFRTd2kwMGht?=
 =?utf-8?B?dllQcG12V0JEcExKNnh1b1lqMWVVMEdYR2N6a2VHeE5DVUg3ekZHNXlkM3dk?=
 =?utf-8?B?aTQvYTNPTVptNncyVkxaYWVabnpBRkpWbVJJMDJXd1VHNm9XSWg5c1l5aHZW?=
 =?utf-8?B?N3k2QzhrWHpkM2FUWTJBclRBNzRub2JnU0dBZWdHUHRBSS96UjlkUkMwd2Q1?=
 =?utf-8?B?cHcydC9QVkt4YnB5eVVHMHp6TURQcTRnaCtnUEhuUStJcVQxc08rUkU2ZFJU?=
 =?utf-8?B?UENFN3RQelhIbnhQVXliVkZTRVdFVUI5VHBodWt0VkI4aVRTNVdhbm5hR3JD?=
 =?utf-8?Q?26YCWn4dnDMLVuFUNtozmIWCF8WPRViiWjv6q7d?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBE28B9604F3FC4C9BB81B7F7CF9601C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f38ac7-7b7b-47e6-6b4a-08d92e8108cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2021 15:36:38.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SINmNU0Z7T9aEnFT1Hx1B9cvE4dbp1Se3QYYd9+qEOML0E9v9LNXpHp2gIYV1KGmGS9Lcwn0O1PVBxMPaGtrcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4624
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgODEyNGM4YTZi
MzUzODZmNzM1MjNkMjdlYWNiNzFiNTM2NGE2OGM0YzoNCg0KICBMaW51eCA1LjEzLXJjNCAoMjAy
MS0wNS0zMCAxMTo1ODoyNSAtMTAwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9s
aW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci01LjEzLTMNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFu
Z2VzIHVwIHRvIGMzYWJhODk3YzZlNjdmYTQ2NGVjMDJiMWYxNzkxMTU3N2Q2MTk3MTM6DQoNCiAg
TkZTdjQ6IEZpeCBzZWNvbmQgZGVhZGxvY2sgaW4gbmZzNF9ldmljdF9pbm9kZSgpICgyMDIxLTA2
LTAzIDEwOjE0OjQyIC0wNDAwKQ0KDQpDaGVlcnMNCiAgVHJvbmQNCg0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTkZTIGNs
aWVudCBidWdmaXhlcyBmb3IgTGludXggNS4xMw0KDQpIaWdobGlnaHRzIGluY2x1ZGUNCg0KU3Rh
YmxlIGZpeGVzOg0KLSBGaXggdXNlLWFmdGVyLWZyZWUgaW4gbmZzNF9pbml0X2NsaWVudCgpDQoN
CkJ1Z2ZpeGVzOg0KLSBGaXggZGVhZGxvY2sgYmV0d2VlbiBuZnM0X2V2aWN0X2lub2RlKCkgYW5k
IG5mczRfb3BlbmRhdGFfZ2V0X2lub2RlKCkNCi0gRml4IHNlY29uZCBkZWFkbG9jayBpbiBuZnM0
X2V2aWN0X2lub2RlKCkNCi0gbmZzNF9wcm9jX3NldF9hY2wgc2hvdWxkIG5vdCBjaGFuZ2UgdGhl
IHZhbHVlIG9mIE5GU19DQVBfVUlER0lEX05PTUFQDQotIEZpeCBzZXR0aW5nIG9mIHRoZSBORlNf
Q0FQX1NFQ1VSSVRZX0xBQkVMIGNhcGFiaWxpdHkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQW5uYSBTY2h1bWFrZXIg
KDEpOg0KICAgICAgTkZTOiBGaXggdXNlLWFmdGVyLWZyZWUgaW4gbmZzNF9pbml0X2NsaWVudCgp
DQoNCkNodWNrIExldmVyICgxKToNCiAgICAgIE5GUzogRk1PREVfUkVBRCBhbmQgZnJpZW5kcyBh
cmUgQyBtYWNyb3MsIG5vdCBlbnVtIHR5cGVzDQoNCkRhaSBOZ28gKDEpOg0KICAgICAgTkZTdjQ6
IG5mczRfcHJvY19zZXRfYWNsIG5lZWRzIHRvIHJlc3RvcmUgTkZTX0NBUF9VSURHSURfTk9NQVAg
b24gZXJyb3IuDQoNCkRhbiBDYXJwZW50ZXIgKDEpOg0KICAgICAgTkZTOiBGaXggYSBwb3RlbnRp
YWwgTlVMTCBkZXJlZmVyZW5jZSBpbiBuZnNfZ2V0X2NsaWVudCgpDQoNClNjb3R0IE1heWhldyAo
MSk6DQogICAgICBORlM6IEVuc3VyZSB0aGUgTkZTX0NBUF9TRUNVUklUWV9MQUJFTCBjYXBhYmls
aXR5IGlzIHNldCB3aGVuIGFwcHJvcHJpYXRlDQoNClRyb25kIE15a2xlYnVzdCAoMik6DQogICAg
ICBORlN2NDogRml4IGRlYWRsb2NrIGJldHdlZW4gbmZzNF9ldmljdF9pbm9kZSgpIGFuZCBuZnM0
X29wZW5kYXRhX2dldF9pbm9kZSgpDQogICAgICBORlN2NDogRml4IHNlY29uZCBkZWFkbG9jayBp
biBuZnM0X2V2aWN0X2lub2RlKCkNCg0KIGZzL25mcy9jbGllbnQuYyAgICAgfCAgMiArLQ0KIGZz
L25mcy9uZnM0X2ZzLmggICAgfCAgMSArDQogZnMvbmZzL25mczRjbGllbnQuYyB8ICAyICstDQog
ZnMvbmZzL25mczRwcm9jLmMgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0NCiBmcy9uZnMvbmZzdHJhY2UuaCAgIHwgIDQgLS0tLQ0KIDUgZmlsZXMgY2hhbmdlZCwg
MzMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
