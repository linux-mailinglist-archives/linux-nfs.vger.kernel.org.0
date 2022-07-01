Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F17563920
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Jul 2022 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiGASWz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Jul 2022 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGASWz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Jul 2022 14:22:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0B919289
        for <linux-nfs@vger.kernel.org>; Fri,  1 Jul 2022 11:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1Pu5Ld/pYnrG22yxm/Urz28wDCDTPlTZEL6mvvKtt0C1h2ydxC6ZNSy2dgqEtLP5FeYd2rcZxvEYpfZchh2/wVtQsiibuZAZj4n7cLrQIbRFpWuVNf7gjIwaZ46vz75g+LOeD52jIKwqb/0NqsEG/A7T5yIsIsTCh4Ql9ZRNqDs0t1PRO5xsxfvt/X1dJintyxZvLYpzqhJBAqSpgRdPevNCEARFb/xqLkDZVJ7KzC0BKtGprFT1mRxlQbUbZ0eeaCQFRV/4rIgxFKY50DpUGpTMGO7DBcoyy3LuWXBdEwofrG3kFhqtN0gS5YyBNpMbwRbOj+kxXKeiUAEKHacqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=423GJdI2pPwDoCy/R/Q/rTo5rtDSKzB6zGq4prT+9CQ=;
 b=C3FmziZzaGJ7mxIQPoWIXqZlqK+jmOpLsWfnpAVuRwHlJJcumzT0adIv9tVRRGDg57ujS6zfLS3blTcJBczPCTstMK1IWmznezjvtTOAYwXKsTqm/Ux01TH3lRx6EIgrFyEbxY6fFO7gak/WrDRxHrVG5pBw8MFNEJjT4VfMuXZKMAZnHZ8uKC+OJVQxI1Fz54jmRC7Iik41654m2DauGW8QGESrdgff4Wb5I8nS89qZFKt+m4nqSYilf8tFM0e2cOiJGTQFhfNsnZ0OKZmHfttNQsHQqZCh2WKwGUlRfarjX8myy1CGOyW0kBMFIm7KqbuFrzj0MmDLqEji9vFh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=423GJdI2pPwDoCy/R/Q/rTo5rtDSKzB6zGq4prT+9CQ=;
 b=LmmQIlfTg4463xJ6Kn9syavDKMqbIo5cqs5ZrVCDjVDgkd4Uf7yCNDwZQWXMhJLrgjSJNkbt3OYi46xZiXkcnIkOed8L90Dd4F7fyHEL9M+z2PdSE0aaSDu5tfcKfcg7hki7/0xD4nT/MvvgXmKHIW6TUHZahyB2rawQ7ePRjO0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB1584.namprd13.prod.outlook.com (2603:10b6:300:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8; Fri, 1 Jul
 2022 18:22:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7%9]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 18:22:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Per user rate limiter
Thread-Topic: Per user rate limiter
Thread-Index: VvWRCLsWSwi3+X3WtqrMTkYKdx9xXMX43ayA
Date:   Fri, 1 Jul 2022 18:22:50 +0000
Message-ID: <05f3b4e144ec5d12ab87d861222128181e805321.camel@hammerspace.com>
References: <737440541.1127428.1656698294694.JavaMail.zimbra@desy.de>
In-Reply-To: <737440541.1127428.1656698294694.JavaMail.zimbra@desy.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a9d033e-90b7-496e-473e-08da5b8eb512
x-ms-traffictypediagnostic: MWHPR13MB1584:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SdipDtdhuioPdx6Hq4qPE5giRQ8qqiHLaakdj63Fu04P6JvaH+spEZopNxEbl5OxP/PkecphHnWtc+dBpa2Bt/DxXlTF4s6KkJvlUyrgfIJkBVyhFB9nXmEOm6aGsK+9oEPBGZbukc7ToQnlIpSkouIoniHYE/rYL+Mw35P/hlJGH4Xic1E8RPARcBDa7sQrKj+ndkidwRWt58hHzMAxl/md0pixKz/T4yj3fGOD4VNSSODJCmxGxjw4GQzsw6A2lFhv52sS9sDrDAifhjW72fDm4gNEj0uhC0+CDeCVjLDlJ+fkZC0SezOYWC+q0/fAxl3XplK+yXCvssOG4cm5p0kXkFMgkr9OPnFYqrYmXhYnGiJfbpAKwd3rzmXJYb+g8biOnpZETjh9wy5zhAyGVa01oRWcDgBlitX2G/bMiYEFiDva2lfyPmeeQhyXg3UFp6QXURHIWVRnDevAqKtrd2CkffmB0QQhDd/8YLeuM+RuMnWp1Cel2jGz9Tf7QEWAWd1KE5gZimiCxldS7oNu8CgwvrLgIlbpiP3XpkmJza1GzgpKiu94oRZU4+W9giZIMwawOZTo+FkdeQgKyR/azdqUtJKnIv2LDy/oXadvbSSO+MjTjEXsdRTvwkFMdJGnAAFpjLGXkr3SstFTbENmQM+oiyn54d/SE56i8JeO2T/Rd5EP67hFu/5pOWCKJRGhZ79pzAkj91yOYz447ZwCyhIF/C0r/dIxleoaTipTgxzOLJCF29dGlz+UEHggBb5xqxBpfXmoitdCXYbhmhpG27D5ewNgKd+1FFACevImTmJp7WqUT0MR5nsbe92ZdQtr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(396003)(39830400003)(366004)(186003)(83380400001)(2616005)(76116006)(478600001)(5660300002)(6512007)(26005)(36756003)(6486002)(8936002)(41300700001)(6506007)(3480700007)(38070700005)(71200400001)(122000001)(2906002)(86362001)(38100700002)(110136005)(8676002)(66446008)(66556008)(316002)(66476007)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emh1Tm54VWdLeXF5ZW5YeHk5YXRxemtaamwya1d0NDFaS2cvbGxNVkJXaGIz?=
 =?utf-8?B?NmFoZW1qdk1pdDRJVTVLQ1daQnUxRVZrWjM3c2EwWjdSRFBoNzZWKzF0N2NM?=
 =?utf-8?B?aXUzMitIdmdkMG5MYlF4Nk1ZTEoraXVpWUsyN3RnOWtZdWtOcks5eXRGWHdR?=
 =?utf-8?B?ZkN6WW9zMmtyLzZhaHZhTUFhSDhzRlhrTVROSXlxbG02TFVpSlV5VVR5Wm5M?=
 =?utf-8?B?MzNRL2JOZ2NtRnlOVDdVemtDekZZT0ZxYkNoQU9pa20zMERmZ3VDZEE4Q3d0?=
 =?utf-8?B?TXN1UXREZU5mdUFjSFZaMTBVMTdNRFpvU2VaSnB6NWFaN1pXaE1meFA4SjUx?=
 =?utf-8?B?SUlaZTR2ek5xWUxlZENOU2ZDVEZWSi9ScGtBUStFYmtsbEs2b29QYmZsaVZx?=
 =?utf-8?B?OUMvaW1oWGh4SnNuai9henZPZk5aWDhVbFArUWxvdjl0V1dFdHMycHFCT2pu?=
 =?utf-8?B?bHBEK2YyWVkwNW00eTJXN0syR0dBSkdWWTZFRnh1R3B0SlNEa1N1WjlNSkN3?=
 =?utf-8?B?UHphbmhVdDFuOFdEVi9SanN1ZG1GOFR5VDg0aVJlU1EzOUtJcUFPeTZNVkl4?=
 =?utf-8?B?bEkyaUE0SkhER0Jra3RJZkpIK245UEFUcVNMMDlSaDVEdUR4WEJNek5mL1gv?=
 =?utf-8?B?YnFZc1ZWaHF2dnFQbTVnK2k1RUMwUjY0QW05VWl0K0JSV1hhaHJ4T1JrUVlX?=
 =?utf-8?B?bXkrU0pJUENYYzJqbDhEc0ZHYUk0ZEhLMVdFS29ZaU15YXZ5YW53TWUyWEVz?=
 =?utf-8?B?NzhkamUyN3JlL0QwUFJQQlI5c3ZPeFlGSDMzZWtUSmdlZ09TanVWQXZYa2ZY?=
 =?utf-8?B?Y3J6TEp1VWYyWmlnSCtnNzFFbS9aQm5MZUFudng0eXQ0NGt4TXNXT2dxNUc1?=
 =?utf-8?B?eDlwclVhMGVPdTgveE16dE1nYVBkOEQ4eWhrdnpBU2twU1hiajdtVzl1TVl3?=
 =?utf-8?B?L3E2MEJnZGxxN2pRUE1nKzlYVE9WSVFIcFg4SlJTU1NNOS9NQjlYb21QS1Q0?=
 =?utf-8?B?R1pVSENna0ZBY0ZWTG9ZWmZOV013VlI0QTJCZjY2VXFXcjVLS3JuRFVpRDIw?=
 =?utf-8?B?bTRCaW5WL3RjeFZGZmZLWGd1RzQwZndRL1c0Z21rZEcyZ0xoKzNjUkxXbUJW?=
 =?utf-8?B?R3NpZ1U5QXQza2owOSt0NTBNTC9XbVdBc1pLL1Ixc245VVRlQmpyYWZrZTln?=
 =?utf-8?B?ZjFiNUpKZGVaMWR3ODdmWERYUEtxQmZGVlRhTVlIdlc1SGY5MXE1V3k3bGE3?=
 =?utf-8?B?S2pCTExMVjRtMkgyZ3NVS0ZWSVVzVlVHdTdaRXFNT2hGYk1VRncvRWNWY0hk?=
 =?utf-8?B?Z1BmQlJMWGtWWHF3L01STC84a21uaExKUDNiQ0oxNnYyU2pVS1BBNEhMa0xE?=
 =?utf-8?B?eEk0WWJzd2wzRnJGY2psWEVURGhiREtEZWdmTWtZMEFIOFJicVlZa29vaWxF?=
 =?utf-8?B?OFZCSGpwYjVQVDI0ajRmdmRjU0xsWml3UGVqNzk3TjJMVWZEa0JMUHpVbHQz?=
 =?utf-8?B?TlhjZGRJZWxzMHRtZVpGUjVtRWJicmZQSXVMMEVySzcrdlZjaktNazREU0g0?=
 =?utf-8?B?aHJ2b3BKQm1nY0NvUXpOYVBsblFNT3lYMjV5MEF2K0R5azBpd1hiSURSQlFm?=
 =?utf-8?B?ODJyem1FSG9aaEZtWmx6WldjSHJUWXlTb3AxRkhOd29VanRUL014SnJTVlhR?=
 =?utf-8?B?c2s2Y0dZUFhQSENDRmxJZE8wdG9EQVUwR1FmaW1QdmN0Zmp0SkdibkI1Mnd4?=
 =?utf-8?B?K1dBREVZVS9YTzA3TFErcXJnMzU3dlUxNWgwOXhUdXkvaDhsSjZHelVNMTBM?=
 =?utf-8?B?VlpIQ2k3OXFxanQwYW9aZUVuc2xRbHczYk1nRjk5NGhUNHNUVFlDN2oxSTJ3?=
 =?utf-8?B?VVE2SEN0WndtYm12VCtnMG55cWJsMGJyNDZhRnJrMU1LTlVEdUQ2NHkxMzV4?=
 =?utf-8?B?OFNRc2k2a2ZnUHZUaGd3VUZIVUF6TEE2MmlJREFwODZ5TVA5NUt4L0w4eGs3?=
 =?utf-8?B?S2xaeWZzWUNLVHhwZ0srQzVjalpKaDBQay94Tk9GRlFlNEhXY1FmYVVOQUcv?=
 =?utf-8?B?Z0laWWxRR3VkajlzWE1sSlF6SnVpS0lmWnFMeXUxWTFDZ21OQkZsbDJDc2J0?=
 =?utf-8?B?SjFEaUlxMDE0a3FnQTB0VnJyYnh4NmI1TS9XVGQzQmZ3MjJRL3prdXBFTktI?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7BB1A2A45C94E479A090B0DBF7828A9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9d033e-90b7-496e-473e-08da5b8eb512
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 18:22:50.7391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJllF5PU4qjH91vxJeAdK4vGLMcaI9H0zr1wwqNNZpNNRfPPr1HkDoU0Jt1WysjEIrE2lByKBU0d9TqV5jU55A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1584
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTAxIGF0IDE5OjU4ICswMjAwLCBNa3J0Y2h5YW4sIFRpZ3JhbiB3cm90
ZToNCj4gDQo+IEhpIE5GUyBmb2xrcywNCj4gDQo+IHJldGljZW50bHkgd2UgZ290IGEga2luZCBv
ZiBERG9TIGZyb20gb25lIG9mIG91ciB1c2VyOiA1ayBqb2JzIHdhcmUNCj4gYWdncmVzc2l2ZWx5
DQo+IHJlYWRpbmcgYSBoYW5kZnVsIG51bWJlciBvZiBmaWxlcy4gT2YgY291cnNlIHdlIGhhdmUg
YW4gb3ZlcmxvYWQNCj4gcHJvdGVjdGlvbiwNCj4gaG93ZXZlciwgc3VjaCBhIGxhcmdlIG51bWJl
ciBvZiByZXF1ZXN0cyBieSBhIHNpbmdsZSB1c2VyIGRpZG4ndCBnaXZlDQo+IG90aGVyDQo+IHVz
ZXJzIGEgY2hhbmNlIHRvIHBlcmZvcm0gYW55IElPLiBBcyB3ZSBleHRlbnNpdmVseSB1c2UgcE5G
Uywgc3VjaA0KPiB1c2VyIGJlaGF2aW9yDQo+IG1ha2VzIHNvbWUgRFNlcyBub3QgYXZhaWxhYmxl
IHRvIG90aGVyIHVzZXJzLg0KPiANCj4gVG8gYWRkcmVzcyB0aGlzIGlzc3Vlcywgd2UgYXJlIGxv
b2tpbmcgYXQgc29tZSBraW5kIG9mIHBlciB1c2VyDQo+IHByaW5jaXBhbA0KPiByYXRlIGxpbWl0
ZXIuIEFsbCB1c2VycyB3aWxsIGdldCBzb21lIElPIHBvcnRpb24gYW5kIGlmIHRoZXJlIGlzIG5v
DQo+IHJlcXVlc3RzDQo+IGZyb20gb3RoZXIgdXNlcnMsIHRoZW4gYSBzaW5nbGUgdXNlciBjYW4g
Z2V0IGl0IGFsbC4gTm90IGlkZWFsDQo+IHNvbHV0aW9uLCBvZg0KPiBjb3Vyc2UsIGJ1dCBhIGdv
b2Qgc3RhcnRpbmcgcG9pbnQuDQo+IA0KPiBTbywgdGhlIHF1ZXN0aW9uIGlzIGhvdyB0ZWxsIHRo
ZSBhZ2dyZXNzaXZlIHVzZXIgdG8gYmFjay1vZmY/DQo+IERlbGF5aW5nIHRoZSByZXNwb25zZQ0K
PiB3aWxsIGJsb2NrIGFsbCBvdGhlciByZXF1ZXN0cyBmcm9tIHRoZSBzYW1lIGhvc3QgZm9yIG90
aGVyIHVzZXJzLg0KPiBSZXR1cm5pbmcNCj4gTkZTNEVSUl9ERUxBWSB3aWxsIGhhdmUgdGhlIHNh
bWUgZWZmZWN0ICh0aGlzIGlzIHdoYXQgd2UgZG8gbm93KS4NCj4gTkZTdjQuMSBzZXNzaW9uDQo+
IHNsb3RzIGFyZSBjbGllbnQgd2lkZSwgdGh1cywgYW55IGluY3JlYXNlIG9yIGRlY3JlYXNlIHBl
ciBjbGllbnQgaWQNCj4gd2lsbA0KPiBlaXRoZXIgZ2l2ZSBtb3JlIHNsb3RzIHRvIGFnZ3Jlc3Np
dmUgdXNlciBvciByZWR1Y2UgZm9yIGFsbCBvdGhlciBhcw0KPiB3ZWxsLg0KPiANCj4gQXJlIHRo
ZXJlIGFueSBkZXZlbG9wbWVudHMgaW4gdGhlIGRpcmVjdGlvbiBvZiBwZXItY2xpZW50IChjZ3Jv
dXBzIG9yDQo+IG5hbWVzcGFjZXMpDQo+IHRpbWVvdXQvZXJyb3IgaGFuZGxpbmc/IEFyZSB0aGVy
ZSBhIG5mcyBjbGllbnQgZnJpZW5kbHkgc29sdXRpb25zLA0KPiBiZXR0ZXIgdGhhdA0KPiByZXR1
cm5pbmcgTkZTNEVSUl9ERUxBWT8NCj4gDQoNCkhlcmUgYXJlIGEgZmV3IHN1Z2dlc3Rpb25zOg0K
DQoxKSBSZWNhbGwgdGhlIGxheW91dCBmcm9tIHRoZSBvZmZlbmRpbmcgY2xpZW50DQoyKSBEZWZp
bmUgUW9TIHBvbGljaWVzIGZvciB0aGUgY29ubmVjdGlvbnMgdXNpbmcgdGhlIGtlcm5lbCBUcmFm
ZmljDQpDb250cm9sIG1lY2hhbmlzbXMNCjMpIFVzZSBtaXJyb3JpbmcvcmVwbGljYXRpb24gdG8g
YWxsb3cgcmVhZCBhY2Nlc3MgdG8gdGhlIHNhbWUgZmlsZXMNCnRocm91Z2ggbXVsdGlwbGUgZGF0
YSBzZXJ2ZXJzLg0KNCkgVXNlIE5GUyByZS1leHBvcnRpbmcgaW4gb3JkZXIgdG8gcmVkdWNlIHRo
ZSBsb2FkIG9uIHRoZSBkYXRhDQpzZXJ2ZXJzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
