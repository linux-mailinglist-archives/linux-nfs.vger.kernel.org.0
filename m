Return-Path: <linux-nfs+bounces-4380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7400F91C1D7
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DBD1C20753
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0575B1C007E;
	Fri, 28 Jun 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CVQ39uaO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o5cLhpSu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA53FD4;
	Fri, 28 Jun 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586625; cv=fail; b=A5KCPuS7QzmRrQWrrYu5oSvDQxyP0hfaGAiz7tuvdtqhrXm/4GFoqoXj99y6gCa/8sMVnGtokC3zao0lkgGFFAXDQrxflvWfuusJ9h2tCa0XFkPPOBG7830o1niWJNIbuL4GyzWCGa9euU3shlysTJ3D1GVaugK/D4GRutnNLWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586625; c=relaxed/simple;
	bh=osLZiN7CM//jo1nz81BoCYTAbhI5cyVs2jgszkXv31g=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FJSqZPfHNf6E9v5mE/iDOkHkGPOzTbLIUBpGSYzPhQqo0qUUs3x22VQXbZwrcVmHDaHJ3VTOb73M+DE91oMHbi7i+J7wvZbg6dHxk1DVhkDy2DdoGJUOVGEXB+nVOWSlgtdbyLs1RHE1T791TmfL5g3wjuzPl4KSw4qMZt/WeTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CVQ39uaO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o5cLhpSu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8MkW4000538;
	Fri, 28 Jun 2024 14:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=rU+xGXQpfavwSYxOax9L6sQTJXrGg8DJrIW88nK5lkY=; b=
	CVQ39uaOKccp/03v/L1E5cCcTUghGsr3OxKg8zNw+4WyxJnBorFtz60Xw3xJoa9O
	iClXf2+iLCmSDfSNEpC+cH8zsodj1BzhNkX/PC6BS47cIcN4jMMjb+YFLnviDivI
	0DM3Zt9OUQgntlhlYKaQU0htYokIfPhfbMKCKl0ZVAk8htZB9Pgp0Jnectw/Z1de
	xHfWREV8Yv2crTxtkOD+gjEpWpbGwGY7krIHJCyHuqTofib+H3WVWbrVTDp1i0tB
	E51ZydPO+BNZb27t9hNeJITyTLOcYahmvZLGb8UJd9v1u278adrgs+guAZlRsmDD
	lNg4c+rq8yamcwBVYypkgw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb8f5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 14:57:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45SEsZpY037256;
	Fri, 28 Jun 2024 14:57:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2chvr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 14:57:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKw6Av2MwLKMT7nMMqTJD+rFp66QG8WxwS5PF1sOz+CDCg2ezlz4W5cLgMaloqqnSYdxDlKWLaO+y0fg3CDYrxanJ2xSt/iHwEH80vTu3HZpiP2JDZ4w3zj/XQw/S2Mq/+KWFCvrFt+8nhS/7jgmsAUsdMSdKIsxsBAyet8LY0i0PbPeIEjQhBsi09OnT2ybSPS73PLc2QW8l5HWaN7wWIlyZ+zR5jqWN8TBoZfKCIyMzMe5HsjK1rqzVictQF8pulciWqxa7Qdd6rDOsoV4bZkBpJt+9E63SQJyYy5c8gEMr6oLE/k/LkQE7+rssHF8l8iowrmHT4f6Fq8gAFk9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU+xGXQpfavwSYxOax9L6sQTJXrGg8DJrIW88nK5lkY=;
 b=e4J+C9dYAgZRQuLyRddiLV9Eku3PUP8bEgm9+vBzKQuPxfYRzsw0rIQjOs2GSUIHSf5h64iGS5euEyojSIakDhEo8KYFTWdEZMu7oqiT0wXuWT5oqTN/wYUYsQUf1NAfGCvvpkZCEgO9Zcy4b3QC53yyfLxUIdDTCzwgQBFT75eFAonGjh1jTArDcKQQohzCTgIosQAFJdjtJ88IM03UBmbx+ni7fgB3DkGj6Vle3leTbFQO6ld4pcca4m6FbZFx6qYfWlYqRDae/7SHusFhkMmKBwKCufyEjoBNCe30+le+jANcg8afMNWakHYNshE22JJzNPvAGY5KhjkClc3/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU+xGXQpfavwSYxOax9L6sQTJXrGg8DJrIW88nK5lkY=;
 b=o5cLhpSuWVG3Ze/r/rWWLQv0eC9WxyVi7EXArLnDSojscbtctLDu4Pa8WNUJRNAjwuwcRO+SdQrcc2ZpSlxE1DIFfsT1f+r/3kMt+KvuzQ9JiwBpweDf0kyPeLegR6XDaXLQMdH4PXJIdOi9QYoBiyclSJGhUfuIHdfAQ6iirpU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 14:56:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 14:56:57 +0000
Date: Fri, 28 Jun 2024 10:56:54 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] Additional fixes for NFSD in v6.10-rc
Message-ID: <Zn7PNqLWc1Q4MqZ6@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:610:4c::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: f8180490-8ee1-4ff9-7b71-08dc97828e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?H/XLF1T9Z+YJBHIB1cVliXMCuZ/gsUm+3uwyU2FHSHDrqOH8xTukbTWS23G8?=
 =?us-ascii?Q?lsAy3VxmwV9mIrN1OFMJ5zftThIOaAWT+uWK+t5p9w5TKeeVnzOlmoNvXK5Q?=
 =?us-ascii?Q?dBjNbrPe6CK5Yaybi5/hEu162yHHb6dFMwj+NtjS5qbIwczGr0XnUOd7lqG9?=
 =?us-ascii?Q?i6zbp2Wll2tECq64osRLTdYnPN9ZyaJ7Z96CxML2yjNlYvqTqPOrn5SgqA53?=
 =?us-ascii?Q?g8Mo8mAQwnaeSM3piH6gMxAhSc3Gkqy9b+KkbCeDA7/kJKHefkY57QItFqZj?=
 =?us-ascii?Q?uH7Iuj3N1J43GkejccfJxoexXOvdsjp1Pf9F3f+YrbB+SPZcQ6Nkn97Y9Mtu?=
 =?us-ascii?Q?azuzSY6G8bUY02q7PLNIM6p9+x5VvFrJb5BD8LnHem18CMxraplMh5MkDoFA?=
 =?us-ascii?Q?O9wd30lcV8EdiaZCMhm3BJurnBmMPjwtd5F8VaCYHkkUtBgZjNyN0kzIvTYm?=
 =?us-ascii?Q?6SloXEvVhJqqfpbAcOK88ua7VlSY41VVkpWz1cxBvs0cSB2/LVDarvnTPQ7Q?=
 =?us-ascii?Q?a5Zu/6FMRFCdCD33kzNNNm9HCPQG72sA9XFm0/WE8/BX0G0kh/X14tWxU7ld?=
 =?us-ascii?Q?2EdgxmAHUYgfGirG0Cw5A3L88hQ+DEVtPWGJjlSMk8bMGvK0KSyCi2SfWKZ9?=
 =?us-ascii?Q?SsiNi3Ggq511k7dYEpOcz6bjGsAThxFy/H1uhXG2Qca2mh4mLGrIrQ0sADj4?=
 =?us-ascii?Q?OBacZQ7PDsNupwNCsGxAR8jXsIB4cKoVP19RIagERRnsVCak1ou3GtsSwyks?=
 =?us-ascii?Q?fOCZmCHDNEFpuHdG68kCCkzeK2Bz7AF2AB/jnrqkPMBcUAHRACvenik7cHLI?=
 =?us-ascii?Q?hJlEwb++ou+cYk7pukylC9Gtqhm3jJjaFB9iQjAwEJfrFWPCyXt/+fybi/MV?=
 =?us-ascii?Q?JQZSdFcvnXnzDzx+qH5Boqu8Krkyineo+D7BrsVuxQykvHocerwM59Hp8taX?=
 =?us-ascii?Q?pXrtd5TyveS0wOvyOPlyY4Ceq4LeSnCng3ioPy+Rkm2lm5KiTqbA+UimMErQ?=
 =?us-ascii?Q?WbrJ//1W9Ln1aY77Z8CcGriUeHOdfaIteDaIl/dkJdxnpgxLzWVN6z/6hv7O?=
 =?us-ascii?Q?amqkbDcwH3sSwP5Fc0YgXSIXJf2Dt4gq8kp8z2I3mZMQAu1D/osCdzBunqm1?=
 =?us-ascii?Q?bYJfYR+XKyHem0Wm2u2z/VK7idF1b2r8RGzsidK5E0RGgaTDabs/348GuzYT?=
 =?us-ascii?Q?usxcSSGw3o32XMQTy5kahZ39A1bOCB3d1zyq/NZwTp4eTApJEE3UBPBRCrYK?=
 =?us-ascii?Q?dxqOzpLMS4xaVAKdwJBP+SVmdM5e94OZs5Iyu79MXZtVpBAfZkAC8MRXO3cG?=
 =?us-ascii?Q?R4I=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WSZz1MK/Y4mUbV4uCBkEhfKCs82QI/w9klDb72lv8PfmfKHGfob4YLoaI8U4?=
 =?us-ascii?Q?7AIvjHv85/AqMj2Jlx6BLUSL50q4XXzsT+g/6YijgD7cRc6HLsVCjVNGKu2m?=
 =?us-ascii?Q?ASnoOgrUG81a8NaMSp1kK5rWjcL36l1+L3kcsv2p+kEi9ApjzQXjCPpyWoi2?=
 =?us-ascii?Q?WHIaUQabwJWAZboevnkUcZ0sxmCeHamVeYmVfIdoXIuUFT6OOfI+WELcJ3PO?=
 =?us-ascii?Q?rBbLfeoDmhN6lWA93Hez0gmAG/Fke0bihRLEe9TDtOqP1ZRHioc2doCCCSig?=
 =?us-ascii?Q?184lRIKfh/EW+VamGNTXIbByw9KNz/W/gQYYIIZqnh41by3g2fjaCSdYkvI6?=
 =?us-ascii?Q?fFdMuA2vvGcYOhgLnAUMAYFb/w3thnNYUR0v1hcX0Y6ZzO9SqOPaIDrej6Q5?=
 =?us-ascii?Q?sH9wh0DqCYeSsmN0pOKCcP/F29CQDIzjr1CkuCeOEvosGZhzVRa4plnUfopg?=
 =?us-ascii?Q?lH0jQ6QI9FJC9aqpTIk0K3zEVN/xihUlkuScYkZ/xtt7h9B77Xp9y9OL/McG?=
 =?us-ascii?Q?U+g6vwIrrJLZlejX859M5SOJJyELkZpI7Dx+xm/ad0NzHLz8fWT3JD6x6Sxc?=
 =?us-ascii?Q?smw89/0f2Ku5MQli9Sjjb379cKf7L8DzGgNdGcs/XMQJLAqomDrPs8vMOJbu?=
 =?us-ascii?Q?+IFAn6nUlmzoPL/JUqUDCYXO89PTxRx9dhFxyjHvymEkT1yfHHDgu7TEihQw?=
 =?us-ascii?Q?K3KLn4602Q/oQwds+iDkkdF6xVWtpWqf5m9bsVPyAJQ2WeGl8OS0gHKLPRwF?=
 =?us-ascii?Q?A0pBfORRWmUOD70tBdzKBTUmZJ6zSA7qihy1dJ8ZHDz7ldrF2BKJBbyHp5eV?=
 =?us-ascii?Q?53TOqEX/A9N69Zj/PBKEsK7Ed40C2Sq2tcmanorIfksToHIt/IaQfIQ/1+K7?=
 =?us-ascii?Q?X5D4C9VIC/+f6UMq22uTpOBfKQVK+1N0ZCU0w0OfXmv+wO/Lprimmqs5ouwF?=
 =?us-ascii?Q?gk6/cGZgnVumFk7S0aQElmpfNe4k5fdii3GDXREqatuj9UhV+AqwXgp8EWuX?=
 =?us-ascii?Q?P4Ey42QITGnCm41LCeGmeHO85c9GXr29Aq0tCspCleCqSqcZuhmWoXaQVin2?=
 =?us-ascii?Q?j2u7RyySePja+rm6hNxO/FLaX1lJSGBIfL8HvcHNR0ae5Og7XfDJJA/4mIhH?=
 =?us-ascii?Q?l++OlONIsbANUxMfIE+pFm35otT0OaZ12+SCxL+JR+PBQu6JmXYDCKz92M2l?=
 =?us-ascii?Q?Mo0BWjWrtnQniolDNyZAkZRmd4p2/LUKw9NrgwjoZ1TWbQGI1pQuuaN1rgzo?=
 =?us-ascii?Q?WVapqwC6ASrs+HMkiJUTLJAS4dhxK0sRl7VeakSmd5IAxsHFN3QHkgrZ/95u?=
 =?us-ascii?Q?j+1JeY8NrPA+rdf2/xVlvdgzSoZIIHHewF4PLF/WqSUCbuFHmgKlZ29fc9kT?=
 =?us-ascii?Q?4vY8YVciNJ2xfZgCl98hyfkxUcX+hZN+PjQXNq6juMSjy3rRlS/oxNrjtlO3?=
 =?us-ascii?Q?hEsUp6YVu6EFPv+3O+YwLZ1a8c30UgBQZuyAkVpEbqk/taz42UrmY43ndBgJ?=
 =?us-ascii?Q?0RptgjBz3FaigJzfRzEbKLLxeyXcEpfWuj88VBTQLqm3hxDciumf51ktR0jv?=
 =?us-ascii?Q?IXysZrz2ykKL5zwSvZLeq+bi3eRPh49KTlR52McS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+iu+ZJ8Sz+jcFIgYID421L7Oh1Fj4l7jzQzwlYxV+PaFeDYvC/vzbzv845qxD18MgEDr36Tw9v1Y4t0PGU/0pmGMKjknQ3rvXx8gcS7bbPZd91td1Nsnpk6YdFGGJ553C33kh2w6JdZjzo4eI0r5vjLBcWSedkNQEsWtNapabWx5PUgTvlTfvqohcMmIkKx+aMXO0oq9A2fcBW5aSC7EMZIpT9ZjMkc23Y5lLBrpxocmQfQ7v7lfnCZSkfxtlX9+lXnomc9M+xH5k+x00W3+JuoLc90bT8vo8ssL2SgwEOsQ1osAl4smfvGhXGZI6y6EwLZUXzQgucuHx+oJyjMaPKPeNGuiZcka7rRqxqlGxdwmutDvb6NTNOqqtbKEJshUiiSfTr575jelZUG2eLeO+jMmeLOFv4GHvjEr8GngqUbHuroGVlSLvOngZG8srzkRw/c8EsxSpZSHLUOBlk25/5pN2OujVhKUXzx7hKzXxYyfNVZppPgwDwR6rMvePEtAstvQeb2qjkGmE9U7Y3IWN1QAzdnUg4d1YmDnW0Lcrfl8X09vwh8O8vxLtlBt9CImUKBREZJ0uFoLsHuH0SLAEFjrNxvWezIhphw/U3Q/q5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8180490-8ee1-4ff9-7b71-08dc97828e44
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:56:56.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LdbBgKpXJQTzBqX//pJwbRceyaOEfMtZo+3cDlzkwblKX/HSkGvAnir/Glb/3xJjYCLo/wFaY70EYEqldkArw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=735 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406280111
X-Proofpoint-GUID: 7Obov8wFd6j2Ebk5qL-3ZiYlZpKr-OOD
X-Proofpoint-ORIG-GUID: 7Obov8wFd6j2Ebk5qL-3ZiYlZpKr-OOD

The following changes since commit da2c8fef130ec7197e2f91c7ed70a8c5bede4bea:

  NFSD: grab nfsd_mutex in nfsd_nl_rpc_status_get_dumpit() (2024-06-17 13:16:49 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10-3

for you to fetch changes up to ac03629b1612ad008ea6603a3d142e291e3de9bb:

  Revert "nfsd: fix oops when reading pool_stats before server is started" (2024-06-25 10:18:05 -0400)

----------------------------------------------------------------
nfsd-6.10 fixes:
- Due to a late review, revert and re-fix a recent crasher fix

----------------------------------------------------------------
NeilBrown (2):
      nfsd: initialise nfsd_info.mutex early.
      Revert "nfsd: fix oops when reading pool_stats before server is started"

 fs/nfsd/nfsctl.c      | 2 ++
 fs/nfsd/nfssvc.c      | 1 -
 net/sunrpc/svc_xprt.c | 8 +++-----
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
Chuck Lever

