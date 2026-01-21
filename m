Return-Path: <linux-nfs+bounces-18269-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIXUJs4/cWnKfQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18269-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 22:06:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B3C5DC99
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 22:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF381801727
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76683D4113;
	Wed, 21 Jan 2026 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MP84w5Mu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="brVCl3Nv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C62528FD
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028188; cv=fail; b=r4i2FhGnyzcroec4SFQcQyf9fqhdEJ/b4RZq+2d9+kyzZMrEm++GFLEW+KfNtjRP+8P5VGCwQ27zmjEt4FG+P7nl717iuEeLM8T7hFX+v9Lm6mByw2sDrSi1AcP2Nel0mWX0NFu9z9koPcWVATj/GetidDjWMAuU6i8DY/KbSuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028188; c=relaxed/simple;
	bh=iLUmUoowPCxxYqocKD1u7Yu6q6ES7wTTgvqjGSFSWFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TYGb5P9MTpbZ5LQ01xVebpg2DvhGBKBv2B+oH3ECv3/7VGzQQd3Gq4SSTwcd+bwTNsfMypjgTGBb4NRr/BRNPGWW41FWRynJiGfDS0icCTSn5cnx8Gm9aaYaZyIUGCBzZ0ZFYDW/s/AI8UKmH+19bMgEFXYyt2iv4oOPBAthXyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MP84w5Mu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=brVCl3Nv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LEM33i3029053;
	Wed, 21 Jan 2026 20:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Rxv8hA+W7KLWXhmmKexj4wCnRrtMn63pkzGvgblaiZk=; b=
	MP84w5MuYeMQStRIS7zTXNyh16c89nK2jMEMxxGpUUWyHWUjik5V/W7AeygfxQjm
	/jBYck1mvZ3jvDq9SvvGdxWCboDkG0tG+ARy2eHuckH41PFhyoGUS/Tj+YJRsaya
	3ExyDUt6e0i3kD+GnpV2lK6p/il0GmjPPNmZ5BLk+OQbQGjvPSi+fTcjJomhxviP
	C3nRdex8zR8QOcs5DKqxT24RGzSmBRb/B8yRbTORkGqBYKzlGfSw4oH54VJTu+Cx
	r2HrMr0rT6pC2t0h/mVDvmNtWcZazlhNGSx/6+b8mu5u1vhGtXSf5w6Yn/+3aa46
	Fs/9hXGHNJbkYAVf8BUOCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vxn0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 20:43:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60LIwaH9039561;
	Wed, 21 Jan 2026 20:42:59 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vbsa8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 20:42:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syU9TRny0Ijb5VLZu+FzFMRDCMrsfhVdrV3KhYCIKneuvgQOzhUSM7cby07OOUWAmAt93TaWk6ydxrWGcan4Kp0dioPkz1TuHOYOlHtHInPp7g1T756Z7GGGAmg+4wNLhws0kMEJ3FCb9ocNOOwT0rOADiWgoxH1lqJpHfwkcZnf+0rKwJBPJ642EQxLNL+5rBVoat/kh/oKB/URFXv7HWZMMH9CzuxIiEqZAeenEO2Taz8DQgDa4p3tJcKgWrLNzV4p/R9xUn/bEC8dGiS0kWa9uAEly3S7Ll2/z1r6COnWqOBXeFL4BaT8xg+/C9j14Pa68PXeJWwAynHf02HO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxv8hA+W7KLWXhmmKexj4wCnRrtMn63pkzGvgblaiZk=;
 b=GgCDrsW480NO5gwxxZ+Sc3hA5pRPE6oNpdqS+z8K+rcWtj7gm7H/7Tuy+YZQiONGdWwrK/a244fsawYBIXp5MZB0LKlPsWYeQox+QWHg4AaiIia+CNneoyWC5cFhqiSMIYa+93Lty3JSr7dJotXMuenf4/v3ZJ5wNaU52ADv8CRbcEXzLq+UM8r211Xc6r6d3Y4pSH02ovq6eBLLEyFnEC+hDQvcwJx3SEjaTZz8sOTDRYOO+50ZZqnSl9a9k2kCdPC9I1v7GO0Cql2o9XrDnodKaM1CiLIDChgEV+juFHbhuRn61a5PyUgIiSs0boH0j+qOba9gp8SczkXqkoMAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxv8hA+W7KLWXhmmKexj4wCnRrtMn63pkzGvgblaiZk=;
 b=brVCl3NvdbDSrx24XLtefgdiI4egq9AyuhZMoCbWhig9TIRcBOirs1gYW6HY4r2OenHMtYcncMFqrMaH/gfwCXvxabv+fqIzeESsAN/Ug3GKMeJ5UAS1Y6dqDAyiziiOJRjEmxcRQ+45iTKtnvxEIBTixSdVDxFpx9O/nSp7X6Q=
Received: from DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) by
 BN0PR10MB5159.namprd10.prod.outlook.com (2603:10b6:408:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 20:42:57 +0000
Received: from DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed]) by DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed%4]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 20:42:56 +0000
Message-ID: <7e56ed04-0299-4386-94a9-890168dafa0e@oracle.com>
Date: Wed, 21 Jan 2026 15:42:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: add a LRU for delegations
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20260107072720.1744129-1-hch@lst.de>
 <20260115162437.GA17257@lst.de>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260115162437.GA17257@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:610:52::35) To DS7PR10MB4847.namprd10.prod.outlook.com
 (2603:10b6:5:3aa::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4847:EE_|BN0PR10MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: e2198121-a794-4d8b-801f-08de592da7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHU5TnVpSWpNZEVJc2hIWExvcjNzclU3bkZEcnRaVVYzV29DY1pjSGh4aGQw?=
 =?utf-8?B?ZWlRbUJmS0xGTTQ5NHZvd1RRSm9vaCtzL29nVURPcG56VWpXenBENUtuYTFj?=
 =?utf-8?B?YmFzZWhmL1ZtS0pmOUxuUzdyUWJRUWFJRjdFMnFPb2NOMkxhb2M3NDBxeEJD?=
 =?utf-8?B?WmYwWkhqRS9NR0p4MlNjNHhPZTFSVitsaEZucm1laWJ3Qnl6MW5EUnpFRzN0?=
 =?utf-8?B?NU80TnBRQWJVUnJENS9RaFdjTzhzcTJ3aGc1VEx6TlFZNmFUV0tpNHVZaW1p?=
 =?utf-8?B?WmtoY3Bqd2xTVEhTUHl6MitpRFN2Q2tzaWJTa3RLeGUySWkvS3dzcUFHdzBS?=
 =?utf-8?B?YnZuUXhFcTZMWitzSXJ0VzFvV2hFOEJ6YVZiOXoyQnp6RERBNi9JYmdpbndN?=
 =?utf-8?B?VXdldlNTYWp2ZHpLV2hVbVRodFJLa3hjZGl3Yi9rQ1hRQlRlZlpQbEltYkda?=
 =?utf-8?B?OStuOVlJN2NJdU95MkxSNEdRQjdacjVmSTFFd1lESkVJNFJQK28zcHpSSHcv?=
 =?utf-8?B?QVhySjRyN1F0QThyOHJiQnZFZXVjdFJNZ2FoTGZQSGpvSjRVeWR3eVpabCt3?=
 =?utf-8?B?U0V4TmZyRUtEWFdCRDkwSGd1bUpBdmFzcXhSWGtyeWZUdGpxaWNOdVZjNnR0?=
 =?utf-8?B?cHJVbVV1d2wyWVBGazkveDFqZHd4NE1RU0pCR3R6Sm5LTGt0QlI2Nlp6QURn?=
 =?utf-8?B?dm9hcHRVNk1PWkU5MENmMXBzRWJIMHZHQU1NWDJVSHpPanZRQTROdktneHBl?=
 =?utf-8?B?RkdxSElmN3QzNW9RN1NFRXZsQnVKblpBRmYwWjc0Skl0cWkzRU9iWVFxNkll?=
 =?utf-8?B?WER6djBtQkNRZUZMOHNyb2VSNDVyZDkzdGNxSEVNcjA4c00rd2QxVDRzRmRv?=
 =?utf-8?B?bEl6dmVmMDlCUjdtU0xOcGtRaGdjZU5iTU9MNSs5alRDWWp3MFR2NmZLNDlM?=
 =?utf-8?B?QS8rVzIzMDBkaGdqdjVjaFN1QTBOTUsrSlhNTTkybXFZZlBkekUrdFp5NXJS?=
 =?utf-8?B?bnRlelBHdjdnclgvVHJhbGRpSUVmZEp1VVdTd3RRRDY4NjJHRml2ZXY1cWFB?=
 =?utf-8?B?WHdKSHBzVHV4OTRUcmVtWXJXTnE4eVAzMGtkT1FPblNHWHlLcUs5VjZIMjRK?=
 =?utf-8?B?dG1MZVp2L251dCtpZVpxdmtxVjRuOEVvdzY3RHpBK2JXamVtOUNMM1dHTng1?=
 =?utf-8?B?bmtBZFVtaUJsWXR3eVozcXRZcDk2emVqY3g3YzlXTWRybmRBZ0R6QjVhc294?=
 =?utf-8?B?cGlyRW1RQWtIVW83OGF3ME5KT00rZnhMbGszVTVtQXJJKzRnTGRVYksrdzdP?=
 =?utf-8?B?dFQ2TEdKbVlkbjhpVnMvdWdRdmtReE1jQUs5MkNrZm1IeHljcUNrWDVRMUlx?=
 =?utf-8?B?SnViR2J3WGtCajByZmhkdTdpRW0yYUxSbEdLN3FROGZXTlc0SS9QclhnVFZZ?=
 =?utf-8?B?T0Rza21Xb1VWczJBeG1jR3NHaTk1bXpFTm03OG1qbUxzZlhFMlUzaEtXbEkv?=
 =?utf-8?B?dk1nOWN4RkgzZEZoeTZnY3l6dmtSR1REMkN3cjByZmZwb1dKTndvWkJrQ3dP?=
 =?utf-8?B?UzlRWVpyTVJ4QXF4RCtKMFBlbGxJWU56bUd1aXNqMS9PVFFFNyt4Q1J0cm1O?=
 =?utf-8?B?MWNSeHlUVllBRDQzdmR3TE1GSDZQLzdJSTFlbUJ3SzFGM3prMUhpbVE0cUxv?=
 =?utf-8?B?UUdpeTdyVE1aT2pBM1VxU3BmOWVMblEvZEk5MDVqT0tNOE5LRmwzS0VoblQ5?=
 =?utf-8?B?YzZnYTVXcU9KbEFvLzkrdkNQYm83dzlmdk5pS0RSVmJJOU1QMG0vQlRnMDh5?=
 =?utf-8?B?eExSTnYrblUzS0w1aHM5SHJrM0ZEc1ZwUUxlcmJlVkk1RkhNbndqZUlzckpi?=
 =?utf-8?B?eTRrOGJpNDdldGxRSHdTbjJ4Ti9aa2FOWTB4N0JoN09DVkl1OUhEeDFDWk5L?=
 =?utf-8?B?ZC9RVWYya1J0SmIvU3NCZTFxdFJrT2V6ekl6ZW9VMmtZU1pCWTZGQWdzaTIx?=
 =?utf-8?B?NGZVOXdrOU5seUJTbkRNb09WV3lmS2VXQ3BNeG9zSllpZVZzQnRPYSt0WHdy?=
 =?utf-8?B?SGIrUUZLUUIxNGRRYWpHZENYVGpBdVhvbnFoL2M5dXZPamNtbUZFaHBaUjRC?=
 =?utf-8?Q?yXgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4847.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFhNdVhhMEpRenRPQjhZWUszNEExVFlGYUZ0K1kzQjduaUlMT0dFejdLblFI?=
 =?utf-8?B?SVQxUUVFa0puTVp6NVd6ZUxiYlFFN3VDSzlHbmFEZkJMMjRzaDJqL09CWU5o?=
 =?utf-8?B?R1pFdnlDdXVDR1V2ZGFtcm5RQnlqc1pya1hMTUdzc3h5ZjNyTG1yV0Fxa1R0?=
 =?utf-8?B?ZWlDWXBya1l5Z1pwbmdtWjNsblhpRTFha1RPTWZIMEJyNlVDY3BVYzBndVBt?=
 =?utf-8?B?T1VSQjgyZGF1dFdxL080amZYMXUrdnpFMkhJajhqUEc1M0VINjJHYjVsRStv?=
 =?utf-8?B?dm5OU0t2L2ZIOWFCOVdYZnk4bUlISkk0dThBTGxEVmxvbGsycU9URGdNSzFZ?=
 =?utf-8?B?K1d2ZzRDZ1pIaStLeXVLZXFFNERGZ2lCdWRZZFUrZDd4eGk4Nzc1MUZTU2ta?=
 =?utf-8?B?bzFSemZFazU5bkZoSEc1T05QQlh5b3I1NkZtNXFWMmZJWnF5NGhIUjZVb2x4?=
 =?utf-8?B?d1ZLblVVd2VkdWZEWnNFaTdsOGhDcmZqUURIRWZEbXcrRHljN1NHbDBDRlhX?=
 =?utf-8?B?eVVpUHl1Yyt0UzhsVlM5NnFvUTlZalgrRjhZVm9xcEkrc0tIclZwZEt4K0ZN?=
 =?utf-8?B?a1NibThPb3NTZm5pbzdJR0JpRHdvM0JETVNzbGdFSCtTTXNoZ1ZPUEI1OWpU?=
 =?utf-8?B?VEpQQkM2QWtJa0dZVGpEZDkvS3RScUhudUJqa21qYnlzRDZrUUJIVk1VL1pX?=
 =?utf-8?B?Zkptb05FOUwrL3pPUWhRRUNtSnRtOEdwN3RONml3Tm1Yd0pYUmg3Y1RLbm96?=
 =?utf-8?B?RmE5bVIyajBQZkxYNDlrZldyWEh1cDM5NUlJbWYyd0IyY2lZdVBuQnRQd1dj?=
 =?utf-8?B?QWkvZjY4dVErdGJqZmhzY1hIdVhlbTNCTDlWN0g3T1BoMHpxMGZseTR3d3pw?=
 =?utf-8?B?Yll1YXBnVlA4Yk9FVi9BUnpHRHlaOTlJKytFSXNvekJpQXZZbkR0WEJnUTVu?=
 =?utf-8?B?MEErSUVGU29PcTRHd2Jrb1pZS3VMeTNaaXpEdUdpRzZBOHlLRXRnSUh6RDVp?=
 =?utf-8?B?S2lsQXhkL2RUR0RNNEVpQVlCT091Y09pMk1XY0VrYkIvcldaQWl2YXo3N21P?=
 =?utf-8?B?aHRYSlA1eW5CTjduSlFkNmN2dTFEZk5EZ3JPcHdVT3FVc0JZeU9DT0dYSnpU?=
 =?utf-8?B?c2lQRXpIZktRZFZZaGZyM3ZOQTNTdGtZdzd1dEQzMEFSam5BTldGS0NsM1J4?=
 =?utf-8?B?TUMvYXFmbnZBcHNqL0JBK09yU2xzcVVyMktuSmZzYlhuNzRvR0JEQ3psNUJi?=
 =?utf-8?B?ZHU4WkxTeEl0Tk9oYnJCRENSNys4dERrWllRdnI1WDZrejFFRGZSdWk5R0VM?=
 =?utf-8?B?cWJMYkQwQThHQk14dU1DbWJYS2NiY0tuSDFPbktzK2tmSVB0NStkVDQreXRU?=
 =?utf-8?B?djlJM1pNcG4zckdST2tGeENKdzRZS1ZxS1RHakRFMS9xMVRQVk1nTm8yWU41?=
 =?utf-8?B?Zy9UcVNYN01WbDJsMzl6QmM5MWM4UVhCR3BNNld6dDRBMitoM1dQZkp3WTBE?=
 =?utf-8?B?WnhmbkNTbEs0NVVFZXJJNnlvQi8rSnh2a1p4M2lpUk45Rmh1WUU5KytITTgv?=
 =?utf-8?B?VEtUSWNjbDRMK3NvK2x5dy8xVVhDUDBGa09pSnNvZTVKMVVUUjZhYXdCS2RP?=
 =?utf-8?B?bFY2VCtsUzVMWHVqQ3pGSVF1Umk0c0ZFcXZrR0JhWVZVQmMvV2RWZGYvS09H?=
 =?utf-8?B?UHVSditjaDJTdCsyUFpVTTFFMnRzdlVVZklIZTAycDJCUkROR08xdk9yNjZi?=
 =?utf-8?B?cXN2VHRyMEVsd08zaTAxK3pRSndTWC9MbE5saEQ3dWI0ME9nWHhwV2F3a2hF?=
 =?utf-8?B?Zk0xWDY5UHpvN3ZlbTFvQ09yS0t1dWJ1aG5zQjliLzdrYU1mTnBQRmUzUnJS?=
 =?utf-8?B?NG85NEFSRUsrdmowY2wyOVNCVmp5NW9YVDlvUHd3RkkrR1pXaTJMNW92OXZk?=
 =?utf-8?B?REZMR3RnMS9rUnIrbXpWMG1sNUhIQ2JiWkczaExJNWdnM1d2cXhVQkpidG1Q?=
 =?utf-8?B?dWo3bjROTkFid05vTXBCbW9teFZmOWs4UjlvMlhaQTZvaTlBajh2U1lCR0VR?=
 =?utf-8?B?ODVRaTVrbkRvQnNWa2hKb0hwVURBOXJpK042Wk1YYU1IaHJITDhudEoxdXpQ?=
 =?utf-8?B?bWVMZk1Md0NxQW15akw3RjV1NnVrb2JoaDNFV0txYlduR0dhNmxGS25TZDRZ?=
 =?utf-8?B?MVR3MUxzSWFrKzNnY0VXNFpLOTZQWk5maVR1TzJhSURDZy80M0ZNVS96ZXdE?=
 =?utf-8?B?SHZpdXNmalA4Z2V0L0F0ZUptZDlYOFlqZWpDN09HNVhBdk1JNXB2WW52VDEx?=
 =?utf-8?B?Q1pNVXJPQ1FBc3BZM3JoNnc2ZDh3NG5YU3A2ZnJHRXhEK01UaTI0RDNQSkY5?=
 =?utf-8?Q?Ym/a02WJppbOByDY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5FUalCV3+PuD1B59PMfgrul2GvThiK8U0pSumlpjGgRl/DWGGZ3iuG8U8xHhBgBajiVHt5GEcgg3zRyc7dc0gr7WXf4wB1ACH6lM4Rz0y48OlEozNJDj/WmHNTzqJMS5uV5ENXCZLpBS+SGwk4w2rOYuu480hhhYpTs8nsUxOZo9F3OmKSJTQMc041bw9FIw56ewZWVWCXM1QcBOUBFJqWOW/BrcEusbr/zh01c/dFSZbY8OVrhxTMXNRb96VqK61HM9fK859CmMrh1f/5LQWkeWCYncoOOTRxgBowGx1UJTqFzWte7U+Nn56YNiM8jeNgRvG+qhOztc2tIgV/Huce0mb0nYmcSBVx7km5YYvFZrg5u3BmzpjDue2pjmJWTpSvoqjP2PEwCwH/Gm+NwdM0o/ONvhtWtCsqkqtN9DqKPDhJpXEvv1BADAi9zskhNAkIlHUMDdXFk34pGbc8dKqBXvplWFvGdaKjbO7n5auctds57DM4hyC3TLbWYaq+J58HERN/0IkCQ3e5kGG06cjZ9Ls8GA/byUO2DZvskO1UnRo6eqodetmk7HbN2XtIFErYcTYM8J3ZuBuT8to+1bPh2D14XUa9/0BWxVrGWDd8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2198121-a794-4d8b-801f-08de592da7ab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4847.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:42:56.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpcD+7tmYVbm4IRJp1oS985itk9VYk3siAV5kJjpe0ocEiP70N1Sh2P38v/tYIahqTNPKhH7tQDZLkH1vyDyR5PDLodUpyD9S/fpnRTJQbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=964 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601210173
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=69713a54 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Yq4Y6B0NYWdngWc6S9oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w2ttD5yYYWNkdnjP8mdWQGVVOHT-wmf0
X-Proofpoint-ORIG-GUID: w2ttD5yYYWNkdnjP8mdWQGVVOHT-wmf0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE3MyBTYWx0ZWRfX8d+WonQ3LuyV
 e9VEfgGTCPOaeytAkkVBMrFdsQ3EEHmESDB7NJq2rmjaQXjYWQlOHuR+KnJ11GiANc5wmPeerU/
 n2xaSHEaZ4CYaVEVwWOjaqj3b4tMeywCc3RBGHPV8UjV8LTG9r66K6ph+7lH0LnLKEdb2lF83dZ
 EuZTLSfbqCDFa5bp/+hq4C0WJER9KJhQVXHk0p1Jp6mEFHftoSHVhlYDIeZIOjvNiGPp0fh6nO8
 hzosuI7Xk8s2HYpR2gTsv+v+eY7fN1tC5oDLZ5oZNvCizvR4gtFW/WrBQlR/txSNC59RxIQAWuB
 DPuTcs60WWYpOJJzO08nm51wf+vxMlTjFXl5eF6ipaDdflVZcXY6ftCu2q2v8WNp9hkG/qbPhXk
 CTIprEcNXOllY9olBSdztRgrV+uIxJve1oSjXk2zOL3oiSPpA7Q0V2J/lVWOA+7SKzZtnY/QzSX
 eqGpEu3Ia26Qc6Y8NHQ==
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18269-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna.schumaker@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 01B3C5DC99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Christoph,

On 1/15/26 11:24 AM, Christoph Hellwig wrote:
> Any comments on this series except how to make it more complicated? :)

The patches look good to me. Thanks for doing this cleanup! I just pushed
them out to my linux-next branch for the next merge.

Anna

> 
> On Wed, Jan 07, 2026 at 08:26:51AM +0100, Christoph Hellwig wrote:
>> Hi all,
>>
>> currently the NFS client is rather inefficient at managing delegations
>> not associated with an open file.  If the number of delegations is above
>> the watermark, the delegation for a free file is immediately returned,
>> even if delegations that were unused for much longer would be available.
>> Also the periodic freeing marks delegations as not referenced for return,
>> even if the file was open and thus force the return on close.
>>
>> This series reworks the code to introduce an LRU and return the least
>> used delegations instead.
>>
>> For a workload simulating repeated runs of a python program importing a
>> lot of modules, this leads to a 97% reduction of on-the-wire operations,
>> and ~40% speedup even for a fast local NFS server.  A reproducer script
>> is attached.
>>
>> You'll want to make sure the dentry caching fix posted by Anna in reply
>> to the 6.19 NFS pull is included for testing, even if the patches apply
>> without it.  Note that with this and also with the follow on patches the
>> baselines will still crash in some tests, and this series does not fix
>> that.
>>
>> Changes since v1:
>>  - fix the nfsv4.0 hang
>>
>> Diffstat:
>>  fs/nfs/callback_proc.c    |   13 -
>>  fs/nfs/client.c           |    3 
>>  fs/nfs/delegation.c       |  544 +++++++++++++++++++++++-----------------------
>>  fs/nfs/delegation.h       |    4 
>>  fs/nfs/nfs4proc.c         |   82 +++---
>>  fs/nfs/nfs4trace.h        |    2 
>>  fs/nfs/super.c            |   14 -
>>  include/linux/nfs_fs_sb.h |    8 
>>  8 files changed, 342 insertions(+), 328 deletions(-)
> ---end quoted text---


