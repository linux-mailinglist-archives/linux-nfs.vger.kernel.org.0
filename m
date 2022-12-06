Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CBC644804
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 16:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiLFPa1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Dec 2022 10:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiLFPaY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Dec 2022 10:30:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2105.outbound.protection.outlook.com [40.107.220.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DA5286F5;
        Tue,  6 Dec 2022 07:30:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXDcTPrq/wX5zgOIqkljjKEA792xsipIUPidemPwrL/x8/ZY+3T3CyGKAb82QPAoxVW4bdZtGG+1Ajac1jd16neDIclYLxaec2hg8aNJ0wJ3PJbLkC6OOs3+LQ5ptdBGAQORK6P9Go+NKFmjGMb/7H/6a6YVuskth1mWoRFYvhQaL/xAsVNbq4jZVSN5mH/E4R9eb6U5VbcmrXZkSgGqioEmwvmqAnIILOqM4tLska8xO498qHdlUxrRfqJsUxphNixE1Xo4lAyzOHFzxfW5PQcWoFsqjfIfovaY6bhkCn8p6BwLlEzY6xKA/VEHk1EDo0U/0tJQ/41wOCJ2c29hMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN7Nhmxt+/BwBi4fIgZF8lpsMCHhGj86MvelQmB30us=;
 b=SgJrVCIDxU2g1XYUS0MCsamDSs8jPtK04/NCQIqYkyl+w+5I1Frg2LAe7MoUyXTe/T7NMp0dKN7PPahsY9eTzqjLMoMERb41RUke1QbeMd5OHXOwRYG2hQ3uUqFy40SCbzPkZgfEQHkeGMdNSSPkjcbgETyV+BE1LyjzKImuEsp5/kjp31a+KT2rSjgpXsvpVdOkAvV1hZGzotY2tAWRSR8+/DP3MoKMPYnn+l282JI7ZYE/7UIhAy0XqgPDhCGErcFmHd63uWKtMm4AqiSGRtRFuAGXMraygMkv2EFbXsHbhK5Jam8EvotA+MYKV6PByhsxzXc980AsIPmhM86qRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN7Nhmxt+/BwBi4fIgZF8lpsMCHhGj86MvelQmB30us=;
 b=LGOvF0BlikG1SDct3VW0aaYm1OPcG/PcNCup22VUnrXFhoOqkBiqofuNUwttfPuLEtu/L89/qXvBUh4jtRB9cqZQSWXuSTW/uQSD09rEGVfjoIZjLas7CmwssAM1it9SR+AzRPfoYetqPhwCFGoRuScjNQkgAbHXflFLrTNJ7O4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3641.namprd13.prod.outlook.com (2603:10b6:5:247::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 15:30:20 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%8]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 15:30:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Denis Arefev <arefev@swemel.ru>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "trufanov@swemel.ru" <trufanov@swemel.ru>,
        "vfh@swemel.ru" <vfh@swemel.ru>
Subject: Re: [PATCH] nfs: Added pointer check
Thread-Topic: [PATCH] nfs: Added pointer check
Thread-Index: AQHZCYemsMPXEzB5bkOzshzWqXlhIg==
Date:   Tue, 6 Dec 2022 15:30:19 +0000
Message-ID: <C675D59D-0684-4956-81F6-FC9602EF2698@hammerspace.com>
References: <20221206092653.28911-1-arefev@swemel.ru>
In-Reply-To: <20221206092653.28911-1-arefev@swemel.ru>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB3641:EE_
x-ms-office365-filtering-correlation-id: 52c8253a-392a-45b5-3e5a-08dad79ec8b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DNZr9DXKp9Y/NXDV+eSfSzdYELURrKN6sUxNHFCC3Pyx1rWSw+Knesy9zBiU2+hdrWPPEdGWextQyxBx5SbRnDvjR2W2DH4VPhWOpcw6eKUanscBohtZzFHRlz9ZoHEFzEiM3ezTQzT/sPvpmg5i7K2AOY+mKyYetx5WS2UEsqBwb9q1O5QTa2ppjn8z7fmJ79aueJxwJq7PWIZak4ylUuLlZr1GO9l1GIz3qZ/f/q1+fuXBdAT6AXRkIae9YzOOyvKByWg/QdoGi9HZjhB1F8yf+caTB44ms91JHSuX3zjx2uc+/ArQH35mf3cPqQFlpOSlZIqxlk5Ivu8S9Aibd4v8XSK+HCyTLum/btXMndiVCY65Nz8UJsc9tkwvieegNfPA08ay14xV6YK8araCkRPAY44Zu7y/7MG9TjGWqIgxZ8p7exENOGt5TYfVNEh6Y6zVGHpmGDjv5GM005wlKaeR+Gq86/QZrUQO+Blhx6cCIeU7WecC6cZWXDQGWMEdQtTFuu3QZAPtDG2+aHFCuz8eDaxJs+FuTF4hzCIm4NApOkQAJ9j0ji4XfZe+1dhvxY4Km4+Z5cUS8Zkm2bjtgNJLREmYTh0R6Op4MuC6uaEeSkujDpQuwCvxDefaDC3rzvVrUhBZw5cAUT6BwdhwkwewGvwRFl/3tElZCEdWoz+z/i6jdF+q1pr5DuH+lL1iTizslPZkoaEuMdG367Tj8QPYMhw0O6NPKOXnDbqMfykyq+KZuY7P29N3RgxVa2/mWZAqn9wSL+Usa/YPEymoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(39830400003)(366004)(451199015)(2906002)(6486002)(53546011)(6512007)(36756003)(122000001)(6506007)(478600001)(186003)(26005)(71200400001)(38100700002)(38070700005)(86362001)(33656002)(2616005)(83380400001)(4326008)(8936002)(76116006)(66476007)(64756008)(66446008)(8676002)(41300700001)(66946007)(66556008)(5660300002)(6916009)(54906003)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTkrYVR1eFF0OWVSZGhmK0hhZFNHQm5qVHNSN1JvUnQ2OFhyNG5LSzhoZS82?=
 =?utf-8?B?SS9KTXhNOU1Kd2pBY3R0ZGZ2QXdSYUx0N3E2TUdkc0QvUHl5MldjOURiZG5D?=
 =?utf-8?B?dWh0OXk0Y0FERi9LajUvUkNOK00zTTlSaElzblRPVG1hMUY2S1BvSHd6M2Fp?=
 =?utf-8?B?eUVoZ0FGbjR1Y1lqc3JwVnlXSUtTN3RFQkRMeXl0MVNxNG83a2RUU1YyWGtt?=
 =?utf-8?B?dlJoU1V5aGVGTk9FQ1k0ekRXK29NSEhKQU5mMnJ2ajRiY1c2bWtxTzJQRUJY?=
 =?utf-8?B?OWlva1h6VWxqbEx5RlhUY2YvSFFhbVZjQXZQTWJubSs2c1BReUR2WU4yQUVy?=
 =?utf-8?B?QU1DelpybWhqT2kwWXNSQnd2dW5iYUs1MGdQWm5UcEtEWmRuR2JmVmdtWmpn?=
 =?utf-8?B?VmttcmZuY3BlZmV0TXdtWTV3WURPT0xKNnFoWHRoamE3WjI2RWJ5azc3M3Fj?=
 =?utf-8?B?MnJFVHBvSHZtZ2hkY3ZzZTR5VnJCN2trVkcxMWZadjM0YWZFSXhXMDEzYUF0?=
 =?utf-8?B?bk9zU05VME54VmlFTnE4bnZCdUtJRjNPSVRXRGpTVlVIMngzOHNFeWdhbHF4?=
 =?utf-8?B?bmVqOTU5dytEVWJGVTh3KytYcHZscklzcVRVLzJPUUdxT2hMUS9ZM1NJdTZT?=
 =?utf-8?B?cVRBL3FicThxMGE2QTR5TFRyZnY4QlFpRVZ4Mm5nekhsd2VGc0xJSlpFb3lF?=
 =?utf-8?B?aC9seFI3RmRvWjFiTVJwN00rVmhFQkNVT1MzV2NxVDFkVW84bjcyTkNDSWdl?=
 =?utf-8?B?MlpFKzF6RUF3T3RMM3hFVTh5azZ2b0pSSjVtYXRCUHVpTXdvL1dRMmNPK0pV?=
 =?utf-8?B?aG9jaUdTM2Y1YnhBNFh1Z3o2WlY2TEhpK0N3YVlRK0pYUlNPbG02WkFQZm5T?=
 =?utf-8?B?Tk1YY3IrKzJEMGJOOTQzK2JtSUYvZlB0WmVxRElGa2lEQ2VKNmo4bXUybzZ0?=
 =?utf-8?B?ZlNtNFc1ZVAzemRQdExEQmdxSE1jTXkrM3hGVnF1K0UyS1JUcWN5bEFmRHlo?=
 =?utf-8?B?TC9xK2I3ZitKVjhUZit3WTA3czFtY1pEYUVQVG1ETEEzRVVwQU13alBkbk1i?=
 =?utf-8?B?MkhjdXBub2k2alNWcnlpWlVhSE9zemUyRU96Y1ZtWWQ1a3FZbE9LdzFUdmo4?=
 =?utf-8?B?K2xNTE9jZTBjWmc0MlEzb2RHSlU3Qy9ZbEVHNHJNS2luMXJMSzQzT3F2V2pr?=
 =?utf-8?B?Yks4MDFuM1dsMitCUVVDZVVXSW5hK3d0N3B5KzUxYklIZ2RyU0lDWXB3STF5?=
 =?utf-8?B?MEdJaVQzVWhsaytha1RINkg0MW9TOXhRbHlqN3VBRHBNSkVnTVdXUlRRY0Ev?=
 =?utf-8?B?VVp2ZVdqSGpWd0pVRk5FK1lNUlZFUVEvMHRMZnhNUm5aZG8vSGlhTEloTm12?=
 =?utf-8?B?QkxsU3NSV3luK3d4K1E0M0JBdmlUT1hYLzBzM21ROFM4dnJERThYTEpYbU5S?=
 =?utf-8?B?UUpSL2dVS0xoYjh6VTFqcWk5R1ZtYXpweTRuWnB2U2pnbG50ZktVSDcrZ3g0?=
 =?utf-8?B?RWRoeFEySFFpMGMwUEpuaW9YUVI5cE9GSVJ1Mm4vM29zR3Evemk3U2hUdGI2?=
 =?utf-8?B?czh6b3Y5NnRDRUtTRFI0RVE3eGxWSUIvL0ZXVDY5TVlmWk9veEJuSEowc3ZK?=
 =?utf-8?B?TmZnTFF2dWFKMXhiM1ZVeFhYQ2V5bDBvWGNJNnZiajg1M1VZeVl1Uy9vVlYy?=
 =?utf-8?B?eGppY3FoMi9FM2htUndxZ28vck9GQUtPRjBlenRIc1RRYWNXU3p0WWhyWVZK?=
 =?utf-8?B?VDI4WG12ZE5aWHhNcXRlMmdIUzYybWJ3cGI0Y210VmJOQ0RxWXVjVUNxenJz?=
 =?utf-8?B?dTJPS3ZqT2VYSUw1OTlERGlxREdDTzE4eGRSelZ2bGliVGhROXlyWmF1ZitL?=
 =?utf-8?B?OExqY3RyT2JzS1QwSXh3U3gvT3J5NWVLL1BoZ0dKWFBvam5OQi8wYXp2S1E1?=
 =?utf-8?B?OEFlY0RiWU5wRDJPcFpUTlBSSUpYSzZ5WEcwcUkrRXFIazk5VEtjWWpQZjJ1?=
 =?utf-8?B?b3pyZ1ljck95TTNuYU1tVGJsSE5CZnNyTk5XZjgrd2doREZINUcyZld2ekRH?=
 =?utf-8?B?NUpWYnJrb0hJSHliM3phYUZRVFhIc2ZPNEVyN2M2WTBCTWpWYUNIS0h0aUs1?=
 =?utf-8?B?L1ZYRUI1TnVKRElTN1Yvc2RuQmdxbzZHZlk1Z2x5bmloVjZ6OHhJQ0t4VnZZ?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58E2A0FE81ACDF42BA1893733DA0DF6A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c8253a-392a-45b5-3e5a-08dad79ec8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 15:30:19.7741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VruD5MwqW6jRxSgxepualRwx7Tub2iXpM55K+4J2pV87jidhHG+K9isEewHYaxOx+mNtjpM4CSGxlBMe24AGjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3641
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRGVjIDYsIDIwMjIsIGF0IDA0OjI2LCBEZW5pcyBBcmVmZXYgPGFyZWZldkBzd2Vt
ZWwucnU+IHdyb3RlOg0KPiANCj4gUmV0dXJuIHZhbHVlIG9mIGEgZnVuY3Rpb24gJ3hkcl9pbmxp
bmVfZGVjb2RlJyBpcyBkZXJlZmVyZW5jZWQgYXQNCj4gbmZzNHhkci5jOjU1NDAgd2l0aG91dCBj
aGVja2luZyBmb3IgbnVsbCwNCj4gdXQgaXQgaXMgdXN1YWxseSBjaGVja2VkIGZvciB0aGlzIGZ1
bmN0aW9uDQo+IA0KPiBGb3VuZCBieSBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVyIChsaW51eHRl
c3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGVuaXMgQXJlZmV2
IDxhcmVmZXZAc3dlbWVsLnJ1Pg0KPiAtLS0NCj4gZnMvbmZzL25mczR4ZHIuYyB8IDIgKysNCj4g
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25m
cy9uZnM0eGRyLmMgYi9mcy9uZnMvbmZzNHhkci5jDQo+IGluZGV4IGM2ZGJmY2FlNzUxNy4uNTcx
Y2M2M2VjYjYxIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNHhkci5jDQo+ICsrKyBiL2ZzL25m
cy9uZnM0eGRyLmMNCj4gQEAgLTU1MzMsNiArNTUzMyw4IEBAIHN0YXRpYyBpbnQgZGVjb2RlX29w
X21hcChzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLCBzdHJ1Y3QgbmZzNF9vcF9tYXAgKm9wX21hcCkN
Cj4gaWYgKGJpdG1hcF93b3JkcyA+IE5GUzRfT1BfTUFQX05VTV9XT1JEUykNCj4gcmV0dXJuIC1F
SU87DQo+IHAgPSB4ZHJfaW5saW5lX2RlY29kZSh4ZHIsIDQgKiBiaXRtYXBfd29yZHMpOw0KPiAr
IGlmICghcCkNCj4gKyByZXR1cm4gLUVJTzsNCj4gZm9yIChpID0gMDsgaSA8IGJpdG1hcF93b3Jk
czsgaSsrKQ0KPiBvcF9tYXAtPnUud29yZHNbaV0gPSBiZTMyX3RvX2NwdXAocCsrKTsNCj4gDQo+
IC0tIA0KPiAyLjI1LjENCj4gDQoNCg0KQWdhaW7igKYgV2hhdCBrZXJuZWwgaXMgdGhpcyBmb3I/
IFRoZSBjdXJyZW50IGNvZGUgd2FzIGludHJvZHVjZWQgaW4gTGludXggNS4xNiwgYW5kIGxvb2tz
IGxpa2UgdGhpczoNCg0Kc3RhdGljIGludCBkZWNvZGVfb3BfbWFwKHN0cnVjdCB4ZHJfc3RyZWFt
ICp4ZHIsIHN0cnVjdCBuZnM0X29wX21hcCAqb3BfbWFwKQ0Kew0KICAgICAgICBpZiAoeGRyX3N0
cmVhbV9kZWNvZGVfdWludDMyX2FycmF5KHhkciwgb3BfbWFwLT51LndvcmRzLA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFSUkFZX1NJWkUob3BfbWFwLT51Lndv
cmRzKSkgPCAwKQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KICAgICAgICByZXR1cm4g
MDsNCn0NCg0KSXQgZG9lcyBub3QgaGF2ZSB0aGUgcHJvYmxlbSB5b3Uga2VlcCB0cnlpbmcgdG8g
cmVwb3J0LCBhbmQgeW91IHBhdGNoIGRvZXNu4oCZdCBhcHBseS4NCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
