Return-Path: <linux-nfs+bounces-16892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E3CA19D7
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 22:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD33A30198B0
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 21:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAE72C0296;
	Wed,  3 Dec 2025 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FlgmO3zQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477F482EB;
	Wed,  3 Dec 2025 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764795986; cv=fail; b=gMYh8x9FhFWPjPH0mwBbpvQTCySntR/DKobzkb3gVC7esc0gUtEymWaew0JRHotohJQoJwr0OV4xOZz3IrvCGJ5bYiPzsbBJTJnYmsKR8mamTm2tdwrWvzJz2SJVov6kIbI9bFuKFl8ZA3fJkIld7O7KAIuNOUdbxBO4DZ/FTwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764795986; c=relaxed/simple;
	bh=hlY6UhShro63FksaZ2PM7GQrloCRAnjPl6+7c2cvdLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZMkT8FLLR+lCTU8on+sFoctEsW5Dy0QePdDDGPFDBeclPVxuYoNOO9PxZNccqTv3SFbNp3JxaeVTjnvsu1K+al8n3c4rk8CIS9k9wxreLFZ3qTlfZjXz5Etn6masZBxS1UXsAT8BxUSGbmY58m1dqmokjfiWKRYxLfyucYSJAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FlgmO3zQ; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iaw2ecDuY70cTVNlz/xcgtl3R7UBNaQg2YIHC7vtZE1OZEe2YWdiVEp42Nn15sLjUsNNL7aX6G89jNk36C+3TjLwt3gCFAylTS84HG7/TJyTltpZfc2mLJ8NjaFO80Ya1WgmfDpQn/O9URrkwe8RNyqFPrfK8M5di4SQsMys4Mge6csXKHByTgWjgcwp8X2cpwJ7QLSL6Ro1cZS2U6SGzjyFPjX7YpUadPhaBc0JWZqNXBPHCSYldy6+sDtcykVR1vxPH82sQY7cZmOdVdy/9NKZ/nhnCCQQTvY6n+mCVFlLBLCPSv2sozkfnqvWej30xQQ5DMrvt1GiJg5c8N3TBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86s+e+8VX/FFlMRtFyJtKG2/kn8xYLot15+FAdyZLT0=;
 b=Fd/BGSIYTvyHX7JSoGDumeR2PfkJiy3VLRGm4Z3u2v1FdsOMVBJFYXh209etxEtbHzN2HKEsZbZ4YBfamt70SjuA660pICuFAU9k1qtDiRzOjQKgjzOUSj9L7kipKuBZc1dggz6Qavc8KSoePE9Q5gdtPgHNcGn9gQIACtUt6oRtrFVhEBGnSoYBsreDoCyeGn2A2/TeIMgaJtVBeT8R9grqIlF7mf7E9TUdkA4jUa8K1rpOQBODcVEokXW/IDuztC3fBYFAFXX+MLyugewzUcvdue1ZekShcwbnHXX2YZAXf1fuQumNGSIm9luYQRa+p/GyqdTT2tSIga30ol7XBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86s+e+8VX/FFlMRtFyJtKG2/kn8xYLot15+FAdyZLT0=;
 b=FlgmO3zQgRo0vjYuj/VKyIbdl0gvP/UpEh3As3rUoKRMeMOWvDXoeEfAKcxd3jSTiWhz3pENCo8HBVLGbP59btDPUm9lLZwp/LuCfDDPQVZxVq5mDIJbR6GuicxL8aktSH+44Tf13FKVWadlqpdVcsYKBU9jf63vj3bMRrk327zKNRTOldI5icEQ6h2NytCKDNBVzVkjdNlauKEtjhtzyACblI/7G1aitKwPefJu2Uoru3VT+Wxxpl/8cBXQ+aTvupnXpkcFuyGpQ3VELfJCIqXz8w3mkHNlwXQh5RneeZCJ4ixkx+Fr1LUXvqfa5uM/eX+h7s7v2CJ6LF0NDlKqKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Wed, 3 Dec 2025 21:06:18 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 21:06:17 +0000
Message-ID: <d3da8a0e-4bb3-4a47-9804-2d0f3c452a84@nvidia.com>
Date: Wed, 3 Dec 2025 21:06:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] NFS: Request a directory delegation on ACCESS,
 CREATE, and UNLINK
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251104150645.719865-1-anna@kernel.org>
 <20251104150645.719865-3-anna@kernel.org>
 <4f5da6d9-ee72-4045-8fe1-c5eacedb4660@nvidia.com>
 <bfe61da1-3b52-49a4-844d-6f39d7ca4e9d@nvidia.com>
 <ba1a5563fd66738156a372eed016986952f11fd5.camel@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <ba1a5563fd66738156a372eed016986952f11fd5.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:610:77::21) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a11a69-56fe-411e-931b-08de32afcd36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mi9tb0xsWWtXdEkzWG9aQTVGN21rdXRIK2Z6aGxjUUdUc2c3SXlNVGJVNndM?=
 =?utf-8?B?MnhIRzZ5a2xIbDdjS2x3MU9qQk1SOXlBMmh3TGRwZ2Vpc0RoZW0vdlgvNjZ6?=
 =?utf-8?B?RU9qWVZacXNaUDZpdkRXeE5BRG40UEdnc21uYUw2ZkxRNHJsNkZ2WTZRUGNy?=
 =?utf-8?B?bzV3MW9yVFJGZXpsaFJlOUhreVg2OGc0SlkwelY3bXFlYmllM1laNkxTN0I1?=
 =?utf-8?B?TTRBaTlQSTRwbVRuSGRkVDVRaGtySHZhYU4zTHo3aUt5cnRqRXNxdnkyM1Iv?=
 =?utf-8?B?bkRWaFJJVTVJTlhLSXRIek1ZVkdFaXNhVjJsNEZMMWlIWm9EZUllTWVZcXB2?=
 =?utf-8?B?S2RQZDZkTnUyOThJZVFBOFRNZ3BHdk1xbFRyVE84djNxYng3eU15ZDRpbG82?=
 =?utf-8?B?WHp0MHNFSnJVRURzY09udkJxTTFEemFwcCtZM2xxeVV3TjBWZ1ZYSHZrcGpo?=
 =?utf-8?B?RDFsUko1ci9HT0VMNGMzekZ3dFBDYTgxbUJseWcyM0JOOCtISStjNlQxS3ZN?=
 =?utf-8?B?Qk14QVdVcHZpN0dTRTdtenJ6UXlWVkExajNCakpaYXM3dWFJMHFOSUVZZ3Vv?=
 =?utf-8?B?TS93NEFCVlhDM1BlUjFES0NTSXVsQ1N4RlBwdkVqRmZkbk9uOTZFbHZhNUlT?=
 =?utf-8?B?c3R4VThEZUNFZ0ZUL1JQVUtsZmx5eGNxZnlSaEwwSmVIZ01wWTFObDZQd0VR?=
 =?utf-8?B?MVRkYkNmdFA3MlVUSzRiODd2a0V3MW16YVd4TGtmUXl3V0tuMzZPMmdIdmp4?=
 =?utf-8?B?MmFIOS9ObXR0eU4xZFl5V2U3a3B2UnNZK1BGcTdMRXZtN2JneWZkSUpqdm4w?=
 =?utf-8?B?cllCUllQTkJ5UmRkR0FILzc2cXE1TVpQclp1OUN3YnB4U0d4YUg2UHhVWWxa?=
 =?utf-8?B?SjFncm1wTExqbVR6OFY4OEYyN3A1cFRVak5TK0pMejRXRWhRYVl2VjlsdVdL?=
 =?utf-8?B?cjY4bUtWcWtGWnRidEszSnRyMGU4cGFIVk1aR0crdVZkcnQ0M3JyM0xxMFBN?=
 =?utf-8?B?YjU0TEVCOUcwYndJeDNsTjFMcWlhRWtsbGRKK3ZpZ3BGZENjd01kbFVZYkpq?=
 =?utf-8?B?V2ova25GWUJqemlQVkx5aUFyaFcwb25UL1dCblZERWZGSlZzcEQzT2VKbXBJ?=
 =?utf-8?B?VjJOSFBaWXg4S1l6cncrQmlVZ3BkaG9JMEZjUDlEYUlaNEI2WjZuMjY3VXVm?=
 =?utf-8?B?eUcxSW1tYjJ0TllCTjNBL01uTGpnNXVneXpVNUxmMU5MaFRKdCtjclFjbVBB?=
 =?utf-8?B?MlhwNmJvNDVzSWZMdDVaUklUd3pMV09KRHJyNEVUdkpJbUNEU2ZUbDlCLzBr?=
 =?utf-8?B?ZXZoVlZWMFFXRlFzTXVyZElSSjRFR0RNb3lpTlVLcmgrY0NDY3pzbTFqbnV6?=
 =?utf-8?B?SWs4d1lKbGtwZFJabSthUEUyOWQyTm9qTVRxaFNSWU16dU1ENmdEaXFRYlhW?=
 =?utf-8?B?YTBxckwvN3pQbDdmVGMxYWFpSW9GWlVKYTN2ODBjUUNJNGFqdWs5c3llVkpl?=
 =?utf-8?B?bFBqMzRlcWhtR2pJLzZCcjVXQzhsWE9acGlqM0tLQkh0ZVdlSnFJQStNRXBW?=
 =?utf-8?B?eWU1YmlzcTEzL3Y2T3A1QXBXSTJRdjRMRFZYRlBzUmQrTnRUUDlKVTJ2UjRQ?=
 =?utf-8?B?VDE1djc3OXBqUDQ2NWtSejBtV2p0a0ZqZFE4R0xmVkkrakN0a3ZoZm9OaC8v?=
 =?utf-8?B?Nng1eXZBM0VWbHR6ZWFzSDZXbFlHSFpJK3llY3J1VVpITGRHTWdhTGVJNGlM?=
 =?utf-8?B?MXlrUG9HZzZrbjVmWFp2VCt0dlZ0ZzhxZkJKTWRJRUhHQUZNa2U0OVpYRFVM?=
 =?utf-8?B?Y1NYNldSeWpKejgrajNuQk96dGc3VnZvMktUZmJVZU5xcHBVL2E3YjIxWVo4?=
 =?utf-8?B?M3VlOFIyaU4wZEVJTVFlRXZYQmpFYWtCVFJBVWxOWlZORG9zWDNSUDgySnpn?=
 =?utf-8?Q?L5emLEz09S77mfEKKjPPeeg1fb4oTl9F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFErSFhvMzJJSnVLMmZQWGRFUUlkUUZQdVJUZnFKd0RIMmhrU0xxTlZ2TjdP?=
 =?utf-8?B?Q0RobFdGZzdhNk5aUVhVQVNIZmVPWFhmRDFIZDZTWnJveVJ5K2NmWFV1NC9H?=
 =?utf-8?B?TWxVTnpac05zckpaSUE0MDEreHRlS0VWZjJSYVJ6aGtGQTFwc1ZwYWdCcjll?=
 =?utf-8?B?V0tpcTQvWEJpQXlnUWp1NTV0U1J4YjAzZ3VLRTd3NkJEbGtySjFOUU9Va3ds?=
 =?utf-8?B?TEtYZ3l1OXFxMlNiQkpCNGNwUkkzLzB3OGJJVWd4c0NtUkRoK1lpSS9PYmdG?=
 =?utf-8?B?cXRtSDBlZU55b2pOekpTdGhKR0RXZ0k4UG9NaHZSQnBKd3FUQ3VkSFFoRklQ?=
 =?utf-8?B?RTA2N0ZrdFRVSmd6NnBtaitkbGpNeUhlbWt3UHpVVGhmaEQrK3NWcWZ0L0J5?=
 =?utf-8?B?eXF5VGxpSDkzVC9NTWs1NkNEWGMyZGo0VHlVdGJtZHJFZVk3WGhubnE3bTF1?=
 =?utf-8?B?amV5T1h4d0xkK2VwTjFmdFd6NjJIREtvalYwMzhYN01KOTl4ZmFtbkZCTjFo?=
 =?utf-8?B?enBQOGVrdU80WHdiRWRDaXVXQk5nMEhvNGpKUEFWMDNuZVJHM0Q4SndWdEov?=
 =?utf-8?B?NmpCK1ZtQWJLaVRDOTdMZEdvZDNGQUNjLzFmRVY2K1oxTVFVdmU2UlRUL3Vn?=
 =?utf-8?B?c3czUW43Q0s1SFNzOU11UHZUcVhyMnh6U2gxTm9TUVBGdGtYRG1FaXVhRTZK?=
 =?utf-8?B?cWxZbm9DZkpFd3lPWkRBcXYzOERnbnc5dnArSTcrZnAwcjMrT3UvZ0RnQm9r?=
 =?utf-8?B?VWEvUW9NUldJd0s1dTkrVm41Z2NvVWM0YThaZURsUzJBTUcxVFRwNk8xTnRa?=
 =?utf-8?B?dlFFaU4xWEJBRzhJeURJR1hUd1E1YkJ1bnloaVFucHZVUm9qSGJ4dEllMnlE?=
 =?utf-8?B?dFFQWWtSdmdzT0RMaFMyMzhuK2UyOGZXQWRYMkE5WXk5dmNDeHgzUFY2eEs3?=
 =?utf-8?B?STlFaXhkMW5GRzllVndYYzB6Z3dvd0xNbFdGMjBMbkNCQTlHR1NlVFpOYTlG?=
 =?utf-8?B?aE5PTm84czh3aHpudnprVlRnRnlNcitsaEpKczhtVVRydzBIL1BkRm1vNjlZ?=
 =?utf-8?B?akdPZjl6ZUdNVEhORVdSN0RBa2JQSHRNUEVDZXhiLy9Xb0tmOStvUEFucm1F?=
 =?utf-8?B?YUljNmJoWkNXREwyMys0QThsbFdvNnZoV1NDaXhPL1VncXdWeTVyOXQzUmJa?=
 =?utf-8?B?bWtiK1V6K0RzZHRlSW16NmVZbGRYbFVVWDc1Mng2Q2c1ZGxtRmM2N3l2VFEy?=
 =?utf-8?B?WlliUlZIL0ZnaDlleUE1eTBnNG4xU1VNYW9xSVJDWmxrTUgzZU92U0c4S2hR?=
 =?utf-8?B?TXoyWHhYbklScUplR3RuTDYwMmNrWDVxVUgxcVQ4SW1tYWliRzJZZmE1RFNl?=
 =?utf-8?B?OWJWbHdFRlREbjRjMTM1cUw0OVNjTWorbXpwTjFyZmJ4cU5yOU51L2JMOEJN?=
 =?utf-8?B?MWlQNjI5WkpVY2tkaW1xbnNDM1JrOWZzTlgwQWozVndZdVA4TmtEY2RPcDhx?=
 =?utf-8?B?Y2Y4UGdmWmNzMkREenU1R2o4UzdnNjVQd3NmYU5MTGRCVEFSNXNqK3dMa0lM?=
 =?utf-8?B?bk5xRVVGUnMxdWRNU0tNS1JhREVVYk9pREVQa1g4NjdLTFVnTW1xZ2tFdEkw?=
 =?utf-8?B?S2NMQTZ6S2JHcFUvWDFtYXVuVmhia1hGZkhKR0ZBNCtveHJneTBxc1JkeVFX?=
 =?utf-8?B?bzdhdDFaNlg4MTJXMFVWdEhLd05NcW1PVEE5QVVlbHJIZnZJdC9EcUx6OWt3?=
 =?utf-8?B?czVCemVGRGYvOEdtQVdMYWY2d3VwZnA0RmxmVGhNSnJzeHhwTU1DUkVWUnYv?=
 =?utf-8?B?TW5oeVcvYm9MbXV3M3hPUVRNS1NWTDdjZlNvSzdKMXVPZCtLSFhnRm5LamNq?=
 =?utf-8?B?VERpeEEzT3g3eTg0TDQzUmFmT2FqRnhjOGVJRDh3eXBKeEZSdHNYME9nZk5Z?=
 =?utf-8?B?Sy9wV09HY2RVdDd5bDZ4UUt4UDVEMkFvNy9sVjFkaDhGUjlQWjNEcEpUYXgr?=
 =?utf-8?B?V2pBT3ZVMnV5YzZFSGM3R1M0VnkrWU5kK1V0dUxXeGl3SzVrR21ScnRFQkov?=
 =?utf-8?B?M1VSallucEVzcE53dWpZMWlwbWM5bTl3Q2lmcTJaQlNpOFlqaGVaQmpLTjZK?=
 =?utf-8?B?N3pRYlpUSzFzU0I5Mk90eWFGMkpwRDByUjRJaDNYdXlJQ3Z3aVE0ZmxQTXlB?=
 =?utf-8?B?RjFmaG5HTk55UzE0UFZPNTlteEJTdnRkR2loT3dYQXc3d3FoNVdVVDBnQlhW?=
 =?utf-8?B?VkNsQ1FpaEhhM3VkYVl5TGNkOTNnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a11a69-56fe-411e-931b-08de32afcd36
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 21:06:17.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDa2uXVo4Fd7x0EPjStLIiKDcImvGhkwQDNLVsNDZww1Neeoi+Insi/mjf/XXvGH2lUu0/0YPME/zQMykqBZbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

Hi Trond,

On 03/12/2025 16:23, Trond Myklebust wrote:
> Hi Jon,
> 
> On Wed, 2025-12-03 at 15:56 +0000, Jon Hunter wrote:
>>
>> On 02/12/2025 16:01, Jon Hunter wrote:
>>> Hi Anna,
>>>
>>> On 04/11/2025 15:06, Anna Schumaker wrote:
>>>> From: Anna Schumaker <anna.schumaker@oracle.com>
>>>>
>>>> This patch adds a new flag: NFS_INO_REQ_DIR_DELEG to signal that
>>>> a
>>>> directory wants to request a directory delegation the next time
>>>> it does
>>>> a GETATTR. I have the client request a directory delegation when
>>>> doing
>>>> an access, create, or unlink call since these calls indicate that
>>>> a user
>>>> is working with a directory.
>>>>
>>>> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
>>>
>>>
>>> We use NFS for boot testing our boards and once this commit landed
>>> in -
>>> next a lot of them, but no all, started failing to boot. Bisect is
>>> pointing to this change.
>>>
>>> We have a custom init script that runs to mount the rootfs and I
>>> see
>>> that it displays ...
>>>
>>> [   10.238091] Run /init as init process
>>> [   10.266026] ERROR: mounting debugfs fail...
>>> [   10.286535] Root device found: nfs
>>> [   10.300342] Ethernet interface: eth0
>>> [   10.313920] IP Address: 192.168.99.2
>>> [   10.382738] Rootfs mounted over nfs
>>> [   10.416010] Switching from initrd to actual rootfs
>>
>> It appears that there are multiple boot issues on -next at the moment
>> and the above it not the relevant part for this particular issue.
>> Looking further at the logs I am seeing the following errors which
>> are related to this change ...
>>
>> [   11.100334] systemd[1]: Failed to open directory
>> /etc/systemd/system, ignoring: Unknown error 524
>> [   11.119234] systemd[1]: Failed to open directory
>> /lib/systemd/system, ignoring: Unknown error 524
>> [   11.143487] systemd[1]: Failed to load default target: No such
>> file or directory
>> [   11.158620] systemd[1]: Trying to load rescue target...
>> [   11.169388] systemd[1]: Failed to load rescue target: No such file
>> or directory
>> [   11.188856] systemd[1]: Freezing execution.
>>
>> Thanks
>> Jon
> 
> Does the following patch fix it for you?
> 
> 8<---------------------------------------------
>  From 849bdbd3a2136a86c809ce6a7fa6ae30e9f0728a Mon Sep 17 00:00:00 2001
> Message-ID: <849bdbd3a2136a86c809ce6a7fa6ae30e9f0728a.1764778907.git.trond.myklebust@hammerspace.com>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Wed, 3 Dec 2025 11:17:25 -0500
> Subject: [PATCH] NFSv4: Handle NFS4ERR_NOTSUPP errors for directory
>   delegations
> 
> The error NFS4ERR_NOTSUPP will be returned for operations that are
> legal, but not supported by the server.
> 
> Fixes: 156b09482933 ("NFS: Request a directory delegation on ACCESS, CREATE, and UNLINK")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/nfs4proc.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index c53ddb185aa3..ec1ce593dea2 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4533,12 +4533,17 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
>   	status = nfs4_do_call_sync(server->client, server, &msg,
>   				   &args.seq_args, &res.seq_res, task_flags);
>   	if (args.get_dir_deleg) {
> -		if (status == -EOPNOTSUPP) {
> +		switch (status) {
> +		case 0:
> +			if (gdd_res.status != GDD4_OK)
> +				break;
> +			status = nfs_inode_set_delegation(
> +				inode, current_cred(), FMODE_READ,
> +				&gdd_res.deleg, 0, NFS4_OPEN_DELEGATE_READ);
> +			break;
> +		case -ENOTSUPP:
> +		case -EOPNOTSUPP:
>   			server->caps &= ~NFS_CAP_DIR_DELEG;
> -		} else if (status == 0 && gdd_res.status == GDD4_OK) {
> -			status = nfs_inode_set_delegation(inode, current_cred(),
> -							  FMODE_READ, &gdd_res.deleg,
> -							  0, NFS4_OPEN_DELEGATE_READ);
>   		}
>   	}
>   	return status;
> @@ -4554,10 +4559,14 @@ int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
>   	do {
>   		err = _nfs4_proc_getattr(server, fhandle, fattr, inode);
>   		trace_nfs4_getattr(server, fhandle, fattr, err);
> -		if (err == -EOPNOTSUPP)
> -			exception.retry = true;
> -		else
> +		switch (err) {
> +		default:
>   			err = nfs4_handle_exception(server, err, &exception);
> +			break;
> +		case -ENOTSUPP:
> +		case -EOPNOTSUPP:
> +			exception.retry = true;
> +		}
>   	} while (exception.retry);
>   	return err;
>   }

Yes that does appear to fix it thanks!

Cheers
Jon

-- 
nvpublic


