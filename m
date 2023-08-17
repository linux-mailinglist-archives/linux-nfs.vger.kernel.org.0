Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8994777EF18
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 04:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbjHQCaX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Aug 2023 22:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjHQC36 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Aug 2023 22:29:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2121.outbound.protection.outlook.com [40.107.237.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7CC26A8
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 19:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBhRe+tcyavBY+r3Fjbtb/LIS6+nfFqu0keFNWFJSOW/vBXsbAyDVfVHxk3DBOzSVmB+Rma3kAoJki+yT29jwV/wylSGOmeDL6+LQ0E+BfQxlSsZr6TZbojcGvEodgJz9LEPjoou2nCSi2nl3y502iUHTPxcLHlMbiFrYIqnOz0s/bSsE9EknDKvHl3QkBi9G8nN6KySmLb34sI3inNlZl3L7O8mlvxlgS6qEXI/FueLgmqB+QEPGUME7rlh8jFYa6nDHozLQYZBOkN3HLrtmV6dZtWQx+4l7sXkrVpf3D36XUNPrlM/0qlAV1z3tJ3aNH/tB3GvvPyGEb0Jo/KgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeS+5+7O4ZGZ2fDOwOXbMkgbXtlt1yRA6TorWBqqJKU=;
 b=K+3oXteX1y7SObs6su65b9m6ZP+8wUKOKwUWEHR6FMNLGDRJqLgNyJRN+TBFCvBbFuHpqrIC2vh8pqkckwSDbX2IHDF4SZJ2iSt4FIKSUXsrRYGcpWrnswTCDtWcHkTi3M1Gp5+p8n/Gu6FHUCVK5YDDwh2G8ht6ZqgJsy/2XbFxJG/w6hhXML/Tsbpg079A0iEfoEZveH9sfGWApTemxfO8AZ2PtQCV30S74Jn3FY+M7ZeYt+WZiaCab1435hNfxrlDhw0grQEtT84zx9n4uVgllaYL5thDtzFHv327yX7Mb+gGBXkM13ucZ7y0c+edv4aBxo0sfuz6OlCX7f+Fkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeS+5+7O4ZGZ2fDOwOXbMkgbXtlt1yRA6TorWBqqJKU=;
 b=HFzsXqUti/SJ/rZYl4RDgcarqGjOfMw2MQdv806LvWgdBJvQFSbdW4ixJxZUMOlE0His9OXCI6uxeB4MqZKAS7Qb6dABpc7HP8Qkukskurxvhvfy/6GMmrVQNqd1/GIQxGo603603Ea/naoK1YGLeOG4GU4W7QyurNfZM00h0mg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3837.namprd13.prod.outlook.com (2603:10b6:208:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 02:29:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 02:29:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "jrife@google.com" <jrife@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Avoid address overwrite with eBPF NAT
Thread-Topic: [PATCH] SUNRPC: Avoid address overwrite with eBPF NAT
Thread-Index: AQHZ0K0ihqQBjpr9f0S0sDLmPXicF6/tvlaAgAAFtYA=
Date:   Thu, 17 Aug 2023 02:29:52 +0000
Message-ID: <545e445a56bdd9b0befa49610d4330c7c3cd32a3.camel@hammerspace.com>
References: <20230817014808.3494465-2-jrife@google.com>
         <96353f2cafa6e06cac240aeaab47a1eac177b07a.camel@hammerspace.com>
In-Reply-To: <96353f2cafa6e06cac240aeaab47a1eac177b07a.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3837:EE_
x-ms-office365-filtering-correlation-id: bb38a648-bb9a-4c8c-c1c6-08db9ec9d6ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZnjbau+vt7ayKzVxFjguM56bpuZA9D0qRpfhImMX5k4irEhVPK83HqsWxWLl41ccBl9tJEtVPUAtR+ci6m4jPDHemMW7cjEKhrrgRw1SCPFWMx40blMUerIPcepmGmy2mcV1hsTJVSwMUtZg8Py6BpS59JAjK06bVUTs1GDjfLVfXgQ34uLc5rR9DsWJoCDU/+nZXG7UPFhn/FA0/+gJBHQwumn7KQIgETtCvsc+5z9Y/r9k9gAI58edC19hHRY1OqMCIsTaTBh8LWjwwa5gkF1UAE/ZUp292Bupil+ybFYC7vUJaBvPxV0Yqa7fZO1/0GttGI4b164zhBWccjY0x87V5nAsk8IID5WU6BFCi/EL/xT230xO/27qJvBQh0o8Y9/pMMtmy/CVpQcTuucRkaCE5yvC3wr8DDF1icJMIgyr4425YLxxdB8Mn7x5fhHWaM0Meg41BxPQQ1v58X6lxKtsXgw2Cuzymv1UyhYCTMvghKyiGeeVZgEFxGqA0xuLCi35+MqOR/p3n/62l8ZDlbK8zSfww7PGuXIxf7NpFjldNMICbw3Q6cFFP89h0+IK43tyzROLegjjXr2GvgBvDwgTYgR0j2bJUfuxkgxc2KpYN4vzjyzu40Ru4iuiv0oy/pfgm62113Bomoz5s67hmK6JMcOJh24icJetxHcAdmFKre2GbXUghHt90TLVqRhahAB5mRczgmUGKPM8g9FUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(366004)(346002)(376002)(396003)(1800799009)(451199024)(186009)(316002)(66556008)(66476007)(66446008)(66946007)(110136005)(76116006)(64756008)(12101799020)(5660300002)(41300700001)(2906002)(966005)(478600001)(8676002)(8936002)(86362001)(4326008)(38070700005)(38100700002)(6486002)(122000001)(6506007)(71200400001)(6512007)(2616005)(26005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3o1ekJTeUVTeGpzV2RVQ0RYQi9WNlJkZGpXYzBuZW9IcWhoWFZoUTcyZkN6?=
 =?utf-8?B?Y2tJOEpWKzJDcy9wZ0Q4NWRoVnUzTStxL1JhU05UQlY5YnJpcFJzY1J4QnAy?=
 =?utf-8?B?bDQvY0I2QW5LSkw1dDVmdGlCZ3NhdFNWM3c5T09pYzNvWk1BaTlYeHY5WlJT?=
 =?utf-8?B?S2hQNGxrWXZrNW9sdFBuM2pNb3p5RFluVGRzLzlCSGlKRTVmRDkyNGwrT2xV?=
 =?utf-8?B?R1ljUVJhVVFOcW12UjFkWGpSWitvTXg3WHQvWVN4VzVTOERhMjVxNVVtbUgv?=
 =?utf-8?B?TWNsU0diMG9JNFNsc1VhSXpIeDBjVGxSbDBQK1pETFRkM0JweG1STFNwTFFV?=
 =?utf-8?B?VXZFeFpHbzZIUENqcVNwZXZtTFVvTVdQWmF2ZUVNcHdzZmJSMXFSaUtOL1FT?=
 =?utf-8?B?T2VwMUZIS0JwUnQ5NXA0T3NSd05zQjA3ZFFMQlJkQy9Jc3FkQnJ6enhlQy81?=
 =?utf-8?B?c1dhb1BJNzE2ZDRoWHFPaExadVBYQmYxc0VNaXhsRWJmQmxHVm54bUJFQTA5?=
 =?utf-8?B?eHQyOEY2eHUwcytzOUtWcU85NU1hcmFxcUMyREZueEV0Z1Z2UGMrR2JxYzBU?=
 =?utf-8?B?dEZ3ZTh3QUlIYXp1U0xlZGwyTmdaQzJqc1lQdmJYK1g2cThqdkQvNlAvZ3lG?=
 =?utf-8?B?Q2lwMmxUTFErcndHWkxHbks0a3ZnUHVoWUdheFBuRG5ISkY5MnF1ZlRXUUNC?=
 =?utf-8?B?dnBRak1GeDJRME1UNTJtNUJsckRuRFJ1VDd2WGNoVFZBRmxQV3ZZajBHdXM0?=
 =?utf-8?B?NUFORnR6OUlpTGY3YXVyTkQrWnRTc1M1c0s3b2tpbHJCYXh5MlB1N0FxL1Vi?=
 =?utf-8?B?Y3REOXRQRmkxSEc0MCtTYmpXcFc3WHNBVHFRVmp1SnJWN1lWSzh6b0xpcVQ4?=
 =?utf-8?B?QlNSbHVxUHk2cEdXMVE5QUhaZFc5UmIrbVp4dUlXTlN6T0sxRktpTWplNWtR?=
 =?utf-8?B?dDRmMXlyWGJudlBFb1duTFFGYUovK2NkMTJUVGhFTXovVXRLQVE0WWJSVVBr?=
 =?utf-8?B?VWoxZ3RtbW9NcGxnSUNYd1FTOWpNRVp4RUtmVlQ0RDduMVBQS3p4WEN1YXZ1?=
 =?utf-8?B?enhXY2t5OUVTTEVJQzZSMWx5QU9RT1ZGaitXWi9TUGd3UzR1MHh1NGZwSGNi?=
 =?utf-8?B?WkhnVmxHQmNXbWF2RWZoZGc0bFVhdXorUDNuYmJURXIwQjJzcG8ybVZWSm50?=
 =?utf-8?B?M2ZVWGdwUUc0emJaV3ZFNy9Bb3NBK0pveDFLNndGb1VSUTYxVXF6Z0dNWGVm?=
 =?utf-8?B?K3JXTTdKZHlTdTREa3hiUnNGb2NCTlVPMWZaeUhDWVV6U2ZaQnZMVnlIeGli?=
 =?utf-8?B?ZEMvb1F3Rms4eG4yUHlPcGpkOWlReUVKN2RsS3RmdzFPdDF0YXdzYWFiS01r?=
 =?utf-8?B?OTVlcE1KTklzWWc2U0pWQ3YvL2p3cXJGbVBhRng4TlFYeE5GdVlHSmdDdkht?=
 =?utf-8?B?Y2kwdkpoSUpjRHlWbE12VlVDa2pBZTdYS2xVaGp2UlhPQzh1Qk51RFByWnNK?=
 =?utf-8?B?YnhlTW11QzVZaGxUWVpIdUE3ZXlDMTRwZVYxUzRXNjgwbGlQTGNxQ1I0cUd2?=
 =?utf-8?B?U0IvcWg0SlI3WDV5ZUdOZHRiMVpnZXN3NUQ4RU9jcFJ6YllPNDhpNDFwZmll?=
 =?utf-8?B?aWVWRDhwQWs0bW1jMjV2bzhyT2RQUUxpOFVXaEl4L2wvMkp3Y1pyRDdIeGlN?=
 =?utf-8?B?OU5xZ0d1L2xkMFM5LzF2Zng1OVF6UEx1bmk1dk8zNWpxVXVIWTVyeDBuSzdY?=
 =?utf-8?B?Vmdicy83UkdXM3NlUFIwcExueHhMekt5RTZZTW9pNGdyMWlUUnIzUFZYeXBm?=
 =?utf-8?B?Z2N4QVhuYjdObkZja1Zubk1PWTcwUlduOGtINlJpSGFrWXVzK1lJYmFUNE1u?=
 =?utf-8?B?N2c4ZE5sZExCSUxZOWQ0ZWU2NEtVcmI2c1MrRCt6V2dOSVFSR1I5TENPUVJX?=
 =?utf-8?B?ZlNNUVh4d1IyMXR3ZGZ0ekZDL0w2aXFBUWU4bktMazY2TE02V0ZWOXQwV3JM?=
 =?utf-8?B?enFmQkpEVUpvcGpKRVhsZHJTNmRxTFAxblBiR1ZJZ0hWTXNrVDFTend0ZTZW?=
 =?utf-8?B?VlZFM2N4NENOUXQ3cmpoU3dhamIxVGZKUW5iOWFrNFRsMTIvWXdsdmwyNHZP?=
 =?utf-8?B?TGNwL21GcmduRnVYNXRtUnhCRUlmQkZ3b0hveHcxNFZIZkU1M1lTc0ZaMHl5?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B51DFC0A8B1BA4FB617BC189037BEE5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb38a648-bb9a-4c8c-c1c6-08db9ec9d6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 02:29:52.9970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42jLkpTDY43S6S5twhsdPhpq5p0YntfCYlTXDIaS/zPljY55Mn1LXIEfvbqrZhemC0Abavlc77fg1BizOUOSZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3837
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTE3IGF0IDAyOjA5ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyMy0wOC0xNiBhdCAyMDo0OCAtMDUwMCwgSm9yZGFuIFJpZmUgd3JvdGU6
DQo+ID4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBqcmlmZUBnb29nbGUuY29tLiBM
ZWFybiB3aHkgdGhpcyBpcw0KPiA+IGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFi
b3V0U2VuZGVySWRlbnRpZmljYXRpb27CoF0NCj4gPiANCj4gPiBrZXJuZWxfY29ubmVjdCgpIHdp
bGwgbW9kaWZ5IHRoZSBycGNfeHBydCBzb2NrZXQgYWRkcmVzcyBpbg0KPiA+IGNvbnRleHRzDQo+
ID4gd2hlcmUgZUJQRiBwcm9ncmFtcyBwZXJmb3JtIE5BVCBpbnN0ZWFkIG9mIGlwdGFibGVzLiBJ
biB0aGVzZQ0KPiA+IGNvbnRleHRzLA0KPiA+IGl0IGlzIGNvbW1vbiBmb3IgYW4gTkZTIG1vdW50
IHRvIGJlIG1vdW50ZWQgdG8gYmUgYSBzdGF0aWMgdmlydHVhbA0KPiA+IElQDQo+ID4gd2hpbGUg
dGhlIHNlcnZlciBoYXMgYW4gZXBoZW1lcmFsIElQIGxlYWRpbmcgdG8gYSBwcm9ibGVtIHdoZXJl
IHRoZQ0KPiA+IHZpcnR1YWwgSVAgZ2V0cyBvdmVyd3JpdHRlbiBhbmQgZm9yZ290dGVuLiBXaGVu
IHRoZSBlbmRwb2ludCBJUA0KPiA+IGNoYW5nZXMsDQo+ID4gcmVjb25uZWN0IGF0dGVtcHRzIGZh
aWwgYW5kIHRoZSBtb3VudCBuZXZlciByZWNvdmVycy4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIHBy
b3RlY3RzIGFkZHIgZnJvbSBiZWluZyBtb2RpZmllZCBpbiB0aGVzZSBzY2VuYXJpb3MsDQo+ID4g
YWxsb3dpbmcNCj4gPiBORlMgcmVjb25uZWN0cyB0byB3b3JrIGFzIGludGVuZGVkLg0KPiANCj4g
V2hhdD8gTm8hIEEgY29ubmVjdCgpIGNhbGwgc2hvdWxkIG5vdCBiZSBhbGxvd2VkIHRvIG1vZGlm
eSBpdHMgb3duDQo+IGNhbGwNCj4gcGFyYW1ldGVycy4NCj4gDQoNClRvIHB1dCBpdCBtb3JlIHN1
Y2NpbmN0bHksIHRoZSBzdHJ1Y3QgcnBjX3hwcnQgaXMgb25lIG9mIG1hbnkgcHJpdmF0ZQ0Ka2Vy
bmVsIHN0cnVjdHVyZXMuIFBhcnRzIG9mIGl0IGNhbiBiZSBleHBvc2VkIHRocm91Z2ggcHVibGlj
IEFQSXMsIHN1Y2gNCmFzIHRoZSBzeXNmcyBBUEkgdGhhdCB3ZSdyZSBidWlsZGluZywgYnV0IHdo
ZW4geW91IHVzZSBlQlBGIHRvIGhhY2sNCnlvdXIgd2F5IGFyb3VuZCB0aG9zZSBwdWJsaWMgQVBJ
cywgdGhlbiB5b3UncmUgb24geW91ciBvd24uIFdlJ3JlIG5vdA0KZ29pbmcgdG8gY29tbWl0IHRv
IHN1cHBvcnQgeW91ciBoYWNrcy4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
