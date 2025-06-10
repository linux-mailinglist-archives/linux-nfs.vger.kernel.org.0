Return-Path: <linux-nfs+bounces-12227-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B770DAD2AD9
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 02:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECA81891E47
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3381D555;
	Tue, 10 Jun 2025 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g1p+fJS5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AgPiFH1D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D728171CD
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749514646; cv=fail; b=DAfY2wdnKGRWuvgVJan7f1A59iHOUznjlJocFPN3Kd9Onepn4G3ss1UutLt2LkplwmkY9FULMZC2Lpjj1Db9WDxJe61I5rpPGen+34A6e+N/vBz2EoMRI6+5cHV3Mh/us3Kw+CWoDvthdAghK5nZol4Cggxzz7xr1xYUcPyNjQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749514646; c=relaxed/simple;
	bh=GrjpfR2F742+xqECFfK6OXJ3rv20+s3vKN+aN2wG7aM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BLvackMSaqMVwUXLsw910Cwxoya7UDAwpdPS8fAXQBF7my3eLj0yM2IeXiFBMCnX1Ba4/3MScQ0wB38gVhANwsMwcNJ0hHGiacOINlHPaonWJoasR7BFH1VF7ZoPxa5ocSelLsO1Qe0HDGqoFVAcHSwlCY95sTx76mD4AKhckZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g1p+fJS5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AgPiFH1D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FPnjN006599;
	Tue, 10 Jun 2025 00:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=s7Ie2h09S6aswBAtPEtr5767Rv7DmPxqEzVi+MjWi1A=; b=
	g1p+fJS5JXLlAJLzCLFvBH8VLSb+QaNDc7/nr6spsjXm0i/FBpT3mjfvQxmI+RSL
	zZGCIYCdHaP7BYymvQmQXtMfjMWaZ0cNeWKKt19sWjvpAe1xSPOO4Bp9A7qa85TQ
	4Ac4VNCGty4LI/ihMmZAxbW0BDAuoznLwe+NRb6IfUzleeaw0l5E3QxUP6EcJGnh
	nFnB7lSctbuNllbUQyKRso3bu7KvesVu26whGLY5bovYoLXdyIMwfE1DCJLdu/ze
	dwVsT7CeIjUWZDB/V6YbF4nlfHeW1ICn3jQc2T0ovrZerVXYUHKny+I/6etaQOVd
	+lI2/7gwklBfeDqa3AkPjw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjthd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 00:17:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559Lx2Bh031370;
	Tue, 10 Jun 2025 00:17:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv82d4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 00:17:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5fYRBxaa4pLdOjGyWhd3qR9Mr/0aUbwMOYkgxygMQ8EueNBrmT8RxNvZ2X9X4ZEoy//LvP65RGkXO8f+UArqPZZcXScvrot7D9u1oHWmaVjKKhye4zzsIci4cS/tIiyDUy62jKHUb84rlWc2wP30dK+/g+UstWlR3w37kWleE4v+LZ6HuHwD9MklfhwiR96+dxv0bAMkG4vbadMKvpQ6PuBRDNUvCRzcFlyffOjsxSSJavfacZvTwBuf7Bau/nTN4mHjiwe/ZoyTy72QCjOyCIkiIFiGXy8hAMCgmbCmoOD4TW/R4RsZt7NyUG76mpnifYWP8VDk8kKy02MPwLjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7Ie2h09S6aswBAtPEtr5767Rv7DmPxqEzVi+MjWi1A=;
 b=bv3p6EDW0NBqcIMbT9dYp0VNHIFcrqJW3NGKagqbVsb7FHOcnSqCN00uVop82t2B/6N3vXXj7OBc0PSRM1jX/GlDrB7FmpL7/kdbXUqvG2oXeMRx8SjBsA87Wj4o3ujrz2GVb0CPy/XspR/TIDS3F75AadLQA0gNk2EPupBhpxaqDQ6Xem8GWZIrlv3Z1443oYfN/pdWpqCDdkUxQNzewbyzWhQ7uF0IqUOnRseaPWPYJb/9BDrbbxnCVV3iHUOdev20t3NGjs2+NfXpPVuW9kzthP2idx/Kx7w12xQuPbxSnvagYBzctGrHuHPQLO3ZFkBJe4lOnooQU4ajriNr8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7Ie2h09S6aswBAtPEtr5767Rv7DmPxqEzVi+MjWi1A=;
 b=AgPiFH1DP7reY7oScNDCc3MRrjuyz2m6Zs3CW1YiZrp9UM7+t/kHFIa/YWNqRIw9aUvEIcYt8EppvgQtelEUJtdw8W2OuMRgDBRykXfC4mcCTfKTAN4cEOwgJj9zfuoBRi3k2yhp0T1rdi0SkCH721wPmTH3Q6Pr8bTGNG/xbeQ=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS4PPFA5A8CF00B.namprd10.prod.outlook.com (2603:10b6:f:fc00::d3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 00:17:18 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 00:17:18 +0000
Message-ID: <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com>
Date: Mon, 9 Jun 2025 17:17:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: simple NFSv4.1/4.2 test of remove while holding a delegation
To: Rick Macklem <rick.macklem@gmail.com>, NFSv4 <nfsv4@ietf.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::21) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS4PPFA5A8CF00B:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0c54c4-93f3-499e-0dd0-08dda7b42927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnZxc3NMeVE3TlNDbEdSVHJQcWwyM3NKZU9Vc1F0VktycUNiRk5oUnZBRVBw?=
 =?utf-8?B?WFFMSldVazA5SXVsaTNsY0JGbEVKdWY3RWxibUw2NUZtdmtETnczYmJQM3NL?=
 =?utf-8?B?cDJ6dEpRSWJZZXF1dElWRUJXWURYazFNRU1UbGh0L1dMamdkWmVPK1hVNXJq?=
 =?utf-8?B?SGlpOUFvUzFHWXlNQUJkS2FvR284ODRDSkUwQ3hKSUk2aG5nb2FSbkZKTHVD?=
 =?utf-8?B?ZUttKy9EemlhWGJkQ2xPaStWYnAxVmVtV1NvRUVNY2dxQ0gra2lVYmg2dVRl?=
 =?utf-8?B?SE1Vd2htU2RXemxwclVNL1IvU2lVWHRRRzFXK0dvUUgvaFN4NjlDdUttMVp6?=
 =?utf-8?B?NGM2TCtMQ01ZUlBnZ0lCY1JyU1FVb1Q2S0FESFhjVFNHRm1tcmtvSm8zUHk1?=
 =?utf-8?B?UDdkaC9ldDNnR3pQZUJROEZEVnZOblZzNGtZZWtKTDdYMDV5aUxVTlFsWTB1?=
 =?utf-8?B?WHpHVkErckprU0lndnFmMkFUcVc4VzRrOXhMVFl5SllEcjhrOHVXU0VsK3Fo?=
 =?utf-8?B?enJHRmg1NHJpOUlUcE9oVUc1b0l5TnArQXlpU09OWSt5eFQ5bkVmZVdoZUhH?=
 =?utf-8?B?OW5RNVAzSFIxTDhlQkN1eUtWWmczbmlxY2dkQWhjV2Z6MEhPTFVuNmZRTlVZ?=
 =?utf-8?B?YjIrQXNkVmd3V1k5TWhmUDBhN3EwQWJkRU9LUTVNczJvMm5pbmg1UE5CR25a?=
 =?utf-8?B?NThhQnNqTm9VdnVIUTVxcmdPNXhVRWpUWjRLOXNOUmY5MTNXR1hCUFU1eHRn?=
 =?utf-8?B?UU5yc1dLcENFYzVBYUJMTHNJTGZhelJGTUo5eDJQZU0wc1RtNjFqZTFjWERv?=
 =?utf-8?B?NHhKMkhXQ1kxSXhhT2kwOEVNYzM0aTh5M2w4aHh1Wk96Qk1yZXFLeG1EOEhl?=
 =?utf-8?B?Z1FLcHI3c3pRS0FVVi83Q1hRcHZQZnZ5aW9URXFCZEx0QktXbUN2UXV4OGl4?=
 =?utf-8?B?N2drSEZUMUlSSXdLalhGa2EyNDBCd3pmTjdkVEVBbXFFdGV6QnRhY2x0aHAw?=
 =?utf-8?B?eiswbDRUaUcxb1NXdFRIeEc3VFIyTEtLWitaSmRISU1EVFBpTi9peVR4UGdk?=
 =?utf-8?B?VnlOZDdTd3p6SWlKV2tKZC83RUk0V3FycEtxWkJLSlJ1bkRLcnNqWlp3dnJt?=
 =?utf-8?B?WWl1L0xMYnkwa216RHF6RGJZR1RwcGRHdlAxY1pLMnI3cllwWW1mNThiSXB4?=
 =?utf-8?B?S2F4Qlo1VE5adWFEc2dvSUZsQmtXeTlBdnlvTUE4UUdmZDcwV2FLR1hGcDM0?=
 =?utf-8?B?U2RGZ052bDgyQklLZkFtcWZxQ01aZm41Zm82QjBQcVU3bG5HS2RGM2tEUnJS?=
 =?utf-8?B?eFVBdjlPVUJZWktKTFJWTFhsSmJmNmhIcjFOVlM0aVlqdTZhclFlV1h4MS9r?=
 =?utf-8?B?VUNENkpEMi9FVDRUVDh0VHh0bTVrc2RWdXBVQjNQVjJnQ0NjUTBaRXFRaWN1?=
 =?utf-8?B?UmN0MUVSalhWSW9oZW8yeTl1TFpuTmxMbXNQM0E5Zy80T1A1OGtLZ2h6MzN3?=
 =?utf-8?B?OWM1U2ZVTU9JMFpJNkgvNUZVQmQ1TXBoOUhLa1NmR3ZISGh1MWdUZjVRYWtX?=
 =?utf-8?B?MnMxTFVwLzJjb2xwSFYvd3V6WEJiRUNIaEhxQmtxcFVBY2NVUWNYY1UvTXRy?=
 =?utf-8?B?cmtxaFRVaWZCOGZlSlFNWjhkT3dKSkN3TmgzOWJ3TytMVmN6R3pIWWJlRFM5?=
 =?utf-8?B?aG1TVW5Fdmx0cFVSVzNwZjk1VGFIWngrSHB3eE01SnlWRjFLN25aLzczVWZW?=
 =?utf-8?B?RDhuTDJSYlk4NGR4VjNES3FuUGc1N3o4dWNxZUdJQjNscnJ6ZCtPeGdNSFZS?=
 =?utf-8?B?ejRFdkRNSGxxNzg5S013QkFvMFBBZ2NJYTZiNHk1OUI0bGgxa3hrSzVPa2Np?=
 =?utf-8?B?bit4M1g5QnlxNWp3YTFuRG9QU05WUDhsT2pIOHNDVmxsNW5VUXZ3ZmJjSzdy?=
 =?utf-8?Q?BzQF9HlASV8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGhFWklzTUI3YUdiKytxNzY2QWxVYW9XaFdKK0JTTmJ4Wi9mZXJyV3NGS2Yx?=
 =?utf-8?B?TlRySTVQZzUwRGljcVRXaXpFaFltWXlSeTZpZklYTWVoaG5jT29YQmdOSlRj?=
 =?utf-8?B?N2p4WkZ0eU93YUhoeVhOYU9UVkZiKzVqb2hVMVRpVzlsVEl3T2hoTUtzSmdk?=
 =?utf-8?B?OE1TNjNuZGd6cGQxMkhtQUJMRkF2QnYyNVVOVnRreW43VUNyS1dWZE83UUZY?=
 =?utf-8?B?WjZ6Y2FRdEVEY1ZPaFgyM0RJMGlxcW9oay81eHUrbXlCN0dwSkt0UnhXUkt3?=
 =?utf-8?B?N0VVbTVicW5HYkxNYk1hUk9XcjNyMVUrL3YySGExeG9pQ00wQzVxOVRQbjFV?=
 =?utf-8?B?UGtZZlpneDNUVCtOdVRJK0wzN09JcEFwUlhZcmtVQ0RrSURyazExY3hMQTJt?=
 =?utf-8?B?R1QyTTh4NW9lZ3l5elNiNTVvT1pHbjFhR3JmTmFQZUQ1emtIdEtTZHhmMDJG?=
 =?utf-8?B?SU8yYlR6Q2ZYTlR4Yzg3VWtteGdtOVcwZFNBQ0QzRXB1dWdZRlNaaVhueU9J?=
 =?utf-8?B?NzF4bTNvdGMwTEtwL3dVTFRsZ0ZvQTRybUdJU3BSd0lYWmcxdDJ2ODhRdGtQ?=
 =?utf-8?B?S3Bsc2VRT3JPNHBJSjZhTU92R0RxbDZ6aWd4UHlldDVVL25sSDEzN0haZVpR?=
 =?utf-8?B?eHp2RDdkeDdpRjlIUDV5U2NlaXZxRkJhUks4WkRnQko0dzE0VjJmV1J1N1d4?=
 =?utf-8?B?eHRTaFVqZ3RNbnJzUEpHNUh2K1YvRTJrSDEyMUtQdDFtSlNOYUoxcEF1WENu?=
 =?utf-8?B?S1lqWkJPY3U2UDFqbUsxUW1LclR4RTlNQzlJc08zT2JrK0M5eWR2TW5sZ242?=
 =?utf-8?B?cU9BeTgrVGlNV25qUS9BcWNwNXpNTFY3VFJ4U3lvcHlhSktIS3Q4czJGQnor?=
 =?utf-8?B?MGdTTllCQlM2N2RSdTlXWEZPRTVNYnRqOGZybXBHajRRN3VETXgyZ3Q5S2Jq?=
 =?utf-8?B?a1lKZEp6eFlOTTdHcitjRGZuZWxnYW1ocTNVNTRUeVozOGs4Qm15WWhIWm11?=
 =?utf-8?B?ZHo5enV0WUVKUHpsQm5NSU92WWFuLzZBaFRzaEZpOW9XZTBIdXpyYTNPMzFl?=
 =?utf-8?B?ZVpWcEJSTjJFY1MvUjdRODdoNDdBQ3Y4TEhvc3NYdll1ZEJISXB5aDJYQ1NZ?=
 =?utf-8?B?cFNxeWxreXB5SXdKWTNvdmwxcHNXa0twQjNhbktRM25hQVQrOUpaYkVMa01t?=
 =?utf-8?B?T240R20wMGw0bkZmTXZQMTNjSDhIV2g1cGF1ZHVvYlk0OHRtZlNuNlcwTGFO?=
 =?utf-8?B?UE5rbG1WdTNGU0JoeHRZVC83dElKZkdjTm52N3pqVU9xUTAzUGJEMW1YaVRz?=
 =?utf-8?B?b2VYTXRVNFlsN3VKSkVabFlkSndBQm1XdDM1YnQ1VWIrWWlpeHFKSEFOV1ha?=
 =?utf-8?B?Rm54WE1ScGtFNE9LZlBDMHYveEd3L0FhZThUbmYyV2RTZHY4N2txa1F2ZkVC?=
 =?utf-8?B?bjN6M04wNXJXek4vcFNYNmpVekdsL1VyRldneHhmMkhlQ1kvTHZyQnlMSmRQ?=
 =?utf-8?B?V21QUUJFZGlsT1JJQW94bVl2enpCUTMxT2lrYjU1b1lJVUZoZXNMOU1jeEY3?=
 =?utf-8?B?ZzhML2V6cisvcjJLWXR2UHAyYmx0Y0t0U25vRjY1alAyMHZyd2R0RjFhbWNn?=
 =?utf-8?B?TDNsaGZDbGRGOVRGYU83QzlrTE1DWVZrRmx3ZWhady9GVWt0bENJS0kzcnVG?=
 =?utf-8?B?WEY3UUI0aHVWeXRSeDBBZjZYSStodUlOa3EzL3ZoK09KMDd5Z0V2QkRHRkN4?=
 =?utf-8?B?VzgvTFRxVlJ0dmpsd0NNTlJEbS9jTnVsNEJ5Nk9SYzZzc1hlNUZPSFlUQ1Zr?=
 =?utf-8?B?TTF3UlV3NkI2VWZzazVwVWVpMmVKUXpTUnZDcDNCSTV0LzZqalJab3NnakF6?=
 =?utf-8?B?K2NibkhBRS9ETXB6bFBFbEpTVlNSNEdqRVVNNWg5Yk5mbENFT1VnNGEySEh5?=
 =?utf-8?B?czJRMjVKWDNTdStnemJtQ3VsUTVjTENaQlZ1MDM2RW83cmxqa3dDQ0NRV1FE?=
 =?utf-8?B?QmJTTVQzMll2Wk1GWUNpcEpYSDB4ekpRSGNleXR3bzh0L3FkbGp5WXRXS1dE?=
 =?utf-8?B?bWJuUzRZY1RuV2ZOaWswYTczKzRsOGdzb2x4cGgxS00vSWloUndVdmh0dEN2?=
 =?utf-8?Q?27Bbfuql8LucS9YJxxaw23hML?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zVUcX1GycSeSjq1IaoqIo5yyZMrOhDven8TtOCDTWoQdRWje5joho75wqrAuPvgbZsS41mQWCJkgVdotO7j30c3qoSZ7Mngn9QbqmlQ2DsBGpZzMJ1SCuBHpDzFACvXNLpPrHSk5YrzPZPtenG1mLkVlf+bTQCmNJieUpu8+PndXKAYfG3N8jCHODVoa//L0T3OIjE9KWyB/bB+WzB9ZWdslYlyrCXAQiyLUAUNcJa1UNSyEReHVSpxQrYheXCBm0WPoPMNPf9WJinJM6ZibMjKzHrrgM7R1zZvZR/ATfb4AYi1J0ybQChVyFWhuVeqX1KzpZd80rFgqQuWtMy8ql16arWUVKJWlFtlKeHJHcFx0exaUOrYmNy7f1HP8UTZE30VfcldiCGjkf4O8iFsxBDSK+kT5Kq0HRyB5dMa9L/bcqoXQIKKCnHDAGfGxj8f6McSWlQ+tXS50EybNA6ku/zzZACJw6Lj+k3bXmxdlzxdQn87OOD62cxm77D6TagymTfMTsZLWCXcdl5ujXpb4AUwKoXyN0hfHJVwB60r6VGlRqH1SMuT/D9XIbjLzN2O88lQxxaOd4tuZzN0/1tXAdX0fZSDPxlHXm+nfi7lvPy4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0c54c4-93f3-499e-0dd0-08dda7b42927
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 00:17:18.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lg0wgKR9fq3zdOV2kmJl95bYdi4dFD4aNi7gRbFiwuRuORsPL7V8raL5DT+aKYwmvFVrNb66Kw9I8zXSC+iYUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA5A8CF00B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_10,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100000
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=68477991 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=60h1SJgk5VDHRkQNhVYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDAwMCBTYWx0ZWRfXz3e2fRXLPjCh Q9f/x1wMEGLELaec8hKfmWlKPS/14Df6T5BOialFW+sRP1K9Zynluc7vxWFcCxso0Izhh1uhvBT /OAbC5SfgV/h3wqqLi6aXYX7M7vjkY6Xdusws2NOchtpI9kVmuk8nVSyOd/g5FVL1J54QTrHLwb
 2FZJXT4ZvLXZ4kbhRBJ+QK/mz14lJQqifJ/0hKV0Cuxno8Mqhe7c78wfkP+bGZgpkV6CUJFnm5T WEtXesyYfsi2PBeldmpmpkfzgVYzmH1rfU49hyOixj53Z/FaRLoxQW9IFJbhehmP1hBe8dexw8S CBiix3i3+BgR4OS+eLp0pKe0PpNV9+VAlmx5Nvi0y6Ag1EXOjacyAe0ftGXa6zicIcOOTvrd/Qr
 TAzDs7g50SisfrbiXZ3eKEINDZEO4tIA2AdAfUZP/RCTHgHPnFYc76InIy9FZljVXRjwEedK
X-Proofpoint-ORIG-GUID: LaVJ_jkp31vTM4jviX7_oiVWYgRkQ2Sx
X-Proofpoint-GUID: LaVJ_jkp31vTM4jviX7_oiVWYgRkQ2Sx

On 6/9/25 4:35 PM, Rick Macklem wrote:
> Hi,
>
> I hope you don't mind a cross-post, but I thought both groups
> might find this interesting...
>
> I have been creating a compound RPC that does REMOVE and
> then tries to determine if the file object has been removed and
> I was surprised to see quite different results from the Linux knfsd
> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
> provide FH4_PERSISTENT file handles, although I suppose I
> should check that?
>
> First, the test OPEN/CREATEs a regular file called "foo" (only one
> hard link) and acquires a write delegation for it.
> Then a compound does the following:
> ...
> REMOVE foo
> PUTFH fh for foo
> GETATTR
>
> For the Solaris 11.4 server, the server CB_RECALLs the
> delegation and then replies NFS4ERR_STALE for the PUTFH above.
> (The FreeBSD server currently does the same.)
>
> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
> with nlinks == 0 in the GETATTR reply.
>
> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> probably missed something) and I cannot find anything that states
> either of the above behaviours is incorrect.
> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> description of PUTFH only says that it sets the CFH to the fh arg.
> It does not say anything w.r.t. the fh arg. needing to be for a file
> that still exists.) Neither of these servers sets
> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
>
> So, it looks like "file object no longer exists" is indicated either
> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> OR
> by a successful reply, but with nlinks == 0 for the GETATTR reply.
>
> To be honest, I kinda like the Linux knfsd version, but I am wondering
> if others think that both of these replies is correct?
>
> Also, is the CB_RECALL needed when the delegation is held by
> the same client as the one doing the REMOVE?

The Linux NFSD detects the delegation belongs to the same client that
causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
an optimization based on the assumption that the client would handle
the conflict locally.

If the REMOVE was done by another client, the REMOVE will not complete
until the delegation is returned. If the PUTFH comes after the REMOVE
was completed, it'll  fail with NFS4ERR_STALE since the file, specified
by the file handle, no longer exists.

-Dai

> (I don't think it is, but there is a discussion in 18.25.4 which says
> "When the determination above cannot be made definitively because
> delegations are being held, they MUST be recalled.." but everything
> above that is a may/MAY, so it is not obvious to me if a server really
> needs to case?)
>
> Any comments? Thanks, rick
> ps: I am amazed when I learn these things about NFSv4.n after all
>        these years.
>

