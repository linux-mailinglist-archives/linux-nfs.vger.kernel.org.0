Return-Path: <linux-nfs+bounces-17733-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69611D0E1D8
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 08:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E0A7300DB8A
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D91824BD;
	Sun, 11 Jan 2026 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OI0PEYKZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1792F2AD20
	for <linux-nfs@vger.kernel.org>; Sun, 11 Jan 2026 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768115002; cv=fail; b=gjUyHFnRUsUfTHMEsvQCye7Qvr42mPbtKINXddfxFOn/ycbWJFOmR+XlglHL9/fR/lGMasJiIy8ouuIBwraQYwC9R9iXOI+wDgQTd5pKpWI83TyERzu2h6q3Zgm+wBirEaicaicUiajh7Nqs0cYfzI3orExL2mmyhw5PLREFkDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768115002; c=relaxed/simple;
	bh=dRG1i3/QyhyNxkC3MTEiuO9eO7YWi8gjjISvxgojmzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n9ttmU9sEiT7z7SoREnldwitzH8Z5DJ49zkcMMATjsgV+3TCVkjg/NL2XjfmYvDpTghMtFqC6vpTOkXYH0MsdxQ5LkzjleLoXy7v7QeJmTPF71ZuPa1xFHSNmdIcAhhuZlJnnkKE61mKXrzj7PHWAeFISV0Yu9CUT/bUNdB6bXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OI0PEYKZ; arc=fail smtp.client-ip=52.101.52.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlmmfADthG1XepESVX8gqW2YcxYWdYpaWA3UCN42JIqoujgbSiiIfKFVacB7x4oICRkE6l/+r/xb7Gs7aAKaOMawF0Yb5vZuhk9LOQrsaXUSqL0b+EkvewDmESSZ7E9wm7pQHRDegwDQf703XssjlbVTeXNBl3YhXC6q1DpJOsGfSonutaeE19v10Zn5KAwqoMKNBYyr9HOOklm51iLVQMQCHQb1V6d+Dd49BECCSjVxTvsLcPRHJtSdh97TnJpDUZpxwUfzKi+aioXI+LVyfXc6rtVg1faKOA0TEGGPLAi9givHaDuwk8X5qpLIWV5ciooSA2o8ei3eGfGilSevGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvXtBdXUyPrNWBRD/bVSY2fhS1MAWETfbQ35BYLuobw=;
 b=EJBquHBi7yLJwje1E2UJ9vJiB2jb2V1j0bGME7AjKs6EAj8z3YzwkGxSK9pIsufTJsg93/t03EmLEU/eGCx/S4unFwnevBFwYLyQXOeaYV/Siq44oVxPqrCjrqD6GMnG5/vecmrJ0LHO5L/mLLlP2fJqk0gmby4ENuPunx1PV8MTrABxVqSqr5pQIIdcEFJO978W/1352yODfM2QhiXNKjLXWCfbAiXPbXRJY4FEud+oBoHP8sxuHCiLxPqzxuYg+Vna3r5zvaKtd88O9YTfNWhmJcjZu2H2clpBF9/2L1O/SB90vOTZK7+fAOc+Mh5NwtlSO2JjE1eA4yEAeAsWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvXtBdXUyPrNWBRD/bVSY2fhS1MAWETfbQ35BYLuobw=;
 b=OI0PEYKZfJB3okjOwXucV3wwHMDfudzOY8TADAGz+5zvACl7Ho1MEYxH8oKUvK1J6/1n9/7NoCzoVzDXU09WQ6j9PObOfHXttqeW7N283l/48nUnhMBjUMkPAMQ3GvUW6ovrXCl/jY+y8F+3zSsI7QKsDinf2qImmf6IX+Ben3/rxeo7dZp3/i0xrh3d+ioNisO+O053yZVrLdlnzjw9s1Y9TXRYd4AnuRoiGvZJQnZy5OV5DFHku6nQ1BU34maa/q4gy3KztUnyAGwuT03rEelVY8O7rdbqyq4ClcG/NNmao7sDA4IEuQKxrd7AjFSTkjSGLnnklFB4ZJMho2MqBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 07:03:18 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 07:03:18 +0000
Message-ID: <391d9e32-afef-4b1c-adf9-422204360c77@nvidia.com>
Date: Sun, 11 Jan 2026 09:03:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Possible regression after NFS eof page pollution fix (ext4
 checksum errors)
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linoy Ganti <lganti@nvidia.com>, Bar Friedman <bfriedman@nvidia.com>,
 linux-nfs@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
References: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
 <43278ef7e260f46de5a7130331f30e12b916f89a.camel@kernel.org>
 <3e7d4222-9326-4761-819f-114831919c80@nvidia.com>
 <d6419d6b1e24c2a704a44f6347bfcfa59fa195c2.camel@kernel.org>
 <211e07b8129353fbec59b44f4859ce22947f222b.camel@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <211e07b8129353fbec59b44f4859ce22947f222b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 812c71eb-c239-4f65-dcf3-08de50df7f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXN3MldtSUtmMy9JVWk4NU4yMWxFYStsM0RUamkwMTlmd0ZCNEFuMno5d2Fk?=
 =?utf-8?B?K0NLWDhSOEpDMlIyZTd2ZnFwakliZ2N3cXJvdG1pQU9JNTBqWUk5aDF1Q3dm?=
 =?utf-8?B?MHRqdGpGZzlPZ0oyVGorWkFYK0hNQVZkZE9tTEhQbUoyQkxITS9wNEFpZWxT?=
 =?utf-8?B?WTRwNzF0Q2I2cUdRQW5iakhzaVZkYThJL25qM3MxUmF2SGV4UmxobXN6K01m?=
 =?utf-8?B?TVFKNGFGQ1Uyb2RUUXY3U0QvYnVSd2tzMDc1TWI3NktQNEFVcW84V09YQngw?=
 =?utf-8?B?dWcreFp1M1c3MlZLUDE1Q1NLaHVSL2RrbVlvK29WRjJ6VTFZUlQzZmZ5T2xN?=
 =?utf-8?B?V2pyZFZrTVJucmhvRHptU1A0bkpwdm81aWc5bVkySUg4UHVJUERMRVpwVzht?=
 =?utf-8?B?QkhFeUNkTkMzMEpFRDFIWXppYlE1Q0lBSFBPMG5wN0RpKy9hSXNpVGt0OW5W?=
 =?utf-8?B?bTZGd2dzNW9abUZyOUxlcDF2ZzgwbGxreDdSRTg2NzdoVVpuQ1MwOWRUTU1y?=
 =?utf-8?B?ZVNpV1I2dUdsY3ppQnN4R3lVMkNUbkQ1TjhEc0NmVlJxaTQ3RjJWaTAyZTE4?=
 =?utf-8?B?VXFkK1EvTE4rdGJTS29Xbk43czRsVk1SRE9KUE1DSDVyclg1WE5VUEh0amZl?=
 =?utf-8?B?ZzA4UUtyTkxtYW0yS29yM0JsZ3BJb3luQjRlRDJ3VHhFVThTZDBONCtsaG5B?=
 =?utf-8?B?WDhJSHFwOGtTZE0wckpJeVRTNGxDSGlqVWs1OVVrVVdyd0h1cHU0TnB2VjNX?=
 =?utf-8?B?NGFLb0FkVnVURm1sQUhzT2gwZndtd3A3SG1ZQU9uRlZwYkpQem50bmNuN0V1?=
 =?utf-8?B?ZWZwUE04MGhXOFdndmsyN2lsUzJKa1M5NGs1Yy83RGpPelVFZ0dQZUdRUXAr?=
 =?utf-8?B?TXVrQ2xzanNDRTdWTjV3cUhrMVUwYWF0cGxSSEluZGhsTjYyYVlPekpCclJo?=
 =?utf-8?B?WWNNeDZ0NzdEOWpiSEtuaDU0L3NmSFNMNStnbktEWVpZKzBTeVZhOEVRZWhu?=
 =?utf-8?B?S3NudG5DcytyWGw2MkI0N2Z1Z0tkT0ZqZ0U2dVlBWDNrVlNrb1Jrejhpdm82?=
 =?utf-8?B?RUQ4elRSa2d1WStrWmRGY3ZrL0liSm9HSFZld3NyWkt0WFMzQlRjNFNxcnNE?=
 =?utf-8?B?L01kY1lZUGpaS0tQeklKK1J2OEFFcEFpaUEyVklHZUFWa2NUdEY0L09HTm1N?=
 =?utf-8?B?dGU5blNlc0JvRHFNYUZYSkR0V3VDN01LQ1VVaWltR216cGxZS01PSW5lRWRP?=
 =?utf-8?B?ZmxidmVIUEpwVjJkMDhTaDRzazFkNjJPazk2VElSblRmMWwzWEZ5TEtWUWFL?=
 =?utf-8?B?SEZQQjlZcVlqMUZNejlEQWtKS2NJcG96ekUvZTIvelFkOUlybXJGYTBPbUdR?=
 =?utf-8?B?OWpMYklNaVl5NzBSR3E4Y1RrZ3pHUXRlSG1kWDZYY21JT29HMXhPSGxVcHRL?=
 =?utf-8?B?NU1vZHVDT1UwRmR4czlHMlRyeEJ2aUQ1SVdoOVhObFVKaHJVS0VsenU1N3Rn?=
 =?utf-8?B?ZnRjZ3lkakk3cVFtTkZGU0ZmVWZaWVJLRDB5a2wrVG1TQ0NhM3FvYXR3RitF?=
 =?utf-8?B?RDhKeW5BaktQSUtYZ2huUFlsM3dJZDhiV2pQYUlEWWlHQ0hhL3VEZngzTUY1?=
 =?utf-8?B?MmVjaVg0WCtJcEFrYzZMN2IwRm9TbUw5WFlYejJLTXhwbWgvUDNXT0g2TWpk?=
 =?utf-8?B?c2RmZy9tY240STEzaFdLWnI4WThQY1pjaXpibTQ5QkEzeUVGNmhIc25JZjVG?=
 =?utf-8?B?d3FlbWtyRWtDSjk3NXBDSjZJdkRVYllEQjRjcGduWTUvQ0F1Uk1nRklsWkNy?=
 =?utf-8?B?ZzRqWmk4N3U5dFJZVXFMWndYL0FsdU1DQ2NkWUdtbjZINEtSSmU3YXduaTdp?=
 =?utf-8?B?MzNFS1JmRk14cHlyRU5pRDVyS3FzUElqcnl3eWk4SWo1ZGt4RG1Ld3dtMXdh?=
 =?utf-8?Q?pp2wSSQ9PyD/4RKdX4avMMfErzDiKkH3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVRUdENZQW9mVGxHaGh6MFVmZGxrbjdlbjhFWUQzN2dYLzBSaERVSnNPMzU1?=
 =?utf-8?B?WDBsQkw2KzFYV2JacExlenVWRFpOa0NuWWRDZ2tPWSswc2x6QzhqNi9nenZW?=
 =?utf-8?B?LzJOcSszQUlzbE1ycmZ5TXJiYXRCcHF3bE5lYmtsRitPZGc3RFZNblpIU2JE?=
 =?utf-8?B?S0wxcDFTZjZQRGRIRStRTmVxQm5sSktndWdwZTJFcUpvQ0d2SVJBMkNGL3du?=
 =?utf-8?B?RG5YVkMrV2Raa2xjWkNDTUxtcElJMm9nZkxTLzI2cTBlaDRkeHZEeEFuNytM?=
 =?utf-8?B?dGYvci83anVSdVNlL2xEbG9nUWYxVHVuYjlVQzk1NUJZNnlGeE1lQ2huNUU1?=
 =?utf-8?B?SlM4NG84cnJ3WkZSMjEwUHRRUjJLeFlQNlVvUkNhUDFGYzZVT3BjTndlcEwv?=
 =?utf-8?B?TU1YbURra0hsdEVPU1dSUVdFM2grV016UHlOMHBqSDBGTVlhTExxQ2JPcFVm?=
 =?utf-8?B?L1lzUlBrak5oL2w3eEpENDNpelgzRG8rbW51YlMybnJkWjI3VGxpbldQbW1G?=
 =?utf-8?B?K2lVVjd2V290RGdGRG9iTEZmNmo5N3RETmdtbFBqTmxGSHFYaWtDVmx2djBs?=
 =?utf-8?B?cnhNWGh5d1RSSkh4NXllbFdoOWNxTkw2R2grVkNOTU42am1ZbjROYjBVQzZv?=
 =?utf-8?B?SGRhb0l1SmZPcWpuSW03Z01xL1hPcEI2RTV4OHFvNS95ZEJHbEFrTWFRRWtk?=
 =?utf-8?B?N1ZDcnFoK2cxWlMzN2ROVkNSRWRVMllmMGFhTnV1MENCWmprcmxwMzFGTEtz?=
 =?utf-8?B?emVLZmg1QWtWb21HMC8wTjVhMmR2TWZzbVRMUmNyRUMxT3N1QjhHOERNTXhU?=
 =?utf-8?B?a3B4SEZFeXdoK3VEbVRqUjJKbG5ja0VMTjd3a2YxdHdHZlhmc2VwTFUyRXhh?=
 =?utf-8?B?SFI5OHlRN01iMytJb1dVODkrcjdGeStlVm12c1M5TmxIYjZpOE9veC9VQXZm?=
 =?utf-8?B?NjFVb1B5cWtZd1VrK2tDQjdtZnh5L0lBVnk2WEppcVVZN290ZlBzbm5EQ2Fs?=
 =?utf-8?B?eVRUTHRJU2JieGNiVjg0VzJTaDR5K2VzV0tUTU1GWnljNll2Wjcyd3BvUHpQ?=
 =?utf-8?B?ajZ0dG9RRmh2aHp4VkRWZW1YYVYrNitvNDNSQW0yY2t6bXpHWitmTzFiTUVX?=
 =?utf-8?B?QjhwTWRQV1ZGMDl2UTlhM2RKMW80SldMazRmRnpSeHFWUVNCQ3k0TVdBZEdy?=
 =?utf-8?B?L2Y5azZUWTVzZko5RW9vUDU1azRsd3FqbS9VWm1RNXBkZ01hQ0xCVGtHaWdv?=
 =?utf-8?B?NzRWb0NpRnoxaStaZlUzTFdtci9Gc0IwTVZsaEd1U04xSU9CZmN5aERTVU5a?=
 =?utf-8?B?MGU5cmJkVWpJeGV6TGV6eGpKK1lTTkRia0RzZ2UvbzhjYmVjL2pwVEF2eUVH?=
 =?utf-8?B?TityWmN2L2xVRSsxcnpLUjZkejRBYTFOQlJxbVpVN3lMVjZoc2dCODE3SUVr?=
 =?utf-8?B?RG5ycC9Idk1CejJ3OWhaRWJiVnJIcndTbjN6WTZrM1VjakE5RkRNNk5NbXlx?=
 =?utf-8?B?b0lUMTZwU2pLeE9aTllDdXBpRG1aRm9GQUdud0tReHlxVWllNUFGV3poRkdD?=
 =?utf-8?B?cStSVjd5Ly8zZHI0dllmUC9Zc2tRNHNYNndEKy9nL0crMmJmRW5pTVNnV2NW?=
 =?utf-8?B?SWw2Q3lYVzNsT1V1NU1saEZ4NGJRaCs3aHp2cEpvb1V1WGQ4QUpKdEY4TmFW?=
 =?utf-8?B?a2Q4bUFiVjBMZ0s5V1RQMFNyM0RlQ0VJVmUvQlNiM0NjREY5QlczMEs4aUUx?=
 =?utf-8?B?ZHd3RWl3VmtZWTZkc1p6ZmFDVWFaNVVzbFQ2WHpDcEl5OXB3b0pnWDk0ZkZY?=
 =?utf-8?B?eEo1S2NVUEJiZ0h3SCsvK3pqWDFCdGFWNm15MEtZeDNuNnZvNGNVako4RFVi?=
 =?utf-8?B?dGhkNGNjQkVkeTVCOGJrTDhUZ0xrTEtaN245UU5xTEs0ZGhTKzcrL2hhNDZv?=
 =?utf-8?B?UXBlc2lhNUVOSEw0NGZmRW5jL3M5aXVNanFkdVhMdDFlZE1jZ2ExT1ZuZ0k5?=
 =?utf-8?B?ellDcGt6dUlkSDJIZmlNaVg2T2dlZjRJaVZUbjVPN2dQQmRJUnFBNDFwdU5u?=
 =?utf-8?B?dDE3bEhEUUp5Wmh2WGJzaUZlR0RuVmlvdjNiK0dVL2JiR3lRZldTcit4Q0dK?=
 =?utf-8?B?dXY5dnhlMnY4MkFhYTg3dlRRMjh2VzM0QXR0VzlOZ3Jad2M3WWdNMUFWZGVl?=
 =?utf-8?B?VzhZRHEwZHkwVlkzaUNGand0eXF2RkMxWlBiNkhXdzFMdk5NVlpuSGliSWNi?=
 =?utf-8?B?ck13NzVEWjczU3N2VzdycnFXbDZuWmthNitOYkVaZW1jWEk4MDBBTnFTV2Jw?=
 =?utf-8?B?Sncra1U4azJnQkVjaVFkakdLTEp0V3pTbXpRdFU3eGUvUlFJdE5Rdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812c71eb-c239-4f65-dcf3-08de50df7f45
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 07:03:17.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ml369uKRjGbuXcggaPDmIaSk4LaK3los/mKzxY638GQih1VW/qCxrE2m8aQGdsnN8ym4bV5Y/1Xa0oEpO8MVCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

Hi Trond,

On 11/01/2026 2:24, Trond Myklebust wrote:
> Hi Mark,
> 
> On Mon, 2026-01-05 at 10:20 -0500, Trond Myklebust wrote:
>>
>> OK so if I'm understanding correctly, this is organised as ext4
>> partitions that are stored in qcow2 images that are again stored on a
>> NFSv4.2 partition.
>>
>> Do these qcow2 images have a file size that is fixed at creation
>> time,
>> or is the file size dynamic?

The file size is dynamic (with a fixed maximum of 35 GB).

>> Also, does changing the "discard" option from "unmap" to "ignore"
>> make
>> any difference to the outcome?

The discard option is already set to "ignore" in the image.
Do you want us to test the other options just to see if it makes
a difference?

> 
> I've been staring at this for several days now, and the only candidate
> for a bug in the NFS client that I can see is this one. Can you please
> check if the following patch helps?

Thanks for the patch, I'll let the team dealing with the issue know
and let them test the patch.
I'll update once I know anything.

Mark

> 
> Thanks
>   Trond
> 
> 8<------------------------------------------------------------------
> From 18acd9e2652d44bcb8a48bc4643ab006787b809a Mon Sep 17 00:00:00 2001
> Message-ID: <18acd9e2652d44bcb8a48bc4643ab006787b809a.1768091015.git.trond.myklebust@hammerspace.com>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Sat, 10 Jan 2026 18:53:34 -0500
> Subject: [PATCH] NFSv4.2: Fix size read races in fallocate and copy offload
> 
> If the pre-operation file size is read before locking the inode and
> quiescing O_DIRECT writes, then nfs_truncate_last_folio() might end up
> overwriting valid file data.
> 
> Fixes: b1817b18ff20 ("NFS: Protect against 'eof page pollution'")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/io.c        |  2 ++
>  fs/nfs/nfs42proc.c | 29 +++++++++++++++++++----------
>  2 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfs/io.c b/fs/nfs/io.c
> index d275b0a250bf..8337f0ae852d 100644
> --- a/fs/nfs/io.c
> +++ b/fs/nfs/io.c
> @@ -84,6 +84,7 @@ nfs_start_io_write(struct inode *inode)
>  		nfs_file_block_o_direct(NFS_I(inode));
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(nfs_start_io_write);
>  
>  /**
>   * nfs_end_io_write - declare that the buffered write operation is done
> @@ -97,6 +98,7 @@ nfs_end_io_write(struct inode *inode)
>  {
>  	up_write(&inode->i_rwsem);
>  }
> +EXPORT_SYMBOL_GPL(nfs_end_io_write);
>  
>  /* Call with exclusively locked inode->i_rwsem */
>  static void nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode)
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index d537fb0c230e..c08520828708 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -114,7 +114,6 @@ static int nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
>  	exception.inode = inode;
>  	exception.state = lock->open_context->state;
>  
> -	nfs_file_block_o_direct(NFS_I(inode));
>  	err = nfs_sync_inode(inode);
>  	if (err)
>  		goto out;
> @@ -138,13 +137,17 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
>  		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE],
>  	};
>  	struct inode *inode = file_inode(filep);
> -	loff_t oldsize = i_size_read(inode);
> +	loff_t oldsize;
>  	int err;
>  
>  	if (!nfs_server_capable(inode, NFS_CAP_ALLOCATE))
>  		return -EOPNOTSUPP;
>  
> -	inode_lock(inode);
> +	err = nfs_start_io_write(inode);
> +	if (err)
> +		return err;
> +
> +	oldsize = i_size_read(inode);
>  
>  	err = nfs42_proc_fallocate(&msg, filep, offset, len);
>  
> @@ -155,7 +158,7 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
>  		NFS_SERVER(inode)->caps &= ~(NFS_CAP_ALLOCATE |
>  					     NFS_CAP_ZERO_RANGE);
>  
> -	inode_unlock(inode);
> +	nfs_end_io_write(inode);
>  	return err;
>  }
>  
> @@ -170,7 +173,9 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
>  	if (!nfs_server_capable(inode, NFS_CAP_DEALLOCATE))
>  		return -EOPNOTSUPP;
>  
> -	inode_lock(inode);
> +	err = nfs_start_io_write(inode);
> +	if (err)
> +		return err;
>  
>  	err = nfs42_proc_fallocate(&msg, filep, offset, len);
>  	if (err == 0)
> @@ -179,7 +184,7 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
>  		NFS_SERVER(inode)->caps &= ~(NFS_CAP_DEALLOCATE |
>  					     NFS_CAP_ZERO_RANGE);
>  
> -	inode_unlock(inode);
> +	nfs_end_io_write(inode);
>  	return err;
>  }
>  
> @@ -189,14 +194,17 @@ int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
>  		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ZERO_RANGE],
>  	};
>  	struct inode *inode = file_inode(filep);
> -	loff_t oldsize = i_size_read(inode);
> +	loff_t oldsize;
>  	int err;
>  
>  	if (!nfs_server_capable(inode, NFS_CAP_ZERO_RANGE))
>  		return -EOPNOTSUPP;
>  
> -	inode_lock(inode);
> +	err = nfs_start_io_write(inode);
> +	if (err)
> +		return err;
>  
> +	oldsize = i_size_read(inode);
>  	err = nfs42_proc_fallocate(&msg, filep, offset, len);
>  	if (err == 0) {
>  		nfs_truncate_last_folio(inode->i_mapping, oldsize,
> @@ -205,7 +213,7 @@ int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
>  	} else if (err == -EOPNOTSUPP)
>  		NFS_SERVER(inode)->caps &= ~NFS_CAP_ZERO_RANGE;
>  
> -	inode_unlock(inode);
> +	nfs_end_io_write(inode);
>  	return err;
>  }
>  
> @@ -416,7 +424,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
>  	struct nfs_server *src_server = NFS_SERVER(src_inode);
>  	loff_t pos_src = args->src_pos;
>  	loff_t pos_dst = args->dst_pos;
> -	loff_t oldsize_dst = i_size_read(dst_inode);
> +	loff_t oldsize_dst;
>  	size_t count = args->count;
>  	ssize_t status;
>  
> @@ -461,6 +469,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
>  		&src_lock->open_context->state->flags);
>  	set_bit(NFS_CLNT_DST_SSC_COPY_STATE,
>  		&dst_lock->open_context->state->flags);
> +	oldsize_dst = i_size_read(dst_inode);
>  
>  	status = nfs4_call_sync(dst_server->client, dst_server, &msg,
>  				&args->seq_args, &res->seq_res, 0);


