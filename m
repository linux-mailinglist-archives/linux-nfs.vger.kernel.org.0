Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD525842C0
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiG1PPi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 11:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG1PPh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 11:15:37 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2103.outbound.protection.outlook.com [40.107.100.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B3142AD9
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 08:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+CLwWwY3bjPj7eF52oe1rqj2LqrxGxXKULzDLWVqx0AHhck1F/nU17l+tcV7dDhsd9apIRJRUJM2w7IZvOY6M7UYDjDJ4qJY0FMw/GXbtJeBjorWWDBgKBHRbI6VaUfaS08nORgsXn1xv0JMmhctorWYtKo5I8PWiGT5UW1YHCoIoVNzr7jbzUpJbMJ9Ovh89PqrEEwF5UYQS2CawskhaToxHUmme97JZml3VZSHgRiRtiQaAxT4SU6lh8mzEbVPSUG0KvTIgVTydqygQDaiE1kWuhfElf8FKPvRCstZyoG/qOumxgi2KOa9hrLCbF3Yi8qANyO02HFu46wB/9L/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtFUdSDD6RBPAQ0RqaMLlxICOIiUVwt4Msw2w7kthbk=;
 b=l7P70JE53JwT5avtEWtZqwVdRe/gax8TPNyCOjnfNbsSAJ77INtVJK4nKNyo+uSna+VLK0Y4+hzvRG9cZAQPXAWpq6980lTkbrOUv8LAiFYqzl5yph4WPIgelw+CfmzegOsmvUPtKdWpd62IPx83GwpyV+IEzQ524DPkH4ZWc6b2PplaDdcoopvXtuivrDR22rV+/l6cd2tM7jqXla29rheDVijBhsqPumTG5OfZhuHc7bCDjY6GuXPysBxnXzdO0YYZ9pK0OHTWus8FUcePrZWWyxRaJ4ehFTH/01/g3vvhGVb87qXHnC5U39428IuE7DOy9dro8WscSxxpsQBMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtFUdSDD6RBPAQ0RqaMLlxICOIiUVwt4Msw2w7kthbk=;
 b=CU732N/2HgbfcxxGbZq18QTCIiz2UV9yd5LCoT/SReAgNVTULjazQS0HICoIM1l6ISo5HDMjyB+UcRExzeW2PdooKP/SkrAcEKQPRc0PlkJydy0K2Ar8yGQ/7ZT4lZ79DEuCD3c9r4SkEVNpkcus+dwdVn9qCOOfmsjxVIyhsvM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB2491.namprd13.prod.outlook.com (2603:10b6:5:cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 15:15:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 15:15:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "kolga@netapp.com" <kolga@netapp.com>
Subject: Re: [RFC PATCH] nfs: don't skip CTO on v2/3 mounts, regardless of
 order of reference puts
Thread-Topic: [RFC PATCH] nfs: don't skip CTO on v2/3 mounts, regardless of
 order of reference puts
Thread-Index: AQHYoo22EvI6SCZQSU6Evb804BNG4K2T3myAgAABrgCAAASKAA==
Date:   Thu, 28 Jul 2022 15:15:32 +0000
Message-ID: <f8c4a540f2077d2c3658a7e85a2df07ae4b9e5b7.camel@hammerspace.com>
References: <20220728142406.91832-1-jlayton@kernel.org>
         <1514326848e2874284a4af016fbda6dea67327fb.camel@hammerspace.com>
         <358ff1e4ab5ea12d8f16417ca85414bf58e37993.camel@kernel.org>
In-Reply-To: <358ff1e4ab5ea12d8f16417ca85414bf58e37993.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 459f31fc-4e8a-4022-68d4-08da70ac03b6
x-ms-traffictypediagnostic: DM6PR13MB2491:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9igsX6Nahgrc+zuYS8jpMqEv7lTcZXauEfby3zgaDh1qxiyL6tZErOx7hdRQTAi+CbLBWKCRc/v5G9+WJeE5J2dcwdGUx5/uaMp4HEAMeHz2BsSifoLly3O1c8elmNu77BRPespndufDpIL9a5iQaF16U7KIFd/oMNxDbxb2kxwS8Yni/lr2CRNdz0FVMWtYailXzoCSaJ9mPW0rN/rbRxMV/HNIK3F2hEolNWq99jI56ZWu1dKJZogivY6coXFc2k3dneMgIce2bp3DlQLQpWKL5lQsZyyyS6c+O5huQCirre9zvqiCNOKjKCsg1AcYnVYcXnzxikREpJmbJya4MO0uTwV2HNBiyORg3KG2tzr/GUDtUNZLOs2oqsrt214eRBNcYp8NpN/+/qCXnTwd/zkkeBXRlYZnvGe4ZDr24PUhbiv5njW9XMAU2jTCwpFwGfN538t/28GOSY94S3/w2tXLdN/fX9B2aXAfhkyoYEWqRM7mKFuR2h1ICj4YxNWcY7D4tFkStWQF/FcD/a4ZhhLY/z08idGFLqncemU3qZqgl1IVT3jtC/5sTa1ccNDMTDgYam34Cr/vM6IPK/2RpzTbszNrm2XxfqYYX4TI9uQ1vx+l0wIUcAl3wUC25zLu6EO1bjDqvF7XWj0KVDxn9uXUfL399C2a4gfgjCs2N4tMZmqK16XJDLvZNasWJCfgqzmtTskS7uhecI1PWtMSGXnRXr1cgFYW3C4ZSzKH7NSgRvEAyLSeVAnQo+IfT7xvwg9ngcRmlFAAE582BVylfetXiT389UrKbw+WBUKADR6tV0V9KfzJH/Nm5o3n2juG47wrBHFfvDZbodqu9Q6xkeuchJgG2C3TYYnjH/+uFFAoOFflvbWIA+lo28qABk4r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39840400004)(366004)(136003)(346002)(86362001)(38100700002)(38070700005)(122000001)(76116006)(66946007)(66476007)(66556008)(4326008)(8676002)(64756008)(66446008)(5660300002)(8936002)(71200400001)(6486002)(316002)(478600001)(54906003)(110136005)(186003)(2616005)(83380400001)(41300700001)(2906002)(6512007)(26005)(6506007)(36756003)(26953001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVgraEhvZ291VzNabHZTdmRZTVMzTmJ3MXJMNmJMUmplMTdtU2hOTDVCK0c1?=
 =?utf-8?B?M2VkZlhSc3NBV2tqMjRWazl6Uzh5ckU0Qk12RmhCcW5nbUs3cVBiUURUc003?=
 =?utf-8?B?eFUxNWdjdW1uWDRybVhwaDNBU3luR21YcUxsbXhTeHQ1TkdIcUo4aW1JUENG?=
 =?utf-8?B?VDJzL0UxU1g5TzNhVVpJZHNlZ3V3VXYxL3RuV2p2TFR2SlBQMXdVSFFVdzZy?=
 =?utf-8?B?NXhUVS9IZmpJOG9XRHpMM1FuMTBmQ1FQQjY1OGR3bnVrTHA2WXVET0pYTUYx?=
 =?utf-8?B?WXNBczBwanlhRVQwZjRRWjhSeU16ZlpJT0FncXhyZWswTGlrMU5HSEV6MjlW?=
 =?utf-8?B?NGlya09NSDRFMldvekxRNy9IWmxCYnBZSkllaXovc3lzQXl1VEpxYWtMVEwr?=
 =?utf-8?B?QXNkTGdnQ1FNN0RFTDlxa2NNdmtFSmxvUlk3b1A5VDN6RWIwelRiVUNLdVhm?=
 =?utf-8?B?UFlHNlo0NzMwKzJ1NzkyUzd2R095eEpCSldaVWJ6SEdGcTRnQlVhTTZvc2lz?=
 =?utf-8?B?K05VajZOSWhtTlV5enRyWG5sUjNRRlRmQytvNkVzN1RWU1pFWDljNUxFOEc1?=
 =?utf-8?B?OWg2Y1cyakZkbytjb2duTTIxNlFIaSsyS3hGZkZIZU1FSUN5V3dtaS9Pemd5?=
 =?utf-8?B?V0R0a0JjQS9EVUsyVUVIcUNVNFdteXhlemxsRXVvalU4a1A5VGtlVmpYdFlj?=
 =?utf-8?B?aTAxWmozZnA5Z2FWclhldWxHWm1TLyt0V3YxRTVNZGhNdGplcWUxd1JUTkRP?=
 =?utf-8?B?aHhPRVE5R2M2NW5QMjN3Y0Z0cWZZNStaRGh1WVhnN21tN0hrZitQZW1WalVD?=
 =?utf-8?B?WHkrbkF2NnhqQWl5N3lOUGRSQUFFVTJRSUt3R1N3Y3ZvblZJKzd6ZzBKQW16?=
 =?utf-8?B?ZThvcXczZUw5MWQ3THNWTC9RbU1UVWlkWW9IYS96RE9MKyt1c0xQWnRQYXlO?=
 =?utf-8?B?eCs1MW5MQ1RLV0NhdXJRSDZkRGdCdURna2dKN29vM05ZTmxJS2RjN2NyNitq?=
 =?utf-8?B?bWFrcFVZbm9NOFQ5NlJMRXc0RXJ1QjBmRm5aWHM2Nmd4bVpIcjJEVzhhS2pZ?=
 =?utf-8?B?bDcwTXZ6ZzlXNEtZaExPak1sRmUxNU9uaU5IVjIzK2tKYW1jeDFTcHNseERY?=
 =?utf-8?B?WEI5S21JcFF0SmVpcFhKSmpsd0VXUWJEdkdXM0hERnl4Nktkc0plSFFHbTFr?=
 =?utf-8?B?RUFaWCtPWkNSMWxwY0lLWFgyVGNWcVBLRkRqVU04eENJdDBEbGhpTkxPamtq?=
 =?utf-8?B?YVZ6bXlaaW5BNmlKVXdsU0Rlc21wZmRDckc0dFhxK0RRaUFQcS85QUlIK3Ir?=
 =?utf-8?B?dVFXQTBkbHMwa2Z5Z0VIREpYWWR5M0o0aDFpR3NaS0RNWXpCWUIxTWluUW11?=
 =?utf-8?B?WDhzT2o4NFhXWnpqYkZLRHN0UUxNZlZvMXEyZVBhN1huNjRJVXlHUVNlOVdZ?=
 =?utf-8?B?cThoOWNwZHdaN1VmazhqRGlHZjQxM0RUNm81VmRyWWx1dFJPbkZmR0lpclYv?=
 =?utf-8?B?QlE2b3BjUVg2QlcyQkpOT1JObGpnT2Y4YjlwZXdtOW9iZUExVmVwSy9VSWtR?=
 =?utf-8?B?T09EUXR3d1QvMGhUa0xEaW1FZkxhRW13NkFJKzZPK1paRzdsTDkra2RTTkR4?=
 =?utf-8?B?UDE2UFJraTdrV2c3K05JUFp4YTNNbFJtUFZmOGFtd3hDYlVndldTQTVVMUth?=
 =?utf-8?B?Rm9vSXdrT3RMbU10RHN1NlRpd3RyZmpGNVg2WG1BMG5sT3VWV0oxWXpEUTNL?=
 =?utf-8?B?NnFBd0ZtcHNqU3lLaW1XNEpMZTk3aXJwZWFMeU5uNCtTb1hYNzkxYlJ5RFA2?=
 =?utf-8?B?NEF5WElMWENXb3k3SXZKZlFBWXJ3Z1V1TEk3NHc5ZVlUWHphMGpGN1Q0dnVs?=
 =?utf-8?B?NGk1ejRjTVJJVDBuN1hCc2ErcTZJVElIVEpOdG5XbE1yMnNnRDM1cG11Y0Jz?=
 =?utf-8?B?SnQ1R3BkalJYZFc3S2lQMjdvbTdpZ0dpdFNtc3k0ZjYrSmpUYkpmTldCc0hi?=
 =?utf-8?B?b25NSFJLTDlGZUkxTFBZd3o2VWpGcG1VRWtSUUl5SldKKzBSZ3BxeXR1TVAy?=
 =?utf-8?B?QSszd04vTk9qSlViZmpqejc5cXpXTTI0RnJxSXBvM29HMHVNckJndkhWOTJL?=
 =?utf-8?B?WGlmYm56NzFpcXFoL1NYZ3NGa2ZUdG9YdnA5bmZVS0hSelFiVlFyTFkxa2VK?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1247AD89C0709044B43F0CAAA35D4A54@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459f31fc-4e8a-4022-68d4-08da70ac03b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 15:15:32.4849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIxa+bsvsgg+Gxlcm3f20gB7TNIhHoiWtNWUZbXrkkdcsIOVLsHoNhhCdVOdp5mtzCK0MRFucAcBk4olx8Orng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA3LTI4IGF0IDEwOjU5IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVGh1LCAyMDIyLTA3LTI4IGF0IDE0OjUzICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gVGh1LCAyMDIyLTA3LTI4IGF0IDEwOjI0IC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IE9sZ2EgcmVwb3J0ZWQgYSBjYXNlIG9mIGRhdGEgY29ycnVwdGlvbiBpbiBhIHNp
dHVhdGlvbiB3aGVyZSB0d28NCj4gPiA+IGNsaWVudHMNCj4gPiA+ICh2MyBhbmQgdjQpIHdlcmUg
YWx0ZXJuYXRlbHkgZG9pbmcgb3Blbi93cml0ZS9jbG9zZSB0aGUgc2FtZQ0KPiA+ID4gZmlsZS4N
Cj4gPiA+IA0KPiA+ID4gTG9va2luZyBhdCBjYXB0dXJlcywgdGhlIHYzIGNsaWVudCBmYWlsZWQg
dG8gcGVyZm9ybSBhbnkgb2YgdGhlDQo+ID4gPiBHRVRBVFRSDQo+ID4gPiBjYWxscyBmb3IgQ1RP
IGR1cmluZyBvbmUgb2YgdGhlIGV2ZW50cywgbGVhZGluZyBpdCB0byBvdmVyd3JpdGUNCj4gPiA+
IHNvbWUNCj4gPiA+IGRhdGEgdGhhdCBoYWQgYmVlbiB3cml0dGVuIGJ5IHRoZSB2NCBjbGllbnQu
DQo+ID4gPiANCj4gPiA+IFdlIGhhdmUgdHdvIGNhbGxzIHRoYXQgd29yayBzaW1pbGFybHk6IHB1
dF9uZnNfb3Blbl9jb250ZXh0IGFuZA0KPiA+ID4gcHV0X25mc19vcGVuX2NvbnRleHRfc3luYy4g
VGhlIG9ubHkgZGlmZmVyZW5jZSBpcyB0aGUgaXNfc3luYw0KPiA+ID4gcGFyYW1ldGVyDQo+ID4g
PiB0aGF0IGdldHMgcGFzc2VkIHRvIGNsb3NlX2NvbnRleHQuIFRoZSBvbmx5IGNhbGxlciBvZiB0
aGUgX3N5bmMNCj4gPiA+IHZhcmlhbnQNCj4gPiA+IGlzIGluIHRoZSBjbG9zZSBjb2RlcGF0aC4N
Cj4gPiA+IA0KPiA+ID4gT24gYSB2Mi8zIG1vdW50LCBpZiB0aGUgbGFzdCByZWZlcmVuY2UgaXMg
bm90IHB1dCBieQ0KPiA+ID4gcHV0X25mc19vcGVuX2NvbnRleHRfc3luYywgdGhlbiBDVE8gcmV2
YWxpZGF0aW9uIG5ldmVyIGhhcHBlbnMuDQo+ID4gPiBGaXgNCj4gPiA+IHRoaXMNCj4gPiA+IGJ5
IGFkZGluZyBhIG5ldyBmbGFnIHRvIG5mc19vcGVuX2NvbnRleHQgYW5kIHNldCB0aGF0IGluDQo+
ID4gPiBwdXRfbmZzX29wZW5fY29udGV4dF9zeW5jLiBJbiBuZnNfY2xvc2VfY29udGV4dCwgY2hl
Y2sgZm9yIHRoYXQNCj4gPiA+IGZsYWcNCj4gPiA+IHdoZW4gd2UncmUgY2hlY2tpbmcgaXNfc3lu
YyBhbmQgdHJlYXQgdGhlbSBhcyBlcXVpdmFsZW50Lg0KPiA+ID4gDQo+ID4gPiBDYzogU2NvdHQg
TWF5aGV3IDxzbWF5aGV3QHJlZGhhdC5jb20+DQo+ID4gPiBDYzogQmVuIENvZGRpbmd0b24gPGJj
b2RkaW5nQHJlZGhhdC5jb20+DQo+ID4gPiBSZXBvcnRlZC1ieTogT2xnYSBLb3JuaWVza2FpYSA8
a29sZ2FAbmV0YXBwLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5
dG9uQGtlcm5lbC5vcmc+DQo+ID4gPiAtLS0NCj4gPiA+IMKgZnMvbmZzL2lub2RlLmPCoMKgwqDC
oMKgwqDCoMKgIHwgMyArKy0NCj4gPiA+IMKgaW5jbHVkZS9saW51eC9uZnNfZnMuaCB8IDMgKyst
DQo+ID4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+ID4gDQo+ID4gPiBJJ20gbm90IHN1cmUgdGhpcyBpcyB0aGUgcmlnaHQgZml4LiBNYXli
ZSB3ZSdkIGJlIGJldHRlciBvZmYganVzdA0KPiA+ID4gaWdub3JpbmcgdGhlIGlzX3N5bmMgcGFy
YW1ldGVyIGluIG5mc19jbG9zZV9jb250ZXh0PyBJdCdzDQo+ID4gPiBwcm9iYWJseQ0KPiA+ID4g
ZnVuY3Rpb25hbGx5IGVxdWl2YWxlbnQgYW55d2F5Lg0KPiA+ID4gDQo+ID4gPiBUaG91Z2h0cz8N
Cj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9pbm9kZS5jIGIvZnMvbmZzL2lub2Rl
LmMNCj4gPiA+IGluZGV4IGI0ZTQ2YjBmZmEyZC4uNThiNTA2YTBhMmYyIDEwMDY0NA0KPiA+ID4g
LS0tIGEvZnMvbmZzL2lub2RlLmMNCj4gPiA+ICsrKyBiL2ZzL25mcy9pbm9kZS5jDQo+ID4gPiBA
QCAtMTAwNSw3ICsxMDA1LDcgQEAgdm9pZCBuZnNfY2xvc2VfY29udGV4dChzdHJ1Y3QNCj4gPiA+
IG5mc19vcGVuX2NvbnRleHQNCj4gPiA+ICpjdHgsIGludCBpc19zeW5jKQ0KPiA+ID4gwqANCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIShjdHgtPm1vZGUgJiBGTU9ERV9XUklURSkpDQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsNCj4gPiA+IC3CoMKgwqDC
oMKgwqDCoGlmICghaXNfc3luYykNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghaXNfc3luYyAm
JiAhdGVzdF9iaXQoTkZTX0NPTlRFWFRfRE9fQ0xPU0UsICZjdHgtDQo+ID4gPiA+ZmxhZ3MpKQ0K
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47DQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgaW5vZGUgPSBkX2lub2RlKGN0eC0+ZGVudHJ5KTsNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqBpZiAoTkZTX1BST1RPKGlub2RlKS0+aGF2ZV9kZWxlZ2F0aW9uKGlub2RlLCBGTU9E
RV9SRUFEKSkNCj4gPiANCj4gPiBOQUNLLiBJZiB0aGUgJ2lzX3N5bmMnIGZsYWcgaXMgbm90IHNl
dCwgdGhlbiBpdCBpcyBiZWNhdXNlIHRoZQ0KPiA+IGZ1bmN0aW9uDQo+ID4gaXMgYmVpbmcgY2Fs
bGVkIGZyb20gYSBjb250ZXh0IHdoZXJlIGl0IGlzIG5vdCBzYWZlIHRvIGRvIGENCj4gPiBzeW5j
aHJvbm91cw0KPiA+IFJQQyBjYWxsLg0KPiA+IA0KPiANCj4gT2suIEFueSB0aG91Z2h0cyBvbiB0
aGUgcmlnaHQgd2F5IHRvIGZpeCB0aGlzIHRoZW4/IEl0IHNlZW1zIGxpa2UNCj4gc2tpcHBpbmcg
cmV2YWxpZGF0aW9uIGJlY2F1c2UgdGhlIGxhc3QgcHV0IHdhc24ndCBpbiB0aGUgY2xvc2UNCj4g
Y29kZXBhdGgNCj4gaXMgdGhlIHdyb25nIHRoaW5nIHRvIGRvLiBTaG91bGQgd2Ugc2NoZWR1bGUg
aXQgdG8gYSB3b3JrcXVldWU/DQoNCklmIHRoZSBhdHRyaWJ1dGVzIGFyZSBtYXJrZWQgYXMgdXAg
dG8gZGF0ZSwgYmVjYXVzZSB0aGV5IHdlcmUgYWxyZWFkeQ0KcmV2YWxpZGF0ZWQgYWZ0ZXIgdGhl
IEkvTyB3YXMgcGVyZm9ybWVkLCB0aGVuIHdlJ3JlIGZpbmUuIElmIHRoZXkgYXJlDQpub3QgdXAg
dG8gZGF0ZSwgdGhlbiB0aGF0IGlzIGV4cGVjdGVkIHRvIHRyaWdnZXIgYSBjYWNoZSBpbnZhbGlk
YXRpb24NCm9uIHRoZSBuZXh0IG9wZW4gd2hlbiB3ZSBjb21wYXJlIHRoZSBjbGllbnQncyBjYWNo
ZWQgdmFsdWVzIHRvIHRoZQ0Kc2VydmVyLXJldHJpZXZlZCB2YWx1ZXMgZm9yIHRoZSBmaWxlIGF0
dHJpYnV0ZXMuDQoNCmkuZS4gdGhpcyBvdWdodCB0byBiZSBqdXN0IGEgcGVyZm9ybWFuY2UgcHJv
YmxlbSwgYW5kIG5vdCBhIGNvcnJlY3RuZXNzDQpwcm9ibGVtLCBpZiBhdHRyaWJ1dGUgY2FjaGUg
cmV2YWxpZGF0aW9uIGlzIHdvcmtpbmcgYXMgZGVzaWduZWQuDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
