Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4ABD4515E2
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Nov 2021 21:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347560AbhKOU6J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 15:58:09 -0500
Received: from mail-mw2nam12on2107.outbound.protection.outlook.com ([40.107.244.107]:53729
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351778AbhKOUhK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 15 Nov 2021 15:37:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov9wxuZ2PLGH/lWVLM8aWkqkVTLJK6gAEo1H3CRs/jugwyDOTymm/Biyw5vjupl28fM7uijH74WWa/DGt1BpY+0PS58GjU7T3ty3V6yge4IKvGRZOUzQeO6OQAwezz+wQoFfRvjQU/eRktL7UjFn5ptKvorBIBKDd8+IfeBxXLutDvUzyRrcQdD1du6crjPbjT/QaFdQSmKGsh9ycI/Pq5KmtzUJhVPAIVQOH3EkfMbQsMp6t/q9Tgy2osS2fOOZKK1w6xp2R9pMc5qjFon2b986MpJiNS2ynVZkZC+VOLTiaK17z0uupK0zRjQO5bhSVJVVbgzEhJZPRS62Q4DHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P/vLU3nMNUwsuA0N3/5b34eL5G8R5n34dzGJze91Tk=;
 b=XOsZM89QXkDdW2M3RjXoZ/pa4TNS25oCAIH/rAegPIYlLJScQ8rni/0RNUiLAoCbPj0ivWkfiaHfuaLVEvnXiYr4061joWewZeB6zCtNqDtYtSRZRnaHEJdrl4z2Zi9qVyXun0ROK2PsARoBMrbnLzxoYi5KsOQ/m/lrYunkpW05TJHtHzgPMwBKkB3J9YpbQe2voTN7JLnKMZesCc97/k9sYfnQOp/QEzqVkvN+L5j4LVk7eGpUUTN85W2SDg6VuuyLsC3REqSilLYCmc5kKYb/TgfGmbKl9E5121XxcU4R4JE3fyYN4tgdMOuihhKU8geFRQkKAnmuqOsYNBq4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P/vLU3nMNUwsuA0N3/5b34eL5G8R5n34dzGJze91Tk=;
 b=IMWA4cngtRadQRMttHypDAf+FCv0B6K/0aaCFwtRAD15sLz6U148mFvI+4lun3TASrT4qlYDlfyVz36OZshK6eaM+TwsUrk5TSQKmBJ8RKlaZXUmeR+MVxlBVnpkMqhLB0eXcUjtBP+ouktt5lgRRLyyatGY/fJthaqODDOuNBE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5082.namprd13.prod.outlook.com (2603:10b6:610:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.16; Mon, 15 Nov
 2021 20:34:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4713.019; Mon, 15 Nov 2021
 20:34:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.1: handle NFS4ERR_NOSPC by CREATE_SESSION
Thread-Topic: [PATCH 1/1] NFSv4.1: handle NFS4ERR_NOSPC by CREATE_SESSION
Thread-Index: AQHX2l36fMShDKZj7EeZXfuVKzPNvKwFC4gA
Date:   Mon, 15 Nov 2021 20:34:07 +0000
Message-ID: <fda021efe885987b0e4da263c0427e271b481935.camel@hammerspace.com>
References: <20211115201834.98705-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20211115201834.98705-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd86c4cb-73f5-453d-0224-08d9a877462d
x-ms-traffictypediagnostic: CH0PR13MB5082:
x-microsoft-antispam-prvs: <CH0PR13MB50827361F811781C7CC92001B8989@CH0PR13MB5082.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQwsWjwUC6q+4ct4xFhcWGRcPGiyCJd5mfi15r6Rcj25NzogBEsPnrp5DBFNFZlS2brQaNhvdss0UQiCEflUttd+GMW0DHBXPbkuEVSTwQex0OyPIR3w3lJakqLzyInelMC3/6Rq/39VqzA3kY2iAE1A9ev/F9l1F2iiiievItfqFQNkus9CpLzQyfBopTvcT2JXZOtsPkKTXyh0aoHEKakkBUYhbRJh+4+GJo6+rkS5j13kaR9GRFKmNvrzcQ0xdlskRCZsU4nKGfjDV0N+gk8aFwz/YB0TXCzSUATUsSYmvCj9O3j0eOjG0wyR6puedwHniYrhdxayrfWcheebNxMBL9qVObwBobJikE/+3Yc5CEdU7Wa//6OAw0F8i1LLLgwgbydTnY9EM6RXsvW3nyaRy7g70Sgtn0pN8hoMSZQ6Tuj9VqQ0qJ1F13DkJ37XQpJZYBfE5aPb/6naidC3T4tM9f/6C4TS2ZoaQIWGaKMJ2PjmL7goG8XP+tLpsGl1DMQS0u6ZsSgbFaX+YejRDiD0u2EmCzL3pnCEYwUx/uCbsLQvOF9YFpkP2AqcKsk1zIHcNx5xp9n1puBsdOe7oNXDbE8IYqzfznrP8yGbXXYNT7XqOUgZdtligeZKqp+vyAeibSmlzRLPkUZzwjYKvD8bH+SVndaE45CW9QPzJB9+EM4Cviv0m1yQQgYMuAATkN7A6LFnfKh89gUrPWN01A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(39840400004)(396003)(376002)(508600001)(316002)(4326008)(6486002)(110136005)(5660300002)(2906002)(6512007)(186003)(2616005)(36756003)(71200400001)(86362001)(64756008)(76116006)(26005)(66946007)(66476007)(66556008)(66446008)(8676002)(8936002)(38100700002)(122000001)(6506007)(4001150100001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFRrNktLK3VHcEZWUkhGbHRJMzBKeklLTDlRVU9rM0JGZVNYa0kwZmhSV1U3?=
 =?utf-8?B?UVZQMjBuQmw4d3E0NG02WlZJMkVQbGo2WWgwdFhaRmVPTlBwdGp5bmJndlZ4?=
 =?utf-8?B?d2tBVGRNMktvK3JNcDl6NXVPbWJKUnhQM1ZHMkh3SXQvays1ejBYYTJPQnVa?=
 =?utf-8?B?SXh5REd4eXdFcXhyU1A5VlN5djZXSStFeXBxa1ZnZ1JETldua0szRHhiY1or?=
 =?utf-8?B?Y2FZSklqWWU5czUzOWl1TXdwdmpSaW5LejNCTzlIc0pVVHZJc2NuY2JUUFNO?=
 =?utf-8?B?S2dqeHBLVUIzMGVSY0NYVWFOa1h4WlU1NmJDcEg0YlZxOVNSa0VURXNwK2s0?=
 =?utf-8?B?Z2NRNnVoenhLTTNRMVpibmJveXpPSXQvYUtJRkNtbUMrWmtNWVlwenVlcmEw?=
 =?utf-8?B?YXRReWJodXZDSE12TGU1ekt3SHB0ckxPK3lqTkdpdldLOE45MmNrN3ZuVWJX?=
 =?utf-8?B?SXZYb3dKdmlyQjFnNGpHYXlONmFiZmxzSlkzNGpmOThiZVpHZVc0cWtPNUNJ?=
 =?utf-8?B?R1FVellHOUhBNmZaa2lXV2FwS2JwVXVYL2JTNTVmTFB1SkJ2eWQ3NkRhd3lS?=
 =?utf-8?B?cHZSNHZkdnZYb05zbW5WTmV3OUwzSkx3U0NQa0lqTHo2T2tkUDVLTC9PYzZQ?=
 =?utf-8?B?SkpySzhQOXFQZzZVb3BFTnJRN0V5VHk3UXpBSnR0cTZOM2pwQ1VmL0oxMnZX?=
 =?utf-8?B?YnZjOVYvYVQwNzZ3aWJ1NDFMSy9nY0lGOXcrRzFMOWtvUlJaVTFjdFFoL1Mx?=
 =?utf-8?B?djdCNUZ1TU43M2FaL3hZTHl3SDQxcGpZMkd0QzhHRUJRdStTTFg5MEdXaHNz?=
 =?utf-8?B?enNLL2NwYWZORUFkMnZrMDVaZnU4VzE0aWsyL09HaXBqeG80WGVvemdWb2h0?=
 =?utf-8?B?T042b0FSNDV0YXJiRVhPQlh4dzljUTJXS1p1SVlIZVFnV25FU1dZRkJtUnRz?=
 =?utf-8?B?SzVseSt3TGU2WjVnbEkyZ2VrV2VWUDBuTmJyRUlza3MrRDk4ZkNBekYrWERU?=
 =?utf-8?B?NHdZTm1Cc0xSZjNUWFVGdXVBN3NsU3pYalhacDMyQnMwOHV5Vm5lN2VnUWNJ?=
 =?utf-8?B?QWhlUzN0Yi83QVgvblFzdmhWZ0lCL1dOclFQY1VsMjBzMVJwbFNvcHRKeWMw?=
 =?utf-8?B?SG9jclR2Q1RqSEE5WFkrNEd5QXQ4RlV0N3RzNWtVNUZpeldkQVVxdVJBSVR5?=
 =?utf-8?B?NGhwM3JYWXdKTmhQd3ovZENvNmpBcG4rS2krSm4vNG5vY0dCc0lEaXd1Q0tQ?=
 =?utf-8?B?ZEg5R3RiUXFRcHNqRlh3WHZlNXdsaWF2TzVDOEllaEFnUDhRYUxIRkRvdi8r?=
 =?utf-8?B?b0Z0M05CK0dKYTVub1JtWlM3M21kZzB3UnVScTc2Z2RVbjkwVi9xU1JwNE1W?=
 =?utf-8?B?NnAwdHVkbEE5Y2hpK09qamFoMUErR3dDcVVvWHUvT3FpTzRBcE1FSnlBWFFN?=
 =?utf-8?B?dk5ZdVdSQzkvT09hZTRVZVV6SU9HcU8zSkJLRUUwMUNOb1AvcG5zdFMwZVJW?=
 =?utf-8?B?VExmNkNyTlFqK2E3YU5rMlRUSXRNN3EzQmYzeW1uRjNDTkNHN2ZZYUtIdU9F?=
 =?utf-8?B?OW9jZXF1TzlkOVAyZklpNFdZSkRJdnJLUzBUVlRoOC9lT0p5dExwcnZURVAx?=
 =?utf-8?B?a3MzQkk2ZVpuREM0UXZRZGNsZ1VPTno4UXdIVG51MmRpUkZ5U2s2THQ2V2J4?=
 =?utf-8?B?TFNmazhVZUZpTGlrb2FHNmhjMjZlQzVObHdXNTJRdU95NEorak5YR2daa2Z0?=
 =?utf-8?B?bUsyWU9NY3QvTXFnOHFYbmliQ01aLzAvU3A5WitnTVdGdTFzSjk2K0FLRUdr?=
 =?utf-8?B?RkdyVS82UzlTc01VRmtyaklkS1pnQzFaNEtRUzNLOGYrb24xdHJ0UEZ6dmRF?=
 =?utf-8?B?U1dpdVVyNzdRbWFpakc2M2dOL0ZobTdBbHd5MXF2TWQvaTE1Z2UwcGY4UkVX?=
 =?utf-8?B?elBIUUZkNW9HenhFY2tpNXFteVRuZFZSUzRXdllRTzFoYVJQeXdrR3RSREUy?=
 =?utf-8?B?YTFoelpHcGVEa2lkUmE5cyttQnB4RUt0VzRFNVYzdjBKaUg1Y2ZWenRySGZG?=
 =?utf-8?B?eEo5clZSN3NLVDhFSjN6alpqNDIrd2VWK2tVTTlVY2MyK3NmVlphTEZvRnU5?=
 =?utf-8?B?Qlh0bWNweDhpN3ZBVll5K1RlamxqeStNbzFKTXdEZTVlTC9FNTU4ZkNLcklh?=
 =?utf-8?Q?1P2RjSQFKGn4zytEvHFY9x8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A54C4B9B6692A43992940BEF673A692@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd86c4cb-73f5-453d-0224-08d9a877462d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 20:34:08.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyH95S3K3U6Wp7izKl8sWm4s9r6WmSF05URvtgrtWl8L4PKXh4yXLBYQKf8cFmnVbDoCqK1xpVQ/mbGzVqYNEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5082
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTExLTE1IGF0IDE1OjE4IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToKPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4KPiAKPiBXaGVu
IHRoZSBjbGllbnQgcmVjZWl2ZXMgRVJSX05PU1BDIG9uIHJlcGx5IHRvIENSRUFURV9TRVNTSU9O
Cj4gaXQgbGVhZHMgdG8gYSBjbGllbnQgaGFuZ2luZyBpbiBuZnNfd2FpdF9jbGllbnRfaW5pdF9j
b21wbGV0ZSgpLgo+IEluc3RlYWQsIGNvbXBsZXRlIGFuZCBmYWlsIHRoZSBjbGllbnQgaW5pdGlh
dGlvbiB3aXRoIGFuIEVJTwo+IGVycm9yIHdoaWNoIGFsbG93cyBmb3IgdGhlIG1vdW50IGNvbW1h
bmQgdG8gZmFpbCBpbnN0ZWFkIG9mCj4gaGFuZ2luZy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBPbGdh
IEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4KPiAtLS0KPiDCoGZzL25mcy9uZnM0c3Rh
dGUuYyB8IDQgKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+IAo+IGRp
ZmYgLS1naXQgYS9mcy9uZnMvbmZzNHN0YXRlLmMgYi9mcy9uZnMvbmZzNHN0YXRlLmMKPiBpbmRl
eCBlY2M0NTk0Mjk5ZDYuLjUwZmE5NjM2NjViYSAxMDA2NDQKPiAtLS0gYS9mcy9uZnMvbmZzNHN0
YXRlLmMKPiArKysgYi9mcy9uZnMvbmZzNHN0YXRlLmMKPiBAQCAtMTk5OCw2ICsxOTk4LDEwIEBA
IHN0YXRpYyBpbnQKPiBuZnM0X2hhbmRsZV9yZWNsYWltX2xlYXNlX2Vycm9yKHN0cnVjdCBuZnNf
Y2xpZW50ICpjbHAsIGludCBzdGF0dXMpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkcHJpbnRrKCIlczogZXhpdCB3aXRoIGVycm9yICVkIGZvciBzZXJ2ZXIgJXNcbiIsCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoF9fZnVuY19fLCAtRVBST1RPTk9TVVBQT1JULCBjbHAtCj4gPmNsX2hvc3RuYW1lKTsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRVBST1RPTk9TVVBQT1JUOwo+
ICvCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfTk9TUEM6CgpTaG91bGRuJ3QgdGhpcyBiZSAn
Y2FzZSAtRU5PU1BDOic/Cgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoY2xw
LT5jbF9jb25zX3N0YXRlID09IE5GU19DU19TRVNTSU9OX0lOSVRJTkcpCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnNfbWFya19jbGllbnRfcmVhZHko
Y2xwLCAtRUlPKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU87
Cj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfTk9UX1NBTUU6IC8qIEZpeE1lOiBpbXBs
ZW1lbnQgcmVjb3ZlcnkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaW4gbmZzNF9leGNoYW5nZV9pZCAqLwo+IMKgwqDC
oMKgwqDCoMKgwqBkZWZhdWx0OgoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20K
Cgo=
