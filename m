Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9CB5F3106
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJCNRE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 09:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJCNQx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 09:16:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2136.outbound.protection.outlook.com [40.107.237.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EB67679
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 06:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNA0uKYChuYleaJHGRUyI8wNQIgxWc7NywRRfMQDlgTcJAhuT8Npslnr8ma6TqJgXWw8l5ip3VEZMb/1IhPM9KOyEGclGYC6wguPIgmyyvtmul/kC1+pG7P2xNDtkmWVJ0nm6sxHmw4dk2jAQiqiOQrNvoWHdUgcScTKBXItI8UBYFTNdAWEN/VWkNCiVg1UsRYjJn/MOHCNWjcQfcW9OMesIbY/+d7T4UPXNaxWUG700D7OsHK3/rMc+vzb5pWipovOZ/46uSxurGq5F0XNTdLzbpNqrjz1gmegH89JsTy3kTLS7Cd+WfOzDB0BNv8DKzRHrxL1RGZTlbQ/Y0J0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23bxsIoT7WLAeTWWE8CGka0/+dEbrP+0vN95CS6LSM0=;
 b=PPIiMOtf37D/Sivd6oyAcDqc3TNFjO1O9yOQSzmGxH6Kj04ly7huMLQO+Z4paQw510ZvTCzFfboanEfQ4cU33iMdvlXK+iZouPr6zfCeVeVDiYuY3tkni05JQ+TfDmYnC8Prs5hNjzut9ledfC0sO/+TZ/LinDLd2mejuE8lvcKv2RHUnCB7/K18R9KK6U+pYCnmL/RpHQXX4d/Te+jtwcDD0Q9xN0h925SdNKImILt2eUU9aNqESE6BzbZigRrSDZcEcMLYQ4CEXe3rmBwzJI6XSQN0jNVgVyc3fDmml/1bTARYubY40+L7tcDRRr8kQMYMrL33NTpwRIXOGZepvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23bxsIoT7WLAeTWWE8CGka0/+dEbrP+0vN95CS6LSM0=;
 b=T2czc10QOwOu5lNA5/erzHZnwbFGldJDddDowGGtQU+Ti7ajhvPEyCMYTD0aYFkrl4QsqieNvDuPy+G3RWdSUAQwu6U1ec63COGg7hChdrPAtX2KMK7div0HnEQXKr4lCORCSrx0AyfBhmcphWWdXdXXB16+TIkP3py0tGSMQqc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4913.namprd13.prod.outlook.com (2603:10b6:a03:364::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.8; Mon, 3 Oct
 2022 13:16:48 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::93e4:42a1:96af:575e]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::93e4:42a1:96af:575e%9]) with mapi id 15.20.5676.023; Mon, 3 Oct 2022
 13:16:48 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC] NFSD: Hold rcu_read_lock while getting refs
Thread-Topic: [PATCH RFC] NFSD: Hold rcu_read_lock while getting refs
Thread-Index: AQHY1a067/oV18KqskKZwQ8VjniGP638qWsA
Date:   Mon, 3 Oct 2022 13:16:48 +0000
Message-ID: <aaebdc3facb1466da6390937b38ee9a31d2f9344.camel@hammerspace.com>
References: <166463917715.10124.3789034969503323129.stgit@bazille.1015granger.net>
In-Reply-To: <166463917715.10124.3789034969503323129.stgit@bazille.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB4913:EE_
x-ms-office365-filtering-correlation-id: 91dc0a8c-4f12-4091-b034-08daa5418712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKGMJayWf2beG7TSkXGfYyiWco7GPkqb03HI7/2zyldXolP49gyqj5kv+elXJUzQYpvxyqiQ4BJKX+s4MZIOV273xML7+gSnWV2QWWXdfCgJ6O4Omb9yWb9BH/By6hxi+QLVsU3J3SlLXBYlG8M5Q72wu2RUZ0/UW5IxYYaydRCjN+vrAuSypMv0dqNHH2UiQrzvvjCwg+K+YiAq4ao+wOxU1pJK3Db+/+HVpxUeH01qpG71PnnzyZCxGJ33v6PnVj0s/FmHgMBXa79b4EqOM4uFhF64UhTU4yYvGs7s2yZsamh1rHZRQ2UxJSE4hMne0GtFBh6/wtx5ee05JmD+SWSZoAMQPPS2DS30W/q+sCL3zoFPVfCdLzn8SWMpvXpraduF6u22hmnvJ4ccOtwOPQXUgkBt9VvhYQj/4mbifcZZlTikKum6X/gss1U54IHXrNjYw+5eqc77mvxrWP7AYf+ggS0pKyeFNWYdqZyTRnBPqRlEWc05RltnIflYAEUH7ADvK0Xv6vPP/odwcNosRBLeJSGrx+OTjxMhfROAvdJAkjPxQtCPBaltPJNaDPIIyxWqy3oDedH4Dl/iIiHhdRL0ilX1YsF6mMvKz3GALjYwPpHG3U12j+ysw9MKzNuvesRAcRr2aoQK+aJblf2oI/J9VlkCO0Ouu6MHmGRFyptmd/YCD6e89Vyzl7V3ysk6iw9SYrpK/4qDRnvaEl+YdNyL3fbvICek6XHUOkXBNgneokqdpNJy0aZZIX2pROPWIDGaCcR5SWdsTSdoFvFaKSajg4M12g3Jl7EK/VPfvNFq1btUK2OX3UV33dg3cv1Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39830400003)(376002)(136003)(451199015)(83380400001)(5660300002)(316002)(76116006)(66946007)(66556008)(26005)(186003)(6512007)(86362001)(36756003)(38070700005)(2906002)(38100700002)(8936002)(8676002)(71200400001)(110136005)(122000001)(66476007)(6486002)(478600001)(2616005)(64756008)(41300700001)(66446008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clNnc0pQMVJySGw1QVcxd3NOWVlITisrZVhWNG1pelNFNGlMM1lpeHpSV3V0?=
 =?utf-8?B?dmlNUDV5dnhnWkVHaTFKdnFzeGR1blB2bkM4TjVWUUp2OGY4WEUzenRNV0FE?=
 =?utf-8?B?a25TNUdvMWtkTWQwMEdzdHdkSlJXVW5HRmN3alo5aGN2MGlLMmc1emRIOWRk?=
 =?utf-8?B?QXAybWhlbC9pNXlmR1VEZVgyT0VLS1RqclhVczFLY0JLN1ZJblVLZ3FKNkFD?=
 =?utf-8?B?RXZHMXhBU2ZyM1Y0ZzZ6Z1ZFZVVtdm1hRG5TNFc1VlBabytxK0dhUlhBalcv?=
 =?utf-8?B?TFVWTnhONmQ4TnVtdWdWeWswdUR1dmhLZk9hcXFnT3g4QytCVStJdXNHMm9U?=
 =?utf-8?B?OGVheDJnZnZzZTVaYmJnS3I3NjJLL0JlNTRCWW9odm9pdktZOWd4bUMwK3A2?=
 =?utf-8?B?YjVqZ05EY21veTFYQlRHa3ZlMFFNekdCOE1OeUJuOWppWVJ3blpJbUJ5eDN0?=
 =?utf-8?B?L2x1Q2pKU1dQekI5Q0MrcnNiaUE4WnhFeVBpRW5SLzEyYUhFcmI5UWFQckJ5?=
 =?utf-8?B?VC9TRmJZWW5RZC93eUhaRFY0SHdnS3h6V2NZZVVrcU9TZWFjQ1hYdlBqa002?=
 =?utf-8?B?TmJLTWN5S3pUcWs5MytLWS9vZmR0dFFiVnBkZmFRU21OSlo3NnQvRGFoanFz?=
 =?utf-8?B?U2l4WGR5NjJrR0pQTWIraUVhd0VNTHluN2habHM4c055OUxkNnJpWDhjVFVO?=
 =?utf-8?B?NVh4a1BZb3VmNkNNUzF2elFFRmJqSGtFZTBSWVJxZFB2ZGFLWHNNY1NPSFBz?=
 =?utf-8?B?Y3hXWjg1UUNDcHVUVHQzQWJRUE5VLzRkR2h2SzFkeDhaU2V0TGUyaVg4dWVI?=
 =?utf-8?B?R3BxRkM0ek5mejdLdHNOcnNpSWppSnZ1VnZ5QUd6UUxXUk9xTTVlMDFoNkJq?=
 =?utf-8?B?WXVXaC9lemxySFdpN2VrTTVUaTRNNm5pWHNFMzlVMkpiaERIdnhSRllOOHda?=
 =?utf-8?B?elphTFBlQVllMzhTVXEydWQvN2M5NGN1b1VOTW5ITWxKZHpFU0pQaGlxSm5J?=
 =?utf-8?B?QTRTWDhmVGEvOGt4QzFNcWg0MVlmK2tIaWlhREpBZUd1YWFvN0lNWW5SUk1s?=
 =?utf-8?B?L0l6MnVWbkVaWTgwM2FtRk81MTRSUHZqeEM4ZlBFWDltamdtaTEweFhsQmdr?=
 =?utf-8?B?TmttTEVhZ05uakd6SlpYZDZ1TnhLR1VzYlRJckhJbkhDNzdlSjNrSDdwWk0v?=
 =?utf-8?B?dUJqRDF3RUFBMWg0K3oxdjBTVENHRGRDWG4wZlo3NUxqem0reXhlY1JucEs5?=
 =?utf-8?B?c1BvZk43K2hseXcyaHU0cFcra1pJLzVrelAvY0pjU0F2Ump5WmZHR0p4djZr?=
 =?utf-8?B?dXEybThYcDlQM3NIQXQ0bHlwcEpUZ2NJWjQrUFdnUjc0K0w5L1grcVZ6K0ly?=
 =?utf-8?B?N1NSSDhTOUFrb1FLcHVLQ3ZGbWFMSUNyUU9sVEZOTW1HdU0rWVFlN2ZxdHNu?=
 =?utf-8?B?YzF3MjRiSkprc3lJV2VTMVJyU3hrK2ZJSkgwNXFkdXdrQ0dxOUZIbUtXUWdh?=
 =?utf-8?B?VnJQMGszaGRhb09ua2h3M3RYV2FsUDhHeERtdW5yT0MxR3RWM0pSVGNxdmpr?=
 =?utf-8?B?Um5MV09YaEw0TE5RdTBPckozNlcvaHhaV09FNnhDa0psZmdkdlRNOVI5RVdq?=
 =?utf-8?B?a0NpKzFXTHRQa3p1bytrVEU2ZUQ0SUM3a25KMXJoSDhVTUhRNDE2eXNwYXp1?=
 =?utf-8?B?UXYxdXJkT0J6VC8xTXFOczlrWjlzWno1VXhrOWhRcTl4QVpQS1NTeTR3U2Zz?=
 =?utf-8?B?Mjk1NVkxZXAzWW5HUjEzTTArRXhvemt5M1g5NWhIdjgxN2FqOXdYaXhuWTZS?=
 =?utf-8?B?aUlhNyt1SVh6N3prK0taSzRUTVdjeE8zdjI2b3JZVE1mMzhFSU1rSlVZVDRF?=
 =?utf-8?B?d3k4cTBFVGtMcUlsdFMzTER2WU9wSWcvanhuQTlSamJ4N1ZLOGkzQ1FlSVU2?=
 =?utf-8?B?SGdRVjdwa0hXNmFTa0ZlWkVhRy9haGFGS2lyZ1FLaXVsZ3Y2Q1RZWXdGTUQy?=
 =?utf-8?B?RDRiZDVlSm1SaEEvN3dORFFUbGNkOC9Md3NXUG9NVENISHdSODMzZEJWRDdL?=
 =?utf-8?B?enJBZHgzem1sUnZ3OXZzSm13WXhINENQaHg2clIzOFUxWjAwRjJvYmxSOElH?=
 =?utf-8?B?NUR1akVOZDdtb29uME1HbmJ1N0RiN3UzeHlyemV4SG44WGhNY3lLT3B1Q1Q0?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D67D51BD75E154492B082A6DE7E3793@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dc0a8c-4f12-4091-b034-08daa5418712
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 13:16:48.3484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3BUleFuNduSccGwc5zJho2NSkIOuke8fmiIy0oLaFXlKUP1k2ouQaSSWxY51EC18i5HKO6fU6FB9yk57Dji5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4913
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTEwLTAxIGF0IDExOjQ4IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToKPiBu
ZnNkX2ZpbGUgaXMgUkNVLWZyZWVkLCBzbyBpdCdzIHBvc3NpYmxlIHRoYXQgb25lIGNvdWxkIGJl
IGZvdW5kCj4gdGhhdCdzIGluIHRoZSBwcm9jZXNzIG9mIGJlaW5nIGZyZWVkIGFuZCB0aGUgbWVt
b3J5IHJlY3ljbGVkLiBFbnN1cmUKPiB3ZSBob2xkIHRoZSByY3VfcmVhZF9sb2NrIHdoaWxlIGF0
dGVtcHRpbmcgdG8gZ2V0IGEgcmVmZXJlbmNlIG9uIHRoZQo+IG9iamVjdC4KPiAKPiBTdWdnZXN0
ZWQtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+Cj4gU2lnbmVkLW9mZi1ieTog
Q2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+Cj4gLS0tCj4gwqBmcy9uZnNkL2Zp
bGVjYWNoZS5jIHzCoMKgIDM0ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiDC
oGZzL25mc2QvdHJhY2UuaMKgwqDCoMKgIHzCoMKgIDI3IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1MCBkZWxldGlvbnMo
LSkKPiAKPiBUaGlzIGlzIHdoYXQgSSB3YXMgdGhpbmtpbmcuLi4gQ29tcGlsZS10ZXN0ZWQgb25s
eS4KPiAKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9maWxlY2FjaGUuYyBiL2ZzL25mc2QvZmls
ZWNhY2hlLmMKPiBpbmRleCBiZTE1MmUzZTNhODAuLjZlMTdmNzRmYjI5ZiAxMDA2NDQKPiAtLS0g
YS9mcy9uZnNkL2ZpbGVjYWNoZS5jCj4gKysrIGIvZnMvbmZzZC9maWxlY2FjaGUuYwo+IEBAIC0x
MDU2LDEwICsxMDU2LDEyIEBAIG5mc2RfZmlsZV9kb19hY3F1aXJlKHN0cnVjdCBzdmNfcnFzdCAq
cnFzdHAsCj4gc3RydWN0IHN2Y19maCAqZmhwLAo+IMKgCj4gwqByZXRyeToKPiDCoMKgwqDCoMKg
wqDCoMKgLyogQXZvaWQgYWxsb2NhdGlvbiBpZiB0aGUgaXRlbSBpcyBhbHJlYWR5IGluIGNhY2hl
ICovCj4gLcKgwqDCoMKgwqDCoMKgbmYgPSByaGFzaHRhYmxlX2xvb2t1cF9mYXN0KCZuZnNkX2Zp
bGVfcmhhc2hfdGJsLCAma2V5LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZnNkX2ZpbGVfcmhhc2hfcGFyYW1z
KTsKPiArwqDCoMKgwqDCoMKgwqByY3VfcmVhZF9sb2NrKCk7Cj4gK8KgwqDCoMKgwqDCoMKgbmYg
PSByaGFzaHRhYmxlX2xvb2t1cCgmbmZzZF9maWxlX3JoYXNoX3RibCwgJmtleSwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZnNk
X2ZpbGVfcmhhc2hfcGFyYW1zKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG5mKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmYgPSBuZnNkX2ZpbGVfZ2V0KG5mKTsKPiArwqDCoMKg
wqDCoMKgwqByY3VfcmVhZF91bmxvY2soKTsKPiAKClRoYXQgZGVmaW5pdGVseSBkZXNlcnZlcyBh
ICdGaXhlczonIGxpbmUgc28geW91IGNhbiB1bmJyZWFrIDYuMC4KCj4gwqDCoMKgwqDCoMKgwqDC
oGlmIChuZikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gd2FpdF9mb3Jf
Y29uc3RydWN0aW9uOwo+IMKgCj4gQEAgLTEwNjksMjEgKzEwNzEsMTQgQEAgbmZzZF9maWxlX2Rv
X2FjcXVpcmUoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwKPiBzdHJ1Y3Qgc3ZjX2ZoICpmaHAsCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9zdGF0dXM7Cj4gwqDCoMKg
wqDCoMKgwqDCoH0KPiDCoAo+IC3CoMKgwqDCoMKgwqDCoG5mID0gcmhhc2h0YWJsZV9sb29rdXBf
Z2V0X2luc2VydF9rZXkoJm5mc2RfZmlsZV9yaGFzaF90YmwsCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgJmtleSwgJm5ldy0+bmZfcmhhc2gsCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAKPiBuZnNkX2ZpbGVfcmhhc2hfcGFyYW1zKTsKPiAtwqDCoMKgwqDCoMKg
wqBpZiAoIW5mKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mID0gbmV3Owo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG9wZW5fZmlsZTsKPiAtwqDCoMKg
wqDCoMKgwqB9Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKElTX0VSUihuZikpCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gaW5zZXJ0X2VycjsKPiAtwqDCoMKgwqDCoMKgwqBuZiA9
IG5mc2RfZmlsZV9nZXQobmYpOwo+IC3CoMKgwqDCoMKgwqDCoGlmIChuZiA9PSBOVUxMKSB7Cj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mID0gbmV3Owo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBnb3RvIG9wZW5fZmlsZTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmhh
c2h0YWJsZV9sb29rdXBfaW5zZXJ0X2tleSgmbmZzZF9maWxlX3JoYXNoX3RibCwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICZrZXksICZuZXctPm5mX3JoYXNoLAo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbmZzZF9maWxlX3JoYXNoX3BhcmFtcykpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgbmZzZF9maWxlX3NsYWJfZnJlZSgmbmV3LT5uZl9yY3UpOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHJldHJ5Owo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gLcKg
wqDCoMKgwqDCoMKgbmZzZF9maWxlX3NsYWJfZnJlZSgmbmV3LT5uZl9yY3UpOwo+ICvCoMKgwqDC
oMKgwqDCoG5mID0gbmV3Owo+ICvCoMKgwqDCoMKgwqDCoGdvdG8gb3Blbl9maWxlOwo+IMKgCj4g
wqB3YWl0X2Zvcl9jb25zdHJ1Y3Rpb246Cj4gwqDCoMKgwqDCoMKgwqDCoHdhaXRfb25fYml0KCZu
Zi0+bmZfZmxhZ3MsIE5GU0RfRklMRV9QRU5ESU5HLAo+IFRBU0tfVU5JTlRFUlJVUFRJQkxFKTsK
PiBAQCAtMTE0MywxMyArMTEzOCw2IEBAIG5mc2RfZmlsZV9kb19hY3F1aXJlKHN0cnVjdCBzdmNf
cnFzdCAqcnFzdHAsCj4gc3RydWN0IHN2Y19maCAqZmhwLAo+IMKgwqDCoMKgwqDCoMKgwqBzbXBf
bWJfX2FmdGVyX2F0b21pYygpOwo+IMKgwqDCoMKgwqDCoMKgwqB3YWtlX3VwX2JpdCgmbmYtPm5m
X2ZsYWdzLCBORlNEX0ZJTEVfUEVORElORyk7Cj4gwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+
IC0KPiAtaW5zZXJ0X2VycjoKPiAtwqDCoMKgwqDCoMKgwqBuZnNkX2ZpbGVfc2xhYl9mcmVlKCZu
ZXctPm5mX3JjdSk7Cj4gLcKgwqDCoMKgwqDCoMKgdHJhY2VfbmZzZF9maWxlX2luc2VydF9lcnIo
cnFzdHAsIGtleS5pbm9kZSwgbWF5X2ZsYWdzLAo+IFBUUl9FUlIobmYpKTsKPiAtwqDCoMKgwqDC
oMKgwqBuZiA9IE5VTEw7Cj4gLcKgwqDCoMKgwqDCoMKgc3RhdHVzID0gbmZzZXJyX2p1a2Vib3g7
Cj4gLcKgwqDCoMKgwqDCoMKgZ290byBvdXRfc3RhdHVzOwo+IMKgfQo+IMKgCj4gwqAvKioKPiBk
aWZmIC0tZ2l0IGEvZnMvbmZzZC90cmFjZS5oIGIvZnMvbmZzZC90cmFjZS5oCj4gaW5kZXggMDZh
OTZlOTU1YmQwLi5jMTU0NjdiMmU4ZDkgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzZC90cmFjZS5oCj4g
KysrIGIvZnMvbmZzZC90cmFjZS5oCj4gQEAgLTk1NCwzMyArOTU0LDYgQEAgVFJBQ0VfRVZFTlQo
bmZzZF9maWxlX2NyZWF0ZSwKPiDCoMKgwqDCoMKgwqDCoMKgKQo+IMKgKTsKPiDCoAo+IC1UUkFD
RV9FVkVOVChuZnNkX2ZpbGVfaW5zZXJ0X2VyciwKPiAtwqDCoMKgwqDCoMKgwqBUUF9QUk9UTygK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IHN2Y19ycXN0ICpy
cXN0cCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGlub2Rl
ICppbm9kZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IG1h
eV9mbGFncywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbG9uZyBlcnJvcgo+IC3C
oMKgwqDCoMKgwqDCoCksCj4gLcKgwqDCoMKgwqDCoMKgVFBfQVJHUyhycXN0cCwgaW5vZGUsIG1h
eV9mbGFncywgZXJyb3IpLAo+IC3CoMKgwqDCoMKgwqDCoFRQX1NUUlVDVF9fZW50cnkoCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZmllbGQodTMyLCB4aWQpCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZmllbGQoY29uc3Qgdm9pZCAqLCBpbm9kZSkKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19maWVsZCh1bnNpZ25lZCBsb25nLCBtYXlfZmxh
Z3MpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZmllbGQobG9uZywgZXJyb3Ip
Cj4gLcKgwqDCoMKgwqDCoMKgKSwKPiAtwqDCoMKgwqDCoMKgwqBUUF9mYXN0X2Fzc2lnbigKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19lbnRyeS0+eGlkID0gYmUzMl90b19jcHUo
cnFzdHAtPnJxX3hpZCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZW50cnkt
Pmlub2RlID0gaW5vZGU7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZW50cnkt
Pm1heV9mbGFncyA9IG1heV9mbGFnczsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
X19lbnRyeS0+ZXJyb3IgPSBlcnJvcjsKPiAtwqDCoMKgwqDCoMKgwqApLAo+IC3CoMKgwqDCoMKg
wqDCoFRQX3ByaW50aygieGlkPTB4JXggaW5vZGU9JXAgbWF5X2ZsYWdzPSVzIGVycm9yPSVsZCIs
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZW50cnktPnhpZCwgX19lbnRyeS0+
aW5vZGUsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNob3dfbmZzZF9tYXlfZmxh
Z3MoX19lbnRyeS0+bWF5X2ZsYWdzKSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
X19lbnRyeS0+ZXJyb3IKPiAtwqDCoMKgwqDCoMKgwqApCj4gLSk7Cj4gLQo+IMKgVFJBQ0VfRVZF
TlQobmZzZF9maWxlX2NvbnNfZXJyLAo+IMKgwqDCoMKgwqDCoMKgwqBUUF9QUk9UTygKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAs
Cj4gCj4gCgotLSAKVHJvbmQgTXlrbGVidXN0CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UKdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQoKCg==
