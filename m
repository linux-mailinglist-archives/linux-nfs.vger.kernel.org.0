Return-Path: <linux-nfs+bounces-15673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C49CC0E14C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F4204F778E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278D11DDC1B;
	Mon, 27 Oct 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KQeeA7iN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nzvkjWcC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E523A98E
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571847; cv=fail; b=U1DmjIqHHgWrckbOsa/0dCtcEbzmxBiRGepel5qNGHqajPCw59JUQFk5d/mOrPPE3vGLiVjOLPUbUL12tUKwedD+uGobF7zk6jpJQlAd82gLiomWXIGQBJLc07ce/Qqf5PkrUxv8tJM2dNYx3XtOvBJUrx5A2jByI3wXiHuQUn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571847; c=relaxed/simple;
	bh=Je40iSGmz9J9CDo4zqYS1NkSeEls5V6S1Py+TSejH9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fpD4Trl9i+OJacZ9TEtCtSu//rS8QBT16MiFCq4CGRPhkCPL1tmXYNT1tktxVrH8pii1h0cCtLdXtmMyplSm3U7lkNXPeN8luib1/7RI0rn4cIQbnRDZbwNfd1X7h/y24x2Eo+g2glSbVbzEqm4Ubfuqc5KNVGdpS7kt+cgfEkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KQeeA7iN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nzvkjWcC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDCftu026548;
	Mon, 27 Oct 2025 13:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9WXvQMOCAuMzyqSKNZyK3uwqalEBxt1dsFJLusA1pgI=; b=
	KQeeA7iNz0aMtARSvCAZfhYnUCvI+dz/l+lhUf2J7DCoI9mAS3CA2Qqywnc//ccZ
	2GqYayUSMPqpY8PMsgd3v1HUyoZ0kk7YDNy4gORBYMxMUgElv2JZmkhR3Aakc9Tt
	r2FUpiMM7RxXugT+MDX2BQsJFSeq+WAvncwhNXsNtjDHJQ8POCrfBNSiJN1DgPF+
	uP2/NebVvZ/G80BY3d1GTDQ/VHF53Az24knJzInKDYeQtOHjUSKGeIzeZaIr0/ik
	11qnT61pone7Vgq+DqmcJQfE/o/gHxpQQEwYh2JDY4IReZhMrXJe/R4L+oYbHeLe
	7VCNZHeZdccth7NAljycvQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uu8x5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 13:30:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCYUL9039038;
	Mon, 27 Oct 2025 13:30:31 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n06t9hj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 13:30:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0ANhZgY5rlWyXYGteV50vIgTCVq99rLgnPEoxTSeSsYb1pE8HaKm8b0Y4hyuwZaULOkysav1W4jZ5uFtnrGF0o+M8lPyZ9S7mZIONTsGba5HHsrvHnt4DrqILXxf2ehI+kPU2sPKU7wk6gUFwE3BKZFcO14ksueLGgZQsogIZp0jsUreNWHTP8zxR5D3L+/Bzdhl81VW227fyngHe7xM+fSxNogOuNSK70EYJAi9Jtbr8k68hJEz8C5TPANWfAACxSWdcwp+YR32WEpLyPnA01OK2o8bVvyEji5Ct1rygXNJfKNTcNiSsYAq2S/rxXKYKELs0UWqRc5IHohUWbPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WXvQMOCAuMzyqSKNZyK3uwqalEBxt1dsFJLusA1pgI=;
 b=di4WfqUUy3qHytYrKNCzwdr4EvDMasADM2vop708YEnniCwmYe0NgaCoeGE+LdMQpng++kETpGnjnbQ/Rjzg1dz42rktExVmSA7cTKYpa9SBQIhLoLVw4WG7a7e0evWKZtwDFs3F1Dihi4OW9NTG+D1oNj8jbuHXeoiSnBJPjSdS1hei3ZdUR6LeT5JIo1TCqc9yDAbJEoXSbNpeGs/kYdlAzT66a7dQTAgmgh0qKcl4SaZ+EZxEhYGGjDetZGiceI0h9tvQLnt0J/WC1KicRWZgOn48l3j885QDqBEodsXz3w1jqLkPqFVZNrO7YyMrI+Sk2G6XPd2UfLXtakqT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WXvQMOCAuMzyqSKNZyK3uwqalEBxt1dsFJLusA1pgI=;
 b=nzvkjWcCuQhJZoxgkY3HgXTGS/bxZqwDRofXCqI5uZAQc6RMQvJGkmCccai4p2jnyOTos52nGSWH+ABRmVJRAkF/9NATEFP4UhLMruLNoq5vIz+xPMuBzDDIenUHTSZDoNqHZ6RydaaOA2h7HUcBnj5ubc7P5O/CwSDTeCZQVk8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8734.namprd10.prod.outlook.com (2603:10b6:208:57d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 13:30:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 13:30:27 +0000
Message-ID: <7d70c343-2630-46ed-9568-0cbe6d289827@oracle.com>
Date: Mon, 27 Oct 2025 09:30:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
To: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org> <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aP8pfpm6jb-Hj92B@infradead.org>
 <d56f3b5c-2628-4714-8e77-7e904c169e90@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <d56f3b5c-2628-4714-8e77-7e904c169e90@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:52::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff47cbe-482f-4ded-9d41-08de155cfde5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eU0wRnFoSTcraUhxY24xY2pqdWNyZ25jejRLb0wzZlBVZEM0cTl0d25GTEQz?=
 =?utf-8?B?SWpWdDU5TytObWVSSGw4ek9kMGl6Z05mL3M3Um1wcmpIc2QxcGNVTGdBMDRn?=
 =?utf-8?B?SzJOQkt6czdIVG1ySXZ5OUZpT2duZG1xcXJqQ1dLeXp2bm1ZTUVQYzdQbjR2?=
 =?utf-8?B?M0xjTkl3WXNleTZQbDlOQ0RiY1hmUGdtVmdzMjdZQlNKNzM1RWRFWHBZOFEx?=
 =?utf-8?B?c1lKbHdsRWRrcTlPQmh6S0dYaDZFdGFwQVNlb040VkZyM2crNDdlYmloUnMx?=
 =?utf-8?B?amdXRDJPbmpSYTVuWlhodmFreUR2RVhsN01yV0NQTU5mL2dGdUZmeFVoUGV0?=
 =?utf-8?B?alBUQzNxSGp1S0V4NFFmQUphdmg2S0tiQWhXWjBxbkR6cE8zcHZuZmRxZVgx?=
 =?utf-8?B?N1gzS1M3enVEMURFVkF3bkpjaDJJQTVXRS9pajFseWxlODRuKzJYZTUvdmdN?=
 =?utf-8?B?K2dKKzRuZWFEWFpPcWh6cmpFd0t3Ynh0NlZPcHZOcmpsNEZ1OFdTQjBzWU8r?=
 =?utf-8?B?UzQ5OGVFbWRzSmEzMzBxaEdBZk1IZ21DUFkvdWR5bHZBMGFIc3hseEIrNDU0?=
 =?utf-8?B?RDBaVXZUampUU1BoK2MzOHhsVXo5bkZWdHFNVS9Tc0dJTTJpVnRCQlEreGdo?=
 =?utf-8?B?Z3RuSHU2cGpGcUxRQU9na0NFZEV6RERuOHNCOUJ5ZGNLZndjYytVbEdzYjJL?=
 =?utf-8?B?QTF2em1QS05wdEowMWc2YWV4K2lGOFpvSlJsUVdIR04vVTlUenBxQzNUS2tm?=
 =?utf-8?B?aTNUL29Wc2s1dFpXNVdpbWxQRjI1bko2N0lWUG9tVGwvTCtJelhUV3FTYkFj?=
 =?utf-8?B?Y0VyLzZkWXNWM2cxZ0cvbEZPYjJCZE1xdXcvQlNkeGcydk4yWGNHQ0U4M0Fn?=
 =?utf-8?B?YWFXaXVQdzM1L0dpNzY3eTFSY0s2eC9ESTN0MGFyMXRrdG9wMElqZDFlR0c4?=
 =?utf-8?B?ZGFXUVRjciszQ0RJTDkwVHFGN1hId0QvREZab0NqT1JvRExGRmVNaDVUNlNi?=
 =?utf-8?B?dDAxaS9EQ3Q3L0tHQkhaODJldTdCcnRQWUE3cTVmQmxQWWZHekd6WXZhN0xS?=
 =?utf-8?B?OFFuYVNpdk9JT1ZvaDZscFdJSXZsWTh0NkUwTVVZa2ZKR0wyN0ZMM2tya2RW?=
 =?utf-8?B?OU9YZmtQbVdEVTFmU0JNMEJjdG94QWUrZ3prdm9IeE1zTFJNMEJ5RHVFcCtC?=
 =?utf-8?B?TVhFNjhuR3E1WEJGSVhwQklUU0ZIOXpXVjZkQk1YQWpIR0E0ZmVZWnM4WU96?=
 =?utf-8?B?TTcxWjdzMVVjYmVMbmMyTG95ajZ0cGw5VkJiOGV2SWQxV0JnVzVwWUVoclZQ?=
 =?utf-8?B?NFpCVUN4QnhHTlFmcllrNXBjcmtjMUZlUVFEeEZGZmV6STgwa1NqN2pUblZ5?=
 =?utf-8?B?bGMwZzQxV0I3VTMzRFpacXloeGpvdHRUZlZsMGpwU1pMakxCSzZneEVUVkk0?=
 =?utf-8?B?Vy8zNGhtRzNabWV2MEpZVk11SkdtY0VkR0RRdlZMODA3eEd5djFUem9ZRHUy?=
 =?utf-8?B?ajViT0kvcFpxWlgzSjEwY2paZk9WS1g5ZUgxSWVsc09LakJydk0yOUVxRmF1?=
 =?utf-8?B?MWxNeWwrdDE5VW9MMXFPREduRkdvRDhjNVAxY0xKRWxpNUVhcVp2RC9aUzdx?=
 =?utf-8?B?dmRiTWFsQ29CVHVmbE0zRzBySHU0dVJycFB0Ymp4Z1puN3JTb2lBbllhZWVF?=
 =?utf-8?B?dDd6SERXUUNhemkrci9kM3FlMzg4UlBFdWZucisxTzQvd1BBSXRCaENsV1RE?=
 =?utf-8?B?ZG13M2N4LzIyZ1lzV2ROWk1vZmVQaVRjM1Q1YklKNGdCRmtLSHd6eEFLb0RH?=
 =?utf-8?B?MlhQekJPb1V5d08yNmUzQ3JtcVM1R0hYc2V2eEJZWGZ6NTJSRk9XcXRQZzVR?=
 =?utf-8?B?K3J0b2xQeVZlNHVJTjYwQVhRNGVCeDdha1hqWm1HS3lyeFlSUnR5OTN3SHk2?=
 =?utf-8?Q?reO3LJi/seIoyCHsTrXZEg34fS7V/ngv?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a29aT1ZJQXlWbjI1WkRKakswVU1aOHA5emdBS2tUWVQ3SGJmcklTamJsWjFp?=
 =?utf-8?B?SmZoUU11V0pWdm44QmxKRzJPVW45VEZKKzVXcXo5bVJ5bVZISFZVVDZsSENv?=
 =?utf-8?B?VmU3eHIyTVNCUnZwL1ZWSkFZVGdhOU5TdHpJck9PMEYyS1Vrazh6YTBSRDY3?=
 =?utf-8?B?bFpidkVObVpSZ3BiZGRBTXY3M0dQaUVtRmUrQ1ZxZnlkR1hTN0JHUkh5ZDFh?=
 =?utf-8?B?Q3dmUHByRndyQjRxNTV4MTdaYXdrRUhlVzRaRHJKdnhOQ0NLSHlQc2lqQUpM?=
 =?utf-8?B?MWl6VWNQUFQzMG9BN0NkNTd5S2tzVDRGaXlJZ25ZdWVUNUtKU2xLMzVQaU16?=
 =?utf-8?B?SUswK3ZTaU01MnZjOUs0VzdpMSs0WTlpVW14a21BMjBaM0Z0cFhZM3lobExq?=
 =?utf-8?B?VklwakFaWktyaFd2bUlody9uMHBDUDFaTTJVa1Q1U25tY3hrVDVnTzJlMi9H?=
 =?utf-8?B?TU0zQ0ttWHkrWUoxTWpLZzlZdWJjSkhtamMzbFZ1eFVUdTFNUE1zQVU4dVVO?=
 =?utf-8?B?VXlnVzd2MjZHb3lCcWY1dC9XMEU4KzZnbjVKZkNLSW9mYVlROUVRRGIvWmI2?=
 =?utf-8?B?NmhyRWR5cFZCcXBFR2hFRms1QjM4VjZJZVNDTUFTcTRYZ0ZzbW9kc0VwMkN2?=
 =?utf-8?B?YlVzWndnbWJWTmE5NGdLaTF3ZEVtbDJKOTZmUGU1SWVoZzNiSDUrOVFEbVBW?=
 =?utf-8?B?MDlWbjFXRGszTklSNi9XeDI0c2gwaHk3eE11K2tXV2JWVDJ1QlZQWk9pR0VG?=
 =?utf-8?B?VCtranpLa3JEallZWTRLMEtvWHNxZ1gzQjdVS0ZNeDdsa3VNc3QvM2JlalN5?=
 =?utf-8?B?NHJjckROV2k0RlZmU1RKZ0diRWRHaTZKUk1rMCswOFpWNVlIdkZNT2ZFeGVP?=
 =?utf-8?B?VVlTdlZyM3gwQ3N5QlM4VElxQW9ZUEMzR0dNRzE5THlOODR2aCsvNk1kUkJZ?=
 =?utf-8?B?d2w3cjVoa3RCZ1RIVXNncXc5ZTFxLzJUbjRONUJWTmhpSWZ5MU82cVkyeHBX?=
 =?utf-8?B?UjV5NUo1QXRMTm53a0pkM1BiYURRcWh3U1IvSXFNUFpKOTU5em12SmZhNGxz?=
 =?utf-8?B?K2hmMHAzMU5yUythdmJqYVVFellCTi9oV1BzNzVCZTh2Y2ZhbFNvTDUwU1o5?=
 =?utf-8?B?MDRRbFB2clZuWDRsT3hqQXBGNWRjT09sZzRQZVozZnlYV2pYcnl1eXBGN3Bz?=
 =?utf-8?B?WGJFYmVmcjJqUklMR2pjS1cwaGNSVEtiZjB6dHJjNHp1Unk3TjZUL1BzaEJm?=
 =?utf-8?B?OUhqaEo5MlJzd0Z5RkIwU0ZKT3JOVGdtQmI0blgxRzFWUnVWT3N5OUVDbmJw?=
 =?utf-8?B?bk5Fdm5LM2hvM0o3S2xTTlUvVzVUZjFHdGdJa1JTb0FPeGFKU0tUZG5KbDVR?=
 =?utf-8?B?Mk8zKzVmdmNuakJydlEvNlZYd21VSERpOGR3ZkdWaDJrU0xKbjBXU1crdDY1?=
 =?utf-8?B?WDQ1VWtqNFVMRmx6UElWTlo2UFM3WXNmS3plMWxoeXdGY1lvQXkreXh4Znpz?=
 =?utf-8?B?MXNvcUxGTEJEbUVwTWhDWXhmamNFZ0Y4TGlaOStOTDR4WU5VV3U4NEZCZDNG?=
 =?utf-8?B?a0ZmN0tKN2w4RCthT2I4VjZPZTYwcFdPWkN3enhnSGpGbEtkM0FjQmx6VnF3?=
 =?utf-8?B?NlMwdHNLMm9OSnVkVUhIOUJkV1BBMW9TUllXcVhyRlNRakdHQnlIeEZkL0JL?=
 =?utf-8?B?N0RmZlNxNFBmdHVubmZhYnNYei9DOStGbCtFNVBEcGxwTVczRW1wb0Y0eXBL?=
 =?utf-8?B?NXpIQnI1dndKakpMeU0zeTlRY1h1bkdkT3dPNjNRbmtsZ0ZMa3hML25iT2E0?=
 =?utf-8?B?M0dGamVVWXNxcDB6T054eDFmeXlyQmdiR2NYaDhEZEdGbXk0dTZHaUJ5clRX?=
 =?utf-8?B?VTNnSFFEbjhKU2loRWtjeXAvaU56QVpSZG9scTR6YlFVbmh5ZWNJKzBQUXBO?=
 =?utf-8?B?Qm55ek01VXRmT3dyWkJoQVdRWDJ4QW4vYVBvNERncitUcHJDKzBZWFI2QVpu?=
 =?utf-8?B?djNJV28vVUFML0JrRXhWMk5qVDdvVmh3STV1emZaaXVFdGRkKzNsS0hsSFNM?=
 =?utf-8?B?QUZpRFhZWkYzWUNJOENVU3lKamg2OEdycHkrRDVENGxwaWh2OXNNRTg2QXFl?=
 =?utf-8?Q?+AVON/jSB5CkXMK2omCauQjM7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9ajZxPoKQe+906LlYTBhXE/j5aEcjF4dP/ZfrZBf/ZROb2JgHYtsw+ySpP36uKCbnRW/hVpAs5b4yBEU9LGP5i4UawtvQo8F/4hsm9QLCE0L7t+PRtFcdFLQpRzPo4p3qEPCq5zZ9/8qgag0g2xTuytAAfOGT03BOw7I76JfdeXbG5Uy/vSU7LIkHDp0Sctm6g6hJFWF8pOK/dMpoNNCuuUVUMX2UUV6gziKHf1FDNIGYN7C2Ttl5/yqRMD8PjHFDWbCOnoqxBTeI+86OCgsi93+p1EcXlJ0sRUi215BqJzDFaPZ8EbeixLJKgfz2jdyjSHmuenAMTVdFZ2qvzr2hMW3Ro9kJFExFx1AX6LVRDhEhzzPUrwHBpZnAhtHKUuQJ1RUWJgRbbISJ2IHuGV/cyLmNihzaZBX3SPjWvArH54nnJxOiYfuOpXBhBF7h4VvKX8/IbdyW1vgfMqzJbKsxkUpXKdbH49uXFqmnkWzjxkO9gfAAtrX7Lmxgjh2kSl2oTVnKlX+99RvbIPh1ATgYZcGfUZGvEqT+GeqxxO7rUhnD3v/uDRYgF5pJBb9QvRXY0B2I+0nXqrX/JEdjCj0SyYGULM6f5f1BxFMQvjOpzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff47cbe-482f-4ded-9d41-08de155cfde5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 13:30:27.5120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hR9567EcAW2MY15cIyAfsZ3Ae766KREtc9b+teqDOu5IhW91SBfyr8p1m8n/eN9d/40EdkSjaILnpafy23s1CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=747 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270125
X-Proofpoint-GUID: 39GEsTsnKvR2N4603O17Jk-rR95lv87B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfX5DFg7Kkzj5KD
 rkqH2qiYsep6lw/JYJiVgFMTLQCAFjCq5BXma4rmwfxx3rM4U88ARedm8rpt1qeqUIDdTyWELNx
 cv6SUPU+jVYu/DlAX3BGayo0v098OTZd7z6xVDG8Girx9im3g5IpjbRLErh9UZisckr78nGkA3M
 8CLTmrkfQrJVv65MZ943dk268hjaEVCxlYzAUEq4NAJ5FUaQFAi0UsR/4+wSdIwwU1Eve/VJmt2
 1E+wxuDwIdarKDNOhovDbM5AcqLu/Y9ptukK694fayGlfk0tSdWi24r9Ks/UbmZD75Fu9rIAF8w
 hvfUvYLP1OGGRGBwCLoe/GQrt6ARCuiTBbUL1eE4ntwfNhRDhR1XU3HXMpAdLf+0FnwbRij5ySs
 +3/ww3A169J+v7YnO+LfRgrGNoKRTg==
X-Authority-Analysis: v=2.4 cv=Xe+EDY55 c=1 sm=1 tr=0 ts=68ff73f8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jnu-gmHZZmhooqaUgVwA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 39GEsTsnKvR2N4603O17Jk-rR95lv87B

On 10/27/25 9:27 AM, Chuck Lever wrote:
> On 10/27/25 4:12 AM, Christoph Hellwig wrote:
>> On Fri, Oct 24, 2025 at 03:34:00PM -0400, Chuck Lever wrote:
>>> This looks like an xfs-specific fix. I'm reluctant to apply a fix for
>>> a specific file system implementation in what's supposed to be generic
>>> code.
>>
>> It's not a fix, it is a performance optimization.
>>
>>> If (IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC) /is/ correct for all file
>>> systems, then it needs an explanatory code comment, which I'm not yet
>>> qualified to write. I don't see any textual material in previous
>>> incarnations of this code that might help get me started.
>>
>> IOCB_SYNC always needs IOCB_DSYNC as I explained three times now,
> 
> It wasn't clear to me until now that:
> 
> a. The reason to add SYNC in this case was only for DSYNC

I might have gotten that backwards. The only reason to add DSYNC was
that SYNC doesn't make sense without it.


> b. Even after an IOCB_DIRECT write returns, there is more work to be
> done.
> 
> So I stand corrected.
> 
> 
>> including a detailed analsys of all users (We really need to rename
>> IOCB_SYNC to __IOCB_SYNC to match __O_SYNC to make this more obvious
>> I guess..)  I still don't understand why we need sync behavior and
>> forced stable writes at all, though.
>>
> 
> 


-- 
Chuck Lever

