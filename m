Return-Path: <linux-nfs+bounces-11351-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21302AA116B
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 18:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE8D7AC6CD
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D3244670;
	Tue, 29 Apr 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C4fukIqi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E14xVa9v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D3243371
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745943303; cv=fail; b=B6xsT/bg5375hX8P8XHtju1zvN7YWB3BPRF8GJQUOEOM6VIgCRTW5VdfJzX6IbN6YPyPOByt+ukCjwgJNGHFdnEw5UAIJM5KJ3uUd7hCfFyhvs0i/FKI0XNzlKL2Jn7a3tZKSiJYg5qIvVRLhcoP+UI+8AXCD8IrW9Lfpu3Ck9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745943303; c=relaxed/simple;
	bh=xU4ojbVf6aLyLib/gYx8RzO9gIrfsbgZ5e7vn0VTWvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R4pVQWUbD/97tSf6+mXu5HfGtiYLKO0YxY9GucGOIhDydDCm2wXj4V1VsrQmCwVBBoDGZhpD1ygoIZqPX199brjDVsGA/k2CvazUtvq7llTxEXCRP6ilJ4/vNiJrEAO7Tls1JHtrMWJS7AtOYouoersxrINkJob/Z26uf7c2Bx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C4fukIqi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E14xVa9v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TF2EwH021957;
	Tue, 29 Apr 2025 16:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xjB+pm485hPzcPKlHuMFaGJO8NeaWIEb1jATMErj1TA=; b=
	C4fukIqi4KWoqvX3jWzkBFdui5pYecDKtraW1NncmLG6hInEwYXpMrkA8d2i0BEg
	RoiBB76MCcqPbJY/WupyH7RcWR25L46qeO9AJLiB/MafbtftCm+4SMsI+hhcNRmz
	Jvlu9y2vVbmfpXvwRgEvUerUh9uVIS+ZDUofMNnvzJcxjMKS7po/gVh2aur5XOoe
	g9f5TzIUc7b1SBcEuunauViIgdjcSdqMEYi2nRhqhVlpTMxtCqVVOyjhqx5LlIsQ
	u6M8FPq7SWAAFh3wrhyV/UgJyq8NyXd4QR0FaebUejsFu9a3SO/g4nNMnfZlMXHw
	mZZATqm2spAjiZjX/xiMBw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b127874j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 16:14:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53TG7F8X011408;
	Tue, 29 Apr 2025 16:14:57 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxam82s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 16:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fy87ySOM2jqzFRG7sTKz4DMRGRUwIEZxmRh1j+RF7z5qSG4VnDgEYt6/22p3apsi7xKVDPI1NwxxGRXAl1jSPPCehMZDBO8o7eUxVkNYfPHlfRnahLJLoPONU2NgT86tEkD9jrOgqk1It7iEesWo11txJ9wyj96XSIlZYDzYnDrpoEdF3h1/d6kDW/FKvGrvTUA2Bh4GqpGqNMsREXgp6oIEJ4aMpvTRrRBxrRk1TpKWN8RvgFCiYAundSFIhCWnl/NuGZs7lSuWFBK/EdmAD4dZac9RwVdVC+BUYPcYAV+cTYQnATuB5XUWc+nVxjlL99vNWeh+c53pjYEyvC38lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjB+pm485hPzcPKlHuMFaGJO8NeaWIEb1jATMErj1TA=;
 b=cj3S34XRR0p+azp1bXJwimVrHfXAhFrSMv6D4lAxovn28DjKf2HRJgsL6nzZC/narfne/9jWwY1Xwt7YzyyhzZ46jnuTs9zK/qvc7L8gaIyhrTfIuKOCBZgHwVh3Nzj63fO6EW575xRtrFLXObuat2nBgkd0i7mURqUDUjNHLl8mTNYE/0EP5BP75+yNOLwxJHRIhExtWwMxyhpikfbHWOGFoB1zDR3XEpzx4LXwIxbGVQS2FuOS3kmwVLuoEaVjtJiLOuSPCxtgFFcjdaJfWl7FpUs8v7hlRv0fg7EImDzTqsHqPHgAYkvxCQJcrGGbZMYgvjpIwpUpl4YZEwg1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjB+pm485hPzcPKlHuMFaGJO8NeaWIEb1jATMErj1TA=;
 b=E14xVa9vvSC4UHtWX+K5jcfhOcilLZ+vVjEiksqp0Fi+0SyyEa0J4H8+7ehX/K1j47NyOx5KQElihfd6RoyNFwDuUq/mE7Hr3cD3dUjSF5rmw0nr2gMdm1ge1z8e8F17DPLcWrnFAhKfWpr3cGuEwH7Ivbpop4RUqL8F3tfm1Mc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5883.namprd10.prod.outlook.com (2603:10b6:303:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 16:14:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 16:14:54 +0000
Message-ID: <2526363b-1f4a-4999-9f9a-8c4c5c6c132d@oracle.com>
Date: Tue, 29 Apr 2025 12:14:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS: Avoid flushing data while holding directory locks in
 nfs_rename()
To: trondmy@kernel.org, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <a804c54445a3f028007763e05285d765afcab0f9.1745794273.git.trond.myklebust@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <a804c54445a3f028007763e05285d765afcab0f9.1745794273.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:610:60::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 02015562-ce24-4029-ef74-08dd8738fa39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L25lOVVNLzB5T3h6eXNLMnozY1NrbnEvRUppMGJ0MVJ2V05DbzVJV09vSFFi?=
 =?utf-8?B?WWJ3bTRHU095dFlCWkkrMWxVbHZGQnNackNPL3NwNEQzWWJkZjJ5UC9qS2p1?=
 =?utf-8?B?Qk12cHF3MzBEQmVUV2U4bDZJZVhJYnRzT2RUUFFmVDdSWWk0ZVFXZ1pJU0pO?=
 =?utf-8?B?WktSQjdWaDNyd3VjUUl5dERteFZmNnhXWm1UaFV6R2hHYWZ3ekljeG1FTXJ6?=
 =?utf-8?B?Tk5NSHE5aHBSSWdqdmFGUmtEa0dJSXY4S3I2Mm5jSk1TZy8wRW4xNnhCVUlM?=
 =?utf-8?B?dityYjRaaGFnYzBvM0lJVTBZa3NqelRBd2JkOUtUU2xvR1dQVUd3eHlCNjBL?=
 =?utf-8?B?K2VwSUZwZmM5dG5jeWlVOHRCUHRaQnNGaVJKYi9WalNNSFJwRGw5Q05udEYr?=
 =?utf-8?B?YmtGT0Exb1NWL0NwQnB3ZE5EL2R5M1hXSG1TUVllMUlTTGdSbHBxM1lkazh1?=
 =?utf-8?B?b3hXTFcwM0NWR2ZKa2dMYVZVaGRMN1lwZTJjcm5OQUJyVUozZ3NxMnhVYngz?=
 =?utf-8?B?dFNxcU9mWmw3YUVtYlBWdU93RHlHOHVXT05jUVlEMnFPekRqRjNNeXlJdzNi?=
 =?utf-8?B?YnNIUXJtNXg2aHZ1cml6a0JOZkxrTFNSZTJQbzFUQjltMlRoUnNFbU5ISGNW?=
 =?utf-8?B?VysySlc3bStHK1RmSm5acFdxSTROQzFrVWRzT0lyQ1ljY2tJTXB6a2hLS012?=
 =?utf-8?B?VTVpTmFTOGx2dno2WWpJTWJiTWo1dW55QzZJY3Rna3JYQ3BLTUlXdmRPN1NB?=
 =?utf-8?B?UlVTMDdGOFFtVXdLWTUyUDY1SzdDNGl6bHU5TS95YlRHQitkeS9RMXpVNEZr?=
 =?utf-8?B?RkRmVk9TdGpreXczVm5UR0ZIZnc3ejdrZHNLa053S3Z3cHpsR1Z4bStCNzFs?=
 =?utf-8?B?dlFVYk8vSlNVY2g4Ums5TFBMVEYxaGo1ZXFyV1I0NmtoZitEVmxoK3kzbVYr?=
 =?utf-8?B?bDNTMUdXSGR5dS9IbmRBeGpwQ0FEL1Jqb1U5OTRmenV4YlR0L1c2QUJYN2gv?=
 =?utf-8?B?c2dzbjBLekdDMVkwNjZpMEhuNzcyREhOMGZBVWM4ckJycVFYcDFpQ0dWVzht?=
 =?utf-8?B?Uk1TN3ROYWlwejVZT1duR3MzZGhMZWhUa0tQNjByclFEYWpPMk9WSGk4cWpN?=
 =?utf-8?B?K0RmaU9HTXVLVDRsdE9nTk1tSk9hUEc0WXZleCtiajRrOTBFOG42NG1zc0dm?=
 =?utf-8?B?U0VWdXFWTlBCZWNEWERGa1lZdTBROHhnMll4cC9lbzkzeHAvNmVlV3BiZ3Fk?=
 =?utf-8?B?enJpc1M3eFRMdnd2eVM4NTVLL1hHVVNwY3drN1ZqaGFZLy8vWGIyZ0VKR0JM?=
 =?utf-8?B?VlROZk0rRGU1NU1KQWZaVFl0TXh1K3BRUjhPZ0VuTVl3UDlsS2gxeDJTRmhj?=
 =?utf-8?B?Qm0zcElQQTRyTEQrc0RsejFlYjh1LzNReHlTdkk4U2VHeUhHck1aREcrbnVI?=
 =?utf-8?B?SWMzRVlibEU1TUJyajdaNnZ1bmZhcVBWTHh5RVRDcTU4ZGpNa0xUUTBhcnNL?=
 =?utf-8?B?WTlMSEpaWmpnT2g4YmhWUGdqQVptZE4ycHFiRTVCRFV2WVJobEptME93em9z?=
 =?utf-8?B?K2t5d0pjQ3kzNnhqUk5IalphTU9tcXJoR1hIdGo4K0ZHelFrdXYxQThNVUhL?=
 =?utf-8?B?L3FOQ2VkM2o2YWlNWXhLSGJKQzFpYzN2UE1FT3RtUzhwWnBHZEY0T0tZVWg4?=
 =?utf-8?B?K2NKL25EbWxYaERrODBEa3ZzQklhWk5kMGxXWmd4NWdCaHlOVmNKSll3MUdV?=
 =?utf-8?B?TkwyM1FoUFozWTYwUmRpTWloWmUyRWRWbnJuRFUzK0V4RnVnaUdzZ0NUMjkv?=
 =?utf-8?B?K0JxSWV5WG5abk1HNytuY2N0L1VoQ09hMTZ1MGpxK2I0RkhENTBpMWNCd0RE?=
 =?utf-8?B?WDVvZTFOYmwybG5MUUdiVnJvSWZOemE2cGZRamU4SUE5ZHcweXJPUE1kSVJX?=
 =?utf-8?Q?bI4B91Jiy9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlIvRHdWWlZERXR4eURWd0ZmVUxpZGhiTVFuOUZxVzVqMklDWVFycGFXVEJ0?=
 =?utf-8?B?WW9HWjh0Z1IwVjRsaWk2S2RXdFgxUHZiWXQ0R0ZTKzd3Mzg3cHB3YkxoWFRn?=
 =?utf-8?B?Z3YxRjF3VjJKcDlvTVJCdG5lc0t3Z3dVRCsrTnd4ZjdIZFZYLzNNMHFkL1I4?=
 =?utf-8?B?cWdjWDFFYUNMNTRoUkc3M3VuUlhVSHNCVy9ZbkZwS2hVc3BpdFhZcm1lVE5C?=
 =?utf-8?B?eGEvUTZuY1lCZ0I2Y0VTc0Zwcy96dnFXN25IeVkxd2k1WGxva25VRkZqekYr?=
 =?utf-8?B?YnVrME5mNWFGdnlRSG1wUVdUaXdIdnd1RkYrb0thSzFaRmNrakdtTVZnbUhw?=
 =?utf-8?B?MnRCcFc5QXB0QWFhbWY0aTVyamJJUG1NNDJablFGK2VQNVVpbDdNTWR5M3Mw?=
 =?utf-8?B?QTdSR2pYY1MybmNUYnByYkxDOCtGbHZyRi80dUpOcGxZS0ZQaWFWc1daS1FR?=
 =?utf-8?B?UHc1ZU1xSnpsbStBZHdUM200UDhsdGNDWko5dExzMjdZbzVLRjY4dUNmWUE1?=
 =?utf-8?B?NXM2MEZ0RVlWeEJJT1kydWswbEpFTmQ5UTk1YVB3M0tEMEVaTGF0SzBhRWgr?=
 =?utf-8?B?UzlJRklMZE9VRVl6R3pyTDNpNDNWMnBmcVpxYmRCcktrU245a2htSXNXSVlu?=
 =?utf-8?B?WXhFeWZGWlU5OTUxWjhoQ2tybldOY293NTYwRStya0FncjFsREltbG51eDk4?=
 =?utf-8?B?YWhFZ3NDMzVjd0ZCeUpvWnozTnpncXIyL2MzWWFEeVNncDN1RG5ySlZsY1Bw?=
 =?utf-8?B?NzJncHdVUW14cGVxU2h3QlVCV3Qyd0QwNDMycGxKSG5oTXVkQjR1Z2JDbXNv?=
 =?utf-8?B?dkl4eVFoTlk1MlpidHZDSzVKWTQ1VnpDNW9ib3k1U2NTYXhMQnIvaU1TQ29r?=
 =?utf-8?B?aWJBblNITjljK1VFRmRKN25Oby9iMXBJSzAyaDVsU3hWZmsyYkt0cTVmNm9k?=
 =?utf-8?B?YXVQdXVzZmNsUno2UG9XdXJTaWVySGhKUHlFVWtrcDRrOE1LTGM5aFNPb2FQ?=
 =?utf-8?B?UmRFakt0N290RTdMQ1U1U1ovaWxUN3lFNXg2UzBTck43ME1yekxjamtod3hr?=
 =?utf-8?B?MjhHZlUvb3N1cnFKenRrcUg5T0lzV3lBNXJSbmdYSFI2L0FGMXZESzlhaDJ6?=
 =?utf-8?B?YU5wc2phWUtkVGZJU0VSd1F0UjUvZi9sSmFTb25sOENUdUY4ZThzSHJiNEtW?=
 =?utf-8?B?bGFFazRXV0l5U2E2elh6ZnNVK2tNekQ0aEZJSUhtRVM3SHR3NG9YZ3dUNXF0?=
 =?utf-8?B?NEdMdlp4Y1NWR0g2dHROc3k0ZDMyYldzdUI1OGl1ZzBtNmtvblBoc2U4WkFp?=
 =?utf-8?B?d1BZSTE0WVl5SEc4YjJITzM0OVpSOVhJV2hwZXlBNDVIWjVMZld1Rmp6cUYw?=
 =?utf-8?B?TkFUYXp5ZjlrK0VSWE9NMGdaU0tsRXBpNlgrRklxWmg3ME92TUpGR0N4SmZt?=
 =?utf-8?B?UlFsZjVZeGpseGRNaXpPT2wwSFZRUkNhSFNuaW50bDh5QUY3QVNlMy91RFdE?=
 =?utf-8?B?dWJJU3VxdUoxVFEvVG8wbmo5US9XY1VmY0s1SzlmSnR2SXBXZ0oraDYwZ2lW?=
 =?utf-8?B?RDg1VVY3RXNwclVsTXVWU3RqeDRUdGVwNFBEblVjNGU0TFdIcGV2dXpEcUd2?=
 =?utf-8?B?QzVyaTR6b0Z1ZFdSVEhvN2NnVzRGalBCNENKaFl2aXdEb05QWVdMZkdJalFv?=
 =?utf-8?B?SEhvRjFzM1pmR1JhU3A1bzdNVWhMYnFFR1ZaNGQzNm5WMkg0NzA5MWxhWWNV?=
 =?utf-8?B?UktqYTlCTHg4NkRmdDlPY2pjUjZtcDFWY21MNFc4TWNxZytTUWxJY2FPd0F0?=
 =?utf-8?B?TXQweXdRb29WV25qMGJoeWtBZFQwWWFSYlpScWh1VFZDTTIxLzhvc3NjUDB6?=
 =?utf-8?B?d0hOZ0FjWkY1ZVdwaHV0ellIYXJXSHNOcDdnYXpYbFMzcXUyT3EraXB1NzJR?=
 =?utf-8?B?aSt1dWhZRnVieFhHNmYwbW91TVRZM1RiMHBMQXhmVkFFdjVUS2ErbWgzbzFx?=
 =?utf-8?B?UnhDSXdXU3F3UU9ueFpROHVGbzM1UEc3d3l0c0t0NERQTDJQand5cWJTekRO?=
 =?utf-8?B?UUV3Ky9FK3M3a0U1bzR3TW5JMjRidkRoZU1Ibjl4bHYzaUROSExxRGYvY25j?=
 =?utf-8?B?YUo1YlRsZ0dMWjFBYjVJUXdNTXhPN3gzcUk1dGE5TUpieFNTRTdFb09XVmtY?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qNSe5JaEoZINXdzUai3hyclCcETBDyt9qSPvOZ3q7KchS3cQtKlXQOJ6FkxpNQY/bztJVtpexE8ZZZ5m1tD9NjYDGxqH7nMN4HdvpuECei7PgSgUGWItx0vMuAiaWm22lWhCe2dT3C/RVNrey1+wYJxBOrl7TTKblE0O35+ZOffkxvVATrdwkENEHMW5TkvG7/Pt/TSO8GmFttJWWRfU9ro0tH2ukUgumT2NmdOJH+CJiLYIkQTL0QP+Hn6QrqbhH9inPYXTe1AyKOOwUiBVdDNTRBm91vdVQB1C/cuK2YL1hL4FDkM8pCX7IvNBMbUCxfIhlOqUxaXx/snRopM7t5EL3IrJrlRTZJS6KDEZwMkWukS9s1O5SHSuOUL27M/08Fe90TQvOG7KNtWHK9k6q8fAJfylkGAdGFIGfX5ZLR3vIJNm0cUGqGNjnQRkQ3Fnp1qIpWaGB8c37LcA1MRR9vD9h03sR2OBkwY1G+VVAuK6GggMOrN25Ci/nvo8IRB/YCVXZDIH2C5jWNVe+X4tkpjXJ5zM4LytZxgzUgTrjTnoQY2F/tqJs8n948lnLQeKtEZNkZqRLK3LlJNL0BGJy/zy7NAOxgOxZvjzTrqynZM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02015562-ce24-4029-ef74-08dd8738fa39
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 16:14:54.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8q/pyOoo3JwN0sIbAS/tlUf6dwn7GyUAksFyUhdCSjGXs51UYAHjXYQitmql9J0jU6QgidKOomdp5qoWTTzHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504290121
X-Proofpoint-ORIG-GUID: z6CZ6MvoZbtZrseGK7uGzYGou5NU-tTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEyMSBTYWx0ZWRfX4s3+gwcLprzV s8iaOjybZAFhzsQcT1qSXV713B/kVaIxbzgcaz0ayOfLrW0i0+WBgqJHHIeYXivgcDVhHz4kNoN U2vrMSnCZE/7ydeLsygphJMhxqCyWFhbwD0u7SPXnhhrTaNLcL+hzoAS3dq1kooPX0L7RguL0OX
 GnGqOgHPLh3gVkh1ACKdSwbD3GmDv6rgAU2EkVhTu8x2o6nCEz9EaVUbnMT3VAgbRfd/rzuW9r4 xdQl3nmDM7tGBK7i9IFdGApTVaoKEbBGO6lwytFONHlQUYda1rdSDCd7FeWZic2oqGfks+GjXvQ vHYD4CF49FO1lSG2tdjcZMwprvynh93/1hRF97zvW0W6Oi6FzIh0ifq+p6FP3LD/Ap7ZrMITNq6 zN3LZ8/t
X-Proofpoint-GUID: z6CZ6MvoZbtZrseGK7uGzYGou5NU-tTc
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=6810fb02 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SEtKQCMJAAAA:8 a=7nibtkjXuEHxwLubei8A:9 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22

On 4/27/25 7:01 PM, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The Linux client assumes that all filehandles are non-volatile for
> renames within the same directory (otherwise sillyrename cannot work).
> However, the existence of the Linux 'subtree_check' export option has
> meant that nfs_rename() has always assumed it needs to flush writes
> before attempting to rename.
> 
> Since NFSv4 does allow the client to query whether or not the server
> exhibits this behaviour, and since knfsd does actually set the
> appropriate flag when 'subtree_check' is enabled on an export, it
> should be OK to optimise away the write flushing behaviour in the cases
> where it is clearly not needed.

No objection to the high level goal, seems like a sensible change.

So NFSv3 still has the flushing requirement, but NFSv4 can disable that
requirement as long as the server in question asserts FH4_VOLATILE_ANY
and FH4_VOL_RENAME, correct?

I'm wondering how confident we are that other server implementations
behave reasonably. Yes, they are broken if they don't behave, but there
is still risk of introducing a regression.


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/client.c           |  2 ++
>  fs/nfs/dir.c              | 15 ++++++++++++++-
>  include/linux/nfs_fs_sb.h |  6 ++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 2115c1189c2d..6d63b958c4bb 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -1105,6 +1105,8 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
>  		if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
>  			server->namelen = NFS2_MAXNAMLEN;
>  	}
> +	/* Linux 'subtree_check' borkenness mandates this setting */

Assuming you are going to respin this patch to deal with the build bot
warnings, can you make this comment more useful? "borkenness" sounds
like you are dealing with a server bug here, but that's not really
the case. subtree_check is working as designed: it requires the extra
flushing. The no_subtree_check case does not, IIUC.

It would be better to explain this need strictly in terms of file handle
volatility, no?


> +	server->fh_expire_type = NFS_FH_VOL_RENAME;
>  
>  	if (!(fattr->valid & NFS_ATTR_FATTR)) {
>  		error = ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index bd23fc736b39..d0e0b435a843 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2676,6 +2676,18 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
>  	unblock_revalidate(new_dentry);
>  }
>  
> +static bool nfs_rename_is_unsafe_cross_dir(struct dentry *old_dentry,
> +					   struct dentry *new_dentry)
> +{
> +	struct nfs_server *server = NFS_SB(old_dentry->d_sb);
> +
> +	if (old_dentry->d_parent != new_dentry->d_parent)
> +		return false;
> +	if (server->fh_expire_type & NFS_FH_RENAME_UNSAFE)
> +		return !(server->fh_expire_type & NFS_FH_NOEXPIRE_WITH_OPEN);
> +	return true;
> +}
> +
>  /*
>   * RENAME
>   * FIXME: Some nfsds, like the Linux user space nfsd, may generate a
> @@ -2763,7 +2775,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  
>  	}
>  
> -	if (S_ISREG(old_inode->i_mode))
> +	if (S_ISREG(old_inode->i_mode) &&
> +	    nfs_rename_is_unsafe_cross_dir(old_dentry, new_dentry))
>  		nfs_sync_inode(old_inode);
>  	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
>  				must_unblock ? nfs_unblock_rename : NULL);
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 71319637a84e..6732c7e04d19 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -236,6 +236,12 @@ struct nfs_server {
>  	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
>  						   that are supported on this
>  						   filesystem */
> +	/* The following #defines numerically match the NFSv4 equivalents */
> +#define NFS_FH_NOEXPIRE_WITH_OPEN (0x1)
> +#define NFS_FH_VOLATILE_ANY (0x2)
> +#define NFS_FH_VOL_MIGRATION (0x4)
> +#define NFS_FH_VOL_RENAME (0x8)
> +#define NFS_FH_RENAME_UNSAFE (NFS_FH_VOLATILE_ANY | NFS_FH_VOL_RENAME)
>  	u32			fh_expire_type;	/* V4 bitmask representing file
>  						   handle volatility type for
>  						   this filesystem */


-- 
Chuck Lever

