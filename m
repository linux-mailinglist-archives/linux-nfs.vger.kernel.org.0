Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927224EC993
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348742AbiC3QVG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244332AbiC3QVF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 12:21:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2106.outbound.protection.outlook.com [40.107.243.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E525716C
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 09:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncN4Hji/9E8i1mODKaw0ZYTJZvUkzpKhTH7/vOmvzJ9g2MuEzP7x/tjqd9ftXBJJDTXBS95+8fS12cgG3cYUK5/JkaHb+HS4RFcDwFCwovJES3eMDBnYOdXzJjqwZamTwVu5Dtg3fVBY7yWjLx32vshHMgQXHBZoUrNTunqyYwa0Jc9JiW53WPFAVBgAqy5zazf78/O2lt2/Uyl9wnFz+logj02mdEur0iXBr61hOkXYLJiY1I0HR471KREb84NGU0ZmYd+OB1HB30d1Sm5zTyTwyQN4Bea1/FRyw1tZGUtnj8fXgfBSJvxDcuRkvoK0RIyvq5dSkloKOBguQ7G8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN8OiK8DFTqerhHhBIWp29UizBljRkaGg1CN4ZYMrqg=;
 b=H97tmDKfhVAWdiuKIz1JAmHLx8SXTSAOebPdfIQqqIpJh8x/IpVs6URPpBTNJfE16leyW1gfP9Atz8LDFfiCTHgHQpVBHTVkfsW0zYv5tbSg+tqQmcJ0CCqzTvZ1o7JYw2HrVqKw76waDQeolRH8igOA5ryAO9gZCLJuku16P9RFU6ZAqeYdIxbK+4PqcyoP+cfjPcbMCEqOSohGqdrS1GopqTDR0l2CV6Mo+SdPhcXNbejVVoP2CRRBGSm6O/LbNZegOoxQAnyAzHv0IFQyQUvM3tv/TWjnjX1AdOAZC1b35OY715TuWblv6m2l9cFLH9/1q88rsBPRVccqDOFd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN8OiK8DFTqerhHhBIWp29UizBljRkaGg1CN4ZYMrqg=;
 b=OiGzI/TmXC12OoW5pmV+d5FtuL/kFSyq5x5kV2avjSbrn7i6w7GLyWJw77i9Q5TuKv+Leyqru8Hd00k+G1DioMqDx0K4noaKgnqSYVhdE89UO/9dLeSmbQNj8c8p+9lkUkLEX4DUVerdIYC6568segzSmw6Qbe/TlwJwnibNJv4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5150.namprd13.prod.outlook.com (2603:10b6:408:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.8; Wed, 30 Mar
 2022 16:19:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5123.021; Wed, 30 Mar 2022
 16:19:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jack@suse.cz" <jack@suse.cz>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: Performance regression with random IO pattern from the client
Thread-Topic: Performance regression with random IO pattern from the client
Thread-Index: AQHYRCHURuyBsHzGwUylCk6TFFITcqzYBlsAgAAJ1ACAAAtYAA==
Date:   Wed, 30 Mar 2022 16:19:15 +0000
Message-ID: <0247959fc43603692ba65c71e1644d3f6d92c060.camel@hammerspace.com>
References: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
         <64a4832afd830d7c831ab687bc7a72cc791c2f0c.camel@hammerspace.com>
         <FF014DFC-EC48-4CB7-A3F4-04FBB82E4A27@oracle.com>
In-Reply-To: <FF014DFC-EC48-4CB7-A3F4-04FBB82E4A27@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 430f6694-32b5-4600-6bfe-08da12690916
x-ms-traffictypediagnostic: BN0PR13MB5150:EE_
x-microsoft-antispam-prvs: <BN0PR13MB5150B661B35FE05ED387D952B81F9@BN0PR13MB5150.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JF+uC3ew2cR2xRZixLS0lNrSglC6oJ/LeJr64KYAbWY0IHn+oNod/D2ScxhMv3qEpWqIaDqENpRR/RSOV5sAjOcyXmF8hgh383Bs7Bq8rxWEMwohCiih3q1ViUWUZ3ljwJusmLWKdUz8tvIgNoRBQU5dKl65UMTM6mUmKKfVg2nkIEQs8yipHFU8gtfwAiOOmTdAOIvDAjxdNJKSwEb31cLG8k3yu1ROdP6BlIPqXycx9LVs93LtCF4TltcCwwJtBlXJCHm95T2DwtZzkFkhm0Pdt3jBV7FHRWt6GVLxrsjxFNtlJOuy8kRlXWLj75F69k9SAKVtF1R5mhmCqMUWsOHe5v9uou0h5N9oddHe7oMdwUUX5fU5fc8QbQ7L9UqfTeTzTVbL3Ny+MG9HmOcJa0OI5vfUZQSKcxjv8Eot89sP2oM8pV6hUOWYiU9MyK/iJK4GAxqEUZHlMqtk0GeBbmYQx0qE9E/bujrbDG8/RNIGPShBkN1WIxaL9cMfJh2kDvZRsbMZBLniuGSOXvgF/AZ/1XxIFycaSFMidNAnxSNRaAA7bM8fnEgUY2sU7ZTrLNhtagbIG27S2sG+6VfkqKq4Qoe+3LKF3wTelncjrBA+lXgyBzfIBTuZ1g5y6LJnYNZC9Y1K4g4N/6pHdIMtPNpk6XwAR25YMSzSM7hf7kgfPpJH5evub/K0LJj4AsY3PkepzYtjonZejHYSmiiexA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(508600001)(2616005)(122000001)(38100700002)(66946007)(66476007)(66556008)(6486002)(71200400001)(86362001)(66446008)(76116006)(6512007)(110136005)(64756008)(54906003)(8676002)(19627235002)(316002)(186003)(53546011)(6506007)(5660300002)(4326008)(38070700005)(8936002)(36756003)(26005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDVGRFpZMnhlamJMamlLRXNET0xnQnZGeEd3Z3lrMW1WWXZVN0ZaV3ZOa2Mz?=
 =?utf-8?B?VmVQUy9WQ25Vdk9LU1dDcEw3MklIU1JhKzcvMnEzbkNhekRibng2bExBMFIw?=
 =?utf-8?B?SjdLN0dUQ3hicWJJTm9nVFFKUGRzRVJpbUJlcEFmSW5zVDN0aWIxOXlyMEtC?=
 =?utf-8?B?eVJ2Y21XUmpoOGFqaENDRjgxTDdsZUxmWXJQYXdzTTl6NW1ETTJ2TWxSMzA4?=
 =?utf-8?B?bURMZ2dBVzNGQlJJMU8vVDlRUCtxQndLdnVzR2dFSjF5VjlxdHlNUHFIdDFC?=
 =?utf-8?B?UTBrSFVSdmdmeS9FbEhUWHFubWJ5U1Q5dGl4RWJ1d3BOZ0l3TGZvMlhkVUtt?=
 =?utf-8?B?WUJ4WWorSXpZRkp3d2taS1kxc1J2RWdZYUJmT1VCc1lqTUdONUJtZkE3L0xk?=
 =?utf-8?B?Rnp2ZzlqWElDWjFSSktDcWMvOEhXZEJ1MndnOGJPNUdtQ1J0VW1kTE9Qb0l0?=
 =?utf-8?B?U0ZzazREOWpiRlJtU29HOW9GWG83aSt1QjdaTWZiaGtCVUllL2N2MDBQbzlz?=
 =?utf-8?B?UThEWmFtY3k3dGwrc3FYUm5YZXZKZlRXU2NaMmU2YWlrbVozbXFzUCs1N0p2?=
 =?utf-8?B?ajJWMGxCMGdlVUxLVWc1SlE1OGd1TktFdUFhdHd3b2RTQS9xMzM2bnpYSUJi?=
 =?utf-8?B?d09zQzdLcFlZVUhWUkJBVTlsY1pXRTV2azdubWMrMVdqai84Z2YyaDBGRXlh?=
 =?utf-8?B?aldha04rcHNyMUk3YXVpMnlSNUg1MG9rRkt2LzNMNytjNFJ2bDVBSzZSS2RJ?=
 =?utf-8?B?cDF0SHEvVXIrVGdkZ0h1aXg3VkpwTUljamxneHNLZ3k2cGpwOG8wekVQNDBh?=
 =?utf-8?B?a1BVS3ZZYjk5K1psb3BxcW04SkdrQ2hzYlRWMXpLU2dKbjJ5NldJYkRZeFA4?=
 =?utf-8?B?dVdOYVJHUmMrenFyektJUWxwLzZKNENIcEw4QS8yUmlqUXRIQ0hYMHpTNEZP?=
 =?utf-8?B?YzhaM3k3NWtaMWJBVjNQQmxacy9HbndEZkFsNldCaWRab1NSZDd1M0ZtVTVT?=
 =?utf-8?B?Mm1qWjJVRW9LQjN3V1lTWE1CTWw4YmNOcmRWbWNJRVY1K1VUQzFGSlpuRzl6?=
 =?utf-8?B?Tmc4RUJPd1BxeUlHRXpJek9FU2Fvdit4ZWJiNzk5RzBWTlNsRkk2Vjg1bWw5?=
 =?utf-8?B?YXJVTzFYYjU4eXgrS21xVHFUaXQ0SUprbmRWcStLQXo4U09BSjljZzNaa1Ju?=
 =?utf-8?B?VngrWGlNWm84TG1VUjl6VXRTeG4xaVRZUkVPM1Y3ZnFsSmRTbll3cEhCaWF4?=
 =?utf-8?B?L0laTnlIYlNOYzRSclM3WUc5Q0JTMlEyZkl3ZFVXZG9lK0RGN1RVZm5BU0R6?=
 =?utf-8?B?cFVXaEczNjRVZXFNdVNoVVdwOEFnZzV1alN0bUg4Y3Y4Umt3R1dueTJJbTJG?=
 =?utf-8?B?UUs0UmdsNGtwckFBSmdvazR2Q3FjQ0I2aHhsMVRLZ250Vy9IZWVUU1NuNU9R?=
 =?utf-8?B?UFRzUTg1ZndNOUZrQ3NaSDlkK2x6UlQrL0NYYW4zcEh5bTdMY21ERlo2ZFdS?=
 =?utf-8?B?S21nMVdwandFMlhtcXRhZ3JVQ3FoeHBSQzd1MkFvakFmWHFVc1dqNkJzMUdL?=
 =?utf-8?B?d0JNUDRURHhVeVgyTzdUUkxRTGdOWENjQ2pCYitGUUxsS1NKRmRHOG1xdVlI?=
 =?utf-8?B?VlRZS014UER5TE9lMEtPcnpyY0lFTHpOYmYwcUhUNEtGY2Jwb21yYU1ieDl0?=
 =?utf-8?B?dzRGcERrM1lFMy9CbmxQMDJiQVF1TUdXNWpyM2pVLzRYb012UnpmMEFsTmlv?=
 =?utf-8?B?ZUJaMVRlV3Y2UC9ZZWVJT2ZHN0x5ak9mRnQ2Zis3bW1TMkgzbDYxL05SSXl3?=
 =?utf-8?B?U2JWcjhVT29OZDR1dHR6aWM1b0w2b0txdDNCb2ZRRjJObGpYaG1yd1g2VmxD?=
 =?utf-8?B?dS9hbDVsSDN4L3ZDcUlvcU5ROGxodjJlS251OUhPNVNjanM4UHI3TzhzWlpJ?=
 =?utf-8?B?dS9aL3VHZGxpS3RsTWZDcmxWYkxZenU1TjNPeHlkMkRUYWtWZXUxZGkrVXNh?=
 =?utf-8?B?aVZTK2dVWjR2UFM1NDhXZjZSVURlNkZpd3BuZDVpSVVjSTNnQTlTZk5HQk5s?=
 =?utf-8?B?OG1KUUJwZ2Y5TFNaNWs3bmlnVllweFZRdUkvVUZ0RXNiWmVyOWxvZDNuU2lJ?=
 =?utf-8?B?ZkJYbUNHb2Zqd3F4ZS9RVU5qU2xXdW5kTUljdDNYbTJ2K3ZSdHNGMmJHS3pp?=
 =?utf-8?B?YjhVQnBxTC90TUlzQm1tdXVmd2I5L0dHSUZFZkRPNDFkbTRyaW5ZTVdXTU1I?=
 =?utf-8?B?Q2ExdXYvV25tbEpYcjdiNGpJVmxHZjdEZldXbk1vQ2lHaHBTT2lYQjQ2Y2lp?=
 =?utf-8?B?dmlvWk95Qy9id2h0K1ZIREJKYmpRZmVubVpYODcxRFRPTWJaUXMyUUhOM3pC?=
 =?utf-8?Q?+NnvJEZP38C69zh8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A559D8B13BC5D443B57F370D1D25D06F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430f6694-32b5-4600-6bfe-08da12690916
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 16:19:15.8739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyIIXp9ZovQ+XL4FCI2apbjR4nsLENyFic36l9bbnvGakcseTcooLFFVEqWFOtZpf44S/JF267BIes44zRxTLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTMwIGF0IDE1OjM4ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBNYXIgMzAsIDIwMjIsIGF0IDExOjAzIEFNLCBUcm9uZCBNeWtsZWJ1
c3QNCj4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFdl
ZCwgMjAyMi0wMy0zMCBhdCAxMjozNCArMDIwMCwgSmFuIEthcmEgd3JvdGU6DQo+ID4gPiBIZWxs
bywNCj4gPiA+IA0KPiA+ID4gZHVyaW5nIG91ciBwZXJmb3JtYW5jZSB0ZXN0aW5nIHdlIGhhdmUg
bm90aWNlZCB0aGF0IGNvbW1pdA0KPiA+ID4gYjY2NjkzMDVkMzVhDQo+ID4gPiAoIm5mc2Q6IFJl
ZHVjZSB0aGUgbnVtYmVyIG9mIGNhbGxzIHRvIG5mc2RfZmlsZV9nYygpIikgaGFzDQo+ID4gPiBp
bnRyb2R1Y2VkDQo+ID4gPiBhDQo+ID4gPiBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIHdoZW4gYSBj
bGllbnQgZG9lcyByYW5kb20gYnVmZmVyZWQgd3JpdGVzLg0KPiA+ID4gVGhlDQo+ID4gPiB3b3Jr
bG9hZCBvbiBORlMgY2xpZW50IGlzIGZpbyBydW5uaW5nIDQgcHJvY2Vzc2VkIGRvaW5nIHJhbmRv
bQ0KPiA+ID4gYnVmZmVyZWQgd3JpdGVzIHRvIDQNCj4gPiA+IGRpZmZlcmVudCBmaWxlcyBhbmQg
dGhlIGZpbGVzIGFyZSBsYXJnZSBlbm91Z2ggdG8gaGl0IGRpcnR5DQo+ID4gPiBsaW1pdHMNCj4g
PiA+IGFuZA0KPiA+ID4gZm9yY2Ugd3JpdGViYWNrIGZyb20gdGhlIGNsaWVudC4gSW4gcGFydGlj
dWxhciB0aGUgaW52b2NhdGlvbiBpcw0KPiA+ID4gbGlrZToNCj4gPiA+IA0KPiA+ID4gZmlvIC0t
ZGlyZWN0PTAgLS1pb2VuZ2luZT1zeW5jIC0tdGhyZWFkIC0tZGlyZWN0b3J5PS9tbnQvbW50MSAt
LQ0KPiA+ID4gaW52YWxpZGF0ZT0xIC0tZ3JvdXBfcmVwb3J0aW5nPTEgLS1ydW50aW1lPTMwMCAt
LWZhbGxvY2F0ZT1wb3NpeA0KPiA+ID4gLS0NCj4gPiA+IHJhbXBfdGltZT0xMCAtLW5hbWU9UmFu
ZG9tUmVhZHMtMTI4MDAwLTRrLTQgLS1uZXdfZ3JvdXAgLS0NCj4gPiA+IHJ3PXJhbmR3cml0ZSAt
LXNpemU9NDAwMG0gLS1udW1qb2JzPTQgLS1icz00ayAtLQ0KPiA+ID4gZmlsZW5hbWVfZm9ybWF0
PUZpb1dvcmtsb2Fkcy5cJGpvYm51bSAtLWVuZF9mc3luYz0xDQo+ID4gPiANCj4gPiA+IFRoZSBy
ZWFzb24gd2h5IGNvbW1pdCBiNjY2OTMwNWQzNWEgcmVncmVzc2VzIHBlcmZvcm1hbmNlIGlzIHRo
ZQ0KPiA+ID4gZmlsZW1hcF9mbHVzaCgpIGNhbGwgaXQgYWRkcyBpbnRvIG5mc2RfZmlsZV9wdXQo
KS4gQmVmb3JlIHRoaXMNCj4gPiA+IGNvbW1pdA0KPiA+ID4gd3JpdGViYWNrIG9uIHRoZSBzZXJ2
ZXIgaGFwcGVuZWQgZnJvbSBuZnNkX2NvbW1pdCgpIGNvZGUNCj4gPiA+IHJlc3VsdGluZyBpbg0K
PiA+ID4gcmF0aGVyIGxvbmcgc2VtaXNlcXVlbnRpYWwgc3RyZWFtcyBvZiA0ayB3cml0ZXMuIEFm
dGVyIGNvbW1pdA0KPiA+ID4gYjY2NjkzMDVkMzVhDQo+ID4gPiBhbGwgdGhlIHdyaXRlYmFjayBo
YXBwZW5zIGZyb20gZmlsZW1hcF9mbHVzaCgpIGNhbGxzIHJlc3VsdGluZyBpbg0KPiA+ID4gbXVj
aA0KPiA+ID4gbG9uZ2VyIGF2ZXJhZ2Ugc2VlayBkaXN0YW5jZSAoSU8gZnJvbSBkaWZmZXJlbnQg
ZmlsZXMgaXMgbW9yZQ0KPiA+ID4gaW50ZXJsZWF2ZWQpDQo+ID4gPiBhbmQgYWJvdXQgMTYtMjAl
IHJlZ3Jlc3Npb24gaW4gdGhlIGFjaGlldmVkIHdyaXRlYmFjayB0aHJvdWdocHV0DQo+ID4gPiB3
aGVuDQo+ID4gPiB0aGUNCj4gPiA+IGJhY2tpbmcgc3RvcmUgaXMgcm90YXRpb25hbCBzdG9yYWdl
Lg0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHRoZSBmaWxlbWFwX2ZsdXNoKCkgZnJvbSBuZnNkX2Zp
bGVfcHV0KCkgaXMgaW5kZWVkIHJhdGhlcg0KPiA+ID4gYWdncmVzc2l2ZSBhbmQgSSB0aGluayB3
ZSdkIGJlIGJldHRlciBvZmYgdG8ganVzdCBsZWF2ZSB3cml0ZWJhY2sNCj4gPiA+IHRvDQo+ID4g
PiBlaXRoZXINCj4gPiA+IG5mc2RfY29tbWl0KCkgb3Igc3RhbmRhcmQgZGlydHkgcGFnZSBjbGVh
bmluZyBoYXBwZW5pbmcgb24gdGhlDQo+ID4gPiBzeXN0ZW0uIEkNCj4gPiA+IGFzc3VtZSB0aGUg
cmF0aW9uYWxlIGZvciB0aGUgZmlsZW1hcF9mbHVzaCgpIGNhbGwgd2FzIHRvIG1ha2UgaXQNCj4g
PiA+IG1vcmUNCj4gPiA+IGxpa2VseSB0aGUgZmlsZSBjYW4gYmUgZXZpY3RlZCBkdXJpbmcgdGhl
IGdhcmJhZ2UgY29sbGVjdGlvbiBydW4/DQo+ID4gPiBXYXMNCj4gPiA+IHRoZXJlDQo+ID4gPiBh
bnkgcGFydGljdWxhciBwcm9ibGVtIGxlYWRpbmcgdG8gYWRkaXRpb24gb2YgdGhpcyBjYWxsIG9y
IHdhcyBpdA0KPiA+ID4ganVzdCAiaXQNCj4gPiA+IHNlZW1lZCBsaWtlIGEgZ29vZCBpZGVhIiB0
aGluZz8NCj4gPiA+IA0KPiA+ID4gVGhhbmtzIGluIGFkdmFuY2UgZm9yIGlkZWFzLg0KPiA+ID4g
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiA+IEhvbnphDQo+ID4gDQo+ID4gSXQgd2FzIG1haW5s
eSBpbnRyb2R1Y2VkIHRvIHJlZHVjZSB0aGUgYW1vdW50IG9mIHdvcmsgdGhhdA0KPiA+IG5mc2Rf
ZmlsZV9mcmVlKCkgbmVlZHMgdG8gZG8uIEluIHBhcnRpY3VsYXIgd2hlbiByZS1leHBvcnRpbmcg
TkZTLA0KPiA+IHRoZQ0KPiA+IGNhbGwgdG8gZmlscF9jbG9zZSgpIGNhbiBiZSBleHBlbnNpdmUg
YmVjYXVzZSBpdCBzeW5jaHJvbm91c2x5DQo+ID4gZmx1c2hlcw0KPiA+IG91dCBkaXJ0eSBwYWdl
cy4gVGhhdCBhZ2FpbiBtZWFucyB0aGF0IHNvbWUgb2YgdGhlIGNhbGxzIHRvDQo+ID4gbmZzZF9m
aWxlX2Rpc3Bvc2VfbGlzdCgpIGNhbiBlbmQgdXAgYmVpbmcgdmVyeSBleHBlbnNpdmUNCj4gPiAo
cGFydGljdWxhcmx5DQo+ID4gdGhlIG9uZXMgcnVuIGJ5IHRoZSBnYXJiYWdlIGNvbGxlY3RvciBp
dHNlbGYpLg0KPiANCj4gVGhlICJubyByZWdyZXNzaW9ucyIgcnVsZSBzdWdnZXN0cyB0aGF0IHNv
bWUga2luZCBvZiBhY3Rpb24gbmVlZHMNCj4gdG8gYmUgdGFrZW4uIEkgZG9uJ3QgaGF2ZSBhIHNl
bnNlIG9mIHdoZXRoZXIgSmFuJ3Mgd29ya2xvYWQgb3IgTkZTDQo+IHJlLWV4cG9ydCBpcyB0aGUg
bW9yZSBjb21tb24gdXNlIGNhc2UsIGhvd2V2ZXIuDQo+IA0KPiBJIGNhbiBzZWUgdGhhdCBmaWxw
X2Nsb3NlKCkgb24gYSBmaWxlIG9uIGFuIE5GUyBtb3VudCBjb3VsZCBiZQ0KPiBjb3N0bHkgaWYg
dGhhdCBmaWxlIGhhcyBkaXJ0eSBwYWdlcywgZHVlIHRvIHRoZSBORlMgY2xpZW50J3MNCj4gImZs
dXNoIG9uIGNsb3NlIiBzZW1hbnRpYy4NCj4gDQo+IFRyb25kLCBhcmUgdGhlcmUgYWx0ZXJuYXRp
dmVzIHRvIGZsdXNoaW5nIGluIHRoZSBuZnNkX2ZpbGVfcHV0KCkNCj4gcGF0aD8gSSdtIHdpbGxp
bmcgdG8gZW50ZXJ0YWluIGJ1ZyBmaXggcGF0Y2hlcyByYXRoZXIgdGhhbiBhDQo+IG1lY2hhbmlj
YWwgcmV2ZXJ0IG9mIGI2NjY5MzA1ZDM1YS4NCg0KSGFuZyBvbiBhIGJpdC4gVGhpcyBjb21taXQg
d2VudCBpbnRvIExpbnV4IDUuNiBtb3JlIHRoYW4gdHdvIHllYXJzIGFnbywNCmFuZCB0aGlzIGlz
IHRoZSBvbmx5IHJlcG9ydCBzbyBmYXIgb2YgYSByZWdyZXNzaW9uLiBXZSBjYW4gYWZmb3JkIHRo
ZQ0KdGltZSB0byBnaXZlIGl0IHNvbWUgdGhvdWdodCwgcGFydGljdWxhcmx5IGdpdmVuIHRoZSBm
YWN0IHRoYXQgdGhlDQpsYXVuZHJldHRlIGN1cnJlbnRseSBydW5zIG9uIHRoZSBzeXN0ZW0gd29y
a3F1ZXVlIGFuZCBzbyByZWFsbHkgaXNuJ3QgYQ0KZ29vZCBjaG9pY2UgZm9yIHdyaXRlIGJhY2su
DQoNCk9uZSBvcHRpb24gbWlnaHQgYmUgdG8gc2ltcGx5IGV4aXQgZWFybHkgaW4gbmZzX2ZpbGVf
Zmx1c2goKSBpZiB0aGUNCmNhbGxlciBpcyBhIHdvcmtxdWV1ZSB0aHJlYWQuIChpLmUuIGVuZm9y
Y2UgY2xvc2UtdG8tb3BlbiBvbmx5IG9uDQp1c2Vyc3BhY2UgcHJvY2Vzc2VzKS4NCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
