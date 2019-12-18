Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E27D125142
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 20:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLRTF3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 14:05:29 -0500
Received: from mail-eopbgr680094.outbound.protection.outlook.com ([40.107.68.94]:33251
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727391AbfLRTF3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Dec 2019 14:05:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHDfmVkNN4HXSUvRI2fkgXu3DLP+CqUNd/AMxg3/XjE+8iuYYUlm3OuXX1v8v+gJviIMiR3beI/tBdAidADQdIlLHB3939lUYPePL4llYJ8UubY94yDbc/fKgRYwjyZ9VKa0CSCmaiZtuSLTXuQIxX44d+KG5+KC6H32ySu2WHHB3mZTcap04yZ8+P+PuZMyGy9P1YwL2XS9IT+BkP+jrPImJwpMpDLDTfaS22JCLBjrpBVP4rVek9i/0BltFm9kzbEoRFs0aIj4nIZj0Agn38XAd38uWfYhTuK9tm6KmZNyiECabzgD/iPGhRxC080R5kxGNwk/LygSgxt4WFNchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Lk2t2Nmk7SN46gBK9e9G9LHs2h/tuCayYDpZrr/xeI=;
 b=A0Bso/j+Ks0xCL1Puj7WEraycv/SXonu+w2Ho5mlgIZh+LQzX5LEK0KApM+CHPFrKprl90oSG7wgu4xH3VaDyrXSgx95Jj2TZAg+jD6WhEBHFDLLNhDppkttfYiYYmmp5dLBw4I8Mx/EGyeMvyrHeLlq6p3QMr6d0DoyhmxUD8qity5tpRiRhlHl4EDg/uQuxiB1oV+RxODGsAU9Ab0cYkbtD7HAUwII/dlWyNGW88cj1kuVEHFE/cF5LHhzHiD1ggJxEj3JdnfinBMHymW/Kk2ldp1Yuw7nce8CWpZCCOfTnzYpKpeUE/osfg2xDCva0QVEO0EY42yhnQ86u2BueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Lk2t2Nmk7SN46gBK9e9G9LHs2h/tuCayYDpZrr/xeI=;
 b=ZfAsGLzXec5oRd3Vmi/2Ep+DBgCL+rnoL8oVJ2BcesT6SOjW9oRJcxzkCI0zFh3iMqAXvwnHhXgyQbfyb7shDMyAG/Xx0L9dHJLit1D7+BtXiMdo26i4mUpe3trTukrjDET/gSL3meKo/8a4sx4fIy8Gqg8wNa6794cur2vrdYk=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2041.namprd13.prod.outlook.com (10.174.185.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Wed, 18 Dec 2019 19:05:24 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 19:05:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: acls+kerberos (limitation)
Thread-Topic: acls+kerberos (limitation)
Thread-Index: AQHVtcs3TpSTmrgSq0KGQIdkoW6kVKfAQJsA
Date:   Wed, 18 Dec 2019 19:05:24 +0000
Message-ID: <f4595e80487d9ace332e2ae69bc0c539a5c029bb.camel@hammerspace.com>
References: <CAN-5tyHJLh8+htpb47Uz+ojo5EfrpP=zyE-Vfk=HjvBgK591=g@mail.gmail.com>
In-Reply-To: <CAN-5tyHJLh8+htpb47Uz+ojo5EfrpP=zyE-Vfk=HjvBgK591=g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bad8746-1425-4145-b656-08d783ed3ca0
x-ms-traffictypediagnostic: DM5PR1301MB2041:
x-microsoft-antispam-prvs: <DM5PR1301MB204167F3D4E7303B342B363CB8530@DM5PR1301MB2041.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39830400003)(189003)(199004)(316002)(110136005)(8936002)(86362001)(8676002)(81156014)(71200400001)(508600001)(4001150100001)(66556008)(64756008)(66446008)(2906002)(66476007)(6506007)(6486002)(81166006)(76116006)(91956017)(2616005)(26005)(36756003)(186003)(5660300002)(66946007)(4744005)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2041;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nwVM67sbce+ch4eJjxfed2hVxUMY9BPFTJPlyo8vz3QMOY4h6Wr7Hf+qZxW2cTbN6t6DhMGYuCwZhGV3b1D4YE7V6EAiApEM20CMhRPy0Se3V7tuol8X2iDOvirO5PIf4WbCg58qMJDsRyAtFOhauOpXeRGd94Szf+NYBZG5cFElY8l/N8b7W0LuXix0dockGJFC8EyIghpysaaS0DXCeVscW+Au/AbqkZNynMXr8ohyxhLFPOUBpUJSBSpDVAXiOt8H6cKq9PPCRjuaq0nKrWysxD7NCD+9f7u3pqp+ViYnNL0ksZKf+JFVkGYc610d7jzvqbtoD8F4N2I3oqpNjSwKGW7Z20st7cFWkGSkXuXb2+1IeOjJJ56vEvwMMsAh91nb4I6RasgHSOfdwA40F/O68wR+VDTBQKwMQNJl5jkU36c8lnfc95piKuJTkU8l
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D68E92F05703F446B94025D7B5A53BA7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bad8746-1425-4145-b656-08d783ed3ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 19:05:24.2728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1L4BCSmPpaOGXABlaJolbihwTMRUkCloeEvaSwc9Idq4e0N5K5/Rik6T1v23dczYtC6ZKMtBUboG/4XUPhH2Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2041
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTE4IGF0IDEyOjQ3IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gSGkgZm9sa3MsDQo+IA0KPiBJcyB0aGlzIGEgd2VsbCBrbm93IGJ1dCB1bmRvY3VtZW50
ZWQgZmFjdCB0aGF0IHlvdSBjYW4ndCBzZXQgbGFyZ2UNCj4gYW1vdW50IG9mIGFjbHMgKG92ZXIg
NDA5NmJ5dGVzLCB+OTBhY2xzKSB3aGlsZSBtb3VudGVkIHVzaW5nDQo+IGtyYjVpL2tyYjVwPyBU
aGF0IGlmIHlvdSB3YW50IHRvIGdldC9zZXQgbGFyZ2UgYWNscywgaXQgbXVzdCBiZSBkb25lDQo+
IG92ZXIgYXV0aF9zeXMva3JiNT8NCj4gDQoNCkl0J3MgY2VydGFpbmx5IG5vdCBzb21ldGhpbmcg
dGhhdCBJIHdhcyBhd2FyZSBvZi4gRG8geW91IHNlZSB3aGVyZSB0aGF0DQpsaW1pdGF0aW9uIGlz
IGNvbWluZyBmcm9tPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
