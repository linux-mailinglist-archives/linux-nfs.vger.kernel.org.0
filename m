Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E79B4C12B2
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 13:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiBWMYe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 07:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiBWMYe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 07:24:34 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2139.outbound.protection.outlook.com [40.107.243.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69999E57A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 04:24:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XixXW90aqlSzAeVH4MoU3lhgfOQjHpzdll56y8POo/tlMvqBF9ApXr1NI+hDMSyzCp1qmy8ex1FOAu61QdwBPwgx+V2Pem0LKSI8xKDwgLnlQclbzrlrWKY8lXrBzRjTWs4tlT87Xk00vNAVpO4TUzpXBwJXOt0CkazLeSkHGigkXWLzdhaWgLBVV8VJm8msRQ2H/J686iQGMzYWyYBToYL+jDa5mtdVs6i3jCorDCt4p7MC9v4OxC64cBKiABkYVwTpwdMQQElM0QAE68LvKIoq15vOR6fhDrGwM/C4nN4E8Bt9GiIiCQ1XUC17xpMBA0+T+ZETxqU4LQLZ6RQGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM/7fgkhHqYqfcdNeO+sKvnq3LLyJWYK+n9KaApo9UA=;
 b=ewZfqcKF6WaIA0SBGIXZA0vU6yHGYlKb1kc+BN+YQI8tZaJ0g28xjwyCz/VHkIbsAjb6IXZFkR3Eyqv9ImvXxuiYrZwIoPyv+UGaKVl7Tner5zBgT7n4kLe2fV75hazC/unnCRBefv2Mx/dHzlTZ7Fc5GvdBKX3ZtigovsFVq9iaSV0iSwHwkG/RO/Jg6QUzfCIUggE/lGHcy05HEoKTU4cO9z9XiwwawS7oQ2pZyWfW+P/tNpaH3NKEAoxAAGP79JJ9K1Cv2pZMPY6XNo/ZE0+GFTw6HbiM8k/+P8f3P4kYj0yBTBSrsnc7YYorq2x4ZM/za8C9xyfE1FLgEuT7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM/7fgkhHqYqfcdNeO+sKvnq3LLyJWYK+n9KaApo9UA=;
 b=cUenNStwaUl9UMO+1znQSnzvFHP0n55ukaNAuKtFxeqM+G0MEBOSbbu+190Xkzr808E5V9RnOkBtknJjsdXPUAxXGuEN1RIQ+Ma14Doz5X2FQIEafQN427xwICi1MTiP+LTsFQLHLuHvNi2bkYJK9xvFcj7feJljLng0aX9oGrc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3839.namprd13.prod.outlook.com (2603:10b6:208:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.19; Wed, 23 Feb
 2022 12:24:02 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Wed, 23 Feb 2022
 12:24:02 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "brauner@kernel.org" <brauner@kernel.org>
CC:     "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "l@damenly.su" <l@damenly.su>
Subject: Re: [bug?] nfs setgid inheritance
Thread-Topic: [bug?] nfs setgid inheritance
Thread-Index: AQHYJWjCc3uFudjLBEiBihXxNl6DhayavmkAgABbHICABb7IgIAAPVoA
Date:   Wed, 23 Feb 2022 12:24:02 +0000
Message-ID: <be3b341c4f0cf177b78f55de70cdb3a15ed808f4.camel@hammerspace.com>
References: <OS3PR01MB770539462BE3E7959DAF8B5789389@OS3PR01MB7705.jpnprd01.prod.outlook.com>
         <20220219113412.7ov4tbkisv4vnmo3@wittgenstein>
         <55aef6aa0e1825c1709051091c7bf849fccbda32.camel@hammerspace.com>
         <20220223084425.uq75dqfwymgfayus@wittgenstein>
In-Reply-To: <20220223084425.uq75dqfwymgfayus@wittgenstein>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d19ed879-4f90-48d2-fa59-08d9f6c7602d
x-ms-traffictypediagnostic: MN2PR13MB3839:EE_
x-microsoft-antispam-prvs: <MN2PR13MB383955C3632FF2719D32CD66B83C9@MN2PR13MB3839.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLklV16CQzoDGrF3PJDnVU1H072UKao18jGumJNqBKDvvOy+aoRSLohkb8zoID80Lh2z628e2X3UnmT6Q3lf1HTfMIXzJaqYtUIUgrhHF0vkmIU8TePV0YVtENPvNhtK9DKqVtusiLgmSj1bxXFyzHqZBMW9Pnc8hIBBvt5FIaiyXxJlrFd2e46BKURwNVdDnmiaob+fs9LvwZNpCtgUsbe6ycPIq+09/zSgNJ+qc/80gosqE9KhC+dJGsuNc723UNHqreYBtwwvKlgR0GQLP+RsJ0huTfYVmTJp92LW5OilnleTme7gRuTQst4L8/Upya84A877rp6Too69oFpmxoK2hXNEb728yDJxDcgVNuki5Q1vlJtclQ58ET9oQziG75ieGHCmQwp6CVl6L45tyHJsC1RlBo4wjRtL1e7fgDo1cYjsWNz3mrQ4lcMuuZMQ9WnvUr6h3q1pW9Pd2qXHn+t41hTeWVqTQ1BTy5Sk+1RfyWhYffoDxLHZJ5xhSlNrbq9y5WJVN4p1J5gvAN3ylNepPvcCmVtzo+z9v/UjduejLePmRB4razuLy0BgqKYWUWBALuBKY7o0UZGZYsGe75U4frH0MqZ/JIYpcCcThUcvqNc7lij6vCCu3ItlqtFhXilIlUidzM/xXSngekvmaYsKVYG6azHPnn/gsni0IrEjpGYhMwUOyT8IUpMgI8PA/VHpGCG9U8eMtoq3UYOJEx8+I27hVuJhx2LXF4b5yoBlLz1bCYbtze04fL/SbMM4Uy+6ofQ/0fEjeXx8yJBwUeH8W2XR//pJM4TFrvCwkNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(39840400004)(396003)(136003)(366004)(346002)(122000001)(54906003)(38070700005)(6916009)(316002)(38100700002)(6486002)(6506007)(83380400001)(6512007)(5660300002)(8936002)(508600001)(71200400001)(2616005)(4326008)(86362001)(2906002)(76116006)(66476007)(66556008)(36756003)(66946007)(186003)(64756008)(66446008)(8676002)(26005)(218113003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWQ5cXRzamhKSTdIb2ZpOTNkR05tVnlIcXdHRzZDOW1PcVV4Z1pJUldUc0Fy?=
 =?utf-8?B?K295Y2tFRmdCdEMzL1BscDJBWlZ6L0RJWng2eTNDUjdaTmlHeGxxY0MvTkkw?=
 =?utf-8?B?Q3hHelVvTXRYNGw4VUJDb0crZVFCdGV5NzV5OVh6Sy9JZlVQRTNkUml4ZVhI?=
 =?utf-8?B?MDBIZnlNMzRYTC91eTZuYlR3ZDd3TmFiVlRORDRUSnoxVTRWVnp2M2lmQ3BG?=
 =?utf-8?B?WUNqSUcvTlFaU01QMEt5VG5kZkVjVFJhNEpTdHkydlNrVldiK1ltbW9DLzhY?=
 =?utf-8?B?ek9rVmRPa01Jd0U0bFdCYjMxbERBOUJYbi9MSG9yK2J2ODdURThxTUx6WXpp?=
 =?utf-8?B?b0xSZzE3UG9QSGhscDFpTWtwZmRSMS85Nkp4TmczU05NcTk1MkJPWmw0anVy?=
 =?utf-8?B?VElaWHR1dXR2UjVLZW14TkVTVVpabC9aQ2x3UlZQbzQ5czRYS3hrRzZncmtE?=
 =?utf-8?B?Z0YyMjBZdVFPaHJBMkV5dkVqOUt6b0tBOEVOSk5CYlV3RVczNzZDRXBiQWh2?=
 =?utf-8?B?dnNuNzFKL241QkhOM1ZGaEIrOVoyNWQ1VVE3Zk80Z1JwRkt3LzY2Rzcvd25q?=
 =?utf-8?B?Y2xBdHl4d2lXdEVCd3BudlB6ZkROdVltc211dXRacUtQOC9RUkZFK3kwQVM2?=
 =?utf-8?B?VHBoWUlEWmNOU2trbjRKSm5QdkpET0x6a0wxZHo2Zk9kQ0ZDNTVlY21uMmJs?=
 =?utf-8?B?YmxBWHlyNm9OVGhqenljQmJjYzNoUWJzaXlkSk5ycXlscFA4eGprT1JMT1cz?=
 =?utf-8?B?MlUyYUFhdjF5NnRQdUJ0b0Q2aHpsaHIrVEJ5a0IwNUVzM0J4cGZpaU5zTjdG?=
 =?utf-8?B?aXR5WW5WYlVIL0J6VDVwblE3cXhCUnZPY0VoUEpjTXdsbmZsUG95WkpoVTVs?=
 =?utf-8?B?U2hXQTY0aXJHZGVUSys1VGlkL1llMk5OSlpZUkpiUWRaQ1M0c2hvLzdrMkUy?=
 =?utf-8?B?K0l1ZWdib0pHQ1dkOVp2TjlzNFhldzJwNWl2cmZseDdaWnhTZzZnd1V0QVNl?=
 =?utf-8?B?UklvaVlmdUpnTmZ2UjkyNzBEaTJzSjVFZlZ1eUFraEg0RHZadk9jUi9xeVgy?=
 =?utf-8?B?bGNmR0tpUVh4T3ZjRlA4WEJEcGpTc0NHTnc3c1lCNm9HcEk1SWp4eitFcGZn?=
 =?utf-8?B?bWg4Q1I2YlJoY1A4MkkwY3EwYytVY1lSYXpVSlpvM1MwZFhLTXpBeHlJckxo?=
 =?utf-8?B?WHN6OWRKQTBLRE9nSDdDNS9wYmt6RWt4TEZaRytEd1UyUHROL0F6cDhFYWlV?=
 =?utf-8?B?R3JTdXNyRnZxanZWaW9qYWl0QXZZVmw4SWIzNnF3NFc5TWJGclBuV3JTZW9K?=
 =?utf-8?B?ak5ZZG1RSE9zUEV2YVJucXl0WVZIcitNbHZUOWI5MHpMZTZOMDY4ZUsvS2xj?=
 =?utf-8?B?ZFg2S21SenZPT2lvRVZkUExZaEJnaDR6bGZBem5yaXFtNlo4bmRFTHQ0S3Bz?=
 =?utf-8?B?TVhTQk02SE14RDFZREpPcTYvL2NTZDNyT1JHTUhpTW15M1dNN1lYQ0hzdE1y?=
 =?utf-8?B?ZGNOZmV5dlBVdzg2K3d1UVdYVUgwZDBKYkI5aDR0bzRySThYeStzODJYWGJt?=
 =?utf-8?B?elMrSDFlTUpjdlRwTjRrNVF4NW1QWmJiQmJxVjZ3VUlFMkhQV1N3dUZIOVgz?=
 =?utf-8?B?SlRsK3ZCV1JxWllLNll6cDd3Q0ZqekRzR2ZhR2VNcUppU2NWWEZxUEJjRUY3?=
 =?utf-8?B?V3NacWpJZUlibVIzSmZyM1ExRDI3R0VMRmRadEIzYXB3YlNUTE16LzdLd082?=
 =?utf-8?B?L1d1a0hPMnljNFpoZmUycmdidisrTDJva1lNYWVON3JOWEIycGdMeDZoZkVh?=
 =?utf-8?B?YnJFQmQ4d0RJNG9kS3cwUEw1SGp0ZXdxQWNOODczaTd6SkZPeDlMb2pUNGtN?=
 =?utf-8?B?dWM1VkMzRnNINmxCL3dZZjhjdFJlMXB6cytESjBIaFZxL0srbkdpSjZTdWI1?=
 =?utf-8?B?QlBRVDhyRllZaEF0ZTJaZzB3aTJ0MWx0ZndsSmJENzBOOXBaZno2cmE1c3B2?=
 =?utf-8?B?WUhWNStRVnY0WTZ0V3oya3hqMll4clNFTFJPRG9kcXpMRGlzNTB0L1ljSWY2?=
 =?utf-8?B?YjFSR1FNN0xEeklxUUVQeUh0cWdBT0FHNXJwampNWUJwekRCYTFNN2RQNktP?=
 =?utf-8?B?cGZpeFM0SDBKb0FmZEtpbTZzRmhvbDlOYmdOTHFtQ0N6cHdpYmVmZXlHYWFM?=
 =?utf-8?Q?qXRlAdT/IbOx/yPlrmq2GWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D39D13AB3F1D148B2616966D0566873@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19ed879-4f90-48d2-fa59-08d9f6c7602d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 12:24:02.1249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rxkB9nTWBQLvBTbdEmcLpz4b86wceteeYbTTR+P6WZJOl02nTOcKY+N2lkTGiMPun5uc7lymC76gTEwwySBaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAyLTIzIGF0IDA5OjQ0ICswMTAwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90
ZToNCj4gT24gU2F0LCBGZWIgMTksIDIwMjIgYXQgMDU6MDA6MThQTSArMDAwMCwgVHJvbmQgTXlr
bGVidXN0IHdyb3RlOg0KPiA+IE9uIFNhdCwgMjAyMi0wMi0xOSBhdCAxMjozNCArMDEwMCwgQ2hy
aXN0aWFuIEJyYXVuZXIgd3JvdGU6DQo+ID4gPiBPbiBTYXQsIEZlYiAxOSwgMjAyMiBhdCAwODoz
NDozMEFNICswMDAwLA0KPiA+ID4gc3V5LmZuc3RAZnVqaXRzdS5jb23CoHdyb3RlOg0KPiA+ID4g
PiBIaSBORlMgZm9sa3MsDQo+ID4gPiA+IMKgIER1cmluZyBvdXIgeGZzdGVzdHMsIHdlIGZvdW5k
IGdlbmVyaWMvNjMzIGZhaWxzIGxpa2U6DQo+ID4gPiA+ID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+ID4gPiA+IEZTVFlQwqDCoMKgwqDCoMKgwqDCoCAtLSBu
ZnMNCj4gPiA+ID4gUExBVEZPUk3CoMKgwqDCoMKgIC0tIExpbnV4L3g4Nl82NCBidHJmcyA1LjE3
LjAtcmM0LWN1c3RvbSAjMjM2IFNNUA0KPiA+ID4gPiBQUkVFTVBUIFNhdCBGZWIgMTkgMTU6MDk6
MDMgQ1NUIDIwMjINCj4gPiA+ID4gTUtGU19PUFRJT05TwqAgLS0gMTI3LjAuMC4xOi9uZnNzY3Jh
dGNoDQo+ID4gPiA+IE1PVU5UX09QVElPTlMgLS0gLW8gdmVycz00IDEyNy4wLjAuMTovbmZzc2Ny
YXRjaCAvbW50L3NjcmF0Y2gNCj4gPiA+ID4gDQo+ID4gPiA+IGdlbmVyaWMvNjMzIDBzIC4uLiBb
ZmFpbGVkLCBleGl0IHN0YXR1cyAxXS0gb3V0cHV0IG1pc21hdGNoDQo+ID4gPiA+IChzZWUNCj4g
PiA+ID4gL3Jvb3QveGZzdGVzdHMtZGV2L3Jlc3VsdHMvL2dlbmVyaWMvNjMzLm91dC5iYWQpDQo+
ID4gPiA+IMKgwqDCoCAtLS0gdGVzdHMvZ2VuZXJpYy82MzMub3V0wqDCoCAyMDIxLTA1LTIzIDE0
OjAzOjA4Ljg3OTk5OTk5Nw0KPiA+ID4gPiArMDgwMA0KPiA+ID4gPiDCoMKgwqAgKysrIC9yb290
L3hmc3Rlc3RzLWRldi9yZXN1bHRzLy9nZW5lcmljLzYzMy5vdXQuYmFkIDIwMjItDQo+ID4gPiA+
IDAyLTE5DQo+ID4gPiA+IDE2OjMxOjI4LjY2MDAwMDAxMyArMDgwMA0KPiA+ID4gPiDCoMKgwqAg
QEAgLTEsMiArMSw0IEBADQo+ID4gPiA+IMKgwqDCoMKgIFFBIG91dHB1dCBjcmVhdGVkIGJ5IDYz
Mw0KPiA+ID4gPiDCoMKgwqDCoCBTaWxlbmNlIGlzIGdvbGRlbg0KPiA+ID4gPiDCoMKgwqAgK2lk
bWFwcGVkLW1vdW50cy5jOiA3OTA2OiBzZXRnaWRfY3JlYXRlIC0gU3VjY2VzcyAtDQo+ID4gPiA+
IGZhaWx1cmU6DQo+ID4gPiA+IGlzX3NldGdpZA0KPiA+ID4gPiDCoMKgwqAgK2lkbWFwcGVkLW1v
dW50cy5jOiAxMzkwNzogcnVuX3Rlc3QgLSBTdWNjZXNzIC0gZmFpbHVyZToNCj4gPiA+ID4gY3Jl
YXRlDQo+ID4gPiA+IG9wZXJhdGlvbnMgaW4gZGlyZWN0b3JpZXMgd2l0aCBzZXRnaWQgYml0IHNl
dA0KPiA+ID4gPiDCoMKgwqAgLi4uDQo+ID4gPiA+IMKgwqDCoCAoUnVuICdkaWZmIC11IC9yb290
L3hmc3Rlc3RzLWRldi90ZXN0cy9nZW5lcmljLzYzMy5vdXQNCj4gPiA+ID4gL3Jvb3QveGZzdGVz
dHMtZGV2L3Jlc3VsdHMvL2dlbmVyaWMvNjMzLm91dC5iYWQnwqAgdG8gc2VlIHRoZQ0KPiA+ID4g
PiBlbnRpcmUNCj4gPiA+ID4gZGlmZikNCj4gPiA+ID4gUmFuOiBnZW5lcmljLzYzMw0KPiA+ID4g
PiBGYWlsdXJlczogZ2VuZXJpYy82MzMNCj4gPiA+ID4gRmFpbGVkIDEgb2YgMSB0ZXN0cw0KPiA+
ID4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ID4g
PiANCj4gPiA+ID4gVGhlIGZhaWxlZCB0ZXN0IGlzIGFib3V0IHNldGdpZCBpbmhlcml0YW5jZS4g
DQo+ID4gPiA+IFdoZW7CoCBhIGZpbGUgaXMgY3JlYXRlZCB3aXRoIFNfSVNHSUQgaW4gdGhlIGRp
cmVjdG9yeSB3aXRoDQo+ID4gPiA+IFNfSVNHSUQsDQo+ID4gPiA+IE5GU8KgIGRvZXNuJ3Qgc3Ry
aXAgdGhlwqAgc2V0Z2lkIGJpdCBvZiB0aGUgbmV3IGNyZWF0ZWQgZmlsZSBidXQNCj4gPiA+ID4g
b3RoZXJzDQo+ID4gPiA+IChleHQ0L3hmcy9idHJmcykgZG8uwqAgVGhleSBjYWxsIGlub2RlX2lu
aXRfb3duZXIoKSB3aGljaCBkb2VzDQo+ID4gPiA+IHRoZSBzdHJpcCBhZnRlciBuZXdfaW5vZGUo
KS4NCj4gPiA+ID4gSG93ZXZlciwgTkZTIGhhcyBpdHMgb3duIGxvZ2ljYWwgdG8gaGFuZGxlIGlu
b2RlIGNhcGFjaXRpZXMuIA0KPiA+ID4gPiBBcyB0aGUgdGVzdCBzYXlzIHRoZSBiZWhhdmlvciBj
YW4gYmUgZmlsZXN5c3RlbSB0eXBlIHNwZWNpZmljLA0KPiA+ID4gPiBJJ2QgcmVwb3J0IHRvIHlv
dSBORlMgZ3V5cyBhbmQgYXNrIHdoZXRoZXIgaXQncyBhIGJ1ZyBvciBub3Q/DQo+ID4gPiANCj4g
PiA+IFRoYW5rcyBmb3IgdGhlIHJlcG9ydC4gSSdtIG5vdCBzdXJlIHdoeSBORlMgd291bGQgaGF2
ZSBkaWZmZXJlbnQNCj4gPiA+IHJ1bGVzDQo+ID4gPiBmb3Igc2V0Z2lkIGluaGVyaXRhbmNlLiBT
byBJJ20gaW5jbGluZWQgdG8gdGhpbmsgdGhhdCB0aGlzIGlzDQo+ID4gPiBzaW1wbHkNCj4gPiA+
IGENCj4gPiA+IGJ1ZyBzaW1pbGFyIHRvIHdoYXQgd2Ugc2F3IGluIHhmcyBhbmQgY2VwaC4gQnV0
IEknbGwgbGV0IHRoZSBORlMNCj4gPiA+IGZvbGtzDQo+ID4gPiBkZXRlcm1pbmUgdGhhdC4NCj4g
PiA+IA0KPiA+ID4gWEZTIGlzIG9ubHkgc3BlY2lhbCBpbiBzbyBmYXIgYXMgaXQgaGFzIGEgc3lz
Y3RsIHRoYXQgbGV0cyBpdA0KPiA+ID4gYWx0ZXINCj4gPiA+IHNnaWQNCj4gPiA+IGluaGVyaXRh
bmNlIGJlaGF2aW9yLiBBbmQgaXQgb25seSBoYXMgdGhhdCB0byBhbGxvdyBmb3IgbGVnYWN5DQo+
ID4gPiBpcml4DQo+ID4gPiBzZW1hbnRpY3MgaWl1Yy4NCj4gPiANCj4gPiBPSywgc28gaG93IGRv
IHlvdSBleHBlY3QgdGhpcyAnaWRtYXBwZWQtbW91bnRzJyBmdW5jdGlvbmFsaXR5IHRvDQo+ID4g
d29yaw0KPiA+IG9uIE5GUz8gSSdtIG5vdCBhc2tpbmcgYWJvdXQgdGhpcyBidWcgaW4gcGFydGlj
dWxhci4gSSdtIGFza2luZw0KPiA+IGFib3V0DQo+ID4gd2hhdCB0aGlzIGlzIHN1cHBvc2VkIHRv
IGRvIGluIGdlbmVyYWwuDQo+IA0KPiBKdXN0IHRvIGNsYXJpZnksIHRoZSBidWcgaGFzIG5vdGhp
bmcgdG8gZG8gd2l0aCBpZG1hcHBlZCBtb3VudHMuIFRoZQ0KPiBpZG1hcHBlZCBtb3VudCB0ZXN0
c3VpdGUgYWx3YXlzIGhhZCBhIHZmcyBnZW5lcmljIHBhcnQuIFRoYXQgdmZzDQo+IGdlbmVyaWMN
Cj4gcGFydCBoYXMgYmVlbiBtYWRlIGF2YWlsYWJsZSB0byBhbGwgZmlsZXN5c3RlbXMgc3VwcG9y
dGluZyB4ZnN0ZXN0cyBhDQo+IGZldyB3ZWVrcyBhZ28uIChTbyBmYXIgdGhpcyBzZXRnaWQgaW5o
ZXJpdGFuY2UgYnVnIGhlcmUgaGFzIGJlZW4NCj4gcHJlc2VudA0KPiBpbiAzIGZpbGVzeXN0ZW1z
LikNCg0KVGhlIHNldGdpZCBzdHVmZiB3b3JrcyBqdXN0IGZpbmUgd2l0aCByZWd1bGFyIHVzZSwg
d2hlbiB0aGUgc2VydmVyIGlzDQphYmxlIHRvIGRldGVybWluZSB3aGVuIHRvIGNsZWFyIHRoZSBi
aXQuIEl0IG9ubHkgYnJlYWtzIHdpdGggdGhpcyBraW5kDQpvZiB0ZXN0IHdoZXJlIHRoZSBzZXJ2
ZXIgaXMgYmVpbmcgbGllZCB0byBieSB0aGUgY2xpZW50J3MgdXBwZXIgbGF5ZXJzLg0KDQo+IA0K
PiA+IA0KPiA+IEF0IGEgcXVpY2sgZ2xhbmNlLCBpdCBsb29rcyB0byBtZSBhcyBpZiB0aGVzZSBp
ZG1hcHBlZCBtb3VudA0KPiA+IGhlbHBlcnMNCj4gPiBhcmUganVzdCBoYWNraW5nIGRpZmZlcmVu
dCB2YWx1ZXMgaW50byB0aGUgaW5vZGUgY2FjaGUNCj4gPiByZXByZXNlbnRhdGlvbg0KPiA+IG9m
IGZpbGVzLCBhbmQgdGhlbiBzb21laG93IGV4cGVjdGluZyB0aGF0IHRvIHJlc3VsdCBpbiBkaWZm
ZXJlbnQNCj4gDQo+IChKdXN0IHRvIGNsYXJpZnksIHRoZSBpbm9kZSBjYWNoZSBpcyBuZXZlciBj
aGFuZ2VkIGJ5IGFuIGlkbWFwcGVkDQo+IG1vdW50DQo+IHVubGVzcyBhIG5ldyBmaWxlc3lzdGVt
IG9iamVjdCBpcyBjcmVhdGVkL3Blcm1hbnRlbnRseSBjaGFuZ2VkLiBUaGUNCj4gaW5vZGUgY2Fj
aGUgaXMgbGVmdCBhbG9uZSBvdGhlcndpc2UgYW5kIG93bmVyc2hpcCBpcyBvbmx5IHRyYW5zaWVu
dGx5DQo+IG1hcHBlZCB3aGVuIGNoZWNraW5nIHBlcm1pc3Npb25zLikNCj4gDQo+ID4gYmVoYXZp
b3VyLg0KPiA+IFRoYXQncyBub3QgZ29pbmcgdG8gd29yayB3aXRoIE5GUywgZm9yIHR3byByZWFz
b25zOg0KPiA+IMKgwqAgMS4gU2VjdXJpdHkgaXMgZW5mb3JjZWQgYnkgdGhlIHNlcnZlciBhbmQg
bm90IHRoZSBjbGllbnQuIElmIHlvdQ0KPiA+IMKgwqDCoMKgwqAgd2FudCB0aGVzZSB2YWx1ZXMg
eW91J3JlIHBva2luZyBpbnRvIHRoZSBpbm9kZSBjYWNoZSB0bw0KPiA+IGNoYW5nZQ0KPiA+IMKg
wqDCoMKgwqAgdGhlIGJlaGF2aW91ciBvZiB0aGUgc2VydmVyLCB0aGVuIHRoZXkgaGF2ZSB0byBi
ZSBwcm9wYWdhdGVkDQo+ID4gYnkNCj4gPiDCoMKgwqDCoMKgIHRoZSBjbGllbnQgdG8gdGhhdCBz
ZXJ2ZXIuIA0KPiA+IMKgwqAgMi4gVGhlIE5GUyBzZWN1cml0eSBtb2RlbCBpcyBhdXRoZW50aWNh
dGlvbiBiYXNlZC4gSW4NCj4gPiBwYXJ0aWN1bGFyLA0KPiA+IMKgwqDCoMKgwqAgd2hlbiBzdHJv
bmcgYXV0aGVudGljYXRpb24gaXMgYmVpbmcgdXNlZCwgdGhlbiBteSBpZGVudGl0eSBpcw0KPiA+
IMKgwqDCoMKgwqAgZXN0YWJsaXNoZWQgYnkgdXNlcitwYXNzd29yZCB0aGF0IEkndmUgbG9nZ2Vk
IGluIGFzIHRvIHRoZQ0KPiA+IMKgwqDCoMKgwqAga2VyYmVyb3Mgc2VydmVyIChvciB3aGF0ZXZl
cikuIFNvIHdoaWxlIHRoZSBpZG1hcHBlZCBtb3VudA0KPiA+IHN0dWZmDQo+ID4gwqDCoMKgwqDC
oCBtYXkgYmUgcG9raW5nIHZhbHVlcyBpbnRvIG15IGNyZWRlbnRpYWwgb3IgdGhlIGlub2RlIGNh
Y2hlLA0KPiA+IHRoZQ0KPiA+IMKgwqDCoMKgwqAgc2VydmVyIGlzIGdvaW5nIHRvIGlnbm9yZSBh
bGwgdGhhdCBhbmQgdGVsbCBtZSB0aGF0IGFueSBmaWxlDQo+ID4gSQ0KPiA+IMKgwqDCoMKgwqAg
Y3JlYXRlIGlzIG93bmVkIGJ5IHVzZXIgdHJvbmRAZG9tYWluLiBJdCB3aWxsIG5vdCBhbGxvdyBt
ZSB0bw0KPiA+IMKgwqDCoMKgwqAgY2hhbmdlIGZpbGUgb3duZXJzaGlwIG9yIHRvIG92ZXJyaWRl
IGFjY2VzcyBwZXJtaXNzaW9ucw0KPiA+IHVubGVzcw0KPiA+IMKgwqDCoMKgwqAgdHJvbmRAZG9t
YWluwqBoYXBwZW5zIHRvIGJlIGEgcHJpdmlsZWdlZCB1c2VyIHN1Y2ggYXMgcm9vdC4NCj4gPiAN
Cj4gPiBJJ20gcHJldHR5IHN1cmUgdGhlIGNpZnMvc21iIGNsaWVudCB3aWxsIGhhdmUgdGhlIHNh
bWUgcHJvYmxlbS4NCj4gDQo+IEkgZGlkIGEgUE9DIGZvciBjZXBoIGEgd2hpbGUgYmFjayBhbmQg
SSBkaWQgYWxzbyBoYXZlIFBPQyBwYXRjaGVzIGZvcg0KPiBjaWZzL3NtYi4gRm9yIGNlcGggZS5n
LiB0aGUge2csdX1pZCB3aXRoIHdoaWNoIGEgZmlsZSBpcyB0byBiZQ0KPiBjcmVhdGVkDQo+IHdp
dGggb3Igd2lsbCBoYXZlIGl0cyBvd25lcnNoaXAgY2hhbmdlZCB0byBpcyBzZW50IGZyb20gdGhl
IGNsaWVudCB0bw0KPiB0aGUgc2VydmVyIHdpdGggc2VydmVyIGJlaW5nIHJlc3BvbnNpYmxlIGZv
ciBkZWNpZGluZyB3aGV0aGVyIHRoYXQNCj4gY3JlYXRpb24gaXMgYWxsb3dlZCBvciBub3QuDQo+
IE5GUyBhbHJlYWR5IGhhcyBhIG5vdGlvbiBvZiBpZG1hcHBpbmcgdmlhIHVwY2FsbHMgYWZhaXIu
IFdoZXRoZXIgb3INCj4gbm90DQo+IHN1cHBvcnQgZm9yIGlkbWFwcGVkIG1vdW50cyBtYWtlIHNl
bnNlIGZvciBORlMgZGVwZW5kcyBvbiBob3cgdGhlDQo+IGN1cnJlbnQgaWRtYXBwaW5nIGZlYXR1
cmUgaXMgaW1wbGVtZW50ZWQgYW5kIHdoYXQgdXNlLWNhc2VzIGFyZW4ndA0KPiBzdXBwb3J0ZWQg
YnkgaXQgdGhhdCBpZG1hcHBlZCBtb3VudHMgY2FuLg0KDQpUaGUgTkZTIGlkbWFwcGluZyBieSB1
cGNhbGxzIHNvbHZlcyBhIHZlcnkgZGlmZmVyZW50IGlzc3VlLiBJdCBleGlzdHMNCnRvIG1ha2Ug
c3VyZSB0aGF0IHRoZSBjbGllbnQgYW5kIHNlcnZlciBhcmUgYm90aCBvbiB0aGUgc2FtZSBwYWdl
DQp3LnIudC4gYWNjb3VudCB0byB1aWQvZ2lkIG1hcHBpbmcuDQoNCmkuZS4gaXQgc29sdmVzIGEg
cHJvYmxlbSB3aGVuIHRoZXkgYXJlIHVzaW5nIGtlcmJlcm9zLCBhbmQgYXJlIG5vdCBpbg0KYWdy
ZWVtZW50IG92ZXIgdWlkL2dpZCBhc3NpZ25tZW50IHRvIHRoZSBwcmluY2lwYWwgYWNjb3VudCBu
YW1lcy4NCg0KSXQgd2lsbCBhY3R1YWxseSBjYXVzZSBmdXJ0aGVyIGNvbmZsaWN0cyB3aXRoIGlk
bWFwcGVkIG1vdW50cy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
