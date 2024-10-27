Return-Path: <linux-nfs+bounces-7516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066919B1F27
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 17:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88BC281619
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA97156F45;
	Sun, 27 Oct 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxgReYut";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QVMl8rLb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71026174EE4
	for <linux-nfs@vger.kernel.org>; Sun, 27 Oct 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730044810; cv=fail; b=e4TxOa5e+KH3BYj2Uay8X7VacKq+n+JCcoJKjvEwGy3kaOFSSDg8fe1JYVOAugOfYcVD/gewLNNiUPVpODE1EXmOLQ+wuoUEJhhx5V+OyVQRah/RRCYPj8dxKv31vvVtWe9ZVeSdzzo0IJopHI5BPW1Wr2jPuTHkPXBFV/EpeWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730044810; c=relaxed/simple;
	bh=sivcquvzBmAYNKMBylV7naRE1JlDC68GVQxIAl2wS20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=am6P+LtVkJyBzDD2rfMONvR81uZpFYcUCvG6RugDygSyo+A88MikAr0vjKvitUX3yJXa9cIlvfq/hP+mKCyDKyQiuzXCrP++JZfvBcosOF/7wtKrJYh7lbi1WoZOCPoN67q0d/8/8aDhumNkJQLpMQAcdF+hEfcYOF10CwpP09E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dxgReYut; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QVMl8rLb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49R5Ivcr021373;
	Sun, 27 Oct 2024 15:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8cLr8L9m4bYrjD+itm
	dErvJr1RW662iem+TMMQQdsGs=; b=dxgReYut2dD1GHjCsAXRmQNMOVik6880d5
	OYwmNPhMf/UDrWe74m0QKilS7dJUyrKr4IEUPTokVuevdbAZxwbbM50MBZ5Ryq4H
	TKFEKsVfJm6SK2P9N6YpCDzhcpvvnmj/c1JeP2dJUPNhmuctx526yIFjk+1vWShK
	MDXy80hMDubDO75w9uBknh64sgPx9Ur/zw4qof3YFjgtKp0fybUu4cPe36vcxh1q
	vD2EXQT0RQ24NV9jXMBJj5OUcT46MiKf4IVSrc5YUgdxru1dA+2gs8FSZZp7SASR
	KIBEcLtK2GHwXHn6I1aZLgXzMy5U9/BbF5bHZBrE5umN8EqtL5vw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgm9e66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 15:59:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49RCBW3w011835;
	Sun, 27 Oct 2024 15:59:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hna9u5yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 15:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1cWxtjRNgII2nb3JIb4Igzd4It+qk4C9H4caPgbiw4Uq9ib+dIf34qY/h5Z62yEOv0nAgdLAkWcDBcaHEldgLnyYThft48MRTjmMPwCSxWBqUjGU4vRdgr3uM4+cZRrqrn1OPVA2+20F63yGTpbwE3dKlkl8ZdAIHhweSi28YYgrjLPKbCEQRvYJDIBN04swKwuvd0fEVT0R1sEidkFaGZDK4sxHweLV+BJge48XXa1e3kfy2Ku7jOE5FeEq+yOmkz1g0kBB5Ij2GTqiV9tujnhp0ph5dDj0Un1zdvXiKoOuzfEfDixZy8mQ8gD1ETL470RUzaGTNc3iUbqTGeaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cLr8L9m4bYrjD+itmdErvJr1RW662iem+TMMQQdsGs=;
 b=yyQy54nZf31+GHd9HBZrETvdyPbWDBzy2GhZRAaDDgnCPDqC9vO8+HQQeySPt3jWaUIORgeFuVTmovioaQ3g2vfv6EEEPwueB96Qbfnv2vTZZ8vyQ3+J7f4EBIFjHyZ3ojyL/FdSVOQOFkzOeguU147/zzIVffrI71n5uMc0by6xKosfElHYF4AwZ5RhRP1uBD/yTKEDYQmSSLmpgo3iA4xg03Hydsz63li3la8TnM/E5rOY4doNjMuIgNev79pFO/XxUNMsrg0K6spDvjpMUsysEkRf9S9toTdTHSIkNLgW8oEyUq9wjbaIZesUZkjvEt6N28pDIE2Pmg7q3eH5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cLr8L9m4bYrjD+itmdErvJr1RW662iem+TMMQQdsGs=;
 b=QVMl8rLbcZWVYxrJGWo5ldv8p0iqnK4aA/zTPfC9WtFAiruX8c5++ORPSDrdf3aXDnws3H3dUQjPaeO6I2P+lgMBV2RH44lY8Ut2iXzTlJR7A9vhSxg/Z19m4t976FG+2s/m0v08Z48iUWnNG7kbfI6OV6ZZ0wlHuHHRUqbthMA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5164.namprd10.prod.outlook.com (2603:10b6:610:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Sun, 27 Oct
 2024 15:59:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 15:59:46 +0000
Date: Sun, 27 Oct 2024 11:59:42 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        okorniev@redhat.com, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH - for -next V2] nfsd: dynamically adjust per-client DRC
 slot limits.
Message-ID: <Zx5jbrm5D9rPorhs@tissot.1015granger.net>
References: <172972079577.81717.6397186554656127040@noble.neil.brown.name>
 <172972088601.81717.17711026200394256822@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172972088601.81717.17711026200394256822@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:610:54::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: db16f8b9-63a5-406d-a5c2-08dcf6a060ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ej14aaFYjaSIlIcQueXzN2rckIwai6vy5uJfaeKKLb6Es4xl4VvlXxNiGuzH?=
 =?us-ascii?Q?EMpaow9jRfnhqUJ2o6ByZuYs7Q+u+3ZgtpmUWtmv4W5yIIwubqK/Fd5xrshX?=
 =?us-ascii?Q?1+m1OOprJV4CeOMT3WI25PzwCFyI6drIFofy1yRAs3y7NUglDBZfA8aOghjH?=
 =?us-ascii?Q?cXd5qXhRpt6IKe09pe7DQTtotyDAXciDnHEH1rPEb8PhEMsJdRUlPUyZMdm/?=
 =?us-ascii?Q?mSUPMDBPAB7dahcXaoRz/M5Ce3vAtH7Kn03gUfXRaXumWmow5hidUiTPOXML?=
 =?us-ascii?Q?X05td/Lm/u6EGxqZk9r8P+a8a5pD1TiBxunVSxy5BnojXeYbatLd1wd1PrH8?=
 =?us-ascii?Q?T/sfCW07YNRZdT3fmmUMQVboq090irCGN7OG05wXnnVMCpVrcP7v1/DIPGh2?=
 =?us-ascii?Q?Ypdks78KNN5ZUWVqTyTkbC45UeT9lYCc4TiViPJ/42IQXFBq2oNWRaXZPJXB?=
 =?us-ascii?Q?BNoXkQpD5CzaIz6JGnXHarC+/mOX9oBmSNbNAHfU8W/yPfQ57aTQv3foJIL7?=
 =?us-ascii?Q?to47Zvh9h5dxOBsa7mjfQMQAJYHnVZdkWNGjyk/2zJu6dGbQJqdtZ0gAksTw?=
 =?us-ascii?Q?mPmFJM6jyPYuamMATffFCcvx53GhZt7qTWz0EJEnMuf13s111zPJZOBtuj3l?=
 =?us-ascii?Q?A2sO8skiyyw614G6tZyU287T8KGfKFFEnk95Sr/w2hZMsVgedEZ4Gt/LMnQh?=
 =?us-ascii?Q?XITXwP8qwg/2QE3L+4V4hOqqJA+8A2jb7NhEACrDw9ibq9npCc7TU7giOs2L?=
 =?us-ascii?Q?FOO3U3Lc4MROM7yIqbOS1Fwr4Rx/KTIgw39NunD4rEyNc+DOjPqIDWm7rETv?=
 =?us-ascii?Q?C4bpzbCSzzJu+JcnZMmaEBk4x8tS0gW5VTNAdZWnba1oTOio8cf4ZgvKjT7s?=
 =?us-ascii?Q?nlHrjnUCfzmC6zUdGn1MYNy3d8gjT2uCAoMiEKVWROCmEqgaontZ1WgyMX/r?=
 =?us-ascii?Q?xOfZpJSqYOQrPZQqWCjAKeJTy7DQoCGU0X60d8BsBF7KgHADwqipV9LjytpZ?=
 =?us-ascii?Q?WQAA2Gww2EeI4xd+++jfyqPTw7t+ynQyouclODVqLPOhn07KG2XH9YSiErLj?=
 =?us-ascii?Q?BxBRpqQFF1ApCSR8sgGRUf1rRcoQ+SEVr/Z+v2AtDrT0Wwdk6VO97Lp78D8T?=
 =?us-ascii?Q?y0Ry3k2jiqKroq1HThjHU3MnSc9a2NrE8GYtKKFe5XWkLFAky1ks9ZyxRFi4?=
 =?us-ascii?Q?Kb0Q1ce3Mz+iBj7kUixwYs1jNlrUmacXdW7gHQw+EOyGvOhduUqeWLhQkNrz?=
 =?us-ascii?Q?jggDXweRwiM3zzczctlStIDx3jv7aA5vFtoFGwFgdbU+4vMPQxXidNbtiL+V?=
 =?us-ascii?Q?fQDLQuo3+/eL83IZg/Kv8gI7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dxi6q5cmMmE6vGUe/zEOGXP1ua5TtPKJepN7ROd+MctSg2a2UBLlgAjyT9hS?=
 =?us-ascii?Q?sSJB4ttm6Y1XNbNkl/P85KDIXPJJ5DVYEZK9rJ6MgQGWR8Dr80vdLerW7emT?=
 =?us-ascii?Q?xN5SHfCocNTw/SEiobk9yiSVZVgcOuzmGsPbxM4US3YKD3A26RcD/SQDhmXB?=
 =?us-ascii?Q?AobM2S+dNueZ486YDz3CdJKb4HBtYZH6GHxzBhV0Sv0ObPHD0uZUMt0ULfUf?=
 =?us-ascii?Q?uSB2Hdih9Si/pjOhtT/vNX/DkDyNDb6ohLAqDXpsVU1KUCkPl4uaFDt1c2ms?=
 =?us-ascii?Q?3+Wd6QHQwKsAa0Yf8AmaRPiU7h7PXumYT8OpTDp+BG9YyJ8Rbven0+MEwElc?=
 =?us-ascii?Q?iSfMTKjD8pOzuZjPkww+vX2l92jPjVXg4s9nkuFdfFxSpL7FIKSSVtLWxu/u?=
 =?us-ascii?Q?t21jYnJNM0dSTTYE5y3LS5qlOB2+R0O7lQENZgz7YjcPwVY4xtyd+lOGdvG7?=
 =?us-ascii?Q?abviwOSlDLLps+byWUDfu99OdNLtY1HtWh2gGT3QIJNYmYzGl30zb4yDj2LG?=
 =?us-ascii?Q?2/TSksNxZfviFkBwOEjsUqFuruUSaU2MAUGjsoJHckY73Q9eLk+gv+laO7Qq?=
 =?us-ascii?Q?HtZHwwB3J51CC/citWbVPz0LkkIdgfZCdbJPGTRPQGIbEv+agAVd1Vo1X9W+?=
 =?us-ascii?Q?zPAVjCTgKFHXO3vinJOBb9A3Scyq4tArSe4eTp7CzSvwYXCMNCNvYeSQBuF/?=
 =?us-ascii?Q?/54qDeS+6OaDWsNNESEzY15ar2dccGCAPdO1DxiPr0YG60b1u54Vm9ugAYFM?=
 =?us-ascii?Q?XImF+Q77KUg9S9qBptvWNcKCZALXifq/tBtbPRG2is5dAhiFjVpmAm4BfXXC?=
 =?us-ascii?Q?Au/UyjJ9OrWbR2I9xjVMw3kItMU8NEjxuM0xxeSQxZ3XaX1/INQ6QBJuM1+q?=
 =?us-ascii?Q?Qi+5Sool5RK9sM84e5t9frOaiMyBPMoucMglxFT8+YMDFsLH60gigE9ikYSc?=
 =?us-ascii?Q?h6Xsuks+QZWkXOSAPKIH3oHOJYh64gU2Fvr5dqFZWv37IAJ5uoM2rxHjfzr3?=
 =?us-ascii?Q?NkuZVDYs/DdM+VyhCM784tx+gKXgn/1Jj9038fQc+HJtquwb8gl+gfWXpxn7?=
 =?us-ascii?Q?4Iza1IB20OpxUOr4YXLR99bFuDSA1hkspsAU+q3Ukxl0/6bmBCOyC2n2Nuc3?=
 =?us-ascii?Q?Xf84Sv7WOOQiW+B+G5Z3/wpEe6fUTrW8vhX5j/pg7WhyPNUyN1DzJp5jmqOu?=
 =?us-ascii?Q?wd90nyZqKtqi5nWSAHrrq0/HEc/knZeAF91zzeS3vXv4Ul1DOVJG2CdqoawQ?=
 =?us-ascii?Q?CZMJZX4Dn7OD9+5F575Id1yXI/ptmcjX27D7GcCBdTWskzTIU+ejBCnI/bU2?=
 =?us-ascii?Q?1tYHHocJKI92KhTn+ddmjdoLEr2ZPG5/jK2H4yszSz/5uDsrwslHesl72/hA?=
 =?us-ascii?Q?w1Nw/G5sLXdj2ISnF6oIdK2WIoFIzrRjHI02Dex6T5c/AVgqDzistIqh1Qe0?=
 =?us-ascii?Q?f3mUqtXK7zVnCwXHNlUvmsV1nLpLSDGaI8xD2kRd2JwqIcnREENOg94qurBd?=
 =?us-ascii?Q?i6GKH0itunYusX/jH/GM1FpQnUJRqgu7OV9Kfa3DeR0WNs5FqsZi2ux5RcL/?=
 =?us-ascii?Q?tOM0aI7cCmhEQHUZowHQ1m/7DK0ink3v95QAeQdt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QqIaSz9svikzYKxKuz6Z/047e9UOSe3gndJPhGv9AknkhszTbzQvOfNMA0bQqcNzcCDA6MjLnjWBFHtfKVGFhYwauPHHdKnC50bKT4MCycOigM8Entu5r1c69G20V/iBmlvskiCQudC9l73GNPg66P1D4nSimauuIjfIyYvuvQyRnwjZWc7+gvdcoM204LBS4pfZrgnYLPYUmvKGOCu4n+mAnmNEyYLbcJ1QgtyeMW5JctGZYR5uPWxuCwuUMHX6uRLkFrhhtIY5IOn4gaX5Nz8bBCkgjTRSkZl53rbBuaj1N9sSSbpINjgHrwqwSFjM64m5djlokFIb9PV0LmObHBJbYMGDHu2zM21PDvuhNGoWyjY06AD2TzNuIZawKCyOQ7SQIHJc5eKkyeZnvxvnqPbnt2+8PpQVGnRRZCZFwLS+TSywXGUuvWbtMkXIZcIOIA9IceL+DfJuDS+b2QX5KIMhoYQJWESY6aVTkLU76/e8Fb4o6uhkfhLtX+NqlnoGDGRmfXSenpMiy4yjQAKsYDuahiMtYJI+hsspK98xWd9vw/l5B+i6QCcltk82FfhLZqMhodn8W9LgMYuvDswIplurWffYmpO6C+cpTHj06s4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db16f8b9-63a5-406d-a5c2-08dcf6a060ba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 15:59:45.9424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7N8reKyzmtKSj8cu4G5bq0NI/ZYKdTuM/EnQs30q5oopJ05gPqCuVMUCCyFYt21UidOSAjk8gi2h2ZSY2WLWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-27_02,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410270140
X-Proofpoint-GUID: WqzMj-OmFQR1TJVkXfcqeSitqYm1mGzw
X-Proofpoint-ORIG-GUID: WqzMj-OmFQR1TJVkXfcqeSitqYm1mGzw

On Thu, Oct 24, 2024 at 09:01:26AM +1100, NeilBrown wrote:
> 
> From 6e071e346134e5b21db01f042039ab0159bb23a3 Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.de>
> Date: Wed, 17 Apr 2024 11:50:53 +1000
> Subject: [PATCH] nfsd: dynamically adjust per-client DRC slot limits.
> 
> Currently per-client DRC slot limits (for v4.1+) are calculated when the
> client connects, and they are left unchanged.  So earlier clients can
> get a larger share when memory is tight.
> 
> The heuristic for choosing a number includes the number of configured
> server threads.  This is problematic for 2 reasons.
> 1/ sv_nrthreads is different in different net namespaces, but the
>    memory allocation is global across all namespaces.  So different
>    namespaces get treated differently without good reason.
> 2/ a future patch will auto-configure number of threads based on
>    load so that there will be no need to preconfigure a number.  This will
>    make the current heuristic even more arbitrary.
> 
> NFSv4.1 allows the number of slots to be varied dynamically - in the
> reply to each SEQUENCE op.  With this patch we provide a provisional
> upper limit in the EXCHANGE_ID reply which might end up being too big,
> and adjust it with each SEQUENCE reply.
> 
> The goal for when memory is tight is to allow each client to have a
> similar number of slots.  So clients that ask for larger slots get more
> memory.   This may not be ideal.  It could be changed later.
> 
> So we track the sum of the slot sizes of all active clients, and share
> memory out based on the ratio of the slot size for a given client with
> the sum of slot sizes.  We never allow more in a SEQUENCE reply than we
> did in the EXCHANGE_ID reply.

IIUC:

s/EXCHANGE_ID/CREATE_SESSION 


It would be great if nfsd4_create_session() could report the
negotiated session parameters. dprintk would be fine since
CREATE_SESSION is an infrequent operation, and administrators might
want this information if they notice unexplained slowness.

It might be nicer if these heuristics were eventually replaced by a
shrinker. Maybe for another day.

One or two more thoughts below.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
> This time actually with the comment change.
> 
> 
>  fs/nfsd/nfs4state.c | 82 +++++++++++++++++++++++++--------------------
>  fs/nfsd/nfs4xdr.c   |  2 +-
>  fs/nfsd/nfsd.h      |  6 +++-
>  fs/nfsd/nfssvc.c    |  7 ++--
>  fs/nfsd/state.h     |  2 +-
>  fs/nfsd/xdr4.h      |  2 --
>  6 files changed, 57 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 56b261608af4..d585c267731b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1909,44 +1909,26 @@ static inline u32 slot_bytes(struct nfsd4_channel_attrs *ca)
>  }
>  
>  /*
> - * XXX: If we run out of reserved DRC memory we could (up to a point)
> - * re-negotiate active sessions and reduce their slot usage to make
> - * room for new connections. For now we just fail the create session.
> + * When a client connects it gets a max_requests number that would allow
> + * it to use 1/8 of the memory we think can reasonably be used for the DRC.
> + * Later in response to SEQUENCE operations we further limit that when there
> + * are more than 8 concurrent clients.

Eight is a bit of a magic number. Other constants appear to get nice
symbolic names.


>   */
> -static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn)
> +static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
>  {
>  	u32 slotsize = slot_bytes(ca);
>  	u32 num = ca->maxreqs;
> -	unsigned long avail, total_avail;
> -	unsigned int scale_factor;
> +	unsigned long avail;
>  
>  	spin_lock(&nfsd_drc_lock);
> -	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> -		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> -	else
> -		/* We have handed out more space than we chose in
> -		 * set_max_drc() to allow.  That isn't really a
> -		 * problem as long as that doesn't make us think we
> -		 * have lots more due to integer overflow.
> -		 */
> -		total_avail = 0;
> -	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> -	/*
> -	 * Never use more than a fraction of the remaining memory,
> -	 * unless it's the only way to give this client a slot.
> -	 * The chosen fraction is either 1/8 or 1/number of threads,
> -	 * whichever is smaller.  This ensures there are adequate
> -	 * slots to support multiple clients per thread.
> -	 * Give the client one slot even if that would require
> -	 * over-allocation--it is better than failure.
> -	 */
> -	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>  
> -	avail = clamp_t(unsigned long, avail, slotsize,
> -			total_avail/scale_factor);
> -	num = min_t(int, num, avail / slotsize);
> -	num = max_t(int, num, 1);
> -	nfsd_drc_mem_used += num * slotsize;
> +	avail = min(NFSD_MAX_MEM_PER_SESSION,
> +		    nfsd_drc_max_mem / 8);
> +
> +	num = clamp_t(int, num, 1, avail / slotsize);

The variables involved in this computation are all unsigned. Why is
clamp_t called with an "int" first argument?


> +
> +	nfsd_drc_slotsize_sum += slotsize;
> +
>  	spin_unlock(&nfsd_drc_lock);
>  
>  	return num;
> @@ -1957,10 +1939,34 @@ static void nfsd4_put_drc_mem(struct nfsd4_channel_attrs *ca)
>  	int slotsize = slot_bytes(ca);
>  
>  	spin_lock(&nfsd_drc_lock);
> -	nfsd_drc_mem_used -= slotsize * ca->maxreqs;
> +	nfsd_drc_slotsize_sum -= slotsize;
>  	spin_unlock(&nfsd_drc_lock);
>  }
>  
> +/*
> + * Report the number of slots that we would like the client to limit
> + * itself to.
> + */
> +static unsigned int nfsd4_get_drc_slots(struct nfsd4_session *session)
> +{
> +	u32 slotsize = slot_bytes(&session->se_fchannel);
> +	unsigned long avail;
> +	unsigned long slotsize_sum = READ_ONCE(nfsd_drc_slotsize_sum);
> +
> +	if (slotsize_sum < slotsize)
> +		slotsize_sum = slotsize;
> +
> +	/*
> +	 * We share memory so all clients get the same number of slots.
> +	 * Find our share of avail mem across all active clients,
> +	 * then limit to 1/8 of total, and configured max
> +	 */
> +	avail = min3(nfsd_drc_max_mem * slotsize / slotsize_sum,
> +		     nfsd_drc_max_mem / 8,
> +		     NFSD_MAX_MEM_PER_SESSION);
> +	return max3(1UL, avail / slotsize, session->se_fchannel.maxreqs);
> +}
> +
>  static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>  					   struct nfsd4_channel_attrs *battrs)
>  {
> @@ -3731,7 +3737,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
>  	 * Note that we always allow at least one slot, because our
>  	 * accounting is soft and provides no guarantees either way.
>  	 */
> -	ca->maxreqs = nfsd4_get_drc_mem(ca, nn);
> +	ca->maxreqs = nfsd4_get_drc_mem(ca);
>  
>  	return nfs_ok;
>  }
> @@ -4225,10 +4231,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	slot = session->se_slots[seq->slotid];
>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>  
> -	/* We do not negotiate the number of slots yet, so set the
> -	 * maxslots to the session maxreqs which is used to encode
> -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> -	seq->maxslots = session->se_fchannel.maxreqs;
> +	/* Negotiate number of slots: set the target, and use the
> +	 * same for max as long as it doesn't decrease the max
> +	 * (that isn't allowed).
> +	 */
> +	seq->target_maxslots = nfsd4_get_drc_slots(session);
> +	seq->maxslots = max(seq->maxslots, seq->target_maxslots);
>  
>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>  	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index f118921250c3..e4e706872e54 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4955,7 +4955,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  	/* sr_target_highest_slotid */
> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
> +	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  	/* sr_status_flags */
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 4b56ba1e8e48..33c9db3ee8b6 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -90,7 +90,11 @@ extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
>  extern struct mutex		nfsd_mutex;
>  extern spinlock_t		nfsd_drc_lock;
>  extern unsigned long		nfsd_drc_max_mem;
> -extern unsigned long		nfsd_drc_mem_used;
> +/* Storing the sum of the slot sizes for all active clients (across
> + * all net-namespaces) allows a share of total available memory to
> + * be allocaed to each client based on its slot size.
> + */
> +extern unsigned long		nfsd_drc_slotsize_sum;
>  extern atomic_t			nfsd_th_cnt;		/* number of available threads */
>  
>  extern const struct seq_operations nfs_exports_op;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 49e2f32102ab..e596eb5d10db 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -78,7 +78,7 @@ DEFINE_MUTEX(nfsd_mutex);
>   */
>  DEFINE_SPINLOCK(nfsd_drc_lock);
>  unsigned long	nfsd_drc_max_mem;
> -unsigned long	nfsd_drc_mem_used;
> +unsigned long	nfsd_drc_slotsize_sum;
>  
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  static const struct svc_version *localio_versions[] = {
> @@ -589,10 +589,13 @@ void nfsd_reset_versions(struct nfsd_net *nn)
>   */
>  static void set_max_drc(void)
>  {
> +	if (nfsd_drc_max_mem)
> +		return;
> +
>  	#define NFSD_DRC_SIZE_SHIFT	7
>  	nfsd_drc_max_mem = (nr_free_buffer_pages()
>  					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> -	nfsd_drc_mem_used = 0;
> +	nfsd_drc_slotsize_sum = 0;
>  	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
>  }
>  
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 79c743c01a47..fe71ae3c577b 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -214,7 +214,7 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
>  /* Maximum number of slots per session. 160 is useful for long haul TCP */
>  #define NFSD_MAX_SLOTS_PER_SESSION     160
>  /* Maximum  session per slot cache size */
> -#define NFSD_SLOT_CACHE_SIZE		2048
> +#define NFSD_SLOT_CACHE_SIZE		2048UL
>  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
>  #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION	32
>  #define NFSD_MAX_MEM_PER_SESSION  \
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 2a21a7662e03..71b87190a4a6 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -575,9 +575,7 @@ struct nfsd4_sequence {
>  	u32			slotid;			/* request/response */
>  	u32			maxslots;		/* request/response */
>  	u32			cachethis;		/* request */
> -#if 0
>  	u32			target_maxslots;	/* response */
> -#endif /* not yet */
>  	u32			status_flags;		/* response */
>  };
>  
> -- 
> 2.46.0
> 

-- 
Chuck Lever

