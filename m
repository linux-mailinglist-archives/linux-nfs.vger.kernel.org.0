Return-Path: <linux-nfs+bounces-12263-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4144EAD3A2B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 16:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039763AC255
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EAD29CB49;
	Tue, 10 Jun 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ib0p1qnz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XcHfdDGX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC353298994
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564117; cv=fail; b=Lf0NQq8aotNeyH25I4q0fZ/+IS3OIwctewZ+yRnWL9nYZfK1ZpgPib2DlzRx9fKQjXC4Y68hmWnzKl8yzZE2JnxITVuowSsrnMtmVltX9WJRvAEumqMRgb+wJK1Im3gYzAMAa31faKIuNAEIEG0OKxq0Z3dKR60BE3w9DLI7+ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564117; c=relaxed/simple;
	bh=kLatRs7kuUIn5S65VDl6VyMVCe95AM5s8yynHxCmT8Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NFPyuCGGX7fFBYv3I+Jhtpt5wCb3g2q35U60e0UBYSN/IpVs3kxxuthL9nK/kZOu7eGnCz7WHNhJpt308lZqEjomwwbUP4hq49mHEQnPfeVFxKEF9eaQNfV1p702jmT/q/A5epsUB+1PqOaGraG0LyP3C4ixk/YkX8DkykAz8iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ib0p1qnz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XcHfdDGX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADBhQp030311;
	Tue, 10 Jun 2025 14:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qIziGWz+3sliBQ8mkvF0b2nOJRnQ/nw9ZL81t0cJ3+g=; b=
	Ib0p1qnzFfIXmobF/PZ/YQ1tDrysbxWAGYX2GhayMESRaW9DI4ZfL90wJIWl0XeW
	6qkZmyY6Ye7TyCb3j/EFF9DvT2GgzPFKY24okaRBmoHrQBXlOHyqmh1RIqdhE/Ul
	SZW94qZ25xnVabdO19ppKmp1UkJ5nWOGa5mGFYTs25/dVKjjpLbzKWBN/sOpxsiU
	szGZ22CGoCMrUGEh3iRgS1bW847deDk9izPnqsaPhCerEubRZWa1V9K5bi3i2FsS
	19oCPNcOzFlibhBQlFOh8t8pKROtW+0dsMXDS6mFSs/siLPYGeZTxpgKTLw1jmD9
	LeXv3qKsE9tVaVYF7igHmA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjupft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:01:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADkiN1007163;
	Tue, 10 Jun 2025 14:01:48 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012000.outbound.protection.outlook.com [40.93.195.0])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8h96f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/0IuhQ1Pm48/NGti+fq59HOxKEU8dQHMF4QbTB2NhBwUEZ7z3EnOeJdS3ThEmbccxbhD34/06gNbsNuDqyaMS/10bob4TrKwlLr5ca4XTAWcyyTn7D2ANNiPZS2jbs++qdAC+5Nq2r8nm3/xPj1s71U4HI0APlh10HQpBNDq/o4UyTT3xHxmuswjAe3kFR1QYcD+uUB4R6/LqbcNFjjO9lg/OjSsszB5JPr5O+aEUlQQe0CZh/C4iOe8+71XgJkGeK91e9hYOxWq3YsifU8mWdo3GcDKR/GLK9GjkccaJiFz55GYEwWCk/IvBbQ6TzAgzfx3H+rcmiiwjqi3cO4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIziGWz+3sliBQ8mkvF0b2nOJRnQ/nw9ZL81t0cJ3+g=;
 b=Y+7+xEtLArQC1PFsbdwi5p+VENIre0ZSsj5ZcUbsCh7xXSQsmLYsE5Kf7gzLrnKSpXet/wHqpocgxs9oZL2ztwGY+18cJZOiGDVDpePgvjNysd/UodDqPCLte1MZhEYlO1Pc0tRT1SrDQFZ/wLA4tcwt4a9SD9gTRJkiBcpZ3sAbnM5RDWhCHTTn3kyTTpGf5O59sKct7+gdmcP5SLpF612UgnZR5uwa2lsrmIZa7mee19c+9w1alPV1UI+lp7y+SMdEXXIAcAHCbz5lk1eQYMrNiwtwNXfviQA//OHeh5jZWgu4YgEztkpUy9DLsG6rq4PyR2hmmyd7O8nKEyoMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIziGWz+3sliBQ8mkvF0b2nOJRnQ/nw9ZL81t0cJ3+g=;
 b=XcHfdDGX9/zxBr61JZP/DrugNthycrySWE9y6dyjyJoj0pfiF/PE2hUa7WJdQmUwW7e3dU0A2gKzaqPCfO3yuvRyCPfHenjqO/agd8b8uzSMWOlJ8beD1Dwp73apH0/gZx0IT7YM2+QoyKS9kZ5n9y/qmJUNzgNKJ+ngEmgYY+w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 14:01:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 14:01:37 +0000
Message-ID: <c187763c-09a3-4027-9833-a78244a4329b@oracle.com>
Date: Tue, 10 Jun 2025 10:01:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: detect mismatch of file handle and delegation
 stateid in OPEN op
To: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
References: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com>
 <f580a2f30274ca61f44d4b8d4b5e9779acd84791.camel@kernel.org>
 <6bc66030-adba-48c0-a992-82f7bbb153f3@oracle.com>
 <7993b2bf9c38041f8963e9161aaa25984b50d3f1.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <7993b2bf9c38041f8963e9161aaa25984b50d3f1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:610:74::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: e27decb0-7c50-4019-5d12-08dda82750c6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z0s3N1c1UjVjcU0xRDFJdFdoaTk2Y1ZvSXdNcTdlUUVmTFhrQnBpWFBjaDBQ?=
 =?utf-8?B?WWhub2NCQXNhLzMxeVl4dllpSFNSRVJGUnczbmdNVzI0eEduR29GSldrcTBq?=
 =?utf-8?B?aVRrOGFxN1hIL0VIaVQ5bHZvVUtKTlNhWmZrakxvWTcxdnh3WWlyYkI1NXhy?=
 =?utf-8?B?L2NuQTdYRFUxeFFmWThTUVdGMG9BU2pMVlBzLzNURzFnandwL1c2SW5YbmM3?=
 =?utf-8?B?aXdRQWN0bFZOSEtIWHB4cURXU3pQQWl3MUlRRnAvMTZVYlNOOHUwVmxkU0N4?=
 =?utf-8?B?T2EvZzZ2cmJWRzY2cm9oWGhwcFM1QTZERzdYajJRWDZiOXdwaXBSeFUramlK?=
 =?utf-8?B?UjJtMDVmUUFqYWM1TGxCRGw0cnRZRHdIRmRDWjVrQ21GY2dxdzMyYmlkMU9T?=
 =?utf-8?B?K2ZzTzlZeWZZYStTUTJlZXpITWV3WGU4L1ZFcmdhRDFpNjZEWHBxWlUrSUxD?=
 =?utf-8?B?cHFDNy9VWnVaazdoLytMWTQ5My9waWRmRVk1eFRlcWVkbko2aWFsb3JWSmRt?=
 =?utf-8?B?RlhvY2RTT3ZDSEU1S3NaUmxxL1FzTWRWVUFBbGdOb0wwcStQSWt5Q2xuWGpq?=
 =?utf-8?B?bnZDcGt1TlVTR3kzNTY4N0tncXVsZlhGQ1QrK2Uwbmx5UEUraHo0YzhOWllq?=
 =?utf-8?B?NnI1dHZyb28xN24yVlFzT3pBcXFBZC8yVjV4L3Q3N2llMkd3dU5xR24rT3pl?=
 =?utf-8?B?bEtPYW1zZFBWKzMwZk5BU2loVmJWMnpsL1VWTVdLbVhwc05vck9NbHVxMHg3?=
 =?utf-8?B?d0JTdlJaaVBmQXV3T3hIRS9VbldsNTdyNnk5RFhlaWtQaTdyRGMwemVPSjlw?=
 =?utf-8?B?bjBvNm51VTh4bFh4Y2RoZXdNQ0o0eE9sRFpwZ2NYTzdib2VlanhSMDJhTS9v?=
 =?utf-8?B?Mm5CcnczUytqVnByQkdnSGRUeFdoN2dwbUdkVU8vK2tDTUdVMUt3dGJHYVYx?=
 =?utf-8?B?YVA1TkRQa1BGS0k3RGE4K1R4eFpqYTlkMlRTWUR2WnRHZDJGWmJpYkZmaUlW?=
 =?utf-8?B?bnJOaCtydmcrM2VicnJBaDBiWUZnRzJYMmhoQ0pHQ01hc2F3VFppRCs0UUNr?=
 =?utf-8?B?SCtaZ1JYOEhCVFZCWWorQyt0Qm1xR29XUVdwUjZVRFNzcXJJZW9MQjZweEZU?=
 =?utf-8?B?QzJtYnZrdTZmektpOXVaSUFtbEhCOWlLWithYlhSVlZPVzBoc3JyUEhuSjBY?=
 =?utf-8?B?VlU1Qzlac3F5cWdUVlJKL2xVbEJjakIwYVNjMngyMlExdEZnN0t0RTVDTXhl?=
 =?utf-8?B?dGJ2bEhxMEVHcDdPZW9aU0NYdzFjN1VkYVlwL1Ewak1ET1RHM3JpSCsxMFNP?=
 =?utf-8?B?aWdmSko0MVVvL3lRdjZhSmY0L3FtcG9WdE9DNlRnMnlUK1pubFpqdUs0V011?=
 =?utf-8?B?Rkh2MTRHd25QL1ZkaXF5Q2IrTWJ5cVlFUFZlelFxMWVVSGZKeVpWOG9CNkZM?=
 =?utf-8?B?UFQ4SFJ3d01NeGlmQ3Z4VSsxc0JReE1BVHNPdCtYeW1nR2VxUkViT3FyNWlE?=
 =?utf-8?B?cWVsd2FMZmtHZlRaK1huL2RCc0pDL3hMNEZ6aVQ0UHVWcms2MSs5ZFA3UUZB?=
 =?utf-8?B?NUVEQllWSkd3NFU4RFYyL2pvQk5UVk12UTN5bEZreEpMZWVtVWlZOE9VTHhI?=
 =?utf-8?B?SkRLdFA3dkdya0p0bHBxc0FieHlocktSV3RxUnBmQlNKYVliOUNjTzdqN2p2?=
 =?utf-8?B?VmtYcVNVMEFhSVYvdjQxQ1JRSzZFZ01aZVk1ZVhDeWczTERSb3pJMGxzRmUz?=
 =?utf-8?B?NUhNeUl3aE5Bdm9lSy9haHM3dWN4NWxReUhlWXM4MGV5S3oxMWw4K2Q2OFc3?=
 =?utf-8?B?ZlV3TFVCK0RmUHN3aTBManQ5M3lwRnFqMVg1bmMvOGNVVTZKcGdZU1VHc29Q?=
 =?utf-8?B?ZnNpSmlmdEdXU1dWV1Z6QUQ4TE9NVjlNbkVpOERHTit2SjR1cmFqWDFPMGpu?=
 =?utf-8?Q?/9YeXaH0a6s=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aFRCbUEzUklLQXNhcDZVWHAzUTlHVEUwUEo2NFJSYUYrKzA2dW83dUxncDlx?=
 =?utf-8?B?ODJwekJTbHNxaHp1RE5idEtwOTk0a1g0bFIvd0xqMVNaZFpFampXWUtoL3hL?=
 =?utf-8?B?QmtTamE0MnJ1TVI0dnVMM0NrZnh2TWVocEFmUzlPTCtjc3FVTjNvTjUzSnR6?=
 =?utf-8?B?WjJzVHQrYU1LTVdBWk1SM2k1aXhRRUlMVDZ6cVltdWZ4MjJqR2NlK1pXUE1W?=
 =?utf-8?B?dW50bjRyeTc5WElLZVhlbGg5aFlNUGhnZTBkcnMwUEEyZlNnL2luTU1WUm5k?=
 =?utf-8?B?L3VYSHdzblRiTVdvUmJkcmFmQ1ZpdlZ0Q2Y3QXIyMnlPczNpNzZSaFhYaURR?=
 =?utf-8?B?Q1ZreHJmZU9LTVBKak9PcElTU2MxMmttVnhtWHFRV2hld2RzZERKQmNxM0RL?=
 =?utf-8?B?TnkxZDhoa3UwUVZzYmhzQTRodVN2MGN1S0lsdFZTZW5iLzJyYThXT3M0dEwx?=
 =?utf-8?B?Qm5LeGZ1QXEycW9ldU5QSGZsbWc1NVozOTV1eU54WVZxYklNMlB0OFFsdzJu?=
 =?utf-8?B?aGszSjVVRUhRa3lEUHg2Q0l4VUk4N1RoQ0NCamtGckllZU1rWjg0SjBWMkR3?=
 =?utf-8?B?VW1jYS92UWwzNE1NUklRdjgvWFpGeUE2L3hGZUJvOThxT3pwbWtKS0NtcytQ?=
 =?utf-8?B?ZWtOOUJ6VS9IMEpFcGdPbGJNZG5kRXBEbU9KZldxQk1nakVQVDAvOWRPMVJh?=
 =?utf-8?B?NHdicjlmL0hPRVdDemVaeXRFenh3YWgrOEJ1eDladzd1SThJOTJPVFNRU1pD?=
 =?utf-8?B?Tm9NeVcrU1V6YkxmamdEUC9JUXJRSmgvMzZESklnVW5Wck1yWkhDSUo0TFlr?=
 =?utf-8?B?MVkrdUVSclczMWhXNnhZcVZqdXRuZHZvVm93UDZNYnlienBSSTZzQzdxbUJx?=
 =?utf-8?B?TXk2SlBqeHBDemFQTnp0TnpxRTJWN09CR1c5d1ZTUUpweDFZaVlTR0l5bFBS?=
 =?utf-8?B?YVpEZGJBNzNQczhFRllqZTZuNWxFaHhFL1R1VTJocnJkdDNSeWlkeDlXa0V0?=
 =?utf-8?B?Z2NyMTZsdGpFdXZtMzlLWVlibEZRWmY0dm9Nbm1GSDZtckhZc1dhTnV6aXQw?=
 =?utf-8?B?NlBMS01JWStTWWdPT0U2OFcybVgvTWg0OUl2NVBsSHVtbFRnYXN1WS9lR1g4?=
 =?utf-8?B?V08zaS92SG5TbVV3QjIzNFhtYUVSd1lVQXBZT0JrVDAvTjNGMDRhTHFQWncr?=
 =?utf-8?B?SSs3SXVnTkVpMVdPMGRpa0JGOUdqamV3aVpWZnNqR3YwVmJlSXBudXVMOHAx?=
 =?utf-8?B?QUY0RWkwMWtmbXFqbWZvUnlBZ3BISFhoa3BjZElnLzFrS0FackdJdFBJRkxx?=
 =?utf-8?B?eTNSSXJnaTh2bXRIclJUeFlUMWRGcEVuOForV3FRVHNjL0NoUEpKWU5waVg3?=
 =?utf-8?B?OStQTW1nSnJxdlJQSXptakUvQ2drSnBZak5vQi8wb2wvbVQ5cGY5amhZMEdZ?=
 =?utf-8?B?NHVmUFY0Y1pvaUdvMFUwVkJrNzFwY1I3blhSRHQrZlZKblV5enpPYzZhVUg0?=
 =?utf-8?B?UktPa0IwWFgxNmRxMCtoM1Y3YjRPUGhUemRGUmFuQlVRVjdOakROaUpTNzll?=
 =?utf-8?B?djZ6a2k1eGV4SHZoYnd1UDBWUnFpaDdJSFRRT2dXVzJHeGpaZktGK295dWp3?=
 =?utf-8?B?bWRsUE82RFMzRnZLdkV0V2x0VGpZN3pDYVcyVStPcHVDS2FDdmVxWEs2TStn?=
 =?utf-8?B?aGQyZVY2VGV1bXBEdzdzMTg3eHR2S0Y0cUplaThGUjZaQzBnYnVlK1ltejVD?=
 =?utf-8?B?eTZMOUZzSW9OY0R6VzN3M1ZJUWFKMWpNNkRlQzZZa2ZHdExMRXkzQ2tmMDY1?=
 =?utf-8?B?NDRVREVaRk4xRCtIc2ZKcEthdGFEVTZQYUExOU5iTDdUNWNONG1Sai9Ed2pY?=
 =?utf-8?B?STcyNjJzME1YbWx4TGxmUjJvelhadzN4L0ZrU1RsYXk1Z1ZKZDlJWHBoS29w?=
 =?utf-8?B?ZTAwNFJ5QTBUYW9PVmhOMHVXTGRSNmNLeG1LRXl1WnMySXQydGZxemZjelpN?=
 =?utf-8?B?elFDUjNSdzB0TG1RMzJPL25qeVc3Y3hjdjRCbTU1K05PdEtCSnJmQ3ZkRmZp?=
 =?utf-8?B?QXJEV01xb2x6dmVjazlwdkVNcERkVDc3UmNYQ3A0UXFFU0N6cEtHNnl0SEZj?=
 =?utf-8?B?QjFydFRjR24zVyt6ZERJQ3lETWU5OE5UR04zU1BEVFNwbEZ0Vmp2V21panBC?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mvkM/+pBTrQdl5rLrFnt/O3EewTVGwR/v2ibK8wjV5rjhgfqNSSZH51wUGzCJ5MARJ18tvY98EtNL+NSbbP4DnCS4OlfmvkutIT60tc0ZXXPQ42caNx/UfBCjkHqcMy9ScS9+DvGSTAVdxB7ytT1vzdqkv6WoBPZVYRarcMacVaII+WsEIYONGAWj2VO2kcixX/hG71ulOfh+jIJhUQ/CEQ8A1hjAg+bcrWVagHdgjjNOuZhOdjfCHoUYwMV1PYulHUrvWky2ZEDBjxs8Jjtkd8Xgy8Tc6tZrV7en7dCHU8axBJYMRLWXBqdwbfRfYLtmjpIJtBf5Hy3HnvK64KmvfAo+LHJxl914zwRPf8Ul0MRmBvgAa74BSxHeobQxDZT1PCOb5pUrmUYxrCxLLlLdkGgvvGhnsWOP5vK/bqU5elNzKIc0xi/ti0+77KKvk5GxqoFHBcfL2bw0B061gWneVGyhBST2oh+EXSdhzzSAPdTZoCx2u25Zqi+1nAXQbIxmidduxAxJk1tzi5L34MzMihR+Ba0BeeScqni+gtpRWkzGcWWLh4shq2bGsFADvL23SBbcWlOVFO5kifPQESPxrdbbdi8toC67JLtmTisXEo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27decb0-7c50-4019-5d12-08dda82750c6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:01:37.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUS8IHLe54ml/iSX3faMOgJrj8kJTePPMDrfEA1kh1DV2naB00HLlIm7Iow1hpD23fo4cfvIkIcRVdY+FO6dzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100110
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=68483acd cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=vHBsYZKSXxWxtqEK42gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExMCBTYWx0ZWRfX8grmN9+wXrkO KwcaFgHv+xWfkUKgUVGdrcNgCD3KwHcgBNbQNvR59TqChzvLMwNopVVErjaOnFFDWdeOLjeqZRQ ijQk6BcRKaTmjKnNtWfAjwfpCMarASfFuzRv/03xPwopWxsKOhaGqwElxxQxZIf92RNqFJof52K
 EiWksZqjyw0Py5n8ATDW/YACXKLHybQ3PDQyFIBt/bYXcBFkRuYN8ZQ4tj2p5zaMtYaNooY9Z4P g/tB1qGlOcYvOcVk7B+J0li3WbycfTy6urKCZuN4U3j+uIbKnai4s3V9ztQgIOlYbg2M/7U+U3L KMKIH/wqS2zjmkna+VwrzPp3B/4HaflAr/oL4O2mBvRGJ2US/Dmwm86u6rANC+Y4+i/Ozn9zKKy
 I9fe1+SCm0qphomz7uKjQUb1Q2suAWAB+gIFGVUAMCV2y6tZ8xV+YrSXAnG6cMk3RdL/f3JG
X-Proofpoint-ORIG-GUID: N4JmkfKvkhXIgnSYYKlZFiuwZZi8Pf12
X-Proofpoint-GUID: N4JmkfKvkhXIgnSYYKlZFiuwZZi8Pf12

On 6/10/25 9:59 AM, Jeff Layton wrote:
> On Tue, 2025-06-10 at 09:52 -0400, Chuck Lever wrote:
>> On 6/10/25 9:50 AM, Jeff Layton wrote:
>>> On Tue, 2025-06-10 at 06:41 -0700, Dai Ngo wrote:
>>>> When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
>>>> CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
>>>> must belongs to the same file, otherwise return NFS4ERR_BAD_STATEID.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>  fs/nfsd/nfs4state.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 59a693f22452..be2ee641a22d 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -6318,6 +6318,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>>>  		status = nfs4_check_deleg(cl, open, &dp);
>>>>  		if (status)
>>>>  			goto out;
>>>> +		if (dp && nfsd4_is_deleg_cur(open) &&
>>>> +				(dp->dl_stid.sc_file != fp)) {
>>>> +			status = nfserr_bad_stateid;
>>>> +			goto out;
>>>> +		}
>>>>  		stp = nfsd4_find_and_lock_existing_open(fp, open);
>>>>  	} else {
>>>>  		open->op_file = NULL;
>>>
>>> This seems like a good idea. I wonder if BAD_STATEID is the right error
>>> here. It is a valid stateid, after all, it just doesn't match the
>>> current_fh. Maybe this should be nfserr_inval ?
>>
>> I agree, NFS4ERR_BAD_STATEID /might/ cause a loop, so that needs to be
>> tested. BAD_STATEID is mandated by the spec, so if we choose to return
>> a different status code here, it needs a comment explaining why.
>>
> 
> Oh, I didn't realize that error was mandated, but you're right.
> RFC8881, section 8.2.4:
> 
> - If the selected table entry does not match the current filehandle,
> return NFS4ERR_BAD_STATEID.
> 
> I guess we're stuck with reporting that unless we want to amend the
> spec.

It is spec-mandated behavior, but we are always free to ignore the
spec. I'm OK with NFS4ERR_INVAL if it results in better behavior
(as long as there is a comment explaining why we deviate from the
mandate).


>>> In any case, whatever we decide:
>>>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>
> 


-- 
Chuck Lever

