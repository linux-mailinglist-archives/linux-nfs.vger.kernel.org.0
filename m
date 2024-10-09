Return-Path: <linux-nfs+bounces-6978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44AB996F9C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AF5281737
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3501E0B7B;
	Wed,  9 Oct 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FR1PFh1N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vWqR58Tp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683C199EAF
	for <linux-nfs@vger.kernel.org>; Wed,  9 Oct 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486914; cv=fail; b=PHGiUdNNMy5Y43uHtNSbd+vO6qQTUg8PTZrcKW52Wn1woZt1A1/DLjKBwyoHhuI9cg6aqU/98oofYtW1fsaiyvyXSdEJpR83fIOW0tV2/FHjbwUgHA3L9rfSROraAWEmoJldDBxIwgicQ8HxbZNgaE6ciQshOJGUnPYCh70eyHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486914; c=relaxed/simple;
	bh=fVvTx69R6d6rKzzyyku9jqUbdHA7Z6nNoxL8+qPjyoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BR9sPlyveGHAcNsO6wgloiY6o9hl3wHe4ZAqua/bEb5c8JCZpGZ+eWZ5orEMl2l19+5QTaWuh22LtwKtQ8nd+m6A1G6kEgN4U2Eg6b2eZDYIJDGuM62/SqdqzTzTJMq2DUkXNSVFE3fBwcgvCOU7O8//K7mkxkNgi3ob4ATshVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FR1PFh1N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vWqR58Tp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499Etgrc000313;
	Wed, 9 Oct 2024 15:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2EbsqzhtYY9wD+Y8g0
	rX9HCCDlhuGMiAGvyjYg8HHWY=; b=FR1PFh1NV1r/hbZqKUWR4AXVvXiOshzo+9
	/ArVlm2bK6Eb9UP/y8hI9rTt7IGgt/MTKb/OKsAbZzXXkXK6JvuA0wTal0bZHBtK
	Pxm+XOi6g5N62+7ssOWmFWxUbP2ke8hDnk7hyEfiiV9IFO6T4mXWzlgiLKw9VLCv
	NNho3UHDiEEFZi7GmeALcTW9eOEKRGSER+mFlcO5eJriJ45J4r7TrKjOBetvttEd
	meebrRwOa3W36bXDIAAqZaaMWHqn6dneFnXnkNUtExWr0Oesq1lluXjtmTDM/8EI
	WX+Pw2U+vqRdIeVti9MR0PssCV/VPx1ABHdt8C3dtoOgsqxI1QFw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308drj1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 15:14:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499E3wpO031162;
	Wed, 9 Oct 2024 15:14:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8rq2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 15:14:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7kABNbWiSNKNmhUpjm0Ldrl3BFM+OJV+JqQm4/AWy0YH4Ro27igG9YcUvegKIul8VNoow2G25qi+OOwocqt+tXp+94FhdJ5NgGHXBa/TBQYhtRqDEqmqVsEqJ7Ush53CBm3fkM6nKvu3ueI0fzvI8UcNE9mSrD63zOs+/3OE941nPLqxySFVmixI+FIcct1TdRm/PC9U/ozINa5ykvmMV8GqFj4Gs4LUjavv0BKG8uMviL4BE74NHUXknK8wuVsCrIKL1HBFnc3DrDLlm4C23Fu5i6gvZf1PYLbNu8hPiQAa3I+Q9REjWqmXLAmeHRcP3sgt250cwTJU+CyYfWxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EbsqzhtYY9wD+Y8g0rX9HCCDlhuGMiAGvyjYg8HHWY=;
 b=SzgGtcO+/gVGugC96POG9RQxw9XoogMFAioJANfdaY2AMz+l889A/BGON1633t/3HURcuW/Ce7KKmef1/tjrA6cfF4xl1rgyV7sMRNAlrdTUtFeAff/XWTxYrpTSljnm83b2daBHmIDpocfyRLPI5w1uyIbsub7hQDiEU19TYUM4YPh2vcx4EOXe2p5smdPu4WUUxBDVoXwGZrnAFqnztOEAfegFr/Nw0oQ3zPmupGnupJCAB7a4jYvqsRE+lo936GlbO6vHB3Pt0NtkSmUijyB+q9Ks/DQvJ3J7Ar4ZYHeXOBR6N8rQ1+GQj8c94tdMR67y/pgP+h38HrCodsNb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EbsqzhtYY9wD+Y8g0rX9HCCDlhuGMiAGvyjYg8HHWY=;
 b=vWqR58Tp7IytA6Enu6ZIREIPbBo+R4/3YQlGLBKTPYJUlivWyYiXIdoUcvI6eop48n+gijm54ri1E9cW5u7CNSJKitseY1Fyresc+HsV+wlnmPrjcVgnv6j6We3FYttfIY4fr46xRo9aYJDOz5Fm0+uH9JuSSgFjm7EktyTjQ8Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8149.namprd10.prod.outlook.com (2603:10b6:8:1ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 15:14:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 15:14:50 +0000
Date: Wed, 9 Oct 2024 11:14:46 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 2/9] NFSD: Free async copy information in
 nfsd4_cb_offload_release()
Message-ID: <Zwad5j0IIAf2+h21@tissot.1015granger.net>
References: <20241008134719.116825-11-cel@kernel.org>
 <20241008134719.116825-13-cel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008134719.116825-13-cel@kernel.org>
X-ClientProxiedBy: CH5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e02f414-d32f-428d-b9a1-08dce8751e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3PGQwBf+i/QR38JZuCDpbHkPl4V75Ml8P3za42YJP8tkYhmAkXWiY+FJvFMV?=
 =?us-ascii?Q?hQ0NlxMDdWjqWPGJzHxTWQntyXRPO/G6oZ0qTUaUevJXLzzr1UqLLsjKuQMJ?=
 =?us-ascii?Q?ugHh8dv/8ufdVZMDQRbSXyYSoItiN3JEkXmDWkJ+YR5ZtCdhCcscX0VzDceY?=
 =?us-ascii?Q?c37dZSePloQT+05CFHTpfVSfJFVRCXCjT6fdbPg0L8wofnEr8S6NDnzCgoj/?=
 =?us-ascii?Q?mpM/Eg4eL8cdur3e7ZxjpxTL4DlcKyLVRqopWEznPkPGjA1WOeBhUe9sDTMZ?=
 =?us-ascii?Q?Jr7EmwgSwvPoc9MzTSQ7WdT1dp2UjfxuUNBMbp/Tofo3x4Wug4fr0d+1Ij4N?=
 =?us-ascii?Q?p1LkcCAikYWthA1wRh0k8IoZVDJnlJtfDE29QzhvzMY+c0MhX1fsB0eDEQJ7?=
 =?us-ascii?Q?UtMcz3A50AAk7+cz8WhEQVikzgXhVPp0tgbLuVrGoSAPvyoNLr/Y1vINHck4?=
 =?us-ascii?Q?jXvR/cvbSDTEtnF5S9NbOeEA5Zj6mKaApoMM0YTkUmJ448BgJpjCoq+vjliI?=
 =?us-ascii?Q?IQ/PD5qXtgPNWi+RML/nQZZjQkrt9U6HWzPs9fthze/PqKAluF27o+SPSWil?=
 =?us-ascii?Q?M5cEn+Cep4VSCFwNZDjn1OJwUBr2Se8lmsdQx7PFL/oOm5qSKyFQGxC5XMNk?=
 =?us-ascii?Q?QBx3baGjH2L4Gd1JJLJAX3ZfnRFfqwH3mbJoC/tXzXIJf/FQPGvp0/gqUUzS?=
 =?us-ascii?Q?onoh9X9Y7lDDGpmmd3CHZck2T5hnv1FnC6oKGAGhxgqHovWO4wnR4MLhYQ5k?=
 =?us-ascii?Q?S4a7+31ItK25s/RjmkgEUvQXDF0BDIBPctw6OfL2j7dtvO8l5HYPo9lLLdEE?=
 =?us-ascii?Q?/qtayUhJNHewjpRixKfxFN9Ddw7F26PaTQ9RHza90UXMB897ltE1KIw7jQzn?=
 =?us-ascii?Q?KZhZ4gui79gnTb5qfMlKqaCfyLJ1i4prbXR0dUNXB5RLUp7pwBiHfkqfXxHN?=
 =?us-ascii?Q?zgQypEqOBs9W85tUtO5tZjKcEF84uOW5cv5Bwu+NazP6SD/40sZQjA0xETpD?=
 =?us-ascii?Q?sjZBdb43sZrCSF7GI3QS4deiWAGFafO/V3MIKnUu3gzPEYypMgPvznvn3bsN?=
 =?us-ascii?Q?t4zHzkkXaDDQ/YFye061nxZSCsZ2YiWDGdpVBZzyFcLvVEKWMMbW2rHE9tV/?=
 =?us-ascii?Q?xssM0sv+4spYZuanN85W0EIGxs3NO33EPBl89iadP6LKk+s2WHF5m1+kNm2a?=
 =?us-ascii?Q?VXN0eARVSWgza5Jm9hBA+narmr+7XPHOVaZr8LDTCIaINvxEX0V8WwU/q2XB?=
 =?us-ascii?Q?XUHC/lcAR1lJUw6Pb6J1DX5NiHQn763E3CNl6a8XNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ubo4qBwKb2E9cgZU9BJo13B9DCMEXIS3UzhD31VEfrcSIXczi5jg4rsJHs5f?=
 =?us-ascii?Q?978hL0+OlyOR15mo/49bthHej5sLKorVKGA+efAPrBd9b40munUFgERByEmr?=
 =?us-ascii?Q?bAGhzXDJaY9UwOsmMdggXkYGNFirwQMVRU5EJj+laOqKjFVzrqwb4M9CAzP0?=
 =?us-ascii?Q?hECHZP4M4G77d1WcBUqPF4aIbS2kvFZ6ncLkmp+Mj53TDw0SlpfGXIhyC7I6?=
 =?us-ascii?Q?1Jeq8bg1MM1/AOLbORLMjA0dHirHeLE6wFWjZZBcevA9dfTunD1vsdYEVymc?=
 =?us-ascii?Q?LGKoUmnpij3UvWecoand5j2NWQFMSptDQJwWSVAftWTwZb1nezDyEpmOKNqK?=
 =?us-ascii?Q?g0iOP62yS/Zqi92c09KIWpqtdc6l5h78Jw3MOfhNiFcUClPS08KiEvjsHeoH?=
 =?us-ascii?Q?QyE2nvog4U3C8sywkbHu8f4hEbjRk165EFQ45E0QEtJaciChExO0ZWg1urCo?=
 =?us-ascii?Q?EeajoycJjOsNJGmvbV3vxQdQQ4eWDcL2KX9rTmtvjVv5q4fBqvZ4avk1/8Dx?=
 =?us-ascii?Q?zdbCCk2ZNwViucvd74KaOLiIabbL9TUhiLpgtoXeL/ZJw7CqasTdKS3tdhFY?=
 =?us-ascii?Q?v1qvwVtw46oCnDmjgQYDvzEGZVFmOQLbx2q9lnU8w4dMkRX178vX+dZL0N2Y?=
 =?us-ascii?Q?XtCOCyR6bAUz38ltKPbTN/4AjW28v+hjxgE5SZ0/zQb1PBm1pefJ9zszDtEH?=
 =?us-ascii?Q?okMm51zQZLFIIuNqS6iJxETe4sQRDoWtISfB7ec9YSC+unmyUCmRPc1J095U?=
 =?us-ascii?Q?PkmUHJEiY295DF9xY+xjPBG6D0tXEY9wa4QOF+3qFbZsJr4MxT4RnNALCeSj?=
 =?us-ascii?Q?usWRy3xp+lwr/1wZFBdbng70XKKUSOhJOt4blRrgIPxImct6XeaPIXwVvF+r?=
 =?us-ascii?Q?Yteaapg/NLqSX2M6AGvNqgoDrzbeJ1UkZ6mQl8BDBNO631NErs7x6M83LBN+?=
 =?us-ascii?Q?4lNGKhpjF//IQZtLqqDe8TQedP+CszIzXUZ9XbHA7+roQKCd5dpu8moYN5Rv?=
 =?us-ascii?Q?lhqqRZEVClAknX4+lDAMNKQZJukBAp40h9C9k50OlxZ5TA2KDJs+qGg1sd7l?=
 =?us-ascii?Q?gxirFbCDMz8oUlOgutTHdwpqaaFo/3xdP3yAfU52uq4tls3dpiSQ1ypseh38?=
 =?us-ascii?Q?y5sigaMXIGruGLSsSmEBYI1TlxGg0K7B5kbB2XHbcro5FKCIZb+FCuzozXPc?=
 =?us-ascii?Q?ZiM07ZjKWfcyP8w8EjingFzmAmYTKDwjaZhHiwFfgmjWOzE72mpUaNGniQ7G?=
 =?us-ascii?Q?cCBYfvOlutFEAmgyqemZdV/kTj6Et4Y7uUwVfS3p1QITxP5UrUFsCXZY/84J?=
 =?us-ascii?Q?TacQvXpNN1UoWnppvIOYQ9wzz02pZMZQ2CtVRcFQqKyDh9mKRDZSPLqvnwt7?=
 =?us-ascii?Q?gDQD/Xus7NnbR2t/1A/CWxC67EVm1VHCXMLfwjtUhLdhCRL3pmwleoq7vpcF?=
 =?us-ascii?Q?oh5ZO1NS8F4mWTuiFg502R7G3AEM9bShVqZ8IgVof3iSA2tWo9kDdSkz002o?=
 =?us-ascii?Q?7puRrEig3AduVrZLk5SzXoDDU5qERrpStb8zv01gGc7manoVJEYdzSX6m5jS?=
 =?us-ascii?Q?2lXH2FmfsDfhb9qXIn2uhEgTlhKhx7QkXUq6jv8g?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lHPeFYUCXCGphUnNoBJ4a+yEhRoSjR5qV6auKxB6zoiQBYlL3TMbCshrLyx8ec6bxHAv5EY4YB9YRju7FfVRHdJOtummFiKWToZQmWWyIfZI3zSdoEVM4n9uHq2U0GUJk1Xx6dDWJa4/CQafz7tk2sCMV4NxRnITPpVgp757FgFBWuw5eLrVDF0aM54QhQjEu6Xg5y67pGmSYqsPXxstneanrWlUgnI88L5nYQQgNE4B+N+ndGh0yepf8Z0rCoMWpYDUSf5Q2gqVwjWGzwNe9+A5CURKMYAAkWpeUAsyOWKmHkVLPXmKuyJDGgoi+WD1zCtZldlF+/5OuLZBntACzY63zVrtVBSLlAUBcl7xYiNb2rS9FhJvoQt4vO+RAHXCDScvyLqrM93+96nNMTqhj7NSxCYQoklF9HsiAZLppkZqZH/18bDRoD7zmA7GrP5Jea67qdCYHUVeb32OfqKnX33C5FNllNiNN5PYGMMryxDR0tY4oDYqSlWX9w7U0AnrqwwJZQfmjgVnCjA5kGqRu8MSzGUGQFoGFeCcNj9vElI5QGwFGfDB4LK6tSMf7xYvqtcauV9+mmyZLIL0kjQPyCqoOibuGmBty06pJj1nmdE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e02f414-d32f-428d-b9a1-08dce8751e62
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 15:14:50.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k/aE3jMKsis5914Cwi7+gmPuld2erJrDWx0M0E/Y7yp8JDtyyQ7tNHoTZlaJm3JEsX0lLc8ufXIi0KrsCArAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090095
X-Proofpoint-ORIG-GUID: mv1FKuP24Anye8RT1GQWK9NUE9N6_RNf
X-Proofpoint-GUID: mv1FKuP24Anye8RT1GQWK9NUE9N6_RNf

On Tue, Oct 08, 2024 at 09:47:21AM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> RFC 7862 Section 4.8 states:
> 
> > A copy offload stateid will be valid until either (A) the client
> > or server restarts or (B) the client returns the resource by
> > issuing an OFFLOAD_CANCEL operation or the client replies to a
> > CB_OFFLOAD operation.
> 
> Currently, NFSD purges the metadata for an async COPY operation as
> soon as the CB_OFFLOAD callback has been sent. It does not wait for
> even the client's CB_OFFLOAD response, as the paragraph above
> suggests that it should.
> 
> This makes the OFFLOAD_STATUS operation ineffective in the window
> between the completion of the COPY and the server's receipt of the
> CB_OFFLOAD response. This is important if, for example, the client
> responds with NFS4ERR_DELAY, or the transport is lost before the
> server receives the response. A client might use OFFLOAD_STATUS to
> query the server about the missing CB_OFFLOAD, but NFSD will respond
> to OFFLOAD_STATUS as if it had never heard of the presented copy
> stateid.
> 
> This patch starts to address this issue by extending the lifetime of
> struct nfsd4_copy at least until the server has seen the CB_OFFLOAD
> response, or its CB_OFFLOAD operation has timed out.

An OFFLOAD_CANCEL that is sent after the COPY completes but before
the CB_OFFLOAD reply is received will free the struct nfsd4_copy.

Won't that cause a UAF in nfsd4_cb_offload_release or
nfsd4_cb_offload_done ?

If I bump the struct's reference count, would that help?


> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 18 +++++++++++-------
>  fs/nfsd/xdr4.h     |  3 +++
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index b5a6bf4f459f..a3c564a9596c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -57,6 +57,8 @@ module_param(inter_copy_offload_enable, bool, 0644);
>  MODULE_PARM_DESC(inter_copy_offload_enable,
>  		 "Enable inter server to server copy offload. Default: false");
>  
> +static void cleanup_async_copy(struct nfsd4_copy *copy);
> +
>  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
>  static int nfsd4_ssc_umount_timeout = 900000;		/* default to 15 mins */
>  module_param(nfsd4_ssc_umount_timeout, int, 0644);
> @@ -1598,8 +1600,10 @@ static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
>  {
>  	struct nfsd4_cb_offload *cbo =
>  		container_of(cb, struct nfsd4_cb_offload, co_cb);
> +	struct nfsd4_copy *copy =
> +		container_of(cbo, struct nfsd4_copy, cp_cb_offload);
>  
> -	kfree(cbo);
> +	cleanup_async_copy(copy);
>  }
>  
>  static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
> @@ -1730,13 +1734,10 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
>  	nfs4_put_copy(copy);
>  }
>  
> +/* Kick off a CB_OFFLOAD callback, but don't wait for the response */
>  static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
>  {
> -	struct nfsd4_cb_offload *cbo;
> -
> -	cbo = kzalloc(sizeof(*cbo), GFP_KERNEL);
> -	if (!cbo)
> -		return;
> +	struct nfsd4_cb_offload *cbo = &copy->cp_cb_offload;
>  
>  	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
>  	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
> @@ -1786,10 +1787,13 @@ static int nfsd4_do_async_copy(void *data)
>  	}
>  
>  do_callback:
> +	/* The kthread exits forthwith. Ensure that a subsequent
> +	 * OFFLOAD_CANCEL won't try to kill it again. */
> +	set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags);
> +
>  	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
>  	trace_nfsd_copy_async_done(copy);
>  	nfsd4_send_cb_offload(copy);
> -	cleanup_async_copy(copy);
>  	return 0;
>  }
>  
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 2a21a7662e03..dec29afa43f3 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -699,6 +699,9 @@ struct nfsd4_copy {
>  	struct nfsd42_write_res	cp_res;
>  	struct knfsd_fh		fh;
>  
> +	/* offload callback */
> +	struct nfsd4_cb_offload	cp_cb_offload;
> +
>  	struct nfs4_client      *cp_clp;
>  
>  	struct nfsd_file        *nf_src;
> -- 
> 2.46.2
> 

-- 
Chuck Lever

