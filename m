Return-Path: <linux-nfs+bounces-6518-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1697A5A8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2501A1C26AAE
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B8A17BBE;
	Mon, 16 Sep 2024 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5wHQhfW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MuZfA4+/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5021591E3
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502597; cv=fail; b=QcwN2gaTGNRRw3up0alQycJu7zohbTE9Pbiv4jNylKMlbGxHpIiSk9YouNx+BuHp8HXuCiK/PM3UIoRf1fb3/dbtXElhiKlLcxA2A9X8nPiZ8pVL6Yk4AZNuUsOOhF0GKcykN4xr9wLIrtVKrBnWZcie+h9ZJrgPbNWKEzUmUIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502597; c=relaxed/simple;
	bh=Q4DcV0IfoZTWFcGfJVWPQm7d8RNcZdSc7brmmUI90AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sBoHUcV3Ov/xTogz5k/hARXCbzSuYFrBN87ZMtyfIm6cm1lqnZSw7Whc8n+XaKfWrkGVMolSRPCgso5vkJ5lXexZcB6mmLW0nm/smj3Z010X9qaUigNdPn6qC7yFSZpIeF2+8JmHMz2qOfAUI4njnu+Ki7y1qeh+VSgXA4PF5zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h5wHQhfW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MuZfA4+/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GEMYth030166;
	Mon, 16 Sep 2024 16:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=u6ABRTb02UeUH3K
	0xaDFCoxOu3p9Fysczws9AroM7Mo=; b=h5wHQhfWBQnAlX9qWvBGvxcSWADG6mY
	9pUSEdlegAPtJpzUvGXwFFnPh/Dex35ymwIqrW5DauyxdalHTe1InzzzEvQRs8IU
	uKuFFfzTxRQmbJqaeWMnQUzr3T8UJGlPS3d5Uj59WqZ6Hdldrx/pqXGzjz2e5vN8
	TvWHxQ33XRED8zRrDkkunM4O/z1fMLTfUQpVjngbX2ZpYLZtMUyDBUsTgPlLTE2t
	K2nz64IG6aF7AUqZXNpwYLVM7d1IssU2XCAaQWohsF1nUl087wPoSetpsiCIJsAW
	aFIoTYFBzaoz9pqbNoiAbzLNVJ/xro5dobmfttlfGhQ1w1CuvdyE30g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n3bst3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 16:03:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GEqdJS034143;
	Mon, 16 Sep 2024 16:03:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycfmf0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 16:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plGit19FSIJRuPHh9PCKP2Wu10mTCoDiyRQQcVwayHixR70eKkmLTPcZPdLEE3OLyfoz4P9VghpT2ntMB0ohwVDsTlTU1cWjyK2NicnCQ3+s6CnFpsmWGyO0tnPRkS4qW8fR+brAGQxfqT2OiOUQ7rlXQkLCUDV1QPZJNdNH6sam7P2TFH0gD7jdaFabQ6im3onTuvDkV6YBL9BR3EiPCJYJRCrc5eYQSm4bhC0k29lBjRgSHcqeP9g1ZqH35b0xn9kNhIuU4+eWgjOuW2EBhuJyZyNx5Ynd0C9XkrFuSb8yYusISxxb9Z2cIMvXX4/l6E7W5b+yYOSdICid6gMWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6ABRTb02UeUH3K0xaDFCoxOu3p9Fysczws9AroM7Mo=;
 b=aRBlgEDaESVQdKfMZ/YYZ5k068BncFb+mDjZSvdImOEhnLrHRtnyBDS9z505Yzr3cU3BfVRd6Ah5NFgXYfF43vstif0b3OjNba3fEXG9vHdvP/QleJp3h4ptM/DFmnpbofjevS6b70rfD019OPBEC+G3yCsZPJSS4rVu+E3FwfmXhoC8zdIftlFTRJLDZSYvZ5aNohjoL0Npk60NTX8DTpK5jdhbqQcY15V/NHPYCooG4tSX+CNDNNWabR78nSF0BbdsPyMqK2NzrlLTYIUcoBVuOPOmQ/CERTffXDYFPqcxLxif9dzNWsNxseFiZ+Jyc/fdXzmOFQwdPF/jhKUnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6ABRTb02UeUH3K0xaDFCoxOu3p9Fysczws9AroM7Mo=;
 b=MuZfA4+/iwaB0ano2PscrKzEOQKq3T72fiBtHQfy+fC7BEurjQezt6/vZvEPL6okEqo8hkBuG4/oDF6FJ4354RRND9QCTXKBCGUZSFh3TrAZRKY9UyTYyyKatXHPHI/zR7sJK8RwpeBoQYqLdf8Aq6lDKJO40pDsD2uSMbLeZgw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8137.namprd10.prod.outlook.com (2603:10b6:208:513::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Mon, 16 Sep
 2024 16:02:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.012; Mon, 16 Sep 2024
 16:02:54 +0000
Date: Mon, 16 Sep 2024 12:02:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [bug report] svcrdma: Add a "parsed chunk list" data structure
Message-ID: <ZuhWrA2IBynEtgN+@tissot.1015granger.net>
References: <afd3828c-a1d1-401c-bdd2-b1f634f44599@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afd3828c-a1d1-401c-bdd2-b1f634f44599@stanley.mountain>
X-ClientProxiedBy: BYAPR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c5b0ef-6309-4218-d2ab-08dcd669066e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3vua70W2PJbXyIvN3YiF3vqPHXwNAKW2vycuZusUOfZO0Miq/GTpGKpAyU5Q?=
 =?us-ascii?Q?i3rSZBtnwbXFyHZOxdWQzjyQ92ckmHo1WQ1lJpGohLGLjvtLa9U2qdYRDSV/?=
 =?us-ascii?Q?tSsdnP1/OWOs6Am5TVWQpS/HprUK1gNSDrk9iUJoXkZ2rMa+bP/K45BydJUQ?=
 =?us-ascii?Q?ylv5U6kpz+r0HJdc4HTdTgD60y9LdE4Tdukut9gMQnJarN1Vl4GprOzSVGOC?=
 =?us-ascii?Q?Lj51F5ncXNyARoXJdcseVhEEkago0Pp7fkukHx5f3QpFQGYlOE9sMPukyxE8?=
 =?us-ascii?Q?pKj2oiRJfvI4tHReC4GDS8u2MiGpj2kCSpDyLW6o23YYlcMaKow/aAseu3cu?=
 =?us-ascii?Q?3TQrv1BELgW8jekedTqSM132uw2qj4czzL/vrPzuxyXUs/nKD4C3HBjqVw9c?=
 =?us-ascii?Q?jiTw3nLIvPbns+BPz+i5EsYvR1bqE4kZLIdmjEFPNCuOhJ6ORnnzxsZxJJka?=
 =?us-ascii?Q?L30tGtnWANV9hOuVxk9VZiXfhX0xuEV7Q8yx3eLVGh7eX0M34ZuOE/Y7l+3O?=
 =?us-ascii?Q?ZzsuZ3IMX9EzdcDUGyF4Qu+gw05S/esdZcbvDl511wJYLPXLfs0ukUyOo8F5?=
 =?us-ascii?Q?6j5xBHwheVdWxsexoz549q9CsYjVnH1Gp2Q+knQw8kme/Ikp7zz1rLip7AGu?=
 =?us-ascii?Q?QgJdeIcNdd15iM5JtzRE2IJbCgU5z06wMaykiy3G5qKU7Vq8vIgy1dNhfcNg?=
 =?us-ascii?Q?E83uzkHk41+9BNQKC/B+96Apr4PHYD3LDCA8wyhYaRLZuLb334O6SnP+qh+e?=
 =?us-ascii?Q?Hs5Jbd0EgHhKT3CE/0tzwZRK3Yn73Amjj2k5SdGZpv+bBcsOtZnmvt/VJxFR?=
 =?us-ascii?Q?mPfGsvgmD7xxuauH0S6s6URohu9Djtp+ricZzoDc0CWZtp8OKMG90UAiaY91?=
 =?us-ascii?Q?KWquqpX+j96quYdx9gMfyIFb5218yASmoMSYAzvM20CrzwY/Y9IZrdqVYHbg?=
 =?us-ascii?Q?nrg6CDlFuaH5ZeAg84e+qh98B2cfQjqWprapwe0ErFmYaDLi53LINo0i2EQB?=
 =?us-ascii?Q?+OlFXiH/riDtNsfJei0Yc7VhmDatmPb4ZP5//AOSg/mZ3/yfp2uI8BWNayxN?=
 =?us-ascii?Q?RyedcliXUek1R/eYjB2HfVzJNaiWV7vp6PDEyjv3JHQE9yB1Vd9Lrpflg7a+?=
 =?us-ascii?Q?7Q29sHpwwI48QRYxOz8+IYiw8KgeHO0uklwZHhqBMEpU4Mkkz3GZrsKBDP5J?=
 =?us-ascii?Q?7GG4q7PCjZew8gqwkLvxK2vXI0OA3w4iDiKMI7hyRhmhrOqBX33uvQvnNC5S?=
 =?us-ascii?Q?XU5t7nwYqQeHyvXsgEppQFAyFalmCBmVFyFd01M1Yw+ZwBJy1bK4svsPcIJc?=
 =?us-ascii?Q?0o/Ba0mtUKsUvn82Cs5vsVbeQp+9wDJ/JkHXzqP3Py7TeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a31+W/kNlpI1ExPNH7Hr0AAtP1O32KviHPvPsZFaiG4wfjO1UvYYaM2ejHDP?=
 =?us-ascii?Q?GC3QEuvBLqc+FxUQK3fVP3ad+SmR3eGTspRZqMURWvVRItWrql+2j+p5Eie2?=
 =?us-ascii?Q?tAL0uOrCAXgZrcuFukNBFA1qkRqOeI3cooEFBipSBEbXKA5JHAbgmXrlg979?=
 =?us-ascii?Q?xS5IH1Sk3bMwePSmjNtDBUZMAKcenc6m/42gre1E9OQ1RrmCILH0BteX8BUR?=
 =?us-ascii?Q?n1ThPcB4g8dFScQ7AAIhzOVq1aP5C+W9QSXFGBMte2CRHEFU/KptfzVl/w5u?=
 =?us-ascii?Q?Z76W0EPjoMeii7+xuutZ3pCYVy1X+fmZI9VjcqYHDYhfSVLiuGK5vr9P9eMX?=
 =?us-ascii?Q?ozfMVIOnormSaugODJlhQFhlumbE4g+RzdnFVRqEgwORVQblW2/p2fcRqc2R?=
 =?us-ascii?Q?THfGUDs7JtQsomN17LATe9fqC+mddVHMnp041BydtJT+A4TWZUUgGZEkqEYZ?=
 =?us-ascii?Q?Lsfk0/B7+DIYu9KRr/ROBb1kcRRTo7eQnNV4Fv9i1mORgoR/njEL8Tw5Uc+1?=
 =?us-ascii?Q?PPxkE6jDG4CDtvMzjbUICKKYfy8KHMjCeAE/7kbwd0O/K9z2FTqgXMN6EOfz?=
 =?us-ascii?Q?OsEQr7AkowdBVgtf9XyCMqNLh7TKcnHLRnwuu6PQkajLwFHzee+ICftAfClg?=
 =?us-ascii?Q?wcTaDFLioJwVHah/E+p0y/iMoIzX020PmORdTiPWY0uJUJHzGMdDDOdDJSrb?=
 =?us-ascii?Q?3tuwjQOnqFxrrsjwdZlEJuz7IHxLXC9zq4s2J1urkacKWiNj3xrbdqFhUlR+?=
 =?us-ascii?Q?/FD2BSc7cyhYhZn44DukCkV13bfxv/2BvY4AE2/egOHj+62WjyWb3sE16Md5?=
 =?us-ascii?Q?NblRJMHMD8wHMbV4/zDrYnJ17he38bk8VIWGsjnD5jTJauE5PHnHOQ9oMd2M?=
 =?us-ascii?Q?4xwBz7C2OQcvdAWgNKetWowHQFSDzZlbLIEn8pFUvORPa+V/H4JRkwR3c89s?=
 =?us-ascii?Q?JUDmZBvkDt7PTjxf2tvPw2cZuv85FIgkovsSt/7ClMRODG2hhEaxBX+kJmzz?=
 =?us-ascii?Q?pHFbUKoND5yJm2lxpblH/GLC9+8V0uHJk17MmTL/rG9dIPq5e/X8XynX87SV?=
 =?us-ascii?Q?V1zqeLz241iTLby1PIljVtgIjxifiWpdA3WM46P0tlQ2MwXb2MiVXVQx3Co1?=
 =?us-ascii?Q?OcYadQxCNj0rDYVUq1Y/wnze58ivoIlWLrDbpSvnllu8Z4OZ3dfV+n0m+Yo/?=
 =?us-ascii?Q?0TXqc5mBE0/u+cPnZa+6XSCvQ4LKDBeX1X26EqBROsM+OcDbgSQ1ZjBqF0lV?=
 =?us-ascii?Q?hRBDS3ZQer8FdB34IkcTJ/wT2Prj/LJK/0cRUnZu4X706VsScnu/bD39Y8KU?=
 =?us-ascii?Q?FXc/Zog/o29RP1bjKkfUGZk+t9mQ8Pb0OjaXXPoEyf0HyZsikoRANUl4uur5?=
 =?us-ascii?Q?bVkc2UbhV9ZBYQgy++dDjv3lESQ3KH3F0NTO78NqTxquSfQpyr509JwgcxJO?=
 =?us-ascii?Q?dMk7aOyBJU/vpxf6DqSOEyPzc3J6d/yD/6ceqwj14HL/SRxScAvLDscZLU6O?=
 =?us-ascii?Q?jzwsFLWh5zAtjBIsghEm8xz3L55BJ8Gm68ol9oeGcxWY8QKLDL8CFD/FL//4?=
 =?us-ascii?Q?ww4NPXC+Vy0pDyG3J+w6lrIh6OtE9v0uXkgzUSOA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s2y27gjJt+bmxCPVCZuDoYjqsQ0iRnMGUx5wXz+87vpLInL0THqY0izcmr7TyAVgNxhPNuW2SOUDMlj71Aso3kAJmisPQSXlgRQEnIvIkRNzdkk4Kd/QVH0fKBBRGfLFbbmnEeSHMAUZm1EPZiDveAGa3YCh6i2ELgrtVLi2gtaWSRWfnVWMMxSLT9boNhVPR4WtMnjqhcV9m4/eKDysxOPVdD4v/2p85U5y13TfDoJXOD56yLXvubHag8AAqYmSBjP60uCWpXiJY1wdzeNPVbUtc2yG8dyYv0RnjbK3HT3SC7OOAZ/dOD94PBYT3BevJX6Uo1HXhNz7w035m/X61/X3HUPUb5Y1orBvVzRhL/TuEG5QPsIZux/tO9n7vYldFQ7QPoURlklqU94V5AKOXJ5q7eklLI4A6gCLwapdnrnb8iZA8PkcIsCv1TSU8aOu/YdbmeDTIMFHSYZFQ34n0cHCq8yOyG4DCERhwpRmUhpx0of4Pw23kXk+mCAT4GUV56N3iff22ZzGl7+0NWsGLKlJRdM8/8cfJZDXYZds4tXrBZRbImPnOiCwMaMmq6F7ZiAPq48fiWKImIMECH+m+JVnfSISHJB3nLNzHJPTiYI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c5b0ef-6309-4218-d2ab-08dcd669066e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:02:54.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCBMN6lsop2VSNrH3wubWMPxq8NXa7BgMm62UaS2zesqwkM5ytTOHIVJTznZVgKX5AJbwd52kFGi3p0CW1KF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_12,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160105
X-Proofpoint-GUID: UqHUw2fMGNJ60a2V-W5A_uqJ3mQ6IzU9
X-Proofpoint-ORIG-GUID: UqHUw2fMGNJ60a2V-W5A_uqJ3mQ6IzU9

On Mon, Sep 16, 2024 at 06:14:47PM +0300, Dan Carpenter wrote:
> Hello Chuck Lever,
> 
> Commit 78147ca8b4a9 ("svcrdma: Add a "parsed chunk list" data
> structure") from Jun 22, 2020 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	net/sunrpc/xprtrdma/svc_rdma_recvfrom.c:498 xdr_check_write_chunk()
> 	warn: potential user controlled sizeof overflow 'segcount * 4 * 4'
> 
> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>     488 static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
>     489 {
>     490         u32 segcount;
>     491         __be32 *p;
>     492 
>     493         if (xdr_stream_decode_u32(&rctxt->rc_stream, &segcount))
>                                                               ^^^^^^^^
> 
>     494                 return false;
>     495 
>     496         /* A bogus segcount causes this buffer overflow check to fail. */
>     497         p = xdr_inline_decode(&rctxt->rc_stream,
> --> 498                               segcount * rpcrdma_segment_maxsz * sizeof(*p));
> 
> 
> segcount is an untrusted u32.  On 32bit systems anything >= SIZE_MAX / 16 will
> have an integer overflow and some those values will be accepted by
> xdr_inline_decode().

Yep, this is a bug. This is input parsing/checking code and should
be more careful.


>     499         return p != NULL;
>     500 }
> 
> regards,
> dan carpenter

-- 
Chuck Lever

