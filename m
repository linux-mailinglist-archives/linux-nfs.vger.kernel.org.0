Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249E94C1E27
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 23:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiBWWAn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 17:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbiBWWAm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 17:00:42 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2126.outbound.protection.outlook.com [40.107.237.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9775E50449
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 14:00:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alVfK36Lrdm7YnrmulNIBuiM56l99gtzmRb+oK3naRS4BkrAX4NKUf2oB4ay86CcjqFap1lIjX1URtcEvh9SPsSHF/6TgDp2af/Clp7rKODrzDpEmWN90o1PEdlF1oUCz/2rwmos90dqXo2Whe0Lc17VU89nY2aRPsEw2gGB23DMe8OankVfTxh/EbB7rruHCbmdMaw1e7g7mTaVPZK6WTQBb4/hp2g9ZDYR2azV8qRWqEiKY/jT6OZzxUZVc9XeVk16YvLRnU6wRZGwcM07Ferbt9lSu0Q7RZLPlxBLvXE7Gi3K/8yxrxJu0bUFlqksqA3/l6HHTk7snL9boFiv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LexyYR5D2ZV8MEc7YNLW0blqh5UiRagzlHHF8xLUSqQ=;
 b=jykbPxRqgZQKArrnO9R1FKsl1S25R2xGSSSwpVQbkun/wMJ/GR6Su32oAezbffq/g7tZi2UNCa+j0ez/ty6IfGO2XarLM2Sn3SWRwlfGNvrOULyupqflKOMGDfbNr2dRBTIai3MFjBS5btnfiayYf7ge7EqefCw7NLP9l1gyQx7+HFjIhdQ/jzWGFm8fOkAmq+hOEaFhmDk2OsyEZm1nZGMAX0eOwx4TTz4zWyeTihdkx7iF7KizOp1bSj/LhEevF1bdRUMc0T8V9EczY0Vf/Z4UtTBlv3IbVw88MUOmbzlOghoq4cvBmyIIPgSDpHlit4aIfWbb1cVerPZ0wua2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LexyYR5D2ZV8MEc7YNLW0blqh5UiRagzlHHF8xLUSqQ=;
 b=N58uY1XoUJx+OOAVR3/c3iSoJyH2Tf2x9QM8NAvOY+5ddPbyEI0LIkgciEjXs3TjdBswzcGjsSEKENyJQKPAN0+m1xWb53QJJsx4MiLQz1YZTieVgIiC1ppLXnupeRpQARdgHjZY5WlsYHvSWwBSKaXXvxz6ZwK8V2t5WRFCU98=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW2PR13MB4186.namprd13.prod.outlook.com (2603:10b6:302:13::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.14; Wed, 23 Feb
 2022 22:00:09 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Wed, 23 Feb 2022
 22:00:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "kurt@garloff.de" <kurt@garloff.de>,
        "Olga.Kornievskaia@netapp.com" <Olga.Kornievskaia@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Thread-Topic: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Thread-Index: AQHYJqjv6MadTc/e/U6k4dGAgYDQkKydEscAgAAiE4CAAImAgIAAFXOAgAOfE4CAAEE9gA==
Date:   Wed, 23 Feb 2022 22:00:08 +0000
Message-ID: <29c0db53ab6dee067c1b91ba3eeca98310506453.camel@hammerspace.com>
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
         <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
         <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
         <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de>
         <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
         <FFD47AE3-D6B0-417F-B0CF-D89E6FDB38C5@oracle.com>
In-Reply-To: <FFD47AE3-D6B0-417F-B0CF-D89E6FDB38C5@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76bff1a1-044c-4df3-eed9-08d9f717db9c
x-ms-traffictypediagnostic: MW2PR13MB4186:EE_
x-microsoft-antispam-prvs: <MW2PR13MB4186C36E12545CE2A4FA3E4DB83C9@MW2PR13MB4186.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JF/FVG7MBgBSxP/tt4SK5/2qnNWGoa1qbBfK2EN+MMBv56wfJ5q3oqq4kFI9FLzgKN62BGHm8kOeu11LMCjJduEJ5T7hhdHtsHodtMPZiG4Tz9Ivam31x/qjRoSLMe2MEyYuzSlE5YXmegPpofw/hwc/Nhw3+rUzLKo4rUrWaocQVntgaj0j/FNEP2C01NKT9Po9wnZoZ8aTcllt3Veiu656KWYFwJN0pzCYneCEnvWIIRb8c3FLsBdDf6hsu5LwsI9B/GzljaoSwXB/39nFtzU0iaYvqWP9YbF4VRhBpIdjxOi5e/Bs5rvQXgAbP6trKUlRz6yMjQVEPtsvx5LntkEV48ZiEkqD3XtLNrKvD9KqX3JiEmSK2j8D/BIEXJM5moCv7c516Ur5fIXQ+lHvVoyre3FrMgzFNz69JGrepqcEZdHe/NwfhUgjcbvKFoajLpMY5mjLHbfIMTNH0v26GOgo9Q+ojWjugCL0tGXV39HneoDU6eJpvnmg72cQFAooP22n6Wccu+xhanMgX1/RXXgP090L9gTaCM084+QXJYHZBZVjNC2raUp+i031TptInFfP8K4RgxRLDBU6JtdBc4CpQg0lxrhGnJc+RajqJJHC6dPkwyJ32enQHZ+/sPjdIViCJ2q4mIDQ9Q6mz6Noql6anjHu9v5HiHZ+ZG6/Qw7sp2GOR6raErf/tbSCgY0vUmQS4tnsHW3+YBb7eTEV63u4Il0D16p65/Q7V3y32C9GjcuHmijGw8vPP3XFT4a4gyD48u9l7r3fwXwyBjV/K9LvAcGdD7W14gkeHXuGhxw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(136003)(396003)(366004)(39840400004)(346002)(38070700005)(66946007)(83380400001)(76116006)(186003)(26005)(66476007)(66556008)(8936002)(5660300002)(64756008)(66446008)(2906002)(4326008)(8676002)(36756003)(316002)(86362001)(6486002)(508600001)(6506007)(53546011)(2616005)(38100700002)(6512007)(54906003)(71200400001)(110136005)(122000001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnVqTkJUY1hBWlpBbVBQeDVCVGpOTndpbkdvTU4wWVdLUzROOHE2VTFlRGp0?=
 =?utf-8?B?aXRwdXNQakxaZWxUMWRXY1ZIZEc4RThBRXlsaU9jb1NuSXhxTGlBVDBFMEN1?=
 =?utf-8?B?bXQ5WDJUVmZSY2VSb3hyYkpaR3JKaHJyTU55VUF0S2VKWS91RmRDVWh3MlZs?=
 =?utf-8?B?MU0yMGxsS2JzcVBqcTY4eFRqdlhSYzVHTUR1dTRnVDdLUkNSL0JtTzVBc1pt?=
 =?utf-8?B?cHdlQ1NYU25BNVdwYlB1R1JidGRzUVp0VmYwdlhPdEZTaFhNbTRWUUJSK1lx?=
 =?utf-8?B?RURwOHFxeUFpV0YwRjh2R2U4OFBXUjRaUjhrbi9VVk04ci95NEtwSGZacXJI?=
 =?utf-8?B?MkJiVnYwTHJMU0N4ZHlWS3E1Sk81R0U2UkY5TFJndzNVRTMrMGo4MDF1U1o3?=
 =?utf-8?B?S0FxVUtEWW1uNmRoaXNGTmtYRnNSdUdodGQrc3g3UHZSbzExck1WSHBtSjgy?=
 =?utf-8?B?ZHhtaW5OSXNjdXI0VEU0V1YxelFTU3Uzd0hwMEYrdmNtTWp2WGk5NllYbUhS?=
 =?utf-8?B?dDRFb1lwOUtEdmx2U1E4Q082OFF3ajlLdHJVeVhBUmxCdnd1MU5XMVQ0Y3VC?=
 =?utf-8?B?ZnB5UDRCemU3NFh4KytyNWV1QTdPMHIxWjhsempkZDZEaENWMVdSMDhtYm5W?=
 =?utf-8?B?NDhML1ExeWxMVk4zOEdNam1sNjNlM1pHNDFQcDRFck9mVmRXdXRzVXZaUjg4?=
 =?utf-8?B?Sy96Rlhlc05iSkVScVRaVHlYQlZmZnRHaWZ1YkpjMUxaWTRadlRlbkRWeThV?=
 =?utf-8?B?cGlOdWhKVmVwVmxVNXR2bG9zdmo4UDFCNk8yejVtaElDL2pGMmRBRHV1VkNM?=
 =?utf-8?B?NzRNanpBU1hWYkYxM0ZjMUlRdjVtR3Y4Q2lZZ3ppU0c1dkhtcDIxa0JraUZ1?=
 =?utf-8?B?dGJ2ckRzc1BXU0dHcEZXdXNPUWhCTHJJNSswVlByaEVDVUVrL3RCNFZsY1dk?=
 =?utf-8?B?Rkc5UWVReFJkOHNEVy9OdFlJWTBvMjBUeVRHRkQ0MDg3c0xoQ2tDZEFmMjB1?=
 =?utf-8?B?RTlEZFEySk9PZ2gvK2tsQysxdFdsWmh5TTZSWXorMzgwa2crYXJESmtPSlBq?=
 =?utf-8?B?dlpndmgyWUdxYnROZHgwb3ZIMlF5ckMrbUZ5Vlc1Z1FFSFhFQ3pwVmx3OWdJ?=
 =?utf-8?B?RFFQdzEveStxZ204Qnk1cFRBekhXMUFPcFlOWGd5TUgyN28wQ2drMkRBOVdB?=
 =?utf-8?B?bjJBMWFzUHFLSVdkVEQrUUk1VWQvaDVNU21GTVJoaWZ6bnZSb3pjQWxaVkg5?=
 =?utf-8?B?L2ZnQklmalpRSFFLZmwva1l2cTdYV3EyekpRNUZycm9Va0pSWlhQOWp5QW8v?=
 =?utf-8?B?Ni9xSU5ZQW1kdk5WeUtJbVJIdWJoTzR5V29odnhkTGxCdjJRbFBwOWgwMHlE?=
 =?utf-8?B?cDNQaWZ4bFBPb2llKzFMMzZ4Rkh3K0JZUFhyTXhzY3Z1RDFDOWd2bUVTUWds?=
 =?utf-8?B?MlRmUmQ5VDh5R21idktpQy8xTlQ0RGZqM2NCSE9xWHlCZStndi9ibmxXWDdy?=
 =?utf-8?B?LzlEMHNlQkdmUVFKU0ZFcm94K0k3YVdURmtvVHMwZU9oay9QZDBwZk0rcW1u?=
 =?utf-8?B?S0dOMkFKVm55THp6R2NVSHRUSU1YM2kxbjMvNHVmTy92c3lmOEpCOWxCcVdk?=
 =?utf-8?B?Tm1Oc0VvU3k4ZmM2bHczVGhkU3daRkV6Z1VOelJlRGFUdUtrUFdDM0l1VWpr?=
 =?utf-8?B?d2M4aU1SYlE3WGVQWVArTUtSU2wvUFBzNU1LdUJrSGNsVGxYWVJCQXpyWW1p?=
 =?utf-8?B?N0NSbWgwMmNyb2NDQTVhbysybUo4UnVyVUdmOHNyUzkrWjliVmlVci9ha3hO?=
 =?utf-8?B?b2d2eitubS84LytDK0c2TnBvSUFLaXFDdE1aR0xiVFdiTzlWeHJEeWtmSEZ4?=
 =?utf-8?B?Y3RQYUNmaTlYOWc0amIrT2tsNTBIQmNLdFFFZWx5dks2Y0ZybEtvZmIrRUkz?=
 =?utf-8?B?RHBBYjFaalNSSHlnazhzSjI4MFlaSGNvUEt4UmZQbXNhMytjMWVNNW83WEMx?=
 =?utf-8?B?dS8xai9FN0NCTHd2aHNaUlBwRmpkMEhwLzhabDg0MGF4MnN0ZDJVWHpHMUMy?=
 =?utf-8?B?a1B2NWxyRXhFd2FJbkxydElOUEYwdGg1WEhvanJaRnhpUnAwNEcvamxHWUhp?=
 =?utf-8?B?bEZvKzJCb1ZPMFJ3NkFLRE5HOHNFRFRwV2lJYVEwa1VUTCt5czRUZVQ0ZDBL?=
 =?utf-8?Q?/wtCCpI80KFYqlDiZUpv5Hc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3952B3DA835B2F4893A7D6DDBC145336@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bff1a1-044c-4df3-eed9-08d9f717db9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 22:00:08.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vqQJCoxoHz/VUiQOK2UV85iARvUUYhQ3OD40NlghObUHZfc/dDnvc0AgI2C7wpetSO8mCftNrLLOAY6B+Edkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR13MB4186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAyLTIzIGF0IDE4OjA2ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBGZWIgMjEsIDIwMjIsIGF0IDU6NDggQU0sIEt1cnQgR2FybG9mZiA8
a3VydEBnYXJsb2ZmLmRlPiB3cm90ZToNCj4gPiANCj4gPiBIaSwNCj4gPiANCj4gPiBPbiAyMS4w
Mi4yMiAxMDozMSwgS3VydCBHYXJsb2ZmIHdyb3RlOg0KPiA+ID4gSGkgT2xnYSwNCj4gPiA+IA0K
PiA+ID4gT24gMjEuMDIuMjIgMDI6MTksIEtvcm5pZXZza2FpYSwgT2xnYSB3cm90ZToNCj4gPiA+
ID4gWy4uLl0NCj4gPiA+ID4gSXMgaXQgcG9zc2libGUgZm9yIHlvdSB0byBwcm92aWRlIGEgbmV0
d29yayB0cmFjZT8NCj4gPiA+IA0KPiA+ID4gWWVzLg0KPiA+ID4gDQo+ID4gPiBJcyB0Y3BkdW1w
IHdoYXQgeW91J2QgbGlrZSB0byBzZWU/IHdpcmVzaGFyaydzIGR1bXBjYXA/DQo+ID4gPiBBbnkg
TkZTIHNwZWNpZmljIHRyYWNpbmcgdG9vbHMgSSBzaG91bGQgYmUgdXNpbmc/DQo+ID4gPiANCj4g
PiA+IE9uZSB0cmFjZSB3aXRoIGEgd29ya2luZyBrZXJuZWwgYW5kIG9uZSB3aXRoIHRoZSBicm9r
ZW4gb25lPw0KPiA+IA0KPiA+IENvbXBhcmluZyB0aGUgZ29vZCBhbmQgdGhlIGJhZCB0cmFjZSAu
Li4NCj4gPiANCj4gPiBtb3VudCAtdCBuZnMgMTkyLjE2OC4xNTUuNzQ6L1B1YmxpYyAvbW50L1B1
YmxpYw0KPiA+IGFnYWluc3QgUW5hcCA0LjMuNC54eHggTkZTIHY0LjEgc2VydmVyLg0KPiA+IA0K
PiA+IEJvdGggZG86DQo+ID4gDQo+ID4gRXN0YWJsaXNoIGNvbm4NCj4gPiBORlMgTlVMTCAoYWNr
KQ0KPiA+IE5GUyBFWENIQU5HRV9JRCAoNC4yIC0+IE5GUzRFUlJfTUlOT1JfVkVSU19NSVNNQVRD
SCkNCj4gPiBUZWFyZG93biBhbmQgcmVlc3RhYmxpc2gNCj4gPiBORlMgTlVMTCAoYWNrKQ0KPiA+
IE5GUyBFWENBSE5HRV9JRCAoNC4xIC0+IGFjaykNCj4gPiBORlMgRVhDQUhOR0VfSUQgKDQuMSAt
PiBhY2spDQo+ID4gTkZTIENSRUFURV9TRVNTSU9OIChhY2spDQo+ID4gTkZTIFJFQ0xBSU1fQ09N
UExFVEUgKENCX05VTEwsIGFjaykNCj4gPiBORlNfU0VDSU5GT19OT19OQU1FIChhY2spDQo+ID4g
TkZTIFBVVFJPT1RGSHxHRVRBVFRSIChhY2spDQo+ID4gTkZTIEdFVEFUVFIgRkg6MHg2MmQ0MGM1
MiAoYWNrKSwgOCB0aW1lcw0KPiA+IE5GUyBBQ0NFU1MgRkhfIC14NjJkNDBjNTIgKGRlbmllZCBt
ZCB4dCBkbCwgYWxsbG93ZWQgcmQgbHUpDQo+ID4gTkZTIExPT0tVUCBESDoweDYyZDQwYzUyL1B1
YmxpYyAoYWNrKQ0KPiA+IE5GUyBMT09LVVAgREg6MHg2MmQ0MGM1Mi9QdWJsaWMgKGFjaykNCj4g
PiBORlMgR0VUQVRUUiBGSDoweDhlZTg4Y2VlIChhY2spLCAzIHRpbWVzDQo+ID4gDQo+ID4gDQo+
ID4gTm93IHRoZSBkaWZmZXJlbmNlcyBzdGFydDoNCj4gPiANCj4gPiBUaGUgZml4ZWQgTkZTIGNs
aWVudCByZXBlYXRlZGx5IGdldHMgYWNrIGJhY2ssIHRoZSBicm9rZW4gTkZTDQo+ID4gY2xpZW50
IGdldHMNCj4gPiANCj4gPiBORlMgR0VUQVRUUiBGSDoweDhlZTg4Y2VlIChORlM0RVJSX0RFTEFZ
KSwgcmVwZWF0aW5nIGZvcmV2ZXIgKGV4cC4NCj4gPiBiYWNrb2ZmKQ0KPiANCj4gQW55IGlkZWEg
d2h5IHRoZSBzZXJ2ZXIgaXMgbm90IGFibGUgdG8gcmVzcG9uZCBwcm9wZXJseSB0bw0KPiB0aGUg
R0VUQVRUUiByZXF1ZXN0PyBUaGF0IHNlZW1zIGxpa2UgdGhlIHJvb3Qgb2YgdGhlIHByb2JsZW0u
DQo+IA0KDQpUaGUgR0VUQVRUUiBpcyBhIHJlcXVlc3QgZm9yIGZzX2xvY2F0aW9ucyBpbiBvcmRl
ciB0byBwcm9iZSBmb3INCmFsdGVybmF0aXZlIElQIGFkZHJlc3Nlcy4NCg0KSUlSQywgc29tZSBl
YXJsaWVyIGltcGxlbWVudGF0aW9ucyBvZiBrbmZzZCBoYWQgdGhpcyByZXNwb25zZSB3aGVuIHRo
ZQ0KbW91bnRkIGRhZW1vbiB3YXNuJ3QgY29uZmlndXJlZCB0byBleHBlY3QgYSByZWZlcnJhbCB1
cGNhbGwgZm9yIHRoYXQNCmxvY2F0aW9uLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
