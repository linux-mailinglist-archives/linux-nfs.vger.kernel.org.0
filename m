Return-Path: <linux-nfs+bounces-13304-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A06B14E7F
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082C918A0942
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8AF19DF8B;
	Tue, 29 Jul 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UmVlAENa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qXuMg+8o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D413D2B2;
	Tue, 29 Jul 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796308; cv=fail; b=TjqzN1cXL0j9n+qpHyqAOWRqvIqWwIgx7ykV2Fdscl+5ESaC785R1lyzCY1DLBkoCCjP1ZxGw19io9Q/TqSqsFWUkbpB+Cx+E+a6AirWXDvWI985O3LIimUblN/ejd1V4aNtIUqp0cy25R5RWzKcldJHjpsxJD2kXqwEyiX8b2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796308; c=relaxed/simple;
	bh=P3bC8OWMJSUA+jvJfL1Pc1Jlh7NGYLd214QTjqMaz1o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e4zi07tfFizwX1copda83BueIiKKzS+1AIiDbYNiQbcXBtiApBoJ1FCMb2Zkgy1ktBg9RKAdI+7uyXqQZ6MLN0qt4cOSDHKrgaav4hOMrli/73lxSmTHApUOlF4PfTnFGlBix9QLeJHpNMOq1kG7xAMbIX0j5dkP2i8Dkytw3bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UmVlAENa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qXuMg+8o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TDDs9b007541;
	Tue, 29 Jul 2025 13:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ByIUZ63Dm2J++lrbpKA7o+byYHjP+evYH5LhDDIY5pQ=; b=
	UmVlAENaXW+Cb7w/P2tRMTT1w0O6qxc6aKSh2G0r7JTFNVbeKdeHr/sedgIfHZ4B
	36scbqGzv4b3IQQr8iCIHkRDQFxulZnImOT5RXaMu/e0S6qb60x6pt+ukEa0NcFD
	C6ThFU41d79xltjJGm5CmOb/aQPXELhRGHuW9TYjr3e6ZSHy1wK2MvaYT3Jvq0vg
	M4o+B6mWodWC3mxGQeKXmAxbTJnuhbvd2U4xHzK9RSjJ6WsxMTHwPuMaGZtEj5Xv
	wxZ+e8It3pEZCV7yEoFhmEXzFEgEpveCC0eHfQoqsCCqWvZoEjp0eCjIhw5RDtTy
	PafbO9toQ9cxwAd8WQj2aA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4yfp52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 13:37:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TD407p016817;
	Tue, 29 Jul 2025 13:37:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfg73vh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 13:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJoiCc0G+VtsOBOE3XlJ5OWdEFzu867ZMT+t0daJtAeHxKocEuQZkCmERahpeUYnB2kS1TUxKw+V3R+Wbha5gwq5iCEs3RKJ6uu4x/s8CSnUq0bbE0EBZhzdMFgxTPFIqZJWJzGMijUnpmFIOuVGYvBs1eZvkPiU4MnaRvF+a7M+eTmtGuKwfaLdzludAYkBIw+wcSKlR5SOHVZ6RuGDl9bRFQxU93wEk8ZGCC2NCe8r4l8bzQRAIcdumpSsOW1TTMG8OO6w+ZeWErQriY1pV+fHrqic0OyShbIoVDQmybgiZqSbioQ9w8vfv7zkVmvR5UgrU/8P/AoakFoorceImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByIUZ63Dm2J++lrbpKA7o+byYHjP+evYH5LhDDIY5pQ=;
 b=J0vjNtaJbjDGNDW+Ag8PabQAHWrhyxOK9BOWA+gEDzVO+MolfjTOfKuOwZB/zBUnCNLjflcW6rrFj2c2Er2oOYKYk3P+G2YSKK69Ky9rbQRb2920DNSX5X/DSZDATfXOTWXQvkCjmJpJ8TnUSzSFgWa0xMR/+UdcclXi2SglY6GkvGXkno35PHABNkTyo9tHzMqZ3xYu+/4dEVdV5RNgmFnbbnj03gXjmA6A0nfq13YOYid9ncCenpMQdZPB47JNp2oMc97sw7IJVaaY10gxkC6BsqFD/pDUSEjMvjkcbAeHXYvZOUF6waSFd1aZA4kdIagZOGH6vl4jKw1Pc+pnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByIUZ63Dm2J++lrbpKA7o+byYHjP+evYH5LhDDIY5pQ=;
 b=qXuMg+8oHlIIJmxXp1gJlbTNxxS7X/0VcqBddj7OYzxuBuipHffZ5RI0obzUy8y21xNNCeWPCQZXqo7yFTLkF0YUdiPbhwyYW9I0sDdiWZQXq+ryzYT2Mm6V6uxghJLSXkrGkhDV9sy071zSo0dnSc1zyvWITgQnnMeMFf/1PVA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7927.namprd10.prod.outlook.com (2603:10b6:0:42::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Tue, 29 Jul 2025 13:37:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 13:37:46 +0000
Message-ID: <96ca4de7-d647-47ac-b42f-d76284394526@oracle.com>
Date: Tue, 29 Jul 2025 09:37:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] net/tls: add support for the record size limit
 extension
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, alistair.francis@wdc.com,
        dlemoal@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        donald.hunter@gmail.com, corbet@lwn.net, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        borisp@nvidia.com, john.fastabend@gmail.com, jlayton@kernel.org,
        neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250729024150.222513-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: efe7c699-fa26-463b-a520-08ddcea519ac
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UFZaUlZndGpqT0hoZDRjVW1scEVFNlpxM1N3VytDY0Z4SVpSd0kwbkEzeDht?=
 =?utf-8?B?WllIb2J3aC8weHJnUmdhUGhkVHNmVjhvekhrTGtIOVZrRkI1djVqZC9WTFdt?=
 =?utf-8?B?VEtMZEV2QnpzOGJKdGtlNG82ZENMU0N5TWwzUlluQWVnTGVqVEt6UzdkZDB5?=
 =?utf-8?B?OTg4K2U5a09CdVJNQmtwaUY0VDR0T3BDY29yTWxkQ0ZTU1VUZlUyYlp0UHFa?=
 =?utf-8?B?TU1hWmcvcU83bWd5blpHYWptSWVOMTZWMGRscFRhYXhXU0g0b1JUbFdad2hP?=
 =?utf-8?B?Y1Rydit5dnp5c2dQQTBXWVJRVzlBSkhlNTFEYTJYRG9mNnpTQmJNQjFpNXh5?=
 =?utf-8?B?ZmR6TkpORWJTb2JxYnZCMEg0SUJYZHkwY0g1em5pa0ZtOWRrQmM0Q3p0SmJl?=
 =?utf-8?B?bGR6WGFrc2hIc2lCM1dPR0c1R085MmpEZlMxYlE4bTJFSkdWSUNDelYva2ZL?=
 =?utf-8?B?ZmxQdHlabmdvVHoxSlBwVzV6TDJQZ3RVY0RhalV5VFFkYmEvSGtJZVFCcERz?=
 =?utf-8?B?SWpZQVZ6NjgvWlRIVHBjL2x6VmszQnFEbSsyRUF6d0hYeFhVOURzV1kxRzVY?=
 =?utf-8?B?VkV2emV4Wm1YZlB2RkdZT1RERVd4R1RISFRad1NhR09VUkdHS2VMdnBaVW9v?=
 =?utf-8?B?MFdUSWhvdktRRTVEbEFwT0x3aU9hQU9NV0h6R3Q0cS9RQUZpT0xlRzY2Z3h5?=
 =?utf-8?B?OVJVdUZ6NTVYbnhZRlRJa003WUpYRkZnekJoM1JjM2V5SDBKWkJYS3pmUkFq?=
 =?utf-8?B?dGI4bUg5SHJLODVXUHQvQ1pMSUxOb0hIS2ZHbFRvSzNoQnlvQVF2d1d0eGJs?=
 =?utf-8?B?ZDcyVitaQTc1ak5DZlV5MWRxUytiVkMwR2ZjTGJlNGVnQXhhSTd0R2RDbm9D?=
 =?utf-8?B?STF2MGJPYkNkejRnTDJKVS84aUcvYUIxc003eWJQWW5TMS9qaFQrZGMrY3Ft?=
 =?utf-8?B?VDJad08zTk9RN1ltbFBVSGlvSHVCOGo0T3MxNEdBeTRGMUVVa0p6UklXbFZq?=
 =?utf-8?B?ZHBRMmdZeE9kVU85bjJkc2tkM1Z4bGFRbkJIRlhvVm1OeXpjNlVSTEV3ekRt?=
 =?utf-8?B?Z01vZkIxNkd3UXI0VWROMzBrQ2QxTCtWSEIwZTQrajczZWVFVWdWcUZQcUxC?=
 =?utf-8?B?YjBHMmhoQ1R2eHNyYk1VaDhzZUxlMG9MNzlDaHc4V1ZyMWZwekFTTTVDVTQ4?=
 =?utf-8?B?dmdTYUlhaCtycVlGcE9KR2M4UHppdWo0MHdQS3NhL1NsZHlRZTd3SVVsZS9p?=
 =?utf-8?B?T3BnVG45bUg3cDZxMm5lc3k3dm92cWYzWUsyMGozYjl5MlJXTDBFdFlkUTRl?=
 =?utf-8?B?VU15cFcwNCtkeWh1aEdna0g0enpTU2RkVWpTbzNBM2doUkdYeHlkSjVjN2FC?=
 =?utf-8?B?d3ZvSytteGxkRnExYXp4WnkvaXd2Nkd3MlNWaXd2R2poV0o2RldNcUlQNmR2?=
 =?utf-8?B?eUNvWmVqaHhaQXB5RFJBeGMwNnZkejhhVVYxU0N3WnJKU1dIN2xFN2hlUUFF?=
 =?utf-8?B?Y0RBdUdPZEY5Q2hZMnVUNlVXVzFDN0doalQ0eXRhZWluaVNqZzZIYnhOdGZt?=
 =?utf-8?B?TEpTTkNQMWN1dEZlcFBPdnFwMm1WK0I1OVhFRFYvM3J2dVBhMG5LUXV1eHR4?=
 =?utf-8?B?TXVhOXpTV2V4cHFwZUtzNWF3blAxVjhaWkcrbE1LdGg1Z0NGMkxUbm8xMkQx?=
 =?utf-8?B?YUdrN083OHJmc2k0ZGxIWkZoZ1lvNHFkRUFrL0N2Tjl2NnY5N2V5YU54eGRX?=
 =?utf-8?B?M0lPMnJGVUEyNjQ1S0lmUVM4bWN1dTljWldpYm5zNzBLeU9LMnVTWnltTS8z?=
 =?utf-8?B?VkpCd0VyckR2eGhreWh6QzBLeDYyQi9hWXhJZEQxYUFVMDZ0cUUyWlhRMnJo?=
 =?utf-8?B?QXpRdVdCMzh0dFZKRjYwT3lraVB4ZzZBUFIyTE1FeUpDMGZDTVpLNW11U3NI?=
 =?utf-8?B?ZDh3dkdtUVhabHcvQW5VM0djOGNZamxGVi80NUJSRUcxdFh6MFdFQWFua1lq?=
 =?utf-8?Q?nfRq98SKxm2/Sd4GqFvEtMoG76OrAs=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bDNCRU1rU00zMWNHb1pKQkRxblRkakZhdngwTUtCNDZnN29IT1lVdDk0eTdk?=
 =?utf-8?B?YnFwQmRTdnN0d2JOa0dCbTg1RHZpeHRhYWpPdzQrR1kzaFpEZnRwVVBNMUNt?=
 =?utf-8?B?elQ3WENRcVViREJNOUxoR1hrcVVxSk5zV1RvbUY4bHBydXVPdUxBZjBuWk1W?=
 =?utf-8?B?RmZ4dzIyWDdidHNNMkx2NVgxZHBiUmVRakVsSmhtN3NmTG9BZHB5aTJhOG1D?=
 =?utf-8?B?M0ZzdXhsWmFMN004YzZhVFEvMFNlZWEvZnlJQnNkM1hSWDJDRjhYaGFtVkhi?=
 =?utf-8?B?eVh5SFpvd1hrbmJqSW1abXU4MXJpUllPN0dMYXRMeTh2dlZlcmRBdUJyT2xL?=
 =?utf-8?B?WW5tS1dMZ3RGWEVscmhYdXlIRTFuOTdTOE5VTkdLcEFya1p3cVRvem91Y2dL?=
 =?utf-8?B?eWpqVGIrY1lRMjNjYXBHOVk2emJ5ekNSRFJDRlNzQWJRTzdUVkZUNGFtM2Jh?=
 =?utf-8?B?UDlOL1EzajYva3h5SXdxMlhXM2FhN2E1bUhTMmxnQ1Fka3IyVWxVMlZ0Mlo1?=
 =?utf-8?B?MzRBN0JWSVptTHN1Y0JoL3UybS9TVmtiajV4d21ZTFVHejZ3Z3l3TUtrR1Zs?=
 =?utf-8?B?SmxUK1IxSXVUSGlZSitYb3l3cDJRTUtSaXVXanRjbXBJWUtGU0VPZHUrRStX?=
 =?utf-8?B?N0xQcXpmQUUyYVkvWno5WDQ5am1zeWhPK1NiK1Z3ZlVEcFF3LzhJbkRYcnd0?=
 =?utf-8?B?QXp1RWdFVThaZmtSajJyZm5jRC9ucGV2a0RqaDBhOUxMYTlraG9DYXVMb1hY?=
 =?utf-8?B?ak9BdkdRQVRoUktYS2NweHVobEFETFRGNHVEVHhCU0xtc2V6cW5Qdmg2THhx?=
 =?utf-8?B?djdGWWFScE5LbXhlVW03NVlqSmMrcnpRUlU4YzMvMzJlSmdHYlJkMXVXcU10?=
 =?utf-8?B?SjA0NUY5MlBFQkJKcUdDSFJIWHlnekpPRERsYktlanVZcGxaVXF0dzZNUnBN?=
 =?utf-8?B?VGQxRXQ2ZFZEUlFBQUE0TFVaUWtUem10c3hsQlRBUjBsYWVhZlBoa2JqdVpj?=
 =?utf-8?B?cGZOYnVRL2h0ZC9mZ1YxK1RTenVPSGF4Qzd2Y2FIVGt5SkdtVGx0L0FuSzdV?=
 =?utf-8?B?cjJuZTMyNElDUEoyQ2NVVjZhTVhydkdqSmFYdWR2dUxPcnJLclNKK01xbi9l?=
 =?utf-8?B?YjY4TjBScEVUMjBQcldxUXpSMWhOWDlvaWlZMVNNM0FnL3pEMnlPeFZkdG40?=
 =?utf-8?B?K1hLTmxiLzdDbGZOWWkzM0k0SEg3elZ4ZTVIN0ZKZmdURnlTQzRITUgzT1BQ?=
 =?utf-8?B?bDdqOWo2akM4bE5yczl0VGdtZE9NN0Z4WFp1R3NJa3k5NXU4Qk9qdlF1RjZJ?=
 =?utf-8?B?c3E1Sm1BcTlvNVV1ZkpsaXFscGdwWW5nU01xdzdoMFo4MjBKU2FqWTlaRmcx?=
 =?utf-8?B?ZncrOU5HRzVyOU1aaWFKRURBdmN0allncXlFTGwrY1dGaTNEZnVQbmlJNDlQ?=
 =?utf-8?B?dHd5NGt3WmxRZ3VxeTV2NXQ4QTFwM0RWVkR6NVVEMGpNVnZUZ21kSlpma3hp?=
 =?utf-8?B?eDRYZjZVNHhpQ1R1VUprY2VLYkU0cndLaGVmK1RBM0dzcnZsNFgyZERsSkQ3?=
 =?utf-8?B?VUM4dHFZWmlxNlcrVWpGYlltd2xnMGVBdHlWamJTaTZWOHpJeU83azZIdzdY?=
 =?utf-8?B?bEYwZEh1Lzl5ZXNDT2lJUUxzdnR2UkxQaktnRGFiVm1Ud1NGLzY4MnExN2VH?=
 =?utf-8?B?MXRpN0NVYko5WkhmYWRRS1VkTEJoZS84cDdFM3FTUHEzZGRjd0d4Z1FPNUsx?=
 =?utf-8?B?eExpOGc4N0xsRXFuZ1diWnQ0U3Q3YXU1YkVIV1pvWVg0cGFabUhUcEtRN0JU?=
 =?utf-8?B?eDJNMUhaZFRTRkw1S05hQnRtc1REV3lVM3hEMW8rdHhNL3dRbFNlT2dWSlNm?=
 =?utf-8?B?dHBZTDdWVUVyeEd6K0M5eGkzYUZma2w1STRQbmg0aXpWOHArZmlYcXJWcW4w?=
 =?utf-8?B?eTdYTGthaHlmMmJvRi8wK25PUzF2Z2lDa2tQYVhPZk5iTVAyYTB6bHl3UW42?=
 =?utf-8?B?UjNRSHNsNy81TjVHSTViL0NHZTk3bEcwT2p1ZDRRd2VFLzhWNlVMMkR3bStT?=
 =?utf-8?B?T21HVlJ3TTNKa3BhcTYzR2RrMmtVME5qd3ovMnJoSnQzOWdEdjRaV05paC9k?=
 =?utf-8?B?V2pqNmJycEpRcEVKMUx0ZzhyeFJ4T2ZQTE5rdGJyWXJ0SFdGUkNjR1hKZ3Fv?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vKE/ug3fHduDGLNynfA+tMtGynB4sn6BP74gMzAGYqt9EFt9Hkav2eGMHmXLtoznVfJpxtmZ2q4qEaZrw2tNcWTM97JPWxBVhT9x9JVb1zgJm+fslxeUK2iDo5fVnU5eqXg+DYFpFoN6TK+AMizSQc+H/tveGmAVA0p4VwXkhN11HPNQYPEsYciBzwBM4Rolz6uG8WWcykCeU2zxJ2Bgq+BFV0e/ExFcL0VR/ynxE5h5xszxkC2u7btN1rZrCvFJCgaqxo7vHiEIiaYKg/E8HgdoVVx+PfNhSVTDXybTeMVVrVbI1Hu5AjUuuyskPUt0+WLVrA3jNlicNQnCze19AeNWUvlqZ3Ve9ZV7JhuPfz7vDY0Up+XeyT1d5CE8NV2HhiyvHt6iH0fzFbCJpEg5YdQmj/bM/oAUITiUo9g+3nGC5nZhhwv7+eFTrW1A2RaT4jMF/7BNjexd+BARaIo5OJ87D0PX74KSHjpKCCQRCtgBChuLyI51iFq1fAjW8HcUAelbzHYNA98l2GwWFF/GtV8V/NpJReZcl1vmNm29IdkHAXIVg9kK8xAgSWWtVG0vNf04cHTnG5h3ZkJnIgQqSTXaEwxVL5tP4N2YDt8lar0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe7c699-fa26-463b-a520-08ddcea519ac
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:37:45.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wASd8pkvvwx96XgFk0i+ghDCYuH4zvGNd76+PM5KpBJbwlbDDBdqxMzDDrkhRvG1q6ysxsHANd4k3JjxOi3Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290105
X-Proofpoint-GUID: Wvk1AqcKZGIxvIj9fSL3RsRIJfZvr51W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNiBTYWx0ZWRfX2J9aKH53MwVF
 D47RUA5LWDC+PoA2Wu1DrJABJkdpkzdrt1C0UhHux4RUkn5TDy7MagEBRT2aw4dNUIu4iVPHJKF
 3w/v3Itq99ykEKkfwOfFkgBa4m+PyXeMN5G/vXy4swSgcLr8q8SHg7EY7CrCOpbn51+n0WJ/MoA
 DsvKBony83vqeIVJrq5rYJH4Yh6DVF1h8bYQYSRkJG71XXgIhrdTotOO5Xk7oSLGAsnkXsgTMJq
 uDSEYQXNPvwGoFWoVqHgsNyN6ujbw6i+5nDjmZBZ+H7hGn+wsdcpP2Xnzie6XbEdMF9uRy4uisX
 +EKgAk54LpReDutT6GLqho6n7I+/2E89cVJikeGfoIZCwrBy3dLiJqyP8b3QvGlpGnTbz0cbwQf
 mW3/r1YQg529Ho1JmHwZ4c0utO9jWZtFSH+6bIEoVsrwDFGtn7vBjTpUHg2zppE2ra6z/zmZ
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=6888ceae b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=BqEg4_3jAAAA:8 a=NEAV23lmAAAA:8
 a=p0WdMEafAAAA:8 a=JF9118EUAAAA:8 a=uN4QKHQ1erwI98Gt5RIA:9 a=QEXdDO2ut3YA:10
 a=0mFWnFbQd5xWBqmg7tTt:22 a=xVlTc564ipvMDusKsbsT:22 cc=ntf awl=host:12070
X-Proofpoint-ORIG-GUID: Wvk1AqcKZGIxvIj9fSL3RsRIJfZvr51W

Hi Wilfred -

On 7/28/25 10:41 PM, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a tls handshake, an endpoint may specify a maximum record size limit. As
> specified by [1]. which allows peers to negotiate a maximum plaintext record
> size during the TLS handshake. If a TLS endpoint receives a record larger
> than its advertised limit, it must send a fatal "record_overflow" alert [1].
> Currently, this limit is not visble to the kernel, particularly in the case
> where userspace handles the handshake (tlshd/gnutls).

This paragraph essentially says "The spec says we can, so I'm
implementing it". Generally we don't implement spec features just
because they are there.

What we reviewers need instead is a problem statement. What is not
working for you, and why is this the best way to solve it?


> This series in conjunction with the respective userspace changes for tlshd [2]
> and gnutls [3], adds support for the kernel the receive the negotiated record
> size limit through the existing netlink communication layer, and use this
> value to limit outgoing records to the size specified.

As Hannes asked elsewhere, why is it up to the TLS consumer to be
aware of this limit? Given the description here, it sounds to me
like something that should be handled for all consumers by the TLS
layer.


> [1] https://www.rfc-editor.org/rfc/rfc8449
> [2] https://github.com/oracle/ktls-utils/pull/112
> [3] https://gitlab.com/gnutls/gnutls/-/merge_requests/1989
> 
> Wilfred Mallawa (4):
>   net/handshake: get negotiated tls record size limit
>   net/tls/tls_sw: use the record size limit specified
>   nvme/host/tcp: set max record size in the tls context
>   nvme/target/tcp: set max record size in the tls context
> 
>  Documentation/netlink/specs/handshake.yaml |  3 +++
>  Documentation/networking/tls-handshake.rst |  8 +++++++-
>  drivers/nvme/host/tcp.c                    | 18 +++++++++++++++++-
>  drivers/nvme/target/tcp.c                  | 16 +++++++++++++++-
>  include/net/handshake.h                    |  4 +++-
>  include/net/tls.h                          |  1 +
>  include/uapi/linux/handshake.h             |  1 +
>  net/handshake/genl.c                       |  5 +++--
>  net/handshake/tlshd.c                      | 15 +++++++++++++--
>  net/sunrpc/svcsock.c                       |  4 +++-
>  net/sunrpc/xprtsock.c                      |  4 +++-
>  net/tls/tls_sw.c                           | 10 +++++++++-
>  12 files changed, 78 insertions(+), 11 deletions(-)
> 


-- 
Chuck Lever

