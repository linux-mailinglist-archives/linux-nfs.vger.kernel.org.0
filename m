Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8459449049C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 10:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiAQJKz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 04:10:55 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:13355 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232619AbiAQJKy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 04:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642410654; x=1673946654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aLJXMPML3mgPSsdhB6igaAh1xwFgyAaK7p9t8yqySbU=;
  b=ewt5ZtOm0PXCwagOkWQgk/VDB/lhB2pmiIiHQtXdIFFOfQFQ/SGuvDIz
   ehZ4IHb8waeDNETes9lB/oGRZHBdRV6VTl81ZNH2fKdvt2Fx2ozVqos7B
   86+UVcjHmLasQ/XQKqlOmsjqEDqpoQQWbPc2i35OtqdfKWAWXB6kYEeWt
   w5SxP46LactKKe01LpEOhXBxoLQR1tRj0TCf+PCEFdZPiRhkqMD/82HG7
   vL7zNWAAuVbJzO99XUet7MFOKa+LzTHAMSjNVRn0H7mNXFk0kScN4SoV0
   gi2B/cGyBgvgkJJ7ps+0vR+M1sF94HMZPH8RE+Lu1rzCk9PszVIcVxvFN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="55836607"
X-IronPort-AV: E=Sophos;i="5.88,295,1635174000"; 
   d="scan'208";a="55836607"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 18:10:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTBCpBiyyBGuckhLqDrUXXjln3f/3v+xe/mXX2xbHQSZAKA2hctoiEOPbv+dm9xpqVumnfSk8Lw+wdvuT0BTnrKwSo+Py6yNGRKhOaAgBEYKv6Np/RBRK976nGaX/NHMIqMasggMtsXrak1bNT5nnqtZZMtVsCGLUymAGvkIaBZLCS25fo/Ny6ov3jtbLHSdf+f6yyA3S2jyHWa50GVRb1DWbouf4Yy0HrWaaOZS4HO5AkSJI4Bn62IYBe9YWszuJvLX9ZdRWf/AewTwM8u7rfliQlG6sgZwu575dFdCa9dtmVvx9unTy9YyvCXy+G0ZqVX4ivPPmtssiaQKFQvBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLJXMPML3mgPSsdhB6igaAh1xwFgyAaK7p9t8yqySbU=;
 b=gl+2yxlUCSItCN1XDB9OYEstamnv4wMmRkzSya6Ymay68hOlwY2aBs6m1wVrdkRve9QiWDTDIC0Qn/XOf6q0SMK3/D9uSLO/hRxLAJ5VLQsHfxEFjf+4svIQxvyZAQtVgruRwRYJOI2NYYb3IoPjVgLAvKAiPPnmDbozhe5mlCURrZx1QxMnjQ9WeLvAIFuPuKfNedgOSsgL35Q2XeDZOkVjFW0F4EbuTUGKmUFc0oeMwNEkzWV72VQjFOuhEFYBlOx29CcUKSA0Wzka8n9SevRw8xY+3zggbZjmoUQjyM4ryAxJ/XR+tpdtfsvAOKYoiXTFCb5RxsOe7/nrRdShUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLJXMPML3mgPSsdhB6igaAh1xwFgyAaK7p9t8yqySbU=;
 b=E5lQYDHn42RQZ8UZeDZ35E76VFvYpOuvBdX90EAktqt+RB0I4gMA2hnWWJ58P0nV469k81RxlEDlwR+Mm5vlG8VbjmmrN9IjVM3g8vBAdNJ6hTYt0EaSbIlLBSOuGDZGT2kQsrOJyigMsPxGXYsmsduomZvWl5vc4GZR7pHClYc=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by TY1PR01MB1740.jpnprd01.prod.outlook.com (2603:1096:403:3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Mon, 17 Jan
 2022 09:10:48 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::3dfa:3c1d:6dc6:4822]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::3dfa:3c1d:6dc6:4822%5]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 09:10:48 +0000
From:   "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
To:     'NeilBrown' <neilb@suse.de>,
        "'bfields@fieldses.org'" <bfields@fieldses.org>
CC:     'Trond Myklebust' <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: RE: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqMcAycEC0/pke1JkGmPD8pPKjeL0EwgABO2QCAAF7SgIAF4BMAgJ9AToCAAArJgIAHh8GAgr9HWraACijNgIABG0CggAA4XwCAADEigIAABkSAgAEmVACAANM0gIAGR/CAgAu6VlA=
Date:   Mon, 17 Jan 2022 09:09:27 +0000
Deferred-Delivery: Mon, 17 Jan 2022 09:07:38 +0000
Message-ID: <OSZPR01MB7050A3B0D15D38420532CD31EF579@OSZPR01MB7050.jpnprd01.prod.outlook.com>
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
 <20220105220353.GF25384@fieldses.org>
 <164176553564.25899.8328729314072677083@noble.neil.brown.name>
In-Reply-To: <164176553564.25899.8328729314072677083@noble.neil.brown.name>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: 3bdcf875b6e64bcd94e9731d253af22c
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MjAzNGQ0OTgtNmE4ZS00OTJhLTgxMWQtY2I5ZmFhNDc2?=
 =?utf-8?B?ZWJhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wMS0xN1QwOTowNDo0MVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53d699e4-6add-4402-eec0-08d9d99940ae
x-ms-traffictypediagnostic: TY1PR01MB1740:EE_
x-microsoft-antispam-prvs: <TY1PR01MB17400A2C16342B1FF415105EEF579@TY1PR01MB1740.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RAU0h1g4CbPFzyYwTkpOJZ12a0HzZjdCHb1inXxMRvllO1/hYQFhO2xKIlRUuqLArEvNJxTjnWm2w+gQU8P5J3ecmPW0aguOJ0EfJELxwqZhcCdz9O81qR4dLIPQcc5GLyo+9qasnoAUgAo4Ds2CR1POJY9VK/DoBuJaKYwii/1raPg4y+a46FRi6VpH4ZJcYt2NV/zXNZf5j6QUDFa/4A3vbHqyQ4kQJqipvKRDT3odHPXCXIX4LTD7/QjbPrHk5c/UhlfmRyg6Kh3eraSjZ+9TwHRgo1tPl0pwZf5ch0KhhEW7pLQHkIIiBkhgLlaVkRzXxQmoEozLPyuQ7cBGTQf3JbV2pWyFR+FLTLfZQVrPrgo0R8bQFGZOgxG8EGgL5v9i4GlQ+ddVSZ5YVh0E6U2nBGfhAQYlG5mlBp5IvS441liOsPKyylnqiDRNDt1UuTrw6ToWEV5dYPxHmNroyBh5vfd0M5Df85ARpjmHkfDrRxUCWDWuCvbaDE7li/rxKryCZN5FtMDDc6WOE11jj1mdIgRhEm4BguqtORYtaz3cPpJwH+1PhJu9YfjUJ+HF64PJCBbnASWbBtaVx5P5KToMoN7zo0/dDeq/UYO9BKcMVTJSoPytQMcuVrk9OVl1oFhZGNoxzM7lcPBZ0Hw1ZowKqY5sksD+o8YcTo5d5S74cEPBgFh23e5FTeME/2rLN43qo7WKOy8a9q67arQWeSz3ZkuwAPq2z0keDkjE0Ns=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(316002)(122000001)(54906003)(508600001)(8936002)(82960400001)(33656002)(2906002)(85182001)(66946007)(76116006)(86362001)(38100700002)(5660300002)(66446008)(64756008)(66476007)(52536014)(66556008)(55016003)(4326008)(7696005)(26005)(38070700005)(6506007)(4744005)(6666004)(3480700007)(71200400001)(9686003)(8676002)(83380400001)(186003)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUpBYWtzdzZmWG13YXNDcDBMN3VTYUV3NjBzVVZmc0FHZ0VjRVhvQnJ1L01H?=
 =?utf-8?B?R1lrN2tQODVyY1NhNVNhZjVIWm12eVRaOWkyRDVObHJmZzhibGtwTTZGTGx5?=
 =?utf-8?B?WFpWK0ZyMEFvZEVUMWhIZlVVSjBGYUFmR0ZwOWtuSmNCeWRQQkZxNWI2L2x6?=
 =?utf-8?B?c2szcnhmRzg2Qjk2SnNhQlhYT3hGMjBLQ2t5U3BoMEFkaEVSQW9RZHZlZmJw?=
 =?utf-8?B?YnZNYmthRFRWNnkwb0N4K211Yk9sWE9PcDJBazFja29FWnZTV0VmL1ZucVIw?=
 =?utf-8?B?anF5RXBrOVlWdDl1U1NwcnpzNVpVUWxhTTFNNFNvUWhzNEhGTEh0UlhrU2pq?=
 =?utf-8?B?bWJzeEZ3ZkdUREZrSGljTVNxbTE3RzcxOWR3SkRmR1pzT2l5NzlOUWtOUEha?=
 =?utf-8?B?RUtOL2NTYzRvM2lVUFJ6SnJCbDAvMEpyR2pXNVRIVDd6Y1NEd00rWGE3Titt?=
 =?utf-8?B?UFArVnI0K2hYWmlycE1Xc01PakVUTi9nSi9wTkozUkxRQTNNV3l3bkxCaFR0?=
 =?utf-8?B?NW1qQXNBT3g1dUtVRUdXMlpWYWk3Y3cxTEtTVjhjZGVPQUhKSlhJRXNTVXFk?=
 =?utf-8?B?TS9qUldydzdRdmlSQnNtQitRZE0zb3VNbDdINk5TWnNuSnlzSUFLTEVkVHJm?=
 =?utf-8?B?QVhUdk51TWxVZVlpYVZuTmc3aGEwY1lkSW9UbDdrSVBKckJpTVE0cU9NVlh2?=
 =?utf-8?B?b2FYcVNXSDFXZ1BJWVBqSEZKdkJ6ekd5NjA2bkpSL3hMMjFITFA5Z2FzT2Ux?=
 =?utf-8?B?MUdtOTN5NmtIU3VYZ0E1OGY5Q1FuNFhFMWY0dFdaMTErSjNKS1BQeWtqanlJ?=
 =?utf-8?B?Z0JhRzdHZUh2dUo2bjR4TGMwM1lWc1plOE9QOVFFNUdwTmowWXdCM3FCTFFp?=
 =?utf-8?B?TWdRWU9QUncwTnYycmljTFpoRUNVcnBpU3duODRMSnNmZUpJVUVEV3gxUnc5?=
 =?utf-8?B?RlBYWDU2ZUlhbHlsbThDTm1DVmZ3Vm1CSWpaSWw5My9hcEtvSXNsTms4bVdu?=
 =?utf-8?B?c0JjTEcwVzQxamFHNVZMZUdhb1JkM0lLVyt6STVJb29WTkYzUlY3bnBlRUh5?=
 =?utf-8?B?eC92RVdmcDk0SW0rVEZZN0JrTVVDS3dlQzN6dnRoaGhNVVpRcXJxMlJJMDFB?=
 =?utf-8?B?U1BIcVBBdFBQY01XV21jQ2YyV1luKzZwWDU0Q0R3SlA2d0pWdTBaRm1ZeVp0?=
 =?utf-8?B?c29HSzk4NWI0S0pIZmFVaVVWNFRGSzZ4R1hwTm9NaXRHc2hZb2NxUS9oSVM3?=
 =?utf-8?B?Ky9ILzdCbjlSN3FOeUFkZWhtRFVxQWdPN1lwZ0FzQldQT1dkeHo3YUM3VWxQ?=
 =?utf-8?B?TnJrY0JhV3FleEpGeXlYNTZxOVAvTHNRMjEzVTBtb2lvUjJPVWRrdVh3RHZz?=
 =?utf-8?B?Y0Vha3NIdGl1L1JNZFd0cWE3MWp3ZjA0TXg0cGZKVHRFVGNaa2JxMnVla09U?=
 =?utf-8?B?TE4xam9mT0dQYU5PUWJUdFM1aS83R0VlY20vaTVMaDNPOWZZQjF2OUlsbXdx?=
 =?utf-8?B?dW5McXhhdXJUOTJCaC9YdndsNTlGNkFFMzJzOHVZbHZDQ3lKQW9ZR2JCcVU2?=
 =?utf-8?B?R1JwUnJ1bnBkdWQ4eVBadDhpVFBsKzJyWnlKQ1ZtUnJ3WjdWaWJEYmxnZTBN?=
 =?utf-8?B?eEpjemk4Z3E3aXE1dll2VjBHZUF5R1R4RVo3dEtCZ2E5dllmb01ROEZQOGdH?=
 =?utf-8?B?aG0wbVQxNkxVUVc2WFNqazVzVVkwWjlzNXJGYThLbVBiQ1JGZndWdmVHK0kr?=
 =?utf-8?B?aUhsTXdBWXpKRWg1b2pFbzRxdzk0SnVmYkdGeXZTQmcwQjFzdzN2SHNMUTNG?=
 =?utf-8?B?Q1pjdiszODFsMWNJMlFNaTJVMFdkV29MY0l0QXg2S1Ftc3JtWnNzTVRDVTNr?=
 =?utf-8?B?SzQrdjlsOXBzN05xYUNqMGNmd0ZQKzdoYjcxc1dEaDNTV2ZVd00wbDd3NGsr?=
 =?utf-8?B?aU9uNTkvcUxJdjhNUFc4a05UZytqYW5Pbm1xaUhXeWVldDNLMG1nS1QvZVVp?=
 =?utf-8?B?Z0VIUGFPT1dNMlRya2pCV0wvSG4zUXJaR1NNczBJVU1KU201ODBtZWl3Z0xK?=
 =?utf-8?B?SUVXMytnYk5Cd2lQOHgvOW51aDlHNlE4VlZSRlZ3SnB1eFhiWVZaY09vcDFX?=
 =?utf-8?B?VXMvSlFMWDBZUXYrc1NZUjJuUEUzbHlOcmV2a0x5Uk9vejVMWUlMcE9zZ0lC?=
 =?utf-8?B?MzdROXZ1UVhWcDZrcTZjNHo3YzNnSVFLa2k5cTBVM0NPWkJKS0haeWNZZXVQ?=
 =?utf-8?B?RUZLQ0lvakU4c3pkTC9vYUI2bGhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d699e4-6add-4402-eec0-08d9d99940ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 09:10:48.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OavNoQODn6Sp98kQnYSkKVh/sLfzs08CK0qMAEg9WrgqnXGQqCHKoAgnuJcCV80Or8QJZeR+Nbxn8JDiH27QOxcek3zgDuqjqvvXsYaSe+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1740
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiAxLyBJZiBhIGNsaWVudCBvcGVucyBhIGZpbGUgZm9yIHdyaXRlIGJ1dCBkb2VzIG5vdCBnZXQg
YSBkZWxlZ2F0aW9uLCBhbmQNCj4gICAgdGhlbiB3cml0ZXMgdG8gdGhlIGZpbGUsIHRoZW4gd2hl
biBpdCBjbG9zZXMgdGhlIGZpbGUgaXQgKm11c3QqDQo+ICAgIGludmFsaWRhdGUgYW55IGNhY2hl
ZCBkYXRhIGFzIHRoZXJlIGNvdWxkIGhhdmUgYmVlbiBhIGNvbmN1cnJlbnQNCj4gICAgd3JpdGUg
ZnJvbSBhbm90aGVyIGNsaWVudCB3aGljaCBpcyBub3QgdmlzaWJsZSBpbiB0aGUgY2hhbmdlaWQN
Cj4gICAgaW5mb3JtYXRpb24uIENUTyBjb25zaXN0ZW5jeSBydWxlcyBhbGxvdyB0aGUgY2xpZW50
IHRvIGtlZXAgY2FjaGVkDQo+ICAgIGRhdGEgdXAgdG8gdGhlIGNsb3NlLg0KPiAyLyBJZiBhIGNs
aWVudCBvcGVucyBhIGZpbGUgZm9yIHdyaXRlIGFuZCAqZG9lcyogZ2V0IGEgZGVsZWdhdGlvbiwg
dGhlbg0KPiAgICBwcm92aWRpbmcgaXQgZ2V0cyBhIGNoYW5nZWlkIGZyb20gdGhlIHNlcnZlciBh
ZnRlciBmaW5hbCB3cml0ZSBhbmQNCj4gICAgYmVmb3JlIHJldHVybmluZyB0aGUgZGVsZWdhdGlv
biwgaXQgY2FuIGtlZXAgYWxsIGNhY2hlZCBkYXRhICh1bnRpbA0KPiAgICB0aGUgc2VydmVyIHJl
cG9ydHMgYSBuZXcgY2hhbmdlaWQpLg0KPg0KPiBOb3RlIHRoYXQgdGhlIGluYWJpbGl0eSB0byBj
YWNoZSBpbiAnMScgKnNob3VsZCogKm5vdCogYmUgYSBwZXJmb3JtYW5jZQ0KPiBwcm9ibGVtIGlu
IHByYWN0aWNlLg0KPiBhLyBpZiBsb2NraW5nIGlzIHVzZWQsIGNhY2hlZCBkYXRhIGlzIG5vdCB0
cnVzdGVkIGFueXdheSwgc28gbm8gbG9zcw0KDQpIb3cgYWJvdXQgdGhlIGNhc2UgZm9yIHVzaW5n
IHdob2xlLWZpbGUgbG9jaz8NCkknbSBhc3N1bWluZyB0aGF0IGNhY2hlZCBkYXRhIGlzIHRydXN0
ZWQgaW4gdGhpcyBjYXNlLCBzbyBpdCBjb3VsZCBiZSBhIHBlcmZvcm1hbmNlIHByb2JsZW0sIGNv
dWxkbid0IGl0PyANCg0KWXVraSBJbm9ndWNoaQ0K
