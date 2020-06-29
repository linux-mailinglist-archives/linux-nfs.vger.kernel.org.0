Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5CB20E217
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2020 00:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgF2VCV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 17:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731159AbgF2TMt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:12:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20712.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9807DC00E3E7;
        Mon, 29 Jun 2020 05:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATiYEWM4Ifv8TQnx32YIF3DA5p68sLW4PFd22rOBXSm1uNx9qfBhUNRtgqqYhpKMJgbMlApC8wGCMkl9g3t3QAvQAHRmyrrQHC8WlSYsE/oFY+oxTWSk8/hdloWCWG9kxKCZ0oxhFPD/f8GDiyTNUd5Vu7l0nlbC6LJnFsdTkpP89p7uCvF8ZklTyQBcV6epJ8fiHocjC7/jvkclOEBKVtSXVf6fKeDZdqNOt4G2wlXd1o3O2aIUfJkl8+lMTFNMUjuBJ6U+zF2KqY+OQ9xG4OhElpJXDBY6AU/X2Xv51AAsZPF6T9wHG4oGIXmDL+WuGWEWXPQUaTz1kB8z07Dgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsd/9fH2anl4Y2kLa/4kvAT5eqK5ND/aUflQkvjz1Fk=;
 b=igyDPFkfKzUIAs2pjYYOo0rOy4X21PnIudR4xy63IHmb6YkmqYLVwzsdLoerBq2xKtWvZ2CrY648wcEqOI2d6TKpWyXeBA6FY5aVssIj5/O0+8lbb78t7C8AX+p1W3pV3GYJ0qx5sOUugniaQLalqH+sPc18hGN0NbikxY6X9uN4B+lP5VhV7hdQT26K+6F+sNJhjwt4kT7TkTbW/Gt0a05bU9wYTDlsdbGV+oMqUPwi30tTaaz9dSqBfkYPUifXu44TBq088p4U3/7GlLQfXvflyMd6Ry8sO8LDnJctmZv1QdS+Aj47TpILJwfy/TXcY0N09/c2P1J2gi6/8lV6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsd/9fH2anl4Y2kLa/4kvAT5eqK5ND/aUflQkvjz1Fk=;
 b=YN8Ir6b6e0+uqLMMPr5IbAcBqKGMkOxPKm1z0Jt937SesMKUf4puRTV/Lgp306v9HyJq85m7P9PNiqB162tAbi61mGCM0JhVD1xAdNiF2F3joEvot4443zuHl6jVle2IkN4/MFwPmzDvOs2mWxKdbRCFw4iDVtsshn/DnT+wTKo=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3543.namprd13.prod.outlook.com (2603:10b6:610:2b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.12; Mon, 29 Jun
 2020 12:04:55 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3153.018; Mon, 29 Jun 2020
 12:04:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "vulab@iscas.ac.cn" <vulab@iscas.ac.cn>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs: pnfs: use GFP_ATOMIC under spin lock
Thread-Topic: [PATCH] nfs: pnfs: use GFP_ATOMIC under spin lock
Thread-Index: AQHWTd2j66k5+xY2aUuF/vWISHiIt6jvf0QA
Date:   Mon, 29 Jun 2020 12:04:55 +0000
Message-ID: <fd936b8622a9838070c58bc66e353f90e69347b1.camel@hammerspace.com>
References: <20200629062139.10364-1-vulab@iscas.ac.cn>
In-Reply-To: <20200629062139.10364-1-vulab@iscas.ac.cn>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: iscas.ac.cn; dkim=none (message not signed)
 header.d=none;iscas.ac.cn; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12cc2fe5-d74b-4d53-8871-08d81c24a35f
x-ms-traffictypediagnostic: CH2PR13MB3543:
x-microsoft-antispam-prvs: <CH2PR13MB3543C26C629DE023ED36B191B86E0@CH2PR13MB3543.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUxWom9ZDg03ILYpHaOH7byITZhUFRdkVqWsQsnBCLr7ceTND4kZ628JQYf73Yk+UZfiKcTYmD7OJT7si87VO+40/jIEQ/kPvQxAwwdA+Vm3rD/ywxcUKrD4kVzayGZYx9SioT2WwX3J5ekHStATrK+lhAS8/PtQ8bFq9xrm1zuhMM+UQGBXvobF4Rko4Fe4E3CcS/LFIdSFAhWqlpx42uXvFESVLKLomrOaSlLPyCeNZufYNpKkvVMyvYYzZwEi7aNptwGJEABoPDyiMyFg/nriIvXOKhGTH9YYcXTb8oAZOI9ok2eraj4ZqzRY0GNG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(39830400003)(136003)(366004)(478600001)(26005)(71200400001)(83380400001)(36756003)(316002)(86362001)(6512007)(66446008)(64756008)(4744005)(6506007)(2906002)(66556008)(76116006)(66946007)(4326008)(6486002)(2616005)(66476007)(8676002)(186003)(8936002)(5660300002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ztvglnoef5ogOTnCPwoYvG1NqDy133tToOXdhrfWWoOxX9E+vV4teW81ms/EgZK4rmIR9tuJVyiU8ljYh9Qle+8NcQKIRMFeOla5Gv8p+zoqLCl5BnJRHCxxJ+Pl28psAvx4UlynhXmREqu9bdsMFc+xILjhD8BkC9YIN1YXXPeBi44j+tV4LzoPvaTZ4JPwa7lp4FPxg+2iNIn4MXNrZd83CA2SQCfwAt+FODxug6kZwvXMLYKw3LtYWvOhUxRLEgUEcvW+l1VS5m6TIK/ymewm1fOQ/1UQZIraxmtye5842vGBh1Xe/3blHy3Iw1/NqhUUWvbj0eV5ETHEJehRXJv5rCN620jwoxkzpTvPDRtU+3YhZK/RBp1jioT35KZHl3W5vFumrMzTadHtZ/fBAATw9O1nq2vKOUVGjGbhjCUyqDy/CZbs8q1ynFqpV6MPz71YngdOf6OmXHset72KMmq6kwcWf9OSTxJ2U1/sPrg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC34BB2EEF84DB4880CC367B191FDDD3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cc2fe5-d74b-4d53-8871-08d81c24a35f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 12:04:55.7243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZH2PBOkuKnxKEJ9BTRbji5AKDVjE1YEuVDtr8ZqvMLomarI6ILRo47N14QwnYrEIrf3FUkFqCegb9m9Xg2Y5kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3543
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDE0OjIxICswODAwLCBYdSBXYW5nIHdyb3RlOg0KPiBBIHNw
aW4gbG9jayBpcyB0YWtlbiBoZXJlIHNvIHdlIHNob3VsZCB1c2UgR0ZQX0FUT01JQy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFh1IFdhbmcgPHZ1bGFiQGlzY2FzLmFjLmNuPg0KPiAtLS0NCj4gIGZz
L25mcy9wbmZzLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvcG5mcy5jIGIvZnMvbmZzL3Bu
ZnMuYw0KPiBpbmRleCBkZDJlMTRmNTg3NWQuLmQ4NGMxYjdiNzFkMiAxMDA2NDQNCj4gLS0tIGEv
ZnMvbmZzL3BuZnMuYw0KPiArKysgYi9mcy9uZnMvcG5mcy5jDQo+IEBAIC0yMTcwLDcgKzIxNzAs
NyBAQCBfcG5mc19ncmFiX2VtcHR5X2xheW91dChzdHJ1Y3QgaW5vZGUgKmlubywNCj4gc3RydWN0
IG5mc19vcGVuX2NvbnRleHQgKmN0eCkNCj4gIAlzdHJ1Y3QgcG5mc19sYXlvdXRfaGRyICpsbzsN
Cj4gIA0KPiAgCXNwaW5fbG9jaygmaW5vLT5pX2xvY2spOw0KPiAtCWxvID0gcG5mc19maW5kX2Fs
bG9jX2xheW91dChpbm8sIGN0eCwgR0ZQX0tFUk5FTCk7DQo+ICsJbG8gPSBwbmZzX2ZpbmRfYWxs
b2NfbGF5b3V0KGlubywgY3R4LCBHRlBfQVRPTUlDKTsNCj4gIAlpZiAoIWxvKQ0KPiAgCQlnb3Rv
IG91dF91bmxvY2s7DQo+ICAJaWYgKCF0ZXN0X2JpdChORlNfTEFZT1VUX0lOVkFMSURfU1RJRCwg
JmxvLT5wbGhfZmxhZ3MpKQ0KDQpOQUNLLiBQbGVhc2UgcmVhZCB0aGUgY29kZSBiZWZvcmUgc2Vu
ZGluZyB5ZXQgYW5vdGhlciBvbmUgb2YgdGhlc2UNCnBvaW50bGVzcyBwYXRjaGVzLg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
