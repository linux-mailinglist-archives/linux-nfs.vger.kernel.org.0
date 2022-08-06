Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA6A58B369
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Aug 2022 04:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiHFC1C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Aug 2022 22:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiHFC1B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Aug 2022 22:27:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3271D286F9
        for <linux-nfs@vger.kernel.org>; Fri,  5 Aug 2022 19:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGdODI/hCgz+b0Sn9Y99bAsmLeiKVVsFUlD4vkUzi11o4tLO+Dpv9CdFG0bSNUPX90D7fFl5lTyls2gXVx4nn4IyPiChOk9BakCb2KGZGiF94UF3UXQcMYMRSRF/v+scQIMwKfp+OnTCRrp6y1DCP//6ShhaoT87hyRIb8bL3E0bkE38DXJbBs0soRU9WHRJe6u5pLqiCOcc2PQ9mTsRZjbj7P0xsQbj9iyrXcsbXBQ5gPFfdWaobcdZ7jpGnXA+VNo01YBQcx9QdDmD6sWNvPha2ToExQMHm16F6FnQOCpBlU+RdowUHJH4Ps1h+0p08DoX+NZUkeWtEusucVcqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUTwz/CcUutdXQJc/7D9emtaXBxpDK2L4LmIbSjU/O4=;
 b=DjvayKjPcYOGuhf0VRYnPiu0X5Umh4BSd1HKfLrUlZBUeGS5xpBQdNppOg/Qc1iuDOLwfaXqySxy/EQHgvrgJJcoTq12TYqsP054jOEA3FxLz6gMitQ/5M8mcrgPtl+hta5fQz/Y6MYwcLA2p7TnVnXgnqj8FUXJhCBP4tUV6zkZ5AFZtCk6195WA0MBGq9ASCYS9nZ5XwsUzkOOwaAHsf9P7Uck1B80Qh3JP3HWXTwDbx1T5zJ+0WlwUGKhAg+bhTZ7JJzi98PvehE856ceRXuCUQK6AO7I0LrSu9zKqP6MfJKY0EhxBev2ypnn4sU8YeZbAGvDePqWgosYxMG8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUTwz/CcUutdXQJc/7D9emtaXBxpDK2L4LmIbSjU/O4=;
 b=DsyE5zGyT1zWHF6YVGu9bhzOlIywm/dG5E3lWczI3smjtc8S6yK5kGf+i6iTH85W4/Pzttq0n0qUIlroFDqTXYMJtArz250NXkRpKMkReNHOdGMBHVpMbGW+t0R/gpX6LrrJtzFxW19A7NZpKyfuFt38NaRQxOloxT1g5n3z7MQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB5431.namprd13.prod.outlook.com (2603:10b6:510:139::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sat, 6 Aug
 2022 02:26:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035%7]) with mapi id 15.20.5504.016; Sat, 6 Aug 2022
 02:26:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "j.kasiak@gmail.com" <j.kasiak@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about nlmclnt_lock
Thread-Topic: Question about nlmclnt_lock
Thread-Index: AQHYqSGeQlPIFd3LC0yt3raS2rNh7q2hJbkA
Date:   Sat, 6 Aug 2022 02:26:55 +0000
Message-ID: <8ae13798a15c69cf16272579f49768ec92484584.camel@hammerspace.com>
References: <CAD15GZf0FtU81hwQ+brhnt+sv895=TpAuz-YrMtjfx__FJ28Gg@mail.gmail.com>
In-Reply-To: <CAD15GZf0FtU81hwQ+brhnt+sv895=TpAuz-YrMtjfx__FJ28Gg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dc7f8cd-8f65-44ab-033e-08da775321ba
x-ms-traffictypediagnostic: PH7PR13MB5431:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yivroieCwPpca6aToH6ciX/qsfuuIzrdPys8t27BwAEkG7gVlDPVJUvo39nx3RNT/nlUacv2EvsQGjahtnXFcl3pnfCqxdTnMiAwAxyyiO4VI4QKgqhzNkVJkxCA3oZ9ko18+E98tpYZbFQPquvQzItfXo/2J0a/kjvRl89WWsXaxQn+q/nOUv/bdZ0R4Kfn3f0R7I+RI8KTBdMieupdJExslBQp21JAr99ehnVfCkjfCKxkoaRb3DlcMwbDIw7lCDLJcBr32NpvzX9WuniIPKQlWk3jaLFtB3oFulJCLwKYVv1AkSASvhQ3vmBqzBuNR+SjE2tgQXfe17XMBKxihsYV8Q5X84R3W0cp0H8RJuN2+bOhyUfiah+VYcXqJMjpj0EujsTKOJn+iQ+o69HN22ognC9Ah0EE4G1piUDX51N9c+zGUApZt9rwqAtPzJFUZbeaItTFBb2FMks21e2T4dtzhYdOta7H5+vZpiPvFdSj2lmDdE33VtgZ9n9rTFVbQ2dfbH3xe/fPcSXqD5GGEBNdn0MnYJMvPp4BidFr56KVh47Kcaek3zWFYOsFOb4tCH1CfIu8LBvIbMW1Q2MfOBGD1lq4GlAe0ncU4Xw4ss0l3QKSgA9xHdC8Cqx8MpUBl+UcT/EJCmdz9kZ4nBchVeFrY+K4j7tq3RGNrXTLMd8+JD9/tSDApJsO2rUo2a6EFJy+N2WLwi77tY7O8VpIXZ0mMcAPBJcigunwNr+RlQ7PSAYHbNsSao61dGNWTEgkC2E3ItsSnpfZlET3QydyFe2KqOU8TGUjCYoNpbkbErGHsiyXMfKRm2T8Dr3UDZYKCJa609qg/8jtqOsnTJX9YQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(366004)(39840400004)(396003)(6506007)(71200400001)(38070700005)(7116003)(66946007)(6512007)(122000001)(66446008)(8676002)(64756008)(66556008)(966005)(26005)(76116006)(316002)(6486002)(86362001)(110136005)(41300700001)(478600001)(38100700002)(186003)(2906002)(83380400001)(66476007)(8936002)(36756003)(5660300002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEpWMWpSRGJKcitRdklHVjM0YkpqejZZYXJ2MWtkSVRpZTFlazlycmVmamhG?=
 =?utf-8?B?NDFYYm9FUmlJK3VZVC9WQzUwWFNkL0xmaW02ZWdDRU9BNGNqSWhjNi9DUmFk?=
 =?utf-8?B?d09IZG1GR3BsWXk3Q2lLN1E4Z0k3MHc5cUxMQ2hxNEowMHJUN1ZnUjlML0Fh?=
 =?utf-8?B?eE9qelhOUS9zckZaRUdEQ1N5di85bDBPSGdXZFpZVS9ML01UMVFkcGU4QTBN?=
 =?utf-8?B?QlZ4ZnJTM0JZc0U5VjcwWXhvKzBwNVdHWUtGVXJNY2lhZ2QxOEFNamxJVEY0?=
 =?utf-8?B?R0V5bWcxaWpZUkt0SnlvTnF3cnIvSVlJaXRjM2lvL0F4UjBsU3FRdGdJdlk4?=
 =?utf-8?B?ZkNVSzB3R2pXa2o4Y09yNmVLKzJTdkducTR1QUJyWGR5SG43K1hiczJUWkgx?=
 =?utf-8?B?OFZXd0c1cEV6allGSTgxTmlXR2ErdktVSjJxUEFuS25LSDk0NzNTV1o1ek15?=
 =?utf-8?B?RnVkZkU2N3g2U0g3TEZoTGVLakd0WFgyZjJUYXl3VURweWRzZExQZUlHUVlr?=
 =?utf-8?B?QmVVRS9mRDRVb3N5NEUwRGJnSGU1ZzhlaTNMNk9YbkdXWnI5SXRwdmlWVjFx?=
 =?utf-8?B?YURNd0o1R3cxWDg4MFFkbWRyOVgyRnB1YjNOU1ErVlY4RnlpQXBQTXNCRENQ?=
 =?utf-8?B?emdLUkE1ZHI2MWlkTGx5TG1qdURIWmpwS3U1cFozWktMalVObWR1bHlkNXBU?=
 =?utf-8?B?VEdVLzE5TE5ham9mMFNySWxscFNFdVlSWU9EOFNNNHNPUlRMNGs4ZDI2bzFM?=
 =?utf-8?B?eHV5eW5JNDF3bS9tQllSSUZZbGUxWCtwaHo1OHZvYld2eVppcDlPY0NkRENC?=
 =?utf-8?B?QkY5VzBqRVNOUWZNOEJPN2VMSzhkU2t1ODRrOThOaGRDSUNQQjYrQkQ3cGg0?=
 =?utf-8?B?YzF1V0VyNXVOWk9OL2NKdE8vcEljSDNtbjErWWxOWmhMb2lldzY2eldWdVBI?=
 =?utf-8?B?aElLaDNIR0todmZFZ3ExU3FBUkx1SnBzNkdmWGpHSVBhenowM2c4dGhMYytJ?=
 =?utf-8?B?eDlMRDQwbDF5cmhwd09MbDY3R2x3Z2NkT2V5cXNwbUluY2IvZEx2ZVlNYk94?=
 =?utf-8?B?U0s2YVF1L3FnbkxLdkUxc0R1WnR4N0F1UzdOenU1dGZkZHlIZVpmd2pLMVdG?=
 =?utf-8?B?L2hiZ1lYaTlJK0ZsZ244a2I2OExlcklGTzlHZ2cxOHNmOXN1K3RoWGR0d0Ni?=
 =?utf-8?B?OXl6Vm9jazdzb01pcFFiRGptdFREcFAxOVFFOU5mVEVkVmcxR25qL09zbjlk?=
 =?utf-8?B?NDhOUlorZUNPS2UvemkyQkNMYmRnTGNBZjlGMmxCQzJsWmswdyt5NDRGN1J3?=
 =?utf-8?B?MlMxaEZQR05KL1BPanJIQ2ZDbFFRZllhSVUyMkdUWTJvUzJ3NVNaR3k0YXJ0?=
 =?utf-8?B?VnR5TU1IRUt1ZjVkQmZiZDltcmMvY1dEM0RNOUN4UlY4Y2VRcGhzd3p5Mm1R?=
 =?utf-8?B?OU1Mc1FoaUdzRk9oTnpqUHZPU1JyQVpIa3F3bTZrcmczajYyYWdvSGJIbXp0?=
 =?utf-8?B?ZEFPT2lxVTdaRVZiaFFFTzFkZHlPSTVhVk4yMFBIb21tam82UDRqK2lkcy9v?=
 =?utf-8?B?Kyt5RmF4dkFUT0Z5azd5NDBHZi9SdEo0RlZsbFhxU3duRU4yK0RzM2tMSHRo?=
 =?utf-8?B?ZkZ5d2swMlV1QU1TRnBpVWN3bUZ1TnhRc3AyNnpBZ3pBK2VKQVd6djJTMXFX?=
 =?utf-8?B?NjlNZHhsVHR6TWF4bXlQZ0lNbnhSWXc2ZUpUS1hsV3FJZnh5NnMyREpNOXph?=
 =?utf-8?B?RFFiVk9kcXRjTUhUUnVDZVZkUHVRNmlTZ0tVaFBwT2RRbzFEV09JbGRQajNw?=
 =?utf-8?B?c2JxaklEYWVCTFdna0JSUWZPZG90ZndQNmtIL0ZoQkZvVTVQczFaRWpGZHhZ?=
 =?utf-8?B?N0drK3NlQ05kVkxFeE9mNE1FMHNxRi9xMHE4YnQvUU1pS0ZVOXdiRVBqbFhP?=
 =?utf-8?B?YTlOSHdhdU5YMnJINW5oUHlRcGd2Q2hZME45VHhzckcrTW0xN091bFZodUI1?=
 =?utf-8?B?SVdEL0ZrUGtodFNrM0tyV0FUa2cwNnBFMDlla2tCbWovWVhCbDd0RWhEZkEv?=
 =?utf-8?B?QUJXWURVNDE4b1lxUFdxeHkvOU9WM2dEMWlpeGYzMUFnMzVQVlh0ZHlUcFpn?=
 =?utf-8?B?MTJaWFJadjR2ZFBCRitnaDN5b0txQ21UUWREWXFwaTJrNW1vWU5xemhhaUR0?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0FF1CD4E2C74B4792F725E89F739C74@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc7f8cd-8f65-44ab-033e-08da775321ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2022 02:26:55.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9E+4bcYPJ4ieWu/c76w0xs0jnMH+IK9eVFbLa1vzgR79Cdoe0BZKpdQQlTBR4MPJkUJ5m5lSNSQ5AOVoByd4jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTA1IGF0IDE5OjE3IC0wNDAwLCBKYW4gS2FzaWFrIHdyb3RlOg0KPiBI
aSwNCj4gDQo+IEkgd2FzIGxvb2tpbmcgYXQgdGhlIGNvZGUgZm9yIG5sbWNsbnRfbG9jayBhbmQg
d2FudGVkIHRvIGFzayBhDQo+IHF1ZXN0aW9uIGFib3V0IGhvdyB0aGUgTGludXgga2VybmVsIGNs
aWVudCBhbmQgdGhlIE5MTSA0IHByb3RvY29sDQo+IGhhbmRsZSBzb21lIGVycm9ycyBhcm91bmQg
Y2VydGFpbiBlZGdlIGNhc2VzLg0KPiANCj4gU3BlY2lmaWNhbGx5LCBJIHRoaW5rIHRoZXJlIGlz
IGEgcmFjZSBjb25kaXRpb24gYXJvdW5kIHR3byB0aHJlYWRzIG9mDQo+IHRoZSBzYW1lIHByb2dy
YW0gYWNxdWlyaW5nIGEgbG9jaywgb25lIG9mIHRoZSB0aHJlYWRzIGJlaW5nDQo+IGludGVycnVw
dGVkLCBhbmQgdGhlIE5GUyBjbGllbnQgc2VuZGluZyBhbiB1bmxvY2sgd2hlbiBub25lIG9mIHRo
ZQ0KPiBwcm9ncmFtIHRocmVhZHMgY2FsbGVkIHVubG9jay4NCj4gDQo+IE9uIE5GUyBzZXJ2ZXIg
bWFjaGluZSBTOg0KPiB0aGVyZSBleGlzdHMgYW4gdW5sb2NrZWQgZmlsZSBGDQo+IA0KPiBPbiBO
RlMgY2xpZW50IG1hY2hpbmUgQzoNCj4gaW4gcHJvZ3JhbSBQOg0KPiB0aHJlYWQgMSB0cmllcyB0
byBsb2NrKEYpIHdpdGggZmQgQQ0KPiB0aHJlYWQgMiB0cmllcyB0byBsb2NrKEYpIHdpdGggZmQg
Qg0KPiANCj4gVGhlIExpbnV4IGNsaWVudCB3aWxsIGlzc3VlIHR3byBOTE1fTE9DSyBjYWxscyB3
aXRoIHRoZSBzYW1lIHN2aWQgYW5kDQo+IHNhbWUgcmFuZ2UsIGJlY2F1c2UgaXQgdXNlcyB0aGUg
cHJvZ3JhbSBpZCB0byBtYXAgdG8gYW4gc3ZpZC4NCj4gDQo+IEZvciB3aGF0ZXZlciByZWFzb24s
IGFzc3VtZSB0aGUgY29ubmVjdGlvbiBpcyBicm9rZW4gKGNhYmxlIGdldHMNCj4gcHVsbGVkIGV0
Yy4uLikNCj4gYW5kIGBzdGF0dXMgPSBubG1jbG50X2NhbGwoY3JlZCwgcmVxLCBOTE1QUk9DX0xP
Q0spO2AgZmFpbHMuDQo+IA0KPiBUaGUgTGludXggY2xpZW50IHdpbGwgcmV0cnkgdGhlIHJlcXVl
c3QsIGJ1dCBhdCBzb21lIHBvaW50IHRocmVhZCAxDQo+IHJlY2VpdmVzIGEgc2lnbmFsIGFuZCBu
bG1jbG50X2xvY2sgYnJlYWtzIG91dCBvZiBpdHMgbG9vcC4gQmVjYXVzZQ0KPiB0aGUNCj4gTGlu
dXggY2xpZW50IHJlcXVlc3QgZmFpbGVkLCBpdCB3aWxsIGZhbGwgdGhyb3VnaCBhbmQgZ28gdG8g
dGhlDQo+IG91dF91bmxvY2sgbGFiZWwsIHdoZXJlIGl0IHdpbGwgd2FudCB0byBzZW5kIGFuIHVu
bG9jayByZXF1ZXN0Lg0KPiANCj4gQXNzdW1lIHRoYXQgYXQgc29tZSBwb2ludCB0aGUgY29ubmVj
dGlvbiBpcyByZWVzdGFibGlzaGVkLg0KPiANCj4gVGhlIExpbnV4IGtlcm5lbCBjbGllbnQgbm93
IGhhcyB0d28gb3V0c3RhbmRpbmcgbG9jayByZXF1ZXN0cyB0byBzZW5kDQo+IHRvIHRoZSByZW1v
dGUgc2VydmVyOiBvbmUgZm9yIGEgbG9jayB0aGF0IHRocmVhZCAyIGlzIHN0aWxsIHRyeWluZyB0
bw0KPiBhY3F1aXJlLCBhbmQgb25lIGZvciBhbiB1bmxvY2sgb2YgdGhyZWFkIDEgdGhhdCBmYWls
ZWQgYW5kIHdhcw0KPiBpbnRlcnJ1cHRlZC4NCj4gDQo+IEknbSB3b3JyaWVkIHRoYXQgdGhlIExp
bnV4IGNsaWVudCBtYXkgZmlyc3Qgc2VuZCB0aGUgbG9jayByZXF1ZXN0LA0KPiBhbmQNCj4gdGVs
bCB0aHJlYWQgMiB0aGF0IGl0IGFjcXVpcmVkIHRoZSBsb2NrLCBhbmQgdGhlbiBzZW5kIGFuIHVu
bG9jaw0KPiByZXF1ZXN0IGZyb20gdGhlIGNhbmNlbGxlZCB0aHJlYWQgMSByZXF1ZXN0Lg0KPiAN
Cj4gVGhlIHNlcnZlciB3aWxsIHN1Y2Nlc3NmdWxseSBwcm9jZXNzIGJvdGggcmVxdWVzdHMsIGJl
Y2F1c2UgdGhlIHN2aWQNCj4gaXMgdGhlIHNhbWUgZm9yIGJvdGgsIGFuZCB0aGUgdHJ1ZSBzZXJ2
ZXIgc2lkZSBzdGF0ZSB3aWxsIGJlIHRoYXQgdGhlDQo+IGZpbGUgaXMgdW5sb2NrZWQuDQo+IA0K
PiBPbmUgY2FuIHRhbGsgYWJvdXQgdGhlIHdpc2RvbSBvZiB1c2luZyBtdWx0aXBsZSB0aHJlYWRz
IHRvIGFjcXVpcmUNCj4gdGhlDQo+IHNhbWUgZmlsZSBsb2NrLCBidXQgdGhpcyBiZWhhdmlvciBp
cyB3ZWlyZCwgYmVjYXVzZSBub25lIG9mIHRoZQ0KPiB0aHJlYWRzIGNhbGxlZCB1bmxvY2suDQo+
IA0KPiBJIGhhdmUgZXhwZXJpbWVudGVkIHdpdGggcmVwcm9kdWNpbmcgdGhpcywgYnV0IGhhdmUg
bm90IGJlZW4NCj4gc3VjY2Vzc2Z1bCBpbiB0cmlnZ2VyaW5nIHRoaXMgb3JkZXJpbmcgb2YgZXZl
bnRzLg0KPiANCj4gSSd2ZSBhbHNvIGxvb2tlZCBhdCB0aGUgY29kZSBvZiBpbiBjbG50cHJvYy5j
IGFuZCBJIGRvbid0IHNlZSBhIHNwb3QNCj4gd2hlcmUgb3V0c3RhbmRpbmcgZmFpbGVkIGxvY2sv
dW5sb2NrIHJlcXVlc3RzIGFyZSBjaGVja2VkIHdoaWxlDQo+IHByb2Nlc3NpbmcgbG9jayByZXF1
ZXN0cz8NCj4gDQo+IFRoYW5rcywNCj4gLUphbg0KDQpOb2JvZHkgaGVyZSBpcyBsaWtlbHkgdG8g
d2FudCB0byB3YXN0ZSBtdWNoIHRpbWUgdHJ5aW5nIHRvICdmaXgnIHRoZQ0KTkxNIGxvY2tpbmcg
cHJvdG9jb2wuIFRoZSBwcm90b2NvbCBpdHNlbGYgaXMga25vd24gdG8gYmUgZXh0cmVtZWx5DQpm
cmFnaWxlLCBhbmQgdGhlIGVuZGVtaWMgcHJvYmxlbXMgY29uc3RpdHV0ZSBzb21lIG9mIHRoZSBt
YWluDQptb3RpdmF0aW9ucyBmb3IgdGhlIGRldmVsb3BtZW50IG9mIHRoZSBORlN2NCBwcm90b2Nv
bA0KKFNlZcKgaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvaHRtbC9yZmMyNjI0I3Nl
Y3Rpb24tOA0KYW5kwqBodHRwczovL2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9odG1sL3JmYzc1
MzAjc2VjdGlvbi05KS4NCg0KSWYgeW91IG5lZWQgbW9yZSByZWxpYWJsZSBzdXBwb3J0IGZvciBQ
T1NJWCBsb2NrcyBiZXlvbmQgd2hhdCBleGlzdHMNCnRvZGF5IGZvciBOTE0sIHRoZW4gcGxlYXNl
IGNvbnNpZGVyIE5GU3Y0Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==
