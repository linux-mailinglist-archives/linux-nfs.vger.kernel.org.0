Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5354C9E8
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351648AbiFONfQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 09:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbiFONfO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 09:35:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2130.outbound.protection.outlook.com [40.107.93.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DC035DEC
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 06:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHGcGpmsCBt2ctUHA6RVLMHh1lwEzPU2xwww37+79rMzVaqXHPTR5Mt7GcnRV+JJnU+IWvmGhhr+E0nUepjzC0fsxj5GdsNp0FkL5flw9WjwlPCzbDNifaXACK9or2mcVZyuzlkiNw/3FwKID0yRVUihXrU9jaTJDYh2xD+hEZ3FnhZiSB8flYYb2MZ5/eTputZ5JrFQXPn6qEcsVt3iPQl96t4NF8DZSMIfI7/689So/+5Hegb5sylq6fobuxIlVeTYQ4JbsJqrOqbL/blmE+XPU/sdJqRNxq/bH2FPnmV6Jb/QYRGGLywb+wp3rZRFUac9t3Y7voHTO/GucEwkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ajzQT08ZtyZCnz7kxumxo1bHCbEIstsOEUAwGDNE7s=;
 b=VRCV75hddDukI/ckR2p/kOM7D2tW5wnOT/bQiaCPvcj6VP4QTpwlz3rg7cgdbP+SQWVhv5gHlHQHWQvncaKnNBFBrvhA0IzMFAq5S8PZZRplSFdlH3lapvXLeH3ddSgriagxqkXODL8INGxlUyVHRxcOmuKdIALNoIIdQhiLLhahNEV+7PUgedv0Mjw/KknEJmEc3pdS33fKmWdzr98UoAEG2juwD5aLH5T54Gw7Wehes42pwlvsxKSrTaHPREW2BAF2FKdOTtu3BNbzV6riUo1CbkFH0cItBgllfFk3BabWQsNrH48+8jf9W96fAinFcD7q3TFR3jsX4Mopkf1cNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ajzQT08ZtyZCnz7kxumxo1bHCbEIstsOEUAwGDNE7s=;
 b=Z0KTCSjJVfmaijwjsjGEvQiFwOQkfK3+fbdPq95iSeQYqLmtTGWmS+9mzu/QgFl/yH+4XZGlPg89bXwxJ3wLY7iHz4xJtFnZ251q9IaEsJc5dWgkWcJPTwwcq2obbJl6T6erZuwexB6sgg0RrQPXxFu2KqhDQu1b7aXMp5rF/Xc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB1854.namprd13.prod.outlook.com (2603:10b6:300:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 13:35:11 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7%7]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 13:35:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chenxiaosong2@huawei.com" <chenxiaosong2@huawei.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
Subject: Re: Question about reporting unexpected wb err in nfs write()/flush()
Thread-Topic: Question about reporting unexpected wb err in nfs
 write()/flush()
Thread-Index: AQHYgLWMeKt2UGLDPUWqSThxqOyi6q1QeAoA
Date:   Wed, 15 Jun 2022 13:35:10 +0000
Message-ID: <1995185dc7899aca681cf70772e8e80c4a7faddd.camel@hammerspace.com>
References: <ff6de37e-899a-8b23-d1a9-bf11fde10e5d@huawei.com>
In-Reply-To: <ff6de37e-899a-8b23-d1a9-bf11fde10e5d@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c06b06e-5a7b-4cbb-0459-08da4ed3dec0
x-ms-traffictypediagnostic: MWHPR13MB1854:EE_
x-microsoft-antispam-prvs: <MWHPR13MB185453A9368AED8E20F3803EB8AD9@MWHPR13MB1854.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wzvXKmWDAw4ZZeREDMkOs9A64r4riqjlOkFg8fFYiFvcBLFA12FG1KaWUxCo+n8I1MZhOqCtmtVLjAExk+D0r9mZi+ur/iS7oL4kzgyMw51lEyPSJlNJyh/2tA6/T6V3chJ7qAV1dSQlgxAIAe/AJJGBx+xiXjjZQ3R8TT+sUeoxy55UefM6pV2vqheuFM6WP5vN57SjB6r59DaucGu8X09Qxs05uvd114CclPoLhlO6itYkv8HGDTpAiL2QmKgErT0TD6HWqhxhnBpUJ8Gy2KHWl+ASc+e6diuj595wE1YKGXse6LwKJFxf0ehLepnjfd0WxK0QQDPimoXJFsMBA8DHmHRQUOUqpqzstBKi436x6G9wZYQE/c5HXtfVMLnz1AJpCM1p46Gj+SV4vb8STUuMdpK0878DAAQjloeimk5/BpFd7gX6QgaHcHae+xJqikYibMZjcv5HxzfKyt6UIjIckvXP70XP7R1OwBj1aNqpYZ1OAAICiTXoYao5V7dVP2lTJtBP8M5K/WjTMq8Xn6+tJefMWdtWeWYbcR+UhjBGzRMK5DTs4uNtNZ29K4azvaOSwdUOPTcrupyoyO+ApbuLUwQtjGPiCgPWUXhhyiwAHGKRZ0oISv8Y2v3FLUXnA924b+P2jZ9Lm0mf7LulEFJQkGxATkJwieTDCriCe2ANE40gIofq9QthN/jSD03LqeZCZBDFac7c8kX2KljQWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39840400004)(136003)(366004)(86362001)(38100700002)(38070700005)(122000001)(508600001)(8936002)(6486002)(2906002)(316002)(186003)(6916009)(71200400001)(54906003)(76116006)(4326008)(8676002)(64756008)(66476007)(66946007)(66446008)(66556008)(83380400001)(6506007)(5660300002)(2616005)(41300700001)(36756003)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzRJaVN2M2ZDNGQxeTNmdTlZaFIzemwvOGJSQ1pXbzEwYjJ5Nm5FOFpGVHM1?=
 =?utf-8?B?MzBGNG9LNTZmU2JZQzZFLzdlZVdNa2E5WGpaUUl0SzExUlRKMkFoYTBaT2M3?=
 =?utf-8?B?RVNNRU9oeGhaS1E0ay9IVE5obm9DNDY1dXJjZFUwNXVpdkdzS1p5VXZXcGha?=
 =?utf-8?B?T1pSK1IzbUtMNm5KcUpjWFlSOTZWZXU4cVB2V0J2WVhmbkRvQ2JrbVpqYkor?=
 =?utf-8?B?WlhNbW1LcUlXbHdvTjRLWFArdGNvQW1KakM3ZVhpT3dVQjJXeU9jVWkxbi9B?=
 =?utf-8?B?NnBkQXNYa1BSS0tiWGUxTGM4bzI5cmVZbGhPZXRwRktQbTBUMlVUWnlNVTEr?=
 =?utf-8?B?QU9zblQ3Q0thd3d2MngzWWhUMXlsNG8rbEkxenFlZVZ2RHFMdDUwa0pYT1Yv?=
 =?utf-8?B?U0txeXVLdUJTdE5pdmxCM3Rza3VrMFhybTBTbDkvOEovakF3bmFxS3FiZ1p4?=
 =?utf-8?B?aThMUDdLS3l1WDdIVjZiTEsxNzYwcUs2WGhQemt1MWNIaFAxam9TMmJCWTh3?=
 =?utf-8?B?aCtJSW5IdVJNNU5vY0FUU3lUOS83a2ppMW9wN09UUENKWVh0cDdralhxN1JP?=
 =?utf-8?B?YTQxSUs0SnM0T09BYXlESzJESkxKVE1xNnQvRzVGclcvTWphSHhyMEhQS1VP?=
 =?utf-8?B?cGFtVkFLVjZ1NVdvWC9oSGk1a2tjY2ZJeXBiU1FBem5jL2w2T3NzdGdiMWUw?=
 =?utf-8?B?MnV3aUVUcFovNk1DZEk5SmhIWkJSRlRKZ2g0SG9RTUtaUzZYNFV0cWpYWWgw?=
 =?utf-8?B?ZURTYysxUEM5RTFsZ2g0bXFJVUdSaG55SUNkMFdSQzlnUDdwNmZnMldYRWJB?=
 =?utf-8?B?Q2hyeGFuM1VBWCs3eG1KdXEzWXE2VTRCSjY3Ni9kQ0dabmt6T2hWYXNHUW4y?=
 =?utf-8?B?aVA3bFZCVTRNa1dyY2lhWTVDY2YwSkJpV2lBYkJYaTdOMlhGcFlTNmFwSHZn?=
 =?utf-8?B?cm1NT2owY1ZWZlROcVlYaEdWczJ0YjhpTWk2TXpScm4rQ1cydnlhUVV4dGVn?=
 =?utf-8?B?NUhIbGt2NCtKM1R3UEkxZysvYVUrMDlzOWFnc0dRQmpJdE1yUmk3R3kwbUU0?=
 =?utf-8?B?WCtQUHFtcjFwRThOMUlsT0d0NWs4dWdQekJscGY4MGRxTGxQeFFKWjF2N0hY?=
 =?utf-8?B?aHhYZGYzLzVJclRkOU1HbnBGZTF2ZFQwcTBvWEVLWG1KVlZ2bG5iaEtRaDdq?=
 =?utf-8?B?WDVKM1gxbkQyQnByWnFXejA0ZTlnSmRPVUM3ODNXRXNqY0FYZTJoWXhJM3FM?=
 =?utf-8?B?aVYrelZxMUdCTlB1TnpORmNJU2E2bzdpUm9QeC9sUWZQRVRnZ253MjRSNXJI?=
 =?utf-8?B?Y25qWEI0NW5pUi9NZmVBSWJVL0FiZ0wrUmU3WlVKOVhmenkwUWJKSWZXM1Jx?=
 =?utf-8?B?TW10RXFvbGFVa09EWUVTNjkrSG4vN3c0WDhiWWszS1pQS2RxVWNZRCtSbDNn?=
 =?utf-8?B?M0I3bU16QktOdUZmUzJSVVpoeUFBVDA4NUorQXJUbm1Jd1ZDZWEyT1M0QXBH?=
 =?utf-8?B?cFp4Tkc4R3RxbHo3a2ZZb2JLUnB6WmxpcVFCU0M2YzNINTJucGFwQngxNk11?=
 =?utf-8?B?dTlLdk9RKzN4bWVEQThaTXpxMTNQNWtXVWNTWnBDVUhGdmR2SnI5SmRIM1Zq?=
 =?utf-8?B?d3V5amFvZzVLM0VYTERVejk2VXRmbGszZUxMMU5ObTRBRm1wN1Z1eXhrQTBx?=
 =?utf-8?B?WG5vQWx3dWM5ZFdCb1BuS255MDhXS2ozQ3dYcFBQVnErNmx4cjdtWSt5U2Fs?=
 =?utf-8?B?NTlyWFVoKzN4MTlIVWswVzF6MFJnUXhZLzZVYlQ1cWRqbmE5Q3VKU1VsT3FF?=
 =?utf-8?B?Uml3SFdVbkg5ZmZ1cFdxNkNhWmxsN2orL1A5OVhkTWMxTDhrb24zYlFHdDdL?=
 =?utf-8?B?MVZtNDQ4UXhUMXdqQWNSblJPQkhtdXBOVFJCeUJ1bDJHNXRpMUFMd2ttdUMw?=
 =?utf-8?B?dVlLWVF6NXBZK3I4SXIrNlJiUzFNVEUzdlh1b0hBSkk5M0N3cVFUdEFRcU0v?=
 =?utf-8?B?TWUyMmJnWFZNbHM2MWRwam1LU1BNUFhpN0JEQUJtYkZ1SlNhRENIVlZrVld4?=
 =?utf-8?B?ZFByaU1MNHlVL3BrWENlN1dCNWpOTzFtNmlabHBXNDFiYW1LRFdjK1lzbzVI?=
 =?utf-8?B?QkZteTFuUmdERzRmOEtDaFVqNFY4UThoMFdXSElzVWlsSjB4aG93MnFJZG15?=
 =?utf-8?B?bWd6cXlCVGZIOG5uRWZrMDFIc1p3b2VxdjRKcHV4SXdYdm9tQjdYVk9ucWxa?=
 =?utf-8?B?NCtkK1ZTODdzYUw3ei9Nb1pYWW85UUcvKzBsVkV6OEFTYW10TU1ySXQyaHV0?=
 =?utf-8?B?QTF2WnFOQ1R0TFdwbVc5ekZJM0ZOdEFkNHBxamVXV0pjRUdyNldreHhUcXUx?=
 =?utf-8?Q?eRp3S76lFY/z7fFg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B814173D833713489E927880A154757A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c06b06e-5a7b-4cbb-0459-08da4ed3dec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 13:35:10.7913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+2/IuB23VM0SuoobndiG5/eJ57N/WqtLRwgRlzSi3ObH3j3amHgxuLGmIDRJfRPwX/DXUPs3r/LwK4yVTiXaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1854
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA2LTE1IGF0IDIwOjQzICswODAwLCBjaGVueGlhb3NvbmcgKEEpIHdyb3Rl
Og0KPiBIaSBUcm9uZDoNCj4gDQo+IE9LLCBJIHVuZGVyc3RhbmQsIEkgd2lsbCBub3QgY2xlYXIg
d2IgZXJyIGluIGNsb3NlKCkuIEkgd2lsbCBub3QNCj4gY2hhbmdlIA0KPiBydWxlcyB0aGF0IGFw
cGx5IHRvIGFsbCBmaWxlc3lzdGVtcy4NCj4gDQo+IEJ1dCBpZiBvbGQgd2IgZXJyIChzdWNoIGFz
IC1FUkVTVEFSVFNZUyBvciAtRUlOVFIsIGV0Yy4pIGV4aXN0IGluDQo+IHN0cnVjdCANCj4gYWRk
cmVzc19zcGFjZS0+d2JfZXJyLCBuZnNfZmlsZV93cml0ZSgpIHdpbGwgYWx3YXlzIHJldHVybiB0
aGUgDQo+IHVuZXhwZWN0ZWQgZXJyb3IuIGZpbGVtYXBfY2hlY2tfd2JfZXJyKCkgd2lsbCByZXR1
cm4gdGhlIG9sZCBlcnJvcg0KPiBldmVuIA0KPiBpZiB0aGVyZSBpcyBubyBuZXcgd3JpdGViYWNr
IGVycm9yIGJldHdlZW4gZmlsZW1hcF9zYW1wbGVfd2JfZXJyKCkNCj4gYW5kIA0KPiBmaWxlbWFw
X2NoZWNrX3diX2VycigpLg0KPiBgYGBjDQo+IMKgwqDCoCBzaW5jZSA9IGZpbGVtYXBfc2FtcGxl
X3diX2VycigpID0gMCAvLyBuZXZlciBiZSBlcnJvcg0KPiDCoMKgwqDCoMKgIGVycnNlcV9zYW1w
bGUNCj4gwqDCoMKgwqDCoMKgwqAgaWYgKCEob2xkICYgRVJSU0VRX1NFRU4pKSAvLyBub2JvZHkg
c2VlIHRoZSBlcnJvcg0KPiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+IMKgwqDCoCBu
ZnNfd2JfYWxsIC8vIG5vIG5ldyBlcnJvcg0KPiDCoMKgwqAgZXJyb3IgPSBmaWxlbWFwX2NoZWNr
X3diX2VyciguLi4sIHNpbmNlKSAhPSAwIC8vIHVuZXhwZWN0ZWQgZXJyb3INCj4gYGBgDQo+IA0K
PiBJIHdpbGwgZml4IHRoaXMgYnkgc3RvcmUgb2xkIGVyciBiZWZvcmUgZmlsZW1hcF9zYW1wbGVf
d2JfZXJyKCksIGFuZCANCj4gcmVzdG9yZSBvbGQgZXJyIGFmdGVyIGZpbGVtYXBfY2hlY2tfd2Jf
ZXJyKCk6DQo+IGBgYGMNCj4gwqDCoCAvLyBTdG9yZSB0aGUgd2IgZXJyDQo+IMKgwqAgb2xkX2Vy
ciA9IGZpbGVfY2hlY2tfYW5kX2FkdmFuY2Vfd2JfZXJyKGZpbGUpDQo+IMKgwqAgc2luY2UgPSBm
aWxlbWFwX3NhbXBsZV93Yl9lcnIoKQ0KPiDCoMKgIG5mc193Yl9hbGwgLy8gZGV0ZWN0IG5ldyB3
YiBlcnINCj4gwqDCoCBlcnJvciA9IGZpbGVtYXBfY2hlY2tfd2JfZXJyKC4uLiwgc2luY2UpDQo+
IMKgwqAgLy8gUmVzdG9yZSBvbGQgd2IgZXJyIGlmIG5vIG5ldyBlcnIgaXMgZGV0ZWN0ZWQNCj4g
wqDCoCBpZiAoIWVycm9yICYmIG9sZF9lcnIpDQo+IMKgwqAgZXJyc2VxX3NldCgmZmlsZS0+Zl9t
YXBwaW5nLT53Yl9lcnIsIG9sZF9lcnIpOw0KPiBgYGANCj4gDQo+IElzIG15IGZpeGVzIHJlYXNv
bmFibGUgPw0KDQpObyEgVGhhdCBpcyBzdGlsbCBzcGVjaWFsIGNhc2luZyB0aGUgd2F5IE5GUyB0
cmVhdHMgZXJyb3JzIHZzIHRoZSB3YXkNCmFsbCBvdGhlciBmaWxlc3lzdGVtcyBkby4NCg0KRWl0
aGVyIHRoZSBjdXJyZW50IFZGUyBpbXBsZW1lbnRhdGlvbiBvZiBlcnJvciBsb2dnaW5nIGlzIGNv
cnJlY3QsIG9yDQppdCBpcyBub3QuIElmIGl0IGlzIGluY29ycmVjdCwgdGhlbiBsZXQncyBmaXgg
aXQgdG8gZG8gdGhlIHJpZ2h0IHRoaW5nDQpmb3IgZXZlcnlvbmUuDQoNCkVpdGhlciB3YXksIHBs
ZWFzZSBzdG9wIHBvc3RpbmcgdGhlc2UgTkZTLW9ubHkgd29ya2Fyb3VuZHMuDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
