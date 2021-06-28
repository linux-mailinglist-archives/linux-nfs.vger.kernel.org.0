Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B9B3B6AAA
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 00:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhF1WCq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 18:02:46 -0400
Received: from mail-bn8nam11on2122.outbound.protection.outlook.com ([40.107.236.122]:29601
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233976AbhF1WCp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Jun 2021 18:02:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcSmsPun5bMpbqO7nmu6Bw7MfXpmW+nzaBlAWv1z1j93zKBdyiSWiz96oQkj542NEytvxxma7Z+V3KdKFN9wFfSyi2FRdhDVRb8dz5SufyeUdEmvOFvq4VB+oetbCpansx60rnjGVVVbHi5xaPb0IayQTc4OCetnZtrTo+SwyFS1IJOjPFA8pWAy89hEJ+E8lBgomrqeeV3rBdsP+mJl7DoI7yXePYJ2Hbj9jAZDzVVtRr+C5wjyMXJTsRTY8DPJsv2AlHXebEt8/h5fiDF9eBKo1aSu2qorUBa/E2Hk1dpTXG6qXtoWtC+Iw9FGzv+kTo9D1ABcDCzKk+cIa3RUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/NuUBw430hUyl/fLUkbT+UIy/1khNrV1fI0dwZ+Usk=;
 b=gMz+CNtFmqUjFgpg2rJ5Ko/3ctvPD5XxWNQtrjEVAPE7wL9LatQpCx+kVFkKX6g7Bd39Vo9x3ZY4BVRm5rixY5Mo6hOl2rO1CLF5I2OGD9XBneDZx+FjEqrcsG/95oRHfP1nipYcswFfsutw1J/66uI5TXs4ja00KsmLwvxvVRPndBw+9mrezJWcfauVMt36mLjnpAF+6jDUu4IgaBLFGBnL9yVyOxNy3Zi5gcXFJVfk+oAX32vP6h9T+7Qa89Vt70WOU+QracXzyxHOlJg7EeiQHrLP0awfSCMHwHmA/dIK1y6uMyhAr/8/moOfWi4WR/oIiyZTBc3d/TSf9Yy0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/NuUBw430hUyl/fLUkbT+UIy/1khNrV1fI0dwZ+Usk=;
 b=b+CSXWCNhLoOw9h5VJ+Dc9jb8BUS68lI4bBFXXW+9h2+wQ6tvkEdwvAb8axPpebgWEhRhnv2BLws6/HXf1q8fAYO3csg0HJksM0UIBws07ikYnNzIrINqNMV95ApMUMmhG1qZUoYToTVpMsCI2L7yoH2UJEw6c3s7dDdOzjZd/g=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3639.namprd13.prod.outlook.com (2603:10b6:610:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.19; Mon, 28 Jun
 2021 22:00:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 22:00:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 2/4] NFS: Ensure nfs_readpage returns promptly when
 internal error occurs
Thread-Topic: [PATCH 2/4] NFS: Ensure nfs_readpage returns promptly when
 internal error occurs
Thread-Index: AQHXbESBxYbm8C/KlUeWrZKSUbsmt6spzAIAgAAMCACAACFhAA==
Date:   Mon, 28 Jun 2021 22:00:17 +0000
Message-ID: <c4ca239850c7b265ae857ea34cf167e13874adbc.camel@hammerspace.com>
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
         <1624901943-20027-3-git-send-email-dwysocha@redhat.com>
         <2561b4f973e14eba413f648b657a7945830af202.camel@hammerspace.com>
         <CALF+zOn7jTduKYRX_fpNjV+qRat+4qqocVLa=dMfQeUU+RmVaw@mail.gmail.com>
In-Reply-To: <CALF+zOn7jTduKYRX_fpNjV+qRat+4qqocVLa=dMfQeUU+RmVaw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87c17dcf-e03b-48da-7940-08d93a801d9b
x-ms-traffictypediagnostic: CH2PR13MB3639:
x-microsoft-antispam-prvs: <CH2PR13MB363964F7C4FF671B7E021A64B8039@CH2PR13MB3639.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q8suinsYPm0a3qtY51tJ6PKTahiHLBSj8Mf2UHnsQ9I/kQXnKuL/hYjaLSmBnjPoQjUS0jGq6aUo54U6AwgWSfyj57bEUyxQrQNkEm5on9vXNjjJT0wjRy/MHCt/yc0Iks7psAwunMsj2/bn4A9Oq0skpVPZOEdFK6r8N+dsk2p1MYuYVbNyUJ3Yo8Khh5agkS7ptg4QJOusgffc1jZ+uFmKqwqoF2qsZl2wOVRx0s2MIWyZaLwUPcFmVk4HLtxt4nczRstKDBikRwOfPK8j34lHHD/jQTKMRTZH4OwfBh6VnR44p/iiFLoj7sj+z40FI1TkcRcJ5ViMOSXucWtfFmwHB4D+g/7Z8uXn5+Rqy5CPsarnzTtcqMZWddkByF6SJBHSDCf8Re6NO03JDJHzr/JPsbcyGVZ8ei9LdQqF2EJ1HVMHwM1Z7E8RrvokKLmdL+8EQl5AsC4SCDxOdnS51irpczDem9MaZ5TRCT7ujrQD3kphv46ubylMX6bkwfZPopXszQc4/Cbjin6ivId2VkM2BU9fUyDQF0kXwLsW/zwYA0PtM03VGgodjG8XItx0G22hhhpJSVUCl0zwQzjHaFBLu+QroGoxo9amUnMBVJNzQjU9fAWaheDlN9m03s/fq1KN6Ut1xpFez6ZtBGqo8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(4326008)(186003)(508600001)(2616005)(36756003)(64756008)(5660300002)(66446008)(71200400001)(6512007)(66476007)(66556008)(76116006)(66946007)(122000001)(6486002)(38100700002)(54906003)(2906002)(86362001)(6916009)(8676002)(6506007)(53546011)(8936002)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTVNWHN2blFvS2IrVnlSZzdKM1k3dHI3bjhLdzhmSlFqaE52WmVqSmhvcWlE?=
 =?utf-8?B?UWcrWk50ZFlZLzFaZFl1VmJWSjdRR3J1TkNIUGo0Z2hpYkZUcTJ2ZkxXeEZK?=
 =?utf-8?B?ZmN2b2dIS0lXUS9HbDZHZ0ZVSjVTRW5CcFBGWlpXSE5wWC94UnFhZ2Z4bDJk?=
 =?utf-8?B?VUNTcUc2aFFOcmVvMGtpZTdIcmViTWVLNXNiT1dnRXR3OXU2cWJpa005bEoz?=
 =?utf-8?B?c1V0cGNLeFRWME9YOHZVUDM2d2taU3NkcUhESS9lUDJYQlpPeXp4YWZ0VjMx?=
 =?utf-8?B?VWNiaWlkNThDSkk0YUc2bUZZcWgyT0I2b3NLMmx3dXd1NDJ4cHlydjZUWU1l?=
 =?utf-8?B?b1ZMRmhjbk42MjErZzlwSXlDQXdPWVdVeVpyOFE0a2RoNzdSVlNqWG9mM3k4?=
 =?utf-8?B?T1VMcnlDakNDOFd3V1NXdEpKNlhuakNEc29tanJ3R0tQV2dyZGppVkNPZU5m?=
 =?utf-8?B?Yi9KUUdncHlFS0FPYWR1d2I0dXVrbzFBSU44NTg3YTBxMCtkWHgvRTRjaUxn?=
 =?utf-8?B?eDByRWpMbzJyUXUvelZrN0JFeGhFMHQwbXhsakFjaWtvWmEvNHZaVzNseTRC?=
 =?utf-8?B?NUNvMWxvRk1pUHB6dGpBMlExd0FHYTdzT1BhcWZzeUZHZ0ozR05JbmFUTXpQ?=
 =?utf-8?B?WEpwR21Tc2R2VkViUGJzNTA5TzVNY3VUM0Jjd3FpWUpubXJ4aWdIYlQ4UUlU?=
 =?utf-8?B?THV3cWdBYTJSVGVsb09iaDR5bks1ZGZ3U3hvc2FUOGdsSWtXdU4wT2VxZUsx?=
 =?utf-8?B?dkhUMVVNSXpmaFU1K3RqTjQ4QzJjWEE4dkEwK1RDanN6bWdJS3g5Y0EwRFRx?=
 =?utf-8?B?bXk0bWpaenRVOWYzd0pNcUZ0Q0VvRXZXRW56a1VpdXdDazJ6YTlYUGNybEVx?=
 =?utf-8?B?RFpyWDFGWmwySjhEWkRkc0pXUFFBQU5saExnSmkvVFU5UERMZHhXRDhuS2F4?=
 =?utf-8?B?ZE1wTzlYSGZ0QzZra0FIcy9NVlh2c2dKSVdySHdFbVNjSkZSNnpsdTJ3cWhz?=
 =?utf-8?B?SzdHMTFCOG41NGVnaDIreXAvYW1wU0xzeDYzTlhNazdnYW1zV25Rb3VNekhl?=
 =?utf-8?B?UmE0c2RqMU1pTWNYMTJjSXJ0V1pzcXNIaUQ5Zi9LdUZJSjhuSHZDTXhTZTU0?=
 =?utf-8?B?d3ZIc3FXSW43c0xxMi9HNU5DM1JWd2dXeHRreEQwZjM5ajYzbWZoS1FZRWd4?=
 =?utf-8?B?N21RWTM2OWdmOWxLNkZ3WDIyZCtiR0k2c25ZcFNUZnRFSDVkN0xwNVBKK2Yz?=
 =?utf-8?B?NlBvS3BMUkRSd3djWEhxTGVKZ2pZcmFXaFQ4d0VjVS9HNnp3U0M3VFE1VnFS?=
 =?utf-8?B?QmYwZ1JjbUZSQkFaaWcxc282NzBWclNPR2E5RUxLT1U4azR6NVdHcHBOMHVL?=
 =?utf-8?B?TFJCb242bXpoMzdnOFU5NUgxY09FWlZjbFFLNE9GS1FENXNGMHdnM3ZTZmp5?=
 =?utf-8?B?OC9TYWxpWHB1TTZBRXdTeTVxRVdhcCs1UmdlRkFYK3hhQUVQSE5zWGNOV21u?=
 =?utf-8?B?SFI5SHBQSDJ1NkRPUnNrSHJEck5xeWhTbUJTK21qZGhwSHZ1UTRuRVlxek04?=
 =?utf-8?B?bjdnbGttZ2Jvb1lCYlBYdjNiSW5RREtUc0NiVEd6YnI2TlE3YndITldhTm5Z?=
 =?utf-8?B?cWFBdDFpaHgvUGNJdEZDRmpLeTlUYnh4NzVaTnFsWGRWUEIxbnVxaDJWYklv?=
 =?utf-8?B?ajFXaUprc3l3WGFHZXErMkk5eDJYbkV1RHE5N3ZuZzdJcFRhcDRlc0U1eHFq?=
 =?utf-8?Q?KGuH/vDBkUCT94rafazizt+08C8hM0hKyPXlso4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD9E8C9BB583774EB3B791A987EAF5A9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c17dcf-e03b-48da-7940-08d93a801d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 22:00:17.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3LiKmENrgSFfgWtrxTk8wWPQDurv1oDLpFn+HwcI0tgMWruXDkmXLHIQlaec3Ian0BuNalWWnLbj7pmWIAjUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3639
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTI4IGF0IDE2OjAwIC0wNDAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gT24gTW9uLCBKdW4gMjgsIDIwMjEgYXQgMzoxNyBQTSBUcm9uZCBNeWtsZWJ1c3QNCj4g
PHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIDIwMjEt
MDYtMjggYXQgMTM6MzkgLTA0MDAsIERhdmUgV3lzb2NoYW5za2kgd3JvdGU6DQo+ID4gPiBBIHBy
ZXZpb3VzIHJlZmFjdG9yaW5nIG9mIG5mc19yZWFkcGFnZSgpIG1pZ2h0IGVuZCB1cCBjYWxsaW5n
DQo+ID4gPiB3YWl0X29uX3BhZ2VfbG9ja2VkX2tpbGxhYmxlKCkgZXZlbiBpZiByZWFkcGFnZV9h
c3luY19maWxsZXIoKQ0KPiA+ID4gZmFpbGVkDQo+ID4gPiB3aXRoIGFuIGludGVybmFsIGVycm9y
IGFuZCBwZ19lcnJvciB3YXMgbm9uLXplcm8gKGZvciBleGFtcGxlLCBpZg0KPiA+ID4gbmZzX2Ny
ZWF0ZV9yZXF1ZXN0KCkgZmFpbGVkKS7CoCBJbiB0aGUgY2FzZSBvZiBhbiBpbnRlcm5hbCBlcnJv
ciwNCj4gPiA+IHNraXAgb3ZlciB3YWl0X29uX3BhZ2VfbG9ja2VkX2tpbGxhYmxlKCkgYXMgdGhp
cyBpcyBvbmx5IG5lZWRlZA0KPiA+ID4gd2hlbiB0aGUgcmVhZCBpcyBzZW50IGFuZCBhbiBlcnJv
ciBvY2N1cnMgZHVyaW5nIGNvbXBsZXRpb24NCj4gPiA+IGhhbmRsaW5nLg0KPiA+ID4gDQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBEYXZlIFd5c29jaGFuc2tpIDxkd3lzb2NoYUByZWRoYXQuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiDCoGZzL25mcy9yZWFkLmMgfCAyMSArKysrKysrKysrKystLS0tLS0t
LS0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvcmVhZC5jIGIvZnMvbmZzL3Jl
YWQuYw0KPiA+ID4gaW5kZXggNjg0YTczMGY2NjcwLi5iMDY4MDM1MWRmMjMgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9mcy9uZnMvcmVhZC5jDQo+ID4gPiArKysgYi9mcy9uZnMvcmVhZC5jDQo+ID4gPiBA
QCAtNzQsNyArNzQsNyBAQCB2b2lkIG5mc19wYWdlaW9faW5pdF9yZWFkKHN0cnVjdA0KPiA+ID4g
bmZzX3BhZ2Vpb19kZXNjcmlwdG9yICpwZ2lvLA0KPiA+ID4gwqB9DQo+ID4gPiDCoEVYUE9SVF9T
WU1CT0xfR1BMKG5mc19wYWdlaW9faW5pdF9yZWFkKTsNCj4gPiA+IA0KPiA+ID4gLXN0YXRpYyB2
b2lkIG5mc19wYWdlaW9fY29tcGxldGVfcmVhZChzdHJ1Y3QNCj4gPiA+IG5mc19wYWdlaW9fZGVz
Y3JpcHRvcg0KPiA+ID4gKnBnaW8pDQo+ID4gPiArc3RhdGljIGludCBuZnNfcGFnZWlvX2NvbXBs
ZXRlX3JlYWQoc3RydWN0IG5mc19wYWdlaW9fZGVzY3JpcHRvcg0KPiA+ID4gKnBnaW8pDQo+ID4g
PiDCoHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBuZnNfcGdpb19taXJyb3IgKnBnbTsN
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgbnBhZ2VzOw0KPiA+ID4gQEAgLTg4
LDYgKzg4LDggQEAgc3RhdGljIHZvaWQgbmZzX3BhZ2Vpb19jb21wbGV0ZV9yZWFkKHN0cnVjdA0K
PiA+ID4gbmZzX3BhZ2Vpb19kZXNjcmlwdG9yICpwZ2lvKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqAg
TkZTX0kocGdpby0+cGdfaW5vZGUpLT5yZWFkX2lvICs9IHBnbS0+cGdfYnl0ZXNfd3JpdHRlbjsN
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIG5wYWdlcyA9IChwZ20tPnBnX2J5dGVzX3dyaXR0ZW4gKyBQ
QUdFX1NJWkUgLSAxKSA+Pg0KPiA+ID4gUEFHRV9TSElGVDsNCj4gPiA+IMKgwqDCoMKgwqDCoMKg
IG5mc19hZGRfc3RhdHMocGdpby0+cGdfaW5vZGUsIE5GU0lPU19SRUFEUEFHRVMsIG5wYWdlcyk7
DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgIHJldHVybiBwZ2lvLT5wZ19lcnJvciA8IDAg
PyBwZ2lvLT5wZ19lcnJvciA6IDA7DQo+ID4gPiDCoH0NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBA
QCAtMzczLDE2ICszNzUsMTcgQEAgaW50IG5mc19yZWFkcGFnZShzdHJ1Y3QgZmlsZSAqZmlsZSwg
c3RydWN0DQo+ID4gPiBwYWdlDQo+ID4gPiAqcGFnZSkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZuZnNfYXN5bmNfcmVhZF9j
b21wbGV0aW9uX29wcyk7DQo+ID4gPiANCj4gPiA+IMKgwqDCoMKgwqDCoMKgIHJldCA9IHJlYWRw
YWdlX2FzeW5jX2ZpbGxlcigmZGVzYywgcGFnZSk7DQo+ID4gPiArwqDCoMKgwqDCoMKgIGlmIChy
ZXQpDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gPiA+
IA0KPiA+ID4gLcKgwqDCoMKgwqDCoCBpZiAoIXJldCkNCj4gPiANCj4gPiBDYW4ndCB0aGlzIHBh
dGNoIGJhc2ljYWxseSBiZSByZWR1Y2VkIHRvIHRoZSBhYm92ZSAyIGNoYW5nZXM/IFRoZQ0KPiA+
IHJlc3QNCj4gPiBhcHBlYXJzIGp1c3QgdG8gYmUgc2hpZnRpbmcgY29kZSBhcm91bmQuIEknbSBz
ZWVpbmcgbm90aGluZyBpbiB0aGUNCj4gPiByZW1haW5pbmcgcGF0Y2hlcyB0aGF0IGFjdHVhbGx5
IGRlcGVuZHMgb24NCj4gPiBuZnNfcGFnZWlvX2NvbXBsZXRlX3JlYWQoKQ0KPiA+IHJldHVybmlu
ZyBhIHZhbHVlLg0KPiA+IA0KPiANCj4gT3JpZ2luYWxseSBJIHdhcyB0aGlua2luZyB0aGVyZSB3
YXMgYSBiZW5lZml0IHRvIGhhdmluZw0KPiBuZnNfcGFnZWlvX2NvbXBsZXRlX3JlYWQgcmV0dXJu
IGEgc3VjY2Vzcy9mYWlsdXJlDQo+IHNpbWlsYXIgdG8gcmVhZHBhZ2VfYXN5bmNfZmlsbGVyKCkg
d2hpY2ggaXMgd2h5IEkgbW92ZWQNCj4gaXQuDQo+IA0KPiBZb3UgbWVhbiBqdXN0IHRoaXMgcmln
aHQ/wqAgSWYgc28sIHllcyBJIGFncmVlIHRoaXMgd291bGQgYmUgYSBtaW5pbWFsDQo+IHBhdGNo
Lg0KPiBXYW50IHRoaXMgYXMgYSB2Mj8NCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvcmVhZC5j
IGIvZnMvbmZzL3JlYWQuYw0KPiBpbmRleCA2ODRhNzMwZjY2NzAuLmViMzkwZWI2MThiMyAxMDA2
NDQNCj4gLS0tIGEvZnMvbmZzL3JlYWQuYw0KPiArKysgYi9mcy9uZnMvcmVhZC5jDQo+IEBAIC0z
NzMsMTAgKzM3MywxMCBAQCBpbnQgbmZzX3JlYWRwYWdlKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1
Y3QgcGFnZQ0KPiAqcGFnZSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgJm5mc19hc3luY19yZWFkX2NvbXBsZXRpb25fb3BzKTsNCj4g
DQo+IMKgwqDCoMKgwqDCoMKgIHJldCA9IHJlYWRwYWdlX2FzeW5jX2ZpbGxlcigmZGVzYywgcGFn
ZSk7DQo+ICvCoMKgwqDCoMKgwqAgaWYgKHJldCkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBvdXQ7DQo+IA0KPiAtwqDCoMKgwqDCoMKgIGlmICghcmV0KQ0KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZnNfcGFnZWlvX2NvbXBsZXRlX3JlYWQoJmRlc2MucGdp
byk7DQo+IC0NCj4gK8KgwqDCoMKgwqDCoCBuZnNfcGFnZWlvX2NvbXBsZXRlX3JlYWQoJmRlc2Mu
cGdpbyk7DQo+IMKgwqDCoMKgwqDCoMKgIHJldCA9IGRlc2MucGdpby5wZ19lcnJvciA8IDAgPyBk
ZXNjLnBnaW8ucGdfZXJyb3IgOiAwOw0KPiDCoMKgwqDCoMKgwqDCoCBpZiAoIXJldCkgew0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gd2FpdF9vbl9wYWdlX2xvY2tlZF9r
aWxsYWJsZShwYWdlKTsNCj4gDQoNClllcC4gVGhpcyB3aGF0IHdoYXQgSSBoYWQgaW4gbWluZC4g
VGhhbmtzIQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
