Return-Path: <linux-nfs+bounces-5360-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BDB951BA1
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 15:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80CABB26656
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5308B1AE867;
	Wed, 14 Aug 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uf58AdI9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w960JAxj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B161AE03E;
	Wed, 14 Aug 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641249; cv=fail; b=Lj1AaC/WgWIjAniX3sFTOK00LHrvyf333GzPVt8JdyOqgKJS6gwCSuCJ+m8GRM2q9MIfEJ1vVrOntaTLuGuHQjgVlKerm2E72qc+08Gtt/RIxOkSiMNGmkHz2IuMRu8CWYa7+Ok5y09eqPHs98oBTtpsJokwRkT9PETsfQh9GjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641249; c=relaxed/simple;
	bh=9WNdMTy3tLqNpuiEholr4gxsmgE16pxAJk0BqE0mCkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cHWhxIcZwKEULk8p5r2sjw/985WMCzBNuEMlXwhzYzaLKFsnnjKDE8D8BhNzMoqku30FcnfPmnyYzeIUkTcF3+GsKDC7mJRQspe/GxUfNXakcJTxj+eabHTAepJtUFKTa0/J25tvRuvPGKCkQg64aflXjC+Dqaa4FZXz6ofpQ/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uf58AdI9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w960JAxj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtZn9003670;
	Wed, 14 Aug 2024 13:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=mdPNvSD9QsIYuTU
	wZ19Xn5QaVb6zLYHr6+5BiTmMTaw=; b=Uf58AdI9SyhdzEuKx5s1RUpi06uBfxe
	ObICcMfbaEGrklw28wftFLQ2/wURCYLC8O5zFa7bK6BvjdrZ0gTSmDG423apSnTf
	pc8DRhKkdFH2aYmkNbxCOjW9kXqPxUDbJNWAglmy2e6TWhA2oqzV+qx+ouWxD5LN
	sb3Pild2W03HEut0v3XH0feWr4246a3ZPyLvTj/BBMCl7c1YnqEBvIpNF48fBWH1
	+KeMu/YgGZXLpzGG0sW1Nib84jrgHxX4uvi5t61orw7sD2aB8J8k2wrn6v7ma+2i
	eDSJ69prDhgw8p4tdS+nwHJ4xyon/ayzDf+T9/FPXs0koT+v15E5DuQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmd05yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 13:13:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EBvEkG021084;
	Wed, 14 Aug 2024 13:13:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngdkgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 13:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCU1OZF3Kp1CjOQh9f+Z6Lh+UNyye0sVs2nm2pCtidoqQ3MghpQosLUOR4TqyNxGgvE26Q90WjFP/kFuC2fcM2A3KSv4zUzJkBQnavPcaDcKUA8gWXwHX0Hdp1rM9UXTl5LC1/UBuIW4lRreGvznRFIW3jroKUUTGgQyS7EB5lNCtUlxGu1nvAQ60smQng5XSLFYfnP9IcKHlKlQn58rZ+DR5ZLFNJw/rDfSjjVRlSQr2sjoTA7EhZRtq4/AWxMNoDe0pZOhXo9Pyfl0ARpKV94g1ZXFMaDQqDN3OdeKDD2byteW7ruRzD7vPr/aTApiDMtClIOr1qhiKY3Mrex4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdPNvSD9QsIYuTUwZ19Xn5QaVb6zLYHr6+5BiTmMTaw=;
 b=QYP9kxGtzC34Fa1Cwjl1oGxwJIe5j7PmFsJVU/DSf6DE+Br2TeEgRQkUTLvhEfv2m1Dou45W9k+iAdiGuiMyMZlH7JVxpI9I37xC/qjj8gQEezsh12354SiGLuR8ruupV4jjlZK+HoO+fXR7OxB7I8s+eMUrdxzovyPdRwHaYTnxarrTJYq6QljOp5qWhBgi4tx4OoBznCoJh/PeyRQWgrpQ9utWJJgc2B+w4KulLYfkiSDcPty5s5UzSYqWxdQkQnXmCgNL+oMtvoMNKtU0YKMO7KhPKR5kC3g1XT8WsbzGOl0zyeb9sKExqN9jQtROCx2SitCOQRchjv/yltElbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdPNvSD9QsIYuTUwZ19Xn5QaVb6zLYHr6+5BiTmMTaw=;
 b=w960JAxjmvLlTCzwWCJTqnDQ4GaECGhYLDmj18T55BQUATZChSBm+JAezGyjKCLxVI2mB2iou/MYcN9qDkJdiI4Je7adJp9zdVmYhN0qq+UKFm7na/6wusOYNFO6jaZvWPYcW/qdf1ho7M3jsKZsYjoJBUmsb9lgj4rZsFe+a5w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 13:13:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 13:13:41 +0000
Date: Wed, 14 Aug 2024 09:13:35 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>, Avinesh Kumar <akumar@suse.de>,
        Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>,
        stable@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Message-ID: <Zrytfw1DRse3wWRZ@tissot.1015granger.net>
References: <20240814085721.518800-1-pvorel@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814085721.518800-1-pvorel@suse.cz>
X-ClientProxiedBy: LO3P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a62f78-0d27-4747-34b1-08dcbc62eafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YhdAFwBH6MPrvGmyOG5aklPL+L8gbgOQmc8SNGc9q9/pIjNNFY5KlQAoEXpK?=
 =?us-ascii?Q?e8bOxWwPEg+uwBqmOnhx+QWjBotORDCq2HMgUFu5hWhJVF1K0w0uoBR2vW5K?=
 =?us-ascii?Q?uuB1OW9iEPL/BQtRtj5GdwxQeS4spcwOTfT4fBrzc2HnNODtwsfpiTMm47TK?=
 =?us-ascii?Q?5/wDYNvaJiCEc+9/iGL6sLVuMIOrkeDJWXLcF998gibCBLU0oeAlkkk3llKs?=
 =?us-ascii?Q?uVkll6K+NYo/GBHnIphNNjIZcDp70ucOMBS1eNgqnQzQ+i2qcpPhGMUUHLUJ?=
 =?us-ascii?Q?TFT9tcbSLTr5/Xv4cl17ch+5bBbBySun4uCJju16/OILzujqsmduQXr+jF5V?=
 =?us-ascii?Q?irrmfhWvbENSoLziyJDTe/KjP7a07jdQEjkXAHD0fnGJBp7BPbfXN+NDbZyS?=
 =?us-ascii?Q?ix7kleaLsBcgfXsU3cnkSeLGunaXL7NpyNDpUpLeeT8Q8afwcT5V1mwO/aLi?=
 =?us-ascii?Q?OyPBTL/F8rIcsrNKbtHuxB56PuudryMO/tSzNTf8pcWNXtMvCpIqDWXoGa4Y?=
 =?us-ascii?Q?92FQKN5qeHE3SXvG+84ibcNkPmcUkOvzC7ae99MXatFE67hPfpdFj9ltm1ZH?=
 =?us-ascii?Q?BX7POD52hTcrSUVq85WkaWnQcCAulrExu3YYW8k5lAeu2Aon3YcqWX4UmzHH?=
 =?us-ascii?Q?Az8bOb+zQaji6XZOKWrCd2bfRSb/TlY2Vbc0/pgy3QCuKTzkiojnEj6sb/7g?=
 =?us-ascii?Q?IJ/uzahgFRSIo3nT+pqmtOViaemjTRWiMi3LNHo3Ruq9K5u57GgBe8r5k3Nm?=
 =?us-ascii?Q?g6HPv+kcziVNTomid+RQwd7bU3KoHl9MTCqlUufx5hsr7/L1eR3t4nm6VhKo?=
 =?us-ascii?Q?pP4odbcu+8bKsUPW6VN1htCs7NE/QdMbmOF4mhYow72Wc8qTDP6eAfBR49za?=
 =?us-ascii?Q?PkTyNBVuzVIQIH83ZyYd4F8Ntnt38O29yQ7FPocV2MTMfq3o7bs5MoD9xZCD?=
 =?us-ascii?Q?XuUIOxZ0f/ABTeb4VxMfTTIHqM/CRsZNyGJz21R2+3Vx+l3V+hqcQ1HTgynR?=
 =?us-ascii?Q?yGy1Dl87v9QOF0svKoBVRcQm+1Aj3YhXxuAITxq552jLv/SmcH6n96QtdqFc?=
 =?us-ascii?Q?9bH3dNYVS+43mxktw8mA8nDFyk8Dj/Y1xFTs8t5I0nCDCEuk7kbHwjI1Ff27?=
 =?us-ascii?Q?QmpuIu2HqvxTxoMQp6g/JYW2AaNHWkMT89VUrdUMML1IGG8K2lLrZHlGqsyL?=
 =?us-ascii?Q?0DxIALOY2Hh+uZXZ4lLXwA76GeQm5MefecnCEDypsmSzm++6vJzQN6glC0Su?=
 =?us-ascii?Q?dalLatMOXgAoYmFf46R7TJOoRVZHOzQraAi+OnBfHGcoLyczqcl4KJp/vuC4?=
 =?us-ascii?Q?CAGVOuWnVCWhJrImaCVGpZme?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Om1R4MbWm2/nmmUaVLnUy5gf0u6qhkTZDAvJH4iZcmO6mMsRtz6f+9LEZNvI?=
 =?us-ascii?Q?Zosnf8WPubZVluyZqmcMsCNYgbMOn7AwxhQGeqAcn9K68+rN5FPulHweaubk?=
 =?us-ascii?Q?V1rgIYqlpNwh1uEeGU/fBvX3tjJswqyLvtYQOPwXQDo1kDv4GiAFdQP9BWxV?=
 =?us-ascii?Q?/3R3DfRDrE0uyeow/Lzg8WJy4BQKP82zNiOnXS8q+GURYgbnEhuLX4Vhp7mT?=
 =?us-ascii?Q?BA7FWIcLKRw+bunVy/G0LgVZqAIPqvK8/DlNa2M3AkLQ8LKgA+vQ9vUNdZey?=
 =?us-ascii?Q?u4kLv+T0NurOsFwEkt5QgWmkiOAC8sIb0WoEnvbZ6+V6CQc6O9hrGB/Nw7tr?=
 =?us-ascii?Q?UXNqYB0vomboDwLbV5ifRXZtI/PSZk1Wbe89ezP8pLxWXcsh0fV37xZOU6fl?=
 =?us-ascii?Q?cL+whNWKu/Ezp5GlwRVhwWBOVZT7ohZLi+9clsCM0kFoB6SpSrDWYDkIEfXJ?=
 =?us-ascii?Q?dzWTndtil+9WtWAVxd8wPlxAS1OdjBiV0kLaIIGTBkh+CvJ7j6gVOVT4e1XQ?=
 =?us-ascii?Q?Pgy6T0dTNug9jVNmPk/38OTSxPv9oVLildXZk+dx/2ziAIG/81cJSWdNSeiY?=
 =?us-ascii?Q?E32LTtoCPrvL6FdI0mY7s3+ZmdrwOJC2j2dC0+4VU+lniw+Qm7lLQjG12f9Q?=
 =?us-ascii?Q?aGp0DErkfGJ6oPRZUW+4tIsnpwfFYT9uKdJEXSK+ZRaZ1Lmduqi0IT9KYRsv?=
 =?us-ascii?Q?g2FtVTKX6HQgWS3mQtFrSfPI5PvkX9jRegqtWApVkdWQkEEsfbqSERiPhQMc?=
 =?us-ascii?Q?omO94UYF0KJAeILriB0m/iw5XagLlu0/QhdeS0kRn/+AAttpdPppf7cSWA7h?=
 =?us-ascii?Q?h4GBLycdao/sfkL3PNeFmhnGKjWts2coG6DOgAtWslJF2mGz05UyfEPyogGM?=
 =?us-ascii?Q?HyaSPk+9tHEPExy7eIE16hFB1SQikAjTSQJL/boiNXJCF6hz6b01J/IA0MrD?=
 =?us-ascii?Q?Sli0jwSb5DGNcqyh+pgFvTtmguHD50F0xOG7yvrPaOsYCOJFxVuZyaNwZEGu?=
 =?us-ascii?Q?t+ahCFfy4Qd9DsKhJue7T+/69IAc8sLCwiltIM6cqzMPRbvM9rYE+7DTn/dT?=
 =?us-ascii?Q?/rpMFDTyYvx/+9bf5lmqQj2sqaUJwQkvwNbOcWS/dmVafCVD4KrPRFxR5NXp?=
 =?us-ascii?Q?0szn9LPls1rQiN1afLCzXf4kzTOoyIE4N3Gzc++y3tt5QwuSwPIYb9WWcTBa?=
 =?us-ascii?Q?eTFF/eQ5dN5+FjsA92DjQqo/DrkrVEAgYtt80LzVW4fzLKGsUoBFp3BkxjU8?=
 =?us-ascii?Q?DinDXoDwEEEuZwWdxblPobA0qUf5CcG25JoPj6Jgy7IT1jT4NAXu5eVc126T?=
 =?us-ascii?Q?75u1OAUURKbrpTaXGijBKVrzWZCmQAQEHyESVGz1XMVO8bDPCsDqERltpMOJ?=
 =?us-ascii?Q?6U0lQBdM3z6itd1Td9calr3KLytQdriNfIX75DigM5+ZTtGAlHqCjQmxPnIM?=
 =?us-ascii?Q?z//H7bBaVf47biFq79/1VE5PTfuDyCfxSUvS7Oa/t+e83ZPIl9ct/aV3UGJy?=
 =?us-ascii?Q?TYv9R7upOlpxmQp+aUVRNfENqWCRe7aHMO/xCAxMf2Ov8p1DiPehHZbCKQgj?=
 =?us-ascii?Q?1bdm47smhTrZV+wmJ0Csp3pWAAUp2l6SV3KL2b2L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E6m3g87Zcm8687RmkDULfx09Z8quNnhMhC/MtuXXjJekPyeq7qBDIB0nceqYQpUn8AUhewxkCoN3mdvNpV6Px8RP0F5pA2NPNVxPY3754BcmanmUHV+OB29F/UNslwfG4lwy/GidrbA7YBE3bW0EY35xJWjA+s+fiFaUL8xUx85z0xh69IiuFobOII/jfLWpTtcKUJjt3QzlTGNxKCFX5q/a9cQbg4XkY3gigPAA7KTT9j/Tcz5VWbLHnGhjcB++6a1eqguhmzA5zjyJ7xFHWd4kht/b+R1AVBT2FdiC9cRQ98D9EsBAH1nOyZ2/QQ32ynIcR8GmP29ATNqwNElPYTOnVxr619vBQOCiwqbkhT+vdGhIH3AYJXU1c9HiYNd9sROn3GTAsVlo7KwOn/KQlTvl5e6wuX9GvEPyG5LJJeHbXLz8dcBtsVWD7yIuIRutR/maQ8aXO2kqDy5/wrey7FphEZHIvd+94UJY9azN+gZm4l8vPIj8ujWHKj6uBvKrZz0kBAjwhvvlnXYaTNwRuBU6QxLs7ovaAlSoJkho5OZFxw6RzY9PtUmrBCbGWXRqHBKFNjvLzeyoQF0JyJonK6XHHDXgPk+7zI6bz/PVgMU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a62f78-0d27-4747-34b1-08dcbc62eafe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 13:13:41.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJW4x1MagCbXLOmLYRpMn1IVXxfuZ4wM40PvGmB66h7Sl83SrDqJY2Af/wUBW/HPEoH0JeLysqMzFWBB9Mpflw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140093
X-Proofpoint-ORIG-GUID: dMUvL7AtztaPbILOGPYybOeyoQs15PDl
X-Proofpoint-GUID: dMUvL7AtztaPbILOGPYybOeyoQs15PDl

On Wed, Aug 14, 2024 at 10:57:21AM +0200, Petr Vorel wrote:
> 6.9 moved client RPC calls to namespace in "Make nfs stats visible in
> network NS" patchet.
> 
> https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * Point out whole patchset, not just single commit
> * Add a comment about the patchset
> 
> Hi all,
> 
> could you please ack this so that we have fixed mainline?
> 
> FYI Some parts has been backported, e.g.:
> d47151b79e322 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
> to all stable/LTS: 5.4.276, 5.10.217, 5.15.159, 6.1.91, 6.6.31.
> 
> But most of that is not yet (but planned to be backported), e.g.
> 93483ac5fec62 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
> see Chuck's patchset for 6.6
> https://lore.kernel.org/linux-nfs/20240812223604.32592-1-cel@kernel.org/
> 
> Once all kernels up to 5.4 fixed we should update the version.
> 
> Kind regards,
> Petr
> 
>  testcases/network/nfs/nfsstat01/nfsstat01.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> index c2856eff1f..1beecbec43 100755
> --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> @@ -15,7 +15,14 @@ get_calls()
>  	local calls opt
>  
>  	[ "$name" = "rpc" ] && opt="r" || opt="n"
> -	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
> +
> +	if tst_net_use_netns; then
> +		# "Make nfs stats visible in network NS" patchet
> +		# https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
> +		tst_kvcmp -ge "6.9" && [ "$nfs_f" = "nfs" ] && type="rhost"

Hello Petr-

My concern with this fix is it targets v6.9 specifically, yet we
know these fixes will appear in LTS/stable kernels as well.

Neil Brown suggested an alternative approach that might not depend
on knowing the specific kernel version:

https://lore.kernel.org/linux-nfs/172078283934.15471.13377048166707693692@noble.neil.brown.name/

HTH


> +	else
> +		[ "$nfs_f" != "nfs" ] && type="rhost"
> +	fi
>  
>  	if [ "$type" = "lhost" ]; then
>  		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
> -- 
> 2.45.2
> 
> 

-- 
Chuck Lever

