Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECEB7E29BE
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Nov 2023 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjKFQaZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Nov 2023 11:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjKFQaY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Nov 2023 11:30:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2114.outbound.protection.outlook.com [40.107.244.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F71D45
        for <linux-nfs@vger.kernel.org>; Mon,  6 Nov 2023 08:30:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTWTOZPbgcXzYui/idVxxFnu1JCM+T+W9yUB79Ih2GzTe1IPMw/17UCqTBWk0+u+D3kXpyqvEJoqU7z7CEeHzF0jJ1Phq6zhZHkoOvgkyv0tDKqU/SC6L15pA2lyWOMnczAKD8/GHZjKWxFLnVCdHIKxccZN5sSMOeJW/Y3RE1oZZ3jom+uz5AfppOwxHm/G+zArNsv6V0OKYjlF99UGRwYrfevk4MA3VLUA+0t+qf7uR5axYOdZ5DU5Wat/RkVCrQdc4FxiFiT+2kiIz+Cpt+oekjoqjmyEV+Ry0vnf2m5FeW6eSHMJhBq73qIOI0BYWvu+HTjFV1mECwtylxxFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlWZ7kBzqzud/SyNWxsQwJ50KLBQ//3lSTB4ldZUAbE=;
 b=hMiH+5D3SaUp/GyIpVrpjdQuLCM60fuW2GgQjnG6F/dsI3PqxV1Og7SgWiLhqErTh1NEf5aT0yuEkb7kvoquYYZP3xtaQM7WLm7ghEPtVICs38EDTDcQ7sjxUBIkrvC7Rm5TJOm9KBKx0ttpCajIcnR3+1uFjTgxpsghivlSpIeXYxPMNSB8u+OkA2Lpld+74VknGsExZlpZAvoJCnN6BZ+5424v2+eiMJJW/+2Fnci+iAJ30K78nCjNQOkvT02atYHB3NsUWMufHxNQFXp4OXASsctp2MbGJ38ZeeGXtzb5g+fwzn8RlbfY6z5vuvOaSLYb/XuJ/IpcZxrm5OyINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlWZ7kBzqzud/SyNWxsQwJ50KLBQ//3lSTB4ldZUAbE=;
 b=XvcpS8KE+mOkiA6GPx+HTfqI3nT1AmpMItankY0mz1/5PuzisMce82i8T5KQQI5cIlyeob1TFH8mmoLKd3RNaGEcXz7w+0TIv4iqwvRiBzJvRtfgeCoChtXAuhQ5dLMcMY74O02f7qUdgEXHLgJkTNBMW/4eeK/0RL6wEyLDStI=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 MN2PR13MB3888.namprd13.prod.outlook.com (2603:10b6:208:19e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 16:30:14 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 16:30:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: General protection fault in nfs4_setup_sequence caused by
 delegation return task
Thread-Topic: General protection fault in nfs4_setup_sequence caused by
 delegation return task
Thread-Index: AQHaEB5BKQ5QGSlnh06Lj6cEjRIJpLBtfMoA
Date:   Mon, 6 Nov 2023 16:30:13 +0000
Message-ID: <971e0321c1637fa4bb8625b618734fa8b229b0e0.camel@hammerspace.com>
References: <151d80cb-33dc-4266-a3ba-4b89ea80e49f@oracle.com>
In-Reply-To: <151d80cb-33dc-4266-a3ba-4b89ea80e49f@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|MN2PR13MB3888:EE_
x-ms-office365-filtering-correlation-id: 0a59817e-0f75-44c9-409d-08dbdee5a728
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBl4AVDOsiiew5cqsEzSgWa/i8nD/cSesQKY0yD+eoKii18GXISmz2ZwUUnZLrWQ0qId+QZ+/YvpqeD4akoBGnTp9EIYJ+KHlrHP/q6u/W+x0RGHA4ufNhoUsUYdUkWoEElAopJ/lB9doN7NCaYK5wKRRwOgSrEAP3EWtWC2++1IRTE6cIxpEgVk+EKFtZeoCqQ9yJOV+OLEgwew0vHhZZqelYpX977Q2wQjSUhcPUMxbcYfipti4p8cQC6DrwgvCG2fzUxRRn6p5glFTUW393zr+4LAcjeYvU2eKn3xfSXMDJZKpH7PK6VrGM6yGIm0tYezaUMo4yt1sG1gBCBfOUQ5JHgi31qU5L10LEu2ULeW/qCOv4h3Umx3rDOGbnuCjlp3giv+MG6JOv7Na5jH11kvGHkNTKPPC5eNAT7BHifpU1pPuIEcgfFF91FUQYCiQYNz51xdhz3Z+/bWhkKJjozCQahcHbqNM3wTHRvx2BreKgKVz357qOaCeiNhprtf+ELDYlRI2YqN4QdSmeR7Bt6+DbQ/zUvz/r7DGsBzJVyZ/ARoQL3ZYDeARaifsnBjJwqAxRLemNDq0wCf0tTfAGPBqKOc198888g6dVJw+oH4fw1eKe+ltF0f5vfncR0rqJ/j9tYdleuaG7x4S8kcyIJaDqYY1BMjnkqIaf+qB+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39840400004)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(38100700002)(86362001)(38070700009)(83380400001)(36756003)(122000001)(76116006)(6512007)(91956017)(41300700001)(110136005)(8936002)(71200400001)(478600001)(8676002)(64756008)(66476007)(66556008)(316002)(6506007)(66446008)(66946007)(6486002)(5660300002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTFUOEZobVNOSWhXSHZWSENiK3FWZnlpTlNaMHZBTVR5cDNtblJZb0tDM2cv?=
 =?utf-8?B?Yzc2ZzBCc2krSWFlR1ZzcjQ5a2VKZlZ2bE1GKzMrMWdzUFNGM2pLbHRmU294?=
 =?utf-8?B?TllxQ2Z3WW92bG5TSW1MRlBvRWd0elljUzg0NWJYOC9xNnJwdkZkenFPbFhC?=
 =?utf-8?B?a2JSVVhHRFIxZWJtYUZEV0RaR29Qbjk3bTBnNW5jYzJJem5uVUU3ZDVoWVhs?=
 =?utf-8?B?NHA3emZkRExTN0FIc1RCWDZnNEd4WFFSOXVneE1YUmhBM29mM0tyN0tKVnlM?=
 =?utf-8?B?RXh1eWxkTjBlTk1id21scnZkK1o2TTVkNHVwTEZNcjQxTTExTlNMV1RxMEpt?=
 =?utf-8?B?Tmg4TFc1RDErNDAxZU1JRm5KSWJBZUZTOTNxQk9waXJhc1I4aFZUUFd5VUhR?=
 =?utf-8?B?Y0Nya3ZBYjZoaUY2aWFUOFNwbGJiMHpDUzlEMWVWYnlwSWJ4d0hEejZ5N1NX?=
 =?utf-8?B?MVplbUVzWEVWaVg2Um44b1M3d3dDN1BkWFNLOWl2TWRTODhvM2pwQ1NoN1I5?=
 =?utf-8?B?MVVhTGF3dlZoUW8zQkdBS2F2cGI5ZEpsSDl0RjR4MEFpOUhjalpGM3Urd1RR?=
 =?utf-8?B?dXF4M1pTTEIxUUF2TTdkNVRXSE5PaVc3Q0ZuZDFVZ1JlUUd5VXBQeU40NGVP?=
 =?utf-8?B?SWxCdmJZV21SdG91aWJWZU1mejkzRGJDTFRublcxMGhvU0J0UkVKUDVWcSsy?=
 =?utf-8?B?T1pHSFZLTWhFbDJPYkp2SHJSTkIxWS96TFQ5QVd1ZzdjUnVVbVJiaHc2M0gy?=
 =?utf-8?B?YlplY1NhRTc4T0ZtRUdpcVFXSlplUHNWaUU3R0FVOGtPeGkxdmtiMFNHNVBN?=
 =?utf-8?B?TlRsRjdwQlhyNDlDTXNMUDhxZ0ozM1RBY2Y1Z3B5LzN1R0ZFeTc1eEVCd0tF?=
 =?utf-8?B?blcySEhtb1ZCRlZERjYyRFdkVXNsZjlyQVViQWY5TEJGRmNNeFZaYUYwT3l5?=
 =?utf-8?B?RmFMKzNJYk1nWjRUeVExcyt5SlYrWExyT1VlVWtQT0UweDM5WVJ4N0FENFNL?=
 =?utf-8?B?ZGRMaklISllNd244UHppb2NGZzRBMVpwMndWOEkwSVlBbVNsVWl3WDIxK1lC?=
 =?utf-8?B?Nlh5RExkTnlKSW1kSmFrbnpoMVNyRlZZK0NlSjVlRnBUYmRWbnB3ZEJ0SU5q?=
 =?utf-8?B?c0tmNWlYRlFyUUIyamxDUHVQQVMrclBUUSsrQW1yd004WTFvdkNTeHlHclQ3?=
 =?utf-8?B?YjVMOTZVTERJbUQ1c1JyOFBsaDFoQmdaVUpVUm0zN3M3cmJhZ0JyOHdOOFdr?=
 =?utf-8?B?bUpHblpnSXd0R3AyNll0REJQV1RKVml5dDZRMWhZMEp2dUZSMzRvL3FXb2ww?=
 =?utf-8?B?aXpia0ZDcEg3QlR6RjAzeVpBWXlwcGZhNGY5aEJjSE1odDNFOHkwRWtHdnE2?=
 =?utf-8?B?RXQ3Qk0vdjhoMWZMbVF6bXJTZy9jYVNXUUtaczNJU2QvbmErMnJwRzhZdFRh?=
 =?utf-8?B?WjRLMURNOXlZZHNTeFhLV2MzT2dFMmVkM01tRUpDT1VFeWd2RjYyeUZ2T21C?=
 =?utf-8?B?aFFXRUVTRU56bTFNaWZWMGlESkhkV0VYWjcwcDFEQmxoaFFLeHNtOWorMkkw?=
 =?utf-8?B?V0hPb0hmRnZ4b2pPY041RElmblRLbkdhVEd4UFFUbThMYWc0NnNaekVhOVRr?=
 =?utf-8?B?bmhXczRiWGRLS21PSXZsZEdhQ05KaEVIOEZDTEI0cnJ5MmhZRTRtajloZmVM?=
 =?utf-8?B?SER4UllFR2E5a1g0UUZCYzV2bjVEVHVyejc5cG5kYzVCQmhyVnBacUljS0Qy?=
 =?utf-8?B?NWZWL3hYMnBCNjdxR211d3JVckZPWVVhT0pmRWlReFNHVVVzL1V1ZmhURjhO?=
 =?utf-8?B?RHZWMnFCVm1XZGNnZDVGN0dkVUNtVU9QaUY5ek9UcldRSG5TWERUMEpsMjBJ?=
 =?utf-8?B?U215QTJYU1ZxczNnZ0hHSVhTK2JVTlU2dDdtMFI3Z1dZWG5Hc1p0bzJPdmRq?=
 =?utf-8?B?d0xURjhBbEc3Y29Idzhad2k0emRIc2FwWTF0Z0ptNkE3QmdHZnh4UkN4cmV5?=
 =?utf-8?B?QUM0UnI5UG13K0pwbEFnQ0R0RGRhVWptRTdocHVDUHM0UXREK0NkdTJaVEln?=
 =?utf-8?B?SXJaV1MyaDJxM1VRZmc5SHd1MGdUSEFzaGpvZ2JDZ291Y3ovNGd3NTBIemgx?=
 =?utf-8?B?WGpGT0R6S1BsajR2cnp1N3hGRnFPS2VaQkNDbi9XeFRxU1dYM0kwUFZQeXBT?=
 =?utf-8?B?RzhkSVJLSTlRSk9tQU9Rd1llS09VWkw1d3FZNVczQmRZQVpJekZRODNud3pa?=
 =?utf-8?B?R1FXVHg5Q0Y0OG9pUFdoTE02MTZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2884EAF2DD2E3C4EB2500B9491883C74@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a59817e-0f75-44c9-409d-08dbdee5a728
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 16:30:13.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOc2LSfF3f6UL6CyhWCvnvhmiCWvRD0XFglP9A+8yegiSxAtLCmaS2CiQi+236fDRnCb4urGkzPdtDIZ766+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgRGFpLA0KDQpPbiBTdW4sIDIwMjMtMTEtMDUgYXQgMTE6MjcgLTA4MDAsIGRhaS5uZ29Ab3Jh
Y2xlLmNvbSB3cm90ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBXaGVuIHVubW9udGluZyBhIE5GUyBl
eHBvcnQsIG5mc19mcmVlX3NlcnZlciBpcyBjYWxsZWQuIEluDQo+IG5mc19mcmVlX3NlcnZlciwN
Cj4gd2UgY2FsbCBycGNfc2h1dGRvd25fY2xpZW50KHNlcnZlci0+Y2xpZW50KSB0byBraWxsIGFs
bCBwZW5kaW5nIFJQQw0KPiB0YXNrcw0KPiBhbmQgd2FpdCBmb3IgdGhlbSB0byB0ZXJtaW5hdGUg
YmVmb3JlIGNvbnRpbnVlIG9uIHRvIGNhbGwNCj4gbmZzX3B1dF9jbGllbnQuDQo+IEluIG5mc19w
dXRfY2xpZW50LCBpZiB0aGUgcmVmY291bmYgaXMgZHJlY2VtZW50ZWQgdG8gMCB0aGVuIHdlIGNh
bGwNCj4gbmZzX2ZyZWVfY2xpZW50IHdoaWNoIGNhbGxzIHJwY19zaHV0ZG93bl9jbGllbnQoY2xw
LT5jbF9ycGNjbGllbnQpIHRvDQo+IGtpbGwgYWxsIHBlbmRpbmcgUlBDIHRhc2tzIHRoYXQgdXNl
IG5mc19jbGllbnQtPmNsX3JwY2NsaWVudCB0byBzZW5kDQo+IHRoZQ0KPiByZXF1ZXN0Lg0KPiAN
Cj4gTm9ybWFsbHkgdGhpcyB3b3JrcyBmaW5lLiBIb3dldmVyLCBkdWUgdG8gc29tZSByYWNlIGNv
bmRpdGlvbnMsIGlmDQo+IHRoZXJlIGFyZQ0KPiBkZWxlZ2F0aW9uIHJldHVybiBSUEMgdGFza3Mg
aGF2ZSBub3QgYmVlbiBleGVjdXRlZCB5ZXQgd2hlbg0KPiBuZnNfZnJlZV9zZXJ2ZXINCj4gaXMg
Y2FsbGVkIHRoZW4gdGhpcyBjYW4gY2F1c2Ugc3lzdGVtIHRvIGNyYXNoIHdpdGggZ2VuZXJhbCBw
cm90ZWN0aW9uDQo+IGZhdWx0Lg0KPiANCj4gVGhlIGNvbmRpdGlvbnMgdGhhdCBjYW4gY2F1c2Ug
dGhlIGNyYXNoIGFyZTogKDEpIHRoZXJlIGFyZSBwZW5kaW5nDQo+IGRlbGVnYXRpb24NCj4gcmV0
dXJuIHRhc2tzIGNhbGxlZCBmcm9tIG5mczRfc3RhdGVfbWFuYWdlciB0byByZXR1cm4gaWRsZQ0K
PiBkZWxlZ2F0aW9ucyBhbmQNCj4gKDIpIHRoZSBuZnNfY2xpZW50J3MgYXVfZmxhdm9yIGlzIGVp
dGhlciBSUENfQVVUSF9HU1NfS1JCNUkgb3INCj4gUlBDX0FVVEhfR1NTX0tSQjVQDQo+IGFuZCAo
MykgdGhlIGNhbGwgdG8gbmZzX2lncmFiX2FuZF9hY3RpdmUsIGZyb20NCj4gX25mczRfcHJvY19k
ZWxlZ3JldHVybiwgZmFpbHMNCj4gZm9yIGFueSByZWFzb25zIGFuZCAoNCkgdGhlcmUgaXMgYSBw
ZW5kaW5nIFJQQyB0YXNrIHJlbmV3aW5nIHRoZQ0KPiBsZWFzZS4NCj4gDQo+IFNpbmNlIHRoZSBk
ZWxlZ2F0aW9uIHJldHVybiB0YXNrcyB3ZXJlIGNhbGxlZCB3aXRoICdpc3N5bmMgPSAwJyB0aGUN
Cj4gcmVmY291bnQgb24NCj4gbmZzX3NlcnZlciB3ZXJlIGRyb3BwZWQgKGluIG5mc19jbGllbnRf
cmV0dXJuX21hcmtlZF9kZWxlZ2F0aW9ucw0KPiBhZnRlciBSUEMgdGFzaw0KPiB3YXMgc3VibWl0
ZWQgdG8gdGhlIFJQQyBsYXllcikgYW5kIHRoZSBuZnNfaWdyYWJfYW5kX2FjdGl2ZSBjYWxsDQo+
IGZhaWxzLCB0aGVzZQ0KPiBSUEMgdGFza3MgZG8gbm90IGhvbGQgYW55IHJlZmNvdW50IG9uIHRo
ZSBuZnNfc2VydmVyLg0KPiANCj4gV2hlbiBuZnNfZnJlZV9zZXJ2ZXIgaXMgY2FsbGVkLCBycGNf
c2h1dGRvd25fY2xpZW50KHNlcnZlci0+Y2xpZW50KQ0KPiBmYWlscyB0bw0KPiBraWxsIHRoZXNl
IGRlbGVnYXRpb24gcmV0dXJuIHRhc2tzIHNpbmNlIHRoZXNlIHRhc2tzIHVzaW5nDQo+IG5mc19j
bGllbnQtPmNsX3JwY2NsaWVudA0KPiB0byBzZW5kIHRoZSByZXF1ZXN0cy4gV2hlbiBuZnNfcHV0
X2NsaWVudCBpcyBjYWxsZWQsIG5mc19mcmVlX2NsaWVudA0KPiBpcyBub3QNCj4gY2FsbGVkIGJl
Y2F1c2UgdGhlcmUgaXMgYSBwZW5kaW5nIGxlYXNlIHJlbmV3IFJQQyB0YXNrIHdoaWNoIHVzZXMN
Cj4gbmZzX2NsaWVudC0+Y2xfcnBjY2xpZW50DQo+IHRvIHNlbmQgdGhlIHJlcXVlc3QgYW5kIGFs
c28gYWRkcyBhIHJlZmNvdW50IG9uIHRoZSBuZnNfY2xpZW50LiBUaGlzDQo+IGFsbG93cw0KPiB0
aGUgZGVsZWdhdGlvbiByZXR1cm4gdGFza3MgdG8gc3RheSBhbGl2ZSBhbmQgY29udGludWUgb24g
YWZ0ZXIgdGhlDQo+IG5mc19zZXJ2ZXINCj4gd2FzIGZyZWVkLg0KPiANCj4gSSd2ZSBzZWVuIHRo
ZSBORlMgY2xpZW50IHdpdGggNS40IGtlcm5lbCBjcmFzaGVzIHdpdGggdGhpcyBzdGFjaw0KPiB0
cmFjZToNCj4gDQo+ICEjIDAgW2ZmZmZiOTNiOGZiZGJkNzhdIG5mczRfc2V0dXBfc2VxdWVuY2Ug
W25mc3Y0XSBhdA0KPiBmZmZmZmZmZmMwZjI3ZTQwIGZzL25mcy9uZnM0cHJvYy5jOjEwNDE6MA0K
PiDCoCAjIDEgW2ZmZmZiOTNiOGZiZGJkYjhdIG5mczRfZGVsZWdyZXR1cm5fcHJlcGFyZSBbbmZz
djRdIGF0DQo+IGZmZmZmZmZmYzBmMjhhZDEgZnMvbmZzL25mczRwcm9jLmM6NjM1NTowDQo+IMKg
ICMgMiBbZmZmZmI5M2I4ZmJkYmRkOF0gcnBjX3ByZXBhcmVfdGFzayBbc3VucnBjXSBhdA0KPiBm
ZmZmZmZmZmMwNWUzM2FmIG5ldC9zdW5ycGMvc2NoZWQuYzo4MjE6MA0KPiDCoCAjIDMgW2ZmZmZi
OTNiOGZiZGJkZThdIF9fcnBjX2V4ZWN1dGUgW3N1bnJwY10gYXQgZmZmZmZmZmZjMDVlYjUyNw0K
PiBuZXQvc3VucnBjL3NjaGVkLmM6OTI1OjANCj4gwqAgIyA0IFtmZmZmYjkzYjhmYmRiZTQ4XSBy
cGNfYXN5bmNfc2NoZWR1bGUgW3N1bnJwY10gYXQNCj4gZmZmZmZmZmZjMDVlYjhlMCBuZXQvc3Vu
cnBjL3NjaGVkLmM6MTAxMzowDQo+IMKgICMgNSBbZmZmZmI5M2I4ZmJkYmU2OF0gcHJvY2Vzc19v
bmVfd29yayBhdCBmZmZmZmZmZjkyYWQ0Mjg5DQo+IGtlcm5lbC93b3JrcXVldWUuYzoyMjgxOjAN
Cj4gwqAgIyA2IFtmZmZmYjkzYjhmYmRiZWIwXSB3b3JrZXJfdGhyZWFkIGF0IGZmZmZmZmZmOTJh
ZDUwY2YNCj4ga2VybmVsL3dvcmtxdWV1ZS5jOjI0Mjc6MA0KPiDCoCAjIDcgW2ZmZmZiOTNiOGZi
ZGJmMTBdIGt0aHJlYWQgYXQgZmZmZmZmZmY5MmFkYWMwNQ0KPiBrZXJuZWwva3RocmVhZC5jOjI5
NjowDQo+IMKgICMgOCBbZmZmZmI5M2I4ZmJkYmY1OF0gcmV0X2Zyb21fZm9yayBhdCBmZmZmZmZm
ZjkzNjAwMzY0DQo+IGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MzU1OjANCj4gwqDCoMKgwqDC
oMKgwqDCoCANCj4gV2hlcmUgdGhlIHBhcmFtcyBvZiBuZnM0X3NldHVwX3NlcXVlbmNlOg0KPiDC
oMKgwqDCoMKgIGNsaWVudCA9IChzdHJ1Y3QgbmZzX2NsaWVudCAqKTB4NGQ1NDE1OGViYzZjZmMw
MQ0KPiDCoMKgwqDCoMKgIGFyZ3MgPSAoc3RydWN0IG5mczRfc2VxdWVuY2VfYXJncyAqKTB4ZmZm
Zjk5ODQ4N2Y4NTgwMA0KPiDCoMKgwqDCoMKgIHJlcyA9IChzdHJ1Y3QgbmZzNF9zZXF1ZW5jZV9y
ZXMgKikweGZmZmY5OTg0ODdmODU4MzANCj4gwqDCoMKgwqDCoCB0YXNrID0gKHN0cnVjdCBycGNf
dGFzayAqKTB4ZmZmZjk5N2Q0MWRhN2QwMA0KPiANCj4gVGhlICdjbGllbnQnIHBvaW50ZXIgaXMg
aW52YWxpZCBzaW5jZSBpdCB3YXMgZXh0cmFjdGVkIGZyb20gZF9kYXRhLQ0KPiA+cmVzLnNlcnZl
ci0+bmZzX2NsaWVudA0KPiBhbmQgdGhlIG5mc19zZXJ2ZXIgd2FzIGZyZWVkLg0KPiANCj4gSSd2
ZSByZXZpZXdlZCB0aGUgbGF0ZXN0IGtlcm5lbCA2LjYtcmM3LCBldmVuIHRob3VnaCB0aGVyZSBh
cmUgbWFueQ0KPiBjaGFuZ2VzDQo+IHNpbmNlIDUuNCBJIGNvdWxkIG5vdCBzZWUgYW55IGFueSBj
aGFuZ2VzIHRvIHByZXZlbnQgdGhpcyBzY2VuYXJpbyB0bw0KPiBoYXBwZW4NCj4gc28gSSBiZWxp
ZXZlIHRoaXMgcHJvYmxlbSBzdGlsbCBleGlzdHMgaW4gNi42LXJjNy4NCj4gDQo+IEknZCBsaWtl
IHRvIGdldCB5b3VyIG9waW5pb24gb24gdGhpcyBwb3RlbnRpYWwgaXNzdWUgd2l0aCB0aGUgbGF0
ZXN0DQo+IGtlcm5lbA0KPiBhbmQgaWYgdGhlIHByb2JsZW0gc3RpbGwgZXhpc3RzIHRoZW4gd2hh
dCdzIHRoZSBiZXN0IHdheSB0byBmaXggaXQuDQo+IA0KDQpuZnNfaW5vZGVfZXZpY3RfZGVsZWdh
dGlvbigpIHNob3VsZCBiZSBjYWxsaW5nDQpuZnNfZG9fcmV0dXJuX2RlbGVnYXRpb24oKSB3aXRo
IHRoZSBpc3N5bmMgZmxhZyBzZXQsIHdoZXJlYXMNCm5mc19zZXJ2ZXJfcmV0dXJuX21hcmtlZF9k
ZWxlZ2F0aW9ucygpIHNob3VsZCBiZSBob2xkaW5nIGEgcmVmZXJlbmNlIHRvDQp0aGUgaW5vZGUg
YmVmb3JlIGl0IGNhbGxzIG5mc19lbmRfZGVsZWdhdGlvbl9yZXR1cm4oKS4NCg0KU28gd2hlcmUg
aXMgdGhpcyBjb21iaW5hdGlvbiBubyBpbm9kZSByZWZlcmVuY2UgKyBpc3N5bmM9MCBvcmlnaW5h
dGluZw0KZnJvbT8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
