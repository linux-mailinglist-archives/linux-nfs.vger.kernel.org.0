Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1178746A
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbjHXPi7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 11:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbjHXPie (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 11:38:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB361B0
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 08:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNbIRZMSp9JrxZUXOE2ABbNH+cqXZTiPV+g8DbotBqoOWOAk6paR249elpGPmf2aSdeVzqjKq/WzBiaW1YcKBT56XrGsFMAJMyO8O3sf55/amcy9lm4QevctiZzbgqscDiWm5koEfZMGu0a5VDPTUFXTsuDm3VXXOHHEuHBrF/CuvjwzKqDxNiNDDzPqFVb3UToVwr3bQv6hM3nGHTJEOKx+LWWEmgp1OhzyAtgSUZ+eTvBKO+QDvipCQ3cBVw0YYbZuCt4/562ahZo7p0QNQHqzBUaPXPo3Ozmg1FZwaPzrE7Ab3h4g3MjV11XPazeEEaHhU5Czl7CiWUP7fTh50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7I4Nc4oQu0GWDNwfnki3sGDw3EKn0f/8I/yZu20C70=;
 b=aieHBcnYqyifkh/utEu3TWAp1QujTFHoZBjkhDx8no5C6RDu85+juiiy+PCOwvGQc/4J7kooVsPqfOzXq7uxEwmVeAPGahZtbYdj7gLXeDRvq1vr4RuM8jUK6r/FUGPECmWyLCdT/k5/oOCoqVvOrWopW1TLJtlR4YT8+Tqs/x36a0ipeuWWgUdWwnFR9r6yfgadXw6tvEIl/YoLUmdpXy0qViHD01ZhSeLahYOTinsPb1L+SZr+sylSrQs66uXz/nIthqZOWHiDtetjJfS0fCr5Fa0ZCnLkbbEIQ1nc/5bNtQ5grdaro1FFbYawKbZ0lJl0MmL3rLNV2IRzUB5Agg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7I4Nc4oQu0GWDNwfnki3sGDw3EKn0f/8I/yZu20C70=;
 b=BhuG7nvDyPnPIWvDbtPu0Vt3rbtxt2zFZZ0dSZO/n2AXbShhvyfkh+yxStUtLEVCOorrpsrK+nzCuq4xU1GFbH/GBS+dbcC+TPVk88kYh2u2PfSz0ivu1kqT5crD9mCCKWRn8nad1XZxriuzzU4de4YY6r5BUukIWiQ9MpkQI6U=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW3PR13MB3929.namprd13.prod.outlook.com (2603:10b6:303:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:38:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 15:38:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Thread-Topic: [PATCH 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Thread-Index: AQHZ1p5EQktXYnKpakGwNExN+xXv6a/5lNCA
Date:   Thu, 24 Aug 2023 15:38:28 +0000
Message-ID: <2e284800a1c4eda8a45f9f7f61b0b0eb6fa15a01.camel@hammerspace.com>
References: <1692890290-2772-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1692890290-2772-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW3PR13MB3929:EE_
x-ms-office365-filtering-correlation-id: 6cae6268-cbe9-4e53-19f5-08dba4b829e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q61ZEGEopwHcQZegRwj4WZ2xyMqzvpU8IWA+G3nEc6AionqN5xZ4AAvW8fwkq07Kll4yrR24c2ACLlgTj/7zfoCoy9CTiAGe02IOnCEUc4Ee0MeGcvxPSpC1RT/VpDgvSusXis4pirNvQ9v4A1UomO8VLwxSlSZSLIO+uxCI/NIN8ivXKvGb0nETt5F7WzpGTgD+98P2i2JOuKGQqQWO/+65wZVY7kOileLYkon5YTweL9fFR15PEwL2hvrGmAyRTbQc4ufFVYE+7FJCUOQ0HgkP6H1qs1N9WiXiXHWLlmJyjGUbs6Utmehyxj2Y6wfbCJNUtLxp5eA+82d8kiZSgfETNY5fANrFTRPuZWLdXcbClTmUB/f41eCHdrVBcanASqlqawz+C0/6jmNlfpIqC3F8pwKx9h9DK3NDoA/QC8Om5dwcgWZzxutjbp4XpcqMIuPJahbE95+GiNIfN9E/RsTR734z4NZE4+amjoj5GFboWQUPJbFHFfDVPj9j31HZDrVg7S/NRTFpT78jxb2ciAtPvl7GvGcUbsWKHmBEFXVO9UGA6xPa1NhvJRy2HR39ayFJlbCFdDLB5Rvw1cM8BDUEraDC0nxTXR8gsBOriIpcKxVeVOojBqcOJ4iApqB//msjxLle4fhnWOvrLdppdZeVvfSFhOiCGCRzInrokvAyqYFxSscfLLRWY1yAlUf5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39850400004)(451199024)(186009)(1800799009)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(316002)(122000001)(478600001)(110136005)(38100700002)(26005)(38070700005)(71200400001)(6506007)(86362001)(6486002)(41300700001)(6512007)(12101799020)(4326008)(8676002)(8936002)(2616005)(5660300002)(2906002)(83380400001)(15650500001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWZ5T3NlbFQyQXQwVHFtVnlCa2txaFlUSVhQNDJkL04vcmJqcXFFRElPYk04?=
 =?utf-8?B?c1NWQ0l4ZmIvVG51ZnBTam1tdGc3cE81U0ExV3IvZndPUFNaTmNwcEdsdStE?=
 =?utf-8?B?NGVhczV2eHljRjkwRE9iKzVJSXJ0RzZKRUh3bGIzWnV4RnBvVzVRVXBNcVdw?=
 =?utf-8?B?cHJ1TjVTUXQ3ZkgveEdHWVk1UFA4V1ZjWTFOMXlQUVJUait6RWZCYjY4T3h3?=
 =?utf-8?B?YXF3T2RORUpEU3RRb0Q1bW1XSk1QUDFjc3JzRk1EMThtVEg0RHZDUW9KSktT?=
 =?utf-8?B?V01Ma05qN1FMTG1KQlpnOXVZTC9XTmZ5a05YQ2NxUHNDVFEwcEpZdmFtdDFi?=
 =?utf-8?B?RXJ5YmNDUzlRYXBSWUVYMERGM0t2NnErQjVxbTVQb1BSRGVYVm9XN2VDeExK?=
 =?utf-8?B?SlF2dCs4Y2dzSlFxdDJwOGxaa3p2VWxIQ25tUVF1OTBKaFZDUTc3bm9kditi?=
 =?utf-8?B?R2s3b0dhby9TREhiaDlaOGZRTThvTndtbEt0UHdnTUxMTm53VklZSzRScXk1?=
 =?utf-8?B?OEhER3M0R2hiWkdBbWNtRndnZTR3aUk2dUoyYnVLeTdOa2NQcUxSbG1raFFT?=
 =?utf-8?B?RTJIcWhKTURFTmJQNnRGeWExTy9GZjh0cFZWMHBLcExublBkNjBMaGR4Mlo4?=
 =?utf-8?B?WENKSnpKckRqK3JHckZvTVVLTmJwb0I0elN4UW9LZlhla1RHQVV0ZEdvVy9B?=
 =?utf-8?B?UDBCNElZNXJNRnhOTEZGVVVXK0lBYzRFbStHbVdnZTNsYjN5eHdVYUxFSklO?=
 =?utf-8?B?STR0MzFjVWFpY1RNbWdOclFyUUVic1hTVHFaMUtrY3RyckxYWXlHVUdMR3Bq?=
 =?utf-8?B?TVVEK0gvTmV5b2F5RU50Vm5xS0JkSkphU1F3a0g4Ti91ZXhvSUZqYUR1R3pw?=
 =?utf-8?B?ajhiOURhRjhWK292ZnExQ1VPN1FCazl3SUxBZCt0d3d0MXFxcyt4cXlaeS9E?=
 =?utf-8?B?QnpkcW1vc05NQUpaQXFQMmE4d3NmM0RUaklhMWhMK2lHMHNZMXdadkVJNmR3?=
 =?utf-8?B?dm0yOVVSVUxxdTVlOW9Xd2V4Z1FmY3FFd3J3aHVRQ3FCdlNyWFhNb0w2VEVj?=
 =?utf-8?B?S0wxUEVvYnZ4bWIzeFZCYUpiRHZQVXcxYjNiS3V2cUkwTk0rNENrS3N3Tjdw?=
 =?utf-8?B?S25FU2M5YVFocFc5WGtwcVFCZUwxYnJVdkgwVys4Mk93bXJ4MzhxdWp1WXhD?=
 =?utf-8?B?ZjVlU0R5cGZMcGJ0c3hKNm84YWk3cmRNaktQelM4NmpnNkY0aTZRSzY5L1pu?=
 =?utf-8?B?aXJBWkhEQVRXdWZOcU9sYzF3L3hmNUtLT0xXcldyMitRNTZQZWVLOXhlZVlZ?=
 =?utf-8?B?M1lKMDIwaWhnOXJuVm1EcnFrSE5oRWRtUkY1NGRJSXE0MnlHU3ZtSVgvMmor?=
 =?utf-8?B?VlU3L0IzemhpcGhRcU9qNllMNTNNZEtPb3BXQmp0Y1l2SEpMUFZSMFJkQ1ph?=
 =?utf-8?B?bXg3R0NxUm9heEJ0MTF0eG5rdDNqazBXN2RRK1RmVmUxSjNJNFBlZjh3Qnkr?=
 =?utf-8?B?VW5FWmZRdHMxSXJxRXBxZURKNTNMRCs3WExkZUdyd1VWdS9uQVpvSUJvQ1pr?=
 =?utf-8?B?ajExaXM5QlE3WDQ3dWFwaUQ2Y3Ira3VpQ2x4N25ybUFKMkRqaWtzaWxFaDNK?=
 =?utf-8?B?bW54UllwWXI3Rk82enNyWjAvVm5ER1RwNWEzVStwb3R4bU9aWFA3S1ZwS0Np?=
 =?utf-8?B?UE04bDhrSnU5TlNhMEthbHlINlZ2RTNvRjFJRHZEZ1c3WC84dGttQ3VxSi9t?=
 =?utf-8?B?dDJRVlNrUFdKL3lHUVVXaVl4c0crazZCVnBrY1MxVDcyWnVFcXB0a1NLV1do?=
 =?utf-8?B?RERxdFBiRWhTUUNteWxwVER1eVhEQWd0L3QrNmZVUVFSbTlmY05zWnY5cTh6?=
 =?utf-8?B?cjZuY0pHRHNGSjBmNlhqRGkwdG9HbEpuL0s0T3gvRFhIeFJ4cmRiVmhCbTZn?=
 =?utf-8?B?K0NOUlRLaVFUOEs5TUhWYzQ0eWZVS2xKV1BaWjBVN2M0OGxRRy9aT0ZaSVZT?=
 =?utf-8?B?Tnd2UHFIK3Q1TGRqaVdBbjFhUXArSzNPVnNTdzQzamRQeTRzdGJQQlN3T0Rs?=
 =?utf-8?B?YjRFR2s5eXc0eFJCRU5lV0w3aEtidlF5TzNBMCs1bkh5QTBPRlloUm1XeEY0?=
 =?utf-8?B?TjdmcEIxS08yRS9jZUsxUXFpUGpabmlKaDdlRk1ObVlMaUpqZmpRMW5KV2xn?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0E1602245703648B0AB495B5AF26AA3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cae6268-cbe9-4e53-19f5-08dba4b829e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 15:38:28.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivBFwnGOWE3a8rifm1dBsPHMaOkXDTb17U6xKPfLPcSEoBO8txy+zHOTKegj6aETxjmMQRJfdDUcUUEASv5BQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB3929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTI0IGF0IDA4OjE4IC0wNzAwLCBEYWkgTmdvIHdyb3RlOgo+IFRoZSBM
aW51eCBORlMgc2VydmVyIHN0cmlwcyB0aGUgU1VJRCBhbmQgU0dJRCBmcm9tIHRoZSBmaWxlIG1v
ZGUKPiBvbiBBTExPQ0FURSBvcC4gVGhlIEdFVEFUVFIgb3AgaW4gdGhlIEFMTE9DQVRFIGNvbXBv
dW5kIG5lZWRzIHRvCj4gcmVxdWVzdCB0aGUgZmlsZSBtb2RlIGZyb20gdGhlIHNlcnZlciB0byB1
cGRhdGUgaXRzIGZpbGUgbW9kZSBpbgo+IGNhc2UgdGhlIFNVSUQvU0dVSSBiaXQgd2VyZSBzdHJp
cHBlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYWkgTmdvIDxkYWkubmdvQG9yYWNsZS5jb20+Cj4g
LS0tCj4gwqBmcy9uZnMvbmZzNDJwcm9jLmMgfCA3ICsrKysrKy0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvbmZz
L25mczQycHJvYy5jIGIvZnMvbmZzL25mczQycHJvYy5jCj4gaW5kZXggNjM4MDJkMTk1NTU2Li5i
YTJiODNiZmIzN2MgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzL25mczQycHJvYy5jCj4gKysrIGIvZnMv
bmZzL25mczQycHJvYy5jCj4gQEAgLTU3LDYgKzU3LDkgQEAgc3RhdGljIGludCBfbmZzNDJfcHJv
Y19mYWxsb2NhdGUoc3RydWN0IHJwY19tZXNzYWdlCj4gKm1zZywgc3RydWN0IGZpbGUgKmZpbGVw
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmZhbGxvY19zZXJ2ZXLCoMKgPSBz
ZXJ2ZXIsCj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBzdGF0dXM7
Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IGlub2RlLT5pX3NiOwo+
ICvCoMKgwqDCoMKgwqDCoHU2NCBmYXR0cl9zdXBwb3J0ZWQgPSBORlNfU0Ioc2IpLT5mYXR0cl92
YWxpZDsKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIG1hc2sgPSBORlNfSU5PX0lOVkFM
SURfQkxPQ0tTOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoG1zZy0+cnBjX2FyZ3AgPSAmYXJnczsK
PiDCoMKgwqDCoMKgwqDCoMKgbXNnLT5ycGNfcmVzcCA9ICZyZXM7Cj4gQEAgLTY5LDggKzcyLDEw
IEBAIHN0YXRpYyBpbnQgX25mczQyX3Byb2NfZmFsbG9jYXRlKHN0cnVjdAo+IHJwY19tZXNzYWdl
ICptc2csIHN0cnVjdCBmaWxlICpmaWxlcCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBzdGF0dXM7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+ICvCoMKgwqDCoMKg
wqDCoGlmIChmYXR0cl9zdXBwb3J0ZWQgJiBORlNfQVRUUl9GQVRUUl9NT0RFKQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtYXNrIHw9IE5GU19JTk9fSU5WQUxJRF9NT0RFOwoKbmZz
NF9iaXRtYXNrX3NldCgpIHdpbGwgdGFrZSBjYXJlIG9mIG1hc2tpbmcgb3V0IGJpdHMgdGhhdCBh
cmUgbm90CnN1cHBvcnRlZCwgc28gdGhlIGNvbmRpdGlvbiBhYm92ZSBpcyByZWR1bmRhbnQuCgo+
IMKgwqDCoMKgwqDCoMKgwqBuZnM0X2JpdG1hc2tfc2V0KGJpdG1hc2ssIHNlcnZlci0+Y2FjaGVf
Y29uc2lzdGVuY3lfYml0bWFzaywKPiBpbm9kZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBORlNfSU5PX0lOVkFMSURfQkxPQ0tTKTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBt
YXNrKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByZXMuZmFsbG9jX2ZhdHRyID0gbmZzX2FsbG9j
X2ZhdHRyKCk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICghcmVzLmZhbGxvY19mYXR0cikKCi0tIApU
cm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
