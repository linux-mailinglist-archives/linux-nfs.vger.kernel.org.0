Return-Path: <linux-nfs+bounces-5072-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1744C93D4C2
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFE11C22D16
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4B17E9;
	Fri, 26 Jul 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vh6keGOF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H6G5xMR/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F7184F
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002803; cv=fail; b=o5H9RYDpltQQXtcQo3nHwACysBEwUpJShCEcYk4zg+KcfCcV8HjfreOiK/QtAVGgXXoCgnQ5LSuKrPgigMaRVVLkLCu1GfwIm0LTIt0qobSBE4Qor14+ApLvebQ5FidQnAPBH7Qr7nOiDSM2yM48jepYzm/C7cSBSKbPkloOHQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002803; c=relaxed/simple;
	bh=NUkITqcV5gxEGFoftqJD+jMbnzZLsVKJv3dFnj6U7no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XTvxJFQdTqD+bCW3c+Be8LzESfKfLSwgTaMiKpavbuF/WI1zog24Ze6XJRAnEvwwAzcjQ7JXZRxIpjbNLDpSjhAXCmDUXVCz8exI3MfMFJmOjR8MK7+LdbjEXsT50h+TTHIOFAUlOP6sP6Yxb4mhtxIh1bVxHaCXS2wl1NY6Ohc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vh6keGOF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H6G5xMR/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q8tUso011777;
	Fri, 26 Jul 2024 14:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=t+bUh02ePtzbmHD
	hR5gWar945F7GPRa3KwDbp6ukPyc=; b=Vh6keGOFslGzraagDG1sT/7PpWuDBWJ
	b1PHWhkszghA4L8HxB25dwdarPB86TlR8sbfvFBA/MN54Ds85IjZFks8rxoicesE
	iKdncKi73zE3Tt8GIxaW4Rgfx9S6ehUqOSLQHIDAPEH9BCMgfQlcp5R6szBz3O+e
	yl7QMLmMsq0q4nPsZ71O9Y0TUhC6vksUD3nU88/utTT6PlxTXn7bXxjPbses0vdl
	y20tRvPpC41zZC/LVxC03eRrZPB33WwpXIY85JLzFDRnYQKfIEviSjTT75bfvnxJ
	Vf0hS64XoNtJkeNXDAfx1rqdsiUqn4usR+yySZMvs8g071RwkxkIQzQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkr5hv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 14:06:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QD4Lad010705;
	Fri, 26 Jul 2024 14:06:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h283us75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 14:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=occ1ZAvXJRnb55bsZlR3hq48DEAWdEdR2//LiAK2SYjWcwAOPv0+KZHEXyVe4Dz+73TSf4dOYUHo2K2wmpiun8w1xjrCCivPr7IX+OKbzjHVIB5f/pCf09UufqlU+e3fE/qDjDd2at5zKWCFihr7KSab35yHIQf++oIB5Yu0o2SwIX5kHWEslclq6+2Gh805MW1/Ttx+Dw8p5HzOZvJ3q/jrxGdj+HW8nGeNIHE89mDmvaA/EiUEwO1As31vWNSdKAs5wkN6fDyXV6xa9950bXUGPOsq53Lv6UV87PwOzVrz5hQkcAeXNg2eC4NYBICy2NDJX5LgXLSSav+oWeXN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+bUh02ePtzbmHDhR5gWar945F7GPRa3KwDbp6ukPyc=;
 b=k4HRTPW25qPEEuTZ6p2LmGxxGbZGLyyENZo50Y6g9X9Q3PmMUZb93DnLg7MLK6EVc4bSBGfjnVu7hfXA30JPCLIEyLYIKjgAMdI2/fW1G1iYRSekhyb9wpGZbEOC8BRvET0o3DkERgT/aIXyXPq+WN5rlmMs+8sNB7s1JfdsPSHazMpWaejq62Ccl+T7dAKGJs+68yuFvL7Opa/siVCGsgCjDxkf0wZ74EwiNt0z5EWKo5P6EKPbEXYiJW2RXssGbWVNIeM4thraSNhK2C2wZrvVD8CoSMVS4Qx/CCySwrQadyxqR+L3C2Cotw/RbnJzHv9qn5LOBa0Ny2dA7JP+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+bUh02ePtzbmHDhR5gWar945F7GPRa3KwDbp6ukPyc=;
 b=H6G5xMR/QXoHr1hrSZfmMdGVn8tNqQjSogtVVWPGYoa3aOyp0pnKtXK9SflKhhi+t0ai13YkqFoP2EuKRERlyadd2l7uxPGVoFcfBwVeEcPSqBvWzBTHU65o/SBlYldThOLhhvQxf6PQMUKEpsXLapBokb6RJvyWanDNkhxdhOE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7638.namprd10.prod.outlook.com (2603:10b6:303:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 14:06:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 14:06:28 +0000
Date: Fri, 26 Jul 2024 10:06:25 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
Message-ID: <ZqOtYYV2rQ7ROqXs@tissot.1015granger.net>
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724170138.1942307-2-sagi@grimberg.me>
X-ClientProxiedBy: CH2PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:610:54::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW6PR10MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0564b0-f7d1-491f-2456-08dcad7c24ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SyHGWjJdGm84aYbXPFB0nZ2N2oCwwm6YmUUSn6r3ausSNuRXbT7AobAg/BbN?=
 =?us-ascii?Q?qIfdB+vmAuvjyU5KZJFFBWcjcAdN4S6UEbETwAG6VDduD/aOBfl6pd44hQZx?=
 =?us-ascii?Q?5LmMuy8cgglmv2B+3tUZMcArb3U3u6ExwF2sz4wpZ6sPU9cXuzqknLaBorN/?=
 =?us-ascii?Q?L359hIVfQWu5dGF4AFPpiCv5uzaRHtC3Or9+gHJfuoCvFFxDsvcauev1bE4J?=
 =?us-ascii?Q?MJfTPjw4HKzPjcppcx+N+ebstbdJgiZucojVK2l4TL6kZkLtWEuor3TgOuNn?=
 =?us-ascii?Q?l30Xcja3cTwaguEDMenDmmLkFC0VvXkMK++d3rcteeC5ZZK76mNrXN8A55oO?=
 =?us-ascii?Q?FLxXtfc/6adfGvzaSBqauMCKG44qFKNB1LyFSymjbgCKyCFvcPo1IRPNQpla?=
 =?us-ascii?Q?1GADpS5qJoT1BqG96ru+aC3LLzrG0MdUFdfE4lMkBs57X/I5lmgmMPTv4JFZ?=
 =?us-ascii?Q?wnpvmkeCQZV4GpXiaPMLIRTgEg3ZFmzhMLajHttpBczPPnFnm6VDZeCw+bzd?=
 =?us-ascii?Q?vre3SsrPYvpLy/g402wy+s2M3qzWMZP4HPooCabYRLLBLJj51gAEoBG2SIu+?=
 =?us-ascii?Q?SlUxf1b+FdAjfy50Z70VVaY4Vys/mx9PnCYKfGlmmndlQElGmAX+zg278ANN?=
 =?us-ascii?Q?sQWswkKAru/HKzpN6vPOqdQvanwVbD+WOJiQWiqrEMdBrPZK4Khn1ZGEsSOG?=
 =?us-ascii?Q?94X7FHqjYDhecC/BxA6gME394qcNTipUuWsaCHgQ+AJLyRDDxmCQBiu2xY0G?=
 =?us-ascii?Q?/77MwVTRo64KvGgxxWCX8PvObIgoFaLQ5++kJHhPjsEToSbsIgmNz3j+hFxw?=
 =?us-ascii?Q?9aQihoLFPQyyZraUCQGqC2EPFgVXthDhlD4+yCwJ2YrmdD044Y1Rw2aBq/34?=
 =?us-ascii?Q?CTdAjcMOloiFesdC0QiEc9FlLl3DqeBGPiXnhlGB6GZSVYG9y5mZlVNUvLFN?=
 =?us-ascii?Q?tbfHkiLNnEWG7lYb0v683yVslddN0AxpfOKW7w8M6c8GKcQtkO43NJupI2lu?=
 =?us-ascii?Q?gkKHE7nxp9B7fIHwQveCuazuzT84UK3o15YZ3WmX/e5ifrOcusIK3LWofIPm?=
 =?us-ascii?Q?tC2T+QOlx97Qx592ygRbP3j/IgmQFkeAf4a7Ly/CEMVDXlkA+BvaXy+D1FcA?=
 =?us-ascii?Q?MSyKsWyxECp03Q74HEDWkQfl/4N5fYJrd0FqdnMZ4Up+mTf2ynaQ+KlkRjqM?=
 =?us-ascii?Q?bIuCmjNUe4Bi8L1Mg9SsM0QGy0i/G0OOxccE9omokCuxl2ahY18SpBSbkITE?=
 =?us-ascii?Q?b3HtyyEVrtH7IK71Vd6Rs3Hmq73wrU00eGtXwamRtdcqdE2QgAhVh95T4QLV?=
 =?us-ascii?Q?AX6Ix3Sig+4jlkcylISpgtFfeW76icZYCyT076uOjafL9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OnK6j2AM2J/5VVl/931liDNWoKa+4eZD0k64KKZqUwYauQRYy5E50awLmoat?=
 =?us-ascii?Q?59W8jm/VSkvdDY9DWuvd0eQZG9/GvmsIIlPYJV1qEYVnX1mZL2vOrGhwC3bJ?=
 =?us-ascii?Q?hUXRXdgkHyIF/TXaou2Z4wsMueHaLEPYimNrVhyCooIzI0bjdNF7ilvjQXNI?=
 =?us-ascii?Q?RBgZdAmuOxVaoO8eXJ2quDup8/cvmbscfEobRIPHsHe82GYeUAg+VAXWjsQ9?=
 =?us-ascii?Q?duYmp0r5R8qZV3tBWQk6YkPs1j9jIQO/Ajol+q8EIM/t629cBmSJnn1XGXd4?=
 =?us-ascii?Q?XzA4O5V4gRQ9ieyGhKQsCbco6WLa2oalA19Af4mkw63KhViBO3gdHlXWOpAy?=
 =?us-ascii?Q?1vfd/g5tvZ9gQkvMoljW+Kd9alBDkfhGD1nFTJG1ZOC3N3+Pm8OO0slSu9k1?=
 =?us-ascii?Q?9DdwgULyzNzy3AtkVk/oQUCHvAWCi9lJvhqrvneRJ990zl0R/o9fIWHSz/Vz?=
 =?us-ascii?Q?cjMcmJYHXBq8usxHRRFvhnzZ024UcVjBvtCVMoQfwLVkZWIoHpE7GZudkPjE?=
 =?us-ascii?Q?d1DrxPhm4ZJ4V5Earnad1+zbySXuWUPhmVFucAexJY9FlZRrOrBFeO7LimEb?=
 =?us-ascii?Q?MwI0yqHj7q7ibAhJ9ER230AnYaG18joXlCFI66lfnOyHtiwIly+NbEaS1VSN?=
 =?us-ascii?Q?tZsR4dvGPOKGkA0PDnQefRbuAeOxfY8h6p8j5vfr60N9loiehQ9CQafvhfwd?=
 =?us-ascii?Q?i2oPFMbSBzUeHva0zEne4bWN928mdAaGvizYQuoedXQTZf3FGrP9njZ76GPv?=
 =?us-ascii?Q?QGLAIL/JjXPWGkYlb720oDJUko2q42TKN+hKwZQybt+hhIqAVJARHgEBtsmo?=
 =?us-ascii?Q?nbVVCFfOS0vi8wmzkt+IQ7Ti2Kx5cXreAS7WWp3cBsjEAZaTvmmxf82PX7CK?=
 =?us-ascii?Q?mxkpCrb4j/wtO7FNEuCM0gAbHCDRi5LPzMjEpWgaF1+2xT7+8KDH5D+TLc8d?=
 =?us-ascii?Q?aSsZa3sVkbo67x3ICNsnWyNYAicZA7mumhL2mHYzQVWOYf1cVkkHaR2kmsFI?=
 =?us-ascii?Q?ozxckBYrj6OD2eV3AvbpAmECTMWIyjHCgNFrRxYjG8hw5TgBV6mMkfZcRBoo?=
 =?us-ascii?Q?sgPjrt5GsDBdgreKNreFTD2YodvdjQ0VCow5boDt6rZG+KCVkoDkWzdFHW9g?=
 =?us-ascii?Q?HQuzMlpLWrJyW26cj9S8RStx8R0zt7ihKtP4nsTZK6oN8wloCHxwrzYtfuKj?=
 =?us-ascii?Q?ukgB3a4mRAUChKDzjYHSW4NxtGpc0QNVmfhrjKAhpSQB9BbfSA+/gMPNqJcJ?=
 =?us-ascii?Q?v/IEAFMlHBA3vOsThC8DxCgqclT2RGOdFocsLnSOL9LRlqk3ttZIG9oxT97a?=
 =?us-ascii?Q?M2TLwA5vlfb1VHNMJPXPCOcxZUi8fPRcQq0T2W3KiwH3FatGUBZOD+Kahs/5?=
 =?us-ascii?Q?OUPg3Lj0Vs+K1IGBQOdgSoyGpIeeB5YXSZrWLBJPQmUgNF+psCRORLenl7Vu?=
 =?us-ascii?Q?B0Yh6HdLyWv2dsBUhQXx4zgKPIOJfD7N9/4lZBj3u76yT4VPVs+Hc1PvL8lL?=
 =?us-ascii?Q?XBwDKx3VXt4MH54Fbl2dk6pOwIrP75hjzIOLBeKP9amK+DrTZW5sAFeKdbmK?=
 =?us-ascii?Q?kFIZZHHDT/0cnaRL+A4fHO0msDhwZ8UQYuZqKMIeUgdi/EMGVb15IIlYpidr?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WueZzhbKSUn8E+P33qQz/SOYVmTvsIeYYj3da6GXfP2U/7OfFe1jTEupojnxYCQSbjCdUn/Hbm9a7aUPECkuy8aIujicw7WqRe3mUzfQvXfUkUOOHkhmPZ4/X/PKN35/5cldeY7HpIjfS2PqITEqfTsVfJmm6d4w/GoFY0sTxJpLcQ6/ZpmWYujVKPZ+HREMkSoi/BY59WasuzdCQQYQ0rVCX1kgTRtc7gLRmQoo44E3Ycgt32zvv9W6TutYqRMW6ZAeY/+LmZi6K8xgb1a+2zMM4JtE3EIvPVLc4t2QRcgpNxXA+lHdMcYN2y4FjWogeEvLjYuI85O2e0w2jpMM/geYg41pVkSZ4Ng/+HdrKRv/AeNudrrHx5g2ZbA6VWgZYSNd/Vlz5aH220BK12aGBn+GO3G/9ZwCu271MqUHc+PjTLp3vVZ4OjTO5JzZoVInLC1lNllsAcOw3/3Qen36dnSROW5baPdLNtoxbOLCrgHTYWDpV/CKihZP0WJ03vY2lT4pDdWAsEhzjwL2xIwipwE8lKOcWkNW40FdEy41238mWqiwXdZySM34wD7sfT5lgqp+tdS7VxU5gZq9muUkPTm2SqXO4zbKHul6xTCm4BQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0564b0-f7d1-491f-2456-08dcad7c24ba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 14:06:28.4718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXwoynTqqg17DM/8QnKAHLRD9hUjdu8GW5qEnae51lxZ23o0eRWi0d6rAdZIcriG6B33anFKlh87EfyG6BiOvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407260095
X-Proofpoint-ORIG-GUID: fSs3G1__wa9JkgJOEAgZ2cTXIOm06MIL
X-Proofpoint-GUID: fSs3G1__wa9JkgJOEAgZ2cTXIOm06MIL

On Wed, Jul 24, 2024 at 10:01:38AM -0700, Sagi Grimberg wrote:
> Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
> stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
> Stateid and Locking.
> 
> In addition, for anonymous stateids, check for pending delegations by
> the filehandle and client_id, and if a conflict found, recall the delegation
> before allowing the read to take place.
> 
> Suggested-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
>  fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfs4xdr.c   |  9 +++++++++
>  fs/nfsd/state.h     |  2 ++
>  fs/nfsd/xdr4.h      |  2 ++
>  5 files changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 7b70309ad8fb..324984ec70c6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	/* check stateid */
>  	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>  					&read->rd_stateid, RD_STATE,
> -					&read->rd_nf, NULL);
> -
> +					&read->rd_nf, &read->rd_wd_stid);
> +	/*
> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
> +	 * delegation stateid used for read. Its refcount is decremented
> +	 * by nfsd4_read_release when read is done.
> +	 */
> +	if (!status) {
> +		if (!read->rd_wd_stid) {
> +			/* special stateid? */
> +			status = nfsd4_deleg_read_conflict(rqstp, cstate->clp,
> +				&cstate->current_fh);
> +		} else if (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
> +			   delegstateid(read->rd_wd_stid)->dl_type !=
> +						NFS4_OPEN_DELEGATE_WRITE) {
> +			nfs4_put_stid(read->rd_wd_stid);
> +			read->rd_wd_stid = NULL;
> +		}
> +	}
>  	read->rd_rqstp = rqstp;
>  	read->rd_fhp = &cstate->current_fh;
>  	return status;
> @@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  static void
>  nfsd4_read_release(union nfsd4_op_u *u)
>  {
> +	if (u->read.rd_wd_stid)
> +		nfs4_put_stid(u->read.rd_wd_stid);
>  	if (u->read.rd_nf)
>  		nfsd_file_put(u->read.rd_nf);
>  	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index dc61a8adfcd4..7e6b9fb31a4c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>  	get_stateid(cstate, &u->write.wr_stateid);
>  }
>  
> +/**
> + * nfsd4_deleg_read_conflict - Recall if read causes conflict
> + * @rqstp: RPC transaction context
> + * @clp: nfs client
> + * @fhp: nfs file handle
> + * @inode: file to be checked for a conflict
> + * @modified: return true if file was modified
> + * @size: new size of file if modified is true
> + *
> + * This function is called when there is a conflict between a write
> + * delegation and a read that is using a special stateid where the
> + * we cannot derive the client stateid exsistence. The server
> + * must recall a conflicting delegation before allowing the read
> + * to continue.
> + *
> + * Returns 0 if there is no conflict; otherwise an nfs_stat
> + * code is returned.
> + */
> +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> +		struct nfs4_client *clp, struct svc_fh *fhp)
> +{
> +	struct nfs4_file *fp;
> +	__be32 status = 0;
> +
> +	fp = nfsd4_file_hash_lookup(fhp);
> +	if (!fp)
> +		return nfs_ok;
> +
> +	spin_lock(&state_lock);
> +	spin_lock(&fp->fi_lock);
> +	if (!list_empty(&fp->fi_delegations) &&
> +	    !nfs4_delegation_exists(clp, fp)) {
> +		/* conflict, recall deleg */
> +		status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
> +					NFSD_MAY_READ));
> +		if (status)
> +			goto out;
> +		if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
> +			status = nfserr_jukebox;
> +	}
> +out:
> +	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&state_lock);
> +	return status;
> +}
> +
> +
>  /**
>   * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>   * @rqstp: RPC transaction context
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c7bfd2180e3f..f0fe526fac3c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	unsigned long maxcount;
>  	struct file *file;
>  	__be32 *p;
> +	fmode_t o_fmode = 0;
>  
>  	if (nfserr)
>  		return nfserr;
> @@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	maxcount = min_t(unsigned long, read->rd_length,
>  			 (xdr->buf->buflen - xdr->buf->len));
>  
> +	if (read->rd_wd_stid) {
> +		/* allow READ using write delegation stateid */
> +		o_fmode = file->f_mode;
> +		file->f_mode |= FMODE_READ;
> +	}

nfsd4_encode_read_plus() needs to handle write delegation stateids
as well.

I'm not too sure about modifying the f_mode on an nfsd_file you
just got from a cache of shared nfsd_files.

I think I'd prefer if preprocess_stateid returned an nfsd_file that
was already open for read. IIUC that would mean that no changes
would be needed here or in nfsd4_encode_read_plus().

Would that be difficult?


>  	if (file->f_op->splice_read && splice_ok)
>  		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
>  	else
>  		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
> +	if (o_fmode)
> +		file->f_mode = o_fmode;
> +
>  	if (nfserr) {
>  		xdr_truncate_encode(xdr, starting_len);
>  		return nfserr;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index ffc217099d19..c1f13b5877c6 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -780,6 +780,8 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>  	return clp->cl_state == NFSD4_EXPIRABLE;
>  }
>  
> +extern __be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> +		struct nfs4_client *clp, struct svc_fh *fhp);
>  extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>  		struct inode *inode, bool *file_modified, u64 *size);
>  #endif   /* NFSD4_STATE_H */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index fbdd42cde1fa..434973a6a8b1 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -426,6 +426,8 @@ struct nfsd4_read {
>  	struct svc_rqst		*rd_rqstp;          /* response */
>  	struct svc_fh		*rd_fhp;            /* response */
>  	u32			rd_eof;             /* response */
> +
> +	struct nfs4_stid	*rd_wd_stid;		/* internal */
>  };
>  
>  struct nfsd4_readdir {
> -- 
> 2.43.0
> 

-- 
Chuck Lever

