Return-Path: <linux-nfs+bounces-13136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7225B09578
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 22:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FE65A1C57
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 20:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969F9224247;
	Thu, 17 Jul 2025 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fbJmPhgC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="luo0WJM0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D00223DCE;
	Thu, 17 Jul 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782916; cv=fail; b=RX5rURL7hc4LFuR+Ok02Gv7+zcnhUzoJdvpxYQhQS0tlWpTfXouopAr6zBhuZ4sHCCFJAUI/3YDTK3XJniQqM/aGCe8yGq3EhrRrxsxT+M7M7aAk5/75vv9xBi7E7xcbrvLjvHCmSwlddvntqDBk2Y9Qhtv955RmmFWePrGtChA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782916; c=relaxed/simple;
	bh=oswvMXYIHROJTK9bUaV62Fvhm9Gjhv6v4vmygSl4/7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xb8OcqdVm4nx/gLHtDAhRmr7WO9DBawyf2aWpxcxEwAFolUPMRgV74zs7Led3jhFv7L1cF+Xs/e0IY8fCMvoL8trBrAhi4zmnQeJEybjXojQ0xybIgSqx1PdYhNH3pel7BFuBaPzEd2qUiupgRn7vJNXEcok0A2GUNrjrbhigf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fbJmPhgC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=luo0WJM0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJXuM1014301;
	Thu, 17 Jul 2025 20:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DVSiwmNAp+QHZhmrc1/bfOAI9am0BEq0t4Q4ZGv5T6M=; b=
	fbJmPhgCAKYAWAChIvkCnm9HpCh1K1laD0Z/GGsm8AsTZB0WVitCufHkvzrDvnVE
	UIIsdTfKO1E9KUfjWGcpwg9k635HAqJfF73qlde4KQe/ZzEuitif+3Ko+Z3CO8ix
	u8XK+HP1Oq0YBUbdR5o6TugGNVxVKQFnIuHuBrmJdXmGtLA4F8d8QhN/xTHyUgx4
	mNApmjvvX75K1t3aQvJ8kQUup8XhW1yTtwMVlCHyWvHs0lKIoky3c8+nX7PeUYxK
	lOuP6EZEbTa59Oww0nJGpOj5QtBB5tditfmNp6hYfIE9dMs/knxwGCDtSa/XJOJS
	tln5nVRCx89AS6X4mZlN7A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g3yc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 20:08:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJGOqf013701;
	Thu, 17 Jul 2025 20:08:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cqw7x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 20:08:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xN2lE9ylnUrP6kq7fK7bU7mDCyUDOpQKVLeAH2TNmnwzVd4UOwdY8IqnobMRw93l9mXGOfiGL7CdqV9otJJKTNqdC5av+Hfx/9k/nU+oMVFgNYi7KquKBrw7mMD3zFDEwX8ZZnh5ioqn1MNmf/EhAZ3DTmRbIZWfdLMRS+ogC47rnYIMHxxpZiFlj+/89g29g7n/hlRIHyxOyDrSoooa5uZwHVhC4UPeVUEjh/S12PtnQeKgR4nWtcksWNHD1+rmwthCBXetV/BwGWaBEOJGnNj9Z/blBijurpbus0joeQXDOisz0Kj3Lgkqqw3fuoKulhmA5Lc02iOVhRp5/eNJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVSiwmNAp+QHZhmrc1/bfOAI9am0BEq0t4Q4ZGv5T6M=;
 b=t2PCdVM5lLCURi7eC80zI6d+i17quAQf0WHL6AtR9KsgEgH1xnE6ZXAWn5k2IDT+eMZ7MovYM7FaBLTt16RAbj/CL/RFb6XwUcyaIqqrl4btTV9CejjGRC3u/mifCMVttLbY4IXmZEPfcO3GIedV6gPLMVuePLwJahVV8sB/X/Byfp9pEH7LZo4hi5VIWdX+/AP7OWoBx00yz6pf4W/G/+C7Pc+dEIwB/tcNXh0tl/t6Z8/MbuAKLkkb4JssP1SSjBzj7IiMLFYajHPIjjzOobV81UYcmO/frJlQpnQLdekQRwE6/fdR6zXbXT1yUcWE+g9nd2YjjNXKRE8je4BV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVSiwmNAp+QHZhmrc1/bfOAI9am0BEq0t4Q4ZGv5T6M=;
 b=luo0WJM0UXJgweEBbjCw+tahWOERykZ7K1eqSpiTMBhcY6vzcuVzrPckEQYgmptZrCFBJhq3Z2Zkn3SQ/HmN34AE/9l1FcglJDegrR6aJUL6rcki3cukE997oPmj5z2xmaSDwaDp9NGg3mqKQK4CG9/AdBhKRyCa/x0sRqIEs5w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6595.namprd10.prod.outlook.com (2603:10b6:806:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 20:08:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Thu, 17 Jul 2025
 20:08:09 +0000
Message-ID: <a7f6e186-ad9c-47eb-88d7-64605d7a7854@oracle.com>
Date: Thu, 17 Jul 2025 16:08:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Change ret code of xdr_stream_decode_opaque_fixed
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250717194838.69200-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250717194838.69200-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:610:e6::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 356249d6-8278-441a-316d-08ddc56da695
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V256RHlzck15NGdhM0MreVdpVTRucVN5QW1qcktNdExzMVdsY2FMZTBPMHMx?=
 =?utf-8?B?R3RyaWgrSzVielpST3JEajgxWDQwcHNiOEYwRHo4b2lNSTlTMHNFb0FuMEMr?=
 =?utf-8?B?MW5ITFVlOHZqSWR6OC9hcjFCc1JsT2F2TFE2eS9GbXVBMjZ2NysrTXZmakFs?=
 =?utf-8?B?L1ZrRHVpeU1FMGFSWkUwZzAveDVNK0p4bTV1aktxNjZ3Zm12cHl1bjVUUVp3?=
 =?utf-8?B?THpTZXoxSnMwcC9FZC9GczdSUEN0dW9ZQm1SYzdiSzdrdjBPcGhMeDJnNG9H?=
 =?utf-8?B?SUpuQjZIR0NNYTV5c0pDcUtrYTRYUVorcEJTdHdLY0xIcnNNVkRaZXRyckc1?=
 =?utf-8?B?WXRSbjhXdld4cmVsYWI2ektJRzJWcHQzbEhkZWFsOTVidEo5eXNYc01TVE4x?=
 =?utf-8?B?ODBWTmFzTHp1WkR5b1hNMjVIZVlRZTBWTXZFdmFPbm1lbmczNW9YdjJwaDZ1?=
 =?utf-8?B?WDhrM0gvR3h5ZzE4eFd3Y1FWS1EwOC9CN2o2b25mTWJDOXJ6Z0VsTzRxVktT?=
 =?utf-8?B?NzYyb3h6M2tIMlNTenU3SmxzRnZRMDNWaVBGTml4cXpySUlQZit1c1NkZzRi?=
 =?utf-8?B?NEJrL1FQSC9xMTJGcHZ3WnExV0F4ZFJvVU9XQ3pCNmlkazk4SUczb0xkc1Jv?=
 =?utf-8?B?c28vb09pL0dZZEk4VXEyVG8vbEYzY0xRN3BEdWFkOHFJOGJaVDJZSVFqQnZy?=
 =?utf-8?B?cjdHWU1qYkdJb0lzN2R6djZXaWd5Vk83bFhxSlpacVV0SDdwZWtFWHRQdmZM?=
 =?utf-8?B?MmR3KzdSaElpTlFLYm0xQUhPMEluelVZQWlXWlo1eklDc1Y5SUE2ejVrYWo2?=
 =?utf-8?B?Yk1EVlNaLzBvTldqbGp2TGNNVGpiSmtRSUMrd2YxQk1PTFMyRGRYTlZVeWg0?=
 =?utf-8?B?cVl6R3haM0xiblBDODIzdUcxNjl4V04xVlo4VWFBcFVrTGhaRzJvSUxQR0lk?=
 =?utf-8?B?eTdHOU1NbmdCWlUwNFM0V3Z0S0kxQmxuc2hZbmNWT1hxanN4Rkl6K2lOd0cx?=
 =?utf-8?B?U2FVeGJXaUNZb282Z0Z6cEtUMmh1SThwZGtvU1BSeEtRY3hIb1JBSm1wV3Z1?=
 =?utf-8?B?cEVqbXUyL05WeEp2M0xmSEU3TmgyVExqR0EwN2oxczdLUHNjZHhJeXlHeVRt?=
 =?utf-8?B?UVgxbmI4NXk2TVZDekJWL091WFdtcVRaSXdoOXBNQWNIMk83K1MyM3VJN3dk?=
 =?utf-8?B?QWFnOWd5Z2NCOXVmZ3pyendZNGdSUmRSYWE1TW5aa0NnM1dLUHBtbURMaHlI?=
 =?utf-8?B?QUVLcDByOW1kaUMrRUtJSlNhNUR6UW56LytzOWMvZDc5dCt5MEt2M0ZqTEwz?=
 =?utf-8?B?Sk1oYXBqSlZKUlM0RGovaDFKV0Z4ZkVucG1jcnMrVkkxZm1Tc2pnUFpFSjY3?=
 =?utf-8?B?akZWNmRhaEk4bkhYS3lIZDJOQmZzVnZMYlJMRll1cjdBMEJYU2JITmFzeCtZ?=
 =?utf-8?B?NFFvQTVzM1dyd3pxaEV4ZjVCZi8yNk55bHZwTnhMd09DdERPQUttVW8vV1pP?=
 =?utf-8?B?aWpwRzZEeGRETmlhZi9ZYitaUC85aStqZW1Fd3pHdVB6V29sLzlKRHl5VGM3?=
 =?utf-8?B?VXpGMCttRnc3OTdNNG1rWnZUM3p6WTlybDMwZkhQZDVkVXFPQU0ydnplS2ww?=
 =?utf-8?B?Q0lWb2RLZGFFSk1Fd3hWbldtVXFJdktXclBJYzBPU1FyM1NnZE5kUTNhUVRO?=
 =?utf-8?B?S3kzU3huZjAybFNqemNhcnhkZkx1VkJZWUJPdUFEdm10OWE4enhocStaVExH?=
 =?utf-8?B?aHgveC9hREM4VTQxU1QvdmVnZ0NNSTIxdkROTGJZQkdpMW1lcUJLWFErZkNt?=
 =?utf-8?B?enY5dVhTT25Xcy8wTFhnc0cxeVYrQ2UzODlmZ2k2S3lHMUZGZEYrcFJ6ZU43?=
 =?utf-8?B?eVFPZjBmbEJGQkhpbnR4ekFTS1JtY3c2ano3UEFnUTFrV1E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d0hiWktaR3ZPWk9CeFFGUnBNTUtyUW1NUHovemdTaWp4NndDbzB5WlVPTUNl?=
 =?utf-8?B?Q3dDUGJRZ0RGajdxazVtOG4xZ2V6QzlxM3VIYTJlMlRwUnBkWXJuZXNCenhG?=
 =?utf-8?B?NGNMUGErU0EwbU82NWJRbU1BSGRScmxxNUhFYWRjejJUUXR4ZGV0dUREWC9I?=
 =?utf-8?B?S1FLVDZYVzhoOGdHU1FnMGV6dVhCSjJaSVd2cG5kM29oK0s1SThqQzIzYmxq?=
 =?utf-8?B?YWZxaTh4cXNIVjU2aTBDWEhjTHBmVkdYYjdMWmsyTVE0dWxGWWZDRkQwUUZL?=
 =?utf-8?B?L2Uwdlg3SDNWWkVVK1RKVllYUWtGM1hYOXYzS09HbWZoSWR5UlU5MW1UZVBH?=
 =?utf-8?B?NjlMTkw1RUVjWXVHaENsZUFDV295cnBNaks2cEJVenBxaVBieU05VjNuRnZ4?=
 =?utf-8?B?cmkySElnbzMzekNCby9QSnM2ZXJFOWxpdWpNUnJFb0EvU29LQnVUSWprcUpu?=
 =?utf-8?B?VFpoSUFOMDNobmFCM3NiSHhQYXg3Y2I4eUs4eTd2U2NaejNJNHFTemZjbEEx?=
 =?utf-8?B?TGhrQUFuQVQvZ0hwOG1Db0xiNTlpaXRNcG5JZHhjRjRYQ2FXK1NXUjBqL084?=
 =?utf-8?B?TDlmTXV3a25yRFJqeDFVQktvOGh5QUdPa1JmakkyNG90OXRDSWlqUmdmRE8x?=
 =?utf-8?B?ZUEzb2Y1bGhlOS9leVhrRkh1dTRsQ05LVnBZcmZFeEtkMDFuZzdnOFVya1Zm?=
 =?utf-8?B?M2svazlWNnl2dlNxMVBiUjNVdzliUkJQanhCdE9DZHNrOTJtakRWTG5JREtI?=
 =?utf-8?B?Y1BPOEN0VlA2OFR1YXRwVmErdERQSU9rNCtIaktMRjgrVHcrckw1aitwNTJy?=
 =?utf-8?B?aDQ4cVlTVEFVVi8yakFJSEQwM2JWd0JvSUJKc2MveEFidHprdHI0bWJ6cWQr?=
 =?utf-8?B?UHNHelRYR0NkeWNZVnBqbTNld3MyR3N3bHUxYU1ScGFBWUxVVzFHcGRvRXZs?=
 =?utf-8?B?WTc1NFZ6b3VPWk5pMzNBWGRzQk1VdHA5dlllN05UWUFZVDU5c1F1Z1NPVjVX?=
 =?utf-8?B?MlMyRGxrNmxacUliRFRIQ0wyQ2Yxa2d1VmtZTjVzWXJCa0VlaEF6LzRyWnlq?=
 =?utf-8?B?WW5CbGZpVFh5cDFwSldQRk92ZWs0TGVBR05jZE5BRnQ4ZGF0MC9TQWFQcGto?=
 =?utf-8?B?N09JZTArVXFyYXRVVzF2ZmhTZUZMaE1lNVdnMkxTSzZhOFZheDAvWldIZGVF?=
 =?utf-8?B?bGs4M25FUVhvS0ppSXZMVEVpN3FTakZrVjRDMm83bi9EaG4zMDNDczlXbU1a?=
 =?utf-8?B?V25naWdkK3p2Qk9NanhlTTVXQUw2UUVaUlpjTllZK3JnWlExWVdrMkVQUEJU?=
 =?utf-8?B?SHJiVkNUckMwL0U1cUhPZ284c0x4UGhEYXlGZ012U2V6UlpIa2NrMzFmMnBZ?=
 =?utf-8?B?Wm9Sb0FwYWUyeUFlRFowcmVWMFpYOWlFNitLTC8wUmhmdlAvRG9JdXEvbkdF?=
 =?utf-8?B?Sm5zNzdIVW01SE96K24reENoWW5DdCs4SExaZXhKc3dCVDlHTldhcm0rQTFV?=
 =?utf-8?B?N0FvaEpIMFZWY0tmREJVVHFrUmJSeWRnemt3cEFlVU9RNmMyRUhoZXM5SGdt?=
 =?utf-8?B?Z1YvS3Z5VkZ0eCtBdVU4N25PZ0FhbXdrVWppZ0FDUVpFWVg1cUZ5ZjlhRk9z?=
 =?utf-8?B?ejN1c0ZybG0wREptcm1KcTh5TGNhR0Vaem5ZdWlZcURXRVRyYXA2d0xhOEhF?=
 =?utf-8?B?VGh1WXY3WTMxR0hwZG1heHFkVFd6b1JBNW9kSVZJRHVBNEt5bnV5VWcraXly?=
 =?utf-8?B?M09wblgva2JMUEFYNzExanhPTXV2aGR1RmNVandua0tEbGxWeWlNWFNPNXh2?=
 =?utf-8?B?ZGxYOUw2U0JVdlJDKzhHSEQ3WE8vU1BOQWQ3dkJMWEtFQVJqWnZtb1B0SFN6?=
 =?utf-8?B?U0dSMnh4K25UbmZ0a3B4b2xCY1pranlFN3BGU0FOTGc5dUdzUzVIYVB6elJT?=
 =?utf-8?B?OHU3T2RGUEYvdmRRUjJBNnhJbkc1bWlrNlI3dFJMVW53TXdKZzFKTlJjVzJW?=
 =?utf-8?B?akFvblJiWFpDU1ZkRUxkS2VoVnZmWUEyeGlWcFBhMVRCdXpVZW9JZmhPTUN6?=
 =?utf-8?B?NmwyNHNKMHo1TkUrUE10NWdlYmpDc2hwTTZVNDRrYU41WVlrZmhzV3Q3WmZZ?=
 =?utf-8?Q?1uMaE3stqocKEYEtKduAZhlKn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r0eyFf7miehwhPwFgBqLXzr8Um+GQDT9xuKL7IYuUf2RHJxv7Okb6CCsUU/IBwut5FGYXhrglBKdOwYarhScCdAhk17X1tEjiX6Urfj/BviyWAtjJimrCZtDWdNJVZi81QsaP73Zq/bP2q7bxsjfdCB7/bklj1cqClAv3fjfKElmfWsPLGCsAbo/7wQmSDOg4xo7huNW4NDwhfMffrcrJGyL7vtRNsT1SN5Zr0WbwKiG5MLlew4rgQlLl8YdMVgQScCY6k7FFQqjHFaB6Bi7u/+oXWl+KMrW1vDb5Gl3qLemjkqw4ls3iUM0+nbxjPRWdjE/psXRhT9AgA/m1k0ePARuouTagFkJY+kkZGE8OKsXoqSg2gGxT0bd/s66KQfcjIVo7Y3JRPk0CeqWL3VL6gfICjtHijnM2LLzL6VkYUvOYk5EgXg1piheaff9Gl56F/IV+9txns3b97+LKo+bS/O6VsiVZnat542ma3JSaCE/N1EPea9TFqV4pIcIIEHVEzZFHLd29MywiZ0BxBIOee9fRT52T4+4GmoEGfvrZo/XF/KATFJDmpgIlqWWim+azAo22zmP4ycUMwb63rkHTijduC+481Hnj4il3iZpX/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356249d6-8278-441a-316d-08ddc56da695
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 20:08:09.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpjvZolzaIqoy35pLLZYoAnt8CynF8AZqvs+omb+Y6NivaHHE9zbSzNs0H0w+N/mslg7pwIeXRcKCc/qyn1CVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170178
X-Proofpoint-ORIG-GUID: PozYfqhNgytZSEJVIFNR-_X9c0411Ooa
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=6879583c b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=s_CSz9ZlJ872RXBRVmoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: PozYfqhNgytZSEJVIFNR-_X9c0411Ooa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3OCBTYWx0ZWRfX/o8P88NwHe9Q hTUNdgVYrw3BlQhaGCrw3OQ2I8kKo0LdpcDCSDnOguFic77A+jcyF0nPsZ5qECwed9Q0n104bAT 3ssIRT14dWl1hJdTCxIWqg2K0y4SEeNOL8NfmQLReKa9wGkNOiWlwvO6msC8fs0n4Bu6v8vciGL
 +x6LI6QGAPYejnkCqmWxmmMFhqyu0uOMTFO3VLsjambirh6iBCGOcm2d/eerlynrnBuCCP6fSMw XG7hSb71/LBDTmxEa0tRGByqXX5BQryoq2wIQIrB4zsTDGfEJrdIGcA57Zo0C8cQSVItRE0rpgg hcxgbaO5tvDjbCrPrOgg3N8UMdkJFaS4RJeEvpIZfY9CqFlpyQwz+8AlMmKxZ8ksND/x6MxfylT
 ROaOdWzRTR/3FSOHvmc67vt8TvgHnS/iGIPiiIr4EDJPlYDUva613NypRCGCX0gEdDXvsUsW

On 7/17/25 3:48 PM, Sergey Bashirov wrote:
> Since the XDR field is fixed in size, the caller already knows how many
> bytes were decoded, on success. Thus, xdr_stream_decode_opaque_fixed()
> doesn't need to return that value. And, xdr_stream_decode_u32 and _u64
> both return zero on success.
> 
> This patch also simplifies the error checking to avoid potential integer
> promotion issues.
> 
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
>  fs/nfsd/blocklayoutxdr.c                                      | 2 +-
>  include/linux/nfs_xdr.h                                       | 2 +-
>  include/linux/sunrpc/xdr.h                                    | 4 ++--
>  .../xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2 | 2 +-
>  .../xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2  | 2 +-
>  .../xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2 | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
> index 266b2737882e1..2a4dcb428d823 100644
> --- a/fs/nfsd/blocklayoutxdr.c
> +++ b/fs/nfsd/blocklayoutxdr.c
> @@ -157,7 +157,7 @@ nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
>  
>  		ret = xdr_stream_decode_opaque_fixed(xdr,
>  				&bex.vol_id, sizeof(bex.vol_id));
> -		if (ret < sizeof(bex.vol_id)) {
> +		if (ret) {

I've dropped "nfsd: Implement large extent array support in pNFS" from
nfsd-next because of the number of (minor) issues that have been found
so far.

Also, I think this patch needs to come before "Implement large extent",
and so does the forthcoming patch that moves nfsd4_decode_deviceid4().

So, please rebase this one today's nfsd-next.


>  			nfserr = nfserr_bad_xdr;
>  			goto fail;
>  		}
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 67f6632f723b4..dd80163e0140c 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1863,7 +1863,7 @@ static inline int decode_opaque_fixed(struct xdr_stream *xdr,
>  				      void *buf, size_t len)
>  {
>  	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
> -	if (unlikely(ret < 0))
> +	if (unlikely(ret))

Unless I've misunderstood Dan's bug report, I don't think these
call sites need to change ... The compiler should promote the
naked integer to the proper integer type so that the less-than
comparison is still valid.


>  		return -EIO;
>  	return 0;
>  }
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index e3358c630ba18..ffb699a02b17d 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -730,7 +730,7 @@ xdr_stream_decode_u64(struct xdr_stream *xdr, __u64 *ptr)
>   * @len: size of buffer pointed to by @ptr
>   *
>   * Return values:
> - *   On success, returns size of object stored in @ptr
> + *   %0 on success
>   *   %-EBADMSG on XDR buffer overflow
>   */
>  static inline ssize_t
> @@ -741,7 +741,7 @@ xdr_stream_decode_opaque_fixed(struct xdr_stream *xdr, void *ptr, size_t len)
>  	if (unlikely(!p))
>  		return -EBADMSG;
>  	xdr_decode_opaque_fixed(p, ptr, len);
> -	return len;
> +	return 0;
>  }
>  
>  /**
> diff --git a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
> index b4695ece1884b..ea9295f91aecc 100644
> --- a/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
> +++ b/tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
> @@ -2,5 +2,5 @@
>  {% if annotate %}
>  	/* member {{ name }} (fixed-length opaque) */
>  {% endif %}
> -	if (xdr_stream_decode_opaque_fixed(xdr, ptr->{{ name }}, {{ size }}) < 0)
> +	if (xdr_stream_decode_opaque_fixed(xdr, ptr->{{ name }}, {{ size }}) != 0)

Ditto.


>  		return false;
> diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
> index b4695ece1884b..ea9295f91aecc 100644
> --- a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
> +++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
> @@ -2,5 +2,5 @@
>  {% if annotate %}
>  	/* member {{ name }} (fixed-length opaque) */
>  {% endif %}
> -	if (xdr_stream_decode_opaque_fixed(xdr, ptr->{{ name }}, {{ size }}) < 0)
> +	if (xdr_stream_decode_opaque_fixed(xdr, ptr->{{ name }}, {{ size }}) != 0)
>  		return false;

Ditto.


> diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
> index 8b4ff08c49e5e..bdc7bd24ffb13 100644
> --- a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
> +++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
> @@ -13,5 +13,5 @@ xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ classifier }}{{ name }} *ptr
>  {% if annotate %}
>  	/* (fixed-length opaque) */
>  {% endif %}
> -	return xdr_stream_decode_opaque_fixed(xdr, ptr, {{ size }}) >= 0;
> +	return xdr_stream_decode_opaque_fixed(xdr, ptr, {{ size }}) == 0;
>  };

The existing comparison will work fine. But "== 0" will match the new
return values better. LGTM.


-- 
Chuck Lever

