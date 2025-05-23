Return-Path: <linux-nfs+bounces-11885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB70AC29E2
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 20:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F121C070B7
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD48295DB9;
	Fri, 23 May 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ATAUZahu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xK2DhDcS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474A47F4A
	for <linux-nfs@vger.kernel.org>; Fri, 23 May 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025645; cv=fail; b=NNla20o/zk91fjkxpGP6W8TvrNwUE291XmzGFeTevIACgYGaiuX4ALUJZpyCFGrlAk7lgLzydTq8C2x55R7jiKLdXuWRe+/S30glE0IRp9LCzMqfQA9YzSadp8aPNpHKiaFJ1P8N1wSkc5AGASgBC/8q4ERphVtNSMowbMwH2yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025645; c=relaxed/simple;
	bh=miwQaI26wP/AjUhKRDSnDMbeBJvFIYTeae7iLgBQR2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ly4Iu5ubbi5SdXc/Z0uNfpdhE628NzINhMRP5vz1At/3WUgrP+zRek5xuifDngLj1wuhXRW3RF5lFnUfWcaQFRFZOqziiUY2/zHXFts6SrgA6gJduGAV2GV6KXXTm8aNipoIZsEl2Fp34EQkHLojhqQDnyjDOT0FRo/omONL8r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ATAUZahu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xK2DhDcS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NI3nA5011889;
	Fri, 23 May 2025 18:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MPx2AxWf4Zhk3BrZJ2hiG0ALlESHVmSbkfA+MNpih6A=; b=
	ATAUZahu4sZ47u39PP693Bx9yKzqqLSO5rXMWt0uX1HDtEchGANTo3GzJUdE6sdy
	1DU0ODtORwwRYDGH4qHPWsMkMuSvd6seyDJYz8Nq2f/qj5pyEs3mErAZCUs+7EJP
	1NZjC8m/8yUG3jeZOIwFlEB95q5dz7P73W4M9rXZPSvZLpMbhY++M9NK6m9yFF/b
	NQQ4nE8/LQlI9o/9XYr6eFJrkZ0HJVy78JyPsfP7jPSM0b0OOGVxXUMSCTlkQWzz
	qCQQPF2gCtmxBgkBw+AhJuKlFkM25u8e7o9sNXyB/jmD+CWZq884UqwYfH0TnNLT
	OVUSEbl8YWbxoWDm4vCpdw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46twy701xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 18:40:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54NIB5AI032203;
	Fri, 23 May 2025 18:40:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rweqbvcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 18:40:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpreD8KbMHLuXvXSI+LDI+AS/rNyfs+bZO8MKGCX44sqsJHqwA5qVC6U4u7Vw4mWFijVPG9SsrAq464oRVsIJb61MMwfLcUH42hGoo6WTOlKeuDT01bunZhoEcBxYU2EygrxpRd+h1jcUqBDPg6AIwksbX1ArVARIjYupSL2W3ZlAODAHJWQEeFOGMWzxVV2rJO087QPHakkvX2DbA9owHKOUX4e2FU4ZyBSr/VvmA3WYBElz63QBwmmSxe6nbYZ9knb3eUB3cGneyHw7gWhRfigzGtGMiak6DJ9JOXg5atj7cDG0XwtHLFpSPAPYqyWfeZjXdnz6fOB38Yy5a68hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPx2AxWf4Zhk3BrZJ2hiG0ALlESHVmSbkfA+MNpih6A=;
 b=fXfkjXlnHUiiXM3toxarnAPhXiuBtkpyQHYD1OvgCO/6c4exHDp2imhdwEfFvqD6tnwrrOqphvF1/QxGuQ0GMWJdG3P73DarkIN7j4zqqD9cTDoGHcpRJtGW0Ad9+zPZzIir2Is4qMV+l6kaeLtqCnt+KM95cqGjqeVsaHIeOstq7t8xq0vnLvqRREtGLvKJbcxAk2Y6NGy3/notJRr0V8zIL2mIcWNc+LKF85M0piBDGcJTgjzuYTLs8YdLZzM1G0qV8qCqLVQCaqkX8CLO+L/aVSP+U19h2+42G7IuX7Y10IT6WZOQWvDFzIl02nzARXZzJbMludf6OHBgufPiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPx2AxWf4Zhk3BrZJ2hiG0ALlESHVmSbkfA+MNpih6A=;
 b=xK2DhDcSh+XkZQYFSIEQGZ3jIuq1wI4WMwOXEHsXhIUI4dd8vnOQrgL1o9JvxJANg7jBdv8l0Ir9yiD98NX9Twr7+C9P/euur3xn8dW+vrliS3iZLXAx3/gFSi5m0L8VWcaHrMJ5pQ9JWlIJXl8crdmAsISR8AYgJlDXzDehgoQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4674.namprd10.prod.outlook.com (2603:10b6:303:9c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 23 May
 2025 18:40:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.031; Fri, 23 May 2025
 18:40:27 +0000
Message-ID: <f027319a-378d-4b91-a418-c45218fb7a21@oracle.com>
Date: Fri, 23 May 2025 14:40:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: unable to run NFSD in container if "options sunrpc
 pool_mode=pernode"
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>
References: <aDC-ftnzhJAlwqwh@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aDC-ftnzhJAlwqwh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: bca8e3bd-4718-4378-ad72-08dd9a29492d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UXNHRWVSNGwyK1VDTGNNMm00YmNMOVByUVEyU0plYXA5TXdITzBoVEUvY2M0?=
 =?utf-8?B?c0s1MGNNYXpsc0djb00zNmZZV1FxUmh3ZDUwTGVJWFEraEE3V1d4d3lrMzRp?=
 =?utf-8?B?TTArUEtLSUNGUCtWS2UzWmpiTGlxeG5MZFRCWlhFeWdYMWRObWJ1dmlKZEI0?=
 =?utf-8?B?dEZ1ZnIyZlFtc2FyMWpsalZCK1BPM3FwOEFzY21UVXdyZmpnNGJaTEZSS2xD?=
 =?utf-8?B?bW1LdGdWZ2paQ0x2Nk1tVGcvOWxRUmQ5a2RtQ2cwTTY2dVd6SlRRUWhJckJ2?=
 =?utf-8?B?ZWUySWo5Z01tckdCRFlVMUdLbjdtaVJVZjBLb0JwUlpsR3RNSi9LNXM4Rk9l?=
 =?utf-8?B?WGQycVVBeFk0a2oxeFJ2eXkzYkxWaFhxazh4b21nQzNXeHBPZ21Ocnk2SVlj?=
 =?utf-8?B?S3RaR0JLM3Q1SVRPNXBxOG1UaE0rUVI4Z3U5Z1VFbUJtR2NSZGNMOGg1NnNE?=
 =?utf-8?B?TklqVXV1VkhvZFpiN0NnMUdIcnpUeDgzNUE3VUROWnpQQ3F5Ykc0UlpmYmMz?=
 =?utf-8?B?U0tkUjhWM3RPOHNXRUM5MDhsRm0xcHFKR2huYjNjYUdEU3REVGxGQmZhQUtw?=
 =?utf-8?B?MWY4U0tjYTB6MHpldnFqNHQ1SmZjOVBCSi9rRG1DbC9qVGQ4QmNtWmc3aVVk?=
 =?utf-8?B?aGYvRUN1U1d6bHpidVhESHhrczNxUTQ2Q1JOK3R6ekJlb0hkYlNqeDFPMHlM?=
 =?utf-8?B?d2JqMmJtMGlLRjcwUEMrTnhaZ0NsdE1mK1JKUGF1RnBHSUVIUEdqVFJ0OTky?=
 =?utf-8?B?bTZzZit2UVFpL3Y3aDRLRGNRckxHQVROZHJob3VSaGpqRnlYOVoyL2pIQnJD?=
 =?utf-8?B?cndEMGJCYU9nR3FuWGdJTHBPVnlERU5kK2I0cFo5REJSQkZpYXQzTEIvMXQ4?=
 =?utf-8?B?Q051cUlGV0U5eVFTWTBXei9wWGd4M0NkSjBpTmNUbnVtbkdBZG5rRWIyR3R4?=
 =?utf-8?B?T3V6Z01JQklPbTdxSWlQRkU3VUZwU1hNYWNvWm5TWUFEU3VCN1FTMWJ3U3Ar?=
 =?utf-8?B?ZFdEdnV2WCtEZE5CNE16VnhkaXJqbThWSlpPSVJteElWUTAxb3BNbWQrVmEx?=
 =?utf-8?B?cVRTS2dnTnlSaThxdnhhZmhRRHBUdC9oVm5NdkZENEM1VjJPSnVJTmcvRFhK?=
 =?utf-8?B?TkNoWUN1Y0VjdnV0NGZubkhTMHdjYTJZV1RrK0hLRVRFcnRhWXZBSmczMWhs?=
 =?utf-8?B?VCtUaXIyaUlCMS9wcGU5L2VhbFBjd3lkMitpS1k0OWxmR1RpQ000NVNNaVpi?=
 =?utf-8?B?bjltd0NkQnFWN2dSYXQrM0ZnNGw0Y0x1Z1BpOURkMyt1dlE2bW1IaWtzYUlB?=
 =?utf-8?B?eXFzRXA4RVdaVERpeVF6b1UrbFBhUUpJeDdER256NjRzOEJyN2dvM0pvVCtB?=
 =?utf-8?B?TW9OeDcrRWhLanhibm1sazZNVWV2TEIrNEppVWdWeTJwdGx6T3B4VUJMV2pC?=
 =?utf-8?B?QkZhSEVJbVFkcjFEYzk4QmJrNENSeVNBbTI0bk13dVBRRStSb2R4b3ZXYTNo?=
 =?utf-8?B?SVk2KzhFb25KU2ZBN2FQMWNoY3pSSFJDd2tUSXlkYVdHTWEya1RpVUt3TDVN?=
 =?utf-8?B?TE44MWpjWkxaa1djZmRJYWdOb1habDVEMUxjTXhDY2xJN01yWGFoTitSL3F6?=
 =?utf-8?B?emwwRWlkZTlQRzFBbVRya3Jyci83Q3F5eFYzODN1aHp4VnlGMVY1aXBRUCtz?=
 =?utf-8?B?aHByOXpzbHBXNC9pV2l4UEJvTVovbnprRWR2YnBldmZnYjM0QjFYNTJzSUF2?=
 =?utf-8?B?ZE56L3R4ckk3R3pDZ2Z3Qy9YNGRicFpTemZIL3c0VUpXdVBNZEY5aS9wOG84?=
 =?utf-8?B?SFJmRWo0SUNQVEJUUzVXODlNS2RUWFdoMkl2N2o3VkRnYTA2K1dwZC80dk5Q?=
 =?utf-8?Q?qgsCQt+N3dLyK?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L1hVU3ZVZ1RXK25UL1R3eVV0M0ZGc0VDVzlJZWV6L3RBVHJTQ1M3bENLSEdM?=
 =?utf-8?B?OVJJUTlTSFN4ZmZjSXJzVzVGWloyNzNDUTgvR1U2VklpRXJ6bzRBVkI5Rmhm?=
 =?utf-8?B?Um5WUUxueVBvQzNSVlBKZGJYcXQ3WEZBaFBXU0ZkSndRY0hidWUwQ0ppaFNa?=
 =?utf-8?B?VVhQK1BJd04wWXQwRVIyem5XNDdMTFdqWk9QTHBOZ0xKaTFqSy90endETnE5?=
 =?utf-8?B?aFhPRFdQSU5RSTVQNndvY1ZnRkJLcG50ZGFPQVZWQS9NQUgxN281bU44eTlx?=
 =?utf-8?B?WENMbldmdGRjbDhoYnBXR2tHeWZSa0NMWTVZL3BzUEh1d2V2OUl2cTN3SzZq?=
 =?utf-8?B?dmFTdnFkNTRoTDZodndMd2x0ZGZGM2lZeWZFUE9WdExjcStGWGh0Tm9LYzRn?=
 =?utf-8?B?SjVBb0ZKM1hJR2FBV2hDVFB4eUVjMlgwUmliWTVGOVQ5OW9NdzgzYS9wTVdx?=
 =?utf-8?B?elQ1RDREVGpjYlFVMlhpelhnMEVLcDZvcDlzeEFUSm1jbThtd0E0amNneFdN?=
 =?utf-8?B?Y3JXOWF1RVdFYVJKN3FKOGU0UzNkRTFaeWk1SE0xeHliT3F2T3Vvd052RTdq?=
 =?utf-8?B?aCtqQ2QxR1FRZ1F3cjVLcVk5TjdXYVV6TXh0WXZBKzExK2JzUFg0V2pqVlNs?=
 =?utf-8?B?ZmE2T2JZM2hPcnNIRnZYamdqRHlXemhSaHVlVzlSUVpWQm01YUtHaVF5dHJG?=
 =?utf-8?B?cnlWSW5CK0dCUnFsNHBoQXNwTHEwYjdZcVkyK1BVdG1TdzZRdnlxdzA0K0Y4?=
 =?utf-8?B?RVU3Sm85cHdtRDNMUU9YL1hXTlFVeHprTlA3YXZ3WGhVS0lGMlNtRzIyUVpj?=
 =?utf-8?B?dlhDZU9GSmV2NzZJNmNydVJwUFZqN0d3TXNFL09uQWhzQVlHS01NRjZ0L3RI?=
 =?utf-8?B?VWdkYVdiSFQrSkJ1d2RBVXlrOFRuMmJzaUtlYU11bUJQa2hFdXBvTXljMEVr?=
 =?utf-8?B?Z25pOWdyVnMxQ0NlTjZsdGxNcVZjdUdETFEzTWNic0RPdzFjSWVpQ3c0Qk53?=
 =?utf-8?B?YXZEbUwzcTVhdVI1TmxBS1QwMUhEM2JPb21QSUJTaEdWQ3NZMjRvdkFpeEpX?=
 =?utf-8?B?bEVWWEhNOTRVR2RUQVZrVjFMbjZEZ2hwTXRROHZ3UUQwcDRPK2RxVEd6aW53?=
 =?utf-8?B?aU1iclNEODhxOU5sQWN0K0dGNkVIbFA4TW9xQWQreS8yVXZjVkRYWXFaQXB1?=
 =?utf-8?B?NHpWdWlGRkJIaUtPT3hqMWgxZWtOQjcveEQybkNRQ0NLWGNNd0VUQm9jTERt?=
 =?utf-8?B?QUU3VE9JZGxwbXhkdnJpT0UrYUVQTFVxWS9Rd3JwS2o4cHhWRUs5TTFLcUdP?=
 =?utf-8?B?L3dVVmxTcERjVSs0dnlLOEIxZHd4cENDZ1YxQnZRVEtUSWF2VnNKa2FHMlhh?=
 =?utf-8?B?b0lkbUU4NUw1TXdhdGNENlpobkhLTk01SkM5SVJyak84ZitRdEZaSXl3V3Fp?=
 =?utf-8?B?cCtzYmJtN3Y1bVJ1aWRkUHU4YnNkUnY4SlRyZkdhdCtYcDc3dExvQWM5T2I2?=
 =?utf-8?B?S1VieEMzVVA3SHZEVGFEK05wZ0U5M1JkbHVFdmM0Tk4xekZLZlNVV3dVdmlm?=
 =?utf-8?B?QThLeHlMMkxNajdoVU5xdHBxblhVOUhtUjV0YmRaLzBZTm9UN2huOFlTOWpT?=
 =?utf-8?B?N013YnVreFEyNUlubTJhVHRwQU90WFdhekxoQVdOVXcyT0VjaHpFN1dnc1A3?=
 =?utf-8?B?Y2U3TjdOek5VZklYU3k0TWJoY3lXVW5raTluZWViR1RGNkd0NGxMUmRRMjQx?=
 =?utf-8?B?N3Rvb0xrRnhNdVp3MVBjSDBMbUdqSDNOMHpJYm9TTXN3L2hHalk3WXNsNkp6?=
 =?utf-8?B?M0l1cmVSRmJ0bktCclg3UUlhTDllSHFkTzFYK0owTHlPRTM0SS9KOFRoTFkv?=
 =?utf-8?B?V2JDVnlIMGh4T2Z2czRPVkZKL2hZMllGK0kwR25Ob3NGODRoZmZNSEtWQTZo?=
 =?utf-8?B?QjA5ejJZeG9RbVdYVUZ3Tm52QVh3K2tRTTZKVXp4WFBMa29oYjAzYjh1QVAy?=
 =?utf-8?B?KzF2bVAvQ3NaVnIwNlRDb1FlU2pnQ0ZPNTZiYXl0bFZEa2tDazBOajZxTTky?=
 =?utf-8?B?bEtOOW1yeUc1bWM4TnI4L0xhV3JaVXlJeFVuYml5Mk9nL21NbElRVkhPSzZL?=
 =?utf-8?Q?gHhsxXlRIWeAS0OEzS+AuWqWi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F0/3dFakKorKIQNczGOxWxoF+kxvmlUK3bCEztC5GhxnlIiEuv8IWbnRJSjj3F/dTRGa9xEEFZoDE2I1yh0PbiVE8chZOWC6yTxELqnKgCwH6tFZ9wbKKpAbXJgIfIPHjJlmPWNKdMUH7ktyVVea07LCEZiTP4wAlHD8Y7u/pvtOgvVLzE62tB+wSxnXtPkoLkxGBHHns/7jJjGeGPY2VsST/sHufqfKJRyw+tbjMuxzYzfWRz8ImAcVK4oY0hGZ1DLGHrXG14SGILZ45Vw1ZGaxxzRoZVNewC2pfVju4jLRgUDjAeC8w/oQYcupU5FXKSl5kU90qnLXxxtJnuYBgDBC8d+wFHjREyWiFZEXV/pPN5oALqNde24iJfWduZs1zPJOQ5Y7BW6DPP+olvl743wmfmAY4uKeMIoJuYXE7SKK0UsLNO5YSoEFkTJXU3MDqBi5FlDz1IDHxR9gmV3fKyqdCksnY2BeuyI3WSqqfL92gQRe0OShbxwrE+kEl4b1EVpHZrTwwbjvujk84uEs/OIV+KCSjBV8HTbrSFpI5eAy3CCeMaY+1gwR1IqSDHLhwOvqF/2azm2tyyLtpPA3GnsWkT5UlHkgCkxQDUx0XUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca8e3bd-4718-4378-ad72-08dd9a29492d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 18:40:27.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw9Esyk14lGNQs5WdU6EZjXYWcknvPCpT+GudEu+4x5rws8OhulaSYNpLyCsSp8OblZKwD34Qv002CywC9gmJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230170
X-Proofpoint-GUID: CZmEOiobitcmyBHtxLDCgYFTQdpVQEj5
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=6830c11f cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SEtKQCMJAAAA:8 a=SsdyLD-8MZX55f-_N3EA:9 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22
X-Proofpoint-ORIG-GUID: CZmEOiobitcmyBHtxLDCgYFTQdpVQEj5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE3MCBTYWx0ZWRfX2SzRwZ6I057h G3/cQ/eb33hs5T6z/MGyEtP1HsT7u62rTDGRSAnOlp0JrcdXG58xCPLOrcWxPFX1e4VSliisaMR t33j7Lm5b5wAOrIG7xW4wgeS0Z9VcF1Z006p+qFIw6ri+hJ4D5J+a1c4atQq4GQekmnUVr/xWpY
 rlZiPK1KgD7SmU3pKoeKnF2rmTkZxJzkB9rTXsLssvs/9XpOwSmnlzHGLhDSdFSIGywNPUy1Hzj BvaPP6+34630M0q9zJGk+R+30XladanCOJ46ufkz9v/znRytEyHlXxNHjQtCblG6k6XdToNZjC2 fSkqEhoh7RdXF+x2f3ONAW8ccVkLg3Ge6YOAibCXsCa6rm5aQOCMDwYlYznx3wekd7kCJZ+qhK3
 aHTxR9XTx1TCfWZ8ULhHowUQEFRrkyYHfiWrx5A17+3FLjuhoz77lHne1zU69ihFfwLk77ho

On 5/23/25 2:29 PM, Mike Snitzer wrote:
> ps. yet another reason why pool_mode=pernode should be the default if
> more than 1 NUMA node ;)

Easier said than done. During bake-a-thon, I mentioned there are some
historical discussions about this. Two I found:

https://lore.kernel.org/linux-nfs/313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com/

And the review comments on this patch:

https://lore.kernel.org/linux-nfs/20240715074657.18174-14-neilb@suse.de/


-- 
Chuck Lever

