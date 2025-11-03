Return-Path: <linux-nfs+bounces-15962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F68FC2E123
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 22:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AC4B4E2756
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 21:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512192C2356;
	Mon,  3 Nov 2025 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lH/uRWkM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W15gzr1T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763E2C21E6
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203646; cv=fail; b=PQtK7xQF+7d7OUK8uIUvPRwMSTwLfOtuVwCr9WeyqSZ2Nswp2KynlZMKrorg9gA4+m1oHnIzTdGoSlA38a02buGcaXUvD0spbmoIwLTW8ZJA/bHIHDQsfq87fLu4KNgA4HyIRLT1XwGMzOxtV/6DhLdH8MbPrgx4aIssnvBs0YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203646; c=relaxed/simple;
	bh=8TuMAk9XGbXRxT3wGNzZHKBGOYCa9aWOFLq0qx8J7l8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lu9XENhGrNJv17OFD6UTsgRUF7KtwjPaH9jySLCfy8HOX8LqYrs5jD1Il0yIPkNATcKfiXO3zeKK5EYt0rwE3lwfp1G+pfcHfXcftlBYTDIF7ap2sM7Twub0JwsLtV4/se9X4wnbnSeoNbxWDEhb6+drhlhS+1iNjk3g5Rv8hd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lH/uRWkM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W15gzr1T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3Ksnkq032653;
	Mon, 3 Nov 2025 21:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uSPl2CgXCCTpNHtx6L0MJyY2NlzXjq0ZKdvcu44u2Kk=; b=
	lH/uRWkM2AFoG6b7wegjBYWRliHRfoioybrFDNTLeTXtIu2logjuLL3Ch3Q0jA45
	ynoiLTpUicby8L8cEvQoSugouK/jhzgmXQjRGhN+g7KX8FdaV4FFOnUwUSgfjkjp
	7dn4CIlxifHUSi5CDKyAoHjDdOiOSpktDBlLDAVWhsJ2TyzMpkKk6nqZOQfs1CLV
	kMP5o6MP/3NIlO6nZiO19B1M+TAPLTnTrgXbQLdatwb2vJe4PA7rqEeP/2vHsNg3
	VxpShl2WRnjnkkkgQ5ZUNWxsydnceya32iymfc8A/pv32ptsfwF6jltfvcquqbCV
	/dkOMRZCaAbPhgk/UmnaEw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a73ud00dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 21:00:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3KmbAg007994;
	Mon, 3 Nov 2025 21:00:33 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc75y4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 21:00:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk4C01d+xZzkVWBO1O3j+ncScs5UGG1HznFQ8IaqgnapNOwn6CA/sGZ6cd5PPWggwnMoqUiJbXYWwxxxQhN3i/M1PQ5ha0BvrAUutK9hZQpqc5fP5tonhjmX1tj2lNkEVd23teH4HGyMdAj34VkW8bpXffDCdBjWFbo3hOehnJO4k8YCrw/s70xoqwr9n4Ix+YlnihA14UbkiwIGnIoybfs4N56tiyleiPa2LzNnMqzKd8STLoJY21hKPSI4AbFTesuFVXfuCbEVLj1n15z2djVJDmPHZYIoq5VRdk7LZlN3h6RUFq90TJo9UxW7LEajcXY52bBfIE88IXvX/CY9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSPl2CgXCCTpNHtx6L0MJyY2NlzXjq0ZKdvcu44u2Kk=;
 b=DssALcgwfSnfJSuIwL3KJulw4kwfjvMpxi5SOu7W8JmFuTisomsGF2ZYPwpP4iSXmEDkT5cCFEsW1HHRgCsY2Z5C3h3AmXIk3y9U12/TqRWNblmvUH8+mG4Tmm+dgUBFUkqEJwOdceiHhW+y4AhFIcZwZJGrnaKqxKEqlz5fGTdDPXHCBAgT0WwvK1GwRjLUCC6Hh0WpMeKmM7J4knr+dTVzh5eWjRRrE4kDmXfSsPv2nv7od7d6aJKWHywztdXGyEe3ITLgCACJI71/ipWhzrPVa/9zFCVY9/jIKXUTu1O/ugJQ3K8xczYXdEOicHmm0OIeSudwX0YNa/1nfJsNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSPl2CgXCCTpNHtx6L0MJyY2NlzXjq0ZKdvcu44u2Kk=;
 b=W15gzr1TaLVNPWLlX+x6vuewcfAFYeDusEUiIdy3udR0PTQ11x7V27bbE4ROM8s+TzPmdIgDHIDmScuApdV6/DeD+gLFMKNzJ/WI+bFfxJ5almtXjxglEXrQONTgDkc91dPy+jWwa2oBE0tuqiEGU+Fyd3HYxvZrM8ItptXF4e8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7230.namprd10.prod.outlook.com (2603:10b6:208:403::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 21:00:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Mon, 3 Nov 2025
 21:00:25 +0000
Message-ID: <246d7f75-015c-4f80-a0f5-80f38f799c58@oracle.com>
Date: Mon, 3 Nov 2025 16:00:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Add trace point for SCSI fencing operation.
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-4-dai.ngo@oracle.com>
 <b8a55017-5bff-49f0-a2bc-6bea6df7d658@oracle.com>
 <41d1baf6-15fa-44a4-9af0-907286b26299@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <41d1baf6-15fa-44a4-9af0-907286b26299@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:610:20::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 730dc161-7f5f-4f59-658b-08de1b1c02ca
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Y1pFcWRtUk96RTg1KzBNcE9SbU5vUjdMcmEySU85aUx2SHJHekhXQ21Candx?=
 =?utf-8?B?RUlHbUZLQytsQWx5dTJWVWJxaHlyeDJzdjUvOGFxdXF2dEZBZnM3Sy8yWURQ?=
 =?utf-8?B?TStQT0tPdTlGZlVPOG5reWtkNHZicmpnWG5RcG9VNVJYMHJvSnBJMHJSeHhm?=
 =?utf-8?B?UTJjV0puZG9mM0puekh2TlBaWUo2K0drOWUwRHo5MmZ0WWtrMkh2LythZy9n?=
 =?utf-8?B?K3RBVTlENmF6UkU2Qjl0UEFkRWZTcGJMa1BuZTBwWWxER3hLYlZTZDhDdG1z?=
 =?utf-8?B?a1hGcC9TNjJRQjkyUGtnQWcwTjhENlltQTVPQUZld0JveFFwbzRIeURFN3R2?=
 =?utf-8?B?Uk1XcXh5T1JLR2dOSnc0cmJaUkFjQzZnZzFMbkZ4Um42Q0FBeWxXeUR5NnIx?=
 =?utf-8?B?MHQ3U2l2RzdISkJla2dmTW5ad1BaSEgxK2puOU5lK3B3NjJtbFhUY21KM3Zr?=
 =?utf-8?B?YW1PTG5HczV5RmZXNnluQjl5b3FhNm1nQ1ozU2V3cW9lVzlZbXkxTkhuemlS?=
 =?utf-8?B?c2UvWkFsaGF2TkVLYkRNais0S1ZsRHoweW9RelQ2NXVDMEJYNXhQOC9yS1Vp?=
 =?utf-8?B?QVQzQXo5Y29paW5TVmVQbWNZTXJLSFZNNHNMTURpV1k0b3BBODRuY3N4ZUF0?=
 =?utf-8?B?NU01eVdkYmRudXk0Z1QwRld2ajJSTXYya002ZUJUL1RGUmRET0Q2eXFYWnAz?=
 =?utf-8?B?TGRlV3lWTGlFUy9wL0d2aDdUcTc5MzEvdE52SXkwQ1RZUGRZZDMyYklQUkh2?=
 =?utf-8?B?c2xnUzRBYnJySFhqYmRnUjFWcW90MXdhWm9yeG9mREFpZ2d5Vm50aFN1dHIr?=
 =?utf-8?B?TjZjOXcyRU54MmJPYnRCa2JiWEppYnh3U000cDBrREw3b1RqVFR2czJGN0dP?=
 =?utf-8?B?dnl2QU03Wkp4aExnL0JMSzh0NFpLL2FMTEVEd3Z2YSs5VG8yZXY3bmx0aEhr?=
 =?utf-8?B?RHQzanhtY3Mzd256K3lhdGNxUjV2TWtsSHlBakRFY2QwaE1ZaDJRS3JXTE03?=
 =?utf-8?B?dU13ZkRQMER2WEsrTW5MLzRsNlF6MG1BVU9OTWg1NFVFVlBia0YzV2wvMkRL?=
 =?utf-8?B?Ym5sQWZlYy9mZDYzRnFrWjZXaVE3UEpwTlFicWFKbjZuUGU3YjVCUmtuM3dE?=
 =?utf-8?B?V3cwNWpTdW1jWWJOR2IvcnNJL28xK0pRR1Nsam5iNW9PNCsrMnp3TVBjQUxh?=
 =?utf-8?B?V0FoemFMRkhsMGhySTdWM0o5UEFyN1dDWE5DZkE0R3pMVWZLL0pxTk5BUEM5?=
 =?utf-8?B?Q1Fic3JZbkVhNnZnMVNrNlJiMGJheVdoTWNjSHVIOFpqMnN0ckxvdVhjZXpv?=
 =?utf-8?B?dUs2U0RUU1JZdy9GbjVlMHNqMy9zaXpLdndYQlN2MjhBZldPaWhEenVjRTNm?=
 =?utf-8?B?WFhQRGhuWXhSSHYvV05SZTRpaDNaL3RRUkJOalV6bGN1bkFHS3M2MU5obFds?=
 =?utf-8?B?ZEZ3Zm1oSXFtQnhFZDJkZmhGN0Z2TytTQXIwS24xMHUxZWZpOW5MeVl5K2k2?=
 =?utf-8?B?NVh4RTlEcWVLcXd1UUQzb2NDL2NVZ1JMeVlrUCtGS3hvcHA2UUZ2bVJUTlhC?=
 =?utf-8?B?dlhMRDFHbEd0UktKQ2g3d2NyNzlWYXY0SmVJOUplbDdEdCtWMlJCaHRYMExs?=
 =?utf-8?B?b0VVc2RDcHhncFpRM1lNQWRlTUxiY2ViVDhMcGpuQ3dNOU9XYU5sUVk3MkR1?=
 =?utf-8?B?SWhrNHdNOFBwRlBYck52My8zSXBFZW5oS1JGb2FXaVFyMVROcEpzWUo4YXQ0?=
 =?utf-8?B?NU4vRWpUb1k5ellaTXhZblJJbzd1L2xzYXRwRUpHSFY1UVErd1kxbVRHL2hn?=
 =?utf-8?B?cjBVb0R4TXZvVjdBVmVzamMxWDFzMkJDbGJwcWhkSzNKald6T1huQ0RMdnMw?=
 =?utf-8?B?cTBHM21rNkhERnVOMUtMb2VYTDVpQ1U2OEdGOGphUzhpQ0VHbUJ0NWJqR0k4?=
 =?utf-8?Q?xEDkkaDx1kYAgRUV+9ElTA6jEXs56w/u?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?N1l3QWJTNytvdmFaL0RFaUhOQzZ5dDRWUEtOTXZRWG5FdjFlaTVKdkNtbUo3?=
 =?utf-8?B?bFNER2lKRzhOUnpJY241ZGZCcG44aklYelZ0TTRqTG9wZm1nQXhzOG81U3li?=
 =?utf-8?B?bGRtYjJRNVhpQW1RUVVtdGtycVNyYUZ3VHMxNWMwNFgzVzkrRzBBb0t1d1Q3?=
 =?utf-8?B?T1ZVYlRTRGFndEdOME1KL1pzWUR6NXRIS2dUb3pQbUVTRkxSM3JxRlVNa3Uw?=
 =?utf-8?B?VWVpTGtIOElOSlZla0ZKSlhwN0llMVh1NktLcU1ySjhpNWgxcTRteDhwcDlE?=
 =?utf-8?B?dm41ck8wSk5sYVNDbk4rT0MvL0JsR1V3YzNPeUtzYmlyT256RHBCWlNkVFhF?=
 =?utf-8?B?TXEyMmZFMS9NZkkxdTlzNnNsVy92dWxxN2dxYjVHTFdKNXZoQUZqWFAwN3o0?=
 =?utf-8?B?N09BMklZbXZqN2YzS3NmRjhiK1VBblMzMDVOWFdGeXFrd2lHdzFsVlV3L0xD?=
 =?utf-8?B?K0lKYTZBTWttbktFOTBjSGRaeHhablYvaWU1RndXK0Rrb3V6WmUwZFJFeita?=
 =?utf-8?B?M1c0RzdrR3lvOStUV0pFREFzcm5GQmlxakhrbDJoNkFSTDVTcWI2YmU5WFhG?=
 =?utf-8?B?V3NJRkI0Ym5NZEZFbGZtcXpnelMzdzRxRHg4VGxlSURBZ2E1THVhVGlqVUha?=
 =?utf-8?B?UFh1ME1HRHM0RVFZM3ZxVFV2eEVHYmdpOEdiNnRnWWFuM1RLc2ErZG5oTHRM?=
 =?utf-8?B?b0wxWHdiRDhmWjVxWmVlTU5Sb1Bxck9Meit1SWlQYkRhM0lCKzltS1ZPOUp6?=
 =?utf-8?B?NzVEWlZQU0xCZFNBcFQzUTB4ZTVlSkVob2JNVWxsV1FDUkhQTXZnSmt4SDc0?=
 =?utf-8?B?NzliR3l2RVRBY0w4Q3orTDlWZExSVUN2RkhNOVE1L3RYeVhKcVE1cjBBSUww?=
 =?utf-8?B?OU5GTWVUc3lXc0NIWWpwVnA4MjU0WjhaNk1TYkhIWUJadlh6MERyWWdHOXd6?=
 =?utf-8?B?akk1RnM5RnJDV056WG1vc3g1S05ob0xzWmxJek5vcGU0UzkrVDdFMndkTSsy?=
 =?utf-8?B?SmhiQi84bEFYMmtFSkFjQ3lLMmRvNEtJdHZ5Zm12WHNWL09mUWMyK2NIbXRw?=
 =?utf-8?B?bGtSMkVwZXh3RHh6RCtwd0lWbVliWkxmZTRNNXlGUHorYi9XQ291ZjM3QTJu?=
 =?utf-8?B?OUJRZThCUzREbENyeGh5ZHZyMkIwM2h2aHhkTXNndGgyZ1dHclJZVW51WFBz?=
 =?utf-8?B?K3RFUEJibk1TdlNjb2ZwMngwSjJYYUpJOHUrbmtBeSsxWm92TVUxSW1Fd3ZH?=
 =?utf-8?B?K1RrVU9PQzZVTlJPeFlxeUJMNHZrakN3MmZqM0hGMjBMTkxGbzNSd3l0bU55?=
 =?utf-8?B?U25RVTUvTnFZUXUyZWpISk43ekdZbXFDc0U2V2U1YklDekxiY1p2anBIbU1h?=
 =?utf-8?B?N29yKzRUZ0c5T1ltRERpcnZFY0pEVk1LRUVyQldOOGxKUzZRWjdWYkNqSUsy?=
 =?utf-8?B?UmN1MXFqYnFyTTRTZElkQ0NRcEw3c0g5d1RKM3M0SXc5Y04xUGJ5N1FqdVNm?=
 =?utf-8?B?VFNqUkdGRGdxNnY0VkZ6dExJWnZYSStpVSt6MXAxUitmU0liV01oOXFEZ1BQ?=
 =?utf-8?B?V3phTldHSS9KaHU3STg2ZXdRUzVtdTV2Nk03YVdzNkQzT3FhcTRySDdSNVRG?=
 =?utf-8?B?ekpSSEt3ZFJDVHM2RnVHVGlZTmhVMkhkYVVqWnJYSVdLNzczdWNXZnFneDB4?=
 =?utf-8?B?MU9JdG1KdEVlbjFCSnhNSGUwN0FHV2orbUZWL2lYVURtVU41aXFINW1SZ2V2?=
 =?utf-8?B?ek9BZU1QNlJmTmF6VndaZyt0WmxSNlBHSjNqOTZVQmYxZ1RBSVdGMm50TFls?=
 =?utf-8?B?VWxodjUwd3lJMk9aWmdHL0dVM1l4Q052ZmFYUkRwaVk4Nk1EanVRUDRyc1ZI?=
 =?utf-8?B?Z1JYMys5Ym1ZL0JXVWpyaGppam95QTRvUFZpcDJpWEJXV0trSVA3bGcyMnlB?=
 =?utf-8?B?OHFUSzJVdzVZcCtlTEdhKzBudXdwQVdMSGNGVmhiRTNXOXJ0R3l2M2JCWU9i?=
 =?utf-8?B?T3lTUFY2TEdIc1JiT2ZVUDV3Nk91WGhDODR4TG5HdUFHZk1lekxxODgybndh?=
 =?utf-8?B?T3RCUVFhVWpZTTRyZXhTQ0dpRUlCUWZJeXVCVEFLbUlDeGdvMGwrMTZXUUlK?=
 =?utf-8?Q?OHJMQCWovuM0aGrvrUSAQnUwl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5lCCwQ0/OZIhslzmCq/4djdxtHj5pbMaAkjA2jOF72uy7Zxidg16oobRxyL7R8AlAlvN3JQmjhrGpdr98NqYJaFoFh/t+inWTnXvgfjCjG016Ad7v9Ccee1gFD/v9szo9+3k4pWZDun6FtJ4JfwhAO8b+CcBAiNayPGPPAo/MGrQdfsuc12T556j7Yoh8+oV0TdwSDgi+T8q+TDuQ/mExVGvW8JQ8Tm5dwhv5cG83mu+DvHEIQcSkAMPmx/7rDJ33EmQn/sINIGyVqSUscDmJgryfl409btwVK0/q8nzfhctoDmOorYWoT8l8Z2N864LZk/Zz6XGS1IPtzqD7nsDQGSpilnjbCpiJaGbIGBtSwbPmn/spbQYITK1GP4AMqSHgzFnZTL9YB2WFUDpnBlixi7s+iprhngj/+wNqQXO5hgGShk4UBB+6mVhSzA7WCcWbzIgzfSSH9q50OLtIPMhCoKzJGziFj/uiAbkdFx9WvDVWhybv0yH3ggitCujml8UPn45GCg7XLEzNenZDBnpKCj1b7r/D805NcFaShSpKikVmk/8F+84nN6RyhnGZkNgacV7eWdY1hFx9RNk1H8vkaTbmu+YX383szfZC2V/V70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730dc161-7f5f-4f59-658b-08de1b1c02ca
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 21:00:25.4593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxUqr2fzhrI8rUDkFjmh7bmfeWXwrKRQAs7f+7K/XTbRxN95LX9V9qCM1uhx23pww+exc61vIkszykQmlkSG6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511030187
X-Proofpoint-ORIG-GUID: fpim5RDtCIfNABqS2GI98BJOgVyDcHTX
X-Proofpoint-GUID: fpim5RDtCIfNABqS2GI98BJOgVyDcHTX
X-Authority-Analysis: v=2.4 cv=NNfYOk6g c=1 sm=1 tr=0 ts=690917f2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Lf-ZmyUT75oGhdbRejMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE4NyBTYWx0ZWRfX+7qow/JTYlt7
 yYRMHFE74e2BJrYY6o3NYyEUf7o4PMPCPPcbnY6BX/dNbrwR1nOXjfRHI7XrJX/dVRWRSiy7mIY
 ugimNHEA+S3BVBDP+aq0+owQ6TxyZMSpl60IhTrSfMGaCchkElwkGQP0iFnYmDI6QYmh84ll6hR
 jxr5Ies2h/VNKIAxPsBwU3YxCArPkLdU4kdnlXn9fbIZqTUAn3O2vi8xQWBVmUnZBguY90vdm1w
 9klaTrOJAV+hNQHEOZmjVTdSw4Gnam+pE8FJuCHlEJklpv4OQ5KXXORgAnxz+TVKJmegyiwjbsi
 lxSYu2aKpvNvav4KCdUSsm+7Ljs/EWp5wff0c+izn3wu67KdUg97h1zljIQkkQ+AdvS8ifAFFaT
 lAjytCC3CaQsXFzC0IAxD9ERRnLeZVMwVPzV2KG+tLPw72VhzzA=

On 11/3/25 3:44 PM, Dai Ngo wrote:
> 
> On 11/2/25 7:40 AM, Chuck Lever wrote:

>> Do you want to record anything else here? The cl_boot/cl_id, perhaps? I
>> guess there's no XID available... but is there a relevant state ID?
> 
> There is a layout stateid. For the fencing operation, I think it helps
> to display the client IP and the effected block device and the status of
> operation. IMHO, I don't see any additional value the cl_boot/cl_id of
> the layout stateid can add?
The theory goes that these two items define the server's boot epoch.
Maybe what we really want is the net namespace number, since that makes
the IP address captured by the trace event more meaningful.


-- 
Chuck Lever

