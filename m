Return-Path: <linux-nfs+bounces-11874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91EEAC2535
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 16:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4D4543DCE
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E429117D;
	Fri, 23 May 2025 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ANuRI2fY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n5CwWuFo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444C128819
	for <linux-nfs@vger.kernel.org>; Fri, 23 May 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011266; cv=fail; b=URNTQAu3UndD2WK2hBTKSuPgq4G/j5dt6j3PyDb7yVg+8LQ9XaLnTUi7SkXVqPH1U79/MmgTCgg4HVrflkLkooo5aSrLcAmXbwZ60ceTpukEYMrA+dOTvfjIqHBnElW27Rotz3K56+UXyLWlE0DJFaukc2hiyXUTLf3s0BIqANk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011266; c=relaxed/simple;
	bh=w6IHdO46Q20vVhVBrs9QMB2Dnyn64/HZwrl7g4LiHM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z69F1rScigpJ4mwW0aJjbkH3xXrFq2yKcPgcmlPwPiUgSN8yBO4Eh7dI7KM8E9Q84jpNm9tsG4AXeHvVdH0crTPWsiEHHrlz2nOyuYf9H/CMkGL1wCk8oIoKTrb1S4d/jYB2mvNnDkDL8AViXXtZx8CvEbIVm5Y1ap7V/TomLhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ANuRI2fY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n5CwWuFo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NEbFru029769;
	Fri, 23 May 2025 14:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e9jxkAiuOuQbLI12o3W4uDPti2aKjIxmSaHqM1AEXE0=; b=
	ANuRI2fY/BbbtxtOwKTfxnB9TijG8HT4P0Tk8mf/CO+DO6LNRxR77XZ+veklfDgq
	d03e9rCF02b31vhfOr9ac2JKmscA7ElcUfSbXmH6e3vazEqBqlXQQnlL2Eeiltxn
	8h8SCKCh98583LNfMT8SEBFLofeIou713je4gODaYVuI8BF935nROgncNDt1ng8O
	ZvuIixU/Qu1+IbkWrp12xo/We9m5/p6EYu5CPkdRZnSpsfG75RiVKxz/PQv+551L
	FwPygAs21XjQya+QvfwtTkJhvMcdx1jM+CZJ5/jBZq6JC3mDYdI0GZ19TCN1Lbv4
	zmAZ5752NZBn/bskjmTdPA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ttqqg0r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 14:40:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54NCusGF020204;
	Fri, 23 May 2025 14:40:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwewj7c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 14:40:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSjA6kHf3A5bdYLt6lyKPrNE5DMPGax8m0oezDCHaaJFvFgg85tXbX0wJwlomkityjS6728nB/X69fGbcfW0bmtB6DGcOBNT4EAjfAqwzPRBSwolY/XOi4JK6v9AuYmdwjm7Frc2WY/KYwJL2GLwHqi8TI4ipUAFvc42HubkqXeetuqp5JBEfBPf0MPGDhoUzcGPkf/Bj9GOSWUTMUoPAQ7rYq8C+Pl8uGCf+yT8zB/38EKLmI6kKOapjoUaG792gwCFlriwqHex54mtqR/4YjHpqfI0ZYdb6bTqgW1dFoDiSkcoFq40g62DJyB63gabqaOzOTOEQZe7fdWxXtndxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9jxkAiuOuQbLI12o3W4uDPti2aKjIxmSaHqM1AEXE0=;
 b=ZdiOFPSI0TlbOI2UlSIRjqAzIsXxIuEmlB74MZfZWTyrkqwPqWf7lGW4YgRaV0w2LRY44RUchz/Au1MLlABNlVUd+JfAOe2VGQcS3KThDfiRpvkpCEBdajm/+2T5iM7oPSWjM4MzqSeDYSS1yWJNsNmV2rlsR+5HP0Bx64eIjal2Y/xqnYQFjXVU3tYd72xfdECyeNrEyDmgcExNqXX5bKc4J87f8zFDPp/6GN9BXO8n9CFUQ62i4RF8e11qIy6xahePeceHmX3A3+Kcs0Qg+KQTMxNXxB8OomeGEYMpfY6gGUpwl85fca+wuob1DMBB46Ks1I/8sB6rL6LMd0DhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9jxkAiuOuQbLI12o3W4uDPti2aKjIxmSaHqM1AEXE0=;
 b=n5CwWuFowGF8ptqYnwDAxnpH08M9L8YlXqq+bmT9cpRATHhNB0ORut158FOcBrd4w8KuIrZ7bRwan1Tvc5a5lfPoRiQdcvh2uJvdiBQVxH8Rhp5KMdYE2NucGnY3g9Oy94HF8ynZCoWIjz2h1Kg8/4zS9plqeiy6C/q6GSChX9Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.34; Fri, 23 May
 2025 14:40:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.031; Fri, 23 May 2025
 14:40:56 +0000
Message-ID: <2529724b-ad96-4b02-9d8e-647ef21eab03@oracle.com>
Date: Fri, 23 May 2025 10:40:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Questions Regarding Delegation Claim Behavior
To: Petro Pavlov <petro.pavlov@vastdata.com>
Cc: Roi Azarzar <roi.azarzar@vastdata.com>, linux-nfs@vger.kernel.org
References: <CAN5pLa6EU6nKe=qt+QijK1OMyt8JjHBC2VCk=NMMSA4SJmS4rg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN5pLa6EU6nKe=qt+QijK1OMyt8JjHBC2VCk=NMMSA4SJmS4rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:610:32::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: c96aa510-8322-48be-863a-08dd9a07d387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkM2UjNLdTN4QVY0VitQNnJ3QnNEYmgxSFRFVEpyMXhyL3RVUFk1RG84Nmwx?=
 =?utf-8?B?ZUZ5a0RvTlpOeURRQTgzZldLSU9MK1pFT1dqT0NubWlLRTh0dVhIUlREQ1h2?=
 =?utf-8?B?NVpoYlNGMEVqQVMvNlo4eFMrcDJrZnFiajJjRHpnTnB6TG5WMWVyUTlGTnFa?=
 =?utf-8?B?aDFOK0pYMThodDBSUFFFdXVYTlNKd3ptajRwZkxkSGZmeDZxeVg5OExkVkJ6?=
 =?utf-8?B?MXlCNTBUczhLSXlXWGQrNnM3UDR0WnBsNEVRcC84OVd3WC9aY0VYRTV1UDdl?=
 =?utf-8?B?NmRXZWdCTlc5VU4wSUlZZnpKY2p0elQvSUpIK3ZpZG1sZ0dZQVVaR1MySFZV?=
 =?utf-8?B?WkRNN2xXMXlaOFhrN2lYczd5Nk92dkFpR2QzbWRudFJmWEFFbFplb3UwOWpz?=
 =?utf-8?B?TXFYb1IzcXF1dkZpRzRWNzRKK3o5RnhQVzJ6SWFoT3VTcWlmZDk0aVdZbVZW?=
 =?utf-8?B?M1JmWlFtOG0vTEFleDdab2Z1aitWbktBVVBIKzVpdUpHbVU4ZlNyZTd5eTRq?=
 =?utf-8?B?OTFwZG9KTXBBNndkUFZIc1hiRnRyWCtvUUtBQU82aEswVDlYSkFJSHBkbTFN?=
 =?utf-8?B?dHM1Nnp4TExaaXhTUGptSUVPRHZXR2ZLQko1djBkZ04rUGZKdUxnWnRIdFh3?=
 =?utf-8?B?ejBHdDVqQWNPS1dBM0pMdm1sWG81NE80VnNsa2xMQjdFT2lLcmIySEQrTEdk?=
 =?utf-8?B?SmltNEJ6OFV1SDR3NEdnb1V3MjdXRmRLd3ZtdnVCV0RyZTIxeGpCS0kwT0lp?=
 =?utf-8?B?UW9XT05WK1I4S0dwb1IzOEI2TXNjMlF3c2lQSkpzVityaHRWaUlVMWs5UWFz?=
 =?utf-8?B?WHJDZjNVWWV3UEdPOVgrSVEveWEvRXNvYitjOTJzbm5DZkxFZDN4VEo0QXMz?=
 =?utf-8?B?YjZmb3Rib3ZWTzZ3VElncUIyalJMWGR4L1labWIyTmIyRTEwUFMzaVJxREVK?=
 =?utf-8?B?TXdZY3c2YmRJTzVBMWI1M2xtcjhiUHViNFdwcjNiOEo3aHFkTWxSNkdoU05s?=
 =?utf-8?B?ZlJpZDB3WVpkMklqSzhaYlptS3FnR3gyeEZuUlQ5bXJub2k2UEtUYTQwdUJ6?=
 =?utf-8?B?aXhjRXFlcUFZQ0FZRmFsS0RETWpTdFR3bGJLdnloTGtmVzhpTWVEaGhINndp?=
 =?utf-8?B?VHpmTWZ4UHlhTG45UTB0VTNyTFBnUG85YjNFWnM0ZDNmSUNIenM2alFNamJ4?=
 =?utf-8?B?OVVMN2dWbGR2UmExQWNJb0RpQnJqSTRHUm1JaUFRNG9WbDNGRnJpaUdub1Vm?=
 =?utf-8?B?RzYxMUhxNzlGUzVQdU12Z3BwREZhcnZtWDBUUEczL0pVN1FlRlNWS2czTy9X?=
 =?utf-8?B?TG1YOTZTMm1ZRjRHUm02NnlXdU9JZEc3VEdBdFlGd0pqemt6dzlNVG52bndq?=
 =?utf-8?B?QlBIaVRjVldhakY1VE0wVDJPQUY2OG5EaHBENlJJaS8zWjZLMkxSS0Z5eWdv?=
 =?utf-8?B?eFNjUm9zbkp0VXo1QmJabkZFZTVLNGp0MVppZ0w1OUZ4Smo3V21GSjRmSjlW?=
 =?utf-8?B?c3EzMHU5UHM5R0pXOFo0NGdVa0ZuUjRTMXN1RE12bFNFRkxhVW9yV282RCtt?=
 =?utf-8?B?ZkJ0MXRsMWNBVC9SS2tTeXFBS1VCd2h6RWNXeEV1ek1WT3NORU0yTVlKSEhI?=
 =?utf-8?B?TndPR05SQ2hUYVdDU3pxU0tGSUgyZHNjNHhTQ2RlcDRiTytzR001d01vcWQ5?=
 =?utf-8?B?eDVmaGJpWG1pMlJ3UldkRlJjZkpGc04vSkNwL3hnVjJGOW8rSWhia0pueXMx?=
 =?utf-8?B?NzIwYlJ2MlhSWlZjMFFxUWNuMzZSS1E1N2lyTml5R3FOdTVtWm9FWlFFV0wz?=
 =?utf-8?B?V00weXpjY3V3S1IvN2JqZ05pc1FnSHJSR0NEK3o1MnZ0aTFPU3NLZnh2Z1o2?=
 =?utf-8?B?ZE4vUndJUENqUHNVeHpaWjJqZU5OVW5STjlOeE1VM1FYU1hkdjV5QlhwWFgv?=
 =?utf-8?Q?2pQFf/bRXaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWlNT0tIZmhZM3hROEpTWUR1WWtyZjdFLzkrMmVPK0V4VjU5bTlZS1lQb2RZ?=
 =?utf-8?B?Y0I4MmVjajJEZGcrQmxjNTRadUVrWlkxMEdjZ0E2WWtmUklqSWg3NlVHQ2dB?=
 =?utf-8?B?UTQvWUhtWWNoTFhRRWxJWlMzYTRDWVZTTmMrR2dkekI3N3htaEhnM2MxZXR1?=
 =?utf-8?B?bTUwMGlRS0R2RFVIODN4QS9PRFFOMUZ6aWpnWGR4S1JJY3d2YkFlZlVQdnpo?=
 =?utf-8?B?WVNPMzFlbFN3TjkwRUl5RG9RQU9ocVpWK013R1NrZFU4aGtKUHM0aFFTcUt2?=
 =?utf-8?B?Rnc3V0J4bG85YzlCSEVUdXRCYlpSUUxvWWRRUFVUS2NYei9uYnhVbVBiK00x?=
 =?utf-8?B?V3FRTG52YktRbjVFb2JIVlByejFDekVNY0h6bWtTbWpZeWJxT0V1UXRHVjZa?=
 =?utf-8?B?SHJTRU5pSDFXRG1hMlBWK3loTlNNZ0xtV1JhUWJ5UU5ZUnhIRmFSU2JiNXdY?=
 =?utf-8?B?WkliTU5OdVJLUkEyVXRZTi93VWp0Wksyc3lnS1g0MjRRSHM1VXJic3A4NXFW?=
 =?utf-8?B?UEFsOUNIMVM2RDgvNU5zbGs0alZaQzJLQjVSTHZ5WHl2Q0RHdVI2emZnYjNW?=
 =?utf-8?B?OU1uTWVPL3pYaWgvbXRJQm1oRGtmNnNSc3dQaGMwa3FWUjVmbzBFU3d0NW94?=
 =?utf-8?B?YXEyRkt2UDRpNSt5Mjl1M2ZWeEs5d0l6eG5JQTk5cGs1WlZkVVlCZFBQeGJ0?=
 =?utf-8?B?aWRHcnAxRnBOSDBJQWNlVURoU202MUdJd3pISFhMbzg2UExraHlTanl5R1RH?=
 =?utf-8?B?ME03bEhFTE9FcVorSG5CdWRlTUxaczRyc2l3L2VjT2lCdmovYVZSV0laWGdP?=
 =?utf-8?B?SWZiM2l1dGZMdXV4NWZiVEdUWTNBNHRBYW5wQnBWM3dldlA2YnYwUm5iYnAy?=
 =?utf-8?B?RXRMb0FSTEZHRSs5TUo1NWNjYTc3ZHVWNmtwc3U0RTdEdnhoWG1MUGpDMjhQ?=
 =?utf-8?B?WDduNGRrVnhybzZsR0wrVzVMSUxMN0VCY1hWVlFQZG90UWZGNHBhRHA5aG5o?=
 =?utf-8?B?ZG1hOTlDT0k0ZVJ4L2Q1b0FVMjZHL1BiejYyekJLVjdJaDhrcFA3ZzJWeDFp?=
 =?utf-8?B?YkVPcGdDL0ZnTHhYMWZqM0dYcTV5QzNGaGNOeDJMZGlGeFdJWDkycmhFZlJG?=
 =?utf-8?B?ckxRM2c2bWtZa2l4VEw3OU51RWpwWmxXb0ZoWktlRWdGRjR3ZUZYVExXT3NU?=
 =?utf-8?B?Q05vZVlqcW5xUk1QUHlNU2NwUnlhdTIzTUd6NHhqdmlXWWVsc21uUDB0YmlW?=
 =?utf-8?B?VkJHUmFBN1lidWViZTB4WVJ3N21pUzRTSVNSQXBrMkZwanAyT0QrU2R5dFE4?=
 =?utf-8?B?ZmVRTnJwMTJYNk50YzRmMjZ4Q1ZmY3NTWVArSENYbTZxVHhnUXFxRExnSHBB?=
 =?utf-8?B?RGU5cjN3UDNtekN6UnRZOGVNWWV3N3Y1S1JsQ01ZV3piNnpud0tiUnhLRjds?=
 =?utf-8?B?Q2hOanFFdk1paWp6VVFwZ0NpQ2RmYVhCT3o5VXR0VVhSVlB3RHBZUzhieUhU?=
 =?utf-8?B?QlZ3eHJxc2VwbGd0dTlsVGpRSEFoZ05zRWZuRzRuSFhHMklrZ3NBai96Y2VO?=
 =?utf-8?B?R3VuVTBlNkNaSDUxVzdxazBwZ2tROUZEaUg4ODJvQytGSDRQdUZkRDBWUDQ2?=
 =?utf-8?B?REtXYnhLa3c4UDN4WkZQbXJwWkxmbXBBL0xDbi9FQzY0Ynp3YSs4R1I4SWQ3?=
 =?utf-8?B?NGdUV09ocDZwTHhVWUlLODd2eW55K1JDQ2JhVFdGbmZrWmRzQ0ZyYXZTSlVh?=
 =?utf-8?B?cUkrUEU5UHdJSEpHaVB0MVRTQVRCTUxpdDU4bU0wU0NzSEk4cWJlbzk0K3ND?=
 =?utf-8?B?Ti96cWVWUkJXb3dpR0J1SmZabEVvZVZYR1czc284QWhmZjEyN2MrcGxIVCtt?=
 =?utf-8?B?akxnL1ozTGU2NXdnc2llb2VOWE82OW0vMmt6ZS9XU245VnRTWlM3ZG9ZRzJM?=
 =?utf-8?B?TEtLa2tTOUUydmw0a0lwam1lbUdiU3RiUklURVZFak5aYzNaWXpGY09QOWNL?=
 =?utf-8?B?STZiNkkvK2RFS1Z6Umh3bHlFam83L3hzQXZ4NDdkUjhONm43SGZNRldPdnJ1?=
 =?utf-8?B?cVhERzB6MWt5SU4xZWQ0RzFQVXR0bjlUQStrVWYyM0NIMW1Db3AwM2ZGRXFk?=
 =?utf-8?Q?c6wnYVgVgifpOqW5TeEwF33n3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o6WIzvSpe4TdTnllIgjVMkgQXHs0XIUmR2yA1ApKZtiUB91lLqbWAL8V8ZdVRUlQDFzWNhx46Hj8WwlZx+YyvnGU+pqH7ljug2Rno1gyqWAuRwKjvPCf8HHzXg7SOYKbmDXlW7HSdyO8WrIsA/B5ud0bZDMNhXBmhhupFZMmQUXW2n+eqg5Oo4mgruSzbBHz2CUHJ0HhyVLYd8Lg/WvzjFXR43ogtcJWQ5HZX1HRND6izKK6r+msQsIqwTz2G/XoRyS6jRWpZwQiG2rWGnQnSXT4AZwhT4v554tzv5hG2BI2a69DmlaEBG5M/2Ud8KPICje5Yc3sDfQ1viZCxiTSi3ol3hZAzCZb1ltWby4+RTo2u18TR0+uaMrfOPPmGahQMAn90kmkzIS0vajsbJGv33JTq4Z1ZzHwA6Qn8MdnvOc4B6OEBhFvMSFhLNBLVF/ihBHI5iWS7eQ9ua7bUbwph9xEyfNKSsrIaFlibf1O+pu+Z5WgU6vacxfl7Q4eyieBH7sW3wRgkEfl29KIWW0cIZdfAHPzuN25UsIycB6EfVN/brWMrOm4r0L4B3PYQAHc4lDHZGLrvjeFvJtHIB3MT70BKMGUBl8NfLn11CsEqmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96aa510-8322-48be-863a-08dd9a07d387
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 14:40:56.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEZdxLm2lfVMtXJI0O71GSWfoBTu1j6uax02hsy6YVvyBNpqIQjF2NzN2moPkRK3avaiuVTzZao9/YqHlqKjtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEzMiBTYWx0ZWRfX4IjSeOjBlsuR MLZadz/zVnJDmzkt7DYmxM1K5HoduD5LIM5qWWFvEzfMu7eHzkWf4Ew5SfuTYD1SHzp4S5rOH7G pCgWWYxrPdBRShwSsXLY1fH22NepMCZvxHNsIED9v81jkgY8BEIt2vkb8H+mZEOiGPfqZP0tRiW
 hIy/wMCCswKmLCvo33C48M8EquqtOFAjEJ9GJlI95RXHIziXlwLlXe24G9XtElLu1rtbETZbd2J BmxOOU7lyLtopJqfss2BHE/dm8ZuGk3ZrjiLGq5C5TcXGnyYrLg+VC7sQ8zhThUgW7el81PP6ES 6XMrMyv2MYL5P/GWsFnbPmXISR0ip2sO6/Lfhake5aab3gPxXQ1i6Z+t+7XJws5Ia3/BZxbTC+D
 mg2PsRRSieV0INigxfWDrRG8R9CV1ZSbbQpmjX1eZcdTXkif6wAnawaFl2vm8gtMxIoQIBvD
X-Proofpoint-GUID: W11dFC1L-bbeutSvoorNySMV8v6x8ny5
X-Authority-Analysis: v=2.4 cv=Za4dNtVA c=1 sm=1 tr=0 ts=683088fb b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=N_suNi08A_6SkTCns0oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: W11dFC1L-bbeutSvoorNySMV8v6x8ny5

On 5/22/25 11:51 AM, Petro Pavlov wrote:
> Hello,
> 
> My name is Petro Pavlov, I'm a developer at VAST.
> 
> I have a few questions about the delegation claim behavior observed in
> the Linux kernel version 3.10.0-1160.118.1.el7.x86_64.
> 
> I’ve written the following test case:
> 
>  1. Client1 opens *file1* with a write delegation; the server grants
>     both the open and delegation (*delegation1*).

Since you mention a write delegation, I'll assume you are using Linux
as an NFS client, and the server is not Linux, since that kernel version
does not implement server-side write delegation.


>  2. Client1 closes the open but does not return the delegation.
>  3. Client2 opens *file2* and also receives a write delegation
>     (*delegation2*).
>  4. Client1 then issues an open request with CLAIM_DELEGATE_CUR,
>     providing the filename from step 3 *(file2*), but using the
>     delegation stateid from step 1 (*delegation1*).

Would that be a client bug?


>  5. The server begins a recall of *delegation2*, treating the request in
>     step 4 as a normal open rather than returning a BAD_STATEID error.

That seems OK to me. The server has correctly noticed that the
client is opening file2, and delegation2 is associated with a
previous open of file2.

A better place to seek an authoritative answer might be RFC 8881.

The server returns BAD_STATEID if the stateid doesn't pass various
checks as outlined in Section 8.2. I don't see any text requiring the
server to report BAD_STATEID if delegate_stateid does not match the
component4 on a DELEGATE_CUR OPEN -- in fact, Table 19 says that
DELEGATE_CUR considers only the current file handle (the parent
directory) and the component4 argument.


> My understanding is that the server should have verified whether the
> delegation stateid provided actually belongs to the file being opened.
> Since it does not, I expected the server to return a BAD_STATEID error
> instead of proceeding with a standard open.
> 
> From additional tests, it seems the server only checks whether the
> delegation stateid is valid (i.e., whether it was ever granted), but
> does not verify that it is associated with the correct file or client.
> Please see the attached PCAP for reference.
> 
> Questions:
> 
> Is this behavior considered a bug?
> 
> Are there any known plans to address or fix this issue in future kernel
> versions?

AFAICT at the moment, NOTABUG


-- 
Chuck Lever

