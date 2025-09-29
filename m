Return-Path: <linux-nfs+bounces-14796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83068BAAAD9
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 00:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A44B3A6233
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 22:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC09019F41C;
	Mon, 29 Sep 2025 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZzPgQD0T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F516tuSa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D5139D
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759183825; cv=fail; b=Gh1GVPgcRvB7dZcSkOB0eIiiIY/P9baMloRViG3hi+IygIqUwnGreaKBuOgO0vWHM4LrxSaTIW9kN73NkGgfLmfPN0f+FlLnicTXeThYg6Y0Zamc/ygLKs3RJ3Tpy7cXZoGvkW/k8KRGnu+8Tmo8NIGZKIOtCRwC28/M8eEc1Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759183825; c=relaxed/simple;
	bh=zmYnIsupMpPE0eV0TFLOeRpFb/MtnQYC/Zv7agL6Q5c=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ViRb3P/o9hdaStAK58YESBpWAm1gp0BnWSKaHjgl5nkNVJeFQXIzrcE/4Ca/pYeD7FcoMnyi95XHxYEUvlHdC+M+2Y5UayKzD+PHnbVfk7DCeNENkAXwdLcl2iSjDOMSMCn8o7mLDJRN1Ta75w9bdtwdqh6epmnEug4H5n7Qc3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZzPgQD0T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F516tuSa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TJxm78004798;
	Mon, 29 Sep 2025 22:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=abVBuAcTVxOz4O5T0oV55ypx+S2ibj0XGlORihMF/CA=; b=
	ZzPgQD0Tzn1QiCXgQI3zPHk+lX/hWjQvwg5ThitJqCtxiLH0RXc6tTZdonP6f3ux
	B/opZgtji5btYZ5X5aaIySxaBGXmn1E9lc/a0RAdv5sBWif4uSFExpcZJAhIoPyJ
	2V6+z7gCJJWtsKrljTYbB9w+YbXrcyyCNrolh4+eawbwHP94Hg5K1VYcXcS2nVrJ
	YCowtmLbMzi3qCVrRndvgzIXQYnwYGmFt6pXOBJL1J6xhi60QANyf6aNtxXefS2M
	SU9963UJUuI2ziUneKOP8PTZbPN5Tdyeve88LWWKaXMjxf6Ny/ZKt8GPIAq/0oVR
	prDBE9huEo0J9hOiiMwyTg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49g0rjg7b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 22:10:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TJk465000557;
	Mon, 29 Sep 2025 22:10:19 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c71486-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 22:10:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7yhQlgnBxWcySYpeqziXp5fupZ5/H+QR2Z/K9T97pOcuZo6NtlGB1kG6zaiLOUvKJYcGNDpstDyyaboIxRmh9UDQUOFWrQV9i/BwY1xt52HXOPhPlKWrdENalyqHBfr5ntR8++k/tRJdJIubAG64AWomSP1iQS09m4xIfmWlACwL3AmfDraQPl03nvcAgoVWfw7xZFrwBYbm/ieJbmx5hfiG86TvYEU0Q8rKMisS26eZJ5i/EALXss/mlZvmzKw2Nrq56FFaBPFTOxV7mzFdpQT1UXg0GOdED7MSf4t8jWaUMqfu+s5CfAm5iXqksQ4G+zVeV4O/o4G9bXdT/Igww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abVBuAcTVxOz4O5T0oV55ypx+S2ibj0XGlORihMF/CA=;
 b=deIChM8pBB0YZo+QIUjg7rlgv6F/XvoL63hlCuCFPtvdWONzfagjORoSpaTNHspQxVStpefLxY0j5yOnEsBJnIsYZl4/SeMc9FkUXguTjbwuwTNe+I1YDhaYKIzKXH70+uWqlXZKOwR2zxFLUkP6X2hom7ZLTwbvkqYi89d8IDePY14tGzXrCnaxnHv7yZh3Qc/mXaV7ppXW4VFKlVBWgJAvSrVhynnToxk8NVpk3r55DhmHtgrlZb4uXDToc3W9iE2C5Nmtfogz08udhgJwQzcpOCt6VWvBVnjU+hroHO/CFIFW/Mm+sAA+S7FAFlZVEmdBYXs5Ei2b8qVETUC9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abVBuAcTVxOz4O5T0oV55ypx+S2ibj0XGlORihMF/CA=;
 b=F516tuSaXESWmkJaO2JnN+/23SeXOtT9OxjCeUy7l4bqt0E1yV+pKqo9Q7FDCYGFQz0CcsEvIHgamnU4rNdppy3gKUWILKLSQeeg6nGQVIEaMNorRKyrTRGMYyAwVpQH/rZjuBgFLBmP68pqjX26O5dtYJD6w85dlCy6ZYt9ri4=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SJ2PR10MB7669.namprd10.prod.outlook.com (2603:10b6:a03:542::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 22:10:17 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 22:10:17 +0000
Message-ID: <b959ffce-a358-4512-be1d-449be4512278@oracle.com>
Date: Mon, 29 Sep 2025 23:10:12 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] Add some tests for unsupported fattr4 attributes
To: Chuck Lever <cel@kernel.org>
References: <20250929201622.37884-1-cel@kernel.org>
 <d195b486-a351-4ff7-838e-47d97f9ac0a1@oracle.com>
 <f86efa58-3dec-42e9-b992-884fc143457d@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <f86efa58-3dec-42e9-b992-884fc143457d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::10) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SJ2PR10MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fcf94b-502a-409f-11d7-08ddffa4f890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0dTa1JsdFB0OW52ekJLWjQ0enBqSFRsSHpwZUYrR1ZXanp0REt0Q0hxMG5X?=
 =?utf-8?B?T3dGaEZXUnF5V3pPbXlERW5jdXU4QTlsdlcrNEp5ZGNIaE1Jc2F3ekx5Zkhm?=
 =?utf-8?B?bDFFMEZraVVZU0p3VklENEthWlhBcUZQMmNDL21vWUp1MElNQmxGcmJrS2xl?=
 =?utf-8?B?ODFoMVZ3djdSMFVCRnI1MXZsVEpTMnJlOHZROHNZMzFPYlQ3T0ZVekJabU5C?=
 =?utf-8?B?c2Z3dmtrMEZMa0xadzBEQ0QyWHA3TTd0RHVMNmVzdGhMYTdWQmkxSHFMQUJo?=
 =?utf-8?B?U3lTVUhrMFBxRkRqWFNyV2hpcWVQaUVVdUsrYjNOYVZROTN6M2IxRXRBS2pQ?=
 =?utf-8?B?RDBlZUVNRUVMcHFnaFFlY3ZKbU9VUklOa1p2RkJoYWp0bkFQa25aYkR4WmVl?=
 =?utf-8?B?VzZVWjVyZm1GUzMxcXdFaWxiOHVUbmpZSERFVFZ3elhoS0ZSTHJZa3lRTndK?=
 =?utf-8?B?aVBOMkRDL3YvS1ZiZmlldHg5Uy9CQjY5UThwZTlQdGpiL01RZFB0cmFGYWdG?=
 =?utf-8?B?eThweUw2bHArSUdGck5qUkxUc2ovK0huNTBNaENwQ1JtcE9vUUJhUk1rbUgy?=
 =?utf-8?B?TjhNQ2pZZWJZWUlSd1JGV0Ivd0xPUWFMMXBLaDlkbHV4dWs4bGc0WmE1c1Fs?=
 =?utf-8?B?Sy9NR3pVeEV2K0tQN0JQenUwVGdnQkthNzRrekVWcEw5RTlWemxzeHRrTVBI?=
 =?utf-8?B?cmZGLy9MYlR4TnlVeWQvN242TTJHZzZJTHI0cEFIVU02WTEreEFBRmp6bUVV?=
 =?utf-8?B?NTcxQU1zZitmM0V1WHl2THdyVElqZmo2SGd3WitTUlNxRDY3d202ejIwTjRz?=
 =?utf-8?B?NUUxSGR0ZVpJRUFTUGdlMHhQNkpUTHZyckp5dFQ1dGpCUnZTNC91a0hHSEkw?=
 =?utf-8?B?ejJDamxQNStKYVc2enh2THFjTXZBaXV2cmNIZE5GcXYyV2ZDTlJYMk9UazZV?=
 =?utf-8?B?a0hBT2xTbWFZbmgyOUNHeVBLdDhmNU56cFFCbGYxK0lMTHJoR2doNnErZEp0?=
 =?utf-8?B?WW1tNmJoNEVQWkFJeDBKN25FLzB5RU5qVTE1SElhRmhQZFBMenJzYnVFTmhp?=
 =?utf-8?B?Yy9DNnBxRTg5b1owbjZKaU0vT2RzNTNrTWRnSHQyVVR6U212TkNZUHhiZHNj?=
 =?utf-8?B?dXc2MHJRazJyUkdCc2wxS3dXWmRJc1NyenRvaUM5cEdhbWFGWXhwNk9lRTR4?=
 =?utf-8?B?MnJCeWRsU1l1YTFWU1dzRzRGQjNnaFZZT0d0THhpREJGclk5MzA3eWR6OVRm?=
 =?utf-8?B?bzVUczVuSUlQZk9PREpSbGtaK0lHM3gzNXV4bnpPRkw1MXpLa0dmNjA0MTFx?=
 =?utf-8?B?aVdFSnQyTUNzZjJVQzFCZGorMEJ1anB4TzNaTVZyUzdPOVFMbTkyVG9LbXNz?=
 =?utf-8?B?MUEvRWorbTR1cWRmcVlGN2VUNzFUcHIxYlF1OTVVNjRuMXJvaEpwM0lFa3NJ?=
 =?utf-8?B?YTlJRnluVno2dkhnTW5QbG1yb1pGOUNObVJQbEowU3ZPUE91Y3VjcHJiRVZZ?=
 =?utf-8?B?MTNjNG9wbVJaS1k5dlYrUTRROFRtZ21ZekxhdkV3cFREYjZTMWtaa2s1UG5r?=
 =?utf-8?B?TnJTZkhFVTliclJ6V0FXZUZmQ3dVMDlrV0I4cG1SRTBnb1QvTzVJZXNNa081?=
 =?utf-8?B?THNEWFBqWHR2UHZwbGpTRXVKR05ubk1Pdi9iSXlUQWJWVWcrdzh2SXdaODZ0?=
 =?utf-8?B?WXhYbFFVenVvd05uZ1JuZlpkbDhBSUVBWTVtRXd6Z2hBL2k0cGF5dkErNktW?=
 =?utf-8?B?NXJYWDFWRm90TGRSOVBPY0ZvQ2xIam1sZmRMeCtUVW93N2FsakxhUDZDTHZw?=
 =?utf-8?B?MEIwMG9nenE4WEJyVnpnVTdIRTZOOUNKL2R6Z29HOVZmL0FIWU9HSWtJNmxM?=
 =?utf-8?B?dHNSNGJuZFkvc1pWZFhLNVVqS0pocU5pRm1JazFmMFZ0L21NczI4ZzJxblE5?=
 =?utf-8?Q?MacAbJJWgghoG6jQbOmV3VzP3KJVE2VD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEpaMk4xSEdJbUlUMmhUY2Evdm9jMG1iMjZ0ZVFHVGZpSk40VHYzOFBhemZ2?=
 =?utf-8?B?NTJaTTMyZTIzbjN2WFJuZlNBeWpnQXBzMk13eWVUVnJEQTVWTjBUZTlPWTVh?=
 =?utf-8?B?M1lsYXV5OWxBRStpb1hCaytPSkt4WFhaYjZFK2dwK29peXRQdldZL3FVOXBO?=
 =?utf-8?B?SGhXS2E5K1BDbXNxNnoyV0padktFcmd0bGtkd2lscDl0MmxxU3pwbFM5UG9E?=
 =?utf-8?B?Y2NWbTgyQzVySFlvMUtQS3ZhK2ttWWVhZ2dqYlBoQXVxMlo2NStZbmlDeldk?=
 =?utf-8?B?eHNJQURCWEFtS2JJa25xZlpmN0l0cEo4V3RlRFAwWTAyWnZHVUNZbGEwckRQ?=
 =?utf-8?B?YzVlNTdrWEVRK2ZnbmZ6TWJHcFI2T280M0VKQ1c3U3dtQ1lhSjdiTUFPSzB5?=
 =?utf-8?B?UWl5cC9EcldSODJNN1dNUTFxeEJLNnVBM3BqNENsN3h2MlpmWXFVa0orb1NG?=
 =?utf-8?B?SGE3SlpVUk5vZUF2eWl3eDJJWjVvZUwwbUhrWXRJaEwyUFk0aXR2NTdiUmNk?=
 =?utf-8?B?WVRBeXc4TWo0UVdLU0NwRXRmc0YreHc1NU00ZjB1aUo4cEN5V21XTFZyRkVS?=
 =?utf-8?B?eHlHenhSMnRCUEdSQ3lyV0E4SEVUOHRoenZ0NFZleHFiRG1XcEJzVm9HZUhq?=
 =?utf-8?B?cDBiMHNENFo3blNUZUl3elpKMGUxMENpbHc1N3ZXR2ZHQXpDT3NSM05aaEFa?=
 =?utf-8?B?N3Q2em1Ka3JXN0tXOEQxa1YzU1Z2d3dCRyt6d2sxdUwyTDlRMUlxWVJvS0tN?=
 =?utf-8?B?eFdhc0NGMXovTmUwdnpRclBZalVnVVpsMkhLandTS2hEQ05WNXkwS1lzOGxV?=
 =?utf-8?B?b0Fzejg1ejRjSmd2VlV0V2lHS0w2WGVVZXdUekVNZStWRmttd3VSQ3pxSFdt?=
 =?utf-8?B?V1ZyUmpjQmRkSEJtdjNIL3hvejlJRnM3MmwyVjdISDdXYllpdlpIYkR5THAr?=
 =?utf-8?B?NWdqcDI5U3hLaUc2eXpyeWNyMStzT2ZINmU3Rk91dW50RWNGVHFyM003R0xi?=
 =?utf-8?B?MDIyOURnVk1lU0tCRFpkb29kQ2h0RmVEYXZySjRtbytBN09QbmN3a3lHV1lo?=
 =?utf-8?B?VU84eE52SDNjWThEVXluMyszSG1ibnRUTVRhbUNZRlRlSGtYSmxnUzJQVGJU?=
 =?utf-8?B?akwwYjdFaVhDN2ZyYnJkbzlrRnFzZUFjaUVHZjc4ZGdqQ0NxeFFydGl5SWJh?=
 =?utf-8?B?MzhiQVZUSEd0NnJoTGdzamlYR3ZZemp3M2E1RUx2cUtqb2srMGdsSnhYcDBU?=
 =?utf-8?B?ZXUvdGkrT2IrY3lVRVRBV2tYTjZVOXA2Y0pMYmlvQjZYU2syaUpBQ0VPZHNv?=
 =?utf-8?B?OW1nRm9YVUszYjBjS2xjNzlnNUZXaVVxZDVtQ2tQSDlqMjBva0hEQUFFRW96?=
 =?utf-8?B?ZmxobklBVGFwUDhzN0tDSHJuYmt2T0VUSGI2cCtrcUhYUTVmUlpqc29YK1Zu?=
 =?utf-8?B?NkFxaWRrdzlwczVwamE1c0VlQTM5Zk5mK08wWGdCN3d4d0JjUTNoMm9MLzZu?=
 =?utf-8?B?WVdEUm1UZ1kvanFZYkpRWkVYQzZJOHVVRjdxNndGcFdjeE1yaW01WGJYeEdx?=
 =?utf-8?B?VC81SkxML1hnQThMNjB1VFVNblZBSTBoRHBiZGNQdXJOc2tueGxxeHZnTHRy?=
 =?utf-8?B?RU0xWXBPOTJSUGFhc0dOTjRNU3NWdlVOblNtQytqYlVuRnlWMHk2Um53UVAv?=
 =?utf-8?B?RWszRlcrYnkyZEh6bEZHMEc1ZXZhTFgrMTJoUVY1L0g5M2NVb09TQjF2ZXFq?=
 =?utf-8?B?RWdrZGNIWGVmY0FsVDBEQzRNN0tNbThyMW80VmNHczBPRE5pYStobXRKenhY?=
 =?utf-8?B?akNEbEV3OHRkcGtlS3N0L2NidWZOaEZDWEttWkVtS01KeWpvdU5yTURrRFdQ?=
 =?utf-8?B?dlNjRFZERXpYWm5qOG1zak5LaEp5WHFZcnl1aDF6ME80WHBSdnlZSFBwb0NB?=
 =?utf-8?B?VjN2alc0VGRJd1Y2a0NVZGlIZEIwRUpuNkp2SW9Qb3oxYzNNUFV6SDNpMm5k?=
 =?utf-8?B?TWxFbm02UURQODBIdGQ4NE9IbDZWWEZLTzJiS1VMS2ZESVJQMTR2Q05jUk9t?=
 =?utf-8?B?NE1XTmxwWDdKaUluc1M1YkpKVTA1YUFDNThGVElPR3EzMy9qN3c5ZXhpbkRj?=
 =?utf-8?B?djhuMmxZaWlaRXYyUW1nMU5ZY0VyU1lDTm1RaUF1WVZTOHc3UnU5MzFGZWxi?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PrqiAVBatqhiJ9Vr3oWx7BsY9xxswPPnE0ZF+wYX4s0iO4v3UHYgbmzyqjONUcs3BJONtUfKEEdfp9cOMRs0an4phTarbaCCM0ZA3eIG8WOSSGxRxzayG8HUVX5jbkJcitKlaNnGMqMZsr7mpIYlojr8ZrKOTq9/gPF1FnSDYUOeRi3gogsq2Zk4JAlTTUyoCLpOUiVFpJUwNNASeKd++21gLYh53xCw8pKNzEl5HgLdXClHmO4N1iPwsJdZ7G/6/MuGk+Qo4re+gqaqClB5OkUk+e9oCaCjPBuzU433nvm/y+YBWbzEqSFuRPo0LwomKrsMzSEKIlB4iiyZfDqcUexOf05IX3Z/zPhV2AH88oU/iNfrZB4M8ap1IkuNtm1WOY3EYtyxF5QYrKxRMBLU0NltqII54d+L+qKF/H7JbqVc/y8+CR83HtVZHC8DweNnScCtUS/m6bu0bkSck+iHBWRW+OYutO906C8rT9pbPVp643CvlQxhQQ1e3wKQZfZ72yRsj4WkK0z+6TZew2wCl4AbQ/skWeh0zycRTzXtQEjaOYNdPuhzkQUeqwgIfATaGzpkwakOpkwC6e50YtYvTaTos3a+uiicD9hPBBOvVBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fcf94b-502a-409f-11d7-08ddffa4f890
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 22:10:16.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gu2fNSu2UXftr81yMkBSLz8BE2Ri0T39QBqiSmguF+AN3/70ChsOlY2RN/8qW0bRtYDM+fDpvu/YY6fHmqXjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290206
X-Authority-Analysis: v=2.4 cv=ZKnaWH7b c=1 sm=1 tr=0 ts=68db03cc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=kJ9PRQf1KRXTnorPM9QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12090
X-Proofpoint-GUID: pORcwmKvjCpCVjPlQfFEyaKl_Lq5JTBI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE4NSBTYWx0ZWRfXyr7rb2JNhEKm
 INwH5jJVwiPtxG7rdeetZ3rA3a4LVpRMly395w33rH64ZwVW1GSzT77E0PhW/LJ+2A2rzV1rSDm
 oIGeCHFj6euwvkGgT7fammwSB9ecqRUNoPLKlIA7SivxEbPX7N7o/q+oVTYBKF+VMU4aFlJsR6a
 teT/8+FcdU2oowzRy3k6/osLj9W39+rjFXFhCym8yCb9yqbRrUyQzhNTQnNjtHP5BbjGTLFKTGp
 WSMuQ3dEY8Tbw7Dgor6PhlYCUf6/O1nGDnW+V1x4wUaIjeKuwMDCQM8Nak63ydKjEkQ48vHyjVu
 XSjH9++p4ekh9t7L9dV55NF79wpXbKe+QUEvp7ns3MuCXeut182Fv4N33TRHZjqaZ4Hlnwt6pAV
 IasezLZPdRXwdfLDbe8rLBbsuvDfdON/uUXT1YcaXM/mMDL4/qc=
X-Proofpoint-ORIG-GUID: pORcwmKvjCpCVjPlQfFEyaKl_Lq5JTBI

On 29/09/2025 10:16 pm, Chuck Lever wrote:
> On 9/29/25 2:14 PM, Calum Mackay wrote:
>> thanks Chuck,
>>
>> I'm still catching up with pynfs patches; I'll get this (and the others
>> queued up) in asap.
> 
> My patch deserves a smell test first, of course. I'm not at all sure
> this is reasonable or proper Python.

Yes, of course :)

ta,
c.



> 
> 
>> cheers,
>> c.
>>
>>
>> On 29/09/2025 9:16 pm, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> Linux NFSD does not implement a handful of these NFSv4.0 fattr4
>>> attributes. Ensure that NFSD's fattr4 result encoder is correctly
>>> clearing the result mask and returning NFS4_OK.
>>>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>    nfs4.0/servertests/st_getattr.py | 149 +++++++++++++++++++++++++++++++
>>>    1 file changed, 149 insertions(+)
>>>
>>> diff --git a/nfs4.0/servertests/st_getattr.py b/nfs4.0/servertests/
>>> st_getattr.py
>>> index 1c47ebf60571..d423aa1df46d 100644
>>> --- a/nfs4.0/servertests/st_getattr.py
>>> +++ b/nfs4.0/servertests/st_getattr.py
>>> @@ -521,6 +521,155 @@ def testOwnerName(t, env):
>>>            t.fail_support("owner not a supported attribute")
>>>        # print(res.resarray[-1].obj_attributes)
>>>    +def testArchive(t, env):
>>> +    """GETATTR on "archive" attribute
>>> +
>>> +    FLAGS: getattr all
>>> +    DEPEND: LOOKFILE
>>> +    CODE: GATT11a
>>> +    """
>>> +    c = env.c1
>>> +    ops = c.use_obj(env.opts.usefile)
>>> +    ops += [c.getattr([FATTR4_ARCHIVE])]
>>> +    res = c.compound(ops)
>>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(archive)")
>>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>>> +        t.fail_support("archive not a supported attribute")
>>> +
>>> +def testHidden(t, env):
>>> +    """GETATTR on "hidden" attribute
>>> +
>>> +    FLAGS: getattr all
>>> +    DEPEND: LOOKFILE
>>> +    CODE: GATT11b
>>> +    """
>>> +    c = env.c1
>>> +    ops = c.use_obj(env.opts.usefile)
>>> +    ops += [c.getattr([FATTR4_HIDDEN])]
>>> +    res = c.compound(ops)
>>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(hidden)")
>>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>>> +        t.fail_support("hidden not a supported attribute")
>>> +
>>> +def testMimetype(t, env):
>>> +    """GETATTR on "mimetype" attribute
>>> +
>>> +    FLAGS: getattr all
>>> +    DEPEND: LOOKFILE
>>> +    CODE: GATT11c
>>> +    """
>>> +    c = env.c1
>>> +    ops = c.use_obj(env.opts.usefile)
>>> +    ops += [c.getattr([FATTR4_MIMETYPE])]
>>> +    res = c.compound(ops)
>>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(mimetype)")
>>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>>> +        t.fail_support("mimetype not a supported attribute")
>>> +
>>> +def testQuotaAvailHard(t, env):
>>> +    """GETATTR on "quota avail hard" attribute
>>> +
>>> +    FLAGS: getattr all
>>> +    DEPEND: LOOKFILE
>>> +    CODE: GATT11d
>>> +    """
>>> +    c = env.c1
>>> +    ops = c.use_obj(env.opts.usefile)
>>> +    ops += [c.getattr([FATTR4_QUOTA_AVAIL_HARD])]
>>> +    res = c.compound(ops)
>>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP],
>>> "GETATTR(quota_avail_hard)")
>>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>>> +        t.fail_support("quota_avail_hard not a supported attribute")
>>> +
>>> +def testQuotaAvailSoft(t, env):
>>> +    """GETATTR on "quota avail soft" attribute
>>> +
>>> +    FLAGS: getattr all
>>> +    DEPEND: LOOKFILE
>>> +    CODE: GATT11e
>>> +    """
>>> +    c = env.c1
>>> +    ops = c.use_obj(env.opts.usefile)
>>> +    ops += [c.getattr([FATTR4_QUOTA_AVAIL_SOFT])]
>>> +    res = c.compound(ops)
>>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP],
>>> "GETATTR(quota_avail_soft)")
>>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>>> +        t.fail_support("quota_avail_soft not a supported attribute")
>>> +
>>> +def testQuotaUsed(t, env):
>>> +    """GETATTR on "quota used" attribute
>>> +
>>> +    FLAGS: getattr all
>>> +    DEPEND: LOOKFILE
>>> +    CODE: GATT11f
>>> +    """
>>> +    c = env.c1
>>> +    ops = c.use_obj(env.opts.usefile)
>>> +    ops += [c.getattr([FATTR4_QUOTA_USED])]
>>> +    res = c.compound(ops)
>>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_used)")
>>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>>> +        t.fail_support("quota_used not a supported attribute")
>>> +
>>> +def testSystem(t, env):
>>> +    """GETATTR on "system" attribute
>>> +
>>> +    FLAGS: getattr all
>>> +    DEPEND: LOOKFILE
>>> +    CODE: GATT11g
>>> +    """
>>> +    c = env.c1
>>> +    ops = c.use_obj(env.opts.usefile)
>>> +    ops += [c.getattr([FATTR4_SYSTEM])]
>>> +    res = c.compound(ops)
>>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(system)")
>>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>>> +        t.fail_support("system not a supported attribute")
>>> +
>>> +def testTimeBackup(t, env):
>>> +    """GETATTR on "time backup" attribute
>>> +
>>> +    FLAGS: getattr all
>>> +    DEPEND: LOOKFILE
>>> +    CODE: GATT11h
>>> +    """
>>> +    c = env.c1
>>> +    ops = c.use_obj(env.opts.usefile)
>>> +    ops += [c.getattr([FATTR4_TIME_BACKUP])]
>>> +    res = c.compound(ops)
>>> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_backup)")
>>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>>> +        t.fail_support("time_backup not a supported attribute")
>>> +
>>> +def testTimeAccessSet(t, env):
>>> +    """GETATTR on "time access set" attribute (write-only)
>>> +
>>> +    FLAGS: getattr all
>>> +    DEPEND: LOOKFILE
>>> +    CODE: GATT11i
>>> +    """
>>> +    c = env.c1
>>> +    ops = c.use_obj(env.opts.usefile)
>>> +    ops += [c.getattr([FATTR4_TIME_ACCESS_SET])]
>>> +    res = c.compound(ops)
>>> +    check(res, [NFS4ERR_INVAL, NFS4ERR_ATTRNOTSUPP],
>>> "GETATTR(time_access_set)")
>>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>>> +        t.fail_support("time_access_set not a supported attribute")
>>> +
>>> +def testTimeModifySet(t, env):
>>> +    """GETATTR on "time modify set" attribute (write-only)
>>> +
>>> +    FLAGS: getattr all
>>> +    DEPEND: LOOKFILE
>>> +    CODE: GATT11j
>>> +    """
>>> +    c = env.c1
>>> +    ops = c.use_obj(env.opts.usefile)
>>> +    ops += [c.getattr([FATTR4_TIME_MODIFY_SET])]
>>> +    res = c.compound(ops)
>>> +    check(res, [NFS4ERR_INVAL, NFS4ERR_ATTRNOTSUPP],
>>> "GETATTR(time_modify_set)")
>>> +    if res.status == NFS4ERR_ATTRNOTSUPP:
>>> +        t.fail_support("time_modify_set not a supported attribute")
>>>      ####################################################
>>>    
>>
> 
> 

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation


