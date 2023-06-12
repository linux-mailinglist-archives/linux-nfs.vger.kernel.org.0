Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC372CFDF
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 21:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjFLTxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFLTxQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 15:53:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CB0102
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 12:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz+KHOrEx3j3fBLXQBjhDMIRxEh5q/Yd/k/kGpJv6S4GAuEbeLDJtliXTG9G+b1b+8N3RdRIAc8OCgpg3almSBHW/EwuQ0IoLsZ/i7h4SpA2SW95ESBv/SVFmTmE2HxcmUVVX8AjqXLCGJzhpVonfU7AX4yqqcPJ9yupVIPEfO87eBSFwld/UhrTUUZKCHUU5PauKoCbwKrS3eiC1Odj0b+fwJqOGHEL+Hq/OswREuhhYV3lRRgZ8R6lyWnPV87kATil5JgMOolE/7ye+WNKH8LubXgXoHFRFh7M5me0l8NcaO/QAuvsjMRMKbVDhtRL+DXzPX/PJcfBKwPWkntobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI4J0ntdgOKNo7f3s3s79FDS7SDaec/tlUawx+XID24=;
 b=NS4j2bqRL4zN1Ilo1ssmWG5LrX9+wdpNdx+EvJcqoNcktm5YTVucX9Cz7+1o4S7YhPFj2OLLeVPNc8mXZxtGScRv6IG9Q71F0yHYurNOUei7EbYCKomO6lvAxJ0jaQqz5rx9aUoupg4se+aYvwsxofRoOsH2jGRCRl/hhCescM3H0ANKKDrMyiMGzA/y53RUiPE4y/UgkQrdgEFPPjl1c374K0t5/4GqTfc2J264RTkJvSb3uwXymqfphHnK8WOsLfBC3GvjNye5A9ve6DNueSr66zK3/I7J4qkFrxv90KJsdNnXprXTZu8LvwO8SRcozYF0LuK0e2GQm4tBJWE+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI4J0ntdgOKNo7f3s3s79FDS7SDaec/tlUawx+XID24=;
 b=SEA2FAj/gRH9jk6IztUwQ/WYqcIbqWxwPYXcj+Y5ZZUDYwI7qeSUgdJowfXX3mO0Vr3fye2Hh4wsPByMQ5aasUs4Azg2zerj2PQxLkLUDNdcqa/Tfri2RuZV2NYEAKjJPH33ZIOQbpO3AvXWeivskVPbyYDJAfyuJG3X287r4/o=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB6136.namprd13.prod.outlook.com (2603:10b6:510:29d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 19:53:09 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%6]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 19:53:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "cperl@janestreet.com" <cperl@janestreet.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: Too many ENOSPC errors
Thread-Topic: Too many ENOSPC errors
Thread-Index: AQHZmixcHGuNgpUrYkSLHkSz8pXLeq+BYVYAgAXeawCAABlYAIAAGcuAgAAFXgCAABiNAIAACd0A
Date:   Mon, 12 Jun 2023 19:53:09 +0000
Message-ID: <fe258f94cf0d4f4731d4affbb78777706692bd20.camel@hammerspace.com>
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
         <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
         <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
         <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
         <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
         <CAAih9mhcOq2XqL0Q0sgkrpfJudpL9knV8yq+Uk1s2mJRRxau8Q@mail.gmail.com>
         <6c16c58a9e6de330eab68aadd4714954df41dd1c.camel@kernel.org>
In-Reply-To: <6c16c58a9e6de330eab68aadd4714954df41dd1c.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB6136:EE_
x-ms-office365-filtering-correlation-id: bcf1626f-29a5-4527-71b5-08db6b7ea5b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8RHZlPv5lplaXLHst1Ty6vWZKyv+HbbdgAkhsy6w9EiE+52/tqeGBVrN1gtBixaEco4/7EZ6bIVlMeakjNRHOUGHPA8H+isBzf7XSDDG1QyQcLj5c7PBsP6cu7W8Z4xjX51+g/q8xfFclqJ7zMwwo2f7Ua5ex16qU6oYBlXln38Zo//K1ysEWv6UCCJPx0UflxQU8BfppDlO3UBFIitLzmlgrUZRzATd+/uLmMHktsWpVrPV8nutMqtBaZWLz0y4bTM4PO2TfP7LFc2CZMjgtyEmhbkLP4/ub6vqKcck8pcjX6FXWOO7F5Lw1vR2KwtPhMs6hPOlF0zE8s1/bdUkjObZoKIj/Q1ZaaKsBk8gi+OtV2Oqn1cYWH3oWT57Eitgk0vAQya7HLlMTR8+U/fmCCmu/DpNqEmD5ll0vNDCfM3MmV6SNp5r723xaRzKUSmtPL2iXclDltEEN+JiPRgdg5wyvgVeHgmTquBcEVWJRJPbGscnhAnfsav2CV+VOGvR9M5Xl79LGKaXqC21FkQkwWj/w8Wn9l3AoLE9mNA3yhhSxjakAg9L7eLnvIn9/8T2oY4C/a/clPz6G6znZVbh9/8jXw5RcrWa2eOKnqUX+YRw4phusjvv3wiqPDKu1HSN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39840400004)(396003)(376002)(451199021)(2616005)(83380400001)(38070700005)(38100700002)(86362001)(122000001)(36756003)(3480700007)(478600001)(4326008)(110136005)(54906003)(6486002)(71200400001)(8936002)(8676002)(2906002)(5660300002)(66556008)(66946007)(64756008)(66476007)(66446008)(76116006)(41300700001)(316002)(53546011)(186003)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1dickwyN3hrdWx0QXd2ejBlSjJYNzdST1plMTJHSk4wM0ZncWs5REZTUzZ1?=
 =?utf-8?B?SVUrck9kRmpWSWRCMzZoZ3N5TjJxdWdzcVVaS2hkZVZHUnIySEZYTjNsV3B4?=
 =?utf-8?B?Ri9QWlV5R1ZiMC84SGpyZXFyK2h1VTI2OW9MSUNRTE9wSmlTYU5iVXpsVEox?=
 =?utf-8?B?RTg3OVFnYXVjbjhwcUZGTy94OHQvRm41ZjEyL3hzNXBMYitVT2ZybzJmR002?=
 =?utf-8?B?VHRYZk5zdDVIZW5iVGxxYnhoamE5cnJpTFlvVVdUZHp6YVlwSWtPYzNVbytu?=
 =?utf-8?B?OXNrZUoyWjJsTUNORFQ5cFpoMzVnTjh0S0Y5M3h3UWNDVS9KekE3RThxNTFV?=
 =?utf-8?B?VEZoUVM5c2QwcjVwakNxcVRKSGlhOW1ZQWlyaW1VaTdGRmlhc0l5c1pkbHVD?=
 =?utf-8?B?L1liZFpGSjhKbTd0SFF5Y3Z6ellBU0lCNFpXM1RxVUpxNUg2UzRnYmpxWjl1?=
 =?utf-8?B?elBzTWswOEMyNWxqZ1NuRnZ0aDVqbEY5WnZjenozN1RKSjE3ODZaNU03d1Bk?=
 =?utf-8?B?U01KelBrTk5pZUhRSjVlRVhVeVY0MUJBTUJRSHpoZGFSbzFQL2dDUldtUXhZ?=
 =?utf-8?B?WUxGcjlnZHlMMmJTVFZ6SEVHZFU0T00vT0JiSGFUbG9YOE5NNjYwTFJEME9C?=
 =?utf-8?B?ajRiOEhGQjhGWmdKeXEzbHkxN1hadDlWQkU0QmQ0SFpvTTRCRFI4aHRLN3Mv?=
 =?utf-8?B?aUJUMFIxbHV3dXBUb2M4eWUvSVpOTmJnWGR0TGtoS3RjZ3B0Y3FlUkNKamh5?=
 =?utf-8?B?Q1ppTmJuSVpaSEt4S3Vxc3VzaFM2UjRIT3FRdXlZbURrMGFDU1dIWGYzWjJu?=
 =?utf-8?B?TW1UQnZZWUs4ZVBHZmZQb1NWOVA3YUNmT25SR2FmaXViTkVJV1h3bm9Wejhi?=
 =?utf-8?B?dzZkMWpwQVNTM1k3emp5L3VXRmdyUXBMeHlrWHpPT2RGZ1M5WHhZNzBXNzl0?=
 =?utf-8?B?UVYyM0wvckxTZnlGNnJ1L0c4azRFM0RQazFPb2pFbUxCcnZtRHZRekpqRUE3?=
 =?utf-8?B?WEROempoZndyL21ReVllclhVQnZLclN2S0FhNHRqaDBrNXpCUFpWZVUxSWsx?=
 =?utf-8?B?Tk5kMjQ3NUszT08wNHFLek1CV2ZJV3pKUEF0THJhMkFqMGY4YVhVaUZiNDBo?=
 =?utf-8?B?WFN0VWtDN3J1WWNBLy9nV3RRMkY2amVSc1Z2UEc2Q2IzK05YYlZBSmZyMHVC?=
 =?utf-8?B?UGJRQVBhY0NkQXppRytFNVc0ZWEyQk1OKzRLVFZrZVZJeG1zRVlnSGJ2bjFY?=
 =?utf-8?B?V2I3Q1dMVGNLNXFCYytqUFFrWGRvRFIvMlo3YWVUTXYwRzFSRnhsenpmSmR1?=
 =?utf-8?B?N21kVGlMREdCTFUvOEpHckNqbXhXaDFWUzZkd1hWbGFnMkJXNWlEMEJ4TWhj?=
 =?utf-8?B?bnlOTVhNS0RFS2htS3pyN0N3cHF3RlBNdk5PcEVEaURCdWsra2hXcU1NajhI?=
 =?utf-8?B?UE9vQ0Vrc1E0bnlPZlVnYkh1QnhNK01HSEovT2IxN2lVblhKN2pIMDRBeitm?=
 =?utf-8?B?SHB5dU1vc1cyN1pLajNYWWtYRkQzYXVjdUtsUW13R2J4SURNMzR2ak5wa0dN?=
 =?utf-8?B?QU5oYyszcC9WKy9qdjNFQ2wwRFNFcXVhN0tqd1N1eUtQZUNkSlBaZ1h3clJh?=
 =?utf-8?B?ZmNESElHODI2ZU1XL1k3RXMwUWkwUU9ocWs1ZWE3TlRKSUVYYlBnVEdBdkht?=
 =?utf-8?B?ZnI3K3ByUWg5TVE5dkw1eWpTWEFSeXd6eHdCbjdDakhScUJPTTRDWlphT1dL?=
 =?utf-8?B?Zlc1K1BXdUhlVVJrdmtnVjVEcXJUbkQrb1UzRktsSElwRzBTRnM5a2dOd3ly?=
 =?utf-8?B?di9lRy9BVnd3MlNCc1FQV09FcHB6eWtTbEZVMXV4MitocWFiZWRaOHdwRjRT?=
 =?utf-8?B?cCtTYzZ1ZUJLWUEvVmUyZzZaQ0JhWXk5RURIa3BaVS9qVTl6dHNoa2JCNmlS?=
 =?utf-8?B?UFdCd0xOWEdLaUp2OVUxT2pWOVd5NStIRnRxKzFHdU9WbFZ1eXBoMVdNK3Jr?=
 =?utf-8?B?UEVuRFdoVEZtNWtXRElTaXgwSzl0NFZlazNyd2VpUTl4clorY1NYdmZWd3I1?=
 =?utf-8?B?RnJua2RDT2FtbjZaSnF4bVBTbnp3dDVYWnRzcmEyUFRaMEdMQjJjOUVrcTND?=
 =?utf-8?B?TlZ2TThoUkR5czQ1OWNKdXpwc1dZQzVpRzJyQW41V1dEZEVwSTdmWFVGR0ZY?=
 =?utf-8?B?Y3JhS0NUSkFYZGRHMTYyTUpXellhT1hIa2lMdTlIQXVZeEM3OEhOQXpZTGNF?=
 =?utf-8?B?YU1XdllmalVGUS9EU3J0Ym8zYlRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7779B018C672DC4D89D4D7D2A6F12E5E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf1626f-29a5-4527-71b5-08db6b7ea5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 19:53:09.2660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBaLbwjSmu++i3Iv0GDzN8JHcyo5ulL20xtAj7KoYAk6iScbNR4oaAgWZWWLHfkUCqzR1TKjgi+qFIkMcgN/TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTEyIGF0IDE1OjE3IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gTW9uLCAyMDIzLTA2LTEyIGF0IDEzOjQ5IC0wNDAwLCBDaHJpcyBQZXJsIHdyb3RlOg0KPiA+
IE9uIE1vbiwgSnVuIDEyLCAyMDIzIGF0IDE6MzDigK9QTSBKZWZmIExheXRvbiA8amxheXRvbkBr
ZXJuZWwub3JnPg0KPiA+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBNb24sIDIwMjMtMDYtMTIg
YXQgMTE6NTggLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+
ID4gPiBHb3QgaXQ6IEkgdGhpbmsgSSBzZWUgd2hhdCdzIGhhcHBlbmluZy4gZmlsZW1hcF9zYW1w
bGVfd2JfZXJyDQo+ID4gPiA+IGp1c3QgY2FsbHMNCj4gPiA+ID4gZXJyc2VxX3NhbXBsZSwgd2hp
Y2ggZG9lcyB0aGlzOg0KPiA+ID4gPiANCj4gPiA+ID4gZXJyc2VxX3QgZXJyc2VxX3NhbXBsZShl
cnJzZXFfdCAqZXNlcSkNCj4gPiA+ID4gew0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBlcnJzZXFf
dCBvbGQgPSBSRUFEX09OQ0UoKmVzZXEpOw0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqAgLyogSWYgbm9ib2R5IGhhcyBzZWVuIHRoaXMgZXJyb3IgeWV0LCB0aGVuIHdlIGNhbiBiZQ0K
PiA+ID4gPiB0aGUgZmlyc3QuICovDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGlmICghKG9sZCAm
IEVSUlNFUV9TRUVOKSkNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9s
ZCA9IDA7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBvbGQ7DQo+ID4gPiA+IH0NCj4g
PiA+ID4gDQo+ID4gPiA+IEJlY2F1c2Ugbm8gb25lIGhhcyBzZWVuIHRoYXQgZXJyb3IgeWV0IChF
UlJTRVFfU0VFTiBpcyBjbGVhciksDQo+ID4gPiA+IHRoZSB3cml0ZQ0KPiA+ID4gPiBlbmRzIHVw
IGJlaW5nIHRoZSBmaXJzdCB0byBzZWUgaXQgYW5kIGl0IGdldHMgYmFjayBhIDAsIGV2ZW4NCj4g
PiA+ID4gdGhvdWdoIHRoZQ0KPiA+ID4gPiBlcnJvciBoYXBwZW5lZCBiZWZvcmUgdGhlIHNhbXBs
ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBhYm92ZSBiZWhhdmlvciBpcyB3aGF0IHdlIHdhbnQg
Zm9yIHRoZSBzYW1wbGUgdGhhdCB3ZSBkbyBhdA0KPiA+ID4gPiBvcGVuKCkNCj4gPiA+ID4gdGlt
ZSwgYnV0IG5vdCB3aGF0J3MgbmVlZGVkIGZvciB0aGlzIHVzZS1jYXNlLiBXZSBuZWVkIGEgbmV3
DQo+ID4gPiA+IGhlbHBlciB0aGF0DQo+ID4gPiA+IHNhbXBsZXMgdGhlIHZhbHVlIHJlZ2FyZGxl
c3Mgb2Ygd2hldGhlciBpdCBoYXMgYWxyZWFkeSBiZWVuDQo+ID4gPiA+IHNlZW46DQo+ID4gPiA+
IA0KPiA+ID4gPiBlcnJzZXFfdCBlcnJzZXFfcGVlayhlcnJzZXFfdCAqZXNlcSkNCj4gPiA+ID4g
ew0KPiA+ID4gPiDCoMKgwqDCoMKgIHJldHVybiBSRUFEX09OQ0UoKmVzZXEpOw0KPiA+ID4gPiB9
DQo+ID4gPiA+IA0KPiA+ID4gPiAuLi5idXQgd2UnbGwgYWxzbyBuZWVkIHRvIGZpeCB1cCBlcnJz
ZXFfY2hlY2sgdG8gaGFuZGxlDQo+ID4gPiA+IGRpZmZlcmVuY2VzDQo+ID4gPiA+IGJldHdlZW4g
dGhlIFNFRU4gYml0Lg0KPiA+ID4gPiANCj4gPiA+ID4gSSdsbCBzZWUgaWYgSSBjYW4gc3BpbiB1
cCBhIHBhdGNoIGZvciB0aGF0LiBTdGF5IHR1bmVkLg0KPiA+ID4gDQo+ID4gPiBUaGlzIG1heSBu
b3QgYmUgZml4YWJsZSB3aXRoIHRoZSB3YXkgdGhhdCBORlMgaXMgdHJ5aW5nIHRvIHVzZQ0KPiA+
ID4gZXJyc2VxX3QuDQo+ID4gPiANCj4gPiA+IFRoZSBmdW5kYW1lbnRhbCBwcm9ibGVtIGlzIHRo
YXQgd2UgbmVlZCB0byBtYXJrIHRoZSBlcnJzZXFfdCBpbg0KPiA+ID4gdGhlDQo+ID4gPiBtYXBw
aW5nIGFzIFNFRU4gd2hlbiB3ZSBzYW1wbGUgaXQsIHRvIGVuc3VyZSB0aGF0IGEgbGF0ZXIgZXJy
b3INCj4gPiA+IGlzDQo+ID4gPiByZWNvcmRlZCBhbmQgbm90IGlnbm9yZWQuDQo+ID4gPiANCj4g
PiA+IEJ1dC4uLmlmIHRoZSBlcnJvciBoYXNuJ3QgYmVlbiByZXBvcnRlZCB5ZXQgYW5kIHdlIG1h
cmsgaXQgU0VFTg0KPiA+ID4gaGVyZSwNCj4gPiA+IGFuZCB0aGVuIGEgbGF0ZXIgZXJyb3IgZG9l
c24ndCBvY2N1ciwgdGhlbiBhIGxhdGVyIG9wZW4gd29uJ3QNCj4gPiA+IGhhdmUgaXRzDQo+ID4g
PiBlcnJzZXFfdCBzZXQgdG8gMCwgYW5kIHRoYXQgdW5zZWVuIGVycm9yIGNvdWxkIGJlIGxvc3Qu
DQo+ID4gPiANCj4gPiA+IEl0J3MgYSBiaXQgb2YgYSBwaXR5OiBhcyBvcmlnaW5hbGx5IGVudmlz
aW9uZWQsIHRoZSBlcnJzZXFfdA0KPiA+ID4gbWVjaGFuaXNtDQo+ID4gPiB3b3VsZCBwcm92aWRl
IGZvciB0aGlzIHNvcnQgb2YgdXNlIGNhc2UsIGJ1dCB3ZSBhZGRlZCB0aGlzIHBhdGNoDQo+ID4g
PiBub3QNCj4gPiA+IGxvbmcgYWZ0ZXIgdGhlIG9yaWdpbmFsIGNvZGUgd2VudCBpbiwgYW5kIGl0
IGNoYW5nZWQgdGhvc2UNCj4gPiA+IHNlbWFudGljczoNCj4gPiA+IA0KPiA+ID4gwqDCoMKgIGI0
Njc4ZGYxODRiMyBlcnJzZXE6IEFsd2F5cyByZXBvcnQgYSB3cml0ZWJhY2sgZXJyb3Igb25jZQ0K
PiA+ID4gDQo+ID4gPiBJIGRvbid0IHNlZSBhIGdvb2Qgd2F5IHRvIGRvIHRoaXMgdXNpbmcgdGhl
IGN1cnJlbnQgZXJyc2VxX3QNCj4gPiA+IG1lY2hhbmlzbSwNCj4gPiA+IGdpdmVuIHRoZXNlIGNv
bXBldGluZyBuZWVkcy4gSSdsbCBrZWVwIHRoaW5raW5nIGFib3V0IGl0IHRob3VnaC4NCj4gPiA+
IE1heWJlDQo+ID4gPiB3ZSBjb3VsZCBhZGQgc29tZSBzb3J0IG9mIHN0b3JlIGFuZCBmb3J3YXJk
IG1lY2hhbmlzbSBmb3IgZnN5bmMNCj4gPiA+IG9uIE5GUz8NCj4gPiA+IFRoYXQgY291bGQgZ2V0
IHJhdGhlciBjb21wbGV4IHRob3VnaC4NCj4gPiANCj4gPiBDYW4vc2hvdWxkIGl0IGJlIG1hcmtl
ZCBTRUVOIHdoZW4gdGhlIGluaXRpYWwgY2xvc2UoMikgZnJvbSB0ZWUoMSkNCj4gPiByZXBvcnRz
IHRoZSBlcnJvcj8NCj4gPiANCj4gDQo+IE5vLiBNb3N0IHNvZnR3YXJlIGRvZXNuJ3QgY2hlY2sg
Zm9yIGVycm9ycyBvbiBjbG9zZSgpLCBhbmQgZm9yIGdvb2QNCj4gcmVhc29uOiB0aGVyZSdzIG5v
IHJlcXVpcmVtZW50IHRoYXQgYW55IGRhdGEgYmUgd3JpdHRlbiBiYWNrIGJlZm9yZQ0KPiBjbG9z
ZSgpIHJldHVybnMuIEEgc3VjY2Vzc2Z1bCByZXR1cm4gaXMgbWVhbmluZ2xlc3MuDQo+IA0KPiBJ
dCB0dXJucyBvdXQgdGhhdCBORlN2NCAodXN1YWxseSkgd3JpdGVzIGJhY2sgdGhlIGRhdGEgYmVm
b3JlIGEgY2xvc2UNCj4gcmV0dXJucywgYnV0IHlvdSBkb24ndCB3YW50IHRvIHJlbHkgb24gdGhh
dC4NCj4gDQo+ID4gUGFydCBvZiB0aGUgcmVhc29uIEkgaGFkIG9yaWdpbmFsbHkgYXNrZWQgYWJv
dXQgYG5mc19maWxlX2ZsdXNoJw0KPiA+IChpLmUuDQo+ID4gd2hhdCBjbG9zZSgyKSBjYWxscykg
dXNpbmcgYGZpbGVfY2hlY2tfYW5kX2FkdmFuY2Vfd2JfZXJyJyBpbnN0ZWFkDQo+ID4gb2YNCj4g
PiBgZmlsZW1hcF9jaGVja193Yl9lcnInIHdhcyBiZWNhdXNlIEkgd2FzIGRyYXduIHRvIGNvbXBh
cmluZw0KPiA+IGBuZnNfZmlsZV9mbHVzaCcgYWdhaW5zdCBgbmZzX2ZpbGVfZnN5bmMnIGFzIGl0
IHNlZW1zIGxpa2UgaW4gdGhlDQo+ID4gMy4xMA0KPiA+IGJhc2VkIEVMNyBrZXJuZWxzLCB0aGUg
Zm9ybWVyIHVzZWQgdG8gZGVsZWdhdGUgdG8gdGhlIGxhdHRlciAoYnkNCj4gPiB3YXkNCj4gPiBv
ZiBgdmZzX2ZzeW5jJykgYW5kIHNvIHRoZXkgaGFkIGNvbnNpc3RlbnQgYmVoYXZpb3IsIHdoZXJl
YXMgbm93DQo+ID4gdGhleQ0KPiA+IGRvIG5vdC4NCj4gDQo+IEkgdGhpbmsgdGhlIHByb2JsZW0g
aXMgaW4gc29tZSBvZiB0aGUgY2hhbmdlcyB0byB3cml0ZSB0aGF0IGhhdmUgY29tZQ0KPiBpbnRv
IHBsYXkgc2luY2UgdGhlbi4gVGhleSB0cmllZCB0byB1c2UgZXJyc2VxX3QgdG8gdHJhY2sgZXJy
b3JzIG92ZXINCj4gYQ0KPiBzbWFsbCB3aW5kb3csIGJ1dCB0aGUgdW5kZXJseWluZyBpbmZyYXN0
cnVjdHVyZSBpcyBub3QgcXVpdGUgc3VpdGVkDQo+IGZvcg0KPiB0aGF0IGF0IHRoZSBtb21lbnQu
DQo+IA0KPiBJIHRoaW5rIHdlIGNhbiBnZXQgdGhlcmUgdGhvdWdoIGJ5IGNhcnZpbmcgYW5vdGhl
ciBmbGFnIGJpdCBvdXQgb2YNCj4gdGhlDQo+IGNvdW50ZXIgaW4gdGhlIGVycnNlcV90LiBJJ20g
d29ya2luZyBvbiBhIHBhdGNoIGZvciB0aGF0IG5vdy4NCj4gDQoNClRoZSBjdXJyZW50IE5GUyBj
bGllbnQgY29kZSB0cmllcyB0byBkbyBpdHMgYmVzdCB0byBtYXRjaCB0aGUNCmRlc2NyaXB0aW9u
IGluIHRoZSBtYW5wYWdlcyBmb3IgaG93IGVycm9ycyBhcmUgcmVwb3J0ZWQ6IHdlIHRyeSB0bw0K
cmVwb3J0IHRoZW0gZXhhY3RseSBvbmNlLCBlaXRoZXIgaW4gd3JpdGUoKSBvciBmc3luYygpLg0K
V2UgZG8gc3RpbGwgcmV0dXJuIGVycm9ycyBvbiBjbG9zZSgpLCBidXQgdGhhdCBraW5kIG9mIG9w
cG9ydHVuaXN0aWMNCmVycm9yIHJldHVybiBtYWtlcyBzdXJlIHRvIHVzZSBmaWxlbWFwX2NoZWNr
X3diX2VycigpIHNvIHRoYXQgd2UgZG9uJ3QNCmJyZWFrIHRoZSB3cml0ZSgpICsgZnN5bmMoKSBk
b2N1bWVudGVkIHNlbWFudGljcy4NCg0KVGhlIGlzc3VlIG9mIHBpY2tpbmcgdXAgZXJyb3JzIHVz
aW5nIGVycnNlcV9zYW1wbGUoKSBiZWZvcmUgZXZlbiBhbnkNCkkvTyBoYXMgYmVlbiBhdHRlbXB0
ZWQgaGFzIGJlZW4gcmFpc2VkIGJlZm9yZSwgYnV0IEFGQUlLLCB0aGUgY3VycmVudA0KYmVoYXZp
b3VyIGRvZXMgYWN0dWFsbHkgbWF0Y2ggdGhlIHByb21pc2VzIG1hZGUgaW4gdGhlIG1hbnBhZ2Vz
LCBhbmQgaXQNCm1hdGNoZXMgd2hhdCBjYW4gaGFwcGVuIHdpdGggb3RoZXIgZmlsZXN5c3RlbXMu
DQpJIGRvbid0IHdhbnQgdG8gc3BlY2lhbCBjYXNlIHRoZSBORlMgY2xpZW50LCBiZWNhdXNlIHRo
YXQganVzdCBsZWFkcyB0bw0KcGVvcGxlIGdldHRpbmcgY29uZnVzZWQgYXMgdG8gd2hldGhlciBv
ciBub3QgaXQgd2lsbCB3b3JrIGNvcnJlY3RseQ0Kd2l0aCBhcHBsaWNhdGlvbnMgc3VjaCBhcyBw
b3N0Z3Jlc3FsLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
