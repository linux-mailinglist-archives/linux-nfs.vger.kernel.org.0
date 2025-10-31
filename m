Return-Path: <linux-nfs+bounces-15839-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F214C25300
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AC93B635A
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3937134AAFF;
	Fri, 31 Oct 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WV5ILvg/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BBnb0h6R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82963346FDA
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916128; cv=fail; b=NqLUFqL0Ta68dzRlyjQSJneS+W5+5ue66h+NU6AHIJIOvIDcK0tMFTgBTDrFFassSGT8PXo5yYbj7I6PvT/1pzWwhE2aaSQ9hXRBPnBeSJv+IDrxAvblMdWaZTLcbcuKKrADdGXnVp+lYCOhyK/zfNb7PN9qNG0fVPC9PMNOukA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916128; c=relaxed/simple;
	bh=/3n3Of+j6jQ4g6WWqaKVcWlXmciar+MnOxa6I0gsXr4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oLjbe2Cro1SjS2NnCVj89Wwy7zJJTT1TO1O0x4OnoBpztPEqKCKc0/xM/GiPgSGvQGFUCKUI/e0J3FxcK/+QqTqlJTS7noYNjeiOQVjL10uGMb9NVRiN8LWQIGn6jmRE+PHP6bYIA8p/ud53IOAgd9/AxmxibDBVKHmLhiSiB98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WV5ILvg/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BBnb0h6R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VCiqS5013498;
	Fri, 31 Oct 2025 13:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VdSsDC/l5BS8iY8Lb3juwMw5X3hr6Fma8WQ8ytNAVyo=; b=
	WV5ILvg/QFTlB9dnV+psaePKIVt/7diJ5shAHuJ26iMQlaabF9chj5fy6aOAmzvp
	GRonh+AIzWHSxOhEr88VxBxqhNO8Gb/jAm+M7HjdW/pnaYXJfoDmt+QzWZNEjobX
	jn+LPfOWO7c1KE7AM4xK2ZcqnjePhmv/VP64kWuoLqjflCczRn+xBgISsDQQPnBT
	jxf/rqwX/SBSoHr5IMbKg8wbeEGa+BsF9D4CPMJ0zalj3FCdQSEHfrmrQ26dx5rU
	2jU/+65nBdOZ+7H9d3DgUpxPaoSesMkpb7rPqkuBzgZDPPU/CTPD9TRfe76HMQ3n
	fprUnDw2iZNAMGOJh5S+9A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4wcqg2gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:08:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VAhJs5007782;
	Fri, 31 Oct 2025 13:08:39 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359wn914-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9ql5Aw1cjHHWyfIPOQBA29GKy2OAnLEBAH/2joeqMHsVNTCRDJxZQH6mbJCjYelUpo9Sv/VDUkyyPmJriTUWqGDWJaEaHipVIn6zmSXlx5dE/zkhuGbAq7ufKcruCDB2M38NSBxo+hX3JJI6whYs/5TPtegKNROLrE7lRpvcYBB4yTrbHuU+bmxgrOTUjksH/wk+mLnrNINVe1GnFGUWQGu93q8HPcUG49Z0jFnnvDzgyAO8v/lKX5cVT7WOXql2yyfYf6fMFBwYPjwAICVv7Zgk2TPq9GcOSF57bl4b57DOWpQLERamzEawsWzwK4fSAIirfnxAEsZ44tN+/n28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdSsDC/l5BS8iY8Lb3juwMw5X3hr6Fma8WQ8ytNAVyo=;
 b=Y2WC0Tubng0jMqG/bJYsE6y1vc+/mW+Bg3+EDgtKln3b6WCpBUBgiFlmDQunFz9+F9g9pqQBCQNn7qrxVNv8p8Blx3t18+yUDzc6e2kD52fwpnWdydwalu2Vy+DW7HNYmmRaPK6HS9VhM6P2TrwCn3e2irlmIVijfaG0jNrV9KV2TWr0t7OYzKVMnbB6xxDDBF2HP/QL74NObb8No52GclCEw/56amJ+u4taEmQHQ+8NDQ5xDwidusd12GUECQujrRj0wyl55UD2PfaK/Z6zy4/wr2JXq7uaANdcUHvIFjPGXe7psl3Tf7QxtCEcnICDg4PM02XzzW2rISjIWnHPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdSsDC/l5BS8iY8Lb3juwMw5X3hr6Fma8WQ8ytNAVyo=;
 b=BBnb0h6RFfSnRx7SZtPmaJrLrThM/0RpUg5Hha3EdLEOO5zYqaWOJ3GFMhsJIOazPoxZbZKzYGkRUyxOoiJDgwV4HZALp0WUGPEq0JFf6XYpQf2WB7nF8NZcOmrI7HOPkUn5YJjHgA7uJ0kbvu5HwSLJyVP6YA9SE686ZODuXiI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7175.namprd10.prod.outlook.com (2603:10b6:8:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 13:08:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Fri, 31 Oct 2025
 13:08:33 +0000
Message-ID: <3f209a8e-594e-4180-b8a4-25791d4d5295@oracle.com>
Date: Fri, 31 Oct 2025 09:08:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] nfsd: change bools in svc_fh it single-bits.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251031032524.2141840-1-neilb@ownmail.net>
 <20251031032524.2141840-7-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251031032524.2141840-7-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:610:b1::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 844dca3b-1bdc-47ed-63b0-08de187e9813
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NzlOVzduK1RKNkZ0c0JyMnlYWU8xenRWK216S3RaTnE4dWJOOXZ1VU9aaVFN?=
 =?utf-8?B?MUk1RE50Y0FzRHM3TUJWZ1VhWklqRGJqN2RaUDlYRE5vdTRkTG8rb3FZSXRa?=
 =?utf-8?B?emZ3cVZtRllhK3RhYjhjZ2JtaldoS1h6WklYR21VeDJYZ3l5TWVWMk9vV3lE?=
 =?utf-8?B?TFA5L2VoU0Z3QlluVzJyVC93MjRKU05rVUJjbm5GVXJPQWx4dzh3aWVRMVp5?=
 =?utf-8?B?VjNsY01sTWswV0w1QklPTE5VSlp5dkpBdzhTRnBVSWZub1FoK1JTM3JHM2tD?=
 =?utf-8?B?SzduWEJxNGtJamtuQWovVzRxNVVqSy9KeFdEUFhrbjk4WDVFbVJDeTBFUEFD?=
 =?utf-8?B?NlF6NmhCNWw5Ym5QZ1dpS0ZSYnk0UFBpSEZmL3VkTllTaElRdDNTM1VWdHM0?=
 =?utf-8?B?WTl2dGJIYjNaaGU1Kytwd0x4dFFPbjZGdzVtazNIY3VTZDZ5OEQ0b0t0dHVj?=
 =?utf-8?B?R0w4QWFQUndmcEszTTFzRFMwNTcrOHpoNnAwT1VwU2JSb0dQTlFiL1pNOVpQ?=
 =?utf-8?B?aUV2bzR3djdrTXJ5RHI2OGRpWENwMXBMaDY2aVRqOHdlRUwrdG05ZnZxTnJk?=
 =?utf-8?B?ZFRVcm1saGc5UmdITHZHVXNIaC9YTHdhOU01eEVjK2NpWisycGIza0drdDJG?=
 =?utf-8?B?QTlrYU52cUJBNW9yRjhDWW5ncGNxajREQVNkN3MrcHBpYmV6OG8xNGlVZXZD?=
 =?utf-8?B?SlAxTFk1T0orUWlaQVhzMEw0Q0pJTE5ydjRvZ3pyaC9IZXc1L1dnRi9XdVBF?=
 =?utf-8?B?QWJxc3ZnV29UQmZ1UFVzL3dPQmtjakxTMGxCNkhoRW1HNVB3T1hJdGFpVnJK?=
 =?utf-8?B?Mkd1dWcydmd6SDd4MHB2SjhtY2JjcTg5a3VKaXZJSGM4dmY4KzRBT0l0Ujhl?=
 =?utf-8?B?VkVDVkxxV2JDbUtGVnJUcEV4Mi8xNGd5R1EyekRvU0Q1dk1RY3FJbG1mckM1?=
 =?utf-8?B?MlBnbmorbVFsU1NleTJvcXA3MWtZZ1JkYWhaZzdDeDdPVTRENjh5TUxyVzJV?=
 =?utf-8?B?SlVWZkRNdDIwTWIwZDlEeU82YmZ1NTBCNUt4TElPbjlST2w0M3kyaG9kSnRN?=
 =?utf-8?B?amRNNERjbFU5cWE0RC9YeXNtSWJsYjdmZEk0eWhpV3A4dzEySzd2L2dIdG1l?=
 =?utf-8?B?QW9xQmpialFIemZlNkxLVk1lZXdBYUR2c0ppY3Y1aXFKK1RvcXVVSXBNNjRJ?=
 =?utf-8?B?Z05la1FIWDk1QVQ1c3BTWjRNeXhyQkkrZzRyVmxqa2RMWW9uV1gzZ1JuVlF5?=
 =?utf-8?B?RzBVL0tFc2lqWWFKbFdQZXpiRTI5MzQyU3FvOThUc2FEcThhKzVGYUczUkZ5?=
 =?utf-8?B?dVhySUxnUG1HeG1qT1NSYjh3dGViWm8yNVZvNk9wdnI2WlI0bzFmT1F5ZlVM?=
 =?utf-8?B?RXVoenlDK1dxT0VDbTFwd0NncGo0T2FFUFFaM0tBMUpreTk3YnlBVTB0Uzlr?=
 =?utf-8?B?NGFuQXMvUzlTZFNSZFdvUGFJMGQ4a2VOMVhqZ2lUcSszdm1RUXdPNnNKSU9z?=
 =?utf-8?B?QnhmZXphckFxN0MzSXBwbFFwbE1YNWlPTWpvcDhBdGgzSzVQV0dSRkM4RjNP?=
 =?utf-8?B?ZmIxWmNHdHFmcDFyUTNqOVpsSWl5Mko3NXhkNDIzOHQ5ZzZ0SzVVZXI5UzdX?=
 =?utf-8?B?QzcvRTRXKzd5SmdsZGUwMjRnNDNaNStrOGpyNkYrbWxkMVo0SGxCa3NOcWZk?=
 =?utf-8?B?bDJUWDA1YmZPbU1xaFRka3NlQS9Hbm1panJucVEwU3BZKzQxcTlFOTJYVjJq?=
 =?utf-8?B?dXpMZEMvSjBtSWJBK1Z4UGxuTzYrSUJEcGFjT1orK2lSV0t2VGZvSmNza2Nn?=
 =?utf-8?B?ay9adFRGY3VYcTVwRXZmSkZaME52dnZ1aXJjWDUxQzVqSXhrQXFueWIzYm9D?=
 =?utf-8?B?bkxsUzhzWVRIMmN4Tmg5T3hvUjE5eE14eHFmWmUzVWdpdDdkZTgrK1FYS1kr?=
 =?utf-8?Q?zhzHJkUTjKPp4lD2MEUN3gHe9fCnL1o6?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?V2RlMmhhN29adm9iSjA1K1ZtQUVuN0xkS3BTWFJQeXVDUGFNZDFINmw1VWdG?=
 =?utf-8?B?UDNwUk1naEpGN0FKWGtnWFgwZnkrRURYV0lOMEVIYUl1UTBteWhpR2gySVBW?=
 =?utf-8?B?VXZyOVBoeGFYWm1DKzVjN1ZlVnZObHVsdjZwYTFSeTdObVRJWk9tNWtLM3pP?=
 =?utf-8?B?TXNyMkpCcWFhK2xFZVRmREtzSnUvMktvVW1NSkhuMEtLUVB5cVB4c0llazZQ?=
 =?utf-8?B?U1dpalBEYk14b0xtWXhORjE1RTE2K3NNanNPL3VROWpuVHBLWHRkeWRIaUNi?=
 =?utf-8?B?UlpPWWo1T1lSN3RVOTB0OExuQ2dxK1E1K0REWVB2dHFnaXdxY1ptdVV3bFFr?=
 =?utf-8?B?R2FVeGtuSTBWa1E4aVdTa0c5U294cGtUWUVPQnBDMGttRC9Cald4YkI2OStU?=
 =?utf-8?B?SnJDSS9iQ2ZVUkErWXZQdkxXWE9JUS9DTFZHTWZ3Y2tuU3dWSHNodVJ6c1c2?=
 =?utf-8?B?WU9VS1VhUENNcTRnTitENTdDRnNyS0pTNmdNdG14a0F3SWFWWkdORkRIQlR1?=
 =?utf-8?B?Rzd3TksrRk1BeHRSU2Vvdzk4WEQrbWNvclBRQnk3VkE2SklIWWJ0cnc2WTU1?=
 =?utf-8?B?aXcvOXl1T0lhVWwwcU0wTmNBc0VYSVNiSGUra2crelp0UVRYRnhMam0wNkxP?=
 =?utf-8?B?K1dEVVRzUUg3MzhKamlPdjgwRGF5OTN3cE5wOGltWjV4MGxmWEQ4VXBZWE1W?=
 =?utf-8?B?WnBacDllWFJMTEMxUnBsNkp0QUVyTHlpYjg1d0F2eWRUTGMyWnpMWnFIQ294?=
 =?utf-8?B?YWJlandiZUdZVkhsNWRpRkt6d1hZNjZMajE1RHRYcldrUGw5MEgxZUY5NGJq?=
 =?utf-8?B?Wkx6YnVGU01scmxSanJWWU9UME5BK0tCc1JYVUpEV1lZQWd4RlowbkZuQnZD?=
 =?utf-8?B?RVZYL1JYdVpBL1RkNkNYeVdydUJieitHYzFWWUxJSEliMDlPSUJhVHVhOXdD?=
 =?utf-8?B?Q2Zrak0wbnpjRi9NWWJ2U3lsa01kQ01RQ1BVRHpTVE1mMGI0K2NqSUtBQXlU?=
 =?utf-8?B?Yzd6VE4zckRlSWU4b3RkbEl1TGZXYzVPNnUwczVpUGFFZGhLSk1zS3hoaG9i?=
 =?utf-8?B?ellZS1ZES3ZKblVUaDMwMUNPZ1N3bmVIVkRuRlRMQUh3eThMdDJha2NJd1da?=
 =?utf-8?B?djVzbTRvVG5uQndOekU1UmpuZWJNdHBhTS9VaEhJZ3kyYXlnRlppUTFBSmRt?=
 =?utf-8?B?b3p1S2FMbkl5VXJFdTM3cDJwb2FGK0RwNjVoR3owdE5vcWpSSVFoWUJJL2hN?=
 =?utf-8?B?WTJzUXI2VjBabXFxMk5sUGxTTkFySDgvaUE0SlVZZTZYZ3EydUxKR2pLSFFX?=
 =?utf-8?B?ZGdiSjBvUktlNjZZTWp6K0Q3cnZkODh6bDdYSU9EeXQ3eHNFd0Z6OEtCcUsr?=
 =?utf-8?B?cHhLRGlXYzFCRVVtWkFXbWRQMWcwcm9lak5aazNmYTRlK3lGR2JnZ3c5OC9B?=
 =?utf-8?B?VXA0K0w5YWY2UElxTFU0ZW5JZkdNUTNVZmFZZWxGOEQxdm5pWEVMNDcra09q?=
 =?utf-8?B?Z3pDSkpKR0FObWtpLytPc2Y5enRpWmZMVjFobjdoZkxYYzVRdWQwQXgvYkFG?=
 =?utf-8?B?T1pRcG1UcjRNWUNqQktkNWJjTUhocUh6c2ZLNk52Y01vZjF0dlE5c3RhdU9N?=
 =?utf-8?B?UXY4TjVHTTB4cEE2TE1XazF5QXRJMEVoQlZmemZvOHhPSDB0NzU0T0VBVmtG?=
 =?utf-8?B?cXQvVktyV0c1a2hZOGFrT2ZVeXJxc3lEelJWaHF0cmR0VEpEazZXRlozWEkw?=
 =?utf-8?B?MTZrSWFla2RUZDd4WDliMkJtZUt4ZTcxa3RpR25oaXJoLzJsTkNEWi9WY05H?=
 =?utf-8?B?bEQ3ZU5ReTVXTU0wdEVRRngxQjRlRDBrSlBLOGNZcnh4NEdRaTJlSDNiYUhT?=
 =?utf-8?B?bnFGaDFmTEhZUEJVVkl3Nnc0SXlFN0tEaFJkYTJsUU5rc1ppZTltYmVnbldY?=
 =?utf-8?B?Qys3RThZSGRDYXRncFRzSEdDcE5XaVJmTVBSWHcvcTFWbkIvbmJMWVJkdk9v?=
 =?utf-8?B?UWlVU1R6MHBkOHo2MFdtNE8vT2F4TkZiSnB0UzZ5Mm1penJZRGt1N0lyUG5w?=
 =?utf-8?B?ZTRReDRvR0xZK1RMMmhXRExpdklXb0w0UkZ6L21DN2ZTNmgvZTJzaDlsVzUx?=
 =?utf-8?Q?gYK9LbtuZvsAHdcrn+0FHmcp2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	87u+pnzSAA5QzqZ8UMCQO9zt+m6GfD/01rk7bN0ZdIBa9D1GViA1vNpxePywAnaHSxH2imyy6GxCtJgTkzu0BfZYoDbkhRj+G26SWpeCy3dZ0xrdnzGVrWCk+xu/xBpE7UUYtV8ZMp0T/db51xCi7jgSdZQ2iy+B/JJ/HLj0SoV6bwpyv0ZyLhY6RM3pmFK6EY9t18rOC8jR0fGT1HAL9qFgYpTxxb7ux7CsEjNdOjdvgOlawjKSl4Gm8uZYvQsDtKsuqtTVTdt78pWI9v8XXLb4TOz82UkDPig9nyB1pPVjNaCv/hw9ZyUHLoVyy8nUf0Xk5w1yFfct8JeHEBRb2aMFOJlF9HStrsFaF8Qu1jHx5Asc4+h62iu3ZjVuI9O5QNUEXFyB9UR7xZv8mkl1RQ5tZtrHQYfpfIhS502d6RPYRQmaPllfOCM4oryWN6WkOPaL8lSsmo3oTBV3Y7rGJskf5zVSLmUrCAlAid2TiiRoCjdDrl6CMvVkFmOVXP1bXqDtnnZXPFZlYaEEaCp7SVD0uS/7glB96PAaUv9xZtkYotYLk2ZT4K32CXgYjzTpJTFeMeomvMOxzOXCTMx6wzDh+Fu4XCLuHChtOaR+6h4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844dca3b-1bdc-47ed-63b0-08de187e9813
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:08:33.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gf4HG/5Q44JREVhA86ATpG3x84eJOBtbdu75yCo1iUo3E3kQKoEIvK9grVoZ6/SonoBIBfFXDRck2ucgn2JJGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510310118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExNSBTYWx0ZWRfX3FErT15HgJwN
 fbBGa2cUTzMDlGiooO2m25krGdrjGw+mR7THSgYLMvKFe8L54Xvoi3XRQG5/F7APZ4+/amepyHy
 /QirjZeEKqQdv36ibuxSRmKbLYWGDQorQpFFl7npmIiTgwMe74kjM6yqFJpmTXbTpVJaeAlvTMc
 W3qpDCJle3FKtByUzVyv2TfeNkIiJs049PUA0hzlFv7pjYbxtGNVR/eplUXiyvGuUxm30ezPxUJ
 wd/dryRLWv0NI38/01Wbpqzif8qpBc9vsH+PdZrcEYnLi0fVYGTPs3E51mOzi/yE8QfRgtjWEKG
 wxEWE0q5o5/1xTVbMlXtXahRNQw7tKCXCLMud+FS1uD302CEBipXvljPxz7RwgBQmnUEFEgIIca
 GJ8vzsXb0PBC5qVAZy9sSrsmIm5kJ845U2ErGOBhxiyscjFkZEY=
X-Proofpoint-GUID: 882JcHDTAMgNnob5iPHUl44Zw136goLf
X-Proofpoint-ORIG-GUID: 882JcHDTAMgNnob5iPHUl44Zw136goLf
X-Authority-Analysis: v=2.4 cv=ZLjaWH7b c=1 sm=1 tr=0 ts=6904b4d8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SELH3DbZoT3rwmbctiIA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12123

On 10/30/25 11:16 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> There are now 9 consecutive bools which, one x86_64, results in a 7 byte
> hole reported by pahole.  When there were 8, there was no hole.
> 
> If we switch them to :1 bit fields then they use 2 bytes instead of 9.
> There is still a hole, but the struct is the same size as when there
> were 8 bools.
> 
> Providing we *don't* change fh_want_write to a bit field, this also
> reduces the code size on x86_64.  fh_want_write is set in lots of places
> (via a static inline) and I think that causes significant code growth.

Anyone with even a hint of OCD is going to look at this and want to
turn fh_want_write into a bit field.

Anyone who wants to add a new field will not know whether to make it
a common bool or a bit field.

I don't find the bit fields improve readability, but that's entirely
subjective.

In any event, I think a code comment is necessary to explain what's
going on.


> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfsfh.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 995fafc383a0..a570b8a7adfe 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -85,18 +85,18 @@ typedef struct svc_fh {
>  	struct svc_export *	fh_export;	/* export pointer */
>  
>  	bool			fh_want_write;	/* remount protection taken */
> -	bool			fh_no_wcc;	/* no wcc data needed */
> -	bool			fh_no_atomic_attr;
> +	bool			fh_no_wcc:1;	/* no wcc data needed */
> +	bool			fh_no_atomic_attr:1;
>  						/*
>  						 * wcc data is not atomic with
>  						 * operation
>  						 */
> -	bool			fh_use_wgather;	/* NFSv2 wgather option */
> -	bool			fh_64bit_cookies;/* readdir cookie size */
> -	bool			fh_foreign;
> -	bool			fh_have_stateid; /* associated v4.1 stateid is not special */
> -	bool			fh_post_saved;	/* post-op attrs saved */
> -	bool			fh_pre_saved;	/* pre-op attrs saved */
> +	bool			fh_use_wgather:1;/* NFSv2 wgather option */
> +	bool			fh_64bit_cookies:1;/* readdir cookie size */
> +	bool			fh_foreign:1;
> +	bool			fh_have_stateid:1; /* associated v4.1 stateid is not special */
> +	bool			fh_post_saved:1;/* post-op attrs saved */
> +	bool			fh_pre_saved:1;	/* pre-op attrs saved */
>  
>  	/* Pre-op attributes saved when inode is locked */
>  	__u64			fh_pre_size;	/* size before operation */


-- 
Chuck Lever

