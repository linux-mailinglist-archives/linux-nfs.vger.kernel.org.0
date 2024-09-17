Return-Path: <linux-nfs+bounces-6527-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 849D397AA66
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 04:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FCF1F22E3C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 02:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D1A29;
	Tue, 17 Sep 2024 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rb7TYmyC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E6BKl2dV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4597D11C92;
	Tue, 17 Sep 2024 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726541070; cv=fail; b=QyIC5rxlxve3t13tZgC1SnD5VGBcDQeSwz06biGe3ni1nLl8gzdwkSHhUn0YKFTGb2WYmzyfIJxzgTdJtf+sA8goYH1tRocnLWy6ummO+f1fNmgUR46n8TQjaDgEhFvbhX5jx6RoU05FIyjnnj4wJ8YmgiDP4ReZmBuaFStI5iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726541070; c=relaxed/simple;
	bh=l+oBGmsb1nuM+yMDuHFP55YXSfwCSrlzRMBH4wBGiVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i+cByduLOpqODB+JXtXeSvoDD0Itrj2IwqFzb/AbW8c3p3W3Za6S33gRc3SpKQvTNOyknxLLiRuSxG4u+Nlya99qr333ELgae9Nob/9LdNH0LDn3QzKcjTHifNxqs9dKvc10Zo1pY4E+cWCGAjaA8QooVVVK3US5lBuk8QCRMXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rb7TYmyC; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E6BKl2dV reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H1MXx1027046;
	Tue, 17 Sep 2024 02:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=ivbvlQVF1f5YJjggm3XWW/+oWopR0Ihzc8PGM0Aq9Hk=; b=
	Rb7TYmyCFpkoSNtIw81PEmYGdfWOTcFIIsUqyInye+Io9AWdVmRe3l2AxNLNUbqO
	d/h+sVFiKteadjXpf3TugMuWyoaT4cOMTLl/fBENcNDy+mowGPxf0blUFdTpDm2s
	u3xBLMOOeneXMDiwTepDqhex1iA2xcgl3AGHohMvRr9PyKjcuw29zFJ9aU/YuPau
	B3DB4sEY1L0w2fy49ScN4ttZeLGNzCA6RndnT6MvuzFE8rjgEBtJwDOc6edKbUcP
	zU01A1geU0c2rRKu/vDtqksAojBxZmetfFmquTje+6256UnnzLjKqt6b9Hs/OmDw
	gX9bdOkFEKKB+Us1qcYzVQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rjvutc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 02:44:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48H27Gob017773;
	Tue, 17 Sep 2024 02:44:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycw3sv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 02:44:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlEJ49Tsptm6kzYjo2uTy6RH+80K8qI2N6jS4Or+8IzIV7AismaKyLC3IFhLD3222N2C2HWsyhMMj9W7c3d9bAX4pyt/Z8gIgxIE1nu6ZXR4TJYlBYc/BgP0Kw8mwLUttDjYlFdWE3DxLFCbOnX3VBF/O+7tCwDwvGh7mcFP2mInLG4+g5+zZeMMMCnPJFwpN9x9eK4aUXj67jNm7SNmpiLb7rogeSFMR6XdpUAR/ggWq5KUmRI7zwpSzhCHnlfwUToHFGvUp/zmg1bAIHAxjmT/q63+0u0ynR2ch78iyd1O4dut/L/XxlW9IzIKAYKEqBEFDm31puk/oWV+6B9VUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiHTJ1ABGdpaUcPYf6JgWBdTOHs3i439iC80tkdBiDM=;
 b=T2KE1MbxLvDyQQNQqnaR494WvDcsS3SURQQoBBKqKZ42VZdGMvx9cs3qcUaK9XRGd1t8yGHQLhdDD/DkkAaVGBhYecGGyDLkQ9WCoTTQNnnh6XnwS0Rv2dS3xluv2rGk3JTtrsb9luicesfQEuJNFBrYI5y66OAElZ7WI75J6wi+XhyGflIj2v90TACRo0w04GRgMAK1WSFvTfQfF0Itb51pHzAMf8OXXlf8KLaA+6VJzCKJQJ1bCGJ34R6vGAc7FjgV3Xxz8922MtQOLdiUMs99XB9zJjXsebv6YMPATybO7uHQ0B8QD7X6n/KwQpyUMbXh2xkpCrc5K9tv9R0uQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiHTJ1ABGdpaUcPYf6JgWBdTOHs3i439iC80tkdBiDM=;
 b=E6BKl2dVohNb/fRb5eUJdGQf56e+CZtJfvw3flQgRIzidNopxD6GSGeDH0sPPVodN4N4k0DxyP4Hf0DT84rZrJozPOhCOmFGiiwHrAVG/Sm+m3gzMyDnO1g3ZbShVUwnvuPO9BOck9wnGEYUTVGAOWNeYY7/i23cBJEGvC4LBT4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4617.namprd10.prod.outlook.com (2603:10b6:806:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Tue, 17 Sep
 2024 02:44:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.012; Tue, 17 Sep 2024
 02:44:13 +0000
Date: Mon, 16 Sep 2024 22:43:59 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Jeff Layton <jlayton@kernel.org>, oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
        fengwei.yin@intel.com
Subject: Re: [linux-next:master] [nfsd]  8cb33389f6:  fsmark.app_overhead
 81.6% regression
Message-ID: <Zujs7yk7zbENaZON@tissot.1015granger.net>
References: <202409161645.d44bced5-oliver.sang@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202409161645.d44bced5-oliver.sang@intel.com>
X-ClientProxiedBy: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4617:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fde8905-b597-4bb8-a5fa-08dcd6c29d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?nN/xKUA4xJz00nDX06g6PWHd7ycmAGYKFDIjZsWoFK212daqXxe1eOZ8qV?=
 =?iso-8859-1?Q?GZC1EHOK5ZaEVLMj7JX4YsFhskbhVLWQSVLb9xz76HA4DcwMaNJYJOc/87?=
 =?iso-8859-1?Q?R/OdWpy0bDAqU3dWSN9sOXJZsg8J7PN8cpLdclkmEScjP1FfUtpyOCgo9X?=
 =?iso-8859-1?Q?iJAT4ELTYCS+c188XCqgQCqRc1+OB5870AltTZO3/RDrRP/1aG04D05C8H?=
 =?iso-8859-1?Q?w45GJmGwW3WWGft+K+9z2wTFgA55sP/89EmaQoT5YPt+vr8j/OOqiBo4BE?=
 =?iso-8859-1?Q?U7kouPSA9uo1g3D9IjgCO5po6oEZ8u3YGDfG+mhH9fbdZyv+TdyGwhe/pM?=
 =?iso-8859-1?Q?anlNMMrGcpKRfRt3dIlaOr/3EX7EcX+z0ED5raffl5qyNiPyqEbGDwTg9Y?=
 =?iso-8859-1?Q?2ty9XWWjJcZw1uVo0DNS368/GhZsajksbt269GHoD4Hq2VQG5/3S+J5UHx?=
 =?iso-8859-1?Q?XkbCZcQAT5Q9fGXIdc5IATvRU81IVig6tJ2fayou0CRAPBUU4WqwIXAKUh?=
 =?iso-8859-1?Q?yUaMMNx72VKLA9PqZcHLDsA2Z2TNyI7WUwzGCBi9QT54Tc0KorKUrxVPWR?=
 =?iso-8859-1?Q?fh/KH1MdCNqeQAFGu3B87kWWdQmqhbyfSgtr5FLyEXtFcx73yrkuR6xBuc?=
 =?iso-8859-1?Q?Eb3/sUTGC8nw3WmXcbGYCkrOZ5nRFI0blQ7+Y1EiD8vZmON61pyxq0tOoQ?=
 =?iso-8859-1?Q?R1ebkst6kgfbHyhDX561zwGHYUPbOZYZaijch5WaeB9bYaS/kn5yEPhFQq?=
 =?iso-8859-1?Q?SjFTr/fAFK/fBjDVZUgCMjK1oajHaXuWGK9VI6UF8jguSu6scfTJc7ORa8?=
 =?iso-8859-1?Q?I5BjN6PbFwPF4yQpLRtGVxpZr3c0tuAp7goOrXlBbdyyHbCujHQx3Ark4d?=
 =?iso-8859-1?Q?P2ghz0vhDdx2aSfEUBpfVbxOG+6I0kven00Hdtoflz4/ElxL91JHosuFB3?=
 =?iso-8859-1?Q?YM0EhTdXqF1Nh1C7QF81ShN1twc7YVC/ZMWrs6kwCS5VQ6nnilYri4sv6e?=
 =?iso-8859-1?Q?pp762vtLHJ5qoFBUQGGCUb3sjs8C//EpOBQR817FxWcmfhhDpMFPl8l4EQ?=
 =?iso-8859-1?Q?JyeyFMrcshNB4pHAbzc2+6EvW6GoCcFb4cEtzJc+O7o7hCcSvUa4WjKT6T?=
 =?iso-8859-1?Q?QOrEEQF5pz/sjgU6twnPRHi7COt9jDa8DjwDlaUL/Z61YyHoY8ODwUlqb1?=
 =?iso-8859-1?Q?QLDlBy3EXeq+kEQFVgppE8Mo7YAWMzivTJ63KIlfgI45o6vR7KAX5wii0j?=
 =?iso-8859-1?Q?kav/s0+ebLjG/Q1EbY7uKpS9CWCjCsX7sr8s8OzmLJpk77HOztHTZLeSYR?=
 =?iso-8859-1?Q?J2XAcWnrwGz5OQMoTM67kgbJpMda+rALUlM7/IgrVnYu3hIKifUaJ2KCeu?=
 =?iso-8859-1?Q?MDMWahMHmzpHIxqQEiJ9Ri9KuSBuWZJJP6/iCndX+FE5qNxa8mlt4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?X5pWvJrzPE6+3RxyYWEt11rQU3jYONnOjZSEBdyqU8ipMHTCAmV+ksqgaa?=
 =?iso-8859-1?Q?WEsXPewe6gQWik5lYOdetByXleOlt5TcFj1EHyM6rQw4ONT6LRXuAP0Zuj?=
 =?iso-8859-1?Q?S9QOKwB7gjQk1NVPKJ31gT/lWDuguYuy/y3r2+FsdpExPzbX0y5AgqTudF?=
 =?iso-8859-1?Q?IeESlwoJnjDtuoa8EpubrdTchLfAoZNouoKGVeXMy7mXzhcilhsH+QAWKv?=
 =?iso-8859-1?Q?qTuvHoztVvUEWM4ZeGM2HY/uLj/OEJSzRWaSKJ/a5TFbfwjkqfTuyFAbUq?=
 =?iso-8859-1?Q?twwYa0/B3A4yt97lrfC9gbIQ6OJUOBJ/m1wFkhosjAvX0QMds4jrxcXXs6?=
 =?iso-8859-1?Q?tJDOV7EuvIMKp0uVTiGhDOPoZnjbKpRiY+wsVkh4HzaaMGoZdGBixLFoE4?=
 =?iso-8859-1?Q?uwd2V88lg/dxPET4HoWlOVyMRW50q2CNOhSSS+KUuOFvgtU3l/yZvylONa?=
 =?iso-8859-1?Q?YVV8rwFka9qR3mCgw66JSHVe9rBeW+hIEvN1tpEh82TByZJhQzpB2lrhLq?=
 =?iso-8859-1?Q?0BKr26I7AFDUK07jweTGZd8/67ZNrNZv4O36Z7A0v/YJvVLB20nMH1BZO5?=
 =?iso-8859-1?Q?ZzEaG7YYEibRALbRp2m0Vj1KC316fJrUseeBi2kwdFd+bLTG00pZ0IzEjt?=
 =?iso-8859-1?Q?6K4stPXtnEG3PoVneipZauTwfGECn/c7Eps4gmLzkxbook/1BOFotjScXu?=
 =?iso-8859-1?Q?nj5DYIpgQ/YmCNtar69RcyDb0FXmgsO4T9R7u6zch1JXGLdMyrECaT2J2z?=
 =?iso-8859-1?Q?U5fKnmwQ5h+iXr2mPw9gHC+0MFvMJhgKoNCYnN4O7NPcI96NgFvqGGmD2N?=
 =?iso-8859-1?Q?npIqA8s7STUNmpaYhe+E3uLWThiVY/H2F4igpnGwBqLNMi94aCTEhJZ3RS?=
 =?iso-8859-1?Q?6EEcWnggjoFBY2gLt4KwAyURzwUm25xl9NS1qUhawfRvxEEqnXtR/g5Rht?=
 =?iso-8859-1?Q?TtpYXsFRqLNeRAJK8KbPs4SagSM63uJu1XpW4MuiXsiXfyIVrRr4I99nzT?=
 =?iso-8859-1?Q?jMJ30oMpT+z7+W+eNFjeYwi8FwWI8+L/i94jZwQ82CDqhqCtxbhefdShHT?=
 =?iso-8859-1?Q?BiSwkEeS6vV4/mnDJvSBjfah+4DqqkRoruA4ud9Jimqucni1uj9Sy0Hweh?=
 =?iso-8859-1?Q?hUE0vo9yfeW4wBMwJpX6V/uItEgRDwEF5Nkg8X8qbUZ/20W1CubCZE6bG6?=
 =?iso-8859-1?Q?ZdHkkNi0/VihM1ZQasl7Uh+uJQI/sKVSojM2PU6HeSJKeXxrK92j9d5B/B?=
 =?iso-8859-1?Q?/tV7aKSs3TMvas42pT04ktG+uFzcsCxiSDapc2kxX18AgOnt7AMwqXXOtt?=
 =?iso-8859-1?Q?bPbH71JSMRfkOgxh4kI5Fe/TV4QH6Tq0HzAzXdkz+7sQMSCNhihstseMhW?=
 =?iso-8859-1?Q?Up3r3dOfb8tSINfbXwN5yed5Ovbjx1ssqCDautKuu+iSxJdYSBDOTCCQOe?=
 =?iso-8859-1?Q?Eqh8/6LBFIzanRKpAcJ+KRr8UihquEQa7rZWUknPjr73DqOOy8GduwyjWj?=
 =?iso-8859-1?Q?G+jdOtQvcnZmo4UGRWo0RcPSSL822w7bFsnO1Bv+tCysZMBvSRCpu7GYE5?=
 =?iso-8859-1?Q?222nSoBglz7N9ErNd9JA7I3Tr1vokBsuiiQ8b65QPD3HPNdLgfO1su63VQ?=
 =?iso-8859-1?Q?RnTNi1G/UGzIjNvS4npQbQdrVVraNe51O7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JpwTBEehjpOGZyEeXNNwQshAj270SjgCzcIXycU/cD+b9//hzTkfyjV+sWl9jzGEWedocdpNTb4HNqCxqlffTOvwNj1aygwdq05XjSw1wrs3EyezKLWWkQmfA+qS9vH3AQjQnaVHc3g8c/noOfTPHDWxgHp5u3bRejBBTzs6eT38MMVEtnOExNYr8OPtBWtuHG2bgWXnMyVlj+MfpkX9XhhoaMGl8k2bBuYIbOZRNi1AutXhmVGhxX9YqivWAYA86ydNvmaKB+eWKQPIPl6/cm+YPuW4+rZ4wj9YZ70spFycU9VpGpVcWX/eKWmdCM9plx0GL5/nYqUNvum4bZ0fapAyf7+aot5dTY5jaL+UXmQT7CAlIY4jqunqbUcfsSj6v7M68I+boO/zDmEu3smz3qJviv6UrqEQMSYvJtNW0aFUceKY1ipkSfrymUlT2TllMT/oxOAcWEsbaT85e7NX0kZGfvQLdXaVKR+mULL0Q4xew4E9glH4pT+l23o3pS/e5QVG2p9WCg4zsX0ry9YJqOu6CjNTOwO43iVnxItSEsGZjr/lVUbDozQ4OLW8hZrGLmXr13S936KdTALhwX/eyG14bpvx7kKWK6hxrglGe7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fde8905-b597-4bb8-a5fa-08dcd6c29d8c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:44:13.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHg4iH3QJ2U3uLDEmZ9LKdoZgGZsL8PHEdRglSlPheEXQuatRPPdfQUesdPkCruK1yEywsOLRBq+h2m0dUsW+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_01,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409170019
X-Proofpoint-ORIG-GUID: oMQ8-vYzT4kIH480fZqLVoxUFiJGlB3U
X-Proofpoint-GUID: oMQ8-vYzT4kIH480fZqLVoxUFiJGlB3U

On Mon, Sep 16, 2024 at 04:41:35PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 81.6% regression of fsmark.app_overhead on:
> 
> 
> commit: 8cb33389f66441dc4e54b28fe0d9bd4bcd9b796d ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> testcase: fsmark
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> parameters:
> 
> 	iterations: 1x
> 	nr_threads: 1t
> 	disk: 1HDD
> 	fs: btrfs
> 	fs2: nfsv4
> 	filesize: 4K
> 	test_size: 40M
> 	sync_method: fsyncBeforeClose
> 	nr_files_per_directory: 1fpd
> 	cpufreq_governor: performance
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409161645.d44bced5-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240916/202409161645.d44bced5-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
>   gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark
> 
> commit: 
>   e29c78a693 ("nfsd: add support for FATTR4_OPEN_ARGUMENTS")
>   8cb33389f6 ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
> 
> e29c78a6936e7422 8cb33389f66441dc4e54b28fe0d 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      24388 ± 20%     -32.8%      16400 ± 18%  numa-vmstat.node0.nr_slab_reclaimable
>      61.50 ±  4%     -10.6%      55.00 ±  6%  perf-c2c.HITM.local
>       0.20 ±  3%     +23.0%       0.24 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
>       2977            -6.1%       2796        vmstat.system.cs
>    2132466 ±  2%     +81.6%    3871852        fsmark.app_overhead
>      53442           -17.3%      44172        fsmark.time.voluntary_context_switches
>       2907            -5.7%       2742        perf-stat.i.context-switches
>       2902            -5.7%       2737        perf-stat.ps.context-switches
>    1724787            -1.0%    1706808        proc-vmstat.numa_hit
>    1592345            -1.1%    1574310        proc-vmstat.numa_local
>      24.87 ± 33%     -38.9%      15.20 ± 12%  sched_debug.cpu.nr_uninterruptible.max
>       4.36 ±  9%     -17.1%       3.61 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
>      97541 ± 20%     -32.7%      65610 ± 18%  numa-meminfo.node0.KReclaimable
>      97541 ± 20%     -32.7%      65610 ± 18%  numa-meminfo.node0.SReclaimable
>     256796 ±  9%     -18.7%     208805 ± 13%  numa-meminfo.node0.Slab
>    2307911 ± 52%     +68.5%    3888971 ±  5%  numa-meminfo.node1.MemUsed
>     193326 ± 12%     +24.7%     241049 ± 12%  numa-meminfo.node1.Slab
>       0.90 ± 27%      -0.5        0.36 ±103%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
>       0.36 ± 70%      +0.2        0.58 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.btrfs_sync_file.btrfs_do_write_iter.do_iter_readv_writev.vfs_iter_write
>       0.52 ± 47%      +0.3        0.78 ±  8%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       1.62 ± 12%      +0.3        1.93 ±  9%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       1.22 ± 21%      -0.3        0.89 ± 10%  perf-profile.children.cycles-pp.readn
>       0.46 ± 32%      -0.2        0.24 ± 34%  perf-profile.children.cycles-pp.__close
>       0.45 ± 32%      -0.2        0.22 ± 15%  perf-profile.children.cycles-pp.__x64_sys_close
>       0.40 ± 29%      -0.2        0.18 ± 38%  perf-profile.children.cycles-pp.__fput
>       0.31 ± 23%      -0.2        0.16 ± 33%  perf-profile.children.cycles-pp.irq_work_tick
>       0.17 ± 51%      -0.1        0.03 ±111%  perf-profile.children.cycles-pp.nfs_file_release
>       0.16 ± 43%      -0.1        0.03 ±111%  perf-profile.children.cycles-pp.__put_nfs_open_context
>       0.26 ± 18%      -0.1        0.15 ± 34%  perf-profile.children.cycles-pp.perf_event_task_tick
>       0.15 ± 41%      -0.1        0.03 ±108%  perf-profile.children.cycles-pp.get_free_pages_noprof
>       0.18 ± 55%      -0.1        0.06 ± 32%  perf-profile.children.cycles-pp.native_apic_mem_eoi
>       0.18 ± 32%      -0.1        0.07 ± 81%  perf-profile.children.cycles-pp.flush_end_io
>       0.17 ± 41%      -0.1        0.07 ± 93%  perf-profile.children.cycles-pp.mas_store_gfp
>       0.52 ±  5%      +0.1        0.58 ±  3%  perf-profile.children.cycles-pp.btrfs_commit_transaction
>       0.02 ±141%      +0.1        0.08 ± 42%  perf-profile.children.cycles-pp.uptime_proc_show
>       0.02 ±141%      +0.1        0.08 ± 44%  perf-profile.children.cycles-pp.get_zeroed_page_noprof
>       0.02 ±141%      +0.1        0.09 ± 35%  perf-profile.children.cycles-pp.__rmqueue_pcplist
>       0.14 ± 12%      +0.1        0.28 ± 29%  perf-profile.children.cycles-pp.hrtimer_next_event_without
>       0.47 ± 27%      +0.2        0.67 ± 19%  perf-profile.children.cycles-pp.__mmap
>       0.70 ± 21%      +0.2        0.91 ±  7%  perf-profile.children.cycles-pp.vfs_write
>       0.74 ± 20%      +0.2        0.96 ±  9%  perf-profile.children.cycles-pp.ksys_write
>       0.73 ± 21%      +0.3        1.00 ±  7%  perf-profile.children.cycles-pp.copy_process
>       1.05 ± 13%      +0.3        1.38 ± 10%  perf-profile.children.cycles-pp.kernel_clone
>       0.28 ± 22%      -0.1        0.13 ± 35%  perf-profile.self.cycles-pp.irq_work_tick
>       0.18 ± 55%      -0.1        0.06 ± 32%  perf-profile.self.cycles-pp.native_apic_mem_eoi
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

Hi Oliver, thank you for the report.

Jeff and I discussed this regression earlier today, and we have
decided to drop this patch for the v6.12 merge window. It's a new
feature, so it can wait for v6.13.


-- 
Chuck Lever

