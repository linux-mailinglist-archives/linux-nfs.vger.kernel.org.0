Return-Path: <linux-nfs+bounces-4413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D581191CF6C
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 00:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38661B21623
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 22:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44EB208C4;
	Sat, 29 Jun 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nLm6hc8q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V2jrMvOy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571E1DFCB
	for <linux-nfs@vger.kernel.org>; Sat, 29 Jun 2024 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719699544; cv=fail; b=qiiVMx8ok/WSSwVA6n989KGgAYIzRb4hnbzTmPjZZlryY/romQ3k2/2L8Z2ISyYoURq3/bg8/NBa0wvgzDpDY3ru6I/5IbdRer54vBC3bNADHkvsvH+vXdfHV67TWMD35Yd768vt8PLfO3hP1gNRnpBFEWQ4wdJVkD8k/fuEpeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719699544; c=relaxed/simple;
	bh=lt4LSwaG4dmCkAqAsVSV3fbveRIulwhBrk0/t7xIBv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ix6M5TNbDLb43Y4Qs6B0Rg+2mDR9vOPsyPrznpgQBZPxBN34n2js8pb4XHMzvE584deqnsfhS61cklrRp2y8tr41HtwI3e72DRvMk/n3m5kSsi7wxROFh9pTGBADc8mE0B+1RnJrhXufh3CCanvqaVk4nCeL1gvi6L+vmNuwWfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nLm6hc8q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V2jrMvOy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45TKkwaF016936;
	Sat, 29 Jun 2024 22:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=cYfzDnRVA4LWRis
	QD6lDBs55/L8YYOWwrYoCo3rbIfI=; b=nLm6hc8qveLtiDBF9e9fEdP0I6GHOrv
	xhFzS1YNHH0Lx8RgPr7ZvkKA9GszWS59Ce+z36kG9NPQCE1DOQKpb9piE+wNy0Po
	lvtvdP7oSPvelkpzjj6OTr1eQRaUoAzJmjET7v37bUHF5L3vr9jyIUfPUeZ+ddlL
	r2mjfwEpdEnfaXbFL2c14+fEtW3FNs8TnUvnuxcxPHPrZVi01QG8nN2boaZolLWK
	2qDFpUwCtHoekChkF+oZDspovuNeornXjiQxnPoL+1lbGWkpAbNXeBIlSRRrUnbO
	CgsvrctnHJ7nFyNEGAD+Tp/LaH/p7Ng21Cb9bBhjuMS+yLmhIcZWAlw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402922rq2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 22:18:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45TLG5Bi033859;
	Sat, 29 Jun 2024 22:18:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q59evp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 22:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkB72v3m1CrRHU34gyGiQuDsrqqN5xxqv2j32Kh9tRDfdJtyiDTojDcOQqy1M5XN5rtYiaPvjqXjiBtW8Hwb9i4henOIDpbBuwgGaBJObYD2yGptYbmoRKrJ6NpGicud1Hq6W5xoQYEVLaRD70o7+O+17ixhQd8MCssVoEgMwMmDch1MprvVW1R/3zisSbpW7JsIolzzjXfeaZkG/+xFC9ih9PDK6fMt/DpXygmCS18EaoYs5k9J4X/U0OmVtOmEJtCA472OkpXG7FMJDQStWd17RYnJBsfCZFwYow1C+Bjudwoqy/3Pa73nnozAXMYBHtVI8PNMdZs/PBsXLDdIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYfzDnRVA4LWRisQD6lDBs55/L8YYOWwrYoCo3rbIfI=;
 b=mydc65FK3JCI4zoUgDEqi/UtA6Rh1dSqVJ0r/b/ODuCT867sHyQt1lhVSqSMgedbiYpWBUFydVeOnbOkdLuipjWbDZPU9MSmjMByvgofO0fDFwPbTf0ox44iOks7cObs2YM1lW1tej5A7mU8HMkuYLPkaoOCCmGR/1WPtcym5GSdjqfv/JHFsayx0n/JnWBIvjQ4WzKushKRQexepl0Os9EGXI4cyZm3VSxBbOfz4A7342VbOqpJmI0zZR9oiFDNtaCE1hPFwodUmdR4BGfGvedG9IFGXf2evVQCAu9kcLtWhoKaCAPBo+HqHvljBY8QrlZ8zwYcEp5QtJLpZrlkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYfzDnRVA4LWRisQD6lDBs55/L8YYOWwrYoCo3rbIfI=;
 b=V2jrMvOyULdJdtxHUdLzqaTD0Jh1nNVHeQrLSSg+3rgGnsalubOQIKNRSYw3ODO7FvV1UlHvaDEwBqv6Gv/McYAIpCUXGEeNCTL2L0f9+zJtrjsnvV4k8izMIox8V2XtzYdK1OlAf//keDFtnXeJr1eFIGcC3rZclRevWiYwbyc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4276.namprd10.prod.outlook.com (2603:10b6:a03:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sat, 29 Jun
 2024 22:18:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 22:18:46 +0000
Date: Sat, 29 Jun 2024 18:18:42 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v9 13/19] nfsd: add "localio" support
Message-ID: <ZoCIQjxougYwplsp@tissot.1015granger.net>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <20240628211105.54736-14-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628211105.54736-14-snitzer@kernel.org>
X-ClientProxiedBy: CH0PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:610:33::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c8178f-92b1-4390-e98d-08dc98897167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sirziemdJQNY4DcxBVIxap3gWqUfE2WUyqx5JDnGNcqLjA5CoQ62REfpwdSi?=
 =?us-ascii?Q?nRtp6bhyJF+A+J9HJ6ykZezpJxIGs46CX6SB1xH36U8CrMUMYJV+4EROURVB?=
 =?us-ascii?Q?WwAz9NSRQNix7M5P78R6D7goNRafa+1REnFQo8QocSDh7mcFMArpNwYYzjAe?=
 =?us-ascii?Q?PR1yvffbYv6P2d3YyD29rkqdN71Aiv+GmYzAOobw4gn8MarLHbzvHUIZJTg7?=
 =?us-ascii?Q?SUre0b0+iSkQIoWoC/AoXfDP72e0JYf+/HIs703LNW36eky87aLM9kB2LyOV?=
 =?us-ascii?Q?qBVukqCAn92TX+KezadQyw1ad8oUK6MWh/ZxWmNGpLII8aUuwliXG1vPemVH?=
 =?us-ascii?Q?3X6b7NXZI/Ip7B1npX8yuqQPe1b0GdOJ/VEl9AnKvBRHNl2idqRSB+0ZzumH?=
 =?us-ascii?Q?4dUorECP6d0NE4eKZxFlzkKI3oaJ03vhnUvjdWIsYrE6pJjkxRudnW/FwyLs?=
 =?us-ascii?Q?HZiGglrIk7KVMZPe1X8LmccBAAUu5JMoyvZHv7Rb6vjMk4R6cZLPzQneCdGg?=
 =?us-ascii?Q?3zAJHqmTQOZpPORX9cqepGbY1xkgfG+MpMFvZunMezunK85qgup2SxK2rJXO?=
 =?us-ascii?Q?mHMC5YK1IpMcDz5eIwEZGab0sX0AUWL78BUrb4Cfl06n69CzSZLlh+tgQkMI?=
 =?us-ascii?Q?HhMamUZhUXqv2J8lOaP/RQF5DA0fRJyIxaj9SpWVV3lS2WT7DvKg9MxBuNLi?=
 =?us-ascii?Q?iXwMAq8atmbnTg3/78W810GPuJ9rBpn995FbQzxs4zDsxYqCragUfzp59lgi?=
 =?us-ascii?Q?FUK72QMjKaSdZzL35qUHnn5Z3Xveh5TAFHOZGb4LRjCPQ8AiuNAE1TOae/2P?=
 =?us-ascii?Q?IlZ79AYJ62E8P4TczMDpTHnclWpW7gAuBcZowPXNpp91Wk0IstZ6FkSfuDaY?=
 =?us-ascii?Q?sD2ZMOLFsTiBhUC0ZZ89oI3CTlASU5KfZ7myjbcOeZqcQP0vp9zkdlC/jSlO?=
 =?us-ascii?Q?tFE5m6BTyxCKzFAtlmNoezXiTtVpsGJ+zb2Wi4PpApmh5bqOjtlRDQyDexhy?=
 =?us-ascii?Q?JeOayJAfeG0tWNorTgjP61UCSY2SFKNYPNeNflcs1EsZbzxnf0tspMmCD7YD?=
 =?us-ascii?Q?GrGW/bL6BUZas1Skt3A3zsNESo6v/7HxY3ZWN/jH6rM+MCBS6Dv8qh1Rc64z?=
 =?us-ascii?Q?O5yBGvqrEzP4xloFxXnzzDJ05BTwc9n9CGoHDuKi8PDf9BuDSB90bxy4Y3pQ?=
 =?us-ascii?Q?lZ2ahih+1BvPJIBaLZ8GlNjGWzS3rC7b3Apw0qkBJPHKurqSpokxh16i5oc7?=
 =?us-ascii?Q?44fyjXQkS6FhLqYFBd4jSA98R8dKmrsokN1hK/l2so5v87HG653u3w7kCm5s?=
 =?us-ascii?Q?qvFOJeKD/F5N526dYWCdXTzxpGpHV15HGeVmEAjN8GcMkA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k/LCXONppPCYkNw0KL/2mLOZ55qw8BcLwmmry7p487Zn7QsguhX2+MK3LRkU?=
 =?us-ascii?Q?eLzgMqjJkxP6l9gy+XlzQ95Cf64N09hkvBB13cSR4GkpaBHzmUgLJA637iB5?=
 =?us-ascii?Q?fWAcb/Bf2Xy/Y+8tptQwBZsde7jWbecnC+pXpliHAC0gF8K3jpTYOJ1O1X5i?=
 =?us-ascii?Q?YRBRTIdue6wQ208p48j1/HpWKZCcTkJkehHenKtl8IU9wYPkd6KTKS9KZOcm?=
 =?us-ascii?Q?fEQbDObtqkQtB4k8Ur5ytIjGxLmTRwppe+qQh5apStHnvcGQxKIi+WvSlb+h?=
 =?us-ascii?Q?hnlRRtS0F3tTphxae+HJW7/WZ9kOi5ibMe8vLDV+zZpVJ0qqArmFTxTQPMi1?=
 =?us-ascii?Q?3ppUihLPsLpun+RBJ3IRRyRzubHLFOwcg16RxvgaL4ajtA/8xJf6z8he/p1T?=
 =?us-ascii?Q?WvtznxGBcN2fyztEZHWQNHLdwNKeMVWtdZVyoygoeg2T4Vra2+DG6d1iDpl1?=
 =?us-ascii?Q?qoZNh93prHdkNhz5vzyjYNWbAqonfFmxpDooR01FfI3XWZVIFrWCgHdFsvpo?=
 =?us-ascii?Q?WiKUdnTE7QRWB7F246uL3PuyQMSfQnlPDZ37ktfvUMXukf16ByfuOdNlMUwz?=
 =?us-ascii?Q?TBuYQj9RGgwF28TuaL3JZPxileLxKU98YCoW79+StvY7fmrM3pzqndY7vu6a?=
 =?us-ascii?Q?3c6ANAHsY4HF24Tjs7hhL4CJjSATjsk/IohmGcc7++8PWANXa+zCXytRgZ5d?=
 =?us-ascii?Q?6Lre3sySFftYldSXJL1wPUEMioP0LA+/M4DLjiTbmlUn4a+9vDpaBiPNBrvT?=
 =?us-ascii?Q?2pKksZ6Q1lDMAEI9kbljc2ICCeqY5RD/k6cx4Fl/rs+jsoNXNW1KlT9t18Qd?=
 =?us-ascii?Q?V3aN0fL0u+8yEDAfiqogmZStV3hrgfw0/lywXiGNgp05OpUolNzbZxZtiquY?=
 =?us-ascii?Q?zlwQmlZinRzw82zbQUrr9AvvoAro9bUSSkgzZHCfoaICoYqoxrEYbp9WGOhP?=
 =?us-ascii?Q?wNDimnbo9/UmcKbkZhZFOzDptPKl7LlTnuIjmGXbTLx/T6Zwd5+DXpnxTetC?=
 =?us-ascii?Q?eKgx5sSS0sFqF83EZ423SQ0OwY6LrVvj6P5gfVj98/JjlPgDfTwvzmJSJeLm?=
 =?us-ascii?Q?8UI4rtiCi13fhVyEpVcBzVCof/aWfRgUrI38iENOc348uKDoCd4+loDo+Mj6?=
 =?us-ascii?Q?0jIA/HsCoxN/Gw++XB2R3NMlMYbVmiQZ+AnJN6RMY+QKRMMmtc1QKiPSWA5S?=
 =?us-ascii?Q?CnHGdHhELIVl+m4EbcVcXUmoD6LvyUNSooEeejMHR5ut5bxLS97PuESW1q1L?=
 =?us-ascii?Q?zK8BDZp6lMqn+TPAE/z+xUsmxxp3cjcfGFjVMYLOO2Xl3tb5Eo/nOLaT/TRz?=
 =?us-ascii?Q?fp1Likk1nC9Vy8+eXUl5pTPVR3cfOKEsd4DDzpOPPMxSieDA9HkKRnTLxAMX?=
 =?us-ascii?Q?Fg22Eb/ob/vhCOIKTFRN63iyGTQv83H2W2fZSmm5/ikI1HaF+T13HIvM448V?=
 =?us-ascii?Q?B/HSGAq6yIREJcf/HY/UEgBEu7XjX2jzJKQYGircaytFvj8if74UkZZ5C0EQ?=
 =?us-ascii?Q?Ia3YA/tbRNzSMrpSoY5skQl3tlDTdyBG8aqrd0YUOWT8+laM59ywyTZlV0vs?=
 =?us-ascii?Q?ulSuN5dO0SfMRi8SMVSBVHt85eQzrRiQwp2MFvAJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WvAw8piE9BZNs6cT5sKW4Y/FItH/qDci2c5TlSc4VlfAw9qZutXb2gXc3Qaz2RZA32aa6pjXR7/GXgG2ZsUhg02N1UFHNrMP3TPPuJnb0kuperwAJRN2LxHWS0/X+TDpIJVjRo7bDMZVr7cMxHnkHuEJrA17SRDWZXXsq+uB5sDeNNPBfAMwlHr5TfjMIdxatPxx7C5KlyX0vx1DK7IrYOVAWuOJF8dzI8zyGhuuHV8UAoBdMiRuxzt8lmDiW+6QSUdzOi8qL5w4pBmxhQKZlQ9Cwb5sBntA29vmwhEOc40oIHFhbUhSF99gHwqcs2jZ4XRMzDMADJzrdaVmgLHNAVA/ENj7AnXbb/rBtdGP5JpmgDFSoQEjOFTxvwsi7byPhFNEmxe7FCkscVHIXeFDNpUj60I8NE+WtmZP68c2hVIBaBT5GSvNTmIsnihJj2fjOskS9kFkQX+2QD6mwehAdhS5VKibRH9Cw5DmVbiC4qGljs64niAjz+kQwbo55HQF3zl2UwoL0d9kixNdvO2Za+YPB/2PtGHW7ffuvbsgVsofjSDEgIAOW2R+tFJpi2RUmfM+cx8jP0qDZOxOZZmL9wLIqqAOoD1/DqY14UuFHx4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c8178f-92b1-4390-e98d-08dc98897167
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 22:18:46.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ieb6XnbF9gKMIdXNkZBwPIKhFp1qQ5rl8VUMLhSA6/32ftYdvhmu0h7L6ZVui9k/xMyqnyEN5MpeozyVXyh8lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_11,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406290164
X-Proofpoint-GUID: 7nyyqHAUuB7JtoLfpe97XzcPcxljhdwq
X-Proofpoint-ORIG-GUID: 7nyyqHAUuB7JtoLfpe97XzcPcxljhdwq

Sorry, I guess I expected to have more time to learn about these
patches before writing review comments. But if you want them to go
in soon, I had better look more closely at them now.


On Fri, Jun 28, 2024 at 05:10:59PM -0400, Mike Snitzer wrote:
> Pass the stored cl_nfssvc_net from the client to the server as

This is the only mention of cl_nfssvc_net I can find in this
patch. I'm not sure what it is. Patch description should maybe
provide some context.


> first argument to nfsd_open_local_fh() to ensure the proper network
> namespace is used for localio.

Can the patch description say something about the distinct mount 
namespaces -- if the local application is running in a different
container than the NFS server, are we using only the network
namespaces for authorizing the file access? And is that OK to do?
If yes, patch description should explain that NFS local I/O ignores
the boundaries of mount namespaces and why that is OK to do.


> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/Makefile    |   1 +
>  fs/nfsd/filecache.c |   2 +-
>  fs/nfsd/localio.c   | 239 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfssvc.c    |   1 +
>  fs/nfsd/trace.h     |   3 +-
>  fs/nfsd/vfs.h       |   9 ++
>  6 files changed, 253 insertions(+), 2 deletions(-)
>  create mode 100644 fs/nfsd/localio.c
> 
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..78b421778a79 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
>  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> +nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ad9083ca144b..99631fa56662 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -52,7 +52,7 @@
>  #define NFSD_FILE_CACHE_UP		     (0)
>  
>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
>  
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> new file mode 100644
> index 000000000000..759a5cb79652
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NFS server support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/exportfs.h>
> +#include <linux/sunrpc/svcauth_gss.h>
> +#include <linux/sunrpc/clnt.h>
> +#include <linux/nfs.h>
> +#include <linux/string.h>
> +
> +#include "nfsd.h"
> +#include "vfs.h"
> +#include "netns.h"
> +#include "filecache.h"
> +
> +#define NFSDDBG_FACILITY		NFSDDBG_FH

With no more dprintk() call sites in this patch, you no longer need
this macro definition.


> +/*
> + * We need to translate between nfs status return values and
> + * the local errno values which may not be the same.
> + * - duplicated from fs/nfs/nfs2xdr.c to avoid needless bloat of
> + *   all compiled nfs objects if it were in include/linux/nfs.h
> + */
> +static const struct {
> +	int stat;
> +	int errno;
> +} nfs_common_errtbl[] = {
> +	{ NFS_OK,		0		},
> +	{ NFSERR_PERM,		-EPERM		},
> +	{ NFSERR_NOENT,		-ENOENT		},
> +	{ NFSERR_IO,		-EIO		},
> +	{ NFSERR_NXIO,		-ENXIO		},
> +/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> +	{ NFSERR_ACCES,		-EACCES		},
> +	{ NFSERR_EXIST,		-EEXIST		},
> +	{ NFSERR_XDEV,		-EXDEV		},
> +	{ NFSERR_NODEV,		-ENODEV		},
> +	{ NFSERR_NOTDIR,	-ENOTDIR	},
> +	{ NFSERR_ISDIR,		-EISDIR		},
> +	{ NFSERR_INVAL,		-EINVAL		},
> +	{ NFSERR_FBIG,		-EFBIG		},
> +	{ NFSERR_NOSPC,		-ENOSPC		},
> +	{ NFSERR_ROFS,		-EROFS		},
> +	{ NFSERR_MLINK,		-EMLINK		},
> +	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> +	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> +	{ NFSERR_DQUOT,		-EDQUOT		},
> +	{ NFSERR_STALE,		-ESTALE		},
> +	{ NFSERR_REMOTE,	-EREMOTE	},
> +#ifdef EWFLUSH
> +	{ NFSERR_WFLUSH,	-EWFLUSH	},
> +#endif
> +	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> +	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> +	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> +	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> +	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> +	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> +	{ NFSERR_BADTYPE,	-EBADTYPE	},
> +	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> +	{ -1,			-EIO		}
> +};
> +
> +/**
> + * nfs_stat_to_errno - convert an NFS status code to a local errno
> + * @status: NFS status code to convert
> + *
> + * Returns a local errno value, or -EIO if the NFS status code is
> + * not recognized.  nfsd_file_acquire() returns an nfsstat that
> + * needs to be translated to an errno before being returned to a
> + * local client application.
> + */
> +static int nfs_stat_to_errno(enum nfs_stat status)
> +{
> +	int i;
> +
> +	for (i = 0; nfs_common_errtbl[i].stat != -1; i++) {
> +		if (nfs_common_errtbl[i].stat == (int)status)
> +			return nfs_common_errtbl[i].errno;
> +	}
> +	return nfs_common_errtbl[i].errno;
> +}
> +
> +static void
> +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> +{
> +	if (rqstp->rq_client)
> +		auth_domain_put(rqstp->rq_client);
> +	if (rqstp->rq_cred.cr_group_info)
> +		put_group_info(rqstp->rq_cred.cr_group_info);
> +	/* rpcauth_map_to_svc_cred_local() clears cr_principal */
> +	WARN_ON_ONCE(rqstp->rq_cred.cr_principal != NULL);
> +	kfree(rqstp->rq_xprt);
> +	kfree(rqstp);
> +}
> +
> +static struct svc_rqst *
> +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> +			const struct cred *cred)
> +{
> +	struct svc_rqst *rqstp;
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	int status;
> +
> +	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */
> +	if (unlikely(!READ_ONCE(nn->nfsd_serv)))
> +		return ERR_PTR(-ENXIO);
> +
> +	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
> +	if (!rqstp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rqstp->rq_xprt = kzalloc(sizeof(*rqstp->rq_xprt), GFP_KERNEL);
> +	if (!rqstp->rq_xprt) {
> +		status = -ENOMEM;
> +		goto out_err;
> +	}

struct svc_rqst is pretty big (like, bigger than a couple of pages).
What happens if this allocation fails?

And how often does it occur -- does that add significant overhead?


> +
> +	rqstp->rq_xprt->xpt_net = net;
> +	__set_bit(RQ_SECURE, &rqstp->rq_flags);
> +	rqstp->rq_proc = 1;
> +	rqstp->rq_vers = 3;

IMO these need to be symbolic constants, not integers. Or, at least
there needs to be some documenting comments that explain these are
fake and why that's OK to do. Or, are there better choices?


> +	rqstp->rq_prot = IPPROTO_TCP;
> +	rqstp->rq_server = nn->nfsd_serv;
> +
> +	/* Note: we're connecting to ourself, so source addr == peer addr */
> +	rqstp->rq_addrlen = rpc_peeraddr(rpc_clnt,
> +			(struct sockaddr *)&rqstp->rq_addr,
> +			sizeof(rqstp->rq_addr));
> +
> +	rpcauth_map_to_svc_cred_local(rpc_clnt->cl_auth, cred, &rqstp->rq_cred);
> +
> +	/*
> +	 * set up enough for svcauth_unix_set_client to be able to wait
> +	 * for the cache downcall. Note that we do _not_ want to allow the
> +	 * request to be deferred for later revisit since this rqst and xprt
> +	 * are not set up to run inside of the normal svc_rqst engine.
> +	 */
> +	INIT_LIST_HEAD(&rqstp->rq_xprt->xpt_deferred);
> +	kref_init(&rqstp->rq_xprt->xpt_ref);
> +	spin_lock_init(&rqstp->rq_xprt->xpt_lock);
> +	rqstp->rq_chandle.thread_wait = 5 * HZ;
> +
> +	status = svcauth_unix_set_client(rqstp);
> +	switch (status) {
> +	case SVC_OK:
> +		break;
> +	case SVC_DENIED:
> +		status = -ENXIO;
> +		goto out_err;
> +	default:
> +		status = -ETIMEDOUT;
> +		goto out_err;
> +	}

Interesting. Why would svcauth_unix_set_client fail for a local I/O
request? Wouldn't it only be because the local application is trying
to open a file it doesn't have permission to?


> +	return rqstp;
> +
> +out_err:
> +	nfsd_local_fakerqst_destroy(rqstp);
> +	return ERR_PTR(status);
> +}
> +
> +/*
> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @file
> + *
> + * This function maps a local fh to a path on a local filesystem.
> + * This is useful when the nfs client has the local server mounted - it can
> + * avoid all the NFS overhead with reads, writes and commits.

Hm. It just occurred to me that there won't be a two-phase commit
here, and possibly no flush-on-close, either? Can someone help
explain whether/how the writeback semantics are different for NFS
local I/O?


> + *
> + * on successful return, caller is responsible for calling path_put. Also
> + * note that this is called from nfs.ko via find_symbol() to avoid an explicit
> + * dependency on knfsd. So, there is no forward declaration in a header file
> + * for it.

Yet I see a declaration added below in fs/nfsd/vfs.h. Is this
comment out of date? Or perhaps you mean there's no declaration
that is shared with the client code?


> + */
> +int nfsd_open_local_fh(struct net *net,

I've been asking that new NFSD code use genuine full-blooded kdoc
comments for new functions. Since this is a global (EXPORTED)
function, please make this a genuine kdoc comment.


> +			 struct rpc_clnt *rpc_clnt,
> +			 const struct cred *cred,
> +			 const struct nfs_fh *nfs_fh,
> +			 const fmode_t fmode,
> +			 struct file **pfilp)
> +{
> +	const struct cred *save_cred;
> +	struct svc_rqst *rqstp;
> +	struct svc_fh fh;
> +	struct nfsd_file *nf;
> +	int status = 0;
> +	int mayflags = NFSD_MAY_LOCALIO;
> +	__be32 beres;

Nit: I've been asking that new NFSD code use reverse-christmas tree
format for variable declarations.


> +
> +	/* Save creds before calling into nfsd */
> +	save_cred = get_current_cred();
> +
> +	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred);
> +	if (IS_ERR(rqstp)) {
> +		status = PTR_ERR(rqstp);
> +		goto out_revertcred;
> +	}

It might be nicer if you had a small pool of svc threads pre-created
for this purpose instead of manufacturing one of these and then
tearing it down for every local open call.

Maybe even better if you had an internal transport on which to queue
these open requests... because this is all pretty bespoke.


> +
> +	/* nfs_fh -> svc_fh */
> +	if (nfs_fh->size > NFS4_FHSIZE) {
> +		status = -EINVAL;
> +		goto out;
> +	}
> +	fh_init(&fh, NFS4_FHSIZE);
> +	fh.fh_handle.fh_size = nfs_fh->size;
> +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> +
> +	if (fmode & FMODE_READ)
> +		mayflags |= NFSD_MAY_READ;
> +	if (fmode & FMODE_WRITE)
> +		mayflags |= NFSD_MAY_WRITE;
> +
> +	beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> +	if (beres) {
> +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> +		goto out_fh_put;
> +	}

So I'm wondering whether just calling fh_verify() and then
nfsd_open_verified() would be simpler and/or good enough here. Is
there a strong reason to use the file cache for locally opened
files? Jeff, any thoughts? Will there be writeback ramifications for
doing this? Maybe we need a comment here explaining how these files
are garbage collected (just an fput by the local I/O client, I would
guess).


> +
> +	*pfilp = get_file(nf->nf_file);
> +
> +	nfsd_file_put(nf);
> +out_fh_put:
> +	fh_put(&fh);
> +
> +out:
> +	nfsd_local_fakerqst_destroy(rqstp);
> +out_revertcred:
> +	revert_creds(save_cred);
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 1222a0a33fe1..a477d2c5088a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -431,6 +431,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
>  #endif
>  #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
>  	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
> +	nn->nfsd_uuid.net = net;
>  	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
>  #endif
>  	nn->nfsd_net_up = true;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 77bbd23aa150..9c0610fdd11c 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
>  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
>  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
>  
>  TRACE_EVENT(nfsd_compound,
>  	TP_PROTO(
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 57cd70062048..5146f0c81752 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -33,6 +33,8 @@
>  
>  #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
>  
> +#define NFSD_MAY_LOCALIO		0x2000
> +
>  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
>  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
>  
> @@ -158,6 +160,13 @@ __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
>  
>  void		nfsd_filp_close(struct file *fp);
>  
> +int		nfsd_open_local_fh(struct net *net,
> +				   struct rpc_clnt *rpc_clnt,
> +				   const struct cred *cred,
> +				   const struct nfs_fh *nfs_fh,
> +				   const fmode_t fmode,
> +				   struct file **pfilp);
> +
>  static inline int fh_want_write(struct svc_fh *fh)
>  {
>  	int ret;
> -- 
> 2.44.0
> 
> 

-- 
Chuck Lever

