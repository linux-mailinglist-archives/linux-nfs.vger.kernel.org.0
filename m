Return-Path: <linux-nfs+bounces-3529-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FBB8D83C9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 15:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B930B1F22D47
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021412D1F4;
	Mon,  3 Jun 2024 13:23:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF359B4A;
	Mon,  3 Jun 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421024; cv=fail; b=TrizgbzbBNM1wsazPLOcej481tC7eyANT5HXj1b3x/Y72akkzdbQyvetsLom3buedUQmyV8U/pcz9RcW2r1XcNvQeCVedJtkvHQEL7/fIPykuDmHTW41ZzFmRvdMpU0cI7HLxneiO8iN1cubDvk4njCq0JzXzMeZSubH/Sar+wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421024; c=relaxed/simple;
	bh=CoIbwU6AR1Qwgqri0BYETwoph2kk6BM5NIP+2oXwmAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ox0tOn2TjHryRJsUrWb0yqDt4ySrdNlNrq56+WIqVJJnr+4ioxJ4hdWWovqM44DcHiCxVdmvY+DJ/o2n2jCORoLWjDHc2ZIAXVQnsF1VJeoMhT3CvgMT4u+HMzsO7G5zMD8kuH6VEEmGsK26Vm+DOeGAv3S2HRG7mwnp67cxx10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CZV35016507;
	Mon, 3 Jun 2024 13:23:38 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3Dln5opNkHQHMX?=
 =?UTF-8?Q?ZPHdfCLMYJtf/1pv2qgR/oABeOhuKc0=3D;_b=3DJ6Jli1H2nN+3UB2Ro20+ygH?=
 =?UTF-8?Q?tqMzdvDAhRV4r+YHpnYbeYs0lAoxG35sLa816atMlMuy5_yIPFdHpoldaEXj/Ns?=
 =?UTF-8?Q?E3EAyHQe6oRZqU1qrIdj5Z7oIP+MR5CFk5vvNnHy2EJcHbUx5Yf_o2/k29sMG10?=
 =?UTF-8?Q?gkLyh7AYOr0MAZcmEkg9m2nFPIhK+shVr94c0uhlEk8tXom3uHtwzkwV0_5IeC5?=
 =?UTF-8?Q?r2oLQdUFFWCzw2hozgw0rUTy2E4a1XjGWQO82R+ji0SA9hMbCG8kDDLN5dioZWq?=
 =?UTF-8?Q?_kFs0M0ZJ2Zi2upbb4rUPpRw5cs1e29coTyb2vukQtd8sQIZTLDMpZlg+RDVtt2?=
 =?UTF-8?Q?jNiZjF_gw=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv05aumr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 13:23:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453Ca5kY020535;
	Mon, 3 Jun 2024 13:23:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj0fm53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 13:23:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8eA1O7HXhBt8rdLvTxclSScNFRsgp2O4SlHJX4Q9IPHSK+RgF4djz5d7yyJiNu/DOBVVo6WskhAe104WAXraaBTW2hInFrwSuw5f0dguMGyBbXX4CXbIe0EJFJIQAN5FsoqxUE/2ffixM4JynErtuTCoHCzgt1ihSsqNz4NBreg8ToLhf//9k8hGwULYOsN2sJFRb+FKrwXSuwfUo5Zs33luQKZJPt3hhL3oB0NlTRFGVqb+4JJd1aqy7mH60dwJ452u9IOhHqYVAc2EOOGAG62nXRUORXpnS1N0F5+w2yK/XNjrbFmGa9ItbT4J3pDsGwmXf3dcOK9VSmsCYCGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln5opNkHQHMXZPHdfCLMYJtf/1pv2qgR/oABeOhuKc0=;
 b=AmHpMzwIdAea4I4u9p5w7SgmvIHiS6+dZj9iIondhQ8wNTmIw5nhGo9tnr4lMrmoeg3EH9nik2EJSaXygaNT2wzaUFrqYbUm0ASG9fpfjFqsWW+G8Tfzb9YGP4OWVmA8r753XNKJapIoAttWHJVIYLOhPDIE58bQTRahDfLXN+Qr2n8ltXUGk1Y4qXdG8vFHhImGZ4kHjsB1/5iN/ZrpTSWkAgP/2Wc0GbHFZMxaLkHctpXex7ApY+tKyWOmLiKYKBNEULntD7OUTTZM6tvHgSKvQBpKGZi/1NkGTdqCTEHcxQnLk5XNcKVYRCPc4Jmt+V9XKF6kR+h2AYcrvfgnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln5opNkHQHMXZPHdfCLMYJtf/1pv2qgR/oABeOhuKc0=;
 b=qIU92vQUO/YCGQKr8+7n7Egch4f+LayT7+RgImIrExtmOYt+Hv+XZQacnrvJre2QkUA2c9ZHuaK9VKulRATKJG9dD+R7FdID4QaYxUBTaRo8B/ehli3RPzTOEqTRJz8TSywuKn8xKQy8kn3QlCMOzWRgsXE9muSenWUD9NccJMY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7909.namprd10.prod.outlook.com (2603:10b6:0:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 13:23:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:23:13 +0000
Date: Mon, 3 Jun 2024 09:23:10 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] svcrdma: Refactor the creation of listener CMA ID
Message-ID: <Zl3DvlqRGasKmhz8@tissot.1015granger.net>
References: <20240531131550.64044-4-cel@kernel.org>
 <20240531131550.64044-5-cel@kernel.org>
 <9ae0657b-b430-9318-4e19-eae9f40307fb@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae0657b-b430-9318-4e19-eae9f40307fb@linux.dev>
X-ClientProxiedBy: CH0PR03CA0403.namprd03.prod.outlook.com
 (2603:10b6:610:11b::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a144922-705b-4ac9-c909-08dc83d05210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ommWkpqoXmD0ATtWjThg8TrQzyEUbae0HSu817TxMUKXhc5UzliGW6PcHb3e?=
 =?us-ascii?Q?iuOfA+IayzXfl0ttRVDMhMu6Am+i0evhy7YEcR0Huord/FtOv5OqAlxe75h+?=
 =?us-ascii?Q?nG0+LTTAxqhW/bnvrbmdVdENmBTlsJYLc9AAtf+WdP0PzeHrjy4lpzbmdMP2?=
 =?us-ascii?Q?tR5ZrHKxftGJjzP6ucocfQ6mKrtvHTbmihVtVHAKcDEofqRcxrfTBcbpU3wP?=
 =?us-ascii?Q?pfuzwHVPd02YKXLdZU8jLTej3Oj2a9R9sEU/idk0KAcdMUtUs+CqFJPf40yV?=
 =?us-ascii?Q?BxuhXWKm00xP8nXjaWAHXcOzhkK3JVc85JnLhl/D1MkBPmXJC5UavNW1E5Zt?=
 =?us-ascii?Q?y3WSfTSeSY6scZBADmm2Rbei8NglPFxcHTXg7Dhd4arDDitRnQgCIWBAVoIM?=
 =?us-ascii?Q?O5FDupqRgMptuUefCVQBEemSZ+h625YWJfxT9qW0BRdLBi3niD1JyNdr6kAp?=
 =?us-ascii?Q?Kd2WimKi/XAu0YNdt5SZztatPQZc0K2eX7pU0E68S2+I7aba2sKG8pwC3FOW?=
 =?us-ascii?Q?8Hs/piPIBdr6197NlFGy2rr/eitRR2IDnvLxvtgVdc3Log5czWk/moxBFDDb?=
 =?us-ascii?Q?5lt39CfKl8xEx3D4yRdIC2BBO0LOhM5zw1UH1xbNZVHQcomigsGpX6F/vWvC?=
 =?us-ascii?Q?uWHPlM3iEcKVKA1sVXyb7IJPgKGY5+2TwuVO4SaA6WEiWiQkE05fx2zlgYbg?=
 =?us-ascii?Q?JhsrleaD2JREVx9e/COD2A0WNf65fIEmvF5hXeaHXW1jbunqYqCvkRhGSPV4?=
 =?us-ascii?Q?W6B/4YPe9bd/vIkVwNd4NXIqvBArhTMKbrp3X+jXBLaiDG4heDDj+cUJ9w3L?=
 =?us-ascii?Q?jByJilV4lBMLMBqcgtr0ZJiEc0e2Va+o0gCyEiKgqXrSwUi3viP9JREQXx0d?=
 =?us-ascii?Q?V/FoaqpjTlYjBCXDvAKgnhalKiiqb04iQ5QrgF4mjpvLbNTrvsW7OEjCY3ka?=
 =?us-ascii?Q?CHxPixgFLycJrw7hoL2FQC1zr8WtuGPuynhTiLU7iczRN6yMl4cn7hq6qcr5?=
 =?us-ascii?Q?Cofc3ACQmGMfzARLOQ6TymK9xS0Z+qsMhK1RqxwhZt2HM98glzL9Fr7ErSjP?=
 =?us-ascii?Q?QGND4BlCQA1/ZEUufSuARstRTSHZZPH+XQOd6RURIeFKYFbIwZYIVSbnZ8w6?=
 =?us-ascii?Q?/tBfQQZR+XnHYuUl8SPwotG+pnz1fCv5AaT/kvBFFXZfv0uzy7tkFAbvutSq?=
 =?us-ascii?Q?0ve4T7ZzmI8P3LTKLJt9QMqWyBw7QfVzHQOmq/MxQ/5dU0dW151WoeA6Zn+D?=
 =?us-ascii?Q?d6wYPyGv6Z3VDT8SPrJftMBcrzXZodYQQgkUl7vn5Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pv26CWztakKSU7j2PSI3Mv7xiRKQAxYiL6CgK9MXqTtN+ba5/FOXsOB81b7T?=
 =?us-ascii?Q?+M8Nj3IBY1Q3FKsT1HSWrdvmqim5kk8hf3wRVYVcl/kJoajiTUO3OpYM8rSy?=
 =?us-ascii?Q?wNGrcGzCinyqe5arY+oWErIPCbn0szHR+ri4LqyGoR7GSGUv/e8WXQNS9FMJ?=
 =?us-ascii?Q?liutng8aQkjJ8pZrGGppbPaEk+HyuUBETiVHcImvSV0WNiaaiYyxu49zBkYV?=
 =?us-ascii?Q?1A+kTg8u5JX7Vajyso5aBcTZNX6UE324lDkqpH8O9JzHSCmuPnMFhqNnY3qj?=
 =?us-ascii?Q?G16SBtJ6Qrj9d+N6HPgN86BwUCJpmOGTX5+NikpRbB5Jc3s8ZWaq06cIHslG?=
 =?us-ascii?Q?MtG+cmDn8ILRHTb59I50HgINU8fEok69He+0ANd5zXLeHHOnReG5BbjyyfR3?=
 =?us-ascii?Q?MQ30GEjI5tOQW7JOavzZd/Pf2cBOi4SXY2d0f4zN5KVclKS+kmqPAjlAhnKK?=
 =?us-ascii?Q?r14Qpf/5o/dc+zaMzrFBKmtBrDMTO/dSXC+T0KaNvSQXH8hvJNqKOe69P8zw?=
 =?us-ascii?Q?MYGIPcS4vfvAlS1Z7DcQ4ExgTcRiLoYvrCmIGBXuDJTZx2PP9HvbNTBk8ISz?=
 =?us-ascii?Q?Iva8cjpoFTeMqlIV6Aog6bCfyY/AFitPgKuCkE5DqM3OIGphCoI1s8LJcS/C?=
 =?us-ascii?Q?3JyGjXMIOAWT6SOFLhh176i8NN0wXaMEmB8Pti+DWqCkSMpR2T+7vhM6Onmo?=
 =?us-ascii?Q?H8quzGVt63nz7jZIH+6IvB8k/ENJSTfY7NAoI5BO/wjUE7h8j3D9tA8ULttV?=
 =?us-ascii?Q?c40qwt0DRl+o5CpKE6CWMiNCV+cR9ZhjPI2gsAPZ3PPOcmIkKCWPHnChFq6Y?=
 =?us-ascii?Q?JZnqoJsz024U80OTc1/D706RKJxHHu2y5qWi0C5FumTJK4txkn8amknBBQo4?=
 =?us-ascii?Q?fre7HDBrm7Frtz5tuWgg4+xHXnfCE868vtYUmEmnxnrGxmThd+Ufmnoc24uP?=
 =?us-ascii?Q?a/H9Sr1K3UTiCjeK+M+dhvCrhfc943+VdkOXoU/4rpfRv4bkdQd1yOrXWUaj?=
 =?us-ascii?Q?t4QiXq0owY0mduq7bLjt734rqIwSjzr/ATklLmpx7Vzt0bm9K3VhuC6UW9Pj?=
 =?us-ascii?Q?rXuG4YhdgxbUw7UlYbpLqvBDNHBjNZrEcJxQB/ef+bUdB+s/z3Dz6HJYS/VH?=
 =?us-ascii?Q?ko2EmrLiJQL0ZS/NBvT/Y+XiPKietJPhfdfYRX+ZnrwFQ/3mXj/qvKJXg2Un?=
 =?us-ascii?Q?U/6wMwPGk743CRbD/juLZ6E0pjb49Ar0rZOhjJAaEhWD5uGXCnVZPbPImIjz?=
 =?us-ascii?Q?PHgdpTYppZyNY0TYXdQN1Xx05VNByyPu5whLS/hyEdemh7GPOXo+IWzPLSv8?=
 =?us-ascii?Q?XWJ4frGiI0e2dscPDx4/FlEdnEL3VXYU+k1tWqa7+X8nyjWXEiHcGKomthvL?=
 =?us-ascii?Q?958pDWhmQTdVMW6C8/5Wu5QORqVAup+bxoacozXaVHRdGoWj9ftT+T2MwlPF?=
 =?us-ascii?Q?6TnJpGiBUR4JMhyn4sXVzaRKcvOYPLhA5C95Mj4vXKrs5YP17s9lyXQGee2R?=
 =?us-ascii?Q?mrbPskieC3/0eQFiygv8vs1sdrm2GF1yF7igclpjrp+9uysXzz0VLnDtbqkl?=
 =?us-ascii?Q?KVKMLORmywX47u3hVYFjYjA9byJqM4VTAk+pzHUePwO/Upve0cTTTNt4wrhv?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zFk6+eUBw6/aduVVxnKKZhbweKJUGbkTss3mjEUpwVaGIua0L4tyrSASmu8BZlrDSBMEmf8ovhcA2d+fpLCH1SadZ7WxJ/Pjt1zsqXdMRphzpvfljei8ZV13qTsQQQIXKcH8bCQ8VWMo+kmXjqtTxmj76nD2TubMT2cToyIlBv0/LWsLBcAGKKzAaV4vfXhHZCIJg3SXHFkGRB72bMxCLd72dSLFKOtRc/NzXtoMA+Tmm72JFXfxxfbbulVXwubfclkmyU9M9sMVDuCHeWOgdQgXXNUG6uFLx9Wz74/iaIZKxaWvGAluaVl3SRjE+uKsY1aIUrQ4JxOovRVre3TLK0+7HszKiFABqGbDJ4m3Y+u04T7ctUyeYTwf68ZmZqs8cpr5n+1QASGzexV/orhjZ6ROQT6O23nSVP4LHi3m7R8vFlq3FfCcodeQzZht1RzOzyc3WKX+VZQuKD+ku2zQvLupwMF5Z4fUspDw4yCRnoFrz087MB3R3Ik6G0dHCv/aw97m67hpIqquFIbuqu5/mt8dHYIjQcUqVXcQEVBG080CfEx6JpdL73S7k9mnoa1eN412rCJLWll/2tex4OKnWMPmKSLXwbt9JW1oZ5C5wN0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a144922-705b-4ac9-c909-08dc83d05210
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:23:13.4139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIvX5DxeKyOu8Uv1CTX7GWEqAeDAU6fC1I4Q+O/FSH2JunXrtqBttFyeywmVkvXM4unDp6I/aBAnTsPRvnbykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030112
X-Proofpoint-GUID: UFcTlRP5Kbwo1GsXaDEK7cGEJezgs7_M
X-Proofpoint-ORIG-GUID: UFcTlRP5Kbwo1GsXaDEK7cGEJezgs7_M

On Mon, Jun 03, 2024 at 06:59:13PM +0800, Guoqing Jiang wrote:
> 
> 
> On 5/31/24 21:15, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > In a moment, I will add a second consumer of CMA ID creation in
> > svcrdma. Refactor so this code can be reused.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >   net/sunrpc/xprtrdma/svc_rdma_transport.c | 67 ++++++++++++++----------
> >   1 file changed, 40 insertions(+), 27 deletions(-)
> > 
> > diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > index 2b1c16b9547d..fa50b7494a0a 100644
> > --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > @@ -65,6 +65,8 @@
> >   static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
> >   						 struct net *net, int node);
> > +static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
> > +				   struct rdma_cm_event *event);
> >   static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
> >   					struct net *net,
> >   					struct sockaddr *sa, int salen,
> > @@ -122,6 +124,41 @@ static void qp_event_handler(struct ib_event *event, void *context)
> >   	}
> >   }
> > +static struct rdma_cm_id *
> > +svc_rdma_create_listen_id(struct net *net, struct sockaddr *sap,
> > +			  void *context)
> > +{
> > +	struct rdma_cm_id *listen_id;
> > +	int ret;
> > +
> > +	listen_id = rdma_create_id(net, svc_rdma_listen_handler, context,
> > +				   RDMA_PS_TCP, IB_QPT_RC);
> > +	if (IS_ERR(listen_id))
> > +		return listen_id;
> 
> I am wondering if above need to return PTR_ERR(listen_id),

PTR_ERR would convert the listen_id error to an integer, but
svc_rdma_create_listen_id() returns a pointer or an ERR_PTR. Thus
using PTR_ERR() would be wrong in this case.


> and I find some
> callers (in net/rds/, nvme etc)
> return PTR_ERR(id) while others (rtrs-srv, ib_isert.c) return ERR_PTR(ret)
> with ret is set to PTR_ERR(id).

These functions use PTR_ERR only when the calling function returns
an int.

-- 
Chuck Lever

