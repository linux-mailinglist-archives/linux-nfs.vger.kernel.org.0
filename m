Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8D562194
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jun 2022 20:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiF3SBO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jun 2022 14:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiF3SAl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jun 2022 14:00:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD739175
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 11:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeNHe/miRDaQ9mSNH6gbdRqGPemqszKTWk3Dw0QXqQRBDB8JKOwm2ms3Zt+Qn9H0GthTo1RqOpSdy2XSoYOtQvVDvqdw12HefqYPa+j2DQ4P291EcW/hXQWgvA8dzadH1Z9swHnqQTegjZDRQztidT7gdJP+K3CBk61eNeAwg3RpmuPCwjYieAd+mkk8EO/dbKD5F0lDLdjs/5d8rhrjljpwnNLun7bwOsCf/CYIwYkzbAG8/NpZzai7SBjE0UvuZ5APha6lolSYltPpvGvl3OZcva7IdmcgJn1iaFCkzu4o0VK2xwVTDzEJ45w5jFJBar7z2gI43ri2xIBLCvXyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HevN41lsT0c1WBu632PPAbV0D13xQNIYlS8z3OTRv1E=;
 b=GgE+60ACSd9/x3Y7wzzEnbcY6k43STnpSA8yRtyFe/6ZCE240fc6oSHHKugGZo35OG2qmf0FIYMoylPOSusg+XbHYZxZBeAI24b/Q2BJMcxwOLKDtE660xQdBbZBAh2ffB6M4LZ0LZ4SZGvZz7AbTiU6Zfg4Ee46pL7Nt0G93nJnhhr9w15hl059481rzT/MSLPD6SMoKOb3nr/muz6fm5reW4ti/dXU4Ff4ekgRf3u87cVvnoXd6R5axAJ6+G6pbcPRee0E9Dtb6WUoNL9qFNNqz8NHKtriwcIptanLCcD8QUUSM8uoMP8nGoNBKQZCi+rWLsbqPtrI7lNjktylIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HevN41lsT0c1WBu632PPAbV0D13xQNIYlS8z3OTRv1E=;
 b=WG7cd8XkDnNg72NIilF5Q3oHiL+q56SclCPI5GtDoByjgBsTlaYQPgCLhm9VTaIvWiMJMVKHWnI6qi1k1pBQoqgW9ANpjUsFzBHxXLpWOdeASw2nbqkAeTpGlGYuOQoKjEuPB7bfnyQP6k0VTZL2Yiy4J/RCuqGMutjvgtLSvMQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW5PR13MB5879.namprd13.prod.outlook.com (2603:10b6:303:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.11; Thu, 30 Jun
 2022 18:00:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7%9]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 18:00:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "zlang@redhat.com" <zlang@redhat.com>
Subject: Re: [PATCH v1] SUNRPC: Fix READ_PLUS crasher
Thread-Topic: [PATCH v1] SUNRPC: Fix READ_PLUS crasher
Thread-Index: AQHYjKZ6PsElrHdOF0ieC+6YHQBvjq1oPUcA
Date:   Thu, 30 Jun 2022 18:00:33 +0000
Message-ID: <faae3bdaf5fc4b1c2ff481977bd1bf091bb0c8b6.camel@hammerspace.com>
References: <165660978413.2453.15153844664543877314.stgit@klimt.1015granger.net>
In-Reply-To: <165660978413.2453.15153844664543877314.stgit@klimt.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58340e90-bb21-485b-ba98-08da5ac26ddd
x-ms-traffictypediagnostic: MW5PR13MB5879:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZKnUdWVIOmdxcx0n3YiW46lkobafmj3r695xhAA4720bpFP8lKX1yvfg+198kJDo5IskJy0lIY4ACazfOvJY+5gRVVyWR0Ds2Z6ugJJmxrvKlJHw26hI61zU5Ey0xy+CNEnVyLJnWHUCgl+D06tfNZnDwE1s0UREBEKIH3xT7+1kLc0lltG4TaOBHB86FLV3Kia6iMin69ewtsJx5spuXRUyCDuBfHeUPiNzDwMn8r2nVxMzsMkX7tda2Vy/lEi5GKCS05Jq0PztHtkwyTYrJaPizRwQKXIk7yI7AkIgvQhzf569B2CdVnNjhwtriwR72/9YasxM6xaaMbvGW/fgsNd1R+T3t4O2pWMMC/8iCXiccDQ0gqABHVAJsBrcE0A5qy/xCr3Hho+8qFABlm4X4GmwXcs0neY1IA9+4g5EFjbI4h+a/y07ANkmcsD24pgwPy/5LxxkGqNJemx0rokfMhCx8cNbKhiYmfuqzNcqW/PzsT/btPLYVZSLHaRBXPgsiBba2NCdLwL/babEWICIzqu7FNdjji0IRAmRdS5kuVnl3wJaTDRWAZgILcM1yJZ0PPhwsLeGVwloqRw6aEdACA8F+WH8X986z36S02NeYd5LNNxPplqsLCjm5u75uClSnLMHQ5gWspoyY1hgMqFZ+bH3hJDofcOsxRVl3ytiEeCrR/P42s15WuY0uvBdaxks/WYNZ2CIQ/oGoLscMtIT86o7/vsq/0D4g+iZs0eUjnX/E5rEkPf+OChOl/9Uu8KabhiIYgWudjL8iJaiG6OgJaXaRZ2971wstPOtRZIn72iGqF9bwwvYa6QC0lLdwflnnKaC2HmQRC6g+zzTYeMi10MKvfMJ2/jVp1l6YHn64lOHTwP5YllqUPqbNJ93OHB1aiAH1fiynJQ2FOQQ6vcoKfqd9Mswy4xqk1qt5yy2ErE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(346002)(39840400004)(136003)(6506007)(86362001)(41300700001)(83380400001)(64756008)(71200400001)(478600001)(6486002)(966005)(38100700002)(2616005)(54906003)(122000001)(8936002)(6512007)(5660300002)(2906002)(186003)(4326008)(316002)(76116006)(66476007)(66446008)(110136005)(36756003)(8676002)(66946007)(38070700005)(66556008)(26005)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUtZYldkWG9EOENnOEZhQ0ZHWENSaWRvVyt1MW83QWs4NlUrOEh0Q2c0SlNq?=
 =?utf-8?B?KytwWGJaMEswRHJlSXlUSkI2ZzRCaS9PbXBWekpUdFhCV2t6SGxuN01NV0pm?=
 =?utf-8?B?QjQ1ZS9jY0ZXcFZRN3NqS2IrRXMrNXozc1BGN3NVYWRnMlF6Y1JuVDJ0RUlh?=
 =?utf-8?B?Q0h1amlVV2RGZ1JRRTh1dFBYbVZvREFrTE5mRHFXVEZZRzJVTkl3TzVOcHRz?=
 =?utf-8?B?c0V5N0cvL3kwelZIWjFuMWIyRWJ1UGNvTTUxM0ludlQ5WEg3MS9GZUVlN3BG?=
 =?utf-8?B?eWZCaUpNbUY2UzlqUnBiWGRWRXI0SUo4UkR5NEQrQTNxQzJiNEYxRTRGSFp5?=
 =?utf-8?B?ejdSN200MWJtWEhwWlJmUTNpL1dpNjluTHJtWFlXR0J5b0xBNExhSzJMSGJB?=
 =?utf-8?B?MEJGMWlaWGQwN2hnUlJPQlVldU9sWmFBZkpwK3ZQbkxJV2FwVUEyZW9qdVA1?=
 =?utf-8?B?cUZIUTFvM3RHT3MxeWRJTGZ4b0FjeUo1Wk9mZG1kdGhWRjNMa0lqU2VWaGUx?=
 =?utf-8?B?aEdVTnpkbktwdFlqQlJpWmE2bXV6RTdnOFJTdkVpdG90YUFHT2JyMnB2ZUg5?=
 =?utf-8?B?czNJemkvTWpLOXAxSm5Feml4UDlYUGY5WEczOEV6T01aOXlNZHJTamFKazVZ?=
 =?utf-8?B?NTZ3NTd2VkVsbUx2V1l3aC9aRGhlSnpreE0vZXQ1Z01ZSzFuZ1hvVUVnLzM3?=
 =?utf-8?B?T2EwNFlYUXJaeVNmSFE1NmtsZXk4QXZ3dmJzQ3dVMTBkQVh0cjJoYmU0RVBk?=
 =?utf-8?B?QTNnWG8zNW50YlN5SE5UYTZuUndMckdwTXdoR2VRSHVKQi81UWF5ZERIWGVB?=
 =?utf-8?B?RjVEN09KeWtXb2R3MFJoUnJpblRObEczbDVYS1c2Sy9NbVg3eEhIYnY1NkZK?=
 =?utf-8?B?d1Z4WWlBOTZSM2p4OGFvaUk0YkdFNk1PNVBSZ2x2blZtTGVocEFGRmlNUElK?=
 =?utf-8?B?WUZRT0JwblFkSzliV2FIU1BTZDU5QU9QUzZEZ1pKWXphaXN0RFliRFlVVWg2?=
 =?utf-8?B?MENVcVdTdHNJR3BXNm1MQk1oU0RDRHdHSUg2MXF0WkR2SFdBU0V6VHhaeEhq?=
 =?utf-8?B?cG94Ynhvb2FPRCtTeEpINTNJNXFLbncrWFJkdFBEN1kyQlRySGx2S2VFQlM0?=
 =?utf-8?B?UWRJT2dQNXNtREdQbFd4TFY2Uk1LWXd4QmNVcVdici9OSDZvK0VJSm5XeW5N?=
 =?utf-8?B?VHIrbHRKQTJYeXNiQlFCSU11em9UZ3pwaGpkUzBJeWZ6MEFqaGQ2WHNER3c3?=
 =?utf-8?B?WlNWdmRPOUhHUmt4TGsyUjJucG5EK0dlVVdzajRJUmlwTHR1OHozbVZDallT?=
 =?utf-8?B?K3NydXRvd1FKVGk2ZkJxbFpaS01Wdm91dUJGMFdmM0hWcmxBcUtONWg4MlNk?=
 =?utf-8?B?anV6TVhQdGFrc3YwbHl4bXEzZjRxT0NSTk5vUHlEUWFyTmJCV2kxdVFlNmhL?=
 =?utf-8?B?ZlREcE9kcTdWNmtvajY0eW8yV0JWUDVkMGlOUWp4aWRzWjNVMjZqZURqMktz?=
 =?utf-8?B?WXR6TGVqb0xUTVpkb3JSNlhyY3A3bUI5eGMrcEFWbUJDckRwZWlUeHphSFd1?=
 =?utf-8?B?MlAzaVBvN3lZbXM0dXdaa2lLR2ZFWm5BdlR2dGFMOVlna2xockVHR3AzZ3JZ?=
 =?utf-8?B?TFRyTXcraUp0Uk1JMGpxTzFGeGY3akZvZDJVeFRCMmhILzIvVGo1bm9FNnl3?=
 =?utf-8?B?MmRtWmlJazZRUXFJSkhzaEx1Vno4M0tUSk10TVdsbExEbGlWZ2FlSlRzdHpl?=
 =?utf-8?B?U29lQnhlVEVDWWlJeEQ3aGlEaldXd3VuTmcyWm84NzBkQy8vUVZyWm1rUzY3?=
 =?utf-8?B?ZUZvSi9pemN2YjNvdVRJNnF0bkFUbGJBNHRoSCtncEY1STVmemRObUZOZzBI?=
 =?utf-8?B?QVJaZjNJVHJaUnhDeDdQSXZzRmRxd2lNUmtnbld4Qy91c0dweTZpN2RyY3Bp?=
 =?utf-8?B?RG5qMGEwYXZwR05OUWp6NHNLdkU5bWpkRjIxOGR1MlNmemtITmE3WmQrWVpi?=
 =?utf-8?B?bU9BNnVQL1pjd05TZGZkZmphY2FnK3RvT01MNDNzeE94ZUFvREw3T2NSNjVx?=
 =?utf-8?B?K0lqWjI1RTdjdmVvRDU5STJIRHhkcVlCbG10WTF4UFZaUy9hR2VQNnN2a1JE?=
 =?utf-8?B?ekxXY2FUcnhQWVh5TkJJTWVPWWg1VGRSRi9jSDNKUXpvYWtaSkt6eVlnMGl3?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86E855840E4FDB42B820968304C832F1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58340e90-bb21-485b-ba98-08da5ac26ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 18:00:33.9437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mXFthUT1ZOLoasLKupKzq/6XBNpBCE0oPNkruqOFHxdb+X9ZUuwOpGxTLk2UthqN3hgeiPgiE2Oy67hf1w/uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTA2LTMwIGF0IDEzOjI0IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
TG9va3MgbGlrZSB0aGVyZSBhcmUgc3RpbGwgY2FzZXMgd2hlbiAic3BhY2VfbGVmdCAtIGZyYWcx
Ynl0ZXMiIGNhbg0KPiBsZWdpdGltYXRlbHkgZXhjZWVkIFBBR0VfU0laRS4gRW5zdXJlIHRoYXQg
eGRyLT5lbmQgYWx3YXlzIHJlbWFpbnMNCj4gd2l0aGluIHRoZSBjdXJyZW50IGVuY29kZSBidWZm
ZXIuDQo+IA0KPiBSZXBvcnRlZC1ieTogQnJ1Y2UgRmllbGRzIDxiZmllbGRzQGZpZWxkc2VzLm9y
Zz4NCj4gUmVwb3J0ZWQtYnk6IFpvcnJvIExhbmcgPHpsYW5nQHJlZGhhdC5jb20+DQo+IExpbms6
IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE2MTUxDQo+IEZp
eGVzOiA2YzI1NGJmM2I2MzcgKCJTVU5SUEM6IEZpeCB0aGUgY2FsY3VsYXRpb24gb2YgeGRyLT5l
bmQgaW4NCj4geGRyX2dldF9uZXh0X2VuY29kZV9idWZmZXIoKSIpDQo+IFNpZ25lZC1vZmYtYnk6
IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiAtLS0NCj4gwqBuZXQvc3Vu
cnBjL3hkci5jIHzCoMKgwqAgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gSGktDQo+IA0KPiBJIGhhZCBhIGZldyBtaW51dGVzIHll
c3RlcmRheSBhZnRlcm5vb24gdG8gbG9vayBpbnRvIHRoaXMgb25lLiBUaGUNCj4gZm9sbG93aW5n
IG9uZS1saW5lciBzZWVtcyB0byBhZGRyZXNzIHRoZSBpc3N1ZSBhbmQgcGFzc2VzIG15IHNtb2tl
DQo+IHRlc3RzIHdpdGggTkZTdjQuMS9UQ1AgYW5kIE5GU3YzL1JETUEuIEFueSB0aG91Z2h0cz8N
Cj4gDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94ZHIuYyBiL25ldC9zdW5ycGMveGRy
LmMNCj4gaW5kZXggZjg3YTJkOGYyM2E3Li45MTY2NTliZTI3NzQgMTAwNjQ0DQo+IC0tLSBhL25l
dC9zdW5ycGMveGRyLmMNCj4gKysrIGIvbmV0L3N1bnJwYy94ZHIuYw0KPiBAQCAtOTg3LDcgKzk4
Nyw3IEBAIHN0YXRpYyBub2lubGluZSBfX2JlMzINCj4gKnhkcl9nZXRfbmV4dF9lbmNvZGVfYnVm
ZmVyKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoc3BhY2Vf
bGVmdCAtIG5ieXRlcyA+PSBQQUdFX1NJWkUpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgeGRyLT5lbmQgPSBwICsgUEFHRV9TSVpFOw0KPiDCoMKgwqDCoMKgwqDCoMKgZWxzZQ0K
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGRyLT5lbmQgPSBwICsgc3BhY2VfbGVm
dCAtIGZyYWcxYnl0ZXM7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB4ZHItPmVu
ZCA9IHAgKyBtaW5fdChpbnQsIHNwYWNlX2xlZnQgLSBmcmFnMWJ5dGVzLA0KPiBQQUdFX1NJWkUp
Ow0KDQpTaW5jZSB3ZSBrbm93IHRoYXQgZnJhZzFieXRlcyA8PSBuYnl0ZXMgKHRoYXQgaXMgZGV0
ZXJtaW5lZCBpbg0KeGRyX3Jlc2VydmVfc3BhY2UoKSksIGlzbid0IHRoaXMgZWZmZWN0aXZlbHkg
dGhlIHNhbWUgdGhpbmcgYXMgY2hhbmdpbmcNCnRoZSBjb25kaXRpb24gdG8NCg0KCWlmIChzcGFj
ZV9sZWZ0IC0gZnJhZzFieXRlcyA+PSBQQUdFX1NJWkUpDQoJCXhkci0+ZW5kID0gcCArIFBBR0Vf
U0laRTsNCgllbHNlDQoJCXhkci0+ZW5kID0gcCArIHNwYWNlX2xlZnQgLSBmcmFnMWJ5dGVzOw0K
DQo/DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqB4ZHItPmJ1Zi0+cGFnZV9sZW4gKz0gZnJhZzJi
eXRlczsNCj4gwqDCoMKgwqDCoMKgwqDCoHhkci0+YnVmLT5sZW4gKz0gbmJ5dGVzOw0KPiANCj4g
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
