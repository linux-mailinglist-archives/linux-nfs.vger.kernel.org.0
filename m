Return-Path: <linux-nfs+bounces-8753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 342629FB444
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 19:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A326188540C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7518A6B7;
	Mon, 23 Dec 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LZOux7uj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qG/47DOd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352D80038
	for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734980087; cv=fail; b=RN1AY6lIK11HmcHpNjRfo5gmezNccOy/Zf9/K3cyNCbBN/9as+I2Acp0fOWkg2wHkPnsbYT0EhKF4NRtuCo3J3eiSI34VNvf7fvKorz2AfHtKKeQ0BambUAcJRQIonxlSoP18QE7GndBUXPDDqDGLlYqFsDUsI2ypCcDvgD9kGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734980087; c=relaxed/simple;
	bh=oxx5ad/0DhM8XBZ5Cv2aDxzyk9LQmij3IQFXzfvevxU=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=ph/Z2e1nwF57UGS4y08SMbGfELv9PAoc+YKlzG7OSLyHQcYHXmAWwie9jXyLAXxnczh3OGArX5Q59oV4uD75+WfZz7PxpVxHLxWop4CLTTB0S1jZiCHBVk0Y9U54ZGiGuGhPQ4/IpmhyPZ9xU5W6SMzkpFwmE92D2Ik9tvcRiDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LZOux7uj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qG/47DOd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNIBrRd032206;
	Mon, 23 Dec 2024 18:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=1t4zhnLu9brRprP1
	5FuGpi+Tkb9OhlNMWEh1R2ch1zk=; b=LZOux7ujOLHLr0UchqwYgHTyjF2g4omc
	kIMQvOh9fiUZnwMwxHnsuepmM9H7uDtUwZgmYv5aDUVxQGM4xAl6ZNjFuLCwKWeI
	E0jozGKXfvYpAC6AvwNyaYWJMRaHdy1y3B1B5EJIdZrCwM6XfrKJXEYfGKwM/flV
	ZabfIvWoTWb5AHNO5WcjjrG2G+cvIz8jvf3L01tCweRCVJ/F0ACL1ycrhCwDgf+/
	F1EFqu1kB93C5J8bafUQ/VvG7CLXpSosYj40Cm7aXrQ/MdmLeRdZrPvT4Eap7yq5
	O+e2uQdP7Fp5iQtVvSlEqT1ZAkI7RFNtgeyYs8gFtq9LW+8YtwIrfA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7c32as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 18:54:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNH0G1X029520;
	Mon, 23 Dec 2024 18:54:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4dg39t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 18:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqBOiyCADKIB9EZX5wl/kEsjZoQGJw2RaGvJyKJuGVXKz9r4nTIqXEPKMg9LZRQxwux84Ao4u5AicjFK8iZoXHxvpRDtsk28viZwcKQneLyASI+sI2PWpN3vEACSpF09lc98coH68HUiVEanh7p7tmkjfUU9eustCbX8PiIsiotIyouUfOTgvXT601ZOknAgM5/BZvmcIV/+nFbsmEtSsmxYw+gK/CnmapLalrOg6c/DIYsTkRFL/gvI4vqUoBzBc5pclZqrqByitLaHZicmlcom/s0kzedbmQyRHDcNg8NCQLlYJRPUir76rF2RGNN6Nm63LjVPmDPnCkj1uvLCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t4zhnLu9brRprP15FuGpi+Tkb9OhlNMWEh1R2ch1zk=;
 b=XoO4XUVZzmbYbr/FMNn2ptXniSFDzKaMG2uL8jE8EsbUqeyGIhLcwrd2CKQ9IqUW6kOr4xXmrJ0XA2qn1lHo51Nrzy+f1kUkGRDC29E1MflA8lBf9Lktrg9Q9EDe9yRex90rnNK575WYZOC4cUQu9Bz65cNYhJjsPI5jq2/me0F7CAbye4PckY0WQ73031Sbw7EbPamCoSD3CGQfA7QxaT/TKOgpqap6BVIbgdK/93mX/QXQjDSdo/B7sFIpUqyKbM8qkJuvdE83YBWar1rHT4yzNngY9PMNQRmh19+X08Afy1ou69ME07nvkRm/faob5os0la1FjkmeO7dVf+mreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t4zhnLu9brRprP15FuGpi+Tkb9OhlNMWEh1R2ch1zk=;
 b=qG/47DOdKe6rhLzQrTfDZ+/3rBZRjkCkFwlJQ4KrEWWFRS8pXkCWBOjeO0wWUjYbGCeRWdHzkE/M8uzmiu/rljGw06vSm8iQ+nQOzopJu9eXKDO2JmOVdojXsY1Xvk2GrDCrQV66s9q7U3CTH6KJFfzABAmnnsJKr78JyeUoqWk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6422.namprd10.prod.outlook.com (2603:10b6:a03:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 18:54:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 18:54:33 +0000
Message-ID: <aa86e853-efca-4035-bb2a-d52a029bdbd3@oracle.com>
Date: Mon, 23 Dec 2024 13:54:32 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] NFSD fixes for v6.13-rc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0043.namprd18.prod.outlook.com
 (2603:10b6:610:55::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: d3df99fb-098b-4a62-fb37-08dd23833da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUxCa1Y2QVQwU09VREhPWXlDdjRiS3B0ZjJTV0xRM2lITExPTTRtYjRjS1FR?=
 =?utf-8?B?UkFqYmtNQXJmS1N4S1NKekdCaDE1WllMN2ZJSU8rQ2FsYlh6UWhQZkpZWDZm?=
 =?utf-8?B?THY4Uzk4K1J3TWNvUDBZekVWLzYzUVVIOFVxak1xZW5McHRlN084cEhsakNx?=
 =?utf-8?B?YU41MjFNWVl6UjkyQmxnTTR4aDRSQzc1bDg4Rk1Ga25lZU0rUUc4dWpQQnhp?=
 =?utf-8?B?SDdmQVFHSThFV3UrbEROdTdkVXNGVHdOZVpmcnMyanlKenFjTk5reHJBYkky?=
 =?utf-8?B?b2lia3V1U1NCQVB4b2hROTlmSXFzNEVsQnlONmwyQUM5M2ROR2ludk9NWEpH?=
 =?utf-8?B?YUtMQ1F0WElEdzNLWnVkMUY5TFFQbDFleWFPNzViTmMraGlwRC8xWURsMlI4?=
 =?utf-8?B?QWhTLzAxb1BGL2xYNlo0VkZhd084dWUrdUlqdzUxRWJhaGIvQm5ySWpEVmRo?=
 =?utf-8?B?WjRFQjlzMzlaYmRMTW42WDJTbU1SNUpxdTlYRmNyTWFobGI4K282RVFuNVlj?=
 =?utf-8?B?dnJ3YUdBTGJxSG5lUEVabVZtdDRFY2RwS3BxMm4zVGFYOUJFQlMxZFA0UjQ1?=
 =?utf-8?B?aVpzUUFjQVBrbmh2aExrMWZBS0tRZmhxZGZjV2U4Q2czeGFIVDBjb0hTRXE0?=
 =?utf-8?B?QWFqNU5OV2dXWmVtSkpBT2plTEUvYVR1amVaalFkNkJtL2dYK2dVZ3ppSnZh?=
 =?utf-8?B?T0tCcWRZTU41eC9jQzFLY3NDNnFOTlNTbE9kZmNRdTgwTFliNVZxMGJPTEJj?=
 =?utf-8?B?REVnV0R3T2JTTDhGTUxGL1FLYUVHbjZUVWN2TnBZS1BramdoUDRQQWtlb3Yy?=
 =?utf-8?B?U0tuMFJBTGRlbjMyVWx6NjFKWmo1dEQ0U2QwY3dWRHhXTzRrYmFiMnlvUG53?=
 =?utf-8?B?cVYwK3VkYVdzdFpYM3VXUzRldVkreDRMWW1FLzZGT0JHMjliQzBRRDBUSEFw?=
 =?utf-8?B?TmwxOE1LT2pSZDhVNjhZcHpEeVA5OC9sVHZHUThGVm9xRXU5aGNFQlZYMis1?=
 =?utf-8?B?ZU1IMk5DM1JmMGc0dEpXbjVMaXdLa240VlNQbDVGd0hVdlVWOThxaVJPL0FB?=
 =?utf-8?B?WjBVblFES053blpMOE1FYytYclI2OTVHKzlpUERBMHprRnJGSGZKZmZEK0I4?=
 =?utf-8?B?WmlQQkZ2MmxsYzNqR0R4WCtoQ1JnWkRwWm1xUENFSTlEdUVKTVJNVmVEZzdi?=
 =?utf-8?B?cFhCbi82U3hzYmx6ZUFCajN4eWhNamlRT05oYlpobjN6NWt1Z04zOWsxZXFW?=
 =?utf-8?B?M3oxYWI1MjB1Q3ZEdTAzQ2RzK2lRbWMvcFJQZXdMMHlqSEsxQ2FoL0ZGSnps?=
 =?utf-8?B?cWZ0SjkvdmJwa0RLZG1FQ2JIcVZmcTBzY3dWU2RuOHdaMmZzTnJHa3U2c25N?=
 =?utf-8?B?S1ZmakZ4aWhzSE9mNGtXenVwWG5mTmYwczF1M0JGUGdxWHVpNlE1dEtUbzhn?=
 =?utf-8?B?N1ZheXlsZEhIMWxPeVIrTHJQMmNkQThmZCsydDlmWmcvM1NLSjM1V01TOGE3?=
 =?utf-8?B?VWZPMWM0blRVQnJhaDJ5cjgyVjZoeG9KRkh5NGo4QWxUSzZpT2xIL3dBV05D?=
 =?utf-8?B?ZHhqeG9rMVdHdFA5R1lia2FVR2toeisxSFVpU3l4YWJ6MFZJZlVTTGw4SW5v?=
 =?utf-8?B?ZjBPQmZRZUREWTF1b25DNmRpamxPVmlOd1ZiOStzdnRvRFkwRjFhU0Jqd0hh?=
 =?utf-8?B?N3NmTDJjSkYzdEFNTm5iV20wa0lVdlNNcVk3eDJJRlNtb2JYZHZHLytWSXp2?=
 =?utf-8?B?MlhLZmhhaHhjc3lSNnI3U25BUFBkRi9Sd3pmcUdneWdUa3BibVBoekNSRURN?=
 =?utf-8?B?eUFNTWNtb3l1UndHalRCSlJ2cHgxRDlpNWpib25BaTlWQUhjY3dyMVRFQklo?=
 =?utf-8?Q?V9No8YX5m9WBc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnRsU1cwclA1VHc3MmZ6b0lrVWlzbFlUMHRiTXhLbG1WNVZnQjBOZk1ja3JU?=
 =?utf-8?B?dnF0VnJENkxtaDQvWWV3eFVKWTJLZzUyNkpqZnkwN0ZyY1VoMmJtVUZLaDZW?=
 =?utf-8?B?SUNEbW9GbG5QSWZ4K1Q5WUx0SHVqWDNQaXVJOTlpYjY5LzZTUnJBNnIwblc2?=
 =?utf-8?B?ZXFNVnJqNnVMSElBTDl5ZjhCT1h3dDVVdElXcU10c0N0amFRTmhLRkFtZE4z?=
 =?utf-8?B?d2djMER6Q2p4QVhzTUkwV25FOU85T25jNERtVEt3UDkxOTgvaHFVWmJzRWhw?=
 =?utf-8?B?MUszdVZKUUJvcERJSDdwOG1MV3hLanBmTFNaRG5IUk5wanJpZWxHRzhnc3lw?=
 =?utf-8?B?MzR4MHpnSnVvbWVKbXNPTTgwUVBNaFRvbVNMeGNkUEtDZmNXdWNDWlhqVnJN?=
 =?utf-8?B?dXNyVjZMTHY5UzhLZDVUODhRa1lEV1I3VUszS3dRV0ZFV1FYY3VxYkdPY21j?=
 =?utf-8?B?QXVtc05US1ZPNFNzcHNlZExCWGVjNVFBQ3NnLzZDdnJnK2lsMnJLZnpPOFF5?=
 =?utf-8?B?U2FuYVg2UkpPOW50TzA5cEJGM2c1RDhCWWRCMEtMckllRUdNcHYyWnA1eCsr?=
 =?utf-8?B?R3o1RUl1NmpISVRYeThKUTdRUHo4enY4TUhKamxBaVRULzY0R2dGT0YrMTEv?=
 =?utf-8?B?cTlNWGtWNmhZV1JiYWI3R21peEZSNndsWU9iU0E5Mzh5OWlYenZnZXFxajQ2?=
 =?utf-8?B?ZzZHT09XNFFhZmt6Tkl1bHRyd3pCNVFMdVdBcUM0SXdvY09RZVBmZkRSU2oz?=
 =?utf-8?B?STRTMWo3em1vVjJ0YW9HL1FVQ1daaVBwV29ldmtiVW1xb1l4RVJveXcxOHlH?=
 =?utf-8?B?QytkWE1od0JSaGN1THY2MXljWWNhYkQxU3dGdFl3aGVlaXc4Zk5xL1BKMmhY?=
 =?utf-8?B?Z2pGc0JjNXlxamNjTDd0c1VHV2ZSVWdQZkRUZnBlYmtwR3h1a1oya05IaERv?=
 =?utf-8?B?ZjNSMVdTWlNrelpxV2NlQzRVOUpoWkhrUzlNVzBwc3hqOHBXamhUeWZPTDRQ?=
 =?utf-8?B?M3BvN2plandDd2NpdEIrRVByaWVSYjFtbXhRUTRlQVZrRWFzazl5MVZhR3NC?=
 =?utf-8?B?SWxrUzVNZ0ZOc3ZGbFJrSmdSWHh4M3B5U0JRMnVlM3k2Sk1tQktXMG5NVnZD?=
 =?utf-8?B?TERUTlpKMW9qNU9HVkFJdThpWVFxNXcwUUZlV3k1MTU3ODZnTE1qeS9mQjNF?=
 =?utf-8?B?dTRiUUdNTTBJZUlobW1ibDQyL2hZRHB4NUt5QmVpcFFQME1yeTlWdG1WL0wr?=
 =?utf-8?B?NzNMekxrQndhdGtFRi9pVFVYUFhOd1UxbUpPZUY5SHpaRldvNEYrWTFVNlJH?=
 =?utf-8?B?TXpETEZxdDB2K1hzUURtVUt4eG85QnlTU1J5YWE1YnBMTVRab2NmY2RUeUl0?=
 =?utf-8?B?YTMrSFlZams4QkNrWkR4UTh2Ui8zZFlBYXUvSWF6aWhXSXhaYzI2RVVJbHlT?=
 =?utf-8?B?KzRHcjJ0S3VueGpjaXY5MFdqdEp2NHlQQXBJc0NnSDg2S0g3TnNvd1NpSmxp?=
 =?utf-8?B?RWR0Y2Evc0lFU2NHVis2b2wyNXRHUkxod1JFd0ZkTFgzV1BTdWpLeUFBS0tq?=
 =?utf-8?B?K1licDRvZEFCYXdHMWcxa0JuU2Y2Mm43YVNlVDFXUzhOZkI2djF5alJOOERQ?=
 =?utf-8?B?L3dCYnhqaVJUZS9nWFZuNS80L0d3U29lazJHakhNZjlUbi8xYzdoeWpld1h6?=
 =?utf-8?B?dVIvRldkazd2TGt4Zm1DaW5lZVgraFhnRWp2ZEJZWE9CUGRmUWI5ZHBTb1Ey?=
 =?utf-8?B?ZlF2a2ZYMnFNSmt4QUhxeUNIM0oycEsyZXJTRTEyU2o3czQzSk5ENG53b2F1?=
 =?utf-8?B?ZTJhOVNYRUk0YWMrRzZQc2RzUFhaQXJyWnlIMysvUE01YWN1Wk52a3c3c1Fn?=
 =?utf-8?B?T1VOR3BEeGFBRXRSS0hCUnhqZGR0MFFJZXNndytkMGFLcFg2emlPWVZVeXNY?=
 =?utf-8?B?cUsrdFd4TXNodEdyMUtZUHpsaDJLQ0hwc2c1VEF3NEt5RFN0TGJETkFJUHZo?=
 =?utf-8?B?dC90U2NNU3AxWHRndEw4QlhlRjM5M09yRm5LZkdQRmJXdk9PN3Myck5kL0lG?=
 =?utf-8?B?YjdxRElOWjNlUFBvQzBVdXR5Zm5aSlFIMlV4NUlYN0Nnd0JnUlVzcVBNMWhw?=
 =?utf-8?Q?iLYCc+rkBH5s7il9iSCzSKexi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hips+lg1hn2xVK4DJCTvxM9BWgC74lcbf/iTBZiSgQVcTI80R87Hl8Rd9OzeuaQqLR2dDTK0h+v+brvbvrS2rYlwTuZjgTte9OtG1ZjdRci5D9qYUaVMOevAsdrPvyqWVWL/nStfNsla3aALCE0ClePS6DsAArKyuO6VlyHgvK9GhOAFTAOH56eBlWYidiqLGrqTfdAJslugUxw5cm0aiJ4hdXINJOBqKSVew6v+wEBt/0djW4hLm3puYtm57KfG2ONoSXmFTl9F5TeDbHcMI+FF0e1JOtR/IBbyXFwkdv0ZkG9svUJ0+4soS/GRkq5de3NRUzMXi4dSK4Zg95yOCdUpSaE8ypLEJts7oc1f4y5JDfcG5tF3Mu3iDYO1zFCDhx3PsbDKXPXxdwQcV9qcJXVFHDPFmSNzdP3y6/uHQ8jXDj+tHRqxYRKm2SE7OO270KQLMRTALOktyKZ7UUS4KGBHzHZBp2A1/e5PeUKm9uxU6pGXb4XSDvwtmI8Y5tJRsTkmi6+ysYt0JoNoiRxrgyWQds3PtRJjIPrH/fC+d0F/80GfaxInSj7GLgjY6fenBsIsdZOhqrs2no66kKNhMLH7piXVDc7FJk+peEAYIpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3df99fb-098b-4a62-fb37-08dd23833da0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 18:54:33.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3hbZ0gXmEc5cqEKxmF455zwRkZUS3hforGUXCI60ma79vJ8RvRRnQ3mCJQeAwBdJztYaEgzc23MNid2S6rJMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6422
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_08,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412230167
X-Proofpoint-GUID: S9K7jkLGY6P_H4W51I3burZF1KCgMCKU
X-Proofpoint-ORIG-GUID: S9K7jkLGY6P_H4W51I3burZF1KCgMCKU

The following changes since commit 583772eec7b0096516a8ee8b1cc31401894f1e3a:

   nfsd: allow for up to 32 callback session slots (2024-11-18 20:23:13 
-0500)

are available in the Git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git 
tags/nfsd-6.13-1

for you to fetch changes up to 7917f01a286ce01e9c085e24468421f596ee1a0c:

   nfsd: restore callback functionality for NFSv4.0 (2024-12-20 09:17:12 
-0500)

----------------------------------------------------------------
nfsd-6.13 fixes:

- Revert one v6.13 fix at the author's request
- Fix a minor problem with recent NFSv4.2 COPY enhancements
- Fix an NFSv4.0 callback bug introduced in the v6.13 merge window

----------------------------------------------------------------
NeilBrown (1):
       nfsd: restore callback functionality for NFSv4.0

Olga Kornievskaia (1):
       NFSD: fix management of pending async copies

Yang Erkun (1):
       nfsd: Revert "nfsd: release svc_expkey/svc_export with rcu_work"

  fs/nfsd/export.c       | 31 ++++++-------------------------
  fs/nfsd/export.h       |  4 ++--
  fs/nfsd/nfs4callback.c |  4 +---
  fs/nfsd/nfs4proc.c     | 13 ++++++++-----
  4 files changed, 17 insertions(+), 35 deletions(-)

-- 
Chuck Lever


