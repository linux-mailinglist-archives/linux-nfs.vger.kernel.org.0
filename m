Return-Path: <linux-nfs+bounces-10042-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E45DA3149A
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 20:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451D3163F71
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B30253350;
	Tue, 11 Feb 2025 19:05:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021075.outbound.protection.outlook.com [52.101.57.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C6261594
	for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300755; cv=fail; b=Amaw7/y8kelDa66/YOACC/2LCTM0j+LQrkdht6e1SUkVI5JwVKeCXwbcfOPC12BCB7dsgpcLcRL+WaO7E8z9l8FwwDFO3qju23OciIqVc9EBj7UKnKNh4ecVNyiA6901e45oMPlDepbubU729V7Rw6kw/PLv7lJ+6Gfc55Nu9VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300755; c=relaxed/simple;
	bh=Z4nvlVojmcvId+to6v12KBJ9cnjQ8XACwjHpZ7076hc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGSk36pJ8D9kY9dU/rfOJsy99/zK2uzcmcKDqMA9BbPqpvYDt6yeHDZ7EGD5lN5IJgRhlyUu3iMtwERGkpf8tWXpean4z9yjP7h6TSbY0SuhQemmfwcGf87YgMZ8xDqgC4gHDRUf+ajpbXBVr1VDGXDQUzuzVUGIEk0Q8sagTIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.57.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upLCuwb1yzwB35DU0h4//jUQc0dZ9vhLIZmnGwYGbrySdsXcGG7WATrPUjlzYFJbdh0o1W8mi6XeLrEhLkKTbZxfOBwRYa4XezewgbAfBp/WZkPbMdi9ycZNgqUDnyCCX3dgKlJLLUP0B4C921+QbIs8Ywayv20E3z9b+jSfAK9oU0WXPLuK+eFb2/M66qPmn1OEOGh85r2x4nup+5ErHvqXuJD+uAk2EufWQuSQZfbWaEuz8DQlMG3wcjDWDeh7X5Ma7pph6m4QlzKbMD6Yj0EOKHh7COXXeGioJjsrPii5AUP+TPkVEM3I+v1MMsPzOO88VuCe+WSO4Ze14hMmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0JA7bFBPXoK2IJ5BlccxEeH/09YhC0Ql1uh8dhOnkc=;
 b=GdCr8DrEOQf3XbSn/aArFCfz6PQX0hlLlICmccLN/ixbBQUf69vHlR5mk4X7Jzu6+o6CaWst41ZWRTYlvCLd0UHGU+xFJJ8kkD/qYmB9euLz0kGmIlBfyor2WGZGPmrc82zJJp7nyX+TKkIrGEdjFANJvi+ODj38954hNszYxQD3csVJ2lWPVvYW+Nd7Rm/iFD4WKW8A6uwBonDsN96YIjZii+Iv/fN4mieacWzc52FVRgswL1CIB74VrdlHWrGEzg2KGhDB7tQIcnvqwNl5NVdU1hFccHSrZuPq/Jz9ct2i13f6XWrYv778MICZgIDa5ZzkpBC7SWdSJpvFXw2oJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 SJ2PR01MB8173.prod.exchangelabs.com (2603:10b6:a03:4f7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Tue, 11 Feb 2025 19:05:49 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 19:05:49 +0000
Message-ID: <d7c63c2e-460c-48c3-8eb5-48dbaeefd527@talpey.com>
Date: Tue, 11 Feb 2025 14:05:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: resizing slot tables for sessions
To: Rick Macklem <rick.macklem@gmail.com>,
 Trond Myklebust <trondmy@hammerspace.com>
Cc: "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <CAM5tNy4f9YyMhYRydudNkCqzVp5f8Np6N25NOT=-+TjJN2ewqg@mail.gmail.com>
 <884876492c56e76fd6fbb4c5c4fb08ee14de9fe1.camel@hammerspace.com>
 <CAM5tNy5yv1CkVc3z0dTJ_Fed9mP-ZBug1L39Jnau48s=OnSPvA@mail.gmail.com>
 <a9127b76-29f3-4782-ba9b-dff1ebf6f647@oracle.com>
 <e937d6d9-9d58-4c09-aeed-9b7e676d8799@talpey.com>
 <8e25d16b9d94179cd9214f46ca214012116ff7bd.camel@hammerspace.com>
 <CAM5tNy4wnvpinT58wOJtAObdadn-hffb5XqvTfmtFoG30sG7AA@mail.gmail.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <CAM5tNy4wnvpinT58wOJtAObdadn-hffb5XqvTfmtFoG30sG7AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN7PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:408:20::27) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|SJ2PR01MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b27f281-49ca-4563-6a24-08dd4acf189c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmpzNUh6M2FWZElJUEMzY3pKWm80c2lMTmNPeUFDekNSMkVSaFZWOU1HR0ov?=
 =?utf-8?B?UUdGRHBmSk1zLytQbGRaaTVHc3dVRUhIcFBQTW1WNzcvQWNvS0JBMG9CNFlq?=
 =?utf-8?B?UjdtSXJBVmd3M1ZDSm40ZFp5bDFxbGgrWkhwanptaGVwOFQxT2R0Q0VWZDRR?=
 =?utf-8?B?dGJTMm5zMlBoUUZMeGxmLzdTVk44Mi9vOEVMdFFZcElzdnlmMUkwTzJJRlFE?=
 =?utf-8?B?YjhDYWxDSDZEdS9nM2I0R25nVDMxQ294STVCTm1oY0RzcXBlU3RwaHJIaTI2?=
 =?utf-8?B?VWp3K0EyeVBwR2VsaURJcFJlTEkvTlVvVFRBK2x4MjhsU1F2dEVFNnVGN1li?=
 =?utf-8?B?MjZNWG9WUE91WVYxZVVKRGFCbU1WaGVHbDl0MlBzMWp4UFlIT1hyd3A4RFFm?=
 =?utf-8?B?RWw2WVo0T1BDR0xWUzUvQ3BMcXlpZUtmSTJ4b3dKUUdiS3ovOEQvTkZlRnpv?=
 =?utf-8?B?WHFnTTEvcVA3K29jN2V1SjRtM1UzS0NKZkZvTU9WcVhaYTVMdkNWbWJlY2tm?=
 =?utf-8?B?ajdzREp5eHJDeHlwVTRtUXRmcm1zN0hBd1d0VWY3czZQTjV6ejhlS1kySDRt?=
 =?utf-8?B?SkFpTm9hS0FqT3JlMXFXQ2IvVGV2SXJXZG9kcGxwZEo5ZzNPTTJ1a04rLytm?=
 =?utf-8?B?d3pTWldrQzhtQnBpTTRPSlVpQTRLREoxQnJCNmRwKzZnVXd3YkU4VUFEbnc4?=
 =?utf-8?B?RHA2STExZGc5SU5XdUFtcjVRcmRWUEZxSjVvNWszQlVxNU0wdlloQ2c0U1BY?=
 =?utf-8?B?c200cGhYNzZWVG9PRUl5MXRsalk1OGxaUDNFcFAxa2hPSlpaU3JwQlJWVitp?=
 =?utf-8?B?VU50V0tBdnRuSFZPT21QQ0RUSG5XWmd2eG5RUjlIOFVxUnNnYjNtRHJCT1Qx?=
 =?utf-8?B?b09wa3lzNm04TXh6NU9VZXJVM0hGYy9kdmI0NnV3LzNWY0FJQ2NNS3RDTURw?=
 =?utf-8?B?SGxRa0orcXUwSHJOV3NnTFhSdW5FNVJCMWVvQ0RmUElRODdqSzlHYjM4Vm1C?=
 =?utf-8?B?QXZ5bjkxMU5DVS9nY1hkNGVPVGNyQ1dveHJBbG5RNlFIQnJDUVFPN0ZZSnpv?=
 =?utf-8?B?N2xlR1hOd29UUkNyMGFxcUVOenJXaVU5R3ZDMTE3VU9zOUUrVklZT3FsNXh2?=
 =?utf-8?B?eml1VERxRkI1T0hsM3dGNnN3R2x0M2ovRytyWW1vNFhzWVlUcnNuM2xhOUpX?=
 =?utf-8?B?YTU0SGQvU2lwTkJXdmZhdGh2LzhWUmZsR2RvWlRGalUvMWp3MTFadzdrU1pD?=
 =?utf-8?B?b3lFcFF2bE1nWUhPVmRpWmc2dUY3ODdNM085NC8ydzJMTkU4VTFQVFhpZzNH?=
 =?utf-8?B?UGhkT0w3QVZ0aTZ5WVdEdFRCS1ViMW9OamMxYTZ3OCtXcDBvbUhrNEZJMEgr?=
 =?utf-8?B?U3pxVDFkeHB3U0oycENzcklpK0M3MEZFNCtvaHhselpWcVNZNHlVQ3RSRUl3?=
 =?utf-8?B?c1ZJNk4vTjZMTVFQdTkwaHFYUkRybUdPampNd0wwWmk1ekNRbFVFV2JjYm94?=
 =?utf-8?B?MFp4SHdEZEwwYzFiSmNGSWkwMTIzU1g1VTh6VHQ3a01PdlVuTlo2azVMcGZ4?=
 =?utf-8?B?Q0ZFdGUwYkYvRmY5TWpScjFSWHBWbURlVjh2aVZleG10Y0NSRnFnbTlIdmor?=
 =?utf-8?B?eTFrWlY5dmhmdXE4MWF5bnBYSmIrTU1sZUlzekE1VGxUQ2NXZkxrODQrL2M1?=
 =?utf-8?B?UGE0UzlHcnFaQmxOZSs1YjlCa2dVVm4xc0pqdFhYRmZadEsyYm9QZ3BhMU1j?=
 =?utf-8?B?WkRXQXo3Sk5sTU9XbG9Dd0VGZ3hXQXFkL1RKSFBJaWpTUHMxc1pETG1oNHJm?=
 =?utf-8?B?ajdVc3VTUFFOSDJjaDhSUzVLTE1ubDNBUHVKcXFRS3ViVWswTVlMVlpXa3ZN?=
 =?utf-8?Q?FJY6pNUEKK7yI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS9lWTJ6bG0xbFJwVnk3RDY2M2hUT1lFMDFQQTBtdDJlNkxNaDBwN2p6M3dm?=
 =?utf-8?B?R1M3blh5RzBON2kyVWhXM093dGQydklXUUdqbnV6Z09RMmt3eVRUT0dPMVJ1?=
 =?utf-8?B?b0tUOVJ2N3NaUWNDalcvbXRlSHNDQ2tUby9ab0k5SURBdUlBcUdUUWE4eHFa?=
 =?utf-8?B?d2RpU0NPaHRmUnBpdkxGdEJLMjlualFPaE9HRmQ2L1E2RTJaejRORXNrMm1F?=
 =?utf-8?B?WnZUdmVwajhPYmZlVDBBV2ZyYXlmMFVLemdLczh4ZWU4MFpTZVNwR0hiUVZY?=
 =?utf-8?B?REczdlNORWxrOEhwak1Mb3o0cC9JMFF6dWFrUmpML1FHYmQ5dkJ0YkNyZkRj?=
 =?utf-8?B?NGdBZnVYdyt2ajJ2a2dBNURuZkcrOWFPL0JWQjZuQ0JTdVVhTzI4dkF1RFd6?=
 =?utf-8?B?a0hUN20xL2w2Z2RWTExuak53WENKQlVMMkRhcFFLM2JBa1JDbTNnUVl2UEVL?=
 =?utf-8?B?VWV0c1NzaVhReGdJOGJWN1B4TEVjTU93ZnJLd3orMjh3OVU1M2tLZFRQcm94?=
 =?utf-8?B?Ui9XTDB5NDIzUW0rR2dEaG9zUGZxUzdwNS9jelpqMlFSbDk5ckYwSWtMN2tW?=
 =?utf-8?B?OTUvYWg2UVJNRnNVeWl3YXkvZHFON1NtNW1jQ2xlOTlxWVQySDNYNFNBUWIv?=
 =?utf-8?B?ZjQzeXVKd20rRWs5bFY0dkRrRmVpdFVuOWxldllBcnhsTG40b3d0TkY0WmRs?=
 =?utf-8?B?SVRWZzF1MzFSOVpFYy9KZFdoS2dzdHNHOVY0ajdzakRXU2kvMnFwN0ZqM0tt?=
 =?utf-8?B?VGUzWkFFaUJ6N1Z0dmQ0cElzVG9YL2RLQmZqS0wzVUhlaFVnQSsvRm84QXpv?=
 =?utf-8?B?cXQvL0JVNGNqSUJ0OFVLMDM4NmFDTEJkNkhObWpMd3pqS1J0clR6clFhcTRQ?=
 =?utf-8?B?NDRiVFlUOTVNQjFUWm5PUVRjTlNxeW5xMXEvYU1RaGxKTDltWG5nNDdKVjNF?=
 =?utf-8?B?OFBRNndTaHY3VHhocllwcVVTZFJCZkg3dUswL3V6TzlUOHJiZGR0d08vUVRh?=
 =?utf-8?B?SmJaRUlTUFFibVBKTXJnUDhnYmxacEdTTC9FVWhaM3BTbms5ZmlHaDNBdXFW?=
 =?utf-8?B?cDQwRWVkbmt2OGNheWpaTHRrZkdxRW1ScDNJYWlsTFgzcC9tbVJTL1JnZ0tz?=
 =?utf-8?B?SjRrQUtpVzBsczVHRFJmSW11MU5PYVFaeVpFVmlxbEFvN0lvRDN2K1dUNmR4?=
 =?utf-8?B?akhUUktUck5VYjladkFCdTEzbUxaYTlNSmEvTUxML2tqT3daVURmeDM5NmR4?=
 =?utf-8?B?c1UxeE9xc0hDdW5wbHJIYzllcVZ4M3pja2VRUDljbWttaDdWVnFFeXpuT25r?=
 =?utf-8?B?ZFMxU203c0hERDErbDN6UWZWUDFyQk1kOEJQUU1iYTBSZXdkRjcvUGw1eWFF?=
 =?utf-8?B?T1hvSzlMOVBKRTBFemNtZmRGMUJ0WVdkRzFQVWNrK0ZmQi9CcktaU3NuWWYv?=
 =?utf-8?B?ZWhoYnJPVHdmUElOZkZqNDNuSG4wMDRYeHkvaXdFL2dyVit4b1FzakxCeWlo?=
 =?utf-8?B?WHF1SWcvUkp0UXFSbHl3eXdvUXBHbDhXcW1mUnNNMFFvaHdIVzVjQVcxQVJJ?=
 =?utf-8?B?bW1XR0ZRelRFcm5BYlJZVWxWNmJWOUtTM1JHazVBb1Jxb3hxTW0yandQRWxX?=
 =?utf-8?B?VjViMnRRdlhuZnMrQmhzb2VKSXdnRk5PeCthRlIvenhoWmlqYkVLazAydGt4?=
 =?utf-8?B?dlJaYzlLMmxuZHd3dDFDb3gweUh3VkZGdC9XMFdPL3ZKOFJaTithbkhIVTRJ?=
 =?utf-8?B?Tzdnc1BXUjl0ZU5Yc1ZOVGxuREp1dkUyeXlGYUlBemoyeStDczM4blRvQnQr?=
 =?utf-8?B?MlZ2MHhIWFkvRFRNNDhwVW53bm85YU1WMjh3YUVCbDNSQk1TZExCNE8wYnpZ?=
 =?utf-8?B?cEdTeEVaZGEvU2FtWDVxMGhVTXZvTDVWQXA4UnJnTFR6WDBMa1FoMmRmUkYx?=
 =?utf-8?B?eEVQY3dNcEc1ajFVbkNWd0xjT1g1UDNCNnVlSEFHamZTMWlsZVFwVnZlQWc1?=
 =?utf-8?B?ZXZiZ2h6Y2xTRnpBNkJvSnc5UEMvaGwxWFVOWHB1M3dpMTBlTUwzZ3VwTi9C?=
 =?utf-8?B?ajd5SU1DSDdaeVJNTnhzcTU0RXV2MnhVbjJDRXVBT0luS212MytUZTYrYytN?=
 =?utf-8?Q?yKnE=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b27f281-49ca-4563-6a24-08dd4acf189c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:05:48.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4B81POXww/N0MUce80X3ad6PaPKLB4LfQQzIbhUKH6bguTCPEm1QiF30EjbfXgi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8173

On 2/11/2025 7:26 AM, Rick Macklem wrote:
> On Mon, Feb 10, 2025 at 11:11 AM Trond Myklebust
> <trondmy@hammerspace.com> wrote:
>>
>> On Mon, 2025-02-10 at 13:07 -0500, Tom Talpey wrote:
>>> On 2/10/2025 8:52 AM, Chuck Lever wrote:
>>>> On 2/9/25 8:34 PM, Rick Macklem wrote:
>>>>> On Sun, Feb 9, 2025 at 3:34 PM Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>>
>>>>>> On Sun, 2025-02-09 at 13:39 -0800, Rick Macklem wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I thought I'd post here instead of nfsv4@ietf.org since I
>>>>>>> think the Linux server has been implementing this recently.
>>>>>>>
>>>>>>> I am not interested in making the FreeBSD NFSv4.1/4.2
>>>>>>> server dynamically resize slot tables in sessions, but I do
>>>>>>> want to make sure the FreeBSD handles this case correctly.
>>>>>>>
>>>>>>> Here is what I believe is supposed to be done:
>>>>>>> For growing the slot table...
>>>>>>> - Server/replier sends SEQUENCE replies with both
>>>>>>>      sr_highest_slot and sr_target_highest_slot set to a
>>>>>>> larger value.
>>>>>>> --> The client can then use those slots with
>>>>>>>         sa_sequenceid set to 1 for the first SEQUENCE
>>>>>>> operation on
>>>>>>>         each of them.
>>>>>>>
>>>>>>> For shrinking the slot table...
>>>>>>> - Server/replier sends SEQUENCE replies with a smaller
>>>>>>>     value for sr_target_highest_slot.
>>>>>>>     - The server/replier waits for the client to do a SEQUENCE
>>>>>>>        operation on one of the slot(s) where the server has
>>>>>>> replied
>>>>>>>        with the smaller value for sr_target_highest_slot with
>>>>>>> a
>>>>>>>        sa_highest_slot value <= to the new smaller
>>>>>>>         sr_target_highest_slot
>>>>>>>        - Once this happens, the server/replier can set
>>>>>>> sr_highest_slot
>>>>>>>           to the lower value of sr_target_highest_slot and
>>>>>>> throw the
>>>>>>>            slot table entries above that value away.
>>>>>>> --> Once the client sees a reply with sr_target_highest_slot
>>>>>>> set
>>>>>>>         to the lower value, it should not do any additional
>>>>>>> SEQUENCE
>>>>>>>         operations with a sa_slotid > sr_target_highest_slot
>>>>>>>
>>>>>>> Does the above sound correct?
>>>>>>
>>>>>> The above captures the case where the server is adjusting using
>>>>>> OP_SEQUENCE. However there is another potential mode where the
>>>>>> server
>>>>>> sends out a CB_RECALL_SLOT.
>>>>> Ouch. I completely forgot about this one and I'll admit the
>>>>> FreeBSD client
>>>>> doesn't have it implemented.
>>>
>>> The client is free to refuse to return slots, but the penalty may be
>>> a forcible session disconnect.
>>>
>>> I agree you've captured the basics of the graceful-reduction
>>> scenario,
>>> but I do wonder if nconnect > 1 might impact the termination
>>> condition.
>>>
>>> Because nconnect may impact the ordering of request arrival at the
>>> server, it may be possible to have a timing window where one
>>> connection
>>> may signal a reduction while another connection's request is still
>>> outstanding?
>>
>> Not if the client is doing it right. It doesn't really matter which
>> connections were used, because the client is telling the server that "I
>> have now received all the replies I'm expecting from those slots".
>>
>> IOW: the client is supposed to wait to update the value of
>> sa_highest_slot in OP_SEQUENCE until it has actually received replies
>> for all RPC requests that were sent on the slot(s) being retired.
>> It shouldn't matter if there are duplicate requests or replies
>> outstanding since the client is expected to ignore those (and so the
>> server is indeed free to return NFS4ERR_BADSLOT if it has dropped the
>> cached reply).
>>
>> Now there is a danger if the server starts increasing the value of
>> sr_target_highest_slot before the client is done retiring slots. So
>> don't do that...
> Well, I think both you and Tom are correct, in a sense...
> Here is what RFC8881, sec. 2.10.6.1 says:
> 
>       The replier SHOULD retain the slots it wants to retire until the
>        requester sends a request with a highest_slotid less than or equal
>        to the replier's new enforced highest_slotid.
> 
> I think the above is at least misleading and maybe outright incorrect.
> So, if the above were considered "correctly done", I think Tom is right.

I think both Trond and I are right. :) In any event we're not disagreeing,
it's just thaty the client implementation needs to be careful.
If there are multiple forechannels, they all need to be taken
into consideration. The server doesn't have any protocol-specific
guarantee that the client has done so. Therefore it's on the client.

> I did the original post in part to see if others agreed that the server/replier
> must wait until it sees a SEQUENCE with sa_highest_slot <= the
> new sr_target_highest_slot on a slot where the new sr_target_highest_slot
> has been sent in a previous reply to SEQUENCE. (Without this additional
> requirement of "a slot where..." I think the SEQUENCE could be in an RPC
> that was generated before the client/requestor saw the new
> sr_target_highest_slot.
> 
> I might post about this on nfsv4@ietf.org, but I do not know if it could
> be changed as an errata?

I'm not sure it's wrong, but it could perhaps be clarified if there is
an ambiguity that leads to a flawed implementation. Adding informative
text can be a slippery slope however, it can lead to new ambiguities.
Either way, it's an IETF matter.

Tom.

> 
> Thanks for all the comments, rick
> 
> 
>>
>>>
>>> Tom.
>>>
>>>
>>>>>
>>>>> Just fyi, does the Linux server do this, or do I have some time
>>>>> to implement it?
>>>>
>>>> As far as I can tell, Linux NFSD does not yet implement
>>>> CB_RECALL_SLOT.
>>
>> No, but according to RFC 8881 Section 17, CB_RECALL_SLOT is labelled as
>> REQuired to implement if the client ever creates a back channel. So
>> other servers may expect it to be implemented.
>>
>>>>
>>>>
>>>>>> In the latter case, it is up to the client to send out enough
>>>>>> SEQUENCE
>>>>>> operations on the forward channel to implicitly acknowledges
>>>>>> the change
>>>>>> in slots using the sa_highestslot field (see RFC8881, Section
>>>>>> 20.8.3).
>>>>>>
>>>>>> If the client was completely idle when it received the
>>>>>> CB_RECALL_SLOT,
>>>>>> it should only need to send out 1 extra SEQUENCE op, but if
>>>>>> using RDMA,
>>>>>> then it has to keep pounding out "RDMA send" messages until the
>>>>>> RDMA
>>>>>> credit count has been brought down too.
>>
>> --
>> Trond Myklebust
>> Linux NFS client maintainer, Hammerspace
>> trond.myklebust@hammerspace.com
>>
>>
> 


