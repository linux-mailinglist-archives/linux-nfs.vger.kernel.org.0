Return-Path: <linux-nfs+bounces-4406-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DE291CE0D
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA81B210FD
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE331DDEA;
	Sat, 29 Jun 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SHC9Wosi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ArQXAfX3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C8A945
	for <linux-nfs@vger.kernel.org>; Sat, 29 Jun 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719676829; cv=fail; b=jbVbmY3eZezPZgYrlwatCL09aq1Znar+08PFRjogrkicq03rCQqZv5OnfYmjs37rOBHSiv0sVr0IifnuSzYTEKpZiCVCsS8Zm+Lm6j5ocVRZzXDxl3vTFddcXDJxIuvhGEkYLsSk4K1GAHbFnGtXNprcK0XJqeVAoWw2oIudzYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719676829; c=relaxed/simple;
	bh=vpxDmrJ1xYH/zQ0a0wcFCTHnPPAH577H6gS7lSIQdQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cnqgeACp60vV2zEC31nXjzaiD+erwzjvh4USrGgU3yIfZEqCu0cjgTuMdEMCvjqgB61u8yAfuDEjppj6dG29drqcdNN5A9PIn8u5PdxTilPSZeALqoZDIT33ynmk3uXWhbsdjqEZIFUAM7JYqA4hF1K1VqRwVmjRSMoZc/gnOkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SHC9Wosi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ArQXAfX3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45TCFwB8031596;
	Sat, 29 Jun 2024 16:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=v3uEEqa1OrIHTSb
	GvgThBKVBOzQy2zTeO18PBt+g2S8=; b=SHC9Wosim0tcRsSo/0q3668nBV3n0UO
	YFkuvkzmSqyeYvu1sJFYcokwLuAIz2hlqPvaHPxgmBghcI/DEJvB5rLogRvlJeAI
	0w/y8HNlKI5pHYTo8zW829DzHZnBnccBGeA/2r79K3gjITDRTLVjLv7y0TwzSiQq
	sQSnXZWFj+84OPv0jikgd0R4RwfVgBEtztH9+0sqeKlG99tASXoVpThl4THZgjlq
	2hltXCixNHMZcYBEDgErsLqojmU7AiX/qeetsYm9zCXoZcWzlt/gmyB9NoInNsxX
	LAbXUyLYjEypL+McQLJyvCUg8ZoXiJL1CQpr1CuJowlgvnrc/h2OHkQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsgfgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 16:00:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45TDqvMD033829;
	Sat, 29 Jun 2024 16:00:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q54urr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 16:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFfjHTwzhGoMfWJob+GRExGq1Avg4HZXtCUa9pa/CahC1gFrV3UvdqybT9ugau1rYUeFu3gwlimCDGWezK+NvUdIA8BmN7LORqJSZuY5pai7ya5lHjD84OuUiHihWatPOd+vaEpQyZUoVkWTSg0n4pzxYXFpZYOji5ix21tLRwdmk0ibMnzf5/8nEFPmkBJtUiF5fE5J/yGXOwE5EoCbmJYHeWQ065IFkJu90hJu2TNYbBW60J8KX76VTLZTAH/tEJnCdOqmX4yFBlfKbBim/2SyCvw4oOOYLd1yoMqK4hQ6a3HrORr1V+06TePM1lI3n9oTJeLjKFYogorxkBk2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3uEEqa1OrIHTSbGvgThBKVBOzQy2zTeO18PBt+g2S8=;
 b=YJJKxTV1G8Z07bo2rNldGuhl25XsOU+mFuK54ah7tOFcXt8rU9drF0Z5Jaxlr0CkoilJHuAUI4KMIyCQfnoiOZSArIYzvjK4iFVv4VTy82wj3+1DIye2u4EBnwRX++wG5y7e5HwfabHwp/CG/yPBX4Ch7RTE2Ac5w3tbyLczQ+18d/atLaThledLqX7xhAk7ypiJRJjXXkTT10iIE9vzbTNOKqlXzmFcQR/7IReB73leBcspWiUCKcwMODWhSt5eEvzlTsnz8skwHzIZLeKYye8eVI4ekW4VaI3MuBxyOQ9yQ4WThbBXOviKfHzUcoLwv1YnWU39P4Rdyqfz+6KstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3uEEqa1OrIHTSbGvgThBKVBOzQy2zTeO18PBt+g2S8=;
 b=ArQXAfX3C21rYF38vaKm//w3X/N+we4c0mKvmQcEdUIwH61lB8hkUgUCkMb6ZpBXcgAFk1o8hmbCCRbnwggVfM85oit+iByRduXg4pJMCUwa1Ds2xpgyIsgCBwnHHP+eQffF5rLm2uTBqXK14dG8MPfim1q9iV26Fi8K/R2+qLk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7277.namprd10.prod.outlook.com (2603:10b6:8:d8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Sat, 29 Jun 2024 16:00:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 16:00:04 +0000
Date: Sat, 29 Jun 2024 12:00:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v9 18/19] SUNRPC: replace program list with program array
Message-ID: <ZoAvgLhX+fOdoXXU@tissot.1015granger.net>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <20240628211105.54736-19-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628211105.54736-19-snitzer@kernel.org>
X-ClientProxiedBy: CH0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: ac936613-31ab-424e-161a-08dc98548a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IJqufqalq4FBOIt7Ne4hBKt61O9dMrTW/CtCvVcVeiSzie+a+20wgjPBDD+X?=
 =?us-ascii?Q?qaoPp+LTc4O36ah02jtSxUT8syayDk5Y40Wu+HDwd1nmM9ohHJCyR6QtxDu1?=
 =?us-ascii?Q?Xf6FgD6KSHbJEYS/pNFpm3Ttj9VvxOQbcn6PkMMa86YJj9YhSDPLdGg7A485?=
 =?us-ascii?Q?jzgdot/ZhE5yLyHwqYMjWtbKbAYsyxvKB+aHodXkPWIfVHAgUdEFtE5NpqBt?=
 =?us-ascii?Q?LOx2p3WzcIhuTwo25g0MLZJvwXAtIdJ+8HDAxeN6yLBuQBZp5CgZuuRFvUn9?=
 =?us-ascii?Q?q7nJ/qk5bFK/X/8o+y1w+yAxWye0iyxzrE8o4XH9169yeOW54yopcH22iGOz?=
 =?us-ascii?Q?IE1nnNvwBNXgUoAA/yYJPybXEa8BacnjcCwcxFsW/idpxNDqiGMDTezqtxz2?=
 =?us-ascii?Q?Z4kl80RdqzFayei3zoINeQms8V0Vt1wD86HZdf3gVScIlskZMZvT539fWpwy?=
 =?us-ascii?Q?7Bn9zyalywnau2SNJCb9K+YZATjPTscblry3psTaQ0H/IOh+5iDoyo0ir7vr?=
 =?us-ascii?Q?KRc6t9ZllgCuDKfQJCyNwajPVNQ+iZpbP4IJV1ch+K6jx8PldUdwa7dq5RMS?=
 =?us-ascii?Q?8t67cgoh5oMBJtle7gYUDaPrHOFPqhiBHDKLpApbl93nyBm6iVhn+j/wTWLK?=
 =?us-ascii?Q?ZvH55F1aAdZ5wZ5hEVqw76neHVEgbaqKA6jcVvo3ZQO5WfqWKZllIL/MTFmU?=
 =?us-ascii?Q?GsoBRY43Nf/NkygbQYR/CiKi1qwfQ8EidmEEH5Iunr1aHmsxjsYaYvpVlyNl?=
 =?us-ascii?Q?ltBWXR6YjlHdZ1V90v2rgmnbTUFRS+swNVxuK+dDxMXo8QO3U15lFHEtCeX6?=
 =?us-ascii?Q?VQp4CQxxuimYOZciRYbURFdo2wHMpPmt1Y2qrHg0ypDR55wNmFVg6hpOOVAi?=
 =?us-ascii?Q?kjf1Od0gt8LxwibuMloXO9ujTP5+hrDZjWoGXNHu7DOwcf7BDUi6cqW4jgjQ?=
 =?us-ascii?Q?Ok70Fcuz0OaToA9bcM+Xx+vO0iTaoxu1RRB4taSiN4xGoGUlRL6ZcsrXURV2?=
 =?us-ascii?Q?chkxDpW72IQBb1D8aq8TQ6ntOlRMPfbmdp21U9mrTDINz1atLGx0Oucx4311?=
 =?us-ascii?Q?aKLminkv3B7DG3SAxjsiivzYi8g0ej1K2cxV4+PhCyToUH21u7Ep/Pg0FrK9?=
 =?us-ascii?Q?SHP9XepgrhL0l6as/8iHw3av+0FZPndLADSV4P0INKZHVR1FX2omi6O1tPrI?=
 =?us-ascii?Q?LmDeBnX09TuwgCD1fh0ovp0EARCauThZM24fef9mqR+7ZLoNGESD6ParWO2e?=
 =?us-ascii?Q?hT0UYdbRQKEFpCa0o0US55Y3FZpio1OYjwQHC78pI0T1Bq/KLvaMoZusAWtO?=
 =?us-ascii?Q?aX7ED80iHHdymPzpiBuGdmfj5h3xudKd4mrZgwKr5rlaKQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TCRZ2e+CsHwdWPip3rTCdcmFjQVaACRSUseEEdyNATY2zq9GmPrBaaOXLfFX?=
 =?us-ascii?Q?8JnQeFLex5+3vXy8FG/FlUn5ODwdY3ty33q3sgEOs7HwKPdeQq1u4pVIExbJ?=
 =?us-ascii?Q?Vm0x2s0VY0JysDiynBOwyFyLdAsFIZytCo1FlpGfch/rWsPklg69pSCtGEL5?=
 =?us-ascii?Q?fr7OZRzLR9SQr3HkhrvlcP9aG+WBrWugxbi8nyQLqeLomgeJGN1+EcOfcW+V?=
 =?us-ascii?Q?UtC8/DhF6z0iolBYbbiTpsFE2KpBCoAOeHaY8ee8Lul8yBecT+Ye1TeLuBx/?=
 =?us-ascii?Q?U3T+UGXAJKSDfuBKhQQlxkQKVdKLoNew06YxYEO3jFzzI5HO7b9rhpSfBri4?=
 =?us-ascii?Q?N/DzLMxUilaNHLcT2o7/qpudRDUduiy1Dh0FgM39aoA7lijhaN+qn65jHbgI?=
 =?us-ascii?Q?2aEFaHAnzQGuzzaVjos1gwsDlTVR8CKtgXb4Jl6vc3wcz0G8MLiAiVZ4vtnp?=
 =?us-ascii?Q?AYQGe6YzxsJR533a2jPoab+bkDMiI2Up1xc+CEq6erZOL6WcYhmU9jGsguC/?=
 =?us-ascii?Q?2G/zZbB1vCH27z4c1/6fNMcAE1PYljxhwqWbxllwUHYIvwMTsDHPMxUd4L7/?=
 =?us-ascii?Q?u5sSFq9RhLyhmchfWIwX3tPOyS1WtHPxbuUluCaeMXm3SNCWNRegW7MWP6dA?=
 =?us-ascii?Q?tI+YIxKueDgH37C4IGPv524tgVUy5jRarPwNkOKMAsoUqMuIdcJmND5SihRV?=
 =?us-ascii?Q?P7esn3GXdfSV1w/rZfcO8jdkQrNQ/dk2s2iCTXGWBEyQ9wiFjO3PrgW8257L?=
 =?us-ascii?Q?0cbgzD8b7MYJLB+11IfnrIElegAuYroHj2b7LH8rbAzh9mZijJm4dc4tQSVi?=
 =?us-ascii?Q?5+AdOwF+VrDTMMy1hn+hJaK29Wl2ZdZuIjVd0R11XmzLjY1SkqgwXBVaF716?=
 =?us-ascii?Q?z4/NmfPIIbgVbK0iDdguSy7b4AuVoqepmZPH/WXRZZ/D/5LusQUwtddVfQGt?=
 =?us-ascii?Q?n1dPfjfga6dZU0Bj7haoepWNQcUV5x5l6Ks7E9rLm6SnIzLD2I2dcNuvOn7l?=
 =?us-ascii?Q?5pvNGNDMs4l624JyEo27I/BrUmw2emZgOgbnrqKNxsJGZVTZm7zT8h5K55Ah?=
 =?us-ascii?Q?2EUYiUaSibpJx/ISVtkflQHwHjw8+KD+wyBBhORTnHNaG4GkUe/bDV3ih4dn?=
 =?us-ascii?Q?6q0ZMnndPizxTxXfKWGJibVlE0ocgGEKdFkCkeG1tazWMYoIM3gUHrJbRmNO?=
 =?us-ascii?Q?ypJeq5X0Q2B49e8zI4jNDYU3FldfSGzx2Hzh3m1/zklyjui+3Xi8+cimLGji?=
 =?us-ascii?Q?EMwJgmyzUKNBV6xIjTEPsno84qNcH61JHDosqXn9ejs8cH5O9y7fre/p5ilY?=
 =?us-ascii?Q?/r3oz4meRDVpt8GeW/U2zS1MU62PJTSlpyBZeua/C4FHGoSdn4Zf/m+8TPk+?=
 =?us-ascii?Q?Co/IxuybthssD9rdftPe86Cr7zWM0bIrED5z6YjXaKWNMInnPwnx5qUzgBgd?=
 =?us-ascii?Q?jC/DlaQeanUFonXuYUmL/cun3e9ET//vZjDtmQNsPc09t9FD95bFRBbR0js0?=
 =?us-ascii?Q?qs+ve5LzNeeWKK9ZdL0vU5kpCJuN53StFmOtUD82iIAMer0Hp7xIJ+rZibOV?=
 =?us-ascii?Q?JDEWJXGOPoc9swm5lxvblYkkFjQSIYEuO83I88P2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KHQqOZaN8CMffYEQb7REJ70M0zjrO1GZKnwGwpFUdcAzX/s+JLyX62XVKVEMHN9uVvsSb1DxQyc11CQmY+ahj24yiKJL/rZ4rixVqXxINcmHGX8lommf7OPU7n0NEDy6jRdjG6kMelnTn5pPLCTZ5CW/+GKoPfuCXrUkTuRUlQiODjccDwFLzymjqFdHtXQHDo40KZyoXGs+uVPDmubC23nKYsPhtYSzW6xUB4nq6fxSLtZ1HAP2dEp7C0On51ndJYrcE7AvqoVRruUacY3uaSISTuydBgfOhhd2pTsnKmCnT4IkjHhx0Df8TI1T2pXUmAOuE1p4zh7M+JnvXo6PfMsO8W17ILm8/HrBWhdihYXMfcmdcCaEY1LvayVq1uNQVnzHRMoexU6yVnqck9eoSEDngidiIZIVbjWqeUWFIRJRH5kUfU31Ac1n+N5FkdMvvt5FcDk8KtAWCL0yNdisFBORDGvJiIUTEHuLdjUxvN0Yx8XlZ23BudLXHNzR0UXiysg66fs8uhwhOoH6W5SmyFHmETXpIE5s+dXIaXN41U2DX9xNkOAjVaaZF9MZ2beFImnzsAOnapKrMZzdFXfvFhTe9pKZryvv782fTXBohQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac936613-31ab-424e-161a-08dc98548a05
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 16:00:04.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Co5hq/YAkOtJKJFhat1I+BvPq91mDUCvlHtD2LQKcynt3f8jNKlmO4TLeBlbJiIhrKl2O+uvVWOCaQduesrY4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406290113
X-Proofpoint-GUID: ICpNdudgXCPxrMmej2y-4xb5ah3DJ_ly
X-Proofpoint-ORIG-GUID: ICpNdudgXCPxrMmej2y-4xb5ah3DJ_ly

On Fri, Jun 28, 2024 at 05:11:04PM -0400, Mike Snitzer wrote:
> From: NeilBrown <neil@brown.name>
> 
> A service created with svc_create_pooled() can be given a linked list of
> programs and all of these will be served.
> 
> Using a linked list makes it cumbersome when there are several programs
> that can be optionally selected with CONFIG settings.
> 
> So change to use an array with explicit size.  svc_create() is always
> passed a single program.  svc_create_pooled() now must be used for
> multiple programs.

Instead of this last sentence, it might be more clear to say:

> After this patch is applied, API consumers must use only
> svc_create_pooled() when creating an RPC service that listens for
> more than one RPC program.

I like the idea of replacing these static linked lists.


> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/nfsctl.c           |  2 +-
>  fs/nfsd/nfsd.h             |  2 +-
>  fs/nfsd/nfssvc.c           | 69 ++++++++++++++++++--------------------
>  include/linux/sunrpc/svc.h |  7 ++--
>  net/sunrpc/svc.c           | 68 +++++++++++++++++++++----------------
>  net/sunrpc/svc_xprt.c      |  2 +-
>  net/sunrpc/svcauth_unix.c  |  3 +-
>  7 files changed, 80 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index e5d2cc74ef77..6fb92bb61c6d 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2265,7 +2265,7 @@ static __net_init int nfsd_net_init(struct net *net)
>  	if (retval)
>  		goto out_repcache_error;
>  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
> -	nn->nfsd_svcstats.program = &nfsd_program;
> +	nn->nfsd_svcstats.program = &nfsd_programs[0];
>  	nn->nfsd_versions = NULL;
>  	nn->nfsd4_minorversions = NULL;
>  	nfsd4_init_leases_net(nn);
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index cec8697b1cd6..c3f7c5957950 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -80,7 +80,7 @@ struct nfsd_genl_rqstp {
>  	u32			rq_opnum[NFSD_MAX_OPS_PER_COMPOUND];
>  };
>  
> -extern struct svc_program	nfsd_program;
> +extern struct svc_program	nfsd_programs[];
>  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
>  extern struct mutex		nfsd_mutex;
>  extern spinlock_t		nfsd_drc_lock;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 6cc6a1971e21..ef2532303ece 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -36,7 +36,6 @@
>  #define NFSDDBG_FACILITY	NFSDDBG_SVC
>  
>  atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
> -extern struct svc_program	nfsd_program;
>  static int			nfsd(void *vrqstp);
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  static int			nfsd_acl_rpcbind_set(struct net *,
> @@ -89,16 +88,6 @@ static const struct svc_version *localio_versions[] = {
>  
>  #define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(localio_versions)
>  
> -static struct svc_program	nfsd_localio_program = {
> -	.pg_prog		= NFS_LOCALIO_PROGRAM,
> -	.pg_nvers		= NFSD_LOCALIO_NRVERS,
> -	.pg_vers		= localio_versions,
> -	.pg_name		= "nfslocalio",
> -	.pg_class		= "nfsd",
> -	.pg_authenticate	= &svc_set_client,
> -	.pg_init_request	= svc_generic_init_request,
> -	.pg_rpcbind_set		= svc_generic_rpcbind_set,
> -};
>  #endif /* CONFIG_NFSD_LOCALIO */
>  
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> @@ -111,23 +100,9 @@ static const struct svc_version *nfsd_acl_version[] = {
>  # endif
>  };
>  
> -#define NFSD_ACL_MINVERS            2
> +#define NFSD_ACL_MINVERS	2
>  #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
>  
> -static struct svc_program	nfsd_acl_program = {
> -#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> -	.pg_next		= &nfsd_localio_program,
> -#endif /* CONFIG_NFSD_LOCALIO */
> -	.pg_prog		= NFS_ACL_PROGRAM,
> -	.pg_nvers		= NFSD_ACL_NRVERS,
> -	.pg_vers		= nfsd_acl_version,
> -	.pg_name		= "nfsacl",
> -	.pg_class		= "nfsd",
> -	.pg_authenticate	= &svc_set_client,
> -	.pg_init_request	= nfsd_acl_init_request,
> -	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
> -};
> -
>  #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
>  
>  static const struct svc_version *nfsd_version[] = {
> @@ -140,25 +115,44 @@ static const struct svc_version *nfsd_version[] = {
>  #endif
>  };
>  
> -#define NFSD_MINVERS    	2
> +#define NFSD_MINVERS		2
>  #define NFSD_NRVERS		ARRAY_SIZE(nfsd_version)
>  
> -struct svc_program		nfsd_program = {
> -#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> -	.pg_next		= &nfsd_acl_program,
> -#else
> -#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> -	.pg_next		= &nfsd_localio_program,
> -#endif /* CONFIG_NFSD_LOCALIO */
> -#endif
> +struct svc_program		nfsd_programs[] = {
> +	{
>  	.pg_prog		= NFS_PROGRAM,		/* program number */
>  	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
>  	.pg_vers		= nfsd_version,		/* version table */
>  	.pg_name		= "nfsd",		/* program name */
>  	.pg_class		= "nfsd",		/* authentication class */
> -	.pg_authenticate	= &svc_set_client,	/* export authentication */
> +	.pg_authenticate	= svc_set_client,	/* export authentication */
>  	.pg_init_request	= nfsd_init_request,
>  	.pg_rpcbind_set		= nfsd_rpcbind_set,
> +	},
> +#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> +	{
> +	.pg_prog		= NFS_ACL_PROGRAM,
> +	.pg_nvers		= NFSD_ACL_NRVERS,
> +	.pg_vers		= nfsd_acl_version,
> +	.pg_name		= "nfsacl",
> +	.pg_class		= "nfsd",
> +	.pg_authenticate	= svc_set_client,
> +	.pg_init_request	= nfsd_acl_init_request,
> +	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
> +	},
> +#endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	{
> +	.pg_prog		= NFS_LOCALIO_PROGRAM,
> +	.pg_nvers		= NFSD_LOCALIO_NRVERS,
> +	.pg_vers		= localio_versions,
> +	.pg_name		= "nfslocalio",
> +	.pg_class		= "nfsd",
> +	.pg_authenticate	= svc_set_client,
> +	.pg_init_request	= svc_generic_init_request,
> +	.pg_rpcbind_set		= svc_generic_rpcbind_set,
> +	}
> +#endif /* IS_ENABLED(CONFIG_NFSD_LOCALIO) */
>  };
>  
>  bool nfsd_support_version(int vers)
> @@ -735,7 +729,8 @@ int nfsd_create_serv(struct net *net)
>  	if (nfsd_max_blksize == 0)
>  		nfsd_max_blksize = nfsd_get_default_max_blksize();
>  	nfsd_reset_versions(nn);
> -	serv = svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
> +	serv = svc_create_pooled(nfsd_programs, ARRAY_SIZE(nfsd_programs),
> +				 &nn->nfsd_svcstats,
>  				 nfsd_max_blksize, nfsd);
>  	if (serv == NULL)
>  		return -ENOMEM;
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index a7d0406b9ef5..7c86b1696398 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -66,9 +66,10 @@ enum {
>   * We currently do not support more than one RPC program per daemon.
>   */
>  struct svc_serv {
> -	struct svc_program *	sv_program;	/* RPC program */
> +	struct svc_program *	sv_programs;	/* RPC programs */
>  	struct svc_stat *	sv_stats;	/* RPC statistics */
>  	spinlock_t		sv_lock;
> +	unsigned int		sv_nprogs;	/* Number of sv_programs */
>  	unsigned int		sv_nrthreads;	/* # of server threads */
>  	unsigned int		sv_maxconn;	/* max connections allowed or
>  						 * '0' causing max to be based
> @@ -329,10 +330,9 @@ struct svc_process_info {
>  };
>  
>  /*
> - * List of RPC programs on the same transport endpoint
> + * RPC program - an array of these can use the same transport endpoint
>   */
>  struct svc_program {
> -	struct svc_program *	pg_next;	/* other programs (same xprt) */
>  	u32			pg_prog;	/* program number */
>  	unsigned int		pg_lovers;	/* lowest version */
>  	unsigned int		pg_hivers;	/* highest version */
> @@ -414,6 +414,7 @@ void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
>  void		   svc_rqst_free(struct svc_rqst *);
>  void		   svc_exit_thread(struct svc_rqst *);
>  struct svc_serv *  svc_create_pooled(struct svc_program *prog,
> +				     unsigned int nprog,
>  				     struct svc_stat *stats,
>  				     unsigned int bufsize,
>  				     int (*threadfn)(void *data));
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 965a27806bfd..d9f348aa0672 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -440,10 +440,11 @@ EXPORT_SYMBOL_GPL(svc_rpcb_cleanup);
>  
>  static int svc_uses_rpcbind(struct svc_serv *serv)
>  {
> -	struct svc_program	*progp;
> -	unsigned int		i;
> +	unsigned int		p, i;
> +
> +	for (p = 0; p < serv->sv_nprogs; p++) {
> +		struct svc_program *progp = &serv->sv_programs[p];
>  
> -	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
>  		for (i = 0; i < progp->pg_nvers; i++) {
>  			if (progp->pg_vers[i] == NULL)
>  				continue;
> @@ -480,7 +481,7 @@ __svc_init_bc(struct svc_serv *serv)
>   * Create an RPC service
>   */
>  static struct svc_serv *
> -__svc_create(struct svc_program *prog, struct svc_stat *stats,
> +__svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stats,
>  	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
>  {
>  	struct svc_serv	*serv;
> @@ -491,7 +492,8 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
>  	if (!(serv = kzalloc(sizeof(*serv), GFP_KERNEL)))
>  		return NULL;
>  	serv->sv_name      = prog->pg_name;
> -	serv->sv_program   = prog;
> +	serv->sv_programs  = prog;
> +	serv->sv_nprogs    = nprogs;
>  	serv->sv_stats     = stats;
>  	if (bufsize > RPCSVC_MAXPAYLOAD)
>  		bufsize = RPCSVC_MAXPAYLOAD;
> @@ -499,17 +501,18 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
>  	serv->sv_max_mesg  = roundup(serv->sv_max_payload + PAGE_SIZE, PAGE_SIZE);
>  	serv->sv_threadfn = threadfn;
>  	xdrsize = 0;
> -	while (prog) {
> -		prog->pg_lovers = prog->pg_nvers-1;
> -		for (vers=0; vers<prog->pg_nvers ; vers++)
> -			if (prog->pg_vers[vers]) {
> -				prog->pg_hivers = vers;
> -				if (prog->pg_lovers > vers)
> -					prog->pg_lovers = vers;
> -				if (prog->pg_vers[vers]->vs_xdrsize > xdrsize)
> -					xdrsize = prog->pg_vers[vers]->vs_xdrsize;
> +	for (i = 0; i < nprogs; i++) {
> +		struct svc_program *progp = &prog[i];
> +
> +		progp->pg_lovers = progp->pg_nvers-1;
> +		for (vers = 0; vers < progp->pg_nvers ; vers++)
> +			if (progp->pg_vers[vers]) {
> +				progp->pg_hivers = vers;
> +				if (progp->pg_lovers > vers)
> +					progp->pg_lovers = vers;
> +				if (progp->pg_vers[vers]->vs_xdrsize > xdrsize)
> +					xdrsize = progp->pg_vers[vers]->vs_xdrsize;
>  			}
> -		prog = prog->pg_next;
>  	}
>  	serv->sv_xdrsize   = xdrsize;
>  	INIT_LIST_HEAD(&serv->sv_tempsocks);
> @@ -558,13 +561,14 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
>  struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
>  			    int (*threadfn)(void *data))
>  {
> -	return __svc_create(prog, NULL, bufsize, 1, threadfn);
> +	return __svc_create(prog, 1, NULL, bufsize, 1, threadfn);
>  }
>  EXPORT_SYMBOL_GPL(svc_create);
>  
>  /**
>   * svc_create_pooled - Create an RPC service with pooled threads
> - * @prog: the RPC program the new service will handle
> + * @prog:  Array of RPC programs the new service will handle
> + * @nprogs: Number of programs in the array
>   * @stats: the stats struct if desired
>   * @bufsize: maximum message size for @prog
>   * @threadfn: a function to service RPC requests for @prog
> @@ -572,6 +576,7 @@ EXPORT_SYMBOL_GPL(svc_create);
>   * Returns an instantiated struct svc_serv object or NULL.
>   */
>  struct svc_serv *svc_create_pooled(struct svc_program *prog,
> +				   unsigned int nprogs,
>  				   struct svc_stat *stats,
>  				   unsigned int bufsize,
>  				   int (*threadfn)(void *data))
> @@ -579,7 +584,7 @@ struct svc_serv *svc_create_pooled(struct svc_program *prog,
>  	struct svc_serv *serv;
>  	unsigned int npools = svc_pool_map_get();
>  
> -	serv = __svc_create(prog, stats, bufsize, npools, threadfn);
> +	serv = __svc_create(prog, nprogs, stats, bufsize, npools, threadfn);
>  	if (!serv)
>  		goto out_err;
>  	serv->sv_is_pooled = true;
> @@ -602,16 +607,16 @@ svc_destroy(struct svc_serv **servp)
>  
>  	*servp = NULL;
>  
> -	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
> +	dprintk("svc: svc_destroy(%s)\n", serv->sv_programs->pg_name);
>  	timer_shutdown_sync(&serv->sv_temptimer);
>  
>  	/*
>  	 * Remaining transports at this point are not expected.
>  	 */
>  	WARN_ONCE(!list_empty(&serv->sv_permsocks),
> -		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
> +		  "SVC: permsocks remain for %s\n", serv->sv_programs->pg_name);
>  	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
> -		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
> +		  "SVC: tempsocks remain for %s\n", serv->sv_programs->pg_name);
>  
>  	cache_clean_deferred(serv);
>  
> @@ -1156,15 +1161,16 @@ int svc_register(const struct svc_serv *serv, struct net *net,
>  		 const int family, const unsigned short proto,
>  		 const unsigned short port)
>  {
> -	struct svc_program	*progp;
> -	unsigned int		i;
> +	unsigned int		p, i;
>  	int			error = 0;
>  
>  	WARN_ON_ONCE(proto == 0 && port == 0);
>  	if (proto == 0 && port == 0)
>  		return -EINVAL;
>  
> -	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
> +	for (p = 0; p < serv->sv_nprogs; p++) {
> +		struct svc_program *progp = &serv->sv_programs[p];
> +
>  		for (i = 0; i < progp->pg_nvers; i++) {
>  
>  			error = progp->pg_rpcbind_set(net, progp, i,
> @@ -1216,13 +1222,14 @@ static void __svc_unregister(struct net *net, const u32 program, const u32 versi
>  static void svc_unregister(const struct svc_serv *serv, struct net *net)
>  {
>  	struct sighand_struct *sighand;
> -	struct svc_program *progp;
>  	unsigned long flags;
> -	unsigned int i;
> +	unsigned int p, i;
>  
>  	clear_thread_flag(TIF_SIGPENDING);
>  
> -	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
> +	for (p = 0; p < serv->sv_nprogs; p++) {
> +		struct svc_program *progp = &serv->sv_programs[p];
> +
>  		for (i = 0; i < progp->pg_nvers; i++) {
>  			if (progp->pg_vers[i] == NULL)
>  				continue;
> @@ -1328,7 +1335,7 @@ svc_process_common(struct svc_rqst *rqstp)
>  	struct svc_process_info process;
>  	enum svc_auth_status	auth_res;
>  	unsigned int		aoffset;
> -	int			rc;
> +	int			pr, rc;
>  	__be32			*p;
>  
>  	/* Will be turned off only when NFSv4 Sessions are used */
> @@ -1352,9 +1359,12 @@ svc_process_common(struct svc_rqst *rqstp)
>  	rqstp->rq_vers = be32_to_cpup(p++);
>  	rqstp->rq_proc = be32_to_cpup(p);
>  
> -	for (progp = serv->sv_program; progp; progp = progp->pg_next)
> +	for (pr = 0; pr < serv->sv_nprogs; pr++) {
> +		progp = &serv->sv_programs[pr];
> +
>  		if (rqstp->rq_prog == progp->pg_prog)
>  			break;
> +	}
>  
>  	/*
>  	 * Decode auth data, and add verifier to reply buffer.
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index d3735ab3e6d1..16634afdf253 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -268,7 +268,7 @@ static int _svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
>  		spin_unlock(&svc_xprt_class_lock);
>  		newxprt = xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
>  		if (IS_ERR(newxprt)) {
> -			trace_svc_xprt_create_err(serv->sv_program->pg_name,
> +			trace_svc_xprt_create_err(serv->sv_programs->pg_name,
>  						  xcl->xcl_name, sap, len,
>  						  newxprt);
>  			module_put(xcl->xcl_owner);
> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index 04b45588ae6f..8ca98b146ec8 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -697,7 +697,8 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
>  	rqstp->rq_auth_stat = rpc_autherr_badcred;
>  	ipm = ip_map_cached_get(xprt);
>  	if (ipm == NULL)
> -		ipm = __ip_map_lookup(sn->ip_map_cache, rqstp->rq_server->sv_program->pg_class,
> +		ipm = __ip_map_lookup(sn->ip_map_cache,
> +				      rqstp->rq_server->sv_programs->pg_class,
>  				    &sin6->sin6_addr);
>  
>  	if (ipm == NULL)
> -- 
> 2.44.0
> 
> 

-- 
Chuck Lever

