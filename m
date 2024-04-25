Return-Path: <linux-nfs+bounces-3003-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D87D8B2388
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D811C2093B
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB35714A089;
	Thu, 25 Apr 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h+2WmoYO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jIIbBxHC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21349149DF6;
	Thu, 25 Apr 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054064; cv=fail; b=gjNpsgT392kuvgNfeWt0rDT4mnZ7SMHZ4Sp4eh+nThNtp26NyA5gFzoxusbfh4wzAEfa/2ZQxO3tCEJDTvErsA2qK9u1+CnK+9I3CASerOKC+aGxKS4MWIj0Jq/dn3P/jNeSPlgLHDjwg0jW03dSZ1TGkaQwXxyF1laRXkszM28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054064; c=relaxed/simple;
	bh=sLmMQuzG/ziEPh71hp7JlW8+NfgZnW24PV5DA4t6jnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RBN5SHygGqcRvjixkSp+xYPfVFnq0LduUJXfiunbKbfU21nJ8//qTOLVIW0ULM8+R0g0PmDInizq+LWwuV6TpXK0jftIhBImIAS7JL6DONhoKZ54fxQe/lzmvvXKiOWGLEY7/VdTMgWO1f7HCzsYLiInMaWN3el8/6Ec1AlPR3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h+2WmoYO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jIIbBxHC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PE77or006675;
	Thu, 25 Apr 2024 14:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=VKx/BEqR0x40S9QHlR30y+Uo18Osyw4DSpffT0ipZTE=;
 b=h+2WmoYOaXxiW8iQIggHcGAAKqfuoogjRj1zjvQ30ZUp2kTeWRaCDQUYo5jMnaxhtiZf
 8DxgCLMsLTyewljD6JeLs6rbuLVeB+nf/RJBvzyEMCNqyRgozpsOeoBC6C02NUSdrMwM
 +5PwrcdQELDTWcqfWBiO8agM5vrbRK5ht6GQV+xhA9GEwKv78+Ub7+AyqEX/L2WVGAXK
 JCT5SMlzCAAdwJlsjnJium+R2SZpU8adKubQrzcUUSN/w1IUhNlyj34TFfG6TeiaVM6H
 1aexiMLxXK6PmFuNWuMvcxnk7H3lwQQNM1vTiqSIBLtVtnv9OjvEzQyPhjat42BA76qg cQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4mdbag2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 14:07:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PDUG8q006251;
	Thu, 25 Apr 2024 14:07:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45aecge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 14:07:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeHh3esv81xvRvAI0L+LYnoUNioVQtiK2XGa3DH2ipNmTIh1lP+xzKJ1ax+RMcxs03iLiakVUxtVuA5FRRhkbtz+oM+H/cb97umbi+r5gQn4fnuy2rji5q0BQF3dmW7ffZlWIpOozYN0Hmu7LwjvHacP5lCbLNONr+7zC3gj7oSVBk/nxBGWI5oz2NqQ68F7HJtci0MlFLIHyOsrvEsltj3UuMHMy1nq4DhcqHwF5jP4OlGQZBfuBN8Fshj+hwgaWPABVi1RWebNDDULBuh5nTJ3QZecw+c6ex7toklKhrOxhBzxYhVJgRF0+DtLZ58FActFRbBUOkP8c9p+UuJ0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKx/BEqR0x40S9QHlR30y+Uo18Osyw4DSpffT0ipZTE=;
 b=QbeXRSOimyYN2dHOlCkVnp+ydING+2tA7bMHUISLIItXIOVr7AZd3qQiyBfipFrN/7z+HQNb1lucS7SXNDcUpdJuXVHkdR5g2igRKt/ZQsrzDYvlRQM5CwHAubHuGdkGZNAi9IJ8Je6sp7ZnrQOidWIb4F1ezrqC5UmleguVZ5ZBG2qBo69bpbrAfa4bKxrifwq4NK9fqdD1k/Q1ctUe1Pgtc4U8nS3xSs4dAR7v6TQHRROBvEBhuNT8gSDYsUiLmh4ig02/3choq+vEfbVlHKe0eHCmqWIEcSdAW/k6fOmDE8TiBPiC9vcioOAm/ch721Pf+WKVXnI4lc1fNYKIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKx/BEqR0x40S9QHlR30y+Uo18Osyw4DSpffT0ipZTE=;
 b=jIIbBxHCalaAajsqGp7y+Om56NwSvMyPt5gPMKmb2JFlWyRmr2A6DEPYuyqhFOwGa2gFGfi0hNGcsaKQde00n3TMdZZY+AcZDJ1s249V+UOylo7c0+NQgr7LBBhU4OSlpI36O71G8TSJ4nQOVxter1Lji/fBO8Swt7zppkMJZUQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 14:07:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 14:07:17 +0000
Date: Thu, 25 Apr 2024 10:07:14 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, neilb@suse.de, lorenzo.bianconi@redhat.com,
        netdev@vger.kernel.org, kuba@kernel.org, jlayton@kernel.org
Subject: Re: [PATCH v9 0/7] convert write_threads, write_version and
 write_ports to netlink commands
Message-ID: <ZipjkqTcbcWcmQJ/@tissot.1015granger.net>
References: <cover.1713878413.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713878413.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH0PR03CA0409.namprd03.prod.outlook.com
 (2603:10b6:610:11b::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3d9801-af61-4288-b637-08dc653103cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UjFvyj8uB/YsCBMOM2OyH815ZMejL4+d7HYuVrFX3jWq2Slkr2gWyrqQEKRb?=
 =?us-ascii?Q?RnROIMxeO+jFACi0cJXecK6gVX09mC1riPqti5Gy3CombjaGGQNRRCZ7rorJ?=
 =?us-ascii?Q?TbLyPPdcLc2y0SO/fwi0pvdzKOx4/If2HBW3HzLLLrRaY4+HqRZW3ct17rv0?=
 =?us-ascii?Q?96lvzGfs0N5lcg5YkM5AzCuR1rRpsakUyCKGzrNSm6pKuIbXVw/7TEANNE/g?=
 =?us-ascii?Q?mLgK3H5xKJPv1kvnBxsPdP5Dg+6sdOuU56mlaWt3uHVd4Hz8vGg4d6ddRvUm?=
 =?us-ascii?Q?K/pMGtk74F2EejGkZDjiC7chKiGrN3lq3VOSljgfKwsV4V/FF8UFU6HhPlYB?=
 =?us-ascii?Q?XRYFaE/0fky0JmC5bNtGltLOkWW0GsIW9wCXPFUk0xPihZJzcTErxMCc0obe?=
 =?us-ascii?Q?0u6dK9dawvnjBwaCyHR1td2kky5N1CJ194Y0dr2ydDuduDxRO73Vm/wW3eQ8?=
 =?us-ascii?Q?4SRSHuPBSbmCZ+dGQv4kxOkfzKYYIkWzMoGXSsBKzqgY8+A+b3ccVeOXTuRO?=
 =?us-ascii?Q?NK+3EHSLZEEiTzk+OHccWH6aAAgx++dtCeETOkD/3RSNLY9Ybz0mz4PLhQbG?=
 =?us-ascii?Q?fivMSab41XM3mcmAy+0crYxqXbQ0T/wLq7D1nvN1QvTglQ9jexI7vBwSlMAx?=
 =?us-ascii?Q?o2CgF2g3ccf0Y0+0MKceOr7GBI5KVk6Hv5kCBSn7FLrlH0SBnwkvDpSfbEcG?=
 =?us-ascii?Q?ns1wkDFxypoUwRtyxT1RhvPxtS/1fSxEpaPHQfOFq83WHU/nY8q8xK19o9Jj?=
 =?us-ascii?Q?t19HVhniZMMmHRNNnrmxf4jemqqgenoe3NtvHUE/jZuQy2q1jpZOp/ZFAkzP?=
 =?us-ascii?Q?Zevm5DGRRCdJSwEvr+8RanfAXADHLt5xaQiqXRnb1mBm3nF9i9W4D3zBSz5O?=
 =?us-ascii?Q?iDkxDlXJ21gdG/0+GelkYlm2owBBoEB3KVAU/l1kCTCsG3z3iflodJbiFJS1?=
 =?us-ascii?Q?/S9qwW0oQI8zihn6ebpMlPXC+4RjDuJw9v5+RHkj0lVu6ppZ6IgNXft3fHeV?=
 =?us-ascii?Q?UAd0U14izE/N8VY3omDXYUvLflNpyPmdUQZuagVnxkfZ0tvA20W+Oj40PH+s?=
 =?us-ascii?Q?EQVfoKxKDGB+rPoebL1pdaiTSNIkpoYIL2B/JUPMFULHlB8ZUuD83R1P7hXA?=
 =?us-ascii?Q?FmQRiyEEI+Ub9iOFl1tYnorfmIw+Q5a2CdRpA0OmmTE7RKvAXgLfTh9/A8Nv?=
 =?us-ascii?Q?jrEMTc62FeyR+Cb8OzomZnw9icz4TFC1ULFjdONGg9Iz+3Y0sFVe7lDxErQ?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZNGiM7zjU1oV813PdjPdkPDJFAEWzM81f0m1Gs5UdEPhQuxK5H6QE0vXJHhp?=
 =?us-ascii?Q?jSS+QXE9svzRUNP+AWV7RrHXRVJ1kxybdos6CqaLSbH2XCAHY2GnYXv0qHY0?=
 =?us-ascii?Q?k3xT7QfBEykL56vDRANsggodK6Gkwu6No7qsvMBQUW5shRdh3jrxXqHFI20H?=
 =?us-ascii?Q?1/oViz5MufS0gmn6/P/xfWvO/wOc3auH+PGgSQdhPvLVs7Cg96MftMgpHzah?=
 =?us-ascii?Q?jkyM8NOELjclwX/ggSGuhZ3tKYfjKjwHKwbMp0U1qcLDTPov9dA6AdvQPQ7/?=
 =?us-ascii?Q?cYSMo3fj7XLZMacglVhKzuGTqtz/GgPiwQ5CmNrrh21cqpLvCg1B0dVQI2Mu?=
 =?us-ascii?Q?leo56InSpVp39mLuUM/dwWVH5p0xHMm16feUG07rzbZ+cKaxQpmojvoXTC2b?=
 =?us-ascii?Q?y9G8C6oekkTNXELRCUoDx93A3XGn3rRmQC5ibeyPiK20/I5L9Empj8PFDkr+?=
 =?us-ascii?Q?elUKC89qDET67tnpXfL+cItl6BI7cBv+Yj/CZSX9bLHpRAdCR/bPmAOsK7uT?=
 =?us-ascii?Q?HPfxGuhlNlgPl7KWivOm8qadXgZJQVnrRVwwJ71ewpVwfEr/eKQ7eSW7pCnE?=
 =?us-ascii?Q?yDK5PSoGyZG2ou0lW/hTDzI6XgqMM3URh52+i9taTJe6w0sJ//QmeiC8uAhS?=
 =?us-ascii?Q?a5uM5GeLeah4+yzjL5J3G1ULdkHHgRcowmrjkWDkVxKACOE0/tM9j9O5DcKg?=
 =?us-ascii?Q?FgRggRLaMHURhgjtgcBYnpjXd/jkPFWgTM+w/DiTeoVB9la90rqzL2qYCjXR?=
 =?us-ascii?Q?Pwf5ss7SAfppZAiX5pC2YTutCuxIPoDEHOn1sJ3XnHRj+Kg/dwppAAs1XgJw?=
 =?us-ascii?Q?WxTwLiFaiLN+iNdi9MBLBgPYbhinzXvBMrR6MmsQnXFqByRSyM2IU0Cqotie?=
 =?us-ascii?Q?H9WBY2b+umS5B9J0nBQQgcUIxK5u7iZ3KhBZvn/nkf/9iNIgiFJEur0wWA1s?=
 =?us-ascii?Q?+vL5ohfUoipv1laNGeeTZ7s7q7TvncbtMw3k4W/1T+RKrabUD9tReL8pYG+S?=
 =?us-ascii?Q?hn80aEJw+NHfbMKMDiLinLSvuSHF9vmHck5zfqhO8+prgxQBOBMkNelVHuNI?=
 =?us-ascii?Q?1YvehAt+hmgGuKwpWICf9tH1USBG3zuMT3bSDhKImWDQ2jq/yhjQTXC4yov3?=
 =?us-ascii?Q?/gv7M0RivJPICAzx3i1lsT5+0FO2Kof890v2cG1LMDYOcNu2IjvLhqenYwKD?=
 =?us-ascii?Q?AjYGugXBC/eNR7DvRuWlGsOJMht6IFIygYxVVzklr5ElwABe2JkU5uA5rVlp?=
 =?us-ascii?Q?JxGQaWe/x68DyDhvgRDN+JGHP09+xKc8Sg9ZRlkiGdE2rTm8Eur2+rk7UXAh?=
 =?us-ascii?Q?kpDSgiS34CMKSnG1E1fCXeQqTnMcXDOIAzXCr1ilAZrBChgw1axB3fM53//z?=
 =?us-ascii?Q?shmctERE7zWoDNbT1hA/8UBJFX3TliqcUdKk7M9zbnJd8kdQH7Wf/CiCL+GV?=
 =?us-ascii?Q?e3qWxVj7115XMcJ1BFA4uOOnpX5paitT9b2zBZlzyHqP6wJv5GuNLz4TW/uV?=
 =?us-ascii?Q?3uWj9ShCtVc7GPHKCZ117b17Zt+VGqIKvQPR0o5PTRrOMVQ32X2dcDonJS2I?=
 =?us-ascii?Q?VDhb0jtF/KSxSbw8WpRdt1aisYHyiPHBoI0/VbNT0UVB83gQQXig0VQZ4SHz?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h7uvCxV6rL6FLC0CxGqbkh99RWnRZ7SEkdeI2+6bvxTiEFNJEW6Z4qTg2Hs6JQbJ4ikfKlHFbA+vGi3yScCBUVkhiuxJx1AWOligS8Pbu934+8q2wxborMGfEVWAf3m7hN1JBuXhBKNG94Ib7hQ1jn+tiiDK6qItj0W/dSLpAaEbJglzELwzITqP6REX+I2MZhRxeK0L9+jTUvhBKfr7UEH/I8XJAh5iHsWAmnDrKSEX7CTBhna8BfdP9EJ5R++ipfwp7pBpkVPvelOi1sNhZ6KL2xcvMLDLPSZBtmQ6vjxVfxtJqVNmSTtVTE+cOQA29q7NaM3Ua91wDoPs1Y6giktkwDMmwH39lHY8/4pO9HojY2T9Qf7vZ0Sa4wFg/RQbNZuD2qbKyPbD1WyXgrBK0J4U0BId+4GuDjr9g6dwrn/z3a1PfHHaTUT2ml7cBZT44SIDXEsTEJv9vf+0rLmkxYBdo2qz+56UByu+AFSCjuBw4r/WOUgBqG8kn7nvy0SfGfb5jJj+A3hnyhj/Hno1yaavsMVsEdseSODNLT0VxrjfVjXBtO4jiKeL54fnB02t1lq8lezoZGmHXMULC0Mke1NQ94mn8OOBDYzvwyKLIE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3d9801-af61-4288-b637-08dc653103cc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 14:07:17.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdI0eXEaju2EbXF7f5yNhBkCmYGv2Sf3ozjaIfKu8l/1QDGiQSsf0hQK7yuk0auYfXUd4derQ+cFKt0dfboVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250102
X-Proofpoint-ORIG-GUID: KI7rrxcLhRH2lfgqgstR1oXhw17B0RFt
X-Proofpoint-GUID: KI7rrxcLhRH2lfgqgstR1oXhw17B0RFt

On Tue, Apr 23, 2024 at 03:25:37PM +0200, Lorenzo Bianconi wrote:
> Introduce write_threads, write_version and write_ports netlink
> commands similar to the ones available through the procfs.
> 
> Changes since v8:
> - introduce scope parameter to write_thread command
> - add the capability to specity multiple threads in write_thread for future
>   usage
> - fix comments
> Changes since v7:
> - add gracetime and leasetime to threads-{set,get} command
> - rely on nla_nest_start instead of nla_nest_start_noflag
> Changes since v6:
> - add the capability to pass sockaddr from userspace through listener-set
>   command
> - rebase on top of nfsd-next
> Changes since v5:
> - for write_ports and write_version commands, userspace is expected to provide
>   a NFS listeners/supported versions list it want to enable (all the other
>   ports/versions will be disabled).
> - fix comments
> - rebase on top of nfsd-next
> Changes since v4:
> - rebase on top of nfsd-next tree
> Changes since v3:
> - drop write_maxconn and write_maxblksize for the moment
> - add write_version and write_ports commands
> Changes since v2:
> - use u32 to store nthreads in nfsd_nl_threads_set_doit
> - rename server-attr in control-plane in nfsd.yaml specs
> Changes since v1:
> - remove write_v4_end_grace command
> - add write_maxblksize and write_maxconn netlink commands
> 
> This patch can be tested with user-space tool reported below:
> https://patchwork.kernel.org/project/linux-nfs/cover/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org/
> 
> Jeff Layton (3):
>   NFSD: move nfsd_mutex handling into nfsd_svc callers
>   NFSD: allow callers to pass in scope string to nfsd_svc
>   SUNRPC: add a new svc_find_listener helper
> 
> Lorenzo Bianconi (4):
>   NFSD: convert write_threads to netlink command
>   NFSD: add write_version to netlink command
>   SUNRPC: introduce svc_xprt_create_from_sa utility routine
>   NFSD: add listener-{set,get} netlink command
> 
>  Documentation/netlink/specs/nfsd.yaml | 110 ++++++
>  fs/nfsd/netlink.c                     |  66 ++++
>  fs/nfsd/netlink.h                     |  10 +
>  fs/nfsd/netns.h                       |   1 +
>  fs/nfsd/nfsctl.c                      | 517 +++++++++++++++++++++++++-
>  fs/nfsd/nfsd.h                        |   2 +-
>  fs/nfsd/nfssvc.c                      |  11 +-
>  include/linux/sunrpc/svc_xprt.h       |   5 +
>  include/uapi/linux/nfsd_netlink.h     |  47 +++
>  net/sunrpc/svc_xprt.c                 | 167 ++++++---
>  10 files changed, 870 insertions(+), 66 deletions(-)
> 
> -- 
> 2.44.0
> 

Applied to nfsd-next (for v6.10) with many thanks!

-- 
Chuck Lever

