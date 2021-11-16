Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E9B453394
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 15:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbhKPOGc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 09:06:32 -0500
Received: from mail-dm6nam08on2108.outbound.protection.outlook.com ([40.107.102.108]:40192
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237086AbhKPOGb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Nov 2021 09:06:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Prd14sjNDlTUTrzrB+rnaqQqY2jJhhjVMGym0pDtrM2gxB3Tn7ILPIVyyKQyGATCs2WpzHH+TQKmWU82aSc0tZbO0qg0nnLEnT1+XCsqJndepXhXxKoLV8YSZEbD5GnFkGERz8x2eu2zARmyVI03/Ft8gdElS2/qHT/9HvN4jgne59jKA6VrzcTtX1SiHIyG06JrHY209GJQBM4vAWiLWBo+s21rytE+HX7Y+3P0KhMR3ml7MZuDykBm8iS2oFNdNH25GiubHHtOoPiOlP2X5fscmUJf+6c/bS5rO3dLBKh+0BGV5FnzTjK5e50dWRBtN5M0gG61Y66ZGCpe8fqKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJe/cqHMnmqMxlcz5wUTy6uqJ2UXIwcaJ39G6KzuJp0=;
 b=MR4/drbgFk8Gx9jnsvhLMyI3fLt6zyZCMJ+kDhQ2XDAQ5RBafL8u+sVY6GAFjHF1pwMG7a9fs2Vomr0/ddI0KSWxQPE881detNllq5eHUq3Gh/gchNVoQXWhfbeICEnkM4m1uIQiR7Yi8z4LMoSPTWirr3G21vjSY59EaNfShfFGa89ggTorOBvPtTL4k8tbi3sisod+LmPZrinZZBjeZLhzvURAt9quHlI55D7PkY2SWfuD9uT2kXdOwbnYklVC2n6F3+yEsF5re1jQdbT179RLUGhrmPcO7vU3V6EQP+imWRkn7YYKvz/crYIdw18z+JzjkwswehYbJvxVwX2YUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJe/cqHMnmqMxlcz5wUTy6uqJ2UXIwcaJ39G6KzuJp0=;
 b=LmmPwql1tC/+7wDdZynHlg/+y/Od7qkMMv4+d/fSUb7oy17WcygVRok59tyDr7Kx15sQ/Ez48S3/kZ3cmtgb5GGLZa8IegZ2sPiUvyrD9nCPWtn+2KDut/BiXMwFwxF+LoVwHWiq/V73nrSgsaik2EwP2gTTedPSAuUqa055lPA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5187.namprd13.prod.outlook.com (2603:10b6:610:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.18; Tue, 16 Nov
 2021 14:03:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 14:03:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] NFSv42: Don't drop NFS_INO_INVALID_CHANGE if we hold
 a delegation
Thread-Topic: [PATCH 2/3] NFSv42: Don't drop NFS_INO_INVALID_CHANGE if we hold
 a delegation
Thread-Index: AQHX2vDLUMHGAI80skqH9d4qS3nyMKwGL5YA
Date:   Tue, 16 Nov 2021 14:03:32 +0000
Message-ID: <a06d3d97a865747058c7d1cbcd4f70911c336fce.camel@hammerspace.com>
References: <cover.1637069577.git.bcodding@redhat.com>
         <c91e224b847e697e42b25cdc36cd164a61ad1ade.1637069577.git.bcodding@redhat.com>
In-Reply-To: <c91e224b847e697e42b25cdc36cd164a61ad1ade.1637069577.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dac3f437-8d3e-4f49-2960-08d9a909dfc5
x-ms-traffictypediagnostic: CH0PR13MB5187:
x-microsoft-antispam-prvs: <CH0PR13MB5187BC393DFA3AABD1416DF0B8999@CH0PR13MB5187.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3wZPv+sFOJ683wyJAFnraphW3V83QCPg8wRGcODlLnSLNyPthJz9HI/n4njEggqnXeisbOmn5vn4Tf47mRQdh9XRjngJkGBLlVK9lPmqwOB+h1FijszMmI2SfTND/otlo5ReTb0RdAuCz+iezEJucLQOzjh8EhFtU0u3uv+bpCIyGCybPQjgrWcNQ8ugp14gSSs6O/XISTX0ZCzHVpwGuoNcwaSYugq40j7MnPtQHAMYG0XwaFSaxSVYr6WRNz/qhFoxt1QpeH4CtcJZyPp+/FOklyhbNHm8QNtxFYBC3y/MSvLdiBU0afcdPQXc3KmjcuREkdvS03etEE1P+elhGzq/7zfepip3yOIboBWhu8f2sJPNo/BkduDoNKPzwZm5cSjDSGaO2L6YpsaG2oKBL9cqqC1r5I/7+jjvjMd+oSFPwD7nsfI9yh3ofaoVZKTKd4ma8R1H9tH4ltLR/u48D6CPNPzdbseS/al4cADD36YtUuJjIq+ep8m9NPIvs8GD1y7BRjXceybiiPBEVBp5s0RBJzylYpNL0ZtdhJDR73qLZPbFmnnUIG0JJHwtNWSQTCyv1BMmhisbjuQRcpJFGKTbmwY0kuNj8d7VfAECY8/s0Hinw6dVr3v0gf6MgcIC1ZGzYc7JN8D8je0sA62lFD3uHBRNuoDR80gRbAFVUpCLlsC0m3FteT0FXoXbsTxJk3AF59/WW/C0j4GbK5IXPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39840400004)(376002)(4001150100001)(5660300002)(36756003)(508600001)(83380400001)(8676002)(26005)(6512007)(86362001)(66946007)(110136005)(66446008)(64756008)(122000001)(38100700002)(76116006)(66556008)(8936002)(2906002)(186003)(38070700005)(6486002)(66476007)(71200400001)(6506007)(4326008)(2616005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkkrUHVYTTMxWVozLzVObzhlTzRBWG9COUNodDYzM3l6QjVkZ3BSeFA0WnlL?=
 =?utf-8?B?bVBLWnZsdlY2RERsNWlhYU9oU2gzcFRrTEV5WTRObjlTQjIyVGE3Y3NTZER0?=
 =?utf-8?B?M2hod2pMbGgrOXNlNkV4T0VDbW1wTEY3cHEwUnpYRlpjMzllRnl1aVFjRFN4?=
 =?utf-8?B?SGd5ZXY0c0t4ZUVXcTVPWC82RXVtUCt5M3RHV3pvWTNUcVZZL1kyUnAzOTNY?=
 =?utf-8?B?ZlZwcDRaWTBvR3AvS2drUElteFR4Q0FEV09FTnpmUFRrZUcwOE9Hc1NOSGto?=
 =?utf-8?B?ZG1kQ21xWWhya3BKQk1WTVlTRFQ4Uy8xeWd3MnBla0laamZ3dHpCQXZDUXM5?=
 =?utf-8?B?ck9PSWVCM1Q3clFocUxVSU45azN4cGs4bEtEdWdwTmZsMkcxVmZTYTNyUVJv?=
 =?utf-8?B?eTBZSGhiVUVLcnd0d2V0d0V5TVhTUk81MHRzMHoyOWdKcHFBZFBFVVozRkZY?=
 =?utf-8?B?bm5FSGZmMEI2bUtYWDZLQ3NqcHNiWW12ZmI5ZzVEZmtMYmpscjZ2SGdmMlRi?=
 =?utf-8?B?MlB1OHBIMmNQTk9qTXY3cUR1aWliNkxLcnFDUzgwYkVtTm9BT2FXMWZPKzlJ?=
 =?utf-8?B?eWRjV1lkdk1ydUc2SUVlY3Z5ZXA3TGlyK2NadTdUZ1hwdHF6YlRVa2ZqQTMv?=
 =?utf-8?B?UTNVNnBHSFZ1OFlLM2tyUjFnMExhU3lHVGVhUjNFZS9UeG41aDUvNktNTFFW?=
 =?utf-8?B?NUNETzJxeEpaRDJjWGJEM0JZMk1vWE9XVWVjSjB1elNSblNPL2JaYW5wZllN?=
 =?utf-8?B?UGhVOW1PejRMaHR0ZnUya0JwZFdPSmpGSXlONW15ZjMzYWJjY3ErK21FZmMr?=
 =?utf-8?B?STAvYWRjaHZhYUR6M0xra2h6cmhwQWtyaVA5bXdlTndUSVRua0N6SXo4UjBH?=
 =?utf-8?B?c2QxcmM1eGthdmkrbTB6N09Gd21sSDVBRlZGYUdBZGJwaTNBSUtqeEZQVlIw?=
 =?utf-8?B?S0N5VkpMK2Q0YTRKTGFlMnN5cjhpVFNwV2ZSbGU2S0lkU3FLR3FaWUo3OUlT?=
 =?utf-8?B?ckVGNnlVUnJtaTRVbWgvTThBVXpmUUxGWERqSzhHejA4RFYxd1dwYUxvczdQ?=
 =?utf-8?B?M3U5NTNxb0ZubVNhTnlac1hKcC9TczBVWjE2Y1QySmFILzJGYlN3VmttSVlr?=
 =?utf-8?B?MWpCL0RQNlhoMFhHN2ZIK0VkQStjN3l2UURua0IyeVVNV3ZNcGQrakZ5VUdX?=
 =?utf-8?B?clZEY3RiNmRTL2QwQnRQZklKdjhZYitmMUZwNDFsWVl1b1I3SVY2Qk02SmIx?=
 =?utf-8?B?dlNhdVpqaWRCampVdXhhRUtWaXRYQnhhelBibS9hSnRmTFBwOVZkNGRyaU9R?=
 =?utf-8?B?ZFJ6R2cwbzdDT1NFZlU2ZmFXcWJXZmpzT0pydCtCaXZVZzlzTjZjUWRxaWg0?=
 =?utf-8?B?OExERzFIRWpYdmQwSjY5b1BtekRoa29RQ3ZueEM0cjV5aDg0SjdRWStHR1Ra?=
 =?utf-8?B?VXJWSDNVWnJDcVU5aldMUFYxcGZnRENjL25Jbm1kY1lUbk14TDFrRURodklt?=
 =?utf-8?B?bkZhNUdYR1dwUFRNeGNqem5xTmhrMmhBVmRwMStweEJsT3dZNlV4cEJ1NWZP?=
 =?utf-8?B?T1kzcEJ3MzFtZllvekJIc1hMR3paeFQySVVhWWxaSnZPdEtoZ3JUMCsxNVdX?=
 =?utf-8?B?QXAvUkJKWnFHQVpJUVNUaG8xb0UwNHd2OTVrT2tsOFdibU5ROWozaExkN2tr?=
 =?utf-8?B?dkhaMUxOT0wralBkMGZhZEtpR1R1OThJRkE0WjdsMFNjM1lPaDlCR3M2UGlz?=
 =?utf-8?B?YTdqTkZpd1NIZHdDRm1KckFvZWZEQzZGa1lXRDJCb2JORHd3VTZZb0EyaUVY?=
 =?utf-8?B?MTNWNzNQLzQ1QkREWHMwU0l4TFlVemx1eG11QXJZODEwZU1VQ0hwRzhQbmQ1?=
 =?utf-8?B?QU4yT3p2MFlBWnRUeXUrYmUxcUZtdWRyYm1JcDdJbVo5Q0VJMjdJMWNINWov?=
 =?utf-8?B?QktVSFF1blJuU2RpTDU0NjN1dyt4WVdpVkR1YVk4eXpsWGtBeWU5dFQ4MEZQ?=
 =?utf-8?B?cmxiQm0rWUJQUFNNVnYvQURXODkyMVI4ZVpSY2RVaGMzdG9iT0hLcXh1RTR6?=
 =?utf-8?B?Q3ZBK0dFcldGbW1BM1pYd1A1MTgyc1NqTll6emJrTjB2a2lDTE9UUU0zeWFo?=
 =?utf-8?B?YzFYbnFxbFFoaWVFNzhxYWlUR1dJMGhBSndCUWNmbWZCQWJSYVVYZXZTcVpw?=
 =?utf-8?Q?1RiwYdlGNq0dV6QSlqNtDEM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <254A306756EC1C429D6FF5356DF62901@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac3f437-8d3e-4f49-2960-08d9a909dfc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 14:03:32.2560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giTP95qDymW8IwAOAutSTzbLrf4VmBENMXjI2ECQ85hdZ0hE/ethr56iDtK4rXlvl3BQB2PpUVisvlcCpX8IXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5187
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTE2IGF0IDA4OjQ5IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOgo+IFRoZSBuZnNfc2V0X2NhY2hlX2ludmFsaWQoKSBoZWxwZXIgZHJvcHMgTkZTX0lOT19J
TlZBTElEX0NIQU5HRSBpZiB3ZQo+IGhvbGQKPiBhIGRlbGVnYXRpb24sIGJ1dCBhZnRlciBhIGNv
cHkgb3IgY2xvbmUgdGhlIGNoYW5nZSBhdHRyaWJ1dGUgY2FuIGJlCj4gdXBkYXRlZAo+IG9uIHRo
ZSBzZXJ2ZXIuwqAgQWZ0ZXIgY29tbWl0IGI2ZjgwYTJlYmI5NyAiTkZTOiBGaXggb3BlbiBjb2Rl
ZAo+IHZlcnNpb25zIG9mCj4gbmZzX3NldF9jYWNoZV9pbnZhbGlkKCkgaW4gTkZTdjQiLCB0aGUg
Y2xpZW50IHN0b3BwZWQgdXBkYXRpbmcgdGhlCj4gY2hhbmdlCj4gYXR0cmlidXRlIGFmdGVyIGNv
cHkgb3IgY2xvbmUgd2hpbGUgaG9sZGluZyBhIHJlYWQgZGVsZWdhdGlvbi4KPiAKPiBXZSBjYW4g
dXNlIE5GU19JTk9fUkVWQUxfUEFHRUNBQ0hFIHRvIGhlbHAgbmZzX3NldF9jYWNoZV9pbnZhbGlk
KCkKPiBrbm93Cj4gd2hlbiB3ZSByZWFsbHkgd2FudCB0byBrZWVwIE5GU19JTk9fSU5WQUxJRF9D
SEFOR0UsIGV2ZW4gaWYgdGhlCj4gY2xpZW50Cj4gaG9sZHMgYSBkZWxlZ2F0aW9uLgoKTm8sIHdl
IHJlYWxseSBzaG91bGRuJ3QgbmVlZCB0byBjYXJlIHdoYXQgdGhlIHNlcnZlciB0aGlua3Mgb3Ig
ZG9lcy4KVGhlIGNsaWVudCBpcyBhdXRob3JpdGF0aXZlIGZvciB0aGUgY2hhbmdlIGF0dHJpYnV0
ZSB3aGlsZSBpdCBob2xkcyBhCmRlbGVnYXRpb24sIG5vdCB0aGUgc2VydmVyLgoKPiAKPiBGaXhl
czogYjZmODBhMmViYjk3ICgiTkZTOiBGaXggb3BlbiBjb2RlZCB2ZXJzaW9ucyBvZgo+IG5mc19z
ZXRfY2FjaGVfaW52YWxpZCgpIGluIE5GU3Y0IikKPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBD
b2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPgo+IC0tLQo+IMKgZnMvbmZzL2lub2RlLmPC
oMKgwqDCoCB8IDQgKysrLQo+IMKgZnMvbmZzL25mczQycHJvYy5jIHwgMyArKy0KPiDCoDIgZmls
ZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1n
aXQgYS9mcy9uZnMvaW5vZGUuYyBiL2ZzL25mcy9pbm9kZS5jCj4gaW5kZXggODUzMjEzYjNhMjA5
Li4yOTZlZDhlYTMyNzMgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzL2lub2RlLmMKPiArKysgYi9mcy9u
ZnMvaW5vZGUuYwo+IEBAIC0yMDIsNyArMjAyLDkgQEAgdm9pZCBuZnNfc2V0X2NhY2hlX2ludmFs
aWQoc3RydWN0IGlub2RlICppbm9kZSwKPiB1bnNpZ25lZCBsb25nIGZsYWdzKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZsYWdzICY9IH4oTkZTX0lO
T19JTlZBTElEX01PREUgfAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5GU19JTk9fSU5WQUxJRF9PVEhFUiB8Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgTkZTX0lOT19JTlZBTElEX1hBVFRSKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZmxhZ3MgJj0gfihORlNfSU5PX0lOVkFMSURfQ0hBTkdFIHwKPiBORlNfSU5P
X0lOVkFMSURfU0laRSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghKGZs
YWdzICYgTkZTX0lOT19SRVZBTF9QQUdFQ0FDSEUpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZmxhZ3MgJj0gfk5GU19JTk9fSU5WQUxJRF9DSEFOR0U7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZsYWdzICY9IH5ORlNfSU5PX0lOVkFM
SURfU0laRTsKPiDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIGlmIChmbGFncyAmIE5GU19JTk9fUkVW
QUxfUEFHRUNBQ0hFKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZmxhZ3MgfD0g
TkZTX0lOT19JTlZBTElEX0NIQU5HRSB8Cj4gTkZTX0lOT19JTlZBTElEX1NJWkU7Cj4gwqAKPiBk
aWZmIC0tZ2l0IGEvZnMvbmZzL25mczQycHJvYy5jIGIvZnMvbmZzL25mczQycHJvYy5jCj4gaW5k
ZXggYmJjZDRjODBjNWE2Li5mYzNjMzZlMWY2NTYgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzL25mczQy
cHJvYy5jCj4gKysrIGIvZnMvbmZzL25mczQycHJvYy5jCj4gQEAgLTI5Miw3ICsyOTIsOCBAQCBz
dGF0aWMgdm9pZCBuZnM0Ml9jb3B5X2Rlc3RfZG9uZShzdHJ1Y3QgaW5vZGUKPiAqaW5vZGUsIGxv
ZmZfdCBwb3MsIGxvZmZfdCBsZW4pCj4gwqDCoMKgwqDCoMKgwqDCoHNwaW5fbG9jaygmaW5vZGUt
PmlfbG9jayk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChuZXdzaXplID4gaV9zaXplX3JlYWQoaW5v
ZGUpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaV9zaXplX3dyaXRlKGlub2Rl
LCBuZXdzaXplKTsKPiAtwqDCoMKgwqDCoMKgwqBuZnNfc2V0X2NhY2hlX2ludmFsaWQoaW5vZGUs
IE5GU19JTk9fSU5WQUxJRF9DSEFOR0UgfAo+ICvCoMKgwqDCoMKgwqDCoG5mc19zZXRfY2FjaGVf
aW52YWxpZChpbm9kZSwgTkZTX0lOT19SRVZBTF9QQUdFQ0FDSEUgfAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBORlNfSU5PX0lOVkFMSURfQ0hBTkdFIHwKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIE5GU19JTk9fSU5WQUxJRF9DVElNRSB8Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBORlNfSU5PX0lOVkFMSURfTVRJTUUgfAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgTkZTX0lOT19JTlZBTElEX0JMT0NLUyk7CgotLSAKVHJvbmQg
TXlrbGVidXN0CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UKdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQoKCg==
