Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8210738968A
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 21:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhESTX1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 15:23:27 -0400
Received: from mail-dm6nam11on2138.outbound.protection.outlook.com ([40.107.223.138]:37056
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230292AbhESTX0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 May 2021 15:23:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKIKHxzx72lyTdMAE+/6R9L0ns+Wc/4lin0Q6k0AIk1so/MLCM8spSWIGRHJ9hWpCK8mKgWK9KtDnWiLTA0+PRgyESVmuR16wlfU8MiWdORMaiH0R8uHf1AMQk/Wjil1qJ8y1cLfy32eWFVPByy3GD0haUe9kkMFeMF8jTrdZI0tZ9oA0FAu166f2s3uI+WTPg1bPac2Nn/3Q8X4oARSm7jiokDmqmJn7y3S8Y/huPoHY3B2nk26i3Jtj2b8LHHbrECzMzMy7C1RAi1tjkXIGcsKnnJNCHKZnSK7uqOPxcaaFp8YBaT9UUw8CwLe9tHDILU22Hds0zo8UVw2lNs/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaPo4a321wbpNPl2h6+Lw3GKttntfvH9lqbM/ezDxRU=;
 b=TG30qReMs22MmVHZl1UFoH2Z/5/LOlCdMUMwcJkmRfZUChOTXf1co3XXA+y1c6YJuWyYJM7UeQ/0OW2KCkRbBrQWO2QSyPf203IRcb/HbxWP4tXPB1Dp3owHQ9nJEMrne30c2CqSk2B9q4FQh6fXVAG67g5InDcEyC3183cgYLalazUH0SyzkAtDVCJdTTesJlkZT9NEbAHga5N1dKaycFltWlmOiaB6T+lLloqMGJavJxTgZRnfePqtGZqXG85/ZMX8piQpYuAu1F5K+rsnX2fwug6h7woi/WbNuklZfNQxOLrYrKBXT3LCemuNeV1vC6neJfs5jU41sQywb5V4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaPo4a321wbpNPl2h6+Lw3GKttntfvH9lqbM/ezDxRU=;
 b=c4pPKu1fFSelGVnE7Ryi3PNOIAwfc2KAXEcr0JwgGxTTv087hLa9FDQGPCXtw2W1f4PBTuf/eMiBZwUrCmx7IP8tH8WnF63xK7VG2SlV25jtdqMN20LAa3RvJDz9BEBSuANkX2gb5VObuclJG6eARDTaSIij7Z9Jlro8hcwoAsg=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB0924.namprd13.prod.outlook.com (2603:10b6:3:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.14; Wed, 19 May
 2021 19:22:05 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4150.011; Wed, 19 May 2021
 19:22:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4: nfs4_proc_set_acl needs to restore
 NFS_CAP_UIDGID_NOMAP on error.
Thread-Topic: [PATCH 1/1] NFSv4: nfs4_proc_set_acl needs to restore
 NFS_CAP_UIDGID_NOMAP on error.
Thread-Index: AQHXSCbe/isydKV+HUuRI0OzHA3ZU6rrODIA
Date:   Wed, 19 May 2021 19:22:05 +0000
Message-ID: <a3885a378fbe2505e0eff358ea67855989243f01.camel@hammerspace.com>
References: <20210513183555.28230-1-dai.ngo@oracle.com>
In-Reply-To: <20210513183555.28230-1-dai.ngo@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 153cfa42-1f9a-4693-ddec-08d91afb634d
x-ms-traffictypediagnostic: DM5PR13MB0924:
x-microsoft-antispam-prvs: <DM5PR13MB0924CDF57E23D250D9ABFD0CB82B9@DM5PR13MB0924.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QQ4b3694du6Y9qSipbLCRx66Og2rAtzQ0B7mqRdqPNIvNj13WAbB9D+bMk1ZKn50dhs/1QtT0nF0TIC0+Tv/ipTJ7WuqehTLGlp8mVgwB3dLKhr8BDujZxN/tBxVJbbdcUSo9u8Z0YbOp84SHy71cGL8g6WXcZmv7fQS0j82gnrFn2b3/jxbDbD4/9J1G6t2XTQVajQFxwnBOrrQ3be7FctZZZIqL9LuFTYopbHen7xOwhpAG6jPYLA8zj43/MDrjZQW/F3Ho2gB72h3PlrmFRnz21+g3erYU1RAiCWkrItQlrmeBj9SJfTnizeshWioiLqUa1cp60EIMk0Vzd+66isQP01doHkcCvtE3yjQi/Iwpe/DFpaJlo9PfzaQqhZO5TSjVN2OSgCVRnO+mpNtyaLtCTywd9rVQhctKCLxBoO7pnpgEDmzb0KIZj/QGnxIeER7wgiV0ulcNtFEBJ22Mtvo3bHw7Z6nRgoXPyy4WuqtCDoQzMP2U+pEnpoVNpMetSC+B+87Lq3vVF9fEhwTPF99fipaBcIfBBfEjGa6U0kQrNhCWCaqrM9lSrmrXlVz1MKlX89K97ld4XAdsShIObvLp5tmsqBoXiE/CRQ69zU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39830400003)(136003)(366004)(71200400001)(4326008)(6506007)(316002)(478600001)(6486002)(8936002)(86362001)(186003)(8676002)(66476007)(26005)(66946007)(91956017)(76116006)(64756008)(2616005)(66446008)(66556008)(5660300002)(2906002)(38100700002)(36756003)(122000001)(6916009)(6512007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TDdLaTErL1JiSGJlaXJlRysxd2tXYUVZUm4ySGZiaGZFR3R0MXJxNmdEK1A5?=
 =?utf-8?B?L3dMQ01kRFpDbTF4Zlh6Zk4zMCtpakpzdzdNNzFJTjBHNHBqcU15V05QSzhx?=
 =?utf-8?B?TjBuTUhYdkNjY3VuMXhGbXM4RXQ2UmFqYU5hbFd3TEFaVWV4c0F5ZlArZnZ1?=
 =?utf-8?B?MkJIYkw2VlhJUmZUU0s1dnRwbExHVnNkY2VTNXpHWEdPV2J5ZDhRSjhxaEF2?=
 =?utf-8?B?aWc2aUJzU0RzZzRFdDA3dk9RcllXbEg0MGhyaGp4YWRxcGZ6Zml6OFZpNG4z?=
 =?utf-8?B?UlM3R2pva1A5UzA2UmlIeVNySHNuNCt0STRsSTVBQ3lDVzgvWTF6d2wydngr?=
 =?utf-8?B?dFVtZlNETU5BWUJ6czB4MlcxcjdQdHo1QzlOcmxBOUwvSmZkazl3SE50bVpn?=
 =?utf-8?B?QnBPSVNuOG96WGVjQmJNY0Frc1MyOEpONC9UdE5CMTNtRElYZDNSSXczR1I5?=
 =?utf-8?B?ZGJZSWtoaUxiNDBvMVdNaVlSUXM3eXplTlBHQmZTODZKNEVzcnU4dm5nNkxm?=
 =?utf-8?B?cU1wU2UybmpvdVlwR0Nodk1pNXllYnNYblFUVDNMaDhYQ1lnSEZtSGdSUHJZ?=
 =?utf-8?B?Q29zQXRuZ1BYTDlYOWtJd2lOajAxYXhyQ2w0bFN1bVZMZmp3MXE2UVVVSkF4?=
 =?utf-8?B?bU5xS21EWkE3SkVHdXFmLyszREx1UXBXdmlEVHJqVDBuczBmdEtvdWpTQmVT?=
 =?utf-8?B?Z2kyUGNVc2FvcUxrTEtXd3VXcTJYOTRnTU9EaDAvZmlRSXBPOWM0SzF6Rzk1?=
 =?utf-8?B?TGRqTGlqWGY4U3FXOTk2VkxlNkUvWThwUW9EOTg1U01xcEwrdFJnRGNqR081?=
 =?utf-8?B?a0xtWTZjQ0dRZUQ4aWlmeGtmRmFmUzFvYkxYNmNtTlFCVnM3enZabWE1cGVY?=
 =?utf-8?B?bGlKNVg0cWdoc1d6U0YvODFFR2xHVUVMYUJncHVEQjVZM2tENUNRdWlBK0tO?=
 =?utf-8?B?bW5NbmtIRGtRM0VHZFMwTXRETnErWE5JR1VuNU1BWWZkSi9wTURGWHpsUGVn?=
 =?utf-8?B?UG1PQjltTWtRdGpWQ0ZWejNLbzFuV0RxdzlrUUlkL3hCK3A5U3U4VGw3Ullz?=
 =?utf-8?B?THlueTJST3FrcWE1enJHYmlleDV6Wk40dGRRcTZHbEt6SXc1WVBqbTJoVk5r?=
 =?utf-8?B?citpMWVoUmg3R204amZvMTJkTFg2Wk8vTWE3SlBJMzRsbDZuRkw1b05HS0Jl?=
 =?utf-8?B?dGRvNXZoMVRjNVlQcEF2SGdSRjBhQ2hCNWNZMHJvZktxRTZVWWJBeFhCajhZ?=
 =?utf-8?B?MFF3NUJMSHE4Njl1dWtWTFk0K1VucUZZZVZtTWlRYjRuRC9TTzV5U0hCd00z?=
 =?utf-8?B?amRKN3BDeVhnSnFTUmFVQTBaOThpWVdnc2R0ejBGRzAvNU5tR05qRmN0YkVh?=
 =?utf-8?B?MVI5b0ZtODJJNDMwd1dRVVNhMDZ2d2ptRHBnaXFYaHBCUk1aSWtHUCtvdVdP?=
 =?utf-8?B?NVhUVENncktHdXdtd1ZldGN2SnVVU2hVNjRBYnh1VFNmMnNOWG9JNWhxUXJv?=
 =?utf-8?B?Sm5SNzZ5RFVxdE9EcHFBRm8wUC95aHhtdGxHcGdOUjlHSG1aRFd6UTdmUEIz?=
 =?utf-8?B?Qzh6R05lbzdlVU11alJVWXNlYng0RktYUENscGJJR2hrNnRsVXpyRExYamhB?=
 =?utf-8?B?c2NTK1NGOTZ3ZWlhNUdSdUlmVERmV0x5eDdIL0tpWk5yRFJJVjlNN3RQUTAw?=
 =?utf-8?B?U3FkYUVHSk5LNEJqM29ubnpyRUVSamtYTU5iZVNhODlRZnZNQXBBb0M4aDBu?=
 =?utf-8?Q?NfmjQPzvFxSITEHuGOCdVEkQYWQkxwcAzFHN142?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5408981FCAF3EE4F938210899118B411@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153cfa42-1f9a-4693-ddec-08d91afb634d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 19:22:05.4079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuXmaiW3wV971Efcbxmgqxz3I1GvsyjjP1seRB9AB2b+rt615657CZW3tei+cK/56n2N/GFJ9u8NkxniOjO2CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0924
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTEzIGF0IDE0OjM1IC0wNDAwLCBEYWkgTmdvIHdyb3RlOg0KPiBDdXJy
ZW50bHkgaWYgX19uZnM0X3Byb2Nfc2V0X2FjbCBmYWlscyB3aXRoIE5GUzRFUlJfQkFET1dORVIg
aXQNCj4gcmUtZW5hYmxlcyB0aGUgaWRtYXBwZXIgYnkgY2xlYXJpbmcgTkZTX0NBUF9VSURHSURf
Tk9NQVAgYmVmb3JlDQo+IHJldHJ5aW5nIGFnYWluLiBUaGUgTkZTX0NBUF9VSURHSURfTk9NQVAg
cmVtYWlucyBjbGVhcmVkIGV2ZW4gaWYNCj4gdGhlIHJldHJ5IGZhaWxzLiBUaGlzIGNhdXNlcyBw
cm9ibGVtIGZvciBzdWJzZXF1ZW50IHNldGF0dHINCj4gcmVxdWVzdHMgZm9yIHY0IHNlcnZlciB0
aGF0IGRvZXMgbm90IGhhdmUgaWRtYXBwaW5nIGNvbmZpZ3VyZWQuDQo+IA0KPiBTdGVwcyB0byBy
ZXByb2R1Y2UgdGhlIHByb2JsZW06DQo+IA0KPiDCoCMgbW91bnQgLW8gdmVycz00LjEsc2VjPXN5
cyBzZXJ2ZXI6L2V4cG9ydC90ZXN0IC90bXAvbW50DQo+IMKgIyB0b3VjaCAvdG1wL21udC9maWxl
MQ0KPiDCoCMgY2hvd24gOTkgL3RtcC9tbnQvZmlsZTENCj4gwqAjIG5mczRfc2V0ZmFjbCAtYSBB
Ojp1bmtub3duLnVzZXJAeHl6LmNvbTp3cnRuY3kgL3RtcC9tbnQvZmlsZTENCj4gwqBGYWlsZWQg
c2V0eGF0dHIgb3BlcmF0aW9uOiBJbnZhbGlkIGFyZ3VtZW50DQo+IMKgIyBjaG93biA5OSAvdG1w
L21udC9maWxlMQ0KPiDCoGNob3duOiBjaGFuZ2luZyBvd25lcnNoaXAgb2Yg4oCYL3RtcC9tbnQv
ZmlsZTHigJk6IEludmFsaWQgYXJndW1lbnQNCj4gwqAjIHVtb3VudCAvdG1wL21udA0KPiDCoCMg
bW91bnQgLW8gdmVycz00LjEsc2VjPXN5cyBzZXJ2ZXI6L2V4cG9ydC90ZXN0IC90bXAvbW50DQo+
IMKgIyBjaG93biA5OSAvdG1wL21udC9maWxlMQ0KPiDCoCMNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4NCj4gLS0tDQo+IMKgZnMvbmZzL25mczRwcm9j
LmMgfCA5ICsrKysrKysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHByb2MuYyBiL2ZzL25m
cy9uZnM0cHJvYy5jDQo+IGluZGV4IGM2NWM0YjQxZTJjMS4uZTEyNjMwZTNiYjdjIDEwMDY0NA0K
PiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYw0KPiArKysgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBA
QCAtNTkyNiwxMyArNTkyNiwyMCBAQCBzdGF0aWMgaW50IF9fbmZzNF9wcm9jX3NldF9hY2woc3Ry
dWN0IGlub2RlDQo+ICppbm9kZSwgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3QgYnVmbA0KPiDCoHN0
YXRpYyBpbnQgbmZzNF9wcm9jX3NldF9hY2woc3RydWN0IGlub2RlICppbm9kZSwgY29uc3Qgdm9p
ZCAqYnVmLA0KPiBzaXplX3QgYnVmbGVuKQ0KPiDCoHsNCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCBuZnM0X2V4Y2VwdGlvbiBleGNlcHRpb24gPSB7IH07DQo+IC3CoMKgwqDCoMKgwqDCoGludCBl
cnI7DQo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnNfc2VydmVyICpzZXJ2ZXIgPSBORlNfU0VS
VkVSKGlub2RlKTsNCj4gK8KgwqDCoMKgwqDCoMKgaW50IGVyciwgbm9tYXA7DQo+ICsNCj4gK8Kg
wqDCoMKgwqDCoMKgbm9tYXAgPSBzZXJ2ZXItPmNhcHMgJiBORlNfQ0FQX1VJREdJRF9OT01BUDsN
Cj4gwqDCoMKgwqDCoMKgwqDCoGRvIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBlcnIgPSBfX25mczRfcHJvY19zZXRfYWNsKGlub2RlLCBidWYsIGJ1Zmxlbik7DQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdHJhY2VfbmZzNF9zZXRfYWNsKGlub2RlLCBlcnIp
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IG5mczRfaGFuZGxlX2V4
Y2VwdGlvbihORlNfU0VSVkVSKGlub2RlKSwgZXJyLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgJmV4Y2VwdGlvbik7DQo+
IMKgwqDCoMKgwqDCoMKgwqB9IHdoaWxlIChleGNlcHRpb24ucmV0cnkpOw0KPiArDQo+ICvCoMKg
wqDCoMKgwqDCoC8qIGlmIHJldHJ5IHN0aWxsIGZhaWxzIHRoZW4gcmVzdG9yZSBORlNfQ0FQX1VJ
REdJRF9OT01BUA0KPiBzZXR0aW5nICovDQo+ICvCoMKgwqDCoMKgwqDCoGlmIChlcnIgJiYgbm9t
YXApDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZXJ2ZXItPmNhcHMgfD0gTkZT
X0NBUF9VSURHSURfTk9NQVA7DQoNCklmIHRoZSBzZXJ2ZXIgcmV0dXJucyBORlM0RVJSX0JBRE9X
TkVSIG9yIE5GUzRFUlJfQkFETkFNRSwgd2h5IGV2ZW4NCmNhbGwgbmZzNF9oYW5kbGVfZXhjZXB0
aW9uKCk/IFRoZXJlIGlzIG5vdGhpbmcgdGhlIGtlcm5lbCBjYW4gZG8gYWJvdXQNCml0LCBhbmQg
Y2hhbmdpbmcgdGhlIHZhbHVlIG9mIE5GU19DQVBfVUlER0lEX05PTUFQIGlzbid0IGdvaW5nIHRv
IGhlbHANCmJlY2F1c2UgdGhlIGtlcm5lbCBpc24ndCBpbnZvbHZlZCBpbiBlbmNvZGluZyB0aGUg
QUNFcy4NCg0KSU9XOiBXaHkgbm90IGp1c3QgZXhpdCB3aXRoIGFuIGFwcHJvcHJpYXRlIGVycm9y
ICgtRUlOVkFMIHBlcmhhcHM/KQ0KaW1tZWRpYXRlbHkuDQoNCj4gwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiBlcnI7DQo+IMKgfQ0KPiDCoA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
