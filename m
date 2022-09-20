Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B885C5BD946
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 03:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiITBSt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 21:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiITBSp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 21:18:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2118.outbound.protection.outlook.com [40.107.243.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472A94DB56
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 18:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae385NsXDCRaXj3bu7VtV8Z19U9C+Rb2HBWhSgmnLzF7E9UzCQ7D2mt7r99P1VvQ0rG2VPwYLC/IwjXnR+31HBzApkZ+fGrlmzmhde+nrEal+20+zEhRPen7N6HefKnS7Pbr0Yp2Df3RuP90wZim//HO9HBh8DSi6fk2jxVUcmjhCz5xRJI72h/B51GNzxycAbQ0cLLn1k/m1hswW/FHlSo88joLFBmGM7LWIEIk1IjFJ+IPmGT8ioz37qdn7so3rB3yeLLETMPpRKo/0QlUMn4/uV/26/yos0+41/KkOr6CZWZY6X2ey74E5gAUfLMaI/wT69kKSyvZVvItF9dLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgrpRUvWJ4kjM+5gh8g9zsIvwK6qt+eRWnCIxCG9Pg8=;
 b=IWosX6qLOQ1q5tCxhh1ki0sktCnYVRFTDz1WjeSoVmc/CaJaFY3pbY9084p9iX4TgnX16xz+1wQK0uNeTWfBV3X2ABXvFTyRstvt7BpFdxX/x1AkG0CUkghchWFPOrHKZZwZ/ZpzOOU4ewhQJZWVezMRqRFXTQT46Y/K7/+q/50hGB4vxRI7YA1JQbMmxKIVAR6uDRqYh5OkOTQHRWBpO2hwAdbfGzJErm35ml9GSBpKodyiOFzv7Q4lOzGpWQsZG7P8SwWGgjUS0hwoIMgIly1gMOa8+TGBqgL4UxIST5rBJ8GLwRsgGeN6+dbk6Z8dwUuy5vjqmmcFyDLhECbJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgrpRUvWJ4kjM+5gh8g9zsIvwK6qt+eRWnCIxCG9Pg8=;
 b=BJQKmXOra8TS836NcFC4ldmauhL2GSGGg3tQUMDuxb3q3QHhp036Fxi27cUwZq1bRMuMNLmt1HFJXRrPT1SxulgABcORUxW/W0RICL2buwRCLjOVS5jmzLSrcAzsKOMD+rouRCV6iNfSR6lVB95T0BwOX0mYayd+46lYYdlu2U4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4558.namprd13.prod.outlook.com (2603:10b6:5:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 01:18:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 01:18:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEAgAACsoCAAAKEgIAAAmYAgAAD74CAn5ulgIAADKiAgAAQloCAAAOHAIAAGXEAgABrh4CAJVgPAIAAOmoAgAAs1oA=
Date:   Tue, 20 Sep 2022 01:18:42 +0000
Message-ID: <6be83f0b6b70c594dcb757e8f1060c0f0408b49c.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>   ,
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>        ,
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>       ,
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>        ,
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>       ,
 <165274950799.17247.7605561502483278140@noble.neil.brown.name> ,
 <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>       ,
 <165275056203.17247.1826100963816464474@noble.neil.brown.name> ,
 <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>       ,
 <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>      ,
 <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>       ,
 <54685EB8-7E6D-4EC4-8A9E-2BF55F41DABA@redhat.com>      ,
 <f5a2163d11f73e24c2106d43e72d0400d5a282b6.camel@hammerspace.com>       ,
 <FA952BF7-1638-4BD1-8DA9-683078CFDE8F@redhat.com>      ,
 <361256cf42393e2af9691b40bd51594ce078f968.camel@hammerspace.com>       ,
 <9279E15C-0A9E-4486-BE45-5DA5DF40675D@redhat.com>
         <166362709287.9160.2951057161316110877@noble.neil.brown.name>
In-Reply-To: <166362709287.9160.2951057161316110877@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB4558:EE_
x-ms-office365-filtering-correlation-id: 33d46725-28b0-4232-6f60-08da9aa60ea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wtUlEr/n7WeGyvaQrCJ6ZGitkn6aE++DziTvLgi829z0nEtqq7pHi6WZxjl2Fz7yFI8y2wqU+3f8KY3EjqDGgj8b5qt10vm+vTT4WP+3rPiUBvDHVr3V77X/f7xb59z6zhDAq/+XfFC9nIPLjLVYzaTlEfYTCUHoykInO2vr+ZWDwNANlGxOm2X0vKT0EQWQ4FV9uqDnI9x/u+KGT/70oGXKhcJ+yJxhSeyVVB2U+yA32Cbe3CtBiCu3if3d8NKOyrPeC96+MXLwGdNh/7cPUM9R18sR2JKwCi487WKOLV+PWR8IuZaR4AzoCDL4F52ddPZUd2ebb2zhTCqKbaEienGnl6JpHzLFVOoOn9UishhaBRBlJVSjCaC50vX8LS3f0iAr4ToDS8hYicRfO78J+o3aYLY1qO+6quQ60R2k1h3ung41Yi3ADl5knUyABZAc2e9g36mwwGQVHlTFXjbp1RHEUhThNRd0Co88lWRAMINrHYxTLckMEcfWx3I9MxTV6LN+/RfF6E+500QEthgf7bsMROwX9MPkXKfYfogpEreMvLKKPMPLnxIdjcfREvCQn+X6qKmDi5L+9kSIvDeFsXwTdfEVXigwhK0NB7o++kVIqotVlZc2bNE3lZB3u3T7QZ5CozMRipIImOWoiSAF6qCbS3fuYq4HPJcIkLdL82G3wuxuRvEKhYXLH9513s6wFAdt1XDOPTTYYnh18a9i3oxKVST6bWAeCH91/LlqAEa+Zz0aIGZF6GQkX43hqdQzYmap1NLVvEvuPrKisE8O7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39840400004)(366004)(376002)(346002)(136003)(451199015)(8676002)(38100700002)(6512007)(26005)(53546011)(6506007)(71200400001)(478600001)(6486002)(110136005)(66556008)(38070700005)(122000001)(316002)(54906003)(83380400001)(5660300002)(186003)(2906002)(8936002)(41300700001)(76116006)(66946007)(4326008)(64756008)(66446008)(66476007)(2616005)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2xET0Z6QTJpeFNmdU8wOFhQS3dCYk5pbkpEWWQ2dk5uTnFWMEt5VTJwVUow?=
 =?utf-8?B?bFU4T2JGMXhURmxhaDErNU1aM0xkK3RzdWhUTEpHZXZWSDRQOXBkKzhHZU52?=
 =?utf-8?B?NEJGYjkvcnFYTlllN056REpsNkVHbTJvczFqNlpMTnU3MDhDQkhmaGtuaVZV?=
 =?utf-8?B?ZzV4ODFqY2NORjJLNThOSmRVZUU3VmVZRldLQVZlcm42eGdZSEhvY2lJOHhi?=
 =?utf-8?B?K3o4Tm04MWpydW1IWFY1T01QbXQ0bitLS3YxYlEzT2FxWFVHYzR5bkJaVmVK?=
 =?utf-8?B?MWcwbENyNGc2aTYvUXpNYjUvalB6UEw0aVQzYmpaKzNYc01lVzZLMWJUeUpO?=
 =?utf-8?B?MytyUGtRWExjRmRMWXdkTDRGYmdVSFM5Wk1TZlhUZmFXeWx3aFRLU3BXeWFV?=
 =?utf-8?B?Z2lCQStVTEh1T3hXeVFTZExkT2t3dHVrWXZLZU9XbVFuT1V0UW04dkJ3WGlx?=
 =?utf-8?B?cTBnUzRMWGZsa1JuVkJPdS8xZjNiUUxkVU8yc2RYMkRrbnFCWlIyYXRyYU4r?=
 =?utf-8?B?dXRUMTRxaHU5R0w1anhYbjRXVWNpYXJKS04yRzhVWFVKb083aGQzSEdLNWph?=
 =?utf-8?B?Nll5R040cGxyeHpGSnlJZW9DcDBEYlBHWVpIeE10Z2lhLzU1Y3YwSlR2UXd6?=
 =?utf-8?B?Z1c4dGdmbmxLTDV0eFBmaVk5aTlhdzFkTVFrUHBPMlVyZW1rRFc0T0Q0MG9G?=
 =?utf-8?B?TFQyWm5rQ3JEOXd3c0NJd2ZCTmY3ZFlYVXp6WE41cUM0YjBMdmd2N1pqQXpr?=
 =?utf-8?B?QWpvL0M1eUQyRTRzY2R3U0Fudzc3TUh2ZWdTcndZWGl6dlNSbVMyV29WMG5Z?=
 =?utf-8?B?RGlEK3hHaE4xSUUyTFNSM2xrdHN2Wjc5cTRmdmkxMFUreVprb3JhN3I1dGR2?=
 =?utf-8?B?dHczWkd1OXgvSXVWclVyK1FBK281WkgxcHpPcmc3QkJmbURvYW40bCtmS2g1?=
 =?utf-8?B?eGNxcjhINGJ6Zjd3QVpRTG13NDZYMitaQUsvZ2xaNWppaTI5ZEllbWZ0cStZ?=
 =?utf-8?B?NFp3akJCendpTnFUKzN6YlFnVmFMV2Fwa0t5Ym5XdGVlRmp1b3ArSUphb3py?=
 =?utf-8?B?V25jTXZ3bnBTZFo4WFdNTGNyNXlLYzNzU0UxYm82VmtXeHNlL0RNYXVQOXA2?=
 =?utf-8?B?dFlYMU1PbFgyemhWR1ZacTNmZHRScUtwdXA4aUhXVXNLRGJucGUzek9SSDU4?=
 =?utf-8?B?MmlyR0dYYjZINnFldExNVUlCMkRTMnVkVzU5MmdXMHMzcVFzVFMrWEJwNk5s?=
 =?utf-8?B?UldBQ01Mc2Zqd3g1eU9QNFNhTDNKN2p2M1JjSVNzN1MvdHdDZnlCbUlnYkFp?=
 =?utf-8?B?MDlGL3NLT25MYUtrMkpMWlBVTDFta1FxNXpnY3k2K3VranNMMGdYaUFmaEdZ?=
 =?utf-8?B?U015QjRyeUlQSWhQRko0VFdHMm5LenJrWUhWbGVxUEFPdlZmODB6NGhGUlh4?=
 =?utf-8?B?amsxY2tnVTRybHJPaHg1Mm9WQTFiOWxGZ0Z4WFRudVJQczFVMm9CRktzRFBr?=
 =?utf-8?B?TFRzdCtJUmd2TjZRZjgrVzN4Yzc2Zkw1TW9OTTVWVUd2eG8veFd2cmF5SlBF?=
 =?utf-8?B?N0NuN1F2YTNsVlJFVHpTVnhOR00rbStZVk5PWW9yQVdhQmxyVWF6MHJ0VHZo?=
 =?utf-8?B?eTJWdVYzNVFac1dOMlVLcktWcHc5NkFKZDBBWVE3WVlZWUlKNHk5WEV6UVF6?=
 =?utf-8?B?dUFaZ3hJRExiNmw0MEtQMEVRd1hHK29rNDVXcVFIcnk2NXpKUE1xY3BTQlNK?=
 =?utf-8?B?TjgwaEZlaDIzQ1A5RmFzcDcxRHJDeFlzYS9qRThtNWp6M2FPZTNtQUdadzFv?=
 =?utf-8?B?Tm5zY3dLOEdrTlpKczJSMVQ2S3BEMnZqL2tmd0xWUkM5M1AzSC82S2tPMmVh?=
 =?utf-8?B?Z0VMRkhvZThUT1A0UlNmVGRhajNMZDVqdmEvN1Mzd1ZFVlFGYThTa2Y2dFZl?=
 =?utf-8?B?S2pwbkJnTUl5aDR4MERRSEVrUjVQeUZuYUdVYkdOR2VFd0gzLzBwYW8rV3Aw?=
 =?utf-8?B?RnBlYkFmS0pWVHVrckhXUk1YL2pjME14TW1NUjFKZzZtZjQvdStCNmRIMVZ0?=
 =?utf-8?B?MnNRRnBMY2F2QXMzbXFvaXRCK0xyNkhWaWZhcGpzbkpRVTlvN0Ewdm1mMmxU?=
 =?utf-8?B?Q0V4dnVSMWo4RURnSW1sSzBPZkVLcHRUaVA4eXA1WWRreURxTk5rWUl0NzZ3?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB12D80395613C46B666703B4641168B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4558
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA5LTIwIGF0IDA4OjM4ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMjAgU2VwIDIwMjIsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4gT24gMjYg
QXVnIDIwMjIsIGF0IDIwOjUyLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gDQo+ID4gPiBD
YW4gd2UgcGxlYXNlIHRyeSB0byBzb2x2ZSB0aGUgcmVhbCBwcm9ibGVtIGZpcnN0PyBUaGUgcmVh
bA0KPiA+ID4gcHJvYmxlbSBpcw0KPiA+ID4gbm90IHRoYXQgdXNlciBwZXJtaXNzaW9ucyBjaGFu
Z2UgZXZlcnkgaG91ciBvbiB0aGUgc2VydmVyLg0KPiA+ID4gDQo+ID4gPiBQT1NJWCBub3JtYWxs
eSBvbmx5IGV4cGVjdHMgY2hhbmdlcyB0byBoYXBwZW4gdG8geW91ciBncm91cA0KPiA+ID4gbWVt
YmVyc2hpcA0KPiA+ID4gd2hlbiB5b3UgbG9nIGluLiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQg
dGhlIE5GUyBzZXJ2ZXIgaXMNCj4gPiA+IHVwZGF0aW5nDQo+ID4gPiBpdHMgcnVsZXMgY29uY2Vy
bmluZyB5b3VyIGdyb3VwIG1lbWJlcnNoaXAgYXQgc29tZSByYW5kb20gdGltZQ0KPiA+ID4gYWZ0
ZXINCj4gPiA+IHlvdXIgbG9nIGluIG9uIHRoZSBORlMgY2xpZW50Lg0KPiA+ID4gDQo+ID4gPiBT
byBob3cgYWJvdXQgaWYgd2UganVzdCBkbyBvdXIgYmVzdCB0byBhcHByb3hpbWF0ZSB0aGUgUE9T
SVgNCj4gPiA+IHJ1bGVzLCBhbmQNCj4gPiA+IHByb21pc2UgdG8gcmV2YWxpZGF0ZSB5b3VyIGNh
Y2hlZCBmaWxlIGFjY2VzcyBwZXJtaXNzaW9ucyBhdA0KPiA+ID4gbGVhc3Qgb25jZQ0KPiA+ID4g
YWZ0ZXIgeW91IGxvZyBpbj8gVGhlbiB3ZSBjYW4gbGV0IHRoZSBORlMgc2VydmVyIGRvIHdoYXRl
dmVyIHRoZQ0KPiA+ID4gaGVsbA0KPiA+ID4gaXQgd2FudHMgdG8gZG8gYWZ0ZXIgdGhhdC4NCj4g
PiA+IElPVzogSWYgdGhlIHN5c2FkbWluIGNoYW5nZXMgdGhlIGdyb3VwIG1lbWJlcnNoaXAgZm9y
IHRoZSB1c2VyLA0KPiA+ID4gdGhlbg0KPiA+ID4gdGhlIHVzZXIgY2FuIHJlbWVkeSB0aGUgcHJv
YmxlbSBieSBsb2dnaW5nIG91dCBhbmQgdGhlbiBsb2dnaW5nDQo+ID4gPiBiYWNrIGluDQo+ID4g
PiBhZ2FpbiwganVzdCBsaWtlIHRoZXkgZG8gZm9yIGxvY2FsIGZpbGVzeXN0ZW1zLg0KPiA+IA0K
PiA+IFRoaXMgZ29lcyBhIGxvbmcgd2F5IHRvd2FyZCBmaXhpbmcgdGhpbmdzIHVwIGZvciB1cywg
SSBhcHByZWNpYXRlDQo+ID4gaXQsIGFuZA0KPiA+IGhvcGUgdG8gc2VlIGl0IG1lcmdlZC7CoCBU
aGUgdmVyc2lvbiBvbiB5b3VyIHRlc3RpbmcgYnJhbmNoDQo+ID4gKGQ4NGIwNTlmKSBjYW4NCj4g
PiBoYXZlIG15Og0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBCZW5qYW1pbiBDb2RkaW5ndG9uIDxi
Y29kZGluZ0ByZWRoYXQuY29tPg0KPiA+IFRlc3RlZC1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8
YmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gPiANCj4gDQo+IFRoZSB0ZXN0IGluIHRoYXQgY29tbWl0
IGNhbiBiZSAiZ2FtZWQiLg0KPiBJIGNvdWxkIHdyaXRlIGEgdG9vbCB0aGF0IGRvdWJsZS1mb3Jr
cyB3aXRoIHRoZSBpbnRlcm1lZGlhdGUgZXhpdGluZw0KPiBzbyB0aGUgZ3JhbmRjaGlsZCB3aWxs
IGJlIGluaGVyaXRlZCBieSBpbml0LsKgIFRoZW4gdGhlIGdyYW5kY2hpbGQgY2FuDQo+IGFjY2Vz
cyB0aGUgcHJvYmxlbWF0aWMgcGF0aCBhbmQgZm9yY2UgdGhlIGFjY2VzcyBjYWNoZSBmb3IgdGhl
DQo+IGN1cnJlbnQNCj4gdXNlciB0byBiZSByZWZyZXNoZWQuwqAgSXQgd291bGQgb3B0aW9uYWxs
eSBuZWVkIHRvIGRvIGEgJ2ZpbmQnIHRvIGJlDQo+IHRob3JvdWdoLg0KDQpTdXJlLi4uIElmIHR3
byB0YXNrcyBzaGFyZSB0aGUgc2FtZSBjcmVkLCBvbmUgY2FuIGRvIGRlbGliZXJhdGVseSBjcmF6
eQ0Kc3R1ZmYgdG8gYnJlYWsgcGVyZm9ybWFuY2Ugb2YgdGhlIG90aGVyLiBJcyB0aGF0IG5ld3M/
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
