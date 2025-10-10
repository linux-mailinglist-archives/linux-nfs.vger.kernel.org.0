Return-Path: <linux-nfs+bounces-15122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D1BCCFD2
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E44227FC
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C6F2EFD91;
	Fri, 10 Oct 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DRVAJ3vX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qYqTBhZw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0422EF676;
	Fri, 10 Oct 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100491; cv=fail; b=sbFjmSf28d8fzRAg7lhRQkTx7whlTlzkOlQlJ0tMWco67XHuwdL2duWGfCIQ0Z+cv8o1G7ijPBRs+t+jrfIuHxSXmjf/bu9RxRzsV2nhR3EzCm/hgVrV3qS0nucHciidHwK7jsjcHob4tdd2uulhsoByaZwgB+rJKpfMxSATpWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100491; c=relaxed/simple;
	bh=ayUCPN5RzcfoFjcvSfhvgZ4ik8uBxu22eRsUJRTsKdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Us9ngBvz4R5i788+nrg3f5LDgp51sokSH73NL66PkIeDaV9pRzezzCUatLHf7DqrxIotFciLVpCGOCO7RKB2Rrbj0npg+EL2gv0DkepIF38Y2ybVkGSc20V3vXgs8WBaKsmIJsIUY+bpNMD+cnWC5bwat75rSL4mBDcCVCZOD64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DRVAJ3vX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qYqTBhZw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A8tOwi004008;
	Fri, 10 Oct 2025 12:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=x7xNw018DGecXjCvrbtl6tr0D8+RidNg1vlvphQIctE=; b=
	DRVAJ3vXysCxZjMqbKswmZo0/Kn3Hu5nWV38cgnSbG3EUwVkgfQGFrID9gCLdq5O
	TewlCZeXS9CuVa4sYNan27e1+lX4rDXfSVqlOxBTx/rLERF9iZs9eDQ3niqPdAV+
	SbAT5NMpN7hKzTAHWue+My1c0S+HsQvbhBaKCkHhcFG/DVdZb5L7F8mlu2pn+qP1
	kCWFGp3oN8QNhkPN1Nezx055sf1/CeFTd0WCuL0QJJmJUKfD9BpSpFd+zo9v3ozS
	zCefKhQ/fHXVHkM44cpkLmHAk3Anq39I7WU4jqb4/eLOkNHFppJvi3+4NdFkaHD6
	kNq10jnEi5Zc6uNsYorVeA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6cbpwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 12:47:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59AAeJC2037136;
	Fri, 10 Oct 2025 12:47:50 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv656nj8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 12:47:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ+YACWqIrOFZ3rU0k6npJ0N0p+DJVKkOeqbHHoPJ/LPGbyziuutDwDuhVCCjWNBHYTiizTu3giRuF3kw0YSRN59ZrsWogZM86UbTexJAmsjcbvS/N3bwOsVvZGvf8SSKBOkBT0WvXaBoc8ae2KbWNllqugkRxycAh4yoCZ6z+F9USPIcdgdPl2HiZrUQdwg5fi+lgUBBZLcO1RwxVlLVu1tg2tLMrsywkGK1V+fP9prf0tsdGeExwydumlNyjoYk3fs3WxfGk09tJCmL4uDNkmaIPUzBr0vNn6aZXZ2ye1YjOM5oVivbwXMlpmE/MGLVO7d7cgjvIeruvyXeTlV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7xNw018DGecXjCvrbtl6tr0D8+RidNg1vlvphQIctE=;
 b=IliYHnOzMuaPuRezPU8ovV8F0vmVXHLRVtFa/kCOXbHeyRUmrGsVke/tFtJJI6gRAQ13AxdOFbFoMShHb+flu9QBkvSUxeMuAQfybywUj4NIqkdnM24B+GepczzcVyZrvGA+Gxj8iI/QhP5o1eCEBcmLNkbma6PO5XATDScHPfkUD5CeHC9QRPiB/A9GZ0wbLjF2/Ehcay3gX1Od8FBBMmYRfnpPygl4znQMMsSzOlTy82z8qO7HO3vZNeaD/DlAQ33qHItQj4Q8OsPdyuje3rkm75TVt7uVNCX5vRPBeijQuFI9Xaxwc81G4jl8gTYuMr3nly7NZDk3cgxFkz7/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7xNw018DGecXjCvrbtl6tr0D8+RidNg1vlvphQIctE=;
 b=qYqTBhZwpjeFr8crmGB/ssbzhNZClpk6ACHCyCpG1AQrBi7sdxE1FdWDMDfpsxbTPWi3Azcqp4sld0tRnqWSZ8poTc60x9iTARlnfufT6m5rUfAK4EybU8hRtMi1vypdZ3eleNakrb1EyngAhvTsl/4uUfnrvx8VHV2WfHGXZiI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 12:47:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:47:47 +0000
Message-ID: <e6f7474c-fa23-492c-92c0-afcf15ff6eb9@oracle.com>
Date: Fri, 10 Oct 2025 08:47:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP
 record marker
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Howells <dhowells@redhat.com>, Brandon Adams <brandona@meta.com>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <> <74e20200de3d113c0bced1380c0ce99a569c2892.camel@kernel.org>
 <176005502018.1793333.5043420085151021396@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176005502018.1793333.5043420085151021396@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0095.eurprd04.prod.outlook.com
 (2603:10a6:803:64::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ae42a2-ca74-404b-3b0c-08de07fb366a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VEVyekVMaTgrNG92U3dLRUZ1cE1BQ0l2bjFOUllXK3dnTVY5ei9XMm96K05m?=
 =?utf-8?B?SHIyZmp3TE5MZ3g4ajQ2STZYSUpyMFlwSVVSRW5hditPWDVVVjc5YU1zYkJU?=
 =?utf-8?B?N2dCSmJ3azloOFBKS05sRktHcHJ0b0VaSERkRm5odisyOW5FNCt6MDF0VTB2?=
 =?utf-8?B?K3RrNXovaEppUGlPTExpRDU5RnJBV21xdW12RDN4ZWZXZlY2dHY0YnV1UFJq?=
 =?utf-8?B?ZmNYOFFmSlE5N2J0dEFKbmlOcGRJL1RHcENrSUYwR2hHbnV0RlRVTlJGSEdQ?=
 =?utf-8?B?VUx0a0YwZWRIMmxHT1pVcnc2RnF0TEVJQlY2T1Y1OFBBTEpWMmFrbEoycTNj?=
 =?utf-8?B?L0NiU2VVZWRHazlLUk9QT1JlS1cvTCtpKzlyZWxaUHVSeDhnVFY0NHZWRHBD?=
 =?utf-8?B?bmtuSFpsbzRTWFE3VUV6SVF0MkRMOHVSZDRLMFZvdlhJRDZrckVuaWFuU2g0?=
 =?utf-8?B?RytIRjJJSk01UFJ2UWovWkRFMERmdWZlVHJ4OW41UFFsNStyYUxnVmxpMitV?=
 =?utf-8?B?aFZCV0pRZEk3REhsQnc3c0FEclB1LzFucGQ5ckVLVFFZcXNXNlNZL0lUQVpG?=
 =?utf-8?B?cHVRUmRSOE92NVU3WWpVQjRYTlNpM0c1YWFLVzRSSEp2WjAyZkg0UE4weFdO?=
 =?utf-8?B?ZXl6NGJEdE1GQ0Z0L3ZSK2UyWEtJY1VaZlVYYzROeGEreWpiSDVsNnJMTHI4?=
 =?utf-8?B?eHR6eFptdHRTakZhUWY1ci80TTk4VXBIM001ckdBMktqeFF2Z0xPazhpeG1T?=
 =?utf-8?B?MXkrOElvcFNJbDRON0xaWXRUeG1reXlZYjFlOWw1KzRFaVpBeSs5b3U1VDZQ?=
 =?utf-8?B?OWdDUU04b1B3QWpUYjZJWm9mQW5qUkd1SjJlbjBCL0RKZUpoZzMwOVdWeGJh?=
 =?utf-8?B?ZkFhRWk5M2RBd0MrOWN1cEk3YituemJCdnJBNDhLVUdiTUtXZHMwdFcvZ2pv?=
 =?utf-8?B?K2RvK1ZESGcyUUpCalFBbU1QbGR4QTFwaTdQOGpORld0ODM3Z0tGZklsUDUy?=
 =?utf-8?B?M1hHclArZndoNHdIQzZidTFldkV3aUpwQTM3Ykx5ZTFRZVRjTnJaYVFqM0l1?=
 =?utf-8?B?anJlcHNxaThxZmNhaEM3VktyOVpjekQyVWhNQmE5OHUrK0ZvbmNCYTVxejBS?=
 =?utf-8?B?Sks0TkptSXhwbTNQbEpwajUydm0vUWYyUHlpcTU0eGFzSkEwVTdZMU9ORnhF?=
 =?utf-8?B?VlpzS3RzNngxOWpMZ1VHWkczZ3FmY1VKYXhkRDRraHRzMmRjUzJra0hmdHJy?=
 =?utf-8?B?cHZmdk0zRHNZaDVSV2lrMjBNQjAwU0oycG5teFZLNyt2NWo0WkJZbEE5WFda?=
 =?utf-8?B?STFLaE1DbHh2QzRCbVZ3Tk05bmtmdVRleFBwWGd6ajlMK3ZqZVdhRU5QcTdK?=
 =?utf-8?B?dERwdXRydDAyMVY3MCtxcDkyb0JwaUFhQUlISVp3T2lyL2l2ZDUway9RN2Er?=
 =?utf-8?B?OThnUzZCYXppZmYvSDg3MmRQdysvY3NuOVM2TWF4SjRaOHl3QXhUYlU4UERB?=
 =?utf-8?B?Mm9Xa05CQmFrOFJ3Z09sYThHNEQ5dEdDamdwZmlCNVVkdXlqcjdEbUFOT2gz?=
 =?utf-8?B?b2FrdHREMnAydElVKzBTNHpScjR5TkQzSE03dWJrTlZwWmttMjJ3WWE3dXk0?=
 =?utf-8?B?MTl3bVQ5TVI5RUpSRXhzYkNUREVuZnlBcjVuUGZHeGU1Yll2TDA5T1BTMmtB?=
 =?utf-8?B?TUlDNUhSQkM2M3JiUWlMbEcvNE50L1dzMWxhWEZkRGhiSXpCT0VibDNVMFpD?=
 =?utf-8?B?YTdmdG0reFFQaHlNSGU0M3dQSGUvbytPYTJYZW51clduUHdFMzErQU8zMk10?=
 =?utf-8?B?SFNONG9JVEViODVZdTBDMko0dVBSNjhMK2pOZ2xKcTZnUnhGcmQ4Z3p6Vnha?=
 =?utf-8?B?RGEyaGxjcDVOK3hnc3pxYTczUDM0bUoyaVFzYURtamYvQ1BrdmN1UXRqMWZC?=
 =?utf-8?Q?MrFSBvZG75wcZ+ei064U2M0l+FnQ+2hK?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Tm9IUlJxZmVYY2FiMFFUUWlVMzJvV0pvYk9DNG1lc3ZySGN6dHg0MG45WUhK?=
 =?utf-8?B?SzRrV29LYVIycVc5Sk4vMXBBbXkyRlNpMEpGSWtVdk0rKytZOUFvM3RtWTBp?=
 =?utf-8?B?bUc3YnViaDBjTzk4WHpscHJYakhCZWVWN0p6a3NkTXBPenlPMHhieE1KMUlK?=
 =?utf-8?B?ZkZSUkV2R0ZnTUZnR3NYQWFZVVNVTmhPcXRiSjN1NjRsWkt0aXROZnFKZjRX?=
 =?utf-8?B?UkRBem1qRnRCVmRrQTQ5bk95SURZdWVlZkdGc1RHd0kwT01Sd0dabEJZeStQ?=
 =?utf-8?B?ck1RdDg4YnYxU0pYODY0U2ZjVmd1UDdkaFl6WXcvekFHekVLcGRJTnRINlNo?=
 =?utf-8?B?ZDNmeXZxc29SV1pxTitvWnBkZmJUVXp0ZGoxZXBmQ2tKYmFWblc2ZzJaUVlR?=
 =?utf-8?B?VUpkaXFHUjVaUlpDVnpnYWhVUm1YK2pUa2pHNy9CY3pydUxOSVZKZUpQMTU0?=
 =?utf-8?B?dU9QRWJocTJ3QUdoS0o4NkRscDBqNlFVNEJyWjdXWExzRXhLQ2N2N2dmYnEx?=
 =?utf-8?B?dXludXVaSHZRRGFpY1JPM0ZCMDZGaVJQa2NiVllVYmRQakV5YWVMMXJXb2Nn?=
 =?utf-8?B?NENrbFc3Mlo3Mld2cGtGWG9xUzhERktJNEtBMW5YcURkdnM3NHFidkhkRGov?=
 =?utf-8?B?YTVpSlBpSktnUnRHZE91NWpST0tNRmVFQWthK2hGc3p1Mm1hYnhSR0RlVUh6?=
 =?utf-8?B?V0dtbVlWY2ZWZ1cwTlhGRSs4TDd1OE93VSsrT0NUQVZ1UW9ncHJvVHU3akZz?=
 =?utf-8?B?UnQ0eFQ3b3JROFJvNWJ3WDVNOWR4NkZJUEV2WXZKVWRuM3VVKzhZRS8vUkw1?=
 =?utf-8?B?NG5jQktVOTdFaktML2FyL1k5UVZBVE84MlNscnNZaXBpOEFodnRZUE43MDVB?=
 =?utf-8?B?OG11MTBlazRSMTJIMEtoTytGbTIwL1FSRGlBc2tMT1VDRUFSQTZ5REhYZmV5?=
 =?utf-8?B?R3g0NURVRFkxY2s1UVhudElkUWxxNzIzc3pSenFOd0x5a0RrcFhpY1hLRE1l?=
 =?utf-8?B?d0FtNE1LZlc3Y1RCSUptUXNjcndlRXB6SkthaWNNUVR6LzlVOTU3a054Sjh2?=
 =?utf-8?B?YTZFeGZ0NFRPOHgyTm5ZT0YzQm40UmgyN1NUWXkwMGZOMUpwaVNIYTRkbjNY?=
 =?utf-8?B?VWc3cklOdm9jazhUM2JNc1N3NzB0SG1hRmdYd0dsNDRjaXhuakxpaDV6U2Ir?=
 =?utf-8?B?QUljZUxuUlp6SkxpMytFcUpBczBvei92SWdyZ3NIQWU3SC9Jcy93TE1aeG50?=
 =?utf-8?B?RWM0VS9iZVNkMFYzeGtXeWkwQUVUbUNPUjhNVUVpWFVOYnlFRkFhaW5ZK3hM?=
 =?utf-8?B?Q01XUEpUUlFZazlHOVVzK0g1TzRNbWd6a3E4TzhRU2k1TEEyQmZUUlZHa1Q2?=
 =?utf-8?B?eUlXTWJ5bUxtQ2J5L09SMDdJQVlCdzNWdlRvVDBnNXROaEJxNGFjbGxQbnRH?=
 =?utf-8?B?RVYwalNPcC9XNUJMMEE1N0tDZkZiSE5pb2FwR2xUUEtoQ3kvaS9EKzlZbHUw?=
 =?utf-8?B?RytweVFMckFmOEVzOXZJVmc4L3E2R2RuRlg3MzlEdmdTZmVWOGtTS3dWS1Yy?=
 =?utf-8?B?VnNxY3AxRDAyd0ErNHNESU1GbTU0STRQaklLUXI3UnVtTWRyWnliVGJSS0Iz?=
 =?utf-8?B?VWNDRTNoQk02RFpxelI2WEVkdG5PSTBXbHpCeHJhbm5wYklqSWxDQVUwRHRV?=
 =?utf-8?B?Zm82R0lGbEpSemxuVnlJZXZLbmtPNWREcjlZNTBOTGZ2bUFrMjlqRStycU9l?=
 =?utf-8?B?NzlNQ0pnanZCd0J5UHNvaTcydlR3ZXAxeU9Ec2szT3lrTW4xYVdvbWxrKy93?=
 =?utf-8?B?c2RQV1Q0K0NySDJaUXVtYTBnYXo4ekFOaGpvME9tK3dSTWEwazJKUkxwVUdC?=
 =?utf-8?B?YTlUN1lsTWlxWjV2Vm9kV0Y4YjcrUE9rckE2eFBNc2FMcDFLbldGZmhyK2NX?=
 =?utf-8?B?RGx5VUdLdjhDU3p3RDhhNCtkVVFESDRzV1gyZ3JYakRiZkpWRG55SmRWQjlh?=
 =?utf-8?B?bVBsMCtBemUxUEdiaWlEekVqSmVFemFvNDdRYk1Jcm1TSkFsQ3M5SHRTS2Q2?=
 =?utf-8?B?RERxT09XY3Q0UWNEb2dvdkYvWlVpVk5CWnBiOWdlZzZYelhQNkNseUdyNlVK?=
 =?utf-8?Q?t/os/dGqL+3+tx9oH9f/OSXPp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KmTW3uv7gUVUEB5UFMAssdKz+CBFMLuGMIuAj/siKvW2L6ZNpWMnrD6n9ljO6j5jkoq7CE0oIr49P1I6PXqgtgRtToX8lYUWThJ+tQk6gTExQ9y12JpnT5fu2TTPRDvrOj3vv+9u632Yd8i86X+jHAgt61J2j8AW8DWD/9D6NOmpOVuMcsUYi0Fe3HtccxbIIrGr4rpvuh63ARdkW39TkR0oL0cQqK1KbRJIplaee7LKBlwXa6ghQEladJhGT5Iu4qYZCCJ9gkgPBDeOgkG6sjRGCFIZF6TQB18F2DqZqio7TTUWCO9eWEpJbrweXPeem+sXx14CKG09nd1iqJ8xwML0eT2C9Nu+s64NGsHYbZ9H3BAVWa43bF7w50zd7ktEUTmxZH/1XXuzuOCPE4sY6Z5n5lSkMphb5Fj3GOLYeEhD/IDTVI6Htds5WZIRL1KUdbkkjta84TcVfbjYUuU7ni0HRqwpflcZ6W8wybwuQlR8B/AB3I9gicOTN8rMP9/gPN6aoeEkfuz3jRlAf5vWMzjtcbAzvIqavq8a8uMLyY4uJbuhqbcPCwOw48DoUFHBzDZU/tv3+zGbCXbIySc61T6lyPHWwO/Q3/+GVTnXUEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ae42a2-ca74-404b-3b0c-08de07fb366a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:47:46.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2TYjLAyAf934gNdFLSq4WNoQppYxs8iOyeoZjTC2Une5lYiAHR+Q04BysEg1hjxANZ8MUz0q86Xhz1lUlV5SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510100073
X-Proofpoint-GUID: GMvX77mhtZCJcbMmOaUhvBvfjdPjs7WX
X-Proofpoint-ORIG-GUID: GMvX77mhtZCJcbMmOaUhvBvfjdPjs7WX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9tSR4mUBJsQH
 dLtp59WJ7ngwO/PQhlmdVS/SaFEL0bspOb6Ej07LJa/2fi9lh4PjdPp1tvsnTpJkXamQFr+sf2V
 6bYduJ18mOglAkRGn7HOlBE2vgZ4wvEXcLNL5kIHripnFuiNKztlwYRtX8VPzOOOrKwsIb0Ilqx
 BHAWfQ0GIocDahADUZboQ/z0d4+EtNLUetGPfwgBo5JHUvE+zxaqJmQCNiQ4WIIhyDwcXjZdm7s
 E7r1lnRUfgWPuPWkVUevf6cP5L84rx9QyMnaKdPJFkbnQT1KWOSvw5kF+o1ZHuv6px8QV9IcK9s
 Gn4Re/2pFbauyzLMqtFRcObES5ZV9sQP+UAX1d5AqPVr6RU9RT1qufym5HFLyo0zPqKz7KbeD4+
 njBc810ZEgC2HfR2Zgv1+vH4SP045MfRCU9IQaIKqNQs1Ouq5dI=
X-Authority-Analysis: v=2.4 cv=FYA6BZ+6 c=1 sm=1 tr=0 ts=68e90078 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8
 a=cBzHI10U8XTwQV4WKGIA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf
 awl=host:13624

On 10/9/25 8:10 PM, NeilBrown wrote:
> On Thu, 09 Oct 2025, Jeff Layton wrote:
>> On Thu, 2025-10-09 at 08:51 +1100, NeilBrown wrote:
>>> On Thu, 09 Oct 2025, Jeff Layton wrote:
>>>> We've seen some occurrences of messages like this in dmesg on some knfsd
>>>> servers:
>>>>
>>>>     xdr_buf_to_bvec: bio_vec array overflow
>>>>
>>>> Usually followed by messages like this that indicate a short send (note
>>>> that this message is from an older kernel and the amount that it reports
>>>> attempting to send is short by 4 bytes):
>>>>
>>>>     rpc-srv/tcp: nfsd: sent 1048155 when sending 1048152 bytes - shutting down socket
>>>>
>>>> svc_tcp_sendmsg() steals a slot in the rq_bvec array for the TCP record
>>>> marker. If the send is an unaligned READ call though, then there may not
>>>> be enough slots in the rq_bvec array in some cases.
>>>>
>>>> Add a slot to the rq_bvec array, and fix up the array lengths in the
>>>> callers that care.
>>>>
>>>> Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call")
>>>> Tested-by: Brandon Adams <brandona@meta.com>
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>>  fs/nfsd/vfs.c        | 6 +++---
>>>>  net/sunrpc/svc.c     | 3 ++-
>>>>  net/sunrpc/svcsock.c | 4 ++--
>>>>  3 files changed, 7 insertions(+), 6 deletions(-)
>>>
>>> I can't say that I'm liking this patch.
>>>
>>> There are 11 place where (in nfsd-testing recently) where
>>> rq_maxpages is used (as opposed to declared or assigned).
>>>
>>> 3 in nfsd/vfs.c
>>> 4 in sunrpc/svc.c
>>> 1 in sunrpc/svc_xprt.c
>>> 2 in sunrpc/svcsock.c
>>> 1 in xprtrdma/svc_rdma_rc.c
>>>
>>> Your patch changes six of those to add 1.  I guess the others aren't
>>> "callers that care".  It would help to have it clearly stated why, or
>>> why not, a caller might care.
>>>
>>> But also, what does "rq_maxpages" even mean now?
>>> The comment in svc.h still says "num of entries in rq_pages"
>>> which is certainly no longer the case.
>>> But if it was the case, we should have called it "rq_numpages"
>>> or similar.
>>> But maybe it wasn't meant to be the number of pages in the array,
>>> maybe it was meant to be the maximum number of pages is a request
>>> or a reply.....
>>> No - that is sv_max_mesg, to which we add 2 and 1.
>>> So I could ask "why not just add another 1 in svc_serv_maxpages()?"
>>> Would the callers that might not care be harmed if rq_maxpages were
>>> one larger than it is?
>>>
>>> It seems to me that rq_maxpages is rather confused and the bug you have
>>> found which requires this patch is some evidence to that confusion.  We
>>> should fix the confusion, not just the bug.
>>>
>>> So simple question to cut through my waffle:
>>> Would this:
>>> -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
>>> +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
>>>
>>> fix the problem.  If not, why not?  If so, can we just do this?
>>> then look at renaming rq_maxpages to rq_numpages and audit all the uses
>>> (and maybe you have already audited...).
>>>
>>
>> I get the objection. I'm not crazy about all of the adjustments either.
>>
>> rq_maxpages is used to size two fields in the rqstp: rq_pages and
>> rq_bvec. It turns out that they both want rq_maxpages + 1 slots. The
>> rq_pages array needs the extra slot for a NULL terminator, and rq_bvec
>> needs it for the TCP record marker.
> 
> Somehow the above para helped a lot for me to understand what the issue
> is here - thanks.
> 
> rq_bvec is used for two quite separate purposes.
> 
> nfsd/vfs.c uses it to assemble read/write requests to send to the
> filesystem.
> sunrpc/svcsock.c uses to assemble send/recv requests to send to the
> network.
> 
> It might help me if this were documented clearly in svc.h as I seem to
> have had to discover several times now :-(
> 
> Should these even use the same rq_bvec?

Perhaps not, now that you point out that these are two quite independent
use cases.

It might make sense for svcsock.c to allocate a bvec array for each
svc_sock that is the size needed for the given socket type. (UDP doesn't
need a record market and is limited to 64KB per send, for instance).


> I guess it makes sense to share
> but we should be cautious about letting the needs of one side infect the
> code of the other side.


-- 
Chuck Lever

