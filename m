Return-Path: <linux-nfs+bounces-4869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D792FC8D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 16:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC935283923
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 14:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE34171E49;
	Fri, 12 Jul 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pip4gh24";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K163Luwd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91C8125D6;
	Fri, 12 Jul 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794553; cv=fail; b=qBvwZ08KdTAdshwjA/nw3S267TzNK6O6A2oIRoq8sS17aeutebYEOWSXAiJRq7TaH+mG0GZ3XZxmQEcbAGo6YAM6ZGzZLGWz+pLLf2mExd9C7KLwquPHAwwYp2xhswcmMfXEqVDYFK26qv5a1bDupoJvYxyK04lJleZvKy4PdY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794553; c=relaxed/simple;
	bh=xIrjKo+pXs8IfamlyYnmsKRoflYMTOrM6attM3GaaZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O/BZq/l46/2g1kAXYv+GDw3tuWkbjWsB40kQ/FMcxhg8QWxpFLoPqg7xkDJjDiWDgXc0uGIBFlrnryXdto0hpNOd73FcKb/Vb2DQSoN40A2+RE6iqouPe3sCtudB1+TA+egie2cWHiRXaR6Z6iYkZZNH65SGaWysBNzb7lUc2Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pip4gh24; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K163Luwd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIjPv028175;
	Fri, 12 Jul 2024 14:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=U/V3623mcZTEYLb
	C9cBIm5Zsb0/jlQOquNuDmBpNO94=; b=Pip4gh24ZvPlWD0fQw8+K96Z2cpKgby
	8o/5XL4OkIJj0Ra8Ea3M+BOBcj8O2abZpSQjhxAmgMitg7GSq3rpdMmNTtooUEnu
	Oun5RRcTZ52UoUnJI0DVdz7pMizCogbRKsHOajdawhIwGlcf6FLavHTCwf9PJmqK
	iev9vIunlf63NhzozWqRg1/Zp8hxYVbcFDEOjpXFFztNOlk5fwSaxry9rtDqPB6h
	PFHHn6KI6vbnlOsClkCSJ5/qgi+iWP43WN++LqS9e8BUYMCUeEhn3hxPqt9j9dAe
	Y55mpEPvR582N8KLJnL+8dgFpO9+Fhxtd13ZEPWF+FwQNyc29gX8J3g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkyc67n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 14:28:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CDmDt2010418;
	Fri, 12 Jul 2024 14:28:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv75fv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 14:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiYalCUdOFmZlD8OmCMimoQg3xmiORsms4wZ3uenAwhzutlqEaaLyTHc8Hsuo2e2qmJy3NjuWmQ3hPZQLPYhjR1oEKdwBVxsCO9+a2SbrUWQbTwQrDkn4AZ6JZcfg1CTZ3SVLn9inyl3grcjVUcLFuRCkfvoi1z6SqDNEzBOcUf0BIuMB4hvvHfdSpXMnQJbR8SAC1qYlEyf0X2mtlg7xE+B+ugrze/6GCrod4Gyl7wLSVXtdR69dxl2J3VduJEs9lqxqy58k2RMhUz5XX+Vry44IuYH1Hxf+qicgmlouBes5s1qw7ANWPU0FIVeZLRe5VQbQUZhWkyrbrMWVvEqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/V3623mcZTEYLbC9cBIm5Zsb0/jlQOquNuDmBpNO94=;
 b=d5c4lWhCGVDztEIYm04fcviVVVDnUQ3VyUWcWxA3PpaEvAnoVIXOsv/ABZi9+5U28XnSIBk4Zlqf1dAz5G43ymSyo1P7GZUC/Agg2Bm2WXzsBth12GfoWHrkrwQiigcrt4RMbunhRw7TJQZ6HYdlVjOEyhyhVILt+VKe7BvyycjcnJq15ZcxLv3+sc3JI1vGOYkS43TWD7G9oRUnfjIz4g+k1nKFO9IQq0UvkCjreacpiLUuIvTx+O6SDTvjL/qRA8KnpbC5kGSzRrOyUtE/Tscx774KeDtzK/fCGb+5kYq3bCzXIDVkHDk7ggKCoGH3Circ3rs6JZtRUr9vdoDq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/V3623mcZTEYLbC9cBIm5Zsb0/jlQOquNuDmBpNO94=;
 b=K163LuwdhLIgRPLsAPmUHY6cyy7gIo7U1x6w7iTNvjD01LK2ej+rIl41IGgPMrqm4ZDA9vmL0Jad3bM3ZXIraUrBwZemFriUzrZ1KAKLQNOaot77Cv4IQlh+uyI70UrVMsWtrB8X5m8hu3UfW4Ruw7wcEmj45HEVZScpmddQzQQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7793.namprd10.prod.outlook.com (2603:10b6:408:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 14:28:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.024; Fri, 12 Jul 2024
 14:28:42 +0000
Date: Fri, 12 Jul 2024 10:28:38 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH -next,v2] gss_krb5: refactor code to return correct
 PTR_ERR in krb5_DK
Message-ID: <ZpE9luTCrUnh8RBH@tissot.1015granger.net>
References: <20240712072423.1942417-1-cuigaosheng1@huawei.com>
 <ZpEx/Jejy/CiXE5Z@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpEx/Jejy/CiXE5Z@tissot.1015granger.net>
X-ClientProxiedBy: CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc42590-860c-413a-8163-08dca27eee33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1qXFslYa/6vSzTE/xQwqtK28wIGgU4wdl1wAly4iK8s95nMCcS91HeXlhlUs?=
 =?us-ascii?Q?4o0DBzqMVndILho4ClhdT/8nw1t10Vuvao9O2yTT+8ygiYSkcrcKShljUpJW?=
 =?us-ascii?Q?HBtysiGZlFoOZFfP61nGRqFhJIhmvRBKILz2J7dt6gZYeWv15mK+bD+Z/Tls?=
 =?us-ascii?Q?f+Jo+20I+5gN/czYsrlMcXTlh4i7aDG0GMPl3UyggiBtmkjBjgN1/PbWYEpf?=
 =?us-ascii?Q?UW67AJQSUCn0MKJ0sW4jYJrJc0So6E/g0F3AKZt8L0+bMD7H910+8enssa1b?=
 =?us-ascii?Q?cB/C0YN8Kg6JQJ/uyllb5fzTwEBnFbix+HD3BXYJKqz0FGgnAbjWDWeAkcUG?=
 =?us-ascii?Q?cFZBE5N0rajxbFnKHKybgMoO8yUalVd2I2+yykeRJkELf5LeGcDnep0jhnZT?=
 =?us-ascii?Q?S+ttdEHzxwCcG0EYPIgcEhUCqxuqF2uUZn/tD1RcP17JtEbAUtmP/gflY0Px?=
 =?us-ascii?Q?8DAMpiCSifw2MkolPCug9/hXIm/5TBI34iLl+AdTW5Y8DYBkhYg/h3W5rUFI?=
 =?us-ascii?Q?MqhGDg8ZAhX6DiUd9IEGoPaJUlTVfd5YRP8KAbFPMN+R/iitLoUTn8KnwcYV?=
 =?us-ascii?Q?X1tPV6X/enrxdtpRrJSlKjAZhpIC47DvrIQoTVUXVPcAKfzV2O4bTDZIazoR?=
 =?us-ascii?Q?JykPXUNqbCC+n8zFdJagqWnlgEbmJY4dDcltsTFnhC5ZwOkWxcOKb9u+1ZJz?=
 =?us-ascii?Q?gP6cSOoQk+ZU2V8WPShh7DmcgeJc+korcOybgM80FTrBrCbmXklKE4sY30dX?=
 =?us-ascii?Q?WRRypN5IGU6SKfLBLzfVj6XtuvxkJ4B2P3oHQwdISVFl/jDXAb8Rsye6Wfnx?=
 =?us-ascii?Q?TsE+iuFmpyk6pMp4bTiGLUZ8KP/5wPAJrJtdiWdAddYfy5tGRXKBgOs4QTA/?=
 =?us-ascii?Q?BuchysJZPmUUJFdADabfpuOyWpA5myUy7u9sWgNB4LCB7Xnx5SS5Yl4KTkPV?=
 =?us-ascii?Q?iG1gE8QPHspjiNN6bw5aZumfAR9S3IEbyQCslY5wJuqaHePuWuQCYrjbh90T?=
 =?us-ascii?Q?S+6ZX58Gzz6tvtI0K1Y9AixSecBr7DwdBp6lgTF72f9UIgjAYwMdkZqLHy4J?=
 =?us-ascii?Q?ygQh7HHipn78hKtExy4gxdKTKwUeF2D6CVl7IR5OgdwywCdbNLNSkNSiOBJO?=
 =?us-ascii?Q?Ji2PVvRpzaV+LWHMeW54qvnGD8GTC7wgPVeoTzUCbXd6L5pLDIY98FdKZdPJ?=
 =?us-ascii?Q?PQp4PwLsfPuCZpIOgFSpC3BU8WM/NYtPNNqj+hgd3uenXCYKMCxr3Mo+p6IW?=
 =?us-ascii?Q?OHAwi2zXFBoOvAWssI6J8DJ/OvkGnlieeKnZ/DZwT4L0xJ+15TU0pNRmpwzO?=
 =?us-ascii?Q?n59U4kyqz65LigSpxiPude7TWiq8dJkOIZ6qSV8yxddxMg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Yuj16NRFO8VFQgPuJk4WgFA7oAkmbQi3DSIkO5HtUSKj0w98c/CbWbEHuEHS?=
 =?us-ascii?Q?N5H6ZTSvWDGp3csKAWKyB4v6TRJg9+6N0Vxq6EJn84lpaAFQEb/1LxOpwkH0?=
 =?us-ascii?Q?bG+a1+wgqiU2GbYXXSubp3nTwyyR5nfYXOzXe5mmo4KklFweIje8FlylkZ4J?=
 =?us-ascii?Q?W01Kd5ym/o+DBnEAZIITxIu8AGlOLS2j11S3N+JeFVh53Lr1vV0SfJtrABxq?=
 =?us-ascii?Q?O/4IDNpc2d2Whg0HdJZ9wyKY/TyILA3y28MTtImaGKY8KSx8+PJR+6gv7vSB?=
 =?us-ascii?Q?5ODoKl4vaW8WSQysS4evUVykShxZp2tdkRxdNJZ2+bgRhVs2u1uuEj46Wihu?=
 =?us-ascii?Q?hJ5mwwt4xbNk51JRMC9Zk14h7D7CpOiwt3mIC+PLo99Klc/yvqsUdHgDeo+e?=
 =?us-ascii?Q?MabviB9tdUaSrfP1mwaz8712ZRaSbYeWdutShGAzIV3TCTbVePz/CXUFm/Pd?=
 =?us-ascii?Q?AWCjrVfowgP1F3PDcP09rL3vutm2IjIsQfrb5pZHgvjdJ+TkzFJudWIj2MWS?=
 =?us-ascii?Q?r/DbvT85VyEIzF7cT0hNo7vkSCDIz6eH9jBks1RHqdqcGra7MnXdsYkvrORe?=
 =?us-ascii?Q?QAMKHiisyropoNLGbIq3CvOt+LqGKPQgM9N64qDzoufk0Nf+bUIVfKyEVIXN?=
 =?us-ascii?Q?egvO+J+z8CsrkU7l3U6xZlL2ZkB+/dd8h8JU2rdyyy+PeRHsBSvO5IV//fCF?=
 =?us-ascii?Q?gUkV2Qf+ayMbS9c/E81nyW3pCoO8oygsuoYowAxd2J1dcob6g170bRjrml6f?=
 =?us-ascii?Q?1Y2NIih416u+ZGIygSChbtT1q/uMAzD0WpFOR45ohQkIRz1mV0BKySBT2Vp7?=
 =?us-ascii?Q?aq6OIS1Aj8fOEEP03XSiSWjBoCz5JKcvPKqlKQaDQ2BCGJP2pTJke/MXxq8X?=
 =?us-ascii?Q?+uYqyCmzN64XACMXjUHcxqxUQ4xP4z6zyFDhhsPVwrUyfkFy48eJ42jLzJsN?=
 =?us-ascii?Q?smoEDUAs2wEPWFfKBFGlSifaqoH2fpGLlo/mzffaeThexTKK0KGgOv2dE9Fi?=
 =?us-ascii?Q?6Q6qcIWSXekQ1gfC/VePzKWlGI+QNeQItPc7yLDuBIJK3YUFsbszaHvaaHZv?=
 =?us-ascii?Q?EyO+9PcUI90+ATvNPpgZUM0amswbR4Vx9WqCYnnNPsmWht8vbuzygGRpcOq2?=
 =?us-ascii?Q?fJ7CjRX4rNMzb9xSs8gqstEQZLXx3/dNAZ6EW2QUoAvSloLi2xwAaIPHPONr?=
 =?us-ascii?Q?4/ncRUBd4gEjGpzz2yFwqiB/vvlFUfn2poX4eRYaqlYqpfjQg9dW1k35SLOV?=
 =?us-ascii?Q?OWZyhGTaJ+vte7cvPZtD5yzdvgqHgcufrEMIzggBe3BIVGubCK1DopdBG/He?=
 =?us-ascii?Q?8qJBFWo7gtTVUnpXGd4GafdtGNcKpsBh4nmxMsgn9oMviGYEFmmDOPC7enBt?=
 =?us-ascii?Q?KDHuqHcTVllRZlUKXH9yKBucK2iV80hYwOdL5g2GEOaBqNjNY1STPBrd3KGN?=
 =?us-ascii?Q?3g1C+Ld3+QYMC5ZXYbGlcMF80oXU4opDLKYC9lf/y5xt28n1mGVsivzmWpK+?=
 =?us-ascii?Q?bvSzzeTZLZ5ByNM0VQ/KbAEbtEgVnQKcjJ5ppvQvC5YXdneRxV3bqp2H8YXg?=
 =?us-ascii?Q?wfS7H2R6SlW0didYIaeKFCm2cYggUTWBLwfWCdOue66kPOrIVE5yA+LQY5/r?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vS7nSxatcT8jLogqkNDhHMZyJgOcXVIfrH6kwp3a+zpxJZ7CKt6w4VmVcFMVTCPnmtW94nINoMs7/fi2l80+5tWZLIeBF5iroVuQb5yhflBOmfGsfeLmZoTyLA8mwj4Y5EKnLFvH8YeN8rYeMonYsSplCSO09gfJvf51GMZ3I136qL8jo9Wy/4kSaBzh8+OQOhAHW5x8Ol1vT1VSvvjflPdN09lhiGnhoh8iERoZ6FSutAW1ep5phEuprxsD9SxP8RDOWYCTQjcwhOjyve0JBc2DFwOayWKyvhaTHLRrM/parTpPSnSQFDnDOd2vQ7bZdtKxOqpwGrRrrL8EzFbb0W+dBBAeWJDx2gwRSJnHQ7Zo0R7aGppLp9tl8yBT+G05Ii4VEI2oTT8yE9XNRYrVYlI6DL/GTu7NANQAP3sC9eFz+C0N7xLmaTfFyYgtPUzGKUCbB5FI4F+/8LFbS8cpmFjNalR5XXqP44siUQxKdlzDIQpQ789AMLFbrLQgbjb3I9YugCH7bB64cMzaFCP8R1MJ4oyZPWAx2IKCnO4hSg2gN8S4hls6rL1959S7u0USD8YmSm+LO8muaSS7oisrPyzj3Nrt4nD2QlAzIgiqeLg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc42590-860c-413a-8163-08dca27eee33
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:28:42.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN7EYQ7t/C4SkXoTauyCJMTEW6a/CJGSBhZjxSQ4mtpWoDVMrD11JBTOIDfRKb71JPDIH8Tg8RW1dUinad2geQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120098
X-Proofpoint-ORIG-GUID: cL8MoFHMOF_iLqRxOofmnXgLqPXAUCJS
X-Proofpoint-GUID: cL8MoFHMOF_iLqRxOofmnXgLqPXAUCJS

On Fri, Jul 12, 2024 at 09:39:08AM -0400, Chuck Lever wrote:
> On Fri, Jul 12, 2024 at 03:24:23PM +0800, Gaosheng Cui wrote:
> > Refactor the code in krb5_DK to return PTR_ERR when an error occurs.
> 
> My understanding of the current code is that if either
> crypto_alloc_sync_skcipher() or crypto_sync_skcipher_blocksize()
> fails, then krb5_DK() returns -EINVAL. At the only call site for
> krb5_DK(), that return code is unconditionally discarded. Thus I
> don't see that the proposed change is necessary or improves
> anything.

My understanding is wrong  ;-)

The return code isn't discarded. A non-zero return code from
krb5_DK() is carried back up the call stack. The logic in
krb5_derive_key_v2() does not use the kernel's usual error flow
form, so I missed this.

However, it still isn't clear to me why the error behavior here
needs to change. It's possible, for example, that -EINVAL is
perfectly adequate to indicate when sync_skcipher() can't find the
specified encryption algorithm (gk5e->encrypt_name).

Specifying the wrong encryption type: -EINVAL. That makes sense.


> > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > ---
> > v2: Update IS_ERR to PTR_ERR, thanks very much!
> >  net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
> > index 4eb19c3a54c7..5ac8d06ab2c0 100644
> > --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
> > +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
> > @@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
> >  		goto err_return;
> >  
> >  	cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
> > -	if (IS_ERR(cipher))
> > +	if (IS_ERR(cipher)) {
> > +		ret = PTR_ERR(cipher);
> >  		goto err_return;
> > +	}
> > +
> >  	blocksize = crypto_sync_skcipher_blocksize(cipher);
> > -	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
> > +	ret = crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len);
> > +	if (ret)
> >  		goto err_free_cipher;
> >  
> >  	ret = -ENOMEM;
> > -- 
> > 2.25.1
> > 
> 
> -- 
> Chuck Lever
> 

-- 
Chuck Lever

