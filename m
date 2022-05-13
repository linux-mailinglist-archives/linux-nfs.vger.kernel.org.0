Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6452659C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378548AbiEMPF1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 11:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379612AbiEMPFY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 11:05:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2092.outbound.protection.outlook.com [40.107.93.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40F15620A
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 08:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBuw1amEJi0J/9MPWRKiiUHu/4f6mlUj0LMx3tECnDGbtKSc5I1O1NnG1HTHpQUcTk4oHDo/7zSMnRgZoUYOqbRgDPkBEAy0i0dmRUhOA/ircIQAl2qf4Y/kVyNeLbRNI5iHk7mx9Mq557lLnUqIrk2AWk6th/9oeVB9wHObg1GsFJKkAEXHOUTo018qqAXLk6rQhW2u28rhWBYLeY2OZM4mV9Y+9f3cSj0mFPIurdw/SRv8qKfqdt9ZeRB7X+2TinYwPXJtDaKFACspJ4sKEvaf9jG0Hcoq+50+LMt5+15QZsXwLPKipRvTwrf84Jmu494z4HXYX4DgrczfxTSdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV9BolaBpdQWFHeTTwp3Rq6rrT1L411T3dl/fVRRxLo=;
 b=bTUY/6KhztbCGjHYKImuK5KVkUEddRm0pzuCaJ6Fm8/RXA0iG9nlPnp3AnuArm8cdYAYj00UaQir1D8KdbFv96Iow145ZDODf3rJRCosLL4/Dyb88/R1qC6GSO/YDwLv6Flc2uR+TEWCoVL2RuLcaqMk8nYZ+nawBwf6SK86wc+kXdsw1/fSZ2KXDhuN2K6KHOCTQIPQOcoocvL8oxN9dFplhOxhnYcij+DQF0U2W26CoYte04MUV7Byi2T9OT0KMOsyb/8Z/JICWa+SzU5gegFf+KOuRicclqBm6uzRTmbQiX00DayZEk7DcSEZ8Jxdca32m9ffN4kipxn/Af+sKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV9BolaBpdQWFHeTTwp3Rq6rrT1L411T3dl/fVRRxLo=;
 b=LQBB5wjku4chcEkVg/XC6zXbP0LYlizG7jkLju26S5Bs4/G9AJhH9iIrkmQCZu1pcnQ4lOsQD/U3gj8PBfENRBrAefk95vwol0J19tJOZv8rzDUPlWY64aXYtYE0zm3CYJglAdr4UDbZL/n/5weCDanr/arZWgkNAX6KYGkIXZk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB4629.namprd13.prod.outlook.com (2603:10b6:408:120::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5; Fri, 13 May
 2022 15:05:22 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5273.005; Fri, 13 May 2022
 15:05:22 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>
Subject: Re: [PATCH] NFSv4: Restore nfs4_label into copied nfs_fattr for
 referrals
Thread-Topic: [PATCH] NFSv4: Restore nfs4_label into copied nfs_fattr for
 referrals
Thread-Index: AQHYZs5rTVTxaQPiRUW4hzLTTb+kR60c6BwA
Date:   Fri, 13 May 2022 15:05:22 +0000
Message-ID: <cd3b333cc9d3a4eb5c1d1f185dbb101a5e59f91e.camel@hammerspace.com>
References: <8ffe993a7aa39881d3e610d5424098ea7ec88180.1652448889.git.bcodding@redhat.com>
In-Reply-To: <8ffe993a7aa39881d3e610d5424098ea7ec88180.1652448889.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 820c91fc-b7b7-403c-00e1-08da34f20088
x-ms-traffictypediagnostic: BN0PR13MB4629:EE_
x-microsoft-antispam-prvs: <BN0PR13MB46292D5A2371E1BC0190990DB8CA9@BN0PR13MB4629.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x6EMQvJ88MAHiLzCrubqOgKpmo1JEuEmzSwJbSKdXleTgAKtfriq7GPpAIMaak6MqO3q2LmomJB/pWSMXs4Si3QRC9R9Cwkm3UI6HeAHy5PQ/oz/agON62SP34My/0FZv3JzARxI9+GP6B+PUfp1HaeB27v+BHqLH1ciYo4vHzeTPj0+1siGzGis7/rTKeo2irQ7OI1eCDFF/2TAJCwawvdC9guV8u/KSh9qe8vSCtABJkE/k3EWvI1CPjw9E5AYa3IxXLXYBb0Gu3CiYW4l2y55No5IxIy9klIrPZvgWLAJaOhwUfZyOPkApzYp+nywfIpcWZJIKruq54gzzVxQTLdLds7k1BBhbv0LJl2/H1hOYPROju///CZ0qsgGmzAyypl3dJ6Jwtn4Tvdk8ILjRCWe/AytPX0hZ6dGxl6Zi7euF70QWzs6Vy7QvCfGin5zNdYgvW7FkF/uyDlvPB0Bk936LN0zdVf+Hd0DZ7+y86HqrfeE0lqCdBPiRufNUAQpLxuVBnCzhBwEiQVfZ0m2wvlUGy+d2rdZaxXJEBmLxTaPKQwluxOy6AagXwRuiF96Jc35Ry6wipKxyj2UMGCpbWKJhAoQKPeyxqLmxhY9/+HU1lKIu4byATdA51qWkZb2nEhHbN5Qdz1HFrr9tXQzUeKfWTgXNFDtUvr/Lwdgb7jB8Yime7bHSzYSUEvz8Ujgf2mGXgKpFmicwjmh0OI1Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(4326008)(316002)(6512007)(2906002)(2616005)(110136005)(54906003)(122000001)(38100700002)(6506007)(38070700005)(36756003)(66476007)(66946007)(64756008)(71200400001)(66556008)(8676002)(66446008)(76116006)(8936002)(26005)(508600001)(6486002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTM4cVJLR3g4NHp2RGNpWk5zeU4vSUlQMmFZM3Y3bGNDNEJzaE8vQkFJWXYw?=
 =?utf-8?B?TUh6QUczSnNlK2crZTJlUWdjYkR0NWVyOCt2U3VBUjB0VUxlS1lYR0Q2SUNH?=
 =?utf-8?B?amN0YmFKM2h0TDVTOEU5R1FCNWhHOCtrK040V1BMOGlUVE03SmJ2R3pSa3pY?=
 =?utf-8?B?SjVzemVUSGJ1MnY2c3JYNEtpYnRwUTlqOWpDc0czN1NOV0txdkxaU1VUd3Zm?=
 =?utf-8?B?dHhHK3dPMmZudklIOFhPUTd3Y29oVkJSY2taZXdQWFdoajdrdXZLeWl6UVRF?=
 =?utf-8?B?M1lydmpSKzRyZWZ1Q3VrZHhVR3Z3S0wrZmpkUys2ZHIvaEltOVVwOWV4QTNz?=
 =?utf-8?B?c3dIRVdPMzJocDZIRXQ2TnhrSUMxL1VvYjVuVDJ6cXJ3WXJoV0ZDRVZTa3Bs?=
 =?utf-8?B?NUFSeE12NTNVRnlnZnpkZjh3cjdaUmxpeDhaU0ZRUjhZWU92blJTU0VNQmxN?=
 =?utf-8?B?Y2d2MG1RVGNUNTV3NU8wUk1YTjFkRXUrTW54c3IzdzBQWldVTnV6K1FwRFA3?=
 =?utf-8?B?REdjSjY5QWM2eEpJYS9aN0J3YlBFR1RXVDFwNitSdmo1clRXeUJRVWxpZ3dw?=
 =?utf-8?B?S3I3d2hXL3l0WU80VHQvaGVoSWpLZ1hWWFoxUHVyUVVUNUs3UHQ1VE51enla?=
 =?utf-8?B?Y2NQQytsY3dyclRhcWg1ZjFIa3J1VWFxNk54MTE5OTJicXhHRHpaaTNZbmtm?=
 =?utf-8?B?enY3YUovTlh1WlhjemsxUktGYzBKQXZtZ0l5RGtHS0pEVEhiNUh2MDRrMFlQ?=
 =?utf-8?B?MElJc3llOTZKOTBUVDZQMEoxWHdaaXU4QmdJbFAxUTZxZHIxNWhhWjgwRkJl?=
 =?utf-8?B?VjNDN25XOVZSaVZKQm9sTk5tZFdaVmxpbFRXWHMwL0g2VWUyN3l0aFRYcW9N?=
 =?utf-8?B?MWllZ3ZsbjJTaUFUbytvVDNwaFo4S0FJd1d3VWlkZllzYnN0d1BpVU8vTGhM?=
 =?utf-8?B?akpSUlhia3VtKzNFUlZjYy92b3B0NnByQmlpZGQxQVhoNFo0YURQc1o5V040?=
 =?utf-8?B?N3Z4amJVdjVmTWRsRHlZTFZxSVYxTVYrV3JVYWx4Y1YxN0pYbnVnQTRpM3BX?=
 =?utf-8?B?N0JGY1owc0dZUElYWUpmS3pqRW9ob3RuMGgyYnU2dDQzdS9uZzhpbDNCQU9F?=
 =?utf-8?B?M09XZkpTV2JTejliQVNxQTFsNjBCUXdWak5VWFhWcDMzSjR1VFBNUlRFY0wx?=
 =?utf-8?B?ZEtHYTZHSExmSWU4WUs4TldCM21qN0huZHBFemd2U3Z5bk5BaW9ZRDY1NS9F?=
 =?utf-8?B?VWd4OVkyRUpMTVQ2dEJwWEd0U1ZTelM4dzIrdUQ0VWRHd2ppV0lvWDMweFpZ?=
 =?utf-8?B?Nk8xZk5mYW1hdE1JVElxTWNWUThLRVhTaG01NUJiZUpCNVR2WDlKZGc2K1Fz?=
 =?utf-8?B?NzhaSkNJT2Z6L3hmelFhVkpPeUJJQjlnQm1zNG9id3RBSy81bUw1cFhUMUE0?=
 =?utf-8?B?MjhHcHBkSjRhRGV2R2FGN1ZjNVNrZjF4MDlQZFRtS2F2SDVZTDlLdGxtVERq?=
 =?utf-8?B?VE5MRXd2b2svWFc4bVVSVXFSS3hTbWNNbVBQVUhvblVxd3hncUVKSjNZZHhY?=
 =?utf-8?B?eUtKRDZ3U1plSUJpQUpYQmpnbmZGQUdpb0hTVzlLeVY5ajVVNksrNmkwY0lX?=
 =?utf-8?B?YVlhTTVRa2w5T0pheEpqNWE3dmNoMjd2UUVzY2phb3A3WUNtd0VQS3NieVpp?=
 =?utf-8?B?RmtqNGgwdEJGdHY3SEhDT0YyVFd0YTZBdnJlZkNDMnhFRHY5R2Jjb3RKTjNs?=
 =?utf-8?B?NHdxV2IrYVNwK21kVGtZSE5DY0RaSG1PMTdwMGEvZk4vdVQrYlkvUzJKY1Iw?=
 =?utf-8?B?UzVtU0oxcE9uZkJQQkFsZHBTWmdRRUtXcitQdVc3MlVWOEQ1b2x2eWpnZlp6?=
 =?utf-8?B?RjlNTWRkSVFjYm5ySFNLTUpNUkg0UzRLMmgzZC9hRnBHOTBMNy9NSmFkM3dv?=
 =?utf-8?B?UkMrQ3RpYmZXZjA0UFk0OGt3SVMwVUROUmZDaFdYUmE5N3FhNCtkaWcxQ2Fp?=
 =?utf-8?B?Rm1PS3RoZWNNOHZwZTBLcUhLVGo5Z3Y0TzZ5ZnFiWDBMbEcyTkdOZGtPSjQ0?=
 =?utf-8?B?alljeGtMN2dtTUpNL2lPRTdiTjlCNFBWQTZVeFkwSzRwOTVsNkNOcERIZ0tn?=
 =?utf-8?B?aUpGVEdkcGdWTUYvYUw1Z2dqaEFMSUtNSlJQRmZNdUwyUXFla2FISXRMaS9T?=
 =?utf-8?B?aXUxZVhxN3hxaEwrTWhVZTZlMzBoUW1XK1FEOVVwdkpqV1RxVGZIbll3Mndt?=
 =?utf-8?B?bzJyK2FTWXA1Nzc1Tk5wdTVZVjd2ZWI0WkFiNDNKR213dlhMdHdPU2xtR1Js?=
 =?utf-8?B?Ymk2WFhmdTNGaklPaVV5OW95a0JjbE9OZXJHK0xJWkljT01PVGJXSFJ0Tzc5?=
 =?utf-8?Q?3jkcauQHK+EGk14Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FEA99028753AD47BF282D737A869B46@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820c91fc-b7b7-403c-00e1-08da34f20088
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 15:05:22.1677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3livT3gp/+EZUjIK5enghBMJ+/q95nJLCb0GUHtaKw8wxdqcEnsXXrh05XQ24qUQpYF8aGA3mmzBBt7Fs1HgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4629
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA1LTEzIGF0IDA5OjM2IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiAuLndoaWNoIHdpbGwgZml4IHVwIHRyeWluZyB0byBmcmVlIHVuaW5pdGlhbGl6ZWQg
bmZzNF9sYWJlbDoNCj4gDQo+IFBJRDogNzkwwqDCoMKgIFRBU0s6IGZmZmY4ODgxMWI0M2MwMDDC
oCBDUFU6IDDCoMKgIENPTU1BTkQ6ICJscyINCj4gwqAjMCBbZmZmZmM5MDAwMDg1NzkyMF0gcGFu
aWMgYXQgZmZmZmZmZmY4MWI5YmZkZQ0KPiDCoCMxIFtmZmZmYzkwMDAwODU3OWMwXSBkb190cmFw
IGF0IGZmZmZmZmZmODEwMjNhOWINCj4gwqAjMiBbZmZmZmM5MDAwMDg1N2ExMF0gZG9fZXJyb3Jf
dHJhcCBhdCBmZmZmZmZmZjgxMDIzYjc4DQo+IMKgIzMgW2ZmZmZjOTAwMDA4NTdhNThdIGV4Y19z
dGFja19zZWdtZW50IGF0IGZmZmZmZmZmODFiZTFmNDUNCj4gwqAjNCBbZmZmZmM5MDAwMDg1N2E4
MF0gYXNtX2V4Y19zdGFja19zZWdtZW50IGF0IGZmZmZmZmZmODFjMDA5ZGUNCj4gwqAjNSBbZmZm
ZmM5MDAwMDg1N2IwOF0gbmZzX2xvb2t1cCBhdCBmZmZmZmZmZmEwMzAyMzIyIFtuZnNdDQo+IMKg
IzYgW2ZmZmZjOTAwMDA4NTdiNzBdIF9fbG9va3VwX3Nsb3cgYXQgZmZmZmZmZmY4MTNhNGE1Zg0K
PiDCoCM3IFtmZmZmYzkwMDAwODU3YzYwXSB3YWxrX2NvbXBvbmVudCBhdCBmZmZmZmZmZjgxM2E4
NmM0DQo+IMKgIzggW2ZmZmZjOTAwMDA4NTdjYjhdIHBhdGhfbG9va3VwYXQgYXQgZmZmZmZmZmY4
MTNhOTU1Mw0KPiDCoCM5IFtmZmZmYzkwMDAwODU3Y2YwXSBmaWxlbmFtZV9sb29rdXAgYXQgZmZm
ZmZmZmY4MTNhYjg2Yg0KPiANCj4gRml4ZXM6IDk1NThhMDA3ZGJjMyAoIk5GUzogUmVtb3ZlIHRo
ZSBsYWJlbCBmcm9tIHRoZSBuZnM0X2xvb2t1cF9yZXMNCj4gc3RydWN0IikNCj4gU2lnbmVkLW9m
Zi1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+
IMKgZnMvbmZzL25mczRwcm9jLmMgfCAyICsrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25m
czRwcm9jLmMNCj4gaW5kZXggYTc5ZjY2NDMyYmQzLi40NTY2MjgwZTZmZjIgMTAwNjQ0DQo+IC0t
LSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IEBAIC00
MjM1LDYgKzQyMzUsNyBAQCBzdGF0aWMgaW50IG5mczRfZ2V0X3JlZmVycmFsKHN0cnVjdCBycGNf
Y2xudA0KPiAqY2xpZW50LCBzdHJ1Y3QgaW5vZGUgKmRpciwNCj4gwqDCoMKgwqDCoMKgwqDCoGlu
dCBzdGF0dXMgPSAtRU5PTUVNOw0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHBhZ2UgKnBhZ2Ug
PSBOVUxMOw0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG5mczRfZnNfbG9jYXRpb25zICpsb2Nh
dGlvbnMgPSBOVUxMOw0KPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzNF9sYWJlbCAqbGFiZWwg
PSBmYXR0ci0+bGFiZWw7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBwYWdlID0gYWxsb2NfcGFn
ZShHRlBfS0VSTkVMKTsNCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChwYWdlID09IE5VTEwpDQo+IEBA
IC00MjYzLDYgKzQyNjQsNyBAQCBzdGF0aWMgaW50IG5mczRfZ2V0X3JlZmVycmFsKHN0cnVjdCBy
cGNfY2xudA0KPiAqY2xpZW50LCBzdHJ1Y3QgaW5vZGUgKmRpciwNCj4gwqANCj4gwqDCoMKgwqDC
oMKgwqDCoC8qIHJlcGxhY2UgdGhlIGxvb2t1cCBuZnNfZmF0dHIgd2l0aCB0aGUgbG9jYXRpb25z
IG5mc19mYXR0cg0KPiAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgbWVtY3B5KGZhdHRyLCAmbG9jYXRp
b25zLT5mYXR0ciwgc2l6ZW9mKHN0cnVjdCBuZnNfZmF0dHIpKTsNCj4gK8KgwqDCoMKgwqDCoMKg
ZmF0dHItPmxhYmVsID0gbGFiZWw7DQo+IMKgwqDCoMKgwqDCoMKgwqBtZW1zZXQoZmhhbmRsZSwg
MCwgc2l6ZW9mKHN0cnVjdCBuZnNfZmgpKTsNCj4gwqBvdXQ6DQo+IMKgwqDCoMKgwqDCoMKgwqBp
ZiAocGFnZSkNCg0KVGhhbmtzIGZvciBmaW5kaW5nIHRoaXMsIGJ1dCB3b3VsZG4ndCBpdCBiZSBi
ZXR0ZXIganVzdCB0byBkZWNvZGUgdGhlDQpmYXR0ciBpbiBwbGFjZSBpbnN0ZWFkIG9mIGRlY29k
aW5nIGl0IGludG8gbG9jYXRpb25zLT5mYXR0ciBhbmQgdGhlbg0KZG9pbmcgYSBtZW1jcHkoKSB0
byBnZXQgaXQgcGxhY2VkIGNvcnJlY3RseT8NCg0KaS5lLiBhZGQgYSBsZXZlbCBvZiBpbmRpcmVj
dGlvbiBpbiBzdHJ1Y3QgbmZzNF9mc19sb2NhdGlvbnMgc28gdGhhdA0KbmZzNF94ZHJfZGVjX2Zz
X2xvY2F0aW9ucygpIGp1c3QgdXNlcyBvdXIgZmF0dHIgaW5zdGVhZCBvZiBpdHMgb3duLg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
