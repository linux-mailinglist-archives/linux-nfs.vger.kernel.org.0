Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6648389F
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 22:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiACVpt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 16:45:49 -0500
Received: from mail-bn8nam12on2129.outbound.protection.outlook.com ([40.107.237.129]:57121
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbiACVpt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jan 2022 16:45:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcfyV0weRtmcniEs/mXE7S+aPXxONS7H7zZR6Y16UKkSJAnXK8GJrVwN0XoDRQX1V75EiW1EqIuYZLUcNaC+jVnzEZHm1VoAsGWbuQwYNzA1ZEt/KfmxNuJgCuCfdlwZANQSjMPqla0fNcHXtg12x3tAtcjb4717TVG6J2Til4V2K/m6X26Jp2QCIodlYR6KqkvG4IQSF/tHzOa5aBbigVuoix3xyz9n2Lg/SBC6asWvrin7kfJgwg9DJVjspDo/7e8cd1XVjjg+/biHgickoDr0eK+j45jWuNK0ISe/QfwGNCmz/DcPUNQa/vtFBsBRVtzpFYaHghVmRji+CGP7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kqtFiYjOKBE6GUJzbVd6lpC0HR7Z9OEKZFvPyqhyAA=;
 b=naUBxhAYvj9hveREbmDYQGERspkhaNJt1Zn2G9dhsCJ3GZRAREyNWPtfrZBuAYEh/3loGIxF1k4r7e0MTv+dyDBVywlCHUD/9SnbYaPli5MO649KreZ5l8kUfrGFE6156eRkCPDOqlQS8By/Axn0uYzsYzbbi0BRKY0VmG7TUjwTZ8bGm4fJEKG7xJ3iuGrgQeORt3C/QlhUAtS/oDzF93SIPlutXRQLKfMVDh82/Ratj7RbxAbgVlmYi6Ep505YkoOntqzbN+xvkkvQ23bXEZ0I5ykmkAo9e34zFUtEvhEQ+hscwruGjlocZrkcXuQTkTQGWcWtBAI886hcHyGGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kqtFiYjOKBE6GUJzbVd6lpC0HR7Z9OEKZFvPyqhyAA=;
 b=ce8FbVPFNNrbHkpFlo6RPhS4XxNsff9UEv1ahU0LAqxTI+cG4Jg0WRBIiA8a1aCKD5lKl+8ZDUQAecnp7TosXVQZbI1tueDuWlVLJGmU+7W6XtFazNJo/9XEIZfmn3BGlVfAMWyIEA7y6NWzDmBmmuRb//IVqrE8ebG0vw4gIDo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM4PR13MB5907.namprd13.prod.outlook.com (2603:10b6:8:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.4; Mon, 3 Jan
 2022 21:45:46 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.006; Mon, 3 Jan 2022
 21:45:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "lists@doriantaylor.com" <lists@doriantaylor.com>
Subject: Re: GSSAPI as it relates to NFS
Thread-Topic: GSSAPI as it relates to NFS
Thread-Index: AQHX+ExsM09K69j28kCAisa0ppoQ0KxB5tIAgAAdtgCAAc9bgIAODlWAgAADsoA=
Date:   Mon, 3 Jan 2022 21:45:45 +0000
Message-ID: <1a7193c740c8cb7ba94ecfb5d5eedd32af37088c.camel@hammerspace.com>
References: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
         <48DBBF53-7CE3-4DDA-B697-B14F8C382E78@oracle.com>
         <AF7243DE-250E-4CCB-86C0-40C69BB71C88@doriantaylor.com>
         <9DA49FE9-F4AF-44CC-8BCF-86F4D2D984AA@oracle.com>
         <20220103213229.GL21514@fieldses.org>
In-Reply-To: <20220103213229.GL21514@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b30a0723-f291-4393-8af0-08d9cf02661b
x-ms-traffictypediagnostic: DM4PR13MB5907:EE_
x-microsoft-antispam-prvs: <DM4PR13MB59072390B6561EE6DDC801FCB8499@DM4PR13MB5907.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fn3ltFPRb9nXkgd/TraqcIVOFftr61HcmEy5T4vs2C+dJh3GS0/yh4AognJWsW2RHkbjootoHr0uXVOZxXtOSyrZqQgMTB8GWNbAUMUQahNXVffT34fnrq+FMlH+P/DbkPbOnu6eXbApcjiaA0WGOmqy8V/I2cy32yp6nrbywQNRNdfwTp08rWXuNEu6XnNkW4nDwv5S93ehXC+moZYAWLt6IGD7zizqWNw68h/4yRVCO9Fz8OtxsexRogw7C6LCudK5WSI8VLUHe9TsVw3bRr/V4nz15ni7grEAB2890E9rUrgBSXDNF2hka1wPSfuehvQzvFcQgM8GdbmSHMvlum+wC1NyLp/4nychU6vLP6rA6P9lQ2oioyk5HGFPeQSldE8fGYhLQEN40diGAdPNlqjs0HYahqNXOJFaYXN6hS5QAq040VGj9MkiyDvrncRmzr18C6OpOS1J+qH6J605EHvYyrEbtnMkDat/a+Dp9DVIDwVeDcap1waQJb1FTaNlNgEyq2sAkup8vRAmw0OFtATZADKGM3vbbHe7Rkhm0WzjpuI1qT0n9ISAfJ5pesJFIlTyauLyymEjzFQHG+CHz7LW1NZ4bTIfgFC/B8z9iICwNkHZe8rEo/SFj0Gy0zchd+5mxa/PHqBlQu8NMNNi93IiFqdcJhM9pQXh5IL6hgDJ8rX3kJ5d5UmtPO575+AL54+TaoMC9DIafGEtH0uh7pgz6wMAjGa6j34H27Ez6YqoG8R6ocp5cnmZMAu6tXc428RJc0l/VA5kZgjBy4iLNk7hzkgA8BjhIB0n5hH3u2k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(366004)(396003)(136003)(346002)(39830400003)(6486002)(6506007)(71200400001)(66446008)(966005)(186003)(508600001)(2616005)(66556008)(6512007)(64756008)(66476007)(26005)(86362001)(4326008)(8676002)(66946007)(8936002)(36756003)(38100700002)(38070700005)(5660300002)(122000001)(316002)(2906002)(54906003)(110136005)(76116006)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnUzNFZ1QXdlemRHUWJyUG9wNGo2eSs2ZGIxQnlFVDM4RE9QclB3dndzdEJZ?=
 =?utf-8?B?c3NEZFFuSGFTZXJScmRBT0JqSlY0WEw5RnNwVWZqc0ZYWUFtV3JvUmVZWWYx?=
 =?utf-8?B?OGhqMFI3b1ZuMU44a2FSeFpYa0o2NkMvR3d6a1RCdnlMVWxWZTloZDdYM3k2?=
 =?utf-8?B?cjZtanRsOU5ZTFFMWE8zb0VjS21HZ2VRVG5ud2lqZWpoMTBiVFJrcUx6eHZn?=
 =?utf-8?B?NWx4aTEzVlR3aUE4ZWx3ZFl1OUZsVjNsSmsvRjczSmowRzJjRlZpSmJtYTFO?=
 =?utf-8?B?QWcrL1pyV1Z5YzcxeXJpTXNJM2V2SVdORStEOEg1Y1FCUWx5RERwd2twc1ZZ?=
 =?utf-8?B?aVlhK05nNTkxczMrdlljSzdtZmJFNUNWL0NMZFQrbGJrNEJzVk5XeEZNbDM2?=
 =?utf-8?B?VTdXSi9uOUVLeG9ZMmJFQzFvbWtOcTNiUkY3djVOTDl5WUVwRUNONmJsWldY?=
 =?utf-8?B?a25uNjZwV3VQeWlNYW9RV1BhR0RvMld5NWM0MkVzSWs1Y2gyMHhjSVlpeFFW?=
 =?utf-8?B?UWc5dXZVQU1TUTJseUYybm1WaGc0WjY5dnhNV0ZzUHRHRHZBWmNIVU1qaGFz?=
 =?utf-8?B?N2xjSmxpMnJaNkpRTjY0dDlucTRVNTBWNStVNm85WGVYeW0waDFhMVoyQjNX?=
 =?utf-8?B?bVd0KzlmWTBISW5Mam4vR29LQk41dmNYcGZLUm5Qbmlic2V5QjBEZTRaeDB1?=
 =?utf-8?B?VjRYdFc0c3k5WWN0QmtBMXl0ZndwNE1TQ3N2RU9iWTNJNVNlZnljT0twZWNu?=
 =?utf-8?B?WFdCc2VXSG9yR3liVmw4bDNwYWpHSnNYR2ZMVVBVMWlvZnV5NEFTVkYzejMy?=
 =?utf-8?B?djhHTVBMMmV3Y0tXQnVOWUxyK3lROVdjd3VNQldycjZZWFV2ZVNiWm9uQWNo?=
 =?utf-8?B?em5wS2ljYjg5Zjk3Q1dUSkpwcTNDMk11TjJJeGtSTzF5TXlRdlAwSXR1blU2?=
 =?utf-8?B?VnlsSjhsNG55V29vOE0yb2wrdkxWc0tGRUpieHhjaC9SclZ2NDJMeGdKbExa?=
 =?utf-8?B?Y3QvRktKWXE2eVUyeDRueVBJVlhEazNlUEdJL0wvbUFGcHdVUFY3T1VxazZ1?=
 =?utf-8?B?U2RTNHlxdHo1ajltSmlrMVlJdWh5TW5lV2lVSjdPMTFucGdCc093Q0czS3cy?=
 =?utf-8?B?Ly9FMXk0UVlacWRiV054QmdMbWE0aVRxWkw1cDduSDZVU1RjZzBoZ20zeTlz?=
 =?utf-8?B?SXZNVWhhc0pOaTF4VHN5aUFZUzVMQVZpbVUvTDVyb2F1SzdiWnVTb0U3c013?=
 =?utf-8?B?cHFObmcxeWhMNSsyTjJOL2J2RXZ2c2lCbjZkempWTFBBVWlaUUt3ZHRTSDNX?=
 =?utf-8?B?WWc1WkxMRi84TnNtSk4xMWlSaDZMSnU1ZE9mbzlhdG5CQm9MNmQ5cVZET1RM?=
 =?utf-8?B?Z24xNnlOSFBZVGxMazQ3dGF3NUE1L2h0cnkwMGFNT0lYaTRjcFRJRTR6Nml5?=
 =?utf-8?B?blI4ZDV4OHB0akhPc0E0WHZ2QmhCeTFRdXkzcHZmUEg3QjNob1k3NjlVcktp?=
 =?utf-8?B?cGw2TFExejVQbXdMTlkwS0tXbWVSdmpFbzhMbXBEZVhFOG5Ubk9FTHpFc3Jz?=
 =?utf-8?B?Q2xxWkZGSlJJRzYwRklKbHlaSjBhODNiLzlKbGV2anNZSEluczllM3NGdTFk?=
 =?utf-8?B?d3NHU05aLzBrNklYZXZaYlRsMGxINXRMWEVhdEhxZmlOR0IxMXBqRmVYdjBS?=
 =?utf-8?B?NW1rSGVCa3NKaHlRa2x6bGVhZkU5YnhCb01mdyttSW9sVS8vSUtjTzZLWDFz?=
 =?utf-8?B?a1d2YlpqdTROQ1F0c0VqTGJjRWJOQmNvcW5zc0hSYTZjdGRSWlVaVkE1MFNO?=
 =?utf-8?B?U0VqR21mZENYb2VlMmduSC9waFBudERoZFJ3eUlhM1JMblB1akptRW5ocDRY?=
 =?utf-8?B?NXZ6bUFoRXR6cWtwSVQ3aitZY3p1QjBiWTJPYVVpc1JZTW90ME1adGl5SjNU?=
 =?utf-8?B?amNRQXJVbG1UeHFVSGlDOWk4NXZuSUpzRkFlRkVmMytqZEM3QTRibHNCTTRO?=
 =?utf-8?B?YjdCS0tET2dyZWVKcEQ3SWZNd3A5ZTlMem91VW5kMXVJbkxIRGZWbnlhQ2xH?=
 =?utf-8?B?bU9kMGpIV2ttV0hsUmQ0US9DZVRSZDg1bTlUNnZQMHc3MVR1MVVjSEo5aFdM?=
 =?utf-8?B?TEVkR1hlMW1CSXROUVNBbnJZL0J4Y1hKSERiU3VLaFhyS1E1Z3A2TThtRlFP?=
 =?utf-8?Q?9vzNIPYxaoeueM6lIF64mlQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDB38DFFA9413245B5D48AB12186C69A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30a0723-f291-4393-8af0-08d9cf02661b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 21:45:45.8187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bX5wNkLS6pdwVVrdRrXgmTNwIF3vkgS+LTf2zughj4PShH7UG9698Rd2peoeicOa7V6BgqA4sMyRkBQv8F3qEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR13MB5907
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTAzIGF0IDE2OjMyIC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFNhdCwgRGVjIDI1LCAyMDIxIGF0IDEwOjUzOjMzUE0gKzAwMDAsIENodWNrIExldmVy
IElJSSB3cm90ZToNCj4gPiBJSVJDIExpbnV4IHJlcXVpcmVzIHRoYXQgYSBtb3VudCBvcGVyYXRp
b24gYmUgZG9uZSBieSByb290LiBJZiB5b3UNCj4gPiBydW4NCj4gPiBnc3NkIHdpdGggIi1uIiwg
YmVjb21lIHJvb3QsIHRoZW4ga2luaXQgYXMgeW91cnNlbGYsIEkgdGhpbmsgaXQNCj4gPiBzaG91
bGQNCj4gPiB3b3JrLg0KPiA+IA0KPiA+IFRoZXJlIGhhcyBiZWVuIHNvbWUgZGlzY3Vzc2lvbiBh
Ym91dCBlbmFibGluZyBhIG5vbi1wcml2aWxlZ2VkIHVzZXINCj4gPiB0bw0KPiA+IHBlcmZvcm0g
YSBtb3VudC4uLiBpdCdzIGEgYml0IHRyaWNreSBiZWNhdXNlIHRoZSBmdW5jdGlvbiBvZiBtb3Vu
dA0KPiA+IGlzDQo+ID4gdG8gYWx0ZXIgdGhlIGZpbGUgbmFtZXNwYWNlLCB3aGljaCB0cmFkaXRp
b25hbGx5IHJlcXVpcmVzIGV4dHJhDQo+ID4gcHJpdmlsZWdlIHRvIGRvLg0KPiANCj4gVGhlIGNv
cmUgVkZTIGNvZGUgaXMgcXVpdGUgaGFwcHkgdG8gYWxsb3cgeW91IHRvIG1ha2UgdW5wcml2aWxl
Z2VkDQo+IG1vdW50cyBpbiB5b3VyIG93biBuYW1lc3BhY2UsIGJ1dCB0aGUgcGFydGljdWxhciBm
aWxlc3lzdGVtIGJlaW5nDQo+IG1vdW50ZWQgYWxzbyBnZXRzIGEgdmV0by4NCj4gDQo+IEkgdGhp
bmsgd2UncmUgZXhwZWN0aW5nIE5GUyB3aWxsIGJlIHBhdGNoZWQgdG8gYWxsb3cgdW5wcml2aWxl
Z2VkDQo+IG1vdW50cw0KPiBzb21lIHRpbWUuwqAgU2VlIGUuZy4NCj4gDQo+IMKgwqDCoMKgwqDC
oMKgwqANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbmZzL2FlYzIxOTMzOWQ4Mjk2
YjdlOWIxMTRkOWQyNDdhNzFmZDQ3NDIzYzUuY2FtZWxAaGFtbWVyc3BhY2UuY29tDQo+IC8NCj4g
DQo+IC0tYi4NCg0KQXMgbm90ZWQsIHRoZSBtYWluIGlzc3VlIGlzIHRoZSBiaW5kKCkgcHJpdmls
ZWdlcyBuZWVkZWQgZm9yIEFVVEhfU1lTLsKgDQoNCldoZW4gdXNpbmcgQVVUSF9HU1MsIHRoZSBr
bmZzZCBzZXJ2ZXIgZG9lc24ndCBjYXJlIGFib3V0IHRoZQ0Kb3JpZ2luYXRpbmcgcG9ydCwgd2hp
Y2ggd291bGQgYWxsb3cgdW5wcml2aWxlZ2VkIG1vdW50cyB0byBnbyBhaGVhZA0KcHJvdmlkZWQg
dGhhdCB0aGUgdXNlciBzcGVjaWZpZXMgdGhlICdub3Jlc3Zwb3J0JyBtb3VudCBvcHRpb24gb24g
dGhlDQpjbGllbnQuIElzbid0IHRoYXQgd29ya2luZz8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
