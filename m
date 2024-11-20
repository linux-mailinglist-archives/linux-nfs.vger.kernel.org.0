Return-Path: <linux-nfs+bounces-8144-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B5F9D316A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 01:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0DA2810DF
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 00:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC250A939;
	Wed, 20 Nov 2024 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DKPSb87c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ICqEuMDm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1FA920
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062738; cv=fail; b=pf8xCirJGp+sX7U1gm9F+Bsgg8vvCW09LSNx/Fq8sAbuJ/mnVuvm+SJcIUxHecyRM24QFnjo95FXPgJUJn7cgg1SrNBdv8fVnOxzklmhHDKzg+UItIK7oL6LyoiHv8N3SBLC1LcKGz0eOot3r49IsGa3cMyvodG1Z9X+P9b69Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062738; c=relaxed/simple;
	bh=jz434/ufz84ZDZjrgPT1ewWqkJ/raH4NbVMb7LXHZvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MCveFVBmiC2MsRZpm2ucBySFBx8r26crgAF/CICMJ5RWmP7ZmjU0DaNzm2ojV5aqiz9LBMSILB9/7E98qJNRrkcdsWSX+qZEJ7f9j26HQoEpwOin9ySaPd9cHxK3DWL/gaIITug2hdkYNR2h1TxZF4i33Yu3E03rZUesQJsMg/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DKPSb87c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ICqEuMDm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJMg2Ou003589;
	Wed, 20 Nov 2024 00:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4drU3+Ak142PcYN1io
	d3Tg9CHMG2An1YxlK33WDifeI=; b=DKPSb87c6mdLkA8nqVljS/GB9IEoqTCR+g
	+sgLAiLsnGgZdeMSWvg7EPEFCPLjnEYiLQs54/QP1py1peUXRNc29ynW8CirQikt
	feftaRQa7B6NQA69RVeEn97dORpSBwUfr46QUyNQcuUp2vt14ovAzcbqLLEJuodR
	qvTo7PqaVJrr7w7M6e+T6IIguVzsAzuw0FYk9Qds3BJcndBcYiF8MrijEWKNCcjX
	6gs7qH/0BFakm1s1dZ6u3Fpe5HmVYHs/Dn7z0DOabkbBVUS2O/0PMHn9OYa+2iiQ
	2/IBz1yOaPeWHsbpavqurbhmrMkYvTZGJEwrXcPxczyHOGc//3AA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98p6rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 00:32:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJMlXgH037367;
	Wed, 20 Nov 2024 00:32:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu9gu75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 00:32:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRg7xWK/PAZSwQwxH/jXHiJcIlTW3Quw3Vb2PpkSkf6zhiKl33Q22bdhAH9TZvt2lheFvSZ1W7JR8ba2sx0W3VeBMtZpaDHNDO2xjf0ilBa9kLVg/yhCXUcTiTaUfGN48FZRJUHAke9QYInW/cA44LBi9leYhGWR9lvB/c6u7IbAvflhkt6Z8UCjJ358fUZpN+NMuyIcvwEdaRWhfq/5CguETb9/HeCERqymZxbqNum5kVbOSzj3foHnnFwOZxkBrnY8Imx3efxWBVy+sRXFzubXIp9Acd2CBHQyPR+mjEEbCeXQ+tVKwL8CWmwO08I567FDrJf+5yrnsrO90MXFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4drU3+Ak142PcYN1iod3Tg9CHMG2An1YxlK33WDifeI=;
 b=YN7YWYzaF2bm0MKdFTp2y7Z3wWdI/nuCxQ9WSs0TZvwhzuyNd3FPzTqisT+SXBzWZLa8PuEa3v8WjbNV4M5rhs+cq8IBa74A3olhttbBBDeRn7Cb+jCBJukQcHx1/pgJl1ecKasGegXghhlmJYmd+8nebmS4RVDL387AFzb4dlyVahEqdN/5JlV4uUvVE/vxw9n00eTcd1hdwJ3cRw8FDVi+O/Qm4Hr3/Wn2cglHnpOGFMlleHuG3rgMJXJbncy+lnOnmsd7y1xtZuqgfd9pJ7oYZ5ki0RwOFCxW9k81y/kcBAe1D0a22Z2N+KDumNVIWve9rn7jinK45iEhC5Triw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4drU3+Ak142PcYN1iod3Tg9CHMG2An1YxlK33WDifeI=;
 b=ICqEuMDmbtfkuiSZA4+3JODwdLkLhg2L4WoJGY+BucpVcroLfRCZBDEbTHFZxuVahEwxp6ptJFdAN1xQUbe2JaIpRMV2iEz50tLQ8SGF37m2RxwK/a4F2pQu6EpmAPxA2W31/C5EgqQEml0phrYJQtRPHy5nHPwYRsWQ+0l/8GA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7138.namprd10.prod.outlook.com (2603:10b6:610:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Wed, 20 Nov
 2024 00:32:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 00:32:04 +0000
Date: Tue, 19 Nov 2024 19:32:01 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
Message-ID: <Zz0uAZQpR4LG/gvi@tissot.1015granger.net>
References: <>
 <ZzzlCJAU357ig+Rm@tissot.1015granger.net>
 <173205527138.1734440.13300385185135924628@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173205527138.1734440.13300385185135924628@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR15CA0010.namprd15.prod.outlook.com
 (2603:10b6:610:51::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: e9bafb8b-7561-471b-0703-08dd08fac1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mxfDJLCe99c3V5R17KUF1Tu7K9jvHvBWrDYLjxmbharjNQI7iETDwbG/sLAo?=
 =?us-ascii?Q?6QefltWrov2MjFInUojMsHDNTUDn5axCzIZtYwyScmkpDmvctAe/o7GzBkLu?=
 =?us-ascii?Q?Qg8+W30hyEDSVVGCIA301LMLuA1sHi/lAH1zVbSAIWf0Xyhgv2uXZWARb2bk?=
 =?us-ascii?Q?gJzDBXqUeKwLb7hqRcOygRYouoPrhCvlR6OCPl0Yw3R5vsXkrrtoNBbnP0lR?=
 =?us-ascii?Q?1jf3QU6wUQcOaaUGja4rYDinwieO8rzQJYZFWbYThCL5SHZeUr/a27sx8QKi?=
 =?us-ascii?Q?A/icLtfXF23MyNDtB1XnSRNA5nM7WK6OHt/DHUSFVaXtrEtFZ7bA+ktvZAAI?=
 =?us-ascii?Q?1m0oZImKqJolzszpSb7jncxr6Ny8pkFoNX5oSXeY3UPyRt/YknhHssjgCiIh?=
 =?us-ascii?Q?L+na0mzPaMUQ0ExJf6JvvaN1MPqIhZD5RK603JDcapOgDT3aFPAisCEfnHrP?=
 =?us-ascii?Q?Ks6TBq6tDfFEl4uUUYe++j+tbCkwg/G7jxZhZba7R0tlGlqtqCQASq5M+UtB?=
 =?us-ascii?Q?aIiojslOTcMZ00O7i639oinv0/Meom1gLOxJdCBLEFv3MbsnRa42LxJ+0Kv/?=
 =?us-ascii?Q?y5MAy5HMJ0CvI0UxjJBXTgMyXd81cluauBm8Ik3EUmILDdw4+j533U2WmDZ7?=
 =?us-ascii?Q?I6CnG0NQI0JNmZSqKOeC4+PPeBgQvKnG6NGxxL1qP5/p345w44HAZM7mkpPx?=
 =?us-ascii?Q?DNKo5EAnzCUD+NJVc6+XVYnw4R9IdOwbWpn0NJrgeMgviDNWjWFrzgiA6jNW?=
 =?us-ascii?Q?IIWOFmzxv6fdGLyX+yGd3yNntS8f9KRNeCRxNkCrUnzwoImuwxfF69hmM2iR?=
 =?us-ascii?Q?36Wkiw0syNVGC7xktFWiuRBxDKofiaR43yyEpDNNsAfFVXR/lN5tOaqXNcZk?=
 =?us-ascii?Q?DTX6jQbZ4TO3v8HGL+vnGVO53UIkJ3OSGy7zJnYtgQB5iCcgqflSgpCgZty2?=
 =?us-ascii?Q?GdR7I2NoKCQrS3ZCJPqJyFjHfLwFyX0C+Dhv8CxG7IwERGxCzUwzd5n0mQRi?=
 =?us-ascii?Q?DYxl3TukYa9RvvrwO0nvS5HjrslqYHXW/OJVR9pGaHRFptTsDlKadGrO96U7?=
 =?us-ascii?Q?kLrLXpndmmEUagzhSl6OtDsxPcQ8gT0xWfFyeXvyW4FvaNmul98SR6paVcNp?=
 =?us-ascii?Q?CmUUkHmiyrNTszZsaPbyQ5cxj+HLgaqkpN9eHdFEaAoeqOdHtC7/Lpk9Geax?=
 =?us-ascii?Q?b+3SvSnnXK0NyZe73Lmo9/BT6OjI03nRuRRCo1zcAWkrQX/gJLORqyoLF70z?=
 =?us-ascii?Q?eiP38EEpzyabxVhJ/odmGfZNjhevrnenDCEfSWaEPareID4/pIoI6ajJ0vKJ?=
 =?us-ascii?Q?5TIZsKBLsXIeqk8X4hF0VxUf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R+MLqfZf+PQpmQWi4n0JGBZTauyFerOzAIPgjYu7PBZaxQ9dx9Q3YZ1mLeyo?=
 =?us-ascii?Q?hosINVNELqMwj2ywO96P/PxV+JHg83NXufiKdiILpdtkuLoqEito6FLTLdCm?=
 =?us-ascii?Q?Fk7CNNQm3qNJJXxxDuxV9Q6crNKZ817YB5qXo2UVOXh4xZpcWTUtz8qLZt1d?=
 =?us-ascii?Q?LVi2zgVNU2eSCEPI5WSP3zPlxWEruo7Ru7LFfopXBorr0m1ez9AmmbBwpFMv?=
 =?us-ascii?Q?LtgS6uigrX9+Vr5Ck86F2vpfkQkBMNKGxrjyK7ldz2qYPvwcnWONyyVWj1D7?=
 =?us-ascii?Q?A69wDrawBlLdibzeq8g3hHTQYKIu4bwynMK8DlgqH6apCO4ZkQ1N2Wp18/uJ?=
 =?us-ascii?Q?zQ7t8oRgyDTwy3+BBpuVuarOP6oth2/yd95Z5XbMiwp2/zpdJLKqyrmF/NeH?=
 =?us-ascii?Q?csknF+ZtmfcgHEPLMMiw30/U9pFdFPdZChjV7vN3wcVd4mqCaUWm1ju1NBbA?=
 =?us-ascii?Q?XfXaTsk6BIq+WvTZGNzQP+mkM9uRLnbcvQnjFpKo35F3SMJumO6AdwEphUdw?=
 =?us-ascii?Q?8JdAo/p0SbOMGxiO7HEbc0aMCgfk4XA8z4lVoxWzyZk+WmRVKoVCETqY01ZJ?=
 =?us-ascii?Q?oKTYi4q8xtwtvLDc2xel3ITzvc7cSqH+7nV94ID1cvU6jEToKpNGv1UdeJuW?=
 =?us-ascii?Q?T3UYjmlkpPpoefuwI/H3gtoxLoSShgASOpGgF8kzZg05TBKghBtQvL9pDLJC?=
 =?us-ascii?Q?cQ/ZQwOQ1/0maQruhxv8yT5+SHy/pdZp2lUjaKhbys8rr5gDNuL+VJbpJEt3?=
 =?us-ascii?Q?P6XjT7zUQZfUCv5XxL8567qSQ24J75ZJvsa8yz0eYF3qHwVszyukaF5XZlVu?=
 =?us-ascii?Q?Mvi/nhFFEDVuUFjdkjNakP2xJ0kI7UnLgGQ4fDJH1Jr6QcBlDF43HPtQ7kFl?=
 =?us-ascii?Q?ojNsCYDDVEXuUg3dPpiCLcvGX7BUVI864IsdkLdBGN/7mQTP28gjUdw0wJG+?=
 =?us-ascii?Q?/1PbVUAFtyx9cjh9yLNHHHdvH9G3O1Vnx2s4tIyRCQfRJSlQGLkD219L4ZcW?=
 =?us-ascii?Q?wkXpslun74uV0Kj7ars6w56UA2JB4h1S3McXwzaRz41+cytdknFrLKmz9ccg?=
 =?us-ascii?Q?sR/Ahu14lcHff9Re4WUfW3hufbzRxLLzXKz/IVv3IYgdIk/nVWbS2pj7yV2d?=
 =?us-ascii?Q?zKu5rf/ITu8++E5DGYR5RjBX18/kEdgjBFIWROdrWd8WjH0ucZHgqVUl4TJC?=
 =?us-ascii?Q?X5HBEn/GyGeRRSINew6WZjaVjwgFGKoKWaKTli3FEWbT5VGNwyd31WZaOHWx?=
 =?us-ascii?Q?qZs2aUUT+yjDvrJSO9//VfBNwENo1B2K1iqatk2QeahJ8SmXaH/gk4w9UGrU?=
 =?us-ascii?Q?Mj4Q30nxKIeDQdDcWJGSieY8cn80CL2Z5jLVZN4qHlD2kYZhW8/FAyJUMaz2?=
 =?us-ascii?Q?Pl+I2t25VCtJ8SOx4RkmZcw5EUqEPdlDpufZndJX1W92czNe4zSV7Cr8pW9T?=
 =?us-ascii?Q?7FQrD5Ob8/sEJil6fcvrBxoBvHMd0E5j1b+egLZbaCgqVIjaIMKp9KksQLxc?=
 =?us-ascii?Q?vNdbPXwcEvi423LVbnHaryWnvAjzuQ0hooRJgLUCRXG0YWNR0Wxx6nZ0ETIK?=
 =?us-ascii?Q?U0GGEGEoXaOCPMsirw9OuzipsR0iueZN/juQVJFl8iw/dgPkL75XjA42D168?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YuJLpW22ZJv5KuDmMor6gcdDRJbpwfuyK5SrtLbUEHB+0o20BHoIwSRdk/05qGP+/diFYU7uIhxwlOVUmT+xhPuBYj5i2vsmPeCnUPZN9IGKjLnV8HKXAZ0JGPd6ODRZLIHbiZp/w5QUuSIivoPxzprr/I7M1xgpwYI2jKQJKvIPI3OUKESHtWD1zZTbql9/7PUFvxeP/Q06tgS4d6gFRwp94zZekPsJ4EuJfI+CNUqXsrsgci3CyKcpPVpUwOc0Vnh2L164QXttJYOML8wVQ0u2lTHTtfs8JB/8r8K1SPUv1g0ECy3hitMnN+tj8wENMsl/Nx191DzYU53gGk0tWJZfI5CoByt5Hgg2IVy10dfCEbwsVjAaVGqeIn/1Xih038K8av5ZDmceeQNfgB1uvWRKGBwk9nzgS5mWy5UUJBFEmZDoUhRKnUOCp9cbzQFcp0MYNxhfyfGQmg79iTQ30dOjnvVpAVon28qEti0sC8vdDu/omKf+JIaYPOARm3E0B0yZ70ZZinCwTYjEM5q0HzXOY5LNsELC+c6vBOjcmPE5NNXzBn7GWzp9DO2kHsf0+YzZ24fVLZZmj1RhHY8VWYnuT4E07Y9F4JRWxfLvp1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bafb8b-7561-471b-0703-08dd08fac1ef
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:32:04.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQRNkMyvh6xtse8cq3B+uPDX0K2rCnB+quNYEjuQGKzoG62fZ7TLqQ71wTubHLv0+hFR/JOQlEzYJ0evVdwBwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_15,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200002
X-Proofpoint-ORIG-GUID: umYzPK15O2b6dc0qjasYIdvITkPxGBGN
X-Proofpoint-GUID: umYzPK15O2b6dc0qjasYIdvITkPxGBGN

On Wed, Nov 20, 2024 at 09:27:51AM +1100, NeilBrown wrote:
> On Wed, 20 Nov 2024, Chuck Lever wrote:
> > On Tue, Nov 19, 2024 at 11:41:31AM +1100, NeilBrown wrote:
> > > If a client ever uses the highest available slot for a given session,
> > > attempt to allocate another slot so there is room for the client to use
> > > more slots if wanted.  GFP_NOWAIT is used so if there is not plenty of
> > > free memory, failure is expected - which is what we want.  It also
> > > allows the allocation while holding a spinlock.
> > > 
> > > We would expect to stablise with one more slot available than the client
> > > actually uses.
> > 
> > Which begs the question "why have a 2048 slot maximum session slot
> > table size?" 1025 might work too. But is there a need for any
> > maximum at all, or is this just a sanity check?
> 
> Linux NFS presumably isn't the only client, and it might change in the
> future.  Maybe there is no need for a maximum.  It was mostly as a
> sanity check.
> 
> It wouldn't take much to convince me to remove the limit.

What's the worse that might happen if there is no cap? Can this be
used as a DoS vector?

If a maximum should be necessary, its value should be clearly
labeled as "not an architectural limit -- for sanity checking only".


> > > Now that we grow the slot table on demand we can start with a smaller
> > > allocation.  Define NFSD_MAX_INITIAL_SLOTS and allocate at most that
> > > many when session is created.
> > 
> > Maybe NFSD_DEFAULT_INITIAL_SLOTS is more descriptive?
> 
> I don't think "DEFAULT" is the right word.  The client requests a number
> of slots.  That is the "Default".  The server can impose a limit - a
> maximum.
> Maybe we don't need a limit here either?

I see. Well I don't think there needs to be a "maximum" number of
initial slots. NFSD can try to allocate the number the client
requested as best it can, until it hits our sane maximum above.

I think sessions should have a minimum number of slots to guarantee
forward progress (or IOW prevent a deadlock). I would say that
number should be larger than 1 -- perhaps 2 or even 4.

The problem with a small initial slot count is that means the
session has a slow start heuristic. That might or might not be
desirable here.


-- 
Chuck Lever

