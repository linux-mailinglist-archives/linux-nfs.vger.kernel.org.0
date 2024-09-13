Return-Path: <linux-nfs+bounces-6454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7EC9784CB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DCA1F28005
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47CB28DC1;
	Fri, 13 Sep 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C4w21jja";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zS2VWiRP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996D26AED;
	Fri, 13 Sep 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241173; cv=fail; b=TGS/bPK4bhJMlNjKx68iI01zCzRKplvbOX/bzpkL49eLyBOaWzXQJiDrGg+Q7d7YKemoAYkXFh8hTkLkSwZXTPqqvzDRowTjFgQF/s3OJ31Vzq2KfiDktmuypod16lWTopnb8lBu4jQi/KPuIbYeCKvZ6IO1yc2tyB6CLZ4s2mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241173; c=relaxed/simple;
	bh=JBp2m7oiphTM3HqSteRLwmnFyeOerRhwsv3l1couM50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lpfi8gRBRMKOgvgVwlwb0ecmJbdQi70ERNQ8y3w2qsqeblUxJxSlYBAKKMrG7ijJq+Q0ZQoh2vIWOT7NPouxpvqycbJrkANfRqJkrt1RKldMVjBXyQy1ltjB8IyG7JMiR6YtChb2AE/iJSreQBrV/B1ShwYv+CdAtgnQIrKoGfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C4w21jja; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zS2VWiRP reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YONi011321;
	Fri, 13 Sep 2024 15:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=/oiMjET8cSCoCTF9c/v8Xgp+t885m0Gyjw4E/K1flwc=; b=
	C4w21jjay1VY94oA9TV/BiX2CHTcCFcnS5G0ki6TyQlcPZlvzqZQoCoAaGfWwzcW
	YVntPV7POlqATeEL9cRGpiDE/kZ1MQVdgse6K/LLXXVW04AuIjyngobFYFW5SUe1
	zalX+UgqhHnHMZn4zOVlyRSVGsQR8JItiKQlYJVHb+BX9Wu7O8yVWe8CnV963PTn
	I2ZEuGOWyu66JVLliUl8JjmGGs+x9H6HjOAQwhSH45Ke5ivr4r8vj9jg8wmkoYYo
	Z209CTGkImintyNsZyU75d9Qn2OYiu1n5RCt+1oVLagD60ODu719kEt+Z7nLoaeL
	3jPAOSfiuQNNjs8pdJe3Sw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2wxqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 15:26:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFNGfQ019825;
	Fri, 13 Sep 2024 15:26:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9kb4xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 15:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZODvkqDnQVmmDplpT3yWkiQOvukuWrf7AoX00xW9VGcKfLuSAPPECABlfT1G3dGCJIVVK9kezz1nGTy6HQHlvNAxnfA9BWU5dctszK2A9NwAc/g1eIaS/FoAqxbjSnsIZKjEKUW1o5rpEle57aBE/OsYufMbd+C8EtjmNnEbGB/lUYCibvlCeSo/arNluTfZVbYS3e9x/L03FW1yGnuv7VH2h0PZ/pNWzfFrpokQxHKKa7co7/q677UX8S78Kv85LgMqLFkgl2wSY1/pTc4Zcq0QoahnywyF9lpYmcVqdghzGtie0vEhk+FkfJsFt8V512lKhUlwrLVyEkK//LACXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUdZDfggtmNLOLo4VBpzGvZLGIE9E4HGHTPB8GruYu4=;
 b=MBjl4ktbw327M4zTkh93bQIKEyjHq/ORcU7QP+05JcS/hdaagUGYTOCWcQJW8piRi3SqW8A/5Qun/QMLsbSIOaixvOm9AvhVGiV2VgY2kG1Rz7hlCTvD2VKH9pI4npgOk55iI//eOVdwmq1e1R0+xEeMx+kTIpS1nAEmBEcOjGBcEZ8CYG7wv94yRnkRiJMuKcpwIFZ8VRhK3/6wHYv1FSIystDElIEwXne00SkXIaqvzu3TNZGM++b5SjoZG6vB58xL/LlCMsmkGm2OM+aLiwmDKrxoNhvmUr3ctna9VS+MbZgtGYeIvSjywRk2sMJcHC7x9itipFY++bOR2SiWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUdZDfggtmNLOLo4VBpzGvZLGIE9E4HGHTPB8GruYu4=;
 b=zS2VWiRPsRdqa0N4zd+5U/+ZiDQlJYwcZKoQPsUMxau+Tr7OrbiRMRp8kLHsWCjmTQRuFdcHvNRS2n08WoGINYa+RgAP9nyHxcf7kAuWE0gLncNxrGWnH0lJGCXuFp5/bls35ZMWlrMqDJzuHrsPRdJsCMv/HZWsoPPYzNkKYl4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4204.namprd10.prod.outlook.com (2603:10b6:5:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.10; Fri, 13 Sep
 2024 15:25:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 15:25:59 +0000
Date: Fri, 13 Sep 2024 11:25:55 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix nfs4_disable_idmapping option
Message-ID: <ZuRZgxkSqlioLuST@tissot.1015granger.net>
References: <>
 <20240912223858.22qibyh3xwk2pqw5@pali>
 <172618218021.17050.8500126114376063163@noble.neil.brown.name>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172618218021.17050.8500126114376063163@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:610:b3::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff8d773-1baa-46f5-7d1f-08dcd4085ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?O7AXSG9I33edR1rO/lFfUbMW/UBhevAPamC3SI9hI6ZCHSjafQpy2QB1tG?=
 =?iso-8859-1?Q?KHoQZF9itLhelx7WJbJb/wW0wMajVjV9Xr0Vlw6R2aLXQDDl6RRalgX5/S?=
 =?iso-8859-1?Q?DK22ni0AlxR6gNASIlPR1H0v/ZsoStMnV4N2yBsC6vJAx72KK+tyoDpfrc?=
 =?iso-8859-1?Q?14kea05Ucwl9oGdpyY2lIHWGcg4f8dTiKNXXgYbnuJtZHlLJbhSsIHBdbN?=
 =?iso-8859-1?Q?YZFhBkPY3oSrT+2h0EI8SXkPLi7gVZwmwLQ3JrtzZIfSHKPzsvTivm6IdJ?=
 =?iso-8859-1?Q?JUf3M4mI4X2/HT/0VLee85lhc/ZCYarwZuFPNG7pxLSoEN4Il///i/sqi7?=
 =?iso-8859-1?Q?3uP0QQLBA8mrbcYUOickF9Lxi6anZrhZuJWYT1QyGhhwolFednjj91P3Gg?=
 =?iso-8859-1?Q?GtQ+HT2jSjJrzXccaWdI6eIxl2CU/ZqwIfH7dtamKU1sy/0j7mJeO3JJZX?=
 =?iso-8859-1?Q?GESQdUSkiS4D+8VYtOjDXntFwO1Ho9VSQYOpAgysDbyYsRfdIof9Cr6tbv?=
 =?iso-8859-1?Q?SFQ72wjvkMJupEVE9X+3w+8G0CWelXdWRYtMmxPtSCsP6IYHrN7/A+76yC?=
 =?iso-8859-1?Q?c+4I3fAVNMUiB0CmWdaAoNX4TcaVwSGUC1ah3Njc7g5raAOZdvDHNWzvaK?=
 =?iso-8859-1?Q?tuoaj8U2LX4w4EybYAdjWeqng6Jlfg3nr6pqgef7A4+lZFWfmIvHMXKya1?=
 =?iso-8859-1?Q?oRYENmudUa1fz+Gm7OVkh79pV/qg58Y5VzSiQ7XHywt16fWzL0UJe4DOEu?=
 =?iso-8859-1?Q?OnKoSZz++lNsva6G+OStQZxzjkyReHXBeZBg3HPY5Ui0n02IEfoP2pSW2q?=
 =?iso-8859-1?Q?S70SCzIf/hNng7umKQp5AsHhk3ZJ+wOjozOKcsKy0r/n9rKtjBA3VA9KEO?=
 =?iso-8859-1?Q?vZszXpHbZjH0YF+1jwmZxQw6TNeFwY1+rm6D5sFNeNRzADoyJon3GUtjMP?=
 =?iso-8859-1?Q?t20ta+eejgqlluxCtwM30T6EL6M5UzVyP2lZ24vjaQm2nkC9GKs8Q+5KJP?=
 =?iso-8859-1?Q?Ogvia0+1/QrM7jCLQ4KYkL7eZB4VU4O1mUvgeCHUe6Xj/XHmcHFRL+TCnU?=
 =?iso-8859-1?Q?YT1uwqM53tR89xXJRpF7ibqnC7xkICC01ChDN2dLciHbWCo2+TZASNzMlo?=
 =?iso-8859-1?Q?ORgENqcKA54pw+wp+FdjmyfWVYtakuJEinFfryoEK1tgTV5O0NCGdk61Hd?=
 =?iso-8859-1?Q?2qHPR7KNyJVmI79lgk+6zsMpcxhQEoPZXwfPksQ9WVHoIW87R2vnXztCZf?=
 =?iso-8859-1?Q?/s4FecugIc/dVEBLOsVxl/PW9/byLzGAZYY6Yi7iPtibYL0GmAgIciK8XC?=
 =?iso-8859-1?Q?5KEIFiXJhELmVMZLeCeRTT6t2sVQFSLJdXGmA6kYucorKH8EXXQGmsFAOp?=
 =?iso-8859-1?Q?9VetcUJaFCrrfiTest7AxP1wtfo5sy9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?L4nL0m9jWGdrR8/4aZdrlHncWw5wGoHQsJH/eCrIpAhif8zBEAF0TKkzl2?=
 =?iso-8859-1?Q?oKD+3ZyiUhTYLL7g97D+iwbCCLcjVjmXyb/3MEM+6eRf+1k8mvJ26iY7b2?=
 =?iso-8859-1?Q?BupYOglUtCd0cazGRkIx1222gtscGFEzaJXugD3J7/ritYRvRAf6C4aOB5?=
 =?iso-8859-1?Q?zfabAH1lRdg0SjIYKi1iNfAiMTGc+Myu8FGifrPVb8IEJHWiQN/VsDfyv0?=
 =?iso-8859-1?Q?0cQoUYKuHwjB8vQkopW3OebAvanQAp1S2vGiMelg4NFo1IYND7nGoxpQXl?=
 =?iso-8859-1?Q?LckBN08n+L0NEyMAn2R7LmtfQODpjxxw3EjT/PCBk8uUny7b6FppBBsvk2?=
 =?iso-8859-1?Q?DlDLDjpVRFkDjuZteqIwgVJZ49i1gXcUoGr+bGthPACL2TtjXM3pnjxK1P?=
 =?iso-8859-1?Q?2fAiHsB+QwNdn8SZ7YhSbLlZS5j1UoY81uVHLh0mnByzMDR+X2PNRzKb8K?=
 =?iso-8859-1?Q?sInFydbihpdVLU9G25I7MUs3e/7JNr59RuMBU/iUUBpFi24OJPcNoK0gH5?=
 =?iso-8859-1?Q?MWJnl3IfQabqmUEdWwpGsr7h8Aa9C4aV/yamR6tTMpzrjyRlwwBHDRzzan?=
 =?iso-8859-1?Q?3E742O8zGAFsNlsqTzkuwtMxv+KX7fJ66C9iqmvMmzK7g5gpybiwZpSktr?=
 =?iso-8859-1?Q?FnxLwJULZi5hS3fTzmXGbJanXOoLi2qAmlzp4hqc9DqtE8eXTBFEAmXj7W?=
 =?iso-8859-1?Q?muwwsirWZuPALAFhqjAdSVmIs4syOUOI+EZiJegxY29XFzJRW7LTyq0/7G?=
 =?iso-8859-1?Q?L336SoWQepMQTjuuaJ4+y0d7UtNCno2mctX0lgMO6Q5gqjI5G2A8i4wrnj?=
 =?iso-8859-1?Q?TRjcMQgUBuXenSOA2e9NHTai2wa2ewskLlJxK2ZUXtYKVvGYaL2odLlK+Y?=
 =?iso-8859-1?Q?d+Whi8n1wrjSun5OddScFZUGdvXQLir7Z3kDjiCkn5XuCwICT0vWW3Qaon?=
 =?iso-8859-1?Q?x8K2h3zF8nwbpI+GrTpaj7skA/FbEqqCbsjfr+EU/Dd5nT9p5xItdSLBSM?=
 =?iso-8859-1?Q?unqtryQfLBKBkl366Po9iFncm6ffXK/5sdCpk2gKwRZiaApZr591cQcNhY?=
 =?iso-8859-1?Q?qYs6P5e8URnriqLvP3xuz+OfaVCb6Nq84uJ0EUwExxDIDT9C8/vZp34Isr?=
 =?iso-8859-1?Q?FGdHZUqou4HFvSjkE+rPPR4BOa+Fd1u0BrtMvOPkc+4yf6FdbF1jk1W8mf?=
 =?iso-8859-1?Q?n70apdZsT8i2HYjwOwgb3IBwCmZWVgZWnXcSkSrIFBPXVMATRICVN0m/P8?=
 =?iso-8859-1?Q?sGV1+GqRUCwBaQ9Xzl3fds/tybZqa5+VlVc53xtodhGkTcWRtOh2GD3k3M?=
 =?iso-8859-1?Q?fv1ZowgWnW0mGLlE5T5Vz967WDzNBhwBu005C9gHa5YF9HNJ/t0ZOGJ06n?=
 =?iso-8859-1?Q?v9x4utCDFgkxqmnhhOd53But5WAX95Zr1T4jGD7iFGMG608qiaYiEVsvCv?=
 =?iso-8859-1?Q?digW1v+yY1EYqUJChP8BMkEAxtbivb25UNqyUeohx6H5LPNbpWFCn7yUo+?=
 =?iso-8859-1?Q?5EERxb3ARewyxyqNp6oXrTZK+JD8L9ub2YnwK/872VL3uf68kNCCF/IeWd?=
 =?iso-8859-1?Q?Ma1whidabEF3j5u8Ijopv+JAxzFAhAt6ta7V0M8+nD7/Dx6P6LfvLBJxte?=
 =?iso-8859-1?Q?WX8TM9bRc0OIsKe2EjrxY2rO1EIRA3qM5h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i4OZ2lILALSWq1TGrI02RXxTnugDQIBb4hi+nuCVTuseGjrYkgKgt/di7MT9Zqfm2++5k51m/5z2KTg7HgPErTVKVC6qu9hn54ujH1eyknRDcslYUoNieIBH+Avh91diaVmAJvCxXnfXnDRFbzJI6l0T4FfC8MRaXNrAs+QK8vHH3wsn1iu+uXrJvEq14+9Ycs0t8VTl/dOvBuGdOmYXRX+pRGmZssEDqXpjCdsir2iqf58WmzcGX4ZJ9ejoOjLW/Ey62VT+6GrZgK5yqc1YmVi1Krv8EY6GFHMB/GWHP4yJ+UBqd42o7PN3r8Ra01C+GqoiWux9scewF/CiTNf3wy/GQPbA28qwwqcrqc8DGOmGMv+X0rWFfEDMSXgoHAbkcortQnURWFd11iQuf30uiSi7tYcbjVUcbmq6HogpbWiBC+bqC0+ulnhRrca/V6PNHPZ6/6PNxDPRelbn70IOq9OSUceUdeolYk15UEvbhf2mkuHiUC5OnEmUfiroxCSdi5DGJBlCSniJew6AaTFDueAQ05qxxnnQSqYd+HbJg+BNzfnlq8lSHZktb9XCOKJndb1XZCaF+0LEGCjQ4fSkF7NW0UTUtXFeLTHTOdUs7UA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff8d773-1baa-46f5-7d1f-08dcd4085ed8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:25:59.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcFYAJw/pq2MkiGO71VxikhBhh7XRgaqvqN6Xo1WDA6YqbSn2+tUBnSV8tr1h4kY7227/ska22lwAx6m83Fn9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=859 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130108
X-Proofpoint-GUID: kLGRd590mySs6aDBs0_H8D845sRyCzd7
X-Proofpoint-ORIG-GUID: kLGRd590mySs6aDBs0_H8D845sRyCzd7

On Fri, Sep 13, 2024 at 09:03:00AM +1000, NeilBrown wrote:
> On Fri, 13 Sep 2024, Pali Rohár wrote:
> > On Friday 13 September 2024 08:26:02 NeilBrown wrote:
> > > On Fri, 13 Sep 2024, Pali Rohár wrote:
> > > > NFSv4 server option nfs4_disable_idmapping says that it turn off server's
> > > > NFSv4 idmapping when using 'sec=sys'. But it also turns idmapping off also
> > > > for 'sec=none'.
> > > > 
> > > > NFSv4 client option nfs4_disable_idmapping says same thing and really it
> > > > turns the NFSv4 idmapping only for 'sec=sys'.
> > > > 
> > > > Fix the NFSv4 server option nfs4_disable_idmapping to turn off idmapping
> > > > only for 'sec=sys'. This aligns the server nfs4_disable_idmapping option
> > > > with its description and also aligns behavior with the client option.
> > > 
> > > Why do you think this is the right approach?
> > 
> > I thought it because client has same configuration option, client is
> > already doing it, client documentation says it and also server
> > documentation says it. I just saw too many pieces which agreed on it and
> > just server implementation did not follow it.
> > 
> > And to make mapping usable, both sides (client and server) have to agree
> > on the configuration.
> > 
> > So instead of changing also client and client's documentation it is
> > easier to just fix the server.
> > 
> > > If the documentation says "turn off when sec=sys" and the implementation
> > > does "turn off when sec=sys or sec=none" then I agree that something
> > > needs to be fixed.  I would suggest that the documentation should be
> > > fixed.
> > > 
> > > From the perspective of id mapping, sec=none is similar to sec=sys.
> > 
> > It is similar, but quite different. With sec=sys client sends its uid
> > and list of gids in every (RPC) packet and server authenticate client
> > (and do mapping) based on it. With sec=none client does not send any uid
> > or gid. So mostly uid/gid form is tight to sec=sys.
> > 
> 
> With sec=none I don't think that any mapping makes sense except to map
> all uids and gids to "none" or similar.

I tend to agree that "sec=none" on the server should be akin to
squashing all RPC users to the local "nobody" identity. But I
haven't looked closely at NFSD's implementation of this security
flavor.


> The documented purpose of nfs4_disable_idmapping is to "ease migration
> from NFSv2/v3".  That suggests that where relevant it should behave
> mostly like v2/v3.
> 
> I don't feel strongly about this.  You appear to be actually using
> AUTH_NONE authentication.  What behaviour would work best for your
> use-case, and why?

Or to ask another way, what isn't working for you, exactly?

The problem statement above says "The server doesn't work like the
client" but does not explain why that's a problem.

-- 
Chuck Lever

