Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3113A340789
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 15:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCROOZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 10:14:25 -0400
Received: from mail-mw2nam10on2112.outbound.protection.outlook.com ([40.107.94.112]:13972
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231331AbhCROOR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 18 Mar 2021 10:14:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7btZBkiPXlSuIN81V70eVo3TUPUuQkG8hh5DFh5IiORn1fmEtgYh802hxR1JGKykCYnjCGzNVI6Xb9QC4eAPZw4Hfq+QE0Vu3UE5SxjBt9PAo+eGYWMLgACHKqjfr7/K13lmCbuijvBn0ZtiqOK9ORp8VqMgC5W3+sILHucCACMAXQ9XSbtjNYkhOqvXmFlt6yd+hjCZsgsb4T1cvrSz031YViHQ/LVp5aDmmm+sr2jqe7G2FvJHJ6QZtJ7mo5adp4tqh4KF8ZUWXybiAijeODjL8txKHtBDIiqgLchErNY+6HTop0QTSfZnn+AslqWOcOE8tcM1b/2mMUndS1zKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TbBT732UQwC6SAvEQAhBlqhbfgFlQ5jRt37YDKoabE=;
 b=FTWw2j5Q6bYPhxot78+ZIWRYE8npQoy5QSoPR2tjZnyOH25o/EKqMB08ZS6+klyy+M1keAPXDqdLfeS3g/N5G3iHtSBS4xxZRItCyVjaSLZSnr/mr7HYFHzbTM4TMprrAK2XxJjrDZrwe3gSQEm1MbSLwv6zWVwYryIT+DgLF5YCHVmpFFimnCy/1/qybFok71vM79qJOGYjXPqynyXENCTh98UHUuZ5kTi1qwMyYhdawecx1kk9NB2y68S2YyAjb95EzV5/7sHdXNz2mV95CfDYQGZFN0ljlnUVNoQ+X5GaTX4rQYPMjfCZmhL3Qj0SbCrKK1vd9edaqOudSWwfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TbBT732UQwC6SAvEQAhBlqhbfgFlQ5jRt37YDKoabE=;
 b=NyKZbZqnt7qSaJ0irEjPXhkY65T2uEOhzik44Ke9RG+I753aGSVcob3O8AncDKPfFERbqzB6XaDygc3uz6dOTFj+a2DWe5w9l9MJxxArefebgt7LOgaVsgWQJpYkP1XqmBFB8DM5ZD9fK2TRba6CykyzBjCcVHsiA7Q9zexDIJk=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3526.namprd13.prod.outlook.com (2603:10b6:610:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.13; Thu, 18 Mar
 2021 14:14:14 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3955.010; Thu, 18 Mar 2021
 14:14:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Nagendra.Tomar@microsoft.com" <Nagendra.Tomar@microsoft.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC] nconnect xprt stickiness for a file
Thread-Topic: [RFC] nconnect xprt stickiness for a file
Thread-Index: AdcbmG3Wy+rLrgPySr2+3WoogOFJygAZiM4AAACZxwA=
Date:   Thu, 18 Mar 2021 14:14:13 +0000
Message-ID: <70f050a8ac12a0054a01c2bf2b11a557e6a67fd4.camel@hammerspace.com>
References: <KU1P153MB01977184017092050048033F9E699@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
         <FFBB2134-E8A6-46A7-ADA0-5E222DC11620@oracle.com>
In-Reply-To: <FFBB2134-E8A6-46A7-ADA0-5E222DC11620@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86ead649-951b-4023-0335-08d8ea181bf5
x-ms-traffictypediagnostic: CH2PR13MB3526:
x-microsoft-antispam-prvs: <CH2PR13MB35267E690ECC9862B37BFC44B8699@CH2PR13MB3526.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6RPn1M+9BcKoxdzpUj0gILR+qLkWR5pOtD4t601ER1HF28mt4YRl2SVFOI54yU7R+bnxfupzINB/iFL8bqriqF2YlxkoUvvXAi09brK0oA/i08gqZ6iFHogUCPvys7uKeE+HiQcRra2iHNBZ18WtXPO2JP1sid3ad6qYL4qdM1TJTTPVNDtsJro/NeRz133/TsrXAegur2OpU+n4I7LXDiQ8l5EdylIZOjhTJ+9A3sFOg2DbwHmmUU54B2/YebM+bGR+ndQn2q1b4sz6FAV+zrs3a8d80p9uSGk5E4ctn8UCemk0Mb1Ru1hiuPVR7jtle3wIhc1E/ovaXf+mV0c9tgTbIuNu69JYYOH2riUtBmnpN7s8lXcNjZIO0JE9F9zaJm+ITcylzBFfirPpJCKw7NwUzdMyhL3XrAcRLEXNCnljJw2GFHsxrGM+1uk/PFI/P2ERnM8uod4zKyiMknoYGTwdJAGpVBlyiaYMWfFxDrO3ivFNjwbUMsyn25QG//erJYBUTW9kji9mFzgZeDPc1GZ64nF6jMAwQ+VG4uwb2J/fbgMQ+lsj1CvK7xG81YrN5VdbZnyWFYO+7aV4JzQONLeFE7jM843aPk0o4in0+b3F5cDzAoyn0lzC/f6OJ1l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(366004)(376002)(346002)(396003)(5660300002)(53546011)(76116006)(2616005)(6506007)(316002)(186003)(66946007)(6512007)(38100700001)(478600001)(26005)(45080400002)(8676002)(64756008)(83380400001)(66556008)(6486002)(66446008)(66476007)(8936002)(2906002)(71200400001)(36756003)(110136005)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cFVHUGhQL2ZIQy9NaFBFSzNxNjYvK0t3N0tiR0xIWVgyOHpIM2RHLzkweHdy?=
 =?utf-8?B?ZVhZMUZ4dWpGOHBZeWt5bGVUL25BeDZER0FZbGYyaUFESDMwaDY0aE5jUXhu?=
 =?utf-8?B?Vng5WXZxOVpsck5QZklpUmoybFFLRTIxTExqOG45Tjl4WG40M29vUURMZ0NM?=
 =?utf-8?B?aTJhL1dDQnplUmVsRDg3MExlS0JRTlp0aWYySVVvNjNobWlDK2JPT21kYkN4?=
 =?utf-8?B?TVc0T1JSOW1EamwyYVpYWDRYdXpWZVgvcDJhOFQ1b2NtdWtOaUttNlMyQ2Uz?=
 =?utf-8?B?dXlVUk5WNForOXhvcWZXcVlYSHcvTnRxREduNE9TdHBYbWQvR1ViSXl2Rk1a?=
 =?utf-8?B?QS8ybnp2djh0dm5raXhCVFYxc2tkaUtPRnpydVZDb1Q3cFc1UHUwRnhMdjUx?=
 =?utf-8?B?YkwyZDFmb1AxU0dtMXlVWm1DTFVkMGJnZHoxdHJwa1U4bXNPWTFNSTNuV0RX?=
 =?utf-8?B?UkdVVDZxUWhtQkpQWFVrNmxNMFNnMUNmVUFUV2ZybUt0R21ZRVllelZYU3Vn?=
 =?utf-8?B?aDR5Y1BNdjdTY0hmczh4dERVcmVSa21yVVA3UGo4R0Q5RFUrZDBtQ2JjdG5h?=
 =?utf-8?B?WkI0UW13dDdoMEpwRnVTdllnQU9qQXJrN3g2ZjN1N1M3VGZyK1FFK0lMZ1ND?=
 =?utf-8?B?VkRDSXNwR1FTby9GbDVCN1huQVdsVzFqTUk1MEVBWlJNN01OK0RtWTJVYmtL?=
 =?utf-8?B?WUxSak1VL2REMFBPY0JxVzFFRXZHWlN6WVFSR3hKdmxSK0ZTN1lQWllqUGcr?=
 =?utf-8?B?ZCsycXNWeDUwenJSNEd6cjRDVU9qQWFsTTZvMU5lNmxKRGJoTEFLTm5DNU9h?=
 =?utf-8?B?VW5RZmU4V1QyM0lSMzFyNjZrVkhFaE9RN1JyRmJiTXN2d1lrVHZwTWZsMlIr?=
 =?utf-8?B?Tko5cm1PVjdvRkF1SXYxc1FZeXBwbTZSZ1FWYXFRNW1lRU9xOFZzQXoyTzhs?=
 =?utf-8?B?T25YZWFzY0xaU1d5bHNQY0tZVWk3UW1kbldjS3RON1Fnd081TUtqSDhQQ1Bw?=
 =?utf-8?B?ZFZaMU5KSXhPSjZmVmcrK1BsRjRXQStsZG5mMmIyMDk1Z0o1ZC9BeWFDazZY?=
 =?utf-8?B?MlNCMXl2WmtCQXh6TldzT3loTHN6NytEc0ovblZlbGN1UklOc3QxbTFRYitM?=
 =?utf-8?B?TG5WRkZMMTdDSDczNDF0S3UrVGpjYlJ6MytzUmpyZkVIU3hYSEJFbGFzaTJt?=
 =?utf-8?B?QXQ4MHZqQ29ScFIvNGVrVHFJcCszbzR6cnNMZHQzR2tOR2hkRVo4WmhSSGZp?=
 =?utf-8?B?ME9aTlhsazRTL0dkZnFkSVhZaitnSEU1UUhOQ0tkRnhYMzk2d1lBN0NPemVl?=
 =?utf-8?B?eHNYa3NSRE5lQWZPekhPYkJRbndhZlo2aVNpeG42ek1WY1lBUXhQSEZSREdZ?=
 =?utf-8?B?SUgySnQ4U09wdTFVYk1sOXRUN2JVRVlwb1Y1dGIxNUhkdnBEdW0vVkc4a2ww?=
 =?utf-8?B?Z3IyMDUrSE1QcEtZZEduQ0lSZnhXWGZNSjZ5VlB2NFJnQjlOeWFsRHQ2VHho?=
 =?utf-8?B?cnIzWkZsVVdVcnUrRFVjYlhaUmN1aTBPRWMzVkZhUXlWUTlIb0JtK1M5RGpZ?=
 =?utf-8?B?Z3RrWUlrei8rbmUrQTRoVXVvMk5mUlFPcUFZZVZ3elpxckM5eHBxTWFFd1Ri?=
 =?utf-8?B?RWx3dnpTUTlyNm91K2NGQ1BkZmpITzZiSCszU1VZNXU2cW5NUlJ0OG9kdm14?=
 =?utf-8?B?a2p4U0RvMXdHVmt6b2hHZkJoMktJWFh5bnozSkZRM2h0ZENBU0pyN0F4OTJM?=
 =?utf-8?Q?JLB8Qb4kpRb8+Y4BSZ7KYfjbmSGt8xJPoEIVFAD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D06ACEA3D58BF14185D12815BACC73E1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ead649-951b-4023-0335-08d8ea181bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 14:14:13.9843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQOz8857zN84geg6gnEm7Jgdy/8wesGkL1mybeGVijw4rH3TvdVAURsYQRRQyVYeqd7Ipl5P7yz96G30FuQr2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3526
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTAzLTE4IGF0IDEzOjU3ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBNYXIgMTcsIDIwMjEsIGF0IDk6NTYgUE0sIE5hZ2VuZHJhIFRvbWFy
IDwNCj4gPiBOYWdlbmRyYS5Ub21hckBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPiANCj4gPiBX
ZSBoYXZlIGEgY2x1c3RlcmVkIE5GUyBzZXJ2ZXIgYmVoaW5kIGEgTDQgbG9hZC1iYWxhbmNlciB3
aXRoIHRoZQ0KPiA+IGZvbGxvd2luZw0KPiA+IENoYXJhY3RlcmlzdGljcyAocmVsZXZhbnQgdG8g
dGhpcyBkaXNjdXNzaW9uKToNCj4gPiANCj4gPiAxLiBSUEMgcmVxdWVzdHMgZm9yIHRoZSBzYW1l
IGZpbGUgaXNzdWVkIHRvIGRpZmZlcmVudCBjbHVzdGVyIG5vZGVzDQo+ID4gYXJlIG5vdCBlZmZp
Y2llbnQuDQo+ID4gwqDCoCBPbmUgZmlsZSBvbmUgY2x1c3RlciBub2RlIGlzIGVmZmljaWVudC4g
VGhpcyBpcyBwYXJ0aWN1bGFybHkNCj4gPiB0cnVlIGZvciBXUklURXMuDQo+ID4gMi4gTXVsdGlw
bGUgbmNvbm5lY3QgeHBydHMgbGFuZCBvbiBkaWZmZXJlbnQgY2x1c3RlciBub2RlcyBkdWUgdG8N
Cj4gPiB0aGUgc291cmNlIA0KPiA+IMKgwqAgcG9ydCBiZWluZyBkaWZmZXJlbnQgZm9yIGFsbC4N
Cj4gPiANCj4gPiBEdWUgdG8gdGhpcywgdGhlIGRlZmF1bHQgbmNvbm5lY3Qgcm91bmRyb2JpbiBw
b2xpY3kgZG9lcyBub3Qgd29yaw0KPiA+IHZlcnkgd2VsbCBhcw0KPiA+IGl0IHJlc3VsdHMgaW4g
UlBDcyB0YXJnZXRlZCB0byB0aGUgc2FtZSBmaWxlIHRvIGJlIHNlcnZpY2VkIGJ5DQo+ID4gZGlm
ZmVyZW50IGNsdXN0ZXIgbm9kZXMuDQo+ID4gDQo+ID4gVG8gc29sdmUgdGhpcywgd2UgdHdlYWtl
ZCB0aGUgbmZzIG11bHRpcGF0aCBjb2RlIHRvIGFsd2F5cyBjaG9vc2UNCj4gPiB0aGUgc2FtZSB4
cHJ0IA0KPiA+IGZvciB0aGUgc2FtZSBmaWxlLiBXZSBkbyB0aGF0IGJ5IGFkZGluZyBhIG5ldyBp
bnRlZ2VyIGZpZWxkIHRvDQo+ID4gcnBjX21lc3NhZ2UsDQo+ID4gcnBjX3hwcnRfaGludCwgd2hp
Y2ggaXMgc2V0IGJ5IE5GUyBsYXllciBhbmQgdXNlZCBieSBSUEMgbGF5ZXIgdG8NCj4gPiBwaWNr
IGEgeHBydC4NCj4gPiBORlMgbGF5ZXIgc2V0cyBpdCB0byB0aGUgaGFzaCBvZiB0aGUgdGFyZ2V0
IGZpbGUncyBmaWxlaGFuZGxlLCB0aHVzDQo+ID4gZW5zdXJpbmcgc2FtZSBmaWxlDQo+ID4gcmVx
dWVzdHMgYWx3YXlzIHVzZSB0aGUgc2FtZSB4cHJ0LiBUaGlzIHdvcmtzIHdlbGwuDQo+ID4gDQo+
ID4gSSBhbSBpbnRlcmVzdGVkIGluIGtub3dpbmcgeW91ciB0aG91Z2h0cyBvbiB0aGlzLCBoYXMg
YW55b25lIGVsc2UNCj4gPiBhbHNvIGNvbWUgYWNyb3NzDQo+ID4gc2ltaWxhciBpc3N1ZSwgaXMg
dGhlcmUgYW55IG90aGVyIHdheSBvZiBzb2x2aW5nIHRoaXMsIGV0Yy4NCj4gDQo+IFdvdWxkIGEg
cE5GUyBmaWxlIGxheW91dCB3b3JrPyBUaGUgTURTIGNvdWxkIGRpcmVjdCBJL08gZm9yDQo+IGEg
cGFydGljdWxhciBmaWxlIHRvIGEgc3BlY2lmaWMgRFMuDQoNClRoYXQncyB0aGUgb3RoZXIgb3B0
aW9uIGlmIHlvdXIgY3VzdG9tZXJzIGFyZSB1c2luZyBORlN2NC4xIG9yIE5GU3Y0LjIuDQoNClRo
YXQgaGFzIHRoZSBhZHZhbnRhZ2UgdGhhdCBpdCBhbHNvIHdvdWxkIGFsbG93IHRoZSBzZXJ2ZXIg
dG8NCmR5bmFtaWNhbGx5IGxvYWQgYmFsYW5jZSB0aGUgSS9PIGFjcm9zcyB0aGUgYXZhaWxhYmxl
IGNsdXN0ZXIgbm9kZXMgYnkNCnJlY2FsbGluZyBzb21lIGxheW91dHMgZm9yIG5vZGVzIHRoYXQg
YXJlIHRvbyBob3QgYW5kIG1pZ3JhdGluZyB0aGVtIHRvDQpub2RlcyB0aGF0IGhhdmUgc3BhcmUg
Y2FwYWNpdHkuDQoNClRoZSBmaWxlIG1ldGFkYXRhIGFuZCBkaXJlY3RvcnkgZGF0YSttZXRhZGF0
YSB3aWxsIGhvd2V2ZXIgc3RpbGwgYmUNCnJldHJpZXZlZCBmcm9tIHRoZSBub2RlIHRoYXQgdGhl
IE5GUyBjbGllbnQgaXMgbW91bnRpbmcgZnJvbS4gSSBkb24ndA0Ka25vdyBpZiB0aGF0IG1pZ2h0
IHN0aWxsIGJlIGEgcHJvYmxlbSBmb3IgdGhpcyBjbHVzdGVyIHNldHVwPw0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
