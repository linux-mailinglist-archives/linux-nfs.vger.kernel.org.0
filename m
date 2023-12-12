Return-Path: <linux-nfs+bounces-504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303FB80EE1C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Dec 2023 14:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F802B20B30
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Dec 2023 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339FF6DD02;
	Tue, 12 Dec 2023 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Puru/QsB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ml/HRcrP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB41783;
	Tue, 12 Dec 2023 05:51:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCDimN5007180;
	Tue, 12 Dec 2023 13:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=T31rXM5AHHXnyV37Oyi9+2AhyBaw9lSbBmIZ+PdsSy8=;
 b=Puru/QsBjFEtIVH1QPR9r/FBWRnI6XcPjafZuvBpJ0z5aS5JHhoaJ72jNrd4RXewq2rD
 SGGaYs3rOkbep48OWRDwKF1f12aNlULMMfOMAMBTPnk7KbMhWjSQMHYHZIFi3833xDye
 5/On6Ez8X66ObnDIxhz2WYLJWXyuqIVuaNKQHY/swDsskrHZlt5AYVovTMNXff5GaeYF
 dq+kf12uaklgk18Mr9HwLs2/yJDbduCJSIExph3lalA4w/G61gF2ZCZ+HpN09qUQKYN8
 LiB2DQon3im3mYhYLNfuTF/n11MY8PwoxOj/0fy1PPIbXCaSfRsltyLHSePOgZikbpmJ 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3kxbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 13:50:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCD10IL012964;
	Tue, 12 Dec 2023 13:50:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepcucf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 13:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmGYv0W1OcTtrVJIDBhBJ2ZGM1pw03nf8bFU5T39ua9rOzHgqsFNkP/516kuerSO6UdpBT4Q8RcaCIpCnqQ/+NdrzXqR9dJQResuRUeSK8BxFF1Kk1hKgAux8zERURSgZaNK2jVZo5F6vxoo69SrT6aFxV+DKckT6gLS2M19Rr8NkJpdpbwjv+t4pNBRfwGS/kT73+QQAJ1p1c3uGsQ1lqH95WTUr39IYiQUJWpa3XdJqkq++iMdADSI5F5fOsLijD/tfbjLetA+Qe+GcNSfBwvEGkau80Cmwfx+WqIAAw7b+tWLFK6nHdOeyHQV4QKP7qFc28Qns0lrDlZxUE0qMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T31rXM5AHHXnyV37Oyi9+2AhyBaw9lSbBmIZ+PdsSy8=;
 b=ewfC4GuNigL5T9G8cWuzZ0gBYXXAWIEs5WpP5nt1ibWpxrbEjicpRE6ggqfy1Wt+/rtVt5BJ2h5XCmD/3UkLINQomAfQMXcNZQpxcxd0A9Xhy1upooAnysC3wUqE/iimmxSfgmu0SdtGX6UHTlOi+u9QC/PptEJf1n1lNi/w9c1qeMnkNB/V9uNTCIkNz0kdN2ysfp4Dc342NzTy4LOJU43u6PmKMcFY52NkdluhMjaK/vhRPEukoQixixL3LGq6R+SN2lx9U2H8YflOvVhNLYFsYHX/7qce2+rGPbYGmbhUuCgbXH0UF0onNYDmtfNxtBQqaj+yWYzlY9qriG9Q2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T31rXM5AHHXnyV37Oyi9+2AhyBaw9lSbBmIZ+PdsSy8=;
 b=Ml/HRcrPGaNq+N1Tg7l6tVE61MSJ9oS/eHBM/jvHJmXBGu8EofrSdCUjU9r/JF6ZMQ1Zoqp9Pd6IrA1h3iXRZIHwaSigbV271iSzXb6nDWf1jkC9V5WaBWobUSgPyF0SbCRXCPiGDRBTtMHvNCh8ZhSUROKiwLzsZNEk0I6zwFQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6638.namprd10.prod.outlook.com (2603:10b6:806:2b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Tue, 12 Dec
 2023 13:50:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 13:50:49 +0000
Date: Tue, 12 Dec 2023 08:50:46 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>
Subject: Re: [PATCH] nfsd: properly tear down server when write_ports fails
Message-ID: <ZXhlNtQ9o+howGbH@tissot.1015granger.net>
References: <20231211-nfsd-fixes-v1-1-c87a802f4977@kernel.org>
 <170233558429.12910.17902271117186364002@noble.neil.brown.name>
 <a2b59634a697ae07a315d6f663afaff5cd5bf375.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b59634a697ae07a315d6f663afaff5cd5bf375.camel@kernel.org>
X-ClientProxiedBy: CH2PR12CA0029.namprd12.prod.outlook.com
 (2603:10b6:610:57::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa21ff5-e4c4-4a05-9c90-08dbfb195929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QeC+P5u6itztH8CHWQnm5eCRrlhof2/+QogJWCWJmA0KAbu5a5cE1pf4pji7KTM/INKNChrF51GOpHsB0YykuMaIsFId1b9ud3Jkw1yOyihmbMtSCz1Y31zoa4B9Mp11Id+WeqkzGW8+iUGlrdXh/ZQwop2fMpyHS22yyYrW+zIVc8DTym04DepwQPJPCAGqo9WA5FqSRaYwyDkFMP334v+ursrkac7TniuMuRgTo4Tj2X0ux6Gpt5cVk/WfnFXmyZItl111ygMeh/Cul5VI3Pbneuqk14XBModrohbYXGiwIwYtpXWtLO2FhfelpDDrEmK+xgyT/hnp55tzm3c+tUr/pKt9afrzdydpNIh0C1VleGTOJg+GFX++0JEqnvlgF4OAs/gLaBWP4qolQ0xLaoAXF2Ih3km1MbHPT5T6fp07ugUamPqIyVHxMqbUgJBgjCf6l/Szex4jAN1YVIDngIloOBb5DHxs9CUKVHAhHG2dO6KV0Xm+gdMBwJCuH8ToOXAxk4JHMKkVO7PxpV0L9Y/CLNlWZ7ySVMDtBoUOPLrsquqNIvWUGr4pN7FidRR4jn0tNGxpoWS2pwJu9zRIkdEFxMi8eg4qersPf9Jsf2w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(54906003)(66556008)(66946007)(66476007)(83380400001)(9686003)(6666004)(6512007)(966005)(6486002)(478600001)(44832011)(316002)(6916009)(86362001)(38100700002)(26005)(6506007)(8676002)(4326008)(8936002)(5660300002)(4001150100001)(41300700001)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gYJ52T89F2NvYilFNNstEoAwjsbNa+rVTMERkZx7b3Q7pP7wfMM1vSi9QtNP?=
 =?us-ascii?Q?WCZsOzuIfgeL4cHBTLzA7LUn+lzzet35VFErU905Lew180+yaRXyaUCfRzSj?=
 =?us-ascii?Q?9qjR/pkfVc1QDmTtBnkJO19g8OqjNE5HDqJNXx8+LUu/Y9jyr4p2/r6Vejbs?=
 =?us-ascii?Q?qh4ZAk0pirDpM/MQYPlFqZDnmkbnM8Bgw4ZDF6VnoZUKOpnCZA55qHBqYSq9?=
 =?us-ascii?Q?lmATbGNBueYjFPeqYvqLbvITaWqTT6wL6owuW4sUPPn/L/k0W/wKxaDPpwsR?=
 =?us-ascii?Q?mrthizag7ReTU2BR5t0a7ncXfLDJ6jjQz12iEPXdB/tSC3Hw+s+iMlHYTT2W?=
 =?us-ascii?Q?yfkwu2H+Y/SrZq4yB2b6FCIKOfxIKeweUUZXEyT5aNBPBXYzkKbknFUZUk2E?=
 =?us-ascii?Q?fd9Jec/ntbSUsHeoqtjSbAkyjZZ//lV8aNGmGyQeFZmvCdbqrDEJRNKofDLG?=
 =?us-ascii?Q?TcgnG1hYNDuwnDFmLNCt+khU6wFO9s1iKz8pWbfKDwXANaWWB91TFSwqtMbK?=
 =?us-ascii?Q?XJR9p0UdhNIjRyu4+DqRm2YvhhEiBrFbiSIVJ0J14bHU1DuZmZX8a+k9ghWq?=
 =?us-ascii?Q?tU5pkn110Aocg6xraB2fF9YF5HKhXUL7RjUA3z6ASSFGt1MEn1BqkvPJubwo?=
 =?us-ascii?Q?py5EW4RpQzaCy/Fql4boI/0Ih8IGAOkFMmRNGxwdG73vhSwhmYHpOT0mxKha?=
 =?us-ascii?Q?TV+m2h1vN5Acandf//k6x4Z87mSpkWD99e+Jb6U4kisaMe5ySBCUEga2QJgZ?=
 =?us-ascii?Q?dIg9+YgHAzIfVZGeM+nqkn95pgyfVbaYMV0wifA/Gc1OlQ7+TtQlNgdjXyrn?=
 =?us-ascii?Q?pRcxSpmKv548OL5K8UZxc3WXCEA0frmocc6CUTOCS+jCkMApwQL7gho8Ad6P?=
 =?us-ascii?Q?f4b3tp5KA91JeDnhBpINW23EgRpMhg2/IBy7/bTLbG3j6miFnpx9BE7STgdT?=
 =?us-ascii?Q?RCogoqzeWKqZnBObWW2JERf9v55nISPI/sQSSMu5DOFhsQvcCzHMbuRDvtHR?=
 =?us-ascii?Q?oRqsokwB/jnwqBh4ILYDUhJKpZV4UwT0kD/WSg3knLyK8LPwYZ+Ba7W+vvQX?=
 =?us-ascii?Q?yX+hFDJc1ei8EJXHbVh9jrw0taSaA86uO2agDjiQNEGjkwNNiPy99DtB6c0o?=
 =?us-ascii?Q?7zKKgogjgyF2CaG9Rk+REjeJxIQMkwqffHg1oGdFxw5UQrVYasM1Ec6Ijonv?=
 =?us-ascii?Q?2ioHs04QMOJ7FpMGukJwCTEw8QT8zBo0jVnYaSeLM9QHIkDavnS5Ca7C0HvT?=
 =?us-ascii?Q?jS/x3oX02TQqUyuap//FZjz2rPDjnXPDP+DO8oHIaO7yzp9c7I9n+mt3yVoV?=
 =?us-ascii?Q?idPHGu89/A1ZChOAl5rYDJlgoxV8bfEvuKY+PyreOyhZfvdxnyROxmhtJBJ1?=
 =?us-ascii?Q?AUJKdN+lpJ/GZD31kF5lZDQa4/jfkOGLZnMFcZL0jR9RCDabecZze1TVy7ts?=
 =?us-ascii?Q?cV6ZPC04T7DBhYITFU6ilqe2Mwm0wfkO6PcuG/wax2PQGr4w2dFmiqKgn9qw?=
 =?us-ascii?Q?r07dL2g5kBS50qDL/cT6OSxtwPuJ5QnCwshNgemPvJwNKKt7wibpy/IUdv/Z?=
 =?us-ascii?Q?dMvFEINjCFeCe0FV6u9dzprW47uYZJsqF9IlcEBq94G+dTbttMPo0ydSD0lk?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	t1/ck1qoxU4txX/TyZs4Cp8RwfGIOJeSRB6E0cuT5HpiKRiSXj1jmCJpT4PtN13lHzyIczhpTc7Y53tDL9ZGA6lPY192q7Jme3iAbDjRb9o7zJm80EaSB8t0imTSXNRNebaOhK97a7CgIa0hW97wSx0yvaM4jQS814eUbp2/Uz+hdjQGoa4zz85c/cZyuVO2kVaiV4TkE0AhUqqHPM8q/iM63Rz09rOCmCh/sj69CM9jPDlnsQwyBSzSgcKsgSCLILmTRMzg9tLLNA5hW3BL4nzBBto3aBxlLBRjUlBqeFrnlIPbpDsA8BveWIZGsAN/AGYFctPlreCQYX/oLpLKKZ0eFcuMAc7bXRNzrpl152+92FMEGIvpXgBWyUexpQ1Kfa2aqopZ5AiFpjWY40JXgAl+suSFGBF3xxp0h/rhL3+Vea2PqHQIPEiywaR0y5PH9az9QGiPFw1Bv5qQWA7rCElxx3dYD9qZPweg2rqMqIJTpbv1mpIs9OhtMgSeSwwf6k7GQDuK8vOuaY2uAWXoDewnf8YGoA2VkeFNUavRebTqwc17OO1QcWgwVA8JBssjPS3Xl2Dy7xvGysQPcna1zihIBYtGCP3WKnhgMsEdYdLCEAUrPwPOs1yx8WTmESp/p8gPU/9oNsr2Ktd87KASjX1A4CHOotXIqjLMJnVGHFezxhKHTkxSB9M4PxRF0/55HUo+wyVpGYIbjMFBhdxZa2aCQqtNPu1yVV0jjjcCeXR8TpfTSSgfF4K3oKFJOKa8xZDeyX+tdTTQEzayPxI1xdPxYgi1Ge0mt9zMpuS1FOxNCzpqbbDPOW1TpGyxVHTjvXcZe0Ysgyj6FrgKeTyZTpqldzFFHvFwK5Uf4fPyS6q0i5KODOtoeKRS7RGfdhX/v06n9GSw5KzUrstB6Pe9uw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa21ff5-e4c4-4a05-9c90-08dbfb195929
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 13:50:49.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ld3qHV4NEU8jV8/Z5ZcuOGHrqpkbw2mwAlQ2MXRAOePPsbZUj5VW5o0KnjWZ+jBqX50hiXjqn2AM+Py52l78Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_07,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120107
X-Proofpoint-ORIG-GUID: g745U0M1zMFI6y3zVFUuHlabhIURfCY-
X-Proofpoint-GUID: g745U0M1zMFI6y3zVFUuHlabhIURfCY-

On Mon, Dec 11, 2023 at 06:11:04PM -0500, Jeff Layton wrote:
> On Tue, 2023-12-12 at 09:59 +1100, NeilBrown wrote:
> > On Tue, 12 Dec 2023, Jeff Layton wrote:
> > > When the initial write to the "portlist" file fails, we'll currently put
> > > the reference to the nn->nfsd_serv, but leave the pointer intact. This
> > > leads to a UAF if someone tries to write to "portlist" again.
> > > 
> > > Simple reproducer, from a host with nfsd shut down:
> > > 
> > >     # echo "foo 2049" > /proc/fs/nfsd/portlist
> > >     # echo "foo 2049" > /proc/fs/nfsd/portlist
> > > 
> > > The kernel will oops on the second one when it trips over the dangling
> > > nn->nfsd_serv pointer. There is a similar bug in __write_ports_addfd.
> > > 
> > > This patch fixes it by adding some extra logic to nfsd_put to ensure
> > > that nfsd_last_thread is called prior to putting the reference when the
> > > conditions are right.
> > > 
> > > Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> > > Closes: https://issues.redhat.com/browse/RHEL-19081
> > > Reported-by: Zhi Li <yieli@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > This should probably go to stable, but we'll need to backport for v6.6
> > > since older kernels don't have nfsd_nl_rpc_status_get_done. We should
> > > just be able to drop that hunk though.
> > > ---
> > >  fs/nfsd/nfsctl.c | 32 ++++++++++++++++++++++++++++----
> > >  fs/nfsd/nfsd.h   |  8 +-------
> > >  fs/nfsd/nfssvc.c |  2 +-
> > >  3 files changed, 30 insertions(+), 12 deletions(-)
> > 
> > This is much the same as
> > 
> > https://lore.kernel.org/linux-nfs/20231030011247.9794-2-neilb@suse.de/
> > 
> > It seems that didn't land.  Maybe I dropped the ball...
> 
> Indeed it is. I thought the problem seemed familiar. Your set is
> considerably more comprehensive. Looks like I even sent some Reviewed-
> bys when you sent it.
> 
> Chuck, can we get these in or was there a problem with them?

Offhand, I'd say either I was waiting for some review comments
to be addressed or the mail got lost (vger or Exchange or I
accidentally deleted the series). I'll go take a look.


> Thanks,
> 
> > 
> > > 
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 3e15b72f421d..1ceccf804e44 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -61,6 +61,30 @@ enum {
> > >  	NFSD_MaxReserved
> > >  };
> > >  
> > > +/**
> > > + * nfsd_put - put the reference to the nfsd_serv for given net
> > > + * @net: the net namespace for the serv
> > > + * @err: current error for the op
> > > + *
> > > + * When putting a reference to the nfsd_serv from a control operation
> > > + * we must first call nfsd_last_thread if all of these are true:
> > > + *
> > > + * - the configuration operation is going fail
> > > + * - there are no running threads
> > > + * - there are no successfully configured ports
> > > + *
> > > + * Otherwise, just put the serv reference.
> > > + */
> > > +static inline void nfsd_put(struct net *net, int err)
> > > +{
> > > +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > > +	struct svc_serv *serv = nn->nfsd_serv;
> > > +
> > > +	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> > > +		nfsd_last_thread(net);
> > > +	svc_put(serv);
> > > +}
> > > +
> > >  /*
> > >   * write() for these nodes.
> > >   */
> > > @@ -709,7 +733,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
> > >  	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > >  		svc_get(nn->nfsd_serv);
> > >  
> > > -	nfsd_put(net);
> > > +	nfsd_put(net, err);
> > >  	return err;
> > >  }
> > >  
> > > @@ -748,7 +772,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
> > >  	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > >  		svc_get(nn->nfsd_serv);
> > >  
> > > -	nfsd_put(net);
> > > +	nfsd_put(net, 0);
> > >  	return 0;
> > >  out_close:
> > >  	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
> > > @@ -757,7 +781,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
> > >  		svc_xprt_put(xprt);
> > >  	}
> > >  out_err:
> > > -	nfsd_put(net);
> > > +	nfsd_put(net, err);
> > >  	return err;
> > >  }
> > >  
> > > @@ -1687,7 +1711,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> > >  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
> > >  {
> > >  	mutex_lock(&nfsd_mutex);
> > > -	nfsd_put(sock_net(cb->skb->sk));
> > > +	nfsd_put(sock_net(cb->skb->sk), 0);
> > >  	mutex_unlock(&nfsd_mutex);
> > >  
> > >  	return 0;
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index f5ff42f41ee7..3aa8cd2c19ac 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -113,13 +113,6 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
> > >  int		nfsd_pool_stats_release(struct inode *, struct file *);
> > >  void		nfsd_shutdown_threads(struct net *net);
> > >  
> > > -static inline void nfsd_put(struct net *net)
> > > -{
> > > -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > > -
> > > -	svc_put(nn->nfsd_serv);
> > > -}
> > > -
> > >  bool		i_am_nfsd(void);
> > >  
> > >  struct nfsdfs_client {
> > > @@ -153,6 +146,7 @@ struct nfsd_net;
> > >  enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
> > >  int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
> > >  int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
> > > +void nfsd_last_thread(struct net *net);
> > >  void nfsd_reset_versions(struct nfsd_net *nn);
> > >  int nfsd_create_serv(struct net *net);
> > >  
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index fe61d9bbcc1f..d6939e23ffcf 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -542,7 +542,7 @@ static struct notifier_block nfsd_inet6addr_notifier = {
> > >  /* Only used under nfsd_mutex, so this atomic may be overkill: */
> > >  static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
> > >  
> > > -static void nfsd_last_thread(struct net *net)
> > > +void nfsd_last_thread(struct net *net)
> > >  {
> > >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > >  	struct svc_serv *serv = nn->nfsd_serv;
> > > 
> > > ---
> > > base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> > > change-id: 20231211-nfsd-fixes-d9f21d5c12d7
> > > 
> > > Best regards,
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

