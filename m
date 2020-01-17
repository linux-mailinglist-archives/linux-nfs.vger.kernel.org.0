Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8514129E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 22:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgAQVJz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 16:09:55 -0500
Received: from mail-eopbgr770072.outbound.protection.outlook.com ([40.107.77.72]:50089
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729818AbgAQVJz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:09:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTjNbZBixW+1yR7zLElfWodART3CvP+CW2bq0p9khV8ygTw+75Et4fREGJlS1R+Bx0ernmXp6sv94WPq7PSEHlO48vFQv5/rUn7gk5VZFJ2VBcPLq9YwK2PIQKK91LipTSbt6964wPY1X/3F8nGQpwDMKdeK2mUKKpId/53bnMX/tUtqFIPESdbIZw+sr6AOsXIYMcm6TgpHPgrLvFNyjycgADHKlBEXs7OruYvItvg6ESZzvutzeR7fnj7karSReVodz6Zh61luSc5C6AR4zgA2Lh0f/9uW3cIBUxwcECEFPmxzw/zqkfczoKTnujzZQ5YDNv39Pva14E1lkS3lAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xdS9lU1TKMRaF15VVjuZG1PhMyeejQQJyn8uzvcDRQ=;
 b=RWAKJW/K6kVem0Hf0vy9X6dotDoBg9+OO9L/2JvUg8Zll8/0XrmTS7SeAVg2jhj5BvtJSHngTDdpb083jhacX9gQzdBvr4HpeYyqK4IxuEEYi8W5OnyqRMHlBOLSguySbiKJw8REJL9VoJkbHsu2dfrEOJxxJqQBaYojV0eUQg9y65ZiL8mKW/IAHtGPE9FOleGttsLmYqPdRLc/DOG5lFDaspPx+MUNJGHa/OEWTvjLfNQoNA61nVLvfabO2MeKcrbF9jxrA8c1bJ4YcxMq/WBgljgglYhLxvPaayP++yrCTHY89r2vo4nfuIkJwgY0gzB+PC7rveSshveZV75Jdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xdS9lU1TKMRaF15VVjuZG1PhMyeejQQJyn8uzvcDRQ=;
 b=A+mw6pE0PddBsOyhtH2PdY5km5CkAwvDo7J3P+8FAMCfnJZ0RvEHFtvnHM/fhU/idUNHOVET8HBEzVxVZUx5DK6Y0N+8nujeeQv3a17liCcfA3orDzeiPzxFrcFcpqoV7UeZY5RUkGBMFertblHFkanJG51UACtkjPxP1GKn1WE=
Received: from BL0PR06MB4370.namprd06.prod.outlook.com (10.167.241.142) by
 BL0PR06MB4259.namprd06.prod.outlook.com (10.167.180.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Fri, 17 Jan 2020 21:09:53 +0000
Received: from BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1]) by BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1%6]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020
 21:09:53 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Thread-Topic: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Thread-Index: AQHVzKBvkFwiKJer6kCJD5wdp4VGvafvW6oA
Date:   Fri, 17 Jan 2020 21:09:53 +0000
Message-ID: <1f3297c1549ad12d47497cd18d2c0d9bc7bc5fe7.camel@netapp.com>
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db53586f-9785-4b65-7484-08d79b9198f9
x-ms-traffictypediagnostic: BL0PR06MB4259:
x-microsoft-antispam-prvs: <BL0PR06MB4259342A17183A166AC7DE0DF8310@BL0PR06MB4259.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(316002)(110136005)(66556008)(64756008)(66476007)(6512007)(91956017)(76116006)(71200400001)(2616005)(66446008)(66946007)(4326008)(86362001)(6486002)(5660300002)(4744005)(36756003)(2906002)(81166006)(478600001)(26005)(8936002)(186003)(6506007)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR06MB4259;H:BL0PR06MB4370.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IHaeDHw9vw7DWC+LzG7f+HcSgRSVhazVdE8Ol93YkUiLmyRx4lJF8q2+dKKumg7IiKclPTX1jjgNoySiWEUsRMVsYEVK496OA8XovdJvxV9BRQ1uDjqXP8hTXtXoXbBNk341fj3e8XXPtlxKPu0yzdzrSMZ7nX5AVynDxYOuuknyVFD1b8yMwfq/5veAO9LIbcWOHQjd1ZihRYGiW+zqfm/A+5pxwszZbL8tQs0FdVWybNohwYxIw6HbE5jzfKVYufaxKhxnZaDeuJ2672lHZn60jYJ1pjHEe6WJ2GrRPCWyTK1i5wxsuKeIqI9xByP7xkFuY9lUS7gDVHbRAdnFn/2LXgpTR37TwHE67JCRXRYzTlHXeCZ6YElsdxfI0ridC9Ds+2m1EpDmEYxmdlpxr5lChL9tU9dlSLVZHrrcKW3b4hDVEmfyhDh3GdAn8V4g
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A488D04A6485EB4BB2FDB9741518A545@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db53586f-9785-4b65-7484-08d79b9198f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 21:09:53.2378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbhsvyIUzJstqCDF6zl0nBHS4regaXP1qfNwmgPnuI0O1UOsDOsubAdn41GhqUC/pQNMp3oivkMdh3sHERvTBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4259
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gVGh1LCAyMDIwLTAxLTE2IGF0IDE0OjA4IC0wNTAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5j
b20+DQoNCkhhdmUgeW91IGRvbmUgYW55IHRlc3Rpbmcgd2l0aCBuY29ubmVjdCBhbmQgdGhlIHY0
LjAgcmVwbGF5IGNhY2hlcz8gSSBkaWQgc29tZQ0KZGlnZ2luZyBvbiB0aGUgbWFpbGluZyBsaXN0
IGFuZCBmb3VuZCB0aGlzIGluIG9uZSBvZiB0aGUgY292ZXIgbGV0dGVycyBmcm9tDQpUcm9uZDog
IlRoZSBmZWF0dXJlIGlzIG9ubHkgZW5hYmxlZCBmb3IgTkZTdjQuMSBhbmQgTkZTdjQuMiBmb3Ig
bm93OyBJIGRvbid0DQpmZWVsIGNvbWZvcnRhYmxlIHN1YmplY3RpbmcgTkZTdjMvdjQgcmVwbGF5
IGNhY2hlcyB0byB0aGlzIHRyZWF0bWVudCB5ZXQuIg0KDQpUaGFua3MsDQpBbm5hDQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiAt
LS0NCj4gIGZzL25mcy9uZnM0Y2xpZW50LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZz
NGNsaWVudC5jIGIvZnMvbmZzL25mczRjbGllbnQuYw0KPiBpbmRleCA0NjBkNjI1Li40ZGYzZmIw
IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNGNsaWVudC5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0
Y2xpZW50LmMNCj4gQEAgLTg4MSw3ICs4ODEsNyBAQCBzdGF0aWMgaW50IG5mczRfc2V0X2NsaWVu
dChzdHJ1Y3QgbmZzX3NlcnZlciAqc2VydmVyLA0KPiAgDQo+ICAJaWYgKG1pbm9ydmVyc2lvbiA9
PSAwKQ0KPiAgCQlfX3NldF9iaXQoTkZTX0NTX1JFVVNFUE9SVCwgJmNsX2luaXQuaW5pdF9mbGFn
cyk7DQo+IC0JZWxzZSBpZiAocHJvdG8gPT0gWFBSVF9UUkFOU1BPUlRfVENQKQ0KPiArCWlmIChw
cm90byA9PSBYUFJUX1RSQU5TUE9SVF9UQ1ApDQo+ICAJCWNsX2luaXQubmNvbm5lY3QgPSBuY29u
bmVjdDsNCj4gIA0KPiAgCWlmIChzZXJ2ZXItPmZsYWdzICYgTkZTX01PVU5UX05PUkVTVlBPUlQp
DQo=
