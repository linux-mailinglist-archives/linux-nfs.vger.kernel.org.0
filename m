Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D89B5295F8
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 02:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiEQAVc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 20:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiEQAUx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 20:20:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2104.outbound.protection.outlook.com [40.107.102.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3425AE76
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 17:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqsjAekhhZBUBWc1zvdy4t/dCHO7PRxZFwLRhOg1OKcTQ0l8xOaYtVCyTfrJ1NiY0/rOXYk08yaSvjl3pnwZLVRijBDN2nJlhmje0HyNa2V0G37RRiBhy9BqiUeTsO/ZBxLFEzvG7kHqceEGhRO/nRr2WzmMAunBDbKmlj7z6bCxebFSCqvuMatHOnxe6n4AC7H48DQVLRqaqNr+bO9M2hLlCuNHCoaAKWKdVSVOPFLkZXHnVhvtQNcSkJTBaHiOYKoCKImUp4F/w4BrnnSmuYE4iTLHZhv1XA65svsa04jEK0ovVV0ZIdHkcbv6+UjWK8TxR3vcztCSJgSeIZ4K2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2hziFkv/3ItBhL1dQeQ1+GpIYEqDOMFkMpjK84EWtY=;
 b=UQ/neBghEu24gjq6eP4HeoC4sFP23NMYV6KfEfWxKyiSrb5N0hCrfVZO3oJtt8HV7jXtP8qCwcQOlLuFSiqex41a5ct2NbXxLjbjtjTtGdL9SXqxRgV07/YVnp4if8geB3O9VD/xlPbg88n6xmmvGGvMq0GllSF4rr1lCm64E6E1QBRVlBShE3Dree5Mimt2zR9fooeCOolmPGJ6PlTvRxj123Y9P8xJ0MJI1s0eu7bSfgBu2tP3y6ax2yg9F1/CDIamw2lEuEY3zamVPqdFr1C2QHpLCwsnXtnbE0BXwnLKompfSHOYjdawtlhV2ziMlmNb74plACE4D/sKqe3iPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2hziFkv/3ItBhL1dQeQ1+GpIYEqDOMFkMpjK84EWtY=;
 b=IdKwV45nSgSPnXpvLCiGW6bRmzy713EiRrBjv5QDhVPvFilV5/FqBTPVHzfgjWGBuIxccc6K8hR24vUPVbQuVXKYUEAK/i6dDRvcQhobdlfy8pgz4rF1D9dA4VNARFiaTPd+rEpumDbwj5gxuOymmQRzXv4Gu0Jc7G0jOOp+iZE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3295.namprd13.prod.outlook.com (2603:10b6:208:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 00:20:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 00:20:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYA=
Date:   Tue, 17 May 2022 00:20:46 +0000
Message-ID: <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>
         <165274590805.17247.12823419181284113076@noble.neil.brown.name>
In-Reply-To: <165274590805.17247.12823419181284113076@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c81f68e-9961-477c-5ff5-08da379b16bf
x-ms-traffictypediagnostic: MN2PR13MB3295:EE_
x-microsoft-antispam-prvs: <MN2PR13MB3295A528F0C623BD4611E2CDB8CE9@MN2PR13MB3295.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ilOo+LFpifzXnl1A6mDDNXf28ZocJcxYH5FTPA1s4Vj8fghlCAX5ddIz8WPdCZ8rg1dEuHN2YCNnR4YD7OMug8t56sjP2GLKUeF1xWBXcXZuAdpJICkcHE7isPEdr5PmDiRC9F0jSTVBPl+UzYotVDXur/xu86xyZxIcBK5qWzz1OS2LZ/wmu+4dSpImBlQbyKZSyi0qXxUorUz7X3kiZZMWPzSVR41TOED2nERlA4reoIcKtZjXsW+1jKjT5q7NoHiaUHfSMJLdMPFUjjmQWiREB4L8GKGMltSbSU8dx4MlBuzQDNHKf7Sh+k+BoMnPtpcMu3+ALs3vYENiVxuQPQ0e9EYhEDLjkHotef2Tf7QiBnEeva4PYLuKgiquPjLIGK4+pmNvN6fTR58CRsCULysU9eKM0A/FG/syPc1jzZ+FbKEqlARw++QuSs8nTqxAw49Gwq0Ke7hQKewMcwsQWeRR3/WrPsZpD7NotU7RCLNG749GW50ghtTDMvWr6d9W+QMRj7ofYzTB2cX0wzmXNSpiKSACsSK5AUhbnb69P3YwnHE8H7eeUHW1TecH4mG5gZFBuByG8rDe9Z/3HPHfe2Nt6itMUHeHvEqwQ0rZKeglsHfRiULVZFfcXBSgclL8RFL9K8QBh7lbPL19tVgNfA7JjfbQ0Ql/was4boVzXCyI4pX3wtUoGkdiTmXCKvFlqEzHY0OlgpN4ht6mvIr7Pffkgb4BBxlB7Ahnm2KSDDnDF6gaWy1mXwvwLU/Sc2UxSv3nZDTjDhmbvT9njgeuYCgtqysD7lzDbbng03OsbYU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(8936002)(83380400001)(38100700002)(38070700005)(71200400001)(5660300002)(122000001)(86362001)(6512007)(26005)(2616005)(110136005)(2906002)(15974865002)(6506007)(66556008)(66476007)(64756008)(8676002)(66446008)(66946007)(4326008)(76116006)(36756003)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3N1MjVhZFR5NFFHZ01BT1ZkV0phNHFhaHRSRktVNEcrWXBDbXNOWWh5MzNG?=
 =?utf-8?B?RlkyQjY0ZTlGbDN3ZU9oZDhFbnlOUlk5QkgrVTNvZitWVVpaaHJISGowT3Ro?=
 =?utf-8?B?S05DSkNhYWNlZHVzdUk1TVh2dG5VYzJLdGhuSXhjZmsxdmpNQUdhcXgwQVA0?=
 =?utf-8?B?b21Bd0hKbjYrTUhlbyt1Y3RYb3R0Z3JwMk1PMGVMV0VvTmRweFBZbS9xUHVq?=
 =?utf-8?B?OG9UdkREbE1MWjZsZGpDUlB1dEQzc0I1MzhOSWdHM0xmT0JoaTJBQzM4UFla?=
 =?utf-8?B?OCtWS251aUtjSldVQjJrR21EYlp3VG5xVTdORmpyck9EQzh0S2Z6R21UZHlo?=
 =?utf-8?B?YnJDUmp3ZXZwVG9MQXhtN1BrcTFMaUE3SVlxa3JDdHRDNjA2aEh4QS9OVTNk?=
 =?utf-8?B?Qi9uS3FsLy83ZnVqNXhOVzJWNlZXTlpPQWNYTlZDQldUajBZOEFuZ3A3Y0Zu?=
 =?utf-8?B?T3hmUWg4ZlRvemlIRkEzWUtlbkY2NlVzUnhMWXE2RlpkcFg3enphb1RxYjRl?=
 =?utf-8?B?Um1QWThEM2FjbkJHMld6empEMnNIL3c4MHFSL2Y1cmFFZVd0STRWSlBCcXhn?=
 =?utf-8?B?dFA3ck5GOXlaN1ZwL082WlRsL25LVkZCNjdFNDJWU0R3ZnRZKzE2ZEtEN2p6?=
 =?utf-8?B?bUpyd043WStNTHBOdTNJZCs2N0RtQ2tpNzRrbEh6bUUyYms3SWpyRmpZRlVZ?=
 =?utf-8?B?YmlrNG9JbDQ0SllaK0JXanhmV0NxNGJZSHZUKyt2OTlocDB5cTZGdU9nZjZV?=
 =?utf-8?B?cDBaQmNaVTNzZ3RXUUZHMGZOT2toSG1TTGwwc2c1eU9FNStyNHNhTjVNSjVH?=
 =?utf-8?B?cVFYd3ZUdUc3M2FLTWRjS2NzdjNjNzFYWFBkS3BlUVVuc0ZtVUlZZ1ErdXNx?=
 =?utf-8?B?YzhNRXhVSTROZy9xVmJWQlAvdFc3bk9JR2RyMkFOZUFlaFFvNnFZUnpRR3BU?=
 =?utf-8?B?OC9RMUMzVFFudkV5aGphVHNxOE9QQXpLa0dvbmJSWkpZQlg0Z2FUQS81SVpL?=
 =?utf-8?B?L2J6bU5wdkdJM2pVbFN3V08yOGtzR1pmQzU2bEdiOGRsQ0xDR0xFQjJmRWJO?=
 =?utf-8?B?bGsrdmdCMTF4eWdNeFI1VTVlN2lwU2N5UDV5V3YvTzNMTzQ2bk1SRk1wcVBl?=
 =?utf-8?B?bUtSNjkycysvWUZrYXc1eEpWWUc1M0dOK3k0RFpMOXY3WmFLUzJBa2xnQVJU?=
 =?utf-8?B?eWErOVZBYzlSNmdIaXM5aVpBYkJYNXpGR244eVZoSFU1bHAyVTJpdmdoNysx?=
 =?utf-8?B?WENrVWVVTVZwa3EyVGsvd0w2bWNpY1B1VzBqc3p6T1hQOGVRbWM5RERrcURM?=
 =?utf-8?B?Z09QZitiNmYvSW1RVy9zeHd2bXNvVnBMTzc0MnJ2R3N2YXA4K0FpZlgrNUxs?=
 =?utf-8?B?c1ArZTBtVUIwd1hzUVFZc0F3eGs0QzFoZlNzRkJscjVRSGtzS3VsYUlzODd0?=
 =?utf-8?B?M2swTUVXZGR3NFVPdG96Q3Q2Zk9rbHNiTDVpTVhEckNxWVVCanE2L1VCaE01?=
 =?utf-8?B?YWlWNVZVemtzay9JSUV5MDR3NUNNam1LcHB0eG5ReG1hV0kvV1hVemh6bG9r?=
 =?utf-8?B?K0RPK0lMNE9QbDZEUnBzK0xiT3Z4cXlaMjJZbmpCZCt5cXB2eEVwbk4ycTdR?=
 =?utf-8?B?aU9jRnNiVEd2VDJDbEo2N040VHV5aWp2S0I2dGprR25hc1pTWkNsZkhWOHFM?=
 =?utf-8?B?K213MFE3RkpubVNUQlN0czhGWTJGK1d1YS9sTEJBZ3k1N2J5TTdpOWpVVmMz?=
 =?utf-8?B?VEw5bG9oOGhaWmM3YTM1WHBXSzhwVDJYK1JuZitSS1o5c0RiVHNuUlZGL2hX?=
 =?utf-8?B?K05pbUhQb2FnY002eks1RDM0QnFydUVsdkJwUmp4WGhQMk1kY2c0M1oxcnJH?=
 =?utf-8?B?NUpONFI1aEYwakVESjNyZ0hxTks3TC9jaFByR1VWWUQxekxCL2xUblg2L0dr?=
 =?utf-8?B?WGVqdmRET3d4dGhlR24xNEFEbWJWQldhd1pWWHAwcWcvSzE3RUdGWEdGVVFX?=
 =?utf-8?B?QWdyWi9ZSk1NR0Z4TmxybXg2VVRKNmx5cGJSVTlJenpJOHlGQ3hkZWFRYW9z?=
 =?utf-8?B?dE9jY0EyOG1PS2k5R2MyYjFvZVM2azVsZTBzWmFTVW52U0dMY3BXY0pCZ0NR?=
 =?utf-8?B?b0xQTk5DMGJsQ2dIOStUd0J3dmxjTDBSV3cxYjNXeEwyQTN1c2RYZmMxZVh6?=
 =?utf-8?B?Ly85M2hrQm8yNTZpYitIUGFDNTFTczNBc1c5STNIdlVhOVZEeVJ2WEZpZ24r?=
 =?utf-8?B?YzFTSFNZSkRMYUpTdktad2JRZHFvL3RRMDVwQVFtV2VwMEtZSElnU1FNR09j?=
 =?utf-8?B?eUllU200YkJoaEttSGIrYW16VWtvMFpONGdUWW13OFNWMFloZis2RWRHZHVR?=
 =?utf-8?Q?JaQwK+13KjZG8Cas=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <013D46F090A3094BA3E087A973F433A4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c81f68e-9961-477c-5ff5-08da379b16bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 00:20:46.6977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYLcXxunfv9+ZAuLd83P7pr3Vdw/ayBLUxjwipGXaKpvzTVNKuVTgL0DyXmO6Qt11cVXLgFENfWuvv8R6mDOfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3295
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTE3IGF0IDEwOjA1ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBIaSwNCj4gwqBhbnkgdGhvdWdodHMgb24gdGhlc2UgcGF0Y2hlcz8NCg0KDQpUbyBtZSwgdGhp
cyBwcm9ibGVtIGlzIHNpbXBseSBub3Qgd29ydGggYnJlYWtpbmcgaG90IHBhdGggZnVuY3Rpb25h
bGl0eQ0KZm9yLiBJZiB0aGUgY3JlZGVudGlhbCBjaGFuZ2VzIG9uIHRoZSBzZXJ2ZXIsIGJ1dCBu
b3Qgb24gdGhlIGNsaWVudCAoc28NCnRoYXQgdGhlIGNyZWQgY2FjaGUgY29tcGFyaXNvbiBzdGls
bCBtYXRjaGVzKSwgdGhlbiB3aHkgZG8gd2UgY2FyZT8NCg0KSU9XOiBJJ20gYSBOQUNLIHVudGls
IGNvbnZpbmNlZCBvdGhlcndpc2UuDQoNCj4gDQo+IFRoYW5rcywNCj4gTmVpbEJyb3duDQo+IA0K
PiANCj4gT24gVGh1LCAyOCBBcHIgMjAyMiwgTmVpbEJyb3duIHdyb3RlOg0KPiA+IFNpbmNlIENv
bW1pdCA1N2I2OTE4MTllZTIgKCJORlM6IENhY2hlIGFjY2VzcyBjaGVja3MgbW9yZQ0KPiA+IGFn
Z3Jlc3NpdmVseSIpDQo+ID4gKExpbnV4IDQuOCkgTkZTIGhhcyBjYWNoZWQgdGhlIHJlc3VsdHMg
b2YgQUNDRVNTIGluZGVmaW5pdGVseSB3aGlsZQ0KPiA+IHRoZQ0KPiA+IGlub2RlIGlzbid0IGNo
YW5naW5nLg0KPiA+IA0KPiA+IFRoaXMgaXMgb2Z0ZW4gYSBnb29kIGNob2ljZSwgYnV0IGRvZXNu
J3QgdGFrZSBpbnRvIGFjY291bnQgdGhlDQo+ID4gcG9zc2liaWxpdHkgdGhhdCBjaGFuZ2VzIG91
dCBzaWRlIG9mIHRoZSBpbm9kZSBjYW4gY2hhbmdlIGVmZmVjdGl2ZQ0KPiA+IHBlcm1pc3Npb25z
Lg0KPiA+IA0KPiA+IERlcGVuZGluZyBvbiBjb25maWd1cmF0aW9uLCBzb21lIHNlcnZlcnMgY2Fu
IG1hcCB0aGUgdXNlciBwcm92aWRlZA0KPiA+IGluDQo+ID4gdGhlIFJQQyBjcmVkZW50aWFsIHRv
IGEgZ3JvdXAgbGlzdCBhdCB0aW1lIG9mIHJlcXVlc3QuwqAgSWYgdGhlDQo+ID4gZ3JvdXANCj4g
PiBsaXN0IGZvciBhIHVzZXIgaXMgY2hhbmdlZCwgdGhlIHJlc3VsdCBvZiBBQ0NFU1MgY2FuIGNo
YW5nZS4NCj4gPiANCj4gPiBUaGlzIGlzIHBhcnRpY3VsYXJseSBhIHByb2JsZW0gd2hlbiBleHRy
YSBwZXJtaXNzaW9ucyBhcmUgZ2l2ZW4gb24NCj4gPiB0aGUNCj4gPiBzZXJ2ZXIuwqAgVGhlIGNs
aWVudCBtYXkgbWFrZSBkZWNpc2lvbnMgYmFzZWQgb24gb3V0ZGF0ZWQgQUNDRVNTDQo+ID4gcmVz
dWx0cw0KPiA+IGFuZCBub3QgZXZlbiB0cnkgb3BlcmF0aW9ucyB3aGljaCB3b3VsZCBpbiBmYWN0
IHN1Y2NlZWQuDQo+ID4gDQo+ID4gVGhlc2UgdHdvIHBhdGNoZXMgY2hhbmdlIHRoZSBBQ0NFU1Mg
Y2FjaGUgc28gdGhhdCB3aGVuIHRoZSBjYWNoZQ0KPiA+IGdyYW50cw0KPiA+IGFuIGFjY2Vzcywg
dGhhdCBpcyB0cnVzdGVkIGluZGVmaW5pdGVseSBqdXN0IGFzIGl0IGN1cnJlbnRseSBkb2VzLg0K
PiA+IEhvd2V2ZXIgd2hlbiB0aGUgY2FjaGUgZGVuaWVzIGFuIGFjY2VzcywgdGhhdCBpcyBvbmx5
IHRydXN0ZWQgaWYNCj4gPiB0aGUNCj4gPiBjYWNoZWQgZGF0YSBpcyBsZXNzIHRoYW4gYWNtaW4g
c2Vjb25kcyBvbGQuwqAgT3RoZXJ3aXNlIGEgbmV3IEFDQ0VTUw0KPiA+IHJlcXVlc3QgaXMgbWFk
ZS4NCj4gPiANCj4gPiBUaGlzIGFsbG93cyBhZGRpdGlvbnMgdG8gZ3JvdXAgbWVtYmVyc2hpcCB0
byBiZWNvbWUgZWZmZWN0aXZlIHdpdGgNCj4gPiBvbmx5IGEgbW9kZXN0IGRlbGF5Lg0KPiA+IA0K
PiA+IFRoZSBzZWNvbmQgcGF0Y2ggY29udGFpbnMgZXZlbiBtb3JlIGV4cGxhbmF0b3J5IGRldGFp
bC4NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gTmVpbEJyb3duDQo+ID4gDQo+ID4gLS0tDQo+ID4g
DQo+ID4gTmVpbEJyb3duICgyKToNCj4gPiDCoMKgwqDCoMKgIE5GUzogY2hhbmdlIG5mc19hY2Nl
c3NfZ2V0X2NhY2hlZCgpIHRvDQo+ID4gbmZzX2FjY2Vzc19jaGVja19jYWNoZWQoKQ0KPiA+IMKg
wqDCoMKgwqAgTkZTOiBsaW1pdCB1c2Ugb2YgQUNDRVNTIGNhY2hlIGZvciBuZWdhdGl2ZSByZXNw
b25zZXMNCj4gPiANCj4gPiANCj4gPiDCoGZzL25mcy9kaXIuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgODAgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiAtLS0tDQo+
ID4gwqBmcy9uZnMvbmZzNHByb2MuY8KgwqDCoMKgwqAgfCAyNSArKysrKystLS0tLS0tDQo+ID4g
wqBpbmNsdWRlL2xpbnV4L25mc19mcy5oIHzCoCA1ICstLQ0KPiA+IMKgMyBmaWxlcyBjaGFuZ2Vk
LCA2MSBpbnNlcnRpb25zKCspLCA0OSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiAtLQ0KPiA+IFNp
Z25hdHVyZQ0KPiA+IA0KPiA+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KQ1RPLCBIYW1tZXJz
cGFjZSBJbmMNCjQ5ODQgRWwgQ2FtaW5vIFJlYWwsIFN1aXRlIDIwOA0KTG9zIEFsdG9zLCBDQSA5
NDAyMg0K4oCLDQp3d3cuaGFtbWVyLnNwYWNlDQoNCg==
