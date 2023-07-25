Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41E761D15
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 17:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjGYPO4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjGYPOz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 11:14:55 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2112.outbound.protection.outlook.com [40.107.102.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3889D19A2
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jul 2023 08:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvIpJs2ZLiH0Vjx+FhAmCKCpvP4gq/+nKocnKyBqif47xNWZHqApCszM8LqCFntTR3cICgeLG9N9dEYhpVZY0h8T+/AaYaWOgkl0embfd/7X6MhVnnrYKZUar9YG4080f0r1xXtsl18P63PziSltHISh7Cqe+iVTiDXn4D7flRgNz2xaP21oz0aj+aoEQV3Z66hDRvXsZLTlywoibJxn/41O+sQ6A9+Da/7Oxzrs+njg5gOygyJoojRx4VbSayK4kMNRQhUESQq2aLw4O6A2jfHMQT9q7QMZKtBhZWrVbB49HcYy46PQYvTpJiUedXwhKPUmGllIzf6ESiGdSExQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ6uPQBqLc42FixOY2d7QqLkxu7B1C4F89BlEwsVJOo=;
 b=Fx9DcnKIagDJf8uHLbzgLE5b83LoWvceAY5/I2IFV5/2GfE4LMJVQc/mA0XTFGiKYTV/GiOVFKWYWDOirV7b3/N05y4/+8vSufrGS49sgq9BOgFFh+eksLcoA3SwzeXvlWrohJUGtXc98wX9PruJ+3wInTtp13ZcO/3R5hQhj73qDTilso58iHvU9r9tiixi9iX7IqH/qKhJX9Q0k7OPOqChK0EXmHLcyM4NpMAl9jBv2X2StVnc2vj0sNWD6npvOKfH7sxc8l/XJW/qgECsNAzocYHoGjhEB3J+uGOZK/prD9hrID6sqhnrU3MD8LHXzzmF083ngoEVlcXKJ2aXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ6uPQBqLc42FixOY2d7QqLkxu7B1C4F89BlEwsVJOo=;
 b=LiE042Miz0Lgm5joY2L1NXdTzWR3MhVcTYch53W+Nor+YpDKnhR9BkZ2emfHaIJgSzN9RbBWu9wBwGIn26qOUKvtQRHciYNt92q/8RKMXcSXIPEeW1FyKVPCtE6HIYFHyhGsBthMmgF4YqvETm5adiM+OVfGc1XYe2eoJ7rja0I=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW4PR13MB5505.namprd13.prod.outlook.com (2603:10b6:303:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Tue, 25 Jul
 2023 15:14:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:14:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFS: Fix potential oops in nfs_inode_remove_request()
Thread-Topic: [PATCH 1/1] NFS: Fix potential oops in
 nfs_inode_remove_request()
Thread-Index: AQHZvwnVRFucrcRHAEGnrsZ0TgKm16/Kl26A
Date:   Tue, 25 Jul 2023 15:14:51 +0000
Message-ID: <fcf5eee44ff2f02414d3747f2b625aecd8811a0c.camel@hammerspace.com>
References: <20230725150807.8770-1-smayhew@redhat.com>
         <20230725150807.8770-2-smayhew@redhat.com>
In-Reply-To: <20230725150807.8770-2-smayhew@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW4PR13MB5505:EE_
x-ms-office365-filtering-correlation-id: e0166c5d-2e14-4051-8e26-08db8d21e49a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/55BIHAJipDtnyIyv6bb/A2l1PZgeKCYJospPDdix7bHZfJS/k8aRLRErg+wPO9pA98nRiPiOnutuoUo1+4VZnSb0E1hCXVPWLBwORnScE8TfKYD7AGrhFplj4lN9arDh/Xehd0VdYLhxNaqeIGxWaPeKj347w/H6bdvuzIUuL7H4gfa0txoZa75bsDmxdfBe9ZOPmdpRUNq2FHD7y5xfHFS4n5WD5ImSPH7CKL7xM3hWFNhe+2xqopmkrmVdE/S5zXMXYA85YG1hwGvMqXbgS7F7+R4Q9UHDvOqGjl/oDB1Hynnp8wdgM3+bwd1jiO7zr01D+PmtZLXb8qp2z+KBuS995RqbNtafLWoycDBcnXb1/NzEkgSyMNM6ZxhYSo4qD6pGlPCbNy+XQTbz1B3fMCvhY00+Cgbl12615yUMFQfmqKSR/fSLvZ33YCa9mRI0LxFOdLYzda8FsojT1ElqRQruaYWACasIre2+jmqmOMVMUw7KfcJHucpbMccBdXjlLlcwstOCE+LMy0XvIFY5EUW7PSLk7eW7i9+BjjK9RDHcD7+P8GXJpoAHV9WRV7vfUrnlcSrTLIm4SHXxS4TiQE23uB+gkTqhQMepO2eXUMM6ZZwT+eBxEhG5cjR82kz3XizT6qWyiWn3YHUwrpHQpE3HYMsiRbiBidFrYQrWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39850400004)(376002)(366004)(136003)(451199021)(122000001)(38100700002)(38070700005)(36756003)(86362001)(6486002)(6512007)(71200400001)(478600001)(2906002)(26005)(186003)(5660300002)(6506007)(8676002)(316002)(76116006)(8936002)(41300700001)(110136005)(66946007)(66476007)(64756008)(66556008)(66446008)(4326008)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azFyYTQ5NXJWUkJ0eVMxSTdOZzcxV09leXJGOEZzYzh2LzBxQXFXajFEdUc1?=
 =?utf-8?B?MG9NYXFLQWxvQjhHSkw4a1BGRlZVZXNzZk9EV0dNZ0RhZFRUaC9zSFZiTUZG?=
 =?utf-8?B?U3Y5blZlZms5bThjN0c2RXFKeVJFK3c4L0dUZWQrbUIzM2FETHkrZU5lU1RR?=
 =?utf-8?B?SFlZRHJEcmxtOE96bWRSUzR4UEdZOUxwNDdkQWZ0dUY1RE5kSTRjU0N6ODQr?=
 =?utf-8?B?SFRiTTFMd2IvWitEd3h2Q0x5WENxVnUxYWNINGZDWkR3NmlQWUhZQVRDVWQw?=
 =?utf-8?B?OTI3NFU5SUduUTlaMVFEZWdWa1krNXpYZXNxNUhQaFpxcHh1UzA2WkVBUng4?=
 =?utf-8?B?UFd2Zm1naW1RbjZNNHBFWjJEL0xPQmFaV2MrZGhjS2ZiVU44WGowMU1qUEJq?=
 =?utf-8?B?engwNE1rQ29XcTBIQ0drcXRkN0xmd1FPeDEyN29ZRDBWS2tEOG5vcEJ3cFhj?=
 =?utf-8?B?M3UyWVdicXgyNVBFRE8vaERsZllJQXhSMzVQQXROcExGc0ZLMFd5TjBIUlNR?=
 =?utf-8?B?NTdvRS9TdkRXVzBKYnE0SDZ0U2MyQzhkc1ZLNVRUZlMvT3Zkc1VaVUxtYUJj?=
 =?utf-8?B?cTlOaFBLbEVmZ094SzYyc0dUbERKdzRiZktkOFJYeWpWeHhkcEFuL3BNdlRJ?=
 =?utf-8?B?TUYxMmVsck1sZmlTRWlwZlNTYjd0akdqYTRKYnNuTGFpVmUwQ2ZUaHp6a28v?=
 =?utf-8?B?bmZsMkJMaFFiZHRTK2NyVXVpV2hHUHBFdmllV1RsYmZadlNKQWlFbVBKT0Mz?=
 =?utf-8?B?Um1NVGFRWnBkRXZqWWdmOW8xMENXMmpqU3JJcTFIRWV0YXNoUE0zNmdGTk1R?=
 =?utf-8?B?dUI5VEU5RFVHS3gvZElYRUdpVmVYSlVRTjc5czlEdVBIaW5jaW12bDNQZkJW?=
 =?utf-8?B?cUJjdnltb3JqOXJEOFFaM2VqNy83RHRTZFJ5OVA0eGh6YnJESEhDUFIyTEQ5?=
 =?utf-8?B?OVdYWWRCbnVLTGhMSGhlRUFpK0VYdW53QWFqK0ZPcnNMaW1tZytaNEcwaHNi?=
 =?utf-8?B?L3M1ZEpmeG5wRVZuS0pScVo0U1Q2K3VENjdaNnVFMFpFT3ZqUlVuMUZBU2kx?=
 =?utf-8?B?YVg5djZiZE5EQnkycnpHdnhnZTVxU3JwQUNMZVpCVUc1QU1SSk9ta2xCTGZq?=
 =?utf-8?B?TmRDWUdzbzhyQ2F5YkdHQW45Zms4cXNvd3lzSmVLMHAxaUduZHZkUDE0d1FR?=
 =?utf-8?B?VmRrYVRXZzVKUzFwNHpKZS9iUlphTUhBb08rK2lqQzBabTV5NjM0TEpReUty?=
 =?utf-8?B?SnI2RW94d2NZNTZld0hRRlpYMlpjM2VDRk93N1ZYcklLdStDdzBxbEZYMzFJ?=
 =?utf-8?B?RFdNNHdSMGFMYzJWKzc3NmxnL05NYXVtcVROK3lGY2d1b0c3Z3VkM0lXZEVn?=
 =?utf-8?B?dTd4ajZLaDlpU3ZqRk9VdytWQ3hDcGpvdG9pOW11UHJtT0o0a08raEdpWHhS?=
 =?utf-8?B?Mjh4ZlA2RGJCaCtaUlRWdVRPS3U5elpHUnNmVDdKVm1TZ2pVRU9tdndjTURm?=
 =?utf-8?B?M2JVV3ZQRFVGcG51Tk5PRWhZZ1dkMjhLUi82REZXNjMwa2NSWERISEMzOFZR?=
 =?utf-8?B?aG5PMzFBenVDVk83djV6eGdsZHRFQVJ6QTJ3Q01lY1dCRW9UTEYrSXVabGV2?=
 =?utf-8?B?STh4N3V1TWFsL3RxOSt5NExHL245T2w5a1RuN2NXTW82WmltSEtFci8xczkw?=
 =?utf-8?B?amU4WXJmOVdhdytPeU5zSTdPSDdidjVrMTNrMXBJQnVEU3I3WFp1Y0psV2hE?=
 =?utf-8?B?MnhFejYvNG5qQk5sVlQ5T0crTytVb2kwRURjMWN3RllvTFZkaTF6aDIxTjRU?=
 =?utf-8?B?dzJ4dGtlUVEvdkUxTkhmUmRzQ2tjUmh4bWpRcDBpZUtES2dhci9RK0lPZ2F0?=
 =?utf-8?B?ZDBHeDhMZFJ4RERFYlFtU3hMZ1J5WkdSZXFxLzhGb1pCZmJuTkxOdmZPQlFp?=
 =?utf-8?B?ZHhDWVlWamVXZVBMSnJsWmliRzR2V043N2tzbzIraUNTQXZOTkp2NkRmRWR0?=
 =?utf-8?B?L09vSjRkcmorczArRVl5S0tCY2xLdFlBazRsZ2ZzdFU0OEw5OVMvOXFEWHo0?=
 =?utf-8?B?QXZTOTUvcnZQZTIwOTgvNVZQT0N4ai8wL09KSlVmSDNEbjgvczZqQVVkTDdQ?=
 =?utf-8?B?akU0WnlaaTl5aUVDMjdqUkhFd3p0c2NSSWVzaTFpZk9CSEVBTnRRWGJFSWR5?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC584384A0F10A419DD0D534F25949FE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0166c5d-2e14-4051-8e26-08db8d21e49a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 15:14:51.1728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fblLhH5TNzjaf0JTkkiEnkZCLXzs6scJxiAFe94LlgcPkghwrPCncXqYT8hl90NSruZuiO0tsIhsOEKxg0UXvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTI1IGF0IDExOjA4IC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+
IE9uY2UgYSBmb2xpbydzIHByaXZhdGUgZGF0YSBoYXMgYmVlbiBjbGVhcmVkLCBpdCdzIHBvc3Np
YmxlIGZvcg0KPiBhbm90aGVyDQo+IHByb2Nlc3MgdG8gY2xlYXIgdGhlIGZvbGlvLT5tYXBwaW5n
IChlLmcuIHZpYQ0KPiBpbnZhbGlkYXRlX2NvbXBsZXRlX2ZvbGlvMg0KPiBvciBldmljdF9tYXBw
aW5nX2ZvbGlvKSwgc28gaXQgd291bGRuJ3QgYmUgc2FmZSB0byBjYWxsDQo+IG5mc19wYWdlX3Rv
X2lub2RlKCkgYWZ0ZXIgdGhhdC4NCj4gDQo+IEZpeGVzOiAwYzQ5M2I1Y2YxNmUgKCJORlM6IENv
bnZlcnQgYnVmZmVyZWQgd3JpdGVzIHRvIHVzZSBmb2xpb3MiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBT
Y290dCBNYXloZXcgPHNtYXloZXdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IMKgZnMvbmZzL3dyaXRl
LmMgfCA0ICsrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3dyaXRlLmMgYi9mcy9uZnMvd3JpdGUu
Yw0KPiBpbmRleCBmNGNjYThmMDBjMGMuLjQ4OWMzZjlkYWUyMyAxMDA2NDQNCj4gLS0tIGEvZnMv
bmZzL3dyaXRlLmMNCj4gKysrIGIvZnMvbmZzL3dyaXRlLmMNCj4gQEAgLTc4NSw2ICs3ODUsOCBA
QCBzdGF0aWMgdm9pZCBuZnNfaW5vZGVfYWRkX3JlcXVlc3Qoc3RydWN0IG5mc19wYWdlDQo+ICpy
ZXEpDQo+IMKgICovDQo+IMKgc3RhdGljIHZvaWQgbmZzX2lub2RlX3JlbW92ZV9yZXF1ZXN0KHN0
cnVjdCBuZnNfcGFnZSAqcmVxKQ0KPiDCoHsNCj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG5mc19p
bm9kZSAqbmZzaSA9IE5GU19JKG5mc19wYWdlX3RvX2lub2RlKHJlcSkpOw0KPiArDQo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAobmZzX3BhZ2VfZ3JvdXBfc3luY19vbl9iaXQocmVxLCBQR19SRU1PVkUp
KSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGZvbGlvICpmb2xp
byA9IG5mc19wYWdlX3RvX2ZvbGlvKHJlcS0NCj4gPndiX2hlYWQpOw0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0NCj4gZm9s
aW9fZmlsZV9tYXBwaW5nKGZvbGlvKTsNCj4gQEAgLTgwMCw3ICs4MDIsNyBAQCBzdGF0aWMgdm9p
ZCBuZnNfaW5vZGVfcmVtb3ZlX3JlcXVlc3Qoc3RydWN0DQo+IG5mc19wYWdlICpyZXEpDQo+IMKg
DQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAodGVzdF9hbmRfY2xlYXJfYml0KFBHX0lOT0RFX1JFRiwg
JnJlcS0+d2JfZmxhZ3MpKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmZz
X3JlbGVhc2VfcmVxdWVzdChyZXEpOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
YXRvbWljX2xvbmdfZGVjKCZORlNfSShuZnNfcGFnZV90b19pbm9kZShyZXEpKS0NCj4gPm5yZXF1
ZXN0cyk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhdG9taWNfbG9uZ19kZWMo
Jm5mc2ktPm5yZXF1ZXN0cyk7DQoNCldoeSBub3QganVzdCBpbnZlcnQgdGhlIG9yZGVyIG9mIHRo
ZSBhdG9taWNfbG9uZ19kZWMoKSBhbmQgdGhlDQpuZnNfcmVsZWFzZV9yZXF1ZXN0KCk/IFRoYXQg
d2F5IHlvdSBhcmUgYWxzbyBlbnN1cmluZyB0aGF0IHRoZSBpbm9kZSBpcw0Kc3RpbGwgcGlubmVk
IGluIG1lbW9yeSBieSB0aGUgb3BlbiBjb250ZXh0Lg0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDC
oH0NCj4gwqANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
