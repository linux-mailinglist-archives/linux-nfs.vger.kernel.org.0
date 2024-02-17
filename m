Return-Path: <linux-nfs+bounces-2002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498AC858CF3
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 03:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A09B22740
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 02:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFF18AF6;
	Sat, 17 Feb 2024 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NqJ/+chz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MxPAZGqH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41914A85
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708136244; cv=fail; b=DPwoZa3dyGvLu2DEXmHRLz4Wo2zbqOXMiPeJh7NC5nYL5/IKT0U01kWSD2wj3zDA1R1U3fKBFpskHH9WDGc9QS1CCAS9uePA1nKT/Kh4qMC/bB1QNiJUK8AcUWcLigI2AqH3P9otDi1LyqiIzVsf6ByjuRLCOSmCnVShWS0yjb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708136244; c=relaxed/simple;
	bh=yT9RlFkC3QFSHuSwftowsUfLn4LyBqYMqFv/YqKkyaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NB9XNQFdxNTyTaRcEAgGdyO2ndn98jVXOmax70YEcNzFDvbtY7cmgB3ofnR4D1wTjqyM1Pgx0rbL1TAyXtSM3V26O1eCabjFESQ8kp6qGuJGR+lwZiSYJHAuFfcOQswghHHAyLi2BCKAdrW5DLnrzBIi3zsb8g9sFc84AaYNPug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NqJ/+chz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MxPAZGqH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41H1udgr029756;
	Sat, 17 Feb 2024 02:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=x7zjlJSG8x/TfHrNnopDPR6wiXT6xyjCNBEDVq9n//M=;
 b=NqJ/+chzTmpUX90np0T5Sd3fwd28DwC73XdZTCF3s5/XPv4+hNL6LQD35VdIFsZi+s4e
 cnfGn921C1HxRRxaKJP099Wd+FzapySHDrQRj9UyqIbWTV/DeC7d7M6p5dJ/mIII5I9o
 jGvJgR4Y9mBh+V8+cztuxrMyh+mKh3rwzDZfz5NgURFYquziPX1YpCNbZ6lNR3/97HTx
 NU17rW7dBZiIZoNSC/P98x/HpqVTfskINqGV4E4leFBjWOPH9BEJ9JJ1csxvAAddfmEC
 7oA9qkmmcbl0b/Qgmput42ojVNmASHsD9oKZNvpf8a23ILsZ3fp9C1sX9tlsTNnPP2vr bQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk3r0nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 02:17:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41H1XGWj015947;
	Sat, 17 Feb 2024 02:17:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak83gu7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 02:17:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9Nl9p4mzwIg1iorle4kiEzflRN5+T2zqMAYrpMu4vYiZ80K+e6xRgdzi/mJ8AwTrp1SHbQqbZz0iAdFBXTUgu/HPX3o2zXwzyA6BhniYHYvcAiGbHOKylSkuy9hghbjuvg+Q0UuYdWj1036L/1d4Q/rcm8+yAS9i9SfO5HYmt6S7vYHCid4wtB7txmvDSxo+jCZ3DlCg9f5i/b4ad6gVu+CO7pwX5+qZKDytq+FdzqKJsEDt3Q8FbfxkpY3IAL/8+rQVrVlVyJnfJmG+rHA4CwkskjrPRVYHE3mUEtI1EpHAh3AnvBMFmz6QMe/qL8hvqsVeLh72L16Gu/5GqeuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7zjlJSG8x/TfHrNnopDPR6wiXT6xyjCNBEDVq9n//M=;
 b=Eqf28b6rWiH7z6Otvmq4yF1O5CD6KW6b23Opl80TIhvgELfRM0shoULFyynlfpdkZ+aOQIwTmkFlwSh9ts2uyIe7sHWF7wiaCEOAGCwzccDu30AcJmEyOIVmlIEiqtSfAw5wCdRyc4l3Oo9UKTWCA9k2o1XlB+eTkDwP4giso2O36vW0Q0emE6PCKo3rogsjpoN1FctDmqiHqvEkjOEsGIgBvpTyqJPgYLjyFLAck/LkgC0JJ1XdbArvwcrBOTw61NAYFDJ+FkHFy84e/J0NQDYzg06L5oO18Ql5D4Xv/rz/OmNl9i+SzFz2bfGqCcn4PSJynl6SYBJYJMWPyjLGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7zjlJSG8x/TfHrNnopDPR6wiXT6xyjCNBEDVq9n//M=;
 b=MxPAZGqHMgMMFY1MdglXvj7jDzqrmIHHpzJU6OXRNzu7eWJ5UziiWnZ8DITq0jFRYl/snVodw72/w6Q3FOyvWGKzbsLfybiKc1Gz4zZCkGWMfBMffB1hRgnh3WapeLR0k4C3pW1cNsJwupoRd+8bHxxd3py67w+OgN7CxZgsscc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4428.namprd10.prod.outlook.com (2603:10b6:806:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 02:17:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 02:17:16 +0000
Date: Fri, 16 Feb 2024 21:17:07 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: PATCH [v3 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict
 with write delegation
Message-ID: <ZdAXI1oAJx0atlch@manet.1015granger.net>
References: <1708034722-15329-1-git-send-email-dai.ngo@oracle.com>
 <CAAvCNcDDb4L2tcbBCcufFg=TLeFSrui4MHFuEeNUA+1VZyXLxQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAvCNcDDb4L2tcbBCcufFg=TLeFSrui4MHFuEeNUA+1VZyXLxQ@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:610:e6::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fdfe94a-9e20-431e-36d6-08dc2f5e8fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	w9h5dvXkgHA8FD5hh6LVsnrZALUQDp2jj5r+P6gYezP1h+GdyORS3/9+VVxcwPJpzDmcv2Tqn+TIx54Dc39TaJCbBlFGbwJCBQ/NC4uT5mS0cWerpLw5Z6ybuQdpd/stzXonNGKoQuSMpIz99EIhB4QZiOh8oEoVGA4jgvnJlPYGeQYsZ9mtFMnJY5aYKaVuA62JlwQ9cwM4Lkd/gGuoyIMBVmYvzEQ/7XVodeRE8bpF5HNahLKZ7CQhQj59iLMad+wcT5CiEdPC4TYfL8VRWHT+Kd6rh4kcxerKz/9IN0CQlWhLMKutR+CgGtujmSebZmr49aASyaEbTwAfYr1uXpclpPWNo4VnTY2rQARXRUiwdPJJFY1+Zxdpjy82/zf4bDTCFKVdKLe+m+JDxN9Kh8MSqvzIKDE7v6wq6qD7+wsHP9KeOF/xmvrcustbD2PQ+cbdKenvUASXR+3b9fmx9rmppITdUQljiWgujZSq+QrULXu2SKB+1G/TDvoSlZvc/sLat6n6YBT/oiYGpXaFE9UgTc9s1lZ9oIy47qaN/aPEXXj2iI+aBPap9yRpZ29G
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(44832011)(38100700002)(2906002)(66899024)(316002)(8676002)(6916009)(6666004)(8936002)(4326008)(6512007)(9686003)(6486002)(26005)(66556008)(66476007)(66946007)(83380400001)(6506007)(478600001)(5660300002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MCiv994MdiFzbSA12t21uxclf85WqLskLar71f8qPIFk8DqIQchf/21KepFj?=
 =?us-ascii?Q?xw4VyuLTEne5+iNmhvRaX7ujeB3T6qCdJ2ijPJRzBHEjeoX0pR3rSiVtXFJF?=
 =?us-ascii?Q?/8sU+2/0vao564iKBdUY0E4FJiVLJ1H9DL/npjRANy0gvcj/GQGgtu/+8OZz?=
 =?us-ascii?Q?SYNrZuy+Y0teL+cJy6gerEF8o3PmmjMVFRgzC8b6YvnrM4b91sZ6SfMHnEcZ?=
 =?us-ascii?Q?3fwaQrDl5nvkdhzxJOlyL2M8QcPqBeTK1NrOd1sGQXiwwwJTtzeeVG2LRjAu?=
 =?us-ascii?Q?HPzrW8VO2aEtfYMBzLCCWEf5U2h3S1hYq6J4XHshxAVlN7OyuZcxDTU9Q2ar?=
 =?us-ascii?Q?vfUuLaAfvJMmf8SA9gngD74t1mCPTblxqw2RS3xp01Lru8Xaky1ET1dtMxgF?=
 =?us-ascii?Q?FPgsdOhwif31flTfL1o85ngmq9QgFStUMv+r8Xlub6rgCU/e9SvIUb1mo457?=
 =?us-ascii?Q?DtIe5kSOMs4eEUNvIxwVQiFN3UwZRmU+Tqz8Y9NzBIs8pLcIY0QimqPK6cfM?=
 =?us-ascii?Q?YqeIsC//hOVLeiK9fVR7UH0VCfRX0cQz8ccOunf7oKZtgJJs4ljjcKeqYnF2?=
 =?us-ascii?Q?DN5XJs8za/H7r59KeBKd3gnXUK0FygFjbFFJlORMOMXMW0RAnNyTDgLbljax?=
 =?us-ascii?Q?W3CAgAkp8pZCEoxxvoL3dFr0fZkA8sK7t6xB1y0UxuVhJIq/7Nlp4x26aNSe?=
 =?us-ascii?Q?f2S/GHtngstG6yPcWRjGBe5Hug9ZBA0H5fY0fJ9ZshnlVGTjVYQNAGb1kQMx?=
 =?us-ascii?Q?xK0lOaU67xtPs78n7AWiwiHnk8rYZ3Tq4Mhe8J2FFfOBrlfMBiGPmje14RDz?=
 =?us-ascii?Q?QBlQcCT27HxSWkL17Scd4IxxrLEUSLrCCRlebvi2jIduL3iG98m4ZB2Ef/C6?=
 =?us-ascii?Q?iU3W5CT/wrs696d8DF72ynfLuCH/m2XB9src9pI9lbmMD3T4YQQ+DnfmmGdS?=
 =?us-ascii?Q?v+CM+7N3f/1fBOVnsWV5Z4Iw6pXBDla1JWQ9/XR/MoXx21fADqzDSOJlEnma?=
 =?us-ascii?Q?MWq75L0kSmEDWJILCHzwZLZOKRMZaNji4GLLKm20SZt9exdfmL4NKZJraTPD?=
 =?us-ascii?Q?ijqQnvBqY+Nw/2ZQif4t3bGIV1tBClpybykZf4dl4E+65aE+1gi+6QnuJxxo?=
 =?us-ascii?Q?WcwnQAedcZWLvrDjmSKLd8iTbTwEwD3UtzO458dRiCfT0Xq4weB3tStsZW2Q?=
 =?us-ascii?Q?17uIjKioFMOYL/m0EU7bYvltXz5Vl7oIhdxsibop4vmPNouhwwKHzN+w74G6?=
 =?us-ascii?Q?ys/XyMqXfI8atF9Q4Rpm615DWWV0p8GOvUoQTTu3YwLYBWAPJwckimtutOHO?=
 =?us-ascii?Q?mUZkiaDnyQPyfzNCxeAPiLL/BxcpWd5mPgV/KK0Us/gAZC0HbLmM956Qga6n?=
 =?us-ascii?Q?94FGpxSkRgwvdJrnMiyjxM5aLkWAzEUtRIUBDRhgBvLDwuEUZe7ZWHJ+nDvj?=
 =?us-ascii?Q?nXIQoplg/5eevypFMwLGbaAnk/lNkULKPmxab7ldo66fc9Z2wnwEUil+ZKpV?=
 =?us-ascii?Q?k07LLxoXSay3ItlVTQjfrQVxid19q0Dcqj7dW3uaXzHbDzmwnlPkjQPNqJjf?=
 =?us-ascii?Q?80x3tSjhEpgSSBUvJo+KE76qgLLRVD6x128+ekhTnSeFFtlJlJASE8A8xCYu?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	b3CDjSJya0dLstw/fcSQeWNu93pSy5HsIEKuH51RNW7VZmU2dRsGB0+K99lmSffSx7TasghYoWz2Ft3oHdxqbWrz+CMQbCzAXTQ5gniAgwIZd3P6PXGjwag/tidCJg8MUkd44N/7jkJ7VImDsnf0e/x6eoUIo8hNhZTrbCsFJ/XjlbFROJbgxOjsJ5JxE8JgBmWguexuIFY9U6cIDzVpAp3ty8oigxq4UIK7ap6tw3QOzxy7DZ9nJGWXwkq8SLd7GjauB4kM3fdCN2wqHnJNnYUYvrLZ1YgwwedGeBXwSlcok+MLENc4nQanLiFYxxm/CUV6Xr7gAkvrhbXUasuVc1lXs8YfTlVi33zJdphha3jFhMnwUkzLoj2YWTjWNxkTY8Cp9jvDHPJcIGxJj5E44oH6+cOPda2Xtq8XGG6FKYOFXmubh4JCngCW2MMh+f+nTN400XsK/AJVPE5iFIyYYnurwsnZEr3nyXikUOd/fPubfedpqOnsHfFEOeawu5h2Hy+6BIAkbnF759c1XuCSxW5bj0SMs4vxjDB38dJ7uNSk7pM3/WnU2yzqg1InbP6LcX35QmEs2BUWBF2gu2YTZli+JonK9+YU0aQexyfRA34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdfe94a-9e20-431e-36d6-08dc2f5e8fe0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 02:17:16.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fyuyu7JNfFah1JHdZn7SeNX0TFd0WQwttUB1Oiid2glr+hpUeK6v0ETzoR+rh5YDYjSrq/95scukDZbZCUtqXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_25,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402170014
X-Proofpoint-ORIG-GUID: nln_cTVu4UXGc_7vH9vdhFUbvEyfazm9
X-Proofpoint-GUID: nln_cTVu4UXGc_7vH9vdhFUbvEyfazm9

On Sat, Feb 17, 2024 at 12:34:45AM +0100, Dan Shelton wrote:
> On Thu, 15 Feb 2024 at 23:11, Dai Ngo <dai.ngo@oracle.com> wrote:
> >
> > Currently GETATTR conflict with a write delegation is handled by
> > recalling the delegation before replying to the GETATTR.
> >
> > This patch series add supports for CB_GETATTR callback to get the latest
> > change_info and size information of the file from the client that holds
> > the delegation to reply to the GETATTR from the second client.
> >
> > NOTE: this patch series is mostly the same as the previous patches which
> > were backed out when un unrelated problem of NFSD server hang on reboot
> > was reported.
> >
> > The only difference is the wait_on_bit() in nfsd4_deleg_getattr_conflict was
> > replaced with wait_on_bit_timeout() with 30ms timeout to avoid a potential
> > DOS attack by exhausting NFSD kernel threads with GETATTR conflicts.
> 
> I have a concern about this static and very tiny timeout.
> What will happen if the ICMPv6 latency is well over 30ms, like 660ms
> (average 250mbit/s satellite latency)?

CB_GETATTR is an optimization for write delegation. Without
CB_GETATTR, or if the client does not respond within 30ms, the
server recalls the delegation. We expect no impact on clients
that connect on a high bandwidth-latency product link.

To lengthen that timeout would require the implementation of a
mechanism for NFSD to defer requests without tying up an NFSD
thread. So for the moment, the proposed CB_GETATTR implementation
will help fast local clients but should not negatively impact
remote clients, and we cannot in good faith provide a tunable
to extend that timeout beyond a few dozen milliseconds.


> Would that not ruin delegations?

As stated above, it should not impact write delegation, and Dai can
correct me if I'm wrong, but I believe CB_GETATTR is not used if the
server has offered a read delegation. NFSD implemented only read
delegation until very recently.

IIRC, there is instrumentation in v6.6 or v6.7's NFSD to measure
how often a CB_GETATTR might have been beneficial. I can provide
more detail when I'm in front of my desktop computer.


-- 
Chuck Lever

