Return-Path: <linux-nfs+bounces-12717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00283AE66CF
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04263AE584
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B42C17B6;
	Tue, 24 Jun 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zcqu2cFa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z0Qs0Q+L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116C2C3253;
	Tue, 24 Jun 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772492; cv=fail; b=itD401icq+yZRZN+Mf/QiY94tsKVQib0VzhP5SjW7H5enYCn+LWmS18L5l0H6FPVUYCIAyAf2VKqbM5wVJjdDPYVhUv8vaT4vPj7I6PthS6QBhGwQAfI//q2tPy9ru2HnMDqDq/rZqophEfWXw6UxTMTE4UR7yLsuMQlApLLJvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772492; c=relaxed/simple;
	bh=VTsPer6bCMIXa40MOxkkEfdvNSi6QOnfaUK3UkMj+Ng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FuUg5YvpU4Ghqivd1c0DuHgcU6aKStyBBqlAsVffAyb4WplGRZCVeLtBrR5DVpYwCx6N2jiM3HDmfW//uQXJI8lV254Pfq9TXXn3yP2PR98NcdYFO1M9BjutgqvdorCeBtM4t+/DFVPtAmvmCiQtb+bTvOUqEIT23EGw05qNXgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zcqu2cFa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z0Qs0Q+L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCiEqc025819;
	Tue, 24 Jun 2025 13:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fi1CYO1rY7ZLaEiLEkzaVxTeaQmqFz/SPzXVmL0EbX4=; b=
	Zcqu2cFakv5NOj2HPIyMgueycmfK0AgStW7to5iu/I9SgUNI+unJeQ2JXwbwD4Bf
	sAGTa8VY+L2s/xcLNCpVTZhGRRA8tFPGmZD9Bkhq2lVcbfyICKwcgNUGcQKQpMj1
	GmO8hcBKczYsx/2tHMnpns4WXmteQHF9M94h58+ODqWybgdTmYYgzW4HTN9y28hw
	D8RbdYcDxp5yWRSY8p2lLCCZm956GFp263r2PUmKLdyJhhEYGd9yth4fmIRGyM3I
	TJ9kaJDPkt47jXOJmkzW3ylbr0fCgNhk/DiUiyQzklnMkYdVNQan7zkuWWsrQ6tG
	eEypigpRQUShnqLOFA+ygw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7uw67k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:41:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCTw9v024331;
	Tue, 24 Jun 2025 13:41:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkqnpwx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:41:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP+odhodeKDYpfCqoEIrbxwJcJ77rJOkIA5wxuU3SqVb1S6e5KcZ0C4CL2W2Ut3a931SgTNc+9V28bDYXGaaHaP57LJ4FkfhWm01QHjm+ufpTJaWBRfbzEnF8JvLmceCnQFOynU9LkdPPgkJLI/fPXfCjcn/7gz8ew6VmbxMUmphSbztVA/D3M0lde+62CZcHZVPksIDPAE9vi3BSvp+ir7e0PzZSKtBJ736i2F93/8OOEXIXx3A7u61aAGiPqlZpLWoUI3rh/cXI8TUfVJv/RGgK4djDUhEfF065sqellnUt9VoyfpwEYM8hQsOUxNBZ4uCco/TUop9We0s8/xY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi1CYO1rY7ZLaEiLEkzaVxTeaQmqFz/SPzXVmL0EbX4=;
 b=zHgb3iKU4ZI5xsEr1GMi9qo9SGVr8iiNFvq0Rq5v6EQzh7hDY07SFXSsrOiL+Qqa5uVCaFpcNB98Zq4yzHSdi5LHdYxtnV1HcZQLt4ia2A79Rn9MVie84lDu5VS8D1+VTVsBhrOF9zg9xRGw7FPEUDmvCLGgkSgplzUyushQmJvIASDGwvVZGD33qjkC9Ba3AlLMKwCSVQbrpVU/KqxqqzWKb9dwajAgmOMwQ4Eb69Vh0x8kOwwfEmZL+DvTpa7sZEErCsvrZO6RINBZoCM7Mbjd7qFiZrLfrit+e3i6FG5zDEOoexiSdvxhnFdc9R2ZSwRM9dLIEAckYvgSzNQSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi1CYO1rY7ZLaEiLEkzaVxTeaQmqFz/SPzXVmL0EbX4=;
 b=Z0Qs0Q+LP93gMNFD2enGs7g13aVQUqIoio6H6ch3eMEBZ4t3xcF/T26S0lPu2U5V0Xkz7gdG6K6GCnAITQ7itr2qmjpLKjrogDxCGYoniXHLaOcV3XxnI+q5Xklf8tL5YH0dJLbdIQVLy+KodDXTSXtThzdAWmYqtApUP9xanmQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8099.namprd10.prod.outlook.com (2603:10b6:610:242::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 13:41:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:41:15 +0000
Message-ID: <13630a14-d1b9-4c38-80f8-33d2de2ea00c@oracle.com>
Date: Tue, 24 Jun 2025 09:41:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
To: Su Hui <suhui@nfschina.com>, NeilBrown <neil@brown.name>
Cc: jlayton@kernel.org, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <2b28f725-03ae-4666-b13b-817cd74ad82e@nfschina.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2b28f725-03ae-4666-b13b-817cd74ad82e@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:610:4e::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f269628-a75a-465d-de79-08ddb324c9fe
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WkdVUGtKVDFjc1lCYUE3TkcySGg3RWJIM2tzOXR2bWN1Y0dNdkJ2Q3ltR0Rj?=
 =?utf-8?B?V0xIeFljOGRHRWdzMWNBb3VuSWtEbVRZY1hDOTJ0YWU0bVE4R1N3SDBIdkVu?=
 =?utf-8?B?cExOV2hrbk9ld2dDeE90NHQ4b2VaeHF1bVV6clRIOFM4T2JrZVFXeHJmYk9V?=
 =?utf-8?B?RjJRd0trbi9GM3Q3NEljZXd6U2tkTkN0VXEzTS9LQ2gzTGlPM0ZZSGFuUTgw?=
 =?utf-8?B?S2Q0M3BiVDY0dXlPTEZWZURvcVUyMmMvL2J1Uk03Qzdha3FWOVdrZCs2OGNI?=
 =?utf-8?B?dU5vbkh4cW5hcmxpTUwrTlVnVEp2UU52a0VzVXBLazNscnQzVVBwUGVUMzRo?=
 =?utf-8?B?NC83L3ZXZE1zSzB0ZHRlenJQU2l4aldpR01RNDNvbHR0OVdpR20yUDE3bkcz?=
 =?utf-8?B?RFZaZUpESUc0eVl5aWhRUndpK1paVUFxSjVJUmh4M0ViemxkelRTdVZMRWNo?=
 =?utf-8?B?aVN4REZZUUZhWktUaU5GLzVkQmNQNU9BZTZLMVJCOFRCak1LSWhnUlIySEg4?=
 =?utf-8?B?OG5OeDZ1K1F6eGlhVzIvNnlTaGdiMGVrVnV2UENhOW1VNnNjMTVyTitJV2l1?=
 =?utf-8?B?L2YxY0tZYjNOZklKWTJXWG9PVnkvZGRZaG5KdHFiZjhBOE9XYk1nd2xWOFdz?=
 =?utf-8?B?bm41b3FYUnRqam5pWmh0aFArYTFaSUtNa1d1VDBTUDA3RnhhV2owRlhTcVpY?=
 =?utf-8?B?NHdPcU1sSVJpK1pLWmUwelpSZ0w2ZXRyczRzQU11QkpNVGhFTVA4WC90eUhj?=
 =?utf-8?B?M1EzZHA5anV3TGlwSGU0QjJVeXFlS2dlbWhZLzc0Y0tYOVZKWUxsbjIvdW1L?=
 =?utf-8?B?Zy9PclpkRHJlT1NsejYwZXplbVNrOE9tb0xydlFBQXFuSWN4dEh2eG00ZzhD?=
 =?utf-8?B?dmxaUHRHQ0oyeE00UjZKYlFpN3A3Rys0cnVmQkUvT2RTc1daRjdBWXZmT3ZO?=
 =?utf-8?B?MFlSM09NL2UyblB0NHZOZHVyWGlxWHJicHdsd1Q0eTZDK3pIQk8ya2kvd250?=
 =?utf-8?B?ZDRiemcwYkY1cHVJWENRMGJjanZtK1djOXhpSmZBd3dUQWNGMThuWTlJZWN4?=
 =?utf-8?B?ektOY2IxelI3STBQZEJqSEp0Q0xzOGpMNlg2U29qYVB5cDBTYklLVmZWbzFw?=
 =?utf-8?B?RmhVVGxOQlQ4aVJxdTZKNnZMQWY4QTVJbkpWd2RMK21JSkxONVZWUzk2b3hr?=
 =?utf-8?B?NWR4YWFHQlRIalJ4L2RudEFhY2xwaVpSRmdMWTlzUnNVME5GOEZydFBLd29n?=
 =?utf-8?B?WmFPdDR6cjJVYzEvSEpnTFpoMnl5eENlb3F5clFjMDRjN0x0ZVNSOFIwUFha?=
 =?utf-8?B?RW5valJReDBmcXYrOWQrVnEwWnJMNUJFM2NqTWJvN05pbEh2cGJRak9VcFJO?=
 =?utf-8?B?QVFQYnM5elZiYmh3Qi9JVElmdXZqM01LVjNCTzVScHc3RlIyNEQ4MEFmM3I4?=
 =?utf-8?B?RGRzQ3gvNDAxb0JRWmxYUWJuYlRFbzA1cjRDbXpaeVRMRnpTRHl3WStyOTZP?=
 =?utf-8?B?K01TcTlWaFAwRGxuRHd6cEU3d1BoYnY1Z1Q0bU5uOXZmOGNBWjlTeks4RndS?=
 =?utf-8?B?UTU4U0ZVNDc4VXNlODRQb1I3RU50VzhjdVkzOEtBYVE2R0IvbmQ3alltc3Ex?=
 =?utf-8?B?Z3k3MDFINnFneThrbEtOL1I2Qi9ZMFdCc2I5NzEwZ05hTmFxTi9VZzdVaExT?=
 =?utf-8?B?NFl0MlBkL3BHd29YbnVUYjgvbmN4VGtJS3Z4MEQyUHc3M2o4SFR1ZFRaenhE?=
 =?utf-8?B?YnhjbWVzRjJsRUlSazFtTVF1OHV3VGpZSUozaVBWb1ZQOFFvK3k1WDVNTHdl?=
 =?utf-8?B?ajJKdTlNTTVhU01ONzdlZ1Jyb1hKMUVLRi9pZzFLMDFUbldwZ1liL05GMkJm?=
 =?utf-8?B?UUFqWm11VmNNM3Y3S0tQMW5HdFZwSDJjNTJwZ3J3S3BwNzVYVnBsU3lMN0ds?=
 =?utf-8?Q?gBkS0hJ+xXw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aE5aZDRmbldmN3RpRG1ockJzb3pjRlNiSkRRd1U4RGhjRlo3aG9iakR6eU9M?=
 =?utf-8?B?TklXcTBrcTNDdFBNc0Fia3Q4R3NkYmltWWtGUjNmdUcrZWlCdElOaXgyM2Jr?=
 =?utf-8?B?Sk12SEtJNTBZZWs0eGU2d1lWTEFPL3VFamZwQWhNTlJKT1dSZHR1K2F3VlRW?=
 =?utf-8?B?clBzRXB2TzFkYmwyZnJUcUtxNjV3UXcyVlkvWTRoUnl2eENYMHdISlJ0bVNE?=
 =?utf-8?B?Y3ZxcjZ6N0lCT1g4SHI0OGQ2RkxKNHVoY0U2aWtiL2duMXFIaGVNT20xbVBM?=
 =?utf-8?B?STNIVFl4QnoyQldmT0YxQ2MrWmsvZFlsczBGck1CTHJJZ0k0eURRazNiSjdH?=
 =?utf-8?B?dVROMjBlNE1QYUQyYlI1RWV4d0cyMnZNVExQZHlWNHkzRHl6clAvejFaYnpB?=
 =?utf-8?B?d0NsRWpOUHZFanNEcm0yRzM0bEJWSEM0d0g5WVBQWHdMUWc2QXRxTCswZTVy?=
 =?utf-8?B?MnZCcUEwMC9vQ2FjS01VQmozRnhyT25YTGc0VDVRclpjU2Q4U1NKdEJzNkV0?=
 =?utf-8?B?WHUxSUxkbC9LSW5sQXpBUFZBY043TlZ3UlRvRzh5cXIvRHVkaDMyWGtCUld6?=
 =?utf-8?B?dStoa0FQQWhqM0ZrWDQxYU5Va05Qc1Bnc0p5VytXZFUxTWFTY2dXWjhpZjNx?=
 =?utf-8?B?VDgrdE9iNXYwRUN5Zk9WZmhWSllubmdxOXQ5UytlZGVFenNnQVl5NW5jOGx2?=
 =?utf-8?B?OWw3LzNjc0NQTjR2ZTlpVGM2NlRPNEdWM2UxWDZqYi9VSGVWR1ZwQVJKTmpT?=
 =?utf-8?B?cnlTbGR6VEJrRmpuQ2Zwd3dJanF5cjQ1YmxLWWxVRlJRMXRDWks1dGdaZXR1?=
 =?utf-8?B?NVNiOGRSeEZ4TkNYbTh4azM3U2pyMEhvZGJ4bEl5KzR6K3hJOFFnYlpwVzBH?=
 =?utf-8?B?TFhxQzBGTkpFT0YwQW9DS2c4TW9tak9aeEw5WUw3dGxSeFdEcExMSnBlMzRQ?=
 =?utf-8?B?UGg1a3F3bVVxem5IQjVQTmp4ZkEyN2dSWXU0QjNJVnhRTzcvY1orNmJKdGo3?=
 =?utf-8?B?S2cxZzRFNGFLS3V3ZGRKY3JWeTNmcFJpS3VUU3lMbm1qanNrTHRLU1AwMUtU?=
 =?utf-8?B?OE1HaWJ6dGg5SFl5TWgwckZFcXFVOGxTNDFwUDNBNWxFOEhVemdYeXF5cWNU?=
 =?utf-8?B?T2NvS1A3akk0RmNUOTV3T3NuRThTUGJaSVVVeWNHSUVqeWJKYkwzUE50dFRP?=
 =?utf-8?B?OHU2VCtiN0hzbWZlanNVNm1ndWxldll3cElOT3NPUGFlNWhKZm45WUpvSjFX?=
 =?utf-8?B?OERETXl3WDZkeS9vZnRienFyTjNMZ1VzL0JUUHkyTDMwY1NTc2VadThwWisr?=
 =?utf-8?B?MHhDSENyclg5L1RVeURCQ1FGYzJtK0s1ZERadEdIVXppWU1IVm1TQlMxc0Vx?=
 =?utf-8?B?Tm9FVVlYK1VUdFZoM1BrMk1lMTNmMjJGQ3o3RWdCcEVYR3Y1VFI1TTRpM0tv?=
 =?utf-8?B?QitqeEcycXZiT2Zhc25DTXgzYWxSUlhtSjVjVW50ajdra0M0Q1ljd3BKSlJE?=
 =?utf-8?B?dGhrUG4ydVQraWFsTWQ1L1oxU0RYK2JxdFlVTVFYWUxKcVQzaXA5bWVSemJW?=
 =?utf-8?B?dzYwS0hleVg1UVZNcEdYb2NQd3JiVWxpSWo1cHZIWGF1N1BBRFBwQzdLR2J3?=
 =?utf-8?B?VzdoWmJrUHk0ZzQrTjNmRGQ3alFMbkdYV0d4dVZXTlZJUlpNaU9rNTZvRjN5?=
 =?utf-8?B?Q29CeXhzaXNDY3U0UjQvWmxPeXVNejRTTHpPNksvYkQ4dEJtNW9IZWRRcFZY?=
 =?utf-8?B?ekVBVGNkS0RJRGl1OVRHaURWZGRwdXVSSWJZVjNKbmxBbG5IN1RJMFNVWTBK?=
 =?utf-8?B?SzhRZ1JSU012UjRIeFgxNGl5Rm5aYlBwTC9jRmxWcXpIdXNneHd3VjZoSnFP?=
 =?utf-8?B?cFZ6K0g0RDlpWGJqdXZyZlYyU1Nia0NzN2k5WVloSnlCTURqem9mVkppVWxz?=
 =?utf-8?B?Wi9oMW9MczdGVnV0cXh5MXRFRDZqSi9xRjdESDJzbE9zWGNVNHA5MUhPNytr?=
 =?utf-8?B?ekZZNnJVcGJkaDdabmNZN0tyaVlMcTZ4K0hZeDdkL3E4Yzc1U0xRQTdkc3Vy?=
 =?utf-8?B?eUpvSVhhNlhwaTRYZHcyT1NqSzBTUEd5c3FnTWNDejhzRm9xdXdmNm1DeHNT?=
 =?utf-8?Q?+V64vLWIrS/2aSTHJeCRMK9od?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7zxEwTeV8NfkxYqP3iKXoeJkXUhqe7NxH5r/1q/wyQb3ecNGViwCPLTu3lTz8qwtGJTo//0PdtTLBXkGYPGiq4KZ+pWpCcrGsFA96LxG2zqoY0mZPWr41phxZqllkV3UNEF3EdkXo3vOxEiyE3tqdISkM50/F574mOwvZ75lbmzXybHAzNQjAQgEO/19KMuIvrmS2L1thjhYuUGD8lugjDOKGmiYdtetV9XloKzj6iZaL0aVuYb0HJanbP3GT0ZQzib0UWxC18AdAHQehEEJgW5ZTkdTrMByYjRcttjWmbTzUC/G4IAAYS8oeue+wgzwnGbmz31+jQ0mzIzGPQlDtbR60F8VSgkozXo9k5pZ2h/H3NVynfZRigzgwhVVTElHaiJ6bUO0HKLcAEthS7gsDk0mFUDqsRemS+PNQln6cUfsFMix51acDfbqpRsgjNjn5J10tEklXueF0oTwzCkD0iTBDM4zOkTtPvuUO2WAJKW5PpSZtLmM26m/YTSR+n9so6f2fz7DmXfjt1ETqH13B+Giu+Rb6tnOykoVnkhh4dGwF7YwYIM61ZO4Qqk1f653Sm131gQ1zKTP7tC3/hHpI+nY6tz56/DPZWmpYJY0UE8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f269628-a75a-465d-de79-08ddb324c9fe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 13:41:15.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jy6bLFM56AahPhVhJGdvwqwdMmDjPw0NdaoB3bOjOOG/AX1jtezAQ2AK4sUeBCT/BKnT7XmpWrvSuHbI1jXhcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=816 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240114
X-Proofpoint-GUID: 5tVJvUuyrl-8091THKbVaNBhVUoKxqRO
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685aab00 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=SlVAvriTAAAA:8 a=Y6EkqQ4tyzyAm07dvI4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=qesGs21RGGeVIEdTuB6w:22 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: 5tVJvUuyrl-8091THKbVaNBhVUoKxqRO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExNSBTYWx0ZWRfX8HsNhAifHIG5 qMNOO/5Y50k1aCNa1ORtM8eGpIDD981b4Xl4nu1+kUHwyFoXK1rvrLZHJRawz3snqe4oGaT5KFx 3jqytOpIcaqXAVtJ0RgjsJG0JeBaLh+uhMej/dUIm2tuIsNNdx6qX6Jo5xqaa2JHXLE5/08RHX3
 3uuJVYR/N6WfY2v/OgJMpQ0Ea4Iagyv9WwSrsxmuI7f4L6LsdhOnEQKr5dvhIoJ06GNNrEU36e/ Vh8VvhTqtNvPb8FDDTkZ/DKGuIma1BHlJhzBqwdpI9/5W5gDyExkNdkkvRw50bI0cgyD/uJ8iSl XqbWy0I+yC1orDJlHCNG8ZxytfIpcPeWqSuyZqSje6s7YqlxaBL/QuHwE8EhGE6aK08ltMmNFP4
 NecGyQaCW++vKChd2MXp/uI0YTgd5rDK7UigxKkZp2b37EjN/uNhYtjNe9pCBjMuZaIm2Ie+

On 6/23/25 9:31 PM, Su Hui wrote:
> On 2025/6/24 08:19, NeilBrown wrote:
>> On Mon, 23 Jun 2025, Su Hui wrote:
>>> Using guard() to replace *unlock* label. guard() makes lock/unlock code
>>> more clear. Change the order of the code to let all lock code in the
>>> same scope. No functional changes.
>> While I agree that this code could usefully be cleaned up and that you
>> have made some improvements, I think the use of guard() is a nearly
>> insignificant part of the change.  You could easily do exactly the same
>> patch without using guard() but having and explicit spin_unlock() before
>> the new return.  That doesn't mean you shouldn't use guard(), but it
>> does mean that the comment explaining the change could be more usefully
>> focused on the "Change the order ..." part, and maybe explain what that
>> is important.
> Got it. I will focus on "Change the order ..." part in the next v2 patch.
>> I actually think there is room for other changes which would make the
>> code even better:
>> - Change nfsd_prune_bucket_locked() to nfsd_prune_bucket().  Have it
>>    take the lock when needed, then drop it, then call
>>    nfsd_cacherep_dispose() - and return the count.
>> - change nfsd_cache_insert to also skip updating the chain length stats
>>    when it finds a match - in that case the "entries" isn't a chain
>>    length. So just  lru_put_end(), return.  Have it return NULL if
>>    no match was found
>> - after the found_entry label don't use nfsd_reply_cache_free_locked(),
>>    just free rp.  It has never been included in any rbtree or list, so it
>>    doesn't need to be removed.
>> - I'd be tempted to have nfsd_cache_insert() take the spinlock itself
>>    and call it under rcu_read_lock() - and use RCU to free the cached
>>    items.
>> - put the chunk of code after the found_entry label into a separate
>>    function and instead just return RC_REPLY (and maybe rename that
>>    RC_CACHED).  Then in nfsd_dispatch(), if RC_CACHED was returned, call
>>    that function that has the found_entry code.
>>
>> I think that would make the code a lot easier to follow.  Would you like
>> to have a go at that - I suspect it would be several patches - or shall
>> I do it?
>>
>> Thanks,
>> NeilBrown
>>
> Really thanks for your suggestions!
> Yes, I'd like to do it in the next v2 patchset as soon as possible.
> I'm always searching some things I can participate in about linux kernel
> community, so it's happy for me to do this thing.

Hi Su -

Split the individual changes Neil suggested into separate patches. That
makes the changes easier to review.


>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>>> ---
>>>   fs/nfsd/nfscache.c | 99 ++++++++++++++++++++++------------------------
>>>   1 file changed, 48 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
>>> index ba9d326b3de6..2d92adf3e6b0 100644
>>> --- a/fs/nfsd/nfscache.c
>>> +++ b/fs/nfsd/nfscache.c
>>> @@ -489,7 +489,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp,
>>> unsigned int start,
>>>         if (type == RC_NOCACHE) {
>>>           nfsd_stats_rc_nocache_inc(nn);
>>> -        goto out;
>>> +        return rtn;
>>>       }
>>>         csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
>>> @@ -500,64 +500,61 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp,
>>> unsigned int start,
>>>        */
>>>       rp = nfsd_cacherep_alloc(rqstp, csum, nn);
>>>       if (!rp)
>>> -        goto out;
>>> +        return rtn;
>>>         b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
>>> -    spin_lock(&b->cache_lock);
>>> -    found = nfsd_cache_insert(b, rp, nn);
>>> -    if (found != rp)
>>> -        goto found_entry;
>>> -    *cacherep = rp;
>>> -    rp->c_state = RC_INPROG;
>>> -    nfsd_prune_bucket_locked(nn, b, 3, &dispose);
>>> -    spin_unlock(&b->cache_lock);
>>> +    scoped_guard(spinlock, &b->cache_lock) {
>>> +        found = nfsd_cache_insert(b, rp, nn);
>>> +        if (found == rp) {
>>> +            *cacherep = rp;
>>> +            rp->c_state = RC_INPROG;
>>> +            nfsd_prune_bucket_locked(nn, b, 3, &dispose);
>>> +            goto out;
>>> +        }
>>> +        /* We found a matching entry which is either in progress or
>>> done. */
>>> +        nfsd_reply_cache_free_locked(NULL, rp, nn);
>>> +        nfsd_stats_rc_hits_inc(nn);
>>> +        rtn = RC_DROPIT;
>>> +        rp = found;
>>> +
>>> +        /* Request being processed */
>>> +        if (rp->c_state == RC_INPROG)
>>> +            goto out_trace;
>>> +
>>> +        /* From the hall of fame of impractical attacks:
>>> +         * Is this a user who tries to snoop on the cache?
>>> +         */
>>> +        rtn = RC_DOIT;
>>> +        if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
>>> +            goto out_trace;
>>>   +        /* Compose RPC reply header */
>>> +        switch (rp->c_type) {
>>> +        case RC_NOCACHE:
>>> +            break;
>>> +        case RC_REPLSTAT:
>>> +            xdr_stream_encode_be32(&rqstp->rq_res_stream, rp-
>>> >c_replstat);
>>> +            rtn = RC_REPLY;
>>> +            break;
>>> +        case RC_REPLBUFF:
>>> +            if (!nfsd_cache_append(rqstp, &rp->c_replvec))
>>> +                return rtn; /* should not happen */
>>> +            rtn = RC_REPLY;
>>> +            break;
>>> +        default:
>>> +            WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
>>> +        }
>>> +
>>> +out_trace:
>>> +        trace_nfsd_drc_found(nn, rqstp, rtn);
>>> +        return rtn;
>>> +    }
>>> +out:
>>>       nfsd_cacherep_dispose(&dispose);
>>>         nfsd_stats_rc_misses_inc(nn);
>>>       atomic_inc(&nn->num_drc_entries);
>>>       nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
>>> -    goto out;
>>> -
>>> -found_entry:
>>> -    /* We found a matching entry which is either in progress or
>>> done. */
>>> -    nfsd_reply_cache_free_locked(NULL, rp, nn);
>>> -    nfsd_stats_rc_hits_inc(nn);
>>> -    rtn = RC_DROPIT;
>>> -    rp = found;
>>> -
>>> -    /* Request being processed */
>>> -    if (rp->c_state == RC_INPROG)
>>> -        goto out_trace;
>>> -
>>> -    /* From the hall of fame of impractical attacks:
>>> -     * Is this a user who tries to snoop on the cache? */
>>> -    rtn = RC_DOIT;
>>> -    if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
>>> -        goto out_trace;
>>> -
>>> -    /* Compose RPC reply header */
>>> -    switch (rp->c_type) {
>>> -    case RC_NOCACHE:
>>> -        break;
>>> -    case RC_REPLSTAT:
>>> -        xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
>>> -        rtn = RC_REPLY;
>>> -        break;
>>> -    case RC_REPLBUFF:
>>> -        if (!nfsd_cache_append(rqstp, &rp->c_replvec))
>>> -            goto out_unlock; /* should not happen */
>>> -        rtn = RC_REPLY;
>>> -        break;
>>> -    default:
>>> -        WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
>>> -    }
>>> -
>>> -out_trace:
>>> -    trace_nfsd_drc_found(nn, rqstp, rtn);
>>> -out_unlock:
>>> -    spin_unlock(&b->cache_lock);
>>> -out:
>>>       return rtn;
>>>   }
>>>   -- 
>>> 2.30.2
>>>
>>>


-- 
Chuck Lever

