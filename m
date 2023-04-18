Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFE26E68DD
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjDRQCr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjDRQCh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 12:02:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2091.outbound.protection.outlook.com [40.107.223.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256C13C1D
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 09:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L85PjDIrI6HQCts7G6eM96PLP3DQdzHaaRTJd6tQ/zJxOEMAyuXC1RADIjuk+pmYbVLabBVBcLpSEtBrlyQ/kIXOE10CqD+7fK4sn1FWSSrj8iPLW/HVi65Ui//EFRz1TAo7tFt/ZLVnpWUijQFPSu94ueW6iattcMJ8QYhJih06e9ovxpvYNvM3vobQeubgrFXwuric7SIzyhY3MzqVgOpXgmr0CoYzG2fSTlqwVvqPfeD22RqnE8Di/VQwGhCiEL75+e/1whsaj/hUlxLssp0sOf1C9SKUjncyzQ+vR4PeqLAWoBLepjHd/TvPx4V9xJF9D8WOcBeO1U6FcDQ/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ew7NkKEhzo7QPkt9c/k/2fwPL5XIHMkPpIy/zig2ek=;
 b=Knn41hDLZKdifYs7zKCH4+XkUggAoKr3+ZUPrSg5vJjz8NsKufHqi0Ex4Zs9698X8nF4Wj8DHEIAV+I3fr4PQ+bkB07R7LFNUkOn4Wi9crNU2tcpCE3WCoYafAtJ0ht/SbhYD1uOko0DGW26PK8iMQFRsV26HNBk2Ldf/Goh29/TDifEZ6d23Spsri1Rz6M98Ig4d8JkavxGWWygm0v5luk8tFQw7UU8kguok6a2iGFqLAoV1UVJHkJXVD2pWFeDuu9XfZuSqWWFRrX3K2uTPy4xNbMONBo3Za+SS0UmOE2s7PUl70MuKwRpInxfOF5/7PSSTi0gNzdVUkv0H3anHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ew7NkKEhzo7QPkt9c/k/2fwPL5XIHMkPpIy/zig2ek=;
 b=f5xYHSHsfBkq73OvwdU3FJrw2mIOvurKpoLyIdYTb7LiZh2M8/lPcl4kXfSJb+U9PAq+9eIA+uiqPsCS+Se4k8Wk463mj6ZGfE08MeHBuDlnEMNEG7s6g7Jtd9aVh/agqUY/rrkTVki0IXeJUdiPtmH6nGMfBoVt+8N2P3cUp/U=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO1PR13MB4982.namprd13.prod.outlook.com (2603:10b6:303:da::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 16:02:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 16:02:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Topic: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Index: AQHZacp/6QlIRljOckmeDtcvLmj9Dq8wCLWAgAAOegCAAAHKAIAAARIAgAAAdQCAABaNgIAAEzmAgAALuQCAAPrGgA==
Date:   Tue, 18 Apr 2023 16:02:31 +0000
Message-ID: <d0f7600702ba073aad1056fbf93306adccf2ae9c.camel@hammerspace.com>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
         <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
         <C7FE1DB9-576A-4463-81BF-E7B1EC266E4F@oracle.com>
         <8723e01c577e257c399e8d3b6e20bca6320964c3.camel@hammerspace.com>
         <19bf7b21-fc68-5281-e587-b7d290899456@oracle.com>
         <d0a5cf8b8c8dbdbf83658b9456afb798af5d7941.camel@hammerspace.com>
         <00fe5d5a-43b8-0f0e-2afe-ae68367f822d@oracle.com>
         <d16f1877626966d854db8c5f82cc37e5b665c5af.camel@hammerspace.com>
         <ce2dbad5-cbbf-4173-0eb2-5113227837b5@oracle.com>
In-Reply-To: <ce2dbad5-cbbf-4173-0eb2-5113227837b5@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO1PR13MB4982:EE_
x-ms-office365-filtering-correlation-id: 05f28a02-75ce-4c09-fd92-08db402650e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TNN2FFXPNm7lrTPIB2JskoMT1G9jPVuKigbW+R5lmrpKsRUNTgdataq1Fa0dy3Rivg4S3nJY4B8FSIQHjnoyCbrl/zr5kp+BxHEX+IKd13epX2RV/90fxFKYrQ7D+NhkbxLJnfL1zoO9ODy2lR0NyyG+hRubBrvU+SFTJgDdfLPZ1lNk5gcv/PKm1gv3m0x+Tvys7Q+oeIPYzt/Sji5nEtreAwRsQ4sYUBpJOzrEO5CGGOl3T7LgKVLo+i3RB1f5rJqk8xPJ8v/G6DZOBfWJKUdJD5JPA/XQ+mYe/qQfZktdYafOym4+Eao6E3QiV8u2iKJ+OrI0ZZ9LV7cmAKlx3fWKdFx85F0pfiU1Lys0B6a6wXxZlzyzS+P9D+hYLNdS7k22HBLuPChua0CSlEKdcvfXYQHSOuciE7OX66SZFYU4E+X8qCz0oed+Cg5i4mLS9x4V6eRj5F1h89zAt8i6w4ahxX/BXwC0RGksudzzcxHMoJ1jwaLNXpxT/b/3TmicOEm3jMD3OJ4GG2QaLF/aFjclgD8ZkOy6NMiG6Huncl/a7p6n7VUGT+F+0LDr7URuggYi3frqpqEGbcS0CkY4DIuK8p6eX/A0RUvvNhDxjnheqpWBeWpVZ22n1YWdDqaQGcq7TdC72qUN77bUID4anXEgnIn3jjdKULz8KvX3mpI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39840400004)(396003)(376002)(136003)(366004)(451199021)(36756003)(38070700005)(2906002)(5660300002)(8936002)(8676002)(41300700001)(122000001)(86362001)(38100700002)(478600001)(110136005)(2616005)(26005)(6506007)(53546011)(6512007)(54906003)(186003)(71200400001)(6486002)(4326008)(64756008)(66476007)(66556008)(66946007)(76116006)(66446008)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUtKbUlZNGdrVjJiUjd3Z0ZkbnVHMCtzUkljczVFeHJ0ZHdKZkpBVitWbHo4?=
 =?utf-8?B?eUY4emRoWkljTEhtem5GeFFZeFVyZ3J5REdYRkRsdytDRmhGdkh3aFZteUJp?=
 =?utf-8?B?WENXK0ZNT1ZkYzhxSitERVEwaWlsUW5YNHdqL0QvZE4zV3FnNWhlenhCc1dF?=
 =?utf-8?B?Zk5jUjljbkc3bXFuUkJQTFFhelpoNU54TFFsNWYvSndwM3I3cStadDJML1I0?=
 =?utf-8?B?S0hZT1JFRndrdmExOXRFWjdwRS9ya1JXd0dsZlB2TDRqekZmeDJXZHliSExk?=
 =?utf-8?B?Z2NCQ1B0VWJaMTZud3JXZ0VwNDNEN1k5eU5DSVRUSEZVSllDYVpBMVFEVmpC?=
 =?utf-8?B?TmJlV04xYzZnOVNkVnZRSlZUc2xCcWdBTWVza1Nkb0szejB4MGM2MSttVHFn?=
 =?utf-8?B?a2tBZFlGWlBnVTVUMXZQSVJsNWdZbDhlU0djWTJScURCMkJQSCtTMTBxK0lr?=
 =?utf-8?B?Yk93U2hFR3NKdDlDUWdPQ3J4UGlPcDhpUDdGRTBqRjlVMndsVnl1NGhmSU5S?=
 =?utf-8?B?L1BUQm5OVTRQcUhHYWp4SWEwK0VtNXd6cDlZZ3hha0I3SDZFSldOQWpVei85?=
 =?utf-8?B?RUFRMEdQcHozSkNQUWhPSmNuWmVWTmRYN1Y3c1dZVGYwb0ZHcSswUFoxdDlZ?=
 =?utf-8?B?aGlOMGU0WGdCQjlIRXpPcWV0SzlZTERYZkZPSS9ZSHpKb3FWTHMxS3NLY0d0?=
 =?utf-8?B?TVFJZUVNWUhRV2ozRGNObEVvQS9zak0rdWV5SE9sTE5zcnJUWHlYcHQ4RkU2?=
 =?utf-8?B?cElBZWdpWE5oNFB1Mmp6UU5jRHhMSXZXZitGZkZyekRYU3paTGwzWkpITits?=
 =?utf-8?B?b2h3NERmYlFLVFQxQS9Fc3JGeS9BRG9FaUV0L0t4Y3RmMHBtQWgxRkphZTVa?=
 =?utf-8?B?Q3hMczJnd05lSjRWczA0TEg3aCtXdXMwSy9YdXRXTktOK25GcjU5dVRtdEVC?=
 =?utf-8?B?b084U2M1RHAvRkd0aENhaUcvSDVscEd1QkNyMWFjM3oxWEtyTnNKQmF0MHRD?=
 =?utf-8?B?M0p4a2dTMW82ekY2ZTNWWU1YbkRSQS9ONEFVOGxGRnFhRkJLNnFrUVdDMHl5?=
 =?utf-8?B?cFhOcmhxSEdzUzB5V3dJcVpybU03TGpvMGIva0h5VkJFM2Z4Y2tzTHFrMCts?=
 =?utf-8?B?Q2pkQ0J4NDg4b050dVBnckZheVNUYVJLVUpBYXpNNitDQ2M0elVoaS82SGEy?=
 =?utf-8?B?ZnNKNzl3dkk3NklFMGR0THJIZ2RzOFNvTzJ4Q1F0Y05xKysxeE11dWEvZTNq?=
 =?utf-8?B?VVhhNENYeUVmSVJTUFNQcHBST2kxbEo0eXlDRlZoM2V1L0lZdEFlbnpqRGZj?=
 =?utf-8?B?VGxaM1ZleHU5OHdDTkJrZDZmOFdib0Z3dTY1Nk5pV2F4MlNnS2xpRk5Kek1m?=
 =?utf-8?B?d0Q3YkdRL0w2TGJtQ0xNTGRuSWkrOUlmU3QwWkpTalcrVFk3c3dCNzRYSEVu?=
 =?utf-8?B?R0ZCRjVSajVQSmVVVVZ3Y29aNnh6dVJjRjc3V0wxci9hMnYrVWNPeSs1Nnow?=
 =?utf-8?B?ZFpmN3IzZFpIR0tHem1uelBtTlI1SjNuUjhla3BIZVIrNmtrdkxLdFdtQ1Br?=
 =?utf-8?B?MFhsdE4rVGliK2NxcGFsRE5rSkdUWlZ5cU9EZUFLSTRIeFR5MDJ5Z3ZOVWdm?=
 =?utf-8?B?b2tPK0s5RFlBRm5wN3NmTEx3M0ZwK1cwb0FHdXRsNEFOVG1EckpzZ29jcFJh?=
 =?utf-8?B?VzJnSGpOV2JXRVRtN2JSMVkwdllpWUloRUdKWmFleDZYMzFNUmpPaFdpSFph?=
 =?utf-8?B?YnlONVEwTzhlTG02UHRVdGNnYlYzb2JEcjJuczBEaElURVNscGRoMDBUdWVn?=
 =?utf-8?B?L1JiMjJyUVlQL3NlK2JtbFB0ZXdxUE40R0EzQ2JRaCtxa3hLSm5kcWdGUEF4?=
 =?utf-8?B?VjRyTTZwV1hyMU9FL2RGczJuL0FBNlF3andpRUdWckVPeUc1TlQ2WFBZSVc3?=
 =?utf-8?B?dmpOTkp4cXJsaEJGOE96czF6b2M5dVJ3YWhnWGtkZGVVRTZ0b0JnNGNxMVp5?=
 =?utf-8?B?ZzhkRWdhZVhvOTJQTW5LVUhFdHNkRlNWVHF5RHY4UXZVcEZqZFI0Umc4NWdD?=
 =?utf-8?B?dzVtL2ZCUXpja0NZTzFJK3poZWdOMXJ5dUlPMzJibWoybVdmMUpUUkN0b1Zp?=
 =?utf-8?B?VXA0Y2xvbk5scXMxWGJmZEM1V2tBSS9YN2o5WHI4VGdPcndkVDFKMlVFZ25t?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73640011A9B78C418CA19F6A9A9CEBD9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f28a02-75ce-4c09-fd92-08db402650e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 16:02:31.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InvtfNnZzb1mfl6T5Z7zXW907IACgOGRASfKGmfiQbXzoNO0IXlEdMHb44hZfRob1fuBkUMY1+qeC1vohGYRjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTE3IGF0IDE4OjA0IC0wNzAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3Jv
dGU6DQo+IA0KPiBPbiA0LzE3LzIzIDU6MjMgUE0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4g
PiB0YXNrLT50a19yZWJpbmRfcmV0cnkgaXMgX29ubHlfIGNoYW5nZWQgaWYgdGhlIHJwY2JpbmQg
c2VydmVyIGlzIHVwDQo+ID4gYW5kDQo+ID4gcnVubmluZywgYW5kIHJldHVybnMgYW4gZW1wdHkg
cmVwbHkgYmVjYXVzZSB0aGUgc2VydmljZSB3ZSdyZQ0KPiA+IGxvb2tpbmcNCj4gPiB1cCBpc24n
dCByZWdpc3RlcmVkLg0KPiA+IHRhc2stPnRrX3JlYmluZF9yZXRyeSBpc24ndCBjaGFuZ2VkIG9u
IGFueSByZXF1ZXN0IHRpbWVvdXQuIEl0DQo+ID4gaXNuJ3QNCj4gPiBjaGFuZ2VkIG9uIGFueSBj
b25uZWN0aW9uIGZhaWx1cmUuIEl0IGlzbid0IGNoYW5nZWQgYnkgYW55IG90aGVyDQo+ID4gY29k
ZQ0KPiA+IHBhdGggaW4gdGhlIFJQQyBjbGllbnQuDQo+ID4gDQo+ID4gU28gbm9uZSBvZiB0aGlz
IGFwcGxpZXMgdG8gdGhlIGNhc2Ugb2YgYSBkZWFkIHNlcnZlci4NCj4gDQo+IFNvcnJ5IGlmIEkn
bSBub3QgY2xlYXIuIFdoYXQgSSBtZWFudCBieSBhIGRlYWQgc2VydmVyIGlzIGEgZGVhZCBORlMN
Cj4gc2VydmVyIGFuZCBub3QgcnBjYmluZCBzZXJ2aWNlLiBTbyBpbiB0aGlzIGNhc2Ugd2UgZ2V0
IEVBQ0NFUyBmcm9tDQo+IHJwY2JpbmQgYW5kIHdlIHJldHJ5Lg0KPiANCj4gPiANCj4gPiBJdCBh
cHBsaWVzIHRvIHRoZSBjYXNlIG9mIGEgbGl2ZSBzZXJ2ZXIsIHdoZXJlIHJwY2JpbmQgaXMgcnVu
bmluZw0KPiA+IGFuZA0KPiA+IGFjY2Vzc2libGUgdG8gdGhlIGNsaWVudCBhbmQgd2hlcmUsIGZv
ciBzb21lIHJlYXNvbiBvciBhbm90aGVyLCBpdA0KPiA+IGlzDQo+ID4gdGFraW5nIGFuIGV4Y2Vw
dGlvbmFsbHkgbG9uZyB0aW1lIHRvIHJlZ2lzdGVyIHRoZSBzZXJ2aWNlIHdlIGFyZQ0KPiA+IGxv
b2tpbmcgdXAgdGhlIHBvcnQgZm9yIChlaXRoZXIgTkxNIG9yIE5GU3YzKS4NCj4gDQo+IFllcywg
dGhpcyBpcyB0aGUgcHJvYmxlbSB0aGF0IEknbSBmYWNpbmcuDQo+IA0KPiA+IA0KPiA+IFNvIHdo
ZXJlIGFyZSB5b3Ugc2VlaW5nIHRoaXMgcHJvY2VzcyB0YWtlIDkwIHNlY29uZHM/IFdoeSBkbyB3
ZQ0KPiA+IG5lZWQgdG8NCj4gPiB3YWl0IGZvciB0aGF0IGxvbmcgYmVmb3JlIHdlIGNhbiBmaW5h
bGx5IGNvbmNsdWRlIHRoYXQgdGhlDQo+ID4gcGFydGljdWxhcg0KPiA+IHNlcnZpY2UgaW4gcXVl
c3Rpb24gaXMgbm90IGdvaW5nIHRvIGNvbWUgYmFjayB1cD8NCj4gDQo+IDkwIHNlY3Mgd2FpdCBp
cyBmb3Igd2hlbiB0aGUgTkZTIHNlcnZlciBuZXZlciBjb21lIHVwIGFuZCB3ZSBrZWVwDQo+IGdl
dHRpbmcNCj4gRUFDQ0VTIGZyb20gcnBjYmluZCBmb3IgdGhpcyB3aG9sZSB0aW1lLg0KPiANCg0K
T0ssIHNvIHRoZSA5MHMgaXMgY29tcGxldGVseSBhcmJpdHJhcnkgdGhlbiwgYW5kIHdhcyBvbmx5
IGNob3Nlbg0KYmVjYXVzZSBpdCBmaXRzIHlvdXIgcGFydGljdWxhciBzZXJ2ZXI/DQoNClRvIG1l
LCB0aGF0IGFwcGVhcnMgdG8gaW52YWxpZGF0ZSB0aGUgZW50aXJlIHByZW1pc2Ugb2YgY29tbWl0
DQowYjc2MDExM2EzYTEgdGhhdCB3ZSBjYW4gcmVseSBvbiBycGNiaW5kIHRvIHRlbGwgdXMgaWYg
dGhlIHNlcnZpY2UgaXMNCnByZXNlbnQgb3Igbm90Lg0KSW4gdGhhdCBjYXNlLCBJJ2QgcmF0aGVy
IHJpcCBvdXQgdGhlIHRhc2stPnRrX3JlYmluZF9yZXRyeSBjb3VudGVyLCBhbmQNCmp1c3QgcmVs
eSBvbiBzdGFuZGFyZCBoYXJkL3NvZnQgdGFzayBzZW1hbnRpY3MuDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
