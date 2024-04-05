Return-Path: <linux-nfs+bounces-2683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B58689A48F
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB649B244FA
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F39172BC4;
	Fri,  5 Apr 2024 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OLP18Pdr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fzL2rtL3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5616C6B2;
	Fri,  5 Apr 2024 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343843; cv=fail; b=JprDZma5f79PvVpAS8qpa2QNiSEwW8ZYcNiDazgUGkF6FC2O7BNc0HbZEwjaGFNp/ktSB0hfHEYMu+Eh86uIxvLwAFKtsohkj/+oWOzo6Gdy4/qvRfF0r0qpEwvnqNOsAYzYWpGmxI1GOgqWg+opk+edlGVvVDI/nv+9h5O5IOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343843; c=relaxed/simple;
	bh=hzovwpXFFuoqDoXAFOM+CyYzttz4As4fihUF+XpVpy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ef/4WiyeR5w3pKVnMFLXxClWCGvSGzPJMDlkLSpidy9H7c1M7DvHXF6ZpJC5lPMgZXHG1XIkqFpZFj65ebM+L2QzGv0rUnN2ygnMk1mZ9Ybk9Wey3bXpUln+XimOz654HO/6GmK3xVgiGxjU/vd7YZ7WKxkjWLuCu5XyYAHUexU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OLP18Pdr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fzL2rtL3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435F3bGH009209;
	Fri, 5 Apr 2024 19:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=HExj08FluU9r+/NrwJKhfDyD6cvkjqNZPRGTQlTRsdY=;
 b=OLP18Pdrzsqxg9biY3LLUdFcCRNP4FzIfk2qlq+df0AsBwZvnQ1j1jCHZBfgKw0EJNCC
 d8EwzW/XN9Yq+lqrCvoXqxD95c5F8toG0fABO+F1YKpy289+tJVWFYjUInmTVbYn14Ie
 VlQNd6ZG9rThz+8cuFQLtP/wC5p1UkdXTgo32/xOWgcVbfI7ph22KEtduUT7syC8n3t/
 T6kEunVj1WVTNMqD9kGAlqUMCLAvZaw4U4Xx7n7mUVaNZ810NlWG9k8JI8HbmbO/T440
 Lbz6fjudOrcWUNAAIqkZCPOeSVto/YpsJyk5CSgpeGINBFtnakDmTXBe0CqX5Kdia3kw aQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9emtm7df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 19:03:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435HQKK0024292;
	Fri, 5 Apr 2024 19:03:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emphu63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 19:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljVvMmrHl6HBbrcADkcE7dVQh7M0wGvHedsya9IBqeO4J6yw80qMA85vfRKgl//qcUi44s//2wjRwYY7LB39h+cpLqCcRwnyuadkxM1eArWuKBZa4eRGFqPxwOT4DlvEaasKbkG7jBBFZS/oyhiOx4a2DREZVMvoMskzX1smlZBE1om5B9Zx18q/PW19k1O2Q8/cWJPRNyEiGtazFKmC0YjebpNnkULfhjVZvQL45J48iZHH6OCJiL/K4H1pYrduXmxBS8awn8SQNbhYW4piwTHmTCroKUkYjzUbg8TC/NhtDMjzhu2B1Ld8+/e0/FxbbyTIArS3NqHVMScWpNsTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HExj08FluU9r+/NrwJKhfDyD6cvkjqNZPRGTQlTRsdY=;
 b=G6haSG4fC4dZeLfHZFrsr7F1vI1W6xl2Nd6mcye9s7dUqQ9cUx8AEMpXKQpn27jRubmafu0nB6Hkqj93nbRMS7zbI/3RhvfpsN4xD7GgtKBbL8T+jvrulvFldmrwaAyHbB7DihufqzsXWW4P3oK/q4RD6zSXSAHHXmlsrX5fR3/UCfyIpLLXrkXnB5PaIZnJHXYYBbRc/Vy2vnD8k3rpbyGeecrZ48bHtcD9waPIkbxRXLwpDeyvlqA0g3ut3nz0oZN72frxataJ1leigQ8RUKjhpNFVfzvj8oFJpnJIjqSGOVfQRZMT/mdTngA9yWFDhJcD5OrLwWSZOfHwN6sQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HExj08FluU9r+/NrwJKhfDyD6cvkjqNZPRGTQlTRsdY=;
 b=fzL2rtL37PR8dg1lY8vXlJCtNNxsfskm+gtIebLfPFY2XBRUQkOdJ233j8MixSUD2cS0lpWKt+S7TFeqflp9ZnPHGhPaHchqjado6QF4kD7UFeMhxbLlYjRtJG9baogTljFZiGf/s5KBGMMHmR316MNNQnECYDzWKp8dIk/kMrE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 19:03:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 19:03:35 +0000
Date: Fri, 5 Apr 2024 15:03:32 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nfsd: new tracepoint for check_slot_seqid
Message-ID: <ZhBLBEIgKxChNBAY@tissot.1015granger.net>
References: <20240405-nfsd-fixes-v1-0-e017bfe9a783@kernel.org>
 <20240405-nfsd-fixes-v1-2-e017bfe9a783@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-nfsd-fixes-v1-2-e017bfe9a783@kernel.org>
X-ClientProxiedBy: CH0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:610:b1::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V7uRSmZI32Qu/u0T3+FbtaBMjd/xpB3+DePaA60og3yro/orrUwgEWttXOS7dpiDu/V4qR4gZStN2JJ9RVN0O7jL2Pcc7cT0bMdE4JFI5FFt+/1s2gnXlFedv9tTxQfMclNboEESFAIukZXsQbIApTQKyCMDsOFyFD4JlSkNcQ1mTc6HPKG4uocfJeXP1tXMTDOEli910Tmnx+1nCYlGPKz5CTufJnG2ceIxT/jNwk9eVQ7BZ6KkGdrgNJoWyaJ1WFizRbRx7XaXavrOVcuRFH74SH06yOntMY5zcKq5PhgoQBSPceJ9cS3ZwIcNii7E2qgWzbZkYq5DFYR7sxZQKJk7piqeJaif29SYaYhx2CjDjvtwlEUI1hJMtpbCjRtNcTrZdUPBZGYkJEaNUjOmFiQ4ebeC5dcEWZaLTQfcbzPnexODVHt7d+q0QjFM8EIc26y6fneYk5OZ3mmenAY1CBZlFePDmUvBAGWI0snwduut7FgSyb8lrenLpP86jcm/+1HEkExTCA1FDIWVxSWcFiLAP72H+ySsZdMlZfxFmE9j0PE7k4kqGwy5EhWOmHUAQ8UQ0O9E3Mknr6j1sSrPJjJ2/XxEyWA2+FIXg79zLFRF8FPDf2vMDIF1OPIKtb5OPXNUB1QzAl4urNkhDuR4yB5rSvhC8Vw67jHZgNwabDw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9SmxOK7MblMZ/bGm9jx0bOGKJwWg4pCpy5vliBV7A+BOh1FmZPpH9rdrrsra?=
 =?us-ascii?Q?V0+hOSWa9EXinsiNHxH7ZjrnnXsC33YgJccf0M/CykxjgMzAhuvawlNrrQTN?=
 =?us-ascii?Q?owl1WktMy1vnoxt3u7sHJoxUpEsDyz5PSkXu0rDqwsQxYfeU1Da74qP4iZ8T?=
 =?us-ascii?Q?5hl74W9s5ZwUVjRTXwoIrQt8Xl2LpYT5UIv7sE4xA40+JCqSHBHDY95PpKRx?=
 =?us-ascii?Q?wwhubsUqSOpBP6H+LQBrPx3zYYq2NZTIOyaUgOb0ogowsxhvaP1PwYvU8Wof?=
 =?us-ascii?Q?bVQ5bG7n54/4GUwjRgvjNVDHRwpBbILJOzgULw98BM6Xl4b08o/f5Yz0DLYN?=
 =?us-ascii?Q?HrqDCYBkD4gIcsElbnONgw7gwlxfEfL7EJ0u4+aRYEGFCU7XCQjlPvB9Z/5N?=
 =?us-ascii?Q?QH2wvnA1d90bsoNH9dNzzi2zhyVUfakdfHw5z/BXaGjErkixMPBKeCu1MA1i?=
 =?us-ascii?Q?zIhw/xzalYvjKajEj2djLZrZOVFQrPwn8x4iPbeBpjM1PMBZxz7R/lCDa8mt?=
 =?us-ascii?Q?fEIe3gyNJi5SIUuxOK98+GEHF/FQb0xqHItGPreVgUPwmz67VjV5pL5Ur8ze?=
 =?us-ascii?Q?gIDmL8Y6R9YFX1vlaZm9GoxlxMuy6YGALWE2fSF3bSVVSE2bLDLIZpFUn1eA?=
 =?us-ascii?Q?kZdcuF2VtH+pPsOuVS6A+lnCsoCOKikoyLk8qPGGaMtvkfczTYJTVpuALdSP?=
 =?us-ascii?Q?Bc1RiCFXHheAROf1BqtxICUzcZ5/HUda0adI01FHCIbgQ5BwruJiHZ56Pkjk?=
 =?us-ascii?Q?4nfZc5TFWHpOrOvdrcKTDtUufsV2K8QaGbsRVGZga5ZWEUvlYG8YeohgyUjt?=
 =?us-ascii?Q?0WMvUcBlliaFpYZK8fX83FeiPV89p165G5aVuUM8DTNIzofOaEVXYBsheb8w?=
 =?us-ascii?Q?46yrqlR2oYoelEEsSM4+Gg4JeOItyXK1in3E77xrUGbdQxv7m9m3E4aHhh2c?=
 =?us-ascii?Q?MqMbzAy3ge49Qq5znHkBuGLDolApVdsn4Cfi7hFKnIfpTOekp7TBKUUOfGMC?=
 =?us-ascii?Q?1GSqZPdB91M7TpqSCjFuFQeOQnP8wUjcG3sN6/+z9UU0iuSSvWbl35NtMMRA?=
 =?us-ascii?Q?yK1iD3jzmaxDI23M07ta+ZXP0FvEjSFmpoDNUaANnbMzPPWXNp1VIx6uLJDP?=
 =?us-ascii?Q?63AAZm2zrQ/PdjEARjGkj+2/tCQ38VAyok38un406agT00mj/Mb/cBFj9C10?=
 =?us-ascii?Q?8tsg4M+xhiDdYQSjb9cW7oAhg2XyQ15bVT/vbhbPOpk964SJVBRXF2ylIl11?=
 =?us-ascii?Q?Cw95wR3CP2c0YeWdNYd24PYuUMNhiK5XVgwsBUV4W+bfjQJquRUbuBJNq+Di?=
 =?us-ascii?Q?ARdIkdyt+85ZF4c9VL1MmQgziDV/Pm4/GIOVlErONvGwEjs367Z+uCek9P+s?=
 =?us-ascii?Q?X3IVtkWqpslJcXVDyBb8FK5Ewwf79J+IDsuIZTJGNVPLP6Y8ugN1oaemhpYd?=
 =?us-ascii?Q?fnVGD+63Ezrc+di1uPbY+/kO7vHXDci2ey6rGPUceOSAVIvamYfNG4iZ8x+6?=
 =?us-ascii?Q?ZeufaveIVaZoL0Zc6Yw5A9uUyJsFqmM1Gu8AtjaOFUOr0Mgye2VmSN0heQC1?=
 =?us-ascii?Q?CAVS0eizc+95CtaHfBXDQFB6Jj/nmcTtJsOIgVAlAh3xB+WZU2FPGoTXVxnE?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MKeHj/vb5zlyouNUv1SVf4k5viCp76qxhW/bcZsTodPS2dx6R7+7v4pBKoPsg+eyLJYpunhwMhDf3bMbDchA97fjTsrtbGwc3lRkXJxACD9nG//dr7jkk42dkbVMcYRvJN6cmvq/dsJPZP+NPit9r7bN/0ZnuL0zFdNZJGS1sII4mb9Z/OUFtags99AdDIFO1Hx37gvVORpMHfnNr9jaE8UkbA5xXXojXOu1S6iUkVkkg8SGXss0t2/yPdAJopGYerdERPkOnkwzgR+FsPNPRCzE0hJPrJB//IsdQtzLKB8iI2eA42aMfX0oLR10ghVmDeF4GIUrI2mDsSXQw3I0T5q7YRJTnd+4F3dFWfOn79VzwpD0EBQCBgZRdkaJ23aH3jErHLFGC7nEREATWJOUq8/Cbv3L7ctmM008AKWZJrDOrnHJcYhMVtUoWPyquFtCu7a7f7/bZiw5HprO0SSdFN8iNIf9fsSX0F4MrYZVZdiDq3qE0KfmcU2Nv8VXI9lOPcyCi1a50Tez/1WfgZP8HoKPiDC4CzAzTpWWDZSeg146l3klJdT4ozaa6bu6avZQlN1ZbqBxpBzU8my9WU9AELgXnTtOSDmJvAzu4YsPlxM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40856b4c-5570-4773-48da-08dc55a31807
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 19:03:35.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEyQVvjSrGzT7K3B9v6k3MBJimEfJqwn85IfxtVBKxcfGyvvTeZzMKKNA5EeRAU5R4fesRIvoW2sQwo7gx1/vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=890 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050135
X-Proofpoint-GUID: aQoGyFOx-UbkGnWJDp3Q9LTiX7Sfzev1
X-Proofpoint-ORIG-GUID: aQoGyFOx-UbkGnWJDp3Q9LTiX7Sfzev1

On Fri, Apr 05, 2024 at 02:40:50PM -0400, Jeff Layton wrote:
> Replace a dprintk in check_slot_seqid with a new tracepoint.  Add a
> nfs4_client argument to check_slot_seqid so that we can pass the
> appropriate info to the tracepoint.
> 
> Signed-off-by: Jeffrey Layton <jlayton@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 12 ++++++------
>  fs/nfsd/trace.h     | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3cef81e196c6..5891bc3e2b0b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3642,10 +3642,9 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  }
>  
>  static __be32
> -check_slot_seqid(u32 seqid, u32 slot_seqid, int slot_inuse)
> +check_slot_seqid(struct nfs4_client *clp, u32 seqid, u32 slot_seqid, bool slot_inuse)
>  {
> -	dprintk("%s enter. seqid %d slot_seqid %d\n", __func__, seqid,
> -		slot_seqid);
> +	trace_check_slot_seqid(clp, seqid, slot_seqid, slot_inuse);

Getting rid of the dprintk: +1

Tracing slot seqid checks: +1

But I'd like something a little different for the tracepoint
itself. I can make these changes if you like to just hand this off.

Let's make this trace point into three separate trace events, one
at the nfsd4_sequence check_slot_seqid() call site, and two in
nfsd4_create_session(), like below.

Two reasons for this change:

1. Separate tracepoints in nfsd4_create_session will show whether
   the client is confirmed or not

2. The tracepoint in nfsd4_sequence will normally be noisy, so
   having a separate tracepoint for that case makes it easy to
   disable that one while leaving the create_session tracepoints
   enabled.

And, bonus: you won't have to change the synopsis of
check_slot_seqid().


>  	/* The slot is in use, and no response has been sent. */
>  	if (slot_inuse) {
> @@ -3827,7 +3826,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>  		cs_slot = &conf->cl_cs_slot;
		trace_nfsd_slot_seqid_confirmed
>  	else
>  		cs_slot = &unconf->cl_cs_slot;
		trace_nfsd_slot_seqid_unconfirmed
> -	status = check_slot_seqid(cr_ses->seqid, cs_slot->sl_seqid, 0);
> +	status = check_slot_seqid(conf ? conf : unconf, cr_ses->seqid,
> +				  cs_slot->sl_seqid, false);
>  	switch (status) {
>  	case nfs_ok:
>  		cs_slot->sl_seqid++;
> @@ -4221,8 +4221,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	 * sr_highest_slotid and the sr_target_slot id to maxslots */
>  	seq->maxslots = session->se_fchannel.maxreqs;
>  
	trace_nfsd_slot_seqid_sequence
> -	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
> -					slot->sl_flags & NFSD4_SLOT_INUSE);
> +	status = check_slot_seqid(clp, seq->seqid, slot->sl_seqid,
> +				  slot->sl_flags & NFSD4_SLOT_INUSE);
>  	if (status == nfserr_replay_cache) {
>  		status = nfserr_seq_misordered;
>  		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 7f1a6d568bdb..ec00ca7ecfc8 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1542,6 +1542,40 @@ TRACE_EVENT(nfsd_cb_seq_status,
>  	)
>  );
>  
> +TRACE_EVENT(check_slot_seqid,

Nit: NFSD tracepoint names should start with "nfsd_".


> +	TP_PROTO(
> +		const struct nfs4_client *clp,
> +		u32 seqid,
> +		u32 slot_seqid,
> +		bool inuse
> +	),
> +	TP_ARGS(clp, seqid, slot_seqid, inuse),
> +	TP_STRUCT__entry(
> +		__field(u32, seqid)
> +		__field(u32, slot_seqid)
> +		__field(u32, cl_boot)
> +		__field(u32, cl_id)
> +		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
> +		__field(bool, conf)
> +		__field(bool, inuse)
> +	),
> +	TP_fast_assign(
> +		__entry->cl_boot = clp->cl_clientid.cl_boot;
> +		__entry->cl_id = clp->cl_clientid.cl_id;
> +		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
> +				  clp->cl_cb_conn.cb_addrlen);
> +		__entry->seqid = seqid;
> +		__entry->slot_seqid = slot_seqid;
> +		__entry->conf = test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags);
> +		__entry->inuse = inuse;
> +	),
> +	TP_printk("addr=%pISpc %s client %08x:%08x seqid=%u slot_seqid=%u inuse=%d",
> +		__get_sockaddr(addr), __entry->conf ? "conf" : "unconf",
> +		__entry->cl_boot, __entry->cl_id,
> +		__entry->seqid, __entry->slot_seqid, __entry->inuse

Nit: How about: __entry->in_use ? "(in use)" : "(not in use)"

Since TP_printk is for human readers.


> +	)
> +);
> +
>  TRACE_EVENT(nfsd_cb_free_slot,
>  	TP_PROTO(
>  		const struct rpc_task *task,
> 
> -- 
> 2.44.0
> 

-- 
Chuck Lever

