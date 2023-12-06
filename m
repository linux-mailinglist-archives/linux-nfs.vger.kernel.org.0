Return-Path: <linux-nfs+bounces-362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6614D8073F6
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEA51F21252
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC1D3FE58;
	Wed,  6 Dec 2023 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IT/NzdN2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qk4zcVOj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4AC1A2
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 07:48:24 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6EYoLS014818;
	Wed, 6 Dec 2023 15:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=7OYyLvOfXUDJLVQwg6kUt12dHler9rF9YZG6DwD7Yck=;
 b=IT/NzdN2drVVbO7DYZHmfaWZ4EvppNw5ON4vqamzlXLbVoes6Tw5ck3PbRZ667/TX7Eg
 lT+Gu9ugSp+93a8QAKup1yZwvwnAcjqc+Xc6STZ2VDwBOXwzI5ZcoQKP8qOCj2G12ZO3
 tmpvIppTPoaLfiASAqitKh7pqzAEvGFP3ZK0n7/803MwUtIXain8kduklX0VXrXrpyZM
 SYBBfu6JeCMLhSKdkzFEngDjLbY6dwm+bQRIPhYqm/KEmfcRg0XgxUkA6D4TV8oupjYk
 Fi8zha4xAA6Ipz+H3n39HoWK3H9ZHChWgnJdEtl7pTGIucAPXzsKxGR0voYjCDvwMXEu yQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdda1r0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Dec 2023 15:48:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6FFlNU039946;
	Wed, 6 Dec 2023 15:48:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan62f8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Dec 2023 15:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+lzx0f7iybdlojKFBzWjF0eTl7dll3PPjYwrSh6ZDmMS+zw58zzHeMjq2FLCy7hbBghTxxnE52ooplfWfvSv/4ARtBpIkP6BUTL8PA+yqiUROqbjePXhmIl5jay6WXyLVJgDXOkZ2T/xiYHTkrdQzrifHj2F/glPKmk4R7CgBxSiUKIPqJ5LzPv1rYSRb+E2TPAfHwaNk2LdDJA3eHxyLay3lG1BciZuh7fj8cow3VBTIy8ytvmiiLRm0oxWon9vZI6wbnO9W2D4Hz+s4VgUW8MzN7EtSIK3kcwvq4i2Bu5vEN1agTFNpPY7dMbGjHamBX2vbmoVaAC9ACN6hCmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OYyLvOfXUDJLVQwg6kUt12dHler9rF9YZG6DwD7Yck=;
 b=SEpt59qkWDShGNVzV0A886wTBqqRQRrBbKA43iGgxdXOzZ190R+4m9LsKuEE0lWW23vxdHRze3oYBHnVfWJkdLsyBTUQz0WvVdgEKfvKKhzg9pXLJJgt1n4JbUoRsdnveFjpDNxuUaCIW1W2sRUM34vKrCk6wqLJxOVoVA+O+ADRhUjnlbY2M5KnhbOHumB3vOfgWwlQx1GPAVwceS2T89/7Cctl/9Zt6Slt6qEoUKxj1XFkvGMojjqCXkVUCS8SRlV/KDTL9221OJRveCFHtKzTluUeRrQZ/VoTmo2yonwJgdccZMCFyG03gusEadTiGnONB/+7ZTMbXNui+1u0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OYyLvOfXUDJLVQwg6kUt12dHler9rF9YZG6DwD7Yck=;
 b=qk4zcVOjgR+sA9orSa6rMFdABGHu/8fQ7hMqJXvuxGyj+oojkhJyKgcp/Rq9KjRLK3W60jS+3cTF9zJ7OWh8KobaSmB22DYAgCktFrGoMFxJQK9Yo4bKiWlxgiPwlUcKKK2N1/yRow/v0oSM5nWieoN88S6CnzYFQ776kgJ5r28=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5718.namprd10.prod.outlook.com (2603:10b6:a03:3ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 15:47:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 15:47:47 +0000
Date: Wed, 6 Dec 2023 10:47:44 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <kolga@netapp.com>, Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: changes to struct rpc_gss_sec
Message-ID: <ZXCXoMQS04uoSDB8@tissot.1015granger.net>
References: <97AE695C-8F9F-4E9C-9460-427C284FBD32@oracle.com>
 <CAN-5tyHxvTevgM38q94W4e+rBzYu7tWqDHVMNcFQ5GT3uNArCw@mail.gmail.com>
 <6F0CCBAF-29E1-4720-A7DC-9F43751B56E7@oracle.com>
 <CAN-5tyGqSXyeu+LXWVu_J=A8CLW01c2wDKSfBeqFaaWLxnOAyw@mail.gmail.com>
 <ZWU/BvRX6BcnSQPj@tissot.1015granger.net>
 <CAN-5tyHi8app4K9aRj1paF=zG6PHLs3w8=C6iH4mZgduxvaAbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-5tyHi8app4K9aRj1paF=zG6PHLs3w8=C6iH4mZgduxvaAbA@mail.gmail.com>
X-ClientProxiedBy: CH2PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:610:38::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e50b0c-e8cd-446c-02d9-08dbf672b1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NVv56sjUvSuXcFHSlgCKax4P2gmo7kU9tQknW/jskHDSX0wTg/Oi7PO/QSXKuXSHpLxngHXzKXMarfJgtRblwOgOp15ZiUOZYK7pxS352CS7TOSXvOQIfpN+Lru3T94Sr6E6jLn6q3l0gygfQsQciuxBaL3Qshku5jeZUTGaokHwi5NW/PMasCfcnzpyj7HPIqKnoFqov2+oF8WtKBLSN6vYFDS5+ySCvLJpcj9ZMxblz9xynWCzzLcjmJqEcX4XmrQk4p2b3OnWdjNN0J7yvnSTbxc6gGvfzwtRMHPRlPVsHmzG6nH/T7d9Qr/feyWet1FJrsRlgvBMdmtctaFQ3W7COlx73PPTOgrtX8tqtqL8v32wy0+QfziHW0eR82EndNnKz23r7DRFQRDEg7OPOgekOU0UPZdEZ7vOt9KNRGMh+O6rvHLi78ab/j/F4XEfY7a4QL+wEjADe+2IiLwordKwQZIg9ih5z1HnyvQDGIN3xQCM11D+KkFnXCfBK+XpL9XYh16d/jbyYQ7OGKeot9JQNZ3brpY5knMx77VoTmi1HQQtuOaqTNILLOfgoIhb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(83380400001)(316002)(53546011)(6506007)(41300700001)(9686003)(38100700002)(6512007)(6486002)(2906002)(86362001)(44832011)(5660300002)(6916009)(54906003)(66476007)(66556008)(6666004)(66946007)(8936002)(478600001)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dXRPY05XT3doMzBNMUdsTVZLblVNOXpPYVBGU2kycHBkNFR5elg3c3ZSTUhN?=
 =?utf-8?B?a05UaVd0eUVaRzg4aytNRm40aDd3WmpzT3d3VUcvbWlJOFRCN2FKdHpsS0pF?=
 =?utf-8?B?Q1U1TCtwWXFqMHpzL1NWaUVQdUQyZlp5TGRmRTFBLzBmZ3dBMTltNTBsaCtD?=
 =?utf-8?B?SkRBOGpsVjdVS1dFWEwxdUVweXRoV0liM0FZUEJSSmdieURMeUhFR295WlF2?=
 =?utf-8?B?ZVJoWkRoZ05ROGVkTkRFRUFXZWNOamZDMFZtWkdINmwyRm1Pd1lSWUI2czFJ?=
 =?utf-8?B?MkdBWENCT09hdjFHOEp3ZXFTb3RqZWIzWG8rTUZVeTk4bUtudmlpS1NMMmRH?=
 =?utf-8?B?SStkN2t6MFExREtva1k2NGdJRVc5K21rVVhISDdKZzdyYnNMait3OHNxWmkr?=
 =?utf-8?B?TzlmK3JtR3gwL05oaUJQRjRIcEQwWDYvWVZxeVV1UlBydXcwZ081N1IxcGMx?=
 =?utf-8?B?aU0yREV5dVEyWTRtaDIyL3ROWUh6NlVpWFBQVmFhcXZKZlYvM003aFN0WERR?=
 =?utf-8?B?MTh5SWp6WHc2dmE4c01VaVgvNmtSbEh4dHQwSEpuWDU5VHpnRWpJNGJRWTJH?=
 =?utf-8?B?VU02ODhFU2hVQVB1Rm9OTjZHdFRJQWJWOGVJTlE2aHJMNTZINlArR25KQ0gy?=
 =?utf-8?B?WGdKT01pZnlmRGI5SldYeDdocEJwclpFTzJxYXZxOXVhOGRxQ1F5Z1VKSnJW?=
 =?utf-8?B?dGREUkJIOFZEUkZLaW1UdUY4QTJ6aXRYaXVkS2ZJMFc4b1NxVzJlVDJqTHhY?=
 =?utf-8?B?cWYyVngzQUR6RVpVUGFua0EvRTZVaG1HeE9qSXJPYmQxVWxNNUUvbkUzaGJy?=
 =?utf-8?B?RUhOT3lRUXBwYmZQT0JaeHlqekdkZU1uZGZLSUE4SW9pRjN0NzA5SEZTc1hN?=
 =?utf-8?B?SUZUQ1hiNWZVbFFtZytHNENwL3NQUjdqdkhmM0RwZzhoTklSbTBVSHhNQ2dv?=
 =?utf-8?B?ZGU5NU9RcWFLRXBPaWlWT0lDd3pGMjhIVlI2VkxnakJFdVhGQkpSOTI3VW5F?=
 =?utf-8?B?UWFMaHIwWXE3ZTdyNmExazltOU13eHZMczhCbEhBZmZPd1d6Q2M0cXkwSDVu?=
 =?utf-8?B?dmJUdzVJSFZNMGw3dEkwWklTU3VkK0pRd2VseFhaL0V6NlJPR3NyLzBuRC9K?=
 =?utf-8?B?VzdjNnpmNVlUYkNOQWJmZ3QzTllWVkdCMFZ6NzdFR0t5R0lzTlJ4NzVESW02?=
 =?utf-8?B?dHhRbjRHZmpkS3VOMVNnSHE3aFY5Z0h5RXlaNUxXR01ZdWc2eHNtOFFGTUJR?=
 =?utf-8?B?WmJnNjgweWtIc28zTittUmVwUTNBRzNRdkFMNmZyQUlxZStaSVRDYlowdHJM?=
 =?utf-8?B?bjBBYmtTRWV4SU10V3k5eTBHRzNablkwTUkwM2VUY0RheDU0Y1FDQitDOEVW?=
 =?utf-8?B?M3laSnNneWk0MTFqNUNEYUUyeFVuMjd6RU9pT0lCZGlFRWlTV3J1cDRhWHhR?=
 =?utf-8?B?Z2ZFYXFoa0kzK0Zzamlpc1pXcnA5WEx1eXNKaVZzVS90NXlQcmNKTjcvTmcv?=
 =?utf-8?B?NkVlYnlsMlhuRndVeEIxUE1vT0wwR3JtOVVuUHFVK1RSdFM2ZnNqamdycHFK?=
 =?utf-8?B?SzErbXFYM1BCUXI2WHZLOEFHZE1NRE5HRjNxNUpuVktRS1hEOUpUK2p4ZzlR?=
 =?utf-8?B?Qk1SbUg3OVZaTTdVb3djVkVJaDQzak93ZVkwZW16T0xTbFoyTy9TR2o5WHVS?=
 =?utf-8?B?UkUzek52eWl5MWhrUmFYS3BVSlJCdGU1RmxsaGgyR2pjTXU3UGZTb1N3cGo3?=
 =?utf-8?B?cE9Yb29jTm5sS2p4bXdIanJjY2ZxSGJwQjRabkYvNzlwR3grMmh4QkNYVEtz?=
 =?utf-8?B?TEJ1K205UUZPbERFR3d1OFlKV0hpcnRZMWpZMHY3RTVUWm1TajNLUlgyOTRE?=
 =?utf-8?B?WWpuS2E5WnR0aTAwVHNwYXg3YWVWaCtKQzczMkk3cERVT1NUcXJuM0JqZDY4?=
 =?utf-8?B?ZEhGbk4yUXZJdVJjRFMrUXVpZnE5ZHBVM3hoMlhuemdaTGpKcU1FaGtidmxP?=
 =?utf-8?B?MTBmVjgwMk1ORWp3czJPbnpsd2FDMWc2SDYzZm1aVk1JUk85WFBqaHgzVHgr?=
 =?utf-8?B?TndWS0NxUTFMYWltRnhjd0tDY1UxUVlRYXdnRXZPZmRWYmRvWks0VHRYMnlM?=
 =?utf-8?B?OHJIQm80ZFU2UGttb2tvTk52MnlQWlFqMHZHL1RrQlFjaFQzWmZrVXZCZllU?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8L9uBSUBhO9k8reDYEGgPuG0siKqzvXxfskqrF+XRfebt83r7+6H6lO/xeMJ9NfWYM0PnqJ0Y+UxBlmhSMe+cLLfQRm8jNPpGna0MjmcIyOlcd/UrNCk/qJmozGFYaJzHyWoCvXDOF78WBDsxSrgACaqixnD7n44bcMMPFB5WQbWQjsXBRy4p39butCliFv4p+HSa9k350SROGmj5M2uAEgH51wo8Ox8wkGyM3vGkuuA2dI0u4nFEdydHDaEucZOAQlzoQVUqzVgp+9XMQGamWquSPGmu7Ju2wSkMEN6b9dADRS0mxVWcGyaKXX1LThjXMpmQMqM04v3sLjUPNQEytPf68Xilh0K/51nFZrdpiRbJVQDT76a9uctfFzqtV7JBe8zz0PUuekrzp+czCU1n5PeXBLyxiWdqmTEiG/Cgc1KHHzoxTeaCxBzwtdV07ImhLfd/I3u40i46QA/uuOCc6p1BUIUva7qvUDKfATlZO7P79DJte1XNyzwe82MGKCpavpmWEtQWBbBZGK1jXOLLSadPzWHAve8W1g6nPh2u2xiM563qWikKbb/ufcymSuuNuZxswsH7ggeffNkD13H6kZ21CY2RkFmupfHNBIoRbdcTCCTeYZrPNHQ33DMy/Ns9qIJED9uP+q412UncASU5ODJqNkyePtHPSdpruKX9FgNUfmLLOT0FpxsVj7jpwJ0AvBn/BG8nYgupViYDyMiZUnrOdik2iXVTUw/XRpb4CdRc1JePv4G6ls5tyU0k0Rc0LgLPN2tqDy4B7h4rkXQkOswAKd4RvuUGWkhw7YEDXeF4tfYqFwUroKja4lWLBmm3rED3K4cmq893ojrDvwdozKgF+IhXTuuyAMcdVCBXsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e50b0c-e8cd-446c-02d9-08dbf672b1de
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:47:47.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUDZJM1kdESolh3Qkt+wK+NMOHmmi/AwAlJpniAJ+n1zryTcZu5w7FROO1PQnHg+FZ2dkmUuS3srgPffTkgpwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_13,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060128
X-Proofpoint-GUID: Ss0ArprzPXjf8vxaoStHS4jFGeJ5TRRs
X-Proofpoint-ORIG-GUID: Ss0ArprzPXjf8vxaoStHS4jFGeJ5TRRs

On Tue, Dec 05, 2023 at 03:43:16PM -0500, Olga Kornievskaia wrote:
> On Mon, Nov 27, 2023 at 8:15 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > On Mon, Nov 27, 2023 at 11:42:08AM -1000, Olga Kornievskaia wrote:
> > > Hi Chuck,
> > >
> > > Given that rpc_gss_secreate() was written by you I hope you dont mind
> > > questions. I believe gssd can't use the new api because it is
> > > insufficient. Specifically, authgss_create_default() takes in a
> > > structure which is populated with the correct (kerberos) credential we
> > > need to be using for the gss context establishment.
> > > rpc_gss_seccreate() sets the sec.cred = GSS_C_NO_CREDENTIAL. If you
> > > believe I'm incorrect in my assessment that rpc_gss_secreate please
> > > let me know.
> >
> > Caller can pass its preferred credential in via the *req parameter
> > (parameter 6). Then rpc_gss_seccreate(3t) does this:
> >
> > 846         if (req) {
> > 847                 sec.req_flags = req->req_flags;
> > 848                 gd->time_req = req->time_req;
> > 849                 sec.cred = req->my_cred;
> > 850                 gd->icb = req->input_channel_bindings;
> > 851         }
> >
> > Wouldn't that work?
> 
> Actually this does not work. However, this does:
>         if (req) {
>                 sec.req_flags = req->req_flags;
>                 gd->time_req = req->time_req;
>                 gd->sec.cred = req->my_cred;
>                 gd->icb = req->input_channel_bindings;
>         }

I think this is a bug, and your fix is correct but maybe not
complete. I think you also need:

		gd->sec.req_flags = req->req_flags;


> Existing code is such that cred in gd->sec.cred is always null. I'm
> 100% certain of that but I can't explain why sec.cred=req->my_cred is
> not working.

The misunderstanding is that:

	gd->sec = sec;

copies a pointer to sec. It actually copies the content of @sec.

As it stands, @sec is not subsequently used after it is copied into
gd->sec, so any changes to @sec's fields are ignored. Thus the
"if (req)" clause needs to update the copy in gd->sec, not @sec
itself.


Fixes: 5f1fe4dde861 ("Pass time_req and input_channel_bindings through to init_sec_context")


> This is current code:
> in authgss_refresh()
> rpc_gss_sec:
>      mechanism_OID: { 1 2 134 72 134 247 18 1 2 2 }
>      qop: 0
>      service: 1
>      cred: (nil)
> 
> Fixed libtirpc code as above (or code using authgss_create_default()):
> in authgss_refresh()
> rpc_gss_sec:
>      mechanism_OID: { 1 2 134 72 134 247 18 1 2 2 }
>      qop: 0
>      service: 1
>      cred: 0xffff9002e000
> 
> If I were to fix the libtirpc this way, then I can use
> rpc_gss_seccreate from gssd and not use my previous changes. But it
> still requires changes to libtirpc. How is that not different from
> what's already there (as in committed)?
> 
> > > As far as I can see, current libtirpc needs to be modified no matter
> > > what.
> >
> > I'm not convinced of that yet.
> 
> See above?
> 
> > > Perhaps there needs to be some config magic to demand the use of
> > > higher version of libtirpc for the new code but it would be just a
> > > different way an upstream nfs-utils won't build without an appropriate
> > > libtirpc version.
> >
> > Agreed, 4b272471937d ("gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for
> > machine credentials") should have added some config magic.
> >
> > If the libtirpc version is too low, then the new GSS status checking
> > logic you added can't be used, and it should fall back to the old
> > logic via #ifdef.
> >
> >
> > > I would imagine distros would build matching
> > > libtirpc and nfs-utils that would either both not have the fix or have
> > > the fix.
> >
> > I don't think distros work that way unless they are forced to.
> > There doesn't seem to be a reason why the nfs-utils change has
> > to break things -- we can do this without the ABI disruption.
> >
> > The change to struct rpc_gss_sec can't remain. IMO both
> >
> >   f5b6e6fdb1e6 ("gss-api: expose gss major/minor error in authgss_refresh()")
> >
> > and
> >
> >   4b272471937d ("gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials")
> >
> > need to be reverted first.
> >
> > Then a patch that replaces the authgss_create_default(3) call with
> > rpc_gss_seccreate(3t) can be applied, as long as it contains new
> > configure.ac logic to fall back to using authgss_create_default(3)
> > if rpc_gss_seccreate(3t) is not available in libtirpc.
> >
> > That should enable nfs-utils to be built no matter what version of
> > libtirpc is available in the build environment.
> >
> >
> > > On Wed, Nov 22, 2023 at 4:31 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > > >
> > > > Possibly because authgss_create_default() was the API
> > > > available to gssd back in the day. rpc_gss_seccreate(3t)
> > > > is newer. That would be my guess.
> > > >
> > > >
> > > > > On Nov 22, 2023, at 1:07 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > > > >
> > > > > Hi Chuck,
> > > > >
> > > > > A quick reply as I'm on vacation but I can take a look when I get
> > > > > back. I'm just thinking there must be a reason why gssd is using the
> > > > > authgss api and not calling the rpc_gss one.
> > > > >
> > > > > On Tue, Nov 21, 2023 at 6:59 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > > > >>
> > > > >> Hey Olga-
> > > > >>
> > > > >> I see that f5b6e6fdb1e6 ("gss-api: expose gss major/minor error in
> > > > >> authgss_refresh()") added a couple of fields in structure rpc_gss_sec.
> > > > >> Later, there are some nfs-utils changes that start using those fields.
> > > > >>
> > > > >> That breaks building the latest upstream nfs-utils on Fedora 38, whose
> > > > >> current libtirpc doesn't have those new fields.
> > > > >>
> > > > >> IMO struct rpc_gss_sec is part of the libtirpc API/ABI, thus we really
> > > > >> shouldn't change it.
> > > > >>
> > > > >> Instead, if gssd needs GSS status codes, can't it call
> > > > >> rpc_gss_seccreate(3), which explicitly takes a struct
> > > > >> rpc_gss_options_ret_t * argument?
> > > > >>
> > > > >> ie, just replace the authgss_create_default() call with a call to
> > > > >> rpc_gss_seccreate(3) ....
> > > > >>
> > > > >>
> > > > >> --
> > > > >> Chuck Lever
> > > > >>
> > > > >>
> > > > >>
> > > >
> > > > --
> > > > Chuck Lever
> > > >
> > > >
> >
> > --
> > Chuck Lever

-- 
Chuck Lever

