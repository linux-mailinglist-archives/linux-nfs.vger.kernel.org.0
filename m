Return-Path: <linux-nfs+bounces-6954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92B7995749
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 20:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E35C282FCA
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0B212D3C;
	Tue,  8 Oct 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wj4d/T2i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jf6qXjmi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451E1E0DBC;
	Tue,  8 Oct 2024 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413892; cv=fail; b=uOgz3CzVrXsPd+TOBBJKxSv18BdhwYmAnSrwGJ90TtTYtFuOvZbXaTYVjYGKbo0DaO6qihlZeirfYfDTPfNfBacgqq/Hs16Gq6I/FO7jAwHRdDrsjteY1UdIsJXQFNwrHKE2jAQo3VdYNUAxqKM6uMmNwq7Ud2wma1GPLZkvFI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413892; c=relaxed/simple;
	bh=PZe7MvCRWB85bvBorqcDTQ7S/BP7rCVoc80b8Dcpeb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CvKt4GYWEW1ZCUNSq8epVNSB12YLlJImEav37ZlysT7Zvgaz/zrp+/cdfJrR0+hy3wxVYmdfZcgHmNpJs8iItAFqM2+O97tXfemuwETfbsqIjYqIbDDgyom5fs99nVavji+rMMksLSVz3enypki/sdAnA9AbSgMWEUJgwXzWQlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wj4d/T2i; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jf6qXjmi reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498IXbfR018100;
	Tue, 8 Oct 2024 18:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ytJ1iMxHdm8HLlooL4T6Ow1fdqVIE9G6M1qPYAsmEpM=; b=
	Wj4d/T2ibzbVZa0Z0ELy8lPgt0wnhSJ4AdXFxRn22OfgmdX2i7kSvbXOCmqEoNlE
	s4KPFcw03rlqDBhad/nAuDlH0urHJvC01zKlE773Jdu0MRLu1jJBHYvMW2tnFxo5
	NAAc3dcWYFK7cBbiT4jHtXFAVtpsQMP0Iz1kXpqPe2Imd31jfdkwBRN4YGucY2AM
	m12aMekhx8MBHfcsVrNG8rG/nsrFR5Eaeo9Ea4sNg3Q6j44zuHwfILrDBLHFheKL
	nttaQjfay1RAoI99VwJEJfhOPI9o0f3IqK27gYYb2OH2vbtf4+RIS/jApmbObR7d
	BQ91ujLhRe1B9tLY8eOdqw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034ptcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 18:58:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498H91wA022940;
	Tue, 8 Oct 2024 18:58:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw7ka5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 18:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eP+0OFQji4bV8Rl2v2Vu8vTjLI0NCG+Gkc+I2b+cvUq3Kh2AkixDd1o6+ImzfTopP9rA6k6ZbiBpTD4bNZ/gHjtI192/sS6CDzUGnVTpHe1h1r/rSvdtyQomlrsoL2A1gGshs7b57QDXPCVY++V2leCs548iB9+jRYPi66DtLXzq6U3jXOgIrQTtx8BFpSBkbVm9v1OSzHPgi/JYZVLaMvvVLs0uJWH9M9ESsSsjOjm9fPReFoKdDpjMG5YjwfnGfUxw4jFLB0pM9joH2XapsX0DEfNl9cwV8KDjkLE/AkbMbr8cQr3jzfOqIcfGzbPkZ44MgvVveaI53toyBX+yZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On0YdiiDn42R96zRGc+HAF1FgPFEyzUlL+WEu+i7MSg=;
 b=ROAAacb5IrnAS8BBOz/PVuUSfJy4ZFaFWa5szwVEOc5f+g4Ff1q6Wxwyvx/BrShqpyqF+M5xhFiiyRzyp/V1rCWCwTnFug9CgZc1NqQIvrlG8mj4g8w6eoS5b973ijrv4jEve5RbdHvune6pxSafUZYqQ3SAo1mSF2H1OHil4ZYie9xeamtmZXuIAbBXZaPX0rteUxjguj18zER93bP/mRQPFNFoZK4jM/R8GVB4gXS2n7t0vJMXfxMBj/+PRIUaagH1s/SiTbvtE7GygRxAHMFR3t3OMihC7COy5FlVAitCXgBZecnravTZ6HQ6QeVhOxLhqCnHhdITAA6BUA7cXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On0YdiiDn42R96zRGc+HAF1FgPFEyzUlL+WEu+i7MSg=;
 b=jf6qXjmiCwBlhbQQEU7iVOWt8/D+9My3YIvTl54dzQQRrs83xNQ/syL+Bp1p4Yd4QC0jBE1+gS7q4SY2gXZGyn/mAvtaseGUBktF1AawZr7pfKJts3KY7PNXqlHrvP3NIksMhh2ejHQsPDgmyTQx+dBvp8wMNCz0gR2RWb75lM8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6831.namprd10.prod.outlook.com (2603:10b6:208:425::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 18:57:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 18:57:55 +0000
Date: Tue, 8 Oct 2024 14:57:51 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Message-ID: <ZwWArwU0XO8Y+Ctb@tissot.1015granger.net>
References: <>
 <ZwLN6RtYwVIkUfaL@tissot.1015granger.net>
 <172825279728.1692160.16291277027217742776@noble.neil.brown.name>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172825279728.1692160.16291277027217742776@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:610:76::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: d39a6c22-dfef-4c9e-a40f-08dce7cb1dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?w7ZkdFy2Qd6r0ZkNIIoSaYwL7FLxhdSoSum3WWwwb4QFnRgqR2vKkrA6Ya?=
 =?iso-8859-1?Q?MLItZo8OrbA17Yty1jXB55SKz6b71/WTTXTu93VA0wxWbrDExOHK9cmuyf?=
 =?iso-8859-1?Q?krlTFzfo57bwj+3tb0FuwFhAubb5SJh+Q2ElGpBlhyFRAabW7UpMdOrn59?=
 =?iso-8859-1?Q?+zqgx40gdthuuw/NvvGfv9SogP0JUnRzLxM5FjlSgfvg4r/cqsYMlAQAHV?=
 =?iso-8859-1?Q?xDpuU1HhUUcEEXUo/W43EUv0AnEZTt4pF842EEg4/m+tV4TXmAwNM4qlsR?=
 =?iso-8859-1?Q?/j4QV1L1rze2cO4zYLnTZ594TH+7U8m2NVJeiPx4m4O/aQ1AIt8ERPj9np?=
 =?iso-8859-1?Q?PXlZX25Z/xdVqL/SdtwUuwPAas1FONu5PMswMnNXsmwU52xE2cct3hMeA0?=
 =?iso-8859-1?Q?kcV/Lo3g6/bqP7v6DeWH/a99qqNloe5DlBQiwqpZDVif1VcxZnDWL8L8zo?=
 =?iso-8859-1?Q?wfYw6y31J+Lxw1h/bGmhuhn6sZG9q9+pG7pwBJTZxT4/k5AhlmqMhxHm0Z?=
 =?iso-8859-1?Q?jRGS/WNQq+8kjkEw5QA8BlDweGykDuKGg1Zs7IB0NhHKQyykl6C0p+YF7W?=
 =?iso-8859-1?Q?ZSGNWi/SCcyDQAu3E8rsC/nX91zh0XHWABUDLSE9WEUyc89bxAIIGmVgal?=
 =?iso-8859-1?Q?S5i2tcx2ZmHVnX2GeXzIW0lxgyLQsnF+w48Bqi5KH8PNUrte3Ao1nu8ToW?=
 =?iso-8859-1?Q?p9+7NENCdbghyRs2RstJa2E1+QUXV6Jll/Lgi3p0ATKdX0odOSctqnN7e5?=
 =?iso-8859-1?Q?bCLwkkp7LUSNZ953KYoix7Alis/wHKUHGlSriMAuk5ohWUlyj7uEDWEJ1u?=
 =?iso-8859-1?Q?SjtuN2KmF6Z8WK5U3VltuHBAdSB6jLmwkIC7cs9Wwms6roaOVZZdWi3GPX?=
 =?iso-8859-1?Q?xddTdDupOeh1KM3HYOkUb1lJtalYSbNovniYqU6ZIm4bUhilCxSJcu/86I?=
 =?iso-8859-1?Q?YNLYPUwquOUdcSFsu8xE+TLSWBC35gfIs0+GQ5gCircfxZQW8oNLGydXlH?=
 =?iso-8859-1?Q?kUHRtWlkkXM1Nskxr5o0n3jwZG8wkxezz0DAj/nOElGo6yddK8f6ayZFbf?=
 =?iso-8859-1?Q?KcDJqltWBebKe4E9ImF5EBNZHqenicH4qIlEoYqADFysuXt67teioFqECT?=
 =?iso-8859-1?Q?qByP0p/4w8GA82EApj7TPDlaVdRkE0ApnlMTc7biNX1KroRCocHH2r0A6+?=
 =?iso-8859-1?Q?V3QFuH0ty98CEku6jW41CWejpVuE8X2LMaS4l0YJ4MAJyuk3olcdh/iRyT?=
 =?iso-8859-1?Q?Pq04t3D2d2QG9DwKttv+Xc8MXYYKTZmz4NpWGVIHpSCDMwUFQnoz2sfXR0?=
 =?iso-8859-1?Q?gRQant5FhMHPIk6pBZR6hjVB8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?13tzivqdIiLD4lhy/PX/QpyLwoFZPOFsIDZvRRIFf7FfSLozIXWUTpVqsk?=
 =?iso-8859-1?Q?n1N/qsroMgQr/OtBwxb8D5BdZX8ghi9e67p9fF+mAgI1AoZdAei8u71f1+?=
 =?iso-8859-1?Q?iWlFIB9X7Pbt0Qn7bu8zkke3GIWzL7izfUDj6NLQE+FC5/oil2hKtrw2GB?=
 =?iso-8859-1?Q?OXPEjG5VhOTVTDi4fRzgaL1HyL2/Uvz37CYQ+OS61xriKCludIJqpiZw6S?=
 =?iso-8859-1?Q?LMXXiesF5AmYmHCHJuzaAPwzCU3nIgmps/XFva37Uf1JDxkth/04R+G2uA?=
 =?iso-8859-1?Q?yy6tL9VNxQaytVrSp8gcO9ArQwRapkJhd+yPPcxpw0EMkP5LIE2DHMiodw?=
 =?iso-8859-1?Q?wv5V8TNrYGK+6+iOPYExLhZ4tqAZRA5RNlSPt6M1j301HhOzoarl3BLO4c?=
 =?iso-8859-1?Q?fR3wAosF3dv84jLD1uaROR4ifrP64s2fG2TrtHwm7wfVMEbZOuZAustJGj?=
 =?iso-8859-1?Q?KgxcRt/OekBUzSrss67gNb3FDMGURGlV5yTbYiia1ocOihM/sv/d/yR3bC?=
 =?iso-8859-1?Q?F/a6muPJVwypITA8Poh6Zj67q1vr4aVq5siM2bQ32uP8BteaLSC9aWUW4Q?=
 =?iso-8859-1?Q?JDrttORM2rLvzbpyV6OvEcwnu3qWOWoMK83djKkLBHr7lBMwKexjGg2crQ?=
 =?iso-8859-1?Q?N5UUG62M4skw8cwaR1JkK73v7d97AQ28Tzw5M7CoLpRj14BmaR4iV5b6MC?=
 =?iso-8859-1?Q?j9kupGTt47KgdnMhXP+bHHpo6AOdyazdiqKrsIVNqdeRLu1iQm+wy69925?=
 =?iso-8859-1?Q?q3fzxMhLyBUx0Gw2tUM3f3w+f5FTFrn8ZUrt/CfTgqiCQDJfluObjLxONZ?=
 =?iso-8859-1?Q?O9CCtkz+l4cVb8sWob1Ysz/0y9X5pcs4rPdmqLh17Ju99MKUjFPpwXAdpD?=
 =?iso-8859-1?Q?FWilKeEovzB7vH+O1KNTHPfhme+RWoY1CI109JTqYNvBUSUXFgKRZvL438?=
 =?iso-8859-1?Q?6auSBYQ43ldSar8ZugSmKA+y6UcQlSkQQwoevkBYyQSE1TzAngQ7lx5Gdy?=
 =?iso-8859-1?Q?q8sGoiznTFfC60qCviQX2n5+RtaecTWMZ9NgpZHkvBagC7uCbAROXjMGDS?=
 =?iso-8859-1?Q?t308r17BrTDeENqFg6lctCpq5rBEKMftYhcM7NqOZWksUS7DKvAOHUZfdB?=
 =?iso-8859-1?Q?5aGxriW6KqgHCwR8aslTZM/IhPuGR+g9fg0Hm3+vlpOTKyHMWApZKFtCsf?=
 =?iso-8859-1?Q?h1DlYR7d4Fl0/PGF3Noiaw/6XHNbQOlXguT7NL/qOC8B1PFcyARiNJtPvB?=
 =?iso-8859-1?Q?fE/VTmNVG8cRBvDrUHVbHVd9J8D+D/cASC2FvNyr/OEJnqRXhPNQySk4/q?=
 =?iso-8859-1?Q?vBylGXIJXfAKnepN22RENHEGtoXsb+z3N1WS+IxHi5jsGZC7GP7WEOnN2M?=
 =?iso-8859-1?Q?JnNK28xnmQxNOgYetLo3NgQOxHB6xaRLl8/VspHMvSvXDq+EwBo/o/ac8K?=
 =?iso-8859-1?Q?YM+f2geFybCb3Hy2Lc5nm9kxLDolunUpJ81JARo/WR9vVKatpgJZ7DijCd?=
 =?iso-8859-1?Q?x9FOsB1Il6vlUhqMxPNhon+7VuWkkAHlhv+oAQbLL2Xu2Obo3JgHps1CSa?=
 =?iso-8859-1?Q?6vw6Rgu9RISs3/O0seiS6iD39pkfJ0wB9iuPVKGGGX2bXcJGxI2BbtmVml?=
 =?iso-8859-1?Q?jG11bEZ/R8xwcLORRWPA6052Rx5l6QuQwi1NrJefxzAK5p0Dj1DGkfXA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0CTI+02k4bWlHHTIvllV/jLSHua35s6T4KGAObp47NbCHmpTLe3onD9mdkGHPteHXYI36VI6inRrzqG1Z6wFGo8LUf/b0xcBTYCN701D7u7bDtNfSjdXczBCI3js3TTblrOemqfPk1zuYGsJ+rbL8I9WqN7lGaa1Cj+Ci/SbWVKkyaa490oeRtpKqnBEAwKuVs7/wyvUyNiJyEreujsh1FkvFWkqqd/q0kNvLOMUYEoKG6JVdioIuiEGGv9H5K4yHLMlmIiAkC3iE8nDNPGDjZHsQaTAjrlAVixIInbpOTueqBHFtsOGh6v/gIuFRmEGRp2Gi4XjjVYyHbjUb6HYGuhqpZf34R0yWVuCvoOojTtjrrCpL+d+OV1wlrOT/dr8WfRwI8TtlO4561BVXaZCk9KNdtNXMDUz0c5Ahhk4Nv6xQSDAWXQ8faEQA9DQeEt3cFA12UMCT3qpaExySARBsBPEaiTApjpFfQv7Oz7Pg6fDRGqSNquc0kX8r+WUY5s0FJ3R22FGOqYbJLYZknvAJq7li2009tP3Jt8f1H5oTLCCW0lRJC4rETap5gd/Y/y5eZrhh0VIOaHDMnL3SdtMW/Gxh6XQv9VOyIkyY3m+vdE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39a6c22-dfef-4c9e-a40f-08dce7cb1dfc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:57:54.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFcu626GVxpGE0z33uhOHLU7sE4y3QMxl5ZCRxpu1oH5P5ZX9spkzhM3JqEoplWbH58TgbmBlB0X1C7R+LBnlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_17,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080122
X-Proofpoint-GUID: 848YR_-9XjR1jOhETtaPrUC4aht0twx3
X-Proofpoint-ORIG-GUID: 848YR_-9XjR1jOhETtaPrUC4aht0twx3

On Mon, Oct 07, 2024 at 09:13:17AM +1100, NeilBrown wrote:
> On Mon, 07 Oct 2024, Chuck Lever wrote:
> > On Fri, Sep 13, 2024 at 08:52:20AM +1000, NeilBrown wrote:
> > > On Fri, 13 Sep 2024, Pali Rohár wrote:
> > > > Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do not bypass
> > > > only GSS, but bypass any authentication method. This is problem specially
> > > > for NFS3 AUTH_NULL-only exports.
> > > > 
> > > > The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 2623,
> > > > section 2.3.2, to allow mounting NFS2/3 GSS-only export without
> > > > authentication. So few procedures which do not expose security risk used
> > > > during mount time can be called also with AUTH_NONE or AUTH_SYS, to allow
> > > > client mount operation to finish successfully.
> > > > 
> > > > The problem with current implementation is that for AUTH_NULL-only exports,
> > > > the NFSD_MAY_BYPASS_GSS_ON_ROOT is active also for NFS3 AUTH_UNIX mount
> > > > attempts which confuse NFS3 clients, and make them think that AUTH_UNIX is
> > > > enabled and is working. Linux NFS3 client never switches from AUTH_UNIX to
> > > > AUTH_NONE on active mount, which makes the mount inaccessible.
> > > > 
> > > > Fix the NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT implementation
> > > > and really allow to bypass only exports which have some GSS auth flavor
> > > > enabled.
> > > > 
> > > > The result would be: For AUTH_NULL-only export if client attempts to do
> > > > mount with AUTH_UNIX flavor then it will receive access errors, which
> > > > instruct client that AUTH_UNIX flavor is not usable and will either try
> > > > other auth flavor (AUTH_NULL if enabled) or fails mount procedure.
> > > > 
> > > > This should fix problems with AUTH_NULL-only or AUTH_UNIX-only exports if
> > > > client attempts to mount it with other auth flavor (e.g. with AUTH_NULL for
> > > > AUTH_UNIX-only export, or with AUTH_UNIX for AUTH_NULL-only export).
> > > 
> > > The MAY_BYPASS_GSS flag currently also bypasses TLS restrictions.  With
> > > your change it doesn't.  I don't think we want to make that change.
> > 
> > Neil, I'm not seeing this, I must be missing something.
> > 
> > RPC_AUTH_TLS is used only on NULL procedures.
> > 
> > The export's xprtsec= setting determines whether a TLS session must
> > be present to access the files on the export. If the TLS session
> > meets the xprtsec= policy, then the normal user authentication
> > settings apply. In other words, I don't think execution gets close
> > to check_nfsd_access() unless the xprtsec policy setting is met.
> 
> check_nfsd_access() is literally the ONLY place that ->ex_xprtsec_modes
> is tested and that seems to be where xprtsec= export settings are stored.
> 
> > 
> > I'm not convinced check_nfsd_access() needs to care about
> > RPC_AUTH_TLS. Can you expand a little on your concern?
> 
> Probably it doesn't care about RPC_AUTH_TLS which as you say is only
> used on NULL procedures when setting up the TLS connection.
> 
> But it *does* care about NFS_XPRTSEC_MTLS etc.
> 
> But I now see that RPC_AUTH_TLS is never reported by OP_SECINFO as an
> acceptable flavour, so the client cannot dynamically determine that TLS
> is required.  So there is no value in giving non-tls clients access to
> xprtsec=mtls exports so they can discover that for themselves.  The
> client needs to explicitly mount with tls, or possibly the client can
> opportunistically try TLS in every case, and call back.
> 
> So the original patch is OK.

May I add "Reviewed-by: NeilBrown <neilb@suse.de>" ?


> NeilBrown
> 
> 
> > 
> > 
> > > I think that what you want to do makes sense.  Higher security can be
> > > downgraded to AUTH_UNIX, but AUTH_NULL mustn't be upgraded to to
> > > AUTH_UNIX.
> > > 
> > > Maybe that needs to be explicit in the code.  The bypass is ONLY allowed
> > > for AUTH_UNIX and only if something other than AUTH_NULL is allowed.
> > > 
> > > Thanks,
> > > NeilBrown
> > > 
> > > 
> > > 
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > >  fs/nfsd/export.c   | 19 ++++++++++++++++++-
> > > >  fs/nfsd/export.h   |  2 +-
> > > >  fs/nfsd/nfs4proc.c |  2 +-
> > > >  fs/nfsd/nfs4xdr.c  |  2 +-
> > > >  fs/nfsd/nfsfh.c    | 12 +++++++++---
> > > >  fs/nfsd/vfs.c      |  2 +-
> > > >  6 files changed, 31 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > > > index 50b3135d07ac..eb11d3fdffe1 100644
> > > > --- a/fs/nfsd/export.c
> > > > +++ b/fs/nfsd/export.c
> > > > @@ -1074,7 +1074,7 @@ static struct svc_export *exp_find(struct cache_detail *cd,
> > > >  	return exp;
> > > >  }
> > > >  
> > > > -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> > > > +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp, bool may_bypass_gss)
> > > >  {
> > > >  	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> > > >  	struct svc_xprt *xprt = rqstp->rq_xprt;
> > > > @@ -1120,6 +1120,23 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> > > >  	if (nfsd4_spo_must_allow(rqstp))
> > > >  		return 0;
> > > >  
> > > > +	/* Some calls may be processed without authentication
> > > > +	 * on GSS exports. For example NFS2/3 calls on root
> > > > +	 * directory, see section 2.3.2 of rfc 2623.
> > > > +	 * For "may_bypass_gss" check that export has really
> > > > +	 * enabled some GSS flavor and also check that the
> > > > +	 * used auth flavor is without auth (none or sys).
> > > > +	 */
> > > > +	if (may_bypass_gss && (
> > > > +	     rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
> > > > +	     rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)) {
> > > > +		for (f = exp->ex_flavors; f < end; f++) {
> > > > +			if (f->pseudoflavor == RPC_AUTH_GSS ||
> > > > +			    f->pseudoflavor >= RPC_AUTH_GSS_KRB5)
> > > > +				return 0;
> > > > +		}
> > > > +	}
> > > > +
> > > >  denied:
> > > >  	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
> > > >  }
> > > > diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> > > > index ca9dc230ae3d..dc7cf4f6ac53 100644
> > > > --- a/fs/nfsd/export.h
> > > > +++ b/fs/nfsd/export.h
> > > > @@ -100,7 +100,7 @@ struct svc_expkey {
> > > >  #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
> > > >  
> > > >  int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
> > > > -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
> > > > +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp, bool may_bypass_gss);
> > > >  
> > > >  /*
> > > >   * Function declarations
> > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > index 2e39cf2e502a..0f67f4a7b8b2 100644
> > > > --- a/fs/nfsd/nfs4proc.c
> > > > +++ b/fs/nfsd/nfs4proc.c
> > > > @@ -2791,7 +2791,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> > > >  
> > > >  			if (current_fh->fh_export &&
> > > >  					need_wrongsec_check(rqstp))
> > > > -				op->status = check_nfsd_access(current_fh->fh_export, rqstp);
> > > > +				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
> > > >  		}
> > > >  encode_op:
> > > >  		if (op->status == nfserr_replay_me) {
> > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > index 97f583777972..b45ea5757652 100644
> > > > --- a/fs/nfsd/nfs4xdr.c
> > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > @@ -3775,7 +3775,7 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
> > > >  			nfserr = nfserrno(err);
> > > >  			goto out_put;
> > > >  		}
> > > > -		nfserr = check_nfsd_access(exp, cd->rd_rqstp);
> > > > +		nfserr = check_nfsd_access(exp, cd->rd_rqstp, false);
> > > >  		if (nfserr)
> > > >  			goto out_put;
> > > >  
> > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > index dd4e11a703aa..ed0eabfa3cb0 100644
> > > > --- a/fs/nfsd/nfsfh.c
> > > > +++ b/fs/nfsd/nfsfh.c
> > > > @@ -329,6 +329,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> > > >  {
> > > >  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> > > >  	struct svc_export *exp = NULL;
> > > > +	bool may_bypass_gss = false;
> > > >  	struct dentry	*dentry;
> > > >  	__be32		error;
> > > >  
> > > > @@ -375,8 +376,13 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> > > >  	 * which clients virtually always use auth_sys for,
> > > >  	 * even while using RPCSEC_GSS for NFS.
> > > >  	 */
> > > > -	if (access & NFSD_MAY_LOCK || access & NFSD_MAY_BYPASS_GSS)
> > > > +	if (access & NFSD_MAY_LOCK)
> > > >  		goto skip_pseudoflavor_check;
> > > > +	/*
> > > > +	 * NFS4 PUTFH may bypass GSS (see nfsd4_putfh() in nfs4proc.c).
> > > > +	 */
> > > > +	if (access & NFSD_MAY_BYPASS_GSS)
> > > > +		may_bypass_gss = true;
> > > >  	/*
> > > >  	 * Clients may expect to be able to use auth_sys during mount,
> > > >  	 * even if they use gss for everything else; see section 2.3.2
> > > > @@ -384,9 +390,9 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> > > >  	 */
> > > >  	if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
> > > >  			&& exp->ex_path.dentry == dentry)
> > > > -		goto skip_pseudoflavor_check;
> > > > +		may_bypass_gss = true;
> > > >  
> > > > -	error = check_nfsd_access(exp, rqstp);
> > > > +	error = check_nfsd_access(exp, rqstp, may_bypass_gss);
> > > >  	if (error)
> > > >  		goto out;
> > > >  
> > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > index 29b1f3613800..b2f5ea7c2187 100644
> > > > --- a/fs/nfsd/vfs.c
> > > > +++ b/fs/nfsd/vfs.c
> > > > @@ -320,7 +320,7 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
> > > >  	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
> > > >  	if (err)
> > > >  		return err;
> > > > -	err = check_nfsd_access(exp, rqstp);
> > > > +	err = check_nfsd_access(exp, rqstp, false);
> > > >  	if (err)
> > > >  		goto out;
> > > >  	/*
> > > > -- 
> > > > 2.20.1
> > > > 
> > > > 
> > > 
> > 
> > -- 
> > Chuck Lever
> > 
> 

-- 
Chuck Lever

