Return-Path: <linux-nfs+bounces-5617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D27095D037
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A017D1F218CD
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790D81885AE;
	Fri, 23 Aug 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J9nEfdT+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DgjMDAhh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BCC188596
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424189; cv=fail; b=pS6w98DAbiITJs7uZ+Yc9ONjmI1ppKq63IrT5MPFcLIwMqtT4yeXMesyOZnwK/Mik4IaDG8jZ/fE8xs85JTcyW2IniwV66e2Zg/SB+ihPl4jZ4jVqMKekHBeuSUq23sJI+0uQnfyI6F0w1sOGOAXRSV5dFhqliYNEI1olgIAApI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424189; c=relaxed/simple;
	bh=nPRyWfPChvOqsr/aayLBqT0abGPdk9kULB30UCz8QDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yqf92M6A6LNzFTJg47kMxveJ7+jmqBnfJTMKOGrTwC5DcaO3CsVYCt19GP5YNld1z8xH954M0bx38iCiz7r1fBwL44GJhevh/00zHDD5YgmjiQJk/Dk7fdUWeC4BTDE+oImW6CgkIeP2YWeCou16SQNWjzydY1kQCLNnwgi7fEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J9nEfdT+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DgjMDAhh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NDMWia001030;
	Fri, 23 Aug 2024 14:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=SKhnM/k/8PDi0lf
	VnOP9oqESPbw75u1KC4jpr1XQXvA=; b=J9nEfdT+GXcaZMvfHu05tGBOxAu/R7B
	I8O3zQwqy3OgxrrIjEZIL3V8fGUd0OPX6D5aMjkL9Q6DxiAx9hFU5svcSf8sCOXE
	k3o4p46XQnjDJEGSvt1W8rTCheBWB5kKVgJ/t0Cf5ZFJJr7ygRWv/ankO43mE6le
	3E7UScmFQvttIR/qkROC03Sa3BpYy1WExolkYKVA3Wt1NjxhJCRxax6h44NMBr2N
	JXumrzY5yjdjFktoFdXXmmGeiDFAoudGehkaiJ4VPOkZ19ua9tjn77PtafZpu5oa
	q646uv2f4rhOFGCpV8Tp7x3ef2v6oH3Ewf5OmcflBNqWTTRy8FIPE5w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 414yrj6rge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 14:43:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NESvLA003177;
	Fri, 23 Aug 2024 14:43:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416v7srjr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 14:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5MPNC/3JFax/Qjc8jeSQwHjk9jSKYgMDn1ndLjdshdvV+GiutaHjcdbWnq8aMv/KAiQkvrrbbAzGKETpv5mHR84sWNl4kUnl4ZObXTGJ19SAKXvWLoP4sf0+7L7mnTKEF04zxkTMIcIv3IyHPUyISoDrOgzJUmvyVWH7bSDI8b1Cy8zC1IZsoHsoO+nDdK4UOZbZ9DygjhJ0GSPG2MKMBS7hzTqJd9zxTr3S38hjLDdAHJm2FBFIonsmYHBpLCx0ARah8KGmDCjfFU21gC38WM+8ohBa60G/hzFgcrmlJEZ4joUQ0mZA0QqEIclcyrHKFXDUZ1tb/KIuk4hMGNlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKhnM/k/8PDi0lfVnOP9oqESPbw75u1KC4jpr1XQXvA=;
 b=Nty1kH71claEbdjJMEeXy8PLpC8uv5oDq9vHgp2ieowWoS3CuKDnRmJIShvUWWN7S/whVooVaS6+mT8cXzIyqB71Nc8dPy7CEfr7VwN+HdGd04QlNA4XR4TmZsPD893A4WVbx5nhfAewG7YYBiQ769XOFBdBuyjeHW6vNUsf0LzbLsCWfqGkac2JVsgjnmA722iO6vndizSsYq9igJnnjVBRo9N4SXLJ8zk+8BoEa7YRwWy/G+0xyeY/qpUNOPUK6AAJGM3JQ8TPibdUXh4BvLHRAwRCGndt6HU1Fhx8WFCe83ZHBslF7hBF7tZBsrmukoSIHUfe807ffWuxmQT0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKhnM/k/8PDi0lfVnOP9oqESPbw75u1KC4jpr1XQXvA=;
 b=DgjMDAhh6Rl5LSksmgKGpVmqQbptgjX5C+Z1oQlko1vNvKMtfbuICP8YaZI24UMgA7CDaMZaA+74lU+BTpZf/kgGby4It0P4tubaLFE1tueqF7RWZW4zxtZtx3DnIA2iQW1aIhUqylLvV3s3LivwO0iR/II/Daw3wJRK9S+6LiU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5707.namprd10.prod.outlook.com (2603:10b6:510:149::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Fri, 23 Aug
 2024 14:42:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 14:42:53 +0000
Date: Fri, 23 Aug 2024 10:42:50 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] nfsd: prevent states_show() from using invalid
 stateids
Message-ID: <Zsif6pDBfVm1sUiV@tissot.1015granger.net>
References: <20240823141401.71740-1-okorniev@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823141401.71740-1-okorniev@redhat.com>
X-ClientProxiedBy: CH0PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:610:118::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c802ef-72fd-4461-2df8-08dcc381dee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h38ZmeFMssPs3sGpemWx7hmzz32IZS7DJDZ0AtpEQF43ZMQzAKO0aCwgBVWx?=
 =?us-ascii?Q?vGfwHRTC4cVlaglsXSBFTvUTWugi6NITZ426GiSFvQd05gCtZF3k4qCSO4bi?=
 =?us-ascii?Q?xPZG6fkpP2ITniuV11GYUOyF9TUVnTjiEX841qvc+Tia3/B94b3AzjIYqq08?=
 =?us-ascii?Q?p6uFaPiFYd3oCg4x0cBmqz8GQlzQldu0uho8glyF8tQOdFUcHLDVX43aJgJu?=
 =?us-ascii?Q?VVa/vcNrhelKgoPBHxBUmaIOPsJb10L15LRZP09zOAWb93pNk22rMr1Z17Vf?=
 =?us-ascii?Q?WWUYvqT3ZUn8T47nGBtYaMNjaCCta3PygJefJW7h/0j3dVam+Q74w17uj4RH?=
 =?us-ascii?Q?nYZn26k72+g+OSmjaryZCH3Gj3jUbal6uZhOyjB/OO5KSgFOn9bzmKn8WJr+?=
 =?us-ascii?Q?xPuO9NvWbFMz+FfePqCqOvtzt+wT+/3v/S3s/cVPuePbcH/7gpbmpQ5CQbJJ?=
 =?us-ascii?Q?QijV/wxclVIQWyMb5Rm/G0p0nfjW8cEKNl5KKdo7Oq7hWKGqPoikEbcFjSRG?=
 =?us-ascii?Q?KNB9257kQ4VhL8G6x7dSyFhSqJlkjo5sPJULuoz2miZDYTjguR+S9kS8rgA3?=
 =?us-ascii?Q?BgHVlTcqeMoWKqE40eS6hOcUJs6wuFay48C15OSfru/1Vx0z6WLF/9YGr7h7?=
 =?us-ascii?Q?B+NYwKU+gcJ3Z/IzvWKz+Cwvee9xQhJqEWpj6P8A+4gdV6FYLLwZwQcHJb9v?=
 =?us-ascii?Q?pY7cCGPZeahqpz8DzwU8Sc/lbXKJipDY0ffut92jSAiHoVLTz0Gi4b175s8h?=
 =?us-ascii?Q?WVOtEQIud5ur1Dc2BD1GffnqQBU+y7D8v2gsGPgiUeDGzDBmfd1j27RHSDCL?=
 =?us-ascii?Q?CWQqPmtYLzRwfRnwXX2LcVf1pJpiGX2ramxcTTIJkj57avd2S6UHIp9iduAQ?=
 =?us-ascii?Q?wtiegMW3dvddsI3X66VOBx2j1a/DFGiWYpYnywYO+z1t0IwqTi29OprPLXsm?=
 =?us-ascii?Q?3QlrS1DNjNNlxxu0Q1VIQyNeWZlI64xxWtyQ4FhgsIMnepnA3s9Mk20oFROA?=
 =?us-ascii?Q?ExXnNXq8sMGkulqXsQ7m5z6jLHJ+Pjwpskt4Yd8FCBQuXjbqLPv8IqtTDSdu?=
 =?us-ascii?Q?xoC5FC5TWp1qI1cjSXRVbiLkGi7zun8pSDQh70UdjP/dQjoY6WmkeAJQE6Jz?=
 =?us-ascii?Q?OQZxurrlQOltlP7r+IKgTaeVeifcgnBA/dIGZxdpWD1J7lWL6OpG7j1RAC7w?=
 =?us-ascii?Q?kU5MDDWJT1KpKyZv4q4ScTVLSANpIHjXrjxTp/OxfMW9AHt0jbNsfEUEZ/s4?=
 =?us-ascii?Q?ahLKjQbzX9BI/+HRQ7mdsA5k7St5Kl0OyJ4U0RfdN0swxKBMYq6DXNXRXL9y?=
 =?us-ascii?Q?H1v/URQt6cf69K2GFq1qaBEGm0u4fSku4qybeNkHs+Nk9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1nfv0oKVQWvUMCWDpLUlUdbe8NR7C4fwCMaBpR2gbWhCj45bilWBDqxZ1q5n?=
 =?us-ascii?Q?8yTBNLSy3gXkXRCjrUk9Zh8Em0omWOneeKlp1secx8jMqOwD3E2iUx9Hb0wh?=
 =?us-ascii?Q?/78rG//Z0KuSeSIcRRCCRBFAMwlHscNS9BQRePu00zZpZ9Vg2W5PNLxFBCBW?=
 =?us-ascii?Q?/eq2YYj+H1XcW6a38BZLnW88CvrZVaIrhmjjIqiEJecr9vYWoRIFsz1TQumK?=
 =?us-ascii?Q?zZaH/EshWflevvj2X9Ncrfk02pPr1zhTtL83gk1reU4rKfQhFmXEYrT5btY3?=
 =?us-ascii?Q?BOciZ7b65hiFiWAwAozomeR12BrlwQBWQ8Q67OMp0MxcsdOS9c88n/+TABzj?=
 =?us-ascii?Q?zlq6JQoRocqnys+jay/iMq7o7Vj5/J1Tsu0s/W5yGdFRmv3L7YFKCPjFry6h?=
 =?us-ascii?Q?AnvOSu6y5atQ8TWoFon4AKN4v8kli8sPr0mNAQq7S7YdI3MkaGdeeAbIHxcR?=
 =?us-ascii?Q?muqIOcAFTGRrNmlvZa2QSGxVaj0aBVNnsxaG2cPsqbC2Suvz6vqmMowy/JsH?=
 =?us-ascii?Q?4+wC9hnD1bmzuMPRu1eXyIjH27DOzQK9tV1O/rHF/XqZE3ZWcrxbXLGk14p3?=
 =?us-ascii?Q?N8Cooqt1BMmvbJ3S/nqt5V39fSy0Yt7/ZNhDUFAVVuiDHLUxIo0IH+5SCNws?=
 =?us-ascii?Q?kBW3R0a/IWOWWHBdA2UkEJJebtcuuYT0SGGUqLBegOO4+VYuLjNuJCrh5V67?=
 =?us-ascii?Q?Gxg6KXqQpOzu/F1fCqOTUuoD6kcyOtz4PjSIn+OK2KKFfhGQUQFfbfZEWpbr?=
 =?us-ascii?Q?iwHmrTL11fAag+kUWVn0Kjhg1B2YlLHdeKyHk/uUXIOT8iQ7FjmDiCgWY0M9?=
 =?us-ascii?Q?McGOo1rrOOapxedIdv5W5rjx9Kq0HuAomuKicg+SYuqspr3BE7qHWBrutjjT?=
 =?us-ascii?Q?Q+KX0tsPMZKKkKTb7Tj4AJiSEg9Sg86LnFjWH1138XkOskeA6bC/yCPvf1U1?=
 =?us-ascii?Q?ktRGpD5X6HzW2J32xz9AtqxCun6ckb6MDH9AFSHLbUVsQHx6i8DQLBb4OODC?=
 =?us-ascii?Q?y49wffs2uI6AEUZnC1QeWRa1+TsXoc/CCXi2Y3TaEuHXeYy1uXSM9kW2ihP1?=
 =?us-ascii?Q?pRw72jI5Bup6y6uIQ/rIZvsaPk9lF68Sh3G1NCaX6cdN+85evr2VZEl8hLA1?=
 =?us-ascii?Q?Mph+49GprbunVXj/lI8ges6tEhEyp03dYoMx3BMGYp4wH5lnjG+gFIwY9jz9?=
 =?us-ascii?Q?ESIhDiBwR84JRqfoU90SBHuEu/7AOHbqG0uPYDMwK7HB9nm242YMhe9XWa/k?=
 =?us-ascii?Q?1j2qUIPV0VsPEOGlzHhOq9t7XSU6TPnqRx4FazAjdFnQ/F+R1Rfy1Pf5jEIw?=
 =?us-ascii?Q?UjpG4JJkQAGlyYsdHlRVnMGT1qAbqxF+WmPlrrjYd4BVUE5wKHR/c7PqdEjX?=
 =?us-ascii?Q?qAWE6MI0aaalAq+k3hSbkP7Pfb9eC36yI0HsblCK7Coqwu0E/z+gYzEw0QSf?=
 =?us-ascii?Q?t+I01i4vjzkdVovlXk4tp8pi3+QFxOusPj5Rd9j+yn+7sc8Dyh/V5dPDm/Pe?=
 =?us-ascii?Q?nQ+D7dQGzvsFUSL5LrqR6OlXh+z31IZbxqwUZWwyb1DX6cmVrmqZsgeDq7HG?=
 =?us-ascii?Q?xo3Q+JY1RR2FMG3RK0arJDe03DIpvdS7Ucl1HgkO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z3MxgmiUuHRs49H8FTUjl/yotu4DwnQzAk21HIp70D5zrQW1x3BwULtRfxXPtuP2YBVhEVDNkr1jdjX3VPAMRbUDvtDJBZb6EQiMb6rRy6i7C2BU31+LidXGL6VtcQ50X3kbnBu3Nil14fnKgPlLzEMc4d/DPIFqcrCbjedENX0bHpXekfxZFoQ+JutpWOEKxPRyoCgkwuH0qCZwm9wosezYJco9JXvumeJOVu6aQ9x91AQBRBtjnq5jj/HEtU20UlVaABwPYZFvK30VKr8fOsO0kNp0pOVxxYakGVLNHlXfEMbC/DhY6uInheCFYPpmA0+c89Fz3H7spcgp7mclD3TFNafMoH1D+kOtQrRudqOOGbB0DMftWfj+2ZnHnq5iWP4eRlR2BlTyJLiE3RaKLHNioH/eOMD8G8CPNzpc4DoeZ+RhbO5CmVYK7KJoOFMGHM3HgbPzQA+DpL4zqaXHdIKGPdf20eRvUfQou22hhKeEc3yoj57fGzRD1+WayugS9U+Z0seWxm0swey7XSzwn87WBXBfKXg9+1SdyZL3LFRF3bEi4733pttFEK3c3x6R/jkW31Dzj9wxdNBE8/7BSoM5qFyQeGTPcxMjOLBKOlI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c802ef-72fd-4461-2df8-08dcc381dee8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:42:53.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22ACa8Dam9JDRGHE3YTTW9raLv0L7VHnMTIgDJNT26PrdmBq4DQjvWdGaZvtEEZf+ToiZpv91KwTvDSaeLL2WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408230108
X-Proofpoint-ORIG-GUID: PyQtgXqFtlevbIYn3yJGmKlOJ57aMJzN
X-Proofpoint-GUID: PyQtgXqFtlevbIYn3yJGmKlOJ57aMJzN

On Fri, Aug 23, 2024 at 10:14:01AM -0400, Olga Kornievskaia wrote:
> states_show() relied on sc_type field to be of valid type
> before calling into a subfunction to show content of a
> particular stateid. But from commit 3f29cc82a84c we
> split the validity of the stateid into sc_status and no longer
> changed sc_type to 0 while unhashing the stateid. This
> resulted in kernel oopsing as something like
> nfs4_show_open() would derefence sc_file which was NULL.
> 
> To reproduce: mount the server with 4.0, read and close
> a file and then on the server cat /proc/fs/nfsd/clients/2/states
> 
> [  513.590804] Call trace:
> [  513.590925]  _raw_spin_lock+0xcc/0x160
> [  513.591119]  nfs4_show_open+0x78/0x2c0 [nfsd]
> [  513.591412]  states_show+0x44c/0x488 [nfsd]
> [  513.591681]  seq_read_iter+0x5d8/0x760
> [  513.591896]  seq_read+0x188/0x208
> [  513.592075]  vfs_read+0x148/0x470
> [  513.592241]  ksys_read+0xcc/0x178
> 
> Fixes: 3f29cc82a84c ("nfsd: split sc_status out of sc_type")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c3def49074a4..8351724b8a43 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2907,6 +2907,9 @@ static int states_show(struct seq_file *s, void *v)
>  {
>  	struct nfs4_stid *st = v;
>  
> +	if (!st->sc_file)
> +		return 0;
> +
>  	switch (st->sc_type) {
>  	case SC_TYPE_OPEN:
>  		return nfs4_show_open(s, st);
> -- 
> 2.43.5
> 

I'll wait for Neil/Jeff's Reviewed-by, but the root cause analysis
seems plausible to me, and I'll plan to apply it for v6.11-rc.

Btw, I noticed this at the tail of states_show():

	/* XXX: copy stateids? */

I'm not really sure, but those won't ever have an sc_file, will
they? Are COPY callback stateids something we want the server to
display in this code? Just musing aloud: maybe the NULL sc_file
check wants to be moved into the show helpers.

-- 
Chuck Lever

