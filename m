Return-Path: <linux-nfs+bounces-12265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E50DAD3AF0
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 16:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30997A77E5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C2299928;
	Tue, 10 Jun 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bk3dJCiu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BNfrTLgp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92E298CD7
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564907; cv=fail; b=GBkfcun6INPTwb+69cWG+LOlcnPFzlUBTBC0TbBe035Ofu/qNg6dxb6UfTz5DaDVEq2sJrVwORwBiCSHjQN9AS2ZH5l1Q5I4r04Pn55fIkq3+c/bxS0glH/VQD0gtbeEwkg0UfE+xS1aputl1XBKGXeUXK7IjVJ76Y3i9EpdlYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564907; c=relaxed/simple;
	bh=p5EoNmnYKKGzt7jLJHugZ6d81ph6frxI1jCyj/n0zJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BOzdee21m5vhKgEvN/rQv5Ws611pAUtHeobIv0EbED44lpw9D9NMwUvzV78toIiBJUHZLsVlI+d/KFVetpgMzQMgs8A0EcfccEyeIv7H89mn5MIgBbQU5btMBwzs8Qi4ZFUn8xJziFjLIcdO1ExN3kV4NvZnX2QzhPFm8S2eeGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bk3dJCiu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BNfrTLgp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADC03F008734;
	Tue, 10 Jun 2025 14:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pyIYDpqgeqOTq8aHAN1sxivcGnLbIViF9OlS9hiA/pY=; b=
	bk3dJCiuNiPbdK+FxwZ25e7yvhD7BT4OeNcVPv5K7Cl95znYuVbxzo8I9xPlJUFc
	4xfGA+/l4zMJ8jOiIp7wAqUVnaJwAeK2lw7GxTBzQjVp1v6AtXYfvLX+4dIJd3Dq
	i8vO5wyEIZzkB4mzpvmsV45uaPg0Gk5lOT1lkcm8LTUet6ZPl1Ycwvfn75tbCBf7
	1HS63sSFCANE1rLtMBYIHrH4FwokVvh1fbLzKfJEmsqjPE4nI8e6KhXO+yhfnMWT
	EczlxBGRUyYpqlJp5DDa3NNl6hAkKuA9gboks4AKFGUdWv4N5EokkmmcPTNRU6KW
	r1XIbj5qxPg3cGamNhUC/w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf4c0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:14:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACPr5m012026;
	Tue, 10 Jun 2025 14:14:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9s9q3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ28O8Bz99ICQpX6tTALjBdiLznDPbB+O9XdrYyRLeZF88YLnjvQVKMdp+NoZBkBofVrctDFooMqR4mbPObQFiHSUUw9pWpeUyLkAgRul3ZF0mNSFOYSkYMbJL7ROZtt5O3GJYAwMKNspAo+EKuY8BU+8zj2cbhlanJa6Kph5VLRlp2FmDLky5azziGmzMrvUqgtr6DJ1twzu3cjuC2AliQmtetmaiic6jt30wFq4/JY+sYfA8/Kx9SjojMfLxMY0bNezlqWcO7oXtJLzrXKzVu0yP5LhMWL9i6RQeLRLk+tlURkYNHSY4BBuyFsTNazB0Vmif16xzLd3ZvoCZNDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyIYDpqgeqOTq8aHAN1sxivcGnLbIViF9OlS9hiA/pY=;
 b=L1RD7Gsilk+yTJ2LIpKfbqiN1GkoDxcwpAZVLSdyhWLgDRiqV3xKimBjdVvqSs14Tt0GFh85O9TKD/dDCuhPhZWlN4T4MTe8eZQ6P7LBIRIvhW4XYmyoJUIs7gap95PlRHBkUexReXTHmoMVailWvuSFNL4Jg2qV8u0sSyO8MaWVk9d39dlH2pjQgzX+7WsLPMkj31O8DhKeJ9YsoLxgQH+EtDed1wXuduTwV2uh640T+O6n0EtR6bwnHZ5agsXuFdaAtQljOEU5Fqv+Q63ruLdNNYCzuEWw/VO3eJ0GJ9EaGuhg8ins5jBL+a7QJHr/7K/Unxu7/qjlQnzlq1HVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyIYDpqgeqOTq8aHAN1sxivcGnLbIViF9OlS9hiA/pY=;
 b=BNfrTLgpJ1U5OEqACSGVNrHOINpCH5NauhphNgg/fM8e4SbrqpniLFRKhjTl1tR0GONLbS/D/JPv7RHHv0GU41JZKJyWO969xrPbEXTS77eUAXLivfoVmxwOqqlQBZcUE3w8X/Bk+DwAWKEbrTv/7Gr9RShO65eJFd12eTQUQUM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5060.namprd10.prod.outlook.com (2603:10b6:208:333::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 10 Jun
 2025 14:14:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 14:14:53 +0000
Message-ID: <11364da2-761a-4f67-9bb6-908e9d718f5b@oracle.com>
Date: Tue, 10 Jun 2025 10:14:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: detect mismatch of file handle and delegation
 stateid in OPEN op
To: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
References: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com>
 <f580a2f30274ca61f44d4b8d4b5e9779acd84791.camel@kernel.org>
 <6bc66030-adba-48c0-a992-82f7bbb153f3@oracle.com>
 <7993b2bf9c38041f8963e9161aaa25984b50d3f1.camel@kernel.org>
 <c187763c-09a3-4027-9833-a78244a4329b@oracle.com>
 <34500150-e2b9-4b88-acae-aebeb1694916@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <34500150-e2b9-4b88-acae-aebeb1694916@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:610:4f::37) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cc527e-e1dc-4b01-8d17-08dda8292ba7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eFFPMnpEamZBT0QzQk5CR3VOR0pVQmQzbHR5UjNBbHNKc2JIaDRoWTJYNDRU?=
 =?utf-8?B?VzRqdTE0R3pBUlhyM005UUlCZTg0ekE1YXh0UWx1aEU2MW8xeHphV1lHQjdy?=
 =?utf-8?B?ZlBxSzhOZDVsWFdaQk96TUtWUU8wQ3VjQjFYZEdLV0pNVm5WK1loLy9RaFRI?=
 =?utf-8?B?ZFdFUnEzZVlvVWkxZTRHK2RFRXBYYmlmaXhEKzFmdXhSWkJnaHZpTDVuaHRh?=
 =?utf-8?B?dTZBNjFhdkw1OEc2RnZXWTQrNHF2WmNUY1pqUXQyVXIyVW9Hd1hyMi9jZjdn?=
 =?utf-8?B?MWxJbkFCNUNGNTRCazY1UGtLMTJ3ZjlVODQrQ1pxcS9aU3BjUTBOYU1EVGRr?=
 =?utf-8?B?c3lqNmt3aGpINmxadmR3cWxxN2JXVXNveXpaRHU4VFhVckpWS2hPUThHemo4?=
 =?utf-8?B?T09sZFFDdThFbE1pRE1wZms5SVRaS3dxYm0vQkd3T2J0aU1Sdy9DZU12ck02?=
 =?utf-8?B?THBXQTY1Z09HOHdnL2pkRUpMeHZzdDF2a1R1T1puQmwrUFp0R0FjcWkrQUxJ?=
 =?utf-8?B?UnFFT1VMNld0MlJpZURSdFk0YXJKdUUxRE9hRWFZejNRMVppTGJldnJMdE00?=
 =?utf-8?B?dmxNSGxVZ1VrRkFGbWtjYmwzVHZTdndCZVFyeDJzazdYeVlCQ2VBS3EzYU02?=
 =?utf-8?B?aVp5eSs0M01MZitSUjdiRFlPUVZnRXY2ZmhCK0lFODRFYkVVVzdwTjZWT3hR?=
 =?utf-8?B?bEQ4ZDhpd29FeEY5U1ZEa0JZYStZOVZLY0V2UG5OUDZKZzBpUHQyNldtYThk?=
 =?utf-8?B?VjNkamtYU1diZ0RGQjMwSzRkSnEvMVQ5eVZmdGhXZWVUUVArek53RGZMQkdY?=
 =?utf-8?B?OXE2L0hxUThLNEg3Z2NKN1h0ZUtxZEpNLzBRVW1sOTRXV280akdURXAyMHZU?=
 =?utf-8?B?UGsvQkk2Tm5lOExGNXcvWUZ2ZnNEdjdHRGhpL0VhQnJjMUQrTVJ6QWEweTlO?=
 =?utf-8?B?QkpzTERWTlM5Q3hteDJXdWhZUjd1c0RwODFEKzRXRUhkWUxYcjlMR1ZxUlUx?=
 =?utf-8?B?ZjFJOTM3VTNRUHY2UG5CWDZCRmFXSWJWWlFMT2FvbTk4VHlrcG4xVmNlN0pY?=
 =?utf-8?B?VjlVc21QbmlSNENQcElqVStWbjhPYW9iZ25qNEZpelpPL29rN1ZmL3VhbExn?=
 =?utf-8?B?NEcxU3pKWlM5eHRRNXQ3T2ZRTzZLVEQwWTRwRnl5dGs4MHVwYUtiYWVVUXJo?=
 =?utf-8?B?KzNXZlR0ak5XTHhSaHMyNEg3dldxd01QeVhYNjNteCtHMzZkZFlPZ2tSbExy?=
 =?utf-8?B?eHViNktQbUdIV3JkSjBWRlQxSWozamFVYVBYMjNaRWxNeTRjYlhVLy9Hell5?=
 =?utf-8?B?NmlhSVlucTVWMC8vYjREdGNtdXM4MHU5VmNGZEEra1h5NDcrN0ZLNzFsb25a?=
 =?utf-8?B?bURIOU1wMWR3RU4wakFoZzh6YzJ3dGYrR0hRSUdWaUxuSUwyd1NuYytFL2JM?=
 =?utf-8?B?VjMyMzRWL1FiR0xtVTY2VGIxK3RUUWhwY1JhOWMvZXpzV3lmcEN3cmN4TW5t?=
 =?utf-8?B?RGJ5SEhqemQ4YXY0OG8yRW5aWnc1NXJBcC8zZHRBNEtHQ0lMYXRJQTU2bXBS?=
 =?utf-8?B?WVk3Z1lNQmV0V0pzWXZJSUZvWEh0R0xaMWRadUErYXNkY29CYUJNTVZWM3Q3?=
 =?utf-8?B?NnkzU2R1d2FZcnZiUlJvNmdrMVRzcWM2Z3kzWitDZWxta0RCSlN3bzZFMTEz?=
 =?utf-8?B?RXdKZXozNk0zcjlKS3plT3F5YlE2MTloZVFlTHpoRmhBNENWeFR6dW82azZl?=
 =?utf-8?B?RDZscVpXR0NCd1FuaXdtbkNhYWZHa2p3OFhiOGdEdGwwMjJRMmxzZWR5My9n?=
 =?utf-8?B?VlpJc2VLYXB3QkpHcjdSWjY1eVp1NUtRdEtIQnBsVmhuRWs4UEExYmZvQzhx?=
 =?utf-8?B?bVpwVXU4M3ZIWm9qMVFoZTdZK0IxODZzOEZlQ0FnQUYzSHI2a3NQSEhkTGZx?=
 =?utf-8?Q?TFPuG3Xl3rg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y1dQL2lPOUhOVk4yMnZ6OEw3MUhnYXFqWTNjWVM3bTVyN1ZyRytZYWUxSXFK?=
 =?utf-8?B?N3hJU244ZksxaDVmamFPaGM2UEExWVBFZldENlJBc3d5anBlMUFITUwrZStT?=
 =?utf-8?B?djdMc0lDWGk4OXN1V01EZWI4ejRHbUtDL3VLbm8zMGxJSTZwUnZxMElNUE9X?=
 =?utf-8?B?dG1Vd3FBUFQ5bFJ3eXBLdlplMEdlN1l3bmdNb1hUY2g2VXRrWUVrV3VHUys0?=
 =?utf-8?B?ZU1zT0tLMDRSME5Ub3p5eTlLamIxMHVTdVN2eFRLZGE0UnhNUzZId1k2VW5B?=
 =?utf-8?B?ZGJRQWQwRlB3RHV3d2l5ZHJ1ZE5hSmNrOUdJb0dMdDRZVDdJcDYwaWZKVW5s?=
 =?utf-8?B?QkpwQWtoUkxUeEJ1ZlI1cUV0cUhVUWlBbEs1Z2NIWHBabnJpZU9wK05NZ3cw?=
 =?utf-8?B?OFBteThnSThNR3NGZkxjcjVHelJ4UGp5MjcxdUg3SWEvcXFqVWYzYVc0RTRF?=
 =?utf-8?B?ajF3ZGszb1pHVE1rRy9UdEdwRVllUnBPWVN1MFNrb3RUZkFsaERQbitLeXlW?=
 =?utf-8?B?aFphK1M2RnkxYW1JbllocGJNUE94bmRlcDZQQkUrRkNnT2xaZ3FTdWpLZk54?=
 =?utf-8?B?Nndva3V0OXpveGdPV1NxT0MrblJwV29mejA1M2hPeG93QlFVanVpcDVUdzBK?=
 =?utf-8?B?YkRwcmExby9DSU1JcGYzZjdpWHZPZWt0NFE0QWlXOU1seXpaYUNkTWNMb0Zu?=
 =?utf-8?B?SzdSQjNoOStRaHNybXRkcjlaeHFqZDBpR3MyZW1vek9RQUYzamhGRE9ZSUxY?=
 =?utf-8?B?QXZ2MkgrNFFwK3BYS1ljR1lhU014NkhXN0pwaXRENmRLeTFNdUlkN0J3djdr?=
 =?utf-8?B?SjRaT2k2TUkrQ1hqMUIwd2hlYzBoYVhGVXhBQkxETEIxWFd0K1hheGd3ZTMv?=
 =?utf-8?B?OWZ6dHFlZzJIVHZXUzRoRXZ0d0Y1LzE3T1JRTVFHdDRVM3l0V0dpdFRZRHhr?=
 =?utf-8?B?MXI3cjd1eGtrRHJlL0NrMW15d1d1OW9ac3BQTU52aDFLeWIrQUV4YW1jK2RX?=
 =?utf-8?B?UEgvT1IzTmFsYzdka1BqNTZReWxKUUNsTzErbWttUHNwMk1sZnIvWE5yMmdE?=
 =?utf-8?B?OUh3WldpL2dkQ24rUlhsVVU0c0djVWxIQUg0cjQzWTZQelNESDlrOE1uYkl6?=
 =?utf-8?B?UU9ocmNNTWFwVWNVTHJoellsVWNjSklCcEF1RC9uWmRDZHpVLzdpRXIzY29O?=
 =?utf-8?B?a0pqTEdsZC83d3o2NGdDbFlhZ3lxT0RHdFZtRTlTS1llYXlaenNKWmkxQXVq?=
 =?utf-8?B?WEZHeTQ1UEZxSVMxaTVzeldwUS9zSVRWazhlMncwTGdXRjRRWjNpb21DUVEr?=
 =?utf-8?B?aHA5S2Yyd0pVRE10L0NTMjRWdWhwN1AxbmxaZk9GdDV1R2RiczZrYmw2RDU3?=
 =?utf-8?B?azVHTHlxWERyT1FMSlN4TW5OTERJUnUrTUI0MVdqck90ZkwrKzFPbHZTRE5K?=
 =?utf-8?B?U0ZSYW9KMXlZK0kyVWVpSlRBekVxYlMvZ1FYTERjcHByL0dEUklucEcwN0dn?=
 =?utf-8?B?eUdERUpwZ1B1WXdsTWlxQVczM1I4aTBiZ1JjUStYZWUrTlpFWHRkRWVWVTdL?=
 =?utf-8?B?RmFUYTQ1SzlWaVRXdWU2c0dpQmhvMmpiWS9NcjREbUx6WHBWU3h6bXp2UFBG?=
 =?utf-8?B?b3lKU3BETnQ5ODNVd2hNcnZySnFvdi9US21DdW80SFFabUdCM3NUQTBYNXhl?=
 =?utf-8?B?UVdONjFqdjk0cmFrLzhxZTlMSWN4c09rVjJzN0Z2N0h1QmJLMFVjei9HYlJB?=
 =?utf-8?B?ME04U1E5OGFsSVpCN2NrY3psRVlUbEJ2ZDRrVzNkVmNlRktMRnVDenV0T2dm?=
 =?utf-8?B?NHIreDdzNnV5Ull5cVRFU1lteGJ6RHVYKzlGYmVlMkxydFhzUWdMTS84dzZs?=
 =?utf-8?B?U2Urc2FnMjg5dzVaOVFHMTZjWFpSTHl4WHBLMG1HMGxUWmt2SWJJbTMwaE9z?=
 =?utf-8?B?K2dzd1BjdkdvVHlYMC9HZDBJeTJNU2RGVG8vdk50L0NGcHovYndGL2dPRmYx?=
 =?utf-8?B?R0JqYkNBQUNxeW01T0wrYTBiWXpXcUZmMEZmTjJDbTMzOHpIemx2K2JJMnpD?=
 =?utf-8?B?UTVNNTVWSDV0cEk4anVmdzVtRGlnM0NuVkJqRVlFaUliS1d1VEVnRmlTaE5z?=
 =?utf-8?B?cGRkc2lZbUgvV2FLM3EvVXUwMnJ1VmN4K2VlNEtMM2d3VXM0bjNPT3VkS1pJ?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Waexo/8TvatjE8zgdYQm7+d4u+2KwK0Jjwksh4HqvTsmJ56njFRM9xk7Sbi9KRt7aYJzEuuvTkVWwJg1iZ+B2kweDFe4N+jO/juoKkj7TQZVOEKP9MieyIcinzmOudrOKLpuV/SOqqnFar9LpFnDbzDRPkyYHDOoKcoh5bqaNs0yCS2isJv+a4/rJyXxt97gSPA+DpK6P5VOfK39igIPewP9BANAKkW3wrGaHNd7UuhfRXjCUAguO/wp7fGNgrcv88T9QapopcZtxWI7KK4Ejr8RIJY8ADNluYNbIWOFbmZLBuWmT5/EWHuc6WJo7r146KsmXCg8oIAsWhJpP5TXz3MWP12yVEYpsPBvu7AE83k5WKBtve+iKtxC5a6tTEdcIdLzBsULth42U0TYOs4j08pIlayRF77ZYBYjBbBuNcRnJUkzbpTWSqgWw5LSy2dF50qucuXFvYrxQEcUhzO141IWA+ZYcvtzwHKwY/FT0wikY5M1un83nFBcPCCiSENL3glsRj3hrcB1Ch/MoNf60muYpjj2g9irihh7k2og+jKDhnOt9nWSu4ARxlw21vv5rEuokkdz61NwZyCSNyZ+f6ZjBGywg8Ul/UbVbdRJ1QY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cc527e-e1dc-4b01-8d17-08dda8292ba7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:14:53.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1z8CidzRnZwzdYQhTsMIMtYJSaGxO6yi4NxrXBsg/ElLZwB94AQeC/FeINUZ2E1itly6RGer6TjyOFRBdS3MNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100112
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=68483de2 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=q7uNPJL-JHGhrytcxtwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lVitpIkHchrFirNTuVO0EPhQp1qPYjcn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExMiBTYWx0ZWRfX8CfPQd18fNtO Hks5GEWYut6zyd4wEbi7O6gCS/QbtLGHw67nVoCB8GPatGVzAoVnsozdke/SHdENIPeUFMkJ7wA 4Gd9ly8V3EX1m15k+GWTNGpYkRWzT+2a2pCb7+vurNqE70OrFVIv39XL0/s/whI57qGdPRtVP1S
 Qi3Er2l6j7tmLgKploEARV9kgyHdcLtUCTcmSgE2Guj3/mtHteFqnsxDWYK+uE4TMycIYJRp/jT +On8PLUD1ljS1CXHl7jW8joMsLS8qjGb83XMEEK5y2SzjD2s6Q+xQSTQJaQenA9/TG0ZQfUVvqk 9w3Ncxl+4BAkytuyc2mg52FMq2QhRCQBCDYH18hZ+21xY37Sc6qH4MWy0NN51yB1Gck8sJD8MUA
 uGT5ykfKWr2pvxRLEBQZ+M6yl599Jxv8BYv9+39wyig6n13awbuIh+A4ic+53RhWLfgyCbem
X-Proofpoint-ORIG-GUID: lVitpIkHchrFirNTuVO0EPhQp1qPYjcn

On 6/10/25 10:12 AM, Dai Ngo wrote:
> 
> On 6/10/25 7:01 AM, Chuck Lever wrote:
>> On 6/10/25 9:59 AM, Jeff Layton wrote:
>>> On Tue, 2025-06-10 at 09:52 -0400, Chuck Lever wrote:
>>>> On 6/10/25 9:50 AM, Jeff Layton wrote:
>>>>> On Tue, 2025-06-10 at 06:41 -0700, Dai Ngo wrote:
>>>>>> When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
>>>>>> CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
>>>>>> must belongs to the same file, otherwise return NFS4ERR_BAD_STATEID.
>>>>>>
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>>   fs/nfsd/nfs4state.c | 5 +++++
>>>>>>   1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 59a693f22452..be2ee641a22d 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -6318,6 +6318,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp,
>>>>>> struct svc_fh *current_fh, struct nf
>>>>>>           status = nfs4_check_deleg(cl, open, &dp);
>>>>>>           if (status)
>>>>>>               goto out;
>>>>>> +        if (dp && nfsd4_is_deleg_cur(open) &&
>>>>>> +                (dp->dl_stid.sc_file != fp)) {
>>>>>> +            status = nfserr_bad_stateid;
>>>>>> +            goto out;
>>>>>> +        }
>>>>>>           stp = nfsd4_find_and_lock_existing_open(fp, open);
>>>>>>       } else {
>>>>>>           open->op_file = NULL;
>>>>> This seems like a good idea. I wonder if BAD_STATEID is the right
>>>>> error
>>>>> here. It is a valid stateid, after all, it just doesn't match the
>>>>> current_fh. Maybe this should be nfserr_inval ?
>>>> I agree, NFS4ERR_BAD_STATEID /might/ cause a loop, so that needs to be
>>>> tested. BAD_STATEID is mandated by the spec, so if we choose to return
>>>> a different status code here, it needs a comment explaining why.
>>>>
>>> Oh, I didn't realize that error was mandated, but you're right.
>>> RFC8881, section 8.2.4:
>>>
>>> - If the selected table entry does not match the current filehandle,
>>> return NFS4ERR_BAD_STATEID.
>>>
>>> I guess we're stuck with reporting that unless we want to amend the
>>> spec.
>> It is spec-mandated behavior, but we are always free to ignore the
>> spec. I'm OK with NFS4ERR_INVAL if it results in better behavior
>> (as long as there is a comment explaining why we deviate from the
>> mandate).
> 
> Since the Linux client does not behave this way I can not test if this
> error get us into a loop.

Good point!


> I used pynfs to force this behavior.
> 
> However, here is the comment in nfs4_do_open:
> 
>                 /*
>                  * BAD_STATEID on OPEN means that the server cancelled our
>                  * state before it received the OPEN_CONFIRM.
>                  * Recover by retrying the request as per the discussion
>                  * on Page 181 of RFC3530.
>                  */
> 
> So it guess BAD_STATEID will  get the client and server into a loop.
> I'll change error to NFS4ERR_INVAL and add a comment in the code.

Thanks, we'll start there. If that's problematic, it can always be
changed later.

Maybe someone should file an errata against RFC 8881. <whistles
tunelessly>


>>>>> In any case, whatever we decide:
>>>>>
>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>


-- 
Chuck Lever

