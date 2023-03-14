Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978156B9F16
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 19:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjCNSvt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Mar 2023 14:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCNSvr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Mar 2023 14:51:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36576EA8;
        Tue, 14 Mar 2023 11:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR/41t+QkwHlVJvzEG3WaP6ol5Zt+k076nAaJAB+g+oQUIEhj/AL7Ph4jPHvsbW0S5s4cZgCJC+79YSSzrpCNqMiCo7+PUmuByQgO2ptRvJqz+ZG/xDvQ5pQS4PTPFaXKKVWPRgvuWof8iiHwuPkUmqG34vRnRJUOjPOYFrRAy0AXfHLym0Ttz5+x0WMxS4ch+FK96JiYTkDFOejaZ9sHNAEUKjAzAGH06GsafWzhZIhutbB1fFcMJO/S+sULbDD5qxfkVLEzjTx8WyVcTzleIdzFgeMHT4lLcVrSF04IegX6S3VPF6PiPifMn1ONZ8pNjSFFiCT7PmoCZ5hGnWNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/3DGQbSdl1+5qEyGolof3zuzD4Khj/OLzSYAmNIMF4=;
 b=kb63SO/6faKxmzTZf+en6ZWVvtwQhwaKAdR9TFBtZgcnS0hsM863fCC1fPNSzmffdfNkhJAP2P/xWneFCjKueDByZ01AI7zEwAIKNCcMzo40w5Xu4AMnuQ4kyriNY8tNE5XDEiRSOUFhFi6HGmllX5CEhHufL05wzvvAYOr4jNdTF+ExZmYZCAHNcwxtuUPwgqUSxLwfvHYhUbD2BhypoLuJ5u1gQ4FgJbFHrqbY+AKpNYKlJVl/L9D49IezHl0XdNtW3PJyIeW8x1hO7AZKykzuPjZ7NWJ2sCX0b8mDW18ZPoIYDNlxoicMKly4OJym5HB6RGnAWoE/EoUXwSRWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/3DGQbSdl1+5qEyGolof3zuzD4Khj/OLzSYAmNIMF4=;
 b=ahwDEsqijsRPK4Pk9oXylsr4kK0XKu1Dhi4NW/B/eZ/4wRuLQnHUcUf+ncBnZlCfh7dJTIKyFyAG7/Tgpw4ZZ/40O29O70xr/UCJLWrOEh/fvCVgu9IuIAyrWNDATFyHYLNQGs3UWEAHSOB9DTLbEwMoCIc0QJ/pYyc4NeVMOc4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5088.namprd13.prod.outlook.com (2603:10b6:408:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 18:51:24 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::d23a:123:3111:e459]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::d23a:123:3111:e459%6]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 18:51:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Chengen Du <chengen.du@canonical.com>
CC:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: Correct timing for assigning access cache timestamp
Thread-Topic: [PATCH] NFS: Correct timing for assigning access cache timestamp
Thread-Index: AQHZUZSKhLSUcixTKE2A+BpRYTFnJ676qLyA
Date:   Tue, 14 Mar 2023 18:51:24 +0000
Message-ID: <84E89457-478E-42F8-AC5F-DFFC58FBEFFB@hammerspace.com>
References: <20230308080327.33906-1-chengen.du@canonical.com>
In-Reply-To: <20230308080327.33906-1-chengen.du@canonical.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB5088:EE_
x-ms-office365-filtering-correlation-id: 7731184f-2574-40ee-881a-08db24bd1c4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKKrDcKjwscXk5qjtGxx9vgx8mYlqTT7sZTQoX5J0SDgIKXnMbrHdk7941Xh8j+8EbAdplQO+uqFDXH0ZuO+Vgx/t+QJ+8sfvssvnKVxVsMr4+cteUxeAepXReJzMv/GzlpbnQjBgsS4V3gPgkkXjANt75wkmx5xyJcfdzeevzO4xhZB2XIYbLWN2AbwqBPg3CAm0qmD3DauALVaJTgezctihDWFvA/7wrt2hD1GrkETOdTEtyVmRbM6L/g/xUb1LFLcK3gR8NEjXm9nJecUIa2ukTNLVOpuuZTZ6Qpca+vUkWQnmLG27l8ztxYgsNgBmEPz2gvbjjl0q4RnWFBX+B7xqEsn5i54UCUn9vdFZDcqRKFmxrs3PoNwLBGkspo94Ii4MblWoNuNEIHjNw4IJTB0byj5mM8kCsS/tR8OlgkFgO6ZL0YJDeXkX+vPKWt4x0Zkn7U/BOn0DCJ1UH7FsJoEA9cqpAeqx9y8LSIaWMqWeBMEWF41fccxsPLnAvEnzSY5hjwnqX5zzjppCZIQBRnwXRbqlxCry78NxyRGTPZmjWSsrNjjfpPq8+GkcdEpVnd7Ek4mviyiMTpFmN4LGBO2WzkFTuIcGbRnsScZSZwXBXOEV2pAtjQlCu60zPZzyArydmb3cDf2RxSyft8dhZPPckeF/9o1UebkYnmgc62KRoAIwgvCThe3VUsjYNB2E7NN26HZ6LQb+tNBzCJCIiOv9m1VLkRjxTaes0N6skeA86B3IHb8ZPfNM9uL93Wrqzh0sJjEWt8MBe+SjzHYxGM/e3OLofng2d1RZbgNH30=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39840400004)(396003)(346002)(376002)(451199018)(33656002)(36756003)(38070700005)(86362001)(38100700002)(122000001)(5660300002)(2906002)(41300700001)(8936002)(4326008)(2616005)(6512007)(6506007)(186003)(26005)(53546011)(83380400001)(54906003)(316002)(64756008)(6486002)(66476007)(66556008)(76116006)(66946007)(8676002)(6916009)(478600001)(71200400001)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tzk3NFFuQ0NzdXpzKzhBWWdxb1VuSnRJWWhvN21MRHVZaGcyVFpScGZCYVlv?=
 =?utf-8?B?RHg1M3pUdU1kTVFNSWo2MWdCaWZUVnpFaEczbzNXZXZxdkxzN2dUZVZMQ1Nm?=
 =?utf-8?B?Z2xuMC9UQlFSemJzdGVRVU1qOEFKbXdBeTFDMHQxN1lESGo3cERqSGh2dkY5?=
 =?utf-8?B?MUtSV1BscnM2Q2dHa2tGNEIwenZ0S0Y0Q2toa1RhMmRYL2QxdHNBNU5JQnUy?=
 =?utf-8?B?b29YaWQ0ZEo1MDF4VXBvRTBMMGw5ZC9SS3pTemNNRjB6V1NDL1oyaHdVcWx4?=
 =?utf-8?B?YkE3LzhTZXlqUGlBb1lSSmdqWitmeVAwMUZidzM4aFF0QnNacUdtY0ZQZUFZ?=
 =?utf-8?B?eVNQSVdRVkljZzNjSGFxdUNtcnFGdmNhc3dsdm5sdTZ2cXZWREh4YWRpeFY3?=
 =?utf-8?B?SUhvdDBpTGw1cXhERk02MGFqcFYyTzZuSnViUXF4T1lhTHEyaWJ6S091dUZW?=
 =?utf-8?B?dm02VjMyNGJQR0pmYnVBQ09tNVBYSDkxYjcvTUNDTlhBT2VUWTdhZlR6SGVP?=
 =?utf-8?B?ZTF3dWZBSWJheHhHcEd4eXhianBobHFSd0wydFpiUUttcjBpc3JhMTJ5Q04y?=
 =?utf-8?B?dWJxa2xHUys2cXRGU2MrZXJmMWhOVGt1NEoxZFZOUjZ0VGFYci9aN2dJbWFl?=
 =?utf-8?B?emU2UVE4Z2RmWE1ZUjRUWWM2VlRKOXJNcmt5UVFteFh2OFJiWWpKZWh2cWg3?=
 =?utf-8?B?ZXl2dGVmVG0vT2NWUmlaUktoWGQrbXI5aWlWYi9obTlGdHVseUlzV2lqV005?=
 =?utf-8?B?Z01QTi9JbjBaa2JsUmhuK2NxbW9wRUZQSmNVVzVlUThuYzdXRFpsS0M5aldE?=
 =?utf-8?B?L0hGYlE0QTczSjNld1dOa0lKS2FSZ2o0WjhhaE1lVGVkMWlwS04rUWNqb1NC?=
 =?utf-8?B?YmtkWnhjbDVrS1UzbkdFaWZrQUhaUDFHOUtqTEJ4QjEyNHZKKzNqODI2b0Vx?=
 =?utf-8?B?T1VQK2Q2cmtwMlVrU0ZlUDRncWtidE1rYXkzcmdWN1d6TGpOR2xkSTNoS1Mx?=
 =?utf-8?B?V1lvT2dTY2UyWTVIV3Q0M0tKV0dHREJEYkFibXd0NmlVQ3kvVmtGV1A1S21t?=
 =?utf-8?B?Szd1Rnh2L0xKRzBFY3YrV3dCa2tTMmRFMjVEYjFhTnNrczYrWGY3VFc5cUJK?=
 =?utf-8?B?Q2ZpT0VuSTFHUHRHNmZPcFBnZzdYZVoySnU0OG5WQ2dVRW5zVVljWEJ5SUc1?=
 =?utf-8?B?eU8rZ1A0a09VNldVdFlHR0hBK0UxeHFNV2JZNmFrRCsyQk50eS9IZVU1UHNv?=
 =?utf-8?B?Zld1MU1tcmNIS1VwZHNMNHBLOWh3eDFkaEFYRG43R3V2VjJyK05zcXExdEM4?=
 =?utf-8?B?bXdqY0NYZ20wYlBHUkdIclVLYTlnQ3E5RitYZHloVmVRYUpqcm9TOVIyY2l3?=
 =?utf-8?B?ZTN4OGpSNzR3cjJjMk5TVFRBbmxUV3FuUlR4OG0xczdTMFpoT3V4V2xHaVhx?=
 =?utf-8?B?c3F3V21HSnVJSkFWcUlRRmEyZ0luUEdrOFIzblh1RHFJVUxLL3gyYmM4YThl?=
 =?utf-8?B?Y1ZIRFhvN09yVm5iQktnd1VPVTh0SituQVlCblQzSTlIYXhMUEN1K3VDUUti?=
 =?utf-8?B?NzNsTWJhOEZXZ0lkbHBJK1JKQThDQWhQcC9DUWNXUlFiREFjbDhWZGNCd3Ax?=
 =?utf-8?B?NERuWXU1VndHNHhWTkRPY3FZY0k2V2UvWEVOYTdqcGYwcVA4UUxocENsZi9S?=
 =?utf-8?B?OEwzTkZtMjZwbG9EOGpMd3hRSVExZjRWUEFmS21iVStOVllHY0xwSWRYYWUz?=
 =?utf-8?B?NU5tNGp4dDREajZoZS90SFA0bStJVDJIZjR6d1BxS2NOR0JUeUlaNjJ5b01R?=
 =?utf-8?B?ekhwRG9EejBDQzc0eDRtdjA1K2o1S2ZxZGlpWHNMcjk1Q2NGbE11WVQ1VTQ4?=
 =?utf-8?B?dG9DbnZtNVJ5Mlc0eXNqY2Zqam0zcWlpSXltZVpSRVoxS05SU0ptaSt5RW9h?=
 =?utf-8?B?NmI3Q3ZtM0lLSFVTdEJzcG54enNQVHdHTEwxYmJMVEYyODBiaE83TnVUZEh1?=
 =?utf-8?B?V21EMVBveVUxSjhtR3JFZDk0SG94amtzRTZGMnFwNWRka1BhNGRZeWNYV0li?=
 =?utf-8?B?Tyt2Z0V5aTZyUUxwMXp3SHJqbnppN2YwMjk1YTl5MjdGaklObXRPbU9IUm9R?=
 =?utf-8?B?UFJabWRoVHovem9yc1VOdkRXMy9weDNrQWQvanFxMElJRUNWU1JZN2N4WCt4?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43233C48E9589C45AF9902B2212B328A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7731184f-2574-40ee-881a-08db24bd1c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 18:51:24.5006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEFNukMhFe4kJEqUmJSGT49/Aj1Yb3DZOYOFABgayM6LgYHd+/vxeoWPdpqTPI7Nzi5F+QqmAEp+tThbczj0FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDgsIDIwMjMsIGF0IDAzOjAzLCBDaGVuZ2VuIER1IDxjaGVuZ2VuLmR1QGNh
bm9uaWNhbC5jb20+IHdyb3RlOg0KPiANCj4gV2hlbiB0aGUgdXNlcidzIGxvZ2luIHRpbWUgaXMg
bmV3ZXIgdGhhbiB0aGUgY2FjaGUncyB0aW1lc3RhbXAsDQo+IHRoZSBvcmlnaW5hbCBlbnRyeSBp
biB0aGUgUkItdHJlZSB3aWxsIGJlIHJlcGxhY2VkIGJ5IGEgbmV3IGVudHJ5Lg0KPiBDdXJyZW50
bHksIHRoZSB0aW1lc3RhbXAgaXMgb25seSBzZXQgaWYgdGhlIGVudHJ5IGlzIG5vdCBmb3VuZCBp
bg0KPiB0aGUgUkItdHJlZSwgd2hpY2ggY2FuIGNhdXNlIHRoZSB0aW1lc3RhbXAgdG8gYmUgdW5k
ZWZpbmVkIHdoZW4NCj4gdGhlIGVudHJ5IGV4aXN0cy4gVGhpcyBtYXkgcmVzdWx0IGluIGEgc2ln
bmlmaWNhbnQgaW5jcmVhc2UgaW4NCj4gQUNDRVNTIG9wZXJhdGlvbnMgaWYgdGhlIHRpbWVzdGFt
cCBpcyBzZXQgdG8gemVyby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoZW5nZW4gRHUgPGNoZW5n
ZW4uZHVAY2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+IGZzL25mcy9kaXIuYyB8IDIgKy0NCj4gMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZnMvbmZzL2Rpci5jIGIvZnMvbmZzL2Rpci5jDQo+IGluZGV4IGE0MWMzZWU0NTQ5Yy4u
NmZiY2JiOGQ2NTg3IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvZGlyLmMNCj4gKysrIGIvZnMvbmZz
L2Rpci5jDQo+IEBAIC0zMDg5LDcgKzMwODksNiBAQCBzdGF0aWMgdm9pZCBuZnNfYWNjZXNzX2Fk
ZF9yYnRyZWUoc3RydWN0IGlub2RlICppbm9kZSwNCj4gZWxzZQ0KPiBnb3RvIGZvdW5kOw0KPiB9
DQo+IC0gc2V0LT50aW1lc3RhbXAgPSBrdGltZV9nZXRfbnMoKTsNCj4gcmJfbGlua19ub2RlKCZz
ZXQtPnJiX25vZGUsIHBhcmVudCwgcCk7DQo+IHJiX2luc2VydF9jb2xvcigmc2V0LT5yYl9ub2Rl
LCByb290X25vZGUpOw0KPiBsaXN0X2FkZF90YWlsKCZzZXQtPmxydSwgJm5mc2ktPmFjY2Vzc19j
YWNoZV9lbnRyeV9scnUpOw0KPiBAQCAtMzExNCw2ICszMTEzLDcgQEAgdm9pZCBuZnNfYWNjZXNz
X2FkZF9jYWNoZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgbmZzX2FjY2Vzc19lbnRyeSAq
c2V0LA0KPiBjYWNoZS0+ZnNnaWQgPSBjcmVkLT5mc2dpZDsNCj4gY2FjaGUtPmdyb3VwX2luZm8g
PSBnZXRfZ3JvdXBfaW5mbyhjcmVkLT5ncm91cF9pbmZvKTsNCj4gY2FjaGUtPm1hc2sgPSBzZXQt
Pm1hc2s7DQo+ICsgY2FjaGUtPnRpbWVzdGFtcCA9IGt0aW1lX2dldF9ucygpOw0KPiANCj4gLyog
VGhlIGFib3ZlIGZpZWxkIGFzc2lnbm1lbnRzIG11c3QgYmUgdmlzaWJsZQ0KPiAqIGJlZm9yZSB0
aGlzIGl0ZW0gYXBwZWFycyBvbiB0aGUgbHJ1LiAgV2UgY2Fubm90IGVhc2lseQ0KPiAtLSANCj4g
Mi4zNy4yDQo+IA0KDQpEb2ghIE5pY2UgY2F0Y2jigKYNCg0KQW5uYSwgcGxlYXNlIHBpY2sgdGhp
cyB1cCBmb3IgNi4yLXJjWCBhbmQgYWRkIGFuIGFwcHJvcHJpYXRlDQoNCkZpeGVzOiAwZWI0Mzgx
MmMwMjcgKCJORlM6IENsZWFyIHRoZSBmaWxlIGFjY2VzcyBjYWNoZSB1cG9uIGxvZ2lu4oCdKQ0K
DQpUaGFua3MhDQogIFRyb25kDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg==
