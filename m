Return-Path: <linux-nfs+bounces-16367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D4C5A51C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 23:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 816D44E1227
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 22:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B082773F4;
	Thu, 13 Nov 2025 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hzZjTTfe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wyy5Jjds"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6876026;
	Thu, 13 Nov 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073077; cv=fail; b=D75MxQhjzqUYNp0HEcjboLUrON5fFyvv+U4piyxMVKaOrU9BUMh+Xhnq2cQabY+O3IfP++m0XS1Su+Pd7LL3EeROij66GTzLfJo411Hpks6ZdNfRauVnVCW2JA2X+QZ79EsHXIIzp9KZcw0uQ9bj18acyab1oJiDUpN6jGuItus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073077; c=relaxed/simple;
	bh=NxulQEVPXs8OqpT3KtJ2m7w3dKyYSyOVuKtsdSkdK2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HlweOEdJ0wNWbf1QdkYfp8DtkMjPKZdsKRfkfp/w0FTT6Jll/CWkNAech7vIcZGESjHadggfqjFrmDPRHhg9NfrNRg2cN77GWHJlmAHDFMGUa3c5X6d7d5SRPRwNn1nh0Zc0+m+xXf1df5Y/ZuikshJiy7aTP8C6EcAzbOI9S2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hzZjTTfe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wyy5Jjds; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADKNA8L008341;
	Thu, 13 Nov 2025 22:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tyWOkELCGgyvUSHPkGQPGjka2MfyQASIAOY/kLuMXZ4=; b=
	hzZjTTfeBUaM0Evqn1yxemNW0feVwdG++mqJVXIwfZOGM3VCGSRghD3jDEu++Ypd
	oR0vdHmfoVxkBdEdprYcUsLyWL/l+VDBmGbkfzNmcVqjhlvxnXm6KfJtAw5s/FBK
	q+v4w69XY70z9sRusWGGByrU2uOOPrQUtCdPmAV2NiEVGRGfNHSbHpSMizsh3u78
	nrujoa9ZyHxo8W1mh37NNqrZsYaqJm8XYzoZMRQXB8bQWs/J2BGzhG7mxWuVABAD
	hbWMVpmWMl2hcQ5frbj9rkqNZVKdmsHDlfgWw6ipjZnkb7pd/VCmF4ik+gy0xFU7
	k9GOjgol3N9wrdbqq+LvMQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxpnk1ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 22:30:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADM5THU022204;
	Thu, 13 Nov 2025 22:30:50 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacrpuq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 22:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFp+E+e8uTzXR39aApohdTvuAiO0CZH9tfGiVg1Nr7cJKu1Rj1KQNa/n+uCxVHQA9cNjCjzeknNvUUpa9qeao359a/8DphaSLH6QoKUrE2g1lXfyw49TO+k925PJHfcdIahR/AmF571uwck7Pn1i7eo95abpz5efrGzn5eAO/+cfN1O850uMkqRfQv1r1ZvNHy5Y7nWuvzMXDHW26DPZg/3dNcwsLX4t09+dSVryvSSIZRddpyzwU4O2wsnkhL8JDLRJpVTf1Rbhp3/G+t/kLUvLdxOlOmqnajcuXLlErCuv95GdWJUFdflSuSiFPb4pYyOkiJCaTvy2DqnCCwDRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyWOkELCGgyvUSHPkGQPGjka2MfyQASIAOY/kLuMXZ4=;
 b=AH3SHfEU5K25EaAIF9I/2O1ncqMmu2kYE7k/gHjvcUg9U1xsxukOQJap/26TDlGfq8Ge3ae4y/KeRg9Pl4djdtfhoqYib/rzOTCNSKAJSypXH0DPVaEDTPJuh4SJpiKtbeAYKKYmX1P4esXL8xzNKW1pyVd3+mbD//l5leD7dYAEYV8DKTVQZ3mwHZGdmpm34XtiX+QT543YlLeBFAi7EvcWD5BmKSi1M3NUkKDAOkSkJOajk2AI5f3PoGzz8jn2YgbvVeIEqJaIFMJCkfxVG2H8smusX2IY2sVEm9nK4/B6BzcCEap/WgH2B259ThNCfNq4V6A+Tkw81tBKadzygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyWOkELCGgyvUSHPkGQPGjka2MfyQASIAOY/kLuMXZ4=;
 b=Wyy5Jjds6XIbAl6gW+8CK7vjGHJQWqIbonB6YC6VK15AgLfds6g7HFKMLbqvSoCM6XIngV5qow/jiUxtA6k/1L/1W0axsKtjBAaNvYv8BdCKjqsgeLp3uu1VyB8mkkjrCSbQBb81Afr87SicNOF4aT53yo9VxotnuBEJH35KrVU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7986.namprd10.prod.outlook.com (2603:10b6:610:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 22:30:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 22:30:44 +0000
Message-ID: <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com>
Date: Thu, 13 Nov 2025 17:30:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: "Tyler W. Ross" <TWR@tylerwross.com>,
        "1120598@bugs.debian.org" <1120598@bugs.debian.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRVl8yGqTkyaWxPM@eldamar.lan>
 <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
 <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com>
 <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
 <aRZL8kbmfbssOwKF@eldamar.lan>
 <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com>
 <aRZZoNB5rsC8QUi4@eldamar.lan>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aRZZoNB5rsC8QUi4@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:610:b2::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: e6be0eac-6469-4dd3-d8cc-08de230448b2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|159843002;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TGhOU3hqbHFnTDExK202TWNhQlpqRG90dnZMZmlvd1AxREE4NlZtQzhETk9T?=
 =?utf-8?B?Mms1N3lhZko4c212NXFBc2MyOERFdGpDUGU5ZGVGNk1nTFRzbHZ1RFplYzU0?=
 =?utf-8?B?c2lwVWp4ckJQVGhNeEl3OTVES1VpQ2JJZm1aQmxrOENjYVp4Ly9JcXFMT0tq?=
 =?utf-8?B?NGgwcXhWUFVyT3RrSXE1VmlWVHBFMGpzWHhXRzZjeGJvbUw1SUZJQU9GMjV4?=
 =?utf-8?B?TldZd1ZKQStuQndFL0tlazRTb0YvS3ZLQ09vTkNUd01rTXN0UnRxb3Jsd1Zn?=
 =?utf-8?B?bys4Tk9XRmw1bGRsS3M4NVc5UDFlN1BhY3dWMTUrVENHSjhMVWdpNlVxMFJj?=
 =?utf-8?B?MkJ1azlJU1hXc0Z5RWdUYW9WL0Rob2s4b1l1eTlFRE5SZUJ0SURaMUZDQ09y?=
 =?utf-8?B?dGxNWktrakJtZ1ZCaUZ0aDhjcGRaWXczZ094QTBab3ZjTlJ5NHBCNWdMR2FH?=
 =?utf-8?B?RXp1TW5abDRTMFQ1eXAzS2ZrWDVVYnZVaUUveVlGNk4zTEtYSWZPSDNFeXJk?=
 =?utf-8?B?clYvRk94d05zcWxEaVk3ME5CZlB2WjNTVXJUbTdzbUtkUWdLSHBzM2lJb2ds?=
 =?utf-8?B?cm14NER2SzRxNlc4aGQ1NXdjTlRBaWxMTkMwZDlVaUZhVHFuZ2NST1Rxakdo?=
 =?utf-8?B?bGhGNng1ZDVHOGk0Q3VnLzM3bkZFNkc4WWErNmRLdWVaRWxEaVhnRVYrZDl2?=
 =?utf-8?B?N3pKYUVYVUl2cml1SWlXT0VhVDJWV2p6RnpKdWdZdkJMTmorSWNYWjB3Nk5E?=
 =?utf-8?B?VWlxRGNZR2VDSWlwdUsvaXhsU0cvT0ZoUnlSbzFjekRvbnVIL0RkS0FNeDlS?=
 =?utf-8?B?b2VUNXdIazc1UXYxSEs5MUJ1Tzl0cFFrUDZoak5iUkx3UWJuZVhMd24xMzRN?=
 =?utf-8?B?VzRKZWh4WmdRZWNoRE5vTG8wdXM1M2haRXlNZUNhZ2ZCeXNDbzNmVlVzSlJm?=
 =?utf-8?B?Y0o1M3E5VUppd25jWlo5aVJSclEyUkJKUmszZkxFV21scWZpOUlCclZKTm9W?=
 =?utf-8?B?RCt3VUhMZFBvSHdNM011OFg4ajBXNkJPUXE1Z1dsVlp1YXpEUFk5Z3pKbXZS?=
 =?utf-8?B?R0t1dXdEeWE0N291bVZndDVwbHVyUDF6aExEakRPbkhqSzg0OGdabi93ZHJZ?=
 =?utf-8?B?ck43OTVqRlNsUFhZNVdwanNzYWZWejdreWFVQjNDSC96VmVVT29wRTRYTGQx?=
 =?utf-8?B?T0JwUlQxaXBIVFFPeFBEejRjVXE3MS9LWTI4YkRNMUxKNWVpMTVocHdiTDJ6?=
 =?utf-8?B?UjhuTjhITDRpMHlwYlV1TTlCeE9Wb3c0Y1dGMmlBemZ4VVBENUpGOUwvaG02?=
 =?utf-8?B?RGEweVQzRGhUUHhoQVdLSGRFQk5yOU9HM1g2Nmd5MlF6NVk5c0FZUVAzYmE2?=
 =?utf-8?B?TzFGNkpTM282NWtYTmNJdmFuYUpOMFlYeEZFSUk0N3IrWGdCcDVaMTdLVm52?=
 =?utf-8?B?cVdaVnkrV1lXdE4rejJOVWVsR3BvKzZVR0hIUlNtbHYwWHN1WXFySTMraEhs?=
 =?utf-8?B?RnlsYlV6MXArUjBBblNSYWFTaVNKTi9GaW5YWGtnZzV3bEtlYkRBajhvaU9B?=
 =?utf-8?B?Znk1aXE2SnhtWW9XWHNWOXNrckJQS0t6Ung3QnZMVUtkMzY3V29qTHlPWktY?=
 =?utf-8?B?VW13MDVTRFRnQXlNY00yNjB0YTN1dGdSbWFhVVo2cThMWjBPdHpTL2E5eElQ?=
 =?utf-8?B?eTBZNjRveW95U1JzamtLblYvRnYzcWRMR0EwK01aeitBSUlqc2dER3VXRkJR?=
 =?utf-8?B?UitvNEJRSThpVXBaVGsyZlp3VTE4RlV3cVNmNDBNRmVuZlpWeUZrcGM2MWtW?=
 =?utf-8?B?dzAyNGFmc0dGNXdlNCtaellaUUptYzBuMDZKWnk4OFdIUVFiYlJmN21vWXZz?=
 =?utf-8?B?bGNIdHJHR2pjeGdQcnhUVFFKZjRBcElMa0I5emFnb3R4TkpLV0M5Tm9Rakdp?=
 =?utf-8?B?cC9TNy9hTnBzeW8za1MxTjNSN3RPcTZhNm1zRTh1bHpvN0RQSnNVNW9naGZa?=
 =?utf-8?B?QitiQ2xyOUpxRTc5eW9SZHBBaDIzYWRUUENwYmR2bDhIck5WS3hGSUhjek92?=
 =?utf-8?Q?LWNX3K?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(159843002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TnlyaGxRR0FIbU1RZnpoWEs5WDdSVExSSTlHK2dXMGdoQnRyeTU3V1I2MGd0?=
 =?utf-8?B?UDBvRUh5YUdJbUg1OEp5eTFBYnlTYUFxQUhIYURUb0t0ZU1lUVM4SVUydWUr?=
 =?utf-8?B?SXp5Q21qcUxoeVFlR1JBUkM1Mm5RNDBSaFdXajk2UHFMcU53V0pTUzlsc0lF?=
 =?utf-8?B?bFJrclkyUjBZd0dHRldqVzJKaHZMZHU2Z2JDbkt3SXVuRG1zRmVNMkhEOU5X?=
 =?utf-8?B?VmhtRmVFMzhZWmJwcVpOellQb1NYRXdiYzlsbW9jdGlEQ0FaM3hzMGhLREpt?=
 =?utf-8?B?VWZ2bEtrdDI0ZVRaOFZHY004R3BlWWxwVzJzM2ZnMms2Rzdma3dvN1pLNTQx?=
 =?utf-8?B?V2RXMGExekF2c09QZm9NTGNRSUxvMXRtcjYrZXFGZmtnb1dLeUxTSzVmbHpI?=
 =?utf-8?B?cUhCYlZlb2xaR0JRMmtlNG5vU05ySEpmN2JhYWJjTTdaNHppalBFQ01QRlRS?=
 =?utf-8?B?blE3UXNaWmRFcHZEdndEdEo4OHlUOUw4VmhFYng4MHVneGpqbXlETGtiT2pk?=
 =?utf-8?B?Z0FiM3FKYm80MFRuMHBjSWw1aURnYlF5QlRrQTM2VkRQQkh4QU1IL0VVVVFy?=
 =?utf-8?B?YzlPb0p0OTNoRjNxTDVIc1QvOCtPNXVTSkFTTjhUcjJQME9OYk5MWGw0MFZK?=
 =?utf-8?B?Wmo3andndlVJdTRQY2NRRTNWb3BOZFBHazZ1UndIek9BRFE0NlpDRW1RdGpD?=
 =?utf-8?B?bnJTNUlKdTg1YkFDcHdVYktmdDQvSExXN0JjTGVoMFZzM0FHTDc5ZGpGODlF?=
 =?utf-8?B?ZTVTcVhBeUxkdFVFclA2YUVzOFlrM3VoVEpUUzgyQ29rUU9KekxhWllwZ3pJ?=
 =?utf-8?B?WDdnOEZmVHUxUjJnWjJSd2xJTlRiNStYS0puQUlqTFhQZHd3ZUlkNHNhTXh4?=
 =?utf-8?B?OWdwNXNQaXcwUCsvUnNyZU5TWkh2NE5XVHJUUkVMVGZSV2ovaFNJa1JmOGpL?=
 =?utf-8?B?THNwMlIzY0V4S1gvNGJKR3crL1UvTU5mb0dTQlJVZHFJcDVtamJQK1VoQzE4?=
 =?utf-8?B?ZUl2ZHJBeXlFOUI2MnpVUlRwY2JPQ2VHeXRMbkxGd2VCUXFjRU04cVBseDVq?=
 =?utf-8?B?L2dWYW5WUmQ4dU9POE5maEM5UDRtOXNtVW9DWkVXREQ3OFAyclpZcWt3ZXBT?=
 =?utf-8?B?UUtHZTZUcTJudlY3YUNNbllERm1wUHBPaXAzZis0eWJ4dUpwTFJjOWRCUjhz?=
 =?utf-8?B?cTRoalVRRnh3OGZvMzVyNWpnNVBSd2sySGRMOWRFVXRBZkRGeG8ySzNzZ1pl?=
 =?utf-8?B?eFdNVU9rM01XTkM4UnV0OEdlNkRRQmFCTXkzenVGbmd3VTFVZGdXZzRydzNh?=
 =?utf-8?B?Zjd0RVBjb0xFSkR0RkpVM1pJUWlOU3ZsamlmYkplaGlmSCtDWm16TFRuTEpW?=
 =?utf-8?B?bzNaSUxXNU8rb3hnMEJBZVV0RTJpRVJ0SUkxNGwwNFB2OXZyQzBwUXZKUjZv?=
 =?utf-8?B?RDZpUkRBcTFLb2pZQjVGUEczaVozMHArdmtmVUhmenA3bUJ3UzUra0drYVJH?=
 =?utf-8?B?Mk9pTkgxdjJON2VqZjUrREhualYzbTRpZGRjZ0ZiK1Jlak5NeE9UVmRPWWdr?=
 =?utf-8?B?RDVLZGZ4T0VnSUEzMklYWDljUktvN29reTRXUzlmTm9mUXhpVTh5WVFhMXhh?=
 =?utf-8?B?VjM1MUJkVXlmTWJDemdCZ0dLaS8xdzk0TGE5MnVEUjhsWm5nSGJndW5BcE1r?=
 =?utf-8?B?SUgzREtUQ011Rko0dnA5dDltMDRwNXYvdzF1L3RRb1NxbGhJa2Q0NTRMQ1d3?=
 =?utf-8?B?YlBnc2hucUw1ZkNBYmk4Z0J2L3BpbEFSbG5UMFVKOExZZ1N2SUkxeDhtV3Ur?=
 =?utf-8?B?UmlsSE9QSnBlaG5OSFhZeE9rckxFVFI4dTh0L3VhV0cwN2V2V1dkeXBXdVNx?=
 =?utf-8?B?MVQ4YlFxTEp0TmxsVDBDaEZvc1M5RC9LL24rNSt4TmF3VkFyOVJFWGQ4L2Z3?=
 =?utf-8?B?R3czdmE4V1ZPMmhTY0dhM2JUaVgxRy84N0RyVFpZeXFSMnNGVHEyd3NwOUZZ?=
 =?utf-8?B?WDZuUzlDNFpGMitxVGpQdEJndDlidGpOSUFrdEpRTCtySCtHSk8vT1hNbmlv?=
 =?utf-8?B?aG9xVHhHc3R1NTk0UlFJSUNFVS9qUlBzRnZuSHAvY2Z0OXo0QU5vcVhJYjJ5?=
 =?utf-8?B?VUFaUC9UR2JIUHRWR01JNnlSaDBZSDlwZURvMTNGWjFWbW5wSHZDRThWNUg1?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MHGGHnDm+jgBX3HbTAwlgV2LFXprOwu2hU32s2xiCp2dslsSuEEFc3uSEa14ZQBoUsVRnvXFsJvmvQOSxexYkCRuxX68pN1WMHnqMZ9xBTpj2w5ZmncvTpzatQPQuZDTm0vyR9f1G74X0JufEsSgujW6mQJR3c9R9+zkclWshM9xXe9D3Rea5XhtV9WlCl9xK/YiKYvqSPdoisx1ujZfCHlgEV7neNtd4T30VW9oDUXsmwjQNhTPagOYqxFZoMEoDV5OwV6Ns4N2byBVX19o4VNPnu/0Gh9damNXYZ0FYlt8UwKpUIeG1+Ns9ayxrIRglUu2euEERlt+PkFL4e38PyW8eaa5tDhw5Ev3wWgpby0eTWHwfvxJThvrVkWTZH1n06a6nlR6ph3jwIvyQpcCFIFEDkC1hanXUuwyHsL+qR7tJVeI2/8kPNRGANw01rmp/SYtEZIKKC7OM/hNFDqAf/NfkV5yaBW0JuVUlWa9/i2GrLfEAqVky2Df+LVVR7wSPPz27hFmzB9MiaBn+gF2pRwyIkrnyWgZlLZF0FcDtEDC9tIPkR7cizY6WShe6s2m9KpTJC31o89uVdiIbrNmhD5bTBdZJ0cOTrw4Z/fOOtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6be0eac-6469-4dd3-d8cc-08de230448b2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 22:30:44.0781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSD/r7pug1OhlLp7CMwLBPIWQwDhy+qV49Tiz+Frxk85679zte0Okz/7ybUYca0OvgXkUuNSR1cewWDyo8LTbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130177
X-Authority-Analysis: v=2.4 cv=Criys34D c=1 sm=1 tr=0 ts=69165c1b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xNf9USuDAAAA:8 a=n0MZWyTlJYnJXyoyz8YA:9 a=QEXdDO2ut3YA:10
 a=FjD-8dGO14Yd8gSk4-3N:22
X-Proofpoint-GUID: fWaTHewMkyUjUIn3ebnEcW1NPWpYlddy
X-Proofpoint-ORIG-GUID: fWaTHewMkyUjUIn3ebnEcW1NPWpYlddy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX5p+S3bzheOlc
 zMSrf49/kj+fs4+zbAYPPmAzmO3PFjOGW4B1fNIIY3yGujgplbzN3C5sDfolT65iOP2JzEkMemj
 b4ZpzEBAQ2hFHMhBONmUQN6veB19SZ4hftv3958oHLX3QODd9izmLOyoWxqPe+OZ80z2iuFUIYZ
 /jZ2dYWjCCBtRxltETdIztXiYdkjQ3wK3gIh9JwhfpchKISe1GS2omg2H/GM3kEwP/3wt4jRNaW
 LbgCC8x2rYY59sdhe/jCztK0NvIcGfaNm0OCWOCSV8xD6hOAQ0gg2wblRT5yrZ9BSfVuZc2OzhE
 S2Abqlaw8P3jcKw1tdSGMuz7gknV3B+f4JIht4O7hWAQyHOiihRJX+X1W6PmBirDdbgr94UDQ3l
 cazi5liZ4e0uxyjMYW8w7i27siQG2A==

On 11/13/25 5:20 PM, Salvatore Bonaccorso wrote:
>>> if it is helpful: Debian follows the stable upstream releases (6.12.y
>>> for trixie/Debian 13, right now 6.17.y for Debian unstable) and we try
>>> to keep the patches limited which we apply on top. So far I see none
>>> which touches net/sunrpc/. The patches applied:
>>> https://salsa.debian.org/kernel-team/linux/-/tree/debian/6.17/forky/
>>> debian/patches?ref_type=heads
>>> (in case this could help narrowing down more the issue).
>>>
>>> But we could try here additionally, if Tylor has the possibility to do
>>> so, to try directly the 6.17.7 upstream version without Debian patches
>>> applied.
>> A bisect between broken v6.12.y and working v6.17.7 could identify
>> what is possibly missing from v6.12.y.
> There seems to be a missundestanding? 6.17.7 as present in Debian
> unstable is neither working, at least Tyler said:
> 
>> 2. Freshly installed Debian sid via mini ISO (2025-11-01). Same
>> configuration as 1/above.
> which includes a 6.17.y based kernel (6.17.7-1).

Got it. No, I grew up with Fedora. The Debian distribution names are
somewhat lost on me.

However, if you know there is a working kernel release sometime in the
past, a bisect would be useful. Failing that, go ahead and try a stock
linux-6.17.y kernel. But try building both the Fedora /boot/config and
the Debian one. Could be we hit a Kconfig problem?


-- 
Chuck Lever

