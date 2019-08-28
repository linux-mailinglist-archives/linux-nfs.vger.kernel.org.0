Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B483A0C56
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 23:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfH1V0Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 17:26:24 -0400
Received: from mail-eopbgr820099.outbound.protection.outlook.com ([40.107.82.99]:63889
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726907AbfH1V0Y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 17:26:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhszLobkgUdGIAcErBCneZNcnVTjEEJcF9lRIbnXgSUBjClgZVbICs+CDJG0vMgD3RcXBFFHKM8BTTJriXIfwEOvtNL62aNPf9m3zgUw2lt7G2HyXRLaalt/V+VUSiZVwh957MfncJEdiH8kzDJouLYeA+h/yf+23+tonaK+4PtB6KVMk4bdUNfoGHhjuClBH8k+qtN8HCpSmEcJzF0gApzibW8RIRyjItgjIAFgoym2FcKY+Jh6mrDibhlNJRnmAsit03Hkc94VHSP/5Eo10TratLcsLFwySd8X/jz48rP7qTaK+73IKL40pITvUbEUPAQQmWHdQfQoPtkMEpc0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3m8yJ+bLE/r8SqGnGMiyi3e6cnJMPuFrUinvjZ3ZNU=;
 b=DOsQiY8RdmKhhrBrtg04UCl63kogKxcQJx/55/ZvaGDW1TeZBJLMzSuJ4GLvmvnKzcKzk97wigCzUC02o8kmnF+lntCOVnA+00d01EGU3OOU/zPGmz0LnfoykqjNo8zBcqvPvqEFD+utyUP+tTBBhY3W3RG74ujV3odda7mZPjZauRw1zEpox256QWwNKETaGxLoQfjcviaJ6AGC9ImFZTTBB4DzSa0P5KhSc+8D0lATG25ogWP5xejdhSbluxxWqve+pCAGCDnpKfYb/sCZHsr5c0cAnaaICYIkL7qLww8Z478Uo+07r/2fvjwpFR0CpRSUSMU1FXpjQgWJrOuYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3m8yJ+bLE/r8SqGnGMiyi3e6cnJMPuFrUinvjZ3ZNU=;
 b=X3VBewaU5GZFmZQC1BZc4QaJhIU4UWokXaYDbQZRJY+Fe0ZQx2Qt9E6yLZ3ikwDsRvFWBHgzCka7xFmVC3K/OSe+v8hOWe9uIugnAsZZ+7qIbTVVjix33fO3K5w/H+Uqv5L+afujR0aUEmkO2b57rCy/shkvpUabRnFTfcx2PJM=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1403.namprd13.prod.outlook.com (10.175.107.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.14; Wed, 28 Aug 2019 21:26:20 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Wed, 28 Aug 2019
 21:26:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "louis.devandiere@atos.net" <louis.devandiere@atos.net>
Subject: Re: Maximum Number of ACL on NFSv4
Thread-Topic: Maximum Number of ACL on NFSv4
Thread-Index: AdVZ/zHAXlVbOFcuRg6ALmyIfYKMtQAAvtpwAISMAoAAAgBdYAAEV7cAAADj6cAABNvhgAAIJ0pwAFl2joAAAjaKgAAAtv2AAAHyS4AAAW6SgAAAs0MA
Date:   Wed, 28 Aug 2019 21:26:20 +0000
Message-ID: <a55b35b61987255d51c73d91c3e15fb99621250b.camel@hammerspace.com>
References: <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu>
         <AM5PR0202MB25644F1290D20A1996C5EED4E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
         <20190826164600.GD28580@ndevos-x270>
         <AM5PR0202MB2564874D2AD5845AE3CD13DAE7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
         <CAN-5tyHjQfrFU_iGXKSDSLnR6ywXizAqtU=5et1ESgKLCgHkAA@mail.gmail.com>
         <AM5PR0202MB2564D07CBF6B765EDABAAAB1E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
         <20190828180541.GC29148@fieldses.org>
         <CAN-5tyEth0YYiuS0oe8Q_LN-7Z8NXiF3hJPj1sL5MYCXjF-jnQ@mail.gmail.com>
         <20190828192931.GA30217@fieldses.org>
         <848b2abbedb5147e7a7e527111018fb04ec9ed7d.camel@hammerspace.com>
         <20190828210615.GA32010@fieldses.org>
In-Reply-To: <20190828210615.GA32010@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eef23a3-38eb-4f51-870c-08d72bfe5eb9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1403;
x-ms-traffictypediagnostic: DM5PR13MB1403:
x-microsoft-antispam-prvs: <DM5PR13MB14036FCDEF87588335C50791B8A30@DM5PR13MB1403.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39840400004)(366004)(136003)(346002)(189003)(199004)(76116006)(486006)(99286004)(478600001)(76176011)(66476007)(14454004)(54906003)(3846002)(66556008)(64756008)(6116002)(66446008)(305945005)(8676002)(2906002)(36756003)(71200400001)(6512007)(446003)(66946007)(7736002)(476003)(81166006)(81156014)(1730700003)(11346002)(2616005)(71190400001)(26005)(186003)(316002)(2351001)(14444005)(6916009)(53936002)(66066001)(5640700003)(86362001)(6506007)(6486002)(118296001)(6246003)(4326008)(8936002)(25786009)(6436002)(5660300002)(91956017)(2501003)(229853002)(102836004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1403;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KPvs930Hazg9C8h4nIp54LcFHSSmnoJeaO3cD4KCSZ/U7VvcIHt6qK4KVwLGMpWBcKP6IMbWHNwQI8dfjwwJvQAgWjyVA+oCUQw9g6MKXil8Di4Tbd4+3g49fgVcnm5L1R4x8XgAOSs42t8d8SkzbmlHRM9a8uM0fBlh6rp3FuoFRKqYgqSnYBbLVPRD2wMDegVRX7exoDRa37hpr7Wv6HxfJ/IkkVfY8dDdbo6yZZWnhUsXNBvB70gUnCmOW4XaUdpiHQYXTnS779kUOEZcLSpCGql8hu+SkSm0junvZ0jByJ4BFiIw0YGCnKHuYAe+OX019BOVHStXJ8LS49rQWhRLr76uC8V0Fx8h5E8QJMIBYPKB567QUs/CXCDjr9JjxT+GQe757aDDT9ULjO9nLhHi9n1aWLt9+vB7W/MDco4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AA36AEB3B1A654583132D910406C1B4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eef23a3-38eb-4f51-870c-08d72bfe5eb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 21:26:20.5959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mboMCB6j2D6MrUvbgwbg6j47b+cyJNgLA8kEJg6XhBV2gGFPsV9chZNbHAqJLDfs2dVuCvxZuK9VmkK5ILKGxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1403
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTI4IGF0IDE3OjA2IC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gV2VkLCBBdWcgMjgsIDIwMTkgYXQgMDg6MjU6MTZQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IFVtbS4uLiBEb24ndCBmb3JnZXQgdGhhdCBORlN2NCBBQ0wg
YWNlcyBhcmUgdHlwaWNhbGx5IG11Y2ggbGFyZ2VyDQo+ID4gdGhhbg0KPiA+IFBPU0lYIEFDTCBh
Y2VzIGJlY2F1c2UgdGhlIHVzZXIvZ3JvdXAgbmFtZXMgYXJlIGVuY29kZWQgYXMgc3RyaW5ncywN
Cj4gPiBub3QNCj4gPiBiaW5hcnkgdWlkcyBhbmQgZ2lkcy4NCj4gPiANCj4gPiBJT1c6IFRoZSBz
aXplIG9mIHRoZSBSUEMgbWVzc2FnZSBpcyBsaWtlbHkgdG8gYmUgYSBsb3QgbGFyZ2VyIHRoYW4N
Cj4gPiB0aGUNCj4gPiByZXN1bHRpbmcgUE9TSVggQUNMLi4uDQo+IA0KPiBBY3R1YWxseSB0aGlz
IGxpbWl0IGlzIHBvc3QtaWRtYXBwaW5nLCBidXQsIHllcywgYmVmb3JlIE5GU3Y0LT5Qb3NpeA0K
PiBtYXBwaW5nIChjb21wbGljYXRlZCBpbiBpdHNlbGYpLCB3aGljaCBpcyB3aHkgSSB0YWxrZWQg
YWJvdXQgaGF2aW5nDQo+IHRvDQo+IGVzdGltYXRlLg0KPiANCj4gTW9yZSBpbnRlcmVzdGVkIHRv
IGhlYXIgd2hhdCB5b3UgdGhpbmsgYWJvdXQgd2hldGhlciB3ZSBuZWVkIGEgbGltaXQNCj4gYXQN
Cj4gYWxsLiAgRG8gd2UgaGF2ZSBhbnkgaWRlYXMgaG93IGJpZyBpcyB0b28gYmlnIGEgbnVtYmVy
IHRvIHBhc3MgdG8NCj4ga21hbGxvYz8gIE9yIGlzIGl0IE9LIHRvIGp1c3QgbGV0IGFueXRoaW5n
IHRocm91Z2ggYW5kIGxldCBrbWFsbG9jDQo+IGZhaWw/DQo+IA0KDQpBIE5GU3Y0LnggY2xpZW50
IGlzIGFsd2F5cyByZXF1aXJlZCB0byByZXNwZWN0IHRoZSBtYXggcmVxdWVzdCBzaXplIGFzDQpu
ZWdvdGlhdGVkIGR1cmluZyBDUkVBVEVfU0VTU0lPTiwgc28gdGhlcmUgaXMgYW4gdXBwZXIgbGlt
aXQgcmlnaHQNCnRoZXJlLiBPbiBMaW51eCwgdGhlIGNsaWVudCB3aWxsIG5ldmVyIHRyeSB0byBu
ZWdvdGlhdGUgYSBsaW1pdCBncmVhdGVyDQp0aGFuIDFNQi4NCg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
