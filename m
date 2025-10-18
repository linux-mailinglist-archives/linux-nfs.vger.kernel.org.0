Return-Path: <linux-nfs+bounces-15365-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A33BED7FD
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93DE94E519B
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC9A27F016;
	Sat, 18 Oct 2025 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hl8u0YQp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l2PSEXok"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67182798FA
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760813753; cv=fail; b=bubbgCyhDm5misE861W48mvaPIbes7EvKQF5rb75wgSUNOt2JJuc44Cm2VdV7ItPNxKWXmTHEXAISRK4WTwCco2tR9tWNGS1IHD0/E11mDSQqtDJWrt2Q9aPBng7304M0Bf6puwNdsUDVy1vyXgrm/PlTmGkbwyPHVJdTjjg+II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760813753; c=relaxed/simple;
	bh=xBkMvRCtSsWawLPp6r3pFCRiOd9R1fDw6Wk/cS0XwUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lvA5GdeHbeOp2oh7M7N3VNnytIOj6gFjPedN9pp9rEgXolOaYhhlcZbBvy2CM7zEchMyQ0GgJKDo2twxFUNA95SAXFnlvGjLY7voRbd22VuiSsjmVJ4v+lfyBARxLyAanTVLQYFHh5/d7a3Fn4pOkLZ/dzczU0yjIF/GvnfL4yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hl8u0YQp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l2PSEXok; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IFdj51024245;
	Sat, 18 Oct 2025 18:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MdNigY7W5KBNq64xr5nHd5Ei1DS1+q/UgLTYyi1OII4=; b=
	hl8u0YQp5f6gLPKHRhkSIMrltNmHHWEtUlOBcVnnFMEcfJqKKC8seb2mQpiPV67Y
	E+Rz6NnQjVjfjg8EaTdILnJ/UsqKVx3VR3GmZB8f8F7J1ZRaTsGB5MVxMO8DDSBD
	v/pX55EYlnD/qxBtDRCzHy61580zL2Sa7k4xq9LEsS+lS6IRiiG8tgLqKxFrK82d
	NwbHurp4IUe2kH6gDnXV7tEDLBGohwqFZxWU9ABhdgYDc+k7iJBphNxyfUaabM2h
	GlkmtjLulDARrClGgGcvtINf12m/N5bb5eQi1UftlItUik6mz80AMaqSqoNiVn+Z
	Mf4O++DYOFq4B1jNH7lIgg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v301rfdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 18:55:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IDHZOc009516;
	Sat, 18 Oct 2025 18:55:44 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1baq5n8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 18:55:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxz6z2GlOwvSn44ylv4Tz8DvhYRMW6xUf6Dbf6GTPNtY9Rml50+QM8pI8LYlOFLddCWntv1RDpvX2hle5Mp34JTguTYTjOHHmgo3XR1Pfyupc5JPVTNfeoI17ZL6P9IjIPdjRPhVMS34v7s7XkDQ0XNVa4FSd5PNzV36OUdH5qm0IiE4CkDi0U1bPxvFEppdC/u9PGnrNUZtNUlxBgVs++bh6yg9xXRnL8ePD8Vn9dGkXfVB1U0JxD3iDA9y4KdBdJVQwuafD3Zro9QhoA2UY2dOxBuw2Mv6QrLq9O2avIJ+AbGg2B5FiSPLR1R1WcoVEdPGhA6JzPhlW3zfTl43nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdNigY7W5KBNq64xr5nHd5Ei1DS1+q/UgLTYyi1OII4=;
 b=UwEHVuygSLBAz6zFeaNZoi75nVtWI6oy9Ue6L+8n/vso/A/zS2s5ET6jjjFkVSuNTModh64TbVnhlv9LnWwRlGaT76W9rQmcNCFRSdcbOaH36aqlcLeDD61mcaChRi/ixQW1nMyVzPbxwlTDalOlyzMXVlmLBcfYHHVZHm1zr1gjEMp2ZS1lQPBBQFusg/u0l3yPgMPSEol6FQ00tbwZ9lorFE98ItkT30M+WMpUXG/CTOFQUubyKPc9rqSZVhStw9uFJAaHnQKZyMUuL8otHlF8zeSNa9nYyyjBViZBTuyqcTzqgFH6K2v0JXxvtDyPEnLlpF4wGQiP2+M6WsXh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdNigY7W5KBNq64xr5nHd5Ei1DS1+q/UgLTYyi1OII4=;
 b=l2PSEXok0ZjO4ODCXF+OP6/RhLg1VwLKGqxsGnb4O13XF0ZHecgapRqogOURV3lqbAaWm0jR4ryqiUyI9+ifbppHcO+HL/ZHh8PySSTkwSwA+OwVD8xrFqeLPhoIcJro51ZvfTCe7yMMXRr9Cu7Bz4OuLi5d/UnH+05vsByiWWs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7299.namprd10.prod.outlook.com (2603:10b6:8:ea::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.14; Sat, 18 Oct 2025 18:55:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 18:55:41 +0000
Message-ID: <83dfd9ac-912a-4254-ae5d-25536a8e79ac@oracle.com>
Date: Sat, 18 Oct 2025 14:55:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] nfsd: discard v4 ->op_get_currentstateid() function
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251018000553.3256253-1-neilb@ownmail.net>
 <20251018000553.3256253-3-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251018000553.3256253-3-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:610:59::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb3588d-e50e-4441-b5e0-08de0e77ef68
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QjJtcnlsdVJCR2ViS1cxaTJ1NGpkQTN5eDI1VGNVc05kZytxZXNzTkUvV1F1?=
 =?utf-8?B?Mjc2THpWNm4yRFR0ZnV2eGY4MDN0M3FPNEpLd1oyWW0vTE1mZURxY25Jb3d3?=
 =?utf-8?B?Sm1Id01zelN4QXUzR3F6RGNDVGcyUEhNb2xGeThueFk3dXo5NkN6bWI3WHJD?=
 =?utf-8?B?VUtBQVd0aFJIc0hTN1FsTjlKU1V3TEhuM2JrTTUxeE9DaWJXS1hOcWJRa3dn?=
 =?utf-8?B?dE9qeGV0YkRtZXVpeFBOaW8rUU9HYWFCSjlUQTNoZEFPWXdRZlhwelFqc1V3?=
 =?utf-8?B?cndRcFI1MTRmdXd0bmtmY0h4NlowaXBrU3hOM0JNM1Q4bDZmYlVWLzZVRjlw?=
 =?utf-8?B?Tk5NamJKTDhCMWt2am51WTV1dmg5aC9ONWZHZ0VpeHVwYTUvUnZhRGpoSU11?=
 =?utf-8?B?NENBTVdWcjZtVUFsemk1b2JpY3l4ajY5dmw1UUtieUVXNFV3Q0ZFK0J3bW5m?=
 =?utf-8?B?VEJRdTUzZlBuTDU0T09mZzNhTjFHQUhOcXAvTFU1WXNqYXUxczRDbmI2djE5?=
 =?utf-8?B?UVRsQjBjRDJjNlRqMXkzaGtXcnE5L25YTjh0cEdOdGYvTEUwZEVlNVZDajVp?=
 =?utf-8?B?ZkZVUnl3MmZXTys3Qmd3QXVXRUZuQkRlQ2V2bGZnZmRJWUE4Q1NkN3RwNWpt?=
 =?utf-8?B?VUd2QkFTNUZJaXdOc3RLbnFJcGJUTmdmWXB3aS9LWG5IdFRBZW52Z1IzeHR0?=
 =?utf-8?B?aWRla1VmdmF4c1UxTDhlc28wblozVFpvSTRnY3duWWkwRThER3NFOW9naG94?=
 =?utf-8?B?a3BoWWNTQ0VHSVN2T3RUcGlRWWZrZ2R2SXFZRFc2aE5qV05MazZzVnJhRGRF?=
 =?utf-8?B?YnpKdEtlVVhlckxyaXJpNkF4SWZTcnR2WHpSN01sNSt6a3FxbUhpZWw2NDNO?=
 =?utf-8?B?Ti9wQXBDampCcFMwdjNibG1XdDUrS0IvTWhRZ0dSS21HWmRIdVFQanJHVmFt?=
 =?utf-8?B?NzhTUmhMZW1jTlg4Nkp0ZmFwMTQyeVgxSXlrQjh5OUZOd1ZMUVhVazkrZHpK?=
 =?utf-8?B?V1dxQk1GNURCdXE3TzZqK0YzTitOYkZKRnZIZGVMaWlmdVd3cnI4WHdyMUZX?=
 =?utf-8?B?WVY0Y0Njb2RCWXBXdnlWS2ZESWoxWTY1VFJwWm1XY0RVWGd1LzRlRlNvQi9N?=
 =?utf-8?B?Qm9XNjkvL2VraVlIUXVscFgvRDJPUjNMUzV0K0FmbDR5d2VyV1RjTFQ2U3po?=
 =?utf-8?B?SWd2eEtBSklQa0lSUnR0R0VublhuakpPY0p6SmdjeTl2N1pUdVhSN2JVRGhP?=
 =?utf-8?B?U0ZaU2ZRTzRuaU9jbnJQMVpIYVN0QlFURHNtN0FKNnF1WHk0QzljRTFDUTNj?=
 =?utf-8?B?YWZtRmljVVBCcGdWS2dIZW5WbGFKVEV3U0VCd3FQMUpRS3oydi9HdVh2TnBB?=
 =?utf-8?B?YkpLTytGWHFlL2pqSmJBNUVNcmYvYmxnRVBqU0hMRGI4RkZhWE1hdWE4WFRu?=
 =?utf-8?B?bUNGck9HNVZBbHMvUGtIdEtlamVuZk01emJKekI4VWxzeER1OUlrd3MvUnZF?=
 =?utf-8?B?V2N5akJ5WTA2YVlJYUFtUTdockwyRnQwb0Z2NndHMlNZMDJxcFVIZTBFWEJB?=
 =?utf-8?B?TStuTEwrcnAyZi85VmJaVVpjMlRDRjJtU3R2ZHN2OU9aRXJBdldmdVhDUjVE?=
 =?utf-8?B?dWJQREZRTmdoY0VFSlR0NFcrblVwZGNIOHZ1dUhSVTZ3Sy9lRnlDMXozd0V6?=
 =?utf-8?B?Nmova0RVYXlVSnNyYVFMNUh4eVZxRXhFSS9XUkgyNi95TUNKUzg1OU45SUZ3?=
 =?utf-8?B?anNWNStQcnhrM2E3bUZJTDQvcU1oTXpNajV6bXBna0h5WXZETGIzTGNJUXBj?=
 =?utf-8?B?MHkrb3B5THVKVXhXN2lCRDRHNk9OVndudkVxbmZlZk5yWEtwVzYveUNNOVZm?=
 =?utf-8?B?dU8yWWNBS3VaaHkzZVM4dng0MEVKR0ZZRVN5QW9XK3NvSzl2QXFxbWNxOVZJ?=
 =?utf-8?Q?k6iLb9FmTqMmcRz2YAeXoM46hX7hoqKw?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a2xqMDYvL2daNllXZng2ZER0WHdaUllQeHJEbkV0elZlVVkzdXRiV3JGTVpW?=
 =?utf-8?B?ZHl2MEVIdEI0SUdrSWFHVU42WitBT0lmZWphdy9TMVlIR2xPZ0pEeExoZTlD?=
 =?utf-8?B?SGZVTk11TnA1a2RrNnFXTmMwSndtWTYrR3N1M1hjdjlkaVFvS1I5cTlKc0lW?=
 =?utf-8?B?bnlFU1J0a3NNc3FrT1phK0gxbFA1NVdQUmw1S3pnb1I3RGtLT1g5SW5NV2VB?=
 =?utf-8?B?VzYxWWFIZ2tCcG1GbnpVbytqeUdjUitjV055dCtrU1J4M3V4NXVaSzdxOTFG?=
 =?utf-8?B?ZXo1cWUyaGJ2Q0pNVXdKOFRpSU1FKzZ5N29QS1BraUk1eGZqZGtRUzA0dEVR?=
 =?utf-8?B?UjRFejc2VnpXbVNLOVRXaCtBNVZxU1dqd3RaL243eSs2d04zbzIzeEdiMVpI?=
 =?utf-8?B?eDVjalFjMjlvY1p0Nll4QWVtSmkxdDVjZXp6U0c4UnNZc3ZwbFVXZEFyRm5X?=
 =?utf-8?B?MlR3ZU1HYnpRa0RPUnFBNXB5VzlHbERJOGQ2V3h4RHl6STJMUnV1cUNLY3Zn?=
 =?utf-8?B?d0ZzN0hSYkI0SlVlVnlsTWt4K01aMmFHcUZKb3U0bmUwcDRlSVh6TnRiQzVX?=
 =?utf-8?B?YXBRcVEzWTBRWGdLc0t6WHA3OVBVYm1pY3MxNEtkVmlPM2NDSWk1ZnlXOGlV?=
 =?utf-8?B?TGlpcnRhZmsrMXljT1RRK1Qrb09mR3VLS2hYeUFMMk55V1VMSklvQlFrL0NC?=
 =?utf-8?B?Z2NEaVlEaVgrcHEyZzRrd1Q0aFdnSDNvU1UrRVQ5Z0VGaWJ3Z0w5ZmdQU09K?=
 =?utf-8?B?VTNYc0piVk1lOXNZWGZsS3pMQW42Zy94Ymo2aCs0bUU2dkNoQzd6VnlmM01T?=
 =?utf-8?B?WnRpWjQ5Y0xjbjNpVDc4dzJPem84LzFPc25yQVlLNSswWDN1WEpmR0pMV0JH?=
 =?utf-8?B?bUVwa3hwalhacWRFbVNSMnE5cVBrMitvVjJnV2tMNmxDSUhWRmZLbFJwVVBv?=
 =?utf-8?B?K1dRZUhYZFRNTk5YbllmYVRDeGlUSGtVVHFKZm4vOTVSWFkzdjNZRXZmNVI0?=
 =?utf-8?B?a2pROVRQRUdjMDRYL1JXbnpFMUVHeTZUdGZjUkhZQkZEUUlPNEd5blpQcm5E?=
 =?utf-8?B?SVREQm4xWTBFQ1BqbWQwemEzL1VNd0VodndGVlk2MU9Fb1J3ek03WFhXeWpp?=
 =?utf-8?B?Wk5uS1FkYVJUOFFWVnpzbVp3OW5YaGJJcDQxWWwwYS9aMkV2WWk1Q25KQnZ1?=
 =?utf-8?B?UGdVRFZIWnpBRitZY3hLZ1BYem1VVk13OVZQQjEyUDhXcTFlcmJTdGlYMkNU?=
 =?utf-8?B?SDFCbm9DcDg5SFdUbHdDTXUrUk43SktxZjJoS1Bka01GS1JEaHBUV3EyQW9Q?=
 =?utf-8?B?ZVpqemlEc2dzNTJyRFNnb1d0aTdJd29RSDdCZ1RvdVAwU3prdCtrSWZ6ck9I?=
 =?utf-8?B?eEI1ZzIvY1FORi9UbWNqcGIxQVRaVTR4UHhQRytyUTI2cjU0VlZnUTZkOXhM?=
 =?utf-8?B?YVI0MzkxWXdNUDBVMThEZEdCMnFKMHhaZGVzUmttOE1iMXhQVURiV0MrNk9E?=
 =?utf-8?B?V0o3Zkh0cjlXRDlnRnRMa1hUb25YeEYwckY5cE0xejFwcWhVV2YxbndqSkpV?=
 =?utf-8?B?ZFJuUm1XWVJaV1VuZStHVzhBM1Jlak1ldEk2R0Zpdi95RjFkOFpwYzdibGVk?=
 =?utf-8?B?SVVhNVZwd21OWkFQMGFBb1RZMm9vTTIzQjRzdHJzV3NLcGJ3YnJwZDdqVk9V?=
 =?utf-8?B?SVpETk5ZZEFUekt3RWdYN1JXNitoQ0IxSGxrV1ZrVTZ5MUp4a2RBZzJmTmR1?=
 =?utf-8?B?QmVta2ZTczdRTlVGc2w1RUtuTzYxcmhJRHhXMWplWWVOQm5oUWZPU1k0WHRT?=
 =?utf-8?B?SkE4VER6RmR2QUkwZlRwSzZodTRaWnBHbDBhSGR3eG1GSHFjS2dLZHZ0aGpv?=
 =?utf-8?B?TmJDTGRaTVEzKzJvRmRzMEFQSHB1MHJPZXJya0plZXU0SC9qVEVFTXY2MXdk?=
 =?utf-8?B?anRBU3NDZGQ5NzYyV2NiWC9rMVFOanJZQTJNSzl4R2haQnZyMGRnYTRSSkRX?=
 =?utf-8?B?L3A4TW81SlZraEpGUkw2VWJqSHYrQkNMWDdJcUkwNytHc2x0cTA4RFBYdlpI?=
 =?utf-8?B?ckhIMU9XQllrWXZadVZzL3ZZM3lESTcrQVBLelQzWTlrUEgweGFFd1dTeDFY?=
 =?utf-8?B?NlZTd2kwQmRodCsrblVhNGRGSjkwcUl4Y2V0dlFid1lESy9reGNGSmVERkp4?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tgpjjuxebt9n0+GM25H45Ion0Hp1Whd1unzLJVYfnchSGjQkzzaz3RihwqxKFbIVl1nEe+jwsrokjaa/zQ/yV/DEP7Y8FETuzV8LZjfzf4kmMnXZTzACg+8ZgK1VlXyFx9zp3OAHxTg5Pei0aN64bXanczJBmuFREdbuD+SddARkwZPL9soxt4sT/sh5NgKBtoHaG/OTk+xnNFaJmqcDDfVohtPMV0n+YDo/aj2OVrD1e6TL+ytt7pksbZpNKuFfBM6cuwxVgV7KkuwGtJUlS1xpVnGa50bMYNgC+LZTYTlb26Ib6UUb+S/aCUvN/UIGER0Wyg/ky5Z3G3osk2u/W8CHsCj7w9BneqODC+c3ri31vzbiUbiNTvDh1g0xj3kNwNqxJSQLRevWcwwxpOzQojP/OriaCLwrfZfyEjntoA4hW1VAU68VxqrrZBRmnSHvRjpnD1SPyMFmleMFtmrCElELrE+WoBr0GEJDk/arQHGINqWjPPLlBwh3E51/qmMRjlHjY4fD5zLwtc9lvzposzmGTihLnGKUkJIsZhsHBhps0Vu9qEJsRxikuIcm1t32tqfroCULVNwSIZewrGS3kFAksZbgWS6+xsp3rSthbM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb3588d-e50e-4441-b5e0-08de0e77ef68
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 18:55:41.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj95PPjoQ4YWRUkIF8fST6w+1JWJqN5vMf0vcNyPhMJ5QgZkyUbTac9GNpEM+sViqZyJ76VASHWeaBKykfRSqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=848 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMSBTYWx0ZWRfX1gFwaZAQ5UAf
 /Jmi7o48cTeNA6aFtm2jet6zaqjRiiT8VFCP1CIWZVI7QOgqAKU7OlV83lwS5BIX5JI98FNXXrp
 DhAAFzy56QJtUOHS4FpRZ/cAX1b5uo++V/+KOcgBpwMSmm0OUmpo9vaU78ifmXR2EHP76DOKC8Y
 WsaGGc1rcKTm5g4jhcnGbJk8+w3bpqHDvTC6XoIK6d8mXaeAld0cP4yMlkkv8t2kvlmgI0fhIlI
 dPn/xnAx+Vm7QeKbdkUhs+u/TSw89s6a95IKRAQ87pkfIdpOVfPm+Ax0JMNxkUoJwfyFaXFggU/
 regRE1Au5MnQvuPZEpatjX3z04ezR0A5KqReFfogW/VBXUQ+FHPUiToJcbNpJwV9apnGyaWgLHn
 1v7Sr4sc4wm7wnxXWUQcftX//gW62kjrtxBRCGWoilvbd2pEQUg=
X-Authority-Analysis: v=2.4 cv=Gb4aXAXL c=1 sm=1 tr=0 ts=68f3e2b1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Xd7o2BhvfMY1-3peyX4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-GUID: 6KZlBJORnkfw6WCcelrpMWW7jBdCCHgq
X-Proofpoint-ORIG-GUID: 6KZlBJORnkfw6WCcelrpMWW7jBdCCHgq

On 10/17/25 8:02 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> It isn't clear to me that the indirection involved in
> op_get_currentstateid() serves any purpose.

Introduced by commit 8b70484c67cf ("nfsd41: handle current stateid in
open and close"), looks like op_get_currentstateid is meant to bookend
op_set_current_stateid, which is removed in the next patch.

LGTM.


> op_get_currentstateid() is only called immediately before the only place
> op_func is called, so the former can easily be folded into the latter.
> The functions themselves are trivial, each a single line.  Including
> these in the relevant op_func functions works well.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/current_stateid.h | 23 ++-----------
>  fs/nfsd/nfs4proc.c        | 15 +++------
>  fs/nfsd/nfs4state.c       | 70 +++++----------------------------------
>  fs/nfsd/xdr4.h            |  2 --
>  4 files changed, 15 insertions(+), 95 deletions(-)
> 
> diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
> index c28540d86742..7c6dfd6c88e7 100644
> --- a/fs/nfsd/current_stateid.h
> +++ b/fs/nfsd/current_stateid.h
> @@ -5,7 +5,8 @@
>  #include "state.h"
>  #include "xdr4.h"
>  
> -extern void clear_current_stateid(struct nfsd4_compound_state *cstate);
> +void clear_current_stateid(struct nfsd4_compound_state *cstate);
> +void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
>  /*
>   * functions to set current state id
>   */
> @@ -18,24 +19,4 @@ extern void nfsd4_set_lockstateid(struct nfsd4_compound_state *,
>  extern void nfsd4_set_closestateid(struct nfsd4_compound_state *,
>  		union nfsd4_op_u *);
>  
> -/*
> - * functions to consume current state id
> - */
> -extern void nfsd4_get_opendowngradestateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -extern void nfsd4_get_delegreturnstateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -extern void nfsd4_get_freestateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -extern void nfsd4_get_setattrstateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -extern void nfsd4_get_closestateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -extern void nfsd4_get_lockustateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -extern void nfsd4_get_readstateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -extern void nfsd4_get_writestateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -
>  #endif   /* _NFSD4_CURRENT_STATE_H */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 9d53ea289bf3..41a8db955aa3 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -949,6 +949,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfsd4_read *read = &u->read;
>  	__be32 status;
>  
> +	get_stateid(cstate, &read->rd_stateid);
>  	read->rd_nf = NULL;
>  
>  	trace_nfsd_read_start(rqstp, &cstate->current_fh,
> @@ -1153,6 +1154,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	__be32 status = nfs_ok;
>  	int err;
>  
> +	get_stateid(cstate, &setattr->sa_stateid);
>  	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
>  					      FATTR4_WORD2_TIME_DELEG_MODIFY);
>  
> @@ -1240,6 +1242,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	__be32 status = nfs_ok;
>  	unsigned long cnt;
>  
> +	get_stateid(cstate, &write->wr_stateid);
> +
>  	if (write->wr_offset > (u64)OFFSET_MAX ||
>  	    write->wr_offset + write->wr_buflen > (u64)OFFSET_MAX)
>  		return nfserr_fbig;
> @@ -2914,8 +2918,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  		if (op->status)
>  			goto encode_op;
>  
> -		if (op->opdesc->op_get_currentstateid)
> -			op->opdesc->op_get_currentstateid(cstate, &op->u);
>  		op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
>  		trace_nfsd_compound_op_err(rqstp, op->opnum, op->status);
>  
> @@ -3365,7 +3367,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_flags = OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_CLOSE",
>  		.op_rsize_bop = nfsd4_status_stateid_rsize,
> -		.op_get_currentstateid = nfsd4_get_closestateid,
>  		.op_set_currentstateid = nfsd4_set_closestateid,
>  	},
>  	[OP_COMMIT] = {
> @@ -3385,7 +3386,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_flags = OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_DELEGRETURN",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
> -		.op_get_currentstateid = nfsd4_get_delegreturnstateid,
>  	},
>  	[OP_GETATTR] = {
>  		.op_func = nfsd4_getattr,
> @@ -3424,7 +3424,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_flags = OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_LOCKU",
>  		.op_rsize_bop = nfsd4_status_stateid_rsize,
> -		.op_get_currentstateid = nfsd4_get_lockustateid,
>  	},
>  	[OP_LOOKUP] = {
>  		.op_func = nfsd4_lookup,
> @@ -3461,7 +3460,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_flags = OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_OPEN_DOWNGRADE",
>  		.op_rsize_bop = nfsd4_status_stateid_rsize,
> -		.op_get_currentstateid = nfsd4_get_opendowngradestateid,
>  		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
>  	},
>  	[OP_PUTFH] = {
> @@ -3489,7 +3487,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_func = nfsd4_read,
>  		.op_name = "OP_READ",
>  		.op_rsize_bop = nfsd4_read_rsize,
> -		.op_get_currentstateid = nfsd4_get_readstateid,
>  	},
>  	[OP_READDIR] = {
>  		.op_func = nfsd4_readdir,
> @@ -3546,7 +3543,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME
>  				| OP_NONTRIVIAL_ERROR_ENCODE,
>  		.op_rsize_bop = nfsd4_setattr_rsize,
> -		.op_get_currentstateid = nfsd4_get_setattrstateid,
>  	},
>  	[OP_SETCLIENTID] = {
>  		.op_func = nfsd4_setclientid,
> @@ -3573,7 +3569,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
>  		.op_name = "OP_WRITE",
>  		.op_rsize_bop = nfsd4_write_rsize,
> -		.op_get_currentstateid = nfsd4_get_writestateid,
>  	},
>  	[OP_RELEASE_LOCKOWNER] = {
>  		.op_func = nfsd4_release_lockowner,
> @@ -3653,7 +3648,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_func = nfsd4_free_stateid,
>  		.op_flags = ALLOWED_WITHOUT_FH | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_FREE_STATEID",
> -		.op_get_currentstateid = nfsd4_get_freestateid,
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_GET_DIR_DELEGATION] = {
> @@ -3718,7 +3712,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_func = nfsd4_read,
>  		.op_name = "OP_READ_PLUS",
>  		.op_rsize_bop = nfsd4_read_plus_rsize,
> -		.op_get_currentstateid = nfsd4_get_readstateid,
>  	},
>  	[OP_SEEK] = {
>  		.op_func = nfsd4_seek,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1e821f5d09a3..18c8d3529d55 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7487,6 +7487,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfs4_client *cl = cstate->clp;
>  	__be32 ret = nfserr_bad_stateid;
>  
> +	get_stateid(cstate, &free_stateid->fr_stateid);
>  	spin_lock(&cl->cl_lock);
>  	s = find_stateid_locked(cl, stateid);
>  	if (!s || s->sc_status & SC_STATUS_CLOSED)
> @@ -7707,6 +7708,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
>  	dprintk("NFSD: nfsd4_open_downgrade on file %pd\n", 
>  			cstate->current_fh.fh_dentry);
>  
> +	get_stateid(cstate, &od->od_stateid);
>  	/* We don't yet support WANT bits: */
>  	if (od->od_deleg_want)
>  		dprintk("NFSD: %s: od_deleg_want=0x%x ignored\n", __func__,
> @@ -7781,6 +7783,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	dprintk("NFSD: nfsd4_close on file %pd\n",
>  			cstate->current_fh.fh_dentry);
>  
> +	get_stateid(cstate, &close->cl_stateid);
> +
>  	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
>  					  &close->cl_stateid,
>  					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
> @@ -7832,6 +7836,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	__be32 status;
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>  
> +	get_stateid(cstate, &dr->dr_stateid);
> +
>  	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>  		return status;
>  
> @@ -8575,6 +8581,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		(long long) locku->lu_offset,
>  		(long long) locku->lu_length);
>  
> +	get_stateid(cstate, &locku->lu_stateid);
> +
>  	if (check_lock_length(locku->lu_offset, locku->lu_length))
>  		 return nfserr_inval;
>  
> @@ -9066,7 +9074,7 @@ nfs4_state_shutdown(void)
>  	shrinker_free(nfsd_slot_shrinker);
>  }
>  
> -static void
> +void
>  get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  {
>  	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
> @@ -9120,66 +9128,6 @@ nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
>  	put_stateid(cstate, &u->lock.lk_resp_stateid);
>  }
>  
> -/*
> - * functions to consume current state id
> - */
> -
> -void
> -nfsd4_get_opendowngradestateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	get_stateid(cstate, &u->open_downgrade.od_stateid);
> -}
> -
> -void
> -nfsd4_get_delegreturnstateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	get_stateid(cstate, &u->delegreturn.dr_stateid);
> -}
> -
> -void
> -nfsd4_get_freestateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	get_stateid(cstate, &u->free_stateid.fr_stateid);
> -}
> -
> -void
> -nfsd4_get_setattrstateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	get_stateid(cstate, &u->setattr.sa_stateid);
> -}
> -
> -void
> -nfsd4_get_closestateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	get_stateid(cstate, &u->close.cl_stateid);
> -}
> -
> -void
> -nfsd4_get_lockustateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	get_stateid(cstate, &u->locku.lu_stateid);
> -}
> -
> -void
> -nfsd4_get_readstateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	get_stateid(cstate, &u->read.rd_stateid);
> -}
> -
> -void
> -nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	get_stateid(cstate, &u->write.wr_stateid);
> -}
> -
>  /**
>   * nfsd4_vet_deleg_time - vet and set the timespec for a delegated timestamp update
>   * @req: timestamp from the client
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 2a347c1bc3e7..b94408601203 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -1043,8 +1043,6 @@ struct nfsd4_operation {
>  	/* Try to get response size before operation */
>  	u32 (*op_rsize_bop)(const struct svc_rqst *rqstp,
>  			const struct nfsd4_op *op);
> -	void (*op_get_currentstateid)(struct nfsd4_compound_state *,
> -			union nfsd4_op_u *);
>  	void (*op_set_currentstateid)(struct nfsd4_compound_state *,
>  			union nfsd4_op_u *);
>  };


-- 
Chuck Lever

