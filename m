Return-Path: <linux-nfs+bounces-13940-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E141DB3A63B
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 18:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC10E18944B5
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 16:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2283322A00;
	Thu, 28 Aug 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YJxom4jv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Etn5TXA4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96C22D793
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398463; cv=fail; b=ZWkJr7Ge/kM6HENBVK6hPOpxBw/i+yadn/6M+Z0mSo1E+CZ8AjMcPBtjwWgqwepUFf5KAo0yusFP61236lHodRCXYN56AaVg6odW2ai3x5TM56FiEO0ZMe0LftCkaqlwb6KI5/p9PhmuX+TP1Y1Zy0dGzPS+U+JhSrMKbfxP+qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398463; c=relaxed/simple;
	bh=O1GwRpzGqbtJZ+xbQST3MgvdlBKXUWEgxpJ+X9iQxKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eq7GZtb8PWPEXVibMPCAXGvmq7BhYpjufsNsTyxkvb+Mtxnwd1D5AU9itmvNSE2FVEv+ihO7HeDDUSGeSblVncuovCn4Ni+HZHwFLRPyZi5Y3zKk2GbI7CU1JebHD+Kzsu3vZ33w0dxvw0t5aphtmvA+pb1lnfKf2IHoa/vcMYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YJxom4jv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Etn5TXA4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEN2oI014302;
	Thu, 28 Aug 2025 16:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=o7wkwj/OgbLvkigEjTsqKdnyZyhvoXb3Js1te/OWfRc=; b=
	YJxom4jvXSIugco5XRw1oV0k8Ovg0ma5bqa/sbsGyLFWefYMrgeVm59sViTaEiXv
	JYIeaJr5897TT23g7nGQIvNyuN1kGmdXpSyjMjdAMfsm8ksmkoC0kYo59xxlShmW
	Sp/80hfQ5WMO2pF0cZGC5kN2ejHOwwsStlskBb0xYdifQGoXtvLeKh+GOR+fUZjr
	4CspGw8Pj0+xAHq6kM/kxOggMLQgLzPk7xS/4Rr+4YV+ZASa3ACWF+5A9NWniqCH
	mW0Pxkl+GvC7dHrl4jt3jXUN99G8rH329ESZMpYjGB3Hpvtvftdu+oVgPGq+ciRB
	xHvaGG0GFH07FhBUYPzXfA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q6790wsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 16:27:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SFbBa1005063;
	Thu, 28 Aug 2025 16:27:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c7kqx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 16:27:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WndjlGvTUz9/n3/UyE6VZoSa/MzyFM1EZkUSDbMKTGsr1PZQcc02q4FJWEpIH2nB26Q0PX9/TWnm6oULL9LJEtq/an78k1pEdEDe1IsqAKChycqwIw0mM+htADG4qZCXFSKg5PkMAzeGF4EyUVnJKMFMgpySiWlxfnCgkkjUEaAyVUL/rbCXdolW2YNMtL9HTnesIMSkQV2uEVSHPAsJBu9Mz+S1Seu2CuG1lmpLwHjtgOxH01Jw83bEcUb+HYKlXt9By6smccR5NeMZaw8sTGVlJWRiS5vD7GeG0uWftOhD0Tf61xY7/R8ZxgW7EKX1cUpu4paTJj9jrKKgBFxHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7wkwj/OgbLvkigEjTsqKdnyZyhvoXb3Js1te/OWfRc=;
 b=BqQfOOEv7CJsXRFi3dlo5ZEbO8TH/jyWBSOn6Lil+uoWWsb/1VAXZcUX51l+60kZYJRuHq6QkvTM0noYyCO/THtZ+wpiSA+SEzQ4HmUjpzUXibmNOC7fmHu14PjgzCMhZ+y8DGDpe5wmW0Gvx63xIZeKlDsbYo4RosJeL3CXvfJB8YXJuIbG2RCXNAvZm/Ig838LR7AJnFoo5wQtl0e+uBs3ua/Obfs4tPZ+FYCYfMdcGJrOPGWhXaIgd66YI/jIVH/UeHT3QnWUeNS3ZvvCJdyIg7ieBXMdWs0SBwNulddSMqLj3mSXGdc7Bi3TyLzczqTBziHtxEZJQ9FIIWUWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7wkwj/OgbLvkigEjTsqKdnyZyhvoXb3Js1te/OWfRc=;
 b=Etn5TXA4rOEbn6yZBK7a1rh7oICQcMnN/53yJcL0WGn17X4HR4CDlFUM5RuYJ0hclHV2dvRRdYi3qpQiOximiaMIeIjSehsV92qdXvpdOFOU0mL+CxmtMvSbx47uAqpV2mBa4LGQaUPJba8t5JFhzDkmti+PEq3+1QUPlGP9p4w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 16:27:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 16:27:30 +0000
Message-ID: <c07ad4d4-abba-4106-9bad-7bf4e771535f@oracle.com>
Date: Thu, 28 Aug 2025 12:27:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-6-snitzer@kernel.org>
 <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>
 <aK9fZR7pQxrosEfW@kernel.org>
 <45ccb9b479b2c5af09755c95f3dbd5b29db4370a.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <45ccb9b479b2c5af09755c95f3dbd5b29db4370a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:610:b3::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e41f679-c403-4e45-923d-08dde64fc893
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RHV4YmdKbGZqZEF2NVZTV0MwREZJcXo3VEN5b3JpNHVUVXVrd3hnZzlJUGRm?=
 =?utf-8?B?MWRhNHc4bVQ4NEUxMG1LanJpMEtSc3g0Y1psTE5YcG1QZzdSejVLd3Vnem1J?=
 =?utf-8?B?d0VQNFpMTUlEQi81WWV3UTNyOEU4Q3VSQUZRSEJUa2tXaFVlcE5sYlZTa0F2?=
 =?utf-8?B?TUFkeU8xWmd0eTJDU004MWRid1B2R3hCcVBzMFB3QlVVelpsY3dtSmRYRDVh?=
 =?utf-8?B?eDFYNmNkYk1Xb3VmckczOTRGSzVNVldMRUQ2dmwvT3ZxREN1cUIreXd1NUtz?=
 =?utf-8?B?YjZ4YWJTM2dEVmoxeG81TDZvaHA1WU5MS1NlQnFvaVNGQmZBTnZRWnk2Ykk4?=
 =?utf-8?B?VUJZZzV1aFVVTVhKTXNmNVY4RnJmOElSR3B2WVM5M2pNSWtJRzN4cFJPdGRS?=
 =?utf-8?B?c0YvWGYwanBxSHBJQVVudEdLem9jM3JuZm1KUzIwOUgwWVZ3aENsZG5ITmlo?=
 =?utf-8?B?TDFPekpDS0VVaGZRL2pKZGlMNzM0Tm9pdFNUZnFYaEtUUkNiMTBSMmxKTUVo?=
 =?utf-8?B?dlZJeGVmaDhXNmc4MlZmQ0ZDTkc3MzZ6aHcxQTZnTzRGTFY1WlZxZTR2dzdR?=
 =?utf-8?B?SzV0enBZZm9LcWpDMXF2YzJ2Z3V3ZVRMUWVhaTErZGJJL1hUcVJNOTUva0dU?=
 =?utf-8?B?VHRGTkI2NHN6ZjhuUWFkVXpnN3orR3ZlWHJWN3V3VUovdFA3b0RqckdKVTZr?=
 =?utf-8?B?Nm12TFNGYmoyeS92VWZlT0RCYXlKdEJ1WnloMGlHaE5XWUhMSDdZZ09sNGpM?=
 =?utf-8?B?aitzd0ZqYWpPUzlZZEFrcEttbVRrTlNxMTlUNHhiU2RrRjluc1FiaVRJN2R1?=
 =?utf-8?B?VXV1ZWd6TWlnQ3R1bFI5S3pXcG9UbGV5bmxtRjFNSjVIc2hHZzBHcm5hN1Nl?=
 =?utf-8?B?d2ZzVythUGhEYnVEeVBSOW5Rc1VhcFRhZDltdlVCMkdVRXdQWmpabjlEUlZm?=
 =?utf-8?B?bVBJRUZMVzl5OEttSW96SCtUNXpWQmdYZFJNRUg2Tlc1Ylh1b3NBRVpsVjI4?=
 =?utf-8?B?aXZtZXo1NCt2REQ1czhLK1ArTzNCZmN4aG5NTXdLOTdmWUhWWjkwd0JrQko1?=
 =?utf-8?B?aGlkVS9lZ2FrQ1lMb01GWnQxOUlYY0Z2SXlrY053ZzBXZHVqa2dtNThoUS90?=
 =?utf-8?B?QmtIRFg3MmtMbUdodXNHamdRbWZjUHB5RVYzTlVmb2hjRDlNTmFnTGozMEYy?=
 =?utf-8?B?RUFRZTA4dUR5bG9laGRqTzZjd2xvK0FmR2tSTytHaVlKVlFKenBQWWhtakpz?=
 =?utf-8?B?VUNKMkxBTndEcTd0U3JueUJnN3d2WDZDTGhNWktzL1dpN3pCdFBXUkZUMUgv?=
 =?utf-8?B?RUNVNGRheSt2ZDRiRGMvTTJBcU1wUUM2STIzeGxUV1NDTVFYNGVmZms3U0VI?=
 =?utf-8?B?Q0lsT1BnWS9LWWp3eVpReE1sNGwyV2UvR3JKRCtvMnEzcGI5aDAwZ3d2WUFE?=
 =?utf-8?B?amdMNGRDSzdGeWlxb1Bwbis1V25XMDlTVGZtalJxUU1GZ2JEeGdKRm1TaTh1?=
 =?utf-8?B?QWFORisyNHJtUjZMNmxXYTFlSFJ4TExaemt6WHNoazg3dngxM0dCbjNvT2FF?=
 =?utf-8?B?Z3RubzZ0UTRNcTBDOU9TaDltZ0F3cmVJVXEvZ3hSeHdKWWJySFZ5SHU5b05w?=
 =?utf-8?B?S2JBL2RlcVBFVXJCQVlpbEgvTWRnRHdNZENwd0I3alViWGNsaDNBeFFpbUpU?=
 =?utf-8?B?TXlOcnFQNHlKVTd2TGFhZXNwZlo4RU0yUGl6aWYwTFJCUjBKM0NQWUVpYmRC?=
 =?utf-8?B?VDVGMDZpYkxDd0o0bUNZK21RWVlNaVhNYTRZb3RtMzU5NU5Qc0t3WmdsV2ZZ?=
 =?utf-8?B?V0k1VnFZS0I5TWhUSDJxRFZoTVNWUjFxMG9pYWkxcTd0SXFJSUwrRGxsRWFs?=
 =?utf-8?B?ck53QW0vNnUzdy9id2h6STRaUE1rWU9aeE5TYU1EVjZPQ1FvL3RTWWpueTdY?=
 =?utf-8?Q?yoRq6eNQ+k4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a3labjcwMjhadGl4QmFPdGVzNWUyd3FlcEhrOE9UaUxJRnV4YTJZMzJUSDlV?=
 =?utf-8?B?d0d6UjBZcEd6NDBURGNlelJvd1h0L2crc0dwd1pZSFg2WHlHSUxteDA4L25n?=
 =?utf-8?B?SytCUlhvWGlvbnkvdDJWMFN5QndNY2RmNFJSQXkraWRkS1cxUU52T3BLSTlJ?=
 =?utf-8?B?bFVxQlNwaHc0N0JqdktJa2VFdE5ieUN3UFlPelBKQi9qSTNlT0QvVjAzNEtC?=
 =?utf-8?B?WFNsc1ZueWtPN091Y2h2WFlWRURjZ2xXZXNpUHJrbTQydElSWUY2cWVLaXNL?=
 =?utf-8?B?M2xqZGxJSEp0UFVLMEkzRE56M2xRd241WnBjM3B3UXdadERDTDRaZm1yMmx5?=
 =?utf-8?B?SmFzSDg5Ukh6MXJBR1U4MDg4WnRVWHJCS0RsVzlhUUgwWk1CK1dxWVJMcnFt?=
 =?utf-8?B?Vng1N01qR3hHL2ovc2FURjBwYWxQcHhmNEp0Z0lLMmFRZGlFeU15M2czWGFT?=
 =?utf-8?B?NFJkL2VpcXVYU1kwTlZZREtZYWVPTGNIeGhVWHdwdjEwaEUxQ1htZjhMNTBa?=
 =?utf-8?B?aC9TYjR2MDAwakVHMXNMdDhHRDB5aWdaK200enR6MlF6L1RJaUlPeWRBWm9n?=
 =?utf-8?B?UjV4alRiMHZreVo4SmxUakNTdjMwQUk0emJJc2pKcm10dGh2dzYzTFNDdElj?=
 =?utf-8?B?dGVWaE9oUWVneG9EeGlDUWRYWnJEWjNiMStvQVgwSk05d2VxQTRJV2tjUFFY?=
 =?utf-8?B?bWZPZUE4OEJEenRESmJFbzhxNWpoUzV1M0NwMTM3bkVyNkUweHZMSjF1ckd0?=
 =?utf-8?B?NzkreDkzL3l2UEcwYWYrZFFyRnpYczhSWFlVT2IwcGpUZGNCV3ZEaGNsWklU?=
 =?utf-8?B?R3R4SEJNVTc0ZEIxTU93blU3aWFmK2lUdDNVcy9PNEw4OGlVOUg3NWNoSEl2?=
 =?utf-8?B?RUY2MGJQcXJhanhTZzFWMCtTY1gyamVra0ZOT3M2OW1GVjFNdTUxVzNYMUQ5?=
 =?utf-8?B?TVdITU9OYTlkZStOUkxtTnJTN01QNTQyOWZERE5QOXVGQzhkUXROd2lHOWlI?=
 =?utf-8?B?QWNPVE0zOGR6Mm1CRjN3V0Vna1FkVk9SZkdkbG5hVTlVRjNqSkJVRmFGMmsx?=
 =?utf-8?B?Smk0RHpVU2o3QjUwaTA3K1UwRTRQTFFSSlZNYXlBWVBNbkJTSjRURlNFZ3p6?=
 =?utf-8?B?K1BSS2FRUmxaTkt3cWlUcmU3UUNiY0d4a0Juc28xRFVEbytXR0wrWGx5UEFj?=
 =?utf-8?B?OEphbVFTMVc3YXlRNUg0cjBBeGo0Si94UzRrSFR2ZnZvdk9tTGxXU0szTm5l?=
 =?utf-8?B?OE5HVUNXODUrVTlqUnh4bUd6Vm1wd3ZOQ29YRm5COFNQNllQNkVxK1BjbXh0?=
 =?utf-8?B?TVBGSS8yazFIRDNLNkRUOUN2eE1aaDBqQkhzQytkSmp3ai9nYXlJcGFTMExZ?=
 =?utf-8?B?bE9DTmIxV0NIZDhPZkFMTUZ6MkV0KzZnNURPTTgySXNVc042eUE3LzN6d3JV?=
 =?utf-8?B?NjJUVmxqaWROS0RyVWc1dE5oWnowOTF4SmlWK0JicU1pNVdNVHFmMEZ3TWwy?=
 =?utf-8?B?eVF2eFJKUng0aEZab28vOGREa1lsbmxMaFh1R3Z4TDE2UnBmclh5aVpmNEZQ?=
 =?utf-8?B?L3BtbzBVeCtGNVJTUWxKNGgxd2lScDJjSTl0VGZOdjVUZDhsM2ppN0FwY2xP?=
 =?utf-8?B?YnpQbGcrU2U2TktNVWRiQWw2V3kwcEZwbGVoV05lMHprWUdOZnpMbGg5VzJF?=
 =?utf-8?B?am95M0lCbUNYTUxIRTNRVisvQUlRQXBVczA1VVV5MUxWZlNOZWplQzVQSVIv?=
 =?utf-8?B?cEdVaWNHUk5hTjFUTlRnd2FaRko0THF6SStVWUVLc2tKQVpET2I1VXFpLzZl?=
 =?utf-8?B?dys1cWxydS9XVDdWWGtFVFBJUkJiNVd1MUpMTnpVTXhiNENQaGdmRWNTYmRh?=
 =?utf-8?B?djFCZkFpNmUxTzRIb1dCUC9RaisvbGtNRWowU01maE5ncTcra0dnSEpVNDZP?=
 =?utf-8?B?UlNCSXE0NnpBdXJWRmlIay8wWjM5Q1pxMGhqemQrVDd2ZC9lSG9KbDhjdDZt?=
 =?utf-8?B?Sk9CbDVYREhOcCtaL01zamJ0NHArVWFSeFp1RlFQN3FPUUFidUhWMWdtclJ4?=
 =?utf-8?B?RnQwU2hMamJCaDkxd2tseks2emJlaUVHUWxVc2l2cXJ5UnlRN0JYQTR6dEFM?=
 =?utf-8?Q?UPSWF/g/yqQ/uIKbcxdu+IXXC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gW/PxCnGdXImwQz5rWL8xqPX5+PPyvbA5qYB7FfSVGXFGyGvpHSPN3j7ajrUzKsda1fCp6S3uLHeBNs6cwy/KaTiGcHb7oST5oVVe+EtVeRGdPTsdxJgQDiZi1m1YnZFNjo1/nZKpw1qZ4hZSDwXdeMvdHPfI6+64Pt8mwWsNKUTIYEA5DKiFDkNLZpvDe7UDMJsGDEKz295wsuWxtyFfugzIQ9lOL4ns/6bZTzROw17yEkeOVyAfbL6D6HKK4hgGCtkbKbN707uSPv7rJy2MZovTJoz3kxay/r7iMcaQs42jHiRDxaYAOXZ3yY3hsRz7Aa7r4FpinAaF0y7Oo3dHPqLPVpS2JbY19zFw1HJ9MsAiDIx2c7GIVARJYQcDuh1nzEC6x+hA489Phy4B4j/XA8Y9IpRrVAxPxkVAmdiHZ8unZ5zlgWBfv+AC/4dmOxqKTYNwRrkMdNlCoqSNi9LmVW2wBj+Hh50ic/MOeVRPzQuVSGIgnGGATKAu+I23Y8PmRiTiz4QLjaiQQ30KD0g1+NhVqy12D+qMkxCE9BZ/uXYM+b2eGSxZL+VJZ4nGjVypN9LWiyYlTrFDl/csWPzeaGAcCxRUnhRLzkL22VsOg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e41f679-c403-4e45-923d-08dde64fc893
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 16:27:29.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDuq0srVmCAF+uNdUioQ13g4doABDYvChEN92S5FtEVtj+DcUvx9KkTR6XnUgY+RFfVDy2M/QeJDELfGhs9P7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280137
X-Proofpoint-GUID: ddIj3c0tu8v9XGTHVIFPGjEXRbBp1yFX
X-Proofpoint-ORIG-GUID: ddIj3c0tu8v9XGTHVIFPGjEXRbBp1yFX
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68b0837a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=WQHKMJTOAWiqymVUo8AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfXxB5LgBNYA2Pb
 WTBC47dxhrrs/rPEOPCElP4FYzXC6CDHurVUJoytJu8M0ZTPthygsH9Kvtc6ZkoAyLSim7Xpd20
 7s/qs/k7HEPzWi+rAJmE+nD93qXuhx1AdYGmygTkhyCoFBZGZeb9MLyFnQn6lNrGyugxBwgZ6lS
 2XhfTE0tinEExJprjXjDWRO1Bq2KFRwfEDNpJObJq/g+KjnFocdyI+ma8d8mx6RWDKz3E1UGGAg
 Mqcvz7bTyDoED5jC1chcNSeqWTYIaprY9UyAA8zzb/kj8NqrrJvyjNNFlmMc8IQih58kXGOtZt0
 QVYV1MhspRJPPzz7eFMdefVSiit79doJ5G78NqnNs5zdCS14Pk3KX9vVDF5imWZ0mohHVwsfNR8
 8WNX0cKN

On 8/28/25 12:22 PM, Jeff Layton wrote:
> On Wed, 2025-08-27 at 15:41 -0400, Mike Snitzer wrote:
>> On Wed, Aug 27, 2025 at 11:34:03AM -0400, Chuck Lever wrote:
>>> On 8/26/25 2:57 PM, Mike Snitzer wrote:
>>>> If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
>>>> DIO-aligned block (on either end of the READ). The expanded READ is
>>>> verified to have proper offset/len (logical_block_size) and
>>>> dma_alignment checking.
>>>>
>>>> Must allocate and use a bounce-buffer page (called 'start_extra_page')
>>>> if/when expanding the misaligned READ requires reading extra partial
>>>> page at the start of the READ so that its DIO-aligned. Otherwise that
>>>> extra page at the start will make its way back to the NFS client and
>>>> corruption will occur. As found, and then this fix of using an extra
>>>> page verified, using the 'dt' utility:
>>>>   dt of=/mnt/share1/dt_a.test passes=1 bs=47008 count=2 \
>>>>      iotype=sequential pattern=iot onerr=abort oncerr=abort
>>>> see: https://github.com/RobinTMiller/dt.git
>>>>
>>>> Any misaligned READ that is less than 32K won't be expanded to be
>>>> DIO-aligned (this heuristic just avoids excess work, like allocating
>>>> start_extra_page, for smaller IO that can generally already perform
>>>> well using buffered IO).
>>>>
>>>> Suggested-by: Jeff Layton <jlayton@kernel.org>
>>>> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>>  fs/nfsd/vfs.c              | 200 +++++++++++++++++++++++++++++++++++--
>>>>  include/linux/sunrpc/svc.h |   5 +-
>>>>  2 files changed, 194 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>> index c340708fbab4d..64732dc8985d6 100644
>>>> --- a/fs/nfsd/vfs.c
>>>> +++ b/fs/nfsd/vfs.c
>>>> @@ -19,6 +19,7 @@
>>>>  #include <linux/splice.h>
>>>>  #include <linux/falloc.h>
>>>>  #include <linux/fcntl.h>
>>>> +#include <linux/math.h>
>>>>  #include <linux/namei.h>
>>>>  #include <linux/delay.h>
>>>>  #include <linux/fsnotify.h>
>>>> @@ -1073,6 +1074,153 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>>>>  }
>>>>  
>>>> +struct nfsd_read_dio {
>>>> +	loff_t start;
>>>> +	loff_t end;
>>>> +	unsigned long start_extra;
>>>> +	unsigned long end_extra;
>>>> +	struct page *start_extra_page;
>>>> +};
>>>> +
>>>> +static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
>>>> +{
>>>> +	memset(read_dio, 0, sizeof(*read_dio));
>>>> +	read_dio->start_extra_page = NULL;
>>>> +}
>>>> +
>>>> +#define NFSD_READ_DIO_MIN_KB (32 << 10)
>>>> +
>>>> +static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>> +				  struct nfsd_file *nf, loff_t offset,
>>>> +				  unsigned long len, unsigned int base,
>>>> +				  struct nfsd_read_dio *read_dio)
>>>> +{
>>>> +	const u32 dio_blocksize = nf->nf_dio_read_offset_align;
>>>> +	loff_t middle_end, orig_end = offset + len;
>>>> +
>>>> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
>>>> +		      "%s: underlying filesystem has not provided DIO alignment info\n",
>>>> +		      __func__))
>>>> +		return false;
>>>> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
>>>> +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
>>>> +		      __func__, dio_blocksize, PAGE_SIZE))
>>>> +		return false;
>>>
>>> IMHO these checks do not warrant a WARN. Perhaps a trace event, instead?
>>
>> I won't die on this hill, I just don't see the risk of these given
>> they are highly unlikely ("famous last words").
>>
>> But if they trigger we should surely be made aware immediately.  Not
>> only if someone happens to have a trace event enabled (which would
>> only happen with further support and engineering involvement to chase
>> "why isn't O_DIRECT being used like NFSD was optionally configured
>> to!?").
>>
> 
> 
> A kernel log message in this case makes sense to me, since it is a
> (minor) administrative issue. WARN_ONCE() is going to throw a big,
> scary stack trace, however that won't be terribly useful. We'll get hit
> with bug reports from it for years.

Agreed, the stack trace isn't very useful information.


> Maybe pr_notice_once() for this? Or, maybe a pr_notice_once, but do it
> on a per-export basis?

Right, I think warning once and then turning off the warning for all
subsequent problems is going to cause a lot of missed problems. Warning
once per export sounds like a step in the right direction.


>>>> +	/* Return early if IO is irreparably misaligned (len < PAGE_SIZE,
>>>> +	 * or base not aligned).
>>>> +	 * Ondisk alignment is implied by the following code that expands
>>>> +	 * misaligned IO to have a DIO-aligned offset and len.
>>>> +	 */
>>>> +	if (unlikely(len < dio_blocksize) || ((base & (nf->nf_dio_mem_align-1)) != 0))
>>>> +		return false;
>>>> +
>>>> +	init_nfsd_read_dio(read_dio);
>>>> +
>>>> +	read_dio->start = round_down(offset, dio_blocksize);
>>>> +	read_dio->end = round_up(orig_end, dio_blocksize);
>>>> +	read_dio->start_extra = offset - read_dio->start;
>>>> +	read_dio->end_extra = read_dio->end - orig_end;
>>>> +
>>>> +	/*
>>>> +	 * Any misaligned READ less than NFSD_READ_DIO_MIN_KB won't be expanded
>>>> +	 * to be DIO-aligned (this heuristic avoids excess work, like allocating
>>>> +	 * start_extra_page, for smaller IO that can generally already perform
>>>> +	 * well using buffered IO).
>>>> +	 */
>>>> +	if ((read_dio->start_extra || read_dio->end_extra) &&
>>>> +	    (len < NFSD_READ_DIO_MIN_KB)) {
>>>> +		init_nfsd_read_dio(read_dio);
>>>> +		return false;
>>>> +	}
>>>> +
>>>> +	if (read_dio->start_extra) {
>>>> +		read_dio->start_extra_page = alloc_page(GFP_KERNEL);
>>>
>>> This introduces a page allocation where there weren't any before. For
>>> NFSD, I/O pages come from rqstp->rq_pages[] so that memory allocation
>>> like this is not needed on an I/O path.
>>
>> NFSD never supported DIO before. Yes, with this patch there is
>> a single page allocation in the misaligned DIO READ path (if it
>> requires reading extra before the client requested data starts).
>>
>> I tried to succinctly explain the need for the extra page allocation
>> for misaligned DIO READ in this patch's header (in 2nd paragraph
>> of the above header).
>>
>> I cannot see how to read extra, not requested by the client, into the
>> head of rq_pages without causing serious problems. So that cannot be
>> what you're saying needed.
>>
>>> So I think the answer to this is that I want you to implement reading
>>> an entire aligned range from the file and then forming the NFS READ
>>> response with only the range of bytes that the client requested, as we
>>> discussed before.
>>
>> That is what I'm doing. But you're taking issue with my implementation
>> that uses a single extra page.
>>
>>> The use of xdr_buf and bvec should make that quite
>>> straightforward.
>>
>> Is your suggestion to, rather than allocate a disjoint single page,
>> borrow the extra page from the end of rq_pages? Just map it into the
>> bvec instead of my extra page?
>>
>>> This should make the aligned and unaligned cases nearly identical and
>>> much less fraught.
>>
>> Regardless of which memory used to read the extra data, I don't see
>> how the care I've taken to read extra but hide that fact from the
>> client can be avoided. So the pre/post misaligned DIO READ code won't
>> change a whole lot. But once I understand your suggestion better
>> (after a clarifying response to this message) hopefully I'll see what
>> you're saying.
>>
>> All said, this patchset is very important to me, I don't want it to
>> miss v6.18 -- I'm still "in it to win it" but it feels like I do need
>> your or others' help to pull this off.
>>
>> And/or is it possible to accept this initial implementation with
>> mutual understanding that we must revisit your concern about my
>> allocating an extra page for the misaligned DIO READ path?
>>
>>>> +		if (WARN_ONCE(read_dio->start_extra_page == NULL,
>>>> +			      "%s: Unable to allocate start_extra_page\n", __func__)) {
>>>> +			init_nfsd_read_dio(read_dio);
>>>> +			return false;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,
>>>> +						 struct nfsd_read_dio *read_dio,
>>>> +						 ssize_t bytes_read,
>>>> +						 unsigned long bytes_expected,
>>>> +						 loff_t *offset,
>>>> +						 unsigned long *rq_bvec_numpages)
>>>> +{
>>>> +	ssize_t host_err = bytes_read;
>>>> +	loff_t v;
>>>> +
>>>> +	if (!read_dio->start_extra && !read_dio->end_extra)
>>>> +		return host_err;
>>>> +
>>>> +	/* If nfsd_analyze_read_dio() allocated a start_extra_page it must
>>>> +	 * be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
>>>> +	 */
>>>> +	if (read_dio->start_extra_page) {
>>>> +		__free_page(read_dio->start_extra_page);
>>>> +		*rq_bvec_numpages -= 1;
>>>> +		v = *rq_bvec_numpages;
>>>> +		memmove(rqstp->rq_bvec, rqstp->rq_bvec + 1,
>>>> +			v * sizeof(struct bio_vec));
>>>> +	}
>>>> +	/* Eliminate any end_extra bytes from the last page */
>>>> +	v = *rq_bvec_numpages;
>>>> +	rqstp->rq_bvec[v].bv_len -= read_dio->end_extra;
>>>> +
>>>> +	if (host_err < 0) {
>>>> +		/* Underlying FS will return -EINVAL if misaligned
>>>> +		 * DIO is attempted because it shouldn't be.
>>>> +		 */
>>>> +		WARN_ON_ONCE(host_err == -EINVAL);
>>>> +		return host_err;
>>>> +	}
>>>> +
>>>> +	/* nfsd_analyze_read_dio() may have expanded the start and end,
>>>> +	 * if so adjust returned read size to reflect original extent.
>>>> +	 */
>>>> +	*offset += read_dio->start_extra;
>>>> +	if (likely(host_err >= read_dio->start_extra)) {
>>>> +		host_err -= read_dio->start_extra;
>>>> +		if (host_err > bytes_expected)
>>>> +			host_err = bytes_expected;
>>>> +	} else {
>>>> +		/* Short read that didn't read any of requested data */
>>>> +		host_err = 0;
>>>> +	}
>>>> +
>>>> +	return host_err;
>>>> +}
>>>> +
>>>> +static bool nfsd_iov_iter_aligned_bvec(const struct iov_iter *i,
>>>> +		unsigned addr_mask, unsigned len_mask)
>>>> +{
>>>> +	const struct bio_vec *bvec = i->bvec;
>>>> +	unsigned skip = i->iov_offset;
>>>> +	size_t size = i->count;
>>>
>>> checkpatch.pl is complaining about the use of "unsigned" rather than
>>> "unsigned int".
>>
>> OK.
>>
>>>> +
>>>> +	if (size & len_mask)
>>>> +		return false;
>>>> +	do {
>>>> +		size_t len = bvec->bv_len;
>>>> +
>>>> +		if (len > size)
>>>> +			len = size;
>>>> +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
>>>> +			return false;
>>>> +		bvec++;
>>>> +		size -= len;
>>>> +		skip = 0;
>>>> +	} while (size);
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>>  /**
>>>>   * nfsd_iter_read - Perform a VFS read using an iterator
>>>>   * @rqstp: RPC transaction context
>>>> @@ -1094,7 +1242,8 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  		      unsigned int base, u32 *eof)
>>>>  {
>>>>  	struct file *file = nf->nf_file;
>>>> -	unsigned long v, total;
>>>> +	unsigned long v, total, in_count = *count;
>>>> +	struct nfsd_read_dio read_dio;
>>>>  	struct iov_iter iter;
>>>>  	struct kiocb kiocb;
>>>>  	ssize_t host_err;
>>>> @@ -1102,13 +1251,34 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  
>>>>  	init_sync_kiocb(&kiocb, file);
>>>>  
>>>> +	v = 0;
>>>> +	total = in_count;
>>>> +
>>>>  	switch (nfsd_io_cache_read) {
>>>>  	case NFSD_IO_DIRECT:
>>>> -		/* Verify ondisk and memory DIO alignment */
>>>> -		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
>>>> -		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0) &&
>>>> -		    (base & (nf->nf_dio_mem_align - 1)) == 0)
>>>> -			kiocb.ki_flags = IOCB_DIRECT;
>>>> +		/*
>>>> +		 * If NFSD_IO_DIRECT enabled, expand any misaligned READ to
>>>> +		 * the next DIO-aligned block (on either end of the READ).
>>>> +		 */
>>>> +		if (nfsd_analyze_read_dio(rqstp, fhp, nf, offset,
>>>> +					  in_count, base, &read_dio)) {
>>>> +			/* trace_nfsd_read_vector() will reflect larger
>>>> +			 * DIO-aligned READ.
>>>> +			 */
>>>> +			offset = read_dio.start;
>>>> +			in_count = read_dio.end - offset;
>>>> +			total = in_count;
>>>> +
>>>> +			kiocb.ki_flags |= IOCB_DIRECT;
>>>> +			if (read_dio.start_extra) {
>>>> +				len = read_dio.start_extra;
>>>> +				bvec_set_page(&rqstp->rq_bvec[v],
>>>> +					      read_dio.start_extra_page,
>>>> +					      len, PAGE_SIZE - len);
>>>> +				total -= len;
>>>> +				++v;
>>>> +			}
>>>> +		}
>>>>  		break;
>>>>  	case NFSD_IO_DONTCACHE:
>>>>  		kiocb.ki_flags = IOCB_DONTCACHE;
>>>> @@ -1120,8 +1290,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  
>>>>  	kiocb.ki_pos = offset;
>>>>  
>>>> -	v = 0;
>>>> -	total = *count;
>>>>  	while (total) {
>>>>  		len = min_t(size_t, total, PAGE_SIZE - base);
>>>>  		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
>>>> @@ -1132,9 +1300,21 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  	}
>>>>  	WARN_ON_ONCE(v > rqstp->rq_maxpages);
>>>>  
>>>> -	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
>>>> -	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
>>>> +	trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
>>>> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
>>>> +
>>>> +	if ((kiocb.ki_flags & IOCB_DIRECT) &&
>>>> +	    !nfsd_iov_iter_aligned_bvec(&iter, nf->nf_dio_mem_align-1,
>>>> +					nf->nf_dio_read_offset_align-1))
>>>> +		kiocb.ki_flags &= ~IOCB_DIRECT;
>>>> +
>>>>  	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
>>>> +
>>>> +	if (in_count != *count) {
>>>> +		/* misaligned DIO expanded read to be DIO-aligned */
>>>> +		host_err = nfsd_complete_misaligned_read_dio(rqstp, &read_dio,
>>>> +					host_err, *count, &offset, &v);
>>>> +	}
>>>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>>>>  }
>>>>  
>>>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>>>> index e64ab444e0a7f..190c2667500e2 100644
>>>> --- a/include/linux/sunrpc/svc.h
>>>> +++ b/include/linux/sunrpc/svc.h
>>>> @@ -163,10 +163,13 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>>>>   * pages, one for the request, and one for the reply.
>>>>   * nfsd_splice_actor() might need an extra page when a READ payload
>>>>   * is not page-aligned.
>>>> + * nfsd_iter_read() might need two extra pages when a READ payload
>>>> + * is not DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor()
>>>> + * are mutually exclusive (so reuse page reserved for nfsd_splice_actor).
>>>>   */
>>>>  static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
>>>>  {
>>>> -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
>>>> +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
>>>>  }
>>>>  
>>>>  /*
>>>
>>> To properly evaluate the impact of using direct I/O for reads with real
>>> world user workloads, we will want to identify (or construct) some
>>> metrics (and this is future work, but near-term future).
>>>
>>> Seems like allocating memory becomes difficult only when too many pages
>>> are dirty. I am skeptical that the issue is due to read caching, since
>>> clean pages in the page cache are pretty easy to evict quickly, AIUI. If
>>> that's incorrect, I'd like to understand why.
>>
>> The much more problematic case is heavy WRITE workload with a working
>> set that far exceeds system memory.
>>
>> But I agree it doesn't make a whole lot of sense that clean pages in
>> the page cache would be getting in the way.  All I can tell you is
>> that in my experience MM seems to _not_ evict them quickly (but more
>> focused read-only testing is warranted to further understand the
>> dynamics and heuristics in MM and beyond -- especially if/when
>> READ-only then a pivot to a mix of heavy READ and WRITE or
>> WRITE-only).
>>
>> NFSD using DIO is optional. I thought the point was to get it as an
>> available option so that _others_ could experiment and help categorize
>> the benefits/pitfalls further?
>>
>> I cannot be a one man show on all this. I welcome more help from
>> anyone interested.
> 


-- 
Chuck Lever

