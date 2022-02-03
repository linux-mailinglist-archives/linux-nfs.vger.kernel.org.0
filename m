Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E5D4A7FDD
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Feb 2022 08:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiBCHck (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Feb 2022 02:32:40 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:44385 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230473AbiBCHch (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Feb 2022 02:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643873557; x=1675409557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RBK71dTb5PTl3JgvdFWB/oeL6cIWeCOSPNrO/5IfQ78=;
  b=aNG/YOFaZGH9jNE+muMY1AyIYFZTis0f410OrfddalSra5upSJUpvdtE
   tFua6d44IFFeH+XwZVuQhzOLcMRf8mfeYjnRm2wJ0ZxUWiCFz8OO3fejo
   k6nJc7koc45lx8OLkA9ZETiYNZ3Yv9/GyfFN7PgLKRp8bJys7HhHD0GfY
   z+Y8LWp4bUfTCHECRtIVBxyaHjY4rQ6ce5MTtN7gs7gyO/Wi54ZLm5Pft
   UNGQDbvz/qNt3vCywHhdylX+RlbmTjHS7fhzJ7u/3YKw4Pc3qC660M72l
   cxb+URntZ/LLxDZ+QE8oGb/QHV+4ojOAVVoY6Kjsml2KTBT8p+2eQhkGp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="49988185"
X-IronPort-AV: E=Sophos;i="5.88,339,1635174000"; 
   d="scan'208";a="49988185"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 16:32:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2cFD9gFvyOT3I1uv0Warynumu6KvEhktZfrl11VlDLIGbZU/e2oOooajXopT6KgBsHO2qbJdGXSE/xapvYWNgqE2GCggtnlX6fb+iGDRhz4iQjGWLXzRRmZ+TXoNxxWEBqsl4Y/9Qk9pRHhcGBj0JzyKwd2dSymaTjPwtTVP91RV5WPhGmmBVZO4cCwZ4Ngi0IlOjQAm9cZCy3IC5i9HalCg8riO0yU3bpXvcCud5J1Q/L6zm3y5aCq+rbn6fLH/Ai51arvezAWmEQy8Bj6+wtbvYrvyrY+lnI4rIFPtB8nPwIfdrFIJrl36gCG9OMhOoLpMdvFSNDiA6Q1RIqsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBK71dTb5PTl3JgvdFWB/oeL6cIWeCOSPNrO/5IfQ78=;
 b=eYutlEDbGUy57ElMhupev0jZ6Yt+I0Y0VcUlxQgsWqrDaClagCecJ+8Ze1tbqfS49TGqwKFdFRy2bQJOohcRy2RJwqk5pFSL6OfZbGZUTteZ4AhKdtYfTmYSHrscgKSEQc/pYZOKIVJAfhIBxAwRLferB0k/QwAxI2AI8xvArLIPLapQg11XGTIzbVebrfI4KoXRLck15PS7niV/Nc/gai8dk2NiCLqD9vvnuzskgNE8agOYRakB/6CIflP9KjP59uZW8ug8V156l3ru6XfNKF+N254OqUF+i2w2DG7xeTr1m0ImcU06S2M5bet6QYAe05hFUaOOjajC5vnSrVeiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBK71dTb5PTl3JgvdFWB/oeL6cIWeCOSPNrO/5IfQ78=;
 b=e/xo0sbhmnU7G1xtPlop0/AF76TX6aykqwTrKugwoK9gNNvQa3xYZfEQbPfQ/F6iRNzk4Woi4n1icEHGVRbMU1JBkeOS848uDyQGmZZvk0DkmGSMB7681hlE4F2ir1K4Viy/wuK7mvHeg8rEsYkjNxP+HNzgSlyp5pqtwMPzYpg=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by TYAPR01MB4125.jpnprd01.prod.outlook.com (2603:1096:404:c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 07:32:30 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::cda5:a5e8:8877:9b4a]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::cda5:a5e8:8877:9b4a%5]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 07:32:30 +0000
From:   "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
To:     'NeilBrown' <neilb@suse.de>,
        'Trond Myklebust' <trondmy@hammerspace.com>
CC:     "'bfields@fieldses.org'" <bfields@fieldses.org>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: RE: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqMcAycEC0/pke1JkGmPD8pPKjeL0EwgABO2QCAAF7SgIAF4BMAgJ9AToCAAArJgIAHh8GAgr9HWraACijNgIABG0CggAA4XwCAADEigIAABkSAgAEmVACAANM0gIAGR/CAgAyajO6AF/xnooABvuiA
Date:   Thu, 3 Feb 2022 07:31:06 +0000
Deferred-Delivery: Thu, 3 Feb 2022 07:30:36 +0000
Message-ID: <OSZPR01MB7050AD4E6F85ABE698EC4CA3EF289@OSZPR01MB7050.jpnprd01.prod.outlook.com>
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
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <164245842205.24166.5326728089527364990@noble.neil.brown.name>, =?utf-8?q??=
 =?utf-8?q?=3COSZPR01MB7050DF6073AB2EC4F82A589AEF279=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E?=
 <164377705404.1660.1273338182990772730@noble.neil.brown.name>
In-Reply-To: <164377705404.1660.1273338182990772730@noble.neil.brown.name>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: 0255cf41e2ea4e80abfb4113d84c3a94
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9OWQ1ZDI5MzQtNmRmYS00MWI4LWJlMzItZmRlNGI4NzA4?=
 =?utf-8?B?NjYzO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wMi0wM1QwNzoyNDowNFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be144c0e-9f21-4fdd-2a5b-08d9e6e75620
x-ms-traffictypediagnostic: TYAPR01MB4125:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4125A4AEFE8E021D57BADDC6EF289@TYAPR01MB4125.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LnRaQusWVNthxEd9XPEnwOih/g7CnjpZ0YVhGRa+W+Z0iCfPe3zo0u/LAmk1/vnr2dDFTwymPcHDBQ/84tXtvc+C+r1gBklUPA80fP99dR9nIJQHv69HwZ8rSTDaksTYZnshti9IE2vNE2/21muR4Gp4WUvRj+Ia0dfhauJVKq3NkGn6JMeRy6hhCc0RyYb3ptXS9qDZ/S+Bv5obVpueyoQZncBgxKlbNDz7cCaMIksr++gamoDOsPtiugInBIOIueoC1QXBUxcgWHJwdBJmJZyyne6GTqERJkNti1DLNk9tzNVKN7EtcL1twBfMOEba+aX5MwG4VaWvZ6kUNtVMKdZVwsWqzQB0n5E16Vh+bokTflKGiAAEfn31eEJxOA2U2FFd442l+BFhSVrcAF/6tObR6hiH9Aa/rD9t827J4au996jr5CXKpfx7fanCbeY+h3/TNaYmU7aVVilxck0+v/p5Yv8RX6Bo1zv6gfq0GPgf+0uig/izA3/yX89O7s6GdeFkSaqFFPXcRQnfDGHEKuSoo12FarCB8KJIDhzOG4uhJqOnISbpjQAo7/Fhnei15F129bTi3PSp45ZNDDugluuT0sBa0u+ZLoWcAC2B1R16DP++x1RRzNdvIFyHqq9na5VpBlcSkEOEHWdKlp25NlcIM422raIAEUxoDPOuZ7Rzg+uKCm3eSOh/qjK98IAoq1csln61dfTlC081G1JrtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(71200400001)(6666004)(8936002)(8676002)(4326008)(52536014)(26005)(64756008)(66476007)(9686003)(2906002)(7696005)(76116006)(5660300002)(66556008)(186003)(33656002)(66946007)(38070700005)(66446008)(38100700002)(3480700007)(316002)(85182001)(110136005)(83380400001)(86362001)(508600001)(82960400001)(122000001)(55016003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVVabnVPb1l4SndmQkVhN0dQZU5WQlpldXdQWkxFcnM1bytaeHdkdmwvWWxk?=
 =?utf-8?B?ZStOR3I2TmxMT2R0Tk1LVXJwNlBBR3JzRnJKRjJWTWtVRWxpQTlZaU1HNTJo?=
 =?utf-8?B?U3FwbTNzK3JlL2pMQk5xbk1IQTJnS3dYSDZjaHNlQ0JWZmV6b3lGODhNOVM3?=
 =?utf-8?B?N3Y4em9wNDZtMkI2dWFtYTFta29wQkNtZ0hobXJnMlpSSUZXZDdCa3g1SVph?=
 =?utf-8?B?TEMxaExaL3VwSzRlcEpIcGZsWDVza09OOFJqUFl2cUwrSE9kamdkZDhhckxQ?=
 =?utf-8?B?L25RNlE0KzN6QjZmT2xmTmxLQ011aVdtc2tvZzh5TE1kbkpvd2ltSlNVS3ov?=
 =?utf-8?B?Y3F4UmpzRkpST3RLNEJET2dBUWVxbEtIY00xSVpPU1lmUlR4UWRFQnUzS2Zi?=
 =?utf-8?B?YWgzQWNDcHFIUUtGS0xlRTdabUlMa2xEdk5PMjJlWDUwYTF6cVFwQTgrVFhy?=
 =?utf-8?B?cVczN1hQdXlyNGFScSs0VDdtSXcyK0FEWkpmUHJQTnhJaU1ob3l3WUdjOHFW?=
 =?utf-8?B?WFg4VS84ZEx5OUhrMGlSZlc1QjJkWXNtODgrZGhpa2daNmFCbHp5Vit2S1px?=
 =?utf-8?B?dWFpMmtzK09sWGE5ZzVxdUZ2SFBMVDRsY1ZaQjdSZGlTVjFkd0s4M3l5Mmxi?=
 =?utf-8?B?RTNNYlpMSUdVeDNRZHB4WlRNMElvTmU3b1IrNHRoczhYSndERGtIbzdlSGk0?=
 =?utf-8?B?KzR0QlBsZFM4SjhSRHhGZjQ2bFNKbW5OTk9YQTFXbkc1bDZvN0xycnlCVGN5?=
 =?utf-8?B?eEVXdzdoSnVHRkZ4V2s5V0JQZzlicVpyL0pHM3BRd3BHWkQvaUp0NTJMTU9h?=
 =?utf-8?B?OE5iRE9adktBODZydWFyeEJnM2VaMlZsN1lJak5jdTJ2bmhkMng2TTk4OC8y?=
 =?utf-8?B?dTd2b0xBZWlTaXdZbklUcUJZRWdYWUduUFFialgzc0JzczBvZnVCWitUbW9w?=
 =?utf-8?B?VUEwUkdyYUN5Ly93TE5QNlpCVDI5d1E0cG45MnhYNW1xU0gxME9TL09tSFlN?=
 =?utf-8?B?ZENuRWJzVm1nVWlPdVMybWlHZGVnRkZEQmplY05wV2hONzV2TGlwMm5iMjdF?=
 =?utf-8?B?MGwwaVhaTjFmMWlua0xmbldTNk9KVUdobmY2c2lnY0Z2aXBkdVo0RW9mYjht?=
 =?utf-8?B?cmY3Q0tUaU9iTnlmMXRoTXo0YjV6TWkrNTlnd1dmYU1tOUZLMmo4bDZUbjAx?=
 =?utf-8?B?MGZMVzlEMU54d3h0ZlVNMEx1OGdjWTJPTXB2bFAydGgvazhrT3FWRUhDQnBa?=
 =?utf-8?B?bjloYURwdVp0eUF2eVRaMzhEZmpUR0lqNWd5Nnh2a3JhM0h6Rlhla1BiS1RS?=
 =?utf-8?B?aUUxa040K1NvbU15WkpoQXRiazJ6Ly9EMllVeGUyNk1zdjhJcG16eEhSLzRa?=
 =?utf-8?B?ejQ2bWZ4Rll0cjBsMzdleSsyWGVZc2c4Mm0rNDVGMFZMVURrMzRaWUpDNkpm?=
 =?utf-8?B?UUFUWWZncGNzRlBkZFZERGNpSitXalNYa0YrRGNwUnhKUldSeGw5dExxc256?=
 =?utf-8?B?WE9kbmtaaEdOdUlLdlpodk0yVWVwc245ZmV2aGdHMGVGYmgva09UVE5SQndr?=
 =?utf-8?B?N096dlFuZEU0WlNJVm9ZOUkvd3lENHI5SGdqbWRHNUVWajRPTlk5Wm1QL0xx?=
 =?utf-8?B?dXNyQ0h6eHFsN1c3Uzg0Y3JZTTdTbUsrcC9ZeUNsMnJFQnpVbUtqcEpUT2hJ?=
 =?utf-8?B?ejlWSTJTOXc1ZVBXWThTbXh6aXl6ZmxZcktnOFhHUldnSENEOUxNajRBYjk4?=
 =?utf-8?B?c3NmY0F1OFhTSFhUTnRLZDI5aG1RYkROZzRPU1VEcVBOa3BDV0lidUhVNFZz?=
 =?utf-8?B?a0wvVXFuTVVpaThzRmN0dnBmYVZtemVYemx6OVVrOHVEZS96bFpRdmRWUUw0?=
 =?utf-8?B?KzJXbkVwSDVQOVZHU3JJWWMzOERCQTJNeTU2cGZTVXQ2cnRmTndQZExRMENl?=
 =?utf-8?B?cnpXM2tpZzZva1hoU1ZRd284c1RtMzM3dEdncVh1V1ovYWxieXpxcTZjVHdN?=
 =?utf-8?B?YVpRVXZ0MjJmUm13d0pCOUlIdnV2bGNkRmZwaVZlSnozT21QeUsxaDZ6RkdH?=
 =?utf-8?B?bkFuWXV2TzdkREM2VFlCQW5ydGVSVGFkOFhkSjM2dk1pazY0T044NXpyUnFJ?=
 =?utf-8?B?TkpRMzZBTWlvQ0hldTJhVDNyM0k2M01SN0NaV1BXUGI4eHFDcU5PcDVVNjNG?=
 =?utf-8?B?L0FlOUljWnhDZk1xdjJTYlMvUyt1QnVUT3RUWEErWEhSL2t1VzFTREpPVnVK?=
 =?utf-8?B?SzZZR2FJK0tvbjNjOFhNd2NUbWVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be144c0e-9f21-4fdd-2a5b-08d9e6e75620
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 07:32:30.5949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9pZ68d8FdNv/j+J1fhn1Mwe/YY7wf5ZqWq8uSidRHXLatXeAJHxtMLKZb1eWuPsR06Cdo6BG7Q2kuV/Oub9kGDWgrEkZ0OHD2ORPWG29O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4125
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQo+IEkgd291bGQgbWFrZSAyIGNoYW5nZXMuDQo+
ICAxLyBpbnZhbGlkYXRlIHdoZW4gb3BlbmluZyBhIGZpbGUsIHJhdGhlciB0aGFuIHdoZW4gY2xv
c2luZy4NCj4gICAgVGhpcyBmaXRzIGJldHRlciB3aXRoIHRoZSB1bmRlcnN0YW5kaW5nIG9mIGNs
b3NlLXRvLW9wZW4gY29uc2lzdGVuY3kNCj4gICAgdGhhdCB3ZSBmbHVzaCB3cml0ZXMgd2hlbiBj
bG9zaW5nIGFuZCB2ZXJpZnkgdGhlIGNhY2hlIHdoZW4gb3BlbmluZw0KPiAgMi8gSSB3b3VsZCBi
ZSBtb3JlIGNhcmVmdWwgYWJvdXQgZGV0ZXJtaW5pbmcgZXhhY3RseSB3aGVuIHRoZQ0KPiAgICBp
bnZhbGlkYXRpb24gbWlnaHQgYmUgbmVlZGVkLg0KDQpZZXMsIEknbSB3aWxsaW5nIHRvIG1ha2Ug
dGhlc2UgY2hhbmdlcy4NCg0KPiBJbiBuZnNfcG9zdF9vcF91cGRhdEVfaW5vZGUoKSB0aGVyZSBp
cyB0aGUgY29kZToNCj4gDQo+ICAgICBpZiAoKGZhdHRyLT52YWxpZCAmIE5GU19BVFRSX0ZBVFRS
X0NIQU5HRSkgIT0gMCAmJg0KPiAgICAgICAgICAgICAoZmF0dHItPnZhbGlkICYgTkZTX0FUVFJf
RkFUVFJfUFJFQ0hBTkdFKSA9PSAwKSB7DQo+ICAgICAgICAgZmF0dHItPnByZV9jaGFuZ2VfYXR0
ciA9IGlub2RlX3BlZWtfaXZlcnNpb25fcmF3KGlub2RlKTsNCj4gICAgICAgICBmYXR0ci0+dmFs
aWQgfD0gTkZTX0FUVFJfRkFUVFJfUFJFQ0hBTkdFOw0KPiAgICAgfQ0KDQpZb3UgbWVhbiBuZnNf
cG9zdF9vcF91cGRhdGVfaW5vZGVfZm9yY2Vfd2NjX2xvY2tlZCgpLCBub3QgbmZzX3Bvc3Rfb3Bf
dXBkYXRlX2lub2RlKCksIHJpZ2h0Pw0KVGhpcyBpcyBqdXN0IG1ha2Ugc3VyZSAtLS0gc28gSSBj
YW4gc2V0IHRoZSBuZXcgZmxhZyBpbiBhcHByb3ByaWF0ZSBwbGFjZSA6KQ0KDQo+IEkgYXNzdW1l
IHRoYXQgY29kZSBkb2Vzbid0IGVuZCB1cCBydW5uaW5nIHdoZW4geW91IHdyaXRlIHRvIGEgZmls
ZSBmb3INCj4gd2hpY2ggeW91IGhhdmUgYSBkZWxlZ2F0aW9uLCBidXQgSSdtIG5vdCBhdCBhbGwg
Y2VydGFpbiAtIHdlIHdvdWxkIGhhdmUNCj4gdG8gY2hlY2suDQoNCk1heWJlIGl0IGlzIG5mc19j
aGVja19pbm9kZV9hdHRyaWJ1dGVzKCk/IA0KSXQgcmV0dXJucyB3aXRob3V0IGRvaW5nIGFueXRo
aW5nIGlmIHlvdSBoYXZlIGEgZGVsZWdhdGlvbi4gDQpJdCBpcyBjYWxsZWQgZnJvbTogDQogbmZz
X3Bvc3Rfb3BfdXBkYXRlX2lub2RlX2ZvcmNlX3djY19sb2NrZWQoKQ0KIC0+IG5mc19wb3N0X29w
X3VwZGF0ZV9pbm9kZV9sb2NrZWQoKQ0KICAgIC0+IG5mc19yZWZyZXNoX2lub2RlX2xvY2tlZCgp
DQogICAgICAgLT4gbmZzX2NoZWNrX2lub2RlX2F0dHJpYnV0ZXMoKQ0KDQoxNDc2IHN0YXRpYyBp
bnQgbmZzX2NoZWNrX2lub2RlX2F0dHJpYnV0ZXMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
IG5mc19mYXR0ciAqZmF0dHIpDQoxNDc3IHsNCjE0NzggICAgICAgICBzdHJ1Y3QgbmZzX2lub2Rl
ICpuZnNpID0gTkZTX0koaW5vZGUpOw0KMTQ3OSAgICAgICAgIGxvZmZfdCBjdXJfc2l6ZSwgbmV3
X2lzaXplOw0KMTQ4MCAgICAgICAgIHVuc2lnbmVkIGxvbmcgaW52YWxpZCA9IDA7DQoxNDgxICAg
ICAgICAgc3RydWN0IHRpbWVzcGVjNjQgdHM7DQoxNDgyIA0KMTQ4MyAgICAgICAgIGlmIChORlNf
UFJPVE8oaW5vZGUpLT5oYXZlX2RlbGVnYXRpb24oaW5vZGUsIEZNT0RFX1JFQUQpKQ0KMTQ4NCAg
ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQoNCll1a2kgSW5vZ3VjaGkNCg==
