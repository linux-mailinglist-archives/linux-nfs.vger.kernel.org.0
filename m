Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D684C79C0
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiB1UDl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiB1UDk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:03:40 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2092.outbound.protection.outlook.com [40.107.102.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C583DDC6
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:03:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chhC32jP8ZvVsLcdbzli7ZJ362zdZS2HQh2SHGYCJoCFBLmymcznHV9hTmnSudefAufa6Xa9UGYQsHvHhvpwurncan/M2hkeDyxZhaW89IWkIEAF4PG9+XZcWazbjiw8JMUua93F4wyXbo+4Q80+JTNBEJBVg4rxopQ58aZHepK/ifmYZz/aTCOxvdeFUu4/1mdJ9vqsLaUmWTv+dPvvTz2G9O3WzEtCfTFg+WH16kfg4Nzb4b82CNRs3QHhGOU+4DbvxnGe4A2DaLWH4Zc+rIW8PpdpJ/NKkfCdRc8ePOo8qpLerwdTF21Aj+bmO07lvZSeASv0hqi9Q5dw+RKsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+YN4YcLqJXubrkjNHhyXrJudo6f2ViDxh4wI73q5XU=;
 b=hwUQUCH5ItwB03z7b5jcv9F7C9n4/VZsF1oRDCGvA2GAcDJpSRia4XOp8hrBwhMz7qs/lLlckeS29NA3YkiwoWZ43o3gMpj4tKnuC4lqL2ZY6FONoJEUelEV60vwBf2mFSaPWncfMiQkEsA/MW2G+qYdPZnRSEnVLyidfucGBdAIZfujBhiZotFubo+cEx1eolKn8JeSGJWZ7SWLiG4v/8EjhV14C9LcwfUiaJhLtX87rs4mcqi5qYvEqHAHwEj4Qd6guUA2HHK+g0udNXBjOSrz+HY6XEm4G10WqthgM7zY+eV+qnT9i+Jd6LImxeuqXKq0lbQrmFfFOEOXMxcoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+YN4YcLqJXubrkjNHhyXrJudo6f2ViDxh4wI73q5XU=;
 b=OYFAMDlFMREFzU9xBUwlN3pabTgKcTuG4a3r0RlVoMJQKra4QRmgiOZxKE6SxAOMWNieQ/ieycliz7ApWQELbUvTyb+8dhXVM4burFJq4RF8P9Rh9My0MYwpps6NkAbXLNs9prF+udX0q0lyq66hcJJJnswwjTfpCm3PFPmdJm8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5519.namprd13.prod.outlook.com (2603:10b6:510:12a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.10; Mon, 28 Feb
 2022 20:02:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.013; Mon, 28 Feb 2022
 20:02:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: managing trunking
Thread-Topic: managing trunking
Thread-Index: AQHYLNUxXT517O22HkejZZ9Hv9ivx6ypYq0A
Date:   Mon, 28 Feb 2022 20:02:56 +0000
Message-ID: <3136254d57e8e17537ea0d21a195293f162e42b8.camel@hammerspace.com>
References: <CAN-5tyE4n2WgQhtuX_1JZsHnyXXZgwGJbRYjw5jrA+bfVcC3uw@mail.gmail.com>
In-Reply-To: <CAN-5tyE4n2WgQhtuX_1JZsHnyXXZgwGJbRYjw5jrA+bfVcC3uw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcbc34a5-40eb-4433-9b92-08d9faf54fd8
x-ms-traffictypediagnostic: PH0PR13MB5519:EE_
x-microsoft-antispam-prvs: <PH0PR13MB5519BE8B6EF6E079DCC272E6B8019@PH0PR13MB5519.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0HaBZ1Ou1YnOY5tWCwDu4b5W5eaGE4pCZzOJc+gXKcGywSnxOrIMfBjNRsp5LyRxUXqLG6KnkbujjKC1ldKNIyeJaxt9SrtUb+imCvGEQ/xTHLoEhWl4an7rvcZOVPbfvsg6iPVLaaYdYVClv2TsGfH1jb4V7oqztqYmUnNuif5SxFMB4yuCR+HqSilSScNJXb6fz66XR7TsTy6iql16yQuNEh1cG73QGiMvdjb5n4oDYf9cDlG4wlGkwRXc/hOXyPQwRflEBED8B/i7tJFRKHcvhyWqxG0XRK3hbHALE5Uz5z5qzjLFiI9r+1l4tLw5PHHoVoiJyEZ2Mg2NQ1kmUbCB34JKMbjKasHx5bYs9z88wZiPU7/7tMHOUhqtXA7Vm+9k+oPQzidrVVqJXIdEvwIjH+gfG3kdQpw4qyoN4eAfs8riTMD9v0ZAemlTf5CkVVwqMwICHwx+jzhj1pg0BuVayToD3dJPCNtnOOTeO0AINPQtrLJ4J1O666AlLDAIih8BKT8gc+/JK3Z6LJRd46oo+7il/W8P2cO9i/Rj3LmF4M03ZDR/CMPzS9fyWREoPEQvqxz2FqpnXuttDiXWN0f+tQh28sXiJwy8+NVzrFa8cGzDfUjuyEdHKdHJ6FbSZ0v1aUt0ahhnt3ZaXC0UGDsUJg+0Got5zdU9gE7kVaa27IUFQ5+NsUl0r8/pnTtBckKguXkTzCqwnK8QPwnDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(2906002)(86362001)(508600001)(71200400001)(2616005)(186003)(6486002)(26005)(66476007)(66946007)(66556008)(38100700002)(66446008)(5660300002)(76116006)(8936002)(64756008)(8676002)(7116003)(38070700005)(316002)(36756003)(110136005)(3480700007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0l0M0VudmprY3IzYldxYTNHcTYxTTZqRmU1azBsMU5CQW03cE42c3BkWG5N?=
 =?utf-8?B?T2crazdTOWdCNklzNWtxeCt6eXUyekVvTGs1M1NYNTEybE5mMkFYMmU1UXd4?=
 =?utf-8?B?MGFSYzc4eVFwUVFLc1JrcW5tUUJxbENCd292RjI4OXRHeG8xLzJ0bFpXN1FV?=
 =?utf-8?B?NFk4U3duUVU4bVhsOFBzVENldGJmYWpsUHducDdHQjJyWWhsWGVxcTF5a1Zs?=
 =?utf-8?B?bjZycTJBaE5DTjl2ZFAxSVlSRHFRcS94VUVDRGtReUpXanFOcVd2YU1IUWtS?=
 =?utf-8?B?dk1oL2JJbStLZnRZL3pjZ1JIR3lpMThCM1psSHU1ajQyRjBOMnpmYzM4SWpx?=
 =?utf-8?B?NklTd2NEbkQwS3NXZXFjeGVHN2NPUFhVVmdwczJPbzE2MEpkZXFNSVVPUE8z?=
 =?utf-8?B?eVVBbkkvQzNJeUtLTi9YYlBYOEtxemwyeVYzcnh4UmdjcTNTTkQ5enIyTTkv?=
 =?utf-8?B?QWFsUU83S1V5cmRycjBidnpvZHU1OUNDNnpQZWFlWEladGJnZkd6MUQzbmx6?=
 =?utf-8?B?ZUZVZXYydTMwL0FEQU9lbk0zNmpHSkI2amFJdTF0czBLc0tBd1NRdk1SSFIz?=
 =?utf-8?B?WHoyb0J5UWtKSEdscVlqK2o1KzE5eTQ5NVlNODIzQWVhbFJLZmJKM2M2YTho?=
 =?utf-8?B?K01JK05EcG43UGlKUTl1S0NXN3cxNVYvL0FoQWl0bUppSVlZSFBWQWNyM3lG?=
 =?utf-8?B?OHdHUGx6Q1VEV3QzQUpDenNtYVBlL21UdUdiZno5MlNobXNtQlBQU2N2c3Fu?=
 =?utf-8?B?WFdFTkp6cGpNL1psaVFrRDM3VXdFa1p4OXMxUXp6RFBQdXd1TG5BYnBIVlNU?=
 =?utf-8?B?amJVNTFBLzNDYzh6bDNxL0NZbGRKVFovM2tYeGVSSGR1dW4xcmJGVUxpSmhm?=
 =?utf-8?B?SUxyczdHOXFWdVVPcXEwYlhSeE9zZUFIcUpWV2N4MGtsN1A5VVZER29rcjBR?=
 =?utf-8?B?T1hmV3VqRnlyMUdvSGFNT24zZ1ZaVXRqMDFIRFlmb2kyRHpIaFB1ekpOb1gy?=
 =?utf-8?B?M0pUZWhoVEQ0UmE0L2VDdHJPMUE0TU1INE9pTkIyUkRDYTZkemQwUVBIM1lT?=
 =?utf-8?B?T3hqVGljVDlmSmRLUDRoeUdmQllrdXY0Rk5HaExMMmxSa3FoUlduODZMWEJr?=
 =?utf-8?B?eXNQaFk4M3FLSmJGdHo0VkNZV0hBVDZYV2M5dWFaWk9NcHE0dnpsSDIyYUZW?=
 =?utf-8?B?bHpoMFhnLzVKTHcrbGRVUVd4RzlIOTNSelJYellOanlHb2tUVjJ1c3YreEFk?=
 =?utf-8?B?MWVRREZ1Z09tYXNKR3prbXBXS1N0aTJsUkpDYmpSTmcrZHJMZnZxVDlxZG41?=
 =?utf-8?B?ZURHdHpvQXNzek96ejQrY1ArQlUzK3FCdDA0YmF0VWpTdlptM1BZLzZ2aXRJ?=
 =?utf-8?B?eHZkcmwzV0pvalpLU3liWVpINGRqVm85MVhIbGI1aTBPWTNoZnVFeUI4clFH?=
 =?utf-8?B?SUdEaStmVm1vdTY3NXJncU4xYWs0VHlIZ05HZlNDUUYwenY1SjV1Q0luajFR?=
 =?utf-8?B?dURJZXhjMEdUaTJwclpLWkxTU3VRVW5uNkErYlh4SkI0TlljT1dyRzJkZ1Ev?=
 =?utf-8?B?bThhdytYUHFqS2QyQzRUTExZUkxVanhRUHM3dXN1Z1pmZk5VNHJpRDZCQ2Zh?=
 =?utf-8?B?ekJKQ3BpbGlQaTdYdzBCYS8xR21ITWtlaVBqQ0w2TnJDZkcrbWRLZ0VMVmx4?=
 =?utf-8?B?S0RXMVBvcjgxZXlMdjV6YU80NlVkVEJQbk1YUTBvSEdWWEFEY1JudFF1TFdW?=
 =?utf-8?B?bnhzeURybXpFZkJNclpyVHNJOWI2VjlqTUgrSnVJcWcybjhGOVQrWEJBM1RJ?=
 =?utf-8?B?a29WZXlJQjJiQndzM0N1eENtQ3IxR2dVdkVubHU0L1BSaGxGZHUwQk5jenRP?=
 =?utf-8?B?ZGRRa3ovUzFEMkplLzZjbFAwd2JHekkvNysyM1JZR091NXZHUUloeVVLMzZ0?=
 =?utf-8?B?WUF3WXZFcncyZnUwVEZMYk1nWDB0d0NKekt5RU5ybGhoYzhNZnpIODl1RDRv?=
 =?utf-8?B?OFV4M09CZXZwNHZHdklsQnd5dnZTd1BQZStydVFlWnhWV014WnRqeVNWS055?=
 =?utf-8?B?U1o3bGdZMlB4bm5vVW1zUXU5ZE5tbU5GSWR6TmUvRWNwQm04MFd1VCtsQXg1?=
 =?utf-8?B?a0d3a3U3cXlhWlA5dVZIblB6Qm54NEFWQkR1L1F5dXZqcUdzRUNFeVZRL2Y1?=
 =?utf-8?Q?ucYclEwyZVgTSwsb55yhUIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <334DC6D3434AEA4CA197C72F4A6B1F0A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbc34a5-40eb-4433-9b92-08d9faf54fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 20:02:56.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83J8I3krkTtcRzpohWIpdnHQZ1c20WlkbBGd3/LbeGxOJq3uArBRaBy7u1vkvW8I1cejhZyVGSYayr7RWEIjyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTI4IGF0IDEzOjU4IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gSGVsbG8gZm9sa3MsDQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8gYXNrIGZvciB3aGF0IHdv
dWxkIGJlIGFuIGFjY2VwdGFibGUgc29sdXRpb24gdG8gZGVhbA0KPiB3aXRoIGNyZWF0ZWQgdHJ1
bmtpbmcgY29ubmVjdGlvbnMgd2hlbiB0aGVyZSBpcyBhIGNoYW5nZSBpbiB0cnVua2luZw0KPiBt
ZW1iZXJzaGlwLCBzcGVjaWZpY2FsbHkgd2hlbiBhIGNvbm5lY3Rpb24gKGllLiwgaXRzIGVuZHBv
aW50KSBubw0KPiBsb25nZXIgaXMgcGFydCBvZiB0aGUgc2FtZSBncm91cC4gQW4gaW5hY3Rpb24g
b24gdGhlIGNsaWVudCdzIHBhcnQNCj4gd291bGQgbGVhZCB0byB1bnVzYWJsZSBjbGllbnQuDQo+
IA0KPiBXb3VsZCBhIHByb3Bvc2FsIHRvIGRlc3Ryb3kgdHJ1bmtpbmcgY29ubmVjdGlvbnMgaW4g
YXMgcGFydCBvZg0KPiBERVNUUk9ZX1NFU1NJT04gYmUgYWNjZXB0YWJsZT8gVGhlIGxvZ2ljIGJl
aGluZCB0aGlzIHNvbHV0aW9uIGlzIHRoYXQNCj4gdHJ1bmtpbmcgbWVtYmVyc2hpcCB3YXMgZXN0
YWJsaXNoZWQgYXMgYSBwYXJ0IG9mIGEgc2Vzc2lvbiwgZWFjaA0KPiBjb25uZWN0aW9uIHdhcyB0
ZXN0ZWQgdG8gYmVsb25nIHRvIHRydW5rYWJsZSBzZXJ2ZXIgYW5kIGFkZGVkIHRvIHRoYXQNCj4g
c2Vzc2lvbi4gT25jZSB0aGUgc2Vzc2lvbiBpcyBkZXN0cm95IGFuZCBuZXcgY3JlYXRlZCB0aGVy
ZSBpcyBubw0KPiBndWFyYW50ZWUgdGhhdCB0aGUgY29ubmVjdGlvbnMgYXJlIHRvIHRoZSBzYW1l
IHNlcnZlciB0aGF0IHRoZSBuZXcNCj4gc2Vzc2lvbiBpcyBjcmVhdGVkIGZvci4gVHJ1bmtpbmcg
bWVtYmVyc2hpcCBjYW4gYmUgcmUtZXN0YWJsaXNoZWQgYXQNCj4gYQ0KPiBsYXRlciB0aW1lLiBJ
IGhhdmUgc29tZSBjb2RlIHRoYXQgaW1wbGVtZW50cyB0aGlzIHNvbHV0aW9uIGJ1dCBzdGlsbA0K
PiBuZWVkcyBzb21lIHRlc3RpbmcuDQo+IA0KPiBBbHRlcm5hdGl2ZWx5LCBpZiB3ZSBrZWVwIGNv
bm5lY3Rpb25zIHBhc3QgREVTVFJPWV9TRVNTSU9OLCB0aGVuIHdlDQo+IG5lZWQgYSB3YXkgdG8g
dGVzdCB0aGF0IHRoZSBzYW1lIGNvbm5lY3Rpb25zIGJlbG9uZyB0byB0aGUgbmV3DQo+IHNlc3Np
b24NCj4gdGhhdCBoYXMgYmVlbiBjcmVhdGVkLCBtZWFuaW5nIHRoYXQgYSBwcm9iZSBmb3IgZWFj
aCBjb25uZWN0aW9uIG9uDQo+IGNyZWF0ZV9zZXNzaW9uIHRvIHNlZSBpZiB0aGV5IHN0aWxsIGJl
bG9uZyB0byB0aGUgc2FtZSBzZXJ2ZXIgYXMgdGhlDQo+IG5ldyBzZXNzaW9uIGlzIGNyZWF0ZWQu
IElzIHRoYXQgcHJlZmVycmVkIG92ZXIgc2ltcGx5IGRlc3Ryb3lpbmcNCj4gY29ubmVjdGlvbnM/
IEknbSBnb2luZyB0byB3b3JrIG9uIGltcGxlbWVudGluZyB0aGlzIHRvbyBhbmQgcG9zdGluZw0K
PiBhcw0KPiBhbiBhbHRlcm5hdGl2ZS4NCj4gDQo+IEl0IGhhcyBiZWVuIGV4cHJlc3NlZCBzZXZl
cmFsIHRpbWVzIHRoYXQgdGhlIHVsdGltYXRlIGdvYWwgaXMgdG8gZG8NCj4gdHJhbnNwb3J0IG1h
bmFnZW1lbnQgaW4gdXNlcnNwYWNlIHNvIGRvZXMgaXQgbWVhbiB0aGUgc29sdXRpb24gdG8NCj4g
dGhpcw0KPiBpcyBhbHNvIGluIHVzZXJzcGFjZT8gU2hvdWxkIHRoZXJlIGJlIHVwY2FsbHMgdG8g
dXNlciBsYW5kIG9uDQo+IERFU1RST1lfU0VTU0lPTiBhbmQgQ1JFQVRFX1NFU1NJT04gdG8gZGVz
dHJveS9jcmVhdGUgdHJ1bmtpbmcNCj4gcmVzcGVjdGl2ZWx5IGJ1dCB0cmlnZ2VyZWQgdmlhIHVz
ZXIgbGFuZC4gQnV0IGluIHRoaXMgYXBwcm9hY2gsIHdoaWxlDQo+IHRoaXMgaGFwcGVucyBhdCB1
c2VyIGxhbmQgc3BlZWQswqAgd2lsbCB3ZSBiZSBhbGxvd2luZyB0aGUgY2xpZW50IHRvDQo+IGdl
dCBpbnRvIGEgc3RhdGUgd2hlcmUgaXQncyB1bnVzYWJsZSAoYmVjYXVzZSBpdHMgY29ubmVjdGlv
bnMgYXJlDQo+IHRhbGtpbmcgdG8gc2VydmVycyB0aGF0IGRvbid0IGJlbG9uZyB0byB0aGUgc2Ft
ZSB0cnVua2luZyBncm91cCk/IE9yDQo+IHRvIHByZXZlbnQgdGhpcywgd2lsbCB3ZSBiZSBhbGxv
d2luZyB0aGUgdXNlcmxhbmQgdG8gcGF1c2UgYWN0aXZpdGllcw0KPiBpbiB0aGUga2VybmVsIHVu
dGlsIHRoZSB0cmFuc3BvcnRzIGFyZSBzcXVhcmVkIGF3YXk/IEkganVzdCBkb24ndCBzZWUNCj4g
aG93IG91dC1zb3VyY2luZyB0cnVua2luZyBtZW1iZXJzaGlwIGNoYW5nZXMgdG8gdGhlIHVzZXIg
bGFuZCBpcw0KPiBiZXR0ZXIgdGhhbiBoYW5kbGluZyBpdCBpbiB0aGUga2VybmVsIHdoZW4gbm8g
b3BlcmF0aW9ucyBjYW4gcHJvY2VlZA0KPiB1bnRpbCB0cnVua2luZyBtZW1iZXJzaGlwIGlzIGNv
cnJlY3RlZC4NCj4gDQo+IEFueSBmZWVkYmFjayBvbiB0aGUgYXBwcm9hY2hlcyBvciBpdHMgYWx0
ZXJuYXRpdmVzIHdvdWxkIGJlIG11Y2gNCj4gYXBwcmVjaWF0ZWQuDQo+IA0KPiBUaGFuayB5b3Ug
Zm9yIHRoZSBmZWVkYmFjay4NCj4gDQo+IFRoYW5rIHlvdS4NCg0KUmlnaHQgbm93LCB3ZSBvbmx5
IGNhbGwgREVTVFJPWV9TRVNTSU9OIG9uIHRoZSBmaW5hbCB1bm1vdW50IG9mIHRoZQ0Kdm9sdW1l
cyBvbiBhIGdpdmVuIHNlcnZlciwganVzdCBiZWZvcmUgY2FsbGluZyBERVNUUk9ZX0NMSUVOVElE
IHRvDQpkZXN0cm95IHRoZSBsZWFzZS4gU28gdGhlIHBvaW50IGlzIHJlYWxseSBtb290IHdpdGhp
biB0aGUgY3VycmVudA0KZnJhbWV3b3JrLg0KDQpJcyBpdCB0aGVyZWZvcmUgeW91ciBpbnRlbnRp
b24gdG8gY2hhbmdlIHdoZW4gd2UgY2FsbCBERVNUUk9ZX1NFU1NJT04/DQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
