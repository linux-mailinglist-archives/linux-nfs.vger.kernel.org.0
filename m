Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF659B0BF
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Aug 2022 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiHTWTu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Aug 2022 18:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiHTWTq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Aug 2022 18:19:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2101.outbound.protection.outlook.com [40.107.93.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5641B32BA8
        for <linux-nfs@vger.kernel.org>; Sat, 20 Aug 2022 15:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm3hde4hR5uDenIA7VUq/gvbClnT7s7pQXYZvQL3VM9l/WzI0nWHrnVFTerBD6jwGxRQ2CKVD7f17zGXm6AzH9uF7O0ahbpMOnozptajSScYCce9hX4JYG15aVo0fFYZdC7SWfDxQ7IKq6Hapx8xVQifjH1iba2EdnN2EvgOgZnKqXRgXpuSgb4MiHXf3+9PAddjtbWVXK0UaX2WjvY1EZv2Ch90gKP5zFEY42CFC15vWjbE5v16cPF3QDPEgD72T5yAJaP/+9/reAQ9epEjd6JuOMLYfLSnpAfdw6TQc2X9XdsAVwhDh0LqUBYTq27kkAECxxIUrreJYrxs8tT+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUuQpFH1MS6nNROQe3OCUpAPk1zegx2jAn8ONIDnALo=;
 b=jjSdu3oyXcoCdnJ+ekH47MCcCg49aM7H+QjHPMJzaY64SK1RAdPInwb+Np/ssJcjd+hDXPB5/P9t7xIQdITOB/SrDh+TQG9Sa+D4n8B6iA/239VPBKWGCUALUGzYYLwGtdicAljVJ2FcWr8Rkp1pDFBPbTSSkbKNgcoocKpFBwgiYk/9IVNhDnrKwf+EaV7ugzo0g+TQiOG0qs+x/nHx9HGrW6bjI7qFLSIDqK0xvLq+Q7G4YjdJZ2Od7DCicyhrVWPlrAPy5VRqsXBFTA5+q2MHhjd9fL2Nc2O/dD2hCpJRwCzPACviDI9E8IkYLmkPJ4edsmULEpnc3gp2Tev7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUuQpFH1MS6nNROQe3OCUpAPk1zegx2jAn8ONIDnALo=;
 b=QXR1R3+wW+LyWDIbrOHBd7/SfNNmcihZzqZ0JVZH5AP637chtvfhhF47zGduRVr65qbj6G+C6D+NiCcDdM4FKtk3h+hRmq5oQ3RrLRFvq2zvXwxtIwK28TniQdVHal0rbzCRGpPwb51hB/EaKYIYHs6KB5nYmJVgD2Wb1bj2Q7M=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BYAPR13MB2581.namprd13.prod.outlook.com (2603:10b6:a03:f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.14; Sat, 20 Aug
 2022 22:19:41 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.012; Sat, 20 Aug 2022
 22:19:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: check_flush_dependency WARNING on NFS/RDMA mount
Thread-Topic: check_flush_dependency WARNING on NFS/RDMA mount
Thread-Index: AQHYtN+Sv4pAiwwN90esG+z2zuh7AK24XB6A
Date:   Sat, 20 Aug 2022 22:19:39 +0000
Message-ID: <786676b7906d5a5b606e40c6b6cbd77a12743917.camel@hammerspace.com>
References: <229A8283-F857-4A34-99B8-EC71BFEA4C55@oracle.com>
In-Reply-To: <229A8283-F857-4A34-99B8-EC71BFEA4C55@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaa3d44d-d4e3-41fd-fb7d-08da82fa12f5
x-ms-traffictypediagnostic: BYAPR13MB2581:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aqnhx+ovEI1r0fqzRwbBI2nHm6tyHp+BseFJPWmlyOP3N5GgPZjLnbTcYk//I0Puqst8YpsUUPotmw3NHbyDX0Eh8yU5l+72Aeogs1Qcj1Z3V5n0+ot6uOj6fq2PS87nBgG/aYJx8MDC0s9lnmqUJ2U6GBJklxj5cxP7cojKJ47D10eTbiSQWVhN99kCHa5pphclLeKTSy+XtwM2Q6RB+jmLeb1pwZJ4fnhBxxirUfeXQOG1MIbBGASXyne6vAjE2AvPb2/5XR818t+i3j/ool0YSzwxDrIphlGgZUgVow5bBU2gBZnLDDWZCtQcfOrsMIzTGjXLwguCcijtAHgDJ2U2h9FpKs6Mg3iqBY3O10/97UNPOEIJWOah5PULYDukjS8oOdNkmDXFcjsoeN3I7wyGOFJeJPog3T5kepaSSNmOj5aG7n1GcDbnPunYe7KdJiELs1p43m+XutrFRu4cUwuhpK6I8ExhVzTdPAH5fKR2F+GkpHzuoFZDSh6p1dibXff7ccwnPgVTw5bWj+F0W19eq6kpTdYEs0GY1/k/fAHfNUVj300nF9agngPdtX7ht86dD4pjJzM2BLzt0+Yt+mS7hB+WeXHHa0bVX8xu9BP7pk4e0WGux4PtSFjw8UakHcYKzm/6Sgd3uPcXrsWKUap6zTWICGU1HzfYOXwxZI9leZaNGRCR6779+JZAANvjaXLpsQhyKxjFiXdOuhCmgpEo1O/ViiEFWP2/DhIAzihHtID/CyQztBF9oGwAG/wuuzt++Ce9/7npDH180wFBYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(346002)(136003)(376002)(366004)(396003)(36756003)(86362001)(38100700002)(38070700005)(2616005)(122000001)(76116006)(66946007)(8936002)(5660300002)(4326008)(186003)(66476007)(6486002)(6506007)(66556008)(41300700001)(66446008)(8676002)(71200400001)(2906002)(6512007)(26005)(64756008)(316002)(83380400001)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnBwT21VcHNWa1lXczVGemlEOHlPOFZCR3dFaU1La3NPNk9JbEgwOGM0c0s5?=
 =?utf-8?B?ZDhpaUpPK1RiaytKeDNxVTlrNGhpeXV6R3JocWE5ZERsN3lHenlNTE9BME8v?=
 =?utf-8?B?Y2NZZ09QTS9OMTBnZXVCZlREU0Rubmtud3JNUXZxdmJBOGlxZFBjSGc2U3Z3?=
 =?utf-8?B?TW5XUHdlcGZhQzV5R29JNnJ6Y1V6U2k1aWRJUGwzMEJOMys5aHdYeFJ2TXVn?=
 =?utf-8?B?U0VCK2s3RmFmRkx2SVRXV1kyYjN5V2NYQ0NyYVNQbFJVeTl1Ry92SklRR3hD?=
 =?utf-8?B?Yi9LY0hWZ293OHdFOEh0dmpwd08yYkx1dnh3S1NoNkx0MTNDRUJFVHI1VE5W?=
 =?utf-8?B?M1AvUHFTbHBpMFVkUTZrVTBHeFdBcGgwWGJZTVlhbDgrZW9HYUh0NlpMeWx2?=
 =?utf-8?B?dkxGaGJLYlJLeXd6MzJIeFpJcU50QjNaek9EUHp2TjB5VmVtNEpKWUppVkZU?=
 =?utf-8?B?VTVIZWVkNFMwU3o3Slh0c2JoTlROQ1JuWUFpK3NWeTExZG9sSGdjQnY5VW90?=
 =?utf-8?B?WmVqT2ZhcWVtTlQyS25Ha1g2RTAvL1d0WkZNeEJoczBEUTFpaHBQOU9nT05a?=
 =?utf-8?B?S1pMcXlxczI0SjVrRW5iaFhVb1ZiNjAwdHJnZDltUWRUQ1U0Y1p5U05WdlZj?=
 =?utf-8?B?NWV5QlVjU2lEczhGOWtBbFJpL2Y3bWVUaU1ic3ZudmJSdHdnTUFVckYxN1dX?=
 =?utf-8?B?R3J6L0YzVUUrNlV0MHZWY2NMRDI0K29wR0pDckpObzJhSFJsVFBxdlk0YW8y?=
 =?utf-8?B?a1VIVFRWa2JpR0NlN3c2MVJ6REpSczlWMXVCSUxpOE8rc2ZIMjBwWWRzWjZD?=
 =?utf-8?B?ZXpOMkdHZTB5MmlHNHZCWVdMWXdQRHJ0UVIzTWJoRkgwc3VpTW5mRi84bzdQ?=
 =?utf-8?B?ZkRFUEZXSVNMc0pCMCtFVEV2ZFBLbENIQkg5ZnZPdGMrZFd0R3dUODBlSEdi?=
 =?utf-8?B?dDdSZzFkZXNibHU0Mk5NTDM5RERHanlKZVZKcUg3QkxTOGxsc290NlhnNysx?=
 =?utf-8?B?WGMvR1UwN2IvWW16SzM5VFVQZzR0L3l2Q05qUkxwTUxYMkZ3a0ljK2ZDTVNT?=
 =?utf-8?B?ckQyMVNGZ2dZUjdXUTJuUm00Ums2bE0xbklHOHpnclZ4Y1hkZlJSbXFZM2Uv?=
 =?utf-8?B?SzlYNWpSYVNDczR6d21FMWtqYVRaTlQrOE5tZGNySHdUcDEvdERabUlqSnFQ?=
 =?utf-8?B?MFpuYTZUeUd2dzA1WGFKZENaT093Q2I3L2hyM083eVY1TkpLU20yK28vNDl1?=
 =?utf-8?B?U2VQVnlVd2VOUzZLeFpDTXo3dm9KWHlvWHhnTnlvT0FOWi9XbkZDa0ZxN2dX?=
 =?utf-8?B?STVXS2dOTFEvdnlpcEJ0OGljbWY2OFlZUSsyUkg5Q2hFNTFlSmdVTWI4TW41?=
 =?utf-8?B?QjJNV1NPZlhpTHpqZ3ZEeWpNcmhNajNjZWFhRUJRTE8yZUNHclFSU3JYK09C?=
 =?utf-8?B?WkdmVDF4NVpoL2VFY1VueTNUVkc3UEswb045ckZLcWQ5ek5GV0VzT0g2aWM0?=
 =?utf-8?B?bkJsZ2JsSUVMNU1wdG0wRzNnMXB3c09vU05aemdtRUFzVWlSUHdWbHZnOUVS?=
 =?utf-8?B?UG5TZTZZR0NycWNqWWFsVGF5ZmRTZXd1UmYwUXRNL2R1NklXdy9PdUN3NVVW?=
 =?utf-8?B?ZUkyQUR3SGJQek92dWR5dU9qbzEvRENPZGpuZ3ZEcmlGSmI3NTFiYTFmdFVk?=
 =?utf-8?B?VEVRTVY5WE4zZGdVOUw2aXU0VU9hVnIzaWZ6WkRjNDVOaDExNGtGZ3JSR3Zj?=
 =?utf-8?B?MnEzemJFVlpRSTlDMHJwN2JvSzIxV0dDbXZrblBaaGNLUWVxVGg0YXloOGE0?=
 =?utf-8?B?MnJjNFhBMTg4OXBiODUvaHFERk04Wms2c0xvaEpVMUQydWltZUx2cUk2NlNl?=
 =?utf-8?B?RDcxRUFyNWF0L240azNjNmthSnN6eE9ySi90YlZKS1kyYzAyZUpJQ2FkcUgv?=
 =?utf-8?B?Qnc5eHhtaEtoQkUreHJBTWxUcGc2a1JndlVqNWZQWG83dm9XN1lxUHhWOE8r?=
 =?utf-8?B?dGpTazMxdlIrRWlIdUVGbHdsUGlBckRGZUhZSTJyMkRiM0lRWTN5UERBYS9E?=
 =?utf-8?B?VzA1VTZZNm4yTWJ3RU8vU3NNUVk0bHR3MDV0bzN6MEdqN0NYY08xQzlGZ1I4?=
 =?utf-8?B?UWk3aFhVaExqMVJXREhXSVNYaXhlZnlsR2x3ZFpsTlRoNXVNUG56WnI1S2p3?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46D23B64356FFA4E988CBBEC1E80E19D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa3d44d-d4e3-41fd-fb7d-08da82fa12f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2022 22:19:39.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7lwXTQROqF4epI+nfwPHA/t6PHiL6/tlNeFuBbLN1VQhqwR981AWSwg+Ov04wY4C5GYwfqjaGqp//JHtPgvqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTA4LTIwIGF0IDIxOjU1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IEhpLQ0KPiANCj4gVGhpcyB3YXJuaW5nIGp1c3QgcG9wcGVkIG9uIGEgc3R1Y2sgTkZTL1JE
TUEgbW91bnQgKHRoZSBFdGhlcm5ldA0KPiBzd2l0Y2gNCj4gcG9ydCBWTEFOIHNldHRpbmdzIHdl
cmUgbm90IGNvcnJlY3QpOg0KPiANCj4gQXVnIDIwIDE3OjEyOjA1IGJhemlsbGUuMTAxNWdyYW5n
ZXIubmV0IGtlcm5lbDogd29ya3F1ZXVlOg0KPiBXUV9NRU1fUkVDTEFJTSB4cHJ0aW9kOnhwcnRf
cmRtYV9jb25uZWN0X3dvcmtlciBbcnBjcmRtYV0gaXMgZmx1c2hpbmcNCj4gIVdRX01FTV9SRUNM
QUk+DQo+IEF1ZyAyMCAxNzoxMjowNSBiYXppbGxlLjEwMTVncmFuZ2VyLm5ldCBrZXJuZWw6IFdB
Uk5JTkc6IENQVTogMCBQSUQ6DQo+IDEwMCBhdCBrZXJuZWwvd29ya3F1ZXVlLmM6MjYyOCBjaGVj
a19mbHVzaF9kZXBlbmRlbmN5KzB4YmYvMHhjYQ0KPiANCj4gQXVnIDIwIDE3OjEyOjA1IGJhemls
bGUuMTAxNWdyYW5nZXIubmV0IGtlcm5lbDogV29ya3F1ZXVlOiB4cHJ0aW9kDQo+IHhwcnRfcmRt
YV9jb25uZWN0X3dvcmtlciBbcnBjcmRtYV0NCj4gDQo+IEF1ZyAyMCAxNzoxMjowNSBiYXppbGxl
LjEwMTVncmFuZ2VyLm5ldCBrZXJuZWw6IENhbGwgVHJhY2U6DQo+IEF1ZyAyMCAxNzoxMjowNSBi
YXppbGxlLjEwMTVncmFuZ2VyLm5ldCBrZXJuZWw6wqAgPFRBU0s+DQo+IEF1ZyAyMCAxNzoxMjow
NSBiYXppbGxlLjEwMTVncmFuZ2VyLm5ldCBrZXJuZWw6wqANCj4gX19mbHVzaF93b3JrLmlzcmEu
MCsweGFmLzB4MTg4DQo+IEF1ZyAyMCAxNzoxMjowNSBiYXppbGxlLjEwMTVncmFuZ2VyLm5ldCBr
ZXJuZWw6wqAgPw0KPiBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4MmMvMHgzNw0KPiBBdWcgMjAg
MTc6MTI6MDUgYmF6aWxsZS4xMDE1Z3Jhbmdlci5uZXQga2VybmVsOsKgID8NCj4gbG9ja190aW1l
cl9iYXNlKzB4MzgvMHg1Zg0KPiBBdWcgMjAgMTc6MTI6MDUgYmF6aWxsZS4xMDE1Z3Jhbmdlci5u
ZXQga2VybmVsOsKgDQo+IF9fY2FuY2VsX3dvcmtfdGltZXIrMHhlYS8weDEzZA0KPiBBdWcgMjAg
MTc6MTI6MDUgYmF6aWxsZS4xMDE1Z3Jhbmdlci5uZXQga2VybmVsOsKgID8NCj4gcHJlZW1wdF9s
YXRlbmN5X3N0YXJ0KzB4MmIvMHg0Ng0KPiBBdWcgMjAgMTc6MTI6MDUgYmF6aWxsZS4xMDE1Z3Jh
bmdlci5uZXQga2VybmVsOsKgDQo+IHJkbWFfYWRkcl9jYW5jZWwrMHg3MC8weDgxIFtpYl9jb3Jl
XQ0KPiBBdWcgMjAgMTc6MTI6MDUgYmF6aWxsZS4xMDE1Z3Jhbmdlci5uZXQga2VybmVsOsKgDQo+
IF9kZXN0cm95X2lkKzB4MWEvMHgyNDYgW3JkbWFfY21dDQo+IEF1ZyAyMCAxNzoxMjowNSBiYXpp
bGxlLjEwMTVncmFuZ2VyLm5ldCBrZXJuZWw6wqANCj4gcnBjcmRtYV94cHJ0X2Nvbm5lY3QrMHgx
MTUvMHg1YWUgW3JwY3JkbWFdDQo+IEF1ZyAyMCAxNzoxMjowNSBiYXppbGxlLjEwMTVncmFuZ2Vy
Lm5ldCBrZXJuZWw6wqAgPw0KPiBfcmF3X3NwaW5fdW5sb2NrKzB4MTQvMHgyOQ0KPiBBdWcgMjAg
MTc6MTI6MDUgYmF6aWxsZS4xMDE1Z3Jhbmdlci5uZXQga2VybmVsOsKgID8NCj4gcmF3X3NwaW5f
cnFfdW5sb2NrX2lycSsweDUvMHgxMA0KPiBBdWcgMjAgMTc6MTI6MDUgYmF6aWxsZS4xMDE1Z3Jh
bmdlci5uZXQga2VybmVsOsKgID8NCj4gZmluaXNoX3Rhc2tfc3dpdGNoLmlzcmEuMCsweDE3MS8w
eDI0OQ0KPiBBdWcgMjAgMTc6MTI6MDUgYmF6aWxsZS4xMDE1Z3Jhbmdlci5uZXQga2VybmVsOsKg
DQo+IHhwcnRfcmRtYV9jb25uZWN0X3dvcmtlcisweDNiLzB4YzcgW3JwY3JkbWFdDQo+IEF1ZyAy
MCAxNzoxMjowNSBiYXppbGxlLjEwMTVncmFuZ2VyLm5ldCBrZXJuZWw6wqANCj4gcHJvY2Vzc19v
bmVfd29yaysweDFkOC8weDJkNA0KPiBBdWcgMjAgMTc6MTI6MDUgYmF6aWxsZS4xMDE1Z3Jhbmdl
ci5uZXQga2VybmVsOsKgDQo+IHdvcmtlcl90aHJlYWQrMHgxOGIvMHgyNGYNCj4gQXVnIDIwIDE3
OjEyOjA1IGJhemlsbGUuMTAxNWdyYW5nZXIubmV0IGtlcm5lbDrCoCA/DQo+IHJlc2N1ZXJfdGhy
ZWFkKzB4MjgwLzB4MjgwDQo+IEF1ZyAyMCAxNzoxMjowNSBiYXppbGxlLjEwMTVncmFuZ2VyLm5l
dCBrZXJuZWw6wqAga3RocmVhZCsweGY0LzB4ZmMNCj4gQXVnIDIwIDE3OjEyOjA1IGJhemlsbGUu
MTAxNWdyYW5nZXIubmV0IGtlcm5lbDrCoCA/DQo+IGt0aHJlYWRfY29tcGxldGVfYW5kX2V4aXQr
MHgxYi8weDFiDQo+IEF1ZyAyMCAxNzoxMjowNSBiYXppbGxlLjEwMTVncmFuZ2VyLm5ldCBrZXJu
ZWw6wqANCj4gcmV0X2Zyb21fZm9yaysweDIyLzB4MzANCj4gQXVnIDIwIDE3OjEyOjA1IGJhemls
bGUuMTAxNWdyYW5nZXIubmV0IGtlcm5lbDrCoCA8L1RBU0s+DQo+IA0KPiBBdCBhIGd1ZXNzLCB0
aGUgcmVjZW50IGNoYW5nZXMgdG8gdGhlIFdRX01FTV9SRUNMQUlNIHNldHRpbmdzIGluIHRoZQ0K
PiBSUEMgeHBydCBjb2RlIGRpZCBub3QgZ2V0IGNhcnJpZWQgb3ZlciB0byBycGNyZG1hLi4uID8g
TmVlZCBzb21lDQo+IGd1aWRhbmNlIHBsZWFzZSwgYW5kIEkgY2FuIHdyaXRlIGFuZCB0ZXN0IGEg
Zml4IGZvciB0aGlzLg0KPiANCg0KTG9va3MgbGlrZSB5b3UncmUgdHJ5aW5nIHRvIGNhbmNlbCB3
b3JrIG9uIGEgbm9uLW1lbW9yeSByZWNsYWltDQp3b3JrcXVldWUgZnJvbSBhIGpvYiBydW5uaW5n
IG9uIGEgcXVldWUgdGhhdCBpcyBmbGFnZ2VkIGFzIGEgbWVtb3J5DQpyZWNsYWltIHdvcmtxdWV1
ZS4gVGhhdCdzIGEgcHJpb3JpdHkgaW52ZXJzaW9uIHByb2JsZW0uDQoNCg0KQmFzaWNhbGx5LCB5
b3UgbmVlZCB0byBjaGFuZ2UNCg0KaW50IGFkZHJfaW5pdCh2b2lkKQ0Kew0KICAgICAgICBhZGRy
X3dxID0gYWxsb2Nfb3JkZXJlZF93b3JrcXVldWUoImliX2FkZHIiLCAwKTsNCiAgICAgICAgaWYg
KCFhZGRyX3dxKQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KDQogICAgICAgIHJl
Z2lzdGVyX25ldGV2ZW50X25vdGlmaWVyKCZuYik7DQoNCiAgICAgICAgcmV0dXJuIDA7DQp9DQoN
CmFuZCBmbGFnIGFkZHJfd3EgYXMgYmVpbmcgYSBXUV9NRU1fUkVDTEFJTSBxdWV1ZS4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
