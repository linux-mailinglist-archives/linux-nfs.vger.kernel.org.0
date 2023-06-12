Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DC372CEF6
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 21:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjFLTFN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbjFLTFF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 15:05:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2096.outbound.protection.outlook.com [40.107.244.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7223FB
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 12:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajJ/kjzBq6HzVNZFO3S9dIkSOJdCqiTkt2lN32c39ooPgoNa5FXMHtDTEsFrfKawAfVir8fbdGU1PX4cAWCaZTWW2u+ejupFQgb3V03dOP2ulaT2woYUvjl0+qTgQQzD+ESe+fxAao5rgL+bGzzeu/7tRJAPY0IU/fGnjmzdN8NcwHsl2LQV4Jyw/vOmpts+pZ4bVQj38lidHCGWWLDSDfxIwg6ffkZ/sIAaPAR2bKxfyC/U+HkFMScK4Dz+NoZPluBM/IZIw+OfG/NLKkhyepa+9Kk6rShigLBUQnraN1fxh9NfjAC0sohG4xmYxIeza46CnMskkcdec9wwCvqoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt2rLDGyumW8y1VhPbabJADxZI9KaGUa5hKkLMrTtp0=;
 b=LnN7kqgcotSFXO8oJ9cG6Eq9YMTksgKVyHuO/PWKa70PDkcRkpa635g78IVGPR/54qfpwTB1JakGaUCmhI4KBf4ySNVfrBdAKa5Oq8z4s9+emQMUgwdzU29jPbBHKEi/SG2J0jgw24juz4EJyxrv4gzch3Qz9KabX9BdAjrbdnRdMsEY69etsQYlZIJi2TV0MVsqy6LIADDCL+0kDVCvPLnbXAOVTKHKhqJdpFBKTiOjq59An643C+iUZsN8Tnw3g7No8HkWvxbiKHD5WVOhwF46c6kBhr1T+HUIXwRPU36APQmLpQS0H8P5XKIGNnTmonmpHSJe7eB5jxyFZqFR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt2rLDGyumW8y1VhPbabJADxZI9KaGUa5hKkLMrTtp0=;
 b=fvDYTP7Y+x0qGq3sKqnltFXVKTgux+iFr47Wk5EZmsSbcvylg38rov/5vEXk7ueeVkc2NmcISAoq3N8CacZxo6CN6eLNU4RIVd4ajCNH1FSsQjOTEYAppp7Nk4oebiPDI9lPI467gb73xhhoHYrx4hd+t6s1gRdLCAHo8WCvCJY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB4873.namprd13.prod.outlook.com (2603:10b6:510:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 19:04:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%6]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 19:04:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "cperl@janestreet.com" <cperl@janestreet.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: Too many ENOSPC errors
Thread-Topic: Too many ENOSPC errors
Thread-Index: AQHZmixcHGuNgpUrYkSLHkSz8pXLeq+BYVYAgAXeawCAABlYAIAAGcuAgAAaUYA=
Date:   Mon, 12 Jun 2023 19:04:58 +0000
Message-ID: <5f3f2565aa31da52cd7b4359cba078e1990d44e7.camel@hammerspace.com>
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
         <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
         <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
         <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
         <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
In-Reply-To: <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB4873:EE_
x-ms-office365-filtering-correlation-id: 09f51d6a-1db9-4286-75ea-08db6b77eaa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zrcAdeVtaQ+NqB7wDD5Eml/rtMctExsfuySxlGDe4IqAxsSvocKaw30rjEXkYktcsj3XaTusmHLxh2Y8NObIje8jVCl0ejMqFGcm9h/R/M2NOjbL7N5sHcfH1PP3CAWWVVKO3IAiSDKvr4/7tPf/RqED76AmbftyeBi1AU0KI9pUsYgEOsusM0s4DJ8GxbKyEjDidce6I3gtEgG1yXtVP+YVri/QynDTNND/cXLGHb17+Wpf/GEVvUnyjc1VcqiTmlcAoI6y8pL0Nf9tzWv3rU26qnpFLc+gE2NEcrDJA+BszzJXiF0SjkFTNn5sTGxtXZEHnWQn2ebnzlHWKS7ZAcNaDIuC4bvnjSN4QbpqOkenruNk6AO2pbQn8Uv7+gP9eMgmT0PvGWgqqwm+FvJ7Q9jJ8MBW6IGvYbzWQbesTO1s+y9A0I75RQ/OyksynKziRpjub5UoNYcTm9tDy9BPiD0KLfJLSxu5cdKMW+F5wvTuMJif2JRa1yPogMkor87NoqCQ+Aisyh6foVUBUYKGlxd9+PzL4ZdiZ+F10lys1iYt0mbj/P3Prr35ZFhlOuevmEOflH7KZH5khlrtEUWjlAcH3yl+7h6n1bmdtlX4FezrdZRF4AexCkVQIElQW8QE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39840400004)(396003)(376002)(451199021)(2616005)(38100700002)(122000001)(38070700005)(86362001)(36756003)(3480700007)(478600001)(110136005)(54906003)(71200400001)(4326008)(6486002)(8676002)(2906002)(8936002)(5660300002)(66946007)(66476007)(66446008)(64756008)(66556008)(76116006)(41300700001)(316002)(186003)(6512007)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUo5bDlteFRHaWw3MWZNSHlBNERjV0pSZXhRZlF1dG5admZwNU9Kakd6SHd4?=
 =?utf-8?B?VnBLM1JTMjkxNk9XQjhqL2NERTU5WXE4a01pMU1vV3Ztd0VXKzFUTWlTS3pM?=
 =?utf-8?B?MElydU9NS0JGQW0rVFlvQXRjdzUzRWpIM09OekFibjhKcjFkMVBzY0lFTWlE?=
 =?utf-8?B?dmVCK3RWZTg2MDQ5N2JNMjBhd2l4UmNYcmY4TVVFVGNKRkg0dEhuL0hqNFZD?=
 =?utf-8?B?WDBiME1NRkhGN3EvbHovNXZpazZJdjBZdno5WkhVSVBLTnozTzYyYWhqQWZM?=
 =?utf-8?B?ajhsSGliSDU1UlNRQmRKM2J6d24vcmM4b1A4YVhKa0tWMkljam1NUEVMQ2hF?=
 =?utf-8?B?WjBVbWljMFdhcmRsdW5KblJBVU9xM3pnUWZ6cWF1bU1tb3hBN0tvS3ZvUith?=
 =?utf-8?B?YitlVXdseHExZlRVbnFEejRkMlp3SndBRmZXU2NDeGF1Ti9vZVRVelJjZ2c4?=
 =?utf-8?B?ZG91ckdYZFFoYWhYNlhlR0JWVXlSY2Mxck5QSVNsSTljZDBhT080c01XUnVi?=
 =?utf-8?B?cForbGxlTUFZNThBRU5jNG15a3JvMjRqa2pqWUZqTDdmTUMwdEM0dXZ4aUVk?=
 =?utf-8?B?d01tWHRvZjUrWUhyNGs4eGhkYi8xOWpPWWlCR1dXQlNoNUxybk5SMTl4TjZQ?=
 =?utf-8?B?dGVBOXRUdEd6eXlrVk1WYi9LYTFVUnIzUHhrcTJWNjZtQXZHZ20ybDdLU3Bv?=
 =?utf-8?B?UFMrVlFSWUVDSmpjc0VjMmVlUHJMck1QWGJNMStPbWFrcWt2MjFTajBGWEg0?=
 =?utf-8?B?TGc4RHNhT0ZUM2xaUlo4TFJJaVFtaHQ5akJJdG42RHRYeSs2VnFqNkF5NXNm?=
 =?utf-8?B?a3AxV0ExcjhLakZxWDdpejBFS2JveVpnTk9LQytSSXRiSWYwa2E1dzQweFF3?=
 =?utf-8?B?TzJXRUxOZkxsaHJvSktvTWxhajFOZmpWQnJBZFFmUXlab2pwZTZQdk1sNksw?=
 =?utf-8?B?cEpTdVQ4dU10QkJ4Y3RuY2RQeDhGYjhIbFV6VGRyNEJwM3RNUklqN0VlWVNq?=
 =?utf-8?B?cURONERDNWlGTFhHL0Z4K3FFUFhMUHFsbGRnckZoeUV0Uk5hL1hSZHE5TEZ1?=
 =?utf-8?B?bVN4czFtQ2ZZaWR1QTJzWnBDUCs3U1crdUNBTG5JdVRLaDBUT3lIWXpZeFNy?=
 =?utf-8?B?T1QzUUhDSGhpR0t3QUMvSDNKalJFOHlKRXRTT1Rrems0MmkzWWhvYlF6Q3JW?=
 =?utf-8?B?alo3ZE1KY25tUDhxcWpIYUpjSGltUHpGdE5xb1dyZ1NVV1VRN1lHK2trQU9o?=
 =?utf-8?B?NEhSbFBuMGdVRlhtWHhwL3RSdDNCL2RoWVd4aDlVdGF4QXlSekNBNkFRWXUr?=
 =?utf-8?B?VVg5bEdTQnE1RjJYKytDRlgyejBkRHlXZEMrSk5RTW1vN0VneExlVGFOVVFK?=
 =?utf-8?B?SmxsdTB0R1J1dW9vR0hKcFBBWmpyQVorUUZ5ZlI0Qnd6c3d4dTZiYmhxOGZl?=
 =?utf-8?B?SmtqM1B1aGQrR3BtbUYxbnJYejVSUHJwVlZ2WUUrT2ticTRuRjJNeU5icnM4?=
 =?utf-8?B?K0NmR2hpeU1yMkhUdmNyeUNtRElhVW1BaTdRbUVGdnhTSU5ESzVvVU96MHFu?=
 =?utf-8?B?VVFITE9qT2lqbWhZSE14OGVabGtUalJWd1VJNUtGUHAvT1lON2UwWlZGenJQ?=
 =?utf-8?B?eUVNWCs2R2pTeGI3Nms0RkVSRThtTVFhYmtYemZkTnlZYkx6NXhWMXVhSXl1?=
 =?utf-8?B?SXhueEJjam5pWVBCT3I2elBNZFpnSnpSNjBtS0NZSWNHVTlmb1BMSFV0amxX?=
 =?utf-8?B?eElKaFdNcllrNGxMNFBtY0hILzAyRGM4NXEya0tVRTNYNUJGU05ScW1DcWcw?=
 =?utf-8?B?OFlGSzRiQjd1QUhzTG9pSTdSb28zUVJscVoyVGdZS1I3ckRDS1I4NXdLM3VT?=
 =?utf-8?B?bDhkbmlodnd6RlVyTXg0L05tSUh4ZUFWMlcva1FLOUl4bkR2a014NkZyVXl1?=
 =?utf-8?B?SXZJZWVmUG1YeDE2SkJKWFZOWjIySkhRSExpOFRFd1R0c0JCWWtqcTJJTm1R?=
 =?utf-8?B?NHN2MmxwSXJvRlNnZTgrbVdCV1VaZjZ0eGtVVVRpK1VHeHlFTzdHQ2JBenV5?=
 =?utf-8?B?dFRLM2hkcVc4LzZEUDR4ZENXWFFPLzZ6YjNmN2pDemdxOHZkamV6UmZmYS9T?=
 =?utf-8?B?djZ2TERha0NmZVBwY2hvcWxDb1MvcGg1MG1KcWd5QTJOeW5XczRVcHpmak9O?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75E15E1BD7E5CA49AB9DB456D9DFE2E7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f51d6a-1db9-4286-75ea-08db6b77eaa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 19:04:58.4834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJWRrBNeidR+I6CsZQ3as4hdm4YXNAEXpRM3X8c8g8MrwcJepiS/2vtg7zEitoqp/l9r66SSnpcSNyqTNqT8gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTEyIGF0IDEzOjMwIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToKPiBP
biBNb24sIDIwMjMtMDYtMTIgYXQgMTE6NTggLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOgo+IAo+
ID4gCj4gPiBHb3QgaXQ6IEkgdGhpbmsgSSBzZWUgd2hhdCdzIGhhcHBlbmluZy4gZmlsZW1hcF9z
YW1wbGVfd2JfZXJyIGp1c3QKPiA+IGNhbGxzCj4gPiBlcnJzZXFfc2FtcGxlLCB3aGljaCBkb2Vz
IHRoaXM6Cj4gPiAKPiA+IGVycnNlcV90IGVycnNlcV9zYW1wbGUoZXJyc2VxX3QKPiA+ICplc2Vx
KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgCj4gPiB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+ID4gwqDCoMKg
wqDCoMKgwqAgZXJyc2VxX3Qgb2xkID0KPiA+IFJFQURfT05DRSgqZXNlcSk7wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIAo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gPiDCoMKgwqDCoMKgwqDCoCAv
KiBJZiBub2JvZHkgaGFzIHNlZW4gdGhpcyBlcnJvciB5ZXQsIHRoZW4gd2UgY2FuIGJlIHRoZQo+
ID4gZmlyc3QuICovwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoIShvbGQgJgo+ID4gRVJSU0VRX1NFRU4pKcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG9sZCA9Cj4gPiAwO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+
ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuCj4gPiBvbGQ7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+ID4gfcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiA+IAo+ID4gQmVjYXVzZSBubyBv
bmUgaGFzIHNlZW4gdGhhdCBlcnJvciB5ZXQgKEVSUlNFUV9TRUVOIGlzIGNsZWFyKSwgdGhlCj4g
PiB3cml0ZQo+ID4gZW5kcyB1cCBiZWluZyB0aGUgZmlyc3QgdG8gc2VlIGl0IGFuZCBpdCBnZXRz
IGJhY2sgYSAwLCBldmVuIHRob3VnaAo+ID4gdGhlCj4gPiBlcnJvciBoYXBwZW5lZCBiZWZvcmUg
dGhlIHNhbXBsZS4KPiA+IAo+ID4gVGhlIGFib3ZlIGJlaGF2aW9yIGlzIHdoYXQgd2Ugd2FudCBm
b3IgdGhlIHNhbXBsZSB0aGF0IHdlIGRvIGF0Cj4gPiBvcGVuKCkKPiA+IHRpbWUsIGJ1dCBub3Qg
d2hhdCdzIG5lZWRlZCBmb3IgdGhpcyB1c2UtY2FzZS4gV2UgbmVlZCBhIG5ldyBoZWxwZXIKPiA+
IHRoYXQKPiA+IHNhbXBsZXMgdGhlIHZhbHVlIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBpdCBoYXMg
YWxyZWFkeSBiZWVuIHNlZW46Cj4gPiAKPiA+IGVycnNlcV90IGVycnNlcV9wZWVrKGVycnNlcV90
ICplc2VxKQo+ID4gewo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBSRUFEX09OQ0UoKmVzZXEp
Owo+ID4gfQo+ID4gCj4gPiAuLi5idXQgd2UnbGwgYWxzbyBuZWVkIHRvIGZpeCB1cCBlcnJzZXFf
Y2hlY2sgdG8gaGFuZGxlIGRpZmZlcmVuY2VzCj4gPiBiZXR3ZWVuIHRoZSBTRUVOIGJpdC4KPiA+
IAo+ID4gSSdsbCBzZWUgaWYgSSBjYW4gc3BpbiB1cCBhIHBhdGNoIGZvciB0aGF0LiBTdGF5IHR1
bmVkLgo+IAo+IFRoaXMgbWF5IG5vdCBiZSBmaXhhYmxlIHdpdGggdGhlIHdheSB0aGF0IE5GUyBp
cyB0cnlpbmcgdG8gdXNlCj4gZXJyc2VxX3QuCj4gCj4gVGhlIGZ1bmRhbWVudGFsIHByb2JsZW0g
aXMgdGhhdCB3ZSBuZWVkIHRvIG1hcmsgdGhlIGVycnNlcV90IGluIHRoZQo+IG1hcHBpbmcgYXMg
U0VFTiB3aGVuIHdlIHNhbXBsZSBpdCwgdG8gZW5zdXJlIHRoYXQgYSBsYXRlciBlcnJvciBpcwo+
IHJlY29yZGVkIGFuZCBub3QgaWdub3JlZC4KPiAKPiBCdXQuLi5pZiB0aGUgZXJyb3IgaGFzbid0
IGJlZW4gcmVwb3J0ZWQgeWV0IGFuZCB3ZSBtYXJrIGl0IFNFRU4gaGVyZSwKPiBhbmQgdGhlbiBh
IGxhdGVyIGVycm9yIGRvZXNuJ3Qgb2NjdXIsIHRoZW4gYSBsYXRlciBvcGVuIHdvbid0IGhhdmUK
PiBpdHMKPiBlcnJzZXFfdCBzZXQgdG8gMCwgYW5kIHRoYXQgdW5zZWVuIGVycm9yIGNvdWxkIGJl
IGxvc3QuCj4gCj4gSXQncyBhIGJpdCBvZiBhIHBpdHk6IGFzIG9yaWdpbmFsbHkgZW52aXNpb25l
ZCwgdGhlIGVycnNlcV90Cj4gbWVjaGFuaXNtCj4gd291bGQgcHJvdmlkZSBmb3IgdGhpcyBzb3J0
IG9mIHVzZSBjYXNlLCBidXQgd2UgYWRkZWQgdGhpcyBwYXRjaCBub3QKPiBsb25nIGFmdGVyIHRo
ZSBvcmlnaW5hbCBjb2RlIHdlbnQgaW4sIGFuZCBpdCBjaGFuZ2VkIHRob3NlIHNlbWFudGljczoK
PiAKPiDCoMKgwqAgYjQ2NzhkZjE4NGIzIGVycnNlcTogQWx3YXlzIHJlcG9ydCBhIHdyaXRlYmFj
ayBlcnJvciBvbmNlCj4gCj4gSSBkb24ndCBzZWUgYSBnb29kIHdheSB0byBkbyB0aGlzIHVzaW5n
IHRoZSBjdXJyZW50IGVycnNlcV90Cj4gbWVjaGFuaXNtLAo+IGdpdmVuIHRoZXNlIGNvbXBldGlu
ZyBuZWVkcy4gSSdsbCBrZWVwIHRoaW5raW5nIGFib3V0IGl0IHRob3VnaC4KPiBNYXliZQo+IHdl
IGNvdWxkIGFkZCBzb21lIHNvcnQgb2Ygc3RvcmUgYW5kIGZvcndhcmQgbWVjaGFuaXNtIGZvciBm
c3luYyBvbgo+IE5GUz8KPiBUaGF0IGNvdWxkIGdldCByYXRoZXIgY29tcGxleCB0aG91Z2guCj4g
Cj4gQ2hlZXJzLAoKRG9lcyBSSEVMLTggaGF2ZSBjb21taXQgNmM5ODQwODNlYzI0LCAwNjQxMDlk
YjUzZWMsIGQ5NWIyNjY1MGU4NiwKZTYwMDU0MzZmNmNjLCA5NjQxZDliYzliNzUsIGFuZCBjZWE5
YmE3MjM5ZGMgYXBwbGllZD8KCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
