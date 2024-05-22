Return-Path: <linux-nfs+bounces-3343-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56758CC7EE
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 23:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065401C20FD5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 21:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EBA146D46;
	Wed, 22 May 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="BdiUZO26"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D71148316
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411856; cv=fail; b=Gzp00swRDCv+rWI6d0kBgpVzs783gD2yGlvoYHI+UAVltoRJjLM+hXmGBUo26u0Fgnm+2nfgBozPKf7DQ2ou6WNqJk4I7vqrgHeJ6P50PhMsMbtW6g80t3/ZJMdr36hy7q4D2lYfmXppCmD9qEbCHzmthVn9uuUSq5lzkwLuMP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411856; c=relaxed/simple;
	bh=j4gQJP1DMJbKcczEDNh60ULoY+TwOst4UnksrKNc+8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhXea9CTV0lG+btDZ4be3HeOvbYLmtrvKyLD5xhnZy55tUqd46AZuJMNQle1phxMTFIXkUtptLICRNlWQYXCprwWxEcUurwKE6z9QYNMbfvSFHNHoH0ljJQeuCFLZjNFpxgH9lgu12yR2+5oaxhQjWmMnBvOONFdey+dvdltAXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=BdiUZO26; arc=fail smtp.client-ip=40.107.223.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUVEzI+Id3cELCVis/2xozLrmxDtNp3PIou7OqStcaBG5zUTcaDF0+96uuiwkZ/drl16W/y/3nqSAqhtYLMl9YKI45D6VwBdZG3CUKUdthnVzcYhN1gb5wNyvQVNhmDcQNVENYy7+PLuFvHHXzZT2KNVN+QyIdF/R4DzKWCHyW6d/nKSEYpmwu+gFiVKn+WD7t4IV5bZDqWtnJJZo419IM3p4Yg6YY4HtwLzd2Wk7cSSNTdjpf6aY4v8Wui62ff5tpCD9T+roQK9NEAojHXTu8ql3ePOSjPE8qwSilfJUIkzSajuzUj/ZMhusgHFIehRZ1WuEHWCEVFrgrPBEgojXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4gQJP1DMJbKcczEDNh60ULoY+TwOst4UnksrKNc+8M=;
 b=aVdpr7Wf3Dnu4FkMNcjVA0m6WkWWkOxsQCtw0xf15H7rJUbafQ0tjTXrAiFLOmFV/wxIMQc7as7AfvMdwWwjewnUoIleR+mcThFubVIE8UvzBVJdesrqYhtxNGuZmxRqPojusbnI/oMaKEuvEKKpcl0dp8vANsmbkQEc2lectBXkdwWLdpxzlzzxADL/ZXqISci5h+kHiowC+WpFMs4+pK6Xov9niyC84NTNDTgV4kU600ao35N6r//NxEo/hG0CfUjgj/7xHFhhMjpwPnlRZ8tXc8TuRrUTOjjgA2jomDNaqp5INC2s7aeWW3bSE8az7OQadHSngDaafGQLY5FTXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4gQJP1DMJbKcczEDNh60ULoY+TwOst4UnksrKNc+8M=;
 b=BdiUZO26P7LvIkRb1V7Dj9cncdyab+i4+UG15cXxslImls7GJvzUjneYHftAlD7hXPXDjyyum3qdVgMc+jXIbwVGeIjYkjJipSOsS140HzxpJXu7v0SaNaQq0h7TzJilpc2zFQpgDcVhHjxOlXbXnp3RLDYo78l9rLaiQ6KizBA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB4956.namprd13.prod.outlook.com (2603:10b6:510:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 21:04:10 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 21:04:10 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "jlayton@kernel.org"
	<jlayton@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "dan.aloni@vastdata.com"
	<dan.aloni@vastdata.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Thread-Topic: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Thread-Index:
 AQHaq36jqWobVAzhLU+0cOtTOPPg4LGhrPIAgAAczACAAAIIAIAAD5+AgAHNXICAABdvgA==
Date: Wed, 22 May 2024 21:04:10 +0000
Message-ID: <e4e181e4a7b2db4b27b6ce3e6bb26b23e514cdb1.camel@hammerspace.com>
References: <20240521125840.186618-1-sagi@grimberg.me>
	 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
	 <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
	 <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
	 <4d2bc7f1-b5c2-469c-9351-772626c707d7@grimberg.me>
	 <c1d98e76-1b5c-4d91-a7fe-9412df7c2fab@grimberg.me>
In-Reply-To: <c1d98e76-1b5c-4d91-a7fe-9412df7c2fab@grimberg.me>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB4956:EE_
x-ms-office365-filtering-correlation-id: 4261ff39-eea0-47f4-7173-08dc7aa2b9f4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3JoQlBoQXMxM0JwUzlOa01NRHBTMnM3OWk5cHZzOHV1aDZueUkyYTloYWlq?=
 =?utf-8?B?ZEUrUG1qdC9iV01DMkIxcEJYTGV4ZDg5RFVQamhudG9ld3RQSm5rckVlbUNl?=
 =?utf-8?B?ZFJLckhNZmhWTnVzdTVob0w1OUZPK1Q3NTlVMDRaMWxkQ3lnWEVOL0VwbVRy?=
 =?utf-8?B?cVJrdWFqcWlVSDE1NWxPR0JJVU16OE8vSElUTW03TnA5ZXV3Um00a0RCYzNa?=
 =?utf-8?B?aTFZUWlaQUQrTCt5V2g0UTBCY1plSUVleXdGRERxd0VWRjJ0QWVYSGptUFNJ?=
 =?utf-8?B?OFhxODNMTWUxVzNGUk85WFIyMzFKaDFJK0s5MEkxVmxjMlAvZ3J3bkpzVGc0?=
 =?utf-8?B?V3ZjdnhMMlluTU41WEpNWjhSMjlsS0xpV0JTY1pDQzB5UzFKU3hSZytDamhh?=
 =?utf-8?B?aEdZYTFIK2t2NUN5b05wblVKOVVNZzZIV2ZrTURtNno2Qkxzc2Y5aU11QmZQ?=
 =?utf-8?B?OS9Gd2V6KzZZT0JQa0REVklkbDJOem1zMWhaS3dsZHFubTVyQ2RrY29zNzZo?=
 =?utf-8?B?NmtOSUdYZDlBR3ZKS0tZMlFXc2VYdFRuT1JRRVdvSkh1RWpLYW9FYmdGKzlN?=
 =?utf-8?B?bFNCazNTSjJrT3QxYUFmQTA1Wi9IMG90emo1dFgyU1R0M3Z5RFk0b0tQVjI2?=
 =?utf-8?B?V0h0S2NBMG0reTdQVFA5Yk9NWDdWRUkvVy96endja2d1OU9ENkR5ei9CMVpP?=
 =?utf-8?B?cVlmUzVIeVpYeml1QnU4TlVpb3Jhby9zU2V1S3FBcWE2VDhTbmFlcFR3enJy?=
 =?utf-8?B?WE40QmJKT3U5eUVyQzR3R004cVRmNDFXbkNDd0pNUlJ6QS8xazNTbzY2UlpS?=
 =?utf-8?B?Wmd3d0RmT05CVENIK2VXOFJ5aTE3akdqdFlGZG4zdDB6RGlHRzVoQ0pVbFNV?=
 =?utf-8?B?NWNjY2tlU1dZa3M0a1oxc21taWx6Z2hyOEthekU0eHlxVVdCMmtiRi9PTVh4?=
 =?utf-8?B?ZlRDS3IxWktzQmMrZjl5V1Y3Q2Z4R1R6bFdsNktxWCtiR21WZ1h4QmNtL3cx?=
 =?utf-8?B?emRDeXBUOGw2MGszNFpaY3ducXZVeXkxOGRVN3lzMlJUY21DV0pISmxRcXZZ?=
 =?utf-8?B?Y1RvV3hJTysya1FVcS9hZGtOeVo4SjJXcnRkbHhrRXQ2UjV2c1QzYnZiemxp?=
 =?utf-8?B?S0h2VWorSmlnOGNXdUhiTEtZUHpUUWZxeE1lbXYvcGVvU1RCL2w2c3U0OXNs?=
 =?utf-8?B?ZHBMbHNWUHEzUU4yZldqVjBYaTBQcCs5Y01PUkprTmszM0tnZTFsMnQrWjN0?=
 =?utf-8?B?d05sbWpYM2FxRk9zczVWRjFrQWhlSXZGZHlDbFBRUDllaXFzUmJ3UTNra1ds?=
 =?utf-8?B?cURHMm5XcEpacG91ZnBBR1BGQW1MeU9IcGNmMnlaL21nSWFscklaUmdHOElT?=
 =?utf-8?B?UzlzZEZzVkZJNjB6VE12aEs5d25Ra2xBZExLS05vRWNtTGtvdTNXeGhzbUR5?=
 =?utf-8?B?RXBHc2FhVnBudUVoemYyTVA5VVBhNVQ2b2o3UGwyZGFKYWZpYjYwR1RrOUVS?=
 =?utf-8?B?K2U5aHRzdi81SEpSamVVZlBwMU96UWlZamZZZ01JeUJ1UGtka1VvL1RGTFRD?=
 =?utf-8?B?UVM5ZEM5VkdMbmFCZ1lvMVAyM1lSSTVVN3ZwaG0wczlvYkNjM252Q2sxNTBN?=
 =?utf-8?B?TlpiYlhiM20rbTlic3pJNUJMWHlCWi9IYXdpV0NlbHRiTzYrU3ZvUUVXN1Z5?=
 =?utf-8?B?bTcyZStqMHE5OGFOL01Cc1JkVkdpK1ZlanpjeDZCMTZiMFgxZUF3Z0pPSVQv?=
 =?utf-8?B?ZkFhM2s0WGYzZUxSdVpxbDRlcENNL3gvbFlNMVpHYUZWOVNiYW54RTBqcGtW?=
 =?utf-8?B?bjE1S0ppNnRwOElEUTBFUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHZhU1NwZ1dma1BZd2xGQWgrMGRUN2RpSnpXMEJlTFZZa1pDRFZIWTkycURQ?=
 =?utf-8?B?TmJDbWNIcmlWYlZKV3hHeVVFZkNiYWhnbExqejZXbUJhWVdHWGwybld2NHY0?=
 =?utf-8?B?bnNveGZqRHBza2hwNTlJVUZCdEFOeExDMnpFQ000MFJoMWxKbUowbEdHUDBj?=
 =?utf-8?B?eTI4elljYzV4c25KcHZxUFM5YU1mRit5aDBvWU90RFRWaUlzNTlUdmNDaDdT?=
 =?utf-8?B?T0tXczlIampLTUlKeGlEWmdBanQ4NzQySFl2TDluTENxU0JDTjRYY0F5V0tt?=
 =?utf-8?B?UThiRE5scXBTSExqeUVzZnlJQTlQMXpaaElZM0FVSUZlcS9MU1o1dm40eHZO?=
 =?utf-8?B?ZnBaWS9FaTFSeTB4SGVLMisxZUgweEZxNWMwdmd2eDRJNS8zQ0cvVHhYT1hu?=
 =?utf-8?B?b1J5STJXaXQ1TmIzRHp1NXArWUUyVGRUNjhjZVdUOFQ4MlRCWDgrdW5taDZC?=
 =?utf-8?B?UjNwR3BMOHVoYnU2ckNHRjFSMGhValpENUV1R2ZEWDBKRmZaYXEvRmkvdDZt?=
 =?utf-8?B?U1Brb2U3TTZLY1AyMWJjTEZ3TlpGa3hyYUwrek1ZZ1ZZbWpDQTRWMHNIVStX?=
 =?utf-8?B?eTRqZnUvWDRMQTYwVDhCa2pBQ3lQZ1JOdzhSZWhndEQ3WVZYTWc2c3FSTU5a?=
 =?utf-8?B?S1ZxRDVPK1BTUUc1RG1MRGt6OW1jY25jaXo4VFdwdWgyWVh3elAyYmdTYU9P?=
 =?utf-8?B?OERMdzNkU0tSOVBYdjljVlMvVkZKcU1NQlJzZUpCMEZZMFpHV0RhaVZhM0hO?=
 =?utf-8?B?b0YvNzlQWGd4L1kzM2s2eE9hUE5BZTFKUTdoS2FGbEdSKzVtK2hGSUZWRWNG?=
 =?utf-8?B?Y2xhd0lJMXh3QzJEU1NQaVZvUXRHVCthS3pDdTVHUXV2dTFNZEU4MGFVQ0xa?=
 =?utf-8?B?dlNMT1NLdll3VVhFZU1rNkVEa1NzbDJNMWo3ZUZxOGh6K05MWXdoeGE3czNl?=
 =?utf-8?B?SEJQdnVVRVBmUGxkWnZXSXZobXZRWjFXUFMyeGRGRDJYSmF1b0FETFVIWU1p?=
 =?utf-8?B?bWRLSHlSalYrYkRJZ1JBbVJtVnhpMHlLemk1MSs0MDFxQmErNXR6bFh5VVJE?=
 =?utf-8?B?Z0hzMVlyV0prVW9GU0FsZ2VpQmt2MnpTbWxITTNvYXNZdjQrRW01RURCL2Nh?=
 =?utf-8?B?U0NoM0N3RlVTNUVHNjVyNTg0Z1Y1QVZ4dmVBVi9VeVdBNWVxZHVvUDFnU0hp?=
 =?utf-8?B?Mk9TMS9RWkw3QTRJUlpUUFRGWno5cjMrdXVENThZb1lMKzJTL0twVktzZDBy?=
 =?utf-8?B?UThBdzlZSk1sdlNyT3k1a0Nwb0FxNTJPbm0yQk85NUxqWmgxb0k3Y1pVVkZu?=
 =?utf-8?B?OEhoWlVoelFHRExYbzJqRU9zbTlxclBxbGJjaE9ubkFOcm1wQzE2VHZIV1o5?=
 =?utf-8?B?RlE1QU1iM0NFRUhCdXlTZmpFKytzc2tRWjVzdTdKWnkyc1l2RXN4K005R05U?=
 =?utf-8?B?NWFyT1k4S2dTQmIxZWJOVmVQNGdITHJJa1pwWnJmdW40TldyRGQwU0FxUlMw?=
 =?utf-8?B?Wm9wQWlqZ1pPc2tPNDBmMG9Ea0Q3RnJDeE1FYzY4dXpDZ1NyQXlOQWRmems0?=
 =?utf-8?B?N0NuZUlkVGRmVTNHMkZHdE5PRnV5dG1sMnhEYndvL2RXV0NLWHVGbUhoZ0Fs?=
 =?utf-8?B?MFJVMmZ0QmF4d0RIV2g5QVN1Z2xvL1FOcDgzRit2RnNLS2s4Tk9odlQrWXFM?=
 =?utf-8?B?V1E0bEJmb1ZIM0I1RzY0RVF3REhrUG1lVkZsWmRJeXEyMVEvS01NSDFjalhM?=
 =?utf-8?B?Y3QzV0JuYUNJQWM0VU9KdTROSEdMQ2liMWNlTDNaUEZUdVd2RDFUUldKczBK?=
 =?utf-8?B?WkZzcncwdFVZYWszV01FN2t0TGtZWEJUU1A5UkhHYTFMdjhBTjhsckI0RFJS?=
 =?utf-8?B?TnFXdFNqUHN4YUUvTEdFTllOTUYyVzVXc2EyVjQ3SW5WL2lBM0hsR0U0VzJ3?=
 =?utf-8?B?eGFjV0szc0NFdlFvdUtKbXFQSGZoMmMrcHR3RW1tMjFmTWNwV0VHOXpad2hM?=
 =?utf-8?B?UGMvelYvaEJzaFlQYzhiSDBGdVpBZDdHSHJmNXlxN1BxMGMzVGlnQ2o0T09o?=
 =?utf-8?B?L3pYY1YyWHhROElicmZKcVRSMjJJcGxBRWFNWTNWU1hXZmhrMDZHTitpdVVh?=
 =?utf-8?B?WnBMTHpoTlpxcjRBVmZsUnQ1ZVIyaGJyQjJ0VUYwWTBXZ2lrV3FLbjB6cDhw?=
 =?utf-8?B?MUJwOHU1UTNaTGg1NWRaR2c0S3VIQU9wNi8rWTB6QWlwM3pZb2FWeTdSVytR?=
 =?utf-8?B?dUIreE1FSG5QZ1RDUHJGSHNGMnhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1B925C02C657D4E8E592CAF7AAC7779@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4261ff39-eea0-47f4-7173-08dc7aa2b9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 21:04:10.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EK8rTnDt6HzjRRTpgPyr/Y3tUStSV4WGekw2IFlrbsq0w66gy6VwvTR1zJAQ5zNAZyI6+F6gZwlBB0guYvcdXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4956

T24gV2VkLCAyMDI0LTA1LTIyIGF0IDIyOjQwICswMzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0K
PiBIZXkgVHJvbmQsDQo+IA0KPiA+ID4gZmlsZWhhbmRsZSBpcyBzdGFsZT8gVGhlcmUgd2lsbCBo
YXZlIGJlZW4gYW4gdW5saW5rKCkgb24gdGhlDQo+ID4gPiBzeW1saW5rIGF0DQo+ID4gPiBzb21l
IHBvaW50IGluIHRoZSByZWNlbnQgcGFzdC4NCj4gPiA+IA0KPiA+IA0KPiA+IE5vIHJlYXNvbiB0
aGF0IEkgY2FuIHNlZS4gSG93ZXZlciBnaXZlbiB0aGF0IHRoaXMgd2FzIG9ic2VydmVkIGluDQo+
ID4gdGhlIA0KPiA+IHdpbGQsIGFuZCBlc3NlbnRpYWxseQ0KPiA+IGEgY29tbW9uIHBhdHRlcm4g
d2l0aCBzeW1saW5rcyAob3ZlcndyaXRlIGEgY29uZmlnIGZpbGUgZm9yDQo+ID4gZXhhbXBsZSks
IA0KPiA+IEkgdGhpbmsgaXRzIHJlYXNvbmFibGUNCj4gPiB0byBoYXZlIHRoZSB2ZnMgYXQgbGVh
c3QgZG8gYSBzaW5nbGUgcmV0cnksIGJ5IHNpbXBseSByZXR1cm5pbmcNCj4gPiBFU1RBTEUuDQo+
ID4gSG93ZXZlcsKgTkZTIGNhbm5vdCBkaXN0aW5ndWlzaCBiZXR3ZWVuIGZpcnN0IGFuZCBzZWNv
bmQgcmV0cmllcyANCj4gPiBhZmFpY3QuLi4gUGVyaGFwcyB0aGUNCj4gPiB2ZnMgY2FuIGhlbHAg
d2l0aCBhIEVTVEFMRS0+RU5PRU5UIGNvbnZlcnNpb24/DQo+IA0KPiBTbyB3aGF0IGRvIHlvdSBz
dWdnZXN0IHdlIGRvIGhlcmU/IElNTyBhdCBhIG1pbmltdW0gTkZTIHNob3VsZCByZXRyeSANCj4g
b25jZSBzaW1pbGFyDQo+IHRvIG5mczRfZmlsZV9vcGVuIChpdCB3b3VsZCBwcm9iYWJseSBhZGRy
ZXNzIDk5LjklIG9mIHRoZSB1c2UtY2FzZXMgDQo+IHdoZXJlIHN5bWxpbmtzIGFyZQ0KPiBub3Qg
b3ZlcndyaXR0ZW4gaW4gYSBoaWdoIGVub3VnaCBmcmVxdWVuY3kgZm9yIHRoZSBjbGllbnQgdG8g
c2VlIDIgDQo+IGNvbnNlY3V0aXZlIHN0YWxlIHJlYWRsaW5rDQo+IHJwYyBycGxpZXMpLg0KPiAN
Cj4gSSBjYW4gc2VuZCBhIHBhdGNoIHBhaXJlZCB3aXRoIGEgdmZzIEVTVEFMRSBjb252ZXJzaW9u
IHBhdGNoPyANCj4gYWx0ZXJuYXRpdmVseSByZXRyeSBsb2NhbGx5IGluIE5GUy4uLg0KPiBJIHdv
dWxkIGxpa2UgdG8gdW5kZXJzdGFuZCB5b3VyIHBvc2l0aW9uIGhlcmUuDQo+IA0KDQpMb29raW5n
IG1vcmUgY2xvc2VseSBhdCBuZnNfZ2V0X2xpbmsoKSwgaXQgaXMgb2J2aW91cyB0aGF0IGl0IGNh
bg0KYWxyZWFkeSByZXR1cm4gRVNUQUxFICh0aGFua3MgdG8gdGhlIGNhbGwgdG8gbmZzX3JldmFs
aWRhdGVfbWFwcGluZygpKQ0KYW5kIGxvb2tpbmcgYXQgZG9fcmVhZGxpbmthdCgpLCBpdCBoYXMg
YWxyZWFkeSBiZWVuIHBsdW1iZWQgdGhyb3VnaA0Kd2l0aCBhIGNhbGwgdG8gcmV0cnlfZXN0YWxl
KCkuDQoNClNvIEkgdGhpbmsgd2UgY2FuIHRha2UgeW91ciBwYXRjaCBhcyBpcywgc2luY2UgaXQg
ZG9lc24ndCBhZGQgYW55IGVycm9yDQpjYXNlcyB0aGF0IGNhbGxlcnMgb2YgcmVhZGxpbmsoKSBk
b24ndCBoYXZlIHRvIGhhbmRsZSBhbHJlYWR5Lg0KDQpXZSBtaWdodCBzdGlsbCB3YW50IHRvIHRo
aW5rIGFib3V0IGNsZWFuaW5nIHVwIHRoZSBvdXRwdXQgb2YgdGhlIFZGUyBpbg0KYWxsIHRoZXNl
IGNhc2VzLCBzbyB0aGF0IHdlIGRvbid0IHJldHVybiBFU1RBTEUgd2hlbiBpdCBpc24ndCBhbGxv
d2VkDQpieSBQT1NJWCwgYnV0IHRoYXQgd291bGQgYmUgYSBzZXBhcmF0ZSB0YXNrLg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

