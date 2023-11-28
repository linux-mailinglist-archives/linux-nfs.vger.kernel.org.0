Return-Path: <linux-nfs+bounces-117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3A67FAF6F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 02:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D27B20EA0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 01:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4369C17E6;
	Tue, 28 Nov 2023 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FN24XaZf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xjuCaIIU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A994
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 17:15:01 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS15wuW031086;
	Tue, 28 Nov 2023 01:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=lVfYDQN8thex0DX72aiGHv0nJWBzZZmTzsYnOLzM4DA=;
 b=FN24XaZf3zG83wiTxGsPpjJMf0WHuZOSyOj7VcCYMxwcQWenBEZXqfIg/EFHTbJav+Ts
 upsxw2kcpk75a9gMF1oP2iuEev6EuiQyYYc5ZmiajLWr4zWh3P+cHkuavlcmwZ6WbLVv
 Z/DZ+1M6fdOO4nnF6t6qjhro+ZNUIkoMmAqy4vQilU3sQD2jjfS3+JD5PskISdHcaZ4D
 XBaHo7In+nzIHQBSM7cV+187fR0YjwBmr9leSPEgugF6F0w7YC1+zZ7hisgvbgAbvzOD
 ayx7im29lbRViYc8ha8e5KKLH3WZpLJWrmvZB8d9l+A1YNifSygdGuf1EZyhDKiPMEcN zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3un1rxgghn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 01:14:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARN0clG001466;
	Tue, 28 Nov 2023 01:14:51 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7ccc69s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 01:14:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpl9o7YTaDaKNhOz3TNJOlWixY3IAbwJzlCWgFf+scV+InTMdBl98eNNQ8apbvjzikG3+K9FnjhWrdURHLIdQQgAXT7WKf0W2gRBM0BBR7K0FoE4pjufRT+9bUPu7QpflUZQcp6qM2QVOT828MJhch5R1ff/M4bh5z1Y/uv0gNDlvLnKahb3e8qZHtA3upFl89MHV+evnBm77BG9srGlCEqZOZxSF/qUboiC6MynkDemSLluFzEI5AkHfrU4KWvILQyY8ILxUq8G8oOwkfpYffNamm6EpeYNeCS+1QdCa7lE79UOLclAk05Mg0orxIN2tgPt5P2M15bN2GanKtC/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVfYDQN8thex0DX72aiGHv0nJWBzZZmTzsYnOLzM4DA=;
 b=HtUQB2xjcJJvveTcLIh5pNGFkg3eKfM6FxHYq+Wi03vxw6qyi/q4nTTK5I6gwZemYU011N+v5euVSydySp7QVS0WLAy0SjTYz070j+arathn2jcDrhR2zfFIdQhXpZvJPQJenOw7qrztidy3EnZfnGcpjg3V78BSJltQa0oS9DIReeNHfqYgTDtIb7K45gw0sK9/C+gjaytgUJr9EHP8SHkJCsrxQqlOm7g3/eIF0hk3PgkZIuFufmVkTFvaf1YhrbDRVWTysuJkmYXe8xhgixsTDbuDJBf1iuJ5OqYWIwF7qWmr72GkEneCrH+UDXjd1zqs3IvY8Y5PmxBSPUDmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVfYDQN8thex0DX72aiGHv0nJWBzZZmTzsYnOLzM4DA=;
 b=xjuCaIIUDFT5n6k9i0DF+VtObiBR9oPlOXYyO4+CA6BH/m18bNYS6wrUblOf+nAKbcHEuRwqlfn7803KOcM4PvyF+pbVdT1zLadmfS6o4KmXCYnQd2kAJzPRkbQg36m7HIlr31loLDwtYVS9wZ1JCy+ggFYsPNwPBrVI8heTDP0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5123.namprd10.prod.outlook.com (2603:10b6:208:333::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 01:14:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 01:14:49 +0000
Date: Mon, 27 Nov 2023 20:14:46 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <kolga@netapp.com>, Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: changes to struct rpc_gss_sec
Message-ID: <ZWU/BvRX6BcnSQPj@tissot.1015granger.net>
References: <97AE695C-8F9F-4E9C-9460-427C284FBD32@oracle.com>
 <CAN-5tyHxvTevgM38q94W4e+rBzYu7tWqDHVMNcFQ5GT3uNArCw@mail.gmail.com>
 <6F0CCBAF-29E1-4720-A7DC-9F43751B56E7@oracle.com>
 <CAN-5tyGqSXyeu+LXWVu_J=A8CLW01c2wDKSfBeqFaaWLxnOAyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-5tyGqSXyeu+LXWVu_J=A8CLW01c2wDKSfBeqFaaWLxnOAyw@mail.gmail.com>
X-ClientProxiedBy: CH2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:52::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b51736-f383-478a-78d9-08dbefaf6a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vQLV9EHuUgJhvI1xHc/f5T428MOF7X6cuFFZFeBTv4mA97EBS6rVZEKgIEMJzQk8dBMiOu+pbGR61os9ZqsXvWPtQu0uuCHfQmml5m48LIWjCtN7Q6CyueamKYyqD2G4GRdTdXqTQeACzFDzWYd24GHpRcc+GRADbpRDC+udZTj/p23qkd2Jm9sNBU4fViVIhVw8q1vRLoF/c37NdL/87FcduBgoFdMHaVY+uTUZKSr+pKhPfW7bg8meUS7nJOgDfaadWwKHrQS/TaGetkg5aRYZbLZ8uHdYvXnTVHuDpQ8/ui/mFnAQlWsqwiAHAwXAmCipX6T02IEXVi+U6+OTPyUnm8LUSlKnnDUUheZlBJsgEeMgpRtTPkzlMgqEnK0UjTDG2+IyJiEXhLT8ACEVi3juGF5E002Ey3jFQzfwMOqvylZWmo5wJ2jAO/ZvDjzjoITeYvtPFyk1jUl36kkXFoVS/iIQvtPxtDZg1n1IOSSEaa+MxOEHL58iEe8ZIwQPLJngJv2IyQ3C5KTYadgEx5sf/RATaiSsstioa54M+hFIpCkHosMC1D1YI33qnkxDzFSAjpVQfmhQ7VMlsr9sybzWtQLv3DWB0N1V5oPmZss=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(8676002)(4326008)(44832011)(8936002)(2906002)(66946007)(66556008)(316002)(6916009)(54906003)(66476007)(41300700001)(53546011)(6512007)(9686003)(478600001)(6666004)(6506007)(6486002)(26005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MlZrTkUxTkdJa1NULytJTUZIeTlJblJUM3lrTXBJZW5ETXVZbEJSQlNJMnFv?=
 =?utf-8?B?V3Y3RlE3bHJZNnY0cGU1b3ZBT1JkV0RpMnNSNGQvdkFBUjJuT0NBSklDTVhP?=
 =?utf-8?B?Z3M1YWY1S2c3aXhkamF2VC8wbncyVXEweVNtdEc5cDBlQjV4ZDV0UnhTOHRt?=
 =?utf-8?B?VCtVTlk2VmFBeldNOE9mUWtRUmFCTURsNXNZVkl4TnhqaEI5MWdmOTUwOGFn?=
 =?utf-8?B?dmk5RHZlWE9FYytQMjdaUlJZQmE2RjBxUWY0OUpqdElET3FLcTRsY083WlFs?=
 =?utf-8?B?SmVxNUd5NFRvUFliaHB3VldZeGxna29qeDhpcjZwZGhrSTRJVUxsNDd0Vk52?=
 =?utf-8?B?VmdIb2FiSXVydk44M3F3di9oWlIrdlVSREpMcFZHV01tYXpZY21IUlpmbmt5?=
 =?utf-8?B?YlpaS2ZQUDcwbndMNmsvRFFtMWRSS3pqaEtMMS9FVnFvL0VENXZXRUc3eHRE?=
 =?utf-8?B?dE5BRkVsbHl1WE45b21Lbmt4M04vMHI4VTdtT0s3ZE0wcEVoMGZON1RPR2I0?=
 =?utf-8?B?YS80OHI4cjFpN0hwUFpuNzU0MnJCNXRsWFFORjc5ZjZzN3F5ckR6RWdMQXZi?=
 =?utf-8?B?d1pGbS8wSEd1eThITUlsUE56Y0lTaWVPZFNqL050T2p2SVcyanJiVVJnZ0FB?=
 =?utf-8?B?bDE0TWp2VGJOTnZuZ2dOVEZsUGQ1TnZCbWltdVNvSzh2eENOU2U0cXBvdmdi?=
 =?utf-8?B?TS92MFA1TmNiK0ZsU05CWEVPNUN4ZnNhS2xrcWJmMWRQWTc4ZnQ3eTV6bUpV?=
 =?utf-8?B?cEF2Sk4xeSsyT1FuZkZscUdoSGw1bVZURDZVMzdGeW9qQldydHhKRHVlUGNa?=
 =?utf-8?B?dW82NWtncXNGSm1KNFJiMkJpanhOdnFyNXhXUUYwSEQ1RUxPWmg3K3FxU2Z4?=
 =?utf-8?B?TGs1OGQzemVScXpOT2J3V1UvVmFwcUpjZkRHUUV3S3NOSlVGcEswUUR3VTZC?=
 =?utf-8?B?ZG5uZUpEZjdIL3UrNmMzN2pvRisxbGU4ZWRQQXVMYjg1QzhpeXpDWFFYUVpB?=
 =?utf-8?B?WXVqQnJpYUZNaUwzcUxlQkdzNFJhV2lGQXN6WWwxMmM1RmF1U3Z4SWhKTWJm?=
 =?utf-8?B?SytnNWNzbkRjanRYNVdtcjZQczhvdTIvM0NDOUVmMlMzbjE4VVNrZXdFRmRR?=
 =?utf-8?B?TzU4OFlqYkljbzQ0S2tsMzIrL001T3Y4cHY5c3RXT2dpR3g0OXg3M3J4cGdS?=
 =?utf-8?B?THhSdy8vdHRFSzUrNG0wUnpEOHZEUzNHcTEycDFlWlVtQ28rcy9BN3VMZUNn?=
 =?utf-8?B?emYwOHVuQ29OSTllUnJiaXpYb0VZMzBFc1piMnoyOHd6QS9LcUJYbDh2S2x5?=
 =?utf-8?B?RFJicjFYVUROcDE5bkt3Qy9RMUJNd2pIQ1lmZU5ZcTNiSkRTUmVFWkN4SnFu?=
 =?utf-8?B?S1lvcjU0dENCeXUyQ09XSWxVSHRXMW5uY2MvL1dJWnZDbUp3Wi8vdlVma1Bm?=
 =?utf-8?B?clZMZFJxK3J1ZitPOVFLWWxjWjhDSUVsWDdFZWFEY0VCQ3Z4aWJGYnQ4Z0p3?=
 =?utf-8?B?UkxES2gyQkdyT1NPNGZvMUpSd21MOGNtKzBQM2xiMWVrMk1FcTZqWnlnVVA2?=
 =?utf-8?B?Mm5NZFN2V1ZzMmVQMHphWTVqOGY3c3lzditoTDE1QzhORmtSV2dLVzBoV2VR?=
 =?utf-8?B?cWRMQzFvTSszYis4WGNaMHRIVkEvUjFRZzdXc2ZpOVVvNGRvalNPSDVTU0Rm?=
 =?utf-8?B?NTEwZlBuVWdXc1BWWjQrUDFUaWJ4SVZnUHhNOFVIdkJQZFZjN3JhRHZIVUZX?=
 =?utf-8?B?QmloNy85MnQ2REo1SHlUeEFqSjFSdkJqRWpnQ1pZemxoQ0xYblhhTTBjSzNv?=
 =?utf-8?B?KyswRzZqWmlRcEZSTUpWQ3o2WUpCV1NmRWRLdmtRQnB4WUdBVnFpWmpKc3pU?=
 =?utf-8?B?RW5uWUJIZzhLRzIvaFFzODUrSEVENEluUGxwVklNZnZXMUp5QVJLWFlsTEhs?=
 =?utf-8?B?S0JvV3Izb2hZVUY2ajRvU2VIY1dUYURlWkR5c2F0aGhrOVRFR1N5aE9PRUY0?=
 =?utf-8?B?eXBpK0tDQW1FNy9QdytjQ3grUnFWYWxiZkRmc0dGZGdqYlBHNFU4eFdSRDc0?=
 =?utf-8?B?bndKTmZ5aUxsU0txMytiTGlXa1ZBbmNaTnJTZEJuSlpwdEVrUTZHQ2lSQTZq?=
 =?utf-8?B?WDF1am5hZm9iZGFRcUNkR0xDak9RaEVIeHE0UkhvcUpwOUs5VDBJSEYxbXBV?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bx8GT+PO6k3m/uaCU9kxouhv2uhIwbJ9VnEQSacMjamEl8rEpbhRcOOgP7oTZg580rX2M25EDnOYdltSyFdJFnJmPQ8YYILbJa7M8VEejK7Sv5B+DXqC2Yi0K1DNVgl7bxhFmrRUQbqXJmnst74WvSgrD6Ag3R/g2vjWBrOZAbK3oKt88ENtV0olUuiH32AvmRQjEjCtp9Is4tExIJ6bPs9VdX/mukCYAMOquyZhfJXkqq/Sucf/mppoyqzkpdhdYXkh7n2TXGeL2P/uTihQcyqps/wEY9BCpxSXM6u0nlgyXAQo8eKwAfAxD4jVnTIy1ZB1gt502MyS2dwRMNv+8toOgEGP1WIlgh2Vqj0ARGLmE31U8qd6SkjoaSfah8kZW6CHSvLLjG3lNAenPWLapigbB+qiD1+bmOmO5yX3MbFl9Zh6uK/1dM9Bn0ZyViSSblyBrELnR5t18l+WGFR7ww+WGeBNydRPW3qlJQnHukpqSKDlpHZxqx83EcQZ6NN+KYfXG5v9Er62Ua7MLkFE7OwgRwvGu6chEgh6y1kBOxCByNL+ULsXCEkpWp9VZQsM2dSeAhC7DQ405CcfSQAEM8fnFuH/OXhW731xYRiJ6hK/sB2cfY1LMkEQBVPDYst6pa/2vz65ejZuAYOZAUa6yZldG3etgI3uusd4C8u0/lrnc95w93a14HDohJcKsDNe7qGt79i6TkwBBoYDg9fJNkbiwLlZX3GV7rCeubjN7GuH2HH9tfu6xPmm6s/vWy1050is6H5gzfGn/2HtSSPtjtl0VyePQTxV2GySG8RdAbBe13Q2tntH6DBrQ7Uaqe51mg60H3CwLce0J5+i8Hqm7zXsHzPiaquKMhjtVAHEasU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b51736-f383-478a-78d9-08dbefaf6a99
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 01:14:49.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU5asoqVAWQNayjxoP+KXtVsgC934gmgnlrUlxd1MRUNx1yr4ZcxFqlx9fvhJYM3xVdfPwkABFQqC2XgNLV8Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_01,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280008
X-Proofpoint-GUID: kXcVbyZycL8CeaLMwmx7mCChef4Gm8nD
X-Proofpoint-ORIG-GUID: kXcVbyZycL8CeaLMwmx7mCChef4Gm8nD

On Mon, Nov 27, 2023 at 11:42:08AM -1000, Olga Kornievskaia wrote:
> Hi Chuck,
> 
> Given that rpc_gss_secreate() was written by you I hope you dont mind
> questions. I believe gssd can't use the new api because it is
> insufficient. Specifically, authgss_create_default() takes in a
> structure which is populated with the correct (kerberos) credential we
> need to be using for the gss context establishment.
> rpc_gss_seccreate() sets the sec.cred = GSS_C_NO_CREDENTIAL. If you
> believe I'm incorrect in my assessment that rpc_gss_secreate please
> let me know.

Caller can pass its preferred credential in via the *req parameter
(parameter 6). Then rpc_gss_seccreate(3t) does this:

846         if (req) {
847                 sec.req_flags = req->req_flags;
848                 gd->time_req = req->time_req;
849                 sec.cred = req->my_cred;
850                 gd->icb = req->input_channel_bindings;
851         }

Wouldn't that work?


> As far as I can see, current libtirpc needs to be modified no matter
> what.

I'm not convinced of that yet.


> Perhaps there needs to be some config magic to demand the use of
> higher version of libtirpc for the new code but it would be just a
> different way an upstream nfs-utils won't build without an appropriate
> libtirpc version.

Agreed, 4b272471937d ("gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for
machine credentials") should have added some config magic.

If the libtirpc version is too low, then the new GSS status checking
logic you added can't be used, and it should fall back to the old
logic via #ifdef.


> I would imagine distros would build matching
> libtirpc and nfs-utils that would either both not have the fix or have
> the fix.

I don't think distros work that way unless they are forced to.
There doesn't seem to be a reason why the nfs-utils change has
to break things -- we can do this without the ABI disruption.

The change to struct rpc_gss_sec can't remain. IMO both

  f5b6e6fdb1e6 ("gss-api: expose gss major/minor error in authgss_refresh()")

and

  4b272471937d ("gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials")

need to be reverted first.

Then a patch that replaces the authgss_create_default(3) call with
rpc_gss_seccreate(3t) can be applied, as long as it contains new
configure.ac logic to fall back to using authgss_create_default(3)
if rpc_gss_seccreate(3t) is not available in libtirpc.

That should enable nfs-utils to be built no matter what version of
libtirpc is available in the build environment.


> On Wed, Nov 22, 2023 at 4:31 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> > Possibly because authgss_create_default() was the API
> > available to gssd back in the day. rpc_gss_seccreate(3t)
> > is newer. That would be my guess.
> >
> >
> > > On Nov 22, 2023, at 1:07 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > >
> > > Hi Chuck,
> > >
> > > A quick reply as I'm on vacation but I can take a look when I get
> > > back. I'm just thinking there must be a reason why gssd is using the
> > > authgss api and not calling the rpc_gss one.
> > >
> > > On Tue, Nov 21, 2023 at 6:59 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > >>
> > >> Hey Olga-
> > >>
> > >> I see that f5b6e6fdb1e6 ("gss-api: expose gss major/minor error in
> > >> authgss_refresh()") added a couple of fields in structure rpc_gss_sec.
> > >> Later, there are some nfs-utils changes that start using those fields.
> > >>
> > >> That breaks building the latest upstream nfs-utils on Fedora 38, whose
> > >> current libtirpc doesn't have those new fields.
> > >>
> > >> IMO struct rpc_gss_sec is part of the libtirpc API/ABI, thus we really
> > >> shouldn't change it.
> > >>
> > >> Instead, if gssd needs GSS status codes, can't it call
> > >> rpc_gss_seccreate(3), which explicitly takes a struct
> > >> rpc_gss_options_ret_t * argument?
> > >>
> > >> ie, just replace the authgss_create_default() call with a call to
> > >> rpc_gss_seccreate(3) ....
> > >>
> > >>
> > >> --
> > >> Chuck Lever
> > >>
> > >>
> > >>
> >
> > --
> > Chuck Lever
> >
> >

-- 
Chuck Lever

