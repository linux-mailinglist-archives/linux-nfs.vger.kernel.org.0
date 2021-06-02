Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09C13992E2
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 20:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhFBSy0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 14:54:26 -0400
Received: from mail-bn1nam07on2103.outbound.protection.outlook.com ([40.107.212.103]:37038
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229468AbhFBSyZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 2 Jun 2021 14:54:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS2OImLfI/3Ohu/DY+UfP6iTsBzvaZoeFgBg15XoC80yIkE5ltqf16YxIOtf7q1bj/wWOqBRfqprjxZcjWtsL2vEClnkJSOdXk/WJmmy1/7r4qTxjho7z/7fAdpSzJ+v7w34lyD2c6/HBZa8djLpUiPyca4BqEO6QoExJXZiqKcbu9SsCRi/6bXphpLsXRyK7QMdrUjsDJhLdsoddGItcDTveUk4oEyRFmFjoHwa0jjbreFk14H2QqNjXDXtsqri2ljpN74UtH1lBrLkRpibluW6t7425f9NhQxiScQpLBVNSDh15N9Z/hRNRf/u5lGr1hbe5uFntAeE8N0iz4nU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3YIBehXvIIQzmGnHp/8whLNXel3Iqil63XdOUhW7rI=;
 b=JfPTDi48admv6XQKHaIWD4LwIbkzsbwGXmRriE7ypUiNPzE3q1ZEYVZ1XJXt0x8NWLfK2TMIHWq6UpzkRnB2HImFaoODbIe2J0fP63NiwBmaX1ZHoZ8zpUYi+LiT1myOYvxbvMo+ctU9zcKdXm0iLHzSNqe8lNZsi2atMaVQz2on1OcDSmlhEgxyW3u5gAT03xwuopNd4TvEW20HnCNVrSsgDeH7WJnm0Z2g4oaJxMrS2vVsgRMwOzotBoCWEbzdfnNL4sTQULchklJsYODNHioRUBlRbMKIoJipQ/BlaasvQKWs0SySf30H7UAGJ5aFksesGj7qahOS0trO8G6YsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3YIBehXvIIQzmGnHp/8whLNXel3Iqil63XdOUhW7rI=;
 b=d6l2nXxcrGIyomLHuzDCqw7grVtLdSjIJ8i0mmjHJEzpFJrezhdWAVI9RGWYycfqjbr36c/LZnqzLX0v9CCtAy5AGcwr3+XYGuNTZv3Gb0XTtSptEPG5+nvcmdsiakDKiqHuGQfuXjY0Aqxj1XvfSktY+8iwS/WH24gvG4Z4IDM=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB1147.namprd13.prod.outlook.com (2603:10b6:3:30::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.12; Wed, 2 Jun 2021 18:52:41 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4195.017; Wed, 2 Jun 2021
 18:52:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH v2] NFS: Fix use-after-free in nfs4_init_client()
Thread-Topic: [PATCH v2] NFS: Fix use-after-free in nfs4_init_client()
Thread-Index: AQHXV91/2f129rRMmkCkKSE1NwpQhasBES6A
Date:   Wed, 2 Jun 2021 18:52:40 +0000
Message-ID: <ed1b9642f6b26f2174c5fd5b88a629a25225b926.camel@hammerspace.com>
References: <20210602183120.532206-1-Anna.Schumaker@Netapp.com>
In-Reply-To: <20210602183120.532206-1-Anna.Schumaker@Netapp.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [50.36.162.105]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7f26b56-6b3c-45ff-dd88-08d925f79963
x-ms-traffictypediagnostic: DM5PR13MB1147:
x-microsoft-antispam-prvs: <DM5PR13MB11476A56FE7A24732625B598B83D9@DM5PR13MB1147.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92ZXptdlhDKcSpoCqG05lKetqSVDAgYfM2s0dsmgcKmp3Dmn7gI+vbYNtctlW+Is1jPSd7c0WfW/SuEM2W494kwATN7vC5zsD7r1FTxcRqCU7LGMNFHnufy9FoosOGQfnrtsIsfgM0sCKLOxKd6fRHXW/ai6L2ls80scODKGniE4ie1eGfuJfI6hxjuSv9TFCgGF9aZ+AR/Nizix+ycC5X/Hs+Xb00bmk7E22sozJ/+LutD04iFV5QlZqkdVURFIdridPdb/K2+91UmpZ7P8SDzyijvbuEjHIgZkX1DfUu4/UeEgjgORQcE3IhOLbLQD4IYQtPJWJBJhvd0xORijac9nsJWVF8ksdYtj5HGNyF91MMm910t9oQ02KTBk2WkOzLxFJg7X/E9AoYUaCD90XS9ADXp4WAxM/Hw7LQIaJfg8RAhyESUZvsAJRwKgIxbMoCVu/BqjF2bR/qHe4Cz189TPUKlcgQ3Q+zktPP2gJzCazB2tYr2LU6/vjEYnLE9ImJGvqp/scuYwtwReY6309/ushH3B/m6pOsBZX/SP0KTVoBP/owBQVeAPapPImkpiz4dTmueEHAxBp6RQuyI40kr/uzVS4zyVlQ0ljq/BRcc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39830400003)(396003)(346002)(136003)(66476007)(66556008)(5660300002)(66446008)(64756008)(76116006)(91956017)(66946007)(186003)(122000001)(83380400001)(2906002)(38100700002)(86362001)(8936002)(36756003)(110136005)(6486002)(4326008)(316002)(6512007)(8676002)(71200400001)(26005)(6506007)(478600001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YzB0VjRPK1Exam5ubFM5cmh0Q2ZvTHM1WXBTUXQwbWpocDh3NklYZXNaK2hY?=
 =?utf-8?B?QUxOZUdwTHNyN1A4dVE1Y0dUL21hV2RrUitzNXNyRzNlcnY0MWJha3VEdlQv?=
 =?utf-8?B?bjl2UmprZ3lFUkhFQXc3citmWGRuYm9oSEs3bW9ySEd3UHFyMVR0dkhFUzhP?=
 =?utf-8?B?akNDeDhONlZISjN1RkJCNnFxYjErNkJGYVhLWHhxRWxBdVFrVVN4SVA4Y3JN?=
 =?utf-8?B?UnN1Rk5BQ28xS3BDK0dlWHNVdGxXdlQyZm52ck16SWxLSFJLeTRkUHdTcW5y?=
 =?utf-8?B?eTRwa1htVkFZWmRlQlY2aFRvamtyQ2RXNlIxSEs5M1RxdDI1cGhtRElvemcv?=
 =?utf-8?B?Zy9wTlVDTXNTZElmUXd2L0RaVlkwalFoWkVFTk5LUE1XbEllQzNvd0VnRTFQ?=
 =?utf-8?B?M2E5OVBybnYrQThWTmZLbjd3RC9KUEgzSFdRMi9KMFJHSVVTNnBEb2ZTYWdu?=
 =?utf-8?B?N1dzZHVsZUxUemRzNEFGVTY4V1JTb2dTQmRSMTdGVk1Zc0ZUb2tXZVljSHJk?=
 =?utf-8?B?YzNvRldzRGdvY0FMelF4V0JMb2VnR1JYNTUxU2xVSTJhcjhZZitxa05Ldzl0?=
 =?utf-8?B?N3JmY09LbU45Q3lqMTNHOURnRmh1eDdCZld1QXN0ZnZBTUkxUkFXNk0vNXhH?=
 =?utf-8?B?cVdnQ21sd2Y3MXIxd0w1cWtDSG5XdkxFcVN4MC8xcm84VDhaMjlwOE9oSkFG?=
 =?utf-8?B?RTR0MVY2RmxFSUtkNWVtTlJ6ejhIdGtuektsY2JXQzJuc2RQTld3anVablZq?=
 =?utf-8?B?alpkTXRaNllIMFVyWXN2YWV2dkNIVlM0bU5wMzUyVXBQd3NOc0IvczIrbDN5?=
 =?utf-8?B?Zm00cHFWYnJPSXNLK2llSFF3d0ljZlBsRVFCUmNmakVESzBrUm5sTnNCQzBB?=
 =?utf-8?B?cjJPZW5QaEhNZ0xFYUI0V0w0b2k1UWwrRjU4TlJnMk9xdktMQTJXMUhVMG9r?=
 =?utf-8?B?QzhnM0pHRFVnWHAvbSs0SStNVk1WWkpidjVyc2g4c3kvRkNBTW9GN3J6OWxo?=
 =?utf-8?B?RUlTdGEweGhPaHhhc3ptUzU1aTlUSkE0UTJZY3Y5TWVMbHpBdU9COHJiUHNZ?=
 =?utf-8?B?bnp2UDFUenB6WFNZdklyS3ZUT3dLcXp0UTE1eXdlSXVleC8zL1ZLU3MwakZI?=
 =?utf-8?B?NlpDemFIallCMkQ2YTM1aFhHRUM4Q3pxZ1d4ZVJjK3dGNTlzN2kxbjQwVEto?=
 =?utf-8?B?dUhiM1lydGVCbkJ6MzFpNkRLUzNxdUhCQWtOUmpsNXl2Ukg5YWJXVTY0NFNv?=
 =?utf-8?B?YlZKRlhUbHRLV2d2eE1mMTFScVcxMTBoMEZQRW94QjhWdEhoYUhMYTJCVFJw?=
 =?utf-8?B?RXFTREcyc05GbklrZzc2MTJGNEhCUGlVamF2b0FPNWJUZUFwN2h3TVVESnlO?=
 =?utf-8?B?aHlsanJGTjlGMCt2dGk2L0V0aXpBcCswRVRnWHVVcERXTjhOamtZUVB3ZTBw?=
 =?utf-8?B?QmpVQWVvb2c3YnBNbzFTVTB2Q0lUeWxVYlFNWkVyNTUrY2kvQzBGbkJrTU5i?=
 =?utf-8?B?TndWdzBNbDhTeWpWbk9DdkJIMmdGdnpCWkZackFjc1hjV1FidXRsQ2VLRkJR?=
 =?utf-8?B?QTV6bk5mdWY0a282NUVMMTlrVU53RUt1M1J6WHJNNXlKWkp6MHpDVmh3LzBG?=
 =?utf-8?B?WUx4aVBJVVRLOEhOamxXb3pnWU1QaXFVY2MvdE91a0Z3RGdVbzdZRm03a0ZL?=
 =?utf-8?B?dVFHZEhHSEhKOW45clBEMG1ZS3BWZ1l5VG9ubTdTMHp0eHF2cmdHQldZeTBN?=
 =?utf-8?Q?Z2zpmg7JbdF6ZVf2j59qlnTNblN1Y4m2gyiB1eh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <26103DEEBDCE614CA8EE653B21AC5E6B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f26b56-6b3c-45ff-dd88-08d925f79963
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 18:52:40.8741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrmv8KsLIZeImg/o/zAAAJQXhhmIConBk6wrpY0XF5xlrHfZXI3mG/PMhcGNUuzoPJKjhCGuW1RZ1uwk/2uTNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1147
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTAyIGF0IDE0OjMxIC0wNDAwLCBzY2h1bWFrZXIuYW5uYUBnbWFpbC5j
b20gd3JvdGU6DQo+IEZyb206IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAu
Y29tPg0KPiANCj4gS0FTQU4gcmVwb3J0cyBhIHVzZS1hZnRlci1mcmVlIHdoZW4gYXR0ZW1wdGlu
ZyB0byBtb3VudCB0d28gZGlmZmVyZW50DQo+IGV4cG9ydHMgdGhyb3VnaCB0d28gZGlmZmVyZW50
IE5JQ3MgdGhhdCBiZWxvbmcgdG8gdGhlIHNhbWUgc2VydmVyLg0KPiANCj4gT2xnYSB3YXMgYWJs
ZSB0byBoaXQgdGhpcyB3aXRoIGtlcm5lbHMgc3RhcnRpbmcgc29tZXdoZXJlIGJldHdlZW4gNS43
DQo+IGFuZCA1LjEwLCBidXQgSSB0cmFjZWQgdGhlIHBhdGNoIHRoYXQgaW50cm9kdWNlZCB0aGUg
Y2xlYXJfYml0KCkgY2FsbA0KPiB0bw0KPiA0LjEzLiBTbyBzb21ldGhpbmcgbXVzdCBoYXZlIGNo
YW5nZWQgaW4gdGhlIHJlZmNvdW50aW5nIG9mIHRoZSBjbHANCj4gcG9pbnRlciB0byBtYWtlIHRo
aXMgY2FsbCB0byBuZnNfcHV0X2NsaWVudCgpIHRoZSB2ZXJ5IGxhc3Qgb25lLg0KPiANCj4gRml4
ZXM6IDhkY2JlYzZkMjAgKCJORlN2NDE6IEhhbmRsZSBFWENISUQ0X0ZMQUdfQ09ORklSTUVEX1Ig
ZHVyaW5nDQo+IE5GU3Y0LjEgbWlncmF0aW9uIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmfCoCMgNC4xMysNCj4gU2lnbmVkLW9mZi1ieTogQW5uYSBTY2h1bWFrZXIgPEFubmEuU2NodW1h
a2VyQE5ldGFwcC5jb20+DQo+IC0tLQ0KPiB2MjogTm8gY2hhbmdlcyBleGNlcHQgYWRkaW5nIHRo
ZSBmaXhlcyB0YWcgdGhhdCBJIGluaXRpYWxseSBmb3Jnb3QNCj4gLS0tDQo+IMKgZnMvbmZzL25m
czRjbGllbnQuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNGNsaWVudC5jIGIvZnMv
bmZzL25mczRjbGllbnQuYw0KPiBpbmRleCA4ODlhOWY0YzAzMTAuLjQyNzE5Mzg0ZTI1ZiAxMDA2
NDQNCj4gLS0tIGEvZnMvbmZzL25mczRjbGllbnQuYw0KPiArKysgYi9mcy9uZnMvbmZzNGNsaWVu
dC5jDQo+IEBAIC00MzUsOCArNDM1LDggQEAgc3RydWN0IG5mc19jbGllbnQgKm5mczRfaW5pdF9j
bGllbnQoc3RydWN0DQo+IG5mc19jbGllbnQgKmNscCwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnNfbWFy
a19jbGllbnRfcmVhZHkoY2xwLCAtRVBFUk0pOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiAtwqDC
oMKgwqDCoMKgwqBuZnNfcHV0X2NsaWVudChjbHApOw0KPiDCoMKgwqDCoMKgwqDCoMKgY2xlYXJf
Yml0KE5GU19DU19UU01fUE9TU0lCTEUsICZjbHAtPmNsX2ZsYWdzKTsNCj4gK8KgwqDCoMKgwqDC
oMKgbmZzX3B1dF9jbGllbnQoY2xwKTsNCg0KT0suIEknbSByZWFkaW5nIHRoaXMsIGFuZCBpdCBp
cyBub3QgbWFraW5nIHNlbnNlIHRvIG1lLiBXaHkgYXJlIHdlDQpjaGFuZ2luZyBhIGZsYWcgb24g
YW4gb2JqZWN0IHRoYXQgaXMgYWJvdXQgdG8gYmUgZGVzdHJveWVkIGJ5IHRoZQ0KbmZzX3B1dF9j
bGllbnQoKSBhbnl3YXk/IExldCdzIGdvIGJhY2sgdG8gdGhlIGF1dGhvciBvZiBjb21taXQNCjhk
Y2JlYzZkMjAgYW5kIGFzayBoaW0uDQoNCkNodWNrLCBpcyBpdCBwb3NzaWJsZSB0aGF0IHlvdSB3
ZXJlIGFjdHVhbGx5IGludGVuZGluZyB0byBjbGVhcg0KTkZTX0NTX1RTTV9QT1NTSUJMRSBvbiAm
b2xkLT5jbF9mbGFncyAoaS5lLiBvbiB0aGUgb2JqZWN0IHRoYXQgaXMNCmFjdHVhbGx5IHJldHVy
bmVkIGJ5IHRoZSBjYWxsIHRvIG5mczRfaW5pdF9jbGllbnQoKSk/DQoNCj4gwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBvbGQ7DQo+IMKgDQo+IMKgZXJyb3I6DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0
DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
