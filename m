Return-Path: <linux-nfs+bounces-6456-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A29B978577
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACB9280AAB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5850718E1A;
	Fri, 13 Sep 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UxV9G7/X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BHW4E9F7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035055898;
	Fri, 13 Sep 2024 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243675; cv=fail; b=FUab+w7cfSQdE9ClJktFwIOBaFmu6Qixh0DX25qnXcE5amqe7c/jdIWbZsX7hYlb3hiAqx85H2pBpBsS2+uyGDe4azmKMsJuVKndfMxpiyzkZGD9SkIK205yyEoRo++U0WyFnX5pcHaD68hf7swFm/UWqR5rdlThOnaxn+T9dDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243675; c=relaxed/simple;
	bh=SVZrM7VLw1DVrJpSJLC8PTL+lXbzuURyP7WTchLqD2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qiLrrsWhZ+3x5nCxCadYPP4P/IVmAONsq/4Xc2PX+u5Cn9XDtg1jyKCJU2IgI8c5QhA9EgrCPNWheMevCggmUC/NrF//yzn1DWUovkzP75O3TueCscsvxIH2pFYKZ7TscnS7Ex4aVxrLK64WEoiI3/ammZbnP6AKabmjH3CO7Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UxV9G7/X; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BHW4E9F7 reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YJai029017;
	Fri, 13 Sep 2024 16:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=1lMuk4z864BTF9GzeJqCQ3CWsTrjkAE94ZEgMZAK3S8=; b=
	UxV9G7/XCFHWBSSx+U1vi5WdskbtwukzWAuwnRUVnNhd3v9tYaOkksCWTsT9O+05
	+38CNjo/MC+cvLRdeYGnI91Hnfr3T5vEgD/FNQ+3cupUfcKUjypkU6tPIwt2JTzT
	zthdcrM7cU5mxfxqwe7OzmxCmPt5zBpmJRZwS3IpzQ7RLFnswpPDfRLKCaNNo1B3
	GgQi5/dC/TMmLG07OdJimIsqrmzzz4PAR3W9NwNInPdHsTBPyTt9xT37PsCSanZ4
	tVVyImYZf3vxrvz90Z+7O8scdsofT7w0gbYdUJC9GdWWgLyK90Aj8vzReKJd3bNp
	xxN2Gv8bBv2SdP9dJh7kzw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde0e2ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 16:07:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFNSTb031602;
	Fri, 13 Sep 2024 16:07:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9dam9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 16:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srtJtHl0A7PyOQ+nQgINPdNOGCiAE9T/wh6xAYSHhrztxfVtLeeHm5TbIS5DPuBQzG30dtaBkvkfIHiRGiSZMAiauFCyaZRLWcGNVlhrCSFES4E4VMuCJx9JyDhhQTRq0aBUlyn3tCi7nsYfr9+GVNig7voOrNYqsCHZziJxevbeorPpxwGmauD01rBTGdcwHSvY9k7M2VU8sUkAFqPdfIfpkQqtv1FyUVPyBZe2m0a+rzGJX9il29PsulwK8vSPVozfS+b6LFclZFe/TDSD78D4sgLvqut/C2lQS3y6OABQaPy9TVX4+VhNZhGFErwsd5+K9D7zV+R963zWVoVhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/o8k5nOhWdvCQsfXOrCku5h0MOfqFv2Q+S0mFZdzuA=;
 b=c4aOkZFJ+LhNa0aBK/pCQXnUTStCcrVnbhIXIcqHy2iMHRFmvDmPVKDuvxlbbmaKtY45A9a86RRSiB0byoJtecAjpgaEBgTzFuFtqibhMK+i5Y//i7sRTlySmSCUmX+uSV0zk1DxrrfZUaK2miogl710PSSgLKTz/4w9jQDCmPMCAfxHVGhfL1T5/Jk4H2f6FaTIULnhaBfEdyq1KpzplqlIbGAXEWHfzA5HZlavJV2NoFXMPnnbTL5l/6zE0h95SRnZG5rKtiWqeWGSEI40/8LNYjKcNcMN/VfI76v2HM7bVR43qAwtQN+A1Qk5Ad0aEjhUEu6aAhpSsQKwYCn41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/o8k5nOhWdvCQsfXOrCku5h0MOfqFv2Q+S0mFZdzuA=;
 b=BHW4E9F7gFlpeDVGTQsHOp0UHNEiNFRee7Gbb+sNuJ6LXIarJTdw0vjereyE+l5HxlKCULQHnsrOIYBxzxHW8al0Tq+tcYVe3K4C628x1f+HieV2QpuMbc1Kt2LUY7OO8XzTpW0LwZxien30ujPM1D4YNBjdTA7Yk69Uk8/IGHw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7162.namprd10.prod.outlook.com (2603:10b6:610:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 16:07:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 16:07:39 +0000
Date: Fri, 13 Sep 2024 12:07:36 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fill NFSv4.1 server implementation fields in
 OP_EXCHANGE_ID response
Message-ID: <ZuRjSIyHguz3ult4@tissot.1015granger.net>
References: <20240912220919.23449-1-pali@kernel.org>
 <ZuRX/QfG+OLm9fTR@tissot.1015granger.net>
 <20240913153631.2lqq5nybuitjiwmo@pali>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913153631.2lqq5nybuitjiwmo@pali>
X-ClientProxiedBy: CH0PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:610:33::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b6a78d-3796-4a84-997b-08dcd40e30fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Ot0Q3efWpJ08M8tloSOBcuW4ACKZQIbJ6JtZf77xLtoqYitHQnMCZs5nAT?=
 =?iso-8859-1?Q?8QAxSp7pXvf+5cpKof1gw0XqBxoldj+ct783IxGj4o9qUsa8roSyWDTlTO?=
 =?iso-8859-1?Q?Cl3iiv74wTTsCfJ4x3fSS11vAMVvGPwhUJpV4r4f2lgHfmYfLSxOrTiCqV?=
 =?iso-8859-1?Q?4YMmKlKJjh9WCGCs8YOzQKkZteqnLGjugxGJn8DlEhq2yGU6nIu7n5xO6X?=
 =?iso-8859-1?Q?E4v43CyGOsIP/0BENfosACSmECIKLikSHCvDYvJhW4d+1zWEosJ0ld0ZDS?=
 =?iso-8859-1?Q?+/Ls40AOXsByBXDMbnSidp6piDRwmOsiKrOusvsIvuek8n1AJP8dwuVPLP?=
 =?iso-8859-1?Q?lHhDDYWNO/5u9gnY9XGTiFiEW0/KDQUu7hv17lgDdbIAcPR53fCBugGafm?=
 =?iso-8859-1?Q?YlWNmOAlx6Ee1fD0SG7Pw16oZ553MGruDHoDC2dJjvGw6PIGpzwDUl+zyi?=
 =?iso-8859-1?Q?+Dow9l0WJHm9j0Bt/4YVs6k+JXM71czw0Li0Z38dq4aYaCLJdNlk7Cv/pv?=
 =?iso-8859-1?Q?1fONfqUMgI8a3st60E7XxbmR2kbXE/J8WpFp27qIw0a4msAkDkxmQ1zZRJ?=
 =?iso-8859-1?Q?zt8h8rONukfYtv1i8BTMt92zpiqt6p1qgaDP9q6lTzAQ/KbxbAugY2CyIb?=
 =?iso-8859-1?Q?wYkQ6BZNR6wyBT9jP5IArPn1gn5t4ktYqnwEXpe3awUaU6R882bSmPyeq8?=
 =?iso-8859-1?Q?r+ILT6Ra2sFLqn8suTig4Gp3hJZGb37xq9YwKS+hQyWJtdUaVfqfvjKvUO?=
 =?iso-8859-1?Q?oan8//pqa2uSCZ4yfiYuBmA9U4zMeQOWXHnvcpYkXziA8XNmqvuAMpEucU?=
 =?iso-8859-1?Q?S4Pt8SuE95Z9bjhOuWmYHNu3ZohSva70ZNY4WAiAx7Dn44sCe7IJHPsXbI?=
 =?iso-8859-1?Q?IFmEbEtW2T6vqmr0h75gDgl3zSoqtUne577V9yyqSD1/JecDmlLxJ5LJcp?=
 =?iso-8859-1?Q?W4vawQ5LM9Jy3YaifnH+rd5ftQLlqqTpvOXgV0CeiZnxn884lH4xy9Tbkc?=
 =?iso-8859-1?Q?F4aeV0FpdXvd502Bb3KuvZZLQ9KfRw8aoXrVqss8knB04SN4ahNodHsx+/?=
 =?iso-8859-1?Q?iVsa3G2DGfD+WtCuo5hmGGhSdCoDLbYuWgi3OER/uGom+h4w8Z0x2wXWGA?=
 =?iso-8859-1?Q?KATESsg+dnuvda554IYOrFMQ4iWpMCVbfmGWf2MLJBy4E91IRc+PorCxJw?=
 =?iso-8859-1?Q?sx5bE+EO4gwCRurWtV9YP4AcGYiw/tWTeuj0wlVzlxkcBcBvS5chQURBv5?=
 =?iso-8859-1?Q?wBQdaSoS9YoFsYHr4yvyWJXkA4ep7vV6APWzEbdu7XC+LHKGnLhDT+/JTF?=
 =?iso-8859-1?Q?RmtNCaCPpMbI6bKsYkoEjOUtpLI/SCSuHpi18ZuyB1V5IhUE4+td5zcj9T?=
 =?iso-8859-1?Q?Xzh/NC7T4riG05DlVQsNLhmLh/d9r1tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?cso7tk8vL4J1CuZjJxHogEjbIkViTw9gjz+VwAhoCvurMyK1Prt0Ueuk7M?=
 =?iso-8859-1?Q?RH8Ah9c2zHIc8WYfvcCKJtDhXeKHANAhANkX4R7Q6Q0NHWgQ+kni7EN/xA?=
 =?iso-8859-1?Q?MP4RAtrsnKCPapstvvPY8MR4ePqJgOlprTHmOqGt1HMPAl4ND47T0V/wHa?=
 =?iso-8859-1?Q?HMDZFUQYCHeVINEyhiP+l+omwg23jDNQNVUTe1eZ7iI/pyw/Oc86ntwmB8?=
 =?iso-8859-1?Q?CLC9cYTNlOMZ4PHGz5X6E9ah2ZiJzkjSI4csajg3wcTn+Am5dA5SeSJBl3?=
 =?iso-8859-1?Q?GmmgtazjMCzO64+/M/fb0h0vRlYFuvOnocs7rcWB4BqD4ZPK3wNrNUlVDx?=
 =?iso-8859-1?Q?b22Mf14u7+VRuvEg2rXqnAVLZPDfTy876pTxNFcUQcV0IwBEPygACTMqVc?=
 =?iso-8859-1?Q?vtVlaXqccpJwXVBguutEWEo9eFhbidVx+6jdSGis0gA12pKnyzbxs2x9kF?=
 =?iso-8859-1?Q?8LJtrzeH75esvgKCaunJSB3Z1byhoYACRcUWBdkjmz5NDERL4c5AHY7R2h?=
 =?iso-8859-1?Q?Y/B4fb9KYB0EiTXd4DGcuHL8EGXDzOVA5ml8X/U4tbfE+seWMNA84yN7+S?=
 =?iso-8859-1?Q?yaBu0uM/x6hkq7hlmX6y46DxGy9U2hHSPH8JgusVRZmu8IQSUuPrPgZGDd?=
 =?iso-8859-1?Q?GvqkyGFA/9ylPrpwG/Xxdi8no0nwcUldy4GPrsAstKFYdSwgXTRIluhfBr?=
 =?iso-8859-1?Q?8CKAZooz5EPPRwDbrYllK4akXkQ67UbPeNL8dNxenC0klB5x9cObxMrvZ+?=
 =?iso-8859-1?Q?st9K8sPN2VguEvulmJ1Nzclfxb7fD6fR5+YzcV6/IEUpp/fzJ6YJy01EIl?=
 =?iso-8859-1?Q?EBuHe+iUVuH81xgJ7ZpOn3CgFC0fUArWa1SWRQaB5ZlDU5SyDGp5rptiGc?=
 =?iso-8859-1?Q?65zp8FgUs6NPc9rCkwF28oy1QMEff0pMfI3Rz9M/5y7i8B5l7srLUyNT8S?=
 =?iso-8859-1?Q?i+vCjMW7LK3Kd9yNUmuFFmNfxUwkXlauQynUKgxxkfgZl2+57Vumt0nzsU?=
 =?iso-8859-1?Q?LR/FGav5tlrtUFoqqZe4BRbtXAdR60P+76ZY0ksXwi7M4XkSb5zqJL7CGQ?=
 =?iso-8859-1?Q?f8QO19ir5hA3E9HRwPfjgTbt8WIaWpC2O87olW/ZQBpgngoV8GxCxRNwNE?=
 =?iso-8859-1?Q?fuTPGmrDDrDIYIE7JcI2GP/w9OSG1NMDiVc3G6xau5eRY9cGCLBRXQXki8?=
 =?iso-8859-1?Q?mAF+5yOAlqWgMmjy6j2iOxRzl2LsAZNtHOCOxR5ZZzVETQL0RYOxq6hNlc?=
 =?iso-8859-1?Q?yG65ftR1jNxHyKjporFQhlPUeJVXTdoQp1xM5OlN4pm7w28UNatreDAW2X?=
 =?iso-8859-1?Q?Tl2SQ/nwklCPGrn1fVIO+28MrA3HCmI34kUrT8PRbcZha3/69yqO6yr+Jy?=
 =?iso-8859-1?Q?lozoRvga15Y4WdGyZr5wbTI0+Ot9vSWwd5yCP0PqNDfDKoS7E4iI7wcR5M?=
 =?iso-8859-1?Q?pI7M6U61l0wrs5+nadCmLPqdFNy7KAagSd2z963x3sNwUtvsx80+zVjr8d?=
 =?iso-8859-1?Q?8YcGDzT4vWS212lFGGvXGZbaAEMFK6Ux00w9psZlMuVYZ0a/cdpl/DzmWR?=
 =?iso-8859-1?Q?WAOf6xZpvkMe7END31WsGSwcCoCKrt/A5uEOUDugIibx8d/Q4tYjz+Qtl5?=
 =?iso-8859-1?Q?W26vPoKW5tGgxosR/Vr3YjVHMjQ785Hx6w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M3E+9ENul2vKdZsrG/EwH3vWuIwU5vE3uhkXhmo43qbuD3AxUFo/Xhr/9bSG/NDQlYHerhC45ZCCfTEwmgeZMa06iMZS9JPoanUXAlLc8mutaaHBHnzayyE1zXsp8Yk1M1z9uDh0Az+7TmGm08muFdc+q2LDeWR2vthjPXuYLXdjhnCgEyrQskUKjB2Cbte86Vvr25SI0pnYAq3TaPzniGoJETKIXTdOBIH3Tp7neG0t4DTydwDTGB4YsoKwukXUUXsUNKoBcRMQdrDpgz5IKL7aB3JomUOoY4/rW85AzTG3IPY8/EeYFq1mNKKXZxFVjazCBW7phdlUaAGZT99cJx1sl1PvqNgEjkYJrd9vb6MTgRplupkWHN1NgUJVCFPt67QPpIs8DQ9/G2O4l5pbM6XAcqGmwRhtgrJ2Ml+DoaW7PNDuCsoF9tQbwaNbqt7qCUEHm35+W17jo9ZQSjpW6bJ+Fqmysm9NwU9rw9R+oWUy+tzxGqtkc2P3KAz9Q2YjbpvsNpoM2yuOaL3hGP1280JhcPR1xTrproFRbobAL0bnwYh0qxlOd0rWSwOxdjC+d4akGp6LnNA8NRs4eBzWUVqD1UXIKk5n7Qfr+Cvvuhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b6a78d-3796-4a84-997b-08dcd40e30fd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 16:07:39.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFf9fUtO1yh+ctpBEyy7aDg/Buz8fl90ApwPGNbMwW1LnzpxnQtV2XsshvETDZdIL5lNrWNeWNYTjYy+lye8PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130113
X-Proofpoint-ORIG-GUID: LRkhQRDcmTVofoc-o30_2ZfOArMW45Lv
X-Proofpoint-GUID: LRkhQRDcmTVofoc-o30_2ZfOArMW45Lv

On Fri, Sep 13, 2024 at 05:36:31PM +0200, Pali Rohár wrote:
> On Friday 13 September 2024 11:19:25 Chuck Lever wrote:
> > On Fri, Sep 13, 2024 at 12:09:19AM +0200, Pali Rohár wrote:
> > > NFSv4.1 OP_EXCHANGE_ID response from server may contain server
> > > implementation details (domain, name and build time) in optional
> > > nfs_impl_id4 field. Currently nfsd does not fill this field.
> > > 
> > > NFSv4.1 OP_EXCHANGE_ID call request from client may contain client
> > > implementation details and Linux NFSv4.1 client is already filling these
> > > information based on runtime module param "nfs.send_implementation_id" and
> > > build time Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN". Module param
> > > send_implementation_id specify whether to fill implementation fields and
> > > Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN" specify the domain
> > > string.
> > > 
> > > Do same in nfsd, introduce new runtime param "nfsd.send_implementation_id"
> > > and build time Kconfig option "NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN" and
> > > based on them fill NFSv4.1 server implementation details in OP_EXCHANGE_ID
> > > response. Logic in nfsd is exactly same as in nfs.
> > > 
> > > This aligns Linux NFSv4.1 server logic with Linux NFSv4.1 client logic.
> > > 
> > > NFSv4.1 client and server implementation fields are useful for statistic
> > > purposes or for identifying type of clients and servers.
> > 
> > NFSD has gotten along for more than a decade without returning this
> > information. The patch description should explain the use case in a
> > little more detail, IMO.
> > 
> > As a general comment, I recognize that you copied the client code
> > for EXCHANGE_ID to construct this patch. The client and server code
> > bases are somewhat different and have different coding conventions.
> > Most of the comments below have to do with those differences.
> 
> Ok, this can be adjusted/aligned.
> 
> > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > >  fs/nfsd/Kconfig   | 12 +++++++++++
> > >  fs/nfsd/nfs4xdr.c | 55 +++++++++++++++++++++++++++++++++++++++++++++--
> > >  2 files changed, 65 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > > index ec2ab6429e00..70067c29316e 100644
> > > --- a/fs/nfsd/Kconfig
> > > +++ b/fs/nfsd/Kconfig
> > > @@ -136,6 +136,18 @@ config NFSD_FLEXFILELAYOUT
> > >  
> > >  	  If unsure, say N.
> > >  
> > > +config NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN
> > > +	string "NFSv4.1 Implementation ID Domain"
> > > +	depends on NFSD_V4
> > > +	default "kernel.org"
> > > +	help
> > > +	  This option defines the domain portion of the implementation ID that
> > > +	  may be sent in the NFS exchange_id operation.  The value must be in
> > 
> > Nit: "that the server returns in its NFSv4 EXCHANGE_ID response."
> > 
> > 
> > > +	  the format of a DNS domain name and should be set to the DNS domain
> > > +	  name of the distribution.
> > 
> > Perhaps add: "See the description of the nii_domain field in Section
> > 3.3.21 of RFC 8881 for details."
> 
> Ok.
> 
> > But honestly, I'm not sure why nii_domain is parametrized at all, on
> > the client. Why not /always/ return "kernel.org" ?
> 
> I do not know. I just followed logic of client. In my opinion, it does
> not make sense to have different logic in client and server. If it is
> not needed, maybe remove it from client too?

> > What checking should be done to ensure that the value of this
> > setting is a valid DNS label?
> 
> Checking for valid DNS label is not easy. Client does not do it, so is
> it needed?

Input checking is always a good thing to do. But I haven't found a
compliance mandate in RFC 8881 for the content of nii_domain, so
maybe it doesn't matter.

One possibility would be to not add the parametrization of this
string on the server unless it is found to be needed. So, this
patch could simply always set "kernel.org", and then a Kconfig
option can be added by a subsequent patch if/when a use case ever
turns up.

Or... NFSD could simply re-use the client's setting. I can't think
of a reason why the NFS client and NFS server in the same kernel
should report different nii_domain strings.


> > > +	  If the NFS server is unchanged from the upstream kernel, this
> > > +	  option should be set to the default "kernel.org".
> > > +
> > >  config NFSD_V4_2_INTER_SSC
> > >  	bool "NFSv4.2 inter server to server COPY"
> > >  	depends on NFSD_V4 && NFS_V4_2
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index b45ea5757652..5e89f999d4c7 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -62,6 +62,9 @@
> > >  #include <linux/security.h>
> > >  #endif
> > >  
> > > +static bool send_implementation_id = true;
> > > +module_param(send_implementation_id, bool, 0644);
> > > +MODULE_PARM_DESC(send_implementation_id, "Send implementation ID with NFSv4.1 exchange_id");
> > 
> > I'd rather not add a module parameter if we don't have to. Can you
> > explain why this new parameter is necessary? For instance, is there
> > a reason why an administrator who runs NFSD on a stock distro kernel
> > would want to change this setting to "false" ?
> 
> I really do not know. Client has this parameter, so I though it is a
> good idea to have it.
> 
> > If it turns out that the parameter is valuable, is there admin
> > documentation to go with it?
> 
> I'm not sure if client have documentation for it.

Again, if we don't have a clear use case in front of us, it is
sensible to postpone the addition of this parameter.


[ ... snip ... ]

> > Regarding the content of these fields: I don't mind filling in
> > nii_date, duplicating what might appear in the nii_name field, if
> > that is not a bother.
> 
> I looked at this, and getting timestamp in numeric form is not possible.
> Kernel utsname() and UTS functions provides date only in `date` format
> which is unsuitable for parsing in kernel and converting into seconds
> since epoch. Moreover uts structures are exported to userspace, so
> changing and providing numeric value would be harder.

Not a big deal. And, it's something that can be changed later if
someone finds a clean way to extract a numeric build time.


-- 
Chuck Lever

