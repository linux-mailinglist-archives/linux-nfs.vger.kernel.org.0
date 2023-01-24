Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68496679F08
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 17:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjAXQmN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 11:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjAXQmM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 11:42:12 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144C4858F
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 08:41:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdOSpakA+XlvzE46HStSU9HSlY459L2N8LfYwhg4BXyUYcVTANiXNLuCbr4q0k1sujCjrkREFR7kY8UXtXJGdMoSj9rf6yzXBbxw6KVkzEEVN5QCI4EEDE06RmOWuUJglM+OKWXOSffl0u2HWdWkzFJVEALbVjssVoU3mStV6YuAYcPEHE/vjPEHOdeUM6FbUsG6Jpp02CXoGA5R+H2ClR60ZTImzHnxVR0KG/f2hvp4FlUCZ/D+EJYFwzfRH5Y27tJSfq6FtwyFSBBwjSAZiu568qkXmQ+wFER7bEKj/W7tUq+4K1J+Mr4GW6uWnIwT5l8jM9Kd8jpKr7lxx5BOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxE5Hl62+HEAgtyrsfztdI1gPFDHte7xxIQ8JbeIhUM=;
 b=Ovhmrocj9GwAyMb/3nIJvEkkpffzsYFKX5jPYekWqJrqwqlQBmaRoM2IfTqVO5v4dEdAPK5rMd98cQYA2Tqi2Y8YBv2lnfxtoevPY8PB9Ka5i0Om+tckpVlqPkucuNZCPOM+6ur2sXlFm628YdwSclMzIH+w7n086FJz8eSzUTqkmEoAO7ihDJH60cUhfmJBUxIVcwFf34y1x1Ryj5RKR4Dw3FrEbbByQqCuAb/gFTRRRyoncOubvQcTM2yxic6SiYbUY+dTWgqPtua8gsnSjCXZMECRJcoBJu1fcIXy4Gr19gSadDxYJhbfbur1Ku/0fDw24VI7C79eiYcdz1I5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxE5Hl62+HEAgtyrsfztdI1gPFDHte7xxIQ8JbeIhUM=;
 b=AP5zE3Cc6+bH4NtUMzab0Dqw3PlBzz5dZaEGy/tUKAl7bFbXw66pvhyzpfsxw72gO7WDwfa61+ecj2LYXgSu80GU2fTPnSyWjlFN5KYYv6z24ypkJYE0RwWOuKCOQ+JRFOApkHHvoPDToizCbuoBRWNCacO5uNEa6/ixNQO5G9E=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3862.namprd13.prod.outlook.com (2603:10b6:610:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:41:33 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:41:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] Initial conversion of NFS basic I/O to use
 folios
Thread-Topic: [PATCH v2 00/18] Initial conversion of NFS basic I/O to use
 folios
Thread-Index: AQHZLIyzdu9eXmSbik+Yz/vm9I246a6twtOAgAAJdIA=
Date:   Tue, 24 Jan 2023 16:41:32 +0000
Message-ID: <0FEB407A-5D01-4430-AEE4-13A45B4840D8@hammerspace.com>
References: <20230119213351.443388-1-trondmy@kernel.org>
 <CAN-5tyFbSaaQBGHkOuckjqPP56QFS-=fF9TuYVLMiaFD0UBCTg@mail.gmail.com>
In-Reply-To: <CAN-5tyFbSaaQBGHkOuckjqPP56QFS-=fF9TuYVLMiaFD0UBCTg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH2PR13MB3862:EE_
x-ms-office365-filtering-correlation-id: 0f24bd69-d511-4f05-12e7-08dafe29d9af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A2WsZKv7mTJdbC26EHGKojlcAK8dn9XcLymnheeqU0HKB4E7Njg8plN41M8PQ9Desr3N9cYYO9gOKoMbfgELwCGejYuoX92cDIR90juaB2RJHJGPluWVnf4sfCd277f40WJs/5KzYiM9dIMWiCuSJSwVt9LLV8qRCrxN+KYgDyQdrKHCGcQZqzFP9vOBFQZ3kg29vabsmJ+R4F6cUSXm9gG7/P78rhV9XOfaiLzv7mc6u6Ye4t2R6CnltwLuTusjlN0UjwuBct+MQ0HwIwg17+0KzSxPLzzN1jtgavFfzttiBLfyrRQM6JETmHxtuX8Wj0L98fivDDBzAWjZKU+K/tV4qzntpONhUZONnNP2sUibrxgtPJbSejH8E/14S4H2ssJiqqzeUtPc9mqpj8tXjGQlmHmJM0HQmOydNHfiCcIV/DVwbQ5sS3URPI/UAjp20wgXf9NBOe4JDJttHNjR/OvH+eFzrql4A+ZWYvziFmFhY6femXaSUft6QbNHCx2pGUta+z2QhQPkhnVcg8g4fl3FZGuy7BsbOtLo0i7K9Tblsn7C+ODWppB+kJaBKrydqWyp+RzmPCTuUXVmsZ7yBpdlmDGMI4aliQVt17cLlURWPVzM/D+tm+Sf6eFdGM7b6E/z4q0krVhUGJklNuxCHhaE9eoM+zOLKcUTMnz/f+NQ6KZ0cWY9XyK4ls7U/j9dgMjeQ5W0PlwInaGAfSMT6O6ZSnXc02A3u4xB/nXJHN0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39840400004)(376002)(136003)(346002)(451199015)(83380400001)(38100700002)(122000001)(33656002)(38070700005)(41300700001)(86362001)(2906002)(8936002)(5660300002)(4326008)(316002)(6916009)(6512007)(53546011)(6506007)(8676002)(186003)(66476007)(66556008)(64756008)(76116006)(66446008)(54906003)(2616005)(478600001)(71200400001)(6486002)(66946007)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFZ1dEtSbFdGNVNYTkVORjdURmNXY3RzRGovN1YvaXRONzhBWmJnNit3U25u?=
 =?utf-8?B?NTh0YWRTL1Jza3NhZHYyZ0JFbTFWRERHUDdHeUQ4TzQrRzJvSmFOUnpldjVV?=
 =?utf-8?B?THQwR20xalBlclRZQkxRMmwrd3NQQTNQbDFHUGV4WGk2TU1yQ0l5eFc5RVVi?=
 =?utf-8?B?UXEzVEk2S0p0WXRiTnpGanl0V0MvTjVHeHM5RE9MVExIa0ZBYnNlM1pEN0VO?=
 =?utf-8?B?RkNzY1JQZFRvM1hFblBGRU8vVGhoQTg1VVlNVXhsYnlHNm9BVm8yaHpwejMy?=
 =?utf-8?B?eTlMM3ZvUUx1UnNobUROemcxRHpPVFVLL0dBYUMyNkdqcWJvbkR1SThwWU96?=
 =?utf-8?B?MGEvbkUvU0NYZ1hJNkJYU0xuUkpNVmpqNWIzUWQvbloxdDlyWkpuaWZYYkRF?=
 =?utf-8?B?WFROUUsxNmxQSXNrWm1PQm45QzFzMm1vTGJKSHhxRDk3T204SnlMdnJ6a1Yz?=
 =?utf-8?B?amN5VmM5SGhhUURlS2hYNU5tY3JTSWo3K2MrOUI2aE5odk9jdWRqVzdCalRr?=
 =?utf-8?B?N0NQZHh2ZDZZaTU4L0J4T3lMcWlIYXVGdjE1NzVjWlZvVVZoM2p1L1FnNi9P?=
 =?utf-8?B?Q1JWNmg1OWxRTW5HZVdDNlc5YVA2THV4eGJjbjB3bElKMExMcS9ZaGQvZTJY?=
 =?utf-8?B?eXFJaVhDZ2ZSeDh1c2JkczV3VUNwQ21wT3licjJnMWU4ZEFPayt4a3Y0U1E3?=
 =?utf-8?B?SG4vRmF3WG5wUHRtNUF6VVJWVUI2SURTZ252aW1NbUFTM2h6c1kvamUvRUNZ?=
 =?utf-8?B?NDFHTEM5WGxabWUwdWZjZ1FVSUJ0OFlSRGhmWUo5ZUh1RmgvYkVndzZEMFRr?=
 =?utf-8?B?ZFVKSjNndGVCaDVZSU5HeHhzK2RMUkpsNnZJVDlMZzV5WmE5OEl4eWpGK2ly?=
 =?utf-8?B?K1FkY3hwNG9Ec2U5Z1YxcnNxTkY4b0hYUDJzL3BOb29QeVcvYnY1MGF4b1dk?=
 =?utf-8?B?TlE5eHVLdVdMNFlZKys3VHA0Z2pCQ1U4bXpuWEdTYVc5Q2FVam1qcVc2aXhp?=
 =?utf-8?B?b1ViOFh4S2lySjFaMlNpN3NYTDNkQTlOZUQrNVNwdDd3UmRGdEpxZkZrTVpu?=
 =?utf-8?B?MnY5ZTBoWm1WSFdVN3dlUE1acFZRWU9jenVNMDF3anlOam40S3RmRUVMZzRI?=
 =?utf-8?B?Z1FTanFseU8zUGZWeExzNlZ3SWhYUURsM1Z3dDkzaWVZWndYc0E3ZVUxQTBO?=
 =?utf-8?B?bnJncEdiWjZlVTUybGNQd0xkdzBRL2VEL0ZXZE1mYmxycVQ4M0ZpUXJmcU4z?=
 =?utf-8?B?b1d1N3pudW52Q1c0VzYwRCt6eC96eCt0dUFYRzNFeVJzYlZjaFlyL2dFYTR3?=
 =?utf-8?B?Tzl3cmx6bTl0V1lVeStiNFYvUGtid29QTmNiR1dualN6RWZOclV5aTdoSlor?=
 =?utf-8?B?QUozVGE0ZU5GOG1NbWNKZ2lJcHZxNWVrQ1J2WWJOWDRTK25nSTBCT3JlTnhs?=
 =?utf-8?B?RStHWkhPZFh6M1M0ak9wUTdoV25iRnNtZjFwUFl0VU0xeFYvbTR1bjBKUTNJ?=
 =?utf-8?B?bmE0aUdoVmU3bzk5WlNVMEgyazlNM1lhMGNjQ3hIeUZDT3RrN0ZGK3BGK3NC?=
 =?utf-8?B?OGMrMnljZVpGNHd2NGRaSzlPVXNoM01KaEpNQTV1ZVZ1eGF4citrSVZoVFhr?=
 =?utf-8?B?M1V5aDdpUGJWL1VmV0xuZytIYTB2M0J2YmNJd25NNG9GajhkRDRleTZLQzk4?=
 =?utf-8?B?R05KTURHN0g5Y0d4Y0RydG5jclU4R0FWaXBGRkZJWDBxRTdVYXQ1RWJQYjd3?=
 =?utf-8?B?MGJuU3R0TGdNdzg2VnBBV01oOGZ5Ulh1dm9sSTR6NzRuOVFOTnBYQmNjMWw1?=
 =?utf-8?B?UjRRR0lxVUM4YWF4ak5YTXgvNmdPa0ZOUWhQQ1F2SmxkT1BpZDNudEZIWXZt?=
 =?utf-8?B?QmJGY2NYbVg4d2d4ZzRsQVhKTHZlRTN0cDQzaURVRHFKUEFaUUNNQXhJSFVr?=
 =?utf-8?B?NmdIMU1IQUtwRFh6VmF6MVF0WHlKRjdKZ2NZc1pnQnlLQndUY2tKcXVGQVVF?=
 =?utf-8?B?ZGpjbUJ4UXQ1Zkt3WXJaZ0x4eW4xQjBhZmVtdG1haXFtSWFxODl6NXdJUzVi?=
 =?utf-8?B?cERnTzZIQndhT2dRSTdDcng4QVBLMnVBT3hqV3RlSDcwL3M5UjlzU1NKZEhB?=
 =?utf-8?B?ZEtzL2E0WkVpc2MzSnllQWFQT3ZPSXQrYVdKU3loKzBFdmJCV0d0WXZvbkY3?=
 =?utf-8?B?MzNGKzFxdVlvVHZBOTMwVnkvVTRGQ0tyNHZ4V0dsU3B4enFMT2R6WitYTnpk?=
 =?utf-8?B?ZTFSRnQ1Y0tlWG5OYTdzamRSbVhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <925D482B4DA049479B4F3B4808536A1F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f24bd69-d511-4f05-12e7-08dafe29d9af
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 16:41:32.5277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2F1yGwogM22Iz+XyPIgFzdal5xob3rCe7V53WDKxAHLnAo4gyYcNALIWy7fkZ0lxpdpcWB5RdePy5jWdy+d50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gSmFuIDI0LCAyMDIzLCBhdCAxMTowNywgT2xnYSBLb3JuaWV2c2thaWEgPGFnbG9A
dW1pY2guZWR1PiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgSmFuIDIwLCAyMDIzIGF0IDEyOjEwIEFN
IDx0cm9uZG15QGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBGcm9tOiBUcm9uZCBNeWtsZWJ1
c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+PiANCj4+IFRoaXMgc2V0IG9m
IHBhdGNoZXMgcmVwcmVzZW50cyBhbiBpbml0aWFsIGVmZm9ydCB0byBjb252ZXJ0IHRoZSBwYWdl
DQo+PiBjYWNoZSBJL08gaW4gdGhlIE5GUyBjbGllbnQgdG8gdXNlIG5hdGl2ZSBmb2xpbyBmdW5j
dGlvbmFsaXR5LiBJdCBzaG91bGQNCj4+IGFsbG93IHRoZSBuZnNfcGFnZSBzdHJ1Y3RzIGFuZCB0
aGVpciBoZWxwZXJzIHRvIGNhcnJ5IGZvbGlvcyAoaW5jbHVkaW5nDQo+PiBmb2xpb3Mgb2Ygb3Jk
ZXIgPiAwKSBhbmQgdG8gcGFzcyB0aGVpciBkYXRhIGNvbnRlbnRzIHRocm91Z2ggdG8gdGhlIFJQ
Qw0KPj4gbGF5ZXIuDQo+PiBOb3RlIHRoYXQgYmVjYXVzZSBPX0RJUkVDVCB1c2VzIHBhZ2VzLCB3
ZSBzdGlsbCBuZWVkIHRvIHN1cHBvcnQgdGhlDQo+PiB0cmFkaXRpb25hbCBwYWdlIGJhc2VkIEkv
TywgYW5kIHNvIHRoZSBuZXcgc3RydWN0IG5mc19wYWdlIHdpbGwgY2FycnkNCj4+IGJvdGggdHlw
ZXMuDQo+PiBJIGRpZCBub3QgdG91Y2ggdGhlIGZzY2FjaGUgY29kZSwgYnV0IEkgZXhwZWN0IHRo
YXQgdG8gYmUgYWJsZSB0bw0KPj4gY29udGludWUgdG8gd29yayB3aXRoIG9yZGVyIDAgZm9saW9z
Lg0KPj4gDQo+PiBUaGUgcGxhbiBpcyB0byBtZXJnZSB0aGlzIGZ1bmN0aW9uYWxpdHkgd2l0aCBv
cmRlciAwIGZvbGlvcyBmaXJzdCwgaW4NCj4+IG9yZGVyIHRvIGNhdGNoIGFueSByZWdyZXNzaW9u
cyBpbiBleGlzdGluZyBmdW5jdGlvbmFsaXR5LiBUaGVuIHdlIGNhbg0KPj4gZW5hYmxlIG9yZGVy
IG4gPiAwIG9uY2Ugd2UncmUgaGFwcHkgYWJvdXQgdGhlIHN0YWJpbGl0eSAoYXQgbGVhc3QgZm9y
DQo+PiB0aGUgbm9uLWZzY2FjaGUgY2FzZSkuDQo+PiANCj4+IEF0IHRoaXMgcG9pbnQsIHRoZSB4
ZnN0ZXN0cyBhcmUgYWxsIHBhc3Npbmcgd2l0aG91dCBhbnkgcmVncmVzc2lvbnMgb24NCj4+IG15
IHNldHVwLCBzbyBJJ20gdGhyb3dpbmcgdGhlIHBhdGNoZXMgb3ZlciB0aGUgZmVuY2UgdG8gYWxs
b3cgZm9yIHdpZGVyDQo+PiB0ZXN0aW5nLg0KPj4gUGxlYXNlIG1ha2Ugc3VyZSwgaW4gcGFydGlj
dWxhciB0byB0ZXN0IHBORlMgaWYgeW91ciBzZXJ2ZXIgc3VwcG9ydHMgaXQuDQo+PiBJIGRpZG4n
dCBoYXZlIHRvIG1ha2UgYW55IGNoYW5nZXMgdG8gdGhlIHBORlMgY29kZSwgYW5kIEkgZG9uJ3Qg
ZXhwZWN0DQo+PiBhbnkgdHJvdWJsZSwgYnV0IGl0IHdvdWxkIGJlIGdvb2QgdG8gaGF2ZSB2YWxp
ZGF0aW9uIG9mIHRoYXQgYXNzdW1wdGlvbi4NCj4gDQo+IEhlcmUncyBteSBleHBlcmllbmNlIHdp
dGggcnVubmluZyB3aXRoIHRoZXNlIHBhdGNoZXMgcnVubmluZyB0aHJ1DQo+IHhmc3Rlc3QncyBx
dWljayBncm91cDoNCj4gQWdhaW5zdCBhIGxpbnV4IHNlcnZlcjogdGFrZXMgYWJvdXQgYSBjb3Vw
bGUgb2YgbWludXRlcyBsb25nZXIgdG8gcnVuDQo+IHdpdGggZm9saW8gcGF0Y2hlcyAoNDhtIHdp
dGggZm9saW8sIDQ1IHdpdGhvdXQpIGJ1dCB0aGF0J3MganVzdCBmcm9tIDENCj4gcnVuIHdpdGgg
YW5kIGFuZCB3aXRob3V0Lg0KPiANCj4gQWdhaW5zdCBhbiBvbnRhcCBzZXJ2ZXIgKHNvIHBuZnMg
Y2FzZSk6ICB0b3RhbCB0aW1lIGlzIGhpZ2hlciB3aXRoDQo+IHBhdGNoZXM6IEkgaGF2ZSBhIGRp
ZmZlcmVuY2Ugb2YgNDdtIHdpdGggZm9saW8gYW5kIDM4bSB3aXRob3V0Lg0KPiANCj4gV2hpbGUg
SSBkb24ndCBiZWxpZXZlIHRoaXMgaXMgcmVsYXRlZCB0byBmb2xpbyBwYXRjaGVzIGJ1dCBJIG5l
ZWQgdG8NCj4gaW5jcmVhc2UgbXkgdm0ncyBzaXplIHRvIDRnIHRvIGhhdmUgYSBzdWNjZXNzZnVs
IHJ1biBvZiB4ZnN0ZXN0LiBUZXN0cw0KPiBnZW5lcmljLzUzMSBhbmQgZ2VuZXJpYy80NjAgYXJl
IHByb2JsZW1hdGljIHdpdGggMkcuIGdlbmVyaWMvNTMxIGxlYWRzDQo+IHRvIG9vbS1raWxsZXIg
YW5kIGdlbmVyaWMvNDYwIGhhbmdzLg0KDQoNCkhtbeKApiBEb2VzIHRoZSBwZXJmb3JtYW5jZSBj
bGltYiBiYWNrIHRvIG5vcm1hbCBpZiB5b3UgcmV2ZXJ0IHRoZSBwYXRjaCAyMWY1YWU5MDE2OWIg
KCJORlM6IGZpeCB1cCBuZnNfcmVsZWFzZV9mb2xpbygpIHRvIHRyeSB0byByZWxlYXNlIHRoZSBw
YWdl4oCdKT8gVGhhdOKAmXMgdGhlIG9ubHkgb25lIEkgY2FuIHRoaW5rIG9mIHRoYXQgZG9lcyBt
b3JlIHRoYW4ganVzdCBjb252ZXJ0IGZyb20gc3RydWN0IHBhZ2UgLT4gc3RydWN0IGZvbGlvLg0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQo=
