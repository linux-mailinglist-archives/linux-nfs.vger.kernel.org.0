Return-Path: <linux-nfs+bounces-8043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFFC9D1899
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 19:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E6F1F259D2
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD611E1028;
	Mon, 18 Nov 2024 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AjadEJeg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fk5o9+db"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A681494B0
	for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2024 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956255; cv=fail; b=iDQ+1dpqREafOC7wiuTHZ0gPtnQJ+H4i30nonIKhG+SjckRbqutVclJNDuau1u+gVg/AgL3rHSkKdtG6kK2IN06cHOIzPfFBlC43EjNFt1FPDbeZPI0kKxbxWgbFhqcTR4xvL16DEBKp+vvfqlVpShvEijblqfaM3dMGTAzpKmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956255; c=relaxed/simple;
	bh=/A8Rc1G2IHRAcmdVAkWzKbMrLBZRYFzlmyC0bWGux1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qbxjbYd/AzvIaCIITeoC+JfEL6PKtFAx72NJMLj7Tbkr2CmhLdOJArmcl2FiO7Ut7BbszY7NmNJ00adxqPPcnfIfYOC8zPdEOI9Oz4hz4KsOytwkRNRz2vhc4DAkQj6uuj/WmK4OzjB2RiDDPUfzWUIcmZF4K3QSK3GiaHbUn6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AjadEJeg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fk5o9+db; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGOOPJ029782;
	Mon, 18 Nov 2024 18:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=29xRcHG3G8oBeABpT8
	ehs0MgVmYBJO9x1QNPxMwfSP0=; b=AjadEJegp0u4O2xXJQaUrWvn7hNTHgAoc9
	PbA49cC4FNanMnhYB/ccAC3F8Rx7Pxn2dDHBzEhyscDqInWKvMj6jJVeXbd9uwjK
	BIJD2jggsVX1n1/RYbg1saGmoQy/n8KIe4dCVYLJEuWNmjj5twtxcUrHwU9IglLQ
	gnFtuNKLWki6+1leqF0pHkCtL+dT9TqPUXj0nbcgQZvt1z1g3jEF9ZNpAsFEgLjI
	nV5PDE4boMA+G/1j6HWRVjrPZxtxodiYsntmhQmFnk6EXCnGHEs1DcW6JYi9n2Xt
	rVS9fYdqsGMbRKCoWTxbBE4s0hfmC4OiX6oaU+/JQ7/kCpHLAVNA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkxsuanm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 18:57:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIHugMg023114;
	Mon, 18 Nov 2024 18:57:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7uqa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 18:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFRC5iw6hVQjejBZH2joDYTGSch4TUBR7ks8jKscVEaKPIKBRBsBEUt//gj0TXk+ZLMUbuvU8P3HgqL3PoriaIEscojUTmcbHsyVYMKMdYqL+/hy8QbB+7YLQKL3vYIzXv+kuh2bOD+97KgVhPPs9yvYcO87kAdWHKsOgkS0WNq3WMTB2mjpp/7fZGJxthxc8LtGpPDhb7uBqf0GLqtjKMMCaKl712vbLKGUhN7hblT+gnoad9Gp7w4M04A+b6f7gBEtAthYbA/qVjbtkFYK+/tQausIdcI1B/T7mPEUsWhDlpAmVJKLKVvg2gan0pPjERmNaXWTOc7s6+M6n0c+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29xRcHG3G8oBeABpT8ehs0MgVmYBJO9x1QNPxMwfSP0=;
 b=HROv2pgl3fqAMYvARkjCzOF8pA/Umr6l7aOT8H7FBsC0051rwd+AMaDwEV3vdKL0OkvGs8Fk/3xmd1srZbf+l5JqfI7VkodcGusX5pLKRONOxA9kMYUK0d02n0jvtokpLprNVQFMRy93lGDAEuwoy/EEQnyg2mXqgOM2l2FzRKA4rx9cOKmOOHxT3HLpCaY4X4lQdeXZYIqhg2qBSJPP239d+iaG8GRdtjHtEV2ugBkQgXuN/euYO4L4MdHiVZjGCw+uyCWsgpAq1OveKdTE8haLfBSi8FIk562EI7yHJTwD7fDP1ChkX8FMk3uMkJZTU2uyig2RoOhlpzaXyEUv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29xRcHG3G8oBeABpT8ehs0MgVmYBJO9x1QNPxMwfSP0=;
 b=Fk5o9+db53jJaA4gNFD1vy8yFxrhlM3hUQHbjQNhnlYABQkeXTzxYcpER5OYoAY9HuuPkGQMNgZaA3pTBmyCrDXCtJkKJB+HF9nYcIS3ZEkYc0F71Ra47Erq7vrrSH0+cKfhUHvedgxEbc4HDN8yVtZtPWfzaOA5ozmD58wuWlQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6912.namprd10.prod.outlook.com (2603:10b6:8:100::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Mon, 18 Nov
 2024 18:57:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 18:57:25 +0000
Date: Mon, 18 Nov 2024 13:57:22 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Message-ID: <ZzuOEt/JjwmROMBb@tissot.1015granger.net>
References: <20241023152940.63479-1-snitzer@kernel.org>
 <20241023155846.63621-1-snitzer@kernel.org>
 <ZyOe66m0BbAOWOyI@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyOe66m0BbAOWOyI@tissot.1015granger.net>
X-ClientProxiedBy: CH2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:610:5a::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1df848-5918-497c-1d40-08dd0802d73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFPGiCNfi1l/W0wcvFJSnFLdAO5Hk6WeKfwtx2qrR+8t7SuunIoaiqA1e4Fh?=
 =?us-ascii?Q?Lt1teQXhyXvw636O01g0ulxF9iFb+zdEgpbzf6aKQdHRPNdgWGVvycEMch2+?=
 =?us-ascii?Q?tjMuXKAVRDLPOy4fQ1VzNPy1jcYMi9knjTBXceA5buP+HDYohDPvk464M0o/?=
 =?us-ascii?Q?wWHirMsfiH9GtWXy+Gxm3SMidxUK8szIJ5V/2+bpeE0N0wl74jB08zNyggD4?=
 =?us-ascii?Q?1AFbVQwuYffHf4iSl15oGfh4NWCJjtDv81Za1sFQ8DZE65wIqgxn0ceZFZwD?=
 =?us-ascii?Q?9QGJ0RaFDd4ZMGm1FcwXHqUdGryTTXiWHe8dxYPLv0qY5AkZmp9Tdzhb9Guh?=
 =?us-ascii?Q?tZD6KipywATnqcxrtNMcS9o5sU/zXJU0txco26eJREgLsnaPoBGZVmD3kCTG?=
 =?us-ascii?Q?baILjK83/APev3y7FjEM31ZgTsQkoE+I1WUVcFTt6wNfiOb7i72EYVz77TtG?=
 =?us-ascii?Q?BsBf84UD/j7NHBeQU8LwRYIX6/rzqJNJCDQLbC+hRtGOkIqJIk80VAZbenP8?=
 =?us-ascii?Q?PImg66MUHsL3bd5M0auBJdR8M3xhwWFr3aNrqzjNIklOCMUU2ZdfSTX3gs2n?=
 =?us-ascii?Q?5pnB8dggBuAfQ+dR0ak50vxH/h8dWez+Oq65o6PG+CRE8nNleyMF2WZI7x1p?=
 =?us-ascii?Q?ETmYrf+bZkDnVNjFDrQx+92iFqpuG+l4S9suKU7MZja9fq7W9B4/K03kSYH8?=
 =?us-ascii?Q?O0XRTfli76zPhowBVrXoKV6ZvRXCVT4uJutf3mtj4QxAAyJjznXIametSTK3?=
 =?us-ascii?Q?E8znTLQA5Sz8jnejoL6SZN589mkbqkl65ru4FeClN1Fnf8P8jhoS7zoT4CNm?=
 =?us-ascii?Q?ifSzO5CzlfyJHEC+VkrRgjuz8p9oeFp/yVKXccd3/lp2mi8tQtp4PlSs5Ydu?=
 =?us-ascii?Q?K8Fs/ArUP4p1tqhVWTEDKWGQOHa+UTvRGSQFcdbXNV7waFuC7HyEmBu0j7M8?=
 =?us-ascii?Q?OBQ2+iE9gbWCSEgGEltLCDzZhA9omjmeRYsahEJOHyPKVzMNRJuJIBg8B4VG?=
 =?us-ascii?Q?gKgZuYlVFcpMQ95WO6d1nlbnW+xJR80o9AXV9T+JsF71/BzsqNHRxYw8HJKM?=
 =?us-ascii?Q?7hQBooF+gvg1uMCHkD9qtmjhcxAf9YsUUQx0LQe4OAvuVzvZi/uk5q96zgWs?=
 =?us-ascii?Q?0SfQQ8Nhme4YXxYllDv+aErXBd/GNXHffHqQbPzCAhmF/cUe5yRbW/l3ngq6?=
 =?us-ascii?Q?luV1jIdl1daznn/dSz8jq7Qv9VdS64RKZ20t9MAW8zHoD4uNIBZEBoN39Jh9?=
 =?us-ascii?Q?Y97A3OvBrGqJYdZazWZD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yHiuXFyG2igYLJTbZpm3K3o13b8Wg19BcZmqEMl0+kI3kN9I1LdQKn1lMasR?=
 =?us-ascii?Q?rT5iFUT78XY9VBfAXX+qgEyPWQe9ODxFhjgK/9Gi8Sp9U2jX+5Lov4o2TuoH?=
 =?us-ascii?Q?jQ/Beb8ll4Gza1+RtwQoM+gkOc6hxDnloNHdySww6sZtn29zzA36U4KwhIpY?=
 =?us-ascii?Q?awxloZXhcQMLSD9tqQ9AoY6iJR3lnPM7J+c/Z+/8tT13g710O+2uMuNeEWQc?=
 =?us-ascii?Q?sJgSZ2AoUlNXfgrPPsl+ShYLQq7OktB5iFYdfccECfNXFfyLoj1RXwrQhxPi?=
 =?us-ascii?Q?jb3/y13nbWMXaG57UpQLUSj1IUwrzgIwMS6n71TJ8TBgiNLRUDdplVtv08Xh?=
 =?us-ascii?Q?TLngxH8pAM1QZ+EJASShN9T5NFSjqoVeX61DgkiGUJ1qUTPGK1w1khWha5zl?=
 =?us-ascii?Q?IezXkV8A0SGEihyR9tsHo/ugrQV/5vT/kobjdGvXMcUuayz/udU6JpZZWMtR?=
 =?us-ascii?Q?VjX0Q63wfntchBZ+NU0KD6iVgbGDgp1Hjn3/xc02Y4vulrqhykqyXKt8wRse?=
 =?us-ascii?Q?ft+7+QmPZgm8NS0pDS/Zj8wx5x5t2pFS1Tyr9ZhfmVz1HGPA0BxwPzBI8I6B?=
 =?us-ascii?Q?NpRK2WsuxJ6o2S8iCQFTMDkS15kHd/4JEGcjYTGnQ7MLZDULyR8RWUd3OHKG?=
 =?us-ascii?Q?3fffi7kBzOF9CtPViu8+65giBjWqlAt3an0L0uQa2b6mDPSiT94MVdqvTbEk?=
 =?us-ascii?Q?NaZQjEZCAnA+Tv2MoTHwudYghTiy/y4xZ6iDO9v+OprwAhggmsS8jPPhPIR/?=
 =?us-ascii?Q?fXZsfO6pZviAZapjFfeOs+bCCYWpjb3JPQefkwBsfFa4kO+fonYqC6BgtI0A?=
 =?us-ascii?Q?RM9hp4krPiwOhid90/nhPYx09ZgcTqSLYEycv2v3WqXxCpsohb0tSRUxmHdo?=
 =?us-ascii?Q?EX8JjspQnVo8BaNIk1X9wp1H3hF1KsN3sihEhjjOrNrnH+udx2QxP5Mj0mcw?=
 =?us-ascii?Q?eEvUARbPHyl8/t/BvsSvoxWUaAGLZ5+JPlj2r+S12bmDStLM8CNKHGUvYYrH?=
 =?us-ascii?Q?WpPyJRRPbkpmKtlCRnUnQ/fUTjgUB22+COg9upRJJ2zbU+7jufz1wHfap/Eb?=
 =?us-ascii?Q?80/uK2iZsFY9yBGAnaoqTnKgRCmKf80DnccVgW2ThM7DlBg7Rmej6yE/U5Dd?=
 =?us-ascii?Q?eLnvIr0vA5sfOCrbya95SlfscYptmiCg9sAVnKHi5Po2zQo3pNst1o70TMfr?=
 =?us-ascii?Q?M5X9QkggxN2R6VrsatqLVM5I/uS+eXjJ/PUHq5xTwILGN1S0jZ8cWCQToQJh?=
 =?us-ascii?Q?+Vj1DqneQ24MjN1xzXp0oRa0Pwg7wZl07EJtr80QkxdgLyaY0/nt5f7VkKF6?=
 =?us-ascii?Q?GSawRoJ6l00Hu6pWF/KnOA3QyVPDGJ7xEoqQjts2SpXtP8EXiYVZ/n33EaUF?=
 =?us-ascii?Q?yVeMYRH7CdXfcgcaJVVcWppmuJ88M16ENodYelscQd6/prBHtHph3w6KT2av?=
 =?us-ascii?Q?r49b9zQLI/P3xx1BNqvTEbfIRV2T59x3NhmfvriKzFO/bQHsFaaUiOrCcDUZ?=
 =?us-ascii?Q?cjV+I3bQQZ9JnIvH2HgFACHQpIIj6LUAS5/+zSKmsXnzV1Rjq8RDW09rvw+7?=
 =?us-ascii?Q?HL4W0aMd1EHvONPZ8Zq9BaQTZZ/1yC4uc9cfYeAT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IGKG9A7/1qpb4sCiovZ9OulXssHfHJYNTUXHhGK3YGEq5Lf70tq5PGgRqdEFuP98HnWGYZdLCzay5LGsebdj63cdt3ExViIJU9frDCRe7l49WBsVZQVB9JGEhr3Wxz7mem92ZGZIO0n7/M+jRfu6qRKgUbgzJLZK/w/xsJ3eHjM0iM9AJnSDPM/hZUZQ+Po+upUcoWpelXy8aKIYFgCtsHKBnidnOX6eLG/UW9Sfp/EDOiCjHRjJuRpKDt68meGvwFMRjX/adCg2ZiYZGE8JTVaJMZFkeHwcAg1SV9fk6n6Bw6tSrPoXFu5VXOVgm/QDm2k3Rf/gRuWZ0sXSctbLTWpnORhkHX2LmUIdRr40mE7BWQC32hwJx44W9TeOIoDDRzvFjynoAKm7sRdJTBBROUuNMimLOhF+K1fwqpUQcqn1ZhOZZfdrIwk2wRThyab7PFkqeAinRX6sm/IDGK9hOD7aZ361ZU4cZbEaYqQ71FfO2tucvGEbayRLYVudOreoUACHwZYwhAOyHa8TPnQBf3nuAQ+e5n7fEtmeyUqWBg4PdM0ktCY9XJLYbur3JuCyuLl3SBMTFUim9NM4BPU8YIH/xI/lW00Nu9oepYmwJQ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1df848-5918-497c-1d40-08dd0802d73d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 18:57:25.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5qkzyBtHPMugl5a07BJqZqqNXzMkJcU+uzjAEAsMkH1/JPBmLYJWDnQy0xDUuDPfTgIzzFZjRFCCvHNAK1+dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_15,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180156
X-Proofpoint-GUID: kI864LeZ7aE056CHjaKSPdhgbyvY_TcJ
X-Proofpoint-ORIG-GUID: kI864LeZ7aE056CHjaKSPdhgbyvY_TcJ

On Thu, Oct 31, 2024 at 11:14:51AM -0400, Chuck Lever wrote:
> On Wed, Oct 23, 2024 at 11:58:46AM -0400, Mike Snitzer wrote:
> > We do not and cannot support file locking with NFS reexport over
> > NFSv4.x for the same reason we don't do it for NFSv3: NFS reexport

 [ ... patch snipped ... ]

> > diff --git a/Documentation/filesystems/nfs/reexport.rst b/Documentation/filesystems/nfs/reexport.rst
> > index ff9ae4a46530..044be965d75e 100644
> > --- a/Documentation/filesystems/nfs/reexport.rst
> > +++ b/Documentation/filesystems/nfs/reexport.rst
> > @@ -26,9 +26,13 @@ Reboot recovery
> >  ---------------
> >  
> >  The NFS protocol's normal reboot recovery mechanisms don't work for the
> > -case when the reexport server reboots.  Clients will lose any locks
> > -they held before the reboot, and further IO will result in errors.
> > -Closing and reopening files should clear the errors.
> > +case when the reexport server reboots because the source server has not
> > +rebooted, and so it is not in grace.  Since the source server is not in
> > +grace, it cannot offer any guarantees that the file won't have been
> > +changed between the locks getting lost and any attempt to recover them.
> > +The same applies to delegations and any associated locks.  Clients are
> > +not allowed to get file locks or delegations from a reexport server, any
> > +attempts will fail with operation not supported.
> >  
> >  Filehandle limits
> >  -----------------

Note for Mike:

Last sentence "Clients are not allowed to get ... delegations from a
reexport server" -- IIUC it's up to the re-export server to not hand
out delegations to its clients. Still, it's important to note that
NFSv4 delegation would not be available for re-exports.

See below for more: I'd like this paragraph to continue to discuss
the issue of OPEN and I/O behavior when the re-export server
restarts. The patch seems to redact that bit of detail.

Following is general discussion:


> There seems to be some controversy about this approach.
> 
> Also I think it would be nicer all around if we followed the usual
> process for changes that introduce possible behavior regressions:
> 
>  - add the new behavior, make it optional, default old behavior
>  - wait a few releases
>  - change the default to new behavior
> 
> Lastly, there haven't been any user complaints about the current
> situation of no lock recovery in the re-export case.
> 
> Jeff and I discussed this, and we plan to drop this one for 6.13 but
> let the conversation continue. Mike, no action needed on your part
> for the moment, but please stay tuned!
> 
> IMO having an export option (along the lines of "async/sync") that
> is documented in a man page is going to be a better plan. But if we
> find a way to deal with this situation without a new administrative
> control, that would be even better.

Proposed solutions so far:

- Disable NFS locking entirely on NFS re-export

- Implement full state pass-through for re-export

Some history of the NFSD design and the re-export issue is provided
here:

  http://wiki.linux-nfs.org/wiki/index.php/NFS_re-export#reboot_recovery

Certain usage scenarios require that lock state be globally visible,
so disabling NFS locking on re-export mounts will need to be
considered carefully.

Assuming that NFSv4 LOCK operations are proliferated to the back-end
server in today's NFSD, does it make sense to avoid code changes at
the moment, but more carefully document the configuration options
and their risks?

+++ In all following configurations, no state recovery occurs when
the re-export server restarts, as explained in
Documentation/filesystems/nfs/reexport.rst.

Mount options on the re-export server and clients:

* All default: open and lock state is proliferated to the back-end
  server and is visible to all NFS clients.

* local_lock=all on the re-export server's mount of the back-end
  server: clients of that server all see the same set of locks, but
  these locks are not visible to the back-end server or any of its
  clients. Open state is visible everywhere.

* local_lock=all on the NFS mounts on client mounts of the re-export
  server: applications on NFS clients do not see locks set by
  applications on any other NFS clients. Open state is visible
  everywhere.

When an NFS client of the re-export server OPENs a file, currently
that creates OPEN state on the re-export server, and I assume also
on the back-end server. That state cannot be recovered if the
re-export server restarts, but it also cannot be blocked by a mount
option.

Likewise, I assume the back-end server can hand out delegations to
the re-export server. If the re-export server restarts, how does it
recover those delegations? The re-export server could disable
delegation by blocking off its callback service, but should it?

What, if anything, is being done to further develop and regularly 
test NFS re-export in upstream kernels?

The reexport.rst file: This still reads more like design notes than
administrative documentation.  IMHO it should instead have a more
detailed description and disclaimer regarding what kind of manual
recovery is needed after a re-export server restart. That seems like
important information for administrators who think they might want
to deploy this solution. Maybe Documentation/ isn't the right place
for administrative documentation?

It might be prudent to (temporarily) label NFS re-export as
experimental use only, given its incompleteness and the long list
of caveats.


-- 
Chuck Lever

