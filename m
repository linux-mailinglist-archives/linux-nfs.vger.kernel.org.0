Return-Path: <linux-nfs+bounces-8125-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7809D2ECB
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 20:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC560B2B6BE
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 19:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6260F1D1729;
	Tue, 19 Nov 2024 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VZsMEW70";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sJhcaUIe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF21448F2
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044058; cv=fail; b=W/6Fuxrcx94jtnufotcrMHIAeL6Qmutijnq+9MD8uD0TRBbFh62WFBmx5T/DW9wTcMiOXYRNpwFz7zbomXtOxji/THmO1KcP6p58Cj5lOKQEe1+flFEQLItZwcaCQRPjmkcisCnvrCTrSzhu8Lup28dnWVQ7cDMM/Qs3IEuZocc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044058; c=relaxed/simple;
	bh=tiWEjMiVshPfhazutt7Nqg5vdGUL7u+KVQYf09gcLXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nqSdynnW+DqM8kzx2OPjcNGPSFT0PR1zcLHxBciEVOkSfJeo+a9rPbpinUKwdWyclj+pYb/O+HcFnefdM3VtSkabfhXy9eOz5J1z8lMJBYbM6LMS+EbT+JoxwswChFopFU+sx3GTfwuTbreHVcHz4RuNtvx7owcwNMOOkY65HN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VZsMEW70; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sJhcaUIe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIMc6a018915;
	Tue, 19 Nov 2024 19:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ZuemUMcVxwUCndThmL
	qA7Y6bJG+P2SBn1/+MKlMvMu0=; b=VZsMEW70BbemmpWrToyv32QcmzzaO4j0Ky
	8XjIeC4n0I7QoPuCry6DI26p05YB29rxff3flB+lduek/Fstw757G2NMk1e3c+HO
	39Po3D4tD3x0Vcv71aFYcG47/lj9w4pDGqmIafdLxUk8hjY+mcSYeSqRF8DUSiP7
	VCzE0vcch4TW9o1Wu9ts0P7BJIerXDentkfUWhVjAFEVvRCVhudu/hdj8TPHuDm6
	qGnZ2wR/VC20fEI3kaAl980Un697rL1ymepGit+c2VlqSicUi5t9aRGseNgc1+1s
	pUhE/yYUmuMty76vH7NYaWyeLWifYaNrXsoqfEpt6+MIMWBu2MUQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc5twp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:20:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIrv42039178;
	Tue, 19 Nov 2024 19:20:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8xr46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:20:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RA7IY193cChntL0zhLyiQxgBayTUFczOPCUwrFZop0rzh5jrwJw+kFJCw+p9ryGWObxsOkxAvFKVyJ8zfKul1vuYHzmLGUImFW/d8m8wBpCTEUtlRSrDD6dTbUW4OlSaFFmv2eZPcxTwcfYuw+Gg4Le0kBC+m/cTd376/rqD+rHzSKrrzhQ4GTBbcpufE6Nrw3B4Ahyxxs7S1qWX5rpDYQMBzYXUN1j9Jrff5qRDuhIuezeZb6ALzVxC4hpuhVmmSPIBrusVfwKSgyqdUTtwHmQoMPVU5nYOucNJ4Aad4VfxAB7W2RRn9mFDwbJQ2KZehPRuR6UmuWx17mtUagno8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuemUMcVxwUCndThmLqA7Y6bJG+P2SBn1/+MKlMvMu0=;
 b=XXbOzQg2Sl+zhxiJgC52MgnbnLYnVkRck2pNgGH2C6+SqUC+0XHlS9KRPuTNGW+BJoMk/ynzAfEvYul+ZkFsMbOaqpqTXIVblQZGzVEOAAEYFdxWa22m3toW8ENLPEnjE9md2DrOdQoA+gZfmogV9HYbsJyyjhWShQ/Pqh5QEED2hZC/WLPvff1czexWEGirzp9Shwz2sRSLTkQb/+nCIY7o6JXHAnUhfkpWHfF9tIgYzmb0k+Be9DHn33TWTX9AKxn3C6cYZwAJrK6mj9IMVsS7GtNg2hkgc50zpXO9kTSjw2NlT/x5wkOGAwAqxwgNEE+ugZ84g4SYOw3VHClOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuemUMcVxwUCndThmLqA7Y6bJG+P2SBn1/+MKlMvMu0=;
 b=sJhcaUIeTnHXUboSqBW4ecU31uzH7KJSa3aVGpMRaQITe9ULvQEZhkApd0WoUgrT+b46OMS7JzXfCqJpVNDe2lSUV/1qMY9Tfe3QzVw6q2IMvMwVAtHCrSlBjmP4sardSQ2FCu1WxkYDOMD5pqq78LdcaT+mPSBVD13h9CEKD5c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4278.namprd10.prod.outlook.com (2603:10b6:610:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 19:20:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:20:43 +0000
Date: Tue, 19 Nov 2024 14:20:40 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
Message-ID: <ZzzlCJAU357ig+Rm@tissot.1015granger.net>
References: <20241119004928.3245873-1-neilb@suse.de>
 <20241119004928.3245873-5-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119004928.3245873-5-neilb@suse.de>
X-ClientProxiedBy: CH0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:76::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b4e05f-b790-4917-ae13-08dd08cf4336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LE3c8bHUmZ0Xxu8sG/fOLiS/5cpFjMP8WhRxeAn5Xex0MDIdraiDLw5C0JRd?=
 =?us-ascii?Q?DrRt4tuTJagPBqRLeaTl5FDd6iLEFlyG1iqYBM82HTiFydRQdpwLRzPfhmuq?=
 =?us-ascii?Q?qBTKTdkxhYoBqZKmjiAZTez0iLUh6PMsm2/Z65ipnjWaPE+gwfPOFPhFyITe?=
 =?us-ascii?Q?vVwISNvjvXytQD35VYOK7uU4tiwHxa0AkX35x9gXAyYm5wnRtcAgmTY7zmj3?=
 =?us-ascii?Q?0CCIojtk/CxKdyhvBqZmW9mqZ/ATRr7ceOXKZ23ftfFRdIXDsxvOJ3q/MURY?=
 =?us-ascii?Q?hnzXh0mgLXv/afhKG4F+6ToWyrwNlyPCTgZKcrjmsJ4FrvXBnCrcu1ciEhS8?=
 =?us-ascii?Q?zPWNrEYWcuT5GHCPGkZJ5PWp82OTFpOTPFbLb2GsowS8Z/HnnXvsNqNbLv8T?=
 =?us-ascii?Q?3AGWBCXpCoc9ujLeFCzE3Yq7nKbeflJMhMaWz1J/MQihMgZcb4irKZ3LeSxt?=
 =?us-ascii?Q?2VhnZDy17B30ZHk5SP1lM84OPl50tfgvjCaMGWQqONl3SlArj5p53IcwtHU4?=
 =?us-ascii?Q?wayA4IiA4XmWbzEJNkwgGsGGOTos1iSCGQ0qetd7ZXa+ofKrcb3Lox/7H3w4?=
 =?us-ascii?Q?QSzJH9e8aAw9pboqcRro1tPp2C8umXtfCJRyjRXZmThDCPCtzY8TyC+XieAE?=
 =?us-ascii?Q?0M8yGrKJaeWQnASDcRo1vW5d5Z3HBb5oFB9Yv68/bPTmK60ZMW78mwoBkRvm?=
 =?us-ascii?Q?kDk1XdMRONVvQ6C63i7kqUjlK/g/mGDAtb1BBjEMUqlPabFhsKUq7b7Yp4EU?=
 =?us-ascii?Q?l4wruMU/Dm0chFqHsZgGyxCE4AwKj9qzAgqPIfbqfT/vBxayMRiD0+HuhtF8?=
 =?us-ascii?Q?p8vCTIw0xDtphJWCfdl6pfsQN1TZSVdIQzTIxn8TdYfCRw86s/Y8sM+kijad?=
 =?us-ascii?Q?UagOSg2tvpCNIRNiq4HziZA/cwQ1TGh10QeXjQ0i4WAdw2Yr1nPymzPWAMH9?=
 =?us-ascii?Q?zBxlN8li09Z0nZcDcANjM1lBcmwD2zIuvRHKFnwkbbtZawo3Ylm2SCVh+BCy?=
 =?us-ascii?Q?Isq3CAoYYFQFf0FNWTolSRlfbrwPBFhVhHlsOQoEq4vhuViGSKBWBbqeaTsm?=
 =?us-ascii?Q?/4Piy6iP8SgqCJY7/nZ3j+Ntvspd/zzAC5pv53gFaT9hnrqAjZmruOaGEfJb?=
 =?us-ascii?Q?rOHZvOXXTZbaJ2ueGR0feveIvlQP7SaXkjf9puVzUKFAnm2hj/yZL1m7Rteu?=
 =?us-ascii?Q?Fuf9h1MR7+7RIXpRfrXgekO+p0CBdoYeSGPq7T5aIzIfYrQrj1Qas5A/vDbB?=
 =?us-ascii?Q?uAEQMkAZafDJc7l4JGvuJr2YWCRZzqfsB7n65nEphRth+iaS9iIywp+D3aF6?=
 =?us-ascii?Q?PpO8ZMTvfieZKOPGnx7cwIdr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XOsElGs24+/N4oqrfETAeNI+IXnOP18JegJWOftaKmdgsagSMqSh+ZUfu6va?=
 =?us-ascii?Q?6rQO2BlWuWaUQPpwCSscpWf+b3y1429NWLy/AwFCgY54yIszDooZ3U23W/07?=
 =?us-ascii?Q?tzMuzHbrDyKcoHyLJ5LvIy8hlwxaogM7IRnUVeQxa/Ia3nkSb+zyOtJQVnz5?=
 =?us-ascii?Q?ARHu2Cz2a0hgJwjdchPI2mkCwF4xHuyK0xzUQ8U+qzA/bLvoMRSYkQFoVYon?=
 =?us-ascii?Q?OQkRGUa1pYLCbHefmNul8lILNFQt2VPkGNILkT8PuwHdxOtCRLteppErPyB6?=
 =?us-ascii?Q?eYopEYWvWmamWnPHQCCSQeJsfYfKBI/R8u1hEwIFg0vGw/aIDgUTXuqb6dUd?=
 =?us-ascii?Q?4sVI9T/+1oa+hhkc4ipZoa21xaM+JPhouTGi41jyqraIk8+OUuKXrY3ESfEz?=
 =?us-ascii?Q?J9HOtPvyWG1DAGAJWAX11mG8f9qFJu+dmNDeaFG93humgeDr5b/iTKIN4/eW?=
 =?us-ascii?Q?4Mh1WxfX7mUDWg3mH5kHBTA/TPfRD2KeTVS0Xkoa17RKZsKGp6cJJsm7eWLG?=
 =?us-ascii?Q?1RrgS+Ul9fKlLg8ReLuHD2IUO+2T4D3tQ5tHbm6e8Ha4XL3wTNtnGvUID+LI?=
 =?us-ascii?Q?XgfgFWU5gxuo8EHn9ziGkd5EFPHhLW+f4SfHb+WljttWq6ROhEjvcvxzpY+C?=
 =?us-ascii?Q?xm+Ev87CnGbNLr0JmEGKE6GsQoIaQw1nSaVEvpQF4sxOdwQkUD2OnJV8BSAx?=
 =?us-ascii?Q?DVT/O8SiT2n0uUakKXc/XDwZNJhQTU9QPxoQdXC0oUZPA14H1jekU04XcTpi?=
 =?us-ascii?Q?93C9dTXfi/tajNszSfGeTd4fKsMMx9+WsQRndAI/7WZ3pUkOABMQ/J0sIBGB?=
 =?us-ascii?Q?GFlQfnt5fuJNLUFM6kpYFWEaIS830HALnXyzC9BMDeH+3Jv2HizY48UnZi4v?=
 =?us-ascii?Q?EK6j3Ggxho3CFEoXj5GDpukfgco5Rt7CwldmHYMUBRfGHm9dqEKiRL/TzvAy?=
 =?us-ascii?Q?8eWnicxgqhxYRsRme82swrozGajMZIHWQShGz4NSkOF8yJTN6Q5jgRym0/wu?=
 =?us-ascii?Q?8xnHd8yapZ5T+Hy0QEG2n0Ts5K7fSXC2pgsfiqqjR++ul/KPj8To/tlfkuF1?=
 =?us-ascii?Q?4hZzweTPr/dv+4uPoC9JfzInKIF+nU2g0WK1ZmaHRvouV6kwyGSi+omR9Rob?=
 =?us-ascii?Q?moveqDyEuGH/QTRC3j7DhauslWx5A8yyIeEUi2dYHAzZqZIm8LRMM/MNiCbN?=
 =?us-ascii?Q?qrqWQqXvZvt1WUpnrMg9a/QpdDLk64jR4exkkZf41CsRPX+rsh2lZnqxbiUf?=
 =?us-ascii?Q?pa1HY7zh9k2s7WL1jIRLOKug8XHzO5xpYNAmT/lWMzs4eRkYtIb4NeZQPV3T?=
 =?us-ascii?Q?aDkygBLFl8liXShzviKxe2/UaHGEAj0fj3bEQljUxbtlj7fSpJavLyWQ3CNx?=
 =?us-ascii?Q?LDSmKyl96LKlWDoLS9o7UL4A36kNhcn+gN2jIsevYdm0rC2F6PT8eB+o2i1r?=
 =?us-ascii?Q?iIhvFarJec/F9hH509CtXGjPM3Kkb8cFJDF5rclG0Dtx+a2QEhevKsr3O3VY?=
 =?us-ascii?Q?Lwe2T7QlQXEqmT4Q5Kj9TKdIS3uXRuWRuWbSHRog1nfQ8nB+iMABdGR0yU8Y?=
 =?us-ascii?Q?wcvvifATli5oztNcxfe7wlek0eJ9W44x4g2ggUXS0lNR1lmKa8yO5BTs2XIi?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Aj38TZJh+fLoEs7zI+0J3LsVfnxwmCignF+rkhNB4g5/co6inY4kYbIelYTlZLFUn3t7YPxwVtgC6i+mRAYoUUDHIuNx/wQK06deHkjlnKS83GwPcrl7UeM+dtsvrAIJIWDz6hNyPjgIO9CjPTJkdJfXKYJE6mY861OKzN/YiEE6/rmRxUcJoRvK0K3r4QuCeyQt2HB8Rlzgt/ohT9h2bqTIAZuaOwN+dYSMC+Lg69bebRV8JFdgtsgugsJkC2EmwTBDk8Xmk6Bm7N6iWPH1jmBkZ3z8DiIP5lmjYOiT5T3/pksEFx35qjbyZj0W+zZL43P+sSi2KMuzIQibHRjKpDyPXNJLW/it6sIplWBWOlFbtAF9LVLHFLmZ81sS6/SquM46UrgaDMaMh7IPzMSy78ADxOhC4IyH81cYtxQw7ShzAMIkwqbZl+hGSV4Oonlh4yBEKDjSmjxlfiEWNk4rbuE3rOBUX515OP6htIlRj7HrrfitbBA7+biJpp0+AZQUDvtmItjqayu/Z0qaPqbLvRrCTLOdgKQMQUJdqrC0DKhnUvNo2JHnYs8RgvWUScjLw7D4ck1UP6HoKELw4xdI9bQrdo1Vp+DiIxBuxAaQnR4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b4e05f-b790-4917-ae13-08dd08cf4336
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:20:43.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqTjs7SVUpWt4qdluX4l52EX/dxikj2xL7BTT/yyrkYWIihRH+++Wna1le7YCmDZ6wqO6tZEUY6yyq/Io0C8vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_10,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190144
X-Proofpoint-GUID: CcG5-MRFLLTXYojciYrGptsoxPKR0_Ht
X-Proofpoint-ORIG-GUID: CcG5-MRFLLTXYojciYrGptsoxPKR0_Ht

On Tue, Nov 19, 2024 at 11:41:31AM +1100, NeilBrown wrote:
> If a client ever uses the highest available slot for a given session,
> attempt to allocate another slot so there is room for the client to use
> more slots if wanted.  GFP_NOWAIT is used so if there is not plenty of
> free memory, failure is expected - which is what we want.  It also
> allows the allocation while holding a spinlock.
> 
> We would expect to stablise with one more slot available than the client
> actually uses.

Which begs the question "why have a 2048 slot maximum session slot
table size?" 1025 might work too. But is there a need for any
maximum at all, or is this just a sanity check?


> Now that we grow the slot table on demand we can start with a smaller
> allocation.  Define NFSD_MAX_INITIAL_SLOTS and allocate at most that
> many when session is created.

Maybe NFSD_DEFAULT_INITIAL_SLOTS is more descriptive?


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 32 ++++++++++++++++++++++++++------
>  fs/nfsd/state.h     |  2 ++
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 31ff9f92a895..fb522165b376 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1956,7 +1956,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>  	if (!slot || xa_is_err(xa_store(&new->se_slots, 0, slot, GFP_KERNEL)))
>  		goto out_free;
>  
> -	for (i = 1; i < numslots; i++) {
> +	for (i = 1; i < numslots && i < NFSD_MAX_INITIAL_SLOTS; i++) {
>  		slot = kzalloc(slotsize, GFP_KERNEL | __GFP_NORETRY);
>  		if (!slot)
>  			break;
> @@ -4248,11 +4248,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	slot = xa_load(&session->se_slots, seq->slotid);
>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>  
> -	/* We do not negotiate the number of slots yet, so set the
> -	 * maxslots to the session maxreqs which is used to encode
> -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> -	seq->maxslots = session->se_fchannel.maxreqs;
> -
>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>  	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
>  					slot->sl_flags & NFSD4_SLOT_INUSE);
> @@ -4302,6 +4297,31 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	cstate->session = session;
>  	cstate->clp = clp;
>  
> +	/*
> +	 * If the client ever uses the highest available slot,
> +	 * gently try to allocate another one.
> +	 */
> +	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
> +	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
> +		int s = session->se_fchannel.maxreqs;
> +
> +		/*
> +		 * GFP_NOWAIT is a low-priority non-blocking allocation
> +		 * which can be used under client_lock and only succeeds
> +		 * if there is plenty of memory.
> +		 * Use GFP_ATOMIC which is higher priority for xa_store()
> +		 * so we are less likely to waste the effort of the first
> +		 * allocation.

IIUC, GFP_ATOMIC allocations come from a special pool. I don't think
we want that here. I'd rather stick with NORETRY or KERNEL.


> +		 */
> +		slot = kzalloc(slot_bytes(&session->se_fchannel), GFP_NOWAIT);
> +		if (slot && !xa_is_err(xa_store(&session->se_slots, s, slot,
> +						GFP_ATOMIC)))
> +			session->se_fchannel.maxreqs += 1;
> +		else
> +			kfree(slot);
> +	}
> +	seq->maxslots = session->se_fchannel.maxreqs;
> +
>  out:
>  	switch (clp->cl_cb_state) {
>  	case NFSD4_CB_DOWN:
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e97626916a68..a14a823670e9 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -249,6 +249,8 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
>   * get good throughput on high-latency servers.
>   */
>  #define NFSD_MAX_SLOTS_PER_SESSION	2048
> +/* Maximum number of slots per session to allocate for CREATE_SESSION */
> +#define NFSD_MAX_INITIAL_SLOTS		32

The first couple of patches did so nicely at ruthlessly discarding a
lot of arbitrary logic. I'm not convinced by the patch description
that the INITIAL_SLOTS complexity is needed...


>  /* Maximum  session per slot cache size */
>  #define NFSD_SLOT_CACHE_SIZE		2048
>  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
> -- 
> 2.47.0
> 

-- 
Chuck Lever

