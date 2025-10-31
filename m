Return-Path: <linux-nfs+bounces-15837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D885C251BE
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A11188B6D7
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041191F09A3;
	Fri, 31 Oct 2025 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PeaUEQ5/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UNEl4AzF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9E12DDA1
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915118; cv=fail; b=PMy8VgCvMBTqjseg403IUaEebWRRPZh7MtlOgKUFbyTuqwpmkZJmWJPdlbhK6j/ysD7RFU0xHVG57yzzmiC5p8SY8IvbVLgF/gdTqgQK7FIFdvIYLl/onPOoyauDVXQmsBniEPjwviP0OlQOoSxwjowa7xAoV5TMfSMBbbI5BMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915118; c=relaxed/simple;
	bh=qpDfeWMEK6uf3bTNdDycpD3yb5EpggV0WxI3q8iek6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OnKqQzmX/cupbhgFyr5sHSZlEyxYArp8QCXZL5+nrvCPbT9y/h45kRIEVgViVnPmollGz2Ba2rVKnyr29zDEd0Z3Io6HdZIyTaUp7F3FcADJAtxCzZX/vDVvkCxTzhMNtp+ft4Swh3m3o9wZDrFLn4lGrByIQdQsVz3pKGCp+0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PeaUEQ5/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UNEl4AzF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VCid5q020658;
	Fri, 31 Oct 2025 12:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=U+pIXL+ovAgjQpEeXc5WRYMw7X1zDyorIunNOriKWkY=; b=
	PeaUEQ5/jwrI9G2nPRiEPtF83LSBQW5HYIs2Z1WZeZH0a2we7adT+qVomT9y1prz
	PzVJB8tpMxQ3zV1zyujwHbBTS3gYCz0JJJGJXzNi3w+93OuaeRzjQUF/8wlNrRme
	XaOGCCZ9t5W1vfOeRsEAi8/f6fGRDZJ4AhSVYfUpw6tp3//IZ2QPe1BQXVqpu8qw
	dpGdPCFOKr2thn1K2bOkiO2wpbQF5iySHQ+fWTNy9X+RcZmlbJds/dVB71iCw2Bn
	lj/XdaNFTl5EOwXh0hkNuOhXCwP7xQi8qbi2GQ6ntGZVoYx+a4rF+4j/n1NqRVzI
	PV0Kgu7s6WrvpDSehKb0UQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4wcq00rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 12:51:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VC7WTR027494;
	Fri, 31 Oct 2025 12:51:50 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34qae9b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 12:51:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNtFKU+tAOZH9tKLxw5x4WSgxo+nznPb4dOlyw7h2qF33xTVEJ1d0AuG1vKOvnPcqgo+7KL3qlYNdLNeul46C1YKPAXcJsOGI2iRgI53oNh6bwd66Ka5SjSqkbfr+T0PvmeDlhdbfUAtRpxuiv9ROGPZVor7HT4snOb3kyvu0YBPzCG1mD+CEBX1sDVuA5h4e4yoWvoedPdZjW8aiE0kecN/fFt/CE8RW2KUWSdKAGlVaHg+1cjTEQkuv2KK4B6Xcum9+3KQwg1KdhwxUNCqw2dD2ai3AL+TtLXebiUw1Vd6B+oU6OluHWL7m746pcFuSLTD5v3etsiUb/tbRu4Geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+pIXL+ovAgjQpEeXc5WRYMw7X1zDyorIunNOriKWkY=;
 b=VAM7ywZqD5C69g9r6BMeDBDgFSWWXN5u+VLUKsCprGzSNdIVSgmVg+tllgaqJ7kvR7d2mnMO6O0LQUaJ+DkjhAc2UyfZVT9oXExziEIe6WVRH5BDC1E8EAjygIcVDliAeKZTR1DcDRofq54EZYFFdjzDi2Qw+RJ9Ikcm3Ib0OKqdiHLqwbwlanTp0ToYDZ54LjPlvWyifHFAcow5if/um3xzPeyY9KENvE4IC0UVeHYC2Rp2pWhKr8lCAKr3hmrqDk0uprjEXC7Oh8Srm9J/z/tspMqZgfGS/y91VxF3P6PU8ytUYnNHvACWxozRysdUY0zG1b8MNT7vTtfEfHjchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+pIXL+ovAgjQpEeXc5WRYMw7X1zDyorIunNOriKWkY=;
 b=UNEl4AzF4PDcUTsd5icsPdu6fuB4QWI0QA728Ymymoco3h2vhuzaYuXQaw61b8J8ZI9IS1BRkt9+YkBv0Fcw/xlJBNN2Wwym2lmF/XAiS7xAipA/HRTJ3VWk/fA3XqQpd6YDgnWVwc4d1bb8wWG+g/rpJABF9htNQS3Z11j4Fkk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 12:51:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Fri, 31 Oct 2025
 12:51:47 +0000
Message-ID: <bca68f1b-ca56-4e94-abd0-de4c509d3d00@oracle.com>
Date: Fri, 31 Oct 2025 08:51:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: don't start nfsd if sv_permsocks is empty
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20251030163532.54626-1-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251030163532.54626-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:610:cc::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd5ab7e-859d-49a2-7c72-08de187c4075
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eFBVdWljbWN0RGI1Sk5FZkhTRE05NjRwR1R5bXhLdFBkUHFadU5jZjYyU3My?=
 =?utf-8?B?dlhhdi9UYzhtb21Mb0pRL21NR1ArU3pjcFF1cVFYNlZDcEdwZzVLTm9tOGZt?=
 =?utf-8?B?K3NqTy82ZWp6ZktzeFRWZDJ3VkxoOTUyeG5OZjhQTGptMlRCanJvRi82RHhn?=
 =?utf-8?B?dVNFOW1PMURmQ3RKR25uOHp6YWJJSVZoV1Qzdkc1Rk5jUGl1RlhzN0JmOU13?=
 =?utf-8?B?WXRqUy80YTVranRMYXAzKzl1bWppSWpCVjV4NDZ0L3FqSFg4Y0F2SGc5Y0l4?=
 =?utf-8?B?aERSUk5jNFI4UU0wR0NuamljY0owbVRGMnRlMFc0cVlRRllkd2hRbEtIU1Iy?=
 =?utf-8?B?czRjWmo1bUFtc09IN2hPaGtQRUlzRWdPbzR0UWhhc040RThnVWZFU1Irbk1F?=
 =?utf-8?B?UzJvNFRDbnlTNURiR0JtLzM5ZEtTTG1aZkpFbWxIckx4S3F0QTZlVDkxSEN6?=
 =?utf-8?B?OGN5WkE1dFJhRm1JY3RrT202R05zbGl3NEZwWFhSSjFMV0h4R0c2TjlncENx?=
 =?utf-8?B?MWw0YXJlbTVhWGQzaVFxazRyVFhHZXJzL24zdzg3UFNTaURlM1dnL0JYUFJ2?=
 =?utf-8?B?ODhKRHpvKzZua25aL1VLVTBxbmE1UFdVTlhsclNiL3hLaUY4LytBYWRvRzJB?=
 =?utf-8?B?a2dtckQ0RTlnaWxybjFHcTB2alkyTXNvMldZZE8xMmozOE5LSnhVWTN3QW9p?=
 =?utf-8?B?VVIzb3BFYmZXbFBRUHdCbUJNalhFMU5GdFJCQTJmR3RBZGl3TGczNmE4Ym5a?=
 =?utf-8?B?dit1V0NEQlpZSVdyRE03emd1L0ZQVnduMEpFbHNsTjhLeHRta3RXRkJML3Vo?=
 =?utf-8?B?V2tuOThJOGcwazY1c2RJaUZNTEVpYk8zK2gvM0pBdmZBOVRKQ1ZhWWlKU1gz?=
 =?utf-8?B?U0MveE5pUWVxVzNybldKK0VFSkZFUWpRd2pxREEwbU9kQTVhTlVKZVZWYnc0?=
 =?utf-8?B?aTZGK1ZEZk5qSXdXeDNtYWs4SndxV0Vhd0Z5OVZXVDFuSlNpdDZuaWhkLzhk?=
 =?utf-8?B?UGRVUXNYbDVQNW1neFA1V0ZJR0VQOEFNNVBTWXJrVTIzS2VkcHQrOFdjS2l1?=
 =?utf-8?B?bkxFVFBaYTFOeXdjM2x0MjhWMHZiS2xVdHRxTDk1OFdlS0ppYUdXMkQzQ3BH?=
 =?utf-8?B?ZHhYS29OaWpwOHpLS2VML29WMG9SZ2VJTlN6aXgwaFhmRDkvamtkUnM0ZFRq?=
 =?utf-8?B?eUlwRVYxU01aTHF4WmlsaUQ3UHBoTkdHYi9zVVdHYlZ2OVZPbGxZU3lNdmgv?=
 =?utf-8?B?b2Q4RzJ0NXprMFZjd3g3aGRMdWVEMlFVaTZ2dkEzTGVUWTlPajF4STcxOGl3?=
 =?utf-8?B?RTJaMVI2TDFQcjJqUUFvOXc2RnFad2NKNFk4TlJUUzRDOXFmQkVxbVZhaXN3?=
 =?utf-8?B?WVYwVGhWWnJYZGZLWG5VUUVCZjEzdHNDdlB5NXV0N0Y5ZXVJalJaUnZ6YUlx?=
 =?utf-8?B?TUQ3TG0yNDlnSndyRjFaOGVkamtvY0Z3WEFhN2tkRk5za29OVnExeXo5MkhC?=
 =?utf-8?B?YUYxUllMZHNYOFRsMURVeDluVVBmQVpuS1JCejhBNFRFdXpxeXkrK2ljeVpt?=
 =?utf-8?B?STlUaEJSc1VteDdpUWJOSStrRGZGUzBicGR3a3ZoSHNTQlNqVEtsOUdtYVZt?=
 =?utf-8?B?ckNjSGNTbXJuOWp6TGZ0L2MrTWs2VnNLQkk1aVBjTVZYYXZBNkVWM1JkbmFD?=
 =?utf-8?B?TnBTZlpFYmhUODZJQklienVtYlZkTUZrTFJJakRRd1ZmamtPQVk2ZVRTa1Qw?=
 =?utf-8?B?UiszdVkvaTVmZjZQbW5yNEhLNDNSUFpJVFoyU1hLQkl6N0FkZ0w0cm5JTzdo?=
 =?utf-8?B?bWZIVnR3UG9xUGw2cm1URnlZeUtjcEg4UXN4a1pkT1RFZCtqOUUyYnFqZFcx?=
 =?utf-8?B?Y1g3dmFIVXladEN4NklpanFJdmRBZDB6L1l1alAwNHlBcGc2Y09jd0hUeGJi?=
 =?utf-8?Q?zfHOWE7ggehN2qdKpowHBHKRFelBiX+E?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dzRvL2c3UTRSRFJaOTdQbzRIVWlIRTd2WS9GRjJkZDJYTUVUbzZDRmtKVC9C?=
 =?utf-8?B?Z1A4UjdKVi9pdDN4RVJvZ1AyV2hqQWlNZ1MvUGk0ZzExMlN4SkQwY3VUajlK?=
 =?utf-8?B?MU1RV0xPSW83RXVJdm4vZGUxQ2dvYkozeHlHMVlsVk1XMWt3ckNicVl2Yy9H?=
 =?utf-8?B?VnczeGM0QkxpVTJhOGFPTnJsUGdXelAvS1JwaG14UXo2dklHNTRiMFRrR0ZM?=
 =?utf-8?B?N1p1MjR3ODVQZmx1QjFXcHprNjJPTFVYYis3TzFOeWlJY2hSK3l3T01UU1BM?=
 =?utf-8?B?MjFPSEZkNnRDWUJxT1E0RmJKZ01VS1lKNlpFRjNIcFh6NmttVG5FVGc1cC9N?=
 =?utf-8?B?UEYzNElDZzB0cDc0WWt3empLU2RtNVpFTWdHaktqOFM3c3VWNmQ0NUlBRG10?=
 =?utf-8?B?dkx4ZE5BdmNuRXF1UGZac3pZRCs3V01US0N3dGJHb0dIZWRVYnljN1cyVjFR?=
 =?utf-8?B?VW85UDZHbmxHb1lML0RpYTNqKzI2VjZBWFkzenJncm42aXBjUmZ1UmZuU0xj?=
 =?utf-8?B?Mm96d0pSNHlJYkdRMTdMYzZpNGhLZXFZNUFFSW1TSnVJcTI5Vm80QUJyS2tS?=
 =?utf-8?B?OTJKMkxkOCtsanNVWW9hTW1ON3QyWHphUG0vNHV5dGlab0RJaFFuYk1nU0tT?=
 =?utf-8?B?WVBaYUc2cmFVamxYdEN2cVJvWnNLWnJMOTFpSjE5NzdpRFdoakZQNk4xSUFH?=
 =?utf-8?B?QVpmZUVaSE5SR1NlcU5CczNaUEpsMlo0YkRDQXFvS0VOdnpLdXJCeUVId3VG?=
 =?utf-8?B?UmJJcTBQY1M1WE0vbTI1cFMwdXlpWHZ0alhxeWZXenpYcGx6ZFBiTmhaVUY2?=
 =?utf-8?B?QWhsSU1sV0tWOEN6VFBvTHdKOXNZdi9YanA0cVpaUmpiRlo4R2c2c0s3K0dD?=
 =?utf-8?B?VXQwYkd0V3cvSFRuSHBwY3ZrS3hodCtzVUJMeHc0WDQ1QVpNS1JNWTVDME9I?=
 =?utf-8?B?bkNqTStDRHlyZG40MGRaWW1VY09rRmtUK1kzc3lqMm92eitpRUYzMXFHSXhG?=
 =?utf-8?B?NWlud0VxYlpjVElCN0dsbU1FMGEyUTR3czg0a3FRR3FnTm85M3IxbTI5Njl6?=
 =?utf-8?B?ZkNZWFB0U2ZwUjFlMzZubXMyZEpwVXVoMUp2SlgxV1lhc29GVmlPRjdQODAw?=
 =?utf-8?B?cHAyak1QdWJSYXl0dWVEUlVNaFZtbU1UM2VOaUczZ1VHUjQvU2ROeGRzc1hU?=
 =?utf-8?B?L1VGdDJtTlR4S3FhZmRpbzlqZ2pXZFJZRHJWZDNNZ2VvU2Q3RDFxWUExTGRm?=
 =?utf-8?B?YmlXaHZrdFdnTGlzaUJRVVRPc1RIQ2VneHhxQVQ5N24ybll3RVRrZDdPWVp1?=
 =?utf-8?B?NDBMQTBrRyt6a2dKcENvb3JkOElYQ0l5NzQ1TUtrVkhRUjNRRmFMei9HbDl3?=
 =?utf-8?B?U2VqcmhyYVBqYnZmNFdoL1RQdXg4WHBvOXkydjc2b2p4aVhJSzhTQ09XT3d2?=
 =?utf-8?B?WG81K3lsVC8xbWx2RTMvbkNra0M1Q0x2cHBna0dBYThLNENXWHZ2K29CQkJq?=
 =?utf-8?B?U2RzcXlmUk15VUlaSUxKb0kxN0hWNDRSM3gwQ1VaMjMxa0kwQ0c5Mkt5VHk5?=
 =?utf-8?B?NDl2VzlwdDV6Qlh5aEJPVWtpeWxRNWc2amZSanpyQmdWMWhUeVh0V2p3VXQv?=
 =?utf-8?B?aWZ4T2ovQ2VQWHYxUWx3WHlFOVdXZTZFR3c3QmU0SC9pTHhUbUNmeXcvTXhE?=
 =?utf-8?B?RDhiZC91ZjhZUVZqU2FtQjlFY2N4d3dCMllxdGFuS0tvc3ZuM201ZFpNYjJn?=
 =?utf-8?B?ak1wNEVwZCtuNVE0dFpQVVhsZ3dYenJ0bnJ5TUJsVDBnMWlNb3FhYmFHa3Ez?=
 =?utf-8?B?dFdjNjE2UEkxRWZjWlpjTHRQWjhPdnhpVG8rbVhHVGFab1pPcytqbjQzcU54?=
 =?utf-8?B?TGZsWWdyTGNQWUxEYllMVU9XMGRZVXAwNHl6U25UV3g3S291UWM1cWhmRnZ1?=
 =?utf-8?B?bldpYTRiYk5zQ0g0UTVpbUJLaUVQQkp0eVcrZnk4SkRQdkY3WXViU3huYnhY?=
 =?utf-8?B?ZWdrdUpFK1hSK0xNZjVnVEtqL3ZMbGQ4cE02NndNRy9IS3hZRHZsY2tNVkhj?=
 =?utf-8?B?Y2dIS1h2LzcxeFIrVzV4eEJoVkFmMmlDeEdXalY4L2pqTnJFUkF3SHpQaURp?=
 =?utf-8?Q?8oHmv4r9SsdShb8mQyxgs8xMQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EGGx0vS1ELnKljjkbYkM8ziUpwVWoCC+QMV/zzK0w8gfyVu661cIooaxn5kHflwxzY74bymaeQjfj0G5kr2Rt5aLXaIchXaFQsd67VLb6aRiqyH0bGx5fZ6rvrqfveYM8I0fP/c/wtb/YyHulhBXGbhyyAGW8usmFXL0PLYhTu6EcJlh/cN67/MjQRWZUc1GFgtQ3dXXrPeDntrk7V2RwrcoEQA4AnbOWTR9Yen4P0Jr0SIs8uN7t0xPd05gz7C0hgY0tZ4RtIP3kcta0RH/LZB060pPQhba64r8aYMIvG6wKO7FZZPv12YtBOJi86tqA1rgORJPmBhRMvGcSyW/7iKtl9H8SjHS6PJh6AbnMrGA1cl54Q7H69XAffzo/FAVjRoWf2A32D/yW0LXpvkhzVO+OYGR5MTZ6xxQ61cDm+sJoR9WKfoPl6NUBUOQU4Jg1q2yjoZXC4b8LmYuRZk7c9Z1zcuh5iPVaQ5EywUZh6WH7J+apyDLEKY/rNm507kUXpzi3+qA0wqHe27S5scsgxXudA/kzhUcy8qPmbG6icysg/npwpg9nHOPvXihe7O9Teh2STmi61khUoYoLYeziTzF1FuaF1qqJippt3xDm4o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd5ab7e-859d-49a2-7c72-08de187c4075
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 12:51:47.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oE4JqmBGHY1WjmG5mMx1H07vvvKrXKr7iTwnFdEauSABA0ZXRsKocS0HZMUrmG91stNaX5W/Bg+Hg3IFMMrFog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510310115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExNSBTYWx0ZWRfX3Jgbz1BUZTvW
 gvxpKOmQLMtJqbneUkm3jri400b+7HsWg29p5PZTRqFrS5LoWL4DVAqekkUcJCHhpxmdMbsZL5d
 qvIh/u7+oW64PB7QQpxomgnn+LSA11CvXVTVoUOT3j3JrhJlfgrbHL+QIqovT75XbFqu4t+4wpZ
 VZNojAM8YoxHSsQU4k3HMYWgLYrwS4SitEF9P7E7k2d55QimGfirfEegZRwDye1TZNAZ5QfzRG4
 Z7sKAnkhcSyayx1Jcd3JDggbZbPs4svkGwvXl6VMi27vl8VssIm8l6ZEZf6IbmvXJVcyunHh3Eo
 PwLjmYVseWPlAL1sYIAhy31pAgvhDSOAwSYITa+jGj0TWDBs/6LzjacQrRY7+5kT3s/Xp7NTWUJ
 vli6CyilQmjBuMyk04nfspj6QKWYjotDOtUnlxmKD8B0a8XXCTU=
X-Authority-Analysis: v=2.4 cv=L50QguT8 c=1 sm=1 tr=0 ts=6904b0e7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VcSpV1Y8wSS7Lp3cxBwA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124
X-Proofpoint-ORIG-GUID: R72BU16R4rVu2ptW-LnggtLyLFPaSVf2
X-Proofpoint-GUID: R72BU16R4rVu2ptW-LnggtLyLFPaSVf2

On 10/30/25 12:35 PM, Olga Kornievskaia wrote:
> Previously, while trying to create a server instance, if no
> listening sockets were present then default parameter udp
> and tcp listeners were created. It's unclear what purpose
> was of starting these listeners were and how this could have
> been triggered by the userland setup. This patch proposed
> to ensure the reverse that we never end in a situation where
> no listener sockets are created and we are trying to create
> nfsd threads.
> 
> The problem it solves is: when nfs.conf only has tcp=n (and
> nothing else for the choice of transports), nfsdctl would
> still start the server and create udp and tcp listeners.
> 

Fixes: ?

One more below.


> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfssvc.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 7057ddd7a0a8..40592b61b04b 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -249,27 +249,6 @@ int nfsd_nrthreads(struct net *net)
>  	return rv;
>  }
>  
> -static int nfsd_init_socks(struct net *net, const struct cred *cred)
> -{
> -	int error;
> -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> -
> -	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
> -		return 0;
> -
> -	error = svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
> -				SVC_SOCK_DEFAULTS, cred);
> -	if (error < 0)
> -		return error;
> -
> -	error = svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
> -				SVC_SOCK_DEFAULTS, cred);
> -	if (error < 0)
> -		return error;
> -
> -	return 0;
> -}
> -
>  static int nfsd_users = 0;
>  
>  static int nfsd_startup_generic(void)
> @@ -377,9 +356,12 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
>  	ret = nfsd_startup_generic();
>  	if (ret)
>  		return ret;
> -	ret = nfsd_init_socks(net, cred);
> -	if (ret)
> +
> +	if (list_empty(&nn->nfsd_serv->sv_permsocks)) {
> +		pr_warn("NFSD: not starting because no listening sockets found\n");

I know the code refers to sockets, but the term doesn't refer to RDMA
listeners at all, and this warning seems applicable to both socket-based
and RDMA transports. How about:

NFSD: No available listeners


> +		ret = -EIO;
>  		goto out_socks;
> +	}
>  
>  	if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
>  		ret = lockd_up(net, cred);


-- 
Chuck Lever

