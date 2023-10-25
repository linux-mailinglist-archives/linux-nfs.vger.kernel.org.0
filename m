Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5D7D65DB
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjJYIyK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjJYIyJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 04:54:09 -0400
Received: from mx1.km.kongsberg.com (mx1.km.kongsberg.com [157.237.3.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBCBB9
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=kd.kongsberg.com; s=s1;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ToeKELHV4egulPiISGH+T7zhG9klAn6TvEM+ccsj3ko=;
  b=JKUMRyVSxquR6KRVLouaiI/STPw8UWbmYPTQzHvbtwZdFyBHL0Z6vukw
   yDY17CoTnWx4lcgOjKok9ujtwaGqXxNJM3oJlL0kBifBpJu1hg20f2G67
   Zco7fKdqC02mDgB309xKiS5D+ZEQ4tyGW52tKU8s3pHOFVicW8hCDV6Qw
   Q=;
X-CSE-ConnectionGUID: b3NtQdMpS8axJK7IjXRwRA==
X-CSE-MsgGUID: 3S96tgs8SUWqZgm9w2VwHg==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:KAZGVKIiZGC0Jct0FE+RuJQlxSXFcZb7ZxGr2PjKsXjdYENSg2QBm
 GAWWGmBbvnYNmemKYx3bYq390NQuJDXzNY1TQporCE8RH908seUXt7xwmUcns+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTHhScijfngqp3UUbaUZXsZqTdMEXpn0VQ73bdh3uaEuPDhayuVo
 9T+vsbDD1Gs3j9wIwo85rmKwP9VlK2aVAgw4BpmPpingHeEzyNOVcpFePnoR5fFatI88tCSF
 r+rII6RrjuxEycFUruNjrv9e0sWdb/eVSDmZq1+AvXKbrBq/0Te445jXBYuQR4/Zwahxrid/
 O5wWamYEm/FCIWRwrhHA0kAe81JFfYuFLfveRBTuCEIpqHMWyOEL/5GVCnaMWCEkwre7K4nG
 fEwcVgwgh6/a+2eyumdVtBgo9wYfMD7HqBAm3NQ9y7jJKNzKXzDa/2iCd5w2T4xgoZNGLDdY
 MwWcjBidhuGaBpKUrsVIMtm2rn0wCCuNWQFwL6WjfNfD2z7wQhw2aOrNtPOfsGMSe1WkgCbo
 WTJ5G70GB5cP9uaodaA2ivy3reSwn2kBur+EpXjza80nFKIllcuNwQkWl7qvqOHlW6xDoc3x
 0s8v3BGQbIJ3EagSdXxXhu3iGSJsh4VR5xbFOhSwAWMzLfEpgCXHUAaQTNbLt8rrsk7QXotz
 FDhoj/yLWU39uPJDyvMsO7Jxd+vBRUowaY5TXdsZWM4DxPL+unfUjqnog5fLZOI
IronPort-HdrOrdr: A9a23:QMdZxKvLbh/N+w+794Q6d1Tv7skDpNV00zEX/kB9WHVpm62j5r
 iTdZEgviMc5wxhPk3I9erwX5VoIkmskaKdg7N/AV7KZmCP1FdAR7sSlLcKrQeQZxEX6INmtJ
 uJYsVFZuEZ7jJB/LzHCHXTKadc/DHOmJrDuQ+Vp00Bcen6AJsB0+/5YTzrcXGfLWN9dPgE/H
 r13Lsjm9KkFE5nFfiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AxpvuimlFcFD8bgOTX4OKuQ63SCbXOXeG6mvpL2q?=
 =?us-ascii?q?gMjZgWJ+2Fn6SyJl7qeM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AyHXO3Q/OcDlnz+pxtEprP1mQf5xTsvqyB1tdqqg?=
 =?us-ascii?q?5ovuLMH1vYQmCrDviFw=3D=3D?=
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="160057676"
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="160057676"
Received: from unknown (HELO mail.km.kongsberg.com) ([10.64.19.15])
  by mx1.kdmz.ext with ESMTP; 25 Oct 2023 10:54:04 +0200
Received: from exchmbnodat16.kongsberg.master.int (157.237.134.225) by
 exchcanodat05.kongsberg.master.int (10.64.19.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 10:54:03 +0200
Received: from exchcanodat06.kongsberg.master.int (10.64.19.16) by
 exchmbnodat16.kongsberg.master.int (157.237.134.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 10:54:03 +0200
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (157.237.3.11) by
 exchcanodat06.kongsberg.master.int (10.64.19.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 10:54:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbZ1dZVmbm6yKb0sFmColn4U1FqeA52p6qpNLka8E81i64OY/fo1YZ9A+mhpMlvMbF83H74ZHSLPstTD1dwGd17Y50wBHhq+YOiBMiBR5O08tUz7oFtwzYopXyr02dK4WVmahLvASeRAYNrGKrVV5aKT8ewWJQc/VUwBoT63zcVLlNw+96ewTtdL29xsxCEjALbIkQk7aB+flKnbq36vt7DalTmb4/F6TuOJ6Tl5B7k5NLMf+y2TYvXfj6JWx+Azvn4zZeHhqVtsFpvf//Y7PyiKYH2Soitfl6x1GzAjdKrmV2SluRIgSlGbwQ8EwjCG3OIJhBAjTzgDrWpSbVpOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToeKELHV4egulPiISGH+T7zhG9klAn6TvEM+ccsj3ko=;
 b=K0AHD/BWaX0RwUr/KKxsSCSUCfem7+X7wvTPsWwW7TQ3JzEWXeZQS53pfKtO/kb8Obubm3kBvEnY3/Hv7DW1DOcw8/eyry+TztLgEWL/ez9JOkcbC1IzR5TCTPSoERkQZ/brYRfWdAz8fXpmHbfVd6nVItQJet48d89WAfs2l2M7qFl08ePPIp+DFxy0rBlP0n6igY972CoHdr6LhJ/99RF+wVANxzxcYk6d9HyLfBsnxzO6f1FJIEeEBKuJC6Rv/8aNibPvndn8EJlmm243ElPcEEubahvRScE2JzlLMhL3LVmAHFDWORoWt9neilKm5MCoRaK7QueRhdSiFdLm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kd.kongsberg.com; dmarc=pass action=none
 header.from=kd.kongsberg.com; dkim=pass header.d=kd.kongsberg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=masterx.onmicrosoft.com; s=selector2-masterx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToeKELHV4egulPiISGH+T7zhG9klAn6TvEM+ccsj3ko=;
 b=zxOS1AFGdZ4El8zoELU7xAeU1aVJR7J0H4QVR9xhyLH/bsvJ1M6tpF7A80Q8IBpbhnHBiQaBRqtpuo91DJNvDvsFwvvaX5/eDMCHyWLRhGkjICPY35+eSTG9V0f7BVtg1GYAGVMSWZhw85SiX7CHoY/YzyWs+YUopiazvc2ldfQ=
Received: from PRAP190MB1833.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:293::19)
 by DB9P190MB1196.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 08:54:01 +0000
Received: from PRAP190MB1833.EURP190.PROD.OUTLOOK.COM
 ([fe80::24dc:b461:8ae0:8bbb]) by PRAP190MB1833.EURP190.PROD.OUTLOOK.COM
 ([fe80::24dc:b461:8ae0:8bbb%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 08:54:01 +0000
From:   =?utf-8?B?RWxpYXMgTsOkc2x1bmQ=?= <elias.naslund@kd.kongsberg.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Writing to NFS interfere with other threads in the same process
Thread-Topic: Writing to NFS interfere with other threads in the same process
Thread-Index: AdoGOVCgubSGcAxgQwCohyJMt2ZIUAAMveoAAABeOJA=
Date:   Wed, 25 Oct 2023 08:54:01 +0000
Message-ID: <PRAP190MB1833223081A5EA000CE30B91CBDEA@PRAP190MB1833.EURP190.PROD.OUTLOOK.COM>
References: <PRAP190MB1833A3FAB75002DD5467B8ABCBDFA@PRAP190MB1833.EURP190.PROD.OUTLOOK.COM>
 <FCF5E1D2-5DFD-4AA6-9BCF-7C902FFCCC80@redhat.com>
In-Reply-To: <FCF5E1D2-5DFD-4AA6-9BCF-7C902FFCCC80@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kd.kongsberg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP190MB1833:EE_|DB9P190MB1196:EE_
x-ms-office365-filtering-correlation-id: 917dab7c-5531-4887-b351-08dbd537ef2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VFnZj3EU1Idv1ZFYOE9SZy6FH2la4Xpcs+qGgWpGFuUe3Ql/RKPgQBy/7irTM+RvcRX7y3+YnJ1QqaCt/UkgT0FbOjcgx/ehAMbvRCSkERXejMJczu2zLRERJgXJ+doqSn47Ztv0euZ/hKmnbMAYjllYElDum8SMmtusbil2pxTV43KhoX+oxkOZgpKV1I4r7h3SEnVF2MH7IdN9vq10mZYM6/4Q1DobDoIIrvZ+9Tfw5G3hI8Ql5t5M8LF/cbPRe1VxKYLXlARlPDu589v1jBfBaA1QXHR+GrEYnIjJhImwLEShtcY/19KgqG0L0JPbKWARC901tUylvbQl8xPt+V2Q3m48ihib8JTGqg9CmotSziyYkjln30RXNs1UL5+rg8AY5by0+sGZ2e4Qf12pqK4JYy20DcMKef/bTySASimQJFRXqU4gQHffuZ2nLPvEI+NmQumsaqS8izKT4NZVAP2tctYSMn5GovOb1s+3AizTTNXij03Z5W0g3bSKTauxzFcDLend7KCvAXV+GtBCJmCy816wQk5HqbDoK0ZwEoO6rGXxTirE4piczkDDX8xrb5s/p8CMnM64p7DjBVQqqazS4dMF6qR9DYtWO9+gLRHn/CTxu5El5iGOZKVCfn2I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP190MB1833.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(7696005)(5660300002)(52536014)(71200400001)(55016003)(41300700001)(26005)(83380400001)(85202003)(85182001)(4744005)(33656002)(38100700002)(86362001)(122000001)(2906002)(9686003)(478600001)(316002)(6916009)(76116006)(66946007)(66556008)(64756008)(66476007)(66446008)(38070700009)(8936002)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um81cFdVOXl0Zzh2dWttTmp6bjlzSFE0dWY0QmZ1WVEydXV2TjkxNUhlaFhE?=
 =?utf-8?B?Zzd3bWdNeFduSW5lcUJiNjZJOHBkckVwRFN0bjdLUVdNOXYyVHJpd1VuakVP?=
 =?utf-8?B?UHhjZE9sQks1b0cxSnJVUmV3bVN3TXk0UEhtOHlHOXFXN1hqOGt0cHlZNzVa?=
 =?utf-8?B?b3FabHhqS0hFMmlQTnYxRHI4YW5zeE44aTB4NVJEbWg5K1VkQi9KejE1VWlY?=
 =?utf-8?B?U3VrZ3JKemRDRzFqRE9PQm12YWZwSzViSlBmUWhsRUpBNit5WVdZTURVUUlj?=
 =?utf-8?B?YXBrcW5nUU85R21yZjdYaE14emUrYmoyNmRuUVozRFQxbUN0aEgxS2pJUlNB?=
 =?utf-8?B?S3dpMnR2dDVCTWI3ZmdBMDU5ejU4bWFRRnp2YWlHNjVQUGFLaVMweS9oak51?=
 =?utf-8?B?enFFazVyaDFCbmxyekVPSWlJZjVCcVE3dnNpZVhkbkNiVFZub0hTWWhTeGNn?=
 =?utf-8?B?UFp4cXc1a2FiUnlLbDVlSEk4dXUrZm9lQ3E3MnNGb3JlQUdtLzk3eUczUmFw?=
 =?utf-8?B?SXdySUdmVHpIN0JSSFBsb1dJcXdOaURmMUxsRWNtWERvYzdhcXlXTFhoM2VS?=
 =?utf-8?B?dXRHNXp4c1R1dk1adDREVVdlcm1XbnR1TExheDFEVlR2WTRUbkFEb1FuaHVE?=
 =?utf-8?B?WjVPTGtzSE1yanZ2QzlXS05qNVpoYldsUU9nZlNEVnZQUEJGVzcvZWU0NnYv?=
 =?utf-8?B?UmQ3aUoxaG5seFBNbWhzakx4VW1taU8rZUx2L2dQd1FENDdqMFJpcU1ET1k3?=
 =?utf-8?B?YmxnNk91TU55VnpNK0IwbDV4T0VFMnZZcU5lMVdzazdUbWVLODNiWG44QnhV?=
 =?utf-8?B?bzNsTTBWbmxXTHBnN3BaZ1RyR2lCTm9vT2Y3dDEwd3N0ZEFXT3J0aVcwTmpa?=
 =?utf-8?B?SlplWENTTS9HcHRQUjhiL1NOVlYweW1ZcDhnU3NoNXRmQUpYWUg1bVU4TTBL?=
 =?utf-8?B?N1pNTjdoRTBWZVM4K05TSzN1U212a3kwdi9TL0ozQkh5N2NSTWI4bFZPMG5N?=
 =?utf-8?B?dHdrRWFQZHMyUFpuRmE2aSt6UEc3MkNYVXhKWWN1N0NMYUtTYkdTK3cwVy93?=
 =?utf-8?B?eUtlUC9tNXhRNi84ams5WjRPQnhSRjBoc0tZMEFSOEUrS3RxRjMrSXJnZm85?=
 =?utf-8?B?V2sxL2tDWTlsd3g4Mmoxd3BTeTlnOW5sMlR3TW93TlZET1hBanVMcjZyTTVL?=
 =?utf-8?B?dXgzTG1UUUVLZVVEaWFlV1ZvRVZ6b08wSEZyUzR3SkJwWElPZGgxYkFlM1pr?=
 =?utf-8?B?cWZRbXdkZFM5Rk9LcE1kdGNicURyWWlpQmZqV1BGWVE4c2JhU1J5Y3QyMHFi?=
 =?utf-8?B?d2FmSnZGSTJQd1VZNmtXMCs1Q1B3R0V4RXNaMG9nOTFDc25pMUYvT3c5WXJ2?=
 =?utf-8?B?NzdZZCtHaWk0cWVMVzhPcTVRUC9rVHhiSHp1T3BZQk01QnFZRWR3aTA4NitE?=
 =?utf-8?B?QmZwUWlJQ01hRFJrejcvWkNZOGJBMlQ1T0tVamNmQThjNENPc0l6UUFaeGk4?=
 =?utf-8?B?ZTFSN21YeUhNUmsyWVJVcU15VlA3WUo4Q2ZlUDRIRmNkdFlvb1AyU054cEVt?=
 =?utf-8?B?ZnQxR2N3M2N0ZWRsY1pwUER3QnVVNWxYQklBb2RmcWVobnRHUEFVczd1L0ll?=
 =?utf-8?B?b0ZyRDd2NGdEV0Z1NjBHR2RrK05FSzcwT0k5RWtoMXlKL2p4VGZDc3pyb3Vm?=
 =?utf-8?B?VGxBZVNrbDlwWmlnUlkzdktQU2hnVGJydjhkVlI2TGRzaXhOVTlnQXZSa3Av?=
 =?utf-8?B?K25jKzJUb01EdDBVSHl2L1BrVG5HVFlJM3g0QzRBU3ZhRmxvUjdqT3pudEZm?=
 =?utf-8?B?aUhKelRldnEwNGZTMklqWUtRSzJEajlJa0ptYTZ2RFBUZ1hNVGRqcUlSTUEv?=
 =?utf-8?B?dGsyZFU3TVlPaG9MUlZJTE1NL1NrZXJiYzdKcjJEQUwzUjlxbWZMeUM0Y21B?=
 =?utf-8?B?ZW03eElqeTIxWFNiMVo0VHBNai9HcFpOeVZLZkZ3djMyYi96SUJISTZBaGJT?=
 =?utf-8?B?Y0JvNGJGQjVSZnkzQkRWb2NTeThGdGRUWXZWZ2srRzRxbktva2tjbGVDbTNw?=
 =?utf-8?B?UFIyS3VLc1FZTHNMdHB5OGVmd0Evdy9DY2VxbEFmSkVWSmV6TFFwQnFGMmtm?=
 =?utf-8?B?OXkxMXAvM0FaOFBmTStOcy85WnRkL2dzSkhhN2k2UzBjLzRrekxNVVdwQm1L?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAP190MB1833.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 917dab7c-5531-4887-b351-08dbd537ef2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 08:54:01.5519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a113bc9e-1024-489c-902e-5ac8b5fd41ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2alv7vyrOxZiJWGPzl/bgUw0CzaBFr5llr2GlXVXIDDakljJEACzOLIUwwVrgm8eX5LGpah8RT3zOAPVAfVmD+cfJKf9zCm+Mmu+a6q5sMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1196
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBUaGUgd3JpdGVfZmlsZSgpIHRocmVhZCBpcyBxdWV1aW5nIHVwIGEgbG90IG9mIGFzeW5jIElP
IHRoYXQgaXMgdGhlbiBmbHVzaGVkIGJ5IGNocm9ueWMncyBkb19leGl0IC0+IHB1dF9maWxlc19z
dHJ1Y3QgLT4gZmlscF9jbG9zZSwgd2hpY2ggd2lsbCBiZSBhIHN5bmNocm9ub3VzIHdhaXQgZm9y
IGFsbCB0aGF0IElPLg0KPg0KPiBJZiB0aGF0J3Mgbm90IHdoYXQgeW91IHdhbnQgSSB0aGluayB5
b3UnbGwgd2FudCB0byBmaWd1cmUgb3V0IGhvdyB0byBkcm9wIENMT05FX0ZJTEVTIGZyb20gc3Rk
Ojp0aHJlYWQncyBjbG9uZSgyKSBzeXNjYWxsLg0KDQpUaGFua3MgZm9yIHRoZSBpbnB1dC4gSW4g
cmVhbGl0eSB0aGUgdGhyZWFkIHRoYXQgd3JpdGVzIHRvIHRoZSBORlMgZG9lc24ndCB3cml0ZSB0
aGF0IG11Y2ggZGF0YSBidXQgZW5vdWdoIGRhdGEgdG8gaW50ZXJmZXJlIHdpdGggY2hyb255YyB0
cmFja2luZy4gSSBjYW4gc2VlIGluIHdpcmVzaGFyayB0aGF0IGl0IHRha2VzIG92ZXIgMTAwbXMg
dG8gc2VuZCBhbGwgZGF0YSBhbmQgYnkgYSBjb2luY2lkZW50IHRoZSB3cml0aW5nIGhhcHBlbnMg
YXQgdGhlIHNhbWUgdGltZSBhcyBjaHJvbnljIHRyYWNraW5nLiBUaGVyZSBhcmUgYWxzbyBzZXZl
cmFsIG90aGVyIHRocmVhZHMgaW4gdGhpcyBhcHBsaWNhdGlvbiB0aGF0IHdlIGZlYXIgbWlnaHQg
YmUgaW5mbHVlbmNlZCBhcyB3ZWxsLg0KDQpJIGFtIGEgYml0IHN1cnByaXNlZCB0aGF0IGV4aXRp
bmcgb2YgYSB0aHJlYWQgd2lsbCBmbHVzaCB0aGUgTkZTIHdyaXRlcyBmb3IgYW5vdGhlciB0aHJl
YWQuIFdpbGwgaGF2ZSB0byB1c2Ugc3NoZnMgaW5zdGVhZCBmb3Igbm93Lg0K
