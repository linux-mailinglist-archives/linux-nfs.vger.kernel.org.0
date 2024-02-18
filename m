Return-Path: <linux-nfs+bounces-2018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27B28597CA
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E8281602
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1036E2D5;
	Sun, 18 Feb 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MwSIeWyV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rq64vk+0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D76C1D68A
	for <linux-nfs@vger.kernel.org>; Sun, 18 Feb 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708274741; cv=fail; b=Ko4c1dWXQStQFB5LIMxnbpwbh7fBLzaEgnrX0YEMIaEdzHB1YI+AOmKprHIoOj6NfZQGF3hub4AnGHDj18WOhM0rrL8MufaPOldKRxakZ3Bc45WqOq1pmICYXNP+Cei/r1xtK3cp7jmuyejCFlJ6k+oAmW6O3q3Gleptzfr1dm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708274741; c=relaxed/simple;
	bh=5QlRGDuPgqMIpQ8zxh6OKGK8CxQrWpPbN/CSlYuLi+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=deYkD4b9ta5iwNv6FxowcYk+eTQRRXuG3Nl/dVva0Woom/OjWHIw9PF4RP6P1DFWI4fVRcRqAFOiczPMHch4e23fIQlm9z0ZQ8LGnJn5f2OxdO8LAxRqcvx3SAxbdlRqzn3ioxuWHeHoD7uRrn7/TI+Qotd+Zr2lWiU6j0cbq5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MwSIeWyV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rq64vk+0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ICZ1Du013112;
	Sun, 18 Feb 2024 16:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=jEj7Lh/me74LlF3dWH7pd05kVRw4vE2nRoeZ2lMT40M=;
 b=MwSIeWyVPIorbboZGLgIOXQzlMgQVb53/vOXwv9NIKlLAXiHfmRYYkhy1PDWfHw9SyJh
 UimLw4eka/xNPE15r1Yss7qUBpTDBExPq64FU2mo7cSAz0OJEjXZ1Wnk0dw32XCgvnhn
 WeFvNjh2JdQqkAn84+zhSCTIYmwux3mpCPGMYNBijhYynEBChxlbc8AUx96JKVgfxcVs
 rtXGSVu5gWzTO/mAh9ACCn5ErFnYlCkagpQHbJv0x1++eEo1Smw13vr+x2vpK07ruMIE
 k/3Es4d9e+NYg/7BZ4etybIh5J1Jc1tUC67tL5mAbtyNUXszTEHjYInKgFwHFk0pSwdT TQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wak7eadj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Feb 2024 16:45:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41IDj8H9016064;
	Sun, 18 Feb 2024 16:45:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak850w6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Feb 2024 16:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddkF142K7QbVk+F+kVaqNxl1XZXvsRFBZVKVNwCfo9LWz6RjTSBoZlFkxMkIMvTHTDOoT/AIWdXM19PBfepONx0dPnVF6RHjaH2inGx+xHgUCaCnGdkYAGs2H/qi5myA0GY7gkC2MwzgzreHShSyMVM6XBM0DrNrTGqXhJZYcJJKyg+Q9xTSdSX4uOn6E/ACjnq56oQIANGbkrtqIbgJtN1QhN16uNg/UtE83JkoTotl4SW96aawLxkL083V52XX4KMyp0JmVa7T/52kcZRtKnHfPOj5G+Jb8zjZHBBrpP2Ff7uxGzUCOQmaS4/bOK9+NjwgHZWNVDYzxgadMY6kLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEj7Lh/me74LlF3dWH7pd05kVRw4vE2nRoeZ2lMT40M=;
 b=ftQxwSdC2fqNT0K//BLLdF3YBJGjf+5CM2P2oBE0FZhTTU0+zwRSg/x4krnCjV4J2o36fXKUsxhAeu181inn9zXVJ1SS5BjwtyCmGfkDp3IKSeQoER4SuC6y/IIl09Wln4hXnqmmoNHJRL4S4zU46Y/6lVCsROHJhOeovI+/MPFYy5slTMUfT2BOIEs0a106AFmq3L2+VYVf3dlUXIjSj4mbWkXo/FGzmwmoh7T56Z/enKVmyNVC5SdasUmo1PlksAC8vT+kyQOHEWuWYdpbKaLbfUfxeJAx+FazMOsWU5MeyMYrYVZj72IVZKoneTTo4gFxSCvBH5m7xgPFdQgsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEj7Lh/me74LlF3dWH7pd05kVRw4vE2nRoeZ2lMT40M=;
 b=Rq64vk+0nBTZ4bg8O+saZUBVkK3bUSQQn8RPp0AKe6ylv4XlgaJytMnTbqIcYwWf3xub80IsUj4Dx1mNukPHZzCgLDUOBbhSMIymeMr5fUIO2L5fwcVjaywtyt+vms8j0dqOrXOfWbsUeZ8ZnxIE6yu3peDx4FPNi0jnPjjRq6Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7359.namprd10.prod.outlook.com (2603:10b6:208:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Sun, 18 Feb
 2024 16:45:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Sun, 18 Feb 2024
 16:45:31 +0000
Date: Sun, 18 Feb 2024 11:45:23 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Roland Mainz <roland.mainz@nrubsig.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: "nfsd: inode locked twice during operation." errors ...
Message-ID: <ZdI0I8YV2Vir8f7g@manet.1015granger.net>
References: <CAKAoaQkeevOpxQPjH+KZt3fyYweLsrY-bhHsqvOpdVXuGYwqXA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKAoaQkeevOpxQPjH+KZt3fyYweLsrY-bhHsqvOpdVXuGYwqXA@mail.gmail.com>
X-ClientProxiedBy: CH5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6f2248-223d-4dea-6a34-08dc30a1053c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fiQTuutNtHcuxjhx9nNu8F6Y90AKskr1FDiDN/V1mxyIwAKmxiqzjGmKYe4r9xEDNUKt0AjUxfektax2zVfY7fkQTq6c2zqy/ibbRjt0jBfJOTm+OB3u5mjDyGEotQgn0q0zL1XVWqTOrT/gn4YbwbEgpWHY3bFC2Q3VgQB7d2THw8FnfTMJlOK3R51V0RKzUnKfU0PhTqYC2nSax42EPwL3G2iVY5X6d7jMY3DuaUb30iXgWwccB6JlDIpKMQ+hFeVe1dH7jz6KFgZ43n0CzwbH20URHFiyVfFu1YlE0jpLxeK2+5JKY+S/dvsderqq8k2HAJAPf4+JCCpOJUn5S4wiCMUYvS7nrZLy27IF+KIrBC+BOejuIW07xIH5J8rBMT6VQigsqlyzwuXsLrOf6bbDlJYT44ZDCbrV4jbZ6cMXhAykzHDwNM+Kl0tQwN506wNs4lDbuZH8KCXpmP2yjJ8EOTUyOXyshhGnYbiNbI2vgGKueCy2HsuqyWccIBZx5YkPQmYQM9Mx7lsU97R6tEYS8YaT7tS3INAyPGQstihAcz5KdxnxpXL/RlkI9q+G
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(4326008)(8676002)(8936002)(2906002)(5660300002)(44832011)(86362001)(26005)(6916009)(38100700002)(6666004)(6506007)(66946007)(316002)(66476007)(83380400001)(66556008)(9686003)(6486002)(41300700001)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Klr2alfgWym2o2fdbPrunsZ3kyDCA0rY6+/oOzlQbCUzKjXageSc3JnfHi9R?=
 =?us-ascii?Q?bKjnIgQgQVsoiz5NylIhOY3Ns+16cYw1CruA37kVPOYlzvL0oE0B5iQA86PM?=
 =?us-ascii?Q?lyppB5CFIw4bb6q2W/aoW/nHYVCCg/psjYlhg7NqhL66XPdwrdwAtGA14aYG?=
 =?us-ascii?Q?MN3NGRdYwaqT4/EhIUwtO5HUBadsuG09HTjg2oKBbfAIKiP/xBLByHLbRUT7?=
 =?us-ascii?Q?dB04SXRs5KfBVLJLxVa20TxUbFs2a++UYLGKrldaVsYRsOqzCSo8ZpnlX2/J?=
 =?us-ascii?Q?gPykNyHqNl5D5kdwQFak5ItfrGTkotiX2Xkg4Fcw59guL2XyVz1rs6B4qn8P?=
 =?us-ascii?Q?Qr9VrSrxcVfPeE+DF1/i/AdAuQ7sUHCEOJ9eThCbLvLQPXUePZw7N7kO6JH2?=
 =?us-ascii?Q?Bf3BQpbB/jaSF7rJnMvtQJnfYZrBJbg098IA+qjKVwz7cCELCMDNPq6KZ0Jl?=
 =?us-ascii?Q?H0bzTMX1pUTfHPAMOhtA8s/tI+tRiBevxQEIKtMcyzPGVz9ml7YAg4ofBwTT?=
 =?us-ascii?Q?98c6PXB1O7GQfr0CHH3YezYzuZzPOgN7l8shAEXQMZRbqA0KdRQy6SO/y5Ji?=
 =?us-ascii?Q?K4h3ToWLxpf+QLnLhOCuhezu2HQNHEsTaaYZ8vd2CrpmaUj69Sjj9txWA6mw?=
 =?us-ascii?Q?xdncOdgkMB9Oi9eoauHHNAxfDAd+ZeJXoJ/naPy+pCF02q0tYZklVEeLui6n?=
 =?us-ascii?Q?+RC6go3NhhGN9N+WmSDUg697i/2rKISAvx41UMLNcEtyfT+W0Fl+oWzh6Pik?=
 =?us-ascii?Q?z2zV170sZPErxZx3sOj1fc80T5usrhBeMHMYdac0Y4QjcMfy4jWwjR+ZjVqM?=
 =?us-ascii?Q?BCL8De9izHBj1YPi0r9S6QRjQntusHf1kM7ZebeIRzkyQUTQTrPC3RhViush?=
 =?us-ascii?Q?aOugSJl7dtKeD9o4lrq+J6XmOztyZz5TP6fsnlfNbgeDmbFqoxcOKd/aRSoT?=
 =?us-ascii?Q?/Si8qyAArgjLsoyEtOTUi2OmIRJMFdIdPEABHRlgZdGvrlGAtb3nsLjmoAsd?=
 =?us-ascii?Q?l+PdgkeWC6NPH1gulWKSHzQEmWOKo3PPqqLcvEJUdD7Paxl2oFu90dw507y7?=
 =?us-ascii?Q?uXuj3onjXlqpsl+rd9Z1bgUBAZd7086LRMXTjIbDxzC3hCeY8Onasll+k7es?=
 =?us-ascii?Q?M5arjZB/PWi2x30owbS3xNY5WF0kICMCGux+D4rXXmEAMNUkQ7+5SRFSWVgW?=
 =?us-ascii?Q?z3+npuG/+J3I7a+LTgOFO4Nqy+GvuEMHlLmQMixm3jhK4C+oY8l87oU/N9wx?=
 =?us-ascii?Q?HKeQUTjIyhuL1SNd9Iny+AVRqQzq50EYjIBKUui6Yp5BVEy1y4aQp6YLtrq4?=
 =?us-ascii?Q?0WCrphAeEMh48LHpKsgDQbzznnLSGTBoNgXJR6VohXMPUdqhzoyN6Vue9ZbS?=
 =?us-ascii?Q?dX4eBxFIUlsDosOl1LHl9TWym7yURVIyJgfSDr+H6q3Bc2JLD80OMsp6gAL5?=
 =?us-ascii?Q?DkgF0S4XfvgtsP9YJmKVGgZahbxWDNMU9idIGpa68KHNCTSg661f7oJwoteP?=
 =?us-ascii?Q?Ss2lYYLbNN0eXPsyTou64kyqckbGS1NLHdnevCPmNIGg2YcMoWzcBmkbcIee?=
 =?us-ascii?Q?otMPAHfMh8I6jlHWb/d4jhLCZv7KGdo1ol5ysX/n4lJ1EevaRpNQYYlYmlJT?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UUMQf6y0o/Qml75yw31AfX1ecFiG+i10nd2Oxy5xJJiz6YzhBIf88VAJWwpKR6/x5ok8Rm3QaW+4Q7G8NZBTspfutKXoAETFzWuoRBFlcTswUxuElXchbdu/P4Qjiu/n++3Nr9hbVPUiMn2f6dATAiAu7SFoW8VPmDuaxYEFkqegH22LbZm0b23hk5PKRte71r0NAMIWoXI905ka/CB7hJlF1rlFS9yQGHslwd7AIvjpwEqcnHBIAXIA/hNexjKbgv5sEx+HrBX9hs5YahHkmD2BDG86Mo2is6jg/PXG6FFgaaSR+YraH3NhMwGYFGh8Duidn0qDQLETeXZmlO6wgqY/RLpV31hRzQSGzSvU3ZYTxUdwYusMmyiVc6KenS5hS22AfGQ4ppGD64uCnPggQgSQcy6PdCb+FDAeZ3gfH5tpFk+spneoqOm24+PfA2xvD0aOB6p/Z7JXb/oFbq/VQwhFAO/11h2aQ+1FYNzYe1LMSmHkAtPq/oxqgJ77cNDk2rjFiUWNcTa1zEinG8PxsY4iJLLlLdA2PJK+He0bV/0eusMZb08bFtuBHpSBRRwxCNAF4RTq2xMH0xCfn/hobsr3p7yZfqtC3LBY5GTaHoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6f2248-223d-4dea-6a34-08dc30a1053c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 16:45:31.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkuhQseC/AQaS48fuDavFg5hD1w9s5c+aioAi6X5fvqm0u78hgjZ1tAxe4BUpAHuQb5fhHkC8ConcKIGaIVkBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-18_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402180130
X-Proofpoint-GUID: 5ox0jf1mfvfeCe900n3irGw4AxdKB29T
X-Proofpoint-ORIG-GUID: 5ox0jf1mfvfeCe900n3irGw4AxdKB29T

On Sun, Feb 18, 2024 at 01:00:33PM +0100, Roland Mainz wrote:
> Hi!
> 
> ----
> 
> I'm getting the following errors from nfsd in the kernel log on a regular basis:
> ---- snip ----
> [349278.877256] nfsd: inode locked twice during operation.
> [349279.599457] nfsd: inode locked twice during operation.
> [349280.302697] nfsd: inode locked twice during operation.
> [349280.803115] nfsd: inode locked twice during operation.
> ---- snip ----
> 
> nfsd runs on "Linux 5.10.0-22-rt-686-pae #1 SMP PREEMPT_RT Debian
> 5.10.178-3 (2023-04-22) i686 GNU/Linux", exported filesystem is btrfs
> on a SSD.
> NFSv4.1 client is the Windows ms-nfs41-client (git
> #e67a792c4249600164852cfc470ac0acdb9f043b) compiling gcc under Cygwin
> 3.5.0.
> 
> Is the nfsd issue known, and if "yes" is there a patch ?

I believe that warning message vanishes as a side-effect of this
series of commits:

7fe2a71dda34 NFSD: introduce struct nfsd_attrs
93adc1e391a7 NFSD: set attributes when creating symlinks
d6a97d3f589a NFSD: add security label to struct nfsd_attrs
c0cbe70742f4 NFSD: add posix ACLs to struct nfsd_attrs
927bfc5600cd NFSD: change nfsd_create()/nfsd_symlink() to unlock directory before returning.
b677c0c63a13 NFSD: always drop directory lock in nfsd_unlink()
e18bcb33bc5b NFSD: only call fh_unlock() once in nfsd_link()
19d008b46941 NFSD: reduce locking in nfsd_lookup()
debf16f0c671 NFSD: use explicit lock/unlock for directory ops
bb4d53d66e4b NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
dd8dd403d7b2 NFSD: discard fh_locked flag and fh_lock/fh_unlock

plus this fix:

00801cd92d91 NFSD: fix regression with setting ACLs.

Any upstream Linux kernel after v6.0 should operate without that
warning. I don't see those commits in origin/linux-5.10.y.

-- 
Chuck Lever

