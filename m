Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842BC67549
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2019 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfGLTJL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Jul 2019 15:09:11 -0400
Received: from mail-eopbgr760130.outbound.protection.outlook.com ([40.107.76.130]:1472
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfGLTJL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Jul 2019 15:09:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtUGrEQGDSGP7X8j3kzybHoPoel7mLLXSr5JFjmAe3ABpWzx6FWsUzDsjVp/kYEzVogJQeeEt63/KOmfw2+nKbAjHtUXf+GKsQFAWb3ubYuQfe4nOWBJjhp1GZoJtKrRK9UcO86rtjW+7NxuLNusrsBnLqS4apRTh3yAMhQTTrrZNmLc+H9eXrYr3VpOe478MxHr7MhgW79fsQ7kcZ5zIQqSs1tw20Mgiwnttx+w0jm7x8jXfCCa3rPZni+OI9UOp2/hovRo34SVVVKDH8OxdE0cMdZkvb8w5UD0s6oSK6yibmXFN0osRrUl2kvI1ZyFV8EkYekhihDZrf1lwP3/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN+00CRLjdYaUGDo2uVEYG62tqTDM9OLIYK4yjEnyho=;
 b=Op9P/5/S3qDlphLM4RDtgivxEDNzmQFuhRFsL8/AI7rWScUmIZFFZHMXVEdQ56r8KA7QxvOKh1VZZjOwSF5rqRVemDn/sCteYV2S4BJ5/aAxciB3Gh35TuZ8uZpzwjAdEmJawBvFEjO+cXXzGmC8wDLme4MxlY4WIGZqkIYwkL/Yed+n7Lbzl8Q8CJ88iPBtfqNU9Nll+S9iEV0KGsFr5XJwCpJqwnMejH8GjWzV0azZgRbFoLgxJSxVlwGejAtohCxXS4yhogo1I5PB5QQiA51MLco9OBaRxg7qcJWEUiIYWKVfc8ewO7xyWmJH/Uu6V1fd0J86wseLwM/utZ1bpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=hammerspace.com;dmarc=pass action=none
 header.from=hammerspace.com;dkim=pass header.d=hammerspace.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN+00CRLjdYaUGDo2uVEYG62tqTDM9OLIYK4yjEnyho=;
 b=SUvKh1lfiZhJRiI2PEXiPoNTy72WWbMo0eMuJo82pkDaZ565hd9/KCrjZhGPuwB3OnkLfEYf+Rp6RMHfRk1X5Es9BRAYUBKZF5OkKrL75NSJdqrk1XqqTQGIEbreeuVkmdLTgx9Z3cxVU5lO0/KaQOjy/jU0L5n5Pmazgh7e5/w=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1051.namprd13.prod.outlook.com (10.168.234.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.7; Fri, 12 Jul 2019 19:09:07 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93%5]) with mapi id 15.20.2094.007; Fri, 12 Jul 2019
 19:09:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.com" <neilb@suse.com>
Subject: Re: multipath patches
Thread-Topic: multipath patches
Thread-Index: AQHVOBvNTX2CipqtKUShUmL2lFq8ZqbFzciAgAAR7YCAAAsPAIABRcuAgAAKzwCAAAxjAIAAEpQA
Date:   Fri, 12 Jul 2019 19:09:07 +0000
Message-ID: <88a507b1974d9a8f9c2afa17f246feab31d6ee09.camel@hammerspace.com>
References: <CAN-5tyF2AL8Bx5QS3HGYzzvjw5vnkfmFxWEmqe_BWfvWCVtDFg@mail.gmail.com>
         <1d019c416f69aa7f3ba7fed3bcfd4c08088fba57.camel@hammerspace.com>
         <CAN-5tyG0jdyn8C11v6b8=v3d1p=WoMAhXrAw8mWGEUn-TVXJ=g@mail.gmail.com>
         <f614be728542c2cb9dd026a5e97b78d4e74a30af.camel@hammerspace.com>
         <CAN-5tyHkdmTJZAYwAcfUy4hYOz=KHgdBeTrYMNYiWQaKp7UrJA@mail.gmail.com>
         <b220fa1ef8b73c99aacb28285af9025d5c7a55fd.camel@hammerspace.com>
         <CAN-5tyEiJUS_HJPCaO+A272f-orQqeRQo-7zF8qMcieZt=410Q@mail.gmail.com>
In-Reply-To: <CAN-5tyEiJUS_HJPCaO+A272f-orQqeRQo-7zF8qMcieZt=410Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 861c27d7-bd4a-4847-37f4-08d706fc6a23
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1051;
x-ms-traffictypediagnostic: DM5PR13MB1051:
x-microsoft-antispam-prvs: <DM5PR13MB105120B723FB27A7390B8BA6B8F20@DM5PR13MB1051.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39830400003)(366004)(199004)(189003)(8936002)(2351001)(66066001)(5660300002)(102836004)(6116002)(53936002)(3846002)(2906002)(76176011)(221733001)(486006)(6506007)(71190400001)(81156014)(4326008)(6436002)(7736002)(5640700003)(71200400001)(558084003)(478600001)(2171002)(305945005)(2501003)(81166006)(3480700005)(6246003)(1730700003)(6486002)(6512007)(8676002)(446003)(316002)(14454004)(68736007)(26005)(11346002)(54906003)(66446008)(66556008)(64756008)(66946007)(25786009)(36756003)(229853002)(2616005)(118296001)(99286004)(256004)(7116003)(186003)(476003)(76116006)(86362001)(6916009)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1051;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Sc/C8/9Z+HbntgFSjDWNYJSkk8nb+szRS3SkUK3LzlEHuGi0zXAUzUPqaEe3BVia5G+oRr2WZ+daU1Xx91oIQHntes/cLLgMCkD+Yr/pJOGvCOEiQMBjOCyfgFRYoLhQXPnkj4H79vMsTU61Kni0RoStHZ7wwEsOB6wf85vdC7SA52uzdo+jw0UZnv7pHKAuq3/n9uc1MWgWiE0D/DI7uQDBmjdWoTR+JSDJ4QwrjqhdASAv9EA9thx0L82ja1Nf2xseOwGc5Q5TEpnOGdZ9+GXvqxQQewBK9CEecyvHCzdGUfNGCxWJBDCgl09nsPwoGj8n0thIMGg8wDeodyBToEfEBhm6TA5/VVO0p7ADlXLtmQ3aSempa/pYI1bkTWCpaPJ2iAKKV1DV+dvEIt32uD2jd6jbIo4cHCKAdvI4Vk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBAFA37387167147A2FE9236888DD2BF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861c27d7-bd4a-4847-37f4-08d706fc6a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 19:09:07.7773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1051
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTEyIGF0IDE0OjAyIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gDQo+IEhpIFRyb25kLA0KPiANCj4gV2l0aCB0aGUgbGF0ZXN0IHBhdGNoIGluIHRoZSB0
ZXN0aW5nIGJyYW5jaCwgSSBjYW4gbW91bnQuDQoNCkV4Y2VsbGVudCEgVGhhbmtzIGZvciB5b3Vy
IHBhdGllbmNlIGFuZCBmb3IgdGVzdGluZy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
