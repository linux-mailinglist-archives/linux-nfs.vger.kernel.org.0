Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712C735EB76
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 05:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhDNDan (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 23:30:43 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:61478
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231909AbhDNDam (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 13 Apr 2021 23:30:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3MYBzVafXXMion7IdLe37TW3bfFKueH7D7hQgzB+6QriEPYbKKF8YMuEDSdxxIzYthvn/Jp8TEbslvArlvkn0lhN8IEijdYfv5bHXwBbyva2tdmrHNxm44MC6KfvuT4ub5YAqz7wwLDtmt7fVzcu7YK9XDnk6JunurMzIMQsI9V5CQhuPIHoqtRc6xMLBoSyL2lA6YE4IdaNa8i1hHlGb8D/Bw6cLW5oIN/vRh55cTkSsxC/3el2cB6lFnGhxjSwbs+HKLBw/Z0SqT4UJ3Jyq1rjxZwQzRlI8STAcByMiTw5SKfoGQerr5g+6w+v6eqHqvdQ8Ioqq4QkZlOo3ShwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vXMqonZCo8oHq/3vAI05blSUGRrmILE7P6rsDpRqzc=;
 b=lA/qr8+U+WcvJekDHjd6w1E0rsNQDzpmO4pUFjvo+ee4kDk5Ko+nC0UgGCFwk39TAqOqBsorZ1LAI0+oKGo4qgscm2j/Il2GAcJQeE4UDPauSW1r8aCDeXN9V5RgC4ILbXXOSyXpVxy557V3YnOamYbJqwS4sWG/8AUhwGjDhHBVUUt1LzcTflWG+7xOZRYYw9hmVAnQ/DrATde5HrH92/AqbvBfNhlXOQQn2MhEdECWevB9QQCRoO+QX2UhIanpMiuFDqix6rDApVXf6kdeK8NK7iCv2+RrbzwJP6BkI3KoGf2hc4KEaz4dXQ08v7mXkAIg90C1n5HxIoKMhCzVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vXMqonZCo8oHq/3vAI05blSUGRrmILE7P6rsDpRqzc=;
 b=iv9nNIVoNw3lB4Vs/z2bj8YYIDb2CJjD6jRGSTkKJt5dalxstLKg/ldVfj9S3kgRIhg7B0RQw4fisVBvYFkAblYv896wB5gE6Dnh3+09GFtcd3UKA4EwFybud5TPx6D2keMg0DPrGiUsRNNeMaShnibpqOH1qy30ZgLWA8gkDgrmKfB+XLBK0P/8oEvUSHg9bMcxL+19a8Ufk386Jtmf81wDk5i9JIEuV2cm6VYh/AyaRNrz2CWqJ/F4P3I6F+HNiUAHVze/is/L5qvI7rT/bJWGhq3KSGOq28a3YUyp9FLASw9BM6KANmbdB3AnN6/Z+sZfP9nZ6GcOjGfTYPknlA==
Received: from DM6PR06MB4074.namprd06.prod.outlook.com (2603:10b6:5:86::20) by
 DM6PR06MB4252.namprd06.prod.outlook.com (2603:10b6:5:27::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Wed, 14 Apr 2021 03:30:20 +0000
Received: from DM6PR06MB4074.namprd06.prod.outlook.com
 ([fe80::ad2b:6b24:5d5e:187d]) by DM6PR06MB4074.namprd06.prod.outlook.com
 ([fe80::ad2b:6b24:5d5e:187d%7]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 03:30:19 +0000
From:   "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: generic/430 COPY/delegation caching regression
Thread-Topic: generic/430 COPY/delegation caching regression
Thread-Index: AQHXMLuIlouLsv7u/kuUt6wxV+WLIKqzGHeA
Date:   Wed, 14 Apr 2021 03:30:19 +0000
Message-ID: <0A9B34DB-56CF-4F22-8A8E-F6CA3176144D@netapp.com>
References: <20210413231958.GB31058@fieldses.org>
In-Reply-To: <20210413231958.GB31058@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.47.21031401
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [172.10.226.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a1156f9-c6dc-4a44-2b05-08d8fef5a150
x-ms-traffictypediagnostic: DM6PR06MB4252:
x-microsoft-antispam-prvs: <DM6PR06MB4252A0665D4E9110E2F7118F934E9@DM6PR06MB4252.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3MuZPsLCaOFIEHtqa17XVXE2+YGMFyRirFvT3+tdbi5g8My4oyLWEHshh/VYnneWj4qHhKVY/0QDMZtLGmnqa46/4uRtSg2mDJsP0LBM+my6SRbQh4s6RH1kQ+pjSheELcSoyNYp+ywDDhkyV+9Uht5ch781f3rGwvH281ebXza3lccRYEkExumuqmuKMD+S09GimLn8KGrnfhWxMBbm5a2JFZIPPFOBEU9SslXnVKpyq0Nx0DBD9NjmzJNxpESFwq7DkYBq6wgsceQq2sZx/LtG2vega9ReUoC02HlEbEvtAgk3OGXnDA1/QHPScxWNyaDqgwZTIlYt1isOZ8AQ0cFgxRz/a4FmQgqkMRZEzMSkOdHuyWgIBzZqCtNwQKacWDQo8S7adfR7kwVE2pyCnSXvzdEX5dzFezMHWrJXrlpCMGHIX6S22n0CzEOJYRCTd8qCzr5Z9cIrZ0BjEw9mvk22jcDZXThGFxYmInhLDBX+UkMmK+eJ7cJMNIWuJw1uAoVxq6S1QisPTCV+Hr25AMRAysxuBzYVsMbz8DmMRAvN4ocRXcePxfD/G5e+sJhMiaMHDpk+uS5bKljH6iz4k2Fwzq87oWDpPbrryB8Z+KSSK3agBUTA1uaT3YlhKyfwgZM07N6DNWTP8fOWvzPkvBAQdBgET7lUbWp9tbi+SCSscOsWXudhC37O8VGFH9JW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4074.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(136003)(396003)(376002)(64756008)(316002)(6506007)(66446008)(122000001)(6512007)(8676002)(186003)(66946007)(86362001)(91956017)(6486002)(110136005)(5660300002)(66476007)(66556008)(26005)(76116006)(83380400001)(478600001)(8936002)(2616005)(36756003)(4744005)(38100700002)(33656002)(2906002)(71200400001)(4326008)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NlFQNXpVY1ZNaEwwTWM4RDNGR1FRNzNHemVseUdsblJJYWNIbmozZ2FHWWJ3?=
 =?utf-8?B?SjlTenpoTTJUMlBNQXJML2ZVWitqc3NEbHNKbmVkVEN4dy8rMy9oekpkaXNM?=
 =?utf-8?B?NDFmL2FmWUF5OXNKOWxLVFBqZTNiZTBqOXZnY1R0anRzZlJ6S2REcGE4SDVZ?=
 =?utf-8?B?R2VxSkhOVnI5bFU0SzV4ZTF0TzNzQVFPdlk1LzlSMmxaL3dMZ1RZa1BjQUpH?=
 =?utf-8?B?WUx4eHlqb0FKQ3RDaG9ocEE0QjEyeW0zUlpBVXlraUxDd3p5VnJSb1B6Vkhk?=
 =?utf-8?B?WDNzSnZPcnEyOWkvd2lsaTM1MDB1cHVZV2F3Vk9aUUdUOGl3VDRGNThOY3Rk?=
 =?utf-8?B?ZUJJanMvbTl5SlBsQ3RnMXFOWDZ5LzRyMURmamNwUk9NRnI5SWZSTmdrcTVF?=
 =?utf-8?B?OXBrRldyWE94cXVNY0p1UVFSL1ZrYk8rdDJTZGxFNmxXdzdNSVh0UWtzZEVl?=
 =?utf-8?B?TC9ObSsyckN3Nk8xeWozaU91bkVxK1VaMTduMlVQK2wxWUlOSzc0bDJzWEFy?=
 =?utf-8?B?R09pMFBHM1Fvd3FtUUxhT09WV215VVRGKzJTS0s4V0U4R1Rhd2dqbGNXb3JP?=
 =?utf-8?B?YVVVZGd5RlJqQTYxTkJuVml2Tk5NVlhUUnphUFBNbkFFMHdSdWJoeVdPY00v?=
 =?utf-8?B?RnYyV0xKRjBvdW5Lb2NXQXgwTnQ5SFAyeENUOWw5a2FwWEkvcnp1d0VKRUdz?=
 =?utf-8?B?cTkyUStNRjJtMno1L3dhYlhvUUs1R2NnVExBcUlUM1A2cS94eGgxQ1dSZXpz?=
 =?utf-8?B?L3gzMXdiVU9Kek05OWJ2RGVVKzF0ZHZjblloYXZFSHYxUU5QTkdlSUJ2Wk14?=
 =?utf-8?B?SldnSEx0eWQ1ZDV4RU81WURidHN3T1FWLzlOdG15WlJVSVk1dldjUWU0czNX?=
 =?utf-8?B?WkpMODZlYlhFREV2NEdsdzM3Sy9XQUwvSDY3QVMvdFFoUnNuS1I3ZHBtRkRI?=
 =?utf-8?B?aHRITjArc0pSNVhTK0UzcUkybmtIMGlmbWc1SmhVY29GN2hpR2FwZUNtc0Rs?=
 =?utf-8?B?cG9nejNETnFPMEJra1ZockVubDl2VlZxZXltRmcrYWk2b0dPa0wvajMzdUtP?=
 =?utf-8?B?UnNoMWlwMnpFRjRERjExNFNoK2xFbTB2S0U0Y2tSOWtOb1JpczN0UzEwRkgr?=
 =?utf-8?B?ZkFGODhoTUsrRDMxTU13ZXcwcDM0WnlTNjZyKy9KSXdyMmsvMGZTcFA0eThu?=
 =?utf-8?B?ajJ2QnJJKzdCTGZScjc3ZzNSN0k4WG00cHJZOWFLS283ZGkwYk8wOVFxRXA0?=
 =?utf-8?B?M1ArNGxyL0NRR2RNMFNtaFlJcFhyZW1BdHdZYnFST0owZlR6cW9DeXBwT1Vh?=
 =?utf-8?B?QVkvOTdyQlhOemtYWjJqVnJnVWhCMm12YlhkYjdnaFNpcVRiSjh4QXEzRzhm?=
 =?utf-8?B?ZWZQRHRSb2RhNkU2b1VoM0dWZ3QrMmxSZ0NuUFZzR3RKMXRENElJSWRyNlFs?=
 =?utf-8?B?SlBkOFRnVXZ0eVR1blBUMjV2ZHNOaTJDSWh4WHhhL3c2NVo1MC9pRTUwbzZ2?=
 =?utf-8?B?ODRRSEZDRElVRFBmWVZDSDNZNkZKRVNHeXQrS0VCREo0aFl0V3lRL0lqMGh1?=
 =?utf-8?B?WmRNbVIvN1hMSkRqeTFXOG5CWGtSRHpmbEJLZytYTjB1RzZLMnFMcGxXVWhW?=
 =?utf-8?B?SERvYXNKa0d4L3VmdDJxa2JsTURITDlPSnQxRy80dEhaTGRxd1JzQkljZ2NP?=
 =?utf-8?B?UlY4VzAyMzBxM3ovYmpwZXluMHNLZHl3cTZJWmJHNFM2czRrTlY1UDlHdXRo?=
 =?utf-8?B?RnFIWnY2UlRJak1hTDB4TGJWTUxJenlxeDVtUDNMMys1VHBYQ2hxemRsNVNz?=
 =?utf-8?B?NjZyNUxnMVhrMExXRWFXZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <214B986AE944E54BAE6E26DB391786CC@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4074.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1156f9-c6dc-4a44-2b05-08d8fef5a150
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 03:30:19.8674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8x6JiOLiV2vw+K3olY9vzp61RxN4yfPjdiabYqj27lMkyRKXYJUcZhl/+PiJlAiai6/qtJn71xhW1sKeDTheCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4252
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCu+7v09uIDQvMTMvMjEsIDc6MjAgUE0sICJKLiBCcnVjZSBGaWVsZHMiIDxiZmllbGRzQGZp
ZWxkc2VzLm9yZz4gd3JvdGU6DQoNCiAgICBOZXRBcHAgU2VjdXJpdHkgV0FSTklORzogVGhpcyBp
cyBhbiBleHRlcm5hbCBlbWFpbC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBp
cyBzYWZlLg0KDQoNCg0KDQogICAgZ2VuZXJpYy80MzAgc3RhcnRlZCBmYWlsaW5nIGluIDQuMTIt
cmMzLCBhcyBvZiA3YzFkMWRjYzI0YjMgIm5mc2Q6IGdyYW50DQogICAgcmVhZCBkZWxlZ2F0aW9u
cyB0byBjbGllbnRzIGhvbGRpbmcgd3JpdGVzIi4NCg0KICAgIExvb2tzIGxpa2UgdGhhdCByZWlu
dHJvZHVjZWQgdGhlIHByb2JsZW0gZml4ZWQgYnkgMTZhYmQyYTBjMTI0ICJORlN2NC4yOg0KICAg
IGZpeCBjbGllbnQncyBhdHRyaWJ1dGUgY2FjaGUgbWFuYWdlbWVudCBmb3IgY29weV9maWxlX3Jh
bmdlIjogdGhlIGNsaWVudA0KICAgIG5lZWRzIHRvIGludmFsaWRhdGUgaXRzIGNhY2hlIG9mIHRo
ZSBkZXN0aW5hdGlvbiBvZiBhIGNvcHkgZXZlbiB3aGVuIGl0DQogICAgaG9sZHMgYSBkZWxlZ2F0
aW9uLg0KDQpbb2xnYV0gSSdtIGNvbmZ1c2VkIHdoYXQgY2xpZW50IHZlcnNpb24gYXJlIHlvdSB0
ZXN0aW5nIGFuZCBhZ2FpbnN0IHdoYXQgc2VydmVyPyBJIGhhdmVuJ3Qgc2VlbiBnZW5lcmljLzQz
MCBmYWlsaW5nIHdoaWxlIHRlc3RpbmcgdXBzdHJlYW0gdmVyc2lvbnMgYWdhaW5zdCB1cHN0cmVh
bSBzZXJ2ZXIgdmVyaW9ucy4gV2hhdCBzaG91bGQgSSB0cnkgKGFzIGluIHdoYXQgY2xpZW50IHZl
cnNpb24gYWdhaW5zdCB3aGF0IHNlcnZlciB2ZXJzaW9uKSB0byByZXByb2R1Y2UgdGhlIGZhaWx1
cmU/DQoNCiAgICAtLWIuDQoNCg==
