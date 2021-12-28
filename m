Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4090D4805C1
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Dec 2021 03:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhL1ClH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 21:41:07 -0500
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:4520 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234607AbhL1ClH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Dec 2021 21:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1640659267; x=1672195267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RIpQa6OtVWdlWzaQryVj4X1v56JpgAhkFHijueONfIc=;
  b=B0jgDyIO7KVyN4MPfRflPPucecJ0IkGZvL4ToFp0jHUj5D0ytBgSqnsG
   JwlP/zCe3JR+f6JQy+f7oZhET7LRGKeJ5wi4m9v6Poo1J2Ub5VH2OGB9/
   7Ga6zipmgCGiDfSTi2XJft8c0OFmQREIRKCrCb59h7VbomAF9jbdBny2e
   Ill3Y/veDTIlQnKfKHVvvlig0a4Rs++Ag8al+kALBVnFZszPr6XcIIh1W
   ysl1SaxRgn16JHCSltFV/yMasUwA8m5IH5p1WauDphGwmBGH9ytaIZvqN
   l0FZaV4WZ4WlwxIa7PJiWcGH3tfDLVHQkixGLcikvpEpHvPRkL9L6g367
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="46711944"
X-IronPort-AV: E=Sophos;i="5.88,241,1635174000"; 
   d="scan'208";a="46711944"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 11:41:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhlfV7VwxvhXRbn/M25KMvqRSczmLLOI8yG5qboLCrTp9mrimj/m0PJfAwZgjx0No9VzHsyhVRVkmiDnZR6C548Dc8+fsGDnP4ThiABHPu0FhY/y1cRaV2XKhu3kgaioScllfGc+SF5XAK7y7f9lRY9SVigdPE33yaSJ/Etpe9ZR7ArUyz3zCmhsK2FUq6dHIlv1OQMF9lRzGKgYzZaglFTOH8C67+jT34Dqrq19J1tsuvB9XMamKjRVuOIKNQfQ1depLUgZ9EWI3zzEBJF6g+JwwKE3i2UtIW7PmMJhJ9H1DPAXFPz8yaf0DzubHm/pa5NkicO+zpouxOOjoWAS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqO1vZztI8d0Y9hf9nXsbpq+432GMaMcQ8JMMZz1A8g=;
 b=GJIHRttw8BHCfTpquAZcI0u+VOP9aQa9auWAf4nmxL6ZgG1IldqF7mm8K2CboGE43oV7G6YpuUUUJXD6mi3RsOXC/rqO41boVxzJQx1k9Uh3w9HdwPH2N3XBHknSLb3olM2Agg64+cT2sAXjIN1l8zUTJThtp+LEWXLYpK3o1gv3xQ9qSBq1ifOVWO/HGTtznhLQM/ev72zhJ1GFaWyQAFg1Lgwd27XJfAVn+Nh0wzd/GtmricndcgX0A2GXjHzA/8ubh4JjwfyY6SHO2R/YjB9Z1AvGORci5TBweIaYpRYLQsiW5xNpfHNQ34s1hUFC6FC6EAaLx6k663R3kxkKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqO1vZztI8d0Y9hf9nXsbpq+432GMaMcQ8JMMZz1A8g=;
 b=OnNheVbJ5VttL65/QseptHs7g41xS3agJ2Oce25GLJlBSAgPP/HWfdwUGDr9bwYiw2lsO0ig0C4/NMGp/pCcGMW8iXUw56qqT+EC8a3vcQ+8/EDfGOR71AUMuE/ATVvJpoJ3cMx+DN48uu4ehG7BdGeCEFjUxNMN/kz+bXyaUK8=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by OSBPR01MB3912.jpnprd01.prod.outlook.com (2603:1096:604:49::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Tue, 28 Dec
 2021 02:41:00 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::7d7d:1bbf:1f8b:6667]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::7d7d:1bbf:1f8b:6667%4]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 02:40:59 +0000
From:   "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
To:     "'bfields@fieldses.org'" <bfields@fieldses.org>,
        'Matt Benjamin' <mbenjami@redhat.com>,
        'Trond Myklebust' <trondmy@hammerspace.com>
CC:     "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: RE: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqMcAycEC0/pke1JkGmPD8pPKjeL0EwgABO2QCAAF7SgIAF4BMAgJ9AToCAAArJgIAHh8GAgr8TGeA=
Date:   Tue, 28 Dec 2021 02:39:59 +0000
Deferred-Delivery: Tue, 28 Dec 2021 02:31:31 +0000
Message-ID: <OSZPR01MB70504AD76843695B93634510EF439@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <20200608211945.GB30639@fieldses.org>
 <OSBPR01MB2949040AA49BC9B5F104DA1FEF9B0@OSBPR01MB2949.jpnprd01.prod.outlook.com>
 <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
 <20200618200905.GA10313@fieldses.org> <20200622135222.GA6075@fieldses.org>
 <20201001214749.GK1496@fieldses.org>
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
 <20201006172607.GA32640@fieldses.org>
In-Reply-To: <20201006172607.GA32640@fieldses.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: 2bce631b5307467bb5db8a433288a977
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9Y2E0M2Y4ZDEtNDdhYi00NGQ2LWFhOGYtZTQ2?=
 =?iso-2022-jp?B?YmZkNzhjNTNiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTItMjhUMDI6MDU6MDJaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 712b8a18-7621-4403-30d8-08d9c9ab7b6a
x-ms-traffictypediagnostic: OSBPR01MB3912:EE_
x-microsoft-antispam-prvs: <OSBPR01MB39125263FF187C2CA83AF655EF439@OSBPR01MB3912.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzdsfECvqz4xx12wDSHdGNbPYSI2dKlM5A00ZONUSd6QorsESQIS2Cz5Z2QRQbEb+d6NhRgttYI1RabtU/6Brm1I4RdEkyDh9lYETeRyuhQloiSeWUuwK8sjIglsBmLgAs+2IYl4JRdi/nQ41zW+ww6dgWsa1C4AQNBjhp0pneA4e7zK47UCKGTegCniUb9lUIVv15s6h2yyvmvU8UpG8gGHuOCgQ9L82Hjwgqj2k0qPFEeu/jAkPob7XVfE7ht+OBSzmCFPSTbspt4w9prxx/y2G8MfCU8Mz+x6f8YO9Y8PyJND9jrtBzfyLehDyVwXo8zlv+fAlaEkpmnh0Ic8m/B3GNiIE9crnBedf+kYIjWops0g0J1F+FqOavo5MLqELkzqddsyuZtcX6w/7fQbowzAnOZOidfYJt7eR2apXepyx96yN1cLxwVufh4iZGX/E4sYibi9DT2nvyK/gV2TpfecsLhuVfm/cqYXa25GN7zB2OPmemvJ7RJWqtcy5V7vvq4dYxL+LHc41rJhDIsVNmBsH4RwS0kfEEaflEP2bU3B2R0x09Edl9v7k4Xk/emzvYazUTBB0FCY3YXm/0L/ZuQYCAfhY44kKgCWlZTkJciRX11z8oihKmipEgy+Kmz5k4yywXHW60LHG4oZClqjR+B2K7gHhybzEn6S5To1+Q6h8fBNfyT3zfMA1/sRnSxKHPZ/T9icFYMmqFJ1KmqrIBsoJTQC3WuSBpJrxqmxdlXlPWltTI2l2j7nOaTuqYNzEyQ8YtyOzwm693aqqvTRGDVObH1W6qYod4v/T59JH1KrYloK1wmHR7L2/ipF2GGYmDqCr53ft48ePuHsHlPZxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(86362001)(2906002)(26005)(8936002)(110136005)(186003)(33656002)(6506007)(53546011)(38100700002)(82960400001)(30864003)(4001150100001)(9686003)(7696005)(76116006)(19273905006)(66946007)(966005)(122000001)(508600001)(5660300002)(66476007)(64756008)(38070700005)(55016003)(71200400001)(4326008)(66446008)(66556008)(85182001)(52536014)(3480700007)(83380400001)(8676002)(40140700001)(491001)(563064011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WlNpQjdhVk8yL21jK1luYzdOSGw4RUxXR2lMODd2YTVPMXVUa29ibk9m?=
 =?iso-2022-jp?B?d3lPd0lRNmxyeSt4Z1VDckNKQ1BqbzBONWVoOVVYWWtaSFpuQTdQZWVt?=
 =?iso-2022-jp?B?c1BvcW1uM2YxZVplS3lGR0ZOenAwdUdWZjRXR0RwUmNoNThDWjZjQ1py?=
 =?iso-2022-jp?B?SmNTeXRKWHQ0VUwxcURBV2NMa2ptQUJjMllyRHZoWlJjcEFJb2p1MUd1?=
 =?iso-2022-jp?B?TEZDWDYveUpSdFdlQU42YS81L3hqOWdNWGM1YWJxQW8rbGtuS3k5OWl3?=
 =?iso-2022-jp?B?eERaRUtGc2VHaTFwbFhjaEN3Z2JYalVuM3RuaDBRQkFNM3NqUk95V2ov?=
 =?iso-2022-jp?B?TGh3b2pzcWlMeml3Y1FSYWNzdE5OSXQ0TUZyb1VxdWRoQ3YydzFRL3hm?=
 =?iso-2022-jp?B?RjRnajBTTG5CbjVTSENIUjk1U2tld3Q1WExReHJPSE1aZHFTaVIwRXBD?=
 =?iso-2022-jp?B?U0o0U0JYL0pmbFJCaVM4V1NlOTRUTHhCSUxqb1NzVU55L29LdjBNbzlZ?=
 =?iso-2022-jp?B?U3AyY3pBSlkzOUtTTFhuUVJrZHR6Ly9jbHUwNjBlZjhaQnd2WFBYV2d5?=
 =?iso-2022-jp?B?Uk00Mm9Lb1A1WTRMaG5WZTNPQXBTOU9qZmNqNHZ4NzRPM1RlL3ZVR0N1?=
 =?iso-2022-jp?B?a0srdVZGZnFiQ25JbFlEZ3FGVWZQbmlUU0hTSlc1YWZxYW16WDZta2lO?=
 =?iso-2022-jp?B?R2lOeEY4eUFsMFBtMzdDN3l6RERzemp2QjZmdCtneFZWMWpaS2hVMko2?=
 =?iso-2022-jp?B?RGNwQ2dmZDlOTml4UjU4OFdzeTI4cjFNM2Z1SVN1bGV2cmw2bHR3NHM0?=
 =?iso-2022-jp?B?Wjg0Mk9pWkxMeVhvWkJFUnNxMlJiOE1waGp3MXpNem81THRTd2Z3c1Q0?=
 =?iso-2022-jp?B?THA0ZFd4V1lkMDRWUDVSdVY1eXhtejlnQ3R0WUl2bHkvZStlY0V4OGhY?=
 =?iso-2022-jp?B?WE5jemc3UEJHS01JVnBIL1dMd20rNzl2a0RodXRMRUxId3RSQW5TNWR0?=
 =?iso-2022-jp?B?NFlsN0dvZUpDTDhjNWFheXM2aUE4SlFGREo0a3ViSGYyaFd6d2dpeWtO?=
 =?iso-2022-jp?B?cWRJREczUDl3cTN0czlwcm5LOEFpeHh0c3E3ZDVBS0FYTVFSYmcrRVgy?=
 =?iso-2022-jp?B?WDJzL2VDcWhNajkySU1jSk1aL2RudGRlMTZXd1lPRTB6UENzWkdFMTF0?=
 =?iso-2022-jp?B?OGw5UEpYaVZ6bE41YWtCWFhXalVGeERwamtoRGlSbENyUWJXR0N1cHBZ?=
 =?iso-2022-jp?B?QWxaYk5uS0xJU1RMZW0rQXhnbkkxQXk3RXBrNkpnVnJWREdPbytoaEcy?=
 =?iso-2022-jp?B?bEhDcDFNeDNHVnNqY3Q2b1VtT2w2UHdBVzJWOXdIZ3Q0VHU5a292MTUv?=
 =?iso-2022-jp?B?ekVGMUdtYlRhaDV6bGZ6RlZHSllYMm45UllXTkFRNmdiTzYzelE5ZE1F?=
 =?iso-2022-jp?B?VUdOK0ZGWjhPeHZPdCttY0hPL1AvSCt6RldZd1Y1ZUIySmxiaFNQMDNa?=
 =?iso-2022-jp?B?bitCU0ZnREZtZFhuNjhWUnBEYm5rMHFaUStGMzJFZDBKMWRDdEMrbjZJ?=
 =?iso-2022-jp?B?SE1nVFpMWWZ5SzZVN1J4enBmU1puaFhCN2FOcElGUVhPZ2RFRWxKamNC?=
 =?iso-2022-jp?B?WVU5OHBQYlJUQXlnOHBFeU15WTgzajdGTnVlbWJZcE1QL3RQaHlYT3dV?=
 =?iso-2022-jp?B?VFRjaExvd3BQeUo5bzhHbmVYQ1d3S255bmI3TVFxaHlCV1F4UkJpL1Y0?=
 =?iso-2022-jp?B?VERJVStjWG1MeWNUU1EvZUVpTVNBZHZXYVdNYlMydE14VEU5S05TL2RN?=
 =?iso-2022-jp?B?T0FIQUNUciszNE43Z0hWWkovMHYrek5wY0EyNG00cUd3RXEremw5S3NF?=
 =?iso-2022-jp?B?UG8rVm1zeE10QjE5V3RwOGFLeWJqWDJqcmV5bkVycEI5M0NNSHNSZDZI?=
 =?iso-2022-jp?B?ZS9uUnJrVHZ6SC9nS3d2eXlXdjMwTHZDOUZYSzhwRzRqUVBGalk1dVhm?=
 =?iso-2022-jp?B?SjA4Y05wS3BJM0tLRkJwTFMvTTZCQTJHR1pBNGtzZ1ZKWnRWY1h6Tkpz?=
 =?iso-2022-jp?B?SlIxVkQyeHJXbnE5cG9Ma256dTdLSFpYalpNOFh2QXM5UUgwQmRleWxL?=
 =?iso-2022-jp?B?ZFByak1teDlodC83WU9XRktydWlLRTcwaXlObjNyN2liSk91NEpZRk1l?=
 =?iso-2022-jp?B?MjNZR1hwMmJmZ010dDhEb2w1R05CQzdidWhxOE9kamI5cTZEcm1Kanpx?=
 =?iso-2022-jp?B?VmZtUDRwSU8yN2hvY0tVcEd6ait1dlBTV09kc3k1WU5yS3U0U3JFQ3NW?=
 =?iso-2022-jp?B?Nkd4Q3NGcTZZdUZHNmFHV1Y4VWRNa3BjN2F2ZTVkMmxiOE92ZHRpUWFl?=
 =?iso-2022-jp?B?a1pISWpvTVNTanJyTWgwclhnWTJrbExYQkppVTJ5d0dkbUhLQkhyb3lF?=
 =?iso-2022-jp?B?SnZFbEZRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712b8a18-7621-4403-30d8-08d9c9ab7b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2021 02:40:59.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNFho8BBY8IT1eNWUKFp6Cqja5pdqFOP0cIpkUSK7Zuxl0oNdERWsbYk2DFebtxWKQUCx42IZOkHQc5d3Uy8guoR7tft1bmVLGOpFfYgAnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3912
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Sorry to resurrect this old thread, but I wonder how NFS clients should beh=
ave.

I'm seeing this behavior when I run a test program using Open MPI. In the t=
est program,=20
two clients acquire locks at each write location. Then they simultaneously =
write=20
data to the same file in NFS.=20

In other words, the program does just like Bruce explained previously:

> > > > >         client 0                        client 1
> > > > >         --------                        --------
> > > > >         take write lock on byte 0
> > > > >                                         take write lock on byte 1
> > > > >         write 1 to offset 0
> > > > >           change attribute now x+1
> > > > >                                         write 1 to offset 1
> > > > >                                           change attribute now x+=
2
> > > > >         getattr returns x+2
> > > > >                                         getattr returns x+2
> > > > >         unlock
> > > > >                                         unlock
> > > > >
> > > > >         take readlock on byte 1

In my test,=20
- The file data is zero-filled before the write.
- client 0 acquires a write lock at offset 0 and writes 1 to it.
- client 1 acquires a write lock at offset 4 and writes 2 to it.

After the test, sometimes I'm seeing the following result. A client doesn't=
 reflect the other's update.
-----
- client 0:
[user@client0 nfs]$ od -i data
0000000           1           2
0000010

- client 1:
[user@client1 nfs]# od -i data
0000000           0           2
0000010

- NFS server:
[user@server nfs]# od -i data
0000000           1           2
0000010
-----

This happens because client 1 receives GETATTR reply after both clients' wr=
ites completed.
Therefore, client 1 assumes the file data is unchanged since its last write=
.

For the detail, please see the following analysis of tcpdump collected from=
 NFS server:=20
-----
IP addresses are as follows:
- client 0: 192.168.122.158
- client 1: 192.168.122.244
- server: 192.168.122.12

1. client 0 and 1 called OPEN, LOCK and WRITE to write values on each offse=
t of the file simultaneously:=20

165587 2021-12-27 19:08:26.792438 192.168.122.244 =1B$B"*=1B(B 192.168.122.=
12 NFS 354 V4 Call OPEN DH: 0xc1b3a552/data
165589 2021-12-27 19:08:26.801025 192.168.122.12 =1B$B"*=1B(B 192.168.122.2=
44 NFS 430 V4 Reply (Call In 165587) OPEN StateID: 0x9357
165592 2021-12-27 19:08:26.802125 192.168.122.158 =1B$B"*=1B(B 192.168.122.=
12 NFS 322 V4 Call OPEN DH: 0xc1b3a552/data
165593 2021-12-27 19:08:26.802367 192.168.122.12 =1B$B"*=1B(B 192.168.122.1=
58 NFS 438 V4 Reply (Call In 165592) OPEN StateID: 0xde4c
165595 2021-12-27 19:08:26.807853 192.168.122.158 =1B$B"*=1B(B 192.168.122.=
12 NFS 326 V4 Call LOCK FH: 0x4cdb3daa Offset: 0 Length: 4
165596 2021-12-27 19:08:26.807879 192.168.122.244 =1B$B"*=1B(B 192.168.122.=
12 NFS 326 V4 Call LOCK FH: 0x4cdb3daa Offset: 4 Length: 4
165597 2021-12-27 19:08:26.807983 192.168.122.12 =1B$B"*=1B(B 192.168.122.1=
58 NFS 182 V4 Reply (Call In 165595) LOCK
165598 2021-12-27 19:08:26.808047 192.168.122.12 =1B$B"*=1B(B 192.168.122.2=
44 NFS 182 V4 Reply (Call In 165596) LOCK
165600 2021-12-27 19:08:26.808473 192.168.122.158 =1B$B"*=1B(B 192.168.122.=
12 NFS 294 V4 Call WRITE StateID: 0x8cc0 Offset: 0 Len: 4
165602 2021-12-27 19:08:26.809058 192.168.122.244 =1B$B"*=1B(B 192.168.122.=
12 NFS 294 V4 Call WRITE StateID: 0x8a41 Offset: 4 Len: 4

2. client 0 received WRITE reply earlier than client 1 so it called LOCKU a=
nd CLOSE.

165607 2021-12-27 19:08:26.843312 192.168.122.12 =1B$B"*=1B(B 192.168.122.1=
58 NFS 334 V4 Reply (Call In 165600) WRITE
165608 2021-12-27 19:08:26.844218 192.168.122.158 =1B$B"*=1B(B 192.168.122.=
12 NFS 282 V4 Call LOCKU FH: 0x4cdb3daa Offset: 0 Length: 4
165609 2021-12-27 19:08:26.844320 192.168.122.12 =1B$B"*=1B(B 192.168.122.1=
58 NFS 182 V4 Reply (Call In 165608) LOCKU
165611 2021-12-27 19:08:26.845007 192.168.122.158 =1B$B"*=1B(B 192.168.122.=
12 NFS 278 V4 Call CLOSE StateID: 0xde4c
165613 2021-12-27 19:08:26.845230 192.168.122.12 =1B$B"*=1B(B 192.168.122.1=
58 NFS 334 V4 Reply (Call In 165611) CLOSE

  At the frame 165607, the file's changeid was 1761580521582393257.

    # tshark -r repro.cap -V "frame.number=3D=3D165607" | grep -e "changeid=
:" -e Ops
    Network File System, Ops(4): SEQUENCE PUTFH WRITE GETATTR
                        changeid: 1761580521582393257

3. client 0 called OPEN again while client 1 was still waiting for WRITE re=
ply.

165615 2021-12-27 19:08:26.845652 192.168.122.158 =1B$B"*=1B(B 192.168.122.=
12 NFS 322 V4 Call OPEN DH: 0x4cdb3daa/
165616 2021-12-27 19:08:26.847702 192.168.122.12 =1B$B"*=1B(B 192.168.122.1=
58 NFS 386 V4 Reply (Call In 165615) OPEN StateID: 0x95d6

  At the frame 165616, the file's changeid was incremented to 1761580521582=
393258 by the server.

    # tshark -r repro.cap -V "frame.number=3D=3D165616" | grep -e "changeid=
:" -e Ops
    Network File System, Ops(5): SEQUENCE PUTFH OPEN ACCESS GETATTR
                        changeid: 1761580521582393258

  Therefore, client 0 called READ and reflected updates from other client.

165617 2021-12-27 19:08:26.848454 192.168.122.158 =1B$B"*=1B(B 192.168.122.=
12 NFS 270 V4 Call READ StateID: 0x907b Offset: 0 Len: 8
165618 2021-12-27 19:08:26.848572 192.168.122.12 =1B$B"*=1B(B 192.168.122.1=
58 NFS 182 V4 Reply (Call In 165617) READ
165619 2021-12-27 19:08:26.849096 192.168.122.158 =1B$B"*=1B(B 192.168.122.=
12 NFS 278 V4 Call CLOSE StateID: 0x95d6
165620 2021-12-27 19:08:26.849179 192.168.122.12 =1B$B"*=1B(B 192.168.122.1=
58 NFS 334 V4 Reply (Call In 165619) CLOSE

4. client 1 finally received WRITE reply and called LOCKU and CLOSE.

165622 2021-12-27 19:08:26.855130 192.168.122.12 =1B$B"*=1B(B 192.168.122.2=
44 NFS 334 V4 Reply (Call In 165602) WRITE
165623 2021-12-27 19:08:26.855965 192.168.122.244 =1B$B"*=1B(B 192.168.122.=
12 NFS 282 V4 Call LOCKU FH: 0x4cdb3daa Offset: 4 Length: 4
165625 2021-12-27 19:08:26.856094 192.168.122.12 =1B$B"*=1B(B 192.168.122.2=
44 NFS 182 V4 Reply (Call In 165623) LOCKU
165627 2021-12-27 19:08:26.856647 192.168.122.244 =1B$B"*=1B(B 192.168.122.=
12 NFS 278 V4 Call CLOSE StateID: 0x9357
165629 2021-12-27 19:08:26.856784 192.168.122.12 =1B$B"*=1B(B 192.168.122.2=
44 NFS 334 V4 Reply (Call In 165627) CLOSE

  At the frame 165622, changeid was _not_ incremented.

    # tshark -r repro.cap -V "frame.number=3D=3D165622" | grep -e "changeid=
:" -e Ops
    Network File System, Ops(4): SEQUENCE PUTFH WRITE GETATTR
                        changeid: 1761580521582393258

5. client 1 called OPEN again but ...

165635 2021-12-27 19:08:26.858006 192.168.122.244 =1B$B"*=1B(B 192.168.122.=
12 NFS 322 V4 Call OPEN DH: 0x4cdb3daa/
165636 2021-12-27 19:08:26.859538 192.168.122.12 =1B$B"*=1B(B 192.168.122.2=
44 NFS 386 V4 Reply (Call In 165635) OPEN StateID: 0x3d15

  ... since no further changes were made to the file, the changeid wasn't u=
pdated.=20

    # tshark -r repro.cap -V "frame.number=3D=3D165636" | grep -e "changeid=
:" -e Ops
    Network File System, Ops(5): SEQUENCE PUTFH OPEN ACCESS GETATTR
                        changeid: 1761580521582393258

6. client 1 assumed the file data was unchanged since its last write. It ca=
lled CLOSE without calling READ.

165637 2021-12-27 19:08:26.860201 192.168.122.244 =1B$B"*=1B(B 192.168.122.=
12 NFS 278 V4 Call CLOSE StateID: 0x3d15
165638 2021-12-27 19:08:26.860296 192.168.122.12 =1B$B"*=1B(B 192.168.122.2=
44 NFS 334 V4 Reply (Call In 165637) CLOSE
-----

So current implementation of NFS client doesn't assure reflecting other cli=
ents' update
when it is written simultaneously in non-overlapping ranges. Because it isn=
't assured=20
in RFC 7530 either, I think this is not a bug.

However, if it will be implemented, what approaches are affordable?

If a client can invalidate whole cache of the file on unlock, each client s=
ees other's update
written in non-overlapping ranges. I verified it with the following changes=
 in
fs/nfs/file.c:do_unlk().
----------
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -746,6 +746,14 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_=
iter *from)
                status =3D NFS_PROTO(inode)->lock(filp, cmd, fl);
        else
                status =3D locks_lock_file_wait(filp, fl);
+
+       nfs_sync_mapping(filp->f_mapping);
+       if (!NFS_PROTO(inode)->have_delegation(inode, FMODE_READ)) {
+               nfs_zap_caches(inode);
+               if (mapping_mapped(filp->f_mapping))
+                       nfs_revalidate_mapping(inode, filp->f_mapping);
+       }
+
        return status;
 }
----------
But I feel this approach is redundant since client invalidates its cache on=
 lock in fs/nfs/file.c:do_setlk().
Also, the above change may cause a performance degradation. Are there any o=
ther approach=20
we can take? Or, doesn't NFS have to implement it because it's not a bug ?

Yuki Inoguchi

> -----Original Message-----
> From: bfields@fieldses.org <bfields@fieldses.org>
> Sent: Wednesday, October 7, 2020 2:26 AM
> To: Matt Benjamin <mbenjami@redhat.com>
> Cc: Trond Myklebust <trondmy@hammerspace.com>; Inoguchi, Yuki/=1B$B0f%N8}=
=1B(B
> =1B$BM:@8=1B(B <inoguchi.yuki@fujitsu.com>; linux-nfs@vger.kernel.org
> Subject: Re: client caching and locks
>=20
> On Thu, Oct 01, 2020 at 06:26:25PM -0400, Matt Benjamin wrote:
> > I'm not sure.  My understanding has been that, NFSv4 does not mandate
> > a mechanism to update clients of changes outside of any locked range.
> > In AFS (and I think DCE DFS?) this role is played by DataVersion.  If
> > I recall correctly, David Noveck provided an errata that addresses
> > this, that servers could use in a similar manner to DV, but I don't
> > recall the details.
>=20
> Maybe you're thinking of the change_attr_type that's new to 4.2?  I
> think that was Trond's proposal originally.  In the
> CHANGE_TYPE_IS_VERSION_COUNTER case it would in theory allow you to
> tell
> whether a file that you'd written to was also written to by someone else
> by counting WRITE operations.
>=20
> But we still have to ensure consistency whether the server implements
> that.  (I doubt any server currently does.)
>=20
> --b.
>=20
> >
> > Matt
> >
> > On Thu, Oct 1, 2020 at 5:48 PM bfields@fieldses.org
> > <bfields@fieldses.org> wrote:
> > >
> > > On Mon, Jun 22, 2020 at 09:52:22AM -0400, bfields@fieldses.org wrote:
> > > > On Thu, Jun 18, 2020 at 04:09:05PM -0400, bfields@fieldses.org wrot=
e:
> > > > > I probably don't understand the algorithm (in particular, how it
> > > > > revalidates caches after a write).
> > > > >
> > > > > How does it avoid a race like this?:
> > > > >
> > > > > Start with a file whose data is all 0's and change attribute x:
> > > > >
> > > > >         client 0                        client 1
> > > > >         --------                        --------
> > > > >         take write lock on byte 0
> > > > >                                         take write lock on byte 1
> > > > >         write 1 to offset 0
> > > > >           change attribute now x+1
> > > > >                                         write 1 to offset 1
> > > > >                                           change attribute now
> x+2
> > > > >         getattr returns x+2
> > > > >                                         getattr returns x+2
> > > > >         unlock
> > > > >                                         unlock
> > > > >
> > > > >         take readlock on byte 1
> > > > >
> > > > > At this point a getattr will return change attribute x+2, the sam=
e as
> > > > > was returned after client 0's write.  Does that mean client 0 ass=
umes
> > > > > the file data is unchanged since its last write?
> > > >
> > > > Basically: write-locking less than the whole range doesn't prevent
> > > > concurrent writes outside that range.  And the change attribute giv=
es us
> > > > no way to identify whether concurrent writes have happened.  (At le=
ast,
> > > > not without NFS4_CHANGE_TYPE_IS_VERSION_COUNTER.)
> > > >
> > > > So as far as I can tell, a client implementation has no reliable wa=
y to
> > > > revalidate its cache outside the write-locked area--instead it need=
s to
> > > > just throw out that part of the cache.
> > >
> > > Does my description of that race make sense?
> > >
> > > --b.
> > >
> >
> >
> > --
> >
> > Matt Benjamin
> > Red Hat, Inc.
> > 315 West Huron Street, Suite 140A
> > Ann Arbor, Michigan 48103
> >
> > http://www.redhat.com/en/technologies/storage
> >
> > tel.  734-821-5101
> > fax.  734-769-8938
> > cel.  734-216-5309
