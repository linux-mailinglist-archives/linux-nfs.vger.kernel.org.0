Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DC0125286
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 21:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLRUBe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 15:01:34 -0500
Received: from mail-mw2nam12on2125.outbound.protection.outlook.com ([40.107.244.125]:54342
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726831AbfLRUBe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Dec 2019 15:01:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPm0DJFXMW6AD5DQ9fqQqVtpS4ELmjFntILgaqlDpb0rWQubk3aM6FxbPZJ7zWVqWHJbL50GmVxRiphJfmjAJPTCVG4XYi/bzYIt6Pru4QYdn9Qvkm4nopMFzilgfwBdSh5YsvLD/1kaOj4n6f6TX8oW7xOtruvgIPLptvgx5Gww9hVvJwTdBf9tQPprmTPJ+WGHEnL79nwsfIF50K6IYlBR+CfDNSQCcb2qXsUhxw3S2Wsd7z0blJlL+XXVCydCu+Mh6xX2dHnBi4YfGAZQaschAxeqm5iWiNbe5Z8BkpMs0pPjfmvzLvvQ3bpDulb8oCo+2OmQ4wGZyWKMO5lFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6j2GiUOowAo71el86zk6vOSvLJ5i4xRTeYO2PdCwvE=;
 b=R8fL09mGMN0s2Jd0ZjIO4MIhvJxu+joxp988XZZfyQLrSNHBxkoSrPiqdv5ZAffz64+rnhPIil/60UGka8OqwKfuAPuAnjylQDkT/fdy6PEoXeIUB7ViU0rSZb2LT4iff8TXPZyzrll0gzsWGIuQaE20i7fc2nx53tHbjGYKWZor6hk7FCKevVnFwHSoCtDw7TMJHab8Vybn+bX+axjV9i/6ef9xnklAEu64zvSf/qlWuTripXqcv+V9Wov48na+Oh9sgrbTF4igCNaen/YYT9RYN8X54B50EPUACNZINNg1TeOgkAjRRS1hf+DYm2iIfeV2Q9wMYi+n9rZ5kXE0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6j2GiUOowAo71el86zk6vOSvLJ5i4xRTeYO2PdCwvE=;
 b=AbtRP+g3f4J9+WE1UOx+f9tQsjdEV4BPNMHSCgweABWFc9xv3T7bVi9zkh48fWXDoLN8HHD7tFE4Vd+zFCfefko83iRTFsbb6ucBJ4XqhV52I6HCFODbyiwtLtXnfB4bnmNyujCtNhCJXgxJQnkYAqK6dBxIbHL/zOot1qJfZkc=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2123.namprd13.prod.outlook.com (10.174.184.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.11; Wed, 18 Dec 2019 20:01:29 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 20:01:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] nfsd: Clone should commit src file metadata too
Thread-Topic: [PATCH] nfsd: Clone should commit src file metadata too
Thread-Index: AQHVtcov9h/HLhbrC0e09rmsqUQCq6fATNOAgAADdgA=
Date:   Wed, 18 Dec 2019 20:01:29 +0000
Message-ID: <48a93ddf23eb8d377509372775ff506d99f356db.camel@hammerspace.com>
References: <20191218173752.81645-1-trond.myklebust@hammerspace.com>
         <20191218194905.GW19213@dread.disaster.area>
In-Reply-To: <20191218194905.GW19213@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 853dea92-327f-4ae9-f12d-08d783f51291
x-ms-traffictypediagnostic: DM5PR1301MB2123:
x-microsoft-antispam-prvs: <DM5PR1301MB2123265D77AAD45DF3B65B12B8530@DM5PR1301MB2123.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(366004)(376002)(346002)(136003)(199004)(189003)(316002)(508600001)(6506007)(6916009)(2616005)(2906002)(64756008)(54906003)(4001150100001)(86362001)(5660300002)(66946007)(66446008)(66556008)(76116006)(71200400001)(6486002)(8936002)(81156014)(186003)(66476007)(4326008)(4744005)(36756003)(81166006)(8676002)(6512007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2123;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HqxNUfpdgiQFYbIrcpY+1AqogPwWsGqGfFMauFA5cEyYJO2sJLuVYXdkYSP07DctgAWDZRo6iAj/G1slb32UOYWP3aPSpGo7qHLffHNe34LWyTqLJwZ+1xPV3/zXIU8ncfaL+uusLKASYQjXkl1xsYEjneeTt1cthRUJCnj4GXVFgOl3f2C4dJLBFc2NZXLAfQeL4PSw89nk9g1WBTluG+trtE31K3gGes1212sitObhEeE5Uo459469BU3dvNQ2YrQ7SUmMnuCtZrjUnpSTZ+oWYVThnKSH2qW9twkUJmQEDpRHC0UOjUhSQ6ZLc7Xba06/FMcDW0AhvR44ssC6HlZReugUFfZIIHw6DA+JxZfAdwIcZseG30OO/oSIGWmLOBVTxQaYYSmtZ/E8nLpMUmMKCXxVoKEBZT7q9pyYgFCU5MRe0Otnt9V6Jt82vrlB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <21FA3E1652DC0D4987A3BFAF2A4DE9F7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853dea92-327f-4ae9-f12d-08d783f51291
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 20:01:29.7195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkjzmWC3cSofF5EWl4dBg16uSMmRtHr+RVofA7R29oC11ZYjKpUkMnXAJOiiFTeGTqnWzEVHw63VwUlSTCtdug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2123
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTEyLTE5IGF0IDA2OjQ5ICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IA0KPiBJT1dzLCBUaGlzIHdvdWxkIGJlIG11Y2ggbW9yZSBlZmZpY2llbnQgYXM6DQo+IA0KPiAJ
ZnN5bmMoZHN0KQ0KPiAJY29tbWl0X2lub2RlX21ldGFkYXRhKHNyYykNCj4gDQo+IGFzIGl0IHdv
dWxkIGVuZCB1cCBhczoNCj4gDQo+IAl3cml0ZWJhY2sgZGF0YSAoZHN0IGRhdGEpDQo+IAlqb3Vy
bmFsIHdyaXRlKHNyYytkc3QgbWV0YWRhdGEpDQo+IA0KPiBhbmQgdGhlIGNhbGwgdG8gY29tbWl0
X2lub2RlX21ldGFkYXRhKHNyYykgZW5kcyB1cCBiZWluZyBhIG5vLW9wDQo+IHdpdGggYWxtb3N0
IG5vIG92ZXJoZWFkLi4uDQo+IA0KDQpUaGFua3MgRGF2ZSEgRml4ZWQgdXAgaW4gdjIuDQoNCkNo
ZWVycw0KICBUcm9uZA0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
