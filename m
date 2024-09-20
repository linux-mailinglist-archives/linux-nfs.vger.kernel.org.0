Return-Path: <linux-nfs+bounces-6580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C997D9C8
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 21:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3009728400C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 19:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D524183063;
	Fri, 20 Sep 2024 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKN9Qbgp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OpYY4klJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5717BEAB;
	Fri, 20 Sep 2024 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726860021; cv=fail; b=qwht9IYlUEgc0GJt6T0iVRP3ZzmWeuCCJj169NdebDrTaJw9Dc4Xq+Xhh5mmIATlcFpQvHSK+kPfXznHdlHW0xbO1WQj21LUiKnlOVtcfQGEwwOLzVjwJpnOh2IdEWQFiBkfh5ILSIkBziNjsfpA4QoOo9ZYFh0V2b/KFF29JWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726860021; c=relaxed/simple;
	bh=oFQf/BgwehFc0KKuyIF39Mr3jfSNksxevuP5/qSY38o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oddx8uhZN6oWtVGrRdpB2rt5SqYrS0TkkhLEIrdjlQiBgJpDH/OT9y2T3JtBKU/2dykdFZPYJqdY4VyQ9u7v/f+8clDPHGAemAKSaG6DsFHiODKpqA+8YDjbrHcnocBwysIvCbuvaAZCVTl5CZPcfS7aZ2edLs5pUijQ38eiSOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JKN9Qbgp; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OpYY4klJ reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KItbch018546;
	Fri, 20 Sep 2024 19:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=K9fQlUav0R1TgkITQji+IWPrx9BFuK3sAqEezgVmcuM=; b=
	JKN9QbgplPpImkKcdZPtEtj+OY/nZjvFcsIuHQRo4/Z6CYD79kqCR74+mtXcaWx8
	zE7b0dz1LegDRVu1wAe8qQ+AfNJzZfAK2SybQ7fL9RaBQNUKzqg/duxx6g1R1KOP
	6mQAMJsHZgY9ZDDsqUW+eX3Zf9SbTKET5RZCPInKAsH04gvhLHvkEbuuPvY4QfvZ
	P+Oc/tgwAATY2mYVvsyMMrToXQSIMKbCcpUIpiDYAp/iTHw15p36yFYdTC33dnro
	I4TUZXcNnscovSJ8JXv59+vhYlzPQC5vzgbXcoHHC+9n+2f3Dv8tCMOQ5Kzza/i3
	nor2JmcMvKITT1hemAERIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfyjhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 19:20:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48KInjxs018599;
	Fri, 20 Sep 2024 19:20:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyd27qc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 19:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyQgweaqWefiLZ8keh0SYH6N7bM9hBJHvPiW47hOlPJS+WlgLOzndfp4r/ZxG6hPSX426oCcFXCHLevDyphpu1AKo23obUGHB3OqS27DGSJSMRpywXRzRmJhZmDDYjCII+7WvOjZHKyAtKydNEPTw04tAS3lvSvO8w79OW4Cs4DcbkvkBpkYg4hDcPMfIn7sZQJw8EH8Z/shb7kX2lb2ErW+8ZRyzugHHlfRwlC3zfMoy+7Faflklx33Q2zp5raaAEm1Pyf2jIiDqRdRLH/EQL5UImM/xCVFn7JUwnkQHJxoFO90ycRAJO8pXwWOLqh7YF6pIpKN0320NPpTNPUozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pybz7TLLC4qsYM81DI4DmOz48umNEJks+R6t/1Yz3TU=;
 b=rRxJdBLCBhoLBCkXxpPzMlcWDCtkqPCZQ7aU/p1qkCPTSp/XMvnsK7eVB3oNhXSSkxMxNtDBt0xuOIuGiQBwgWs6bTXD0jvNOrpX0rj8rF+fUND5Q/Ad+vmB0qUtiQvej0BQc0CAJmz2nAkVMPReurEtnQ8rD7hWnemgSF/5Ar5q1D1UDh6hg1WEcwvTSJDAvc+n6hGMKOr7X24mYS3FijSr3+AkJOJrq+hOMMIk9Q8OkRaIhxJo5HG4jOrATiRO7zFtsDBjfXLFvm9O7/3Dyvh+Ya1kQNBicDPxGskfNSIRgGC4R1Gj078p6cpUe+MoOTSjkqY64qhd05l/4HoydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pybz7TLLC4qsYM81DI4DmOz48umNEJks+R6t/1Yz3TU=;
 b=OpYY4klJPhE/FnW10WySKIZ02UC0r5ezYe9PlGgFkaq1rT8ALMHuDQL50zg0jjV8A/CCQFhI8k2JjfXDYUE43xhQ6seejKBmFYrrGk5WGj4jTRC/EnqNkrkLtW54KNlbF4JYo48bO3vEAeTK8wXH/jwJ/aKh96MIaNiO48Ixkds=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB6992.namprd10.prod.outlook.com (2603:10b6:a03:4ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Fri, 20 Sep
 2024 19:20:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8005.010; Fri, 20 Sep 2024
 19:20:02 +0000
Date: Fri, 20 Sep 2024 15:19:59 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Add support for mapping sticky bit into NFS4 ACL
Message-ID: <Zu3K34MHFUYNaRfu@tissot.1015granger.net>
References: <20240912221523.23648-1-pali@kernel.org>
 <Zumizr3WnA+XY9ge@tissot.1015granger.net>
 <20240917161050.6g2zpzjqkroddi22@pali>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917161050.6g2zpzjqkroddi22@pali>
X-ClientProxiedBy: CH0PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:610:74::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: c167add0-6222-4973-8aaa-08dcd9a9399f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?v4Ktfz3PJ1CSPB4/Ai0CFta1xy/rbT637kg7SkRmRLpjIfAwvdYjrn9ytk?=
 =?iso-8859-1?Q?9YJYCJpFlysJUhMwwCHypTPj1yorQqbyt1fzjZuhLZttX2LzaPpGcV8Yop?=
 =?iso-8859-1?Q?nQAbDKVbqPnZ7C2oQIsWgXNmSroBLHHZBpxedYlO5Z5LT83s6bLu4CxBdm?=
 =?iso-8859-1?Q?QW6N0YaeiSYZQyPwP77y1HCTXgKpk8CNGdjmH643BzYFz0Jx742WPm1r+I?=
 =?iso-8859-1?Q?nlj/zWDuStJMuCc0LJmWaY07iof8RVw00qrPL5PoHdGXmqWiMw1LG1C249?=
 =?iso-8859-1?Q?DkaH2xswjgkipr0AOF2TxfcLKNvza2y1GpNyG8OgEDqpXPzKKkqAVOFPgP?=
 =?iso-8859-1?Q?mLxrpvdHRZyZzZynse8wObyNlfIkoe6fvbById4murSek7w3tKkzNzBhzt?=
 =?iso-8859-1?Q?tgJRUEmIaCmd1FNOTOeAkY7GgsA3iTZhM3V2JY9jkfpH72ykhPMw66otsr?=
 =?iso-8859-1?Q?6FUEvo/Op7hxw3WppTL/81tVKwdNNLwrPrpyYFuDpPfxarkWCfHgVrR+Co?=
 =?iso-8859-1?Q?xUYhZ6hkEv4gi4xK7VPlOX8BMvQYKQ+yY8JSvlV/bzd40KvFNQbIbeyOwU?=
 =?iso-8859-1?Q?5jm2Lylx2xF0GqHk+ZSqPUF13lPLJ9ipz9rgp7m8zCUMTTBMwjnT5iP6YK?=
 =?iso-8859-1?Q?OEV6ZSG5o7UMd9yoy9CZAs2SiD6vZ/gA9jLZ7DOwloHvRA5kYG/P6oS4EN?=
 =?iso-8859-1?Q?piH34kIdKA6Zo0BvcS/aFWhIjPU89Zt4PhHCHlt7+TvoMqVFW2NcxFKs1T?=
 =?iso-8859-1?Q?kYoDGRu2SqPswHiOtdbEelzAK9WU0XFtiBlhBvZ/lnyFdDT03YU3f7amhm?=
 =?iso-8859-1?Q?rv4EhBgNA0K+PrNVPrVElSge+in+usdWlD247hTV+5TyDnl3a6yAL5jzmj?=
 =?iso-8859-1?Q?bD7X3OEsq0lxWVo0y4uhNzORZoQh+CKEUOfGxAp6BE3GhRB2Jt5rAgTjcP?=
 =?iso-8859-1?Q?6XGMjwBB5cIL278eVT3vN22G6S0ZlbXfEEh8WAYF/CMVbRTM+n6hkZhVrx?=
 =?iso-8859-1?Q?RKqxuQ6s5E1SzXzMnA6vpcv/0HIEi6XLNQk2T1vA4vt1LLQEt8crDu0Xva?=
 =?iso-8859-1?Q?foC4vZiiKYauQWIxbnYcWvWzkmysnsedXB5/gms7KPnaZV24S/o1cnJgd+?=
 =?iso-8859-1?Q?+eLtV+6+zFWYD2OZMH5XUkPoMslZkfQADeA3CjNz6C2nqsQLPZhW0Ed0C+?=
 =?iso-8859-1?Q?1ksrborugZX19N2BduGvIxqg/Psy0vIl6kIOgpQm8yG9U+hFDsRse+EMgD?=
 =?iso-8859-1?Q?A+L012xYtaK/krpZnexw5ww7mbs/92oIg2GG/QAGC7Us8iWlBQ2UnQeOWe?=
 =?iso-8859-1?Q?5orwulY2lL7KaGXpdCBt8sevzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?cCIvtvrgf6SWnybPSKSHNCbvjuDAeTrjG3vBkornFbJ2bbQPRPegoPgT7x?=
 =?iso-8859-1?Q?hMmhB71bAldjxFPK0aTCrMBFBxiamwZx6rl54HdwOZM7A7hn+4UDmeRK7Y?=
 =?iso-8859-1?Q?mwP+lKYOYtSLV4Yx9JLE/684T48BtC62bDEO2dgZx/8CSGwWToTqymvdTi?=
 =?iso-8859-1?Q?cqLVoTjw0buU5IsQJGD7uBhHZ6SO5VA3PcmAk42nzIVDG5B1otIF3dxCTG?=
 =?iso-8859-1?Q?v5UJCk3le98RNBZWkbNsYcJbftaV4braFEg6bUBhWHvPqRg8LMiW+Za8dG?=
 =?iso-8859-1?Q?su7ayeB785DrCPuMN5k6krrkfbZkkIdpEPugitR6gkHDchlYZCzLJ7Erky?=
 =?iso-8859-1?Q?HGSkpGpfEinsl7pKPQdeknzI1cn5Oc7WMdDbVKy6v9IcG0p6Rf/jU2XfIq?=
 =?iso-8859-1?Q?Z7CsWk6rifbZeP3wXm4qI+nmGNBqwpRjcmka6AacCfDb40JyzMXg3GBpLC?=
 =?iso-8859-1?Q?bxh3IOcAS2fjADj8kBV0BxNsPmYbbZVXA+c/ggdUVtwVIuYiZR9K65m2JD?=
 =?iso-8859-1?Q?rzFyPDs/xzGXlxz8uC48PhD3vbhZb89ZcQiDsqs65XHq5Ly2wNF4OScvby?=
 =?iso-8859-1?Q?SV4ctbKY5uCZ3uLMA8P7s1bo8osB0HUHjsPCieklTqNZ0B1VareaV0/PX4?=
 =?iso-8859-1?Q?0AjXB1OS9L83mCyeXzLjGysWjo+PQ6D1oSMUb2C2jPGFCj8w3EUoRuhqBw?=
 =?iso-8859-1?Q?vbHKljmXn+yFDE6NLqwOM6jYDbDAd4zn1BGLpsWm7q2+OQAAsTxX7OP6A9?=
 =?iso-8859-1?Q?LPhybQuMdtWro7weu2KDV8vnTm+phthM9vRbWck9Exg1OZsI/2ioGS+PVV?=
 =?iso-8859-1?Q?QyQ2H7qyXGtTYfubCzKLOPpPk4dXabMZcRiHFWch1gBwjZoBLOOGyg5p80?=
 =?iso-8859-1?Q?7id7MreBDCCEfhklIyYza+AvLF4jpHVIok6skAc21TV5kdaMQJz2rhLbwM?=
 =?iso-8859-1?Q?cM2WLhF4nHPQ5LzioOrmI5bAecdY2/CzQzRFuiNq0ukWO2YJJj9wN50Bos?=
 =?iso-8859-1?Q?o2W5lfVyY98/CCo1vBHGVZJiUlriQinWY7BGI2kzGNTg1k+U5Qd7gezrS6?=
 =?iso-8859-1?Q?KhdExovTa+RoQOQtU24gkQu374qKMQ0ZSGSRHq/7YesqUmbY5iYk7Db70o?=
 =?iso-8859-1?Q?MUMgfWLwmyZoraEXK88LxgRAMujzNzfMaVKA3IjV6QK1tEndw/jicoHNNX?=
 =?iso-8859-1?Q?pA137XvHyIoMZcb+mqXqoum4jIDsMlNmgYcpNVyYdZIxChGusixzP77GR6?=
 =?iso-8859-1?Q?/jNYMopFtnmgs6Yw40Ts1NPBSl8aIXvYJyIUzCUkh+NKXbaIp9HxeUqz/g?=
 =?iso-8859-1?Q?/QkV65OiCAdMKSbCckq0k4q3KwjNchsr9EzFe6Do6mTJOvhIUcCY+zRikC?=
 =?iso-8859-1?Q?yZgSRwXAMma0NAM+QsnI/LI7zbah35ewAZKOt1kjgGgDgl7yEsdl609wRx?=
 =?iso-8859-1?Q?Tk7MzQtOBcadkimjM6DpVxrlnVSUvTKHqb4KD2WKUfgoqISmOuWbO4mIaV?=
 =?iso-8859-1?Q?F5mD4mpHvYHCAxoOCU/AOg/ZSXzdTT5FhVZNW3SlD9r0gldxj0IQF1wZzT?=
 =?iso-8859-1?Q?3LsGjcZFVyp4PabvVkp53fstIha9HuzUd3pvOX4Jqi5mA89VmrYEAzh54d?=
 =?iso-8859-1?Q?vKPkoOdyZ8n9X9N5r5TtAiRi5vh0zR3/l3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OcdTOqNGinhCN4ik84ioTTe64mGyYfjx1tUpXjO1FcbgX/Fx4CJQB6cyB5I3PdzWnNpX15ehvDTxlakKIkCXy5O4Y9rBwkVqADGB+jPyNR7TGGMk3Exts9PH/Grw/9hj9P8bST2V+tv/HX7QBLoQ9Bg2N0M/OlA3Rf5bJOkNzUFsmHjzsLGjyxJU+un5kYRiepZlWHpawef6cquH4+urTTigwg4db2U05F3pV8GsmoodPqitz2bPSsa5uitBamQDyKvu1xprXfN+FDmmNVrbJSZNU2fPydz49iomdJf+JWD8H4/vkMFbDDIsguJyiEJx2I9ItP9te2cZrd6/YNwm3AmKspwsL2zm2vkPBCt+5nrgtaHZU1a4CScUpEaqj9ywf2SF2aK6m36KtigQWTOwAvnTwb8LXB023Y/yKea7OlHQAdqvSsrx+xpp3EtM0lbYXRWZCZ7SrdGHNyQeUQsnbdmWCkvAJPi9Dt67ojV5ODndnQUWklQ1Jh0ZEkqm8DttMimxVV/nXzgkpHnIVw/tc6jFlWbt4+hfvheT03PhQGerV6f9mYDiBvyCAGtL4WHChA+Q/XF15I5xb3N7lp9FqQgqy5Mp3u2HQKPuAzsCgwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c167add0-6222-4973-8aaa-08dcd9a9399f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 19:20:02.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxUbhvpqJJELGg08HiEAPdRBnQ5v1LUbUcFEm5bV9KF2lnZ4V2MOy117b+sbyXBhyXYDz23RTKJDSE8VnlFQew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_08,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200140
X-Proofpoint-GUID: 1iVQjpVv_pVhbxuF3OKyuw5ea6OgOsox
X-Proofpoint-ORIG-GUID: 1iVQjpVv_pVhbxuF3OKyuw5ea6OgOsox

On Tue, Sep 17, 2024 at 06:10:50PM +0200, Pali Rohár wrote:
> On Tuesday 17 September 2024 11:39:58 Chuck Lever wrote:
> > On Fri, Sep 13, 2024 at 12:15:23AM +0200, Pali Rohár wrote:
> > > Currently the directory restricted deletion flag (sticky bit, SVTX) is not
> > > mapped into NFS4 ACL by knfsd. Which means that the NFS4 ACL client is not
> > > aware of the fact that it cannot delete some files if the sticky bit is set
> > > on the server on parent directory. If the client copies sticky bit
> > > directory recursively to some other storage which implements the NFS4-like
> > > ACL (e.g. to NTFS filesystem or to SMB server) then the directory's
> > > restricted deletion flag is completely lost.
> > > 
> > > This change aims to improve interoperability of the POSIX directory
> > > restricted deletion flag (sticky bit, SVTX) and NFS4 ACL structure in
> > > knfsd. It transparently maps POSIX directory's sticky bit into NFS4 ACL
> > > and vice-versa similarly like it already maps POSIX ACL into NFS4 ACL.
> > > It covers NFS4 GETATTR ACL, NFS4 SETATTR ACL, NFS4 CREATE+OPEN operations.
> > > When creating a new object over NFS4, it is possible to optionally specify
> > > NFS4 ACL, so this is covered too.
> > > 
> > > For client SETATTR ACL, CREATE with ACL and OPEN-create with ACL
> > > operations, detection pattern for restricted deletion flag is ACE entry
> > > INHERIT_ONLY NO_PROPAGATE ALLOW OWNER@ DELETE together with check that
> > > nobody except the OWNER@ has DELETE_CHILD permission. Note that the OWNER@
> > > does not have to have DELETE_CHILD permission in case it does not have
> > > write access to directory.
> > > 
> > > For client GETATTR ACL operation, when restricted deletion flag is present
> > > in inode, following ACE entries are prepended before any other ACEs:
> > > 
> > >   ALLOW OWNER@ DELETE_CHILD                                 (1)
> > >   DENY EVERYONE@ DELETE_CHILD
> > >   INHERIT_ONLY NO_PROPAGATE DENY user_owner_of_dir DELETE   (3)
> > >   INHERIT_ONLY NO_PROPAGATE DENY OWNER@ DELETE              (4)
> > >   INHERIT_ONLY NO_PROPAGATE DENY user1 DELETE               (ACL user1)
> > >   ...
> > >   INHERIT_ONLY NO_PROPAGATE DENY userN DELETE               (ACL userN)
> > >   INHERIT_ONLY NO_PROPAGATE ALLOW OWNER@ DELETE
> > > 
> > > ACE entry (1) is present only when user OWNER@ has write access (can modify
> > > directory, including removing child entries), because it is possible to
> > > have sticky bit set also on read-only directory.
> > > 
> > > ACE entry (3) is present only when user OWNER@ does not have write access
> > > (cannot modify directory) and it is required to override effect of the last
> > > ACE entry which allows child entry OWNER@ to remove entry itself. This is
> > > needed for example for POSIX mode 1577.
> > > 
> > > ACE entry (4) is present only when anybody else except the directory owner
> > > has no write access to the directory. This is the case when sticky bit is
> > > set but nobody can use it because of missing directory write access. So
> > > this explicit DENY covers this edge case.
> > > 
> > > ACE entries (ACL user1...userN) are for POSIX users which do not have write
> > > access to directory and therefore they cannot remove directory entries
> > > which they own. This is again needed for overriding the effect of the last
> > > ACE entry.
> > > 
> > > When restricted deletion flag is not present then nothing is added.
> > > 
> > > This is probably the best approximation of the directory restricted
> > > deletion flag. It covers directory's OWNER@ grant access, child OWNER@
> > > grant access and also restrictions for all other users. It also covers the
> > > situation when OWNER@ or some POSIX user does not have write access to the
> > > directory, and also covers situation when nobody except directory owner has
> > > write access to the directory.
> > > 
> > > What this does not cover is the restriction when some POSIX group does not
> > > have directory write access, and another POSIX group has directory write
> > > access. This is probably not possible to express in NFS4 ACL language
> > > without ability to evaluate if user is member of some group or not. NFS4
> > > ACL in this case says for the owner of the file that the delete operation
> > > is allowed.
> > > 
> > > The whole change is only about the mapping of the sticky bit into NFS4 ACL
> > > and only for NFS4 GET and SET ACL operations. It does not change any access
> > > permission checks.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > >  fs/nfsd/acl.h      |   2 +-
> > >  fs/nfsd/nfs4acl.c  | 242 ++++++++++++++++++++++++++++++++++++++++++---
> > >  fs/nfsd/nfs4proc.c |  31 +++++-
> > >  3 files changed, 255 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
> > > index 4b7324458a94..e7e7909bf03a 100644
> > > --- a/fs/nfsd/acl.h
> > > +++ b/fs/nfsd/acl.h
> > > @@ -48,6 +48,6 @@ __be32 nfs4_acl_write_who(struct xdr_stream *xdr, int who);
> > >  int nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
> > >  		struct nfs4_acl **acl);
> > >  __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
> > > -			 struct nfsd_attrs *attr);
> > > +			 struct nfsd_attrs *attr, int *dir_sticky);
> > >  
> > >  #endif /* LINUX_NFS4_ACL_H */
> > > diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> > > index 96e786b5e544..6a53772c2a13 100644
> > > --- a/fs/nfsd/nfs4acl.c
> > > +++ b/fs/nfsd/nfs4acl.c
> > > @@ -46,6 +46,7 @@
> > >  #define NFS4_ACL_TYPE_DEFAULT	0x01
> > >  #define NFS4_ACL_DIR		0x02
> > >  #define NFS4_ACL_OWNER		0x04
> > > +#define NFS4_ACL_DIR_STICKY	0x08
> > >  
> > >  /* mode bit translations: */
> > >  #define NFS4_READ_MODE (NFS4_ACE_READ_DATA)
> > > @@ -73,7 +74,7 @@ mask_from_posix(unsigned short perm, unsigned int flags)
> > >  		mask |= NFS4_READ_MODE;
> > >  	if (perm & ACL_WRITE)
> > >  		mask |= NFS4_WRITE_MODE;
> > > -	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR))
> > > +	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR) && !(flags & NFS4_ACL_DIR_STICKY))
> > >  		mask |= NFS4_ACE_DELETE_CHILD;
> > >  	if (perm & ACL_EXECUTE)
> > >  		mask |= NFS4_EXECUTE_MODE;
> > > @@ -89,7 +90,7 @@ deny_mask_from_posix(unsigned short perm, u32 flags)
> > >  		mask |= NFS4_READ_MODE;
> > >  	if (perm & ACL_WRITE)
> > >  		mask |= NFS4_WRITE_MODE;
> > > -	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR))
> > > +	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR) && !(flags & NFS4_ACL_DIR_STICKY))
> > >  		mask |= NFS4_ACE_DELETE_CHILD;
> > >  	if (perm & ACL_EXECUTE)
> > >  		mask |= NFS4_EXECUTE_MODE;
> > > @@ -110,7 +111,7 @@ low_mode_from_nfs4(u32 perm, unsigned short *mode, unsigned int flags)
> > >  {
> > >  	u32 write_mode = NFS4_WRITE_MODE;
> > >  
> > > -	if (flags & NFS4_ACL_DIR)
> > > +	if ((flags & NFS4_ACL_DIR) && !(flags | NFS4_ACL_DIR_STICKY))
> > >  		write_mode |= NFS4_ACE_DELETE_CHILD;
> > >  	*mode = 0;
> > >  	if ((perm & NFS4_READ_MODE) == NFS4_READ_MODE)
> > > @@ -123,7 +124,7 @@ low_mode_from_nfs4(u32 perm, unsigned short *mode, unsigned int flags)
> > >  
> > >  static short ace2type(struct nfs4_ace *);
> > >  static void _posix_to_nfsv4_one(struct posix_acl *, struct nfs4_acl *,
> > > -				unsigned int);
> > > +				unsigned int, kuid_t);
> > >  
> > >  int
> > >  nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
> > > @@ -142,8 +143,11 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
> > >  	if (IS_ERR(pacl))
> > >  		return PTR_ERR(pacl);
> > >  
> > > -	/* allocate for worst case: one (deny, allow) pair each: */
> > > -	size += 2 * pacl->a_count;
> > > +	/*
> > > +	 * allocate for worst case: one (deny, allow) pair for each
> > > +	 * plus for restricted deletion flag (sticky bit): 4 + one for each
> > > +	 */
> > > +	size += 2 * pacl->a_count + (4 + pacl->a_count);
> > >  
> > >  	if (S_ISDIR(inode->i_mode)) {
> > >  		flags = NFS4_ACL_DIR;
> > > @@ -155,6 +159,10 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
> > >  
> > >  		if (dpacl)
> > >  			size += 2 * dpacl->a_count;
> > > +
> > > +		/* propagate restricted deletion flag (sticky bit) */
> > > +		if (inode->i_mode & S_ISVTX)
> > > +			flags |= NFS4_ACL_DIR_STICKY;
> > >  	}
> > >  
> > >  	*acl = kmalloc(nfs4_acl_bytes(size), GFP_KERNEL);
> > > @@ -164,10 +172,10 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
> > >  	}
> > >  	(*acl)->naces = 0;
> > >  
> > > -	_posix_to_nfsv4_one(pacl, *acl, flags & ~NFS4_ACL_TYPE_DEFAULT);
> > > +	_posix_to_nfsv4_one(pacl, *acl, flags & ~NFS4_ACL_TYPE_DEFAULT, inode->i_uid);
> > >  
> > >  	if (dpacl)
> > > -		_posix_to_nfsv4_one(dpacl, *acl, flags | NFS4_ACL_TYPE_DEFAULT);
> > > +		_posix_to_nfsv4_one(dpacl, *acl, (flags | NFS4_ACL_TYPE_DEFAULT) & ~NFS4_ACL_DIR_STICKY, inode->i_uid);
> > >  
> > >  out:
> > >  	posix_acl_release(dpacl);
> > > @@ -231,7 +239,7 @@ summarize_posix_acl(struct posix_acl *acl, struct posix_acl_summary *pas)
> > >  /* We assume the acl has been verified with posix_acl_valid. */
> > >  static void
> > >  _posix_to_nfsv4_one(struct posix_acl *pacl, struct nfs4_acl *acl,
> > > -						unsigned int flags)
> > > +		    unsigned int flags, kuid_t owner_uid)
> > >  {
> > >  	struct posix_acl_entry *pa, *group_owner_entry;
> > >  	struct nfs4_ace *ace;
> > > @@ -243,9 +251,149 @@ _posix_to_nfsv4_one(struct posix_acl *pacl, struct nfs4_acl *acl,
> > >  	BUG_ON(pacl->a_count < 3);
> > >  	summarize_posix_acl(pacl, &pas);
> > >  
> > > -	pa = pacl->a_entries;
> > >  	ace = acl->aces + acl->naces;
> > >  
> > > +	/*
> > > +	 * Translate restricted deletion flag (sticky bit, SVTX) set on the
> > > +	 * directory to following NFS4 ACEs prepended before any other ACEs:
> > > +	 *
> > > +	 *   ALLOW OWNER@ DELETE_CHILD                                 (1)
> > > +	 *   DENY EVERYONE@ DELETE_CHILD
> > > +	 *   INHERIT_ONLY NO_PROPAGATE DENY user_owner_of_dir DELETE   (3)
> > > +	 *   INHERIT_ONLY NO_PROPAGATE DENY OWNER@ DELETE              (4)
> > > +	 *   INHERIT_ONLY NO_PROPAGATE DENY user1 DELETE               (ACL user1)
> > > +	 *   ...
> > > +	 *   INHERIT_ONLY NO_PROPAGATE DENY userN DELETE               (ACL userN)
> > > +	 *   INHERIT_ONLY NO_PROPAGATE ALLOW OWNER@ DELETE
> > > +	 *
> > > +	 *   (1) - only if user-owner has write access
> > > +	 *   (3) - only if user-owner does not have write access
> > > +	 *   (4) - only if non-user-owner does not have write access
> > > +	 *   (ACL user1) - only if user1 does not have write access
> > > +	 *   (ACL userN) - only if userN does not have write access
> > > +	 *
> > > +	 * These ACEs describe behavior of set restricted deletion flag (sticky
> > > +	 * bit) on directory as they allow only owner of individual child entries
> > > +	 * and owner of the directory to delete individual child entries.
> > > +	 * Everyone else is denied to remove child entries in this directory.
> > > +	 *
> > > +	 * For deleting entry in NFS4 ACL model it is needed either DELETE_CHILD
> > > +	 * permission (access mask) from the parent directory or DELETE permission
> > > +	 * (access mask) on the child. Just one of these two permissions is enough.
> > > +	 * So if there is explicit DENY DELETE_CHILD on the parent together with
> > > +	 * explicit ALLOW DELETE on the child, it means that deleting is allowed
> > > +	 * (evaluation of permissions is independent in NFS4 ACL model). OWNER@
> > > +	 * for inherited ACEs means owner of the child entry and not the owner
> > > +	 * of the parent from which was ACE inherited.
> > > +	 *
> > > +	 * This translation is imperfect just for a case when some group
> > > +	 * (including group-owner and others-group) does not have write access
> > > +	 * to directory. Handled is only the edge case (via rule 4) when
> > > +	 * everyone else except owner has no write access to the directory.
> > > +	 * This information is not present in NFS4 ACL because it looks like that
> > > +	 * this is not possible to express in this ACL model. So for ACL consumer
> > > +	 * it could look like that owner of the file can delete its own file even
> > > +	 * when group or other mode bits of the directory do not allow it.
> > > +	 */
> > > +	if (flags & NFS4_ACL_DIR_STICKY) {
> > > +		/*
> > > +		 * Explicitly allow directory owner to delete child entries
> > > +		 * if directory owner has write access
> > > +		 */
> > > +		if (pas.owner & ACL_WRITE) {
> > > +			ace->type = NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE;
> > > +			ace->flag = 0;
> > > +			ace->access_mask = NFS4_ACE_DELETE_CHILD;
> > > +			ace->whotype = NFS4_ACL_WHO_OWNER;
> > > +			ace++;
> > > +			acl->naces++;
> > > +		}
> > > +
> > > +		/*
> > > +		 * And then deny deleting child entries for all other users
> > > +		 * which do not have explicit DELETE permission granted by
> > > +		 * last rule in this section.
> > > +		 */
> > > +		ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
> > > +		ace->flag = 0;
> > > +		ace->access_mask = NFS4_ACE_DELETE_CHILD;
> > > +		ace->whotype = NFS4_ACL_WHO_EVERYONE;
> > > +		ace++;
> > > +		acl->naces++;
> > > +
> > > +		/*
> > > +		 * Do not grant directory owner to delete child entries (by the
> > > +		 * last rule in this section) if it does not have write access.
> > > +		 */
> > > +		if (!(pas.owner & ACL_WRITE)) {
> > > +			ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
> > > +			ace->flag = NFS4_INHERITANCE_FLAGS |
> > > +				    NFS4_ACE_INHERIT_ONLY_ACE |
> > > +				    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
> > > +			ace->access_mask = NFS4_ACE_DELETE;
> > > +			ace->whotype = NFS4_ACL_WHO_NAMED;
> > > +			ace->who_uid = owner_uid;
> > > +			ace++;
> > > +			acl->naces++;
> > > +		}
> > > +
> > > +		if (!(pas.users & ACL_WRITE) && !(pas.group & ACL_WRITE) &&
> > > +		    !(pas.groups & ACL_WRITE) && !(pas.other & ACL_WRITE)) {
> > > +			/*
> > > +			 * Do not grant child owner who is not directory owner
> > > +			 * (handled by the first rule in this section) to
> > > +			 * delete own child entries if there is no possible
> > > +			 * directory write permission (checked for named users,
> > > +			 * group-owner, named groups and others-groups).
> > > +			 * This handles special edge case when only directory
> > > +			 * owner has write access to directory.
> > > +			 */
> > > +			ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
> > > +			ace->flag = NFS4_INHERITANCE_FLAGS |
> > > +				    NFS4_ACE_INHERIT_ONLY_ACE |
> > > +				    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
> > > +			ace->access_mask = NFS4_ACE_DELETE;
> > > +			ace->whotype = NFS4_ACL_WHO_OWNER;
> > > +			ace++;
> > > +			acl->naces++;
> > > +		} else {
> > > +			/*
> > > +			 * Do not grant individual named users to delete child
> > > +			 * entries (by the last rule in this section) if user
> > > +			 * does not have write access to directory.
> > > +			 */
> > > +			for (pa = pacl->a_entries + 1; pa->e_tag == ACL_USER; pa++) {
> > > +				if (pa->e_perm & pas.mask & ACL_WRITE)
> > > +					continue;
> > > +				ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
> > > +				ace->flag = NFS4_INHERITANCE_FLAGS |
> > > +					    NFS4_ACE_INHERIT_ONLY_ACE |
> > > +					    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
> > > +				ace->access_mask = NFS4_ACE_DELETE;
> > > +				ace->whotype = NFS4_ACL_WHO_NAMED;
> > > +				ace->who_uid = pa->e_uid;
> > > +				ace++;
> > > +				acl->naces++;
> > > +			}
> > > +		}
> > > +
> > > +		/*
> > > +		 * Above rules filtered out users which do not have write access
> > > +		 * to the directory. Now allow child-owner to delete its own
> > > +		 * directory entries.
> > > +		 */
> > > +		ace->type = NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE;
> > > +		ace->flag = NFS4_INHERITANCE_FLAGS |
> > > +			    NFS4_ACE_INHERIT_ONLY_ACE |
> > > +			    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
> > > +		ace->access_mask = NFS4_ACE_DELETE;
> > > +		ace->whotype = NFS4_ACL_WHO_OWNER;
> > > +		ace++;
> > > +		acl->naces++;
> > > +	}
> > > +
> > > +	pa = pacl->a_entries;
> > > +
> > >  	/* We could deny everything not granted by the owner: */
> > >  	deny = ~pas.owner;
> > >  	/*
> > > @@ -517,7 +665,8 @@ posix_state_to_acl(struct posix_acl_state *state, unsigned int flags)
> > >  
> > >  	pace = pacl->a_entries;
> > >  	pace->e_tag = ACL_USER_OBJ;
> > > -	low_mode_from_nfs4(state->owner.allow, &pace->e_perm, flags);
> > > +	/* owner is never affected by restricted deletion flag, so clear NFS4_ACL_DIR_STICKY */
> > > +	low_mode_from_nfs4(state->owner.allow, &pace->e_perm, flags & ~NFS4_ACL_DIR_STICKY);
> > >  
> > >  	for (i=0; i < state->users->n; i++) {
> > >  		pace++;
> > > @@ -691,9 +840,14 @@ static void process_one_v4_ace(struct posix_acl_state *state,
> > >  
> > >  static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
> > >  		struct posix_acl **pacl, struct posix_acl **dpacl,
> > > +		int *dir_sticky,
> > >  		unsigned int flags)
> > >  {
> > >  	struct posix_acl_state effective_acl_state, default_acl_state;
> > > +	bool dir_allow_nonowner_delete_child = false;
> > > +	bool dir_deny_everyone_delete_child = false;
> > > +	bool dir_allow_child_owner_delete = false;
> > > +	unsigned int eflags = 0;
> > >  	struct nfs4_ace *ace;
> > >  	int ret;
> > >  
> > > @@ -705,6 +859,28 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
> > >  		goto out_estate;
> > >  	ret = -EINVAL;
> > >  	for (ace = acl->aces; ace < acl->aces + acl->naces; ace++) {
> > > +		/*
> > > +		 * Process and parse ACE entry INHERIT_ONLY NO_PROPAGATE DELETE
> > > +		 * for detecting restricted deletion flag (sticky bit). Allow
> > > +		 * SYNCHRONIZE access mask to be present as NFS4 clients can
> > > +		 * include this access mask together with any other one.
> > > +		 *
> > > +		 * It needs to be done before validation as NFS4_SUPPORTED_FLAGS
> > > +		 * does not contain NFS4_ACE_NO_PROPAGATE_INHERIT_ACE and this
> > > +		 * ACE must not throw error.
> > > +		 */
> > > +		if ((flags & NFS4_ACL_DIR) &&
> > > +		    !(ace->flag & ~(NFS4_SUPPORTED_FLAGS|NFS4_ACE_NO_PROPAGATE_INHERIT_ACE)) &&
> > > +		    (ace->flag & NFS4_INHERITANCE_FLAGS) &&
> > > +		    (ace->flag & NFS4_ACE_INHERIT_ONLY_ACE) &&
> > > +		    (ace->flag & NFS4_ACE_NO_PROPAGATE_INHERIT_ACE) &&
> > > +		    (ace->access_mask & ~NFS4_ACE_SYNCHRONIZE) == NFS4_ACE_DELETE) {
> > > +			if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
> > > +			    ace->whotype == NFS4_ACL_WHO_OWNER)
> > > +				dir_allow_child_owner_delete = true;
> > > +			continue;
> > > +		}
> > > +
> > >  		if (ace->type != NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
> > >  		    ace->type != NFS4_ACE_ACCESS_DENIED_ACE_TYPE)
> > >  			goto out_dstate;
> > > @@ -725,6 +901,38 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
> > >  
> > >  		if (!(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE))
> > >  			process_one_v4_ace(&effective_acl_state, ace);
> > > +
> > > +		/*
> > > +		 * Process and parse ACE entry with DELETE_CHILD access mask
> > > +		 * for detecting restricted deletion flag (sticky bit).
> > > +		 */
> > > +		if ((flags & NFS4_ACL_DIR) &&
> > > +		    !(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE) &&
> > > +		    (ace->access_mask & NFS4_ACE_DELETE_CHILD)) {
> > > +			if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
> > > +			    !dir_deny_everyone_delete_child &&
> > > +			    ace->whotype != NFS4_ACL_WHO_OWNER)
> > > +				dir_allow_nonowner_delete_child = true;
> > > +			else if (ace->type == NFS4_ACE_ACCESS_DENIED_ACE_TYPE &&
> > > +				 ace->whotype == NFS4_ACL_WHO_EVERYONE)
> > > +				dir_deny_everyone_delete_child = true;
> > > +		}
> > > +	}
> > > +
> > > +	/*
> > > +	 * Recognize restricted deletion flag (sticky bit) from directory ACL
> > > +	 * if ACEs on directory allow only owner of directory child entry to
> > > +	 * delete entry itself.
> > > +	 *
> > > +	 * This is relaxed check for rules generated by _posix_to_nfsv4_one().
> > > +	 * Relaxed check of restricted deletion flag is for security reasons
> > > +	 * and means that permissions would be more stricter, to prevent
> > > +	 * granting more access than what was specified in NFS4 ACL packet.
> > > +	 */
> > > +	if (flags & NFS4_ACL_DIR) {
> > > +		*dir_sticky = !dir_allow_nonowner_delete_child && dir_allow_child_owner_delete;
> > > +		if (*dir_sticky)
> > > +			eflags |= NFS4_ACL_DIR_STICKY;
> > >  	}
> > >  
> > >  	/*
> > > @@ -750,7 +958,7 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
> > >  			default_acl_state.other = effective_acl_state.other;
> > >  	}
> > >  
> > > -	*pacl = posix_state_to_acl(&effective_acl_state, flags);
> > > +	*pacl = posix_state_to_acl(&effective_acl_state, flags | eflags);
> > >  	if (IS_ERR(*pacl)) {
> > >  		ret = PTR_ERR(*pacl);
> > >  		*pacl = NULL;
> > > @@ -776,19 +984,23 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
> > >  }
> > >  
> > >  __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
> > > -			 struct nfsd_attrs *attr)
> > > +			 struct nfsd_attrs *attr, int *dir_sticky)
> > >  {
> > >  	int host_error;
> > >  	unsigned int flags = 0;
> > >  
> > > -	if (!acl)
> > > +	if (!acl) {
> > > +		if (type == NF4DIR)
> > > +			*dir_sticky = -1;
> > >  		return nfs_ok;
> > > +	}
> > >  
> > >  	if (type == NF4DIR)
> > >  		flags = NFS4_ACL_DIR;
> > >  
> > >  	host_error = nfs4_acl_nfsv4_to_posix(acl, &attr->na_pacl,
> > > -					     &attr->na_dpacl, flags);
> > > +					     &attr->na_dpacl, dir_sticky,
> > > +					     flags);
> > >  	if (host_error == -EINVAL)
> > >  		return nfserr_attrnotsupp;
> > >  	else
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 0f67f4a7b8b2..56aeb745d108 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -259,7 +259,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > >  		return nfserrno(host_err);
> > >  
> > >  	if (is_create_with_attrs(open))
> > > -		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
> > > +		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs, NULL);
> > >  
> > >  	inode_lock_nested(inode, I_MUTEX_PARENT);
> > >  
> > > @@ -791,6 +791,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >  	};
> > >  	struct svc_fh resfh;
> > >  	__be32 status;
> > > +	int dir_sticky;
> > >  	dev_t rdev;
> > >  
> > >  	fh_init(&resfh, NFS4_FHSIZE);
> > > @@ -804,7 +805,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >  	if (status)
> > >  		return status;
> > >  
> > > -	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs);
> > > +	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs, &dir_sticky);
> > >  	current->fs->umask = create->cr_umask;
> > >  	switch (create->cr_type) {
> > >  	case NF4LNK:
> > > @@ -848,6 +849,11 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >  		break;
> > >  
> > >  	case NF4DIR:
> > > +		if (dir_sticky == 1) {
> > > +			/* Set directory sticky bit deduced from the ACL attr. */
> > > +			create->cr_iattr.ia_valid |= ATTR_MODE;
> > > +			create->cr_iattr.ia_mode |= S_ISVTX;
> > > +		}
> > >  		create->cr_iattr.ia_valid &= ~ATTR_SIZE;
> > >  		status = nfsd_create(rqstp, &cstate->current_fh,
> > >  				     create->cr_name, create->cr_namelen,
> > > @@ -1144,6 +1150,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >  	struct inode *inode;
> > >  	__be32 status = nfs_ok;
> > >  	bool save_no_wcc;
> > > +	int dir_sticky;
> > >  	int err;
> > >  
> > >  	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
> > > @@ -1165,10 +1172,26 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >  
> > >  	inode = cstate->current_fh.fh_dentry->d_inode;
> > >  	status = nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
> > > -				   setattr->sa_acl, &attrs);
> > > -
> > > +				   setattr->sa_acl, &attrs, &dir_sticky);
> > >  	if (status)
> > >  		goto out;
> > > +
> > > +	if (S_ISDIR(inode->i_mode) && dir_sticky != -1 && !!(inode->i_mode & S_ISVTX) != dir_sticky) {
> > > +		/*
> > > +		 * Set directory sticky bit deduced from the ACL attr.
> > > +		 * Do not clear sticky bit if it was explicitly set in MODE attr
> > > +		 * but was not deduced from ACL attr because clients can send
> > > +		 * both MODE and ACL attrs where sticky bit is only in MODE attr.
> > > +		 */
> > > +		if (!(attrs.na_iattr->ia_valid & ATTR_MODE))
> > > +			attrs.na_iattr->ia_mode = inode->i_mode;
> > > +		if (dir_sticky)
> > > +			attrs.na_iattr->ia_mode |= S_ISVTX;
> > > +		else if (!(attrs.na_iattr->ia_valid & ATTR_MODE))
> > > +			attrs.na_iattr->ia_mode &= ~S_ISVTX;
> > > +		attrs.na_iattr->ia_valid |= ATTR_MODE;
> > > +	}
> > > +
> > >  	save_no_wcc = cstate->current_fh.fh_no_wcc;
> > >  	cstate->current_fh.fh_no_wcc = true;
> > >  	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
> > > -- 
> > > 2.20.1
> > > 
> > 
> > Hi Pali -
> > 
> > Apologies for the delayed response.
> > 
> > Being somewhat un-expert in things ACL, I'm not sure if this is the
> > correct approach, or if it's right for the POSIX ACL-only
> > implementation we have in Linux. I'm going to research this a bit
> > and get back to you.
> > 
> > -- 
> > Chuck Lever
> 
> Hello Chuck, thank you reply.
> 
> Just to note that this does not affect POSIX ACL-only storage on Linux
> server. Everything is same as before (it is POSIX ACL-only and
> everything is evaluated via POSIX ACLs).
> 
> This change is just what Linux NFS4 server provides to NFS4 clients,
> i.e. not for POSIX clients. As Linux NFS4 server already maps POSIX-ACL
> into NFS4-ACL format, I think that it makes sense to also map
> POSIX-sticky bit into NFS4-ACL format. It allows better interop for NFS4
> clients which use NFS4 ACLs.
> 
> What is this change trying to achieve is to allow Linux server to serve
> POSIX things (like sticky bit) for NFS4-ACL clients which are not POSIX
> aware, and serve this sticky bit in NFS4-ACL language. And same for
> opposite direction, to translate NFS4 ACL rules which describe sticky
> bit into the POSIX sticky bit in mode.

The fundamental claim from your patch description is that:

> > > the NFS4 ACL client is not
> > > aware of the fact that it cannot delete some files if the
> > > sticky bit is set on the server on parent directory.

POSIX-based clients are in fact aware of this additional constraint
because they can see the set of mode bits returned by GETATTR.

So can non-POSIX clients for that matter; although they might not
natively understand what that bit means, their NFS client can impart
that meaning.

I can find no spec mandate or guidance that requires this mapping,
nor can I find any other NFS server implementations that add it.
If this is indeed a valuable innovation, a standard that recommends
or requires implementation of this feature would be the place to
begin.

What RFC 8881 does say is on point:

> 6.3.1.1. Server Considerations

> The server uses the algorithm described in Section 6.2.1 to
> determine whether an ACL allows access to an object. However, the
> ACL might not be the sole determiner of access.

A list of examples follows. The spirit of this text seems to be that
a file object's ACL need not reflect every possible security policy
that a server might use to determine whether an operation may
proceed.

-- 
Chuck Lever

