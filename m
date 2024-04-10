Return-Path: <linux-nfs+bounces-2748-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D127489FDC5
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 19:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4897A1F21F00
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD217B513;
	Wed, 10 Apr 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LIFsl16/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s5j1oNX6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5C17A918;
	Wed, 10 Apr 2024 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768856; cv=fail; b=lxgGeYXMlXrQoHI1GsM5legMW1wRpgqF/l/KzcjoqL3Bl5L476qrq865VgvMwMHupJR7uH99d6nP6ZS1RFTbm2UGk4ar6xGn7OJqA/muLrB+h3QkzO13zUTGKpUmw8UwqL3AuRurqIPc9tuvo9zbbVlEDhPYCIZTQnZ6Hr4Thjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768856; c=relaxed/simple;
	bh=8A2FgP2CMcqgCvcH52I31oH6hOqmJIGS8syQAzpXP84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lXpbaQxt5xvt3u/7seYbqFJ4oZENJ7XBv31S5QJ8YnIcLXbWN2mvkXZihgo2fzV1e0CKkusWL3cTGCbmDKpvmYCw9z8d9np+ZwagtiE0KsuScXobatE8n50/q20++IfpdbA/H+aaqTBFcSjvftOSnB5vH3Ii6dY0jL8x8alnvFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LIFsl16/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s5j1oNX6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AGSube022644;
	Wed, 10 Apr 2024 17:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=hw8e5W8ttrqmY5X486AWmxo6HtBGzPiVLEoN4gdEf8w=;
 b=LIFsl16/WUiJN7I9TFx1kpIxMQoY5JhczPrrkF4qvNNAYRj8WjbaodsYpODTh0NqHbKH
 tXdam+CZ/yaB19ORaV4fpxbWZUd08WVAdJ2QLUA5aJxdiIF1Q+iNL95jNt4uhdZzBHwY
 CkzZH/hzmhDunPxsTUNQesTAPGisMN2uJ3neXwXima2rOTvxCYDru/4EyQ7v/qmxCDl0
 o9OQCC1Grho8ZNolFuQK12Ya99EXGLYXvtMFwfyF4BfgkAt1DOi8NQQH3DfyXeq3TgkR
 9i6M6HlT8aefIJcMXLUiVKncn8Q1As3/KCx1MJSkeeO5u/kVjc8ogb6ptc7FQCEWpRzi Pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf7t9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 17:07:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43AGIo19026260;
	Wed, 10 Apr 2024 17:07:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrsrhb9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 17:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeU0cilNhrzPl81w9XdGRJaCQ5RfQ5WzwkXg5/u5CPhlLWsNs+kyOo+Jrh3jxTLYmGqnSkdHTv40udugIJPhVAj6PgSpi+HhfmraEbaRqwQeVhvtYISf00u7I5ar14O3adMzkz+JSNS4HXoQKaC71lI8UZgfXfGpeXlzvYnaAB95emnzJ4Y7eDDCUDY0OyirnSn0NYI88lxOWXoXmPnywzvX4Bm5LI7Z8aCvHWNf9Yc0cpcZeNsxq72V11RykxIAyHoCs1/P7OyiXXarNgG4MLHArjSfs9f18NwD6rWR7Zv8Kw4oZu82VGF9ovrlT5r4TM4trzKUHCmFxsY9928Mag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw8e5W8ttrqmY5X486AWmxo6HtBGzPiVLEoN4gdEf8w=;
 b=dE5IsZi8MSaXzU8xwZwD54+yOYaJc4zovwHAEYXSAcdrMOp0kqBK+jdb7CbIJ8oHYcIyczy5b0TjRsmh7tCTLuHga16kOjSbpqGa/b6lyhNCccCRLiBWNanzSfR8/qhEylvwqQS+2q1VqEQ/MnT2sefdzjCF8oqtJGGd91NIrTSP2KYE9z63YmOpEwlPLWj30DrQ8f8peOAmkFuoCHsiFNLrkoUM6UoXjiEFOl5VJiKO821O+R/szG53ZYtDn+ExUszanitbp4xbAf9cTLMhZnWD1apkrpiR909WieYQH0xc6gFnp9BNUjatH+anf6Zz5Ik7LXshIbaiRxCzYIyfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw8e5W8ttrqmY5X486AWmxo6HtBGzPiVLEoN4gdEf8w=;
 b=s5j1oNX6G2hcIC1s5cA1bXvX+MgSnDt+DfXt2TWfIZCYAMdGDz5RHcvJLlrYgcGA21pPHUy+ILzXL1VO85anrA3qz0lT6L3Szv7N5auKQyay791Q4xLiK7E0Fs0W+dKpd7VP/NeWyck6liMHTuOU2dt0hIA62chl2e31W1pv80I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5158.namprd10.prod.outlook.com (2603:10b6:408:120::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 17:07:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 17:07:23 +0000
Date: Wed, 10 Apr 2024 13:07:20 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix rpcgss_context trace event acceptor field
Message-ID: <ZhbHSFsPQAP1pfQQ@tissot.1015granger.net>
References: <20240410123813.2b109227@gandalf.local.home>
 <ZhbAndktED4NsANF@tissot.1015granger.net>
 <20240410130741.40ebeda4@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410130741.40ebeda4@gandalf.local.home>
X-ClientProxiedBy: CH0PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:610:e4::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5158:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5TfymUDWRNr1SNuOOD8nDAAE5IAg5pBMX00OXs7Y/lh2v4NHkCgZhn20RoimC84/fV3Wc1+L0C7jwufQz25wH2sE4N2roFTY3+hW1O1H6/59xsDDO9IS7SSby55rG3iq1IAODFTuA3wJr8aR+ZesyS6K5XoMjcUfhHEte+Q8O8c6U+MEYXHe/aY2zPfvnpDv+P9vi4vhvqEFfMN6GIRSiyU3Q5UHHcqbUkA1NqEJ0ssXXK28RqTRv1Gs1+CVfO6QTGscohvbmMVnii33b0k382aKk+IitMK5iRQ9rdQzh3xZ8NtGl5A24hOhn9+oUCo/mrUBZ8atQUbcC28MI4VXdYSZaD8iREa9Xsx/zGKYf92CIpHe1Kw/UELdxpqMQRIFynTVnYU6Y9ncZ0M3SUJmnJwB3cmyYE3yKswBcXdFvoNQOpqQqINQDiWYl0IS2DHF0SCKn2O09N4DBJWhEweWlByGte+8YbPQwb9ekmtNZANxg4dRzFVrKcWN2ctKDW4MfBfW2CiQIvfEfp8oWRHGjLp5Ek67C6EuiwK3Q6wb4CHvcMNQokH/umFagu/sDMQPG22Srd524hwE9I7qEUa1v/b9oMI1tVBXUolrtItDiEcLOjlmTlp32gqiKz48zqM/uzoe2wMoIs3cBtxqBxN5wRwiebEThO47GSHRltUi8mU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vj36FbRY6WD0wNvJDWkAtC+AwSv/u53u4JZodHoCW9NRS2J9SZ8j8Y/Nrtgm?=
 =?us-ascii?Q?67MookW2WoIktERbnJ9BYJ1EbB11ywrMB3wTf392Hx1VTcjJuRrk2uS4nWR3?=
 =?us-ascii?Q?u9FYNKy+aVrIXpX77JzTMRc++3rNEEWTGLINoprF06ifUkFsM2e8Alm9IOeC?=
 =?us-ascii?Q?9icDdk/+3NkIeukkmjE0s4rIjHRX6Fvx68UdqDnoaKu+HyQdauCUAOWpBVLp?=
 =?us-ascii?Q?3caHJGoMWWAvPsrYbC6kKu05BFURAV9XltoAmdppcG3F4CZIGmvJZdKqpBLa?=
 =?us-ascii?Q?y3mzyi7xk1B40k7LG1wTpN9DaR2w5DWOOpotvNStnb47HPFed9sqhg16R7ON?=
 =?us-ascii?Q?MoYnAKLriq6ZPG+6ANHekIyzWhO2Vf2wgLSmRnXRTM/e4pvkirxjZhZPsx7U?=
 =?us-ascii?Q?tJh4GLeNPWqZyyGVfIFVftbgV32EGd/dyPCCwPxrN5YKF+XPuyREvml111oX?=
 =?us-ascii?Q?KNPE4IIRoKL3/879fqsnVqHq+txL+3l7nv8c2M6CgWu86hFQXD1TJS8p/yex?=
 =?us-ascii?Q?yRnyDOVw+FRg4AbWmycTB5EgdylHNx/+cEXc73+dCix6FzqRCNZwd1hzYor4?=
 =?us-ascii?Q?sav7PpjFR1BMWLgkQsZWKcy1ENAcc1AvaYn1xXHAmwX14zws13r3kY634ajj?=
 =?us-ascii?Q?nMLpmNTBcyKZonUPfwn2hQm945PIPWxogUg2WLHq3kwA1l4P0vDxZvwLNQbE?=
 =?us-ascii?Q?fAWnbP6cwrOkqj3rk1Xsi1rUtMnXDvlRROU6tUXrNHC3IDjD24Tsm9qa562V?=
 =?us-ascii?Q?h6e6ruUx8C4ZvMSLU53Uzs6NVrRXhW/jJZ6LrvGSCWSeqmNdTXio2jPmQVig?=
 =?us-ascii?Q?Xr+AGH7CqpYmsexLs/BnOYsSH4+ZVo2AYoMXpXGg+HIHBdiESr6jwMdZRb0U?=
 =?us-ascii?Q?rB69fJsKvIMAd41Y0rryh0EClH9MzFbMHobaLnUfgzz483Q93W7MvKoLfsBs?=
 =?us-ascii?Q?DpRrGMumXYm1LBHJ4jh6NDsTI1WLcBXvJfccNMIUflpnJc+hwnOIWmf7/g5j?=
 =?us-ascii?Q?CuI3u3bw5Eqb3jA2z8+S+V8wz8S/At1eXbNU5Zu9gol3T2ntQjxnuD8kO76R?=
 =?us-ascii?Q?ObMLuwL333l1+nUOScJiZB7GP14M8xU8FkReYswQsM1Q4aCDcmFOrLtk2bP1?=
 =?us-ascii?Q?EnbsVsbQ4T83vHqlDE7wXwm85iCmcm4bb08YPd2LDuncMN1O4Tatk+JuHzpr?=
 =?us-ascii?Q?pzJ+5kkrrpJCf8Q7YjER5T1oiEjWqGeD4LL6vDRWe0LUaX0IR9UO0P+290Ud?=
 =?us-ascii?Q?PQrxMzu2zZzDtPyYy7ybo7EChboX9q8GIJkxz389PQwUG4EpCB44CruVi79m?=
 =?us-ascii?Q?yBCM4WFntzEX6eIRTTpA7umrkydMayoe9zXng2KCIHAPtjt9cZtzshP4Z1ug?=
 =?us-ascii?Q?OpdnDb6foyPpoJqBXzEeOgA8Kp6i8c6O4zFJGU9CUcxq14P341QpQ6esJo68?=
 =?us-ascii?Q?fdYrWxu5fAOI43RlkLIu68HGIh2m5/fOV58CCQGC0YKdCIEroh5l3hqTMAco?=
 =?us-ascii?Q?BoR+JsgeAptH88nHFeDaQaD+vdeT96sNe8yeq2bP8zKXW6uJfHqdXwcEvGRv?=
 =?us-ascii?Q?7Z/UlWgiJd5GkMqm0XuEu3wET8skgybQAvAX98puT22YKVOEpbCICZ3qaS1C?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HSq8nKmcWsV3GhMsExkj2Mch7nRVYofhvKN99nI+uFLMVF38O6g0jYnyfrNTmgrvfCcymY5zI0s55kT2jiXw1jDUPKnXLqWsEIrUcc8SNeRzR1oPubMtQ02xsbjzRmHHziPfa6PGzX+2T35X7cimkGtT9UxDNUTD/ie948FjqbRfM7Jj3Xu/DNzYzJKDAf/jSmEY1I4L2/1VYa+qmbqtCGzLzCjBQr9k6Ot8gawludISmT2/8NLQJrD6OkgOc6pHTO59nmJIXYsPYKKNeci4TMahG/GYm2+R+vVYob8+0+cER4/4g0X9g/OMsX4KcOUIwrA9s9JgLf1744TQVu7p0FzfDXuctC537KBOkO822is6+7MH+/mFnN4LrZ1YlUJF6rMgCsHCPk9WJrKBD/bVl8S/I9xmy+3rQ3QYDiUwDB8TVVXvqB5M0GD1hnpskAJsXEIvX2mLwKnlHy3xAgeH6hZILTwqYSR9hbkqAbmcB8YnYV9A6o5hxRh7TptucIypy8tNo/XnNZnFc85ylWADNMrq3g64FZa11YIPR6mj3bwGDEtB/x5l7aKvBUTyLHzB+LpW0PrYwnZP8/VdqcZlBAuw7F/bOnl3KqA6wUAMxfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7deeabd2-02e0-4514-f1a4-08dc5980b082
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 17:07:23.2519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zC1rwILW6BRZfTjzNjD+fAAdItnaPO6O5kLQz9nSFDvsF+wouB+kfb4RSO9/i6vmbWkUaLvm8uSaO8f7CD6VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404100125
X-Proofpoint-GUID: 0RsBP1bJzk7OpNVjWSRsfWPpUIVgzJQG
X-Proofpoint-ORIG-GUID: 0RsBP1bJzk7OpNVjWSRsfWPpUIVgzJQG

On Wed, Apr 10, 2024 at 01:07:41PM -0400, Steven Rostedt wrote:
> On Wed, 10 Apr 2024 12:38:53 -0400
> Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> > On Wed, Apr 10, 2024 at 12:38:13PM -0400, Steven Rostedt wrote:
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > 
> > > The rpcgss_context trace event acceptor field is a dynamically sized
> > > string that records the "data" parameter. But this parameter is also
> > > dependent on the "len" field to determine the size of the data.
> > > 
> > > It needs to use __string_len() helper macro where the length can be passed
> > > in. It also incorrectly uses strncpy() to save it instead of
> > > __assign_str(). As these macros can change, it is not wise to open code
> > > them in trace events.
> > > 
> > > As of commit c759e609030c ("tracing: Remove __assign_str_len()"),
> > > __assign_str() can be used for both __string() and __string_len() fields.
> > > Before that commit, __assign_str_len() is required to be used. This needs
> > > to be noted for backporting. (In actuality, commit c1fa617caeb0 ("tracing:
> > > Rework __assign_str() and __string() to not duplicate getting the string")
> > > is the commit that makes __string_str_len() obsolete).
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 0c77668ddb4e7 ("SUNRPC: Introduce trace points in rpc_auth_gss.ko")
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> > 
> > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> 
> Thanks, but feel free to take it if you want. Unless you rather have me
> take it through my tree?

Well I guess I could test it for you. I'll take it for nfsd v6.9-rc.


-- 
Chuck Lever

