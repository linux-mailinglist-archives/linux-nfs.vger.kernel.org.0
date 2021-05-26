Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D44390DEF
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 03:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhEZBdh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 21:33:37 -0400
Received: from mail-bn1nam07on2093.outbound.protection.outlook.com ([40.107.212.93]:44865
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230306AbhEZBdg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 25 May 2021 21:33:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jncbrd0JqiYTnldx4mjDlHjjKSiaRFW43WuYS6ltjgK2OniJOleZD82oUB31UbiGnC7SUEC1K0NxKUXHrGBDqCQvCCxwZZ8nBRdsuqsFSg687mYDRyr5ZmaKOBe8rMIOGmA70otDqykQD8hl1i2nNCXOzrVDfv+21M+EYpSIV2jxTz4IGYB/83z1KKOZCif8Pw72QyHWk0Iez7a1El489lePE0QT97wa9qglHD22eeRcp9t9+woTE7v2Qy20TpBa3Er6D+gDLKATVdQfg9vSvlqsKAmP/oQem5JpEdR7yr9bs8opdF7UzrRSImaFkmt/hbtZwRGclr3utYz19oQ49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpMdmOKX/mV9Wu99hj5gb0QDq26MCTHiLXd3VHD9X6g=;
 b=S3x24vMPPBYF6a/NMr8EekOynn/ZKOM2QHYvEdzZqJikMLCAK5Ceok1cUjA7KmcsEfV681aPHbIzOZ6gAHzfBpyR7NoMAtqxjYZgUzm1fdvIUoy30eviYPWjqO6x/+MXsjYXQh3bnK0/2OKQvYKWW7gHbiAxSK+NPYVN/5X1Q0OMaeyNZkjwZyZGxrc/QNrXA5ygzxMWwRimxkDzqOTSHEjH+FL9FM2h4tvEJuR/YXEkYKpFRX+VDp+hXI5L6w8LZiYBjtyU0Bvwda7Bphzc2tXGrM/4cOeOVzwow225SoTN9CQEVJyl/LnUS/115BdaipenjjDChY1jMfQ3rz87Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpMdmOKX/mV9Wu99hj5gb0QDq26MCTHiLXd3VHD9X6g=;
 b=DP5kFWkuGMKDORow7+eXJAgbrgqw7XBg4JsfJDyHsvSA0fxJq7l3+Bx1jPOOaL2P7ocQWD/2Bn3ksARaB79HPQXqSHPdcw6yfSTgpjqdRZN6ICSFs2DslcFKpPCMtoNLtDqdVvXZMHgTvTGz+yzi2SIbS7tgKYBVBqtRmOE1GRg=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB2378.namprd13.prod.outlook.com (2603:10b6:5:cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11; Wed, 26 May
 2021 01:32:03 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 01:32:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/1] nfsd4: Expose the callback address and state of
 each NFS4 client
Thread-Topic: [PATCH v2 1/1] nfsd4: Expose the callback address and state of
 each NFS4 client
Thread-Index: AQHXS1tm1/cfZuMU0EWRUxykxPdcnKr0usmAgABMWwA=
Date:   Wed, 26 May 2021 01:32:03 +0000
Message-ID: <d0466617bdf9856ae6eb56416ea5f3637340f49b.camel@hammerspace.com>
References: <1621283385-24390-1-git-send-email-dwysocha@redhat.com>
         <1621283385-24390-2-git-send-email-dwysocha@redhat.com>
         <20210525205845.GB4162@fieldses.org>
In-Reply-To: <20210525205845.GB4162@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f2cf24a-b72a-40ec-f342-08d91fe610b7
x-ms-traffictypediagnostic: DM6PR13MB2378:
x-microsoft-antispam-prvs: <DM6PR13MB23784202D1FF20AF61B99054B8249@DM6PR13MB2378.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tr23L3nIf2ZVrh4U4Kfgt1jmqyrzxXcth6trsA3/wiA5IiIZIFff4SUam4/CZDxvHlOJCyKlwiwSabySu+n5HWpUlXRFy085NpjjFQZyWbgBSsjhneR25Xj12+oceDEJ0JtU3d16XcAUq2sPHJSIYZ+TxB51d6NQpB3rJubOukpS7yICdyv2a/QvMCjX9MYV9qHNC0FNqhtomzR/RyD8e7bgzf/U8ACW2Bq2uE5OJzp70j4j8rc6Z73Whs1IscR16MJ/GarNLmP5uHZ0wdapmljH5qrFWC1z8T4kL+VueM/9evITmSdfBrQazOqdVw/Dr68/Cbt4uk5ZUw8bRgGbPayOCMiMGqFtz0C2mRlGCD39rncIiQO1Pe0HR0uKCTAG1YaYLuM0yOZmH7txQSoVIEp5EU727X34mQJaSA2T/ZV8uuyKs2vM48/MNfNchdxKmlyt6XVuHoUm80RDtczoNgqt/+KHR9sp7JSnjU7OfgyTdpYVBBoYFg65lICINUFEM2kAnHkFgIAxi2XgsUacYz53DJKSBHvgY/0rZ3XFqrGxazdXrlCKb2uXU1NpmYrwHB34+Gdf7vWb6ZjHn//GVVv6xBrri8nXR6vcxLcg5gs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39840400004)(38100700002)(71200400001)(36756003)(8676002)(6486002)(110136005)(66446008)(478600001)(91956017)(2906002)(2616005)(6512007)(86362001)(316002)(66556008)(5660300002)(122000001)(83380400001)(66946007)(66476007)(4326008)(76116006)(54906003)(64756008)(26005)(6506007)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VTJOVXQzaDgvTmFkTDZCdlRFSG1Jdmp2UzNyLzNpanFmU2dGbnN3ZEVmZlIz?=
 =?utf-8?B?aGdQQnFWdzczL3p6RlVTWHZWaGYwcDBPR2paTVJiWnViVjNoc3FMWTNTVlJx?=
 =?utf-8?B?TFZpQjNJZ0kxVHNwOGNaTVFYSklsRHFjTlBFUVJoTFM0aDBraTY2N285SDBV?=
 =?utf-8?B?NlcwSWpFcGVoTlJZcDFuWXRteXc5WlJiVXI4R0VPVjBGek5RUFpCZHk1SVUr?=
 =?utf-8?B?MEVEMGE5VSs5b2MyYjdQeXd5elJtZVl6YmNlSTF0NXRSSTVTWHRmZmt1QVIz?=
 =?utf-8?B?L2kyWEl4S0Zvd1lyYXNhdDFpeVgvZHBkRE9JaEQrRTNrdnNJOTVKQlhjNGxj?=
 =?utf-8?B?QU5OMlVFU1RUODFpNGVEZ2EwQnR6L0g0UWhoZ0VxbkVFNFozSjh4VFp3bk9u?=
 =?utf-8?B?SXpiaXVpcFpYWkNXZzRWSXd5RjJGOWQzVzFuRlpRK0tYQTJGYTRhaFlVNkZr?=
 =?utf-8?B?SGl0Z0VHeVU4bmlzV2Q5TUlUTUsyQjFPSS9NbDMvNkIxckgybkJRWjNQdHNs?=
 =?utf-8?B?U1psVFVlb1FFUmx2ZzRjb3NyaWtvNC95cDlqRjVMMzNkRFZ0NE1yWktqMXlJ?=
 =?utf-8?B?VGgrSXc5QkRYSjRzbVZRMENGcWtzbDZ4L3ZkQlBzaTRPcWtrWUVidE9uamxV?=
 =?utf-8?B?VXZ5dE5YOXFyNDcvbTFiZC9zY01Jd3NMdVp0ZjNnZXVNUVVPZnFBZzZtWk1r?=
 =?utf-8?B?Y2hkNlIvdEVXMmU4K2pxQjAwRTVKUkxtckxMdE9ONFJZSDE2MUFBTlVKUkRj?=
 =?utf-8?B?VEpBdzR3Z21RNnZvNTZzZGVEQzhoZHliZmRITDB5M1lpbGRQWEZua0RUeHd3?=
 =?utf-8?B?cWtTSEpaVGM5Zm9JS0VVcUFIMkhQVW5BT3VQZjlNRVBMN3ZXd24yUC9OTXF0?=
 =?utf-8?B?SG04YUlYVm1TdXRzcDFPM3RIRjBoMVNhTFNQT0NWOWswbXVNM1JPVkd2K1Rn?=
 =?utf-8?B?OE1EcXJsbk5maXphdGN5dDBFMTIrck1OUERMaUFiWHBuNXFkd29yM090RDA0?=
 =?utf-8?B?UEpFR1g0SlBwU1hRT25rUUlmT09sS2hQVTd5b3Jpdnhqb2xmSjZ1eVIzMU1X?=
 =?utf-8?B?RlhaOWtzVFhPb2Y5VFdXMExmMXFNZWFuS0ZKTjZMeFBkVDk5RzRUVUVmbEVq?=
 =?utf-8?B?QXk4OGRYanBpSU5QeEZ2aHFUbENQZ3JmZGZyNm5TWUEvYUY5NmlSeS9hZEQr?=
 =?utf-8?B?bG1WbGx0SmMrcU1saFVZYVNBNmd6TTV6TW8wV0RCZEtaV1JuU0RHVTRSc2dv?=
 =?utf-8?B?NXo5b1dRa3Q0dVJDUEhSdElucHoyV1Fja3Q2VnkyQU1qaTZnMytJT0lnTFdE?=
 =?utf-8?B?d1MvVjRvbUdSQXU3SnZOSlFpT2hjdnlmN29IUm8zRmtkNVo5V2VwYlZrMW81?=
 =?utf-8?B?Ym9MYmdVVk5qMEd3WkhYZFV1SlhlQ3FJWWI5cmtqQ0pjY1IweHd1Q05LYkFh?=
 =?utf-8?B?eW9EUU4ycTZ6S21OTmVOYVVWZE1VZ08wZE9rNERDSzRYN0ZOVkxMZnMrSDFZ?=
 =?utf-8?B?S1oyQ2RuWHd5MEZubE9pTDQ0V0xnaDFmODQycDc4K1ByWUNWSnFsT2huQ2ww?=
 =?utf-8?B?aVlleTZrQ2hUTWpyNEwvd1A4cXJ6aWU3Q0tKYzh1T3hOOWhSVGJQTUZ3STdY?=
 =?utf-8?B?S3QyUzg0aEtUSURjTjhweTlvajlaYncySHcyTVorbWhvYmVXUzBHdkNmKzNk?=
 =?utf-8?B?Vk9oTnBYYmdTRU93bGN4SC91SHFGTlRKWCtjVW5NQ2pUSFdmTzh2L01qYjln?=
 =?utf-8?Q?9zx+5b9hKAUdIdrHbsuatFTuvZ0U5AV2zqXyB5b?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <66F8569E5FA62644ACE2394DC22E7463@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2cf24a-b72a-40ec-f342-08d91fe610b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 01:32:03.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgZfAppq0OAVDXp/eqODW+jcT/s+DpcKY5fjdsBwfSTaEGhbhTv4crg9m5zGzG2D4cCIpS+oaYrxASQOii08Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2378
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA1LTI1IGF0IDE2OjU4IC0wNDAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IFdoZW4gSSBydW4gdHJhY2UtY21kIHJlcG9ydCBJIGdldCBvdXRwdXQgbGlrZToNCj4gDQo+IMKg
IFtuZnNkOm5mc2RfY2Jfc3RhdGVdIGZ1bmN0aW9uIGNiX3N0YXRlMnN0ciBub3QgZGVmaW5lZA0K
PiDCoCBbbmZzZDpuZnNkX2NiX3NodXRkb3duXSBmdW5jdGlvbiBjYl9zdGF0ZTJzdHIgbm90IGRl
ZmluZWQNCj4gwqAgW25mc2Q6bmZzZF9jYl9wcm9iZV0gZnVuY3Rpb24gY2Jfc3RhdGUyc3RyIG5v
dCBkZWZpbmVkDQo+IMKgIFtuZnNkOm5mc2RfY2JfbG9zdF0gZnVuY3Rpb24gY2Jfc3RhdGUyc3Ry
IG5vdCBkZWZpbmVkDQo+IA0KPiBJIGRvbid0IGtub3cgaG93IHRoaXMgaXMgc3VwcG9zZWQgdG8g
d29yay7CoCBJcyBpdCBPSyBmb3IgdHJhY2Vwb2ludA0KPiBkZWZpbml0aW9ucw0KPiB0byByZWZl
cmVuY2Uga2VybmVsIGZ1bmN0aW9ucyBpZiB0aGV5J3JlIGRlZmluZWQgaW4gdGhlIHJpZ2h0IHdh
eQ0KPiBzb21laG93P8KgIElmDQo+IG5vdCwgSSBkb24ndCBrbm93IHdoYXQgdGhlIHNvbHV0aW9u
IHdvdWxkIGJlIGZvciBzaGFyaW5nIHRoaXMtLWRlZmluZQ0KPiBhIG1hY3JvDQo+IHRoYXQgZXhw
YW5kcyB0byB0aGUgYXJyYXkgbGl0ZXJhbCBhbmQgdXNlIHRoYXQgaW4gYm90aCBwbGFjZXM/wqAg
T3INCj4gbWF5YmUganVzdA0KPiBsaXZlIHdpdGggdGhlIHRoZSByZWR1bmRhbmN5Lg0KPiANCg0K
WW91IG5lZWQgdG8gc3RvcmUgdGhlIHN0cmluZyBpbiB0aGUgVFBfZmFzdF9hc3NpZ24oKSBzZWN0
aW9uIGlmIHlvdQ0Kd2FudCB0byBiZSBhYmxlIHRvIGRpc3BsYXkgaXQuIE90aGVyd2lzZSAncGVy
ZicgdHJpZXMgKGFuZCBmYWlscykgdG8NCmZpbmQgdGhlIGNiX3N0YXRlMnN0ciBmdW5jdGlvbiBz
byBpdCBjYW4gaW52b2tlIGl0Lg0KDQo+IC0tYi4NCj4gDQo+IE9uIE1vbiwgTWF5IDE3LCAyMDIx
IGF0IDA0OjI5OjQ1UE0gLTA0MDAsIERhdmUgV3lzb2NoYW5za2kgd3JvdGU6DQo+ID4gSW4gYWRk
aXRpb24gdG8gdGhlIGNsaWVudCdzIGFkZHJlc3MsIGRpc3BsYXkgdGhlIGNhbGxiYWNrIGNoYW5u
ZWwNCj4gPiBzdGF0ZSBhbmQgYWRkcmVzcyBpbiB0aGUgJ2luZm8nIGZpbGUuwqAgRGVmaW5lIGFu
ZCB1c2UgYSBjb21tb24NCj4gPiBmdW5jdGlvbiBmb3IgdGhpcyBpbmZvcm1hdGlvbiB0aGF0IGNh
biBiZSB1c2VkIGJ5IGJvdGggY2FsbGJhY2sNCj4gPiB0cmFjZSBldmVudHMgYW5kIHRoZSBORlM0
IGNsaWVudCAnaW5mbycgZmlsZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZlIFd5c29j
aGFuc2tpIDxkd3lzb2NoYUByZWRoYXQuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZnMvbmZzZC9uZnM0
c3RhdGUuYyB8wqAgMiArKw0KPiA+IMKgZnMvbmZzZC90cmFjZS5jwqDCoMKgwqAgfCAxNSArKysr
KysrKysrKysrKysNCj4gPiDCoGZzL25mc2QvdHJhY2UuaMKgwqDCoMKgIHzCoCA5ICsrLS0tLS0t
LQ0KPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRzdGF0ZS5jIGIvZnMvbmZzZC9u
ZnM0c3RhdGUuYw0KPiA+IGluZGV4IGIyNTczZDNlY2QzYy4uZjNiODIyMWJiNTQzIDEwMDY0NA0K
PiA+IC0tLSBhL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4gPiArKysgYi9mcy9uZnNkL25mczRzdGF0
ZS5jDQo+ID4gQEAgLTIzODUsNiArMjM4NSw4IEBAIHN0YXRpYyBpbnQgY2xpZW50X2luZm9fc2hv
dyhzdHJ1Y3Qgc2VxX2ZpbGUNCj4gPiAqbSwgdm9pZCAqdikNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHNlcV9wcmludGYobSwgIlxuSW1wbGVtZW50YXRpb24gdGltZTogWyVs
bGQsDQo+ID4gJWxkXVxuIiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBjbHAtPmNsX25paV90aW1lLnR2X3NlYywgY2xwLQ0KPiA+ID5jbF9uaWlf
dGltZS50dl9uc2VjKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+ICvCoMKgwqDCoMKgwqDC
oHNlcV9wcmludGYobSwgImNhbGxiYWNrIHN0YXRlOiAlc1xuIiwgY2Jfc3RhdGUyc3RyKGNscC0N
Cj4gPiA+Y2xfY2Jfc3RhdGUpKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBzZXFfcHJpbnRmKG0sICJj
YWxsYmFjayBhZGRyZXNzOiAlcElTcGNcbiIsICZjbHAtDQo+ID4gPmNsX2NiX2Nvbm4uY2JfYWRk
cik7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGRyb3BfY2xpZW50KGNscCk7DQo+ID4gwqANCj4gPiDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvdHJhY2Uu
YyBiL2ZzL25mc2QvdHJhY2UuYw0KPiA+IGluZGV4IGYwMDhiOTVjZWVjMi4uNjI5MWI1ZDEwODI0
IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mc2QvdHJhY2UuYw0KPiA+ICsrKyBiL2ZzL25mc2QvdHJh
Y2UuYw0KPiA+IEBAIC0yLDMgKzIsMTggQEANCj4gPiDCoA0KPiA+IMKgI2RlZmluZSBDUkVBVEVf
VFJBQ0VfUE9JTlRTDQo+ID4gwqAjaW5jbHVkZSAidHJhY2UuaCINCj4gPiArDQo+ID4gK2NvbnN0
IGNoYXIgKmNiX3N0YXRlMnN0cihjb25zdCBpbnQgc3RhdGUpDQo+ID4gK3sNCj4gPiArwqDCoMKg
wqDCoMKgwqBzd2l0Y2ggKHN0YXRlKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBORlNENF9D
Ql9VUDoNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuICJVUCI7DQo+
ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBORlNENF9DQl9VTktOT1dOOg0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gIlVOS05PV04iOw0KPiA+ICvCoMKgwqDCoMKgwqDC
oGNhc2UgTkZTRDRfQ0JfRE9XTjoNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuICJET1dOIjsNCj4gPiArwqDCoMKgwqDCoMKgwqBjYXNlIE5GU0Q0X0NCX0ZBVUxUOg0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gIkZBVUxUIjsNCj4gPiAr
wqDCoMKgwqDCoMKgwqB9DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuICJVTkRFRklORUQiOw0K
PiA+ICt9DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvdHJhY2UuaCBiL2ZzL25mc2QvdHJhY2Uu
aA0KPiA+IGluZGV4IDEwY2MzYWFmMTA4OS4uODkwOGQ0OGIyYWE2IDEwMDY0NA0KPiA+IC0tLSBh
L2ZzL25mc2QvdHJhY2UuaA0KPiA+ICsrKyBiL2ZzL25mc2QvdHJhY2UuaA0KPiA+IEBAIC04NzYs
MTIgKzg3Niw3IEBADQo+ID4gwqDCoMKgwqDCoMKgwqDCoFRQX3ByaW50aygiY2xpZW50ICUwOHg6
JTA4eCIsIF9fZW50cnktPmNsX2Jvb3QsIF9fZW50cnktDQo+ID4gPmNsX2lkKQ0KPiA+IMKgKQ0K
PiA+IMKgDQo+ID4gLSNkZWZpbmUNCj4gPiBzaG93X2NiX3N0YXRlKHZhbCnCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBcDQo+ID4gLQ0KPiA+IMKgwqDCoMKgwqDCoMKgX19wcmludF9z
eW1ib2xpYyh2YWwswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiDCoMKgwqBcDQo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHsgTkZTRDRfQ0JfVVAswqDCoMKgwqDCoMKgwqDC
oMKgwqAiVVAiDQo+ID4gfSzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoFwNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeyBORlNENF9D
Ql9VTktOT1dOLMKgwqDCoMKgwqAiVU5LTk9XTiINCj4gPiB9LMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBcDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHsgTkZTRDRfQ0JfRE9XTizCoMKgwqDCoMKgwqDCoMKgIkRPV04iDQo+ID4gfSzCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB7IE5GU0Q0X0NCX0ZBVUxULMKgwqDCoMKgwqDCoMKgIkZBVUxUIn0p
DQo+ID4gK2NvbnN0IGNoYXIgKmNiX3N0YXRlMnN0cihjb25zdCBpbnQgc3RhdGUpOw0KPiA+IMKg
DQo+ID4gwqBERUNMQVJFX0VWRU5UX0NMQVNTKG5mc2RfY2JfY2xhc3MsDQo+ID4gwqDCoMKgwqDC
oMKgwqDCoFRQX1BST1RPKGNvbnN0IHN0cnVjdCBuZnM0X2NsaWVudCAqY2xwKSwNCj4gPiBAQCAt
OTAxLDcgKzg5Niw3IEBADQo+ID4gwqDCoMKgwqDCoMKgwqDCoCksDQo+ID4gwqDCoMKgwqDCoMKg
wqDCoFRQX3ByaW50aygiYWRkcj0lcElTcGMgY2xpZW50ICUwOHg6JTA4eCBzdGF0ZT0lcyIsDQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2VudHJ5LT5hZGRyLCBfX2VudHJ5
LT5jbF9ib290LCBfX2VudHJ5LT5jbF9pZCwNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgc2hvd19jYl9zdGF0ZShfX2VudHJ5LT5zdGF0ZSkpDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGNiX3N0YXRlMnN0cihfX2VudHJ5LT5zdGF0ZSkpDQo+ID4gwqApOw0K
PiA+IMKgDQo+ID4gwqAjZGVmaW5lIERFRklORV9ORlNEX0NCX0VWRU5UKG5hbWUpwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPiA+IC0tIA0KPiA+IDEuOC4zLjEN
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
