Return-Path: <linux-nfs+bounces-12308-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F11AAAD5799
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 15:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CA11883C86
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A3328937E;
	Wed, 11 Jun 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GkZ+5L5B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Btd9s0On"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354582882A5
	for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650022; cv=fail; b=bc3zg0R2AdwicIA2WqDAAbl16rCJEpsUpLtTPdqvya0/hlrfF1uTgRPUbdEjXuGnI8mnvliDA5NWSUDs8Tbk8Bz5gjlcSvzaozBPI74NCKvHp1GkRZWOs8uU766Zhb4nsiQ7Jx1t1xEkx0Hu9Du+I7ApmCYyHs3qN8dSw2bVBZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650022; c=relaxed/simple;
	bh=rEZedqfPDJ3aObU1+eAmhGQ8cTWZgab6Wjsee4Gx16k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GG6BIRm5k3YJbOi0k2uFmvnnQdv39AtHDNO6KGtFc1KbVeIDwcefx1rw1gImZi7mTavqyp3mxsy+ZsrxZZ2D1mbhzQDXXsM8X4XVtFtweQkGPZSDm9HYOwnzGRrI5zpN8Ec7USMHHl8s3IJXA3vOpEFDIDpMsYppdbYqJLI/Va8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GkZ+5L5B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Btd9s0On; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BCtaMO004508;
	Wed, 11 Jun 2025 13:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KfFqReTWVx9UazH0EdwGM6DoBQON8xvXiM8zIR+mk1Q=; b=
	GkZ+5L5BEAlGbqfkCl++3+62yN6QQC8l2WNDK+9EGK6qMl77w99ZIzs0jvrTb7pP
	G4PSCbaAXXP33sTpsc5fD5XuL/bZA1zQNguLAaFfrreotFvTgNAC7Kk17FfD/2Tw
	v2BgfOOQ3vwSDS+zNVehem/XO2qQj4DAo+06XBfAJQAwoi5Hrwb8ZKd0OEKKzXX/
	dTcUid35LAeBi5yKxI1UUu/cqJ8AaWJesLAX8kK39Y29n7SW1+WaJ1VM/BOKGh5P
	bbL9DuL09+/haNGY7P8iyG9ul8GRzOPwEhk3Hp/eDpYKVCGMWlnj3PdQuu8ZxaFf
	AhjLNacgmQZwMxHNHbyDoQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad6vmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 13:53:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BDX0jK031327;
	Wed, 11 Jun 2025 13:53:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bva71y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 13:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/qEx3k+iQNkxaKfouriSgKIWTe0MgJWhlXCIuFNaOqp3m2YiopbSIlFCotnP5XE+CCXskbsPmP2p57dsyNkmYf6gApVXyhHK34yN0JP9zSYZ0sUUdcDdBKudZTSf6KZZSOMlLMdQb7OmwtrGhWwZFYZuhm+Fc1scO34T4g/qFMpO3shJLm0ZgddMYsPMecUz3ODJG4wX/8ZvinYM+19OOznwrBXJraxu9lX+xSK9yZDObeoBnP90NmLauiDCAALNTTmdNfH53ZxSzQdPh8qwqorluteMU56zSnP22rvFmU1f7ytvgP9w2PCKXW2ds/LrBAVjgN8aECzGwQG7ACKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfFqReTWVx9UazH0EdwGM6DoBQON8xvXiM8zIR+mk1Q=;
 b=XD3c0d9ih89dvQswaCkwwXDEmX1O1NE3yTKIGrvSKqnPWMsBzBimyJAxu+ylx6iBTMWeG6hx878dns0cNQZt+qBz/EoPIE3VVRmfMLtls7wD0IZ5QQ+NsU8j/HGyYJHlJujZOZ4N862tCTpXRD3pX7tzWP8Om1SC+/5dJm62h8fHD/UecIo61OypXCJ6TRN48ig6cWKuJu05VrJlMCkmS7AHtiOa8NiQyvW1CZz/jiBmrburdj6M10vjM8kB31/Od6XAdCJ1fPL6sMubCWt/lN5VcgWvGT0ImDSUY+64OoanuuY7BBa4upvVuIiFvKCUW+ImASEX1VWTCZT/v67G0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfFqReTWVx9UazH0EdwGM6DoBQON8xvXiM8zIR+mk1Q=;
 b=Btd9s0OnuAv4o666jSchbIZkvJn16eQFuvqEcPvH1mflFg7sFYfYdRb1Fckdz00SdlyVltAwpMM3346qX2+3mt+yOSlzzOsJFFp3Aaewr3YHx1/kxayJWPq8aj7ES9N/29eTK9dd/1cr7rhYBtTGq1mNnNf3dj2TUoobspa55Lo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Wed, 11 Jun
 2025 13:53:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 13:53:22 +0000
Message-ID: <a2ec01e0-e820-4058-ada0-fb0ec8e1e9e2@oracle.com>
Date: Wed, 11 Jun 2025 09:53:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Implement large extent array support in pNFS
To: Christoph Hellwig <hch@infradead.org>,
        Sergey Bashirov <sergeybashirov@gmail.com>
Cc: "J . Bruce Fields" <bfields@fieldses.org>,
        Konstantin Evtushenko <koevtushenko@yandex.com>,
        linux-nfs@vger.kernel.org
References: <20250604130809.52931-1-sergeybashirov@gmail.com>
 <aEBeJ2FoSmLvZlSc@infradead.org>
 <uegslxlqscbgc2hkktaavrc5fjoj5chlmfdxhltgv5idzazm3h@irvki3iijaw4>
 <aEfE-r2dkuDRUKsq@infradead.org>
 <75iqhi3to6gohuo2o4h3cewslcjzsfyrl7l7x2x3qyiaaecjci@uwoeqjubvqft>
 <aEkoTdJttLesPv6M@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEkoTdJttLesPv6M@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 6661f04d-b5b4-451a-6316-08dda8ef5487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2U1bHNPcStlbzN3MEVRcjNONUhydzlNWExYYzJVTnRQamw0T1E5czB5NXhu?=
 =?utf-8?B?QTFRVGJVMU5UNml0aWRBMHNobDV6VnhXNFk2dnBnTnhUZWJXZmRkcC9BMys4?=
 =?utf-8?B?MWUwTklRV2g4VEFJT1J4Q0hWZ1YxTjF6NjlZU3hFdnBQVzRmaE9nYktlMFdP?=
 =?utf-8?B?NXQvUm1XTEk1ZnFPbDhYZ0FkSk03RHhMTkhFK2JUQ3FPSlJSQVlscU90R1FQ?=
 =?utf-8?B?dU1wQzJnWmJtcFhMajU3M1d2eUJBZ2FjeC9vQ3M1RXhYclgvdVZOYWhSQmFT?=
 =?utf-8?B?QVlvMDk4Tk5MYWZMZDViaVd4NVRmVW5CYVJRZE1hMFAxcFp1Y2h5ZEkzQURP?=
 =?utf-8?B?RmxPZEFuTlozdFIxZ3F1dVBkSXQrNnhsc1RZUlNxQzNWSGRueTZmRTVTbDU5?=
 =?utf-8?B?ZWNjZ2xxbEtHWWhKSlp4a0ZtUTZGNVlMTjFmS2Fjdm1kRkRodGhwcnBYWlhR?=
 =?utf-8?B?ZE9nZ0ZXTWo4RDRpdE9KNTRBdzJUa2lYdEJBZ3BWSVVqU1lPUmVSYzd0ZTdQ?=
 =?utf-8?B?U1VXeXU3Z1dDdU8wZzRFUVBCdkMvS3BaWnFINUNiWW93azROOXczQ3d0Q2JV?=
 =?utf-8?B?YnN2UmdteWNEYk1LM0dFcTVkenlEbGxSdXNNUi9vaFozZ1d5ejdobzlMTmZw?=
 =?utf-8?B?UXhsdUhUZjRtbFFuRzBqUDFNOHlZdjVaNTdMWHRZTm1SZFMrYlNCN2F4cXJS?=
 =?utf-8?B?TllxREFEUUh0R1JxRjdaTFY1Q3I4Vk9tYUwwVk9DN3lqZkthTDRRaUcxL2RJ?=
 =?utf-8?B?a0hVbGFxR2gzQU5sSG5JZDMybHlHKzhYK1JsNzFqQmV4OFlUK2Q1SXFFRGY2?=
 =?utf-8?B?Y0JHY0lST0JhNkl4SDdYclYrN01Ga2RHWE1xOE5EM0JxNXREclduSEZ3ZnFh?=
 =?utf-8?B?U0cvNUZ6YzZFbCt6YS9xd25tN2FVbnp4UVN5MlBLMGQ0bXA2b2hHMFBQY2Ir?=
 =?utf-8?B?cTFBdVdxN2s2SElyRVc1eVNmRENLbE5rV21BS2FVVkx4WUJRRllONzhCVkxL?=
 =?utf-8?B?aVNFZjRsVit1L1AvcHRGU3kvUlJFZTNaY014U1lqRTRUOCtweEJKMmprTXNN?=
 =?utf-8?B?ZlBrZkdPMWhzQ0h4UGRNU1FSWEdMd0N2K3RBMDR1SWFkUUhHcmszQTNNTmVu?=
 =?utf-8?B?cGFKY2tsdUk0cHhDNTAzT3c4SGF3VWVsSUtzM1kyeXgxK1NmVnVsTDRTSGZi?=
 =?utf-8?B?dlBFZmhTdnVmemhnUURoVEdsQkluU3RQWFlHZktwa3lWVUhZenY4RE0zSmR2?=
 =?utf-8?B?a3ZCK3ViQzIyQUs5NlM3SUV2K1ZqeU5EV04zaUtxRkdZaTM4aUdIUkpuSTZp?=
 =?utf-8?B?S09Ydk5RU2NHam8vVnI5Mm92Ky91T2YzSXpEd3RNYmRlSWdQUVVSOEo3OVhS?=
 =?utf-8?B?dWNpNVExWVVjQ0ZmSm1lR1BpeXNjRnBmVzl0TUcrbWNtMXNWbHhsdFlhbDky?=
 =?utf-8?B?d0cvTzlSS0hoRUVKRy8rTWQ2YlVubXJ0clQzeHpMWTk2a3pqbmVBOENIYWZ0?=
 =?utf-8?B?Yy92TjA2UTNtU1NqNGk1bCs1QlZzWWFHeXZHVVJZNENrbUN6T0Uwbk1SSHVP?=
 =?utf-8?B?MU4xZHUyVXBRSjlYQ3BzeThQU05WQmNscC9kSS95MU1OZVE3WFAzOWxTenJj?=
 =?utf-8?B?cWFoNDJxK1hISWVBemd1RUdscHNCMWdsaVhITVREUXJKWmgyNXVKUXFrMXBF?=
 =?utf-8?B?cHVHaGFBTnAzVHJNVHQ5REVrZHkzZ0h2enFvbWhtMHJZM0tHN3B6UTcwYnVM?=
 =?utf-8?B?eVB0ejQreEdUeXU1ZTNpR29TSnN1dkduYURYMjFCRWx2SjhzZ1VYaWZydkZ3?=
 =?utf-8?B?THBUNGUzZVU2UW9pdFVjcjh4cmExcDZNclZlMDRyNlpVaUdFU0w0d0dWeU9w?=
 =?utf-8?B?OHplUnJCZEVJcmN4djZsNndoenNiay9Mc0lVeEpVL0Z5WFhuVDNGK2t3aVRx?=
 =?utf-8?Q?fqi3wMbDOB0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkJVejluK2R5ZklHYTU1U2h1MW16cHMxMUNXd1ErYnUzQVk4UG1NYng1Uzc4?=
 =?utf-8?B?UTVDQkRJT1JOclkwb2pYVVZLSGkzZHgzREg0dTVFUUhTYzVRS2thQUFCTk0y?=
 =?utf-8?B?b1U0WmtEd2N5WXZYL1NCdjhMNTBtUVNkWE1Xajd0R3RING9Ubncwb0JFN0R0?=
 =?utf-8?B?RjJxUmVOUnpZMDZsZEFNaFNLZEdyYUZhZHp2Ri8zMTYrbm8xMVluVk1XcTZD?=
 =?utf-8?B?YmxBNWVHbERDcU9KYXZiMlgrajRoZ0JNNUxHUDE0N2NBRE1SZGYzVXdXdW0y?=
 =?utf-8?B?cGljZmVKdFdOSjI2UTBvUkJzREF5aFNqenNDZ0xienUwSDkwQVUxOWJQSW9F?=
 =?utf-8?B?UDhQT25HVTEzQzg2VmZ4ZEhyT05SdXhReXpkNlQzSHJ0OGpzeHlXN2tDYjZ2?=
 =?utf-8?B?VDFDQ3VDcVU5U1lKcG1YdUhva001azYyaHgvNGFxMVNsUVB5RmV6WktxRzVF?=
 =?utf-8?B?ZEVPb200MFI2dXVDdmR3NkFvZDZVTDZjRlVKK1JIcUdmdElJQ3o3L0oxd2Vv?=
 =?utf-8?B?Vm9LeC9OQk1tWStsVFd4MkZoMjVyZE9CelJWbEJBWm1PME5RbU12Z29JUGJn?=
 =?utf-8?B?VkdoZGZXeVF0cXhialBpQXpDTDJLc2VicGlJd3ZHSStsdzRXMks2dUdVbm10?=
 =?utf-8?B?K0J3ZjlPWnJzUkErUWJ4K253SGpYcjFOUmlzdWdiTjNyemxWNE92bHYxeWlW?=
 =?utf-8?B?cHdwUUFsS1JxQVpxOWk0b3A2QVhrbW5MSUtLbmIya2NyQmhwRFF4RVdiSCtB?=
 =?utf-8?B?RkwwMnpnN0MvRUpySktHZEsrWEF5S3BRQmo4V1lnNXkzRFFJeHk2ZjBUdFRG?=
 =?utf-8?B?RUpkMktUQVR0cTNFT2Y2b0llZEx5SXo4TkpZaGloYjF6bXVlM2tZcnBjcFlR?=
 =?utf-8?B?T1ZFZ0xVZEkrN2tXbWVwbm5abHVKUUZmMThtMy9zVFNJc0tSOUxmMDFlQnVE?=
 =?utf-8?B?ellGM3lCNXcvdGNKdnJydElaZUJJckZVU0cyZVBvZGFhb2tDWk1sN0F5akVw?=
 =?utf-8?B?ZS9oQmxpU0xnMnowTXhTbHJNWFMvM3VIT2VaaDFMdFF6b1lmbHBTOUhhRk5V?=
 =?utf-8?B?MnlTVXd4UTRFc2VMTUF2d0U2TzRueWJyZmh0WDlwQ0ovS21ydXR0OExUTmhB?=
 =?utf-8?B?SUowYlRtMWtTRGNYRTM4TW1PRmw2MGtMekh0ZGRtZEczaHZNMGVSTFFMenpp?=
 =?utf-8?B?MHNVVlNYWWpjOHhucTNQSEpDN1ZnSitYSlQwOVM0MXd0UXdIT21Wam9zUEV5?=
 =?utf-8?B?N2hqeWI4cXpmSXQyMjZTY3JDTGpxTGdmRlhjdjM2R3JjVzZmaDJ6S1hoYkk4?=
 =?utf-8?B?a1R0RjhubmRIeEJVRDRvaG1TT3BETGV4Z2lMS1pWQ1Z3Wmxka0t2elgzdkZS?=
 =?utf-8?B?cXcwUkZPOHQwcHJQMVN4RFhNTUd1KzRFSThETDkvN3l0dkVWL1JwbDRyZmRX?=
 =?utf-8?B?SlFiUHF0UkhTY3IvQ3dRbHRNMEJWWm9mQVlxTmxNeThiaVJELzJXMW1qSmhM?=
 =?utf-8?B?M3FJRFBBa21WeVlRdTV5amRYa3BJNk5KVWpaV093akFOZ2RLekpjc1RhN0cv?=
 =?utf-8?B?dm50ZTlGY21DLzlKblpJemN2VGdNZjB3QkFlanNIZkNJY05BWVJoQVhWNVJU?=
 =?utf-8?B?RDB2d3RWZWpCY1lsU0k2UlBMaDB5cmx4OHBxNWtIWkNTVXpraHBOeW5VUnRl?=
 =?utf-8?B?ZGxXQWUwQTJhWUUyWlFGNndpekN0LytlTjM2QlZWZzA2MzVtb2NISmhiS2c3?=
 =?utf-8?B?eWxlY3ZiNEZyeWpxOG8wN1pSOFcrbkRnOVRlZnBmRldMazQzNjB2dnQzSFZW?=
 =?utf-8?B?eE1rK3ZISGFIenFFaElTZ1RvMmhwNS9ZVkN0Um8yUG5XQVhWdTFFV2UxcVU3?=
 =?utf-8?B?MkhNSzdVYVZObVpycG4xTEgxOVlSQ3hJSmhXeTg2UUpmUktHNThpbWp5dXVS?=
 =?utf-8?B?UmJkNE1naC9NS2RPMFd0WlBQcTFOTkUvd1hZZmZYZDF5ZjdYSUVmSzhuMFZY?=
 =?utf-8?B?YTdtVG9SQ2g5TDMvNEYzTTdMekRRZ1lBZWxlcWtzMmlwcW5YWG8wV3ZsZUNh?=
 =?utf-8?B?L0dqc1RsSHBzcHcvSldkaXBYY2EzR3l2QkhzazlrcXBReTVYM05abFFPYUxZ?=
 =?utf-8?Q?SmtO+iLGrsLwMI22yl8hpcbcN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qt+JfaXYkbNdWpc2zMalsV1qf32TvIWtpy8crAP8Jvnsd6NlU8iSySlWqlG394z5BBnQUIuAIc8U0YKCCSKipjy4VFTI3BICclfDHpY0kuVZo+w+idgeMC47SqzAcETNmm9A3QbKJ78gjACTYAQFQQ9FsJeUBg74NdNfqnX3mcuAh5ahGSC3OAbJqTcg7bMZgS+HigEtr7vQrqam/LeQMtbhASfBA9W/HFYLkfTjwMMRKZjCT4XO60SfeXhxuR58dNw7Wm33gSBtaY0EY4CG2S+jd5iymS9Pl0QKOh3Y25CuQ0GyMpIbju+Xd0giqmYxyNr1qqrtxfCEgi0s/hL5t46Hzz2pQ0F2GkguT9DHCBKrsgcRq155lzkUEntaiVoKEgw9E5dtNUj2/fbPvXRZxEB5YJspG5FJP0bYjP8Wv2qrnrWNW0HotbAroPG1Avl0bcuirx7YCYBlZutQG8YPap39Jdo/sPT/7c0MoEr91+cgb42FS2sjpCpEqtDZ3wb8BXRzY0Ffxbh5MmG7oVCAL6b4edCu3Fuxmib1jlzEguKwU2ixR7VY/BjZq57RyDRKYRmfcTu4DvlZ+DWywAyp6selxLbMDi31xCTObAd0gUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6661f04d-b5b4-451a-6316-08dda8ef5487
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 13:53:22.6468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzzOnXFo5fCiZ3WQoD3u6DCZyGxxxHkBSKp88xRFMmBqRze1ajHYVHZO/s03eJGXsHrr7F/YTS75dXcFBZcn6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=954 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110116
X-Proofpoint-ORIG-GUID: 5rcmMRExw09YN-nvEp-8IHjzlEroPIKo
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=68498a5d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=2YtQu1bGLftdnJPXFUIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDExNiBTYWx0ZWRfX55U76wBsqd9a uChStqly9UqhQvmVcKm7as/QWvyx0WPtM5KEgClFD4YTDU0ZLfwgqvoq/qc7UxDx3y4pz+6rZya N0faqlAbJAj61DLTr8kSHKMZ7DEHI0c2TpkUbuourbvywMYlwsl8E7r+igqAYOf+opopyGt05uY
 /SWASoN3qSJgg/sjgHYntMRb4K7xBA1bN+khjlvSvjJAxM8sKUx4gjJgSoq5WCY1kAA4otISf/B y4l8a3JaKl+J4T2rqUSkp11cgneer6eANj4Xq/6ezAKulUAviIzSvWF0HxdA46TwuBN1QOj9oQw GbeWLSZVXp7ZT3TlpDx1k3+PGIHvqe6zmRtQ37KvjalQFVZUTbGsNbeJES25dh6SbV0IPHU//jm
 YO3St0KSEBEuHCrLcprVhAVlT+Yz/ls5xl536JD8WtbOmj9XIw+iB+kC8702kbTZPmgQQ7Oi
X-Proofpoint-GUID: 5rcmMRExw09YN-nvEp-8IHjzlEroPIKo

On 6/11/25 2:55 AM, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 06:24:03PM +0300, Sergey Bashirov wrote:
>>
>> This should create 2.5k extents:
>> fio --name=test --filename=/mnt/pnfs/test.raw --size=10M \
>>     --rw=randwrite --ioengine=libaio --direct=1 --bs=4k  \
>>     --iodepth=128 --fallocate=none
> 
> Thanks!  We should find a way to wire up the test coverage
> somewhere, e.g. xfstests.

I implemented support for setting up pNFS with iSCSI layouts in kdevops
last summer. Unfortunately since then I've been distracted by trying to
find enough hardware resources to add it to the regular matrix of tests.

-- 
Chuck Lever

