Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7C5AC826
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Sep 2022 01:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiIDXk6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 19:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDXk5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 19:40:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2125.outbound.protection.outlook.com [40.107.220.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F6724BE7
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 16:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF3fjy8ja3Cvp2FAQHo8AzL9s7omiAK96K5oPPA6dEMCS+fL8cmMU3ngo9D4W5iqxf7pdBVYAjVcmdC5DybcF+67FNpY9giUdGhhgbxYTgUNggsFPYIgSocyUVja4JIkD6WHHwQieeHyMHwwtcikqhgH1SesUnmz4D0WQcQkUSYGvF3d3OGS/upRQWJjM3p2FIvpAhWU6N5iCIJa/ZaLCMrtxvMpzVemn8+QFjHSo0SoA4qxJy1XTrdvDb23K2EFZlrb4rUYWMWvGJmTmQ8ImybVjMkSih7VJNt925IKzJej2SCUsqaDqh70TebHmOjFFDfEHNC99YA7aWmf/1GGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg5dQHk0WrPOxAmGO6vDmNLDskj2oVJqcK9iftnVqzE=;
 b=MclqXJsLKnM7cFqmIALnZJdrKbL/x4BLamI/qYU9I8Re7RBAjOMecfDfBmLJLy59/Oe73NASC0dWo376NpfDiQCDjAqxlpCd8F6i2fgPiZ8Zx2yatEqf2damwIuAmf8GyDym39mbymHh1CgKtpFbFwb3p2rnAooR1XSw5qF4qXRGSNfUryOG+uQTZgWegWZlb93qjcotGLXBWDAjMQEVoIpozQSM+xALwtr0D3TzUYPUVswdx/3zD/ZGZxVQCsIEmNxCK/BOAJJJXUsMNaqfIq1WILTPCZqStq7Y1scz1KvDKhDzwOI2MV5lAdChzkCrRx1pDOqY5KebqG8no6OEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg5dQHk0WrPOxAmGO6vDmNLDskj2oVJqcK9iftnVqzE=;
 b=CTT70bCrQViPJ/oBr4brGrZB0qjoM8ktALWHV42h20e50tmSbsM6vhS1y1FJfKi8mh2CYhLUyVQtahrcZelbSl7BRHCmHBnPNjUKDr79IR8St9p3s8EhsjD3erc5qob301sWsbEUcOJqm0WGhRTv5EB2GkgS59cUp2SVZ8VtMuE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5169.namprd13.prod.outlook.com (2603:10b6:610:ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.11; Sun, 4 Sep
 2022 23:40:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.011; Sun, 4 Sep 2022
 23:40:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEAgAACsoCAAAKEgIAAAmYAgAAD74CAn5ulgIAADKiAgACEsICAAELlgIAC38AAgAD0fYCAB5X6AIAAYkyAgAIShYCAAAN5gA==
Date:   Sun, 4 Sep 2022 23:40:53 +0000
Message-ID: <2e5b8af112d8440757681a1f71de4ec0cc57ae90.camel@hammerspace.com>
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
 <166155716162.27490.17801636432417958045@noble.neil.brown.name>        ,
 <c64f102712ed8a5d728c2bf74592715891302f78.camel@hammerspace.com>       ,
 <166172952853.27490.16907220841440758560@noble.neil.brown.name>        ,
 <22601f2b7ced45d3b5f44951970f79c22490aced.camel@kernel.org>    ,
 <166219906850.28768.1525969921769808093@noble.neil.brown.name> ,
 <1cfb40103f3f539973587f4565af79d5dc439096.camel@hammerspace.com>
         <166233410596.1168.312161459644850792@noble.neil.brown.name>
In-Reply-To: <166233410596.1168.312161459644850792@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH0PR13MB5169:EE_
x-ms-office365-filtering-correlation-id: 699bed70-ae7e-43eb-00d4-08da8ecee815
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KYM0z/08X8XQyRc1fwvU9G6JlcHh8+ZDBNFRtqufnzCUuX+UVkJQ/qJ7mNMf28S/cmrFuaqE12+H2R9XQAafXolCxik/vX9z1ArMzkYK9CtebaUMBwU4Sb4266Z9OOleA+0uq7IbcGQU4KM8k5OI4TC8NjlzvVmT4fwhcYPy7V3PGByJIMKzxqBCBPeHnpKjPwZ4iNR3xFPhUT9sbVhcbpCSc8EY8AqKZXNnllCpygPGi1na8nuixacaabgEMWR+7/5yeIrJ1yJlH/lZCegyOLANcchK7BEsmpoN1C3JM8sCUgXuHJZ4gtxowKyj9u3hQiVGSJPc6NoykfwgeOd6meX+mBtvI/B2AQ8Rnz/gaM6ZPNxShD7O0eTC07RrpQ4jrq+jZoE3vGe/lp8+jrGMH3lc7wWMfaOYltHIJEX2oOwqfh1iT4u8+vC/oDyQepT4wzHbDZh7mYjpsAJq66IHAhE2ZAjDVj64i31nBCgdRdOKeXph6z5tG0rIG+dyZZufDsrcSDwNZhi9+10fo3xq8fjyvOXptPT4OtbY0iI5o3K9Le+a5X4DdZi4P2xjb3ZkaaQyj//owg96rdiS8IohF4qhj0HTfHAA+EjR1w6YO2LAHCHilZMOqGCr6ILeNyH5kOTRAWJN0OAGNMcprHL448o89jrnFOXqDbivC3mY0qaZzUI1SY/vundDcVAUu5vu0lgCvfWf/jjmseN1v4TPUA3yq0zK0f2iwivfA/P/azWwokobLxicU0lsij1t5B4V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(346002)(39830400003)(136003)(2616005)(186003)(41300700001)(71200400001)(478600001)(6486002)(26005)(6512007)(86362001)(6506007)(38070700005)(38100700002)(122000001)(83380400001)(316002)(5660300002)(2906002)(8936002)(54906003)(6916009)(8676002)(64756008)(4326008)(66446008)(36756003)(76116006)(66476007)(66946007)(66556008)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXdWYVZ1VHhndTBLMVRuMGZpb2lBeDJSWWpsV2J0eklNU1N6RHd4cU51M0hn?=
 =?utf-8?B?ejhYR3FhOGc3bDZPS2RYREgyS0dxblRNOWV0Ty9pQk9EN3hZVzBjK2E0Wmpv?=
 =?utf-8?B?ZnRhMitnZWQ0R1JWa2Z1UXZyQmlibHhReFlIRTdzY3l2VjBDNloyRW9TMDFv?=
 =?utf-8?B?UkVxY0RxcVY4dlhsaUxYQlFJd1RKdnpJRzNuR1lWY0g2OEd0bUFPaSs1bWYz?=
 =?utf-8?B?TlRVNHRDY1VOM1NvR2tqTSt3bEhMZm5OMDRITEFoZjhhWGF3MW9PUW1tamtQ?=
 =?utf-8?B?d3ZQS1gzVU9BdU9jekJ4WXlMWDBpTGlwS2F2Z3ArTmplb0YvblpjL01pVXRy?=
 =?utf-8?B?KzVIRUQyaWttaGlBREhOVCtYRmg4UWpXeGlCYUlZQWQ2SWdGcUZxd0J0OUQ2?=
 =?utf-8?B?V3MyMmc3YzRDLytwdExzTE1zZWtjM0g5YTQ4S1VhNlNJeGxQMm1WK3ViY28z?=
 =?utf-8?B?U3dsakpKajdYWHNhLzk4NmY1NkJEVTRQMHRXWFEzdVdIb1VrZ2VtejY1Zm9M?=
 =?utf-8?B?MktFK2IxVDl6N05tcXlxaWxlUXYwVWVCdzNEOEpHNlVjY2hjOGd5Mnhlb3N2?=
 =?utf-8?B?VmU4K1BUS2dSZ1ExSkxjRHQvUjZPRkZNcW9WZzZDWk9VTGFCYXRWZzZLeVFD?=
 =?utf-8?B?Q2V4cUk0SkZzRFpnaytOc00rMkV6cDZPcnVPVHFoZlBzWXNIUFZwRk5OWmdu?=
 =?utf-8?B?TDVlakMzZ0JLMjYyRzRGYVl4SmFyKzFRRnNVbzhHTUJmM2RDRElsQ0hUajY0?=
 =?utf-8?B?cis3NHFyTjdUYkdrT3ZJTkpXVnl0TDU4QS9tZndlVDQ3YzdlRzhNTE45SXVv?=
 =?utf-8?B?UDhhTXQ1Y2hSRWtPOFZIV044Uno5dVNVZk94TlhYczhJWVZkcTFxeW0ydWV4?=
 =?utf-8?B?ZVdFbC9WcEJBaGZ3QWp4ckM4WnVzZmZPcXBtYjFleXBQTjBVaVpzRmV0R1B0?=
 =?utf-8?B?Vkloc2JJZi9NQkxNTUFKMlliTXhZcUJlYlNLZDNlVmd2cjBxalpETm1MV3Vr?=
 =?utf-8?B?UjJEeHFIM0tqSTBEbHBQNDFHUVMvVVhUMWJsZDV5SWIwbjkvVEpnVmRmTFNv?=
 =?utf-8?B?a2xtcVlrd3o3dTlVNzJUenJqZE11emN6TVBtTnNSL0Z6Y0RZbitnMlhnMEZw?=
 =?utf-8?B?b0FCV0FLLzhheHpFcFBlTmtLVEp3OEZYWGNZM3JuR3ZYY3FvSVR5VmVWSGsw?=
 =?utf-8?B?enRHNE9RM0ZQbHdyeXRNYmxrVUhxNUFlczB1QzhwV2hVQnJZbnU3RnQycWUv?=
 =?utf-8?B?MjMyTVdyM0JIcUk4aUxZRW50bGhMM2tpaTFRWkdWS1ZHeDRNUGZvbWJSRTlq?=
 =?utf-8?B?eXg1bmtTSERnVDhYS0FXNTI5VFRyWUp4ak1rNHVJQU90RTd5U2FuWXhJYkxt?=
 =?utf-8?B?eUgzUFhWUGROWTh6c1l3cXRvNWR6ZzJ0SFpiSEwzNDFZb2RlcDZBa0tPcUph?=
 =?utf-8?B?YVVKaVVqNVNQSkJYZldLbTBxTXYrRVhxRHRMNFFTZ3hhaWp1dmZzcnYrTFJX?=
 =?utf-8?B?eEVSZ0RLeFhXOHQ2Sm9PLy9vRjd2ZjlzNHRteU9lNHhSK1RaRXVoek5xR1BG?=
 =?utf-8?B?YWt4b0VZcHVHakx0eFYzS003akhxeFkwT1B5dTMwUXB4TUc3WTBQNkl6QWxa?=
 =?utf-8?B?SUJPc3l1OG5uSWhwUVl3L0Q5dTRYSVBRRkZHc1kyS2ZSbHFBTEczdFNSSjNN?=
 =?utf-8?B?MDg5L2FqSUpOTVBqdFBaWWNvUWd2bUZrT2dnVjNvZXJrWUtCbnZ3dGZFNU1o?=
 =?utf-8?B?VVY3NFBMOCs3RmtMc2pTN1ZNOFdwTW9DblBjKzNCREJwL1JqUlpHZjNOZ01r?=
 =?utf-8?B?RDBtQ3dWUHBWakFqUnVNcnM0bUg0OGtSZ0F0WmdhaGtwRnArb3dsTXhNNDJj?=
 =?utf-8?B?cWxmMExhTTEreVowNm1SeG5CcFJBMldOb0pBS0tJMUtGWG9jd1g5aUlFWEEv?=
 =?utf-8?B?S2RFUkRFUlZ0TnZLeDdkanpXQzBLWENvZjhteENtN2kvUzR2WmhTOU5oSy9P?=
 =?utf-8?B?d0s3cGhMS1dDbU5FM1NoTTM0ci9ZREoxMCs4OUc4T0VkTVRwclZUb2JHTkxO?=
 =?utf-8?B?dzN1dTNWUVRYUXFvcTVha3RIeWxDSjZ3WWhJdlNhZ3JRV24wRFh2ZHMweURm?=
 =?utf-8?B?anVxd1dzMjg5c08wbEFHeXhMa0FxN2NMMlZ2UlJZYkJqaGxTMzIvNE42em8r?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43BAEE2E1D698B4F83807BE81A4A2B63@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTA1IGF0IDA5OjI4ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBXaGVuIEkgd2FzIGZpcnN0IHByZXNlbnRlZCB3aXRoIHRoaXMgcHJvYmxlbSBJIHRob3VnaHQg
bG9nb3V0L2xvZ2luDQo+IHdhcw0KPiB0aGUgYW5zd2VyIGFuZCBldmVuIHByb3ZpZGVkIGEgcGF0
Y2ggd2hpY2ggd291bGQgbWVhbiBkaWZmZXJlbnQNCj4gbG9naW5zDQo+IGdvdCBkaWZmZXJlbnQg
Y2FjaGUga2V5cy7CoCBUaGlzIHdhc24ndCB2ZXJ5IHdlbGwgcmVjZWl2ZWQgYmVjYXVzZSBpdA0K
PiB1c2VkIHRvIHdvcmsgd2l0aG91dCBsb2cgb3V0L2luIChiZWNhdXNlIHdlIGRpZG4ndCBjYWNo
ZSBhY2Nlc3MNCj4gaW5kZWZpbml0ZWx5KSwgYnV0IHRoZSBraWxsZXIgd2FzIHRoYXQgaXQgZGlk
bid0IGV2ZW4gd29yayByZWxpYWJseSAtDQo+IGJlY2F1c2Ugb2YgcHJvcGFnYXRpb24gdmFyaWFi
aWxpdHkuDQoNClRoZW4gdGhlIG9udXMgaXMgdXBvbiB5b3UgYW5kIHRoZSBwZW9wbGUgd2hvIGRv
bid0IHdhbnQgdGhlIHR3bw0KcHJvcG9zZWQgc29sdXRpb25zIHRvIGZpZ3VyZSBvdXQgbmV3IG9u
ZXMuIFRpbWVvdXRzIGFyZSBub3QgYWNjZXB0YWJsZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
