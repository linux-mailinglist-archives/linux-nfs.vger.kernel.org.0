Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBEF3E21FE
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 05:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhHFDBF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Aug 2021 23:01:05 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:51040 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235709AbhHFDBD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Aug 2021 23:01:03 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2021 23:01:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1628218848; x=1659754848;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=TS0I44lrMUgCZWjvcDBTg7baDUBUV4++khwd2y+Z+QI=;
  b=ZTRrMWjEzD/CEFHQZIJ6W79SPYJR8OdXwWFq7RrAo4NS+RR5FiZBkaTF
   kwpIEKhgWC0KFnsrZA1Hgubs7Wm4ZH70qrdLBHld0+IZWur/Vh41D4TTQ
   K1FSyxMXq1yRpS2/PQx+cFWbkPkS6A9dZeTU0jtVWRoBuB8/4XBZE0Qf1
   mN5NiswCIdCl+wjFzM1pCmwM+nyuvWnviFpGZh1GXQKrciQ+ly6R84Iew
   t1U37B0+GLizRCJIgJ2oyUZ2nOuHMv92klCrDCr1K/1OW+6L/Ug6F3oKQ
   01x0xmjy7ZVHVrNPcCx83FLfrdab7ghVVp67hb/9OAETR4OWqBHRRS7tG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="44339443"
X-IronPort-AV: E=Sophos;i="5.84,299,1620658800"; 
   d="scan'208";a="44339443"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 11:53:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0OzFoh1W6L4rJDa2E+r3E+UcI8xFK4F+oiYf+jheOqHHRaLSNcUDt1sI1Y7VuKEZhDrV/W9SW/Ogw7JaSeGFTCX0KVqoZnGytLQu+hM92VA/f2REb2h87qt/czIITaqasp29nkK3cRbdW1hAnvsqjSNDmoQVgqnFSzdba3Xnh7yv1qJJUrB0N2pS83kmidLDlmN8cds4WQhpHisiLGB7zEnPZoK21msj7si/M0m2RM6wClYJqNhyWtVWJbBvBX/AJj2P8fWMNCRXEKsSP50gki5vi9DrFcu4aa7pBUe2TckeDuzG2R/VnR3XnSwQLRDiZ6+NdGe2BRJXISfKHg0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS0I44lrMUgCZWjvcDBTg7baDUBUV4++khwd2y+Z+QI=;
 b=ih9PBmiasxRFr7q9RVJKhSM+YPDPLDXhN/XMiXv4/laliCdOScjrKyeYhyVx/bBX5E5WPQ75vgFMuJ+oVD4IUgB+5l2IzRO0Xpwi5ROW/LFWBuRduWyzmEG5fMe3med6LmkGzk7+q/ptzYQp+pbVgvnaVIdwSsSVUZQcPgqBJUUsiY8avwIYlTDlAaRb+K2EIWuN06qElOSjZeIaIIUV/lJvfZG5tBd28GYS5TEObBEyw5Lt5QltmLE6VZwMIDPCKKulrIYzHPC3KtCVTvsClYBBvcyJlZ3Tfu9B7sv5PnaMnhv6bMZMTPcFFnQrPncIewVmsLVhEWAiPB9T+FX3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS0I44lrMUgCZWjvcDBTg7baDUBUV4++khwd2y+Z+QI=;
 b=J2Wq27gqGIGWT4M/r0Dhpnfzq281kgC0shkzkMBF+CFuj2YKYV6uBw5qfpYNZyj9ByrIPp1BeaOdqxb55PHZZ0Nh23RCaZm9enDDl4LdgCslE3NtXdoCY7ZvuoY4dAawuxp3gFGSRfcG84zhdWrhxtpsLM4U2Js6Pc6COwry36w=
Received: from TY2PR01MB2124.jpnprd01.prod.outlook.com (2603:1096:404:e::16)
 by TYAPR01MB2656.jpnprd01.prod.outlook.com (2603:1096:404:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 02:53:36 +0000
Received: from TY2PR01MB2124.jpnprd01.prod.outlook.com
 ([fe80::c013:4af0:bb36:2368]) by TY2PR01MB2124.jpnprd01.prod.outlook.com
 ([fe80::c013:4af0:bb36:2368%5]) with mapi id 15.20.4394.019; Fri, 6 Aug 2021
 02:53:36 +0000
From:   "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "mora@netapp.com" <mora@netapp.com>
Subject: =?gb2312?B?u9i4tDogIFtQQVRDSCAxLzJdIG5mc3Rlc3Q6IHB5dGhvbjM6IGZpeCByZXhl?=
 =?gb2312?Q?c_error_while_calling_self.process.stdin.write?=
Thread-Topic: [PATCH 1/2] nfstest: python3: fix rexec error while calling
 self.process.stdin.write
Thread-Index: AQHXim09YQ3wybV6MEeT4I6vtT/MSKtlxs7+
Date:   Fri, 6 Aug 2021 02:53:36 +0000
Message-ID: <TY2PR01MB212415A9A1B901F79888B29C89F39@TY2PR01MB2124.jpnprd01.prod.outlook.com>
References: <TY2PR01MB21247B7616B9A21424F7CB1089F39@TY2PR01MB2124.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB21247B7616B9A21424F7CB1089F39@TY2PR01MB2124.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df1e4059-4331-4d48-6836-08d958856318
x-ms-traffictypediagnostic: TYAPR01MB2656:
x-microsoft-antispam-prvs: <TYAPR01MB2656D2516AD2EBD5BE7E420E89F39@TYAPR01MB2656.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ox22K5X1RM42IIFEw8Jh8n8IvzWEV0fo1Th7Up3FDhjwhT7l6oc7kHwU5YAKuFmq/JAaOuEssKatMUQnejr4PoU6zVe9qf1UWP0mInn4VXBwpOPHWdD6HiCr+S6+RLSm6vjp/P34pLNX8jcHnrBL28+SvOUB2SIFOnNtJx1qVbKK9UAy0SyGvNQCQ51cM40Djh1B/RCtSGgIcbGptnyCxtAgYeYcY66uDUzLHBvpcdUZ8q/odGeI8eAaRFaHdVtioDrOp+3AsxUhBuaI6sZpKZsgop8JB81WydAusK7rliUoiHxKOiUPVNQfxVZqanTshHRk4ibOTFTTuHUv039LwuZNhVaUGlhaa5ZSypHXjjSY2LoNtQLYKA5+wIfxxWuxv003nFeOYreeTXVXJLlNU8qssSAGfnDxGc3UxJ0O9JQSsSKJ182RSSxGVtvbLHRSMc4py0GIkJ68favFL8V9rfdsV0h4fx+7GEogprTQDziKxwjvSwIQLUw4O0WGPwn+Oc2sqUt1jaMOfVgDjFPBfBSaGyWzrQGeZYm+dRkNEBsRJf3IkukdnRArH0y0QJUBOXpUepswnp+S2n2cSF7TojiCdD3MeRtadxX0xtqCl0uuMfjx91ud0LhpThBd9FbCvDx+FV8XZXFjVtbNS1doWA6ePaXfZ2ZN8tDvGl/JXDPHdeOOyX49W3NgAJRtiPfQft0Se/+3bMrbat7fdhR8Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(7696005)(26005)(186003)(8936002)(83380400001)(316002)(110136005)(38070700005)(33656002)(478600001)(122000001)(6506007)(38100700002)(224303003)(52536014)(66556008)(64756008)(5660300002)(85182001)(55016002)(91956017)(76116006)(9686003)(66946007)(2940100002)(66476007)(66446008)(2906002)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZW9Za2JIOUJaQ2dybStvVlZHd2V5UEJzT1BmdjRxZkgrLzRYYklUZDIwTlVo?=
 =?gb2312?B?Rm5vc21UV1lXai9LNi9NS2lmaHBpTk1oVmdoeFVjdTJKeU9sWk1Cd2Vhbmx2?=
 =?gb2312?B?MkR5RE4vaFpKRi8vR1pPUGVVaGF2VmxCQng1TkR2QlErL0tHc2RoQ1RnZ29N?=
 =?gb2312?B?UXFLdkg2MmRMS3l6M3dpVSttcmRVekx6ODAyWFJBY2YvS0p1N2s2U29nWSt6?=
 =?gb2312?B?RFlCbEJOSmNFNXdOS2ZualN6MFFGRFJ6RDE3U1o3UWxLQW9rQlBSY3JPTUdj?=
 =?gb2312?B?MmdpUDgwUjY5K3hhUFgxN2RsWCtHUGVTNWhyRHhMS3NjWVVIc2xQMC9HS09D?=
 =?gb2312?B?V2lLR3VSZHJTRVJwT0grTWJUbFFvYXJwY2xjc3FZVkpOODYzMTk2cnJvSlIr?=
 =?gb2312?B?TWQxNTNPMElBKzBjRGdaRFpXNXA4VWRUMG5QdDNESW9oZ05xU3hSejVPVDEr?=
 =?gb2312?B?SHJSRk1zYjVqc1hPTVk3S3d6S05yZGptYnVQcDRSQTdMWmZGNDhvYkxmdUVs?=
 =?gb2312?B?OHVpTnkrR2lielA4UjU4UkpZbGFJTG9ndjBZaXQrbWk2MHZRV3FaUlFTeENE?=
 =?gb2312?B?ZmZxNFJNY0x4WExmVG81UDdZbzlhaklwR1U0bFNTTUVqMVRHZUJZcllBN21T?=
 =?gb2312?B?N2RIWm1lZ2FVZmVnNStqMHlmS1I3MjE2aE1GS1ljN2hndzdhbE93MGltQm12?=
 =?gb2312?B?aG9LMUEyZytxa3ZZMVVwUnptdjRpMHJDWm9MZnJUVFBVcXBTTDU4YUpobzZR?=
 =?gb2312?B?QTdrMUhzcVBjTEFzVjQ0UnM5RFJzK2NESlk2WUwxSFFqTDZwODlrZDVNVXE2?=
 =?gb2312?B?WjdTQUlnNTFzbWwybnROV2F5T3VpV0JFdWcydkIzV1FQOVJ0NjRnVGsxR1pE?=
 =?gb2312?B?R0tsTWJUMzNZblB1b0ZiOTRHZ25xZFhlZUxPa3NoT1o2VTRMbmdYMHF6Q2lh?=
 =?gb2312?B?cmYxa01aVWVaUHJaaitqSHFZeTJobVhyZkFqRmxMbDM5ZCtDQlZCVllBa0g1?=
 =?gb2312?B?ZDY4QmxzQmdOZUtMeVZGR1loZ1RuQm5obHlqNFpqWnQ3dFB0dWFFZU93eXRW?=
 =?gb2312?B?RG1qdkllTWhGTVpWZWFZSHZaNG51ZDRLMTFsUnNSeUY5Yzl2VzR0cS9Ka0w0?=
 =?gb2312?B?eHRMa0c4SWRaTi9ZTDZlUUhHak5laW9SQlNUTjhvVW9ualNOVndvaEp1bmVG?=
 =?gb2312?B?VUlxWCtaVjlJamp5TnNwdHMwVTRTeklFYWcwa1dnMmNvQ0YzRGl4em1Wc1lV?=
 =?gb2312?B?TUt1TGpRQXY5REZiUU1tRUE5N0loNWxVNzJJVFJUdVk3TXcwYUhQSGlKMkcz?=
 =?gb2312?B?aHFZVDRObmpoNWFLdVY1ZTMveE5iRU9oVzlhb09xVENhbTVoaHhKQklmcS8w?=
 =?gb2312?B?TDNkQ04yQzE1VTNQVmdmem1RT3hOb01xOHNyQlkxdlVkN3hJUUUzSkVKWGJ6?=
 =?gb2312?B?K24zTjhkNDZ2Wk1kdXkwSnZBWGZrQjNOTmcyVldvMHgwbjM5MVVMSTRRaHVi?=
 =?gb2312?B?eVB4SDVHYUVoQ2RQa1BBT1VycFdFUVA1aGlzOFlKQXd2TWlTdHpFcFFPOWdx?=
 =?gb2312?B?cURZUjE5Y0paSWJWRmtPU0pTUjgxcU9DUUNXeERiMFEzNStEdlZ2Uk1rRjFJ?=
 =?gb2312?B?eDRHa3BkUlBLSEZieFljNGE2R1hBZXprWld2aWFMUFV4aVZ3MGNDejRxaFZ4?=
 =?gb2312?B?OTBxSHBQczJzZzV3MmRleEN6bVlkZXR2VE9oUnF1Q1BOZmorZW5jSjh3Nkw4?=
 =?gb2312?Q?vxx/tTVssyi3VVdQsu9bgQo467zo8un62qpFvtc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1e4059-4331-4d48-6836-08d958856318
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 02:53:36.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0FE7t+rtlRwO6gQ65CL3NLL4RXcU2FBmtjzAKAD0Y5XqJdFB8MOrO4y9IcloY4W7B71OQ/xHyn24jTOmM0TdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2656
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

QW5kIENDIEpvcmdlIE1vcmEuIEkgY2FuIG5vdCBmb3VuZCBvdGhlciBtYWlsaW5nIGxpc3QgYWJv
dXQgbmZzdGVzdCBzbyBJIGd1ZXNzIGl0J3MgbGludXgtbmZzLg0KU29ycnkgaWYgdGhvc2UgcGF0
Y2hlcyBib3RoZXIgeW91IG5mcyBmb2xrcy4NCg0KLS0NClN1DQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogU3UsIFl1ZS/L1SDUvQ0Kt6LLzcqxvOQ6
IDIwMjHE6jjUwjbI1SAxMDo0Nw0KytW8/sjLOiBsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnDQrW
98ziOiAgW1BBVENIIDEvMl0gbmZzdGVzdDogcHl0aG9uMzogZml4IHJleGVjIGVycm9yIHdoaWxl
IGNhbGxpbmcgc2VsZi5wcm9jZXNzLnN0ZGluLndyaXRlDQoNCldoaWxlIHJ1bm5pbmcgbmZzdGVz
dF9kZWxlZ2F0aW9uIG9mIG5mc3Rlc3QgaW4gdjMuMDoNCg0KICAkIC4vbmZzdGVzdF9kZWxlZ2F0
aW9uIC0tbmZzdmVyc2lvbj00LjIgLWUgL25mc3Jvb3QgXA0KICAgICAgLS1zZXJ2ZXIgMTkyLjE2
OC4yMjAuMTg0IC0tY2xpZW50IDE5Mi4xNjguMjIwLjEwNw0KICBUcmFjZWJhY2sgKG1vc3QgcmVj
ZW50IGNhbGwgbGFzdCk6DQogICAgRmlsZSAiLi9uZnN0ZXN0X2RlbGVnYXRpb24iLCBsaW5lIDE2
NjYsIGluIDxtb2R1bGU+DQogICAgICB4ID0gRGVsZWdUZXN0KHVzYWdlPVVTQUdFLCB0ZXN0bmFt
ZXM9VEVTVE5BTUVTLCB0ZXN0Z3JvdXBzPVRFU1RHUk9VUFMsIHNpZD1TQ1JJUFRfSUQpDQogICAg
RmlsZSAiLi9uZnN0ZXN0X2RlbGVnYXRpb24iLCBsaW5lIDM2MywgaW4gX19pbml0X18NCiAgICAg
IHNlbGYuY3JlYXRlX3JleGVjKGNsaWVudF9uYW1lKQ0KICAgIEZpbGUgIi9yb290L25mc3Rlc3Qv
bmZzdGVzdC90ZXN0X3V0aWwucHkiLCBsaW5lIDEzNzAsIGluIGNyZWF0ZV9yZXhlYw0KICAgICAg
c2VsZi5yZXhlY29iaiA9IFJleGVjKHNlcnZlcm5hbWUsICoqa3dkcykNCiAgICBGaWxlICIvcm9v
dC9uZnN0ZXN0L25mc3Rlc3QvcmV4ZWMucHkiLCBsaW5lIDI5NSwgaW4gX19pbml0X18NCiAgICAg
IHNlbGYucHJvY2Vzcy5zdGRpbi53cml0ZShzZXJ2ZXJfY29kZSkNCiAgVHlwZUVycm9yOiBhIGJ5
dGVzLWxpa2Ugb2JqZWN0IGlzIHJlcXVpcmVkLCBub3QgJ3N0cicNCg0KSW4gcHl0aG9uMywgc2Vs
Zi5wcm9jZXNzLnN0ZGluLndyaXRlKCkgb25seSBhY2NlcHRzIGEgYnl0ZXMtbGlrZQ0Kb2JqZWN0
IG5vdCAnc3RyJy4NCkZpeCBpdCBieSBjYWxsaW5nIHNlcnZlcl9jb2RlLmVuY29kZSgpIGFuZCBz
ZWxmLnByb2Nlc3Muc3RkaW4uZmx1c2goKS4NCg0KU2lnbmVkLW9mZi1ieTogU3UgWXVlIDxzdXku
Zm5zdEBmdWppdHN1LmNvbT4NCi0tLQ0KIG5mc3Rlc3QvcmV4ZWMucHkgfCAzICsrLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L25mc3Rlc3QvcmV4ZWMucHkgYi9uZnN0ZXN0L3JleGVjLnB5DQppbmRleCBmYTk0MWI2Li41MTU4
NmM1IDEwMDY0NA0KLS0tIGEvbmZzdGVzdC9yZXhlYy5weQ0KKysrIGIvbmZzdGVzdC9yZXhlYy5w
eQ0KQEAgLTI5Miw3ICsyOTIsOCBAQCBjbGFzcyBSZXhlYyhCYXNlT2JqKToNCiAgICAgICAgICAg
ICAgICAgc2VsZi5wcm9jZXNzID0gUG9wZW4oIiAiLmpvaW4oY21kbGlzdCksIHNoZWxsPVRydWUs
IHN0ZGluPVBJUEUpDQoNCiAgICAgICAgICAgICAjIFNlbmQgdGhlIHNlcnZlciBjb2RlIHRvIGJl
IGV4ZWN1dGVkIHZpYSBzdGFuZGFyZCBpbnB1dA0KLSAgICAgICAgICAgIHNlbGYucHJvY2Vzcy5z
dGRpbi53cml0ZShzZXJ2ZXJfY29kZSkNCisgICAgICAgICAgICBzZWxmLnByb2Nlc3Muc3RkaW4u
d3JpdGUoc2VydmVyX2NvZGUuZW5jb2RlKCkpDQorICAgICAgICAgICAgc2VsZi5wcm9jZXNzLnN0
ZGluLmZsdXNoKCkNCg0KICAgICAgICAgIyBDb25uZWN0IHRvIHJlbW90ZSBzZXJ2ZXINCiAgICAg
ICAgIGV0aW1lID0gdGltZS50aW1lKCkgKyA1LjANCi0tDQoyLjMwLjEgKEFwcGxlIEdpdC0xMzAp
DQo=
