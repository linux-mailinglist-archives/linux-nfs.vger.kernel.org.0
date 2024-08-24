Return-Path: <linux-nfs+bounces-5687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00495DECE
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A7282C2C
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EFC374D1;
	Sat, 24 Aug 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LZgKfJsl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DsI17Hb1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A7558B7;
	Sat, 24 Aug 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724514947; cv=fail; b=DM91kkhNdVO7hSANnzmn/YYle0dYY3iI/YmeRpAhwtUcaNRT9XbFn2MSkitC2dPuFWuaGPnTdESfw2CjWl9aY2vrykMeruLSk6QfBXGV4cclrijg1yjTDgPaV8lMbyhDLP3rk3p8cUHvIlaecpQvAYKFotp3y5mgrkESwyKry+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724514947; c=relaxed/simple;
	bh=pYvSztdOXg+94Gb/HV7qAeY3oIAkNFqPXuGPrd1+LIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ocTvf6NC+GnvY9qdlsk+0dWSkVch8MEPBc6UwR7yMcefXnVufek4RivpKmCA2OZ1/6f97oepKh4fkiB6VBJgTn+5/wqSPp78JKkPZ1qM2C4hIk653uXMQJLnQo9D9eF+BX6zuzUaYZjT7eYNUSenCxa10FsDRNvjzCXVxSgbb8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LZgKfJsl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DsI17Hb1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47O5dVLY020287;
	Sat, 24 Aug 2024 15:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=6JzSbppLBDEdQ6a
	NM1nT71/+8O2f2qpzg0qRqABaDQw=; b=LZgKfJslZcC+5CA+j+9KKnfYjSZfTD5
	wE/iD9xw0wr6bnwGadFHs4ZvWRW9RCF+M3K+t1Lz5/ippXXMj+6mvkJJ9NUJm7DI
	ym5Zf/dorGD0N+AksYu4oR5RgYbcPUXAWiaXdLlZgPoKWvgOEVV1zFBt+RNXp698
	EHHNhy6fIE6OissbRzF1bxLWLNDqp8z6ciWoGN0thXrm7Un4WK/6KjIg9OWHZjZ5
	eneLsvqhHnE/Zrke4DhJ/AP41ZUwiKNoAjKCSmA4gQIL1yE3Coa9B55JQkLuTINB
	hpduL3VF5U9bIeqqJwopO4KGOR38GbuVxunw1iofjzzdLiq9A/FgU5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177hwgdtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 15:55:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47OFXC1e031017;
	Sat, 24 Aug 2024 15:55:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 417j8w89ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 15:55:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaBWVrCXT42ShRBb3eWx1iwTpA5ZkndfGhAjYS753EcLq5FfshY2+EGcJlM3Uab7zN+Wyr9oKHFLG7PR/taCJG1JEuE9gbyqjYyFtYHjEUsNbTrUEO7ih6vTdwusla3Bp86rdwcdWnvsv1vbVgILihUZ9jdiw3r+G6U8CHGnFiMVGi66HdcVIeNRNzOv838cHfeayMUV/mnMs5ftguYw6sEIScrNU8kNucHYVPVp2yVr4UYSilnNIWkuPRlSK+GD2I/05QuHlLgHG3qYvuCaSU1lz6oi01IkfxHzt9taSLRjeMcEyIWhawmiK282ONVM+3AW7w0iG0T/4jGxBudgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JzSbppLBDEdQ6aNM1nT71/+8O2f2qpzg0qRqABaDQw=;
 b=X+pLwP72yTCrxr03mgrJDEzKRJYFGEy9rYSH+0UVUDbIwvDuETvb/8p64Gch/E8fsymUEvaspZf/KhO7LPTtVsJEZ3OJ+VZOb9KhrkMRUrp2eIG1hi3o3R4nN4X15a/LcO0kDvpnSXeKwfGSXa/iIMQgCv7qY+MonpVEaJ+dBwU1rsj+0V2RtPRwBHX/N6P8+YMHZyW0chqjX18r7wC2L/1LYRujVTUxIudgF/dIDC9pLG+RH6up2Ouppb/Iou9sDuLcyzcXsVl19b78/n5xGsrDQ/BB/yeJS0p187uUV3An9PcRB6ZCWgJHW1nEZmuODOM+LvWHlRAM3jG43o45pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JzSbppLBDEdQ6aNM1nT71/+8O2f2qpzg0qRqABaDQw=;
 b=DsI17Hb1afTfFROXYu1IT6ovLXG1mDUadfb6RoJg6N9pghMFezifNnxvYfW6+toVdHv8GsatS6D65PUAWNNQBy42eQxolr3JBs3roL2rzafGKVbOjxEvlCzKIeasHbaimXWbxV3gA5xK6HL62BMDYO13k4QO370uVzvK3HDmX6A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 15:54:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Sat, 24 Aug 2024
 15:54:06 +0000
Date: Sat, 24 Aug 2024 11:54:02 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: "trondmy@kernel.org" <trondmy@kernel.org>,
        "anna@kernel.org" <anna@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>, "kolga@netapp.com" <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, "tom@talpey.com" <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "lilingfeng@huaweicloud.com" <lilingfeng@huaweicloud.com>
Subject: Re: [PATCH v2 2/2] nfsd: fix some spelling errors in comments
Message-ID: <ZsoCGmEs9LjQf0JZ@tissot.1015granger.net>
References: <20240824014336.537937-1-lilingfeng3@huawei.com>
 <20240824014336.537937-3-lilingfeng3@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824014336.537937-3-lilingfeng3@huawei.com>
X-ClientProxiedBy: CH2PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:610:58::37) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be5edb5-afb7-4a8a-8aeb-08dcc454fbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y6IYZ6KNl5+mO30MbNxLKyH4D0JHQUom7oDYtKjgJ09PYHpeoZzmjFoLkbDv?=
 =?us-ascii?Q?1RIuJSev/iPAQXYSYIGTSpDiQoqkeCrzYyZnMqnaJ3BnCGIg0yc2IqYhlRh3?=
 =?us-ascii?Q?ZkRYa8XM7GHgAWO0hd6TonrgHtUJHyq0wkHvS9ZxcGAzcAByOtjgPrs+cyTq?=
 =?us-ascii?Q?ERT8sj6GTiDNMFJXoyQpUii17ecyK0GmPR+6M+72W2P82ydKGDdkiOYcxn2r?=
 =?us-ascii?Q?5b2c3Tu1SQPNCascsOLxKDRmwAALZE3ayHcc1a5iJ3hYLD1mG6zRYvSIydOa?=
 =?us-ascii?Q?x+IzJLBW1olTys7HknFg+lJ//rey2W+Xmf4Ykfxu7SXkvMcxsfonPpk7sAtA?=
 =?us-ascii?Q?SNIUb54DU7fMaLjuSnkYDL5/1KalCkXX4mKha6JcrzUeeiEAhqxCAOtKdd7A?=
 =?us-ascii?Q?lcEggqtUsgj2LQ2DhfFIublTr3SiKYQorC8DKxhgm2YpNBm84D2Vtc1//vxc?=
 =?us-ascii?Q?Ts5eJZcvRSk2wMhj1HRVPLt3KW6WV4A+iliKBEARjgIO7fYqnqGOq50X/FeS?=
 =?us-ascii?Q?IBeU4XPZ0VGNXCzr/W3zTfAZgqhdPVTgKSFRvJpYx+9gYTDpJ92Kc8i3riCP?=
 =?us-ascii?Q?59P3tRpdDmf2W4ZHCSZMOjG5/3imBaZQ/OEtrTVeHkkdXiBR8B8C/vRIF2sD?=
 =?us-ascii?Q?TnuCZNe6DHphskpiS2gVdQIJC8LYhvQ0QQ0scBHNJ0lVYXVbXJH59PnfxHrk?=
 =?us-ascii?Q?ydKfMNFvbDR9m6Ld8yJi5RvM7n4C3UslNMlw0X4OBkcjkFTLGRlRbyYZE29a?=
 =?us-ascii?Q?UuQ+CvCyehA2bcRgr+Gdlc96aPjS8ZfC6MBP5ZYrEtinorSj6mUB+yK9/UQd?=
 =?us-ascii?Q?DN5iGuCVLMl7FGsGQ5c3txsNOBFWyYCA6svSn7qVo4oDiX0/vTBb7X/slZEz?=
 =?us-ascii?Q?nd6k0P9V7jbJbM6bWVwpLdBY2UR4AoVqHEERj3upXqejtJp0r4Sabj8rJPXZ?=
 =?us-ascii?Q?GIZZRQqGEB9QKV0oH/81FjF4Jk39qEX/tOfYpYgqRhzWXDmko/Es/c2Qy9Kw?=
 =?us-ascii?Q?fYCp6YGdsojvpIa4kUtqeNof1jk72dPT576DTU0wFm7YtBv9feydwDhbyu9Q?=
 =?us-ascii?Q?CqYtMbFBgyRQlZZXI6veiVXakQLizoj+ugOlQzmTE+9WF7RrNa7ZwQSiORMV?=
 =?us-ascii?Q?aj9AvweK2yPZx2CL7PrOywbvt97KeF7dWUA+k55Z38bPpa3HRHvyh95r8mqR?=
 =?us-ascii?Q?geswfzuz14dXLiKW8chvUsuLIhajrrObYRmBSo8lavkD5eijGkobcAUqqKee?=
 =?us-ascii?Q?0g8VOj7s6ReowoGD8XuzTsNc7Ipf8ralNXsW/CJCTpP/wdfcyvcsL5ugpwKz?=
 =?us-ascii?Q?0uEeLPq/DCOuglBHw14+FYNVQ4YuOK7dq3kPzNPS3yOQHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LYaPb+87E+/6lLQSr+aBqJTcPU8F//EWl3To69e0o6YcFiJNuSkAIV6dUuvv?=
 =?us-ascii?Q?xmjaQsJPN0zA51d/4R/Z7aBuo00oeazMs8MKMDaEXaPZ+c5HYdX1z7MAxa18?=
 =?us-ascii?Q?CgHH/trliUYM69cqSQvNoSHD/IFK8g3fHQc2ODNVvSYzjsYFAn7p06nfDIgQ?=
 =?us-ascii?Q?/JvZygUY/Y/ZG9GdO1dxt+yC6BBtjMxObJnmRssPmOqQni9KCu/3rd6QLtOD?=
 =?us-ascii?Q?UfzjfuIqAERLc7eclrfb1rnci6jqakFhVKPCQl3XrozZYM+k0J8YHzzn7ueY?=
 =?us-ascii?Q?rKq/EjLcqXhtkypPi9j7yBVXF8Y0XMWuw386MT1IKBVWFb40fAxQVV4IS5Ty?=
 =?us-ascii?Q?xv+lV252l78MVzsDFrlUCfG3zaX7p61yg4OrTuUVPCtl/QMNfVorh4iCoVBC?=
 =?us-ascii?Q?hHSisYxUvxaXov5dl9CTXfNry/Xtk1hK8qBChYuc4+fA4JF5Tl+Ytdeh1fiH?=
 =?us-ascii?Q?DoWXR906WadIRlBEjuhy/GVLbpDyXmSiR9Te3yd0wTKPdVEWnwupcP32snMk?=
 =?us-ascii?Q?nwqBAxjbnwPNsJ2Wz7EhYcW+Vj++DsRkxw0bggbUqFTMLJ0sQRG9sAQCrLhL?=
 =?us-ascii?Q?QHCtRUJVxkM/nQqndvksPuvS9D5qjr5xVX//kJJGS02h5R5MGN/bhA1MSmSa?=
 =?us-ascii?Q?efJDehcS97HOIa9ZdR1GTXBYIwp/kPtbzd6HZPsOWpwrHZV1KtvWtuC/EgdO?=
 =?us-ascii?Q?Ui3HG4T9Q9kEqBWNe0C7AYlZD024ZLEE1R+b/slr9qe0eHc0PQbjURi1G1tI?=
 =?us-ascii?Q?yKGE0159bg3W8wvnHTT/I3XtsuSuDEMGz2AeXVkhFzDkDoF1jEX3eKk7E72l?=
 =?us-ascii?Q?vnnGj9BEfIF0BhSY5qRw4WzXd7SNU//cDcDZxgSWCpM3PlMFdcgnf/qeJ1fN?=
 =?us-ascii?Q?qsr3jtosIeIq1TkyomyzYzr1/nEh/MGdDT/vICJsLarATT+U0AyefuQLloww?=
 =?us-ascii?Q?wE0X+afr8cXdJgupkj2WqlmE4ub+j/aUCdhMg3iUn4obizXayxNxyv32x8JX?=
 =?us-ascii?Q?G6bZWVj0QT8r8JL1zbxEYWtZ+srnhEm0Ex6HyNCRk4yQMVNWE5bprb+jzO1g?=
 =?us-ascii?Q?Unv2nirEPcYxd87emaFJk+p7yF1jPDdrwZN0N0ZeLl3JItmPDYBIVmn3BZRq?=
 =?us-ascii?Q?N/1raQbJyxxxbIDT0pZwxmuWg114Rbho/3+f46u94cuc53dba4k92n9W66g1?=
 =?us-ascii?Q?OdXX4ObK1YUMbe1v8S0eGotwYztUvki7aNCBYSG5HoZA1mDVdH869CTNnftJ?=
 =?us-ascii?Q?JH1zkAS7/4ZxUSCy3LzLoRFdk0zbCL+zBRX+j7oNJHuOI3vnSKNalih3rWHW?=
 =?us-ascii?Q?3UjMrpT7ZiWmqDJS4Bmg3N0z4aI1SMqGfOjhFOKfWydolMnvbfX22tG8oFD8?=
 =?us-ascii?Q?XCuZmo0Colmu9T9GBoRn6Pk98yLDDYqDCdMEVtHzVDSC0GE9mnuHaA8GOtHs?=
 =?us-ascii?Q?5bHxJHDc+MCV8R8sVy1rzF6nbR3cxUfFbcxhVnkFtCBFItCjzwIpOw+h3H5b?=
 =?us-ascii?Q?I12Wi1zRRiwtPTG5W9nDeKphDF0Pc0io0AAvyGDEZb2NpDogg/gUCcn+0LDj?=
 =?us-ascii?Q?eXXn6qf7tdDLRcXWpQHlor+6LMLZmHzG7ZhvOMmR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vXSVyuLi4PgyHG499gbH63rxYkkFRvr3dW9tAWMxeifUoN5CW2M9+qtbAO1pVGiScJ2VBtxJ9lAPpuxLU7ctC9nEJjBPdTTO6iw6WUWmML+2fmw1w+EvYwD45Q50ITNfeGAoF9prNS6IbARNcMoDmYc0hX9CXCCDhVtj/DIPGcCSkJnkb9izWyiIpbIYILvQRFbMvJEdoxWZdCsH4sis+EBdoM0t4xehw0Z1gQsv7UC2fhs6G4ILcsOs4p5pZFIqSDkh2sI4QD995Ow7/NWQ34KiKBR+QgGOJqmgETaxyG3z6P5Q75fF3af0ZH4APEtpNDlDYxYiWB1+zzY0Q52vRyDxYoClzwf/3zFw22pho0h1JxfeI97A1iRjLNReZlkNAdRuRLmrfdwhuSWnwVdhmLzB5CFZKFJCF2BtaXAKJQcHO3sLygUdTNy3omcCaL3n7Ww/S7OC+qv+cKQryX6qMWbYPmDeW7JSkxvvYUXrK7VV9p76bgB/cCcgX3f+ZXXXpXPmCMz6QNdR6raSg9yzMOHHpYGTcYjN6sNgGMcsaRFfeaBXJoEurX78haKrJujzIvtX3Pir+QXkDLiERO6K4a7B5cBTf2Qs6tVklCGExnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be5edb5-afb7-4a8a-8aeb-08dcc454fbd1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 15:54:06.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30y2BJnj5hTnsUTYvr4NZLFDojar/dEnZgCDYruGkOtJu4WSvAnUtiLCIMDwctcCLVd56TTDDiSIVDBiwp3gjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408240100
X-Proofpoint-GUID: 3KT8IbzhwfkM-XbI51FOwskBMqDliVr7
X-Proofpoint-ORIG-GUID: 3KT8IbzhwfkM-XbI51FOwskBMqDliVr7

On Fri, Aug 23, 2024 at 09:43:36PM -0400, Li Lingfeng wrote:
> Fix spelling errors in comments of nfsd4_release_lockowner and
> nfs4_set_delegation.
> 
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>  fs/nfsd/nfs4state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Applied to nfsd-next for v6.12, thanks!

[2/2] nfsd: fix some spelling errors in comments
      commit: 2a6dfb4ce8136b93e38e1101636af44ed82b3d3e


-- 
Chuck Lever

