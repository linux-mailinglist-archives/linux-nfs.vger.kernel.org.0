Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910E24A6AC7
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Feb 2022 05:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbiBBELR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Feb 2022 23:11:17 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:23696 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232069AbiBBELF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Feb 2022 23:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643775065; x=1675311065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dFL3umO+S6vY/1MxjBt7htNpRfEIGoKbK4Eq/jS7GPM=;
  b=BNqOKlmQukImb9q90k03Rr+xykcMv9t2lNyKAVVoiU677uo1PAAd76qD
   +67b6ISuJunU4vdDpURX3qfdl8c2immluHDUCOTByjgPhRAEPIQi1G/qI
   vgG8U17dhOFYo9Qej1jM+czsvBF3uF5iB257KNdsovyrYW0HaatrmVB2a
   Ds7mW9ymr4TrdjoERMZ39q3DNXAGUcWR3ItuJTkisvdynXw7L28V9Uwa7
   9dB/NeiyvkEkK2VsB8AIryFhsi2Sp1M4nUzzlZEMeT8YgoE66TpgjCS+l
   1z4P3vDnTIabnKlZJ1U9ROjgoBplJp/gOrU4KISFAm43cqR01/s+YXaDi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="56948370"
X-IronPort-AV: E=Sophos;i="5.88,335,1635174000"; 
   d="scan'208";a="56948370"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 13:11:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0h9nYvvO6v1Zs1MFBHxklbIfkeJ/95JWQTrDQQWyEGQDAYtBhdYah6Ry/nrSCIaJH5KXF5T71ZYIK7zLf+yPJQJbRohcsH5YtxaBT1V5Ocmgt1/nrBN1xRQypxFNx35jKCansBqte85bSM+LKEBDFef4l1UXTP5LDzLLXKzGALAqJS9GZu57rY9Y1rbGEMETwQhZvrjP5kqYAU3xK8K/KMeXSdB/JXPU6OhnXRvMhhOzPRkjcHRu4+/EgJgguNpwUqpHhKmPzyKua0gdpQxNsu4K5tN9+8pTYPDf0ZPl2kr2nZAiMM6xP3Om2Toc+XNpFx/9qQagjTjHpVMEW/Uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFL3umO+S6vY/1MxjBt7htNpRfEIGoKbK4Eq/jS7GPM=;
 b=BG121zjEURt9+PG6hdFqP7+3EAl8XimFQvpdGjNO8ZbIOv4Y5VT6jVJflEL6PBX8yzHyukesj3/vPatOsyV0Jdh9jC9TuKssl5KHceegtss/bKXhQ+EHJN3yYVf7ik8/fL53RpQRXu2KTh0L8UEDffvK2+mJTSeUk1zUevqHuAYwyFwd4whtu+ikJcWb8el8OxZyqcYB8k+rh5626eMN39pJf0ur8ubTOcxB2lbUjhIZEX0Z1G6a320nVj/73ABrWAPqs+L/g7ZpmBY/ve3r0CqS6BuHkHHrNJGaSQtSDgwdK7GYwd1bXZKDqDeNAaGZB8PV6vbsAHqoLZgAslZ9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFL3umO+S6vY/1MxjBt7htNpRfEIGoKbK4Eq/jS7GPM=;
 b=MX0OW5x3jHu2+u1oLnikjXlYvezCkyYIcYJf3ERmOk+1QUHLnrT82IGr3AaxX51+157DjJ2D2vFe/0ZW6LtbhQtrWdHJYDWifvZiGi8CuYEOPW0/iRTWrkiQwoSgjMDvKxgAEsUuVJOUtHJGQrIV2n5WykiCyLAYRs1Ixf2TaOI=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by TY2PR01MB4586.jpnprd01.prod.outlook.com (2603:1096:404:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Wed, 2 Feb
 2022 04:10:59 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::cda5:a5e8:8877:9b4a]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::cda5:a5e8:8877:9b4a%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 04:10:58 +0000
From:   "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
To:     'NeilBrown' <neilb@suse.de>
CC:     "'bfields@fieldses.org'" <bfields@fieldses.org>,
        'Trond Myklebust' <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: RE: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqMcAycEC0/pke1JkGmPD8pPKjeL0EwgABO2QCAAF7SgIAF4BMAgJ9AToCAAArJgIAHh8GAgr9HWraACijNgIABG0CggAA4XwCAADEigIAABkSAgAEmVACAANM0gIAGR/CAgAyajO6AF/IKoA==
Date:   Wed, 2 Feb 2022 04:09:33 +0000
Deferred-Delivery: Wed, 2 Feb 2022 04:10:09 +0000
Message-ID: <OSZPR01MB7050DF6073AB2EC4F82A589AEF279@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <20201001214749.GK1496@fieldses.org>,
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>,
 <20201006172607.GA32640@fieldses.org>,
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>,
 <20220103162041.GC21514@fieldses.org>, =?utf-8?q?=3COSZPR01MB7050F9737016E8?=
 =?utf-8?q?E3F0FD5255EF4A9=40OSZPR01MB7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom?=
 =?utf-8?q?=3E=2C?=
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>,
 <20220104153205.GA7815@fieldses.org>,
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>,
  =?utf-8?q?=3COSZPR01MB7050C5098D47514FFEC2DA82EF4B9=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <20220105220353.GF25384@fieldses.org>,
 <164176553564.25899.8328729314072677083@noble.neil.brown.name>, =?utf-8?q??=
 =?utf-8?q?=3COSZPR01MB7050A3B0D15D38420532CD31EF579=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E?=
 <164245842205.24166.5326728089527364990@noble.neil.brown.name>
In-Reply-To: <164245842205.24166.5326728089527364990@noble.neil.brown.name>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: 558cd35294864e67bb9fc08d7829f34e
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MTQwNTllYzAtMzk2ZC00NDIzLThlNzMtZTYxZDRlOTg5?=
 =?utf-8?B?MDcwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wMi0wMlQwNDowNzoyNlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a012cef-db7a-4b3a-65f6-08d9e6020481
x-ms-traffictypediagnostic: TY2PR01MB4586:EE_
x-microsoft-antispam-prvs: <TY2PR01MB4586AD20645C53DFD001FF8BEF279@TY2PR01MB4586.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lc9B6UzEdj53ZNMnMvWmlon1X5VlCgs5kAOijqOYgxloMKUmTsIl6NDWfHvA1VF0WJzBbiFTWsAi/NDitz8mvEKpfyUMaHvQB+NNiCqEKWgsCuZ2jpd+RMZ5mGylsNjZSoIRgHFnBkvu3s//jn+RutOkeGlGoRQTEx01EolV/aknykFaINmr5ILJ6imc8h3a72xE6yU/FUR4yO7HkiUosrK++sXfF5i8IeOpuD9CGDXPGdiE8MAystqzX7Hg/Vcr0ivboZOQaEW/k3W5sgD9Jy75PUw6uR8hR+HAgfjfAqerZoMpUPt7Ewyqkfhx2wffYdvKSJwY2YLO1LP45dLhsOlMpjFBqyiFmDYl9isO09Da+Hkfm7AmIqOdWuQPTsI7MfXOORQD1A29X7yvNCpHWEPR1ZGgo2F7pzDeRB6p3gIeJ3mnMb6wkfJ+MwNwp0qNTqvckGMdle33haBWNdiFjJhcAJfWuKJAjnUcN/awspAo4e8N6mE7eCRGE1TGWRrVEmUDkpA3VaG6MzBya+57cOurBwgCxGbmZ6kVHfhpzAQRmGtrOiJKZjFCC46f0RUhOJI19EYtglGZstbd5jMfIdei5Gg8A7K75AbSM92Z6pErLnHvMvdJA7vY/GJsuTTyrO1moW9uqrEhHwhf10IaRYc2Rx6hDlo3FNQB4Ez+VgV9lcOImYHJkOQTr2kXFJsUjDMC5zxrjp23W5yyqIdcGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(9686003)(86362001)(38070700005)(38100700002)(316002)(54906003)(6916009)(82960400001)(83380400001)(6506007)(7696005)(6666004)(2906002)(66946007)(66446008)(508600001)(26005)(3480700007)(71200400001)(8676002)(52536014)(66476007)(55016003)(8936002)(66556008)(64756008)(186003)(33656002)(85182001)(5660300002)(4326008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXozbldwUVkvSGR0MXk2Tkt1Y1FhMlFqUHlxZVZkYzl3UXo3MGRSMkxmc2Zi?=
 =?utf-8?B?Vy9CZTA1ekxDSlYrYjR6SjB5bVBvVjU4M01aeDd4V2REbVhXZXpTZGhSRk9E?=
 =?utf-8?B?L1l4c3RieTlRU24raUp5NTF1YWl0Nzc5eFB5bThQNlRVUElTSk85WEFmQzVO?=
 =?utf-8?B?RWgwVzlrcHF4dGNTZDFGdXh0bTBCb0xwNGxjYUgrU2VWTUhHeEdRRHJ2Z0VM?=
 =?utf-8?B?b2hHblQ3UUJXSHZnRFBDNnNHV1Rjc1pOMUlpNk9uNzEzbkEycVNZWWdrTkVT?=
 =?utf-8?B?NmZMbWxSV284aDNlcWVOQUxOc2ZCQWZ4LzFVRTN4RTdPMUFnKzgyNXZaMkQx?=
 =?utf-8?B?RnJGYTdSVVU3YmhWZ3NnUjI2aTdQVk9Yd3FibVQvZEtnTzdLUWhHelRVeEwr?=
 =?utf-8?B?cUYzaUlMcm5uT0pzazQxN0ViUEVsUjM1UkU5LzNiVVFpOHdVVXEyUi9qV2c3?=
 =?utf-8?B?b1Z1ditia2t2MWdvdVMyVVVJOE1PL3NhVkhha0pidTFHM2c0cTlJUnZEcDRR?=
 =?utf-8?B?THJqbVlVdlphcFgzL1VVaERBc3JzWVhvYUUwMktSMTMrWDRwN1JYNjduVDd1?=
 =?utf-8?B?MUtVMWdWK0htWU9EdWcxdkF5cldkNjk4YSs2MXBsczdodHVZN2Q3WStxQmxu?=
 =?utf-8?B?N2NZdUhyaTNhRmNoajdSV3Uvakx5YStCcG1JSE02Y3ZNd2tNMkJHM0QvS2JR?=
 =?utf-8?B?STlJNlU2SDNJczZUQlVlMWRwTE1Qa0JDQ3JtTDVWRDhwRDl6SnByai9tMnda?=
 =?utf-8?B?WGNha2FWeGZxTHVsS0tqeElmbnpTS25DalI0N3dNMUl2RFVzSUM5VHJvak1a?=
 =?utf-8?B?SXBZNitBdTFoaCtzc1hKc2VybXBrdUVNa1RvYllCNkkwOFMyMVJuZWsxL0hm?=
 =?utf-8?B?V2lsR2EvQW1iNTYrS0ZSMERIOEJ2SGJXZlUraXJxWmtsd2ZRaGVOOVJ2S3N5?=
 =?utf-8?B?SVI3SXhjeEl6SUxYcE8yN3pWV1h5R1FKWGE5ZEhhOUkyTk8zQ0lNK1E2RUVw?=
 =?utf-8?B?MkIwS1NocWxZL2RwRTVBcXc5dVUySE8wZ0NlWkt1WWptNnk5MVhTMWQ5NWNq?=
 =?utf-8?B?Rmt2RkEyL2I5NUhCSlRUcGhaNzZmTUJOZ3JVbExiR2tldEhpSlk1bkpIMUtx?=
 =?utf-8?B?OXRpVnZIbVpRVFhjbmtJYlJXOHJZUDhJWkJjWmQ0MTNtenJHQVpRNDgzNVg5?=
 =?utf-8?B?WjdPSmJmQnZJU00rQnBzd1JTL0g1eGYzRk0rUzRNRnp1c2dad245Sis1WTNm?=
 =?utf-8?B?eVJObGx2KzQ5Sm0wQ3ZBUWtRaEhYOENwYjRNa21lVkpvRTVZelJUMkdkakh2?=
 =?utf-8?B?Q1A3WjZlSDJnSFY3c1hrUjA1ZTQ3dUNXUkY0VWZVcllzOGhNbDBmL283bWQ3?=
 =?utf-8?B?TUFybDkyandKdWVJS3FkNVAyQlc1YkNIeFZNbjY0Rmg4NmZ1OWloTnA2WSt0?=
 =?utf-8?B?Umx2S2NXSnpReWZkZGhKNTBMWDEvZm8yajRGamhrSkpsNmZ1UmNvdVpiTGFQ?=
 =?utf-8?B?S1krdTN5VktxWGMrTG5WVXJjRk1kbUkyREFTcTRBbVNWNFlJbVV3SlpIeWxG?=
 =?utf-8?B?R3FHaE9HeWd0bFRnZlE2QkxuUkt0TzhSYk1jVnpCQ0hNUGxLbDJjZmtSMVhw?=
 =?utf-8?B?NmpuRFVvK3VabHI3Tm4wTGFpNUZPcmxxdEpGVVhzemozTC9qaXJveUJnYVpE?=
 =?utf-8?B?ZnV5THRmcEhuM1VXWnFaOHgxOWJSRDdnQjVxOXNFdjN5WWtNTHRXaDBtRENB?=
 =?utf-8?B?QmlSU251TWZObDFWYzNBTSt0TE5nYnV3VDRac0xkNGc5UUxBQzYwZHFtSWZt?=
 =?utf-8?B?bVZjcEh6T1gzMW96b2NQUHJzWUk5eDZubEo4Vk8xeDdIUmZRTVRrdnkyY0VO?=
 =?utf-8?B?VVlqL1Iyeml6RUxTZjQrK3JsTE43Mzh5WXlJSVNONXRwbkcwQlhlVmRocU81?=
 =?utf-8?B?bDlhcDd3SHVOUUZseXlxb0IzTGV6c3h5ZmxlWXBiWTFydlFZRDBVUlprVHBG?=
 =?utf-8?B?NHNNbkFUTXhESlppQzNjb1N2M1ZGd0o0MDlEaUhkeWphNUhnaWZhbmVtanZu?=
 =?utf-8?B?TDgzM0QxQmpIVjlYZzBvdlhKWlFId3JnM2lPVm0zbVQ2eVBJWXdIaFhpcC9T?=
 =?utf-8?B?ZzB6Y1N4MFJBUlNuMUxPN1NKYmNUakV0Y29aL2ZKR3ZVa2wvd2QyZmtSRXBC?=
 =?utf-8?B?Qno0TkNPd3dzKzRLTm5YcWRGclNBZWJ1eEIxUGQ1ZDZ3MHRlODB3ejBNMkl3?=
 =?utf-8?B?WHNiNGNYQS9sZno3Nk84SWRaSjVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a012cef-db7a-4b3a-65f6-08d9e6020481
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 04:10:58.8766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QNL+C2kspIPpM+Pj+8P2z2oUoN74ki70CX2BPliRZIBnOOzS5c6T3i3fKaD6KYrGzFYIDc/0zrXu9KV9htbJSwcSrau0EbvJXYHkaI9ZX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4586
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBJIGRvbid0IHRoaW5rIHRoYXQgY2FzZSBhZGRzIGFueXRoaW5nIGludGVyZXN0aW5nLiAgV2hl
biB0aGUgZmlsZSBpcw0KPiBjbG9zZWQsIHRoZSBsb2NrIGlzIGRyb3BwZWQuICBJZiB0aGVyZSB3
ZXJlIGFueSB3cml0ZXMgd2l0aG91dCBhDQo+IGRlbGVnYXRpb24sIHRoZW4gdGhlIGNoYW5nZWlk
IGlzbid0IGEgcmVsaWFibGUgaW5kaWNhdGlvbiB0aGF0IG5vIG90aGVyDQo+IGNsaWVudCB3cm90
ZS4gIFNvIHRoZSBjYWNoZSBtdXN0IGJlIGRyb3BwZWQuDQoNCkkndmUgdW5kZXJzdG9vZCBpdC4g
DQoNCkkndmUgbWFkZSB0aGUgcGF0Y2ggYmFzZWQgb24geW91ciBpZGVhLiBJdCBpbnZhbGlkYXRl
cyB0aGUgY2FjaGUNCmFmdGVyIGEgY2xpZW50IHdpdGhvdXQgd3JpdGUtZGVsZWdhdGlvbiBzZW5k
cyBDTE9TRSBjYWxsLg0KTXkgT3BlbiBNUEkgdGVzdCBwcm9ncmFtIGNvbmZpcm1lZCB0aGF0IHRo
aXMgZml4IHJlc29sdmVzIHRoZSBwcm9ibGVtLg0KDQpUaGUgcGF0Y2ggaXMgYXMgZm9sbG93cy4g
V2hhdCBkbyB5b3UgdGhpbms/DQotLS0tLQ0KZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5j
IGIvZnMvbmZzL25mczRwcm9jLmMNCmluZGV4IGIxOGYzMWIyYzllNy4uNjcwMjE3ODYwMzRkIDEw
MDY0NA0KLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCisrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQpA
QCAtMzcxMSw3ICszNzExLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBycGNfY2FsbF9vcHMgbmZz
NF9jbG9zZV9vcHMgPSB7DQogICovDQogaW50IG5mczRfZG9fY2xvc2Uoc3RydWN0IG5mczRfc3Rh
dGUgKnN0YXRlLCBnZnBfdCBnZnBfbWFzaywgaW50IHdhaXQpDQogew0KLSAgICAgICBzdHJ1Y3Qg
bmZzX3NlcnZlciAqc2VydmVyID0gTkZTX1NFUlZFUihzdGF0ZS0+aW5vZGUpOw0KKyAgICAgICBz
dHJ1Y3QgaW5vZGUgKmlub2RlID0gc3RhdGUtPmlub2RlOw0KKyAgICAgICBzdHJ1Y3QgbmZzX3Nl
cnZlciAqc2VydmVyID0gTkZTX1NFUlZFUihpbm9kZSk7DQogICAgICAgIHN0cnVjdCBuZnNfc2Vx
aWQgKigqYWxsb2Nfc2VxaWQpKHN0cnVjdCBuZnNfc2VxaWRfY291bnRlciAqLCBnZnBfdCk7DQog
ICAgICAgIHN0cnVjdCBuZnM0X2Nsb3NlZGF0YSAqY2FsbGRhdGE7DQogICAgICAgIHN0cnVjdCBu
ZnM0X3N0YXRlX293bmVyICpzcCA9IHN0YXRlLT5vd25lcjsNCkBAIC0zNzczLDYgKzM3NzQsMTUg
QEAgaW50IG5mczRfZG9fY2xvc2Uoc3RydWN0IG5mczRfc3RhdGUgKnN0YXRlLCBnZnBfdCBnZnBf
bWFzaywgaW50IHdhaXQpDQogICAgICAgIHN0YXR1cyA9IDA7DQogICAgICAgIGlmICh3YWl0KQ0K
ICAgICAgICAgICAgICAgIHN0YXR1cyA9IHJwY193YWl0X2Zvcl9jb21wbGV0aW9uX3Rhc2sodGFz
ayk7DQorDQorICAgICAgIGlmIChzdGF0dXMgPj0gMCAmJiAhTkZTX1BST1RPKGlub2RlKS0+aGF2
ZV9kZWxlZ2F0aW9uKGlub2RlLCBGTU9ERV9XUklURSkpIHsNCisgICAgICAgICAgICAgICBuZnNf
c2V0X2NhY2hlX2ludmFsaWQoaW5vZGUsIE5GU19JTk9fSU5WQUxJRF9BVFRSDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBORlNfSU5PX0lOVkFMSURfREFUQQ0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgTkZTX0lOT19JTlZBTElEX0FD
Q0VTUw0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgTkZTX0lOT19J
TlZBTElEX0FDTA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgTkZT
X0lOT19SRVZBTF9QQUdFQ0FDSEUpOw0KKyAgICAgICB9DQorDQogICAgICAgIHJwY19wdXRfdGFz
ayh0YXNrKTsNCiAgICAgICAgcmV0dXJuIHN0YXR1czsNCiBvdXRfZnJlZV9jYWxsZGF0YToNCi0t
LS0tDQoNCll1a2kgSW5vZ3VjaGkNCg==
