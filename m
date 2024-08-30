Return-Path: <linux-nfs+bounces-6053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDB966440
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADF42862FD
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3561B2514;
	Fri, 30 Aug 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eR3EHgdH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DaVs6iPL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CCB12F59C;
	Fri, 30 Aug 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028423; cv=fail; b=QJqU/iD++EmPVQzgPAOtr3AOeV1vgzMvZfHoVrMkAdxaZYbA644d0Cx23R9jxeA12AwQPETIaqSYVUr6hwF9THYPBGAPbgkjvA4WMfFPyEpYbJX+13cZ2QDSJPjFnVAB+0HP01tHGAgpMDX1nx/hOPsvOwMVXLUpxUvsaZeNofk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028423; c=relaxed/simple;
	bh=QnHP2viuF6lYad6qP67sOvebc22IzfL6llN23nBjBcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SBcyP4+V9dYHM1k51c1/1Qhn9WQbqvDLfPHJ5JRr7Cvyx1v1U/1exWwKVE8iwkt/YB/TLfWr8WL8k8LNjB1+D/MAUaVKbcKiSCHvvaq1QSvuFbdo9e3WqDv1HOqTrSmW3SG1vkjEVBSLe7IloKWQKiXhjvGyyWA6QbjsKeylr3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eR3EHgdH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DaVs6iPL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UE0XEH030883;
	Fri, 30 Aug 2024 14:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=RCwiTp/fhq6Z83V
	XiDhK0ka5ZZ7hldyQI9TksKj3CC0=; b=eR3EHgdH40/mfSwEBbUjQ+0Pmtw1Y/w
	82PZwEobLRCC2S6n/+Uej6sZ6sZmhRJ4dJ+vVGio39Vg3ZzokDM0pFC6+4C9efN6
	o7y65jSXniOR/WifPe4GYa3xNNow/JoSWttM3Ye0+TNiRDLaifJq0SRMmDb/n4G1
	4ElXej2U+pCp7XV2o49XvL4LYrpijtHTJiuxqCMGjrwBqmO0oEfPXHS+VGhP5LHK
	iXImBZbG/CkxQ9Q2bpKSMyHwJaYTZBoPjbFS38JgixkxJuQzZcN6+ayS3dKMFX3v
	cdSdfo76BpFoyYBbz7srlZqoF5JgaDtZZAAvgnWOAil0kvOpt6Fs4rw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bf04r5e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 14:33:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UDTXCl020303;
	Fri, 30 Aug 2024 14:33:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8rw2vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 14:33:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iheh/spuNdTDadN1rXyOZshMYyhYt17SplL9l7YGzRWSRmBaachorOC5/N+dTZ9QteUWIUEg+MBomrVWHIkhv6VRCFKRWduHyU3M8NVzt/hey4/EkyUvskMecgfUPiTLNvhzGi0uzkvtCRg+8/hEeW2fnALL73IPHtd0bel6HD9wTTVYeFEgLxJpTWZNAfoay69gb6Ix6LjAaL1efn9Aa4VN/dJ5Y6Ct6ESk7qGf6V1FOldpH1Ry37BlpSaGQmuws8kl7Yvw57Pk76xnqTs2KkMwGdpUZ+tWHhKIwKP6nqyHW78NnYHdck0YQsebLntgEXycX2vc+lYg6waowAtFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCwiTp/fhq6Z83VXiDhK0ka5ZZ7hldyQI9TksKj3CC0=;
 b=ByDuISl7r/SQGl9x/xhhof4rowHa3Oyj94runyVH9kzB0/176VoINlCRTb4IJgDwPlyzpPG3qEpSeWRGcH+poKZDZZ+VY8wVVrsR/l2hvxxdzAPZf7yoTtC87rfxg3yeTFvhtx65/bn3oryM1IAQW2XMtO9a6SxUAgng5CmqeuWUZxZBdygzYt0ddK00JpJT1b569RiKgMHySYux7M87CjARbxSmMTFF/RZY9Vd58gSEzczbP2nmWz8BSOC9RGFARxkNHhUUij4qL33HQU8KFOZQtu7kVRXBXHV8iAkzXF7GboCUnOL7v5IBSq6pWP629KnhN6RGW5sNwuGUgtR5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCwiTp/fhq6Z83VXiDhK0ka5ZZ7hldyQI9TksKj3CC0=;
 b=DaVs6iPLah58mCxtFZ5WyONo6vQ6YRy/Vj0VcuQMk9S0QCO642hUoAaUD8kaUgds66IYqN+I33uW0GU8NZpDvo+MQdY953pV+5OrTPHWLMcCkEfzY25CWqsHA3filDYGqSPjFvI3RyKHJdLOutSYUT3piBsOiW2G83MXjQXmuAw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4444.namprd10.prod.outlook.com (2603:10b6:806:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 14:33:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Fri, 30 Aug 2024
 14:33:10 +0000
Date: Fri, 30 Aug 2024 10:33:06 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: "trondmy@kernel.org" <trondmy@kernel.org>,
        "anna@kernel.org" <anna@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "okorniev@redhat.com" <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, "tom@talpey.com" <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH net-next v1] sunrpc: xprtrdma: Use ERR_CAST() to return
Message-ID: <ZtHYIv3EDQWSf8IC@tissot.1015granger.net>
References: <20240830014356.3465470-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830014356.3465470-1-yanzhen@vivo.com>
X-ClientProxiedBy: CH2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:610:20::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 265c837f-251e-4a4d-1957-08dcc900ac4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c98aPs5ICA5COJJhhla3j7xIcfHk7SDs2kz7O68+emOjFgi2RYpUhnmcxVdD?=
 =?us-ascii?Q?6pPQ2YwD0Cr1PJZDtCciZ86pyDBVEmEdHnl/yn6axqN5Rz8dZXPTNBAaqDL0?=
 =?us-ascii?Q?NclWZkAzTW8BorO6hwfAkWmMZ2o/HgeN2nbUSHS2XAhZB4aHRIrsic0AJFmo?=
 =?us-ascii?Q?t3pM4XccnBxq2V7fRegpBCiiB/evvpnrajBVs+DAQdKjXpu+UWGVdz1sNrGZ?=
 =?us-ascii?Q?5NyVyw3MWnvas2QRlfp5OPowQOVrnlrsMFamYpA5FP58eXW+Ecso7wKX7qaA?=
 =?us-ascii?Q?UYuYATHsysjHJ/dRZyFpOwiXcOsGUO0szSZLKHJlh+3UepjpyGNBmQkj3vGp?=
 =?us-ascii?Q?/Rj7JgbzOSeJeBXll1q6MnEL/QPdUBsS0MbNmafJbnsXbdfAXnaYCkkgJT5Z?=
 =?us-ascii?Q?xR/fY2JnkgCLstKERPazPj8rjQ9/mFXBDlSVWp04r/V8jiay8Iyfa+pexKiA?=
 =?us-ascii?Q?v62D+036Il+oj+pOmOuk9aDJ470AXGhEmlpvqB09Q4J5M/J/pKyqCl1TxN5F?=
 =?us-ascii?Q?9Zq1XodWEUbmfhZsCksUvRaZ3ZBWIV0P4J7Oo6vFYhC/OkTOWvVwDr+2bAvF?=
 =?us-ascii?Q?uyCZuA/I2QsFVaWASv0sAfEz25Dyy2iXnG/oiBX7LhmBpZ5Bplot5GDTMSxe?=
 =?us-ascii?Q?mMtUnjSC6ztZblIy5iu6J7HKMwGWga9l+KC2JlHkatRg4yUE2sWfGXUiRQq0?=
 =?us-ascii?Q?6SqP0SMXAcqq6ujNNEM7lEpJty5/kwqV/2oLB5uFDjW4uiHooOzG9Cn38gd4?=
 =?us-ascii?Q?JYei9BCqd7RixhM+nFWeopEm2f9fS3kd/oXz4hNPL/vHJfZ0OOjHX0itNwUe?=
 =?us-ascii?Q?bRxYjzPueXyexf8Jm71eex7isMPJPfOZULQ8DR2OyJ51CMjZrvmsrN4BrY3k?=
 =?us-ascii?Q?O2m6ACfwYOt49iqnLKA8jEZj6d364SUraCMf6sc8cYlRunnyR01YPjJSZBxo?=
 =?us-ascii?Q?5wsaPNM959GCkAMsox93t4WGgUPqPdmQWcuVLJLneDTgbtua+FaCRxUPbeJD?=
 =?us-ascii?Q?v14mGxEJUUnplC61HDwfvYB760l+QuWPiB5vxYUhSOGd0o4qctkavkxwg6Y5?=
 =?us-ascii?Q?1uVBA0qkRm0ecEPJOS9jm8kRD9w59Ga4VuOqpzZZ/OBXsDRv5iZRuZs1trih?=
 =?us-ascii?Q?GBYN8blX7jQ48KfV1AAZ5sA50hiRFucETrsuzmoPig25N5zHcmGBI+eWZX4G?=
 =?us-ascii?Q?4sNb/xkFAAIvyebJV1uQVHeQR8+2Aqdl2MOif6p6lF8LNN8NenL0Wzpes3bb?=
 =?us-ascii?Q?tKrcp7GY+Vzkj/a8xQCxwc0lLQphySfeApVhFOPVRQ4D46of8ernqF61oy9D?=
 =?us-ascii?Q?pCmxzo8pqHkr1K3yvcX9Onogz1wSBFrw/cSSvmcFOjqY8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YC5c7cX/vyB1hlAov7re8WFv9XB2SxJr9qNEBMd4L9o4mwzeoot8VoJOOxyY?=
 =?us-ascii?Q?VGOPkAOCM61Ae0nQYSg1178WNNE31gnclqXra0hH8L4rH/H9XmqvzCXQBpuV?=
 =?us-ascii?Q?mbbNZyrOux+ugFLANEW89dmR+brI5DnEE+mwdbUH5mIOjgqCQQyMtKJdY0cA?=
 =?us-ascii?Q?FrZEVCBZYy8ycWXNu9qcRRgSCcJdtq3Kd8w53IRTD48waSVzBMtDlUY86cxF?=
 =?us-ascii?Q?m/WRWm2H3OQJ8RhfeD5jIjFJjorUNS2tqmmRCS9ta2PEwpfzMaiDF5089zOy?=
 =?us-ascii?Q?yXDfsUoFGWidqLPDzchG4+0oesTsutyGi2/EhjHN2LPtySY/lPuO+o2Bxi6G?=
 =?us-ascii?Q?iRznSjPGLL9rHeRTnt1pR3nmhbK2yqfs/0xXxx24mh/s1XZ6RHInOfLgpAB5?=
 =?us-ascii?Q?/vF2uYppWOjzVtvZCYNQx3li8WZsB+YdkJK8CLarCqX5FpHnPSRBxdaVaCA0?=
 =?us-ascii?Q?dlMjOXHxGNAnC0lrGCIpbRLD2ex+LXt4N2VzLu+/eZzvgHbSJfAtm30KP/Wj?=
 =?us-ascii?Q?sJ5BP/Tg4h5cOE8+NMl0QLvfJCrAN5r6i55LwYTYWCTlCsncLk5roRE3sKnm?=
 =?us-ascii?Q?got4G1idcTzl8RhAwzKvTKxUhE9KOeH/UB3j5sM+KyRl5i2/BcaDi7uwJxEj?=
 =?us-ascii?Q?YCZ15iAN9lYalgM+TZ7MeXcONQFc2ObmGJkkKF1KURKoX1SjblAq3UvH2kwf?=
 =?us-ascii?Q?lCS13s06crU9Enlnfi8No9LIpMhKVYNXnJe8v4Z4wD+qE6yrr5ESZbi9jE1u?=
 =?us-ascii?Q?bayR5xCxqo0NyOnTdTO++i+mYcOQPA0hpyh2zOft6mE8yltp/eNCJC6ybCpr?=
 =?us-ascii?Q?Qf1ySXnU7t3urK8zhO91N7sIkhozPuQ7GA5hn6eiihYOn+pD7KVAYDhAhBpY?=
 =?us-ascii?Q?ws3o0cnkrGTrUDtojt8Oiziv95d0g4zmkIixE0kd/MKHRfwpluQlnXWsrgsK?=
 =?us-ascii?Q?a6XGnBa9NAVu1FhAH/RTE5D+T86qEvPviBG7uf1M63DmPKae0ZMcFAhzYSM/?=
 =?us-ascii?Q?66XV2cd1AgNLUjDWy748bHbXGYbCYjgCUUN3JoDf/uJgrPb+1RGjzkiz/JUK?=
 =?us-ascii?Q?2XHjVh9UqGZx0HCV9NPO5s3EYfgpTTk3U9Lg20iypreJsdw3TDy+JbqVucrF?=
 =?us-ascii?Q?kF4RRddDKCS37q7WAhKW+0yiWwu5HApn04pL8MDmxD0iHCLVD/StUHylzOHs?=
 =?us-ascii?Q?7DgNKcbGWkXrGCnZU7eDWF8pKeoLI6R4fNir1vwTcpoct/dfe3Pk0iwieKu1?=
 =?us-ascii?Q?qfD0dVZfvxMp6GIbQrYNeHKNMKGDaDHbsy5TcBNGCw8q0n29Do02H9oqWU+t?=
 =?us-ascii?Q?Lw5sIpwvHr/uhOEsC9zjO8gQ7h1NNvCMFRunCn4JWJRDCyyVbD7b+WisBy/V?=
 =?us-ascii?Q?9fq+Nkt1dTQ+VZt0I1EvWnPT1XYwxymQItARfquKlMm+OWFcGgDwyC4QO+NE?=
 =?us-ascii?Q?XixutqdrFk23/Jha8tIPElDuG1D32Tyw4NlPILbd3r3UmzdbFEtDo7utplVI?=
 =?us-ascii?Q?rtbITwEnio5EUKe47vf+VLi5aWh5CX0841nZG4cmxpRQ3S4S0X3dm9xVxU2O?=
 =?us-ascii?Q?9gOOuEHFR0/pDO6Phmze5YMbpSQKtSD1t2QwOyYzMpcohhn8RE/HJSyARQ9c?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OP+PzTnMtyW4PR7T6cGxxtWVhfrG1STKi5buZjpsG6iK6xCAoe7AMmc6KRVlfk80MxsfcCNDMRMmdt2p7ce18T3/FjCHhJR69ZYpU3WwlgWeA4xOzsccDGYy0sei/GDBL3wnNWjvllZ2OE6odf2jkO/59oK2yKWm2KjY4DPz9IcasZvcmrLCBkZCqMMu/zbTJiBS2ODmcCc2lMFuIm0j1dsxXpaDsiONETtcQHVPMLbf1Vo+wIojOS4Q4HbcblY8EibnWDZJYM4LVS9Atf6Mdvj3Nx8+mn6f/LjoLW471bbivZoJ5z33wgZmNZRzchDRzv+I0N1vUqCI6txfG4V/SOeoa7yKZY8cy0oO8HjDDr66i1thF9hASYiS/1ZkL/GnNoqhz+X+6gLeTQsGiwD89GEtzqcUKiIu4+t1sw2cVl5DRrV0JlG1cKIGw86ja+7K2kxAXCFj76268XelprGyY+HDrQdoroWwLlcyYUWJj+IMNIVy8TDEZ/wTqgViQHCCh1MQCz3EYorhwuKSc9izaC/VOT70gYaXmFm9B/nLALcm6/IXSHdQh0NCsNcb6Fe8gRdXuwbfC57ToB+zPNIt2JzbwZ5DqfqM4F8LKVBw+X4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265c837f-251e-4a4d-1957-08dcc900ac4b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 14:33:10.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpGHmqLU1ocu6aiPRxy/vI1zsXFbQjB3BZE30WQd40/kMifnk3FIjLaKR4gG/NR98f3BE/jYjGPDWYjGefCwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_09,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=885
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300111
X-Proofpoint-GUID: l9Sy8Hzhs_gfhaFn_gxFKBNyGo77Na39
X-Proofpoint-ORIG-GUID: l9Sy8Hzhs_gfhaFn_gxFKBNyGo77Na39

On Fri, 30 Aug 2024 09:43:56 +0800, Yan Zhen wrote:
> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.
> 
> 

Applied to nfsd-next for v6.12, thanks!

[1/1] sunrpc: xprtrdma: Use ERR_CAST() to return
      commit: a1499a6890cd3551e9b04c3ec55774236188cc62

-- 
Chuck Lever

