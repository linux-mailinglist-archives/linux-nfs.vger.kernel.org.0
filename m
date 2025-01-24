Return-Path: <linux-nfs+bounces-9569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7899EA1AE30
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 02:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AFF188CA30
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 01:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267D91CEADA;
	Fri, 24 Jan 2025 01:30:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2107.outbound.protection.outlook.com [40.107.93.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1637E575;
	Fri, 24 Jan 2025 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737682227; cv=fail; b=j+IiRO6jKsSEI12SnPM4rhIh07jT1DkQFFLhpBri1W02iRh+jjPCVRxx+A9TPpPyP37UcltxjTn9gVI1hPNVFRCt4tirC1KhTfWQrWBadX7DrifWnIZtDfj2YVV/PWjuZdVTY+m/Zuud6mIGvp2vFEc/KA68rvmPUdKj7Ee7mPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737682227; c=relaxed/simple;
	bh=oFG+NqE0i/PjREV7Kz4gR5CDdVH1n3Z6tt5a4p0138c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l5An1geYUbUpMf9d1nrHxZgNdiOT9FgLrQOlGZB3Vqvq73zDiUfM8zDAsvvA0v06QSugtgkY3dGC/ANtxVmSM3VpFUvy+/lM93nCl7Rx15xvccMTmfPW7a75rOAR4soo7UBEmLjRdy2F00QD5lQI6+1BQx0LqTdXcU1FC4bGhSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.93.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ji59QqXwESUFqbf6yQocjBdIdcqnQTJpUnNayxOEmc37d1aW/Fn0y/RnyR0Idxw7sz9FRnGwaCqOCHoMf/VELUrdNDplOST0+mbDbMJua+n2NP0ggv6CsiV0nMwOqVliRaFHmHut8WDWpQI0vh6kpbBebHRqKJePWKms/cN7fNBJJttciQqMmhSfwxCjv98kzOVAPDufRa4EKkpKhekfaIHFYS7uJAKE4UsE2fGizRp8WyEqjFQdLiZqFCJSVCXARP7tOB/a6znEeeekQxnWa6inF1JfXF/wTJ+smLi2vyZsyce25CwNcRGYr/LsUq/vZPuNqALwCDfr7TLNFqGTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VKXbeAEtN187N6YUnuSC67yVdeTVlTkGV96EaomNrQ=;
 b=v+S/UEm46Cbbc+tfO+axmmAvli6Lwxv4dIV8uTmB6OEdY/YN9TwxR9Xgjn3WNF//hck3BQPHjn8e+VkjVb+m6pyDfClptUvTIjyaGY7N3z3D7cnu5BU42irWVi/F0YRV/hbdhsshy/RjMC649qsTbhbxFtSWOJxZPt1HAaWRchKaYy+nGrxUtVvYtNQ1ktfRRfqM85yZ4YY1h7IIG0lYv1vXZqwb9Gcl74npWOzW4r797+XAziMKz79zrIz0ZN7sod2anp89DbFlmq9qhK6zrCnKzY86iyrz9DqsERACnavKmgYtUNabhc6x+MRcJCyZt/oUz6CWXO7fM970+Bi5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 CH7PR01MB9001.prod.exchangelabs.com (2603:10b6:610:24f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.13; Fri, 24 Jan 2025 01:30:19 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 01:30:19 +0000
Message-ID: <19d4f8bd-b139-43bf-9ca6-716e59c9ee0d@talpey.com>
Date: Thu, 23 Jan 2025 20:30:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] nfsd: when CB_SEQUENCE gets NFS4ERR_DELAY, release
 the slot
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-3-c1137a4fa2ae@kernel.org>
 <a95521d2-18a2-48d2-b770-6db25bca5cab@oracle.com>
 <4f89125253d82233b5b14c6e0c4fd7565b1824e0.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <4f89125253d82233b5b14c6e0c4fd7565b1824e0.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0023.prod.exchangelabs.com (2603:10b6:208:71::36)
 To SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|CH7PR01MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4f0563-58c8-4262-2786-08dd3c16a9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3RsVmZkeStDdEIzWjFUYk42N1Znd0tvRnAvNm40L0J6S1didDlVcXNQL3dj?=
 =?utf-8?B?emlCL1RtdEovSFJBYUFGMFd1Y1BNdEowWHpQNlBTSWFDR015bEJaamsvU2lB?=
 =?utf-8?B?aWF2eXFoUHBKelV0cFZMd0FsMUpSaEZaRzI2eTBzSnhGTEdEQ1k4anY5Vlpn?=
 =?utf-8?B?SVpKWm56TEdlTHh3eHBNMG1kUHlZKzIyZG85NWxWM2RuMEkxSXJOcDdXbW9l?=
 =?utf-8?B?bXVBSnhRLzFiSVpMY2JoYkxQS3hkbHQ2K0tBRXYrQ3A1UU03OFNvSS9PSVo4?=
 =?utf-8?B?Mlk3NjBENE0zRmpsRU5jS0dZOHcvc0QzUW9EYnJtekJSSTYvc0l1M3dSdHAx?=
 =?utf-8?B?R0tFeVE3L0VaOVBOT3ZoanY4RUVMNWRNNUtWUnlyVWJFSDFCUHRpMTZBcFdx?=
 =?utf-8?B?MHMzb1l6RHJJdFNkZ2RJZ2o0VzFQSHZ2TUg5MXppdXBJdDgvS20xYTNkdElG?=
 =?utf-8?B?SDBSSXpqNjh6S0hjWWErV1cxT1YzSk05WTFsc3YvS0p2aXQ0L2hUdXl2OVRK?=
 =?utf-8?B?Sjdmc1hZU1Y5cElIY2FRbUNuVlZGK3BIMGdDNkgwekxjb1ppd21odUFLdUo0?=
 =?utf-8?B?Z1MwM3VRSndmL2N2SGFvMHdHL2pOa2hBbnZoamphbHlnU1h4VUZRUVEzS2JM?=
 =?utf-8?B?Q3ZzUzVPbG9DcUZ3cnYxcTViRzRYWm0rUWQvS2Z1Z0g3WjVFei9yK3FQWGNy?=
 =?utf-8?B?Vjl0RXNDbzVveDJMdnZCci91c25od1FMVEN6a2toYjRFV0p4Sjd1VyszSDZ2?=
 =?utf-8?B?cjh6ZkR3dzZYZFczbi84anVsalBTS3kvSjIvTlMydFpYMTN2RmRDaWorbDZR?=
 =?utf-8?B?RVExN1pjZW11aUQ3K1JtSldEd1BGcDhwUUhVR0ZMMkEzdzIxeXhIQ2pDejh2?=
 =?utf-8?B?d3pnNGZDaUZ5L3ZNbXJnSlo0VTRPMEdNdU5FNWxOYlRIai9GNjVkUzc2NjFT?=
 =?utf-8?B?WUZvUDhxN0c5RXd0OVhSQlo0aVFkYzEybzhxSnJ0bzBuVTBVZmhYUXo1SDJC?=
 =?utf-8?B?TUUyc1hsTkZmRndzSTU3VWw2U3FqMGM2bHZJL3ZrWHhJVzIvUTY3TVYwazlH?=
 =?utf-8?B?czBEVlFEMEhxMWNDcmRRRzl6Z3VKT3d4RGRoK3FSVHFJNkRvdThTbWlpenJO?=
 =?utf-8?B?a1RkQ2ZJNlZ4b1hhV0piWVNCNEhvR0hWRTNwUDRURm11WlRmZDd4Mk03SWtN?=
 =?utf-8?B?Nm5RTVFCa1B0anZNZVVtc1BzNE5odW12ZGJ2THBRVGpWVklmNEhmblpZeUV6?=
 =?utf-8?B?Q3pId3o5dmc2dUR3dkxRaVhETFZCMjl2MHJ3ZmlyQXpZQVQrLzVKYXpXaG9Z?=
 =?utf-8?B?MXo2REJSMFpOQmZDenppeEZVdjZFQnFXMlBON21LLzRiNmdPbjN0akxxWURm?=
 =?utf-8?B?dzhkMUNQS1ZLZURqRFN1Qi9WY09LbzVkRWJWeDBGbXIvMGo3bUhnZWo2K1ZE?=
 =?utf-8?B?YkVPeVp4bWNEOGMvRzBEdTdvU01ocDdZazN1K0J3UWZ2dFM3TmM3THoyZTl5?=
 =?utf-8?B?d2IxMDR0ek5NMFMvZzFkZ1VJV0k1bStVTGRXMjhWUGliSStkQ0loenZwci95?=
 =?utf-8?B?bEZLOUVib1RPUTdiQ1NZamNGVnFrMXhBYTEvcGtWeUZkWENodW01ejBrWDQ0?=
 =?utf-8?B?Z0VUZzVJcFVuVjJXTGxRUXYycDJGVFNiNjFKTUR1UHlEcWp5TStrbGN0WFBL?=
 =?utf-8?B?ZkR0bmVGY3djNW9ZT3FNbC9rZzZoY3VUSHFuQ1lnSnhVNGJDWGdNTVMyUnFF?=
 =?utf-8?B?cGN2UDFjMGxNM2NzcFc4enJ3TFNacTJrNnF5UlRTVm1HWkpRd09zdGNBdmNw?=
 =?utf-8?B?RTBNSis3QzQxVFg5b2FTQXM3YUdnbkI1ZVhFV2J0ZDR0WlQ0Nk9RcjFLZHJ0?=
 =?utf-8?B?WTdyaEU5TWJ4cjdJbnAzdjFqQnFrelNFdnFvV0NrOTNoTnFVUmYrSyt6UStx?=
 =?utf-8?Q?tSpp4MIb2P0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkRTa25GOEFZcHZtUXVRdzhTeVpEZExkK25qcTRtRUtEZWVRWUR0dThFSS9H?=
 =?utf-8?B?NHlpTS9CRHBUVjhSOU42M2J2eFJKR051RTlxQTZnVTFkNEdzSlZ6TDJrTzQw?=
 =?utf-8?B?VnY4Y1FPb01ZcGdmMTZpSHdFY1NOcE42WGZjOXhqdWdqWGZvQ2duSFlYNlBa?=
 =?utf-8?B?S3hoSlhYaG5WUDZOQmtrZGNuYVlxak5PbHVjaXVTUWlqMkhNSit1SlZJNUNZ?=
 =?utf-8?B?cnJTc3RjTW1IN3JmbER5UFRPb0FKV0t6VEE2WnpXUzhlWS8xdmFJZDVuVEVP?=
 =?utf-8?B?WXRBSTVncWJSRS83bTVUYWp5NDE4c0ZjUHVhaXlQVHJsSkwyYjNVNTI3ZmZM?=
 =?utf-8?B?alpOWEN6UzdBZ3pQMm1GaEtJSmRMYS9nazRVNmZQNnRhWFpxS09ScW1yQ0JP?=
 =?utf-8?B?VWZ2NmdiMG1SR0o1Z3NDbHlYcTF5TXBYc3doTjIrcmEzajhSby9ya21OMGd0?=
 =?utf-8?B?M0ttRmZMRU5kcmU3NFZtSEN2R3ZpQVM1Zy9oa3AxNHZtdUo1Wkx6YzUvZ2Fi?=
 =?utf-8?B?R2hIamZOWWl4VXZUM1h1YTMwUHIvdWgwQ1BHcU1HR0ZyeGNTdFFMZmYwbmdP?=
 =?utf-8?B?SkVOZzRCNVJQSzUwd21xVk1ncHc5bm42YnpTWVZMSGRKRXgzT2JVTEhSWG5O?=
 =?utf-8?B?eG00cTNPWWdIeGxHSThVUFVzcEwrWklNUTc4alhDdTVENmNsYzhGYThNTVpM?=
 =?utf-8?B?VlpRaU8yUTdxMkpLbk8rTGJjKzhMQ3YvRVZrK3FmR0tlMUFRdVJDbEIwVUVi?=
 =?utf-8?B?bzV3RHdkbWlhbmp2ODNWVG4rTS9XaXpBQThycjdHV21RUi9DYzBHUHVUNWNj?=
 =?utf-8?B?WTFsVFdlcDVwSmJLTi9xVXV3T0ZqMkZZb2pSb2ljVHFJS0FDeU1IQVpMc251?=
 =?utf-8?B?OUQ1bHY2d2dqMFhsaDF3a0k4NVhmMDcyTGZod2t0WVc2ZVR6aVlyTnROVzV5?=
 =?utf-8?B?a2VpSUV4Tkdkb3gzVjNDa3hrVXhQVGNUU1U5TmE4Zi9POFBNL212QnNMcDYv?=
 =?utf-8?B?YXc3NG5UZjRxUmdQV2w0VEtMNytyNFlmNXc0b2dpK2hoR2FmbWtQVmlGbkhK?=
 =?utf-8?B?RlRoTkJpd29IM3VndEtDamJjZHE3aVRNWjRBTEtnODR3MVhVN2x2bHIrS0tC?=
 =?utf-8?B?NUZaVXZIZDFpRU1tWmx3UTRuZm5GRmxrMWNWNUVMZzQwSmNmSGRLZ2JEUlRB?=
 =?utf-8?B?SWJleUMvYWt2KzB3M3hpUC9qM3g2VkM0QTdiRE9uNUx4L2lDaCtXWDM0Y1lS?=
 =?utf-8?B?L2EvcXRoZlNxSlZIRDE0alc2bUxFdXBtbkJYdFJOVDFXbExNR1F1MWU5SWRx?=
 =?utf-8?B?R21lNjM3a2xLVmZ2OUU1MjhBZjVLZWJkSHo3TjFiNDd2WWxBdEt6ZkNPMFho?=
 =?utf-8?B?cC9jWUhPaVJkKy8xMnJRODBPWmJSemE1dnNjNEM4dkxRQ3JhN0FONStvb1NE?=
 =?utf-8?B?T2ZFWm81WjBGYmloWFFaVU1wa3VzYkYxMk4zamgxVFlIUzBJaFZ6bU5XSnM0?=
 =?utf-8?B?QXZzUTdSTDExaUdZWTV3WWlTZUhJWHdPMFQzV3lvdGxOZFBpcktpcTh3S2RO?=
 =?utf-8?B?bU9MenZqellTbDZDK2p6bmRmVHpVVjBnTUhWV0lUMmdsby9NMWVHYnNBRW94?=
 =?utf-8?B?VnVMRmZ0UUVLUXRPWVpwbkJyd3Y1NVAxSjdmbjNHZStxajZzKzZRTGlqT280?=
 =?utf-8?B?YmkvWkFHV1FCazRaSU5MbGtvNDF5SmkzYzBUZWZPc2xydmJKTGFSUFFwWnR1?=
 =?utf-8?B?VzNtN3ltS3MvZ2dhYmlFVXdyRU9GWWRKaGFzdS9aakhUWlo0YlFxeW1DQnN5?=
 =?utf-8?B?LzhoT2JGR1E2Qy9ETHBVVmRjTUVBaW0zV1BhMUlOVzYxNytHWmVqdmxUZmdS?=
 =?utf-8?B?L3NJRkNNZjQwbnVQRmU4eDUvb3M2ZzdveXArYXBFOXhHaDgvd0psTnFZOVNP?=
 =?utf-8?B?QzhZTWd4eTZPeWJGZzBwdlFGcEdDNGJ5ME1TSzZvTmlvZ0FoSDFld2FBRTRN?=
 =?utf-8?B?bUtINW5YVVBrQXlwb3JrQ3FEV2EvcWVuRTRuNnR6QU11NnZvcVpzN09Ma05R?=
 =?utf-8?B?VGRXYzVZeHNFa2ZaaVF1dW1FdGEwOUtXMVJXTEphaHMyMTJlc1hnN3NpOXlO?=
 =?utf-8?Q?go0g=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4f0563-58c8-4262-2786-08dd3c16a9ce
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 01:30:19.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWJwQwu0c10TIY2+c0VkE8x8MGtWqEO7qZxrasIHiW7WkG+L9QLEyabzTdJ1ZfL6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB9001

On 1/23/2025 6:20 PM, Jeff Layton wrote:
> On Thu, 2025-01-23 at 17:18 -0500, Chuck Lever wrote:
>> On 1/23/25 3:25 PM, Jeff Layton wrote:
>>> RFC8881, 15.1.1.3 says this about NFS4ERR_DELAY:
>>>
>>> "For any of a number of reasons, the replier could not process this
>>>    operation in what was deemed a reasonable time. The client should wait
>>>    and then try the request with a new slot and sequence value."
>>
>> A little farther down, Section 15.1.1.3 says this:
>>
>> "If NFS4ERR_DELAY is returned on a SEQUENCE operation, the request is
>>    retried in full with the SEQUENCE operation containing the same slot
>>    and sequence values."
>>
>> And:
>>
>> "If NFS4ERR_DELAY is returned on an operation other than the first in
>>    the request, the request when retried MUST contain a SEQUENCE operation
>>    that is different than the original one, with either the slot ID or the
>>    sequence value different from that in the original request."
>>
>> My impression is that the slot needs to be held and used again only if
>> the server responded with NFS4ERR_DELAY on the SEQUENCE operation. If
>> the NFS4ERR_DELAY was the status of the 2nd or later operation in the
>> COMPOUND, then yes, a different slot, or the same slot with a bumped
>> sequence number, must be used.
>>
>> The current code in nfsd4_cb_sequence_done() appears to be correct in
>> this regard.
>>
> 
> Ok! I stand corrected. We should be able to just drop this patch, but
> some of the later patches may need some trivial merge conflicts fixed
> up.
> 
> Any idea why SEQUENCE is different in this regard? This rule seems a
> bit arbitrary. If the response is NFS4ERR_DELAY, then why would it
> matter which slot you use when retransmitting? The responder is just
> saying "go away and come back later".

SEQUENCE is special because of the minor versioning rules. It is
prepended to COMPOUNDs in a way that allows it to be optional in
order to comply with the "no new required operations" rule.

As such, it's not handled quite the same as other compounded ops,
and has some exceptional handling. It's not beautiful, honestly.
But it allowed the session to be introduced in v4.1.

> What if the responder repeatedly returns NFS4ERR_DELAY (maybe because
> it's under resource pressure), and also shrinks the slot table in the
> meantime? It seems like that might put the requestor in an untenable
> position.
> 
> Maybe we should lobby to get this changed in the spec?

If there's a defect, absolutely. There's an IETF errata process.

Tom.

>>
>>> This is CB_SEQUENCE, but I believe the same rule applies. Release the
>>> slot before submitting the delayed RPC.
>>>
>>> Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/nfsd/nfs4callback.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index bfc9de1fcb67b4f05ed2f7a28038cd8290809c17..c26ccb9485b95499fc908833a384d741e966a8db 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -1392,6 +1392,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>    		goto need_restart;
>>>    	case -NFS4ERR_DELAY:
>>>    		cb->cb_seq_status = 1;
>>> +		nfsd41_cb_release_slot(cb);
>>>    		if (!rpc_restart_call(task))
>>>    			goto out;
>>>    
>>>
>>
>>
> 


