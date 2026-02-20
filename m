Return-Path: <linux-nfs+bounces-19065-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GFSJfeBmGlMJQMAu9opvQ
	(envelope-from <linux-nfs+bounces-19065-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 16:47:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13864169022
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FAC330488FF
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78392BDC32;
	Fri, 20 Feb 2026 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QNni9LjL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b9gD3yrt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9670EEBB
	for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602389; cv=fail; b=iaca7Xu7r8T3cwcXtQZFQXooKMrud74fqc0ZK82raK0qaV2VJdfmhBONefgndXefrAf5l+spirxCay/oq33vUzHkcU/hIQK2wdqlijtjY/W5STifZ2hnhf+Bk+LanE+KOM7c3qDmvczTJ6/aMiJn5TrihW4qkCHAz1oRrK8QUHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602389; c=relaxed/simple;
	bh=eVZf5OEk36czHe1c59D5vQvazDCE5A3UUIk6UPwgY4Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GVhrh8uZCMXNf1KGrHCzX0cutZrm7snXj6I7JlsUIg5vtlr+IpV8+eC3Prdef6k29BrEz3DfYNUR+nffz6ab90L6ylPOYcby1/jCpDiZdSreaVXgTZbB6Bqt0bEQLU0Xo5VeVluoeghYkm6KMuVgPJzni9CzXzwcNKK+57eHlos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QNni9LjL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b9gD3yrt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KDXUck1572869;
	Fri, 20 Feb 2026 15:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HJQZ8X6D4HHKU+/0uLh45wyjeRA11v5/igZlajuAfws=; b=
	QNni9LjLSPy6PoHSm8bz4QY2JIj9mhB3NcWs2vNYrtUcFRxa9xwc2noj5CYAD7Z2
	zG63mWiFqFBlZfWWcWtj8ZWssJMVu1mE0B6zaSTN3hx8T4YUtn2H25F2xNrhW9zX
	3OibAoC1qxfxiah3BYkfIzJ+TUkrd4TfCEddQe4p0mz7gk8knrpM0wLCwVClXFhR
	1ZmDvHbP5kGiitD4fWfMd5RaASxqtiaOCh2ie8jpD7N9VYyi+Us3nCh8cOKG8K2D
	3DsjY53AGhLqKvcsDv7yyWDg+wCng57TGYfGGjt6hgpYYe9VYLKA0iBY6jTiVL/W
	GkzEc7f5+fmnxWq9i3IVbw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj049f9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 15:46:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61KFAtMZ015086;
	Fri, 20 Feb 2026 15:46:24 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb266agb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 15:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okcWyalteQ+57DogdlEl4qirf5o/CRo1JrU/PFQIQQyUbt3r/cGFrSRVYMaPsGq1KrGDE/N6RJXLWKQx47hWO/72C+O3I8J36SVi6SCeJkZMgaS5u593mCSUtA73aTb9bNHIxmJIptHYthi2g7UPloB5Yzl78JEf5tSXDMV3CpktwEivd2zlMRAGjsBemTie++3Ndz43Dn0ZIEIIZZffGmbMU9kyE15tv3S8qLnjkMWZoAQ+TYPPg9HcCGoNLpb4pKd+tYgEklX2+VbrwTZVf+aVCwH/9YO2t3igYj1enHL6fhFMZbgdd8x771/jLhcfej2qlCKh8K16L44paJ+VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJQZ8X6D4HHKU+/0uLh45wyjeRA11v5/igZlajuAfws=;
 b=PZ6tOQ0Kr5yy+HDveAvkFsaVaOYUbHq42gCoub6owbhQysDQ4CIKCv9Z6naJA4CZvsXkBUQoa7YDk+6wCFCvHwlE+XyUkPkBPUXlViN4Qtw3EWuKuY7L0FHzzi17EBcl45GVmXO3g9BJmrI82X1EZdaCkD+GBczgVv4w24gqs56uV31fxjgOZgMI/ALI5vIPFzd4TO6bU9KOzVs6TpbpYnGKFz4uYPNq9bRiecujmftey8eZWGiGWzCIN82wROdbfTFeU8/PdSmluvmdQDQELxeod2AmqJCe+zTdEikQoJvBgix4K/ufFaGjVSD3J50OIUcfJC5r0uXVSs6BIJsHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJQZ8X6D4HHKU+/0uLh45wyjeRA11v5/igZlajuAfws=;
 b=b9gD3yrttTIOaScUTSbwySoZbwjVpFKInddKoRLvaxL48EhwNKpyK2eRfR1EhpPpvdtjIGvFlxEqvWflDVxqWTyozcro0tyoT+IX4pCJeDZzcQft2yqzPSLx+5okdGlJ7AXAiDDPtChB//MAie6WzXnRBBNB42GF5wuCJ0Wu0P0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS4PPF80FDA9397.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 20 Feb
 2026 15:46:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 15:46:20 +0000
Message-ID: <377ab826-ff0b-4793-a2ab-999db9ccc99f@oracle.com>
Date: Fri, 20 Feb 2026 10:46:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4 reexport
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org
References: <20260219221352.40554-1-snitzer@kernel.org>
 <098b9502-8868-47c9-b164-be80bb11ae74@oracle.com>
 <aZeXvNclhMMzsweq@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aZeXvNclhMMzsweq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0025.namprd14.prod.outlook.com
 (2603:10b6:610:60::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS4PPF80FDA9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 601f3a31-78b5-437e-6ba9-08de7097318d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aHNjL0VxMHUyNmtBdHJIYTE1RGo1M2kyS3k1b3d1bGdrM3VsdXRYYjFITzJp?=
 =?utf-8?B?N2o4NCtlZUNzaVZrNFlPT3FnUnBTOVc0MW8zREcyWGUrc000UnVuNjdjd1pr?=
 =?utf-8?B?SWVOWFFxMk5veTJrV0IrRFJ1N05wZFhaYndpSkM1dCtKYVFUK1duckxnaFI4?=
 =?utf-8?B?V3FKcW1TRHlkbTkydkdWWmd5QUZobElLNmhRTGFFUTY3cjcwQWFWRTdId3Iy?=
 =?utf-8?B?U1lWVmZ3Z1dGVzY2c0VPbW5HMWNZSnFLU2Iyb2c5dnFPR2tKbUNEUjR6QytP?=
 =?utf-8?B?dW84bHp1elRINE1ta2o4eklpZUs1NmFxM2tRSHlSZm9DZmhwUEVBQWVWSDVa?=
 =?utf-8?B?QWQ5K3g5dytFWUlUUEcxMFF5Ym1XS2FUa212VVlqZGRTZ2RFbEE3bGFmQmx4?=
 =?utf-8?B?QSt2cTZvdlg2NnkzK0kzalZkOUxqVCtrTG51dWJZZ3V3NzVjbTFmYnhKa2ZD?=
 =?utf-8?B?cmxEcDlRUnloQ3JzT2JWUjZiVmJzZ2g0YStKS2xRNzA3UTlWc05TeEplbWk2?=
 =?utf-8?B?anJGZlhOc0ZjWTBnOUZJQ2pCeTdUSy9iVmwvSDRIUjJ1b05KUTluNEZvK0Ns?=
 =?utf-8?B?NnNUU3JhcStiTGhSZFlURWtQeDQ2N0Z1RExvdk9tMkVTZE9mcnhsb3dtWXZa?=
 =?utf-8?B?UXJxVGdOd25KR0Jud0hHcVBZZ3NzMUUwSTRZcjlteHBIRTdLb3c3VWhkMmFO?=
 =?utf-8?B?YUhQRSs4RkkwOFNCM3o1clRZMmRKSW9RUzV3RGlQSnpxMkd2TG9GNGxabnZr?=
 =?utf-8?B?RldwazkyaFpveXUxT0diWlhuSXVSNU5oVWQ1SlRkU0MxdjdyN2E5VDN3eWU0?=
 =?utf-8?B?S1hiNGZxUzR6Mm9HMk85cldoZ0FPMDhLODFvUVU5K0dlZUZKS0x1c0RkRGNz?=
 =?utf-8?B?dE5uWkhaSHVKanN2VzFPTG5KYlJrNDVZN3dYQ1BrSTM5SGpWYUFWUFNOT1ZU?=
 =?utf-8?B?TTdGQzM4eUZFWkM0WVJnZVM4NkxYUnU5a2hjcmZqanhYRHdmR3JoRU1Yb25T?=
 =?utf-8?B?UkVWTG12VmcrQWsyKzFzNk0wZDI3dUtVa1h6Ky9rcnZKT3JvTlNVZSs4Y2sy?=
 =?utf-8?B?ckFpaVNCTVYyMEdrZ3RhYi9kUnNxdWUzNWFaeFZ2OWFnRUc4OXZFOCs4U0Jn?=
 =?utf-8?B?ZDdtSCtFZmtkV0ZQbk9vbm5tRDZpN2lZM3UxWU11aFJNMXNJa3lzOTdKdnI1?=
 =?utf-8?B?NE9DY0hSOGZPbEMzVlNBN2kzZkZzdWk1anI3U2NTbzRYUzlWYVM1cytNQ0xh?=
 =?utf-8?B?QjJvNnNXOEQ5b3pDL0d2S3dLUGNSYU9mOEtXcllsRXE2KzJ0Z3dod2dNZWp2?=
 =?utf-8?B?aEJURTRVRHlqNzl1TXA0WGkySGlQSGVwSEpRMmZOR0wxTVp0emFiWUVFUzFa?=
 =?utf-8?B?MFhtT21BanVicjkxaWVqMkFWdXYzMktVMGFBMEoyV1hqWmtyUVlmOWlJelpW?=
 =?utf-8?B?MUM5dHhtQUkwTDJySmk1Sy9LUDVnSkdaQWhnQkViWStUeW1mcllVN2xLVzdI?=
 =?utf-8?B?bVFNTjU3QlpLejNPdjV5aWV6Qit3NVluK1VtVVB5Vy9KUk9IL252QmZjZ0gv?=
 =?utf-8?B?SDRhVFFrL21xd3JwN0loK2svT0h4cG04allvNGZZc09pZ2VTbVB5R1hwemF6?=
 =?utf-8?B?NEhOc1UvdnRCR1VqVG1UN1d1c3pUREdOOWppUVhOeHJvRnhkZWNQQmpWRmdh?=
 =?utf-8?B?a3JsVGlVZVc0TVBQZ3NqeHNNZlpneE40RU1vWEdjN2RNQUcrdlBEeGtlR0V1?=
 =?utf-8?B?ZG4vTUhhYjFKMjcxN2pNQUFGRmV5M0FQSTBJSWtlUmVTcHJXcDhlaTQ0UEc4?=
 =?utf-8?B?TGd1REFiaWJCa0dYV2U3cFM5VzRVR3RmLzdNYjMzV2tFbXZSRGIyOUpFRmZ4?=
 =?utf-8?B?N0NrUGV0ZlVMTFF2TG9QYVh1RytmTE4wVG1NOERxby8rblg2MHFhdjdPL2l1?=
 =?utf-8?B?SWNBc2p2MEVXZEJrWnF0SUx2K3NXY0R4UDNnYnlab2swNCtjeFBVQ2Y3ZlVm?=
 =?utf-8?B?Qi92Yy9QelVBUFBQcjVPMW5wQTFvQUFWT2tyb2M4dVhxSEhrTG5wVitUMC9O?=
 =?utf-8?B?YTFUcWhxRU5oOW85a29takFsT2ZDUjg4M0pWb29qNGM5VWF0QVpBZk56TFEv?=
 =?utf-8?Q?eD6U=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T0Urb1orS1kreEwvVjgyeWRKVnNFOWVHK3lwRUtHZmxOSG0ra3dxd3pTSlh1?=
 =?utf-8?B?SzZPMlZXMHd4TUN2MVVCSitkdnpCZ0d1M0F5WDBQVkFFWE5DeHFHNlNQMzdF?=
 =?utf-8?B?aU1wYjg4SzJJZGQ3THV5dmdtUDNWN1FTdER6UFhEVUp1Y2NiR1J0RDJ3TVlq?=
 =?utf-8?B?UGdFa0ZHMUx1dnNCN2hqdmNPa29JN0ZtT3JvOG5XS1ZPOElCK0JjUTVMRzRn?=
 =?utf-8?B?M29ZUnlXNDFqVVdjRkhLYXB6bUtCbjFIR3VIcG5PTjZnTEhoUGNQUTJNaVpu?=
 =?utf-8?B?d0tJOUc2UzVUY1JCbkZqN25rMUtMaUQ5MDlmM1ZIU0hRanI2Wk9DcUU1M3FN?=
 =?utf-8?B?MFd1UlVwRW4rb2ZFcTFqQ0dtaXdlZTNCd1RSSDd3K3phd0lLK1prbnRINXpv?=
 =?utf-8?B?Rm5kTXhNUkNUM0FNb001NVBaQXpaVVFHZCtGc2dpWjlXOVM1aTZhNXIrcmpi?=
 =?utf-8?B?aDVJUmZ1U1NCR21SZ1RDM09SVFovNkVVckhVbVl3ZVFOcGpSYTZpaUlXNWtp?=
 =?utf-8?B?MklMUUM5N1lJVW1xUEc2RHRhWUF6ejNBbHhkYVpqdjJXdFl3YkdWcXZrUGtR?=
 =?utf-8?B?bVpIK1lyTGJxb2hLdFI2ZzJMUURkM01mZjd6R2lmM05kUVNHOW1Ka0FzQVpY?=
 =?utf-8?B?Ui95K0Vxcmg4cmdtVFlsSmFuWEpGdGhFTVUxODVwa2NtbndPUWZTU2h0MUwz?=
 =?utf-8?B?dmZLYWNqd2M0c1IyMGZIT2d3dmxiK0xSZVZFYjBTeEVnaFY4UFpmMkZJNW9Z?=
 =?utf-8?B?bmRmOWJZc1RDeCtRYmZWeDU5UThRS0w5bmdTb29CZ1FlVWYvOXdQYkdpOUg3?=
 =?utf-8?B?L2tzam4rZHhZTDY0dm03VlBSWDE4TC9LMzlUNlYya2IxZFVtUmNKWkllZ0JF?=
 =?utf-8?B?RU9ENkpTVzlRZjNVTFhmUnlrQzJ4U3VaWkZaaGNlVlhpWnlkZkJKMVkwa3FI?=
 =?utf-8?B?ZHdTSzFEZVFYK0JQRG54bkJrYjFscEMxeUxtbU9aK1J0NjFic3doNFRiWmNz?=
 =?utf-8?B?QkRXWDBVRk1mcTVHeERDRE56cTVFU0k5OTJnbk91WHVFNUhwVGsrTkY5Vk5J?=
 =?utf-8?B?dlNsNVlKNkNvSytQb1lMdzZwYlNyMjlmcGRwNTdRcTBPR0lYcjNFbC9BWTI2?=
 =?utf-8?B?RDM4Y2pWcE9wVDVvNjdOSUJsNXZNbW5KQXJEZlNNZGJQOGN4QlZxYU13eFcr?=
 =?utf-8?B?VU13MkdwRDhqVHZnd2xtdjhrOUpkaTFDVm5DT3BQQ0NNZTExQm5tSzRsY1Mw?=
 =?utf-8?B?TlZLSktnK293Q0Zuai9NSnpqVUhBSE42d2lLT1pzcjlHVUxTVlBTTzRhNGlD?=
 =?utf-8?B?MDRNU1NCUXo5dUtkeW5EZVJINHJkR2syb3hwdENlTXBRTnhPNnR4ZmRESTJ4?=
 =?utf-8?B?dDZ4c29ZVmtZeTRtZENYL25MaG5LMEIrcEQxNmpuZkNIWkxvc3d1d3pjT1FR?=
 =?utf-8?B?N2M4WEpNY2VNWkFoamo4eDRJSmtZTFczOUJzVDlxeWdtWWpjZkx0bmpaMEJH?=
 =?utf-8?B?QUk0ZzV2MUhyaExvM0dLUUpjQ0JuQlMzaStENXlpWG9zT2dNUXE1QTNWMS9N?=
 =?utf-8?B?S0hTaUw0aFFpa1BXODVkRFB6UTV3TVg4YUNhYTRLSnN3U01nanBUK2VrbkE2?=
 =?utf-8?B?NitMMEZaV05yN050dkprSlV3OThRNk9obUl5N0pLVlZLTGc1T0RSVTNlSndt?=
 =?utf-8?B?RU5vaWRZVktMQ1RqWG5PeDlXb0hZQTc1Mnp3L01NNlJ0b0kzeDRsWFdsSzdn?=
 =?utf-8?B?d3RSTys1MTVSeVMxeHBkV2h5RjV1aTlia0ZueGdUREZFMTRlYS9HM2x4WjFW?=
 =?utf-8?B?ZGU4RmllTEdVd2NzTEpoS25BWXdxamJ4cjJMbjJpT3AzMzRiSnBLdnQ2M2x5?=
 =?utf-8?B?aHE2REVTZ2EwTTVzZjN5NVI3cE1saGVBNEFsSm9aM0dBZzM0eDdIeTY4a2xz?=
 =?utf-8?B?b05JTDFVMzJGZERkRTNQK0NubGsvR3djUWRDWjFuS1krcHFCWXF1bmhyekJn?=
 =?utf-8?B?K3V5dlRqZTgwcWNFNGRVR1RkM3YzMlAzS0VGQm5hdkVwQjNJRG5wWkdyUUpC?=
 =?utf-8?B?ZHorR3JUQ1JQa1JWOTBuYXlMaG84V2tiL0tYVCthRktMaEVVTFI4SzdCbE9i?=
 =?utf-8?B?cEk2Y09lNFN1V2lyL3BnTHozNWI4RkVjcHZkb0VHcHAydVdad0NnNmY0NnZI?=
 =?utf-8?B?aUhrT1dUVEFZM01SRnJYVVNwRStZTnVJODdYSFhGZ2h5VFpDa3dRRjFIeVFE?=
 =?utf-8?B?NXl4WWdvOGc1RWE1Z0kvY2kvdWVHNnVlMFFjNm1YNDgyYzhuRFc0NFM2RXpa?=
 =?utf-8?B?YmxkOWY4bFI0cW1pTTNvMUJ1TFJuTnlma2MzdGxmZDA5K0J6R2Z6dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ixyFq9TylCIarWSgg4BbqvyklJbDQBDWfly7ZGQN6AgjuQ7mZeoVd9xipyFtaN+0a2kLqdSJ5ZHpYG7nAXPtE9nqcKNETtvjtFM+WtQ/M3vgACEA+cZlHrzIQ4Z4PjWpx08KxbRjtw4PMTgSaTFSAXA12y4asFFfmK/FoWmVXfihft+jzlGAZNWeNkoS/v6ixIPDH0DCUt7NggH4fAVlru1L3K2EfoPVaT5eDZwIHlnmCeLr7lfPLlKQNJd00sBfkqKaXViyeovS6Vb7jxewmZPjZPTJnRee0k5spXUNNM60pdDt0LRFi6NCqp56piibRLTMnceXeJI07FFCrISVScGXncS7RAvBs353b3COvsD1DKeMiaOlKl+uUPFs4ptKh7+gYMEpdMnQOqM5d8SBlrCfxZDeMx04kqBFRcbxBChIUWU93EV5Ov8GS1sHba1V86FKAe+dlVZFg2RzZFeS9Ll2rqcNfskUkRn62hiCSVCtRn3LWddRr50Dgw9B7C2lxti5X0JqRidQQknXLeDg5l8c+13luaV9WBB8f1norsQKwFOLpN34qoPLIEpF0dsWY5H2yJ33/USLBCq5/jpG3b6mmme06AkRPwgjT3gy+oY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601f3a31-78b5-437e-6ba9-08de7097318d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 15:46:20.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGc0bU+Ho6LUVLhIlGzYy/wC63TJNNt9aC0AAo7Xw4oibRRAuM6a24z/QlXnB3ooHHqz7AfOHvBDOvSRM/0f8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF80FDA9397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=879 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602200137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEzNyBTYWx0ZWRfX//jXhAALt3xl
 BgCOCAQOUy3mFU/ZVoULmnlvHyQu+Lqemn5y6A0J2hPK1nCnksoQLAWq+L5lcBYnqu4QSV01U7a
 k2swir+cWv/Ao69ZM0B4jvXSeBNrxQaYPH/S4zftxJ644KjMmIGVQrv1RJUFPKXL97lxi+E8Gjk
 5T/c7esm+D54JGJdU6+Cuvkpntpg0XV8zpvUMo5t8Hrbd2VGyuS/wtT2w6PmBgK4DSgTQkmY804
 sanq3gf/RGVFzjUeGWRk71Mlc7QxI5JfYz8PMEuM9c5v40u0J0RsEJUYIddasjinjs0Rq9dQP4F
 ySPBGsX+HU1xUOcVodmXExqVSmvPlhEegnhNg8ve2ptGtcxqhMjiStmKmtvWGZIr2ZGvEbdR7zG
 irFIOSzEUUhk/XMEkz7JYkeNtSRJJIekkK0DjRkgjWpIJ/4OSi814Bgblb7PLVKRO5+kGNLVxum
 /ziJjyMMs/yxpE2lsOw==
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=699881d1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=suz83mM_4dGne39mBSIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZsXBHpYxVwkwexzs7GIBLZ_SQeRi8k7h
X-Proofpoint-ORIG-GUID: ZsXBHpYxVwkwexzs7GIBLZ_SQeRi8k7h
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19065-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 13864169022
X-Rspamd-Action: no action

On 2/19/26 6:07 PM, Mike Snitzer wrote:
> On Thu, Feb 19, 2026 at 05:21:06PM -0500, Chuck Lever wrote:

>> 1. I haven't been a fan of these double-subsystem patch sets. Is there
>> any way we can get this split into one set for NFSD and one for the NFS
>> client, with as little code sharing between the two as possible? Maybe a
>> pipe dream, I know.
> 
> Open to suggestions, but the reexport nature of this patchset makes it
> tough for each half to be entirely standalone.
> 
> As is, patches 1 - 8 could all land via NFSD. But the code would be
> dormant because no filesystems would set EXPORT_OP_NFSV4_ACL_PASSTHRU.
> 
> NFS _could_ just apply patch 3 (so it'd duplicate NFSD's commit for
> patch 3) and then apply NFS patches 9 - 11.
Aside from the added complications and compromises needed to manage a
merge for two independently maintained subsystems, the API boundary
between the two subsystems is already ragged and rather /ad hoc/.

The sharing of XDR definitions is going to get more complex as NFSD
transitions to the use of xdrgen.

As a general mission statement: I'm just hoping for a way to minimize
the effort to merge such cross-system work as well as lower the long-
term maintenance costs. But I guess none of that gives direct actionable
guidance, so I'll try to dig in and get to know the patch set first.


-- 
Chuck Lever

