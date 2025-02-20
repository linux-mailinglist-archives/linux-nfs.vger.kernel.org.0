Return-Path: <linux-nfs+bounces-10227-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA09A3E4DA
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 20:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709533BEA51
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468D18DB24;
	Thu, 20 Feb 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Au3v1G/F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jNc5jk+W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF31F892D
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078917; cv=fail; b=fxvag7rRVUJ7A7LNOcVg8uCjcxIW/M6oFhfSZKdCN8lp4n5L/p6nVuprSkpKDb+VvaPxE/1PAiRNcZ9iWBFchb/gOev5mwvPtNnhAOiCjoqvUVReqOb4+JGf6oHTz513YmgbBjkp7iR5WcsECisENokKA4zaMotkeqNS1//FMZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078917; c=relaxed/simple;
	bh=ohmLTsx5VCFsCU7glq4RgBm5tSHYOWfsclee8FFkKMA=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b9chJ1xf9OPZ34FolpLYX2Ht9iPyQQvvgykKFN3cr0ICwB8tZQvZIUAVKHFwNpfza6cqIRhVloW4fo2ogkSORWgRy4Zwh4EXvKuc+z9Qb6E9ha97O042actzJeMH0rvYRQbrL3onbfZS1BCq+B/HPb3oaL4XLIkD32drtW4IPQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Au3v1G/F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jNc5jk+W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMqH1007578;
	Thu, 20 Feb 2025 19:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UctUPyNBVvdRVo5ah4aPZgaA+ZgpNlNgM442qLkHjNg=; b=
	Au3v1G/FDzKvbGWIZSY6mMrTGXf6Yb6F/F90AWMmUue4sjfOUtNptrvJr90uOtSw
	2odavixWi5WHtROEqhAwK4JB2pV1/TMKkQ+eZF4XuOsLa5h8Itue47nM5YnthdUX
	GfO2zGF1/fkTFoqpaLz088bYDvyNr/rIHpfgOHO6lhvsPEN0sblniMWdjB7trXUX
	sZLXO/wgcs/SgC91v2wNqT9l8MxZy/tJtsAbGXcy4OO0lMhcpWWWVJCTIJ/dFlef
	Gqir2bjcbpFdXTcxXhbAqEpyAGa18ZO9LZ8fkgv8DPBo+nX5GHZkL/ae+chy+dX+
	2l+51vXUTHBc/PgK84KmQw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n4v5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 19:15:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KIrEmf009808;
	Thu, 20 Feb 2025 19:15:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09ec5ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 19:15:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ercQ5hipCgPG+INAUy7V23CG6fQsCBoor3A8G+QVqIOVmq/Z1jUAv/p30VdYk0NVruFKIvlyfC6IdPVXs+iOZwAxWMZa16wiaLA8hrcpkguzr8nL6MXSxsFbGwCOFcbUOxC5M63Ozkk9H9Q7S2UrBzIEHoK7CAWHWV0AFn/PX0FqkW2cbJSnDatj9NYQyvds3baN0ZiPNmM7+Brv43JVR+CKX1QUDye7yGGXb6SsoCfBeU9f4G+TFx5Mnzr8OisfwG1JkrrpEgE0Siyi3LNB10vgjCY2NnFaKnOSLyBpJ4lK3AnwxQlkEvcQXzEl4RyvlUtViG9peH4PyYdEdL9p5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UctUPyNBVvdRVo5ah4aPZgaA+ZgpNlNgM442qLkHjNg=;
 b=pI1kSzyFkeRFXFYGQN+b7p501OR9cfVtZf9KxPJ1F/+crKRP8QTRsHvEOwzYZuNCPyPdtptmuaEH5rbS/AugSu80xyrXHgbjnKq7XRlwkuVljsXyY4ACtS2v2SkKaXBRTU9VwIEDe4iNAyG1MsLy3NeO5AN3b+5ikpE1KgUwpB5tUb6IGcKYz2tHfLVcmiY344KUZRz0/204j88G9BnsNnIfbCa2GkEsbEOEw9ZbcHC16MJ9kEaAqnV0g7lnrERgYjWd8+KKNtouN4Va1W+zR2sC7bE6eOnHNjxE4QLtqCrfX0ZtLaCvnd/xL9KhMyvTS3Q6oapUDP3UN4L4hcn6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UctUPyNBVvdRVo5ah4aPZgaA+ZgpNlNgM442qLkHjNg=;
 b=jNc5jk+WbtXKVhLilk1DLBweo9a9OMfzzUc/5CGIy6ZxoK3FJeGRHbw8jcb/XnRgvTntCSv/jHHFiOzBkGaLppKoEQpPlOIA2XKVGJ2WSgyWaWBPsxiK6Raq11Wo3qV2QOAWjlaMEJgD+H/vtn1pgxI6Z9SLyHEgy3LUuoYVPeA=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CY8PR10MB7316.namprd10.prod.outlook.com (2603:10b6:930:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 19:15:07 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 19:15:07 +0000
Message-ID: <aa2a411a-1358-481f-b593-a3b288c45aae@oracle.com>
Date: Thu, 20 Feb 2025 14:15:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: add the ability to enable use of RWF_DONTCACHE for
 all nfsd IO
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>
References: <20250220171205.12092-1-snitzer@kernel.org>
 <0282e805b6cbd583acb9071862335aecd97e48bf.camel@kernel.org>
Content-Language: en-US
Cc: linux-nfs@vger.kernel.org
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0282e805b6cbd583acb9071862335aecd97e48bf.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:610:b1::18) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CY8PR10MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: baea157d-eacf-408f-e02d-08dd51e2e304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGlhMzRMMU5ZK1EyTjdEMk84RkhEZ2wwYVNGSkY0dzVhYS9DaWZtalEvOFVD?=
 =?utf-8?B?bXFxd29EZGgvcEhDQkt0Yk9YbVhsMTJycmxHYTRxdnV0SDZpYkJpTmR2MTlM?=
 =?utf-8?B?NkU0bEhQVDEzNHdLL3R4cVpTY1p6VzRKcEw4SWVIRnZRMXdndjhHUnVHM0JR?=
 =?utf-8?B?aDJsT3JLa1EyNmJneTRxM2M3TXIrcVAyaCtGQkQzTTljV08veE1XZnNNOUdS?=
 =?utf-8?B?cEVrbC85SHE4RDJod1dnWVlxTzJERWVCSVdNUGtHT2hMdUFXU2xzNUtCL1hX?=
 =?utf-8?B?Z1FnaGJOVnVSVGIzT2hsZkhxajI0Ykdkb0RrTVhta1VqdVZvSGF5Nzd3SUVw?=
 =?utf-8?B?Y2g3U2dQay80N0lpZGxnd3lOOEhGTkNhS1BaSDREaDNrSjF1K3czRzkxY3B3?=
 =?utf-8?B?RUVNVWRkdFZaWEZDNkJPKytrdVpQb3pKRkYzcTcrN2VxaWNXZ0FHczVxWlJM?=
 =?utf-8?B?QnFNRnhVdEhOTVRmY2N5NnBQSGVTMjNPYXpEUDJmYkI2dTI2Y1VkOEJvY0NR?=
 =?utf-8?B?VEF0c2lRVzVWdlh5YXlSeXQ1YitNWWlOUWNJdm9rOU5QT3gzbFpHdFNSc0Nm?=
 =?utf-8?B?UjRJNDNDK0ZkVElRT3hwQjJMV05HOGEzOG9sMHFOMzl4ZGNIeFY4cHljOEZn?=
 =?utf-8?B?UzhJbG1uMEwxRFZxWmV1NXJPRTgyMktab0JSQVpFcEU0YnpYWVJINzV3OWdy?=
 =?utf-8?B?cmlXTmwwSW5UL2VLY29vU0g1VUFFZ2xFYzVNS1l6SnYzVVFvdjI5eFozNURw?=
 =?utf-8?B?MmdtUDhHdkNLS2dnbVYvdXVYSU4vdS9MRS9uekVtNU5wTlBLVHpnZmlVRHB5?=
 =?utf-8?B?WXdoUkpHN1ZqekprOUFVMklnTFlWb0RKWVV0V1dEVG15VDBSYXl5Ui9lUU1U?=
 =?utf-8?B?WnVQdFdPZGU4QUtpYWY2dHZQZHFIN2FndWFUL3NXUElGemhDL0tGTXcxU0Zj?=
 =?utf-8?B?ZTdBVFZuemdoMUp6ZHBGWE52VkVXSlpORWUrMnoyN1FZaGhzcWR1dVE0UTl3?=
 =?utf-8?B?MDBVYVB2b3ZYWi9iNThmdUVId08rN0J3TnR1RC9OY0Y4YWtPR1ZlUkdYcyto?=
 =?utf-8?B?YUpOcHU5ekNiRDJadTJWTHhYSzdHQVVGYjV1VmFlS1IyK05GSVFseEpjZEpO?=
 =?utf-8?B?YkFVTnN2SDlOd25sdGFtWDQvbFZSRC8vdW03czdNa1hxemxNY2NzamltSlRv?=
 =?utf-8?B?ZHV6RUVCQXJFUCszbXF2N2w5amlqRk9aSUl5a1BlWjRKTzV1MjZyTzE4cmFh?=
 =?utf-8?B?ZlhVdktocDJNMFZQb2Z4YU8wS3NuM3Vub0RFR1loK1Jvc0hmcTNzYmhWdnRm?=
 =?utf-8?B?OGhRdVpubWE4Zmh5L1ZGWjZpcWdOb3h5dGNlUitOMjdXd1NNcVNYQUVXTDlK?=
 =?utf-8?B?S3J5d1MxS3czWktmRm1TMTgySEdpOXBsSGRhMlFNVGROU05mOEJud0R4WE1Z?=
 =?utf-8?B?ejBxQVdndHZHa1FaZjM5bUllQkV3aG9GZEFhMzZ5NU9qckFWWjAvNnY2cmxz?=
 =?utf-8?B?YnpuamRURG50UUY5dGF2MitSWEVHbXZVaTIyaUtvNnJSSVZMek1WRUJlc3pi?=
 =?utf-8?B?UW96VDRibllKQW5rQzd4RUthSkNOZWVCUFFreVVTM2R3Q0M3bWN1OGFHeTk1?=
 =?utf-8?B?TzZqTjVJSjdocUFFK1VvWVllbXlnVlU5UzlkbzA3ekMvbkFCaFlIbE1sZTF6?=
 =?utf-8?B?R2V5SitsWVo4TFdxMFpTTkVGUHZyelU4OTYxNk5HZFBYZlRoQnJzUk13dm1I?=
 =?utf-8?B?MURVVllCRmx5RXdNQ2hoQ2VUMXNEcWVHd0JFcS8wcHNHZEV2NEpHVm01RFAz?=
 =?utf-8?B?aEdrc3psMU1zWXhQWXJYdjVVSWVxWjY2ZHdDR01YSis5dkdxRWd1cWtlRmFu?=
 =?utf-8?Q?k9jGgOxeaM0RS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmEwN0FiY1JEdVFpdGVwS2JVT0ZIQkRsWDZ0ZWt3elRQdzhQTVZMZDNmVzhB?=
 =?utf-8?B?Z3VCQ29LNWovNW12Szg3VjN2czdCSHJYbUh0bGVuaUZ4SkRUOEVPbHhPREEw?=
 =?utf-8?B?Skd0Vk9aSE1JQzhLdFV1UlVNaWwyWHAwNFk1V2I5Ny9MMkJ6V3pQVmFHWTN5?=
 =?utf-8?B?b1V6RHlXa2dHOEI0YkFzNDVrU1hVM0R0WjVzZnB6VTkzOTlpa0IyTWZxaHp2?=
 =?utf-8?B?aHZNdURKaHRGUm54Y3Z5QjJmb0RYdWtDR3lXMEluc0o2bEtKbXltWDlwWWpt?=
 =?utf-8?B?eFdrTkRLdzYrR0lOY1Q1OEE3OEdRL2Q5VHhXK2JTRGlvNGJEUmhaMkcrYk5L?=
 =?utf-8?B?TlZqYnkxS2RES3k2dUlReVFDZVBqTUN1TElDYWFRdUo2SUkrM0dKL1phT0hz?=
 =?utf-8?B?ZG9DN2tPTHEzdVJDeWE4YkpFMUR2elNSQ1UyYmMrSmlzS0tBS29iZVB4WTVV?=
 =?utf-8?B?Ylo1YkZPSUwyUlMwUVhPRGptYXA3NVIvZGphNWpXSktId3c3eHB0WVZhQ05k?=
 =?utf-8?B?Y3lIRjNjZXNnYXpoUEpvUE9PTnhndnlaTmRKT3dMbEoyUG80YStDK0ZkY0Yr?=
 =?utf-8?B?VkZNNGkvVjlYWFA5VE1GWkE5Q3Jib1hSTkF1TUFONjhpcm92RzE3REdkaS94?=
 =?utf-8?B?T2p3QTlTQU9CcG96NnJtQm9sbldjdS9nazNLUXQrRDNJMDZ6aVh6RTVoaytT?=
 =?utf-8?B?eU94bkg2WVNVOUpVOG9uTFp6STRIalZqMmJtcy9yQmpMTysxVHRKUjVoVElJ?=
 =?utf-8?B?TmpWRVJWaE5KdGxrVEd2WjRkVTJUdHBjb2JETTlLNmlSRzF3TTZhWWd2T1Jz?=
 =?utf-8?B?OW9qcm8zWk4yZlJtS3l0ekZOWUJvQWRaSFZibDhObFpDbG11VmlhQ3k5aE5m?=
 =?utf-8?B?SmpER1p0QmRuaDkrZXRkdWxENFFZSzlqaUkzdnBIdmFuRDFiUkdVNlhWbWFO?=
 =?utf-8?B?QytVRW5EN3dxWXcyeWlnd2UzVXFCMUZVMmVvQmhmckkrTURHSVhpVFc0K2hT?=
 =?utf-8?B?NW5RZnp6ZU9VMVFCTDhxWFhGcUFBVG9RZW1TMkx1dTFibDRqQmJQczlLOHRH?=
 =?utf-8?B?bVBnZ0FRYXJWNHF1VzlQOHlQbktxR0hDTmg5SUR0S0kxM2l0STljYXlISkZM?=
 =?utf-8?B?NFZZOGFKcXFtdEcwUXNPcC9tbG9KT1ZCYnNhVHV3Z25TK3ZrdzRXQ3RMYWxW?=
 =?utf-8?B?NkFTRy9hVG9sV3VqT1ZvbktRRkdqYUVmd0ZSUWRISGRUYWI3cnFRSEtNa3lR?=
 =?utf-8?B?L0J3V1ZPRkNjWDNYYWR6ZnFMYVBUcmhJbUZ2c05QQ3hPVFJBZFpMVHBCNzlU?=
 =?utf-8?B?cERML1JxVVcwWUNVdEZ0cHlGTHlqWFpzWVpEVEYxUCttS3RBNzRXTWdQZWxn?=
 =?utf-8?B?aG1kNTJlVUZQNnJjZlVxNnJOZi9QVXJFMjFGWkZOT2NEc2FqY3ovWHlPdzBp?=
 =?utf-8?B?WGhUTm5KRktBb2wzVjNEL09GaHlkbm83dkRiQ1ZEZlEvL0JDZ2oxMEkwVDBR?=
 =?utf-8?B?ZkFXT2NkeSsvNHNmMDBaNm9wUHM5cmpNWEd2Z2kvb0JRcnUyNFV4QlZPREZE?=
 =?utf-8?B?a2RObXFOU3NvTjJSTkFjQjdKckJvT0Qwbk5pQkJqSGZDdi9jYUhYYVVpYmFo?=
 =?utf-8?B?c0lpQzJxaGowNUtsZWRacEhCSE1VV29CdkUyK0tSdmpYUWxPZWVRTlVrNVhW?=
 =?utf-8?B?QlFKZU0yTlUvU1RFMjhrVlFkNWZsMUFFZnpKRG1xN2doY2lHMXYxY0FFN1ZD?=
 =?utf-8?B?S1I1RTl6VW9qZXdxdGpLM2U4bG93am55M0gwL3ZYeUJKK0MvS0VNUnJIUjJH?=
 =?utf-8?B?Rk9PejdnN0VUMkIyOGxVVnRRQXp4ZEh1MGFMTTNDVVVXQTFDUzFFL3lXUWlO?=
 =?utf-8?B?eitRUHNVaSsxRFdBNDVydCtqb2hZa0hiZHNrL3ZDWVVyaXBHOVphM3BEYi8r?=
 =?utf-8?B?OVJrTTU4TDFkOTZqNVYrdDFIbDNTeit2TUdyL0FSUXNmTnZFcDl2dTE2WEx0?=
 =?utf-8?B?V0VoS2ljNzVLQndDRGMwbmFnOVQyREFXUWJXS0x1MC82TUZKWk5KWk1DVjJ0?=
 =?utf-8?B?UGU4ajRCMWZFYVo3WUVyaEVhRmE4RkpMbnVOelltUGdYT3JsT0kzUER3b2Vp?=
 =?utf-8?B?OU5ac3dzeVRFZWtVcEVUbHVtbmVPSW8yWVI0b25OdTdhOFEwMXRjaHRZN1c1?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4qkJQW/izpi/cDnL1mgMeHFh2Va+xKZc2NFVRQOXbj+bWDvpjNJb4ovrw8syZ0nCwhnEjz593LvAB7Pf/ilCDPDOpDHSTZRRUh5zpcSYBihAAuYQDP+sZSTN+B9rxbwjmtCBQzbzG0qL7mFFVBc1pGPf+MGtfixESWHKhJyu2YhdBijJND4KsCuRLAX+IVM2Nqv62d1WsfrK7aZ2CqnsyHJv3xYKzXfIpR4mnxD36A8vBUKvMURl79Y0fU6X5EmSDum9JYIqVGfWyonue2sOdhDc4JPM3Nzmc4VdPWnwXjghLURLnn7+A6Wi69LDWQGTzi/KvEzA0cuRKStMmrV8xPmn/+Z40fPbQ9FJnO/h2HgW3TAlWT84dWXQopjw/wvgeY8jDpFsSsPHsCe8CfMD/AY5CGFqAlg5WUPA5yFeW782G4Lv+3wyaCCnonUJ2yNV5C/GioCEWVADkA7KDMXOJT6jku6tP7aHLmpXWCsyuU16DozJrXXQbgYrIdL84DshDP8PnGQ1gswtdrHRsAhWQuHnr6KaD8QZaTr6Jzu4jlDa2aa2Ryo09Zi/bjajMFmR8NTDm6grdY8t/p1pKSH4CvGZG1cRYHEWAojc1VRufx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baea157d-eacf-408f-e02d-08dd51e2e304
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 19:15:07.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXESOgrm9asIGXYfuR+xznwIjvAZuGuMK9nWQJF3HIbHeKIg9fLhd0NKOnUF62c4CTmKFeNQH3tOpw0cfHZPRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200131
X-Proofpoint-ORIG-GUID: 1_H0erVcQukFIqKNGbFmf0Bv5SDnHutJ
X-Proofpoint-GUID: 1_H0erVcQukFIqKNGbFmf0Bv5SDnHutJ

On 2/20/25 2:00 PM, Jeff Layton wrote:
> On Thu, 2025-02-20 at 12:12 -0500, Mike Snitzer wrote:
>> Add nfsd 'nfsd_dontcache' modparam so that "Any data read or written
>> by nfsd will be removed from the page cache upon completion."
>>
>> nfsd_dontcache is disabled by default.  It may be enabled with:
>>   echo Y > /sys/module/nfsd/parameters/nfsd_dontcache
>>
>> FOP_DONTCACHE must be advertised as supported by the underlying
>> filesystem (e.g. XFS), otherwise if/when 'nfsd_dontcache' is enabled
>> all IO will fail with -EOPNOTSUPP.
>>
> 
> A little more explanation here would be good. What problem is this
> solving? In general we don't go for tunables like this unless there is
> just no alternative.
> 
> What might help me understand this is to add some documentation that
> explains when an admin would want to enable this.

Agreed: I might know why this is interesting, since Mike and I discussed
it during bake-a-thon. But other reviewers don't, so it would be helpful
to provide a little more context in the patch description.


>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>> ---
>>  fs/nfsd/vfs.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 29cb7b812d71..d7e49004e93d 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -955,6 +955,11 @@ nfsd_open_verified(struct svc_fh *fhp, int may_flags, struct file **filp)
>>  	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
>>  }
>>  
>> +static bool nfsd_dontcache __read_mostly = false;
>> +module_param(nfsd_dontcache, bool, 0644);
>> +MODULE_PARM_DESC(nfsd_dontcache,
>> +		 "Any data read or written by nfsd will be removed from the page cache upon completion.");
>> +
>>  /*
>>   * Grab and keep cached pages associated with a file in the svc_rqst
>>   * so that they can be passed to the network sendmsg routines
>> @@ -1084,6 +1089,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  	loff_t ppos = offset;
>>  	struct page *page;
>>  	ssize_t host_err;
>> +	rwf_t flags = 0;
>>  
>>  	v = 0;
>>  	total = *count;
>> @@ -1097,9 +1103,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  	}
>>  	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
>>  
>> +	if (nfsd_dontcache)
>> +		flags |= RWF_DONTCACHE;
>> +
>>  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
>>  	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
>> -	host_err = vfs_iter_read(file, &iter, &ppos, 0);
>> +	host_err = vfs_iter_read(file, &iter, &ppos, flags);
>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>>  }
>>  
>> @@ -1186,6 +1195,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>>  	if (stable && !fhp->fh_use_wgather)
>>  		flags |= RWF_SYNC;
>>  
>> +	if (nfsd_dontcache)
>> +		flags |= RWF_DONTCACHE;
>> +
>>  	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
>>  	since = READ_ONCE(file->f_wb_err);
>>  	if (verf)
>> @@ -1237,6 +1249,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>>   */
>>  bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
>>  {
>> +	if (nfsd_dontcache) /* force the use of vfs_iter_read for reads */
>> +		return false;
>> +
>>  	switch (svc_auth_flavor(rqstp)) {
>>  	case RPC_AUTH_GSS_KRB5I:
>>  	case RPC_AUTH_GSS_KRB5P:
> 


-- 
Chuck Lever

