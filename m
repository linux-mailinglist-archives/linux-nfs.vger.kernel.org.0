Return-Path: <linux-nfs+bounces-8460-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386B09E9952
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 15:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A6E162293
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB34198831;
	Mon,  9 Dec 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n7yxTll3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rvGv5xWb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A70219ED;
	Mon,  9 Dec 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755659; cv=fail; b=UdSAVg7gn8ufaDRLvmRfbGzS1VpS871GECHswhsLlXrD5tuqaSKWqBCaHm3plNP2Wpxmh4Ni2+GlTxraM429dO8p7MmtUQdCSY7S6nsmqKPL/XOB5gkoHZB8UMsktb2AMliyojJcTv3W+/tN8UGFZBVXcdkeiUwzjFfOrpskQvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755659; c=relaxed/simple;
	bh=nwy3mtmclsOVeVmgyLcj9mDnXXhsY+qBd/QVBNZwcAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HVa9XYYH6TyoCJaCkZRlhouz9E7QNGMO4EbkfQqY71YsG+PvYXJPw8DnacqNzHXJfW59Og6KIaX+/nq9/3uGjhGpzSGmlq11Y6IVGAhqU9tuVOCoSExn4Fh2Kpqs8+Ao4INeCYPFqZF8gHrH3hMCmX3iTmfnPZCyqoobUugrRS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n7yxTll3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rvGv5xWb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98frmO019837;
	Mon, 9 Dec 2024 14:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ycoc49/YyJve2VdKwH0S0fU7V3HvF6sxwRuuD7aw7AY=; b=
	n7yxTll3s7Frnmpbgyar8+4Nptg7hPFRrFxSbdxVTRAJFvKY88Aly8uVzW6pwB3m
	dAp7kzjaEWYQxFbE99ExpUJ8WqB4+yQy0h+iigkGeeVv48PNGXUEre0X0cuEtPpg
	A8Tejc9EoMud+6SP5eAsz/t3XaD7gaX6KELCXeMN1Djtc4IfbYIQa2uyrdUxY//r
	9EmpPf0QQ/dfN7DMEc86/yunaIRSlEUlCBN63aB9M9V9QpW/2vApkG3L/YasDThV
	pWriOG1Amt666F2byufCSPktNI7Cg3qIl0u4JlGDf+5kerPl1Gv1BAZmRdoD86Ez
	K8LGrQL788YD8j2ywD9ZMw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdysucuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 14:47:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Ee3d1019220;
	Mon, 9 Dec 2024 14:47:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct7bedy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 14:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpDNYmHLhANqZThxFEjj200VcV+gP34ax9Vq+jkkezr8YLODZ5NIASFaPHgZ/GRAspRhb8ROm6H+18F4XlfGTwragpnJ3JXSUlIWdTPosAptRja1u4dkPSd5Uf5NrAW9Z9IUBZCbZazACC5aVUx32PBGaUeSs/gBXxe3xZBmRr4yOXXfqAYZaYakkk03FSSD0xgL26nGQWtJBcP7mgvHL80wXlCtIaNzbu87myCabIZc0m/Kk+pLaePAomKYWB+z1pYM+WCTavKz6YNIAfQMs+XlphefRzcuIUqqPNyZDODC7KaMk9URzAzMgk5A9INjPy/jK9SeHmi3rIKoyUM3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ycoc49/YyJve2VdKwH0S0fU7V3HvF6sxwRuuD7aw7AY=;
 b=uQAWnAsvry0uEIsFc6y5FSyip2gicFHauZziuL3zTPdJj6WoliSE1NUexn3cKytle4zkQkzCx4eWRCd6qzrzOWpm5/tkFjrdbbeE7aUVzn4qIja6niHRNi5z13KHJBMYgEVfL8K7Lx9cUB0tyGr19xJtSp3VOHU0ZO/RhvulL4dVXPL7lAK6MkrGEEftOwN5M2Br1v8L9eg7su5JHEQXjfyacIkvSQHVmEXQgokIfPmqT7Qvr5gJ4czBVm9cSeT9WB6y7OSflig3NH0fcLsndvPYFjMD8nbyXhG+tctWcNUdF+l61SjmxLbsroFxuhiLTx02AyPWjW86beqguAGc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ycoc49/YyJve2VdKwH0S0fU7V3HvF6sxwRuuD7aw7AY=;
 b=rvGv5xWbLzbyTHKd5zW/sMLoG5m2Fxv69fMKK4pzmGy0+0uJuoOq/7vi1rGr6DeztTRswuZ5Yqg5/IB3IYimufpHs7c5JT7AwdHH4l54KBa65kwqAX4RksOml6pQ9cH7EcqH1cFyhDmBujOoeBDPaHeLnThozPGdOayfx9EdG34=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6725.namprd10.prod.outlook.com (2603:10b6:8:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 14:47:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 14:47:21 +0000
Message-ID: <6c287aa1-9d94-467e-a85a-7b7076fc080c@oracle.com>
Date: Mon, 9 Dec 2024 09:47:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: fix incorrect high limit in clamp() on
 over-allocation
To: mailhol.vincent@wanadoo.fr, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc: David Laight <David.Laight@ACULAB.COM>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241209-nfs4state_fix-v1-1-7a66819c60f0@wanadoo.fr>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241209-nfs4state_fix-v1-1-7a66819c60f0@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:610:cc::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: b54436c9-bdfe-4c6d-5ac7-08dd18606227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzdyVzZxUWx3dWE0Y012LytwT211NzB3Mm02dGxjUUtTV1BTU3VDdEFHeEhD?=
 =?utf-8?B?RmVSbGp6SDdRSE01NkpoNzBpcG1pam9LbEQvelIxcW1PUm8wdHlpOHY3b0ZE?=
 =?utf-8?B?dkJtNDJ6Z284dzFxUmVNL0RnNlVUb2NLU1MwSDRycUlPbldyY0RlVGVDbGVk?=
 =?utf-8?B?eGRYOHVRNklqamhqYWQ2VzI4YUV4ZDVjOFFhZ0FaQ3M3RFNBbXNyTWdMSWpG?=
 =?utf-8?B?Y3FiS3BMb09zNjN5Wk9GN2NEWkl0WTZXVEk1UjlyNnJuc2FMSzV4TVdrOGN2?=
 =?utf-8?B?STQ0RFVwYzdtN0VsRlJ1NEFOMUp6OG1QU1dVbjJxNkVFYTF4LzZNQ1MzN1Vo?=
 =?utf-8?B?RlhnUXJlc0dvelNCTWc2L3FUUExNRHlTazdQb2h4RjV1M1JKbVFvVURmdnpQ?=
 =?utf-8?B?MXBkYXVmUm1xa3RxdVhvWHNDWHBvK3RMSGcrbExPVGtsaTltTkVjMEhQOHZK?=
 =?utf-8?B?VDhGKzBuSnpycGhlNm5ZNW1ZaW1nWDZwcnU1UWZGTWFRQ2c1TldhYnFUUm92?=
 =?utf-8?B?UkhBb3pFQVBOaHZmU21JeDQ0Q2x4R3MxN0NZc2VkVVVQNUM3bjl1endkaDRT?=
 =?utf-8?B?V1RQMzByWlZGbWlBdE1INFp1SmdkdW1TYjJ3LzRqQTlndnM5RWZjbnhXc0Vj?=
 =?utf-8?B?aHRwY05NUVFyU29WL0lON2xlN2EzcVhTOUFabXhhYkZWZHVJZVIzZHdoeGdJ?=
 =?utf-8?B?aWZ2eW1tMURSemMyVys4bVl2SEo3WElSczRjWU9LbCtjUk9KbmFyQ1NnU0oy?=
 =?utf-8?B?MWpaak02ODF5S2poaGs1RzdwRVRCUTJyMGlSYXZ0ZGlqUkZVWUQ3OVZENTRa?=
 =?utf-8?B?cFhhU01uOXVmTFVodE1ETGdUUk9sZnRLaFBZS3A0bTF0anZXV2pZWkZWdC93?=
 =?utf-8?B?SVBEQmtLc3hYQW80M3ZmUFg2R2xScUFLZFFoWDE3S21VY1B5ZENReHRCRktU?=
 =?utf-8?B?eTQ2TEVnRGsyTGtuOTRaZURHVjBjRjZWSE91ZVQwT3F2akl0RnptemcvZkt6?=
 =?utf-8?B?QmhneEY4UjFQMExaYlREc1N6eTA2cFlyZGNvZDNDTDFESThaVlpWL0c4Z2F5?=
 =?utf-8?B?cWhKMHBtVFNWQTl4YnJzTVJXL1NQS0hCYW51SXJFRGlJSVBCUmo0YUMzUFl2?=
 =?utf-8?B?MURlY1pUbitXUEVuZDhpNG1hQjF4ZlZ4L3FmMnF5emxSVGtrMWtIUUx6RExC?=
 =?utf-8?B?aHJHOXJubjdQaldzYjZpUy9WQmNBSW9EcnorODk4dTZUUDF5d1dvWks5NDgx?=
 =?utf-8?B?RkVhWVkvNFFBVkJSRnl1aVJTczlXTzZPSDk4TmRKMXBYeFBDd0FoVitxeGxX?=
 =?utf-8?B?akZlSHBRekovbXVlUmpmWjQ5OVEwK29aSG9mS3N6MnpYbHRiMFdaQml1dnVD?=
 =?utf-8?B?L09QYzdhYms5T3dNMGtBcUp5dU9nNUp0VnJmTXN5VTBXa1pkQnlCU1Ryby9P?=
 =?utf-8?B?aUp4NXo3elZPbWErN2VkeGRuQTFHNXpkSS9tK0MyaUtsV0hEanUyVkNvbndQ?=
 =?utf-8?B?YUlDek8yRlVtcnlyMUJ1cTVtd3lGZVBPbzZ6SnRxNnNmdlZMQk5VcnJjMkpV?=
 =?utf-8?B?b250S3RQMHpHZ3lsQlRBODk3UU1MRjB0dUI3Wnpnd1RCS1RmSlJEcG9lYlk5?=
 =?utf-8?B?Q0dMM3Z1TE1iZUVtdXdldFVvajJSY3phRFVNR1IxUXVEV3U4eXg3OWlyMWtw?=
 =?utf-8?B?dFd1V3M1aVJFSVpZZHRSVnFqNXB4emkwdGJQTm4wbGRnTjlzdFlNYjVhSlJv?=
 =?utf-8?B?Yjh5Wk5tVklLZGNkRThoV1pRYkJLbys0bWpURW1WQzBXVlViQVhGNHFld0pl?=
 =?utf-8?Q?uX86eTWcCvGm37hxf5C/2hUMFUbEEuQ9zmckI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ukk1NE9meUhmaVJpNHVkdDEwWXFhK2xWcUJOODNhQjdmMUdzN042dC90blZF?=
 =?utf-8?B?OGMwMkxEMFZHb3VsOG9tY3hqY3RHd3E1ZnlhOWJBaEJkTGRTbGYxK1c3MXdH?=
 =?utf-8?B?RzdpeTJTMmRlZ3hzQWlUNXd0eHlWMklzWHRKcG1GRXA2WkpQc3JDeWc5RFhC?=
 =?utf-8?B?SWNLVy82cFBzM2dJUXlRdFRoRHhkWUE3a21ybzZqQlpKWU11VHJUdGU5QW44?=
 =?utf-8?B?bzBqV1VSTjA0QXMrNnNxZzUrSkZxQ1k1VEZlU0ZQb0g2TEdGZFFsdUNQa0l3?=
 =?utf-8?B?WUZrYW1GVVpwellCQjJBUS9Md1ovajU0allxZWd3MEpMajd2MkM3MStwdDF5?=
 =?utf-8?B?WjhrY3J3RGZrcEhGMjZBUmUxZjZVc2c3YXhmUk5IbVlhODVYSnBpeUZ3TWlN?=
 =?utf-8?B?SlZTaVBjRkV3OS9LeGhtSy9XVnhXdnppa1ZyVVhvOElZYmxvWi83bXU2eTRn?=
 =?utf-8?B?TzYrZE8vWkFUNE16K0k3WW9WQzA0dyttblVkTlk2OE1LSk5DMVFad24xNy96?=
 =?utf-8?B?bGRJSlpRVTNqNGRMbENDYkRFS00rWnNia2pWcGhlRFV5R2gza0d6aXpvSGZD?=
 =?utf-8?B?d2QxcTVuVHByY1gvU1d3TWtiZHFlUUJmSVdzSk0xS0g1OHhINUpuRzk4ZzN3?=
 =?utf-8?B?ay9xcWhLK1Z1UHIyTFp0Z0xYSXFFWU5xellXazcrMzJlOXBNc2phMkk4WXpV?=
 =?utf-8?B?TEhqL3NWc2RBOFkxS3VNYythbzQwN3kvOHg5WllQMFRLaXJ4M0tBYlRjUHBR?=
 =?utf-8?B?b3ZMWTNoOXQ4aW1MZ0ZPcWpTbEM0QjRBQ3ZLd2dXNjBUT2poTjVKcmhZQndW?=
 =?utf-8?B?MXBMMUpDdHRleS96djV0TXdEcXlwdUxtcHFzd1UwK2w1TEFwTGFPNHIwTDZ4?=
 =?utf-8?B?Mm5OdXZ5Q0IvT3VmYWZYWE1GOG85REllSGl3RXdjYldOdXlyTXl2RS9xbDFM?=
 =?utf-8?B?a1pndlY1OVdUb3I0cWxpTGpRb3h1NmFZQ3dMYmdhREdSMjJaOUlqNHFVMmRV?=
 =?utf-8?B?dmdQWFUvbHM5S3EvTC9Nc0VSemJNN21hVnViQ0tDL0RhZUk0NmJLcEVzd1Yx?=
 =?utf-8?B?RVFuR1NJbzZ5RVVKcjJOZ1BnYnhqMk5heThIUHZxMEp4L0xweUFEa0NXNXMx?=
 =?utf-8?B?Q0YyVFJsMThsMFg4WlBpc1U5UFdMRWJRNVc3bkNka2xCM0QzM0VyUDhKSUZX?=
 =?utf-8?B?bnd3ZEczTHQ1elFDZ3dETVRpa2ZTTk43ZkExbDhIZ0Z2cTFiZnVZaG83U2RV?=
 =?utf-8?B?TyszQTcvaFZla3VGVG90NkFqc0dCNWd5RDhXYUZTTE1aR1pzQU9ySUNPRitL?=
 =?utf-8?B?OFBUSHVJWVJJNkpOdDNoblV1M1J6dWhucGQrd0JJazFZaHY3RFpjL2h4VnZQ?=
 =?utf-8?B?S1JURUo4cmRKQk5yOG9VKzRmdSs2MnRMZVoxYmkrejlnYjkyMnFKTXUxZVJa?=
 =?utf-8?B?anJ0aGVLVTI4VUZWUHBMT2ZnUVFRNDhiMm9xTUZTb2JLRmlEc0F0NkNuVERz?=
 =?utf-8?B?czNlWEFjdVZIN2E3Vm1zWklFTXp3cCtreTA0NTNQUExQWkQ0eWxscnlhelBF?=
 =?utf-8?B?M2k2R2dGN0RQUEtnckhnSE9ZNng2M0JGeEprMEU0R2lwUzkxbmE5a2UvOURv?=
 =?utf-8?B?UXhwRktGYkhDOTBVdTBVWXloV3RtMEtiNTh4elpPYTkvdWxGQWthZzNOVHIy?=
 =?utf-8?B?ajNUMlhJT3hVL3dCYk5JVE1MM3FQdUhWSWtMQlNaNTJjREdFVitxNm4vZldG?=
 =?utf-8?B?b3d5QnRLR0FydUFzMzNSMVliSnJYVjU5WG82TEM5Vk1XakxhNE9aZHQ0b3hq?=
 =?utf-8?B?V1dzenBxVUtjQklLRnN2b21RelhRTVhWcy91U2ZCMHMzQXZxZkRsd1VjNy9O?=
 =?utf-8?B?UW1ocXFreDZBdlVqR01Wakl1NUxJU1NNQmlsazA1cTEzMXhsL2JNaWduT2pQ?=
 =?utf-8?B?c3JNQjQ5NlB5L1ZrMzVJdkhReklncmdmdHJ5VmZMclMwQlRUVjdLMGd3UmNz?=
 =?utf-8?B?TWlKZHFiR2V1V1cxd0gxdEZIcXQxSFkxMmpOdlFKVnZjVXk2SHhJY0FOWnNK?=
 =?utf-8?B?Wi9wdTZsU1JXZkcrZmlxRzVaQ2ZWenRtR3UyOFYyK21pVU9UbDV3TWQ4d0Qv?=
 =?utf-8?Q?bs/93YNSICvXJXxrW0aQ5x+SL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q0svcI4DSGP0IziExQx1O3pC6BNM6hXL4O1vMyJOXLR+YWO9wNwGt/Mw2uI0vXWPnOuc6OeNzbj9QlKOut3eAC/rpzVJftOIFPP0oeODzUasfQT1H9V7eHFuAqM+xliH2QumiVgRvTTqOlKQlDm18yVi5Yh+wS2oToh2Uy/0DxQ6YN6BeWo92vn7NS8WoX2C5uhhV5hFDXay576j/M/Bbx37qHcfnAlLxbb7MgLKqSHmfTxrR7jtYz3xMozLndnxYqKOLdSdZC2Dmjs8v0WwfCv/aFSHcw8wG2tniGA+Jd1e1YFJMwKH7548oEBMl3vJ5Ckz1pESaeeLsNr5hL0eZOEJc2yb6cPu2KPk3NFryOZjeTmFo6zo23433aLpdFbPsAJmsgO6C1O2q1jN4KMgwCImxuEWnf3Qu59sJpvUxakt7iddHu/Qgo3zf1C1zja3hYC0pbxaKfYM4J/XdzEesMMEATBHhSpD1chnt+7Kkg/Bq45wyFuVqVICKbCdRphJm8NWHTv2hRknAhBNcijXA8rFgrIpDBCFZ/tlwalS2UwN+mjysRSoneaThcK/C4HviP+1RSAKtap2x5WSa/Rfx37KWJRjDWTcUsSgPNHd0u0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54436c9-bdfe-4c6d-5ac7-08dd18606227
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 14:47:21.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2114p7FZ38PPNYbePHZyXPFCFEMhs2loIDHw1vkA6cFlF7RLCHjrFjpNHwKFS+O1eJ2mJKxniWSyMQEEuY44Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_11,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090115
X-Proofpoint-ORIG-GUID: odlqFyB8SbPGHcBRMcXxzx_C_Cof1nN0
X-Proofpoint-GUID: odlqFyB8SbPGHcBRMcXxzx_C_Cof1nN0

On 12/9/24 7:25 AM, Vincent Mailhol via B4 Relay wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> If over allocation occurs in nfsd4_get_drc_mem(), total_avail is set
> to zero. Consequently,
> 
>    clamp_t(unsigned long, avail, slotsize, total_avail/scale_factor);
> 
> gives:
> 
>    clamp_t(unsigned long, avail, slotsize, 0);
> 
> resulting in a clamp() call where the high limit is smaller than the
> low limit, which is undefined: the result could be either slotsize or
> zero depending on the order of evaluation.
> 
> Luckily, the two instructions just below the clamp() recover the
> undefined behaviour:
> 
>    num = min_t(int, num, avail / slotsize);
>    num = max_t(int, num, 1);
> 
> If avail = slotsize, the min_t() sets it back to 1. If avail = 0, the
> max_t() sets it back to 1.
> 
> So this undefined behaviour has no visible effect.
> 
> Anyway, remove the undefined behaviour in clamp() by only calling it
> and only doing the calculation of num if memory is still available.
> Otherwise, if over-allocation occurred, directly set num to 1 as
> intended by the author.
> 
> While at it, apply below checkpatch fix:
> 
>    WARNING: min() should probably be min_t(unsigned long, NFSD_MAX_MEM_PER_SESSION, total_avail)
>    #100: FILE: fs/nfsd/nfs4state.c:1954:
>    +		avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> 
> Fixes: 7f49fd5d7acd ("nfsd: handle drc over-allocation gracefully.")
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Found by applying below patch from David:
> 
>    https://lore.kernel.org/all/34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com/
> 
> Doing so yield this report:
> 
>    In function ‘nfsd4_get_drc_mem’,
>        inlined from ‘check_forechannel_attrs’ at fs/nfsd/nfs4state.c:3791:16,
>        inlined from ‘nfsd4_create_session’ at fs/nfsd/nfs4state.c:3864:11:
>    ././include/linux/compiler_types.h:542:38: error: call to ‘__compiletime_assert_3707’ declared with attribute error: clamp() low limit (unsigned long)(slotsize) greater than high limit (unsigned long)(total_avail/scale_factor)
>      542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                      ^
>    ././include/linux/compiler_types.h:523:4: note: in definition of macro ‘__compiletime_assert’
>      523 |    prefix ## suffix();    \
>          |    ^~~~~~
>    ././include/linux/compiler_types.h:542:2: note: in expansion of macro ‘_compiletime_assert’
>      542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |  ^~~~~~~~~~~~~~~~~~~
>    ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    ./include/linux/minmax.h:114:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>      114 |  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
>          |  ^~~~~~~~~~~~~~~~
>    ./include/linux/minmax.h:121:2: note: in expansion of macro ‘__clamp_once’
>      121 |  __clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>          |  ^~~~~~~~~~~~
>    ./include/linux/minmax.h:275:36: note: in expansion of macro ‘__careful_clamp’
>      275 | #define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
>          |                                    ^~~~~~~~~~~~~~~
>    fs/nfsd/nfs4state.c:1972:10: note: in expansion of macro ‘clamp_t’
>     1972 |  avail = clamp_t(unsigned long, avail, slotsize,
>          |          ^~~~~~~
> 
> Because David's patch is targetting Andrew's mm tree, I would suggest
> that my patch also goes to that tree.
> ---
>   fs/nfsd/nfs4state.c | 46 +++++++++++++++++++++++++---------------------
>   1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 741b9449f727defc794347f1b116c955d715e691..eb91460c434e30f6df70f66d937f8c0f334b8e1b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1944,35 +1944,39 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
>   {
>   	u32 slotsize = slot_bytes(ca);
>   	u32 num = ca->maxreqs;
> -	unsigned long avail, total_avail;
> -	unsigned int scale_factor;
>   
>   	spin_lock(&nfsd_drc_lock);
> -	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> +	if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
> +		unsigned long avail, total_avail;
> +		unsigned int scale_factor;
> +
>   		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> -	else
> +		avail = min_t(unsigned long,
> +			      NFSD_MAX_MEM_PER_SESSION, total_avail);
> +		/*
> +		 * Never use more than a fraction of the remaining memory,
> +		 * unless it's the only way to give this client a slot.
> +		 * The chosen fraction is either 1/8 or 1/number of threads,
> +		 * whichever is smaller.  This ensures there are adequate
> +		 * slots to support multiple clients per thread.
> +		 * Give the client one slot even if that would require
> +		 * over-allocation--it is better than failure.
> +		 */
> +		scale_factor = max_t(unsigned int,
> +				     8, nn->nfsd_serv->sv_nrthreads);
> +
> +		avail = clamp_t(unsigned long, avail, slotsize,
> +				total_avail/scale_factor);
> +		num = min_t(int, num, avail / slotsize);
> +		num = max_t(int, num, 1);
> +	} else {
>   		/* We have handed out more space than we chose in
>   		 * set_max_drc() to allow.  That isn't really a
>   		 * problem as long as that doesn't make us think we
>   		 * have lots more due to integer overflow.
>   		 */
> -		total_avail = 0;
> -	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> -	/*
> -	 * Never use more than a fraction of the remaining memory,
> -	 * unless it's the only way to give this client a slot.
> -	 * The chosen fraction is either 1/8 or 1/number of threads,
> -	 * whichever is smaller.  This ensures there are adequate
> -	 * slots to support multiple clients per thread.
> -	 * Give the client one slot even if that would require
> -	 * over-allocation--it is better than failure.
> -	 */
> -	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> -
> -	avail = clamp_t(unsigned long, avail, slotsize,
> -			total_avail/scale_factor);
> -	num = min_t(int, num, avail / slotsize);
> -	num = max_t(int, num, 1);
> +		num = 1;
> +	}
>   	nfsd_drc_mem_used += num * slotsize;
>   	spin_unlock(&nfsd_drc_lock);
>   
> 
> ---
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> change-id: 20241209-nfs4state_fix-bc6f1c1fc1d1
> 
> Best regards,

Hi Vincent -

We're replacing this code wholesale in 6.14. See:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=8233f78fbd970cbfcb9f78c719ac5a3aac4ea053


-- 
Chuck Lever

