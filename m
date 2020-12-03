Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC92CDFB5
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 21:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgLCU2h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 15:28:37 -0500
Received: from mail-dm6nam10on2126.outbound.protection.outlook.com ([40.107.93.126]:45920
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbgLCU2f (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 15:28:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/2nQQlekJpyzw2NWJN1Yb7AnyaR6CnzO/BtTJXA83uUIQO2WwkmVfnMyxGIJFsqgG8xe+UOxoB+5hrKIrsvpV6DLnn9G/TXY4kmv8WbtpY6VLZn3249ZrHUDyXxvnBzvBV5DclnSmA4Spi3AnL+ZFAZkrVz3Hz59Whv0urr+W681PWml2MVPHyU5r1z1JQv1Ownsw5nzzsXifyGZapP7XIBquMoa1PfzfOIx2Gi3oXDu5/mlKdDDoqZ4PE61jZjf8u3pSkgn2UMqwzdeZWIskyDNhCDb5WqPeg334FftFxB55mtGrk611W3b/58uOFTbPbuV+JmlWa94801FySFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0USCSZSE5j+ez0xxOEXWyQPZgc0hpGyNloxOvQ3ozw=;
 b=GAiCOfAdvXySTbernw5s/dTHqNSLKs5tzYtxpHjbE8k3+7zupXjr19xiWHz41t9NiE7gPH3akLq2GtCXsIdBLJgaChL0rp8dOYX+Wi2THmS9For5we5KrQtPJWdXNArCBs8LCJf8MaEAGDQwLVTgVqKZ5wdt/SIGSqc5iD1yStVBXtUBRuI3EKBGHBZ00RFnCp4rA92aI+Y9KoEOS5J6G6+TGGJUFctndYzY+emklFzhGcM4ti6gd6iwHz9KlL1dQkv+shgHqj/2G/UfesZPXYLaJGUA2RGaF90uuvMOu5AIz6vRVCzEnKPghqmF3EVdIcfQUnNcEYJG9/TzlLIbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0USCSZSE5j+ez0xxOEXWyQPZgc0hpGyNloxOvQ3ozw=;
 b=b2R5ECDkzNVtfFGjfYNh9+KjmHEz8OWIbLZieoxBuFK4Tiglbm1X1Ek+PAdpzHEGbaXlB1kZn9qc7BH7xANVe5dDAyb4oy8+L4dIWK74xj0N7PY5/YK0pKj+McmImjyZAmw4kFOUZAojeByyP8B0nlK1bB2mk1DHBEtHIuFLw9U=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by BL0PR13MB4241.namprd13.prod.outlook.com (2603:10b6:208:81::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Thu, 3 Dec
 2020 20:27:39 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Thu, 3 Dec 2020
 20:27:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "daire@dneg.com" <daire@dneg.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR4tJDJwAAAWCe4BeKhpLVGiQL7pUtKchSdvFeTqNAIAEhEYAgBNavQCAAAtBAIABTyGAgAxAb4CAAG0ggIAAGvSA
Date:   Thu, 3 Dec 2020 20:27:39 +0000
Message-ID: <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
         <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
         <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
         <20201109160256.GB11144@fieldses.org>
         <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
         <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
         <20201124211522.GC7173@fieldses.org>
         <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
         <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
         <20201203185109.GB27931@fieldses.org>
In-Reply-To: <20201203185109.GB27931@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04fff860-0312-4b67-8633-08d897c9e130
x-ms-traffictypediagnostic: BL0PR13MB4241:
x-microsoft-antispam-prvs: <BL0PR13MB424114B375C7CFE407B000EAB8F20@BL0PR13MB4241.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eirkya3y6fixfucMYtuBrXDy5Gz/jZmf9OwU2B48IwioFBf5gMysXguHpoDCqLpvWOIEspDXS2Xk6TXHxULlvy8POv0tzs8Y6Askkr7rt5EfGB7UO7+zhXv7rqsH8X999Nngj7U/GSUT4b3SQztA5iCj51JqRW4MAPhKwufYHraeB47j//IaDnaXM5rCfjNMMKmYxsi8D+rsEzUFvwNXemdnyHZQlwZsYVk1fO0KFNgAE2iII28Pb6kapXaxybuqHF1HrnB/jmClNEf623Hd378uf3VfriWcgxt+okoxZy5WxTfqVcVU4kRmZvvYeRX5VON9oE4/w8GLWQO02Wy6P89nTtCuPYIrzekmDEJtWorKrdm188ayC9Zsit1yB9SgfHPieeqsbq8Ju+ie2Sya+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39840400004)(366004)(396003)(91956017)(5660300002)(36756003)(6506007)(6486002)(966005)(6512007)(26005)(2616005)(186003)(66446008)(76116006)(64756008)(66556008)(66946007)(66476007)(4326008)(2906002)(86362001)(83380400001)(478600001)(71200400001)(316002)(54906003)(8936002)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a0ZFTnNmaW1ST1RLZ3ZCeTFVMGR3SXcyWEhvOUlxbFhYSUpvdHRSTyt4KzZs?=
 =?utf-8?B?NEFBczAyZVA1YUhSVE1qYlZIMm1mWE9LdDZBZDk5Y250VGpVdno5NFNTeDBo?=
 =?utf-8?B?VDhlRjFQcHcwaWdVdmRId3pHVENjRnlqQ2ZoWDVIQlRLUXJPL3N3Tyt5VGF0?=
 =?utf-8?B?Qkh3cU5CK0hyT1VSWlJzY0IrTHpFcDlCczYvL0tKTzFPQjQxSHhWV21zVmlv?=
 =?utf-8?B?czk5b2hOb29kbHpHTm5YMFdMSmlnVW16dkliNGRBWGVFNDV6cFFDRktwVzE2?=
 =?utf-8?B?MVg0K2lzdXpDTkdlZXgyUktFRk5MNGNxcXlKclF3UFVFWk9KUWNBZTBnVTIr?=
 =?utf-8?B?SUNoOThMOGlTVStWa1F5NjBQNUhwRlk0Qmg4TVFDRGZocTZsN1R6amtIbXVx?=
 =?utf-8?B?aXk3NGhWRUdRVForL2FPWC91bVNPMVQ5Y0YvVFVUVjJBT2NodmdIZmFkb09u?=
 =?utf-8?B?RkxVRUR5YWlOUjYwNFdNSE9yVWxZSmduZ0Y0RUwwMG9Zd01NQWJ4cS9reVpQ?=
 =?utf-8?B?dlBoOUdJQTYzNy9oT0RyYjVKUEhEdU1XMjc5aFZvS0ZDUlB2OEk3d0Q0TCtH?=
 =?utf-8?B?c0xMUWJCTFZpc1YyZE1tNS9pYkduSlp5b1hlL1lENHk4cXF4d3ZCWWJRb0p2?=
 =?utf-8?B?dmZvVytjY09HbjkxemZDZklxNXhZOXlRRTY1MDZObkplQjhEYUdJWkttT2NO?=
 =?utf-8?B?OHc4eVZGdGlueUcxaDJ4b2JjTXlPSEgvSUF6RWNzNjBlR1Q5Y0VZVXJlNjNm?=
 =?utf-8?B?YlA3d3d6b3MxbmYzWFl1dGhwczhtNjI2aHpCazV5dktVSStwTE9ZM29ENFZr?=
 =?utf-8?B?MGc0TVFVRS9QRGp5dnRkRDlQWEl5R3kxUERZUjJxSmJUSmZveld5L3JZeDJP?=
 =?utf-8?B?anpjZWlkZVcwR3VmTnhoQU91cjQ0L2UwQnNLbCtscmxCR3p1bzVhNktxeDZR?=
 =?utf-8?B?QzFWV0d6U0NSOUdIOGdKdUFCS2RPWjRZbTA3ano2WG91NGdJQmhmM1IzSlJI?=
 =?utf-8?B?ZjgxT25yQzJ2REhrcks0VGZrN0xaZHUrNUJMZlRxa0VIQVY5c1owV1I3MFZP?=
 =?utf-8?B?dXp0Smo4WEtnTnZyQnF1eXRUaUpzM3ZEZW5NSGV3K2NOb1hKVnJFQlNZeXpI?=
 =?utf-8?B?bGRKVjZMdWFuNUUzME9hcEw5TVBJamFBTlh6d2ROOXg3Rm93eThXanY2MTBm?=
 =?utf-8?B?dG9hbHdSUHFuZUZkeEZZbmhyTTBWVG5hcGFWZERnMEk3Um1MQzJ4c2lTbVdm?=
 =?utf-8?B?S3RCclIrbnE5YUthbUhDandiRmw2alVPN3JUL2JWeHc5c0x0cDRhRHgwNjB0?=
 =?utf-8?Q?6AukO+0YBvwKxANlqqbYmV2mr3Bsl56NwH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <35C9154F439D19419258D2309C1739AF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fff860-0312-4b67-8633-08d897c9e130
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 20:27:39.4731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/6jsE+RTL7vvds/QvbXpzw/LUxAVX3GrL/m/d7CtU4y9GNtEECFaag4kf1/pu9tZfysyIqAt3Ashwmwr3q35A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4241
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDEzOjUxIC0wNTAwLCBiZmllbGRzIHdyb3RlOg0KPiBPbiBU
aHUsIERlYyAwMywgMjAyMCBhdCAxMjoyMDozNVBNICswMDAwLCBEYWlyZSBCeXJuZSB3cm90ZToN
Cj4gPiBKdXN0IGEgc21hbGwgdXBkYXRlIGJhc2VkIG9uIHRoZSBtb3N0IHJlY2VudCBwYXRjaHNl
dHMgZnJvbSBUcm9uZCAmDQo+ID4gQnJ1Y2U6DQo+ID4gDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW5mcy9saXN0Lz9zZXJpZXM9MzkzNTY3DQo+ID4gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW5mcy9saXN0Lz9zZXJpZXM9
MzkzNTYxDQo+ID4gDQo+ID4gRm9yIHRoZSB3cml0ZS10aHJvdWdoIHRlc3RzLCB0aGUgTkZTdjMg
cmUtZXhwb3J0IG9mIGEgTkZTdjQuMg0KPiA+IHNlcnZlcg0KPiA+IGhhcyB0cmltbWVkIGFuIGV4
dHJhIEdFVEFUVFI6DQo+ID4gDQo+ID4gQmVmb3JlOiBvcmlnaW5hdGluZyBzZXJ2ZXIgPC0gKHZl
cnM9NC4yKSA8LSByZWV4cG9ydCBzZXJ2ZXIgLQ0KPiA+ICh2ZXJzPTMpDQo+ID4gPC0gY2xpZW50
IHdyaXRpbmcgPSBXUklURSxDT01NSVQsR0VUQVRUUiAuLi4uIHJlcGVhdGluZw0KPiA+IMKgDQo+
ID4gQWZ0ZXI6IG9yaWdpbmF0aW5nIHNlcnZlciA8LSAodmVycz00LjIpIDwtIHJlZXhwb3J0IHNl
cnZlciAtDQo+ID4gKHZlcnM9MykNCj4gPiA8LSBjbGllbnQgd3JpdGluZyA9IFdSSVRFLENPTU1J
VCAuLi4uIHJlcGVhdGluZw0KPiA+IA0KPiA+IEknbSBhc3N1bWluZyB0aGlzIGlzIHNwZWNpZmlj
YWxseSBkdWUgdG8gdGhlICJFWFBPUlRfT1BfTk9XQ0MiDQo+ID4gcGF0Y2g/DQo+IA0KPiBQcm9i
YWJseSBzbywgdGhhbmtzIGZvciB0aGUgdXBkYXRlLg0KPiANCj4gPiBBbGwgb3RoZXIgY29tYmlu
YXRpb25zIGxvb2sgdGhlIHNhbWUgYXMgYmVmb3JlIChmb3Igd3JpdGUtdGhyb3VnaCkuDQo+ID4g
QW4NCj4gPiBORlN2NC4yIHJlLWV4cG9ydCBvZiBhIE5GU3YzIHNlcnZlciBpcyBzdGlsbCB0aGUg
YmVzdC9pZGVhbCBpbg0KPiA+IHRlcm1zDQo+ID4gb2Ygbm90IGluY3VycmluZyBleHRyYSBtZXRh
ZGF0YSByb3VuZHRyaXBzIHdoZW4gd3JpdGluZy4NCj4gPiANCj4gPiBJdCdzIGdyZWF0IHRvIHNl
ZSB0aGlzIHJlLWV4cG9ydCBzY2VuYXJpbyBiZWNvbWluZyBhIGJldHRlcg0KPiA+IHN1cHBvcnRl
ZA0KPiA+IChhbmQgcGVyZm9ybWluZykgdG9wb2xvZ3k7IG1hbnkgdGhhbmtzIGFsbC4NCj4gDQo+
IEkndmUgYmVlbiBzY3JhdGNoaW5nIG15IGhlYWQgb3ZlciBob3cgdG8gaGFuZGxlIHJlYm9vdCBv
ZiBhIHJlLQ0KPiBleHBvcnRpbmcNCj4gc2VydmVyLsKgIEkgdGhpbmsgb25lIHdheSB0byBmaXgg
aXQgbWlnaHQgYmUganVzdCB0byBhbGxvdyB0aGUgcmUtDQo+IGV4cG9ydA0KPiBzZXJ2ZXIgdG8g
cGFzcyBhbG9uZyByZWNsYWltcyB0byB0aGUgb3JpZ2luYWwgc2VydmVyIGFzIGl0IHJlY2VpdmVz
DQo+IHRoZW0NCj4gZnJvbSBpdHMgb3duIGNsaWVudHMuwqAgSXQgbWlnaHQgcmVxdWlyZSBzb21l
IHByb3RvY29sIHR3ZWFrcywgSSdtIG5vdA0KPiBzdXJlLsKgIEknbGwgdHJ5IHRvIGdldCBteSB0
aG91Z2h0cyBpbiBvcmRlciBhbmQgcHJvcG9zZSBzb21ldGhpbmcuDQo+IA0KDQpJdCdzIG1vcmUg
Y29tcGxpY2F0ZWQgdGhhbiB0aGF0LiBJZiB0aGUgcmUtZXhwb3J0aW5nIHNlcnZlciByZWJvb3Rz
LA0KYnV0IHRoZSBvcmlnaW5hbCBzZXJ2ZXIgZG9lcyBub3QsIHRoZW4gdW5sZXNzIHRoYXQgcmUt
ZXhwb3J0aW5nIHNlcnZlcg0KcGVyc2lzdGVkIGl0cyBsZWFzZSBhbmQgYSBmdWxsIHNldCBvZiBz
dGF0ZWlkcyBzb21ld2hlcmUsIGl0IHdpbGwgbm90DQpiZSBhYmxlIHRvIGF0b21pY2FsbHkgcmVj
bGFpbSBkZWxlZ2F0aW9uIGFuZCBsb2NrIHN0YXRlIG9uIHRoZSBzZXJ2ZXINCm9uIGJlaGFsZiBv
ZiBpdHMgY2xpZW50cy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
