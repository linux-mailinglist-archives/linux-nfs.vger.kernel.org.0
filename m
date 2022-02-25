Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D044C3D10
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 05:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiBYEZl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 23:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBYEZk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 23:25:40 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A73F542B
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 20:25:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdP2ZLZkzYhNH4kSoEVpnaqYxWnEcMEEjXYIJ40hiiBOWw0dcz9bEECOubvV+qfBtGnuGvftHg/AVJvdTdz+s6x2dzCSOV5fnD771BMkadwxRnrIyWLqNjIsS0HyEB0uneDCLGbhWfS1sRMSmyyuLQ9KQKwX/Sh8U0DJKC+UURR4Uu3NKZNd0Gt18UhfegCjH18cd/vbcNarkfquOgVsgjcZc+wojOcCHZNef1eduzh2ld2oQJ2xzcbFjowtmXPnlM5Cs0UkxdPaZhzScM3TIoXVv8mVUU7209EFJ18F9FuwrS/yU5M88WKyHzt8u7EF2uPjs1V/OWOQYDhE7Lb5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqJH+h7ngXgXOr1fix4/i9y/SJ8CLghUJOS+gviHBEQ=;
 b=YILr7yPVEI2TNmwjKi9upHtHEi1nt+XyrIGYO8TVFmCFvAncKP7VUBCSny5B/nO8/gjUc984fTw0lu+IIYXFbMzaosHJ1uSgIeqjm8+w27SW2bs8TWxNYwhw8DxrkabcDiaET2N3khhuzcFQX6iYYcOgPXF4EpRHgElpr+MS2fVy7/uCmnnTwJX3LyqYuiqAsUrzZRoeQrkTjyXeluCGpvPD0y4gbJ97Nte1/YWa2I8g2LOuMXjCsGixzGLPYarjKyO1IO49g5ogUMbfcLaUWzbtq13X3ChVBBYs2SYAU8t8HO7gQD8lHALjY1CXjKgI01RIvfPsCNFZfqhfAmC3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqJH+h7ngXgXOr1fix4/i9y/SJ8CLghUJOS+gviHBEQ=;
 b=G05FQNYNSYaIRvSNZghyQ5tfUA7ykl2Mkwlu57GLh74dQHyuoGjSgDangItD2YSwO+Epc8kDemItotSA8v1nhsyjj9ltC6JWkNPln2OiHp5R3JGypjuc9GcXeVO0cHvEy4px2KHgcZC5Tj6SUrTggSnJI9HZ2mh/8w8laaHu6VQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3524.namprd13.prod.outlook.com (2603:10b6:a03:1a7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 04:25:03 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Fri, 25 Feb 2022
 04:25:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH v7 19/21] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Topic: [PATCH v7 19/21] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Index: AQHYKPtgN77REpvsVUWcQtB9d3Bbtayi9t8AgACXPoCAAAx0gIAAEsgA
Date:   Fri, 25 Feb 2022 04:25:03 +0000
Message-ID: <4f1a9a7b5e3ac59e365c5e40ee146ceb0f4e1429.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>        ,
 <20220223211305.296816-2-trondmy@kernel.org>   ,
 <20220223211305.296816-3-trondmy@kernel.org>   ,
 <20220223211305.296816-4-trondmy@kernel.org>   ,
 <20220223211305.296816-5-trondmy@kernel.org>   ,
 <20220223211305.296816-6-trondmy@kernel.org>   ,
 <20220223211305.296816-7-trondmy@kernel.org>   ,
 <20220223211305.296816-8-trondmy@kernel.org>   ,
 <20220223211305.296816-9-trondmy@kernel.org>   ,
 <20220223211305.296816-10-trondmy@kernel.org>  ,
 <20220223211305.296816-11-trondmy@kernel.org>  ,
 <20220223211305.296816-12-trondmy@kernel.org>  ,
 <20220223211305.296816-13-trondmy@kernel.org>  ,
 <20220223211305.296816-14-trondmy@kernel.org>  ,
 <20220223211305.296816-15-trondmy@kernel.org>  ,
 <20220223211305.296816-16-trondmy@kernel.org>  ,
 <20220223211305.296816-17-trondmy@kernel.org>  ,
 <20220223211305.296816-18-trondmy@kernel.org>  ,
 <20220223211305.296816-19-trondmy@kernel.org>  ,
 <20220223211305.296816-20-trondmy@kernel.org>  ,
 <EF67F180-F1D8-4291-92C8-86E5D10D1F25@redhat.com>      ,
 <73e0a536c0467693db87c3966cf02e20ff3d889b.camel@hammerspace.com>
         <164575906990.4638.4113048743095971193@noble.neil.brown.name>
In-Reply-To: <164575906990.4638.4113048743095971193@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cfe0259-125b-48bb-10b5-08d9f816cb8a
x-ms-traffictypediagnostic: BY5PR13MB3524:EE_
x-microsoft-antispam-prvs: <BY5PR13MB35246E7B5FEA3539ED439666B83E9@BY5PR13MB3524.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZndUoYiJWgitsriFHK3D+1A8FpiiAnFpiaHvrVroYgyMEo2ARJu1Etn8tmvNYCGY8r//5zZUe5ExxZFllgqW0+woX6U+RNjOq7y+8k16WXf9DrtkBoSXE9YQ/0XuUBl/j8H0N3wGg1ODWiieNIJeCQOkaUOqKlC6V9pNcSqAjujF2+msDS4z+yMdb8RuQ16ivshCLDAiP3kvDhU9bsojJF5ybY+CV68F9sEb3UYqV9/N7oVyPKvUlLWNUX9qPjBrQsNXCIadCJ8thy2PU60ns9ODWzUyncCVLIlMi9Ob+OVrmV8pNimskT14YdEbhn0cXOtY+jsotqh8t69hsjV++emghw0bk1xZOY0rQA7agj6ZwSlxF7lOB1KHA5S+jFbpnH7eneqr3l0N/Q4H52dtFBjoWXEFZIueMxdzFip/xN3vbtU91jmOmTu+c/3hlyTcgQMvaC15Y1QOY0LL9lFKu7NG2GD7ATslUJzXFKlMDtJKDKNa3sIWU3080MlAPV7WFYB7NKEDQlTJofF5Mg+Gkc51Vi2Vm7NtCFG7BXYqG5wFTa9PdKYjM0Q7L+3T8xMdj0bQA2tvMRmunHBbQgD4k+dpF4n5v3oyATBdGKQ7COP6a5PRdEYJxkyJ6d8bbfOnsQNdAHvdY737yq1nXWuQOpmPW26bZg23vjos/MJbHkVXT1rKslGAe9CNeUW+d470iHTfAO5M+Q8yaiSrQdwfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(39840400004)(366004)(396003)(376002)(346002)(26005)(6486002)(86362001)(71200400001)(508600001)(122000001)(2906002)(186003)(38100700002)(66476007)(6512007)(83380400001)(8676002)(6506007)(66556008)(6916009)(64756008)(54906003)(5660300002)(66446008)(38070700005)(76116006)(36756003)(316002)(66946007)(2616005)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bks5K2JyRXYyWFNYOGlnZ0VNWUpZdGM5bjFaMXZ3dnBkL3IxdEkrZ1VXU2lT?=
 =?utf-8?B?RXNDNlpYNVJYcWlnWHcyOEJsU0JucnJsaVRGRnM1UU11UjBxYnNkd0xoQmJh?=
 =?utf-8?B?MDI2ZVUyQUZXQzVFRFdIQWVYUlhQMEZNUjJBODhFci9DZlJLYVJaMHE5dlFZ?=
 =?utf-8?B?VzAxWW14OENLY25Ua1hMVTJrWnU4ZTlFQ21lZ3lNNlFFZ2kyOHE1UFlNbmw5?=
 =?utf-8?B?OHJ4OU4yamlFYUN4MFF0YjZqMXg3R2QrT1JzMnpqL0JtSVV3QlovaldTZXdV?=
 =?utf-8?B?dHU5VHZBc3lOWkNWWUYyYVBWbUsxV3gwelJWWWtIa0cxUy9tcVYzZDlTTWZE?=
 =?utf-8?B?T2h6NFBCMVJvYnRET1hjZkdKcC92Tm45WDlKYVpPZGFtWThtUklBSXFxZFUy?=
 =?utf-8?B?NVZ2SjdCaUJuS25YMlBoWVNjYVBmVFI5VkRSelhwTXVKZlVKNUlzbWlhaDds?=
 =?utf-8?B?Tnd2MHlKc1ozRTdaNG9PemxMeHZLSVRzVWp6ZDVqY3AvOS9Pb3MrZTZUWHl3?=
 =?utf-8?B?cSs5RWxxTjZENEZISXM0U1R0UnRsdUJwZVRpRW9qbnkrMnRNWkRYdVRWL0VG?=
 =?utf-8?B?bVVpR1oyUUJ1bUlWME5ucUxObFhadTQyWnJRNm13SDA4NDlBVTNxdU9ORzhr?=
 =?utf-8?B?RXJWV0xIckVlU0JTQVNhdE43SW1QTXV3M2kvRXBjZjZTS2xrelhYazlUbTcz?=
 =?utf-8?B?TXZOUWtKS2lMMjgyNjU1REEyVzcxNkhPcDVpdlFNZDZJbUlxU2RleEFmeHFS?=
 =?utf-8?B?SWNlT0VHV25STXNkRkN4WjNYVWRwVmpZYlN5NEhYZG9MZ2RXK0hzUGZ3eElN?=
 =?utf-8?B?K0J1SkdYWGR3YW5xSGYwOGR4QlY4Ui9NeTd6UjJZWU8ySWJkUVNMSjJpU2dZ?=
 =?utf-8?B?WDRyZ1lsdWZ1T0l1cFU5eVVYYWZuMEw1aDdzR2VBM1BPa0ZnNjlEUFFNdjNX?=
 =?utf-8?B?QWlPS2ZIOWxucmloVnBCT3dHN24vZVZBLytBUmFVV0lHM3ZaZGdDTXE3a29Z?=
 =?utf-8?B?Qmk1T0JoZW1hMlgrNDBMdGRlYlNzaTY1ZDdWZHlwZXN6VUtLYmpjL2FiQnJa?=
 =?utf-8?B?dHlHS3NBYllCcG1ZWGVsMDBiSkpmZGJ6QTdCZjl0VkdrellOcTVhV25PeHNM?=
 =?utf-8?B?eThuZ2FUY3pxZjVHV0dMWkF0SnQvVHR2OVk0dmQ5M0RObStRaDFwOXF4Y3FJ?=
 =?utf-8?B?M21JVWJvYjRyVEFIQ3NpMVlZMHJ5NVZrejdweWppdllucUtVcHprekRSZXRL?=
 =?utf-8?B?WE4xQU5ZdXgzRWljckQ2RUlQeVNCSEZRNkQ0WGZYQ29VWTg4OXlFRVhMaW96?=
 =?utf-8?B?TlFpczh6REMxVnpTanBUOVlkM1RoYnQ0QnppK0R2eVE4NDg1aHdoR0xsNmVP?=
 =?utf-8?B?NmJRSUxVMFVxYjNzMWFlRGxjMkdjMW5BVjdTTFd2S211VU1WSGd5b2lKbXFI?=
 =?utf-8?B?Wmx5cFloY3FYSFFjeEIySGZ2YXMrQWQ0Q1g0SmxmQjBmM1ZRcitFSS9xOTVC?=
 =?utf-8?B?R2FGZXg4QjRxSFppK21aV2lrWXVFT1FldUhxK0pjSzJ0Wk5sWERCZlZrVXc4?=
 =?utf-8?B?WlZKQW44ZHlOTm9mMktNaFk2bTgxUDZWYlN0eDRTMXUzeFYrbmNDNnBiWlFk?=
 =?utf-8?B?L0QyeDN3ZmtJQzN1SC9DOVBMNDlIYkw0bC90aFpRbkdJNWh5MS92ZFZIaHFs?=
 =?utf-8?B?Qk5FU0xCSFVLbDV0Qk1ueTlKNkx0elZhenRCRUpWNWNwNURDQVNlYnRPOTli?=
 =?utf-8?B?dXNWVzRYR1VNYkhKYk02UHlrV1RiY2VkcGkveTFBSUVFcWxtZUR5ck1Rbm13?=
 =?utf-8?B?WHNTc2xuakNuQjc1RmdvMEM3SkxxdmdNSVZ2M0E4Um9qQlphaEZMRVE2OC9B?=
 =?utf-8?B?WlVCSVh6NjZnS2NXdUxhUXZmbXlzOWhyYkJwY1lnYnlVV2I5VkhOYjhFOXJr?=
 =?utf-8?B?NWZIeWgyWTNXdlpvSHpkUStydjMvVXFpNUtzVm04ZVJ2YmpCTTVodGN2cjlV?=
 =?utf-8?B?clRtOHlqTWJQbFBUTkNEczNoNTN4ZnVvN0hoTDNmUHozZ0xYR3hYeU5QOE4x?=
 =?utf-8?B?QStWdjh0SUdFR3lQQnRncG5VZXdJN1NjWXFrTkFZaFdMblpxK3BsZXd0SGJt?=
 =?utf-8?B?V09LaHI1ZW53WWMvUk1ET0R5bTh0clJkUHJMaENEdzIrc0huR05pR0E4SkI5?=
 =?utf-8?Q?2LwPobvRKdb+clE0f043tGQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35AEE41DC3FFF247A80D911E28B99F62@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfe0259-125b-48bb-10b5-08d9f816cb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 04:25:03.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXphWdymXQGAJMYlN1WOtF7kd4YLTefAJcxOxmQDqVGa+j4DVUKqVvXLcb0vqk4ZpCH4hU3piRJx7b6XWmIruA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTI1IGF0IDE0OjE3ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IEZyaSwgMjUgRmViIDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBUaHUsIDIw
MjItMDItMjQgYXQgMTI6MzEgLTA1MDAsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4g
PiANCj4gPiA+ICJUaGUgWEFycmF5IGltcGxlbWVudGF0aW9uIGlzIGVmZmljaWVudCB3aGVuIHRo
ZSBpbmRpY2VzIHVzZWQgYXJlDQo+ID4gPiBkZW5zZWx5DQo+ID4gPiBjbHVzdGVyZWQ7IGhhc2hp
bmcgdGhlIG9iamVjdCBhbmQgdXNpbmcgdGhlIGhhc2ggYXMgdGhlIGluZGV4DQo+ID4gPiB3aWxs
DQo+ID4gPiBub3QNCj4gPiA+IHBlcmZvcm0gd2VsbC4iDQo+ID4gPiANCj4gPiA+IEhvd2V2ZXIs
IHRoZSAibm90IHBlcmZvcm0gd2VsbCIgbWF5IGJlIG9yZGVycyBvZiBtYWduaXR1ZGUNCj4gPiA+
IHNtYWxsZXINCj4gPiA+IHRoYW4NCj4gPiA+IGFudGhpbmcgbGlrZSBSUEMuwqAgRG8geW91IGhh
dmUgY29uY2VybnMgYWJvdXQgdGhpcz8NCj4gPiANCj4gPiBXaGF0IGlzIHRoZSBkaWZmZXJlbmNl
IGJldHdlZW4gdGhpcyB3b3JrbG9hZCBhbmQgYSByYW5kb20gYWNjZXNzDQo+ID4gZGF0YWJhc2Ug
d29ya2xvYWQ/DQo+IA0KPiBQcm9iYWJseSB0aGUgcmFuZ2Ugb2YgZXhwZWN0ZWQgYWRkcmVzc2Vz
Lg0KPiBJZiBJIHVuZGVyc3RhbmQgdGhlIHByb3Bvc2FsIGNvcnJlY3RseSwgdGhlIHBhZ2UgYWRk
cmVzc2VzIGluIHRoaXMNCj4gd29ya2xvYWQgY291bGQgYmUgYW55IDY0Yml0IG51bWJlci4NCj4g
Rm9yIGEgbGFyZ2UgZGF0YWJhc2UsIGl0IHdvdWxkIGJlIGF0IG1vc3QgNTIgYml0cyAoYXNzdW1p
bmcgNjRiaXRzDQo+IHdvcnRoDQo+IG9mIGJ5dGVzKSwgYW5kIHZlcnkgbGlrZWx5IHN1YnN0YW50
aWFsbHkgc21hbGxlciAtIG1heWJlIDQwIGJpdHMgZm9yDQo+IGENCj4gcmVhbGx5IHJlYWxseSBi
aWcgZGF0YWJhc2UuDQo+IA0KPiA+IA0KPiA+IElmIHRoZSBYQXJyYXkgaXMgaW5jYXBhYmxlIG9m
IGRlYWxpbmcgd2l0aCByYW5kb20gYWNjZXNzLCB0aGVuIHdlDQo+ID4gc2hvdWxkIG5ldmVyIGhh
dmUgY2hvc2VuIGl0IGZvciB0aGUgcGFnZSBjYWNoZS4gSSdtIHRoZXJlZm9yZQ0KPiA+IGFzc3Vt
aW5nDQo+ID4gdGhhdCBlaXRoZXIgdGhlIGFib3ZlIGNvbW1lbnQgaXMgcmVmZXJyaW5nIHRvIG1p
Y3JvLW9wdGltaXNhdGlvbnMNCj4gPiB0aGF0DQo+ID4gZG9uJ3QgbWF0dGVyIG11Y2ggd2l0aCB0
aGVzZSB3b3JrbG9hZHMsIG9yIGVsc2UgdGhhdCB0aGUgcGxhbiBpcyB0bw0KPiA+IHJlcGxhY2Ug
dGhlIFhBcnJheSB3aXRoIHNvbWV0aGluZyBtb3JlIGFwcHJvcHJpYXRlIGZvciBhIHBhZ2UgY2Fj
aGUNCj4gPiB3b3JrbG9hZC4NCj4gDQo+IEkgaGF2ZW4ndCBsb29rZWQgYXQgdGhlIGNvZGUgcmVj
ZW50bHkgc28gdGhpcyBtaWdodCBub3QgYmUgMTAwJQ0KPiBhY2N1cmF0ZSwgYnV0IFhBcnJheSBn
ZW5lcmFsbHkgYXNzdW1lcyB0aGF0IHBhZ2VzIGFyZSBvZnRlbiBhZGphY2VudC4NCj4gVGhleSBk
b24ndCBoYXZlIHRvIGJlLCBidXQgdGhlcmUgaXMgYSBjb3N0Lg0KPiBJdCB1c2VzIGEgbXVsdGkt
bGV2ZWwgYXJyYXkgd2l0aCA5IGJpdHMgcGVyIGxldmVsLsKgIEF0IGVhY2ggbGV2ZWwNCj4gdGhl
cmUNCj4gYXJlIGEgd2hvbGUgbnVtYmVyIG9mIHBhZ2VzIGZvciBpbmRleGVzIHRvIHRoZSBuZXh0
IGxldmVsLg0KPiANCj4gSWYgdGhlcmUgYXJlIHR3byBlbnRyaWVzLCB0aGF0IGFyZSAyXjQ1IHNl
cGFyYXRlLCB0aGF0IGlzIDUgbGV2ZWxzIG9mDQo+IGluZGV4aW5nIHRoYXQgY2Fubm90IGJlIHNo
YXJlZC7CoCBTbyB0aGUgcGF0aCB0byBvbmUgZW50cnkgaXMgNSBwYWdlcywNCj4gZWFjaCBvZiB3
aGljaCBjb250YWlucyBhIHNpbmdsZSBwb2ludGVyLsKgIFRoZSBwYXRoIHRvIHRoZSBvdGhlciBl
bnRyeQ0KPiBpcw0KPiBhIHNlcGFyYXRlIHNldCBvZiA1IHBhZ2VzLg0KPiANCj4gU28gd29yc3Qg
Y2FzZSwgdGhlIGluZGV4IHdvdWxkIGJlIGFib3V0IDY0Lzkgb3IgNyB0aW1lcyB0aGUgc2l6ZSBv
Zg0KPiB0aGUNCj4gZGF0YS7CoCBBcyB0aGUgbnVtYmVyIG9mIGRhdGEgcGFnZXMgaW5jcmVhc2Vz
LCB0aGlzIHdvdWxkIHNocmluaw0KPiBzbGlnaHRseSwgYnV0IEkgc3VzcGVjdCB5b3Ugd291bGRu
J3QgZ2V0IGJlbG93IGEgZmFjdG9yIG9mIDMgYmVmb3JlDQo+IHlvdQ0KPiBmaWxsIHVwIGFsbCBv
ZiB5b3VyIG1lbW9yeS4NCj4gDQoNCg0KSWYgdGhlIHByb2JsZW0gaXMganVzdCB0aGUgcmFuZ2Us
IHRoZW4gdGhhdCBpcyB0cml2aWFsIHRvIGZpeDogd2UgY2FuDQpqdXN0IHVzZSB4eGhhc2gzMigp
LCBhbmQgdGFrZSB0aGUgaGl0IG9mIG1vcmUgY29sbGlzaW9ucy4gSG93ZXZlciBpZg0KdGhlIHBy
b2JsZW0gaXMgdGhlIGFjY2VzcyBwYXR0ZXJuLCB0aGVuIEkgaGF2ZSBzZXJpb3VzIHF1ZXN0aW9u
cyBhYm91dA0KdGhlIGNob2ljZSBvZiBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIHBhZ2UgY2FjaGUu
IElmIHRoZSBjYWNoZSBjYW4ndA0Kc3VwcG9ydCBmaWxlIHJhbmRvbSBhY2Nlc3MsIHRoZW4gd2Un
cmUgYmFya2luZyB1cCB0aGUgd3JvbmcgdHJlZSBvbiB0aGUNCndyb25nIGNvbnRpbmVudC4NCg0K
RWl0aGVyIHdheSwgSSBzZWUgYXZvaWRpbmcgbGluZWFyIHNlYXJjaGVzIGZvciBjb29raWVzIGFz
IGEgYmVuZWZpdA0KdGhhdCBpcyB3b3J0aCBwdXJzdWluZy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
