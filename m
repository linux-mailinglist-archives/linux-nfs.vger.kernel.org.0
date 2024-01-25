Return-Path: <linux-nfs+bounces-1433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 587CE83CDCD
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D7F1F235DE
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED37135A5E;
	Thu, 25 Jan 2024 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DsZvRrXt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B0YtcaYB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998BA60271
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216015; cv=fail; b=V5eprDyjTCej6M8QrruLrLLyg5kCRIpyFWXXPaUkKw5PX2gcHrvkMzGOf8QAikwLtmrTtb58RiOPI6SGXBK4QTe8etw2yiDQKrUs539Gf/xqsm2+SetNa16stnrmzNAZhWPIGOZC/p6TNN5uJbNvi03Ve8IYFz2aEk8y2xdmHrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216015; c=relaxed/simple;
	bh=QUZgk2MWL9BMjEH3pnNGQCYY0HbnyWhTHPdz1nb1RKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LGdq6PO0ZHxccU2ZtcdSZHeP9aGae3oi49QlqAa13e7yTZEqU5tpT/Z7nOVWBVzOYnWLdDlX2fR6T/AaSpR7HYe16pOTT1cPDFAUkpWOXeng/30Y7/4gGjk+Un+Ui0bIwqLG9+8WJT4H9hhYvwB0XSWA7tjjIv3FVZecdj2wSQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DsZvRrXt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B0YtcaYB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PK3vOP004493;
	Thu, 25 Jan 2024 20:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=uGYUReQIkIwmIBjdHj78Lu+6TQJSsf3ExptcC6jrSF0=;
 b=DsZvRrXtt+H7Cc4OgdIgZ7RvaEEooNubdjaLJ2TmrhOlah5H8PcWkpoT1+d0q6TlUD8W
 R9ecFNk9+0Qt8+LoQtCWxIkoRJlcAW3XsdcjbWIaKQF7SM+UW8b2mEclYW8AinE2h2jj
 l7FyiPoJN1rSwuybUQtQtygeRxTN426XkCiXzThXzvVVO4VxxYXU9tPIfghbbhOkHOKC
 C64+k0qg+DTqTY9eK3t1J8hGYUGdZyewouAIc7z0d043W8eZE7ZfpAk+knUrFvCF2Vgc
 fGGxaqOq4nhPp+ooEM8/mN01ydQkT6QN9re908enycUEzpxwhcYEVf1e2pzmW5qpMvG3 xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vutwx0uah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 20:53:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PJRN3p029423;
	Thu, 25 Jan 2024 20:53:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33xard1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 20:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrokCwe0cGNuPNcExyt9FajwvJ/6cJDe1BgTsDWiHJttTipPWwKndMGN5N8stofRLJviHffDjny/F337cKKCVgYDJbh5DyXe4Jc4xWB+m6YugUtdUzE1A7gJgwO+sIB6rGtFjd0kcm9uDewqNUvywQgKbwM7CQYi2c12+C6aKFuoUW2FWHnOphA605HnxDazSCWU/2Rt0T2cX5si/YKZW4QH7w5Wp/UXGXkjzX+XYTKXIoBxkUda3sODPdibnoW3KVAfhUAlwsJTKRgXbwA9zW0j9wwjkTDCSkwMTrT65oX+hB2i5QXzItcM5GHDZMyEfHW8ZkzeNjkBIvACXzgcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGYUReQIkIwmIBjdHj78Lu+6TQJSsf3ExptcC6jrSF0=;
 b=J5wa2zBIIzYOvqQhc41HL4VWvt8VD46dES/6LH52PVSjbBPpworSfNbjdokpY5ZaYOke4o3jRrsDic8v1JUyYP3w2BraLVIfwQK4zCtpXR8p5dqmOzrn9EaVPP/ojzT27BDGFLPA1Jj9qtqFD+3QjOHhrZXzDC6jf4yGJ+T2fdlAxPrROhdAIeS2Y7LayyQImEJXu3VsXsfxocEzTECbPEtiQgiP8+xfY2Uw0iYm5sUNT94M1BPE1Jh6rjHpJbrmIGXArzMcaSkwKbRUuknJPOexQIyw8U2++SzYPazCeRfEV2LKMG9rwjv2TdIjprePA3dNFIXRDLJppYnru9G1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGYUReQIkIwmIBjdHj78Lu+6TQJSsf3ExptcC6jrSF0=;
 b=B0YtcaYB8Pb1Tewun5HhlSCXN2AeOq4/5yAfsjb/+Nv0QLKiplrc9Vkmk6SZqFnaYmPO70jfKi/K59I2w8YHJAtR9WaCTI+V5qtzBxY78U8sh1q34ovp5m1crb9WyNs5utujcRvTUFfebeWG1JcfiCu5cGY2jSvM3yHbB5MZ0PE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 20:53:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 20:53:26 +0000
Date: Thu, 25 Jan 2024 15:53:24 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-nfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 05/13] sunrpc: add a struct rpc_stats arg to
 rpc_create_args
Message-ID: <ZbLKRC1GkiKUkK+L@tissot.1015granger.net>
References: <cover.1706212207.git.josef@toxicpanda.com>
 <4cc2a7aca55ff56ac3ced32aafa861f57f59db02.1706212208.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc2a7aca55ff56ac3ced32aafa861f57f59db02.1706212208.git.josef@toxicpanda.com>
X-ClientProxiedBy: CH2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:610:20::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c81b724-73e6-4a88-6f64-08dc1de7ad9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	24n8E85om/vWXVa4sscZU4jt12vbYX2G4TZaxzlr0N1j9Fha5fLaecQUDRDoNCwS276tCUkRwX5dWzcWbSBktYIg8WDrYPILNFjr3AWm/Wrj0fPjbrTIkb6KBhxdLszvUZFLTRUzV6OCiDOtKRy6U4/EnXW/F3cd0u0hvGXuN0xL9oOEmRnUZDT7mETKPeUFyvXI1FR2o5r7oVRh8P8lgMyyyTW7sgCz9gIcO4jkJD3CKCFi2DTs9jdEGGaqDBticxPbKSf648y+jQx2lZtBkP71XhJvkI1NYzBZbGAyvVIhOKtoHOIdYsxM112vBQlTK8eqV079bkaGaj8QhXF1hAtc/HehJPwpQaEw95UfxPSktdCSuGOfY9PtNgz1c36/+Cly8+dVxUO42y4uaJYSN3wJrmCeYmBz8NoX1vt/U6K60jnISt8AQOK4PTowpfuD6wvMinQr3wbFy+xU6MDktRHkWB3CIsTSJdgGtk73BRsFZ/nK9TBU5Tn0H7evE+t9APJke2Bm3EJ2cpZxfFxo4tfv2Tk33G6URwwK5/QEdPYfDMwzOKEtO2bDrUGZMVS43fsgJ8JWYAQ7tAf3O2RUoBRK6QwVsrYIxeCUPu7ME1A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6486002)(38100700002)(2906002)(41300700001)(86362001)(6916009)(66556008)(66476007)(316002)(6506007)(66946007)(478600001)(9686003)(6512007)(5660300002)(4326008)(44832011)(8936002)(8676002)(83380400001)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KfqvBDWa4p1sLYGbA/LzTfdAMXYaRtIYSctaXn3L944m2hxMaUAhVSaEL+Xo?=
 =?us-ascii?Q?9/K8an0NVmVAb13MWI0UKs+Afy4nsw23GhfFUoJNH5H/bSrRV6Ij6S58kADt?=
 =?us-ascii?Q?Xb+9EJVNIEg04lRZGwrMOUPbyaqW1UnNz4HPf5cUHmrFkHdRwipsYEGmyd49?=
 =?us-ascii?Q?b7F5WR8MSBE9F99jeqO2qu1Ymep/r2Bq6+bc4issGpQRvDUqz1bdfQsmkHXR?=
 =?us-ascii?Q?C9rCL8w4xzKZHkvYBx6Cfx/OAbCAGAz3u8v75ZGYfJ1Leeyg/nwMUCPne8vz?=
 =?us-ascii?Q?58fZkGt4pkkrhBxGJx27+MEsHGWPWcHDnDYcDwKtTViPygdmtssslmDZwlSn?=
 =?us-ascii?Q?6mqBw7Y6t/ZFeuiM3F1bN9jUWz+VPhTr/c2xYBgJoo2W7uQFXEqTE7aLDfrx?=
 =?us-ascii?Q?DIR2crloaJZloskACAzXynO5ZfhM4bnUbkTrP475j6XkxmAUHuOTd3hnfzcU?=
 =?us-ascii?Q?L2nESKhOZiw3epo9M//ZKc34WBfcw3vSF3ewDFY7VgNO2fNpjK6wKmVpC8Wb?=
 =?us-ascii?Q?0qn7qD5Fq1Rt4tVkatCdHnZy7xd3wIuIggYf3WEQxq4QOIRu6NVAokDZMwSL?=
 =?us-ascii?Q?1SDAnXUO9gdSJwip4TiJu4S6BNyWWUFvZ4d204YOPR8OW39m4jpsxOSAIeMK?=
 =?us-ascii?Q?sAdWVOgQr1CRr/C0Q4qIv+whvZJOXl3HHXkwFL7Kzx+YC9YGFglh4XB2bEjM?=
 =?us-ascii?Q?ZH1mZAApP+0dkOUYxvJSTIv02MY1aDGIwzMYKQDA+SuuLGs4+d0ptYBQYBuD?=
 =?us-ascii?Q?d+8Rd9y8xgmCs9thjaV6F2eKQyQziTxYYeK/DqNAzJkWNyv6ZoXSog+7qYvc?=
 =?us-ascii?Q?mMpXtqemm5HpFnNnsh1pfBmWxQKEkpQbmhpcEbm5Etj00378enf3SZ9xMgo4?=
 =?us-ascii?Q?WDUDKrFn88a35VZwtsPq6a2ld4UZUsPwKfxcGqqhlIGsFjxM5h1l9M4Vu9QE?=
 =?us-ascii?Q?z/UNGEl01mGdctiM+P4iDrXEhoo6l685SJcy8brv/XyGh/0TEwFAy+eoJ4s/?=
 =?us-ascii?Q?V7tY9pYpBhJ5gjfb97GuLWr9l6bSuGfAciq+2YqBNoxTOd1y1AVcF9sVqnXx?=
 =?us-ascii?Q?N1Yb6PSV+4PoSw7t6qsd10RW66BrNBgn4hkaqYUdYYez+ZtJ96Wh9WawYY0A?=
 =?us-ascii?Q?jsY9QnkQAC+vkO7l9j949eaDpDxAFMX6p3FLeCKPdmo+D+1WiWfk9+55ckdm?=
 =?us-ascii?Q?iLhh5KMY71iYcOvwkQ91LgWW7bYMA3DGaubWdMfpNwSOM5f8+ubpuTRwmgoV?=
 =?us-ascii?Q?zAAK0r4FeDotZ+zFNkdv03RhlfsKp9Ncd2gPOkpAhH9Kqa9f88A/rApJg04e?=
 =?us-ascii?Q?qY8+QcKin+NxR1pwZM2ehxPrtbLyiQcTuDGVni1M5YIonfiqvHvr1dtxUuI1?=
 =?us-ascii?Q?ig6zCWkKAmuUEx8sTOFMJVoxPrgsFhf09yspfW8hViF8+xkss97UfkzM1IEd?=
 =?us-ascii?Q?GjclNbuWqxlFI+yNp+q3XmJp558tmVVNQ/ozsEyN1rGxflG+2cVROpaYK4fH?=
 =?us-ascii?Q?D9vqHMls+cJT1h+xyKOj34J2w8CZMIa/knhJbT/br4NwJi1JhT6L37KLBnmM?=
 =?us-ascii?Q?q32D/HgNz25fuNIAJRpxbeNEl4Utu05P3unprrWiPSDUxhMrjDdqb49wps6b?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uJuyHJLYlCkfgubFL7rj5BpVShH0lNs3z8z7JWTkgiFRm88c7x1oihzOi8jUu+JfH2XihIzybgJYw+/mflwBInapyBOceauMqP3D1u0psl6zNXxo6YvmTTCdIJ51wLJc7+M5OcNPrrHFSfGIEhqBUoj0FL/cA71hIj1LtSmvHj69HnI383pDAJrUeW+Guj30H9bjBK0WbeB/ZFiUQrxHytxHz+6do8bvR7nFIKUuYHCvFpks2SWFU4eOvGWXGVwZPOYJqhNREOrKDbN9XWY3ZufEZhBB4N+CH9Pa4NW6b4XvLcRO91nQplV0L5AB6HLKj5tEVMfJ6X2d0r+tLJfSO/feE7lmJQlKWjJhrLJ1WnFXTfJRsYtTFfuuyGFyXWXMObSsqcZV99zjfU9NC6XRo4sLWHK5Ci7oDQhP81IBYwElMPWBoAA/MeGdEkj8CiOLwDncbwkkYBbZ+Vj8Dh4DYY/0EyxLvqndpOsTItbG8cvMYfEvS0vJp8fHBGQRr2uDrr+F32gMJnLkVc8/JVPEBlF34F94Vgmzb8aFYrP8hYOg5WniI6gsYh44ATpaKOQVe8UHICrIXic7omQsbn4P/YHBQ8dADuQ9+xUcGJ/KQ/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c81b724-73e6-4a88-6f64-08dc1de7ad9c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 20:53:26.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWHq8Bw8wICCc0/SGnaepCnlbtrUuNbdKVlmjdSNiz4CMQ/KWMO99DcZyj6gK8Zo88qFk4dtelMtlrTvRlZlsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250151
X-Proofpoint-ORIG-GUID: vMGHo4i-9HjfG8bSw9_uVXJy0-TAdZJ6
X-Proofpoint-GUID: vMGHo4i-9HjfG8bSw9_uVXJy0-TAdZJ6

On Thu, Jan 25, 2024 at 02:53:15PM -0500, Josef Bacik wrote:
> We want to be able to have our rpc stats handled in a per network
> namespace manner, so add an option to rpc_create_args to specify a
> different rpc_stats struct instead of using the one on the rpc_program.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/nfs/client.c             | 2 +-
>  include/linux/sunrpc/clnt.h | 1 +
>  net/sunrpc/clnt.c           | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)

I know it isn't obvious to an outside observer, but the
maintainership of the NFS server and client are separate.

NFS client patches go To: Trond and Anna, Cc: linux-nfs

NFS server patches go To: Jeff and Chuck, Cc: linux-nfs

and you can Cc: server patches on the reviewers listed in
MAINTAINERS too if you like.


> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 44eca51b2808..590be14f182f 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -73,7 +73,7 @@ const struct rpc_program nfs_program = {
>  	.number			= NFS_PROGRAM,
>  	.nrvers			= ARRAY_SIZE(nfs_version),
>  	.version		= nfs_version,
> -	.stats			= &nfs_rpcstat,
> +	.stats                  = &nfs_rpcstat,
>  	.pipe_dir_name		= NFS_PIPE_DIRNAME,
>  };
>  
> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> index 5e9d1469c6fa..5321585c778f 100644
> --- a/include/linux/sunrpc/clnt.h
> +++ b/include/linux/sunrpc/clnt.h
> @@ -139,6 +139,7 @@ struct rpc_create_args {
>  	const char		*servername;
>  	const char		*nodename;
>  	const struct rpc_program *program;
> +	struct rpc_stat		*stats;
>  	u32			prognumber;	/* overrides program->number */
>  	u32			version;
>  	rpc_authflavor_t	authflavor;
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index cda0935a68c9..bc8c209fc0c7 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -405,7 +405,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
>  	clnt->cl_maxproc  = version->nrprocs;
>  	clnt->cl_prog     = args->prognumber ? : program->number;
>  	clnt->cl_vers     = version->number;
> -	clnt->cl_stats    = program->stats;
> +	clnt->cl_stats    = args->stats ? : program->stats;
>  	clnt->cl_metrics  = rpc_alloc_iostats(clnt);
>  	rpc_init_pipe_dir_head(&clnt->cl_pipedir_objects);
>  	err = -ENOMEM;
> -- 
> 2.43.0
> 
> 

-- 
Chuck Lever

