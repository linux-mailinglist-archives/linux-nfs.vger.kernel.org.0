Return-Path: <linux-nfs+bounces-8010-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6E89CF343
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 18:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A47DB3B184
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9DB1D63E9;
	Fri, 15 Nov 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GKl0JREf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y9AgDXKW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8A18E047;
	Fri, 15 Nov 2024 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688814; cv=fail; b=XfhjDWuFfPcm+0SZjNgfCFDk+nQJzkfHhv0VZx9ZU7tngzVd/S2bBd2Y1aJhrY+riXtULj7NIL74RRwzybkoxmdMvQzt2YAGQmXV2SBf3YOx1D44ysdadHjKDmJr9qZkP7xho3+bsJJag82wpzMql2lKhw3ElL6WdFV7rFuC53Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688814; c=relaxed/simple;
	bh=1qoWYLLcENaX0ZThGVox5vov9dBOOgCU8Q0WlUhEyKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tynulEJF/OIq8s/LlQjc/A3+O46KcLNkvLC0r8MTnfjPHnYhRPbJXNdZvKbzdUwbb9rsLm9HBRfJ/EbrhDLtNcnZSe/++rXj4Xp3d3OCyFe1kKGmU+CbeYxoWFaQYPIeV9Caui/8j1gtObg1WuS/ove540+ZOOrUv2ryXApJ3OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GKl0JREf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y9AgDXKW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGMkku022995;
	Fri, 15 Nov 2024 16:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DQWN1RA3iPGOaoDq38ewyBp/sgc/dKbfH6KrpIOZeok=; b=
	GKl0JREfS/YYt/SBRA2o8PB3sCspV7p0jyAer3Sl6501keZ+sIQ93mNd0IkniJWP
	Oy0pTqC1jgNAFRlsbbKZYEcwJNfp5QLsZfC4WraSbFV/DnPCAbyI7fYkpc2864bC
	Yv4K/LMaSGGs/KD0ecme0P7Y8JwICXVqwA+g9ojMda0aFrkEXim9g3hcCCQJkMaH
	TK5EI/G8r/c0AmOlOHzLgNBah9ZdFsMPQ52aan+cXWsD82K4YvcoMH8xsg0XGynh
	y+e4Kbk1IX2JW29faVUjnzaLvGVuIhqi+0pp7QLwVfp72nv/2u7JfU/3SOP4JvLx
	xPAA0XMxl2ZcJ9go3E1R2Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwut5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 16:40:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFFCwpr025856;
	Fri, 15 Nov 2024 16:40:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ce875-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 16:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsqI0NAZKMWzB0BZmQcXc7EVm2JSr/NtUk4Fayvlm2y6Hh/VUZOJQV5NKTNuctIWK1n3pch9xghdFFaLvpY37jeQBEt2JXpWWFOLjTUMXrH3BYMJJzanf1cQz4ULQc5mxCXK9lT8xrAzuGfNZuuARTnHkK77lFXxoG/WfV6nqeXbWXHTzZnt63FAeI4m6Qu0AGmD8G1kDkxPLgzGYBT+00X9Nt6bV5N8SJwwE09MNFiM7ob3RCfjpOGhMF6MMOB1MpXPx6vQlhGCyF/uvSJCQ+kiVSab8pr8sVXkvEtUAy0vOgwf+yPkCNgyQBEGwuWeeSvpoplODZjer7c46UjACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQWN1RA3iPGOaoDq38ewyBp/sgc/dKbfH6KrpIOZeok=;
 b=FN5dLeJWlqEXUSexyOaykbWCz0xuZLAuPOwdODe726pChefqevdksu7c0OMoqkWCA9z/DEgUTiZ75eOLetPvkzcoEscoTiwbfoz8/l3dgQfEk0p7QEv8KLi0Tk3CZQD2maBt0OEPaoVOXr4sCv3Rwr9EF3IlkjYzlvos96VN7KDZ74U/7GaKperSeOg7EoegkVT5xMGWH2nPvMs2eBJLwswamwCfKReOBtisSpVxzIjR36i2egWe1YHZ5yaHot25F0aMMzmttDllq+4j0aMGL843Oq3sllpTe/s2YUztjH7aIZz80lct7be23ZiSMGnAnwghOoZ/eFC8PIFCyNsM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQWN1RA3iPGOaoDq38ewyBp/sgc/dKbfH6KrpIOZeok=;
 b=Y9AgDXKWmPh01E8fgJQ1LjxVVhlhyPtfYu4vmLVtcxkMOdExSp1pu3Fhm2gi6uQ7ojMXwIyNtcuBtgNUuNgJdaECMoe33uBI5yYwwmIVugvMdAi5EGgOo6zX24oNg/jYNcWCOHA45B2Uj29NKj8sm4/N1s3+XrHncmMLZu3Kp04=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8194.namprd10.prod.outlook.com (2603:10b6:610:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 16:40:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 16:40:04 +0000
Date: Fri, 15 Nov 2024 11:40:01 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, stable@vger.kernel.org,
        regressions@lists.linux.dev, linux-nfs@vger.kernel.org,
        hughd@google.com, yuzhao@google.com
Subject: Re: tmpfs hang after v6.12-rc6
Message-ID: <Zzd5YaI99+hieQV+@tissot.1015granger.net>
References: <ZzdxKF39VEmXSSyN@tissot.1015granger.net>
 <Zzd12OGPDnZTMZ6t@tissot.1015granger.net>
 <CAO9qdTGLn6QWJg71Ad2xcobiTHE5ovoUxSqvrDDrE_i1+uqUQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9qdTGLn6QWJg71Ad2xcobiTHE5ovoUxSqvrDDrE_i1+uqUQw@mail.gmail.com>
X-ClientProxiedBy: CH0PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:610:76::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 210005a2-5e8d-44b6-1df7-08dd0594281e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDczNXREZStRNmx1RzlJODBydmtDRVhydUcvWGF0SnE2WDNySFZuWmNpUVZ1?=
 =?utf-8?B?OTkrN0xSOWpEc2w3ekZFdFJJeFdtRTA2YjZiQ0NGNCtrZURKaHhVU09leG5E?=
 =?utf-8?B?VFYwQW9wbEdkM2drNGZtMFRoVEJLaGd5alpXdGhYVlVtNWcyRXp2NEtCMHhx?=
 =?utf-8?B?UzUzditHaktlSVordWxLZmZHQ3NlM1BoNjZmK1hmREQ5M0JZSXI5MmhYdDJq?=
 =?utf-8?B?bkhZSElIajU4MWxWNzA5b2hxWFYxWHB2MEVkaXd2QkVnVTdCS0t4Zjl3SzFq?=
 =?utf-8?B?ckptNk5wWUd6ZWdjNm85YXMzVW1xUmJEL3V5TkF3cU5MTVBDbzJ0cWVQQ2pK?=
 =?utf-8?B?ejZYcXZiUHUzVTZ5dDV1cWhZUVRLSDU4YnArK1RXbFB2MXFJOEFUeW5mTTg0?=
 =?utf-8?B?TXZLdlVkd244VnVJdm5NWkNXN2JrQ2ZFdGlYcWJ4dlI5VlJOMGNQS1ljQUFr?=
 =?utf-8?B?ZlBvT2dRNUtoQTV0dGNkVms0YzBzVHowOG9Sb0VHVEtzY2MxQ29INnc1cVlv?=
 =?utf-8?B?bnUyYlVFVGpvalNYRVRyT1lCTHZSWDZrN2lqUnRlN0dDdEk2TzVEaHBvTzVF?=
 =?utf-8?B?a2todmZ2ZXVubXlzVXJESFl5bWpJWVJPTzNOS1ZaOFFJQUQ4bDY1Qkg3UllQ?=
 =?utf-8?B?c3dva2czdWdYenAxVHFjdmNqMUc1WkFWMFBsazhvS01La0NVRlBveGNPWldE?=
 =?utf-8?B?eXhEdDNwTHBnaVdyYmVLNG52dXpVYTNDRVZpcVU4SXBPMDFjc2lMZzE2cWtV?=
 =?utf-8?B?Z3A5V1dsKzk4Q3RZdGh5NmpWSW9WZUxWc09tUEx5L21YL3Y2Q2VQcldSMkE0?=
 =?utf-8?B?VHJtL25XRnJ0RFp5K3lzVFZ4Z1A2OTdlTS8wcXB2Z2dqSEZHUGVDN2JOekpj?=
 =?utf-8?B?SUJNMFduMVpFNHVoZUlSVlE1Tk9zYmtxb1d0TDhWcW1SU1VqOUE2VTF6dW1t?=
 =?utf-8?B?NXYzaXVaRHQzZjVrYjltZ2FTWnRHdHFkNEV2ZUU4Zkkyd1BCU2JmUW9xeG9P?=
 =?utf-8?B?dWNzYnliZU1NUU5QSW9Dd3NKZnAvZHpxdWVDTVF2WDAwWTN4bVFCQ0xBckl3?=
 =?utf-8?B?ODdLQVM1bEpMcjdITVd4bjVJOVZrblluK2I0dCtLcS9CdXNsQ1hWTUFmUTNp?=
 =?utf-8?B?RXJjTEdwM0hHRFZOSzlTVUpWUnB2OVJmVkpnZ2kwMFErNThYeVViUDBZd21m?=
 =?utf-8?B?eVNmS3k5UGtLczl0bHZyMlAxeWpkajRHamZ6cWxMMk14UTg1RmtqTkphUUFr?=
 =?utf-8?B?eU1DY0hHZzZNTUs2dEdZbFFHMXBIMTBxc1dsQWdFUTcyc0E1NjNtUGN6Uzgx?=
 =?utf-8?B?eDJmOHFYOGVlUVZsUzEzcWxSTXJaOTFZTDZIK2R1SGgybkhiSnVhNUY3RVBV?=
 =?utf-8?B?NWdmSG9tcEVVK2pJNjc4TFRiWnUwTUV0dGF0Vzd4Y0VsUExoR3F5dVhFNWNY?=
 =?utf-8?B?SmpWNnVvRXRxdHROOUhjZ1NxeWI4Ym1oVGhDSGt4Wk9wLzNRSWdZRnVla3BB?=
 =?utf-8?B?MGF4SzZLOXNBMnAraHh3NUQvNThLWlB0dytoUUJpalRKVHFETy80bmFuR3VS?=
 =?utf-8?B?SkJqVUllaEYzY0I4UDEwbDVYV25NTVFoTkJONUVsZHB3REZ5N3JIcXpUN0dX?=
 =?utf-8?B?N2JVMHZ4ajNEYklKbkJVU3BIWmNBNWsrRlhQeU5hUEFhVkdqSmpkMlpFd0dv?=
 =?utf-8?B?Tzd0d2x4K0grYi9yckNrR2YyVjFmUmNvYWdVd2VRVHk1SUpwTXlWY0VOYVpr?=
 =?utf-8?Q?dsx0rcnud9fuyKHZYGYGjySNTVNtoqfVfd1z5oR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEg4K1dmZUtPSTk0U0tJOHBVM1lqNDE0YzdtTFArSDFYVVV5TDNncHI0d3h4?=
 =?utf-8?B?czVHWjltbm4rMmZHTmJHR1NrV2R5UUVWcFBKTDh4UURHVXc1c1huQkkrbld4?=
 =?utf-8?B?eWovZEthVG9NL2xXaTR6d2lwTkNWVHpVSHMrREkwRW9BV3JmbURYc0VyVmZk?=
 =?utf-8?B?d1dqd2NuN05hY283UUMrMGpNZzB3bTd0K3QzM0dhbjJwVzZTM0pSZklhVmdl?=
 =?utf-8?B?NnVUSlBEREhyZSswRWNQUWJVL1RGWGw5em0rVTJTaWJEbW9HT0JwUkIyOVVj?=
 =?utf-8?B?NXBBSkZlWlYySUt5VWdLbXpDNXBYZEpZSE9KeG5KVGRFT2x4YWx1VmdZbFhO?=
 =?utf-8?B?di96aWIzcWc4Rkt2Mi9ET2lzU0RmM2E4cEJtOWFBcEhlTDVYZU14UC84ajFL?=
 =?utf-8?B?bWtYU0RGa0RzNjNHeFBsQlhWdVB6MWFIeUczYThwM3AwK3U4akxxVmZIYmEz?=
 =?utf-8?B?cXJKem5reWtpNlYwU2JJNWhvN1pPb1I4RVlGNnoybllSSXV4bnk0Z0tDNTRZ?=
 =?utf-8?B?Tm1GeU96K09IaGVRSmFrckMxK2NjSGlaZFFyVHNJa01KaTcxckJGbTljLy9Y?=
 =?utf-8?B?V1pOTHpwWmNHT0UwTWI1UEczM0R3ZlViTGdRdXMzWWUwMjRSNVpINDZZZXRM?=
 =?utf-8?B?MzMwUW5YOEd5VVYreWRKWHZqZFVQbGdvc2ZKcDlkb0xpTW9EeU1RVGk4TzFC?=
 =?utf-8?B?RERMTXJUbzlVYnZjbGg1ZHhlSGFScms2QW1WZHA1bVRQcmRUWlNGWWpIUUJY?=
 =?utf-8?B?Z1pBVllWSE5BQ1luOHhibzEwNGVwOGluV0k4Mkt4aDErN2tqb1paMW9MK1Z5?=
 =?utf-8?B?TGdBZ25mYkJLRDI0RHQ4OWY3bHFXa2NHYWpwaG0wblZITEMzeGhpM0RiYnpJ?=
 =?utf-8?B?NUhVdjhFaVdpRThHcmpUL0FJMzNDS3A1b2xZK20zVGNvMVBCLy9LRnBPVFVS?=
 =?utf-8?B?U1VtMkJwcTdZQlNtcWtZb0xRNnNXQWhQbGZTQjQxSlhjUjZNZi9SR1dQRHpS?=
 =?utf-8?B?WE53M253Y3czUzd3NkF6bi8zWSswcm9aNkV0NTlYV3dEZzFxV1ZsaGNFQ3B4?=
 =?utf-8?B?NWwyQlVZT3dEb3B4S2dlcGcxVWFUdUpSLzVENnFwcGdab2RPS0lKcmxLNlA5?=
 =?utf-8?B?eUdEdWw5OWlhSWc1L1ViSVIwSHI1K29PTEdEdEZUa1pobkRRREI1bks2WmdF?=
 =?utf-8?B?TEpBbUhsaHBMRE54YkdYOXpmYkU0TjZXczF5a2hLTnQ1VWNjUU5PWW5TblRu?=
 =?utf-8?B?MHprU3BnaVY0TUtQNStidVJEZW5YQXhpUEVKV2k3Q1pJZExQWHE2alMyU1pn?=
 =?utf-8?B?MCtiYWg3NE90NW5DV0lLK0dTT3g1U0JOb3czNXIxNE5iUG1MMFl3M2xVZWVZ?=
 =?utf-8?B?amhkc1MzMFV3M1kwb3FGaU1GWW1ZcUpSSVJHM0U4WlY1RGZlM2tEaTIwY2pt?=
 =?utf-8?B?clBicW85QkNVSElaVVJkNXBjcnQvSitTYzh5dVhsbVZjRzY1U2locjFNMENr?=
 =?utf-8?B?RlU3L3dvUUlOejNxUEgyRi9haGxMSnY3Z1p2cFhyVnB0Q3BjbDB2MGYxa2dG?=
 =?utf-8?B?RFJROGNaSFQ0NDNHUTl6Mno1d3psWExmakhkeVp2WTl3ejNxcEwxREp3MTFh?=
 =?utf-8?B?azJ5d3d2NFJuQzZqV2U3RzMrQ1UrdVFlV1BQZDhhcUQrZTg2TWFRQ0NORmdU?=
 =?utf-8?B?dEthZlVWTktOTHNaTk9Qc0hLZUl6Mk5DUnBDRTZlMS9nTTV1VXNOaHF6a2k2?=
 =?utf-8?B?QXZjN05ENG4vZWVSWU1mUjBjOWdSNjZOdTVwZjRPcGZqdWcyOWpLYzNBQ2ZX?=
 =?utf-8?B?SWp5V0kzclVWME03Mmc4bDJnMEQ5ZjRJVUVqZmtGWnp4enl4U0loT3Q4R0hP?=
 =?utf-8?B?OTMxOXNRUk1GVTZoTk91K1dJU1RKYTFmV25iUHBWdHpKQkVpL2ZZeUhFRFNK?=
 =?utf-8?B?NU9VL0c3Uk5rK2VZWlFPVUM4TEd0YzBxRlpYVXcvY2gwb2NLanVQdi9sLzRo?=
 =?utf-8?B?eENnWWVpcVovNXM0WFhZb01xV0h3c0VnRDBKZGFSdHVNNTAzbU1qY0FJOTZu?=
 =?utf-8?B?ZjAyK2lKS1l0eVNIcm4zelVRTUNWc0xXcUY1ejJjN2lIWEpDWU51NS9OT0VV?=
 =?utf-8?Q?TL9da6zkj/g+r+lQVEUi01DZi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8rApPL5v4xoOqPgCOqludmySgXkys0tmQIYUrtY4EbscwsuXuWpOSaJ75whu2Qasp1WvEH27U6oKCTFOOVvalFNaZCZ+wJssHrO7Ow8TXMDTf9D95bl3xC0rT072HY11e5UqNU9ifRLCtHcqDcLga5dR0qOagmYe6EWET/iBe8wSFdHotrMCRIhK84WKy5ow/C6NQwu3EHrcmyYrXoiZ5Y53Xcx0laI+/1ZfTPXiHAEZU/8tcpjPcgDdVpa70txqVxBJCFvHxl/9/U6G3cEaY0vQOwhUVXdaKZVKaoPAVWjTi4YS3uELZZ53OtCED1kPQcq0LwSAuqgE1b2BCl0H0s2UlU7CMfDtPLwpk6r70YxggEzz4BIBI2Z5uNCncPah9rstrrKfkSN6VOd1ywBxCuXp83QVGDc/X30luA+eF3mLQBz/+d0vcHBYTT15D0NS9kWV4eYjNj3khMS+guq9j0IQ5rYqqcpUmFIxPliDkuTlOGvxRmdaa5seylPAKZuo/byhzojP3D0b1DUpQyTZ8UQfZHedTNa/bu8ckFO3F8S58zM2z2XVMKkMVU+aeXMzSbdFdVQ9P6npdzOQjp87fc41X9HP/MstWeMpgbPQDg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210005a2-5e8d-44b6-1df7-08dd0594281e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 16:40:04.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed15i8c1Vmdutuc3VWRj/SJA6UnjuoEK9hDIQknLQYZlanb3FbMHdKLcI5Uqr58yy2InxaFPjC2xHcYUvyUozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_03,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150141
X-Proofpoint-GUID: GOPlvEMh_l4M-aTogPGRgyB1b_l0xe6E
X-Proofpoint-ORIG-GUID: GOPlvEMh_l4M-aTogPGRgyB1b_l0xe6E

On Sat, Nov 16, 2024 at 01:33:19AM +0900, Jeongjun Park wrote:
> 2024년 11월 16일 (토) 오전 1:25, Chuck Lever <chuck.lever@oracle.com>님이 작성:
> >
> > On Fri, Nov 15, 2024 at 11:04:56AM -0500, Chuck Lever wrote:
> > > I've found that NFS access to an exported tmpfs file system hangs
> > > indefinitely when the client first performs a GETATTR. The hanging
> > > nfsd thread is waiting for the inode lock in shmem_getattr():
> > >
> > > task:nfsd            state:D stack:0     pid:1775  tgid:1775  ppid:2      flags:0x00004000
> > > Call Trace:
> > >  <TASK>
> > >  __schedule+0x770/0x7b0
> > >  schedule+0x33/0x50
> > >  schedule_preempt_disabled+0x19/0x30
> > >  rwsem_down_read_slowpath+0x206/0x230
> > >  down_read+0x3f/0x60
> > >  shmem_getattr+0x84/0xf0
> > >  vfs_getattr_nosec+0x9e/0xc0
> > >  vfs_getattr+0x49/0x50
> > >  fh_getattr+0x43/0x50 [nfsd]
> > >  fh_fill_pre_attrs+0x4e/0xd0 [nfsd]
> > >  nfsd4_open+0x51f/0x910 [nfsd]
> > >  nfsd4_proc_compound+0x492/0x5d0 [nfsd]
> > >  nfsd_dispatch+0x117/0x1f0 [nfsd]
> > >  svc_process_common+0x3b2/0x5e0 [sunrpc]
> > >  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > >  svc_process+0xcf/0x130 [sunrpc]
> > >  svc_recv+0x64e/0x750 [sunrpc]
> > >  ? __wake_up_bit+0x4b/0x60
> > >  ? __pfx_nfsd+0x10/0x10 [nfsd]
> > >  nfsd+0xc6/0xf0 [nfsd]
> > >  kthread+0xed/0x100
> > >  ? __pfx_kthread+0x10/0x10
> > >  ret_from_fork+0x2e/0x50
> > >  ? __pfx_kthread+0x10/0x10
> > >  ret_from_fork_asm+0x1a/0x30
> > >  </TASK>
> > >
> > > I bisected the problem to:
> > >
> > > d949d1d14fa281ace388b1de978e8f2cd52875cf is the first bad commit
> > > commit d949d1d14fa281ace388b1de978e8f2cd52875cf
> > > Author:     Jeongjun Park <aha310510@gmail.com>
> > > AuthorDate: Mon Sep 9 21:35:58 2024 +0900
> > > Commit:     Andrew Morton <akpm@linux-foundation.org>
> > > CommitDate: Mon Oct 28 21:40:39 2024 -0700
> > >
> > >     mm: shmem: fix data-race in shmem_getattr()
> > >
> > > ...
> > >
> > >     Link: https://lkml.kernel.org/r/20240909123558.70229-1-aha310510@gmail.com
> > >     Fixes: 44a30220bc0a ("shmem: recalculate file inode when fstat")
> > >     Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > >     Reported-by: syzbot <syzkaller@googlegroup.com>
> > >     Cc: Hugh Dickins <hughd@google.com>
> > >     Cc: Yu Zhao <yuzhao@google.com>
> > >     Cc: <stable@vger.kernel.org>
> > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > >
> > > which first appeared in v6.12-rc6, and adds the line that is waiting
> > > on the inode lock when my NFS server hangs.
> > >
> > > I haven't yet found the process that is holding the inode lock for
> > > this inode.
> >
> > It is likely that the caller (nfsd4_open()-> fh_fill_pre_attrs()) is
> > already holding the inode semaphore in this case.
> 
> Thanks for letting me know!
> 
> It seems that the previous patch I wrote was wrong in how to prevent data-race.
> It seems that the problem occurs in nfsd because nfsd4_create_file() already
> holds the inode_lock.
> 
> After further analysis, I found that this data-race mainly occurs when
> vfs_statx_path does not acquire the inode_lock, and in other filesystems,
> it is confirmed that inode_lock is acquired in many cases, so I will send a
> new patch that fixes this problem right away.

Thanks for your quick response!

My brief sample of file system ->getattr methods shows that these
functions do not grab the inode semaphore at all when calling
generic_fillattr(). Likely they expect the method's caller to take
it.

I strongly prefer to see this commit reverted for v6.12-rc first,
and then the new fix should be merged via a normal merge window to
permit a lengthy period of testing.


> > > Because this commit addresses only a KCSAN splat that has been
> > > present since v4.3, and does not address a reported behavioral
> > > issue, I respectfully request that this commit be reverted
> > > immediately so that it does not appear in v6.12 final.
> > > Troubleshooting and testing should continue until a fix to the KCSAN
> > > issue can be found that does not deadlock NFS exports of tmpfs.
> > >
> > >
> > > --
> > > Chuck Lever
> > >
> >
> > --
> > Chuck Lever

-- 
Chuck Lever

