Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2144F6CEA
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Apr 2022 23:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiDFVjq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 17:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbiDFVjK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 17:39:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2095.outbound.protection.outlook.com [40.107.220.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD0FDF12
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 14:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH6oj8fSNgDUT0EKnr7rvWyRav7IRRwSJW1EdUVxbYoSChHCKm9hYiOq9vLnZtcVxT73ahdT9JNNhJBwr6cv2TO5aKDuyukEvs4WlAC9fXAFudyP+QY+Qvz+2T+6tgcBDqkbxxPCJvyEs7uBnCOSfvaZCx6/qV0y+thMo5HOG2pQw3C92hMCo/t/6sy+Ac3uPphher8Y2TiFUx1hZeEV0WtOROWPkWh2mSZm0VJIg4aTV3OtkRDq8Hkk0ZniqjB65yPG2p2X9Gsjy7tLUFMpVwrUrZ/QpZFfNzf76KNsyxdvlqhErygCCSXRsDNSB+ahlBlg/XTJnEOoWuE9y0eReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQgT8SmVKRvgrlQJrSMtsGdOf+063eEkmFKAhWXPYmk=;
 b=fq8gX/KgZYdPUQQ2EsXj46aRTY16bBv5RQSxS33W7IAhxHkpK2+Nrtaxl7Osz9XRA3ehRUqP0lP3KtCfkkt1Z3txqbirTbejfId67XUpI2tJgqG3bwXc8dbanaLKeE0x+nxqBRzU+vfe5MBNTtY1gxIgXmpdxgmSTsnlDjQGHtleTZi7OvhyYMjNkiwCV6y6n5j+pXY4ovlYgCvcWzfrcpNH6e582W7zD3AjNV2ryxtBsBFnDjtAGnrHVqU0PPBZGQCXVfvMqslqujgjLFEiex1I8G2ETD+StDQM8i/CqymAcPwIaGgmmunqeDhyBWLUNWZG8q26/0+TJ7qfT3PGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQgT8SmVKRvgrlQJrSMtsGdOf+063eEkmFKAhWXPYmk=;
 b=f6gvPRFoh85Ofv9LvOZe2mJl6fIPyW+metQC8MnU5ugXFD7V9ZkZ+C2ksJCohH0E5v8l2m5wY+DrySXQPpW/zZU0cExk/RggNqEGYbqCK6hJBSq0UdnkaoMhOx8ZJA1DAcrrpn8XVhonIjDPWl2aI2x57+YnkK4zc1YXN38sZ/E=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4759.namprd13.prod.outlook.com (2603:10b6:408:120::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Wed, 6 Apr
 2022 21:17:15 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 21:17:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] SUNRPC: Fix the svc_deferred_event trace class
Thread-Topic: [PATCH v2 2/2] SUNRPC: Fix the svc_deferred_event trace class
Thread-Index: AQHYSe+HymHLwioJ0U2H/VB83m8N4KzjV6+AgAAFtQCAAAYbgA==
Date:   Wed, 6 Apr 2022 21:17:15 +0000
Message-ID: <c4bea3892c7d219138c3a9ee961bab40e3d1c246.camel@hammerspace.com>
References: <164926821551.12216.9112595778893638551.stgit@klimt.1015granger.net>
         <164926848846.12216.6872977249610829189.stgit@klimt.1015granger.net>
         <7976abc7a7ea7bbc445256884d0164a1b3ac5bb6.camel@hammerspace.com>
         <0942D638-0F40-4811-9820-AECAA65D529B@oracle.com>
In-Reply-To: <0942D638-0F40-4811-9820-AECAA65D529B@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8788a241-c36b-4662-6e0a-08da1812d302
x-ms-traffictypediagnostic: BN0PR13MB4759:EE_
x-microsoft-antispam-prvs: <BN0PR13MB4759D3F8A9A03476AC8D4CBCB8E79@BN0PR13MB4759.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xPjYj7n6T0lGYQzS9znsHrHCs1LJaY7NGnSnZmNMwcwWL0Qwv7/hhrlah5HkGD1lTNT5kJy36h9MVj4zzdtpN3zg9d5tN18ckAs/DQeVv2FyW1KmOG28dPMKReTWZ+hd7Hjonfms3QVfVQG07tqSuFS/oseCOQto9OZvx29ODB3XReOtvzFOxufJ1ZT1heOJEiH4TO4mzGgaSGrE/Nt7ogcsb9a7ScjfrX5cNPR1r16W/r4xkT5zkP2PuPrq3byArMy+b1cbV0+bIqIsn5aFZEpT1xGU6t97jomvc64Bcuqdk0peR1xNzDXPu1kctmWbxBRv2QLUIcA9fm4ylYoJAtZhlmHGJ3ml/mdIaNwoUJeRFu1HW7uA/msQOqUmyxQ/yp5n/CkFxC+4w4Jay47LTdPTpqKF3660GSdkF4DirVpU98kOlNO8G9oDYstWSff/5m0hi8vR8yZyd+s/kuAsq4K4OvyfD6DLdYUkkqFnNXWuFZz5Ac26CnyW+R1RY7eaoosdiP3ZN4kkFWsO2EhM0fgwgZo2p9HFSSE8wy92jmfgnzOH3vgvth2ptn/WI04GPFBoJ6TGTUefjcgD4gmeSlYFz2lkzrYctacQFRTTgFFMtUBDiz7Slp7e7PWQZ8zMMZAIVd1ZO2+HQUOSarooRAFvT98RBa+DsiSCGpdr2Or0aelDXdNiXCnRM4ZNn3l4h683SRC6j48fx880QCWJrUsLUKfqwhQFUlQQNFmBw49/5mT3Xk9XFZmtAjenw7l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(83380400001)(38100700002)(66946007)(122000001)(38070700005)(76116006)(8936002)(5660300002)(4326008)(64756008)(66446008)(6512007)(8676002)(6506007)(53546011)(6916009)(2616005)(508600001)(71200400001)(6486002)(66556008)(36756003)(186003)(26005)(66476007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk9kRFNTTnJWTU5KdjlvM2o1c1NEM25TQWZOSkdOT2JydjdKY1c3bXdYZkU0?=
 =?utf-8?B?Kys0SVNyV0lKM1dWTzVsRlY4WVh0YytQd1JNM0I0Q243SUlZbENIUkJEWHA4?=
 =?utf-8?B?N0UwMjE3eFppMmNVQlc4YkdTZENER0UrNmRIUCtHZVFPdVdWTU1ubXBQSFBi?=
 =?utf-8?B?ZFdWU0xtcHVROU1xeTVwUXFrK2lQSXBSN2xFOEJNSjVwN3VMQVdHWHovM0I4?=
 =?utf-8?B?ODdKazNCZ1VFKzRoQmYyckpVL3NjY0ZXMUhJL2RxRUhMMWgxQ0ZYVXcxZ1d6?=
 =?utf-8?B?R1ZPbUFQS0NBMEc0OUJVSFBQQjNRaWI4K0ZPTnBRME9OMDRhRitzUkJqalhU?=
 =?utf-8?B?azB2WmgweC83TWZIa1E0ekd4NTdIOTFUZFM4ajFiL1Q4R0FOcEhMRzJMYUQr?=
 =?utf-8?B?T0hFTUJiVks4NnZhQVlLWFYycVZoT2xpWlp0bUt0Y1FMNEM1cW9KcWxISmFH?=
 =?utf-8?B?VUZuenVMNnJVdlM0ZVZGMU9meHdDYjQ1SkxrZUVmNHY1bmFGaERSU2ZBai9D?=
 =?utf-8?B?RjlxMDlETjY5OTY4ZU9YTmRjcHhSdlRUaVlBUlVGV3BnRVM0ejlJMlhwMnM5?=
 =?utf-8?B?MEFWeEk3Tm5sMkVqMnhkazhYUTE0anhBeGQrcTJnam1sdzl5dGJSUVZKNDZG?=
 =?utf-8?B?Y203bFBPR3hQWlBOeUdlTVBmZFYxQ080M05UdHJWYUtMdDFtdUZUN2lFTGRu?=
 =?utf-8?B?eFA1UnhTK3F6bTJZUDJZcU1rWDVGMEF0QUlSNnhwR2I0dTBHYTJvUmZ0Z1pk?=
 =?utf-8?B?Y2tLZXR6UlFLdXBCTkZWZXptcFVEeW1pY1ZoN29PNUhBRldkMjY1RldnRENO?=
 =?utf-8?B?WXhrR3NjdWtUOUMreUo2YVNrSG16d1M4bE5zeU9Rd0RTclRPTUVISldwNlBp?=
 =?utf-8?B?SXRUQkowSEZIUVhHSGxZSTNtdW1MUVQ5V3hQQXhMZWR6cjkySWlMMVI2ZXpZ?=
 =?utf-8?B?TEJaYUdCeWE0N2F6VEVwdXAvc3ZncmdVRW9JQjltbFgySmpSZDZRY1ZCYmdq?=
 =?utf-8?B?WDJaUG9UOWVVelBhdFZNVUt0QlJmRGNyU21udVFwa0tHaVh5cjJXQTE2cmNp?=
 =?utf-8?B?Vk1BaldWN2xMdHVnM2ZtQ1hERjQ2VzJlYndRWHRYd2xpVXIzZjJTVmE4QndI?=
 =?utf-8?B?N251V04ydUw5VTFIMFljUUpxV1pxcnlVN2FpQzVXVlR4QlRrUExtUmxSTU4y?=
 =?utf-8?B?aFV6MTUzWTNGREloRzY2UHFnOG9kemlMYUxJcTNTWkRLd1Rka09YczY4cWt5?=
 =?utf-8?B?bm9OTzVJd3Y1LzFlU1hSZ3FJelE5eExoUzdoK29WVTQ3ZWlrTk9ZdGh4TWJE?=
 =?utf-8?B?R0Z6OWJNV3p0WlJZQURTRHRFRlRjSGtXTTh6aUYxNGJrTFhXZGtFU0VNc3Q1?=
 =?utf-8?B?VFA0N2o4TGcrTGVMRHBOakNaS0sraS8zeU0vVm93NDh6Si9hbDkrL3FXSmZv?=
 =?utf-8?B?L0QrSS83RU5sc2hUMktXYUxaZWFuTlJUeldZWENqdi92Nlp3M2tqaU9qdWdj?=
 =?utf-8?B?QlBwWkIxckwvS1ZwcWlMdmY3cHZUQkFOQTNMVUNKSGdEcnhNTWl3dWdudzFh?=
 =?utf-8?B?Q2xPeEEvNVFndUVMYjIxTDQvRUdhNkJXVVc4VzYvc0xxdnkzeGI0OWJFNTlV?=
 =?utf-8?B?UGtIV2JJaXZSUktnOW9JRnFhNnBLQzF6ZjhCazFzSGZJQ3lpWjlhR0FiNk1L?=
 =?utf-8?B?WHlxTmhrbE9FbzBDRFVxWnpZTDQ3eGFXcGNiTVVITlFPR0c5ZnQ2cEwyOVJS?=
 =?utf-8?B?N0tFRlZTNXd5VzI5Ym5WcWJFMFBYQ1FVS2RkU3Vjd1IwMUwwQk4wR2JnV3VI?=
 =?utf-8?B?cG1aS2wvOHovVjh4V2ZUdTVaQzFPVWU2RXRraGdSMTMrWENiQktWT3pObGhQ?=
 =?utf-8?B?WVQ0aEVtQkVia0svemYwMC84R0pBMmpQTWVIOUJVM1ZqL2ZxaXdvdEhzanV5?=
 =?utf-8?B?alorUzRUc2kzWlR4bGNoeTJIMTQvSlZjc01CS29sRHVkck9HblhQUWJ0OUpU?=
 =?utf-8?B?MUxSTWlPdDdIMnFOVytIVVQ2ZFppaVlKUFV5bHl6U3VsT1ptcENFY2wwN2J4?=
 =?utf-8?B?dWV6dU14dCtEL21vaklldGhnbWhsaHdwWFhvUGZaQkZxZDduQVhBaGwxdVQw?=
 =?utf-8?B?b0xtOE1GdW0yOHpRbHJNUUlkeXhDMVc2WGtvek90ZlROeVNSQ2ZWanRqa1Vp?=
 =?utf-8?B?ei9OTU0xNFB5K1d1MjkvUkh3WThxNENCZGtON3FTcFFHVnc1ODZTYVRDS01R?=
 =?utf-8?B?eitGdGUveHVQWEdRMjhYa2lWUVp6Ymx0OEZydHg1d0EreG96aEtBanFjaWk1?=
 =?utf-8?B?K2NaZms0VGJGZXM4WG1IVGZSTUo5YWROK0dUcGQwZEFTSmI5RUJSRzZXY0ZJ?=
 =?utf-8?Q?zjDBj8R+rFLgo3LY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F94E61C8496174CAEC7613238AEBC33@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8788a241-c36b-4662-6e0a-08da1812d302
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 21:17:15.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSwCmOYDsRTEOdrb/IeJMRz0stCxjpEF+qF3aJFry5/rrq+WoFjjUCXEn2q7Zj3Ihju54VNX4/YQnmwFHDHWuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4759
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA0LTA2IGF0IDIwOjU1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBBcHIgNiwgMjAyMiwgYXQgNDozNCBQTSwgVHJvbmQgTXlrbGVidXN0
DQo+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQs
IDIwMjItMDQtMDYgYXQgMTQ6MDggLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+ID4gRml4
IGEgTlVMTCBkZXJlZiBjcmFzaCB0aGF0IG9jY3VycyB3aGVuIGFuIHN2Y19ycXN0IGlzIGRlZmVy
cmVkDQo+ID4gPiB3aGlsZSB0aGUgc3VucnBjIHRyYWNpbmcgc3Vic3lzdGVtIGlzIGVuYWJsZWQu
IHN2Y19yZXZpc2l0KCkgc2V0cw0KPiA+ID4gZHItPnhwcnQgdG8gTlVMTCwgc28gaXQgY2FuJ3Qg
YmUgcmVsaWVkIHVwb24gaW4gdGhlIHRyYWNlcG9pbnQgdG8NCj4gPiA+IHByb3ZpZGUgdGhlIHJl
bW90ZSdzIGFkZHJlc3MuDQo+ID4gPiANCj4gPiA+IFNpbmNlIF9fc29ja2FkZHIoKSBhbmQgZnJp
ZW5kcyBhcmUgbm90IGF2YWlsYWJsZSBiZWZvcmUgdjUuMTgsDQo+ID4gPiB0aGlzDQo+ID4gPiBp
cyBqdXN0IGEgcGFydGlhbCByZXZlcnQgb2YgY29tbWl0IGVjZTIwMGRkZDU0YiAoInN1bnJwYzog
U2F2ZQ0KPiA+ID4gcmVtb3RlIHByZXNlbnRhdGlvbiBhZGRyZXNzIGluIHN2Y194cHJ0IGZvciB0
cmFjZSBldmVudHMiKSBpbg0KPiA+ID4gb3JkZXINCj4gPiA+IHRvIGVuYWJsZSBiYWNrcG9ydHMg
b2YgdGhlIGZpeC4gSXQgY2FuIGJlIGNsZWFuZWQgdXAgZHVyaW5nIGENCj4gPiA+IGZ1dHVyZSBt
ZXJnZSB3aW5kb3cuDQo+ID4gPiANCj4gPiA+IEZpeGVzOiBlY2UyMDBkZGQ1NGIgKCJzdW5ycGM6
IFNhdmUgcmVtb3RlIHByZXNlbnRhdGlvbiBhZGRyZXNzIGluDQo+ID4gPiBzdmNfeHBydCBmb3Ig
dHJhY2UgZXZlbnRzIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGluY2x1ZGUvdHJhY2UvZXZlbnRz
L3N1bnJwYy5oIHzCoMKgwqAgOSArKysrKy0tLS0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5oDQo+ID4gPiBiL2luY2x1ZGUvdHJhY2UvZXZl
bnRzL3N1bnJwYy5oDQo+ID4gPiBpbmRleCBhYjhhZTFmNmJhODQuLjRhYmMyZmRkZDNiOCAxMDA2
NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5oDQo+ID4gPiArKysg
Yi9pbmNsdWRlL3RyYWNlL2V2ZW50cy9zdW5ycGMuaA0KPiA+ID4gQEAgLTIwMTcsMTggKzIwMTcs
MTkgQEAgREVDTEFSRV9FVkVOVF9DTEFTUyhzdmNfZGVmZXJyZWRfZXZlbnQsDQo+ID4gPiDCoMKg
wqDCoMKgwqDCoCBUUF9TVFJVQ1RfX2VudHJ5KA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIF9fZmllbGQoY29uc3Qgdm9pZCAqLCBkcikNCj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBfX2ZpZWxkKHUzMiwgeGlkKQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgX19zdHJpbmcoYWRkciwgZHItPnhwcnQtPnhwdF9yZW1vdGVidWYpDQo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2R5bmFtaWNfYXJyYXkodTgsIGFk
ZHIsIGRyLT5hZGRybGVuKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgKSwNCj4gPiA+IMKgDQo+ID4g
PiDCoMKgwqDCoMKgwqDCoCBUUF9mYXN0X2Fzc2lnbigNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBfX2VudHJ5LT5kciA9IGRyOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIF9fZW50cnktPnhpZCA9IGJlMzJfdG9fY3B1KCooX19iZTMyICopKGRyLT5h
cmdzICsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAoZHItDQo+ID4gPiA+IHhwcnRfaGxlbj4+MikpKTsNCj4gPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF9fYXNzaWduX3N0cihhZGRyLCBkci0+eHBydC0+eHB0X3JlbW90
ZWJ1Zik7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1jcHkoX19nZXRf
ZHluYW1pY19hcnJheShhZGRyKSwgJmRyLT5hZGRyLCBkci0NCj4gPiA+ID4gYWRkcmxlbik7DQo+
ID4gPiDCoMKgwqDCoMKgwqDCoCApLA0KPiA+ID4gwqANCj4gPiA+IC3CoMKgwqDCoMKgwqAgVFBf
cHJpbnRrKCJhZGRyPSVzIGRyPSVwIHhpZD0weCUwOHgiLCBfX2dldF9zdHIoYWRkciksDQo+ID4g
PiBfX2VudHJ5LT5kciwNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZW50
cnktPnhpZCkNCj4gPiA+ICvCoMKgwqDCoMKgwqAgVFBfcHJpbnRrKCJhZGRyPSVwSVNwYyBkcj0l
cCB4aWQ9MHglMDh4IiwNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChzdHJ1
Y3Qgc29ja2FkZHIgKilfX2dldF9keW5hbWljX2FycmF5KGFkZHIpLA0KPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgX19lbnRyeS0+ZHIsIF9fZW50cnktPnhpZCkNCj4gPiA+IMKg
KTsNCj4gPiA+IA0KPiA+IA0KPiA+IEhhdmUgeW91IHRlc3RlZCB0aGlzPyBJIGZvdW5kIG15c2Vs
ZiBoaXR0aW5nIHRoZSB3YXJuaW5nDQo+ID4gDQo+ID4gImV2ZW50ICVzIGhhcyB1bnNhZmUgZGVy
ZWZlcmVuY2Ugb2YgYXJndW1lbnQgJWQiDQo+ID4gDQo+ID4gaW4gdGVzdF9ldmVudF9wcmludGso
KSB3aGVuIEkgdHJpZWQgdG8gdXNlIHNvbWV0aGluZyBzaW1pbGFyIGZvcg0KPiA+IHRoZQ0KPiA+
IE5GUyBjb2RlLg0KPiANCj4gVGhlIHdhcm5pbmcgaXMgZml4ZWQgYnkgYzZjZWQyMjk5N2FkICgi
dHJhY2luZzogVXBkYXRlIHByaW50DQo+IGZtdCBjaGVjayB0byBoYW5kbGUgbmV3IF9fZ2V0X3Nv
Y2thZGRyKCkgbWFjcm8iKS4gSSB0aGluaw0KPiB0aGlzIG1lYW5zIHRoYXQgYWxvbmcgd2l0aCB0
aGUgYWJvdmUgcGF0Y2gsIGM2Y2VkMjI5OTdhZCB3aWxsDQo+IG5lZWQgdG8gYmUgYmFja3BvcnRl
ZCB0byBzb21lIHJlY2VudCBzdGFibGUga2VybmVscy4NCj4gDQo+IElmIHlvdSdyZSBhZGRpbmcg
ZHluYW1pY2FsbHktc2l6ZWQgc29ja2FkZHIgZmllbGRzIGluIHRyYWNlDQo+IHJlY29yZHMsIEkg
aW52aXRlIHlvdSB0byBjb25zaWRlciBfX3NvY2thZGRyL19fZ2V0X3NvY2thZGRyKCksDQo+IGFk
ZGVkIGluIHY1LjE4Lg0KPiANCg0KSW50ZXJlc3RpbmcuLi4gSSBoYWRuJ3Qgc2VlbiB0aGF0IGNo
YW5nZS4gSXQgbG9va3MgaG93ZXZlciBhcyBpZiB0aGF0DQppcyBleHBsaWNpdGx5IGNoZWNraW5n
IGZvciB0aGUgX19nZXRfc29ja2FkZHIoKSBzdHJpbmcsIHNvIHlvdSdkIGhhdmUNCnRvIGNvbnZl
cnQgdGhpcyBwYXRjaC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
