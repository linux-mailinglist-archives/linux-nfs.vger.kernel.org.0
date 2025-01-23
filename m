Return-Path: <linux-nfs+bounces-9543-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1DEA1AA66
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7927E7A4627
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAB156F2B;
	Thu, 23 Jan 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WtjoY8jR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WMSs9q0m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624A7156228
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660992; cv=fail; b=kJGt8O1CQIFsJm3cEylfmkl+1+pj0v5aeRZ8LqKhWdFEDv9DlG61Q+POozHiGua9iK3M1rlVDMel1co1mP+n6u6U6d1ZWFewYqt/LUMaGTnZdlB72AJ9G/iwAbOGPOKxo9+BSOKW/FOW5rpAivRAKJaO70NZW/D79c26GkCxAJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660992; c=relaxed/simple;
	bh=IVsqKGVCkrNuqHP+k10lBxAsWAk8xNC2wszBI7LaOas=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T//ISsfheoHRj7hZXjhhE4EPVjGutaEhhmfza6t/jej1zNxy6H3Kf+gdl7ko102oGPcTPlIin3OQGbFWii7PFomxydZ4MEe6TEfge2aLjtVwBRSvnLMh6Oxazh2Bly96kATuOTD57E0R3nO0W4T+AjuREw3wcZ14lEcKUT+WExk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WtjoY8jR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WMSs9q0m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaMmR030496;
	Thu, 23 Jan 2025 19:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mCpYYHnDPrD08O4uPt9tPIZa8Q0RMUKvh/0mWzrCGvk=; b=
	WtjoY8jRDEAtcAmQtYLiRdrKQX/KaXaqbFaPFrkTHbRoRb/uKLh4oOHhOeKiAEX3
	Q22k8DVF63mcmTlt2xi8yXA5SXxqCC4cmEbWlBPBZcyl/FU7IfakF8MyvrcDIWL6
	dP3LghTqhmtDE5EdpCgcB3ZUBTCij/22bmMOyw9L+mzfYUrXg9SER8dkb9QzcH5x
	zs9hBmQuv4tvDaLM08T584XgO/bimswaCtwBavoPgiFwSP3bO1O9KgVLT1JNLs0z
	G1+PlyMlLb3hWRsY9jKFy03VXk7HTRPQ7JB72KOfyKy5+XDtW5FVjv61z6iYZobr
	qLJHvKfW54na8bczd5Y6MQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b96ahxf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 19:36:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NI0IM9019473;
	Thu, 23 Jan 2025 19:36:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c5e5qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 19:36:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+ics+lwx96fU1MPjKaumNZX1deAIXrJOmXgHR2Kb69lrqNmNakNgOqF3tNKTLJZ6oXt0ntnC6bcbWtPN4CH3fPeNUwIUrTnazTgZYMaCsjSenOZtAnawkGpFYsoak//+Zv1gyk/wokQR0FSN0irRHfNRt3ueajTHmiCCx1R+2PNRo0720ioPvJ7aJcuC7EK7TVoWOSWoZ3m10hYQqiKMIWn/99zz8wTrFrZ4YXrpwSNtzCTLnCRQuEYHWPXG4O93r7YNuWBdku8TFZ1CDNLa3B1GAYaYcrpX+vJqL3si6UM3TZF9l77+bsSSD4gGMT1ENa8qQVny9+Vc7viEs3HRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCpYYHnDPrD08O4uPt9tPIZa8Q0RMUKvh/0mWzrCGvk=;
 b=goD2FeZ15jWQqVmOUY5xbAE4B4HOJSF8cF9EJJL3Zl21AX5cZtVGNBZ6JOFYL0DPyLv6akiPGirTjI/IZr4mimdO4LMROiFAPrimYFUO+5lkvY/QBmPoRjUByre6+wwOmpHyXtnTQINrZd01dY+u4BCWnL8QamBQdX6+JCVrK9nNVs0FKbQQleh24ZFew/56EKTq2Z8aX3fMW7w2yntbGpOGoYAMf8qRNXSJ2ZDH5reDT9nQ78tRpIlRJhK6qjMZstDVlix4TPYNJ/jWHpvL3wvQ4oMSXTy+MoTT+0sa2NP6W0jd0ItnN8eOKJrblW4LBiUY21l67zVEYdBnMiPjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCpYYHnDPrD08O4uPt9tPIZa8Q0RMUKvh/0mWzrCGvk=;
 b=WMSs9q0m7dL+WJH1uN1UC6Wjyd814klgo52UD2WcjMoikYhT4IpKi/fSUlkG4fK8bzwaS6902a/qAs0zZbvlQg3oj4y08FtKtS6vH8jf3I+Kg1Y1Pcj7O3vgBarzvam0JyS0xLSDtgQ9G/hK7Q84g2VSGaWIWJqwxJ3dKNBxHqU=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CH4PR10MB8172.namprd10.prod.outlook.com (2603:10b6:610:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 19:36:22 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 19:36:22 +0000
Message-ID: <020c8945-51e3-4783-b852-c89bc7917b67@oracle.com>
Date: Thu, 23 Jan 2025 19:36:19 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs] Move to xdrlib3
To: Jeff Layton <jlayton@kernel.org>
References: <20250122-master-v1-1-3c6c66a66fe5@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20250122-master-v1-1-3c6c66a66fe5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0696.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::10) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CH4PR10MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 67142e4a-99aa-49fb-f770-08dd3be5376e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHZiWWk5ckhnQ1JRaUo2a29WZkdKdmVPSVUyZU5FL3N6Z3pGU08vSzFjZjlR?=
 =?utf-8?B?ZFgyVjlJMFVrQnVSZEduRjBidnV4clpWVzN0Q2Z6bDBDai8vM3IySkVCL3Q5?=
 =?utf-8?B?elVHcDZ0ZllmZXBVQm1IaXBmaDlubmxWbHgwT1JTS1BZVFdpRmdTVkxVc2xN?=
 =?utf-8?B?L21oeFBFR1JiSitBNDVBbFNXNTl0bFcycUk4OXlKV0NJUzY5d1kxQ1JKak1V?=
 =?utf-8?B?WmdQN2VuSFl2MzMvZ1p1d2plQUdmaithUWlIUkFRWlRSMVk1RTVsUmJ5NTZY?=
 =?utf-8?B?K0FUdllWRHVWaVZYYk9KalVSNG9VR2lkQWR3U05kV2VmUkRQS21BOStkaWdp?=
 =?utf-8?B?MldZUnJJSmk3a0NTTWxXLzYxU2tOTDZxOFdYanczQzBHV0p2ckhnRXlqOEpa?=
 =?utf-8?B?T2k2dlEwc0dDWEFaSTJiNnZrNXBlUGU3QlFvS0FJOHdaTlZCQ3FnOGpLYXB6?=
 =?utf-8?B?eXI4cUxEMVVXSmh0YXh2cG9HWC9wRExtcWhlQ0p0ZFlQeEM5Z29UVUx1b0xH?=
 =?utf-8?B?cUF4Ky9MWHlPcVQyeDJVTHMzekFDVUFqeE1sSTdkRmNDTGYxNEpiVFJSd2RB?=
 =?utf-8?B?cG1DZjk4dmxwT0hJNXhQNGk0WUlkc2ZYdGV4dXVvVmNxMVNwVTg5WVIrVlN6?=
 =?utf-8?B?dUI1S2RiTDA1eW1mdExaYWk0UTVXRWc1UDFERWg0dW9JeUFhQUc2bStUd1Mv?=
 =?utf-8?B?SUx3UFZzUGIvMHA5Q1R2aU5OV0NMUHJ5cnp3WjdyK2FxZ0RTRVAyQ1Fwek1F?=
 =?utf-8?B?WjBEaUxKdG1xejVIWlo1ZnhZMXRvN2lET3NXMFNZcERHWWV6K0YvTkhPWkFa?=
 =?utf-8?B?VW1sY3BZeE5jZlkxM0ZTdSsxRlU4aGhiYWg2a0VyT0syNmJ3WkZBQ0dhU3hw?=
 =?utf-8?B?VjJOMTY2dWdQMTVhUVMyWXM4K092eHVDbDRQejF4Ykl3VlN0YmV5M0xhaWl4?=
 =?utf-8?B?MmVWQzJmcUlVcm52R0didGo1NzVOTXhLdElBOXl2SnN2OWgrMzRaMGdCbDJn?=
 =?utf-8?B?YloyYlFqY0twZzZqaUI4Q2ZmbHFpR0EyZEtNdVRCOVdLRmRjblllZnd5RUsy?=
 =?utf-8?B?U3M0ZXpZaDNCQlVxVHB2bHVieDlwTkRKalFPa09NNFhlbE1wTnYyUjZSb0l4?=
 =?utf-8?B?ZndMcCtCUEx5K0o2NGZFMWYrVHBNSEw3eDBHWUNQdWZ1M2dWek4vMGFxZW9D?=
 =?utf-8?B?a2crZ01HSW45YnlpeDBQVkUwbmxLRkpTOFl2NDhnelZoVjRCeWJCaURzWXp2?=
 =?utf-8?B?dkZpdjJqejRwQm9mSkRhUXBucWtqaDlrbUIzRno4LzdMZXh2S0UveXRNMWpT?=
 =?utf-8?B?cTZuMFEveFNKbjFMaFVxVnFFR3BnRjZQN29pZUlGYVBBQWdZb3pnakRVMFd0?=
 =?utf-8?B?OVJ5QTZiUElMZmlOUWlGMjY1QUFkRDRZZTNuVXFLcm5KcHRZWWY5eVZFcE9R?=
 =?utf-8?B?aDZOeEdtaUk1ODRlYVhEZTZFZmxRdWFaczBjeGhQM3RpZVpjYU9nTzc1Q2Vs?=
 =?utf-8?B?K25MS3FhREFGaWJ6ZjRmVnNXOW9Ec1pvMGhyNzR5Z2ZyTHJpN3ZmYW4wdjNx?=
 =?utf-8?B?TmJsNHM3L0E2aDdlemc5MFk5eGlKNEJVS25OMk1kTURqNmg4ckRaaXQzMVpr?=
 =?utf-8?B?ZWlOdzVaSXZXT1FCb0VPbjNmSVJiVFZTYnpHd0ExVnFKQ1NtRWdKRVB5YnpT?=
 =?utf-8?B?MWtjUWJCa3RJSlAzQ3FWZmdjMUpwYUVlKzJVaHlOa1daNGRvWWFNN1NvSFdi?=
 =?utf-8?B?ckNxQm1UdHhYNTJ1K3crd20rR1p0eVFIM0JsTHo3T0lWMTd5OUpvdGdIeFlx?=
 =?utf-8?B?Z251Qkc3N0k2RHI3ZE5zZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3pSRjgvUUtGR1RRdGNValYwQkVISXdvOEs2bHROK0J6cXVLN3grdWZQbUJv?=
 =?utf-8?B?UkJ2Q1pVcWRwOVloOXFZS1kvSmI3QVRjUVFNT2EzZTFpQnIwb2FsMDRqZVlN?=
 =?utf-8?B?UzgxdnM5THltV3FzRU91bHV3RTVUSlJuS1Y2YWk3YkFJOHFCY05aWDJFMVNV?=
 =?utf-8?B?UkR5bGlyWWsvMjdIOFJHSmxXbVVmaHFKWHRONWU3RFovOG42R01xUWMvdUFQ?=
 =?utf-8?B?ZHI3TzZOUWx4SE9lMjA2NFg5OThiTGpIRUlrOFRqdjZiUXE4MEl3aFVtUHFH?=
 =?utf-8?B?Q0hQaVBlUC9ZZ05TSkx2Y2x3cVg5UzUxUHhHenhQS0lJUnk1SkhLbktTYy94?=
 =?utf-8?B?Z1N0RllKT1JJMmZUVWxxaDBCRlFlaGZDcFFLL2ViVkZMMEtuNG1vOVlULzd5?=
 =?utf-8?B?NUJRRHk1SExPVHN0dDNHamdQNzVlK1YwbFc5YlRvaG90Z3hFS09VbXkzZTIz?=
 =?utf-8?B?RHMrS1JBdmxXL2ZsSWw2cVFKckNSZkhBMXl2K2NWWUpHa3BmdHZHUnRaS3F5?=
 =?utf-8?B?VU1Od05MREhBV21uci82MGhPbFU5Ujd0d0NLakEvVnV3NVd1RTg0cTlJQitu?=
 =?utf-8?B?NmJIWmJZaXZSaW1vTmZtNnJna0RvYzY1Tmo2anoyUHZxeUdPR3FPeDJHc1FJ?=
 =?utf-8?B?d2dHMFF5Skc3eXpYb1VSZWFUblFSMDdlY0xIS3lMYmVSNmliL3RzSmtyYVg2?=
 =?utf-8?B?K0VkcUlvbVNYZTQ3Q2NMMENrcXk0aHo1a1NqV0NmZ2hhRHZxM0JmZlYwMTFS?=
 =?utf-8?B?eFVrbGZjcVAzN0hMZ0Q4WTlzSHR0TnU1czhES3lQU1pWd09IamhyRHgwQUM0?=
 =?utf-8?B?a1V3aVdVWmZUYjVHZDhrcnhZOFZYT2pIQ2ZNaVhKOG1WUmxlMk44SVMxZkFZ?=
 =?utf-8?B?Mm5LcHBCZXBnczZkUGhVZzk4dVB5bmRXSkJSanNNTE9CTnIxQVFnZHN2RTYx?=
 =?utf-8?B?RG1nZk9obkhOZUlIQlI5UmFXSTgwcFVlN3FzZVBuZVorcThNeWh2T0dNR2Zw?=
 =?utf-8?B?RDU4MVprMEFKdHpiT1pKQmpKN1ZVejYwck1EZzFBS0FEZzlvVjY3N0cwOTVP?=
 =?utf-8?B?VUNEdW4rWEJ3ekprVmU5ZHhBNTc4ZlFpb2ZHUjJMNSttS0hSR0hRenBTRzZS?=
 =?utf-8?B?U1YwL3NPV0JjNGpNRWlYOVFFZDFDOEFnZjhyWTM4cFlsbVZnOGMwcHVvcjBN?=
 =?utf-8?B?Y0IzSFluVEg2QVkxaWVkK3oxNURQSmJvUHJxcmJPNWp0RDdYZmtVd3lINnFj?=
 =?utf-8?B?YW9vNEk2WFp3YmFPTXRWRFMwK2Z2R3ZXbmV2NGxkSmNwYVhSamFCYVJENndJ?=
 =?utf-8?B?a21pWWFRZVg0N1JUMU0waEZpSVhsSHdMQkxibnFQNmhqTEJyTDhVeDZacklD?=
 =?utf-8?B?aE00MGtLSW5ibkRUY3dCblIvWDhpRVhhei9ZUFE1cjBQYlhTOGQzTmtDS3Nq?=
 =?utf-8?B?UHhPQ0xqZ2M1R1laTncxU09WaXRCSW9uWEVtcjRPUGIvVVUxMndDOTl3eUcr?=
 =?utf-8?B?VXIwVzU1TURZWitRMTV3U3NoV2VnZjM5YmhKVmlubzJDQ3pKTnRxYTIwWFNZ?=
 =?utf-8?B?ZG1rUFNhdFVoU1Rrb1hUaVhBRWRJUWJ2L3E3c0hlbWxTVlY5czc0RWVnQkJZ?=
 =?utf-8?B?dHQ0VzMzY01FMEk0KzFwNjNVUVlTRkUyU2ZndEFsMVdXK21WSmozNkRPQWRm?=
 =?utf-8?B?TGxCb3NUY0lkM1A4YU1zWXc1dFVYdWt3Q01QQjFsbkJLL2JtcWN6Tlc3T1pk?=
 =?utf-8?B?ajZrZWNSVDB1bDZXVFFuRGNZRGVpWGZtYXh6aUU1Mkh6cGdvTUdVVk1lRm5V?=
 =?utf-8?B?d1hkYmZwR1hEUllLbkQwWkJDempDZ0ZpOGpoRzR4WVZWVUhoK0l3UzhaZHN3?=
 =?utf-8?B?cUNMN2gvRVFYZFlmbVQ3OGtVVUl5VGIxdEp0eGR5aitYYkZWZnkvMk1JZGFQ?=
 =?utf-8?B?QnhiK3VhTTZTTjdvZkxiWEx0aGRCd0tVekxiaXBhTThBSldJVFVSa3UwVmRI?=
 =?utf-8?B?cHlyNWIzODd1UEwxVkJFNkdmYjRTT1VGVVpZWURLUy9mZFhndVBiUGFlM2F6?=
 =?utf-8?B?MkFsRUo2N3czUUZKUFhnN1o1RVJlK2wwNkxKUHRNbzJKN0pNVVg2bDBIbDRk?=
 =?utf-8?B?NGNNdE4zTDZiRWdiaGNQVnJ0RnVKYUFPMzVkZjA1cURuYVhXSHZhNHFSUjVW?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5jgAfBJ4tFi87eqtIqW52yb5QRHhxfFEaK3RbLri4//9fcQdGWWw8JwrJh3NoI+AL8cB8QSPW5F9bHclYTL6PkFdAGEOZVf7blngJcbtqDQ9oOx/zKB/wfYJRvPoZtSmtxAUO5h8rPIw6J/+p2qr8wtlryozsY8wY/Wke0Pfjrd0nSaeWLYsoHAnN8u7NJcU+L4N53Vt7vjgv6Gc8XgYvqymiaG+sfbiShNXJ37YUYizCvbsVi8TBI2lnYfDbWwFQ9LIGoIVX6b4SZbD0mz6U6pyEnxi1ruEnewG0lQN4gW4gdMScF2BkF/sm+CwvJORWXdk6WlwENlpwUvtweuIqWZvbGUICe7bpj/1rgpsVW+B67GhoJfaq9kIuLnWmWt6HuvGUBalKsH6SSy6EsAC5Cif0+D88oqp8PUz9o39RposJLcrFzXvgf3O2EiXTCn37dW6hTCtOWfWcGe/PcE1ykxkFDT1kw7tbRisdvLrAtioBk4nKWqWsz08tKWsBB1CtGUYq5EfGw2akuRcOx4f/yTvsnmmt795s/ZELqcCPrRvc1r6Rugsf+cudsCBkpifRks3iho2wp535+j+E5a8s7TzSxBUV/3FKJme1+PIS0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67142e4a-99aa-49fb-f770-08dd3be5376e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 19:36:22.2646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vjIBUwtASbMvKTszpV7F44v/gGBwlX9NF2zpAqvhpsDCoQvDKNtmUfcmbJQCIEqqVM26WRMeJ2shEOcc3pGuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501230142
X-Proofpoint-GUID: uQ_CQxSjyc6xuAt4uLP5EwS5e5lhxkNc
X-Proofpoint-ORIG-GUID: uQ_CQxSjyc6xuAt4uLP5EwS5e5lhxkNc

On 22/01/2025 5:13 pm, Jeff Layton wrote:
> As of python 3.13, the xdrlib module is no longer included. Fortunately
> there is an xdrlib3 module, which is a fork of the bundled module:
> 
>      https://pypi.org/project/xdrlib3/
> 
> Change pynfs to use that instead and revise the documentation to include
> a step to install that module.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   README                                | 8 +++++++-
>   nfs4.0/lib/rpc/rpc.py                 | 2 +-
>   nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py | 2 +-
>   nfs4.0/nfs4lib.py                     | 2 +-
>   nfs4.0/nfs4server.py                  | 2 +-
>   rpc/security.py                       | 2 +-
>   xdr/xdrgen.py                         | 4 ++--
>   7 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/README b/README
> index b8b4e775f7766086f870f2dda4a60b3e9f9bac6f..efdc23807e8107b8fcd575e8a4c80b9c73e3cd07 100644
> --- a/README
> +++ b/README
> @@ -14,8 +14,14 @@ Install dependent modules:
>   * openSUSE
>   	zypper install krb5-devel python3-devel swig python3-gssapi python3-ply
>   
> -You can prepare both for use with
> +Install the xdrlib3 module:
> +
> +	pip install xdrlib3

Thanks Jeff,

I see that Debian's unstable & testing suites have a pkg 
(python3-standard-xdrlib) to provide this post-removal from standard 
Python. Of course, that's not in general release, yet, but then neither 
is 3.13 itself. Not sure if we should mention it?

e.g: your distro may provide xdrlib3 via a pkg (details…), or you may 
install it via pip…

or similar?

cheers,
c.



> +
> +You can prepare both versions for use with
> +
>   	./setup.py build
> +
>   which will create auto-generated files and compile any shared libraries
>   in place.
>   
> diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
> index 243ef9e31aa83eb6be18800065b63cf78d99f833..475179042530a8d602a51e7bad1af7958ff5dd56 100644
> --- a/nfs4.0/lib/rpc/rpc.py
> +++ b/nfs4.0/lib/rpc/rpc.py
> @@ -9,7 +9,7 @@
>   
>   from __future__ import absolute_import
>   import struct
> -import xdrlib
> +import xdrlib3 as xdrlib
>   import socket
>   import select
>   import threading
> diff --git a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> index 1e990a369e6588f24dff75e9569c104d775ff710..2581a1e1dca22f637dc32144a05c88c66c57665e 100644
> --- a/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> +++ b/nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py
> @@ -1,7 +1,7 @@
>   from .base import SecFlavor, SecError
>   from rpc.rpc_const import AUTH_SYS
>   from rpc.rpc_type import opaque_auth
> -from xdrlib import Packer, Error
> +from xdrlib3 import Packer, Error
>   
>   class SecAuthSys(SecFlavor):
>       # XXX need better defaults
> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> index eddcd862bc2fe2061414fb4de61e52aed93495ae..2337d8cd190de90e4d158b3ef9e3dfd6a61027c5 100644
> --- a/nfs4.0/nfs4lib.py
> +++ b/nfs4.0/nfs4lib.py
> @@ -41,7 +41,7 @@ import xdrdef.nfs4_const as nfs4_const
>   from  xdrdef.nfs4_const import *
>   import xdrdef.nfs4_type as nfs4_type
>   from xdrdef.nfs4_type import *
> -from xdrlib import Error as XDRError
> +from xdrlib3 import Error as XDRError
>   import xdrdef.nfs4_pack as nfs4_pack
>   
>   import nfs_ops
> diff --git a/nfs4.0/nfs4server.py b/nfs4.0/nfs4server.py
> index 2dbad3046709ea57c1503a36649d85c25e6301a8..10bf28ee5794684912fa8e6d19406e06bf88b742 100755
> --- a/nfs4.0/nfs4server.py
> +++ b/nfs4.0/nfs4server.py
> @@ -34,7 +34,7 @@ import time, StringIO, random, traceback, codecs
>   import StringIO
>   import nfs4state
>   from nfs4state import NFS4Error, printverf
> -from xdrlib import Error as XDRError
> +from xdrlib3 import Error as XDRError
>   
>   unacceptable_names = [ "", ".", ".." ]
>   unacceptable_characters = [ "/", "~", "#", ]
> diff --git a/rpc/security.py b/rpc/security.py
> index 0682f438cd6237334c59e7cb280c8b192e7c8a76..789280c5d7328a928b2f6c1af95397d17180eff9 100644
> --- a/rpc/security.py
> +++ b/rpc/security.py
> @@ -3,7 +3,7 @@ from .rpc_const import AUTH_NONE, AUTH_SYS, RPCSEC_GSS, SUCCESS, CALL, \
>   from .rpc_type import opaque_auth, authsys_parms
>   from .rpc_pack import RPCPacker, RPCUnpacker
>   from .gss_pack import GSSPacker, GSSUnpacker
> -from xdrlib import Packer, Unpacker
> +from xdrlib3 import Packer, Unpacker
>   from . import rpclib
>   from .gss_const import *
>   from . import gss_type
> diff --git a/xdr/xdrgen.py b/xdr/xdrgen.py
> index b472e50676799915ea3b6a14f6686a5973484fb2..f802ba80045e79716a71fa7a64d72f1b8831128d 100755
> --- a/xdr/xdrgen.py
> +++ b/xdr/xdrgen.py
> @@ -1357,8 +1357,8 @@ pack_header = """\
>   import sys,os
>   from . import %s as const
>   from . import %s as types
> -import xdrlib
> -from xdrlib import Error as XDRError
> +import xdrlib3 as xdrlib
> +from xdrlib3 import Error as XDRError
>   
>   class nullclass(object):
>       pass
> 
> ---
> base-commit: d042a1f6421985b7c9d17edf8eb0d59bcf7f5908
> change-id: 20250122-master-68414e8f6d5f
> 
> Best regards,



