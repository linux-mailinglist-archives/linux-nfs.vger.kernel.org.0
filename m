Return-Path: <linux-nfs+bounces-5591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BF95BE8A
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 20:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1251F2486F
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F01CFEBC;
	Thu, 22 Aug 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RhadGmbI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aDSvw9h9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A281CFEA0;
	Thu, 22 Aug 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352882; cv=fail; b=t/4TrxcwAyzINQ8idFvV9QpRb4HQTCgcTe08JZOH9pghZ+5XMDH9arufggaWzip3LWz/UD6iZ38Ses/9w+OZeKTds8NQRT1Au6MQyt+jibd7SdzGB2ndAzGyX49nHAPSRy+f7HVqwGsnE/9DPK6dIxrOmp8LZ0YNiAKijSRqK10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352882; c=relaxed/simple;
	bh=XQvyWAbuyLYAY/2NBfMX8TCyFW+sPq+R7n1KiooBFzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D513ERnT7rjNeK97BIYvRoVCxfD23uCpKGc/RSlYfAwcCEXrXlrw0h4G7IyF3l1TNLqUdzoxZyQXnPi82J5MYoLH87BoP+Sw8ytP2pHjsMvaVCQK/J1KsTkNRHI+QeTZSrCyk1ewXDyyKFZ4GmwE4e3sWcBdAHb4fPRNtrsFe64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RhadGmbI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aDSvw9h9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMWes029706;
	Thu, 22 Aug 2024 18:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=t9zl2oZJk7WUL4j
	d0ioYsbWa8jwF5i0cvw3FKBheO0E=; b=RhadGmbIpZLR4kdgC94g6+QOYlJz/A4
	BL9ouEWRnFbOqkczhd5KFFi3Sqm6r+BoCRA7HPcHXK4CJhlA4LCmKaj71DYE5vYJ
	WJkhnOL1Qrs18Pvk7BpRkokx+1rOQCFvY+A5/fR2iEfUY+DR3dBMLcA2X/m3H2Ag
	cHkpW2a+HIeOPC47c1fL7FZU5U05SC48Ov8Ip+4vAesaHDH0U14V/5xvlwXyFe1D
	bP8ki6VncIOnT0ZRmJVNEP8pZSV5hh8TUutXt+SL3pzhAhHe94WgCTO/jWtzIs3d
	8HUxXxittM4+lZUouvcFZvMWJGuy/j4cpfbwPSsapgyuVfz0PAw8QdA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67jpmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 18:54:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MINu5W028322;
	Thu, 22 Aug 2024 18:54:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416ajus8kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 18:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is+DsZNvzF47QjSGVVkInHb9Vc1MRK3TJ3WlF0PSdF+NcuOgHh0NU0Jak2Mq1bcowJGBPPMfYkPwBSsxEnv/32Sk4XiUDO4EgNwaP9TbdKVlOlw1Yib+ZXavJJABpTLUOlIbRQGNaBLz6Lgu1eLlJVVB7MDkkWaLFBcO1LCyE2ctGEnUYs5qKKCGPr5m3pZTHNFeUqQNLFc9DAYPEQZLMPW5qyoc8VCg3sKScZ5PLJfpEvNk9A9SOka4/gIS++fractz+bF+VMs8UOxVhFSvnxlXF2qpv7zDL5Pq97dgwgG8rIiN/+zdzXI86ii9se2pS+L3n6d3jKS+7EgpwbsJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9zl2oZJk7WUL4jd0ioYsbWa8jwF5i0cvw3FKBheO0E=;
 b=ZKSujuS+3hN0qvqXd9bMT5MYXDKft7D8aiPy03Lk5CB8g1Eg49/8Qg+rrjVWWWYCI0UJSyUnqMtg/k6mK+oA0wFk2ORgpSJOiD+Ul+i6IfTVuqrIA1xb32E4p8WmogjjdDXBkwSHbz0mNbBruNL27soSZTtZMDRtcmj8wFtXZ+3vD2T8lGRii5+NBjL7pjAtOdjP6OfJDFOyh8QCZ4FTLsI+R1vf8o842dghikHF9i1vvOzMTxCq5YrjlT9G04Grp10hNzlu5SuXmumPk5VGmaKtkVhdeNH/Bzk42sTs6x+uUkYOU5YEDiusNMPONXBDCgcoHNr+m0vLyhQVzSpjtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9zl2oZJk7WUL4jd0ioYsbWa8jwF5i0cvw3FKBheO0E=;
 b=aDSvw9h9OMkLqftTbH38qzS2GDVuNpNptarp9aD1KzesqyE2J9rUwVwhFiHHMZ/dWlpARGOPb4ro62RA9PpQXzHBn0KjeqjRe9uDlMsTNk6vD6Q0hf3kxPJKp/uyn2I4FEFUlxEH9TLrpc9n5+MniPYlXWT/k1FuXlCcd8PNEW4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4965.namprd10.prod.outlook.com (2603:10b6:408:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Thu, 22 Aug
 2024 18:54:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 18:54:26 +0000
Date: Thu, 22 Aug 2024 14:54:23 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: ensure that nfsd4_fattr_args.context is zeroed out
Message-ID: <ZseJXzv80ssTkZW3@tissot.1015granger.net>
References: <20240822-nfsd-fixes-v1-1-905ae5249531@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-nfsd-fixes-v1-1-905ae5249531@kernel.org>
X-ClientProxiedBy: CH5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: d7975eaf-9198-450a-25d6-08dcc2dbd848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T6GYVKXSC6B+GrWruNy2k/yaHtNn5WHPzTbXvWgXFatNgDHBs3a33S00yLxG?=
 =?us-ascii?Q?0dnYUl26jGlfCSOW4Ry0RQZeC8743LIow7RoGY8RLr++fzzJaq+KufuA7Yp/?=
 =?us-ascii?Q?1MV0+Lrd766AZqGWp+1vsmAOYncFq9UGieWCrxDwjOrAAgBoxaL/dLvskjVo?=
 =?us-ascii?Q?Ue2iaRluTSjWBx2mE5XnNq9FXDKl9V4rvsKdVSclSKsKXTANLlQ9qhaDd2Ng?=
 =?us-ascii?Q?KMkTGnwEdGFX9X8ZKIPD9Q7jskVctP2lqi39QcHpe9xMP3szVSJDraaDRdAu?=
 =?us-ascii?Q?ObrwM5qWizRi0cNJkBh/Depi8hAWeGD0vvSffADKnEBpp9/aMaHDbwspp9te?=
 =?us-ascii?Q?nLXlk6wC2o5ZbnHKVnETvYoY1G4O81Ww6dv80Hm469VFBtNz3vg7+2blUrLt?=
 =?us-ascii?Q?SaiQdaM0H9zDGZgUHnL1upbi8f0pyOgAFlGufJh9b4kLoU5vewEXrd16GNfS?=
 =?us-ascii?Q?Zv3xOuh8bRySdEtnachTYMIxzBCICLBAebtQlIkOy6FWDhpL+64T0b3V70lM?=
 =?us-ascii?Q?xKOVtp4ivT6LbSEIQEdNp67IOgI1lGZh0q4C/whuJ9qPT2RIdWpM08yFidj0?=
 =?us-ascii?Q?s0rmPehWe/kXClV1ypYgyZnL1HHqdPfak5jKGYJ/LzkL3hu+NZUsahyk1+Wz?=
 =?us-ascii?Q?I/GgAdKjS8XU56oYAFYSNyzf/wZ9oUI7kUkFcLUD3LwWPzzSITDJQdHNF/0r?=
 =?us-ascii?Q?xAEeufH5CjR9rYl1fO84SeGBRFZs11RQCcuAtBCDdA/UCz4wyCiFxV1IF1xx?=
 =?us-ascii?Q?HrJFc+WYnBpnxwg0LphCr5clxlni94x7Zs+eymTum4ZIcT6m8I8RNT7YeBcS?=
 =?us-ascii?Q?NF1I8TXwbEMCbZ1GSHi36Uij0Xj1zFOGMvdybvvCFrqK9+P9lw4bwfDJTFUd?=
 =?us-ascii?Q?e4+57lIWevh6UagX4D9BVZG6eSEQImsBMpoORgfJYgqd58yXeJ2eyP+cIFHD?=
 =?us-ascii?Q?bTr4Z6563EEpFHYTkIkPDOjm6g60NQJC/CjNL4Jfwj4EW7DUIAU499wfOdDl?=
 =?us-ascii?Q?D2yYjKR4H0MVpWE9ENouxKAqmhbA2AvqN/raH146m4pgj+GFpHGxZnYYm2l+?=
 =?us-ascii?Q?kPgdMKS9ZF0ZrkKnb4gZ0iurlv6WrmGKBZzy0LPAfldceApAnne9RoEvl/LV?=
 =?us-ascii?Q?MQqw4YZy4d3zyHADjNS9WNFAhz4b8Hy409DpbkzYVRtHtorBJtX9pm31RbEc?=
 =?us-ascii?Q?8xw4N4GF4oUN00RMxaMor3T2CHNmYWzTJL0t6jfzo5mtuhhbqivUWclZojLY?=
 =?us-ascii?Q?TJm/caxT/R0oLWpkgER3MP1j9D70JdyjwvPDmu6dTiRKb8A8YaHs6h6WaE+N?=
 =?us-ascii?Q?19mI7l+/y/7MMBKvJ9mAutc4LNCzXqLzQEkaDyDWuBRRsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CxdNoOm3CvzuCwc8AchavH3xdYiFizIhDD83peX4Lv0MxI4ag7HaCDlRFkvV?=
 =?us-ascii?Q?V90mRnX6pVmR2hKL7Z26HDMa/kSTxWUU4aPbsPcdxYWOb024U2tGFD6Nmu+O?=
 =?us-ascii?Q?SZgJomFUWSewhEUEvRMhu2vOkC1OftAY4hwcUJm1qmJkc28Ym6E3ILSzNzHQ?=
 =?us-ascii?Q?2Oqj7nYnL0N1WRYySSBhjpajTxDTRuqIXlRZmONXn2UKzSkASCcHCtDbBJOG?=
 =?us-ascii?Q?9TFl8Pv3rAcGz9Cv19MHpp301GLTes9Pajq6zfxTpjjXDMIj/KUSycz431dY?=
 =?us-ascii?Q?UBbcV78FonZkFBeqMHIlNTce0UEG/02niaou4MjAPmsPdUn06YhYjkHhwa+w?=
 =?us-ascii?Q?VJOcnkHxrxQ5DJ+IWDqNVqr0NlIxikUejzxWZpSvW7APSr71ttBNw3XQrPuy?=
 =?us-ascii?Q?8/VzDSYZjf+6zSJYH5x8G5uqHOyR/O1gda9I739S1/cRP5AWOOMGj6bVqfpH?=
 =?us-ascii?Q?h2FFB8sRqwIreJvWH6BIHyWpaSPeJUNymDfWoOGHSjGcA5dYS2G4dWZuXHQD?=
 =?us-ascii?Q?K49f2vZAmOymtARweltqFmDgR2Vc685EguSDyhmm1S/c46IiQd9Ij9MaTyCM?=
 =?us-ascii?Q?xJfbfsh9ZbcSl4joOg8Rn4UwnO8VrbczMJSS6iO+dqDv0mIXntkgN4reHC63?=
 =?us-ascii?Q?nMw2LYJ4CIWbonaJ6Eu/CbzrEg/roq+ZyZl184WOXmOCmn935/gddbzffmPY?=
 =?us-ascii?Q?kyTfiKNI9dcMM8Ui6QflxEa/cmxBdPb15RtjKOK/J/dYHPNZS2OQA22wHOUp?=
 =?us-ascii?Q?0+5V1Cs6df10EQa1eyyWweqZucqkZEvjOWzf63RTRk7/mkoQHrf7gY9xK8zB?=
 =?us-ascii?Q?EMoKGrrDp/lHv4RHWo1fZ+UXRPqmbbop0NFHzkuYI0ivB1yWBhVE9XARRvuT?=
 =?us-ascii?Q?CCDvQFezuhvUoH7w50bxkEpbV42ZjZqf1KOmOftr57DBpLKczwQgL/IkxvZH?=
 =?us-ascii?Q?vGTHD3RLeCT9IYi3Qy0upD+IrMG2fX0QKbbviM+wIvzKxz8zmJB7BMYNaZtj?=
 =?us-ascii?Q?KrbZfz2JtxkgZT5J4ZlXucLvf1WuoiLLQX90sB7CRc9WYDRMj+qPhcFPaymf?=
 =?us-ascii?Q?01HKjIsoYWiYNZTgZm9WkiwDeHTTkIQzfHKaGRogK0afAbq+ZnloUSHfBCVr?=
 =?us-ascii?Q?JWvS5mTOpKVvdhZ42fTRfiMdbKxcPeUg+VlHGMuHMK4+2Ri6w5Oi+Z8NzeS8?=
 =?us-ascii?Q?pxPrZEQaZ4x9u45SQxtzqWVzEU4UWnfvLzYwiunKT9eX1Ql6EqkTUvM5pYc4?=
 =?us-ascii?Q?G7kAe5NxeAI6pEZuaajU6PrYY4/KRNXFJ/Dfdaf5TdjGV+9j7XGMdoRkS3v1?=
 =?us-ascii?Q?hN1KFb+455PjnN+3aGFGWHqzaU4yeplUdw6uN2LRGyj6MzACjI317kFjyllV?=
 =?us-ascii?Q?YAYZcgf1VnryRSgeFa1zW1jd/UUCoDqv3PzOhZv1bOrIQtfgRt65QjMJ+y0o?=
 =?us-ascii?Q?bwf0RsgZ4dYQtIRJ0iNab+12qvPbtKvZ3LhzYasIkyHoKXvQ5L9+90KUPQPi?=
 =?us-ascii?Q?D2fA07HlqymEvpkWLRIZqIu+IdMOeuZXaqKjoEPcuXgj0EXBxTDRkYGb48Ps?=
 =?us-ascii?Q?dTnoLyT2URv9IW99I2O2/bgRuwfbCXnttIddS3/AobTsvZ6uYScOtfT2/sb3?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jsCiaYPNsccxkW3Hq4f0yvp1AWA8zAvSxUZmLnytHINVgd09uBtd7fu5wvOSIMz58ddV7OWnBZGNXcFR4rSccMzILl3NYPURIrk2iCiLxy63D6SIosLFmY5BLBMukk/V3tqlL1gEr4+z8GLwlKyWzaRplB5f8h1RU2LKrsc9+6vJkp0FPkWRY5Wzy/NGcDbNgGEIvIokhDiaEyBPs+TlRi6kUGyNDmVcXNEVYVHGKHNuVAih9i3BG/IHFp30ulqO1Qk8bG7wG2hWGTI2NzpwZts8UVW71M+CGAYYr0EgsqstPn2u39X9R2eEv0JIO9WvjU7ZAlDYbzX7u4rIaELAKf3CnIXbYQppRVpWKRpPhsP0vN34t2y28xI5t8a8IeLg+fGPC5uVtgExUxhxRPYJjCrxVFnDZpcArUS1u4fkCU/aCLGdBmM0oD7NrGEIAFmgD4jiyKH8XZvfqA9Z4Cp43bbDiMjLkR/V2Z3qc15qFPsB0sFswF5PGgtAis0YC+ir/W6q7bOKhn6ruYnKnRx77u6O3W5y59kVhpDD2wCOSopIOM04WAFLnSA0p4wtfh+fyAlAe5Ise+8Q+eydCGjchGT9gqUt/Yt87cn1zItrAqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7975eaf-9198-450a-25d6-08dcc2dbd848
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 18:54:26.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cy0pkkqWgreSN2yHznSUr1socvkx/bCLK2EJjKAKyWwnwP0IJKi0pZkYBmswxfK7PKmsQrd/GLC71qk0EFzKKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=730 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220142
X-Proofpoint-ORIG-GUID: WE4z8K7-cUH-1YccpqPn1SWR8FPmBplA
X-Proofpoint-GUID: WE4z8K7-cUH-1YccpqPn1SWR8FPmBplA

On Thu, 22 Aug 2024 14:47:01 -0400, Jeff Layton wrote:
> If nfsd4_encode_fattr4 ends up doing a "goto out" before we get to
> checking for the security label, then args.context will be set to
> uninitialized junk on the stack, which we'll then try to free.
> Initialize it early.
> 
> 

Applied to nfsd-fixes for v6.11-rc, thanks!

[1/1] nfsd: ensure that nfsd4_fattr_args.context is zeroed out
      commit: f58bab6fd4063913bd8321e99874b8239e9ba726

-- 
Chuck Lever

