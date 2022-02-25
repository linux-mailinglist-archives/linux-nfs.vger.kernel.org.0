Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4734B4C3BC2
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 03:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiBYCd6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 21:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBYCdz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 21:33:55 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2101.outbound.protection.outlook.com [40.107.220.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4589920A38D
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 18:33:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQsixmWA1PrSEi4OePIf1/uDkX5sGTtvKiro/js2PYOM2iNhD29Koxx7Hhi1amQFKwsDUbIAzcTBoOs4pon3KrrKFVpx/x0HX5Zgnz9NTDuDPVfBr/96c90Ia5x2++yV+Ue7RE1QvV6sOcS5k9cKwDLFwSfzAPorpYhL0LtAJ8BzfDzOqGB0Khooq9k2uBeILI5bWtiJVyM+zfNbjETTeq/YDaGPIUfMSaRb2ZsLtci0buIgAxp1OT7H7clS7G/w5XYt0nml309uJgxDAwgdAvyDOGVUnpHakmY4AlVTrVSxU+HA8jAjTfXGZfDq74Z5fif+bgu21dZA6rofxc9zFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9pVXKHecWiMOIExGI68aJaESIY5NSjmVxVvvwrXcT0=;
 b=VizXkx1gTgCRWycWvBOd04o6l3OAY646hbFcdxKKE6IhyuKJvHkcPKvksNoxQ8RprMOVxnMjGX4GzgWxDTU+7Zjf46Bqk1zXwWgUGkVWAUBfDSGi1/FFDAeRYBZbbDntBfmXgdqBBuEib0KePtUnu7HMyKKMQ2sejwQqkUDTS5NoiqX/J9DqE9/5qTQnoV2uZczMFQGRKmWIFwsYq0ZH1vnS9sjCW0FV8PTBy18T89+wXrkXaRN5Xo4k/TJOKIS2wPCa4hErIqzsduM6Ws4+f/ijvrn6PLzbqVzMeWmTA38VbL5SGYJC2IJiCjLNY/jEgofi0hbyk1GZosKtFH48IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9pVXKHecWiMOIExGI68aJaESIY5NSjmVxVvvwrXcT0=;
 b=c+W2cs2JwA7mMK2vPRykpFhKmIXsVSaCkxGVwKkrSLcxleMeZJ7zR/oH4loJbMOat0eYjUfjTKofSCxs9VYnwHFI8pHFgXQUBBoup1EismLsEIwF7042oj1VrZ+CsroED9AUD41Kl3rp8c7kgMfj26sbzEzt+t0aiuNflGv9VeI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB2936.namprd13.prod.outlook.com (2603:10b6:a03:183::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.14; Fri, 25 Feb
 2022 02:33:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Fri, 25 Feb 2022
 02:33:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 19/21] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Topic: [PATCH v7 19/21] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Index: AQHYKPtgN77REpvsVUWcQtB9d3Bbtayi9t8AgACXPoA=
Date:   Fri, 25 Feb 2022 02:33:16 +0000
Message-ID: <73e0a536c0467693db87c3966cf02e20ff3d889b.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
         <20220223211305.296816-2-trondmy@kernel.org>
         <20220223211305.296816-3-trondmy@kernel.org>
         <20220223211305.296816-4-trondmy@kernel.org>
         <20220223211305.296816-5-trondmy@kernel.org>
         <20220223211305.296816-6-trondmy@kernel.org>
         <20220223211305.296816-7-trondmy@kernel.org>
         <20220223211305.296816-8-trondmy@kernel.org>
         <20220223211305.296816-9-trondmy@kernel.org>
         <20220223211305.296816-10-trondmy@kernel.org>
         <20220223211305.296816-11-trondmy@kernel.org>
         <20220223211305.296816-12-trondmy@kernel.org>
         <20220223211305.296816-13-trondmy@kernel.org>
         <20220223211305.296816-14-trondmy@kernel.org>
         <20220223211305.296816-15-trondmy@kernel.org>
         <20220223211305.296816-16-trondmy@kernel.org>
         <20220223211305.296816-17-trondmy@kernel.org>
         <20220223211305.296816-18-trondmy@kernel.org>
         <20220223211305.296816-19-trondmy@kernel.org>
         <20220223211305.296816-20-trondmy@kernel.org>
         <EF67F180-F1D8-4291-92C8-86E5D10D1F25@redhat.com>
In-Reply-To: <EF67F180-F1D8-4291-92C8-86E5D10D1F25@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3966764-db45-4ae5-01d6-08d9f8072dfb
x-ms-traffictypediagnostic: BY5PR13MB2936:EE_
x-microsoft-antispam-prvs: <BY5PR13MB29361728C16C79D1EFACF167B83E9@BY5PR13MB2936.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hJ1rbVuQnPD1znAz8qh4XqUJvkBiLJoQpZlxmMk5mkqREDQmtWVt5cHWjB4PELyyMlbMQvhrk2Qdnh8grMDlPyZ9ypj7cM2IVIOt57MrVUO3q8qX6kL5fGGlDoXjd2/D9sGEKx0zHKq1XIWFvXfTJaJIoCMVF7LSLeajB2rqCvD1klDFXEW2iuw7stX+g3Y26sl8kIvyiUYhQbtHXJQn7iYAmWXQci+XCkjnSApK4G/avvMFtR9KnPdDIwA43O5R7W1SdieBm0bZkhsuJxXl3iA8duhj9fibMPBTn4QUclkmemi8Yp97zx0F/pIeLLbw0a6+N76AGPn+pcALvXD1KY41MZ5xNAaKUPwvraUwtBqPc5KfX3lurhgJtkeW9xGCaOG0qSll7r3JiZC+w7g6uKv+t61qt6zlUn9WkjgBSha2tyFVBGSTq0o2+wJeL+koqfW3GIhEW3lb6cv5MOatTbSvAx13k48TxMqbOi0uxA/GCLgdj1dmJEdhc3XTacJIG/wb4kPm7cSEjNfIyRhNLD/66y7Trh5gI2EeyvmwWRKkYKgHGT5JxcnhdX6wGvdDgLOsJVIX8wPz1EiddNqDn7S/BUOb/Ru/SxyOF3Qp/reix+nP/ropFgheVGbYUvRPoVac3W7qDXXzXX7Jjat5YdBEPJVQOcA41B+s/FxEWYEdwSfEojWyx06kSamTRX9aeArkwIoywx61chkEvyLMcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(376002)(366004)(396003)(39840400004)(186003)(2906002)(6512007)(66446008)(64756008)(66946007)(66476007)(76116006)(66556008)(26005)(36756003)(122000001)(38100700002)(5660300002)(6506007)(8936002)(53546011)(38070700005)(6486002)(2616005)(316002)(83380400001)(508600001)(71200400001)(86362001)(6916009)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUVHZENXSzlUNm0xWlRWLzBjOWFnSVZLWkNXZ0NvRnVseEpHSVM2L3k4UmtN?=
 =?utf-8?B?Nit5SGxMVXVMM0l6RHZBNWtDN2EwZVpCVnJCd2VndEViQzBidE1xaXBab1lW?=
 =?utf-8?B?cVYrWngwQlVLQW5renJsUHg5aUVETy8xTmMzVCtXWU9MNVV0dno2Vkd5MHd5?=
 =?utf-8?B?S0U2a1pybEc3ZjNhdDg4aDMzM1Y4K2pWdkJYMjVqdnR0TUlmZ01BMGlXREx1?=
 =?utf-8?B?YlpDS1hoUXkweGFNZXZjamRwdjE5L1hyR2trcmF1R1c2TjVDVXB6bDNoR29C?=
 =?utf-8?B?UlpNOTRYQ3lLaVFrOTlEd0l3eUxMbW92VVhIMFljdERFYmt2aGdrektjQklh?=
 =?utf-8?B?WEtZTlNaS0NrWHFZT2djTjFqZ3BYOUVzNnhUb3pYczRkNnFaVTZFQ2trWm1l?=
 =?utf-8?B?blBuaEEvMC9aRXc3bjFSME4wOWJTUjZZdnZralZKOTR5K083eGJRNFlocUpj?=
 =?utf-8?B?YTJGTzF3VEpOcjVzSHQ5enNPRHhWL20za2ZsSzhIM0l6R3Evb09QVTlOVVgx?=
 =?utf-8?B?dm5RbDdNNDdnSHFGNEpueElRMjI3bERmN0NQazdBK05BVGxEemZYd3VxVmVP?=
 =?utf-8?B?R2llRzVDQytYZEVtWklBQlV5T1BQT1RYZ1pNWEpIcGFHcFd6RnU4R3RtYjVs?=
 =?utf-8?B?dE5mTHZIbXJVMENhbmtHUkJ2bWp3QnhBUjdiUllKby91ZnJKcVlWVVhQcE9h?=
 =?utf-8?B?VzZpa3MyTUl0b1JqenFsSnY1ZU5TOGFzRlhaMTdsbm1uaVVOSSttNmlxWVd5?=
 =?utf-8?B?c3hRamJQTjl6bDUxS0t3Y0tHZEM4RUFuRWNzSkUyZG5VL3A2MTd0cmdlN0sy?=
 =?utf-8?B?bFZUdlNqM29IV25TblZ5MTZFT1RSdkJ2cHRhQlo0aGxtWFVhSWRNMnVwZSts?=
 =?utf-8?B?OTlGRStvK3N5eVRkUWd0aFZtenk5T2VoTTd5YkdLTW1jcThidytKejBzTTRa?=
 =?utf-8?B?aW82emc2THl1Wk5WSjd0ejhmS2R3QXBSK1dqK1MrRE1ObXVlNlcvWklkeURF?=
 =?utf-8?B?UWNXYnIyUXRKZy91ZlovN2ZITU1ZMFFKalVvZ0htZzVFcW94NjRBamVSL2h5?=
 =?utf-8?B?dTVTR3hUS1kwNnpsNFc2UEEvbEpYaTdyMG90VFZIbWlCclU1dXhHZVdWYlVN?=
 =?utf-8?B?Nml1SmZTdkgyZzNscGNDNXpHenY1SklWMnhmeFR0ZWdOUWw1VEpsRXRNMU1k?=
 =?utf-8?B?WW5iRXRSOWZYaHNPL0NIN0NteWRCdTQyQjhJWksyZC9iWE9KUXM3SWlBQ1c5?=
 =?utf-8?B?anpldXJyMFdVaGpRdTQ0dGhKQytjckhFa0c5dGFKQWpmRzZDNjdZWS9SQnNt?=
 =?utf-8?B?UHFQb1Z6eE9vSHBTaGhTamZnc0xLTndHNGRPZjhQVXJLQ0JKTTYwK1Q1Nldh?=
 =?utf-8?B?WE14Tm0yVnBrREdyckZLVDY5LzBZakJtYnhJR2ZLdDFCVlRNYkRINlN6ZzYx?=
 =?utf-8?B?aUdjSjdnblkzcUVDZTBYNHRmejc5SmgxcnVJRXZoUnVnWlV4RWUzbGF6NkQv?=
 =?utf-8?B?bHJMd0gycGNSeTR5YVNObHduMmplNlRBU3RqU29rOVlhQjJRZ0Q5RTMxeE4v?=
 =?utf-8?B?ekxaSHdzd1Q2Rk5uaE92T2I5dUdWN2lVbnc5SDkyYXZQQ1BTZTUxOXVJZU9r?=
 =?utf-8?B?ZnE4VFFIbDg4a2ppajU5bjAzTnRGTVFqMUVHcFlnYSs0djhzTi9sOTZ1L0JX?=
 =?utf-8?B?bUYvVE9XaDRLNGpGam1yaHFIZXFsYmpGa1lxSjlqeXRmeTVVQXluVWRuU2U5?=
 =?utf-8?B?bDA2b2srb0FaVVBmWktLWTdRY2lWWVB3UUVQNCtJcSs5UENldjRxalFwUGdH?=
 =?utf-8?B?V2tXV1l2c2p4MjNNd0tHRUUvZzlkVSs5ZGZMVXc0a09xUHhIWWJ6YnliekYr?=
 =?utf-8?B?OHdXc1NLM2dDaVl3U1dQVlZjS2NabTAvMFJuaXNyMnZvSEhvb0Voejc1dnVs?=
 =?utf-8?B?NFE4cm1VODh4dXlWYTVMdFE1cE5pNFBKNkJGL0NaVFFvc2c2eUhTQmsxeVE3?=
 =?utf-8?B?aHh2UFlIYi9DNit1ZTcySTg3YlZadFp1NDlQS29DSHpwY0haV3pSa2xwVERU?=
 =?utf-8?B?eWMwNnZxL3JvbmIrVHUweElraTM0T2hkdmI3VmgyN3RGTFNYSkhsNXg5WmVh?=
 =?utf-8?B?aW05R1h3eW1YcVNWOUQvcWZxWE5rS01jYlBtOXNzOER0VW5vNGV5eG81c3NM?=
 =?utf-8?Q?wBLCtQm/Aa+mZmZ3a0eEbAg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71BF5A141AB60845B3D7A9E452A66610@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3966764-db45-4ae5-01d6-08d9f8072dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 02:33:16.8570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ip/x+5U2xE1efH/7E67XBjD/C592aNDrXdjk7hmtzK/2QuvT7nG9R6ihK3GyhHJ4ttJxN+mF+Kn4PEw10eLelg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB2936
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTI0IGF0IDEyOjMxIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyMyBGZWIgMjAyMiwgYXQgMTY6MTMsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3Jv
dGU6DQo+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbT4NCj4gPiANCj4gPiBJbnN0ZWFkIG9mIHVzaW5nIGEgbGluZWFyIGluZGV4IHRv
IGFkZHJlc3MgdGhlIHBhZ2VzLCB1c2UgdGhlDQo+ID4gY29va2llIG9mDQo+ID4gdGhlIGZpcnN0
IGVudHJ5LCBzaW5jZSB0aGF0IGlzIHdoYXQgd2UgdXNlIHRvIG1hdGNoIHRoZSBwYWdlDQo+ID4g
YW55d2F5Lg0KPiA+IA0KPiA+IFRoaXMgYWxsb3dzIHVzIHRvIGF2b2lkIHJlLXJlYWRpbmcgdGhl
IGVudGlyZSBjYWNoZSBvbiBhIHNlZWtkaXIoKQ0KPiA+IHR5cGUNCj4gPiBvZiBvcGVyYXRpb24u
IFRoZSBsYXR0ZXIgaXMgdmVyeSBjb21tb24gd2hlbiByZS1leHBvcnRpbmcgTkZTLCBhbmQNCj4g
PiBpcyBhDQo+ID4gbWFqb3IgcGVyZm9ybWFuY2UgZHJhaW4uDQo+ID4gDQo+ID4gVGhlIGNoYW5n
ZSBkb2VzIGFmZmVjdCBvdXIgZHVwbGljYXRlIGNvb2tpZSBkZXRlY3Rpb24sIHNpbmNlIHdlIGNh
bg0KPiA+IG5vDQo+ID4gbG9uZ2VyIHJlbHkgb24gdGhlIHBhZ2UgaW5kZXggYXMgYSBsaW5lYXIg
b2Zmc2V0IGZvciBkZXRlY3RpbmcNCj4gPiB3aGV0aGVyDQo+ID4gd2UgbG9vcGVkIGJhY2t3YXJk
cy4gSG93ZXZlciBzaW5jZSB3ZSBubyBsb25nZXIgZG8gYSBsaW5lYXIgc2VhcmNoDQo+ID4gdGhy
b3VnaCBhbGwgdGhlIHBhZ2VzIG9uIGVhY2ggY2FsbCB0byBuZnNfcmVhZGRpcigpLCB0aGlzIGlz
IGxlc3MNCj4gPiBvZiBhDQo+ID4gY29uY2VybiB0aGFuIGl0IHdhcyBwcmV2aW91c2x5Lg0KPiA+
IFRoZSBvdGhlciBkb3duc2lkZSBpcyB0aGF0IGludmFsaWRhdGVfbWFwcGluZ19wYWdlcygpIG5v
IGxvbmdlciBjYW4NCj4gPiB1c2UNCj4gPiB0aGUgcGFnZSBpbmRleCB0byBhdm9pZCBjbGVhcmlu
ZyBwYWdlcyB0aGF0IGhhdmUgYmVlbiByZWFkLiBBDQo+ID4gc3Vic2VxdWVudA0KPiA+IHBhdGNo
IHdpbGwgcmVzdG9yZSB0aGUgZnVuY3Rpb25hbGl0eSB0aGlzIHByb3ZpZGVzIHRvIHRoZSAnbHMg
LWwnDQo+ID4gaGV1cmlzdGljLg0KPiANCj4gVGhpcyBpcyBjb29sLCBidXQgb25lIHJlYXNvbiBJ
IGRpZCBub3QgZXhwbG9yZSB0aGlzIHdhcyB0aGF0IHRoZSBwYWdlDQo+IGNhY2hlDQo+IGluZGV4
IHVzZXMgWEFycmF5LCB3aGljaCBpcyBvcHRpbWl6ZWQgZm9yIGRlbnNseSBjbHVzdGVyZWQgaW5k
ZXhlcy7CoA0KPiBUaGlzDQo+IHBhcnRpY3VsYXIgc2VudGVuY2UgaW4gdGhlIGRvY3VtZW50YXRp
b24gd2FzIGVub3VnaCB0byBzY2FyZSBtZSBhd2F5Og0KPiANCj4gIlRoZSBYQXJyYXkgaW1wbGVt
ZW50YXRpb24gaXMgZWZmaWNpZW50IHdoZW4gdGhlIGluZGljZXMgdXNlZCBhcmUNCj4gZGVuc2Vs
eQ0KPiBjbHVzdGVyZWQ7IGhhc2hpbmcgdGhlIG9iamVjdCBhbmQgdXNpbmcgdGhlIGhhc2ggYXMg
dGhlIGluZGV4IHdpbGwNCj4gbm90DQo+IHBlcmZvcm0gd2VsbC4iDQo+IA0KPiBIb3dldmVyLCB0
aGUgIm5vdCBwZXJmb3JtIHdlbGwiIG1heSBiZSBvcmRlcnMgb2YgbWFnbml0dWRlIHNtYWxsZXIN
Cj4gdGhhbg0KPiBhbnRoaW5nIGxpa2UgUlBDLsKgIERvIHlvdSBoYXZlIGNvbmNlcm5zIGFib3V0
IHRoaXM/DQoNCldoYXQgaXMgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGlzIHdvcmtsb2FkIGFu
ZCBhIHJhbmRvbSBhY2Nlc3MNCmRhdGFiYXNlIHdvcmtsb2FkPw0KDQpJZiB0aGUgWEFycmF5IGlz
IGluY2FwYWJsZSBvZiBkZWFsaW5nIHdpdGggcmFuZG9tIGFjY2VzcywgdGhlbiB3ZQ0Kc2hvdWxk
IG5ldmVyIGhhdmUgY2hvc2VuIGl0IGZvciB0aGUgcGFnZSBjYWNoZS4gSSdtIHRoZXJlZm9yZSBh
c3N1bWluZw0KdGhhdCBlaXRoZXIgdGhlIGFib3ZlIGNvbW1lbnQgaXMgcmVmZXJyaW5nIHRvIG1p
Y3JvLW9wdGltaXNhdGlvbnMgdGhhdA0KZG9uJ3QgbWF0dGVyIG11Y2ggd2l0aCB0aGVzZSB3b3Jr
bG9hZHMsIG9yIGVsc2UgdGhhdCB0aGUgcGxhbiBpcyB0bw0KcmVwbGFjZSB0aGUgWEFycmF5IHdp
dGggc29tZXRoaW5nIG1vcmUgYXBwcm9wcmlhdGUgZm9yIGEgcGFnZSBjYWNoZQ0Kd29ya2xvYWQu
DQoNCg0KPiANCj4gQW5vdGhlciBvcHRpb24gbWlnaHQgYmUgdG8gZmxhZyB0aGUgY29udGV4dCBh
ZnRlciBhIHNlZWtkaXIsIHdoaWNoDQo+IHdvdWxkDQo+IHRyaWdnZXIgYSBzaGlmdCBpbiB0aGUg
cGFnZV9pbmRleCBvciAidHVybiBvbiIgaGFzaGVkIGluZGV4ZXMsDQo+IGhvd2V2ZXINCj4gdGhh
dCdzIHJlYWxseSBvbmx5IGdvaW5nIHRvIGltcHJvdmUgdGhlIHJlLWV4cG9ydCBjYXNlIHdpdGgg
djQgb3INCj4gY2FjaGVkDQo+IGZkcy4NCj4gDQo+IE9yIG1heWJlIHRoZSAvZmlyc3QvIHNlZWtk
aXIgb24gYSBjb250ZXh0IHNldHMgaXRzIG93biBvZmZzZXQgaW50bw0KPiB0aGUNCj4gcGFnZWNh
Y2hlIC0gdGhhdCBjb3VsZCBiZSBhIGhhc2gsIGFuZCBwYWdlcyBhcmUgZmlsbGVkIGZyb20gdGhl
cmUuDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
