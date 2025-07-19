Return-Path: <linux-nfs+bounces-13160-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA02B0B09F
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Jul 2025 17:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4113BF0B8
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Jul 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05382874EA;
	Sat, 19 Jul 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KP3D9p/z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s0kp5e2I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A11A315C;
	Sat, 19 Jul 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752938857; cv=fail; b=JBnynZ2/5wg8abPzyhT0gYHPtD+HU5kv7JN0UXILn32RBy+TOVMFes9zcSKEcu9dQKvB/GJBwK+pHWcps6GV7otRmirG6K8RXsRA3FDlbvZ+OjMfm2W/VzabMfFPh34JCHNsSvGXebfb08KN/Jub49xiZpmGsOu7td1/wX05/hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752938857; c=relaxed/simple;
	bh=LLSQML0/KQ4HpybwwDQTHkt0RLx/rtsTvkjWsIbz4Ig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JEbTn+GehrX0gZWbGukGwb5Ay7B8x/fjL0rxTmGt1Leq1uQD4/1F+dvwgN7+mpLoRPrsHhWz5jUKB0pm6qn4N7fegHkaT9lQFvIv/v/ZNyLAg2pT3fpFwf3ZIrvAq6IwY5xqmX2a55aoIsqEncVUUNy8Db81DXt8bT2xmOqZUwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KP3D9p/z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s0kp5e2I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56JFBV2U015700;
	Sat, 19 Jul 2025 15:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d4dzLY9kx4NtOM3ZR+Km5u8qbeg7H2s/518HYDpMAhM=; b=
	KP3D9p/zIcbXTVsN7PyOAuelmWT3oHkCX7sxfk43vqKNjgJPeG7dMWJk42aQdDwl
	dMpRHQjl294gYNhIf5h75mOn4M9xAASo13+ha6Pc51dUHTdrxv9r1wfdzzNNUf9W
	+tnrD3KuWGkxJ6uYze/t5kTVSBYYkkHCmThzMo55wsAXy15l62rrVIRfV9vs+a9Y
	Iv73V5Nhh80nHYq/2/2e/MniUYvLD2gk7w+gePQoCXTatP5Hp5DGzLewTjAZojXb
	nHqEzN4NkiozuxFryizNtMzoujgBgJbKKZRMYmDsbgjp/58AJHVNXkCdwa1s4P9z
	FWPwGUPtGKsqxdHgmGuHXQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e289xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Jul 2025 15:27:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56JFK4mZ037743;
	Sat, 19 Jul 2025 15:27:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801t6mama-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Jul 2025 15:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cg3VcmDt++x/7hTraruYKaXCoFAO0t5naNPljRWGU75WN/SxpSfu0ZqUXpFOFJGy4b+xahFd+8Hr1gmjGLBe1nrtUhiW8oBzUckMmAet6wcsvqsTHSpF/u/tQFs8MW+q1aUupK5N1Zo31pVANDUPpTBnCT0HLExn+ejo1QCv97UotPt/0VAtxKybzFwy9dTUx1bkHM7hq2+yhyWRQszWR2nvKH6+LOjS8o2GQaIdIiip38V14DZRKMq4Gas2W3GbM1ddeoNts3Jht3tEEpPLVVvL/WPJSLNKS+k8y/PFF37wIXYkYIJCkSIfK+2RKYON/iTlhXkrI5sN9wvTgJzUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4dzLY9kx4NtOM3ZR+Km5u8qbeg7H2s/518HYDpMAhM=;
 b=w5VwFf4sawEYMA2kQ+1rYcDNrmU40WL5Ykzhq3/+7V20Xr36zcCQ1+GekVXSQFPP9oDa3LJ/75UNBWhO9lHx8edPwIrQAQG2dkUVL3oSJCrI0P7CRa1w1+jUzaWfE6M4mNmx2O683uBStK/lBD/bPaOLnM7QXSh6bznbKggvns0PzDiqPV3bmnAT1J3EFH5aziLj9FC52KOOj3IPc/5GO2gqjcHiJ9CsaZcsikep6x1ljb0Wha1qJ2jq9DU5/ilkh3RuDYT/q/snT2wu9Yvu0IJ9LuCpHwowctvitwpUCpVejbpV+saPLQS/e6pmg5tSvaAOAUBB31vyc4vWQufcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4dzLY9kx4NtOM3ZR+Km5u8qbeg7H2s/518HYDpMAhM=;
 b=s0kp5e2IFHwEz30vqoXFIs0N8uZIDT9zWBZt07eA8EaIdHVo1TGg5PZ/rP1nZGMjG98lIrwvKJmZinwwIcCp3h7OzqPEsoJA2guqMGla2/FJmQu/3OkTBJSnXUkl6vj/aLhvgmwrmTbIVJAyalsFskGdBNH1pPqljnEs5GVQp5c=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Sat, 19 Jul
 2025 15:27:27 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.8943.028; Sat, 19 Jul 2025
 15:27:26 +0000
Message-ID: <d8266d7d-c475-4114-bc05-6e46c8ec16bf@oracle.com>
Date: Sat, 19 Jul 2025 11:27:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Rework encoding and decoding of nfsd4_deviceid
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250719113730.338129-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250719113730.338129-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:610:52::37) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|MN2PR10MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 1788eeb8-1e62-44b6-48bc-08ddc6d8c379
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eGNwRkZlUCtMYi9ublhDbjJEUi9CQzhjZVlvSTA1Y21LQ09wZmZhbmI3SE5Q?=
 =?utf-8?B?UWdpTzAya2ZWWWQxSDZNVERQc1BnRXV6RGg4bzlvdDZjSUdhMzMvR09XUE9P?=
 =?utf-8?B?amhSRmtJMElSQ3NzN1JRTENBMDM0VzVha3RITW8vZ3ZCMnVERjNITmlYb3ZU?=
 =?utf-8?B?L2wydi9EOUJ0T2pLSU43M3BlSDZCNmVzOXNGWGp1ZXBUTTg1UVZiTzRYci8v?=
 =?utf-8?B?OUJzMm1xakZSVjBmT2hNT1IvU0h5RG8yQVhINVZRMnRmcGNSLzRJcVd0THpr?=
 =?utf-8?B?RS9jc0w5dE94OFVaMzUzeUhPTW82MnI5aHpLaHlSQThnTkxFOU9Tem9UaGFj?=
 =?utf-8?B?KzdPMFBHd01OZG9jV0hpekpiNzBUazVpblNaa2NZTjdVR08vdmZSUTMwRE9p?=
 =?utf-8?B?WWxsMUpPbWpPS2xqenE5blo1eTJscFZZRWtHRG02dGJPWkQ0bGhWVCtaU25R?=
 =?utf-8?B?NDdLYjUzdWRheW5jU2lKN01HUWRmbnJoMDhGQlBNbEFBNi9oL1diaURqRmVD?=
 =?utf-8?B?aGFUUmtjQUc3STYwOU1VVzBPdndLV0FZWVprSmJIdW4vdU8wK1hGd212Q2k3?=
 =?utf-8?B?MDRpRmh5c1JYVXF4cjlrRnJDcHNJa0hTMTJMSHVySytpWVFLS0NyL2lyZDhr?=
 =?utf-8?B?UzR6enNsOTBwcHVRU3pkYkVva3o2SU9SdXdpcndVMS8vcDhnM2hTdTV1bnJa?=
 =?utf-8?B?VFFISXhVSldqd2c4OC9SYnk1M05zTS9WRVhaTGdObFRlc2JGSnFKa0ZqNUpi?=
 =?utf-8?B?cnN2azR1YTh0OFdzOVdtbFZTQUNId1hqSU9TTndGRUpkZGdkdzkzVmJtQUc0?=
 =?utf-8?B?alF3bXdLMGJ5WlpMU1ZzZWM4MzBBcjM1UzYyNW1NRFNOMmM5MVpGZ3ppUTZX?=
 =?utf-8?B?eTNuTFpwZFhFNyszaE1aMmREanA0aUZoZkdsV0N6bTlGQkF5Wm5RL1FMTXBX?=
 =?utf-8?B?VWFsaWhISGk3V0ZtcUNFRlc3REFwcXNYYThxL3NXWUNHSFg5Q3lQeGxLMDJX?=
 =?utf-8?B?d2d0VTFYZ2x6WjJEZVQzNTZ6ei9IUGJmdFpDaW15cFp6L3NSRDE5Y1QzU2xq?=
 =?utf-8?B?dUZNOUEwc09iUXJjSmc2eHB0QnNocG1CdFdaR2cxcDVLUmxqLzl2Umc1YjA1?=
 =?utf-8?B?cW5pdDBjVW9xaUQ1eVpFM2V4V3VhbVNjNFRFckhwQ3pLNjNlSzZYdEF3Q05Z?=
 =?utf-8?B?dFdZOVNuQTIvNEx1aFRnd2oxQlVua1JSbjFsNmpEakRzcHArSDkyd1RIVmxT?=
 =?utf-8?B?QXFyMlN3SlRUQmgyNTEvdTJ1MGhNQmhOV0l1VkpmOUUzRFNWR1VYaWE4VXIz?=
 =?utf-8?B?UXlaWGZjRnhHandGM2gzTCtSa1hiMGpKemhGbWV0Nm1XR1BDVXdmVHd5Nmp0?=
 =?utf-8?B?bnVwTWdNQ1UvMm9tbzNHSGhkQ0MxOUtaN3E1VHR5SEJRZU54Q1dBMzVBY2FQ?=
 =?utf-8?B?cmJGSHJvMjJNN0tXaDA4aHJoVkdjUDgyMHlydGFJTzZYYm05dWJpSjM3OEpr?=
 =?utf-8?B?K0pEeXp0bWZmYjBjMENERi9jZUpLdFRwNWthRWhxa0JDL2Y5Qm5NN2Y4UjF0?=
 =?utf-8?B?THpnNjZ6dHlRR0RyNXVCenIzMjZFUU9tYzZrVVlHYW14eUlUbnVTWE1kUG0z?=
 =?utf-8?B?YVNIUllHRjl1T3EyT0VPOVQ1cHM5b1ozNVJlNUFtdklWTXRBbGtvL3FSWE03?=
 =?utf-8?B?U2I0Z3ZSbExFNWN2S1VBcG5tTUtWUloyS1NYMzU4SlUvZVJTc3pZQnpxZG5z?=
 =?utf-8?B?aS9kTk1jNGFIQXVRWTJHc1ZlNjByTFN0Q0gxMXhqanEzSEJubEY4bllJOTRs?=
 =?utf-8?B?ZXE2cHNLZjkxNUpsWmhVNytVNzlyc3FORGVpUzk1NlFyYkZPNnhXanYyUzVp?=
 =?utf-8?B?SEhaWGdyM1M3VWZ0YXZLWUFuOWVVTE84cTBLUWU1bHRWbCttNkg5eXg0ODB5?=
 =?utf-8?Q?cG8dldyANQw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K1ZUekwxbXlyRWtaR1AxMFUyL0RHcWpuVmMxRThpOHZOckw0VUJCQ2FOSlpj?=
 =?utf-8?B?TUZqSVhwVlBXTmpGOWVVN2o0dXZBeW50NStCcG52RkNrU1p4dFNkUU1OeVp0?=
 =?utf-8?B?aHd4dGp1VUxDTjREb3NOMUd3b3ZiTGYyUTUrdEg1VHNkNmdnaTEvNW1ybkc5?=
 =?utf-8?B?VGhBdDUyNDkrWGRaS25kMHVPbkR1R0R1VWJ1aDNtSlRZaVlNVTdSUm5oL0xU?=
 =?utf-8?B?bzhnOEg2WnpESUdwWGlMSGdQem5FTWtNZ281TDNDYzFqUU9DYXBES3FhcmVK?=
 =?utf-8?B?OVlPZU5HNDRRVmlJZ3huM3VRVkJsTTNBWXMwNFZTdk1WWkJ3dmV6V3Z6V0FV?=
 =?utf-8?B?c2pjOHYyNG5zck52MGd3T1JRT1N6S1Q2Sis0Q0hsK01wTGx3alBnN3JqYWRR?=
 =?utf-8?B?SU83MC9lS1Y5ZjJMRFlqc2JiUXVMUlV1KzZGbFM5UnhrMDIvZ3IxdlpuNTQ4?=
 =?utf-8?B?T050WWRBMnI1UzZ3QTY0UzJLMVNtL0Q0emhTVSs3ZUMrcVBqU3llSUp6cXpp?=
 =?utf-8?B?eXI3S25SMnpTY05sYlE0dVVXOFljSEJQbkh1RUhWMFp6MCttcVNZMHJPS1o2?=
 =?utf-8?B?bnBsWituYU10dUtLbTZ1L1hWV3dhTFdJdHlLUWVhdGhNTElNSTJhYXpNellB?=
 =?utf-8?B?VE9GOC9tbzdxSk1QWiswTE1kTFJJWWQwTyt3ZnpiOUN6NUhJL01BMFdudWVh?=
 =?utf-8?B?NmcvRUM1RXZhem9IS3U1TStMdEJVeDZIbXNHUEk0NVZQb09WOGREUituY0hp?=
 =?utf-8?B?VWtJUzdyUmF1ejJoaFNPeW5jUzNGZHJLSEdkRWNWRjdLZVRKeTBDNWpzY3Bo?=
 =?utf-8?B?NWVCZXkrQ3FsYVg1QjIvK1dRdTZmSzVUY2JxV2JNTDRaRXVBQmZBZkVZVlNS?=
 =?utf-8?B?dkZIb09jS0JIcUNkTjVBNzRCSWpRSnRiNk16SGRmL3E2THQwN0Y5M0s0b0xB?=
 =?utf-8?B?VnRZOENmWHN6cE9IaTB1cWUwd0ZoOWJzeDFsbXhldFB4czNSMytMdUhWY1dk?=
 =?utf-8?B?Mmh3WUNBZnhOQzE2dkhsZjdlcGZ6a0MrSTBLMlduUFRWbFhnQlBseWJVdSsy?=
 =?utf-8?B?a3R5bjdrZ3pMcjRheXBsRTE2R2NhbkZMUW43WS8yR1QzTWtpZHdvWnhoN0pP?=
 =?utf-8?B?eVBwTzNpU1VrSVhJL3lqdjlMSlV1NzlTQytXcksrSEFlVnIvemtIOXV5MmU3?=
 =?utf-8?B?cDNva1VXVFdiSEUrOGFIT1Y4UnZPVU1UNUE3Mk8wY1VLZXY5NjcrYXdyYnVx?=
 =?utf-8?B?aHo4TThGRitGZksrcXhXRDdxNWNXN0VkQSs1SlVQMXEvQTVYeFdGZmRUS2dx?=
 =?utf-8?B?d0R1VVNEVFl1UE5jaEcxMjh3SllwZy9yWGRxWlV3RHNaZU83WmZDa0F1OWJv?=
 =?utf-8?B?b3pBMEhGNjlPNmtxMEF6N0wwcU9iemhXZllZNVBaN2doemxRa1hsemdyLys5?=
 =?utf-8?B?UmVWQ0EzbHNhUDRLajQ2TnJFeGRwWEY5ek9IMkRJeFpqN3lHWmZmZTBzLzUy?=
 =?utf-8?B?dkROQmxzL2RnQ0pWdlRxbUdZTmI3ajBNNlRVcy96d3kxbk5VUmwxdmM2bC8y?=
 =?utf-8?B?SWhrZ2tZWkJxVjBSWFhJejVKdnN0cFM2YUdOa0pwc1RtZDFxaWg0ZnFxYlVR?=
 =?utf-8?B?R2ZyZS9WNjh6RE9qbCtLV2szemdsUi9FTVVZei9wRUFzUXhyVkNWaVplUTRw?=
 =?utf-8?B?OFFXUFp4djJ3NE41bmlkQ2RWa1c2eTl5V0pyaXRDZFd0YTI4aE9HNVVGMmlW?=
 =?utf-8?B?NGR2OWR6Z2UrWmw5OWkveTFOeXprbFhNTUljdGg2YmdhNG0yVkVXOVQzOCsv?=
 =?utf-8?B?TVJmSXM2c25QNFArZXI5NTB0YS9BcWQ2Ulpqc3p6bUVoQVhvNHJuVnlMY2dJ?=
 =?utf-8?B?VEhEV0M2RUhodUo0dGk4Sm9tN0ZMTVRjNU05WURGNUJYVy9ZRFNibHRkNW1s?=
 =?utf-8?B?L0V2czBUMWQ4alZPVE1keUxZbVREdGt5TFVtam9vanpnVDExVXptSEhjK2Zp?=
 =?utf-8?B?ZzV5bFo0M1RENHUvOGFQOFBZdXpQYVN2RTZia2xMYUg5NkhTQ0tUUVlTUzVN?=
 =?utf-8?B?K1ZGb21SMEt6c1piVFpIME5sa2NCZVF0SGY0NE1sdld1cmUwLzFIOHgvQzdP?=
 =?utf-8?B?QzZ6eXplSnZxUTZ4MFkrbHFtWDVJUU9IQmMzU3g1L1ZxSHVldHF2OUU2WDRr?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MY4JE3XBNev7xtRHKSe6V4Zry3pQz4W3UfAFNhqt47/EU69NUlTIleIdz5L5s35c2tMUmZ0HqHhIojp0cFZKKxl9STGGka6keL+c6W4m9IqLf6tZ8FcyQvHMtsgToetzlaY4XquyEatBauIZqoNCIqOtBMRQc4WkLlG6zA0oj4j+M+g+bQ3tcwAIUkajb65KTXQB9Oh5NqeaLb5/FaefsYTE+mF2AOFtLfh4nMo/YpIoVpeS3uC4FTk8WrhCbrHqn6+fvDZlFyoOXIfdWze0Rj9gBTlO5qO/+X0WT72wNx7IjsSV8YSDDCTTcGCPG7Z7W//2SegaC2zIWE8Hvld2A6Z7G9+WvAgGBKAnFb8/FtTIeiXmVDp3Aq/VWA1OBd8Hdr1sUoW/MonqKf972upW5rOe5ZIIfe+bsAqjCVa53YJ1Q4YJbszYmiX0biNn5T8WckH/SX2VgKB4qne3nDZXvzeR36cKq2K4wWSMWQgudJ8RPZZ1yO+5BFxl27DgtGiAYPykGVEIxxOK/8oSg3nLgTsnqiIP0f8UXmf7PkT01sLVo1WKcHdI0V30vXjGoEZaHmcA/l/8TungPsKuAxUA0mh2C3P/bT5dXNFzw3ko+PY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1788eeb8-1e62-44b6-48bc-08ddc6d8c379
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 15:27:26.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo7iEvswMPEfP/3GmKbgIyczM/yk1Ng01qMpdzZrsI1RFOXsWu8el/0VXpEQVaLpsp0H3GPfryFn5DhY5tCkoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507190154
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687bb962 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=pGLkceISAAAA:8 a=oN3sse48MwF8nJORSpcA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: ffyXqMI1VnA4dUCgOxY7wt41MskNmCo2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDE1NCBTYWx0ZWRfX62Z5B+GpivSn
 bOImFSOSnMAcLyxQxGch2GKEGIVqO+F/E0MWAiSLgx3ORigaCs3n7q6+U1r+C3sZFMqSfdf+6W8
 GFGfkoKijDElJgX8ukVTn5K7TJ6/b468tqB2Kr4rX1DPXGzzWkr9/I9v6Wt/A2rXkJKMsyevert
 mOAa0gXwILChe8WE996Uj2ZEH43Xio7hYJaZ2QdOzvVGeUaK1PyL/oMglxbLLGAg5rckY7b7Z5E
 DDkxBOQkb5sn+ZGX8TVObO3I2HaEFc1jtvM3R1PJMfWYh3ed8fzDsqhownBkBIv+aR2lREgn/Lj
 Lu3Zo+TSyBkiafkyGDswIAz58fXAMI27gW3hH7iLhak81zZF4yTZxqKmH3IHG6QMXTXnR5tRTyO
 Q3WWJUKjJMJPlL8xBzDnjAADcFCid4CnvH5dL/huXGwY0m1DfhU/ZcSS9iHfLR+RUfse8IpA
X-Proofpoint-ORIG-GUID: ffyXqMI1VnA4dUCgOxY7wt41MskNmCo2

On 7/19/25 7:37 AM, Sergey Bashirov wrote:
> Compilers may optimize the layout of C structures, so we should not rely
> on sizeof and memcpy to encode and decode XDR structures. The byte order
> of the fields should also be taken into account. This patch adds the
> correct functions to handle the nfsd4_deviceid structure and removes the
> pad field, which is currently unused.
> 
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>

Very thorough. At first I didn't think we would need to update the other
layout types, but yes, I now agree that's prudent to do.

A few nits below.


> ---
>  Tested on the block layout setup, checked with smatch.
> 
>  fs/nfsd/blocklayoutxdr.c    |  7 ++-----
>  fs/nfsd/flexfilelayoutxdr.c |  3 +--
>  fs/nfsd/nfs4layouts.c       |  1 -
>  fs/nfsd/nfs4xdr.c           | 14 +-------------
>  fs/nfsd/xdr4.h              | 31 ++++++++++++++++++++++++++++++-
>  5 files changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
> index bcf21fde91207..9ff2a23470e61 100644
> --- a/fs/nfsd/blocklayoutxdr.c
> +++ b/fs/nfsd/blocklayoutxdr.c
> @@ -29,8 +29,7 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>  	*p++ = cpu_to_be32(len);
>  	*p++ = cpu_to_be32(1);		/* we always return a single extent */
>  
> -	p = xdr_encode_opaque_fixed(p, &b->vol_id,
> -			sizeof(struct nfsd4_deviceid));
> +	p = nfsd4_encode_deviceid(p, &b->vol_id);
>  	p = xdr_encode_hyper(p, b->foff);
>  	p = xdr_encode_hyper(p, b->len);
>  	p = xdr_encode_hyper(p, b->soff);
> @@ -156,9 +155,7 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
>  	for (i = 0; i < nr_iomaps; i++) {
>  		struct pnfs_block_extent bex;
>  
> -		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
> -		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
> -
> +		p = nfsd4_decode_deviceid(p, &bex.vol_id);
>  		p = xdr_decode_hyper(p, &bex.foff);
>  		if (bex.foff & (block_size - 1)) {
>  			goto fail;
> diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
> index aeb71c10ff1b9..28eb5bedb7e13 100644
> --- a/fs/nfsd/flexfilelayoutxdr.c
> +++ b/fs/nfsd/flexfilelayoutxdr.c
> @@ -54,8 +54,7 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
>  	*p++ = cpu_to_be32(1);			/* single mirror */
>  	*p++ = cpu_to_be32(1);			/* single data server */
>  
> -	p = xdr_encode_opaque_fixed(p, &fl->deviceid,
> -			sizeof(struct nfsd4_deviceid));
> +	p = nfsd4_encode_deviceid(p, &fl->deviceid);
>  
>  	*p++ = cpu_to_be32(1);			/* efficiency */
>  
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index aea905fcaf87a..683bd1130afe2 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -120,7 +120,6 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
>  
>  	id->fsid_idx = fhp->fh_export->ex_devid_map->idx;
>  	id->generation = device_generation;
> -	id->pad = 0;
>  	return 0;
>  }
>  
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ea91bad4eee2c..f3a089df164c6 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -587,18 +587,6 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
>  }
>  
>  #ifdef CONFIG_NFSD_PNFS
> -static __be32
> -nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
> -		       struct nfsd4_deviceid *devid)
> -{
> -	__be32 *p;
> -
> -	p = xdr_inline_decode(argp->xdr, NFS4_DEVICEID4_SIZE);
> -	if (!p)
> -		return nfserr_bad_xdr;
> -	memcpy(devid, p, sizeof(*devid));
> -	return nfs_ok;
> -}
>  
>  static __be32
>  nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
> @@ -1783,7 +1771,7 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
>  	__be32 status;
>  
>  	memset(gdev, 0, sizeof(*gdev));
> -	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
> +	status = nfsd4_stream_decode_deviceid(argp->xdr, &gdev->gd_devid);
>  	if (status)
>  		return status;
>  	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index a23bc56051caf..ec70cb9c17788 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -595,9 +595,38 @@ struct nfsd4_reclaim_complete {
>  struct nfsd4_deviceid {
>  	u64			fsid_idx;
>  	u32			generation;
> -	u32			pad;
>  };
>  
> +static inline __be32 *
> +nfsd4_encode_deviceid(__be32 *p, const struct nfsd4_deviceid *devid)

Let's call this one svcxdr_encode_deviceid4()

(Note the "4" on the end, which matches the name of the XDR type as
it is specified in RFC 8881).


> +{
> +	p = xdr_encode_hyper(p, devid->fsid_idx);
> +	*p++ = cpu_to_be32(devid->generation);
> +	*p++ = cpu_to_be32(0); /* pad field is currently unused */
> +	return p;
> +}

The byte swap operations are unnecessary here. The deviceid4 blob on the
wire is not used by clients in any way other than as a cookie. So the
content of the blob can remain in the same endian-ness as the server.

What we do want is to document that fact. The usual way to do that is
with "(__force xxx)". Maybe we want to do something clever with a union
type, but here's something quick, dirty, and untested:

{
	__be64 *q = (__be64)p;

	*q = (__force __be64)devid->fsid_idx;
	*p += 2;
	*p++ (__force __be32)devid->generation;
	*p++ = xdr_zero;
	return p;
}

For the new "is unused" comment, IMHO it's not adding much value. But if
you want to keep it, let's make it active voice so it's clear this is an
peculiarity of our implementation, rather than a protocol requirement.
Something like:

	/* NFSD does not use the remaining octets */


> +
> +static inline __be32 *
> +nfsd4_decode_deviceid(__be32 *p, struct nfsd4_deviceid *devid)

This one should be named svcxdr_decode_deviceid4()


> +{
> +	p = xdr_decode_hyper(p, &devid->fsid_idx);
> +	devid->generation = be32_to_cpup(p++);
> +	p++; /* pad field is currently unused */
> +	return p;
> +}

Likewise, replace the byte-swaps with forced type casts here, and fix up
the new comment.


> +
> +static inline __be32
> +nfsd4_stream_decode_deviceid(struct xdr_stream *xdr,
> +			     struct nfsd4_deviceid *devid)

And now this one can be called nfsd4_decode_deviceid4(), which matches
the naming scheme of the helpers at the top of fs/nfsd/xdr4.h.


> +{
> +	__be32 *p = xdr_inline_decode(xdr, NFS4_DEVICEID4_SIZE);
> +
> +	if (unlikely(!p))
> +		return nfserr_bad_xdr;
> +	nfsd4_decode_deviceid(p, devid);
> +	return nfs_ok;
> +}
> +
>  struct nfsd4_layout_seg {
>  	u32			iomode;
>  	u64			offset;


-- 
Chuck Lever

