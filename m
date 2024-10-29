Return-Path: <linux-nfs+bounces-7560-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BDC9B52DB
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 20:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771961F21683
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 19:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF820720A;
	Tue, 29 Oct 2024 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f4U5yNCY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NP1hsX6q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7AE1DDA2D;
	Tue, 29 Oct 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230809; cv=fail; b=bhHueLQUM9Voumcwz4/hg5litqAZWJNNGYJ221rwuGiD75BxheN4B62cm7mq58ijnvpxv1vYkSzb04IYfVz2amLfEBr123Zp6bE+gRkgy4ZLFMrwuyHUeHjYLQunXqVFz5ARW71fnBrpKX1lQuY4NiS+Ev/Pi8n9GcsQ9nNHRI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230809; c=relaxed/simple;
	bh=hWvyEH3sWP8PbayZXarbVBTi77Hi2DmJ39huyF+5Ee8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ST9Q2cEkMIkkzxAZOGpyTO1BoA05fCDImhA6DEmMdK4+DSEu9NU7pNT/Vc7lLa5o++ePuUATUTL8x2F3M8gvS3SikcGWORaOXEBQwgS+5GbgbcLyXZQBtHS0Z5tWdsyqJR9+hpERxi40ftL088aT8ldRGJO3uI7dG1F2zLs5k4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f4U5yNCY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NP1hsX6q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfWpi030955;
	Tue, 29 Oct 2024 19:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Kss/ZPAPE05g81BqYG
	VH6SgYo89vNBrORJpWHrmJKwA=; b=f4U5yNCYMsVhhLuPjhhzSFvqiW3rsTtIjv
	GdSPpi5CCzMd4l+V7NU+W5jHCZ5l0E9bs5lxs+IkZNC18Lt3b41PmGILGLhlWpIx
	JWrKOJviHs6ScEy2Gs37teRiEH9R2O8/+bAm7Z6KhPpTmYhtY6KXQ93OAaa0JfFm
	H2n2AxLsYvkAYZ3IfUkBktFoDAVJUNF1ap3iiZ4k1PHq5FSZ7JN0kpuVyj2DAKWX
	YbvcmpmmZAnIy3K0LmIHTKVzDPMDh4IJoIMsLZat3Ytr5RkUV0XeP3W1fFl9sXy+
	dXK5vlhbZQF//X2WAWGglcQCXemjqPopbPZCBsPrcV45MqaChi+g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp6ee1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 19:39:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TIbcew008439;
	Tue, 29 Oct 2024 19:39:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnea58qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 19:39:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JchMiYZdVO91tJQ3wWVCd4jaruQ1hpEDtQEGFuZ4F/vi0T8/IDTI7kT2WVyN52B9Jloyh8y1lwWkdX3n+Y/TdOVQhxk/LLzg2gv5R1i1+hiyhIS976RIqE7pKO+hrDmur7tDQisoZgVWfhtvOSj3KiXs8z2/Ztd4H5HU1wfzL8lKMLUgp3HfmaUykH6+1QkTk+oLR1U1mVukCuwlkz7OvDpZR1KoS9BHhniJ9JqmOnGAk3tkQeE7CrrBKjSMS/n1vmX/JFvvLUucaCHMSVuLn5YrJDH0Zolsx0/cZ2/+odOgtQw8ohsGSgl1rUAgYuqPfEJCtn7FZoQzjyn82L4CgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kss/ZPAPE05g81BqYGVH6SgYo89vNBrORJpWHrmJKwA=;
 b=JhnWJVdYP/3aMPCcPvshB2+cM01MlzrTqNbcYVnWMuhiDXs/Lbzt6EeTnwdk69XcLgiITxpLrKaeGscm1VQYWAZ+GbrKXgrCfBp9lg+xYgHGUfvzorbC/02FfTLHZuglvlo7Xw9y58iLsJv0oXFeByuTJYIE2g6ivGS/Cprdwl6y/E0ZYj5BUKyJe7byv6SOou7DIP7L+nxppJehVzBuWIUHRYffi8tUCaArpUHMTgQsNoq/13PZ4ZD9GhpXXQCiYNuNUm0gak9ncBpNegQ6orM6DpgSt79s1peu+2kFz9HE+aRzvJ+Z1O1NfIjb9acIibWFqOSNj1jcdzWGYIxzGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kss/ZPAPE05g81BqYGVH6SgYo89vNBrORJpWHrmJKwA=;
 b=NP1hsX6qIsPdQiCsw8qgX5x8C69lcovbe8z0vo/6ogyjAsvANSHJe7bsIcnU/Kxk0ZV75M/tr1EYn2DZl/4XTSvkatVJP/ws/Q7TEohqMTioVIrCR3xlD+br4oj2gAED8ctyYCmfIU+FKvEIwW6k/uJYqj0onYVpnInqzchHqV0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8003.namprd10.prod.outlook.com (2603:10b6:610:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 19:39:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 19:39:51 +0000
Date: Tue, 29 Oct 2024 15:39:49 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: remove newlines from tracepoints
Message-ID: <ZyE6BWVxzHh5IiAT@tissot.1015granger.net>
References: <20241029-tpfix-v1-1-19f69fcf915a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-tpfix-v1-1-19f69fcf915a@kernel.org>
X-ClientProxiedBy: CH0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:610:e5::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f94ba1-7a9f-4f82-db67-08dcf85174d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CE08MNmVTuA15xvJTNShqYiDcacP6nd4ys6CLztZBTG5m1QkzCU9bI29kIHP?=
 =?us-ascii?Q?bMqtUCzvRuUiz3XlyyTNLf8v2aD2SFlCuPceEfTxrArqA+6KA0TRfhh6b+B8?=
 =?us-ascii?Q?5Ri76reuQx921rbFP34TKeglthiA1w2VTD7EnoHA/YW2+htZE6tzyOvR5Ofp?=
 =?us-ascii?Q?/DG/7G8UfFko54AeHnVOtTMAZdcXUs7KJaYnKIxcKcys5GioJjtv5bx+ulOJ?=
 =?us-ascii?Q?iJ8SqLN6AQXFQvuQUIj3EMGRaJ4qWaCrvtj7qIFyK1c/m+h7cAYyOSg2L3yE?=
 =?us-ascii?Q?uTTCEEAVexYGqkEimwG2M7PPnwIzvSuiqj52pxZNiaQXpGEx3F9bF46s0QxK?=
 =?us-ascii?Q?wUOurZQj9Yo2ERMxmqIf6oIDMIUAv+rDpK8YUIKNXYTRb7oR1jg+0nu1yuQ3?=
 =?us-ascii?Q?nJjHSpS975kxwX1a3uROUTStznLMJWv8o+IV+hY8iZ1ONk2Tur9j0sJf1qgU?=
 =?us-ascii?Q?9zD7QZFWsfVktZutZymdT7KSND9hyBXzZn+/b9EC4h82QNHfJLN6cUYv1x9U?=
 =?us-ascii?Q?pEISb28Mn8Zcqqqr3x28WuyrMEfk8UkLW0uSdg58t8KlPFjUUt06ZQcSVbOe?=
 =?us-ascii?Q?kII64uIPqdy9v1nEHzlIduZpWQsg7JyDc8AIzz4Y8SZjAgsrhmj90dxtuWSN?=
 =?us-ascii?Q?bicTeTI8ymEaa4EnRYnmQr6VM7GxfoIhpbozOPClsgMfA95i/molFLJvN7Tm?=
 =?us-ascii?Q?yTJoOBgkYqi5I6uC/1d392z3M7VcG7ePAjO0TVpClg0BlCgB1WB/GSITOhiL?=
 =?us-ascii?Q?+aIMYcrKjvMPRL5tU34tEsgFY5170N+Q8yTe5Vufrmus1Y5T4Dz0QrbQrs6W?=
 =?us-ascii?Q?cxfQ0/4TnU0D+aDm3mORh9K1yw9ly0bvMBaETR9uteiiQJaVf5xEHkf/6sEB?=
 =?us-ascii?Q?Cdfb7YCkuq39ehyapWeClEoHgEumkmxPRg7JgF2GX5tsg2j2q8lfvKTVK/J+?=
 =?us-ascii?Q?QA+YbDcK3zT+8Jiy/Q5hGwddxA04ngFG5gVDe8VruhOUO8dP0pKh+x3nAFYi?=
 =?us-ascii?Q?9ukEKHVtYxOih3OtJUpYrtV+WP/cpuP50whjRyQanSMFdXG/WEtB9Tv2tV+S?=
 =?us-ascii?Q?FKjt5uICJAI5wBiZwn0I2A+CTsBscz+Vw5TXAHNIamJmtdPrUADZ71fiusAC?=
 =?us-ascii?Q?5TqkCLu8/AktWI3SoK9nSHDWQIvRtOi9RWzAc5EKHCRaw12Nm4nACdAU46LG?=
 =?us-ascii?Q?9ixTOCwEt+67PpJV0LeVzcZ3oyYHZ1ByzqC4rUXjrR0xZo6so4e0OokcoJ5H?=
 =?us-ascii?Q?iENAm2U/sP5y2OG7bg+AAE29akiXzuYyemELYWbNPleRTPpgszno0on3G0Ic?=
 =?us-ascii?Q?BzDdSpj7TWUgmLzr+HQexkq9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yA6hsXlDd1Dwdxp7XW6sUP9VK0OKavmnr1SCYMBwSzXZm/6L0Me7ARnFatm4?=
 =?us-ascii?Q?apXnTZKbiBY5yR78DK8fRZAa0vMb14C7eNhnWCb9kbkyHwWGciRLIDyNeIb1?=
 =?us-ascii?Q?/eSbFSg8UrtqxiftTHwUgBtbbKJUwKcdGjkYv6J7R4XEknbRMxWh2HlEIyhH?=
 =?us-ascii?Q?0t83yurnQ3hgaTTJlVxc6SDhKOJHT1Hhz3zUSC9y+Tr7QaA9uKZtUaYN4Xg8?=
 =?us-ascii?Q?nuPUMHosf4P4a6Et3xZfBlAJs/eWCXs0TfUZYXD1u6Qn44OX7ZkJwGzZO3Ib?=
 =?us-ascii?Q?cZQ8w5WR1BRgU1qjPwFChdHpq2O/eSfKwHjZ4ELJ65VimoCATgeIhbmj/KIR?=
 =?us-ascii?Q?aX3dtfztL4u5Ot7wLJIKn2iOOkXb7WrZIpmv582CUcqNnouoY01GDC/TjzG1?=
 =?us-ascii?Q?n9rmFaQ+fwFi5tzQ6CKkSluEzA+DiAX3IHbBr9cwYL6AYvXlHUBcXXW6MJwB?=
 =?us-ascii?Q?5a8prizIGvLB99/QVJIYuo8kuHqoaGKU3FWAWxkEmBEsV0AuUDINpQHQyBkO?=
 =?us-ascii?Q?F96UvMEP4KAEWmIKYO1jiEI2KhSe2v2TUhSPXjBRCAOntnxgO2RFknSHG/OF?=
 =?us-ascii?Q?lL63sg5Ve9SDrvBWkE0gmhO89Ye5KA3dcwn/ocZmdetOT4C3/ZBVKgqBfTWJ?=
 =?us-ascii?Q?xi1JWzXWd+cYDx24j/eyArYcpER1tceXhCQ36a//OzhEKx+fbLRrWekRd1O9?=
 =?us-ascii?Q?QMu3o1Eiy7nJScq9WV+EGgh4gyf/aHT7sIqaSOBiYerpInEHLkAN65jBCDdG?=
 =?us-ascii?Q?zhGrZpb0UiZvgT5hlBq7/M5kpa49StefKj2UQFGXOO8/iyrDUmOP0pSaTC5P?=
 =?us-ascii?Q?dWbVPXSJqRS1yXDoj9AWnBjP/4IGYRXZN4zwiybX1wP8yHFa0gQpClpWbqPj?=
 =?us-ascii?Q?+VsEgzajCyt3ADSe7rhr5cIYihOdTWdQMGPhNx+LsnR0e5NdpB8d6xIE2p1y?=
 =?us-ascii?Q?T6VQD8Sk1zFQfsfFuUJnRYxZu1CcMuJiPWd4dF/AnV859QJS8d9GqDMTpxZI?=
 =?us-ascii?Q?Se8DEyLyCKPNCP8Kw14NQ/GrWoJsGa5R2KkJBLqz8wnqCX22q1cxrrzuvKTF?=
 =?us-ascii?Q?CvRgfXyzIagL26Scz64JeRWQEF6D6ZKE3wmZ/M+6zZnD3Qe0XGSuw7nM6mWl?=
 =?us-ascii?Q?ikAFN3GGuaWWEVnRv7fgSxJKj3f0C6Oj41GhuFd3Td1xHRUvRGtWZcWMp1rx?=
 =?us-ascii?Q?tAgnmxlNxwk+s9HGso8yFBw6w4bI7Xw4bVpaW9NFtiZqtbha5cJ+gEebOvfS?=
 =?us-ascii?Q?q8/gawOT6/KMnIT34FeOuEZ/VjLUc2jrqyDjErxmexqcySjzt7K9TGyEF/5o?=
 =?us-ascii?Q?auO3KVHLM2KUSoMQR7kzaojTN1m0WT+MuX+x4ncJYwGXVDVYn3eNXuazgCJ4?=
 =?us-ascii?Q?UE0qfVwTfB0W9YT1cukZ8cwJ4vrIwsBWtRaIiGJC7f7jYeIROBkHdHc9+EMF?=
 =?us-ascii?Q?dzLwGMBEsPC+wrckYtw9E5bBLczTYDIkZ7Y5i9Xuyz0w6HaE/Qv/81NDvViV?=
 =?us-ascii?Q?xLSVtj9xBSqnmfpMlJw1t3hWER2hDzg2BKnZ3VcHgvDizYU9Rb7oAaNJJ+qU?=
 =?us-ascii?Q?JosONSIpOLaCQdBfrxf3BpL4Eo+oklHKpGBEHQ/y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dR2KK4KbY3TrQD+JSZ1EiwJbQvgwqaY9mW9SQktEquHjY8US+oTGpoDiu7M2534vS7+iRPs7+rv+kWNpSL83Al309lbbh4QCa9Tetxu/mAQAxdpBlITTifU8NWGbQwuh2GEFwp+OHA26MONJe3OggtL7bBnlNekRlhpuAsQ+COvNwZggxvTNUOV/Bntb3KWme6R1QSNiH2jRwPu38y2z2PLzd/wCDn5adztaMnCg9qH39GDkuOxByEcgnIZxw70Ddz5cK+l95SwR+ehBsNRsBiFjOKDYzsJEd51NYxlVrpMxsRyf1QxHWfIU4tkcHYab7s1KzJqPk+3humwe56wmypKJOLJRDxptDbzts1CnzgfRct/QEbrH0q9LaU14ciVc+NA2lFbSBC/5uad9xWgfXcVc4Y751dEvhfhs8aiNGXzMHY5i4e9Eaj1wB0SWQ200zGctqSOlvT3hcr9mmW8ZDbo45eMTu+673Tqm7sumELFD96S72ShVb4svWaCnov/RmnWHZy83kObRbXQdivT6s1rQnKWqM8supfhrmICrGREBPArRoSGtkRkH7E+0JwuBU+V3BjPBvLkSd9KtKOnxzoJNIolzeUP1YzUHB2Sh344=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f94ba1-7a9f-4f82-db67-08dcf85174d0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 19:39:51.7930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73Kb4tbYS+TpAQwq9Lvw+Uq+UDIIy6qZclUrUOsGrV1idtqeYtWdWxwb73h4Iz0p0Y88XEcr8Gp5URV51TR6kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_14,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290148
X-Proofpoint-ORIG-GUID: T12eVB2z2akFWEW5Gst9KlJblo6-RJpp
X-Proofpoint-GUID: T12eVB2z2akFWEW5Gst9KlJblo6-RJpp

On Tue, Oct 29, 2024 at 03:21:43PM -0400, Jeff Layton wrote:
> Tracepoint strings don't require newlines (and in fact, they are
> undesirable).
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/trace/events/sunrpc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index 5e8495216689549f1c0bb377911eac4a7bb7b1a8..b13dc275ef4a79940a940dd463b7a3eef5ca428b 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -719,7 +719,7 @@ TRACE_EVENT(rpc_xdr_overflow,
>  	),
>  
>  	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
> -		  " %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
> +		  " %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u",
>  		__entry->task_id, __entry->client_id,
>  		__get_str(progname), __entry->version, __get_str(procedure),
>  		__entry->requested, __entry->p, __entry->end,
> @@ -777,7 +777,7 @@ TRACE_EVENT(rpc_xdr_alignment,
>  	),
>  
>  	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
> -		  " %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
> +		  " %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u",
>  		__entry->task_id, __entry->client_id,
>  		__get_str(progname), __entry->version, __get_str(procedure),
>  		__entry->offset, __entry->copied,
> 
> ---
> base-commit: 9c9cb4242c49bbadd010e8f0a9e7daf4b392ff6b
> change-id: 20241029-tpfix-252e1f852ae4
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

Looks like a client-side trace point.

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

