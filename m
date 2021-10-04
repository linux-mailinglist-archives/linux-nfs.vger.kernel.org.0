Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CC84212E3
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhJDPm6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 11:42:58 -0400
Received: from mail-bn1nam07on2121.outbound.protection.outlook.com ([40.107.212.121]:46935
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235807AbhJDPm5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 11:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex2IVxuuzlgAQIv7qKzM2GmNqkGUuNTL7N9RCNRKQkt3NPineB77UaHG4ww5Jvxr13FoVp7Pap8wBJQYm6iJOyuszXVLxifIv5eGal+GeoZwNe5MZB27MnpgC291+Di52PSMEt08iawpM27FydAOtNhL0P38J74UumFN7ta+kk1KJcqM0df7iLg9KVotYBUGk2/gas0Wv267UbD7avJeCblD77A9XsgpTmV/+XTyMZqJKFtoYP3Q93Cawx4dP2abwyDNshV0WYuCsJRbJNOajsKV6S5Hf1kJNsOr1GhJEFWLpKd17gKNrwUBgMIMT+obvTzHeAvat5fq8S2MgmQcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUXyI4vnMb63H+Zn/LtXgnm6NoK6DLKoGiALKa6Ws70=;
 b=PYn6pD6ZJ+AGe5sjjz6sVjZi18jqcaxgjLt6BmSILnNhFVVhn1X2S1teWnoH37bhBnqLgy0jks6rRmIX3hvMULmJTEBp6E8ujoVEul50Sq6Z7sf9JhWfUbV3BQfuQNI7TwOeUoR2Y2/kZbCuVpcSZUDAWrdIFNJKDUjqHWn6J7oNUQfZLWtq6wNxl9cXtvhNozJOdYZ2jATVLBy+b03rcV1r6x+9QoWTmve6BG6RPkFYxexUKJXvMQZNqHC8K3lZhgPHTUJya+qbHLFBQw3Ji6da24BX84gNQPiRf1tUTm5kzmnJos3hkW0SKdyvDpbGSh0ACEqImV4/+j1gw5QrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUXyI4vnMb63H+Zn/LtXgnm6NoK6DLKoGiALKa6Ws70=;
 b=ICpMqclGtQwS7hSX+CuGvTQBTChGfnHo9VgB83kFUGsdhB1Dkv5OigSjdiGhCVNTaIPYIxJmPJHvVhxPqbbVNOkvo7JmMLpkgetUeAPriK9fygs8OwWZkpdl8KL5bX16ypNvvcCNxfyhMPrg17oeLEBW33m4gVXnijG9AVheHYw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4426.namprd13.prod.outlook.com (2603:10b6:610:34::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.11; Mon, 4 Oct
 2021 15:41:04 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%6]) with mapi id 15.20.4587.017; Mon, 4 Oct 2021
 15:41:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] SUNRPC: Tracepoints should store tk_pid and cl_clid
 as a signed int
Thread-Topic: [PATCH 2/4] SUNRPC: Tracepoints should store tk_pid and cl_clid
 as a signed int
Thread-Index: AQHXuSmJFoxxq1UbX0KyHogR72D4DavC+iaA
Date:   Mon, 4 Oct 2021 15:41:04 +0000
Message-ID: <ce1a2ef5757fc96c21f2e6402021ca646dfbfa80.camel@hammerspace.com>
References: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
         <163335660381.1225.8730120749232774829.stgit@morisot.1015granger.net>
In-Reply-To: <163335660381.1225.8730120749232774829.stgit@morisot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 308b78fc-8498-4a47-90e4-08d9874d6056
x-ms-traffictypediagnostic: CH2PR13MB4426:
x-microsoft-antispam-prvs: <CH2PR13MB442695B17E5AA945758470ECB8AE9@CH2PR13MB4426.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3FKUKU7kalYa9iXwPt6B4usTlXmNzp90+4ypUpahZyQ85vwdcqXX6VNti3hP+3RX8yozS6OWRRAPpnE2wuPa1ppH6bFe23E4A2LpgCzoodmfd9Kfd9g1gj9f3fWwGuOSltxQsDxl2NHrE8OD1QCwNTYPRnlAkcZL5dvr8R9FrgiNukYu0U2P4JUmXsSPAA05T7N5ZkU0JDpfW/TfbxfApUIy0/2my/LThBUGtnpPezj0sljWB+YwK6qBFHR4wIKVzbvTZjQfOIDhK9Hf1mCKcMzqODh2sR3gxgNUhJIP49MAvyqncDvE8hfavxaCkgq9mrabItyGe523vBrs4Mx3x1O2I5d38wgDUK+JRpBHDSRiimMCEymFWdoFJLPwQapcwnbfD2Wh8h2w6SrF5shwUCnf8Rli2YIZs2PHfDHWGcSzCfWzx6HeR7KULK3NWKagfB99LETvkD5Q0wWkvJ0OIYSJtuNo1V9q6QOFobJyJFEUp61UPOwi7p+6JWDRNcL1BV0M+ltrPyg1mx0mFnG6xwnALaQCVXwXVBaqF+5GHlJJNFSUVVEromqwV4icRyh/EIzKII79DXAURO4dVEDEAqcmCHnwW+OE27VejigQqZNef4ayDsKA/S9kgEdlUcURlVg9jvViZpDd5raRCsOAvXgUHNU91hntKi3mMkWQcbR+7ZQj795ZiUnZIFCPn4dN9TMSJNbedr0eVH/9MTGFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39830400003)(376002)(346002)(136003)(66946007)(86362001)(508600001)(122000001)(76116006)(38100700002)(110136005)(38070700005)(2906002)(26005)(2616005)(6506007)(5660300002)(66476007)(36756003)(66446008)(6486002)(71200400001)(64756008)(66556008)(8936002)(316002)(6512007)(4744005)(4326008)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym1ucE4xckJrTjBJbkt5aXF2Z3k1bnJwWW0rZEZuZUpoY1l5QlprMFdzK2Rk?=
 =?utf-8?B?b0QxQnVTV1FxRHJMWFNFYlIxSmxTRys1WFJsM0NMc3Roayt4Y0hERlZsdGRL?=
 =?utf-8?B?VlFLRXRBdDFsaStKVlZLdXEwTkVkWjVhMzdLNVZjbEN0VXdLbGZWaXVacldL?=
 =?utf-8?B?U1hMS280UUdkTmsvQWdJZDFxd0hwOE1Ncm9vSTN1bmdzbEF3NkpCSjNYdXVn?=
 =?utf-8?B?ZTRtTkgzOWFOcGtQdDR4M3ZqbDYzVHp0Z1VyQk9hYmpDZWx1RDZLajViVUt2?=
 =?utf-8?B?UC94TE8wS3VQNFUxMytHL0puMmFBU1R5ZFQvMTR6aDhxTENVSUsyMXdGdGJn?=
 =?utf-8?B?VHlBUW1xWUd6aEtITlUxL1daT3NpeEE2K2dxdktVV0J0cEp6WDVKWVphcS9i?=
 =?utf-8?B?Q1ZxcmxqOGd2UE1YbnhtMnVUR3RzNU9IOU1vbTNVUlZ2VXVoN1E0SmswaklD?=
 =?utf-8?B?WWZlUW9jMS9WVnFUSHRNd0cyendvbnhEQmdoNFFMSmkwVytGMGRpejJxVGY4?=
 =?utf-8?B?YVZxeUtkYkRjVzBpSU5Ccng1eXY5TENQYmdKOWxnc2JyVWZjK3NpcXRFTTV5?=
 =?utf-8?B?WDNCQU1vbVpnRTNmcHJraUMyQmFRbjJIVW9nL3lQQUlnY2VsVlhUUXdpNitW?=
 =?utf-8?B?aEZWczNhUmZXSjhjRXhIcVpqR01aR3d0TEFrNjdxUjNhU2ZSMnBiRjMrSmtY?=
 =?utf-8?B?OVRaOWpsYnBIYk9zc2FEWmEwRjhqRHBjd0oxMVEzMXpUN2hQN2p6ZUpXR2lJ?=
 =?utf-8?B?aTVoQWVycU9uTnNwOStJd291M1ZZVnNmQ055UzFObFladHJSVGd1S1dDOGZ3?=
 =?utf-8?B?bCtIajJaZGoyVTQzS2p5L2IzaXJzQUROby9HSjM0TU1wODVranBIcXNuMWhn?=
 =?utf-8?B?V2dIdTBqRk9FdC9qeDVlcXBsTXYvU21vVzJNRTJMdTlnNmd4WWxUVktjck53?=
 =?utf-8?B?MERvaGF5NUxMNXl2S29YZEtFSDRyTzhQd0VoUzdnYlZ6cEQ0dmkvaWZzdFhX?=
 =?utf-8?B?NGZmU0taNWNwaW4vcWFMcnBqK25Wem9nd0sxNFRRVjZ6NCtuQnJGVFJkNXBs?=
 =?utf-8?B?dStrT3E2TkZyM3JjcFBOVjlPZTBKbnVZSVFSbW82aFpmRVUzV2FYaDhRalp3?=
 =?utf-8?B?NHZ3aXp4Y3dCMDU1WGszMk5RTm9nOUhXY0lZNjFDWjVnTHNNV1k5VW5nRjY2?=
 =?utf-8?B?NXJXQU1BY0xaS1JSY1czL2RTem1IRmJKdUZrSmRkRGVrSndFdzY4bktzUHJi?=
 =?utf-8?B?VXFwWjZrZ0xMSFBzRGFyMTJWYTk1TkxnQVJFQ2dVS2oxTmdaUUNtQ2VYR3pR?=
 =?utf-8?B?L1FtcEFHQU5XVGs5WTdUNG8wQW1GaDlhSHlpVUNTYXpZSklqdlY5RHZKL3A4?=
 =?utf-8?B?SGNUNVhnSENJM2UrRWp2VENHUFo0T1c3STRudEJPYVRsdVVPTGd2SHcwSTM2?=
 =?utf-8?B?TGsyekpWc0l0cnJ6VnYvc3FuWW1VYmhJb0o3eWNxWFB0bEdZVTBRU1FWL2w0?=
 =?utf-8?B?Ukkzd2pzUHZGdlBMWkI5YVBIaHFlQ3VIYUJtWDY0OXlXQ3VuWkt5TnNhcWRp?=
 =?utf-8?B?cWhRMjNmSG11LytQMkkzeXRQbCthckl5WGc0aWdQV2JKRUlDeWdjYTNpbi9M?=
 =?utf-8?B?ZXdPU2V0VS9ua0k3SDV1TEU5c0FXK2hnOVlGVjUvQUlNT21oWHA4S2s3UitX?=
 =?utf-8?B?ZWt1cHc2STdqdEIycVM5Q3dsOVNXUkhLTENjUUJsc3lVN3pvWUoyeVA4aE5Q?=
 =?utf-8?Q?a+YeWwuLfx2vK0/YnTmUNo0QQNzSBctQEggddvO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2289A2E874D0E4B87D39B93FD4A410B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308b78fc-8498-4a47-90e4-08d9874d6056
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 15:41:04.6510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nk7KR4UO21C6AmhAJv3NkqHueXIV3O+UYQ5kWJZBKAhLwqhEjatgboA+PXqXxbBm1wp3kczkH4esWga/KlN+Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4426
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTEwLTA0IGF0IDEwOjEwIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
aWRhX3NpbXBsZV9nZXQoKSByZXR1cm5zIGEgc2lnbmVkIGludGVnZXIuIE5lZ2F0aXZlIHZhbHVl
cyBhcmUgZXJyb3INCj4gcmV0dXJucywgYnV0IHRoaXMgc3VnZ2VzdHMgdGhlIHJhbmdlIG9mIHZh
bGlkIGNsaWVudCBJRHMgaXMgemVybyB0bw0KPiAyXjMxIC0gMS4NCj4gDQo+IHRrX3BpZCBpcyBj
dXJyZW50bHkgYW4gdW5zaWduZWQgc2hvcnQsIHNvIGl0cyByYW5nZSBpcyB6ZXJvIHRvDQo+IDY1
NTM1Lg0KPiANCj4gRm9yIGNlcnRhaW4gc3BlY2lhbCBjYXNlcywgUlBDLXJlbGF0ZWQgdHJhY2Vw
b2ludHMgcmVjb3JkIGEgLTEgYXMNCj4gdGhlIHRhc2sgSUQgb3IgdGhlIGNsaWVudCBJRC4gSXQn
cyB1Z2x5IGZvciBhIHRyYWNlIGV2ZW50IHRvIGRpc3BsYXkNCj4gNCBiaWxsaW9uIGluIHRoZXNl
IGNhc2VzLg0KDQpVZ2guLi4gSSBlbXBoYXRpY2FsbHkgZG8gbm90IGxpa2UgdGhlIGlkZWEgb2Yg
YW4gaWRlbnRpZmllciBmaWVsZCB0aGF0DQppcyBzaWduZWQsIHdoYXRldmVyIGl0cyByYW5nZSBv
ZiB2YWxpZGl0eSBtYXkgYmUuDQoNCklmIHdlJ3JlIGdvaW5nIHRvIGNoYW5nZSBhbnl0aGluZywg
dGhlbiBsZXQncyByYXRoZXIgdHVybiB0aGF0DQppZGVudGlmaWVyIGludG8gYSBmaXhlZCBzaXpl
IGhleCBmaWVsZCBpbiB0aGUgdHJhY2VzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
