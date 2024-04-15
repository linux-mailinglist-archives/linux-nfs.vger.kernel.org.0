Return-Path: <linux-nfs+bounces-2827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0298A5C91
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 23:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250881C21119
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 21:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026815696E;
	Mon, 15 Apr 2024 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PabGYkO5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nrZI149g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF2155734;
	Mon, 15 Apr 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215019; cv=fail; b=Pujpf1QMqrPxljPTjLRoQV1F5Syv1WvNT9jusSg6GeWamuB+CDbeP5H0YI9GmBXF61hrTcv8/FJU9Y9mo4mxLftVQGwZf8R44jnoiT7glUQYtW/jZolcBQLq9Axec84Po+N4VANNDvufHBhDF7be8zkJNx+zAjPaaRYApZmj3kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215019; c=relaxed/simple;
	bh=dFzY5MMKJqPm7youTPrgkc6bQpqPxTTsRJpmMX5jf5s=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZKiy8PCVzh3ZEnIs5W/QJ3CtSKshY8G3cEkp/lILO/hMPvvXFGH1LhA+JmMabnENaA+w1WzAjZy97zNEW94zJNpUF2RTnoiPyXSdrfCURpPeQDKF5uNJRhpWDbHr6hW0ZFn6eg7m+pp2YKv29sUjFqQLfHEjBgquDBI+DcKJi1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PabGYkO5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nrZI149g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FKmxcq003662;
	Mon, 15 Apr 2024 21:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=yZRw//SFtis80IpR2XGIwgB9fdUL2ITzA2J6QTZecz0=;
 b=PabGYkO5jli1X1g9vGyQMP9H7o9Go18nEI4tNL+hKXkvVmt8cMZP32u28sN9MuJHEopI
 YJDd+YNNgId6/Vv2ljHJSfXedyZlOqXzwU8DGG22OCoMJKvoqbHR8UreJbssr0l238fd
 nCsxjjj6Yw7z6LD652+ofHbg9h36HXvWE8wgbGrODK6XnwCbIbGoeyuvPD+XR+XOG1Tf
 P0eMQ/F7Qydt+UR+hbdJQUO1ktSJJwSppUxasaJjIBB6E6QEApLBhsPA8tkSbukZ59Hq
 6jGaqUayB5pb7uRiMYGgrXj3jGR4GDthPPvJyCl10IOL3LLxxxSqruHMDoZUxIRXSzMV 7w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhnubv0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 21:03:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FJp39n028938;
	Mon, 15 Apr 2024 21:03:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg6bd8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 21:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT3fG+rV3xdsyllyRtV9gOETkLzKui4iZ/Ma2AGIgRpHj/QZ43qJXOXA9+TKQqe30uTO/JYna8JzJ7CwuhB23Sv2J004bN/IWrKocRn9vNTqoA657MzmNO1Z7Wrrx0scVBsiaDJA1zMj+/Mqw/en6BQHQD3XbyG2RehvRPKZ1Xu7QWMY+llNiakaZpJsL7JePdaFwaZjbv41IRwLGx/6qpoHt/C02+tyFKdC3u1oCj6/gCotyMnGHFeXyNvCnYKYG4VPA/CWeQ+FpZTFfB2cPnWJa2RwQgU9ukRFj6Y6L67PWMIV5Ui0SrcBJEhRMf/1rfqzl7bV3ro6WQIdSE+H/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZRw//SFtis80IpR2XGIwgB9fdUL2ITzA2J6QTZecz0=;
 b=aPqtXq03BmlXYos+XgVFZO65qQw2hcalzrLS8JbiHu5Horue8C5CVHJal0Y63+0zng2dKLrKRGKQQWGxohwYxhdwM7au8tPojO2u5Mb/6HL7M76ZSmeaWBaLS8Y3jtIk6Mpd38L02KlY4gFOWe3zbbQtsoSnDZnbNI69YZvQC0xVElOcGb1ohf536qVS1mr4eex1YwmLtjM1/wTjGhS4C8jCHNmjYjtn95h+0eZBMipVLHC7usQaZ5aG24RpGUUg7ebb9vHUIqgGAOAt/5FtMbbT2wEuMnWjV8bEwjL9uYfj9kdRBt80sDaIftorFJy7R/KzXMs3vUXYc4B6VB+d8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZRw//SFtis80IpR2XGIwgB9fdUL2ITzA2J6QTZecz0=;
 b=nrZI149gZ5q/cxf9pvJ/NF8eDh2mi39PksHBd14M36zwCxNnswbkV00vyZ1WdqLbY8nPDnkyBCKZEz2eWp0EPJyFkIe7zMCow8XhVa3zIJAv1Z3CmHrlWl8PFgmXw4FpEhI98kHI1nPzmlwr9qd/xXS/IWfHPVS5Quj2wdVJZZw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7976.namprd10.prod.outlook.com (2603:10b6:930:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 21:03:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 21:03:24 +0000
Date: Mon, 15 Apr 2024 17:03:21 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] 3rd round of NFSD fixes for v6.9-rc
Message-ID: <Zh2WGRLG3mA92OxN@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH3P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYXPR10MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: de4421a7-2341-4758-7c56-08dc5d8f7d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RTkNhkYYjSY/A4y+Ql+HkXlevQdAlUXmBpxMntKT7qz0yT8qKGNin7pKxVBt?=
 =?us-ascii?Q?kfrGKClHEK8FYRLGxDK4eJ3NYi+RdFpq01Ofnv0dRXugV7CM1IGTJEhv9gw8?=
 =?us-ascii?Q?E7xLSUHucggScbpfgfQASNPHvwwXMOo/mze4FRdIqsZjdHOny9yxfwPen7BD?=
 =?us-ascii?Q?Rc1r0hJuwkzOtT+HQ9J0sbZpxt1oN/7+tmcuGSQ+I4Mya+cIIDSmT/J5FDb+?=
 =?us-ascii?Q?slFy2JmjpFcE2xFr9jdiHMuS1TITitp8QyHhAfSN0kDnrx0c9gyP6+k3Gf0J?=
 =?us-ascii?Q?Zg1EF6Pvdmu8HWvYdMqdExzefEQx9CDUCCIj67k/q3VgYObiRudVXvms9/eg?=
 =?us-ascii?Q?yBNf9F5WdSpEpghNMvdVjpBPvmClF8d+9JOilMweU04efynEwWMfbIgFUpmg?=
 =?us-ascii?Q?Td3y1awTKV+CCjUyGSAkZO37wtHVjtRiDjuY2Mr7aUET0tbfdnsjwZI4KIJr?=
 =?us-ascii?Q?g+3g28bS4zo+0tXd4dx7yBaMu58DWlk0wQIZW5pVtDEns1ormA3dk19dR1hI?=
 =?us-ascii?Q?Y5/KGWI9z8zCsSzgaxcWCNUJ4fG4oMlY5qe11Dbi0ifmwdrQbIKYGEEJonqp?=
 =?us-ascii?Q?lTn9OUGRehPWQ80ZnsAI4Li2eWEW3MmHa4xS9abCovdERY7x3+b24u+0/qDq?=
 =?us-ascii?Q?9iLEygGrtuHuxyKf7LL4Qq/3V086Dw7smOTsSRyQLui8OLSGczKC0n8rx/nA?=
 =?us-ascii?Q?ary2/r7+q5KwWI+Gc6Oi5gz/yzrbEBPmP3gyiNfDRv0SZrvXBjPNlPuVywUt?=
 =?us-ascii?Q?Y2ps60fnQkD6sBTRQeKYH1WHQFHNRNyXUjZPYpx2LI+y+AR8e6ai7SAB2GZ2?=
 =?us-ascii?Q?QWCDsPxbLEuOUipwl2bR0k+66cZVWe871oydyIuapYsR9LWc/mvp+0ecyaBy?=
 =?us-ascii?Q?i7+lJPojTwP8Ta7UYHZ7uhgdlymeVGrE74a6xPTneVO4a9sbQ+un95CU49Fo?=
 =?us-ascii?Q?GFBkOpamS44mrY4I/dw/ro36Gv0A9ZbemnoClwowz/zsEOXVqUIZTO9DoUO0?=
 =?us-ascii?Q?Bg0O7v/0+KX8ZwkjYjnSIXUEQZ9Rr+UAMwFFxWDiNVHVe8z6hOo7OP3WjBIO?=
 =?us-ascii?Q?xg1STf7/OaD3kvxI5OK6oCfQvxA38JLE6nmlx2n4FWJ2X+8KITWPi70/3Xnd?=
 =?us-ascii?Q?My/XoVkBzW4rQSXP2KnwnsUg/47h5QH2F8+FSF2p11axms4O1nlHuaA60LeC?=
 =?us-ascii?Q?frFYX9VeZb94xdVNVyRb50j+uZfRcAHQ2nxc7a7sIqwIUzP8w581WDwJBarJ?=
 =?us-ascii?Q?qrKx4oyH2eImAXV8ERaIJy04Y0xtwIxcc1bucxyqzQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?X2H5qTqvYv0mEj8L18CJlxSeIYEWGhUu/X3vnJIfo8EJtSY5OeBnkxRI/a0P?=
 =?us-ascii?Q?N6oBiHpu0F3IKaEa9yupY5T1GmiomYFUkDILJbEaoVaByPwodcUGfIvCvwZZ?=
 =?us-ascii?Q?AW6fr9PHkH034Ruty/TzhfjskqijneuUb/xx786xzhf6zVOjeAeDbI/kurRo?=
 =?us-ascii?Q?gjQZg/0xZDEZ/dO08Iu8j1BFiJ/Th0nPYRLryve6Bof0VP63wqcooGkdm6Y3?=
 =?us-ascii?Q?+U5D5AZYCvxaek4iH+0rdxD5zsOW9kK/l83Z5HNFCPoTOBwZzWFrfJJjFNAn?=
 =?us-ascii?Q?0Br2sDhCtFyu1KQikAwu1xyLhIdZHIeC2f3Of/4rvFXRa3lCXIyFsznvJh1P?=
 =?us-ascii?Q?rn3s9wQFcRLNy8M7cZ1IJz/44UvKTuURXkc2cbHQRBkLGTI1AMEDP79j3riM?=
 =?us-ascii?Q?GVPH1Og8gA+DUowoORIlG/Y7s3Xh+bH3YtPLP3Wjlo8dufgxWR5v/A7bYfF8?=
 =?us-ascii?Q?Q4+1pAB5uPiy3Jb0fH53AVdMyajLaKeJcHUi0Hrx7BvOC2nDH+J6M+BK5Ycm?=
 =?us-ascii?Q?puR1zLotODgjNWu3U5PNiEttYs3YuEkZlrzNGSDFGn2V1GiHJPZrGf/kDEpi?=
 =?us-ascii?Q?byss53Q/Zbk9INQuh/oP4UYPaPzmc7dzWuuXz+HiohzYnCdSwB1vDuMA9WXB?=
 =?us-ascii?Q?sWkjRmCQGhiZsjjO9HDtrs6bYki3maBqtbt8WtRcGjTBFWsvn0PMIJiok95d?=
 =?us-ascii?Q?Otp1hRxZXhDLyES+UJv5z2EQgQW64CLew/D8xdF4zG9f+TksGcMZnWwz+vD1?=
 =?us-ascii?Q?JW2me8Hy4xqI4+1HVH9x9viKwVLFlMb7bKi44YVr2kglowRZ8oQ6ihyhGx4U?=
 =?us-ascii?Q?R4t5gcV0Tm0G8Wame/N3j7KgP9t6mPpSoEYJqabWDgleRlxWUsWgfNcqSZxb?=
 =?us-ascii?Q?03IIn3v2n5oH1nYfnA3gE6JBENJELLZjx0a5WnqMYMsBNsto50ICOqLnqW4g?=
 =?us-ascii?Q?h7b8+byDRgY1cway9mjtNJ7o0KCoQZN2MKQL0pT+z86/rRowj3IrrehtCgpz?=
 =?us-ascii?Q?cRntnVKBGIDIgt+sZoZqs6hOG0y371z8tPJSsPM3z8jMR2b3sdKrd3FHCz5X?=
 =?us-ascii?Q?HvuSovvizaPuF9ljCsM65OvWVjDj3c2YMSk+bZ/aF5s+sZBmk/pmlfAXuUcn?=
 =?us-ascii?Q?CSd4Lasa+3+4y6oXss1UoUicKcYCENoyyaIdcXeUwnLH5yVPMVLAn9lT/Vpw?=
 =?us-ascii?Q?uhb6tF8QUuZ+lAPxZ0DdKBg3nC2KpATrGdDlUWw+MhKUwLVsw0TsB8p9PrQE?=
 =?us-ascii?Q?7NunQ2AmDRk25npTItsEhjqpnYIcLAxdnJ9Gm4Biu9uZyq1Sy6uFZhe3Ua6Q?=
 =?us-ascii?Q?BoBy5OskmHS4AQC3b2vvdVstOCZvhYjWQdWI1WQu3xoxQjjtHkQjUjbIOlYV?=
 =?us-ascii?Q?ah2kKWtpfHTJG6eMVXrMXAmks+/fiBsuO3CdT1zyCIHQ6t2qk5q/FtGPOiTK?=
 =?us-ascii?Q?L4LOpiwFa40SxktJOtv5M8x+FpYjyRqTjRepSKxybHHDKPkYAcUy8kJntsGT?=
 =?us-ascii?Q?ogV8R4LZdUC8bL6rqekEtaWw9/B7k03V7Dkz8TXA1NeUhS9jACf1wSVQ8NKi?=
 =?us-ascii?Q?jVGgbVY3ZUkjllHxVE1P2PKo6UyRCwgpvL9Bn+Ga9HjNB6m9USS9xJ/6fL+n?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gHiY8VGsdm1jaXSHEpfnZe9YrT58Zb7Qo+2smPADpwmLOsn3irZa+LPDgiCK5VUxwCXuuyBSzEfbFYRDNekAwTY66CQaON87iTqDYkstEdwhCg8S56w6k8hyRm/JfL0Evf3Hi21IpU8tf+TScZ35OEk6CVPFm7CSEuuVBcZKcU11SMM4o7rn9pZDtafym83uc5hvZqLZN1ro+zo6MR0ATyVrogj2xhYJb7ty4h7lee5OcfAx1ZA0R0euC26FE52mQbBD0yG+ZDHF2yZVzUcSYHKdcbirexEA4knIxyj6qEGaoDJ0fL/HOwQqPFpgHeNmHyKHIGCnUFtmJxuIC7cvM5RJHlw0WI3EyzQVkLCecXFOfy0dG8s3qlymwdQ4nLOYfkeraCABHgHgIKmNj1VrdwT0kXdvqBb4J6LyAyMay9ec9vJZkm289V3kMunpQQpeOC2K5ANFl/OCHQe++sDNOCTHC48aTGh6QTkpl5WDvy4BHMsEMFG3PTRyWbrqW/h2e5Vw2TXrOnCgGGNDjB2Rom503WscttMSo7+UsoBrzaT0SEA79TM7xC4SbwPgDPTuvruNU5lNfuajNzL+k+D5brFN1ZRVZ1CMbbaWCE66HgI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4421a7-2341-4758-7c56-08dc5d8f7d38
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 21:03:24.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opaTh/NEdU1Fa1b+E7qrlL3om73jTt7u3D48bwe3Gm/1Nx0tLkKrXwntzzMsurcUcyk4S1UNtqU+cGiXeuStCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=819
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150140
X-Proofpoint-GUID: 3_88k8_ghbfXhqcdUzwm_hJXlMh_-6Ya
X-Proofpoint-ORIG-GUID: 3_88k8_ghbfXhqcdUzwm_hJXlMh_-6Ya

The following changes since commit 10396f4df8b75ff6ab0aa2cd74296565466f2c8d:

  nfsd: hold a lighter-weight client reference over CB_RECALL_ANY (2024-04-05 14:05:35 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-3

for you to fetch changes up to f488138b526715c6d2568d7329c4477911be4210:

  NFSD: fix endianness issue in nfsd4_encode_fattr4 (2024-04-11 09:21:06 -0400)

----------------------------------------------------------------
nfsd-6.9 fixes:
- Fix a potential tracepoint crash
- Fix NFSv4 GETATTR on big-endian platforms

----------------------------------------------------------------
Steven Rostedt (Google) (1):
      SUNRPC: Fix rpcgss_context trace event acceptor field

Vasily Gorbik (1):
      NFSD: fix endianness issue in nfsd4_encode_fattr4

 fs/nfsd/nfs4xdr.c             | 47 +++++++++++++++++++++++------------------------
 include/trace/events/rpcgss.h |  4 ++--
 2 files changed, 25 insertions(+), 26 deletions(-)

-- 
Chuck Lever

