Return-Path: <linux-nfs+bounces-2509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1461788FD8A
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 11:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEAF297751
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C087D3E7;
	Thu, 28 Mar 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lyyPBn6g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094943ACD
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623396; cv=fail; b=ihWMmMbI2uuhS8Ayxgtu8BPlLo04rIyGz1bJ7wGmv/2D8hZW3iXxOXpjrw9YX/XBDTm0eSHAZa9aEcGC6CmFLqRJveUXTlacgYLPfzDIxkpxShqJrXjwdNoGn+6n5KXaCDrt1+KbwiUY6o3mufWpRbCe//UXzkz8zAA7g7xamWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623396; c=relaxed/simple;
	bh=TSHp+8VuzItQ/CcHTC9+VO4kxckeSaIkmbkPHtaGEL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fg88e9dYVEStCsx7acai+nfXjl5ZwtnC/yU/XGxPBEBwaNhmz8uXNzyqR56aJjEzMS0n+CC1fOOxleXjDfz3TO5xxUKKbvqzWZjHi9oY5tpzj8u+6Cny3cTzgC/WvFxfskAFP+ffEuFMkDPRt/aGFh0pOn1qyIHjVtPMWzV7Jx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lyyPBn6g; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711623394; x=1743159394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TSHp+8VuzItQ/CcHTC9+VO4kxckeSaIkmbkPHtaGEL8=;
  b=lyyPBn6ghwWR9LPxRnQoh8smZrNRFi42JpzJu/SApiwzzP66xBBdolqB
   XY6vPg4jfS+jASEXR+iOcb/8dPLe3smUu4Uy1e/f7rt+aWL+8qJASH+Bq
   yX0dPoTWOn4XI9CAxDUSqc2MCJo29y3yK3AQp1X7Xi1KIBq2tP2gkWfGy
   j16SZJB0N0VNuo8cpSijcJ5/yHez1AVEj7PyORRIxfham4iaeDvGUJ9bb
   f5BbV7bsFsNT9zASwlAF1J9I/PXOUG+rsxMYr98dQCSeA/qb5xI/lrlcV
   H3xnciGYwZYdZK+HkAuDEh4Wg0m8oveXtGn3lxM2cLYUa0BBwp78OlrOW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="115262764"
X-IronPort-AV: E=Sophos;i="6.07,161,1708354800"; 
   d="scan'208";a="115262764"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:55:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKJmTLlm0rx2sperqk4Z5ju7OFdTpLdY9xE9d71w7ZrfkPmqC14ElfQxyjc5JbECbf5uXAtmsLkTagU1sRQkTr+Qkw4CXi+/rIiJvJxXxLppVaX+WY+qtF+7Zcw/0y5e4D9dFanccoCgvA27sC4JqaXCgG9HkpF70IY28sGRU9DXcd5+OcWkXhKFAjUMriAB/isvy/pVt+qRBgzahBH8PRBSbOXToDNTqUrxuEsg5qDCk0A7ojOOboONA8Zr1lmUFO9Gpmb2jmd8SRAQlp98uHjfdBO3yolHTkDpDzqRzp3bBPTNOw2c1lkYWsnG3XOXWvT6FalPPLNU/LZ81sn1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSHp+8VuzItQ/CcHTC9+VO4kxckeSaIkmbkPHtaGEL8=;
 b=BcEuNUis03BkjDhQJRX5kvmy/P3kZApAZVK4qUznwwo8SPAwhBE2X6Zrwv7MMj1/OjkkTnz0xnfKPyg2X2vXA3ij2oe8LxUhnjdnwoyMws/32viDonAgH7UDXeBWUvdbZJUFIt9pxWqsBz/lqRZE19/87mb53ybLvjMCBjF24oy/euKdeZCsvCpDCnwJjNx5/2T5vDbBzGvRJr6S7bXXVRtHpxd1hUuj8XQ/sq3Wr09KMEvZiIjvCv6Pd6p5ywwf5Fa18A/3bACOZIaT9N77r7aP0znsfj4Dzresoa2pDOKxyoVVigin23Prud6zxbmrhE+hgs8IYTkc1FDQ6Z32vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYBPR01MB5328.jpnprd01.prod.outlook.com (2603:1096:404:801f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Thu, 28 Mar
 2024 10:55:17 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 10:55:16 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Chuck Lever <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: trace export root filehandle event
Thread-Topic: [PATCH] NFSD: trace export root filehandle event
Thread-Index: AQHagFz0uIwTcnboYEqxSgcqIBjnwLFLwH6AgAE7m2A=
Date: Thu, 28 Mar 2024 10:55:16 +0000
Message-ID:
 <TYWPR01MB12085995872AB9BA28F21D032E63B2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240327152737.1411-1-chenhx.fnst@fujitsu.com>
 <ZgRD066XLhoQRXS+@tissot.1015granger.net>
In-Reply-To: <ZgRD066XLhoQRXS+@tissot.1015granger.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=f0678aa4-d2fa-46ef-b3f1-85901c81270a;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-03-28T02:32:24Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYBPR01MB5328:EE_
x-ms-office365-filtering-correlation-id: 3616422b-e388-46e7-f325-08dc4f158d87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UwGUdr9z44x4n8xvEarUhEr4GFTirZjF3zoVH6ijfbIBdkQwVn4z35f6W8UiWDQ56JVTGXfpGiAbjzY8WTKIBYx5rdZqlJVU5Y5MEDkxG7PXnhOXGenJRxAHzBVnB5wMuloaGuRtK9TM0KJ2KQYzK2eZxzXpqYMZS/l4cRhXBznbSJ0INVYYWQ6ryY6TgR0LRNqbr+soOgK62AibTDYk8kPMMU0PSy8HB5F5wRPeKbxzLlBldweE0PT6wxSUyzzRQ1VWjKzgcW45vFi2xwiLLajT11IPPuYmet2cg2ul/ZHR9x8a1T5cuTa3QKWoSPAUgbv3NHjzTMxY0ASwUh1SqgmGOEomhqFthYflT9cZ3u+bX9YM33LtQ5ZHN/iysB2nQGUne8bRHKWrqwg26UNcSKivDsXX3iZA8C5w0sSY1Z1Agwadz4nGyjxhyD+TIxMB8OtdMr++elY5lbQuKS0DukdjpGNdqlZi7s6CiZftuX8Mf90imxEPQF538bBnc/StoG7gjd1rOf+JcY/k263Hzck1CCm+OywHy02Qgm7OgQJ0AUDbZvLBuqZ1tUPp0HNNZQe1PFzE+zYDOyaxkTawcXuKzZfzB12NY35UTDHknWgrqDo8gC1BSnNpA7YalDIx6Me4AJhPSZD5XQXIkSn94NSSIdjbpl9nMKJloIbH022oKtbjY4p3afMfV7ZAVLIUfn5gobJ/D9rW8kPrSh4M1nVCHJJG9PONMaKV+/+DV5YAU0Dyg9KhEFT10aM05KWT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MmJocE1OVU5qRlhGcDl1dUM3enlhM0kzODQvV0NjRkdmaXZsWmlaRjJOZHVP?=
 =?gb2312?B?b2lqdlR0UEJpQnE5ZVJFZUp0S2JvYzU4eVFPeFpOSzNraE1FR0g0R1kxZHhE?=
 =?gb2312?B?cC9hVWYxdEY4ZVlOYnVQNTJURmhZd29yMmd4VExxNDNpWHhFOXhFajNMZXJW?=
 =?gb2312?B?TDA1Y3p3Ri9VQUFvaHpUcWtydjM3RTQrQk1DWWhEVkdEbU80N0g1YTBJZ3Yz?=
 =?gb2312?B?WTd5dTIrdHpXTTNveWtXbHFjQ0VqSktScTRHMWwvUE5jd1l2STdqNTUvOUNC?=
 =?gb2312?B?cUR1TW0vRk5ocUNUYkI4REJDSUVpTWFReW4wbng2MlVZVW1WMjZ5M1YyWncv?=
 =?gb2312?B?alNuNkhyaGloU25uWnQ2QzRtNHkyaERrS0RIbEdTQXZySTIrKzdjdEZvYzlq?=
 =?gb2312?B?Qlp0d2FnS2RLOWtkU2E1VFNMYitScmtTMjlOTWlJYjJId05KbjIvZ1hTVUN0?=
 =?gb2312?B?dkdaa2l3TFcxYlZDVHdyM0ljVHlLVHlSUVd0Z2U3ZFQzdXYxQWU1djVNb2lS?=
 =?gb2312?B?TW9VY3I4QnZTUkNkT1hUUzYxb25VZHhEVWtaQm9TZkVvblVCNGcxNUtpTTZF?=
 =?gb2312?B?L0l1Y05IUHkxQ1QxcW4rMDZDUG5yVVNVTFhBYngrSDRzNVRQdEc2eWc1WFBn?=
 =?gb2312?B?dGRta3hTSEEwZ09PUzVIQVEzajNINWRPckVDT1ZFNXRGaXYwL1RHL2dHSlRa?=
 =?gb2312?B?YzkraEJNZUQrYklzb0dmdFZmVGlPOTVtL1NhWnFFc1ZlSEhpZHBUOGYyMTRX?=
 =?gb2312?B?Zy9SZVhIY3Bqa2YzZkUxQkZQb1FVZ1pRRzZFbndsaVp6L2dPclA1Z2FnY3Jh?=
 =?gb2312?B?ZWttWjJQVXB0dVV2c3ZnamRkRk8rbS9ZbUlyNGhBcm1QNEIzNnJ3N1VFd0F4?=
 =?gb2312?B?UDRxSnhtSXJyQkMxR0l4WE5ldytsNGZEUFZRRVJMaFJnVDhLdm5hZkJTTlFB?=
 =?gb2312?B?UU5VTzMycVRzYWFwM0g1U0FZNm1iS25uNmdPYTJWNWF2OXREcW8vSndwMDZF?=
 =?gb2312?B?SUZLMGdBQWFPdFg1ZERrVXlPTm0yRGNrRmpRKy9vVC9hT2ZOM2pZTEt3MFN1?=
 =?gb2312?B?YnFvYVhPVUtaOS91YW5rL0RSeUFSRXM1a2d3VmR6Y1NwYmdxdjZ3UmVtQ0Nk?=
 =?gb2312?B?Sy9iZlZQRFYwRUcvZkU0Z0YwMC9hbmtJV0ZEVjlRaXlLbWsrZ2RSdjl1Qy9K?=
 =?gb2312?B?TUU0NHNXVXFSSTlxUjZBNnlnVVRVc2J5aWRpQUNlU2NraG9weTA0M1dWUWVv?=
 =?gb2312?B?TjJ6cVJMMUY4VXcxbjVPSU9rTmsrZTJlNmdvcUttekhWS3JVOHBBT3VuaVlx?=
 =?gb2312?B?UHdWb01CQnZKN0l1L2gzbmtJSzUrRVMwc3NqQ0JJdVJWWEwyY3RmcUlpM2Q3?=
 =?gb2312?B?NnRjQkNMV0RVU3hFODVpeS9TeExNeFpDUXBCZ3FrT3FoYkRJQzVwcnhteVRT?=
 =?gb2312?B?ZVVORFEzaWVBRzNCWHFWM2RtR2V5UTlRQkdyQ3BreitDT2ZCaUpDTUNRR3pr?=
 =?gb2312?B?bEZCMkQvM01BTkVJV210cmVZT1dLS25XbndTMEZpaFZZSFJ3TVg5bTJCSTdv?=
 =?gb2312?B?K2R0T1d4UHZjTVRpRWU1MW8xYVQxYzM0SE9DUTNmR2ZwVGJVZHQreVl1WmZH?=
 =?gb2312?B?OFJDQUtBMnAxUklIMnY5U1dKUmhLVTk5bjhMeVZVUGMwVlVIaUdGSURNd1M4?=
 =?gb2312?B?WkZBSE1VdnJRZ1hLR1VSZDBxZytiOEIvYlVST3NwV2xCc0IwQitvWDNCSjJn?=
 =?gb2312?B?ODgwc2xLQzhLeEVVWTlMZWU0dWw4Ym8wbHdRbnJwZlRRUWZjclNhS2hTeE9E?=
 =?gb2312?B?ZE15OXd3UnRiazVNRm5DVWUybVh1UGpXbk9kdWU2N2dhcXdMVGFPSmFYVzIw?=
 =?gb2312?B?Vm9MdkVPYjlqYTFkNkNyalpmcEQyZEQvTDh3L2FKbVV0U0hZNXUwMks3NG1I?=
 =?gb2312?B?QlA4Z0hIWlZIVWIvSnB2d0JhVkdDNnYyemZxcy9sTEZqdlRmdzJyTUdYazdm?=
 =?gb2312?B?NnBjREY1QmdJcjh4TDVta3prUmxQamVVeDUvR0dPUlQrTThCTFlYYzFKa1hM?=
 =?gb2312?B?M3ZEM054eEhnMlAxUjdKd0lZeTlNa09vRkc0WHI1eXVOcVM0RjVvbUxJL0VU?=
 =?gb2312?Q?Jbsn/r8DjMDr/g315bBgtnfcL?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tubhdU+ZGDWqrn3grYSCMXLhjbKSFq8Cydc3JfYhSDgHJX+j+S/Y+DhdTi5MUg+HY2b10Df0T8/8iOspZxOimCBtyGleyizEsOsA7IK4XJV4vYR8TcIDk0OtIuX0uSjrO3BoAQihS8d8NjhigqB6pu3HsjzfIqfzjDwP/zdkqop7Z1gqr2CobHZI3bGH2QMnnE90FcMShrCWvOSZkc3kO2cpQd7qtfrkd6EqKapkn5FYNesHyQOiVLz6DXdfbsHvwbgZr1UaBGoYQKU/xGHMrmpsX4sqNj2sH3xKKQ2ibqfwC+LbwhQXZjAapW4qDd9NRcRLnvmQizhcKQkS+4erLzkk3vYG+fU0LAomG6Eyb/mvMTf1tPToPuDEzWJFjvUu8OaPijtFSALlmteoxSPdCqxZwgZ+iwgAwgVSoy74GU4mfbnKOcJkaqyW8geN8Yc/Al7Neh7KFZnT4Ub2diJh4SMxkSRIGBbn8kUdvm7md+zUVwoWQ13Se5Ab16eTDuk+BqO8EnAZOp3FjtungDKQ5vdifVr1k9kiWqQ5CkfMCatrgZ8m9/6/uFLlqorn5LYM9K6XPyUZ3Egs2WLKZ1xD+kQRqsJqr+6Q5WhzeeUnuIkLDx72TxrShFKb9PbaQKHN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3616422b-e388-46e7-f325-08dc4f158d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 10:55:16.6636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uK7Gjq9yMA66kRvkN9Sluf928cwylmGLYRtxtLl3Ab+/vx/q9ThasnJurAcPxp+XOSNyJXZCaE+bzE2SI5H6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5328

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxl
dmVyQG9yYWNsZS5jb20+DQo+ILeiy83KsbzkOiAyMDI0xOoz1MIyOMjVIDA6MDYNCj4gytW8/sjL
OiBDaGVuLCBIYW54aWEgPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPg0KPiCzrcvNOiBKZWZmIExh
eXRvbiA8amxheXRvbkBrZXJuZWwub3JnPjsgTmVpbCBCcm93biA8bmVpbGJAc3VzZS5kZT47IE9s
Z2ENCj4gS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPjsgRGFpIE5nbyA8RGFpLk5nb0Bv
cmFjbGUuY29tPjsgVG9tDQo+IFRhbHBleSA8dG9tQHRhbHBleS5jb20+OyBsaW51eC1uZnNAdmdl
ci5rZXJuZWwub3JnDQo+INb3zOI6IFJlOiBbUEFUQ0hdIE5GU0Q6IHRyYWNlIGV4cG9ydCByb290
IGZpbGVoYW5kbGUgZXZlbnQNCj4gDQo+IE9uIFdlZCwgTWFyIDI3LCAyMDI0IGF0IDExOjI3OjM3
UE0gKzA4MDAsIENoZW4gSGFueGlhbyB3cm90ZToNCj4gPiBBZGQgYSB0cmFjZXBvaW50IGZvciBv
YnRhaW5pbmcgcm9vdCBmaWxlaGFuZGxlIGV2ZW50DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBD
aGVuIEhhbnhpYW8gPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICBmcy9u
ZnNkL2V4cG9ydC5jIHwgIDQgKy0tLQ0KPiA+ICBmcy9uZnNkL3RyYWNlLmggIHwgMzkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
NDAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9m
cy9uZnNkL2V4cG9ydC5jIGIvZnMvbmZzZC9leHBvcnQuYw0KPiA+IGluZGV4IDdiNjQxMDk1YTY2
NS4uNjkwNzIxYmE0MmYzIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mc2QvZXhwb3J0LmMNCj4gPiAr
KysgYi9mcy9uZnNkL2V4cG9ydC5jDQo+ID4gQEAgLTEwMjcsMTUgKzEwMjcsMTMgQEAgZXhwX3Jv
b3RmaChzdHJ1Y3QgbmV0ICpuZXQsIHN0cnVjdCBhdXRoX2RvbWFpbg0KPiAqY2xwLCBjaGFyICpu
YW1lLA0KPiA+ICAJfQ0KPiA+ICAJaW5vZGUgPSBkX2lub2RlKHBhdGguZGVudHJ5KTsNCj4gPg0K
PiA+IC0JZHByaW50aygibmZzZDogZXhwX3Jvb3RmaCglcyBbJXBdICVzOiVzLyVsZClcbiIsDQo+
ID4gLQkJIG5hbWUsIHBhdGguZGVudHJ5LCBjbHAtPm5hbWUsDQo+ID4gLQkJIGlub2RlLT5pX3Ni
LT5zX2lkLCBpbm9kZS0+aV9pbm8pOw0KPiA+ICAJZXhwID0gZXhwX3BhcmVudChjZCwgY2xwLCAm
cGF0aCk7DQo+ID4gIAlpZiAoSVNfRVJSKGV4cCkpIHsNCj4gPiAgCQllcnIgPSBQVFJfRVJSKGV4
cCk7DQo+ID4gIAkJZ290byBvdXQ7DQo+ID4gIAl9DQo+ID4NCj4gPiArCXRyYWNlX25mc2RfZXhw
X3Jvb3RmaChuYW1lLCBwYXRoLmRlbnRyeSwgY2xwLT5uYW1lLCBpbm9kZSwgZXhwKTsNCj4gDQo+
IENvbnZlcnRpbmcgdGhlIGFib3ZlIGRwcmludGsgdG8gYSB0cmFjZXBvaW50IHNlZW1zIHNlbnNp
YmxlLg0KPiANCj4gSSdkIGxpa2UgdG8gaGVhciBjb21tZW50cyBmcm9tIG90aGVycyBhYm91dCB3
aGV0aGVyIHRoZSBuZXcNCj4gdHJhY2Vwb2ludCByZWNvcmRzIGEgdXNlZnVsIHNldCBvZiBpbmZv
cm1hdGlvbi4gV2UgZG9uJ3QgbmVlZCB0bw0KPiByZWNvcmQgdGhlIG1lbW9yeSBhZGRyZXNzIG9m
IHRoZSBkZW50cnksIGZvciBleGFtcGxlLiBSZWNvcmRpbmcgdGhlDQo+IG5ldCBuYW1lc3BhY2Ug
bWlnaHQgYmUgdXNlZnVsLCB0aG91Z2guDQo+IA0KDQpNYXliZSB3ZSBjbG91ZCByZWNvcmQgZXhf
ZmxhZ3MgdG9vLg0KDQpSZWdhcmRzLA0KLSBDaGVuDQo=

