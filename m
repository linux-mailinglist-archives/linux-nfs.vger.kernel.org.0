Return-Path: <linux-nfs+bounces-262-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C548025FD
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Dec 2023 18:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78621280D96
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Dec 2023 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02A168B6;
	Sun,  3 Dec 2023 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JkMJQvDu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SN1LJ0S6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7FB6;
	Sun,  3 Dec 2023 09:32:44 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B3HEntV013841;
	Sun, 3 Dec 2023 17:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=znYH7snNbK+SzcTrUI8CY1p78VVhQKtgUG6KTjNNRNU=;
 b=JkMJQvDuLOi+8D52bbMBywMfciLZt2RGdyiqrd6gNofL1xJJrDplWdBVWijNFeVS09hI
 B4/IOuZ98VK9Tj7RRqto0j4+1NRtjRNgVB8p91QDyBSl8d9+mBSPb7k3gpH6AWgmxQtD
 8mpZa0YLKVJxaaIgWNH0BNqdw1uoJKxwILXTo6t3Njo7Mpx8IJ9ZWESJFt3Yup3YTQ/V
 Wt8IqtmagAu+mvLxvMw9hOPlM1/6n05/mZdmBUAB+nn0vUYmIfOkq8YaZZPsDCCpNvWl
 cA7a6nVj3iaQWNUTwAcPBxzI+rPpPz2sJw4nP7W4OyQ+gz9XZfT52h0FlDZHh2IMW1Ku dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3urvmd82xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Dec 2023 17:32:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B3F0xc7034400;
	Sun, 3 Dec 2023 17:32:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu14t62j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Dec 2023 17:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLoCcwH4GVP4EClqBa5BQeYw3CNeadYuS62NvQGCtBPqFLYzcRgDmwgb7/FIAzyOWOF0KK8PWo+qfobPH2cwhkWAkFVAx19wFqBERI+xc5EDewAsM5dfotG4IWOw7EWcRWkqSwz696X3lNmzhpaUqURchZEGUjHdS3px3waKvuJCuIgDBJUQRA6qiTUHQpO0Qufx79srErixG0RrBe3Dxe9y84CfxUiOhQFZF1tYPQlToJEuw2wdm3LOBBLyITQiz10mxRJaeIaIQsPj0sknzIAQMmaVlMKdJ8+uXyB0KQkysHbyY0WmDDX4Oh+2zAlkpmth+c7Udwo7AAIZOquZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znYH7snNbK+SzcTrUI8CY1p78VVhQKtgUG6KTjNNRNU=;
 b=TrUnBKf/WVoYnbmDIkd+DcM0rPeawTx/93oAZEQf+mUmbyI+tTFCMDaEgS25J2lfsx/dMP7ymXPFOjeuoAx1CNCIbGavuo3G+YRsEkfwESeOi7XS9eIIRFvNJmuc79xsVgQZH2I3SppjtTkhhHpWLZ7QQUoFhsEcf2O7FDCq1beorVpPp3DOItXJUB59A3e/ICNamqmPj4fmH14zGT3UNyvwlK0A+2QYjdWMA+FYvph+olvHdVRxB12f6hvcCLCdhhOA57rj9D2tPjOhihmKWvGhMcSGBaQ07uRQZxE4tLKn1YuQbtNgCAMcnJt8D8lP3PMxYqThvtCUso8EZGdWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znYH7snNbK+SzcTrUI8CY1p78VVhQKtgUG6KTjNNRNU=;
 b=SN1LJ0S6dQ1LzS6Cf3OeWhVGLuF2P4q7WQazJOQlyCll+6dU7w8ImVG12EjQiM6oJyvOLLSZ9U1mfICBrYsr0b2d7uDLfk/zJBhYevtdNeUjElWqhUqJKJI5WycwXqM0ZdaFxq9Oee14AteEUYtIWInRXpZ5DNs7C2PTvLpDZCk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6480.namprd10.prod.outlook.com (2603:10b6:510:22c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 17:32:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.033; Sun, 3 Dec 2023
 17:32:21 +0000
Date: Sun, 3 Dec 2023 12:32:17 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: chenxiaosongemail@foxmail.com
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenxiaosong@kylinos.cn, liuzhengyuan@kylinos.cn, huhai@kylinos.cn,
        liuyun01@kylinos.cn
Subject: Re: [PATCH] NFSv4, NFSD: move enum nfs_cb_opnum4 to
 include/linux/nfs4.h
Message-ID: <ZWy7ob2HhNRX7Z1b@tissot.1015granger.net>
References: <tencent_03EDD0CAFBF93A9667CFCA1B68EDB4C4A109@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_03EDD0CAFBF93A9667CFCA1B68EDB4C4A109@qq.com>
X-ClientProxiedBy: CH0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:610:b3::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 434b12ae-1d73-44a1-dada-08dbf425cdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Dbk3IjO1n7NBw3t675L1ryKG9b72a2/3rN3OMFBs5v7MGXAaqPYR9R1FDrJ8Mwsb/C4C5givxigE9FMyVWhXYjGpR3QxAVZL/hVPKFFjQTjBNZUeIwmYpVx9u5T9Sn1Ns4RQtOdDOJmIieL1Q4blI6+zVu8MI69xjlDEctzBvENuDc3p33Irrk7ncDYXSQ7sRwijg5mdjGrIxcpcys5CPyBHDk7VoE6Xj20sMIgqkgY5sJ/KPvWA5BtP7m3izrxDiJS8lpSy+uR8qyhi6kOXUilLwUXBSTP2cwzr138ngWVVGa7B9C67gh7RsTv+BdYyZ91z+/+spUOp2DUsI8U9cGiR1OslWkqNvbyhWCZx+vCZ9pokn4JVoU+5sMg0PMUHbuBQgOOxxCvxv08CHKy3t3PQCg3EOf1TSFtS57+yUqIEBp8H92Y1/DqBpe+tSPa/DKDZ2OlVH8UkQ1aB9RYruW6UaDf9rO7woPlYiydD1gNPqHaSe0g6A9Szwx3a9/YnoYanjP+huWn++GCvTfX2/OLBXBB2yzGr0ECa2FBasfh8wzxu3JgB5op8L9baO1nd4mYQaQWhw2HQXWjYo3K2rs7OJnhqlZLWfxYVaPRxQ5XOIVlCqdyEt5y3JbeajIMK
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(26005)(66946007)(66556008)(66476007)(6916009)(316002)(6506007)(6512007)(9686003)(83380400001)(41300700001)(2906002)(478600001)(6486002)(6666004)(7416002)(4326008)(8936002)(8676002)(5660300002)(86362001)(44832011)(48020200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GNfAFjJXzjoW8yGHYXa6IrLjFYhi1GkaImlko+rd5EZ2PDqZ2wbM3yqRsdbD?=
 =?us-ascii?Q?BSiYmFd+LdsZkDbpbVbVhJX6iqRpYK4OuAswqM/hax3gORkrz1U8efnvBhda?=
 =?us-ascii?Q?sMeKBFLadBf7FQz3zSQzIpXAtQyoIVNpZ/p4irQIsDCpEBsKgpj/sB18RAuq?=
 =?us-ascii?Q?mtKAa9Hk5kTkk9WnBQkvX/ifbdp/QMIay4XMVBIKs/aCkj/fNkKIp5YELCTb?=
 =?us-ascii?Q?0Ibck/E9dJw+wueozDS+Z9cB3Fp7Sm7VMK3zfGZNaiotOOt5qSJ/gHQSFpAb?=
 =?us-ascii?Q?n14yOYyPgv7M6KqTEK+vB4L2PtednpjcSd69yO42XsHIqLuDdoyRCEsLlj2N?=
 =?us-ascii?Q?JZg8kMBF6uAWfy7LBWEY08lvI9nbheu9KUQH/HKNSPDTglNYdpMf3a1LcQWx?=
 =?us-ascii?Q?lUfZtF4YBtIsFseelXKneP8XUVEXplfCE2KaqYn3bFcwzhOS/WMNaLN2kk+U?=
 =?us-ascii?Q?Wear2TIPdb/WbBBTFKgUuiiMCVQwyJqGmPXAHSAcZcneuItr4sw/v/hG0jIg?=
 =?us-ascii?Q?NkKcwysgvSKUEJvONsJdO9+5nFmOzm2kkuxvfHnfZt3IMyAUDfl7G3nfjbvH?=
 =?us-ascii?Q?RfhtwU0o8Za9M03A+dLwj2JrOJSq/G9t95NHqpBXjlLrzYMFwzWqUyyHOw1a?=
 =?us-ascii?Q?mZh4Fle+glf7Uivpa8dgCByEHrCaKraXX6FYxSJxZVWSyKALXQJMByY3X6k1?=
 =?us-ascii?Q?KoZstigO/M2XPvdCKhxjhpHsXdry9K6CUWvEeHEZziPWDnoYel68VX5FORij?=
 =?us-ascii?Q?xj2sKB94VdWxN6/DarJIgmkr5WwaiA7jLVhduiR7UjpxqjKoHHXeB/GSOyY7?=
 =?us-ascii?Q?nUHvHz1K3r4XsfF4o7SkihmimjeneGDZAHHAhnUbWniI0JyXnkpLoP+3p+/m?=
 =?us-ascii?Q?3d+Th+y50sD2QdC4mPgp2WQqrTadHJhMCucQ4JXlOViVv7kDDYYK14Z08zcw?=
 =?us-ascii?Q?/fbCihaoWKDBFM+E27XHn4fuLYDeFGyNFl0IdYIIZ+XbpYNgcYt37dPor4gX?=
 =?us-ascii?Q?5QOCPDOhB1dIRTByBKp5AtWqa49KuFHk5IBVfRH+KeB0siwM8EXMtLdCvGPd?=
 =?us-ascii?Q?7D2Hu9pWc99hlsCxnwtVWCO0VfH62nkjY7aTAxgNZl1Yf134TbF3O5D7ZVYB?=
 =?us-ascii?Q?amnDbXYZwSXmBUnhPUQLHBk75EVQhMtdf/8wltr4oj8IY8DqP/xjRSxfxGy2?=
 =?us-ascii?Q?S4pck4rkdBS1NrCjlUQ8Z7xqaE01yMfBavbrEJvRWVsAmnY3fxjvL+QKtpya?=
 =?us-ascii?Q?/yI8LB5WwF10vkNR5Yr5jSwSexlT0J+IBnbH9JBp6sJvcI8eZaIEfKawSKHt?=
 =?us-ascii?Q?LH/lfzRC3QN3IawxKustgjMEpT9EsaqHEdyNWrXnjbSqBO8UG5aIVYKv/UVA?=
 =?us-ascii?Q?ut3DGtrTOO7Z7P2gg8/l0pAdyHSAu9OzD8pVoCoBPq8UJXzmh0jGC9CgMkXJ?=
 =?us-ascii?Q?TuVcFyDf9fIjws8OHD9skIAC3g2i5yDUZVYRkb2CHfKjtc6MWCtGfqUWGdSj?=
 =?us-ascii?Q?dbO1EnntexR2iXkP8rJNjdu37GIXU8jKuX2PyivA/2RiGjn0DorPDSuPSpbJ?=
 =?us-ascii?Q?NF4NwdkAGhbt/nKNgvDgxwBT+O3X736M/tn6lCpu2lpJFaefSeQf0rvmaSHz?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?wLZKEf/LEMMsOOBM9P178z/Hq24Cd89rxh/Ifi5X2g7kHPL0QAASJvlCeFCf?=
 =?us-ascii?Q?or547dlnGoqT5a450LiyyBvJoCzHVRR5loPsxcEVxGvO1Qhk+h5EoK5+Ow0u?=
 =?us-ascii?Q?GK8+wgjQOzagLswkSwO1Qms5jxw4R4gv+q17wzRX8zTOf1lkVEWvj7x6iow7?=
 =?us-ascii?Q?bCZfugR8ZtjmX2B94yNRDaaFoJ/3KRUguaoxzrMzZAudPyjxQAx2YKVQh9Xu?=
 =?us-ascii?Q?NPtMPBNIneKmii04+/KTi8yuZJTSJ6tVfMrU7+/Kg5J1Zw/KUMk3llcBEXUF?=
 =?us-ascii?Q?Fd92lGD+VdvuA0mp8XMrqEDqZmaLUCot8jEmazqzLOXTcdLbhC0sTPiRjHVn?=
 =?us-ascii?Q?BZamQPE6jB+ltsToT4zdJ3zEoXiGc2mGHFQFomxmummRIE8wqJxCkT1z//ZI?=
 =?us-ascii?Q?lw/6LQPaC91FNTHXwjRKgBCPvLTYAdXsolnW8gf0Dco85wwHdz5Uo4NB2gr/?=
 =?us-ascii?Q?t3iVok48ZYQySElnmGm6gRzczbHOKGVsQPikPj23D1B386pgG3O/TqYNRATh?=
 =?us-ascii?Q?73V9zXA9ljq48yFJpPbRaFPSEKduZpd4s/0WiMAfWGPayeTYwo+YlNonBs4A?=
 =?us-ascii?Q?waOVOVO3Hk6g0SuoweVM5Y2vxuUctJfcvHtIJZaoFbytimQUsGl8tSoam2RF?=
 =?us-ascii?Q?CU9y8sjeIM7tU8CDItD4O1/xv0VuUoxIe/PbQ7ZRpbc3cxlIi/hnzOtWvXNL?=
 =?us-ascii?Q?B3k8TaBYrCRpNoTpfX10rEQphnTXfdWnzmYJXEexCwgeEIN1bIB5jZSW5czd?=
 =?us-ascii?Q?Euevlff+et/94s52i0RADTAtrwRrxRiuGFb4dHrSrqlCGVzkfIuLgAD05GhL?=
 =?us-ascii?Q?01S9fK7ebxjwycZ9BbCouFdnK/rJIwV1/FJf8XDlzenAq85ss5ZQh+XrIA4H?=
 =?us-ascii?Q?14y7uuhuRPTu/M52aAsejS6NU+KGlXYakF0fzVxxbyNDxTYIMrEf2U+UhZij?=
 =?us-ascii?Q?NnPDo9KjRZVaixg72b/JL49lZZ6bTnACvdodqMtKttw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434b12ae-1d73-44a1-dada-08dbf425cdac
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 17:32:20.5976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDX0udI3AhKEo32kJaBGgCFeces/Tr/MoR3vzq/Kq8TNAmL5gIqjA6PpWpHvUJX1l0JqH4JTwKuFLh9THrj2nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-03_15,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=867 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312030138
X-Proofpoint-ORIG-GUID: QSMAtLXo3fFRsVfhxpXDb1HsYUThUuhZ
X-Proofpoint-GUID: QSMAtLXo3fFRsVfhxpXDb1HsYUThUuhZ

On Sat, Dec 02, 2023 at 09:07:25PM +0000, chenxiaosongemail@foxmail.com wrote:
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> 
> Callback operations enum is defined in client and server, move it to
> common header file.
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>

LGTM.

I can take this through the nfsd-next tree if I get an Acked-by:
from the NFS client maintainers. If they would like to take this
through the NFS client tree, let me know, and I will send my
Acked-by.


> ---
>  fs/nfs/callback.h      | 19 -------------------
>  fs/nfsd/nfs4callback.c | 26 +-------------------------
>  include/linux/nfs4.h   | 22 ++++++++++++++++++++++
>  3 files changed, 23 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
> index ccd4f245cae2..0279b78b5fc9 100644
> --- a/fs/nfs/callback.h
> +++ b/fs/nfs/callback.h
> @@ -19,25 +19,6 @@ enum nfs4_callback_procnum {
>  	CB_COMPOUND = 1,
>  };
>  
> -enum nfs4_callback_opnum {
> -	OP_CB_GETATTR = 3,
> -	OP_CB_RECALL  = 4,
> -/* Callback operations new to NFSv4.1 */
> -	OP_CB_LAYOUTRECALL  = 5,
> -	OP_CB_NOTIFY        = 6,
> -	OP_CB_PUSH_DELEG    = 7,
> -	OP_CB_RECALL_ANY    = 8,
> -	OP_CB_RECALLABLE_OBJ_AVAIL = 9,
> -	OP_CB_RECALL_SLOT   = 10,
> -	OP_CB_SEQUENCE      = 11,
> -	OP_CB_WANTS_CANCELLED = 12,
> -	OP_CB_NOTIFY_LOCK   = 13,
> -	OP_CB_NOTIFY_DEVICEID = 14,
> -/* Callback operations new to NFSv4.2 */
> -	OP_CB_OFFLOAD = 15,
> -	OP_CB_ILLEGAL = 10044,
> -};
> -
>  struct nfs4_slot;
>  struct cb_process_state {
>  	__be32			drc_status;
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 92bc109dabe6..30aa241038eb 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -31,6 +31,7 @@
>   *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  
> +#include <linux/nfs4.h>
>  #include <linux/sunrpc/clnt.h>
>  #include <linux/sunrpc/xprt.h>
>  #include <linux/sunrpc/svc_xprt.h>
> @@ -101,31 +102,6 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
>  	return 0;
>  }
>  
> -/*
> - *	nfs_cb_opnum4
> - *
> - *	enum nfs_cb_opnum4 {
> - *		OP_CB_GETATTR		= 3,
> - *		  ...
> - *	};
> - */
> -enum nfs_cb_opnum4 {
> -	OP_CB_GETATTR			= 3,
> -	OP_CB_RECALL			= 4,
> -	OP_CB_LAYOUTRECALL		= 5,
> -	OP_CB_NOTIFY			= 6,
> -	OP_CB_PUSH_DELEG		= 7,
> -	OP_CB_RECALL_ANY		= 8,
> -	OP_CB_RECALLABLE_OBJ_AVAIL	= 9,
> -	OP_CB_RECALL_SLOT		= 10,
> -	OP_CB_SEQUENCE			= 11,
> -	OP_CB_WANTS_CANCELLED		= 12,
> -	OP_CB_NOTIFY_LOCK		= 13,
> -	OP_CB_NOTIFY_DEVICEID		= 14,
> -	OP_CB_OFFLOAD			= 15,
> -	OP_CB_ILLEGAL			= 10044
> -};
> -
>  static void encode_nfs_cb_opnum4(struct xdr_stream *xdr, enum nfs_cb_opnum4 op)
>  {
>  	__be32 *p;
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index c11c4db34639..ef8d2d618d5b 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -869,4 +869,26 @@ enum {
>  	RCA4_TYPE_MASK_OTHER_LAYOUT_MAX	= 15,
>  };
>  
> +enum nfs_cb_opnum4 {
> +	OP_CB_GETATTR = 3,
> +	OP_CB_RECALL  = 4,
> +
> +	/* Callback operations new to NFSv4.1 */
> +	OP_CB_LAYOUTRECALL  = 5,
> +	OP_CB_NOTIFY        = 6,
> +	OP_CB_PUSH_DELEG    = 7,
> +	OP_CB_RECALL_ANY    = 8,
> +	OP_CB_RECALLABLE_OBJ_AVAIL = 9,
> +	OP_CB_RECALL_SLOT   = 10,
> +	OP_CB_SEQUENCE      = 11,
> +	OP_CB_WANTS_CANCELLED = 12,
> +	OP_CB_NOTIFY_LOCK   = 13,
> +	OP_CB_NOTIFY_DEVICEID = 14,
> +
> +	/* Callback operations new to NFSv4.2 */
> +	OP_CB_OFFLOAD = 15,
> +
> +	OP_CB_ILLEGAL = 10044,
> +};
> +
>  #endif
> -- 
> 2.34.1
> 
> 

-- 
Chuck Lever

