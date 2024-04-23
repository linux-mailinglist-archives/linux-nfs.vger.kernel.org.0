Return-Path: <linux-nfs+bounces-2956-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359E08AE868
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570C41C21922
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51721135A5F;
	Tue, 23 Apr 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPqnRuO/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pmeCVIt5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E087641
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879733; cv=fail; b=knK8D6YgKecpiiWEf6ujIVSTEJCVmq8bytXvEyEnNNp6cLWQZyumY2MmNhiPLoKYbq+N7CvXI1aWrQV8zxinaYcVwcusUY5Wr8hMOY3TKYszE56rqQ7GR4WhxNdevVqyN96beGw1O0OiECaWVTiXM14qq2eA6nsKdCj85XaR0EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879733; c=relaxed/simple;
	bh=n4u7KL4XUQFJzKBA5TbcKaHN7JHhVArFKsOSk9wCiGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NbTUzbUE8/iNIxsOyB3GHXzo2OUmB7IG7c91MYwKh1MQNgUpdreKl1ZmH0IeJVFKucgaMI8Q1SSKmzu2NZI9u86qRQ8dy5pJkRt7tqAZ0gqVmBlSmjQ3p0W5kMZjTDvE3s9ONG48F2w7FRHWzRh1FxjR/hgSIatiGn6Fe0y6luc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mPqnRuO/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pmeCVIt5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N7YBoh013668;
	Tue, 23 Apr 2024 13:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=38HHQu7AHSCcPSwD/2Aafxg/fEHh+Ur5ke9x/722Bvc=;
 b=mPqnRuO/9A7lH8YzaY9jXg04Uf3SuX0ruvy9EA9F43epOGRaG5Kbm8zipe/i2z3GXw44
 R/zeL8IiSfPtxWUP9Idah2ljM6LCF48RM2spkL0UDcm30VZTLXmQ5nNbBHDkHTmeSZT3
 66Lk0fbZft7ka0grfVh/f9wkqLJqp4UX1tre1dRhAuwOksze+wk+riKbydLob/XrrFto
 yaJq+23ekiokZMLiQXHKn1R5+RlnbBNwzQypPKcwRkhbLvJwet1CWYgIm26fSYIMgl8y
 JDp4nZSroAN5hXtprNfOwpVr45san5SHigIjBNZEfUSaqWnHA175boxkbGsu4YVOiF22 uw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5aun5ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 13:42:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NCCqHT035602;
	Tue, 23 Apr 2024 13:42:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm4577yd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 13:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAimI9aFQgFXOQHocBy+XUXYc68IVJjkJsGNkv78RJJkmsvOZ6LhpHeFC8czlW1+Q6tclSnpwuOwI1knSZy/KdQ278MN07ak2HOJkMz2gOgpKaEvmPKMLW5o4qJTThAHdQejiN8ufjHWg/m6AOJtIVtygP9YO+gDntnROu6HEsSQXkoia7Pq1m2OUYdEpCExsvFC54lgqAjsqbGbfnZR55R/VcsEQP6bZKf1O0Q4lpPXoQyBg712fSRXvtaNFOlCUfWk/UOMCClAA6Zlsyq7I/J4nK5IGbDeyznQu9WIlcTVk69IhXWCIX9ueRJrTVHLlZ8Ud62gWFxVzg4iMqliKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38HHQu7AHSCcPSwD/2Aafxg/fEHh+Ur5ke9x/722Bvc=;
 b=hCZj42TavTg8jy/JgZpv5HXXo94/exRinoftY6wJDphzsMzUTsQXJZotduQ9HgP1FdEKe07ABR3F94Hnj4aFwi3ISogM9OnrsuhEk2eF4RsGOQEOUTwyeec9+VpBnOTTt7lCCsCE3jfgQpO20sfboFvGNsmHs/Zi1LSEC/B7XvsJIWFP1t88OKWgB1Vnf5u33LH/8CvBHS7O3aMufoBLtnt43nr62oY06WyUMmd1fUXNKIjNI8E2vNpj5xJM90J5BHGsi+h5YKaA0nh5rXo5JiW+vpmwzLWBwSkx3GaR5NVcUjvEWGzs3QLgD7G2YnHEoAVYZGcq3BRwD4ew6Dka7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38HHQu7AHSCcPSwD/2Aafxg/fEHh+Ur5ke9x/722Bvc=;
 b=pmeCVIt5eB+YH5yWw1hi2tnpOkBJODRRkiAfwEmVLIlDNK2axxZZ89PRfbLeJdsEJro1AayDEr57DdVzg8Yw2D6RaqisT47SlynrGRFGziTMZ6G/rhkf8+cyMDU4hFztM/B8+aVzdGls4zinYiNETRntWuJXZtDWTJbswXknWFc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7688.namprd10.prod.outlook.com (2603:10b6:303:246::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Tue, 23 Apr
 2024 13:41:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 13:41:56 +0000
Date: Tue, 23 Apr 2024 09:41:53 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: mark cl_cb_state as NFSD4_CB_DOWN if
 cl_cb_client is NULL
Message-ID: <Zie6ochDV9VjumK4@tissot.1015granger.net>
References: <1713841953-19594-1-git-send-email-dai.ngo@oracle.com>
 <1713841953-19594-2-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713841953-19594-2-git-send-email-dai.ngo@oracle.com>
X-ClientProxiedBy: CH2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:610:57::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW6PR10MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e73f3e-0ddc-45d4-2e91-08dc639b246e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rWWP9ICdKBZJM2AVuaqBx3Z/Q8JCkrY0fi0IfwJSB6XT7G5l4ZW6YB1f9//G?=
 =?us-ascii?Q?bNifoTKVdvV2MeCLN7JSgPYgutJon61yML6pSSvVH6SimNYGQKsy2v+Vc3bR?=
 =?us-ascii?Q?1qDb4fohwjZDb971mOwvXXZAz+VQJTuxqGYW0DrGWR2MZSrBEJyJUhAnwn0D?=
 =?us-ascii?Q?t1oOIypu/srl7HgYjZumbhqoztL8nJNsthG9ZlxJckWw/toozje9WMuuCi3H?=
 =?us-ascii?Q?OJ6EbfMQpD/jD7TN5jSQNCJJtx9meNTHky7k9kHaU8q0IUcud/zDrD06xOkW?=
 =?us-ascii?Q?ET+6WzmEO/+nGta5mVXti/9xbUKfEAJNhrJnsId7WgDT0l3SS5DqEWNFtsLH?=
 =?us-ascii?Q?+Q1SiqcNgiHX9PB8vtV6l4WWAa0y5SkqfO7QFBUlraHk7Hmqak97sdm3/4DP?=
 =?us-ascii?Q?od0sttIJEE8VVsMoWVoo/cPBMEJKyJlpW5f0q8IrvPBJC99Vt5RNRGDsLtkT?=
 =?us-ascii?Q?QP5M/bgOM7IqHaB5p/B1BlvlaXTi4xtfzVngPEPN6wMFxU8l9kXOwR96ccfw?=
 =?us-ascii?Q?+IHHktwfaagSUpoEY0k7ApEqQpgeXvCVoAr2g37puIEPGJ9f09dEewB9GgSL?=
 =?us-ascii?Q?RN/OAMtuHgjl+Ptmm430a3eWsVDSDxrSQjww1K2PKCSigqXvVnahQ0WmlKsg?=
 =?us-ascii?Q?14KXuwJLN4vfriPoLTOtwI0+dYvRKFETQkozRfZEXzwAIrSq3u1fDY6NM67u?=
 =?us-ascii?Q?sqyONL2fNUgvsXauFPS9jAdgsA6dR3It1J/pRUmUbQto9tF2IbiErnFpaZaV?=
 =?us-ascii?Q?s0dZ3d9Phb9Jy3nNekXBuFqSo+W6cQ02UA74aQHKaiXonywo0VKNs+BVF1xm?=
 =?us-ascii?Q?a4xEKeJDmzil1s8Zbbidr2l/FLd58D+xxg6MmW90ff60eBVoVd+aeYxII0Ea?=
 =?us-ascii?Q?UmSTD4lUTt8LpTW2iLKaZERZ2qM8OrjvJU6cD/YZhaf0O0x68RIyAjClxW1k?=
 =?us-ascii?Q?rdCFoEcqI+6V7sVrqm3gkXSJn1oO/SCVsBC82CWJP8YSjfhHVFmtoBNsggoB?=
 =?us-ascii?Q?EfvVf6L1xvchhrYpAsQL0wwJ+5VSC5qKUstNbHtVd0KnGP5U0xIxO0ubIW/m?=
 =?us-ascii?Q?V+O4wUM6zSQ03wqCQdhV44t6z3KkheZPLD91zQS9mZ3NSUIWUq3s9P2IoQrC?=
 =?us-ascii?Q?j8bN1SptBCbAV6wkoHlup82SwJpVTnBurb2jCJQsJ04q8Ok9CGuW43CjmgGK?=
 =?us-ascii?Q?xH6Ib/TTjc8PW+wfayACUTA3d0ZVcb3rBg4rSq8EsvZM/lPde5R0Mz9ViF3j?=
 =?us-ascii?Q?o3WUWZruobXNnupJ84GBEynOL4EkrA9DPjULQKSNKQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/R3i5omyVA8gRIQvgcZcNHn/AIgKibM/zb0IYRp2gzTBUvOHJfrzfof9BUnA?=
 =?us-ascii?Q?YwYrism13Hj19HsJow7nZhb2erjHdBBfzEZcCzviYHZ62ZMyhN+SrD9SOS0/?=
 =?us-ascii?Q?GEMfaxXWW8Akh7SD/hFxaxX+fg1BINyl7b9VPuLQRBrlOV9Q+YlZmoBCs0tL?=
 =?us-ascii?Q?X2trS5fwg4x6yvU10lvvt3z4YzCq7tvsITwrNCgVS2Nm847P5Z43/gqjSEwl?=
 =?us-ascii?Q?UpkwlU1UTJkGlc0GcmXLorMe+NNehyoq2kG8vVC8OREoWkwVz8H5zNnQuHUU?=
 =?us-ascii?Q?LTzUSj1AAGxgoV/3tlYaeP5A/2CbmaDiSz/Jj/1rhlaF6tOr1wdQYDA0G9RF?=
 =?us-ascii?Q?7b6BZ1JJzt60NgkOzaLp6z3hUuOkGK801yMuKuzY49n6ikJeJeSkjyioTsVv?=
 =?us-ascii?Q?uLaXQUj39M5b+3Q7rkmAR147iLo5IfVcqShs9Yg1Mub+ABUvP8Ug+n7+n9s3?=
 =?us-ascii?Q?zoVNQp+GFId+NcuhHE2QnRfqW6UXZ4yA9ijMm6aJVLH+LjJ3l19ezBIyOv0V?=
 =?us-ascii?Q?+Q0JhmfRoEfhMHH2+wy8pIX71DANJBHrAdqRp6qCCMyc+Ni2Fti5gZvTJUsd?=
 =?us-ascii?Q?5CHC3aoBJPDpAt9FzjdehYSqyefOJ3x+KAkZRrP6Zp5w/9Hr0o6zDfzYCjPo?=
 =?us-ascii?Q?5DmUuLpLTWmRoZJ+DgnLWazmNNPdIH/KMpMddaJt9as9mNLCT7R+fW9ikas9?=
 =?us-ascii?Q?C2lnj1bgv1gk9quJ86BYl67sSgJu91Mqffy18ole8LCWwOk/tSfh1AFQJELg?=
 =?us-ascii?Q?+6PPnB51ggiPWXwMZbGNYg7K0paJHRkZCRKHT1Lj0eS8usSFS2dchhqqkZvt?=
 =?us-ascii?Q?Oys2sVKGRW6h2kg/2xH/oIGAU7Lpx0FjXcBI+5Jyik95J/EP7WqdiChwFqPn?=
 =?us-ascii?Q?HvEx+li5LPeiC229gQ+w7Fau7XJBN//CnQf/zJY/+4aEfs0cRemb2yqdS6jv?=
 =?us-ascii?Q?CWCaTRtENxQgCfPUli9snvh+do1I3+kRvWMooxNb7NH2xLf3Qsp9piaAZEEf?=
 =?us-ascii?Q?TkHk2m7rXD+NzIqW6F/or8sJFHqN+Jvy6Td2iMF4/Bp3mODaB42z4DWpZunG?=
 =?us-ascii?Q?IA0rt54khR9mJ4bOSZOKyep8a76NzTHS1k1F5fU1bB8RB+nWE64Im1ulaCLn?=
 =?us-ascii?Q?uI8gqcyB6ZwBV9y3QBKxgaDdQy0mSqwfrsrYFZNfsRVu7r/w5R1PPfJSQrxN?=
 =?us-ascii?Q?X60yZuO5IVe1jttIAOi9ADhNk0t+J6EFunu70RrWMnFGdTAUo5Yq+Ms7LmX7?=
 =?us-ascii?Q?ta+s3/TCsAwPdf/eU6orndWEax86oKlFuuGPlm3/47n5ievj6sBsjMEPjqK3?=
 =?us-ascii?Q?mAADioKl3DCNN53Q1bHN+BnXPvjqiK7fja8JoRpQo3pYZD5G+PN2iW1zfGYa?=
 =?us-ascii?Q?x/vZyDQmwE5u1lxoApZ2oZP2XCD3RSouEd7/Wu8IKlEEFV6mVYLhU2fTufL5?=
 =?us-ascii?Q?wIdxVsgyJ4ja4xRvYLLU4r1g/L8UQ8+2r123WTJNhjC8CsruJzxX2P+taRI7?=
 =?us-ascii?Q?O+/G8+9n1C5/ztvKIc1ee3w67uiPeHcriosrIyK4T+f4TAmB/syAB+hHd3OO?=
 =?us-ascii?Q?9jvOKMC4ZXAYt5VnfaY6AvdKxZGrofEn2AyguWv7U6hl06BmoieoBaV9y6N0?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kHCIOCUf9G5KseLCKfbCy6IHoOVuYDjtsWPCRnpfV8yuzKOstXMqMPkYb3UaiY3mCUl6t22BB9Cg8kaWI1QqPjVayUvUKa/cd6v1PNxJvyucQUfsNpBvrJjWoQb1AZih17s1umM23HdQIqnlN2NpcsGLeqm037N4P55aO5T+FXNeLC2PEXY60DDQHJuM1xhYsGkxLO94pJ+6uyWLsTUppWnTqs3KY8XUAX7wW5r268fxyqdhFhzyg+N57W/d2PMdEXEx6Zx9/7WOP1V7wd13a5vQD1E2jZCBI6DW9vNcLh/hIG9h8DIVG/a7RIF5BcxrkGVqZbfD11ZZ2CuSW+TyPBk36htVxbuT1cLg+aqiEgx9cvaBktTtJ+WbN+Kh3q15IsBhLHI1qy8RM9mKotOphbVjKIj23GmOSJRXLRqsKVf9L6Bs+2tNI91skTycHEOZHBlgV1xhUlSHa6Q+HmfrosuxiBjGlSDTh5DHnrSP+dNYhFyviKpoNQNvuqGHQsgFkYmCTa/xewiKdz2mh0fnE6TjFlVr91pvFmojVGcIoMo7QKK4ci9NcEQkrU3BZL9L+vMmDRZUEbFizSxE3Epk8RBqcZcGcdYavSy0pZvYJWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e73f3e-0ddc-45d4-2e91-08dc639b246e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:41:56.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91+Cpl/+pFWv/UW3S5kGTKHwyiSiUGBbkZi6PwU8lJf6Rh8+B7PXTtI8YzWF/qKuRO1W0H+6vw896P6eHJinMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230034
X-Proofpoint-ORIG-GUID: UAg9DaYeL-khTCYzDzs7GR7nDSZX9xaU
X-Proofpoint-GUID: UAg9DaYeL-khTCYzDzs7GR7nDSZX9xaU

On Mon, Apr 22, 2024 at 08:12:31PM -0700, Dai Ngo wrote:
> In nfsd4_run_cb_work if the rpc_clnt for the back channel is no longer
> exists, the callback state in nfs4_client should be marked as NFSD4_CB_DOWN
> so the server can notify the client to establish a new back channel
> connection.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index cf87ace7a1b0..f8bb5ff2e9ac 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1491,9 +1491,14 @@ nfsd4_run_cb_work(struct work_struct *work)
>  
>  	clnt = clp->cl_cb_client;
>  	if (!clnt) {
> -		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
> +		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
>  			nfsd41_destroy_cb(cb);
> -		else {
> +			clear_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags);
> +
> +			/* let client knows BC is down when it reconnects */
> +			clear_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
> +			nfsd4_mark_cb_down(clp);
> +		} else {
>  			/*
>  			 * XXX: Ideally, we could wait for the client to
>  			 *	reconnect, but I haven't figured out how

NFSD4_CLIENT_CB_KILL is for when the lease is getting expunged. It's
not supposed to be used when only the transport is closed. Thus,
shouldn't you mark_cb_down in this arm, instead? Even so, isn't the
backchannel already marked down when we get here?


-- 
Chuck Lever

