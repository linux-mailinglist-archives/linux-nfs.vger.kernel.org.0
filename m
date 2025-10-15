Return-Path: <linux-nfs+bounces-15270-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4FFBDF862
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 18:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB133A87B7
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Oct 2025 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87EA2BDC2B;
	Wed, 15 Oct 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pxXQyn02";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k+blIMci"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B362BDC13
	for <linux-nfs@vger.kernel.org>; Wed, 15 Oct 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544165; cv=fail; b=X8Aq6hhZfcxUdu6Gs6/zTVHVLTzlyQ2kl8g6BZNYVtdoD9XvpX3b/3O5AD+EQkQ+bzo0uSKfSfUgHuvJVmUdTv0KN0KLflb5C2Ufjz4G/cHSWR8Q+ecxMHQ42YqcxNESmPbnRdSV6w4TDhC6jVEOKK0viaB/1okLmPGc9zelr1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544165; c=relaxed/simple;
	bh=7xp+4/66N4+zdfEdcpsCvr4sHbCH6UWJ6SeYbbBdx/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FZmpUd8kxn2+jU+Hki+5LCI/4TZ+W1605rjxQfgnNus+YJ9C+7oO7AzTZDeycmh429Btt66QRibj2DmBACLNut8r9c5nLjBA7YK+YxmIAixZpkh7q2vHlZSV3+eYfMWz0VQVDAFVCTEvcAY0NzDKgJpY7CDdaDHI73sOPlSz/8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pxXQyn02; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k+blIMci; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FFuFgw002535;
	Wed, 15 Oct 2025 16:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SWv178njNQFgwHljQYdJYhbt8ycJc22rerG9DE7MhAE=; b=
	pxXQyn02CG/zocnGaVzVllXHZu7m05W63oM/FbycdI73fqXYfUq0Nqbeyaman4rU
	Id6WVA2tCwpVQYZg9UFt30WIuOCQoPOLXCyszbwzIYk+/gJfXNCSp3ghamDGWMf1
	Bq3Kxbsq69inWN5kWPGOG3xf9uIiCe3SYO4P8tqVc5ons6eJyQnRGHOdXXxnkx/Z
	sdH1DyZ9fn5dNVs0E4aABOXTVcIJdhhNP1ooPSQGpyVLSqjMua+AJvTwXaBZNWy+
	tJyBGjFytLerPm2HwcWI8XxcjS2AHQU6N8EgPARrJOfJRCkKeSubcRD6XurghEI2
	rDgzCKEVicRJhWjO2CUTfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47pwaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 16:02:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59FFmi4v037793;
	Wed, 15 Oct 2025 16:02:33 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpahbrc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 16:02:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVEp7aJoAddrYlOTd3ZZfj3lmkKAzkRkgM6/deu6p1TBc1CKBV0Uazl9NkYW9U44JdfgwFVT+9bOypqKLV9wiSngLL3WafYVZCbp5To4YiJxyh2COtfb8+U+VrllO+6WC5HvbptjAkNJeYghObvhIsyxLnWZkAn7tggCR1/8ac/XWoDuzUsPUsmr8DzvYhEW6OuVlBuKQMPVqHCWfXJ2u272EFi1wWj63h6asaIb1zv4K30+vP4QLEUq1g0DyNiQq1klWsop6H0SwnzE4+lw9r9rHJ231Xejq1hcMnLaMAV+D4bO9ZjCsm1PPHF6Pe6GrDRWq6V74Ug/m2U5m60A/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWv178njNQFgwHljQYdJYhbt8ycJc22rerG9DE7MhAE=;
 b=WjnWYFREV7Dx5nwUxAX1PHRGD47O7cx5uiTE6a2NAvqbm+QmDtWtU0VOxkTjJLR4WMkwkOViGlipRp2+lGcLkLfZ9d7D/ypGE6UqaGiz3IiQX3au0wdSRxyhLqXjHXXXQyfLw9fH4edZrChEKuirUs8uLliQhgrrnTai3WRUs/89Xi9obZvKQgD7DiH95+oFFhHROiCKXluKQe1qnmWiSQjNioZa+i0lFtw1Y63x5Y4KDRCQYSY6TVfo6fbfUcXVzJ4KgYppBVwy+Oih+SWkW+vvneQoL9G1XeI8T3C5VYea/Ipc1tvDj+tbSwapDGIpY6CL3HNXWy5irmvIHHKfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWv178njNQFgwHljQYdJYhbt8ycJc22rerG9DE7MhAE=;
 b=k+blIMciGc4rZGsQrxW+5Z4rypghAmR0k+vi9Td3bYLdpD01qj9sKFL2sHMElbSFOfxUZ2/ayrrXoLO3BLk2NCA32y8WMcwK0UqFvMuJhiU9MOjUVStp1tar15ZuBwXOX8RUvZ9STZsAFOP9Bhtbg6W/kcubJVZJ++eg1dAwEyk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4262.namprd10.prod.outlook.com (2603:10b6:610:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 16:02:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 16:02:30 +0000
Message-ID: <a2ecf4da-8b28-4902-906e-773346e8c283@oracle.com>
Date: Wed, 15 Oct 2025 12:02:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nfsd: ensure SEQUENCE replay sends a valid reply.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251014233659.1980566-1-neilb@ownmail.net>
 <20251014233659.1980566-2-neilb@ownmail.net>
 <176052583604.1793333.11667202487074445027@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176052583604.1793333.11667202487074445027@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:610:33::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 60790aec-2b3e-497a-2e18-08de0c043e4c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?THlHQzBsUUExM1pDNm8yY2YxLzROOW5wTlNCdk5Zeis3YnVLYzVuWWRTUDd6?=
 =?utf-8?B?d1hYY1NJak9WZml5RHZKQjU1dVA3TGcreHA5azhsdFdVTzJoK0FkVzBnc2kr?=
 =?utf-8?B?anEzeitJRjA2M1k2RnFQZUFHb0x4cERKZUtBcUNpeTR1QUJCVGRadzNxUTNT?=
 =?utf-8?B?TWcvdGtzY1F3NGNpMzJtNVNWR1hOK280cnMxVGRqN1hucy93YXRKNmJ0VXpQ?=
 =?utf-8?B?Q01idjJWQ1orWTUvcVNXaU1kV2I4clRNSkJhUEswUy94UzZkT3ZQUGpYeFo0?=
 =?utf-8?B?ZHRsR3lrZjRUV2h5UDF2Nk8vbXlVVFdaQnpoWXMvak9CcWxSU2svbzJDdzVm?=
 =?utf-8?B?Y1FLUmZPZnlFL0xXMURVZTZIa2xuUGZsYjFEZnY1Nm1hQkNSdXZLMld3U0Ez?=
 =?utf-8?B?bVBVNFNhcE5wR2hSb0k2Ym9WYWtpdkp3WlVYLzc0bmF5djBtaHdmQ2M3c1Nw?=
 =?utf-8?B?NkRQV2ZxWUtaRlA2KzhoYytTVS9pUWc1U3JxOGdyeXNPOXVBVVdoSnc4OW9r?=
 =?utf-8?B?NXJIZmFpZ3NuQ3pQN2VkQ2wza21SYVpqNk56NkZYVSt5NmhkZzlnN0ZRSHlE?=
 =?utf-8?B?WHNkOEFKMlN0cjNzbUtmUWEyY0l4NlVwcUFCamhwSDBEaEpydFVGV054UW93?=
 =?utf-8?B?SXYwbjlqUkhtemdnYm5xZiswbFZ0TFNtQkdlcllrYzVZM0xEbjMvZ0Fnb3dW?=
 =?utf-8?B?dFlLc1lpUEkveUx6eFBxcXljUFM4ajk5K0o5VWNiWXNVanYyUENnb1pCRkJk?=
 =?utf-8?B?ckcyUTRCVGdxcVd2M0pCRkNZc0pjUUI1N2QyQW9vSmc4V0ZsUWk1TnF5cGpv?=
 =?utf-8?B?VEg3a3NJTTBLZGVQb1FKNHJJZVhlS1VETVhqTVh5UnVrcUw5S1JJbjNDODFy?=
 =?utf-8?B?Y0phSWhpUTFYYUc1eUg1aW9RRU9kUVFVeUJ4ZGVYM3p6UU8xTXFkWmh1dGp6?=
 =?utf-8?B?cUZMYUVQdjdQbGlvcksxSFBhNFlwdTZmVWhMc2tDVzlZMFViV2FHZThaYmZo?=
 =?utf-8?B?cUdtV2NyOFVlTTRVWXpJcVVIVlpqVG50NW9CcUhXZ01oREx5MEt1VlZLaWdp?=
 =?utf-8?B?MU42cVVxYkV1UnN1WC9YZE9mVG5IVGdyV0kzMW5mK0l0UkVjTURvN1VkNHRF?=
 =?utf-8?B?RjFmak1wM2RVemV2bTUwNi96aWVkMytJT3c1K2doeTJoQUU1RkVHbjIwdUFS?=
 =?utf-8?B?bUZHcG1nOUttTjZBckRjNjlsdkRkNURydzB0NENFV0xnQklFbnl0NDBsSUVF?=
 =?utf-8?B?aWlxNHFOUkhFQmZuMUlaampqRm5kZlFRcUIybWRrRlJSQW93bnk0emZTRnRv?=
 =?utf-8?B?MGQ0VDZnTnRuL1EwcXNaRlBWUzdlRGs5R2RxaDhjVVpCQk11ZE9iOExOakc1?=
 =?utf-8?B?NzY4VUVPbVlzUlBvYnh6c0FndjBMQkl2L3Z1OEoxNEhJSXlBaDM4Rm9jNzhK?=
 =?utf-8?B?bG9hbDFnbDJPTU9PUEV1dUJlWDFKVXk5cmp3UC9wVVhvS0RxUjI2dEdidWlS?=
 =?utf-8?B?MlJ6RU5QKzFkVmNsc1k3N2lJWUxXU2M2aHFWVXcwcGpQRjhUNVJ1S05kNmky?=
 =?utf-8?B?UXF1QWVPT1lDUHVrNzlMYXp2ajBKZG1ESlVDUlphanplajJIM1BvMDNjZ1ov?=
 =?utf-8?B?d2VWVzFocGsxWWJCZ1pURkZHWHJFSWxKVmlMQU9kZ0ZvRHJDM0tGODJ3SitL?=
 =?utf-8?B?c1hYZXNFbEZFTUhYTmo1OHRwdklNVUthcDR6YjVSUUhOZFFCemthcGthS0ll?=
 =?utf-8?B?TWZieVFCWWtDWUZUMmFzS2oxdVZwaDdwM0ppT0FOS3RKY2FBRVJQSVAvWEtm?=
 =?utf-8?B?TGtOcFU5QTNxQVAvNDRyQXE2dC84dWFTd2V3MnFDWWE0dWZJUnhUVDk5ektu?=
 =?utf-8?B?ZGM2Si9xeGRheVA1aEhiKy83Zm9LS3lrclNobnNrM3pGTjBlSGk0Y05JWTI5?=
 =?utf-8?Q?tIOlioaZaBNy+xao6jg2V/UbMtPWhfk4?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TTN2ZzUrYW1pMTd4azJabjdqN2VkNjhybS9FcGdTUERyTDM2WW1aaEJKOGcw?=
 =?utf-8?B?eWFsYWVjaFVoRC9EOGU0dEdIQlVJZ3ZCblB3cjFGREhKRXoyLzBSbmx5bzZn?=
 =?utf-8?B?N2FsVFdxWmpRSmZRRWhwZnRaV3V6MUFFdGhoS0pra2xvWDBXcWZQMWxJQXVz?=
 =?utf-8?B?SnQrVk9vNnFCMHJiK0RmRkhzQk83NnBocWhOSVRGWERodFllZ1FRSUJzNGxq?=
 =?utf-8?B?Mk5kc1gxQ0dzTlM3Z1JOV1hDNjBKTmVWWXZVblFkRGFzNHFrcFZ3ZGQ1Rm1o?=
 =?utf-8?B?TE5EV056eUl0WGJHSlM3MitweGdVbWZhdEIrSW9FNWVDTkp6eU5yM1JpUHZS?=
 =?utf-8?B?emcxVk16M1QrYjQrc3ZLSnAvMjl2SjBpemVYdEZGVDI3bGZ3bFF0MVJIaDRM?=
 =?utf-8?B?SkErWXlxYmJTOXdjMEdpNzdpRFVQZEFSbHJmMHR4cmNzKzVzRENkaWthQ2tD?=
 =?utf-8?B?OG03Q2JkaUEwMlY5VVNVRlQyV1dHS2NBeFByTkROS2szSjM2c0lkSUVGcFE1?=
 =?utf-8?B?bHc4ejNnQm1qbHdKMGZiSkJCK1FGZ3hPdXpnVHhUN0Jka1FGaHhBaG1ZekJU?=
 =?utf-8?B?M1Y5cDVnYTJCYXBVeDk3WGRWVHFEanh2QlFLVStGREs5L2wxSitJdkJ2eUcw?=
 =?utf-8?B?V0lpUXFwYUtTbW4rU0s2OWdXOHhEYS8wMnlLVWRuTFJLMzdJTFdoeFRsRUwy?=
 =?utf-8?B?aVZqZ0orZjVldDFra2lmdGJEQ0R6MjY3SmdPMXZHbWtmM0dOYkdYR2NqSWJR?=
 =?utf-8?B?WkZMbm83enRqTTRObU5hNlRqSHZ6M08wc0doQXBTY1d0OGZ5UXFMVUQrb0lD?=
 =?utf-8?B?UkFOQ00zTlRURDJTczdKY1Fva1ZIbm8zdXJ6eVZOa0tHbzdNazJyR2IrVFV2?=
 =?utf-8?B?c3hXcGZTd2VWSGp1Z3RoRjlkV0pLNzZ3STV2eFM3RERiaDlDM0d4a1FKVmIw?=
 =?utf-8?B?U0xlK2RaS1VRaU9VdEVVbE93WDZCVjIxTVdOMHNrN0lydU9VNGFRVGlGNmhp?=
 =?utf-8?B?OEVqNXFJdkxaMVBSNi9jN0FGbG9tWXNjeW92alFKUXBlUkFTS3dnYUtualZW?=
 =?utf-8?B?SExlbVJISDhEMWpoV3ZDc24wc3ptcFJJZ3VEN0htREJxOEtDbDJnY1Y4RkxV?=
 =?utf-8?B?Ykt1akp1VzlEUDRzYTk4UHd1aVorUXB6RFQ2bDFMc3RjVlRXandncG03NU5O?=
 =?utf-8?B?cXJEWjVpTzExeVVybFFHYlg0QXZSOFc3NDFuUktWYVhITHA1WXl5RUdEYmQz?=
 =?utf-8?B?bENBOHNBbUxXYVhSUTliRFBBUWY5TXIzU2NtK0d3eVJNVDM1cWR4SEhBVno0?=
 =?utf-8?B?R3Z0UVczbkdnOXlvMDdjWkQ0WmVEZVdscWJKQnR6UlB3WnJ1aWFycll6T0du?=
 =?utf-8?B?TTYyeXdocDFnTVhKUXIwNWxxV3B1azhpc2lKVDc4R1VHNHBNQmxwanA4MWJZ?=
 =?utf-8?B?Z0s2VVJCZGloQUsxQm5xb0VxZjhlTGh3UlNlSlZqaU9YdGtsV0RGVjVlQWhn?=
 =?utf-8?B?RVJqa25rZTJDUC9EMnJsbm9SSjFuK045eDZEQ3Z0RTdvNEtrVUUzNGhoUWRD?=
 =?utf-8?B?RkVEZnAwYS9TVXFUQVBmL3hER01KTFVZaDRtM1FSb0ZJdllsYUxRdnZZM2ZP?=
 =?utf-8?B?Qm0rRnFDaEZQMHI1V3hnOXdFYTlnTmoyeFZVSXVqNFE4czU3eklEK3dLNFNr?=
 =?utf-8?B?eTBSTFY4Y1VkWEFhZ0w2bEZiOExVVUZRNU9hdTRkWG4zbWw4alN6bEc1MDMz?=
 =?utf-8?B?TUZmeFNjTXovVEZRVnZwUEMwWUJDUUhMTThCckE4VUN0blhJS0szd2tLcDNq?=
 =?utf-8?B?MG5DWk0wWnE1RVp2SmpjWUdiMWExeHp4SUhPWHgzN1JVWFlJUHFrZll6QjNz?=
 =?utf-8?B?dnR4Uml0RWhPSHFLa0dQUGIyNFRRV1NRNXVEUXpuRE4xMDlxTjdVZjJTVXlm?=
 =?utf-8?B?UmJSMkFrT1cxTGs1bHMrZWxSdVByVHArRXUxUGtLVTBzY0VwU3l6OFVkMDQw?=
 =?utf-8?B?dzJyMU1UV0JjSXdtbFhTa2RXaWRSalZwbkJVY2wrS0pHckhSKzgxcUFBYlpO?=
 =?utf-8?B?c2xlemY2TjRaUkZSenBZTVFnbXRvUlBlMGNraEZsZC9ieXArNXN2SzBBVmJI?=
 =?utf-8?Q?5+zTtjXu8/FUgUkO1kIxW7Gr+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lls7LhpGqtlFXG4n8zMJ6gPOJEPKEy7fwTCcpWYv+9F9SFDD5dbPxzkOXpmdVV5prwNfKUQH2IOUwPiuNN9bnYBtejbI9cJJ2pmNbZtH9cgc2+jg3ez1sZcXYH5Ygb+4jtTkLaQkzz+83+eoDkLATs8vkOy9TGSs0TvfXjyGGLf5qmWl+0ZQqNsJKE9eEnELsYqPZlKKhhLs7A9JV8xYNu1X6FEM02Yc9sejF98zGmdzJYXGIg0Hkp3ggeEsdGHIe2hSzj/omFHXo6L9+OicwmLQ7XUQDwvSChglz1SjfNOslp1K7KYcF8V5ytZMUb3JIQy83xtOqzeHCuAsCd2bwvAcUsPrpYdhMWJzt7mIZfqJYrfZC2kSUuvCG1Zf8RrDk4EPDn0sRMpnuq59C3kAKrU+ZHLZHo3sye0mpZZENcL3RyFKXSXHCP043rPZlP2Gh0DzH2b8w3zv4U82jdVONTKmVlrdgdtx2F1yarcpa1KkoCTdcADGjmw7Bs7H7MeNz06jRZ40GqF98Vs/yb7Z49FcKVX9/nuubFhiWwWQ8oBtLQeEYe0OJXnXTuH1jBjM3EorjY5+yuOc1dqduHRidPVu2JoFIqPDzgQyp7sD/Q0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60790aec-2b3e-497a-2e18-08de0c043e4c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:02:30.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFhLmUgrUBRKehMJKMFveyg2ujZx0Gt12OxxnzzBNZ2GmbC/PTx+k6h0vXOt3sC6j1EoGr4sQBGbVnPv4Bgwlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510150116
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68efc59a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=-Zs3SlEuFdPl_lJKSEwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y_rkC6Ck4y2Gq-2R06hkdh65BWQt0ZTo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX50YNdEGtOmqm
 YbkOSrOh36/3CTk9zGRoZk+B70G9Fs8qlLQsW8q3kL04cijszSy6NdNJjTAC1Z7L1UxRAIYTgDJ
 ayyZWY4jwxm9Nojocvi1A0PJFzEa5D0b8+vnRfk2Y6oH7bunaIpkORi2Q35Q0DJXGQcBcW7yh4Y
 jiXCWGUoL67g4R6207zWyNqz+eRgyjgD3vYdCz5Jj/sOR1P5TgMVm5h4MuMCC4g5tHt4wz8xhMq
 ovdrWL0zOXmFDGKwxXFHnuntYXIZfiFaZ/1rN/TusJ4t/nW3Oj8MAaWLTVny+Vw5gi8U2es/lmJ
 eDN+GKciNcfRlpyirSxWql/Ui2Mcj9lN08AK18Mt23tOXxDTb7bNlNzGDIMS8qVqwW1c2wUkhI2
 TE+YLnMu4P5B3jUnEzfMLS7bJsBI+A==
X-Proofpoint-ORIG-GUID: Y_rkC6Ck4y2Gq-2R06hkdh65BWQt0ZTo

On 10/15/25 6:57 AM, NeilBrown wrote:
> On Wed, 15 Oct 2025, NeilBrown wrote:
>> From: NeilBrown <neil@brown.name>
>>
>> nfsd4_enc_sequence_replay() uses nfsd4_encode_operation() to encode a
>> new SEQUENCE reply when replaying a request from the slot cache - only
>> ops after the SEQUENCE are replayed from the cache in ->sl_data.
>>
>> However it does this in nfsd4_replay_cache_entry() which is called
>> *before* nfsd4_sequence() has filled in reply fields.
>>
>> This means that in the replayed SEQUENCE reply:
>>  maxslots will be whatever the client sent
>>  target_maxslots will be -1 (assuming init to zero, and
>>       nfsd4_encode_sequence() subtracts 1)
>>  status_flags will be zero
>>
>> The incorrect maxslots value, in particular, can cause the client to
>> think the slot table has been reduced in size so it can discard its
>> knowledge of current sequence number of the later slots, though the
>> server has not discarded those slots.  When the client later wants to
>> use a later slot, it can get NFS4ERR_SEQ_MISORDERED from the server.
>>
>> This patch moves the setup of the reply into a new helper function and
>> call it *before* nfsd4_replay_cache_entry() is called.  Only one of the
>> updated fields was used after this point - maxslots.  So the
>> nfsd4_sequence struct has been extended to have separate maxslots for
>> the request and the response.
>>
>> Closes: https://lore.kernel.org/linux-nfs/20251010194449.10281-1-okorniev@redhat.com/
>> Reported-and-tested-by: Olga Kornievskaia <okorniev@redhat.com>

Very tiny nit, on behalf of scripts that might complain:

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Closes:
https://lore.kernel.org/linux-nfs/20251010194449.10281-1-okorniev@redhat.com/
Tested-by: Olga Kornievskaia <okorniev@redhat.com>


>> Signed-off-by: NeilBrown <neil@brown.name>
>> ---
> 
> I missed this change
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 230bf53e39f7..6135b896b3fe 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5085,7 +5085,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		return nfserr;
>  	/* Note slotid's are numbered from zero: */
>  	/* sr_highest_slotid */
> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
> +	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots_response - 1);
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  	/* sr_target_highest_slotid */

Can you send a v3 of this series please?


> NeilBrown
> 
>>  fs/nfsd/nfs4state.c | 51 ++++++++++++++++++++++++++++++---------------
>>  fs/nfsd/xdr4.h      |  3 ++-
>>  2 files changed, 36 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index c9053ef4d79f..631147790d5e 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4349,6 +4349,37 @@ static bool replay_matches_cache(struct svc_rqst *rqstp,
>>  	return true;
>>  }
>>  
>> +static void nfsd4_construct_sequence_response(struct nfsd4_session *session,
>> +					      struct nfsd4_sequence *seq)
>> +{
>> +	/*
>> +	 * Note that the response is constructed here both for the case
>> +	 * of a new SEQUENCE request and for a replayed SEQUENCE request.
>> +	 * We do not cache SEQUENCE responses as SEQUENCE is idempotent.
>> +	 */
>> +
>> +	struct nfs4_client *clp = session->se_client;

Nit: Let's use the usual practice of local variable declarations
immediately following the open brace. The helpful comment can go above
the function declaration.


>> +
>> +	seq->maxslots_response = max(session->se_target_maxslots,
>> +				     seq->maxslots);
>> +	seq->target_maxslots = session->se_target_maxslots;
>> +
>> +	switch (clp->cl_cb_state) {
>> +	case NFSD4_CB_DOWN:
>> +		seq->status_flags = SEQ4_STATUS_CB_PATH_DOWN;
>> +		break;
>> +	case NFSD4_CB_FAULT:
>> +		seq->status_flags = SEQ4_STATUS_BACKCHANNEL_FAULT;
>> +		break;
>> +	default:
>> +		seq->status_flags = 0;
>> +	}
>> +	if (!list_empty(&clp->cl_revoked))
>> +		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>> +	if (atomic_read(&clp->cl_admin_revoked))
>> +		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
>> +}
>> +
>>  __be32
>>  nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>  		union nfsd4_op_u *u)
>> @@ -4398,6 +4429,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>>  
>>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>> +
>> +	nfsd4_construct_sequence_response(session, seq);
>> +
>>  	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
>>  	if (status == nfserr_replay_cache) {
>>  		status = nfserr_seq_misordered;
>> @@ -4495,23 +4529,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>  	}
>>  
>>  out:
>> -	seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
>> -	seq->target_maxslots = session->se_target_maxslots;
>> -
>> -	switch (clp->cl_cb_state) {
>> -	case NFSD4_CB_DOWN:
>> -		seq->status_flags = SEQ4_STATUS_CB_PATH_DOWN;
>> -		break;
>> -	case NFSD4_CB_FAULT:
>> -		seq->status_flags = SEQ4_STATUS_BACKCHANNEL_FAULT;
>> -		break;
>> -	default:
>> -		seq->status_flags = 0;
>> -	}
>> -	if (!list_empty(&clp->cl_revoked))
>> -		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
>> -	if (atomic_read(&clp->cl_admin_revoked))
>> -		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
>>  	trace_nfsd_seq4_status(rqstp, seq);
>>  out_no_session:
>>  	if (conn)
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index ee0570cbdd9e..1ce8e12ae335 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -574,8 +574,9 @@ struct nfsd4_sequence {
>>  	struct nfs4_sessionid	sessionid;		/* request/response */
>>  	u32			seqid;			/* request/response */
>>  	u32			slotid;			/* request/response */
>> -	u32			maxslots;		/* request/response */
>> +	u32			maxslots;		/* request */
>>  	u32			cachethis;		/* request */
>> +	u32			maxslots_response;	/* response */
>>  	u32			target_maxslots;	/* response */
>>  	u32			status_flags;		/* response */
>>  };
>> -- 
>> 2.50.0.107.gf914562f5916.dirty
>>
>>
>>
> 


-- 
Chuck Lever

