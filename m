Return-Path: <linux-nfs+bounces-4256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86679152A2
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBEFB22B3B
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3119CCE6;
	Mon, 24 Jun 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QIYrINq9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OZKv/rwl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4E19B5A7
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243569; cv=fail; b=i/GVg41vUeLglfXF59bbXOUE8Rie0XT6oN32+53DpcWTE7tEwLkEO2+GgBGey6VKEuM3gViaiSidSrmTdJ6bgRIL67wammrjWXMfXdAeH+imXAfPzuRjn56pcyKG1iL7RLJzhg/Fi52GfXeuiELuSG9tba2iFbxmQFA8/20ZyoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243569; c=relaxed/simple;
	bh=q5VxfdPZ2ugaOedqb71Rss2oiLIjS/vDMgiJYeobt04=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=D+qG6DGAdjrw9P5RTOLm1exdIRDrwDlubTmYBqy84rgfgOwA79vFRSQlioMwmIVsqfYUvN7dRof++GCf+DVNj/bRYW58FTcRXwv+W0Q5Z1icSUn/7OoRaGS53CJtKhU05QZW+aviqGzmAHqdgSukjHHHLUKDw9XU83fJP6huWBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QIYrINq9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OZKv/rwl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OEtRJk010063
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 15:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=4+xISfxTTvZcf5qtdq7/h/DErxlB2kf8BZDtDg3AvpE=; b=
	QIYrINq9SBtaWHLPS9z0vQvrmt9h4fTPSthAS+zLZPtCyO8Xm8oXNX/nX2WXciEj
	yn6BxaR8rd/Mri0/XVQg4bgy8uEBDKBYFhnUJUemXSzjoaqfRrFwvKkxQFy+4HNh
	tcozl4FSQj8bXO/EgXj80ibiJx6u7fIQ0Rg6ei4hOX1Q7O6+8iVIsVUDYb9OD1mu
	8IyouGf5Tx8/ahmXX1dwoJ9v+KZNCm8hR8hOP/0A7c3gtgsr7WSvL7VZBQTRiyvY
	2K8ZRY74/CMl0V50t/7zFwe8FaTyXnRgGlsWd+4u/5PPW1FWDS0sRd/JLnIDz3gE
	QT1zNgJgbCnubW/jUL3KEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn7030hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 15:39:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OF7ZQm001303
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 15:39:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn26va4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 15:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMvhlIWgalYiQ38xyyPh1yvBjde9gAeYAEdS7qtOQt1NDDqqFNDHAIxs68x1e78tJ/plQldvWrYrC7oF8CYXJI9kSMbnUdiqNTgWpVD1RltSv+2mq696HYXuGUHnwc7vwnBzAy5dV+i/djjShOPdKwbaIzEtyLuG+vgcaEjRXP/5ogWJD6JksgCogNXpe2rYqNOEEIulk8gSaTIgSiyZHZW6AVyAdQtc4HybLuzQ9wVl4WX0VJLhO0KAd2cz+4zwD5Dt9Prv/LpPmzc3D+jGmEzgCvhMzJtx/NUu7Sk5SUp4VXpGdLHwyh0qxmYoaIBIEa9O5yNNHiOEJY8IpO0Lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+xISfxTTvZcf5qtdq7/h/DErxlB2kf8BZDtDg3AvpE=;
 b=lRfhn9jrAVt3WMbNKTW7oZjh8yaHVbmVPG61XjuOKGjRmsvj4j06Pftyy4k9F4SM+ZCjTPJu/aBH9rIzInHjPRl9awnkWtT188VLvxjoTAfDQkS3HLMJdJigDqdn7VIsf40WOFo/Ld0mAJogzE7PUa2oQN7AMnrJvpH2LrSYWg5kojqNMnHBr10Czfrs9nI8stCptyraNezOnsScRHnywz9DqcOZLM75L3SHhw/75OPakd0IaujsI2nMGyOFW4WYxPdR5MxK1y39BTPcNf+D9R8kFRen4uG7lj7xQthW76poKDEpalgk9G0OFSqB2UHByFEiZ5K40WUXjHeluSJ49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+xISfxTTvZcf5qtdq7/h/DErxlB2kf8BZDtDg3AvpE=;
 b=OZKv/rwl1YfTwbVf4N6a/84QuhFYbjas2yXqXboR/g98jYkI0Lo9kbavxhQgyPwvKCon3m4MfZRlYFwANXg4okzyhNaNqOMe3mckqNI3pP1oz6SmTPYXi3dE1Vfycoej8aXGY2sj9K6tATrbb48raJHtYXEG26kmXxbnIbc5F+M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5839.namprd10.prod.outlook.com (2603:10b6:303:18f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 15:39:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:39:23 +0000
Date: Mon, 24 Jun 2024 11:39:20 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZnmTKDOj9VEWSNud@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:610:4f::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c26ddce-5bb5-4088-dbac-08dc9463d22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1Au7er2mN8GgsnBBy+Z2S0ByBJHnmobc0ihLmaVaofwg/ucrUW3GA2rpCURK?=
 =?us-ascii?Q?sJ5VK6WkGwaRhOGp5GgkuYJgyHdWqaeWIxzGSWIfZ5MUscaNsZYttYGQ8GTo?=
 =?us-ascii?Q?V9QZa1aPT6PEHYwvhQkEOxmt5NiXz/ttqDsTZ+wa3wpCSafAsouJO1z51jiO?=
 =?us-ascii?Q?mnBaXV99ahCtgp/wxhHD/MSj8vk0+M/rW3vwJp22kZkaQrTMv+eGKRAodRgg?=
 =?us-ascii?Q?ctf7VjqH7gkJyjEZKkaQu6t80S/IJEZRYxB4bYjBlZsNh692nciuYsde8lhP?=
 =?us-ascii?Q?RpkCNbhDzDJaIAWE1rUMYOUIycuG6P+db2LSKyjiNhE0zusQWP7qYNFSoTF9?=
 =?us-ascii?Q?lhTv/+LfbT9q1N0jUcB2XdzDyPzbxaoWloQuuIiZMnKtFnO0X/a0uuviQ8Ks?=
 =?us-ascii?Q?UiHIu1SlBg+3w8yciWHv1avWxpSOj1RJ/HPPcWtzZ+1wd+OjxFfSo4PNXDTX?=
 =?us-ascii?Q?+r4VY8qHxeHyHQaohh+u4ugLZSVs9tHqvTAAbQiWzTTcJ7egoKHXtU+Yeruj?=
 =?us-ascii?Q?Z1E1zydPiCHJ3+k3BQ9j98r3BrDMKZaqqaeWEvt/UozZmZk9CgzEruEed8gl?=
 =?us-ascii?Q?T1VS8NLRY7p8h9/Z0hpdAezj2wu1+wd3oREWX3rkl5Z/CSH8coyFg44t3qqg?=
 =?us-ascii?Q?fIjf+Ic45r0e982MUVpDZQ9yF2adKFR+VVjcWXeNYb2U/PFJ66wmbVNNwzkf?=
 =?us-ascii?Q?niaRlR79s50Wb7PUJSJG2ucd3Aiw0vrFBeF/yeTO8x5ni2FnM/z9fJU0TEMj?=
 =?us-ascii?Q?EsVb0eJ3hRBLK2mqvlPsUUsdyTLZl1/7T/puAi5/jpOHWDvY7O44WLWtc/wP?=
 =?us-ascii?Q?J9MV07M5hx9syc4Q8hwgncmYy7dFyuuEYEDbLjQAY+xQTqTw/WHBZGi4iWic?=
 =?us-ascii?Q?dE9MifVq8u6ant6cZqvVwpIB43uCt7O/inrNYKpg0DHiFMQk11O+OngDTm8y?=
 =?us-ascii?Q?JE9/S7eq8Jno0RsTCjIJHatkS7i5PTbZa7LXOMdwlgqi9bGT0vPimOamvg8Z?=
 =?us-ascii?Q?XyQDrjN68tYjZIHYWg+fmJimmREtjZgOlow5wMPCB02MtS99yTvrJLYpUxAZ?=
 =?us-ascii?Q?/FXneeEO2KHnEJYoZgANGirkJJW60HNGM6zjAH7FvJ/Je6d/+hk4APowpfPx?=
 =?us-ascii?Q?PEDKknMT0D7Ansdere11XQYixVWGrBLRZ24f/1mMbxHwpYOWM/pch6tfPtfo?=
 =?us-ascii?Q?elbYn2x6mEFIzd+UANRBbp5RJ1mPEZ9osHmHwOcnmfxUvSk7HLtVToOhd+ex?=
 =?us-ascii?Q?eF9q+F8vVwn12CIhEeWe?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?znlmFjX9iItSLQUXQMWYZI4v90Hk+IaoEsSoUDM7nenTZjuRwToMExGGCAJv?=
 =?us-ascii?Q?kE5uAhViSXJLB4VZDUuRlabEZvLpOCjNdc6AS4eyHGCfiSVOH+JH0swEMcAw?=
 =?us-ascii?Q?Il0JEwBw+HyQdU1QBdBMsdzSNb1GQcr9QbmOQVhwp4qSMRlsZi5QGkn0xqHK?=
 =?us-ascii?Q?ZfCfzTfcTBT6e0IxI1RElq4mXfvTz8W368KzHkjSdKv4cFCM8dBD8aq3vDgG?=
 =?us-ascii?Q?JzuxMITyvUdmqKppSkRpEg8T1ANS7SCEkQyYrmthC7SDbi/zmkByKR0Kss1E?=
 =?us-ascii?Q?lALhkg/I7dMUT1e02ACqAHgi8dU+Xp+xjngBFrApIIJv+JKNaleT5qPxadBH?=
 =?us-ascii?Q?ucr5/PHzwP8y/GN3486wyaNzdDE6YsouQ4rOpnK576Hbm46sKX4+jRxLUNbW?=
 =?us-ascii?Q?umA3WDKG8X8s/z6ku4huBpRjZvRSK2dtyxlOoZuwMwPSkCqNy0jimT8/WA8Z?=
 =?us-ascii?Q?JQx6WnsJppE3KGFgv/h82DA7969kL+1D5+HhnKwzItTjXbCc3xefGoamNQFJ?=
 =?us-ascii?Q?5bxEDz23XgsiumqeK9yUALpoLgngpgiy9ZX/HikxMttSOTN7IciLvjKWxL/8?=
 =?us-ascii?Q?SfGlzjfifLhy1BuQuCUzwnXVNmpPcFweo6sYc/nhOp/bc8mbOapkyJhb17Ww?=
 =?us-ascii?Q?U1YAWF/oE1LSkLf/xLnNSJ3iK7s7Vvhbpx4zM55GZnGtTYuwKhSEAugU6X8J?=
 =?us-ascii?Q?BdZjfxyJxk3bUfXVd64fhjUFU9ePYt0d7W5przMCT8LJn+6JfDi6AA9pohq9?=
 =?us-ascii?Q?dy0J0xwNjqnsaQrm9qrf1wMBR3npT0AzXMMSwoiHzrNx3Fr9WyLivJwPwm5+?=
 =?us-ascii?Q?x++5ZzZ/6CnjAxcbMA8dY7wn76hArdREQQRsLGwn6qhuJlcP2N8z+L2rn0q7?=
 =?us-ascii?Q?25n9g1QhloPLiLHs5hO1RCeg0VBH6db2i3IJez6jh9fFZqu1BUbzujOyX/oc?=
 =?us-ascii?Q?MLPWdGdnq+VBAffpGRKYXyvm4eu2buxKpTGBtrIjc8qLPjyHyWXa1nUijt+Y?=
 =?us-ascii?Q?Z5ABVfOvffVnnZOrHZoiqd0WU+qN7oW97wD6bnRV0moALgo7XzOKGtIlNCAr?=
 =?us-ascii?Q?+9m5KhLkP7HoO2KRaxoSkMy9a/fRkgsF5koaBBgeTZqDMzwmiMdR5FUOs7Tm?=
 =?us-ascii?Q?UyPmT8DNN+8H5ggHrctCrt3EaZZXcJi5od2JyhIXP7KPfUrRXfCP8Y4wUgwq?=
 =?us-ascii?Q?h5bY8ArMrN3oeFz4FnZ6Fc19FM1dl4dOiLvZ0n8aJBGKXDkjQFRmqdGKyPh+?=
 =?us-ascii?Q?sE8iF1iNFJnB9l3G94ggZdJu7L7GCWMRNEU5sA3+50CyAkU4JxvRpZG1nPW6?=
 =?us-ascii?Q?2tNJlDYbtA8zTo1XASQsUTYyKrm19PyoYBTbBWQrCKt5bBTVDP2n0uM9CFPE?=
 =?us-ascii?Q?GI4wrtQDcORN+8p+GxOR4gTGfmJGXqAQFybQ3tKTciLrCUoV0v6lkA2eAQ0c?=
 =?us-ascii?Q?3byVBlDBNMCx48FMYhYvQBC9ogaYrFQl1NZFTmHyHFFsxLfcViouyrdmr5dL?=
 =?us-ascii?Q?hmRHelQbn4syARcHRmyL/SoDe3hGSVu+DJCbSV6lv4VN8qfI+mChMfcTFpv1?=
 =?us-ascii?Q?q/LL269i7A9WTIjU8oPtF8d5lRBNfh+BrGq8b5WX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Yck6WrGJI8cRSrTHCkzMkVqv6o1rn21+fuvW1UL1jLKqgFpoeZ+sW3MXZec5AfUhzQGG+yoKSNXzGRcX6WSUFkRWj+1rpHZsIBiJapWA3Oe5G99rn46Q6Dm6uu9mzvLm2f5LSwLwJf879LLxDO8o+SBPU4GX4gnRI7Phnw2X6e9vAsjdnRL3P1LjpbYR1UsZ9tcJ/+H8gKyAeX6XDoAC9156z7bV5Lq+zV044Pt05/AKJDlT2IEV3p/lkngFCPzR42dEKnx29ZJ60J48sFkCK3aOufLPnidJYpVqz1F05BOP/hBh+QocH5NvWqREFO7Xh//6ng7RDmDGcPu+gYIatBx4wSx1bNWBq82rwewgIevZp2Le5h0bfAc25CpFL5pcnNmYB363zcEh07rpwzvmwSdt4UMASmeJj9GlrdrxlWOxtsRbyE/+153tjGHZBYq8GDV7wpLLJO9rWrw79f3F4SedFjnjHDTePRLzV/8BS8Bc5Y4/k/gJgid507VJSbUIbqjFZNR5D5/ydWAUcwitGVojpXXvegd4sWZtqIbmZFQiurgQms3LDLS6ON+Jp4Kwx7f4oCtm4bscyiPXOYdFiRSDf99zYSmupRrMaAjb0tk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c26ddce-5bb5-4088-dbac-08dc9463d22e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:39:22.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ED68KfzwVv8Sl8AtIUAspCIC2BjGiTe/axC5QvzJa8U1dS0zRRH5ULS/whTFu/1r00BtFFjmuqfN7+UoPh/lfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_12,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=954
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406240125
X-Proofpoint-ORIG-GUID: U93Ybvp2m2_67Lv4OFzIWZIzokHUXmKi
X-Proofpoint-GUID: U93Ybvp2m2_67Lv4OFzIWZIzokHUXmKi

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.10.y

This week, I submitted this work for inclusion in linux-5.10.y.
It is currently under review.

You can find this series in the "nfsd-5.10.y" branch in the above
repo.


Out-of-kernel follow-up work

Amir Goldstein made these review requests:

- Adjust the LTP test fanotify09 to update the comment with the
 appropriate 5.15.y version
- Update fanotify_init(2) "FAN_REPORT_TARGET_FID (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_MARK_EVICTABLE (since Linux 5.19)"
- Update fanotify_mark(2) "FAN_RENAME (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_FS_ERROR (since Linux 5.16 and 5.15.???)"
- Update fanotify_mark(2) "FAN_MARK_IGNORE (since Linux 6.0)"

I plan to provide these updates once the NFSD filecache fixes have
been merged into the 5.10 LTS kernel.


-- 
Chuck Lever

