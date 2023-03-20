Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202DD6C08C6
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 03:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCTCA3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Mar 2023 22:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCTCA2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Mar 2023 22:00:28 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01376974D
        for <linux-nfs@vger.kernel.org>; Sun, 19 Mar 2023 19:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1679277628; x=1710813628;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=HZYkKc7cH3jzL2ZU2MZ1jtB35Xp/um7a/HfV9HPptAo=;
  b=pxErA24NI/zayLZcoQNrbrkM8gDiS3Qy0urk6gNRGnPBkEA0TeTydQJt
   Pg++on50ec5yiH8uunKP3V1Q5N/LmzjzYky7tPw2vII5TsUJXivkaiNo5
   dQnyC/VFXQ9w3LNgZUP8exVPE+92lYFm9gvnZe8goQ0mDGDWIeovD6iMI
   GBFgmo1ahDGYo9GTnprxhU3MUnkAFKeavTYCr8MEYTuTr/xkTbKMaIfOM
   wBlzqt/uLK8dxtOZfJ0klqN+0MWD6bpmaHtyHPOkT7z/uhLU7H8jbIKn+
   oThF9ZhKSfe4ipYXUoqfzKt+61gSePDTZoiq1C9VOUpYw7Ev0m8LWfFh5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="79392671"
X-IronPort-AV: E=Sophos;i="5.98,274,1673881200"; 
   d="scan'208";a="79392671"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:00:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g60exr6utvsISmPHBDtAuMtWH91cbXlktOulpiwpW+dsO2HIV/zvsF0JR45a1Bu0JQic5C5TN0lbVtravIcjtDmSOxLG1Fw2c87ElEVebAZ+IAggkLgjIqcgHbq0vV7I2aRLEg/plTNe9vV01UefuPX4xqfiJrYhyb3Lzjv9y55ukPUmxx+JRU5tX2GFkK1l69JCHZe9JJGURMFl7pRI2nhm6XTqdu2A9r4mpK/z9ncn6YHKGBLu+KHjoAB7KpjWzlJQPJZyGTXD/IUc7HXpp3rhRc0WdpEPal/2eMrZhhA5b4hJF4tphKFuTpdn9Gahq0y+xCJne7ZbLAPnh3TOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZYkKc7cH3jzL2ZU2MZ1jtB35Xp/um7a/HfV9HPptAo=;
 b=VlE9CAlK8hw3GITV52pCBNyxHhnnMEjgkLWumusX2zXglKR8iSnAV34Bcm2BX7QlOcOY8usX7QZmvIwwEFWIgCLgrWA3Zc1ViiEXBgERWqqlT+rYeiRUS4o1TzqzmFu5M1+ROV29KR3ZECd7wa0mzSZh1JU9mMg4n2wigZgH+Fl4+gBV4/GjjrRl5s4rYcKihr73rm0XH3Q6lZ8feIiKE5Ec9r8MudZA5kfETH4OzC8mKm18+Z9/ye2/nSlQKFKJwAhOy8qHS/TIvP3M3eVFSg2061SfmUUc04jFS6jBkK8ZrLKNxiJz90OakLhDqNQhyMF1LBoeAi/uqdClYOFL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7183.jpnprd01.prod.outlook.com (2603:1096:604:144::12)
 by OS0PR01MB6082.jpnprd01.prod.outlook.com (2603:1096:604:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 02:00:21 +0000
Received: from OSAPR01MB7183.jpnprd01.prod.outlook.com
 ([fe80::d7f:a3c9:8f14:463]) by OSAPR01MB7183.jpnprd01.prod.outlook.com
 ([fe80::d7f:a3c9:8f14:463%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 02:00:21 +0000
From:   "zhoujie2011@fujitsu.com" <zhoujie2011@fujitsu.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "zhoujie2011@fujitsu.com" <zhoujie2011@fujitsu.com>
Subject: [PATCH] Add testBlock and testChar test request information
Thread-Topic: [PATCH] Add testBlock and testChar test request information
Thread-Index: AQHZWs+6BDzG3ie9iUqxjWGnTnmvhQ==
Date:   Mon, 20 Mar 2023 02:00:21 +0000
Message-ID: <20230320015856.381132-1-zhoujie2011@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7183:EE_|OS0PR01MB6082:EE_
x-ms-office365-filtering-correlation-id: 42c15ef8-8fc1-473d-4f8c-08db28e6dcd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UjXa0A5dNKOVk/rXSgUJYdJBzyLbP1lvA48Ot97S/yGkeMGvOY/N2sKr2v3Pya00AnDBI4fFgYK4HP/CitR8NkfdB2jX3RlTXki3cxrtQPAK3dOAO6/yqEtBBqzRVX1R0QrZsIczKIzQBnFWQRC3+0TMSEBAue9ob9bSVQUbBHFI2OSQjA8pTehpDbjqzVh+xoRU+FjJHflZZHWQy7q0Itvel+p7cTH94bWtCQawgS9jy+Rlr7M1OQAwzPx9jPbmPhDrNXR2uu32/b4CAKM99T+gVUiBMrMgrVm3vkPR6AHhqNZTatrVAOI4KWdsbQaXhWUFj+kWxFfQq9TScgvPB9JMzrS1Ugeu36DW3yf6e2Qa2SHrecfJUbqInaOoUHpmP/x5zGDfr8Ll84xHrajhbzDKU2sMdwSwK2LiPD2izdI8Yl4njjxq5psbhNVV5zhoH6sYO8h0JVnvd4RRCn6pFJjOj8nvz0ZLWXuBsjhLVhv7wLc/IO2TTpQr+cLf2NJoOEZCrSHxpvyHf0ypvz3LLDLV033pRVXqJxHYCmtjmgcNWIBgsQUgIVWPwAI16iKGuOzFeOX1vpuC2ED4h0f4sN1RgILjmhyS4sAGtMDoipfuuAvMb04sXhzlLcsHnZOSf48VyhC5Lkx4CbZzMLdPrKL2Sqsc0ZY2Xcfsn381yj3RY+fVzVCAvVRbYUJ2AIYKxe0jBlJyMNG0cdmIKtZT0uUEOZ77Gj5PGXAl8gYzlQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199018)(1590799015)(1580799012)(54906003)(41300700001)(66556008)(66446008)(76116006)(64756008)(66476007)(66946007)(478600001)(6916009)(91956017)(5660300002)(8936002)(4744005)(316002)(8676002)(36756003)(85182001)(4326008)(38070700005)(86362001)(1076003)(6486002)(6506007)(6512007)(122000001)(82960400001)(107886003)(26005)(186003)(2616005)(71200400001)(2906002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?ZmEvZ2J4aWhHRFlGbmZHVzJLWElLMnRRY1YzQ2pXcUFWa3RUNkUwMUFmK3dWSzhr?=
 =?big5?B?czJTcDNQUFk4cmxQYTN5bThEQyt3aytBRjgxYnlSTDI5OHZsTzQ0aGpFK3ZvZ1dx?=
 =?big5?B?eUdieFl4Y015SGQwTkRHeUhHcDk3a1kzWUFrQTRaWGp2YVZJM0xmMUhKZ1hoK0xV?=
 =?big5?B?L3hGdFltYTZ2My9JVE95NDNNbmY4bHNoSm1SRkc2VWZDdFo1MGdqcmdBdXMvelZI?=
 =?big5?B?aDA1TE9lMUtiUnhjNTR0Ry9ZNTVtbEI2OEoydkorOUhUcTVxUnkrRlRiWm9iM3E4?=
 =?big5?B?WVNCRkh6bFVsaTFKcHlFNjVKY2ZvMGZteDBtZzhyeUNOS3E2Q2ZpM3paeHlYNU0r?=
 =?big5?B?RjlNQ0FoS2dLczYxT3hqUDVUUXNrR0x1TlhnbU5FYWFUSk04YmY4ZTFlMGRpOHMz?=
 =?big5?B?YkF6bmhJT2EvYzFvWkxia0UrRWJLYVoyZDJnM2VlaVkvNW14a3BZSlNHcjhSUUcv?=
 =?big5?B?TGhFN1E5RGVsZFllRE1UTUdkaXVSWmI5YzlDd2Yrd3lUenYwSk5YdDNXU3BsTW5X?=
 =?big5?B?MFR4cWpmRS8yQ3FDRzc4SFF3RStoVkM2WTM5VXpUdmkwd2lQd1ZKcWhRa3dyc0Jr?=
 =?big5?B?ZGIydENUeHA0R05lWnhCZG00M1RvT01PS3NmMGpOcXRGbGh6NWhDM0l4bWEydEZn?=
 =?big5?B?K0lPNU5aSThhbVZaVjQ0OG9VTEhXMXh5Yk93TE9jMm8xcWFaVy8rWHY2aGFhSmIv?=
 =?big5?B?cTBVKzJlRVBBc2RPb3RFRC9ZUEFrcGVKWTVCVVRWRlAxSGFSNkhRQWpHSXZ2RlJk?=
 =?big5?B?eWZ5SG9hQlA1STY0NkEyQ1k5cHJWUm1lYU5qYkhBSmhZb0p3TTArenVlNjhqcXFt?=
 =?big5?B?VEVpbWpOWXhBNzFpZ0RGeE5WUUFoZjA2Yk1zN2tOU2tkL0hrNU9RQTZQK0ovVldI?=
 =?big5?B?cktHY1prU3RBR3NVdCtBNS84TjY5UU5Tai9pSVhGQ0JveUZWWW5kcFNCS2pqYnov?=
 =?big5?B?SUVPU2syTXk4dEtxOFFQVWhMN3VuemlaMlBsZ2I4UFdGQ1RPL0NSdnFnQ1locS9k?=
 =?big5?B?ZGlYU1hZQWFlYVRBQllzdGlqQVRwZmdlNnhzdDB4SmNoTjJrK1MzQTVjYnR1WFpO?=
 =?big5?B?OTJwQU5rM3Q4Mnc4eXMyWG1BaXVnQkVGSXRzOWFmaTdLMmNsQVNSc3ZSL2h2MXB2?=
 =?big5?B?NnZFUnN1NmZZeWdxZjFoRDRqWHBKUlJycGF4YW9YdU1NR3cxMVI2dE80MzZKQTlH?=
 =?big5?B?S2NURnJ6SEQ0UFNKMVBLVmtMZlYxWWVpd0NOM2NzTUpaeTU1dU1mREljWVA0ODFu?=
 =?big5?B?Y0FYQlhvZDhWdXh4MERVeTlVMEEzYW5HZGdiazQxbUZIWjhZcVU0eU16WUtDTlZC?=
 =?big5?B?ek13ZHViOWlURW9JWVVHVXBZSlNURG9uY1lzdzV0MWZkaG1FaE8rek9uYUd4ZVVj?=
 =?big5?B?dmp0Vk1UYmRGOGI5YjBPeXU2a2RLV0pSeEpSTm45OE9lM21CK0FkRGs5OU8rSFoz?=
 =?big5?B?UUFoVWoyVnlTQWpvQmhhU0tMQnh2Z3VTcTZPSkx6bjFTZnREUmUwRG0yMUNZN3Zn?=
 =?big5?B?bWsrSVRsNzBEQVlxT0dObjd3Ny9pekJtNk1qTU51Y0lOdmhZQU9qR0l0eUE2Q2RU?=
 =?big5?B?RlgzNTdhR0JreXFMdVNNQmhsa0pyQUNzT29nTlh5a3RaTm5GdVhZdVpORTBXTEVs?=
 =?big5?B?Q0RNOWNha3BMaEdWbk9RK08zZ1VmdHo3K3pnT0ZNbUtrK0dOczNrQWkxZWRwcTZG?=
 =?big5?B?YkVLNFpkNjZSQVpjb2E0ZzZMVTZPbGVreTd4K2QrdHluRDNEMHNGUFd0OGs3dENV?=
 =?big5?B?dUF4MkE5RDZHT0tWYTZxb0Z4OEpTRWhKMkdjdUpUS1EwTERaZEplYXRxZlg3QVdL?=
 =?big5?B?SFNWRS9PbjJxRnZVeDVaRVhBeVJkZWg3OFdkT1JqeVNuSDZjS21NdlBKa2R3bmU2?=
 =?big5?B?T0Rla1hjamNkOFVxY2hJc3JoNHNmclhFS1ltQ1poVlpmQ01hNjJUT1YzOUo3QjRi?=
 =?big5?B?bGptZ2pkSnBGKzltQVAydFFFbkFpcWxQdUhERjdaT3FtTzRvWjdyVlFuVGdPU2ZH?=
 =?big5?B?cDFHT1FwS2Evd2dCOUdBa2hweFRHTlFKVzhiS281dlE0eTgxMmc9PQ==?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bvefJcBxy21YrfIKapEmYguHFWrniWvQvuz8lyPHm0vgmZO7kTmH/4y1c/htz4tzvXsatJkeN48pH6uG2rRNvL+2iEI6g39LurtGwhZb08Y7GmpjNuTttQVe3nr3Ft3CBd7HLYlQx0bC9gFPZhCB0PYJ0RaGpyqhheZnYdgjmJs10FTeyBtSGYJ3/vODpa5cHd9AatiyxzCK+WeNO6jqIa/uEHRGjGpduavPoAEh7IRLdWhdUCgaXS6ejgdPBkTKjjX1E86EdpV0X3P1jUyLbtHFtMgdEfKsUs26mL3jTVgoj2szoV4GpCC/jWgj5PypAkmVeNFN4THTkzqCmXB3vFPBwzxU8Hftn0R1bkoVcyzCInlTMk8cdllhOoSn3iYFUwOE4sm9P9huG1wnKyrIeXBO0CdzDeiZI699YYL1VneB8N/n6QRdTD9xrvtCOBT2RRnB38Jq4MfT7K+KEKmsOEw56DPTZfyf+O1Qy5eAMU/mn+DezXuF8VirGvDYBfWPQNLY3K0TmeWfljvNTv7fCn2hGlHuY6m/pecbFQzSxrx0D0pp8JWhCJvOc6DCV+YrsNERToTd3gPd6IaWE1BOe31t0+F2+wDFMKtiuZV5uRqGAgkGe+xhmYDZ6Fcxzd/NJR4N1q6+RKHr06GAo9elPOFncekIQxvyi+nK2vuGylnXVvZ5UCpePzRcCy36JX0b2wib4WcKM89FdXcJkbeXzOszmmRAml5lBbzomPR18BRENSIlzfVpwW5WUlNKsKKqMBBiRlzgUDeOIjT5Rp3JalNfpifAcyVf/um3WxyXPtY9E0wS1PsLMdhBhuf02wzu
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c15ef8-8fc1-473d-4f8c-08db28e6dcd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 02:00:21.5326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckApjFzV5Nv085xDQzciuglduQCW8eXvsrK4qDTgWWlPjG+F7v0jsSLv6RV73Cwr2Q9WH+PFJwzhshw5qXN1DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6082
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

U2lnbmVkLW9mZi1ieTogSmllIFpob3UgPHpob3VqaWUyMDExQGZ1aml0c3UuY29tPg0KLS0tDQog
UkVBRE1FIHwgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL1JFQURNRSBiL1JFQURNRQ0KaW5kZXggYjhiNGU3Ny4uZTQ3MjcwNiAxMDA2NDQN
Ci0tLSBhL1JFQURNRQ0KKysrIGIvUkVBRE1FDQpAQCAtMjcsNiArMjcsMTEgQEAgTm90ZSB0aGF0
IGFueSBzZXJ2ZXIgdW5kZXIgdGVzdCBtdXN0IHBlcm1pdCBjb25uZWN0aW9ucyBmcm9tIGhpZ2gg
cG9ydA0KIG51bWJlcnMuICAoSW4gdGhlIGNhc2Ugb2YgdGhlIExpbnV4IE5GUyBzZXJ2ZXIsIHlv
dSBjYW4gZG8gdGhpcyBieQ0KIGFkZGluZyAiaW5zZWN1cmUiIHRvIHRoZSBleHBvcnQgb3B0aW9u
cy4pDQogDQorTm90ZSB0aGF0IHRlc3RCbG9jayBhbmQgdGVzdENoYXIgcmVsYXRlZCB0ZXN0IG5l
ZWQgcm9vdCBwZXJtaXNzaW9uIGluDQorTkZTIHNlcnZlciwgYmVjYXVzZSB0aG9zZSB0ZXN0cyBu
ZWVkIGNyZWF0ZSBibG9jayBkZXZpY2Ugb3IgY2hhciBkZXZpY2UuDQorKEluIHRoZSBjYXNlIG9m
IHRoZSBMaW51eCBORlMgc2VydmVyLCB5b3UgY2FuIGRvIHRoaXMgYnkgYWRkaW5nICJub19yb290
X3NxdWFzaCINCit0byB0aGUgZXhwb3J0IG9wdGlvbnMuKQ0KKw0KIE5vdGUgdGhhdCB0ZXN0IHJl
c3VsdHMgc2hvdWxkICpub3QqIGJlIGNvbnNpZGVyZWQgYXV0aG9yaXRhdGl2ZQ0KIHN0YXRlbWVu
dHMgYWJvdXQgdGhlIHByb3RvY29sLS1pZiB5b3UgZmluZCB0aGF0IGEgc2VydmVyIGZhaWxzIGEg
dGVzdCwNCiB5b3Ugc2hvdWxkIGNvbnN1bHQgdGhlIHJmYydzIGFuZCB0aGluayBjYXJlZnVsbHkg
YmVmb3JlIGFzc3VtaW5nIHRoYXQNCi0tIA0KMi4zOS4yDQo=
