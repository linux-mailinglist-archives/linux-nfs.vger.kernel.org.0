Return-Path: <linux-nfs+bounces-19891-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFIPCcz3rmnZKgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19891-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 17:39:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D18F923CDE3
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 17:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF0D83022072
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48873BD659;
	Mon,  9 Mar 2026 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oa0x99pr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jTn3Frmx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D63B5307
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074351; cv=fail; b=R1Xp+9vYXk6CeE2yaP1aA3JeVS7P4VwazHu5w7nNCYax2jwCv3gW/hPRraogcC2gCkGrb4vlm4UpxIdRwiIV6OxDALZJgA7oQRpmIDJ+mj8lywZGuBs2lCOvYLVqz5xLzuNmksTt0ElOtZynH5IEL8iRP7oytY82NKV4dCZnKuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074351; c=relaxed/simple;
	bh=FZOTWaCmEkIUOAQNb29+Wzvto1Qt9UvhCzmx04JvLP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a7Td6EgCtRsjxR/SfX68EZWlCM8iBG3VkVOSfDA5BUPDqD7PIL89xCrNDb58xsqtjJIQJVvi4KaGbOephwTge5efc06xTjhuxVsXt/cmYYXgAeQZcMIh+F9zdaapbhVOy7ngZ46Qat4sAGtyI/8ljAj73wItuPCmTq0kbtH5dMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oa0x99pr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jTn3Frmx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298vPlf3293969;
	Mon, 9 Mar 2026 16:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FZOTWaCmEkIUOAQNb29+Wzvto1Qt9UvhCzmx04JvLP4=; b=
	oa0x99prrveBPPnFaj29jwt9Zmpa4Qd8hc9sIgjVT6WN2K8uXdXuf26wB6qd8qEj
	Sqb8gN7EWrv2JojgwzlAIfnZwW/vZq8matcihAgf6PuN6ddhkUOGclinrN07R9VZ
	bD2e8OUPOC7RosVEwYbjws6BHMhUqZjSka3m4KN3hkYCT2VYbIAf2vfX1QBHM/IB
	kWPAXFyNAhgzzldp9C5l0T/yLE2Hn7EryOAOcuM9QyB3UJMrTrWZCXb7KBKyyEM6
	cnkMMjtl0ORtNIHqhCRw0dtlnHqTyU3eHQKGLLaT1SBHNu0rJ/77Hva8DrTsJh3g
	O1TTjRBdOfc18x1YBk5QLA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmdkh9rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 16:38:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 629G0uU2014795;
	Mon, 9 Mar 2026 16:38:53 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafd6596-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 16:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBOG2llxjd1eFpZ3VWOUt9J23ZeltOUldErDhyvGvtgvFHzaS5KjExwXbTWY+Ob5Fxm6Mfqw8MHtmOvr328McC0Ey/lRX6GgukIpCgHEGd2pWIdc/Tyftm26iz6zY5HUvp3n5sq+jJc8ocDImKqG39qhs5LDNjnatbFS+X0Rx4wwTFFlQ6wF55mxHaoXGwCqYj+HDvcGx+iTguSP/UbxuLx1E2m/vSwc97kpCPWOPtaf4q3YeUvC6XSsNwg+18UbXxz33cKixUOeu20P5HgQWjvbeupZ6DxxiQLmVxosD3tr6LG+loT5pkIzEirnuA7SIM6XRurRgIQuI6zbzB654w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZOTWaCmEkIUOAQNb29+Wzvto1Qt9UvhCzmx04JvLP4=;
 b=kgj22vHfw4JRWPs2BB2vCLAYt8EQ3cHKD57ZOAxo/BEyuj0rGFiRexyxVvXZE7t5grR57wc9wGsjTwcJ1EIJ87gNnm6t6JHTgv0xm55zK2Dtaof/iiWE3fBc42TbiP8+T2PlNOPO1BA0gXDCUCEYhG4YprrM9zZQDu3p9PKAFqcIxObWCxHlPsg9+KpMW1g5ijB058bw/ct2h6vmg3R6dqiQ20mutL2q2/L6OjJDV1Z9qtFPQQKjs3e3OBPzOnxlfzNX30agIYZWgJne4ohLjL+vXz1AA5Uk+86MtkrgRwERhlIH4wq2DeZznBI7ASdg1H6ZngwXNyxkpsTLqkr1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZOTWaCmEkIUOAQNb29+Wzvto1Qt9UvhCzmx04JvLP4=;
 b=jTn3FrmxSfqZWnrNGyi4CXAIbqzzbpzx65EQK8/9mp/K6a6Lenrp8Oms0oObWzHIyDvzTUnaS1ooK+BmPtERgobV8M7oT/j5gQKREdYO23pzToIFzbUpnepBJPX3BYfLONy00nmQf0hvjs4CncPpL5sHuH/8YUXaH6lO7DTy+8E=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS0PR10MB7221.namprd10.prod.outlook.com (2603:10b6:8:f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 16:38:49 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 16:38:49 +0000
Message-ID: <ebe57216-1c17-4b9d-8a2d-6e2a09bdcbc9@oracle.com>
Date: Mon, 9 Mar 2026 09:38:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] pNFS: Serialize SCSI PR registration to avoid
 reservation conflicts
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
        anna@kernel.org
References: <20260306162927.3276695-1-dai.ngo@oracle.com>
 <fc0a566a-9cba-4fd0-99a0-d7fb7043a77b@oracle.com>
 <aa7oo3sOTe-WKjVl@infradead.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <aa7oo3sOTe-WKjVl@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::23) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS0PR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8254d1-6a2f-4306-1f3c-08de7dfa5761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	/FqUgumANMlbNFaECUQnVfud54Pp0axb+JrVDNy0w9hRYVPuaSWLfKhDyVfoOm+E5b2CP2O+v3t4FTxiZ5PTgjCkFf1dWbhWckPevMoq6byim3znYppny/RrkR8FF0YHSyz+YWrHNsyOo9RO2W2Fa7IHIQRASZDYvbVCfR9ln6/S5PJEMHU2JUIpictx3czvpPIBrCnY3U9ZanzuGU8t4kuqhl+MWH1vGMBdmwGzOjHID6/m0x1hwaQRIvUZ67diq3g9fwu5FFYHjGxgVxmblkv2pwmamdElXGAVO04cbayCEEmdjYjiPy9JEiVA4I+J5Kp5zzFl0xprE09iv8mQkc08aCAoFiSLLALUEX+fzlR6DmBqxdSW1G+MsYD0ISzhO/QSw6f61rpvgMx49xXCfZ8jnlZbVj9YB1tb2TujhlhkbV+Db9dN8dPYyF1H+2bDQ2zlFlyexgdrZxqtdEW0AM3FW/bBh4MeyAwbpsR8fOFXPGUaJDw0tRoKfuAx5mS2p0EYvvYUyAzd4DRLu0Y2gznz/2I1q4T5pLixC8NeFtIFPEtfHhjCT3bYAHRs5ipe6TAZZKZwbBCQ1mvMndp5ocrkgPt5qL0ROwmoqGPEmgZD2IIGHEqsRpCzz43YzqpUpoTOq/fuiIl2FBFM+zKqSwK5UyIoEdkmKmnKHoLM3OMP4O5+LRSagf1FRWRHo7yGiYb1YRcqDshHuLT9CUb+o5+0sl+HmYbRWKG+E44NguE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2xuaFRCY29Ld09NaTJxUU5PNENZeG03UWl1NGsybXcxcWFHaUVYSTBIa2FD?=
 =?utf-8?B?ZHJmU3pLMjhVc2JYVVFhVmVZUEsxVzdhNW9tVzN6ZmxmUHh4b2piQnRaMFJS?=
 =?utf-8?B?QUFNRFYydDlyMEJnVUFLWUFWbVU0a2MxbDY0QzkvYzY2NXJtV2ZyZlB3WE5B?=
 =?utf-8?B?QS9yREtuVlBiU1cySmVxck54VmJSeVFQZ1k0TldhY3FHYWIrTGYxVjVXWFdi?=
 =?utf-8?B?SUc5ZzVhd2NHaG8yeUhwV3hpSWJhV3cyUnd0aFprZTRSNG44OXh1RVZwM3BE?=
 =?utf-8?B?V0RHZjkyejl6WUQvdXBiaDBkY0hKQXVBUXdKZUdMaTd2UUNwUmxURjJFNVpN?=
 =?utf-8?B?aWsyT2VjRW5OWkdBeit5NzlNM1hyNFFyNFpNd2V0LytqQ2ZqUVo0aTNRZTJw?=
 =?utf-8?B?YTV1eFd4QkM5cExVMmEzVm02Y2dMWDRhd253enhwSTlsSWxQWm5QUGdYcjZO?=
 =?utf-8?B?OEtQUm5zbjdJOVhhMUhiV2dOK1dLYkNnbjFkc2phZTc3WTVMeHNES09oQXBm?=
 =?utf-8?B?VldoakRzeDFVcXJrSnZnNVZ5bTNKM3QvWE1kSUtMSFMyeXRyVmJYd2JoYXV3?=
 =?utf-8?B?NUd4d1UxckFpTmFEZEMwUlNIOS9EclVia09QcDdzYlN4RktLeE5acTJmRU84?=
 =?utf-8?B?Y1JJc2NzdTZCT2d3RkxMa1hENUMvVmFtOCtoV3JMZThYWWlqR3dkcW9qRUtv?=
 =?utf-8?B?NjExc1NmYzI0dTRhTyt0U0lEcGJqcXUyaHBqenJJUFhsTDc0bm40ZVRyVzN1?=
 =?utf-8?B?dlVlN2pzbDVYSHJVZzQ1WlpNUzcyRUFJZG5SdmFCOExWSUs0QnVpc1hvZG5k?=
 =?utf-8?B?Wlh2dFpoRzBLVm54RjRIY2hYQk5IMEFEbDFUdmxLV2RML1ZmMStJMHJTVGds?=
 =?utf-8?B?TmMzTjNCMzlCdWhRZWc5enRHQmQvdWtqRDJSUFZkbWRWa29sTDhOR3BVWjJO?=
 =?utf-8?B?SWJGaStFVlhjZDRUWmd1UnhuQTNSUUhuVENQUnU4S2xmYm1jSlIydnZWQW52?=
 =?utf-8?B?bWdUUFpNYlJjMmxGcFptd2V4bUUxa2NwRDFlYmNhcDBGWkgvUHRRSGgzMWNn?=
 =?utf-8?B?ZUtTTEVFa3lZVzlYTEphVVVSSXgvNnA2QmsyU2x2d2ZrOFY4Q0t2eFBGbEZH?=
 =?utf-8?B?QWVxemtWa1YvcGx2MVNpMXhnblFoQnYycWhVNmRQTXRiRmV0RFFkS0hDL0Rw?=
 =?utf-8?B?cnhqVjVTRTZVVzBBLzhCRmVVZUlmdklOekNXSE1HZkN6bks1TWhSdkRxRnJo?=
 =?utf-8?B?REVBcHFXMzZRR2l2SURTMTMzdnU5L3VTVHExNHJFY3phLzM2bXNuRXR2RUtx?=
 =?utf-8?B?Wmkwa1RTbmNsZTN4aXVhTzUzMWVtbkE2K2Jva1RzbUhMSVFoMTlTWHRCZ0xY?=
 =?utf-8?B?Sm9Kc2pFaEh4K05ZN3BiWmRoclJHR3JzSWJxOVlqRk5XMjJWNnAwSHFESlN5?=
 =?utf-8?B?UEd2dFVVYmZtQXVhVWlNMWVEWlpPa1NvYjRxbmkxN2lvZlFySC9XejV4MHA2?=
 =?utf-8?B?ZG1Jd3B3YVNuTXRQYWhKd3Y3NnFHbE50UmNjOENzS2FlQ0hyTXJQa3dDZ1Bk?=
 =?utf-8?B?QkdFakJaeUYyWkRmUjVsT0hOY25mZXZrVWkrV0J5RlBCVXdLRGM0MzdTYk0y?=
 =?utf-8?B?N2ovQWdEL0p5K2s0UFoyUlRYTWxscWNxeFJaTlYvVFdmQmdZTEtaYkR2bU5E?=
 =?utf-8?B?MnRnMUVNa1lsWmpKdjBDVDc4cGhYRDBEVmtqK1Z6T0hIWERMbzBjUzlNTVZQ?=
 =?utf-8?B?UmtVcGRTMUlhZHpoMjRoejdxL01oaDNtMU5MbVFKUWt2UTlUWjRGd1NrTXh3?=
 =?utf-8?B?WEc5OHVUZTdIWDlEWSsxWGVmR0s0KzQ5TWdSbHZSb1VELytZemEzcEpEVncx?=
 =?utf-8?B?L09iam5wdUpaVnlhR1A0eUpwSitRNzJKUjdJUkUzTGpTTVhNdFV6Nld4VzlC?=
 =?utf-8?B?UHNVVXVsM29JbU1aY1kxM2xrUTJlcVpCL0hrSVFQTXdHZS9sdU9hOXNjUzZv?=
 =?utf-8?B?ODFvNDR6VHNwWDFZN2MrdTVsT2IvOFRyNFJGUDVmRU9rQWl4bEF0YW9aYU9n?=
 =?utf-8?B?YzNCckpOc1B1czNIMWVsNXNweE0rYm1iSjAxVC9qNEJtZnVPemVpcHp1V1hi?=
 =?utf-8?B?S0NUaW0zZjBlRFZIN0ZzV1piR05DWkk3NFdUVHFwVHJmZXVBMVczKzYyMDg1?=
 =?utf-8?B?elN4ZmU4N2ZKclRJM2dpc2U2R2I4TkxLVlc5aGk1S3ZuclU1M0xDcHZXYXlC?=
 =?utf-8?B?Y1NsTHZMZmdNanZtVzd3ZzBpNHlBc0VkaVhVbHdrZVprRkJrWFpQUFQ1WVgv?=
 =?utf-8?B?R0VNb2hVZllYc3NZd0JvTVdBWjBiVGFpaFZBYU5rcE12YXN0RmE3Zz09?=
X-Exchange-RoutingPolicyChecked:
	kNvKAXn/MMDIbaShLviZUVPoXRfMmVi40I3bZPNMqLr3UiHo9axolvVsoHx7eTcweoiaAof7sYtT8awq+XUVw12qJGJ3XMb8meDRyUh+R3nCOQ32eS1aQjA8+rZRT+VmyCIRJBE+ckXi5WmvrReUVTmZoUncN6SH2EQV4cnMAPSDJaGQxI1nlWYRziLOi7wjVYOHjJWoDdgYi4pyVnjj0a1d8QWMgfgdIYh2bWJbTe/juovRtNBcDXa12A4eWq3ZwYN+5GReewFLY9O4VjrRjk/ZITQ/il4u9k1Mcdjkacm9Iu0LuNTtCfsD0nGdtatqlNBFZXryrQPZtdZpiohsSQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gGWNMO/ivFnII/kYkRWP6ioU4b/hrxz5nCXWBRkfTi4j3X+wJtwSb3QKGxOQ8Q+LdnILg3AzmKmBbP2x2bS8+6uCAZQ/9upTtwCOs//LNlyKRfGUwTT9szkZbSrgN13ntl5Ud4tzxgBVAdOYOnvIyvoF/PhD+U3wYydxP+nW4mTzqZ+PqsfQDPChvy1LQGGBrEiddsPmqbZ+CKiekwjgpPPqMHg0H0dYHsoTveJ1zHGqm36DRlRdQyL+AqQqr06V8hHpvbM802QqdcKUTaaNKoyFjHKVstqj+O7LOL9WWKcbJR3SguNoG064YuU19j9MdSjMsJVub1lSBs3M2detkjjOvIul+ejCB+tg4+J090m7yuLscSlRpBOEq45DiL/znFJzIRXvrYQr8uBvQCSPh0RjkHd5+5P99T0YAW6XlHBc1osyN1QlUzTqNHjXxtMJTMFbHngJbxfNV1jYlyiJqNALn8cEYsuTDyY8z+UL4vLJZcoLF8MN1OTVqSzJLyozkNLmTF+SciTN0rCpr/3OwXG0SgohiHqizMysMRz+Bv1Qc7mGlqitO2tbWAaQKIpZBQJAyDHxcbUe91QHNe1GadFZ9/W9gg5G6XVoO4C7Ygs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8254d1-6a2f-4306-1f3c-08de7dfa5761
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 16:38:49.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNV7SJOqQkT5Qcqj04tiyymdGRwFqc8n7Fu7PdLLZj4CGJBNDmJLD+0rs+fOYLNU6ioxtTB4ccyn1ARuk2whrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090149
X-Authority-Analysis: v=2.4 cv=MuBfKmae c=1 sm=1 tr=0 ts=69aef79d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=A84GwmCLaz7Yp1n9UeIA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12267
X-Proofpoint-ORIG-GUID: SYyziIL3pNzr4SJcmVptnC7X6idwNBkZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE0OSBTYWx0ZWRfXyzW6yN4dNNtS
 QrYalaDQqwdMbdMap5FDxdus9ppv27KtqTok9gIlaMaXIvKp68NQlGIQRONMsy/KA7gDiv4XFe0
 u7giwaPN1fFYfdEcfa9dh+CZEYGtLlnr16rWIuNlpS7/s7NQLB2zCOfL96JPSIHwo/q8Wv6q4AV
 6b+f2TfQ9wrefAMFsR8eBCvEUUYa/2J/hca/+eNZI+EWSVNQKyYMe6ZOWHQFcZK6BV1UHV6Kp6L
 TkEQq3PU9OKn3CARgmdRe3Cwzx7gF7WF9xV4y2iB5gW876WsatZ9+oQ7pzlsa8Dlfh9+g85/ddF
 SpWBn2RqhKSt0dNfygE/HFjwE7lZVBxP5210yWHDSo/aedid3s7sOu7/mlkFxLxnfBtnskSZZls
 oQgSISnkdl38yJHMjrIhfT1CPqq7lD8mn/yNmlp+8tEzChVnDWAm1IUwx5QeCazNg2N+OFJHFzJ
 CgTIh2JQ5euoIkZvO1GGm9I6TRLIDv0+bBNnMwXA=
X-Proofpoint-GUID: SYyziIL3pNzr4SJcmVptnC7X6idwNBkZ
X-Rspamd-Queue-Id: D18F923CDE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19891-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action


On 3/9/26 8:34 AM, Christoph Hellwig wrote:
> On Fri, Mar 06, 2026 at 10:46:00AM -0800, Dai Ngo wrote:
>> Christoph,
>>
>> The new mutex, pbd_registration_mutex, is initialized only for the
>> top-level pnfs_block_dev in this patch. The mutexes for child pnfs_block_dev
>> instances allocated by bl_parse_concat() and bl_parse_stripe() are not
>> initialized.
>>
>> Should we initialize these child mutexes as well, in case we later want
>> to support concatenated and striped SCSI devices for pNFS?
> I don't think we need to, as the registration would happen on the
> actual SCSI devices, not the meta devices.

ok, thanks!

-Dai


