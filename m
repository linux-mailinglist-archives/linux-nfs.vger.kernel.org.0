Return-Path: <linux-nfs+bounces-6612-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E66C97EDFB
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 17:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA04CB20A6B
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3419B3F6;
	Mon, 23 Sep 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YiTUfZFQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ur99Hb5B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844D126C01;
	Mon, 23 Sep 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104730; cv=fail; b=kxTGp4Eli58Q+nMXbSQJnr6eMlFtUYY7g/Cw7t8rID6wR/kIl1jOO15S3FjUUnw4HI/mvcdh8LOSmoVhGqFlo2vCZmtJtNjKYUw+y6GL45M9JBAGuygZ8Dj918W5W0HbTpJAaNeb9X0q9TdbppjRHrOTd+AgWIV0srprVPMQcp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104730; c=relaxed/simple;
	bh=wsEO0lwEjGhNEkiowiFTDV0aDi2lSpekC1e7JYVWEcM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Zmg5OvTc0PQscrsNXu7iy016AgVEgwyZBHIz+2bIekQXerpnBwSGMH3YnD2kXNNMmt0c8zXY85TEExksSlIMOPtGeLt1itwAbDGyiXOzzR8E3qg7J+cQKkI3FmFJjBttM9H1wQbc6Ccky24u9DwKsvWJDVSMmENXAbbGCeZgu8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YiTUfZFQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ur99Hb5B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDsD3m012949;
	Mon, 23 Sep 2024 15:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=iTXMRM/klwILwFRjpecHPGIPJjUqWViRkOWzARFqQK0=; b=
	YiTUfZFQfFJjp0RJPdkb80uHxdEo1+jyaO0PBS+WY2P6mqDw462ZHaXuHm8MZdFQ
	Ub3wesVYPe9sIXpInUSLghmhDxnVSbkKKCppZOGrk4TSBcQlbjgZJbXP1wC/vmaV
	QEqkX6mbzEVRabhEWZE4FGfcTe+LLPP7sH4PzItJz+mfC8kqZ/tX8irm08b2O+lx
	1nI3TBd3ilweCpfhEQAe/cnWhvKAYR0saiFDxG14VVVbquw1k2sSe/7O/vyhH+V0
	kCIH26pX6ETuYNU1OmcbqQnDuNuTlxx0XRij+orsmcaHAjEhMVndykZ5vwGC+nDx
	qJBfZgohkFAYfgpiJiectQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6cahph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 15:18:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NEI6Ki001233;
	Mon, 23 Sep 2024 15:18:36 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk7nqwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 15:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3nC17XGWN2/eOdUQsuXgchSfde4hJNb6gZshZmcDB+kxrI0fcTCAoTpH3I62ww2G1SsSKbYxQfmqRNtLZnfasStllyRW5jPto0OSsCVy1LGCpB+G8ODKOTR31H4PUcArB149xRUfxGOx2irxFYsKSWl9v4C3E7tduXmeYgk5aRRVM+jH7mJF/nz/60aK2RYS8l3nHKunlFe8+PMDWTqE/nfLINze9fCJvFW3q49U3JSP1g3vNchrzQj9Ot5kJUqVJhR0/CKhAutOjsjBCXtOK1vAzwHtU5yBA24FWH6j4KM8o9B7t6xmM02HuMldXK2IOIoH8ftUk60i0n0Da8R9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTXMRM/klwILwFRjpecHPGIPJjUqWViRkOWzARFqQK0=;
 b=OeQSRPESblGgxfpCz4hBO6m29wna8S8YO+ZEXyvq6lZ5sUpJIBp2Xg3grDhFdbhmZf46waUUnttiFFP2I12iwWcH85xqSX+zI2QYF5wrFTTH8vm6UfJdlW3t/ivHCmQbUtUOOXpYfEwxvX8gBChffueF9hDnmYgbDw3BdXzjqVhDSbEPbt/O/L02D62m44KL9WaKrwLilKADmFG154F9bqvBFoWFFCxtPXVCAiS3N7etGbdC+yBcLP0JZ5YVOF31Asb1p5T82Qyya9t27SGOPZ31w/lXDeVD/yuWnK1yEg9Kk7/S4zdAj7sB28zf2MiBVoKmkowZZ4k4T74gBCFU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTXMRM/klwILwFRjpecHPGIPJjUqWViRkOWzARFqQK0=;
 b=ur99Hb5B26UkKyDNDGYvhtNDjmTwHZFyrRJAShmrNhswNsZFizShu7Hng0VGaYcwQjBc61Zy6HorGZV70nGibl3oehu+shdxyW8iAAhFdp4IrzcbpUDPo1CUo/iHZmoS8M3hf05vCBg1cTKKuY6JdSpuB9HV+LOK72JNP2/oiLE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 15:18:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 15:18:22 +0000
Date: Mon, 23 Sep 2024 11:18:19 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for the v6.12 merge window
Message-ID: <ZvGGu59VMM18+31a@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ace659-e2ef-4040-8b71-08dcdbe2f634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94TE9l0RolPTDS7e9VTC1AMw0KdIJ18dXNploWfbSKlTbsUkbdrzsLgwAY60?=
 =?us-ascii?Q?Rk4ZT5QpMwqK5lH0ZFm2ZftU6WX7/NyFcWBxX02oWBRpBgEU0W3Pw9aAb6Z3?=
 =?us-ascii?Q?wflRtMqsupgNEZTRBYMYMW5XgRQ/AVOUs+D5X+uYcU9YmeLRS7RBrg9bRmY2?=
 =?us-ascii?Q?+ElsXDQ7rzLKV+jn0GoauWUm9PhwDdG4K4hHtZGaZ/DHD2FoRxNGDfFLP+Or?=
 =?us-ascii?Q?RVb3R2XXU7sTKVzIXZUXmUL9K+Aqm4me9hfaFdlInSXNvo6IADfRKJw10laF?=
 =?us-ascii?Q?VIViStUCDE9jI7F9j/58vefO0htphlBF0u95S7vmSfZ1Ou4mEmh6IVh2duVY?=
 =?us-ascii?Q?/RblX8ok3vZFj34oRyr0tbUg4AQBxrWoIP+nZfHn8JVQmbF9/nQ7METId9Fi?=
 =?us-ascii?Q?zMCzqAG/0cpRmvcC1haxORJ4xSNUVsxgZCEvxhr86Ig45U1gggNPT+9EoIlo?=
 =?us-ascii?Q?WrVA5nzcOAcfedo5vzINsa2WTt3bEX5twKx3+9KzmJRaAFGNdswoG/pW9eHa?=
 =?us-ascii?Q?MXWIoDDtrg+hWxuldjpb7p2eucssk62a+e+UNihaZyE4UxacBDdseiIi6zQ2?=
 =?us-ascii?Q?gnVNW8MLiTlmOIu3B1rZVb1aru7KL2dHcR+2HVsPhioLMxyQRQQHJFp/7iLy?=
 =?us-ascii?Q?CnFvd/JGZR04WUqeE/t39pR1b/03a24E58b4AisSZPSdOZHKwJcIFL/8IQ+h?=
 =?us-ascii?Q?LrX/LwRJvNokenX9j7WXZk2zZ77ySh4udQuKsyGtiF0TymISrxd8R0F4Lnwz?=
 =?us-ascii?Q?jparKcffAy6a1tdWi9Xs5DaLi1D8EzfdW6KVgqmYsTLHvh7BaGXTbcAHVT7d?=
 =?us-ascii?Q?D7hlIBjEUe9FvdQq7vU6f1a43W9gUxvkEFpbt1GInvwS1i0xqfukV5r/v20p?=
 =?us-ascii?Q?Mo1GEESZy5ByyrZrZrY1pv+5TMJ0MWmUMLIsGmLsgC9wKE7miJarpLhp+kqv?=
 =?us-ascii?Q?9Q+Cl963dT1nBBdazfU0yHm5l5qQayrR8MzVjKcMLrl5qc9mPlsuxX/u0YyO?=
 =?us-ascii?Q?UOvf/w/vwRn1/Zcp6w6ivJlEAb9XcnL85pw+NgeuNyPlgvPFowmP520Nza1h?=
 =?us-ascii?Q?/N+3oorL2dOOomC0OZvU9W21DlPzKl8/3WbcJnRtjq/MwJ5c9MrKejiAdmca?=
 =?us-ascii?Q?bEoqcCz6Z6lOHjl7gJUQbhJI2+cgZBh5hkxZt4rpXNzrXp7UEACutHV3YgDy?=
 =?us-ascii?Q?b6PT8PPiKIgRXJXfjDuRXzFNQYmVRak+okWp7OTcmWlp+NWNrDIhWs0ui+vO?=
 =?us-ascii?Q?WD+fEIONhQrqfSkdpFjYdHjC4K1u8dA9nLX60zgWDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wArxjpd6GveuWsXXlqKjWZ6TNco2wR799M2nJot8UivnDy35ofB//uo+vzRf?=
 =?us-ascii?Q?hqHdZtfR+XCbBFh0yYTHIh2S+nlzypTNJ6Cju7p0a9apWdlzmkLEFciYBHp7?=
 =?us-ascii?Q?iYar38amqnkziWdeDanlNw8YQM34I+PIBD3ZpS/aWNXJ9geqPXAxAjkIfb3p?=
 =?us-ascii?Q?JVn+BMulILAcTx978K+xSKo+5Fwgti66ml/BEXEBKbSS5acfUHKe2STZecWE?=
 =?us-ascii?Q?eTKSbsX5euFt9+X4PS4mTfnBEEy6ooibArkI4/WacZ2TYn9P/Jyl7lafmLQ5?=
 =?us-ascii?Q?dLovAzZCb2i0eh8nZwkh/Owwm5/ZJXDvGf2gpPfOoVV7PBOIQu8zxK8rO+1v?=
 =?us-ascii?Q?9hw7VCaWEKR59vMFxnH6T/V6E6cY7gWk579u8PHS/Qzs5k+AtIhxzdlLzB7b?=
 =?us-ascii?Q?K44bNcrwFfkGcfKzSt0TVcTvLigoeRAmW1hJjnxsiiGW17MW4OmOlSpZMyHk?=
 =?us-ascii?Q?eybACuTU0dXI8tjIzyzQ+hj1GjqoXDdR+5N60GphiUaWgZ7C0HJPzCPDBDlJ?=
 =?us-ascii?Q?icWm7C6lUEtsEXDa1d3ELwWAME6IqKzyHwvBQ1ueR8ErFyO2u6Ylpc4EiiYq?=
 =?us-ascii?Q?PsnsGqGEPpalbA91LVDm/qUD3DRoMFGT/vd6NS8tpLPtx9TMCOGnuceHwTAX?=
 =?us-ascii?Q?AWpeCFeZf1BLyNESVdKkAePRhkcJe76Q7eAPKAM7Ym+DXBD4/x9/ZwU48fLT?=
 =?us-ascii?Q?ehLpxDVsmqPlvoS5daLqY0JjhCPZPc8HCdg6UYfvrU4oKwqsPqNb/17tUMpf?=
 =?us-ascii?Q?5Y4EIlK08HLBi4PLf+vqlRhfJyCO2sc2JRW+E1oNA3eDx6cVDJJr9f6sULns?=
 =?us-ascii?Q?cNQ8Hf4f9cvnWfW5lTVJ2kb/kKW92Xo2WYJjcRYgu8QOpCe07FaIMy5ffRfl?=
 =?us-ascii?Q?G1uc8Xw3fDOnZ9apvganPDO/vvCPU/l+owsD1GSmA4XWEplcUhUVlJJ0QLcC?=
 =?us-ascii?Q?MXoVHhyggS16l06f7+MdiAUO6KQ1NsW1YejIu83c/TF6JUw19a4D4K2d0ijy?=
 =?us-ascii?Q?GX2WjE1Riabx0CI5yjH6IettHr6sRuGf7gvhzPkAf0oGK3rMMCdWs3WCECRf?=
 =?us-ascii?Q?r0hwZd98CxBa9jy5qpJFd32fAX0efGzeMCXPqqWogF32waLyl7ariqv7nZgK?=
 =?us-ascii?Q?+cRoVCv25zujQK0c7ltyWyYeI9FeKUffKxGfA3tqUZG5L1nG8svWlfRDC9hm?=
 =?us-ascii?Q?rwhE/Pz/UBbhgNGnSR7gQTarksLJNlvJ8ZFrznkap57+Dhm8yoycRt8wd7fX?=
 =?us-ascii?Q?HfAIiy1OHDxJx8ygQXAeB5i57u8xU/t1mFh1b3r8CRiog7ZKuSz1POELP6AH?=
 =?us-ascii?Q?0PkGotyQZuZFkaeo0tkTEf6E+McuG4KY0MorKZIi9NQZSvwpWZeJLynSIyiF?=
 =?us-ascii?Q?LdZOjiHME7cJq2B2NETxpdG0dajTH1YTckYZNgT7d+Dxkb54RieFJBOzvWJ6?=
 =?us-ascii?Q?sKKRdAsaSlxvBzqUQ5s7OeMTM34hfw+7jFyGjViV4qBlVI1I9xLZjMCR+LXY?=
 =?us-ascii?Q?D9avQGJxuEMxbOFSYMAiQV12SIqSy3grK4OXuW6etsD1fx4j+REA9kElo318?=
 =?us-ascii?Q?3xM6pcIyW8GzEImS4xtVN8kJD4e83xGxAp/sc/NP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i8piru9pTeC+TgB/ntW/oe6rqUV1cA+y1l7P8gMo+lnOuePXaITfu3pm/ETLb8xuM6g0fXR2bxteAy+bVSxi1x65zefnjZjRMfKP1hCWvyyMefmX/d7n6JEBPwh7wpU4Xn1pPWmXJAVYoMSB7y3lm4EwqfLx50fC+VOI+d0pmqkHNTfsJX7schHKodpouiKmjNlmgiRM8NSyu5aozYAbyrsUtxTYVbA4NVqzbmA+2eyW2kg0iaaVHqXMvW2WQaXKbrAPz47YF9NCHMDf4KdaaWGrWgPK+X/kx1z2hcLbzeb/+buXrAtsMziisR6u5wJFX8vTy+Vb68nV64/HrYPoq5qmgnwEcbvJwD4hBAQkZNM7anmqy2SX3ju7xba2SkpXmy7fL29AvSIeqx1ZBd9Xfo0Vbe1PtFgIKuYhIZyeoLrmt5df39nCO6wCri3e8bGZY+nK6+HS5JPjzKumGUyAl3+MEYUSVheeAt2LOMEPaR4Gtw3IXIxS3K4+dOYhhTEXCVId4JnbwLLHtXBtsqllZWG6QVJHSXaXSZaorSOslOGd9oJpdXqM7dm5XAGawPS5SpFzP6PJEiOQuWVy82CawKFB609lw2AVMdvwoy4w5XM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ace659-e2ef-4040-8b71-08dcdbe2f634
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 15:18:22.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eRUjoRHMc7OqX4Vbj7HTHyCchW58G3XUNCDYnMnV4UvLpin3bJBt47oA76jVachyy57iZQO2plA5lqy7wy/dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_11,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230114
X-Proofpoint-GUID: vPggxYv1UmjkuAGX2R6SghTe1b5GYJKN
X-Proofpoint-ORIG-GUID: vPggxYv1UmjkuAGX2R6SghTe1b5GYJKN

Hi Linus-

A quick note about the rather fresh commit dates in this PR:

We had some additional changes queued up that needed to be dropped
because their defect rate was not going down as fast as I would like
prior to -rc1, especially considering maintainer travel plans. Those
changes will be rescheduled for v6.13.

The commits included here have been in linux-next for weeks and pass
our NFSD CI tests.

--- cut here ---

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12

for you to fetch changes up to 509abfc7a0ba66afa648e8216306acdc55ec54ed:

  xdrgen: Prevent reordering of encoder and decoder functions (2024-09-20 19:31:41 -0400)

----------------------------------------------------------------
NFSD 6.12 Release Notes

Notable features of this release include:

- Pre-requisites for automatically determining the RPC server thread
  count
- Clean-up and preparation for supporting LOCALIO, which will be
  merged via the NFS client tree
- Enhancements and fixes to NFSv4.2 COPY offload
- A new Python-based tool for generating kernel SunRPC XDR encoding
  and decoding functions, added as an aid for prototyping features
  in protocols based on the Linux kernel's SunRPC implementation.

As always I am grateful to the NFSD contributors, reviewers,
testers, and bug reporters who participated during this cycle.

----------------------------------------------------------------
Chen Hanxiao (1):
      NFS: trace: show TIMEDOUT instead of 0x6e

Chuck Lever (13):
      svcrdma: Handle device removal outside of the CM event handler
      NFSD: Fix NFSv4's PUTPUBFH operation
      .mailmap: Add an entry for my work email address
      NFSD: Async COPY result needs to return a write verifier
      NFSD: Limit the number of concurrent async COPY operations
      NFSD: Display copy stateids with conventional print formatting
      NFSD: Record the callback stateid in copy tracepoints
      NFSD: Clean up extra whitespace in trace_nfsd_copy_done
      NFSD: Wrap async copy operations with trace points
      tools: Add xdrgen
      xdrgen: Fix return code checking in built-in XDR decoders
      xdrgen: typedefs should use the built-in string and opaque functions
      xdrgen: Prevent reordering of encoder and decoder functions

Guoqing Jiang (1):
      nfsd: call cache_put if xdr_reserve_space returns NULL

Hongbo Li (1):
      nfsd: use LIST_HEAD() to simplify code

Jeff Layton (7):
      nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
      nfsd: fix refcount leak when file is unhashed after being found
      nfsd: count nfsd_file allocations
      nfsd: add more info to WARN_ON_ONCE on failed callbacks
      nfsd: track the main opcode for callbacks
      nfsd: add more nfsd_cb tracepoints
      nfsd: fix initial getattr on write delegation

Li Lingfeng (5):
      NFSD: remove redundant assignment operation
      nfsd: map the EBADMSG to nfserr_io to avoid warning
      nfsd: remove unused parameter of nfsd_file_mark_find_or_create
      nfsd: fix some spelling errors in comments
      nfsd: return -EINVAL when namelen is 0

Mark Grimes (1):
      nfsd: Add quotes to client info 'callback address'

NeilBrown (22):
      nfsd: don't EXPORT_SYMBOL nfsd4_ssc_init_umount_work()
      lockd: discard nlmsvc_timeout
      SUNRPC: make various functions static, or not exported.
      nfsd: move nfsd_pool_stats_open into nfsctl.c
      nfsd: don't allocate the versions array.
      sunrpc: document locking rules for svc_exit_thread()
      sunrpc: change sp_nrthreads from atomic_t to unsigned int.
      sunrpc: don't take ->sv_lock when updating ->sv_nrthreads.
      sunrpc: merge svc_rqst_alloc() into svc_prepare_thread()
      sunrpc: allow svc threads to fail initialisation cleanly
      nfsd: Don't pass all of rqst into rqst_exp_find()
      nfsd: Pass 'cred' instead of 'rqstp' to some functions.
      nfsd: use nfsd_v4client() in nfsd_breaker_owns_lease()
      nfsd: further centralize protocol version checks.
      nfsd: move V4ROOT version check to nfsd_set_fh_dentry()
      nfsd: Move error code mapping to per-version proc code.
      nfsd: be more systematic about selecting error codes for internal use.
      nfsd: move error choice for incorrect object types to version-specific code.
      nfsd: use clear_and_wake_up_bit()
      nfsd: avoid races with wake_up_var()
      nfsd: untangle code in nfsd4_deleg_getattr_conflict()
      nfsd: fix delegation_blocked() to block correctly for at least 30 seconds

Sagi Grimberg (1):
      nfsd: don't assume copy notify when preprocessing the stateid

Scott Mayhew (1):
      nfsd: enforce upper limit for namelen in __cld_pipe_inprogress_downcall()

Thorsten Blum (1):
      NFSD: Annotate struct pnfs_block_deviceaddr with __counted_by()

Yan Zhen (1):
      sunrpc: xprtrdma: Use ERR_CAST() to return

Youzhong Yang (2):
      nfsd: add list_head nf_gc to struct nfsd_file
      nfsd: use system_unbound_wq for nfsd_file_gc_worker()

 .mailmap                                                                          |   3 +
 fs/lockd/host.c                                                                   |   2 +-
 fs/lockd/svc.c                                                                    |   9 +-
 fs/nfs/callback.c                                                                 |   2 +
 fs/nfsd/auth.c                                                                    |  14 +-
 fs/nfsd/auth.h                                                                    |   2 +-
 fs/nfsd/blocklayout.c                                                             |   6 +-
 fs/nfsd/blocklayoutxdr.h                                                          |   2 +-
 fs/nfsd/cache.h                                                                   |   2 +-
 fs/nfsd/export.c                                                                  |  37 ++--
 fs/nfsd/export.h                                                                  |   7 +-
 fs/nfsd/filecache.c                                                               |  36 ++--
 fs/nfsd/filecache.h                                                               |   1 +
 fs/nfsd/netns.h                                                                   |   7 +-
 fs/nfsd/nfs3proc.c                                                                |  44 +++++
 fs/nfsd/nfs4callback.c                                                            |   8 +-
 fs/nfsd/nfs4idmap.c                                                               |  13 +-
 fs/nfsd/nfs4layouts.c                                                             |   1 +
 fs/nfsd/nfs4proc.c                                                                |  71 ++++----
 fs/nfsd/nfs4recover.c                                                             |  13 +-
 fs/nfsd/nfs4state.c                                                               | 225 ++++++++++++------------
 fs/nfsd/nfs4xdr.c                                                                 |  29 +++-
 fs/nfsd/nfsctl.c                                                                  |  19 +-
 fs/nfsd/nfsd.h                                                                    |  44 +++--
 fs/nfsd/nfsfh.c                                                                   |  58 +++----
 fs/nfsd/nfsfh.h                                                                   |   2 +
 fs/nfsd/nfsproc.c                                                                 |  49 +++++-
 fs/nfsd/nfssvc.c                                                                  | 126 +++-----------
 fs/nfsd/state.h                                                                   |   1 +
 fs/nfsd/trace.h                                                                   | 124 +++++++++++--
 fs/nfsd/vfs.c                                                                     |  45 +++--
 fs/nfsd/vfs.h                                                                     |   4 +-
 fs/nfsd/xdr4.h                                                                    |   1 +
 include/linux/lockd/lockd.h                                                       |   2 +-
 include/linux/nfs4.h                                                              |  17 +-
 include/linux/sunrpc/svc.h                                                        |  44 +++--
 include/linux/sunrpc/svc_rdma.h                                                   |   2 +
 include/linux/sunrpc/svcauth.h                                                    |   1 -
 include/linux/sunrpc/svcsock.h                                                    |   2 -
 include/linux/sunrpc/xdrgen/_builtins.h                                           | 243 ++++++++++++++++++++++++++
 include/linux/sunrpc/xdrgen/_defs.h                                               |  26 +++
 include/trace/events/rpcrdma.h                                                    |  23 +++
 include/trace/misc/nfs.h                                                          |   1 +
 net/sunrpc/sunrpc.h                                                               |   4 +
 net/sunrpc/svc.c                                                                  | 130 +++++++-------
 net/sunrpc/svc_xprt.c                                                             |   9 -
 net/sunrpc/svcauth.c                                                              |   1 -
 net/sunrpc/svcsock.c                                                              |   1 -
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                          |  18 +-
 tools/net/sunrpc/xdrgen/.gitignore                                                |   2 +
 tools/net/sunrpc/xdrgen/README                                                    | 244 ++++++++++++++++++++++++++
 tools/net/sunrpc/xdrgen/__init__.py                                               |   2 +
 tools/net/sunrpc/xdrgen/generators/__init__.py                                    | 113 ++++++++++++
 tools/net/sunrpc/xdrgen/generators/constant.py                                    |  20 +++
 tools/net/sunrpc/xdrgen/generators/enum.py                                        |  44 +++++
 tools/net/sunrpc/xdrgen/generators/header_bottom.py                               |  33 ++++
 tools/net/sunrpc/xdrgen/generators/header_top.py                                  |  45 +++++
 tools/net/sunrpc/xdrgen/generators/pointer.py                                     | 272 +++++++++++++++++++++++++++++
 tools/net/sunrpc/xdrgen/generators/program.py                                     | 168 ++++++++++++++++++
 tools/net/sunrpc/xdrgen/generators/source_top.py                                  |  32 ++++
 tools/net/sunrpc/xdrgen/generators/struct.py                                      | 272 +++++++++++++++++++++++++++++
 tools/net/sunrpc/xdrgen/generators/typedef.py                                     | 255 +++++++++++++++++++++++++++
 tools/net/sunrpc/xdrgen/generators/union.py                                       | 243 ++++++++++++++++++++++++++
 tools/net/sunrpc/xdrgen/grammars/xdr.lark                                         | 119 +++++++++++++
 tools/net/sunrpc/xdrgen/subcmds/__init__.py                                       |   2 +
 tools/net/sunrpc/xdrgen/subcmds/declarations.py                                   |  76 ++++++++
 tools/net/sunrpc/xdrgen/subcmds/definitions.py                                    |  78 +++++++++
 tools/net/sunrpc/xdrgen/subcmds/lint.py                                           |  33 ++++
 tools/net/sunrpc/xdrgen/subcmds/source.py                                         | 118 +++++++++++++
 tools/net/sunrpc/xdrgen/templates/C/constants/definition.j2                       |   3 +
 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2                     |   4 +
 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2                          |  19 ++
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2                      |   2 +
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/enumerator.j2                 |   2 +
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/open.j2                       |   3 +
 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2                          |  14 ++
 tools/net/sunrpc/xdrgen/templates/C/header_bottom/declaration/header.j2           |   3 +
 tools/net/sunrpc/xdrgen/templates/C/header_bottom/definition/header.j2            |   3 +
 tools/net/sunrpc/xdrgen/templates/C/header_top/declaration/header.j2              |  14 ++
 tools/net/sunrpc/xdrgen/templates/C/header_top/definition/header.j2               |  10 ++
 tools/net/sunrpc/xdrgen/templates/C/pointer/declaration/close.j2                  |   4 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/basic.j2                      |   6 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2                      |   3 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_array.j2         |   8 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2        |   6 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/open.j2                       |  22 +++
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/optional_data.j2              |   6 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_array.j2      |  13 ++
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_opaque.j2     |   6 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_string.j2     |   6 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/basic.j2                   |   5 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/close.j2                   |   2 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_array.j2      |   5 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_opaque.j2     |   5 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/open.j2                    |   6 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/optional_data.j2           |   5 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_array.j2   |   8 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_opaque.j2  |   5 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_string.j2  |   5 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/basic.j2                      |  10 ++
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2                      |   3 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_array.j2         |  12 ++
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_opaque.j2        |   6 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/open.j2                       |  20 +++
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/optional_data.j2              |   6 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_array.j2      |  15 ++
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2     |   8 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_string.j2     |   8 +
 tools/net/sunrpc/xdrgen/templates/C/program/declaration/argument.j2               |   2 +
 tools/net/sunrpc/xdrgen/templates/C/program/declaration/result.j2                 |   2 +
 tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2                   |  21 +++
 tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2                     |  22 +++
 tools/net/sunrpc/xdrgen/templates/C/program/definition/close.j2                   |   2 +
 tools/net/sunrpc/xdrgen/templates/C/program/definition/open.j2                    |   6 +
 tools/net/sunrpc/xdrgen/templates/C/program/definition/procedure.j2               |   2 +
 tools/net/sunrpc/xdrgen/templates/C/program/encoder/argument.j2                   |  16 ++
 tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2                     |  21 +++
 tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2                          |   8 +
 tools/net/sunrpc/xdrgen/templates/C/source_top/server.j2                          |   8 +
 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/close.j2                   |   4 +
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/basic.j2                       |   6 +
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2                       |   3 +
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_array.j2          |   8 +
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2         |   6 +
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/open.j2                        |  12 ++
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/optional_data.j2               |   6 +
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_array.j2       |  13 ++
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2      |   6 +
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_string.j2      |   6 +
 tools/net/sunrpc/xdrgen/templates/C/struct/definition/basic.j2                    |   5 +
 tools/net/sunrpc/xdrgen/templates/C/struct/definition/close.j2                    |   2 +
 tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_array.j2       |   5 +
 tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_opaque.j2      |   5 +
 tools/net/sunrpc/xdrgen/templates/C/struct/definition/open.j2                     |   6 +
 tools/net/sunrpc/xdrgen/templates/C/struct/definition/optional_data.j2            |   5 +
 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_array.j2    |   8 +
 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_opaque.j2   |   5 +
 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_string.j2   |   5 +
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2                       |  10 ++
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2                       |   3 +
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_array.j2          |  12 ++
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_opaque.j2         |   6 +
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/open.j2                        |  12 ++
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/optional_data.j2               |   6 +
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_array.j2       |  15 ++
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2      |   8 +
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2      |   8 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/basic.j2                  |   8 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_array.j2     |   4 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_opaque.j2    |   4 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_array.j2  |   4 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_opaque.j2 |   4 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_string.j2 |   4 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2                      |  17 ++
 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2         |  25 +++
 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2        |  17 ++
 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2      |  26 +++
 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2     |  17 ++
 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_string.j2     |  17 ++
 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/basic.j2                   |   6 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_array.j2      |   6 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_opaque.j2     |   6 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_array.j2   |   9 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_opaque.j2  |   6 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_string.j2  |   6 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2                      |  21 +++
 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2         |  25 +++
 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2        |  17 ++
 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2      |  30 ++++
 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2     |  17 ++
 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_string.j2     |  17 ++
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/basic.j2                        |   6 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/break.j2                        |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec.j2                    |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2                        |   4 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/default_spec.j2                 |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/open.j2                         |  12 ++
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/optional_data.j2                |   6 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/switch_spec.j2                  |   7 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_array.j2        |  13 ++
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_opaque.j2       |   6 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_string.j2       |   6 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/void.j2                         |   3 +
 tools/net/sunrpc/xdrgen/templates/C/union/definition/case_spec.j2                 |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2                     |   8 +
 tools/net/sunrpc/xdrgen/templates/C/union/definition/default_spec.j2              |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/definition/open.j2                      |   6 +
 tools/net/sunrpc/xdrgen/templates/C/union/definition/switch_spec.j2               |   3 +
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2                        |  10 ++
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/break.j2                        |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec.j2                    |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2                        |   4 +
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/default_spec.j2                 |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/open.j2                         |  12 ++
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/switch_spec.j2                  |   7 +
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/void.j2                         |   3 +
 tools/net/sunrpc/xdrgen/tests/test.x                                              |  36 ++++
 tools/net/sunrpc/xdrgen/xdr_ast.py                                                | 510 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/net/sunrpc/xdrgen/xdr_parse.py                                              |  36 ++++
 tools/net/sunrpc/xdrgen/xdrgen                                                    | 132 ++++++++++++++
 200 files changed, 4959 insertions(+), 499 deletions(-)
 create mode 100644 include/linux/sunrpc/xdrgen/_builtins.h
 create mode 100644 include/linux/sunrpc/xdrgen/_defs.h
 create mode 100644 tools/net/sunrpc/xdrgen/.gitignore
 create mode 100644 tools/net/sunrpc/xdrgen/README
 create mode 100644 tools/net/sunrpc/xdrgen/__init__.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/__init__.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/constant.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/enum.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/header_bottom.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/header_top.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/pointer.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/program.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/source_top.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/struct.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/typedef.py
 create mode 100644 tools/net/sunrpc/xdrgen/generators/union.py
 create mode 100644 tools/net/sunrpc/xdrgen/grammars/xdr.lark
 create mode 100644 tools/net/sunrpc/xdrgen/subcmds/__init__.py
 create mode 100644 tools/net/sunrpc/xdrgen/subcmds/declarations.py
 create mode 100644 tools/net/sunrpc/xdrgen/subcmds/definitions.py
 create mode 100644 tools/net/sunrpc/xdrgen/subcmds/lint.py
 create mode 100644 tools/net/sunrpc/xdrgen/subcmds/source.py
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/constants/definition.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/enumerator.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/header_bottom/declaration/header.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/header_bottom/definition/header.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/header_top/declaration/header.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/header_top/definition/header.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/declaration/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/declaration/argument.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/declaration/result.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/decoder/argument.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/definition/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/definition/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/definition/procedure.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/encoder/argument.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/encoder/result.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/source_top/server.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/declaration/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/definition/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/break.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/default_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/optional_data.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/switch_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/variable_length_string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/case_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/default_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/definition/switch_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/break.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/default_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/open.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/switch_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/tests/test.x
 create mode 100644 tools/net/sunrpc/xdrgen/xdr_ast.py
 create mode 100644 tools/net/sunrpc/xdrgen/xdr_parse.py
 create mode 100755 tools/net/sunrpc/xdrgen/xdrgen

-- 
Chuck Lever

