Return-Path: <linux-nfs+bounces-17297-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E369ACDCFA4
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 18:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC6D230332B7
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE01FD4;
	Wed, 24 Dec 2025 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RIlLnTm6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vhkSl3sr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9228D8FD
	for <linux-nfs@vger.kernel.org>; Wed, 24 Dec 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766598764; cv=fail; b=K3YvR5sGKV9UJOnuRHUGYkOBbthCIYaWy18MR63XEhjPETN4f1Z2uv4a8kqedlxFN1Ivoq4MqYetlsbGyHrN5QtahN3qwJanq6wX7ZY2OYSkhSUoV+EL6PMZPumxfEelQCgLzbLB+rurvmneORynvQOEFHyp+I3oJIE8xTae1Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766598764; c=relaxed/simple;
	bh=ff1G0CM9Yd9cBLivsh7p9lyERVyuwKgC5IpvBrq0G4E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UXRux0W1uTym8Tb+yrHbsQLdv3/9M1b8Az9Nn/hxy51Qb6xWXNfE7gEYIrhYUsQv5Upv+pL7OWbb5M9kufVV+/7EmxfSLEy0iZY06eeX60mMmLATsMWhn9CCKedKMk23QmFpFMqjkoox3DeTF7z0Rre9P++njxlyYY9EED9tWz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RIlLnTm6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vhkSl3sr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BOE5IXC2683314;
	Wed, 24 Dec 2025 17:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7iu998EYrleI1pRznGl9BCmbA5+ylrMGU6HBNkiQj1k=; b=
	RIlLnTm6X5k3FdujpNNiEmqjp46uoAy99aPrXujuDHBIodZ7YogsV71XUH9HA6Oy
	A42Ti2JCuaJEa8KGG3tRLmbojRO5JqE8PrlcVwBXk+BptGbZ/yFYK5xfaKWA91t4
	nDX8Mx6TcnimUW/fY1DgzZlsGT1h8ANIQ29Q6jzDh6cbsPlmqUeLz0vbO80DDWPc
	4Ds/twi/gtz0AdUU9LV4X2JsiiWjOsrBZQ0RxS+jgCpTQd1kxWfhKCG+URCK+Vqc
	SjR63iCQnN16OY/lTTg1xYYNx+e95RDeOlfhLsBFOvpm56G7e8f9gbnfsU4w29+J
	Di8nIQHAJUPmcfm8tXGSTA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b8hmag5yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Dec 2025 17:52:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BOG1eMk002401;
	Wed, 24 Dec 2025 17:52:14 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j89kn0x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Dec 2025 17:52:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3Nx7GNrBN0ei4kHc5JJd8RzuHjvzzuVPj55NqxYXC21hOFrum0HlzoyRFVbLXizssW0TkZIziTTYlS6z7SlNtlELh4BCmUPehz/Hy+xc22dunDh3SEzqPcGlxHxRGI/FW134Qs07DH6bRNvJWNJemuHNqojbsc/ZJu1q04ah/T4XWK6ZbmN25TWCfjPxWdQcDAUXmgtwLGrp4BjeuiQsF23+cR+pb+mb1rhbAh5uw/byMO6K2dOU4z1aSJhSX6q5rzEcDrJtGtZgNMz7etw34hACRANq0TVNvQ8axOvw1nGge7Caa4rOUjot5Er4fftYLkTk8HKLXfat1X94qe75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iu998EYrleI1pRznGl9BCmbA5+ylrMGU6HBNkiQj1k=;
 b=EWmAQyfz9npBzcRvSZApthPsBpG/GLOrXFbizkcUtIxuQ8Y7bO2jnVYMOkuKAwg2JtX4oCZxviJjU59EoGJ0t/JQoqLFvQYLGJN8e1GFiHFvkuAS0kbKPPaik6ZcUH/8CZhZkN79eIEGgKDPR+4FmlE1jL91UT+pvCWPH/N6DTe6scOseqCz00a3h5VfoecHs6oP6cBxEX99ozzBZcYJ4DBNqoSlR+5CCNyo2E8D4IispQ+0O5YHjSBakVeGqXlVEZ6xjdb40t1x4Vg3DdVQbCRnU4YZzYsXBMBTSPLk8kmDGT0lMfVufkt4GtRT1VKoSYuZed99mTvjedWCjaayCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iu998EYrleI1pRznGl9BCmbA5+ylrMGU6HBNkiQj1k=;
 b=vhkSl3srQ1hEv7oHUq1/fMV079N3i/S0ZR1dDq7aLqKzwXdNiHZ8UXYpqK/OiA6MdLXcPASTitUR24EF2NG9nYVb0Dthu1JJevyJalTiPrmDmS+mGqZs4oxzoEVDuBhVyhHv8HQ3QgH9czQUajliOEAf70mjI9Sr+yl+PPgd/6g=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH0PR10MB5641.namprd10.prod.outlook.com (2603:10b6:510:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 17:52:09 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 17:52:09 +0000
Message-ID: <0bc92d15-09cd-481f-8874-8dcc5a7b9d39@oracle.com>
Date: Wed, 24 Dec 2025 09:52:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] NFSD: Track SCSI Persistent Registration Fencing
 per Client with xarray
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, neilb@ownmail.net,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
References: <20251222190735.307006-1-dai.ngo@oracle.com>
 <6ffa2b50-c0fc-4532-908e-951b224fcb10@app.fastmail.com>
 <f1448227-ddd8-47cf-9fe3-3e1983520de0@oracle.com>
 <c55508e3-4167-4439-8663-5dd782404893@app.fastmail.com>
 <3bf448ee-7e1e-4ed8-93a7-2754084885c5@oracle.com>
 <492c5f62-e11e-4601-83f6-31aff5f5802f@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <492c5f62-e11e-4601-83f6-31aff5f5802f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:91::37) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH0PR10MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: d26438cc-7f04-425c-1954-08de431528db
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UjRZdjNJZDdzMWZRSlVUb1hPUW1UcHZncjYydS9Tdk04a01BTXkrZER1RGQ3?=
 =?utf-8?B?YjBUaGlPQXVUM0pxbnZBY09yRkQ2SXVqekYwMkt2R0hZdnRrWWtzR0JQMkoy?=
 =?utf-8?B?dklDRE5YUWsrQlpiYkdxUUQ5eGp2d2E1Tm9XakM4amtMK0FsUVhla2RUQ2ZJ?=
 =?utf-8?B?NWF0VEthRzhQOEFoMkhtc0prdTlBSFZBTGxyUTZHSk5GV2ErNUU2d1NQZTh3?=
 =?utf-8?B?c3VVZFJRcm5WNkhKTFlvK0tQRklqNHE3YmEvSWkzQ1hwMTI1MXprNnd6bXp3?=
 =?utf-8?B?amNVeUlNeGZMRXFucTJzYldvNWtKQnduaG9qNmJRQVN4L2xta0REVUs4d0dV?=
 =?utf-8?B?YUd2cDA3ZElneEkvTWd0OEE1dVFvaHhEL1V4VWJGSHlyNURYaGFaVkNpV0JJ?=
 =?utf-8?B?VEZsRWdnZjF5Q0c4c0FCNjRzZW1hV1cybStsSTNOZmJEUnd2YVRDMVEzbXRy?=
 =?utf-8?B?OGdYYnFzbHhNK2FtUkJYN0tJSDV1V1ZFM3RwZDZFelhxWHdrR2xRcnA4UXBU?=
 =?utf-8?B?UU42SFgzazNHSHBlMFlVQi8wbWRoSklWTU5lZy9qSUVEMWlUbHhPUm5vNWVF?=
 =?utf-8?B?aEVqV0l2VDFGdk9GOEhSeXkxSDIzb0k0MWZOaldIYnYwcVRINThDdVhnMVdk?=
 =?utf-8?B?ajI3Ky9GckkzOTZ5OFM5bE1JL2lrRXl6T1MxTHRLa1YrYktuMWV2d1V5NFYr?=
 =?utf-8?B?TEVHbEE5OEpvYlc2WnE0Snk4L2NYYzk3WUlwWVp4Z1BKZXF0UndCVjlYajJa?=
 =?utf-8?B?VXNreUoyNzNQdEZ2NXZLaVJBQUM4REIydm9jVlRNY3FYOHcxWFRGUTFOdDgw?=
 =?utf-8?B?ZndUWFNWaW5kV0VQdVpZOFZWKzhBR29MelJEaVBBK0dGSlBlK0VVQktrTjdr?=
 =?utf-8?B?RjVYNkVNMTJMTHRrVzFZTEFDY21mQk13SXlkM25JWkhrRFc4RUlkdUlnbTZy?=
 =?utf-8?B?d1BjM1QzVjlwQ3FzTGNPWnREOTVQakovSGN5WWlqWER6NlJtMzRNL2JlWG5W?=
 =?utf-8?B?NzdOaUFFSGJJeEgvM0FtZG1YREU3ZGpOTCtJSG9LS0htYnNtVzRIR2xMUHFU?=
 =?utf-8?B?SDlCMnBXd2NZS2tuYmpTTnlkSVBOdnF1NzE3cGFJdU1wQ1R3bnJXRnd3a0tY?=
 =?utf-8?B?YjFGUC9DZlVDMWhkdWh6MWo5d09BRVF6VEVaV2VRbXJFWFBzV0FUMjhaL2E0?=
 =?utf-8?B?aXcvWDlCUlRJajdmUklkanViR0JWYVc2d1pEeFk2VW10L3hWdHJmc3VkM1dB?=
 =?utf-8?B?SEM4TXd0bFNWL3NBbk5iYWVHZjJYMWFBVUZBb3hzV1ZQdisxb29mVXZjMWhH?=
 =?utf-8?B?SjAwSnBndXI0UFRhMXZyYXo2c1piWnk3YlhCODZHak1KVEQ3c1RmTHZCQlpL?=
 =?utf-8?B?YUgyR1VSbHM5R21nZkZ2b2w2OTkxL3RTN3lHbXZCL2VxUHVnQmNkOEJlSVU2?=
 =?utf-8?B?cFRLRFZGanJ0bWl6SnJqanJYSFhPVjVlOVFXcVlRak5YazZqK1ZLR1g3VmNo?=
 =?utf-8?B?UmpMNlgwMEcxOUszTWdkSDdnWituTVlpQ1pZZjFmWXRIWk5McTN1SThmRjYw?=
 =?utf-8?B?eng2emtIM1pnc09GZGlxVEVTNDdtV0hjd2ZXZDVTbkRHeVA4cFBBdHh1VkVz?=
 =?utf-8?B?UWQ2QS9KeUU4ZUhQVkdWMWNDdnQxZ3pRS1NLYlFXSXJaeXJyN04yMXNReEti?=
 =?utf-8?B?dVpmZEc2dG01cy9KRG5sZERXczVnZ2I4MjgrYUFKWEw4N2VWS2M0U0duNDI3?=
 =?utf-8?B?S3BhTGFjTERhbnEwekJkNFp0WmtyaUM0bVl3RUxWUWZCNFJjSngzK2FTZVBj?=
 =?utf-8?B?OU1vM0NTSTBrTEk0YXFUeTBnd0VGVnFVNHRJd3p0UlpOVTVGM0Y0NldQK3Mv?=
 =?utf-8?B?aUtQY0dLMTlQUnpWVTlDMmpwVmI3WExqSTIrUDlFS0dVTEd5OFBqbHgvYUg5?=
 =?utf-8?Q?5Re96UtqCOJoGWsAmcGwwq6f6c7QkpaK?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SklxbUxJZ0lrQitaOEtTeFdXMzJTV0wyTC9aUWhLUkpuQ0dYVWs3Q3I3RDBN?=
 =?utf-8?B?dU1xVDdxeUttYi9wWDlDU2g5RnVKM1NEM0JscW9pZklvV21vRk9UZytDTk1u?=
 =?utf-8?B?VVF2VWZBUVc0bjhxd1dnSXJpQkNFWCt6ekZYSVJpU2JqM0RDMUpacVVZUW90?=
 =?utf-8?B?ZTZKcmwzWTRYR2FjQWNiT01DWFdTbDJ2bzFidHVCQ3JPZjh2Y2c1SEJLOTgw?=
 =?utf-8?B?aU54OUpXV0tMcW9qK3ZqMHpTejRtZWlDVU95UjM0NGtSaVcvQUZLUFdoUmc3?=
 =?utf-8?B?UTVZWGZWZEVCN0ZMK21MRFp5QXVFS0FTMGYvT1dEMUJSWHBaSTZ0TFZ6R0di?=
 =?utf-8?B?SlZYZUFyS2MrYmZJQW5lamFraFg0OTZCOGRsQjdhNVBrMFVCM3M0bnc5ckFI?=
 =?utf-8?B?UVVQdnFaOHFDa0c2WnJaeXFiaFdQRlZLZUxjMkU4ckdra1lxR3U3UzVpQkp0?=
 =?utf-8?B?WEx6dDB5dnZlTEsxSUkwcStmazMwNGhnUHZ1ODFHYzN3ZjBpcTZUc1dwblBT?=
 =?utf-8?B?MjQ0VDVQb2ZCL3F0aDZ0OUlJQzlaUjJXaWQxWjlMNVRsd1VNY2haelloVUds?=
 =?utf-8?B?RmNFTXEyaU14ZDBtblVpYkdaaXF5bHhsR0VnbDk0OVdINHV2QXZFMXg0SXJp?=
 =?utf-8?B?bHNGenczcWVscGJtRkZRVzF5a3kvZU92UlNTTkRpYWhIWmRrcG41NUE5VktF?=
 =?utf-8?B?b3ZXOVN1d1RMNytOZnE2WmNpMUdXVjZzdVhObktEcDZJUnFIWS9jNXRGcnFv?=
 =?utf-8?B?OHRkSWVnbWM5U3ZFY0tVNDBKdjlhTkxaWVJtdTh4d1lXOFY0czN5Y01JNWNS?=
 =?utf-8?B?WTMrNkgxU3RiNnVSS2J6RExEa3NpNzNrdHl6TzJ2NVExaEtWTVpqbG5STCtt?=
 =?utf-8?B?VHdhYzNQYTZodmY1VkNsQWRNc1ozT0VLR1JoS01iM3cwZHI4blZwTndUcGRR?=
 =?utf-8?B?VDNmRnQ1emV6dGVZMWhMZ1E1Z2VrNlloUTRndVREa3JEVDdnUDVvVGdhR1ND?=
 =?utf-8?B?WlRZcE5ITi9pU0RyeGs3cEpoMENDVjVkYXFReXpvZlhzREI5YlU5akVxS0d5?=
 =?utf-8?B?SkdXemVjUlV3ZHVlRUh0bk9DQWxScGcxbjh0aVN1S041V3JSdVlydGZWejRU?=
 =?utf-8?B?OXVFNGFGODBrdGk1RXBJZzJzMWZrT3dTOWEzNys5S3BCbkVoUy9qRE1IeHNo?=
 =?utf-8?B?WkErNjZnWStaS0p5QzZ4NlRuMThiTkRDdXpOSFkyNVJJeUFrVEJEYUk4aS9h?=
 =?utf-8?B?bUcrVktwbnV2VG1LNGJRdWpOVTdRbitKaUdMU3czUlI4VkFvd2ZtK0lMa2hl?=
 =?utf-8?B?SU1pRWx3QmwzU3oyb2EwZTk0eUh0U0FSeGxRVFdFbUtVcWRWbWRNbGJXV0l2?=
 =?utf-8?B?bWs0UDhkeFIxZzV3a2R2cjEyejJSRFMxMGJVMFJraDRzck5OaXV4RS8vVGlL?=
 =?utf-8?B?Vk1QTFpxcjVUVUFYQjh0QnM4ampDYjhROW42MGUveGw5Slg2VzhUc2FXSURP?=
 =?utf-8?B?TTMzcUlPcWFreGUzYTliQW1PRTE1Tm4ySkFyeTNPdk1uQjNuUVJhbzlEZmJr?=
 =?utf-8?B?UDdXWC96UG9wc3pERi9aTXNibzAxMDB6YVhFaGFDN0pmOStVU1lIblF0cnF6?=
 =?utf-8?B?NHAycEt5dTF0M0lBNUxzZk04TzIzN0VNOXhPUHlQc2VoVnVKbWVKRlBORWNn?=
 =?utf-8?B?azhMZ3E2WjJrSzlkUllhRFRyZnlXdVo3K2lXMENsSDQvc0NLWVp0ZlcrVmtn?=
 =?utf-8?B?ejFLTWQ1RzZxbzFwN3NnajB1WE1NcVYyTFNVRHBsOWNKaEFVMWhTcXdHSTBZ?=
 =?utf-8?B?V2o1bUlDL3BZckRrdFdyaFNRcEk3OG5ZRzhNbk5lMjZFS0lLaHhqcW5ycUlv?=
 =?utf-8?B?aUozSUVDQ0dreE5GaWdmZE9ETFZjamZVZ3QxSktHenZTczdnOTRjNTVWMVRo?=
 =?utf-8?B?aWpBZUIvZS9WQjE3aEJ2Qmg2dDZ2TEJibE1MTUdVUHJDZmduS240SVdoYUdv?=
 =?utf-8?B?VStDQVNYek9UbVBoSTZJd2pmb2pFZ3VTSnRYTzk2S2NDQzIvQ0JZTE5MQVF2?=
 =?utf-8?B?cm1rZktqL0swdGx3SVRPYUdNNHlIT2k5VWZaZnFXU0tIdTJ1bExUMnlWL1Q1?=
 =?utf-8?B?R084dTV1ZEpOSFBmWEJlQTJDQzZWZG9hZ0FpSENrZ05pczFRcVpzbWxrcEh3?=
 =?utf-8?B?di9VTUxSZTJRV3FQc1lCTkU5S1N0aVJEZE5oWXc1eUlMZGJ6UGprRTFWY3ds?=
 =?utf-8?B?ajhRUEFKekc0QWMrNU5LV3dzUllxNURCN2RLLzhxRXBoVjBVcVhvRTRVaWpu?=
 =?utf-8?B?L2RUSXhNTzJES3JxMzJnMS9abTMwR2dkYnRrcUlTd0sxbGtYcElYQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hlpbDeiKOP/awmYuGRljW/OEHyX9M4ecoEc1QdxqfV48PDhdZ1e9O3mz4E+W30EdHvL3jOBXwRv3/AMq6fur9o7zU9UouHbW/jm+/9t+z/4vFSU4rroEdS8BPuNOvOkB03Aa7U7bTRli6Ctzoqhqk2z05w+KGmFHyR8TPKK/TjMfPTR53V1ca8UA8bkqEYav1s7tlMURyW91e9HSZcjrZrDKmBnvBTbqvqC2pmbsWdK1Kqgz/Id+LYkpKYWecn1BT6cTkr9wlp7uPi5z0mjiqbhDtorPG1DoVfqjaLYiFuUH+jet7k7d23nzwhk7vxivX0KsHO/1K7Hq+ZDP4x3hZJgdN4f3i/KVoNYdL/EDfqbWoCxd+7wacQFUM2ue+eQ6wubwCpcEkgYE5ya48R6ZVsu6lQpN33h86ESmEnlMYV8BwTB+Oh/T+s1SGL3mm904eAS6IkIxwuF7F8rqQz/2UU39+iojb08pD5bxWOLI5mtC/e12shmQq/lCQwE4l8PaxeknrY8sC92nQFfMzcTEtvtGxcqRIygj1lcoSG7Q7Xm1gjFiAbjnkSqt0Lhz0fd3ui7avUrbTIRe1DTBRFncw+vCS2j3NMKERXrQnHJlgck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26438cc-7f04-425c-1954-08de431528db
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 17:52:09.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sq8W6Xv2VQl0iFKi5Gfx/DE9ULz1a6CkwWbJeXhFiaaSiQOmbg3FrE16UpFpde3zOiinhIaMpfQLghRl0KWUWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512240158
X-Proofpoint-GUID: SoXOfCfk6vjrVgEO7Y57q1BJ2RKcS4IO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDE1OCBTYWx0ZWRfX/va8Wu5/LffW
 BE5aDEmBF+fVSgAFwLf79xOBm45qFo/wvVc2brSjjDcyn54Z+b2foYoQUaeCqjU71MLVzw0QpWk
 0thFZtfG2fwswDcxhjnRKNZNwQfXhUFergbD7lA8ndUcg+q+g3rXp28CEDor+9a9VbGE7Q437YE
 jhf+zIddvMogXY1y9fr958cYcow+4TXQ/q5K+IG09OwWK7K7Kl+luyiY5sb0GXtQuJWMrQRKF04
 R0g8W66hIl0VgEby66cKggUPEWf2EP1QGRwC47fnNaCMQbwfnRCFd13CRFYSoqVEqKxeKhZRttt
 Y+yBojg2HomhI4/gSelfrKVATNB5q9u/cxKghcVrKdDd7z9ycwAc55EPejY/LheQsJIUfVhaPUv
 3pLqVFZZAJoTiCyfnXquR5elglZCW0nQJ6/+rwX53bvkicc8G+9duGmEnCDgcGkb1THFqBvQlw+
 /mcW3WdOfjlWwodFedA==
X-Proofpoint-ORIG-GUID: SoXOfCfk6vjrVgEO7Y57q1BJ2RKcS4IO
X-Authority-Analysis: v=2.4 cv=d4P4CBjE c=1 sm=1 tr=0 ts=694c284e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CoaabLbwqiNiroaARHEA:9 a=QEXdDO2ut3YA:10


On 12/24/25 6:57 AM, Chuck Lever wrote:
>
> On Tue, Dec 23, 2025, at 5:34 PM, Dai Ngo wrote:
>> On 12/23/25 11:47 AM, Chuck Lever wrote:
>>> On Tue, Dec 23, 2025, at 1:54 PM, Dai Ngo wrote:
>>>> On 12/23/25 8:31 AM, Chuck Lever wrote:
>>>>> On Mon, Dec 22, 2025, at 2:07 PM, Dai Ngo wrote:
>>>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>>>> index b052c1effdc5..8dd6f82e57de 100644
>>>>>> --- a/fs/nfsd/state.h
>>>>>> +++ b/fs/nfsd/state.h
>>>>>> @@ -527,6 +527,8 @@ struct nfs4_client {
>>>>>>
>>>>>>     	struct nfsd4_cb_recall_any	*cl_ra;
>>>>>>     	time64_t		cl_ra_time;
>>>>>> +
>>>>>> +	struct xarray		cl_fenced_devs;
>>>>>>     };
>>>>>>
>>>>>>     /* struct nfs4_client_reset
>>>>>> -- 
>>>>>> 2.47.3
>>>>> Another question is: Can cl_fenced_devs grow without bounds?
>>>> I think it has the same limitation for any xarray. The hard limit
>>>> is the availability of memory in the system.
>>> My question isn't about how much can any xarray hold, it's how
>>> much will NFSD ask /cl_fenced_devs/ to hold. IIUC, the upper
>>> bound for each nfs4_client's cl_fenced_devs will be the number
>>> of exported block devices, and no more than that.
>>>
>>> I want to avoid a potential denial of service vector -- NFSD
>>> should not be able to create an unlimited number of items
>>> in cl_fenced_devs... but sounds like there is a natural limit.
>> Oh I see. I did not even think about this DOS since I think this
>> is under the control of the admin on NFSD and a sane admin would
>> not configure a massive amount of exported block devices.
> Ultimately, the upper bound on the number entries in cl_fenced_devs
> is indeed under the control of the NFS server administrator,
> indirectly. But looking only at the code in the patch:
>
>   - New entries are created in cl_fenced_devs via GETDEVICEINFO,
>     a client (remote host) action
>   - There's nothing that removes these entries over time

I don't understand why these entries need to be removed over time.
These entries are created only when the clients accessing NFS exports
that use pNFS SCSI layout. So long as the clients still mount these
exports, don't we need to keep these entries around?

>
> The duplicate checking logic needs to ensure that client actions
> cannot create more entries than that upper bound.

How can this happens? repeated GETDEVICEINFO ops of the same device
still use the same entry so how do the clients can indirectly create
more entries than the number of pNFS exports?
  

>
> I think the structure of the new code is good, but maybe the
> kdoc comment for nfsd4_block_get_device_info_scsi() should
> underscore that it does not allow more cl_fenced_dev entries to
> be created for an nfs4_client than there are exported pNFS SCSI
> devices.

I can add comment once I have a better understanding of the issue.

Thanks,
-Dai


