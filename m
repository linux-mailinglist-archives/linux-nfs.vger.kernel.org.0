Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4090F4CE61A
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Mar 2022 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiCEQyc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Mar 2022 11:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiCEQyb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Mar 2022 11:54:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2136.outbound.protection.outlook.com [40.107.93.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4633403FB;
        Sat,  5 Mar 2022 08:53:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lvi8DSD0bHU9SEC63nabseTqWFpSUXTeoKGlioHMz3MYBVx87djdzk0V6nuwkV1fmmdhXLSx9s4eLHh+KtBYfq29SInFwQVIrijs9CjLleA3AWe9LXuyVsGoezIuKQe/4ZrcdEJHqGwf+j7E6OwwrXO3WoTOqOZQi61at36PgwyYzBBiFArebk5h5NQK6LuFU/tckqnpOHyMEyuVlM0TK54zc1JjGDVvSppUY1wqxlY2TDPgLhppBhPsT6Dgqxp09YcLJ/Xt2jNNg/C7QnDvS8EsjzCvW1bVG6eM5cE1ZKDqVE+DmHa6/+FCA7g/QAlnpkKy16PUDXwTeqLBBXUD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpzTftYsa+A7wrZta9CyDereF1eU1FGIWqS4jOw4DDo=;
 b=ZmLqgNok1qRQCZZrc8MjelBHKPTVwtJBTcfmzC04Oa0gNJ2kyuHd3U/SqiL0qRs/xQnqQBGekbSxSV39KuMP8AaObmdAyE5X2CHy1GrFxoMd0n5letaka9p8byEQSa0ms/KfD8xaBFf6w5j3LQAU4VrW4mYJaswV5P/Fa3f8KC257xEplKahaSm/q35JEpwOJTLXXZIsEUCNWbzxx0kNvOCay6avTmAVhvqitAkF0s3AYSv+cb8c+PnVYiGdTCJ74Hfq5eP5oFpyCfUTRqVl08W3AP/d9Nl1A41mm3mS2K1arZI8WfXrB58rCXel3sF1f9OQhMRgiXEQiPch1fM01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpzTftYsa+A7wrZta9CyDereF1eU1FGIWqS4jOw4DDo=;
 b=bUk/KwaO8wjLh+1q+x3jG4/1T8aluEiz+65o4qJ/MEcM1HDFQohN78AdW8T758lsmwhfr2VIfRLsuPqsDxyWfin4OAX+hkXKAKSwZ6mpyHRPfsirXi2ibofY3+u/G02Vwj0Vx+vopm6+1MS9LDXoV1v/JknnUd42jaDBMg2JU+c=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5053.namprd13.prod.outlook.com (2603:10b6:806:1aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.4; Sat, 5 Mar
 2022 16:53:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%7]) with mapi id 15.20.5061.013; Sat, 5 Mar 2022
 16:53:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "chenxiaosong2@huawei.com" <chenxiaosong2@huawei.com>,
        "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH -next 1/2] nfs: nfs{,4}_file_flush should consume
 writeback error
Thread-Topic: [PATCH -next 1/2] nfs: nfs{,4}_file_flush should consume
 writeback error
Thread-Index: AQHYMIz4ntebXgxsJ0GgUhvxvI+AhayxAgAA
Date:   Sat, 5 Mar 2022 16:53:36 +0000
Message-ID: <ca81e90788eabbf6b5df5db7ea407199a6a3aa04.camel@hammerspace.com>
References: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
         <20220305124636.2002383-2-chenxiaosong2@huawei.com>
In-Reply-To: <20220305124636.2002383-2-chenxiaosong2@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c540bc94-5341-40b8-a9c1-08d9fec8b0db
x-ms-traffictypediagnostic: SA1PR13MB5053:EE_
x-microsoft-antispam-prvs: <SA1PR13MB505301A3E17DF2FD0C460E7DB8069@SA1PR13MB5053.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOQVnYk7qXWJ8v2dI6QhC2+AzwsNFRSYNJBCkyryn/WAC+IJtYCbSofw9w6UVRuiSkGeXUwrjS5drVgmAXwJGP3C2OVB8pwbU49fZfVlN3CAH23DVdoTjAFKXM0dQO6ojHJThYo+9xBsxUuJdG/gBsdKE4El75cDmDZgOU8mW5LE3i3nIWUcgb//3WKuzRn3bPE353F5ArnxnQ+Z0P1gL87qt3aNGuqcE1lRGPw8pv523+wmuolqxROzyJRPaSs01j0dFZOJWVzmirtX0IsTG7+fPxl7OSkqNP/LLdGYGELZ4aoGlI0z4dt3qjnaKxcLSDbGUBJjpt8aiXfe8sJORlrK8HE+1qrjnuDmCZGlr+HcZ6tbb3eOJUZE7NJaTd0wXgVizLN24YBm0S20UX/y1A1vnY/nqEr4+BomxOvXdRbIROboFC8obyPE0IQraxxhP/wtQAyQqFsIYhrL7NkrZ0so7ES14r3EZ8cq+eTlLCE6CvEgqOMJTSSbr/XbWHHLtwPkbenlG9ndhHA6IqGd+JeNKHZeIpCdO8KDtwAbjucARHtJxr3nnuyjPUFq4TSPqK/MS02Bwos5F74B9LGysD7V3l6dGK8MCCRy8tLKwTy/goOrt7rgf/9jpOANXiOZPskt2lyxgtXHHKz+ttT6NAralkDImPmTckLdyueuWgThhkCu5CGp8YewRNCQbHcJlVhJZ3Pym0PV3xsJIdyqPYMJerW8jvEeb0RsIhLpu3XOKv6G72OaczQXtpSARhYTsJRiWcy0WEGZ1SHOsJWK9ceg8nEhcfkKyu40KkSic/aQfAuX6gNtQyfCvpzIGTtuD9aTBWlIQZJnrYB6CbZPhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(4326008)(2616005)(86362001)(36756003)(38070700005)(38100700002)(2906002)(26005)(186003)(71200400001)(122000001)(66476007)(66946007)(76116006)(64756008)(66446008)(66556008)(508600001)(8676002)(54906003)(110136005)(966005)(6486002)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFNtcWFadHVrcmRkc1k0WUd2OHpmQnVwVEpVTzhXbHQ3cHNoS0ZBS1Q5NVRv?=
 =?utf-8?B?N0Zwa3pmUndIdHB2R2tqU0NuTFphU2F5UFF2Z2RPSm5iUWdjOXVISURQWU9K?=
 =?utf-8?B?NWd4T1ZoQ0FvL3JDd2ZSQjVkSk9QSEljTFp4YXVFck9sQ1gwblIyZUJFQnQv?=
 =?utf-8?B?ZndhYStRSzYzRG00VDk4YnRKSU1DeHBmV3ZIVzZUdE1ESXhmRUZJVTVQamMy?=
 =?utf-8?B?dGozeTdBcGtac3o5YnlKN2Q0ci9icHhWbExNT0VQVHZNc3lIYm41Mkdldk83?=
 =?utf-8?B?MDA3Rk9ETVMxRTV6ZWNUYy9wWGJJbEh6aTBpVDNOS1NZclhaLzYyUHh4RTYz?=
 =?utf-8?B?cXUrTGlsVmdzbEZiVFRYUUdpYkRNWFBjTGRUK2lDWklPK1pub2hlQnJRYXVx?=
 =?utf-8?B?K3lpTml6NXdpK09Za1Z3Vm9GRjZUZ2ZYY2dWcGg1Y3FOTjN1NWhhOTJGWlQ1?=
 =?utf-8?B?UWxWckR0d2VDcnNvOWMzSFkvUi94bEFiUkZZbGFMOWxKcE0xeEdmYjFmdWxL?=
 =?utf-8?B?N2EyNVh3QUpQekRmZ1ljSFdTVEtGQjFlWFZsQXlSRlJkVEZzQm9wVnpjWUdC?=
 =?utf-8?B?dVVNZGx0eHQ2b1NPd3p6QUx0QitRc2J6SERPbFQ2T1dBOG1GaWVYaVdNczM1?=
 =?utf-8?B?R3Qrc3hiK0ZVMmYyTk04eVpwbWErZ2FSNUxPNC9PaVJxME9aZTJWcXRKcm5a?=
 =?utf-8?B?SEZNYXEwRGFWWjBBMmgyQ2RyQ29sZW9BbTZGUlVMZVNlVHBieGxzeHBtSGNY?=
 =?utf-8?B?KzdsQjkySUV0c3FESkJFdVRxZG1Bd1JNSFlRM2FFcVg2N2Nabjc5WGNsSEhU?=
 =?utf-8?B?OXByZ2N2V2IxZ2xLSG03Z0s0OGF4N0ljVDlsV2JhdjlBTi9MbWpOR0s3Q3gx?=
 =?utf-8?B?TDlxblJGMmdyRzROREdTTXpqRFlOekQrb2NQbjBLSTVBd1JvL0lBQVJORENw?=
 =?utf-8?B?cDNGRUdWSzJYcjY5QkFWbmdIWElEWEhJTmVaMkJoYTMvY1ZnNUVXUVA2azZ5?=
 =?utf-8?B?U2RZQUd4NDVYdnZTYkdzZUw4aGlQMks5SHlRc29xcmxrOEpmTTlsbUxibElx?=
 =?utf-8?B?L3dUR3NrOHBLbERIdGlyWXlmZ3NOYXpVcllWMStyQTZMbG5CNEtzazNKY0hn?=
 =?utf-8?B?aHg0Z0Jpd2NlZXU2N3poREZoRldxZHZKL0JCQldZVzhsWWxCY1JuVWxQRks4?=
 =?utf-8?B?V3Yyb3R6RGg3Y3BmcjNKb1Y5ck55bUFtYmNZNnJQZlNzTVQ2OHorWCtvbG1r?=
 =?utf-8?B?VmJCN09mVEY0M0FNN0lnTXhReGFNdUcxdHV2RVV3aTVmaW93WkJObEpVdDZk?=
 =?utf-8?B?RHlGTDNsdzBZb09BajNGZ3ltL0FrZUx6Q3hVd2hwWVVVWlBmd3h2cHNqWGlJ?=
 =?utf-8?B?N0QyRmFjOUhhelFuL1ZDMWpkWGhJbWZIOU9YV21XSElkYktzU2ZRSG1lWVU4?=
 =?utf-8?B?ek93N0JKUHhCaGJTMWRnSWNueWw5UzFVeVFnTy9hR3ZUZmhoV2RGcXpzUUZx?=
 =?utf-8?B?OFYrTUZXWWN0c0ZaN3dqN2NjcEJtWVNSNXl6M1RiTTgzS085OXhTbmtrSFBp?=
 =?utf-8?B?VGpLMHpNNzN2Z01yT2dMQ05BZE80c1NsaysyS09JZWZZa3NrcnJhNXNRWDVo?=
 =?utf-8?B?cE1wa1RQWWhNaVZ2UFp6QmFkM2NjZ3ZZV1ZlbVB2dGQ3aFhFQjEyS2ZXVG44?=
 =?utf-8?B?TWhwdDI1Q0JReVVHOVpvSHBPWVUrMTJWU3hWNnFHS052RG9VME50L2tLM3hk?=
 =?utf-8?B?S0hEd3ZERHpBMXF3RDgyMjZVazg0Q25sS1BvdnM5ZGpGNnZvWUV4bk1NMlox?=
 =?utf-8?B?Q1dHTkFPdERkeG5zNFRPaU5xNUpwUytLUXhDNFVCaHVCOTFOQTArZFRoSm15?=
 =?utf-8?B?NnNiZHh0Zjlzb004TG1zeDRESFp6cEZOQWhGZUk1VjRLVmVTNWpoZ3BDcHdD?=
 =?utf-8?B?N3hQUkJ3U1QrM3liUTNZYjVBS1JpakNCV3Nia0RqdkhRM1pkbkxRbHVaK3JV?=
 =?utf-8?B?bXZrc2htT3pnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B31299C9783C754ABA8C2A28F1333D03@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c540bc94-5341-40b8-a9c1-08d9fec8b0db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2022 16:53:36.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3H6OXKIimIOyvmUMe2W5iSplAhGpd7Td8fJ8h6hcerfYh8bP+tbN/l6AHjyg+zMcQClfavzfL294IZumC/CAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTAzLTA1IGF0IDIwOjQ2ICswODAwLCBDaGVuWGlhb1Nvbmcgd3JvdGU6Cj4g
ZmlsZW1hcF9zYW1wbGVfd2JfZXJyKCkgd2lsbCByZXR1cm4gMCBpZiBub2JvZHkgaGFzIHNlZW4g
dGhlIGVycm9yCj4geWV0LAo+IHRoZW4gZmlsZW1hcF9jaGVja193Yl9lcnIoKSB3aWxsIHJldHVy
biB0aGUgdW5jaGFuZ2VkIHdyaXRlYmFjawo+IGVycm9yLgo+IAo+IFJlcHJvZHVjZXI6Cj4gwqDC
oMKgwqDCoMKgwqAgbmZzIHNlcnZlcsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDC
oMKgwqDCoCBuZnMgY2xpZW50Cj4gwqAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IC0tLS0tLS0tLS0tLQo+IMKgIyBO
byBzcGFjZSBsZWZ0IG9uIHNlcnZlcsKgwqDCoMKgwqDCoCB8Cj4gwqBmYWxsb2NhdGUgLWwgMTAw
RyAvc2VydmVyL2ZpbGUxIHwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgbW91bnQgLXQgbmZzICRuZnNfc2VydmVyX2lw
Oi8gL21udAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAjIEV4cGVjdGVkIGVycm9yOiBObyBzcGFjZSBsZWZ0IG9uCj4g
ZGV2aWNlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IGRkIGlmPS9kZXYvemVybyBvZj0vbW50L2ZpbGUyCj4gY291bnQ9
MSBpYnM9MTAwSwo+IMKgIyBSZWxlYXNlIHNwYWNlIG9uIHNlcnZlcsKgwqDCoMKgwqDCoCB8Cj4g
wqBybSAvc2VydmVyL2ZpbGUxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgIyBVbmV4cGVjdGVkIGVycm9yOiBObyBzcGFjZSBsZWZ0Cj4gb24gZGV2aWNlCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IGRkIGlmPS9kZXYvemVybyBvZj0vbW50L2ZpbGUyCj4gY291bnQ9MSBpYnM9MTAwSwo+
IAoKJ3JtJyBkb2Vzbid0IG9wZW4gYW55IGZpbGVzIG9yIGRvIGFueSBJL08sIHNvIGl0IHNob3Vs
ZG4ndCBiZSByZXR1cm5pbmcKYW55IGVycm9ycyBmcm9tIHRoZSBwYWdlIGNhY2hlLgoKSU9XOiBU
aGUgcHJvYmxlbSBoZXJlIGlzIG5vdCB0aGF0IHdlJ3JlIGZhaWxpbmcgdG8gY2xlYXIgYW4gZXJy
b3IgZnJvbQp0aGUgcGFnZSBjYWNoZS4gSXQgaXMgdGhhdCBzb21ldGhpbmcgaW4gJ3JtJyBpcyBj
aGVja2luZyB0aGUgcGFnZSBjYWNoZQphbmQgcmV0dXJuaW5nIGFueSBlcnJvcnMgdGhhdCBpdCBm
aW5kcyB0aGVyZS4KCklzICdybScgcGVyaGFwcyBkb2luZyBhIHN0YXQoKSBvbiB0aGUgZmlsZSBp
dCBpcyBkZWxldGluZz8gSWYgc28sIGRvZXMKdGhpcyBwYXRjaCBmaXggdGhlIGJ1Zz8KCmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC9jb21tCml0Lz9pZD1kMTllMDE4M2E4ODMKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tCgoK
