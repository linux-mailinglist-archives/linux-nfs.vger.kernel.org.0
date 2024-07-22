Return-Path: <linux-nfs+bounces-5008-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB3B939069
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 16:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECC4B219F7
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E91C8CE;
	Mon, 22 Jul 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jCNVdiPu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QTMAYbTi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67C16D9D8
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657709; cv=fail; b=pCzM9iiaBK/WPeQYY+4Ej6DwlO0qJTnwijsysdFbKKzrexjQpn85U+P5jqlhbMNdNtDEeoOiIsHDEMW8Wy8iadiktqNP0aj9cGo9rvLajZLw77SDUBlEb73h5Fh/b4l2tGEA1orvf7vZzGWKh9SizBz4r7KW5vJP02VWM4Gp9ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657709; c=relaxed/simple;
	bh=TjKtwofTT8UClyDppITTPIS4Bq/texTq2ifYK+wHTIY=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=JkVJBTN2BnesMKlqKBUyVfo7ZQhU8G9mPW4hjsEjW/KX0/rwkT9+smcW2Xfsy69S9cSPDhDl2ccMqyxpfUGb4kVt1ChsDGV20Bo8j8q4QCZB/sOqpzuNwaVsYLLqYWRia9AgBJcYCchZiGl6eeJLv0YCrOa72sj0dcBZBkKpWHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jCNVdiPu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QTMAYbTi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MCTIL1016428
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 14:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=zL1FhZV7hpq5HkLSLLKbtauPr/MLDb2UMGKZzDQ5aW0=; b=
	jCNVdiPuoF1uD5mS5B++6boSBnaueqv4l+gZ+hHvzN4tHu9I+1d9TxFOYKySqdnG
	/rqwTUpoUae+ZZQbBA8QKIRn0J6tZwt0d3NbW3JqdukA/31h+RTW8e7eAT0cmt9W
	ePovmLSa4Bo8QW93IsRK4LlI1YFndrFR3E9U/2ZveD2rngXRflT/rbth9OxbefZ4
	wnCytPvOptw83We5YDtht2BlpxJC7ii8L9fdxSJv1Z+rlP7JllMi32AfzAnLGpYU
	UrtjzF5GL1qCmUDGG7h4JIRO9zX3bJtXn0oOJ1p+9Zi9xxiRZ6rxFDrFd9XtWfcg
	lYv3SosNDtfLuCOs2AQAZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg10sx9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 14:15:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MCkbZT011016
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 14:15:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29prrm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 14:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpvuxsdZOh6NhG/5GTZg6A7muaJlDqSGvutGGAGZO2Sv3dX1qiCS7dOjTjMMzYVxKrrnnWE/uCZDjy3BNwYOmOUZpewj4vcn84l0Nfo16q0JSw0ua3NKSYJLAPymNpj+FVWMf7nHJ5M5PleT1A/lK0sttl6tr2EZ5Z+BdFXg4Iysa5G/+BR/w+7WkkWjHOChnQfuOu3COp76mCFj7h84ARruN2XpVlDcTa1zbb4iN/8N2ckacLNaBv/LYGRy5uY8qb/U/qCA+M4s1n+MD6DKl7yyeatVJRhCGNBWBoUka+rrXteeJ/fjskLRMd1TvwMeXMQHd2Fv9GnOOtlcks+nMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL1FhZV7hpq5HkLSLLKbtauPr/MLDb2UMGKZzDQ5aW0=;
 b=FLDd7zr+A5HxJY/lxOO1No7c/LFOqo9+gmsDnGrXXBxfE46XaVS7Mw55G3Lyzw2OJiN4uLKIgHXYyAWJrNXkQpc5RxqU9U+hCh91kQtZNiZMr13B5Po6MwEw/45CN7cbJn//unLL0bCu+pDfMqr8dpiHFVQXaRcw8mF3WmPPv8gnhSnA23dY39LtvepQS+qRbsMzfHyKnrpbbwV/o8C/s8Q1IyMgDYgu8nPyQfIH2IGw7Z7znRaELZlFTZe/G5MKXdAwy3UinHWYziUTSmforwaUtxZN66sWjV7F7cOJU7OFEBYzxTRZnlUpklgs70EacXEeWKkaXDLildHXdi0FFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL1FhZV7hpq5HkLSLLKbtauPr/MLDb2UMGKZzDQ5aW0=;
 b=QTMAYbTisqMMv+cglrL8LCzg9vhDtXR73LvQJwRAmtDrOx2B6qPqaJFFh1WeGDf3Z+cGi3IYwgPA3rnrqrFwg6mbrQ21qtoNVIopCEek/J68DUDp3QGEPB3kPaAhdiv4oNlWCegk8oGvT/42X5A9QCO47Ijq4fuLSEKP9t2kG+w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5951.namprd10.prod.outlook.com (2603:10b6:8:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 14:15:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 14:14:59 +0000
Date: Mon, 22 Jul 2024 10:14:56 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <Zp5pYGboWIWGXcgH@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:76::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dce7e7a-eabf-4804-c9f7-08dcaa58abc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xZwFqxSwSvX9Q3KWFcgaXAkCrx7k1+LpvD+g61xBbF+180ktI5gmRJMxAIyP?=
 =?us-ascii?Q?xsDoLRmXT2r48Bz/oyZQdtigTph08jwZBLjQkEqmafNemOxonybApQQPQorJ?=
 =?us-ascii?Q?NXUmXYnGPGibNFkTsWnOx1ImyGWN9PLMNbGRoXoYq+IQwp2fWndgoIxW0fgk?=
 =?us-ascii?Q?ykqg84vp3d3XtLiWov57OylQZkou6yxd04nhvCR5QPhBdyxxMYL/ZBel4KFY?=
 =?us-ascii?Q?Y+NMx4Iy6y8lEEEkZaJnOqQkc0RqTuXs8uQ5zYA4Htnv+BE+aTr9+Ftmc5E0?=
 =?us-ascii?Q?RJ36qR0mCIIynTqEf2z7tTerhMBOxbcpVinAOHsFmIvF7SDDr/4dcj0CuNtv?=
 =?us-ascii?Q?ojjZU5Ksicqr0/djBDzd+vvJ/uhjds6ZpCSwSnbe/662xkGUpeAdgPScawOd?=
 =?us-ascii?Q?0QAjhui8zc7uNbkFxQqo7Xa/I1oof5dO9ul17VH5s/w9cbwvlqoaWgmYPJE3?=
 =?us-ascii?Q?P5TYGYndDpGntA5zIAO8oy8k74LOaEmkDtByrmxydbdS6/VOrWkoqCAvE3RG?=
 =?us-ascii?Q?N2zJya2aCGJweUneDYsZOlvXPTF5Dwfd+ERDgZJMVLI7b64DVgt213PiwtlY?=
 =?us-ascii?Q?ZWwVgOtQ+k/u3Xv6AayeC2ZTpLHZW+gzVhQ9cGJynWmBguy7mJ9YJphD/f/F?=
 =?us-ascii?Q?ho1Lm9zbwJfDouw1MK662yV1X6CBNkXO8J9td2Qg0gO9Vxmnb3Wdp/ME9miz?=
 =?us-ascii?Q?RDDGVTlQGR3bF0b3ijG18/EH0U7Xw3y/6RldLVDNzKziW077ecmdonhNxoyP?=
 =?us-ascii?Q?2BCIXLno3XkVsj+x/kraa2WAZYJs0r0c6Xsqi40sw1msrs2CJvefpiK8HtmI?=
 =?us-ascii?Q?qFKvjvl11LV7m36Rt290hXapJ7gyqDmZNylWPHtrZkqUxkLnA4ewteOT9U+i?=
 =?us-ascii?Q?UJwyjXSjavu8/hm6VXcnZW/Rdd4v/aRcf+GclxYBIDjiKXijsQmU91jSLp6L?=
 =?us-ascii?Q?GYktR3+jUoKR5D5mXbzsCWQvM+VMbL5tmjdHb5eW6hm8CArxHpqRv/RHnNU1?=
 =?us-ascii?Q?tXZdqsh1PBjPz5QZWk4bNmHKORUOouh3xdWS1L/RMwtcPS62JZGzDtB6iy7/?=
 =?us-ascii?Q?chjkAeUM8swjonQYMWKpoTKjFHFfW4iratcVGyLFZXe+z6totDh31o5h0cgb?=
 =?us-ascii?Q?Uy9rLRLyVlK+TMNnMuVsGFql1/+V++lK2LcBL4eJg/5N8ex0Ujzrumy6+5tA?=
 =?us-ascii?Q?lir88NlaNYonhiO1ab1tJhrW0mdFeQwqzfP3H9ehKIhmONk4XHDV1XURHFa4?=
 =?us-ascii?Q?vp6OkLOR84AgQR4A6UpVcN5kYqGJjRWwjFEbKirQapJ4uQy8tWAFH1ah3Rng?=
 =?us-ascii?Q?SnQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yuUyU+N8NS2QbmAVa7y+7db3EhnVzWrBxWVGe1fB0nWUxuWBClmKozz4+xJV?=
 =?us-ascii?Q?aG+lm4RU+NyinncUPdiA4kArjb4SMZNvI+FNz3erCggSGMycqHh+D5blD+Gi?=
 =?us-ascii?Q?GRK2CJAOT1XlqtNcVO3j3LgL75tma4hqPRImT/IEVoB1eclJMJgbIrGTMURA?=
 =?us-ascii?Q?OLkkVTByKRrCLmi8J/ckl3frKFNw3hEAC23wk1odeUEC8X8Xzil3gj1WqWK3?=
 =?us-ascii?Q?B3+A9r7oRWTa3paCKu91FGIssp9ftv6ox5U90W0pvQFrtGQvy8OHjRFMmxjD?=
 =?us-ascii?Q?EYBSxq8RXDEjrbhQ6ENO1Ykx1kvBKbDA6HQgmU4pzcukuZjMBXdcUAHBHPuo?=
 =?us-ascii?Q?+2ybz3koHPSx0Gz1S0WHWoqYL5pxCTuXfyyNoNgvu697xFnJBGt8QN1yhgpB?=
 =?us-ascii?Q?wPQDNkuhPzwfIJirHOMDLI077tIpsplk1SxeXBBOBbvVHnrVz2CqClREQAur?=
 =?us-ascii?Q?EMQ6AegFuM8sHPd2E1nLyWtudEae6sVZMBnZhdcoAarZcZ41gI2BAgGtZtJo?=
 =?us-ascii?Q?Oh7VrE0TaZK5QlhcTHcNAJh9JAtHjeKvdnySexsfHXBwFLAYlX5u4KBlxYEt?=
 =?us-ascii?Q?wS/q7RysxLPhu+rDElN3BbCJ9jqG8gGq6NO/PkY/jxoUJrEoF9EBMLa15Tjk?=
 =?us-ascii?Q?0bTuKNKR9wbFrCCAvS30APF3053hswWtMWTTIWwtKI033iUa9AnxR9AzsYrx?=
 =?us-ascii?Q?nDr5dEIfJ82L39HKDlWCbYKiNenIPkefPSSaeJ7Li/6U1U0IMcy++0bTozIa?=
 =?us-ascii?Q?K2fe5K8zSAeb/9ItEn/K0JcvgfYCPXJrA4+sOxK/KR7Mr3KXFuo0kphnjH4h?=
 =?us-ascii?Q?SEwuon8zjAQxzGXOGimlNg3nJzkzg7MVO/pELNLKksmJwQ/b+zgWlUiLNgCg?=
 =?us-ascii?Q?llaA4qyHNSvsx0mpYcFTENBzuckJ7jJHOnL4+1KTtEu3+XcCUBeUJei3j8GP?=
 =?us-ascii?Q?xlF8OEBwCiPQo2TTF3OQtcI6Z9hpQclSUvJ49brhDHFEOOma8aLRIs5365Vd?=
 =?us-ascii?Q?CFMu2LzmgSMw7LwAiLXdwWGEOJA4q8GdKjqNn1b85XUSlGvt3BMkP2uxZd7K?=
 =?us-ascii?Q?V7SSdJVLdamUkmv6OQRRaS9Gppp/a7gWauM45xr3Sr73xvZF/Mf8RbS+69o2?=
 =?us-ascii?Q?vW7LC3cM0FFh5OEjGuD6xc7KAxhY/S8YgyKrp/mEOS9wppQLSnDpAxl47Ao6?=
 =?us-ascii?Q?qA1EJu77+gek4nSS0OshKexrCu5hcTXqyzGbp2fmQvHQVYuCZJvAkX/YbgfI?=
 =?us-ascii?Q?P8VJYZcDsNqbyrFZ6VCIzeSARIQGdL9EtE3Y2WQmFIw8SHh+EXmpkpF72v3Q?=
 =?us-ascii?Q?LrZPddjVl8IZdTQa4lywMS0AnDSlkXont5BGWplNpR4Yem/IpNcW/82ELk69?=
 =?us-ascii?Q?c+GSbMA1Qksg3jFGMgi6TvXw/9t67aGsPp21q8Dg6aqCSaOOoR1jQ7dqskK1?=
 =?us-ascii?Q?gx4Q1nb6aBG7BMyaaLvjDPeuZZG2I5S1Mb2+xCN6R4soS788TNRNsLQ99uKa?=
 =?us-ascii?Q?UuYYFdLFLnomHWV4rKN7nPHu+UbWAn+AGu7lwlavbn4Q7HLAHLloXcVXnvD7?=
 =?us-ascii?Q?UuchOmKGL3BepVW9iXTB+z9l1ITelNKYG0TA8zEl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z/NzNtEmvfl9uw2PZZHNuCiw3ATowdSWgmjo726SRMjfQlBdOsVhF1CeRfo0MzZ5fXx+D5g+IsKMaVHoG4S/gTpX4tBZ4zBHTj69cMoZuGTqBRTfCsnPHI6axx6AYs8EjE9febAcH67ovs1bNFslMzPoEMvjTcgcwtR9xn9EIDV1vlP0b98lLL1qOcfnyCX51iIQFw4xcvexnu8Fq08BIBHtFW/PW8ypLIU70R7shdaEyLvJVR2Ug7P2cftxfJpzHoq3NP3FciVW1eAD8D/ZqBA1Uvx0F/dKh6+Z3WBirwgvAHiptRS/tCxfG2ANSrQpJx6Tqzt3dM0K4vU0CktfRkzK2efNEgv9n2rypmlHiF2gC8fK7fwRb37ojd4oMsRiWYC/brJPi/QUS3W4ZmNLcmK58x+RSUZE1pSsW9o0Tt9eXJA69hs5e44yaW0GoSMDbJoI2y7sFd+zbisZd4TaLUrNdAHcYg2n1nWsoSSoXB0IhZr4kCaMUzvdFzxTlRP+lYhVAkOyzzqbBbA9ocIYWeqbzQhvq2qRaRlKfILHnULb1vU3pU7fzkXdIyQOvvBpzgLjrU4Ot4OrKNbTCjTJRTOOhMOC5jlsMhxTvB7HfhA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dce7e7a-eabf-4804-c9f7-08dcaa58abc0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:14:59.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeyI/aBliJl+fc6EVIvkC5XRmZpJf+GIc/ImBK+QOnR7zfkt8LElIlTccK8MuOEUw+h5Ydet2YTNkBtm3xA5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220107
X-Proofpoint-ORIG-GUID: P5YZU1TXr0F4DeY1EErCW76dQ2Zcp5M0
X-Proofpoint-GUID: P5YZU1TXr0F4DeY1EErCW76dQ2Zcp5M0

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


Out-of-kernel follow-up work

Amir Goldstein made these review requests:

- Adjust the LTP test fanotify09 to update the comment with the
appropriate 5.15.y version
- Update fanotify_init(2) "FAN_REPORT_TARGET_FID (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_MARK_EVICTABLE (since Linux 5.19)"
- Update fanotify_mark(2) "FAN_RENAME (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_FS_ERROR (since Linux 5.16 and 5.15.???)"
- Update fanotify_mark(2) "FAN_MARK_IGNORE (since Linux 6.0)"

The man page updates have not yet been merged.

The remaining work item is updating LTP's fanotify09 test.

-- 
Chuck Lever

