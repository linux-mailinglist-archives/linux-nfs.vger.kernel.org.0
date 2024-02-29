Return-Path: <linux-nfs+bounces-2124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4386CBD0
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 15:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694D31C20C06
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223377D3F9;
	Thu, 29 Feb 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eaqsPpvZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAD013342A
	for <linux-nfs@vger.kernel.org>; Thu, 29 Feb 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217777; cv=fail; b=dFRmIKSfeswgjltDBiovnNmZEBtDbq7tgdI8ZcmKSxs7hyecrKUoqBArvbVCtr9+GuX1RTtzPA4Lnmjf3uO8hbEvT9Fn22J+hsMopMzp4dwsYi562mMrmF1ewHKLqHojkRA05nSyBV4SwVWqvSOTwCeGfDomvO7E7GRXKpzS03U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217777; c=relaxed/simple;
	bh=qCDdDxSOBMRloF9rFwyZfnF3l8rDhA1B5j2Kn04j+3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GA9rz6FTvwUTHpWk1JdyBZcYnt85dzxUspCym2xLp9uTUTjvUAE10xAyQKu0i87KOEEdwyPP2O/xRKDEblWdpOm9KMFaTsTb7rT2f0wPvnh/mdRc5qZBOqyHejovPb7PjgS/Co1G0aiGV4fvUGuYBt8jO6Zgc3oM6yoPWvPHW5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eaqsPpvZ; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1709217774; x=1740753774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qCDdDxSOBMRloF9rFwyZfnF3l8rDhA1B5j2Kn04j+3g=;
  b=eaqsPpvZ4haAUYENzvmwcGyqnjt2ngXLt5NTZ0sd5PIwNdp77rmSxyZS
   DlYrXQbbO03rk4gNhqyswlTSlZCJZkCFZ1zHCQ/lojZp7EX/Ck/xRCCqB
   2KzTk3DmJUrXZ4BbRw4Xv7N3TkgmrF+qs9yxK1/KEx505q6dZeIK2zkmT
   XhBYSDzm+cSEA8aFsWKEV5W3rWo9u57sKeGLjUWxM0O606isPQBG6lSUZ
   sZ9HwKIzXgEOMrfd+YKh25gC7Lp3ednxSksL2ox9xW6FcLWG8zTk3EGnB
   PYXKExpkjlj/IvQcBp2ImhI+9Ir9erUbEPdQ8W7ET8zaM7m1wPgrrDIRd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="112575596"
X-IronPort-AV: E=Sophos;i="6.06,194,1705330800"; 
   d="scan'208";a="112575596"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 23:41:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMWwsm6vSXpZ9GsxcV2W5WYPuFii/4dpghcDOkU6GfDuh1+T5QwnmNL0Byeq8ZDql7dIC5jUwZLu8h2bxpQ/7PsANJKdTloJcwtPv0yIJIF3Prj9hYWXtkhuG9hbQfvaO0yMgc89Po+r0W7TbeKMAmWEyzKWaIpvCdvDH/XqQ2KKd6pNNHJcD8pSx/jOQjnW2U7HpS3eyOpxdEsD942WX31EFOqqEUh48slwdI6ugx+jB/6yuY91xvecQ78pVNP3M6hRsKx0EYDLNzb5kOcvVz5ww3WJQK+n7KYOTA8oZ74EBa5OHugxuKeDbarbaX7Y1vl5vMSLIICJxxJZ5e3rVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCDdDxSOBMRloF9rFwyZfnF3l8rDhA1B5j2Kn04j+3g=;
 b=ekqpoLfLg9wmY+pTvZlBXUZUhoyb99y1+fPlLZqEuzyzxA+JX734Z2EkouubF0pcXVOunkWXJCqmKdcbqXJC0EBW9O8hPaKxmTqXi1xtoWwVReOvWDtFUiCiHQRdoRrLtjoByZx4/INlYxCj2BZyW5Jnga/XlyyTfoVhBo/qWsnjq02HlQtMxph55mvSCobTGzYHEruyE+hPJaES/EvmvZt6+pBgZNAqgYTrAgStEg5V3zDl21lobemg+bip/u2s5WVY77b24vrmTS9QcI3akcTd2OUJN9xx+38eg85HqNWc752abA8zdgmoU6aXVIVKvQ4G8k3YVN2yHeitPodnkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by OS3PR01MB9483.jpnprd01.prod.outlook.com (2603:1096:604:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 14:41:37 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::8616:7a44:8a7b:6be4]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::8616:7a44:8a7b:6be4%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 14:41:37 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trondmy@hammerspace.com>, "anna@kernel.org"
	<anna@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] nfs: fix regression in handling of namlen= option in
 NFSv4
Thread-Topic: [PATCH] nfs: fix regression in handling of namlen= option in
 NFSv4
Thread-Index: AQHaZNk6yvt0rOgZNkieWEW69rtCTbEgSWmAgAEnr4A=
Date: Thu, 29 Feb 2024 14:41:37 +0000
Message-ID:
 <TYWPR01MB12085CCDB7878DDAD34D0ACC5E65F2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240221151613.555-1-chenhx.fnst@fujitsu.com>
 <6f42ef00497c15e1ceb2267e69bdeec239910c64.camel@hammerspace.com>
In-Reply-To: <6f42ef00497c15e1ceb2267e69bdeec239910c64.camel@hammerspace.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MWE4MTkyYmMtMjE5MS00NDQzLTljNmUtYWU4NmUzYWVl?=
 =?utf-8?B?YWUxO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTAyLTI5VDA3OjUxOjU1WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|OS3PR01MB9483:EE_
x-ms-office365-filtering-correlation-id: de879953-2ca4-434c-9718-08dc393488d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lNQsfdh4Ph9NWKpNmORCF+MVz4vr3vlimuuFVR9YWq9QxE6aTtv/Ti6uAuq+VSGVnfhcXAvlJH8ElNrCfvd6hDncM2x+U7PFVrxTUdjMPDjuyQkAu6UI5OoFaEA32TlGVJ7hvyi1zI5SigDSwdpgx4P68Rno/qBOZmftMj6bOtuy4x9fb6JV/U7FZ3MlnmfbYDWVGLm7f7anQ/u+uiJdFncOAQKcLw9xryTUH1aTCUPCH47YY6LBJfJ68pZnHpAAXA7SmOgtMHWzgxFu40oWKjFrOLB4cLLQDO2uBAQGOHWp4zcLGCfJC6fB1faVDM+NsFRqOME1df6/mUXC8Vdh+BkIzFSb1UuF9cHFPNwH+RY1Op1Hmry9ku2aT4GfZa2dUQxy4ED0f1ZZi0Lo1/cAz/w1bLb44mjHOdYURrmQ5L+wylAXA2QjiySZ05cUXDVVH9zuesJQQ12Ka9XPhjhuI9qecACT7MZ6oRxNsh21DmiOhsvjLdZHOExgbRnofhBR3GEUmEihjQVkFH89mQ+8+nmcTyWZaPsYrlizl8J5XWpyEOy4ghS5e9XQzCVGblCyBM/5wjDbfgFolSTh1ArzcW+LcsGGyVXCkwxB8yOofPA7m8BnKvUgJ6+KsNSCfK7OpQfuENmkfqQZ69wlxESR1BRhsQEYhjhFY51As6PL3XXyqGi4/z7fycnixvJE9Jn06L62Gd6qeGJQZTywXegccSqaJIJUK12pNafEl62ZiSS/RJX9eEdyxJF0E7aoYkMh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnpZbWdMMCtZSFljTVdkc0FJalBCWmM1bTVCRHMrWHlVSHpwU00rWnJCUW9G?=
 =?utf-8?B?MlBLMk8ybEt3RDZjdjJ6UHFzUlZwMFQya0xEMWJpV1RreVdhWXY1Vk1GV0VQ?=
 =?utf-8?B?OUVUUEJPdktrdUJWb3oyVU5MalduMC9NNEZCVllHQ0FrcjNWM0lqMHdLOTlz?=
 =?utf-8?B?ZWppR3A4MjBLeElwVFJhczgrOStmeTcxTThaZW0rK1QvSUg2TC9xR3VkNGxU?=
 =?utf-8?B?MjZLSW5iYkNURC9obWFNdTZqNHd5eGZzWmlzRUVUSlU1TWZkQWgyaTJncmVP?=
 =?utf-8?B?aXpDamVGOGRRMCttMlo4N29MOVYrbGo2elNlNDdhdUlQVmhKZnNRSEdJWmc1?=
 =?utf-8?B?TnF5bDh4ZjNmUjlaeHEwWm9iNDNxNFU2QnRLb0ZBaEEyTDlZMExEYTlLRHBO?=
 =?utf-8?B?c0g5VE9WUHJkaFFFMy9tMnUyTGxXWEV6OE1IL0s4ZXltSVZkcGxDUEhDWk1K?=
 =?utf-8?B?Y2pDSWVUcW45dy85TFM1VjJ3T25qWkpUcytCN3FQKzVBb3hXN2hvMCtoR1pX?=
 =?utf-8?B?ekU3Ky9lRGJBZVYydXA0Z3dMSkV5YVRqWFdtZWpRczBpcE5PdUhPM3YyYWJn?=
 =?utf-8?B?bEt3QVVpUWo2NnRtSlRjOG5UQ2tocEMwbXMrQjJoU09wUVlhVnlTZnNRR3Vj?=
 =?utf-8?B?MnVCVkkvby9Sak5QRzc1MWFFZm1WQmJlckY0VHpKaDZtVkN1QTg2TGgxV1pQ?=
 =?utf-8?B?THNXRW5pOXFtT0NhQW9uRXhNcWxKMXB1cGNmVkErQnFnaUV0emE4TjFtT0Fj?=
 =?utf-8?B?aDF1VDIrdWkrVkVjM0R6WU5xR2E0UmN1MVJ6bUJnMlE0bE13S0ErcWxPbmVv?=
 =?utf-8?B?TGxjSlBXWHVPMHdpV0xkdW56Q2VRSndFemoxR216cjhDem5hT1ZNS0VQMEpT?=
 =?utf-8?B?c0xPYWZ6M1JJZUdjYjVyRWJNUjRvdUNnYkloM0lwWVIwMDNlY1NzMmpZYzZ6?=
 =?utf-8?B?eERYbFdBMGJML3hFSW9HdXkyVG1WdzZHWmNodnUrT0o3TVBsWWxaMFhqQ2p4?=
 =?utf-8?B?QWZBaWJhTmFlN0h3cENpdmhoZ3p5WXlXa1pzaVAzVUNlQ09nb2hYQzlscnNB?=
 =?utf-8?B?d0ZWZlh1elJHYU1tNmdOa3FuM2hndmdJbElHSnVIT2ZIaCs4c2w5cU1mUTZh?=
 =?utf-8?B?c0kxSGpKV3BEVTlKZVE3Y25mdlMzeTFVT0ZnTS91MTN6SkMrcTM4clJjb2Z4?=
 =?utf-8?B?ZGNNRS9RTkJ3aDVPWXlXNjVUQVkwbVhPNU04Z0xZbDVlaTc5K3VFUE1QczJE?=
 =?utf-8?B?aFZBdjVXZkNWSU83TkxuT3hXVDlzL2RyUHN4OVFzWlZjc0pnTTVCWlZLNEwz?=
 =?utf-8?B?QWp5b3JQRStIalFuaG9QZ0dkRjV4YnB5cTB6M1RRczIxV1phdUxuK1B4MzBk?=
 =?utf-8?B?SGtaQU0zUEFKOXdiZDJzOW8reVlGcmx3b0xqQy84SGR4eHFLOVJ0Y3pwYnhQ?=
 =?utf-8?B?TFpoL1pvYUNuSDQzc054T2JzNEJscjZ6QzRyUU8xdGltejdobXNlSGVPL282?=
 =?utf-8?B?UXI4UUJrV2dmcURaNWRpOTZEY1UxOHJRajRkalNremhwSmp0YmxaN2xuckRp?=
 =?utf-8?B?aW5hTkFsenEzRnpITDhIQU9SZzR2bjkvS04wa3dkaklCU3JETzUrMG9vckYw?=
 =?utf-8?B?cXNTNGYva1hrN3NyY0dZYXFjZDNFZXA4SFIyTC9MOFhVd0E0a201ejZGcGpz?=
 =?utf-8?B?blpwZmZ2cnh3UmwyWEUrbzE2bzZQa0hiczJubWs2aWlTUW9weDNPZys5UW84?=
 =?utf-8?B?NEFQQmF4aHNMSFk1MnJQSHFjbHkvZjZveFc1NGZWSEFyak5XRHVaSUZhVzlK?=
 =?utf-8?B?TitEbzR3ZGFzVkhMSkNVb1FFVFdheUU4MExyVU04VGdBMTBxRFBoY1JUcXdZ?=
 =?utf-8?B?MGtGZTJBbTdvaHRQbFk5c1RZZk1HVGcwYzVzTFRSTytYQ0k5NVdLZ0tac0xC?=
 =?utf-8?B?T05icUVFNUkwelRUc3UvcDcrYmpUcmNDZW5PNXZWYys0QUV2ODJNNjc2VGJz?=
 =?utf-8?B?ZGpGdWt0dVVjTDBFaDc3ZmJCOTdtalcrMmlnckt3MDB4c0JhS3dlaCt0amVn?=
 =?utf-8?B?YzgvYlN3enp0VWZFQnJFTUNYR1ZUSldVNGpURytDeG43U3Z1YjdLT0J1d3Bv?=
 =?utf-8?Q?oMWHOJQ2uQYUnLyHY/Q/0QRQA?=
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
	pBH21pKtCPQob+LDP8ShtaUj7B1Izj3MTLTIsOY43BESCA5HWCO5xJtdRawzHi9r5h3qQYlwUI2HKTw7ZKEgRQhdEgG6nMFM+UvM0PXK7cQPupzrg/n6z1FhD55raqPMhknYNVsqD51SoyDInPr8bheLDVU2aA34l9mN0c5ZImlB6zG1zsdyXE2PuCLqXlONlFDyR8l4QHdeqvUVTt2SIEKAd/Fg00Dvl+ZDSrtrcbQzenA+Grr6wdjNGpxk/+w9L+R6kCA/ZAsttMufHyzNle2YaYLjDZZc1HZgIvmZ8mTWh/yppIAcTx+DkH4FxuPGc4WuZVu5fXK4+Ip5ZjpiroIAwY+v1RZO6zoAdUNQTisHJaebu6A0/LC32Ca4gHkgch/iQHHQeT/dwG5XuFfhofsm4VfCE0eF+07eWcIXnON+ctU+fEgh+h3kx3n+lEVv7IJ3vkRneyfdK5fYEh+tvB/W+SqmckZC4GgnVV5iKvJVmkIGYnZoi1OBoURrrF0Flm6ybOsKDKqBcs/79gLBN3shGx/yzQVQLyFBzfedEuXxV4APEoLxugo8dFrculhFxga7f1H/08mc8Sd67c5u2dX6eapxSzE1RBkgj5vAfQVYC8j7Zn6nl755t2a1U0OW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de879953-2ca4-434c-9718-08dc393488d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 14:41:37.6599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuVrGTsvxALvGajCAZ3P3ubz8R5BmCJ8544JNTLX/kN8ZSUwh1a6V8AQmfUj43+bayIKAOoRebQtazzAkNKY6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9483

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFRyb25kIE15a2xlYnVz
dCA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyNOW5tDLmnIgy
OeaXpSA1OjAzDQo+IOaUtuS7tuS6ujogYW5uYUBrZXJuZWwub3JnOyANCj4g5oqE6YCBOiBsaW51
eC1uZnNAdmdlci5rZXJuZWwub3JnOyBqbGF5dG9uQGtlcm5lbC5vcmcNCj4g5Li76aKYOiBSZTog
W1BBVENIXSBuZnM6IGZpeCByZWdyZXNzaW9uIGluIGhhbmRsaW5nIG9mIG5hbWxlbj0gb3B0aW9u
IGluIE5GU3Y0DQo+IA0KPiBPbiBXZWQsIDIwMjQtMDItMjEgYXQgMjM6MTYgKzA4MDAsIENoZW4g
SGFueGlhbyB3cm90ZToNCj4gPiBTZXR0aW5nIHRoZSBtYXhpbXVtIGxlbmd0aCBvZiBhIHBhdGhu
YW1lIGNvbXBvbmVudA0KPiA+IHZpYSB0aGUgbmFtbGVuPSBtb3VudCBvcHRpb24gaXMgY3VycmVu
dGx5IGJyb2tlbiBpbiBORlN2NC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggd2lsbCBmaXggdGhpcyBp
c3N1ZS4NCj4gDQo+IFdoeSBkbyB3ZSBuZWVkIHRoaXM/IEluIE5GU3YzIGFuZCBORlN2NCwgdGhl
IHNlcnZlciB3aWxsIGNvbW11bmljYXRlDQo+IHRoZSBjb3JyZWN0IHZhbHVlIHRocm91Z2ggdGhl
IHByb3RvY29sLg0KPiANCg0KSW4gTkZTdjMsIHdlIGNvdWxkIHNldCBuYW1sZW4gcGFyYW1ldGVy
czoNCiNtb3VudCAtdCBuZnMgLW8gdmVycz0zLG5hbWxlbj0xMDAgMTkyLjE2OC4xMjIuMjEwOi9u
ZnNyb290IC9tbnQNCg0KQW5kIG5mc19zZXJ2ZXIubmFtZWxlbiBpcyBzZXQgdG8gdGhlIHZhbHVl
cyBmcm9tIGNvbW1hbmQgbGluZS4NCiMgbW91bnQNCi4uLg0KMTkyLjE2OC4xMjIuMjEwOi9uZnNy
b290IG9uIC9tbnQgdHlwZSBuZnMgKHJ3LHJlbGF0aW1lLHZlcnM9Myxyc2l6ZT0yNjIxNDQsd3Np
emU9MjYyMTQ0LG5hbWxlbj0xMDAsaGFyZCxwcm90bz10Y3AsdGltZW89NjAwLHJldHJhbnM9Mixz
ZWM9c3lzLG1vdW50YWRkcj0xOTIuMTY4LjEyMi4yMTAsbW91bnR2ZXJzPTMsbW91bnRwb3J0PTIw
MDQ4LG1vdW50cHJvdG89dWRwLGxvY2FsX2xvY2s9bm9uZSxhZGRyPTE5Mi4xNjguMTIyLjIxMCkN
Cg0KQnV0IGZvciBORlN2NCwgbW91bnQgY21kIHdpdGggbmFtbGVuIGNvdWxkIHN1Y2Nlc3MsIGJ1
dCBubyBlZmZlY3Q6DQoNCiMgbW91bnQgLXQgbmZzNCAtbyB2ZXJzPTQuMixuYW1sZW49MTAwIDE5
Mi4xNjguMTIyLjIxMDovbmZzcm9vdCAvbW50Lw0KDQojIG1vdW50DQouLi4NCjE5Mi4xNjguMTIy
LjIxMDovbmZzcm9vdCBvbiAvbW50IHR5cGUgbmZzNCAocncscmVsYXRpbWUsdmVycz00LjIscnNp
emU9MjYyMTQ0LHdzaXplPTI2MjE0NCxuYW1sZW49MjU1LGhhcmQscHJvdG89dGNwLHRpbWVvPTYw
MCxyZXRyYW5zPTIsc2VjPXN5cyxjbGllbnRhZGRyPTE5Mi4xNjguMTIyLjIwOCxsb2NhbF9sb2Nr
PW5vbmUsYWRkcj0xOTIuMTY4LjEyMi4yMTApDQoNCkkgaGF2ZSBzb21lIHF1ZXN0aW9uczoNCjEp
IEFzIHdlIGNhbiBzZXQgbmFtbGVuIGluIE5GU3YzLCBkb2VzIE5GUyBjbGllbnQgdXNlIHRoaXMg
cGFyYW1ldGVyIHRvIGxpbWl0IHNvbWV0aGluZz8NCjIpIElmIDEpIHN0YW5kcywgZG8gd2UgbmVl
ZCB0aGlzIGZvciBORlN2NCwgb3IgcmVqZWN0IG5hbWxlbiBpbiBhIHZlcnM9NCBtb3VudD8NCg0K
UmVnYXJkcywNCi0gQ2hlbg0K

