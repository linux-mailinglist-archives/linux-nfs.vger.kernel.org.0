Return-Path: <linux-nfs+bounces-8127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C129D2ECF
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 20:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FEF283ABC
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 19:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17191487E5;
	Tue, 19 Nov 2024 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EB5wlR1D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RAUEU4BI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236D8528E
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044360; cv=fail; b=Nmr7E6ZZlLubha67+hQ0PijM1AtbFXeHvAM3jPukBBLjfnqUYecy4zprVMN/xU21HPNVvCh512C+DrhXLfEGTFRt5IMIl6ehkZK01h6nmQ9EsSmp4xMWIcfudt208VhSqk6sHNWjW5I/okvtHfmdiXetyqhTvw/3w4AOfTD2Fgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044360; c=relaxed/simple;
	bh=HtFBOBo8MBJuAovFcJKPhRpOIXWdwz3ihX3yU7ZtwUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pSv0PZdOQll0BheTxZ8Ej1HQHkllw3sIwrnFaW19RJBjHguqSCSULfJtWkx/i+JOqFZ2e2w3+GGYrg9Cm0DAPQe08IBM6C9E8jkhgpsnUlMC/rFAi3lHRBbmcjYhXCv6ybnB6JoCW2Ikwm3Ny4jlK0583BhpiVfNzkDYnNNUfq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EB5wlR1D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RAUEU4BI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIMXtD005957;
	Tue, 19 Nov 2024 19:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=v1iqt7u1/QOPE1m1RE
	LO7DNoyH/5fO5wLv7kT7/8AUY=; b=EB5wlR1DWoeBGdtwHzNhBGgA+tgsbPTCkf
	1Iqn0l1uf0bzgXTpeFoHzj+HnamJwGzkNf3VZ180p0IqOBFmBkw9BSP+zA2JyHE9
	EIHp2k/We7nzvqR+TjnQjGfr89G/HgYuIrpLUn9C6iWY9LuaI/7aHg+y5iXUy3i8
	hDzjPk2gNlFCMQCmhdXdG4UQoy0qmnonHlB6q7ozqBZiYonKl/W8RdQVbdjPiMNH
	b4mUTzbU9kwrXC0zrqA4eqUgloB9EtjI8Vd7Ao0n5mEFaIfV142Q3ZhPbVBhRvuC
	RDGznU6fHPHGeq8g8GcC9UunOCbqaMdZS5qjk50k3Z0RDPJcdWQg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430xv4raqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:25:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIgnVQ009033;
	Tue, 19 Nov 2024 19:25:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu97ahn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:25:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPck8E91pjE7E0uUuTYCzESKPmmC5oUpTaaHU2KMEdZyg3oHpxeSdoQeoO0JQI0GmiACRrIpMmMp97PIuPtHZJRx64znFGcSAuh6q4no5LWcS0sSv8A24xRoCfyB7DCnkZfDNsLtqnHhCwRMRC4jLtR1Ylzd69wQY9zBhRb1zb6KS76vzyxzxdpt77EGxLfZXpGIRpMMHLrZYd/fYmM9CAIMs5uorAYR7fCYGw5aH5D1rIj7HHZn9MrO446zujTTPFB29GDjYFcAcO0XCChbkLdeJ/sv0qlHNcDoXwt2T5XePDsD84uo5+dUBFQEuWj5yx4JzoGIZbn1j9yssty2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1iqt7u1/QOPE1m1RELO7DNoyH/5fO5wLv7kT7/8AUY=;
 b=o6idtZfGPDq8fGXvXsp0uMlh/dXFgWCUTlD5L9C8Aud7NumvvxRyVmSJk1HPT5ZPM0o47uuLSoeBGuz6RThXlcSy/JIHP2PLj13oZcL9eneOgPYxdeAQm25syoHXTdc7EMSo1iwSbqm4dSho5RNk1Clj2T/1I0gcywooGlmlun54ZWgUWhiZQt3xxH5PXN0oNvlq7Lf7th1y14SMd5jsCknXcFOaQ47QW+s7aWjH9gk+7BSu4J3CZAwbMw7uYkYg6nNpjLTLz+367yuYxsIHcpX34xCjuAOw/JrYT/QiXgJpSj+RrROFWwzd8K+VjSdn40iphDJA9gYPVrmuuh4yyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1iqt7u1/QOPE1m1RELO7DNoyH/5fO5wLv7kT7/8AUY=;
 b=RAUEU4BISj7GWqCox0m2LQxcIqjh+8UfAGwyVYnjFrfvLnRBBGSmUpyhmJHw2RQuDWiho/RDqRaMi7BKujKCEuEQgPVi+qOGA68qQSfavWVKUYKG9hwkKL1Uh5CV68RJvSyFP6LJ1VW+8cXhYgUmQdWeXdKZVgY93M1IBMWqCI0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7941.namprd10.prod.outlook.com (2603:10b6:408:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 19:25:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:25:46 +0000
Date: Tue, 19 Nov 2024 14:25:43 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
Message-ID: <ZzzmN2ZTPkvf+Vl8@tissot.1015granger.net>
References: <20241119004928.3245873-1-neilb@suse.de>
 <20241119004928.3245873-6-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119004928.3245873-6-neilb@suse.de>
X-ClientProxiedBy: CH5P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dac395c-ec83-49a1-1fb7-08dd08cff771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iRBVz/w/LMCg97YwJ4fhzvJh1PuMcd6u+csMlHdIuLLUWl2F04Jk4IYFzEwN?=
 =?us-ascii?Q?vQVqiy6mUMvud4kFbY0s4dxRQ4VN2rtK9JMk7AqaOKwjpjA26mM06IT0B3E4?=
 =?us-ascii?Q?kfGRLGO4cjjsKrEWj77aqlf07q/E6S+CHR7A6wk2IZm9tpqIdYNMHnGTObWb?=
 =?us-ascii?Q?jjAmZq0fBFInGMm9UKt9yJVYfGMSLgPkXSHuOqlymld/R1KJHiiwulEMwdAV?=
 =?us-ascii?Q?Ri5rFbCX4VoJ/FRN2YXSgSBIc8q3oHL9XvT2GAynwHO/bMyXnqbDLnmesPZk?=
 =?us-ascii?Q?LUrdy6NLjzan+e3YXtVKSVxgPeZWElcSpIAyeRXIvAM0bNXvOjwBs+UFTeEB?=
 =?us-ascii?Q?IgYNazDhoJ3rVOmSNuN6kOFIKb/sUSOaE1vYm1mSv4YnXUAit2dDuyoXKMwh?=
 =?us-ascii?Q?WC7rvMvSqLcVx8JUgFvPGGx0sX5va98N7U8my7L+q6HqQfUrGVRQ30q9UTHT?=
 =?us-ascii?Q?+IcbDdsUu9MS9LYBWMPOTXtVdD9K5Fxxr4OSH//IH/3AoFB9sxTMnUq0HpbW?=
 =?us-ascii?Q?YGSVsO6pjxIirtvkOfkGC/WtRZF5rXx2wTQc0cjoC9qE5UycUTA3LBMeyfTt?=
 =?us-ascii?Q?Xn50HsJ90JMorIg+rrlWZ3neeexj9P9R9PoauZQvLAH62JdwEHS0tH0aDSOO?=
 =?us-ascii?Q?sV4YVabXufLt8Bx/+5dnyawqllgKz+OhQZy1sA31XFzzH+3bF1hB8e70rSI1?=
 =?us-ascii?Q?ZKSXKdU+K4yyMQ8BD1AAT11xk4HsaPBHt6GRLv6U3TWlmmpCQhildlJ+CKny?=
 =?us-ascii?Q?XZpIGrY06z6vsMoUVEGSQZou0bcXi6z9sAOm9jSNpPvPeX6LynWEcOAIdQ/d?=
 =?us-ascii?Q?NZiRTkxfinE8I/VFkegWXGgkkmiVHyxNLvhmcWEFzT6j3bYK5M4OE58dieY5?=
 =?us-ascii?Q?mzCKQiTHmjXvCX5ab0PlavMbJzKera8IU4SHHYIlJ0qhWA31856hmDtBX47x?=
 =?us-ascii?Q?hjkZ7qF5xDobfXfqUmwkCOhVWWOslhLV7MFX6SIHt4XXOa8oOlNT+1YLz8aC?=
 =?us-ascii?Q?r60fY9te9gRenr92os9Rm1CDkVzwrgEeFofxYhRqbxn6vE+rZiuLnONNusOa?=
 =?us-ascii?Q?38mVNXdHYE2yWWL3Mk26mfpG8tFE+6fZnJHO5XaGsFrsxyWXdwuQm2QrpgHJ?=
 =?us-ascii?Q?lpMM+UOP0Rrpl+KzUZbTEJwvD5m+dNqNnfRjUtJNicAtR7eMsv9DykNEmDVj?=
 =?us-ascii?Q?sLaW/pmUVrHqyrxNsergyie8kG7IpnciLl1HagLzuEHM6uoxeecsk7hYoa9Q?=
 =?us-ascii?Q?122QNQu37lE7j9PC+GeNeWWf+LU/D80dRmq5nBM64TFyImmwoOjLLQXYEcD7?=
 =?us-ascii?Q?NnQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?91waifCrdeaG9FppYbvLWmrnQ7sVy1DjB58rFVQhk5nG07FfMNC2MZWrjjDj?=
 =?us-ascii?Q?uGylW4FYUN4sX/GQZCG//Uvv46EfwZz00sOZ5yUliLhREwsgWWdrefK9INED?=
 =?us-ascii?Q?ZMyt2IbHcsgRKSeXU0lKJp2kPaKPXBzdOJzKA2Zi4Fm3c54LCXDEOONWhuXQ?=
 =?us-ascii?Q?WJSh5X7Tvj9Bo20pRinYpuzz6xhT+bks1lQE8KBQs7oPTZmMmKz2r43FxKR/?=
 =?us-ascii?Q?L57ZooRrMoPaiMcmnJCCG5C4vvF1V3OVwrCJNRFgW3Gk4wyKxg6YAGtJ/VeR?=
 =?us-ascii?Q?IbdLLUoWBtKpIfIie/TyKZj8Tf/BoPRDDa0LmSIDA1ixzEUtMqoxMby8DnMN?=
 =?us-ascii?Q?CNgKh8FyP4Zg6yc4vN/XkVtUYw9YX5Uk8hMBW7Sl07d8h7pgR4fvuORpeSyA?=
 =?us-ascii?Q?RZIqQRa4CPht7awyFczYNS7sUTJhZ7D3H3NPzFotIBzEIljyAXyut4x2ze8g?=
 =?us-ascii?Q?ubFmLse1RffrbSJWEIKTEY0awGyHRsd6qBDVEoZqkJgjXaXfQ1h1Oy1p/Y9U?=
 =?us-ascii?Q?dsf3jqK2kYQPPTH4NAfTJqVAevJLpU6+nTcygCLq0BwstqOGbtIqG4K/OydI?=
 =?us-ascii?Q?DVUSpQYNf8n2Ttzv3au4uNJmNJq6fl9IESvt0YmRCoYE93/dLCXsAGSRaqDd?=
 =?us-ascii?Q?QLLsXZR4Jpa6u0ptOcwb3h3Jyc2pG9swDlkf2I9Yz8o8Agazr+VXBlN02jPB?=
 =?us-ascii?Q?XRD6NJasa/cV/X2qZcxwq0+U4FzLwq4QGSYNNhH8RknEz3CI1pb7OZROw1rp?=
 =?us-ascii?Q?GXigINaszq/by7fyn2b5ZZaCh32upWHIDkzLraUbjuMdP1SmQCpoh4yiNu6+?=
 =?us-ascii?Q?b/qpLT/9QoYiv18/8UdQQvqPJ5VRNB/yrZhtPRa2ThSuV2Y4GGoKpYbL0bDT?=
 =?us-ascii?Q?M1YsnHoWFtjLmYEm4ojL+mcWalU3aN1ljsDcpbpw0Zo5RYfBVnPKuSF3vZdu?=
 =?us-ascii?Q?3mU5CXzIqj5LvWrKEqkYeMPhvMmbQne1wRcDPhKMR9OvWoacsFGHLxzSk1xb?=
 =?us-ascii?Q?0kNTfjq53Cqk3uEsehBCGxBYQjVSFo0KIY5EsL38gmkgnDqDC4gDPy0gbOA1?=
 =?us-ascii?Q?hefPYGkKqOkgWdUhzfIusKQrp5wHgnU0CJ45ikuWOMe0dgcOIV7WU6+IQFuL?=
 =?us-ascii?Q?oCN2UvzBvRAbKFMd+JQ25YNbxWFN+29tYeBzKzWQhxIW1c6H8+tpUHXf/Jx/?=
 =?us-ascii?Q?4GoQxsuYA/7aQ4//TPeFCgbwPz5XAPZq7FQJfgYwiKLr9X3QXc2L5+6zc6qp?=
 =?us-ascii?Q?EW0WknTGJReh+edXhrjOE0I79y3JbMSuwK+bOe8rHYD0+DnwJo/+t+zGRD8n?=
 =?us-ascii?Q?ZoxmXg4NR4sTbzSduMpaHm/4gT3myPV9nBaXIXL/3tnJnt5Dn845x0yTS9go?=
 =?us-ascii?Q?RYWkObg+Uzhxfb5Pxh6wWEqVIekCAEfYAaxjW7h2w5vv92AvGfjnpk+lLinJ?=
 =?us-ascii?Q?trYRQCNWXVUY5JGFVn7syG3yrGyC3wWl2Z2rkb0Ttwz4KF/jO92ypccp4HAL?=
 =?us-ascii?Q?r/ywqGm/txWn4cUgM2VdALczL0L+4ErsxhZY4TvqgSiD7VQm9GRkqYpOqQ+/?=
 =?us-ascii?Q?yXO8grZ+KP1VnT2ij+hWaBIjYMmJrqcGyf2gShAxmC4iJyUphud8Ls01Oefa?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jzC8kU7iecvsWWir8lpsL7TEknlcIyi/5EQfrlwjd7LpbvqMTEKuIYMg/Ie3Ogg4G080/7n68HnJ0QxDdC0ng1fbD3ugcNmZgq0p0lFehbrRwrFJ6aCvr0rtb1DSwUgbDiVpcAFI7l1n2Br7rdJQwNB2+e3z86d6mpy8b4U4PQNjmoUNcydJZaTV5PDNnAV0igdJLpQwe0798OiL1XT0h4rJlWWiW6oy8DzbLsCbzIwYvY5FGDFoUXzJV75DVuXb1Oh6fDc0XEpOhvvpFiIqh3rzG6rKeH9vKPUbhr3iSqI/qLTDs+aVeubQmpdaomTCGPZcmfQ9ReQxMyWOB4DeDmCxql32eltCddUivxXJPUAexI8rE1aP5s+HiPwplrO/Dd8eOcKecgOsXTx4fQAEgsCQ20ubybfFyO6VsfvgcLUIp1v+hFrvvVgpzpl2r34cTQvMssganlPiT8XeP7etZxwDDeWD4D64aGcO2ZuykPv0vMEoFCO/u7nSi9vZtNzBQbPn7X82LXoItike+nmiDM1YGgRsWRxSLkygvmqQvnnB6GZagKVCoZtW05pTqf5pwBn/kx94Un+wtpK+UB7uSuUqZtNqMjEIdOM2X9pq7sA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dac395c-ec83-49a1-1fb7-08dd08cff771
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:25:46.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ViHG74RqtdnPp/qhV2uuXfTyMPE0BV9UMwXdHCROoQ7HEzbJZ9RTBx821dpCyeMhR6XuqL1gGaGlBttYlvcPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_11,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190144
X-Proofpoint-GUID: IUw7PLt9LfDVGKFCiKlLOgs-p9WrtEJO
X-Proofpoint-ORIG-GUID: IUw7PLt9LfDVGKFCiKlLOgs-p9WrtEJO

On Tue, Nov 19, 2024 at 11:41:32AM +1100, NeilBrown wrote:
> Reducing the number of slots in the session slot table requires
> confirmation from the client.  This patch adds reduce_session_slots()
> which starts the process of getting confirmation, but never calls it.
> That will come in a later patch.
> 
> Before we can free a slot we need to confirm that the client won't try
> to use it again.  This involves returning a lower cr_maxrequests in a
> SEQUENCE reply and then seeing a ca_maxrequests on the same slot which
> is not larger than we limit we are trying to impose.  So for each slot
> we need to remember that we have sent a reduced cr_maxrequests.
> 
> To achieve this we introduce a concept of request "generations".  Each
> time we decide to reduce cr_maxrequests we increment the generation
> number, and record this when we return the lower cr_maxrequests to the
> client.  When a slot with the current generation reports a low
> ca_maxrequests, we commit to that level and free extra slots.
> 
> We use an 8 bit generation number (64 seems wasteful) and if it cycles
> we iterate all slots and reset the generation number to avoid false matches.
> 
> When we free a slot we store the seqid in the slot pointer so that it can
> be restored when we reactivate the slot.  The RFC can be read as
> suggesting that the slot number could restart from one after a slot is
> retired and reactivated, but also suggests that retiring slots is not
> required.  So when we reactive a slot we accept with the next seqid in
> sequence, or 1.
> 
> When decoding sa_highest_slotid into maxslots we need to add 1 - this
> matches how it is encoded for the reply.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 81 ++++++++++++++++++++++++++++++++++++++-------
>  fs/nfsd/nfs4xdr.c   |  5 +--
>  fs/nfsd/state.h     |  4 +++
>  fs/nfsd/xdr4.h      |  2 --
>  4 files changed, 76 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fb522165b376..0625b0aec6b8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1910,17 +1910,55 @@ gen_sessionid(struct nfsd4_session *ses)
>  #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
>  
>  static void
> -free_session_slots(struct nfsd4_session *ses)
> +free_session_slots(struct nfsd4_session *ses, int from)
>  {
>  	int i;
>  
> -	for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
> +	if (from >= ses->se_fchannel.maxreqs)
> +		return;
> +
> +	for (i = from; i < ses->se_fchannel.maxreqs; i++) {
>  		struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
>  
> -		xa_erase(&ses->se_slots, i);
> +		/*
> +		 * Save the seqid in case we reactivate this slot.
> +		 * This will never require a memory allocation so GFP
> +		 * flag is irrelevant
> +		 */
> +		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid),
> +			 GFP_ATOMIC);

Again... ATOMIC is probably not what we want here, even if it is
only documentary.

And, I thought we determined that an unretired slot had a sequence
number that is reset. Why save the slot's seqid? If I'm missing
something, the comment here should be bolstered to explain it.


>  		free_svc_cred(&slot->sl_cred);
>  		kfree(slot);
>  	}
> +	ses->se_fchannel.maxreqs = from;
> +	if (ses->se_target_maxslots > from)
> +		ses->se_target_maxslots = from;
> +}
> +
> +static int __maybe_unused
> +reduce_session_slots(struct nfsd4_session *ses, int dec)
> +{
> +	struct nfsd_net *nn = net_generic(ses->se_client->net,
> +					  nfsd_net_id);
> +	int ret = 0;
> +
> +	if (ses->se_target_maxslots <= 1)
> +		return ret;
> +	if (!spin_trylock(&nn->client_lock))
> +		return ret;
> +	ret = min(dec, ses->se_target_maxslots-1);
> +	ses->se_target_maxslots -= ret;
> +	ses->se_slot_gen += 1;
> +	if (ses->se_slot_gen == 0) {
> +		int i;
> +		ses->se_slot_gen = 1;
> +		for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
> +			struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
> +			slot->sl_generation = 0;
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +	return ret;
>  }
>  
>  /*
> @@ -1967,6 +2005,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>  	}
>  	fattrs->maxreqs = i;
>  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> +	new->se_target_maxslots = i;
>  	new->se_cb_slot_avail = ~0U;
>  	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
>  				      NFSD_BC_SLOT_TABLE_SIZE - 1);
> @@ -2080,7 +2119,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
>  
>  static void __free_session(struct nfsd4_session *ses)
>  {
> -	free_session_slots(ses);
> +	free_session_slots(ses, 0);
>  	xa_destroy(&ses->se_slots);
>  	kfree(ses);
>  }
> @@ -3687,10 +3726,10 @@ nfsd4_exchange_id_release(union nfsd4_op_u *u)
>  	kfree(exid->server_impl_name);
>  }
>  
> -static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
> +static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, u8 flags)
>  {
>  	/* The slot is in use, and no response has been sent. */
> -	if (slot_inuse) {
> +	if (flags & NFSD4_SLOT_INUSE) {
>  		if (seqid == slot_seqid)
>  			return nfserr_jukebox;
>  		else
> @@ -3699,6 +3738,8 @@ static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
>  	/* Note unsigned 32-bit arithmetic handles wraparound: */
>  	if (likely(seqid == slot_seqid + 1))
>  		return nfs_ok;
> +	if ((flags & NFSD4_SLOT_REUSED) && seqid == 1)
> +		return nfs_ok;
>  	if (seqid == slot_seqid)
>  		return nfserr_replay_cache;
>  	return nfserr_seq_misordered;
> @@ -4249,8 +4290,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>  
>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> -	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
> -					slot->sl_flags & NFSD4_SLOT_INUSE);
> +	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
>  	if (status == nfserr_replay_cache) {
>  		status = nfserr_seq_misordered;
>  		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
> @@ -4275,6 +4315,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	if (status)
>  		goto out_put_session;
>  
> +	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
> +	    slot->sl_generation == session->se_slot_gen &&
> +	    seq->maxslots <= session->se_target_maxslots)
> +		/* Client acknowledged our reduce maxreqs */
> +		free_session_slots(session, session->se_target_maxslots);
> +
>  	buflen = (seq->cachethis) ?
>  			session->se_fchannel.maxresp_cached :
>  			session->se_fchannel.maxresp_sz;
> @@ -4285,8 +4331,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	svc_reserve(rqstp, buflen);
>  
>  	status = nfs_ok;
> -	/* Success! bump slot seqid */
> +	/* Success! accept new slot seqid */
>  	slot->sl_seqid = seq->seqid;
> +	slot->sl_flags &= ~NFSD4_SLOT_REUSED;
>  	slot->sl_flags |= NFSD4_SLOT_INUSE;
>  	if (seq->cachethis)
>  		slot->sl_flags |= NFSD4_SLOT_CACHETHIS;
> @@ -4302,8 +4349,10 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	 * gently try to allocate another one.
>  	 */
>  	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
> +	    session->se_target_maxslots >= session->se_fchannel.maxreqs &&
>  	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
>  		int s = session->se_fchannel.maxreqs;
> +		void *prev_slot;
>  
>  		/*
>  		 * GFP_NOWAIT is a low-priority non-blocking allocation
> @@ -4314,13 +4363,21 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		 * allocation.
>  		 */
>  		slot = kzalloc(slot_bytes(&session->se_fchannel), GFP_NOWAIT);
> +		prev_slot = xa_load(&session->se_slots, s);
> +		if (xa_is_value(prev_slot) && slot) {
> +			slot->sl_seqid = xa_to_value(prev_slot);
> +			slot->sl_flags |= NFSD4_SLOT_REUSED;
> +		}
>  		if (slot && !xa_is_err(xa_store(&session->se_slots, s, slot,
> -						GFP_ATOMIC)))
> +						GFP_ATOMIC))) {
>  			session->se_fchannel.maxreqs += 1;
> -		else
> +			session->se_target_maxslots = session->se_fchannel.maxreqs;
> +		} else {
>  			kfree(slot);
> +		}
>  	}
> -	seq->maxslots = session->se_fchannel.maxreqs;
> +	seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
> +	seq->target_maxslots = session->se_target_maxslots;
>  
>  out:
>  	switch (clp->cl_cb_state) {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 5c79494bd20b..b281a2198ff3 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1905,7 +1905,8 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
>  		return nfserr_bad_xdr;
>  	seq->seqid = be32_to_cpup(p++);
>  	seq->slotid = be32_to_cpup(p++);
> -	seq->maxslots = be32_to_cpup(p++);
> +	/* sa_highest_slotid counts from 0 but maxslots  counts from 1 ... */
> +	seq->maxslots = be32_to_cpup(p++) + 1;
>  	seq->cachethis = be32_to_cpup(p);
>  
>  	seq->status_flags = 0;
> @@ -5054,7 +5055,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  	/* sr_target_highest_slotid */
> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
> +	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  	/* sr_status_flags */
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index a14a823670e9..ea6659d52be2 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -268,7 +268,9 @@ struct nfsd4_slot {
>  #define NFSD4_SLOT_CACHETHIS	(1 << 1)
>  #define NFSD4_SLOT_INITIALIZED	(1 << 2)
>  #define NFSD4_SLOT_CACHED	(1 << 3)
> +#define NFSD4_SLOT_REUSED	(1 << 4)
>  	u8	sl_flags;
> +	u8	sl_generation;
>  	char	sl_data[];
>  };
>  
> @@ -350,6 +352,8 @@ struct nfsd4_session {
>  	struct list_head	se_conns;
>  	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
>  	struct xarray		se_slots;	/* forward channel slots */
> +	u8			se_slot_gen;
> +	u32			se_target_maxslots;
>  };
>  
>  /* formatted contents of nfs4_sessionid */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 382cc1389396..c26ba86dbdfd 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -576,9 +576,7 @@ struct nfsd4_sequence {
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
> 2.47.0
> 

-- 
Chuck Lever

