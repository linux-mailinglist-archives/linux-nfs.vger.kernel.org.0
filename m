Return-Path: <linux-nfs+bounces-7089-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8A499A6F1
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 16:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18101C20F83
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E4C195F04;
	Fri, 11 Oct 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lKxwKq3J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GyrEw4bB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C319596F
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658280; cv=fail; b=dhJ3320Zb0KfaX7Cwj4qjwUTW5rAcHvQTAM9ztyRuA9rPSFTcOt/ASOA9eZw+TJicbeQ/LKKrf+TT+r8yPO+qlC/S6cOA/5xduxXoLr6NHrDDv8CPa/rVmjJUHIOQuqiQrn/6IB1g9YvUrrou/B9g3DTK7Tr6Wz6n/1h1AX+cxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658280; c=relaxed/simple;
	bh=8lGisgfPtZxv1R9fsw6I0GZiE/nTfkiTWpa9hG2Zpg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hFxH6DyZC/GwdVCaCQdjwnzD2MjIfotPjDb9OkI5HHnffleaPTCO1LP1FXLAYxoYgCcNfdQk+SvdMiPxNGdDjVMtbDuJM5HMXLe3Lz6LanzluTHFaUz9970YqwmmlI7ivjn/2Sj/qGXWHpoCJzse1Lmhz4eS/ivDQnKI8ymOx/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lKxwKq3J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GyrEw4bB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpUsj015015;
	Fri, 11 Oct 2024 14:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=u5aS4+zugPF3koFerb
	fbBANlErhPJ1+jH4OyJtODCTM=; b=lKxwKq3JuoIFgjhQJKzU1laCLlE5ODVZna
	DYt5EQMMuED7jybhKATqYTaEWrR5shg19d5AlMnLr66tbtZS6b4eGW9XDw2TxxV/
	0SHpyX/hG0cv4gyjQd6amdEBd3v8GePc0HZeO4e+TmxfyvFVEOd78HrM9jf6N2t4
	VsTyxfaB6dXdIm8v2FhcAKgnJ8R5noDNVfcWaSekR1qyClzFYc1Sl4aJsHW77w5H
	szi356DgHDtxVWr//eLs+NlIROqEXtAZ5kFC/5/Wh9vedpjPeu40argLS2tb2x94
	2HNxdlcOvju5P3me5WGb30vAGHhVBm8HSKTXKgEgTc4LSk3ZEBBQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e556w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 14:51:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BDuwGe020641;
	Fri, 11 Oct 2024 14:51:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbfmfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 14:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAnKp5ZlSzaRM6LZSf0Kzl26H+KLtgOa3RxHQF6DbYN/0a4S18U0MtdDFzsEsI3YLMRU/SKzUDy4zVjrF7pPjJe7n01Ki5TPgU89/5u3NCKPH+a4z6jjIMJVtCzrd/V1de0+dQdKjJ5QvU1RU3EWvgH4ZlfngQA/slKcuLsa91uhofjzcGlZBZI1FNOs6TUpjvvOYruLsrcX1C9uIFI0iImmhohr3fXmFwFMHRbTq3xDxdCkZm96RlZ5CahKDTMNQR9j70QGpzTPll+AwZ2HkMDanxDapvc4gcVd2BhlBVS/knD0ZPOcKwpY9DQQ+HCAyeY+ouQlbeNIhrPGvFxmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5aS4+zugPF3koFerbfbBANlErhPJ1+jH4OyJtODCTM=;
 b=S3qcV0lmw98tq1fPQwxBxwEns4fbSYVzZwmEft7ub6UG0jcajjMafVBC8W8g2aaxbD21HqroHkQC1AWVnUKi+S4XqVsm5j2BJDY+QHyhaisqEGkMjHesrD1CUu+P4bf/rIZz3uvb3Aaoz8OyNPpOQ/TbbA+PDe4cAlBBH/gVRqj9Lyti6gh5lMAIifdFhHhSa6mJEl6MPpY8ZNy4eWYqN5DqF8dCDUrXB/RrUzZQ7bYkJkts3K04Ztv8S1lGoiLHLZ5sDNgT3xfYfiEbG2gZMyKgIEB8C6+98xWTRpL0Fyw+Bh2BtxG5xCQrRff8X9Yo+Iy/kpyZ/8HRe8NDO1QX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5aS4+zugPF3koFerbfbBANlErhPJ1+jH4OyJtODCTM=;
 b=GyrEw4bBQjiTrnVMGoc1uD9g7E5PF5QyoV2VFJJMkQv5185/O63QPUOyA+RT50uK2w89VGOU2yNA+fso927aKkC5pC4Qt8G4RSu2+D3nCsKbWm4xCesNQkrfX1mUDC7JTXgxHTvLlHqDEqR1mwLreWSN4vxCxZoIz0jAoampKDY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6562.namprd10.prod.outlook.com (2603:10b6:930:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 14:51:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:51:01 +0000
Date: Fri, 11 Oct 2024 10:50:58 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH nfsd-next] nfsd: refine and rename NFSD_MAY_LOCK
Message-ID: <Zwk7Ug9oFPa7kLxG@tissot.1015granger.net>
References: <172859586932.444407.11362678410508147927@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172859586932.444407.11362678410508147927@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:610:e7::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6c66da-a806-4034-1ac1-08dcea041f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BWNpPX5d+5rZvbS6YYCsCU2Hc9iGIDWn3hBv21irHCCf9lRWR8xMErSID1mN?=
 =?us-ascii?Q?DVr7TkzVmdOw5eO2NSc8JnthfyqGU7oJsVlX/M8+OTLriPhLE6wxglu/Dzt4?=
 =?us-ascii?Q?79rILBOCLF31uN4CtBw5kF2zQJ5LpfkpWwgVgqQowILbyha+pSj3h9J9tgji?=
 =?us-ascii?Q?6PGjYGZC1OigIGc3Nfbnssl1OWcP05yefXJyDxR012iDw+s0BsYUBV1YhbMb?=
 =?us-ascii?Q?GgIwqw2UaQhIJjjcXBT36sjBimTwrjOVGvIGp2yqypBTnYeISIJVEZa7QwlX?=
 =?us-ascii?Q?Q5/lDWQdJ1dweTs2jCeTfNLCU7h+4nHA+KO5Fg3v1Fo2Ddxn2L9S93gL9LnA?=
 =?us-ascii?Q?47S4YTwXupn2Hgc2UYQYaExkNWpfjt4Dj8gqiDmRlqE0OUSoklTdsMO7FA2s?=
 =?us-ascii?Q?O7D2VNqWp6+QwCOe0+KQaXcwYydxk/LSMVL1wqt3ry93utL1Ypd1iFoPz5UN?=
 =?us-ascii?Q?+mHd364PL0sgJn/SWJdI4ys9SlOJCxGypsz/im9snMivqU5OageyevVeeZTc?=
 =?us-ascii?Q?39aNv6o4BPyplJt1apSyGFXOLzZGGBCA7yvwKJHl1zdXBttoKt+cFMXrUw/V?=
 =?us-ascii?Q?vOQnSN6PEPZVujtGmhkVTpB69XaxpfUvKNARbfeOazDIBGxgOR+V29PFw9fD?=
 =?us-ascii?Q?C/iEzr5B8STo5AAbhtK8FiFukXsvKj8UhZsJSlkrzcjX4wvb8mBzhRn7zOml?=
 =?us-ascii?Q?6TIVgsljxOxVqrypcTDVQKTtLNBdaugS0hbEZangNfK7xaJZC93Anm/ayX8K?=
 =?us-ascii?Q?lPAcopzXRh0I5VlSlv6ARC6PM/ERqb+cUGBJ2tpjWmNYhKZSmQnqPa+4lgPL?=
 =?us-ascii?Q?pLd69TPynlkS0t0uZz52RvhMfke9YZFrKvHlmBbdL8rMo1fPaeHVgO7fFt/N?=
 =?us-ascii?Q?MMBluO56cRVX+Y0CopT40z4gKKegtX8JumN8oXDZZW9VldgwvS5pGm6x8T3u?=
 =?us-ascii?Q?8g+tT2zUTpRKcfFYnkqaZ11aBrbly1ZedOuWVr/MMe6hnOi2kVTe4n09187j?=
 =?us-ascii?Q?tUqrBgSArOUdfqDKaR3dPy0peCWQEQHcdrhu5/uLaqX6C/NRTZjrZjoTzrWx?=
 =?us-ascii?Q?ELDj0U2W5bFDOKyIZFEUVJj449sv4xnPkXZ/pveV61qYVxLI15ANrfiU6MRz?=
 =?us-ascii?Q?LmK3LUquVhox+iCB9/xOGOMcsSZhS9OlCxL1fXww9egp27obg1mkB6iKTbKo?=
 =?us-ascii?Q?9CIPRfz1HMr0kIXzG13L4NlKwHqINuyvPdMSjMcdeoIWqnZejfiKZBvz44dV?=
 =?us-ascii?Q?6y5gEpZQbyvTQpRCA+bte73l1GKzRvWj6SxWLHyVvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sb/PYwexTLQwvjdIa8EV9tCiGR4F+YfRXNA3c7lE27Z9YbEwexq7vMXdsYP+?=
 =?us-ascii?Q?SzGNeg1Kxb4AsdJmzVNTz1hscoQkHawk/tBXtId79AaF6iM57QJo1RcsvfoQ?=
 =?us-ascii?Q?GTqViY4E0RQI0vErfjXo/u2egDfOveXDYq69s8PBtxGF+CWsgkertmw+eAHj?=
 =?us-ascii?Q?CANhP6FUkiEKUYETJI25wMWuWamrPqR13AfuYRWe4AlOA7QEXyiKdSLLZ5/6?=
 =?us-ascii?Q?w10qETuizOCGs193MBzRyYhpsjKY5Wuf/ZV5uXrY6zPYkyeLc+yutuHoeBp2?=
 =?us-ascii?Q?iMjsuaoPRF5sYoJBYqKvWdaJdGHSY9gCWQy/316v3+yQiVKpffYKQyjFCooW?=
 =?us-ascii?Q?weK764cjPDEjJ8MPw1jAhMvbR0NvWzcY7A4oZIxvOYapsJ79J0DCHThzrKL2?=
 =?us-ascii?Q?AV9nB3I8oEl/wEOOTowRSJ8ujA1E/qoAmXP7bp98acHko6dsO0X1GsEB8Vf8?=
 =?us-ascii?Q?vxUOUpiYXraYieKN345zHiaUd6JCtz8glDc2/rqDEdUMa4PWLusuM2ySW85z?=
 =?us-ascii?Q?IlE4mKlV4NBPUn+Ii8kvO4fmQ0GQr9JPWyBShMxUclCSql/p0KGJlMcEmYNa?=
 =?us-ascii?Q?2lcVrvx/M7rBol8lS+fTR9+CHBVtQ1+vrbKxd/tJZLnlWvnAHlManyiRI/aL?=
 =?us-ascii?Q?JSyHsqhkNa7vBK2MRN8Yus1fhwuju+6Ul+o5V9tZwQdKd1l5Yi+YZd4FQqQ0?=
 =?us-ascii?Q?4ZSgXiAqM1VPhIjgwPcP75/pd5Ayr3bO5G1fKtbO2AVtruA6N2qbzsLQ+lpN?=
 =?us-ascii?Q?Xi6+CFvZGzECpo05lAMHbOkpQUDiGx7fzazczfFGyLR0EO6ztagtq+qXdrYU?=
 =?us-ascii?Q?HSkIfXH+XwmoqVOzvZqtoibybZvJqXCrmMNNw1mcYz+TyI0J8WYSiopJWkUe?=
 =?us-ascii?Q?CToV1wugFQYnssr8wkuQGESoyVxHG9w+uJS3icatRzBUkjJJfslnPObTAY2L?=
 =?us-ascii?Q?4WRf0XUxvyjpDTTmPJJOTe75v5q34EF+dmWBHNIwFE8Njn4GU0WxR/QJS/Ax?=
 =?us-ascii?Q?//udMd9vAF9RReQpfkgi4TuhMClGXE28D92j874T0jvHyqK+PJE3+pvG2z1x?=
 =?us-ascii?Q?nx9Wtjxkhe6wXi2uezSecepTBvFOXf53qCF1mEYut07L8ZCNO8wqI8hD1d/M?=
 =?us-ascii?Q?01CvDe3xj4AmWzpkH6hioLqmNt40U0ynwq0X/9Ku3zKtdz2MfvLZQ+QwR7jp?=
 =?us-ascii?Q?cwBu1iZbhZgU4Xn2oTwwSDoMlqAB9njBb44pUbbvXTPf73gP0dGWPb/2BZcb?=
 =?us-ascii?Q?q9hAuNAIOLE1tHSr+fW9P58tqhi7kEJigENfKauSCJsKqm1YWkAyPrVKL8GG?=
 =?us-ascii?Q?KH6MPgPFfjR6ejSNQRPIfoqqe+AZEfuEGrigTZ/Vur+k62j60lnL5anezOe4?=
 =?us-ascii?Q?jcQ7lOaFDoORPBtnj0/TYt16IdEjk6vIhYAh1UxBs8mJZDkJ6TxpHOtdA1EE?=
 =?us-ascii?Q?tAbI5+zWczvhNMldk5rN4pRLnJzPbpulsDiMkNVuxj2BIaHj8fRzuKjYkB72?=
 =?us-ascii?Q?PYWbAVDdBIvJ71PfuTGs1GWxgMEBsjkaWAOVUpAml26SCrZuywS4YBdtbGzM?=
 =?us-ascii?Q?SgRjoixZhsjuyvDxThW3rL8Nh2m2Bcb3QIjbVP2f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KbXo/IhtYceGyTP2us1I769ysRgBK2lCHuYN1QuRKyuS5+ctzazu4GRBR1tyqeoLkDpU73dp0ZtQo4kKiiIoKx4nej9YOCj8aNq0szJF3vHPXMPtq5/o/CbMvjABolXKRb8ok3eQHFfArYOzqTbxVauZrgu4wxS8z/yJdBO8vNi6OE0LMY7V923yqWLCx7hhSbu/lkSaMobiYQlW5gAjyxU31LKRb/rc91IBfdb4e2m5Sv16NiE1f8Im856+FtH3/n/NX7EMStLmbvqLdQ6xZxTAcvmxG55ovTe4gep/54EwzRuuhE3up3yuEGu6ywbhKRuY1ZE9e4pOQ9JbzjfgAdzF5KElU1kNFCei7K/zueLvyYrkNWWgz+HmEHg9u0exlHLEeIheg0gWjL+tI+tihddXK1x8nvhpsqNCVhRfuFKfy0KNJKoY2JYuDU38EJPRDI4T2dOmXkLtKweGAp3/Pn1imJ9M8CbJACkmm9/4uQJUKBK0eE2PVqBJ7cQIkugRWSzDf64gJpY1HWwfiMUofCFmZHbiat1iRY2DYvOZ+volUjrTLlETyq5swwACv4Ls0UvVZpmMvRHVdlCBWySi+T6p7b0/9sH5jJ+Yg4Swo3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6c66da-a806-4034-1ac1-08dcea041f94
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:51:01.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOVla/xBHjBsyjnM3wjvH1f/hCt2zOe+Vm+HOEws0W00+83sQYl1bgkgV1dgILR1ZMnCRcO902jLEJuAatvCSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_12,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110102
X-Proofpoint-GUID: NanPFNwY4EgjKaKdX_McCTeq4ZttLOjO
X-Proofpoint-ORIG-GUID: NanPFNwY4EgjKaKdX_McCTeq4ZttLOjO

On Fri, Oct 11, 2024 at 08:31:09AM +1100, NeilBrown wrote:
> 
> NFSD_MAY_LOCK means a few different things.
> - it means that GSS is not required.
> - it means that with NFSEXP_NOAUTHNLM, authentication is not required
> - it means that OWNER_OVERRIDE is allowed.
> 
> None of these are specific to locking, they are specific to the NLM
> protocol.
> So:
>  - rename to NFSD_MAY_NLM
>  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fopen()
>    so that NFSD_MAY_NLM doesn't need to imply these.
>  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
>    into fh_verify() where other special-case tests on the MAY flags
>    happen.  nfsd_permission() can be called from other places than
>    fh_verify(), but none of these will have NFSD_MAY_NLM.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/lockd.c | 13 +++++++++++--
>  fs/nfsd/nfsfh.c | 12 ++++--------
>  fs/nfsd/trace.h |  2 +-
>  fs/nfsd/vfs.c   | 12 +-----------
>  fs/nfsd/vfs.h   |  2 +-
>  5 files changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index 46a7f9b813e5..edc9f75dc75c 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
>  	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
>  	fh.fh_export = NULL;
>  
> +	/*
> +	 * Allow BYPASS_GSS as some client implementations use AUTH_SYS
> +	 * for NLM even when GSS is used for NFS.
> +	 * Allow OWNER_OVERRIDE as permission might have been changed
> +	 * after the file was opened.
> +	 * Pass MAY_NLM so that authentication can be completely bypassed
> +	 * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH_NULL
> +	 * for NLM requests.
> +	 */
>  	access = (mode == O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
> -	access |= NFSD_MAY_LOCK;
> +	access |= NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_BYPASS_GSS;
>  	nfserr = nfsd_open(rqstp, &fh, S_IFREG, access, filp);
>  	fh_put(&fh);
> - 	/* We return nlm error codes as nlm doesn't know
> +	/* We return nlm error codes as nlm doesn't know
>  	 * about nfsd, but nfsd does know about nlm..
>  	 */
>  	switch (nfserr) {
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 4c5deea0e953..885a58ca33d8 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
>  	if (error)
>  		goto out;From 226d19d36029605a16d837d1a94a6f81b6e06681 Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.de>
> Date: Fri, 11 Oct 2024 08:23:08 +1100
> 
> 
>  
> -	/*
> -	 * pseudoflavor restrictions are not enforced on NLM,
> -	 * which clients virtually always use auth_sys for,
> -	 * even while using RPCSEC_GSS for NFS.
> -	 */
> -	if (access & NFSD_MAY_LOCK)
> -		goto skip_pseudoflavor_check;
> +	if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
> +		/* NLM is allowed to fully bypass authentication */
> +		goto out;
> +
>  	if (access & NFSD_MAY_BYPASS_GSS)
>  		may_bypass_gss = true;
>  	/*
> @@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
>  	if (error)
>  		goto out;
>  
> -skip_pseudoflavor_check:
>  	/* Finally, check access permissions. */
>  	error = nfsd_permission(cred, exp, dentry, access);
>  out:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index c625966cfcf3..b7abf1cba9e2 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>  		{ NFSD_MAY_READ,		"READ" },		\
>  		{ NFSD_MAY_SATTR,		"SATTR" },		\
>  		{ NFSD_MAY_TRUNC,		"TRUNC" },		\
> -		{ NFSD_MAY_LOCK,		"LOCK" },		\
> +		{ NFSD_MAY_NLM,			"NLM" },		\
>  		{ NFSD_MAY_OWNER_OVERRIDE,	"OWNER_OVERRIDE" },	\
>  		{ NFSD_MAY_LOCAL_ACCESS,	"LOCAL_ACCESS" },	\
>  		{ NFSD_MAY_BYPASS_GSS_ON_ROOT,	"BYPASS_GSS_ON_ROOT" },	\
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 51f5a0b181f9..2610638f4301 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
>  		(acc & NFSD_MAY_EXEC)?	" exec"  : "",
>  		(acc & NFSD_MAY_SATTR)?	" sattr" : "",
>  		(acc & NFSD_MAY_TRUNC)?	" trunc" : "",
> -		(acc & NFSD_MAY_LOCK)?	" lock"  : "",
> +		(acc & NFSD_MAY_NLM)?	" nlm"  : "",
>  		(acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride" : "",
>  		inode->i_mode,
>  		IS_IMMUTABLE(inode)?	" immut" : "",
> @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
>  	if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
>  		return nfserr_perm;
>  
> -	if (acc & NFSD_MAY_LOCK) {
> -		/* If we cannot rely on authentication in NLM requests,
> -		 * just allow locks, otherwise require read permission, or
> -		 * ownership
> -		 */
> -		if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> -			return 0;
> -		else
> -			acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> -	}
>  	/*
>  	 * The file owner always gets access permission for accesses that
>  	 * would normally be checked at open time. This is to make
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 854fb95dfdca..f9b09b842856 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -20,7 +20,7 @@
>  #define NFSD_MAY_READ			0x004 /* == MAY_READ */
>  #define NFSD_MAY_SATTR			0x008
>  #define NFSD_MAY_TRUNC			0x010
> -#define NFSD_MAY_LOCK			0x020
> +#define NFSD_MAY_NLM			0x020 /* request is from lockd */
>  #define NFSD_MAY_MASK			0x03f
>  
>  /* extra hints to permission and open routines: */
> 
> base-commit: 144cb1225cd863e1bd3ae3d577d86e1531afd932
> prerequisite-patch-id: 7a049ff3732fdc61d6d4ff6f916f35341eddfa04
> -- 
> 2.46.0
> 

This makes a lot of sense.

Let's get my nfsd4_lock() patch squared away and applied to
nfsd-next, then I can apply a v2 of this one on top of that.

-- 
Chuck Lever

