Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF20E3DF6B9
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Aug 2021 23:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhHCVHZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 17:07:25 -0400
Received: from mail-bn7nam10on2102.outbound.protection.outlook.com ([40.107.92.102]:59283
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231519AbhHCVHZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Aug 2021 17:07:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgD6SItsEV/qJubFlL3UV0jNWOA9qqA0/c+qBr0mwLC6aPFuM0F9V3NLUOF0jE7q6hB8/p45pk46eiavaTZYeOeD60be0J03VWGLQJMby+eusouXFrD68r0gKHWNuxAIfm9QhNW9il5Bi1EdhzYIJY6DUzOLF6OaBDypUVZHQ0yQnDRzLfn33Qd2k+qhNJONqfSWsNpQqAgKDfO3GaF6vjoqm22r9aj7QkBIkx33G0cGjOt1hmBCmDQQLVhdxrtvFykOaX3MKCfHabZToQksFCGXPLGxWjFFgWgwWJ9ysGBpCS8vEtau31w70bXgVn+27GaG0Y+cnFGPo82EtkwIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj2zr8aN5rB8kpIrxc7v5mwdzl/w6FV7wyPdNrL+1Kg=;
 b=G2g2QwWfV6BmsyNSluNp1oN3NIwtuTv9QPBc2ef4BZBHQZNYIPBeRcSdEnQR6HJ0kzARE9IS03UQNfvMk++61yJa62wlOHaV4GEWc1E61uGD/FwMsbDvPCrY8/XOQ5XWRGOCqKZFxUif4SMvKe1M9Zi+fY/8vyK7D1s3V8VXLLol5MGFVV244ig6SBxJZN6Hm+qlokJFaAL1mM9d0nkH+D9upfY8KUtDQa9hgY2mv2hopvX+IhRIEv7D5W5LI65ToR9NVwsdxwRo9cCnJTlW3kYNmK4aQl/2/NtbyVVxe3RgM9hH/S0WqlJ/DVxLrjeT3Bd4LIaVsI6Vtx9K61xDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj2zr8aN5rB8kpIrxc7v5mwdzl/w6FV7wyPdNrL+1Kg=;
 b=gQOd7ZL+7q04X7yBoa04BKixkwfElMAFhWOZxkUHnDqq7wC89CBtGo0rYFIKyamyiDKkyor6a9T0uESCj+zu4QwPIf7GgeZTuNeqK7l5SLpiLLIwsY0ISWtrq6YiuyzDP4jkwObEz/LokRHwJ6tbcByeTqkcByQtHojHjVO8t5I=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3608.namprd13.prod.outlook.com (2603:10b6:610:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.13; Tue, 3 Aug
 2021 21:07:11 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4394.015; Tue, 3 Aug 2021
 21:07:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ9owuGm7b0CEqtoxaJkItc06tbmWqAgAao74CAAAokgA==
Date:   Tue, 3 Aug 2021 21:07:11 +0000
Message-ID: <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
         <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
         <20210803203051.GA3043@fieldses.org>
In-Reply-To: <20210803203051.GA3043@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c18c152-aac6-40fd-370f-08d956c2a96d
x-ms-traffictypediagnostic: CH2PR13MB3608:
x-microsoft-antispam-prvs: <CH2PR13MB36082089050A521E47544F2CB8F09@CH2PR13MB3608.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aU5IHqkb3HwKYzDSdXdOjlRGZTzI6eYt/WOZRevhEHeIpzfG7WWS3uQOXPPR96JlMyK6il6DZxpA1cs6cEsZudkvN1dtQTbosCpMQ+YPdae74QgtIA7FBcwfISA656b5V6/cFiJEUt61y17yigm5G1aX0zX2tILMLTF0um2lZSXTlzBO+45JcUMAd6qLZAiyORg7eK4QuULUMFQ1P/DPV8yLWtRBNNQJ36Egth1anLNpQgvSnd8L2i3K58eheG5Vk+eLRfkgvHLOCqB854aitWjtnDOmM1MPpSEEYtDNOxC5cyuCA8ZWuRENNoLF+GYnxfG1iZeKsPioCy8eWvP6setiOwEKrFCa51c5rDZi54OYTO29Jm3DyLfynqyByXB1PxqGhUeTTX6P7mJtsTThcu22MUVF1S1wWAjwiOtcgfrjQ7Cg1uJAy9UVypFuDN35GEZzlp/ciEPQugAKG01wOUC59A3EWuqcNfJY73YXPlXof59wGMuJwMCDVcFzdxvhAaGUQvWLoRCcRK6mwbqSwD4ezaJT71kbd4xIIKKyxxo9ST9mKrZb97i03P++qpophzpPXQ04xHbXDJ3EX2a3ZBtt0rHO+KngS5ppJgliuJjPxEJ1Q5FjbjmsGCv9qiHOe/rLys3CI2fIBxBJQ01bystsIFQ5F6TCzKS7kpNrG98UtKTWRphoGq6nplcZgafSO9oJcyTfnjwgnhuqfsoPew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(5660300002)(76116006)(508600001)(66946007)(8676002)(38070700005)(8936002)(2906002)(83380400001)(6506007)(26005)(64756008)(6512007)(54906003)(6486002)(6916009)(71200400001)(316002)(2616005)(4326008)(66446008)(86362001)(36756003)(38100700002)(122000001)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0k5VnR6aXpzSDI0OW1pUm93S1dic1F5QWREYU5RTlQ1NHk3bkFNb2JnYktZ?=
 =?utf-8?B?MldYeWtQckhQMEZBcGZQdHdqMkdpS1VDTUI0UGNKalF3bHRKcVlFMHZYSkZl?=
 =?utf-8?B?RjdJczdCT29aNU9Ba0pqK3ZhWFRSd1Y1aUhHRURGTmpPUURVSE9GZzZuNUJw?=
 =?utf-8?B?QldyZnNBL1g1Um9BRGxCQ0hBUWZoL2FpSlNiSTZoajUyMnQyQlY2THpOUkN6?=
 =?utf-8?B?L0V3R3RiWVBxNzRJT1JTUzE2eTZIMTRDcWRwMlc5VEdJRERoaWtsYmFkSllz?=
 =?utf-8?B?N01BeDFBNWkxcjRLRTU0MkprdXBZZnQvZEdyT3pyWTMxcHVab1Y0dm10ZmEy?=
 =?utf-8?B?SjJtbmlBckdkOGRobVFsRG1LbW1hSHRVREhiK240MWJqd3VmZEN2Umx6MVBN?=
 =?utf-8?B?VVRmNG85V3F4bS9ybWVFaFVPQlBOdFFLV1psTHg0WC81dnAxcU5CMFc3WlZX?=
 =?utf-8?B?NURXUnkwSjJZYmtDZEdxbmpOOFhpWndnalZERlFzNTNkUzQwcXRoby9RZFl3?=
 =?utf-8?B?VkNTbGVuQU1nVmE3K1pXVjN4Z1RHM3FhZGZTTXAxV2djWEhmRkN1OERCZWYx?=
 =?utf-8?B?VmlramVhOXQ5Tkt3N3AzVXhFZ2t6ZHZPYnF3NVU0KzZEZUFHTjJvYjd3MzRp?=
 =?utf-8?B?eXNjR00vL2plM2dDSkEwbnl4TnByM0p5dUVjOHN2U3dQd2Z5QmdUbUFyNnNV?=
 =?utf-8?B?cElLbE0yZzNadUFSZmNzVUx1UC9qcElWV3VyLzhRRW1jSUt6SmdOSEl2TFhM?=
 =?utf-8?B?bWFRdi9USWVDUjdsZzRDVFdsS1RJd1ErSEF5bDJVVnlKc2tTUTdvd2V5THB3?=
 =?utf-8?B?WnR6ckdKNmw4b1pxL1FoM3lKb1J5ZmJocTkzVGtCdy9Fd2cwdC9NdUFsOGs1?=
 =?utf-8?B?MGRpdTArT0hxbEFpYjk2SEZwNk5QNjJFWlg4QldDZDFCMFFGaUJqcnpCTUNp?=
 =?utf-8?B?YnVXSkczU0g1RUExL04vNFkzUVp2VW9rdkFTL1p3djNBLzl0bkUydHNTVUFa?=
 =?utf-8?B?aWZDK2U5bkpVY1M5Z2ZWVjZDU0NBWTlQRm93b21pemRWU2FKa3BzZFl4aEkv?=
 =?utf-8?B?WUcwQWpKYzh0cjNtMFB6TC9uOWFXZndKZ2NQZ29BZDFHT29lcnNGY3NtWis5?=
 =?utf-8?B?N3pmMzhVOWZEMzlUTEp6Nk9UcEVPNTc5VHBMNGJRSEYwcm4xT0Y1bHpJOWZC?=
 =?utf-8?B?ZGRTcElxZkJ5Y3pCS0lNVVBTelpFNWdoWFNaT0FDd1l2MUFtUzF0bXArZmgy?=
 =?utf-8?B?clJSMUJFbXZvZzcxTVVUbDNSc3RWVDMvbnlFekdmSnIyaktLQ1U3emk4NjRy?=
 =?utf-8?B?RzJ1MHVNeUF2UllwdVlVOC9aaFRRR0VhYzQ4NWtpdnQ2TWtmdDE2em5pRm9k?=
 =?utf-8?B?Uk9oZHhnRnFUM0JWd1dNSGZUM2VUc29iR292QVBMUXR2OVI1TjE0QUlYOTVC?=
 =?utf-8?B?UzJPSWxUS1dzeHZ1bDkreVMvSlpwV3dmYUFJbjk0MmV1YjVnVDA1QmFtOWRJ?=
 =?utf-8?B?bmZXSHNCTUwrNUJaQ0pJWmliaE5PV1hmL0RaNmdiYkM1bEVWK09HNjFidzZJ?=
 =?utf-8?B?Q0hGZ3hwSFZIL0xkOUsrZmpXczJ6WndCeDYwOWNFM3A5NjVpVWFzNXVmZjJs?=
 =?utf-8?B?Ti80c2ZudmdjcjBaQWNrSkpSMmhOdGJ0OHZudW9ad0NUalNWa3Uvd0xtdWJw?=
 =?utf-8?B?Vk5JMzRMZFVUeVNubFdQZS9tTmhLT084R1dHT1FEbW5qR01ERzh0QmxiTFpv?=
 =?utf-8?Q?oHH8nMuyH3onckD5sKnIKYqTJ2DIevIHXNAYIaN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6E6F0E851EEF142A3EBFCA779DD4755@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c18c152-aac6-40fd-370f-08d956c2a96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 21:07:11.3736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJ4D9YBpZAzem04HucaCdatLgWkUROtKjADYx9Za+GoWwIh/e6J255b/TljIdezHvhfJzIUoFXAYBffou+aGcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3608
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTAzIGF0IDE2OjMwIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIEZyaSwgSnVsIDMwLCAyMDIxIGF0IDAyOjQ4OjQxUE0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjEtMDctMzAgYXQgMDk6MjUgLTA0MDAsIEJlbmph
bWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4gPiBJIGhhdmUgc29tZSBmb2xrcyB1bmhhcHB5IGFi
b3V0IGJlaGF2aW9yIGNoYW5nZXMgYWZ0ZXI6DQo+ID4gPiA0NzkyMTkyMThmYmUNCj4gPiA+IE5G
UzoNCj4gPiA+IE9wdGltaXNlIGF3YXkgdGhlIGNsb3NlLXRvLW9wZW4gR0VUQVRUUiB3aGVuIHdl
IGhhdmUgTkZTdjQgT1BFTg0KPiA+ID4gDQo+ID4gPiBCZWZvcmUgdGhpcyBjaGFuZ2UsIGEgY2xp
ZW50IGhvbGRpbmcgYSBSTyBvcGVuIHdvdWxkIGludmFsaWRhdGUNCj4gPiA+IHRoZQ0KPiA+ID4g
cGFnZWNhY2hlIHdoZW4gZG9pbmcgYSBzZWNvbmQgUlcgb3Blbi4NCj4gPiA+IA0KPiA+ID4gTm93
IHRoZSBjbGllbnQgZG9lc24ndCBpbnZhbGlkYXRlIHRoZSBwYWdlY2FjaGUsIHRob3VnaA0KPiA+
ID4gdGVjaG5pY2FsbHkNCj4gPiA+IGl0IGNvdWxkDQo+ID4gPiBiZWNhdXNlIHdlIHNlZSBhIGNo
YW5nZWF0dHIgdXBkYXRlIG9uIHRoZSBSVyBPUEVOIHJlc3BvbnNlLg0KPiA+ID4gDQo+ID4gPiBJ
IGZlZWwgdGhpcyBpcyBhIGdyZXkgYXJlYSBpbiBDVE8gaWYgd2UncmUgYWxyZWFkeSBob2xkaW5n
IGFuDQo+ID4gPiBvcGVuLsKgDQo+ID4gPiBEbyB3ZQ0KPiA+ID4ga25vdyBob3cgdGhlIGNsaWVu
dCBvdWdodCB0byBiZWhhdmUgaW4gdGhpcyBjYXNlP8KgIFNob3VsZCB0aGUNCj4gPiA+IGNsaWVu
dCdzIG9wZW4NCj4gPiA+IHVwZ3JhZGUgdG8gUlcgaW52YWxpZGF0ZSB0aGUgcGFnZWNhY2hlPw0K
PiA+ID4gDQo+ID4gDQo+ID4gSXQncyBub3QgYSAiZ3JleSBhcmVhIGluIGNsb3NlLXRvLW9wZW4i
IGF0IGFsbC4gSXQgaXMgdmVyeSBjdXQgYW5kDQo+ID4gZHJpZWQuDQo+ID4gDQo+ID4gSWYgeW91
IG5lZWQgdG8gaW52YWxpZGF0ZSB5b3VyIHBhZ2UgY2FjaGUgd2hpbGUgdGhlIGZpbGUgaXMgb3Bl
biwNCj4gPiB0aGVuDQo+ID4gYnkgZGVmaW5pdGlvbiB5b3UgYXJlIGluIGEgc2l0dWF0aW9uIHdo
ZXJlIHRoZXJlIGlzIGEgd3JpdGUgYnkNCj4gPiBhbm90aGVyDQo+ID4gY2xpZW50IGdvaW5nIG9u
IHdoaWxlIHlvdSBhcmUgcmVhZGluZy4gWW91J3JlIGNsZWFybHkgbm90IGRvaW5nDQo+ID4gY2xv
c2UtDQo+ID4gdG8tb3Blbi4NCj4gDQo+IERvY3VtZW50YXRpb24gaXMgcmVhbGx5IHVuY2xlYXIg
YWJvdXQgdGhpcyBjYXNlLsKgIEV2ZXJ5IGRlZmluaXRpb24gb2YNCj4gY2xvc2UtdG8tb3BlbiB0
aGF0IEkndmUgc2VlbiBzYXlzIHRoYXQgaXQgcmVxdWlyZXMgYSBjYWNoZQ0KPiBjb25zaXN0ZW5j
eQ0KPiBjaGVjayBvbiBldmVyeSBhcHBsaWNhdGlvbiBvcGVuLsKgIEkndmUgbmV2ZXIgc2VlbiBv
bmUgdGhhdCBzYXlzICJvbg0KPiBldmVyeSBvcGVuIHRoYXQgZG9lc24ndCBvdmVybGFwIHdpdGgg
YW4gYWxyZWFkeS1leGlzdGluZyBvcGVuIG9uIHRoYXQNCj4gY2xpZW50Ii4NCj4gDQo+IFRoZXkg
KnVzdWFsbHkqIGFsc28gcHJlZmFjZSB0aGF0IGJ5IHNheWluZyB0aGF0IHRoaXMgaXMgbW90aXZh
dGVkIGJ5DQo+IHRoZQ0KPiB1c2UgY2FzZSB3aGVyZSBvcGVucyBkb24ndCBvdmVybGFwLsKgIEJ1
dCBpdCdzIG5ldmVyIG1hZGUgY2xlYXIgdGhhdA0KPiB0aGF0J3MgcGFydCBvZiB0aGUgZGVmaW5p
dGlvbi4NCj4gDQoNCkknbSBub3QgZm9sbG93aW5nIHlvdXIgbG9naWMuDQoNClRoZSBjbG9zZS10
by1vcGVuIG1vZGVsIGFzc3VtZXMgdGhhdCB0aGUgZmlsZSBpcyBvbmx5IGJlaW5nIG1vZGlmaWVk
IGJ5DQpvbmUgY2xpZW50IGF0IGEgdGltZSBhbmQgaXQgYXNzdW1lcyB0aGF0IGZpbGUgY29udGVu
dHMgbWF5IGJlIGNhY2hlZA0Kd2hpbGUgYW4gYXBwbGljYXRpb24gaXMgaG9sZGluZyBpdCBvcGVu
Lg0KVGhlIHBvaW50IGNoZWNrcyBleGlzdCBpbiBvcmRlciB0byBkZXRlY3QgaWYgdGhlIGZpbGUg
aXMgYmVpbmcgY2hhbmdlZA0Kd2hlbiB0aGUgZmlsZSBpcyBub3Qgb3Blbi4NCg0KTGludXggZG9l
cyBub3QgaGF2ZSBhIHBlci1hcHBsaWNhdGlvbiBjYWNoZS4gSXQgaGFzIGEgcGFnZSBjYWNoZSB0
aGF0DQppcyBzaGFyZWQgYW1vbmcgYWxsIGFwcGxpY2F0aW9ucy4gSXQgaXMgaW1wb3NzaWJsZSBm
b3IgdHdvIGFwcGxpY2F0aW9ucw0KdG8gb3BlbiB0aGUgc2FtZSBmaWxlIHVzaW5nIGJ1ZmZlcmVk
IEkvTywgYW5kIHlldCBzZWUgZGlmZmVyZW50DQpjb250ZW50cy4gU28gd2h5IGRvIHdlIG5lZWQg
YSBzZWNvbmQgcG9pbnQgY2hlY2sgb2YgdGhlIHZhbGlkaXR5IG9mIHRoZQ0KcGFnZSBjYWNoZSBj
b250ZW50cyB3aGVuIG9uZSBhcHBsaWNhdGlvbiBoYXMgYWxyZWFkeSB2ZXJpZmllZCB0aGF0IHRo
ZQ0KY2FjaGUgd2FzIHZhbGlkIHdoZW4gaXQgb3BlbmVkIGl0Pw0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
