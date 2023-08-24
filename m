Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76E27875C6
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjHXQn5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242788AbjHXQnY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 12:43:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2098.outbound.protection.outlook.com [40.107.244.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA8C1FD3
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 09:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtTXPjvhyz3oCco5bzT4DhXT4+86pCUFx3NCTrIyF29URg6L5Sj6wTx+EKf4S17ocvLHYgHiMG5cYnC6IRV8th7k991ZCmVICYUJGL9JjyHd/aTkpfdFiQX2tS8DL2DJeqKLlQCtLFz7o+J1KU8wKaOZjgtSdDpJMz2zdurSuONLA7iycFhKWhhKSYH3qr8kY8R9Z41y6seokwmKEBHfWlZC7aEtD+NUtzS+1EXzOWixye6zoLorwzj3ITa/4a8DBxSX2jhxi4FXe4nshT2xpMMXJwKFjpywdFug1ROuxpYiklTMojq5eby5ee3vKpcXqyzkc9j7W5ledQeAdVqwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/Q2yF2/0f81cyVz0j8lmBLO4hep/sVVvvN9Ywsakuw=;
 b=RYDJWcBMCBn968ahWMzPV28vpE9NX0Svu2m63NQ9GqMklnCErO7LCHpcVa0+CEK53XnbjNbbw51whV+4JVieZwW6B2sZWqBLOTUvotzT0rmLCQnKKhRxAuQls8+hei2N6r6oUByW/ZmbhEfaaoYWJpNSe7vc9Gd5nxPeRYXYaFsT9zyF78BEG+j9FX9giTIzHE488DlWWR30j47Tb8c0OoeHcN1ieCEBxOIJRdjy0GEWI6aXlwWKWA95IGpyVOkDkSyx8uFTQl/uFl+7Xxe56dMQLrONtruiWJZ+RMwppv5ri6bUSvWj0C+9QPe3KYO5ccsGoWu5nmk69sdu2plA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/Q2yF2/0f81cyVz0j8lmBLO4hep/sVVvvN9Ywsakuw=;
 b=OEHZPXpIROJzeULn9Hcl1kyHSoJ3MEfJqBR2Iizopz8am2h5EblMvnU08aYhXJ5s22XDHejyl+c45iFiZ993gotWN9XSQUhVe7Lv4QmLhPDKt15Z4o25u5rSm/0O/irYiZnd7QkvCASYfG8erepES8NbXBVyDvqf3fQM1OSW0H4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5849.namprd13.prod.outlook.com (2603:10b6:510:171::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:42:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:42:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSv4.1: fix pnfs MDS=DS session trunking
Thread-Topic: [PATCH v2 1/1] NFSv4.1: fix pnfs MDS=DS session trunking
Thread-Index: AQHZ1qdxYBBka0rcWEGtrK5rv4xzv6/5pquA
Date:   Thu, 24 Aug 2023 16:42:38 +0000
Message-ID: <7edc85a1a05fdcd1987d16ed873e64023490df7a.camel@hammerspace.com>
References: <20230824162416.17482-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20230824162416.17482-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5849:EE_
x-ms-office365-filtering-correlation-id: 8888f4d8-346f-40fa-b5d8-08dba4c1207d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v72tw9TF67uUTMGxD7cpbQ7TkGxtteQcqLtyCL2OHpHIf3xLWMHj0gYL0ObzU5HkdsVYVsVxAM8TnDTIw5+gIVUGs0rXss82+PQVQBT5kRgEdaEz+RzJuHXEFV6GwSp/b3fbwKZBaUbyoBg90k+fJSADgEFBRkVYf8b4JhMGI0Z8wmEfv91kKTROFPLP/gbNVAb16dvxDanMhZbbKqTMuE8WsTaVV0dCby0OzwtNorXAI1B2E+1IM1EkdD00s5PaFNRD7CieqT2iM4eQjZvHkTMmPcenLvIWtQfOTIm6K8q79RynHli3qEiakRo8KGUlefwIC5gD64wFLYYc52ranu98ICPYOMqH0aPjGmaenZ/YmZ7itdwtNhEd7UeCOUnkx3OOQJa+CMuPhaGaRuK/+UWZYKLPemSo1RlmZXTUkl/N6WeDqf2qU1OnO436RwIUnb/8pmLZ3+jRBl4XIVzU+HP7eFX4qvmd0mY1nRlqrReRfurvPPTGun0/uirTOiy8Hmj8EeEl4yYh1wLMClZpwmOoSZ3jNmuB2TqO4LkexTmt4oTc6nAkMltsMYeEdIcAdarAYGdnYxFl67CobjRScR0GNJgldzgpgqAq15hFI6eh9VI1hYyMY65y62RyLPpcfvqWde9uC7JLdFzo2OnM7XkyPXyKtQG9+gS2uDAspP7N11KnD6fzAdtHbMGJpoa6RyIn7p5urn4NvUdNZKQ1xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39840400004)(346002)(396003)(376002)(1800799009)(186009)(451199024)(122000001)(6486002)(71200400001)(2616005)(316002)(6506007)(5660300002)(6512007)(15974865002)(86362001)(41300700001)(36756003)(76116006)(110136005)(66476007)(64756008)(66446008)(66556008)(66946007)(26005)(38070700005)(38100700002)(83380400001)(478600001)(12101799020)(966005)(8676002)(4326008)(8936002)(2906002)(18886075002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWhSd0NhOVZDWkUvV2s1SFFESDA3UlVCdHBKZUJNUWF3TVliV3owaFhjQWRV?=
 =?utf-8?B?NndBRkorTFo2YzdTS1FkNmh5Z1dpL1ZTSzhUTjcrZ2dQQVNkY3doZm40cnMz?=
 =?utf-8?B?VUNFMjRuYU5qZGQrL3RITEQvTlZDbGNWU2tkY2w4ZTJLZXpxczQ3NTIxSGdv?=
 =?utf-8?B?dmFYTk9DUFVjOFRBenNMZ0pUc0REZkUvL2ZXanZBbzJwM21BdVA0SFd1dTdT?=
 =?utf-8?B?b2RESHdCQWM0eTcwckVJUWc4dWhpUXFTVSthRmdjaDN3TCt5MCtJa2Rwd0do?=
 =?utf-8?B?VmFvQk9FQytWZ0JqRGpncW9yYmIrcDhISHlsYWtpWmFEeWlrT2gySnNEaERO?=
 =?utf-8?B?c1VJc2ZDRUd4NkV6R2hhZXlXNWZmc2F5VmVZcjdRSXFzVitTdWQ2VG5Lem1w?=
 =?utf-8?B?YWhhMS9rSnB4S1dqekVwUXphNWdXQzBZOU9CY256dkJ6cGJxdmFZSUpleUFI?=
 =?utf-8?B?eDBPMlB0OVFUcjQ4cmRsQVpXTzJaOTNBdXJReDY4T1lydWlkL0tkbnR2aGt6?=
 =?utf-8?B?QythQUJ2RitKUWZHUStvcGRlZkRmbVhadE9OMjZaWGYrYWZTSGZaOXcySW9o?=
 =?utf-8?B?YW93cWlxeTVpSHZYWkpqWmxmbld3VVFzS2hTOWtDY1hZY3FEQ2F0NHBCMUph?=
 =?utf-8?B?T1NwWWtRSVZFRVVkR2xBT2Fzb2F2b2pJNE92MEhMY1VsMk41bU9COUVhNzFj?=
 =?utf-8?B?bk1WRG9sRzY3ZTJvQ3BTV0lxTis2ai9kQzhZQzAyZFFaLzVnNFJZRU9JZk9S?=
 =?utf-8?B?bTJSYk9JeUFlUzFtU1pPR21qRXlTcWQ4WmRPR2ZDcVdScEUvM3l3OW9WMzJ4?=
 =?utf-8?B?SlUwQWFpOG80VW1ycFp0aXJtYkt6MEZ3Z2F6Uk5YT0orZElReVJhZ1VrY2du?=
 =?utf-8?B?WkRXeVdDTDNKbnJxT3M0OVIydWxDMzF1L2l2V09SUWRHKzU0aXdVUkNVVEtk?=
 =?utf-8?B?eXVRZnplL0pxZnpITy9TUEw0UGFCdXY4QVhleTZ6S3FldFVZMGQwekN3R21R?=
 =?utf-8?B?UURzQlVydmlUdjJrOVRVbmlDbE9GbUF3djMzcnVBYlowOThNNzFjUnJSTDlU?=
 =?utf-8?B?TlEyL1NYZGFEeTFtaWIzK3M0WEVncXJEclFSZVVyNW9LeWZYbHJhekZXRVdQ?=
 =?utf-8?B?azc5U21zdENFNWNTc09meE9JQkVyU3ptU002b2tnL25tQWhZRGJweU5nc0pT?=
 =?utf-8?B?MDh2QTg2M09jVEdia1BybWhKU05NV3dzWFR6RUQyL0REYVFuTXNLd284by9O?=
 =?utf-8?B?cy9zSUFRQlpaeUdQSHloZDVuNU1rV1hjRi9xdEliV1UwWi82QVI0MFQ2eVp3?=
 =?utf-8?B?RHZCcWltcXowdVkwb2JTZjRpOE9Wci9zUjdFMjlLam82MjdTNFJGcVlBbjYx?=
 =?utf-8?B?cEc5SnlQR3VkSnRwK2pqLzQxQW5zdzhTOWF5RUkzREVVTmlzWU13NkZYWFZY?=
 =?utf-8?B?RnlSUzREUW52QVJmK29rdTNMUmZEMS82UGg2RlM4QUFYV2hHOTM2dTZiS1p4?=
 =?utf-8?B?YlU3MFBNL0MxcWJLeFhiaExGTkk0VXFIU0pqdlVvVDJidEFpSHhSNVdxMVZk?=
 =?utf-8?B?cG9yVFRaRzFzYWpYdTBVSXlDdnBacVljNm5VM09vWjlvSmVta2hYUFVMY1N1?=
 =?utf-8?B?YkRzeElrMkZKa0dDWlNIS0d5d3RreXZZZnRMTmxmNG9KeXNMK2xRakR3MEll?=
 =?utf-8?B?VUdDaExQVjMxcms4OTN6TjhUcVJtam1OeUZva1lLV2hsbEhvRWR6QjRKQ3R6?=
 =?utf-8?B?Ui91bUEwT0VhSFdrMDMzQzhhVTJ2Wk9KWWpFaGVCUjdrTWM3V1lvTlVwaDVy?=
 =?utf-8?B?WFBQK3JrcThCV212dC9wcjMzZEErSHJFZ0RtVVJibFgvc0RDSEtIVzAwZkYz?=
 =?utf-8?B?VUtydHZ2VDdOY3hhUFV2MVRVZHNLRWgyRCtVSzMrcW5XMER3aWpCZnNrUDhT?=
 =?utf-8?B?d3Q1cnFsWFpuTW54dngwTXlweTIzcm9VdDI3V3pHcjFXN05qQnpEKzhuZHht?=
 =?utf-8?B?WjFMa0oyem9id0ZwUTZWU3BFdjJGRW01eFk3VHZ2UGQyVFVvVFhIYnl1dEEx?=
 =?utf-8?B?bWtnQnI0ZFUvWXhmL2xYekdpSmJKQVg5TXY2bWlNb1g2QmZ0WWhkZTRlTU1S?=
 =?utf-8?B?ZUhIekN0OVdad3JaRDFyVGJ2SjVieWFnNW4wUXBHVjd5R1JGTi9WUlk1M1kr?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B2CF662684F67468B0361E2FB7E3A23@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8888f4d8-346f-40fa-b5d8-08dba4c1207d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 16:42:38.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WKF9bNnf8QoVlGjPNXlt9YMyxje1oTeUZhuomzuhjMq1vq55cVAU9anSDJ0fyjk3Lb6g0J6b0ijvQTqb+UeOsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTI0IGF0IDEyOjI0IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToKPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4KPiAKPiBDdXJy
ZW50bHksIHdoZW4gR0VUREVWSUNFSU5GTyByZXR1cm5zIG11bHRpcGxlIGxvY2F0aW9ucyB3aGVy
ZSBlYWNoCj4gaXMgYSBkaWZmZXJlbnQgSVAgYnV0IHRoZSBzZXJ2ZXIncyBpZGVudGl0eSBpcyBz
YW1lIGFzIE1EUywgdGhlbgo+IG5mczRfc2V0X2RzX2NsaWVudCgpIGZpbmRzIHRoZSBleGlzdGlu
ZyBuZnNfY2xpZW50IHN0cnVjdHVyZSB3aGljaAo+IGhhcyB0aGUgTURTJ3MgbWF4X2Nvbm5lY3Qg
dmFsdWUgKGFuZCBpZiBpdCdzIDEpLCB0aGVuIHRoZSAxc3QgSVAKPiBvbiB0aGUgRFMncyBsaXN0
IHdpbGwgZ2V0IGRyb3BwZWQgZHVlIHRvIE1EUyB0cnVua2luZyBydWxlcy4gT3RoZXIKPiBJUHMg
d291bGQgYmUgYWRkZWQgYXMgdGhleSBmYWxsIHVuZGVyIHRoZSBwbmZzIHRydW5raW5nIHJ1bGVz
Lgo+IAo+IEluc3RlYWQsIHRoaXMgcGF0Y2ggcHJwb3NlZCB0byB0cmVhdCBNRFM9RFMgYXMgRFMg
dHJ1bmtpbmcgYW5kCj4gbWFrZSBzdXJlIHRoYXQgTURTJ3MgbWF4X2Nvbm5lY3QgbGltaXQgZG9l
cyBub3QgYXBwbHkgdG8gdGhlCj4gMXN0IElQIHJldHVybmVkIGluIHRoZSBHRVRERVZJQ0VJTkZP
IGxpc3QuCj4gCj4gU2lnbmVkLW9mZi1ieTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFw
cC5jb20+Cj4gLS0tCj4gwqBmcy9uZnMvbmZzNGNsaWVudC5jIHwgNyArKysrKystCj4gwqBuZXQv
c3VucnBjL2NsbnQuY8KgwqAgfCA5ICsrKysrKy0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZz
NGNsaWVudC5jIGIvZnMvbmZzL25mczRjbGllbnQuYwo+IGluZGV4IDI3ZmIyNTU2N2NlNy4uYjM1
YWNkNzliODk1IDEwMDY0NAo+IC0tLSBhL2ZzL25mcy9uZnM0Y2xpZW50LmMKPiArKysgYi9mcy9u
ZnMvbmZzNGNsaWVudC5jCj4gQEAgLTQxNyw2ICs0MTcsNyBAQCBzdGF0aWMgdm9pZCBuZnM0X2Fk
ZF90cnVuayhzdHJ1Y3QgbmZzX2NsaWVudAo+ICpjbHAsIHN0cnVjdCBuZnNfY2xpZW50ICpvbGQp
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubmV0ID0gb2xkLT5jbF9uZXQsCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc2VydmVybmFtZSA9IG9sZC0+Y2xfaG9z
dG5hbWUsCj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gK8KgwqDCoMKgwqDCoMKgaW50IG1heF9jb25u
ZWN0ID0gb2xkLT5jbF9tYXhfY29ubmVjdDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoY2xw
LT5jbF9wcm90byAhPSBvbGQtPmNsX3Byb3RvKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuOwo+IEBAIC00MjgsOSArNDI5LDEyIEBAIHN0YXRpYyB2b2lkIG5mczRfYWRk
X3RydW5rKHN0cnVjdCBuZnNfY2xpZW50Cj4gKmNscCwgc3RydWN0IG5mc19jbGllbnQgKm9sZCkK
PiDCoAo+IMKgwqDCoMKgwqDCoMKgwqB4cHJ0X2FyZ3MuZHN0YWRkciA9IGNscF9zYXA7Cj4gwqDC
oMKgwqDCoMKgwqDCoHhwcnRfYXJncy5hZGRybGVuID0gY2xwX3NhbGVuOwo+ICvCoMKgwqDCoMKg
wqDCoGlmIChjbHAtPmNsX21heF9jb25uZWN0ICE9IG9sZC0+Y2xfbWF4X2Nvbm5lY3QgJiYKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdGVzdF9iaXQoTkZTX0NTX0RTLCAmY2xwLT5jbF9mbGFncykp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1heF9jb25uZWN0ID0gY2xwLT5jbF9t
YXhfY29ubmVjdDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBycGNfY2xudF9hZGRfeHBydChvbGQt
PmNsX3JwY2NsaWVudCwgJnhwcnRfYXJncywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY19jbG50X3Rlc3RfYW5kX2FkZF94cHJ0LCBOVUxMKTsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY19j
bG50X3Rlc3RfYW5kX2FkZF94cHJ0LCAmbWF4X2Nvbm5lY3QpOwoKSW5zdGVhZCBvZiB1c2luZyBy
cGNfY2xudF9hZGRfeHBydCgpIHRvIHNldCB0cmFuc3BvcnQgcGFyYW1ldGVycyBhZnRlcgp0aGUg
ZmFjdCwgY2FuIHdlIHBsZWFzZSBpbnN0ZWFkIGp1c3QgYWRkIHRoZXNlIHBhcmFtZXRlcnMgdG8g
dGhlIHN0cnVjdApycGNfY3JlYXRlX2FyZ3Mvc3RydWN0IHhwcnRfY3JlYXRlPyBQbGVhc2Ugc2Vl
IHRoZSBmb2xsb3dpbmcgcGF0Y2ggaW4KbXkgdGVzdGluZyBicmFuY2gKaHR0cHM6Ly9naXQubGlu
dXgtbmZzLm9yZy8/cD10cm9uZG15L2xpbnV4LW5mcy5naXQ7YT1jb21taXRkaWZmO2g9ZDFmYjY3
OWQxZGZmMGFlOWUxMThkMzM4MGMwZjU5MjdjZDI3OWVmZQoKPiDCoH0KPiDCoAo+IMKgLyoqCj4g
QEAgLTEwMTAsNiArMTAxNCw3IEBAIHN0cnVjdCBuZnNfY2xpZW50ICpuZnM0X3NldF9kc19jbGll
bnQoc3RydWN0Cj4gbmZzX3NlcnZlciAqbWRzX3NydiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoF9fc2V0X2JpdChORlNfQ1NfTk9SRVNWUE9SVCwgJmNsX2luaXQuaW5pdF9mbGFn
cyk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgX19zZXRfYml0KE5GU19DU19EUywgJmNsX2luaXQu
aW5pdF9mbGFncyk7Cj4gK8KgwqDCoMKgwqDCoMKgY2xfaW5pdC5tYXhfY29ubmVjdCA9IE5GU19N
QVhfVFJBTlNQT1JUUzsKPiDCoMKgwqDCoMKgwqDCoMKgLyoKPiDCoMKgwqDCoMKgwqDCoMKgICog
U2V0IGFuIGF1dGhmbGF2b3IgZXF1dWFsIHRvIHRoZSBNRFMgdmFsdWUuIFVzZSB0aGUgTURTCj4g
bmZzX2NsaWVudAo+IMKgwqDCoMKgwqDCoMKgwqAgKiBjbF9pcGFkZHIgc28gYXMgdG8gdXNlIHRo
ZSBzYW1lIEVYQ0hBTkdFX0lEIGNvX293bmVyaWQgYXMKPiB0aGUgTURTCj4gZGlmZiAtLWdpdCBh
L25ldC9zdW5ycGMvY2xudC5jIGIvbmV0L3N1bnJwYy9jbG50LmMKPiBpbmRleCBkN2M2OTdhZjM3
NjIuLjMyNWRhZDIwYTkyNCAxMDA2NDQKPiAtLS0gYS9uZXQvc3VucnBjL2NsbnQuYwo+ICsrKyBi
L25ldC9zdW5ycGMvY2xudC5jCj4gQEAgLTI5MDQsMTYgKzI5MDQsMTkgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBycGNfY2FsbF9vcHMKPiBycGNfY2JfYWRkX3hwcnRfY2FsbF9vcHMgPSB7Cj4gwqAg
KiBAY2xudDogcG9pbnRlciB0byBzdHJ1Y3QgcnBjX2NsbnQKPiDCoCAqIEB4cHM6IHBvaW50ZXIg
dG8gc3RydWN0IHJwY194cHJ0X3N3aXRjaCwKPiDCoCAqIEB4cHJ0OiBwb2ludGVyIHN0cnVjdCBy
cGNfeHBydAo+IC0gKiBAZHVtbXk6IHVudXNlZAo+ICsgKiBAaW5fbWF4X2Nvbm5lY3Q6IHBvaW50
ZXIgdG8gdGhlIG1heF9jb25uZWN0IHZhbHVlIGZvciB0aGUgcGFzc2VkCj4gaW4geHBydCB0cmFu
c3BvcnQKPiDCoCAqLwo+IMKgaW50IHJwY19jbG50X3Rlc3RfYW5kX2FkZF94cHJ0KHN0cnVjdCBy
cGNfY2xudCAqY2xudCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBy
cGNfeHBydF9zd2l0Y2ggKnhwcywgc3RydWN0IHJwY194cHJ0ICp4cHJ0LAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB2b2lkICpkdW1teSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgdm9pZCAqaW5fbWF4X2Nvbm5lY3QpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCBycGNfY2JfYWRkX3hwcnRfY2FsbGRhdGEgKmRhdGE7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCBycGNfdGFzayAqdGFzazsKPiArwqDCoMKgwqDCoMKgwqBpbnQgbWF4X2Nvbm5lY3QgPSBj
bG50LT5jbF9tYXhfY29ubmVjdDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlmICh4cHMtPnhwc19u
dW5pcXVlX2Rlc3RhZGRyX3hwcnRzICsgMSA+IGNsbnQtCj4gPmNsX21heF9jb25uZWN0KSB7Cj4g
K8KgwqDCoMKgwqDCoMKgaWYgKGluX21heF9jb25uZWN0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBtYXhfY29ubmVjdCA9ICooaW50ICopaW5fbWF4X2Nvbm5lY3Q7Cj4gK8KgwqDC
oMKgwqDCoMKgaWYgKHhwcy0+eHBzX251bmlxdWVfZGVzdGFkZHJfeHBydHMgKyAxID4gbWF4X2Nv
bm5lY3QpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjdV9yZWFkX2xvY2so
KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX3dhcm4oIlNVTlJQQzogcmVh
Y2hlZCBtYXggYWxsb3dlZCBudW1iZXIgKCVkKSBkaWQKPiBub3QgYWRkICIKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAidHJhbnNwb3J0IHRvIHNlcnZl
cjogJXNcbiIsIGNsbnQtCj4gPmNsX21heF9jb25uZWN0LAoKLS0gClRyb25kIE15a2xlYnVzdCAK
Q1RPLCBIYW1tZXJzcGFjZSBJbmMgCjE5MDAgUyBOb3Jmb2xrIFN0LCBTdWl0ZSAzNTAgLSAjNDUg
ClNhbiBNYXRlbywgQ0EgOTQ0MDMgCuKAiwp3d3cuaGFtbWVyc3BhY2UuY29tCg==
