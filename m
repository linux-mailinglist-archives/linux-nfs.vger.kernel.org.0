Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF2D141233
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 21:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgAQUVc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 15:21:32 -0500
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:45411
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727519AbgAQUVc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Jan 2020 15:21:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHa9Abia6rOy7eFc63DrK0kWlsRMscyKbBWFps3cEm3Y7RKz/yUnS4/XYVP81qNMVfHDUHO3OUKpLA38SwXyf94HEMYSKY4itwuU5z9U9EZdQuEyA5OdP723VDEudXDcIuspWmPOx2U4WeMdDGX1mdxfA0myUb3VUl24YFy1VfHdX8XhB5xHDU0rr6T+hMRu14gQVf4AnvCsq+rV+m+77Obp4/nMDzVyQV8zsER5ev+dZ5cYwLbLxcgwzTX7PZ4Q/miJ4uNe5LmfTiArEnjf2tIpiMuTkzbha/9tuBxoQEsHxlxdkFx3xC65ssTMCFa3Z5jcJVp7koctsFQx+brs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9ocQMgzh4Wlvy75izLt1QAGDYZ/sLmuv55AsCLVges=;
 b=VL7gebv1nCJeq4Op8IibH4ZBUZkhsoeVmBw9OM41dpWEkeip6pOy93A8wfKvKIqOj72ZSye6D341AryB3dLMRzXypRzuhBlJQvzOPciRKjSi0AXNpzzhVQDJr6NgJhQpgiYPg5PZjcWzYFLs7ryQmcR0Iw1dXqY7xt2JYJYub06Bu4TaFFHnizAGqdiXf0f8Q/EGmnYYoTzvLbBvHGkKDv/30uc1vIpmcQHLOgBsdsRu8II0xNi7s8tVt7MefjuamF7HhgCz/FkiNCuDLerwf0gweckpAzvwn5PxbYqGPuCUmtKCbODaGtnpPapP2VjWdvOf0idEC8sVtlczv2vcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9ocQMgzh4Wlvy75izLt1QAGDYZ/sLmuv55AsCLVges=;
 b=b6mkgzlfUxVMIvMCq5ri1g5kWl0z/DHcj8TMJ+ZsSddP/ySY7X8+SBxBxdZCvBTt06ENaHLt5EMvycFW+v4szpfnYAjx6zo3zc/6WS+QDfpTzw/m0k0RJEzhJ4geRnS8l5xQVJeVpnPKEF5bXaJjXNadA64tAGoOTuM7YfDRMzI=
Received: from BL0PR06MB4370.namprd06.prod.outlook.com (10.167.241.142) by
 BL0PR06MB4772.namprd06.prod.outlook.com (52.132.0.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Fri, 17 Jan 2020 20:21:30 +0000
Received: from BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1]) by BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1%6]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020
 20:21:30 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] nfs: Return EINVAL rather than ERANGE for mount parse
 errors
Thread-Topic: [PATCH v2] nfs: Return EINVAL rather than ERANGE for mount parse
 errors
Thread-Index: AQHVzU6IaiabJ44BLEKEqBOxHYczS6fvEiGAgAAHmoCAADMOgA==
Date:   Fri, 17 Jan 2020 20:21:29 +0000
Message-ID: <5e16e2118d1c7de73627b521a2f36df76ab0e698.camel@netapp.com>
References: <20200117165133.GA5762@pi3>
         <464519.1579276102@warthog.procyon.org.uk> <20200117144055.GB3215@pi3>
         <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
         <433863.1579270803@warthog.procyon.org.uk>
         <465149.1579276509@warthog.procyon.org.uk>
         <473345.1579281525@warthog.procyon.org.uk>
In-Reply-To: <473345.1579281525@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 124e0e1d-7348-4cb6-2edc-08d79b8ad660
x-ms-traffictypediagnostic: BL0PR06MB4772:
x-microsoft-antispam-prvs: <BL0PR06MB4772DA25F312C85D7B16ABE4F8310@BL0PR06MB4772.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(5660300002)(316002)(6486002)(54906003)(6512007)(2616005)(26005)(186003)(6506007)(558084003)(6916009)(478600001)(4326008)(36756003)(64756008)(81166006)(81156014)(8936002)(8676002)(76116006)(66476007)(66556008)(66446008)(86362001)(71200400001)(91956017)(2906002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR06MB4772;H:BL0PR06MB4370.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ois6fGfRZgnHhcu73w0hX23pJKdCgGxYXqljWvwr3T120nesEWRp5QFh8pbf7SpwA9kC9f3uDPzkWk2PHMMOM7XFWuBIL5s3piX3bMyAGaS3u9S3pOKahKDi0eu9l9JlXxQWnTo+GF2qppKkTYNDvlJCTM3MbaA9M/gORbYliBPwQZB9e7JUAFCWbFTSk7yXQuAt5WAhYOJ6qqpjp09Ttu3worri2Mz/6uB0zCTZIWaWbfzMIe7vgRxGOtATxaJLiBBzgokNnPZEwkpf7BAvn2Vvkb+EMv5Nzk5HiQQrhbI6/t5mbFz4VOtXfYPAVsYBhphsRwr4H7rT62CPcHbMG3a7LChbsx98ziJ8BluLtU/hrHG4Kv3wE9hkeHIL6LXySoA/ONyEBxmu88OPNsm0GLSaLv/85hMFrMoHCH002ZvOpu2JkIs+NY4HXEvUlFW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3EAB88D5DC9FD4799521EAF1AA44B5A@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124e0e1d-7348-4cb6-2edc-08d79b8ad660
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 20:21:29.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkgAkorxEE1pkjo9LAhD9V2jijR+x/SkThjwlt/hhjXoHmr0zKIGY3lBTgOXN0+u+5hukluG90xvza9Ougt2lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4772
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTE3IGF0IDE3OjE4ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBIaSBBbm5hLA0KPiANCj4gQ2FuIHlvdSBwaWNrIHRoaXMgcGF0Y2ggdXAgYW5kIGFkZCBpdCB0
byB5b3VyIGJyYW5jaD8NCg0KU3VyZSEgSSBoYXZlIGl0IGFwcGxpZWQgb24gbXkgbGFwdG9wIG5v
dywgYW5kIEknbGwgcHVzaCBpdCBvdXQgYmVmb3JlIEkgc2lnbiBvZmYNCmZvciB0aGUgd2Vla2Vu
ZC4NCg0KVGhhbmtzIGZvciBmaXhpbmcgaXQgc28gcXVpY2tseSENCkFubmENCg0KPiANCj4gVGhh
bmtzLA0KPiBEYXZpZA0KPiANCg==
