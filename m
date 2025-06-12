Return-Path: <linux-nfs+bounces-12388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D0AD7867
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 18:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4698F3AC4AE
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C67299AB5;
	Thu, 12 Jun 2025 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gWlsBSRJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A2/RttQW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820632F4328;
	Thu, 12 Jun 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746576; cv=fail; b=KFgOSjsvFfQLjdfopvqlnFG85JU96ydL47hSOFxH4qGAy6YuRRRQMooByQg/f/ibcc+Q6SpZa3SlBp60C1V7Ad/ntF9ooYeauPqP7zK8Ci6de+5qRz2SxKfDPzp2ACs9xCktS6i6rOELvnNEPOGLymzO/B4nnPhzA8EChanQeRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746576; c=relaxed/simple;
	bh=ROR7fmj0QzVQbtxfsHRTCMjitsznJcYvciwVmhGE+mE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cyAesrWW7UWE4yN2hYmBd2hGYEF/qNKdHUj0uhc9PSTEzk86laEfkhn1kYyV++DRwe8r/EyjRnFCwXeaiQjL2I9a/TgvYP5/MwWqaXRsYBKmqtoLLUjT2A9AqHRFEHTeGuqCpaI2WHBO0c+CBv+XImTe6iEbMdaw8835pzLyaCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gWlsBSRJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A2/RttQW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CEtb9I003338;
	Thu, 12 Jun 2025 16:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GsgpxplM0o6mgARKbaMdCoi4PjWWLdnyvfHte6rVTHY=; b=
	gWlsBSRJgnBqcURpm9hpnDVTTqGX49Nfvttykvno8wezPwbjV2+uy0VC6Rhi+SiV
	YuOBdGrHHdF6EfGJRPVtzrvIs8MynJWg1BNVF8Lu8r2QxeLZrrdAyScg2YFCNegL
	lwXtRZYK4xA0xz+kf2dVIb66nb/uIxYgfrtwSHYRrukCXPk526FnyMIhIcPT+U4o
	kjywjed48sZLId/kSFvObs+AYTVZV6E5gnmZk7TZut+HXQmgsQfjUYAk647Z3Or5
	jzuMsPZ3/z4VNHW1tv3pWrmaB7g2itxi6R2d2viirO29PQJKvXi+pOc2hEeFZ0GI
	QMerCtGcVGBCmfK7/xLmBg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14j4eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 16:42:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CG4aGZ040639;
	Thu, 12 Jun 2025 16:42:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvcu29x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 16:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNjEgCzZqdzqAkx/bKWOHaVhyTOCL52oRewF+l98rebzJ57Z5vy8vmtpSRd5yHHWuDD+B6mpmnzhbZ5A5rUG/UJ6+TrvN4QyMaLtUjkzmU912Jbf6y9nLfaADn3inDUlOsyml8p6bYV0S3zdBoiE/emH9a6IBsXuSHiMjRA762w1hzpvJ+fpXZXZOIHs3lmvNExkvkKUKSb4Z5E1a64M/RtMAJAt2mUCmxBSJPerprJxuN2tvx5LiEtxmSldKwGqCDMBbjrnYIMatQ+8pkTRcOq2gXeWJ/kgZCDZKnk85pBous7q+R1laDqztTVDG3m1MDk56mApXd4J1rWjQ6LJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsgpxplM0o6mgARKbaMdCoi4PjWWLdnyvfHte6rVTHY=;
 b=JObSbNas5wpc5IsyMH+3tGV9Di9TWjWfOC6AOT3nt33/i0pzR/uuP49rGHOIWuyCpYOVYRUoL36icJyCVLYCf00dgAag4MRxukeemMQbSBUt/a5jqMuqctyFdsEc2blcZ8YmgX/j597hhSv5cZbnUKYxrZggVmhccabdb3BvVLOw3SHTm4XHy4bPy+f7fyfgGrwRTXDRxa4ikvcjgnNwnZTR1fDD5Ph0i1Tw/bEwjYdjIwePwCTMy4fh45w4EifHMadM4al/i2KnPVJyU7OCKHOGICvCMNH2PKCDHMqfiWHGzrFAEWH76lrjthUbKTSYqOIllTXYtPY4MydxGvxkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsgpxplM0o6mgARKbaMdCoi4PjWWLdnyvfHte6rVTHY=;
 b=A2/RttQWAI1wAxfQHEjDJtbQnv+n8ax09QQv3vhRmHuNm1JLuZmbxI0yzp9k3wAExDaMTlQbsilFHmMWVuAviFmstpfPT5JFQ7Vj38cFVc71gOB+JGoI05MAdeFVjZ4Ab4QpCLJ7fSDN6XRrtyrF3zrA7K92rUJVhVQEpypnrFs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5814.namprd10.prod.outlook.com (2603:10b6:510:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 16:42:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 16:42:34 +0000
Message-ID: <38f1974c-f487-49b0-9447-74ed2db6ca7e@oracle.com>
Date: Thu, 12 Jun 2025 12:42:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
 <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>
 <ae18305b-167d-4f27-bc3b-3d2d5f216d85@oracle.com>
 <1cd4d07f7afbd7322a1330a49a2cc24e8ff801cd.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1cd4d07f7afbd7322a1330a49a2cc24e8ff801cd.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:610:53::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3c4048-d8c8-42e2-8eba-08dda9d02208
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZmFma1FFMWp6N3VHYy9GZFk4QVZHMGE3OTROQ0x4eWg2aXRvU3dIejNaYjlq?=
 =?utf-8?B?NGJvYnhFTWpUZG8yTVE2VkhlaVU3Zmw2aExqMUs4ZFdEalJvSDQxb21GSU5i?=
 =?utf-8?B?eXRoUExkNEloT0dja0pIdVRnYzdXVU5oRWJZby9rZ3dadzhpbHllOWpXcUhY?=
 =?utf-8?B?Q0lZc3Y3bDlXa0h5V3FEQ3pQcnJHckYxSXFld0NWRG5GSHZXbHBQcTQ5Sysx?=
 =?utf-8?B?MThldlRzTHJrcVZSdnQ5TW5JMXJzT1JjNHVqUjdEMVR4MTZWYVV3aFoyK3Zj?=
 =?utf-8?B?cTN2VlpRUWZjSDh0OUlvZlhML09aY1RWY2JFVnBGdmllS1JKeEVQOFlheXRq?=
 =?utf-8?B?ZUtzM0pkNkdYUDZMM05qVGZ0STA5NmRzVFdmcHdWVHdZVm0yR1lzWXJRNlNo?=
 =?utf-8?B?QTcxOVkwUDJ2cXgvWHdZWEIvMVc2QlExSmp3YXVqemdpdUZFSVg5bjJrYzRv?=
 =?utf-8?B?ZkUxK1lZMENiUkllNFgyUFRMdUtJTmphYmZmZWFFUUJwY1FzUHJQT0pENHVC?=
 =?utf-8?B?SXpGYjV4MGF6VEc4N1M2RlBqS0h0RUp6Q2svbDErMEtZZnF0ZXJTRHhTL1dq?=
 =?utf-8?B?My96SmhTcXhBbERaaEVyNjZYRzJiQUtvNjdDZkpVdU8vQU1vS2x4UFBOV0Rs?=
 =?utf-8?B?MWlYWWQxcXM1UzlOOGtqajdpS2t4VlZKU3BUOWVITWtuQjZwdlM4SkZBd3Q2?=
 =?utf-8?B?WkprOFZaenZ4dWFkTXUxWU9ydnFPVTdqQmdrL2FTV1duUDF4RDFlRW1qUkJ4?=
 =?utf-8?B?VGlZZmVMZzhzME1KcUhadkNtL2hjUWFTdFh6T2hQQ0VrbTlHWnBLRFZNTUlO?=
 =?utf-8?B?dldZNi92NnNFWFJPUDJESFBHMW16elY5RGYwakVIQTBLVVRNTlZhakN0ZDJw?=
 =?utf-8?B?WkVlY29FTGNobWdOMytKdEppaVVaa0I0NlEzK3JINGFITGhhK1oyRDgzUnFY?=
 =?utf-8?B?bUp6eDlBSGNHTHk3WDR3eFU3dHYrOVlaSHFRNU9mZTF0K3BzaHhzSjFMNWtI?=
 =?utf-8?B?Z0xhSHE0algyU1RWaHd5MC8rVUR1OUJJQ1dLMnlRMW9vRlhYQjlRYVBkZDZX?=
 =?utf-8?B?ay9lVFZTdHkzTVBveCszU1U4LzZwVGtnQnJvS0JERU05Qm0zQWsxSjA5bStH?=
 =?utf-8?B?U1h5a3JDMFNtbWpvWmQ0VVd2TmdNUWNybHlCYi9BUEpreHR5L1Q0S29iMWVQ?=
 =?utf-8?B?MTV4eEIwVGhxenozLzZFUktTODBvN2RYbnF3Q21lWmg5dSt2NFEzdXZwUmF0?=
 =?utf-8?B?Y2hyQ21wbllZZWlXb2tiSHBhV2djSGtlMkNRZVlsanQ3K28rQkwzN3pkZk9u?=
 =?utf-8?B?L01VUmtBaFlha3R2cVVHZktHM0VadERrU3A3dXhnU0lhamFnbkQ5VE5VanlM?=
 =?utf-8?B?QXRVV05VdkRjcVpSN3MrckFNeHpsMlFFb2xYVFJBOU1XM3YrbkF6L3dwdEhj?=
 =?utf-8?B?Z1JYRm1hMVE5OHVsS1p1bGczSGpkMXRTRSthVmI1SDdDTlZ3czV2cllqdkxh?=
 =?utf-8?B?bHZRQ1pOUjFjWHhQMXRuYUx3NlYyc0NOVE1rL2tWU3R4T3BYR2JBUXUxbkdR?=
 =?utf-8?B?elhyWVdHR3VMaFdWODg5b3Nvc3RSRGY4dG5wNVlJSW41SUJUcXl4YUxvK0hG?=
 =?utf-8?B?N3VvU1phMk1kR29BY0RXaFVFYW9GMW9IU2pKK0xFUnFxWGxjeTVuV04rTXZt?=
 =?utf-8?B?aE56Si91S045L3o3MEMvaVdueFhFOWNiQVJsNVd2aFJvR1VOUTVLY0lVckc3?=
 =?utf-8?B?VGJyWWRCUEpjU3VJR3IzSnRTK1cyZUhaN0l3OVNtV2xTVGxoU2ZDN3NwSUJm?=
 =?utf-8?B?Q3FGcms0VjdLUEhiR3JoM0YwVkJreDBBQUpIeHgxbGVtSDdvOG8ycXN6a2lt?=
 =?utf-8?B?MDhxQnVBTkNrM1FSWmdNSVpUbWlhMFFQR2pZbFQ1c3lJeVd1ZEdtWmV0MndY?=
 =?utf-8?B?OS9qUE9BdEtMLytjaHNobTU4UjhQK29uTzdjcWFCdXVVTDJDRmV0MW93YlB2?=
 =?utf-8?B?M24zaVFwdTJ3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cW11anR0RnpUS0NuL1pWTTJzNkd3YzhjdENvazNqdUJOSHBGdnYrWis5d3Fs?=
 =?utf-8?B?T1lOTGxPSFdtZHkzUWI3bnFUTTZscFVJRlk5bVhCYlRQZVl0Qis2a043V2tj?=
 =?utf-8?B?TlJydEcrVkxORzlHR1lLTEZpY0JMbVB6ZmJQamRObitYRllGd1dNTWNzYkY0?=
 =?utf-8?B?R0xoRVJhVkVDQW1HOHQ1dStUS2k0bVhOR29zR1NzQnQ0R2VHeEdmQWdCNjR3?=
 =?utf-8?B?bGdRM0VCV3JrcUJTTTRDek4zQTYwMzRIMTdSbHF6Q3lOLzdyNHp5Yys3R0F2?=
 =?utf-8?B?YTNjWkxKQUs3S3NXU055VG5DR3BSeTArQ2dibkVVZklXM3hUUFBLUXFIYnRF?=
 =?utf-8?B?V01xL1J2enBHS09sUFJ3OVdxRks4OTBoNHc3aXdjeUd0cnBwUkRGdSs1QVNI?=
 =?utf-8?B?aHJ1YjZiQnJpYWpNWXg5MVd2VFF2UDRlZ1Z3Z3BSVDhlQzN5cGRCdnNRSVFm?=
 =?utf-8?B?dE5jaFpyRDdnMjhHNGM4RzJBZmttcGxRd1R2eUtMUVpGV21qamxuN3FFRmhl?=
 =?utf-8?B?b2hCZUxTTXRlMnhLOEJ0Z1ZSTzNaT2ZQeTNPam15WnV0SFdFNVJaQkt4SUds?=
 =?utf-8?B?OHhjUHRyT01vazQyNW5wb0FObkVtNjJvVkM1Z0p0aSt6SGNha2w4RUlEY2Np?=
 =?utf-8?B?SGNwTFdsTFpRd0FGZUhvbnQ0VFdPRUsxS0xiMGZuL3ZOMVhJS3NwRGliNWtw?=
 =?utf-8?B?VE43dUpTUDcwVm9NOUR1elhkNHYzZ2E5dHc2VEpFSzRKUVdkcng1K2ZaLzV3?=
 =?utf-8?B?WFFFZHh0a1kxOWxMRnNYdWl3YkFxbjZtYTNTaVdhMU15VldUaktlR1o0cUdK?=
 =?utf-8?B?S2JoYXNxYk5rVVFqbExZWHpiMWQ3NUh0VzVmNDBiZWVsZkcxT2FtSEtVWFlW?=
 =?utf-8?B?VU8rOGgxd2FPR2tqNHJDZ0NwQnZLTlBoSGg1bStaNXBRNTNYcHNGaGVybC91?=
 =?utf-8?B?V1dKY2JaVFhGWWtYS21ENDlySGJNYVU5azJ4THZReU5pVm5FWGJ0dVlSQ2s2?=
 =?utf-8?B?WHd6TXdZaTBnYTJvZDZhMnNaejh4TDMyWVFCbGpzeXMyamI2OTZMTnYwYnpZ?=
 =?utf-8?B?RHlzNWxIaXd6czFUcEFaWUJnVEUxaFAvWmNMcHBwenVXMkRWaGhBaWlHTEFp?=
 =?utf-8?B?ck1MNDdZb3BOMlArMXBYbDN6b0RYT1dNVSsxbDFHNzJXQ3puaVhUaUZ5UmQ2?=
 =?utf-8?B?c0FqRXRaL2VYVW52SWhTZ3VTTWdnQjh6MThVaXBiOC9hTXlxZ0xJVEFHK1ZY?=
 =?utf-8?B?blRZdUNDbTZtL1VsQW8zd1FSTlFmVUtkcGZydHI0Y3JwMTFRWnk3NnJWQ3Rk?=
 =?utf-8?B?MW9wVkhObmZURWVCa2lpejYwTXAzdG80YktPVHdXeVhQUGJGRGdNdUc0R3g2?=
 =?utf-8?B?MytpanV2TXlnY1FEV3FMMlZ5bFFwTDAwaGJGQ2NPREtaWm9kbXNYZHl6bUFZ?=
 =?utf-8?B?V3pzYmVTdThLUnpWMVBKbE5HRWFvdjJJUTl0YXlpY20rY01HSXNyRWowOEE3?=
 =?utf-8?B?Y3ZUZlFtQnNxSHZ1NXgza1pLd25yTjBFVjlhT09YczgvTlRZRk5DaEpLT3pG?=
 =?utf-8?B?T3o3WlZHbzBESmpOMGI5bXBOUVJqT2NUVzBtcW9nbmNyWUQ1L0RjaUQxdjBB?=
 =?utf-8?B?YjIrREhlNUxuS3RuazM3ajdSWXVNYnNYODBCUG1RRUhhSzVseE51WWErbC83?=
 =?utf-8?B?c3ZHVzRRT2wrdDJKWWo4YzNLcGg5Z1NiMnRvaDN6S1ZLcllnaGMxWkRrYVN5?=
 =?utf-8?B?R0p5ZXU0TXkrQmYvMFRCSFBNMDJ3dzA0T250aXk5WkZOUmZFUTQvMzZFQjJa?=
 =?utf-8?B?dDZGWi96aWNWblpiY3VvMlVBNlpuWldrMmo0Vk5EV25UY3NSd2FUNnlLRWhm?=
 =?utf-8?B?V3VOQjUrRU1PdDVIQW9QR2c2YXlDWllLdmVwQUhrSUtBcElzM3MySy9ZK21z?=
 =?utf-8?B?VkZsQWxFQ0VqeTdDeU9pMzFhMGNMWk5xZ2IvVFljZEYwRnZ4UmZoSWZyNW8x?=
 =?utf-8?B?aUJ6TFNFVm9jSU9DUk9vQS9LNHAwTXM1V2hrZmY0WWsvUlBaaDJtdXQ3bUtZ?=
 =?utf-8?B?cXRoOHRIY2hjM0RZUUljNThMT0x1TmtPNHpxR2xwNWMzSjVjUkFYYkVna2NS?=
 =?utf-8?B?VmZrZW1CeWl5SEc0NnNReXdPZWFwV2VzTi9VNjI5a1RWQzF4THhTU21qeEF4?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0n1hmotqn9p2lZM3dbRz7Y4swbTs2VPF2BV+va+8swtufI3zINgZK5tgp5n+n0I09Mdvw4q29aAdqodGTymei2Dv180cbVTn3e0jv3c9hjGkCBBw+OWKShky1u5Pkl/ihUadof5mkfaR2L0FLkd8Gqcv2O3dInPl7bw0nYgxi5nRm1tZ5JB6hMDZXD2H/fAh1rYoldACpANeu5HhyUxFYCM/QZBkggSjaVBnTrIhm4ok4EZ1X+9okdShPRQ2+/MoAeR37hkvtDmEQav3+vxLEtA+91L3N/oCLFwsuJ8A19jZm5TazrpOgfgTrv2vjFi9O5sKCThXRYLQT0mp8k+lfvwMbS9KJ0/xr3f1xjLKqJ+muE1UJ15UYYgzGAw1hFuQPb3AI08J1h/aUm8AnOkoNxHnl9mFLxfB+ap3bB1ttXqNSEIOaoq1GVGi8aADUBG7XBWNiAVXA1bCPbngxLGbgjS+Y49o5PMBcDxXt68H7B22+e40mtPSCWlQrA5ZBwmuBgheNI9cj/+QtchA4m5U15PoBxKESnBq2JNZIXE/ukrKSymte6YILwy5HYw425W+yDzts9j6/9UnFoZOKMckZuZ+NAkHXAiSQryPoExlmW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3c4048-d8c8-42e2-8eba-08dda9d02208
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:42:34.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzVcPZuRM4WZU4Rx49cHJAC/ZHim0Y7PvEQRg4tfu3R3Te+1gJQOzDSrRl0PjxUWuvRMsQLg5j6EmspH+guhQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120127
X-Proofpoint-GUID: a45i194KNNN96j6FoU2cCKjlSS2cIKfT
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684b037f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=3oB3AuryIvCLTMMkX3IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEyNyBTYWx0ZWRfX5+P9vb3GD2o0 7I/vlKWWpVJf5Zmc1HzadlcbUfd/LMAG477Hn1LZc3kTs/h2p8Hj+lWX5Gg7tOswRUoYwx9mYcx T0N8s2T/Dba1FgR02DY9FWk91meRd/LaA3eMwB7R0y/+pvehT1PV6wR1NWzaMSjqwFQAKg04KnM
 vUmXKD83ZEu3R8vsQr9dkzIvFs0RsFEcZI1f6RnGXTtNiMa9zbjrhAfqnCNTl7GDbI//42uGG1H McbgUT3fuyRgiGFWwRk6Z0JrdLypk56u5UXjlpf9qkC7QZvqowMK/BvzJBpM5XyIJ6b3H7JC4NC J2bslFXflAsz6oTM7t/OTii1t1KIpz1Zjhl7X2gxTznhbkQXLEAKb6S0b+G0Zlxtp9Q81a2yz54
 gOrnPwVJCjiJM1YN8ZfjFkac9K/KirE7utp0Apf1MG52jxN7jr5SrEcb9CC8L59JZIGlaVXe
X-Proofpoint-ORIG-GUID: a45i194KNNN96j6FoU2cCKjlSS2cIKfT

On 6/12/25 12:15 PM, Jeff Layton wrote:
> On Thu, 2025-06-12 at 12:05 -0400, Chuck Lever wrote:
>> On 6/12/25 11:57 AM, Jeff Layton wrote:
>>> On Tue, 2025-05-27 at 20:12 -0400, Jeff Layton wrote:
>>>> The old nfsdfs interface for starting a server with multiple pools
>>>> handles the special case of a single entry array passed down from
>>>> userland by distributing the threads over every NUMA node.
>>>>
>>>> The netlink control interface however constructs an array of length
>>>> nfsd_nrpools() and fills any unprovided slots with 0's. This behavior
>>>> defeats the special casing that the old interface relies on.
>>>>
>>>> Change nfsd_nl_threads_set_doit() to pass down the array from userland
>>>> as-is.
>>>>
>>>> Fixes: 7f5c330b2620 ("nfsd: allow passing in array of thread counts via netlink")
>>>> Reported-by: Mike Snitzer <snitzer@kernel.org>
>>>> Closes: https://lore.kernel.org/linux-nfs/aDC-ftnzhJAlwqwh@kernel.org/
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>>  fs/nfsd/nfsctl.c | 5 ++---
>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index ac265d6fde35df4e02b955050f5b0ef22e6e519c..22101e08c3e80350668e94c395058bc228b08e64 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -1611,7 +1611,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>>>>   */
>>>>  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>  {
>>>> -	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
>>>> +	int *nthreads, nrpools = 0, i, ret = -EOPNOTSUPP, rem;
>>>>  	struct net *net = genl_info_net(info);
>>>>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>>>  	const struct nlattr *attr;
>>>> @@ -1623,12 +1623,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>  	/* count number of SERVER_THREADS values */
>>>>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>>>  		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
>>>> -			count++;
>>>> +			nrpools++;
>>>>  	}
>>>>  
>>>>  	mutex_lock(&nfsd_mutex);
>>>>  
>>>> -	nrpools = max(count, nfsd_nrpools(net));
>>>>  	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
>>>>  	if (!nthreads) {
>>>>  		ret = -ENOMEM;
>>>
>>> I noticed that this didn't go in to the recent merge window.
>>>
>>> This patch fixes a rather nasty regression when you try to start the
>>> server on a NUMA-capable box.
>>
>> The NFSD netlink interface is not broadly used yet, is it?
>>
> 
> It is. RHEL10 shipped with it, for instance and it's been in Fedora for
> a while.

RHEL 10 is shiny and new, and Fedora is bleeding edge. It's not likely
either of these are deployed in production environments yet. Just sayin
that in this case, the Bayesian filter leans towards waiting a full dev
cycle.


>> Since this one came in late during the 6.16 dev cycle and the Fixes: tag
>> references a commit that is already in released kernels, I put in the
>> "next merge window" pile. On it's own it doesn't look urgent to me.
>>
> 
> I'd really like to see this go in soon and to stable. If you want me to
> respin the changelog, I can. It's not a crash, but it manifests as lost
> RPCs that just hang. It took me quite a while to figure out what was
> going on, and I'd prefer that we not put users through that.

If someone can confirm that it is effective, I'll add it to nfsd-fixes.


-- 
Chuck Lever

