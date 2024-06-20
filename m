Return-Path: <linux-nfs+bounces-4160-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF863910A9C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D97285F00
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D661CAAD;
	Thu, 20 Jun 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jhZKB7tk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oz9JlFq8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48C1AE090
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898538; cv=fail; b=JQhj/gaIgt2r6VyY6NtPTvQ0FMUCiyLC4b/bIaQv8GIJal5PjyfROUghE3J0bYH1/TJJu251rOhx2L1qC+i6iktS7FU/sMnOvpHPezV06FTYYsGV3Ob63KOEjxWA5k2mGCye7HGjrcx5kJAeq9q8BC4ylFxkMbOMP630/RwEolc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898538; c=relaxed/simple;
	bh=b/07ouV9uQVa2hBh34XezjTRZElUfc7/i8ZFLN1Vnxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nLKmCLGn90PLgOpaWeZ9k2hNJmOD0C3RJYO2Kpmg3J3JeovIGwR3s82m/XteYS316Pk1FdhvWRAPMprMHNOrRXfpI6/pN6a7PX64O59aU7QW8hkIIVP4ZbhkHuBipVP4VV0cpH/H7yghRIl0VOkX8ahilcN2hHOvznCXqzCz4iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jhZKB7tk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oz9JlFq8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KERxtc003251;
	Thu, 20 Jun 2024 15:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=gvSv4NGNmHj9Eqe
	+YIBgd1GwpEPxQmsCc+S/1q6MA+g=; b=jhZKB7tk5/yQUyacyEffYO4Q37MrGDd
	3mHeKE+zGUzU7kD7LD1dKpTc3z8HveM5aFY6CSzKYYaSAofdWJjR0Nylh58lItxY
	Deywl163VvCRwLpTsvE9lRniruIX24AEPxVPR0D3UiVjwQPmzG63ha1+eWrIMog/
	GpGWMrHaPsUJGr+aCqzSasUJnqGr3ZP3hg7LAm0r/PHZdPwuSSXPRjITr9+AWlG/
	7SutNeDQp7PnksdWcmpIQ0XICCOVn1Okknkw3Y/JRUPQzV2W7VYjPYnHCcpJJiZl
	8W0CFuLdSscAYeJIehU4gJOqmrk5ZFbCJiHXBI80ovc3CRm1uYOeQRA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuja0kj82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 15:48:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KF7BtA030635;
	Thu, 20 Jun 2024 15:48:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1danskh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 15:48:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqP9mLyakrWGduoAPIMcmhf3eK5bQMtWFpPy+OnCA73dC7XApK2/74LCnO1qx2ltWWHX+iLG9B69PyBj1nUmdGhA8ByOenGJ0IF+TAsxs5eSUEIWO4vUxCaD/FXW0i+NLmiw4+l8dcoJ3csFE0AOq/n8JUlhGZWQzllHqfjyX4AnJxOoFbjHBCzfAEvVhGy9Rwz+ABPuSKfiGoXPPYXKbCILMsQo0ld70oLzUdlUOgSLmeFYCPSwlLHoL+Hq6gtSBVTv0u8o6n8w0fgn5eUwAhvtTTRIyCzROI03vtULMlcOXybDHnWOmunM8KUVfKd+nfowJc6hAAnr1vevGXHkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvSv4NGNmHj9Eqe+YIBgd1GwpEPxQmsCc+S/1q6MA+g=;
 b=M8a6aro9mc5RilmTNWaq3Bo+wPqnCMu2v2qJB/A7MmVF9xNaYGTT1K1NZzc+l+zddlYwmB2bKGD62TwRFv5aO7Ke74EWtEXt8eijxTIMjv4/ZHy+Mtt+xSpWwkpRAkb4fXrRjxMNGp3ikEVHfqhenRezJ3OdWy/MY1QaUk44T22TM+9NoXTDKS9wW0KY1L/unLxcfB7Vca7yX9v5pUsKPBxVJjtThSy8vojL+iI4gJBA9JCPZT1/jTfiXaaGNEBxRl4g4oJsdi4SH4rxDtPXd2Guyn85L+QNb3GOeW0C3c2FcP7alfZIxfx3c7LuCMTKiUcFG1zYKSx/la8T5A2xmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvSv4NGNmHj9Eqe+YIBgd1GwpEPxQmsCc+S/1q6MA+g=;
 b=oz9JlFq8y4hCelA4BN7iPlnNGlLE47DtUKRsJLZr70pmN0kZ7FaCXtiE35T+s5X/Z02zYfhJR+eWcLmWF03Up6PMcm2SFOhS6m9ZLY2j3LsJUzhj5o6zEatnlNRQxG32qZsvZlLzNEmuN5Jhg1uCj/TWKsBmo5l7UKzV5GW/fzU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5771.namprd10.prod.outlook.com (2603:10b6:510:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 15:48:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 15:48:41 +0000
Date: Thu, 20 Jun 2024 11:48:38 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <ZnRPVlI3zVMP7Mh8@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org>
 <20240620050614.GE19613@lst.de>
 <3859730C-40EC-4818-9058-D74E4153623B@redhat.com>
 <20240620141519.GB20135@lst.de>
 <DC39D637-E108-4D24-808F-7AEF29440263@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC39D637-E108-4D24-808F-7AEF29440263@redhat.com>
X-ClientProxiedBy: CH0PR03CA0378.namprd03.prod.outlook.com
 (2603:10b6:610:119::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c205d35-51b8-4577-27a5-08dc91407578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QDkyfHvc9P7TATaFCXWb6YbNyWMlTv40aCtlnsm2JXL7UdXsqi9yQbhffHaB?=
 =?us-ascii?Q?2aOTKSZ6dpDNf63qqgXk30UT7EuMEzrEvTe4wq9WJCU1dMqoWGjVvyZ0nGck?=
 =?us-ascii?Q?Ifqp0MFl3tgAkVQ2w7TUDs4zJkoYDucP5bhOAqvflIXCdM4HV27vX0XpmWxZ?=
 =?us-ascii?Q?cFlSXJjSSkI/i9lN4/lTBwD4NGntR/m3Wj87xBpOe4OGAIbpSxKjAHjG+whE?=
 =?us-ascii?Q?mEqjJUOb7OU0saXoSeKPO2vSwX2KAZsfUjdYftUfr2xWF4qpPPmniDw6Gscd?=
 =?us-ascii?Q?uMIQXoWV8FZYmK4/2vAwk8Htnu4ofU+k7e54yb2ivQ0xjGcMMboUylhLE14G?=
 =?us-ascii?Q?Kf/CTssBx8T4gSoeHGv7l3D0hn2jTfkiWN3eeqfdo4fpQEJ87zOHw4M6ji8K?=
 =?us-ascii?Q?DQ/iblYhC+E8u7z+e51fIvtv175oWZZFVCoVSX4asmJfYeayGkjqJiZDGfle?=
 =?us-ascii?Q?jdMt8wp6kSgYocXgy5SsnqpVa/nkkNlfi4U91wowQOkVFeJYaHzZ5MBpXK0u?=
 =?us-ascii?Q?9p/cmVlYCzhyFD6zajMw2CgdCXzrcLX+uau3ETm0kkc1x5MeHjI2n1WEk8lN?=
 =?us-ascii?Q?opwEIhEOndJCTXXaMYjoZWzhLVr4h7wuFhUwt3QHbqy3Q9B07OgXhPUiE269?=
 =?us-ascii?Q?UcRF0oRGrhDrU3ChlCBcPru6z0W/t+SRGh+PYJJ+ronvydPYNHmNVN9wDaci?=
 =?us-ascii?Q?ulMFDGyyZuzsoA3Z54omntgZMSH6a6BZ9M2uKqC+DRAT9kUrKkfrBWYWa/ca?=
 =?us-ascii?Q?70FI/oGb3CzmvsTqJ8tQClcZMJJ+lMiWZSEOGMyFDhhHzJdkp4H5w66SxM/L?=
 =?us-ascii?Q?VsNGqhr//WpJZduQ9JPSpzHndjma5gIjTdu1zXxgmdR2gYkMmKPFY8Kk+7SY?=
 =?us-ascii?Q?mSOUv2mWzfTWEytttKl8Yhst08fJSjw8LR93ksgN+mcDm1QzgDaOFEo8hpfP?=
 =?us-ascii?Q?X8dNCvrr+tLU4HG16GYTRAou1dozbZiXCOGucVQTd9iNQM+/2myJbnpPegzI?=
 =?us-ascii?Q?QURhluf9Gvy/eReyDnRszAb+IHLbvlPtlnWES0zB2hXrB0pdng+ND92bIqvC?=
 =?us-ascii?Q?sYF6ILM8cNZJVHGAyvOu8zSM99td3MXrqz4AuN9BauafZwBMX+WJvr9xHN3m?=
 =?us-ascii?Q?sbcn2U1KO5YRJwhpnelB0x86kk7iqelgmZRdEHbSGEKnda2NTrdwpAhhGgis?=
 =?us-ascii?Q?pPjNCF6zaNF4rJ5SFLqy2GyWNkzWCyUUZ3XbyXHDvjVUEePp/ImeX49568BJ?=
 =?us-ascii?Q?lSMlzByQaWxwqKJa3Q2hw3U3IXQmxSoFEoL6AArSuk79QApPSXcZSFeGjmpT?=
 =?us-ascii?Q?U00PWM6IhfRn3t41n98X7l3j?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ttObuHG6RM6e4aT/vTK4mYU1VtPqqgQe1FQpWj3akDFdVzQ0aVacQoVdMFlN?=
 =?us-ascii?Q?V5nPm2x3XDy259cpe1DAayn84gf0fxcgS7mxQmzeq0CnMa/LDJZleUJoJfsP?=
 =?us-ascii?Q?Fo20eapuiizd+6eaYZAju9aPtWVD0Os0bs1nK6XHrgfZMivEWVz3R5fCjEzU?=
 =?us-ascii?Q?BJ2M12V7e8J3JsAfiGU6DoWIXYj/dOpH6s9PMc4J3ia4Y0ZL7JMP0sGMDISF?=
 =?us-ascii?Q?ktyTbW4V1tt8hE2KqIceARDGS9srk9KA2dEvTfxJYa99PTaE7fXk7ZRMhFIK?=
 =?us-ascii?Q?iO5IAvjKlThXGSgQCJAogqopDh+SDygQKMhjMmJZavcc728uSrEzN0wnJA4d?=
 =?us-ascii?Q?YzK1VKLZM3PcX9W8wVNAx4+24ts5xaXhGrAi7WU84QlVPWcb4wvuJlkf4hnH?=
 =?us-ascii?Q?X7h+WzMQb3bBoCbksXFgizJg4P8Jpg72ay9JJzyAG9OSNwNIlt2IblIO/JUP?=
 =?us-ascii?Q?1TVUJHFdHgRbHC4Ia555S2M/KhpTORMtyqSnGiJH7iaBcp+v5Y8ICEo8wYd+?=
 =?us-ascii?Q?TzRf84RfjGgB0hJ6wbMtAUl0G9FkmikGkpVKnqCOnCZIKOJiUTN1atq5P+lu?=
 =?us-ascii?Q?eRC7jNwrYL/8SR86/VyBTK5FS5wLNZIyPoVgr8i5AMEtUbkedBNLCWXwr/IZ?=
 =?us-ascii?Q?dHE+YsKPEYpjCgDv6dQ5zE9H+7sQQPgGOpbqa97fmwXi9lHIH0zdJBwmHD7q?=
 =?us-ascii?Q?4o3pE8qzquCHjyjhhutLqZGK5f3sk/+bh8Z1i9A05q1OfOha5WfugKDU73rZ?=
 =?us-ascii?Q?rj/GB2FcobQvxDwcHb7jPuGfOhibkh4xpM6MoWkNCFwmbOL21NXu/B7UX5EU?=
 =?us-ascii?Q?PzqoywNGrMA2e9HYsDEi+B+atCHHNoexYWOdVEdJgUM4/kjImyLqMtW0p3A6?=
 =?us-ascii?Q?GIMEMQmNxle+8vqEYteeVj3OvHaxH2BAZvEjRqOp4GJU9XFeevCLE80vQ+fm?=
 =?us-ascii?Q?jzw99hAgApmnqoBp9v91+FNahQzN0HTmz+OUhZCK8JIMMgl3wY6hOIDZXM0w?=
 =?us-ascii?Q?4DvOCu53MR6/GuHjCmqz48X5BjiX4G2ss5lt3kjqPw68zm6PdMK6cevOWWBq?=
 =?us-ascii?Q?4o26qkP6bQvwsnEfzFf6akBnGKA8pnHevzQqv+zZxUfO14e3W96+xzZusEEr?=
 =?us-ascii?Q?UlrZZj9Id1ibJNuHE6e5+zq9pU96iE+i9slhbrL75cgcsWNSy48ZupuEI+LM?=
 =?us-ascii?Q?oc5RMJga93x/njBDlO5bj8AAoneWwI3lyuus2RujVbKTj7nKgN1u9ibdhC4P?=
 =?us-ascii?Q?GHbfFH30yUaOF1yzYmPot1ryPpcoPhE3nMNtizSJ8eSP4HTBXV4qw2CgYX6i?=
 =?us-ascii?Q?ojW1y/nM5Ab1mt8e20Dma/JGxKOI9rsldvvilxcyS1mXJCdkhod6twCVEUdu?=
 =?us-ascii?Q?M80KBAOW1qC0IjEhFG4CkegVnY7mpZUGJ+QSFulrINcvKJ8LcNB7wKxYhcir?=
 =?us-ascii?Q?iykN1xNCCPXcsuS2povVpkz2xJsP3Z8R4tUHnseWC5G7asITlXR4qxjN7GDt?=
 =?us-ascii?Q?hA/Nt165TJjA53ZjUWHNiZVwj6BTUOpl5hQSIwdNIPtUpol+wbMZlvyRAEkP?=
 =?us-ascii?Q?FL2II5b/h7TQs+g3+Y8tL13O63wFmmuBQZiQW/wZ8cP0GFEEinmVQF52QLFS?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gW+F12CHmpoQ4qqaZx+Cxu6rdDTgfbZt7yefWCNKVmgmbl1Dxg3ZaLmGxMpiPheqK+iFAtfxJ1aKAVQCzt+6QQX1QZbDVgqEK4XQNoMDHGZVVgyrPlbNZIYUQ2pyttKJDRTr13G2pRSThyLpZ0xOBZeaRSbd+fQgfmbYzWOxgziedx0A92QRMFOdxMGscHSTsLFL50nt4ryi4w+rCtYpMbdYHGnaL3NbgvD6uBwcaGL2gUkDHnT6up+sgas1PgVdnyayiX0VwapUav8Ynh4wOJeCsW4us8OYKvzOM1aBoxCbnBymixyWfmFWF4mVCEGVHa2p6soWRhumgambWG1gqQElL35VxoDUPr5Rpy4iL04paOv/xk5hdOaUo32Mi0sqWXvK04TFjk+ocZ/dEGTFby34tRPlr40mi6Lonj3SdkIIdSuKug6xfNi4z0LhsEarsk+RmdPYx/S5DYjdtKZ0qalhfP/Jv5QRr78mo17ku+z73dyO0quXwfDEL4X5jV3k3S6poRm/vVaIhOu9WiECkAhJ/BXGLkLD/e9dwMEXCobynLhjWKtrRnRlOEGjtAvJbOwP0IBcQG1V3rvVaBPxM6/SPrmPWe/SVA/HMt+rIso=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c205d35-51b8-4577-27a5-08dc91407578
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 15:48:41.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk+OEH2X7fNzwoDzaUShJbmglh3YYfSefvkWY0BB255VcCbIx7E+GLtAQZPwH1uf+axGyvU3+3HgTfL/RdOOOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=536 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200114
X-Proofpoint-ORIG-GUID: 9x46mzU59C6zm-Dw4IabsSRVHukdDZ79
X-Proofpoint-GUID: 9x46mzU59C6zm-Dw4IabsSRVHukdDZ79

On Thu, Jun 20, 2024 at 11:45:02AM -0400, Benjamin Coddington wrote:
> On 20 Jun 2024, at 10:15, Christoph Hellwig wrote:
> 
> > On Thu, Jun 20, 2024 at 09:52:59AM -0400, Benjamin Coddington wrote:
> >> On 20 Jun 2024, at 1:06, Christoph Hellwig wrote:
> >>
> >>> On Wed, Jun 19, 2024 at 01:39:33PM -0400, cel@kernel.org wrote:
> >>>> -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
> >>>> +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0) {
> >>>
> >>> It might be worth to invert this and keep the unavailable handling in
> >>> the branch as that's the exceptional case.   That code is also woefully
> >>> under-documented and could have really used a comment.
> >>
> >> The transient device handling in general, or just this bit of it?
> >
> > Basically the code behind this NFS_DEVICEID_UNAVAILABLE check here.
> 
> How about..

Let's leave this as a separate patch. IMO this is dealing with an
entirely orthogonal issue.


> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
> index 6be13e0ec170..665c054784b4 100644
> --- a/fs/nfs/blocklayout/blocklayout.c
> +++ b/fs/nfs/blocklayout/blocklayout.c
> @@ -564,25 +564,30 @@ bl_find_get_deviceid(struct nfs_server *server,
>                 gfp_t gfp_mask)
>  {
>         struct nfs4_deviceid_node *node;
> -       unsigned long start, end;
> 
>  retry:
>         node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
>         if (!node)
>                 return ERR_PTR(-ENODEV);
> 
> -       if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
> -               return node;
> +       /* Transient devices are left in the cache with a timeout to minimize
> +        * sending GETDEVINFO after every LAYOUTGET */
> +       if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags)) {
> +               unsigned long start, end;
> 
> -       end = jiffies;
> -       start = end - PNFS_DEVICE_RETRY_TIMEOUT;
> -       if (!time_in_range(node->timestamp_unavailable, start, end)) {
> -               nfs4_delete_deviceid(node->ld, node->nfs_client, id);
> -               goto retry;
> +               end = jiffies;
> +               start = end - PNFS_DEVICE_RETRY_TIMEOUT;
> +
> +               /* Maybe the device is back, let's look for it again */
> +               if (!time_in_range(node->timestamp_unavailable, start, end)) {
> +                       nfs4_delete_deviceid(node->ld, node->nfs_client, id);
> +                       goto retry;
> +               }
> +               nfs4_put_deviceid_node(node);
> +               return ERR_PTR(-ENODEV);
>         }
> 
> -       nfs4_put_deviceid_node(node);
> -       return ERR_PTR(-ENODEV);
> +       return node;
>  }
> 
>  static int
> 

-- 
Chuck Lever

