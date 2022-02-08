Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9624ADA52
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376432AbiBHNqA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 08:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377108AbiBHNp7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 08:45:59 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2116.outbound.protection.outlook.com [40.107.223.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17938C03FED1
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 05:45:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUAAM0ES5Ok0GhtyF5UhzmWBpZWntm8WvnmMQEC6EvT86ujb06f1bkvwcQdaKAbKrbHbjS/+7Ujf23I2ezl+DsuwteDNXW3JcMAWQ1v+AWvV+uWOw4D/OuNov6FwalLcw2L6eH4ZkEqwquc2Hw7W25UyAd/dSS2BNFj02clK+BbBWIjxvyWl2+PExd/4uyT9Px/RkMssW/A4TPE/3/67XAa1LmGVtxW88nMBgHu9ZIIrCOdB65Oe4Rqm66REwBZAz1mMfOxGDPi5lPBqQxW6Fbfj3JA0j4vpKtIpcjXBwLFzo3hrh99cXjPp/dLZu5dp60SHNPWveb63EWmx9+RcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oVMVwyweND3jr8OjQyHQp8icN89GEzFqPsP5gmUQhM=;
 b=P6Y1viVUqSlBUTrRf3sBCVQtToCsWhEpyb3Z1GYp/JQ/EJfSExp3oJBUvTNv6WlYy09HxGkwAii5+DY7601qCWNqvl5YA88TSrrCPcuh/AaDE8A0FHIEtULifZWOl3IAKJo9vc1iEwpQ6/E8nchHp2o1BgT9wC0PkZfu34TIXKopD9kqis1DyItKZ1LqAgRWcCKNl69I/QhoHm9MFnf54+ERaR2OnIosw1/GwmMFZOEYuzp17A9B28DSap3NJReO7SvRadLwCvShCfkAKO1Jz2eR9RkkH4yVtwORpc0egbMoRgHeFVNrhD1lm7C377nCvGHx1aefpm4qagPl95f6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oVMVwyweND3jr8OjQyHQp8icN89GEzFqPsP5gmUQhM=;
 b=JcV7OTEALfSYCSaltxkjTl9bokk+1pdmOxUbUrsgMwyLp2fwIPlOZKe0zTcixo6QAm94cUPXPL6oSRzt+aEndGZg5E3cy3VII1FgspLpxL1MBnWRe2ZDBXHpjs+DbQOdcv+hWOrHv7rmdSJikulGt5eGTPoBGHh13kz65gYptAk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4553.namprd13.prod.outlook.com (2603:10b6:610:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8; Tue, 8 Feb
 2022 13:45:54 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%6]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 13:45:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Thread-Topic: v4 clientid uniquifiers in containers/namespaces
Thread-Index: AQHYGqGY+wEK6KvlxECYW5WP2WwW2KyFReGAgAAYO4CAAsQQAIAAHRgAgAA//4CAAEjXgIAAwaaAgAAlW4A=
Date:   Tue, 8 Feb 2022 13:45:53 +0000
Message-ID: <c9948f895e91abb76a21609bf629b88bbfcf4d9a.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
         <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
         <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
         <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
         <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
         <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
         <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
         <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
In-Reply-To: <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ddcf253-1fa0-477d-0863-08d9eb095389
x-ms-traffictypediagnostic: CH2PR13MB4553:EE_
x-microsoft-antispam-prvs: <CH2PR13MB45536587402D3BF4B4EF83A4B82D9@CH2PR13MB4553.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3+okGo61rFxAjrRR09gugGDJHJA2HSAQIz4SXm+dIWAwQL9nHtk/xh6Wedgg/t0OFjMUncSisxzwcd0fpu6zFk4Qxb4bmG2ZbS5wR3J0Yt6mqGH7GqcSh6vvVmu04otPwyx4iazYxLuJwjwajcnrjYH+4cM6m0Q4V6P6stAai9JSX1Xl6N1lRbOCs9Px2PKQUi0CfjubTLRjIeV2dlZV7JTOUG0SekYPIXIwL495U9U5zmYfrIeAmwBqelCd2KF1v2PjMqgpNxp7XNfXUzb8Z5+8b63w1dIUkeZOG4QPjZVrz5dWLOEtwfts3pVp/unIOEERvhwIdEd4gUTi1wOCaecid6C1TR442FMWo+5ygDULYwNGhWuqJkbg3/AWWVgCxETS5+fLSSwzn4KqlLwqarsWbnYMZ53DyQLzN9VE9qpniXXS5DfNJ/KZQ8SBDPhZ5x6irzE6KX1yFjQJ6nTQY04LKoxAe5L73+FuhdOMg0Nc8bAgatniy9XQ4BXqSYDVmx+H05x4gSvr3MrutCO+BuZ5esmOGWQqSEcxWSvK2KaSWCicSafQxpr7h4085Vc/sFHOSJim4a9BubFQeGtm4If6EVaEgBvlX4NXxhEsN1dHhfLb0X1iXYIhTiBBVkJpxR7bzEbrZ1dH2kY43dzGjEmwWUnt2cNLcKj0hIS2MF17fZtg9JTVmeFL3Nr4vv75oA1pfHUWPxO/SnRLH9lIilLCLoGMAPyx+WvZhDiJf0/O8YhcV3zyrpzXuTevqNMo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(76116006)(64756008)(316002)(36756003)(110136005)(122000001)(5660300002)(186003)(26005)(66446008)(8936002)(8676002)(4326008)(2616005)(83380400001)(38070700005)(86362001)(2906002)(71200400001)(6486002)(53546011)(508600001)(6506007)(38100700002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVdETXN0M2VheDVlczF4ZG91NHZ3L1hMWDZNT00yL1lzN1paaGp1TXNidXhW?=
 =?utf-8?B?WlZDNTRKM1NvNTFFVkErM013dCszNThDeWF4T0VrOHo1U0pWT010N1ZKUGFr?=
 =?utf-8?B?YVBYYnltREVRdFpVT2sreDdxOWV3SndreXNiTmZhMjZrejRGSlAyTW5Fb3NT?=
 =?utf-8?B?STJDNEJXQkhxSk1QOWVmWUpKZk5WZnZyTWM2ZE5KanFWS1R5ZjRCNW5FV1hq?=
 =?utf-8?B?bXgwSzlBZ2R5VHBldXRNSG9YbUNFbTQ4QW10b2kxVWE1c21BbHdlYi84cUkv?=
 =?utf-8?B?OWtPMFpwVXN4Qmlxc3FvRHhYNy92bGpRbVhac3FNSjZLQ2toUHN3SzB0VC9B?=
 =?utf-8?B?T2FPdk1VNmIyb0Vvc0lFSk84SVIyT3pZU0FNWmE1Q3lvaFQ1NjNwZVhmcjY0?=
 =?utf-8?B?TVFjaFIzck5NR3ljV0xmYS94UWJ6ZjE1YUtmVzZzODJCK3dFNm1sdldXZzBY?=
 =?utf-8?B?ZitjL1c0VEdoMWNENlhBTS81elo3OWRBSVVWenB5Yk45Q1BmU1F4L01vMmZL?=
 =?utf-8?B?b3JyMXEvSnVtRENnQThWaXlMK3JVeGNvNUxIWVdSZmt4cW4vTEpaaGZtOTlM?=
 =?utf-8?B?cnFveStGOXRvbm4wTEVhMzh0WGpRWjB5bStaSnhOS0J2WlkvN2xBS3FibkQ3?=
 =?utf-8?B?MndWeERhU01VcldnZC9xQTZVbENDNHErQTRHZ3JqVlc4UnFlWTJTSVFINmk2?=
 =?utf-8?B?cGl3d3hybVh5S3pXSGlhc2RLVHpLNDI1NDJyc2xXdlp1RC9nc1BiOGFOYmR4?=
 =?utf-8?B?RkFNN1VIeERsTWdKb1hvVmJ1aDZ6enpmL05IOWR2VW5LY2VNcFFzTFNRRWNH?=
 =?utf-8?B?elJ0U3k0QjRCaXhRdHFheDR0SFdLVWV0Ukxsb0tlUEl4emtZN3M5NkxZbThr?=
 =?utf-8?B?aWVPUktPVXBSUEVXSlJQenNrQlVTSjdDcHFlUlBha2VzbmNxTGsvTFBjbjZF?=
 =?utf-8?B?c0wwdU0rWWwvMjNTcUlFMFpjb3QyRlp2RHlZY3BkbGNWZFBvMlVNWUZFbzky?=
 =?utf-8?B?Z0M4eDRLcmQ4Mkk4UHlZY29Dcm5yUjBvTVlhdXdYbHNtUy9RUzk4VVc3N3Rx?=
 =?utf-8?B?TGRaS1hvSGE3L0dxL0E2eXFvZ0NGV1lrb2luN3MyNXBZdjJBTnkyZkQ0VUg5?=
 =?utf-8?B?WUJYYU53V3FkdWgyQmgwanozWTRSV1NEZkFFUGJtVmZoRVlvVlpMQmVxWWls?=
 =?utf-8?B?MStBZFp6N3FWL2xFZm0xcEl2OXMzV0dUeEl1eEJ2OVdtS1BaV1U4OWJTWDdv?=
 =?utf-8?B?M2o0UlhjYXZISlhUamxRcVpsdG9rYVdwVk5RcTJuWU1ZVVdkQmovWHdaZjhM?=
 =?utf-8?B?aGVPL1U4OXZDWVRTbnRVSi9tN2pXK2VrNzhPSCt2OGJsazQ1MGlUTnJLWldx?=
 =?utf-8?B?amtlWm1VWlZxTm5idStWaGlhazltYURkVTJ3MFlDeGhwQm9RSlRZNFhKTi9h?=
 =?utf-8?B?T25JNUQ0SDk3UzF4TTBLMm95SkVESmxXcmtIU0tjSDRTNk9UYTcwUlFzZkFK?=
 =?utf-8?B?enJDY3V5Mi91OXJjUGpscmp4OTdFbk80Q2lOYm5Vdzd6NHk3WEJ0YWlJdVFY?=
 =?utf-8?B?WFhSOWU4VEJFLzgwb2YyU3gzM3RMK0hWL2JmVE9uVUQ5U1h1bmdrSFhlUldi?=
 =?utf-8?B?MlAyMFplbVRhamZweCs1UExtOW1Raldwalh5QlFVTUhjMHlncDFTb1IvRElp?=
 =?utf-8?B?S3V0bmQ3VExDeVBjS0xwMmFSc3BPYVVVYmFoMGJQODNmMmo3STU1Y0JaT2l4?=
 =?utf-8?B?VW5JV1lSbmRpY0E5OFZZRDhWMGlVVURQREtzNG1oL0FFTFF1MzBlRExSRnha?=
 =?utf-8?B?SXBwcVVWM1Jzb3hjM0NsTGRQODNibyt5OE4wOU5Wc20rVVhVSmNLaUVLSEpk?=
 =?utf-8?B?Y29EdjhjejJaanBzWjhDeC9jS1NPNnFGLzhPWmxnSk1ZRzJYU2xHRDJFNzF0?=
 =?utf-8?B?MS8wZmZLd2I2eDN0Qnd4RDZEU1gwYWE3UTZpUnJRbzdCTmZlMFVkYVZLZmdk?=
 =?utf-8?B?V3BYYW5QRkFpTkcrUkhmVWdESFIxcmlmZmtqY3hzZEM3cmFCSy9qczk1WnVw?=
 =?utf-8?B?MU5PSmxsbkJhRWcyQmFSbUIrV1RGL1k3anlweDlETW1MQklxS3BkVi9MVTJF?=
 =?utf-8?B?Yks4WUNBY0pIZy9wak5uTUpkR3oyK3krSTExRm9sRVFSU2p1aWdYM051OW4v?=
 =?utf-8?Q?QXuoS/wMWAHdaYn95XJqsC8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEF36D66A828B344BB37B9C109A0E35D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddcf253-1fa0-477d-0863-08d9eb095389
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 13:45:53.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aRSCUXhnCLGvEK3X3H05ZNGEHlZv2unoRt+8Z8hmcf+8VnphQtz/VAP2C8Dm0N+cAdOA816EvzFKsKl8scuJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTA4IGF0IDA2OjMyIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA3IEZlYiAyMDIyLCBhdCAxODo1OSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0K
PiANCj4gPiA+IE9uIEZlYiA3LCAyMDIyLCBhdCAyOjM4IFBNLCBUcm9uZCBNeWtsZWJ1c3QNCj4g
PiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gDQo+ID4gPiB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gT24gTW9uLCAyMDIyLTAyLTA3IGF0IDE1OjQ5ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3Jv
dGU6DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBGZWIgNywgMjAyMiwgYXQgOTow
NSBBTSwgQmVuamFtaW4gQ29kZGluZ3Rvbg0KPiA+ID4gPiA+IDxiY29kZGluZ0ByZWRoYXQuY29t
PiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiA1IEZlYiAyMDIyLCBhdCAxNDo1MCwg
QmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIDUg
RmViIDIwMjIsIGF0IDEzOjI0LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gT24gU2F0LCAyMDIyLTAyLTA1IGF0IDEwOjAzIC0wNTAwLCBCZW5qYW1p
biBDb2RkaW5ndG9uDQo+ID4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IEhpIGFs
bCwNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBJcyBhbnlvbmUgdXNpbmcgYSB1
ZGV2KC1saWtlKSBpbXBsZW1lbnRhdGlvbiB3aXRoDQo+ID4gPiA+ID4gPiA+ID4gTkVUTElOS19M
SVNURU5fQUxMX05TSUQ/DQo+ID4gPiA+ID4gPiA+ID4gSXQgbG9va3MgbGlrZSB0aGF0IGlzIGF0
IGxlYXN0IG5lY2Vzc2FyeSB0byBhbGxvdyB0aGUNCj4gPiA+ID4gPiA+ID4gPiBpbml0DQo+ID4g
PiA+ID4gPiA+ID4gbmFtZXNwYWNlZA0KPiA+ID4gPiA+ID4gPiA+IHVkZXYNCj4gPiA+ID4gPiA+
ID4gPiB0byByZWNlaXZlIG5vdGlmaWNhdGlvbnMgb24NCj4gPiA+ID4gPiA+ID4gPiAvc3lzL2Zz
L25mcy9uZXQvbmZzX2NsaWVudC9pZGVudGlmaWVyLA0KPiA+ID4gPiA+ID4gPiA+IHdoaWNoDQo+
ID4gPiA+ID4gPiA+ID4gd291bGQgYmUgYSBwcmUtcmVxIHRvIGF1dG9tYXRpY2FsbHkgdW5pcXVp
ZnkgaW4NCj4gPiA+ID4gPiA+ID4gPiBjb250YWluZXJzLg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+IEknbWQgaW50ZXJlc3RlZCBzaW5jZSBpdCB3aWxsIGluZm9ybSB3aGV0aGVy
IEkgbmVlZCB0bw0KPiA+ID4gPiA+ID4gPiA+IHNlbmQNCj4gPiA+ID4gPiA+ID4gPiBwYXRjaGVz
DQo+ID4gPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+ID4gPiBzeXN0ZW1kJ3MgdWRldiwgYW5k
IHBvdGVudGlhbGx5IG9wZW4gdGhlIGNhbiBvZiB3b3Jtcw0KPiA+ID4gPiA+ID4gPiA+IG92ZXIN
Cj4gPiA+ID4gPiA+ID4gPiB0aGVyZS4NCj4gPiA+ID4gPiA+ID4gPiBZZXQgaXRzDQo+ID4gPiA+
ID4gPiA+ID4gbm90IHlldCBjbGVhciB0byBtZSBob3cgYW4gaW5pdCBuYW1lc3BhY2VkIHVkZXYg
cHJvY2Vzcw0KPiA+ID4gPiA+ID4gPiA+IGNhbg0KPiA+ID4gPiA+ID4gPiA+IHdyaXRlIHRvDQo+
ID4gPiA+ID4gPiA+ID4gYSBuZXRucw0KPiA+ID4gPiA+ID4gPiA+IHN5c2ZzIHBhdGguDQo+ID4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gQW5vdGhlciBvcHRpb24gbWlnaHQgYmUgdG8g
Y3JlYXRlIHlldCBhbm90aGVyDQo+ID4gPiA+ID4gPiA+ID4gZGFlbW9uL3Rvb2wNCj4gPiA+ID4g
PiA+ID4gPiB0aGF0IHdvdWxkDQo+ID4gPiA+ID4gPiA+ID4gbGlzdGVuDQo+ID4gPiA+ID4gPiA+
ID4gc3BlY2lmaWNhbGx5IGZvciB0aGVzZSBub3RpZmljYXRpb25zLsKgIFVnaC4NCj4gPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBCZW4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZC4gV2h5IGRvIHlvdSBuZWVk
IGEgbmV3IGRhZW1vbi90b29sPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJlY2F1c2Ugd2hhdCB3
ZSd2ZSBnb3Qgb25seSB3b3JrcyBmb3IgdGhlIGluaXQgbmFtZXNwYWNlLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFVkZXYgd29uJ3QgZ2V0IGtvYmplY3Qgbm90aWZpY2F0aW9ucyBiZWNhdXNlIGl0
cyBub3QgdXNpbmcNCj4gPiA+ID4gPiBORVRMSU5LX0xJU1RFTl9BTExfTlNJRHMuDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gV2UgbmVlZCB0byBmaWd1cmUgb3V0IGlmIHdlIHdhbnQ6DQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gMSkgdGhlIGluaXQgbmFtZXNwYWNlIHVkZXZkIHRvIGhhbmRsZSBhbGwg
Y2xpZW50X2lkDQo+ID4gPiA+ID4gdW5pcXVpZmllcnMNCj4gPiA+ID4gPiAyKSB3ZSBleHBlY3Qg
bmV0d29yayBuYW1lc3BhY2VzIHRvIHJ1biB0aGVpciBvd24gdWRldmQNCj4gPiA+ID4gPiAzKSBv
ciBib3RoLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgdGhpbmsgMiB2aW9sYXRlcyAibGVhc3Qg
c3VycHJpc2UiLCBhbmQgMyBtaWdodCBub3QgYmUNCj4gPiA+ID4gPiBzb21ldGhpbmcNCj4gPiA+
ID4gPiBhbnlvbmUNCj4gPiA+ID4gPiBldmVyIHdhbnRzLsKgIElmIHRoZXkgZG8sIHdlIGNhbiBm
aXggaXQgYXQgdGhhdCBwb2ludC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTbyB0byBtYWtlIDEg
d29yaywgd2UgY2FuIHRyeSB0byBjaGFuZ2UgdWRldmQsIG9yIG1heWJlIGp1c3QNCj4gPiA+ID4g
PiBoYWNraW5nIGFib3V0DQo+ID4gPiA+ID4gd2l0aCBuZnNfbmV0bnNfb2JqZWN0X2NoaWxkX25z
X3R5cGUgd2lsbCBiZSBzdWZmaWNpZW50Lg0KPiA+ID4gPiANCj4gPiA+ID4gSSBhZ3JlZSB0aGF0
IDEgc2VlbXMgbGlrZSB0aGUgcHJlZmVycmVkIGFwcHJvYWNoLCB0aG91Z2gNCj4gPiA+ID4gSSBk
b24ndCBoYXZlIGEgdGVjaG5pY2FsIHN1Z2dlc3Rpb24gYXQgdGhpcyBwb2ludC4NCj4gPiA+ID4g
DQo+ID4gPiANCj4gPiA+IEkgc3Ryb25nbHkgZGlzYWdyZWUuICgxKSByZXF1aXJlcyB0aGUgaW5p
dCBuYW1lc3BhY2UgdG8gaGF2ZQ0KPiA+ID4gaW50aW1hdGUNCj4gPiA+IGtub3dsZWRnZSBvZiBj
b250YWluZXIgaW50ZXJuYWxzLg0KPiANCj4gTm90IHJlYWxseSwgd2UncmUganVzdCBkaXN0aW5n
dWlzaGluZyBORlMgY2xpZW50cyBpbiBjb250YWluZXJzIGZyb20NCj4gTkZTDQo+IGNsaWVudHMg
b24gdGhlIGhvc3QuwqAgVGhhdCBkb2Vzbid0IHJlcXVpcmUgaW50aW1hdGUga25vd2xlZGdlLCBv
bmx5IGENCj4gbWVjaGFuaXNtIHRvIGNyZWF0ZSBhIHVuaXF1ZSB2YWx1ZSBwZXItY29udGFpbmVy
Lg0KPiANCj4gPiA+IFdoeSBkbyB3ZSBuZWVkIHRvIG1ha2UgdGhhdCBhIHJlcXVpcmVtZW50PyBU
aGF0IHZpb2xhdGVzIHRoZSANCj4gPiA+IGV4cGVjdGF0aW9uDQo+ID4gPiB0aGF0IGNvbnRhaW5l
cnMgYXJlIHN0YXRlbGVzcyBieSBkZWZhdWx0LCBhbmQgYWxzbyB0aGUNCj4gPiA+IGV4cGVjdGF0
aW9uIA0KPiA+ID4gdGhhdA0KPiA+ID4gdGhleSBvcGVyYXRlIGluZGVwZW5kZW50bHkgb2YgdGhl
IGVudmlyb25tZW50Lg0KPiANCj4gSSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBleHBlY3RhdGlv
biB0aGF0IGNvbnRhaW5lcnMgYXJlIHN0YXRlbGVzcw0KPiBieQ0KPiBkZWZhdWx0LCBvciB0aGF0
IHRoZXkgb3BlcmF0ZSBpbmRlcGVuZGVudGx5IG9mIHRoZSBlbnZpcm9ubWVudC4NCj4gDQoNClB1
dCBkaWZmZXJlbnRseTogZG8geW91IGV4cGVjdCBRRU1VL0tWTSBhbmQgVk13YXJlIEVTWCB0byBo
YXZlIHRvIGtub3cNCmEgcHJpb3JpIHRoYXQgYSBWTSBpcyBnb2luZyB0byB1c2UgTkZTdjQsIGFu
ZCBmb3JjZSB0aGVtIHRvIGhhdmUgdG8NCm1vZGlmeSB0aGUgVk0gc3RhdGUgYWNjb3JkaW5nbHk/
IE5vLCBvZiBjb3Vyc2Ugbm90LiBTbyB3aHkgZG8geW91IHRoaW5rDQp0aGlzIGlzIGEgZ29vZCBp
ZGVhIGZvciBjb250YWluZXJzPw0KDQpUaGlzIGlzIGV4YWN0bHkgdGhlIHByb2JsZW0gd2l0aCB0
aGUga2V5cmluZyB1cGNhbGwgbWVjaGFuaXNtLCBhbmQgd2h5DQppdCBpcyBjb21wbGV0ZWx5IHVz
ZWxlc3Mgb24gYSBtb2Rlcm4gc3lzdGVtLiBJdCByZWxpZXMgb24gdGhlIHRvcCBsZXZlbA0Ka25v
d2luZyB3aGF0IHRoZSBjb250YWluZXJzIGFyZSBkb2luZyBhbmQgaG93IHRoZXkgYXJlIGNvbmZp
Z3VyZWQuDQpJbWFnaW5lIGlmIHlvdSB3YW50IHRvIG5lc3QgY29udGFpbmVycyAoeWVzLCBwZW9w
bGUgZG8gdGhhdCAtIGp1c3QNCkdvb2dsZSAibmVzdGVkIGRvY2tlciBjb250YWluZXJzIikuIFlv
dXIgdG9wIGxldmVsIHByb2Nlc3Mgd291bGQgaGF2ZQ0KdG8ga25vdyBub3QganVzdCBob3cgdGhl
IGZpcnN0IGxldmVsIG9mIGNvbnRhaW5lcnMgaXMgY29uZmlndXJlZA0KKG5ldHdvcmsgZGV0YWls
cywgdXNlciBtYXBwaW5ncywgLi4uKSwgYnV0IGFsc28gZGV0YWlscyBhYm91dCBob3cgdGhlDQpj
aGlsZCBjb250YWluZXJzLCB0aGF0IGl0IGlzIG5vdCBkaXJlY3RseSBtYW5hZ2luZywgYXJlIGNv
bmZpZ3VyZWQuDQpJdCdzIGp1c3Qgbm90IHByYWN0aWNhbC4NCg0KPiA+ID4gSWYgeW91IHJlYWxs
eSBkbyB3YW50IGV4dGVybmFsIGNvbnRyb2wgb3ZlciB0aGUgdXVpZCB0aGF0IGlzIHNldCwNCj4g
PiA+IHRoZW4NCj4gPiA+IGl0IHNob3VsZCBiZSBwcmV0dHkgdHJpdmlhbCB0byBkbyBzbyBieSB1
c2luZyB0aGUgc3RhbmRhcmQNCj4gPiA+IGNvbnRhaW5lcg0KPiA+ID4gdG9vbHMgZm9yIG1hbmlw
dWxhdGluZyB0aGUgbmFtZXNwYWNlIChlLmcuIHRvIG1vdW50IGEgZmlsZSB0aGF0DQo+ID4gPiBp
cw0KPiA+ID4gdW5kZXIgY29udHJvbCBvZiB0aGUgcGFyZW50IGFzIC9ldGMvbmZzNC11dWlkLmNv
bmYgb3Igd2hhdGV2ZXIpLg0KPiANCj4gV2UncmUgbm90IGxvb2tpbmcgZm9yIGV4dGVybmFsIGNv
bnRyb2wsIGp1c3QgYXV0b21hdGlvbi7CoCBUaGUgTkZTIA0KPiBjb21tdW5pdHkNCj4gaGFzIGRl
Y2lkZWQgdGhhdCB1ZGV2IGlzIHRoZSB3YXkgdG8gZ28gaGVyZSwgc28gYXMgbG9uZyBhcyB3ZSBj
YW4gZ2V0DQo+IHRoZQ0KPiBub3RpZmljYXRpb25zIHRvIC9zb21lLyB1ZGV2IHByb2Nlc3MsIEkg
ZmVlbCBjb25maWRlbnQgd2UgY2FuIG1ha2UNCj4gYWxsIA0KPiBvZg0KPiB0aGlzIHRyYW5zcGFy
ZW50Lg0KPiANCj4gVGhlIGxlc3Mgd2UgaGF2ZSB0byB0ZWFjaCBhbGwgdGhlIGNvbnRhaW5lciB0
b29saW5nIGZvbGtzLCB0aGUgYmV0dGVyDQo+IGZvciB1cy4NCj4gDQoNCkFncmVlZC4gSSdtIHNh
eWluZyB0aGF0IHVkZXYgY2FzZSBhbHNvIGFsbG93cyBmb3IgdG9wIGxldmVsIGNvbnRyb2wgaWYN
CnlvdSB0aGluayB5b3UgbmVlZCBpdC4NCg0KPiA+ID4gSG93ZXZlciBpbiBtb3N0IGNhc2VzIHRo
YXQgSSBjYW4gdGhpbmsgb2YsIGlmIHRoZSBjb250YWluZXIgaXMNCj4gPiA+IGRvaW5nDQo+ID4g
PiBpdHMgb3duIE5GUyBtb3VudGluZywgdGhlbiBpdCBpcyBnb2luZyB0byBoYXZlIHRvIGJlIHNl
dCB1cCB3aXRoDQo+ID4gPiBpdHMNCj4gPiA+IG93biBuZnMtdXRpbHMsIGV0Yywgc28gdGhlcmUg
aXMgbm8gcmVhc29uIHdoeSB3ZSBjYW4ndCBhbHNvDQo+ID4gPiByZXF1aXJlDQo+ID4gPiB1ZGV2
Lg0KPiANCj4gSSdtIG5vdCBhcyBjb25maWRlbnQgYWJvdXQgdGhpcyBhcyB5b3UgYXJlLsKgIE5l
dHdvcmsgbmFtZXNwYWNlcyBhcmUgDQo+IHByZXR0eQ0KPiB1c2VmdWwgb24gdGhlaXIgb3duIHRv
IGNyZWF0ZSBpbmRlcGVuZGVudCBuZXR3b3JrIGNvbmZpZ3VyYXRpb25zIG9yDQo+IHRvDQo+IGlz
b2xhdGUgaGFyZHdhcmUgaW50ZXJmYWNlcy7CoCBXZSd2ZSBoYWQgYSBmZXcgc3VycHJpc2luZyBj
YXNlcyBvZiANCj4gY3VzdG9tZXJzDQo+IHVzaW5nIHRoZW0gaW4gY3JlYXRpdmUgd2F5cy4NCj4g
DQo+IFRoZXJlJ3MgYSBiaXQgb2YgYSBjaGlja2VuIGFuZCBlZ2cgcHJvYmxlbSB3aXRoIDIsIHRo
b3VnaC7CoCBJZiB0aGUNCj4gbmZzDQo+IG1vZHVsZSBpcyBsb2FkZWQsIHRoZSBrZXJuZWwgbm90
aWZpY2F0aW9uIGdldHMgc2VudCBhcyBzb29uIGFzIHlvdSANCj4gY3JlYXRlDQo+IHRoZSBuYW1l
c3BhY2UuwqAgSXRzIG5vdCBnb2luZyB0byB3YWl0IGZvciB5b3UgdG8gbW92ZSBvciBleGVjIHVk
ZXYNCj4gaW50byANCj4gdGhhdA0KPiBuZXR3b3JrIG5hbWVzcGFjZSwgYW5kIHRoZSBub3RpZmlj
YXRpb24gaXMgbG9zdC4NCj4gDQo+IENhbid0IHdlIGp1c3QgdW5pcXVpZnkgdGhlIG5hbWVzcGFj
ZWQgTkZTIGNsaWVudCBvdXJzZWx2ZXMsIHdoaWxlDQo+IHN0aWxsDQo+IGV4cG9zaW5nIC9zeXMv
ZnMvbmZzL25ldC9uZnNfY2xpZW50L2lkZW50aWZpZXIgd2l0aGluIHRoZSBuYW1lc3BhY2U/wqAN
Cj4gVGhhdA0KPiB3YXkgaWYgc29tZW9uZSB3YW50IHRvIHJ1biB1ZGV2IG9yIHVzZSB0aGVpciBv
d24gbWV0aG9kIG9mIHBlcnNpc3RlbnQNCj4gaWQNCj4gaXRzIGF2YWlsYWJsZSB0byB0aGVtIHdp
dGhpbiB0aGUgY29udGFpbmVyIHNvIHRoZXkgY2FuLsKgIFRoZW4gd2UgY2FuIA0KPiBtb3ZlDQo+
IGZvcndhcmQgYmVjYXVzZSB0aGUgcHJvYmxlbSBvZiBkaXN0aW5ndWlzaGluZyBjbGllbnRzIGJl
dHdlZW4gdGhlDQo+IGhvc3QgDQo+IGFuZA0KPiBuZXRucyBpcyBhdXRvbWFnaWNhbGx5IHNvbHZl
ZC4NCg0KVGhhdCBjb3VsZCBiZSBkb25lLg0KDQo+IA0KPiBXaGVyZSB3ZSBhcmUgdG9kYXkgaXMg
dGhlIGhvc3QgTkZTIGNsaWVudCBpcyB1bmlxdWlmaWVkLCBhbmQgYWxsIHRoZSANCj4gbmV0bnMN
Cj4gY2xpZW50cyBhcmUgZGlzdGluZ3Vpc2hlZCBmcm9tIHRoZSBob3N0LCBidXQgbm90IGVhY2hv
dGhlci4NCj4gDQo+IEJlbg0KPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=
