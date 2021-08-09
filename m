Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56923E476F
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 16:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhHIOXG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 10:23:06 -0400
Received: from mail-co1nam11on2128.outbound.protection.outlook.com ([40.107.220.128]:56312
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234075AbhHIOXG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 10:23:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBDvDnoGvZa/Xb0+ESpVqXdZmNtoPJmQ3igO+yuOFtTcaOLJi7O6n4U+X6SeY3R4XY27T3PYYMfCQg/VXf1iwMoU3A/CrI0QX3GJrwxtXm4F0EQy5l314Wq/76HTnwP24gm8xecasXWn2+znjOCNWyo7XoLfbcwZGU6jxJlGBHc3YOOpRStjQtdXZOWPGAERa+f/pR4989LhkL5uvJl5Jg6/0nMX9USdx7MOEJGlHFLVqzg9AhP6o4bj++IdbOLigivkoN41TzqqDVgS8MZFU9/HbzLb7lsrQUhJ0TftLBe6JhcymWbpBWPxr16P5ZMlc7t3A8s3zvIC2AN5dVSj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUSF2daan/z75bGJdxrcJtnIJkYnQVdpA/jm6SUrkPU=;
 b=JwaMN4Zi5LO8CrM9mD5tJ1XrYpLRpqiFsVBApAshCfpXdm4oZv/wkSLD9BB2gbgg8V3Yyjq4yRA8QELNJlCYV0NtX8RlCebdXQRX1Z9aZ4QCbq4fnvZ5lZrBdbnPj5ylmn3HGC3qdc6zxxEOS2CF51XNe1spfn2BTXtRhTWw3aDt3ep+VLwHXlWmKUP+aN6GdDlodBVxwWvKUPQH76TuqEHQdKajUv0dNhs9GR5DTydmvFYhCETfslK6YF8G7U7xmoyekTCtT0rnvpbr1Y4SlcX/VH+NCzu7IyVpCRanMDUpH7WxDVubSJJL2vnF1kd4LiYllq5X6kQ/FCuP6mQiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUSF2daan/z75bGJdxrcJtnIJkYnQVdpA/jm6SUrkPU=;
 b=H2O3krurCg8juIDFqAI5AstCizP+5KeN8V42i6Hrm2inJSb4NjKcWsy/nWWcZdMjceEcTDZx/JvfEgSPoXAnmCdTBetTG3CdJggNcRQjGvUWKd1499+lKIeH00aZ8y4ctBh/NwUgNnpvzmXb6GuhF84yM0doVdABD2t2I4LaMC0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3766.namprd13.prod.outlook.com (2603:10b6:610:9d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.6; Mon, 9 Aug
 2021 14:22:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4415.012; Mon, 9 Aug 2021
 14:22:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ9owuGm7b0CEqtoxaJkItc06tbmWqAgAao74CAAAokgIAACEIAgAACAoCAACJ2AIAAA5WAgAAQJoCAAAG1gIAAB2KAgAACOwCACAjwAIAAqEWA
Date:   Mon, 9 Aug 2021 14:22:42 +0000
Message-ID: <960504100073731731f249c74ac59d933324408d.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>   ,
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>       ,
 <20210803203051.GA3043@fieldses.org>   ,
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>       ,
 <20210803213642.GA4042@fieldses.org>   ,
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>       ,
 <162803443497.32159.4120609262211305187@noble.neil.brown.name> ,
 <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>       ,
 <162803867150.32159.9013174090922030713@noble.neil.brown.name> ,
 <ea79c8676bea627bb78c57e33199229e3cf27a9c.camel@hammerspace.com>       ,
 <162804062307.32159.5606967736886802956@noble.neil.brown.name> ,
 <dfe4f6ad0420a67b9ae0f500324ba976d700642c.camel@hammerspace.com>
         <162848282650.22632.1924568027690604292@noble.neil.brown.name>
In-Reply-To: <162848282650.22632.1924568027690604292@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 821c5cf9-cbd0-4b21-4e80-08d95b4126d6
x-ms-traffictypediagnostic: CH2PR13MB3766:
x-microsoft-antispam-prvs: <CH2PR13MB3766A19962A1D8CB01BA5158B8F69@CH2PR13MB3766.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l3w8ccnXcF7RdMSAkWGhUW1+7Gon6nr83pq2aCed/wNrFVzXPi5W1QbEjS3/OW0qIyp6M5qpGWre3AB51D9nRRf6gEaTT3oTIM/oS1D9S53dbXwsNnz61uZtge7u6oVrtwF01PCLOCw79j6cuCo4TnpdkP3HZtO0o54mtjXHCnUOaqUm3xgXRNr5xLGzkRrMV/CmyajxuJJ229JG6ROCA7rtmdes000Sek1u0/YWIwSCs8h2MrFyaPXqNsxgRhxys0AKlaDCG2xKv8w7F42fHWMBH63UivKCN431DuDQvvM2wtwYVttrVt56lX8qfzUFRd/I8y3k0ZzYvaZFz9C0DGog4AtXbqq5n6D9mSBlJE6TnVtNlpgZUdcIfaxvIwXf52KyUKAM6MLgsLidHso7+qaTPA7qx8J9F4V4sM5O+3Xj/ba6jpFOw0drqYTMxaS26C6fvUmE+0cJn9VUTMOwupxfSgqYlg62fGFsZi1dksIOUvkwSvDOjsLobB0hZ/BEUg6mL3c0gnb58jLrBpfn8zWRHjvclp8dYuSveWYqv+4JPPMRb8KY+LCo6XPsAJP8CPGKJiz0CTl7YRbl65JzExTWCcGKoLAC3+iP0/UwhkoCKvLxdIJMq2VMqpt3Zy/ZZg9WFjImt3+URyD5BEWwBEOpcV1pfQ9HsHYsH3whqxV9XTEewDeUa8AVaMH61CoXm02EJWKn11ForrzVOY1eMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39830400003)(366004)(136003)(346002)(76116006)(6506007)(54906003)(66556008)(64756008)(66446008)(66476007)(36756003)(66946007)(2616005)(2906002)(26005)(316002)(6916009)(122000001)(71200400001)(6512007)(8676002)(38100700002)(6486002)(8936002)(5660300002)(86362001)(38070700005)(478600001)(186003)(83380400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWhhRWFWMTRCcE1hcktjSjJ6cGZLc0x0TjVUUVNsTU56SUVUSUVhZnBpamts?=
 =?utf-8?B?ck81a0FGOU5QaTZNQWRiTzBQVjZiYnpIdUx0VHlkbEU3QzFTS3ZmM3RURGlv?=
 =?utf-8?B?MkNLVlZTTzJBeFo2SHcyT0ZadlhQOXdOYndhZDdQaE1yOXVhRWhDNFY5Z0Jz?=
 =?utf-8?B?ZHlyRFJDWWNWbkRmRUZwVHBrWmMzSHpGK1JFNzdRbnB5NHVROGJDUExlT3Ax?=
 =?utf-8?B?QlpLZnIzMXUvc1lHSHVUKzJlOGJzOUNaanZ2N3lUVklGVkk2T0J1cVhuT2du?=
 =?utf-8?B?alA5SEZkdUpzZjJnUGIzWndmZXYwZG0zYm1zeWNuVXBwQUQzWi9CUnJ2V2Nx?=
 =?utf-8?B?dWg0U0NWR2tpdFBZQjVLazZKVWYxME5Yc0Q5d0ZGOVh2cmpMVndmUktVNjdN?=
 =?utf-8?B?Y3FKTTBncyt0OEp6MG4rdnB0c2w0RTl4THFvTVNjZ2tDbWVRby80TlJWdmdM?=
 =?utf-8?B?S3pER0hJWFFTMVdQL09IdDk3YUVWcThqek44OVp0TDZacXU3WnBFdzhhQXZL?=
 =?utf-8?B?cFZyOHlLQy9paXBnWlRhZFQrcTlDdG8vYlcxcGYzOTdXbXloSUlQR25aaXcr?=
 =?utf-8?B?M0pKLzlObjRram1xeVFyeWwveDg5T2c4YUxqZlp4aXVWeEw3ZExsWi9jcStC?=
 =?utf-8?B?Q3U0UGhFWnZaR081eG5YSHVGVVJ0M1UwZmdMVkI0bjdhVVNJWDRKSXdHcG5J?=
 =?utf-8?B?VGtuV1RNTTVlK2VTa1crcGE1ZHQwUzM0YVdyeVBYSUhYWGZXK01abzFTUmo2?=
 =?utf-8?B?UE95WUhVSmQ4bCs4QzV3R3dnNDk3L0dUTEZaSEw5Z0dmN09rcVBPQWp3V1BW?=
 =?utf-8?B?cU1TNFBpcDBxRW1hTktFUkJhRjVwSVY2Y2FiNDFyZ2w1RnJPc3l2eVBFdUli?=
 =?utf-8?B?dnV6clJsNHFVV0VIQWhXS283WXBIUEVtay9QVjFnNTlrL0dqZGVqa3N4UkJQ?=
 =?utf-8?B?K045ZmVVeFl1RWNrV1BNUTJCNnFlakx5NVdoZExCZVo3KzdhbGtEZVNBemR5?=
 =?utf-8?B?ckdnTXBjQXd6dDJlRGNvSHQvTkpvNFZLcElDL1BJY1BBRnFML3N1TVhmNWVy?=
 =?utf-8?B?NE1VcXlaS0gxcHBlVXhzeG9ma1NCQ29hb0k2YVNqZXNYMjNjblkvRTR4d1ZW?=
 =?utf-8?B?aTAyTnpSeEhUK3ViY0pVMHNZUEd4SFRLNEhodlFyeXpjV0FhVDZOYm1FVms1?=
 =?utf-8?B?TnRicThySGVMTEhVRHA0VkttUS9jSHB2eUxSazZhYjRxdEl3dHFOMDl5V0Z0?=
 =?utf-8?B?WFFzODZzV1dOaDl0VVFrMGgwbzByMWUxTVVGUmIzN3pVQjRvSFFxd1lWVGRU?=
 =?utf-8?B?T1Y5R1BjdGZZNTdpWTgvNGNyQkhnaUtUcitYTUxCa3A5TFhEMkxQVU42OEls?=
 =?utf-8?B?MzV4aHVvVXlBekRJZFE3bVlwMUpCek9EdTVVaVF6SVZCVk94OFNlU2tkZmo4?=
 =?utf-8?B?QmVjNEdDSkt6SFdYV2NQMzM3bldlTGlZZnN5andIUlhGR09QMU5rZ2FPZk1W?=
 =?utf-8?B?TXlsUUtUYmJBQlZSOXpFOWh3ME5XWkJ2akhWaEFuckJQWDlxYWxiMTczQ1Yy?=
 =?utf-8?B?c0dpYjhrQTFsY1JJZnNyQ0lkVlMxVlA3TzJINHRZTVNyTEVrT3owU2pzS2pp?=
 =?utf-8?B?Q2x5amh5TlkyTGJlZ2lVd1hybFMrQUlSNVdCd0xEL0g0WVVEdE5tM29xK3BC?=
 =?utf-8?B?cmw2b2NHbFppVlFUUndjNjBtamczbFJyNWxTcXVFMWFiU2MzcTdhQzNrZERV?=
 =?utf-8?Q?XLvRrILPXjsMnOZ8y1r2fAJkBURkOg3MlhLRy+V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <44BE7AE36C13A24B9EC7E38527DEC4B2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821c5cf9-cbd0-4b21-4e80-08d95b4126d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 14:22:42.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RebTi2v/LsoBCJ8+T6U5szFd/592H5gQHIodUq2Z1JL7Jd79i7WJNSKz0JLVc2F82+YS0bPOo6YAEa4vJn0C7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3766
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTA5IGF0IDE0OjIwICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMDQgQXVnIDIwMjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBXZWQsIDIw
MjEtMDgtMDQgYXQgMTE6MzAgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiANCj4gPiBDYWNo
aW5nIG5vdCBhICJiZXN0IGVmZm9ydCIgYXR0ZW1wdC4gVGhlIGNsaWVudCBpcyBleHBlY3RlZCB0
bw0KPiA+IHByb3ZpZGUNCj4gPiBhIHBlcmZlY3QgcmVwcm9kdWN0aW9uIG9mIHRoZSBkYXRhIHN0
b3JlZCBvbiB0aGUgc2VydmVyIGluIHRoZSBjYXNlDQo+ID4gd2hlcmUgdGhlcmUgaXMgbm8gY2xv
c2UtdG8tb3BlbiB2aW9sYXRpb24uDQo+ID4gSW4gdGhlIGNhc2Ugd2hlcmUgdGhlcmUgYXJlIGNs
b3NlLXRvLW9wZW4gdmlvbGF0aW9ucyB0aGVuIHRoZXJlIGFyZQ0KPiA+IHR3bw0KPiA+IGNhc2Vz
Og0KPiA+IA0KPiA+IMKgwqAgMS4gVGhlIHVzZXIgY2FyZXMsIGFuZCBpcyB1c2luZyB1bmNhY2hl
ZCBJL08gdG9nZXRoZXIgd2l0aCBhDQo+ID4gwqDCoMKgwqDCoCBzeW5jaHJvbmlzYXRpb24gcHJv
dG9jb2wgaW4gb3JkZXIgdG8gbWl0aWdhdGUgYW55DQo+ID4gZGF0YSttZXRhZGF0YQ0KPiA+IMKg
wqDCoMKgwqAgZGlzY3JlcGFuY2llcyBiZXR3ZWVuIHRoZSBjbGllbnQgYW5kIHNlcnZlci4NCj4g
PiDCoMKgIDIuIFRoZSB1c2VyIGRvZXNuJ3QgY2FyZSwgYW5kIHdlJ3JlIGluIHRoZSBzdGFuZGFy
ZCBidWZmZXJlZCBJL08NCj4gPiDCoMKgwqDCoMKgIGNhc2UuDQo+ID4gDQo+ID4gDQo+ID4gV2h5
IGFyZSB5b3UgYW5kIEJydWNlIGluc2lzdGluZyB0aGF0IGNhc2UgKDIpIG5lZWRzIHRvIGJlIHRy
ZWF0ZWQNCj4gPiBhcw0KPiA+IHNwZWNpYWw/DQo+IA0KPiBJIGRvbid0IHNlZSB0aGVzZSBhcyB0
aGUgcmVsZXZhbnQgY2FzZXMuwqAgVGhleSBzZWVtIHRvIGFzc3VtZSB0aGF0DQo+ICJ0aGUNCj4g
dXNlciIgaXMgYSBzaW5nbGUgZW50aXR5IHdpdGggYSBjb2hlcmVudCBvcGluaW9uLsKgIEkgZG9u
J3QgdGhpbmsgdGhhdA0KPiBpcw0KPiBuZWNlc3NhcmlseSB0aGUgY2FzZS4NCj4gDQo+IEkgdGhp
bmsgaXQgYmVzdCB0byBmb2N1cyBvbiB0aGUgYmVoYXZpb3VycywgYW5kIGludGVudGlvbnMgYmVo
aW5kLA0KPiBpbmRpdmlkdWFsIGFwcGxpY2F0aW9ucy7CoCBZb3Ugc2FpZCBwcmV2aW91c2x5IHRo
YXQgTkZTIGRvZXNuJ3QNCj4gcHJvdmlkZQ0KPiBjYWNoZXMgZm9yIGFwcGxpY2F0aW9ucywgb25s
eSBmb3Igd2hvbGUgY2xpZW50cy7CoCBUaGlzIGlzIG9idmlvdXNseQ0KPiB0cnVlDQo+IGJ1dCBJ
IHRoaW5rIGl0IG1pc3NlcyBhbiBpbXBvcnRhbnQgcG9pbnQuwqAgV2hpbGUgdGhlIGNhY2hlIGJl
bG9uZ3MgdG8NCj4gdGhlIHdob2xlIGNsaWVudCwgdGhlICJvcGVuIiBhbmQgImNsb3NlIiBhcmUg
cGVyZm9ybWVkIGJ5IGluZGl2aWR1YWwNCj4gYXBwbGljYXRpb25zLsKgIGNsb3NlLXRvLW9wZW4g
YWRkcmVzc2VzIHdoYXQgaGFwcGVucyBiZXR3ZWVuIGEgQ0xPU0UNCj4gYW5kDQo+IGFuIE9QRU4u
DQo+IA0KPiBXaGlsZSBpdCBtYXkgYmUgcmVhc29uYWJsZSB0byBhY2NlcHQgdGhhdCBhbnkgYXBw
bGljYXRpb24gbXVzdCBkZXBlbmQNCj4gb24NCj4gY29ycmVjdG5lc3Mgb2YgYW55IG90aGVyIGFw
cGxpY2F0aW9uIHdpdGggd3JpdGUgYWNjZXNzIHRvIHRoZSBmaWxlLA0KPiBpdA0KPiBkb2Vzbid0
IG5lY2Vzc2FyeSBmb2xsb3cgdGhhdCBhbnkgYXBwbGljYXRpb24gY2FuIG9ubHkgYmUgY29ycmVj
dA0KPiB3aGVuDQo+IGFsbCBhcHBsaWNhdGlvbnMgd2l0aCByZWFkIGFjY2VzcyBhcmUgd2VsbCBi
ZWhhdmVkLg0KPiANCj4gSWYgYW4gYXBwbGljYXRpb24gYXJyYW5nZXMsIHRocm91Z2ggc29tZSBl
eHRlcm5hbCBtZWFucywgdG8gb25seSBvcGVuDQo+IGENCj4gZmlsZSBhZnRlciBhbGwgcG9zc2li
bGUgd3JpdGluZyBhcHBsaWNhdGlvbiBoYXZlIGNsb3NlZCBpdCwgdGhlbiB0aGUNCj4gTkZTDQo+
IGNhY2hpbmcgc2hvdWxkIG5vdCBnZXQgaW4gdGhlIHdheSBmb3IgdGhlIGFwcGxpY2F0aW9uIGJl
aW5nIGFibGUgdG8NCj4gcmVhZA0KPiBhbnl0aGluZyB0aGF0IHRoZSBvdGhlciBhcHBsaWNhdGlv
bihzKSB3cm90ZS7CoCBUaGlzLCBpdCBtZSwgaXMgdGhlDQo+IGNvcmUNCj4gb2YgY2xvc2UtdG8t
b3BlbiBjb25zaXN0ZW5jeS4NCj4gDQo+IEFub3RoZXIgYXBwbGljYXRpb24gd3JpdGluZyBjb25j
dXJyZW50bHkgbWF5LCBvZiBjb3Vyc2UsIGFmZmVjdCB0aGUNCj4gcmVhZA0KPiByZXN1bHRzIGlu
IGFuIHVucHJlZGljdGFibGUgd2F5LsKgIEhvd2V2ZXIgYW5vdGhlciBhcHBsaWNhdGlvbiBSRUFE
SU5HDQo+IGNvbmN1cnJlbnRseSBzaG91bGQgbm90IGFmZmVjdCBhbiBhcHBsaWNhdGlvbiB3aGlj
aCBpcyBjYXJlZnVsbHkNCj4gc2VyaWFsaXNlZCB3aXRoIGFueSB3cml0ZXJzLg0KPiANCg0KVGhh
dCdzIGEgZGlzY3Vzc2lvbiB3ZSBjYW4gaGF2ZSBhZnRlciBCcnVjZSBhbmQgQ2h1Y2sgaW1wbGVt
ZW50IHJlYWQNCmFuZCB3cml0ZSBkZWxlZ2F0aW9ucyB0aGF0IGFyZSBhbHdheXMgaGFuZGVkIG91
dCB3aGVuIHBvc3NpYmxlLiBVbnRpbA0KdGhhdCdzIHRoZSBjYXNlLCB0aGVyZSB3aWxsIGJlIG5v
IGNoYW5nZXMgbWFkZSB0byB0aGUgY2xvc2UtdG8tb3Blbg0KYmVoYXZpb3VyIG9uIHRoZSBMaW51
eCBORlN2NCBjbGllbnQuDQoNCkFzIGZvciBORlN2MywgSSBkb24ndCBzZWUgdGhlIGFib3ZlIHN1
Z2dlc3Rpb24gZXZlciBiZWluZyBpbXBsZW1lbnRlZA0KaW4gdGhlIExpbnV4IGNsaWVudCBiZWNh
dXNlIGF0IHRoaXMgcG9pbnQsIHBlb3BsZSBkZWxpYmVyYXRlbHkgY2hvb3NpbmcNCk5GU3YzIGFy
ZSBkb2luZyBzbyBhbG1vc3QgZXhjbHVzaXZlbHkgZm9yIHBlcmZvcm1hbmNlIHJlYXNvbnMuDQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
