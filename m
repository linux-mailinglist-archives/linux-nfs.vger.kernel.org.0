Return-Path: <linux-nfs+bounces-15252-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5BABDAF0C
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 20:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F36A1922E91
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 18:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5C273809;
	Tue, 14 Oct 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cVmzzUMM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mj7fcD0D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF42877D4
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466363; cv=fail; b=FOkPMVoNOR7nwPHuD2DDIRn6qvwbgg3P+PtK/C/C3fuluiBC5y5qenB8FyDOaZRfqKuoGzZPKDXthYzxodUBcDtxvT9l+RuS8Tq/QzjFNrDYjcfVkH+0gTWRVssuMWxOZs1uw34xmflhh3/F3zJh91FqNoJQk9CVIgeMs0lK63s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466363; c=relaxed/simple;
	bh=5bBI1CX3NRFf+narYJPByoHbF4Nd2Z/lOITK+kEOcsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XaoOwVbGGkP+rTQ8aqWYabEdvNxRvbpGpDy5mH/RDbsb5dTCV5qqf8jeJ4tjiXr3WJiOyAtBYJ6gPsD94TXDQaYjb3y2D/TbQMYeqtSeoJbN9Qk9ccYDXfaV2tOTWnWCcNGyfz0g05SNz6FxHWZg9fw1VPcmrm7VKqffgCyy34U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cVmzzUMM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mj7fcD0D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEfLfx019482;
	Tue, 14 Oct 2025 18:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6LOOCBBpE2tP8YcTeJa+WGVWElZObuF5eXmFZcVOYgw=; b=
	cVmzzUMMGFmDWN8XzSMmpTchZsO5KedIn8lACPRuQ/HNc88mKdRg4V4+YrknuW9n
	ARUZjgwYiOxTPBnU/2zegVbcpBQ6ZKNaxGPyPAx3e4wmXG4X0XFK5PFkjcYfahU4
	ff7Wt+CSf+v8c6n9evEkcQ66WKXHedvayuCWzEEaBKRKuPemrHuGreVq6HSxoWOO
	OBYyqvO/bsP6xNjWy0wtzcBr00Ri9lfv709g4g+1DTFQVIe2RqksdROuzbxuTpEl
	RlBMGEShe0o9jOAIXpApAIyhU1JcjgdNfuju59iqS3R/O4dc2s9br1yFNu83fWhD
	w0i6Nq38zCsLmLmGJse8MQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9bw2r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 18:25:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EHL2Gf018397;
	Tue, 14 Oct 2025 18:25:50 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp92nsm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 18:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkt5xPj68t1VDIeNJZmlirlsBBObwsGrthykK6npKNSQyayeyOrMUjXb7mNfDXJLoBuyw4wEhZIecWi+rtonMQOCptkSz/IKuIrSXzUKNgaGgjpX4u2jQIY5gCb16OVnQEzWe32iB3lH3BpfVsiSp6NCQTAgg6voOLXTD9RSHu95ONwdpBidoe4754ya/r6P4GdbH8XSaeFvT+qRHPyrJulgfGnHCyG3SWtxzawb4mAF2B9JYs5rN9Rp0NP2haxz1e9zyjkj0evcxZWsPGN8SSybbR0cTqTXSN123FvYKslK+yTQsdyQF/NzmiVCX2AOIJKLkAYmB6kIH6d9QX/vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LOOCBBpE2tP8YcTeJa+WGVWElZObuF5eXmFZcVOYgw=;
 b=gzBu8FWqvSDzKG7vjg5S78LWU6YoheqwgUeNkt7qr2k/9OYwhDlZBXfi5Zthlln43T4xJkKQ/tuOLWS1LDMFF9Zb3s/3+jfAai0s+z7vhAmlHvNBaCCNK+d/fyPdHyhmphhntsN8ehSAUTN94jJz2pVcpVlGV42KeowUtTKQTSkF3JwPLZb1oSRzAfY4n5pqAYSpqPq3JMh/GWcRZUkSGB5wURWxI/goBPmWTomLx5oYRHnTdBWLu71+ECRV7AtdQgNdawsCATrf/7YHQuXzCK9tI0xMEcIOy94N/w9aSXk3I06kCsFXOVmrlBEx7eCGMBVRVT8azvxa3RnaOLV2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LOOCBBpE2tP8YcTeJa+WGVWElZObuF5eXmFZcVOYgw=;
 b=mj7fcD0DJFeP7khEV8jZxm2XuJMRXSJ1RyOsrpClVkL7xOGjSZmArvrDfgyq4pRFl9ssdINiSLrILunPWmQ7CW2wcmj7mMigjs+WyU2pAv8BsWsaknIREirxGy8jIHvmtlHlrZ+HCOP1oT+izPW5geIJ2aX9ypBUc2cVImmaFPY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6783.namprd10.prod.outlook.com (2603:10b6:208:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 18:25:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 18:25:45 +0000
Message-ID: <42b57300-40e2-4d7d-9ec6-4dc9e2583f2e@oracle.com>
Date: Tue, 14 Oct 2025 14:25:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: free copynotify stateid in
 nfs4_free_ol_stateid()
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20251014175959.90513-1-okorniev@redhat.com>
 <53d794cc-daa8-489a-8fcc-173e5cb8ef75@oracle.com>
 <CAN-5tyEPpeQt8eRXkP2MgnnPBmjKY6cZSe6k8wVL53GDr2445g@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyEPpeQt8eRXkP2MgnnPBmjKY6cZSe6k8wVL53GDr2445g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 9758018c-3c1d-4447-5051-08de0b4f175c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eUVBZmhvdDhSQmJtZEx6Z3ZNQzFZWEZ3cmxSdGx1R3YrQWxoNzdwRlI2eDU1?=
 =?utf-8?B?ZnoxcXFsY2NZWS9yWHYzMlY5eGJQVkQxSWsvUW53RkxROEdJaFloVHRMUXVE?=
 =?utf-8?B?eFhJVEt2RWkrQ1kvRTNNS01qMGx5TGN2bWc5ZStqc3VmUTRYMk12TFBzS011?=
 =?utf-8?B?YlVFamdBTXppVUw3M2lYOFQwVTJ5MUxyN2g1VERSUjZ4YnlTV2pJRHNNSXJ4?=
 =?utf-8?B?N2lUa3BkNG1rRUcrSkdSZi91RGhuWlY2RmpvOGI0YVlYZVR3Sk5haC9SeUxp?=
 =?utf-8?B?b1JMTkxXanhYVkJVVlFZQzFaNGtYQlJON0VSeXk1Ri91bnVURFVtc1RkMEtK?=
 =?utf-8?B?NEJkK3NuZEFVa3NDamJscmdqZVR6Ukt3Q3Q2UmIvZDZGUXpEaHpUUG5BRStH?=
 =?utf-8?B?MFN3NVhpQXRDa1RYZXdiSWsyMWEvcjM1V28rcVljY05ZNTU2dW82ejM0R1ZS?=
 =?utf-8?B?TEd0SFNXVGU5cUZCTWxDcG05T3RHUWhBN2NuVnVpeVpIUXBMOVZtc1BTS241?=
 =?utf-8?B?WDZiL2VuK0ZYbXBveXA1ZzRBdkpiVDZDT3pCWW1WQyswYTk5Y3UwWHNJblIr?=
 =?utf-8?B?OXFSdVhSSFZKbDRkSmpnTmZoZCsrOHFtekdEMmc3NHdzSHV4M0xLVWxEOFlB?=
 =?utf-8?B?bXE5d05HbVhpQ0Q3c0h3Q1k0VnIvWWlqU1YrOUFTYW1zSDhlY1l6aEZWZld1?=
 =?utf-8?B?Y1hCSHNGWHljM2cwZWNLcGFobGc4dmg3M2cxaFBFbHA4M1k1RzFHUG9KTmdl?=
 =?utf-8?B?R3VXeE14TlJkSjJyVTM4b3Z4d0FNTElTVzk5YU12MlI1ekJGOHpZYUpIUXc4?=
 =?utf-8?B?OXNtSlA5RzRGamM5RThwZFZRRGlmV3orVytpd2VyNWt2YVdnWE1LQ1A3a0Fl?=
 =?utf-8?B?RElhWmFjZzQrbXlUUU9VdDFKdTBGb0ZzQWlhOHZ2SnJIVUE1QzlaTFMvR3dD?=
 =?utf-8?B?SnJMS0pQQ1g3a0lkTjhZNG55OE1rS0doK0xJeWNoM3QrZVZYSERXRjV0a0Fp?=
 =?utf-8?B?YkpydlM3QnY5SXlCYldHWUQzZVZJU0t2T0ZYcVY4S3dPdGFSV0MyeGcvckxB?=
 =?utf-8?B?ZzJxQ1p6R2xFeU5hSE9wRGZsQjlyZUJ6OE9FKzJLZ3pJanBVdHRvSy9UdGU2?=
 =?utf-8?B?QjhJY1ZWWUhBYlFibFJxZ3EzdXJ3bGpEanJ3U1pVZ2NROHkwOHhLVDk5emYv?=
 =?utf-8?B?SlB4eHlDRGJ4UUJWelo0citKK2M5NjZrZHBJaG92b294eWpGdHBBWXJLNTRx?=
 =?utf-8?B?L0c5VnAyQmQvZmc5eFRmNEp1dmlCTFhqS3h0NHF3TUJnYW14d3IxRWxEMjc4?=
 =?utf-8?B?VnFISUZqTlFuZTFJR0k0T2JBNG9iZEF1UlIrdlQ4bWRtU2dXTzBLL21OZmJ2?=
 =?utf-8?B?a0FzTGQrdVRjQktCeHU1NE9hOG5ORkZSMGZLcUxXNlpCU0dJZnBHSTVndVVQ?=
 =?utf-8?B?ajUvdHcxRWVlVDBTVjhYdk1YSGd3S28rTTFsbHhIU1RLM1BRWlc5UmxOeHpo?=
 =?utf-8?B?eVhLRng2dmxMWXV4STZ6em5QNENsakIzWDcyZ29jT2JSejhETkxEQ2NIT2NZ?=
 =?utf-8?B?TktwYW51VnZMMkpDT2hvMjdiQ1gvUDFzOENIYUM0MmhMVng2Z2JBa2pSTGRa?=
 =?utf-8?B?RkdUem45cVNzdG5rSGNYbGdNdCtrVVdubFJkdVRqaGFHbDhXQ01UMERYbFk3?=
 =?utf-8?B?UXRPU1NWUzVjWFdhZlhXaER3QWtXZHUraERjTDY3NGhkNkVlM0QvRy9hTnlv?=
 =?utf-8?B?cTZlTnNIYWcvZUNDaUZXVmVlejlUY0F2RDhXUW4wUENFelhqS21XaW9EYk1j?=
 =?utf-8?B?dUVQY3ZxUEoxWm01K00wVnl5N2lsaDdMNVVLaWlHb2kvbFZrN0ppa1N0dk5E?=
 =?utf-8?B?NUk5SGFvRERpdFRlWWlHRGQ0VU1DN3NNOTdOWVBFNGtRQVNGNjl2Y1JUc2w5?=
 =?utf-8?B?dDJMYXBVL09jVjErWXFPZWhpRUlMdFJOUW9FTzlIbWhTZ1NTaWp6WC9wYkxH?=
 =?utf-8?B?VXpGSXcyRWt3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?KzMyTWt2OC9kZnNwbzJoSXF6aUFudEkvMVU2c0RZdDFZaFJVZktRcHFoeW5F?=
 =?utf-8?B?ZFowUFhlbUFYenlPQXlMazYvc2YwUFJyUm5aTDNQenRqWHQ5VldEUXVZbUxs?=
 =?utf-8?B?aHQvanlUQVd2c2ZnUG90K0ZxbXNzZXVOVHZiMTJrUlR5Rk56V085WUJhVDEx?=
 =?utf-8?B?MlRiandhWEkxQllkYk9jcTBMRGtmQ016ajYyTld0dkpaS0kreUc1WUdUblNz?=
 =?utf-8?B?Z0V1TDlJb3VUSS9HV0lwTWsydnpKOGE5R2FKZDJ4N1VjeGY0R0lwaTIrMUpS?=
 =?utf-8?B?amRxRlJPNGdEbmptU2pXZWFKVWEzTzhEalFYL0VuTG1nbFdMdlAvWXhRSE9t?=
 =?utf-8?B?MTlISjBNcEpJbDJJemN2cnlEWjB3a3BUR0h0am1CQnltRzdlVGtlY0FMQ01l?=
 =?utf-8?B?dk1wRGhpMS9BemJHeXJiSENwMSs1Nkl1ZXNlY0FCcmF2aE9YMkVUMks1Z2hr?=
 =?utf-8?B?WnhPWGJjNHVsbXJxTzJwQVRkcFFNRGZJNzUzcWphOEtGSzZBN2U1VXBFQ3ZP?=
 =?utf-8?B?SHcwb3cwWHU0dHlRYTdzR1F4THoydlpHdms4RmdnekhRYktWN1A4UDdRSjVO?=
 =?utf-8?B?SWFlYmt1ZFUvVW1mYzdaWkpQaUhMTXNJSG9BUTQ1alc3dmMzaGtjQ0JsWXdE?=
 =?utf-8?B?VjVrVWRiSWs2ZWdLQ2t6Tkk0dmN3RDNNMHZsN1BPR3Y3ZGlROWN2VU1ZY0Nn?=
 =?utf-8?B?MG53MGtobGNLcjV6RUpySWNTaGpvTVJucjVkcDJxSEo2U3F6bmVNRkVzTkRz?=
 =?utf-8?B?enl1L29qSDN3WjI1bGljMysvSUx0dC8vWHdRcm50OHViaWh6cmZhOEF3L3lH?=
 =?utf-8?B?KzVLWGZrK0FQVHBJR0Z5MERwVGh1NWZ3TFRUTVBYRitadUJqbG1Eb3BaUlQ5?=
 =?utf-8?B?VTJ1aWJ3R0pYNzl6Q2pSYjdaSnVLbFFqTU1YV2hyajE2UzR6bTYxdUViMFJk?=
 =?utf-8?B?bVlVbzZEYkxMV0t2bTdON0FsR3ExK3AwMU1vZ0F0TFhpM2RiTEU3RTZWMExO?=
 =?utf-8?B?NjRTOEtuOCtGQWpnRG5QNFBhbFo5S3c3U2Rtek13L2VsMkxaZDBMZWtzeWxT?=
 =?utf-8?B?K2dLTzJXbm81cW85Ti93S3RjajEydGdmM3hIemV4NFpRVmlTLzNPTFRPK1Jj?=
 =?utf-8?B?ZTBhNWJHYnJsNytWNUtaN1pkSzNVdDlmSGx3QTJjQXIwSFpodm8xTlVSUzhk?=
 =?utf-8?B?SVJQTmYwbWRBcTc4TWdZbnR1SFpaN3NWSFUySExUYlF2ZCtjSW1iVTFkS3BX?=
 =?utf-8?B?WE5qRHBQeEUwWkxJMTYrQWlDOHJ0d0JCTEIzcVo4QmR4QlBwZXR2RW1QUmtJ?=
 =?utf-8?B?UzN1QTQ5dGhqZVhSMmwxa25aVU4waHNWUUtZaEtQRjg0MXBMckl4ekRzUkZL?=
 =?utf-8?B?SUtSelE0SGtEYTQzS3ZsSXc0TzBPK3gxS1ZITWduUjF5dWxBV2NPOWRCeGdQ?=
 =?utf-8?B?bUFmd2IvWm0yM1Zoa3JlOC9MNDI5VkxqQ2swbHh5enZaakFsNVcwMlp3LzQr?=
 =?utf-8?B?ZEpOZUlKN2ZrK29iMDU5a2lIUlRYMHowYU9MeE4yb2pTNXpBeFEyRXNiK3Ay?=
 =?utf-8?B?U212WlQrMWtEdDZGT1FOYTg4b2RVa0hGcUd4alRCdkx5RFhQdVd4a1pCVUt6?=
 =?utf-8?B?UFBCaGZMck02WGYrZWY4dXExLzVEQUJvVENhcGNDTEFiV3ZsbTYvZUNGOFhw?=
 =?utf-8?B?TEtZT1VCTnV5b3Y0WGNwOFd4Z3JSdDd2MlUxZnhFY0J6VGpwakNxS3RINFpD?=
 =?utf-8?B?L0xHd1E5Yi94MU4xeVNYaS9peDI2ekt6RjVDYUFYYnNwQkJLcnJsT1Q5MHdw?=
 =?utf-8?B?U1MxNnQya3o0KzJ6NE4ybkZ4d2hlQ0t5YVZDUW8zM3ZVVDBjLzZkYXIvNGkv?=
 =?utf-8?B?TGhXaDBvcm9CY3FOMlU5QkNwWkF4Z0I2R1Y3NDI5amtxSklDVVFZczYxR29p?=
 =?utf-8?B?MXN1eTZzR3FJT0VITFBKL1lsM01tczBqTTlDcW8wSTRRYVZpZldmRkNiZlha?=
 =?utf-8?B?TXRaVFNKRkRrQmJ3bjhYeGw1enB0NEVzOUlSVTl6WXByOHN0QmpIaGllMzJ0?=
 =?utf-8?B?cmV2cXFoQ3lpa040RFA0dk53b0NDS2pueGd0S1l6b2w5Z2JXZWVVcnVLUnNl?=
 =?utf-8?B?K3Avako5bnIwM2VLWHQ4a3RKM1hKTEMvdmdWVVVaaXFpVTQ1d1Z4bXhMUTMz?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9c48uIJK1P96N2i3gILyvIy46SfK1ZoDaCs5+v6fzx2Ewje0+oDQf+sx/K++3jITWpqkK3KNcA5cTWC2KrZ6bTWCg/g/nRAswX2Wz7C3G8gmukkUG42zfBSKUJj7pxxBAdfef8ekUrMcllxiBdu3TCo9flefpVDJhcMwgTUQbHH1BVQGnmhQzzXJIPjYIhZRILu8OrVgQFCoyAVLO4E3sbjvG1P1w0IJ5LQzXoA217RfdSzZigDr30uT+uMeqeAVz266XvzRNxCJ3wguiyrm3ufKaXnjqTLFddXggK12EydBgx1csGed9f4TRnOML20shtLYr1vhBaEt+DCfTlufXcv6pObuNdNY2ZvEjtPvofTQwP0a+ametStXDacrzGLN4FW5US5xxm9Hdexk/Vr2HU3qbvfHSIK1al4a3qpVRFQyMKvW7N2+dz47P/0IS49Qsim/T0YjVslUG8RHuciVHz+3hFeD3KHGTbZ/iiGj2WKth3yRR32XKBzVT6ptdSsCTWCY6NRIZWuUJW7FXJyd+u0ibjC6Q+zDp0LwDN4X97WVXx6mPI4SqsjCmyepPgskeWVxP4TESSnhmyakEEnqGet2Xou2Ma9Lg7j1Y/ARFG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9758018c-3c1d-4447-5051-08de0b4f175c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:25:45.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAnXiVcQ90mXOfrCx4AGaNKcTgCQJeXO7scVOwDnBuSpNYIiUymAeYFVD2oYb5VsxyJZcHeBxCZFx3PW0ojgDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140135
X-Proofpoint-GUID: S_Xy_w4qYYx65A_3DFQ5Bqoz6E-PExKk
X-Proofpoint-ORIG-GUID: S_Xy_w4qYYx65A_3DFQ5Bqoz6E-PExKk
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68ee95af cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=QlTix4eMWeUHQVdeilQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX84/gsfst2FP4
 3+ntdBiMaZ7idYNz56xNew0yFaGISjInEVqN6qwn+MKCJEQySTsq+2N9SP5uICINIKMLLOCrfU2
 mqzVSAS63IZYNjrHSgxVKF+1wDKt7YQJguNBEKDqqbGtTPzlk0hCYvS96hWhAKEJjM0ED0hsqNk
 LUFOMrOJQ32IsC3zSLM1b/Rxncmay6L8OOpLCA62NKUIrp3gf+26cLu7KLglW3/HuK/OvEbqMjm
 k9wNEoIMIc5MWlJaL+nNWCEas7FDPgbTjO7yjfH/si5AHvXDsXI4br+93zhRv3vIdjzMOBkwpET
 JDo5/mKzC6QSUKVKZdC0SagJWMa9EWyfw9xF6FNDNF+1MBWtEiK/kFI0CGMK5rJLWLqpe4UQ3aA
 gvJkaaHT2zdZV9HeJwoHNdAtLf60SQ==

On 10/14/25 2:20 PM, Olga Kornievskaia wrote:
> On Tue, Oct 14, 2025 at 2:05 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 10/14/25 1:59 PM, Olga Kornievskaia wrote:
>>> Typically copynotify stateid is freed either when parent's stateid
>>> is being close/freed or in nfsd4_laundromat if the stateid hasn't
>>> been used in a lease period.
>>>
>>> However, in case when the server got an OPEN (which created
>>> a parent stateid), followed by a COPY_NOTIFY using that stateid,
>>> followed by a client reboot. New client instance while doing
>>> CREATE_SESSION would force expire previous state of this client.
>>> It leads to the open state being freed thru release_openowner->
>>> nfs4_free_ol_stateid() and it finds that it still has copynotify
>>> stateid associated with it. We currently print a warning and is
>>> triggerred
>>>
>>> WARNING: CPU: 1 PID: 8858 at fs/nfsd/nfs4state.c:1550 nfs4_free_ol_stateid+0xb0/0x100 [nfsd]
>>>
>>> This patch, instead, frees the associated copynotify stateid here.
>>>
>>> If the parent stateid is freed (without freeing the copynotify
>>> stateids associated with it), it leads to the list corruption
>>> when laundromat ends up freeing the copynotify state later.
>>>
>>> [ 1626.839430] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>>> [ 1626.842828] Modules linked in: nfnetlink_queue nfnetlink_log bluetooth cfg80211 rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfs_acl lockd grace nfs_localio ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops snd_hda_intel uvc snd_intel_dspcfg videobuf2_v4l2 videobuf2_common snd_hda_codec snd_hda_core videodev snd_hwdep snd_seq mc snd_seq_device snd_pcm snd_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp nvme ghash_ce e1000e nvme_core sr_mod nvme_keyring nvme_auth cdrom vmwgfx drm_ttm_helper ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
>>> [ 1626.855594] CPU: 2 UID: 0 PID: 199 Comm: kworker/u24:33 Kdump: loaded Tainted: G    B   W           6.17.0-rc7+ #22 PREEMPT(voluntary)
>>> [ 1626.857075] Tainted: [B]=BAD_PAGE, [W]=WARN
>>> [ 1626.857573] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
>>> [ 1626.858724] Workqueue: nfsd4 laundromat_main [nfsd]
>>> [ 1626.859304] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>> [ 1626.860010] pc : __list_del_entry_valid_or_report+0x148/0x200
>>> [ 1626.860601] lr : __list_del_entry_valid_or_report+0x148/0x200
>>> [ 1626.861182] sp : ffff8000881d7a40
>>> [ 1626.861521] x29: ffff8000881d7a40 x28: 0000000000000018 x27: ffff0000c2a98200
>>> [ 1626.862260] x26: 0000000000000600 x25: 0000000000000000 x24: ffff8000881d7b20
>>> [ 1626.862986] x23: ffff0000c2a981e8 x22: 1fffe00012410e7d x21: ffff0000920873e8
>>> [ 1626.863701] x20: ffff0000920873e8 x19: ffff000086f22998 x18: 0000000000000000
>>> [ 1626.864421] x17: 20747562202c3839 x16: 3932326636383030 x15: 3030666666662065
>>> [ 1626.865092] x14: 6220646c756f6873 x13: 0000000000000001 x12: ffff60004fd9e4a3
>>> [ 1626.865713] x11: 1fffe0004fd9e4a2 x10: ffff60004fd9e4a2 x9 : dfff800000000000
>>> [ 1626.866320] x8 : 00009fffb0261b5e x7 : ffff00027ecf2513 x6 : 0000000000000001
>>> [ 1626.866938] x5 : ffff00027ecf2510 x4 : ffff60004fd9e4a3 x3 : 0000000000000000
>>> [ 1626.867553] x2 : 0000000000000000 x1 : ffff000096069640 x0 : 000000000000006d
>>> [ 1626.868167] Call trace:
>>> [ 1626.868382]  __list_del_entry_valid_or_report+0x148/0x200 (P)
>>> [ 1626.868876]  _free_cpntf_state_locked+0xd0/0x268 [nfsd]
>>> [ 1626.869368]  nfs4_laundromat+0x6f8/0x1058 [nfsd]
>>> [ 1626.869813]  laundromat_main+0x24/0x60 [nfsd]
>>> [ 1626.870231]  process_one_work+0x584/0x1050
>>> [ 1626.870595]  worker_thread+0x4c4/0xc60
>>> [ 1626.870893]  kthread+0x2f8/0x398
>>> [ 1626.871146]  ret_from_fork+0x10/0x20
>>> [ 1626.871422] Code: aa1303e1 aa1403e3 910e8000 97bc55d7 (d4210000)
>>> [ 1626.871892] SMP: stopping secondary CPUs
>>>
>>
>> Reported-by: <rtm@csail.mit.edu>
>> Closes:
>> https://lore.kernel.org/linux-nfs/d8f064c1-a26f-4eed-b4f0-1f7f608f415f@oracle.com/T/#t
>> Cc: stable@vger.kernel.org
>>
> 
> To clarify, you want v2 with these lines added?

The additional tags in this email thread are picked up when I import
your patch. No need for a v2 unless reviewers ask for substantive
changes.


> (do you want me to add "cc: stable" too)?

As the policy document states, please don't add "Cc: stable". The
maintainers do that part.


>>> Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>> ---
>>>  fs/nfsd/nfs4state.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 1c01836e8507..c197438765db 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1542,7 +1542,8 @@ static void nfs4_free_ol_stateid(struct nfs4_stid *stid)
>>>       release_all_access(stp);
>>>       if (stp->st_stateowner)
>>>               nfs4_put_stateowner(stp->st_stateowner);
>>> -     WARN_ON(!list_empty(&stid->sc_cp_list));
>>> +     if (!list_empty(&stid->sc_cp_list))
>>> +             nfs4_free_cpntf_statelist(stid->sc_client->net, stid);
>>>       kmem_cache_free(stateid_slab, stid);
>>>  }
>>>
>>
>>
>> --
>> Chuck Lever
>>


-- 
Chuck Lever

