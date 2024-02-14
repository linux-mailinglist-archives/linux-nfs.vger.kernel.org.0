Return-Path: <linux-nfs+bounces-1924-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3A8551E3
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F226A1F218A6
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EE95EE78;
	Wed, 14 Feb 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AwlUb773";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ahP+BBIP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA4126F38
	for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934493; cv=fail; b=NkUx2PQDYxAQJ+uvoDmBVpETzfBsHnc02iPYaKKlrvEFh6Hnmh179JE3m6Djfx6GwaaWeF1NVN6AqYyD1PahsN3phla1oQstauIguIA/aHBAI6eLwrTNv1aX8LW6+89a1A50NkaGGfR0Y3BN0bRgTq7tlGUS1CRRUVpRkHrjqUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934493; c=relaxed/simple;
	bh=cOcplc3IOVBm+IGzJoxGKXP643xg4/Cq5ekn2OGs8/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=naOQKZL2sELPyk7xpOKGB7c0c2MXVAyUXUf1jyTC15xVb7kLksAVraAijFBXzUMUFp8VBF7H2AmzDIe+7IHxpfDRSYhtEry6ybn3qWAda8YD190eqOZf3iWR376PLwXhGB8abeMPC9NkEkHZYDSijTnW3ne3Fc1BZw410gOBMTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AwlUb773; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ahP+BBIP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EHOfWu003930;
	Wed, 14 Feb 2024 18:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=5pzmvhnY6AXbE/gTjLsO27D1Tub0mZoCYw63OtwGSuM=;
 b=AwlUb773TXL+8AwjbVgpPuDNhk9e5NG1qGy3e75aaG7wYrv2DRPlG2NWgiC+WoDmHIxA
 JNdPRgtOqIgaNxaG0MjOk5aOhb8CGinTuyH6w1vs3VUde8GLd76MJLR3X/bcwP2vWx1W
 sbqJE2B4XNpE/wtLW3b+03o+Fxnhi1zNnsqNIyVuAkaEl0C+BjRRIgQ8Hfw3DgczeT/G
 28pBonpomAiOkDwb9A5LydWfVdjbAvjeB9JBrrlleTE01MXohPEwEa5AjxnZgyz26q7n
 pJ8vQATQI5PXXpa2nlVaOyUoecZCB3U3x6Zuw5hYHgdMxrNxSWIBWD9p5n+GIwaL3398 +w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91vur47p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 18:14:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EHvB1g024577;
	Wed, 14 Feb 2024 18:14:47 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykfm0qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 18:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3CxMJykceSd+yoEJtBQyYyLgIDFs4uz/c5EunU5CYv2XIWB173Tr8XL3IJfhPz4FcdedVO6PRLAebbirPxsrLrM9ZVRm/quVE1WjyF+e017GQfdB9KB33azKttr2rJxaY0gewkw5+q8MbHD8cneN/Lae2DLs0PjABu+O/mfI+7Jw4nxw7aILXiMgSAfuU5Twxy4qCUHIcVaTnMSP6zDZG8rd/s+c6r3OQ7lF3Yl7RFViCw/+WhWb89NgdqfkTUxa0UOX8Ln/KKgoEXFPVJeakfJQd2waTx69J4PiLv+mASwCHeNN04FlOPEq2fKhWppPGwuMeRwS8ohJZY+kcF0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pzmvhnY6AXbE/gTjLsO27D1Tub0mZoCYw63OtwGSuM=;
 b=CF2+ivsrRKpD0+yID2+5/AsPAlCCKI5psrnLt0FlSSG6VoXUJL3mMpE4dX2Z4ENJo4FWQPrwXBT3y1GSwHJlcurPHATS4LQDkj7A2ZpzFIiHRJA7Oje22yG2iLGnvLm3MnKffIfUvHmMXx+ckRqa59TejiB7JdZE7jI4+8OCKT1d6ptj6qIy8MUX+uui6cznXwCp4b2hCrwzszRZl5z9J5U8Et7cyXFtePWO4VbcsKF7eQCYrGY6pySMW7NNxgizw9MgW4hdWZhG5D1vGJb7X5CEMiyR27HE/0/dsbRsGwd0Ta3hkvzxX8hB1wVvtBWIAzbm4XbRvBkzerhmW4yxeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pzmvhnY6AXbE/gTjLsO27D1Tub0mZoCYw63OtwGSuM=;
 b=ahP+BBIP+HHlGFnaKi4R8cb1ZiiJFn1d6SHWTGY8KdIkn8s4eQ3vwNwWecoHzQqOBrDXazWr6E6dcSKQppQosyS8/SG6kd21ZBIwf2lMDdjQ6SrLRH0zBMmzjINtMImFSIKBEcJ3EF/jzABQoqCJ4vUaRZVNecd+jalUrYSOFfc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41; Wed, 14 Feb
 2024 18:14:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 18:14:45 +0000
Date: Wed, 14 Feb 2024 13:14:42 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: dai.ngo@oracle.com
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: handle GETATTR conflict with write delegation
Message-ID: <Zc0DEuJ+jYevKc3Y@tissot.1015granger.net>
References: <1707846447-21042-1-git-send-email-dai.ngo@oracle.com>
 <1707846447-21042-3-git-send-email-dai.ngo@oracle.com>
 <ZczTPSSCmKSmdSnB@tissot.1015granger.net>
 <7994e006-b2e7-4c9b-9644-52225e1d9594@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7994e006-b2e7-4c9b-9644-52225e1d9594@oracle.com>
X-ClientProxiedBy: CH0PR03CA0408.namprd03.prod.outlook.com
 (2603:10b6:610:11b::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cc9c71-5495-4143-6461-08dc2d88d26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pKKRdxBMFtcAmIfz9AjiPbL6F7sRQ6+a9H08s0g1sKooX0bdSakg/JtZvJ9CESgewfiJ7faP4bxEDfzBqTyH3pcxXpxwrY+xdonDslVL5YLytaZj2DrlQmgU6Ahv8fSa7am1DvUjR/BfwaTlHbJk6wNf4UbMNEcWme/YWerrDpmaVfYMFAw+l5GTSL6cL1IBabehTNCBWLYJFM20gr/iq1cwn8I6uFIdvO33XMNS8hrdf/KR3NMQIJ6hdBE7TonJvhOFhZ5Jmq53G/VCkKo/xjLjRn59n9dgCYhh+EQeScjE+oK1iIhkBUoeUzHOQh63//yL56tFM+YKqLdDbrk3ZqLNIgr3HwHjSce5vhWyIY9E8G5ES9Q2BgbnZEbR/zmXtYJ8MIjPwKXa+YIUIUDQ4c/+Ek92eixx4Z+d83oMpjhc6hrc/97kzr36zsr+ravNd/EY6DXOEf9vUXOP7Us3tMWY7fA0ZxWWabuFQEpuyKNwDl/iQIFYAmY2j674/KeN57JCa2tt0dI1j0DzY/QPBYJY6BROI3QhSHtfVqRMntSLIZp8eVAqw7I7V7ldc7yq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8676002)(2906002)(34206002)(5660300002)(44832011)(8936002)(4326008)(83380400001)(26005)(38100700002)(86362001)(53546011)(66946007)(6636002)(316002)(66476007)(66556008)(6506007)(6666004)(478600001)(6512007)(6486002)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ACY8S2zP8LcWzAlaz6LSr2cOTA50kgt8hMAbarfpzHI9MSkM8MSnIsrKZzHQ?=
 =?us-ascii?Q?j1kKBdf0NmjeJWx4ymOPIgOpOd2c/vV6/3ZOsxomT+kbtJ6AzKSV3IVTzLnT?=
 =?us-ascii?Q?pLvu+71PrgjGpTKzud2nc5PYIFT7JkdVp5dWP1XKx46S2MU+ehZQBwHnYPZO?=
 =?us-ascii?Q?mK4RxpPWugclMR59aBrc58lmK074pcYsnXcA2+RYpA3UdfVATPlJJarz63oc?=
 =?us-ascii?Q?Ae30zqNxeYcc1+dgiKBvoUYga95TURy6em1VfeZZWxEEWwlM6458gLgYhQzP?=
 =?us-ascii?Q?s/CczPBSCbIMbbLHGJrRwHH6ZAPB6M09f5IGryh2mYOXFVoPxNHMQgUQM+gk?=
 =?us-ascii?Q?XgDY4O3lNQpg3koxphaY9PddbnJSHQLepbWWJxYtAKJ+aOuk13BdRHfJeGq8?=
 =?us-ascii?Q?xxdYZqGb06fjh/LwPEnDdvSERofhW1LVEl8xih+xEj/h1c4BrIKoVWkPM83V?=
 =?us-ascii?Q?FI6R8w3jz2J6cGzSL5apF9q6ChDzvLkG19EVwVjOyKfiIlb9xFOmADey9big?=
 =?us-ascii?Q?bD501/PkxpMQB+jmutvT2osBORGdR4rr1bd6C/x6jGLJGfxjau39ni5BdOA0?=
 =?us-ascii?Q?T75qNS9bSomg9TArhv1MYh0DXGdFW1gsXlkFLwkuQ+LSPxo/Cdc89ldBw7ZM?=
 =?us-ascii?Q?tzDsR4pB1cOGGnnaPwQ5fuEqL6s7Yg5w5q++Js2liB5U6Dz6pvnZonSFWIv/?=
 =?us-ascii?Q?tUx81wItyqtuye00xqy/JO074DBH6ZMjk8NUU1MMqQiQHufM9yP4yt5qPPAH?=
 =?us-ascii?Q?e5xjZ4vPlnQAUY1sgFnDIBwuhfBDye76rX8W3bE3EDP4zt7htO3ZqwKP/CZG?=
 =?us-ascii?Q?Nzqir8FjMy0TJ4VoHl94x0T41jKm7h4ML2HSqawjnG2b98JwDr8vBN3xMsmT?=
 =?us-ascii?Q?3ZIF5QL8alaoB+nXVE7Ot5OLyvdlxKUE403jaIH/nuXVosk4ZnT6LJXb7LRb?=
 =?us-ascii?Q?fZN7mVIRDwOVIbrBO04u/uhqCagZFgNPylY0JrIbOcFpGkeHqpFnP47nOcSh?=
 =?us-ascii?Q?1tFtqOuPzhHraogvjYpDGhnzCOPZmyR+6mdW8HlNCb4Gl+rIvrbDVt/YjjSZ?=
 =?us-ascii?Q?2e/yWtIA/q5oC+XiDztZ5C8Nkosoqvxs+dhLNWwuFDQg5OLFDMLcfkLHEHKI?=
 =?us-ascii?Q?mVGRhzaPv0RJVIT6Do6bxuLaGepYdGOKmnqUh1jv1x3oFAzZUHnDRGGBIK/n?=
 =?us-ascii?Q?IQgi6dqZOm4XVVYxBI76O+3jgAGqBSkFVZ0/LDyu9y1PkQFzDxX70ABHm4El?=
 =?us-ascii?Q?V2koXlQHtKhXVTa0FlvbTTDSbxVLvQ9ynnTA2cF1uxTMrbWwXAnmZnD9+qeC?=
 =?us-ascii?Q?bPCZPIiP8cHHAQlZNmOYg6gj9KHEU/uuraDawQA29zPtV8LPnC5AA/SsYLnH?=
 =?us-ascii?Q?djZlXiGxahNkPohoKObXPC3KAueOPVL+JFaQQC06LFvp1y2tufzYtBrSuzqW?=
 =?us-ascii?Q?D+UbU9VlypBATG3rD09c9eoj5Fwbo3gYZAZ7UfYDHlA0EXK+fZ0GFY+jC5p2?=
 =?us-ascii?Q?zfw3snqlczLuZnkA0cO46pNNomnrJQcPhQ5r2muhpGbWzQlzWUHMSR6mSh00?=
 =?us-ascii?Q?0pfnsGzUwNPeCCNG92iao4/s1lolySEEv1wC2kCKedmg//mPTuTn5gpvCbBc?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K7yKYq83DSKJhWj5ojOcbJ2rkqnxpjOY21MWzDkMrELTADYUb7EXZC2eBQon8vOzhSDumBYrBO+buR+CyYGjvPxTOhEjRZnptK82sh9pFVnA5P75uuM4SGCiUFvcnt5uOw8GdGIGJqBJkYkU4W+t6egO1cox9rYAdQ9/MWfwKt4G9sazrne0qEoVOHLAQObh++KWLhvxmp6byRvC0LhSe7Rcw5OOEaoo8WEj19+jSFFvM4z3U/fTV0shSdgkrPWPkO7ey8/pDvwMzWMUmmahzCqBfLgjfBY8X5/L75nfYaQ1ZIzk9yqTQ51j4GZAUJ94EFGscGptvuDSnYx+a+AwiqoFdt2K1uu+sIplCIHLJHPan9knlsLIiR6XHWClsoZT4nvdQLknSs1kWLfD9qTNrlGV7bXIQ6+0BIy3jSBrOePZW3ks0k7VlUnZI+y/Tu6MnwYdPhbxstwQOVugoAwjVrNE+zPrw0XMOVUBTjp+yJvcBTrBMdGYVSUVHFVHRIvq59jwupKI84gUSKi7ug5Q5IX7HG8aywESxNSvYnYMXlMIUZT8DD7EeCdcNQIqfXkkn55ogI11MfAb71TG12Zftzd+SKz/qg+t4Z7zjAKCNL8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cc9c71-5495-4143-6461-08dc2d88d26c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:14:45.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuD7JZuvncBmQbkeK3yp/0oahUA1tAygU1o2HWCQa2xb1DLz4nk7fXD4+/sneZtIzUNS45+ppEtOmb1y9+pRng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140143
X-Proofpoint-GUID: ljFs_OEwhQZ65d9o8hsuck2bHQ2l3Vm_
X-Proofpoint-ORIG-GUID: ljFs_OEwhQZ65d9o8hsuck2bHQ2l3Vm_

On Wed, Feb 14, 2024 at 10:10:50AM -0800, dai.ngo@oracle.com wrote:
> 
> On 2/14/24 6:50 AM, Chuck Lever wrote:
> > On Tue, Feb 13, 2024 at 09:47:27AM -0800, Dai Ngo wrote:
> > > If the GETATTR request on a file that has write delegation in effect
> > > and the request attributes include the change info and size attribute
> > > then the request is handled as below:
> > > 
> > > Server sends CB_GETATTR to client to get the latest change info and file
> > > size. If these values are the same as the server's cached values then
> > > the GETATTR proceeds as normal.
> > > 
> > > If either the change info or file size is different from the server's
> > > cached values, or the file was already marked as modified, then:
> > > 
> > >      . update time_modify and time_metadata into file's metadata
> > >        with current time
> > > 
> > >      . encode GETATTR as normal except the file size is encoded with
> > >        the value returned from CB_GETATTR
> > > 
> > >      . mark the file as modified
> > > 
> > > The CB_GETATTR is given 30ms to complte. If the CB_GETATTR fails for
> > > any reasons, the delegation is recalled and NFS4ERR_DELAY is returned
> > > for the GETATTR from the second client.
> > > 
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4state.c | 119 ++++++++++++++++++++++++++++++++++++++++----
> > >   fs/nfsd/nfs4xdr.c   |  10 +++-
> > >   fs/nfsd/nfsd.h      |   1 +
> > >   fs/nfsd/state.h     |  10 +++-
> > >   4 files changed, 127 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index d9260e77ef2d..87987515e03d 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
> > >   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
> > >   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> > > +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
> > >   static struct workqueue_struct *laundry_wq;
> > > @@ -1189,6 +1190,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
> > >   	dp->dl_recalled = false;
> > >   	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
> > >   		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
> > > +	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
> > > +			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
> > > +	dp->dl_cb_fattr.ncf_file_modified = false;
> > > +	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
> > >   	get_nfs4_file(fp);
> > >   	dp->dl_stid.sc_file = fp;
> > >   	return dp;
> > > @@ -3044,11 +3049,59 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> > >   	spin_unlock(&nn->client_lock);
> > >   }
> > > +static int
> > > +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
> > > +{
> > > +	struct nfs4_cb_fattr *ncf =
> > > +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> > > +
> > > +	ncf->ncf_cb_status = task->tk_status;
> > > +	switch (task->tk_status) {
> > > +	case -NFS4ERR_DELAY:
> > > +		rpc_delay(task, 2 * HZ);
> > > +		return 0;
> > > +	default:
> > > +		return 1;
> > > +	}
> > > +}
> > > +
> > > +static void
> > > +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
> > > +{
> > > +	struct nfs4_cb_fattr *ncf =
> > > +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> > > +	struct nfs4_delegation *dp =
> > > +			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
> > > +
> > > +	nfs4_put_stid(&dp->dl_stid);
> > > +	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
> > > +	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
> > > +}
> > > +
> > What happens if the client responds after the GETATTR timer elapses?
> > Can nfsd4_cb_getattr_release over-write memory that is now being
> > used for something else?
> 
> The refcount added in nfs4_cb_getattr keeps the delegation state valid
> until it's released here by nfs4_put_stid.

If the client never replies, does that pin the stateid?


-- 
Chuck Lever

