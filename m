Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E96C7ACAD9
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Sep 2023 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjIXRJA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Sep 2023 13:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXRI7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Sep 2023 13:08:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2117.outbound.protection.outlook.com [40.107.94.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A93C6
        for <linux-nfs@vger.kernel.org>; Sun, 24 Sep 2023 10:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr4mOcWBM6pDzoV9kYhPkAp2Ee81CONIUZ69NFpnTc51XV60FSFiftTFIu3VPSuOKqus8O2FNt8uVCRu+iM47SA5l4HmMNuXBvWczyXhbcague/3qWchUWuGwK24OkNS+drQuY3hMAvBlQSl8kh/G3rX+dCrrPr7EqSdDl+ot7LwSCNDnMTjB5p4hCuoWAzIA4xoeI0fRn9y2Tgk9PM4o3thGX3EnumYlA3bv+oqnyWhEaJkFIoy0B9xPPbrSjOYuMofwsWBpE4XKaAZ+TVNyL8zESBQH4Di05RNDKCXmgyVTdrOXE4PM6yCNYIVWDCy0703vkxzTrTM9au0Q4teHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e1oln4qLs7VtPi1bCN0uuGOj5Ht/pCLH/jdZ8rX3B4=;
 b=Pq4Am74SylJ8YIRFrGKlbwU6NPRq0nnYVA8eCQbPxjxu18FkokTux0L7AIG4mNj2dGM6gcGDdyJyYLUKlAMpaJJcM1u7IuOf/WMcrMJVe9rB+1tPwK7vBttWBAU2VV63DG9NleXVx1cSqx2Y/3p8WzONcSjwQ/1haDQN3mTduCjTnuVlt0hoKEt80/v76GxkVOE5YFHQiSLa0fXJkAg4VYJMQUtfd9EGiYk+ykf8oqCWCTmpj5jzd8070WbOCPRk2PfpMaH2VIT7KDGeBA/GriNrSz1qmeJYlC1swIqvIbUl1J6J/X6OlRJTRgnM9EgqGSF5aUhDyiY231SjlzuHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e1oln4qLs7VtPi1bCN0uuGOj5Ht/pCLH/jdZ8rX3B4=;
 b=dHBNNwBGi5gf9gkxxZNMR5SNgcE5a493jwRCEgudxe0FXevh2tY7psKwvQT14j7hdmheKo/O9lGYIGzRaOxB5QWguZcWJrLH9sI11tEkNmxm2SuEjyHgTcxP9Ey7lB8Qfw8f+p/Y9ISevPSbGLxDnvjRzIjggKwVD5xfa7ZPgB4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB5060.namprd13.prod.outlook.com (2603:10b6:a03:355::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 24 Sep
 2023 17:08:49 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28e0:7264:5057:7b20%6]) with mapi id 15.20.6813.027; Sun, 24 Sep 2023
 17:08:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
Thread-Topic: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock
 regression
Thread-Index: AQHZ6bx01N78VobVYEyXXSG5Nx3/F7AkIK8AgABNMACAArF1gIAAHKIAgAAgKACAAAHOgIAC4ikA
Date:   Sun, 24 Sep 2023 17:08:48 +0000
Message-ID: <29ac4c1f8017735a6d4f8e48e04172dc91d461ae.camel@hammerspace.com>
References: <20230917230551.30483-1-trondmy@kernel.org>
         <20230917230551.30483-2-trondmy@kernel.org>
         <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com>
         <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>
         <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com>
         <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>
         <CAN-5tyE8u1HCrS9KWQywc3BDvPG2ceZG4kn_vDkJjS-W2mL1KQ@mail.gmail.com>
         <c1c6106c3b4a6106ff706130fe551b424512dd34.camel@hammerspace.com>
In-Reply-To: <c1c6106c3b4a6106ff706130fe551b424512dd34.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB5060:EE_
x-ms-office365-filtering-correlation-id: 623d5c3b-5be3-4718-02e7-08dbbd20eb1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kd3c9IXv00RJ7dhsQDJbpWD8+3BB8WJHeLuk/Ky52E/oQJSCJm2qZVwJvXJCdEjZFWbhUdnfwZdPfIeXWjk8i1g//BErR3aqA9/OfvN7GAiIGJGcZvbd4hLx+iQ0i9b2m1Nm6pQSBCvUCbtxBBP7g/jj1p62uhhDEHQaCNM4P3kZbKFe/J3Gulk/eltguLwjpHFXJdTnhs984vIHBWfZ6FtwBt7TaAW26R97co/vt5SKzPt4TyW5o12Z6mINSBaP1+p65o6lm0YMOakAyj/cMVXHlZ9rxEG2V6yXPlhq+oYQPsw0WLuX74514Fao2r0M/ffleD7J8ily33LZ/FS5c66noDVkSDO9N2rrFmAd4DGweIHUzK1FKjjkTzwdQHhIrmSTTuK/X4COzPHWiU1Wz02GN+ceisGyu1YE0I97r40Njl4lHPC9Tivza/ZfmXHbcC1PngJztUFliFwnLXzVAyk8DKXUZXCmGOcMFaPgyjnjBbRKY+vTS9W4p8lZL2ZyC+ACC0CwRAyWCTT5a9CfJY6CZo8hA6I1r0WmQaSXmNx/epjIUjkOE+jIOC2Uv5Gb5OVUGLs5FrnDia6VHPg+rE3r3Eq6RhV/HZ1YkqXmkQKGcSVZMJ1KRwdAuDd7grrD39erwwMC/WRD4OV1Jaxymgtz+YNF+Qmo2lSLBmK0MTI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(366004)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6506007)(26005)(71200400001)(2616005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(86362001)(478600001)(122000001)(38070700005)(38100700002)(83380400001)(54906003)(2906002)(4326008)(36756003)(8936002)(8676002)(6916009)(316002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW52Q08xQzJZWnZsMWdEcmN5dzVYTjRhSzFmWWozbHNqQmdFclJwL2pQSzU3?=
 =?utf-8?B?elZOOWVOeXlvcFA2U2hZVGxSRkMxWEFPWERMZEgyVUNGcEttci8rU2xtZTdl?=
 =?utf-8?B?SHUvbi9UNlhSd0pDQzEwRDlsbmpKMWJPM2E1alRWd3RicWpPY1krNEx1NTRW?=
 =?utf-8?B?dkttS2cwQ0phMXdKN1JTNWFZbFlMbXhxRjVzbGFuZlRhcS9zZExCZWI1RUdi?=
 =?utf-8?B?UFJrSzdtZXlOZlZ1VzhMTWtMdHNYb3RKc2tXa2prTTVxRmFoS082OThRTEdM?=
 =?utf-8?B?dXozNzQ4SGFTZC9oQWFQd1E4cno1VHh5UUZWSm9mcUY5NkZyQXBXUnZkdmMr?=
 =?utf-8?B?eEpERHl2Q0hwdUxaSkZ5c203RlZqZjVwZzVZWG13d1RPWVAwTFM3dk5jdlJR?=
 =?utf-8?B?bFp3eHBaaEtLcWxDaWdIeitBTVNncFB5YlErY1A2ZytVNnlzdWZTdEo4ZlVC?=
 =?utf-8?B?SytxTC9ybVc1Y2g5WTJDdTRDZk01TjJ3OHpkeDM5WEJhN2RrZ3NpcTJxa3p4?=
 =?utf-8?B?VnB1YTRYVUdvclJMVmRRKzZjaGhVRG56WElzcDVFN0tySlkrTkNZMi9KZVV5?=
 =?utf-8?B?N1NTV0dIWTZMS0QrYndQUWlEMDBDbUxIeG9oQlBpRjczVXJ3ci9tMjBqWGJ2?=
 =?utf-8?B?emwzV2NwVkNoUG13RTAvWncvYkFpWmlKQ2pPRTQrZW0xbzYyMlZTWnJVOE04?=
 =?utf-8?B?Z3lTTGc0bXN1WTB2ckdtVjdJUWFwSitucTFwK2h6Z1cxcTl2TitxdnJvMHZG?=
 =?utf-8?B?TEtjaFpqdmtyRWJNeHhLZVI3ZGp1NUFKVVc3UGxKSVRjLy9ubm9QV2hzcnRx?=
 =?utf-8?B?YnJyVm9tNmxIZVpOTkFraXRnTnEzZjA5NGIvYjdKUlIwSkdKbzJtRC9RdHNl?=
 =?utf-8?B?cUZXMHhmSnIrR1I3L0k0U01GZDMreGd1YmZtYkUxSkpXdlFNUDJBbStmNGtG?=
 =?utf-8?B?aTRzVzZlZnF3VTlaby9wRnJkYituMWhvM0hpUHdteVhhOFhhK1pLT1RuQ3Np?=
 =?utf-8?B?bWt3ZzFwYkFUUnl6b05GcnhZV2RWR1RsbmE4d0VFNzFXM2RxSFJpUHlKZThH?=
 =?utf-8?B?c081T001UnozcG51V1FKNDh0NkptWWg1K3dPYjlsL1Y5NEEyTkIrbzU3ZEhX?=
 =?utf-8?B?dVFXODNwSUpjbDhpUEZxVFc0M1QxZXJrM0FRS3hOMnZaajRiVWJLK2RiYXFo?=
 =?utf-8?B?UzJydDlrNXdOcEt6dXJhYXFEQXRYdExoWURZZ24vVWM5cDMwNnhZR2xuaEEy?=
 =?utf-8?B?YmZ2bFV0QlpEbTBHUDUveW5ieUlJazk0Rjl6NEIrRkRlVzVYMW9XVDdiYXhS?=
 =?utf-8?B?aW9IMGExRHVWaXdQQld4L2Zhd1c5Y3hBMWwzVlRIa1BoUEtxcGFoUDZRMFNy?=
 =?utf-8?B?TmZGUlFEODdpNHQxUWVzdDFDb3BEOWwxK2xzREhYVVlKRDJKcHJxNjBaUkJU?=
 =?utf-8?B?U1N1QUd0Sk14R3hIT3ZOeVA0QnptMU1PNlRDNXFPS1VtcHMvNFV3R1FubWxG?=
 =?utf-8?B?OGhqeEZ3L3ozSm9wZjA4UlR5YWxTZUJ5aVRUZFQxV08yR0I2N2hQcUhXYUxT?=
 =?utf-8?B?aGxtRVRRU2VjYllocDJCR2dBTEhxV3hmbFUxSWRZU25nSTZlTVlaeTFVTHd2?=
 =?utf-8?B?NHpEWngxV3FTcitJS0pzQTR0dXRDTG9Gd3RuTS9UZTZqREtrOXp0dXpYNVU2?=
 =?utf-8?B?TExlc0hiYTB5NHUvaC9TYVlUVFg5SktYSEZSWkRXaTB6RU1odEcvVVZBMlRq?=
 =?utf-8?B?bGNuajJaUi9LakpCaFdKc3U3SW9pcUI2WDNKVW9KQjltd0hIWjEzazBBYTZ1?=
 =?utf-8?B?N0NvWkZaUm9KTkUvZ2F0RjNGY0VQdUt6RUJ5VDhKcXdXVUQzYVhVeXZQcHVW?=
 =?utf-8?B?RnUvbTEyK0ZBeFhQbC9IeVEvZkFHRlorZ0llaFZCUm9UKy9ON29QWVh3RW0z?=
 =?utf-8?B?K1RCQ1BWS3F2cENJazhHV0dXTkpwRERQZktvb0VGR2Z6alFNN3lNMHlsYURk?=
 =?utf-8?B?RDB5K2RPQWVhMkhDMm5RSmljZHBwb2RJcmk1bXZHQU9Tb1NZWTVOUWY5Y0Fp?=
 =?utf-8?B?ZnBkR0VYNjVuOFNWYlpoeGpkaERQdTNHOWY5VXNFNjJiRitZQm9VMmZOYkNm?=
 =?utf-8?B?OEM5bDFTaHNyV1VtTlVZUGNVT1RGdGpZM25ZeE5sTjBQQ0NRQ2p3elFpWDJm?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B06D34C62BF9284D9B2DA146785E524B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623d5c3b-5be3-4718-02e7-08dbbd20eb1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2023 17:08:48.4052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqGNvJCxvWMCOBsHD/1+7l75GUFYgSVkEuXSYdx1fhiorVWKOkewFxVwSv5Npq/24JZ+0HPKlUKiaxlOyvqPsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB5060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDE3OjA2IC0wNDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIEZyaSwgMjAyMy0wOS0yMiBhdCAxNzowMCAtMDQwMCwgT2xnYSBLb3JuaWV2c2thaWEg
d3JvdGU6DQo+ID4gT24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMzowNeKAr1BNIFRyb25kIE15a2xl
YnVzdCANCj4gPiA+IA0KPiA+ID4gT2ggY3JhcC4uLiBZZXMsIHRoYXQgaXMgYSBidWcuIENhbiB5
b3UgcGxlYXNlIGFwcGx5IHRoZSBhdHRhY2hlZA0KPiA+ID4gcGF0Y2gNCj4gPiA+IG9uIHRvcCBv
ZiB0aGUgb3JpZ2luYWwsIGFuZCBzZWUgaWYgdGhhdCBmaXhlcyB0aGUgcHJvYmxlbT8NCj4gPiAN
Cj4gPiBJIGNhbid0IGNvbnNpc3RlbnRseSByZXByb2R1Y2UgdGhlIHByb2JsZW0uIE91dCBvZiBz
ZXZlcmFsIHhmc3Rlc3RzDQo+ID4gcnVucyBhIGNvdXBsZSBnb3Qgc3R1Y2sgaW4gdGhhdCBzdGF0
ZS4gU28gd2hlbiBJIGFwcGx5IHRoYXQgcGF0Y2gNCj4gPiBhbmQNCj4gPiBydW4sIEkgY2FuJ3Qg
dGVsbCBpZiBpJ20gbm8gbG9uZ2VyIGhpdHRpbmcgb3IgaWYgSSdtIGp1c3Qgbm90DQo+ID4gaGl0
dGluZw0KPiA+IHRoZSByaWdodCBjb25kaXRpb24uDQo+ID4gDQo+ID4gR2l2ZW4gSSBkb24ndCBl
eGFjdGx5IGtub3cgd2hhdCdzIGNhdXNlZCBpdCBJJ20gdHJ5aW5nIHRvIGZpbmQNCj4gPiBzb21l
dGhpbmcgSSBjYW4gaGl0IGNvbnNpc3RlbnRseS4gQW55IGlkZWFzPyBJIG1lYW4gdGhpcyBzdGFj
aw0KPiA+IHRyYWNlDQo+ID4gc2VlbXMgdG8gaW1wbHkgYSByZWNvdmVyeSBvcGVuIGJ1dCBJJ20g
bm90IGRvaW5nIGFueSBzZXJ2ZXIgcmVib290cw0KPiA+IG9yDQo+ID4gY29ubmVjdGlvbiBkcm9w
cy4NCj4gPiANCj4gPiA+IA0KPiANCj4gSWYgSSdtIHJpZ2h0IGFib3V0IHRoZSByb290IGNhdXNl
LCB0aGVuIGp1c3QgdHVybmluZyBvZmYgZGVsZWdhdGlvbnMNCj4gb24NCj4gdGhlIHNlcnZlciwg
c2V0dGluZyB1cCBhIE5GUyBzd2FwIHBhcnRpdGlvbiBhbmQgdGhlbiBydW5uaW5nIHNvbWUNCj4g
b3JkaW5hcnkgZmlsZSBvcGVuL2Nsb3NlIHdvcmtsb2FkIGFnYWluc3QgdGhlIGV4YWN0IHNhbWUg
c2VydmVyIHdvdWxkDQo+IHByb2JhYmx5IHN1ZmZpY2UgdG8gdHJpZ2dlciB5b3VyIHN0YWNrIHRy
YWNlIDEwMCUgcmVsaWFibHkuDQo+IA0KPiBJJ2xsIHNlZSBpZiBJIGNhbiBmaW5kIHRpbWUgdG8g
dGVzdCBpdCBvdmVyIHRoZSB3ZWVrZW5kLg0KDQo+IA0KDQpZZXAuLi4gQ3JlYXRpbmcgYSA0RyBl
bXB0eSBmaWxlIG9uIC9tbnQvbmZzL3N3YXAvc3dhcGZpbGUsIHJ1bm5pbmcNCm1rc3dhcCAgYW5k
IHRoZW4gc3dhcG9uIGZvbGxvd2VkIGJ5IGEgc2ltcGxlIGJhc2ggbGluZSBvZg0KCWVjaG8gImZv
byIgPi9tbnQvbmZzL2Zvb2Jhcg0KDQp3aWxsIGltbWVkaWF0ZWx5IGxlYWQgdG8gYSBoYW5nLiBX
aGVuIEkgbG9vayBhdCB0aGUgc3RhY2sgZm9yIHRoZSBiYXNoDQpwcm9jZXNzLCBJIHNlZSB0aGUg
Zm9sbG93aW5nIGR1bXAsIHdoaWNoIG1hdGNoZXMgeW91cnM6DQoNCltyb290QHZtdy10ZXN0LTEg
fl0jIGNhdCAvcHJvYy8xMTIwL3N0YWNrIA0KWzwwPl0gbmZzX3dhaXRfYml0X2tpbGxhYmxlKzB4
MTEvMHg2MCBbbmZzXQ0KWzwwPl0gbmZzNF93YWl0X2NsbnRfcmVjb3ZlcisweDU0LzB4OTAgW25m
c3Y0XQ0KWzwwPl0gbmZzNF9jbGllbnRfcmVjb3Zlcl9leHBpcmVkX2xlYXNlKzB4MjkvMHg2MCBb
bmZzdjRdDQpbPDA+XSBuZnM0X2RvX29wZW4rMHgxNzAvMHhhOTAgW25mc3Y0XQ0KWzwwPl0gbmZz
NF9hdG9taWNfb3BlbisweDk0LzB4MTAwIFtuZnN2NF0NCls8MD5dIG5mc19hdG9taWNfb3Blbisw
eDJkOS8weDY3MCBbbmZzXQ0KWzwwPl0gcGF0aF9vcGVuYXQrMHgzYzMvMHhkNDANCls8MD5dIGRv
X2ZpbHBfb3BlbisweGI0LzB4MTYwDQpbPDA+XSBkb19zeXNfb3BlbmF0MisweDgxLzB4ZTANCls8
MD5dIF9feDY0X3N5c19vcGVuYXQrMHg4MS8weGEwDQpbPDA+XSBkb19zeXNjYWxsXzY0KzB4Njgv
MHhhMA0KWzwwPl0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NmUvMHhkOA0KDQpX
aXRoIHRoZSBmaXggSSBzZW50IHlvdToNCg0KW3Jvb3RAdm13LXRlc3QtMSB+XSMgbW91bnQgLXQg
bmZzIC1vdmVycz00LjIgdm13LXRlc3QtMjovZXhwb3J0IC9tbnQvbmZzDQpbcm9vdEB2bXctdGVz
dC0xIH5dIyBta3N3YXAgL21udC9uZnMvc3dhcC9zd2FwZmlsZSANCm1rc3dhcDogL21udC9uZnMv
c3dhcC9zd2FwZmlsZTogd2FybmluZzogd2lwaW5nIG9sZCBzd2FwIHNpZ25hdHVyZS4NClNldHRp
bmcgdXAgc3dhcHNwYWNlIHZlcnNpb24gMSwgc2l6ZSA9IDQgR2lCICg0Mjk0OTYzMjAwIGJ5dGVz
KQ0Kbm8gbGFiZWwsIFVVSUQ9MTM2MGIwYTMtODMzYS00YmE3LWI0NjctOGE1OWQzNzIzMDEzDQpb
cm9vdEB2bXctdGVzdC0xIH5dIyBzd2Fwb24gL21udC9uZnMvc3dhcC9zd2FwZmlsZQ0KW3Jvb3RA
dm13LXRlc3QtMSB+XSMgcHMgLWVmd3cgfCBncmVwIG1hbmFnZQ0Kcm9vdCAgICAgICAgMTIxNCAg
ICAgICAyICAwIDEzOjA0ID8gICAgICAgIDAwOjAwOjAwIFsxOTIuMTY4Ljc2LjI1MS1tYW5hZ2Vy
XQ0Kcm9vdCAgICAgICAgMTIxNiAgICAxMTQ3ICAwIDEzOjA0IHB0cy8wICAgIDAwOjAwOjAwIGdy
ZXAgLS1jb2xvcj1hdXRvIG1hbmFnZQ0KW3Jvb3RAdm13LXRlc3QtMSB+XSMgZWNobyAiZm9vIiA+
L21udC9uZnMvZm9vYmFyDQpbcm9vdEB2bXctdGVzdC0xIH5dIyBjYXQgL21udC9uZnMvZm9vYmFy
DQpmb28NCg0KU28gdGhhdCByZXR1cm5zIGJlaGF2aW91ciB0byBub3JtYWwgaW4gbXkgdGVzdGlu
ZywgYW5kIEkgbm8gbG9uZ2VyIHNlZQ0KdGhlIGhhbmdzLg0KDQpMZXQgbWUgc2VuZCBvdXQgYSBQ
QVRDSHYyLi4uDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
