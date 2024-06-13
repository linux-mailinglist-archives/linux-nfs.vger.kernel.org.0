Return-Path: <linux-nfs+bounces-3771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5592D9077AF
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE18B209AB
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91FF12F5A5;
	Thu, 13 Jun 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RLDxo09G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TPK5grsK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B312CD91;
	Thu, 13 Jun 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294496; cv=fail; b=fWPuW03OREwAdos6RMwk+GDgeeK+7fZkdllCjVSvbMjaKNqOsX50UxotMapskyE4nasnFABBACNvqr4MvuWEpaITd0Gkdz5DCpuJg7k6SMmced9rX8zoN9WXQ0YkfgQkaXKtmA2+M72i94bu+yhuHXdGETZLA3aBzhymuN4Buyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294496; c=relaxed/simple;
	bh=Ff4oUcA3jXKDkmyUme6wM3iyRKYjwahDZWk/JewNUHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WJtwROU1Tk9QWYaWyeaKhUGws/7+FTZaGQ6Y58c0GgL+moRvyQY06Xujim7CVhdOTE6UAKRy3GEFnquKNoBoW/0nbzYP7VKKY/wKDQhQC0IzoWfnJGq3uUK6fCtq4ftsqIy85PoNx1fmOOc/ELJhtcxEGsIDAA8bcPFPP28IxJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RLDxo09G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TPK5grsK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtRTu009667;
	Thu, 13 Jun 2024 16:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=/IYQRtQenEusR11
	a8EJ3HjfRrxv3NjwScA8JtI5wRxk=; b=RLDxo09GBFk4TtB2zID6+ql5RAoI7fE
	1W4UvSeA84awdr7vHYI8/tplpQn8V1h0wqD595CHrktBcDij8DL4ekJQFEr8/SFt
	1nRpusapzay20BX/oISiAVlH7nZnME1qEGRkYvPT1l2gYDGG5yFDVQavK1EreqHN
	B0ep3HQ8VApJR8Mvx/tItTGr661SoxnsXwXFpldm6NWz+Om8YQ0yLeKUAbtPfPE0
	3F0GD9ct6szj47v1outPqBGoswi0xNxWjFXZ3212tXkQM6go2dsD1bWa1zedjwiC
	VvT/LTZxhYGJsfcUt55Qme7FsPw7N2aSiujPtpjRWukA7k7g7EeJOSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7fst1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 16:01:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DFsasY021653;
	Thu, 13 Jun 2024 16:01:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncaxpuvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 16:01:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtC0ozRmZFPzOKockGfcktMAxKVJkJ/qSadXt7aRb6DVhbtWDr+hZakK5uRKJdLFBW8kERvfypj3KDDWF1x6QPUmhsxzbMmqOmnG/BxGgL8Iquy3c9UBJ1hkVyA2Bqlk7qDMFiKs9pHTGkG3a6SWJQebKDYBJL37lEM4CxlXu2ZSo3w6F9H4lTvn8ddBWr/NhvRgxzDnt/Q0GUJgVf6JjaMQRkLeG82dwq+BfzVZQoFdHl1jUmT/HKKKFKhYsHZwnZmWORdD7zG3L3unHwdzQAIBg/V0KnFwy1Da+guzwFfJgmn8uNMtRlxqMX411THZISiB2l6ndc+YWTBUGZucEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IYQRtQenEusR11a8EJ3HjfRrxv3NjwScA8JtI5wRxk=;
 b=OdtxybNxqslFY4zgvUH8mVg5I/+lY9KGWdO0GnbAiSY6G94bOjwUIC7KFVSqFA8yRURRCt/egAFd9jI6Chl0vAvFpmmMHgEGGZFxFsV91PF2EfAHONeFu6wz6kX/lZd+vteHoY7chqlrHnxuBLi5r4mxW9oH6dEe+OfdHAq7GlPsoY6mtYwqludN4GMX7UZEJdiRpGiuccEKQUFIL5I2oIhJvxITNvtA3F/9YV7/WIdbk/XFdFdbKmTNCv/VWSZTZB3Et49dhhYYnNwkDUUY8i8WfBPAnsRWXnRVJIYYBYKWPMn/TEN6800MYevs4r4/r5BteBcDd+JBuXgvSVzUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IYQRtQenEusR11a8EJ3HjfRrxv3NjwScA8JtI5wRxk=;
 b=TPK5grsK8QTYAoYMcL3HJdopM7updiIe0qhZgHOUsOXx46FJaGa8nqgBA8NsLU/w6t6LkMwP8LbUsp0Q9JQ2s1q1rIhIf+trqEYU9Rbkqa4DgkeA4EdpD/9LIygcaSZ9TS2UVLX9mcNwUfgHm+H14Wcdh6+8D3HYFa0fHRr1OGU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7197.namprd10.prod.outlook.com (2603:10b6:208:3f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 16:01:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 16:01:07 +0000
Date: Thu, 13 Jun 2024 12:01:03 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/5] nfsd/sunrpc: allow starting/stopping pooled NFS
 server via netlink
Message-ID: <ZmsXv3pS1ui1egpI@tissot.1015granger.net>
References: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
X-ClientProxiedBy: CH2PR18CA0023.namprd18.prod.outlook.com
 (2603:10b6:610:4f::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d78cb77-03a2-42e5-968a-08dc8bc208f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|7416009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mdguU/GyZx9OLTHn17UgPcOEWLvb/qpFw8jeRcq6tTW1zAMBfjgO+1erQDwO?=
 =?us-ascii?Q?5d4fch41EsTDx8iVWiQFW2rVQfPqPTbrYu817d2jQUUu6tE1nbHt02RU1M+x?=
 =?us-ascii?Q?RupnqO7gmUSkmF20dl8VtxVqF4LYaBfktnRTIFXZiBBsZNJrdC4AvV2vIXs0?=
 =?us-ascii?Q?UyMzQkfZuOZfhoITyrPYJAa6HnrhJpLMAtFz0JhG37yxQKLdmHq1WsUkUHPf?=
 =?us-ascii?Q?L0w0FwZkSuuNITnqBxQahtGkU+qXHoJSUFM+12C9bYIr+iXhqCYGT7cQatgX?=
 =?us-ascii?Q?mrINdR84XfdALK67iK9gc80yS5EGMz6XsZ43wzO5466Ml/s2bEI/XgShat1R?=
 =?us-ascii?Q?P2QAbubm0gxibBww1JkQQRo/e/J9a4ufpNlOS0fGNgoECo2DJa5IlqlCCIoG?=
 =?us-ascii?Q?lYSaAcXvyDui/P33iBfL1TfYHYT5xPXzYlsI6Uv2HiB7t7SexYUrvedJqAZ6?=
 =?us-ascii?Q?ukxwMvNFiKsLDz7tei9Cs7yYm0tx6i1wn6p4iVwSKE3P4Jp2zDZ0d+LINDrk?=
 =?us-ascii?Q?5IMY0od4UZItzfoWZMwe6/TwxuE/Nt1renAzqRoRs/YqJXxDqWtrp8UFCSr9?=
 =?us-ascii?Q?LzPd1+j7boUdGZ2J97z857znmFmvsrgp9IWtivFGRyNiP2atDnz0f5TCuiGq?=
 =?us-ascii?Q?MwxK3E3q2jNTPoH0ti9s7SZvqWrrmqIcYzlTlJLYqYLH+0j2CJAA6MiyOqta?=
 =?us-ascii?Q?Twmp1lqgdlP45uknXlGssXxVdGa3SF65zm7ASg3B70rYf0rCEqcmv9RgbKrn?=
 =?us-ascii?Q?SLZ64XdQeiE11IHx9qp/EWj8iBFlygput0Gh7htwSoTpe5a70YQMMqV+ptw9?=
 =?us-ascii?Q?07a7EXyxynZjU93YTAoz3Lu+6LbTgUnjGwhZ7TVhGhCFRlu4KeQxU0EeXuWr?=
 =?us-ascii?Q?AYbliWBnJxgC1YvWHI1BqZ8tSdeFv1gbMllw1nVKG4jZx4EHq7Dx94DLKjkS?=
 =?us-ascii?Q?mGjcg3oK85ira5T+DgnWy8lH5r2yU3xcP9AMAIqX1AlJeGpLpic3HzLzSL3C?=
 =?us-ascii?Q?A+C7EXkzN/WRwibAbqemquYdoiC7Je2UvcXC2Ps+XVs6+0zeH6xqMxZGdGj6?=
 =?us-ascii?Q?T4mCS/y3ZgOqdha4rAspU3wt1x1ZP905Mz7JSWSPswfqYun3jDc4v/E5Rvvp?=
 =?us-ascii?Q?VSP64OnYyZ7Rj4x3A9T0rYcRfQ+nekxMHeSuzrDIAIpAzpznYhB4w2Myw1KX?=
 =?us-ascii?Q?lcFhi9K7uurIhczKaCHjoqYBQnPq2cDCxHy83lLHyZ5t6KaCIwU7jtNRJn+B?=
 =?us-ascii?Q?73UHBOyFvVzfaE4lHDyNi9Bd5YUMP8qspSc/pKLQ3fTOTGC1OFN8dDHWr5E1?=
 =?us-ascii?Q?qZdPXxrpZbpxXKgCEPiLhISs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zWviInQ9NUWCoNFckFzfX59HykmGS1L/rFxEGk3pQVYLe4DfJH7A03mV4EDm?=
 =?us-ascii?Q?Oaub79cerWnmBsSyxDPi0buLnPpIsVAIHklwRLjgx5qjK2Nbj4QHtHQIP5hW?=
 =?us-ascii?Q?J7Y6KNq4tc5BF6IF+8JQ9HVNMChvEFPq/gX5cdqU7vjvZ26CTqlH9o1n5sIF?=
 =?us-ascii?Q?9zfEPwvGuT4tR394+B0ss9cz9wgLQURboClsw59uppt68RcTJe63hA6XI3eb?=
 =?us-ascii?Q?jO6qPjMQ7jHGLycZVE7ALwp8mQsqjpE/vox0bBLYZDkLKHC9H8xme7wgcydF?=
 =?us-ascii?Q?pLBH+MslV4nOiDonVCZDK7UGno5eNqT2S0hd4o0PUcBYUUdJt2PqJumsygTV?=
 =?us-ascii?Q?15eyJXW0Rm2aLnM0QdHy0TbI4FTtZcMjaXCLV/krZ1xcX5h/3X49We/5QaQO?=
 =?us-ascii?Q?CZrMAhyrw3kFeMgXEoIo2uxZmB5HKg7NjzH02Jx+Jf55XrHMGaqbCOcu2E95?=
 =?us-ascii?Q?Fd3ddWCWaAHJQLcVndNT//+8gy8zTpYod7gwvQjjaJo6sCd95s0XCTO/cZpb?=
 =?us-ascii?Q?bx5aXqylzRGnxnkkYws/6USzpf2GTjAg27pID5h4gD7L3ybA3NzO0dPU6Aql?=
 =?us-ascii?Q?29gr4d86PotqDcliMeFe2axKnnvHKMuEbql1/1xFPhm9XuE9oYCashtzKMXv?=
 =?us-ascii?Q?ZXdjFE0NLD7rK4yAzsZ8U1wvHDZNzwdH0spu9v1fh+Biy2IjTeHyVBCNVzU1?=
 =?us-ascii?Q?wWi54J4ks+jIchYhMa2Yl48+HJT+PcKqSQm2PeoU97yVCsY8ZQx0voG7+d+C?=
 =?us-ascii?Q?7pn7Bj7ykmFBdOpeo2acr2pp+OUTmrdpPflmGGTP1pWt3pAbKEgCnqJ1Fy6t?=
 =?us-ascii?Q?d0qxAD1W/cFJel5wX1s6iZzpw4cOq/gVMXqU3il4FdX2jy6ntThfxW6TZFK/?=
 =?us-ascii?Q?u1svKkfUwJ4TP2a3U4EQnxIMmkmS+jBCea7YjJKWG5UNLp1/k+GQMm3FsWFY?=
 =?us-ascii?Q?RgRk7BlKrdHSicZj67grs3p+IELOXt6yrqVMUXhoMcRDl20dWHKXyzvPgVe3?=
 =?us-ascii?Q?6jM8NrizD2Eb7lg4ashF9gVXJWc4FxXv/3auPEG/me1B90NcswDWgVgYGhS2?=
 =?us-ascii?Q?q8ZTRk7MXX9xgTJOj6lf4kDZbShkDqj4z5JZWibIezUCT4lPlLUMgWLJfaL/?=
 =?us-ascii?Q?UubjyZjPUIg9XKMAswBqUfLJVL21lIWuM4Vr8V3Eudv6L4qYdENqb6k/1sXJ?=
 =?us-ascii?Q?w8CoVP4UlQusYqSdN/4TDQlDuAf/2lWyeYjNmUXgSsIGvvWvzWslfKsfP6cF?=
 =?us-ascii?Q?yriwp6I24mvLZHjHd80wtd77qmyEpWlYEFGeGtG+K/YAonijPTndVxhEvyU6?=
 =?us-ascii?Q?+DDb8r9fLmpJ49vRRl3eVGvgxb/xBCZR6zIS+yQDT9E5oDitOmagNwmiA7Jq?=
 =?us-ascii?Q?bHHxSBx9yYV8M1Og8EfeQHEUPwdVrkEwOYJl1+RjD2tAJiFwB8080Cd9fYX9?=
 =?us-ascii?Q?aXpw2xvoRDXQqniN+RmQnHPLLRHnNdjXBQzsgjQiAbDg3G9KmKi5TpiO/Xtx?=
 =?us-ascii?Q?IXuOrS0pucV/jNJsw01xdxATAbM0ImG1ZNNE8auUT5xWxSRFe3jngRUISDCr?=
 =?us-ascii?Q?A/4Q9rW/O+/eqrkUknOSIbvVHscPvXBouIWi3JY6Oft2F9pRGa3Iho0/Up7U?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L+EjbmlAQfQkMEq+RjJxiuOms6XV/L/CL7os7dN29VOmPYzqs8zJGp2EXR9y9TGyoP1+8nkP2NF/7WcmY1k/VoFCGKUb9CCpwrJQkG3xW15nUgj0IeLQKQz04n+dDBnCzQbngcFcamDgee1gWUp8PNxam4aLFLvAWxPoDovt+MUTcf3Nzh4YODXqm7Sw1Q0oE56DwYCJctfYYyouNMAlQFCQapcZBLmvqx9LpaoEnLVqAM0jW3B1gbk2+LwthjrtZGRYKjAxANld5yRJczMwMKpIEXKr/ELQNVY00ewyNgwAlrxZC6cDW+z09J315slR/wO1wl19mASeYDQfjPgzzQRHYr3kt4ME7ATVTw7+yDbGVH7KDSWMdeNIkCq0LD3IzISvl+OQa+5lRUsn4FWs/c8cqTsgIhoFtAPuxSA+24mBRSZncUjvEntvAQyuS/+LUaRnoYN+XNqstFADSIxqh5vzmTLS+DnZwyZ4Ff7yguHNJAPgrO4A9iYkI7iGljwURqxy/hMA2eXPMyEv3wCmUizR8g1uPeW187Ig7miihPHdxxRayCOS9dE1/p4ysXH+CaGuJP2LVaumPmUrlbdek2owXJF2UIaU/TrM/5iLZwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d78cb77-03a2-42e5-968a-08dc8bc208f0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 16:01:07.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XNcfjPwY+W3g2oHMC3llSXMw69LQV2eassoKzX0y3E+ZFJ8v5zk3eGL7+rgBUeqKgTNZzG0knSSccKWIoUc8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=782
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130114
X-Proofpoint-GUID: -jzs8eiU01Uip7AzF4Za6SArZdtXYeQq
X-Proofpoint-ORIG-GUID: -jzs8eiU01Uip7AzF4Za6SArZdtXYeQq

On Thu, Jun 13, 2024 at 08:16:37AM -0400, Jeff Layton wrote:
> This is a resend of the patchset I sent a little over a week ago, with
> a couple of new patches that allow setting the pool-mode via netlink.
> 
> This patchset first attempts to detangle the pooled/non-pooled service
> handling in the sunrpc layer, unifies the codepaths that start the
> pooled vs. non-pooled nfsd, and then wires up the new netlink threads
> interface to allow you to start a pooled server by specifying an
> array of thread counts.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - add new pool-mode set/get netlink calls

Applying this series to nfsd-next for broader exposure. Review
comments and test results are still welcome.

There are a couple of nits to be addressed in 2/5 and 4/5, and
we already discussed adding a disclaimer about changes to the
behavior of the /proc interface. So, can you fix these up and send
me a refresh?


> ---
> Jeff Layton (5):
>       sunrpc: fix up the special handling of sv_nrpools == 1
>       nfsd: make nfsd_svc call nfsd_set_nrthreads
>       nfsd: allow passing in array of thread counts via netlink
>       sunrpc: refactor pool_mode setting code
>       nfsd: new netlink ops to get/set server pool_mode
> 
>  Documentation/netlink/specs/nfsd.yaml |  27 +++++++++
>  fs/nfsd/netlink.c                     |  17 ++++++
>  fs/nfsd/netlink.h                     |   2 +
>  fs/nfsd/nfsctl.c                      | 102 +++++++++++++++++++++++++++++-----
>  fs/nfsd/nfsd.h                        |   3 +-
>  fs/nfsd/nfssvc.c                      |  30 +++++-----
>  include/linux/sunrpc/svc.h            |   3 +
>  include/uapi/linux/nfsd_netlink.h     |  10 ++++
>  net/sunrpc/svc.c                      | 102 +++++++++++++++++++++-------------
>  9 files changed, 225 insertions(+), 71 deletions(-)
> ---
> base-commit: fec4124bac55ad92c47585fe537e646fe108b8fa
> change-id: 20240604-nfsd-next-b04c0d2d89a9
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

