Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC3309E4E
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Jan 2021 20:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhAaTf3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jan 2021 14:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhAaTdE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Jan 2021 14:33:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E924C061A27;
        Sun, 31 Jan 2021 11:25:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYzR6eIy++1M6IWIYV3HKjoNr/bfEIphWdbwMPd4zphW4XGOSI4/VlSD5b+52rh78HKZqQkSa/01Rx/YRmY0DJIUHiRbTr0AH1bj7KQipDABBzzo7vBKVbUx7nypHvBvdbWb2amFwPNVQK7g8e/CUTu0dexK5zv2sRRsRo/XHsMmCU6rYR2qJbQAFy1DcpMuTEWcM8UnB5Shd4Sj5qSfaW4HL2y/jh/V2OWuV5m8agCFnm8pqAtB8smrUPWbVnnbh0xGWNF1q50xXTcDPHursxG+zhZ1jNjsIwF5k/HoAqZh7Z2yZIl2pKDbrasJ9hzGXz+8UppE82+W/X2Ogid/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6jdcIxbHuI3tcrimesOPrFZ7ZSe4vTFtBXukzY1ljA=;
 b=DE2UL73vZbYZGh6GGpK9mBo1meSjFjWAW24Anxis+Uy5c0xBB4AE4c+XZ+weV4GwXMfvlEMFA0yAz456/OQcsugylC6dbS7Y93j9ZnMUKjR82fIEOYXORfmFq84PNzqY615VQNObN1AdXRuRnl5i+LCfhmFT+ZnvJgXjBhrLM9y07qwtui6F02+096nIeQKB9repITLDMlH27pXw0y62+Eh/leYyqNJ8XsvDFCLnTtc12iKRK6FzcNLgfUyErUxtPKmp+yiDmVynxth5bh5KNmIiv+nonv/17nPViz+w7wCBpp/wK1q+4kjJJzLHwzPoUG8XW8MoT7bbWDWFyVAoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6jdcIxbHuI3tcrimesOPrFZ7ZSe4vTFtBXukzY1ljA=;
 b=Py0t6jkRnXnEXRcYiVcVvpqL+Fnsmndhk2LgrBVL//UFxpYa8fm12RjlR/YSLt4L3AN1RXrfSqg3VHuRaN9hnI60hMXHl9KhnLDfGRoQ6nWA6FwyX4W5Z1OQ1jLDZ/9hOf+57T+w1HnvFMR6vHdH7RJilpGbDPy+2pHxyLWAj0Q=
Received: from (2603:10b6:610:21::29) by
 CH2PR13MB3687.namprd13.prod.outlook.com (2603:10b6:610:9c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8; Sun, 31 Jan 2021 19:25:30 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3825.013; Sun, 31 Jan 2021
 19:25:30 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for 5.11
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for 5.11
Thread-Index: AQHW9/J6W/jj3juqlEK7LCc2xpIr4apCHNsAgAAA64A=
Date:   Sun, 31 Jan 2021 19:25:29 +0000
Message-ID: <2de1512a4c3f37b6b5e48a0393499032d9fde9fa.camel@hammerspace.com>
References: <8eb145f609386c98be1ec6381424cf408804ac7d.camel@hammerspace.com>
         <CAHk-=wjtGGxGYT6aVaGOxwSp2YtdVdOOQj2nUiPiQHhWTHmcwA@mail.gmail.com>
In-Reply-To: <CAHk-=wjtGGxGYT6aVaGOxwSp2YtdVdOOQj2nUiPiQHhWTHmcwA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d94a53a-643b-4ee6-54bb-08d8c61df89a
x-ms-traffictypediagnostic: CH2PR13MB3687:
x-microsoft-antispam-prvs: <CH2PR13MB36870176DDA98828A925D1EBB8B79@CH2PR13MB3687.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mlyONZXTNgrPgBI4a7BjpLwJVeoJ+UovNR0LzqJwr9ALK4qu2AklUvIsyUfQ4RK3tLjH/Lu1CsXJfWHpY8qs5caIRhezXZOxH2nVkqvsRDPwtbjDtYBoAYVdFecV+SPDj+3/TQeAdd3xmpMAOKFx+nL51vwmOLGIVFKUK91wsDDx7Hgws95KsRRg38+mP9halCmgPGBM9Pp4oqguO/Ox8R89QHmkd+nVp4goRN+MpaqC0qjFSpNWIp4UPAVGTQ/kZODF75XlHVK/2iSXWjoGjX7zR1GnMgEnPJ1BVsfFd/LzRKRQmTe5C4pzX2gAakbsjfuQrc8Zs6bv8Yjgo435DhadeYMj9KDvgT0nXB6Pj4lURs4nZIcwHNe8GlYPX8SDtCaMOvvJvyrAyd4kLNATFePg2vIdOoasYxJ3aBrHWSgeGWqJFf7+sEuSnOo3Y6RbcgghkZO8QdFSKKVrdjfwd2h8th5O/yVynQK4h1XIvrz9IcJLHqzZJGUPmMzKuWgV+H7ZKwcDDOCUy5QYsxoADw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(346002)(396003)(376002)(366004)(8936002)(4744005)(71200400001)(76116006)(86362001)(316002)(6916009)(478600001)(5660300002)(54906003)(4326008)(8676002)(6506007)(53546011)(2616005)(66946007)(66476007)(66556008)(66446008)(64756008)(2906002)(6486002)(36756003)(186003)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TWZITEJIVGlWa2pjTitqVDBqRXdRcm55RTUxNHlodlFWN2c5bXJtVkhpRVhC?=
 =?utf-8?B?L2o3SWRiNDc2MlZZVVBuZlh5c1R5TnloZW0zTmR5aXZ2S2RTckxHRUJCZDlY?=
 =?utf-8?B?R2srQzRqRUFjTkdYblMvemxqcU5EeVlaL3dMenNuZkJCMzJtSUVTdUZLL0Ur?=
 =?utf-8?B?cFlKZzJnZk9aakVONWJKb0oyNXhYR2lkOWc2dmN1ejlqNDBQZm1LTDJXdmdV?=
 =?utf-8?B?eVJGQ3UyT1Y2SUJNdjZqbkFGUVJCRlZSelN4My9rT2pHeWVCK0NOcjBsU0ps?=
 =?utf-8?B?TWhkdUs1VHE0bE52b3Z6OUFPU1hzd0c4dkVDVEVEZFB1OTJQdzZIalRSMERm?=
 =?utf-8?B?N1pHZXJtdWJsNGdrSkl4T1VRR1RPNlUxSzRQaVIxamZZSk5oa1F2S1QvWldx?=
 =?utf-8?B?Q0VCVHRHMGw2MlZSNTdMcks3SkRIK044YjdPY09ZbjFBa2xlWlk5UU9ZYTFR?=
 =?utf-8?B?UENGQWZVOWdsQkxONnZGaWZCRGxPTDdBUXo4RTZiUDI5aGZtUXlaVGs4bVBX?=
 =?utf-8?B?NFJTVEdZUVNhYng3MVZZN0ZWUzhLOUpnZlNYaHpOSkp4WDN3U21qWTFhbnBz?=
 =?utf-8?B?N2p6RzFOYnh2QXUrY05iWG84MFZXaXRQZ1FOYUM4T2J2RzdtY09Td2JsTFJt?=
 =?utf-8?B?THFLTW1GQ1pHc0VYS2QvK0lzTGFJOGtTaC8xRjhrMTlSREN5b2c3RHpOZFJF?=
 =?utf-8?B?OGhNUFBsT1UvYmdYZ1ROaUw1REpVZkVOK0dTK2JEV21kNVlHZ0d4SmxLK01H?=
 =?utf-8?B?OXlCWlpHQ3NBelZUN2F0ck1ZMWREUFRldHJLM0FkMGR3MmlJQWFtZU5OdC9Y?=
 =?utf-8?B?RzdzekFBNDZXNGJrRit3aU9mcHJZL0pIQUozOUZpVnRkMmd2SmZpUUN6NkI4?=
 =?utf-8?B?SUc5QXBHbU9lWHZjZjlRYU5LM004YmRLY3d4WHI2R2hSRFNaK1d0Z1ZFZ3ZP?=
 =?utf-8?B?dHRNOVVSdFVSZzZXVDloQVRYcDdDWnplOXZ6RXd6RHk1cWpGcXBQdndsaUMx?=
 =?utf-8?B?cTVFc0pTakdHOUl0ZUdCTjlxM1F1QXRMTVpkVzMzK3hCb2hBQms1NE9kZEx3?=
 =?utf-8?B?WGVSRDJMd3Q4RDN2RmFIV2NheFJ6d0thR25yODJsVnFmbWN3WDlhZjZXakhD?=
 =?utf-8?B?RjF3ZVhKZElpT3dvbEdqNDZRVDVkTHNNUHVEM2dNeHlKbHhmeFVuaEcxMGNv?=
 =?utf-8?B?cEEzT0VOWStFTlpQaW16VFgrVHVkamgrUnpNWDd2Q2JoSkJBYWZ3dzNFaUlh?=
 =?utf-8?B?TlQzdGM0MUl6ZnhtYlRkWEtZa2tjdWZERTMvdjFuaHZEVmZIUDhSeFUvQmRR?=
 =?utf-8?B?MFZUVW9rWW52alkvZ2lZT1A5SVY5WHY3aHcyR2ZzbHRLYTlpcU1aOXprYnJN?=
 =?utf-8?B?UHdOdFV2cDB5Y0lXWEJXY2x3K2tiTHFsdDVYOTZDUFd0L2t2SnE0R0dHaFlK?=
 =?utf-8?B?WXVucGhxVjlQejFWUXdQcWhZaERVd0FDWG5yd3FnPT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2A1880BC0E5194CB5C050A08469E4E3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d94a53a-643b-4ee6-54bb-08d8c61df89a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 19:25:29.9670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02DikoA3dmXftRULt3Hoe5vArduyrbBQ9vgGuLl0C63g3cYBLc0yxbleacZv4zstjXsgGREPqiXYIrmvOzuzOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3687
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTAxLTMxIGF0IDExOjIyIC0wODAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gU3VuLCBKYW4gMzEsIDIwMjEgYXQgODo1OSBBTSBUcm9uZCBNeWtsZWJ1c3QgPA0KPiB0
cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gwqAgZ2l0Oi8vZ2l0Lmxp
bnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9saW51eC1uZnMuZ2l0IHRhZ3MvbmZzLQ0KPiA+
IGZvci01LjExLTMNCj4gDQo+IE1lcmdlZC4gSG93ZXZlciwgaXQgbG9va3MgbGlrZSB5b3Ugd29u
J3QgZ2V0IGEgcHItdHJhY2tlci1ib3QgcmVwbHkNCj4gYmVjYXVzZSBJJ20gbm90IHNlZWluZyB0
aGlzIGVtYWlsIG9uIGxvcmUuDQo+IA0KPiBTbyBJJ20gZG9pbmcgdGhlc2UgbWFudWFsIHJlcGxp
ZXMgZm9yIG5vdywgaXQgbG9va3MgbGlrZSB0aGUgbWFpbGluZw0KPiBsaXN0IGlzIG5vdCBkb2lu
ZyBncmVhdC4NCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqAgTGludXMNCg0KDQpZZWFoLCBJIHdhcyBj
dXJpb3VzIGFib3V0IHRoYXQuIFdhc24ndCBzdXJlIGlmIHRoZSBwcm9ibGVtIHdhcyBvbiBteQ0K
ZW5kIG9yIGlmIGluZGVlZCB0aGUgbWFpbGluZyBsaXN0cyBhcmUgZG93bi4NClRoYW5rcyBhbnl3
YXkgZm9yIG1lcmdpbmcgYW5kIHRha2luZyB0aGUgdGltZSB0byByZXBseSENCg0KQ2hlZXJzDQog
IFRyb25kDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
