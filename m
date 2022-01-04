Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1B9483F3B
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jan 2022 10:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiADJdd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jan 2022 04:33:33 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:58739 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbiADJdc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jan 2022 04:33:32 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 04:33:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641288812; x=1672824812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j1sPLJujV+hu2kRWXq7d6S0cUiDrGq176R48nYXCZvE=;
  b=WACRjDeExtVYiIP5Zp6x3GZD62ThgGkKQ/thyWe3oSQvLO0pzZ7BGHSV
   j2tu5wCHuQe70ZxNQhnyrnIKdh/s/K2wuDMWtG49ExG0i6dnrzkU33dkk
   E54Z8wHGc/hnhG20xAEH7g0xQdfNQlJqPWlNN9Qs75WCxAZZ1IqbSSwe7
   +/hGATP1FYouWQPbIsC1WT2mpv8T59t47cN9fFUcoyZKiUil2YAphOLh+
   SzRNSpDm+ygK9RM3kpRa4yyqC9GtdVGzF1MX718VA60onbqFg6hpBw19T
   MtT0P3QeSI953EpN5ukcoLixxdutUeuWh+tVRcX0Jdpnu5T9ReqgRMg9+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="47930214"
X-IronPort-AV: E=Sophos;i="5.88,260,1635174000"; 
   d="scan'208";a="47930214"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 18:26:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaszxtMfjBaov3oDPFF1lwUaz3pqC6/fWYC+vMZj7SuwGZSY54eq/dx+ogpF26mT22milQdo7M+7SpbV7AQiGf41b4F2nYQtKGjVZKxCYX4cbel642WSFI3J2xHqI3C0gk1zOlD7OV/C/MxfVWiRohemhxRm8K8USrpkzZEOjDLadcn+OMOxFaxXDMmrcB5jZLjst2Uq4/tyaRR7tt/LmxoOgOD1ZIZ/+pvSZpBYaJ6QaHs38vc0HTq60tioiA7lJMGiK6ssWyMnNiFG2L3hCNF4ynzM8K2FjdGISUn9UAcv7MpLcDjCgcq876FMZlGVVtzxolLXDjgopRJLi64RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYlLLGgbX/PP7nm2OuJ3T+GqnkgJ9XFGfVQFGIj+cFc=;
 b=Gk54ppt6oRyGs1xknjVMUA8B2v5UBovh6hXoy1CkpefDMqbBGH1IwUMYz/shA/jfaUWQeweOE0LzRURlij6MFAUok+JRUjvUmDMakT2Y7pKqeP7AGo274b7pKoxKXmzeapigiTNrPAVUF/8ooYxaeblQDX5jWpXnYMCAh8z8uH52y5cPIGqSESQSem7Yy8fP11AD5ttGEnz9a2AFCOuISe2SjvAAStQ7zoh+xHlHBtTnVEyFA+g5rjXl1e5PT2fV54crJRBVJg9LIU9r9sZI4sxVJJ0D0R813hI+WXYyuNSgs1kY3guXGyZBg3o7kZ9fsyUdwkjVp7UCqhgGwqoYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYlLLGgbX/PP7nm2OuJ3T+GqnkgJ9XFGfVQFGIj+cFc=;
 b=lnTZct8IS8YEA105H3yPIgMzAJzUIIHbaB6Cgke5TyxRuLJ0gU8DzlsPfBaave5YT3TMXATFiGHhD0GMtlWlXihcNRvAK4KCVpSLGAywCzBsg+8PbM94p8G5iZMPyb+hO+Rp6tLQaVNKfWM2n0Hj1lQsuqhJ7gQ2dGxFJrRvZ98=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by OSBPR01MB4629.jpnprd01.prod.outlook.com (2603:1096:604:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 09:26:17 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::7d7d:1bbf:1f8b:6667]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::7d7d:1bbf:1f8b:6667%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 09:26:17 +0000
From:   "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
To:     "'bfields@fieldses.org'" <bfields@fieldses.org>,
        'NeilBrown' <neilb@suse.de>
CC:     'Matt Benjamin' <mbenjami@redhat.com>,
        'Trond Myklebust' <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: RE: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqMcAycEC0/pke1JkGmPD8pPKjeL0EwgABO2QCAAF7SgIAF4BMAgJ9AToCAAArJgIAHh8GAgr9HWraACijNgIABG0Cg
Date:   Tue, 4 Jan 2022 09:24:56 +0000
Deferred-Delivery: Tue, 4 Jan 2022 09:19:14 +0000
Message-ID: <OSZPR01MB7050F9737016E8E3F0FD5255EF4A9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <20200608211945.GB30639@fieldses.org>
 <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
 <20200618200905.GA10313@fieldses.org> <20200622135222.GA6075@fieldses.org>
 <20201001214749.GK1496@fieldses.org>
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
 <20201006172607.GA32640@fieldses.org>
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>
 <20220103162041.GC21514@fieldses.org>
In-Reply-To: <20220103162041.GC21514@fieldses.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: 0aa0b8609baa4ab8ae4d6396c1862283
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9Y2NlZWE5YmQtMjcxNi00ZGMxLWJjODYtZjg1?=
 =?iso-2022-jp?B?NTU0YzcyOTNkO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjItMDEtMDRUMDk6MTQ6MjhaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bca3d007-a58b-4264-904b-08d9cf6442d8
x-ms-traffictypediagnostic: OSBPR01MB4629:EE_
x-microsoft-antispam-prvs: <OSBPR01MB462941ED2559C52DB14869F5EF4A9@OSBPR01MB4629.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /2JTbX0tGc0KOU2zqzRmZL0CgqNWGAzFLSHw9I7esFhdr+B7DHx261dOnXDUa/7fK1rIYF5NjHdG19nULyHt/miStq2PAvTM2jAnyhQFJEMEGNugvfvdknkmcqFK67YmeXLyuZ31KuibRVEDArfQJoAHL2dsaqvOO2gBLDahjRTqN6hg1+OJdvsRCCnIZgJqIbBkAG29Bd1EvC8512STAWQIZdh32HCUSg7KKlUSgnUPrwWkWdZHtADMApVNtQKl4khDDKkkT0J6EQWoaaz5RVoh6/P8hHS4dpcoZ/HPCrcfWzlRba1I6P546xld+iU+nKAhVLpoXjxJRY3aW2Yxzx9BvexctmohpyYOUo7HGX+dcyMkTp04REjSesV+wuVu95bOLJqssNezWHjRTMYoeaDIz/scyCIrtvsKEPg73iGNHvVdT6wFYoZfu7/YmKb07fFm28xFkzrD7PxnSwsXu9AyXJkvHv41t+QtKHoHr60BsUcHPsRwvm4LZ+1R+omXudk2bNI7l7NbqRsQnfC1FFLOOBCjj91bK6b7oOg6xCMhEMxl5sGETrGKfeGYKuGDjXhFiesoH957jJdb/ja5XmhbTJWYgZrDmeSdkwBsiZ0GvGdtca1cIi2c6g/rQSNXNAUJWi0NbnTuM2azZj+DJKPvYZn/zoOSxi+D0r5/MMP4qrY6hc0Zt9lFNRfRff4e6jKCNCayqrbD+N6TP+Tuqf8jics6Sn5bzZKDPPAtFDOOgD7WSFTSIHqT7HlK5XHqhHU5BiWx2w1P8hzsvTTM8BTb61u+z2HUA0T3JcxaAooDcDyPuMCCOcHnthMuOkpaS7t3+gVCM8c0r12JEyCjrgYqAKOHBZyfE0TZtu0pgU4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(53546011)(71200400001)(6506007)(2906002)(38100700002)(66446008)(83380400001)(52536014)(33656002)(122000001)(26005)(82960400001)(5660300002)(85182001)(55016003)(186003)(66556008)(66946007)(8676002)(9686003)(966005)(66476007)(64756008)(6666004)(7696005)(110136005)(8936002)(3480700007)(76116006)(86362001)(316002)(508600001)(4326008)(54906003)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TkgyTU9qeUtuamUvQWdUcTJrRTRlL1RBdnVjWU5JdWVXajcxL2FxSGZM?=
 =?iso-2022-jp?B?K0pORkxBNmZ5R1JJL2RGWWhYbEVyNTJxRUVVT3Vqclg5ZEhvL3AzdDY1?=
 =?iso-2022-jp?B?cjQ5ZlZZWWxxcU5nNGpyS3plOFd4TWdkek4xQStNS3JDSTRNTW1RcFdV?=
 =?iso-2022-jp?B?WnQ3TzNrMlMyTXJ2VzMzd1hYODhKbVJLaG51MmhMNXhRSW8weVk5THJY?=
 =?iso-2022-jp?B?UXZ2aTl4c09UUGN0cnV0TFdBSDdqTEdCY3RWbUdJSFoyNlcwbUZiZnBM?=
 =?iso-2022-jp?B?YUM0SnhKQTZKdFJUWWU3V0VFOFNmYldJMDI5NlJxVlQ2U2tmZHFoajdN?=
 =?iso-2022-jp?B?ZTJ1amVocFdKekhGT0Vsa1RBZ0hTS2x1QTkycjcwaFU5aWlqeGtuQzEz?=
 =?iso-2022-jp?B?bVBYMnRDbjlPSWhyWG9DcG5vQmVxa2NXcFZMOEZNTlNQK2p4VTFtNU8v?=
 =?iso-2022-jp?B?QjdkcVRaaDBMcDExYkVCVW9iR0JHRVJXQWNYcXBnNmNENGQxVXNmVmFv?=
 =?iso-2022-jp?B?Q3luRXZrdFRleE4yN2lZOVFFa0F0cisvV2ptZDFRTEtDSTdpODR3KzBn?=
 =?iso-2022-jp?B?clIyaXkrZk9ubWtIa0xTS1NmbmZJdWQ0b29WL3VHRDltakFLYUtpakJS?=
 =?iso-2022-jp?B?ekh6eGpmZXM4aExRakJEMzkvZ3BEeDJXcmVDandaakRZU2ZwbmppeXBY?=
 =?iso-2022-jp?B?WGxEem9BeStaU0FmREU3SmRLTzcrM1pRaEpYN2R3VGdzdFdybXViWkZO?=
 =?iso-2022-jp?B?czZwL1BqSmI1bjltQ0RWZjMxMjFpemVYTnBXdEI5Q2c2YzRoSWtUR1Fq?=
 =?iso-2022-jp?B?R3FVN0Y5SlpPTCtlNWxlS2VTT2Y1b1FSak16ZnBkci9hMys0NDFwSDdj?=
 =?iso-2022-jp?B?NkF1L2ZqdmhjRnlCc0F4aE5CR2o0ZElUUVNOQkUyZXc3aTdlSGdnVEZR?=
 =?iso-2022-jp?B?aFdzQkxrdk1TNk04eHNGOUFSYlpPa3dkQXBvWFo4ZmlxbXo5QVQrbEtI?=
 =?iso-2022-jp?B?eFd5YndubUw2aDd6ekVSa0pkUFlZN0xNcXhFTDBqQXFqU3k0V1piUEgv?=
 =?iso-2022-jp?B?M0NXTzFESy9wSWVyZlpCaFdkemFtakFCN0R1Mi9LeWNSMW9ncU82bFhl?=
 =?iso-2022-jp?B?blQvWGx5dElQVEZZZHZFak53Z2ZWbVljK21EVVlBQ1RCTEY4dGNYQXgz?=
 =?iso-2022-jp?B?bSs1ODZibnZZQzVSaGd3eldyVjNsYWlwYmRiYlhMdUlJZktlQWUzUmx4?=
 =?iso-2022-jp?B?bnRheUc2UWllRHFRT0o2dnVMMU5KQ2t3UTlRQ09rb0lrWXArcmMyU3RT?=
 =?iso-2022-jp?B?N0JTNm5zL2ZNb2JjSmlZdmtSMzdVZU85cVVyYXVwSnFkY0cxQVNjSVJk?=
 =?iso-2022-jp?B?eWJSZ2Y3d0lLQlA3WDUyYVVqbHVRZ1V6N3RSTDRacStDandjaWg0NkF6?=
 =?iso-2022-jp?B?SGtMRG1nLzI1Qmc3ZWE2aHpFdEF0b1YrcU1BRGpGK3NTdlZpM1ByZEtx?=
 =?iso-2022-jp?B?VW0wM05oRGp5UEwxazZGTjVxTi9IT2JiVlRTR3dCTVBCOHpWNE1YWHhG?=
 =?iso-2022-jp?B?WTZpVXFyamRwb3NCaDdHS2w1NDJSWW5SRGpubHNydDJ5Z05PcmY3eitk?=
 =?iso-2022-jp?B?UklxbnZxeDhQYUJOckExVnlrWmxpdFV2Y0ZXd3h5cU9LTTJsL1JvRit2?=
 =?iso-2022-jp?B?OVdGN0lzWHNhSDlzUWRSOCtWM2dHTmRLeTRHejVncVpTWFM0NTdWU1Fu?=
 =?iso-2022-jp?B?RnZFSjAxek5zcHlZbVc0dCtmR0Nvc08rUkpHQngyOUNNZ1FmazN2Yk9W?=
 =?iso-2022-jp?B?OGNmZytxY0RPSXJzd3U4VlZTMytRRm1UczZidVVXWWJBaXptYkxOUmRo?=
 =?iso-2022-jp?B?ZC9RaWlmNUlNMUpuZmFuNUFvTjhvVkNPbUJVVjQ1V3ovY0JNTzFRbXF0?=
 =?iso-2022-jp?B?Z3FWTHAxQys5c1ZZR2VObC91SFpKRzhjekYvMmpwb0ZMcDhQcW14VjdN?=
 =?iso-2022-jp?B?aWwxenBQSk12ZGxXS1FPVzJ0WkxPTE9ENFlMT1QrZ2REZFJLMDg3b2Iv?=
 =?iso-2022-jp?B?TW1nRk5GUWFkd1g0R2tjaHRCNEpUZ04zN0Y4S2hEMFU4bHlSWGI3Nlg3?=
 =?iso-2022-jp?B?OVlQM2E2M2Z6ek42WGNFSVdpNkRaNitvYjFMVWwweko3c3VQRFl1TXpk?=
 =?iso-2022-jp?B?cGRSRGFWSnQ2RCt1L1djWDI3ZHFVSmUzUWpMd3lORHNxTi9BYW5yY2Rj?=
 =?iso-2022-jp?B?SHNYTFdwVmpQZ2ZmTDJTek1uSGZNa2o1WlFxSDF1NDRId2JodFNTWjBR?=
 =?iso-2022-jp?B?L1dpMzIwMzNiWUpxT1FjYUNxUXFQendGL1JiRllsWHRXUHcxZGlkTllM?=
 =?iso-2022-jp?B?UDVCcGJVNStpY21sNUpaZ1FiUnE3K3o3dUVUQm12TzBtOHlRMTZ0V1hR?=
 =?iso-2022-jp?B?N3BqbGd3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca3d007-a58b-4264-904b-08d9cf6442d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 09:26:17.3479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqoHVuKwEhYDXBKBafpGlosGq3/PjhJcReB46QYeSsBaxQVmBjmX1YjaNQqDOfIh1di+uyB6TVugJ9yaehxaPD1ryZmKEojBThxVX/CbpmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4629
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil and Bruce,

Thank you for your comments.
Now I have understood that this behavior is by design.

> > With NFSv4 there is no atomicity guarantees relating to writes and
> > changeid.
> > There is provision for atomicity around directory operations, but not
> > around data operations.

So I feel like clients cannot always trust changeid in NFSv4.=20
Should it be described in the spec?

For example, the following section refers about the usage of changeid:
https://datatracker.ietf.org/doc/html/draft-dnoveck-nfsv4-rfc5661bis#sectio=
n-14.3.1

It says clients use change attribute " to ensure that the data for the OPEN=
ed file is still=20
correctly reflected in the client's cache." But in fact, it could be wrong.

Yuki Inoguchi

> -----Original Message-----
> From: 'bfields@fieldses.org' <bfields@fieldses.org>
> Sent: Tuesday, January 4, 2022 1:21 AM
> To: NeilBrown <neilb@suse.de>
> Cc: Inoguchi, Yuki/=1B$B0f%N8}=1B(B =1B$BM:@8=1B(B <inoguchi.yuki@fujitsu=
.com>; 'Matt Benjamin'
> <mbenjami@redhat.com>; 'Trond Myklebust' <trondmy@hammerspace.com>;
> 'linux-nfs@vger.kernel.org' <linux-nfs@vger.kernel.org>
> Subject: Re: client caching and locks
>=20
> On Tue, Dec 28, 2021 at 04:11:51PM +1100, NeilBrown wrote:
> > This is due to an (arguable) weakness in the NFSv4 protocol.
> > In NFSv3 the reply to the WRITE request had "wcc" data which would
> > report change information before and after the write and, if present, i=
t
> > was required to be atomic.  So, providing timestamps had a high
> > resolution, the client0 would see change information from *before* the
> > write from client1 completed.  So it would know it needed to refresh
> > after that write became visible.
> >
> > With NFSv4 there is no atomicity guarantees relating to writes and
> > changeid.
> > There is provision for atomicity around directory operations, but not
> > around data operations.
> >
> > This means that if different clients access a file concurrently, then
> > their cache can become incorrect.  The only way to ensure uncorrupted
> > data is to use locking for ALL reads and writes.  The above 'od -i' doe=
s
> > not perform a locked read, so can give incorrect data.
> > If you got a whole-file lock before reading, then you should get correc=
t
> > data.
>=20
> You'd also have to get a whole-file write lock on every write, wouldn't
> you, to prevent your own write from obscuring the change-attribute
> update caused by a concurrent writer?
>=20
> > You could argue that this requirement (always lock if there is any risk=
)
> > is by design, and so this aspect of the protocl is not a weakness.
>=20
> The spec discussion of byte-range locking and caching is here:
> https://datatracker.ietf.org/doc/html/rfc7530#section-10.3.2
>=20
> The nfs man page, under ac/noac, says "Using the noac option provides
> greater  cache  coherence among  NFS  clients accessing the same files,
> but it extracts a significant performance penalty.  As such,  judicious
> use of file locking is encouraged instead.  The DATA AND METADATA
> COHERENCE section contains a detailed discussion of these trade-offs."
>=20
> That section does have a "Using file locks with NFS" subsection, but
> that subsection doesn't actually discuss the interaction of file locks
> with client caching.
>=20
> It's a confusing and under-documented area.
>=20
> --b.
