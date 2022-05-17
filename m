Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30BD529696
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 03:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiEQBOO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 21:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiEQBOM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 21:14:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2120.outbound.protection.outlook.com [40.107.236.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3D04093B
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 18:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cedkCsXIhQpt+qF1RBIImtOgSOtHwCk44DK+m2URjVVKHkcsRRFYEBSH7f7hzmWsgu0T7xYLNCZoKMwsRL/AvAJnTOS8Anrd3YLe9Hcp4g8MPT0/AnP0SjqWNktNNbIY+xxAWf7Evk7b3Smy1yFFOdOa4IfU9A8niAKf44ciXBWsPF/Dg5m+C6jkGna5HW8pEjGSGYRxLonbfIm2hgjUF637YvR4jWWakLIGsPb2Y1NpYdSEgqZ4QeDW0UcCXCqO22T/5iITQCktFbA0YIzWJICr7bhBAjkW01jnkly+W+Ila27mn3S9g4UmhQNhuR3hu5YIU+UWIgBKvLyPdTyOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dChkO+EigVoy+WjFoXWinE+HyjeCxQZhcOKIqSkmNr4=;
 b=mhgsuXsvPgeQ6rv1evFcJuF+DWDoaIAaD7JInoetNUUlYvYhaLfY3PeInHM1B+HxTOoNvwFfV5N8C/XBgVsoXeghCPQpTo14hhwG+ECO3OoMowW6n07BtA67FSA6r6sMuafKwLicFvM0nAzEOLe0Rfj2USP5H+9SxRdLszIgR8s4s79tIk0r2kTFXB1E9DXT2C61K8y3cmUFFcmaJaKzitI6YxHTDOoe+HuiXojzluU3vG2YYeFwRoHqEIYtoI0Fkd/aurM+P4ofhVWT7Q8b0U27mrzqU1dLsF0uTlPnXNuDI7vW5pBRr7wp1n+X9ayz3TWp5/ULqfOrmVM/YviqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dChkO+EigVoy+WjFoXWinE+HyjeCxQZhcOKIqSkmNr4=;
 b=fNCTZiESdOoGQiRqV38pIBxJHYu8T0Bc+cuvNNQ1LFLXY6pvz1D+BV78kJMM1C9pCJOEdY7LbNRb41KewWqJMFCymfKlWBDef+HPFIQNggE0xIb2+nW1vsDfPFAQtToziAmkpynRhenwUfYpqGdK4d4VzPuQg10N0kIwrAnBiAA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB1057.namprd13.prod.outlook.com (2603:10b6:404:22::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 01:14:09 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 01:14:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEAgAACsoCAAAKEgA==
Date:   Tue, 17 May 2022 01:14:08 +0000
Message-ID: <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>   ,
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>        ,
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>       ,
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>        ,
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
         <165274950799.17247.7605561502483278140@noble.neil.brown.name>
In-Reply-To: <165274950799.17247.7605561502483278140@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83f9aba2-a556-439a-8a51-08da37a28b76
x-ms-traffictypediagnostic: BN6PR13MB1057:EE_
x-microsoft-antispam-prvs: <BN6PR13MB1057D847ED5155E3339893FFB8CE9@BN6PR13MB1057.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TQnvrtwF2T7Y+4z7IUISMCccfCR9yeoG5+cpGSqvIn1/8mJiLZK+u66iDd9Hl2/nVeXGlfWAXniHFNM59U/5e6mRQaNDC5xbMp4SgajBPqUlbLm1ocZgV1oOPTLou0WY+Bd3NvE/54ws8YWdAoUZawUB30lMP1JXGb9l8SSf0nUHmkY3CKYjWqeTKaxEBdgJVkMLg3dBXCHyoOf9BjMZNCiimzHr3JDxMqUqTzKMswlnlsPGDtw5BJkC+4Mytg1YX6OpQDZmGANwxAc9mXmxdcCfeiMUJwhfc81q8oLsH5Xt+yO9V41YIFhLX9Zb9V7aeEatq8NgJJOARZwmwNQPb06eDaV7Yf0Oxp2IsQNYFcTHWw+GQVQZc+pDOQsLIJTAwJMg+L2l3MwIldmfrGvtCJ4QzrvXpv+JQhKwNUV1g/RAY/YJEMecv64+Nbs8S56SYZemzfFizqz/EE+DzF9UkyTCke/MGfoHgpBAI2tGJ50ITnInn5BYuxl+AHFYU4buKGAvotf1L8XDHlIfDXS3ob57p5Z5Rx4YmilVb9VRwXvsLL3am7fRwQPr3PkmQkpVsEKuiXvXTp+comJfZTA7JAu+5BbO1+9cr/PpJpCb91epfZeU0v8CMkb3CBzgrBLP0gHgYCPpheRpqJzUtyCaZSY36IuurAgwz1srSE4ERcA7fzIGCoIwYrXnlNyz3hw95+AyMHyj01EA4TzXFyAqAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(8936002)(83380400001)(38100700002)(38070700005)(71200400001)(5660300002)(122000001)(86362001)(6512007)(26005)(2616005)(54906003)(6916009)(2906002)(6506007)(66556008)(66476007)(64756008)(8676002)(66446008)(66946007)(76116006)(4326008)(36756003)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnY5WjZSM2k5Tkc1UXFsWlNWanFzTUQyQklqbytTZzZEczJiYVJvbkV5NHpx?=
 =?utf-8?B?UUtuV1crQUlGSTBBK2xGZld4ZnplTmxvcVhxQXV2dUxRRDR0a3pUMld1V2tX?=
 =?utf-8?B?TFZSSVFKOUhxMkpkZUtjVzhzWUljNW1Qc0pRZjZ6VHBhMVg1QlBRam92MXRQ?=
 =?utf-8?B?dEx2c2NNcnFLamw5TkcrQVpPVlhYdzRzbTFFL0hpMVF0cy9NM2RWRk5YRmJR?=
 =?utf-8?B?VGpJaWhLZzN4OWxHVkdpVDdQamJvK3N4TEIwV1B5YXA5aW9XbmRMTFUzcXZq?=
 =?utf-8?B?eFVNQ3Bta1dNamRlcGJWeUd1dFBzUnNFSnB0cSsrbGRZV2ZZVUNGZ0lmZnYz?=
 =?utf-8?B?dkdSZmdYdlBCQ2ZKdCt2RFFGaGROeHJLZ2JTUXM0cXhtOVRKTTFLT005VlhM?=
 =?utf-8?B?K0pvR0RFaERPM3lFVzcxQ1NFUXNTbmUxc3VjWG5ZNG4yT0lOSTlRbzRTUmhY?=
 =?utf-8?B?RWpJd3lzQnR4ZTJRdXA1aDFoU3VkeXFsbitJTDNhdkZpRHc2RlQrdTRkcDc1?=
 =?utf-8?B?bVZGSVlDcm1QSzZXUTZqV2Jka3F6L3FucUpsN2tkNUVRUnpLOE13SGRLWGd4?=
 =?utf-8?B?c1ZQelFYaFJuSCt2NjZoeGl3N3ZiQkhkMTBISWhRRjdsTkFBSUlUdUpOWk1t?=
 =?utf-8?B?VkV6SVZpNCtTazF6Rkhaa1JBM0JzZm9kQWVybStrNTMvRnA1cis3dXdibytx?=
 =?utf-8?B?czhQVnhNVkFLNEJ6RU9pRU5ua293M3NhQXBheGVwU0J6bHZJRE45THh2QVkx?=
 =?utf-8?B?Z2F1NjRPRnVhd1JaUG5HVmgxdkZIWHdhM0xoUWN0RFI1V3pudUlBMldEOTF2?=
 =?utf-8?B?TSsya1lORTAxbWhINWR3R0NhdENpczV0eTJMa29FcHdxRGFYOFFBclJIeFZS?=
 =?utf-8?B?NDJ0VHZXM1Nsb2J6dXFCRVJ6VmlrWjlYSXRaNGtrY1JCcmFwQVpQb3hhVmJR?=
 =?utf-8?B?MlRqU0hOaEViS09UbGtHZ09VUmdXTWVsbzVkUEltUGlCWWZkbzBNMzhFTWJK?=
 =?utf-8?B?eU9mUjBpK3VFN2cvbGo2ZlY1NGlTK3dUb0luQUliUTJQVDhYU2pJeG80UnZo?=
 =?utf-8?B?c09wT3dnUTJjRldQU2hkWW1ieHREZU5UV2lHd3NJZFR1cDNnc1I5QzlpYkEy?=
 =?utf-8?B?ak1qZkVlV1pxYzFJSmhXV0o5akpqVWhiaFBEQ3NPOVVCUlRFNjkybFhuSkRQ?=
 =?utf-8?B?eDdkU2lyV1pHaEZQZHFYLzlSMmN3dVRKUi9kWVk4NG9YYThESEthN2hKajVW?=
 =?utf-8?B?dmhNaCtpTEhmUytGZnpKRmpqMG5LOVZreVRTa1VtQmxCcnNxT1gxMGwxWkJ6?=
 =?utf-8?B?Z1U3akdaOW5ZUmU1VlV4Y2k0eEdKZ3VvbXAwZ2xEak1oQkdDRTc1N1hUOFY2?=
 =?utf-8?B?YkJMTDBmWGR6d2dhSzAzdWx1OUhlYUUraFJoWDU0cVVuK2padUEra1g0eDNt?=
 =?utf-8?B?UldXSFFLSFk5TFNUNXFsK1BhQ2pBd1ZTcnZvK0sxWFhEb2lwN1NGdWtjV1BM?=
 =?utf-8?B?cDFhUjZlTmdOcStGS3hYVTFWeWpqWGZYcXBWQTNuUDByandoYjlRMms0Q0Mx?=
 =?utf-8?B?Q2RNWE0yRHBjTnp2RUNRUHpWY1hwaXJMcFZpT1lXV0lINzg3ZjFRNWN5NFJL?=
 =?utf-8?B?Wm5obld3QVBqM1ZodFRrZ0lzUVpLNFFnTVQ0NEgxMDJDcnhZRmNKSE43K3Rt?=
 =?utf-8?B?VkpmMWJldXV5M1M3Z1E3ckhaU1ZKcU1Nd3dwWjFGeG4rTlpPVE9xSC9ZZ2Fm?=
 =?utf-8?B?YkJqdmg4WDY2aDBUYjhkWTM5N1hXZmpmOXBkRklsSm1YRFNGbENHbng5K25y?=
 =?utf-8?B?TFRlS2dVbFdBdUtBN3NRU3FYRXlwM1Y2RjRhT2taVTNhRjJXK1ROWjRGRVd0?=
 =?utf-8?B?d3ZKYW9VaEpyYStZOWxtSXVPYmlKekhpYXRlazk4eTV3UWZka0pCZ3BnQUtX?=
 =?utf-8?B?blBFdmUrWU54WFIxYjlia1hKcHovVnFtZUdWS3RkNjRLRUhEUXNuSHNTaFYv?=
 =?utf-8?B?TTl0RVVxUW9CdDIyS21UckphbEd4R0RFWGFvYUE2cUdCR1g2Q0Z1STVHMlhz?=
 =?utf-8?B?MXdoTXkyMStHdG12SHV3NFRCWHN2SXI5b2Z0WnRtKzZsczltSTl4ZlpZRWdI?=
 =?utf-8?B?aysvd0xjekx4WjlQOTJ0MWlKOW5UUTVjcy8yVEFpbW9xSStrYzA5L3JHYVhv?=
 =?utf-8?B?VE9tTU9DK3ZLclZ6eE9JN1h3YTkxN2JFRVJESjAzQ0ZUdlcvN1U3WlZyeGdC?=
 =?utf-8?B?bFl2WUxjMFR4WmFHYUFGQkJYSXRaVnJCQkpTaGhjbzBGS2Z2QlJMc1huM1Na?=
 =?utf-8?B?dDdJRXJKS2s5Y2gyZFE0MHBHTXAzUHl3RFZVWC9oY3Z2RU9jMTVMakdsVzRZ?=
 =?utf-8?Q?GW8D2HV8H3q4rA0E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68399913F7C93241B3A7339DB0A693CA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f9aba2-a556-439a-8a51-08da37a28b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 01:14:09.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHLA87jGlZ/TGhmyMxviboPBXERJLdBsjFP+1vYBAt1/+cYdwn6FNZTA27t1TgxK/9koeTk9/Xpf3CAISZITNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTE3IGF0IDExOjA1ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMTcgTWF5IDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBUdWUsIDIw
MjItMDUtMTcgYXQgMTA6NDAgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IE9uIFR1ZSwg
MTcgTWF5IDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIy
LTA1LTE3IGF0IDEwOjA1ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gSGksDQo+ID4gPiA+ID4gwqBhbnkgdGhvdWdodHMgb24gdGhlc2UgcGF0Y2hlcz8NCj4g
PiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBUbyBtZSwgdGhpcyBwcm9ibGVtIGlzIHNpbXBseSBu
b3Qgd29ydGggYnJlYWtpbmcgaG90IHBhdGgNCj4gPiA+ID4gZnVuY3Rpb25hbGl0eQ0KPiA+ID4g
PiBmb3IuIElmIHRoZSBjcmVkZW50aWFsIGNoYW5nZXMgb24gdGhlIHNlcnZlciwgYnV0IG5vdCBv
biB0aGUNCj4gPiA+ID4gY2xpZW50DQo+ID4gPiA+IChzbw0KPiA+ID4gPiB0aGF0IHRoZSBjcmVk
IGNhY2hlIGNvbXBhcmlzb24gc3RpbGwgbWF0Y2hlcyksIHRoZW4gd2h5IGRvIHdlDQo+ID4gPiA+
IGNhcmU/DQo+ID4gPiA+IA0KPiA+ID4gPiBJT1c6IEknbSBhIE5BQ0sgdW50aWwgY29udmluY2Vk
IG90aGVyd2lzZS4NCj4gPiA+IA0KPiA+ID4gSW4gd2hhdCB3YXkgaXMgdGhlIGhvdCBwYXRoIGJy
b2tlbj/CoCBJdCBvbmx5IGFmZmVjdCBhIHBlcm1pc3Npb24NCj4gPiA+IHRlc3QNCj4gPiA+IGZh
aWx1cmUuwqAgV2h5IGlzIHRoYXQgY29uc2lkZXJlZCAiaG90IHBhdGgiPz8NCj4gPiANCj4gPiBJ
dCBpcyBhIHBlcm1pc3Npb24gdGVzdCB0aGF0IGlzIGNyaXRpY2FsIGZvciBjYWNoaW5nIHBhdGgN
Cj4gPiByZXNvbHV0aW9uIG9uDQo+ID4gYSBwZXItdXNlciBiYXNpcy4NCj4gPiANCj4gPiA+IA0K
PiA+ID4gUkZDIDE4MTMgc2F5cyAtIGZvciBORlN2MyBhdCBsZWFzdCAtIA0KPiA+ID4gDQo+ID4g
PiDCoMKgwqDCoMKgIFRoZSBpbmZvcm1hdGlvbiByZXR1cm5lZCBieSB0aGUgc2VydmVyIGluIHJl
c3BvbnNlIHRvIGFuDQo+ID4gPiDCoMKgwqDCoMKgIEFDQ0VTUyBjYWxsIGlzIG5vdCBwZXJtYW5l
bnQuIEl0IHdhcyBjb3JyZWN0IGF0IHRoZSBleGFjdA0KPiA+ID4gwqDCoMKgwqDCoCB0aW1lIHRo
YXQgdGhlIHNlcnZlciBwZXJmb3JtZWQgdGhlIGNoZWNrcywgYnV0IG5vdA0KPiA+ID4gwqDCoMKg
wqDCoCBuZWNlc3NhcmlseSBhZnRlcndhcmRzLiBUaGUgc2VydmVyIGNhbiByZXZva2UgYWNjZXNz
DQo+ID4gPiDCoMKgwqDCoMKgIHBlcm1pc3Npb24gYXQgYW55IHRpbWUuDQo+ID4gPiANCj4gPiA+
IENsZWFybHkgdGhlIHNlcnZlciBjYW4gYWxsb3cgYWxsb3cgYWNjZXNzIGF0IGFueSB0aW1lLg0K
PiA+ID4gVGhpcyBzZWVtcyB0byBhcmd1ZSBhZ2FpbnN0IGNhY2hpbmcgLSBvciBhdCBsZWFzdCBh
Z2FpbnN0IHJlbHlpbmcNCj4gPiA+IHRvbw0KPiA+ID4gaGVhdmlseSBvbiB0aGUgY2FjaGUuDQo+
ID4gPiANCj4gPiA+IFJGQyA4ODgxIGhhcyB0aGUgc2FtZSB0ZXh0IGZvciBORlN2NC4xIC0gc2Vj
dGlvbiAxOC4xLjQNCj4gPiA+IA0KPiA+ID4gIndoeSBkbyB3ZSBjYXJlPyIgQmVjYXVzZSB0aGUg
c2VydmVyIGhhcyBjaGFuZ2VkIHRvIGdyYW50IGFjY2VzcywNCj4gPiA+IGJ1dA0KPiA+ID4gdGhl
IGNsaWVudCBpcyBpZ25vcmluZyB0aGUgcG9zc2liaWxpdHkgb2YgdGhhdCBjaGFuZ2UgLSBzbyB0
aGUNCj4gPiA+IHVzZXINCj4gPiA+IGlzDQo+ID4gPiBwcmV2ZW50ZWQgZnJvbSBkb2luZyB3b3Jr
Lg0KPiA+IA0KPiA+IFRoZSBzZXJ2ZXIgZW5mb3JjZXMgcGVybWlzc2lvbnMgaW4gTkZTLiBUaGUg
Y2xpZW50IHBlcm1pc3Npb25zDQo+ID4gY2hlY2tzDQo+ID4gYXJlIHBlcmZvcm1lZCBpbiBvcmRl
ciB0byBnYXRlIGFjY2VzcyB0byBkYXRhIHRoYXQgaXMgYWxyZWFkeSBpbg0KPiA+IGNhY2hlLg0K
PiANCj4gU28gaWYgdGhlIHBlcm1pc3Npb24gY2hlY2sgZmFpbHMsIHRoZW4gdGhlIGNsaWVudCBz
aG91bGQgaWdub3JlIHRoZQ0KPiBjYWNoZSBhbmQgYXNrIHRoZSBzZXJ2ZXIgZm9yIHRoZSByZXF1
ZXN0ZWQgZGF0YSwgc28gdGhhdCB0aGUgc2VydmVyDQo+IGhhcw0KPiBhIGNoYW5jZSB0byBlbmZv
cmNlIHRoZSBwZXJtaXNzaW9ucyAtIHdoZXRoZXIgZGVueWluZyBvciBhbGxvd2luZyB0aGUNCj4g
YWNjZXNzLg0KPiANCj4gSSBjb21wbGV0ZWx5IGFncmVlIHdpdGggeW91LCBhbmQgdGhhdCBpcyBl
ZmZlY3RpdmVseSB3aGF0IG15IHBhdGNoDQo+IGltcGxlbWVudHMuDQo+IA0KDQpOby4gSSdtIHNh
eWluZyB0aGF0IG5vIG1hdHRlciBob3cgbWFueSBzcGVjIHBhcmFncmFwaHMgeW91IHF1b3RlIGF0
IG1lLA0KSSdtIG5vdCB3aWxsaW5nIHRvIGludHJvZHVjZSBhIHRpbWVvdXQgb24gYSBjYWNoZSB0
aGF0IGlzIGNyaXRpY2FsIGZvcg0KcGF0aCByZXNvbHV0aW9uIGluIG9yZGVyIHRvIGFkZHJlc3Mg
YSBjb3JuZXIgY2FzZSBvZiBhIGNvcm5lciBjYXNlLg0KDQpJJ20gc2F5aW5nIHRoYXQgaWYgeW91
IHdhbnQgdGhpcyBwcm9ibGVtIGZpeGVkLCB0aGVuIHlvdSBuZWVkIHRvIGxvb2sNCmF0IGEgZGlm
ZmVyZW50IHNvbHV0aW9uIHRoYXQgZG9lc24ndCBoYXZlIHNpZGUtZWZmZWN0cyBmb3IgdGhlDQo5
OS45OTk5OSUgY2FzZXMgb3IgbW9yZSB0aGF0IEkgZG8gY2FyZSBhYm91dC4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
