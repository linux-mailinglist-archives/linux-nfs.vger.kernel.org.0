Return-Path: <linux-nfs+bounces-2216-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B116872DE6
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Mar 2024 05:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B071F21CAE
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Mar 2024 04:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3914F68;
	Wed,  6 Mar 2024 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gN7NCgLL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49921EAC0
	for <linux-nfs@vger.kernel.org>; Wed,  6 Mar 2024 04:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698152; cv=fail; b=iYkUi0dNE5/ja8FohsWTwo8/x/hnKJW+RHwZkavsBW3zXDCCmCNZND4BaTQWCrtOUhxzIK3scsMxTC5bBv1n+ySSRK01klCOqlhuYQFYvUlgiJDGDQWtRKgqGTRqTlbSOQwEAyEoMkAas96HTwDdUtKV9hcGidq39d9esoLpocs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698152; c=relaxed/simple;
	bh=d7NcLaCqDnYC00eWqJvQzw53AtRoRqLwa1/RKXt1abg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a8UXfvEHW7hTd5rT/UElmxeV/wjiueR/Svkp5jomOJLXP0NoP23w2LaUDp3367WxtTTa6b8rH/F1NToUyGQGBDpquTfUYybA84EcBq1BU992CFSNnU2w+imAb5VNSj4EQZ7eWWK6Uigr/fVpEPPPkDo8pRbBInVE1SFCYDftcfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gN7NCgLL; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1709698149; x=1741234149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d7NcLaCqDnYC00eWqJvQzw53AtRoRqLwa1/RKXt1abg=;
  b=gN7NCgLLzeAcfCSnols6GdqyyLLzNF08wc5V4U9WtQGPMQDRVGfoD90g
   tfl1eOD709TDRM2N+r777lwt1J7vEhSRzllhbmBzWDfFResmf18q2ZEUv
   9FR3ZdFYmFCZiGRLOXSPzshTQnn2xuZduwY2wJLvkHTOng1QjjctlWBXr
   axojGo4Zg4yw38qbtgPwsOdfLmoYMmXSbViznB2Qpa+h04BNQhEJm+2u7
   ECu+tzFmnPstafvMN1uHh0T07YBrA/XveKNpT0p5xanHk9qiPiYmjY0kw
   QwxViSEk2E/b9px+lJI6R9fICAv6H36AKfSyppy9vkHx8sB8enHamGfQI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="24283824"
X-IronPort-AV: E=Sophos;i="6.06,207,1705330800"; 
   d="scan'208";a="24283824"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 13:07:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLPDmjb/dGOIKZesWJo57VPbRgDDXIfszQEPOnPkdyQS1enRSTI/3+96OFMdMajBt37cUykamjuWw2xy/cCnMuDBahSwk5+gsiMi3PTkQURN+YcCuE0XFBTO5EHXMhXVQaKgBaA+8WMBug3A1J2UnufH1+JHWJjNbhAr40TOh8PiGxEKRewobGjtt19iaAeyLiO0ByNpo0AqXA8akK/1BKqwNESEvDKZY6MfZQ9hF8BLP9RkiuSsXWmbAFoXDN6LWUtyewK9G+WzW6NCcFee6q1Mq/8SvOwImvxxVpxI2O0dq1Xb8SAZLZsDn7hLoQ8i1mGcoJDMzaEcjK4eWX+75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7NcLaCqDnYC00eWqJvQzw53AtRoRqLwa1/RKXt1abg=;
 b=SAELcgtPS1T9n3436zNO7odfURieLKVmOwUi6mEfhd9nlj9CUnx6pkGqr8XiNb1vupDWbeexRsMmjO616j9xcBP4XrcwiiMwFI2Hh6vB8mtzXM9zPQizSPCWxNDBLgS1dJVt9Aweaq5F3RW7LV+s65UWr7xDhENXLNRFAEmEhN2UUi+gHML5o2zuZ0BTrsaDdhFKV3ppBckwpJVUGsuaet+FThfJV4D/8hPqK8wg9JorruB/L4tHxkfqctby3LSApAu9a2s4+jFWip/ZWEGZ7r2BZyuvbkV9/opquh2xxoxAdOup8bjl8vYSDuXzsmBmE0Cxwf190CMrZveMGIIExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYCPR01MB10682.jpnprd01.prod.outlook.com (2603:1096:400:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Wed, 6 Mar
 2024 04:07:47 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 04:07:47 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trondmy@hammerspace.com>, "anna@kernel.org"
	<anna@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] NFS: add a tracepoint for uniquifier of fscache
Thread-Topic: [PATCH] NFS: add a tracepoint for uniquifier of fscache
Thread-Index: AQHabq89CSzbssDvqU+K7fiobaDIUrEpRi2AgADUJGA=
Date: Wed, 6 Mar 2024 04:07:47 +0000
Message-ID:
 <TYWPR01MB12085CBD5300D1FA74BC05C58E6212@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240305034122.172-1-chenhx.fnst@fujitsu.com>
 <4fecefc561df655aefeb68cf716cb3eb0fd2f011.camel@hammerspace.com>
In-Reply-To: <4fecefc561df655aefeb68cf716cb3eb0fd2f011.camel@hammerspace.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZTY2NzgzNzgtYzdmOS00NDY0LTk1YzctNjIyZTQyMjg0?=
 =?utf-8?B?OWY2O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTAzLTA2VDAzOjExOjI3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYCPR01MB10682:EE_
x-ms-office365-filtering-correlation-id: 8ed2979a-20ee-412f-93f7-08dc3d92fb84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 f6KoYTL0Z7CGUF/XMxGYdNBBP6eqZznvEDgdahTDmBm/orkT69o+bqWtwXO04TTAJbw8+CwGpsBj9oC/rWeMJG9uWH4RjbHxn3V6WAGeCYrL63n04Lp8LN+h2xrCmltFh7Aondv5kB7ehABT9yT39cPiqLorO2cVmHzECZWSdzvnva/0v6x4MgDD5fyIVZ/6vSvU3wwwMM1DriIjyhZQrtmB4v9jPR2nOXbbG0gH7Uc96IO0WfYY9ldKA92nhCahEOQ1Wm/mILb3nutremvTzajEwW18OA+8kIPeoZFlpRAqRyjVNV1q98q9xVg0oNrdWrHwVr6mStutzOU5+zlduZXtcOqvQMYnVlFB+AfYXCe9fJmYwo2uWLux34VcNsHidKCUpTzEmAn0wEMc+KM6HDEvaIJoetJGrCdQmaLoubyQIal1J3a49DinvMd7vF/Wub62lZFI7hg40K2hw1Yne04SgXnkjJ0u18f0lT1Mc/vd6CjQVbGD3LCCOLsYUz/VdS8DM/kWe5UvDDTjmJoz6JyBhGNEdrVF/qepvlXOmXDm1bI0Vzf4GJ+Wlwh9vDY325zuNIFrWTIYgbk1akXFbIJuWmz52bnATJpt7QsdhNDJ2I1tgTFInf4eM5bQfiF1SDoXZF4PiF6xrN2ngCgsCWNuejqEJC9qQEi8m3kw+wesCA/GoByIYWbhJjEbUYOYcrJQvmhN8tnRoQjxEWzRbdb29DdtY7BQOPqURsMBpOj8fcaMS3AWoXOKg8KQ9m4+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WU1YOTkvejhCOVRYM3JNalZZWklHVWkrTnN2azU5ZElXKzJLVWRxcStZY1kw?=
 =?utf-8?B?KzFzdURQaVB2cWRsQUJ1UTJVRXF4M1ZLeFV3M2dhZ0ZhMFJpZGZnZzZ4eUpM?=
 =?utf-8?B?YzBCdVVuWkpaTnVIN3NTL0Q3dkJTYXlrSzdnT1dxbW5SRFhCNXM4K2QrSHdh?=
 =?utf-8?B?bUVia1JQYmg3eVYvajFVbU5UMzFwQ1o5bjdYMzdzMjVHVHZ4N2tCR29vMS9q?=
 =?utf-8?B?dTlRd0lWQzduOTlUeUpnelV3cldsdWlza2NoS2szNHBuOVFrNEJrbjNmRGxo?=
 =?utf-8?B?MEpCVXpFdUlHdEs3RTVKTXo4L2FXandIbDhSVHJXTzJDdlB1dG9wSU9GVFUy?=
 =?utf-8?B?YnA4NUJVOTBkMEI0QzhZNW5yejlYTW03SlJGNlVCeW10SlpUV1pZbEd6MTBO?=
 =?utf-8?B?eldEbHM3RHU3LzBxN0JNS0VNTWpPYlk4alhKbkdrOTF5eWJkcGxWTEUzeFdZ?=
 =?utf-8?B?dWxsL3BTbEhwdENVWnVYeng1R3NIZXBFSkZCSUFJbTFZeGRvRnUvWloycTFn?=
 =?utf-8?B?MEdMaElRN1VJY2Q0WFJiZkN2UmlVcnZ5bHF5Vm5qdXV6S1l4cVhPWjJoKzlX?=
 =?utf-8?B?RmQxMVdPVmFTcGhyM2JuR0VmYjlNM1MwRWYzbHR0VlluY3YxY2w2TWxEM0dI?=
 =?utf-8?B?VklqaG9SZVNBRktuS2FyazM0eWlmU0gvYzB3S3Yva3E1M0pxSGR4QXVncURQ?=
 =?utf-8?B?QjRCaG5FSi9LNmZSVkp0Q2RIbnEyNkV6M2x0L2hZWHEydlJXcEZJYWR1US9G?=
 =?utf-8?B?eU55aGdIWDhSb3Q1WlN2clE0ZEZQZGRHdU9UNmxKZkk4R0J3bndBN09KY0Ew?=
 =?utf-8?B?RUd3Mnd0NkNWaDN1WW93MnBTNTJHcjJkaUQ0RXJsLzN3ZHlpWTJQaVZKRm13?=
 =?utf-8?B?aG5GSU1lSVRVdDllYTNTa2szK1VKbTgzM0NpOVJ5ckdsTTZlSytzQ1NuYzlZ?=
 =?utf-8?B?UDluZGRlODcyOXlhUy84MnU1dHEza3crUkZrS0JmMmwrSjRPbUVWeEMzYWZ0?=
 =?utf-8?B?TXNQc3ozblViYVZMMExBVUJKd1I5WDUzSTREZ2t3WWJEMlNmZjBlU2pUclBK?=
 =?utf-8?B?TU9zTHF5K2dnOVBseEtoRHRkWXNGRnV5ZmxjblR5Wmo3ZkNkUGJnRGRoRXR0?=
 =?utf-8?B?eE5PbldmQWxhSVJKRWFWVWJwZjh1UFZraEErSFpiSDhWWjlYM3htaHJvQk5t?=
 =?utf-8?B?RGhDcWtoWTNBc0lncFpad21McEFrVXpMQWlRNVp4ODZaMXo3dW1ZaWNCeGpT?=
 =?utf-8?B?NXhxNWR5cllRRHdTN1lmUmt4ME5mSEtxOUFyTWd6TU1aWi9sZzZnYVdab3Z5?=
 =?utf-8?B?MTVqZEU5Rks3S0s0RVR5Y1JqZDVNRVNFQ3l0ZjBnWkRaRlVvbEpWTFhZeU5C?=
 =?utf-8?B?SDBveDNvRndMbXl4aEJYdHdzS2xhTUlQaWdhTldFUGZrKzlJVTFXaE9kb21z?=
 =?utf-8?B?VitacDA0ZFJqMEZ5bDRCWkhDeU9HWXRxLzZJY0dvbFovV3FDcFRtOXRoYkgz?=
 =?utf-8?B?NHV1VkloV2pPT1lrMmVsR3ZmRW0rTGx1cFBscE5RRmluUk1tSGxGU0FiMGVy?=
 =?utf-8?B?YTVva0V2eFpsMFNoZkV3WFJqRHhuS0hGKzlHSW5xWjRUcFNUa3ZraDltWVRv?=
 =?utf-8?B?Smd1aUREcFRTR0dUNk42WWwySGZCSmJJdFByQVc2VksxWDJmaHhOSTF2MEJy?=
 =?utf-8?B?TGVWcXRSR1FJUm9HWEpaQXd2NEFOSTNkNUR5aVB5OXQ2emRPU0E1bGNGY3VU?=
 =?utf-8?B?bGxVd2JheGVDNlhSdFFJRmh4REs1RjdrNUlZdGVpaG9QMEdaMHhIWjlCSjNE?=
 =?utf-8?B?ZFBpL1VyQk1ja1Yva0R6RDZzZitpMGQwQVozelBsZ2t6UnVRUHRYdTRlU242?=
 =?utf-8?B?N3NTTFA4SHphNjUwdy9hbmk0aHZrTCtvd1BNOXRJdGdtODY3M1ZFRUxIYWYv?=
 =?utf-8?B?TythbTUyc2xabVZhSEJKeTlkdHlDL3ZUbkVsQkJTSzV4ZkZmc2pCclZzdTRa?=
 =?utf-8?B?L1lJYVBVNVBNS0s2Qm0wb3FUYXNDT05NN2pIa1pKUHczRUk0QXZwRzZkY1No?=
 =?utf-8?B?eC9MWnk3VGhJMTJKZmVzS2xjUDhSbWtVVW8yUnJmQWlQZUZoaVRneHN1ZGhm?=
 =?utf-8?Q?/aiRaLkEWkgXjHLkp71gfIDJt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2+UDZwu863A7/adNIh8d9uw/3dHc7Z2mqcTNU/3u9o+TTdW/jnYQ3nGmy8s2JPApfv/NPa7ofQ4nCH9+C3u/0HIsSfyjt8a9FudQB1OoapoLHXxxdSNZWYlGPwaafOnjpU2CMQhTVdKRHWq2XxCEW5OO3IatM8N6C5EN0rD2oAA9FVYwe7eVn9kz63hMQeEzURpbLfSFUI0E1wZnjeDYHUu5nJxJWCeb9bpUCH6bcaiKBh0qy/4yFpb/dpgiYv5fps+/fgcP3HBhWSLFMyV04wnauRNSf4vsbELCZq+JjxF2OoHLKb3FRPSjo7eCzgkky7nYdgBf2Q5PckwNt1L4e8eWhFVHIuUnvyO0quEv+i9VMezuaNLIvqp1MtllxVTJH+mqxGqQhdz0gfQhIZ/2+qwee+ZKFLCQIhKBQTfwu2WYWIAut3scBA3ue80V5tXOM/nswaI5LgVtj+RgrF+puqymU+VSwm6potpcMrSODUKAv/pdycKor+hWWyab8NVIvtc4fuQ1fRkM50ZcuQ3SopHfuZpxGcxRQGSzayDIuxC0pldS8fCwiYXQBya3or7aAiYyCc7ovfaNsEagylSHx/JhmmcU0yYAjSB5amQu0n/LbLW3H5Nl/3N/29uzZPf6
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed2979a-20ee-412f-93f7-08dc3d92fb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 04:07:47.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KoEzPRXK+QYDw/QoLd1Nc1zU/aMmxDBz/o1aJR50tUlOknQvhDgtF4kaziFWhTMNDpn0CZl61GA22BwpT3OtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10682

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFRyb25kIE15a2xlYnVz
dCA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyNOW5tDPmnIg1
5pelIDIzOjI4DQo+IOaUtuS7tuS6ujogYW5uYUBrZXJuZWwub3JnOyANCj4g5oqE6YCBOiBsaW51
eC1uZnNAdmdlci5rZXJuZWwub3JnOyBqbGF5dG9uQGtlcm5lbC5vcmcNCj4g5Li76aKYOiBSZTog
W1BBVENIXSBORlM6IGFkZCBhIHRyYWNlcG9pbnQgZm9yIHVuaXF1aWZpZXIgb2YgZnNjYWNoZQ0K
PiANCj4gT24gVHVlLCAyMDI0LTAzLTA1IGF0IDExOjQxICswODAwLCBDaGVuIEhhbnhpYW8gd3Jv
dGU6DQo+ID4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBjaGVuaHguZm5zdEBmdWpp
dHN1LmNvbS4gTGVhcm4gd2h5DQo+ID4gdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2Eu
bXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uwqBdDQo+ID4NCj4gPiBBZGQgYSB0cmFj
ZXBvaW50IHRvIHRoZSBtb3VudCBmc2M9eHh4IG9wdGlvbg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQ2hlbiBIYW54aWFvIDxjaGVuaHguZm5zdEBmdWppdHN1LmNvbT4NCj4gPiAtLS0NCj4gPiDC
oGZzL25mcy9mc19jb250ZXh0LmMgfCAzICsrKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9mc19jb250ZXh0LmMgYi9m
cy9uZnMvZnNfY29udGV4dC5jDQo+ID4gaW5kZXggODUzZThkNjA5YmIzLi5mZDg4MTMyMjJjZDIg
MTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzL2ZzX2NvbnRleHQuYw0KPiA+ICsrKyBiL2ZzL25mcy9m
c19jb250ZXh0LmMNCj4gPiBAQCAtNjUyLDYgKzY1Miw5IEBAIHN0YXRpYyBpbnQgbmZzX2ZzX2Nv
bnRleHRfcGFyc2VfcGFyYW0oc3RydWN0DQo+ID4gZnNfY29udGV4dCAqZmMsDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0eC0+ZnNjYWNoZV91bmlxID0gTlVMTDsNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+ID4gwqDCoMKgwqDCoMKgwqAg
Y2FzZSBPcHRfZnNjYWNoZToNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
IXBhcmFtLT5zdHJpbmcpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdvdG8gb3V0X2ludmFsaWRfdmFsdWU7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdHJhY2VfbmZzX21vdW50X2Fzc2lnbihwYXJhbS0+a2V5LCBwYXJhbS0+c3Ry
aW5nKTsNCj4gDQo+IFRoZSBkZXNjcmlwdGlvbiBkb2VzIG5vdCBtYXRjaCB0aGUgY29udGVudHMg
b2YgdGhlIHBhdGNoLiBXaHkgd291bGQgd2UNCj4gbmVlZCB0aGF0IGV4dHJhIGNoZWNrIG9uIHRv
cCBvZiB0aGUgb25lcyBtYWRlIGJ5IGZzX3BhcmFtX2lzX3N0cmluZygpPw0KPiANCg0KSSB0YWtl
IDU1NTk0MDVkZjY1MiAoIm5mczogZml4IHBvc3NpYmxlIG51bGwtcHRyLWRlcmVmIHdoZW4gcGFy
c2luZyBwYXJhbSIpIGZvciByZWZlcmVuY2UuDQpNYXliZSBJIG1pc3VuZGVyc3RhbmQgdGhhdCBm
aXguDQpJJ2xsIHBvc3QgYSB2MiB3aXRob3V0IHRoZSBudWxsIGNoZWNrLCBhbmQgd2l0aCBhIHBy
b3BlciBkZXNjcmlwdGlvbiBhYm91dCBjb21taXQgbWVzc2FnZS4NCg0KUmVnYXJkcywNCi0gQ2hl
bg0K

