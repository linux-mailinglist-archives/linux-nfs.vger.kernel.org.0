Return-Path: <linux-nfs+bounces-72-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102187F7A8B
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 18:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3028A1C2089B
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 17:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E88381C2;
	Fri, 24 Nov 2023 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gt61SkdO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wojn8UG3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392301988
	for <linux-nfs@vger.kernel.org>; Fri, 24 Nov 2023 09:44:08 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOGI1fe021180;
	Fri, 24 Nov 2023 17:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=ZclGvsQJF/8L9/vPMuTu5jmQp10L0ORwawrlKFPuz1M=;
 b=gt61SkdOQ92BYgGAt9WwQVwC1mAJyh6DAr6iKn3KWsko7Qr89/jRuevokkKUhVGLSlyE
 O21Vky9ch1quejtm2uvyMMycCHBciZXSalRkG/OPVu4MWSAI/ajgpBPcsrhKknR4a8kD
 effUES4tie6NT7MXTJVd2uc7OramOD+2Ty0OaQ5Amzss5S866h19NOF8Dmvqv8NSotsm
 9vIrmrIhQwqKFluYIQVkqDK9Z5QgC5ruvQHDi6XSk2Hdo8GsDQDaQNMbDVjZ1UgSklCG
 I9hG59TEFNVe8cMVFpBWdkACxyoks5X7zKVnKpT+Lx6cT0VsNAoSIAQG648ALnsIQBOQ Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uenadurrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 17:44:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOGvL7n022962;
	Fri, 24 Nov 2023 17:44:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uj3y70bv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 17:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTxSWfrSH3t8P/o/KObvrPEy83bZeX4zuNSO5EQCKc4CkXUIPD58X8T1o32Az/VsrpH0wgcIgkYvXb6a72k81eoe/VgETmeVPV/8uSJgH5HgS57V8ldSQcDOtbMNMAHmvaHHC7ZckbFFCYM/9qj6ypf8jXM9KARQ7pspfnRF7wWzcjdu2d88+pfVnRKQ7F4cQq0JfKbXncis0+NsDKAsQPeMVsz0unEbZsU2FBnyfr8OiNVC1s5CI5Bp7XjQLRY6DTe27NhHNQL4ie2tJskfZYOHHCzRJvZdC06fsLWojDWpq1/vcoCr27n5Sq6YGr4e0z4G71HkJgO3iGJIOyHpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZclGvsQJF/8L9/vPMuTu5jmQp10L0ORwawrlKFPuz1M=;
 b=i8TqfBBZDJJwr1vHRgkUbj9+bdL1Kyk82j4LxVsIml3DoYg3cheScEaUafuWhW3WSVQoCxDx6Y3KRvFnYihfajGqR//vbRvBGhbZC7KMGhbUoqJxkS6Hl4adI8f+POFFuxyHkBefGwwTo/gOxNSksvmv3Gje421DQIAIisOsAeoxS1EQChQoMKFi2x1XEIiqmGx561qimji/fi4N1GtCAJuxozKwL/wi7m7TryFctbcBzBJeJPxhTpYhePvWqBFWzI6mH+ZVOgp8m5oo85aNr9WCtyYwYh8Y4ZN6juqIlrawVnYP1QHmqQepaPTONmEp7DNl3t0GN3sd5fCwxUjEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZclGvsQJF/8L9/vPMuTu5jmQp10L0ORwawrlKFPuz1M=;
 b=wojn8UG3GuuitwhzOCJIt3hxrARWaYrQ5QTWFh1IF6x8NoZWFSc1w85sorO8Fa1ctcmRrE4ieb278XdhE4tc6IVZhwzTOmVEfswotu6WBjwhvw8yA99lp+AluIH/BIxArTJplNuSvxBTNYNmLsZYUj9APPkh/+1O1FttUnvstko=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4878.namprd10.prod.outlook.com (2603:10b6:5:3a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 17:43:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 17:43:27 +0000
Date: Fri, 24 Nov 2023 12:43:24 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: <DOT>foo gets NFSv4 HIDDEN attribute by default by nfsd? Re: How
 to set the NFSv4 "HIDDEN" attribute on Linux?
Message-ID: <ZWDgvFfkAF8e3MFj@tissot.1015granger.net>
References: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
 <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
 <CALXu0UerMnjs9y4gQTvy-v-gqSgO2imFbMAZ87LFj1tQqvfjiQ@mail.gmail.com>
 <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org>
 <CALXu0Uf9LiNL7SA57vSq5pMBVBZESWexcRwDR0XMc9fFpPiNkQ@mail.gmail.com>
 <CALXu0UccoNs0A4MjQH7gPboarWyZcRQzsy2zJRxk51LR0hGDVQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALXu0UccoNs0A4MjQH7gPboarWyZcRQzsy2zJRxk51LR0hGDVQ@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0403.namprd03.prod.outlook.com
 (2603:10b6:610:11b::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a1c2c4-302e-4e61-f715-08dbed14dd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	conN4IQ46BFUmEqEL0Cys05N6DIt4x3KAF5GNr2kCCZ0hzhc3Kng32gEOLfZ8iHnxg6TL8py9/lPM6hLf3ts29ObNIrY+T3POrI6O2tzIpmrh4vnIzLRhPprxZbhO1R1vUdCA6kqmr3e5MHidtcnzksG0da8LA4UayN2zOYk5nEA2nVotZXDq7O2YfmmOiy8GeDXwV5bsz0reooO/7CEnOJzdoUsXE2NWcXpL/+Jmi4a6lcJsQxwrSvstje5/H3/Ic2Uac7rltRkEV939lwOLJUBizBPfGNhezvBcy2/T73RrbFbaWs5u3P/WC25Yoj5zO9stSwTGmfNjHXSFO1bFjUcsZRzypqkPEHXxMF5aNnQFB81Vc+iGrRTVJti0JIxkk6jy5DI3M2MPcsySW+7qKsPH+hRMs2iQ5pnxMby6Fyr5qzlohcKViWgO+vCOEZqHGDC738XjUbrY8faw7kS8gWW89aJvzJqPJyFTlA+CJQuqfyjQpxG5LCdw5XQXKXaowOk/EskUUMZHU3qoIY0ZwzjyyPaENDLTbWF7MlruBUlBUQVIRBehr7/1qbwrZ6e
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2906002)(4744005)(44832011)(5660300002)(26005)(66476007)(66556008)(66946007)(86362001)(316002)(41300700001)(6512007)(8936002)(9686003)(8676002)(4326008)(6486002)(6666004)(38100700002)(478600001)(6506007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GWADF70CAQ+W27Hf/qa8my4IoNgngIUVkW/HeGGNvvoE/10MN35hGMlm7y8Z?=
 =?us-ascii?Q?DKl+DJUV8mp6SUy/4QAwMLQpWEkCC5+MhROKqSM8FwOUaUu0/ASE5seyG9Bm?=
 =?us-ascii?Q?oh6yAYSizUIw8Qv1nbgBz+zkwnfFtACE0xTbSeAoeCJf371/JQj6/AjO/Z5E?=
 =?us-ascii?Q?uLgPGHQAwiUPSuooD8ddFYHMza+mptM/SSFsVZtMHARDeORMP339VcgEAl35?=
 =?us-ascii?Q?MPdG9d3vIbwV3LDUE4TEye+0zrpyORKonuZC7Nx4U5lBQWkA4c7iCqj+Tm/O?=
 =?us-ascii?Q?dg8C6yaxV9J6AX3+YyShc1Xl4Q2pAl7UpP3izmVkWmy0SveBtON0YmCGR2cQ?=
 =?us-ascii?Q?2N4g52OHglGbRxAlAqxAAQP15OrkHk8NE71X98NaFw27kI1r3fDei88ezJrI?=
 =?us-ascii?Q?QA4JoMIgeRQreArRhTO5b18Ytw6sEgPpFWgGwyv7txUqt9uTN9nEf43ms2qq?=
 =?us-ascii?Q?8NCM/h0/Q6OqUVLkHABol1yN9VbP6f2RVFJ2dFTLCq7g4qejwxlidZInGRkN?=
 =?us-ascii?Q?i3xEw9KfMfqeyV4CNind3DF/KFdQw36ljyy6dZhEQKySqOVHpxLzIWZWnsJm?=
 =?us-ascii?Q?PYVZ8Zi72CMlYOK6l1vFfytNihlAHmEbEi7g6mtBe7wcW2fcxrSg2bSJgZgn?=
 =?us-ascii?Q?y7MbwJBAlqvlILxsIqUyhQYr33FwgQlkgHY5WGstWbAtYHrm6RuMLyYIPyZq?=
 =?us-ascii?Q?GYIeIIhbflxme/FHuSHJKXV7S6Lw5UsB1NvfENJgpz8gEAboo+S0WEYQkpbE?=
 =?us-ascii?Q?4RJ//bvu0NaMU+sZvkYxS3xZrPdwgVdB58t2H+HvMBI2C8VNHZoW37OLdjf5?=
 =?us-ascii?Q?cg609Oyl5nyaqnNkkrJhDijr6BeZ5RGcPrZWz5F4Dz0m+PBfXPNiuSwtJynZ?=
 =?us-ascii?Q?AfKlRdBK7xqkXhasXia12R5Qh5Q8ceeiw1aF7IFkTgsWlBaV8pEvXxr4l1xK?=
 =?us-ascii?Q?SCCVtHwFPgOUx9/dyEvnj6vNbl+4Up8Fl1U1JvtN2zOuiAAp+AMc8B+ntK5l?=
 =?us-ascii?Q?uE4VrFzOqyaL9A/sy0jEUqqUy8+qmRgQQds0Ak4XAI0XLoCJtl95HClGhuLZ?=
 =?us-ascii?Q?P7S6tVeOe4RtT+jG6lFZ5uj2lJpbxpkeXmBj6BeXLPxCOM7dQ7JijnyaTmgp?=
 =?us-ascii?Q?aKUORP+l7kkVPCG54I/EpUeQGwt5U3ArFOA/yQ/N//bxp8K8vxug4gbFsQF9?=
 =?us-ascii?Q?mh+yGntsGHQ/smZGmAnpE8EadW0Kc8uoL2gVpi3j+TA9HGvmNUnho5NLvk53?=
 =?us-ascii?Q?i1wLKVqh5WLursTtFvYjik6h0hzf3QLlkWCg8wtpUeZVZ6X646pGhcfpWn0p?=
 =?us-ascii?Q?hTnFTmncYS4GpTbniAHrhyEfg9QA1eqG66w4ixCSFWJ53Ko+m5D40gKNuRd9?=
 =?us-ascii?Q?CLNNlgNrnPDPYXG06hyPIYiNLkwdp56v7KGNPMSahT4JGDvh/EbQDkO9MSRp?=
 =?us-ascii?Q?iPrrUmvpqzQfnykpeRIjJM89oAkeKoli1LCKrR7bC0PyvPccCruAkFGZXlTM?=
 =?us-ascii?Q?7f2RkaF+SGDh7CF/zplY8NWYwZp7HinJGPidJ28HuxItVEpKyQivWsR15Uha?=
 =?us-ascii?Q?yc6GnnARyhdtsLVPFvFTxH9Z123O1If73RnclnFmn1yUbxWlTHg/4X0cDZiA?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ih9FxGxHyLpetAgNpCzcMyZ5eolGbgLrE9VkEnHlhqrWRT6FpByuc3l7kmnfOSvXO03g9jUbzY3VmlC4kH+f+XxrcK+zQBCWaO5h5cvmzUA8dWYbmsQGyUQHgiRU2dqgH+CVxJOGBsIuPFVB5uKdA+kQJfkkb0L17N6VDErm5sXTkImwdbjhhKYy3G+4D6jfq0hj8Gk371bEPDfVpSSJZHf4dxqq0q/EIAAhGBPJsrmT6PbUD1GHWMOmB7fI+EDfWb0rhoX55zdAtKl4Iv62tBv4DvT1hTLP/Q24QoOlN3qIUmbl41EBCL/WcPon5TfTLoZACQihUfpVLl8+xiV+OMkP5Omv6wwBpDEEAZELrwbX4at2OgSaWCT9sRs71rOpMhUg2ti+VvHz1i+Nc+xaNoV4OuWTn88+qfWmOzc1KdtgFlPdKiNT6JpXeSgD8TcT3GDDjUzzqI8BK5n0wRi0OpynKgSm3lzlW/DcczFGLjThmWLHgETwFShdp44nXLXg610/t+5k6qBJx0MAwpa5fwQZTokeFWPUhQYPTpm1qQWnvKVLajPOEalnXDVvzJUV+vaEEpSq9WhAbhtONcd4PlSeDW/qUKBRCieQHieAlcSzi9cRiZjSkBX7kAKeiFIlTeeAEIPCJnqCUGPnTLinnLfNJ3jgt+rIr1dmQx0FL9qXtg17AYscElXVoqG8WkZlWgOUcS2tTlR4g3GF4hVyjEdOjur+81TGxDmdWv+7PH7+xdftvEZ1VK903LQeLYhk20euQUBKiGdg9m7+b7uTL/jt6dFfHX8nCIGtQ+sTJ60=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a1c2c4-302e-4e61-f715-08dbed14dd54
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 17:43:27.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSvcamLWJZTY4SVpYeQYncg0VR8G0p+/WiQLBH2NxINDFsZNc6eWsl626vF1qfZ6G0hO1C153Nycw+Fu2B4ipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4878
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_04,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=717 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240138
X-Proofpoint-GUID: 7NvVaQOBE7XW8crBr4EtFmNgzbimHWbv
X-Proofpoint-ORIG-GUID: 7NvVaQOBE7XW8crBr4EtFmNgzbimHWbv

On Thu, Nov 23, 2023 at 11:24:10PM +0100, Cedric Blancher wrote:
> Also, it is legal for a nfsd to give the DOT files (/.foo) the HIDDEN
> attribute by default? Right now on Windows they show up because NFSv4
> HIDDEN is not set, and it is annoying.

I suppose an NFS server could do this, but I'm not aware of any
other multi-protocol file server (eg, Oracle ZFS or NetApp) that
does.

Dot-files are obscured on POSIX systems by the NFS clients and their
user space (ls and graphical file navigators). I don't see why the
Windows NFS client can't be similarly architected. Or perhaps it
could fabricate the HIDDEN attribute for such files itself.


-- 
Chuck Lever

