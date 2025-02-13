Return-Path: <linux-nfs+bounces-10103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C24D2A34E63
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 20:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13637A3F72
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49699245AFB;
	Thu, 13 Feb 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nFclGrr1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PgP9pJPy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60B206F2A
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474567; cv=fail; b=URhrszCyDh9pN4I/qwfOIO79qBJ2i8xQGO1ZiYsjLFY16pxEYHti/MeBskdfBc747OA8ca55JiZvwmHFmaVIYnDIQ4wp9fge988mK8xY0oS7hXic+/QCM/ctLXEmGCr7Xzvz+VotgdUzFQ1BfmFA9pXN/0xvSwObJGZl/j04c4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474567; c=relaxed/simple;
	bh=aF6ByHtWipXUPASKM0len701KoyDeTsu4K08IH5n7n8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZH0UaraLsdR5zkVsD2Fw39DLzkBdH4ZtbZh4PiqwU5l0sr/L5hTzt5FxCymMhxQfoqN5fvnp6gEbHOKLn5vakkVRU602dXLWUQq7uNZgKaQRJtH28f0GxnA+WUuJAIcreYbo9GnYrxE2d19XIH5WbRXFwuUhrwIDhgiLKs7JQq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nFclGrr1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PgP9pJPy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfYOJ020912;
	Thu, 13 Feb 2025 19:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/PQoZ9PuMjsDMTHGxl7fCFsR7y+8GFrMPj32TqE9NIo=; b=
	nFclGrr1PXVl1RF3xPSNZL384qgna5F09orvXiUStRaGuO6tR08yhqK+kVTwz3AL
	N7cdi+2U67n2bBSgnoiLTAq4aAyWMP1W1JFz+usOc/mP+nC0agRmKHkgbj3wd2jE
	XvjZqZPQJPvYFdRTqOoPj2K4tvpWrSt/2C30GBInTjVpn2tuQsAFne7wVgKxdQZ+
	Sr6pkA1fi9RlnlgRm5LeAahAQ5lD5Ox9FawoEh+nufNKESZHqIOc3XKAlLo8QNsn
	NlUFj6R3u2GyoFS04f9D8gN97i3KlE/0NALik0sxOtd9BHsPvoSlVrmfTiK+TWTL
	diUMhzhi3iThom3TJ4nUiA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqagmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:22:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIeBFw025242;
	Thu, 13 Feb 2025 19:22:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqjqj2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tov0nP7ys7iIvvcCRnkkZZzzjLATHXH0hcu62hPfIM1/C+8zs5FDK/pvtoWupaDQuM6rmDpHq0pgiad/dpkRF2t9HNzvDLnWfcZ08QdX3P4QkhUTCkc7X0T2xxIF9ScP0yhyWZW4ige3fr4OBZkaBsiidg/GrD+ICCt3eeZ9niVoIOVYDY78fJgikarmEHb7oe67YXKSOcT2MazwQsnCYFEE6oH1Dtz8ZWe0Zt5zyvkSek51up+GrPQmURfnvY5WAPjpLPy5OBVq1Mu+O4aPzVIMG5xFU/sriIrubZ2O3tGToWPMmg4iwP10T37C164IR60ZcCGvo63R9ZZeJydjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PQoZ9PuMjsDMTHGxl7fCFsR7y+8GFrMPj32TqE9NIo=;
 b=xFdR/NkGzLyvz/oDtTbxAU+QgHU8TvDVc3haZnxi48f/hS9xo41LF/LFmEy/ryhZLKrb2jgD8e0YrDPf2I13ad8Ifji1n8ak0aikpypv/acY+0TegUXAorYZu0I7d/qBi8Y7SA243ivf1aP/UsaRbq4F24dTargUEKqu5RhBZHcWIWU1wjM7gBeHM7lm/AknEiXobtjeKhalaKLC/n7/07Sk8SS1ZaDwys7zlyRcIxLMmCeBgqPE8fV55n08cumjH5DOuFnTMTM/Yoli4RDlDCzzv8sf8/BzqMdqDZ6RB3O1pSwjvc8tEGRakQEzqpv/SHPy0S3xXGmcCZnBIDY0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PQoZ9PuMjsDMTHGxl7fCFsR7y+8GFrMPj32TqE9NIo=;
 b=PgP9pJPyeTQ4a2kBGd8tYQamkP66AhSh7CWzyX6KyZZR7/Vpg6isVfhBwuAjIAhtnYwjY0kt9BvknzP7hjhNVMJlg9ewU6xqmqKSkoWX2xL3un2KzoNV57tbPkBOgEjJnvz9WztpU3CWDLpyl6fxYaWJNEnm9kAz0t4RMeorjJo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5007.namprd10.prod.outlook.com (2603:10b6:5:3ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 19:22:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 19:22:27 +0000
Message-ID: <69eef1ad-9f1a-4ef7-9578-9822358a038b@oracle.com>
Date: Thu, 13 Feb 2025 14:22:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
To: Trond Myklebust <trondmy@hammerspace.com>,
        "aglo@umich.edu"
 <aglo@umich.edu>
Cc: "okorniev@redhat.com" <okorniev@redhat.com>,
        "cel@kernel.org" <cel@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
References: <20250213161555.4914-1-cel@kernel.org>
 <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
 <CAN-5tyGt4OhqZbzzADe9OumbaThrefZ1nTw=_wrrxy7FWfWK9A@mail.gmail.com>
 <18421def0a2aa132a6817b56f97eb9d6f3928727.camel@hammerspace.com>
 <12784b78-d053-46f6-b0e3-e81ca2e90269@oracle.com>
 <db7103ddc9ab031dccf0807456c09e5297179fc9.camel@hammerspace.com>
 <97b5cedd798448c57e21ac499f0d9be551341002.camel@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <97b5cedd798448c57e21ac499f0d9be551341002.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0039.namprd14.prod.outlook.com
 (2603:10b6:610:56::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fce94ef-321d-46b4-d54e-08dd4c63c0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWIxTWNuSWJJenlONWowcjl2UElnMlJtMHN5Rmw4bFh5L1J3UDRPcXY4SU01?=
 =?utf-8?B?RGpEUDd4ZVNsVDE0TXpQTzNkWGovbHR1TXVQNDhoWlZzZ0VZUGhmYi9WSndr?=
 =?utf-8?B?K00vM0IzVFJidUY5UUlTOGlhNVNoZlBzMmkreDZQMVlrMStYTEt3c1BhUUFt?=
 =?utf-8?B?dC9QM05wc1dXUFREcVpEMTVzUTRyc200N2lvZGRpQ3craTRqamsrai90VVNI?=
 =?utf-8?B?UjVvZllodDBzbjBBQUsvai92cUJGaHR1Tkk0cWdBQmdqMk5wc0VXc2dCOUty?=
 =?utf-8?B?ZHB3ek9XcDB5L0IzTnpTQVhnOXNxRGlUM0RISHlGZTRHdEJaekVFalJ5TEVN?=
 =?utf-8?B?ZDhwdVUzalUrQlVlekdZNC9iLzFOY1Z1U3pJQXVwMW5hK2xENWJQWnh3REky?=
 =?utf-8?B?ZnRZL3dRcmE0RitaVkF6c0x5Y2daVGNqSnplNjJBYStseXRHamNmZlJJOUMy?=
 =?utf-8?B?bG1ydGNrc0NpY0d6VG9zQnpNRXdiSXFDcVo1Z0ZCK0hJZHRNZlpTcHgyQjFz?=
 =?utf-8?B?UDdxazVQUjBKWWRabzhEU1pXMWVUVUhDZEZoRkpQRTFXTnlUOEwxZDFQM2lK?=
 =?utf-8?B?Vm5sS1NCYnMxZ1pTY1pUa1Y3STdoK3Vnc1RXenluL3VzMDVBZ1QwM2ExTlMy?=
 =?utf-8?B?MU5JaVlSaWtXeVhZUGJHYjFxdWRDalhSSkkvUDgyRm1ZQSs5bmhkTS9vVFh5?=
 =?utf-8?B?UG5lYXhhYmVWSml2bFovWjVmNTByN1IrWXU2RDNnOUJEa3NvOWxRM0lSbWNC?=
 =?utf-8?B?QVlKNE9rK2lxUS9pRDNKZVliZFJxMnZDemM1YkJrUGdMaEUxNUtVdTJGc2NN?=
 =?utf-8?B?Kys0UVNMYmlMQUlHQjZxbDFSWnc4dkRzN0xjVmJuaHJRaFNhMzlHWjd3WEFa?=
 =?utf-8?B?Q0ZxMGVNUFhJc041WUFISUZUTzFuVTl1aGZKVm9uaXowL1BmUjFqL2c2eDlC?=
 =?utf-8?B?Ym1YYTZQTXJJRitEVVZkWXpkMm0xaGVHS2JwYlJhNmFCdjRqdjkxQU5TMlpo?=
 =?utf-8?B?QnljVFc4ZnliWUFnTStqTWwwdmp0YVVBVDUrMUMrK25KYm9jd3pZdWEzdElU?=
 =?utf-8?B?ZnU3TmZJTCtxM1o3MG0zM0tCUFJ6VjFUNUljd2J0NGF6NitJdENGT2tmK3dj?=
 =?utf-8?B?L295OGtLd1JlLzBON1AxR2pycmJTMWdQd1hMTW4zdXROWVM0OE51WmVrSTNz?=
 =?utf-8?B?M1hvQTBDT2tweDhjQWxhUWJyaUI5R1lFcXBQbTdGZjNFZWYvNTVHc0RMOEIv?=
 =?utf-8?B?UVZuY2d6NVJJTUpKZHRUYWhjUFgrT0N5YUFsTEk3SlhNcSs5L05oaG9JckN5?=
 =?utf-8?B?bC9QQThUTm9wakNscUVGRXc2ankxOFo5Ti9xL1d1VEozRlNyN3V3WElDNURr?=
 =?utf-8?B?Ujc5bkxKajNpQ09FZVlkWjUxaVBMcy9oYml2dTlQR3dTbFpVS2JGZEpxMFM1?=
 =?utf-8?B?d1U5Wmo4cWpUc1RGa0s2VnhVZ0x0SWd4OGlKUGRHSTlwa3pxRVVBVXZuSm5R?=
 =?utf-8?B?cXJ0dFRmbVVwRXYzaEo3dkNtd0pSQ0hGSTVUalJvRVhPb3Z5UlZyUG00S21v?=
 =?utf-8?B?NDFSa3U2bU5jYnM3eUZnaHpaY3kwSWFkTWJqMVV5NE5RdkVyN3lyM1VPMjdh?=
 =?utf-8?B?RWlHeGltcHhOd1RjdkpnWkVBWEd2NkMxK1Q2NjdzZ1dQK3pXeHlWYXU3ZWxw?=
 =?utf-8?B?cTJnRFNjd2tPWnlhektpamErcDZVdUhiQXdoTW9tRTBtUHcybE9YU1hGajFY?=
 =?utf-8?B?K1Yrc1h2QXhWSG03RFFQT2JIRExtQUN5RlYvVDFpOGlGbGYvR3VzNXk1ZlVE?=
 =?utf-8?B?RzJvbFdDb0VpVDdLQlpya3g1UldNcTdVbW10SjVIVytvaFhLYUJKamJpVFYy?=
 =?utf-8?Q?QgW4B4jxVGWMe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWU2dW94TjhOUksyT2F1QTdPRXdFUlVXUG9kUGdRRjRITU1qNTBpa3FjaGNw?=
 =?utf-8?B?TVNHZ0ZrdnJRRDZpRmJhc0JWM0RFR0ZQVnY4d0tGd3lOMFI4dmFpS3JHTnVX?=
 =?utf-8?B?SDdoMmJQcU1XU29LdXF3ZVBWbjVKeVRyNm02TVlZRXRvWnhCVW9uSEpoakh5?=
 =?utf-8?B?SjQ3ZUgvK3NlR2lxMHpOWHJxRVV3ZTBKbVArYXo4NHpxNE5abVJtU2ErRXJl?=
 =?utf-8?B?cUJ4TDNkcTNGYldpUGdlQ0NBYm80Yk9Ca0RaNmtNWDhLUE8vSGFBTG90MVJK?=
 =?utf-8?B?K0ZwM2lNY0JoY202SmZUWThYZUxobkFTZ2N3YWJKTmtUMUZGaGNLWVNFSUQw?=
 =?utf-8?B?NmoyRDN4UG1IcG0wT211bHJUQW01M0RGZzc3OVRZN2xwSFJNa0dWNHJXeXFG?=
 =?utf-8?B?Y3c3VSt5NDFEckVoVWVXcVBENGZTYmR3d205eU4veXI3WVVlbUxIbENHV2ZO?=
 =?utf-8?B?eFU1bFl4aGtwZXR3OWw0MzJDSWNwYi91eWIxM29Kbmhhc0J4K2pqWkU0dHo2?=
 =?utf-8?B?TStPMjJUVHdKbmh1MndpZzg5b2NoUzJaOUs0WVhWL3llTncrdkE0aG91dCtn?=
 =?utf-8?B?cXlLTWZUa1M5VVVRbFkyc1FiZi9MbXJHbmhWNzZqc2V4YnpOWVlKUnJSYWZL?=
 =?utf-8?B?T2VMb2RXMVRWOUhFUXVCWE11dkV3TXlnQ2xGVnl6YXZmQVlUeHJsN1J2cm9M?=
 =?utf-8?B?a0hhejNDS2RnOXd1MTJxOThyQzhYSE1ySVJkYTNNSjZ6TnRGQlVla3lsZGxq?=
 =?utf-8?B?SG9xZ0NJbnVTWkFFUk03Skx0QXhMMHJaSVdpbjBVTGxua0xlMnc2OXdrRHRp?=
 =?utf-8?B?V3JZclZsM0FvMHRNajZiTndzVWN3WSt6NHU1eko0ZWp6NmhnbkRwUklDd1V3?=
 =?utf-8?B?bGNyVmtpSkJTVW4zVjNVT2pUenZxZUx6WWRNOE9rTGNsRXdOSXV3UUU3eElT?=
 =?utf-8?B?cW0zOXBrMGJRdG5DbkZkTHJ5SmtBZjFxZ3ZiTy9qWFBhMmdTM2Q0Q0FJcFA2?=
 =?utf-8?B?ckhZeHlJQTZDZi9hRkhwY2pqamthdGlNaHdGYXlGeXpLZlpMbU9selpKb0Vk?=
 =?utf-8?B?NDZRclV6L0wzdG5sTTJNWGtzZG9sK00wcHJMUGtZZEF4b1Z6L2pJZ2pOMkJl?=
 =?utf-8?B?WGp4d3F0dlpndG95SW5hblFqL1MxejdVT1ArMXR2R25KSGlBaUpqT1d5dTZw?=
 =?utf-8?B?ZUQydTFpTmxsbE1WNXhQeU5KS3ZLSVVNRy9DVGdBRVNFankrV2xFSE1MQ2Q3?=
 =?utf-8?B?S2JnVjlLelhtelk4R0d6dXp2VkRDb1ExekRJM2R6OUNMUi92L2xFWDJKelgw?=
 =?utf-8?B?SGN1MTBPMVhvd0VCbWRsbHo4NCt6dGVoblc0YlpYQ0U0bVRUdkwvMTd4QXlD?=
 =?utf-8?B?dWo3d09Gdm1HNFRFM2RUMG1QQjY0NjFyL2Y2dm5SQmlYY2gvaVJUTG9xQnhR?=
 =?utf-8?B?cExheFUyZmZTTmwvWDd6RWUxdWJmL3FmSzcvR0FtYmszM3VzaUl6c2x0dSt0?=
 =?utf-8?B?OE52UThtajlrcUs0dlExVkgyTTMxT3dObWJOY1F0dDlIYUtGNVN4bjB5Wk9t?=
 =?utf-8?B?Y1pOenE5L0lsUG9CS1lFUGJCZit0VnI5djlZWkNFOUM3dmFYU1ZxTzdFQk13?=
 =?utf-8?B?ZG45Q2hRczQ2RTdGWFcvdm81WDc3aUUzbEMzSEhVUW8wNDl3ZzNOZHlWMXFO?=
 =?utf-8?B?ckRhYzFiYWtNUHdqTjRma3BTOTlGMlpTVDIrNGZvOFhGY0tkNzRYclVVS3BX?=
 =?utf-8?B?MGhPYU1PQUlacU1TT3NWSUJHYjVZMHdFdjlURTR5Qys1VERML2xEWGNnZ3l5?=
 =?utf-8?B?c0ZBY0tmbzJvMUVLRFR6d0VLTktPMDMxSThWcEF1eWltUW9GV3VsTVppUXVH?=
 =?utf-8?B?Mk9heFhRYVdod2RrUGRHb1ZpbFZuZGVhN0NYMFlQN0VybHJNS1JuR3hFWVRH?=
 =?utf-8?B?bkNQck5wcnlMQkhjNmQrS1hWV2h4WnZndjl1ak0zeTZweTFtMWp4M3lVWkNK?=
 =?utf-8?B?NGMzNFc0Z3Q3L05EQ2w2d1NRU21DNG9KZ3JMblF2aUxTenAxOUlaWUVpcmha?=
 =?utf-8?B?MWw0MkV5S2dtcnVkOXpnTFZSN28yZzBnVURlY2kvT0VKMDFpYnZRTGVtajFs?=
 =?utf-8?B?cDdOS2VZbkMvWm5jcGpxSFNpRWhlRndhczN3SElnVFlGTzREa0lQNHVBV3Zt?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IHPZjdnvStRZQ+/D1Jb8efC6wLAbYTE0oByw/VnhOVK+z/i59kzq3LJxQZjPZAvJE/tIxEkLXooi6dOXTpzplrRaSRkSR0zyDGSq/VDXRfALA1WchgkPl6znVZiaQgD74LVMUM37KNZPBTm2ScrEUxXPT0hyAQQE/xDjEwzFtuI711SZYY7wJh/jH0B+yvv17vwfv0ES6zk/pVFyhM6p+0qSiSWpI211WxG4DltK+bJvQqQ4RMOTAX/Ow1MmSI2j2TfBiEufmqpC67W1G31KdRdoTHCBh9RGszRF+c6Nu6/85OeYg+yj23fPUcV/B1QnUukn89piMneC1C9K6WaKqrVwX5oPWLv6mwzKxugh+gfBJP5xYe5EBzEDrXN6e9fJr05KTSNnbd6oUc30zIoXkeP6TGh3OGBxNoja2KHbsTHQzBrqokRnQI+9URKA9FtaEi/8CjyXUAHsr+PBikO6FwvDFfbezPdAngCApkA4GwDxj5t8IH+MlSIUVPxDjo20LeZ4A5S7lOQcnQoZrD1W97SUhMpOlBDRuUHhjkf2kXH/Hw6HqHQKCileJVSYvkIgL1irFfmFHID4ofg4VSldLIqUMWYk64j5PhE3muavu3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fce94ef-321d-46b4-d54e-08dd4c63c0db
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 19:22:27.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+iQfSe19mtyJxWGvHZZZ2iDRui1fWk6kQddlG6ProSxpzFR/ynQTItLi7JoLs7fTe1ujPuEhgiS+g54OC2Qfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130136
X-Proofpoint-ORIG-GUID: tGboz9IK2TczLGgfAYA6JlaG7sf8uIcz
X-Proofpoint-GUID: tGboz9IK2TczLGgfAYA6JlaG7sf8uIcz

On 2/13/25 2:12 PM, Trond Myklebust wrote:
> On Thu, 2025-02-13 at 18:49 +0000, Trond Myklebust wrote:
>> On Thu, 2025-02-13 at 13:47 -0500, Chuck Lever wrote:
>>> On 2/13/25 1:44 PM, Trond Myklebust wrote:
>>>> On Thu, 2025-02-13 at 12:53 -0500, Olga Kornievskaia wrote:
>>>>> On Thu, Feb 13, 2025 at 11:59 AM Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>>
>>>>>> On Thu, 2025-02-13 at 11:15 -0500, cel@kernel.org wrote:
>>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>>
>>>>>>> The NFSv4.2 protocol requires that a client match a
>>>>>>> CB_OFFLOAD
>>>>>>> callback to a COPY reply containing the same copy state ID.
>>>>>>> However,
>>>>>>> it's possible that the order of the callback and reply
>>>>>>> processing
>>>>>>> on
>>>>>>> the client can cause the CB_OFFLOAD to be received and
>>>>>>> processed
>>>>>>> /before/ the client has dealt with the COPY reply.
>>>>>>>
>>>>>>> Currently, in this case, the Linux NFS client will queue a
>>>>>>> fresh
>>>>>>> struct nfs4_copy_state in the CB_OFFLOAD handler.
>>>>>>> handle_async_copy() then checks for a matching
>>>>>>> nfs4_copy_state
>>>>>>> before settling down to wait for a CB_OFFLOAD reply.
>>>>>>>
>>>>>>> But it would be simpler for the client's callback service
>>>>>>> to
>>>>>>> respond
>>>>>>> to such a CB_OFFLOAD with "I'm not ready yet" and have the
>>>>>>> server
>>>>>>> send the CB_OFFLOAD again later. This avoids the need for
>>>>>>> the
>>>>>>> client's CB_OFFLOAD processing to allocate an extra struct
>>>>>>> nfs4_copy_state -- in most cases that allocation will be
>>>>>>> tossed
>>>>>>> immediately, and it's one less memory allocation that we
>>>>>>> have
>>>>>>> to
>>>>>>> worry about accidentally leaking or accumulating over time.
>>>>>>
>>>>>> Why can't the server just fill an appropriate entry for
>>>>>> csa_referring_call_lists<> in the CB_SEQUENCE operation for
>>>>>> the
>>>>>> CB_OFFLOAD callback? That's the mechanism that is intended to
>>>>>> be
>>>>>> used
>>>>>> to avoid the above kind of race.
>>>>>
>>>>> Let's say the linux server does implement the list but what
>>>>> about
>>>>> other implementations that will not. The client still needs an
>>>>> approach to handle CB_OFFLOAD/COPY reply.
>>>>>>
>>>>
>>>> There are several cases that need to be handled. Off the top of
>>>> my
>>>> head:
>>>>    1. The reply to COPY hasn't yet been processed.
>>>>    2. The COPY is complete, and the state has been forgotten.
>>>>    3. The stateid presented by CB_OFFLOAD is one that was reused
>>>> for a
>>>>       second COPY request after a previous one completed.
>>>>
>>>> The client will want to send different errors for either case
>>>> (NFS4ERR_DELAY in the first and third case, NFS4ERR_BAD_STATEID
>>>> in
>>>> the
>>>> second).
>>>> With csa_referring_call_lists<>, the client can easily
>>>> distinguish
>>>> between the cases and return the right response. Without it, the
>>>> client
>>>> might end up returning NFS4ERR_BAD_STATEID in case 3, or
>>>> NFS4ERR_DELAY
>>>> in case 2, etc...
>>>>
>>>> So in practice, we want all servers to do the right thing if they
>>>> want
>>>> to avoid confusion over state. The client can't fix these races
>>>> on
>>>> its
>>>> own.
>>>>
>>>
>>> We are currently living in a world where all NFSD-based servers do
>>> not
>>> return referring calls. I think we need to understand what the
>>> client
>>> should do in those cases.
>>
>>
>> My answer is: not try to fix that which cannot be fixed.
>>>
> 
> Put differently: it is a lot easier to just implement this properly on
> the server instead of doing a load of contortions on the client.
> 
> All that needs to be done is to store 3 extra pieces of information
> when you create the stateid (the session id, slot id and sequence id
> for the operation that created the stateid, i.e. 24 bytes of
> information). When you update the stateid, you also replace the stored
> extra information with the new session id, slot id and sequence id for
> the operation that caused the stateid's sequence number to be bumped.
> 
> Then in the CB_OFFLOAD callback, when you look up the stateid, you also
> look up the 3 stored values and put them in the CB_SEQUENCE op. That's
> literally all that is needed for the client to be able to figure out
> the order in which it needs to process the operations.

Yes, that part is obvious, and I'm in the middle of doing just that.

But I'm not fixing a /new/ problem.

The issue I'm getting at is what to do on the client to handle the
existing cohort of NFSD servers that do /not/ currently support
referring call lists. That is 100% of the population of today's NFSD
servers.

I think your answer is to leave the client CB_OFFLOAD implementation
as it is: it saves unrecognized copy state IDs, expecting that later
a COPY response will match it. That works well enough, but...

I'm wondering what happens if a bad network actor injects CB_OFFLOAD
calls with bogus copy state IDs. Those nfs4_copy_state structures
won't be freed until the mount is gone, and there doesn't appear to
be a limit on how many can be created.

IMO we need to remove that client logic, eventually. I don't think
it should be left in the client.


-- 
Chuck Lever

