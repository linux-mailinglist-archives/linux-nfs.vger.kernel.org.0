Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482DE3EF083
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Aug 2021 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhHQQ6Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Aug 2021 12:58:24 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:19552
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229716AbhHQQ6X (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Aug 2021 12:58:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdrOoWFTx9K9WbeifRAbNRHehqzTTeAvmK/obQ1wAQPsdb0Kdt8XYfHmJJ5YzlhJqLPhejUMbU67AtOMy9AIi8FJ4ic510tSDgKQWpluycOqARgIbid3fxhxj1ePPQeSwDQOkzGxhOZ5qzrBgEZ/f9Ar90ItXCP4i4P/emAiyutUMWtvRsUV0v/WZcX6bqmglwnCacjBqYcbbaVBBYiTsDfJbOc0IEq4/QO4xCRA6lkZud4uYocnRO+u/mMiVCz4vhq4bE/a+nNOQWkyFgaZC7vqxzg/tFwtXBFX48lJuymJSRiUELujlyU78yTezZNorSVIy/7/yZb+Q8tbSMz1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObOUQBZpMwojTg0oTl/ImYPlXnUCoesvAf07NL/STVc=;
 b=ikrZpwT17gWrmci3uet6yMrj0gDIBUXaFEnGtYdzpAjF7mu2n3RMXx3ZJEXn9BA6qCbhgEE79Bg/5SJIwPiYkTL31BhBj8gnh+c6fJ+9TIyaT31lW8D+0zDosH/4VIF6IUa4SMIQQaDeSmKWfgVv2hmFhLX2y3Ll09Ovflw57y9n1Sv4O9mJnRPX17Oh1h/g5vuzAQGvKW9RW2siR0V6JBl2DXv1xninUpCe2rDWXdGvZtWocw6mZpTaFiG8kVu1A885TT+qoNBfwTF7/o3dZOs++EQALPpGxHNER29fyEo3/aQNe6BH9tYKhycp42DIaVSIWUn9rme0hT93XU6+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObOUQBZpMwojTg0oTl/ImYPlXnUCoesvAf07NL/STVc=;
 b=mr1F8RnaolcW+hRpQOrDZF7SnAw2hjMCzohT6ulDRvjHhF1hgUHXhWpfY11O2aMgbTkelSDnkOvIrq/E+JM9JG7tORSkF8TxU8OJQsu8k/U+bQ6UC1ECF+YjxTKzatnP/dPvmUH1RhDPPmNUbZRqOuBUT6n8iyu0jHFi4lVimAcj0070nZ6uSe/FzQt7/mJ0kZNXnC9BPAHY8gzSHFkLeYSpHWBQVE9JGCAh86Pjyhgxgqko64YHwODGZ3YjaPPbQ8V4VkY3vYo4GoenS9LHeBEKQ1F45rqwOj3KSUVHXh6Lz30s7nPF3vhT6SG1O1zFvYKa+TDIq15BWS4T+ifmvw==
Received: from BYAPR06MB4296.namprd06.prod.outlook.com (2603:10b6:a03:10::20)
 by BYAPR06MB5159.namprd06.prod.outlook.com (2603:10b6:a03:c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 16:57:46 +0000
Received: from BYAPR06MB4296.namprd06.prod.outlook.com
 ([fe80::7d63:de76:f951:c981]) by BYAPR06MB4296.namprd06.prod.outlook.com
 ([fe80::7d63:de76:f951:c981%2]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 16:57:46 +0000
From:   "Mora, Jorge" <Jorge.Mora@netapp.com>
To:     "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        steved <steved@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH v2 1/9] nfs-sysfs: Add an nfs-sysfs.py tool
Thread-Topic: [PATCH v2 1/9] nfs-sysfs: Add an nfs-sysfs.py tool
Thread-Index: AQHXiwAhKJa26OojD0iFxLT6srOhtat3l2qA
Date:   Tue, 17 Aug 2021 16:57:46 +0000
Message-ID: <279C2380-566E-4FBD-9C76-0E678A22A31F@netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
 <20210806201739.472806-2-Anna.Schumaker@Netapp.com>
In-Reply-To: <20210806201739.472806-2-Anna.Schumaker@Netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.52.21080801
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a05f0fa-0534-45f6-abbc-08d961a02364
x-ms-traffictypediagnostic: BYAPR06MB5159:
x-ld-processed: 4b0911a0-929b-4715-944b-c03745165b3a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR06MB515981319D8AD2422F1F88ABE1FE9@BYAPR06MB5159.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dUnwkYrGRQKmK25pMtBVUC7Xh9MM3fDmNkXhg+mFYz+fF4Woeae9aVTstrriphGDiDXOIpr7td4qYYPK/s1NpXlQ35h/Lgp0NibfMyaPuOTo3gXDX/JDlEweVoVZnVQm5TvzMWmkZXdzDSUeYbi+RhQn8B2Khx7MOCeHThDfnonPev5zA7ra0Bs3OrtlhKwnZ9s4yiGIjidLgpGsdXs9xqhWvrAk3gz9Y4EUl8JEp0M1NiR11vFJ+NAB9HQkjpBnYj7MsEN5A9fbWtYXtf91oLv8OHgvCLshUvYB+2vyD2zlbVVz4qFy5WB9oaiUxqKDVVWTx1vQzr0xD8jueZa3JaWddaDlWVra6fDS7Ppz8lmOjA6mlmaH9SJmSW9YiXZqCrjO9VQg41e/G15uRezbVB3x/zQ2B2VArYVrEsBLR7fIQ22OuwZOiQHdDNFF+meMhNIcocafXr6cmnlmxTHVDJF/tDTI/0vYncS2LKm6tUlJdcBr4NWw4llWy+7stMC26nmuhawrZ3UupGkvedGhSd+WGjzfmPRJ9Q9/bPZJWH21vVM7NY/zmYiWl3a9BJuogCl+QeiS8to7dLJ4/GgO1sSSkX/ffhDDdN7t9E5tpLIHLsNCYXgMjr2ZFX613Gz2C1FKEXvPzvptKKrJhLiPHIHLTugyjbp0NNYZbwx0XYf5pfDCdAUgtoM4NohK0N8xd7w8YI4t7UWSebi64oxpMV4WrwCJt0zP2o09gxi16nP3e9ECT5nC6mMr/rBbUH/t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4296.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(8676002)(2616005)(316002)(33656002)(8936002)(6506007)(478600001)(38070700005)(26005)(110136005)(5660300002)(36756003)(71200400001)(6486002)(66446008)(122000001)(83380400001)(6512007)(64756008)(91956017)(38100700002)(4326008)(186003)(2906002)(76116006)(107886003)(66476007)(86362001)(66556008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGRaNGRyRUszWXI3clF3RVFrbVNjbDRONSt2MVBwL0c0b3VWZ2FtN2RiZjNZ?=
 =?utf-8?B?UXBtdm9OWXFtbUoycG5Yb0c2dGR1ejl5UW9zYUNtcmp4NkE0azBnSnB5VEV3?=
 =?utf-8?B?ckxtYlFvaDloMGdpeDdlZmcyRTBPMTc4MXN5OE9tRFdPd2FJRis0ZUlQdlNx?=
 =?utf-8?B?d3Y0djBxd3hOK1BsUVZLM3F0bHhiRkRBd04zemE3N09OM1RuNDJtc3dRZ3Bn?=
 =?utf-8?B?VVA2OWZ0cHRKcFkvV29Jbnl1TEtnRzU5Y29nSWRFSlA3RFo1UFZUOG1xL25v?=
 =?utf-8?B?dERtOXV3OGZkNXBrSHpiVjhKMEJPVHJVZEQwN3AvTWhkVDkvUUY0SlJwWXR1?=
 =?utf-8?B?N0NnczRaam9MZ2dhZkdZdDdFZ0xPaGl6UFZURSsvV3hEcUhLbFBMYWtPdW1O?=
 =?utf-8?B?SkJuaStmREV6VTMyQjRUVkM5VGp3bzE1cGVHb25FMlA0U01wWjgrRGZ6TXlU?=
 =?utf-8?B?bjNjcFQ5RjhjSzRGYUp6MmRteE5LZWlqSU5nZWxyYXRva2c2Nmd5OFFPZE5Q?=
 =?utf-8?B?QlpvUHZHOHVRUk43SmxBV0Y5VE5DaHhucUd6VFlxK1AvZXdXTFRkd3dyUGRC?=
 =?utf-8?B?Q0ltRkFqQk5rVW54ci9HVXQ1ZlV3d3BIVnNuekQveHBkc2d1UUhDdEpTdGhu?=
 =?utf-8?B?bTJoelkvejZWQ0F3NUU2eVYwZ20zU0hodlBVc1Z0UHVtYVVPV0pLcUlMOFBx?=
 =?utf-8?B?cEtpa3hmcG5RZW5BYzNZZ2QvZkFsMm9BYzlDQ0dZZE1MWmxveTZsOFlBbWVL?=
 =?utf-8?B?VlIvMzg2UU5ZTnQyTkFCK3pHa29wOE9kM3pTSHRWZ1VpOG54TFQvWEZHZ0pH?=
 =?utf-8?B?RU1PR0JsRDhwRU1WNUJ2SXdRUHd1Y2tXd2NYZkFQWlNTMjZna1YwSUdGaGxn?=
 =?utf-8?B?OUp4QW1wMU1GR2tuRmIvQ25UN29NTXdjaVZLdGZpMFY1aTBYeEFzcXN2cGFk?=
 =?utf-8?B?MGR1VnhyS1VxNXNhVTVuUk9FUktHZXlTNEw4K3l6a0tRTzZwN2VEelZQT1NO?=
 =?utf-8?B?WVN4SVk0L041S2FwRVlvM2thbTVvdEh4YUtpb2pOYlVFM3ZveERkNWxNQmtE?=
 =?utf-8?B?S3RiZHR2NElCQXNiRzNhQS9HZ1FRUGJUblFVcFN5U01QWG9mT25LeGp0ZmxR?=
 =?utf-8?B?SFVlS2VGYno3UFFkS1NVSG52S3pmMXo2cW8xTkRrb1RUY3A2aHBsbUtqandN?=
 =?utf-8?B?dFJHblhqbWU5S1BoRTA3QXM1TG1rRngxNHBYMnlCbWVwRE9temx0Y3RmbzZR?=
 =?utf-8?B?NFE4dzkyaGtWVGgyQjY1bGZNanhiODdPOGorRVhRcFFYK1FDalkxc1BKR0V2?=
 =?utf-8?B?UllxTGJtV2tIdTZRbXlRbGk5QXZCWnQ4VmpYZ1h5cTZaWTdXenpkWmFrN0Fn?=
 =?utf-8?B?a0I2U0FMV251SUFyNGdicUxHanRqRUR0ZVprc01QS3BGbGk5WU5PdjVqTTFH?=
 =?utf-8?B?Y3NJM3didTBxRGRiNTFWNVRvNE00VHdyU1ZuVTNtd2t0bTM1MWVXOVpSSE0z?=
 =?utf-8?B?SzZ4NW9saFkwdDFGRUJjR0pHaWFxOHV0TWxSenY2dDE1eDB5VWt3QU40TFhN?=
 =?utf-8?B?RWJnYUtOQnVUOXhuL3Z2QXp3NkVpN1ZkaTRDWEh5N2IxMzI1U0RXQVBXR21R?=
 =?utf-8?B?bzNoVFB1b1owVE5hMFJ1aWRES2ErV3RmcFBoa2hCUlZjK2c0Ym9Mc1J3MFNk?=
 =?utf-8?B?M2tmS2owUjRSdE9OYXMwdHUwWXd2RkdoZG1YcGVOcjZvZy9XaUd1eVk3UmxV?=
 =?utf-8?Q?QU6n++W5SD5fgSyEkpl0jfIael4ndc2mXOKVAnW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B05169DCD56B147BD56883A6006FB84@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4296.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a05f0fa-0534-45f6-abbc-08d961a02364
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 16:57:46.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I18aFo0O+wScTlbCAcbcV8fQ71VvhpnlO9rGrHs3ivGwKTPd/OEiyjVVYvr6KZzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5159
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGVsbG8gQW5uYSwNCg0KQ29tbWVudHMgYXJlIGlubGluZS4NCg0KLS1Kb3JnZQ0KDQrvu79PbiA4
LzYvMjEsIDI6MTcgUE0sICJBbm5hIFNjaHVtYWtlciBvbiBiZWhhbGYgb2Ygc2NodW1ha2VyLmFu
bmFAZ21haWwuY29tIiA8c2NodW1ha2VyYW5uYUBnbWFpbC5jb20gb24gYmVoYWxmIG9mIHNjaHVt
YWtlci5hbm5hQGdtYWlsLmNvbT4gd3JvdGU6DQoNCiAgICBOZXRBcHAgU2VjdXJpdHkgV0FSTklO
RzogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLg0KDQoNCg0KDQogICAgRnJvbTogQW5uYSBTY2h1bWFrZXIgPEFubmEu
U2NodW1ha2VyQE5ldGFwcC5jb20+DQoNCiAgICBUaGlzIHdpbGwgYmUgdXNlZCB0byBwcmludCBh
bmQgbWFuaXB1bGF0ZSB0aGUgc3VucnBjIHN5c2ZzIGRpcmVjdG9yeQ0KICAgIGZpbGVzLiBSdW5u
aW5nIHdpdGhvdXQgYXJndW1lbnRzIHByaW50cyBib3RoIHVzYWdlIGluZm9ybWF0aW9uIGFuZCB0
aGUNCiAgICBsb2NhdGlvbiBvZiB0aGUgc3VucnBjIHN5c2ZzIGRpcmVjdG9yeS4NCg0KICAgIFNp
Z25lZC1vZmYtYnk6IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAuY29tPg0K
ICAgIC0tLQ0KICAgICAuZ2l0aWdub3JlICAgICAgICAgICAgICAgICAgIHwgIDIgKysNCiAgICAg
dG9vbHMvbmZzLXN5c2ZzL25mcy1zeXNmcy5weSB8IDEzICsrKysrKysrKysrKysNCiAgICAgdG9v
bHMvbmZzLXN5c2ZzL3N5c2ZzLnB5ICAgICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KICAgICAz
IGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCiAgICAgY3JlYXRlIG1vZGUgMTAwNzU1
IHRvb2xzL25mcy1zeXNmcy9uZnMtc3lzZnMucHkNCiAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRv
b2xzL25mcy1zeXNmcy9zeXNmcy5weQ0KDQogICAgZGlmZiAtLWdpdCBhLy5naXRpZ25vcmUgYi8u
Z2l0aWdub3JlDQogICAgaW5kZXggYzg5ZDFjZDI1ODNkLi5hNDc2YmQyMGJjM2IgMTAwNjQ0DQog
ICAgLS0tIGEvLmdpdGlnbm9yZQ0KICAgICsrKyBiLy5naXRpZ25vcmUNCiAgICBAQCAtODQsMyAr
ODQsNSBAQCBzeXN0ZW1kL3JwYy1nc3NkLnNlcnZpY2UNCiAgICAgY3Njb3BlLioNCiAgICAgIyBn
ZW5lcmljIGVkaXRvciBiYWNrdXAgZXQgYWwNCiAgICAgKn4NCiAgICArIyBweXRob24gYnl0ZWNv
ZGUNCiAgICArX19weWNhY2hlX18NCiAgICBkaWZmIC0tZ2l0IGEvdG9vbHMvbmZzLXN5c2ZzL25m
cy1zeXNmcy5weSBiL3Rvb2xzL25mcy1zeXNmcy9uZnMtc3lzZnMucHkNCiAgICBuZXcgZmlsZSBt
b2RlIDEwMDc1NQ0KICAgIGluZGV4IDAwMDAwMDAwMDAwMC4uOGZmNTllYTllODFiDQogICAgLS0t
IC9kZXYvbnVsbA0KICAgICsrKyBiL3Rvb2xzL25mcy1zeXNmcy9uZnMtc3lzZnMucHkNCiAgICBA
QCAtMCwwICsxLDEzIEBADQogICAgKyMhL3Vzci9iaW4vcHl0aG9uDQogICAgK2ltcG9ydCBhcmdw
YXJzZQ0KICAgICtpbXBvcnQgc3lzZnMNCiAgICArDQogICAgK3BhcnNlciA9IGFyZ3BhcnNlLkFy
Z3VtZW50UGFyc2VyKCkNCiAgICArDQogICAgK2RlZiBzaG93X3NtYWxsX2hlbHAoYXJncyk6DQog
ICAgKyAgICBwYXJzZXIucHJpbnRfdXNhZ2UoKQ0KICAgICsgICAgcHJpbnQoInN1bnJwYyBkaXI6
Iiwgc3lzZnMuU1VOUlBDKQ0KICAgICtwYXJzZXIuc2V0X2RlZmF1bHRzKGZ1bmM9c2hvd19zbWFs
bF9oZWxwKQ0KICAgICsNCiAgICArYXJncyA9IHBhcnNlci5wYXJzZV9hcmdzKCkNCiAgICArYXJn
cy5mdW5jKGFyZ3MpDQogICAgZGlmZiAtLWdpdCBhL3Rvb2xzL25mcy1zeXNmcy9zeXNmcy5weSBi
L3Rvb2xzL25mcy1zeXNmcy9zeXNmcy5weQ0KICAgIG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQogICAg
aW5kZXggMDAwMDAwMDAwMDAwLi4wYjM1OGY1N2JiMjgNCiAgICAtLS0gL2Rldi9udWxsDQogICAg
KysrIGIvdG9vbHMvbmZzLXN5c2ZzL3N5c2ZzLnB5DQogICAgQEAgLTAsMCArMSwxOCBAQA0KICAg
ICtpbXBvcnQgcGF0aGxpYg0KICAgICtpbXBvcnQgc3lzDQogICAgKw0KICAgICtNT1VOVCA9IE5v
bmUNCiAgICArd2l0aCBvcGVuKCIvcHJvYy9tb3VudHMiLCAncicpIGFzIGY6DQogICAgKyAgICBm
b3IgbGluZSBpbiBmOg0KSk06IFRoZSBmb2xsb3dpbmcgY291bGQgc2VsZWN0IHRoZSB3cm9uZyBt
b3VudCBsaW5lLg0KICAgICsgICAgICAgIGlmICJzeXNmcyIgaW4gbGluZToNCkpNOiBNYXRjaCAi
c3lzZnMiIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGxpbmUgaW5zdGVhZDoNCiAgICAgICAgICAg
ICAgaWYgcmUuc2VhcmNoKHIiXnN5c2ZzXHMiLCBsaW5lKToNCiAgICArICAgICAgICAgICAgTU9V
TlQgPSBsaW5lLnNwbGl0KClbMV0NCiAgICArICAgICAgICAgICAgYnJlYWsNCiAgICArDQpKTTog
VGhlIHByZWZlcnJlZCB3YXkgaXMgdG8gdXNlICJNT1VOVCBpcyBOb25lIiwgYnV0IHRoaXMgaXMg
anVzdCBhIGd1aWRlbGluZSBhbmQgaXQgc2hvdWxkIHdvcmsgZWl0aGVyIHdheS4NCiAgICAraWYg
TU9VTlQgPT0gTm9uZToNCiAgICArICAgIHByaW50KCJFUlJPUjogc3lzZnMgaXMgbm90IG1vdW50
ZWQiKQ0KICAgICsgICAgc3lzLmV4aXQoMSkNCiAgICArDQogICAgK1NVTlJQQyA9IHBhdGhsaWIu
UGF0aChNT1VOVCkgLyAia2VybmVsIiAvICJzdW5ycGMiDQogICAgK2lmIG5vdCBTVU5SUEMuaXNf
ZGlyKCk6DQogICAgKyAgICBwcmludCgiRVJST1I6IHN5c2ZzIGRvZXMgbm90IGhhdmUgc3VucnBj
IGRpcmVjdG9yeSIpDQogICAgKyAgICBzeXMuZXhpdCgxKQ0KICAgIC0tDQogICAgMi4zMi4wDQoN
Cg0K
