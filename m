Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB924362EA
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 15:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhJUN3x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 09:29:53 -0400
Received: from mail-bn8nam12on2092.outbound.protection.outlook.com ([40.107.237.92]:62406
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231182AbhJUN3w (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Oct 2021 09:29:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbKkxKXsxt5gYnhP74azeXBnAZNK07sVvbGPqNvYqUj2qNBoMSqc89+xZf1N51H2ISisdIeV+EZNN1vPuECumKB90HWLsMCH0IA0l2lPLbO8vcfs56B3g7KAUvn2w7x0agrxUgOcryu5NtLB9rgMn/P2xMKkKng1fKUzyYunF7W3wF9uERR+L5kdAOEf01zdOtrRNNaJoDMbZ79ARxlq7DwARbGHDEuBkzlvIuFKjCEXr66kAnqg8KHROEERe01GQp71J/c/u/6G4X/3Ud0bG2OFU7IHrMnP42oJJKxn/Rr5nFjkdYbm+ifXONZJSBXPXdzcJOrMkADdIDrzI8Wx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t2ihOXxYlakh1aItLeywMe9GPXjsYJufJn4Y/vd7Bc=;
 b=jCthukSRdPFA4EpxbRSpYbZJc0KGiPOJhhqAHEeTvUM89DIIGIWK9HmRekriCP9MOIJXKcq9ZkMyoh5pUa3Az9mTa7bnJs+9k7frnbkgplHN1a6N4qCu/kqXFfB04arJz6Q0OjcLfxuJVcnc7OqMU7EqMarad/nM993JHjG/RsEdDj0GhgsRb7qKRx0msyxw3MIPDKFg9EpZHX9bh8NOWuceSwcvvHkLn02mTq6Ey/uoKI1e/aQUPrJsTdRp9XunTQfYOEw2ID42cW67CWKg8uPHZo9rIIf9pp88LEzyrD1YQUzsjDyrPiDSMn3EX09CqbBKGd2irEKnPD8suUl3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t2ihOXxYlakh1aItLeywMe9GPXjsYJufJn4Y/vd7Bc=;
 b=WBDQPL3jHDFgWGAnMxmAR6/KpSO7n1ylw2mR3ZwNqpyXSsy8Tisi7sQWfkck3h/0fegJR4Zl36AE+VrRyo7a51CTiMY3N9OQDcb5+/uJyMvFB3A516LCbefykuCgb+zHaXFzrY4VlJLf61z6gWHSzEQueg5GcWDXTEzCNU0rqP4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4587.namprd13.prod.outlook.com (2603:10b6:610:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.11; Thu, 21 Oct
 2021 13:27:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%7]) with mapi id 15.20.4628.016; Thu, 21 Oct 2021
 13:27:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "caihuoqing@baidu.com" <caihuoqing@baidu.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] NFSD: Make use of the helper macro kthread_run()
Thread-Topic: [PATCH] NFSD: Make use of the helper macro kthread_run()
Thread-Index: AQHXxleOYULvDLiBqU6CiNZR95X2XavdchwA
Date:   Thu, 21 Oct 2021 13:27:32 +0000
Message-ID: <b481c093912de062aee6ea456dcd6849e7515cbf.camel@hammerspace.com>
References: <20211021084206.2236-1-caihuoqing@baidu.com>
In-Reply-To: <20211021084206.2236-1-caihuoqing@baidu.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd83aca1-883c-4265-ba09-08d994968992
x-ms-traffictypediagnostic: CH0PR13MB4587:
x-microsoft-antispam-prvs: <CH0PR13MB4587FF18D112420D0FF4C524B8BF9@CH0PR13MB4587.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YCAUAVvS0CdRLiCqRl3m0rAFIff0OfMz9duYFnzeLLHP50WNBlQIPfviewiu4/HcYhBOuZkErYw4KD8/HXWsdgLUSWi0vLG3reW+lAjFvauInzZy4W7KZS2aToGBLnBVakQJH3hCE0RrVxpETZ4nn+7/wOoO/fsTgHxjO608hefiHD2So6lOnbJczvmUV5u+V3zWyNYW2/h/dBZ4qdc6G8IZzI4WU4vTBsnaiqTDgaiQvoGtXNGsSwPnex9dR7SUOvtmRjQbvMgTUS44KHT6hBcMh5Wzah2juZXtREmLHF3NtVH0AOW93KNoN6JjgOrwLAY1xBMX/QBGD9U2dte4PRCOE2FbBwVmaBbX8bQn8vQD2q9v/jBLfA3q9zopeWFtGkFgc4K+mZtgAjndeQoozYgr6vv4nVXGHwjorvFsCwkeHc8iAmRCCguw4aGIfOuZc2oBsewNDJWcH7N+2S/o7qFaMF9RpFD78wTdmJTVu+0ba3tjKNnhoNqaKtRVKy1wbJD81C5q8Bfp3fzpQmqwcmkDoNiNFv9hlksH9VJYvRAvYNqEiR4gS8atIrrsSWb6om6UcwBaOzp7uXpXlu8tFY91NWLzYg94rV9KtVgfNQXxSTYyi6O9dZlWVWG+u13kbgXhvsZuR0+Ah6kFtxkP7VUIEPg6rfSPbiDOSyW8VP4u7jyti/50paOvzjnr3T1AarwQ0ghNUjmHLC776+sDvCLQZ71XmC2Y4ykjN9tG1tUoM38FLW306a73fZAwXzui
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(316002)(54906003)(36756003)(966005)(2616005)(2906002)(83380400001)(26005)(66476007)(66556008)(64756008)(66446008)(6916009)(5660300002)(6512007)(76116006)(66946007)(186003)(8936002)(122000001)(71200400001)(38070700005)(6506007)(508600001)(4001150100001)(4326008)(8676002)(86362001)(38100700002)(10090945008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTQ2RjZTZWdHNWkxbG1UcUxlQ0Z0RnpUelZIWWdRejJSQnZPMFhmYzdvQUZT?=
 =?utf-8?B?WDBsNCtPK2FBeGNGSVVDZ3FNM0xKOFhFWTJnOFJqL2NRdkZHMEFKeXBReWZ3?=
 =?utf-8?B?K3F3UDZ3c1BkRUtFSXZUTEcvYzZDWGJIRVNXUXNjc1VGNUJ2UEtQTTNtN00x?=
 =?utf-8?B?Si9ZWkUyVmRWU1QxSVhlYlJpaHN1NUZvZmJJNS9oOUE1MkhFMG9QaTM5UDd3?=
 =?utf-8?B?Y3dMZTk0c1Y3YzlhM1F0VzJuaW1wZ2JuMEZ2T1gyb1JTWVc4SEIyeFp6NGZx?=
 =?utf-8?B?QU5mNTdtZE5WVnFLNm12MDI2MGlGNGZXKzNGLzU0Mm1oNGJQSkJvaCt3ZUpS?=
 =?utf-8?B?QkFCVDNOUXlIVTFVMGNIK21nc3lNOERKUjhndHdtZzFEbGFoM2dORTZwWFNr?=
 =?utf-8?B?VzloUkhjTmlPc2lLeE04M2dhSTZOQTF6RngxNkMwTGhVWjJYY1JMODd2dTN2?=
 =?utf-8?B?U25PUWJGYUFNMzZZU2drVHFPaDdOVW5Hd3FPbHVRL29CTkRtWmRyTnpDbTlT?=
 =?utf-8?B?RDlKZ0VYTFp6TS9wdHgyMjRuNjA1Ymo3YkhrV0RXek5xR2ZvQWZxOHhCaEN4?=
 =?utf-8?B?dldTZDhQUFUvTkgzc2dWeDNGeitsMmxKM0I2U2FKT2VYL2prUndzT0thNzdZ?=
 =?utf-8?B?VHM5andUWWtiSzBqZEZsOURrenc4bUNzT1Z5SHVGbDFielgxZTZrK09QY3N2?=
 =?utf-8?B?ZGZxUm5TTVM4Ylk3L1NraUdOUFNOcWZySzdGczNWY3daS093VG1zZndhakpL?=
 =?utf-8?B?MlkyQlg3YmxybWNSN1hNVzBGQzZXbnh1SFJxSTQwL3JweUJwd0IxNWIvdjU2?=
 =?utf-8?B?MDFpdzRXbERUY24rWnpWNzNVbk51MXh3VWNVNE9GalprMzhOYnNlSEJJR3E0?=
 =?utf-8?B?MUg1Uk5LR3hLcm01Q2VMWWlKaVErK051MS9Pby9Dd2EyWDZuL3NCUU81bFJ2?=
 =?utf-8?B?VnpTNVQ4d3Z4Qk1FNmZvMGZlSDVUbVlYOForVFNlL01pSHJJNGJpYzBpaFp6?=
 =?utf-8?B?RnhvNUJ6alpEWWVmTWlFZ1RnUE85US9SUXhoNjB4KzFWSk9VT0ZJdjdMVEs5?=
 =?utf-8?B?T1BpMjVMS0tpb0d2dWcyWFlCR3FScEsxd3BJamoxVHU3OCt1WFU4WjMwOUYz?=
 =?utf-8?B?TFQwMjRNQzhKTW5oanN4WkpZS1lmaE5VUFYyZktaZDlDWDI3bSs4T3U1QWpC?=
 =?utf-8?B?dThhNjJSa3h6ODdhTVMxMXFIaitWRlU5dXlSU2NzdDJjVmZQSzVlNlprRUFl?=
 =?utf-8?B?OWxEWkF0VDBhSzVRRndZUUgvSzhWdXFXQnQwRjZ3MWdpUU1Ia1RUNWs3Nzhy?=
 =?utf-8?B?ZmtLMFNHK1hWWVo5ekpUdDdPMmIzVXZ1TmgyWlRqWWRybUQ5Ti8zYnBsR3BC?=
 =?utf-8?B?Rnd5U2s3d0JhTkZrZWxjWEJac1MwUjlyWGR4Y1ovRGpUalZESmZpWHlvdk81?=
 =?utf-8?B?Q0hadUJPTzV3eGpHMHBXZjJqa3FYUFZTRCtoM1BzSW9Jbm5GUGp1RDdVcWx3?=
 =?utf-8?B?MXBKNGc2ZlN3enNYT080Rm5KSWtWWFV2U1Nwb3lZREhwV25ST3N1QlByd3Zu?=
 =?utf-8?B?Vmo1eWdMRktMTERyWEF2ZkZObEI1VDltWXJZQUZ3eUNlSkZMTVlZYUk2aGZx?=
 =?utf-8?B?TGtuSHlnd1d3QTJ3OEs0cnkvSW1KQUdIUkNERGM1b01GV2k3aWg4eVZQbzdz?=
 =?utf-8?B?THJaa2ltdlNCTHkzUDdnVGJVSHUxMXZ2UUxGaG9OUzduTWZ5ZEdjK1luZFpT?=
 =?utf-8?B?NkhNMkFaaUhMUkczcHRSSStNaVp4SDNOYXYzTVpPM0ppQzhtbDRIWEJZRDdq?=
 =?utf-8?B?VFh1cjQrZUpCZlBxNUl3Qll6Lzc0S0JMNitUVVlkR1JnUVpzK2RXQjVHL0hX?=
 =?utf-8?B?UVAvazRUckZKRVowcmZMNXFqTzY4bWppTFpzYmtaOWN0VzdwWUp2NWRVcTlJ?=
 =?utf-8?Q?AUiLfGk0g+AIdfqIXmel22EG+wIkxERf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6267F182227024AB4A31EAB015AF796@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd83aca1-883c-4265-ba09-08d994968992
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 13:27:32.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4587
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTEwLTIxIGF0IDE2OjQyICswODAwLCBDYWkgSHVvcWluZyB3cm90ZToKPiBb
WW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGNhaWh1b3FpbmdAYmFpZHUuY29tLiBMZWFy
biB3aHkgdGhpcwo+IGlzIGltcG9ydGFudCBhdCBodHRwOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5k
ZXJJZGVudGlmaWNhdGlvbi5dCj4gCj4gUmVwYWxjZSBrdGhyZWFkX2NyZWF0ZS93YWtlX3VwX3By
b2Nlc3MoKSB3aXRoIGt0aHJlYWRfcnVuKCkKPiB0byBzaW1wbGlmeSB0aGUgY29kZS4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBDYWkgSHVvcWluZyA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+Cj4gLS0tCj4g
wqBmcy9uZnNkL25mczRwcm9jLmMgfCA2ICsrKy0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0
cHJvYy5jIGIvZnMvbmZzZC9uZnM0cHJvYy5jCj4gaW5kZXggYTM2MjYxZjg5YmRmLi42OTQyOGNi
MzFhNTUgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzZC9uZnM0cHJvYy5jCj4gKysrIGIvZnMvbmZzZC9u
ZnM0cHJvYy5jCj4gQEAgLTE2ODUsMTUgKzE2ODUsMTUgQEAgbmZzZDRfY29weShzdHJ1Y3Qgc3Zj
X3Jxc3QgKnJxc3RwLCBzdHJ1Y3QKPiBuZnNkNF9jb21wb3VuZF9zdGF0ZSAqY3N0YXRlLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1jcHkoJmNvcHktPmNwX3Jlcy5jYl9zdGF0
ZWlkLCAmY29weS0KPiA+Y3Bfc3RhdGVpZC5zdGlkLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKGNvcHktPmNwX3Jlcy5jYl9zdGF0ZWlkKSk7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGR1cF9jb3B5X2ZpZWxkcyhjb3B5LCBh
c3luY19jb3B5KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhc3luY19jb3B5LT5j
b3B5X3Rhc2sgPQo+IGt0aHJlYWRfY3JlYXRlKG5mc2Q0X2RvX2FzeW5jX2NvcHksCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
c3luY19jb3B5LCAiJXMiLCAiY29weSB0aHJlYWQiKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBhc3luY19jb3B5LT5jb3B5X3Rhc2sgPQo+IGt0aHJlYWRfcnVuKG5mc2Q0X2RvX2Fz
eW5jX2NvcHksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YXN5bmNfY29weSwgIiVzIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAiY29weSB0aHJlYWQiKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKElTX0VSUihhc3luY19jb3B5LT5jb3B5X3Rhc2spKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfZXJyOwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzcGluX2xvY2soJmFzeW5jX2NvcHktPmNwX2NscC0+YXN5bmNfbG9j
ayk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpc3RfYWRkKCZhc3luY19jb3B5
LT5jb3BpZXMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgJmFzeW5jX2NvcHktPmNwX2NscC0+YXN5bmNfY29waWVzKTsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJmFzeW5jX2NvcHktPmNw
X2NscC0+YXN5bmNfbG9jayk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd2FrZV91
cF9wcm9jZXNzKGFzeW5jX2NvcHktPmNvcHlfdGFzayk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0YXR1cyA9IG5mc19vazsKPiDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSBuZnNkNF9kb19jb3B5KGNvcHks
IDEpOwo+IC0tCj4gMi4yNS4xCj4gCgpEaXR0by4gVGhpcyB0b28gd291bGQgY2F1c2UgdGhlIHRo
cmVhZCB0byBzdGFydCBydW5uaW5nIGJlZm9yZQphc3luY19jb3B5IGhhcyBiZWVuIGZ1bGx5IGlu
aXRpYWxpc2VkLgoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=
