Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80AC513C3E
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 21:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiD1T7u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 15:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351303AbiD1T7t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 15:59:49 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2122.outbound.protection.outlook.com [40.107.100.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065BABF532
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 12:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5CGVgtNiCGMkBFdheDWVUkuQYcP19bOu0fLHNkJ8GEaYO7uJeqxPFv1PIb71smFGmCslZW3ULv67Ki0w6bce3v4xV8iiyIBVXJuF3kzYx6vfEIWh9DkjQxrQBB913AJe4yUHbndAp0xnE9ZGAfoz0/+vqag1s6bgbKaLF0cW+AX4gB37ObeqRU/QwP+DFun7XP1Mazjx1PdMo9vd3NVpfGAxU5HsVy4wvR6mbIHv0iUSmaLPaShGBLAzXGBYNI9w0moKfOXqiEfqBA00XBavKcDxZx3lFixn3HGkw5m8ZsON09xP89lyBQYQlOOj4XKNerRek3iBwIUBDoRBzkA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpY6F88mkryWlw6tT/k8qUawez5AZpGFuMD+63kbM20=;
 b=W/0rh1e/KtkK/1fQmYkE4tTz2uR8z7MBcErQuin9Wfiuf1BMo3SlgsIPzMPHR5gGxSFCEDPdlXU2tvbEzODH9+LQMPxQYuQgq1ZRcXxde24dkWJ+i3VDG4N5lepUtC4B/AS+8L0wyCihySktRjEELUBv/IWTyKNYZkiwAXBIu0b8mmjsA14DBbTUgSCXUvOwiW1Lb5bUbixFIutr87/0nKK17PtqVAxS2D2pRBA+f3YHjGUCqwAAIiGwiQ21SGsIPb1rEAbjDwwZCvbidd08u3nWSu8ksK3NhuCjpXA44f5XKgpYJdXLYxcKsO2GoTi3/oaAOvsV5h3duPqdx9jsnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpY6F88mkryWlw6tT/k8qUawez5AZpGFuMD+63kbM20=;
 b=gJ02TDbCxL37dTA1aN6iBNNU7c7MzLHNod6I+SMAhTm0aWufErhUA7inru7B/iyslKiKXXM8pUJ1PvaMdgs3h9IiQEwYyGeQLDP5PdgXF6lu8BtN7NIdoVEkJ/aYVJgaui99ZRerrQm2OjInO2vNjTj8FXQUeN7uBt3xV4er810=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR1301MB1920.namprd13.prod.outlook.com (2603:10b6:301:2d::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 19:56:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%5]) with mapi id 15.20.5206.014; Thu, 28 Apr 2022
 19:56:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dennis.dalessandro@cornelisnetworks.com" 
        <dennis.dalessandro@cornelisnetworks.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS regression between 5.17 and 5.18
Thread-Topic: NFS regression between 5.17 and 5.18
Thread-Index: AQHYWwCs+SbXmjJVWUyBjwAfi09dZ60Faq4AgAAMfoCAAERPAIAAApAA
Date:   Thu, 28 Apr 2022 19:56:28 +0000
Message-ID: <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
         <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
         <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
         <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
In-Reply-To: <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b0896be-1de9-442c-60a7-08da29512f16
x-ms-traffictypediagnostic: MWHPR1301MB1920:EE_
x-microsoft-antispam-prvs: <MWHPR1301MB19207F963E7F4159C3055F42B8FD9@MWHPR1301MB1920.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IJjMl21vc8ZxtSpJibUvWHp7G6WzvVf3Ly9VZ71o360cWBcO47t1ZpVw6emdltDeX1R/F+JchJOvYSp8FWbiLe0NJoBYC/pNc1OZL7ffHf2SNGaH/SaeLIOToEbRZrosVHGstHIFo+01ARCurjrjKGoPEAaWTQaVpcB9yQZQK3A3GYyTSyhK9YPkozfXkHjZN/CKlo30jH2509mtBqOCDHzABUQDa+rKe2pCaiSWdkxYYPiDRjkDS5PjH8kiJKrFHvMtE5jikNRdbE9AlsW3DLaOj0l6oDbxTg0qqIRwqbSpZmDM/9iLx4OwI06QjeeBiseieuNkU6jn+hi6mZUv3VHCPKW/zAAw3Wl9j9SF29lRHQoO0sdAXk1OZ4khwUbP4jEdbpo1x8lDOB7E0DPFWx5YE9Ge3amjMAdibXHsr65lttSyqAwwFW2sei0hPqYY9BAvP2MQxUkADl0N8ySU6RR0KaY5RVcaSanYz0nj70ZkxTnuv7BVKKQiqstRFBABf56Eu+X59S9fBdM5fJFncLXlRz+ikJNHabJy+AH4k2vargq0CiinYkWKARLEkdxGG6LTPFXPq2cMml3TObgeNSyIHOepy4Id1g+OcqJjP4aCVyFJOoyFNakIKagJcSx9B78z4EC0Fw59xAtFfPp1Jq9PYAs/PSM8sYKZXH/AAm0M76u+wiXddz9XjjbAmBNScra9bc9oGAAkdE/BJHG52Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(66946007)(36756003)(76116006)(2906002)(66556008)(186003)(316002)(4326008)(8676002)(66446008)(64756008)(83380400001)(66476007)(110136005)(8936002)(2616005)(71200400001)(86362001)(6486002)(508600001)(99936003)(38070700005)(38100700002)(26005)(53546011)(122000001)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlhUYkxrdmV5bEplbi9lanBiZUZJd29lc1dxL0NJSktPdmNWeDRHdW1RckNK?=
 =?utf-8?B?TVFLbUlXUWd2ODNrMGVabFZRSEZDZTYvTFJnbzJUSlZkVTZKMFZzQmt3eFQ4?=
 =?utf-8?B?a0hjRDRiVzQzbWRRWkIwL0dUN3ovOFBOTTlHUUwvVko0NmQzSEd2TFlkeEdD?=
 =?utf-8?B?THFjZW5zNjhLR2x4SC8yZ3FDSHZzQ2NZMGpHdGN5d0svaG9kTXF2ZndsUHdT?=
 =?utf-8?B?RURmSllFS09wZHBTUzFJQll2VHBsOWh0M1BpaUdzYlY4QjBqd01qSGJ5aW1J?=
 =?utf-8?B?M0xPc241bUNzN3Z6aFZ1RlUraGFsTWI1bUhvZ20rRmhpdVVMOXlaaC9RMWZn?=
 =?utf-8?B?K0hXeStOSGdTdUZwbHNzMzE0VFh3SWkxM2hla0VJWmZhQUNDRmlRSmt1bDMy?=
 =?utf-8?B?RmdYSDZ5bFYrOWFiWVpaMEZNeExsemtybWlnbVdtalFkMUxkNm5JQW9nRW5x?=
 =?utf-8?B?NS9zTm9qb2pGMk1XVWsrZFRpL3hUdDY0a3NoT1JhZzV5UVllclNsUmM2Sm5v?=
 =?utf-8?B?eXpNZGJxczlJdnNSRWJxSm1CUUdqYXVSM2xGSFpNRWEzMExjZFkwMlI2MVhq?=
 =?utf-8?B?Zi9aSVl1T1FYMzhZNTZvOGxVKzF4VVNCcFE0akVER2JUNzJXaHUrajRneHZE?=
 =?utf-8?B?UlVhRkpMZTVObnowZ2dXQ2JtR09hL3hscHJ2QUUrWnBFQUorQlQ3Wm1PaTV4?=
 =?utf-8?B?MTlWcGdPdDZJSCtkTmlVSkNjaUZUdmZOWXFWbHNTaDh1bFdUaVdnWkt1M1JF?=
 =?utf-8?B?ZzZXT2t5aFk4UmpJTzJ2U1gzZHR3MlpkUi81SWFFMUFmRHhJWGNDeDJuOHNB?=
 =?utf-8?B?VEpyRzNlRUVwcUpXMEZYa0xsNGgxMWpOWTlLOWFJLzBhc3Qxa3EzRVJ0TFhM?=
 =?utf-8?B?QStqZGVPTHpEakdmWmxjdzhLNGY5S3E5RldnZU1hcEQ1dFpxTUNoMEIrbDJR?=
 =?utf-8?B?Nk1peWpuamo5L2EwMHpDK3hucmNLN09yeDhsRS9BYXlnbEc0cXNHdTQ5MGNp?=
 =?utf-8?B?N2dYZDRoTm10bXdoRWRPK2NHd1hHYXdQaks3b25Tb3h5L0s4eTFaTEpXTWVj?=
 =?utf-8?B?SnUzUi9lcytaK2szOUlYYXZtZGtQaXVRd280WHJQTDB0dVNlb2duditKY3Iy?=
 =?utf-8?B?b2JScUVxWGFBMHE1Zjk5cG5vQkxBRDVuUUhyZndzeHRUK1FMVmxnOGdyQUNw?=
 =?utf-8?B?MCtkYlFCMGVScHIyc2MwTm5ONXlPN05Qa3QxWVpqYjlBejNsdXUvbjhMRE1R?=
 =?utf-8?B?bUpoTDltTnhKbTNhUE1OOXpsdjl4VE52bTBHYTFkMkhoYVE4WnVBYXJvcnpO?=
 =?utf-8?B?ZTViMEtQK1Y0YnRFQXZZaXN0cVdrRTlGTUtwNStDc2xWV3hwSkd1SGV1aTJm?=
 =?utf-8?B?QmZ0UDVzSlJpN1JDdTg3a1loNkRpVHR6Y3lHNGI4Qmtuc0s4ZUxCcUZ5dUJm?=
 =?utf-8?B?VlFucXRWdjlReVF0N1FOemQ0ZjBvbjVIOVpMMStoTUxETnhuV0hGMWdBRVJE?=
 =?utf-8?B?QVZDVXk2QmNYd2NEOGE3Ukw5SW9YQlVNN25jN1V2Y01Dc3JPTVJZNXo2Zkw5?=
 =?utf-8?B?MVlGUVBPWi9hVHlBN3k2cUZuV09CbmU1eWFYTDBSZDFHd0xyVENxOG1UbUdn?=
 =?utf-8?B?Y0FxdzRkNUY0Q3F0ZlRhcFFWT1pOMDZLSFQva1VZM2xTYVIxVklsM2N2YUNO?=
 =?utf-8?B?R25WRlpGOVFzTkxxalA5Y1lEYytjTjdVMnptWjk5Tkt4RHF5Rnk5aXNRQXF6?=
 =?utf-8?B?NFY4YTJvU2t5UFFBNk1GdnBuTjhRd29JVTZvTHJKZ3F3bUswNnFqOXh3V0NY?=
 =?utf-8?B?UmowTnhQSWI0MnI0SFZYSGU3VmFkYi91VUJTZjdaT0FvTDNMUEVhU1FYY3dq?=
 =?utf-8?B?emdZZlk3S1Q5a3hKakxhOEF0Ym1DOFhjTHlLZE9xazQxWEdrTVpSWnlLcHk5?=
 =?utf-8?B?OHp2UjMvbjBTRjFSOXA2Wk9JL2xWeVhxd0crR2pEb0VTcHczTXlIaDhWWDhW?=
 =?utf-8?B?Zmx2WVdHN21iU21QS1EwNzYxU2xIOXdTZFdsMW1Vc3hLR3FPakppR0JCbmlJ?=
 =?utf-8?B?VlpoKzNTVlNySUdYc2JHSmVTaDFPK3NVeStVWTI2NmQybm4zMkRLSXltNnNS?=
 =?utf-8?B?cThrR3U4WFc4SjJUZksrYUJmRjk3UXMvZDNOZEp4emxTVWxYL21mRVNiWW8x?=
 =?utf-8?B?OUNKRFJnb2l1RlFHRHR5YlFFNVNFVDVkMG1NZXZIMmpUSm1jdHE4QU51NTVJ?=
 =?utf-8?B?TjJGS0FrbmJuODBQeFRobHIzRVVHMmpzQmEwbExpbnk1NGtoWlJWZUxORE5S?=
 =?utf-8?B?NGxHcUFvYUhGR0FjT0Q2QXFYdVA0K1VDMUI3b1lBZENLMHlsZFhFVHExSEpH?=
 =?utf-8?Q?TOlq8ur41AaeYrvU=3D?=
Content-Type: multipart/mixed;
        boundary="_002_ca84dc10f073284c9219808bb521201f246cf558camelhammerspac_"
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0896be-1de9-442c-60a7-08da29512f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 19:56:28.4807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DivlJ8wgZXaUqtTfYjly/MQMGvnvn39cPbUfWD+8HckEDMukSQ/thl14q0vYTnz4GXwHBeWA6/mWq2gQ5hZ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB1920
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--_002_ca84dc10f073284c9219808bb521201f246cf558camelhammerspac_
Content-Type: text/plain; charset="utf-8"
Content-ID: <30305CA9B3DD6D45AEB987C42D3842E9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDIyLTA0LTI4IGF0IDE1OjQ3IC0wNDAwLCBEZW5uaXMgRGFsZXNzYW5kcm8gd3Jv
dGU6DQo+IE9uIDQvMjgvMjIgMTE6NDIgQU0sIERlbm5pcyBEYWxlc3NhbmRybyB3cm90ZToNCj4g
PiBPbiA0LzI4LzIyIDEwOjU3IEFNLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4gPiA+IE9u
IEFwciAyOCwgMjAyMiwgYXQgOTowNSBBTSwgRGVubmlzIERhbGVzc2FuZHJvDQo+ID4gPiA+IDxk
ZW5uaXMuZGFsZXNzYW5kcm9AY29ybmVsaXNuZXR3b3Jrcy5jb20+IHdyb3RlOg0KPiA+ID4gPiAN
Cj4gPiA+ID4gSGkgTkZTIGZvbGtzLA0KPiA+ID4gPiANCj4gPiA+ID4gSSd2ZSBub3RpY2VkIGEg
cHJldHR5IG5hc3R5IHJlZ3Jlc3Npb24gaW4gb3VyIE5GUyBjYXBhYmlsaXR5DQo+ID4gPiA+IGJl
dHdlZW4gNS4xNyBhbmQNCj4gPiA+ID4gNS4xOC1yYzEuIEkndmUgdHJpZWQgdG8gYmlzZWN0IGJ1
dCBub3QgaGF2aW5nIGFueSBsdWNrLiBUaGUNCj4gPiA+ID4gcHJvYmxlbSBJJ20gc2VlaW5nDQo+
ID4gPiA+IGlzIGl0IHRha2VzIDMgbWludXRlcyB0byBjb3B5IGEgZmlsZSBmcm9tIE5GUyB0byB0
aGUgbG9jYWwNCj4gPiA+ID4gZGlzay4gV2hlbiBpdCBzaG91bGQNCj4gPiA+ID4gdGFrZSBsZXNz
IHRoYW4gaGFsZiBhIHNlY29uZCwgd2hpY2ggaXQgZGlkIHVwIHRocm91Z2ggNS4xNy4NCj4gPiA+
ID4gDQo+ID4gPiA+IEl0IGRvZXNuJ3Qgc2VlbSB0byBiZSBuZXR3b3JrIHJlbGF0ZWQsIGJ1dCBj
YW4ndCBydWxlIHRoYXQgb3V0DQo+ID4gPiA+IGNvbXBsZXRlbHkuDQo+ID4gPiA+IA0KPiA+ID4g
PiBJIHRyaWVkIHRvIGJpc2VjdCBidXQgdGhlIHByb2JsZW0gY2FuIGJlIGludGVybWl0dGVudC4g
U29tZQ0KPiA+ID4gPiBydW5zIEknbGwgc2VlIGENCj4gPiA+ID4gcHJvYmxlbSBpbiAzIG91dCBv
ZiAxMDAgY3ljbGVzLCBzb21ldGltZXMgMCBvdXQgb2YgMTAwLg0KPiA+ID4gPiBTb21ldGltZXMg
SSdsbCBzZWUgaXQNCj4gPiA+ID4gMTAwIG91dCBvZiAxMDAuDQo+ID4gPiANCj4gPiA+IEl0J3Mg
bm90IGNsZWFyIGZyb20geW91ciBwcm9ibGVtIHJlcG9ydCB3aGV0aGVyIHRoZSBwcm9ibGVtDQo+
ID4gPiBhcHBlYXJzDQo+ID4gPiB3aGVuIGl0J3MgdGhlIHNlcnZlciBydW5uaW5nIHY1LjE4LXJj
IG9yIHRoZSBjbGllbnQuDQo+ID4gDQo+ID4gVGhhdCdzIGJlY2F1c2UgSSBkb24ndCBrbm93IHdo
aWNoIGl0IGlzLiBJJ2xsIGRvIGEgcXVpY2sgdGVzdCBhbmQNCj4gPiBmaW5kIG91dC4gSQ0KPiA+
IHdhcyB0ZXN0aW5nIHRoZSBzYW1lIGtlcm5lbCBhY3Jvc3MgYm90aCBub2Rlcy4NCj4gDQo+IExv
b2tzIGxpa2UgaXQgaXMgdGhlIGNsaWVudC4NCj4gDQo+IHNlcnZlcsKgIGNsaWVudMKgIHJlc3Vs
dA0KPiAtLS0tLS3CoCAtLS0tLS3CoCAtLS0tLS0NCj4gNS4xN8KgwqDCoCA1LjE3wqDCoMKgIFBh
c3MNCj4gNS4xN8KgwqDCoCA1LjE4wqDCoMKgIEZhaWwNCj4gNS4xOMKgwqDCoCA1LjE4wqDCoMKg
IEZhaWwNCj4gNS4xOMKgwqDCoCA1LjE3wqDCoMKgIFBhc3MNCj4gDQo+IElzIHRoZXJlIGEgcGF0
Y2ggZm9yIHRoZSBjbGllbnQgaXNzdWUgeW91IG1lbnRpb25lZCB0aGF0IEkgY291bGQgdHJ5Pw0K
PiANCj4gLURlbm55DQoNClRyeSB0aGlzIG9uZQ0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K

--_002_ca84dc10f073284c9219808bb521201f246cf558camelhammerspac_
Content-Type: text/x-patch;
	name="0001-SUNRPC-Fix-an-RPC-RDMA-performance-regression.patch"
Content-Description: 0001-SUNRPC-Fix-an-RPC-RDMA-performance-regression.patch
Content-Disposition: attachment;
	filename="0001-SUNRPC-Fix-an-RPC-RDMA-performance-regression.patch";
	size=2444; creation-date="Thu, 28 Apr 2022 19:56:28 GMT";
	modification-date="Thu, 28 Apr 2022 19:56:28 GMT"
Content-ID: <E4852B7CBC78634BB31B8501046BB385@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAwNTA1ZWNmNzZmNTEzMTUyNWU2OTZkM2RhZTNiZDQ1NmE4YjhiM2FkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20+CkRhdGU6IFRodSwgMjggQXByIDIwMjIgMTU6NDY6MDEgLTA0MDAKU3ViamVj
dDogW1BBVENIXSBTVU5SUEM6IEZpeCBhbiBSUEMvUkRNQSBwZXJmb3JtYW5jZSByZWdyZXNzaW9u
CgpVc2UgdGhlIHN0YW5kYXJkIGdmcCBtYXNrIGluc3RlYWQgb2YgdXNpbmcgR0ZQX05PV0FJVC4g
VGhlIGxhdHRlciBjYXVzZXMKaXNzdWVzIHdoZW4gdW5kZXIgbWVtb3J5IHByZXNzdXJlLgoKU2ln
bmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tPgotLS0KIG5ldC9zdW5ycGMvYXV0aF9nc3MvYXV0aF9nc3MuYyAgfCAxMSArKysrLS0tLS0t
LQogbmV0L3N1bnJwYy9zY2hlZC5jICAgICAgICAgICAgICB8ICAxICsKIG5ldC9zdW5ycGMveHBy
dHJkbWEvdHJhbnNwb3J0LmMgfCAgNiArLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvc3VucnBjL2F1dGhfZ3Nz
L2F1dGhfZ3NzLmMgYi9uZXQvc3VucnBjL2F1dGhfZ3NzL2F1dGhfZ3NzLmMKaW5kZXggZGU3ZTVi
NDFhYjhmLi5hMzFhMjc4MTZjYzAgMTAwNjQ0Ci0tLSBhL25ldC9zdW5ycGMvYXV0aF9nc3MvYXV0
aF9nc3MuYworKysgYi9uZXQvc3VucnBjL2F1dGhfZ3NzL2F1dGhfZ3NzLmMKQEAgLTEzNDAsMTQg
KzEzNDAsMTEgQEAgZ3NzX2hhc2hfY3JlZChzdHJ1Y3QgYXV0aF9jcmVkICphY3JlZCwgdW5zaWdu
ZWQgaW50IGhhc2hiaXRzKQogLyoKICAqIExvb2t1cCBSUENTRUNfR1NTIGNyZWQgZm9yIHRoZSBj
dXJyZW50IHByb2Nlc3MKICAqLwotc3RhdGljIHN0cnVjdCBycGNfY3JlZCAqCi1nc3NfbG9va3Vw
X2NyZWQoc3RydWN0IHJwY19hdXRoICphdXRoLCBzdHJ1Y3QgYXV0aF9jcmVkICphY3JlZCwgaW50
IGZsYWdzKQorc3RhdGljIHN0cnVjdCBycGNfY3JlZCAqZ3NzX2xvb2t1cF9jcmVkKHN0cnVjdCBy
cGNfYXV0aCAqYXV0aCwKKwkJCQkJc3RydWN0IGF1dGhfY3JlZCAqYWNyZWQsIGludCBmbGFncykK
IHsKLQlnZnBfdCBnZnAgPSBHRlBfS0VSTkVMOwotCi0JaWYgKGZsYWdzICYgUlBDQVVUSF9MT09L
VVBfQVNZTkMpCi0JCWdmcCA9IEdGUF9OT1dBSVQgfCBfX0dGUF9OT1dBUk47Ci0JcmV0dXJuIHJw
Y2F1dGhfbG9va3VwX2NyZWRjYWNoZShhdXRoLCBhY3JlZCwgZmxhZ3MsIGdmcCk7CisJcmV0dXJu
IHJwY2F1dGhfbG9va3VwX2NyZWRjYWNoZShhdXRoLCBhY3JlZCwgZmxhZ3MsCisJCQkJCXJwY190
YXNrX2dmcF9tYXNrKCkpOwogfQogCiBzdGF0aWMgc3RydWN0IHJwY19jcmVkICoKZGlmZiAtLWdp
dCBhL25ldC9zdW5ycGMvc2NoZWQuYyBiL25ldC9zdW5ycGMvc2NoZWQuYwppbmRleCA3ZjcwYzFl
NjA4YjcuLjI1YjkyMjE5NTBmZiAxMDA2NDQKLS0tIGEvbmV0L3N1bnJwYy9zY2hlZC5jCisrKyBi
L25ldC9zdW5ycGMvc2NoZWQuYwpAQCAtNjMsNiArNjMsNyBAQCBnZnBfdCBycGNfdGFza19nZnBf
bWFzayh2b2lkKQogCQlyZXR1cm4gR0ZQX0tFUk5FTCB8IF9fR0ZQX05PUkVUUlkgfCBfX0dGUF9O
T1dBUk47CiAJcmV0dXJuIEdGUF9LRVJORUw7CiB9CitFWFBPUlRfU1lNQk9MX0dQTChycGNfdGFz
a19nZnBfbWFzayk7CiAKIHVuc2lnbmVkIGxvbmcKIHJwY190YXNrX3RpbWVvdXQoY29uc3Qgc3Ry
dWN0IHJwY190YXNrICp0YXNrKQpkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0cmRtYS90cmFu
c3BvcnQuYyBiL25ldC9zdW5ycGMveHBydHJkbWEvdHJhbnNwb3J0LmMKaW5kZXggNmI3ZTEwZTVh
MTQxLi5iY2IzN2I1MWFkZjYgMTAwNjQ0Ci0tLSBhL25ldC9zdW5ycGMveHBydHJkbWEvdHJhbnNw
b3J0LmMKKysrIGIvbmV0L3N1bnJwYy94cHJ0cmRtYS90cmFuc3BvcnQuYwpAQCAtNTcxLDExICs1
NzEsNyBAQCB4cHJ0X3JkbWFfYWxsb2NhdGUoc3RydWN0IHJwY190YXNrICp0YXNrKQogCXN0cnVj
dCBycGNfcnFzdCAqcnFzdCA9IHRhc2stPnRrX3Jxc3RwOwogCXN0cnVjdCBycGNyZG1hX3hwcnQg
KnJfeHBydCA9IHJwY3hfdG9fcmRtYXgocnFzdC0+cnFfeHBydCk7CiAJc3RydWN0IHJwY3JkbWFf
cmVxICpyZXEgPSBycGNyX3RvX3JkbWFyKHJxc3QpOwotCWdmcF90IGZsYWdzOwotCi0JZmxhZ3Mg
PSBSUENSRE1BX0RFRl9HRlA7Ci0JaWYgKFJQQ19JU19BU1lOQyh0YXNrKSkKLQkJZmxhZ3MgPSBH
RlBfTk9XQUlUIHwgX19HRlBfTk9XQVJOOworCWdmcF90IGZsYWdzID0gcnBjX3Rhc2tfZ2ZwX21h
c2soKTsKIAogCWlmICghcnBjcmRtYV9jaGVja19yZWdidWYocl94cHJ0LCByZXEtPnJsX3NlbmRi
dWYsIHJxc3QtPnJxX2NhbGxzaXplLAogCQkJCSAgZmxhZ3MpKQotLSAKMi4zNS4xCgo=

--_002_ca84dc10f073284c9219808bb521201f246cf558camelhammerspac_--
