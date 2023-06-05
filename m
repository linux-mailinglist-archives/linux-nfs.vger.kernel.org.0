Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C907229DA
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jun 2023 16:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjFEOxb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Jun 2023 10:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjFEOxa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Jun 2023 10:53:30 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2098.outbound.protection.outlook.com [40.107.96.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D5A7
        for <linux-nfs@vger.kernel.org>; Mon,  5 Jun 2023 07:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj81rbQwsfiyZZfA6ndsWUsFCukK2rH5jX5MnSbzw4Fi1/QDId+7W9/mxP4SH1od2RwoW7W9gD4o5DOjDMyZVya1GAxkzNRNhSlS6l5CHWhW3jYSMu7vhZ0MJfjg+Ti/uCASba85PgkzgOGCgIMkfDc4I1bRTJSVNS22xgclCQkywzK6C2XMahLcCW5KrahrYgTNgD6R3B9i4okJFcpyuZ3hbxUwr4batMNKenRO5RGB7+HmezobWnnBK9WP8r4jeOekqBjwWMvsfPweaHOmAp0/J/gHlXLIheJRK3nRW8+sO9Iy/1m0CSX9sRT7UwfBxHnTwDzsEvFBkS+d2MgSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDLCd+clvOQrJn1gg/E0Ntk9PxaS6Lqbx2rzGOz85YI=;
 b=SOPi8Vn4USXDCoitS1cDCRCCffSoWhkD6Nz35lLKgmRdXKJ1CIn2w2mKkV8sbPuVt4O/IOZn1jau3iBSI7aHOaOQF08MeUjwzAOa+cGJhBV8sfrMet6d8XpGZIWKN77+DclfnWUg3gzjMz1Ua1qVip5dvRUD6W1IFs3qi+WzhWAyukAv+tnW6pzmWKPZZiR0pCy96IW/IwKi35vY6kND8b5yBv8UjtPReI6q7p8QpaqOhUE0r6eAE9EvR8xCOXRGbh2a3wOz0c3EOOgHXS0z4kDqlCMiBXJ5VlYJly2b2muiFubSogpO0ZHqYEVtgkFtRph4ROhkggcy6tpyzpJ4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDLCd+clvOQrJn1gg/E0Ntk9PxaS6Lqbx2rzGOz85YI=;
 b=B5hJFD+g3bdXIzmoUZUPaS4TRYXl7e4+LsrsN71e3sa9xe76HWMhUGSLa7tGKCqwwDvPn/S0jJE8oZhemYtG+PYcYExBKfBOmwDK+8PBlntqIRMQ9Zu9GjQOZZYbHYXhabxA+sCnUsUQRhNhWQY5a5NJi5ibDrQhZRYP/uGUgNw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW5PR13MB5463.namprd13.prod.outlook.com (2603:10b6:303:196::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 14:53:26 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::220:c91:e569:4027]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::220:c91:e569:4027%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 14:53:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>,
        "steved@redhat.com" <steved@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH 0/3] Add docs for some mount options missing
 from nfs(5)
Thread-Topic: [nfs-utils PATCH 0/3] Add docs for some mount options missing
 from nfs(5)
Thread-Index: AQHZlMHXF/et6Mp1aESIOC14NPZ02698STAAgAAIQAA=
Date:   Mon, 5 Jun 2023 14:53:25 +0000
Message-ID: <9f64b187051c2818728683352ad10c882acfdcb7.camel@hammerspace.com>
References: <20230601194617.2174639-1-smayhew@redhat.com>
         <8338619a-3609-0c82-0ef2-196127504850@redhat.com>
In-Reply-To: <8338619a-3609-0c82-0ef2-196127504850@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW5PR13MB5463:EE_
x-ms-office365-filtering-correlation-id: 8c6b9bb3-3dcd-4f67-8405-08db65d49dde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gyAeUQ6ochOQM959Gg31Sw7rBbFgXUAcponGMCY6QOpzlVC8c0c1hp9FVb8Xv9TfLuMqT67WUXB6MBrVZEijPxNLaJ94vGxL2aeKZr2sqD79alR8CojV3RMPSAlXIqYh+AXfxOQq/tAmFZAXXxlq3aVL+tGBX6MkPbJBLaEUu1S9a7AEZdotCaqQ2XlUvqjSiDUtIVVMuY1pwkQqeCivtluX3VDgZwoS6qnHMgwSeq+w36e9W/jx3Zzes5pUopYs0PA1OYr2U03B+WaR1Zi0n/cYOZb2A0PjBx5+rcoK4loKFswqwtlRXjqESSc/R7vkdv1CbFPHuqb6O/tX5XwG6mH0BcwfV853ML1jccYq7+Rcu4PD1XRLpLd63KW1reMhMoP0J215bcFRnQSMfjxMsvOlveM3Ny5TKjhHX/GT3+LJqfa97NwDC9me8puebUI1LypR+DDhO0lxLlgI5wtEqle13N22x9fHGrykTsBmtkG60/dDvd2EGByWBGOPWaeJd6xirf/ltj7YJZ1yn1KhDEP573AfDTHKt63zlFlOu2IuFKDkkzD/ldwtumusPPthLLITRIK5B+pSUwbSRJJZNGuAU3vuxyQjkWIE9V8hxbujTLPd37Wwu8X2eEWDP4fn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39830400003)(366004)(346002)(451199021)(53546011)(6506007)(26005)(6512007)(186003)(2616005)(83380400001)(6486002)(36756003)(71200400001)(2906002)(8676002)(8936002)(110136005)(478600001)(5660300002)(38100700002)(4326008)(64756008)(86362001)(38070700005)(316002)(41300700001)(66556008)(66446008)(66476007)(66946007)(122000001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUppbG1Dd3h5Z0k0RERydkVXTnlRenNKRndSazAraThsWEJRWWFFWDVabUhy?=
 =?utf-8?B?Tnh4TmVpcWo4MGQ5QWF5NWZFMjJqRjFTdnpQVGhJNGdQMDBHZ3dpdVZyL2pF?=
 =?utf-8?B?M2JYOVorWXZNcHdhaXdtTVRzMlBpWDJ5S0VUb2F3Q1gxNDZzYkIyWjhhZWo0?=
 =?utf-8?B?ZG1xUjJ2V1h2ekc1dHNwR08xTEJzcnlISjU0MWFmdk9kMHBySHR5SWJIdFla?=
 =?utf-8?B?eVFqeGhLempNZFdkb3AveEh4RWRjMXh2UW40bnk1NUVMdno4OTdBZjdTUDVH?=
 =?utf-8?B?MS9rY0hsRU50M09zL2I0bGgwc2swQ3g3eDJlOHRXMVJIT2tUSjFPVlZiR1BE?=
 =?utf-8?B?WjAvY2NQVUw2aTlUTC82ZUpPZVdqVUk2azJaeGNpQm1ES2lROWFPSlpKZERo?=
 =?utf-8?B?TE9mRHZxeVZodFhWT0lEbmVUeGR4LzVGOW9rRHpYK3c5Y0F1RElzQXBpZlhC?=
 =?utf-8?B?WUIyNGVJMXNkdW1DK083MGozTWJiY0ErZEJDNktQY0o0RWZDSFluVXUzVVU5?=
 =?utf-8?B?MHpETXYzZ2NISCtjZFpCK3pWS1ZYY2p3TG1zT0IxaGFOdVppbENHSEEremN2?=
 =?utf-8?B?NlVlR09qY1Z0bzhnS0xXeXdVZWlhb2xLK2RYQkh4aHVjSENoa2xwZHNOczQw?=
 =?utf-8?B?T2xGVkkrSmVKSWg3cVZFajhsNnRwZHlsTEpJY3QvOHNYUG9RNHpYRTRqdW1s?=
 =?utf-8?B?MWZwYzE2MW1udFY5QWpMRzU2c0lZSjdSWDZXTnppNWJwY1lCeTE3VUw4a0k3?=
 =?utf-8?B?VFo5ZVdtUHBKbTFFci9VakhBajZYTXJML21QWTA5bjZxdlYzbW0rZmxxd0dN?=
 =?utf-8?B?Sm8vS0dkTmc4VnM5UHY0SHpNeTNQRHBZYTBPYklrRDJlSzVoUVFscEJZVU1i?=
 =?utf-8?B?U2MwODVtY1c1Nk5aZG5EUlJrR0lzUFZSK3ZTNitGcTVVRllDR0ZMWnVFWVR1?=
 =?utf-8?B?N21MWm9EcDNmZHZObXRzTmcza2h6MmI1bGduUTZvKzVlSmUzR0c1OSthaHVv?=
 =?utf-8?B?UXdNVEFYMmY0WFR2Ylc2MkN6U1RSeTdZK3cxNk9ldHErdGJ4U291aldvRUJN?=
 =?utf-8?B?bzhva2ZZK0lSdkprejJQNU9ZNkhyc1JCZ0EvbE5PRmR6bjBIT1JrZ0JNZmQv?=
 =?utf-8?B?bkdZS0Mrc1dnVlRDMnpuY1BHbnk0NHpjQ1ZMcXlUVlArMThSU09MZ3I4TDJG?=
 =?utf-8?B?QWRQNEs5dnhDbG5MSjhkY1hCQ0crUTVxcEtnWVYrdk5EaFp6RDZYTHRsQU9z?=
 =?utf-8?B?dWs2UHhKWktxM2dLQU0xQXhxZXI4T1hyankxOEZkSEFLS2lsNEtzR09yYjQ3?=
 =?utf-8?B?QzU3Z0IwY0Q1TE5mRlBIZ0k1MWtGOUphTnh3Wmx4VkluVWEva2xhZDlZQjF5?=
 =?utf-8?B?eEtGKzF3cHlwL1Jvc1B0Qm1nYUgzYnJCbm5sbThpQXk4YnlHMHQ0UURXa3o1?=
 =?utf-8?B?VVdiZlpidUM0VEVsUk5oUWYxTGdpaFZHVlgyMkF5OFdiTFc3dzlYL0tWVjV5?=
 =?utf-8?B?N21MOE00Tk5NdlRBVVk0TThZWFdaS3RJWElEZStKM2JURTV2Q25GK3ZZaEpl?=
 =?utf-8?B?cW5HdlZxM2R2MHloR0drdTltNjlxNHk2V3FuaSsrWFZLQlRob0RKczIyWHdx?=
 =?utf-8?B?MzdqNG9RUVRqOEFiY0cyZGc0bG03UTVhWk41ZU95TExsTXBmNFVTWlprMitw?=
 =?utf-8?B?ZFVSZmtRUkZDV096Sk5BRkd6bFlJb2RtdHR1THR5OFRvWDljL3dlSXJJcDR4?=
 =?utf-8?B?eHF3TVc0Q1Q2MVlXME5jbG13TTVqNE5OMEdLREZiOHFUZ01ScjJISGlJMkkz?=
 =?utf-8?B?UGFEU3NsWmhSalVaamlFRHl4bWgvVitKTXQwbnBQS01xbExrdnFrMzlSeVY1?=
 =?utf-8?B?TDRLN0U4b1Y1MjY3aUpMY21zd0lBZUtGTEtsSGgxTXZqMCtwb1QwNEJtVTJL?=
 =?utf-8?B?d29ONm1XZ1lqVVQ3aldqSWJSZ1o2c2drQWJ2TFpoQnhaeTl1b2lPdjNTOFMx?=
 =?utf-8?B?YUlwWWVQeGQzRVRMTU9NZjk2Mkc2N1E0aVVObjRHVkRNSXNIQWpIM05aK0NQ?=
 =?utf-8?B?c3crRXkxVjFVTXEyVmhrNDhQcEV1LzZpbDdjTGZPajAxaW9xRWZPaEZ2K09O?=
 =?utf-8?B?UDdsWTBDdHdNbld3VllKbitmWndUTVhSVEo5K0p6ZEhMdDhVTjF6K2xITENC?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFBD156B93823043907B20255DC681B4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6b9bb3-3dcd-4f67-8405-08db65d49dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 14:53:25.8568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+ebAVQDkdBOigJSGCTHxuTwQlNSLZSuH5nZSwJ4kQM37scMVrcTSQpy2E6DnyU7+gGdEDuzkJ5GUwjWrvIC3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTA1IGF0IDEwOjIzIC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDYvMS8yMyAzOjQ2IFBNLCBTY290dCBNYXloZXcgd3JvdGU6DQo+ID4gU2Nv
dHQgTWF5aGV3ICgzKToNCj4gPiDCoMKgIG5mcyg1KTogRG9jdW1lbnQgdGhlIHNvZnRlcnIgbW91
bnQgb3B0aW9uLg0KPiBNeSBvbmx5IHRob3VnaHQgYWJvdXQgdGhpcyBvbmUsIGlzIGRvIHdlIHdh
bnQgZG9jdW1lbnQNCj4gYW4gb3B0aW9uIHdlIGRvIHBlb3BsZSB1c2luZyBzaW5jZSBpdCB3aWxs
IGNhdXNlIGRhdGENCj4gY29ycnVwdGlvbj8NCj4gDQo+IFBlcnNvbmFsbHkgSSB3b3VsZCBiZSBm
b3IgcmlwcGluZyBvdXQgYWxsIG9mIHRoZSBzb2Z0IGRvYw0KPiBmcm9tIHRoZSBtYW4gcGFnZS4N
Cj4gDQoNClNvZnRlcnIgd2FzIGV4cGxpY2l0bHkgZGVzaWduZWQgZm9yIHVzZSB3aGVuIHJlLWV4
cG9ydGluZyBORlMuIElmIHlvdQ0KdXNlIGEgaGFyZCBtb3VudCwgeW91IHdpbGwgZmluZCB0aGF0
IGlmIG9uZSBvZiB0aGUgTkZTIHNlcnZlcnMgYmVpbmcNCnJlLWV4cG9ydGVkIGdvZXMgZG93biwg
ZXZlbnR1YWxseSBhbGwgeW91ciBrbmZzZCB0aHJlYWRzIGxvY2sgdXAuIEJ5DQp0aW1pbmcgb3V0
LCBhbmQgcmV0dXJuaW5nIGFuIGVycm9yLCAnc29mdGVycicgcHJldmVudHMgdGhhdCBzY2VuYXJp
by4NCg0KVGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB1c2luZyAnc29mdCcgYW5kICdzb2Z0ZXJyJyBo
ZXJlIGxpZXMgaW4gdGhlIGZhY3QNCnRoYXQga25mc2Qgd2lsbCBjb252ZXJ0IHRoZSBFVElNRU9V
VCBpbnRvIE5GUzNFUlJfSlVLRUJPWCAvDQpORlM0RVJSX0RFTEFZIGZvciB0aGUgTkZTIGNsaWVu
dHMsIGNhdXNpbmcgaXQgdG8gcmV0cnkgdGhlIG9wZXJhdGlvbi4NCk9UT0gsICdzb2Z0JyByZXR1
cm5zIEVJTywgd2hpY2ggZ2V0cyBjb252ZXJ0ZWQgdG8gTkZTM0VSUl9JTyAvDQpORlM0RVJSX0lP
LCB3aGljaCBkb2VzIGNhdXNlIHRoZSBjbGllbnQgdG8gZXJyb3Igb3V0IGFuZCBsb3NlIGRhdGEu
DQoNCklPVzogdGhpcyBpcyBhbiBvcHRpb24gdGhhdCBoYXMgYSBkZWZpbml0ZSB1c2UgY2FzZS4N
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
