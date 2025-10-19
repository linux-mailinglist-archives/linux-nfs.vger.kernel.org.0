Return-Path: <linux-nfs+bounces-15389-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AEDBEE852
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E063AEF04
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5549F35966;
	Sun, 19 Oct 2025 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jVuZaZx2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k76/ZAhq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9129D260
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760887003; cv=fail; b=iznPH7WfqWc30+Z3Xq4rvV+pKOPnbQhxqesQRxVjBUqovhwzHGv60e68EDYMk47sLd7jahs9D3X/IzgZeFFYfEUpBt9taAoPHvRkIlB5InwS8WZA4nIg4Zpz66fpxYR5i2J2lCf7JSWLkWxKFnx2oTAbdfILAhaUkChYEGC8ijo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760887003; c=relaxed/simple;
	bh=hWn6/79D+asDd5CD+TrwwAMceIuH3UgKoiKGd64iKBk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=msVjPorGeDJYa/FizaEnoxAtOkN/gWqLDFKyWJ4BzDizMlGzYV5I0rEBzpolehCeRGBM65J5XxA1CmWs3Rv1Gbh6N3zXL0D0DjieX1NC0LsjH2gVbFGkNOai6c8OCzB1ScI2h+zKn5CtbL6V7+gL8nC15BlFz+rOWEojUPvvyao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jVuZaZx2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k76/ZAhq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J5F1FX015222;
	Sun, 19 Oct 2025 15:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wK406NufBCrAOeSu5+4+72Grz0FNodsUgU7ZnxuRc7g=; b=
	jVuZaZx2JbP/GUDBjIqlf9JUjkm8oQ5XXuk4rSN+Jdg2pVkFFxM9YPPfTtUt+xty
	N5R36kEcuj3pMXvUwSXFPeBXdTlYBmsnywSvhxos+CScbweoIDt4pEcEmKjjVsHQ
	zxHFnUagIVC+D2AiKrNFjxcodf+bAHx+5G3cNLO7/WVG1TNbk2vx4fT9x3KxIRz2
	eQoY+08X72k/e/XCU1MpVJt1MAXL6MY2B24iZR98T8LZGD3puPZlWuyOJVFgLFZ2
	vN3egcKaiGROSqm4VmnP5g8mDhJ23p3kzwy/IbO1Xs3R/zr8Tr+dVwkG1GekegOv
	PIyxfIW4k3CZDBbd89WYuA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2was2u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Oct 2025 15:16:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59JF0KMN035234;
	Sun, 19 Oct 2025 15:16:35 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bay300-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Oct 2025 15:16:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDgvQG1ZFcuOSnLPengiEK+9wQV5KBmISWKpCo8wnLLGvVFcK6xqJ7T+kHxMQSUHaHbocgfxzp25KzT1XREJ4d5JSEXiuDreYUvUufE0Ne9bQ1G0cadsmxoWv63J6ax8YplaIMocBzSfImgLMuR4rWavZnbg4bdbm8bc6quQmUX5jgzNwoOeupR3T0+MJDGRs1Uhcr/wjU2MbF5n9VXkMd4os+8mHSJkyqzYilRR9FduFQlb99sEF59/LhFsiVO2wA5zbOE4OKbj3U2g4jVkHhYpbPcJQMi7fYZ9nnD/yx6Xqav1WmYUKkiunAmX2gjVt8gl/+oo7Mx059GMVUZL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK406NufBCrAOeSu5+4+72Grz0FNodsUgU7ZnxuRc7g=;
 b=gLkXvL2EQcFyZFMhoZwSkY+ksApCqebTRueVsaD7WwO534zxL0qZAMC3P6GOWS2/vSz7u7q2FsUgnuPF1grY5Y6NgDoxbOkLYen5+RR5ckqDWWFPTnliTzjespgXeNf6rq+OeWxF9pBIiyTr4uLm6BfvH8/gKz9SIVsHx1NqHo8AqMWmf6DwQ0mnHznwHGDl20lp5PszA/t0Qa3W4kqcL2hTAO/CFe2NVq7NJDKIy4EqMx8hYmaU4QdxgcBww3PyCuh/vxA977rf6tpkfQLPU0yQeBZf4D3RURc6q7zG4mCovoc/XBpNQC10Bgz8huQQvHwnMRJW+UOGxJ5J/lUYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK406NufBCrAOeSu5+4+72Grz0FNodsUgU7ZnxuRc7g=;
 b=k76/ZAhqqydjbo9URV5djrN+5g17LUgrSgR8uGVtqetAQSTMzVuIcANPIrAZfHpC4DWI+WKE6MXBwT1/6rZrZDGazZR4PpelrhlWI+tFR+sn4qo8XMFj/SmMZNqoyrN5xmZNqVHELPWcRu4lEqkppw6A23fhNzAaaSqTQgjKodg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB997583.namprd10.prod.outlook.com (2603:10b6:806:4b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Sun, 19 Oct
 2025 15:16:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sun, 19 Oct 2025
 15:16:32 +0000
Message-ID: <73a902ad-0918-4ae6-8f9f-e79bd9ecdade@oracle.com>
Date: Sun, 19 Oct 2025 11:16:30 -0400
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/7] nfsd: discard ->op_release() for v4 operations
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <20251018000553.3256253-1-neilb@ownmail.net>
 <20251018000553.3256253-2-neilb@ownmail.net>
 <3c41883e-dac0-4b80-8ec3-d627936cd574@oracle.com>
 <176082622071.1793333.16934396492512587125@noble.neil.brown.name>
Content-Language: en-US
In-Reply-To: <176082622071.1793333.16934396492512587125@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:610:cd::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB997583:EE_
X-MS-Office365-Filtering-Correlation-Id: f6406343-1cc2-4666-17ae-08de0f227c6a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?THNTVTdmcyszN1BBZVZlaEtESDhpZldpVzFmSzhubzVRZHF5dndoTUZlUFFC?=
 =?utf-8?B?QXFibTRYcGV6OHNQam81N0dUU0FnZmFSeFdLUXhHRGNicWJ5M3JjV0VWZGJx?=
 =?utf-8?B?Qk5PdWtWRjVGZnRhMGRGOUx0MlNQQjRmMDQrZ2xJd212dmx6VCsvb2VhOVBV?=
 =?utf-8?B?RXVxcHpOc01oS2FWRlBnbU1SdFFHdnFuQlQvWUh2WmJjNEVkaGJOZ1hidmor?=
 =?utf-8?B?Skd4dHpXWGdIMDg1R3FPNmQ2S0w4Nkx3TmpMVEhSd2VZMHI1eTR1ZkxobWJ0?=
 =?utf-8?B?eTlia2lKalBod0xxMlVuN05WSk9oTjZ3VXNtRUZSYkZxalZ0d0J4UDRvcGIw?=
 =?utf-8?B?WTRjWkExd3dQYUxBWi95WFNwT2JQVy9xb2JvR3gxdzFWTnZJazh0djVKNzF6?=
 =?utf-8?B?KzkyOTdCcnhSWEZKam9iaUdRTmFSVGRkOTEzbGJONnhkSEdKYWJMRGIydi9w?=
 =?utf-8?B?U0Fhb28wQko3Y09lOE0wTEpsNXBVckpPYUEwM1dVekxEL1BOTXV4bWlUNTJU?=
 =?utf-8?B?aE81dzhjZVliOXZ4SFRscFVQeWY4N1BodzRCcFVmbXpGdGtLdHZtRkR5cUdm?=
 =?utf-8?B?OTRSMWNwdmJFeEpuaEd5bGVrUmp3eHowR3lHWFNRRXVOamozYWhhd3g4Nndt?=
 =?utf-8?B?UkZROHp4NlRmbklZMEIwRXpaczl4VlMzVTNGeVlGWUthUVVpNXFFRVQvT2po?=
 =?utf-8?B?cDdhL2hYTGxnNTNjUEk5SnRSeW9iV01IWjIzdCs5M09xK29sYVBlTzlhOXln?=
 =?utf-8?B?UE81ZEZnZGlOV3B2ZkhKOHFvM2YxRXViNjB5Q1I3LzFtOWVjU0lUcU1zREVv?=
 =?utf-8?B?ejVzd3E2SHh3alQrN2V3TU9rVTFRcDhDeFVqekFDSnhjZUFkZnMyejl6eG5s?=
 =?utf-8?B?VTQ4RDlxK0NsNE1DZ1dvQkdLOEFQTm91TDNwZzVZWFJiMndieE1FUHJNelJo?=
 =?utf-8?B?SEZxdWFOOU5vL1dIQnZ2ZkgxOVN1R0tNd0tqSkdobmFoQmhzVEE0MkVoOGVq?=
 =?utf-8?B?UWYxMk5iS0tsenhjamZySDU5RU5ITDlzbDNoTzI3TnVCZVRpWjhzUHR5QVdT?=
 =?utf-8?B?Y2ZMTWZYWkZqWVBIemV1aVNFMmFkUVo0eFllQ1lQV09sdzJKSmE3VmZWWmgx?=
 =?utf-8?B?ZEcwRGJ4eEtTV1JOTDRTaGc3TGcvaWE0YXA5UEhIUzlhTjdkOXpCKzJjQmRR?=
 =?utf-8?B?L2tmL2VjK252UWRQZ1djaE42VmZvZWtFR211cSthUjV6d2FVcFNXVFNYSW04?=
 =?utf-8?B?MnlNekdvM2ZsUXpFTUJjdzFDWnVWNVFVWjVkYzdwN0lrc0ROV0Yxb0toTEV4?=
 =?utf-8?B?Y0FORmVVVllvbEl1RWlhTW8xUmZ5eURsdkU4eXhpV2JPRVI1YVZycCtTSGVZ?=
 =?utf-8?B?NGpkeVJtTjhDRHZVV0FjUmhJNHVneERsU0NORk5vS3lVZGtLT3FwYms0VDBo?=
 =?utf-8?B?MGpEamkyWkp5NE5PV2xuVHRCOWtFdGEzOTNLcFR1T1NTbVY2a2lHS1dlcmlq?=
 =?utf-8?B?eGhmTlVIaEpRc25CYVBxd3hhMDRxT3dXZVJYS3JZM2lYWVpNNFZMMnZPam5j?=
 =?utf-8?B?SDFWcGZoWFFoWXVFYmFtRkhYTUwydWtXUDdDMllLc08vTFlINlBGOGpRa0o5?=
 =?utf-8?B?QlJIbnN1UW5SRllEM2RMMEN5bUp5KzAvdXdGcjRpNm1tYXVQTUloRmNoTnNv?=
 =?utf-8?B?S01qeU1na0kvMnBETDlNY1pxOEx0SVAva0NqOXpIMFJwdjEvMW5rSUdlMGwx?=
 =?utf-8?B?aE5aTkUzRlJBbUVJdlkxUlpka2Z6b044MDhaMm5kbFd2NHpPcWRjc2lXbkV1?=
 =?utf-8?B?Z2RqeE5lOE5wMFJxaTg5Tzh4T1BGQ25KSnN2dXVlR1RzaTA5SFZ6bDJweFhP?=
 =?utf-8?B?WnJVMUZWWlFjam9IeTh5TXJXTTA4dmFNUHZpSjY3ZW9haWRPUkl4SzNoSEp3?=
 =?utf-8?Q?/y66H+AtAgWQLzNoKlaDpENFhtObzqQB?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cDJDc2xxYVN4UUtSakNHL1VSbldKZ1pJcGRBbWJXa1VsdlVGVi84RGRGS2ti?=
 =?utf-8?B?NXlxbmRrV2VrYTRCQ3JmMTZxSEo3Mm9nSUdGMzltTlpYUU1kMnhQN1YwaEZp?=
 =?utf-8?B?VkFKUFBZcm00ZWVLcVZVSVphYTZjekVRdWxKcm5LeFN2dlBjN3drN0J1RUJE?=
 =?utf-8?B?dzJ5WkdhWkVJbXQzSU5KM3pRQlA2QVlPcUh6NDU2WEhDN2VzT3Ywd0YzWGw0?=
 =?utf-8?B?OW9CUVg5U1dhVEw1MzVvUVp1akFjRmZnVFNoMFJUQzlkWDM5MmsrMU5iWHpF?=
 =?utf-8?B?UWU0UVBnNW0wZTc4WTdrZmlPUm40VUFGSTY4cFR0bXZhOU1HTU4zdWlNMExi?=
 =?utf-8?B?UllUSElXU1ZFS0R3S0V5UU5qWEw4QmlyUGJha3dHMWc1WGxZajRYS1htOWQ4?=
 =?utf-8?B?Ym00NkQzNU5oek50eHN5ZTUwU25ZUnAxaUpRU1dNWHFabFJqS2RUT2lvaEda?=
 =?utf-8?B?Rm5qVG90L0NDbGFRekJZK2U1dHplV2lWSXQyN1EzdDNJeWpkZWFxMnNOMEV1?=
 =?utf-8?B?R1BtTklMdTJCQmJVOFMwMlFUVng4a2w3bmdsS2tyZW53T2REUUxUSXltOGdH?=
 =?utf-8?B?djExRnVFVXF4bkt6ZGp4ZWR3MkhoeGlSOFVsNEs0MHkvM1h5NXNYTTJQTVRz?=
 =?utf-8?B?eDZpcVluSngvVkpUVGpNeVpYd3NxVFdzd0x1M0tpQmptcjgxVDdBMS9SSkdx?=
 =?utf-8?B?L1JPcEcxbk00UkFBSW1VRTE3T1BjTzJ3N0ExNkJXWC9IaTFOQkxVQVRhSnlr?=
 =?utf-8?B?UEI3LzZTWGxjVENnNks0Y0lRdmZ3WTJoRUo4aTdUNjg2RHZUcHhIZ2NweVdY?=
 =?utf-8?B?RmxTaGI0a0tzVDlxVVpMOG9iOEJVMUZBRUNwbDdObUM2WS9pZzdPYVJGTWls?=
 =?utf-8?B?UGdKa3VTWjhmSDRIa0ZIM2VZdkUwTW1VQm52OGpEQlVhVWhDejQ5SWxmSm9L?=
 =?utf-8?B?SEIvZHdPTE5SM2JYVlEyVSt5cVVUZFVZaDJhNDZPQ24ySWs5MFBWUjNrWjlK?=
 =?utf-8?B?Ujh4Qys5QjZXSGpKTTNkc2I1d0lnU3hTdzJBWVpKZ1M3b3V1TmJKLzBFOVln?=
 =?utf-8?B?ckg5UlphOEMwLzBDems1dTNTa0ZLa2F6cUUyeXFwTUhrRUxlN0dUeHB4elRy?=
 =?utf-8?B?cHA5OHhvaXRHT3htVFoyQXJRanVDK1NRKzd3RmRqS1k4WERUeDhEZjlBcGd0?=
 =?utf-8?B?T1J6Znd0Vk1rano4a2ZSalEzRUtabGlRNWJubFJjNHNwNFViUzdlWGNpeWxj?=
 =?utf-8?B?VVdqRHJ2UGhqTlJRbUQxUkVGS2pDU3o1dHRxSjhBSFU3cGZqU2lPZnlmaVUy?=
 =?utf-8?B?eVV5VlFkQm9DdmNkbExnSWg5Y0lMTTlxUk9JaFovVU9vZDN4aWVXNUZ4anNW?=
 =?utf-8?B?QUVDWmFuSjZzU2RhS01haW52QlRqUG5qYkNteVo1QmFxYVEwSzU0d2lPbkZV?=
 =?utf-8?B?TTJsNmY4ZGZjWEg3ZFFvTHAydWhlUGM0L1VkVWc1SGVUb2c0Zks0VkxBS3du?=
 =?utf-8?B?L0xZdWYzQ2JudU4zcUtSZ3RjMEJMR3RraWRyREcrYllnOWsvSC9sbzN4SGtK?=
 =?utf-8?B?RXhyMFk5aFZaWFRXUjRTWVVsbWtrcmhxcGxZdkx4UmtXK01ldFBUY0I0Nmdp?=
 =?utf-8?B?RWxaNVRiZDdJMVlVeG0ybmV6SUxpeEJaakc4RFMrVE5XcGFSM1BuUUF3clVk?=
 =?utf-8?B?cWlXN1poVE5nRVZncE8wbFhmSTMzK0FYaWVSMEFKdmhaQ3U0VmJ3UUNTWFVZ?=
 =?utf-8?B?dm9aZUsxcTY3US9WWFpkOTVkRHhqUmFORGZvem01L1NiQ3d2dDc3TVZrTzNY?=
 =?utf-8?B?cHpNa3Z6TnhFTElqREpLc2xuSDJMWUd4Zk1Lb3czWU50UDUxalRGZDh4aldZ?=
 =?utf-8?B?cTg2U1J6c3c4MkpWTjFRbE44ZWo2QTgrRkNSU3FNc3kwWWF1dXBnazMrdnA0?=
 =?utf-8?B?V3g2MENCM3k4VlVMNFBCQkNmUm9ISzliSzg1UXI1RU91Q3JpK3BONUN2aHpM?=
 =?utf-8?B?VlRaUnQwQnZScjZnWWNZY1RlOVFScjdGNTRtdkVvMnIzMy96bVo2WUJDL2NC?=
 =?utf-8?B?UHF4N0dFSnlZTkhub1ZuUWUwOWN5QU04T0NqZmRNUVBiQ0t0bXl1amNwZ2Fj?=
 =?utf-8?B?cHJJMVJlS0tlVWprdElIcXpwbUp1ZmxRejVVNEdxaUplSEhqM2d2Z2J5K1Rl?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jxXlfRxJUgHHhW9qrw45nyOss55aZMw8taf68UebTj6tRjx4GeOIwP/XkrbgqR2V76NUzXapRqGNstHaufbCnkqYdLrFUeyoPTmzwCUKtT0kKgsToty0y9iMsb0sJVb1g9E4rnVaaxwv50HUVINQi4pd6mKDynqw3ezW/7REV2a4GFkSlZh1+2o8dWZ2uHaL8Eknmk9UIKwPg6too+XUHRKS1U445BxtzWgQ8cO8PuYiI649N6rBIse4iMx61c7eTITo+KBLzxi1VYPbO2zCc20rcHV9keoOGq2plf21a0vqdH8/Bvh9k7YYGJZg6KwsmOcNIcACkcmquredPtWK/hyIN9LfRzgFj2S1KjIFz5Qyk+yvNbXsU9RFrokG/S4nm0+rQHNvtvXgLB88UJOGQD0WlQOwyEumym6AgIEizoVLArcC6Swkl8MVKgQPQUFwJm6UxLtRUZVylOpmSe39KoAtn2iO+aHnemDZKe+6gJk8JsVruPIzOxQ4kqTUvbgA7a/uPkBcvaN0oGvmgRcjYzkQNEy6erNJjqfqI+H99jCoKhe9oDOvfMOfNN87/kyKU/gB7dmiE/B4oDlYwdvsqSJZl2E6ISfCNhfjEQ5T/uM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6406343-1cc2-4666-17ae-08de0f227c6a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 15:16:32.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qa8IeRl71tBSlXM0k3e5jfQofwMHAQkI/7awXgfO/Lr89Twja+L2ahlV/r9mZ0uZOuY2vA8iJw0Pnj4vQ/bz8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=984 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510190110
X-Proofpoint-ORIG-GUID: NIh6vQ6g0Sen5-KqRZ54vXcn70Dy9TeN
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=68f500d4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7Hcnm8hyeUIu_9x_xkEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4nTDN4TkeVXz
 i4Y+K9NVwNjY6dEbhw5dYykveMa3DY+TWnblT0b440ToOJrsBTd8RPlkaG5DhtbLGbU19aoLFtT
 WzfyGqv6AuNfPfQURlk9gUaJIiAND1lYtdSbrsq+AWPlMspg89je0Ovv7K64nWSz+OM9YLumDuu
 UtNyjiMMqz+2/QOAMRIBVlQOiAd1cwFjZ/dzrmwwkYG4QKuOf/aQSqh3krhTrhQTwuBGQISRBYH
 853h1KFA3GnqNUg/K0Ai9jmA5mQjYDfxHahaTWeLamaazWY5gNZXxNTPW/rONVQJPf90lNyJTaw
 kTCokhJprojMhD8UfDxUSmUMMbo8MFeCsCUxTHPmei254Rc7R7hfDfeyDyNVMzUDEkkcZVjexxq
 WN4ePbd7dlprXQ+HOzeElZWVTTkYFu77eZdiPN8aro3KaXC14xE=
X-Proofpoint-GUID: NIh6vQ6g0Sen5-KqRZ54vXcn70Dy9TeN

On 10/18/25 6:23 PM, NeilBrown wrote:
>>> @@ -4803,8 +4809,11 @@ nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
>>>  {
>>>  	struct nfsd4_secinfo *secinfo = &u->secinfo;
>>>  	struct xdr_stream *xdr = resp->xdr;
>>> +	__be32 status;
>>>  
>>> -	return nfsd4_encode_SECINFO4resok(xdr, secinfo->si_exp);
>>> +	status = nfsd4_encode_SECINFO4resok(xdr, secinfo->si_exp);
>>> +	exp_put(secinfo->si_exp);
>>> +	return status;
>>>  }
>> Unfortunately this goes in exactly the opposite direction that xdrgen
>> is taking us. I don't want to add anything not related to XDR to the
>> encoder functions. The encoder functions for individual operations
>> will someday be all machine generated.
> I think some substantial restructuring will be needed before that can
> happen.

No doubt.


> The various "read" ops (read, readdir, readlink) do that
> actually reading in the encode operation.  Ops that return a path name
> do the dcache walk in there.

Yes, those are indeed flies in a vast pool of ointment.


> Until we have a clear design for how xdrgen would be more fully
> integrated, I think it is not possible to tell if this actually adds a
> burden, or maybe removes a burden.
> 
> I can imagine that we might want to call the xdr encode function
> directly from the corresponding op_func.  In that case, having release
> code explicitly in the old xdr encode function will make it clear what
> needs to be moved out into the op func.

If the encode function is called directly from the op_func callback,
then op_func can release its resources itself after the encoder returns.

What I can see happening is that we leave the read and pathwalk related
functions as hand-coded, and add a pragma directive (or some similar
mechanism) to xdrgen so it skips generating code for those XDR data
items.


> But in any case I don't think that the 'release' functions are helpful.
> An alternate approach would be add fields kfree, file_put, and exp_put
> to struct nfsd4_op, have the op_func fill those in if it wants them to
> be released, and then always free them all after the op has completed.
> Do you think that would be a better approach?

I don't see that that's any different than invoking an op_release
callback. Can you perhaps elaborate further on what makes you
uncomfortable about the current arrangement?

I'm happy to consider re-arranging things a bit, but I'd really like
to keep the XDR functions focused only on marshaling and unmarshaling
when its practical to do so. In other words, I nod towards the existing
technical debt, but I would like to avoid adding more.

Generally, though, removing unnecessary virtual function calls is a good
thing to do, so thanks for looking into it.


-- 
Chuck Lever

