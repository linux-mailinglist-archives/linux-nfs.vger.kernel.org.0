Return-Path: <linux-nfs+bounces-19248-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIOqIrkwn2lXZQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19248-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 18:26:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E78319B850
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 18:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D56030087C4
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752C3C1998;
	Wed, 25 Feb 2026 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HQJlLVcu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LGX3REmg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536753D9020
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040373; cv=fail; b=AI6Tb0mlkPSJG+SeSGDmvvQ+ID/JqMo7i15nczinrod3bs0vn6xd7Y0TKmwkvcCLUFou+fak2U3t5dds3k1pSMz+QBAPxhSEhqp9ru0PMD8V1A9w97uO6WZgK2zurqcBSG99mdXEhcDlTNq8t1+QbeEBC0cXYuIGKwIelgIyWNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040373; c=relaxed/simple;
	bh=kj/qeRGN7xvdftdMpLcFxe+WGEVbFz6GBiwCyHVqhMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o8pYHpaG6LFelrPGlwaC6lisbiDmnJF2TbI5pajQj2oARFNp3yjk05HmgyX27zHuylq+cMs3NZtUt9EVVZlzVlU/pKhtTcbazOAv/woLbP8SjHTpY1lDj4Zm1DuptOsikl1syzIxvBkIAIcJuN3QzwKaoZBtkIfYlQD5a/kY3cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HQJlLVcu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LGX3REmg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9u3Do369379;
	Wed, 25 Feb 2026 17:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RPPNuDtfwxvmuzHhTtra1kiWNXGICIKlsrK4B5f+dd4=; b=
	HQJlLVcuXVPNPUuIQNcphtad4gGrS6h2E4xYKFdSDwUqIr/NRm4i974KLRcuuJD8
	n27FuXMsl3d9r505ksyqvz2VGORmv0lZBHRgmNraGIokvQga73iS4FzJl1yM2yFc
	366MyQwhjSguA5gHOMT7BgbYmiESnQe79mySyZb49Hl6iIudsueYW669TQf/cnjU
	8RzfK7H1iIKp5LLsjlmxlzDLIlEJQ/RYGHdRg2aEDwXSaRMbTfJOKwFeMZ8ef647
	ogRtRoZh+Uec4tc9znGHgzgg9ahNkfvrZdbavb1wOx+v+n1SvHyw5TMQqq1KXDzg
	JZZl1yvI3C122VWPr+H5bA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5xn78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 17:26:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61PG64rk027778;
	Wed, 25 Feb 2026 17:26:01 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35gd4dv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 17:26:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUQdefGBTIRfb0fiivD9nkz94iT1+4gKKTNtxtrbboEUteOpPnOmKNouHrAiBLVbu0hIOwuLXidDGW1TzrPa0fc9Pk0EbZ/TbDSbGsKg7arR7aVZveLXfcW2R8UL/6VvGn17SJ7K/iKNX9I7UBwxSlEW0qdblB6w/lXjT6ZcOMMQFC9T8F3kOUN8l4fIGMSMiOIhKhLKvdY06GYGRaSebBW59ufW+/YPl1pAifOsu/lDD8SGnszdq2qtrSK9JengTIxn5LCfuilYu7NzFYkgPvFqEaefvNd7QvnASZ0GarLyvlH2Wq4mlNhkS5ubw0j56SPkQRyl7XpC78b/fPsZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPPNuDtfwxvmuzHhTtra1kiWNXGICIKlsrK4B5f+dd4=;
 b=XfVvPGe9neZrms9E74DCfLhL8jtdXgVcIwzSC+SMkRv2diYfkhvgP2nFzl5CfW6NfHSKyp0SHPZdyZET5FZg6syUAzuUCld9BdKxJ+w5TVfPSRQw5BGi4pScGmJJSC2KnNorIFiXmsBzww2XmUMmodn0HPg8lgIVk3dW2xtJUQiG3W5MvTZiOCt4814XSTdKQdZixiM03BH2ZlZZvDIrQvFzKHzePuOVg2pVyI0/W+xqWiP/kB9Z0ufYlhDVEpMF0qYoFNGJTJy9tEEbFcLiw2qo2GKCrX/lzIQmKJE70IxeL3RyKCXWR1RcGnEj3HMZ8Fo6GtySO5SPvOchxoC0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPPNuDtfwxvmuzHhTtra1kiWNXGICIKlsrK4B5f+dd4=;
 b=LGX3REmgy0iHdZfYBor51+sfF7Sfdg4UcTP6z2zShr/5173jXWl/2VNWuFrISOz6vtNiSebtZ1za6rbit4zTJRMV2suFdExagW72GIFI3yXFRoHv4U/43b2b+OmnGhF9jS9x4MUTXbp0jTxPwnRU56rOtWJon1aQa6voHUV/AWc=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM4PR10MB5967.namprd10.prod.outlook.com (2603:10b6:8:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 17:25:58 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 17:25:58 +0000
Message-ID: <6eac3980-85e9-499a-a6fa-c72b144a4087@oracle.com>
Date: Wed, 25 Feb 2026 09:25:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] NFSD: move accumulated callback ops to per-net
 namespace
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20260225103337.587416-1-dai.ngo@oracle.com>
 <4b7553c45a9255bf5569a908d3aa7f18350e3312.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <4b7553c45a9255bf5569a908d3aa7f18350e3312.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:a03:331::23) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM4PR10MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4541fc-0367-480b-cca7-08de7492f062
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 mpM2a1uVUVIF23Mo6Mz90G61DnhP84+V3V5lcxZrdeFCh6N0nYJ02qxKNxBS4kTD9lgxpqdkLlIRxTHE95giHr8TnqGClJnIDTWX2t4jvSCKy2xlHLYnrB3lhTS3stwOvhV82rGKKRoT6EOSeUAvUq1Hg7bDbrmMxXwXvvKGkABrWDi63BIqs5ekIW6ctiOv4zoAbftSQLQYJ6eQgBBu4zyMb+N4db6bA1QSvgiKGiqUmg4b+5q3jpkqhz2aTx68+NhMCjBucyOIrJGnFVxq1P1lMIijDKTXlDsr1DxIl84mm4ZuHMV9sPZ7uqigdxKjNuty7lGGp01GSDfZE520Eku9mnn3Hk7YY34jck8bI8jEAASWW308FNp6PzWLpz167kB1cD/tubP47nN4xb8gzC6/WthT26ex+xja0csFPec2cZ55wYGF+TDsUziJxZsedBYXWaEOq4wwnc0Myr5zTehatunePXG9fjxStEhBi6CA2B6h2y9CkXAET1APjCjrhbjkMkqc+2IIbkRutVI1GVglK1ATDIdnUVu9XUSniI4OdXxCurz8yg9mvtjWmObN8zG1RHcn82wbJ1W4kt6BDAdkVeF0xi5HBmJR/e5cZ63h1Up2MmxXQFTZdI0IiR4tiVb/fTGRdA15HMcZIeFZB1nfBAVMCA3mSZpPCVrsHyIL36gu6+7xyJw5HpNT6ROGZigtxX/WxRjjkIl7MpEcpQMVkgZ/A8rZymXEESsZRts=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TXViODIwODhwdUowN1FEUnc4a0MrT0xsb2RhZng1QWxqSktDNFJKam5uaGxn?=
 =?utf-8?B?RjhhVUFuTlFJQ04xZWJHcis3cUg4ZDd4aitYK1Erc1NQa0g4K3dwRzE4Y1Bq?=
 =?utf-8?B?NlZGU2M0OHJBM1FEbFJJQlRnR3g4WWhPTXQvMGZPaTJ6aVlzZWlyaGVIcUxZ?=
 =?utf-8?B?M0VCQ3U5Ui9WRm9pengvdzJ3TnB4eGV6OUZFQnZQZjJIZHEydFlIZEwrK01E?=
 =?utf-8?B?RkFscHdscWJhSUNsdTVMemN5T1hNSFBkMXFzS0JtYVBUZEJaRzdhYUt4SUlX?=
 =?utf-8?B?a0lJOHJRSkkzaGpXVndKM1ZKZk9IOU1jV2tQQmN3bFRQV2xocXE4TkRJU2ly?=
 =?utf-8?B?RVRzRm42UFk3dlVmL2NYWHhHTWRRMHZ6T2krL3g0ZWtnZWM2RVNUZ21xVTNV?=
 =?utf-8?B?MDZ3SUZWSzAvK1BrMEhnMlNQRVZyUjl0dWFSeG52QWRkRllLRk1YUGdwRXdU?=
 =?utf-8?B?RTVyZDRkQUNCbjA5SVJsZjlyaUJ6c1o5NlEyTkViQWJYM21EZitWaytERVBi?=
 =?utf-8?B?K3cyeTR3NVdjNytZeUtjdXlHK2IxODI0d3FyKzZJbjh5M2RBUFQ0ODlzaW9J?=
 =?utf-8?B?Y2RFc3huTERrVng3amRjU2htV2J4U3RlQkt3ZnFpQ0kzb3BNM0VYaWI5b1BZ?=
 =?utf-8?B?K0U1MkcvK1Z2Rkl3bEZJTFBZbGV5VFNpeTVZbWNZSWplUnZubjNiQ0VPWkhY?=
 =?utf-8?B?OC9hOWdlR0hJRC91UXdGdGRwQzNqNE9FK1Iwblc3UXVCZS9mWmY5eFVXZFlF?=
 =?utf-8?B?Q2hOTVE2dno0ckpGdEJIKzRxek9MR3ZlS1p6OFpuSjkyd0t5Qktna01rQ243?=
 =?utf-8?B?MFVGaDExM0ZJbWhWdkdEOUdPTVEyTUxiUlJPYndTS2dQN2N5VVA3ODd0YkJ6?=
 =?utf-8?B?Vnp4TDJ1c2htS2JDbXo3WUJSRVo4M3k4Y1FyYnNvSjlsc0ZMN2xOSzM2dkJt?=
 =?utf-8?B?NUxITGJ3ZlU2bHlqditSVEN5UERVRHFMb1cyeXJpTjdGQ1pvZnQvWlFmRDZ2?=
 =?utf-8?B?azk1ZlhmWWI2Ri9uVEhHTE9PSGtCREFDdG8vRTBWa0tPSGhTRkFSU1FSempv?=
 =?utf-8?B?UXNZZGVaV3Vsd25yMzNsU2FqVmtENktxN0JtZEhMR3lmK0ZIc3h2VHN4ZE9J?=
 =?utf-8?B?RXVNSmVta3VYQ2pYYkd3NnM2UHk4cDFEcmdsUENPQmNBOXlYVElmdFAwWHNi?=
 =?utf-8?B?NWpqdDFsSU9BU0liWlJCWmM0aUVLRzBjaEFQc0xjRWd1bnE4aDlRcnJHRG1z?=
 =?utf-8?B?OUNneHFkblo2RkkyMmhSSEhiWHNUZTRrSmxETTdLLzBoZTRFdFZVei9TSzBF?=
 =?utf-8?B?UkY3MCtqckJ3NUVQRGhuRDhiWDEwMG5HcXViejJNYXZNZnlWQlF2ai9yTG94?=
 =?utf-8?B?K2RHMThWMzZBbDZwQUdrR0h4Sm1VenM5SjVVZ0FxNkxsUm0zYzR3bzA5QkdI?=
 =?utf-8?B?Z1MyMDl5MHFEaElwUGJ4SjNxYUxsU3c5RGd5WDZHSDE1dUE4Nm9ML1FSVGIv?=
 =?utf-8?B?TXZmLzVQMmlFVjNJYkV3eVAxdWpDSmpPVGVwaGNUWFQ4a3RrS1VzZ005UW5y?=
 =?utf-8?B?Z1FnMm9nNFZBaEpoODZVMlNHNktKSG02M29qRjh0RkhDZEtraVBrV0s5V1hG?=
 =?utf-8?B?NzZpaldRVFJYZmJBUjl0aTB5MnRlSktJZDFsaXpEZFVGUnRSVFBqT1Y4ZWp0?=
 =?utf-8?B?MGdwL3ZmbTVvaDE1Uys5bXJQcFNZTVBHQlhSOGJ3R2JrYmg0TVlyYW9XRkFT?=
 =?utf-8?B?ZHBuTTFlVUgrUnhORS9BQzdtbnJQWXlXNzI1R0x3TkpjVThYKzNZWlBMWno4?=
 =?utf-8?B?UzFLd3JGd21kcENXTEEvaTZWeGkzTTZHVW9VN2RDTVJ0MDEyVCtUQ1dSZHNJ?=
 =?utf-8?B?ZVpjRmRkZFBEdnFXVUpCNjFtY2hiaVlDSDJCU3FRZFA0alJhdHh6RWpVdFM3?=
 =?utf-8?B?WUFFU01yNVRwRFErSGROanZnWlAraENFelBJeHllaStwc0ZZZFJ5aEg0K0VI?=
 =?utf-8?B?MHNhOWYwV0dOZSs5MXc5OGRnSUVzeUtzSk0vM21iWFZuUmcvaEs3VllVNHgw?=
 =?utf-8?B?cnF1Q081M1lvTS9zc1JiK05VT2JuOHRrdDA3dW1OK1JnRUZuWm4ycnVxb052?=
 =?utf-8?B?OUoxWUo2ZFVUZysxaGNOODluaVN2OHJiU3AzcElLV2dISTVpTVh5SDdLZFpx?=
 =?utf-8?B?Qk9yTEcxcVdQZUtNUW8ydEt0Q3o3QVUwMWo5Uzl5cTFyd3JmMHRtVXIxNjJU?=
 =?utf-8?B?alFnc3RxT2NpTmR6TDdGQWY2d21vTWkrN01QRHQwOVlWVTllZ05hWko5Ni81?=
 =?utf-8?B?bTd2WGFaYzc2SzhPZUllU3N1NE9hY21hWEZxNFo1Z0k4ZHdibVN4QT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0UnQzg2ho1Gd+r5P+DQqIeNzXUfmT6YeAHytJo0T45h2tQkeSgMQPDPgcmSkRzWBxpEWtunk025IJB1FtSEOqmCBIa6MVhCP1EygQvKNVJjzPhB5ptR/gXuN9A8SZtlCAhT9hqlIO813nBg0eILallnuML1xVKBEbOOYuHQWtAd+TDoszX/7AeDVIn+zwnSgOCzZc6VXTaOUyHkbc5QZbXPFtlWgykz68eXDdNrroNDpxZWwuZrbLV8MkiUmpkv6CaBwMHPN5pMc2QdZI4MQZ39wwOxHKYY2INBzkA3ABkBU6OpNNAi7yzupFUtW4NIyZa+sdKX96PNlKbGI15RfWuNQB1jJqJAJXLV79WEWortiz9ux0UKkQh6rrMH7oB8IE01ukm4x2G8HSteAN+tNZCViynV+KaooYhmodsUzW98syHTHYhNW3/SIO+7BD9QvRNOvq7n0RpwoVk2VzCM4+u1ah9XIBHtA34cVifmh+CVvBoRpEqiUjlgF3pheLxLpZlEgOddrJ6AoDAxYlBOHX/SnhgfDC0PJ2YXMyl0PgYaJU3qXzDWfa9R7qxBpak2jp0j7Olxn6LJzJX64/yrmjm98r3MnXOlX2FMFjoHuk8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4541fc-0367-480b-cca7-08de7492f062
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 17:25:58.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVO3gNEefAxPyI/f/xJmypys01zq2b5j7FZVSTKD6BxnDwpDwUcWrr/xYfRtPOPBTJBmlHNExh21C3JyeouIZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE2NyBTYWx0ZWRfXyx2gaUOGOSwg
 T8TYwBZvn5USa0ECugvfozCZ7iQCZppgP5MnOtylbmY9ORZbwyb1hAoqYUIsRjMwyLFNQdT9Kq9
 HB9LBm27PJcyKSAqEQsULnGT1toqksWgBpvkBFeNWUeOBvAHwPBSDumOEI2jWek+NDeUQl6n9/3
 8FD5qdNGydeJ1fmE042YVuAAo5JK+uJumEvMiIbU58Ir0OhSGuAUnfi2Km7rIwfqR5oce2XkgER
 jVGDxs70693lXJK1yLT7I7/5ildNy1nmaI9Yrof5Fm2fQlRpwV5bbTYUdm6by2jLoD9NWiE2B7W
 50IRj3NNc4m86KcER0AgRFnGvYyqsfXhlzPP3Z9AELmvfMymtBeK9aSpvh20JTlXRD+4zSg3QOA
 9vPPrRGEUiZexjAAF8IXetLeUHeXWVHUbXJIUK1OvA7Y598im2AsTbLcnjZIUsQlG48fd9QQCbX
 nX/6Q3eO8RhYlrc7G0Cr8CbVQCabrYgQTAv2MeaU=
X-Proofpoint-GUID: HVb09vObplo8ZSTm3ykd6kSONgriLCAS
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699f30aa b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=c9H0zXf6WSiqR4uV_aoA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12262
X-Proofpoint-ORIG-GUID: HVb09vObplo8ZSTm3ykd6kSONgriLCAS
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19248-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2E78319B850
X-Rspamd-Action: no action


On 2/25/26 4:40 AM, Jeff Layton wrote:
> I had Claude take a look and it came up with this:
>
> Moves the callback RPC program, version, and stats structures from
> global statics into struct nfsd_net so that each network namespace
> gets its own callback counters and program definition.

Clause describes it much more precise than I did, pretty soon I'll
be out a job :). Fix in v3.

>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index aea8bdd2fdc49..aad4276b2f1bc 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
> [ ... ]
>
>> +int nfsd_net_cb_stats_init(struct nfsd_net *nn)
>> +{
>> +     nn->nfsd_cb_version4.counts = kzalloc_objs(unsigned int,
>> +                     ARRAY_SIZE(nfs4_cb_procedures), GFP_KERNEL);
>> +     if (!nn->nfsd_cb_version4.counts)
>> +             return -ENOMEM;
> [ ... ]
>
>> +     nn->nfsd_cb_program.name = "nfs4_cb";
>> +     nn->nfsd_cb_program.number = NFS4_CALLBACK;
>> +     nn->nfsd_cb_program.nrvers = sizeof(struct rpc_version *) * 2;
>                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Should this be ARRAY_SIZE(nn->nfsd_cb_versions) instead?  The nrvers
> field is documented as "number of versions" in struct rpc_program.
> The old code used ARRAY_SIZE(nfs_cb_version) which evaluated to 2.
>
> sizeof(struct rpc_version *) is 8 on 64-bit, making nrvers 16 here
> while the nfsd_cb_versions array only has 2 elements.  The version
> bounds check in rpc_new_client() compares args->version against
> program->nrvers, and rpc_proc_show() iterates from 0 to nrvers - 1
> accessing program->version[i].

Yes, it's a bug. Fix in v3.

Thanks,
-Dai

>
>> +     nn->nfsd_cb_program.version = &nn->nfsd_cb_versions[0];
>> +     nn->nfsd_cb_program.pipe_dir_name = "nfsd4_cb";
>> +     nn->nfsd_cb_program.stats = &nn->nfsd_cb_stat;
>> +     nn->nfsd_cb_stat.program = &nn->nfsd_cb_program;
>> +
>> +     return 0;
>> +}
>                                                                                 

