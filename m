Return-Path: <linux-nfs+bounces-13511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DFDB1EA3F
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E7618C5BFA
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449327702B;
	Fri,  8 Aug 2025 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ljBxPJv1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uy3idHSO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4327274651
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662885; cv=fail; b=L9+FLkldWrxBWBnu51X1D8J1WWz6c5wlGbHxm+YAHBvs3DjzQ+a3WnF+L+sRy4kkJugzti2TA0QfcYTNwyBM/wzd5+LcmpwChSLr6zEYjG0q8oS8eMrcOm69EtcGGAwzGXat6TmfmZ0EndICJc39igpW4a0ZDsnWaRugGlrfo2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662885; c=relaxed/simple;
	bh=+MSMniFB20j708RZ8yCSJeTmmQU64PsilXUdv2QaM20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CZv0HghmvK6WMtQy58X4UgcTNpa7rnCnn/nWUp5Dx3MIEb/b50aOBXRZ8+u/2LyT7EpLkeujdDiWqKxRUdIa+Qe6K3nFMqCtj/H/RjkhAz50Z+8aWzgT/+946eE7T41yxYpQ2mBmQLljYwldAQ3jlcMkCBmWQ2Rwt3uHMYjzlyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ljBxPJv1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uy3idHSO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNAG3000643;
	Fri, 8 Aug 2025 14:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XBQV0k9BdOp5LiRmo5CJrI6etewXb0PI7i1KdlndMI8=; b=
	ljBxPJv15fRyJB+swwjhS6FyBmnqzBAXupEckY1HMDwZGhg5t1LmF1N7Bi1Z0yBR
	AOOJfpYR9td9SPXNK77r4QndSQZIkKAzxzgLUfHlfs/bEwn/BZBmaUyMLcC3dIgm
	us+C5UbEBh7tlLESygGoZxmyRS2SrihtQmuJjF7J9MwPMIb9QAF4h2x4zC/039KD
	k1y1Eo/8hqChojdYNeYOa2aMiMa5b9uM/3K4hC2SaQGNmb3KxRWJ2w+GaARABV+8
	eJuT5ORnSZC+WVhQADYkyQKpd3KVIj3P55DASvixUs/Nl21kUoVdZ02wBBHOQoxY
	HXmkIV+HaHuA+BCtIer5RQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy6j4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 14:21:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578Db9kZ027303;
	Fri, 8 Aug 2025 14:21:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwqt0ej-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 14:21:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWluEOz2F2BjIJy9hrTDD3WUNN9WbojEa4DxuM4L/4f77woUAKp94kvqAznGFOkqU2TPAaujFwzlQO+MGPTFslbNZBTKmH7AkDWl2scxJWMwHB9sD1wQtO+79E2BY14w9aNq3CdHQcy4TGh8v8Q0/Y3dgvM1MQ5sjBRy/q4UcBpPjDrfysyCTmDSEpVt3oF56LLgoMiys9yDi0fl/UEUT/qMwqN3Keq5w3vOSGYcv/w5lYg2otm6mx/iv4wvZvmzaCapQNMoAKHZjpK1ifRZDHUlLbqFbccECn2zuk8moKX2yFyOjI3GhOffkdN6GoWTmR4PI39Y1fbH0JvDimLIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBQV0k9BdOp5LiRmo5CJrI6etewXb0PI7i1KdlndMI8=;
 b=BwaBSh6a8kaZsdTRa4hY4xBA1ElaeKZ2b+b/00TykTu2I4prvrmn6g5PsSo3uBTmSD97XMaVlEg78vizXLmVs49yz91eE6OdUkkT/nSytF6ag52JZrDdnJOGxaJ+FZ0ceVGQ+5iWK8S3qwJrD6/jnv/w/AfOc2n2hfmDUfwyBN2tc9ApcMxdXBy8mKH10RzDXPXvDsspTHO2AcFAOfbudQvtJUFARwFDP1XtCTfsiPGEb+ajqTqDL5orhDTzKQxNQdysm8f9zI5LczHOrp30WFrqIa9+kbM2WgATN3tuMbAyYD3oa+pg3/6FdBcTi/5XEbD3+75QR9EnT6TOm1OE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBQV0k9BdOp5LiRmo5CJrI6etewXb0PI7i1KdlndMI8=;
 b=uy3idHSOO0H2UV3Zp8m+GwW/92lo9onIMhCSW5h34JehtkgRtpdnQg3vuCedCq5f5+gVupmfzNi19icfowxWBDle71che0RByXpzUERgL7TViH8x2ntNQvSdNuS+7Wt8aNj8bstyW6pzcMxCtf+Bn+V9I4b42VJCjAm5gvET1iE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 14:21:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 14:21:02 +0000
Message-ID: <5aa61423-8d99-4505-85dc-b2d4f76851e3@oracle.com>
Date: Fri, 8 Aug 2025 10:21:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] NFSD: issue WRITEs using O_DIRECT even if IO is
 misaligned
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250807162544.17191-1-snitzer@kernel.org>
 <20250807162544.17191-8-snitzer@kernel.org> <aJVhW2LEnD9VpMAE@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aJVhW2LEnD9VpMAE@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:610:20::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 8005f03c-15d9-4bd4-a488-08ddd686cdf1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MnRaVTRTalFWNGxGbTB2MnJXbG0yREtmOCs5ZEZ3NFhQMTl5N29OdTg1Qmgx?=
 =?utf-8?B?TkxiUEJrdWhjRjBRRDlBbG1DNEUvcXBLM3NjT0dEaWtMS3R4UW9UbnZDaTZQ?=
 =?utf-8?B?RUh0cVNYN0IwSlZ3c21JZU9tQ3UvQUQ0Q0xUeVVaSEdPNmE5WUNOV3pvaWdo?=
 =?utf-8?B?dUcxV2NhUmU5cEJvTEIwcG1JbHZLMWNWL2lIc0wyZ0ZtN3FUdmcwbDUvd0l3?=
 =?utf-8?B?aWg2UmpMUDRHMzBLQ2tjeEVsZ2tyVXYwTVdmL0Z3ZE0vWlpqUDE0ZnVOdzNS?=
 =?utf-8?B?VnM0ZW5jU1RFVWoyY2EzNU9TN1liOVJWQlV1dzJWMEtJNjJxdGt6UFN2VzBp?=
 =?utf-8?B?UE85MHFuLzAyUnNGOGc4dVBmRFZubjRpa2luOHVFVnpUbG9uM2E3N1RtZnJB?=
 =?utf-8?B?RGlzL0tDUSs2VHRVb1pFb3NoVkJmK3IvNDd4YVlaNGtxQnIrN0JOZzFoNG1Q?=
 =?utf-8?B?akxsd2k0ZHFGSG5RZVppczJ3U3g3NFRqL3VXa1FCTnlWRFRiQ3pjdVkzRDFU?=
 =?utf-8?B?R05SaWNJVW1GYmU1NkFIdGhwRTVuYStqWkVPY1JNcmFlV3JKRkNXa3ZoanlZ?=
 =?utf-8?B?ZDU1L1dvVkZyZkpTZ2JlUkhNSzRHWGxicDFYaGY1RCtrNHVwNFQrZ3lmd3px?=
 =?utf-8?B?OFlXcHFYZVBpUFNoWVJ1dDgrZFRmNGc5NXhsaFRYUkdPNHpvUWpadW45QVVT?=
 =?utf-8?B?QmtSYVVCRE52R1o3and4cTY3K2xQSGduUmZEa0RtZnJhTXhZZEZQSzI5T01T?=
 =?utf-8?B?UnZ5NjkzQ2Z4UWNKbk8vOGM4Unh4dkR3d0IwZnRjd2k3SnIySGllK2VMOFln?=
 =?utf-8?B?Q2R1YmxaelR4dU8vR3VaQ1ZqZno1cllvQ2NkYVZ2ZERUMExGQjkwNDR5Q0xG?=
 =?utf-8?B?MG95OTlReStVUkhTTVJXQ3kxcnkxUml6QU9lTXU0aWxSUEVGSFRaUmZmSS82?=
 =?utf-8?B?QnRoWEdYU3I3OTdndUswVGRMVkhFVmpRZ1UwSFozYm5sUHN0M2Fzb0lUbW04?=
 =?utf-8?B?dllkdXFWUlhQd3NDVHJvN3BMd0JYa2FOM1NMblc3ckp1RHdXV0Q5QVh4MnIr?=
 =?utf-8?B?dVp1Z0trRVJrUVI2Y0tkTVdOVzNYclNhYmluaTk2YWR0YUQrTVpkWVJmZ1dp?=
 =?utf-8?B?UWJ3Uy94eFZEZ29pTnVOdlVONUVZeFlkNHRLdURpOVpHeEU5OG5LaUkwd21s?=
 =?utf-8?B?UnRudkhGOWZPUmsvVGs4bkQ5TTVWUlJmakFyTkZHSlJVR25ETnBtM0ZOZU9w?=
 =?utf-8?B?SVhUaG04ZytabEN3MlFDSGtSaEZZaW8xSDNybW1OM3FoZGl3bWRlVHdoejJx?=
 =?utf-8?B?eGt2N1pDLzhyMzM2K29FL2lkM3dZZUhjcGxlTngzUll3NC9icDdWMm1LbGo3?=
 =?utf-8?B?dDdBTFB0d0tJV2taUzFIbVgzMENBRndjOWtNekFySDdGRHk1bmRGNXB5S2U0?=
 =?utf-8?B?bERjSlBudmVPUFZKUjNBRFQ0Skk5NXlQK2NGbGZYaHBIZzdFNWZ1NG11d0lp?=
 =?utf-8?B?ekdWdjJLT0hMZStGSlNrMHVWOU9CNzR5YnlZRUdqbW5SMDV4N2lQVVVEdnRn?=
 =?utf-8?B?UTdkZ3E5M25RckFGSDNFMXp6MEtuMTNmOTA0U015a0pKZkZCUDVPeDRyVlpO?=
 =?utf-8?B?RG5WMzJKMnd2OWRHOXhJRlhYMk9LVUtTNk5iS2pNZStRK0gwbVZwSWZaeEtt?=
 =?utf-8?B?VnA0MG1XQ2xWUVpxZlltS3RrUjR6WEc0RUNmd2wxZ0d1M1B3RmdJclkreTQ3?=
 =?utf-8?B?Wi9ERDZwMG9jQStPYkFXQ05xcjAzSDBKVmdWMU9RUVdQb1VLbnY1TFc5Ri8x?=
 =?utf-8?B?dUhWZnltak94WU1tZ01TK21ubHR1Ui91em1OaFBTaVQwRDZKY0Q0MU0yVElM?=
 =?utf-8?B?MVV2V28wNjF4QUVvWnYzT2ZCVERDOG10bGtTOXNvVUdnem0rSm5wcUpNdTgv?=
 =?utf-8?Q?2Tq/j/lL/OY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bkwzaWlISnJjKzFzSWd5RFhYQ24yaHNrVllDdG85S1F4dTkzTDhsTlNDTFJ6?=
 =?utf-8?B?RU9maW03TlR2dFg0TGdCb2tYY2xBc2tpdFZHRnpxZGllckJEdndoYXBNcmpj?=
 =?utf-8?B?MGJ4OXZoNTIvM3AvSlA5R0JaTEQvOVdsUUdyVnpPWUtHSlhpUHBOU2ZXQm0w?=
 =?utf-8?B?NkZiZUIvS1N4T0hqVnByYkdiZGh5YUJSN054QlMrMTRnMXpXSFpqT2ErSkxC?=
 =?utf-8?B?cU5aVkwyTDJOUWpnNUo1ZG9tV290SmZ0djc3a2Q5bkwvREVCQldZbmI0Mm5o?=
 =?utf-8?B?WklpMlJlMHBvbGdVN0QzNVdJbzY3U2tzVmQ5TG1UTWFNK1J0RGZIdkdqQ1FQ?=
 =?utf-8?B?bENpdkhlMWF3cWZpamxPUG0wVFhjSEM0akpuQTRybG90bGlFMjZFbXFqNjQ2?=
 =?utf-8?B?dVJCTDIrTlNmanhHaTFRNmp1ZitmanA4TzlLM3Zja1NtMVJpbTZiMURzYVYr?=
 =?utf-8?B?ZHd0dGsybU93WjluQ2QvWlpRWWtiVXFFUjRoNjh0OXMxWXhFNWJiZ1ZpTkpT?=
 =?utf-8?B?S1FGSlRGSXd3T3EwQW5xWVhsSEpmNEtUb3VObUhob2FqQUdJd2h2Ly9jWUtD?=
 =?utf-8?B?Q0pGMWpVSXc3WHkxTjFYWlEweVgvTU1GcjhtbXZKUGRWUy9reW9WWEZVTy9L?=
 =?utf-8?B?M0xMVHJjSm5lVHlHMWxPNVIxOVJjeFNlZnZQMnpMVFNnMFNJREw5R3dIbjRX?=
 =?utf-8?B?MHljN05aYjRLUFZJRm5SWDNRaTBqWTFrK0VFdUJMQmcrY1NYSGo4enp5UjY0?=
 =?utf-8?B?Ujd2SkdWZXlTWnFRc0xwZUhsNHdEY2Ezc2x3RXB0R0RaY0JEYnRHWGhrT0p4?=
 =?utf-8?B?cmpVU3pIbG8vYkVOSURaU3pVU0NUOG1TUnZWejJGdjFZOXNPenBqc3lKY2Jn?=
 =?utf-8?B?TC9xR0hpb3JmTTRvY2JRcFBhT2pOVDVHLzZIQXphdDhpZzBZdFlpL0lsNjhI?=
 =?utf-8?B?OE5KVFhyckVSeXc5eTFzOW5ldjQ3YllHZGpHRmFveDR4dVVoR1ZsbG1rbXhR?=
 =?utf-8?B?SktqN08zaUVGclNHUS9QWWw0L1R1dGtxNGxuWGgxQ2RjOVBid3QvMEhXODVh?=
 =?utf-8?B?YVk1OHVxZCtLbWZqeFlERG9kU3ArNml3UjVHMGFDS0dYTVgwV2RHenVpUkxT?=
 =?utf-8?B?UUtuakM1dWNRSTR3Uk5aVjUwV0s3bTB6ZzQxV0NLZVloUU4vNU82NFMveFNZ?=
 =?utf-8?B?ZUt3VSs4ZUpXMFd5NzUydE1pWXJDR0EwelR1d2lkU3kyWW8rWUNVSDMwN2dv?=
 =?utf-8?B?TFRQTXQ2a3ZjWnN1SnJnWDEzMkM3WjZPOGsxU1ZJR2N2Z3JJMnBNSE1sVmE2?=
 =?utf-8?B?UFlKcFREOFppbHNQWGhDVTdSc21IeEhYM0VpWEw1M2tHZVdQWGNhcFZrOFc5?=
 =?utf-8?B?NW4vMnFmZHRVTUc3ZWpCQlc5blJDOW1TRGJKVkRvWWJqUTEvYUE5QlJ0UDc0?=
 =?utf-8?B?MXRQTENiR2pySUIzQ0hDUEtKRG1FdFNUVU5WOWVmMDZKUlFNL2F2U1VPSTJ0?=
 =?utf-8?B?ZmdQcnVKQy92enJocmZ2TjRsbTYydmNKVUdSS3FOeGpnU0xKdGZCMnkzenBR?=
 =?utf-8?B?emhFdHRESnIvR0IyZDVpMjZiZUR4THNpd25vUUs1ZDhQcEtxYWdCWmkyOTBa?=
 =?utf-8?B?U3dDTUNBTFVCR1BraTVEdlZQb1VBT3ZoaFBHT01ScHdTVzllczhDbGNna25y?=
 =?utf-8?B?Y1EvQXF3VVpkMkxqQ0JKNlc0YkhFNEljVSt0Y3BBL3FZanA5WllwUWs4SzZo?=
 =?utf-8?B?YzZqNFQ3RHM5c0wrb1R1N3dWM2ljS1pPcFZ4Rzl1TG8vQ01Pek5kanBLVWdS?=
 =?utf-8?B?d3g3SlBWRUxWZFhMUkJXVGtjZ083L2pDNjVJNFdaNVdaemIwaExIVW9OREV0?=
 =?utf-8?B?NlhGSXFxZjkyRktoa2hYWG50azV1RUFrdXpuRXlpME80aDZ4VnFXNlVzU3ZV?=
 =?utf-8?B?ZDEwV2xnMmhoclorakNIZzA5UWxnamh4cXpCQitjQ1l4TklGMVRjWEJJTWRI?=
 =?utf-8?B?YzZnWHVDNUdyb3dHaXpCUXRjYWFsVDVFSm9tcTQvL0hTUXZ2OURBdlAySVBw?=
 =?utf-8?B?K3U0b01senlrdXlEYkR6L0lxaXAzMW82eXltcDFISHI5WXFLUlBCWHlNVUtV?=
 =?utf-8?Q?8JtVc/WIKH17iQGsreO2FaWc+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S30CKlt4AmH0X6Zddt3TJP/2wvAWHp+JKai4Enx5ETHiUtQScull/hDq/1Y2NvNc2BtEkEjitUSbtx7YbkWvqG3JEhRxILPfB2Jqy8CDKDbTBZ+1DwSQL+kNTtJZU7Q4a5VDSZMF3f2A0nfrMMMGQ1oJ08VERnC7KIs+u0Sf2I3LOr1MUr1rPXJzxgc1g84RXclBdKoUa2sO1Xt5k+tRVFklIuaa6P6ZuAGeu4+trNX2cmD5Zor27YLn6sNTozTRhpQl7gefv/3iBTC7tUwDPRUE3TAKxqzCUzEewzACRhNlkjFl+o0Hd/xa0Rj4Izt1Hk6DZBbrtlDzDs8SG8qicfWK9/iPCneEHrMdohhoqoFsY8NgR85OBRZMmPjPyc7l5GGXeDy3H0GLcdxJmjvgy81Tog3Qcn4b/w1qg+6IMSR6xXZ2H8T1/tfrmmPmHLiqSPT583ApQdJfPN6ceZeTAUssC97DIs056IW0qtZJ7HrDPKYhWBfC3y1hDJKSyHMtNRu/x/jcRZranm3tjSlQPdLQyH2uY1WZRjv5l2P7buQymDv1jpJDMm3iEs3yiaVk5Yw8pcjFSLoDfeJveSlmuc9Zz4x9/41FwYp8qHt2gaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8005f03c-15d9-4bd4-a488-08ddd686cdf1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 14:21:02.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iwiwvc6SEh7h3i1kGxrnLirWiRK9uG7dvuoDk4rS+QFA6k47ul/nRtBwZOJfQyaIXJupKF7Fq04lx8QyDJi95g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080116
X-Proofpoint-GUID: MBjptmb8spyCt4WJhgBBA9IfZCIEv1sn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDExNiBTYWx0ZWRfXyvQFPU450WSo
 ViSRIdFEjjgO85EYOOqq0MCq656krn1guMFZq7aCNZ4xg71R7CXEyM6UwUTxxBNrYdy1y91DTyx
 SDhTT43qdRUdxCFcb3ujmI0a3taBMJC7oL5j7bFZq77iBaG9dTvQgXIM5HYqRAwy6A4f417Mxp4
 kWgCYKBi242WlFy8PNL5euXnVZJY7AMZ4CxKu+FU3F4rt17PLDRWrksZ00Ds23yWFxbF3oxEHAe
 rMDdztrA70wVfk7xLeocjnijl7wIZWvRplSoy6zWk6hgoMXHXe3/ZJqr2Fg0xRgNmAAJCsOsRvu
 Nc/Aew16pJJV593TDxcBySfI6GkyW0PvnBP0e87yTSZsZuVnmzCAPNUPXMWOXTZ9RWHjQjm5R0t
 9io2p8f9N9MYyYKHT4UG1KR5EvYWACOKrEQVEqwdiv/Q0ucQjITcEHIvhP5qos6z1dkz9Rfe
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=689607d8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=AeksLOLxZWj_dXOUX0sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MBjptmb8spyCt4WJhgBBA9IfZCIEv1sn

On 8/7/25 10:30 PM, Mike Snitzer wrote:
> On Thu, Aug 07, 2025 at 12:25:44PM -0400, Mike Snitzer wrote:
>> If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
>> middle and end as needed. The large middle extent is DIO-aligned and
>> the start and/or end are misaligned. Buffered IO is used for the
>> misaligned extents and O_DIRECT is used for the middle DIO-aligned
>> extent.
>>
>> The nfsd_analyze_write_dio trace event shows how NFSD splits a given
>> misaligned WRITE into a mix of misaligned extent(s) and a DIO-aligned
>> extent.
>>
>> This combination of trace events is useful:
>>
>>   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
>>   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_write_dio/enable
>>   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
>>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
>>
>> Which for this dd command:
>>
>>   dd if=/dev/zero of=/mnt/share1/test bs=47008 count=2 oflag=direct
>>
>> Results in:
>>
>>   nfsd-23908   [010] ..... 10374.902333: nfsd_write_opened: xid=0x7fc5923b fh_hash=0x857ca4fc offset=0 len=47008
>>   nfsd-23908   [010] ..... 10374.902335: nfsd_analyze_write_dio: xid=0x7fc5923b fh_hash=0x857ca4fc offset=0 len=47008 start=0+0 middle=0+46592 end=46592+416
>>   nfsd-23908   [010] ..... 10374.902343: xfs_file_direct_write: dev 259:2 ino 0xc00116 disize 0x0 pos 0x0 bytecount 0xb600
>>   nfsd-23908   [010] ..... 10374.902697: nfsd_write_io_done: xid=0x7fc5923b fh_hash=0x857ca4fc offset=0 len=47008
>>
>>   nfsd-23908   [010] ..... 10374.902925: nfsd_write_opened: xid=0x80c5923b fh_hash=0x857ca4fc offset=47008 len=47008
>>   nfsd-23908   [010] ..... 10374.902926: nfsd_analyze_write_dio: xid=0x80c5923b fh_hash=0x857ca4fc offset=47008 len=47008 start=47008+96 middle=47104+46592 end=93696+320
>>   nfsd-23908   [010] ..... 10374.903010: xfs_file_direct_write: dev 259:2 ino 0xc00116 disize 0xb800 pos 0xb800 bytecount 0xb600
>>   nfsd-23908   [010] ..... 10374.903239: nfsd_write_io_done: xid=0x80c5923b fh_hash=0x857ca4fc offset=47008 len=47008
>>
>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>> ---
>>  fs/nfsd/vfs.c | 183 ++++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 170 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index be083a8812717..1b5aa3e6e6623 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1315,6 +1315,167 @@ static int wait_for_concurrent_writes(struct file *file)
>>  	return err;
>>  }
>>  
>> +struct nfsd_write_dio {
>> +	loff_t middle_offset;	/* Offset for start of DIO-aligned middle */
>> +	loff_t end_offset;	/* Offset for start of DIO-aligned end */
>> +	ssize_t	start_len;	/* Length for misaligned first extent */
>> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>> +	ssize_t	end_len;	/* Length for misaligned last extent */
>> +};
>> +
>> +static bool
>> +nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> +		       struct nfsd_file *nf, loff_t offset,
>> +		       unsigned long len, struct nfsd_write_dio *write_dio)
>> +{
>> +	const u32 dio_blocksize = nf->nf_dio_offset_align;
>> +	loff_t orig_end, middle_end, start_end, start_offset = offset;
>> +	ssize_t start_len = len;
>> +
>> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !dio_blocksize,
>> +		      "%s: underlying filesystem has not provided DIO alignment info\n",
>> +		      __func__))
>> +		return false;
>> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
>> +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
>> +		      __func__, dio_blocksize, PAGE_SIZE))
>> +		return false;
>> +	if (unlikely(len < dio_blocksize))
>> +		return false;
>> +
>> +	memset(write_dio, 0, sizeof(*write_dio));
>> +
>> +	if (((offset | len) & (dio_blocksize-1)) == 0) {
>> +		/* already DIO-aligned, no misaligned head or tail */
>> +		write_dio->middle_offset = offset;
>> +		write_dio->middle_len = len;
>> +		/* clear these for the benefit of trace_nfsd_analyze_write_dio */
>> +		start_offset = 0;
>> +		start_len = 0;
>> +		goto out;
>> +	}
>> +
>> +	start_end = round_up(offset, dio_blocksize);
>> +	start_len = start_end - offset;
>> +	orig_end = offset + len;
>> +	middle_end = round_down(orig_end, dio_blocksize);
>> +
>> +	write_dio->start_len = start_len;
>> +	write_dio->middle_offset = start_end;
>> +	write_dio->middle_len = middle_end - start_end;
>> +	write_dio->end_offset = middle_end;
>> +	write_dio->end_len = orig_end - middle_end;
>> +out:
>> +	trace_nfsd_analyze_write_dio(rqstp, fhp, offset, len, start_offset, start_len,
>> +				     write_dio->middle_offset, write_dio->middle_len,
>> +				     write_dio->end_offset, write_dio->end_len);
>> +	return true;
>> +}
>> +
>> +/*
>> + * Setup as many as 3 iov_iter based on extents described by @write_dio.
>> + * @iterp: pointer to pointer to onstack array of 3 iov_iter structs from caller.
>> + * @iter_is_dio_aligned: pointer to onstack array of 3 bools from caller.
>> + * @rq_bvec: backing bio_vec used to setup all 3 iov_iter permutations.
>> + * @nvecs: number of segments in @rq_bvec
>> + * @cnt: size of the request in bytes
>> + * @write_dio: nfsd_write_dio struct that describes start, middle and end extents.
>> + *
>> + * Returns the number of iov_iter that were setup.
>> + */
>> +static int
>> +nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
>> +			   struct bio_vec *rq_bvec, unsigned int nvecs,
>> +			   unsigned long cnt, struct nfsd_write_dio *write_dio)
>> +{
>> +	int n_iters = 0;
>> +	struct iov_iter *iters = *iterp;
>> +
>> +	/* Setup misaligned start? */
>> +	if (write_dio->start_len) {
>> +		iter_is_dio_aligned[n_iters] = false;
>> +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
>> +		iters[n_iters].count = write_dio->start_len;
>> +		n_iters++;
>> +	}
>> +
>> +	/* Setup DIO-aligned middle */
>> +	iter_is_dio_aligned[n_iters] = true;
>> +	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
>> +	if (write_dio->start_len)
>> +		iov_iter_advance(&iters[n_iters], write_dio->start_len);
>> +	iters[n_iters].count -= write_dio->end_len;
>> +	n_iters++;
>> +
>> +	/* Setup misaligned end? */
>> +	if (write_dio->end_len) {
>> +		iter_is_dio_aligned[n_iters] = false;
>> +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
>> +		iov_iter_advance(&iters[n_iters],
>> +				 write_dio->start_len + write_dio->middle_len);
>> +		n_iters++;
>> +	}
>> +
>> +	return n_iters;
>> +}
>> +
>> +static int
>> +nfsd_issue_write_buffered(struct svc_rqst *rqstp, struct file *file,
>> +			  unsigned int nvecs, unsigned long *cnt,
>> +			  struct kiocb *kiocb)
>> +{
>> +	struct iov_iter iter;
>> +	int host_err;
>> +
>> +	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
>> +	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
>> +	if (host_err < 0)
>> +		return host_err;
>> +	*cnt = host_err;
>> +
>> +	return 0;
>> +}
>> +
>> +static noinline int
>> +nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> +		     struct nfsd_file *nf, loff_t offset,
>> +		     unsigned int nvecs, unsigned long *cnt,
>> +		     struct kiocb *kiocb)
>> +{
>> +	struct nfsd_write_dio write_dio;
>> +	struct file *file = nf->nf_file;
>> +
>> +	if (!nfsd_analyze_write_dio(rqstp, fhp, nf, offset,
>> +				    *cnt, &write_dio)) {
>> +		return nfsd_issue_write_buffered(rqstp, file,
>> +					nvecs, cnt, kiocb);
>> +	} else {
>> +		bool iter_is_dio_aligned[3];
>> +		struct iov_iter iter_stack[3];
>> +		struct iov_iter *iter = iter_stack;
>> +		unsigned int n_iters = 0;
>> +		int host_err;
>> +
>> +		n_iters = nfsd_setup_write_dio_iters(&iter,
>> +				iter_is_dio_aligned, rqstp->rq_bvec,
>> +				nvecs, *cnt, &write_dio);
>> +		*cnt = 0;
>> +		for (int i = 0; i < n_iters; i++) {
>> +			if (iter_is_dio_aligned[i])
>> +				kiocb->ki_flags |= IOCB_DIRECT;
>> +			else
>> +				kiocb->ki_flags &= ~IOCB_DIRECT;
>> +			host_err = vfs_iocb_iter_write(file, kiocb,
>> +						       &iter[i]);
>> +			if (host_err < 0)
>> +				return host_err;
>> +			*cnt += host_err;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * nfsd_vfs_write - write data to an already-open file
>>   * @rqstp: RPC execution context
>> @@ -1342,7 +1503,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  	struct super_block	*sb = file_inode(file)->i_sb;
>>  	struct kiocb		kiocb;
>>  	struct svc_export	*exp;
>> -	struct iov_iter		iter;
>>  	errseq_t		since;
>>  	__be32			nfserr;
>>  	int			host_err;
>> @@ -1379,31 +1539,28 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  		kiocb.ki_flags |= IOCB_DSYNC;
>>  
>>  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>> -	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
>> +
>> +	since = READ_ONCE(file->f_wb_err);
>> +	if (verf)
>> +		nfsd_copy_write_verifier(verf, nn);
>>  
>>  	switch (nfsd_io_cache_write) {
>>  	case NFSD_IO_DIRECT:
>> -		/* direct I/O must be aligned to device logical sector size */
>> -		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
>> -		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0))
>> -			kiocb.ki_flags |= IOCB_DIRECT;
>> +		host_err = nfsd_issue_write_dio(rqstp, fhp, nf, offset,
>> +						nvecs, cnt, &kiocb);
>>  		break;
>>  	case NFSD_IO_DONTCACHE:
>>  		kiocb.ki_flags |= IOCB_DONTCACHE;
>> -		break;
>> +		fallthrough;
>>  	case NFSD_IO_BUFFERED:
>> +		host_err = nfsd_issue_write_buffered(rqstp, file,
>> +						nvecs, cnt, &kiocb);
>>  		break;
>>  	}
>> -
>> -	since = READ_ONCE(file->f_wb_err);
>> -	if (verf)
>> -		nfsd_copy_write_verifier(verf, nn);
>> -	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
>>  	if (host_err < 0) {
>>  		commit_reset_write_verifier(nn, rqstp, host_err);
>>  		goto out_nfserr;
>>  	}
>> -	*cnt = host_err;
>>  	nfsd_stats_io_write_add(nn, exp, *cnt);
>>  	fsnotify_modify(file);
>>  	host_err = filemap_check_wb_err(file->f_mapping, since);
>> -- 
>> 2.44.0
>>
>>
> 
> Embarrassingly, turns out I only tested the NFSD_IO_DIRECT case prior
> to submitting this v5, if the 'nfsd_io_cache_write' debugfs file is
> never written it defaults to NFSD_IO_UNSPECIFIED.  But even if that's
> the case we need to treat NFSD_IO_UNSPECIFIED like NFSD_IO_BUFFERED.
> (that is how nfsd_vfs_read behaves, but I missed this in
> nfsd_vfs_write when I refactored the code for v5).
> 
> This incremental patch fixes this oversight, Chuck should I submit a
> v8 or you're OK with folding this fixup (if the rest of the code is
> OK)?

Hold off on v6 for now. Let's wait for more review comments.


> Thanks,
> Mike
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 1b5aa3e6e6623..b529754a20bd5 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1505,7 +1505,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	struct svc_export	*exp;
>  	errseq_t		since;
>  	__be32			nfserr;
> -	int			host_err;
> +	int			host_err = 0;
>  	unsigned long		exp_op_flags = 0;
>  	unsigned int		pflags = current->flags;
>  	bool			restore_flags = false;
> @@ -1552,6 +1552,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	case NFSD_IO_DONTCACHE:
>  		kiocb.ki_flags |= IOCB_DONTCACHE;
>  		fallthrough;
> +	case NFSD_IO_UNSPECIFIED:
>  	case NFSD_IO_BUFFERED:
>  		host_err = nfsd_issue_write_buffered(rqstp, file,
>  						nvecs, cnt, &kiocb);


-- 
Chuck Lever

