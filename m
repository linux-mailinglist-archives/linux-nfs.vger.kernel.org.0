Return-Path: <linux-nfs+bounces-19059-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6u1MCWXrl2mX+AIAu9opvQ
	(envelope-from <linux-nfs+bounces-19059-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 06:04:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8282E164BB4
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 06:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33C5D3013852
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 05:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F009F23A99E;
	Fri, 20 Feb 2026 05:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XjZVL2hZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LGUzH/gK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB713D53C
	for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 05:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771563873; cv=fail; b=aiIkNg2vQuIzXOUtloFnMwvEMEgFta8Bn6ajCJSPugnNI9Fm8SEEza+oL3vGpRYpHaFf2rv33WlauE/cP+bCX3yCUfS9ewi+oiT37NivhKfi08M6567nYNgu5oB/EyQtmyQDlAPKyJ4Ah3QxAjnsg1oKwg/yHhY3I/PzjiiLqnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771563873; c=relaxed/simple;
	bh=ejmszlE8F42C3M3GrH2A971pUR08xbhNW7uBYBZJrLU=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=c/vDJVPjCe3bmtHJPhtjtP4OKHGYw6H3fLCbdNEAgaGJKpHoaE5n+M4ATUdHcrVc6GyrnoYvrue8M/K6ZuM4DhaT/rxyZujlh2L/WgTI0RuXUFAOf+NDq6+l2icR1focNtsXEIjulxUHhODSCXDHbGWkwSvTITI4n1In5usS1Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XjZVL2hZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LGUzH/gK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JLgEQi1378307
	for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 05:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=jMVbULo44fJmDVAP
	30wEBqwfXStIdUADe96ySsdaaeY=; b=XjZVL2hZJ0jtLfnzHoZSxoZlPMbDD89H
	mpK0wIjU19Ed9bxrZ+wjzwx8kwN9m4IQbd7O31vN9bw+CJUtiUG6AvbAeVHdY+Gp
	nLgc4KTlYTbc6qv+Na1glXiHqeeRM+j0jgqtZ7+DEAeN4aQ0TzTYyyPJfwYTltls
	ccqyBFXA+134C87JtE5DyVqNkfp0mQkeEUBe6Hm/rB8zvYWHryfxhb39igd6BIEJ
	d9oPSFtag//PNoPIYraIvA3nCfTKnqNohgdvN7aZunggvs7oChQfAwrXhiDf12bD
	QFHDiGW6O7SMuAciSS/C77fEN4Z/5cfx5G4S48y2ymBqlJYCxKVQfg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0wrnfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 05:04:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61K307rN015702
	for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 05:04:30 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ce4axtf3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 05:04:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ii4BPgvAKHSLs/2mC72OdFF2t/aGbJyyyO4O3tmaeF67IctS41OVVWbLaiqLmsiE2Q4sdVFSymwGa2m5asmNcLWFl/wAjFaFolUH1Waz1bSSJ5v7JbU7PYycqGv+pG6Qua4WU/sTuCYUAEt4h+jRcc/K5XQVUMaSuhR/93mXd51VLGWV6kAIrPQ7UGFN3+zXKeyXyJX4ssau1BePDqU4+EnPnEi/G6KERz+HDpx6cWD53gYYqgipwFIlnyzVZQdjZm2c1Y8LhjCF9du7Aku0vQujNijrDtY9KrbUmltVlDoEMRCVovRh/X3VSXlnIHPyTge5XqPu1pPMm9KwySZc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMVbULo44fJmDVAP30wEBqwfXStIdUADe96ySsdaaeY=;
 b=WM85CD/43nab6vfUT6HVzretyZhUcJVL6kcqCyc9699i7HIWbNoj7JgxoQoDIVMpELT+sdT4PC3MK32w2UKFSo0X9KCBEwLnTNFwBn0XWBqBAubx332Mk0uXi/hWbmJJFmd1BxLrHi3Ia3iNhiCQDh9eGCnP+V/Eey8YIX32OdqdKwn6Lq44PcHa3cP50mOnjjwimwe0IXyDpj/CXDu7Ym8SNll2lmZ8kEQqoL29IODCmX64eHqX9ZpCkqe+4ifz7dc9qKvKxuW+Mc8OkkVG8G+ceOtdum+PtmaWOT2nzDOGznA96IAztq1Rk1d7uZ7/eSgBAEEuAyXVP94Jw8yAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMVbULo44fJmDVAP30wEBqwfXStIdUADe96ySsdaaeY=;
 b=LGUzH/gKrPO7Qkh69qc9H1CPGZ2wHOArJl51mB6X6l2/Zlj3LYt5ImtgTIg6YZC19S+hc5BM+jPBEDe9M6emAfY/TZyrhPpxcoYlbe9OdWbYzpl+S91trzJPL8hdr5zrf4FPRtWp1/q+gZH4knaoyln4CVKrSXNUfxJJLrlJiPg=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS0PR10MB6104.namprd10.prod.outlook.com (2603:10b6:8:c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.14; Fri, 20 Feb 2026 05:04:28 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 05:04:28 +0000
Message-ID: <d0fe178c-8507-49ce-969b-97bc74fa1fc0@oracle.com>
Date: Thu, 19 Feb 2026 21:04:25 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
Subject: LTP inotify04 test fails with kernel v6.19
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0033.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::8) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS0PR10MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc35f18-f2c4-44a6-61d2-08de703d862e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFc4WGtPbVMxQXVKUmMyY1JqWFpPcjVaaHN1OW1Ea09NNk1nQTN1cWFnWDVt?=
 =?utf-8?B?c042MnB2Vy9mS3gwekM5TzIvNmltZ2MrNlFSR0ZRQ3d6Mkw3bHRpdW9CQzBG?=
 =?utf-8?B?T0dWNGRpeUtXN2U5KzV2blpoWFRva09EeWdHcUpKNTBUNnFYY3lIQlFFVFJH?=
 =?utf-8?B?Rmg2T2NBODQwS2NGM010enU1dGtOWWNUV1VCMzJ5VVV2b3RpSk5tTU1Dd0t1?=
 =?utf-8?B?TWI5WlB2YitaL1pMWDFadit6aENrd0hsMkV6OFZ0QlBkMmpmMVpVWU13cm5J?=
 =?utf-8?B?b3BqRUhOaEdnMXR2UzBraTFvUk56K2ppbjNDTURmbTVLL2pxQWtpTkxScWlX?=
 =?utf-8?B?ZkoyNzBOb0pXdEJGdFg3L3BvRFh2ZXZKMUNEbnpvRnhjUjlKeFB5Q0VVbW9V?=
 =?utf-8?B?WkdlMU9LVk9LaE1jRnNrZGxIcHZQeTVaUVc2S2ZCUXZVczdiOWdQbC9HMmtw?=
 =?utf-8?B?dVVRUlVpVTNITDBqbzczNDFJRmVRSEFMN213UE1yZVlORzc0b3ZzelF5QS9Z?=
 =?utf-8?B?MFFLbEk5cVNOaC9jVTdjaEpvNFdLaTYxUE5DU0lVakpzT2xwTzRHTDFpbi9Z?=
 =?utf-8?B?cEJDUkVkTE1FYXhWbkFvSStuQ2paZm82aTZWREtYN3RuRUNPRGZhM0QvVStH?=
 =?utf-8?B?ek91ako3ajRYeXNnMVNPc1N0dVJsNkZXOU50eTV3ZzlkU3QvbGRkeFY4NEMy?=
 =?utf-8?B?UmhqUkhIdWNYQ0trTXU3MUkvMllRZWVGeExBcEwreENlQjhzaTJXSVh2SjNR?=
 =?utf-8?B?Y3FiWDdNTHRleENGaEx2dHVRS3c2ZVR1NndYeDVnYTl5dzZROG5iRE1MaC9X?=
 =?utf-8?B?R2pmSGdWNmpQSW5ISWZwWmZSWW13MTdQeWJHTGJzZENjTWZUbklUTHRIS1Qr?=
 =?utf-8?B?MU9xcGpxb3NHd1I4QnlWakhQT2ljSGR4V2h6TFIrTk5MOWVuZ0RkSnRuOFBM?=
 =?utf-8?B?TkI2TVFCSk4xeE9oRzRvbWNCS2N1UXVuTFN6TFV1bFNQcUM5TUNtZU1GK3FG?=
 =?utf-8?B?WUVMSEF1WUVCMTFzNXpLYnVsRjNLbDVGVjBERGdvdi9tZGRCV0x3c1dRZWZl?=
 =?utf-8?B?bG9Pc21kdlN0TWlHbDZPNmJ0dEhEdnJrcE5lSWRrdjAxMzRGKzEvR3Bmdkdm?=
 =?utf-8?B?RmswMUFOakJPaGFSa1YwR0s0YytXWGwwb2wxY3YzM3JhQS9tM2hQaWJBcEk2?=
 =?utf-8?B?VG5uSGMzbmFTU3dYUWFlVUZTY1I3d1gzbGxGdGRpSXN5dklXV2I1anRIUHlk?=
 =?utf-8?B?MFZwUkh0eWN0WlFrbzI5N3FPT2JsbjVodmVYYXUwSjdyMlNvUGhhcmVVbXYz?=
 =?utf-8?B?OVk5WEd5akp6UllJS2xzVTZiVERXUFJqRzBDTkM2bW5HQk1ZMWFuVGlvY0Fy?=
 =?utf-8?B?NVBuK3diTlRUTmZoS282eHQwamR6a3JRc3RjRlZLZzRDL3IxQXVNNHg0UE1M?=
 =?utf-8?B?eTFrRlJaaHhyaGQvelJsZldJU2xTQVdpNlFyeFgvazZCMy9FVU9JeUdrWlhR?=
 =?utf-8?B?dUFvdUpQNGtxVkh4QzNzSERkaDR3cEZqNUtSYWxaa20yUDloM3N4Z2R2U1Zl?=
 =?utf-8?B?dTRQOFkxUW13WS9HN3VjWHhuOW1jMTdrakJFYTBLT3c5dERURFAzcXJPa1Ur?=
 =?utf-8?B?WE1DcXhYVHhvRlZTRUpvSWNTSE4yc2hVWDNjdjJvenBxY2tBdjE5OS9kV01M?=
 =?utf-8?B?aUtydVkyQXdWRkM3SDlTUkdTM1MxcHN2Z3VaZW1pMzRBeXZWVk53UTEzVHVj?=
 =?utf-8?B?UEsybzlwbkw0Y1RrZ2phZkRrVnduTjNHem9GS2o1MDBtelgwMDRVZjhlS2Rq?=
 =?utf-8?B?VllCelkzdms0dDJ1VmwvUEdNSG5KNnpDT2tpQTljSThLZkU3T1F0UU1uNVBF?=
 =?utf-8?B?WlNmV0Ryb09LTmRGS284WkkzTDJiaG56QmlKYkk0NUd5TllLdERuc0xHU1Nu?=
 =?utf-8?B?OVJGYjduOHVPQVp5T3JtUVdSK2RUUC9Fbmd3VG44UXBqNUdiNHlGV1BLUjFh?=
 =?utf-8?B?bm5YeVByMUtucDhBbEFBRlpyWjRwVklCRGhTN1ZvaUhmamRnYTErcklFWnk2?=
 =?utf-8?B?R29PYnByOEIrbUVIbERtYytzTWFWaGlFMnZ6ME1TSUczWUxYbm5DMndSTTBj?=
 =?utf-8?Q?ZE/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVNWeWtmUjdWV0orMWRnSzhQK0xieUhGSjBvYjk3SFhRY05sSWp0ZFo0eGcz?=
 =?utf-8?B?dFo0ZHMwY3l5OUlxTUxNNFdZbFV6Z1dDQ3lNTDNhUmErTExtTTVDVGFiMmR4?=
 =?utf-8?B?d0JoUUM2RnFFSytEZTF6cUpXLzFVdXJ2ZFJEVHZpdFpzZW1YVWFpSlZDZmJF?=
 =?utf-8?B?L2J6MktzRTlGa3djWGNXVXY0TGkzS0lkMS9jRlo3ZzAwd3QzT2g3QXNoR0tv?=
 =?utf-8?B?SFhvZDU1dDBLYUt5SVIyYUgvS0dsL1lJTzFUeXY3RTdFa2RtU04vNnRudnQw?=
 =?utf-8?B?ZE81SGJaK1AveWd5OWxIWkdMVTR2ZWhVNzU4Y0d3eHFZSzRUZExXUUhOcVMw?=
 =?utf-8?B?aUoxRTNyckJIVmdjVHVDUkNQOEM1Tkg1cXNCdjkrTG9WZEdSL3BXdG02eFlG?=
 =?utf-8?B?dEVaUTNldDcvTUxXLzkrMGMvVXBXa2JvS1VSUTBmZ1JFaWw5TTVpY3BXU2lv?=
 =?utf-8?B?eGhsbmVjZzJvMnVGZkNTNDF2UDdONXVZTC82NlI5cGNtRTJuYVlsaGxQd2tM?=
 =?utf-8?B?M25xOVNkdUFWUDd3TU9ra2Z6NmlrN1NJcnExcGpIVEpjUVlaTlRqWFRJL3hj?=
 =?utf-8?B?Z2pnd0FDUStPMWVSTk5XQUVGOGZVRzRpS3lGUlhWdjhMS1J5MUJzYXBtUEZq?=
 =?utf-8?B?WXdETFk1QkNiUUlXRUdNQmo4NlhaOEFIYkUwc2tNcEpFTDF2U2NsVk4vemJz?=
 =?utf-8?B?dm5rSUJhanIwTWFlM3paUVBUWkVlb1JEOUZlODlkUnNZYmk3ZzJ4S3dlU2V0?=
 =?utf-8?B?VWxpL0RlMUZpTUxwb2JpWTZRU3RleVhlbUg2eE00VjQyUnNkVTBOU3F3UjE1?=
 =?utf-8?B?MzA5UmZoOVNYK0hLVHRoY0V3KzBFZDZPMDkyL2kxRGpKVjQwNUVMUUdBajN4?=
 =?utf-8?B?Y2RFUHk0NXVaL0xJS3VSYm1rekhDL0ZrS293am1CVGkxcmV5V1hkQkVEWk9Z?=
 =?utf-8?B?NStEeWVJVTc3Z09jUWNUQ3ovRnc1cU1CQlJNRHQzYzN3V05EWDVyQnFrbEN3?=
 =?utf-8?B?K2ZUWnF6cyt3YlRLOE5FWEJ3WTljcSs2Y0NTSmRldzdFOHVmc0pZemVBVDlk?=
 =?utf-8?B?N1dRL3lKbDJHdWNNVmpWT0F6bm13NjgwRTdzaFB6WDdOeWVrNUNqQXllY1VY?=
 =?utf-8?B?WGRwcVlhWFJ6WUxsZ25zSTF4bWVwZXpBWldydDg1QmV5M3NONjJROHJnTHdE?=
 =?utf-8?B?TXAxRGs4MWxuQnFFS0dSVkVQREpqZ05rZVNEQ1ZPNFl2WStaL1gvYUFFeWFs?=
 =?utf-8?B?QkVBRjJkMjhLWFY3N0hmTkNDQjU0dnhWK3Rxd0hqWVk5K3FTR0NRenJjNGhz?=
 =?utf-8?B?ZFltdkhPcG1xQU9VYzhVZnB4TUx1RGl6Ym0zKzNocnIrNlFwU0FzZzJYdGth?=
 =?utf-8?B?eGVoUHNCRGkvQU15VUtyNHVxOHNzMnNJR3NHOVpOaUYvSjJ2SXhzUGZMQitX?=
 =?utf-8?B?aUVVdzArMzVDcGhnUFZCcitoZEFTcjZWSktFcm1rRjhwYTRYaVluaWVuWGRj?=
 =?utf-8?B?WWFjZTYwbVV3VWxjZlpJeDZ3V1NUekV3c0cwZDZOKzZaRHoybnZIUlovNVdo?=
 =?utf-8?B?T3diNGlaQ1dyWjRBTFpYTk9nUUhTQUpLN1BLcCtIYy9xYlI0VHpqbGp6R1Fl?=
 =?utf-8?B?Q1hGVldoOHUrV0UrQ2hIMnMrL01nNndsZTF2bktqRW45MGVJdzBEVjN6Zjcx?=
 =?utf-8?B?bkFlMis0WE9QTUlVdkJVY3Avd3RUMHJFQ2kxbkZ3czY0cjRkcUVPb1ZpWGVU?=
 =?utf-8?B?NmR5ME5qUEFCbmk5eXAzcDBEalM2ampRczVMaXdsNkpoSEtJSHAzeVBkSGtL?=
 =?utf-8?B?QXM0TUN1NXFDUzNIOThud0l0SjBoSlhSOVZCU0lNVkJsYjQvU1NzVlBrWGxz?=
 =?utf-8?B?bmxCNXB6RXhVTkRhaXd3MlkxTU51VnJ2TDlMNXd1WUtUWS9LaWI5M2JhcnRh?=
 =?utf-8?B?Y2NzNTlGNnJHQUQ3ZVNVK3FmbjF1cXpFNFdBT1pLYTQrc3hjN3EvWTdBYWh4?=
 =?utf-8?B?L0wyMjQxRW1Eb3pBRDhmc1VnWFo0QmYxd0wzdjkvYm9SZUp2K1BLOUFwWDRR?=
 =?utf-8?B?cjJ0R2RuS2ppQkRXTjNXYWVUWTNrUFUwandqZHpYSTRjY09qZ0RicTQzTGZY?=
 =?utf-8?B?bXRUeU1xbGpXaThIM1V5eHVKRm1aeTNUeEc0N0VGcnJ4bXcxdTB3cW5VeFNp?=
 =?utf-8?B?R2RBcFhZUUJqVHZXMGtKSURLY1BqUXNORnFhcDlEN3ZWd2gwSGpEeGpOZ3hB?=
 =?utf-8?B?R0dNanJ1b2JTT1VVUFRqMHlwTWxMYmJvRk5XUGVMaU52YndYQnBKRHFwVkpy?=
 =?utf-8?B?cFI1UWJMMEh0SUk3MWxTQ3VTem1jRElEZlJET09GbDVDZW14VGJBQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aAjVSK5Sn6J8ScAhSNj1wENqelhUmlutAdGCRQ3sPoFNzbDM4YS3BO5j/X3Gx5a2OIhC3TYBPh0OctbLh8D/8UPgeWRCQwbKkoIOTjs3DqrgLguMgILatj6/hQ0oqm3Tz957R7gSt2rFxmoPLDN/DCHWEGwV0tcS8TmrKeUjV3kOdaXpXYYKl3NeOh0vLBk5rFeLI0DI4DtDKHFkz0HW2+tTLxiqhxv2hzgBGkgaTfyECik65GUlPADvWw7gk7BWurMuzTNQFbzxbGBdtM7b0rdM8wmaI3IyRgKIOzbQhwZmgg7/HPs9FRkIAf5BPse14lXcDCzqJuGk7ngFKpcWUd09tU86uL5dGgz9aW8g3LWvXVVWJilUNfPiDsEbKeleOetgIhxDeXNhpiiM9oXl/SljsI2UWqrBrL8m5N4MUh2KrD/wr6jkQTGCVHTBYRcXMxH943fOSs0sLlMNDRqxhsmpgyak2EXRCpm282uiNIQ+Fd5GdhtF0+6jfKLHsIBgKLK2skH01ct4JHrpbvmFam9G2bunlgxPo54i/zf/w+3rsukGJnPyfC52kIz/yboi45z5If+mUis+x4eeQbeZApM2RaotMDcfmyIXD451UvQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc35f18-f2c4-44a6-61d2-08de703d862e
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 05:04:28.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlWmTIwQ5a7HB7F0jf6b0oqioc/xYrNaqZo56YogyZB43HWqT+vMkL07lNOXo2QglUkI81wPj21XfKnsKLofeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=863 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602200042
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA0MiBTYWx0ZWRfX41n3gzzU7uTt
 0tjnqycGUcVfip80eXuQYTxpmP5Hnk/mLsxllvLZXHITsqPKlinDwc9CPDfdQbnZlREOQFYbnQ0
 nSG9Ye8UYAYfVvlm7d7RiAm7YEp4jG3LBomP1+RyGiNbfqHV7l6CQzGjwi7DVSpKum6AloE5CIS
 VSFKGh9lMRFOaxvw7lAo52h5f4HGsi+ZO/KjKMmATVwbn3tBekyNMMzzWlhA0YW6FqHm7Id/uId
 4Yz6RFqBNpnX8o3U+DP1XG+IKzG+HZAEOSlJpMjRrF6SW/3Dl843kVI9TKxgwusW9P+zpGJ41eV
 i82RXqugkC9FX7MVH6AtaxRfBP49Ct3fvfwNlUtkFrEZzmi82CsQUrRm68wNiAB/M8Ez2O4LDme
 sI9h7HxDiA+1Vim6zv8PljFGOem15GFHpF4ENrbeJQp/ST2eiTu0q91nzIPcRZ/fcVvikVeJAsM
 0pgGzsSURNs1eFVJ2gw==
X-Authority-Analysis: v=2.4 cv=ZMfaWH7b c=1 sm=1 tr=0 ts=6997eb5f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=F6iBOzG4TBQ2cRzdy9oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MYx4KiSmtZVJx3p9TcDJiDo3t3T7MnNg
X-Proofpoint-GUID: MYx4KiSmtZVJx3p9TcDJiDo3t3T7MnNg
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19059-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8282E164BB4
X-Rspamd-Action: no action

The regression was introduced by commit:

bd4928ec799b3 NFS: Avoid changing nlink when file removes and attribute updates race

After commit bd4928ec799b3, unlinking an NFSv4 file that has a delegation
can leave inode->i_nlink incorrectly unchanged (stays 1). As a result,
dentry_unlink_inode() may skip fsnotify_inoderemove(), and FS_DELETE_SELF
is not delivered.

In this failing sequence:
   . vfs_unlink() is called on an NFS inode that currently holds an NFSv4 delegation.

   . delegation return triggers an attribute refresh that advances the inode’s
     attribute generation:
         . nfsi->attr_gencount is updated to fattr->gencount.
         . fattr->gencount is set by nfs_fattr_init() in _nfs4_proc_delegreturn().

   . the update to nfsi->attr_gencount happens from nfs4_delegreturn_release()

   . when nfs_drop_nlink() later runs as part of the unlink path, it uses an older
     gencount. Because nfsi->attr_gencount has already advanced, the check fails.

   . The mismatch causes nfs_drop_nlink() to skip calling drop_nlink().

   . With inode->i_nlink still 1, dentry_unlink_inode() skips fsnotify_inoderemove(),
     so FS_DELETE_SELF is suppressed.

-Dai


