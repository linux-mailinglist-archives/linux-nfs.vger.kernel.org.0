Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55FD4433A0
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 17:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhKBQts (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 12:49:48 -0400
Received: from mail-dm6nam10on2110.outbound.protection.outlook.com ([40.107.93.110]:17502
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230315AbhKBQtq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Nov 2021 12:49:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8H5AxMiKYZxcCso/WG7abUlx+blVr5bl5RVOhjm4PitCwEah9v8hMdBO8OV8lXYks9XAT24u74M1QP9HIjWE6P06EVSWTH/lEz2bfbzuirZnoh01bBMHC5tvMKtJkK1QuPmAolJt6yf9bWS0DX3xMOdWk/wu97pgEjfwZwlEpEh5JRHMGcrQ295qJSUozQ9wXaNG0fpOK6ZCeuihjStWhn99GKeBHA7NM22CbFzJb7j2o931/eZ1SagUO2naDc7PtsrLggaWPgjP5NwqsK5xfhUZZBFxZA45MrDTRsgQjO+0geeYdYxYpzHDFCo9R1MobAQq8BbPVmEOIrp2btpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnYrE9pscKzsCaFVIio2h7P/m1gEY/RxKyefMTrcyaE=;
 b=YcZAfzS58b6URjisiTWV8m0c0RHVYOfCLyWA2l+x0pFg2nr3v4t4yqv5ueFEahuB54j5ZSBlLq64sno96XI989Z/KPfzW/jEwoy8og7fGSvj4sNj9acX6P98SmzwHfFZWC7mpMSnjHKwcorJ8Wf1Ou7NoqmwE2A9JTWx5A4DMQDxMYz2MGU2UinJEoKtRccgzv4jKY0xI6Uxk0hjSmsHbMVgCUDroqDQS86KGY9nMPOd5EAVt3SAbSOPAv0vgIMjUuxDHkDsVQ4iK95XO4JF81AA3FZPvb+Lgmdfpmz4Wiithn+UwwRNHSmtkfgYe6AjO1G2KDMJqbM6m8uW9IQDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnYrE9pscKzsCaFVIio2h7P/m1gEY/RxKyefMTrcyaE=;
 b=cuy0j+/kXgvXhKg/KLsd+ZZVXP16t9Td53zi2R/eCb6dwl/WnGtn+1x5Q5TIAAjxRKC0sLnBaMHw4TGXIuSHvQhdmu89jvPtoVSqCufyZo5llH2IB4c8hMFap4G8EzYwLiDC/kycJ+1Y6QKyx1eIARvpXU7O/Cdq6ux9kTDX8/c=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3400.namprd13.prod.outlook.com (2603:10b6:610:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.6; Tue, 2 Nov
 2021 16:28:55 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%8]) with mapi id 15.20.4669.010; Tue, 2 Nov 2021
 16:28:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfs4: take a reference on the nfs_client when running
 FREE_STATEID
Thread-Topic: [PATCH 1/1] nfs4: take a reference on the nfs_client when
 running FREE_STATEID
Thread-Index: AQHXz1v4o2sZThDS3Em5oh6bn8aATKvwbq0A
Date:   Tue, 2 Nov 2021 16:28:55 +0000
Message-ID: <9c677842d46b95e1ac7011afd44e29229d9efaa9.camel@hammerspace.com>
References: <20211101200623.2635785-1-smayhew@redhat.com>
         <20211101200623.2635785-2-smayhew@redhat.com>
In-Reply-To: <20211101200623.2635785-2-smayhew@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 098b0c7c-8c39-40e3-2d63-08d99e1ddd78
x-ms-traffictypediagnostic: CH2PR13MB3400:
x-microsoft-antispam-prvs: <CH2PR13MB34004CC4D1B93C4AFE5A8061B88B9@CH2PR13MB3400.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7uPhFoIH6S5nFpVIjEoxxiELOFyDPa1R9pbEUFaPrHnFwOv8l+EZuNuyL+PCwY8z9AA28zk0sGHvCn2mC+q8T3jLwBJrXpYOZCzHHTrJhKAtDhDvxIaUU5aeIPBU1+qYyUmiasX5/vy2Hk+AVIPShmBelnZkEyzk1LRHCBNNVYnBUFLPM4051ZfZJU4AOVuIZfqkJXqx70E0RD1SsPvpjiDaEIsK55080hcr9UxjOCCfOiuLELW6QkByM7YAWD6nICSSjh5pp/5Oev88Ys05c3ObNAwCcxACS90hjHo3MXJQo7WwXRyWaZXvza0MCpW+Bw6amXyPUugSXG1VotNPBGznmfJq25C3hppbP0Y6WeLDH4qCjRARsznD/Fa67UIrYeybL9n02Kwi2UdpdIuvBtNi+s9uqYawpbc+Re8FU6Hrfx1ibCKvrhWdU9Kr1k/o3pe6pFY6U70NXNwd71CnnHeWoQXhgtli7azsdzKH84aJR5vr4eurxUMnpJ7rp8+P2aEWB8jKrhXGY+yiAgG96Uq/JTjy+Ca8rLlzrmjpaOm334rXjBF+LKHDXxSp2nSBvaaTeKIhu6++GJIqiIHhaxFnYIp0twhpY/ygwGoBi3dofLA45tIRHUjyntR81ZzPzIaimyeYTZ3221F1AC/9XgKo67z19Kgc407zjk86nX6rmRAMulVvjx5ceLcCdm17TDxS3RrGOCB4m7tg3ZaPng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(71200400001)(6506007)(66946007)(66446008)(66556008)(8936002)(66476007)(316002)(64756008)(8676002)(38100700002)(122000001)(83380400001)(4326008)(186003)(110136005)(36756003)(86362001)(38070700005)(5660300002)(26005)(6512007)(508600001)(76116006)(2616005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VisyZE1acDZxeVh0d2dTSVNLdjVtVlU5MW9rK3loNERydXpuK2U2c2JmK2xU?=
 =?utf-8?B?WFBGR3pEVGsranpvTTJISC9adEZaYm9ienRIM1lMd1NaQUJjazBwRHRSZm8w?=
 =?utf-8?B?cS85cUgvS2VWaG0rckJoK29aV2doTTRMQ2RITXdyNnU5dFliWmMzZGJMYkNW?=
 =?utf-8?B?RFgrTUJvSGh5dlBMbjd5Y3R1dlFYRlBaWEozOTZpTGt3bkpzbUpQU0VUVXRX?=
 =?utf-8?B?eGhNT29VSDFzWkd2SlFYR0c3V1JRSE5vYU8xR0dhakphNWtPTUZMT05XZGoy?=
 =?utf-8?B?dm1XRDVLUExkNkplLzAvU29KR3M4MHRLUkJzbk03WFJNU0FTSkNvelhnS2Ru?=
 =?utf-8?B?U1BYdWhwQnhpcURvdjhtYm1QWEtxcXFkNm1UUmFMRUc1Wk91M2tyL1QzMjFh?=
 =?utf-8?B?TExWVHZCSHl1aU56S0hYWDh5d05XNUNQMVEyN05sc3h3SUpyczNRSlhJTVJX?=
 =?utf-8?B?ZXV2L2VMVG0ycFM4b0JkcGtGaThsckU2b1dmU1dXTEFZeHpESjM3WXJTTnRM?=
 =?utf-8?B?YW40U0F3cUphZmlJM2NvRTY0SWdQOWFUeDN3NjM4SGpmR3dSZG9jbjdMQmFT?=
 =?utf-8?B?S1J0ZW1Fek5ZMXFSM0cxc3dwbWU4THBveUZqaXJHNm12YUwxTEEyaEV2NXBp?=
 =?utf-8?B?ZzNxd1Q5UEgyNWNOeXc2ckxYQ0JBaEJOcVkxQVJZOGlyZEV3WS9Ud0pzY2RT?=
 =?utf-8?B?UGZuZ2xDMVRmNFFMajQ2ODFBc1B1RVJoNnlLSlg3L2VUWnJrSys5d3djbkwz?=
 =?utf-8?B?SDNNMkkyczVMVTZlWGpJa2N0TkVFbU9nUFlBL2JMVUNCdG5sVWYxR2VnR256?=
 =?utf-8?B?N05GYVJGOHFiVUtGTFdpN2VYVnlScU5qMkF2MU0wTVQwSStBOWdmcGphQVV1?=
 =?utf-8?B?THdCUHNla0kyODRQN0U3QWhmbFVDVUtsWG1jaFRkVERjWlFCOTNaOUlLYzZI?=
 =?utf-8?B?a1NWUjNZdG5tMFVobTRneERWUy9vMVBjOExqaThJYnlBUGhRUVpWdEtybkpW?=
 =?utf-8?B?cmo0angxcHNZTjRQV2Q5NU42R1F6T2NPNXZXVExCMEkxVFB5bnBEcWd1YUxC?=
 =?utf-8?B?V1N1UE5lTFJ6YjEyOFlvUVM0WHZOQzFmOUxpWDgvSzF0QUVhMWc0VUpQb3hw?=
 =?utf-8?B?Q3RkbWlxeUhaZVdYRjMrb09iTi9LRFVrLzVmK3ZScnBrWHQzSmpEb2ZCOGU1?=
 =?utf-8?B?QlJrSXNXZzJ2MFlHV0FGWjBmZkw4UWI4T1VReHlWRVAveVgydUhWYzlkaGhQ?=
 =?utf-8?B?UjMrbUhjbm85cTk5YWxnazBnMzBkUGxSV2NldUwvNTNVdVo1clViMjlBNnlw?=
 =?utf-8?B?bUlrNGpuWUR0ZG1sYmlLUElFRG93ZXNDWXJQQXEvZ2xJRlk0T2Z6STJXaUt4?=
 =?utf-8?B?dHU5WDA5NlZOVUFsR1h6ZTAydkNtQXZYSkhQV1V0UURGVDIvTHZlQnQ5TE5s?=
 =?utf-8?B?dmRzeE14MzQrbzBwZDZnV0VEbFRiZERNaFZqMXdpR0g4NDB3cCtxaUIwTGV6?=
 =?utf-8?B?aUhMaStGR2lSRktnU0FZN0YyYTExNWIzS1RLNGt1NGhMMnQvTUc1VVBmSyt0?=
 =?utf-8?B?NE1zWTlKRjFtZkxhQjlZbXAwNVZrMUxUdWlzdlJ2YkxTbjhhb0s1MWl0THNF?=
 =?utf-8?B?TGJ4ajRzSHR6ZEhqYVY3WmlwSTFsK0g3U0ZUTHgrNjcxc29aZGRTaXdjZVQv?=
 =?utf-8?B?YzhyNmY3bVhZVnI3VDMrdnVqenNYazBRZEN5T3FnNjM2NWVWQVVwczlldWFW?=
 =?utf-8?B?MmIvUDFxLytoZ1drYU1Uc2YvWEo1VG96ODlySlN4TUl2K1FzYXRVU1FybVRI?=
 =?utf-8?B?QWhPUWpCZUFWVEx6dTl4blBhVzJOSEJtZXV5bVVBRDM4bVd2YkQ3UTlNbVlS?=
 =?utf-8?B?azBVMGhuYkl5VEZPV1JzVDdJOVZqV09YM3NPTC9NWHAreDhneGZ2eHUxOGNt?=
 =?utf-8?B?MTZKaXRpZmwyTFBnZ0VUeURnZjBhYXByZVJFQWRrS1RGeTdPUnVscGdEcTFv?=
 =?utf-8?B?QVdUSm5scEpna2xGRUJBZUNHNVpIMHozREFPb2dFQkNrVlFxclArVFNKTzAy?=
 =?utf-8?B?d3IxMHlyem9JNHJrQjkzL2JZRTl1UTRmOGxRdkh0ZFA3K01oZ1lpVFFOd0kw?=
 =?utf-8?B?cDcralIxUnhYT0JqL0pFT0JYbHphdHdZaGJpNDRnaVlZUjVtRWhUbkRXOUpt?=
 =?utf-8?Q?sdMjzZ6BhqUKmQG7lxrw9Ow=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B32720926B56F438A7B506216EF343E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098b0c7c-8c39-40e3-2d63-08d99e1ddd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 16:28:55.4804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AW48cGeDdFRrXTu11dfP8zjYESw3LmzqavkefCVbpMGqAh8VKIDWGg+06BabDqLtaC2QROpdO6ciu8euNcEwlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3400
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgU2NvdHQsCgpUaGFua3MuIFRoaXMgbW9zdGx5IGxvb2tzIGdvb2QsIGJ1dCBJIGRvIGhhdmUg
MSBjb21tZW50IGJlbG93LgoKT24gTW9uLCAyMDIxLTExLTAxIGF0IDE2OjA2IC0wNDAwLCBTY290
dCBNYXloZXcgd3JvdGU6Cj4gRHVyaW5nIHVtb3VudCwgdGhlIHNlc3Npb24gc2xvdCB0YWJsZXMg
YXJlIGZyZWVkLsKgIElmIHRoZXJlIGFyZQo+IG91dHN0YW5kaW5nIEZSRUVfU1RBVEVJRCB0YXNr
cywgYSB1c2UtYWZ0ZXItZnJlZSBhbmQgc2xhYiBjb3JydXB0aW9uCj4gY2FuCj4gb2NjdXIgd2hl
biBycGNfZXhpdF90YXNrIGNhbGxzIHJwY19jYWxsX2RvbmUgLT4gbmZzNDFfc2VxdWVuY2VfZG9u
ZSAtCj4gPgo+IG5mczRfc2VxdWVuY2VfcHJvY2Vzcy9uZnM0MV9zZXF1ZW5jZV9mcmVlX3Nsb3Qu
Cj4gCj4gUHJldmVudCB0aGF0IGZyb20gaGFwcGVuaW5nIGJ5IHRha2luZyBhIHJlZmVyZW5jZSBv
biB0aGUgbmZzX2NsaWVudAo+IGluCj4gbmZzNDFfZnJlZV9zdGF0ZWlkIGFuZCBwdXR0aW5nIGl0
IGluIG5mczQxX2ZyZWVfc3RhdGVpZF9yZWxlYXNlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNjb3R0
IE1heWhldyA8c21heWhld0ByZWRoYXQuY29tPgo+IC0tLQo+IMKgZnMvbmZzL25mczRwcm9jLmMg
fCAxMiArKysrKysrKysrKy0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZz
L25mczRwcm9jLmMKPiBpbmRleCBlMTIxNGJiNmI3ZWUuLjc2ZTY3ODZiNzk3ZSAxMDA2NDQKPiAt
LS0gYS9mcy9uZnMvbmZzNHByb2MuYwo+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jCj4gQEAgLTEw
MTQ1LDE4ICsxMDE0NSwyNCBAQCBzdGF0aWMgdm9pZAo+IG5mczQxX2ZyZWVfc3RhdGVpZF9wcmVw
YXJlKHN0cnVjdCBycGNfdGFzayAqdGFzaywgdm9pZCAqY2FsbGRhdGEpCj4gwqBzdGF0aWMgdm9p
ZCBuZnM0MV9mcmVlX3N0YXRlaWRfZG9uZShzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2ssIHZvaWQKPiAq
Y2FsbGRhdGEpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnNfZnJlZV9zdGF0ZWlk
X2RhdGEgKmRhdGEgPSBjYWxsZGF0YTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzX2NsaWVu
dCAqY2xwID0gZGF0YS0+c2VydmVyLT5uZnNfY2xpZW50Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDC
oG5mczQxX3NlcXVlbmNlX2RvbmUodGFzaywgJmRhdGEtPnJlcy5zZXFfcmVzKTsKPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqBzd2l0Y2ggKHRhc2stPnRrX3N0YXR1cykgewo+IMKgwqDCoMKgwqDCoMKg
wqBjYXNlIC1ORlM0RVJSX0RFTEFZOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKG5mczRfYXN5bmNfaGFuZGxlX2Vycm9yKHRhc2ssIGRhdGEtPnNlcnZlciwgTlVMTCwKPiBO
VUxMKSA9PSAtRUFHQUlOKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcnBjX3Jlc3RhcnRfY2FsbF9wcmVwYXJlKHRhc2spOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJlZmNvdW50X3JlYWQoJmNscC0+
Y2xfY291bnQpID4gMSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBycGNfcmVzdGFydF9jYWxsX3ByZXBhcmUodGFzayk7CgpE
byB3ZSByZWFsbHkgbmVlZCB0byBtYWtlIHRoZSBycGMgcmVzdGFydCBjYWxsIGNvbmRpdGlvbmFs
IGhlcmU/IE1vc3QKc2VydmVycyBwcmVmZXIgdGhhdCB5b3UgZmluaXNoIGZyZWVpbmcgc3RhdGUg
YmVmb3JlIGNhbGxpbmcKREVTVFJPWV9DTElFTlRJRC4KCj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDC
oH0KPiDCoAo+IMKgc3RhdGljIHZvaWQgbmZzNDFfZnJlZV9zdGF0ZWlkX3JlbGVhc2Uodm9pZCAq
Y2FsbGRhdGEpCj4gwqB7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG5mc19mcmVlX3N0YXRlaWRf
ZGF0YSAqZGF0YSA9IGNhbGxkYXRhOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnNfY2xpZW50
ICpjbHAgPSBkYXRhLT5zZXJ2ZXItPm5mc19jbGllbnQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG5m
c19wdXRfY2xpZW50KGNscCk7Cj4gwqDCoMKgwqDCoMKgwqDCoGtmcmVlKGNhbGxkYXRhKTsKPiDC
oH0KPiDCoAo+IEBAIC0xMDE5Myw2ICsxMDE5OSwxMCBAQCBzdGF0aWMgaW50IG5mczQxX2ZyZWVf
c3RhdGVpZChzdHJ1Y3QKPiBuZnNfc2VydmVyICpzZXJ2ZXIsCj4gwqDCoMKgwqDCoMKgwqDCoH07
Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnNfZnJlZV9zdGF0ZWlkX2RhdGEgKmRhdGE7Cj4g
wqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBycGNfdGFzayAqdGFzazsKPiArwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgbmZzX2NsaWVudCAqY2xwID0gc2VydmVyLT5uZnNfY2xpZW50Owo+ICsKPiArwqDCoMKg
wqDCoMKgwqBpZiAoIXJlZmNvdW50X2luY19ub3RfemVybygmY2xwLT5jbF9jb3VudCkpCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlPOwo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoG5mczRfc3RhdGVfcHJvdGVjdChzZXJ2ZXItPm5mc19jbGllbnQsCj4gTkZTX1NQNF9N
QUNIX0NSRURfU1RBVEVJRCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCZ0YXNr
X3NldHVwLnJwY19jbGllbnQsICZtc2cpOwoKLS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20KCgo=
