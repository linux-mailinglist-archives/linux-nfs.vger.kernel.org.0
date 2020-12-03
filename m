Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB2D2CE232
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 23:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgLCWyX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 17:54:23 -0500
Received: from mail-mw2nam12on2135.outbound.protection.outlook.com ([40.107.244.135]:29760
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728599AbgLCWyW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 17:54:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnIpIP7nJwzjtveLGUtsLbx9rN2IRivaKe1I9V08v03AbCmoxYbQtlJS6EluMv6AfEX+WISkGlw7nx9/X3rn2r2qRhjR93+1Cid4Pb0rMZfVMNIUzu+SEpHGCobaOtsAQ+puChrQiN3Q/WLIHB3Klo2T5oZV0PC1cWM+1NSvptHkeZ8gaRXWENqBM1atcZfhkoa3F5wBzdM08DNGGzOX2/iNJNNlbUTS2eYW6QC1y0iRUFSapdsoHvqjbl3ToGieHA2dF6aDi16/QqPGKcuiCqKmtoXNBvBM8EfgoL4/7VZitr0MvjcOHStX9WdchCJ+Ok/jDjux4X2tWgRDB5JjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdPWWFT3zVaiMYnDmPXmu/f/BeKRubVANNm7o/ODzQs=;
 b=f0a9XJqDT8aNNyr5guGEszm6BoPZVVWZU1RElKfCLCEtX57vMebHaHEBvsZ1xJJvz82zy7tot+UmhsSRH9RX/INrq5eSJKmT0ssZiU5G4YiNyz0eEIOtS0g5a8x3Zc66OAhE1HHIKpeVlgATsQaoEm1WjKjjcD65IMbJ+/ivDW1OqKfzJ8oWgUMJjWSvdMgvEngASdiLD6VomBoIq0Sr1HRPPCkAi0A7H2bicsa/Soo9/hX1XSKfF2ArBXSgJBG3jU+QMSJePbMlJh552YrwcNsrJLT8RtOWWW6G5jMpOgo+wVJEewXU0R3r2g9rFolGRGruo0JbGbuZ5db8Qp5AoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdPWWFT3zVaiMYnDmPXmu/f/BeKRubVANNm7o/ODzQs=;
 b=aAN57FZkyDM0x/YK7iMw0YqnLgvo2pnMMXPxjCp0TMT7TnB0irjzwJ4i9rF7OsHfN8sOuWvte7KekIkV8KMafLF0a5D4Fl58DW70y3GDIFCr2xAE9zyX9HJbuxkRbPBozrf3HugJwqumDQN0p4Q0vf+QTUeN0kyDiPoz50I7tSE=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3213.namprd13.prod.outlook.com (2603:10b6:208:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Thu, 3 Dec
 2020 22:53:26 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Thu, 3 Dec 2020
 22:53:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR4tJDJwAAAWCe4BeKhpLVGiQL7pUtKchSdvFeTqNAIAEhEYAgBNavQCAAAtBAIABTyGAgAxAb4CAAG0ggIAAGvSAgAAMzwCAAAXZAIAAE9IAgAACQQA=
Date:   Thu, 3 Dec 2020 22:53:26 +0000
Message-ID: <d88c69f90820bf631908cbe3d3ce34343ec672f1.camel@hammerspace.com>
References: <20201109160256.GB11144@fieldses.org>
         <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
         <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
         <20201124211522.GC7173@fieldses.org>
         <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
         <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
         <20201203185109.GB27931@fieldses.org>
         <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
         <20201203211328.GC27931@fieldses.org>
         <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
         <20201203224520.GG27931@fieldses.org>
In-Reply-To: <20201203224520.GG27931@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 371dd2d8-a5c6-4a7e-66f5-08d897de3f0f
x-ms-traffictypediagnostic: MN2PR13MB3213:
x-microsoft-antispam-prvs: <MN2PR13MB32137E6A68A784DD3D78ECA2B8F20@MN2PR13MB3213.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vpk26TCOmBYn1jn9j+f9q0MsmZB5ZfXr8619RRGdGRJdHSf8+pkRrAebfrQDE4tNzPv8HCODbvcnt9LgwFMjIl5WpJWQfEr6FUcDdFc1egdjpug7QC66iP/VvOxEZR4xL3lUbpdaiGtu3xubVUBm7ONGBODgJUDhX/ZHIWnrVQsIj8CPSdrPap5/HJ/BtE3BkyNZRuK4geGoB85omIfOEE/RY6Lbi1swBmuGhtBlaChWCchg685bIU+KjvPlcBJXGY8yhe3SSb98TLoriEp1jcTuzfqgt18TnodYt5POkUjX+EMctNwKFzDp+3CTSmbrDOlkpJZaiDOuQiMyd4bVaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(39840400004)(136003)(83380400001)(5660300002)(8936002)(86362001)(6486002)(6506007)(478600001)(36756003)(91956017)(71200400001)(6916009)(4326008)(186003)(316002)(2616005)(2906002)(54906003)(66556008)(66476007)(66946007)(8676002)(66446008)(26005)(76116006)(6512007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aE9tcm1QaE1kZS8zMmlVMmFTbVRLM0lDT0gzb2NCUnBVRjBoOHFQemVuOEtB?=
 =?utf-8?B?YWoxTzYwRXQ5VXdteEsrRzNoZXJHT214bmx3NUZPTzhvWXBsR3kzWXVBVkQy?=
 =?utf-8?B?eHpYYnlYTWlTL1JaN1ZvTCtRVkRGYUI1djloVGZxK3BHSkl4ejlNRTY4ZXZL?=
 =?utf-8?B?c1ZxajM5VkJnRHJlaGh6SW5neE8xcVFYbktNYVZPeGhmalNkZWRINWVPRENk?=
 =?utf-8?B?MEViS1BkaWx4MXcwSXZtTmRQWjBaSmdGM09VRHVEZ1RWMjV4SzJhTkppMHYx?=
 =?utf-8?B?dDNVb3Ixd2FxZmVTZmhpcThHaGRPQWlPOHFkeWdyU29mNDUrcXpqVzgwcFFu?=
 =?utf-8?B?WE8xcno1WnhEamFVUEI2UUFpN0JuOGdEbHNUcDZIeElqUEM4MWN6NlQ5a2hx?=
 =?utf-8?B?bWNvdTJmYWNmbkxPUll3dzY4Z3hyUVZPenp5Wk0vdmltYUVCc0t2bjdhVThs?=
 =?utf-8?B?T0ttYUVnZlkvWTlsTWxibXlHeFBvNzVvQVNTb203dmJvOEZsdEtXNkR2SlBO?=
 =?utf-8?B?d0s3d3lOTjBBZmUvWE9BSEpOenJjSk5IK3FkYTg4QWhMdit5REtJMWRZL2Zw?=
 =?utf-8?B?SDltYnI1RnE2eE02SG92bVNqR1JBY3JCdWJXazlxdEJXMVZJUGhITVVjWkJC?=
 =?utf-8?B?Z21QMnVsL3kzaHpPZkVJV3pONzUwNElEZTgrUVloTG5scWVUYko2S1N2N2Jl?=
 =?utf-8?B?M1U2SzhHMXJwbFF0WDVEVTdoWUlNSmF1WG5IN1VKUVFlTW44ZEdwN0cwbmk4?=
 =?utf-8?B?R1B5OU1RemxPaXQvR2FucnU2RUxhTk9KcDJ4b0N5aFZmWHBTYlo2Q2E5THdF?=
 =?utf-8?B?cmpqU1FUOENnUnBkaTZsRXRTb2VSV1draUtBYkV3dTdiQ3hVRVVldUlWaTQy?=
 =?utf-8?B?aUxlbE1YcG9sN2MwTUxpSXhHZHF6ZnM5c0RrUGFuQXNVcU1KeU45emsxWTQv?=
 =?utf-8?B?ZllTUXJma0lmWm0vYlVRQVdJazJrdXdNSkxYQXplYUhoaUJwT0hBT3ZQK3JG?=
 =?utf-8?B?V2doQzY0ZXo4dzhvcmFjSHBYQzVNZ0x2MUlwaGU5a0hlNlkvdG8rV05GWEho?=
 =?utf-8?B?Q3hXU1Ewb2xQWHZsMlVDOWxrdFZXM3B4cVBVUnd0dUNFRDlrSHUreDZSaERN?=
 =?utf-8?B?d3BWSXlQM0Z4Sm4yaVlGVk5VRG5aWlM1RmFWMGZwMHVGQ0Z4UzRpd3BRQjdP?=
 =?utf-8?B?cmZhSWhQUVUxamp2Z2pvNG9Ya2Z5bWVDTzNra1JTN00wM2RGVnBWK2ZUbFRN?=
 =?utf-8?B?V25XcmZPdzVwN0s4Ylhsd3hmQmhjUGZrS3Q2S3NnS1loMkM1WXB5citwcTIy?=
 =?utf-8?Q?zzlQl/p/ubGgFIR3s4wkNBwGEqNQnqQUaS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <95A227EAFB100A44912B106A97174AA1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371dd2d8-a5c6-4a7e-66f5-08d897de3f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 22:53:26.8477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcU5a1dzC/KFbMnNxY3R4MXCFEVZJVHdRGwXeOio8J9OMKJj5zJOCea5Whe6AccMp/zZeP9P/ycPJAzh4f1w7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3213
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDE3OjQ1IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVGh1LCBEZWMgMDMsIDIwMjAgYXQgMDk6MzQ6MjZQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IEkndmUgYmVlbiB3YW50aW5nIHN1Y2ggYSBmdW5jdGlvbiBm
b3IgcXVpdGUgYSB3aGlsZSBhbnl3YXkgaW4gb3JkZXINCj4gPiB0bw0KPiA+IGFsbG93IHRoZSBj
bGllbnQgdG8gZGV0ZWN0IHN0YXRlIGxlYWtzIChlaXRoZXIgZHVlIHRvIHNvZnQNCj4gPiB0aW1l
b3V0cywgb3INCj4gPiBkdWUgdG8gcmVvcmRlcmVkIGNsb3NlL29wZW4gb3BlcmF0aW9ucykuDQo+
IA0KPiBPbmUgc3VyZSB3YXkgdG8gZml4IGFueSBzdGF0ZSBsZWFrcyBpcyB0byByZWJvb3QgdGhl
IHNlcnZlci7CoCBUaGUNCj4gc2VydmVyDQo+IHRocm93cyBldmVyeXRoaW5nIGF3YXksIHRoZSBj
bGllbnRzIHJlY2xhaW0sIGFsbCB0aGF0J3MgbGVmdCBpcyBzdHVmZg0KPiB0aGV5IHN0aWxsIGFj
dHVhbGx5IGNhcmUgYWJvdXQuDQo+IA0KPiBJdCdzIHZlcnkgZGlzcnVwdGl2ZS4NCj4gDQo+IEJ1
dCB5b3UgY291bGQgZG8gYSBsaW1pdGVkIHZlcnNpb24gb2YgdGhhdDogdGhlIHNlcnZlciB0aHJv
d3MgYXdheQ0KPiB0aGUNCj4gc3RhdGUgZnJvbSBvbmUgY2xpZW50IChrZWVwaW5nIHRoZSB1bmRl
cmx5aW5nIGxvY2tzIG9uIHRoZSBleHBvcnRlZA0KPiBmaWxlc3lzdGVtKSwgbGV0cyB0aGUgY2xp
ZW50IGdvIHRocm91Z2ggaXRzIG5vcm1hbCByZWNsYWltIHByb2Nlc3MsDQo+IGF0DQo+IHRoZSBl
bmQgb2YgdGhhdCB0aHJvd3MgYXdheSBhbnl0aGluZyB0aGF0IHdhc24ndCByZWNsYWltZWQuwqAg
VGhlIG9ubHkNCj4gZGVsYXkgaXMgdG8gYW55b25lIHRyeWluZyB0byBhY3F1aXJlIG5ldyBsb2Nr
cyB0aGF0IGNvbmZsaWN0IHdpdGgNCj4gdGhhdA0KPiBzZXQgb2YgbG9ja3MsIGFuZCBvbmx5IGZv
ciBhcyBsb25nIGFzIGl0IHRha2VzIGZvciB0aGUgb25lIGNsaWVudCB0bw0KPiByZWNsYWltLg0K
DQpPbmUgY291bGQgZG8gdGhhdCwgYnV0IHRoYXQgcmVxdWlyZXMgdGhlIGV4aXN0ZW5jZSBvZiBh
IHF1aWVzY2VudA0KcGVyaW9kIHdoZXJlIHRoZSBjbGllbnQgaG9sZHMgbm8gc3RhdGUgYXQgYWxs
IG9uIHRoZSBzZXJ2ZXIuIFRoZXJlIGFyZQ0KZGVmaW5pdGVseSBjYXNlcyB3aGVyZSB0aGF0IGlz
IG5vdCBhbiBvcHRpb24uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
