Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3073A2B0AC7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 17:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgKLQyp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 11:54:45 -0500
Received: from mail-mw2nam12on2133.outbound.protection.outlook.com ([40.107.244.133]:23392
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728692AbgKLQyo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Nov 2020 11:54:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9bTSD2ugXcN2hNNkhB/hxngyPIBdn7W81RNkTl5vYTxrrFPiasRLtdE2ZNfP03bc5CtcE32OYOBrSvnCYOU/xIvAHHk3hMDhdZNQBTQim8ClihwGd2cBYceVDRxTyhDogMpDKI93ZQVSbzO87i/M40fvrOOaCU7uKIkeB4lrq1WQoyak4jTf1YAeENEevj5D3Amb0A+BFI/XnDmw0f2x/LQRKcLvNn2LVpX8tvoht3nIxwb4roERB2C1ujL1WA52u8Ibv4o+wBZ4+oDjwX9/b9v+gRV49PcYV2kAi+aQM3e9YrSghoJEPVwVPvyB4Nj9FpvFQMkhd9ggEYPETvPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQq6K70UlIDSu3GWC/YzHGD/TwmkolClLmi3Beemt04=;
 b=lIN8tLuJQ6tpDC3yrdpZ6DlI6U5Mv+0TQGKa4SIXMfCzFcDHnfiCaytU6Q/CB4f7e4qphxgrZtx5hd8Vn98RKBh6fI39huHffsj/VKwbP5NBUc+NcjQs4r8Qr+ZYshefmyqjdXP+G54WYiM6HLmibIFd2LdGVKtUkww59wB9zyaVokhrtKEhl8hpYZVHPvRU7P30JRjDNtiIO4ZhPnS78D6pR3ydiJ1bBDrGA9oL0L8NXSooEa6/3lHp1V4ZkC0uaRWa2s6ebEtfTGi0Vvs+WXinYtokzu6XU3aK6IThJvrF8IKIPzvV1Q7g2QmXsSfLchjMuU3IHDii720pIBLK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQq6K70UlIDSu3GWC/YzHGD/TwmkolClLmi3Beemt04=;
 b=UJpA3qkYTaeVi5mk6uQ/f/+gC+7EB/YVOsjroMsDMGOlGo2h0RLMvKcnZS9NM0S+7lscdEejcuH2swOu5P7O1YOGw2lO3/4Ovs0ddmW2RUMtQWnGnFhv4vqQEVbPd7M2plfn+0Bf3/koI2Nil3Pw4i+etMi+SI7+yFyIdSZ/h60=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2637.namprd13.prod.outlook.com (2603:10b6:208:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.15; Thu, 12 Nov
 2020 16:54:40 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Thu, 12 Nov 2020
 16:54:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "guy@vastdata.com" <guy@vastdata.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH v5 00/22] Readdir enhancements
Thread-Topic: [PATCH v5 00/22] Readdir enhancements
Thread-Index: AQHWt6smlycN3byFeUCu4hbFFYYhUqnDgPIAgADhS4CAAEEBgIAAFm8A
Date:   Thu, 12 Nov 2020 16:54:39 +0000
Message-ID: <fbc830f41e90c510adef43e13c4463add305f6a9.camel@hammerspace.com>
References: <20201110213741.860745-1-trondmy@kernel.org>
         <CALF+zOkdXMDZ3TNGSNJQPtxy-ru_4iCYTz3U2uwkPAo3j55FZg@mail.gmail.com>
         <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com>
         <CAENext7G47KvYO3q0_7g3KUX+QxQs3G17nuqs=Npsg2RBPdX7g@mail.gmail.com>
In-Reply-To: <CAENext7G47KvYO3q0_7g3KUX+QxQs3G17nuqs=Npsg2RBPdX7g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vastdata.com; dkim=none (message not signed)
 header.d=none;vastdata.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e8a11fa-d02a-4b07-80b0-08d8872ba559
x-ms-traffictypediagnostic: MN2PR13MB2637:
x-microsoft-antispam-prvs: <MN2PR13MB2637A4B69639807F882F661BB8E70@MN2PR13MB2637.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +fa+U2KZQr0zSxXGf9BBj+B3Dp0XRilPYPiUthWTO+MF28gFOPxkNyVb99NdVGzkGR9Cq2QtzIv430cqOw6EJMohkTi4qP8+wZSmPN6s53musfTfceEK/F1iTq9ZwcvoLFoD9Aj3pR5JMNmyPomjaiAi8N0MAkgjcu9OKXNFL7Xn/N2UDWJjoCmkNXKh80KhDZXjNvAYkeevv8lJqHcX1J1+tW0ZYtO3WCMCFssWjJ+JPJ/fA6CEXYQpIGu1WUiqDKueYklrWg+oOTL//4mmRtrN2ioSik1IkYVjrPR920f9M4KHfGrCw2kVKdqjSSAemxydroT++A3dq6lugkLUUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(346002)(366004)(396003)(376002)(6506007)(66556008)(76116006)(91956017)(4001150100001)(83380400001)(8936002)(66446008)(66946007)(64756008)(5660300002)(4744005)(6512007)(36756003)(2616005)(2906002)(316002)(186003)(86362001)(478600001)(54906003)(6486002)(4326008)(8676002)(26005)(71200400001)(110136005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WZn/yxnvORRWFhh1cGUHJnd7TgfFKhNjpwbaYYO8uNxaCItepaUpqjOmHTjKyPsVZb/SFxopsVUtUpxf+uU8S23CMOafT5pDE+JWDcyYsTn3gI5SC6bhk1DxoPjTCq3J4bNtnG/IpkgvqCgJkVsDqsaER9yMmFlYlq8QkcX7sYg9cpXndF0nIUhHWIp8SZSiCPf+h+4Ye9yvEAervLvHHb6RB0aWEs7y/oaFIw2NAiKIfcrkiVQpbTaHKJGh87MCpfoSTKWwKsIMCN69B6EsOp+nyFLZ5tKnIypL63f+qFz5U/5zqERb1qwGyV8Yg+M41irOdWPlcLdDbjls6/H/3gQ3VJQovwWW/iXR1AW9t+0K5r2Q0LdwAyMM9+HeNYV3Zc4xBHoVksLxmRbXPCaBN9SNKrrv51b6qhL5idvfyIqC3EYYbzktwyx1mFePSa5ynR5RXtEH1dF6hhsd/878BSvrmJQHopcMTRLvAM4hTVNYoRH2Th5MTvhlRhY/oNOWWcYbkvif/8AabZVThOU7a09cEo/4PRbo2MgJtkGJawXpeYM4Re4Dmey7RPzKOhR6g7bT2B20so8NRSvcWcSt0rMgPZXlImWkTAHVsNcS0FNtV0X6RPNZJUM7W78oMnqqXTWlgGN20dieWP45pOwRyQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDEAA1D565C8664E9497B089BEE93EA2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8a11fa-d02a-4b07-80b0-08d8872ba559
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 16:54:39.7776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLGOSg3fTwTqx8gWN6O/PtO0VWYQKZXyyixfDHaHMCY8H55aTM4FMorkv/mBEb1qTyaWWAL3BtjjRUF+0CGurQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2637
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTEyIGF0IDE3OjM0ICswMjAwLCBHdXkgS2VyZW4gd3JvdGU6DQo+IGp1
c3QgYSBnZW5lcmFsIHF1ZXN0aW9uOiBzaW5jZSB0aGUgY2FjaGUgc2VlbXMgdG8gY2F1c2UgbWFu
eSBwcm9ibGVtcw0KPiB3aGVuIGRlYWxpbmcgd2l0aCB2ZXJ5IGxhcmdlIGRpcmVjdG9yaWVzLCBh
bmQgc2luY2UgYWxsIHNvbHV0aW9ucw0KPiBwcm9wb3NlZCB1bnRpbCBub3cgZG9uJ3Qgc2VlbSB0
byBmdWxseSBzb2x2ZSB0aG9zZSBwcm9ibGVtcywgd29uJ3QgYW4NCj4gYXBwcm9hY2ggc3VjaCBh
cyAiaWYgdGhlIGRpcmVjdG9yeSBlbnRyaWVzIGNvdW50IGV4Y2VlZGVkIFggLSBzdG9wDQo+IHVz
aW5nIHRoZSBjYWNoZSBjb21wbGV0ZWx5IiAtIHdoZXJlIFggaXMgcHJvcG9ydGlvbmFsIHRvIHRo
ZSBzaXplIG9mDQo+IHRoZSBkaXJlY3RvcnkgZW50cmllcyBjYWNoZSBzaXplIGxpbWl0IC0gbWFr
ZSB0aGUgY29kZSBzaW1wbGVyLCBhbmQNCj4gbGVzcyBwcm9uZSB0byBidWdzIG9mIHRoaXMgc29y
dD8NCj4gDQo+IGkgKnRoaW5rKiB3ZSBjYW4gdW5kZXJzdGFuZCB0aGF0IGZvciBhIGRpcmVjdG9y
eSB3aXRoIG1pbGxpb25zIG9mDQo+IGZpbGVzLCB3ZSdsbCBub3QgaGF2ZSBlZmZpY2llbnQgY2Fj
aGluZyBvbiB0aGUgY2xpZW50IHNpZGUsIHdoaWxlDQo+IGxpbWl0aW5nIG91cnNlbHZlcyB0byBy
ZWFzb25hYmxlIFJBTSBjb25zdW1wdGlvbj8NCj4gDQoNCkFnYWluLCBJIGRpc2FncmVlLg0KDQpJ
ZiB5b3UgaGF2ZSBhIG1vc3RseS1yZWFkIGRpcmVjdG9yeSB3aXRoIG1pbGxpb25zIG9mIGZpbGVz
IChlLmcuIGRhdGENCnBvb2wpIGFuZCBsb3RzIG9mIHByb2Nlc3NlcyBzZWFyY2hpbmcsIHRoZW4g
Y2FjaGluZyBpcyBib3RoIHVzZWZ1bCBhbmQNCmFwcHJvcHJpYXRlLg0KDQo+IA0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
