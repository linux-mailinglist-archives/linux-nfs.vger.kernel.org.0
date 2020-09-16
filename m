Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB89926C47F
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIPPaD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 11:30:03 -0400
Received: from mail-dm6nam08on2108.outbound.protection.outlook.com ([40.107.102.108]:39521
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbgIPP3a (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Sep 2020 11:29:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5dRZYNm3YYT4iyeJKPvFkC5MSXr6MnvnX1E2IJmi7fvMZUWY/r95iLk3Qsmhf0ZRWpYWZQdl0F1mYhjEkNRPfX/lsULJM2kYKS47Ff3EnpD1LS9HzPf78sSZ2C4dv/8i4cUB3VIVWWppqq+we1KBKjJV1mVqgQ6Ed4s1L5fKnD0PQQZjNpaGW73vXMFsAg8goRZ4/BfF85uArTgMBlWpxTQUfaGeIMKMFXFVTZzzSoUCiVInlS2n6muzXkQrphEXbJeZTw3wIrlt0M3gzg4TrBdGJF7rxJmDRnm+wndh12yzcj/hZZprxCJX48c+OoAeK1lNg/JCRPludoiPYBjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWTEmr1okNTCSMRVvWcCNLd/AYRNmd+Rbxak9pD6QEM=;
 b=Omx/Uh10JKpP9ooyIi8bpqZcPKcsBx9VgMGK8Cvc74wg+ma+QfAkIjn6ox4KAox6z6WN4q5fOr9/98PcqKyYvTEoZhbspcxmTfvsLRjeqsttjDOeVsmwNz6yk9OPqyYTNCZ9ayheCR5XXnvnKBI3cQ5SVqTm+AiJfG87HTZqwMYMazFEUOiy/HPymgus0YnYEdBWlNjn1jxLq8Q26h7pQra+x0w+VgXZZCBgQb/NaOHKzSvTvX/AYGZWDf7iAfdWeKDjTZ19i7nOCQYyXFUmBQ0fRcLsjE4RPeF14icTkIXIXRMbDv87pnqFeH725ohGKu4LjlAeEsFnpdWTgpwtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWTEmr1okNTCSMRVvWcCNLd/AYRNmd+Rbxak9pD6QEM=;
 b=HH/wa1e3ExKYOyG+SQv2vCytf7WRZU8zvCZgVv4+TCDTkfL0QeGIRSUE3tVL9l4lB180FfC3zr5zw5e51zaNVDPVVQDFmltMwTaP6ZtVt5CauYlixCfkbCfLxfdZnO3DhyysyHUJhIxRwJ8C6G6NEjhvTbTWufQFgp65ViNIswY=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3005.namprd13.prod.outlook.com (2603:10b6:208:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.8; Wed, 16 Sep
 2020 14:52:51 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3412.004; Wed, 16 Sep 2020
 14:52:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Nagendra.Tomar@microsoft.com" <Nagendra.Tomar@microsoft.com>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Topic: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Index: AdaLdYAHSfC4FmukRxSfbPzbpNbQ4QAw4uWA
Date:   Wed, 16 Sep 2020 14:52:50 +0000
Message-ID: <1fdce3fc0981916f8d3829933db61a3f78aebde3.camel@hammerspace.com>
References: <SG2P153MB02316AF481EB246AED91DCB69E200@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB02316AF481EB246AED91DCB69E200@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4669043-d61a-450f-e66b-08d85a502f2c
x-ms-traffictypediagnostic: MN2PR13MB3005:
x-microsoft-antispam-prvs: <MN2PR13MB3005E5D6C7FF860652020ECCB8210@MN2PR13MB3005.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RNrTOe1HodgIqclMEq4vpSvg1bYcXWIkoQ7g/NAmE3kzbwCBpdYziS/8woZkYakovQgA22pbkJ+Vyuvrnf+b5hBO/q38W+0oJaKuL31teAoqQE0BrzyPnSyRyC05tqkTertbL0XWKVyLdnrIKLQ3qKTdWdGhATMMBnQlQP8YhBssxgEuytMik5fjALWL3++ZKJ/ojQS9cXOL1YB+YijKo+nMSg4GIHiuJTO5tSXCX/prsg7CXOYoPAfeNDN19r5qcKV8g/XNYTkqDHdcRfxqSObrAV/B2JTS3adOgoxDL/Ae/jK7NuG5qP36H+YWayu99ec3cSRr4OmkOxjCNIBOEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(396003)(376002)(366004)(36756003)(86362001)(478600001)(66476007)(66556008)(64756008)(8936002)(6506007)(66946007)(6512007)(6486002)(5660300002)(4326008)(26005)(186003)(2906002)(316002)(83380400001)(71200400001)(110136005)(8676002)(2616005)(91956017)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EZllH1RHj3/qFSBrCOnND64nY5QSY800XpufezEsq3JyKKutAveDREKxQ8/fiRzdnShBD6qieL3eelCqGCAWWydutyBOyZjULWod6Gje42ma0WfDJqYvvMNXtIwaZWkRWLCp9ValnIpGjdEnoDTNVHD8TnSh9Pz4H7Wrsose1iIbIrGDkckgc5FyV7/377ertA3isP6qUOy9WRn1mVtm5gFEZLurkybjU+BuQy63nsTWoWQX2YJV7SWuequj/QeYj3y+lZObOhqunO019bkVWByeW0CS7OSi7DzkTDXmrcrbnRj07HsJg5sTAwIi+lqy6l1UG1J05plh3IqETSKWXgaM1KntHyee7DHRisN4A3MJfBvLI7K4UF+OGPXkt0lKe/a07SFq/3ut3yXbqepkYvHhJow9AZUAcqXa0NIn8YkdMeC44Bd+GgZu75dZrNvXC/JFpqjbGCLEjBqd5VOOpsVWYeWtfIZxVBTmgt3KxAN0I2QyS3Pt8zLFyRb6qP4ElbRtRqnzGRokgP16aQThBwZZjHdz8aqryy6y+roC5SpLFNYgeG+gZue9eKN82koqBe0r9mPhIyhSoRs6A9ksFej++qeUqGWPrcFs2Rdz8U/2uXYc/CgC/e6CdBKYttVPY+cJOiRqdwTpbZV1OsOnDg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A729AF4A3CC2347BAD0D6410730A8DF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4669043-d61a-450f-e66b-08d85a502f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 14:52:50.6677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OOoDh/6UI6pWT/bMWvxqNpBRnsXu4TuaqGyre8GYk0eIFIcenFaPgvVWwpdhZSW31upVIohdcs136cl/ZPnCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3005
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTE1IGF0IDE1OjMzICswMDAwLCBOYWdlbmRyYSBUb21hciB3cm90ZToN
Cj4gRnJvbTogTmFnZW5kcmEgUyBUb21hciA8bmF0b21hckBtaWNyb3NvZnQuY29tPg0KPiANCj4g
SWYgTkZTX0lOT19JTlZBTElEX0RBVEEgY2FjaGVfdmFsaWRpdHkgZmxhZyBpcyBzZXQsIGEgc3Vi
c2VxdWVudCBjYWxsDQo+IHRvIG5mc19pbnZhbGlkYXRlX21hcHBpbmcoKSBkb2VzIHRoZSBmb2xs
b3dpbmcgdHdvIHRoaW5nczoNCj4gDQo+ICAxLiBDbGVhcnMgbWFwcGluZy4NCj4gIDIuIFJlc2V0
cyBjb29raWV2ZXJmIHRvIDAsIGlmIGlub2RlIHJlZmVycyB0byBhIGRpcmVjdG9yeS4NCj4gDQo+
IElmIHRoZXJlIGFyZSBubyBtYXBwZWQgcGFnZXMsIHdlIGRvbid0IG5lZWQgIzEsIGJ1dCB3ZSBz
dGlsbCBuZWVkICMyLg0KDQpJIGRvbid0IHRoaW5rIHRoaXMgcGF0Y2ggaXMgY29ycmVjdC4NCg0K
Rmlyc3RseSwgd2UgZG9uJ3Qgc3VwcG9ydCBzZXJ2ZXJzIHRoYXQgdXNlIG5vbi1wZXJzaXN0ZW50
IHJlYWRkaXINCmNvb2tpZXMsIHNvIGlmIHRoZSBjb29raWV2ZXJmIGNoYW5nZXMgb24gdGhlIHNl
cnZlciwgdGhlbiB3ZSdyZSBub3QNCmdvaW5nIHRvIGJlaGF2ZSBjb3JyZWN0bHkgdy5yLnQuIGV4
cGVjdGVkIFBPU0lYIHJlYWRkaXIoKSBiZWhhdmlvdXIuDQoNClNlY29uZGx5LCBldmVuIGlmIHdl
IGRpZCBzdXBwb3J0IG5vbi1wZXJzaXN0ZW50IGNvb2tpZXMsIHRoZW4gdGhlIE5GUw0Kc3BlYyBz
YXlzIHRoYXQgd2UgbmVlZCB0byBzZXQgdGhlIHZlcmlmaWVyIHRvIHplcm8gd2hlbiB3ZSBhcmUg
Y2FjaGluZw0Kbm8gcmVhZGRpciBjb29raWVzIHRoYXQgbmVlZCB2YWxpZGF0aW9uLCBhbmQgd2Ug
YXJlIHJlYWRpbmcgdGhlIGVudGlyZQ0KZGlyZWN0b3J5IGJhY2sgZnJvbSBzY3JhdGNoIChpLmUu
IHdlJ3JlIGFsc28gc3VwcGx5aW5nIGEgemVybw0KZGlyX2Nvb2tpZSkuIFNvIHRoZSByaWdodCBw
bGFjZSB0byBkbyB0aGlzIHNldC9yZXNldCBvZiB0aGUgdmVyaWZpZXIgaXMNCmluIHRoZSByZWFk
ZGlyIGNvZGUsIHdoaWNoIGtub3dzIG5vdCBvbmx5IHRoZSBzdGF0ZSBvZiBvdXIgY2FjaGUsIGJ1
dA0KYWxzbyBrbm93IHdoYXQgd2UncmUgc2VuZGluZyBhcyBSUEMgY2FsbCBhcmd1bWVudHMuDQoN
CkNoZWVycw0KICBUcm9uZA0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
