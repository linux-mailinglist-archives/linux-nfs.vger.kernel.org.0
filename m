Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7611D48610A
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 08:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiAFHb6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 02:31:58 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:15583 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234484AbiAFHb6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 02:31:58 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jan 2022 02:31:57 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641454317; x=1672990317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DMPRFWsF2Kjsa6cK8Gdu6bOtk5kfZx28PL2HGCh/SVw=;
  b=Z0Zip8dcA5h5NpGe0GvqFMyCpf0aYeGHdI24M6RWBgjzrL+tg7R/AKy8
   /WJ6QGYHJI/miQEKWtvHkRPBTRK8qsjx97k7r8JLLU/yBAs9VTDlBNBao
   p15Vajs3kNMhCyal2X//RAUDGEgGzJKaqlYeotyOh6ZWgnBXG+d+v5W82
   J3X1PuVdRJAxFZVswEBWpPL57jaqAvoTLHc4MaJ3P2d3HtF9KBjJ1chu+
   8FOE/PqdjoYpGvWUttbNMn02hA4zASeXKqNh48g4tZvKrdVuHoAqsVy2S
   bkPDffFRcYEHGhK4nAebv69B8bofGPRHkHJ5aOzIxiz0PMY5hHXbePs6r
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="55204911"
X-IronPort-AV: E=Sophos;i="5.88,266,1635174000"; 
   d="scan'208";a="55204911"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:24:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVX0nyY0YJ+tss4R2JfEf/N28DYWyp8K1yUNG3/8UYxnUEHp0JhZLh6ch5F0qUJfhFcqnMGyWjF4HdHufprhgWqz9RNWE4wYqjJBfZMWB3W3WdPeHe8UZZxUKhQQzb28csZlAmEY0q48o125H+o/6Q58MM68R8hWoz68U7q1CCQ2Hh1amyOWOERNz0tI1bo9L2XWG1EfKCWcCkYd/TCBx8DjFTYvdcCszcZwlIEY0zj6IpHaIuaOLjk1kEEftBvZMNZpeB4pD+9Wy0pTh4HF5l2uRTZqOLm3cbM168p1Z5DK+6W/bEFJA2uNYjfK/3TI+d9SNxZkZTR88FUb6PWuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTIHtzmKCSF7t3ckZFkEaedOZkZqkFfCwTNej405v+k=;
 b=dkMZwpPGQ/a/Q3wZhH0gNbJ40hV7dqXQ27Ni/Q/VfY0l2R0xtbG20dK7C0FNmFglOtpSWEEEaZv82FVDhPMPiJorRLCE4sT5FQDi3x0lGnKPSb6ZzCOP98WfsiQDGDJ8OSl/QZEHzPYNeil+DBT8GFPSAYh0V6ZB1EkA0fzTL8PuS0QoP4hEpGkfQXAwQsZS90bw2QZlj8QT4mx27AAhJvd5AQtXuzZOe+oUPTTZMsw1XONKfalRi+0h6csJ7qxki5wPZSiFPuxQr2x5FDj9m2vEYRgPDXetCnt32Er2oPn60RoCaGzadm8kB5apEreOE/jhT3a7St2NUIr8hJ4CGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTIHtzmKCSF7t3ckZFkEaedOZkZqkFfCwTNej405v+k=;
 b=P5cLAyL1LWWRe2zUsiyyjkAp1cCp+Bdlu6Z23MuWzfLG9Itq7Pmam8/0KdtyvK45rV/61DEKXUa22sW/QxAXMvMw2g9ygNuy0WS4WnbwTwdujUAb8M/OwV54c7AoItsMSAxFsDsvKgGp2em5cnfnESy0YV02k8QHbEZ4i+OrhGw=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by OSAPR01MB2145.jpnprd01.prod.outlook.com (2603:1096:603:19::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 07:24:43 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::7d7d:1bbf:1f8b:6667]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::7d7d:1bbf:1f8b:6667%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 07:24:43 +0000
From:   "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
To:     "'bfields@fieldses.org'" <bfields@fieldses.org>
CC:     'Trond Myklebust' <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'neilb@suse.de'" <neilb@suse.de>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: RE: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqMcAycEC0/pke1JkGmPD8pPKjeL0EwgABO2QCAAF7SgIAF4BMAgJ9AToCAAArJgIAHh8GAgr9HWraACijNgIABG0CggAA4XwCAADEigIAABkSAgAEmVACAANM0gIAAmsvg
Date:   Thu, 6 Jan 2022 07:23:16 +0000
Deferred-Delivery: Thu, 6 Jan 2022 07:21:09 +0000
Message-ID: <OSZPR01MB7050BC53F1F38FAA579E03B3EF4C9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <20201001214749.GK1496@fieldses.org>
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
 <20201006172607.GA32640@fieldses.org>
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>
 <20220103162041.GC21514@fieldses.org>
 <OSZPR01MB7050F9737016E8E3F0FD5255EF4A9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
 <20220104153205.GA7815@fieldses.org>
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>
 <OSZPR01MB7050C5098D47514FFEC2DA82EF4B9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
 <20220105220353.GF25384@fieldses.org>
In-Reply-To: <20220105220353.GF25384@fieldses.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: 7781f70e133b4df7a082b7ebbe8d3c4b
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ODA0MWM5MDAtM2NhOC00MDFjLWE0NjMtNjVi?=
 =?iso-2022-jp?B?NzhkZTI5ZTQ5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjItMDEtMDZUMDc6MTc6NTRaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 677b23c3-9f09-4430-314c-08d9d0e59c58
x-ms-traffictypediagnostic: OSAPR01MB2145:EE_
x-microsoft-antispam-prvs: <OSAPR01MB2145B7017640721D31C8AF8FEF4C9@OSAPR01MB2145.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QvqEX6LiCoTAnVvslkMrrcfFZlRH4eLSOqr417x+lsVnC7zGYC3iEvh3Y/J84iLGcatuvvVDCWk8Bu4Y8CXyrLoVkf91LfYkeHFycLmoHxC/eFjqr/TNhC08f1EulwvkMAbExCSZFreImode2XqORQgoDQb/4Ux2YCIrBVNiWYYpDHVcCZJ+JxjFDvvOBSojMlba7aj5IPfW30fPcbSF5LCmDTcvG4r/C0az2Qmqcq3vW597foU7QeZNgT6I6Pr7HeWTF2u3DUKPtIL07Z+IKVaDWHBAyckoae8erSj58p/l32sfnRyZTzrHEXbU5xmvlWaorCU1D7lA5ZAfvjso5qLMPYXzgh/i8n6K0p3TAZ4NB5mSBZQqZM0KU+4nPwHaWRYL62ufbvIUinijDuZzpmpD23NSqgP4TP2gTcEJP2g9tVDJkh8F1vIoUpFw8FI2EUq/FD2dYMAXg8jr/dZEf+RJdOaVeRY6FCT2jRzYF/T6qmmuxw5Nkh/KpfEE4q5C8sBwVZMKxSdXEhuz63i/uuPiTg4yneF1JOwCfLo4HEUmpjRIvkFhxRpB2fETEwG9KQ5dmLr+hkaUOLlxNY1Mx1EdWDdW+fU534FVrxLfjn4RWCEABu4JRgnaIoUNPXXkahepT32XxlNgjHnVDhPEgxxbpI/GPLdDCwm6pukzXDc/DAvfZOpNblB7ieKFNC4A74lVBLjaw+2lTSBzis9Szyko3aZQXHmCwmyhqyFJdAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(85182001)(122000001)(6666004)(3480700007)(38100700002)(7696005)(55016003)(64756008)(5660300002)(71200400001)(66446008)(66946007)(66556008)(66476007)(9686003)(38070700005)(76116006)(26005)(4326008)(2906002)(316002)(54906003)(186003)(82960400001)(83380400001)(86362001)(6506007)(8676002)(8936002)(508600001)(33656002)(6916009)(52536014)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?c05aVzF2cU5kZ2YzQ2lQQTh4M25VUlBJMjJtWDk5ajNpMEhNa3N3cWZM?=
 =?iso-2022-jp?B?STdraWxnQWM2VXFoNE1EdElLQ2RyRkIvbHBiZGZCdkJTcThUakI4dTNi?=
 =?iso-2022-jp?B?WklBS2lKTmloQ2xaRjEvdU1qTkdUNGU0V05NNjREeUlsbDE2MWNwOW82?=
 =?iso-2022-jp?B?ZUd1RlVDdTVPUUV5TFFwWGNIa3FaUWJwdkdUQXkxeDFmdzNiNm5QMzB1?=
 =?iso-2022-jp?B?VGIxN2VvbXJNbmVCMFFZWGs5NmwyOUNzR2FGaVRZK1R6RzVMLzd0UVpN?=
 =?iso-2022-jp?B?V1RvK0hpWFRiRUgwS1BFV3dMS2hLV2xtUlRvODFmRU5HVlNGVlhtRmtx?=
 =?iso-2022-jp?B?VjZ4bG54WmJXM0FOY2RXY1MwWlNKRGlJVWQ2N2tFTm9iZDhtaFVham5U?=
 =?iso-2022-jp?B?R0RZeFNyY2ZOOUo3SXJxSU1sdVBTTFBoWEp0T0xJRUdlY0ZKWExIcHlM?=
 =?iso-2022-jp?B?UTJxaE1qTmZMOTlJQXpiSWtXUGxrcEV0MEFPdVQyZnV3bHdrNXlyaVYw?=
 =?iso-2022-jp?B?WjBYY0lCVUU3RGlSMVN3aU83ME1nVVNKYlpxbnlDTTFLWFdDVmlqSk9S?=
 =?iso-2022-jp?B?elpxT3VHcnpHMS9wd2RvL2lOTzF4aTFscVBsOE9lSUFkd01aWnQ0YlNH?=
 =?iso-2022-jp?B?THFnSXhLRDloUGxWSThhYk5ObU9rL2ZmeHFqUU5EUjhUWGRucVhpODlp?=
 =?iso-2022-jp?B?M0QwcDh2YjFzTEJlODROR2ZXU0g1VlRNem91UCtEMmNrUDUxaUt3MmVI?=
 =?iso-2022-jp?B?d3htUlduenRwSTBPL29MM3JsQ1d4MXVhcGVjclVEWWJTb2s4MHJNTFY1?=
 =?iso-2022-jp?B?QzRSc3VmTWt1SlZtSXpxQys2dC9KOCsvUFRoZU1CWWRUOGdyc0V6L1Q4?=
 =?iso-2022-jp?B?UHZHV3k4NnBteVlVaHZYL2pwZ29Ld3lZd285ZTN6ZnBPNDBGYThXaWoz?=
 =?iso-2022-jp?B?WkFWRVQ4V2FOM1RnMmRaOHdnNEFvQ2RRSStpckcya2dUV3VCR2Q4Ni94?=
 =?iso-2022-jp?B?STRhMi9nWTZmSDNwT3BmMWFQZmFSaHpYYitUVHpRV3k4RkNKYWdrV2FV?=
 =?iso-2022-jp?B?V3ZMcjlkOHBGdmk5NUh4dlhjekZyVmlGakhwSjlyY0w4U044VURVUDVX?=
 =?iso-2022-jp?B?Wm00NkRoUk41OWtzdFpaU1M0c2duNVdqRHkzOW5lTTE5WHM0ZXhDaHZm?=
 =?iso-2022-jp?B?YUlycU9MeFd0TWEyeFNqK3B2ZEMvNWZoMEFydENPWlB1V2N6Yk9mK0NU?=
 =?iso-2022-jp?B?TUNkOHVUNWdtM3NqL0ppbmZFaHF2bUNsemM2NEhUSUlqQ0RRbTl1TEUv?=
 =?iso-2022-jp?B?UjhkcHVzUGh6SXhKa1J5L3lBUHUxQ1I2UURSQkVZQVRTVzNWL1hrZlBZ?=
 =?iso-2022-jp?B?TU51OGF3T0ZLdDIrZUJzWmZnSERrTVROVTlQQ2Z6UXlSM09DR0Y5eU4x?=
 =?iso-2022-jp?B?SVN1YTBXUndzcnBsOFlZMzlRTkNuYUx2MmtncGVkdEZPOGlVRU5tYk5i?=
 =?iso-2022-jp?B?THVZeWN4ZHJPYTBHcTRTQ2NNblowSmR3cHhSbHBLWmJsTjBTUVQyWWNu?=
 =?iso-2022-jp?B?aGthaVliclVFc2tzRU1pTHhaWGdxNjdiZUdOdWwzVEVReDdVYnpIQ3pI?=
 =?iso-2022-jp?B?TlBSUmR5eW1qOWgzMk1hWTBIa0lrZUdQdWxYZFJrWmFzRUpZai9relVO?=
 =?iso-2022-jp?B?MHFwb09kQ0xTT2hLVSsvYlQxaVV3NjZBZ0JOU0s2WEVud2dqbGNuazI1?=
 =?iso-2022-jp?B?TG1rWFRRS3ZEMW05NXNKN1dsdUZYM3BsbmwybzFIbHRKK3hyZGZBRnVZ?=
 =?iso-2022-jp?B?QVkrS3doNk5Fa0YzTVJHdFpMZ1ZFM3V1MDlkUzgrdUFoZS9RZ2d5NC9M?=
 =?iso-2022-jp?B?czRqRDh0Nnp3NlYyT0FoclhLWGcrTVNocG54WnFlK004cFZIczk1aGZC?=
 =?iso-2022-jp?B?WTU1L1NuZmR1N3FIY0c3d0FCMENoOTBtSEwyaVFuZHNZQ1FpbUJLZ01z?=
 =?iso-2022-jp?B?dVhUT0dzdjZGVGFteVBtai9zc1k4aVcvbEhYNDVwVTA1b2JQamlHL3Y3?=
 =?iso-2022-jp?B?aFQxQ2x1d1VQam13MEZya25lWGZwR3h1SWg0bnhDZ1BpY0FPcnhuOTBs?=
 =?iso-2022-jp?B?Q05ld2dxb2ZMb1VyM2VDSUIzOUxMcW5pT25UOEY4dUxtUlhXeE56Qysz?=
 =?iso-2022-jp?B?NW83empjaXRoZldtbjkyaEJjdndFTWlEclQ4SVRZb2tUNExlajROZzU0?=
 =?iso-2022-jp?B?U2VqWmp6NVRzUDJ1dDZiZEdMYnBCR3l1TFVoNGFJNnZPNVRhdkcrOU1I?=
 =?iso-2022-jp?B?dk5YSGliWnJ6eHBENU9saWRDRDRqVlZoZ0kvKzR1OVk1SlJxSmNiMTBk?=
 =?iso-2022-jp?B?YWVyQnZkbjJyb2UyeENHRDVjSitzeFU4MnlTbUN1MzZ4REpwWlhtV21o?=
 =?iso-2022-jp?B?czJLTkJBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677b23c3-9f09-4430-314c-08d9d0e59c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 07:24:43.8201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTlCMyRjOd6KqHgWujlnIaRsk5hs7cKvFU7Hs1phNIDOKE2XCJmOxRA2Q+9Y77Ozi3/T5fr8cwgDTdNR1IaJyxkj4P4Fnoe5o4gbjgGl8n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2145
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> How about this?  I also updated the lock/nolock description and deleted
> the end of this subsection since it's redundant with that. And removed
> the bit about using nolock to mount /var with v2/v3 as that seems like a
> bit of a niche case at this point.  If we still want to document that, I
> think it belongs elsewhere.

Thank you so much for creating the patch!

For the most part I agree with you, but I feel unsafe to remove the part=20
"using nolock to mount /var with v2/v3" even if it seems niche case.=20
I'm also not sure if there is another suitable document to migrate it.=20

Therefore, at the end of "lock/nolock" subsection ...

> @@ -733,16 +733,9 @@ but such locks provide exclusion only against other
> applications
>  running on the same client.
>  Remote applications are not affected by these locks.
>  .IP
> -NLM locking must be disabled with the
> -.B nolock
> -option when using NFS to mount
> -.I /var
> -because
> -.I /var
> -contains files used by the NLM implementation on Linux.
> -Using the
> +The
>  .B nolock
> -option is also required when mounting exports on NFS servers
> +option is required when using NFSv2 or NFSv3 to mount servers
>  that do not support the NLM protocol.
>  .TP 1.5i
>  .BR cto " / " nocto

... can we keep the description like this ?
-----
@@ -733,17 +733,14 @@ but such locks provide exclusion only against other a=
pplications
 running on the same client.
 Remote applications are not affected by these locks.
 .IP
-NLM locking must be disabled with the
+When using NFSv2 or NFSv3, the
 .B nolock
-option when using NFS to mount
-.I /var
-because
+option is required to mount servers that do not support the NLM protocol,
+or to mount
 .I /var
+because
+.I /var
 contains files used by the NLM implementation on Linux.
-Using the
-.B nolock
-option is also required when mounting exports on NFS servers
-that do not support the NLM protocol.
 .TP 1.5i
 .BR cto " / " nocto
 Selects whether to use close-to-open cache coherence semantics.
-----
Yuki Inoguchi
