Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B4583541
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 00:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiG0WQg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 18:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiG0WQU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 18:16:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2106.outbound.protection.outlook.com [40.107.93.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D44055BF
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 15:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zjc5evHm6UCuX5JiK1iL8sF6rIDBNaNJVAjoop3ZuhzYWiXycXxCqAvBXFsIkxsiPZdXnaMUx1zloNJTbxJfBBn0VIi9lg4dIlNYrOixR1Ubd+up0Yz9Ieg+5yxwWHiXwuEu1bVIRy4gdnDYAwlmb1i5bysMFDwYyvNCAam9ep+wnJEe45OT+cyycp7Hs/70EHaGLxhpDpGDEuAYnSMRcgNXpROlIWGEH+HCTndkxxFr0Z0AlQxZxNhmcVK0rgOmXV3oM2wupdEDyM8RCm3+iMZYkAw+kTQcMz9gZvlm7W1Crbo0cAoyaHNoqTRQgXRklaxKo3WknxvdDP9b5YGMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23qO0GwJQgV5tUC3vRBG/g6Jra8J5XiXP2nkQ2RCf+E=;
 b=nYlJJKgyfiAZqG8zjrBMRNLfq+U6q6O2knuqWBE3xBkA2Qrcy+oG6/Zpj0mFh5dSqljzr1d8InZIqpkWwnk/HoES/YBRCTlwBsgb08OwD5eJ1pVTFQzyJrnjH2Ziqn/evHv5f3C57qOKGUyQPdZAEf5E+O45SfqHFoB0n07Z+21nqb3DFNKkctgEVaF4ZgNqRl9E+R4zKQv5LeaxQcziCMh+1BQLPCh86Oh4YUPlkrbcJ5B0F4LDbOuwAhz18xdbHG5Ur/Y96jePGXbuoykKteHf6Q7p0PuaKEpkKZKHdZDdrFpWRnoqkzStymjipxbRwW+Dz4hTQ1ET+Ts8+xzg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23qO0GwJQgV5tUC3vRBG/g6Jra8J5XiXP2nkQ2RCf+E=;
 b=WJ7UtZnKtAcgCQksipBOnq1Vl5gKx9GO0AfYHs95BPf3lpqSJ8hNJZBnkeRVrZUVw89EO515bFsZGRtmwPjiamM2GXfQQIp4b6SlMkkLa5wUpK5Lmd0KcYRMoOZXZcRn0KEXkc2wNQt5LXFm9iH3D++41UReZGgkptwWalgI8Fw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN6PR13MB2413.namprd13.prod.outlook.com (2603:10b6:805:5c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1; Wed, 27 Jul
 2022 22:12:59 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::88ef:2709:1cd2:50cf%9]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 22:12:59 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "hch@lst.de" <hch@lst.de>, "anna@kernel.org" <anna@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs/blocklayout: refactor block device opening
Thread-Topic: [PATCH] nfs/blocklayout: refactor block device opening
Thread-Index: AQHYhkAmJNycDTqqkE+otoZHjy5r+62RPU2AgAHCOIA=
Date:   Wed, 27 Jul 2022 22:12:58 +0000
Message-ID: <6b037d60406b2c2a3bb660edbaf429a48f72070e.camel@hammerspace.com>
References: <20220622135822.3564952-1-hch@lst.de>
         <20220726192127.GA20701@lst.de>
In-Reply-To: <20220726192127.GA20701@lst.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f057cfcb-aee8-4f1b-fbd6-08da701d2a26
x-ms-traffictypediagnostic: SN6PR13MB2413:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wpdTa6bXtt5SFImtoh6BgheIdToeJN4huefMBJbAHa8IZ+d33uEvYMr310MxfcivCt9XDZ3TI6VpT4UlLo4SAQY2068a/m2Wmg35CqOgSenM2Sz8uC1YsPnEeZVygn9pVR3/UlBBIXforB+lMqNM8j83XsxTBDUPg+Cqm5n2z968JrJmarH1O9w7VhrnRQ4SlTMynsx0XtbNmBUYVuOMC1/UXIx90FuhMmsJMwfChuTt6bHw9OaPKxz+USRhBZgB7zqIdB5lyZu03OLJG4QBzMnHMvRnKO+LUXNhrIULppl6BQgUyh7BCnQ4o6PdyqfKV3v7rFm4UCba6oOL2F9jklqD6rpi77b5pcYUU39CUjhnwhMNl5YNjxvXCPKwZdVADP8MpDKMnzjNCErPSw8wxSwAyYNhNtnq6O6tChSdiwFEudKIZHKinf6p3qednKnyazSl9F8p340Txnbs4MI9n8U3LO2ARwNcnqoM0BG8d5mDpxZuhfjGdNd81bxzRcTYpXOqE8gl9CsIHBGnVZWaTfjNOF4+pMtu8/RWPFhR7EfyC57ccc4rtZ0w3uZjzgvqvINse/6O6MFP81ln+bmpIDN0AGDp38IwKY2vRfZ79P9ltUnJVRfkV6RNYrw/xxnQ+8dZXAzIQaY1wX40ISj6UXb5U5EtxrCK5P19n3/8klF55YzeOZd5tZw/w1jz5LXHXMdw4TMij6KUK1PCo2rHh+BYxxzUhIFGpI+9xwSMBMWUmm/rGtk1iN5Tiv2tyWpMFqEgS50006cqERJO5ZGbIIbe+8z8o3WKzTiNgnv46ULgBehfgn+i0zgjcV3KlHHAAuMdypkicbg8Ajpddlo3EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39830400003)(136003)(376002)(346002)(6512007)(66446008)(38100700002)(66556008)(83380400001)(86362001)(26005)(64756008)(122000001)(478600001)(8936002)(316002)(110136005)(8676002)(41300700001)(71200400001)(2906002)(4326008)(2616005)(36756003)(76116006)(6486002)(66946007)(5660300002)(6506007)(66476007)(38070700005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2FISW81NERwdGUzcmo4M1dHOGh1SWlEb3NLVWNHQS9tVWVpbkd4YkE3MW1q?=
 =?utf-8?B?NGUwOVRGYlZVWWgzRm92SDJSWHMyZkV6dWNvVkVpVEwyM0JROWI2Z3o1Y0VK?=
 =?utf-8?B?RUZUdFUrZ1VJRTdoYXlRTlNIOFVXNUtSVURmelVLeGdUWE5GTk5PdmtpeFJS?=
 =?utf-8?B?Q3ROMUV2eGIycE52WlZCVElEK0RzbkhoQWkySXZ0NFJjTC9FUXUxU3V2c0xl?=
 =?utf-8?B?WXo5VkdpRUtBOHY4L1FvWnhjbmlmYm8xRUEzQ3ZnUXlpdjY1ckF3ZnIva3N2?=
 =?utf-8?B?blFhZkRNVWVBSGdpNmI1ejVHQXhyVzdaQzBBcFplOEFBbzh2NmtlTDJLaVVO?=
 =?utf-8?B?YXdqOFFuamFweWNHbGI2aW5kRHVWQVA4YlNCMEpuenlCZmRoTk1jS1pOZ1pD?=
 =?utf-8?B?ZHhIcVR1OFJkTndOMjExR3FieWVwSTQzTjJTMjFRL09jU1JhclIvcTYvdmpT?=
 =?utf-8?B?ZUxvdFR2TE5NSzZMTnVnUS9sSTJtY2dWaTcrM3ZXZmxiYXJwT1Y0YkM2djBT?=
 =?utf-8?B?ZTB4ci84QmIwWnJWUWdNRHgzSk9kVnpFdnM1blhKOWpxNFFPcUdraXZFVVR1?=
 =?utf-8?B?WDJGcWhQbWRYMmc1V2pnWGk1VFBvR0ZIdmpWTHFpL3JucEZObTlpZTFkeENR?=
 =?utf-8?B?TnUvcm5wMUJTNU9VODAzY0N6UEZiRnJqczMxQm4zdlIvUDBieUZzZmg3SGpx?=
 =?utf-8?B?ZXBHWFVzdUlnSFplYTk5aXdxU3c2d1JYRW5PSTBtSWVZZlFzL0JHVHFvWlZS?=
 =?utf-8?B?MWQ1UE50eEVvL0hmdXdYcXJRYWxybHVXaFo4OTZGcmpZRXF6SXEybldMV1Zq?=
 =?utf-8?B?VnIzVmpGUVlaOFF1YitqM3VtZk1zN1h2ZWYwbWc5RTlIOE1aUTNjMlpabXRC?=
 =?utf-8?B?RXBhNnJSUzRSSDhJNHpNcHpad1dLQ2IxaThhbExmbzd6YXJVUUVnNGdiVVZM?=
 =?utf-8?B?c3RUdnBFR2VLaFRhSUlnVWFMUGpIVTRyS0Z5L3JQZW14bXFEQ0xuNU1Sdk1w?=
 =?utf-8?B?ZmJ3UTI2TmlYQ2Jpb0Z3KzE2aGpvRnVNQ3ZpdmIvU0NIYm9wU0FNeEQyb1c1?=
 =?utf-8?B?NWdBODB2Q2JXRHVtakZiZnFUWXNMVEdqRTlCaFFPU0RibnY1dDliR2huaXp1?=
 =?utf-8?B?ZkVRUFhpNUtDaTRIUWFVS2JzVklqbzh4eTRPbmU3eExOUW1Cc1hFWFJqYWtt?=
 =?utf-8?B?N1JsNzJVRENZWERBS0MvVHVtZ2wwdGZ3Z0F3NXRzRFNrMEpDKzNhVGk0eVhn?=
 =?utf-8?B?aHdaWGxqZDgrSStmdEorNnRJbWgwanI1NjRkcFozcHFHMDY3dUhCdUdVb3Js?=
 =?utf-8?B?R0hEN2pqNGV6SlFBVTA0cmUxU0poNnNBaVlFWlhnS0d0Y29Ua3lBc0dlSGZN?=
 =?utf-8?B?RVowWGRVeHNVcHZaL3pFSG9FYUdNQkhiREgvU3M3R1hiRktrd25YQjdFRUZ3?=
 =?utf-8?B?c05ZWmEydUxuNENjVUVNREttTXVPcWhjbVhVdFp1cU1GQk13b1NpeFk5VjlE?=
 =?utf-8?B?elB0cDFYZm03Z0xFMVJhWGxRSUdMOXhRRitMQmE0OU9rdHVEb01wTFB3b09Q?=
 =?utf-8?B?SEJYbGZqYzFwei9HcnR0NHo0RTRTU2dVWGlkSlBKVXFsaGY5M0UxUVBiNVpX?=
 =?utf-8?B?UWJ1dSthZWNkL2g3cERPajk1UXhNNnhCSEw4bVRpM00vZnplTCtDYUdZbDhX?=
 =?utf-8?B?L0t0Y2E5bTQ0TzlrT1JyTzFVSTdnRGt6STRnNUtwWVh1ZVNLK1BEa1VkWk5p?=
 =?utf-8?B?cFI0TnZpcXpubnJPd0dJVHJGang0cHJuRU9jWGhVWFdscjkweTZ4MjlRdGcx?=
 =?utf-8?B?SlBpSHFiZ1JvdjIzenNzbG9aU0RPRHQ2SElQTHAzbzkvdERnYk1CUjV4bUFY?=
 =?utf-8?B?S2Mwa04vcHhRNklzN2hveC81bWo1T01BQnE2cm9WalBJa2VYM0tBVnBWck0z?=
 =?utf-8?B?eHl1eGRRaVkxcWNtYjQzV0svWkdNUzhBREZuWE9wRSttR2N5ckxOcW5KWW5x?=
 =?utf-8?B?TG55OHpGanA2YnRuQ3dzQUt0QVFOc0hMaDhwRlViR3lvUlFoTGJVNTk1MS9w?=
 =?utf-8?B?NjRQcWlNd2VoOHlkODBwZHQzbDVzbUY0TFhEenNldWIwL0VvbkhPNmFZeDFP?=
 =?utf-8?B?Qis1UTdBT3RiOEs1RDFmRUtPVW14V0xKdU1oNUIyMThjMGUrRG5VSFBOblMx?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6B95B7E4E16314592C993ABDA769ABD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f057cfcb-aee8-4f1b-fbd6-08da701d2a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 22:12:58.9750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2GhXlBZ1Aw0ZWNSTOAHZ8hWPmkb+iFjVyHv/7+AQiy2QdwA/59e/6AkyhSw8NlEvEg5gV/2J3lKB4oWGCjLGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2413
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA3LTI2IGF0IDIxOjIxICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiBwaW5nPwoKUXVldWVkIGZvciB0aGUgbmV4dCBtZXJnZSB3aW5kb3csIGFuZCBzaG91bGQg
YWxyZWFkeSBiZSBhcHBlYXJpbmcgaW4KbGludXgtbmV4dC4KCj4gCj4gT24gV2VkLCBKdW4gMjIs
IDIwMjIgYXQgMDM6NTg6MjJQTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPiBE
ZWR1cGxpY2F0ZSB0aGUgaGVscGVycyB0byBvcGVuIGEgZGV2aWNlIG5vZGUgYnkgcGFzc2luZyBh
IG5hbWUKPiA+IHByZWZpeCBhcmd1bWVudCBhbmQgdXNpbmcgdGhlIHNhbWUgaGVscGVyIGZvciBi
b3RoIGtpbmRzIG9mIHBhdGhzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4KPiA+IC0tLQo+ID4gwqBmcy9uZnMvYmxvY2tsYXlvdXQvZGV2LmMg
fCA0MiArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+IC0tLS0KPiA+IMKg
MSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQo+ID4gCj4g
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Jsb2NrbGF5b3V0L2Rldi5jIGIvZnMvbmZzL2Jsb2NrbGF5
b3V0L2Rldi5jCj4gPiBpbmRleCA1ZTU2ZGE3NDhiMmFiLi5mZWE1Zjg4MjFkYTVlIDEwMDY0NAo+
ID4gLS0tIGEvZnMvbmZzL2Jsb2NrbGF5b3V0L2Rldi5jCj4gPiArKysgYi9mcy9uZnMvYmxvY2ts
YXlvdXQvZGV2LmMKPiA+IEBAIC0zMDEsMTggKzMwMSwxNCBAQCBibF92YWxpZGF0ZV9kZXNpZ25h
dG9yKHN0cnVjdAo+ID4gcG5mc19ibG9ja192b2x1bWUgKnYpCj4gPiDCoMKgwqDCoMKgwqDCoMKg
fQo+ID4gwqB9Cj4gPiDCoAo+ID4gLS8qCj4gPiAtICogVHJ5IHRvIG9wZW4gdGhlIHVkZXYgcGF0
aCBmb3IgdGhlIFdXTi7CoCBBdCBsZWFzdCBvbiBEZWJpYW4gdGhlCj4gPiB1ZGV2Cj4gPiAtICog
YnktaWQgcGF0aCB3aWxsIGFsd2F5cyBwb2ludCB0byB0aGUgZG0tbXVsdGlwYXRoIGRldmljZSBp
ZiBvbmUKPiA+IGV4aXN0cy4KPiA+IC0gKi8KPiA+IMKgc3RhdGljIHN0cnVjdCBibG9ja19kZXZp
Y2UgKgo+ID4gLWJsX29wZW5fdWRldl9wYXRoKHN0cnVjdCBwbmZzX2Jsb2NrX3ZvbHVtZSAqdikK
PiA+ICtibF9vcGVuX3BhdGgoc3RydWN0IHBuZnNfYmxvY2tfdm9sdW1lICp2LCBjb25zdCBjaGFy
ICpwcmVmaXgpCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYmxvY2tfZGV2aWNl
ICpiZGV2Owo+ID4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IGNoYXIgKmRldm5hbWU7Cj4gPiDCoAo+
ID4gLcKgwqDCoMKgwqDCoMKgZGV2bmFtZSA9IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiL2Rldi9k
aXNrL2J5LWlkL3d3bi0KPiA+IDB4JSpwaE4iLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdi0+c2NzaS5kZXNpZ25hdG9y
X2xlbiwgdi0KPiA+ID5zY3NpLmRlc2lnbmF0b3IpOwo+ID4gK8KgwqDCoMKgwqDCoMKgZGV2bmFt
ZSA9IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiL2Rldi9kaXNrL2J5LWlkLyVzJSpwaE4iLAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcmVmaXgsIHYt
PnNjc2kuZGVzaWduYXRvcl9sZW4sIHYtCj4gPiA+c2NzaS5kZXNpZ25hdG9yKTsKPiA+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoIWRldm5hbWUpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwo+ID4gwqAKPiA+IEBAIC0zMjYsMjggKzMyMiw2
IEBAIGJsX29wZW5fdWRldl9wYXRoKHN0cnVjdCBwbmZzX2Jsb2NrX3ZvbHVtZSAqdikKPiA+IMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gYmRldjsKPiA+IMKgfQo+ID4gwqAKPiA+IC0vKgo+ID4gLSAq
IFRyeSB0byBvcGVuIHRoZSBSSC9GZWRvcmEgc3BlY2lmaWMgZG0tbXBhdGggdWRldiBwYXRoIGZv
ciB0aGlzCj4gPiBXV04sIGFzIHRoZQo+ID4gLSAqIHd3bi0gbGlua3Mgd2lsbCBvbmx5IHBvaW50
IHRvIHRoZSBmaXJzdCBkaXNjb3ZlcmVkIFNDU0kgZGV2aWNlCj4gPiB0aGVyZS4KPiA+IC0gKi8K
PiA+IC1zdGF0aWMgc3RydWN0IGJsb2NrX2RldmljZSAqCj4gPiAtYmxfb3Blbl9kbV9tcGF0aF91
ZGV2X3BhdGgoc3RydWN0IHBuZnNfYmxvY2tfdm9sdW1lICp2KQo+ID4gLXsKPiA+IC3CoMKgwqDC
oMKgwqDCoHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXY7Cj4gPiAtwqDCoMKgwqDCoMKgwqBjb25z
dCBjaGFyICpkZXZuYW1lOwo+ID4gLQo+ID4gLcKgwqDCoMKgwqDCoMKgZGV2bmFtZSA9IGthc3By
aW50ZihHRlBfS0VSTkVMLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAiL2Rldi9kaXNrL2J5LWlkL2RtLXV1aWQtbXBhdGgtJWQlKnBoTiIsCj4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHYtPnNjc2kuZGVz
aWduYXRvcl90eXBlLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB2LT5zY3NpLmRlc2lnbmF0b3JfbGVuLCB2LQo+ID4gPnNjc2kuZGVzaWduYXRvcik7
Cj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoIWRldm5hbWUpCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gPiAtCj4gPiAtwqDCoMKgwqDC
oMKgwqBiZGV2ID0gYmxrZGV2X2dldF9ieV9wYXRoKGRldm5hbWUsIEZNT0RFX1JFQUQgfAo+ID4g
Rk1PREVfV1JJVEUsIE5VTEwpOwo+ID4gLcKgwqDCoMKgwqDCoMKga2ZyZWUoZGV2bmFtZSk7Cj4g
PiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gYmRldjsKPiA+IC19Cj4gPiAtCj4gPiDCoHN0YXRpYyBp
bnQKPiA+IMKgYmxfcGFyc2Vfc2NzaShzdHJ1Y3QgbmZzX3NlcnZlciAqc2VydmVyLCBzdHJ1Y3Qg
cG5mc19ibG9ja19kZXYgKmQsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCBwbmZzX2Jsb2NrX3ZvbHVtZSAqdm9sdW1lcywgaW50IGlkeCwgZ2ZwX3QKPiA+IGdmcF9t
YXNrKQo+ID4gQEAgLTM2MCw5ICszMzQsMTUgQEAgYmxfcGFyc2Vfc2NzaShzdHJ1Y3QgbmZzX3Nl
cnZlciAqc2VydmVyLAo+ID4gc3RydWN0IHBuZnNfYmxvY2tfZGV2ICpkLAo+ID4gwqDCoMKgwqDC
oMKgwqDCoGlmICghYmxfdmFsaWRhdGVfZGVzaWduYXRvcih2KSkKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gPiDCoAo+ID4gLcKgwqDCoMKgwqDC
oMKgYmRldiA9IGJsX29wZW5fZG1fbXBhdGhfdWRldl9wYXRoKHYpOwo+ID4gK8KgwqDCoMKgwqDC
oMKgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFRyeSB0byBvcGVuIHRoZSBSSC9GZWRvcmEgc3Bl
Y2lmaWMgZG0tbXBhdGggdWRldiBwYXRoCj4gPiBmaXJzdCwgYXMgdGhlCj4gPiArwqDCoMKgwqDC
oMKgwqAgKiB3d24tIGxpbmtzIHdpbGwgb25seSBwb2ludCB0byB0aGUgZmlyc3QgZGlzY292ZXJl
ZCBTQ1NJCj4gPiBkZXZpY2UgdGhlcmUuCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBPbiBvdGhlciBk
aXN0cmlidXRpb25zIGxpa2UgRGViaWFuLCB0aGUgZGVmYXVsdCBTQ1NJIGJ5LQo+ID4gaWQgcGF0
aCB3aWxsCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBwb2ludCB0byB0aGUgZG0tbXVsdGlwYXRoIGRl
dmljZSBpZiBvbmUgZXhpc3RzLgo+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDC
oMKgwqBiZGV2ID0gYmxfb3Blbl9wYXRoKHYsICJkbS11dWlkLW1wYXRoLTB4Iik7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKElTX0VSUihiZGV2KSkKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBiZGV2ID0gYmxfb3Blbl91ZGV2X3BhdGgodik7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgYmRldiA9IGJsX29wZW5fcGF0aCh2LCAid3duLTB4Iik7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKElTX0VSUihiZGV2KSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIFBUUl9FUlIoYmRldik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgZC0+YmRl
diA9IGJkZXY7Cj4gPiAtLSAKPiA+IDIuMzAuMgo+IC0tLWVuZCBxdW90ZWQgdGV4dC0tLQoKLS0g
ClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=
