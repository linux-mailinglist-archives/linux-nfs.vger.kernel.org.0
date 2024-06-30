Return-Path: <linux-nfs+bounces-4448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1734891D468
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 00:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A7F1F21154
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5FD6EB73;
	Sun, 30 Jun 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X+DBd6aP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FQAhgrYt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26C6EB4A
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786242; cv=fail; b=c9fONxwg8nwsX6+LtgiwJHpxh6OWcL1mXoo3jHjYe5KSHQsY+kYLrzuQ98z9FLOpMoHLNi5m1qVf/gJkgqJcYp3JK31k+lVdkPYdlj3jNwavEz2UsQGtw14Ip55QuPH+kClu5+Dkgoz/bjrvoJjN63XfZL5wBiyTeQYAT+2wECw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786242; c=relaxed/simple;
	bh=OU6QsIjdIy9tGkWX3LC4MgkvyfVmdgh2hzMFgNRRYRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VZz8yJKi5sw+ZS0/5sj6P56RXAbUv+9SvM0Y+ZWsn+oUFlU/rxaNA7H4mzm/WTCxGLfNqAjOVobbCAIlFHBy3IZjW/LP7Ij/kAbID6lmIdcCx+OxMvTiKM/rMfjLVpPcX+LNn4b58wYSuQDE82baY6FeNhcRwJN0eDgC7zGOniA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X+DBd6aP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FQAhgrYt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ULJrbE009789;
	Sun, 30 Jun 2024 22:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=v0iXRMtjcCR2Sff
	v+yBW9IUs8PrDlKTv4ybcXA6n4q4=; b=X+DBd6aPsq3DpSMV6xAq6jG3z+TvDje
	AxRdKoJm3B2uD6GNjmgXJPZaY8AKT9QWFYhYjQJTKKJl7lCWM0IewWd7J1WpcMKI
	OUL5OiutdigtpSEzbqOyIHGfdzdmcIOrb6PJtkxOEc/YcAY0/Fcn8+cXkSWGpiwJ
	boay8QBsmPduVVhyVJIZ73iOZStMhkRGgrQ9vTARrrR/BlgKOOEuXQjzIMlI4oz7
	L9scc6MbHfMSqXUWJCGNOIjHobc4d2aorflph75FNa3hf9Sb3D+WswxmTXZd+7p5
	Us0j+12P+wuXcQzQ0Qvv9uUkOAUJNHBJend/vNxflN3SJu/nYtKcqLg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a591hhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 22:23:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45UI4Vlm018993;
	Sun, 30 Jun 2024 22:23:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qc32fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 22:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfyAIwM4Znn81AQkUX2upQ2he28XgD4PthXWY5V8HcX5bUGqEULlDhJgVJIp6aNj0UrRtUAb4y+RUdZY2qxkMLjN0+519lGKFG0LhqwKgkakQb5vY3TS2Sr8vqXJ+xkqLccx88mUY39T6SpX2iZ/3OdFJCBQTppDRG0ZPwa6FDDx4Pi5Tpv1HPRotyZQLih35wARfnrvslXoJ74e0hQFYYsbFE7feqVsPKI5qnyK9H4b7/sWURGWkA57v/FwTL93dH5DfAH44X9YEcOTSrGlms55TmlCOgbfwsU7wgykBpq4ML1LGDath92DycrZVAtET6ziro78ugegFlEqjuo42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0iXRMtjcCR2Sffv+yBW9IUs8PrDlKTv4ybcXA6n4q4=;
 b=LBiBU3xtKjUT0tdP9p6CGFvc0VhLKZCT2uvPlgKWBoc/wkwxnZyrXXd+ckdJKaB0YDJZj38Qj9l7NFb4Wn/PqGy8KlZL6Kc7MH+QcGd85hHEtjeB3BbuaxMSkvDzvR0nAMST2tb6JmXGPPlXMzoTdz/WTLHlc7HIALVlRyMm/c9rNb7ZOx/rGt5GFI4m/ABLExcdzUuGAtTfwjqt7y9sMNxiTWMwIUUPWJOvGM7tCF0Swc5ZwQq2TKjqxOB50+h+eBGy8XfVFrXohw/aGVIpdiWQaQov0IcW8Jhr3cpgUUXEhH8150mow5uD8gdQ5n7oZXHDHCnwzMKy+HJG27ImEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0iXRMtjcCR2Sffv+yBW9IUs8PrDlKTv4ybcXA6n4q4=;
 b=FQAhgrYt8QraMc6UvvYCnS0Zaj57Sg1Dvtfh2FJrRD+DEeI+HCsg9KH/2iS7z3Ajc/Mo1Z1N2DgdfUFSQWzakIu42oPdHIseZVHeDwwOkvIk7Tx00im6pnMRSu7h2coaa9u0zAtksuSpzL0aHAmBhzZAjs/1flxFgJUvtyGj3qs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8196.namprd10.prod.outlook.com (2603:10b6:610:246::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 22:23:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 22:23:42 +0000
Date: Sun, 30 Jun 2024 18:23:39 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v9 07/19] nfs/localio: fix nfs_localio_vfs_getattr() to
 properly support v4
Message-ID: <ZoHa67EVj49oxqhn@tissot.1015granger.net>
References: <>
 <ZoAtT4M3jCIF8pIC@tissot.1015granger.net>
 <171978489020.16071.9497041442174299803@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171978489020.16071.9497041442174299803@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:610:4c::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8cf863-37aa-4dc1-df64-08dc99534c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6n1J7kL31Piq5x5x2nXijv9S0eSzeL+iOedczeokw6c7acjGStAqkqvUutIy?=
 =?us-ascii?Q?i/bUcI+pU4P3pmUXF+DNyMpFmSgay2o8Id7F43lwvdV8Fg1Ug20vtytHv+Xq?=
 =?us-ascii?Q?xSBXHzx/Q/cPZpP1vv0QEPGMYJfbDYK2WRdTOXCDGmpTGutY9I6EsbLYqx3Q?=
 =?us-ascii?Q?oS5NWauv+ugEzebMnnkH6dEZ6RX30qZB3WLqL303cjNofceHwMvD0JMiRaQW?=
 =?us-ascii?Q?ULuon+uzBI65uwzwOLCLtEv7xts7A1bfGpAr9NHMMkCvc3Yb50neL8zHfvaU?=
 =?us-ascii?Q?etekG8FR/lTQFyOx9dUeiDpffUaqN7mkmS2aLzQlIZMFQHIncHhNkPGUH8iY?=
 =?us-ascii?Q?At5MsOPFnahjOSRi6AGyjTCplMAVdoU2qvlbZBrUcqivEvifXOpp3319GUMU?=
 =?us-ascii?Q?RRwrE6VdX/IEVeDS8YOlmK1o9gp026b5hwAnBJzhxCjE8KQKpQD1kqpfa8Fo?=
 =?us-ascii?Q?XpBd326YjYo/bAT1mbJGuwBcMIfxue7pH5lw8YeCT+T6ljI/QPzXJQgxwiyx?=
 =?us-ascii?Q?HxS8Ghw7JXdetTHBOoMgR9dBYjaBrzqDZDZPA4SpGq8/02JmxmMD3oEXk/Ng?=
 =?us-ascii?Q?NQ5+RBV6FP0Dy4Vray1vYWSQG2exHUeoU5dMYmHsbVWyPVGg5xLr1tevEwvG?=
 =?us-ascii?Q?UAMLmrqlbJuTeF8774lZPYPwqlnzadMsofttrjJOBXcoFlKqZYpKDiBienBa?=
 =?us-ascii?Q?RxKJ7JmbExz0QS3iNKLXWSa8XDJB+w2IDpYTfFj8rPhRYQu1H+w1QcFYJGdl?=
 =?us-ascii?Q?x1ocGMZHVkTQaL6pGTa/3dZ7PNVZFPGbpvav20H1tQO35Kh7QpDyznUdz2Ku?=
 =?us-ascii?Q?xxRwqA1KoEy4GtuH7kM67QP0aGErNXVYw3biIr3ebDxIFLEa407mP3ennPNU?=
 =?us-ascii?Q?mMiCw/RWHarNF4hb+W/IzrM4snhj+c6qneJGMTG1QFmZ9Kk9Kh+WhPN0JlO9?=
 =?us-ascii?Q?ROnprCsf8A6cMkpcsUvRdC8JkE0CcUM9Ag80iO5bc2CvLdSwV8LA/VMg+126?=
 =?us-ascii?Q?BftRc/3bTbDJ0K2aaHm9/Tq6eZhnyVFtgGu5B2lES8H6HTbwDd42097q+v+U?=
 =?us-ascii?Q?prlNJ/8LKnD+8UryOmqlUXpdqOyyVxLCnuf/MFA9s27rruaj8vSTB7OlLGce?=
 =?us-ascii?Q?aJfv2zZ5Urw6tnaeaFEYzlG0jke5yJPm8KNprFPutu6tDGG0VrSQMjuctayI?=
 =?us-ascii?Q?w5vsqrqSmBRFXREHnWn2Dzltc8aDdz3ih56Oe6XOHSj5ByibgXXYmwNNj01Y?=
 =?us-ascii?Q?hXsH+9vAREpei9VF2vwwVK2evtHE3AZ0WlA6SQfvA3bqYcqDdxE+BPgtgH26?=
 =?us-ascii?Q?hT0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lZg2hQ+oDMKiKqIkHvKg3ojx/4u4X7sOnI+nbGRt7E5ce0se7aDKtYa/+Quf?=
 =?us-ascii?Q?2HX7FRUUjrF+Wg4NCCey4r7lLCH+RKShAiBqmWSAY2iX4FlW1e4N6mgY7i9b?=
 =?us-ascii?Q?d9mgCBxESg3NnHlDsk7+yWy8ghN9IyI10S2Zqfakb/gjSeQfwBxB4CY7jOb6?=
 =?us-ascii?Q?34WTSa/iBJ5U1GvmggDMvgRu7xFpwjFpe4OSkMq+b0g+AhJN98S9AsaX1XFn?=
 =?us-ascii?Q?GATneu9tksbgfwPvY7aNqfCEZ1jZWBmeDWQEX04jszi8XUwQUB0M707xWAVo?=
 =?us-ascii?Q?xILJiUiSkuv/0AbmPxTKm1Tf/dnB1LxLWd9qgaIg9wSFeDdym3LXVAjcOhiY?=
 =?us-ascii?Q?pZjJLGRnpfoab5D86IIfZjBzDNNvlmJ05zuHH8S13stmUbKRfOvcGV3XOeD1?=
 =?us-ascii?Q?huOKdAt06CrYmQcRe09jtrRA8sR/YE/Yegtuo3zXedXZptX4koJSv2JwOrcF?=
 =?us-ascii?Q?hiDSMntVHepa0dMQE4tYElDQhsZkh3riwUUVyYJ5yJFTBBr4qDNn6xmYgauV?=
 =?us-ascii?Q?6Ri4K6UHMs6nZSSYCSvvf4ScC4TqTgL9FMX+NLzJhkW/otzbulCTNGcSVyI/?=
 =?us-ascii?Q?6q4hB8LAwFwFeZi7jV/XA8uAysWyH87n6X+Xjk+c8y4caMrU1TDrjFVz9sBO?=
 =?us-ascii?Q?ixLvJI14vBj3Sc7Dx7fqtk1payOHUvSPxMS91I/Stwxb3PCIRhAP4VX30JoX?=
 =?us-ascii?Q?AR5r6CpyIajBH8UWERwTD98nnXUNep6MiSUPhAMako2qT/Z19WAKnLkC0+TZ?=
 =?us-ascii?Q?byRHDn8VkSJoDs6PtPrAUI/f4p/zNmK5kANCuojOCwiSjl9dtmXKx9i2Cx0d?=
 =?us-ascii?Q?pD4f/mz+gC7tZpoQ6aymjvladyBpVJtz+9D/01s9yDGQVSnq4GaOFxUGdscH?=
 =?us-ascii?Q?baZj+JMk7bB0+Dv8t7XTmcTdzDZovhGY4SM9ob6ZrhMLZ5EBdiyIFFlj6rOK?=
 =?us-ascii?Q?OWxWA5sK9k2cXySsIJl2aV1PeeDxmt1w2eiLmj8XoDrgv/n6SM4/be0puK20?=
 =?us-ascii?Q?5u/L/NqtutR/2v2fl99pMfPd94k5o8LD0WeTp7WdvpgJ6bcUYjuc2jm/eBdj?=
 =?us-ascii?Q?6Pgr79Gp/eve/AJKmqBpvJT36G5uf5YDjJX+RfjAjhrdWKKguC3K2SUos78q?=
 =?us-ascii?Q?qNCAndeeXJcQUGNQ+QWvqwPGfqGlr4p4qHrYSB7gcEr4UaxiaIKlxirSOYxT?=
 =?us-ascii?Q?Ygh47Rvk4qt+Tt/YuJd8kU3R9JvUwbC/1KDclnTPA0kVRTXhVGwEAPve6Liw?=
 =?us-ascii?Q?qpRKAghCdxoldl7a5vmlGGi0MgjnwgQxmVNZS5WTf7Z00Kn6Gql2bBNKbfjI?=
 =?us-ascii?Q?yQBnJPaDIaipbYZ1sZrQCi9RgGQZRYahp6peZL3lSTHpF6CFDugP9Hdtnsfn?=
 =?us-ascii?Q?53dqqjl4HfnJpkrtMJ+ZCyx3lfB1KWSpcBUrW4V3eqUe4ko1hpJOXN0GcdNH?=
 =?us-ascii?Q?sc1I6Ai0Cpwlb8BNfx9VEctQvOEmmfr1F2NqC0BIv18DTu+0B5BSZbLiRh+S?=
 =?us-ascii?Q?btMZtLYTZtkOekZERBT7WUAME8Zqn0EuhwsqMbTbfnPzvUPsxzIpS3W0phMd?=
 =?us-ascii?Q?jOGTFCuqW36Tzj1jO0J3AUUE9/VzAMfzjP8hRybI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	r091O9kWmMxIDYgdDxyCX5V7aI9u3skSHjrkpWhG82xk7fsdgkdnIt6GkvSPdgeu3Xoe3CyjnpjcShxlkZeCgpFtltgf1Wqn0rKbyRgJNmQb1cNEoculeCxKG0E8Fo0t5v6/JCpswp/22ClfYCBmPfyndwkX852UdHaYk9QOFbfbqOKup7AscrnblCVt8+xQPdTE3aiaBvejKf4HvR15tuUmqhZpxipCpAXP16u9H27t2xS/gKG1i76eTBgQXKpMJOR36NgLQowFkgLGR5TdVQGuuvvCzn7sn6qavWyZhJ2/ceFUZ9uA/kI4NrhQ9g7Num3EG5b3AGfwm4eGFzRpkVhQcbovKNwipYZNf62n4QwvC51ndeq7WugChzZye4MPB/K2/4BNNikVkKQZcfpK/nD0Onc1Aez1i1HixUaM4iwwMI6VTZSmW9dPllOanj8IQ3+2gxNB5B6XHptU95mRKLR88Rh+q3F+vnPwwtHO/P1FVEvuclnA9GEuVuaHT+uR/AqX2UEFFQAUwbRcp1D28Sx56yyc5kyQHyApge2wxw4x3NlBZw3fEGe8D4uyYsTOkgRcASRkL1lS9iancjcvcyxxz1MprAl41q7435At65w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8cf863-37aa-4dc1-df64-08dc99534c8e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 22:23:42.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kSDEC/vBgo1kCbBUZ3hveDF8GumgXU30jLVs0bnlum0T6PB4zK3u7f7gLnKr4HS/uTxBANBOEV7BaqjEPeDMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406300180
X-Proofpoint-GUID: VEGMGOxqXPzqECSXzsqbxN0h0tevbNAo
X-Proofpoint-ORIG-GUID: VEGMGOxqXPzqECSXzsqbxN0h0tevbNAo

On Mon, Jul 01, 2024 at 08:01:30AM +1000, NeilBrown wrote:
> On Sun, 30 Jun 2024, Chuck Lever wrote:
> > On Fri, Jun 28, 2024 at 05:10:53PM -0400, Mike Snitzer wrote:
> > > This is nfs-localio code which blurs the boundary between server and
> > > client...
> > > 
> > > The change_attr is used by NFS to detect if a file might have changed.
> > > This code is used to get the attributes after a write request.  NFS
> > > uses a GETATTR request to the server at other times.  The change_attr
> > > should be consistent between the two else comparisons will be
> > > meaningless.
> > > 
> > > So nfs_localio_vfs_getattr() should use the same change_attr as the
> > > one that would be used if the NFS GETATTR request were made.  For
> > > NFSv3, that is nfs_timespec_to_change_attr() as was already
> > > implemented.  For NFSv4 it is something different (as implemented in
> > > this commit).
> > > 
> > > [above header derived from linux-nfs message Neil sent on this topic]
> > 
> > Instead of this note, I recommend:
> > 
> > Message-Id: <171918165963.14261.959545364150864599@noble.neil.brown.name>
> 
> Linus would not be impressed.  He likes links that you can click on and
> follow.

I've read email that suggests he doesn't like those either. Another
day ending in "y", I guess.


> So
>    Link: https://lore.kernel.org/171918165963.14261.959545364150864599@noble.neil.brown.name
> 
> is preferred (at least I think that is the current state of the
> conversation
> 
> see https://lore.kernel.org/all/CAHk-=wiD9du3fBHuLYzwUSdNgY+hxMZEWNZpqJXy-=wD2wafdg@mail.gmail.com/

As I read it, this refers to using Message-Id: to link to a patch
submission. I'm linking to a discussion thread, not to a patch.
Just to be clear.


> NeilBrown
> 
> > 
> > 
> > > Suggested-by: NeilBrown <neil@brown.name>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfs/localio.c | 48 +++++++++++++++++++++++++++++++++++++++---------
> > >  1 file changed, 39 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > > index 0f7d6d55087b..fe96f05ba8ca 100644
> > > --- a/fs/nfs/localio.c
> > > +++ b/fs/nfs/localio.c
> > > @@ -364,21 +364,47 @@ nfs_set_local_verifier(struct inode *inode,
> > >  	verf->committed = how;
> > >  }
> > >  
> > > +/* Factored out from fs/nfsd/vfs.h:fh_getattr() */
> > > +static int __vfs_getattr(struct path *p, struct kstat *stat, int version)
> > > +{
> > > +	u32 request_mask = STATX_BASIC_STATS;
> > > +
> > > +	if (version == 4)
> > > +		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
> > > +	return vfs_getattr(p, stat, request_mask, AT_STATX_SYNC_AS_STAT);
> > > +}
> > > +
> > > +/*
> > > + * Copied from fs/nfsd/nfsfh.c:nfsd4_change_attribute(),
> > > + * FIXME: factor out to common code.
> > > + */
> > > +static u64 __nfsd4_change_attribute(const struct kstat *stat,
> > > +				    const struct inode *inode)
> > > +{
> > > +	u64 chattr;
> > > +
> > > +	if (stat->result_mask & STATX_CHANGE_COOKIE) {
> > > +		chattr = stat->change_cookie;
> > > +		if (S_ISREG(inode->i_mode) &&
> > > +		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
> > > +			chattr += (u64)stat->ctime.tv_sec << 30;
> > > +			chattr += stat->ctime.tv_nsec;
> > > +		}
> > > +	} else {
> > > +		chattr = time_to_chattr(&stat->ctime);
> > > +	}
> > > +	return chattr;
> > > +}
> > > +
> > >  static void nfs_local_vfs_getattr(struct nfs_local_kiocb *iocb)
> > >  {
> > >  	struct kstat stat;
> > >  	struct file *filp = iocb->kiocb.ki_filp;
> > >  	struct nfs_pgio_header *hdr = iocb->hdr;
> > >  	struct nfs_fattr *fattr = hdr->res.fattr;
> > > +	int version = NFS_PROTO(hdr->inode)->version;
> > >  
> > > -	if (unlikely(!fattr) || vfs_getattr(&filp->f_path, &stat,
> > > -					    STATX_INO |
> > > -					    STATX_ATIME |
> > > -					    STATX_MTIME |
> > > -					    STATX_CTIME |
> > > -					    STATX_SIZE |
> > > -					    STATX_BLOCKS,
> > > -					    AT_STATX_SYNC_AS_STAT))
> > > +	if (unlikely(!fattr) || __vfs_getattr(&filp->f_path, &stat, version))
> > >  		return;
> > >  
> > >  	fattr->valid = (NFS_ATTR_FATTR_FILEID |
> > > @@ -394,7 +420,11 @@ static void nfs_local_vfs_getattr(struct nfs_local_kiocb *iocb)
> > >  	fattr->atime = stat.atime;
> > >  	fattr->mtime = stat.mtime;
> > >  	fattr->ctime = stat.ctime;
> > > -	fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
> > > +	if (version == 4) {
> > > +		fattr->change_attr =
> > > +			__nfsd4_change_attribute(&stat, file_inode(filp));
> > > +	} else
> > > +		fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
> > >  	fattr->du.nfs3.used = stat.blocks << 9;
> > >  }
> > >  
> > > -- 
> > > 2.44.0
> > > 
> > 
> > -- 
> > Chuck Lever
> > 
> 

-- 
Chuck Lever

