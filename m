Return-Path: <linux-nfs+bounces-7933-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D59C7868
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 17:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FF41F23C27
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442BD15AAC1;
	Wed, 13 Nov 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DWBY8vmq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aRpviLVq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445C158D93
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514386; cv=fail; b=G8PBZwKNLMQUwNJkOEXoKTEHXnKS1tIDMaZSA9kEsIW2vpArCmU7uNuFgSjpb5g6a/S7AbgQynjuuTCaBkOFs23CNhI9ISkWViQi9+KjMj8qEV/6GGwJ4zz7ncOuestIcH/4Xl0ikLciycrNSKgswXlWpcQA6BJCu5CZtj2VI5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514386; c=relaxed/simple;
	bh=r6KWpBIH2DSwB1DhWKr8NGYV77Br7vJbAuecmVmzDZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hX3i2YQVAhRQAvma9Ychf0HC6GeObm0Rpr03fB+rSt5H+mzUJmxJj30e9maRXLoH+ez3CLswZsCO4KvHl/axHzXpYNS075NKo8W2E0vj/iePtLIUd2dkH1Jl9gqPdjseDvthxPTxHITE5mLPSQC/Q48RIEQmHDoHxUsZlgQbh5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DWBY8vmq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aRpviLVq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXWES013693;
	Wed, 13 Nov 2024 16:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pNgHG7IkSQUQVr67fS
	jrV+cYXVedcQTQQ4sgkBmK2kc=; b=DWBY8vmq4bnyCXF0+8vW2paE+NqKPl5JDd
	Fdcpj9l7auDLCV5xtz2YGK71oQaK4TaSBNPCcZmdn46JJa0y/GIjQMenUotZPeoA
	o4MR5JYvsw2EVg3ezt9EPhAYR1gDPtjpdzC4VvsxqqGI0orPy8QDBsVmGr7zChyv
	IkFxJ/uRUfAxXqi73GuCgsGgzauKi44J1fjAM1Tlm8HfnQmERQ8zwiIC2sqAubtw
	dkmHJ4gIx5vfJsWIlxvpSR0uI+1wVG6U1w71PZC8nSKuo6MozJVukNYdFVVmjHC3
	lVzT47q0yVqByvBdvAjeEITWOPFg8CaS44gCta+H0d4GuPHrAnzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbf9ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 16:12:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADFmZaK025914;
	Wed, 13 Nov 2024 16:12:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69hhtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 16:12:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8EpBOOaD3DQEsnkWXWMdRic6ILE0KozUxttBUkI2wR0yPwSiCeGWK5IUmj7aQQenHGEVhVlr/TaCokpXVdepXCi2fipCRjRpngWzZA42I9DHODBhep0ftqK46dUt0AUm6xNFEtzr8e/3BVkwlxE6gecULgsuYCT3beCWozlH9fnffZpa0jFC2clqrZVXGp9H55rxTqrSSHl3kb9EqfkrCgqFrgag8/hwUtl68w5uPsD6mcTn/biPFklfgL6TsZ0OHfe5GdmbRXY4n2SwBJ2NJ+UkXlX1rWYdnAdq8sUDNbRKk1zbYWptXo+2scUMtQR3iUcy7+VQYdnL3ZQbOkOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNgHG7IkSQUQVr67fSjrV+cYXVedcQTQQ4sgkBmK2kc=;
 b=EkJsOrwQrHhzTHVZSBfsAji4ArQ3ilSw59FaIgmKEp3t13umZZlawEywwtpTR6pbiiMsCszSf3tCqFbOO/xGzQv3p/PlJcbjgmmqZACUh4JCkjeRSauXGKxK57V2NA0O2vNb63Nrm/2J6sTwvXJttgeQY1T7XPBQRCjjMEpIQsfTZDNxnM1gBllgIbFOBFkgxdKpkz+idkpwMxXdLevmvtAxoejT09Ge7zojI9CkHGO1NUxZOLDBiwnvJeRgFqq/AgJ+fCcODIgYCssTvsOdYmepHvKRwXykWfQ+vebxGei7jsu1v5746ypjxhEWhFnvOFPgZQZOPL22k3MJHvyRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNgHG7IkSQUQVr67fSjrV+cYXVedcQTQQ4sgkBmK2kc=;
 b=aRpviLVq9xkh6css8JafTn6bcxizISGoYEPPwosEElS3Mt8d5WOEeU5Dqd74XnvS++nINHl/4g7vPuQF3ssR67G2TBUVOqfwJdqfiScSt5NEZaIpBgMkkGAw2uH2ZEFY9/rAsWFc6lC6gHaCNLMFjt59s0r+WJOR0Mn5iMFBa/A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7723.namprd10.prod.outlook.com (2603:10b6:408:1b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 16:12:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 16:12:55 +0000
Date: Wed, 13 Nov 2024 11:12:52 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org,
        Philip Rowlands <linux-nfs@dimebar.com>
Subject: Re: [PATCH] libnsm: safer atomic filenames
Message-ID: <ZzTQBNHvjllrB59o@tissot.1015granger.net>
References: <95b7c243dae00ef4fd745f2b6d2cd0c979779237.1731514115.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b7c243dae00ef4fd745f2b6d2cd0c979779237.1731514115.git.bcodding@redhat.com>
X-ClientProxiedBy: CH2PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:610:53::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c3323a-d5d6-49e8-2a39-08dd03fe0842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KP5cKVDr7t51RirBvSC/clLV/+B0B425wPH14QB9gaS5v7oSSt/iRQnht7CE?=
 =?us-ascii?Q?jSvDw94hoAoqmHKvo+p61B88HT8rmqIxavYQfJaqc/u6g9vgOUUeRBPy5FoJ?=
 =?us-ascii?Q?wbedaDmeY5J6GiV/gyHYBVOqFV8kkdi6Cbdjci0i6e2jZ/KeQvdZaGPjCTdb?=
 =?us-ascii?Q?k0Y9fIJf84LSYrPy1CmdhjQYsfVjxK/53H2rINnez93hAkttpGK7gy/FMrLV?=
 =?us-ascii?Q?bJlwwXrvwdMCjiNjWV9URjq4yyUukUP6y75u5Yau1j4RdMIhgDHUQZeNWnig?=
 =?us-ascii?Q?psiBIeLw2x6vJ2kzRmI5NEZO6wafcjJkKahQLfvfc6ZJmIAQaC/FJm611Usk?=
 =?us-ascii?Q?o0wHooQvqf8qlQcsVZ15N0YCR5i8RgqWFXTdyuzoZz+3u3lZR6g1yhIHxKi0?=
 =?us-ascii?Q?gaL0cHBxr0AruKxv3mWV2Lbq0/tWfHAh8QDngnaivcFrjwB9Pfadzk/O7/DG?=
 =?us-ascii?Q?1IXMqhpeSt1Wyc6Dga/qUx0KY7OTfzYJiLKlDMV0wwMU6aYZXqYZeAkDbSql?=
 =?us-ascii?Q?4qkqZWqcZ0ARBBgDPzNHueR6pzcSpfhyuIvUFLENrwH12AbI6Uqqeoj439BY?=
 =?us-ascii?Q?lFQJRY5QUalQW0s9WuhbptZc6IMUo7R4oxmKR+oTFH0hrNSM/FTR18xgIowl?=
 =?us-ascii?Q?v27vJQZcVM0Fs1izQ1qKU0HeERTzINgYf7j5W3md8+zwbbtpQ8T4dibcob97?=
 =?us-ascii?Q?AdZsccv6LtgZcHVIbXWJgkubklKPnbHVh8EQZ7FVtKrZgP4WjrLpMj1prNsN?=
 =?us-ascii?Q?eABql4CpLhkbYe0WuOPjqCrt5FeZM/S8P0Ng9kuLYDKtJ6OOgYl8WRUhnfOA?=
 =?us-ascii?Q?nBXEshQw6VPqaVEQcMDaZwUXbSwiryt+QaoXee8qmZWdG4R1+r/NlMn/vSJG?=
 =?us-ascii?Q?jesMiGfAthMzXQ6yF1u9zXzlfgYKQdu0hG3rHwNb63W4njdOJo5LfRkPiTT1?=
 =?us-ascii?Q?doCWL/ONjhh7vFMBW5mun4XYje0CPEunYdpA0DzmLfF+axZeJtJX8kFZd08I?=
 =?us-ascii?Q?ebN2zcdjrda7hS6xM91LSloIQr/t2TODLYaaHaaYt5i03aYdbGQGmXl97mPD?=
 =?us-ascii?Q?+AjRlFO50m2LQoZyB0IPmSeXhtKFDfhdkvNg21pT4R829NMUbok91COVRxpa?=
 =?us-ascii?Q?I5qmeKpnThOxyxGMCCOjTldGmlgkgK63rCXcjmhflBq9POQ1jTwIvFqIPzuA?=
 =?us-ascii?Q?sE956G9NB1MT/eOqrsgXu84gnn6QuPhysaQ8C6TY8DUTCbduRQLV5pHOFhYH?=
 =?us-ascii?Q?GlaLHJtc+FwHI8w2QaPHtUUhE5/YR4ovooNYmmSy4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2U+7hOoYNVKVkQxRYlsDY6WNkexGxUiv7d3hZ1HQvt5EQ+iKTaiT7cirdsSc?=
 =?us-ascii?Q?VcW0x3ZiKnQeKRgBKQxR7G9SOF0mMrrA6A/hXqONRlC65vq0CD84zX6jOusS?=
 =?us-ascii?Q?NzIvfXiqSMWlyGt3vjR7z38/Uk70R+Nz6F4FjqMJP0kTcycgJ4LGN+WlpxWf?=
 =?us-ascii?Q?glkCB8UPZChydKhzvOtBzwcySAOodwWY6+ZORydVMFEvGOp9IMD7OdJEhUjr?=
 =?us-ascii?Q?u5VGqLpxrdtlR67RmmTtuv5CqWUTbRkAvCHIdELx8iujtOfc5pX8QFeCU8oL?=
 =?us-ascii?Q?n0oQKDtd20fGmsaNuN+O2zUSka2fLbAOOl+KBmNGJGkt63TkIx4a+PCuVqYc?=
 =?us-ascii?Q?47t9P/mGgDgJidMFE+QP1KdtoJfMBAACVtFUvKSOgvT3kppr3NvmvneVuIBc?=
 =?us-ascii?Q?66qgWkr1hALeqW7t1W+osMxVl9e8FGvDcek+e2Jli2Dak0/kuLXeZxgB07dw?=
 =?us-ascii?Q?dTaxDyrHMEOdsAclDJTsxyKxtAih3vEV4H0ZBiQJ7RjAPMRqP+B3XInjacC8?=
 =?us-ascii?Q?Mrlvq0TT7V9fI0MLWMjp/cijDWdQOc1jcDiLbE895znJ+ndSJD7R5uvEG8ti?=
 =?us-ascii?Q?0KiFkSMxm/ZLyVKpqLxqo/58lcszizr8Ipe7xgX9twFWQ2v74sapsrae9JJq?=
 =?us-ascii?Q?m/HGaxktBVY23ixmVjVTM7bX0K/Cn8jEvtSI9zJa4xTw5csFrA22r4FqLZXX?=
 =?us-ascii?Q?54w2UVGLz1fhhmqujJyOaFMk4gR6A0VzVt5GGohq86vG+IMQoDG3TciqOtkn?=
 =?us-ascii?Q?MjfwRaLvFEgfUFVJZMhSdkLJTou1sYNS25KUU8Su/btnutj719DQooKknIer?=
 =?us-ascii?Q?/cEEuF9HdX+yQGNdQXau3SdYxlC/wR6KUW7uZWAflF2n5wziMggKgWcJPGCb?=
 =?us-ascii?Q?5vxYv5nt/L7iXh+qhC+Wb809+RzCqscEyDFHTh+nnYS+ygA+X6TNuQQJ/Rju?=
 =?us-ascii?Q?o51MZHS1ufO1RWVcQZzZ3IC71NT1c4GsEqZJYH6/Xe5ZsDIA6HwKPP3P+Rr3?=
 =?us-ascii?Q?sswCbxosdfwwUjH9woPphgLOrCzM/D2S8yXh1qexom/clRopHI/4wty+pYk3?=
 =?us-ascii?Q?YJJNsyiXvL93naADBM4z3+zzCeqQ2f1Gi47UfFRLFWxH2jWHOYP4tA+2KPoa?=
 =?us-ascii?Q?bYSeDt0GFLrbhWFAt4DPHdNmsWcU6QoFTzPYnl8t4b8y2o+He53KzEH9Yb45?=
 =?us-ascii?Q?dHcypJ3xce962w7lGk8qfbNqislitEnGRtfoL0J+m3uA4Kbhrt6cufWrTpy6?=
 =?us-ascii?Q?K+omvbaza9fQZApa4QKthaYNr1NAen6h/+UOxpOI5UiHA1HMOddziYzvJZjc?=
 =?us-ascii?Q?fLo3ZYLzmX70/JgXVq4JtitNFZgJB6aK3SOx1llh3lywfG3BhzMz1DVp2h8Q?=
 =?us-ascii?Q?e36fvqrqP+syeMGhcaCpbFOihmRWCtXH6TUDDEaN+jVOhw/3IKDqghJtJqMp?=
 =?us-ascii?Q?kto2EgEO+/MhaTh3wFmQal19XW+trRXuSOP6w2HnO1sXPRwqcbR5H0Yc7YHd?=
 =?us-ascii?Q?ql86oOg/JpqPPYNIvh4mOI9XxIEuEDmNe0638BSmB87smffqILVj0VJjByV1?=
 =?us-ascii?Q?/0Le8XsHZpw21aAQonUfa/Jt+IzeAZUaCWGU1LbPnMqsiNcQ+pbKwleuEb6O?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7u/wReJZDyoUHmvRmgsNSOBiSXSX+XdalhourXVmV8qA0ZW3Me63oUpCkY/OWviU5WiZkXmKsxeZVcXupMjS7/WvuurbukNsWosclWccQtrMOkck3yzGrduERgdBJM+5qDCwPbS22ranVKkg3KkRPeic6QbmoGVsGH47PytBx09IqUFdICPyGOmDHHi3Vgoafm3aAm9nFurVVsZ9FbNNffsWAf2kEqxyqHyG6j/kRFSs2c5Kbeuv9pl+9aYRQes5sbFilxVjIaGat3MYq8b4tBNltEjqq8XKPZlZscFpxSP9Lji5CnttWKbrwPkxzBAJEq01Hm1JKJzb7W15r0DUFOYut5eE53r1iy5EJVHQzf30D+2eWa/yXWmaJTDBHr/2W+SNK5qU5WsT6Juqd9bgVccDFj+Wcv+8t/0r87C5VcrXY+ZSnWgW390YdnFuKYcKCYDPrlqUSWYkTfwypJDqFrHa2he8eiZURy7uTTcdVoBSCMe4zYh3j3fPQn5KAx2m5TqyFH8TRAA0WCmQIgdoT2/idDj4Mz/fiD+fJdgfrNdy8dpu6EDxMqS/SD/TRgtvW97jXybj70RKHn+7yMI3N3BmbUSBVH8qBT1uxsi2S1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c3323a-d5d6-49e8-2a39-08dd03fe0842
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 16:12:55.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiYYoOJurvH7jCQCDhXlGxCo4I0Vkoy/ANgvG6CfV6VnNmlnZPbevtNU+Ou4f3hCBmgCIFMsX/3u8LMGRCk4zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130135
X-Proofpoint-GUID: jmLDrcYwl1Hz1vuVCu4zizyyys19Ocgz
X-Proofpoint-ORIG-GUID: jmLDrcYwl1Hz1vuVCu4zizyyys19Ocgz

On Wed, Nov 13, 2024 at 11:11:11AM -0500, Benjamin Coddington wrote:
> We've gotten a report of reboot notifications being sent to domains that
> end in '.new', which can happen if the NSM temporary pathname code leaves a
> file behind.  Let's fix this up by prepending a single '.' to the temp path
> which will never be resolvable as a DNS record.
> 
> https://lore.kernel.org/linux-nfs/04D30B5A-C53E-4920-ADCB-C77F5577669E@oracle.com/T/#t
> 
> Reported-by: Philip Rowlands <linux-nfs@dimebar.com>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  support/nsm/file.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/support/nsm/file.c b/support/nsm/file.c
> index f5b448015751..e0804136ccbe 100644
> --- a/support/nsm/file.c
> +++ b/support/nsm/file.c
> @@ -184,10 +184,10 @@ static char *
>  nsm_make_temp_pathname(const char *pathname)
>  {
>  	size_t size;
> -	char *path;
> +	char *path, *base;
>  	int len;
>  
> -	size = strlen(pathname) + sizeof(".new") + 2;
> +	size = strlen(pathname) + sizeof(".new") + 3;
>  	if (size > PATH_MAX)
>  		return NULL;
>  
> @@ -195,7 +195,11 @@ nsm_make_temp_pathname(const char *pathname)
>  	if (path == NULL)
>  		return NULL;
>  
> -	len = snprintf(path, size, "%s.new", pathname);
> +	base = strrchr(pathname, '/');
> +	strcpy(path, pathname);
> +
> +	len = base - pathname;
> +	len += snprintf(path + len + 1, size-len, ".%s.new", base+1);
>  	if (error_check(len, size)) {
>  		free(path);
>  		return NULL;
> 
> base-commit: 38b46cb1f28737069d7887b5ccf7001ba4a4ff59
> -- 
> 2.47.0
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

