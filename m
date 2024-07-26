Return-Path: <linux-nfs+bounces-5075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A30293D64A
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 17:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAE21C234A5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2561017838E;
	Fri, 26 Jul 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BTPziXwh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jxyu9ueM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82A17967C
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008431; cv=fail; b=Qva70O9VE08/H10plOcuijw7g8II4FQRDNaWlh4HmLhttkmFLvO7hKSlBqzQ2HnhBBbMp9d7i6orpk9u7WquWNLOcnDHs29IWw3aTUIGouum5R5Bslt5+IzMxnaK0ocTj7O0xH0PLn5U1vLDpTs1c84T61kVp4HQB72Ezehm2V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008431; c=relaxed/simple;
	bh=V21I3o/XGdofRO8lq3R6J1d0+Q0II+gKIkWjSmTrGkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FBBate6xLVHbmNb5sYMgzAqcfV1QYakZb5d4WCter+yl1R1n9KYEVvS4Xfc+ss1WrfAHU9eYbppJkh4caK4KRtp9s+bL1oszxIRrtgkLmZPggvaPBfYOkZSXl1CwIbk56K/dTF+jY9q3decSTzmNTIr8iLjk8Id1XkNIAbMQF38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BTPziXwh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jxyu9ueM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q8tWVi012537;
	Fri, 26 Jul 2024 15:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=VfuG5G+9I/K4EBJ
	GAVWw4SK6wn+Uni87JRFMr2EdhBM=; b=BTPziXwhw3yaPhOOYTUwptCcQwVbPwo
	xCWRS/bzh88MtKTDDY/FOKJUsIZBsC9IwcK07JpGnU2F3FmJ/jstt93S4gpj9HTb
	2qs8aBo7NZXZJmJ5DPo20QrZ/5JRsJKgt0ewKX4DEIGR7jfKTneKo2NyIRFjfbOk
	FVFuOKDdLlKINLucv0wZM7uangI61/H+ef697ZBJRVgQoFPKls3TghyarsK1c2dv
	4ULZueGSvFuRIByBl6Dp9CNjS5xmHyctvEjCtMnhNFGnF/rsIq3fqeo956wnkAkt
	zMrWBQvAvggcFvvbzUBSP+uwY7suXILT61nvfoq8YXH4AtNfKqeTJyA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0nsme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 15:40:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QFNmos010743;
	Fri, 26 Jul 2024 15:40:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h283y4ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 15:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Viidprn3xGbqQOYmBSekmEm/3vzLIc4cvQAw0t7Zd4akazPTKBMvo96tdca2ftOzPtju+Qo1IU+afJscKUeVHmrq2csAo6KlZLEtHKWY2L+yATpLDI3nYgoI3Jns4BqWBZHX2zSuU8QcOgt7GMWoYL+RvzjpYep2XFEjTVGnsZmT/z26GL7WaHs99qVluKCTadSc4je2mPY+xyl3m4jCOOS+Eiw+gHhfo9mWYZ6LoMzgCRAoUfWywtGzoiXBXzoqX205YQnYs3eHYnq1N0hY9KcAQ4pIUWeKOVKgBdiXfzi/BU/MIZY4A4t+Or2e/yFcAzFYa/7BjmTeGoM1R7tg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfuG5G+9I/K4EBJGAVWw4SK6wn+Uni87JRFMr2EdhBM=;
 b=diqcKiNVTZtrio+EDnJxS4dys9NdbG9VHL8j6IU7BszGoVipclzDwH3w0dAGgM5tmTeYoQerL5fm/bPdTqnEem74c323RiGyrrtQ5gWPDNIo77+FCHmHJntUG+2rmm17tCF8do1glYVyh0OUY9TLa0C4emU/XzSP2apeNXfDYzcSv8JtfKLMeV2jBB1MVEJxmisjun7PCr5hNzwegSIioyKJp7JvUQzthTpo2dSfxRKQJcguy8WJMO3f2V27i2HFjLhletjGAHcWhkZhJIHdzMC9TLNlOmrK/CZp1uvxPfgUGFelZku/7/IXXAVoBEVowdt7SQhJK6/Tv416DLC5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfuG5G+9I/K4EBJGAVWw4SK6wn+Uni87JRFMr2EdhBM=;
 b=Jxyu9ueMdbEJV5vhBUOw3r6xcEP5nRNQWmagyu4LULEwPyQO8AaymBhEsfFfk34mknnwoaZjxuu35BZBezUeR02S8F2M6+kEePL3NoscVXIrGiCcUf/dMUibC2JHmIqOQU/+GajzSQ5VdqSWjUgF8iXaz8O3Ca18x9qb6lfXzoY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 15:40:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 15:40:16 +0000
Date: Fri, 26 Jul 2024 11:40:11 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/6] nfsd: Move error code mapping to per-version xdr
 code.
Message-ID: <ZqPDW/dgEHKBGAUp@tissot.1015granger.net>
References: <20240726022538.32076-1-neilb@suse.de>
 <20240726022538.32076-4-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726022538.32076-4-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:610:b3::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af528cd-9e83-410b-8ab8-08dcad893eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AQ7jFmXU4pINxkNAfvXIkKgOAYw4bM9t4uuqLs0YbS8zTCpr0lMY/zE+SWhr?=
 =?us-ascii?Q?2LZ+x/L1w3Dc7s1egwwGru4Js0iM5k4UnMX759ohpb1HD5PjjdZztytX//45?=
 =?us-ascii?Q?xEwVE9D3FI+fOCy7FqJrfLa2Six+wBY3u8WevfhwfAjDDDXrLD2GxvVb5gEm?=
 =?us-ascii?Q?oaYBVpcCiuZjDSaqHL3uHNpiEwjyFkQOMr/L7/SrkqW8dOGkIBUTQSqj8peC?=
 =?us-ascii?Q?cT+BU3WbHDK/56b5q0yK5C0yXO0UFiB0+JwY9fo2jsAfGY2GtDNA1AShab8h?=
 =?us-ascii?Q?3CFIvNTD41naBKs6znlYwh/PCzH4ngo+nPgRBBYNbnrrUlQ9opj//LfU95hF?=
 =?us-ascii?Q?nWEpweL4WLzCeKy70uUKHw7bCw/L7dR+lrtidVmGuuJ7+VoMlB7NN7LfcmII?=
 =?us-ascii?Q?NYfogqK6+Z2DTnvB4EocpTW2gt1FTzTGy4X0hitV3mTpzQZlTU1cyWrr7D4W?=
 =?us-ascii?Q?/Pl0vjOyUzSrV9T0h4Uo5nPKR6JHY7lXD3D9CcFAYui8p0b/i4rC9PpmFc+S?=
 =?us-ascii?Q?XPXpRdZBWnR+hf/wbR2frzYPUd6hruNjzU/WBvdj2RLsvTN228atRMWoklsN?=
 =?us-ascii?Q?e/YiNvmx683RiFJuquY0WZ2yf44DH4HhKpP9DH5u6X4qiN7Wia/0VA0bOYnc?=
 =?us-ascii?Q?G2+/XVL0dJH4U5Ayr2QVbcQ0KkLXmZa6L+dALHm7O0YNfUerp+ZfBU/vVT9f?=
 =?us-ascii?Q?emrlvLWL9KJ6y6yVeoyGBRXT0B7vbcX9WvrgRhi1gGWSLoTWfQBxEJScW4kW?=
 =?us-ascii?Q?9hBz9f8N7JGEWFh4gDsgh07CSWRUvvLMyq+C9a+9ViwiM+qXChWG1U26+mDM?=
 =?us-ascii?Q?3lkvNEFd3aV/BQ26at+dfUoBiI3DVT4uCnSfzYjVqqfZG4zsXEZ+5xmRGYjs?=
 =?us-ascii?Q?yqzL2OHpGGkk0QwT+MGIsKM9cMlR33RAM9pFuz/D8jUVzYQWtcQNjJvtqsKB?=
 =?us-ascii?Q?zNBsB6aH2Wo8BJ/v1F8Ic5iJh65P3XQ+vCD19nhxvn1FBiGOfcEzTc/qDTEr?=
 =?us-ascii?Q?Utr8dU2lg5lybE8HzF8BSIY7bubATD4gP/JYiLa3KwLjI8Fy7ncHiIpIkC+C?=
 =?us-ascii?Q?AYYOq/7TNfPxrAAtHpBlhQbbTRI+DaNMRWCZK80OPytbfosbesYnWufnJD62?=
 =?us-ascii?Q?ItHUTcEmNnHFdkABmfWjWJ+5F94IM5pgglUD1vYdijEJKJ8yG0R5KrRT8eLP?=
 =?us-ascii?Q?PgyXI+M0oeklP1/9t58Dzav69llOCDAMAeT8ksXEJSrDquOQsXRe5ASiKxo2?=
 =?us-ascii?Q?Q7c992ArDJDEkr2itYoBI6M/jjoOoQGE6b4WUsr7wkSCt/5Fgk/5l6/SeISH?=
 =?us-ascii?Q?G5iYjjSmqIYuFM9OSA/a1KGgxwxC0LZowMY/wx0FHQM6/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aMFWRTaY209XpUGEbZdG/yiqMwKrvB5DtdQ9dvEbJSnmKzpbFpXlUJT7My1y?=
 =?us-ascii?Q?hc5NlMW1S/d4GHrYwgR+9nheOB1SPcwMrTJHCE6wJ1ShgPhM+cVrlPq8abVI?=
 =?us-ascii?Q?cBpZ48683cI3F5BtgF59MxnqNr3at39PxKoRHD4kSdpj9i2Cg+iiA6v6gbCM?=
 =?us-ascii?Q?JoMX0R4LdkJm7iM25TWSOK7ddPc8boFvOKGs91kZSQGAE2dnAakj2qb/iT49?=
 =?us-ascii?Q?WyXlMQwp6/gK/2lK6Piski05n/zzoqfQjKrNYtDIvouKEhaM/oPzFCHS8+YR?=
 =?us-ascii?Q?J9jm3BLmCfcUI/OG90S5Wd6tUNqSOpei/AGU2+HydfAcyenamFUThajDno3K?=
 =?us-ascii?Q?i8kcWcmaysAsQioAF6TVBP1etcMI6wlYmmdjS/bqyFu3fwAInwwJ/bAiznE+?=
 =?us-ascii?Q?QWLCl1uqsvAG6+RC03zQBN524qrcjIdzN40uzLvbyQRKUg45f5u9sUrqKnYC?=
 =?us-ascii?Q?DLof7j7z9a6A51i0x2yAet1DmYws8A4Z7rEj0QqPOSHJvdVFsUNV/bNFqmMn?=
 =?us-ascii?Q?0Mrh5aM8yDK3MdLzN0Mbvjei+1G55ZI5Ub2q8Hks6rZIMiunBeaLDa7PTnGk?=
 =?us-ascii?Q?GB/8Yi++JVA08LxAo27VILzsCS+QuFpXEGMbcjn7802nif9/u6AA1KiDsKkk?=
 =?us-ascii?Q?2P+yjUm4AXe9cu7n59RJY2qZJCzbO8M8oi1OB5L+Tgz66pizlArWM5XbeA0V?=
 =?us-ascii?Q?K//TRX9PpLPz2cDsV9cZaUDdVWmg4WnxvmRpebLPXUEqcRma9KmxHgWM4Eg3?=
 =?us-ascii?Q?qGqqYnPm+V9vBNjG1q6gXkLjL0A8Akd2gs8DslmGVRBLpPfQRlQIAvw2E5BG?=
 =?us-ascii?Q?1b1gDGP3tPrj/m1dkb3yXttDmxXiNAT5eV9gnvwxCJ0UIA+RUIyLox0qUHLD?=
 =?us-ascii?Q?A22R9YE5qmQeQlBwklxhL+KGZwJmMmZl1LtELDj52r3m0CF92hl6Jp9mKNHX?=
 =?us-ascii?Q?gZ/NzdtG3Z4O+zsFknof0wO7pkNRvoR7apKct75tXyHknGm3DUmx4vO8Ci6Z?=
 =?us-ascii?Q?X5xQb+WlSM5a9Wv+hWzgsosow4pnc9Ltbf3+VzS/4j/NLusidjB1mLSyUYRx?=
 =?us-ascii?Q?7nPUAe6OkuBJdvrAWxYrUblpiz92hNevIl95vg37qDxMcMQ879VUtLVOinW5?=
 =?us-ascii?Q?WTiXQmaF1Nm31WfqL3Vztk/V3V+hLgdAXB1KDkOSZPeiYn4gHQ7MClKRQJNL?=
 =?us-ascii?Q?djO9P/TKmOkmYiCaAk9fL1jbr+U27vEDrw8BFI43/JqbqwWl9u6V+h+1x7gv?=
 =?us-ascii?Q?/Wh+iYttSfYlBFMTrxGRwYM61RU3pmmjK2WIWGx9+cMjWTFvEIDgy9PMYCiQ?=
 =?us-ascii?Q?AnYfUQZbMy53+PpykWsl4NRd+yK02Mnb9gegjNSpnn7QujqkXujtrd8mYWs2?=
 =?us-ascii?Q?Ac9PPmBn83U3MEeW8fkGbhAoFGGygQ4GdcLFt8CyLUmBkH7tEVzr+6Pmsjem?=
 =?us-ascii?Q?EO28eYhayRxv4fLy28hu26o2NKMh/hhO9+dr5l27BX1UOjVdjUkG+cvEnHhY?=
 =?us-ascii?Q?Iabs6d1cUgc4XMDRzOloOP2RlgcQAiI8GuWotXpbSrPkm+ixyqDrtxyjG/r0?=
 =?us-ascii?Q?ysYmmyL9hTNXF3f6044tYKqwwBwlkK8WRbAcsSiWA/ExGY/7Ais5DChd5ceF?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pGItT6aP3rNayIGRF1Yi8CFC2A/8kovHqObSM/XKZG8vcG0aJXjrTDthZB7JXdMmUc0Q1EiTX+CPxw10xHEwXhKe3oMxXiLhUUxU7KvyELHOtG+DGBbHiEhzeCG2MzqFF4b+TsCAulp8fAqyqJWgmMoiEiXUm1Zv02maSQ9A605j9yM1Yk8mhN34k/KixDArJOe+UHACgfpwGyyF+1rl0YpDJK81IdFnLlNUQnRbOrpVCqJINCyqETkH1hW96e3vkR8dH+P8ooU3t+UB8ky2ow2IqP3w1sloKblGANMsbqYMkbNWB1x6OdCigcoJKeXDjPTjb5sET+ObxKON+4qHmDbq2ej4Bk4aQYLzvSjcYxO4/zss0ZDSDadxOBX9s/qHyHlmJD12pBFdm8/juA2DRQr40p8OiJYEpK4kRmeac56LUO1tmLwbRDustcEA7PqIdZCPq6ZtWi1K4MiuEgFwlZGS/d+/8PV8BVBr6PXxbU5bNI0e+qkY51UtsLwYkGLtGFt/69kT14XKLb9vqj/za0zofZKw7QHoOWIHqeJ39amQxUWFwrjboXlJyijow2i5Z0SD2438BgJTdI6vdNSAY/CFunOHoLeVvARpJFa18ts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af528cd-9e83-410b-8ab8-08dcad893eff
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 15:40:16.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXszqp230V2wAUHqC4IHaDoXC+yd6E+JjAx4Zm6xsBYn9wS+YsJwqIsgTvj6tQfPUzZv6exptoypI7OMpwdCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407260105
X-Proofpoint-GUID: 18lgWTMDZxQiXDC68xuPoa1b0uooJF2x
X-Proofpoint-ORIG-GUID: 18lgWTMDZxQiXDC68xuPoa1b0uooJF2x

On Thu, Jul 25, 2024 at 10:21:32PM -0400, NeilBrown wrote:
> There is code scatter around nfsd which chooses an error status based on
> the particular version of nfs being used.  It is cleaner to have the
> version specific choices in version specific code.
> 
> With this patch common code returns the most specific error code
> possible and the version specific code maps that if necessary.

I applaud the top-level goal of this patch. There are some details
that I'm not comfortable with. (And I've already applied the other
patches in this series; nice work).


> One complication is that the NFSv4 code NFS4ERR_SYMLINK might be used
> where v3 expects NFSERR_NOTDIR of NFSERR_INVAL.  To handle this we
> introduce an internal error code NFSERR_SYMLINK_NOT_DIR and convert that
> as appropriate for all versions.

IMO this patch is trying to do too much at once, both from a review
standpoint and also in terms of bisectability.

Can you break it up so that the SYMLINK-related changes are
separated from, eg, the xdev and other changes which are somewhat
less controversial?

More specific comments below.


> The selection of numbers for internal error codes was previously ad hoc.
> Now it uses an enum which starts at the first unused error code.
> 
> NFSv4.1+ now returns NFS4ERR_WRONG_TYPE when that is appropriate.  It
> previously returned NFS4ERR_SYMLINK as that seemed best for NFSv4.0.
> According to RFC5661 15.1.2.9 NFSv4.0 was expected to return
> NFSERR_INVAL in these cases, so that is how the code now behaves.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/export.c     |  2 +-
>  fs/nfsd/nfs3xdr.c    | 17 +++++++++++++++++
>  fs/nfsd/nfs4proc.c   | 11 +++--------
>  fs/nfsd/nfs4xdr.c    | 15 +++++++++++++++
>  fs/nfsd/nfsd.h       | 23 +++++++++++++++++++----
>  fs/nfsd/nfsfh.c      | 26 ++++++++++----------------
>  fs/nfsd/nfsxdr.c     | 19 +++++++++++++++++++
>  fs/nfsd/vfs.c        | 14 ++++----------
>  include/linux/nfs4.h |  3 +++
>  9 files changed, 91 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 9aa5f95f18a8..7bb4f2075ac5 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1121,7 +1121,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
>  		return 0;
>  
>  denied:
> -	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
> +	return nfserr_wrongsec;
>  }
>  
>  /*
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index a7a07470c1f8..8d75759c600d 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -111,6 +111,23 @@ svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be32 status)
>  {
>  	__be32 *p;
>  
> +	switch (status) {
> +	case nfserr_symlink_not_dir:
> +		status = nfserr_notdir;
> +		break;
> +	case nfserr_symlink:
> +	case nfserr_wrong_type:
> +		status = nfserr_inval;
> +		break;
> +	case nfserr_nofilehandle:
> +		status = nfserr_badhandle;
> +		break;
> +	case nfserr_wrongsec:
> +	case nfserr_file_open:
> +		status = nfserr_acces;
> +		break;
> +	}
> +

This is entirely the wrong place for this logic. It is specific to
symlinks, and it is not XDR layer functionality. I prefer to see
this moved to the proc functions that need it.

The layering here is that XDR should handle only data serialization.
Transformations like this go upstairs in the proc layer. I know NFSD
doesn't always adhere to this layering model, very often out of
convenience, but I want new code to try to stick to a stricter
layering model.

Again, the reason for this is that eventually much of the existing
XDR code will be replaced by machine-generated code. Adding bespoke
bits of logic here makes the task of converting this code more
difficult.


>  	p = xdr_reserve_space(xdr, sizeof(status));
>  	if (!p)
>  		return false;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d5ed01c72910..c4b65f747d8b 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -166,14 +166,9 @@ static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
>  		return nfs_ok;
>  	if (S_ISDIR(mode))
>  		return nfserr_isdir;
> -	/*
> -	 * Using err_symlink as our catch-all case may look odd; but
> -	 * there's no other obvious error for this case in 4.0, and we
> -	 * happen to know that it will cause the linux v4 client to do
> -	 * the right thing on attempts to open something other than a
> -	 * regular file.
> -	 */
> -	return nfserr_symlink;
> +	if (S_ISLNK(mode))
> +		return nfserr_symlink;
> +	return nfserr_wrong_type;
>  }
>  
>  static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh *resfh)
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c7bfd2180e3f..117dea18cbc8 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5748,6 +5748,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
>  
>  	if (op->opnum == OP_ILLEGAL)
>  		goto status;
> +
> +	if (op->status == nfserr_wrong_type &&
> +	    resp->cstate.minorversion == 0)
> +		/* RFC5661 - 15.1.2.9 */
> +		op->status = nfserr_inval;
> +	if (op->status == nfserr_symlink_not_dir)
> +		op->status = nfserr_symlink;
> +

Ditto here.


>  	if (op->status && opdesc &&
>  			!(opdesc->op_flags & OP_NONTRIVIAL_ERROR_ENCODE))
>  		goto status;
> @@ -5870,6 +5878,13 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  	 */
>  	p = resp->statusp;
>  
> +	if (resp->cstate.status == nfserr_wrong_type &&
> +	    resp->cstate.minorversion == 0)
> +		/* RFC5661 - 15.1.2.9 */
> +		resp->cstate.status = nfserr_inval;
> +	if (resp->cstate.status == nfserr_symlink_not_dir)
> +		resp->cstate.status = nfserr_symlink;
> +

And here.

>  	*p++ = resp->cstate.status;
>  	*p++ = htonl(resp->taglen);
>  	memcpy(p, resp->tag, resp->taglen);
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 8f4f239d9f8a..0f499066aa72 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -327,16 +327,31 @@ void		nfsd_lockd_shutdown(void);
>  #define nfserr_noxattr			cpu_to_be32(NFS4ERR_NOXATTR)
>  
>  /* error codes for internal use */
> +enum {
> +	NFSERR_DROPIT = NFS4ERR_FIRST_FREE,
>  /* if a request fails due to kmalloc failure, it gets dropped.
>   *  Client should resend eventually
>   */
> -#define	nfserr_dropit		cpu_to_be32(30000)
> +#define	nfserr_dropit		cpu_to_be32(NFSERR_DROPIT)
> +
>  /* end-of-file indicator in readdir */
> -#define	nfserr_eof		cpu_to_be32(30001)
> +	NFSERR_EOF,
> +#define	nfserr_eof		cpu_to_be32(NFSERR_EOF)
> +
>  /* replay detected */
> -#define	nfserr_replay_me	cpu_to_be32(11001)
> +	NFSERR_REPLAY_ME,
> +#define	nfserr_replay_me	cpu_to_be32(NFSERR_REPLAY_ME)
> +
>  /* nfs41 replay detected */
> -#define	nfserr_replay_cache	cpu_to_be32(11002)
> +	NFSERR_REPLAY_CACHE,
> +#define	nfserr_replay_cache	cpu_to_be32(NFSERR_REPLAY_CACHE)
> +
> +/* symlink found where dir expected - handled differently to
> + * other symlink found errors by NSv3.

^NSv3^NFSv3


> + */
> +	NFSERR_SYMLINK_NOT_DIR,
> +#define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
> +};

It's confusing to me that we're using the same naming scheme for
symbolic status codes defined by spec and the ones defined for
internal use only. It would be nice to rename these, say, with an
_INT_ or _INTL_ in their name somewhere.

A short comment that explains why these /internal/ error codes need
big-endian versions would be helpful to add. I assume it's because
they will be stored or returned via a __be32 result that actually
does sometimes carry an on-the-wire status code.

As a note about patch series organization, it would be helpful to
split this hunk into a separate, preceding patch, IMO.


>  /* Check for dir entries '.' and '..' */
>  #define isdotent(n, l)	(l < 3 && n[0] == '.' && (l == 1 || n[1] == '.'))
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index a485d630d10e..8fb56e2f896c 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -62,8 +62,7 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
>   * the write call).
>   */
>  static inline __be32
> -nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
> -		umode_t requested)
> +nfsd_mode_check(struct dentry *dentry, umode_t requested)
>  {
>  	umode_t mode = d_inode(dentry)->i_mode & S_IFMT;
>  
> @@ -76,17 +75,16 @@ nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
>  		}
>  		return nfs_ok;
>  	}
> -	/*
> -	 * v4 has an error more specific than err_notdir which we should
> -	 * return in preference to err_notdir:
> -	 */
> -	if (rqstp->rq_vers == 4 && mode == S_IFLNK)
> +	if (mode == S_IFLNK) {
> +		if (requested == S_IFDIR)
> +			return nfserr_symlink_not_dir;
>  		return nfserr_symlink;
> +	}
>  	if (requested == S_IFDIR)
>  		return nfserr_notdir;
>  	if (mode == S_IFDIR)
>  		return nfserr_isdir;
> -	return nfserr_inval;
> +	return nfserr_wrong_type;
>  }
>  
>  static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int flags)
> @@ -162,10 +160,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	int len;
>  	__be32 error;
>  
> -	error = nfserr_stale;
> -	if (rqstp->rq_vers > 2)
> -		error = nfserr_badhandle;
> -	if (rqstp->rq_vers == 4 && fh->fh_size == 0)
> +	error = nfserr_badhandle;
> +	if (fh->fh_size == 0)
>  		return nfserr_nofilehandle;
>  
>  	if (fh->fh_version != 1)
> @@ -239,9 +235,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	/*
>  	 * Look up the dentry using the NFS file handle.
>  	 */
> -	error = nfserr_stale;
> -	if (rqstp->rq_vers > 2)
> -		error = nfserr_badhandle;
> +	error = nfserr_badhandle;
>  
>  	fileid_type = fh->fh_fileid_type;
>  
> @@ -368,7 +362,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  	if (error)
>  		goto out;
>  
> -	error = nfsd_mode_check(rqstp, dentry, type);
> +	error = nfsd_mode_check(dentry, type);
>  	if (error)
>  		goto out;
>  
> diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
> index 5777f40c7353..9bb306bdc225 100644
> --- a/fs/nfsd/nfsxdr.c
> +++ b/fs/nfsd/nfsxdr.c
> @@ -38,6 +38,25 @@ svcxdr_encode_stat(struct xdr_stream *xdr, __be32 status)
>  {
>  	__be32 *p;
>  
> +	switch (status) {
> +	case nfserr_symlink_not_dir:
> +		status = nfserr_notdir;
> +		break;
> +	case nfserr_symlink:
> +	case nfserr_wrong_type:
> +		status = nfserr_inval;
> +		break;
> +	case nfserr_nofilehandle:
> +	case nfserr_badhandle:
> +		status = nfserr_stale;
> +		break;
> +	case nfserr_wrongsec:
> +	case nfserr_xdev:
> +	case nfserr_file_open:
> +		status = nfserr_acces;
> +		break;
> +	}
> +

Same comment as above.


>  	p = xdr_reserve_space(xdr, sizeof(status));
>  	if (!p)
>  		return false;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 0862f6ae86a9..cf96a2ef6533 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1770,10 +1770,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
>  		if (!err)
>  			err = nfserrno(commit_metadata(tfhp));
>  	} else {
> -		if (host_err == -EXDEV && rqstp->rq_vers == 2)
> -			err = nfserr_acces;
> -		else
> -			err = nfserrno(host_err);
> +		err = nfserrno(host_err);
>  	}
>  	dput(dnew);
>  out_drop_write:
> @@ -1839,7 +1836,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
>  		goto out;
>  
> -	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
> +	err = nfserr_xdev;
>  	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
>  		goto out;
>  	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
> @@ -1854,7 +1851,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  
>  	trap = lock_rename(tdentry, fdentry);
>  	if (IS_ERR(trap)) {
> -		err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
> +		err = nfserr_xdev;
>  		goto out_want_write;
>  	}
>  	err = fh_fill_pre_attrs(ffhp);
> @@ -2023,10 +2020,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>  		/* name is mounted-on. There is no perfect
>  		 * error status.
>  		 */
> -		if (nfsd_v4client(rqstp))
> -			err = nfserr_file_open;
> -		else
> -			err = nfserr_acces;
> +		err = nfserr_file_open;
>  	} else {
>  		err = nfserrno(host_err);
>  	}
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 0d896ce296ce..04dad965fa66 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -290,6 +290,9 @@ enum nfsstat4 {
>  	/* xattr (RFC8276) */
>  	NFS4ERR_NOXATTR        = 10095,
>  	NFS4ERR_XATTR2BIG      = 10096,
> +
> +	/* can be used for internal errors */
> +	NFS4ERR_FIRST_FREE
>  };
>  
>  /* error codes for internal client use */
> -- 
> 2.44.0
> 

-- 
Chuck Lever

