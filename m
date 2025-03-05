Return-Path: <linux-nfs+bounces-10488-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF5AA50CB7
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 21:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E243A3AD261
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4403725523E;
	Wed,  5 Mar 2025 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iuy826XG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J8uVmNPV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C324E4B4
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207660; cv=fail; b=lwcJ5+Nw2WY9z/TrC3vulsdpvfzoWcbDuCPEX6/B37pKLA/FkudJeOy1k5pmiw1wwIkXexylfHYLmRAZtosbVIdmHujDXc6QLWxGZrcuYWJR9PZz6zdAFZfXs26D5P6J2vinMOaliwjjsMXAsfNRvMkoxx+eM/v/wYthyM1rq+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207660; c=relaxed/simple;
	bh=15YdrolV/T5SvKMvAUE21KlRDxKf16nNuN3rFR0Le38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DwSEsoA++QQpDaJgQ607G0Op3Er9zz8PLMNnOpEra4ny2utS2EUSix0j0sd2NdfmtUXOWKuQhXRzu9AOe6jgMR3I2gE/jyicjZAbGTyVBGqZWYytjQBhTMBhFBnZzROl8Ar0zlUe0W8OTVuu7ygLLQ5IQbCzJCFI4GRt3fVL9v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iuy826XG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J8uVmNPV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMglb009440;
	Wed, 5 Mar 2025 20:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RXSB7IWK1KyqcnxqCgj1vJlNjjnB57V7VR/mGmQegME=; b=
	Iuy826XGqWaGE4m8gvXlLvzrEy0VTH2eQ5t1iq09cdtl4hTpobIcrbr04CjQJE8d
	gEmE8DioTKZkEH3vdSUx8eNIlZRnRksBrciQ4qCIdzX/BjnqDE+a749KOZxA0sn0
	CuOMvtGY+V0LPkpt3Aacns4DjOdSJiwrtrOUmTOUaW06JjKzNaE0pcXtZFObMOJm
	6oCi3mNM7njuym/5/NcPAGymf/m4p4oUL9fJ1HfyPW/jCgJzCOXS0+vVS8+rSz0i
	/rTQfbtrdHEGUSrahGUWGr6cdMu/IzT0Bw8A2m0rURJV8J0cvff7K6QscT76djPx
	o0zs3QBmEPAdl8+5QbudLg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qgsn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 20:47:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525K57XW022645;
	Wed, 5 Mar 2025 20:47:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwwy29s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 20:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFgagI0gMZbXzeiOCgFptHT1Wpzdlfv4wbfr3aLLLX3X8b3PpwiFLdkbG0zdKMBi9xKjZ9dDWhYUXbokU5z5KmZWqAnIJBQvHhw+U1UMzOlkDJQFh2kCxHznfK2wo6ReOLDOQIXhe99Teh94ASY9ko4ZeSSd6uRyXv0d1LyC7tbQJyUD5PkVexMN3p4XAVBDrvvAJxM9uojjchiSC6qe4YA6hyAPwxhZYBLKNLy0dUjRWLpYEvj3jag8LapcdJRfPDyACx/meHFtL/lxtSx+HUcHBYxjlNSNPSV6+UnTc16eWcckicgNYwLleKqnndpoFW9hxnLlXaxNx3rL8fQn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXSB7IWK1KyqcnxqCgj1vJlNjjnB57V7VR/mGmQegME=;
 b=TppPYXVAJ6zmEAf7JJpEpJaVqZHqoGb225C1H+8pMDsyrwez4FmnXo58QSgLCTifi8SwnoShGe224W2qxEaw3LU+5uZhuzUUCqWJ363D9OZjY4alIK+vq4KgA9aGBJ9QyB02U/mw/XbLzTg2oO3u61i9ZTl1oPpm6Zj7h9Zx0jWy1nv9hRjOW6c3WRdhchnpKH0nR+I1xgak1FvRFSN5X+39Y9g5Z6QmErwfMxRweJs7N73yP7amAPu4T/ZKiMVA7l4G8JhxQlQh9YvOJRMY49ldpJRCn2wBuH45CDIFgilT4/wExIeO9/+IJYH475Tsgak1v9B7e2v7UVqSLsUnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXSB7IWK1KyqcnxqCgj1vJlNjjnB57V7VR/mGmQegME=;
 b=J8uVmNPV/BJT9xlpfEwzayTe/E5LzN33q5fz9P50EJcaSw06dhQ3oniJTgVzbZtnZytGxyxikfjdRJ20rZOqvkYpWSNMskZuyMSh7dZ/hYVxKPjVRuAPJbdqo9b1gQUJxy/mfVq+ofzn6k71V7SS6urtsDmRGYw88ZjBc2/tVYM=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM4PR10MB6158.namprd10.prod.outlook.com (2603:10b6:8:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 20:47:15 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 20:47:14 +0000
Message-ID: <96135388-c965-45b0-8c81-03b680136757@oracle.com>
Date: Wed, 5 Mar 2025 12:47:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
 <1741120693-2517-3-git-send-email-dai.ngo@oracle.com>
 <22c1c21fde3a5b17851207664571341e3dcfc315.camel@kernel.org>
 <ac7d9408-c1fd-4f4b-88a3-162a9f3cf176@oracle.com>
 <24582f1bb0778852feea0e676b7db163019c1b4b.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <24582f1bb0778852feea0e676b7db163019c1b4b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::40) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM4PR10MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 2966e1d1-6485-4295-a76a-08dd5c26e8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0gvWEZxVDdNdXZheDdaRHpzOWpIV0FSUjFkSUF0NTdEM3NpdjkxUVd4K2pt?=
 =?utf-8?B?b3J6WDFLYjVzRytIWGFzdG9rb01wWTJTTnlqVS9SWFdYV3l3ZGpUTXlaYXZ3?=
 =?utf-8?B?c1ZUczJkQ0kzSmlpVTQvcy9Oc09TV3g0WllPR3h0SnNpdUlhRWJCTjdxU2dw?=
 =?utf-8?B?UVk2VTBrQ3JoSlRBRktEdUZvVzhPUURVMkNENVQ5cXJ1L1R3YjJYZzBOdkFI?=
 =?utf-8?B?U2E5L1loZGpDTmdBbTRZODF6MXJ6TyszRUpQWTZFS0dyZnZSa0dSekZEVnBQ?=
 =?utf-8?B?d3BwOXlJbm9QZGlyNHQ3eFNOaXhNSVhTa3hVNVZ6NWdGc2xmMXhNMTdYMTkx?=
 =?utf-8?B?TGRYK3BqY0cvdC9uYUN0eDRKM04vRzFMdmY0dStueUdBSHlNeHNPMFpTRmxj?=
 =?utf-8?B?VlRTTWMxUiszWTZjOXlLbHBkSW9uVm5zRk9UeXhHVnJOdWd5RXZwaVUrb08w?=
 =?utf-8?B?SkdCTjBGUzl6MWhrOWI4R2NjKzM2ZlFScENPS3EvblNsMTNwUFpDWE5vSjU4?=
 =?utf-8?B?UnlvZlVjWGFDeW1yNzNHSXpBUWxxSDAwNitDSTF2MHE4eEJuOGNmUnVQa2lE?=
 =?utf-8?B?VDFVakw4UnVqNHZJTk9USS84SkVJZEdHcFB4dEFNcTNWQTFUYjdidnYzM2dq?=
 =?utf-8?B?b3FiV3g5aFgvT1V3WmNYSFc5UFJSd0YzUXdER0p0anZmeEs2TnhtMVNBZC84?=
 =?utf-8?B?eUtLTFVCZE12T0dQekpmTzExekdVM2ZiV2VWNUhqR05ndnV2b0phTThCNlhw?=
 =?utf-8?B?SVlha3JuWUJid29mVExVTjUyZElYWU03anRpU3RCN0k3V1pIdzA3ZVdpQ0Vv?=
 =?utf-8?B?OXZzemVHWW5DdGxnSHczczlXZStqcFJSL0t0QWxBYUpyRGRvNDJqNk5ocUtl?=
 =?utf-8?B?WHgzV2FwR3kxOU9mTkhYMzdaUVVJMjZIUmFUL1grZWY0WUt4bVh2OWtQTDhm?=
 =?utf-8?B?UmZhbmR3b29zbXMrWmtROVlLdWhzdFFYcDEveWxmQTBHMUZtQjBDTnlack5L?=
 =?utf-8?B?aDQzMkM4WHlWZHJZcTVtTXNHOWRWdC9tMEFlMHAxSVJtUnkybWkyOTRUNDN6?=
 =?utf-8?B?TVZNdFlNWGtDQmk5WittRHU2aVJDYVIyL1ZTVUJoby9MYXU3MCtTSUhieWNP?=
 =?utf-8?B?ZXFpc21zNEtFUlZFUW1UOStzRzJOd3dYVUZRSjNWMFhtQ0xvT0ZKV0U2SlNI?=
 =?utf-8?B?aEJTck1mVFJrNk95bWxnVUQ2cVRxZy9FNTNzNndUa3hNZkt5VE9tYUFJYTNW?=
 =?utf-8?B?cHlGTnlmanpPY0dpTHM0N0Z2THZ6SWI3SUJoS2VvcUx0UCttOHVRNzRudjQx?=
 =?utf-8?B?RVQ1S1hqa20xekFiRDBYeVdMcGpvWjhLaFZhajJ6Ums2UmZsZDk0bE1RN1Zw?=
 =?utf-8?B?VFhJK0dWaGhjVlVqVjlXRHhaVkhHM1FWdUx4dXBVVnFtcW4wTXE5QllqTlpw?=
 =?utf-8?B?NFFrRzV3NHlBQ1FRTW9xcjRialN4MDFyc1UwYlFxbmxWYitkL0xUdFBxTmM4?=
 =?utf-8?B?ZGJ6MGpJTjAxc2h5UlRYWTF0TTZ1MTA2WXVOMHpSSVFtQzlyeHNRNFBvbWVw?=
 =?utf-8?B?VDV5UkxBVTV0VWJCSnk2TmVSN2s2R2JNeFBlT09MSmlUWS8wdEpMRjRTMGgx?=
 =?utf-8?B?YTMrQUFJU0tZSlN4YmR2a1BkTXFEQ0p0WkMyV3RiU0VseWhYbEVSeDdRbXhC?=
 =?utf-8?B?ZitvZXNTbit4cnJES2dDbkxmejR5L3EvWEUvMGwwbGtDbGpxT0VyNFhQVmh2?=
 =?utf-8?B?alNyaFZVY2JiVnRtOE5ma2RFazhPU1lEMXJYKytVUWxndEN4QnR1YXc5dDMx?=
 =?utf-8?B?OEdHU0g0MTZuZ1pzRnJIWllxQnhxNXB3cExLZDVXdFZ6WUpIWm5aREZ6dVUz?=
 =?utf-8?Q?Brxg6pKmwPH7H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWNGSDVqTlF4SFFnV1NLL0VPRDdsN3huWGlWeDNpeFhUVVlPMTczclFFT0hQ?=
 =?utf-8?B?eEh2UGlUUzErdWxxQ0paMTRYbmFtSUc1d2VlcG91YnRtZVFKdm9rUUdpRlRp?=
 =?utf-8?B?SG00WFIzakNhWEd5VkkvWmsrc2pxMDZMMWRaMW5jSlNORjNiN00vNUVkZDVw?=
 =?utf-8?B?UGhXK1M2VmZPY1hwNVRKMlMrSnQvK2JoNnI0bWlrMzJBUlhCaWNQdVpyNlc1?=
 =?utf-8?B?dmFKUk9LNzFYYWJoRHp1ZXBXVTdsSWUyK0pRcFBjd1NrT1AwbmY1cFBpTytj?=
 =?utf-8?B?Q0VSNG9BeXV3UUNTYnpZazR5Z1ZoQWVYTit5ZktZZG9SSDJmNzAzZzB1ekpK?=
 =?utf-8?B?OTZvaHhwblgzRFJ0NVZtWlE4K2VJak02dVVZK0FreksyNnRjV1pRVHN6Tlpw?=
 =?utf-8?B?N2FTSFdONjR3ZGYwTm9EY2xUUy9mRDd0d0RZeTBDSkFRU1dBZWlwYXBmVjRj?=
 =?utf-8?B?YU5lamkwL054ekpzRFpydm9PL2toSDh6blRMWnc1dHJpeFBpTGFzMzV5Q2gr?=
 =?utf-8?B?R01LNktvUm8zOG9jUThiMnZtY3F4a1RCd3UvbEhZa2hFVGlrSDlnWHJocVpa?=
 =?utf-8?B?cTVQMGhIOHd5ZnZhSTBRUjZFSWw3V0pVdWt5SXhqYXAvdHFaVUIxbU1FZDJH?=
 =?utf-8?B?aHlYY3BQMHljV0hNUm5FMS91TFE5Ty9IYWtYMVdScU8zckZNaXVQcXc1TVg2?=
 =?utf-8?B?SzFHWkFqS05KcXdjR3ZWMm1VRkVUbWpOdUZ4SXJZZDRlV1JQUHpTMDhuVzYy?=
 =?utf-8?B?SFMwWXJyOEpNNkRjRzcveXVvK2VzOUdsUVBMa0JkMFpmYmVYNUdjU1VMR2pZ?=
 =?utf-8?B?WVo1UlhYRDlyWVdFM2pJUUdOZ2poSGJmZC9henA0QjRNbDV4cFI2VVhxYVpy?=
 =?utf-8?B?U3Z1SStZVzdtdE5xRjhEYjVHZnIzSFd0YXBneVJ5T1JXL1RqWkpndzZZSEFW?=
 =?utf-8?B?c0NKQ3NMT3hza09LTXZwTkpqZFdqUkt5UE9aMEJSWUd0WmtpK3dsTWwralhh?=
 =?utf-8?B?L3M5anpWMy8yU1UveUVtVCs0L3k5Sitsd2cydGhFbk9DNlB2K2tYbGtYYmhB?=
 =?utf-8?B?bnlNZlhick5OM0FDclR5WlZCR085RHZrWEx2aStEZUxtaGsrS0IxNlBUbXYr?=
 =?utf-8?B?bWxWYmpvakdLUkxVb2lSZ3F0U0cyMExRak9oSkxYenk0WVZNV3hQeXIwbHpn?=
 =?utf-8?B?eGV6dTBmWURPZWt3VmVpNHl5emNIcG1xaWRjSGpNMUdiMXdIOFJnb2FiWmxO?=
 =?utf-8?B?ZHc5TUp0b0d3d21TcTJTN0pHTE00eFo0SHEzcnltZGo0WXFnUUtSbkpTdno2?=
 =?utf-8?B?eHNEaGVaZlFPSVhUaDJHVnBqNmVoTGViRndVWUk3TzdlVnBnaUdGM3VlUEta?=
 =?utf-8?B?WUF2RFZrVjdDNk9XL0pWV2p3LzJaYXFIZjk0TzZQeFlKUzMzZXN2SzdlQ0Q2?=
 =?utf-8?B?YTAzUkNDTGFzek5seXQ3azErWmdHZ1N1eXhEcjJrWVBFQTRJL3I3UnRVZnVS?=
 =?utf-8?B?ZWZoQTZmNGhxQVBjdklyRURDUnExYU5mUC9lNnpmOWRDeUpYNEM4SXpFbzBh?=
 =?utf-8?B?ZmJET3BGbnJ0N1lidTMzeU5QV1A5dDRCM3FKaVJDOEdsVHF1VlRkaWtuK1Nm?=
 =?utf-8?B?VlpFMEpqYzNjb292SHJTK0k3QUozVEJBV3RCcEVuSjZsQzE1L2ZNckJWcG5W?=
 =?utf-8?B?VElqYlk5clh0OGdwZ1RKMUFRU1lucW1yUUVzVkZXUWlKVHI3aW15ZWNJUGRQ?=
 =?utf-8?B?Y09pV0pwZUZuWGtqOTV3dWFZZWV4emR5OGhPaVllMm50dkhVZDNsa0tEbnl4?=
 =?utf-8?B?QkEzZUI5WnhBMVVuVUN3cHNzR01qUlpPd2h4d0FidEM0M1hXeXZPL0c2K2hN?=
 =?utf-8?B?eWV2N0ZRdlBaQytZV2VlYlZUTWJIZEZIaUk3ZW1ucjJqUjBjL0ZiZjh4bXVM?=
 =?utf-8?B?RlBWRkFZOTRtb2kxMmI1cnZOYzNiQlMrU1FnTWdEUjNXQ3BhVVRKVktLekd1?=
 =?utf-8?B?LzBmcDNpbm43a01YcW9uWDljNk9wTkxBN1NTVEM0azR5T3FyVWlneTZNaHNB?=
 =?utf-8?B?WTZnZ3RzWU9oQ1NpampxZEdEUFZiU2NWTkpyMU4rOU9VQzBIcVhYMnJaNlIw?=
 =?utf-8?Q?9mMVfxrSggYgvMI8ljHlE3oxO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i8ZY8GLXTapYXEQbCdODanv9nKU6yJsXYAJh9g/xUy63zZNz3R2KLuW2vOMUJ8IsnmGuurcPdI53oZ5sbo95O9VHW5qc0DsfmY+goIB/2RoNpL8D9t+WoBWRV8s2CXkqHQ3FBs09h1OmzY1PkoUWhzO8ABWqYK080CG5J0+qF3GAeTyVCG4DM23+B5TkNEbDIQtfUXy3cQ9ZboLTt/fgOeTaCtV6cSPNfJAeuwbR2M75gmWcAh3Bb/bjps1uUOWNQPYS1tfPMtGNzHGmUwC4EVt+q6zC9jhTH4CR0t0ZPtcimkiMD2Ov7hWL+2ZqsfBhq//Qw4rPjp17aA9kcpCTAsTJhyrCVrVokTdqfsoWgNi8918ENCpXzcw1vz1oG6G/59Jzz0xZJjZqDe6DjHQsWRJuiWft/U2X37s7Sl7epVyX//uaXQxR+AfcENe7KDFe/3VpiHL6KToNkB89IUjG13wLa1ZNYmAPEJpaa2p43eA4egA8rMK/aQt5uayasqfXTXMJ9DNKafg8tPIDlRWa6xORAHIy0ThR+VUGG2DjFW8f5JV9ZMuWAJY9Y8+CBt8P7Xv3Qp6jSOlnCeaIkRUOnUHgs4MZANRkc4tBiD2HPXw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2966e1d1-6485-4295-a76a-08dd5c26e8da
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:14.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbxOk7Lmfq4oFtsrB2j4j27pYNJoG+C6KUuTUjvXF0AjCopI82vrVRR11w7Za8IeqkFyrr94aDJ7APgFxFxHGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503050158
X-Proofpoint-ORIG-GUID: tKMjWlWbesg4Rca9Oi6g3baj422l22iV
X-Proofpoint-GUID: tKMjWlWbesg4Rca9Oi6g3baj422l22iV


On 3/5/25 8:08 AM, Jeff Layton wrote:
> On Wed, 2025-03-05 at 09:46 -0500, Chuck Lever wrote:
>> On 3/5/25 9:34 AM, Jeff Layton wrote:
>>> On Tue, 2025-03-04 at 12:38 -0800, Dai Ngo wrote:
>>>> Allow READ using write delegation stateid granted on OPENs with
>>>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>>> implementation may unavoidably do (e.g., due to buffer cache
>>>> constraints).
>>>>
>>>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>>>> a new nfsd_file and a struct file are allocated to use for reads.
>>>> The nfsd_file is freed when the file is closed by release_all_access.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>   fs/nfsd/nfs4state.c | 44 ++++++++++++++++++++++++++++++++++++--------
>>>>   1 file changed, 36 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index b533225e57cf..35018af4e7fb 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -6126,6 +6126,34 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>>>   	return rc == 0;
>>>>   }
>>>>   
>>>> +/*
>>>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
>>>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>>>> + * struct file to be used for read with delegation stateid.
>>>> + *
>>>> + */
>>>> +static bool
>>>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
>>>> +			      struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>>>> +{
>>>> +	struct nfs4_file *fp;
>>>> +	struct nfsd_file *nf = NULL;
>>>> +
>>>> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>>> +			NFS4_SHARE_ACCESS_WRITE) {
>>>> +		if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
>>>> +			return (false);
>>>> +		fp = stp->st_stid.sc_file;
>>>> +		spin_lock(&fp->fi_lock);
>>>> +		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>>>> +		set_access(NFS4_SHARE_ACCESS_READ, stp);
> The only other (minor) issue is that this might be problematic vs.
> DENY_READ modes:
>
> Suppose someone opens the file SHARE_ACCESS_WRITE and gets back a r/w
> delegation. Then someone else tries to open the file
> SHARE_ACCESS_READ|SHARE_DENY_READ. That should succeed, AFAICT, but I
> think with this patch that would fail because we check the deny mode
> before doing the open (and revoking the delegation).
>
> It'd be good to test and see if that's the case.

Yes, you're correct. The 2nd OPEN fails due to the read access set
to the file in nfsd4_add_rdaccess_to_wrdeleg().

I think the deny mode is used only by SMB and not Linux client, not
sure though. What should we do about this, any thought?

>
>
>>>> +		fp = stp->st_stid.sc_file;
>>>> +		fp->fi_fds[O_RDONLY] = nf;
>>>> +		spin_unlock(&fp->fi_lock);
>>>> +	}
>>>> +	return (true);
>>> no need for parenthesis here ^^^

Fixed.

>>>
>>>> +}
>>>> +
>>>>   /*
>>>>    * The Linux NFS server does not offer write delegations to NFSv4.0
>>>>    * clients in order to avoid conflicts between write delegations and
>>>> @@ -6151,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>>>    * open or lock state.
>>>>    */
>>>>   static void
>>>> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>> -		     struct svc_fh *currentfh)
>>>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
>>>> +		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>>>> +		     struct svc_fh *fh)
>>>>   {
>>>>   	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>>>   	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>>>> @@ -6197,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>   	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>>>>   
>>>>   	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>> -		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>> +		if ((!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp)) ||
>>> extra set of parens above too ^^^

Fixed.

>>>
>>>> +				!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>>   			nfs4_put_stid(&dp->dl_stid);
>>>>   			destroy_delegation(dp);
>>>>   			goto out_no_deleg;
>>>> @@ -6353,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>>>   	* Attempt to hand out a delegation. No error return, because the
>>>>   	* OPEN succeeds even if we fail.
>>>>   	*/
>>>> -	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>>>> +	nfs4_open_delegation(rqstp, open, stp,
>>>> +		&resp->cstate.current_fh, current_fh);
>>>>   
>>>>   	/*
>>>>   	 * If there is an existing open stateid, it must be updated and
>>>> @@ -7098,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>>>   
>>>>   	switch (s->sc_type) {
>>>>   	case SC_TYPE_DELEG:
>>>> -		spin_lock(&s->sc_file->fi_lock);
>>>> -		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>>>> -		spin_unlock(&s->sc_file->fi_lock);
>>>> -		break;
>>>>   	case SC_TYPE_OPEN:
>>>>   	case SC_TYPE_LOCK:
>>>>   		if (flags & RD_STATE)
>>>> @@ -7277,6 +7304,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>>>>   		status = find_cpntf_state(nn, stateid, &s);
>>>>   	if (status)
>>>>   		return status;
>>>> +
>>>>   	status = nfsd4_stid_check_stateid_generation(stateid, s,
>>>>   			nfsd4_has_session(cstate));
>>>>   	if (status)
>>> Patch itself looks good though, so with the nits fixed up, you can add:
>>>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Dai, I can fix the parentheses in my tree, no need for a v5.

Thanks Chuck, I will fold these patches into one to avoid potential
bisect issue before sending out v5.

-Dai

>>
>>

