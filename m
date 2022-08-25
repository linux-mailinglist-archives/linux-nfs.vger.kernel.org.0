Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2C85A15E0
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Aug 2022 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbiHYPcu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Aug 2022 11:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbiHYPcf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Aug 2022 11:32:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2107.outbound.protection.outlook.com [40.107.92.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC63A9C0A
        for <linux-nfs@vger.kernel.org>; Thu, 25 Aug 2022 08:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq3PBQjebY9w6RMArLZ1/RQbS4QC8dBpvZfG+LrQzfhB81JF66+iqF15K2EAyr8/bOXlxRPlvCw2yiouTkuAfmu1/T120QntuxIxYkdzxPWbcPRfuUB6KgQN+4NA6hZNaq3HRng6zPsWyO/t8aB9nkJCdMzr2YUN/wsfSm+6PyFsbJSHNkPWYmL6WayuhAbyanPkRbURTIoHv7ftsYHNIiLDgJ3Pm/SNzYNR10BJaY8W+iEG9jcNgRbCQK55LR4yKERV1JDYhtZYItPS2KmExIp7f5QzzqB52oj4i7AYWDJgAx2vMhx6gt1UU9lrT08CxUgdO8KASodkjWbz8qk2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RYIN2egUE2FTqqUdc5G+g9C7RGu2Xh9HnM1cQNg2r0=;
 b=ZiZqzaUG95CQOdLPcDEZHBj7FQq76Qrorzz6pwyMG9zXrohAkMP9+arLScnpE7tFMfRxLVZj2c/gs7M3AEtyvrJRKP0sB5u24FnqkEBVucuIQePLsCzqouza73ISdgwVabHId4WY+hwgUmqlnqyDQDq2vK88P7ke4S3Xvz326sMbIsgNyDRJCEgs+8ukOt2+KpTJOf7+5wzbdxi4tdFHniPKqSV99EiwpV/vMiAKiqH8qk/8Fsbkjy/VEJEUE5vnRqc8Wpc0NkeMBSA/7LQ0KKeteWNxiLZ0YRc7+93BSuTLVjbYRM7mgQLqiM7E1Fj8cTyBA8vc2lIS4Q+b2jW9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RYIN2egUE2FTqqUdc5G+g9C7RGu2Xh9HnM1cQNg2r0=;
 b=ej8Afdj127RpABO2hhk1g+VN30RgQbTo8JTv5r2g6rEYl7E8NJBaAVvHAZOjGtu2M1t+LYmQfzOXWi2/v39djh60+TJtyFA/hmDPtlZuxfQPTyfPZPdrSaGCnFVJPDesatfhPwG8NZQy78+xMEYKDVjJMdfqGk1nnHtJi0UfdX0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR1301MB1969.namprd13.prod.outlook.com (2603:10b6:405:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.14; Thu, 25 Aug
 2022 15:32:25 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%4]) with mapi id 15.20.5588.003; Thu, 25 Aug 2022
 15:32:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire.byrne@gmail.com" <daire.byrne@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "benmaynard@google.com" <benmaynard@google.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
Subject: Re: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Thread-Topic: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Thread-Index: AQHYt5zQc0jiP02yL0Kjw6guU1m2RK29/pOAgAAFTACAAAEnAIAAErsAgAAlsoCAAAdXgIAADgwAgAFlDICAAAiigA==
Date:   Thu, 25 Aug 2022 15:32:25 +0000
Message-ID: <b4cbbdef254e9e0e6feb41455d809aaf0c5abfdb.camel@hammerspace.com>
References: <da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com>
         <20220824093501.384755-1-dwysocha@redhat.com>
         <20220824093501.384755-3-dwysocha@redhat.com>
         <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com>
         <CALF+zOknvMZyufSUD-g9Z9Y5RfwE-vUFT+CF0kxqbcpR=yJPJw@mail.gmail.com>
         <216681.1661350326@warthog.procyon.org.uk>
         <5ab3188affa7e56e68a4f66a42f45d7086c1da23.camel@hammerspace.com>
         <YwZXfSXMzZgaSPAg@casper.infradead.org>
         <5dfadceb26da1b4d8d499221a5ff1d3c80ad59c0.camel@hammerspace.com>
         <YweOySTkKQ3PDLCv@casper.infradead.org>
In-Reply-To: <YweOySTkKQ3PDLCv@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac6e43e5-8d8e-42a9-ee59-08da86af0332
x-ms-traffictypediagnostic: BN6PR1301MB1969:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iXnneTCxiNN+u8HhAmuaKKHllgHmAE7CM89hO25z9QW8sjdjQ7IsEwwPZDwTY26vaUJ1vMxT0iME3G2dYimQ9TUmql+7ZbSRNvQdhE0kw34LAqDmwk1BSUUqGVgQiHRJFzohI8cBoDG08piLNq7bqdg1dtGgq+jdgwhQnhQxjdqq6zRigT789yD9LCEvNy4wHjEwooAxg1bEnIwncgv1kV4Q75bkU2IDH/lluwwer4VmCZRmNPDgste2ieTaEQ0Ht1ubK6SxpMBq9t7Zj2Wd6JCFG42GwKdo1B6aCZLHSoegRdogujC+sGOw+Ny9Bl6A0y+Y5V5eCvYNhai8Cu5BLNgOUIdA49cG93gi6hXxljfUo3VfhEDSZCAMPnBsntykcKoHrEQPWCLoL2f0nI9CcZy8Nx/CYZRONfosBiCAzm9pIL6Zk6OBXqZEirjbXgrndQ5k22Gvhy1YSKKgCxspFIpEx1X7CdlpocBAaHwexrlGbqikdx8LpCcM5JwfWa4OReLNTIZ2scnc7V/jqtsTPVLDJoxOJ1pZld+mbCNONb71/aFkqmB0krl2DN6CZTJ9DxuBanoyqdKqj/u5stZvveV2gIMqfDtlzrFO5rs+LEUV7RYEfgwMIvtBCwwpJt3ljq42KK31r1KSItfVmTukO9W908ZRFHRbEl4xnnZRk+2r5yW5ofR1670c59KsY238RBWEgPunp3OEz/1bn+RsmP1BmlGFdDhsnlBVeWQiUJk7AFPBrCq+M6id4Ljxef82Pfd1QitMGaA9vCWaFgQqLwvhmLWcPo1UxWBtQqafjC7jCDeX89atgT+R1p+eq0lR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(376002)(39840400004)(396003)(2616005)(6506007)(26005)(6486002)(186003)(478600001)(6512007)(64756008)(2906002)(38070700005)(8676002)(71200400001)(66476007)(41300700001)(36756003)(4326008)(38100700002)(76116006)(8936002)(5660300002)(66556008)(66446008)(86362001)(83380400001)(66946007)(316002)(122000001)(54906003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjFuV2wrekNNT1YzREtPVFV5OW1hUjBYRDVDMzQ4eFpFS3lCeVRxSHVyNXMx?=
 =?utf-8?B?U0VaNFBWSUhpUyswL21UWUdaelg4c0J2Qml2V1UxMnJSRE9jZVBCL2FWa2FG?=
 =?utf-8?B?Sk92NDhYVUNRMmZtS2hHNDB6QlNGL01tRjBTY2pQb0Npbmw4VG4yQTNCekQ2?=
 =?utf-8?B?V1l3anQ0NDNic2w0dGVGL3pRL2JSdUNYRVFFSWdxNnRnSHNXcjNhNFBOM3RU?=
 =?utf-8?B?QTVZd3pqR3ZFSUIzUHFSME5lQXNDZlRJNXBCendEdURFZ2JLYUkvOW5UMk9m?=
 =?utf-8?B?Lzl3bW00U3E0akVMcjdmZ0VpbUp4NUt5NlpXb0gzZkFSaThtbkZwRVNDWCtB?=
 =?utf-8?B?UTFvbnI3NEpNd0RBRENqUW94Y21EbURCQ0xsVnJyVWEvMUZta3dzejdqV1lV?=
 =?utf-8?B?RHl0ZWM1T3RBekFhc2JycGxpSkZmNmlEdXdRYUhDM2ZGMmxCdkhzd25OSTcv?=
 =?utf-8?B?T095NVh5WDJQWFR3ZkpmKy9zUmFnSGk4bzY2cU5CZ2plTkhzK2V0K0s5a0Vm?=
 =?utf-8?B?R2xSY2psTk03Z1NZRzBaS2VvWFRwa0ZKandiNkRYSlp4eUMzRVV2aEwrN2FM?=
 =?utf-8?B?Sm90TEVDVDUvTkt3L2FDN0NlNVNydHNBa2R1TW1ZdDBjK0orelpWM0FqRU9K?=
 =?utf-8?B?c2hEYmVZeFpVQ2tqcktJblQydU5SUG4wSkRPWm9YTGROUDlRNmdKZzhDOWp1?=
 =?utf-8?B?aHY0a3JwUm5LOVB2cTdSUndMU0N1NmczQWlSTUxJZlZxYnFuclRhbnZ4ZDRE?=
 =?utf-8?B?d1RHd0pSdVBna2QwUlpWemFENFUrSUF0L2RGckhJTCtIUmNzL21IWlZrRGIz?=
 =?utf-8?B?RkJhcXFZRFpyenI4bm5nV1d5VVJLalQ2NXRXSkROeS96VDVjUUUrdThodUFp?=
 =?utf-8?B?eGNnSmxGZm1qdXZtN0NhbUUwcVZtQk50dm05LzluUWRZdGNVbGVkaFdvcUpM?=
 =?utf-8?B?R091dlNJZHVxQ09IVnB5TGF5OGNPbDJwNU1DdWphTDVnNm1ibjFtbVBHZHF2?=
 =?utf-8?B?b1h5Z1dudDNnSmVzb3h3SmdXaWx2MmVObVl6WHdEVU9uSldvMU5sNUkxb3Y5?=
 =?utf-8?B?M0RFYTBFc1h1bHlZMlIxZ0k4TTh1TVNoL0xvK0p1VnNaZFU4U1BGN0x5K1BR?=
 =?utf-8?B?TVd4amptcXhmQXA3ODdBc1BUUk5kZzFIWk9aYXM4bjlvak9pMmUyWUhGTDFL?=
 =?utf-8?B?V24yaEE4VE1PV2t6ZmJrbVBiQWxab1VOcXRSSWMvOXBUVWNjZ2F4bk1QL1dW?=
 =?utf-8?B?UFV0SVNsZWpBSHFIdGhNZDJVaHZoL1dLUk5HM1ZuYUwyZE9nZWlEak5oSTZx?=
 =?utf-8?B?UlVFalBFTVVTdEg4YXY0a2g0eDEzbWRYQXpkTUY3djJuNUpEUHBlZmpMS0pu?=
 =?utf-8?B?KzZucHl1NlRSYzdlM2Vnd0pVaFFjWHVRc1ZLeXhubmpaOHc5UHRkalEyTUMr?=
 =?utf-8?B?aytvbWtrQ3BGdXhFYytDY2FZV2JDSlE1aTJsa2VlR0tTS3ZlMFhLRkJDcjk1?=
 =?utf-8?B?Z1dZa0NRa2RyOGsyS3M1STByeUZ5NGxZOGZjeENBVXNBTExzQ3AvdWFFS25z?=
 =?utf-8?B?ajhJeWVBU2ZHREF3T20yMFdkM2hjM3EvdklIaDRscUVhME5IeWJtbVdDREpU?=
 =?utf-8?B?eTFoWVpESmpMMWZsOUpYMGppb1hoNEpJU1lrNWhMbzV2SXlCQXVnRlpDU2lv?=
 =?utf-8?B?ZUk5MW5vM2hUeDlCWVFSd3NLcVhLYU9xbW9raCtmNUhiY0JwNVlEaDc2VDdi?=
 =?utf-8?B?eEZPd09IVGMreDU3YTNYbUE5WFRtRkwwRE1OMjNYRHBYd3dnQ2wxUGdPaWs5?=
 =?utf-8?B?aXlUK3ZwMUgvVk9EYTJNMkgzcDcwSGRWOFFDYldsMlRINVl3SFhRRjZjeXJz?=
 =?utf-8?B?Snp6SDNQUld2alRRUUtocC9nbUY2a1NMMFZzSXpTZUNRS1Z4ZitacGc3YUNU?=
 =?utf-8?B?bzgycGpTOG5ya0RDM01vSjg3bHI1RHBWNVNYTFpVdFhibkZOL3pnVGFFekE1?=
 =?utf-8?B?OUp6NHRWVEpJWkJnbks0OFlXYlpDYzBEMjJHZGRJZXBlVUpQZHM5M29XVXkw?=
 =?utf-8?B?b2ZnZEU3YmI5SXJkUU13L00rNVJrcEJ4UGFBSjQzV004N3RJM1N6dHlWdXNj?=
 =?utf-8?B?M29QdnZTTDRhZmY0NnRzaWp1bXM3ZW1qSTZxNnZZOGU4ZGNsU2hQQTA2cFY0?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <346C94E99313924391C027B2FCC5D7AB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6e43e5-8d8e-42a9-ee59-08da86af0332
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 15:32:25.7258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NR/Y4dXj1JT295mdHTITukcpmkbY8XS8O+AKS1BWun1VTvHHZ8jTyE3ixldXCGYY/X5y4ynAe4IZnZyrWi7n8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1301MB1969
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA4LTI1IGF0IDE2OjAxICswMTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gV2VkLCBBdWcgMjQsIDIwMjIgYXQgMDU6NDM6MzZQTSArMDAwMCwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMi0wOC0yNCBhdCAxNzo1MyArMDEwMCwgTWF0dGhl
dyBXaWxjb3ggd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEF1ZyAyNCwgMjAyMiBhdCAwNDoyNzowNFBN
ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+IFJpZ2h0IG5vdywgSSBzZWUg
bGltaXRlZCB2YWx1ZSBpbiBhZGRpbmcgbXVsdGlwYWdlIGZvbGlvcyB0bw0KPiA+ID4gPiBORlMu
DQo+ID4gPiA+IA0KPiA+ID4gPiBXaGlsZSBiYXNpYyBORlN2NCBkb2VzIGFsbG93IHlvdSB0byBw
cmV0ZW5kIHRoZXJlIGlzIGENCj4gPiA+ID4gZnVuZGFtZW50YWwNCj4gPiA+ID4gdW5kZXJseWlu
ZyBibG9jayBzaXplLCBwTkZTIGhhcyBjaGFuZ2VkIGFsbCB0aGF0LCBhbmQgd2UgaGF2ZQ0KPiA+
ID4gPiBoYWQNCj4gPiA+ID4gdG8NCj4gPiA+ID4gZW5naW5lZXIgc3VwcG9ydCBmb3IgZGV0ZXJt
aW5pbmcgdGhlIEkvTyBibG9jayBzaXplIG9uIHRoZSBmbHksDQo+ID4gPiA+IGFuZA0KPiA+ID4g
PiBidWlsZGluZyB0aGUgUlBDIHJlcXVlc3RzIGFjY29yZGluZ2x5LiBDbGllbnQgc2lkZSBtaXJy
b3JpbmcNCj4gPiA+ID4ganVzdA0KPiA+ID4gPiBhZGRzDQo+ID4gPiA+IHRvIHRoZSBmdW4uDQo+
ID4gPiA+IA0KPiA+ID4gPiBBcyBJIHNlZSBpdCwgdGhlIG9ubHkgdmFsdWUgdGhhdCBtdWx0aXBh
Z2UgZm9saW9zIG1pZ2h0IGJyaW5nDQo+ID4gPiA+IHRvDQo+ID4gPiA+IE5GUw0KPiA+ID4gPiB3
b3VsZCBiZSBzbWFsbGVyIHBhZ2UgY2FjaGUgbWFuYWdlbWVudCBvdmVyaGVhZCB3aGVuIGRlYWxp
bmcNCj4gPiA+ID4gd2l0aA0KPiA+ID4gPiBsYXJnZQ0KPiA+ID4gPiBmaWxlcy4NCj4gPiA+IA0K
PiA+ID4gWWVzLCBidXQgdGhhdCdzIGEgUmVhbGx5IEJpZyBEZWFsLsKgIE1hY2hpbmVzIHdpdGgg
YSBsb3Qgb2YgbWVtb3J5DQo+ID4gPiBlbmQNCj4gPiA+IHVwIHdpdGggdmVyeSBsb25nIExSVSBs
aXN0cy7CoCBXZSBjYW4ndCBhZmZvcmQgdGhlIG92ZXJoZWFkIG9mDQo+ID4gPiBtYW5hZ2luZw0K
PiA+ID4gbWVtb3J5IGluIDRrQiBjaHVua3MgYW55IG1vcmUuwqAgKEkgZG9uJ3Qgd2FudCB0byBk
d2VsbCBvbiB0aGlzDQo+ID4gPiBwb2ludA0KPiA+ID4gdG9vDQo+ID4gPiBtdWNoOyBJJ3ZlIHJ1
biB0aGUgbnVtYmVycyBiZWZvcmUgYW5kIGNhbiBkbyBzbyBhZ2FpbiBpZiB5b3Ugd2FudA0KPiA+
ID4gbWUNCj4gPiA+IHRvDQo+ID4gPiBnbyBpbnRvIG1vcmUgZGV0YWlscykuDQo+ID4gPiANCj4g
PiA+IEJleW9uZCB0aGF0LCBmaWxlc3lzdGVtcyBoYXZlIGEgbG90IG9mIGludGVyYWN0aW9ucyB3
aXRoIHRoZSBwYWdlDQo+ID4gPiBjYWNoZQ0KPiA+ID4gdG9kYXkuwqAgV2hlbiBJIHN0YXJ0ZWQg
bG9va2luZyBhdCB0aGlzLCBJIHRob3VnaHQgZmlsZXN5c3RlbQ0KPiA+ID4gcGVvcGxlDQo+ID4g
PiBhbGwNCj4gPiA+IGhhZCBhIGRlZXAgdW5kZXJzdGFuZGluZyBvZiBob3cgdGhlIHBhZ2UgY2Fj
aGUgd29ya2VkLsKgIE5vdyBJDQo+ID4gPiByZWFsaXNlDQo+ID4gPiBldmVyeW9uZSdzIGFzIGNs
dWVsZXNzIGFzIEkgYW0uwqAgVGhlIHJlYWwgYmVuZWZpdCBJIHNlZSB0bw0KPiA+ID4gcHJvamVj
dHMNCj4gPiA+IGxpa2UNCj4gPiA+IGlvbWFwL25ldGZzIGlzIHRoYXQgdGhleSBpbnN1bGF0ZSBm
aWxlc3lzdGVtcyBmcm9tIGhhdmluZyB0byBkZWFsDQo+ID4gPiB3aXRoDQo+ID4gPiB0aGUgcGFn
ZSBjYWNoZS7CoCBBbGwgdGhlIGludGVyYWN0aW9ucyBhcmUgaW4gdHdvIG9yIHRocmVlIHBsYWNl
cw0KPiA+ID4gYW5kDQo+ID4gPiB3ZQ0KPiA+ID4gY2FuIHJlZmFjdG9yIHdpdGhvdXQgaGF2aW5n
IHRvIHRhbGsgdG8gdGhlIG93bmVycyBvZiA1MCsNCj4gPiA+IGZpbGVzeXN0ZW1zLg0KPiA+ID4g
DQo+ID4gPiBJdCBhbHNvIGdpdmVzIHVzIGEgY2hhbmNlIHRvIHJlLWV4YW1pbmUgc29tZSBvZiB0
aGUgYXNzdW1wdGlvbnMNCj4gPiA+IHRoYXQNCj4gPiA+IHdlIGhhdmUgbWFkZSBvdmVyIHRoZSB5
ZWFycyBhYm91dCBob3cgZmlsZXN5c3RlbXMgYW5kIHBhZ2UgY2FjaGUNCj4gPiA+IHNob3VsZA0K
PiA+ID4gYmUgaW50ZXJhY3RpbmcuwqAgV2UndmUgZml4ZWQgYSBmYWlyIGZldyBidWdzIGluIHJl
Y2VudCB5ZWFycyB0aGF0DQo+ID4gPiBjYW1lDQo+ID4gPiBhYm91dCBiZWNhdXNlIGZpbGVzeXN0
ZW0gcGVvcGxlIGRvbid0IHRlbmQgdG8gaGF2ZSBkZWVwIGtub3dsZWRnZQ0KPiA+ID4gb2YNCj4g
PiA+IG1tDQo+ID4gPiBpbnRlcm5hbHMgKGFuZCB0aGV5IHNob3VsZG4ndCBuZWVkIHRvISkNCj4g
PiA+IA0KPiA+ID4gSSBkb24ndCBrbm93IHRoYXQgbmV0ZnMgaGFzIHRoZSBwZXJmZWN0IGludGVy
ZmFjZSB0byBiZSB1c2VkIGZvcg0KPiA+ID4gbmZzLg0KPiA+ID4gQnV0IHRoYXQgdG9vIGNhbiBi
ZSBjaGFuZ2VkIHRvIG1ha2UgaXQgd29yayBiZXR0ZXIgZm9yIHlvdXINCj4gPiA+IG5lZWRzLg0K
PiA+IA0KPiA+IElmIHRoZSBWTSBmb2xrcyBuZWVkIGl0LCB0aGVuIGFkZGluZyBzdXBwb3J0IGZv
ciBtdWx0aS1wYWdlIGZvbGlvcw0KPiA+IGlzIGENCj4gPiBtdWNoIHNtYWxsZXIgc2NvcGUgdGhh
biB3aGF0IERhdmlkIHdhcyBkZXNjcmliaW5nLiBJdCBjYW4gYmUgZG9uZQ0KPiA+IHdpdGhvdXQg
dG9vIG11Y2ggc3VyZ2VyeSB0byB0aGUgZXhpc3RpbmcgTkZTIEkvTyBzdGFjay4gV2UgYWxyZWFk
eQ0KPiA+IGhhdmUNCj4gPiBjb2RlIHRvIHN1cHBvcnQgSS9PIGJsb2NrIHNpemVzIHRoYXQgYXJl
IG11Y2ggbGVzcyB0aGFuIHRoZSBwYWdlDQo+ID4gc2l6ZSwNCj4gPiBzbyBjb252ZXJ0aW5nIHRo
YXQgdG8gYWN0IG9uIGxhcmdlciBmb2xpb3MgaXMgbm90IGEgaHVnZSBkZWFsLg0KPiA+IA0KPiA+
IFdoYXQgd291bGQgYmUgdXNlZnVsIHRoZXJlIGlzIHNvbWV0aGluZyBsaWtlIGEgcmFuZ2UgdHJl
ZSB0byBhbGxvdw0KPiA+IHVzDQo+ID4gdG8gbW92ZSBiZXlvbmQgdGhlIFBHX3VwdG9kYXRlIGJp
dCwgYW5kIGhlbHAgbWFrZSB0aGUNCj4gPiBpc19wYXJ0aWFsbHlfdXB0b2RhdGUoKSBhZGRyZXNz
X3NwYWNlX29wZXJhdGlvbiBhIGJpdCBtb3JlIHVzZWZ1bC4NCj4gPiBPdGhlcndpc2UsIHdlIGVu
ZCB1cCBoYXZpbmcgdG8gcmVhZCBpbiB0aGUgZW50aXJlIGZvbGlvLCB3aGljaCBpcw0KPiA+IHdo
YXQNCj4gPiB3ZSBkbyB0b2RheSBmb3IgcGFnZXMsIGJ1dCBjb3VsZCBnZXQgb25lcm91cyB3aXRo
IGxhcmdlIGZvbGlvcyB3aGVuDQo+ID4gZG9pbmcgZmlsZSByYW5kb20gYWNjZXNzLg0KPiANCj4g
VGhpcyBpcyBpbnRlcmVzdGluZyBiZWNhdXNlIG5vYm9keSdzIGFza2VkIGZvciB0aGlzIGJlZm9y
ZS7CoCBJJ3ZlIGhhZA0KPiBzaW1pbGFyIGRpc2N1c3Npb25zIGFyb3VuZCBkaXJ0eSBkYXRhIHRy
YWNraW5nLCBidXQgbm90IGFyb3VuZA0KPiB1cHRvZGF0ZS4NCj4gUmFuZG9tIHNtYWxsIHJlYWRz
IHNob3VsZG4ndCBiZSBhIHRlcnJpYmxlIHByb2JsZW07IGlmIHRoZXkgdHJ1bHkgYXJlDQo+IHJh
bmRvbSwgd2UgYmVoYXZlIGFzIHRvZGF5LCBhbGxvY2F0aW5nIHNpbmdsZSBwYWdlcywgcmVhZGlu
ZyB0aGUNCj4gZW50aXJlDQo+IHBhZ2UgZnJvbSB0aGUgc2VydmVyIGFuZCBzZXR0aW5nIGl0IHVw
dG9kYXRlLsKgIElmIHRoZSByZWFkYWhlYWQgY29kZQ0KPiBkZXRlY3RzIGEgY29udGlndW91cyBs
YXJnZSByZWFkLCB3ZSBpbmNyZWFzZSB0aGUgYWxsb2NhdGlvbiBzaXplIHRvDQo+IG1hdGNoLCBi
dXQgYWdhaW4gd2UgYWx3YXlzIHJlYWQgdGhlIGVudGlyZSBmb2xpbyBmcm9tIHRoZSBzZXJ2ZXIg
YW5kDQo+IG1hcmsgaXQgdXB0b2RhdGUuDQo+IA0KPiBBcyBmYXIgYXMgSSBrbm93LCB0aGUgb25s
eSB0aW1lIHdlIGNyZWF0ZSAhdXB0b2RhdGUgZm9saW9zIGluIHRoZQ0KPiBwYWdlDQo+IGNhY2hl
IGlzIHBhcnRpYWwgd3JpdGVzIHRvIGEgZm9saW8gd2hpY2ggaGFzIG5vdCBiZWVuIHByZXZpb3Vz
bHkNCj4gcmVhZC4NCj4gT2J2aW91c2x5LCB0aG9zZSBieXRlcyBzdGFydCBvdXQgZGlydHkgYW5k
IGFyZSB0cmFja2VkIHRocm91Z2ggdGhlDQo+IGV4aXN0aW5nIGRpcnR5IG1lY2hhbmlzbSwgYnV0
IG9uY2UgdGhleSd2ZSBiZWVuIHdyaXR0ZW4gYmFjaywgd2UgaGF2ZQ0KPiB0aHJlZSBjaG9pY2Vz
IHRoYXQgSSBjYW4gc2VlOg0KPiANCj4gMS4gdHJhbnNpdGlvbiB0aG9zZSBieXRlcyB0byBhIG1l
Y2hhbmlzbSB3aGljaCByZWNvcmRzIHRoZXkncmUNCj4gdXB0b2RhdGUNCj4gMi4gZGlzY2FyZCB0
aGF0IGluZm9ybWF0aW9uIGFuZCByZS1yZWFkIHRoZSBlbnRpcmUgZm9saW8gZnJvbSB0aGUNCj4g
c2VydmVyDQo+IMKgwqAgaWYgYW55IGJ5dGVzIGFyZSBzdWJzZXF1ZW50bHkgcmVhZA0KPiAzLiBy
ZWFkIHRoZSBvdGhlciBieXRlcyBpbiB0aGF0IGZvbGlvIGZyb20gdGhlIHNlcnZlciBhbmQgbWFy
ayB0aGUNCj4gwqDCoCBlbnRpcmUgZm9saW8gdXB0b2RhdGUNCj4gDQo+IFdlIGhhdmUgYSBtaXh0
dXJlIG9mIHRob3NlIG9wdGlvbnMgaW1wbGVtZW50ZWQgaW4gZGlmZmVyZW50DQo+IGZpbGVzeXN0
ZW1zDQo+IHRvZGF5LsKgIGlvbWFwIHJlY29yZHMgd2hldGhlciBhIGJsb2NrIGlzIHVwdG9kYXRl
IG9yIG5vdCBhbmQgdHJlYXRzDQo+IGV2ZXJ5IHVwdG9kYXRlIGJsb2NrIGFzIGRpcnR5IGlmIGFu
eSBibG9jayBpbiB0aGUgZm9saW8gaXMgZGlydHkuDQo+IGJ1ZmZlcl9oZWFkIGhhcyB0d28gYml0
cyBmb3IgZWFjaCBibG9jaywgc2VwYXJhdGVseSByZWNvcmRpbmcgd2hldGhlcg0KPiBpdCdzIGRp
cnR5IGFuZC9vciB1cHRvZGF0ZS7CoCBBRlMgdHJhY2tzIG9uZSBkaXJ0eSByYW5nZSBwZXIgZm9s
aW8sDQo+IGJ1dA0KPiBpdCBmaXJzdCBicmluZ3MgdGhlIGZvbGlvIHVwdG9kYXRlIGJ5IHJlYWRp
bmcgaXQgZnJvbSB0aGUgc2VydmVyDQo+IGJlZm9yZQ0KPiBvdmVyd3JpdGluZyBpdCAoSSBzdXBw
b3NlIHRoYXQncyBhIGZvdXJ0aCBvcHRpb24pLg0KPiANCg0KSSdtIG5vdCB0YWxraW5nIGFib3V0
IHRoZSB0cmFuc2l0aW9uIG9mIGRpcnR5LT5jbGVhbi4gV2UgYWxyZWFkeSBkZWFsDQp3aXRoIHRo
YXQuIEknbSB0YWxraW5nIGFib3V0IHN1cHBvcnRpbmcgbGFyZ2UgZm9saW9zIG9uIHJlYWQtbWFp
bmx5DQp3b3JrbG9hZHMuDQoNCk5GUyBjYW4gaGFwcGlseSBzdXBwb3J0IDFNQiBzaXplZCBmb2xp
b3MsIG9yIGV2ZW4gbGFyZ2VyIHRoYW4gdGhhdCBpZg0KdGhlcmUgaXMgYSBjb21wZWxsaW5nIHJl
YXNvbiB0byBkbyBzby4NCg0KSG93ZXZlciwgaGF2aW5nIHRvIHJlYWQgaW4gdGhlIGVudGlyZSBm
b2xpbyBjb250ZW50cyBpZiB0aGUgdXNlciBpcw0KanVzdCBhc2tpbmcgZm9yIGEgZmV3IGJ5dGVz
IG9uIGEgZGF0YWJhc2Utc3R5bGUgcmFuZG9tIHJlYWQgd29ya2xvYWQNCmNhbiBxdWlja2x5IGdl
dCBvbmVyb3VzLg0KV2hpbGUgYSBsb3Qgb2YgTkZTIHNlcnZlcnMgY2FuIGRvIDFNQiByZWFkcyBp
biBvbmUgUlBDIGNhbGwsIHRoZXJlIGFyZQ0Kc3RpbGwgbWFueSBvdXQgdGhlcmUgdGhhdCBjYW4n
dC4gRm9yIHRob3NlIHNlcnZlcnMsIHdlJ2QgaGF2ZSB0byBmYWxsDQpiYWNrIHRvIGlzc3Vpbmcg
bXVsdGlwbGUgcmVhZCBSUEMgY2FsbHMgaW4gcGFyYWxsZWwgKHdoaWNoIGlzIHdoYXQgd2UNCmRv
IHRvZGF5IGlmIHRoZSB1c2VyIHNldHMgYW4gcnNpemUgPCBQQUdFX1NJWkUpLiBUaGlzIGxlYWRz
IHRvDQp1bm5lY2Vzc2FyeSBsb2FkIG9uIHRoZSBzZXJ2ZXIsIHdoaWNoIGhhcyB0byBkZWFsIHdp
dGggbXVsdGlwbGUgUlBDDQpjYWxscyBmb3IgZGF0YSB0aGF0IHdvbid0IGJlIHVzZWQuDQpUaGUg
b3RoZXIgcG9pbnQgaXMgdGhhdCBpZiB5b3VyIG5ldHdvcmsgYmFuZHdpZHRoIGlzIGxpbWl0ZWQs
IHRoZXJlIGlzDQp2YWx1ZSBpbiBhdm9pZGluZyByZWFkcyBmb3IgZGF0YSB0aGF0IGlzbid0IGdv
aW5nIHRvIGJlIHVzZWQsIHdoaWNoIGlzDQp3aHkgd2UgY2hhbmdlZCB0aGUgTkZTIHJlYWRhaGVh
ZCBiZWhhdmlvdXIgdG8gYmUgbGVzcyBhZ2dyZXNzaXZlIHRoYW4NCml0IHVzZWQgdG8gYmUuDQoN
ClRoaXMgaXMgd2h5IEknbSBzdWdnZXN0aW5nIHRoYXQgaWYgeW91IHJlYWxseSB3YW50IHRvIGN1
dCBkb3duIHRoZSBMUlUNCnRhYmxlIHNpemUsIHlvdSdsbCB3YW50IGZpbmVyIGdyYWluZWQgcGFn
ZSB1cCB0byBkYXRlIHRyYWNraW5nIHRoYW4gdGhlDQpmb2xpby4gSXQncyBub3Qgc28gbXVjaCBm
b3IgdGhlIGNhc2Ugb2Ygd3JpdGVzIGFzIGl0IGlzIGZvciB0aGUgcmVhZC0NCm1vc3RseSB3b3Jr
bG9hZHMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
