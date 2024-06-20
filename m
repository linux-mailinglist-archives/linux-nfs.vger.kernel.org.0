Return-Path: <linux-nfs+bounces-4154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E69108C0
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A530C1C20AC0
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF47E1AC42B;
	Thu, 20 Jun 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UCx1wpfb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZP9xO2bI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92B41E497
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894752; cv=fail; b=C6nys++cfAuI1CFRaB/0o5rpIn4g84kSiHT66HiHUfm2ayibBr0E9xPEcl6Iznv/mi/yBZCFtYKbfkJpjz1j5fl2b+4h3c4k/MMyQ9nCyYOWwsGj1YI8ITXqQU5Wn5/NEXO+GR8MQmzjS1EabApPy6Vflxw8iKvLgckV2djPfsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894752; c=relaxed/simple;
	bh=fw7ZtaZ3CnarUjf5kzAa0oZS8IKX/2EsNkRhALOjGoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RjMWAKt8Z5qNsMSi543YbY/o286TYOoNSNSLpH9kYkZ1xpqvRCsyImoWFZbN5BN8SM/b1zt1xyur9GubIMwetg81IGqxaJJV+bT+9nwEMJRzdMGdqvhS865j1/Mo1K/hoNMSiNIky9WhmX4Tq1Sh9WMq6ESwVb2Ept/lQJ+UzRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UCx1wpfb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZP9xO2bI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KESUQd019959;
	Thu, 20 Jun 2024 14:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=zyca1If5mrxaJiy
	r0vgqXHJsf5y9har5DqmcdBzqwXg=; b=UCx1wpfb2PL53Han37bCIzSe89OMoMp
	2lKt50yiAimNiEIx3105BDc3fWlCaNBFwpjatmdFRWIxUz3pupJnvTSK5fxKbkH/
	5etCle06Ii/snXL0UnUMLx5moEVGVsy/+5T+bV6pJoEe7eezfNC3IIt/NQ/otKJs
	2Q51tEzKSZG40qvTNvJrdzGz9nXCPRzEm5YsEiWRtYLxlvMe1DWjX7j2JA0sU6b3
	7RY0btHIGfSJVFVlzv/+f6KF2phXxBqIbaa9EiDDodX2wsjatkuNVKevgEdbJr4V
	20baZSWcFzvOBHb914336oW4pesKvEAXeA1m6sjkfF1q+Pc7ERLqnfg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yujc0bd5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:45:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KEaxN2034465;
	Thu, 20 Jun 2024 14:45:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dh4yyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwxI5KZc+NtftySX5sMtp7UJeGCqzjgNUxsS9AKAlyoe5oJYAbJcxRPfgbGukEQDf23ikW8bdmwFY+B6QC2jc5W3jenvSE/9vyjbWpxKeiJ/eGqHAF/EFlfA5bu1VucSV0eXZALUH75QJWdl8wFq2SPXWREHyHuO/2+C8KXBwQsXPLIroQM7CTox8W9I5R+X5u7438/YN6WPdW5AKjfl2OCKLEa4PqITiA185j1oLAHt5hjW8fZAGwiNoSZ0BDAYga5QTK7F/chBjXKrJSPrTcTewH47pMboq9SSF2rUbFZUBsx77EUJz2/uI4WsQQ6X0G2xCpcNdZH/ywahKtp6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyca1If5mrxaJiyr0vgqXHJsf5y9har5DqmcdBzqwXg=;
 b=JmpKIBASimzHZqlbKaXyreNyrtnFcua+w3rahD4QCGnpuysPMKW3CYKGcM1T59O73xp3hAB1hYeb4i2JgwOs5OwRbNyQwRR4jMkY6gDIDTJrK5xOWWtwJ2JQ+6ocjtZIrufaUaW5VU+CNMsuE9N6SazhFbQPmvX7ihsQjlEWCXYwojy7AcGMng3XdBUhXCnd/FBpiDvCWbU1Dt0IP3LuO57I7M4QBL5iGNhtWOdciBcsBzzOjVH29JVzrbnPY4iZo55PqoQq/h0TtoIb19ETubiINYb9zvmCrPWsskaHi50mjenRNBX1LxE5SQUzUwQITbt5lmKsaB60Z3yr8yldkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyca1If5mrxaJiyr0vgqXHJsf5y9har5DqmcdBzqwXg=;
 b=ZP9xO2bIGOOTIiO1dzbRO0kUXrgfmJE1rKpflmeMjbrpsi2yvG5MnmbA3yjdBw0MowA5+4chTHlJGvM1+BjyG/RxB0mNoZOxY1h5aWMqf/FjVHRxFVWVLoO/+6YTJGkQtMXYdFa9GP1Gg93HVn55lFIkAWCwVQVgMzpSpRzRL2Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6608.namprd10.prod.outlook.com (2603:10b6:303:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 14:45:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 14:45:37 +0000
Date: Thu, 20 Jun 2024 10:45:34 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v6 17/18] nfs: add
 Documentation/filesystems/nfs/localio.rst
Message-ID: <ZnRAjqjpOmOyERAc@tissot.1015granger.net>
References: <20240619204032.93740-1-snitzer@kernel.org>
 <20240619204032.93740-18-snitzer@kernel.org>
 <ZnQ0FSQHJLPHxRsP@tissot.1015granger.net>
 <ZnQ9q9n1wJrBNRC9@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnQ9q9n1wJrBNRC9@kernel.org>
X-ClientProxiedBy: CH0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:610:b1::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 577661f6-2103-494e-eb48-08dc9137a5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qW5QZPF+W7oC+Z3ayW/s8PeeebbDlsAVOy7d0DJH0O5F7QsmyVqfL79vLXc6?=
 =?us-ascii?Q?m/f5XgJDn75uoQR4TXrELp8J2qCIJZ6UXwZKbUDjuvuREnn4LzERriKJ55YX?=
 =?us-ascii?Q?Ir9Cq690LyqySjeojLCgeaQMyfRbZ6hFgPILF/ykP3Ef7UMDP6GRnu/J7h0i?=
 =?us-ascii?Q?tQDRzzTKzUjVZ7cBcRgU2MhAKdAI8FSBoLCoIIqxqX7q4letQ1NSa0oxDUg7?=
 =?us-ascii?Q?ELktTUZmGpExCt9a4RJX17KwUvfH1tJ4KErcUqnx9GY7mprUk8En2j3knz5o?=
 =?us-ascii?Q?G6oUw4OkMAJngKDQKpsVgG3Hj8lpw4aW+G0mcMHovlRe47fJYZ7n6YdSxoHQ?=
 =?us-ascii?Q?18WO1ajKOfws4wHsysnK2bJqD6j14REGH4b1MG4NwqCgLTK4eUeZj4+Ly9nC?=
 =?us-ascii?Q?BS+58TD3It2vbiwwxITsPzXcRUHuuA46WDPgJxb32gkbT9u8DprEhNwKhAvq?=
 =?us-ascii?Q?E7C0+NpfvsBGqL03pFR8I1sF04b9h1hinFZymB9Y7XX3MnAz8GjAx0naQT5h?=
 =?us-ascii?Q?UaMALUiqt7x/cGEnZqrEP0V8cawxruE0Y1Zd41NUE2bJdqXvV4XZuS32p6UG?=
 =?us-ascii?Q?rLkVLQRBgextcgZ+3GVyLSw9nkLtRao3VSpV9OjdQ4UhOdh1ew12FSn/RECl?=
 =?us-ascii?Q?Xz7R1FqLqGa//oUUgiEsvNXTSQd3tW4XSL5GIyMhbW1bHX3hAXnuO8dc0tmQ?=
 =?us-ascii?Q?lqFx3Uo4puH+FYkVubGtFEdTtplCkC/nHMCt3Idp8LyWCpoQ30s2e6JJQdN0?=
 =?us-ascii?Q?QDFlL4UT39endb083DWvJkROgT+V4CZKuaI+IJDCuLdGfRBnfGFTIfyY3In3?=
 =?us-ascii?Q?CIIAZA989EvEVP+OH2ikJez3fwx3cgLhjM6gW/pP6V7+omQYWQgyAPrYsMrn?=
 =?us-ascii?Q?igaaEn/UM2UqBPWIQ4Sa2pXCHAHvtVT0b1oewOO6XXkWjAmGp9tsYVoHD9va?=
 =?us-ascii?Q?UYnKrWZO2EonNEnCZZTYNbDJjPOqh99dH9z9k0kdRcxWGhxwMMZ8/gq48NPi?=
 =?us-ascii?Q?RcMBSUvoj2OPbgxATexWx/FjGpw7s2Kh3bh3sdOtULZx9F0Qd+OM0NEVXQsS?=
 =?us-ascii?Q?1xWiUnI7CWgmc8BQgtGXVAXM2h895FkF5qijmiVzr6MPzY165wHPxt5RdbGl?=
 =?us-ascii?Q?B2WR/mOYesxIlD3e9uJbTKsuFqJhC6o+kSlBx8+wWxNIIrTZJ+fLoRQFaThg?=
 =?us-ascii?Q?Kn3UMClxlBJvR0j4UW/J5K+C+LfEefNS8LqmxkZaBp/t6NmWMmAnjpyZIBiW?=
 =?us-ascii?Q?JTn2NIAHMFhGqbt2Kvn+2pdkgijat8irf5KJRgXJMvnMIjm7n22FtxMwHKKR?=
 =?us-ascii?Q?sOuqv6CWoE+YYNYYp/5ZmdVX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8HdafJT9Yx3BRZnuQqUJe4+hVMgXbdxiTuWJY5hhSxbp0c667HklPRns0EOE?=
 =?us-ascii?Q?vQ8TR2qDAN9VoXkqQP2E+Is6m5T33/iRbEZu4FCON/28OhCM3hIvq4K3cFFv?=
 =?us-ascii?Q?ZVDAM/EmQyjmQvw+8sxitWDBDzXrqJ83ckba9lbfklltWgQVqv/tSGKkkTUi?=
 =?us-ascii?Q?6DcZXgT9X3wb4DjBgWxMwz5wWPSBe7duNoqtIobiE/m0vzbO58meyiUmv7Hz?=
 =?us-ascii?Q?6Jy+hUMV2ecWm5hgq3i2ZyliYru1csrZijyBJxZMXtQNKEw1gB+cH1ijFqyb?=
 =?us-ascii?Q?ZP2bbuC13zX7wvEz7VxChPI0RYRaCBTQ9dCDLrssDjSxpnno4s0/JdvSP7Zn?=
 =?us-ascii?Q?ZuFQCBNgRK5tHulxh8I1DmP8s4AMLoGhLd/XYpCmIzg8vbpGM/gmkwsAx4sS?=
 =?us-ascii?Q?dhsKFvuWWWkdMHWwc8i/MgTD9nXcP2Nhc3inmNvHss/dUl9+1+JUwhKTqWk6?=
 =?us-ascii?Q?fNgGoZq5j8wI+/aJiXQzZ4T3g6ZplK8/K7OIkt4i3Y4rqAFcyHkgg55gUCQA?=
 =?us-ascii?Q?qFRkVrMPThDCDWbXS6HZw+3Zu79wdTnQ1U2lpnLs21T57Q4oxsvl6jtcJjzN?=
 =?us-ascii?Q?+OgW+CsSyraIGuuvuXTRlQGc/dbSufKAhx7nf5bPx4fYKwvzWf0vs+dmx0LZ?=
 =?us-ascii?Q?5b5xB/gwFuu5SBsta60rGc8KmmbH3D6AvdtmQUl341BQqK0uyvW3O58xPzQC?=
 =?us-ascii?Q?MhnO+3W5AqBcc6g1axXLAyqLtiE+/QKevoVex1fGxcTa6FSMdJnejYCcyLO/?=
 =?us-ascii?Q?AyQwxBn05GgCLNmtQ9qTaoI9cH4/1ESQdDM4pf5yOsDnpgX0JTpOlvaiUTrc?=
 =?us-ascii?Q?jMbNurZb4lcyC+l8tSRrfQCkb2iltLzGRqnccIwMMY/hhdLGNUbJD6dTbTjF?=
 =?us-ascii?Q?z/tSOmQiafByJefueJk7cHv9+CbPNJkeT/WbJ8Wu8muGR3CRUYRrtA482IUh?=
 =?us-ascii?Q?eBXblCRy/X9Lf28MJTSZm0SNRSxGVoSa6zQ/nSi1rDr2q9oQgkqauCJRK7U0?=
 =?us-ascii?Q?PdyLsLsVso+KcPUuDtFQG3GL1ZS6k25YDqGtjIV6Ck7++QZTEZe+wEkZJWYE?=
 =?us-ascii?Q?U5t38aNXHW+00halj9ze0iBgYjMpsUvoS2mwHKUn3GqldpvkeykBzkHis1sX?=
 =?us-ascii?Q?11+FhkQY4Oxzx18prvhwQRLpa1If6FyqlgJerMsAG4NHvWk7f6Wdh9sbhMbl?=
 =?us-ascii?Q?w/SgMwbxsRtfcarmeaxPfNblGL6kct2QNY0LxVg9B1aJIrYJwiI/KcbvsROM?=
 =?us-ascii?Q?t/yc6e+aove/DdS43K8mq8Mbv1PPIRAAY79PcKn1wyAP7hak0jQyAPUs/LDu?=
 =?us-ascii?Q?fN1PgMElnv8ngaPsq3OuyJkM/Ogs+qcltNxo/ikGmzg6T7OJXgxWniu270ZI?=
 =?us-ascii?Q?ij5IAiy5TfupGmWl9bGnSQ05vcO1uPIHQ3R8fsPT4DueBuaGX39jAi7Jigz7?=
 =?us-ascii?Q?qa7OCmTJ4RsaKkpVAqwxGHwDMrG6NP9VjA4lsDjSG2Cr+Wk9lKi9zfOngK+c?=
 =?us-ascii?Q?SvwxgleETXOHIfOHI8zA7DEgw6rk6ig0yKEIWAC+mcc3oHAoNNJy3ttA9S9K?=
 =?us-ascii?Q?zkb/nQEaAEco2dWKQffu+lxzV2p0My85/rTZSTr2c0MUAOqkkGCpd73gUOBn?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6tljfVgNjlcLsqlEaS3xotbwzDesLr8Kbt1kHvo/KGJmEZbMe/Zt05Dv3hwkJxX3FB5G70NnBcW1mEy06qwXRIUF+j/vqjZouOn2Hszf/0tPHAhOIhvOobmDobsGLIKcdV4VCJPjUaY0HoEwVnLL44JICuam4ho7c7o/8lEIQRfl9m+4CkbOlFIKD25tjv7gHMVw0P4MSRURhlarcYq71WgMIZo/tL+mHY3OPI9+yBBaenkRSfdifjDDB17IV3cfFP5lSOZWawyLuCEfMoT1kAWRNsWZurEWPJClimg+rcgYw99dVhM0C45eGsLp/aQa4uwYwg8aZjUYnWmBJtDmx/N1OVDQQ8E0O3mUuj9W2/RMOOX3vHybTr4nuapVXZoVv+g8/CdK/hxYFLyT4+bh/we5GrY5SDsXOb10RrxsG/g3DJHsBvV65bI0PQNEoGSHWRZgwTs6wcUHgPx5FNPN1Ihm1Ve3gUz/YZTh9yxy+5NjWzfDU0xYaL1R3ERLe+MHwBhOrqfCC9dDpdooZuUdzpsIVMOFB3I3F1Uy+/FqvJOD6pbgJ6F38l9ENWThaC0DK5yBtUhE2ln7gWY5JVzJgdIlyKnHKg4BHXa++cqfaAc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577661f6-2103-494e-eb48-08dc9137a5f9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:45:37.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmRvi1EVdKob6843W01Gj0kHh4igXHtdIsiz4nm8rDxYEFdUVe0sezb6KsmjcOtbua7dwG/M2kX0AgcE/6NPnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406200105
X-Proofpoint-ORIG-GUID: QuYfnPZvlFYD-lhhdAaOUxRmMU9cECuV
X-Proofpoint-GUID: QuYfnPZvlFYD-lhhdAaOUxRmMU9cECuV

On Thu, Jun 20, 2024 at 10:33:15AM -0400, Mike Snitzer wrote:
> On Thu, Jun 20, 2024 at 09:52:21AM -0400, Chuck Lever wrote:
> > On Wed, Jun 19, 2024 at 04:40:31PM -0400, Mike Snitzer wrote:
> > > This document gives an overview of the LOCALIO auxiliary RPC protocol
> > > added to the Linux NFS client and server (both v3 and v4) to allow a
> > > client and server to reliably handshake to determine if they are on the
> > > same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > > the same connection as NFS traffic, follows the pattern established by
> > > the NFS ACL protocol extension.
> > > 
> > > The robust handshake between local client and server is just the
> > > beginning, the ultimate usecase this locality makes possible is the
> > > client is able to issue reads, writes and commits directly to the server
> > > without having to go over the network.  This is particularly useful for
> > > container usecases (e.g. kubernetes) where it is possible to run an IO
> > > job local to the server.
> > > 
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  Documentation/filesystems/nfs/localio.rst | 148 ++++++++++++++++++++++
> > >  include/linux/nfslocalio.h                |   2 +
> > >  2 files changed, 150 insertions(+)
> > >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> > > 
> > > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
> > > new file mode 100644
> > > index 000000000000..a43c3dab2cab
> > > --- /dev/null
> > > +++ b/Documentation/filesystems/nfs/localio.rst
> > > @@ -0,0 +1,148 @@
> > > +===========
> > > +NFS localio
> > > +===========
> > > +
> > > +This document gives an overview of the LOCALIO auxiliary RPC protocol
> > > +added to the Linux NFS client and server (both v3 and v4) to allow a
> > > +client and server to reliably handshake to determine if they are on the
> > > +same host.  The LOCALIO auxiliary protocol's implementation, which uses
> > > +the same connection as NFS traffic, follows the pattern established by
> > > +the NFS ACL protocol extension.
> > > +
> > > +The LOCALIO auxiliary protocol is needed to allow robust discovery of
> > > +clients local to their servers.  Prior to this LOCALIO protocol a
> > > +fragile sockaddr network address based match against all local network
> > > +interfaces was attempted.  But unlike the LOCALIO protocol, the
> > > +sockaddr-based matching didn't handle use of iptables or containers.
> > > +
> > > +The robust handshake between local client and server is just the
> > > +beginning, the ultimate usecase this locality makes possible is the
> > > +client is able to issue reads, writes and commits directly to the server
> > > +without having to go over the network.  This is particularly useful for
> > > +container usecases (e.g. kubernetes) where it is possible to run an IO
> > > +job local to the server.
> > > +
> > > +The performance advantage realized from localio's ability to bypass
> > > +using XDR and RPC for reads, writes and commits can be extreme, e.g.:
> > > +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
> > > +-  With localio:
> > > +  read: IOPS=691k, BW=42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> > > +-  Without localio:
> > > +  read: IOPS=15.7k, BW=984MiB/s (1032MB/s)(19.2GiB/20013msec)
> > > +
> > > +RPC
> > > +---
> > > +
> > > +The LOCALIO auxiliary RPC protocol consists of a single "GETUUID" RPC
> > > +method that allows the Linux nfs client to retrieve a Linux nfs server's
> > > +uuid.  This protocol isn't part of an IETF standard, nor does it need to
> > > +be considering it is Linux-to-Linux auxiliary RPC protocol that amounts
> > > +to an implementation detail.
> > > +
> > > +The GETUUID method encodes the server's uuid_t in terms of the fixed
> > > +UUID_SIZE (16 bytes).  The fixed size opaque encode and decode XDR
> > > +methods are used instead of the less efficient variable sized methods.
> > > +
> > > +The RPC program number for the NFS_LOCALIO_PROGRAM is currently defined
> > > +as 0x20000002 (but a request for a unique RPC program number assignment
> > > +has been submitted to IANA.org).
> > > +
> > > +The following approximately describes the LOCALIO in a pseudo rpcgen .x
> > > +syntax:
> > > +
> > > +#define UUID_SIZE 16
> > > +typedef u8 uuid_t<UUID_SIZE>;
> > > +
> > > +program NFS_LOCALIO_PROGRAM {
> > > +     version NULLVERS {
> > > +        void NULL(void) = 0;
> > > +	} = 1;
> > > +     version GETUUIDVERS {
> > > +        uuid_t GETUUID(void) = 1;
> > > +	} = 1;
> > > +} = 0x20000002;
> > > +
> > > +The above is the skeleton for the LOCALIO protocol, it doesn't account
> > > +for NFS v3 and v4 RPC boilerplate (which also marshalls RPC status) that
> > > +is used to implement GETUUID.
> > > +
> > > +Here are the respective XDR results for nfsd and nfs:
> > 
> > Hi Mike!
> > 
> > A protocol spec describes the on-the-wire data formats, not the
> > in-memory structure layouts. The below C structures are not
> > relevant to this specification. This should be all you need here,
> > if I understand your protocol correctly:
> > 
> > /* raw RFC 9562 UUID */
> > #define UUID_SIZE 16
> > typedef u8 uuid_t<UUID_SIZE>;
> > 
> > union GETUUID1res switch (uint32 status) {
> > case 0:
> >     uuid_t  uuid;
> > default:
> >     void;
> > };
> > 
> > program NFS_LOCALIO_PROGRAM {
> >     version LOCALIO_V1 {
> >         void
> >             NULL(void) = 0;
> > 
> >         GETUUID1res
> >             GETUUID(void) = 1;
> >     } = 1;
> > } = 0x20000002;
> 
> Thanks for this, nice to see I wasn't too far off.
> 
> > Then you need to discuss transport considerations:
> > 
> > - Whether this protocol is registered with the server's rpcbind
> >   service,
> 
> It isn't, should it be?  Not familiar with what needs updating to do
> it, but happy to work through it.

Well the issue is whether a client can assume that LOCALIO will
always be running on a fixed port. Which, IIUC, it will be. So I
don't think registration is needed. The protocol spec needs to
state that the LOCALIO server port is fixed, and that makes
rpcbind registration optional.


> > - Which TCP/UDP port number does it use? Assuming 2049, and that
> >   it will appear on the same transport connection as NFS traffic
> >   (just like NFACL).
> 
> Correct.
>  
> > Should it be supported on port 20049 with RDMA as well?
> 
> Unless there is some additional code needed, I don't see why it
> wouldn't.  But I haven't tested it (will look at NFS's RDMA support
> and wrap my head around it).

Head-wrapping NFS/RDMA is a multi-year project :-) 

You probably do want to have LOCALIO available for NFS/RDMA
connections. I'm not sure that requires extra code. I don't recall
clearly, but I think there isn't anything extra done for NFSACL,
for example.


> > > +Testing
> > > +-------
> > > +
> > > +The LOCALIO auxiliary protocol and associated NFS localio read, right
> > > +and commit access have proven stable against various test scenarios but
> > > +these have not yet been formalized in any testsuite:
> > 
> > Is there anywhere that describes what is needed to set up clients
> > and a server to do local I/O? Then running the usual suite of NFS
> > tests on that set up and comparing the nfsstat output on the local
> > and remote clients should be a basic "smoke test" kind of thing
> > that maintainers can use as a check-in test.
> 
> I just figured running nfsd and nfs client connecting to that
> localhost was obvious.  But I can fill in more howto like info in this
> section.
> 
> What is "the usual suite of NFS tests"?  I should run them ;)

Start with the cthon04 suite. We all seem to use fstests too. There
are some others, but these should be sufficient for your purposes.


-- 
Chuck Lever

