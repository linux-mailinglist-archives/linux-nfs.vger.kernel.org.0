Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57C76205F
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 19:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjGYRlp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 13:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGYRlm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 13:41:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D307121
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jul 2023 10:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtzyimE14UFOQGW+cO7RrN87Ayg39ViQfkMn3RAjGaD1mwTwPNZy+yFzZaBkOFUB+PJPtvH25m8Io61qtshuleHvrduYEfkFpMKj+l3joL70rGjq7oO3UtpcsKoQeDm/UlbSfhwMj9rhJzZ1NWBaIClOuckXx/+yrZ+hvfB+0oVYQA1wozErY9Jev/5myw2GNJI8qx2dxicqLWkIkWLBwqkqt9OSbqgJlw1ZvX4ZI+nNkEMIbXohkKwLNStgM3mr3FOFi8hQhYi7anFvckQXXj36daPr5BHmi+Lo1C4bcLPwBQi6bHlzRR8bfgdBR/uKe7kz6iQ63J5ncKiuZ3N9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTFFnKoXycxOuzUEFN/ogE2Jhh9rWH7YHqq4linqDqM=;
 b=e7ALtooIx5ymPp0Hyxqv1pbiM6T3WJ0A09FpuuIMfsykg+ZZy9W97IdlUAWaZNXfQYE8MGbXBZYvMwt3HkVsptONEEH33T+N7q4LqrwPqRRRwl6Ao/+CkjybNOKQ2VB4GzPkzqHPiFxWm+97B2Wz6jFDGvWb4QjH+tOGXvcxUqJqsJCDY5wZ3JgOX9mINyO/WaFEm54aF8MD8F1M9v0RAMTcrTqxcWMJnwtELi9yNaGeLr8/xdK9jFACWfDNLLpt9bJEmCK2/2ri+6tJPwH+qOMMwcyxkLZaZJW9DWw02Z4pFEdbQMQn8fVFVfdUEjcgfcYXPXFY/GVU60nvNOL1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTFFnKoXycxOuzUEFN/ogE2Jhh9rWH7YHqq4linqDqM=;
 b=EvNlJ8lsqItpglw4icH2p5g4/3B5j3S/3IOuZrh0Pi7aSoXxShmCpJGlUIL6xB/OcP5rxv3T6RZe/WWJy3NSWy/5FELuGHFxWoishpCerGyM1tBZeEIZ2oDdyya/ARbUwxZXCPEtimWK+l1D+jv+elmDYRhsSrOpY/z6ppJVrZQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5299.namprd13.prod.outlook.com (2603:10b6:510:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 17:41:35 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 17:41:35 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFS: Fix potential oops in nfs_inode_remove_request()
Thread-Topic: [PATCH 1/1] NFS: Fix potential oops in
 nfs_inode_remove_request()
Thread-Index: AQHZvwnVRFucrcRHAEGnrsZ0TgKm16/Kl26AgAATaICAABWXgA==
Date:   Tue, 25 Jul 2023 17:41:35 +0000
Message-ID: <1a2ee0602cd169a96db29565449e2e6cc7a31912.camel@hammerspace.com>
References: <20230725150807.8770-1-smayhew@redhat.com>
         <20230725150807.8770-2-smayhew@redhat.com>
         <fcf5eee44ff2f02414d3747f2b625aecd8811a0c.camel@hammerspace.com>
         <ZL/3MZDNGqwlOgPW@aion>
In-Reply-To: <ZL/3MZDNGqwlOgPW@aion>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5299:EE_
x-ms-office365-filtering-correlation-id: d24d2b70-d2a2-46b8-c311-08db8d366429
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: agxf5fMQt4xwOgFcjxMKQK0nQpwcbr5AoOk4I4crHhRt++vfYVfIPD2SUMUAJAvofQA1lvV+IKS0Vm5g6bXLcXE/2C4xburNKecVFse6gf2lAJU+KhFPd9yFmhYjp6UEfa3dkulx5lwJFlEjRYKrPlwdBJUzsq7pfQp2e72k9HB7JksUl9daZRSHDtxtZf2yURUJklQXch3XQkGzW4tjZ+1/4TYELVTkl0+CG5bivpG4GvR8MHzMQzLEP5U6B08sn0b+z1PmE8MhqTJQpvdQPWPxGXCxsbciLYN5fNva3sBC7f2pkpQpFh7hCVtk8Bh187/PC+ysM4lTZgkf1ydX3hqLL9agZ5Okteq+bjR3V0e1bOveX8ykb5Flg+mUrLJMLstUTAiAfvW5cAFGsDN/F2M8IvuRfDQChHmBVIOszn4S9t1b2c0wgu/QAV5apqvgQqlmFN8ZOIWgl6+mSd/iWCbIXLCBLvGIfJlz68qVTP8yTGO6meO+vXPnymCJ4eWK1xx53oUWl8jPVvHnS2DccSSL7RwQiuodv8i3JupU+Ec/fVG/1XPOUSZ9u4CX3Fy2INTmuI4A7NI3/ZpOCeZ/s+IN2EBGh8v8XT/PASA2qRIG/N9gs4MiC/FhuXJv3/W8qvCm7mAVrUodrX7q02AkKfHkebuxv4izfgtElIJUqxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39850400004)(451199021)(41300700001)(6506007)(186003)(83380400001)(478600001)(26005)(71200400001)(2616005)(6512007)(38070700005)(2906002)(6486002)(86362001)(36756003)(6916009)(5660300002)(66946007)(76116006)(66446008)(122000001)(4326008)(66556008)(66476007)(64756008)(8936002)(8676002)(316002)(38100700002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmdEOXk0T1AxcjJKVEgzR1dQUS9NYmM3MWRJTVBvWUVjb1ZKS2ZHNEVuK2Jm?=
 =?utf-8?B?bXNZcDJXMWJraUIzT2ordlRDbHZsVmNZTm9ENHB3dnVVeHFIUGVFaDRaWTVm?=
 =?utf-8?B?a3Q5eTZUMHFoRmVOdCtPK0Y0b3ZQbG9IMlRxeTF1Uk1SeWVXVFQwNFlkak53?=
 =?utf-8?B?bk5lQWZXeG44NWVVT3NhVmprL3E3Q0dTN1dGRXBldS9KbkFUUXBNNHlnMlBW?=
 =?utf-8?B?Ny9SUHU1SE5nS29jTHZXRkxzV1VydkxHeDN3Rkt0SlVyTlVERHV5K3pibW1l?=
 =?utf-8?B?STc2SGlTN0kxYUMyOTBGUGhNa2tma3E1RlZDakF3WEpZajhFUWYrWlNGQTFJ?=
 =?utf-8?B?ZDVyakFqTXhZa25yVkszOUFWbm1nQk0zZTdnd0JMTVpqd2tqckxsWGhqMFc5?=
 =?utf-8?B?T3VNTzhiR1UzcXNTaDFnNTFJejJnYUIzODdUZTZtSUp0bVdiUGNFK21iQ1Vo?=
 =?utf-8?B?NFY5R2x1NStPZUxYSVpxQ0k2M2E4SzZPQUlER1F1UTBsNXVNTkRxU09lN3o2?=
 =?utf-8?B?cTdyZmFWTjlNbkhzMk5vUzNDVkE1ZjU0dUNxTlZhZDhjbTcxUnBMYUYxSVJq?=
 =?utf-8?B?TlR0VW1WQmVSSjQxTkxFNWhPd1duaFUwaXhuZW5qQ2QzbHFUSUVEa0hDOE52?=
 =?utf-8?B?TzdtbkZxSHRBbk1EWGhERnFZc25vd0MvdER2TFdndUk3c2xPYVByRk1OY2pN?=
 =?utf-8?B?SS9mNDdpRm95Nlh6YjNWcDkvVW9ZZG0wTkQwVEFDOThLbEltYlJTanNnQUM5?=
 =?utf-8?B?SERKZUdJTnk5TUN0SEpLQlNPaHNqSHZVQnFoUFZRRGpKV0dpM2NhQWplcWwx?=
 =?utf-8?B?enowK0JKdDZtOVV2bCsvOVRvc1RGTEhsUEFxTnhPK0E0bGJ6djg5REMybW5W?=
 =?utf-8?B?bUx0VUdOdVY5eGlFb0ExQVA0UDV6ZGMxdkZGc3JRN3FJWGtMak1vRitCSU1G?=
 =?utf-8?B?QzUvVFpvTXNMaW5GSFkwYWFJd0FxcjNveHBuNEI1SzM4bjN2R2JYUE9SWEVV?=
 =?utf-8?B?TFdlOVR3bzdzcm9iY3ZRdkdLU1VjdG5TejF4emZEQ1plSE1xQWlweFBlZmhJ?=
 =?utf-8?B?S1VZaVk3VmNpSmd2QUFSeTJaU2RzNGNaakx0M3BWRVlpZEsxemUvaDhXeW5m?=
 =?utf-8?B?NDZ0YVVtczB3ckpWREVYWFR5SDNDdFBEY1BGV3JMQi9RQUdsK2owaGdydndl?=
 =?utf-8?B?dUxJMEVsbXVmdk51bDhyTnBzY0dVZzRIUkt6QkNrbjRCQXpIaHhaVmtFdGRU?=
 =?utf-8?B?dmt6MGF5N0hYbHJiRm1NTm5idFZKMG5UdFY3d1dsQzRqL3Zvb0RBblU4L3B2?=
 =?utf-8?B?U1JpVmE1dEYxMURxZUxXQzlXYkIwaUNKdXI1Rjhmd2JHMk9XUnZTWE55NUk0?=
 =?utf-8?B?eEtEV1g2UkZNWExwV0JJU3lLVDlRay9IL1N4d2J0TVdCYkhaWEtRTjM5d3Fi?=
 =?utf-8?B?Y0dKQTA3V1k2ZmdDdmRiMG1hcVFMbnJuUGZZZmNQMzlYbGJ5bFFpTHpwODF2?=
 =?utf-8?B?ems3cTdrV2NlS3ZVdnprbHB2T3NsUU54bmNqcmk2VTFqU3pwY1hIWS9GUGdk?=
 =?utf-8?B?TkNIc2dvWFJZN2Y4UHM5VE1ETUttenZUWStkZENtQW5NS0xnTGIrdkVDUGNC?=
 =?utf-8?B?eGU4UlFHcXUxU21OczhUUk1XL3pyWis4VTZLSkY5Q1BGZm5JZDJROE5BMFBF?=
 =?utf-8?B?cGJUQ2E2NkdsS3Vndi83cmY0c0FuSkU1YUVJSThwdWowSHJFTkxPS25seG5P?=
 =?utf-8?B?cTZqQ0xUWFhDcGoyVHptcnlVcFVjUWYrcDFDNWZSUVJBWWJFWEh0R29Wencw?=
 =?utf-8?B?VVhZSStNaWZkQkNNcTVHM0QyRlVkNHEwQ1NPOHV3WHE0UCtua1I5ZGQ2NFh3?=
 =?utf-8?B?eittb1E0NkpBZitrdmhmRDVJRVFKbGtnNzBRVnlHZ1ArUVlEeldweTB1RnEy?=
 =?utf-8?B?aFo2SEZ3VnQ1bzVoelBQajhGaDI4UW5PRDJCRC9ZZDViUGNYQzJ1dkdNaDMy?=
 =?utf-8?B?N0pROEd6SCtBckJYMnRDaDN5SVhSYmZvQVNsbUJVbDZYVE44MWhTTmR4ZXBq?=
 =?utf-8?B?djhrNTZjSVN6aXNBRVBTdTk3aFRYUUMvclhJQ1RscSs5T3pvekxjNzRqa1I0?=
 =?utf-8?B?VjJtRTV2KzJoSnpFSEt4aE0wVmpHeW5sUyt5ZXlaZ0wzZHh1LzZGWkpweEF5?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A457EC82C4369E43A43E3B1424699512@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24d2b70-d2a2-46b8-c311-08db8d366429
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 17:41:35.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvT+TUfEjoi6qDqu1/jvttil4Q3xi3Rsq/IwwORi4U/YRv5HxB7QKaPXuL+2Do3BgVoFjh28D3ilS+GyztFZDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTI1IGF0IDEyOjI0IC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+
IE9uIFR1ZSwgMjUgSnVsIDIwMjMsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+ID4gT24g
VHVlLCAyMDIzLTA3LTI1IGF0IDExOjA4IC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+ID4g
PiBPbmNlIGEgZm9saW8ncyBwcml2YXRlIGRhdGEgaGFzIGJlZW4gY2xlYXJlZCwgaXQncyBwb3Nz
aWJsZSBmb3INCj4gPiA+IGFub3RoZXINCj4gPiA+IHByb2Nlc3MgdG8gY2xlYXIgdGhlIGZvbGlv
LT5tYXBwaW5nIChlLmcuIHZpYQ0KPiA+ID4gaW52YWxpZGF0ZV9jb21wbGV0ZV9mb2xpbzINCj4g
PiA+IG9yIGV2aWN0X21hcHBpbmdfZm9saW8pLCBzbyBpdCB3b3VsZG4ndCBiZSBzYWZlIHRvIGNh
bGwNCj4gPiA+IG5mc19wYWdlX3RvX2lub2RlKCkgYWZ0ZXIgdGhhdC4NCj4gPiA+IA0KPiA+ID4g
Rml4ZXM6IDBjNDkzYjVjZjE2ZSAoIk5GUzogQ29udmVydCBidWZmZXJlZCB3cml0ZXMgdG8gdXNl
DQo+ID4gPiBmb2xpb3MiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2NvdHQgTWF5aGV3IDxzbWF5
aGV3QHJlZGhhdC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IMKgZnMvbmZzL3dyaXRlLmMgfCA0ICsr
Ky0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3dyaXRlLmMgYi9mcy9uZnMvd3Jp
dGUuYw0KPiA+ID4gaW5kZXggZjRjY2E4ZjAwYzBjLi40ODljM2Y5ZGFlMjMgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9mcy9uZnMvd3JpdGUuYw0KPiA+ID4gKysrIGIvZnMvbmZzL3dyaXRlLmMNCj4gPiA+
IEBAIC03ODUsNiArNzg1LDggQEAgc3RhdGljIHZvaWQgbmZzX2lub2RlX2FkZF9yZXF1ZXN0KHN0
cnVjdA0KPiA+ID4gbmZzX3BhZ2UNCj4gPiA+ICpyZXEpDQo+ID4gPiDCoCAqLw0KPiA+ID4gwqBz
dGF0aWMgdm9pZCBuZnNfaW5vZGVfcmVtb3ZlX3JlcXVlc3Qoc3RydWN0IG5mc19wYWdlICpyZXEp
DQo+ID4gPiDCoHsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnNfaW5vZGUgKm5mc2kg
PSBORlNfSShuZnNfcGFnZV90b19pbm9kZShyZXEpKTsNCj4gPiA+ICsNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqBpZiAobmZzX3BhZ2VfZ3JvdXBfc3luY19vbl9iaXQocmVxLCBQR19SRU1PVkUpKSB7
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBmb2xpbyAqZm9s
aW8gPSBuZnNfcGFnZV90b19mb2xpbyhyZXEtDQo+ID4gPiA+IHdiX2hlYWQpOw0KPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGlu
ZyA9DQo+ID4gPiBmb2xpb19maWxlX21hcHBpbmcoZm9saW8pOw0KPiA+ID4gQEAgLTgwMCw3ICs4
MDIsNyBAQCBzdGF0aWMgdm9pZCBuZnNfaW5vZGVfcmVtb3ZlX3JlcXVlc3Qoc3RydWN0DQo+ID4g
PiBuZnNfcGFnZSAqcmVxKQ0KPiA+ID4gwqANCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAodGVz
dF9hbmRfY2xlYXJfYml0KFBHX0lOT0RFX1JFRiwgJnJlcS0+d2JfZmxhZ3MpKSB7DQo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mc19yZWxlYXNlX3JlcXVlc3QocmVxKTsN
Cj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhdG9taWNfbG9uZ19kZWMoJk5G
U19JKG5mc19wYWdlX3RvX2lub2RlKHJlcSkpLQ0KPiA+ID4gPiBucmVxdWVzdHMpOw0KPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGF0b21pY19sb25nX2RlYygmbmZzaS0+bnJl
cXVlc3RzKTsNCj4gPiANCj4gPiBXaHkgbm90IGp1c3QgaW52ZXJ0IHRoZSBvcmRlciBvZiB0aGUg
YXRvbWljX2xvbmdfZGVjKCkgYW5kIHRoZQ0KPiA+IG5mc19yZWxlYXNlX3JlcXVlc3QoKT8gVGhh
dCB3YXkgeW91IGFyZSBhbHNvIGVuc3VyaW5nIHRoYXQgdGhlDQo+ID4gaW5vZGUgaXMNCj4gPiBz
dGlsbCBwaW5uZWQgaW4gbWVtb3J5IGJ5IHRoZSBvcGVuIGNvbnRleHQuDQo+IA0KPiBJJ20gbm90
IGZvbGxvd2luZy7CoCBIb3cgZG9lcyBpbnZlcnRpbmcgdGhlIG9yZGVyIHByZXZlbnQgdGhlDQo+
IGZvbGlvLT5tYXBwaW5nIGZyb20gZ2V0dGluZyBjbG9iYmVyZWQ/DQo+IA0KDQpUaGUgb3Blbi9s
b2NrIGNvbnRleHQgaXMgcmVmY291bnRlZCBieSB0aGUgbmZzX3BhZ2UgdW50aWwgdGhlIGxhdHRl
ciBpcw0KcmVsZWFzZWQuIFRoYXQncyB3aHkgdGhlIGlub2RlIGlzIGd1YXJhbnRlZWQgdG8gcmVt
YWluIGFyb3VuZCBhdCBsZWFzdA0KdW50aWwgdGhlICBjYWxsIHRvIG5mc19yZWxlYXNlX3JlcXVl
c3QoKS4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
