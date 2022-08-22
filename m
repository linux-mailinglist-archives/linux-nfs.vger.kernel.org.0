Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B164459C202
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Aug 2022 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiHVPBo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Aug 2022 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiHVPBX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Aug 2022 11:01:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2134.outbound.protection.outlook.com [40.107.93.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3152872D
        for <linux-nfs@vger.kernel.org>; Mon, 22 Aug 2022 08:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTVmWSdZpWWB1YeuUu1F1Q1LSTrYIvmEXFiAhcR/mV1dxj8Lsl7STuGhclLR3VJamt5ftyV9YTV4+iCFcgaOp5toyUDIU+dkKtmmT6JJXTeE/o7TuVoWT81Kvh63SkZjPWHE4N7Rlb7OUeXzUacVLvmRYr1/a5DPUJaknZCVQUmaTHt9M1MXq6f/dqzK3vRrLmQms5VVsCiIWyKJob6EjiAqMFykedhlA+f7fx+fcR8U24D4NT2po1PRXDR9SRKAodNXLqfWyTnx7pjzN6DQxpKXzTHo3J2LA85LrY0BCILqgofKCJAAxHMF4I5hPik5NFf/D0GrkRCo8sm6Gme14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa501R0WztVYu74vWwSmRcs02jvg6JYxJHBuJHsto6o=;
 b=nUkUZWKJV3IH2Ebugs0Nn8GLNtqpXX/G/bcdo71PqnyETTO5gxruMYZqWsj2PrChuWxQlLnNOKUcr5mdSDNb8Vzy+cs/JoZ8yu35WINbBEjBKkRWhQP5soLW0Wz8xhrOsHWtOrPWmudUHq5n//mqI7JqDUbAHVIYwLCvo/z8VgRtTDYCm2XczgHXg7Nz6uWqUn7/3M3mAQpCUkfq4e8ST+csybezylq4YhYmZNVMJn/8PFgSamg1ScUXLMZoeJN4mhJT1WKkVqwBK9XP8aE/vkDGL25TZjvkNmDTcKm9L6qbjVwEmNKn6QM7mf5rv5xknUbu/epAe2O213mDFKGXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa501R0WztVYu74vWwSmRcs02jvg6JYxJHBuJHsto6o=;
 b=AGfyqEsTQS4eX9OoUVtVgYVGKlLplKE2dnznTKw6ssoZQ4f1r9Obolkw5+5aLYOUdjltmx+EwUKfbKzCTPil1xkQ71fiNZ1pjI9wfr4Eqz/lXUvEpt4VMH+HNogTTJg4gZqbm8hhlfvXHZIlT+I9XO6d7jXkUNpcbp67m8ET58Y=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB5933.namprd13.prod.outlook.com (2603:10b6:510:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 22 Aug
 2022 15:01:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.014; Mon, 22 Aug 2022
 15:01:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "igor@gooddata.com" <igor@gooddata.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Regression: deadlock in io_schedule / nfs_writepage_locked
Thread-Topic: Regression: deadlock in io_schedule / nfs_writepage_locked
Thread-Index: AQHYtf93d5SRXUGPYkyFYNes7xsaQa2686EAgAALV4CAAAUVgA==
Date:   Mon, 22 Aug 2022 15:01:18 +0000
Message-ID: <6beb46a169e675c560871ca54748481522ecbaec.camel@hammerspace.com>
References: <CA+9S74iBrObUnaSpSdqXu0_GosDdE1dmSbmgxfmxEK2mhDaNjg@mail.gmail.com>
         <28bbec15d3a631e0a9047f4a5895bd42db364dba.camel@hammerspace.com>
         <CA+9S74jaMmn69WLsOZG8QYT2kZQDn9SGszNr-ozxRPubPuV5wQ@mail.gmail.com>
In-Reply-To: <CA+9S74jaMmn69WLsOZG8QYT2kZQDn9SGszNr-ozxRPubPuV5wQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69408178-9135-47f5-4952-08da844f2acc
x-ms-traffictypediagnostic: PH7PR13MB5933:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvMcrF1yusL9FpPUIxHzurORSqqHGRWsVEPUukHTy/rAZef0z1ZWtxXqKLyIPalljZt+DaA+MCg7OP//tFoCCXXpZzJOQU4YA45IGIFrB0RH6du7o1Ie+uy5RsvH+5xfTDiWoUA98A1n3qrLK/2dWqdlHbtWh7ispJ8ClRW7BauOrdLL7b8sisC/SNBBt4/tZ/3oSQo0bhgUsFAXQSb5SmJy2ihwC3tTGJjhCamYMCAcNRDdklGAVKKvJn0AuVWPokohfStzg7d2B4hn7UftmXPDI0QeawQgp4mdsYWikpLBPrxYU5Ur9vITE77ts5jvqd3r+RTyFHuaCWyQFLR0SLaX9cULLf9hQ+400T/cqaE0vKhKkYLI7iyvM3FaTwKSGhHN9DIE0NIqJinq8Poc5aoDCf+Fsu6zR5sJvICErCjHii+onRSLKcHpXLmK0Jwapt48nHstcdaWdTZubkdVJ9GYNJor9/+gz3BaJ9UK+Qfg7peLzPWLUClZ/PODgqdsTN0I/gnBTISsBy/R2R7nGGagesSpmE/RO5tmj5FDol5retANDSJ/zkK56PIPqVFPd7oCMu7wquIiwzBx/a+byKuBepttPzMN85pmsTci3xAXTfJsf+dh/Obkl1YuOmrphBUQLiGN8Z6bmiaxd7Uu//47lgpOfOqyefO/FuRBfjVhIf9/MLRmMh1SbgutU8JlUMsLBcaUMV++A7ZFICmQLnQgPmi03/9vn7wflNdOBWj+8LIuVNCxc14uVzGdlzZInyDsd7t0KIniTx9kYjItONRT/8yGHpr43YsWvnYn0jI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(346002)(39830400003)(366004)(396003)(71200400001)(41300700001)(8676002)(54906003)(478600001)(6506007)(6512007)(26005)(966005)(6486002)(36756003)(83380400001)(2616005)(186003)(316002)(6916009)(38100700002)(122000001)(76116006)(5660300002)(66446008)(66476007)(66946007)(66556008)(53546011)(2906002)(38070700005)(86362001)(8936002)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUVlenhRV3NBQnVCWFZFSEYzVVJKWFc2OVhiMVNFOU50Q2VOQVVIOXJUdHFo?=
 =?utf-8?B?SHhEWjdqcmsvYkQrelRiYUlrMmtoYlUxdHpLR25iNjNOajJ2enArSVFXSVY0?=
 =?utf-8?B?NEF5a2ZsalhqUHhqang0eU81bVROMG95WTh3QTQ5b21RY2ZsTml3SitXczR6?=
 =?utf-8?B?czY1VnV5RU5iblA5dVBxcGZGOTdTUWdwN3F1N1M2WHQrK3JYL1pGcDJ5ZGNq?=
 =?utf-8?B?U2tMQ3p5eGluUVFxWUx1YUEwWUhSbjJlQW9peDJvQXp6cFo4aG9VS3JSMEky?=
 =?utf-8?B?NTdjUDNMODZPeFlKckNtbkJ3Q2svc3NUOTlYVXZkS09NZ3U4ZUkraDFlWGd5?=
 =?utf-8?B?SkJXQUMydWRJRDdyeTZ1eG92MGQxb2pGakV1c1MyeE95RVh4TmoySW5zY25y?=
 =?utf-8?B?cm80aVd0c21yTFB3TTVPNVVmQUFDYjk3cTk2TkY4ajJzNUY0Q3hUMEkxYlVE?=
 =?utf-8?B?YmwxNVRyYlFXV2xuNkphRmR3MjU1RXZ0bW1aclh4V1pQeDlLQy9WU1I4Y2ZO?=
 =?utf-8?B?SDBsMlRHNHpwTW1KZWUzQVk5T1BDdi9RSkFEY09POEU5QmdtekpJU0taWms0?=
 =?utf-8?B?YmdJZFJIbHVudFFWQUlLbmpnaHdiclROeXVkc2I2Yk03M2RwaGI2aFZheWd0?=
 =?utf-8?B?M0Mxa0YvTkN2Z3JLd0F0a3RqNFluWlVxNUpFSHZraEhqVnhKOVpUenRESVpr?=
 =?utf-8?B?cm5DNFFreU9KMTQ5bWZGVUpzdG1LZ1g3TXYwUkRUdTdPTlZoL2JxR0lOaFBk?=
 =?utf-8?B?SHpLbjUxUWJxU2FlSkx6RStCUzhWNm1GZndIOWpDSjUzdkpoWk0rZjhzZTBJ?=
 =?utf-8?B?TGs5M1JoQjE5NFJpOEplS2J2a3FjRFlOZnFoTUhUZ2dPd3hNcS80dHZzRFJa?=
 =?utf-8?B?K2trSXFRdmZJbXk5bGRIVDVYdlRFNnZFUG5qRStnYXVFSUJ5d2FidUM2ejVF?=
 =?utf-8?B?ZmxTQ1g0N0hSdGN3SjdhUm9KMG9qN2hQT0UrOGlVZnBCN2JHOTlKS0ZjbFZE?=
 =?utf-8?B?RzRLdUw5SHJNMnE2OTVwa0ZVL2J5SWdtbnJYeXA5UkpkdlE2ZmZaaGMrVTJF?=
 =?utf-8?B?b09uWFEzdHNnSVhKVVVVOUdVdVNvZmpXMXpIMnh0NHV5ZlBrU0NIOTJUTGYx?=
 =?utf-8?B?ZG5zWmYwVG54YUc5UDJMRHhFcm0zODQ1UUM0ZXFtSUhyb08xMDEvRVF5Sk1I?=
 =?utf-8?B?MWFQa0p0am45dTNwSUVxYUk2WlVGU2UwWVpCVkdLWTZQcHRSamo3b2NNWlY1?=
 =?utf-8?B?MSt6c0Nvb1U2MGtIQm9UOGo2RTR5VVJFVXh5ZDZHNlQ4bU1UVVNKNlo0Q0hI?=
 =?utf-8?B?VjhteGZkaVUwdVJjdXN6cWVobkVEb0t5WFMyOVBMd3laVGQ2d01teXRNTXhQ?=
 =?utf-8?B?RkNhUHB3L2dNOEhUenVoVEhRam1MelR4MkxsM1FkSHREMFRwbGY3TjhSM1I2?=
 =?utf-8?B?dlpENWI5OGlCYVJJVlRnQ1hsWVNBcldsaklodWdvcm9MM0dnelY0OUZHUHVo?=
 =?utf-8?B?WUEzRG52NDJwWGxrS0hlQk1tUDFyRDJwL0dnVXFJcVpVM1pVYi8zem1waVh6?=
 =?utf-8?B?U3hjc3JGY0pZK292bG45a0ZwYjFVaFJ0MThmdnUyK3BUTG0rRjRXTGVnVkY2?=
 =?utf-8?B?THFxYmE4Wmg1WGkxQklKOVppM0Uwd1k1U3h0WlVQTjJBbENUSlhiN2ZDSHho?=
 =?utf-8?B?WDlnQTJMRmdhMG5mTjJ4N2VZNXBubDVOYTQ0dHptZmNlVGNwbGQyTEFteU13?=
 =?utf-8?B?MEw3eS9ETUU0T0JINlpiK2pNOUtYQ3g0S01lVlFaMVJnSTJuUFBvR1FSb1dY?=
 =?utf-8?B?WmVURHJwT0JNZno4cDluZU9Fa2s5V1g2VlNEelVXMTg5bTZNd0dkYzFQeWR5?=
 =?utf-8?B?OU1hTVNzczd0OGRsQXBMNGZYeCttb3NNb0E1N1NUM1ZzdVlJY3JjL0lweW5i?=
 =?utf-8?B?VXhsMW1HTlpQNFRpOTIrd1dBK0tCRGZjWVR0aEdJaUQ5N0R1dXBmYTVXT2Jl?=
 =?utf-8?B?WFQ2K0kxT1k4eEJsdERnM0Rac0FUSlNOVm1WZWNpTjI3Rm13U1dTTUNQN0VT?=
 =?utf-8?B?M3k5dGtEa2tnQXJDZ2p1YUNuV243WVdyZjFTWU14dFl4ZVREdU9Kc1UxRVdG?=
 =?utf-8?B?a3JsTFI1L3JmaElabnZHRXdkNE9UaVlESTFYWGdRa0RkZU9FZUw2UmQwVEd3?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C87C4A41F3FE9D47A351B1F353376CA3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69408178-9135-47f5-4952-08da844f2acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:01:18.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTB58/ZHN1yXDRx2nM6t4L/qldDbO0b23dmUXUUBanfrQ4Idu4YoTnibz3HF5XF1bd2Zu6OZhAY9tA8b+TpoJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTIyIGF0IDE2OjQzICswMjAwLCBJZ29yIFJhaXRzIHdyb3RlOg0KPiBb
WW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGlnb3JAZ29vZGRhdGEuY29tLiBMZWFybiB3
aHkgdGhpcyBpcw0KPiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRl
cklkZW50aWZpY2F0aW9uwqBdDQo+IA0KPiBIZWxsbyBUcm9uZCwNCj4gDQo+IE9uIE1vbiwgQXVn
IDIyLCAyMDIyIGF0IDQ6MDIgUE0gVHJvbmQgTXlrbGVidXN0DQo+IDx0cm9uZG15QGhhbW1lcnNw
YWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9uLCAyMDIyLTA4LTIyIGF0IDEwOjE2ICsw
MjAwLCBJZ29yIFJhaXRzIHdyb3RlOg0KPiA+ID4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwg
ZnJvbSBpZ29yQGdvb2RkYXRhLmNvbS4gTGVhcm4gd2h5IHRoaXMNCj4gPiA+IGlzDQo+ID4gPiBp
bXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9u
wqBdDQo+ID4gPiANCj4gPiA+IEhlbGxvIGV2ZXJ5b25lLA0KPiA+ID4gDQo+ID4gPiBIb3BlZnVs
bHkgSSdtIHNlbmRpbmcgdGhpcyB0byB0aGUgcmlnaHQgcGxhY2XigKYNCj4gPiA+IFdlIHJlY2Vu
dGx5IHN0YXJ0ZWQgdG8gc2VlIHRoZSBmb2xsb3dpbmcgc3RhY2t0cmFjZSBxdWl0ZSBvZnRlbg0K
PiA+ID4gb24NCj4gPiA+IG91cg0KPiA+ID4gVk1zIHRoYXQgYXJlIHVzaW5nIE5GUyBleHRlbnNp
dmVseSAoSSB0aGluayBhZnRlciB1cGdyYWRpbmcgdG8NCj4gPiA+IDUuMTguMTErLCBidXQgbm90
IHN1cmUgd2hlbiBleGFjdGx5LiBGb3Igc3VyZSBpdCBoYXBwZW5zIG9uDQo+ID4gPiA1LjE4LjE1
KToNCj4gPiA+IA0KPiA+ID4gSU5GTzogdGFzayBrd29ya2VyL3UzNjoxMDozNzc2OTEgYmxvY2tl
ZCBmb3IgbW9yZSB0aGFuIDEyMg0KPiA+ID4gc2Vjb25kcy4NCj4gPiA+IMKgwqDCoMKgIFRhaW50
ZWQ6IEfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEXCoMKgwqDCoCA1LjE4LjE1LTEuZ2RjLmVsOC54
ODZfNjQgIzENCj4gPiA+ICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdfdGFza190aW1l
b3V0X3NlY3MiIGRpc2FibGVzIHRoaXMNCj4gPiA+IG1lc3NhZ2UuDQo+ID4gPiB0YXNrOmt3b3Jr
ZXIvdTM2OjEwwqAgc3RhdGU6RCBzdGFjazrCoMKgwqAgMCBwaWQ6Mzc3NjkxIHBwaWQ6wqDCoMKg
wqAgMg0KPiA+ID4gZmxhZ3M6MHgwMDAwNDAwMA0KPiA+ID4gV29ya3F1ZXVlOiB3cml0ZWJhY2sg
d2Jfd29ya2ZuIChmbHVzaC0wOjMwOCkNCj4gPiA+IENhbGwgVHJhY2U6DQo+ID4gPiA8VEFTSz4N
Cj4gPiA+IF9fc2NoZWR1bGUrMHgzOGMvMHg3ZDANCj4gPiA+IHNjaGVkdWxlKzB4NDEvMHhiMA0K
PiA+ID4gaW9fc2NoZWR1bGUrMHgxMi8weDQwDQo+ID4gPiBfX2ZvbGlvX2xvY2srMHgxMTAvMHgy
NjANCj4gPiA+ID8gZmlsZW1hcF9hbGxvY19mb2xpbysweDkwLzB4OTANCj4gPiA+IHdyaXRlX2Nh
Y2hlX3BhZ2VzKzB4MWUzLzB4NGQwDQo+ID4gPiA/IG5mc193cml0ZXBhZ2VfbG9ja2VkKzB4MWQw
LzB4MWQwIFtuZnNdDQo+ID4gPiBuZnNfd3JpdGVwYWdlcysweGUxLzB4MjAwIFtuZnNdDQo+ID4g
PiBkb193cml0ZXBhZ2VzKzB4ZDIvMHgxYjANCj4gPiA+ID8gY2hlY2tfcHJlZW1wdF9jdXJyKzB4
NDcvMHg3MA0KPiA+ID4gPyB0dHd1X2RvX3dha2V1cCsweDE3LzB4MTgwDQo+ID4gPiBfX3dyaXRl
YmFja19zaW5nbGVfaW5vZGUrMHg0MS8weDM2MA0KPiA+ID4gd3JpdGViYWNrX3NiX2lub2Rlcysw
eDFmMC8weDQ2MA0KPiA+ID4gX193cml0ZWJhY2tfaW5vZGVzX3diKzB4NWYvMHhkMA0KPiA+ID4g
d2Jfd3JpdGViYWNrKzB4MjM1LzB4MmQwDQo+ID4gPiB3Yl93b3JrZm4rMHgzNDgvMHg0YTANCj4g
PiA+ID8gcHV0X3ByZXZfdGFza19mYWlyKzB4MWIvMHgzMA0KPiA+ID4gPyBwaWNrX25leHRfdGFz
aysweDg0LzB4OTQwDQo+ID4gPiA/IF9fdXBkYXRlX2lkbGVfY29yZSsweDFiLzB4YjANCj4gPiA+
IHByb2Nlc3Nfb25lX3dvcmsrMHgxYzUvMHgzOTANCj4gPiA+IHdvcmtlcl90aHJlYWQrMHgzMC8w
eDM2MA0KPiA+ID4gPyBwcm9jZXNzX29uZV93b3JrKzB4MzkwLzB4MzkwDQo+ID4gPiBrdGhyZWFk
KzB4ZDcvMHgxMDANCj4gPiA+ID8ga3RocmVhZF9jb21wbGV0ZV9hbmRfZXhpdCsweDIwLzB4MjAN
Cj4gPiA+IHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwDQo+ID4gPiA8L1RBU0s+DQo+ID4gPiANCj4g
PiA+IEkgc2VlIHRoYXQgc29tZXRoaW5nIHZlcnkgc2ltaWxhciB3YXMgZml4ZWQgaW4gYnRyZnMN
Cj4gPiA+ICgNCj4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29tbWkNCj4gPiA+IHQvP2g9bGludXgtNS4xOC55Jmlk
PTk1MzVlYzM3MWQ3NDFmYTAzN2UzN2VkZGMwYTViMjViYTgyZDAwMjcpDQo+ID4gPiBidXQgSSBj
b3VsZCBub3QgZmluZCBhbnl0aGluZyBzaW1pbGFyIGZvciBORlMuDQo+ID4gPiANCj4gPiA+IERv
IHlvdSBoYXBwZW4gdG8ga25vdyBpZiB0aGlzIGlzIGFscmVhZHkgZml4ZWQ/IElmIHNvLCB3b3Vs
ZCB5b3UNCj4gPiA+IG1pbmQNCj4gPiA+IHNoYXJpbmcgc29tZSBjb21taXRzPyBJZiBub3QsIGNv
dWxkIHlvdSBoZWxwIGdldHRpbmcgdGhpcw0KPiA+ID4gYWRkcmVzc2VkPw0KPiA+ID4gDQo+ID4g
DQo+ID4gVGhlIHN0YWNrIHRyYWNlIHlvdSBzaG93IGFib3ZlIGlzbid0IHBhcnRpY3VsYXJseSBo
ZWxwZnVsIGZvcg0KPiA+IGRpYWdub3Npbmcgd2hhdCB0aGUgcHJvYmxlbSBpcy4NCj4gPiANCj4g
PiBBbGwgaXQgaXMgc2F5aW5nIGlzIHRoYXQgJ3RocmVhZCBBJyBpcyB3YWl0aW5nIHRvIHRha2Ug
YSBwYWdlIGxvY2sNCj4gPiB0aGF0DQo+ID4gaXMgYmVpbmcgaGVsZCBieSBhIGRpZmZlcmVudCAn
dGhyZWFkIEInLiBXaXRob3V0IGluZm9ybWF0aW9uIG9uDQo+ID4gd2hhdA0KPiA+ICd0aHJlYWQg
QicgaXMgZG9pbmcsIGFuZCB3aHkgaXQgaXNuJ3QgcmVsZWFzaW5nIHRoZSBsb2NrLCB0aGVyZSBp
cw0KPiA+IG5vdGhpbmcgd2UgY2FuIGNvbmNsdWRlLg0KPiANCj4gRG8geW91IGhhdmUgc29tZSBo
aW50IGhvdyB0byBkZWJ1ZyB0aGlzIGlzc3VlIGZ1cnRoZXIgKHdoZW4gaXQNCj4gaGFwcGVucw0K
PiBhZ2Fpbik/IFdvdWxkIGB2aXJzaCBkdW1wYCB0byBnZXQgYSBtZW1vcnkgZHVtcCBhbmQgdGhl
biBzb21lIGtpbmQgb2YNCj4gImJ0IGFsbCIgdmlhIGNyYXNoIGhlbHAgdG8gZ2V0IG1vcmUgaW5m
b3JtYXRpb24/DQo+IE9yIHNvbWV0aGluZyBlbHNlPw0KPiANCj4gVGhhbmtzIGluIGFkdmFuY2Uh
DQo+IC0tDQo+IElnb3IgUmFpdHMNCg0KUGxlYXNlIHRyeSBydW5uaW5nIHRoZSBmb2xsb3dpbmcg
dHdvIGxpbmVzIG9mICdiYXNoJyBzY3JpcHQgYXMgcm9vdDoNCg0KKGZvciB0dCBpbiAkKGdyZXAg
LWwgJ25mc1teZF0nIC9wcm9jLyovc3RhY2spOyBkbyBlY2hvICIke3R0fToiOyBjYXQgJHt0dH07
IGVjaG87IGRvbmUpID4vdG1wL25mc190aHJlYWRzLnR4dA0KDQpjYXQgL3N5cy9rZXJuZWwvZGVi
dWcvc3VucnBjL3JwY19jbG50LyovdGFza3MgPiAvdG1wL3JwY190YXNrcy50eHQNCg0KYW5kIHRo
ZW4gc2VuZCB1cyB0aGUgb3V0cHV0IGZyb20gdGhlIHR3byBmaWxlcyAvdG1wL25mc190aHJlYWRz
LnR4dCBhbmQNCi90bXAvcnBjX3Rhc2tzLnR4dC4NCg0KVGhlIGZpbGUgbmZzX3RocmVhZHMudHh0
IGdpdmVzIHVzIGEgZnVsbCBzZXQgb2Ygc3RhY2sgdHJhY2VzIGZyb20gYWxsDQpwcm9jZXNzZXMg
dGhhdCBhcmUgY3VycmVudGx5IGluIHRoZSBORlMgY2xpZW50IGNvZGUuIFNvIGl0IHNob3VsZA0K
Y29udGFpbiBib3RoIHRoZSBzdGFjayB0cmFjZSBmcm9tIHlvdXIgJ3RocmVhZCBBJyBhYm92ZSwg
YW5kIHRoZSB0cmFjZXMNCmZyb20gYWxsIGNhbmRpZGF0ZXMgZm9yIHRoZSAndGhyZWFkIEInIHBy
b2Nlc3MgdGhhdCBpcyBjYXVzaW5nIHRoZQ0KYmxvY2thZ2UuDQpUaGUgZmlsZSBycGNfdGFza3Mu
dHh0IGdpdmVzIHVzIHRoZSBzdGF0dXMgb2YgYW55IFJQQyBjYWxscyB0aGF0IG1pZ2h0DQpiZSBv
dXRzdGFuZGluZyBhbmQgbWlnaHQgaGVscCBkaWFnbm9zZSBhbnkgaXNzdWVzIHdpdGggdGhlIFRD
UA0KY29ubmVjdGlvbi4NCg0KVGhhdCBzaG91bGQgdGhlcmVmb3JlIGdpdmUgdXMgYSBiZXR0ZXIg
c3RhcnRpbmcgcG9pbnQgZm9yIHJvb3QgY2F1c2luZw0KdGhlIHByb2JsZW0uDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
