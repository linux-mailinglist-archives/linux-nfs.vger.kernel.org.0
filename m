Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09A5A8826
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 23:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiHaVeG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 17:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiHaVeF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 17:34:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3DAD83C9
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 14:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIGTQ1nDqNlXJyHoUSGItgYCe3aTOuQjzkjf8ezg17Tk0xejZUDb2oEiw9RKVECCAZE8EmQZS9ASIcBoSsInyjs3hNfvL8eUBY7Wq+9Grbc01ibOEhtG5S7fDIz49aksLzVnAlcOfnZsjIS7VbDnyvgk6JP6wqyM5jusFzet6jL2U29HZGMcePFSkzNDQbHyKT8hf5vI5FNRM2xmUG7cAYiRpma8LT2aRKfkrXdmbefJkHOt4U5nxwzkcg5yrrgM2rol3YwfkJsTdMzUIRwqa5iByliOxMBsBAbqiXoZvBFONS8et5+h82S/nH0TKxINvhWSbU1MGmiAkO6brA+6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMTtIVALu99f8TfaUvUkc3R4jd3Ba+bR5IQAWgC4CwA=;
 b=BtpMhvPhda9qtFMoNkYrKAnfo8OqgLhIbC9SocrE4OmsyaLQRleJn3mKnD9yKrShUA5S4xqHP1djj5LTGu5YwiSM6iJi34aIARmdmXWeUXDQXs5d4T/7ooKUIXi4CJvTRgb50FJE7ohVmxmYSfL6188CCdwwTxA/rIusmictv8gq7/rMy2xyM/N/ZB6Ykm9gVT6XxrVeNTQeprXfmLULT0jl216d3H9zE9cY0xAAIOVRnhFaFJJuZAWHPLzB/SGEhHEQ16/Gfd1JS+qpg/Y5pCxnm24FFYFRuZq/DA76SY8SBalqxq6OUdm/XLLK8WkJKQjs1QTdYfPZqhWrmgzDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMTtIVALu99f8TfaUvUkc3R4jd3Ba+bR5IQAWgC4CwA=;
 b=fL4hm56XZ7ULnizZv7WQfCskuMg00q5ZxDev3VgMuClCaAuFstC760GWb0I5gzb+itKw/sKIfFiNE92ceol1CrSnPngKOG4O27MSUAUD1vw6LtJaSBdmdwzaQS65c55EBJ9nzBXjwi4dwHQaGaU75/zpfhpL425rtJgJEhYqdcw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB2874.namprd13.prod.outlook.com (2603:10b6:5:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 21:34:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 21:34:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: client call_decode WARN_ON memcmp race since 72691a269f0b
Thread-Topic: client call_decode WARN_ON memcmp race since 72691a269f0b
Thread-Index: AQHYvXcxZmAk8aoraUaCg1gjDhO8pK3Jh9MA
Date:   Wed, 31 Aug 2022 21:34:00 +0000
Message-ID: <24350372a2a5cb244bc843faef569404088f9278.camel@hammerspace.com>
References: <6806AB48-F7D6-4639-8D03-E31BA25C4CF3@redhat.com>
In-Reply-To: <6806AB48-F7D6-4639-8D03-E31BA25C4CF3@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8def509d-e9e8-48c6-4a5b-08da8b9884a4
x-ms-traffictypediagnostic: DM6PR13MB2874:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23b7mjXIPGr0A9eKadyO/8eA8FkN7KsIz3eBifEO54wYnLjzs37sGqe0zGJodeay6JfKtn1uM/TjgxOQG/qRi4KtnFWIlWNUiutNMvpOHVMOaJne7oeJ3CxmExItr/+4xLcfr7sKyEaV8ztwtNHrbYDW248LSOMvRfi/vJCrbSvQvc54swsd/cMz6x9r+/2T6Kiolyv2o84uX2LzEWF2eg8R2qBGb7WDJ0ndGfvbzBnztX3d36weMhq0GpOz0sXz8BDEoaLRvqU1DIh719jNRreZfHyyPDZ8c79W1A6qYr6dL4DgxvDr5rRY9mySyUp1pYijGj0J3O/+kfOmt/wA76CXz5clY/JYgs7JAabYdnZlv0mWEy5EYVELL2Kp8D4ZE5CSIb0qr1ntUVxVN64yAZhTsZHmNiQrgUXL1/lUG3Su0NEU5YQ2I1ML7zI7Ky7vvGiAUw/q0iTQunATYXUbHgie0nOggFWOKEVfY2wfYLzzWKV2WuJSu5+TnnM4zadanvsW1AO6zJSxhYh6rxzVyprft/wA4v2b6/3qOcwK0h1Xv4XlfTzlFWCxU2avUNG3owwKxnZrl+6dS1YDxnAeARi3DzK2ejbLBOTDEpXqcFpa82SPY1mQmg/fwAWjoRnoGlJonSHrS7415rQTUnKb6iMDNBTpaphgJvt5q6q7OCZwjPYk6W2ceO2sKSmjFOWAxNQcZn9AX4zOtm4yowgx0oTCZvcz/WPYMBThjmiu5MwaizKv9Nxm/q5vUwi2rnVe5b5R7I53+wzDzX9ulaRlds+TYdHGmIIpa1C2vL2htyaZ4Z3tfvibH3w8zUV13nDu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(396003)(366004)(376002)(346002)(136003)(122000001)(38100700002)(41300700001)(5660300002)(8936002)(38070700005)(86362001)(478600001)(6512007)(53546011)(8676002)(26005)(76116006)(64756008)(66446008)(66556008)(66476007)(6916009)(66946007)(36756003)(186003)(6486002)(4326008)(2616005)(6506007)(71200400001)(2906002)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0JYZFI0VWlKWGZrM29LZzMvaURoems0WHR1Uy85ZWQxQUIrMjFmVWo2QXRR?=
 =?utf-8?B?cTR6Mm8xelY5aS9kQTR1aFNEdVlPZkNPUzNwMHU5czBLR1BnOS9welpCNnM5?=
 =?utf-8?B?eWNuakRSVmxENFdHcFpSYk5lSW9XcCtWQ1BYUzkxWDRSMm9yMm9Cb0hNY0Nm?=
 =?utf-8?B?eXVWSTB6eC9SZE8xK2xZb2hLcmFxZW9qTWhhSEpaaGJSM3BmeFlWcHgrc0RX?=
 =?utf-8?B?RkJwYmEvUW1lNnh3NFljRytFVzhQQWprTDZCbUVyMXNvaXJpUGdZOU16L0xI?=
 =?utf-8?B?TlZBcmJ0R3lVaDdLZWZjVGhFd2J1c2sxMjVTU3BLSFNYeG5GS0YwVEp5TmZP?=
 =?utf-8?B?T1R1eUt1enRNTlZ5Ukt3R1h4Q0ZFS2cxU0h1NUFhSGZkaDNGREpPQ3ZWQ25X?=
 =?utf-8?B?Zk9YVXc0M1EzY29BRWpWMUpSN1kvQXN6Nnp6ejdsK2hWUkkwZnZlYXhudkxO?=
 =?utf-8?B?dUloNUxuOW12ZzFGRERwN0tBL2dHWUFPY2lpeDJDRDN0VWZDUWxwNXl5Tm5t?=
 =?utf-8?B?UjMyOC9hangrZitid0NNcFZ5azMwRGh2Mm4xVTFoNkRnNWQ2SVcyYmdNWlpV?=
 =?utf-8?B?ek5ZMFRWUnByNkVuS3NtaG5oSnFGRnFWT3IzZHI4eDdFU1hxN2Q4WFZNbzJz?=
 =?utf-8?B?NTN6OFNkSXpWK1dpeFRMdzNUVXYxdzE2T2hwNDgrSFlYUVFsSytFUWFFQVRP?=
 =?utf-8?B?clFDVkhjMFYreE9mVWhEU2FDRjBvK2hBa20vRHRiYlpqbUNKVE1FWjdJaXdR?=
 =?utf-8?B?UndNbURJYWVQMzFDa1I1RDF1Y1UyektpRFJ1VWx5SDI0WEhPY2tMRmF4NFhO?=
 =?utf-8?B?SjR2aXlsUm5taUJzUENzTXhKVFl0eUVZNm5iTExSbXJ3QmxYU0lsc0lUTVY0?=
 =?utf-8?B?Q3JyQjI5cEJTRHJFdEdaZWFMY0JNWkF1RXRtTWVsdHFRdGdBM1kvM3llSm9N?=
 =?utf-8?B?ejdJNmlhRUMzQTNkK29mbEI1ZGNRc0pNMExWQkE5cXE2b0FGaHhBUW5vbm5D?=
 =?utf-8?B?blcvUmNwNDFBQSt2NTBDWjBvTVlJU0xQcXRGVUJvN2VTQnlvcUEyS0VTTEd5?=
 =?utf-8?B?ZCt1aUJjUDd3cXc1TFhocVFaSXJwVjcyai84eHVkcHpCR09ES2V3Y1FPS3Nu?=
 =?utf-8?B?clAwVHJoT2ZnY2ZMcjMvRXlCYXpWQ3BuSzA2cTNzY0tNRGpWRmFiWEcwc1Bk?=
 =?utf-8?B?VDZkOTNmNVdVUk02c1NMMzBXS3QxWlZpVGpFaEp4T3llYjFEelpUSlpaelpV?=
 =?utf-8?B?ckNNckFnaEREMldScjJJZG1GekR3OGJtdXg4MGJYWmMvaUg4UXczcjdnL3N5?=
 =?utf-8?B?cEtsc0hHbnlrWHdiSm4zY3lYSDFnQU5Wb1JrMjFlbitJYmhrZkhmUHdiTzZ2?=
 =?utf-8?B?VUV4cEp5Y2hKRTBjS0pPYlU5VTFHT1hVcklFRDA0TWljSTNuOWhZTjVBTUo2?=
 =?utf-8?B?UEFuZ0hSZThyVmVrWG5aWEJDckRPdC8zUWZ2cFJGWVVrZDN6RHdZbFM5SWpH?=
 =?utf-8?B?VGEwd3A0WE5id0RscmRaeXhmSFlHT0R4T0QvVjJPaFRLdTJtdGsyR3VaRG45?=
 =?utf-8?B?emdnc1doc2J6UW81ZmZTMmhaeEg3SE5Ua25VTlVRQ3E2OGcxcHdWZnZ4S0F6?=
 =?utf-8?B?ZUM1UGpydUhrNk12N2xtYUFXdC82RFkrMmpsTmFaa1ZYaitrOE1uVHdaRHlY?=
 =?utf-8?B?RU1yNDJ6YTBFZE5lQlFOcnQ0VUtyUWkzZS9jb0NVcWNnamdtdFFLbmwzRDlF?=
 =?utf-8?B?NUFzc1poNitaMnU0WmNhTmx5WDJvbFBtYkYvL0xNa1JmVHZDR0UvYlpaNFJX?=
 =?utf-8?B?ZVBGNEV1ekRnQ2pESCt6cTdxSXUzbHNhVVJrcGU1WEhic3MyNXhKbE4zMlV1?=
 =?utf-8?B?YnVYb0RzMXpjQVRpK0VRYytCNHBnRG92aWRVSWJIcGlBbWk4RDYxR2xFQTRx?=
 =?utf-8?B?Vy9Xb3FtU1Z2cFh1Nk1RT2psWVB3b2IrdmZxYTU4OWFxVGN6eVl6VjE3KzVk?=
 =?utf-8?B?dzZ2d3NMZXRXRXBLazFYSW1vV2V3Tm9vMkZMejlmeWZGMENydXB6STFqUEY2?=
 =?utf-8?B?THpJdkRrNWhzV2o1aWkwZkVrSms0cTRUV0pMOExVZFdycVRUbzhsVkRvbHZ4?=
 =?utf-8?B?SlpPKzBvZGdtcFdlenVjM1FUTDRiV1VjVlFZaUVTb2lqR0hydldHMjRkWFVm?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2211D6EB4D1BBA409337D2DD5CE18266@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2874
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTMxIGF0IDE2OjIwIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBIZXkgVHJvbmQsDQo+IA0KPiBTaW5jZSAiNzI2OTFhMjY5ZjBiIFNVTlJQQzogRG9u
J3QgcmV1c2UgYnZlYyBvbiByZXRyYW5zbWlzc2lvbiBvZiB0aGUNCj4gcmVxdWVzdCIgSSBjYW4g
c29tZXRpbWVzIHBvcCB0aGUgV0FSTl9PTigpIGluIGNhbGxfZGVjb2RlKCksIHVzdWFsbHkNCj4g
b24NCj4gZ2VuZXJpYy82NDIuDQo+IA0KPiBJIHRoaW5rIHRoZXJlJ3MgYSBrd29ya2VyIGhhbGZ3
YXkgdGhyb3VnaA0KPiANCj4geHBydF9jb21wbGV0ZV9ycXN0KCkgLT4NCj4gwqDCoMKgwqDCoMKg
IHhwcnRfcmVxdWVzdF9kZXF1ZXVlX3JlY2VpdmVfbG9ja2VkKCkNCj4gDQo+IGJldHdlZW4gdGhl
c2UgdHdvIGxpbnNlOg0KPiDCoMKgwqDCoMKgwqDCoMKgIHhkcl9mcmVlX2J2ZWMoJnJlcS0+cnFf
cmN2X2J1Zik7DQo+IMKgwqDCoMKgwqDCoMKgwqAgcmVxLT5ycV9wcml2YXRlX2J1Zi5idmVjID0g
TlVMTDsNCj4gDQo+IEFuZCBhdCB0aGUgc2FtZSB0aW1lIHRoZSB0YXNrIGlzIGRvaW5nIHRoZSBX
QVJOX09OKG1lbWNtcCgpKSBpbg0KPiBjYWxsX2RlY29kZS4NCj4gDQo+IEknbSBub3Qgc3VyZSBv
ZiBhIGdvb2QgZml4IC0gcGVyaGFwcyB3ZSBjYW4gZml4dXAgdGhlIG90aGVyIHBhdGhzDQo+IHRo
YXQNCj4gcmVxdWlyZSB0aGUgTlVMTCBjaGVjayBpbiB4ZHJfYWxsb2NfYnZlYygpIHNvIHdlIGRv
bid0IGhhdmUgdG8gc2V0DQo+IGJ2ZWMgPQ0KPiBOVUxMLg0KPiANCj4gQW55IHRob3VnaHRzPw0K
PiANCg0KSG93IGFib3V0IHRoaXM/DQo4PC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCkZyb20gNzUyMzkwOGI4N2VkZjI0NTk5NGIyMTMxMDhlMmNlNDUxZjYzNTI5ZiBN
b24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCkZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCkRhdGU6IFdlZCwgMzEgQXVnIDIwMjIgMTc6Mjg6MTMg
LTA0MDANClN1YmplY3Q6IFtQQVRDSF0gU1VOUlBDOiBGaXggY2FsbCBjb21wbGV0aW9uIHJhY2Vz
IHdpdGggY2FsbF9kZWNvZGUoKQ0KDQpXZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSByZXEt
PnJxX3ByaXZhdGVfYnVmIGlzIGNvbXBsZXRlbHkgdXAgdG8NCmRhdGUgYmVmb3JlIHdlIG1ha2Ug
cmVxLT5ycV9yZXBseV9ieXRlc19yZWN2ZCB2aXNpYmxlIHRvIHRoZQ0KY2FsbF9kZWNvZGUoKSBy
b3V0aW5lIGluIG9yZGVyIHRvIGF2b2lkIHRyaWdnZXJpbmcgdGhlIFdBUk5fT04oKS4NCg0KUmVw
b3J0ZWQtYnk6IEJlbmphbWluIENvZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQpGaXhl
czogNzI2OTFhMjY5ZjBiICgiU1VOUlBDOiBEb24ndCByZXVzZSBidmVjIG9uIHJldHJhbnNtaXNz
aW9uIG9mIHRoZSByZXF1ZXN0IikNClNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCi0tLQ0KIG5ldC9zdW5ycGMveHBydC5jIHwg
MiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0LmMgYi9uZXQvc3VucnBjL3hwcnQuYw0KaW5kZXgg
ZDcxZWVjNDk0ODI2Li43OTI2NWVlMjVkMDUgMTAwNjQ0DQotLS0gYS9uZXQvc3VucnBjL3hwcnQu
Yw0KKysrIGIvbmV0L3N1bnJwYy94cHJ0LmMNCkBAIC0xMjIxLDEyICsxMjIxLDEyIEBAIHZvaWQg
eHBydF9jb21wbGV0ZV9ycXN0KHN0cnVjdCBycGNfdGFzayAqdGFzaywgaW50IGNvcGllZCkNCiAN
CiAJeHBydC0+c3RhdC5yZWN2cysrOw0KIA0KKwl4cHJ0X3JlcXVlc3RfZGVxdWV1ZV9yZWNlaXZl
X2xvY2tlZCh0YXNrKTsNCiAJcmVxLT5ycV9wcml2YXRlX2J1Zi5sZW4gPSBjb3BpZWQ7DQogCS8q
IEVuc3VyZSBhbGwgd3JpdGVzIGFyZSBkb25lIGJlZm9yZSB3ZSB1cGRhdGUgKi8NCiAJLyogcmVx
LT5ycV9yZXBseV9ieXRlc19yZWN2ZCAqLw0KIAlzbXBfd21iKCk7DQogCXJlcS0+cnFfcmVwbHlf
Ynl0ZXNfcmVjdmQgPSBjb3BpZWQ7DQotCXhwcnRfcmVxdWVzdF9kZXF1ZXVlX3JlY2VpdmVfbG9j
a2VkKHRhc2spOw0KIAlycGNfd2FrZV91cF9xdWV1ZWRfdGFzaygmeHBydC0+cGVuZGluZywgdGFz
ayk7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKHhwcnRfY29tcGxldGVfcnFzdCk7DQotLSANCjIu
MzcuMg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
