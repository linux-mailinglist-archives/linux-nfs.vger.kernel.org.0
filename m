Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454B242E47A
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 00:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJNW5f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 18:57:35 -0400
Received: from mail-bn1nam07on2130.outbound.protection.outlook.com ([40.107.212.130]:24228
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230512AbhJNW5d (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 14 Oct 2021 18:57:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lad9yEvRwPnpcPBSkByv5C0wAAIobh3Pi8vVCfSmqFeuu+FDZZkOdVEV6AEFyOEDhFmwlkRv+xONKb6Z9T4FTB1bwLyTyU5C0+iVnPjSYE67H+STLt0VRSZOuPA9Ypd3ytBpFIW2w68nZjHK/+C2iCxkYEEQhEOcCrSAQBAOllUE/fYEKjdf4n0E+GFOXoXUxwcY3IhDS0zZ53139Aw8OMgiGZQWPkU3JWjXupEIbebE6hYyFsYvVdwTb7GBvkUs7RgvirOsjpMp1bIC7d4ce3nNZaXH4EOUedAy37nm3nJzPEGpIl3n2Nyt/ni4mKt9mqN+0nU34/6bxmJjXYSBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SAyjv86Ktg5AWDRk4138oQZ4w52hgRHiVc7oOe2GIk=;
 b=Iuz7qgP2c3icgILXNIBIZBPINaRfwHfRY6hYyaUr9HQfROkp2x5Bpdqke5Tg+Rn2UoP1hgZ0JerOqPbQ/Lj+gA1TXsRC4lYo2wk3P9ytkBtxgDJCMkz09Xp5/bYxVWKecxG7TUI2kkoIy257L79tHvzpgpphDnrsDRBepa8JJtnQ/lG3fEd49EepJgGAhmF+eBWsHJZcsr2f7XbXkeLuxY0gjv0NEPoHNNXb1J32iD/Wa0/8mf1ajZ34vIS++Ay1iKXurFKDx05BAr8VfBcsZPiKqWJ7qy7pPq31o4+cpwPQjvFJB5eyIhPnW8P5ChqwzFFV0KOaRwbrWY4V9Fn2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SAyjv86Ktg5AWDRk4138oQZ4w52hgRHiVc7oOe2GIk=;
 b=Tkh2onH6MgVsdi0LDF7yn5dpaiYzgjI7d8WNHDGRGUZqPRSEs5o7ybLR1tg1jQNxaf/KLKeRcCWzyAf9KG7zLUQ7LVuMOVVGSVwM90a/9ia9O8dI4rUT3sKpKI6pOOzaUNipyvVGQXrFaR27so2168tiujprWRur8Y//EDjRf1s=
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by MN2PR14MB3999.namprd14.prod.outlook.com (2603:10b6:208:19a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 14 Oct
 2021 22:55:26 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::e9f9:a6a2:de33:e91]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::e9f9:a6a2:de33:e91%7]) with mapi id 15.20.4608.017; Thu, 14 Oct 2021
 22:55:26 +0000
From:   Charles Hedrick <hedrick@rutgers.edu>
To:     NeilBrown <neilb@suse.de>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: more problems with NFS. sort of repeatable problem with vmplayer
Thread-Topic: more problems with NFS. sort of repeatable problem with vmplayer
Thread-Index: AQHXuiGsqc+X5CxXXUyyoyieE0MeDavOf4cAgASpXU4=
Date:   Thu, 14 Oct 2021 22:55:26 +0000
Message-ID: <BA9C2730-FE48-4FBD-A37C-A9E46168594E@rutgers.edu>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>,
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>,
 <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>,
 <1EA88CB0-7639-479C-AB1D-CAF5C67AA5C5@redhat.com>,
 <22DE8966-253D-49A7-936D-F0A0B5246BE6@rutgers.edu>,
 <08DD4F45-E1CB-4FCB-BA0C-A6B8BD86FEDE@redhat.com>,
 <5F282359-128D-4F72-B393-B87956DFE458@oracle.com>,
 <EE014097-EDF8-484B-81DF-9E7012122BB9@rutgers.edu>,
 <70E12E3F-2DFB-4557-9541-67276E5A195C@rutgers.edu>,
 <2C0DB856-23E5-41A2-A9F5-6E64F5A9FCB6@cs.rutgers.edu>
 <163399585460.17149.13892990608606706424@noble.neil.brown.name>
In-Reply-To: <163399585460.17149.13892990608606706424@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5d472e1-08d5-49dd-7490-08d98f65b694
x-ms-traffictypediagnostic: MN2PR14MB3999:
x-microsoft-antispam-prvs: <MN2PR14MB39991EDE0DA2948269B205F0AAB89@MN2PR14MB3999.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SHsbIOfFKOem2Wwd10nQR04/j+oec/MiF9VxOkTW3B1QsxrFOFqA2PO1pryzNQfQgQs2qI7PjhonOuJqTkDOOQU9gq1dEwUEGoLZNdUa1TmEyOPncPxZsxiEBqqi5sBMD+Bz+EdGh8B5Wc1HCLyU/U380v4zsNEB72/XniZnYVbHU+MIyq6OMDPsuJkccF6+gl996doeF2c00vY3B/JFrEgTqurUZLPS9GopXfLTyESUmHhcCHX3JHbc1Po+cZoSBUy5ayz4PCTqBD/YP1xK7XOILsN3qkFjooFnGu1TFb3hvcfkl2iyr4f13OBdeMFiNiIY1v4S9Jr79N59joqGIWbowlBadNpRiII39voOkYND46sD/lgYT7F/42L3TzjvE4MvLHNGji5UlBrRn8N4qMz/hnEpmYyvPHmiatCmtMID3P2rQi5d9najIWHLHCN2567dEHI4186ESTzvGLxt5HOWeOhVY9An5IzDHxZmp+qI7lUhnyQK6H8KN1Q01NopzAfnvSIv/Ad6mXQormhYsSrKVNDscUODsm08z9sOSQDKjIQQ/a8snIfhHYXVWZY1tMMBEQJ97aQxk3gYay3TEOISpzLzO1Eq+RjKy29gNmgzqSAAEGmzYEjQNcsbQWgr11q27BYem4DZEVavc7RbXqWcBIFvxP7fJW6ytHpuPhI2pHEHtquUCkqjnwK6su4BBAUrohmD462vXejMwXTWBxGivlMlAp++0IAnKKBDug0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(38100700002)(508600001)(6512007)(122000001)(8936002)(2616005)(6916009)(75432002)(53546011)(38070700005)(2906002)(36756003)(26005)(786003)(66446008)(66946007)(6486002)(66556008)(64756008)(66476007)(6506007)(83380400001)(316002)(4326008)(5660300002)(54906003)(76116006)(71200400001)(86362001)(33656002)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aER4WmZwa3I4N3A5bXN0RC9UWEwrUXZQcUc2dWlKTzdjejk0OUpTZWIranZ0?=
 =?utf-8?B?S2ErazVlOGpvb2wyNmhodXFIL2Ewek5pemtZWFFuYkNFWEVIRERKeEFmT0xH?=
 =?utf-8?B?VzJhZ0d1MTlEV000SHoxT1kzVitwa2oxb3BqK09yUS9JZElsTi9VM2FkeU9V?=
 =?utf-8?B?Y2lxKytJUlVGdThCRE9aUTlGTmQ4eVBFZ0pWVGVabzlEdTF5dWVmZWZPM0Qv?=
 =?utf-8?B?Uk5EcS8rUG40eEVCNmF4aW5sR0FHQTNQdjR4ZEp0dDgwM21BTnU4QXEzaUVj?=
 =?utf-8?B?K2ROOEpVanR4ZlY0Y1huUHZGbU9jQjZxQ002SStZZ0JPU1lPZTYzcDF1YlRV?=
 =?utf-8?B?NGdkWWpTQ0x3VDM4S0E4aE5WWTB4cDczVXR6dGZ2c01ZdGRWck8xUHNoMEJr?=
 =?utf-8?B?aTY0UFlZSmF3Q2ozTDI4aFJIcXM3M1Bsb2diWlFDOUE3d0QvSkYyN2pSSm9O?=
 =?utf-8?B?SUVFaXEwQ0ovZVlpbkRlRjc2TTBuZG94aVZGVElPOU9ETDkzQmx1dDI4QmZK?=
 =?utf-8?B?Unh6aStJbFVGVVhXN1E0M2kwbmwrbWlFOGZvdnJsSWFTK0xpQ29GUU5lV1hO?=
 =?utf-8?B?ZXNNMUZtNkUrM3FZd3FTcXh6Ui8zQzE2aERXTkUrM0xQNUEvVmZVYWUxcWd5?=
 =?utf-8?B?SjRhZzhRcXhyN3E0UzZJcnhZTE44YytUdEhIMFN2L2VkRmQzVHhiSkNpTjIv?=
 =?utf-8?B?UWVSTVJPalF3cG9Wd3NxWVF3N2xIcWkydTNWdXp4NFJXRHNoMjhuSjRscGlF?=
 =?utf-8?B?aUd2MThVNWxwcHYvM1NNRXozNlUzVXpYYnFRbnFUZ3ljTG9DUTJpRER3QXo0?=
 =?utf-8?B?ZUJkQVpvZlZJaEVkeWpReEdDNjE1VnNPbFVDSlVGcGs0QW1RNE9GZ2hXcitB?=
 =?utf-8?B?Y2ZmQ2Fhd2RIN0RGUFBWV3lhL2JEVHZEVTV4SmluUkNzTmZFTkovNC81WjlE?=
 =?utf-8?B?ejBkYzI5aDNDWUFLRGpwNUtUaW9KQm9RQ241Q0s3aDR6MUxpSFhhYm9rTmkv?=
 =?utf-8?B?UHBMSnBnSnpWbnk0Y1BMZU1yQ2tJMnZsTlVRMGRQNVhUeHQ5MU8xL1lydDQ0?=
 =?utf-8?B?VWVVcURSZG9tdzJvd3lFaStFSkhFZEJzTEQxU2g2RUFHSGI4aHl0SzFpZXZr?=
 =?utf-8?B?anpaU0ZWa0tMaWplb0hUT0l2THQ3Mis4aG10VnV0eEpnZjAwRkVuc0p1czJC?=
 =?utf-8?B?bmVBR2U1Z0NuMFR6T09ia0RXWTdjcDhzK21Db2w0enlhdXdwM1VvQTdQT1Y1?=
 =?utf-8?B?cnlybis1dmlwMXh5SHBLYTQxVDROS3gvMUk2bStSdktrK2xvZmFZRVZSQ2x5?=
 =?utf-8?B?akd5NndKODFsanU5eWE0WW1ZOXNLU2lCVFN4WmM1RUtYa2pQVVpHSzR0cmtX?=
 =?utf-8?B?MnhTSnM5b3F1MXFYSEhzOEdPT3R4QlFCeTJqL3V6UGJpVlhzT01sNXhJdmxm?=
 =?utf-8?B?Nm5xbDhVNURwb093VUtWTXdYamM1ejJwS3EyOVhld0ZQVGpVSTlnYzN6aDdj?=
 =?utf-8?B?QXowTkF4Q2czY2QxNlB2N1l0RVpCb3FrRWpxRjczS2NXVUtLbW9jcXUrV2Fu?=
 =?utf-8?B?Q3QzWEMrZEEvZi8wUCswSThhTGl3RFhlVkpMaXVyelFOSHh1aDROSkY4azJH?=
 =?utf-8?B?ZkR1blZYVjVsQVR5TGxCQ09IMHg0cTV6cS9CWXNRR1ZhZUZHWXhCWTg5Y20w?=
 =?utf-8?B?c00zdUV4cEdMeGZ6S2x6YTVVV1NadmV4L2pQcDhpQlVmZjVONkV6aXJlK3VF?=
 =?utf-8?Q?cR6Z0Avl5akBRjQAsSqpKp3tBkI0h1xBHizxt5N?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d472e1-08d5-49dd-7490-08d98f65b694
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 22:55:26.6092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rw2fRF5uAJGguv0wzBnXb5K4s0/I7Ysl8T2PBmxnAJtMMAOcMgRhpqpaGJEdf4uGaBwUGmRSefReoDYvxmi0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3999
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

VGhhbmtzLiBXZeKAmXJlIG5vdyBpbnRvIGNsYXNzZXMsIHNvIG91ciBwcmlvcml0aWVzIGFyZSBz
dXBwb3J0aW5nIHN0dWRlbnRzLiBVbmZvcnR1bmF0ZWx5IHRoaXMgaXNu4oCZdCB0aGUgb25seSBp
c3N1ZSB3ZSBoYXZlIHRvIHJlc29sdmUuDQoNCiBJ4oCZbGwgdHJ5IHRvIGdldCB0aGlzIGluZm8s
IGp1c3Qgbm90IHRvZGF5LiBXZSBhc2tlZCB0aGUgY291cnNlIHVzaW5nIHZtcGxheWVyIHRvIHB1
dCB0aGVpciBWTSBpbiBsb2NhbCBzdG9yYWdlLCBvciB0byB1c2Uga3ZtLiBTbyBmYXIgbm8gcHJv
YmxlbXMuIFRoZSBkZWZhdWx0IGt2bSBzZXR1cCBkb2VzbuKAmXQgdXNlIGRpcmVjdC4NCg0KRG9l
cyBkaXJlY3QgbW9kZSBnZXQgdHVybmVkIGludG8gZGlyZWN0IG1vZGUgb24gdGhlIHNlcnZlcj8g
SWYgc28gSSBzaG91bGQgbG9vayBpbnRvIHRoZSBzdGF0ZSBvZiBkaXJlY3Qgc3VwcG9ydCBpbiB0
aGUgdmVyc2lvbiBvZiBaRlMgd2UgaGF2ZS4NCg0KPiBPbiBPY3QgMTQsIDIwMjEsIGF0IDY6Mjgg
UE0sIE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4gd3JvdGU6DQo+IA0KPiDvu79PbiBXZWQsIDA2
IE9jdCAyMDIxLCBDaGFybGVzIEhlZHJpY2sgd3JvdGU6DQo+IA0KPj4gDQo+PiBJdCB0cmllZCBy
dW5uaW5nIHZtcGxheWVyLiAgU2hvcnRseSBhZnRlciBzdGFydGluZyB0byBjcmVhdGUgYSBuZXcg
Vk0sDQo+PiB2bXBsYXllciBodW5nLiAgSSBoYWQgYW5vdGhlciB3aW5kb3cgd2l0aCBhIHNoZWxs
LiAgSSB3ZW50IGludG8gdGhlDQo+PiBkaXJlY3Rvcnkgd2l0aCB0aGUgdm0gZmlsZXMgYW5kIGRp
ZCDigJxscyAtbHRyY+KAnS4gIEl0IGRpZG7igJl0IHF1aXRlIGhhbmcsDQo+PiBidXQgbG9vayBh
Ym91dCBhIG1pbnV0ZSB0byBmaW5pc2ggSSBhbHNvIHNhdyBsb2cgZW50cmllcyBmcm9tIFZNd2Fy
ZQ0KPj4gY29tcGxhaW5pbmcgdGhhdCBkaXNrIG9wZXJhdGlvbnMgdG9vayBzZXZlcmFsIHNlY29u
ZHMuIA0KPiANCj4gVXNlZnVsIGluZm9ybWF0aW9uIHRvIHByb3ZpZGUgd2hlbiBhIHByb2Nlc3Mg
YXBwZWFycyB0byBoYW5nIG9uIE5GUw0KPiBpbmNsdWRlOg0KPiANCj4gLSBjYXQgL3Byb2MvJFBJ
RC9zdGFjaw0KPiANCj4gLSBycGNkZWJ1ZyAtbSBuZnMgLXMgYWxsOyBycGNkZWJ1ZyAtbSBycGMg
LXMgYWxsIDsgc2xlZXAgMiA7IA0KPiAgIHJwY2RlYnVnIC1tIHJwYyAtYyBhbGw7IHJwY2RlYnVn
IC1tIG5mcyAtYyBhbGwNCj4gdGhlbiBjb2xsZWN0IGtlcm5lbCBsb2dzDQo+IA0KPiAtIHRjcGR1
bXAgLXcgZmlsZW5hbWUucGNhcCAtcyAwIC1jIDEwMDAgcG9ydCAyMDQ5DQo+ICBhbmQgY29tcHJl
c3MgZmlsZW5hbWUucGNhcCBhbmQgcHV0IGl0IHNvbWV3aGVyZSB3ZSBjYW4gZmluZCBpdC4NCj4g
DQo+IC0gdHJhY2UtY21kIHJlY29yZCAtZSAnbmZzOionIHNsZWVwIDINCj4gIHRyYWNlLWNtZCBy
ZXBvcnQgPiBmaWxlbmFtZQ0KPiANCj4+IA0KPj4gV2XigJlyZSBwcm9iYWJseSBhbiB1bnVzdWFs
IGluc3RhbGxhdGlvbi4gIFdl4oCZcmUgYSBDUyBkZXBhcnRtZW50LCB3aXRoDQo+PiByZXNlYXJj
aGVycyBhbmQgYWxzbyBhIGxhcmdlIHRpbWUtc2hhcmluZyBlbnZpcm9ubWVudCBmb3Igc3R1ZGVu
dHMNCj4+IChzcHJlYWQgYWNyb3NzIG1hbnkgbWFjaGluZXMsIHdpdGggYSBncmFwaGljYWwgaW50
ZXJmYWNlIHVzaW5nIFhyZGIsDQo+PiBldGMpLiAgT3VyIHBlb3BsZSB1c2UgZXZlcnkgcGllY2Ug
b2Ygc29mdHdhcmUgdW5kZXIgdGhlIHN1bi4gDQo+IA0KPiBQcm9iYWJseSBub3QgYWxsIHRoYXQg
dW51c3VhbC4gIFRoZXJlIGNlcnRhaW5seSBhcmUgbG90cyBvZiBsYXJnZSBhbmQNCj4gdmFyaWVk
IE5GUyBzaXRlcyBvdXQgdGhlcmUuDQo+IA0KPj4gDQo+PiBDbGllbnQgYW5kIHNlcnZlciBhcmUg
Ym90aCBVYnVudHUgMjAuMDQuIFNlcnZlciBpcyBvbiBaRlMgd2l0aCBOVk1lIHN0b3JhZ2UuDQo+
IA0KPiBJZiBpdCBpcyBwb3NzaWJsZSB0byByZXByb2R1Y2Ugd2l0aG91dCBaRlMsIHRoYXQgd291
bGQgcHJvdmlkZSB1c2VmdWwNCj4gaW5mb3JtYXRpb24uDQo+IEkgZG9uJ3QgdGhpbmsgaXQgaXMg
Kmxpa2VseSogdGhhdCBaRlMgY2F1c2VzIHRoZSBwcm9ibGVtLCBidXQgbmVpdGhlcg0KPiB3b3Vs
ZCBJIGJlIHN1cnByaXNlZCBpZiBpdCBkaWQuDQo+IA0KPiBOZWlsQnJvd24NCg==
