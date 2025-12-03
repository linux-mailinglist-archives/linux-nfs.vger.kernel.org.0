Return-Path: <linux-nfs+bounces-16880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090CC9FE2E
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 17:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6336305E10D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5805A341044;
	Wed,  3 Dec 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QL2I6v+s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF912F90CA;
	Wed,  3 Dec 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777425; cv=fail; b=IEWPfTHhv2V9sMHQl93CPAz2AV+uGt41j3py7CczKaCNQleCB8a40Ml42BGNDoPAQtA7+VqggR/Jc4+aJnMG1jS1dYg1u3d4w7gnVeSEnvxnP2QpAsKGxcTsuOEzseu+1IzkpbXGopKu5BfqeAMMLNjsCNq0P6iZrrEllpBiiog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777425; c=relaxed/simple;
	bh=UKCU4KjvM3q40YaouxiBc46FEOnbDa1ZA2myjivhyzY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kx8P3w1snv3G1iW14b62JWHE79APGSCLG8WUqyTUH3SlEsZh6DcAEO2imiPCs+c2HBgdpO8n/7iSI3Qe0OdLdPHDPCkRl7lA08oIiqDc2r+1l11FihjAPff7f4a9ajuuFeIQEZfU88qZwBLia3eHa2yqnCDXLF8TLPiMNYCfI6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QL2I6v+s; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvClNQPGIe2uF+njUJw3MORtm+sX0ls9JkzZp2JiNrLr8wrYRBfNWOuxS63NGYp0CMwntMvK75M6Ka36w+jSwvNkk7bVH7ldYke0EsHaVmQf7i4sHprsj6M0OO3DPQYREOls6X2Q77AO5IUK2rtOhAuDSOVGRtDKmuPeEmaLctPvKAmL2pVRW6EYH8BeVAMdH7J7BiKXy1L7zmJ3rhhOA3IcKifrhPZ/5YS4qI+PUeckDCVmig6woHvKcZpTPZmFmgUKCKfYxQr2kWUqu4bqGh+UIZq6jxsiv5gJQSzhp+zZzTEFYmNp3TibAiimNPdl7nSEPhyKACGPSnRkdMfu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgyb0Akb1kSwy0mFak7OFEZx0fBcnU5U6Dcu2zntTBk=;
 b=WRttzruGXb1DmIi9llOJ/xYjYPlK2JS39HPG5A3aQqETB4AZZdc6KUHMZ3pH2lsClftY8EgJT1tD6v4aEVJ/jEJuaCJZcgWtHOySX0pE8D4Qa14NePLcG77JSxKmd/nnV54fNJsoRSUzyjN97+p0SyG66HgV7ABUTQKXDZKifgnShELDxND1YjeSBzrAjZJT5FwNyJp9tcdGhn7qyl1vw6KY8wChp1wkfE5tgpaFwDc+IjRrpO6lhrrKz28pTTFgWt0JvGEvGeezgmVz02Yz6iIPviKZgVAnI+azwldJ7WZ6TivTKEuU0v9QQAWsT4/N22eQjN8rx+eVH7snejOCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgyb0Akb1kSwy0mFak7OFEZx0fBcnU5U6Dcu2zntTBk=;
 b=QL2I6v+sfjg75MaaVchmCySEfznH7ytv2hH4BDL0A/WIiqRf1xY4RK0O5q4soQnsCVDH0mcF1cL/INzhu2UktlYE7tadKNdOnhguW2J73PYyzK3+JSfo4i4+sHOmqHAFC5TH0l1TKk5z1yHLK8fRzjRWBzrzSR6e3S1lJkVQIer+JwxxG6mvY5lxqxogjVIP6mQZbaRNyaBXzqVjBmwK36sD1az/JNBM9xC85AaJU0bpVfjqOJtwPKpN4aRLGi7uchEDjye8pQOWUPvsVbKm7YroH1jy6k6aE3AOEzoAlIpqLui9fk+zycyg+sficeJAxWdaMxddRSXOE5AmHpHBeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA1PR12MB999110.namprd12.prod.outlook.com (2603:10b6:806:4a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 15:57:01 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 15:57:00 +0000
Message-ID: <bfe61da1-3b52-49a4-844d-6f39d7ca4e9d@nvidia.com>
Date: Wed, 3 Dec 2025 15:56:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] NFS: Request a directory delegation on ACCESS,
 CREATE, and UNLINK
From: Jon Hunter <jonathanh@nvidia.com>
To: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 trond.myklebust@hammerspace.com
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251104150645.719865-1-anna@kernel.org>
 <20251104150645.719865-3-anna@kernel.org>
 <4f5da6d9-ee72-4045-8fe1-c5eacedb4660@nvidia.com>
Content-Language: en-US
In-Reply-To: <4f5da6d9-ee72-4045-8fe1-c5eacedb4660@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0293.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::11) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA1PR12MB999110:EE_
X-MS-Office365-Filtering-Correlation-Id: f75c5fd3-a4e5-4d57-b1c9-08de32849848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UC9JRVNYUG56T1JRZURTdURmTEVVbno4dm5mZE9JUXNYZkVlMmZGOFp4WFpk?=
 =?utf-8?B?RTUvRGNoYUZ4T1lMZGVYSW5WcVYwUnJqWDJuaGlOcGRaYjNNcnRtL0JmUSsx?=
 =?utf-8?B?UGNWNHdMeVRjV3NFNnRXR0o0OFdzL1NKV0FadzZxMENUbWpHYXQ0aWUzYmhV?=
 =?utf-8?B?K0YramoxR3JzaDBFQjBPamdFcktOdzBlMGUrcFRJYWY3bWkxVFZxWGNZZVNF?=
 =?utf-8?B?T1NRTkcyUTBQN3JiRDlvZ0U5bTB2VTNXRlBXK2F3ZWVuZUduSW44ZlRhdW1r?=
 =?utf-8?B?Q3YxOVlNY0RMck5YTDhhN0ZhRDhTM3JwMjMrcXMycWZZYWxoNXlyUjZHNFh0?=
 =?utf-8?B?aVIyUTBkVXZWTnFGUW15WHZtM0w3eG82TWZ4NXBLckZPQ2J2Q0REWXlOOGEr?=
 =?utf-8?B?Skx1YUVoYkRIUWsxdDdoYjBWU1pQd2NLT25icC9maU5OUXBFdDNsTlZ1MEt0?=
 =?utf-8?B?WjAwMktpWVE1ZTFTQW40cFlySW91ZTFYYnREVzZ3REtBaktscCtHWkgzc1BM?=
 =?utf-8?B?bjFEWUdjcGtDTERpSC9nSGVrT0F0QVB3dFIrVWljT0swUW9FcTUzbnJIMXFl?=
 =?utf-8?B?MzJPMXdQL1ZYaGFOUWZWdklQZEtHbEQzNmNUL05WSXJ0ckFRbjJrellldUV4?=
 =?utf-8?B?amh0MXk1UEdkbUZJUGNQT21UbG1wS2swZWVMUGEzQXNXUFkvaHY0SUgveEtp?=
 =?utf-8?B?Sms4UENuRVJTU3dUZXhGTFdBZ2FxUVI4NFBYVHdpL1BvYTVieHhtYWFkT0lk?=
 =?utf-8?B?SGt3MFVtZWt2WEVZbSt0VUhGVm1QSzBQVkg3T3BHVWM5V0hqekdpM2hWdVVq?=
 =?utf-8?B?L1pkZnpYa3BWT1JPT3JNY3JDblhhdE0wZ2xqbmtIY0M3VVczRGJoQmxZU1hy?=
 =?utf-8?B?QW9xcUNnL1lFWGZUT3BBcURHRWxNeVJRTFFVdGlSV2M2YnRjdGRqVkxYZVN5?=
 =?utf-8?B?dHVqOVRrNHhxVDV3TXU4RklGNktCOXNncm0wSUhVK21Gamw5RHNlNHhNUkxp?=
 =?utf-8?B?bUxvUUlCcTdyb2xqQjdEWTFkaE51Z0lwQWdzQlVXVHBnSE9pZjZhbTlrdzJx?=
 =?utf-8?B?bmdmdUh5RHJaNFp4RDNudlZtamZRaTNCelNoNGRtdDJwUkRTbnFVYW5mQzB4?=
 =?utf-8?B?ZjVWaVM2QmhzWlk1WEF0YzlkdGtsMUVqbWhWdkxTbHFyY2VlMXliTW9wcTFu?=
 =?utf-8?B?WkViQjlVenBzV3VYUGxZSHYwMzUzRjdBYUZiQ2pDRHFVaE1JbDZDQ0FKWTN1?=
 =?utf-8?B?VitEQThod2ZpQW5ETHVTc2Y0bjd5SUt0bFpJSzB1dTRuZ0VQamZzRVI5QjlZ?=
 =?utf-8?B?RnUzMEpneWhCY00xbkpobndwcERtQnkwSnp6WTBzUEdRekxDRnVGb0N0ejUz?=
 =?utf-8?B?cmF2QVNuRU14L205Nm9ZbzFsdlhxdm1KcXl4Q05HUjZib3l6Zks2cms4ZDlE?=
 =?utf-8?B?ektEN3hhVUdwNGFUd3NxNTl0a0lMZ3A3Ky9xUjgyZEdWMS9nUjJCbi8wbXU5?=
 =?utf-8?B?aUp4dnczRDNFNGFFeXBndlhkc3YvR1NOVkV2bWNIbURhVWh2OEtSUVlGTVRY?=
 =?utf-8?B?eEw4Vmw5TnZ2MDhyR0IrM2Zjb21oeXk1bHFDSjFoU0dISDZIS0lTM3p4cVgy?=
 =?utf-8?B?aU5LOE5kaW5YeXlsZWx6VzJLdUhtYjBkYmMxNktQYmlzODBnQ0tkU2pWelN4?=
 =?utf-8?B?Vnh2eGNhUk9NVUMyaW5TbjBxWCtCUlhoQVdPQmJYV3l4a2o5WnJCWVQrTWRa?=
 =?utf-8?B?d1BNTlgzelVRaUg3VU5CUncwa09OQnd5dTc0bTMrY1haaldyZVIweU5wcUda?=
 =?utf-8?B?ZnUva2cxUzJXMHl2ZGd5U2RSdWVUb1JDMyt3bEZLaHVGbHlUcWNHckZxOUEw?=
 =?utf-8?B?b2NQYUNIdytGZGl6cGVjRERtUElEVXRnTGFWWmc2VE50TDhCTjZZTTBydU11?=
 =?utf-8?Q?J+KM3UDtrUTbPy+5I/tDPerM8Cp6sMTM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVduRTcwSDY5NkMrZldmZlUzZDNsMlRoYmVrMFRFR3lKWWNVRDNVU3FMSjNR?=
 =?utf-8?B?T0RES1NENDBNRzJzTnRISjh5TlE4TVQrY3F3WTBhVlQvbGh4OW4yVXJkUllU?=
 =?utf-8?B?VDNzNVZyZ0RjeCtYQ3JNVzkvdU9RdVY0N0lySHFtVVZEUUJEVk1tb2swWWVB?=
 =?utf-8?B?RlIyeW1DRjE4NFMrNjZpVGU5R0QvVER5OHdydnJtU1ZWdmZiQjFCOXBlc3A4?=
 =?utf-8?B?eHZpL0RqMEs4aEk2Wk96S1JIU203NXEwb3lGK3k5M3pib0NzaWgwc2FZZU5p?=
 =?utf-8?B?ZTZtYTZ1d2VmZ0dPVytGZTNaSUpPdXNyV2Q2RlBNaWFSUGk3bXovajR6ZVl3?=
 =?utf-8?B?SjVpMHNoN0tmMktQTlRNekFpdWt4QmNRbEJMbXJwWGJlVDAvaDJoZXNpUmFS?=
 =?utf-8?B?Sk43S2gyYkRlUWhWdTdqT1lxeUdsaHNQb0dHbE1EV09zVUxubllXOFBxMWRv?=
 =?utf-8?B?K215cC9UOHFSODlUMXBZc0xOK1FzRzU0b21NRU8yQXExc252ZTJCTm9RSW51?=
 =?utf-8?B?NHhabFB6d2hDcFZTVXRtL0hmSnNGN1BPbXZER1RMejRsQ2s0OVZ1OVJSMkpm?=
 =?utf-8?B?YTFndWdvWkhJZzNvQ1BRb3gyTjNWVXQ2N2lVYlpQT05YSXlXWmtvU0kzcjNz?=
 =?utf-8?B?V3FtbzNuOUJkWmk3NWhyanc2Znl6bHdWRHEzLzV6TDhxdVIyK05pWEoxbmVJ?=
 =?utf-8?B?Y3pUck5YREF2VDlsNnY1ZE40Q1ZXYkJPWHNjeitrNjg1NThwVmY4WUVGdHI0?=
 =?utf-8?B?QVQ5cDVXY282VE5lcGQ4OEVCeVBFTHphcWFqY1hoQ1VNOHlsS25hNTNZWnV2?=
 =?utf-8?B?Wi9pUWMwUzduS0Q4WSt2c3lJNno5SUdMS1p1dW1ZRzRiYkVNNFJPOFhaS3dU?=
 =?utf-8?B?VWxzMytRMFF3OHM1OUhySDRXbXZjbnUwR3NyZDhSWUNLM3grVi9rZFQwYk5l?=
 =?utf-8?B?OVZIeXRRZUc1eDNQeEtvd2NWZHpvY3k3Z1pkbkFkL0RhZTBJdnVhOUM2TzRU?=
 =?utf-8?B?djBqTFNHWHJIYjdxalUrMGZrSmtrb2tkaFFUek1OMXRYTWVEbFhtZENQTXM4?=
 =?utf-8?B?VUJUUTM3Y2QxK0pKTFVzOUxqR3NXRHM0SDU2VDJ6THk0a1psZWJlek4xL1dp?=
 =?utf-8?B?bThRaDgxcWg5bmpKaHFpTnQwUmZOcjlCakx1cm14K0Zpa0s5am8vbzVoZnlr?=
 =?utf-8?B?V25JUEx6MVZ4eE90SW56VythZnFkeVJlZGFGWjJwQlpETW8raVVjUFFadEIv?=
 =?utf-8?B?bVhCSzlZem1keFJqM2VGbUF2RWFDbm5wemZUM3lMUHhCWm0vK3NpRW5WTWMx?=
 =?utf-8?B?ZTlwRTA1MFJvcFdPWW42T0tYSWdXYW16bGc2cGx2NHBXYzRLYjh3bWl0TlhR?=
 =?utf-8?B?VTVUVWcvdTdhM1kvaFdXUVJkNU9MTml1dllOUEdDcFVmb3JMa3I4ME9HOUtz?=
 =?utf-8?B?WStiSkk4RDUwK04vdDBzTkZFdWEzbktwb3k4S1RhaEthWVdBaFRZT0VtTWpT?=
 =?utf-8?B?MUFHcjlqcko2OFRvUmpFNDNHK293eDA0em56NkVIQmlBdU14ZkNuSW9ocm1K?=
 =?utf-8?B?MWx5aldLNTVRbnZRbU5BNkRwd0llaXllazlZZ2FqSFIrYjRKK2l4VVJUdDRi?=
 =?utf-8?B?ZzVPMEpUcDBHbjhwelZvQzBDUVdmWlBLUnhxQnZrSTd6NFJZdXUwSFRtUm9v?=
 =?utf-8?B?YXJRSGNTK2VwazMyZEJhKzkvZUF3NjJPcXZmYnJQOFZzY25XWUNLZ2ZPZFFu?=
 =?utf-8?B?ZlFLVE1LMlJqSlEvNkp2NlJaQWk2QUM5QkxnMGE1aWtTYnFiVW1LT3JyZDRh?=
 =?utf-8?B?VGEydXFYY2IzeFNwUlpqN2dTRjlWRm8wT2xNWjNyL2Z3YS81aEo2K3ZseUQ1?=
 =?utf-8?B?ZmI5cmJjRUgvTGpocjFhYzV1UlJCZS83czBrUytkTVh1UXY2N2t4YnB2dzRP?=
 =?utf-8?B?ZWhLNWdZSFdDWGVmWWVHSU5kZ0l0eE92TW1DREFSZWt1ZVlEYmUvSzVHMzE2?=
 =?utf-8?B?b1liVzVDbzJBZ21oMVZ4RmcwUmNHMUY0cy9qczdMYUZETXhLaUJ0djJVVE9m?=
 =?utf-8?B?eUxpM1dLRGJQOTRFRmZKZnlmdlpnZFc0RmF3cXQvaFRZOFdBaC9Oa2lCV2dM?=
 =?utf-8?B?SllESXZvNTJRdzNIR2NCVld1aXBRRGtIYlhoa0pSZTdBelM3K001UWFvREoy?=
 =?utf-8?B?WGlFZ3hUc0N5M3NnRW4vZE1Vb0YvUkRQM0tsTjJQTVpLdFBleEtxdFRsazRL?=
 =?utf-8?B?RjlkbGgvNHRwU0JhUUVUYlZEL1NRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75c5fd3-a4e5-4d57-b1c9-08de32849848
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 15:57:00.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJx5sWMzkI6te21Al2aP+p/wCXLdG0ukPyBpzksRoIfRWHg7h61rKMSJ+OzbRygRgJGxbBZVM6wiPQVpkQdqFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999110


On 02/12/2025 16:01, Jon Hunter wrote:
> Hi Anna,
> 
> On 04/11/2025 15:06, Anna Schumaker wrote:
>> From: Anna Schumaker <anna.schumaker@oracle.com>
>>
>> This patch adds a new flag: NFS_INO_REQ_DIR_DELEG to signal that a
>> directory wants to request a directory delegation the next time it does
>> a GETATTR. I have the client request a directory delegation when doing
>> an access, create, or unlink call since these calls indicate that a user
>> is working with a directory.
>>
>> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> 
> 
> We use NFS for boot testing our boards and once this commit landed in - 
> next a lot of them, but no all, started failing to boot. Bisect is 
> pointing to this change.
> 
> We have a custom init script that runs to mount the rootfs and I see 
> that it displays ...
> 
> [   10.238091] Run /init as init process
> [   10.266026] ERROR: mounting debugfs fail...
> [   10.286535] Root device found: nfs
> [   10.300342] Ethernet interface: eth0
> [   10.313920] IP Address: 192.168.99.2
> [   10.382738] Rootfs mounted over nfs
> [   10.416010] Switching from initrd to actual rootfs

It appears that there are multiple boot issues on -next at the moment
and the above it not the relevant part for this particular issue.
Looking further at the logs I am seeing the following errors which
are related to this change ...

[   11.100334] systemd[1]: Failed to open directory /etc/systemd/system, ignoring: Unknown error 524
[   11.119234] systemd[1]: Failed to open directory /lib/systemd/system, ignoring: Unknown error 524
[   11.143487] systemd[1]: Failed to load default target: No such file or directory
[   11.158620] systemd[1]: Trying to load rescue target...
[   11.169388] systemd[1]: Failed to load rescue target: No such file or directory
[   11.188856] systemd[1]: Freezing execution.

Thanks
Jon

-- 
nvpublic


