Return-Path: <linux-nfs+bounces-13639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F401B26808
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Aug 2025 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6A5164A77
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Aug 2025 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0E12FB987;
	Thu, 14 Aug 2025 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VVXNOthn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zzrMZmzZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A2318150
	for <linux-nfs@vger.kernel.org>; Thu, 14 Aug 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179218; cv=fail; b=KpwBTXoShmZ5qzVNtAnF+JWgVHIWUjbfPjQgWm694iZgrDJL9gERzTbdNZs30DHFyeFAgzV8X69E4rGTZfKn9o4voKJs2XrgyTsEZAAOq7wKlQTpucZY1SXDQ6lS8KCsNly+AiRcQufrrajLZTkUrrqFMFt7/vgNN89YE23T1FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179218; c=relaxed/simple;
	bh=WKcs7rqOk9xcQNIuyJNLWNplAt3tm08xVi1jelLZ1LQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JtSl4D/WVcXxtDPKwT0lBe7qLUFo06eUe+Gg4rjuqJyxwaFR8mu98LmJFZh5R9O2a6rx6/bR0UhzW5YxYeMzrVMiQI1MU3p3cPCHQ60n9fkeKQKkQOwFu+4TxbtCxs94Eol2fiy3e+qtBJpovcw1DI0O3LXv6DVOsq8NcM6YQv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VVXNOthn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zzrMZmzZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECgPVE029765;
	Thu, 14 Aug 2025 13:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JlKqovSyn8/k3PNBX0VRObFeqj0TwmAVlwxPr0OyWB4=; b=
	VVXNOthn5SqkZ+bkV4jSnka4ln/bS3ycpLYuTa4rjGgh6hFYU2QRx9QtHZSNxN86
	3N0zKfUbNrf8SKKvasrYkgH21Te4W8firH3783VZqWUV0aPUjUwZqmQguFZDPl9Q
	QyxHXt39FKO+8pKj/bL6HToAF6cvvrMCSS+FT+dwWqMzfGR3o8J2nx7dH6xaEqY7
	ViuNRK6eFU6oIvLzxDBvzWW8LHD/1yqftqYBt9mpH5tT+kuT+b5ksduUmchQ0sqA
	xr298p7V73exHT7bLUXdKPD1LJ0kDhzSz/uWyLbModoZpA/4KCGEa1jYcKzHof/y
	xajlHl21//Kbj0h1qxUcYw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcfa4ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 13:46:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECKwS6030268;
	Thu, 14 Aug 2025 13:46:46 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvscsvq1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 13:46:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiHbK1vnXPq4INF2a6Pc2jdfZlmatozLUdIKs8lRfNKM9EtCh2fxib8ON6plSavVTszHMO5YgwA3ejLW5rdEkO2YwhvUscL1LOe0rpys/SS6BcOzqWG9B2PXi0mGeGDr5PDawHHSjLbLP2vfHrYBNCUACf6RP1u1UIV24FXVWJKE5c4pB2aQMa3HyAuutc1fLkIzc3J/KbqTbRaXrMamYO1bCyB8DAvwn3J+jDD0nuAULZ6iQbOMwcNvAGMs0L4Mg2m95bsAt4WXBykrAvWApRG/opX4fcpvt8hnomeUZHUX4iDer7+hk6HRqs/fUWlj1P5EOxMdVpmqFWQIRXNw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlKqovSyn8/k3PNBX0VRObFeqj0TwmAVlwxPr0OyWB4=;
 b=Dfb5IgAMfzl+tkheFectcDp4bDCjp2lsIDN+ilIUpqMxt1dDKV5cftIT7H4fF4UrdrKHhl5g0hMRTX3shxzMq5/h65fcc0jONhA92XZ2C26GsIi5YliXRnBfAHxvMfxPsAfNmb2nQgQvwP45AORHsUNz+SZ0R6fq/zYv3ph2Xq2qHHpsQMslHkzRkSpYvvsQxrcnhp9IWr5nNdghhkBNaRFtVECETZcqFambCu2/Xej4goGKSISF5N0cQDSaeZQ3Np+72cExpBxYBa91Do8Q1z3vla1OjX1zaece0h0RfZROkDwmKrCR4MKHXKLakKB3GpB9dVO/mCQnwTc8dNJwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlKqovSyn8/k3PNBX0VRObFeqj0TwmAVlwxPr0OyWB4=;
 b=zzrMZmzZF+tONyPkYOf/ZX8rGILuwQ1PvDq/O/rbpxA/E4zsz+KgddCSBcCoSF26LnW+xSnsCAz6gT2N//1q1yx7ZY3Y8VQPkFmWfRH7jYV6hC4rokMe1lYH5ogQAsN82w6eoo1Tq49azF7zigHnX20M7P1+4hdXF1Ymfl7bXow=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7567.namprd10.prod.outlook.com (2603:10b6:930:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 13:46:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 13:46:41 +0000
Message-ID: <f1df7876-84f4-490b-9c3d-c332d216c5b1@oracle.com>
Date: Thu, 14 Aug 2025 09:46:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when removing listener
To: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
        neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
References: <20250812190244.30452-1-okorniev@redhat.com>
 <2a024899-6be0-4349-aed0-ee05e196fc1f@oracle.com>
 <CAN-5tyEpg=vZGXkGYqjq3RLC_h=rt3akXGvnqKzddtLJ8Q0O4A@mail.gmail.com>
 <07bb55026499e120c2057429beece2638f4e9256.camel@kernel.org>
 <b45634b4-6074-4255-ae59-835bd597c6af@oracle.com>
 <3234d854389417b834a26edb16c812c9c1f4172e.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <3234d854389417b834a26edb16c812c9c1f4172e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b74fbfd-271c-49b0-221b-08dddb38ffa2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dWZiSkdoRGQvLy9NRFd2SFJzS2Q3QmxiTXlrYnBhMkFGbHVwZ2VMNHo1K3o0?=
 =?utf-8?B?d3g2eXZJVnJtNUlCRjBnTmJyM3JUQzErbUFPS0grZVZ3RENqSEw4V2RySkda?=
 =?utf-8?B?K05HUWNFaGVRN3RxRGhXRUpXRzdFZytjUk1ZQklXT2tVM24wa1g4RXFYRjhx?=
 =?utf-8?B?bElQOWdaVVFSZndHNm5mSm8vWlhpSWJCczNyVTlLZmZnaE1vRFloczFpeWNm?=
 =?utf-8?B?ZWRLVlN2a0xMYnNwd0E1M1JDSkVDMmFvNlRYZkRpckNtWUowU1owcjJSMUgz?=
 =?utf-8?B?TGFzU2c4S0ZIbCtrQVAxeVVObk1KUmQ4TjZYSE14ZnN2VXl6SElHdUxNejdl?=
 =?utf-8?B?T1BFa1puOHd2Y0srK0xYanZucmV1VXpQNDZmaGJkd1BGZHo5VVNiMHo3Z3Zy?=
 =?utf-8?B?N2ZyZk5Idk5VSTdNaW1lSGd0ZmZWajl2MTc5VHhQdFhCUnZqOENmZVZUSUYw?=
 =?utf-8?B?QlA3amdCbjhkRXphOVdPbG1rR0hFLzNvUStiMTNaQmdnSEI1M0w1cFlQVHc2?=
 =?utf-8?B?eUlzWk13WjVnMzliOGtZdVJjMlFwb29HaDg4UVJZR3F1R2E4SVFWaDFFbDl3?=
 =?utf-8?B?TjhoaHNTZ1NVL1plbTB1SENyMWcyMVdWamdVU1dkQ0VzS1N5b2VJcC9qRnUv?=
 =?utf-8?B?UlVUMmpiNU00cTJ0Tjd5QXNkeWxyb2FsOUZKR3lLMm5zMzZPa2dXRW92V0l5?=
 =?utf-8?B?K1lOSVM2TDhoKzl2QVVvOTh4dG5FK1h3OGdvcXIyK0dJZnJ6YzhmTDBhei9E?=
 =?utf-8?B?QVp3TGZCVS9YWmE4UGp0TTBoWEZYdmRaN2ZQYlB0KzQ2cjUxUVhMbEt6d0Ry?=
 =?utf-8?B?d1pqYkhtcGxhMjlxbEZwenZnS0lJTzVzakJ5WFlPQlFEUXErdW93QVBFcEYy?=
 =?utf-8?B?RjNlMzFVak5Xbjcrek53TmxpcE9ub2RSMFE2RUNzNVptQUpJQldOVGp0aVNi?=
 =?utf-8?B?d3ZwbTlHMUFNSDFxNEMvR3BVdUhldndid1d5a0NsTWt4M0ttQndCeHVWa21z?=
 =?utf-8?B?am16b2lIQTBpcmtkaVNLRkFIS1dVcVhhRkNXZi8xYksrNng2Q3kxMlQrWlgr?=
 =?utf-8?B?TE0xSGZVdG4ybkNKZE5aU1lucHhvOThIQnlWV255M1lUWFlDR2dSM2Exb01X?=
 =?utf-8?B?ZVFFcDhjQlF2VmlOMzJETk5HcVZHVHNxQ0hxQUJXeld3WXUxWmRGUGExemdF?=
 =?utf-8?B?bjJNdzh1UHZ5ZjI4dVBaUlMvbVdZd3lWOWRhSWFjNDg4bmdvdzhBRVhHNVNV?=
 =?utf-8?B?Z2h5TnM2NEhhYXUxazNaNWFHZnkvVkVkZFkzZXprVXVEM016djhzandFRC9z?=
 =?utf-8?B?ak1VQmEvSUNHSVV6a2Y4R3BRTGY0YTBJcVBnQVoxcEZlTlJMaTNpanF6Z00r?=
 =?utf-8?B?SXpod3Q3L0haZGFpa29uREZ4TVc2dGFKa0JFazU3Tm9uMzltQW1XR3plNmhp?=
 =?utf-8?B?WnJyellsKzI4QUZsSVZTTTZwRXQzaUhVRW5XdFE3R0poUmcxUzIzY0ZKMnFT?=
 =?utf-8?B?RWpNUkVUM2JPZnVScmMrVXIxNmRXSVhDemRzYy90bDVUbTFCdUtMSFM1b01I?=
 =?utf-8?B?eERReWNtUjVKaXBQZEI3YTNRbXk2WXdkSzVHbnpScVRHWk9IQWROdDJvaTNt?=
 =?utf-8?B?UlRlWDMyRk44M1dURmI0OTdmTmpjRWhMWEM0VXhGUGljaFhDSEpianNiYis2?=
 =?utf-8?B?RDlRL2dyTWpwVjViUHlPRkNVd3hWdHhCWWpqcyszcCtkQkJyS3dJeWEyQTlY?=
 =?utf-8?B?YXNZOE4wZFNYeUVUQ21qOFVBK05qKzluVndFUGhpUTgxN0ZaSjRaaXZnWjJm?=
 =?utf-8?B?N25xZnhXWExoMlY0ek5zbDhERkhGWGJqYVdBd1JWanQyWno2QVpwZGxEQmJM?=
 =?utf-8?B?NUNwWDM4dlBFcFU0ZnBuYm5jUk9SeXJsZnl5QnVML1RKa0l3OWhIMXRoc2Rt?=
 =?utf-8?Q?TaHNXMpDR8w=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dVlOYXRLZXRXR2lySEVpcGl2WStjdkF2cm5mcWJyb0hYY0ZJcGZ6bTNiT1lh?=
 =?utf-8?B?WFR0WXc3ajYvYkVuaEJaMVJVYUhWY21mQXljU3ZtK1JvY0s1ZSsvTXJZWVls?=
 =?utf-8?B?anJnMk1nQTVCQkZmVy9SMFlNVVljRjJkQmY3YUhsdFBWczBwM0o0NlhEV0Nv?=
 =?utf-8?B?TDR5UVFTeThEK3M5UTFrTHUwdlJHSnhzY2pJUThxdFFRNzVFZ0x2eCtxeGg0?=
 =?utf-8?B?R0thOCtjRHNJOXdMTElLTGZYUG5jajRzN2tsa0s1R0xoUnMwNmIxeHI4TG1j?=
 =?utf-8?B?Uy9BSjZ1eEREdjZEVTNGUGc3TktIUnhPR0VSRUQ3amloWk02cVFURUZOOGk3?=
 =?utf-8?B?amtUREdRUDhxOFVMd2ZoNEtsQU5EcXhmcnUwSm4rbGtTNUxVUkVsdy9kZ01H?=
 =?utf-8?B?aDhrTGRtd1N0ZzZldmlvaHpHNlk1TnNscXNhTDZLS2wyNUNjeVhudzIxNGE0?=
 =?utf-8?B?eWtKYlRHdEJJMVVyWTFOZzFzMDBONTJNWUIrbGFKaUl1MUJyaHRURjloRU1r?=
 =?utf-8?B?dllzZnpkSUZYclJRSmpOdmMzdDdpSnNaSlZDMldvWEREUkc3R1A1c0E5QUhE?=
 =?utf-8?B?VEUwczR6VFRuZ1psOS9nM1R2K1VJRk1ZRU1ObnB3NE9PeDNSbG9DWFJiVGZy?=
 =?utf-8?B?bEN1eDg4Y1ljNmFvalE0TU1tR2ZhNEU0UUtPV05obFVuMEpiTDdxcXJRVVJL?=
 =?utf-8?B?aDcySXQ2RDNLSGY0SytFVk9kNXl0UzdDMUM3eXhIY0tzbnV5cjB2SFlyUlZI?=
 =?utf-8?B?bzYrSzAyTDdoMTNUcHo5V05kVlhicUo1cGt0QzJKVUo2MlNhalFQam1zVHl1?=
 =?utf-8?B?UXJHci95UGROQVZhM2dKY1gyOVJIbkhtQm5pRUNNQk9wekpqYzVVU3BRdlJP?=
 =?utf-8?B?enloalFHVGhuZWp0SkVVb08wUFZaL3BRYzQ3dXluenZubzNjOGRMZW1HQmF1?=
 =?utf-8?B?NG52RGg4NmlzbkZjU2FQeW0weTIzNDdLakM2WFhkWFg4eUFwdTZ0aHhicW1T?=
 =?utf-8?B?a01FOVFqbVFyRXRMZEtoSDlkQmU1TzNpOXZKVEtyWG42QVI0RDBDOTF5L25M?=
 =?utf-8?B?eUZyMEN3LzUrRVgyM0hhSUs5THFDOUhKV0JNd1lINEsrbGw0dXM2ZVRKR2Rr?=
 =?utf-8?B?U24xTXZhbUYweENZS2pBdkEycVlxWE43bE1tSXhHcUwva0w4emJhWUhGZjd0?=
 =?utf-8?B?YWh6WDlZM3cvTUdIU1VnT25NSHVtQnhISm5BRmhqQ3hhcFl5OFlzdFNkNExQ?=
 =?utf-8?B?azFscXUrYzhFVzBOVDI2WnFrOUpvZkFrM3VRMGVCVmZlbUJlcVhMUkZmVGtN?=
 =?utf-8?B?aE5HVmg0d0xQcEtxeVRnSjhwd0szU0pEcDlYZFBLRW1QeXRtZkR2NVFnMndY?=
 =?utf-8?B?ZTVNZWtxZW9UZTdPRkhwVW1sOWJUM0RnTCtUSFUrakZiaFg1bkh6TzcyNkpQ?=
 =?utf-8?B?TzVMMUFVSUM3OHZtYzE5Q2MrZzh0WmN5MU5wKzBidUJ4ZzRQQXVBRld5eFZH?=
 =?utf-8?B?RSt0RXBQQ1NvTEViV2pNeVZQakFPekxoODhuTnYvaXRBaUhlaC9Kc05pcERV?=
 =?utf-8?B?TlcwWndBYzNqMkFjTFJHWHNvY0FhaWlweGl1TGxiTDJEZ0taKzIrL1Zpb2NZ?=
 =?utf-8?B?TmQrQVlSemI2ZU9WWFIxVWoyZ2JGblU5UmJhdURoUmFnSVZJbURHM0xDV2pV?=
 =?utf-8?B?ci9Xb3VaeU1NM3FFNEZVckQzbEZKQnVEaEowTis3S21WQWtKTWM0YWJKOTF2?=
 =?utf-8?B?RXJjZ2hNQVdhWmVkQ2U3bnBNblFrK0tESXJqeGZid3Zqc2t1R2dpS3dBQndt?=
 =?utf-8?B?RXdSTnprNWlBOHdRT0VpRXlBRHUwQVBFMElqVHZ5djhiL3JLVUQwTE5kYXFO?=
 =?utf-8?B?N1I3QkxFQ1Q5MHdEdnhVajdGSk10ZVZxMFN1TnJhazkxclF6S2Z1WHpFWXA0?=
 =?utf-8?B?RkFxK0RiTkxLNkFZTlJ4WWFHZXl5Q1djNUxsU2dUU3VmWDRManIwcHBLVk1S?=
 =?utf-8?B?U0VQdFZ4eTRIc1FGeEpOTmJyeGs2NjJIbGw5c3Nybkhtd0ttVGR5dDAwNGNa?=
 =?utf-8?B?TTNiQnhBdXdjL3kwOFp2ZTRJOEFQZ3JJcW1tVnEydW96KzBCQkQ2YmhONm5w?=
 =?utf-8?B?SEM0bE1ldUdYR1BhVVFWMzcraVNYanJBZlMyQU5McXFNNGdacDBkMG9Bb3g0?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uVENEeaEU1SC4/oZvrGATeQMsLVZ8d/pGici/ADexfEve3FXoofXkvYQT63aSF7Tx7Gvdgu7MNjZSJVBFmYWze6e4pzjNuBB7OLyt0u3uDSb3wuQuDK2bEXoTG7V7vCjLhc4D+dikCTeLmEgr9Nsjdrg5gMPBUCXt+Uz823ZBYrfU4sZ0fPsykEFmRWB2wgVbAuasI5uA5TlA8Q6Kdsnn53JhHvlvhF7tfEwEWubM/zAD9wjkVSjqBquDY2H0B3bRt7Nu72t73apsFrLT/a5Xxi26avyoPrBQXFg0DjzDxKgIKyQ6Joa0UwsrtH3r2hmgpBMyMyJQYmY4RMQRwRGbLVKUxO95P7sHh6npORsxhh5PtLWcDmdCiL1l1U2Bm07ihv4DGSo2z7Cd+EoW4ePGMZMV5densMeIIOSn8wQwrFRYtKbpSnV5NFn1GUebE6w001UlSfWcvkm2C3ASoQqGtTRK1QGpY6bhLzvzUD5UuBoYKJ5XabimrqOQjdPdiySOq5tbFOk6Qm26OjUXHauvZpNBteCC3zJ7N+1DzFWYlWQsTiMG4aekPSlYM9CearPttmSDfyHZBq3uB9JCMZptXb2w47KMewR+0NisSGUato=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b74fbfd-271c-49b0-221b-08dddb38ffa2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:46:41.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GTC4K7zB3ZbV6yRL5F0UqRSqmFIgWDM9MZgPcxF1DIPMh7do0z96unoTSG0ob4Koyp9a0v/kfEzwmWPMZdPSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140116
X-Proofpoint-GUID: z98j6ZKYjM4tcd7NBvtAASG0759mKn94
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDExNiBTYWx0ZWRfX643R9r3e0wrr
 cLImqT6UzGe4XdIgq7O1dQiylLxhGLeCug8tF3Dv2w4JdZXymHdpYWbrJC47/QLYUQbSLEmpj1w
 Jdqs1BDQHz5AoEQUPchTM6tZ50XvrSqk1wOVhO+sZb2merUjV/XyPv0fdFsd7HxSDvLViRlsAAb
 PJR1REqYUbJmRn6yxYIrwYfBX/h/zhG4c/LQoUVK9/WOBWhPOKcZYoPwjGUh/JJBVoaCmmc0zYm
 BTwtoPDHlXOvlYVRx1TJYh5dSzXbxzi3S4ztq/386EHrSM5wRqYxM7EHZKtsspwzeq0coOjrdPc
 lHmurIofVssOQ/seu5wRxSsgV1mrB8JyRvPzuFJ9NTevdXZ0NKRW7Lk7dgHANohM7jS8cuwmc4J
 sjoMjHUjJSlFTT2U3qlfMcmjyX2Bu3bPN2ytzXkPkYQ0LHcRNt+nOuLpHIRD2VrsJ1B7P55M
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689de8c7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=RfpxFgRdUqQ7pTNvf_8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: z98j6ZKYjM4tcd7NBvtAASG0759mKn94

On 8/12/25 4:30 PM, Jeff Layton wrote:
> On Tue, 2025-08-12 at 16:00 -0400, Chuck Lever wrote:
>> On 8/12/25 3:57 PM, Jeff Layton wrote:
>>> On Tue, 2025-08-12 at 15:13 -0400, Olga Kornievskaia wrote:
>>>> On Tue, Aug 12, 2025 at 3:08 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>
>>>>> On 8/12/25 3:02 PM, Olga Kornievskaia wrote:
>>>>>> When a listener is added, a part of creation of transport also registers
>>>>>> program/port with rpcbind. However, when the listener is removed,
>>>>>> while transport goes away, rpcbind still has the entry for that
>>>>>> port/type.
>>>>>>
>>>>>> Removal of listeners works by first removing all transports and then
>>>>>> re-adding the ones that were not removed. In addition to destroying
>>>>>> all transports, now also call the function that unregisters everything
>>>>>> with the rpcbind. But we also then need to call the rpcbind setup
>>>>>> function before adding back new transports.
>>>>>
>>>>> Removing all rpcbind registrations and then re-adding them might
>>>>> cause an outage for clients that attempt to mount the server right
>>>>> at that moment.
>>>>
>>>> Ok I'll take a look at unregistering elsewhere. But to note, removing
>>>> a listener is only allowed when no threads are running. Thus no mounts
>>>> are possible.
>>>>
>>>
>>> Right, which is why I think this is fine.
>>
>> I think Olga's proposed solution is "fine for now" but IMO it adds a bit
>> of technical debt that we don't want, long term.
>>
>> A better solution is to make NFSD listener creation and destruction
>> complementary, if that's possible.
>>
> 
> Agreed, but that's a bigger project. Note that the patch below is just
> adding rpcbind dereg/reg to what the netlink interface is already
> doing. It already blows away all of the listeners and recreates them
> when one is removed.
> 
> Changing that is a bigger project, and at that point we might as well
> also allow the removal of listeners while the server is up. I'm not
> opposed to that, but it may be considerably larger change.

Change size doesn't worry me that much (it will need some strategy,
though).

But two practical questions, then:

1. Does Olga's fix need to be backported to one or more LTS kernels? If
   it does, the narrower fix is probably better for now.

2. Is there a concern that the "larger" change will result in ABI
   incompatibility?

IMO both of the current behaviors (replacing all registrations and
requiring the server to be shutdown) have negative impact on server
availability. Adding or removing additional listeners should be
seamless.


>>> There is a small chance a
>>> client might see the bogus rpcbind registration, but that's still
>>> better than the status quo.
>>>
>>>>>> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>> ---
>>>>>>  fs/nfsd/nfsctl.c | 5 ++++-
>>>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>>> index 2909d70de559..99d06343117b 100644
>>>>>> --- a/fs/nfsd/nfsctl.c
>>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>>> @@ -1998,8 +1998,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>>        * Since we can't delete an arbitrary llist entry, destroy the
>>>>>>        * remaining listeners and recreate the list.
>>>>>>        */
>>>>>> -     if (delete)
>>>>>> +     if (delete) {
>>>>>>               svc_xprt_destroy_all(serv, net);
>>>>>> +             svc_rpcb_cleanup(serv, net);
>>>>>> +             svc_bind(serv, net);
>>>>>> +     }
>>>>>>
>>>>>>       /* walk list of addrs again, open any that still don't exist */
>>>>>>       nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>>>>
>>>>>
>>>>> --
>>>>> Chuck Lever
>>>>>
>>>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>
> 


-- 
Chuck Lever

