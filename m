Return-Path: <linux-nfs+bounces-7656-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2DB9BBCCF
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 19:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E01A1C21CE1
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 18:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F90224F0;
	Mon,  4 Nov 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="BjM/GJ6j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2115.outbound.protection.outlook.com [40.107.92.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9381632E4
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743474; cv=fail; b=WBD35z/A8bRVgSVkHZIKOcgUsUG2V7YF+D46C/rsstUkJUHMs/FCW9Ata7JRszPPt12+BG6B1WyHLNKzhVBai1uMgdUqDr9ea+MzxnWbUhGdj/SJw2FmqSrOfJsw4B8TG17GYYKg0dVbbiYmRZBuIdbK0wZPE69teivEJgfalxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743474; c=relaxed/simple;
	bh=kWMSNPsHdFee5EbZkZnNCl4HrEK7omPW2SYlBl5Ni7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hX9oJsiSHRQHA9SPVwkZf0C3N0JK3d7UwNqiuMVHmOyf3dpXC4CvZ4jzYp4MN0RAK8980gG8RRkHV/tlz7u7t2+0CaTL0arMXuCqsIvnVGUqQRsQLj7RWj35oss6ZObYv0CkHFPcHEKUoFxgtdtSv5e7WEnt+Qm1dBH1p6tW0nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=BjM/GJ6j; arc=fail smtp.client-ip=40.107.92.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot/bTUWBZsr5BOXXOIdFfaf9jIikCGmEKYrJhNmuE+yzLC8tf697gwoPU2HUFXdQIOs+639NCFdUUb/oz8b7FbEd/qNgU92QQsCU5VnRabuHDXWpCQ7nAU0jzFfWLj4q8wbPs0f8jyTIc1sKhd7M1L2QOtGlEi0+zcZ5EapoCs5eCUaj9KZJlyagkPxZABi7OTKbj+JNHAfEAuZM0vj6G7dWS+4dvVxplGAbCzaSEb4fXSB8DwDLMDyub4nN8rdN00r5ak5GwEdPGgAlh8GrFDtCbWjAPeqM2/S2nMbt+VkLIAkjw2Nj38MhRfw9OAwJn8x5hVUOi9ujoYvwlZOHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWMSNPsHdFee5EbZkZnNCl4HrEK7omPW2SYlBl5Ni7c=;
 b=J56ynGuQE5UvuYxYb5fuNI7NqPskFSFO3S5wqV470CEwCIgGW6u0Xvh/vdCeQzimJQMV2dUa84VCBDk9mn3ksjO974EQw1CmvXrbZf3/CoZp7+WPOgcLjSJOZYoZ3IY6M5bYLw1PTr1gqVNcJkB149+/SXdnwkrAINBVyJhNs/VZ7MMpNws8+NCMwMPDk1UhE4+boPFHaMdxfyNgnBHz6wvnH6qqA3cwUDlvsZbG9DKzJ0TuaL5eOJ5GcwZU6301QlOin2wGItnjS+mzAka8a8d9R/52+4nv4YtqYFyfViK9tKHqVsBhE3kgcUaBeIyedrkKu7QCU1MtjAnsWjgluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWMSNPsHdFee5EbZkZnNCl4HrEK7omPW2SYlBl5Ni7c=;
 b=BjM/GJ6jUJh2WlrQYTCgqbKF1jpi0TmkNHPoVuPwuTHlzhH/03pCqeoY+pWNsb4qxjUHeTcfxLOk2H3UqqEWnAKIWQqpxNpqVNG0iVDqsRNmCNLuHoZd9InzCbVSM3Vd1zOzeYl1R+7C4wfGFiN12FgcCjwsOV1w9UJZ0xnmcho=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5493.namprd13.prod.outlook.com (2603:10b6:510:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 18:04:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 18:04:21 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna.schumaker@oracle.com" <anna.schumaker@oracle.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Soft lockup with fstests on NFSv3 and NFSv4.0
Thread-Topic: Soft lockup with fstests on NFSv3 and NFSv4.0
Thread-Index: AQHbLTxl3bBI7TBP4ESJCTJw2iuAfrKnbXeA
Date: Mon, 4 Nov 2024 18:04:21 +0000
Message-ID: <727185b6375cbb9138edd46a7bd37186de83670c.camel@hammerspace.com>
References: <9F6400FB-AF3C-4B56-B38F-E964B60B508D@oracle.com>
In-Reply-To: <9F6400FB-AF3C-4B56-B38F-E964B60B508D@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5493:EE_
x-ms-office365-filtering-correlation-id: 8a42f22f-28cd-4b6d-e8d6-08dcfcfb1bd3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFdXRmFnQTNkd0piMU51ZklqMjZ1U0VhOGoyam1uQ3RCQ2hCWjFGaGsrQTI1?=
 =?utf-8?B?YTJMS2NNMHVBTDIzOGpVbXdDRVJUZ250Zll0bVRyNVBQSGlWTGQwOGJRUHNu?=
 =?utf-8?B?ZGVrUjc1TStRSDFublYwU2pyMGxlL3REdDJRMUhVYnNOQWpPYmdhTUd3SmZa?=
 =?utf-8?B?TEFCYS9MOW1ZbTBkMkNvOTRLWmFZdkQ5QXJyYzRZMjZzTS8xb3lqZVNIQ1ZL?=
 =?utf-8?B?T29SMlNnbFFzR1N6OXlGYTNrTDR1QXBCUEFBWW5qbklYejZFbDd2MEtDUldC?=
 =?utf-8?B?NlBQTm0rRnMxRU8yNW9WYzRnekxmbGkrTDdqKzNBaHhUdFM1aVgrcFU0bDll?=
 =?utf-8?B?R213d1kzSnBmMjN0WWtTVGNlN01Ic0dQc0VxTGFqMGZnQmROOUVDMm9KZXVR?=
 =?utf-8?B?OERDMHR5U3Nmb2RSYmZZcDQzU3JjN05sQThGd3RxdkgrRUpWNVIzc01aeFc0?=
 =?utf-8?B?SDlxYjNtbTkrVTd1ZXpVbk55dy9ZN2p3cHhWRVFXUUhta2EvdVpVQkxpcVpG?=
 =?utf-8?B?WS85Y0I3WnM0Ly9TNnVHQWJaSHFpeUkrbWJLeDBRUUpOa2R1bTFRWnZWbmwy?=
 =?utf-8?B?SVh6UStOeWlqeWhHL09sR2JXWnBGYXN3R2p3QlpMUnZaWnBta3kwaVplcTZC?=
 =?utf-8?B?dXVPTG5xNFY2UEQxYjFOTVBuZmIyRVhkMUt2YyszYWZvdEF5OHhNQXZGYTNL?=
 =?utf-8?B?dXlUKzk5VWgxd01jQmoxb1BRZktrSXlFd1NjWGFCK2V5dStmZFlyWnIzZkRQ?=
 =?utf-8?B?YXFNUERlL3RwK0VVeHNrRUhLUzFmTVlsN0wyTHJ4aVlVU2R0NzFoMVdnQ2JD?=
 =?utf-8?B?bWJyZkRhbWlUckFWZTZUM2hwb0xBMkpadkMwdEJEYUdNSG5ZVFJ5S2pkYXV4?=
 =?utf-8?B?Y21US3FTYlVhcFhPRElObUJJdEg1V0U4NUlPZmEzZU9FejJIQlo1Qk42STd3?=
 =?utf-8?B?MmQrSXNkRkpLZGdVYStKUGNwTGQyVFFjeFJiTFZGQ1JieW94QnVwR3R1YjVm?=
 =?utf-8?B?WXZLWWJoSG9wS2NFUVZEdlZGUi94emQ2OGpvN3YvNlRUY0xZMU9wOEpqcU5E?=
 =?utf-8?B?WXh5alJLQll0T1dJbk4wY3RjZFczanhWUExUVmtVUXVmYXhWbThRK0hoaHg5?=
 =?utf-8?B?N0V3aTlFdWJ4WWVNQlMxRU5zYWVkc2RuRVhVUGE5M2NmOVRMYUVFcXJLR0w3?=
 =?utf-8?B?RG8yakUvdkFDRVl3a2pFQXlWalRDRzNxOXNVUnF0dVA2RURhZTFtYmdjRmc5?=
 =?utf-8?B?Zmd0WThjSCs4b1ZnZlRjWEQ2K2RST2U1NHpxUUxPaXhaWSt6ZkJ6a1ZQaUlu?=
 =?utf-8?B?eStodURHZ2l3dEFVTEZqTTZIN3RCUFFNbHNjaXdHb0hjNlJOVVlNdGFqaTZy?=
 =?utf-8?B?U3RDVUY4dFhEM2hEVzVZZWJJT3lkUmk0UHpIZ2lmOER1eXM1a215STRkZ3VB?=
 =?utf-8?B?c0FXOEE3RVMwckt1aVJvVU9oVXhZMXNXNkFMOHlMc2lyVVlaVEN0K3hzMi9q?=
 =?utf-8?B?ZnZlNXg3ait2dnQ4TVF1d21hQ2NNMGJxOWRaTFdGZGd4REZVbUt0NHhiVUhR?=
 =?utf-8?B?OGRLdGViMWo5U2hpOHQ0Z2lNZnc5bFkrZERMZU51dUZEU0tuZkd4N1B3S0JL?=
 =?utf-8?B?T2dqL3BIMnZIS2ZSaWp4OGJYTVQyamNiL2pyR2YrN0ZlOEl0TS85N2ozVE5q?=
 =?utf-8?B?T1BEa2ZUQ0trZkN1b0s5cHE5enVYMmdJVzV6VlBKN0NmcWl5SHcwZEZQemlj?=
 =?utf-8?B?bldqYkJzSGxNTi81WU9LQi9lc3g2WVpPL3V5Y3dzeFRPMlc0bVZ1UTgvSDZ5?=
 =?utf-8?Q?FNywreBXPu1LygswFap8qIjvy+BDHcAzGw4tA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djFaTzJJeWlXUldRNXc3b2J1MzZ0VlAwYmhNNlBMRCtPN2FrTitQTG1NQlNm?=
 =?utf-8?B?aWVsOTF1Tk5BejArUWZEZWU3TGxGcjBvYUUySHNjY2VqY0JHOFpMcFQxSUkz?=
 =?utf-8?B?K3J2N3UvWWNsZmdObnlzZjFQRnZSRUdpenlPTmVBNDc0MHlnamJBQWQwWDNJ?=
 =?utf-8?B?NXFPZnBJcjFEWlBzS1dVVGdLbmNUWFErTHdGdVRrVUJOTUkwZVZGMHduNTly?=
 =?utf-8?B?ZzlRbjUraDZFNno0dFVNbEh3UG91YTlCQVpOTERQRUtuOFMxRzl1VXl5NzBR?=
 =?utf-8?B?MjdOQldVbmszYkdRMHByQkpSNnRGZ0g1d21NcU1yTkUyT09KQjdmeWVXdkhB?=
 =?utf-8?B?c0tkVWxPQnRGcktRUWplNmFMV3Q0Z3dZWGxvYTJDVTAvcktmcnFiM2FlczJE?=
 =?utf-8?B?QTU4UzdCdnRCU1RmSFBQZ09LTWp3N0NkaVlOYjhJSmlWbUhUdjBPWHdIejRa?=
 =?utf-8?B?Nld0aHhYQnNNYit2N0dSZjRYNkQ4cnZSUGpHZTFZa0RjOWJhNWNaODYzOGwy?=
 =?utf-8?B?OHV1NXdlQnVBRlUwN2l1bm0yMDhLTU9nM0k0OU9NY0VHeVlYdnVrNnJGaHJv?=
 =?utf-8?B?dFZQTnVid3hMT3h3WTN1UnNydUVrQ25WTDE0NDNwNE5xam1GbVpTb3BUQ29J?=
 =?utf-8?B?b2lRYUl4NHV0NlV2Wjl6cjZyYnpTM3JIU3hkMkRab3VkYTlsU2lXSTVMNlhI?=
 =?utf-8?B?ZjU3MkVwMnN4V2Q5dmJzekt2dzAxV0duK2x0NWJqUzFiK2d5K3FwSE81NUoz?=
 =?utf-8?B?WGcwRSs3ZXlKeE8xWU0xbzQ4ZncwYWlSMFVwYjFKR1dsaVg1OEFwUGtCVzZz?=
 =?utf-8?B?c29sT1Q2bWQwYmJHSmFIcEJiTyszbkNRd3FFdUZLSnZxQ0xabThSd2h6WEtH?=
 =?utf-8?B?RDRLdlBydmY0NDZjeGpnV01kOVR0VThsUVpKKzJBMGo5ajBXOEhzWE1MTk1t?=
 =?utf-8?B?K3FTV0pJSEdwRmpjVHRibVZNVkY1WTAzMktjSzBKeGFlVDJuQ2dBNURUN0l2?=
 =?utf-8?B?NTdBVDNCdGZjRklVMDJ2THVVczNFWlQvdzZoNms0N0JIOXdtanFFMWlqbUpC?=
 =?utf-8?B?YVlQMitzMERHcGdGTTJZQkZQTlVxQzVock5iQmM0dklUVFpiVnVzY3cvZ0d4?=
 =?utf-8?B?MGxlYUhmeTFvcVQvb0NvRFdYN2tmMGdXWTIrdU5sMCthZnZtM1hmSDRTTUJj?=
 =?utf-8?B?QUZWUG1uOElTRElYYnF0Vy9rcUpZdGlYd0dTK2toKzlta1U4S29XNGUySC9F?=
 =?utf-8?B?NTJOeXY1MkU5VzJ0amlmbGpacTlILzlROURXem5XeUdGYlprT0dIM0E2Zzdz?=
 =?utf-8?B?TTJTV0FUTWpzeFBKcVdENlJJV2N4VW1Va3lCeDNOaEEyeHh1TldDb0d3MjV4?=
 =?utf-8?B?UVVBem5TUmVqaDlCQS9LZEFxZ3pIanFCS0JLSzNzK2E4MGNuMGxuTE5WZFEy?=
 =?utf-8?B?SFluQWpObTJ1RFk5WHVOS1k0TXR3d2JQQnpnTzQ3UWxkZHc2cGJqbThtdlZU?=
 =?utf-8?B?S3NwaUxkODNyQlNMbFM5ZnRhVWpkQ3NqQnQ1NVExWEdGT0R4bFNtT3M5YWRT?=
 =?utf-8?B?MlBITXpOYmY0UFNrS0hZNzFxeUcxNDZJUmNwYTNEN0g4cndBT3plQmV3dFpo?=
 =?utf-8?B?K0MrNGNRZG9ndDltYVVZMVZJdE44ckoyZXZFWkRwLzAwWWRxMVBEb0xqUXEx?=
 =?utf-8?B?UjhDV1I0Vk5KNTFpQlJvR1lBNWxOYTY4VTc5R0J0aTlzQ1RLenpDbUVRNDZH?=
 =?utf-8?B?ZE1aTVl1NC85NWkvRitwc2tEOEtUcSt0VzRQcVFXaGx4UGY1TFhBSGVFMHNv?=
 =?utf-8?B?a2s0aHdBVzhEVFhQSndBbUdsUjhOMW95OHpyRFFqK2JpRlJwaFVMNHlHRGhX?=
 =?utf-8?B?T0NhVUQzbDJLTXR5bUdKdHlzNm95VkxnVkJnbVdLU1UxV2FkZkVKbHZ5S0sy?=
 =?utf-8?B?UDJ0eXdqV25Ca1FBQnIrWGlyTE1BSUlvN2g2cEdYREdVbGJOVEducy82SXcw?=
 =?utf-8?B?Wk5DWTREdkd0QTlIdmgxQ25wb3k3QjByQTRUZjROcWRRUzViSGRobTVYVVpx?=
 =?utf-8?B?ZTNvYko0TkFSdys3L0liS3FjOTRjN0Q4WCt4N1EydFRncXpPbzlTZzlZWmxK?=
 =?utf-8?B?elRSQlVSb1loVDByT0IxVU1hVENxcXMzN2I0RWR5b21MSm1DVU05VVo3OTV0?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72291D7FDEDED748A5DA46F4F5BA9CD1@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a42f22f-28cd-4b6d-e8d6-08dcfcfb1bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 18:04:21.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlLPf58dlsjHUq8W16E06eNOTwsdEmBy+//HtBkcHantFm/R8BxHkAK6RRq8zNbTJ81F92qVMhpHHXgG5Ovwjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5493

T24gU2F0LCAyMDI0LTExLTAyIGF0IDE1OjMyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IEhpLQ0KPiANCj4gSSd2ZSBub3RpY2VkIHRoYXQgbXkgbmlnaHRseSBmc3Rlc3RzIHJ1bnMg
aGF2ZSBiZWVuIGhhbmdpbmcNCj4gZm9yIHRoZSBwYXN0IGZldyBkYXlzIGZvciB0aGUgZnMtY3Vy
cmVudCBhbmQgZnMtbmV4dCBhbmQNCj4gbGludXgtNi4xMS55IGtlcm5lbHMuDQo+IA0KPiBJIGNo
ZWNrZWQgaW4gb24gb25lIG9mIHRoZSBORlN2MyBjbGllbnRzLCBhbmQgdGhlIGNvbnNvbGUNCj4g
aGFkIHRoaXMsIG92ZXIgYW5kIG92ZXIgKHNhbWUgd2l0aCB0aGUgTkZTdjQuMCBjbGllbnQpOg0K
PiANCj4gDQo+IFsyMzg2MC44MDU3MjhdIHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BV
IzIgc3R1Y2sgZm9yIDE3NDQ2cyENCj4gWzc1MTo2OTE3ODRdDQo+IFsyMzg2MC44MDY2MDFdIE1v
ZHVsZXMgbGlua2VkIGluOiBuZnN2MyBuZnNfYWNsIG5mcyBsb2NrZCBncmFjZQ0KPiBuZnRfZmli
X2luZXQgbmZ0X2ZpYl9pcHY0IG5mdF9maWJfaXB2NiBuZnRfZmliIG5mdF9yZWplY3RfaW5ldA0K
PiBuZl9yZWplY3RfaXB2NCBuZl9yZWplY3RfaXB2NiBuZnRfcmVqZWN0IG5mdF9jdCBuZnRfY2hh
aW5fbmF0IG5mX25hdA0KPiBuZl9jb25udHJhY2sgbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lw
djQgcmZraWxsIG5mX3RhYmxlcyBuZm5ldGxpbmsNCj4gc2l3IGludGVsX3JhcGxfbXNyIGludGVs
X3JhcGxfY29tbW9uIHN1bnJwYyBpYl9jb3JlIGt2bV9pbnRlbA0KPiBpVENPX3dkdCBpbnRlbF9w
bWNfYnh0IGlUQ09fdmVuZG9yX3N1cHBvcnQgc25kX3Bjc3Agc25kX3BjbSBrdm0NCj4gc25kX3Rp
bWVyIHNuZCBzb3VuZGNvcmUgcmFwbCBpMmNfaTgwMSB2aXJ0aW9fYmFsbG9vbiBscGNfaWNoDQo+
IGkyY19zbWJ1cyB2aXJ0aW9fbmV0IG5ldF9mYWlsb3ZlciBmYWlsb3ZlciBqb3lkZXYgbG9vcCBm
dXNlIHpyYW0geGZzDQo+IGNyY3QxMGRpZl9wY2xtdWwgY3JjMzJfcGNsbXVsIGNyYzMyY19pbnRl
bCBwb2x5dmFsX2NsbXVsbmkNCj4gcG9seXZhbF9nZW5lcmljIGdoYXNoX2NsbXVsbmlfaW50ZWwg
dmlydGlvX2NvbnNvbGUgc2hhNTEyX3Nzc2UzDQo+IHZpcnRpb19ibGsgc2VyaW9fcmF3IHFlbXVf
ZndfY2ZnDQo+IFsyMzg2MC44MTI2MzhdIENQVTogMiBVSUQ6IDAgUElEOiA2OTE3ODQgQ29tbTog
NzUxIFRhaW50ZWQ6DQo+IEfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTMKgwqDCoMKgIDYuMTIu
MC1yYzUtZzhjNGY2ZmEwNGYzZCAjMQ0KPiBbMjM4NjAuODEzNTI5XSBUYWludGVkOiBbTF09U09G
VExPQ0tVUA0KPiBbMjM4NjAuODEzOTI2XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBD
IChRMzUgKyBJQ0g5LCAyMDA5KSwNCj4gQklPUyAxLjE2LjMtMi5mYzQwIDA0LzAxLzIwMTQNCj4g
WzIzODYwLjgxNDc0NV0gUklQOiAwMDEwOl9yYXdfc3Bpbl9sb2NrKzB4MWIvMHgzMA0KPiBbMjM4
NjAuODE1MjE4XSBDb2RlOiA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5
MCA5MCBmMw0KPiAwZiAxZSBmYSAwZiAxZiA0NCAwMCAwMCA2NSBmZiAwNSA0OCAwMiBlZSA2MSAz
MSBjMCBiYSAwMSAwMCAwMCAwMCBmMA0KPiAwZiBiMSAxNyA8NzU+IDA1IGMzIGNjIGNjIGNjIGNj
IDg5IGM2IGU4IDc3IDA0IDAwIDAwIDkwIGMzIGNjIGNjIGNjDQo+IGNjIDkwIDkwDQo+IFsyMzg2
MC44MTcwNzZdIFJTUDogMDAxODpmZjU1ZTVlODg4YWVmNTUwIEVGTEFHUzogMDAwMDAyNDYNCj4g
WzIzODYwLjgxNzY4N10gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDAw
MCBSQ1g6DQo+IDAwMDAwMDAwMDAwMDAwMDINCj4gWzIzODYwLjgxODQ1OV0gUkRYOiAwMDAwMDAw
MDAwMDAwMDAxIFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6DQo+IGZmMjk5MThmODZmNDNlYmMN
Cj4gWzIzODYwLjgxOTE0N10gUkJQOiBmZjk1YWU4NzQ0ZmQ4MDAwIFIwODogMDAwMDAwMDAwMDAw
MDAwMCBSMDk6DQo+IDAwMDAwMDAwMDAxMDAwMDANCj4gWzIzODYwLjgxOTk4NF0gUjEwOiAwMDAw
MDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAzZWQ4YyBSMTI6DQo+IGZmMjk5MThmODZmNDNl
YmMNCj4gWzIzODYwLjgyMDgwNV0gUjEzOiBmZjk1YWU4NzQ0ZmQ4MDAwIFIxNDogMDAwMDAwMDAw
MDAwMDAwMSBSMTU6DQo+IDAwMDAwMDAwMDAwMDAwMDANCj4gWzIzODYwLjgyMTYwMl0gRlM6wqAg
MDAwMDdmNTkxZTcwNzc0MCgwMDAwKSBHUzpmZjI5OTE5MmFmYjAwMDAwKDAwMDApDQo+IGtubEdT
OjAwMDAwMDAwMDAwMDAwMDANCj4gWzIzODYwLjgyMjQ2NF0gQ1M6wqAgMDAxMCBEUzogMDAwMCBF
UzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gWzIzODYwLjgyMzAzMF0gQ1IyOiAwMDAw
N2Y2ZjZkMmYxMDUwIENSMzogMDAwMDAwMDExMWJhMDAwNiBDUjQ6DQo+IDAwMDAwMDAwMDA3NzNl
ZjANCj4gWzIzODYwLjgyMzcwOF0gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAw
MDAwMDAwMCBEUjI6DQo+IDAwMDAwMDAwMDAwMDAwMDANCj4gWzIzODYwLjgyNDM4OV0gRFIzOiAw
MDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6DQo+IDAwMDAwMDAwMDAw
MDA0MDANCj4gWzIzODYwLjgyNTEwN10gUEtSVTogNTU1NTU1NTQNCj4gWzIzODYwLjgyNTQwNl0g
Q2FsbCBUcmFjZToNCj4gWzIzODYwLjgyNTcyMV3CoCA8SVJRPg0KPiBbMjM4NjAuODI1OTk2XcKg
ID8gd2F0Y2hkb2dfdGltZXJfZm4rMHgxZTAvMHgyNjANCj4gWzIzODYwLjgyNjQzNF3CoCA/IF9f
cGZ4X3dhdGNoZG9nX3RpbWVyX2ZuKzB4MTAvMHgxMA0KPiBbMjM4NjAuODI2OTAyXcKgID8gX19o
cnRpbWVyX3J1bl9xdWV1ZXMrMHgxMTMvMHgyODANCj4gWzIzODYwLjgyNzM2Ml3CoCA/IGt0aW1l
X2dldCsweDNlLzB4ZjANCj4gWzIzODYwLjgyNzc4MV3CoCA/IGhydGltZXJfaW50ZXJydXB0KzB4
ZmEvMHgyMzANCj4gWzIzODYwLjgyODI4M13CoCA/IF9fc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJy
dXB0KzB4NTUvMHgxMjANCj4gWzIzODYwLjgyODg2MV3CoCA/IHN5c3ZlY19hcGljX3RpbWVyX2lu
dGVycnVwdCsweDZjLzB4OTANCj4gWzIzODYwLjgyOTM1Nl3CoCA8L0lSUT4NCj4gWzIzODYwLjgy
OTU5MV3CoCA8VEFTSz4NCj4gWzIzODYwLjgyOTgyN13CoCA/IGFzbV9zeXN2ZWNfYXBpY190aW1l
cl9pbnRlcnJ1cHQrMHgxYS8weDIwDQo+IFsyMzg2MC44MzA0MjhdwqAgPyBfcmF3X3NwaW5fbG9j
aysweDFiLzB4MzANCj4gWzIzODYwLjgzMDg0Ml3CoCBuZnNfZm9saW9fZmluZF9oZWFkX3JlcXVl
c3QrMHgyOS8weDkwIFtuZnNdDQo+IFsyMzg2MC44MzEzOThdwqAgbmZzX2xvY2tfYW5kX2pvaW5f
cmVxdWVzdHMrMHg2NC8weDI3MCBbbmZzXQ0KPiBbMjM4NjAuODMxOTUzXcKgIG5mc19wYWdlX2Fz
eW5jX2ZsdXNoKzB4MWIvMHgxZjAgW25mc10NCj4gWzIzODYwLjgzMjQ0N13CoCBuZnNfd2JfZm9s
aW8rMHgxYTQvMHgyOTAgW25mc10NCj4gWzIzODYwLjgzMjkwM13CoCBuZnNfcmVsZWFzZV9mb2xp
bysweDYyLzB4YjAgW25mc10NCj4gWzIzODYwLjgzMzM3Nl3CoCBzcGxpdF9odWdlX3BhZ2VfdG9f
bGlzdF90b19vcmRlcisweDQ1My8weDExNDANCj4gWzIzODYwLjgzMzkzMF3CoCBzcGxpdF9odWdl
X3BhZ2VzX3dyaXRlKzB4NjAxLzB4YjMwDQo+IFsyMzg2MC44MzQ0MjFdwqAgPyBzeXNjYWxsX2V4
aXRfdG9fdXNlcl9tb2RlKzB4MTAvMHgyMTANCj4gWzIzODYwLjgzNTAwMF3CoCA/IGRvX3N5c2Nh
bGxfNjQrMHg4ZS8weDE2MA0KPiBbMjM4NjAuODM1Mzk5XcKgID8gaW5vZGVfc2VjdXJpdHkrMHgy
Mi8weDYwDQo+IFsyMzg2MC44MzU4MTBdwqAgZnVsbF9wcm94eV93cml0ZSsweDU0LzB4ODANCj4g
WzIzODYwLjgzNjIxMV3CoCB2ZnNfd3JpdGUrMHhmOC8weDQ1MA0KPiBbMjM4NjAuODM2NTYwXcKg
ID8gX194NjRfc3lzX2ZjbnRsKzB4OWIvMHhlMA0KPiBbMjM4NjAuODM3MDIzXcKgID8gc3lzY2Fs
bF9leGl0X3RvX3VzZXJfbW9kZSsweDEwLzB4MjEwDQo+IFsyMzg2MC44Mzc1ODldwqAga3N5c193
cml0ZSsweDZmLzB4ZjANCj4gWzIzODYwLjgzNzk1MF3CoCBkb19zeXNjYWxsXzY0KzB4ODIvMHgx
NjANCj4gWzIzODYwLjgzODM5Nl3CoCA/IF9feDY0X3N5c19mY250bCsweDliLzB4ZTANCj4gWzIz
ODYwLjgzODg3MV3CoCA/IHN5c2NhbGxfZXhpdF90b191c2VyX21vZGUrMHgxMC8weDIxMA0KPiBb
MjM4NjAuODM5NDMzXcKgID8gZG9fc3lzY2FsbF82NCsweDhlLzB4MTYwDQo+IFsyMzg2MC44Mzk5
MTBdwqAgPyBzeXNjYWxsX2V4aXRfdG9fdXNlcl9tb2RlKzB4MTAvMHgyMTANCj4gWzIzODYwLjg0
MDQ4MV3CoCA/IGRvX3N5c2NhbGxfNjQrMHg4ZS8weDE2MA0KPiBbMjM4NjAuODQwOTUwXcKgID8g
Z2V0X2Nsb3NlX29uX2V4ZWMrMHgzNC8weDQwDQo+IFsyMzg2MC44NDEzNjNdwqAgPyBkb19mY250
bCsweDJkMC8weDczMA0KPiBbMjM4NjAuODQxNzI3XcKgID8gX194NjRfc3lzX2ZjbnRsKzB4OWIv
MHhlMA0KPiBbMjM4NjAuODQyMTY4XcKgID8gc3lzY2FsbF9leGl0X3RvX3VzZXJfbW9kZSsweDEw
LzB4MjEwDQo+IFsyMzg2MC44NDI2ODRdwqAgPyBkb19zeXNjYWxsXzY0KzB4OGUvMHgxNjANCj4g
WzIzODYwLjg0MzA4NF3CoCA/IGNsZWFyX2JoYl9sb29wKzB4MjUvMHg4MA0KPiBbMjM4NjAuODQz
NDkwXcKgID8gY2xlYXJfYmhiX2xvb3ArMHgyNS8weDgwDQo+IFsyMzg2MC44NDM4OTddwqAgPyBj
bGVhcl9iaGJfbG9vcCsweDI1LzB4ODANCj4gWzIzODYwLjg0NDI3MV3CoCBlbnRyeV9TWVNDQUxM
XzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQo+IFsyMzg2MC44NDQ4NDVdIFJJUDogMDAzMzow
eDdmNTkxZTgxMmY2NA0KPiBbMjM4NjAuODQ1MjQyXSBDb2RlOiBjNyAwMCAxNiAwMCAwMCAwMCBi
OCBmZiBmZiBmZiBmZiBjMyA2NiAyZSAwZiAxZg0KPiA4NCAwMCAwMCAwMCAwMCAwMCBmMyAwZiAx
ZSBmYSA4MCAzZCAwNSA3NCAwZCAwMCAwMCA3NCAxMyBiOCAwMSAwMCAwMA0KPiAwMCAwZiAwNSA8
NDg+IDNkIDAwIGYwIGZmIGZmIDc3IDU0IGMzIDBmIDFmIDAwIDU1IDQ4IDg5IGU1IDQ4IDgzIGVj
DQo+IDIwIDQ4IDg5DQo+IFsyMzg2MC44NDcxNzVdIFJTUDogMDAyYjowMDAwN2ZmYzE5MDUxOTk4
IEVGTEFHUzogMDAwMDAyMDIgT1JJR19SQVg6DQo+IDAwMDAwMDAwMDAwMDAwMDENCj4gWzIzODYw
Ljg0NzkyM10gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwMiBSQ1g6
DQo+IDAwMDA3ZjU5MWU4MTJmNjQNCj4gWzIzODYwLjg0ODcwMl0gUkRYOiAwMDAwMDAwMDAwMDAw
MDAyIFJTSTogMDAwMDU2MmNhZjM1N2IwMCBSREk6DQo+IDAwMDAwMDAwMDAwMDAwMDENCj4gWzIz
ODYwLjg0OTQwMl0gUkJQOiAwMDAwN2ZmYzE5MDUxOWMwIFIwODogMDAwMDAwMDAwMDAwMDA3MyBS
MDk6DQo+IDAwMDAwMDAwMDAwMDAwMDENCj4gWzIzODYwLjg1MDA4MV0gUjEwOiAwMDAwMDAwMDAw
MDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDIwMiBSMTI6DQo+IDAwMDAwMDAwMDAwMDAwMDINCj4g
WzIzODYwLjg1MDc5NF0gUjEzOiAwMDAwNTYyY2FmMzU3YjAwIFIxNDogMDAwMDdmNTkxZThlMzVj
MCBSMTU6DQo+IDAwMDA3ZjU5MWU4ZTBmMDANCj4gWzIzODYwLjg1MTU5Ml3CoCA8L1RBU0s+DQo+
IA0KDQpJIHN1c3BlY3QgaXQgbWlnaHQgYmUgY29tbWl0IGI1NzFjZmNiOWRjYSAoIm5mczogZG9u
J3QgcmV1c2UgcGFydGlhbGx5DQpjb21wbGV0ZWQgcmVxdWVzdHMgaW4gbmZzX2xvY2tfYW5kX2pv
aW5fcmVxdWVzdHMiKS4NClRoYXQgcGF0Y2ggYXBwZWFycyB0byBhc3N1bWUgdGhhdCBpZiBvbmUg
cmVxdWVzdCBpcyBjb21wbGV0ZSwgdGhlbiB0aGUNCm90aGVycyB3aWxsIGNvbXBsZXRlIHRvbyBi
ZWZvcmUgdW5sb2NraW5nLiBJIGRvbid0IHRoaW5rIHRoYXQgaXMgYQ0KdmFsaWQgYXNzdW1wdGlv
biwgc2luY2Ugb3RoZXIgcmVxdWVzdHMgY291bGQgaGl0IGEgbm9uLWZhdGFsIGVycm9yIG9yIGEN
CnNob3J0IHdyaXRlIHRoYXQgd291bGQgY2F1c2UgdGhlbSBub3QgdG8gY29tcGxldGUuDQoNClNv
IGNhbiB5b3UgcGxlYXNlIHRyeSByZXZlcnRpbmcgb25seSB0aGF0IHBhdGNoIGFuZCBzZWVpbmcg
aWYgdGhhdA0KZml4ZXMgdGhlIHByb2JsZW0/DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K

