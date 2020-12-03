Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9432CE178
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 23:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgLCWPW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 17:15:22 -0500
Received: from mail-bn8nam12on2139.outbound.protection.outlook.com ([40.107.237.139]:46817
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbgLCWPV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 17:15:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB85Tg0FrvK3tVE2YW72pAFLxc3+KacqAU9GGqlAULVxIjK795nZUsW5GqQg3HcvRUFSB3DlIlBD5ERfXt7q2h3VZP8nchyYw75q6EPN/OyPXP+X+9FDhTE3OPEp63kBxAzlSqdDyQNe2O8uEV13QKA8n6tAGZOEczn5v/F2Dsx9HubEARQyi2WbLwcAbey9/nTpOmU7E7founPO3zwcBvHUsVkBXdeam05WspocWKfavukP2ViLOfaoBckWZ/3UCPiMXrvZG36vJSLVhK4tPVLviNUfu8b7Ok3prMeF/wL1DPz2PkFR1kPZE0I0DUu7Mc8tlUoIif/3y1zwKXTn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqj3jA92vU7GMFSa2N8+JN9KSUQp7mKgEAUPc5sOH/s=;
 b=LzX1k+oPbzAcyrky72LGUMbmlGxkkQsDUeB+mC/B4BnAmwnus+/7vaIDkYxV+rPiuIWKL4tllzVnvMVVAEQrdXaaGiQQgUp+pK5k5TInnwSduVe0aIfxDO80rCjNLct/kmnw70ER72TE4cM9r5Un778h2f/lisgl+nCsUzOdafyAcr5N8t8vINa+VSkhBc0QokzG+G+E9TbEzK2Q1g/IrrnS7ysf+2+FNtXzkS/LfvIomgRWxFWyf7OH5AAVnsR9+Qdt5VT7Bfv80OKLgxoUn3e5tQ2XOqg29iQo2pCtp+sRi/2v5M8mw7fN0Lwy7OVwna7DtICYCv7Rok4dUaq9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqj3jA92vU7GMFSa2N8+JN9KSUQp7mKgEAUPc5sOH/s=;
 b=NNBTY/ScO1Eaf522NStT18UlTYQY+FXQOJvUeBLJapyfn6yBcMD2DsooPNBRJblvS01EZJwvcKpO+QKLQFyTNVbsaoH2RgHSV9yllYO8WW1NWjOUOYiilwGDusrXznDMbPaUvq89LlJ47GXpoc21ibFgApf3wRNrSRza8cWx21k=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3183.namprd13.prod.outlook.com (2603:10b6:208:139::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7; Thu, 3 Dec
 2020 22:14:26 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Thu, 3 Dec 2020
 22:14:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "ffilzlnx@mindspring.com" <ffilzlnx@mindspring.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR4tJDJwAAAWCe4BeKhpLVGiQL7pUtKchSdvFeTqNAIAEhEYAgBNavQCAAAtBAIABTyGAgAxAb4CAAG0ggIAAGvSAgAAMzwCAAAXZAIAAAzUAgAADTACAAAHegIAAAs4A
Date:   Thu, 3 Dec 2020 22:14:25 +0000
Message-ID: <0452916df308e9419f472b0d5ffb41815014dce4.camel@hammerspace.com>
References: <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
         <20201124211522.GC7173@fieldses.org>
         <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
         <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
         <20201203185109.GB27931@fieldses.org>
         <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
         <20201203211328.GC27931@fieldses.org>
         <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
         <019001d6c9bd$acbeb6b0$063c2410$@mindspring.com>
         <b9e8da547065f6a94bed22771f214fef91449931.camel@hammerspace.com>
         <20201203220421.GE27931@fieldses.org>
In-Reply-To: <20201203220421.GE27931@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04831bb4-00c2-4df3-3618-08d897d8cbb2
x-ms-traffictypediagnostic: MN2PR13MB3183:
x-microsoft-antispam-prvs: <MN2PR13MB31839B9EAC84B72FA4432556B8F20@MN2PR13MB3183.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cxeJaCjplcumKAINusoMXe/B7vmsa+CF1d57XMSXNemNTW8q0I50yHn+hfF6gzJHC2Cv3FCuZWkj8soV4/riNSgjIDGtNYX+36Riu8EehHJHwE60ak1HEDBE4iQpfN0XjEx3f3cGNEKtApJxolrP/QTPvUIzPqzNHkR/C3LY5/7MezBzRqLw52IpkgVEoZyx6R36OwiKxT1CZc605b0PuwPP2nU3gsimlm9ip6eqVbXdPmdU561FEnOjNczwjFlx2UGK10xi4wK3QIjte1iseJSkGhc1XZ7UI5DMj9qC5PYyRh8fBFdnATR6OutR7U9tjA3I1k5XUV8TbFb8LKLpbv2a8oqSOs+QkTUWNpEDl1J645pQcIO8HJGMaclGSngIVPY7NrV/havoSxeBI8ZJsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39840400004)(366004)(346002)(396003)(26005)(186003)(478600001)(966005)(83380400001)(71200400001)(2616005)(316002)(6512007)(54906003)(8676002)(91956017)(6506007)(66946007)(2906002)(66446008)(64756008)(66556008)(66476007)(76116006)(5660300002)(4326008)(6486002)(86362001)(8936002)(16799955002)(6916009)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aE5RMmkrZDVid282THpsOVBTM0doU25xMzZ4U0tjQkN2Mlc5SkpVK2c3WE1v?=
 =?utf-8?B?a0I3djVjNExvc0Z3WVZaNmphMkxlU2VqdmpLUDFWdURkODB2bDdDMnVJVDhO?=
 =?utf-8?B?S1FNYzlpM1BocjkxK0FyQ0xjbEFuSk5pUlpaY0RQRzBoeVA5UVhSQU5MT1J1?=
 =?utf-8?B?MzBVYUJUOTVOVTZxU2dvZFBKcHdBOHdDSjgvUGtoQmx2TEdDcEZXdkVrbGRC?=
 =?utf-8?B?OU84b0hnMDBwSzNSQktqTkRrSVBmV0E1WkZmSW5RaTlFa1lEZTNRdWY5U2xE?=
 =?utf-8?B?aXdUTkF0eHUwWlVRMHJzTUpPYnRhRGFWaDd1WU5qc1Iwb1ptZk42T0RGN2RP?=
 =?utf-8?B?ZEplLys0NktwT2c1RWw1NTEwblh3UUQxSzRGdFJZQ21vOVVZVHUxTFVRbUZi?=
 =?utf-8?B?d2VUVXFOQTRVWERqTnZaRmh6Qi91bmx0V0V6enFJWmdUSU04L1ZNTlRtYUF3?=
 =?utf-8?B?TGhYTnFHY1RWZ1B5MDkzT3F3eHlUVDQ4anduT3o0eFVNUkVra2NEUXcyRmJI?=
 =?utf-8?B?K2VLSmxlRS9MOXowR2lDL0J0Tzd1Q1J6bFh1OWZVZGptVW1lc2R1M05Dbk5s?=
 =?utf-8?B?OTh5eWhRNWEyZUozeUoycE1wcnkxQzJOMjN4c2pvSTR6YXBrSmNHOW1FVUJC?=
 =?utf-8?B?Z3VXb3laVkNIb1JoalRBaFV1Nmk5N3RMSDZJY2N3aFNlN3JmYloyYVA5aVBa?=
 =?utf-8?B?a0JhMHBtb2tYYzBsc2tJWktKcjBuU3BQNGJnSG5UbVFrelpJNTM5c2UxVTB3?=
 =?utf-8?B?ZlAySlN3M2F3TnZvTGUwTU5SL3lEcGgwK0VEdXZYTDk5Um1KUzE4emFlRmd4?=
 =?utf-8?B?Nlh0bnU0RTZVbXF1cm9Ocm5WUm5wRFlGQnNDSUdrdGZpSExLdW1VOXZtNkpH?=
 =?utf-8?B?VitzMzBQRUNhRmNyQ0swUEpZZ3ZpN1hIcHBHQnV2d2Q5K2I3NXkraFYrdXhl?=
 =?utf-8?B?WkJFNFVmNS84ZWc3akRQYkRCQnJjamdwYzROdEJ5ZnMxbGdES3hoN0J6Tnhr?=
 =?utf-8?B?cHczSFd3S1RQQWtQeENuS3ZxNnN5aVBiRjhUaGZaS0F1ZDRTWXR2UWdWQ29T?=
 =?utf-8?B?VDduK0wxR01rVStPR2tidlYweW9TakNWdGRHWXl0UHQwMHF5anEzcWNVbkdx?=
 =?utf-8?B?M09TTnlIWEV4SFk0bWVtMkRTZVNpZ3hlUi94S3B6a2VmeTJvZ2RJWDNXZVJz?=
 =?utf-8?B?aGIvQUdka2lsVGMwM0N0T2FLVUcrbHJxYTRLZzIzb0FmRmJUZzNEMTB4QjAv?=
 =?utf-8?B?SlM3ZnZQcDJjSE44OXVHMGpkMm1mTWdlSE1zVENBMlB3aU5WeEpzYUx5TVlN?=
 =?utf-8?Q?MHfl2ORThl0VKhXFVYsW2VOQ7Z4IfIaDQ9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BD12DC24771AC46B48EC5772BA1D639@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04831bb4-00c2-4df3-3618-08d897d8cbb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 22:14:25.7546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDDHlxreB4wXDgsgKsxzIEaMQ3tD3uCKDKQH30yWIOWR58seN6AE8xU8AUTh6CvpEDR8e1XnFQy5FhIaAghajQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3183
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDE3OjA0IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVGh1LCBEZWMgMDMsIDIwMjAgYXQgMDk6NTc6NDFQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMC0xMi0wMyBhdCAxMzo0NSAtMDgwMCwg
RnJhbmsgRmlseiB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCAyMDIwLTEyLTAzIGF0IDE2OjEzIC0w
NTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+ID4gT24gVGh1LCBEZWMg
MDMsIDIwMjAgYXQgMDg6Mjc6MzlQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA+ID4g
d3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBUaHUsIDIwMjAtMTItMDMgYXQgMTM6NTEgLTA1MDAsIGJm
aWVsZHMgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEkndmUgYmVlbiBzY3JhdGNoaW5nIG15IGhlYWQg
b3ZlciBob3cgdG8gaGFuZGxlIHJlYm9vdCBvZg0KPiA+ID4gPiA+ID4gPiBhDQo+ID4gPiA+ID4g
PiA+IHJlLQ0KPiA+ID4gPiA+ID4gPiBleHBvcnRpbmcgc2VydmVyLsKgIEkgdGhpbmsgb25lIHdh
eSB0byBmaXggaXQgbWlnaHQgYmUNCj4gPiA+ID4gPiA+ID4ganVzdCB0bw0KPiA+ID4gPiA+ID4g
PiBhbGxvdyB0aGUgcmUtIGV4cG9ydCBzZXJ2ZXIgdG8gcGFzcyBhbG9uZyByZWNsYWltcyB0byB0
aGUNCj4gPiA+ID4gPiA+ID4gb3JpZ2luYWwNCj4gPiA+ID4gPiA+ID4gc2VydmVyIGFzIGl0IHJl
Y2VpdmVzIHRoZW0gZnJvbSBpdHMgb3duIGNsaWVudHMuwqAgSXQNCj4gPiA+ID4gPiA+ID4gbWln
aHQNCj4gPiA+ID4gPiA+ID4gcmVxdWlyZQ0KPiA+ID4gPiA+ID4gPiBzb21lIHByb3RvY29sIHR3
ZWFrcywgSSdtIG5vdCBzdXJlLsKgIEknbGwgdHJ5IHRvIGdldCBteQ0KPiA+ID4gPiA+ID4gPiB0
aG91Z2h0cw0KPiA+ID4gPiA+ID4gPiBpbiBvcmRlciBhbmQgcHJvcG9zZSBzb21ldGhpbmcuDQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJdCdzIG1vcmUgY29tcGxp
Y2F0ZWQgdGhhbiB0aGF0LiBJZiB0aGUgcmUtZXhwb3J0aW5nIHNlcnZlcg0KPiA+ID4gPiA+ID4g
cmVib290cywNCj4gPiA+ID4gPiA+IGJ1dCB0aGUgb3JpZ2luYWwgc2VydmVyIGRvZXMgbm90LCB0
aGVuIHVubGVzcyB0aGF0IHJlLQ0KPiA+ID4gPiA+ID4gZXhwb3J0aW5nDQo+ID4gPiA+ID4gPiBz
ZXJ2ZXIgcGVyc2lzdGVkIGl0cyBsZWFzZSBhbmQgYSBmdWxsIHNldCBvZiBzdGF0ZWlkcw0KPiA+
ID4gPiA+ID4gc29tZXdoZXJlLCBpdA0KPiA+ID4gPiA+ID4gd2lsbCBub3QgYmUgYWJsZSB0byBh
dG9taWNhbGx5IHJlY2xhaW0gZGVsZWdhdGlvbiBhbmQgbG9jaw0KPiA+ID4gPiA+ID4gc3RhdGUg
b24NCj4gPiA+ID4gPiA+IHRoZSBzZXJ2ZXIgb24gYmVoYWxmIG9mIGl0cyBjbGllbnRzLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IEJ5IHNlbmRpbmcgcmVjbGFpbXMgdG8gdGhlIG9yaWdpbmFsIHNl
cnZlciwgSSBtZWFuIGxpdGVyYWxseQ0KPiA+ID4gPiA+IHNlbmRpbmcNCj4gPiA+ID4gPiBuZXcg
b3BlbiBhbmQgbG9jayByZXF1ZXN0cyB3aXRoIHRoZSBSRUNMQUlNIGJpdCBzZXQsIHdoaWNoDQo+
ID4gPiA+ID4gd291bGQNCj4gPiA+ID4gPiBnZXQNCj4gPiA+ID4gPiBicmFuZCBuZXcgc3RhdGVp
ZHMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU28sIHRoZSBvcmlnaW5hbCBzZXJ2ZXIgd291bGQg
aW52YWxpZGF0ZSB0aGUgZXhpc3RpbmcNCj4gPiA+ID4gPiBjbGllbnQncw0KPiA+ID4gPiA+IHBy
ZXZpb3VzIGNsaWVudGlkIGFuZCBzdGF0ZWlkcy0tanVzdCBhcyBpdCBub3JtYWxseSB3b3VsZCBv
bg0KPiA+ID4gPiA+IHJlYm9vdC0tYnV0IGl0IHdvdWxkIG9wdGlvbmFsbHkgcmVtZW1iZXIgdGhl
IHVuZGVybHlpbmcgbG9ja3MNCj4gPiA+ID4gPiBoZWxkIGJ5DQo+ID4gPiA+ID4gdGhlIGNsaWVu
dCBhbmQgYWxsb3cgY29tcGF0aWJsZSBsb2NrIHJlY2xhaW1zLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IFJvdWdoIGF0dGVtcHQ6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gaHR0
cHM6Ly93aWtpLmxpbnV4LW5mcy5vcmcvd2lraS9pbmRleC5waHAvUmVib290X3JlY292ZXJ5X2Zv
cl9yZS1leHBvcg0KPiA+ID4gPiA+IHRfc2VydmVycw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRo
aW5rIGl0IHdvdWxkIGZseT8NCj4gPiA+ID4gDQo+ID4gPiA+IFNvIHRoaXMgd291bGQgYmUgYSB2
YXJpYW50IG9mIGNvdXJ0ZXN5IGxvY2tzIHRoYXQgY2FuIGJlDQo+ID4gPiA+IHJlY2xhaW1lZA0K
PiA+ID4gPiBieSB0aGUgY2xpZW50DQo+ID4gPiA+IHVzaW5nIHRoZSByZWJvb3QgcmVjbGFpbSB2
YXJpYW50IG9mIE9QRU4vTE9DSyBvdXRzaWRlIHRoZSBncmFjZQ0KPiA+ID4gPiBwZXJpb2Q/IFRo
ZQ0KPiA+ID4gPiBwdXJwb3NlIGJlaW5nIHRvIGFsbG93IHJlY2xhaW0gd2l0aG91dCBmb3JjaW5n
IHRoZSBjbGllbnQgdG8NCj4gPiA+ID4gcGVyc2lzdCB0aGUgb3JpZ2luYWwNCj4gPiA+ID4gc3Rh
dGVpZD8NCj4gPiA+ID4gDQo+ID4gPiA+IEhtbS4uLiBUaGF0J3MgZG9hYmxlLCBidXQgaG93IGFi
b3V0IHRoZSBmb2xsb3dpbmcgYWx0ZXJuYXRpdmU6DQo+ID4gPiA+IEFkZA0KPiA+ID4gPiBhIGZ1
bmN0aW9uDQo+ID4gPiA+IHRoYXQgYWxsb3dzIHRoZSBjbGllbnQgdG8gcmVxdWVzdCB0aGUgZnVs
bCBsaXN0IG9mIHN0YXRlaWRzDQo+ID4gPiA+IHRoYXQNCj4gPiA+ID4gdGhlIHNlcnZlciBob2xk
cyBvbg0KPiA+ID4gPiBpdHMgYmVoYWxmPw0KPiA+ID4gPiANCj4gPiA+ID4gSSd2ZSBiZWVuIHdh
bnRpbmcgc3VjaCBhIGZ1bmN0aW9uIGZvciBxdWl0ZSBhIHdoaWxlIGFueXdheSBpbg0KPiA+ID4g
PiBvcmRlcg0KPiA+ID4gPiB0byBhbGxvdyB0aGUNCj4gPiA+ID4gY2xpZW50IHRvIGRldGVjdCBz
dGF0ZSBsZWFrcyAoZWl0aGVyIGR1ZSB0byBzb2Z0IHRpbWVvdXRzLCBvcg0KPiA+ID4gPiBkdWUN
Cj4gPiA+ID4gdG8gcmVvcmRlcmVkDQo+ID4gPiA+IGNsb3NlL29wZW4gb3BlcmF0aW9ucykuDQo+
ID4gPiANCj4gPiA+IE9oLCB0aGF0IHNvdW5kcyBpbnRlcmVzdGluZy4gU28gYmFzaWNhbGx5IHRo
ZSByZS1leHBvcnQgc2VydmVyDQo+ID4gPiB3b3VsZA0KPiA+ID4gcmUtcG9wdWxhdGUgaXQncyBz
dGF0ZSBmcm9tIHRoZSBvcmlnaW5hbCBzZXJ2ZXIgcmF0aGVyIHRoYW4NCj4gPiA+IHJlbHlpbmcN
Cj4gPiA+IG9uIGl0J3MgY2xpZW50cyBkb2luZyByZWNsYWltcz8gSG1tLCBidXQgaG93IGRvZXMg
dGhlIHJlLWV4cG9ydA0KPiA+ID4gc2VydmVyIHJlYnVpbGQgaXRzIHN0YXRlaWRzPyBJIGd1ZXNz
IGl0IGNvdWxkIG1ha2UgdGhlIGNsaWVudHMNCj4gPiA+IHJlcG9wdWxhdGUgdGhlbSB3aXRoIHRo
ZSBzYW1lICJnaXZlIG1lIGEgZHVtcCBvZiBhbGwgbXkgc3RhdGUiLA0KPiA+ID4gdXNpbmcNCj4g
PiA+IHRoZSBzdGF0ZSBkZXRhaWxzIHRvIG1hdGNoIHVwIHdpdGggdGhlIG9sZCBzdGF0ZSBhbmQg
cmVwbGFjaW5nDQo+ID4gPiBzdGF0ZWlkcy4gT3IgZGlkIHlvdSBoYXZlIHNvbWV0aGluZyBkaWZm
ZXJlbnQgaW4gbWluZD8NCj4gPiA+IA0KPiA+IA0KPiA+IEkgd2FzIHRoaW5raW5nIHRoYXQgdGhl
IHJlLWV4cG9ydCBzZXJ2ZXIgY291bGQganVzdCB1c2UgdGhhdCBsaXN0DQo+ID4gb2YNCj4gPiBz
dGF0ZWlkcyB0byBmaWd1cmUgb3V0IHdoaWNoIGxvY2tzIGNhbiBiZSByZWNsYWltZWQgYXRvbWlj
YWxseSwgYW5kDQo+ID4gd2hpY2ggb25lcyBoYXZlIGJlZW4gaXJyZWRlZW1hYmx5IGxvc3QuIFRo
ZSBhc3N1bXB0aW9uIGlzIHRoYXQgaWYNCj4gPiB5b3UNCj4gPiBoYXZlIGEgbG9jayBzdGF0ZWlk
IG9yIGEgZGVsZWdhdGlvbiwgdGhlbiB0aGF0IG1lYW5zIHRoZSBjbGllbnRzDQo+ID4gY2FuDQo+
ID4gcmVjbGFpbSBhbGwgdGhlIGxvY2tzIHRoYXQgd2VyZSByZXByZXNlbnRlZCBieSB0aGF0IHN0
YXRlaWQuDQo+IA0KPiBJJ20gY29uZnVzZWQgYWJvdXQgaG93IHRoZSByZS1leHBvcnQgc2VydmVy
IHVzZXMgdGhhdCBsaXN0LsKgIEFyZSB5b3UNCj4gYXNzdW1pbmcgaXQgcGVyc2lzdGVkIGl0cyBv
d24gbGlzdCBhY3Jvc3MgaXRzIG93biBjcmFzaC9yZWJvb3Q/wqAgSQ0KPiBndWVzcw0KPiB0aGF0
J3Mgd2hhdCBJIHdhcyB0cnlpbmcgdG8gYXZvaWQgaGF2aW5nIHRvIGRvLg0KPiANCk5vLiBUaGUg
c2VydmVyIGp1c3QgdXNlcyB0aGUgc3RhdGVpZHMgYXMgcGFydCBvZiBhIGNoZWNrIGZvciAnZG8g
SSBob2xkDQpzdGF0ZSBmb3IgdGhpcyBmaWxlIG9uIHRoaXMgc2VydmVyPycuIElmIHRoZSBhbnN3
ZXIgaXMgJ3llcycgYW5kIHRoZQ0KbG9jayBvd25lcnMgYXJlIHNhbmUsIHRoZW4gd2Ugc2hvdWxk
IGJlIGFibGUgdG8gYXNzdW1lIHRoZSBmdWxsIHNldCBvZg0KbG9ja3MgdGhhdCBsb2NrIG93bmVy
IGhlbGQgb24gdGhhdCBmaWxlIGFyZSBzdGlsbCB2YWxpZC4NCg0KQlRXOiBpZiB0aGUgbG9jayBv
d25lciBpcyBhbHNvIHJldHVybmVkIGJ5IHRoZSBzZXJ2ZXIsIHRoZW4gc2luY2UgdGhlDQpsb2Nr
IG93bmVyIGlzIGFuIG9wYXF1ZSB2YWx1ZSwgaXQgY291bGQsIGZvciBpbnN0YW5jZSwgYmUgdXNl
ZCBieSB0aGUNCmNsaWVudCB0byBjYWNoZSBpbmZvIG9uIHRoZSBzZXJ2ZXIgYWJvdXQgd2hpY2gg
dWlkL2dpZCBvd25zIHRoZXNlDQpsb2Nrcy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
