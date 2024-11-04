Return-Path: <linux-nfs+bounces-7654-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7719BBB26
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 18:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F091C20A02
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 17:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48C71C4A18;
	Mon,  4 Nov 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dDqtlL2e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YoEeyfip"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE023762EB
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740219; cv=fail; b=oNaz+6pAgeYiaK3jzkOwRI9QI5e/+DfJWT7pf8pmFbBOd0a6YyazoqdZHCwO4YFH8LUsaFsJkCUHRlFy9SrsreRn0q/JrtGyHGxIxkvfw9bBO62n7gqmu7QcOD2Ao6NafD8MH+T1T52HRNioG+t+70HalJ7WdSBtbt6AuMWh/PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740219; c=relaxed/simple;
	bh=6lPmIQ89/Z9XUJ6V2BmaWSKgqvSvqBp9KFPW2YVsGAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VxgFoNU57bjpjhXx5/EUphXQsy3dGiP0cj0EB0qd0CyJ6yh8yKSWJMsMtD0TJOX0Yn199QUsKsWuoITT13YJcZ1bVOlTnCrIf2ndoCR7ZtcMkJHIi78TdjR5o/2zl+MqoxIZuXkdwHkWzwC9ZlQO9F+yq4XmrEYIGL0o24oz/rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dDqtlL2e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YoEeyfip; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GMb5D007265;
	Mon, 4 Nov 2024 17:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ur2OScIUXLtI9nXbx1
	PU1JoAN3EpnNBb3Cwt7dXB4gg=; b=dDqtlL2eYUOORgLm4Cdgc0izbb+T4AqHjr
	h7UAx7S+U7i5hRYCC1vyHB4J2LFeDf44NfXZLi9H0jTtJ/laejtTpclMs07EIKAh
	wVsYpv1uVddEc7gGGokCfCGR33pP7Ie6xJsCVyYsQ1OzajdTaaghENNyNqNJxiLD
	vIDDPOVze8S1aO50qYDH2mwXGkF2H7Qq7Ec6plspz0QXoMPqSlzqJXPX47W4LRKo
	MWg6DWm/DJpArYpGAAepsikV0FqifTDHSyN5gvFxX7M3PmBAvIc4lRV7aUVviEeM
	S7pICVpNEFPnT6J5Qw+8ZHXZfEXpg/3wnnlnFF72VTX7hOryu+Vw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmt392c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 17:10:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Gg2NA004960;
	Mon, 4 Nov 2024 17:10:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p879f1ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 17:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCcla2pk8QeBPKcJvpDreHW+/oWVjcD1TwnDWo7llc2lFi92OlxQxr/2NfulujsSUthgzD7D8kdezwlthKbuDXn0FezWgueGb19LNsHhqbM7pd4mjnTc80/MmEDABj9K10Y3ZHvqAEAPlSzRYUZ4XMNElAOp0A1z70uFZjPu6CAqhnztvD8+/VCVg/0y/x1K03Plv+tvBkb1xjskEch2VdktrPzOVYMGfIyBYOuG5kPw41gnNcDdPGhBXpruwqR44MQm20PKliGTlsn3NnTYhK/7BoxmK9tS8Zo5EHeeE2l4DvKkf4nQ6YK8sKYrXBmD/5Fkhvj4S/4I8n30FVOGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur2OScIUXLtI9nXbx1PU1JoAN3EpnNBb3Cwt7dXB4gg=;
 b=BzRWhn13gfeN5ZtIpjdxIkAXhBu8aqhBnhr6wfWNHOb04P6w8kdO+PgJy/RVjhmqDikIQsUcAJ2kDRt9kW9xDAkeYXi+EWuDwUufqKkDWRqy7pOjNPPa+Qa4NWFHWetdeAlqF8bDpxaDRzwiLbpikEgU7vS1cLbhaLdjnTOsqlt+yCsXmxOtgzlZLE3r+QDCFFLR6ZIVML5xALN9VE4lbI4qHmoUiXDFgLrtEC95e+Vntx7BX+pm04uG2k3SoskzzEg+dSA7PFM2QActYxVA2Cdulhsa6CVQcnE2hHLe2Ou8zAhKLX2SbSauhMC5MM8+ecx7LYQrJWnxN9T+mXj04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur2OScIUXLtI9nXbx1PU1JoAN3EpnNBb3Cwt7dXB4gg=;
 b=YoEeyfipqqMZOfWqjr9HN10TQOzCT3CCPp/a0bdNpgzMVLlZXgTVniFnJRuUi2JgvWEenajDfpJJpsz1y8Uyg0WWvo3WxIv0OHuNYd3sLvyVd0XTEBIPoF52HONFpq0+13mmS/fLpDbOwITMUi65vxIi1R/4SpcS0Z+VLUvCvCY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4167.namprd10.prod.outlook.com (2603:10b6:610:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 17:10:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 17:10:04 +0000
Date: Mon, 4 Nov 2024 12:10:01 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
Message-ID: <Zyj/6fF11NKHIvas@tissot.1015granger.net>
References: <173069566284.81717.2360317209010090007@noble.neil.brown.name>
 <f4d2c708aafac0174f6f7da22ceccac72bf93119.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4d2c708aafac0174f6f7da22ceccac72bf93119.camel@kernel.org>
X-ClientProxiedBy: CH2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:610:60::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c25254d-5e00-44ff-aabc-08dcfcf38655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Q1Mf/ECWVmYNrZhoe8GKyefsOgDaUrrn9esPc1jDh+sdJUeEXR723pRMdS6?=
 =?us-ascii?Q?rQ0F7kGzdNOLeW8ezsm6Mr7AjxtsBw0rmO6DJ2uCrBVDZ/6LgEUfczcLehYS?=
 =?us-ascii?Q?lhzyomTSRWtNzaKjUxXA3vBsKyHObiudipodk6ku8nuOUfxy32p6o5VRO/Lo?=
 =?us-ascii?Q?weV5QRcasHFZoQ0wqp3At9gt7h9AMc83zEKi2CAksJr5gjv2Z0HeiESIFp8L?=
 =?us-ascii?Q?jOLh7dbeY8zzUpHjOtn+6hQkw6NzTc1CT5Kn05Stb9Pe4fjmf+iY5Eky/Evo?=
 =?us-ascii?Q?9XtANGUMt17cSY9MaBRsxDUp4i3GSsL9t4GGgdSRT5AcCY1S3HkToj270Kua?=
 =?us-ascii?Q?Lp8L1uvrY8OSEXjqpltqSWwtOS3lMNPBI3QPizCDMdhvQWAsszEw2yU5F9vs?=
 =?us-ascii?Q?hqsMX0k5D0XVzURRzpmfH6+vPnUG3QLCvV2chPMGzwX7mOZspMPzojOYysDY?=
 =?us-ascii?Q?8Cv9LryMZkFla3/6dwGRyXNZ38f/zcVjK+D6JJvRvVz0SGoKQYz0vwsXv7fX?=
 =?us-ascii?Q?7E1fwsQX7F6LbKn2+x4NSLhgmImvWSXC7oJNADDsSVCm9gpdCbxTx7aZnAnJ?=
 =?us-ascii?Q?pGY77lgWGWgs1Cg2LuMF4qYqz3tORU3Ig815ltr8xMAZYBC+nZ9iIngV3B3d?=
 =?us-ascii?Q?fGQbBq0+upAlugYOB42CBxc4dRgnVRCj40+F6ZLtciHc0h8XEcpL4fChGxst?=
 =?us-ascii?Q?TEN3/SowbjcIgM2sIitc48dS4wtviGxI1WDgEI6nBD8AAMJiHgoQRBC8F/XS?=
 =?us-ascii?Q?GkHGzs3AXkvO3BpFmw6Pk4N7J5E6rTN8VWIcsCRQhM6NAu3pR0PHAHBQCH1a?=
 =?us-ascii?Q?orHI2immK7bItuX9Yl1L6cGxZNtwUvXsihdILBkmZkqC3NUQ5udGK59oE01w?=
 =?us-ascii?Q?Ns+7t4j2ANanzhC9NLR/h8YWQxMJ/+2AXOf+5xOmqYkbUVSoBbh1L7/sLx1q?=
 =?us-ascii?Q?lMm9hM6TVZNNRNMam5COpN21LbGVAphLndNFdQrYfylwX9HLeXi4ZIBAkLti?=
 =?us-ascii?Q?UkW7Qg6Nsqbo/bUQRJc+G99Bzp+HMYOQfxjb1sfhADNqsH7mWBoG2Y+FlDfQ?=
 =?us-ascii?Q?/pRYJ5HotUeVSCRRMg8uVZ3ZP/eAp3al9J1osHbgaLxKZrFHPiow1d61FBMI?=
 =?us-ascii?Q?Il3D3n5CgiSZiarixwuDlWquZ+2eVaE1qRb3mmtv6fTTUbYKadkyIkijkNVK?=
 =?us-ascii?Q?ALCm/JWh+T6ZbNhadiKT0G6UNkqBPJ2xcFtA5fhtMZ8lFAY8tKHZwUbxtLDK?=
 =?us-ascii?Q?hDJXQiZJjg1n/xHzdx3HXDx3afIvr7a5Ak0/cgaQb3MCvOZf38oBeat+x2Vp?=
 =?us-ascii?Q?2Gz4ULtHiGG+RGH37F3UI97w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOBBwnf24Q8p2L5XZNvuZTHagm354GaccaNK1KbbwPrs+v+9fyCo7vXlBIG+?=
 =?us-ascii?Q?jNbyihBXPma5MKg7f5z2WRaWOjZgB0uGO5v87v9Gg4Cnj7HPLY523xhAx1Ks?=
 =?us-ascii?Q?nb6gC5unOS4hvH6J5d5brz08woFcrzJDOOP/NsjykvceYEKscN/EE/9YaqEz?=
 =?us-ascii?Q?p2q86msLXwv7ALV12G+cwINP/qpBih+F2q3aR1bEDC+Gjp69XyQU2YGYpRca?=
 =?us-ascii?Q?5RLMH6MwAWoq/X7+GtMt75stCee8gyhxGVWM8WmtWw47Wkp9buNJCskxx4//?=
 =?us-ascii?Q?1ncqY55If18zRfcbRbz0STLlAuKiuzBiNE9KRMzCsFUOniCsJZpSxWmf1B2O?=
 =?us-ascii?Q?+1SEyXgOTdQOn5LdLQy59X05JFRWKRyE1yMykT50dw3nq8IF3OZaGKMaykae?=
 =?us-ascii?Q?AAoJFFF2+3nfjjLN9IRCVEu0iNqhTdniSftUZBKUOQPSJPY47Gj5YjX9hMuu?=
 =?us-ascii?Q?Y32XZX/qp/g3tU1kYLTqtGdjt6ZDOher8jamU7ph3jzZ/DLI192W0jBQzKy5?=
 =?us-ascii?Q?+xmfMXoPpwbx2d9aruUjgKm+5adnB4i8cOMUydoxdSsdVC/yV3Dfxmr9aPn+?=
 =?us-ascii?Q?8NSFNxju0FTooBONZ5NjiE9h+lG25I68BLW8nQZUACBJj3y/QVP38FFxj76I?=
 =?us-ascii?Q?9xRC7oHIoi0k1y2PKnBOlRxCbfehO1EL1GqcairBycZ6BFaFpZicEh1NoIkA?=
 =?us-ascii?Q?PBPjSiZZpG84DogfHRJ2nS+xoKQ8UhEmIXKW1nf+ICAeg9CVb1j+v+1ec04x?=
 =?us-ascii?Q?3YFIeRChhIN0NhLl5ykB+137t/tdUAZ/m98ygwDfOpYDNRaCWD3C4JLuKqf6?=
 =?us-ascii?Q?n2ZNvl5Fm75ht6IRbzjQqpKQTP6DV8oJa7wBCSjlM+64FlIdRgROlUEeZszc?=
 =?us-ascii?Q?AF18vTO34mXceBN9cLIukSc5itfi8Tp7LcPADjSivaJtYBST3SozLxptbjfZ?=
 =?us-ascii?Q?qf4Tl0sftyis2r30tPOeHZ/kChQX6peLrdDGKe+G7Ea5/XuPrI7+8YQyKE2C?=
 =?us-ascii?Q?LRd5D2MrvRyqwL0XJ7FW13IfxNf9hG2Rxw3o2PTm+HTfW8S60WZPWzp9iEP3?=
 =?us-ascii?Q?as5Y3/S5IvpU1jnvtALJ1RmmlxRxQYSPPyo5CxkVPHGt5k2x24e2ObYFH4YT?=
 =?us-ascii?Q?XHbRDSAtkTBwp2Cs5PMg8H1q2A//JMS89P+PCvry7V56n9rG3b+X1yueyVSS?=
 =?us-ascii?Q?WpHfojp2fu3kQqqva08HFd62u96kpIdiUWCz6hMy1+slXl9i/FIFlBiTl4Kp?=
 =?us-ascii?Q?UCeb2TCLTnjTtVd6q1umR15rv2BQgpsAUVnAHdP5VYsFxdza4clMnSP+xrvQ?=
 =?us-ascii?Q?i3TW2FNl11fCDzUpaoqPP1QWipLvHiXYSxbmrmuYnHUZ67bk82F6OyWMeAzl?=
 =?us-ascii?Q?L5G3jDcdhtuJcjKb+p55byebRpmEEi6/38S+ECk4jc7zqsGqwV68naR8VByQ?=
 =?us-ascii?Q?61tX4GimXicvehELro8kGjhyZz5E198TIqtbGwlAazy2lJ2CaMXFXk5ZrcH9?=
 =?us-ascii?Q?75Y28Je4M3R2CLsZab4oChVZXK35T87VVNBzo1HywQwvxH+p89sLzDlcgYKI?=
 =?us-ascii?Q?vM23wx+3h5S3zVLvIEigb0S39fGYCpo0dS4GfYtb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EbsNrc5YlGxL8Z78DXXgJ4448E+F1RtajEw/NmUAdrxBzB7hJE9/eXCHPUxFoj1tlQbFSxsSa8huRE36NpWPTXSANuMPjdMVT5WTGhTcFmYrNNhDKG92fzx9Ztujqg1tRy9Er518t/s036cyDT5jq1NBg2nL52nZPwAzBWJmW5vzxEjqiIWtNsvzTGZb4M5iV60Dvk+yKEFbruucEjXQtPpMkmkuQ2sVYAuH7enfSJvU5lidnKd72orQBG+P39TX7tPH3wowXHfxLNYrHqOlV6UXFum0OexXglKBSO4EOgKRf9dMC8SSllRLLo+FI47fuLejgx2DHY5GPZ/oG31WXjqu5aFUI0ym6eDqbNQNOVelzEgY/3WtFAeV2/OnfUa6sqQ4PbHkU85ptkN8HZe2okcvknmVZkuzPvHKUT21VBpjMUBH4FOKlMquSkHU88pMg0tR2qdDf4gIx7q23hwsD7kRvPBUDZEjSlJ18bc/dQ+y6Zco0xsqLWZ2UG/QgX4vLx+5WdiexMyLNLT6O4ZMHVQEh19DfJ+mUq+cS0aaNkQAkKFEeStRlkuiFuKn8QkA1017hv+SblaACmjUsyZ6B8Rad11ZdR2caHQ3TQdKUwc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c25254d-5e00-44ff-aabc-08dcfcf38655
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:10:04.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pem9OxIprAAhBZ1Qa2DdRtM+tCNXj77LTX3mdKLKkHUCrB8JALILNtmyt1L/vu0R9KCAVqmWrxYVSd7hJtf8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_15,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411040143
X-Proofpoint-GUID: wlwYkd3jPwQxHdf02KRLQJSZCAmNU2nD
X-Proofpoint-ORIG-GUID: wlwYkd3jPwQxHdf02KRLQJSZCAmNU2nD

On Mon, Nov 04, 2024 at 08:05:27AM -0500, Jeff Layton wrote:
> On Mon, 2024-11-04 at 15:47 +1100, NeilBrown wrote:
> > An NFSv4.2 COPY request can explicitly request a synchronous copy.  If
> > that is not requested then the server is free to perform the copy
> > synchronously or asynchronously.
> > 
> > In the Linux implementation an async copy requires more resources than a
> > sync copy.  If nfsd cannot allocate these resources, the best response
> > is to simply perform the copy (or the first 4MB of it) synchronously.
> > 
> 
> Where does the copy get clamped at 4MB?

fs/nfsd/vfs.c: nfsd_copy_file_range()


> > This choice may be debatable if the unavailable resource was due to
> > memory allocation failure - when memalloc fails it might be best to
> > simply give up as the server is clearly under load.  However in the case
> > that policy prevents another kthread being created there is no benefit
> > and much cost is failing with NFS4ERR_DELAY.  In that case it seems
> > reasonable to avoid that error in all circumstances.
> > 
> > So change the out_err case to retry as a sync copy.
> > 
> > Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operations")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4proc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index fea171ffed62..06e0d9153ca9 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1972,6 +1972,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  		wake_up_process(async_copy->copy_task);
> >  		status = nfs_ok;
> >  	} else {
> > +	retry_sync:
> >  		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >  				       copy->nf_dst->nf_file, true);
> >  	}
> > @@ -1990,8 +1991,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	}
> >  	if (async_copy)
> >  		cleanup_async_copy(async_copy);
> > -	status = nfserr_jukebox;
> > -	goto out;
> > +	goto retry_sync;
> >  }
> >  
> >  static struct nfsd4_copy *
> > 
> > base-commit: 26e6e693936986309c01e8bb80e318d63fda4a44
> 
> 
> You're probably right that attempting to do this synchronously is
> probably best. That should avoid another RPC, though at the cost of
> having to shovel the data into the pagecache.
> 
> If memory is very tight, I suppose the synchronous copy might also fail
> with NFS4ERR_DELAY, in which case we're no worse off.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

