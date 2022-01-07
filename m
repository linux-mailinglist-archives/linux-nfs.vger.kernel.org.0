Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C27487428
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 09:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiAGIex (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 03:34:53 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:33831 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235962AbiAGIex (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 03:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641544493; x=1673080493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mLAa38pvs8yTlZfbKsOBNu9nII+HNeaDISSE1qiY/Eo=;
  b=ZWxyD5B2pQD98W+fI5FaRx3nm2RUAarugJdPu/pCZCCnUvcqLU4MVUed
   MrzJrTOjnzXRM+pqeuDznNaovyyb15590zjU5aVCZbOUDsZGb4Myo8ArZ
   FCIXrIldtQuKLiNUidCkp7PrWUXb0bvXAf1qJ2KK/uGgiwaJx7McEfb+5
   vqeXK5njKTodzINvDxkpiScoxja+rz/5UR+UCUS55Yq1xiQDXmUGB5BuA
   LGCeGuuAC3MfRl5uQ/McZEMHX+jY1ZPpLw1P064CdoHJ61XvwVj5wgjU4
   fnAkXVv2wFqbZrZbcv6kSnURzDtR/lgIlxIwWwKpD+ttWEPe+EKllogH1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="48158322"
X-IronPort-AV: E=Sophos;i="5.88,269,1635174000"; 
   d="scan'208";a="48158322"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 17:34:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HovEibttgfZEBmmWIc9Sj9qUt/B4Hz1gMVCTRX3AQkaKzJxSHvyebHUf9WDK06V1mp3u+fJ0Wul/sKTwH1nZCRiSIxauLVq1odetDd9Se6Car4eFJR4/PzVi1gc0CPyAhLXIKVXY/h8WqACPdqItYUuz9Qj5Cl7pUCGRyeGYB+d2NOxSNe4a2jFJhxDYt2g4CVXMA2H7dPJub02b47WonE/V+i63cqcvmbxht0I08bR1bJdr+Csto8xhS8D6vLY/02fnYFKJE1fuj8fZpNeDsStSTJIOHdmvXDIZKPL4ni/514NhFnBhHn2T6dNFsmjgc6RIKb/CcU9Y/ha1m4oUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKlMC7VjCGGMh3bkObCjNGOdbvm/2hFRINbwDS2zndA=;
 b=cdocKU2vQfxGjatldYlz8E1acRUpAOQcgZuu+r8DB0cStA8Y1wIDE6BuM4iJkZQkNCryTqdagAaI3fUWKXA23Gi9udj/5EIlAPT8iQM44XC98wVkrcGI9dfVOAUkyv2wLsFdfU/wOn/5p3B4LtXxng/uWcUsfW1zV+/4OJtWTiSdNW9nynxsyPvArF5/RQZhyGti0p/UxvgcyQnTYRbmcV4qxkfSWPrOI4pBPrsVXTKLirRlbGmBxgBOD0hTebthj2R/U8iaGSSsK38KfkNAGDnB70ptiHr2HO6+jMxp0KX+MAmpW7Gw9BXhAo6znzhYNE/dDgdKMtTrNnfBMdiS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKlMC7VjCGGMh3bkObCjNGOdbvm/2hFRINbwDS2zndA=;
 b=R90aJvlQePBL66fNNVIfW27D6MfVttYEKDB7TLZ4w71qoZhte0Xpetpokbdf6n9mkC7vIKT1zG2MoXR/B+PphsU+VdNseggE2iM2IVZaG50uIFE+CJ99l/nQ+rp5MNPuXpIcX+bNBBTQl0V7MGa3U6nrQIpYmX78x8YKsE8yZ60=
Received: from OS3PR01MB7048.jpnprd01.prod.outlook.com (2603:1096:604:121::14)
 by OSBPR01MB4696.jpnprd01.prod.outlook.com (2603:1096:604:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 08:34:47 +0000
Received: from OS3PR01MB7048.jpnprd01.prod.outlook.com
 ([fe80::f5ea:652a:2226:511a]) by OS3PR01MB7048.jpnprd01.prod.outlook.com
 ([fe80::f5ea:652a:2226:511a%8]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 08:34:47 +0000
From:   "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
To:     "'bfields@fieldses.org'" <bfields@fieldses.org>
CC:     'Trond Myklebust' <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'neilb@suse.de'" <neilb@suse.de>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: RE: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqMcAycEC0/pke1JkGmPD8pPKjeL0EwgABO2QCAAF7SgIAF4BMAgJ9AToCAAArJgIAHh8GAgr9HWraACijNgIABG0CggAA4XwCAADEigIAABkSAgAEmVACAANM0gIAAmsvggAB08gCAATEf4A==
Date:   Fri, 7 Jan 2022 08:33:24 +0000
Deferred-Delivery: Fri, 7 Jan 2022 08:31:38 +0000
Message-ID: <OS3PR01MB70486CD03BE83C3E782EC7DBEF4D9@OS3PR01MB7048.jpnprd01.prod.outlook.com>
References: <20201006172607.GA32640@fieldses.org>
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>
 <20220103162041.GC21514@fieldses.org>
 <OSZPR01MB7050F9737016E8E3F0FD5255EF4A9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
 <20220104153205.GA7815@fieldses.org>
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>
 <OSZPR01MB7050C5098D47514FFEC2DA82EF4B9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
 <20220105220353.GF25384@fieldses.org>
 <OSZPR01MB7050BC53F1F38FAA579E03B3EF4C9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
 <20220106141628.GA7105@fieldses.org>
In-Reply-To: <20220106141628.GA7105@fieldses.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: a7ad510d3b6246cd9b35f9f8866ab6f9
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ZDI4OWQ1ZjAtNTQyZS00NTY4LWJiMjctNTM0?=
 =?iso-2022-jp?B?NTA5Yzc3NTk3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjItMDEtMDdUMDg6Mjg6MzJaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65373fff-7ac7-4fd0-6473-08d9d1b8902c
x-ms-traffictypediagnostic: OSBPR01MB4696:EE_
x-microsoft-antispam-prvs: <OSBPR01MB469662DC9F5F0DF3FCB3A76AEF4D9@OSBPR01MB4696.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nawRXiDY62t9dLIV+/9Njkc6r+HlyDWQfW0hpGGvhfdxHJE75kUMPDgwj2jtahSbAePRouBMoYMT3bOfIAd3ythNToCTo7dzWg/evF+LsNbECm2slPOhcugkq48MIl8mMhmfBteaOJgAQpB1De/Iu0ho9Xqm6BFoAKQi1qck8FGnW4VGfvUjFfY03Fnuu7TpfOBuRXSyjGjWME5MAbr5/0f+HlNkC11VH5NJeN4vTRXJXgeLb/9WNi/cHsEVSDVi1lUWqgNXskZcz7I0hSUP2EkbC/rWgW8CS9euUEyR6yHNx5hphOKlhDxpVJ01VgyOYSpXhLZLk9utwjDAOQzlbmRlvOGqTgrpq6xBGfz+1C7yt8ep1TdaLmLp8Yzdzoyp5s1Zu3Jes3mbX9sIWxTDB5JrQSED5+O4r6U428JV7j6h536wpsrciWKCRl59o7rVs6GACQTijz1HudS10IAvO0Q4zeRTeqnOl4QExJuiSFgDXZ0fqrLit3mmd2o2lUIBV/qVrVmjgbzG9OOv/ZTaHrvJjbjCmtrtoukcIKuvpScZj9CFxnVv0Igv1lTAwRgH1g35ECE8mT3Nr66jGWOkRG+gtlpB4cfEq8XlZQPwaZgKq8OuLdZdT5qM/J9jW6jgcBGzAPOCf1Lzyum8BnIkZNfmIZdRNaYd/MFQv3iicpUrfRmCSLNSfxddeJzPWUSbJtd61naw7y/TnNjgWmsgf+2GqhpfbJPqUFsk3uCnOc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7048.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(8676002)(66946007)(6506007)(55016003)(8936002)(6916009)(86362001)(122000001)(316002)(5660300002)(66446008)(7696005)(66476007)(26005)(2906002)(66556008)(3480700007)(38100700002)(6666004)(71200400001)(508600001)(33656002)(64756008)(186003)(38070700005)(9686003)(54906003)(82960400001)(83380400001)(76116006)(85182001)(4326008)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WFFOeGNLSk4yMzVxMXpoNGFRMEY4MDZ4SExMc3IxUk5IbVNJb3VadU9P?=
 =?iso-2022-jp?B?dGE4SUcrdlBpYzNaN3Ezdjc2K3BPbWd0UlpFc0NoM0k0K0pCWG4weEtu?=
 =?iso-2022-jp?B?VkdvaXZ6VDY3dlZVZ3ZnaFN0K0lkNTBOcHNXN0ZGZk1XN1oxZmJRbDgw?=
 =?iso-2022-jp?B?aGd5TERnN0E4aGFvSjlWM2NHZllERFc1azNIVXlnTUovN3B5THlwb0hN?=
 =?iso-2022-jp?B?aVNtYXYxWFN3MnkvVmVxV1UrNlB1d3BEZHk0bW9PcjNWaThCU0lyWHg1?=
 =?iso-2022-jp?B?eVJhK0FBUld4djEydFBuTE9YMjQyNk5aQnpxQzZUbWxqdTZpRjZjcnpH?=
 =?iso-2022-jp?B?UThrMEdpeFlhRGYwa0F6OU1iMkNkbjB4RWNLbEVYb1FtMUllWjVaOCs3?=
 =?iso-2022-jp?B?REJCdlVZZGFKZDlNeXNWWklGeVZldmY1ZTFkU3llYzZ1ZVNuYWlHeDRH?=
 =?iso-2022-jp?B?UTloQWMrV21aay9JUUVJb1hBdmx0Z2pkMW5SUXQxMlVNYmQxeEMyNndY?=
 =?iso-2022-jp?B?aHVWd0g1cXJmSkl1NG5nTXhvVkcxU3VPYXB2TnJzb21kay9TdVNMczFp?=
 =?iso-2022-jp?B?N0s5ZFdDSlpkdlZtWm1ITHZsTmdzZnF3Yys4SWt0ZTJMeGx2OGxCZGU2?=
 =?iso-2022-jp?B?Tk5qc1pZUVN6VmFnSjUrclZxZVI5eXE1SGdqbWM0MUpoS1diYUZVQ1Vy?=
 =?iso-2022-jp?B?U3JTMDdlNHoxamdHeWM1RXdGNTY2ZHpMVXpXSWhrUWRYRmJ4YzFJOVEz?=
 =?iso-2022-jp?B?L2h1ZmFuVUdhWms4R0JHTWU5OUhHWnlMdmJPcGFpOVpnZUFxcEFDZkcx?=
 =?iso-2022-jp?B?ZjZ5b0dWQWFuTUxmSjgzLzd3RUIvbEliR0ZieE9CQlBkeGp3aWhqb1lj?=
 =?iso-2022-jp?B?WTNwNkEwUkF6WUZJNWIvMXd0VlJsUC94ZUJrdmd3UWd3MFlqMy9Scm1I?=
 =?iso-2022-jp?B?Vi9oakQxQ1Uxa1dIeTdrZ3hUS0RCcks1UDNnMnRTR09NOGVEZFZyUm1a?=
 =?iso-2022-jp?B?YUdMREFSVHhPc2xON2JpVkMvb3p0RWY4QXJUaXZTdGhBZjJjc3oyZzIr?=
 =?iso-2022-jp?B?YXUzUmI4RXozVHZ6VGFlbUZoaXp3Z29GeGhsaHlqc2FXUG04VCt0dUhy?=
 =?iso-2022-jp?B?amc0NCt2SHlzQkRTbXQ1VmZnbjdsaGpNZGJ1bXg5OVdIY0FLTjhPZTRR?=
 =?iso-2022-jp?B?ZkxZS2lzZGsrd0l1Nk5rMURqUUhkV2U2c3ZFTitRVWU4R1ZmU1Z5UWNh?=
 =?iso-2022-jp?B?TGFKSE1teXpUQk9sNVJ3VW1JTGNFeXZEd3pwbVdHNVRNNzY4OWxxdHNJ?=
 =?iso-2022-jp?B?YVJCY1FFeEhLTHNtSVNNSUwvN0JMZDhRWGRsOTdhU2UzUldJNlZPckhR?=
 =?iso-2022-jp?B?VUNGS2NSSlVGeU5YemZLNzMyL0RLckk5RG9XVUZ5dnArWm9OOUtIU3U5?=
 =?iso-2022-jp?B?eXJFZkZGWkFZUDY2ZWJIQUJmYnV3UVJhUzl5NHl6eUVvTXZQVEIrek1U?=
 =?iso-2022-jp?B?RUZrZFJTNDJXTm13d21Bc0x3VVpxYXZTN2pmTDRONFVJOHlOOTBZeDFM?=
 =?iso-2022-jp?B?dmxkVjBaT0hZelFob0dPTDcrK3lDclBjcTNYd1pncHNKL1pUYW1BcVJN?=
 =?iso-2022-jp?B?aW5Pc0dITHl2cWU5TXhtc1pxTjNoMTBYRkc5aWVFZE02M2Zaek05WjZn?=
 =?iso-2022-jp?B?VUhqS29rN25FVldrbG9vQTRLbWlkWkgzYi9PTVp3Rzhla016U0hwRnlC?=
 =?iso-2022-jp?B?aWwvS0p0M2M5QWhVaDZDWThNZjJxNW1VTlFVWmVYOXg4TUJqUk8vYTZa?=
 =?iso-2022-jp?B?NVdqNnRyR24xOFIvd0ZBdVpxRXdlbCs4QmNBK0FUWUhBMzJzQkxZUmZY?=
 =?iso-2022-jp?B?N1BrclltMm4yMUxrS24rUjlZaFZVbDZLR0RlZnppWWJIU0tHcFN4dFRO?=
 =?iso-2022-jp?B?a1E0R2RzK2h2N1pzK0hpRVlYZ2tDaDQ4Z3ZoQU9MY0wvQWRQL2FZOWMv?=
 =?iso-2022-jp?B?R29qRVkyS2xKQlc3MXdTMm1mNHVRY01ublVHdU9rR3hERVRWaktwdm5y?=
 =?iso-2022-jp?B?L09QRW10U0tRbHJ1aitJOVNuYWd6aWhEeUJERlpzaUhqTjdMSU1XdDhQ?=
 =?iso-2022-jp?B?YisrdzVHLzVaTU9aa3dmWWJjRkt6TnhmQkFDNEJZa28ranpYWkcrYkNG?=
 =?iso-2022-jp?B?N0xUeG5udlhJcGdPQ21wVmErTVV5bHNVZnNNMnhTQVFQb05RczdMQmdL?=
 =?iso-2022-jp?B?Z1JNVVJjZ25NNExJMFhZSUFla2c2ZWcxaWp2Q0RTQWxZN2lZNnZZY05x?=
 =?iso-2022-jp?B?NFQ1dVBxUUV5djFEV09wdzgwR2czUVdFaFIwQlVsUXhYcGZRd2R2c3Bw?=
 =?iso-2022-jp?B?a1hFUDZCYXJNemxDWmhXM3kxRGRmQmNqVE5nM1RRWDgyY25DN2dFRjdJ?=
 =?iso-2022-jp?B?OElrSzFnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65373fff-7ac7-4fd0-6473-08d9d1b8902c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 08:34:47.2027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hz/RmCGM9QFgd8z4805ovpqYX7a2egZF5RT9Fgo9HEj97HqwD9UQXelJZdOdOZFZLE0yeyPBFC7B4QljpuQjNJ/td6cEfzSFBsVc++6bZ1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4696
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> I could live with that.
>=20
> Though the other reason I cut it was because I think it needs updates
> too and I wasn't sure exactly how to handle them.
>
> The v4 case is more important and should probably be dealt with first.
> I think the answer there is just "don't mount /var over NFSv4", period.
>
> And maybe we should be more specific: the problem is with /var/lib/nfs,
> not all of /var.

I see it now. Yeah, I agree. If we keep that description, we need to consid=
er the v4 case ...

After reviewing what will happen if we delete this description for /var,
I've changed my mind. I believe it won't cause a serious problem.
I have concluded that it is no longer needed for the following reasons:

 1. Users who build a new system with NFSv2 or v3 are not so many nowadays.
 2. Even with the nolock option, mounting /var is risky. For example,=20
   if /var is mounted when the system is running, the existing processes wo=
uld
   be prevented from accessing the files they require.

In other words, I agree with your idea. Your first patch looks good to me.=
=20
I think we can remove the part "using nolock to mount /var with v2/v3" from=
 the nfs man page.=20

I apologize for taking your time.

Yuki Inoguchi
