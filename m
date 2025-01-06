Return-Path: <linux-nfs+bounces-8923-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD9A01D0D
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 02:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96C116231F
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A3381A3;
	Mon,  6 Jan 2025 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JeeRuzNj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jcKV3r5t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FD17C
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jan 2025 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736127576; cv=fail; b=JMfHEJC6QPwLO+29EuHrqkrfvvUsU02Gruo9AMpfePDW580PinLEfurXCRHPtpJQculJwmioIsopBt5bB5+uS2xac5oX2QQpyNeNAwteP3h34bhN36WYgiLlEyYRl3d5NBaphCwVt3NW7HgrDTRRPBFxZV3hHhWMdQ4DuRRjCjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736127576; c=relaxed/simple;
	bh=ggX6F0NxK3N6EmftqcCBl03W9ZdoRMToQMgplUMjLzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hp1VfcNuUINtNs7HoxLkDSzyENocd6U4c0c+ERX+ot4ZZ3Vnw9wYOcA1XaKh/0pBVUUvMMDKg0+KGCGBS0W9HOW5egPikDIAT8eJ4jJ3H0vppyHU/mzxzWMU3/sxv4HSloHO2RqscVwHZJmwX7vurfdWg62EsGa3hFufVlBoWvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JeeRuzNj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jcKV3r5t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 505MMHIE021427;
	Mon, 6 Jan 2025 01:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=b7dajuAH4Rimj8wVhyNDC9E0W6jT0TMwhDqlXtUsLEA=; b=
	JeeRuzNjVqByqzkjFlM4zZNJnjinjqkzXktSpj22/wCJiSqSXn7KTF4iUOz/WFqC
	tN8Iogo9I1rTrgoutGq65APJjJMQQU5L/ph2LC0Ycsece0Rxcb0h9hC/SRYZG5G1
	J1pnXaIFcQQQrfxmlA0DssqenHMyJLZkRvtF/shX+gjNkgJZXk5JupSmJt/qz8Cx
	VfHUXiadho9yf4f+pa/eBoSpNj3luog3V1+SpnnGrUsMWf1mDluFXSr7e6myqEHF
	IgG+Artl1bzBUzPN1omlWI3STuwWLetHtIeZUL6m1VKgUbGhQjFH4KLhFanyddjw
	ylttnijUzgTpKmZaVfjv3g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk021pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 01:39:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5060w1CB019969;
	Mon, 6 Jan 2025 01:39:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xued0prc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 01:39:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceOd4+6kO/jC35koB4dJnJjo+j1Y1J/meSp2mqEgzh5RixMsxMnIqHonLlpauuXqYnbHj3ULWGSu5dQrltTn6xtwjM8bQSA1weFIIo2wYiMcUKXpGJF/EBtXFIwOxsxjeDIwhD/kPN7ZHuynBthIhMR2SZAkUP/5gIBAYsz8xC6Kr+EJ3cgHfo90CLrxW0ujm67Ad4KX7RgwaID/uPyt5HPNdY7AaMmkOI7foP0H7NL0qoFVnAkFwwqOuuZ/xIAOq+YZ2pmJW5OlmI3q2EkzqdsPAGxzr7tW8ojWLk32uM2/4D4Qf9zBh44OaVsDMLPUOKuPUXLSv7l3ixGYidIMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7dajuAH4Rimj8wVhyNDC9E0W6jT0TMwhDqlXtUsLEA=;
 b=ILdUeo7X56l7nWFVouFe9JUQAYunB2CDkN6Xv8OB19qyDRerYeEHQHDu/Sl9JyE7+NPqCR06XRXg50+EhA0dTRl4F8K1DLEUT4mUEc32Ms44CrC8D08d6x6uEUGTbCXOqbKvOhOJ6IKNLEWK8aBPJXzkyRZuVQ6md8kF30nfyUJxzqTdhBjP1JX8odaKtyGfCTtwRw7Y96ldi4umpo8CK7FcQYDGMn4XSxK8umd7WdWY5njVzwvQhoK4IfG6M3IIE7QHnIjCLFMekv+n+j+zl+bTrLOUbOuJhvKzphR1YNlnHKs6ZK1GoktI0GUih+5c8k8C7EBRRbRtmujLS/mD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7dajuAH4Rimj8wVhyNDC9E0W6jT0TMwhDqlXtUsLEA=;
 b=jcKV3r5tB1jwSTWUG3HjrO+X80eBacsIHwzS0CI0+0gKXJmj/Mofe/rz6By5Q74/1GZDCbopr9tWPd1HWOwyu6TK3N81KWoDHVv69yjfb1kzKD+pdi8BE0keM0rNRNO4Shz//FN5GMSenTfhyyH3w6G9iibWSPMZwqD/4QR0gWE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 01:39:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 01:39:05 +0000
Message-ID: <354b8db5-0929-43ea-9934-69ee59b5d3a0@oracle.com>
Date: Sun, 5 Jan 2025 20:39:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] NFSD: Change the filecache laundrette workqueue
 again
To: NeilBrown <neilb@suse.de>
Cc: Tejun Heo <tj@kernel.org>, cel@kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <> <3212763d-7c93-45ee-8b27-fe5d6a9e7fe8@oracle.com>
 <173611613288.22054.13027633542289679485@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <173611613288.22054.13027633542289679485@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:610:b1::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 41649cab-fbd1-4f16-949f-08dd2df2e7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk9ZNUZVZFI5amNscGowUE1jSURaZC9pS0hKL2lveklRV0dQSk9hMHpHbVM1?=
 =?utf-8?B?SjdONm5FSFNmZ3NFcXFCVG13MElQRDJMNHY0ZmNNNkpGV1FzRDdOUjJUL2tP?=
 =?utf-8?B?QnRIQXdnbnlERVM0aklqclRrTDdpektWVGtKSlBnRHUraVdXRm8yNHZFNGlo?=
 =?utf-8?B?MkJrWTVhQ01uSFlEcGJvaFV4R1BQdThCTG1rWVhpUWxLUmJ2cUxwNFZ0Nlcy?=
 =?utf-8?B?VlRkcVQxZnZROGt5NkRKcU9Ca3NuNUZ3UGhsQkhnNElVWmlJczNTR21PSjFF?=
 =?utf-8?B?ckZ4UzRhUDBFOC85UG9haVcyekVWR0tjeUZ3NHY1MFR2UFhBc2pFVTkzdU5V?=
 =?utf-8?B?eThvL0JoWGdvSHhGMGt3ekxjejI5cEZwRFU2cGsxaGh3RmppQzVBM0NqMGdR?=
 =?utf-8?B?OE92NmZGcGtIdmZIbDd3MmJmMnRuV1A5bXVWT2xrckhYV3ZuQzVhS0FzcEJH?=
 =?utf-8?B?SnlZcnMrY2VKa0NCV1BvZDF6amhJZGxNZGowZ01xaXd6ekhhOG1HUWhKMXZP?=
 =?utf-8?B?UGtjR1JxSE44SWdRaUxRb2w1Q0xYTnFEQmlFZzJVbFlZNzVzUDU4Q1JUR0Zx?=
 =?utf-8?B?ZkJNVTJINjdTVHZsMjQwMmNUOXdaWFB4SVV6SGNVVlNwc3BJVEN3UjEyN2dR?=
 =?utf-8?B?MjZXTTdkM1hyUVFBeUl0MUNOVnlZMU9DNGl4VDdmOHB4YTRMdko2ZUQ4YmFp?=
 =?utf-8?B?SExLS1ZMMG84WlFocDRVVHpjcFlzT1ljN1BuRW5SUXlTVW1uUlZkRWIrQ01a?=
 =?utf-8?B?SXRUWjhKb0k0SEJ0RDN2dkxTbnNRVHY0MEt6MUhVNjY5UU1vVVgrdzdQaFpD?=
 =?utf-8?B?Uitad2xCb1JJYVZXOWZLOXRGcExHek9XTW0vVVlSQnhuRTBvb0VwUHB6Z21p?=
 =?utf-8?B?YmIrdDA5dlg0dlhtdkh6bGg1dGR1UU0wQVlsZTNJVFFDNUlqdmIvR0FJVVE0?=
 =?utf-8?B?TTRORGpJRys0d0dIbU51Qkx2c3VtMW83TEE3Q2NEYlphTkZCekNIWmtBcENy?=
 =?utf-8?B?OHVGQk53L3pzbFAxOU1LcFF5a0hUNXk1ZmVxYlAvc1lLUExDem90cVlwYm90?=
 =?utf-8?B?YzExM0NrNE9RSmJJMFdXSGVvbnFMaFV5ZVQ0Y0M0WTNVMmpnRU54MStDTkRo?=
 =?utf-8?B?SU1KdzdveG5YdHdoWTV4TzNVb3BqWFJEUEtmN2VmOGpSVjNQTlk2bHlGRHJn?=
 =?utf-8?B?ekRHNmxOOVUxSmYrbExZbEdySDZHK1pMaFYxM0VKcXBWWEd0ZTNYYVBEaEhG?=
 =?utf-8?B?blEyY0tEbXhVdlRNZDl0SFJ4NUJkejNCKy9vRmRTMi9TY2t0cDZWTlJYeFg4?=
 =?utf-8?B?RmU3Q1V2T0lQV3Iya2g1NitYMEJIQTVPV3JuMU9CdkRIYXcwTi9yTmVhcHFa?=
 =?utf-8?B?Mkd0VXA2NDJ5clJGRURvMnpYOG55cmErdDRjUys0SXhyVzVnaStleDlJUE9v?=
 =?utf-8?B?QUNUU1lhVDV3UHB6YWVjRkVDcE5UVXdqUHBROUtvTytudlFSOEZReXdjRTJi?=
 =?utf-8?B?aHQ4WXhodjJGa3NuM1MxL213TUJyQXRzOHV5NWZSMWpBSkdmS3cwY1JhWG5t?=
 =?utf-8?B?Z3VwZDNoQmRxRDJxSnc4YVFRT2NiYnd0WlhtZ25Lek4zWE5KVDdodWloUWdU?=
 =?utf-8?B?Mkt5QnNNbmtaeUMvTCtEK1R5alVmN2xOOE5tRHdtMlJZZG9qbzJQSDNQSWIx?=
 =?utf-8?B?SWI0L2p4NklHNEkvQnZCQ1BMNXZXOWxBVXFHMEQwanRSYzFRTWpWMEJseEtp?=
 =?utf-8?B?RXJPa005Wis0cG1zU295ZHRySjc4VEJwWXB5eklOdGNCWjBIUVEyWEtUQWMx?=
 =?utf-8?B?TGdJbkJUS0U1c3RGb0xJcnZQR1B6Q3N1RTJhNTJUbmRoWE1BeVhEOGZGZDUr?=
 =?utf-8?Q?2YtNEm6VIQVNr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZSUXovZEpDQzJOMmdPaG16VVlVbzZIY1JCNDFTTkdXWG5OdW1DY0FTMEVo?=
 =?utf-8?B?aDVVeG13UXg1cVM4eUk0RjZNcmdIZDBjTzJFMVFSbEF1SHBTME5yY1A5bDdt?=
 =?utf-8?B?SDlnbmdNSnB3amxxOCtwSXVJclU4ajZURS81MVg4VkZVOEtudWYvd3ZUL0No?=
 =?utf-8?B?UGIzNDg5ZVUzVVRjT2s5UlZiR1BheVdGOG9hU1A0SitFUE05NXd3dG5pTnZO?=
 =?utf-8?B?akUvV2dZTHVpbmtZN1JFTXRCb2VpczIxL0hnRTZ3bGRtZXppSkRpaGxRc3JH?=
 =?utf-8?B?MW9EaWZoVUpxK3FDUkhGQkJZTE95aXprT1NtWjV4U1B2bW9BaGhrVWlRZ1Jl?=
 =?utf-8?B?UzIydWRiWDlzNFpIcVJ2dVhpdDZySEZickMwZ1F1RHEvcVhWblgxczNvZDlF?=
 =?utf-8?B?MEZSeEZLMjNvSlpZYWR2UlBkWUE1cnJjaFVlWEx2ZUVtOXYwcE1uMlgzeTNq?=
 =?utf-8?B?L0U2TjJKUEsvRGJBMURUSlEyLzRuWW80c28xMVAyOVRXU3krNTlwTHozSmFa?=
 =?utf-8?B?SGhvc3RzTDhidmNZdzNMMWx4bTRDRWc0WXZURHRxN3N2K0FaREJ5aXN6U2xt?=
 =?utf-8?B?Q0doWlNwaXhadDBhak9mRGh4NG5ITDE2ZmliRDFwVEg3R0RUeHlkYmxXQ1hZ?=
 =?utf-8?B?RUE3eEtvWTdUa05jSCtPbFZTcmk5TGpINmUzZHVyRE5wTGRqU3E5aUZzbFNx?=
 =?utf-8?B?eVM4MDNxcXN2cTVlSVdZcUJRMDhrVENxNDZOYlp0TUo4QUJhMUMxU3NHTDJi?=
 =?utf-8?B?UEhQWUpzQVJMMjVQUTI4WmhKM2JlRldpaFZWdWR2Njg2a3N4cWhUQ0VwMW14?=
 =?utf-8?B?N0R1emVwcVlWWW4yOHZBRVk3em03Z0lyWHRuTmpGL2NsQXVESjVRNWxuYWJi?=
 =?utf-8?B?K05BY1U1WGp4R2NKd2E5bUY0NmttemoxK3NlNTRpZ2lSQ21OT0hZSnJ3ODYy?=
 =?utf-8?B?YTcxRWxmSW9LZ0dJbm5QZ3duSWI1bk8xTXEwWDA0cm1VL25QNUpFYUNFYXJL?=
 =?utf-8?B?Z2QwZ2hjc0hEeUhzMjJVYmJGSGJjRFREMVdUNS81Sm5Pa2pEb04yMHEzZEpL?=
 =?utf-8?B?YlUxSHFzZC94bXEwd0xRckZUMFJxdzdXb3UrMEdhejNHY2ptVGk4eW1aWmdl?=
 =?utf-8?B?Nmhmejk5bXc3aEdyUmpsa0ZoNmJJbnhzQ0tPWkFTS1VHVFM5QTJ1clNoTTBp?=
 =?utf-8?B?REtNUWxvMDMxcjlTQURCT1VyRWRJdXRHZDlKaWxFTG1KbXJCdkRZeTNrT2JJ?=
 =?utf-8?B?cUFmelVOMjZYUDFZQUlhZ21wTnJ5N0dNakRTUHRwcThaUFFnSHlOQ2xYcDBN?=
 =?utf-8?B?cWdad1F5bnAyQlc4ZUZWRjVpZENkQ3V2YUVpY3VNd2Z5WmJseTBjMnVpVGFq?=
 =?utf-8?B?WFB1OG5PbG9UdVJHR3NHNXVzcFBUWUNKa2VZRytBaDNwdjhxSFBLaXJmbnJq?=
 =?utf-8?B?bU12a2VHRk5MbEVnd2FNYXEvTXRvU0RiUmJRWjN1c1F2NW5acERPSGFHSzUx?=
 =?utf-8?B?cFlPWWMzeWhuSVlBMlFEWHo0VzR3aGR1aTJXOVBwQU9VWC9YVm51YUlJend3?=
 =?utf-8?B?MFhQMHl1eU1NbVpMOVY2OUVnUk1TZVpOWjRBSmVVdEM2cExJU1FnMitVMDBL?=
 =?utf-8?B?UVlESkl1N3RkZDFBdkZneFZlZXpPdFJhV2dXYkR3MnhhVkNYZ2Q5eHRtRnAv?=
 =?utf-8?B?VWZEMDhKckorTkQzM0hiLzlaWjUzYkJhZUkzZWpTei83MkNSWnlzZXdDa2RQ?=
 =?utf-8?B?RGI5ZmNvZ1FUT1g4THZ1R2dXT05MVDFTTyt0Y1NFR292OUljcXZ4TjdEUHh2?=
 =?utf-8?B?MFNTejV3UkhKcllyMlVrOGVqUVVhNkE0bG9BRk9ra1R0Q0F1SE1oMGk3RjZR?=
 =?utf-8?B?aFJ5VHJlTlFxY2xRci92ZkxBeG5xa0Zabyt5SGVOQmxvdDlMMTNSOFUydm1P?=
 =?utf-8?B?VCtpYjhUeXNBdVc1ZTY4Q05PN1pOdzBrcDl2MVk4OFZwTUxEU0p4NmprQ1h0?=
 =?utf-8?B?aUdBZW9obnVFVVV3K2tZRDdyRmFJV2J1U0JtUXY2bkJ0YzJGV3ViS1Q5ZS90?=
 =?utf-8?B?RlZ1TTdoeFQ3YjhTN295OWxYcGJ2dHhHc0d0dXZoSms1UmVJWGNwTTJmZ2ow?=
 =?utf-8?B?K00wV3NZaFhpb0ZaVVNZMFB3YVd1MWJpdzBBWjFpLy94K29XemRvY0NXaG1G?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uG4R5hes4TqyC+HQ5oiVb6wquIflq4W/C3tMTNTMYzQuQda2uj+qNIXernvlfeyKxCYQWwElSj/xABF0EF/mexGe6G+sLFHswo2WZ5aIIXv0LSQSu5RUn1kszX2hcv/ix/lQ8PUqagu3jpBKlP21FqHiD9e7uPrzYXofUZ8PnVAmuOGAL72IAFM5phn1ekh/CkZmEaJJLfBjnGCIpjDU87cCHuwD5yXVMdXaplQzTSGmNZ77Wd8MBM/nAdfD+zIMnG1YHD9W4qX1X+ZmVXhWL5etFcW1QRxdZiljTAAHcybL+EHuiS0yyOocUNi2n7/KdWItSQAq/rtNdmhpb0Q2vizlmbYCJCIr9YZBzDPeUcGaNVQ40muD39tghAZ7kWrKcBDJU23GOCnedJdcYG4QXDIYEC2Z6M/4GoAxR/XNM8oKcQB+WShR7V6sKng1i4yVpFx39lSz8UFi1T24y4hGnbhulpGTURRIDc2lxzsdSik0EjDg9CzOWQmXhdSCKi4q9Epivwtmv0rddeCEgEK4z07xVw/c4wzz4xot2zsA6fYPbdjS32x0q2EwRRJDnczbt2jIzriywaoyHGJtNYZYog2Lx+ymSCfxhm7VSDj2+os=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41649cab-fbd1-4f16-949f-08dd2df2e7de
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 01:39:05.3053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0ikkV4W+ffBRiTVK/gyxth5HQ4vZGNpqPvmRXfB8mM0uy50At/rQKU//3IdloPXKCIRhJKipljhhiuVEQBpyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=886 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060012
X-Proofpoint-ORIG-GUID: ypEJdYAFbUGUrC8EyHNQBs36Raho1px_
X-Proofpoint-GUID: ypEJdYAFbUGUrC8EyHNQBs36Raho1px_

On 1/5/25 5:28 PM, NeilBrown wrote:
> On Sun, 05 Jan 2025, Chuck Lever wrote:
>> On 1/3/25 5:53 PM, Tejun Heo wrote:
>>> On Sat, Jan 04, 2025 at 09:50:32AM +1100, NeilBrown wrote:
>>>> On Fri, 03 Jan 2025, cel@kernel.org wrote:
>>> ...
>>>> I think that instead of passing "list_lru_count()" we should pass some
>>>> constant like 1024.
>>>>
>>>> cnt = list_lru_count()
>>>> while (cnt > 0) {
>>>>      num = min(cnt, 1024);
>>>>      list_lru_walk(...., num);
>>>>      cond_sched()
>>>>      cnt -= num;
>>>> }
>>>>
>>>> Then run it from system_wq.
>>>>
>>>> list_lru_shrink is most often called as list_lru_shrink_walk() from a
>>>> shrinker, and the pattern there is essentially that above.  A count is
>>>> taken, possibly scaled down, then the shrinker is called in batches.
>>>
>>> BTW, there's nothing wrong with taking some msecs or even tens of msecs
>>> running on system_unbound_wq, so the current state may be fine too.
>>
>> My thinking was that this work is low priority, so there should be
>> plenty of opportunity to set it aside for a few moments and handle
>> higher priority work. Maybe not worrisome on systems with a high core
>> count, but on small SMP (eg VM guests), I've found that tasks like this
>> can be rude neighbors.
> 
> None of the different work queues are expected to "set aside" the work
> for more than a normal scheduling time slice.
> system_long_wq was created "so that flush_scheduled_work() doesn't take
> so long" but flush_scheduled_work() is never called now (and would
> generate a warning if it was) so system_long_wq should really be
> removed.
> 
> system_unbound_wq uses threads that are not bound to a CPU so the
> scheduler can move them around.  That is most suitable for something
> that might run for a long time.

That's not my understanding: unbound selects a CPU to run the work
item on, and it can be (and usually is) not the same CPU as the one
that invoked queue_work(). Then it isn't rescheduled. The work items
are expected to complete quickly; work item termination is the typical
reschedule point. My understanding, as always, could be stale.

But that's neither here nor there: I've dropped the patch to replace
system_unbound_wq with system_long_wq.


> system_wq is bound to the CPU that schedules the work, but it can run
> multiple work items - potentially long running ones - without trouble by
> helping the scheduler share the CPU among them.  This requires that they
> can sleep of course.
> 
> I haven't seen the actually symptoms that resulted in the various
> changes to this code, but that last point is I think the key one.  The
> work item, like all kernel code, needs to have scheduler points if it
> might run for a longish time.  list_lru_walk() doesn't contain any
> scheduling points so giving a large "nr_to_walk" is always a bad idea.

That might be a overstated... I don't see other consumers that are so
concerned about rescheduling. But then it's not clear if they are
dealing with lengthy LRU lists.


>> We could do this by adding a cond_resched() call site in the loop,
>> or take Neil's suggestion of breaking up the free list across multiple
>> work items that handle one or just a few file releases each.
> 
> I guess I should send a proper patch.

More comments in reply to that patch. Generally speaking, I'm
comfortable chopping up the work as you propose, we just have to
address some details.


-- 
Chuck Lever

