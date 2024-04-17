Return-Path: <linux-nfs+bounces-2876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D378A8410
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 15:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3851F22A39
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DE213DBAA;
	Wed, 17 Apr 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BA4CPtXp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i+HNjqAB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A112DD8C;
	Wed, 17 Apr 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359835; cv=fail; b=dzKmtttsXjeou7MoW9zYqNPtNru1luvjpGAO0Kt/8/fH1jiBQvPgcIxe9oHdhUbCB9TvvBZQomhIlU+gEaCEe2iQAEzxPJz+jAZjbwry9bxCVkD9KG9ckuDZ2iQ8WpYx+nvhoLs64FoJGkX0dLi8sBKLlUnUnPCVMsNF5XNIWDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359835; c=relaxed/simple;
	bh=bUWrUHHyHqmRdffWSbWeeA+g+5+A9HmQbHhtn/cUrS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qcTleztBro7svPj1Y+C6nH5yCcxstvrA2SzHGmj0X1EdvEglxo9oSAHvRrgFm8OUCtyDy31nRGKOs0OF0D+xZZywtgZulwHwGR/QNnvtMDNIPYmQd3BnQaJiW3fVasGIGTcbDnZ925jmx49uf0OGZ5996DIq2ltX48xNaoHTfZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BA4CPtXp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i+HNjqAB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H8xO6b021913;
	Wed, 17 Apr 2024 13:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=jvDIteHdK/ZwZR0kIGFysDKF+DXITpD/PVf/n1AmeGY=;
 b=BA4CPtXplDgGRgIYhA2M40jiP2cBZf7rOeEfhGrRQxLY469kq82r18zEidzkVkMqyYvD
 JKgq6WCe4HbP6WHA5zh+5dqZlGJrUUKTLyhxwbo0Ye3i7eocDXGgwlvDl7T6154z7Ind
 /QYcf/cfuYGGg6Eo91x1qs/Cu92Fmk9aZvL3XEBtnOQTb/PLDqTjPm1wG9l9fXGToTml
 ifIHqttBi0H/9DrtVPM/k7mUKWEN4J4kB1+uq1FqY2EGdKGZIpMybyI4ciENEzbFHmru
 tPwWbmEgKqMvIjf1+dzeBqfVNhkoFXLfdlFiwcNb0r5dzvtuHnXS6CXzqwoXmo5DothP uQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv7rw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 13:17:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HD5PxW004283;
	Wed, 17 Apr 2024 13:17:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggf2s4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 13:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ8rw0BahbawDInd+nPLaKiVr1w52fH3vuiNZJkxEOtA81qGL12UJB2AjyFe02PCzNj0XnyshqH8VJZMOTg2G1+qnLnQVF33lKjMmzqwjb/MLXy+3PhqKtZloLhVIHqygWcYTjPpb9p7x/Vj6weFeZTOLfSFvbZXLzkPzS3Q8lmE5azBpavddJ50uR7/6KGtUALGlykNiKIi+sAEqppY9X+XpTUIztkJnJH6TTnQLSpdaTF2orFdADlfhKl6tlCD6oQIpo56wDFR9xSRVkzccv51QBAMlb+5Sik9yO+B8pfs7OSwMldJhWnXH8UAmFa4dyvYooJYIdV3Dv4JfDtToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvDIteHdK/ZwZR0kIGFysDKF+DXITpD/PVf/n1AmeGY=;
 b=M7QTJmS7n0aXjP+SFL0lF6C9OTAyO2AKVfedkejyMlRtJH8Q8dbu1gDeMI5dx3xnnRA5Saow7PvVowykjT2JNHQR249xte9pbAlEzeySW3kyPvelYxguDcpxa4r1CDbAzFLeoEweWRlfLf4QHfzEuSD2QW6l8PxWMxbS3uXhH7MUqEiYPkC63Wa/s40AeaBfeNV08XG26OtrwZCA5UJC4icfhvgJv9SbFG9BSj4jpyftcgoGnIChAQqQA8jWNNkL9HNe7jktJScixuJSvwuIW6UMl9gfKp7YdU4S5tJM99N/OyrfsHIzIOniYNm9zxBvQlkjGOn91z96aTFIBXm0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvDIteHdK/ZwZR0kIGFysDKF+DXITpD/PVf/n1AmeGY=;
 b=i+HNjqABuYNGEfHRH88Lcfo5/ktbA2+XuDckGdM0Q79XY6DLVWN6A86k9W2+TcMAy9DiweLBVUpqmomhT/vDfkPRdEmHWas6dcxO89kPWPdOn3Ct8nAX8wWoM/uhVq0kcFnFyPzZhbc0i7dSfm1e7945p3UnLUe4p9wrpdqpMXk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7362.namprd10.prod.outlook.com (2603:10b6:8:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Wed, 17 Apr
 2024 13:17:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 13:17:01 +0000
Date: Wed, 17 Apr 2024 09:16:58 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: cel@kernel.org, stable@vger.kernel.org, linux-nfs@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] Revert 2267b2e84593bd3d61a1188e68fba06307fa9dab
Message-ID: <Zh/LyjplA5coHKqJ@tissot.1015granger.net>
References: <20240416203337.10248-1-cel@kernel.org>
 <2024041727-refueling-sensually-0566@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041727-refueling-sensually-0566@gregkh>
X-ClientProxiedBy: CH0PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:610:33::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bb22ad-8cb9-4559-b704-08dc5ee0aaa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tf4EQgZ3gLvLlizl2z1kmnEusGS2LH0r3Vj8PTG1o7MnESXDye6KP//qkrv28/DMs8owoZyfsWWnQ9ZfKatWosbGd8iEY0MHkncOzOqDoXG2IBXhCrwFm40k7q1+Pb/Lk/WXfpEm65z5CDYBE45SqoGVY2haeVJ22SGn60pgDXPq/wLQzBwwk39JFcygdyx1YnMxiT2DNS/78FC4QQW1J3jafuOdiMQAVDY4A5l/sr0yFI28muQUy90IlleJ/I20TMrNtdYB4hT40dQim2ie1WmX2X0tcMYZp7UesBzfcnrJxXrQKROYcOewgro31ubXT7/tC0SXWPqLkxZDXXmMIPJDjM2rWeOfhCSKufvfzl4R9Mt6X6L43+1gDXUDTe1zFsiBEVKfT9Wu99g9Lv6f/h2h1C9dJWfJdvfTlq8WDiQHcj0L6rAIBkVci5WqkBwRzmXPujBvtUBWnWk1Wtty46RB4zCnG/XawoykPrehMxxMjpNQwctHnG8+FNggTBYvI2vXpHwf4dtrv/8mYURkwMNcPPDykrVTbhov1DUM43zIbwtXBzIEARvMGw1HktBBl8BMtPSnT8+w8xlTueyp/H7r6hwa/ZrudNY7nGLIub/kYFekfO98HkMyknfjpIILX3TwYU+T19XQG9QhzoKEAFxRIaiTG8RVi0IZ1BH095M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GJwDm6A7FdxyQN3fyXATpbhqlQEtUeQLYh+npwFk9m0BwqbaC0KKVUXk63l7?=
 =?us-ascii?Q?EwH190+UpVAyz56kExF1E2s4PhUZJqJGxtmWeFl2kz+heBJ6p3PWf4ZfS/bJ?=
 =?us-ascii?Q?Ve27LWzMpRS/hjsHmB+Nqb+sskYayPtfnpCKPNcBe2BzswVvIJNjkjLozVdl?=
 =?us-ascii?Q?pSM2zCgxrUZQXG+LHTo3xBTkLSI4G5jeAGx5m68DJcWO2CgK61lHT4ng1XK2?=
 =?us-ascii?Q?8qrE98y0oaE54PSTAoxwHJL/HWs6onrRzwP5ByUAbu4IpuX21fzjjVH6vaar?=
 =?us-ascii?Q?Vd5WPMRPdaMHbiW5F2N2yowxACNmZvuvmNu8AoikM6nor31uQQgU5lno9mIN?=
 =?us-ascii?Q?ubhyFh5RAHnknKWfEBeKXbIpSeXGs3ToHcFh+YE/GbYN+lVblAmp9uG6+3u+?=
 =?us-ascii?Q?8sNzB16FUo9PpB4Od8Ru40kajY4i3/i3OhbML/dRNMiMV7Hr04B7fvDHMoUb?=
 =?us-ascii?Q?LD7T9WQejA2YEc2tCU02QyNuRajX/KhoGBfE7OxbRXoMYtoad7U/Z07TjQgj?=
 =?us-ascii?Q?9IOPmUmLo/TVnJVJJYFtcVdx+nN/t5c1indlyiEtZUGL9PRMWtecNosdubxI?=
 =?us-ascii?Q?OgErXmaWyEkafiCieCw5MEeP63XXKxQXeZWv0VsSZriyiBiRVTDp2ufZAUgP?=
 =?us-ascii?Q?SBJNFkZMdHTliSFKWNqfFVCcEzVBrYnuVHEZTD5rO8tcOnJd2HxlqGpS6r+9?=
 =?us-ascii?Q?In8j3zKYhkmQ5NGpvEABtLIhB6lq2LSJkyYb5dMrrCURLh0Kwq6w+ucwHFgY?=
 =?us-ascii?Q?IRcu+q4aOIlfafA8s1HpQbkLHuTEt5YFZLQP4vIQjDpKERbrStwx+j8fQTh2?=
 =?us-ascii?Q?DHpHxllt8tZ8T+t+uU069857D9G1CDk73MJJBqXNuyllUcIm1Zer12TiCl06?=
 =?us-ascii?Q?xFadGdK/cq1nJd7kLRkD5lKZDDItQZ4qAZGUlWAYa8d8oUQyLuAaEoaOPTmf?=
 =?us-ascii?Q?40YvgQY7ydItEdT+wnRxnKZxmpsyq2zME5HlDp/fJn7cjZDpI9K9dWruRFFE?=
 =?us-ascii?Q?i99uJp2h+ARPWbRtxm+C+AgANiW+F0iYkDxVodgtkyHL0nbTM9mtQ4w2LSN1?=
 =?us-ascii?Q?GWamAwMSUE777qXclxhRDsLFNvk+hLR2lm3acF+5QwBgRS44GwSdEZr+dA4V?=
 =?us-ascii?Q?t584u/7MEU3I9opa3/3WlHTbFE8oNw96KGrD7kwvIZZwWaq2xNDIUYihKRXM?=
 =?us-ascii?Q?Ja+OcQExbsDHyEQ6S0TzFa4RNdbpLU9GYmQ30sE8BxgOvf2SkoqoHXbdtSrU?=
 =?us-ascii?Q?0g6mxYeHjEi/1XrwVh1T2rUUdorTqJfkxk8DpT4T0U1a7iUKQNEq7DoKftVi?=
 =?us-ascii?Q?Y4qJOjlr8W+m6WJKaWrrH+6zilXB0wjyM88Li0YZ4CNU/E4muFZ64xrrlxre?=
 =?us-ascii?Q?B3X+YWfucAKHiVe0Fsyqa7AGQeKLqzmIf3kPwjgJKrD9aVi1P5nnUPdyGVgd?=
 =?us-ascii?Q?RC92RWtgloIgIUQOhtelP9mrZyBWohDUXJ6C90dZ8yt5LnhNAe+72/XEt9/f?=
 =?us-ascii?Q?hMpVA82HkjQ5q0wCJWSUzzrEOca5dDQV9rkYLz+jplghETJ4zA+/ZHwpzzyv?=
 =?us-ascii?Q?Fu/x+UzGHRKQ1wIQpfE/73eP6M+WzCRm1R4U6d3MXZFqEOH9F7M+rIfiCYA3?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F2kYV1I/xAG7LW0die2meUbWuWsEiCNYc6O0RNVftOaPpoSCfL+ec6lx0bHYCPZNp15jIusb3ps90V3r7cnnuUONRaaAAuFuPEWwN5mIZ5TSHitFSPcn+6sBq0VY9nZdSJBSFotYU7ngKq1b7U6tTy/9I2IGNLp0LNUl8Zl0Xmmxala2JptMxJT24e5eMx++R7Bg3/9MyQh3c0kdRTibm76HNs3r5D5l6A9sxSEQFzL6TAgOnBWzpWGGqf/OvaPfvwDKmmtmqc20q5BSnZ7plsWp98DmF/Az4Kh9ToMHz/V/QScAcv6Q/Wp05ebiNqUCCWjii4cd0M+8myRRL4BYfZaoFks/h/BlAXUJ34n3YGXwN1GfWK36k4Gytn3V2rbuLSTBp0W+IZp6R9k6/ZzM+CRhe2QXmHmH9kENkMvOD5LBzgE1BJAoxbWqmj7rK3ENRQ3iJaR0nyBUkb7HzLTxlGq75ALgnV+i899HTKNi01q2l8P3NH0iyxjMBciu4kYPnvOPxd43A5vot4Tn0gsvrqtrRC2+FscpexXjTF58x7qs1sOy2SbRhm7YkVGjpoZHQtJ+DJyQq6lJxjUn82xmvjbiIHOqhMOiYL6GlZFooQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bb22ad-8cb9-4559-b704-08dc5ee0aaa8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 13:17:00.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AI9lpqsPr8fUNvfcjayWmdgL42WdESHNEx0GXb7xNthX1QjJfTKi1dnyzNlo3ZW/FYX5BJ7EZOnLxizFVhgS2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=907 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170091
X-Proofpoint-ORIG-GUID: ced6wus50pXqyAoSad2aIubxaGWBdG63
X-Proofpoint-GUID: ced6wus50pXqyAoSad2aIubxaGWBdG63

On Wed, Apr 17, 2024 at 07:56:53AM +0200, Greg KH wrote:
> On Tue, Apr 16, 2024 at 04:33:37PM -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > ltp test fcntl17 fails on v5.15.154. This was bisected to commit
> > 2267b2e84593 ("lockd: introduce safe async lock op").
> 
> Your subject line is a big odd :(

I used the style we normally use for revert patches for Linus'
kernel. Let me know what needs to be improved.


> > Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> 
> So this is only 5.15, right?

Yes.


-- 
Chuck Lever

