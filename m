Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7CA5A2B7B
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 17:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbiHZPog (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344347AbiHZPoe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 11:44:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E9FAF0CE
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 08:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqhKxhEn/sLjU2R61ZzR18r+DVTnseEWKyaFNejnAslbJa683FurI/5gQKKyw5WfF2vHHBc1IE1PjXQfMw7W9YLHoPOJVbU/OEHN6eeBbQg7NgUCWjl+4uV7KF5pTT+RjWRTapCS7c3SuUl2gCvAjNFgXPsFK9vTd9S+fspBkzdN8hfXfaWEIE6pzb67CCcz3O1m+zDPLp7Fqga0wjEaLMaozUkYdiibFktmOqkPQdFKNpwAUE0Wb75D+RS6jyTnZ1TJhuM8YmU21nEHgX5V4ITvhxZKxp5TdNp+G6idHPe5OHKqy442Lcc7pa82Ztdxt1m+rWDqphXt+gPQyopBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOtB/njobACoNHjF/5YjkseH09bN2XaHaoXKCw+hC9Q=;
 b=UJkeg3czdl3zJwZ2aeKpLyU7ZwHhF1prQk8SeouWVfvL08xETC74GWR5YRw1rVZ+a7CZGd92qDO2QGSH/t8gCEESz1S+dU+dLO8fUSuPUePFQFTO7XPb/SB8l16oGvlDBl6HvA7VbGpNir35ESyuIFp70pVA8Uqd3vM2hygZMzR0jqW5tE1ORpVYrlCrC84mlLlcb8RNUyn3nf+dX8IZA4FcTtI0Zn13R55LKMd4mPNGdRXs/umw1Sv8XykiRD4ivkZdlzWA93I/zQ4XinsOnvi7zyJMH+pugbY5mKT7wK0B8rMEDrdJwKdZV9SwL8+jDDL5MTc2IQij1fpdZCPqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOtB/njobACoNHjF/5YjkseH09bN2XaHaoXKCw+hC9Q=;
 b=P4Mxe+UpSl8JVQuKy/I4l37GkRn5W7zhGPPgK7sb5x1QqeMTja5Wm7jtYkxEospNdYzZ9LHyih9FlfTdSr9wTu0UqHdGAuRmiL+36EcGn5jjamWj/ntB2GnRrbNrSD4wHftlZytHKXYoe192o0OylvQgYHJ3rIF2Ts0OVrUeFzg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5610.namprd13.prod.outlook.com (2603:10b6:806:231::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.4; Fri, 26 Aug
 2022 15:44:30 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%4]) with mapi id 15.20.5588.003; Fri, 26 Aug 2022
 15:44:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEAgAACsoCAAAKEgIAAAmYAgAAD74CAn5ulgIAADKiA
Date:   Fri, 26 Aug 2022 15:44:29 +0000
Message-ID: <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>
         <165274590805.17247.12823419181284113076@noble.neil.brown.name>
         <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
         <165274805538.17247.18045261877097040122@noble.neil.brown.name>
         <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
         <165274950799.17247.7605561502483278140@noble.neil.brown.name>
         <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
         <165275056203.17247.1826100963816464474@noble.neil.brown.name>
         <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>
         <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>
In-Reply-To: <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37f84514-5b4f-48c7-b67f-08da8779dd31
x-ms-traffictypediagnostic: SA1PR13MB5610:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /GT4EFJO/J1U8nOtvmERK8Nk6MKujVTDDHj8Hyo1EpENeTdICktx6OnTBm4H+N9QhEj5GRghECcIa3hMGTq7Lq1PzZav9mjgtb/HkGkAEfSrP5lEblLs/ZIDE8qGhQN/MbgYCZHWGvV2l1DjEPLmVv8H861VHiEhbWaLztemrsXlM3ibvK/oi7t0aVK/3BIaGrCv+RUjGq0jxWW17FrTJ2KD91fAijJkWmGWTQ4SllK1dXS/Jkr8mNLiC7auNNqhvjaGIR+GGDPuSkF4CKp0DmnOpWi/hQfGXMqpE8kG/rH250ObKZ7VCA2dQCCiDhOuBYyt8Y4+//bE0jNXRFreFs6RBg2MR1WpMF5F/6FPqmH3uKiRRWvyGXQ0f+ozzkuR6CAal3R2L22ssfF7TS/aGfdrnONDLU14FfsRnIuwrrByTsDS49ogbYRTSVLFkof24XT/CzhDP5oeOFx+N22PNC7MqiqHCHy8AMUAm3Q0LNXDLekwCd/gRklrYskSKo3/WvNkS6SjZeerAKXwz8vpl/zsZo3IGJLR9wynIc33RZG5oLhzsTAjg2NEKp2GrwWTrXLrmeFhtarWfH3W0KbklqMYhb+hULBaE+u44iZ4UundmHnZ+Jx3SFXM1II8xTCH9wOxZoeAlyWa37FxQXS6OnlLgkRY5/I76lbH2feD98OUm8qRYCV6FjIcUSLrHMcTbF657Y0k7UyLSdjxintXG/iWs/y8EPM8n7gq4Q3MS8ybDlDb+QuZYlWGA86Q9J7+616qxGbbMb1zKKr4r/C3JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(396003)(366004)(39840400004)(8936002)(83380400001)(38070700005)(86362001)(122000001)(38100700002)(76116006)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(71200400001)(6916009)(316002)(54906003)(36756003)(6512007)(53546011)(26005)(6506007)(2616005)(186003)(6486002)(41300700001)(478600001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDNtWW1VRlc2S0lENENiY1R4bENQaHcwUjI3SUwyeDVTR0tSNmFnQlc3d3VC?=
 =?utf-8?B?eStmVkZLN2VNTzdZL3V0Wm5ZaGxGWUtqOTh1RERiSXJpUFM1UFBPNjdHNWJK?=
 =?utf-8?B?VnRwc01DMkpVUlVLSWdRVEQwbVFROFRFUHd3RHhMSXZZTXRpNDhOci9TWWhs?=
 =?utf-8?B?S082YTJWZHdsWUY3MzBSNjhBamc1RTlQWU9EM24zeFVLWmdpYUpmdWVTWnB5?=
 =?utf-8?B?bzFkbFFGRWVxNzN2elExbjhxSjZoWVpmT0wyTUN3enhpS2l6S3NqbTdLd2NO?=
 =?utf-8?B?MVNaTHdKVk1ncFlKZjhleDc1WWovTTBsWmYxNTNpeXJMc0ZWMlRnN2lnbHlz?=
 =?utf-8?B?aitOQWR0QmRXTEFHOHBUVGl5dE5rOGEyOG1LUzRNckdwQXZob1lSL2pHTzJO?=
 =?utf-8?B?TzlTcWIydVJ4QUM1aU5UOFNNMXlkWjdEODhnbVR6VEtDeklmKy8vNm9aNEph?=
 =?utf-8?B?N21Ua1R2SVUzaUhPaE9PTi8yQVRiVVFsZXVKQjJDUTRvYTdLUXJaQjhVQmZP?=
 =?utf-8?B?NUQxMlEvanB3U3hxNG5KK1c1MnBtRU1vQWlHVXVBdHZIbVNkdC9ZN0lMY1Vv?=
 =?utf-8?B?V25xc1YzVWtGWWtmUzFGRzExb2ZHR3RnVlNxTGVpWXlJdHJhb3RJaFB3VG9p?=
 =?utf-8?B?blBvcnd4WVliYkxjUFp2V1RPOGMyTWNBY25kWjkra09SWUtqdWc4MWlWcS8r?=
 =?utf-8?B?RXRXQXdUak83NW13SFdSSmFkUFg0N0RaRVJlVnhKZVJNWTZ3Q2ptWmMvMDNP?=
 =?utf-8?B?UEtqWFZHSzIxYWVwQWoyWXJjK3Rhb204SVFtaVRGVVZ3aXIvRVdOSzJ4QVBu?=
 =?utf-8?B?dGR3NlJJeE04dDhyRGkwaC9EeVhwV2lhVVhlZFh3clJFYWpGS2xRZVlPL1h6?=
 =?utf-8?B?cWV0alc3UGF6Si85R05LbWhvNFBNZ3JJdTZvQVNGbzk5akg1bitBY1JPalpN?=
 =?utf-8?B?NStxa0Z2Q0ZhTTdFYXIxbXV5T2lydytlRkdnbjNUQ3MxRE9lbDJDeEJFZHUw?=
 =?utf-8?B?TGJBTUV4cHF0LzZnNDJ6bjZVbzJhWXNqY3c4UWFPeTZITFVIcUF4ZEs3cjJu?=
 =?utf-8?B?RFdFbDQ4SHJLMTdjYzFuNmN5Y1NUbTB2YXVhRE5BOVdNTGZINjZsdDk4dmtz?=
 =?utf-8?B?YWU1MnJsaXlqZmJpSkhNc012TFAxb3poU3RvN0N0RGx2Rm5jV0hiS2ZQTEg1?=
 =?utf-8?B?Sit3S0VLNHVteWNVV2hqSVRFRS9tRXltWGwrOThzQlIzbXdDRmtpOStwRXBi?=
 =?utf-8?B?THN5Q0tIWTMwdlZuS1J2L1h5NG9mUVRLUFRvSHRROFo4ZWNxdVA5aktjeWZu?=
 =?utf-8?B?WkVHR1YzOW1tTXVWb3BYNXZrYldBYkl4OWFoUU1LanFndDY4N1RxRXc0Qmkv?=
 =?utf-8?B?SFozM2RZdVF4c2VUYmdBUWQrTVljNTNreWx2US9SeTV4VGdsZEpuODM5cEZ4?=
 =?utf-8?B?dEx1WklxZnJVbUlCSUFHR2I1REJpM2w2Z2tGRGlUck5keGtLKzhhVkVWSVAz?=
 =?utf-8?B?cXZMNDlBczNpK3UwZzE1VHVZWmM5cFMxa0IvcnVKYzh3djE5QWlIOGpheW9K?=
 =?utf-8?B?M2NnRmRKekI2NG40R1E0QzI2MldOeVcvQWdRK2I4VVU2bmhqYTE5T1BpcG4x?=
 =?utf-8?B?VDd0TU1MZE5HZjRvRDA3azBmdkxFNEJIWVlibXdXVFBQRFhGeUpaWGdub2ds?=
 =?utf-8?B?ZmJnLy9GMFNGWXBwaFc0dkNkR2MycnRIc2ZGSVV5cHU3Y2tHTWdOSUFnUUZl?=
 =?utf-8?B?NVZJSWMzTmNyZ1dqMmd1VnNIdVl2NHgrZFpUbDhOdWEvYlBHWno5SFFQMVpW?=
 =?utf-8?B?M3RKeTBRdjB0eDhURG8zT2lPRmd0SHhTS1NCZWdZYXQ5UE91emh5NGVMcUNx?=
 =?utf-8?B?TU9wUzNKWmI4d09mRDNRTE9zdHc2WVIrNkFwbFhSMGcxWDNQcUZSUy8zNDR6?=
 =?utf-8?B?cXZvM2ZDNEpNWXpHMjdkYjFiSTBsODF2ekc4K2IvdlQxZkdjekdLMG5LVmkx?=
 =?utf-8?B?ZHNDSjVhVjFGKzRxdkJOOTF6bVpBVkVzbzJLZnZ2QlcyLzZ6cm1HSTlSV2Ja?=
 =?utf-8?B?aGcyVE9BTUU3VVhqWkQ3YWdreEdyYXhBVnhQcHE3V3FXWHUxeWVWZ0R0UEZO?=
 =?utf-8?B?WTZFOXpkVUVQRUxUazY1TnJ2REtIcXpnSUtKTGpTZU9BbWZ3NFhUWk5aWFA0?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3183F8B074674A419F6980B1228A43FA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f84514-5b4f-48c7-b67f-08da8779dd31
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 15:44:29.7693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyJJikMCok49Q2n/v/jWsm1fnevXxzYZnqHJjgG+eIqLz1+faewIlFpt2tugGKMJpYmPg2emFShgNXF1QQDf8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5610
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTI2IGF0IDEwOjU5IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNiBNYXkgMjAyMiwgYXQgMjE6MzYsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gPiBTbyB1bnRpbCB5b3UgaGF2ZSBhIGRpZmZlcmVudCBzb2x1dGlvbiB0aGF0IGRvZXNuJ3Qg
aW1wYWN0IHRoZQ0KPiA+IGNsaWVudCdzDQo+ID4gYWJpbGl0eSB0byBjYWNoZSBwZXJtaXNzaW9u
cywgdGhlbiB0aGUgYW5zd2VyIGlzIGdvaW5nIHRvIGJlICJubyINCj4gPiB0bw0KPiA+IHRoZXNl
IHBhdGNoZXMuDQo+IA0KPiBIaSBUcm9uZCwNCj4gDQo+IFdlIGhhdmUgc29tZSBmb2xrcyBuZWdh
dGl2ZWx5IGltcGFjdGVkIGJ5IHRoaXMgaXNzdWUgYXMgd2VsbC7CoCBBcmUNCj4geW91DQo+IHdp
bGxpbmcgdG8gY29uc2lkZXIgdGhpcyB2aWEgYSBtb3VudCBvcHRpb24/DQo+IA0KPiBCZW4NCj4g
DQoNCkkgZG9uJ3Qgc2VlIGhvdyB0aGF0IGFuc3dlcnMgbXkgY29uY2Vybi4NCg0KSSdkIHJhdGhl
ciBzZWUgdXMgc2V0IHVwIGFuIGV4cGxpY2l0IHRyaWdnZXIgbWVjaGFuaXNtLiBJdCBkb2Vzbid0
IGhhdmUNCnRvIGJlIHBhcnRpY3VsYXJseSBzb3BoaXN0aWNhdGVkLiBJIGNhbiBpbWFnaW5lIGp1
c3QgaGF2aW5nIGEgZ2xvYmFsLA0Kb3IgbW9yZSBsaWtlbHkgYSBwZXItY29udGFpbmVyLCBjb29r
aWUgdGhhdCBoYXMgYSBjb250cm9sIG1lY2hhbmlzbSBpbg0KL3N5cy9mcy9uZnMsIGFuZCB0aGF0
IGNhbiBiZSB1c2VkIHRvIG9yZGVyIGFsbCB0aGUgaW5vZGVzIHRvIGludmFsaWRhdGUNCnRoZWly
IHBlcm1pc3Npb25zIGNhY2hlcyB3aGVuIHlvdSBiZWxpZXZlIHRoZXJlIGlzIGEgbmVlZCB0byBk
byBzby4NCg0KaS5lLiB5b3UgY2FjaGUgdGhlIHZhbHVlIG9mIHRoZSBnbG9iYWwgY29va2llIGlu
IHRoZSBpbm9kZSwgYW5kIGlmIHlvdQ0Kbm90aWNlIGEgY2hhbmdlLCB0aGVuIHRoYXQncyB0aGUg
c2lnbmFsIHRoYXQgeW91IG5lZWQgdG8gaW52YWxpZGF0ZSB0aGUNCnBlcm1pc3Npb25zIGNhY2hl
IGJlZm9yZSB1cGRhdGluZyB0aGUgY2FjaGVkIHZhbHVlIG9mIHRoZSBjb29raWUuDQoNClRoYXQg
d2F5LCB5b3UgaGF2ZSBhIG1lY2hhbmlzbSB0aGF0IHNlcnZlcyBhbGwgcHVycG9zZXM6IGl0IGNh
biBkbyBhbg0KaW1tZWRpYXRlIG9uZS10aW1lIG9ubHkgZmx1c2gsIG9yIHlvdSBjYW4gc2V0IHVw
IGEgdXNlcnNwYWNlIGpvYiB0aGF0DQppc3N1ZXMgYSBnbG9iYWwgZmx1c2ggb25jZSBldmVyeSBz
byBvZnRlbiwgZS5nLiB1c2luZyBhIGNyb24gam9iLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
