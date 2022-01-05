Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC65B485011
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 10:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiAEJdO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 04:33:14 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:34082 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232161AbiAEJdN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jan 2022 04:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641375193; x=1672911193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uWKT1Oamfz4gqwqg3lVSPO4grJeAwdrOms/swlfesDw=;
  b=uehcMxXH5Ah2R/I8Nuw95ta7h9EPImvIKjojQyrZ6oDODOmDMMc009Pm
   Fw8vYAA8/26Xv0LsP6EL0xdCBOe/zIjiaetxxGsfmVkr24/YEmQfDyOfX
   7so0lQrEYrLROxQSgi2ySKvSj2VtLrwq5IiAyQStqulCtZUxwMTJ32VBM
   nVLSLZc33k/m2mDrU/1NzeN1XWxl+L5d7iwE6FTCX6vSWCS91S7O1i9SG
   vkdEIHCFLHnmwAEzgYxgFDuIon4w4FZuzm6Gni8RwJtssKr4FgdUFRQ7p
   E8vwQzB2c8xD4CzyVgpfCefbpAjvfkWjN0m9hiE38nghaP/KWfaWVcTfx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="46867713"
X-IronPort-AV: E=Sophos;i="5.88,263,1635174000"; 
   d="scan'208";a="46867713"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 18:33:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRWtfNznQZBlh1u4BC5hB7UL1qVeKtdkKGVe4SnRbyfShHQ39IFuRR+ok8APlE3+PL5aPgVJn44jl1GkOEWCueFVNJKSKQan+QWt0GL6QQE+wjvrEODHXWQ74h927gJRQL0olLkckxLEP7iYZsRFKpwjFOB9qvwnEsFMCrswqxiQ4D3TGpYXafhfORugf4Jzva8DLt9hf2SPe0bQ/ki3NlEgcOzOmlZc34o0SOAG65O7iCVJBuwbRnOUgL1A3i1FS3yPiiPcYrif5ynV8dTBj5SB7W7b8Ox0gymTWV6f7jA3SiIN0WyyO1BI2InILKt5azMuwgH6j2jJjLc7gdKI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWKT1Oamfz4gqwqg3lVSPO4grJeAwdrOms/swlfesDw=;
 b=DJvt9Rk5mmtE9eGv0dhlB1NjoCZTpZE8Ezu4EiIYoqXZI5SV89E09SZ3RFO7aQM9wHXCwfxcMkMgqeuDwnSadIluD+7qNskIVYZi5g3ei3fgUt8UdYlvTLhRrMpE102dN+y3rQ1XXrU/B9F/NTaQpYeI/Pa5q0rRZ0Eu59kSlPdmRum7Kz24Jmv53mSfBzz/i9eQoR0JrshkTnF/2GE9P7wDkPUfFG1po80oR9s3reaIJUyz/KD1BZoqZP+YAsv4IKKFYMWSyhfSCeaVEq5hb7hmxaTjShPV4Brz7UO2QWnUm9+EucvkVWLUpSSwqmW5GC/90c7KYmgnDnj/ofCThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWKT1Oamfz4gqwqg3lVSPO4grJeAwdrOms/swlfesDw=;
 b=ej0eBFULS4hWBsVAUWC0wgU+f6OHh9Z2QYSAx7p1IbmQX/gUDlQpqyKeCZoxArt4zOnNZqZcb/+oOXUKbaK6jTMRUrsrVi5xTM6sCEIpVN9X41i6MlgOFdRPmZqT2oqE5hT35GGBj69gwp3MGH93z7LRuxMvssJCPY+n55GS2/U=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by OS3PR01MB5749.jpnprd01.prod.outlook.com (2603:1096:604:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 09:33:06 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::7d7d:1bbf:1f8b:6667]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::7d7d:1bbf:1f8b:6667%4]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 09:33:06 +0000
From:   "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
To:     'Trond Myklebust' <trondmy@hammerspace.com>,
        "'bfields@fieldses.org'" <bfields@fieldses.org>
CC:     "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'neilb@suse.de'" <neilb@suse.de>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: RE: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqMcAycEC0/pke1JkGmPD8pPKjeL0EwgABO2QCAAF7SgIAF4BMAgJ9AToCAAArJgIAHh8GAgr9HWraACijNgIABG0CggAA4XwCAADEigIAABkSAgAEmVAA=
Date:   Wed, 5 Jan 2022 09:31:59 +0000
Deferred-Delivery: Wed, 5 Jan 2022 09:30:34 +0000
Message-ID: <OSZPR01MB7050C5098D47514FFEC2DA82EF4B9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
         <20200618200905.GA10313@fieldses.org> <20200622135222.GA6075@fieldses.org>
         <20201001214749.GK1496@fieldses.org>
         <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
         <20201006172607.GA32640@fieldses.org>
         <164066831190.25899.16641224253864656420@noble.neil.brown.name>
         <20220103162041.GC21514@fieldses.org>
         <OSZPR01MB7050F9737016E8E3F0FD5255EF4A9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
         <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
         <20220104153205.GA7815@fieldses.org>
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>
In-Reply-To: <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: 26fe0474842c4764a2bdf910947735bf
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NTczZjc0MjUtOTZkMi00MzM3LWFmZTAtOWI2M2M2Y2Q4?=
 =?utf-8?B?OWZlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wMS0wNVQwOToyNzo1N1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6388952d-3e64-461d-5a45-08d9d02e6145
x-ms-traffictypediagnostic: OS3PR01MB5749:EE_
x-microsoft-antispam-prvs: <OS3PR01MB5749F7B54410E0DC3B24F1D2EF4B9@OS3PR01MB5749.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rdAZArgRKAiIooZ0SED8n+Bc4H+XEndPutGppOu2gTqBIqmg4I/4f3CewrWdMZQAYwR7OJRHPR4xtBKPuMSlaGLE0AiXjoUmXRYWpLYjNIM3yPb7e7ixMbt2hA3s/K8L7XX+h/P21iz3zW+kxCs6OpoUSy5ILAAQsaR18uJGEaDK2HSE12iENqDOiPzXV9bOolaHyS7FWCObVWeRHgZqn0pZUrjNFdRHRSVjR4dTYdjUjh6g58Wk2CTx/tlANCR5S77tQUwYHiFvvRtKoqFWXqFKpxRIAhePPEvAIa4l+vGuS1k0O7H3iCmA7k/RBDK6YGAptgriM9MdjqMjfd02vkQacgQXzSoiSkKE5EhyBh0HfEjkfO7q3ejzZ+OB/+uTpgohxV8WpBtmbIyPd/Aka21Gtp1F1CtpgY2KvEO9RCbEdU9/Tcc6BojKbGL51DHqDzKiG1DrVT0JPMPqeysWNQulyF5VC3Z51Qd5egB6cEVc5CMC64nDkpM/xf9qDeFP0vSLwi/0IVtUBazWIrFka5ai4/v0qhu6tixMtZJsO8B/JqUwOPAge/GJYo54oUZT6T6NIef+RiwhR4bOGrZGlBp6VaZujYVSMP5qWmBL8t4dROdz+TE2oZ2WlS6AuBqgaP4c90p42NGkySQn1ETUNMHkJMA3T0lBkod/ssEmINwJtbOB9xrWu3T5ZXjtt8SQBtV0fkVRnUN7cAzNJTeB/2+VmgyG9naiVe+aoMw5zZMNj0el0jj8ScwG8qbzbZgiSiQ9dXahBvCpVVlaAZDV/iYFb/sh8RqMjgWAp5NZ6x0Jrjv/BVmuDto9aDSC2oNZTap+F/q/IcLas736BGTYx7Zz+XMkAzSViH61xY1NMHQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(122000001)(38100700002)(66476007)(38070700005)(5660300002)(66556008)(64756008)(66446008)(55016003)(82960400001)(66946007)(508600001)(85182001)(83380400001)(966005)(2906002)(4326008)(6666004)(33656002)(71200400001)(3480700007)(8676002)(8936002)(76116006)(26005)(186003)(316002)(53546011)(9686003)(6506007)(54906003)(110136005)(86362001)(7696005)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clB1bDE0OENDMjhTRTZnN0JvYXVuOE84eUI1MzFCRlA4cjdxSXQ2Sm5obGVx?=
 =?utf-8?B?VnNWUlZUNlcvZDAxL05QdG1Mcm5wUEtvbzVuTHBtbmJNdlZGUG5kNDViOGI2?=
 =?utf-8?B?U0RCdUxMVm42dk1kSkpJZE41em1ZbE1WU1BXcTFIeWlRaEc5OVJNdGlUMEg0?=
 =?utf-8?B?Wi9pYVpIUFEyLzl0WC9WZkRCQUdwRTE3cVlRSEJrWmhibExhL0l2alFFanJ6?=
 =?utf-8?B?ZDVZZnd3VzIzQmFpKzB2bGtramNkVWFVTnBFcU9xYXo1V3VyMUdYS2kwRDVp?=
 =?utf-8?B?SUF1NTZjNkFCYU81QkJRNHUyRUlkTER6dXM0Qm5XY2lOVTJQRWlpTk55UGNn?=
 =?utf-8?B?NmxZT1dkd2lkV0NwL25ib0w5WlJTZm5FWUU0QmxsRi9RWWZORWtLSURXWXMw?=
 =?utf-8?B?QVRuSThVL1dUS3A5MksrY25tQXcxc0dNWDMzZXVSdEVsTS96Qng5Si9XbVBx?=
 =?utf-8?B?OUMzVi9kaUpMZEZLdCtVc0pNNythaXVoMlRqRlc0ZnVRRUNxMXQyQWxGNUwr?=
 =?utf-8?B?MjB0b2syNFVsK3pjMmNVaWZUYUwzaGVvYjhQb2JKam0yNWFUTkdPTERxWlRq?=
 =?utf-8?B?SVpoOTE3K09mSzBpTVpRdlhZTCsvWWtIRlh3VGlXQzE3UWo0UUk0VWZKN3dv?=
 =?utf-8?B?RWo5aEZHcWVhRmg5OGJzWFAvNFNoeS9OVEN1WHhKYlRscyt2TS8welNnMDdm?=
 =?utf-8?B?NEEyVW0zWjY3MlYxOFRCOG10YmtDZVl2UXhGem4weDRxenp1dE9yZ2wweEtD?=
 =?utf-8?B?ZFUrcFhNbGNJdVpiVFcyZTd3VzBRTHhIWHZYYkh1V1JYcDBRaVZxZzJEa3Rx?=
 =?utf-8?B?aUNpdUhneXdmZUpSUGFkOU1rZEc0VDRVaDk4QUxyb1BWekJuNUlBVS9sY3Q4?=
 =?utf-8?B?Tml5aEZFQ29tSlBIRUVDbVhLL1pzaEpaU2VTTzQrZ2VId2dXQ3VNZzVEMjZh?=
 =?utf-8?B?NkNQNEF3bFJYa29sS0MxcStveWZjSXh5L0E2YklmRkNZQ3FFOHpUQkJXaUl1?=
 =?utf-8?B?OFVFVjQvL1ZqWmNXc3RyMUNlc3JWWklIS3g5ZjA2T1QrR1J0MzNyeDBua2RK?=
 =?utf-8?B?Q0srVktsNzVYM1lYYUNpU2IrZm42MlpXVFo1dWJXUWFFdFFBZkhKQm45cXg2?=
 =?utf-8?B?RWhoUEk2UEFPTzljSDgzSUhaVHZ0NlZpNU0vSnRQcThDVXJFazZCSGFzMlBt?=
 =?utf-8?B?TU9oT2xqNGpzYnMrdUlLb0wwS2RiYldUZWZuQnN0a3B1RWJqOG8rSnorUHlN?=
 =?utf-8?B?SUtCYXE0Q2twZXYrNTFaVkFzVHdBbFJZeEFzejlhcDIwZVdLS1ZKVkFHL2Jz?=
 =?utf-8?B?ZXJoUlYzZVlLazV4Q3lqN0dWbkNoam1DQWxIWHBsanIyN3VKVTE3TmVXbEFx?=
 =?utf-8?B?SXo0dk1Gclc1a1RLYVd6c2Nzd0FZUmt3bDhkVTNSMWtNbTYyWFB2Tm8yK3Fu?=
 =?utf-8?B?M25hTnRLczhqWERRQTRhSHZMSnB1VFVDM3llNjFpWUIrRis5QUNFbStXOHpE?=
 =?utf-8?B?cnVWV0tmZ2VTWEZlYzBJelR3dUlTOVVudG9XNjRWemZ6YWR5d3I4aFBpYjg3?=
 =?utf-8?B?NWp4dU50SWZPbzRlSHhQaDVBeDcwUk41NHhqTzNQREI0ZzNMUi9YUEExWkdK?=
 =?utf-8?B?ME1EUlhFZjhNTDFVVjZDajNYQ3BhaFZCVkJDa2QyUmQ4MlRpVldzS0dFYWVz?=
 =?utf-8?B?MUpIYm9PYnNHYVc2bkJYcVpJbTBhTVJ5M1ZIRlQvU0xhVGRkbW01cWl5bUtV?=
 =?utf-8?B?VTRITWhlcFI4OFhOSkxmMXlHZUV4UitsWWhLV1cySko3ZThIU2RrTUZ0ZUc4?=
 =?utf-8?B?SWs2S3JnbThYcmZRQThtYVVrMUJLOGhJNC9ydjhtVHlxYk9BVUpvQmVpU084?=
 =?utf-8?B?RWZZR3Iya0ZlSCtnMWx6cTdteXRvcmZ2ZTJhMSt3MjdJb043ZEhJcFcrQW9W?=
 =?utf-8?B?YmFiR2F3bzdGWENuOUJZY0NaUE5yVFRpZjdET3ZnS2Z2bnRwUkw2WGhJS1pr?=
 =?utf-8?B?V1I2T1FReklGL1RwMlJoNDlMNjIxS1lUU3VDVWFFT29FZVM5WHFWVWdlRW43?=
 =?utf-8?B?M1ViN05EQ0NWZlVtbHl1N1JDeHczSGpjVVNwVFI0eEVoRktTb0RUY0lpd2hH?=
 =?utf-8?B?L3BCVXFzL0EzblFYWTdIc2VqcCtVcUt1NVBKQTlJanRPRm5WaDdVSzNnZlZn?=
 =?utf-8?B?d3A1OWtIOFhYQnIrMmJycWdUWHgrS2pMNElIT1Byd3dtckRRNmtGSWJvQmN1?=
 =?utf-8?B?TjJKWDQzVlQ5L1cyOHFxNEM3cDhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6388952d-3e64-461d-5a45-08d9d02e6145
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 09:33:06.8046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izq/oZz+3t+TyVk1HQQFq3m4AAadb/6Qn4z4BpJ2aWt1mB691yLH0MD81+EvgA8oIRuF9AYKg8leeCfi73oDwlrY7H/8Ovmdvd6vljGwvnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5749
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBJdCBkb2VzIGlmIHlvdSBhcmUgZG9pbmcgZnVsbCBmaWxlIGxvY2tpbmcuIEkgYWdyZWUgaXQg
d2lsbCBub3QsIGlmIHlvdQ0KPiBhcmUgZG9pbmcgcGFydGlhbCBmaWxlIGxvY2tpbmcuDQo+IA0K
PiBJT1c6IElmIHR3byBjbGllbnRzIGNhbiBwb3RlbnRpYWxseSBib3RoIHdyaXRlIHRvIGRpZmZl
cmVudCBwYXJ0cyBvZg0KPiB0aGUgc2FtZSBmaWxlIGF0IHRoZSBzYW1lIHRpbWUsIHRoZW4gdGhh
dCB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBpcw0KPiBpbnN1ZmZpY2llbnQgdG8gZGV0ZXJtaW5lIHdo
ZXRoZXIgb3Igbm90IHRoYXQgd2FzIGluZGVlZCB3aGF0IGhhcHBlbmVkLg0KDQpJIGhhdmUgdW5k
ZXJzdG9vZC4gU28gZm9yIGNhY2hlIGNvbnNpc3RlbmN5LCBmdWxsIGZpbGUgbG9ja2luZyBpcyBu
ZWVkZWQgaWYgDQptdWx0aXBsZSBjbGllbnRzIGNhbiB3cml0ZSB0aGUgZGlmZmVyZW50IHBhcnRz
IG9mIHRoZSBzYW1lIGZpbGUgY29uY3VycmVudGx5LiANCg0KSSB0aGluayB0aGlzIGtpbmQgb2Yg
aW5mb3JtYXRpb24gc2hvdWxkIGJlIGRvY3VtZW50ZWQgaW4gc29tZXdoZXJlLiANCklmIGl0IGlz
IGVub3VnaCB0byBmb2N1cyBvbiB0aGUgZmlsZSBsb2NraW5nLCBJJ20gYXNzdW1pbmcgaXQgdG8g
YmUgdW5kZXIgIkRBVEEgQU5EIE1FVEFEQVRBIENPSEVSRU5DRSIgDQpzZWN0aW9uIGluIHRoZSBu
ZnMgbWFuIHBhZ2UuDQoNCk9yLCBtYXliZSBpdCBpcyBiZXR0ZXIgdG8gdXBkYXRlIHNlY3Rpb24g
MTAuMy4yIGluIFJGQzc1MzAgd2l0aCBtb3JlIGluZm9ybWF0aW9uIHN1Y2ggYXMgY2FzZXMgDQpp
biB3aGljaCBjaGFuZ2UgYXR0cmlidXRlcyBjYW4gYW5kIGNhbm5vdCBndWFyYW50ZWUgY2FjaGUg
Y29uc2lzdGVuY3kuDQoNCkNvdWxkIHlvdSBwbGVhc2UgdGVsbCBtZSB5b3VyIG9waW5pb24/DQoN
Cll1a2kgSW5vZ3VjaGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBU
cm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEphbnVhcnkgNSwgMjAyMiAxMjo1NSBBTQ0KPiBUbzogYmZpZWxkc0BmaWVsZHNlcy5vcmcN
Cj4gQ2M6IElub2d1Y2hpLCBZdWtpL+S6leODjuWPoyDpm4TnlJ8gPGlub2d1Y2hpLnl1a2lAZnVq
aXRzdS5jb20+Ow0KPiBsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnOyBuZWlsYkBzdXNlLmRlOyBt
YmVuamFtaUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBjbGllbnQgY2FjaGluZyBhbmQgbG9j
a3MNCj4gDQo+IE9uIFR1ZSwgMjAyMi0wMS0wNCBhdCAxMDozMiAtMDUwMCwgYmZpZWxkc0BmaWVs
ZHNlcy5vcmcgd3JvdGU6DQo+ID4gT24gVHVlLCBKYW4gMDQsIDIwMjIgYXQgMTI6MzY6MTRQTSAr
MDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gT24gVHVlLCAyMDIyLTAxLTA0IGF0
IDA5OjI0ICswMDAwLCBpbm9ndWNoaS55dWtpQGZ1aml0c3UuY29twqB3cm90ZToNCj4gPiA+ID4g
SGkgTmVpbCBhbmQgQnJ1Y2UsDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBj
b21tZW50cy4NCj4gPiA+ID4gTm93IEkgaGF2ZSB1bmRlcnN0b29kIHRoYXQgdGhpcyBiZWhhdmlv
ciBpcyBieSBkZXNpZ24uDQo+ID4gPiA+DQo+ID4gPiA+ID4gPiBXaXRoIE5GU3Y0IHRoZXJlIGlz
IG5vIGF0b21pY2l0eSBndWFyYW50ZWVzIHJlbGF0aW5nIHRvDQo+ID4gPiA+ID4gPiB3cml0ZXMN
Cj4gPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+ID4gY2hhbmdlaWQuDQo+ID4gPiA+ID4gPiBUaGVy
ZSBpcyBwcm92aXNpb24gZm9yIGF0b21pY2l0eSBhcm91bmQgZGlyZWN0b3J5IG9wZXJhdGlvbnMs
DQo+ID4gPiA+ID4gPiBidXQNCj4gPiA+ID4gPiA+IG5vdA0KPiA+ID4gPiA+ID4gYXJvdW5kIGRh
dGEgb3BlcmF0aW9ucy4NCj4gPiA+ID4NCj4gPiA+ID4gU28gSSBmZWVsIGxpa2UgY2xpZW50cyBj
YW5ub3QgYWx3YXlzIHRydXN0IGNoYW5nZWlkIGluIE5GU3Y0Lg0KPiA+ID4gPiBTaG91bGQgaXQg
YmUgZGVzY3JpYmVkIGluIHRoZSBzcGVjPw0KPiA+ID4gPg0KPiA+ID4gPiBGb3IgZXhhbXBsZSwg
dGhlIGZvbGxvd2luZyBzZWN0aW9uIHJlZmVycyBhYm91dCB0aGUgdXNhZ2Ugb2YNCj4gPiA+ID4g
Y2hhbmdlaWQ6DQo+ID4gPiA+DQo+IGh0dHBzOi8vZGF0YXRyYWNrZXIuaWV0Zi5vcmcvZG9jL2h0
bWwvZHJhZnQtZG5vdmVjay1uZnN2NC1yZmM1NjYxYmlzI3NlY3Rpb24NCj4gLTE0LjMuMQ0KPiA+
ID4gPg0KPiA+ID4gPiBJdCBzYXlzIGNsaWVudHMgdXNlIGNoYW5nZSBhdHRyaWJ1dGUgIiB0byBl
bnN1cmUgdGhhdCB0aGUgZGF0YQ0KPiA+ID4gPiBmb3INCj4gPiA+ID4gdGhlIE9QRU5lZCBmaWxl
IGlzIHN0aWxsDQo+ID4gPiA+IGNvcnJlY3RseSByZWZsZWN0ZWQgaW4gdGhlIGNsaWVudCdzIGNh
Y2hlLiIgQnV0IGluIGZhY3QsIGl0IGNvdWxkDQo+ID4gPiA+IGJlDQo+ID4gPiA+IHdyb25nLg0K
PiA+ID4NCj4gPiA+IFRoZSBleGlzdGVuY2Ugb2YgYnVnZ3kgc2VydmVycyBpcyBub3QgYSBwcm9i
bGVtIGZvciB0aGUgY2xpZW50IHRvDQo+ID4gPiBkZWFsDQo+ID4gPiB3aXRoLiBJdCdzIGEgcHJv
YmxlbSBmb3IgdGhlIHNlcnZlciB2ZW5kb3JzIHRvIGZpeC4NCj4gPg0KPiA+IEkgYWdyZWUgdGhh
dCwgaW4gdGhlIGFic2VuY2Ugb2YgYnVncywgdGhlcmUncyBubyBwcm9ibGVtIHdpdGggdXNpbmcN
Cj4gPiB0aGUNCj4gPiBjaGFuZ2UgYXR0cmlidXRlIHRvIHByb3ZpZGUgY2xvc2UtdG8tb3BlbiBj
YWNoZSBjb25zaXN0ZW5jeS4NCj4gPg0KPiA+IFRoZSBpbnRlcmVzdGluZyBxdWVzdGlvbiB0byBt
ZSBpcyBob3cgeW91IHVzZSBsb2NrcyB0byBwcm92aWRlIGNhY2hlDQo+ID4gY29uc2lzdGVuY3ku
DQo+ID4NCj4gPiBMYW5ndWFnZSBsaWtlIHRoYXQgaW4NCj4gPiBodHRwczovL2RhdGF0cmFja2Vy
LmlldGYub3JnL2RvYy9odG1sL3JmYzc1MzAjc2VjdGlvbi0xMC4zLjLCoGltcGxpZXMNCj4gPiB0
aGF0IHlvdSBjYW4gZ2V0IHNvbWV0aGluZyBsaWtlIGxvY2FsIGNhY2hlIGNvbnNpc3RlbmN5IGJ5
IHdyaXRlLQ0KPiA+IGxvY2tpbmcNCj4gPiB0aGUgcmFuZ2VzIHlvdSB3cml0ZSwgcmVhZC1sb2Nr
aW5nIHRoZSByYW5nZXMgeW91IHJlYWQsIGZsdXNoaW5nDQo+ID4gYmVmb3JlDQo+ID4gd3JpdGUg
dW5sb2NrcywgYW5kIGNoZWNraW5nIGNoYW5nZSBhdHRyaWJ1dGVzIGJlZm9yZSByZWFkIGxvY2tz
Lg0KPiA+DQo+ID4gSW4gZmFjdCwgdGhhdCBkb2Vzbid0IGd1YXJhbnRlZSB0aGF0IHJlYWRlcnMg
c2VlIHByZXZpb3VzIHdyaXRlcy4NCj4gPg0KPiANCj4gSXQgZG9lcyBpZiB5b3UgYXJlIGRvaW5n
IGZ1bGwgZmlsZSBsb2NraW5nLiBJIGFncmVlIGl0IHdpbGwgbm90LCBpZiB5b3UNCj4gYXJlIGRv
aW5nIHBhcnRpYWwgZmlsZSBsb2NraW5nLg0KPiANCj4gSU9XOiBJZiB0d28gY2xpZW50cyBjYW4g
cG90ZW50aWFsbHkgYm90aCB3cml0ZSB0byBkaWZmZXJlbnQgcGFydHMgb2YNCj4gdGhlIHNhbWUg
ZmlsZSBhdCB0aGUgc2FtZSB0aW1lLCB0aGVuIHRoYXQgdGhlIGNoYW5nZSBhdHRyaWJ1dGUgaXMN
Cj4gaW5zdWZmaWNpZW50IHRvIGRldGVybWluZSB3aGV0aGVyIG9yIG5vdCB0aGF0IHdhcyBpbmRl
ZWQgd2hhdCBoYXBwZW5lZC4NCj4gDQo+IEhvd2V2ZXIgaWYgb25seSBvbmUgY2xpZW50IGNhbiB3
cml0ZSB0byB0aGUgZmlsZSBhdCBhbnkgdGltZSwgdGhlbiB0aGUNCj4gY2hhbmdlIGF0dHJpYnV0
ZSBjaGVjayBzaG91bGQgYmUgc3VmZmljaWVudCwgZ2l2ZW4gYSBORlN2NCBzcGVjDQo+IGNvbXBs
aWFudCBzZXJ2ZXIuDQo+IA0KPiAtLQ0KPiBUcm9uZCBNeWtsZWJ1c3QNCj4gTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KPiB0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQo+IA0K
