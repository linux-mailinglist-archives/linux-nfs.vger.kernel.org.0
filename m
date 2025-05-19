Return-Path: <linux-nfs+bounces-11821-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBFDABC8BD
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 22:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB27171701
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 20:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F421A92F;
	Mon, 19 May 2025 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+Q7KvON";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mnIEGTL2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F821A94F
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688047; cv=fail; b=l9peGBELYhAhITwN72rmVgQPaP+U1wAIpqUgf3lBlf/pgukMiKo1VLGS6mrWzLF0KgAb2v8PBiNhzJGvYIK9CGsfIGIoc0Mn9kWKzNKJ5RM4YlmjyabXeoitbMxPlcxYTGV1s6SGjvSHwWa3RdaP7qe+8N+C2U7mdr/qIzAhiao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688047; c=relaxed/simple;
	bh=s6G67T+Kaw7I6R0tJEzpAINOhA2gowsper/s/MmboAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bMRaCWqthYFjSO16Y+ryHCu84+7AuMq3reIJYVFasfUQjaXLlAo8SIoP5J5ko4d8d+JO/RjqnxyL1U1LZKh6lc0pM1Toy6p6htuZZw0TjdTQ+W/dUkLXcp7J6G8iEfwqicwQHCepTXTTsmGOr0L3k8C6weAimqu1N3uOeY6sWJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l+Q7KvON; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mnIEGTL2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMucu028893;
	Mon, 19 May 2025 20:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3zY++JIlDygjm9AiYaI6kEsT96eI5zIu6L60IvV/utc=; b=
	l+Q7KvON18wodsshCeePZ0NHBK/ubb44yBbYwNSnUY7ImUOvMpdFvEOKlwpCzZra
	9i0kBw/F8OlFPO+w1xuHEPKGIDs/VixmbcnC8aRD45G+5LEuxslrbH5GXMKWzfE9
	+2eHVjBQ0EAag2/4wlZXCHEBQlsnWhki2lU5C6AgsjpoCOcyPyWX1Le20x8NOIM9
	dBvyZzRSjPKon5Nz5L1m7K3y36y/Oyza7GcUrxkKcHjx+XBmRt28fGy3zeMvavlV
	+H6CCwoRIwbjqRV0jeO+wzS5JptD1PadywOWQ7kVTRf0tRkzhUHdXo9elBbyd1w8
	kzaAwfLvnxUVammmj7wXSg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjbcuwac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:51:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIo2sk017407;
	Mon, 19 May 2025 20:51:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7e2f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0P/qIaSUzLONwk2IM9RY43VL7NgU167zeNCRzN3E/Y3HjTBWMcQdpTiV8LVlcFQ0nww6/NFx0ZWNsI1bHie7+26xsRfZTk47MFIUkXN8ODb9lkmx+7/GIWoLqyTybRopJN9I3OPjvpdedEJ/RzXJ0Ns8BsZJhRdeCpEH17a7zc5m4SmekcWWX8bFE8GrWu4i7Vz88XWLRR8/comsOLG6IzIZ8Nofmj4AZ7LHxTB2z6rPt+xlWtOlj05Sn6aqo1Gg4IdTcnX9ZXc/+fdFdc6T6BIiWg6Ha8PnS9PFPclADe7dG0ZibfTldE7cPivEvJZRcKSDcFsi9Mao296Gh+7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zY++JIlDygjm9AiYaI6kEsT96eI5zIu6L60IvV/utc=;
 b=iXZtStPRjY/ZNZ67JCyCTV1NAcjdhOUbrL4Tp88QEz43at293p0GXJkZpq2Jf4+BrcanMF18lSN9kCuZbnwJF9or2prPdFQMr1GHTNzN2gn2toyiRDSEecttceSGMWHixcKGuk3nx1LtoorExyQXikEk9LCgLpYAZSZiZxWLNqxZpNTcn8o2lD/xCaQzMK59kKfOhRCvEL8dMj8oqX/jdxu8foM6kEu3tgIJm2eSkL4aH0dHXN4kG2bBMBtRBhwCD031RSz88DXhy+/Seeqlz/Gmnr1SYSOpVRI0Xsdik2cuvKKvS9+S04IXu8t+XS+YoTTG9bSkGUJt5ybxk4nq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zY++JIlDygjm9AiYaI6kEsT96eI5zIu6L60IvV/utc=;
 b=mnIEGTL2xOuF8dnYFsK+GWOfgprimKrZ8mkuCAoWfAzwCbT23ttvbI8+DfFCWhGeNbBGnYRpibAKGEcIvITLac/LsImDxnj2OUBbVXo7DrW38JAQ9A5ARoNJ+m6zUqpHUMplgVfzPpTgLrmHyYi5/Yt8YSUoUBH6dNNJOL45Ps4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPF1C5E69607.namprd10.prod.outlook.com (2603:10b6:518:1::78c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 20:51:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Mon, 19 May 2025
 20:51:47 +0000
Message-ID: <d61fa10a-4c13-4c4f-b922-da541a7a1a1c@oracle.com>
Date: Mon, 19 May 2025 16:51:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Rik Theys <Rik.Theys@esat.kuleuven.be>, NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
References: <> <02da3d46-3b05-4167-8750-121f5e30b7e9@oracle.com>
 <174763456358.62796.11640858259978429069@noble.neil.brown.name>
 <780a7e7a-b8c4-4ebf-ab79-d1480afb6b6f@oracle.com>
 <4bee9565-c2a8-4b90-be57-7d1340fa9ed7@esat.kuleuven.be>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <4bee9565-c2a8-4b90-be57-7d1340fa9ed7@esat.kuleuven.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:610:53::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPF1C5E69607:EE_
X-MS-Office365-Filtering-Correlation-Id: 557e1516-4129-4880-a43c-08dd9716f859
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YjVnN0VpYjkzb1lSaUpQSHVuMTBsRi9vQjN2SzUvV3U4MmpoaFNhMDZydFI3?=
 =?utf-8?B?RzNDNmlGY2pGcFZKYzZoTXVEOWxaNm1IWFp0WGFuVlAwN1VMK0tFUVlQcGp2?=
 =?utf-8?B?K2RQR0tibXpCQ3BxTlR1UEdrOXkrcDFFRWs2V1hvT0xMZTc1UWZXVUV2WUhk?=
 =?utf-8?B?bTJpNlpSN0ZRRzk2R3ZELzY1Z1haSjhGcG5wRktDNTFtMmp5VWhXUXdveEZB?=
 =?utf-8?B?Q2tMSjRtRmphNEt2emxwUmthakg2WndYbEtDeDJIbklpQzhIakZiMUorRHY2?=
 =?utf-8?B?SVNSYndoOWVJdG1WY3BDMXhPNzEwaFI4c1pTaDFNbGdQQTh0cjZQRVlwZ0R2?=
 =?utf-8?B?SkVkbTVLMjBYV2FtWmdNelkyWWxva1BsbmpVcjBrREJWNWQ5NC9YT1Q2SFJl?=
 =?utf-8?B?NjBsVGdoSzVlODAzZ3haV0pIaURBQzVQMnJTbXRkd1dBbHFBdW1HYXFISHYy?=
 =?utf-8?B?N3pDaVZMQXl5R1U1VmplUExEbnYxUm54ckNNNFlyK2VKT1psb1RaV1ZWazJp?=
 =?utf-8?B?ZWJOdHpqNUZralpyRDRLTE81U080UENwcTBlMUNHeUN2OUE0VDd1K1A3T0dK?=
 =?utf-8?B?TVZQdzg2VUc4MWlGTFNjL2NrRTB3YWlZREg4R0x5eFpZc2J0QVYrNGxYcXZB?=
 =?utf-8?B?M2VJWXQwUi9VMmd0dnJZbDl2ODB6NEdWTXpKd2Z2Qk9wNmZpZ01vNlJ2TnVX?=
 =?utf-8?B?cWxsUnFXVWZQVzE3NFJtNHEwRmlndHVFUnlZaWVNQmxKRXBDQzB6N0JYeldn?=
 =?utf-8?B?NzRKd0ZlYTVRanRwV3JxYWVHd01pVFhLdlA2REc2aDlDTVFSdlVtRytxSkRI?=
 =?utf-8?B?VUw5ZndlMUpqUXNFS2NIYlRUZEd5TlNNWXF2ekYrRnZHMy9WNWxySFlaMG0v?=
 =?utf-8?B?TnFrL09iUzhMTzMwYVUyenhlY0dzcG1GY1JWeXVGRlpUaVZzS3lodDdwdUcv?=
 =?utf-8?B?dldrMnhjcmhiYkMxekMxSTErc2QxbXlLQVdOb2VSL2dCMGZEcFpQanRpNmFm?=
 =?utf-8?B?aGlCblVwb3RDR0pWYUhJNDRzdUZkVkFFeXlreStyTnl3bzZNczc5UEtBOUl1?=
 =?utf-8?B?ajN5RlpHRmxkbEdJODlhYmFtZlRmWktQN04xdG5uYjRrVzVKbUZZSzVZT3Zy?=
 =?utf-8?B?WmRzUys4VDV2V3R3M01QcFVsNU5YUFpHNldXamM3aDJzbU5xUFVCbHhZcGRD?=
 =?utf-8?B?NlFlRzNHcmI5a2VCdVFKL3RNYWpTbEl5dVBqVGVXMnhwa0E4OVA2MlhqQzZQ?=
 =?utf-8?B?NWRLSXdmUkl2dVhSdkJ5VU1zazBPcVZJMXVEUmZXYnZ5dDhCbkNNbm1ZTGdO?=
 =?utf-8?B?ZzJVbFFkNTYxdDVuSmhhcnpYNXV3U3c5cFk4WENNMHFMM2lRNzlkbGhRRDF4?=
 =?utf-8?B?cFUvKzRsRXlyY2dGa0FMcFhWMXFyanptZ29QNFpMZ252cHpjeExGYWs4N0s3?=
 =?utf-8?B?SzVpOTFXTHBjdkdtZm5MM2RSU3U2NjJQU0NNV1ExNk1MZ1ZHSHUyV3hNandV?=
 =?utf-8?B?djBCQ2tkOFZTYi9CaElpUVFmWW9Qam91eVVmbHRYWlVrZmtVbGlYZjI4dGpy?=
 =?utf-8?B?VE94aFlqZHpxRkpuUk5TYnlMWEpPN2VmYTFoZ2d1dk1yUEpramVRYzl4U0xH?=
 =?utf-8?B?SnhoOVZrVGN6YUtVKy9tcmpMb2NxL1pUZHFMakdYSGRPbGNrdm5XWHNyalVX?=
 =?utf-8?B?VGRuUGtNbGhwTTBhZGtjV0tsSkxZZGVaUFNYV29QOWdjL2tGcjZwTVQyMmVo?=
 =?utf-8?B?Z29WTktkWVZtcEpQQTUvRFFObjdCTTc3YkxZb1QrTnRXdlpFZElaaWp4T0tt?=
 =?utf-8?B?TGUwRURsYmo0NHN3YkJqYVZTNzNpTGVoUFBvUmhoOTR2TmxuaEhRQWVXczJn?=
 =?utf-8?B?SHk5MXhCOGtScUgyamRrK05pejFYaVFabzhIMnliM1FKSTdYOUw5bm5UdEZS?=
 =?utf-8?Q?tav+xB9Vneo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OGlxNVV3RVdlemYyL3ZMNWRxT0dobGl1blZIVG9IRzJFa2k0eG5XMm9oRHpn?=
 =?utf-8?B?NVFISU83cUhvcnNIY29FR08rQTg1UkRHdVN2c1MwTm8vZXBsWnBuNkxrbXRS?=
 =?utf-8?B?OEFhTDQxbHZRWUdDVHZBSlNscEMzYU9xbTZQTHAxcm1rQW9MMmtGbXgzdkhR?=
 =?utf-8?B?M0hTVHczc0dVczlWUHBGRm5MdDRxZWE1M3RFREhIRUhSUGpwbjdTa0U0VFVD?=
 =?utf-8?B?L2NlOVlyMmJmYmdlUXM4QWNDUzlwODJ4WDRYY25ZRmllN1kxcHA1UG1oejFM?=
 =?utf-8?B?M2pNaTFlL1p4WFBzUTZZakYwclE1QitaZ25HUVdGQ0lqamVneFlrQVJmTzVJ?=
 =?utf-8?B?Z3pnV3ZCbFBLSnc3YWVvaDEzT0l6TmxGU0pBVGtJS0VmeDNiNzRxd1UyK0V5?=
 =?utf-8?B?OTJUSWZhNU1ueHdIdFRpWHJSRFpKdm5GS2RCQjlyY2tqOG9XUXdKQk51b1ph?=
 =?utf-8?B?Y1J3eVo1WE5tV1RmSm9aQnVlVUt2bUtjcWd1b2FtcmlJWnRoWnduVDRsV2Vw?=
 =?utf-8?B?RURHeGQzSS9pSkZNTjM5SmtDanFRNVJGTTY5QTZlUk5oaHVYQUZDSndjbXJ6?=
 =?utf-8?B?WEkvbVNqNUE3aGpFRkxOc3Z5YUxIWnVLUW1nSURLajlLdXoxTGZGYmNPUTZO?=
 =?utf-8?B?VCs2bkE2ODlJNGxPSEpkWGhSNXFSdVZwejUrRnY2WmdDWjgxMVZiN2wrMENB?=
 =?utf-8?B?enR3dGhzNHpEV0lkZERXWGhLV0VJTG1SYlFzNkVxbmVmVkJOampOYm5jOW1S?=
 =?utf-8?B?NS9kNmkxQ1BOSEVwdkRYK0tNTDA0Smo0QXJEMVZlNGcrUm9YS2ZYZTVZcWFH?=
 =?utf-8?B?aXEwTk9CODNDSVdPRGc4amR1d3ZjOVA0WnhuRzUySzB2bTRJRXNYWjg4WHZn?=
 =?utf-8?B?QnEvd2lsbFJRa21VbEllSFdBZVJZVWZDdEhuS0tUd3NmMUxRdkZlV2gxZStj?=
 =?utf-8?B?Yit4bVdzSUw3REdONElSdmxRNTRNZDJ5ZzYwWVdqb3hpWTF3SllNdHBlQmZ5?=
 =?utf-8?B?SUk3YlNVM29taGNxWkttUjZkZnE2dC9oaHBqZnptN0J5R200bVlnTXRLWU85?=
 =?utf-8?B?cngvVEg2Y3RxY1UrU2xwazVXdVVrS2dBbUc2NEZHc25lZ2NNUkluR3NBdzFZ?=
 =?utf-8?B?bHRBZWsxNjdBRXdXTmRIODVmQXE2TUQwTXU4cXZJYlk4b3I1T3JGVkxpWVI3?=
 =?utf-8?B?aHErYjBhaW9rYXkya1YzcE5vQ1BMYnRPeUNQdklUTDBTUGxxcy82SHM4NWJP?=
 =?utf-8?B?eWhndC92Qk81UFVNaWx0OWlqdU1vSUh3SllTUkhWQ3lkM1Via1h6N1FyZTNR?=
 =?utf-8?B?N2psTkJkY1F3YXpRM2xnMEVDQWNQRzlCeXpvV3IzTGF0QkZtL0p2U3F4MkMv?=
 =?utf-8?B?QjVHbVNoU2RzeVA3U0YzWm5PaDNXYTd6ZThKUWlJditIQUlMZTVtT0tzYnpL?=
 =?utf-8?B?MXBac0Q1YldiSHBnZGI2cytUN0dwVkU0ODMwNmdvSHV2WDlnV21uaWJTdWZI?=
 =?utf-8?B?WFRhOTZITlA3Y21Ic2FVSG9lbW9yR3lRYk5sYXRLUUJKdjVqTUppV2xoZGUw?=
 =?utf-8?B?MkVvR0NHZkMrZ3E2NDBTaTA3QTNyS1JkWU40MStLU0NEYnNYRy9lRmdrWW1X?=
 =?utf-8?B?VXNEanVRbGdrYzRrTktZTjltNkpYSDJkbEI5OUtFSFB2TDNEaFdBclNFS0FV?=
 =?utf-8?B?d3N4WHNvOGlCUEYvOGszQ2p3OFZBYUlud0p3dHJXa3dGeDFxWDVJVysxVzdX?=
 =?utf-8?B?TlBwZDFQRXcwd09sUnZiL3d6cFVRdTBKMlFSdGtsSHVYM3lhWDZHMWZFQ1JG?=
 =?utf-8?B?cVZ4Tnd2cXBtdm9hdGorb3VidFhQaXZqTkVRTkxmUlJ5dkE2Qk14STc3Q2Ux?=
 =?utf-8?B?MFUvcER1WktZOVhtYk9UOUttdnRVT2U0Tm4vQ1VoYkhDc3F6YXRmYlZwODc2?=
 =?utf-8?B?di96R1AxTXVXRlptamE5aGJKT0ZWT3ViUVIxMjJ0Sit1S2VDeitPWWVPVFhG?=
 =?utf-8?B?TGpvWkJwend6KzRsM3JGVmtocWtLL1hMSnpSaVcyZFNDOHBCWTU3aTBHMmxp?=
 =?utf-8?B?cytlVWxJTUVEVVE0VDNjL0pjeWhrYjMrbTNOazNmT21wU2o4dksrSTdKajVz?=
 =?utf-8?B?eUxQbnhPQk13dHh2MythVFpNQkVCVlJGQThLUXFpVVdtU1QrNHZWS0Y3cEQ5?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Nf427bC6m7moBhl5wG3WqpM+ZnzzWlmxO+tR2xp6GSUJkVnwPLMZHyIMKdEa8+qXHdpIPyRxFhTrnnT1iX+503yvhkyc3BZJWlK7USHnSCdCLurcE8pKfLNLzH0jRXFbmEeYtV5Y/gBBQ2Iay8htzflb565txUFvNYIdNrvpqEwfUfVebcF6izBL/V0JIRLWfbXLIWi6zht1ghQBLxGi8bX3Gu2zybUks/zOJ2qRsnQ/OzXesKdX103FCLbSdSTA5RONx7eJQMh4/cxjZ9pIrLQT0+R4Pqmd3ogu4DQ767ZuzLwTkDoA6/E/UisxzWDUNQEq1FWi6nCskTamv9Wh/3GEeyW7fyHqPLXCDYRsykWLbOe6kppwgWIlWPUoaGf23aTu9czs5FFb8sOfTWn2wXmZ2l0+UK3cIMQ699MPqov8BElwfr7bgf4cMAPR8K47ERNO36QGbLXWiZSvTA4Z3Fc6YI6FEO9Q/WYv/MIBO3WtdHEaFG/2n8wGjFo9p3YVpo4HbRi0xPz+RGgLHMvfTGWfEp4t9gLtgIQSnqcYegdVQtaQDutXcgZdPXDACKtTzxY9AUMSvq6XsuPFzZf/QmedDvCD4DvcBZoVJRzzf0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557e1516-4129-4880-a43c-08dd9716f859
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 20:51:47.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uf8pJJnPTNz6f1oYA8umJYalFAxR46k6nPf/FrKiC5QtkspnjylJTU0kj0aJTWG2B214N7+k4Y0UTsSOcRnutw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1C5E69607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190193
X-Authority-Analysis: v=2.4 cv=ec09f6EH c=1 sm=1 tr=0 ts=682b99e7 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Aibhf0-DC0M9PW6wVKYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13185
X-Proofpoint-GUID: KMv1cBldDHmtwir6IwaF_XQJb-aAyg18
X-Proofpoint-ORIG-GUID: KMv1cBldDHmtwir6IwaF_XQJb-aAyg18
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE5MyBTYWx0ZWRfX2KUK6rLZKE2c n7Wl11lHd/L7J03g72hClH1cGogg6KIE11XlPqOR6f+Vg8ti7lTCGNksNwAqYtan1Y++Ab96gD6 FeZZVFQzsIDaQdEbJHXhLRMFSzf2qUI6GzOZLb6gfh2xdTomWOgrblvY/nhPGxorrUJruAnXnrA
 6n0+1XN+8E+jVRESLDQ5+DHGi/V7lcnEL+o2AnOYMR5qFvdPcqVnCujz/DuM+G0SVSfxTqmASeM 8NYXg5xgYCk8WQJ9UGLF5GAPV4CsEHj/5DFyl7dVVSF76YhT7HYvodd5TMSKFSBNIhMn+VRT2i1 7UiE9N+nmMO31XB9CsHK7qkUe+rjBRFqUfC1swfJV8S3aHgJTLGrK9MXyo6tg3KU+2EvmjxEAFB
 IRqArgN8BeEISYGYKRbdO90ZO9dkjrmozRhzO4GNBcVapHwJUZnVIaWthv9hEvrNc18HYnCn

On 5/19/25 3:35 PM, Rik Theys wrote:
> Hi,
> 
> On 5/19/25 4:16 PM, Chuck Lever wrote:
>>> Can you point me to any documentation about how the client certificate
>>> is interpreted by nfsd?
>> A TLS handshake is rejected if the server does not recognize the client
>> certificate's trust chain, as is standard practice for TLS with other
>> upper layer protocols. Therefore, when an export requires mtls, the
>> client must present a certificate and the server must recognize the
>> granting CA for that cert.
> 
> In the man page for tlshd.conf, I only see options to configure the CA
> and certificate. I don't see any options to configure a CRL? What's the
> procedure to prevent a specific client certificate from accessing the
> server if the certificate is believed to be stolen?

It isn't clear to me that CRLs are the preferred mechanism to reject a
certificate. But in any event, that support can be added to tlshd if
gnuTLS itself doesn't already handle that under the library API.

-- 
Chuck Lever

