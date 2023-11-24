Return-Path: <linux-nfs+bounces-71-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D712F7F7A68
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 18:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C87C2818E4
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D739FD7;
	Fri, 24 Nov 2023 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y9wCqKi4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OI4mekfn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F2D19A4
	for <linux-nfs@vger.kernel.org>; Fri, 24 Nov 2023 09:30:54 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOGI1Qe021276;
	Fri, 24 Nov 2023 17:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=djDglbg713iZUNfj4Jllsl0bMfcBsavisOXmWblqqpM=;
 b=Y9wCqKi4hju6B+8mHfD8QEIQatGQ9a8rMjgJ+gRuJiS/p+Ib/LQLmrrwfvsFPO91lvbk
 PDM8OJDUvgNNpo+BEgsLFn9GX6cMC1y0Zyggg3owur9BZjJi0n8fkNebEOqmWA2a8uss
 oZeOKN/A0vUx9wcwpdrlszB2mpikQ/BlvTnSdnby3tShK6oorjIxyb2tBWVXxAb3XZOv
 92IOdGHoZXGXkC9UcZ60akY1Co4SJ5J7s8+TgAyrufs1BEGsG7pGbrDphmVypLOAahr5
 PqkVg1MhlaCfZQPSffFCHKjPD0SQDkdh4bgJLr/DZikYOe2GVVm6m7r+dM+GP5rypiCa HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uenaduraq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 17:30:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOGtLWM036008;
	Fri, 24 Nov 2023 17:30:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekqbw8g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 17:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lti9+PBhJ99od+GEAxkA9YnzXz/d7uOrFk8niUM1qU65SObUoTEHT8Q+Sp6cPaQf8/G+cJdX++tccYCjlG7hDqAt/FZI/RSurnYzKlkrH/irEM1KBJZqfpWLH9tGfKdwY3Ck/Kvpp+HYFj0gMM+whSjX06UbhJbwCqt4JK6sDu89Ag8IaY9T6Nr3JbxlyMfA20HssaL9C5ac+kPehIk5xYNzivqfrfRw5B0M9fzd4McVkym6WLVFazmOp10QWV4BUYZC8lvKfkZerwdzWm17nxLz3J6TpAxL+3MwDTMQnJwsJ76+rZUVNnBvXGHSwWyhMIIHCax/hfyJQt/d2u+dQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djDglbg713iZUNfj4Jllsl0bMfcBsavisOXmWblqqpM=;
 b=l1IeCdytPptCxzwUSGnQ0bb2IYzsm517XTnenKM/VMgmF92KHMSXyFmexY9/NMgL199YzGd4dbIRuKJdNCPzqgM11zZwJWPtiBVlzhLD1RNag0vGJTEFxgzfUlA5cbUvXIXgbUZbVrB996kPCAvL3cWNug8vihjHjdcA0Ih8t+yqnKMpZxKGiqpocnK55AtlVVBLPTQjYRyv9nsBMJWBUyfVHyEz2WwYbsNlI5JHO+HT8+zGMUmI2VgsqTjboSOEzgz7T1rHdgRUmRex11JdIuvmLEFYEd9f51wYu4nFaIaRrhV4CsjajaolquBjgXGdERh2cHWP/8+5Exz9KxYPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djDglbg713iZUNfj4Jllsl0bMfcBsavisOXmWblqqpM=;
 b=OI4mekfn6eccVcYlPOMNbP9/BPW3qDpJRCkADcZ+4ScMnbBVtyLcL3SxJMq+nrSi5B/UVy990vDQ5PwEgE24K3cp7NQqYnytPoBH+AiW2RvW35a6ckXAUOG8mRlz8liq9rAZsfL9lLwUkhV5R8LeTnSnO2BL1DctI5u0wGwGW3Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6832.namprd10.prod.outlook.com (2603:10b6:208:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 17:30:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 17:30:49 +0000
Date: Fri, 24 Nov 2023 12:30:47 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: How to set the NFSv4 "HIDDEN" attribute on Linux?
Message-ID: <ZWDdxz+1LWR3FClw@tissot.1015granger.net>
References: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
 <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
 <CALXu0UerMnjs9y4gQTvy-v-gqSgO2imFbMAZ87LFj1tQqvfjiQ@mail.gmail.com>
 <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org>
 <CALXu0Uf9LiNL7SA57vSq5pMBVBZESWexcRwDR0XMc9fFpPiNkQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALXu0Uf9LiNL7SA57vSq5pMBVBZESWexcRwDR0XMc9fFpPiNkQ@mail.gmail.com>
X-ClientProxiedBy: CH2PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:610:4f::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0c5347-ecf5-4386-ad30-08dbed1319d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UH9y43wM9i7sSiDElX2ZnUbXTkr5ngzjP364Emty3kOLXr4pwhqJeZbzD/JbxZClCfRcWXbX8aVLZ2NPc0S6yWgwy3PO9Q8A4OajlkrP3tU3BTfZqMgJ5XHTxy1e66ne5la9a72Vzr+g6AbzO5MbTYtGpCvoTZ3a6MtZ/6EdQgKtOi+HG8MQwppYUcqlhU4PeNY00/vi0NmItO0C4b+etO/oNr+AiYmQ2Xx2vgH0TLXjRGvwxHiFr01SoKegOkHQ+eaJ3/IZLJiD68PmuZTkCR9mwjyJV895EKxig9WewooWj8u8DfvPjfjBSZX1wRNBg6GR67RVeprmLokkOBIjiubdoI6SgoEUJRnIq9JAoaeBHz6mjAr0A8sEgLJ6rY/ifQvpbRpx6zZZoQCvgaty0kwuJrzHc5BOyWStXzeh0/kAY3T7VljlnaQWktdtDBzo+vjm2aU4Gj65oF8ah/6czOKHNF3OEwk/R0+CkTfzRiFENOiL1QAodgQFTFQnUjtf/DlC2/plJppfLSAdpOMyxbxdZX5+NKwdOfwonWnTZgdNq+GAik6gcUlscDqj9yMkcPeJSMRsRrZ39v4+jZ0sss4URTp1ap+XlpIZRNnwZyY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(5660300002)(44832011)(66899024)(86362001)(41300700001)(4001150100001)(38100700002)(66946007)(26005)(6916009)(66476007)(66556008)(9686003)(6512007)(316002)(478600001)(6486002)(6506007)(4326008)(8676002)(8936002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GTYnQ5Q+Yul9r7zSCPP67vRLtbBM4JWZKp44uc1SZ+o5BBt7kDW6xUdw7FRq?=
 =?us-ascii?Q?F7wzMmFrsH8ckAL5GANUcWD+5RAE1X6FMiIeTSytzc/+TqivfHQO9t22rRzu?=
 =?us-ascii?Q?SvS379Z5MlmkWRpy119slOX3ULU6iVWGT2hT63Ab4nVDsnEdLReqMI073eVs?=
 =?us-ascii?Q?erqCS6LtowxVW7vd6jbiXT9y4INket3kmmWgTO95v8FIOm5Og57Ved1P+U40?=
 =?us-ascii?Q?X6+e8znumq87AidM/IDYqWcU1aiNQGFpY0aryAAPhdz0WWEOyrOPluSMIp9r?=
 =?us-ascii?Q?Lnvh+qpr3QPj70cmKDvrcOm7PUrmnEcM7OPbzGILyML2g3Obg7BQqnYQuItg?=
 =?us-ascii?Q?+4IrimMfTl9Wxa61g/GZjSIWeiF2FkfFW9gQdFY9c0qsXHZN+3hkKkHrtgxe?=
 =?us-ascii?Q?8qrNG4JVR8R9NNBDS4QU8g7Wmppiimw7iM4sv1RXfn6N7rGjb2rCwaT6NT5K?=
 =?us-ascii?Q?xIi7AKf8peGSNy7vDN0EAI+PR7Ej1YZ5KB8tM0rAooEdegO+ajd1MeVJLuqK?=
 =?us-ascii?Q?q2e5Ng+76yRkfOUnm9vjCEYNVyi/sRvAD9VBMRaNsbc3SNkphHzaIngHiQpv?=
 =?us-ascii?Q?TT6I/ZhSIw7hOw5eXmBEVrXHb/si101YNQJg3iDZMx5qfCEm3L8xKH2xf1Vq?=
 =?us-ascii?Q?oMY4YVmBZUDXfDdjpleagy1sVJ43zHjFFLFP32O6ZJ3wPlFnucqyN8WtrA7Q?=
 =?us-ascii?Q?o0JU5nmEJkvcLxTSp8cHeXNgz6nZUcqlZrZMIHmangyri7G8k6lLV5/Ejqfj?=
 =?us-ascii?Q?sFTQDnRsou86vBqoZO8aZEkIHZcnrSDl6hkNQeL0q4eklVy/emcsOsnWjhvc?=
 =?us-ascii?Q?miMsG5VYJpsLgxD/lz2RzZ/cXKcJqRWnN9I6Eb83wzxDs55OKd77wf6C5ecx?=
 =?us-ascii?Q?zlwiIt0qofqSXysEkv/B9VFitIIIOVatH3QJYsS8CTGQdp1QXIAOhHIWz0KE?=
 =?us-ascii?Q?/NgIgMr0oTdJlYwr8jdHAdPaSfdTiusRzQn08AywChKZiti2lX1hOzYsBkfF?=
 =?us-ascii?Q?YuO7+z5Tf7doJqXWsIzWIxeztcWrJB35oltiv6KqtgQ/nZTU50c6+CVdXOw/?=
 =?us-ascii?Q?rmOJ3zwBTnxQbU6osoq17GnXQNV5AiF/RdUMbmxx6YwD0MoK5BehDC6E7yWn?=
 =?us-ascii?Q?YIhhhhEcy5Ak8J8FHsU0rOXgS5Is4rd4ezxK2z4ab6zFEyuU2ZFHcD0dmv+x?=
 =?us-ascii?Q?ghRBWpqBA9ann5YA+69n9DmaPyElGh3NkNJWa+cni3mGA+rAJfAQWJ95/jvw?=
 =?us-ascii?Q?5rgPK+ARjrkVDMdEqb+Ci0rDwA+NbU1zaE3LOk5zY7oPiP37sRTEdVdy2Fzo?=
 =?us-ascii?Q?x7iNyxumMrTBrvnYAaS/1B76Tq9+9S5ei29ZSnBSmPVq8Oj5U4SUl2K9iB9M?=
 =?us-ascii?Q?nVEa3DPWKNyZ0DHGV9PbDWnbFLVVO6FAFpXVOCZuUt/NdFos05uonULCzafO?=
 =?us-ascii?Q?DpJCCfF2l5iX4khPsE+i6isbMWM8Yw5j3DyD21EqJZ6nHYkDNqTogugspqPi?=
 =?us-ascii?Q?QA+oFYlnx8Otx/zBftuGp984GWKjRO/NpMEpSj/e3VKUtQ+tTeKXhKAgTCjy?=
 =?us-ascii?Q?gvV60LzX+fAMy6ic+V7oixwEnnydrJyMKAKcy0t6ibKGLam9QA2ZUe42Y3dX?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gbfzVWuzmhz8nxKmJqwIXryD+9wzO/tmR3VO+jaGRjgy45jOXrix5cVV8sX4ostoSZ9yGX0ITW+3E6Ry0QNVqCM9uLzp23S64sapjDc9I0Karemvgm+N1gM3M4jicR18DJlF0LTZ7trI8Xxqdi/bPCBLB7duZ54ASxj9tSYBH1GrSuMZc+NepAE4ZjiKYWdd3bEdNdeOmq+dIT/8vM78ywwJGKQrNWgn0BO96Wbo2zColoWOqJPTqwItaAf8UCbanNFAYKzlIROiukzOqAtU5BgdbEwmVC+Ra8KaXpEItwCye87AIg05O/y6EWcmH1ymiDSZbMFd147sYQEN52k2jHOCgcsySZNwG0+w0GSF4mIiQiK3foFyIGbCpupPryp73Jb18/n+0YAR3V5ydZAPj9iqq3PibFAs0NYD6HpeLJAX/r04gWSJk5fwHL8n9WtXqigSE0+Sf6nEt8rO8fholNdqP3TIRsTmLLZPJ9Va6C7/pm2rWF0hs0rPaci3n4tMX0UOsDqOkcbwcAt1l/PKhGznRFvo3MdnbmI4/DM7INiySgWBzZxHagX/++p2kdM/Mqkzt2B3IvI3FE3HfsGoOP7QD1FM83blwR4wbuQwTfoRqmY1Abu34zIJi6v/1YuZFl+fVGILI/V+HG9ooHvx1OsHr/GBLg2dDHZAVSxZccs9EBqza6gvvaSu1n2ZAGZ2BSTBMpocUN2L2ak6BLVXMxUPIKRZabAQlHc7EFErRSam0IAfGwVkGaVYX1FPg4wEYy74O4hi7rVjl2eIXfyl3u11RjqPclNuVOIBzx9JxOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0c5347-ecf5-4386-ad30-08dbed1319d5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 17:30:49.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9swY5sOlpDayluDtNdlshuOOn5IZyxIIqEn9SfveTvo8AdwSyki9xi+1j8fCpsYY/tvVXV4bgt2lpvxRELaSVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=805 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311240135
X-Proofpoint-GUID: iCLfRQs9tJWYeVtXEwfoc96ArvBtfnHV
X-Proofpoint-ORIG-GUID: iCLfRQs9tJWYeVtXEwfoc96ArvBtfnHV

On Wed, Nov 22, 2023 at 11:42:43PM +0100, Cedric Blancher wrote:
> On Mon, 20 Nov 2023 at 12:46, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Sun, 2023-11-19 at 17:51 +0100, Cedric Blancher wrote:
> > > On Sat, 18 Nov 2023 at 12:56, Jeff Layton <jlayton@kernel.org> wrote:
> > > >
> > > > On Sat, 2023-11-18 at 07:24 +0100, Cedric Blancher wrote:
> > > > > Good morning!
> > > > >
> > > > > NFSv4 has a "hidden" filesystem object attribute. How can I set that
> > > > > on a Linux NFSv4 server, or in a filesystem exported on Linux via
> > > > > NFSv4, so that the NFSv4 client gets this attribute for a file?
> > > > >
> > > >
> > > > You can't. RFC 8881 defines that as "TRUE, if the file is considered
> > > > hidden with respect to the Windows API." There is no analogous Linux
> > > > inode attribute.
> > >
> > > Can we use setfattr and getfattr to set/get the NFSv4.1 HIDDEN and
> > > ARCHIVE? We have Windows NFSv4 clients (and kofemann/Roland's codebase
> > > supports this), and that means we need to be able to set/get and
> > > backup/restore these flags on the NFSv4 server side.
> > >
> >
> > No. They would need to be stored in the inode on the server somehow and
> > there is no place to store them. These attributes are simply not
> > supported by the Linux NFS server.
> 
> Linux has xattrs, which are per inode, and can be backuped and
> restored via tar --xattrs. That would be good enough

This being upstream, we are more concerned with a properly
architected long-term solution rather than a proof of concept.

If Linux were to support them, I would rather see these treated as
first-class file attributes -- such attributes might be used by
Samba, the SMB client, and local accessors as well as NFSD, so they
would need a common and consistent API, through the VFS.

Since they are not POSIX attributes, I think they would have to be
plumbed through statx(), and each file system would need to
determine their own mechanism for storing them. The VFS API would
also need to indicate whether the file system supports them at all.

Again, this is not as easy as just stuffing these things into an
xattr and all of the above is outside the purview of NFSD. As we
don't have any Linux-native application use cases, I can't see
implementing support for them as a priority. But as always, patches
are welcome.


-- 
Chuck Lever

