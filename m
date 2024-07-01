Return-Path: <linux-nfs+bounces-4496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D360991E309
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 16:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B981C216CD
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2116CD0E;
	Mon,  1 Jul 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wam1XYe4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aOYqBYJQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF1984DE9
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845898; cv=fail; b=eXpjlbuAZMNj2TjSmh+eHLEF0O6VCPLMcL8cliPg5CWALcZFpVLTExJT5HDhD0mheLP2VSNnxeLK5f7MhP85D/xpz6XOH2223nHaXPWCf4D+bOSLoX+kFXRlFtkybc44FM+UO+PPdft9s3H2LAA2+uwhQvorGLMntpvqG9fQqIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845898; c=relaxed/simple;
	bh=mjn+w72UPbhbBE36QTCw5wLYdeYwqe2O4f0zkoXDwj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bdWv7+NMcqzz3dGv+NM/ZQwgs6rFXmtwajowYNysIRsJMDRv8vDm6t3mu6EeRQfoCXw+Om9aLiGefwVoFkWPxcXovMaeT9s/ceU45DrHh91Cr7hYoFs6N8uFpi4qwS5V6nQsLeMBKlCPChMMEknlP4tsyG2t4f/OJbqynod+WQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wam1XYe4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aOYqBYJQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461Eql4I019910;
	Mon, 1 Jul 2024 14:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=5k0nOC1T64RWmzu
	9E2hx5r5WrciSm7n7YvrHFLa4EKI=; b=Wam1XYe4wYRytLQZLwRZDL1KzqQFpAC
	c6WBM3JNp6IM/s/l4COniv0IjJmcvMzkNObfXD2Qud0QiBfldyQ+3Tuz2Vst+6RM
	QWVp07V/VNp7XKioiuwHguBCuSfkRrMpTFRRXGf74Xkc5gqZLab3Px828Gtq/A4M
	2+LgXtoratcjFqJXXf9qVhcdef5GQ1V1QGfsxxy6FV4Lz+k+wqhzufPK6a0bag/G
	/gMkAH5ViWLuz0+mECKV+p/28fBAfD/8a7ESI4rzQQKcwUSiQaB8Ez2OSXcelr5F
	jF5fVqCddMItJX+qTU7SXAEuR6887eZiLo6BWNx2MyYwpEvTrtIJnJA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402922u3qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 14:58:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 461DgTI2018963;
	Mon, 1 Jul 2024 14:57:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qcwb16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 14:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQ/ihZ8ZnFRBkyt/6HuazoqpZbZq2UUljrHmr7rBb9k0HVOkKqREglPsgF4dtdlxUOMUahzYGxNJymAkZGmD30GJp902Ndj+sRGf0Tk/ulTiCWhREJw6FCaQBzQep3SVc1EZJ0h42R6Rp+UldVanvKAg4+/xQcNv/I9rorhf+QeDluBPIJQIYRygZVBRWU5f8Q0apOmhnJy7sHsmOMtHr4q+/h5CgbAqxNpzYG50u/jVEeP1zcLHy42ESRL/YWTsF6184Xm1b/FGzxrJpAlsP8Zs0CulLSvx6W473SDSy2k/xxqY0kevM6aXJdfCeQt1tc+3c06d2o13TWldFUZ/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k0nOC1T64RWmzu9E2hx5r5WrciSm7n7YvrHFLa4EKI=;
 b=LCgbhBuooh5Ot7rSUOa79WhysYHtFqpjSzctbdtFmsv4GpVBPq3XrY7vFSyMlsKHOYYVhnmf9+GmMveHhZ5K3D7+eMZ8gZgjeR/OIvStM5S5k0rXJXxxY47ln3iqjNyY5bjZ2nfZj+Q1NKdk1sZ1/Jf4SkDYw6RfMbVH3Dn6EWrbcgVj7ztH2mO5trnnipwY3KS1OBXUP4Ja+iUwxs4NhNyccAkUJZFUeANV5tNZmManjpJKHcAmkw10pJSsxsIVpQFneME6ZR8U+mDlqbuqUT3U6nl4Icn++zpj8U43APW9FGdOyE+S53EeCysHKI9B1BZNA5juu1O9T7f5bDzCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k0nOC1T64RWmzu9E2hx5r5WrciSm7n7YvrHFLa4EKI=;
 b=aOYqBYJQ0+YweToCiQLvaoXo4LKShpMAJv/aE6HfU8r9V1k8xdAtB6P3/Y0pIaOaDDkr7/wDSOH2S68ts4ydqaIRXwO+kS+ihZ7Vl+KjcdI3aLqg4w8VV5+Mj4p6mGaeUoUr3R2Sy7Ye14azuKxAr+i8xmY6LyS6qj60UGn6/jo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 14:57:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 14:57:51 +0000
Date: Mon, 1 Jul 2024 10:57:48 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 3/6] nfsd: pass nfs_vers explicitly to __fh_verify()
Message-ID: <ZoLD7PDMsNh9uoWP@tissot.1015granger.net>
References: <20240701025802.22985-1-neilb@suse.de>
 <20240701025802.22985-4-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701025802.22985-4-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:610:11a::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 513e3286-40ad-4ed1-6354-08dc99de2e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?upHAGODAUG6f/1Y/EaqzL4j3r5xlUVEleEH+pAbw71xKAmDcPOt8JEFc3HQF?=
 =?us-ascii?Q?MUuwVXbCi6F6AZhuOoMw8Amw/7zthpvx5ZDiYFUpyz6n2IQ/7bv9KtjQYOtf?=
 =?us-ascii?Q?DE5nisco5LlSHCmiLgoG3+FKFi8RZpETW90mekuWR2Vty9PyBlzsatLIR9s9?=
 =?us-ascii?Q?AE0xnm/OFLgJ0oHDWf7DF5Mz2YiFiJPvD2Ef6AqLFxZb4x7fJHuXu/i9hSHE?=
 =?us-ascii?Q?2fUZxpWaiSP+y1GsZByHd4soVw9k9tTcxlo2cAQiT/Rvd+GgPuzWXoa5c6rV?=
 =?us-ascii?Q?22Z/FP+k4/kX/KSsq5Nd6HqiaKS++wfNKqQ9pM+K6OjZZFVOhG0xnG7a5ijk?=
 =?us-ascii?Q?Bmvv4bSgLc0BIbmkRYmGEfSIszlkteeCTFPFN9ylG85Ed9CTTEr1y+uEo5p7?=
 =?us-ascii?Q?PJ+S3XTQJZEFPGwj23YH+AZeuFQLiNQqDz0rjqd9+HSXneBENURhIH2izoJO?=
 =?us-ascii?Q?16QJAa2P+K0fv3gJAcuIb0LDtSCdIv7tLzoKn6/IFuNOWIvfxXJMmeNfa0vn?=
 =?us-ascii?Q?wMZlKHgnx1jCdwepiZRJn7jNSzkJLwbWhAy9n7A0+eO177RXMiU8RGjAJNUK?=
 =?us-ascii?Q?VR+LCtEBTVZzKJTgyu4q2DfTR2+nIzrgbqntU+zcdh190FZCcnXk8W+0MCxk?=
 =?us-ascii?Q?++QSlcsIvoHcP+qxUcRNLVKZ185NG+PrQBbdZQcwgPtZwS2z9jhH5LYhRBqx?=
 =?us-ascii?Q?YTPWV86521YtzCCxsn85sdkZy+2ACNjoAjtDOD+AcJ3s4gqBviVFwCo6P3nN?=
 =?us-ascii?Q?8FuCoVOQsljXyjgzeMenwpZE/59zjJeLWLifgBKo1aA8m6L0lfegWlRd/7Dl?=
 =?us-ascii?Q?JNwT4U2wfJGu2fi7a9TiH7lUwb4RL3xqEpssb1uZrbXlYLW5BnQsKsDFsW8S?=
 =?us-ascii?Q?oa38ugLDZk1xuLAsX2gT1ngMmaWztMddv0loOJNWEjcXqePZqUBTcjFTIgdC?=
 =?us-ascii?Q?NgVfdIWMIPqYYKDhtik+c5jFe2vo2R8nW2XbmX1HOLQZP6rlfDOF2v8/nxV1?=
 =?us-ascii?Q?eh9PRiUJm6pO8BDqW6hfkq14kgWMMgnYe3YWBRwWrSHS3AcTp4gIUqwbGpWZ?=
 =?us-ascii?Q?HEqm1ML6iHtPGzvWYX9miwG6I9HJHH8kQr2GBxZMXurYADpDaX24yckbzxyh?=
 =?us-ascii?Q?fB59h4RRZKjkujnsu4o2qHwz3yHiNXnRzlr19Q52zk5IjzRvQB/HVzIE3DDl?=
 =?us-ascii?Q?73/rvWtINwhhpcS8Wr0nUAH0QKZKJvtCvCHUgHXA4MEZQHtiQJi026HnwKyI?=
 =?us-ascii?Q?aoNd4KXXA4s9PDFjGWh99cekvjmIsPbJX387i+H7Ln3WjEXosvqOzZCwajLp?=
 =?us-ascii?Q?TWW3FPgMTaKjkw7bmiBwRlJd/DwkGlmtiE0a02vpzqGm4A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1YEDl3S4gnwiwu0wL72uZWu+uEz3RzwESEkOQ8Kw58NiLkjrKLNs3eMj6M+X?=
 =?us-ascii?Q?FkN4vPR9dDwAh2TNzG5Uhd5HbIx2qtY20Ej/6+ea7itrUUt7gEprdpzmBBqx?=
 =?us-ascii?Q?wbhPWZUxrb/Nwt8Uvj7Ze9bmuoYyKQhs1ae0hiNNm3g3+imaG3jsBRMRXYVT?=
 =?us-ascii?Q?rdzLEGHD12NaumxwEeA5E/h1AIQRuUKyIH8+N9OZTVPnQlPlr/9bgjhZ/qo4?=
 =?us-ascii?Q?GRVSJaFznepfogGVnBzFAKwZsa+VsOlyIq7NrDf4h8785DdUg+wveHOBByFB?=
 =?us-ascii?Q?T+ai3AT8Pe3VKfmBOs+hg4GdEF+PkjircW9+x9afi1u7aGBA2W9wfDELzLIq?=
 =?us-ascii?Q?Na6qE2TKLB8r9EhvoFYiT8n5v4mZ4bXwBP3AfDcF7As0km7r0mwIxlFlDPT/?=
 =?us-ascii?Q?wOV48ocUFA5rP3Qe7ul/FJXEbfMTVRzicCiKPsf9kXPIZkXYPWqt6Dfb9glP?=
 =?us-ascii?Q?LARss0SxiHiNx+JMxWML7FoUzP9a3kyEkyCvShNyI1e9hi6Qcpxi0/TYbMm/?=
 =?us-ascii?Q?ztOOmjL9sFTRBkPh/qq/j4lFa80FvPXf82Px/lYMsD1TIi2mzal12Y58RMAi?=
 =?us-ascii?Q?GgpW5vfQ/mTu/0PAKBaf0P7/WT6KBClcySHsmFu8QFJZvCuPtLTt/thz3l5i?=
 =?us-ascii?Q?w8WPhSBCEOBLW4h0pNg6dRaOBNGZoBHHxodRtRVTbefI/68n+chjbJ6A0/f/?=
 =?us-ascii?Q?R5orDG13SdjwbN/BKHc5x6PELNWAgskOFfLIv8DC+Y9t2m0D3dTtEXw87/GA?=
 =?us-ascii?Q?wT4UZKDEqhJMn2oW8KuNE2ErYl8omiAaMkVc+XG952EQ5vZsEShYoiye22Sn?=
 =?us-ascii?Q?xR5LtGvj/KRf4SqOQf2f9//xfaQEYO3N6R5eJYSSxEGom3nUzX3R7hovgI5B?=
 =?us-ascii?Q?ou4vuTl/iQtyixXOBaCuOjNwhMlsfzfsZYsBTryt5uOTxluUffsTwbugoPn7?=
 =?us-ascii?Q?MHrp1VTcHYwb0KZ7/Dw53uwh7lTXpaxk/dd7zyVIbla8uwnE8Upu+zZ5ZFzj?=
 =?us-ascii?Q?VnIzZEOeGCmBAVNUfgfW1XwvHjnVs1zLk/clePx7SnnbmabW5I79eha+MZIj?=
 =?us-ascii?Q?tKO+OwGsEtJK0AWBpY0yE/PhNgX/6JJf5ZRpMpkuQWzD1GgkM6+RP910Vy8t?=
 =?us-ascii?Q?jFmNdD+MfUj1QDMA1V8Vhf1cTfKLaOSJWoVJmZSG0xxn43Se/lshjQc3kO/X?=
 =?us-ascii?Q?AD4E7hJhzrys1X01/jDHLI+OmhrfcOJVIbwlHwTU1/52soG0Ob7bA+PwAfrL?=
 =?us-ascii?Q?h9WGhyVgywf+NWU+QEQYX+51NpbQUZkdHXB2Lag9gVnydeSFBkm/IDP0Vd3Y?=
 =?us-ascii?Q?2Asyw1Q/9BIE2tK2pdWsZ2bWh2nhcXy19RaTaohbw+ApVOuwkazGl5PBhZfM?=
 =?us-ascii?Q?H/6YvV+CNWb8OYgN7kNT39ahETLWe9d12VJjPEs19jgyG58OKpQd3dRI5T5L?=
 =?us-ascii?Q?n+G3Ea5Ru1O20peajLUbtLmhd7kO7iIWh4NXDrxqD63DtLL+ZnwC7gYuv7Xk?=
 =?us-ascii?Q?ix0UL+VsiyVtXtdrn3AJpMCNJ2gD6uoyZ/JHuv96iDOnNpJ5NenuGi9IMoe+?=
 =?us-ascii?Q?wdL3aRfTg0/hGBxhRpsBmDHhkGvJg9QpD6UkITkY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Cw9HEJfTC/7thS77lQ/HbdX0CSRW9L1GZ0GmeHPseAjfA74TLOnnI9wa4Cuv4UUS+cR8f1GlnV8JqwKontfQeHT/b3ZbXkQd0ScZ5WLdpDbBbHmF2OWDwKnjLSdLJrUgUQnYEJClCbt5HM0Qbve3FFeenLai+2lWvf/gHlvTaqyqPlCzr7MZ1vn1xcoj51v0+hD7vTfRn/e6lre16O/I8qIbl0ThsqgSHIoHeQgrnHoThpohajLzwJ/hmQemMn0oeKRwYE1OAvryBv+IHAlmSqe7Ey5HOls6FMFgkYISfKPblQQwwhxdmWQ/pYEnDg6qGHdwnhPqn0NCFSdF0CEFdJOvFT2OqVXtrpWUC0mkx4diB4aY5HBQVwdd/tLZkaB+cu+ZQPZ5PKQO59ivhqO9qNUm9fjcTMwjixXDfW+BxL9Awt4yvDpzc31uK2cDAsnfl5sNIcsEopOVGQoAWwRWB39CYtiNXQ/a0wKgh5jtiHwEfmCtEbh3w9UOfxtE9bivOyrVerOFMzla3CYXQWixinrJ3FcvwOuMEh4tVWKQYi7lumcsL9hkYxlrhoNAlxWhb2TGwPJkJxJI3JUHXVGUw8k/Bs7gDYipeVLWffP560w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513e3286-40ad-4ed1-6354-08dc99de2e0e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 14:57:51.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkM9PpEUOxQmnBnkKio9xLhjEaishGU3wK9bMR/ZDgKUL3dUyEJszs88KfjelA56k97EOyzKRFgwM8TV0eBqqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=986 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010115
X-Proofpoint-GUID: _yNEuvzKHHKGIWmnHoZMuSf5d3o7ATlZ
X-Proofpoint-ORIG-GUID: _yNEuvzKHHKGIWmnHoZMuSf5d3o7ATlZ

On Mon, Jul 01, 2024 at 12:53:18PM +1000, NeilBrown wrote:
> Rather then depending on rqstp->rq_vers to determine nfs version, pass
> it in explicitly.  This removes another dependency on rqstp and ensures
> the correct version is checked.  The rqstp can be for an NLM request and
> while some code tests that, other code does not.

This is my only other major quibble with this series, which
otherwise looks like it will shape up to be a nice set of clean-ups.

I'd rather avoid having program- and version-specific logic in these
utilities. It makes it a little more difficult for us to shave out
support for older NFS versions using Kconfig options, for example.

Have you thought of any alternatives to passing an "RPC version"
argument? I will also ponder.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsfh.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 760684fa4b50..adc731bb171e 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -62,7 +62,7 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
>   * the write call).
>   */
>  static inline __be32
> -nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
> +nfsd_mode_check(int nfs_vers, struct dentry *dentry,
>  		umode_t requested)
>  {
>  	umode_t mode = d_inode(dentry)->i_mode & S_IFMT;
> @@ -80,7 +80,7 @@ nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
>  	 * v4 has an error more specific than err_notdir which we should
>  	 * return in preference to err_notdir:
>  	 */
> -	if (rqstp->rq_vers == 4 && mode == S_IFLNK)
> +	if (nfs_vers == 4 && mode == S_IFLNK)
>  		return nfserr_symlink;
>  	if (requested == S_IFDIR)
>  		return nfserr_notdir;
> @@ -117,8 +117,9 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
>  	return nfserrno(nfsd_setuser(cred, exp));
>  }
>  
> -static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
> -	struct dentry *dentry, struct svc_export *exp)
> +static inline __be32 check_pseudo_root(int nfs_vers,
> +				       struct dentry *dentry,
> +				       struct svc_export *exp)
>  {
>  	if (!(exp->ex_flags & NFSEXP_V4ROOT))
>  		return nfs_ok;
> @@ -128,7 +129,7 @@ static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
>  	 * in v4-specific code, in which case v2/v3 clients could bypass
>  	 * them.
>  	 */
> -	if (!nfsd_v4client(rqstp))
> +	if (nfs_vers != 4)
>  		return nfserr_stale;
>  	/*
>  	 * We're exposing only the directories and symlinks that have to be
> @@ -153,7 +154,7 @@ static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
>   * fh_dentry.
>   */
>  static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
> -				 struct svc_cred *cred,
> +				 struct svc_cred *cred, int nfs_vers,
>  				 struct svc_fh *fhp)
>  {
>  	struct knfsd_fh	*fh = &fhp->fh_handle;
> @@ -166,9 +167,9 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
>  	__be32 error;
>  
>  	error = nfserr_stale;
> -	if (rqstp->rq_vers > 2)
> +	if (nfs_vers > 2)
>  		error = nfserr_badhandle;
> -	if (rqstp->rq_vers == 4 && fh->fh_size == 0)
> +	if (nfs_vers == 4 && fh->fh_size == 0)
>  		return nfserr_nofilehandle;
>  
>  	if (fh->fh_version != 1)
> @@ -241,7 +242,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
>  	 * Look up the dentry using the NFS file handle.
>  	 */
>  	error = nfserr_stale;
> -	if (rqstp->rq_vers > 2)
> +	if (nfs_vers > 2)
>  		error = nfserr_badhandle;
>  
>  	fileid_type = fh->fh_fileid_type;
> @@ -281,7 +282,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
>  	fhp->fh_dentry = dentry;
>  	fhp->fh_export = exp;
>  
> -	switch (rqstp->rq_vers) {
> +	switch (nfs_vers) {
>  	case 4:
>  		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
>  			fhp->fh_no_atomic_attr = true;
> @@ -330,6 +331,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
>  static __be32
>  __fh_verify(struct svc_rqst *rqstp,
>  	    struct nfsd_net *nn, struct svc_cred *cred,
> +	    int nfs_vers,
>  	    struct svc_fh *fhp, umode_t type, int access)
>  {
>  	struct svc_export *exp = NULL;
> @@ -337,7 +339,7 @@ __fh_verify(struct svc_rqst *rqstp,
>  	__be32		error;
>  
>  	if (!fhp->fh_dentry) {
> -		error = nfsd_set_fh_dentry(rqstp, nn, cred, fhp);
> +		error = nfsd_set_fh_dentry(rqstp, nn, cred, nfs_vers, fhp);
>  		if (error)
>  			goto out;
>  	}
> @@ -362,7 +364,7 @@ __fh_verify(struct svc_rqst *rqstp,
>  	 *	  (for example, if different id-squashing options are in
>  	 *	  effect on the new filesystem).
>  	 */
> -	error = check_pseudo_root(rqstp, dentry, exp);
> +	error = check_pseudo_root(nfs_vers, dentry, exp);
>  	if (error)
>  		goto out;
>  
> @@ -370,7 +372,7 @@ __fh_verify(struct svc_rqst *rqstp,
>  	if (error)
>  		goto out;
>  
> -	error = nfsd_mode_check(rqstp, dentry, type);
> +	error = nfsd_mode_check(nfs_vers, dentry, type);
>  	if (error)
>  		goto out;
>  
> @@ -407,12 +409,16 @@ __fh_verify(struct svc_rqst *rqstp,
>  __be32
>  fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  {
> +	int nfs_vers;
> +	if (rqstp->rq_prog == NFS_PROGRAM)
> +		nfs_vers = rqstp->rq_vers;
> +	else /* must be NLM */
> +		nfs_vers = rqstp->rq_vers == 4 ? 3 : 2;
>  	return __fh_verify(rqstp, net_generic(SVC_NET(rqstp), nfsd_net_id),
> -			   &rqstp->rq_cred,
> +			   &rqstp->rq_cred, nfs_vers,
>  			   fhp, type, access);
>  }
>  
> -
>  /*
>   * Compose a file handle for an NFS reply.
>   *
> -- 
> 2.44.0
> 

-- 
Chuck Lever

