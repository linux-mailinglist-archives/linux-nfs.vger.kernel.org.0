Return-Path: <linux-nfs+bounces-9969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA1A2D844
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 20:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98567A36D8
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8454192593;
	Sat,  8 Feb 2025 19:18:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023131.outbound.protection.outlook.com [52.101.44.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8830241123;
	Sat,  8 Feb 2025 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739042307; cv=fail; b=m8UET3NUeMiGyEvta6vC2b7BG7T+2UfERpSW8mn9C4lYi/x+Ve+k8t9llPzy1GezqAVf+RiRyHJUXpxp0MRr8DegFuMF14OcFLtkR0MXKI1z//LQqnBP404ysI764ZlLiyyZdAFtmOfX6Yz3niRSNS2bXHVad4O0kxIVbaBE69s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739042307; c=relaxed/simple;
	bh=GFoqbgLvC8+hhcfmEYe122fkhyIPb5WQGN0bUwZvGCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AzPdxrWoXfYFrcoFu6Zz8bed9BNlFFhEEXo/ccBWeITvm0oRZJ6iyIFUC9uCN9B5IuwkktDxjiDN6pySvIriCKawrygIIsXat1vsy9q/bwz+PhJt25FZEEn/rK5jdXrfzS3vfCVmmFEkoLXhbGYSrybDB7LD/m28bd+qx0udug8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.44.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC58OiOcELIM5mrYGKDDwCJyInY4l3LzJJE0/WLDjY6NO5JBSbWOOjYewYAUJauGVm+OK08YSK9Iust3kNzva/ihzXJjF7+Dj/cmIe8xhRe9AUnYuZKjonlvsfJGuQmYX2x2NrgtEhPv47Cmf27yFeimxuztl+jepNoKivUTRFRK51wzRBt1yf2mHQCWPnK+jortDvtBJMZoV+SGN6KbrBJhTwXBAx27/T4zz6cZjXDqZQgLKv4cyaQXU5R8Sl9ftcT3bNaYuKhdEsLOtN+UWHzgVUfasjZVQQjCtbdrYtl+187mm9R1WaheEX6L8ShiwqFVR8w/KfCL1cVkus9a/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f38KI/qOPfyD4qLLvvk2Iwa/T+95kvzer/0O61f+bc=;
 b=HE1ICKiWQMVifef23Eb7m4xHfmeFt/tF/qq6aYL57PwEPhmi2pMzslKjtpTlutVWNYUo/DBDphjPxs230YgjznGBC6UF6zA89WcFR0h9qzFifEJrnD8UkPra46SVaDAbXTRsv5STXtmaXM9KTIWJEbJhJ6iciQrX1p0ykhIKNSzdiX0buYNGtPp490kNsx2bhrOT4iRYd8tkIw5Cj4x91RjBZfZzOgcfY6HgBRfZrQJPAR0j7fqXJmc69GSIX0Rg4N8ba7ay8U5C/Uzke490qNdXbLU4yKUq+RMx6jvzkz40EF3+6F14kNb2ordZC+P5niQ9Wlp2+hhYi7wFDSlmaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 LV2PR01MB7886.prod.exchangelabs.com (2603:10b6:408:14d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.6; Sat, 8 Feb 2025 19:18:22 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%6]) with mapi id 15.20.8445.005; Sat, 8 Feb 2025
 19:18:22 +0000
Message-ID: <29e739f1-2d85-40c2-a549-5ab9d71686b0@talpey.com>
Date: Sat, 8 Feb 2025 14:18:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] nfsd: handle CB_SEQUENCE NFS4ERR_SEQ_MISORDERED
 error better
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
 <20250207-nfsd-6-14-v5-6-f3b54fb60dc0@kernel.org>
 <28174296-129d-4459-aa23-a94bbf00d257@oracle.com>
 <3e4d14075482489cd010e4ea621c0bd368700e27.camel@kernel.org>
 <40970e33-4689-4623-a423-b346e739ba80@talpey.com>
 <66532654ca25280ffa30168a977601ba4a37aaab.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <66532654ca25280ffa30168a977601ba4a37aaab.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:208:32a::7) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|LV2PR01MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1528f3-357d-41f6-a37e-08dd48755a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHJEbHRIMkZxbjVVV1lFVVFhZGJ3bnRIL1d0LzNFaVRrb0V1UFhNODZaRzda?=
 =?utf-8?B?Q2h0eDBDM2IvYStCTkdvdkpLWk5TQUJjZ2RMcXRtODZpdG0rYXBUVW5mZzk5?=
 =?utf-8?B?ajRKUzR0dFFnV29Hd09HWjNWRllFamZhUXc0L2ZnSW9ZeUJzdGVDUHYrMlJa?=
 =?utf-8?B?TnM4VFVtTk50ZkhJS0NjWHFBbzVpSGZrcmpScE8zMUMwSGVyVHN6RmtUVzcw?=
 =?utf-8?B?UWtGOEFkZTZQZ3AyY01IWjM2WjYrRms1MnYzQzZ3NjB3TWJuUlNlMjZ6RC84?=
 =?utf-8?B?bThGK2duZnFOTlhYanduS1J6bHZTaWFJcVlYRDhld0FkMlIwcnRnR3phVWxt?=
 =?utf-8?B?di9sZlFoWEgzM3BjWWNwUnduQ0JtWVFGMndycnlyMDBmWkxSVHhxMkY2bDV1?=
 =?utf-8?B?SVVGQ0Iva053TlJPZVpKWEs4cVVFM1hJOEV1VVpXVmpYS0VnMnhqUUFjR2Jj?=
 =?utf-8?B?WWFjdnljc2N1QzlmdHVza1Q5ckVRYy93K1ErNHMrVk14MDAzQTdOZzJ2aXFC?=
 =?utf-8?B?a3g5TjkyUkp3SFFxK2RKcFI5NW1GSE9NeXVFcldTeXFJRmFZWmxZMUlrem5r?=
 =?utf-8?B?QWt3SnJKN3NyWjZ2ZHp4V3dIM0ttRlJ5K0tMaDh1YmtkZDhVKzVnaEVTRGpR?=
 =?utf-8?B?RC9ZVWs2NHR2UHNrU0RhL2RoV0hadjhISVJ5blNKOWhxZVpYVjVvUE5uV0xu?=
 =?utf-8?B?TCtsaVowa2RMV1JYZVNVZXBOd2lhM1dmYis1WDRxcmtQKzlLRGxiU1Biam1E?=
 =?utf-8?B?Y011OG90aFo1RWVBMnViRlMyVW4zOG9mdlFtUTdwQlFOWFFkMThKKzBJY0Ix?=
 =?utf-8?B?cFZ0SFR5TENiNE5ZcTVmSlRjM0hmZnVYN013R3FmZmJlNkcvNmV3TGl2dGZM?=
 =?utf-8?B?WWkwU0JYSFVKdUpPbE93dS9waGZTNksrQUJWa2lRNEtJRTZQZ3RMM0ZnSzdY?=
 =?utf-8?B?S1JleXlyZkNxdUcxdXdmc3JFYjFseERTRXJrQTFaUkRxZjBQcHR4UEJqRks4?=
 =?utf-8?B?cFQxOHU1K3N4VVkyOTN6Q1RNR2FDU255MytoMTN6Ty8rVXRjcnE2Zm12YXlk?=
 =?utf-8?B?UThRYTEzaGVRQyttbTZMNlRwWHl6ekFZT2hsZExNMnhWVTFxUHFHeklybU5K?=
 =?utf-8?B?YlNPekJhczlmSU1wYnlzRHJIbnE4TzBOYnlPUjNwcHFTcllacE9lY2ZjT1hq?=
 =?utf-8?B?eUx5cEtuUVRWSXRmSS85VlQyTnBZWTJxaCtQSnlNUmpRNTEzWkJnNzl0eDdu?=
 =?utf-8?B?SHV5R2VWTGx0RHlETUpZdEF1Syt4Y1d6SmtEU0ZCNmtjcTNlTHlQM0FhQlE2?=
 =?utf-8?B?a2tsVVUrb25aU1NwWFo4RTcybFcwSm5GZXpQSVNyNDZEOG96TExWRUtFUkhz?=
 =?utf-8?B?UFRHU0g4N1pMOGhxSkJWSUZReGprYktUNzUzd1ZObWVEdVc0bjNzdTRJVnU0?=
 =?utf-8?B?UXJrOHZVOVdldi9UMFB6NWRyWTJpcStPcUc1YUc2M2dSVE1kK3pESFlnRXhT?=
 =?utf-8?B?VHZlMCtxV3AxMTUvWWxLcVlBdUY3WEFKQlJqN0kyYkRlTjhkb2Nvb3NPTERQ?=
 =?utf-8?B?TE1qRU8zc1JoWlBmV3hrQStTWUpFbzRKS1lHWUIyUks0RHBIeWpURVcrVWNO?=
 =?utf-8?B?bjJkQlRkR01ZUmJmNkFxVjROSjNoMDZ1UFloRm1Sa1c3bnBWTEFSZUU5dGxu?=
 =?utf-8?B?bC9TNUNUTnVqNmM1TTJGR1p4MlhKTVI3ZzV3MFJVNnU2Tk5sbVJiakJ3djc3?=
 =?utf-8?B?S3ZJTVJ4NWZpZUcrSUxMaUtlV0dhd0xuandETWFhMEtaaGFNcCttMEZRTGpZ?=
 =?utf-8?B?dW02cHloZ2NwQ1JRZWgySHREMWJaNEdMT29PYnVQU3A2Rm5rTHczQWFxQUor?=
 =?utf-8?Q?HF7raHINmbPSa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21uZEVUSnloMzR6ZWJYM2hmK3doNkVFaFNrZEhZdm1ibTlldWxMNytNQWIr?=
 =?utf-8?B?ZGZtSU1ybDFDcGNNbWxKd0h3WVNDM1NnV3A0NWtObkNWR3p4SHdpV1M4WGFx?=
 =?utf-8?B?eUFEdUUzeHA4RVBmQ0VETGNyOVp2VjJ3MVI4eWRKYXBScFdyN25iTGVlS3Ra?=
 =?utf-8?B?UURic0IvOGVmN0wzazR0U2ZDWDVqcE9xQkFmWWtIRS95MzBvdWhiOGVWclVS?=
 =?utf-8?B?enZ1aUV4UklRVnFOd2o4blZjUVFIQ3A0Z0IyZGUyYU5tcEcrQXZaeU11T1Vi?=
 =?utf-8?B?bUh6YlJDV1Y4RlpxYUwzbWNnUkpNU3hhUUVmcTh5cU5yWVRtTWtwcnUyTzJX?=
 =?utf-8?B?S3RUanpxUTlPdDNrcTc1WTN2cGMvMFJ3OEVKTTd1b2VHRk1JdlB0dGluc1E3?=
 =?utf-8?B?WnIyTTJvd0p0eEJ3NVJXcGx4VUFIRVhHLy8wRzIrcVhnRkYraC82OHVSUkp2?=
 =?utf-8?B?eWNOWk02UElSck9IaG1kUXFkZzJPVkEyemdvbDhMT1IwLzdDWWpMKy9sS01F?=
 =?utf-8?B?RFE1U0NXVFFTY25VcCs2SjdQSDVUcGNCL0trVGpUOXlldXFiaTE5dmxLdlJX?=
 =?utf-8?B?V293SjlNT2FJYTBwaVhYUGFxU0lJUFNRZmZMQUtlWHc1ellBcUIveUhhR3V3?=
 =?utf-8?B?ZENpVzBwSUNlTXZyc2hRYWM2U2dpN1h5eU5VUm5iM3ZFUjB0cjU5d2F2dk9a?=
 =?utf-8?B?OGR5aFZ6N2VKQnp6RWtoMDUzVVY0d1dWR2hRVnBYanlNdXZpT2V3UGZNd05x?=
 =?utf-8?B?Szl5VlRYMHVMeG9oeVlFV2U5WXErd0N5ZUFvWTZrVlBTWGxRaVBJRE9kVjNj?=
 =?utf-8?B?VHN4WDdZWVZRTVREZ1VxUEM5Z2tOYmNkUGJwaG1DVzhNSWltUm9GSzhmL21B?=
 =?utf-8?B?cERaRkgybWVkb3c2eEp6bXYxZzhUM0w4YzhBMWdLRG1ncWpCamNwUmNMZGtK?=
 =?utf-8?B?eERIVDk4bFBFVnJ2UjI3MmYxakZkRk9YdjVHVFQxMWEzYUpoZzN3UnpuNDhi?=
 =?utf-8?B?T0xWaDdZdGZZcFMxK2laRWNIc2d6Q2ZaTXZtU1BqcWp0dWc4NndBc3ZFYmFT?=
 =?utf-8?B?US8rbVFCTXdaZFUwMEpzcy9wOEtUZzZxZHVYVEpXSWJ3Y2s4TTlKUmlidXJY?=
 =?utf-8?B?RkdiSDlrYWZ0VXFlZDlOVm43b0czYkc5R1NISlgvZWsvTzRqclM1QlpyRFYr?=
 =?utf-8?B?MW5RV1I2MDhUVDZpaC8xQ2Vmbks2TzlrMkhLZ2RkSGowSy9IMXRnZ1FONzFk?=
 =?utf-8?B?RnZaVm9WbjNMdE9lNERNeHNlY3djTmlXWjIzcEFLNmZPRVJ1em4wYmIzVFpF?=
 =?utf-8?B?bXNsYjN1ZWFqdjY1ZHA1YWdWWWtabGUxSnNudVJIOER0SzlRYWRqVmlaTGlY?=
 =?utf-8?B?QmtmbDhseC9tK0ZMTEpBSXdiSUVPbmIySTR4ZVVqMjNYK3VvYkwzVStXUldD?=
 =?utf-8?B?bWtKNnBXam5LY0tNWUU3MFBTMzY4aHRwbEJaR2U1K0h1NjIveTFROE54Y3Nt?=
 =?utf-8?B?cGVXbjBwY3VKYTBZeUpyaFNCMTNoRHFBNjE2M0VqSkdQdTVRTytEcjZXaks1?=
 =?utf-8?B?SnUxdWdTWXEwa2JoRTFFcWI0Y0ZFRHpmVGkrZ0FKczdWbVpDUDkzTWwwaFNa?=
 =?utf-8?B?SUVDblBDQTRuWEpwUWhWR0lEald6Nm5NSUVkbXJhWloyUC9rVkR5N1R4dkFx?=
 =?utf-8?B?Y1N1d2dOYStaL05tcHdwWFlkT2FwMjU5aGhpVVdsYnVEU3dOaE5XTU9GM0Nq?=
 =?utf-8?B?OGZWa1F4eVBxMUlrR2JPZkdZMVdlZ1V0b29MeTVkVHdYdHVpelpzdkZkZXll?=
 =?utf-8?B?K1c2YlpBRFZVci94UXY5N3g5WCt5cUZiZXF0bXpKS0haa3ZjWXhCdlNzS0Rq?=
 =?utf-8?B?eXM1SXBhdlRCUmlqRnR0b2NuU0dOZzhoeXBHWkVlY0h0WHNCd2R5WlkyVGpI?=
 =?utf-8?B?NmZqRnJUUGhMSEZ0bE5xZHdKNDFCTmphc0tNb2hRT2s2S0duY0hNaFpFSzJx?=
 =?utf-8?B?dHF3dVE5aG5jaXF1d2JrRzRiaWRNQzJDRThqVCswWFpibGpSQUFTRm5lVDlK?=
 =?utf-8?B?dmJCSyt5dTFHQk9KSkRzMVh6dkVoaTY3SEs2RklxaWM0aURMZ2ppTVNDMnB6?=
 =?utf-8?Q?8BjCcO5KkVdD+uxBBhojeqEyq?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1528f3-357d-41f6-a37e-08dd48755a7e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 19:18:22.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQW5flQgM3norFjT7kTKk+92yFa07NmYu1Dagn3SPrVuVFYDYKLpIrrtO8xn3U8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7886

On 2/8/2025 11:08 AM, Jeff Layton wrote:
> On Sat, 2025-02-08 at 13:40 -0500, Tom Talpey wrote:
>> On 2/8/2025 10:02 AM, Jeff Layton wrote:
>>> On Sat, 2025-02-08 at 12:01 -0500, Chuck Lever wrote:
>>>> On 2/7/25 4:53 PM, Jeff Layton wrote:
>>>>> For NFS4ERR_SEQ_MISORDERED, do one attempt with a seqid of 1, and then
>>>>> fall back to treating it like a BADSLOT if that fails.
>>>>>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>>    fs/nfsd/nfs4callback.c | 16 ++++++++++------
>>>>>    1 file changed, 10 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>> index 10067a34db3afff8d4e4383854ab9abd9767c2d6..d6e3e8bb2efabadda9f922318880e12e1cb2c23f 100644
>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>> @@ -1393,6 +1393,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>    			goto requeue;
>>>>>    		rpc_delay(task, 2 * HZ);
>>>>>    		return false;
>>>>> +	case -NFS4ERR_SEQ_MISORDERED:
>>>>> +		/*
>>>>> +		 * Reattempt once with seq_nr 1. If that fails, treat this
>>>>> +		 * like BADSLOT.
>>>>> +		 */
>>>>
>>>> Nit: this comment says exactly what the code says. If it were me, I'd
>>>> remove it. Is there a "why" statement that could be made here? Like,
>>>> why retry with a seq_nr of 1 instead of just failing immediately?
>>>>
>>>
>>> There isn't one that I know of. It looks like Kinglong Mee added it in
>>> 7ba6cad6c88f, but there is no real mention of that in the changelog.
>>>
>>> TBH, I'm not enamored with this remedy either. What if the seq_nr was 2
>>> when we got this error, and we then retry with a seq_nr of 1? Does the
>>> server then treat that as a retransmission?
>>
>> So I assume you mean the requester sent seq_nr 1, saw a reply and sent a
>> subsequent seq_nr 2, to which it gets SEQ_MISORDERED.
>>
>> If so, yes definitely backing up the seq_nr to 1 will result in the
>> peer considering it to be a retransmission, which will be bad.
>>
> 
> Yes, that's what I meant.
> 
>>> We might be best off
>>> dropping this and just always treating it like BADSLOT.
>>
>> But, why would this happen? Usually I'd think the peer sent seq_nr X
>> before it received a reply to seq_nr X-1, which would be a peer bug.
>>
>> OTOH, SEQ_MISORDERED is a valid response to an in-progress retry. So,
>> how does the requester know the difference?
>>
>> If treating it as BADSLOT completely resets the sequence, then sure,
>> but either a) the request is still in-progress, or b) if a bug is
>> causing the situation, well it's not going to converge on a functional
>> session.
>>
> 
> With this patchset, on BADSLOT, we'll set SEQ4_STATUS_BACKCHANNEL_FAULT
> in the next forechannel SEQUENCE on the session. That should cause the
> client to (eventually) send a DESTROY_SESSION and create a new one.
> 
> Unfortunately, in the meantime, because of the way the callback channel
> update works, the server can end up trying to send the callback again
> on the same session (and maybe more than once). I'm not sure that
> that's a real problem per-se, but it's less than ideal.
> 
>> Not sure I have a solid suggestion right now. Whatever the fix, it
>> should capture any subtlety in a comment.
>>
> 
> At this point, I'm leaning toward just treating it like BADSLOT.
> Basically, mark the backchannel faulty, and leak the slot so that
> nothing else uses it. That allows us to send backchannel requests on
> the other slots until the session gets recreated.

Hmm, leaking the slot is a workable approach, as long as it doesn't
cascade more than a time or two. Some sort of trigger should be armed
to prevent runaway retries.

It's maybe worth considering what state the peer might be in when this
happens. It too may effectively leak a slot, and if is retaining some
bogus state either as a result of or because of the previous exchange(s)
then this may lead to future hangs/failures. Not pretty, and maybe not
worth trying to guess.

Tom.

> 
>>>
>>> Thoughts?
>>>
>>>>
>>>>> +		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>>>> +			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>>>> +			goto retry_nowait;
>>>>> +		}
>>>>> +		fallthrough;
>>>>>    	case -NFS4ERR_BADSLOT:
>>>>>    		/*
>>>>>    		 * BADSLOT means that the client and server are out of sync
>>>>> @@ -1403,12 +1413,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>    		nfsd4_mark_cb_fault(cb->cb_clp);
>>>>>    		cb->cb_held_slot = -1;
>>>>>    		goto retry_nowait;
>>>>> -	case -NFS4ERR_SEQ_MISORDERED:
>>>>> -		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
>>>>> -			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>>>>> -			goto retry_nowait;
>>>>> -		}
>>>>> -		break;
>>>>>    	default:
>>>>>    		nfsd4_mark_cb_fault(cb->cb_clp);
>>>>>    	}
>>>>>
>>>>
>>>>
>>>
>>
> 


