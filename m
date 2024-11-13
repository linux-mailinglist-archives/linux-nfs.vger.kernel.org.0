Return-Path: <linux-nfs+bounces-7936-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 780439C7898
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 17:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6921B1F220E4
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89102158D93;
	Wed, 13 Nov 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kq7IXI/4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FxkvswPB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5A16A382
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514865; cv=fail; b=oD0wlQNCnznOsZQPjP4pWdmCIZgzuQEgPIbHovETU0cLlqhFg6J6AhaVvsv415bnNlrO/EpPCBO0aEYKdapYCyC4p58V29/siR53eCGFy0FKLNu9V4wS46JmunAT5f5xIXbsBZ/l3Wq//xOKuZax7bwAdko8dMyU83RU25711Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514865; c=relaxed/simple;
	bh=CqPIilgx+TvO+uxo3oYPNX85Sjuh1EADevRt0NSNb5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=quO4+EdUgskmVqG65FcKeb+8Guv89Sk6QqOVGDTq09IfE3M/CsUyt8p8YizkoGUuyCGZ0IKReaH+52WtgnlpjuWeNhGV+cVf3jLZfvszXMutWz0n4P/KWn8VV9HZU8RM9Rn+wq8KzwxNc4sGOThuVw3hkIZHpf3c2woseKyhaT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kq7IXI/4; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FxkvswPB reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXXfk003408;
	Wed, 13 Nov 2024 16:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XhCw4cUSoSaftw+KfyNlVS/Okj1mxk7D4y+E6zUDGnA=; b=
	Kq7IXI/4WYR127+iSoqgXf83BYQykPjhV1VXQ8+NJAM03YiyWcyk+QcwEariXwXK
	1qP/tHasglPNcnznmmFEQCAqhv6XoO8j4E1cMCc7mYkUcCEkabUFT5sP7NsFGli/
	YfslOUsD+bqnxI/9pyS7lQvp34YcQzKOci+Jj46Xmx/fVfdm9kkkODzaYAEIi6TR
	sqNfkEr2lxcQIm7W4+R9Mmib2liFMxAw2UCz+Rygn43cZYUPZIdjmuzHss36hulo
	mFdBpxZ1tF/RcxsUSUnQkoIApLehQjTynWNSZypzHCcas4BNAwBrv902RAliq7j8
	n+axOns7GlS21lpPWhKhvQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n4y7yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 16:14:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADFGT1c035927;
	Wed, 13 Nov 2024 16:14:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69hd0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 16:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH++YjqN4hEGB6bPEESRnZCvg0OHu46IHKEnF9UrSQojmIYiNTDt0sfmlc7N/pI7JNjdsrut5Wn/EdkOTQjgjEMxl1LLh6o80P7eVUT+SbFxDxGSWgev34Rjw69A5ex7je5rCGJzfr6G6bJPLebqmlmrc+rKIlGnVgWMxiNJE1dzLqMmySj9683AQYgWaCCS8ZvympxhV1yP37gg8xwFySfgmFdE9kZdhVacKy7Q74dHTHFhujbScFimKmL9OZGkRCrC/wWyeDe1ACuZeoFuE7Wosa9u/sRjY3hy8hkam/+9KL0cgDa1VZLFgbVtCZIdAd9zL5Xlvd+Tw/qAFrzi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIkvZnhqhZcwOhWRJj97XrVL4U+0FsrnVV3Rk1eQnxQ=;
 b=OyIP/YfNMjHEkDF9q4ytPaSJpqZzyBCv8pUvGIzatIl640+HSl4HYQCEjY2Yw5Ds4LMczOQebJ1Y+hESfv8/QC5zTp91Ve17gzEQfwlbimdGQen8RieL61qlSOYKxQSaxRoTrojHBtfhKJfdA1JwkDtMiCO2CVt2K+gFwmRpuq8umO0G6j7PJRM5S+06ozxSaOyasD4y9nPzXbSxEFtytWmz4j3c595vvwl6RNKPDsoqdjH42WZJ87A185rs/UT5e2hp0VRtQJyPCpj71IbsOQFG8MACDZW/zH56qWpz8CFO/NdEgrrs/7uvGVr5lcdda5QfEDJkfJUP/lGBvlJePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIkvZnhqhZcwOhWRJj97XrVL4U+0FsrnVV3Rk1eQnxQ=;
 b=FxkvswPBXNIiCvhBLgbF6LNvoADPrH39Oi5nnqd4AVncdFIT2SKNMWAXwGnfMY+46Nsb1ZIi6gc83eAP43dFdvytcjSYZQCkgEzvM9Mw9YvuX5P5Wv9f/wcOMq4WRbfJJ/lOuSyrxaYyTxUTK3InednmgD71fMFtvjf10xFwEf0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7723.namprd10.prod.outlook.com (2603:10b6:408:1b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 16:14:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 16:14:50 +0000
Date: Wed, 13 Nov 2024 11:14:47 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Thomas Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Subject: Re: [snitzer:cel-nfsd-next-6.12-rc5] [nfsd]  b4be3ccf1c:
 fsmark.app_overhead 92.0% regression
Message-ID: <ZzTQd5NKe5WXkLlA@tissot.1015granger.net>
References: <202411071017.ddd9e9e2-oliver.sang@intel.com>
 <4d5d966b2efc0b5b8c59ef179e99f3f8fbf792f8.camel@kernel.org>
 <ZzTKQGYJFh7PH4Fw@tissot.1015granger.net>
 <48ad2574e14c35aca27c10e68f2a1069ccb646df.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48ad2574e14c35aca27c10e68f2a1069ccb646df.camel@kernel.org>
X-ClientProxiedBy: CH2PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:610:5a::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: e04b7cf6-cfc6-4c31-0627-08dd03fe4cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?mTV7iTRavhzGC7BrCTOuv+n+6oNJulmsauKK1B1ZCZrfzqg0NV3W1IacgS?=
 =?iso-8859-1?Q?dBx/IgqokFLgOnkCnAetekjQP3v0Qenq3TKPeHVCc5I0C+UcgBgv0NJn3k?=
 =?iso-8859-1?Q?1Kg37P9GH5KKOajOW803bNybvdI9rIIcDavXeQHU5tEkykr0iJtTqxHJsD?=
 =?iso-8859-1?Q?MzGe9Y4B9hlVvHtkn+YarzOZLTtUd7I8Ee3ZrbLRcEpxHkoLFXtr9gw7PM?=
 =?iso-8859-1?Q?uOoe5Avb2e3UrWS0vx7Pm7oTyNo1dgUtbbAiuG3xE9ikNKyUcX9BkVgo6n?=
 =?iso-8859-1?Q?FpuXQ3kZfodNLEdeudHkuFiznkkZ0llOAEakuCOtCKIGNSIV2v0qfcIws9?=
 =?iso-8859-1?Q?YBn/EZuZHWJnzh+CY9y/9hPbp3aj6HcsPsXPxZkgbMSMmQNvCq7n97qU8v?=
 =?iso-8859-1?Q?BgdUDG+v34eVwSWJLqMuYPIzhAIqHud3w3+B6LqD1ZSjTFvsuiQXgVqC+m?=
 =?iso-8859-1?Q?wpvu21XZIyOu/sd7/rVaJptGuy4+RZ8UzT8DQqVnWToM7yoAMubrJDchHl?=
 =?iso-8859-1?Q?0LDFSS0tX5mt01RQ2jo8DN7n/idbBExfLNWaAvPdmgTnkNf60dBEEyqtr9?=
 =?iso-8859-1?Q?49asvhZDjvsWAt9noC7pWv62clqjgDF/NPzbGXGGfqOyqCITofmshtvT78?=
 =?iso-8859-1?Q?o/ia35PGvyrzW+Dfpn+Dmfaxt7zuLfUau0iqoqDqcy5tQCjyxHJHv4/L0q?=
 =?iso-8859-1?Q?AdEw6Mmi3LNO1zn9KKErJMrE9lFsQKwLgbcqpOqiBokJsNubT7UjKcZeAF?=
 =?iso-8859-1?Q?thzYe0hGlKBhkgoZCZ5myUTsCFM83TD2PmbjxDt6CT/j4UV4YwSfr8IiVj?=
 =?iso-8859-1?Q?bUfiF3VdRnmMbOApD503Nq5L9Xo86aqyH7+02Stib/XSE1WHIJ5JfFbxdY?=
 =?iso-8859-1?Q?TeZy0O0L/lC1bm7pbAckOuD7aHR4A4WqP4cY/RtJs7ffqNZrR8xxZrxY8R?=
 =?iso-8859-1?Q?l2ZihnIXuPRh7kdctLUoxpYDl3DXlCcfAGttHaVLWmL8kSJAf16aOEXsYJ?=
 =?iso-8859-1?Q?9sFFxEUNDCHu7LjqnnQQIzc6/jPiRRRtUFuutVbVT61qG6SKpzUQR0UDh3?=
 =?iso-8859-1?Q?snAqC2OPI3O5qOqMdPQ2isaC6LbiezoBcvmv8BaLeLeMOos1w4owhvSUDJ?=
 =?iso-8859-1?Q?YOA58OQo74Fuu4BF5wMIkVKB66yte4714BvoQHrGl3d7PP3WJVSwTEcjHB?=
 =?iso-8859-1?Q?LqokrP4d+vqKiSfIBeUWLIxHVOMkuzMDDx0Ocn5Y+7D13fSsOsOpezsLIr?=
 =?iso-8859-1?Q?eRBB9ozxA0W4iGCTsg6tpU3irK1aYa1TB7WAMTj6YE5scCAXX0qoyN3nXd?=
 =?iso-8859-1?Q?7aLQ5dChjFjbHjQOCGy8UzyyGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?VzCAMdjnnkM8lrOJuIh0Q85yic8dmWXtjSvYKnyW6yzmnDrHWFNuNNFj2I?=
 =?iso-8859-1?Q?BPSg0ND2x6OB5XZQ6rmjaKTa1qAjX1sKjzQMPWr6roI4BLdPhHrJn2+4So?=
 =?iso-8859-1?Q?sMTkAD5SkRIhzAsWnl/nyD9L1ZIYziCLE/smbAKRoXzDOSyTy+hIZ8wenf?=
 =?iso-8859-1?Q?+6sQP8kXB0sw50p71Q3EBFv7JGsIivfpnJO4CxlNNoiUtdjHWRyrafSn9c?=
 =?iso-8859-1?Q?HapSs0b51/+weUpqSxugjWC+M+bb5XWPgflKIMSczP7Zh9CCvDolrdw8lZ?=
 =?iso-8859-1?Q?IhgeY/fSIp7onFB2t9AGi+y99WNu9QVTpjTvS+vpzr7BY/kA1oqB3NSa6R?=
 =?iso-8859-1?Q?K/heh2dM/cH8f207nwleG3m0NdoA88NsnkXMljhBL17J4benuX40cQEtZm?=
 =?iso-8859-1?Q?dZrk3skcB98x/E0VXsw/nW9S2VGsZCOS1WcaONU3y1F2ToPDSbwOhnCfvZ?=
 =?iso-8859-1?Q?mHLzp2MOK74kHOV5YjkveUr2dR9tskVs5ldxzWc0O5cpJz7ZQBXNH3SXmN?=
 =?iso-8859-1?Q?r+/BqVmopguelaz6zq3cXERmG+O9v03T4lvXJ2l3AtX0t7M0q280x32URK?=
 =?iso-8859-1?Q?IkaqehwNEsXlv0V2kuQLzFhK5zh/EmAxyqBKQ3P6irYlzph1s++Ka73KfF?=
 =?iso-8859-1?Q?jpL+OUqKLYtFsH/V0YbVAGETZDU89dDD3g/7O/sBNMCGV93ke9FEPvjfla?=
 =?iso-8859-1?Q?hfYtqxBeajM+FRx5tVkqT0HqQPK/K66mDJ8o550oIoJynlnavkwjXIQEE+?=
 =?iso-8859-1?Q?KHsSs9IuDTaP+HiqadCgrlyEcjKXTns78wveqCobGw80iD+qRoKnxoanEH?=
 =?iso-8859-1?Q?5Kc9mXS/wICMScCb3IThZsjXwCu8w5+3QxNYRGo58CwEon4Vbv8shpJN6g?=
 =?iso-8859-1?Q?LJtGr+dqyKkhBXb/W9gYDXjh0E+jF6pf/FcE9qJfLVNiRfsk9P/gX6U7B5?=
 =?iso-8859-1?Q?RX6Y4lJJbQg8tbasNqoLgen1cJMCt/fQH1k1qbQYGj0IOnO8f0qJGQGP5V?=
 =?iso-8859-1?Q?WNTlM4XH3hUjzets4u3afVDChA/lSVDh3dzQrCCaZywdvguCW/zvxnxliB?=
 =?iso-8859-1?Q?IVECWkpJTy0wSpt82A67rBV/kqdlkRaT2penDUBKUC1fj6BkI0P1mJMLzs?=
 =?iso-8859-1?Q?CwTnW3xxKJzmUdlD9DyomW5cW94BySX9lWXIByj2jiS5a0XHLt9/88pcAC?=
 =?iso-8859-1?Q?0DRsimfvRLrCjYQ7RLOkFlhFuek4Gpc3q6q890OwYrt2sLuWNnYhT+KX2o?=
 =?iso-8859-1?Q?lCRxo4qoYSD7yVgbnwFV0SNfwSSLyXTe/xY78Ctnv2G4qqh8xwXh3T6SNk?=
 =?iso-8859-1?Q?+f5j039d66qKXpF3qLQv51UTY8UwihPGC+dYtsOvLROoSrRABlsyQ73+/Y?=
 =?iso-8859-1?Q?mbBVgqKGLQnbJz3/QC3KOYhree5PsAX9AiuuPsS+63+rT4Jap2ZOPUnMH/?=
 =?iso-8859-1?Q?CMHW/z4aZFZh8X7696MO3jk441lpOl8+/RUE8puCFu+txtPt9AkEI4Fgc7?=
 =?iso-8859-1?Q?flACQVxM2tmdbsSDD+kjucQY6wvy9Jj+dGr6pnj778cZ+OrdOwA7peQqea?=
 =?iso-8859-1?Q?4ijdqx65W7qFoNkX3oaY8p0fcG8UuKAKZ+6XZuf8vuwAU9/ffFUXC0EO1r?=
 =?iso-8859-1?Q?m7Fa3ShRpPIlKYGMe8lEVp3AXCGT7xm0yEN4p+9zUyQg3jSCl5sUQd7g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oNQOKPhWcCqK6LvpdyUBYRr83R1R1kQM5hSB5iyA98cvtfOoRFT1+sCqi/AKlkjKLb3PzwIvjlgfZfjKn+a+kYeHudOePNQxrFMBMJABfKMcpozxqu6n7tmTrKRQr7/gwk2h4GpPhvX4d2KLDI0ZAzFGJTnGmxXIU4QObV3rQB7/FQ4Y2r9BARSoQlNp0Qa2K87Ld0XWyw1OAtzTdh7CBXr0T66sXmiNYdNmIFhHSouq2zYpZzFvydhOnTZU8DfNsVGtoajqwDH/1nWdvsji/fKAfNKMmvOKTghcIQci1eFiaTKgTA7AFuh2ULYa3Q+kl8f+phnMx4qYpVgEczAU1xV5Q6bO2uFVhhTyvRJV7FY8rN3Nqty/wxp/6pKG8wuU7hL9LjB0wrLu6H/ku9WUe2GxHIQZ5llLrxuGCnjDTYVwFKVjYqMqeyAjLjQj4O/hwXdgBdRR876mvPrJVvwfFYgAAFEduVex5d3sn3bt9XuV1aW0P89XEXaC2nbC0eQQeXX8+C5+mS2RIrgmMX3Xfoe8fCc1v6W1pDFpbp8rzgUQOQ4SzrHilA1ACRysPRew6Vh8nVzNAQ0wLbm+wE1VF9RZRjFs4epQSqdPHoSXg+0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04b7cf6-cfc6-4c31-0627-08dd03fe4cd1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 16:14:50.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+SuFGxfifXxLaVfcnprELyV5RFXcohw+S0mC+3tMpGZT02mCoh2BG0YCF1pAvmtGva7vURuOtyv7Ux4GfUnOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130135
X-Proofpoint-ORIG-GUID: Fk6s1J6TyQgA7hlONBiOktSi138ZM5Qy
X-Proofpoint-GUID: Fk6s1J6TyQgA7hlONBiOktSi138ZM5Qy

On Wed, Nov 13, 2024 at 11:10:35AM -0500, Jeff Layton wrote:
> On Wed, 2024-11-13 at 10:48 -0500, Chuck Lever wrote:
> > On Thu, Nov 07, 2024 at 06:35:11AM -0500, Jeff Layton wrote:
> > > On Thu, 2024-11-07 at 12:55 +0800, kernel test robot wrote:
> > > > hi, Jeff Layton,
> > > > 
> > > > in commit message, it is mentioned the change is expected to solve the
> > > > "App Overhead" on the fs_mark test we reported in
> > > > https://lore.kernel.org/oe-lkp/202409161645.d44bced5-oliver.sang@intel.com/
> > > > 
> > > > however, in our tests, there is sill similar regression. at the same
> > > > time, there is still no performance difference for fsmark.files_per_sec
> > > > 
> > > >    2015880 ±  3%     +92.0%    3870164        fsmark.app_overhead
> > > >      18.57            +0.0%      18.57        fsmark.files_per_sec
> > > > 
> > > > 
> > > > another thing is our bot bisect to this commit in repo/branch as below detail
> > > > information. if there is a more porper repo/branch to test the patch, could
> > > > you let us know? thanks a lot!
> > > > 
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed a 92.0% regression of fsmark.app_overhead on:
> > > > 
> > > > 
> > > > commit: b4be3ccf1c251cbd3a3cf5391a80fe3a5f6f075e ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
> > > > https://git.kernel.org/cgit/linux/kernel/git/snitzer/linux.git cel-nfsd-next-6.12-rc5
> > > > 
> > > > 
> > > > testcase: fsmark
> > > > config: x86_64-rhel-8.3
> > > > compiler: gcc-12
> > > > test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> > > > parameters:
> > > > 
> > > > 	iterations: 1x
> > > > 	nr_threads: 1t
> > > > 	disk: 1HDD
> > > > 	fs: btrfs
> > > > 	fs2: nfsv4
> > > > 	filesize: 4K
> > > > 	test_size: 40M
> > > > 	sync_method: fsyncBeforeClose
> > > > 	nr_files_per_directory: 1fpd
> > > > 	cpufreq_governor: performance
> > > > 
> > > > 
> > > > 
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > Closes: https://lore.kernel.org/oe-lkp/202411071017.ddd9e9e2-oliver.sang@intel.com
> > > > 
> > > > 
> > > > Details are as below:
> > > > -------------------------------------------------------------------------------------------------->
> > > > 
> > > > 
> > > > The kernel config and materials to reproduce are available at:
> > > > https://download.01.org/0day-ci/archive/20241107/202411071017.ddd9e9e2-oliver.sang@intel.com
> > > > 
> > > > =========================================================================================
> > > > compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
> > > >   gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark
> > > > 
> > > > commit: 
> > > >   37f27b20cd ("nfsd: add support for FATTR4_OPEN_ARGUMENTS")
> > > >   b4be3ccf1c ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
> > > > 
> > > > 37f27b20cd64e2e0 b4be3ccf1c251cbd3a3cf5391a8 
> > > > ---------------- --------------------------- 
> > > >          %stddev     %change         %stddev
> > > >              \          |                \  
> > > >      97.33 ±  9%     -16.3%      81.50 ±  9%  perf-c2c.HITM.local
> > > >       3788 ±101%    +147.5%       9377 ±  6%  sched_debug.cfs_rq:/.load_avg.max
> > > >       2936            -6.2%       2755        vmstat.system.cs
> > > >    2015880 ±  3%     +92.0%    3870164        fsmark.app_overhead
> > > >      18.57            +0.0%      18.57        fsmark.files_per_sec
> > > >      53420           -17.3%      44185        fsmark.time.voluntary_context_switches
> > > >       1.50 ±  7%     +13.4%       1.70 ±  3%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
> > > >       3.00 ±  7%     +13.4%       3.40 ±  3%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
> > > >    1756957            -2.1%    1720536        proc-vmstat.numa_hit
> > > >    1624496            -2.2%    1588039        proc-vmstat.numa_local
> > > >       1.28 ±  4%      -8.2%       1.17 ±  3%  perf-stat.i.MPKI
> > > >       2916            -6.2%       2735        perf-stat.i.context-switches
> > > >       1529 ±  4%      +8.2%       1655 ±  3%  perf-stat.i.cycles-between-cache-misses
> > > >       2910            -6.2%       2729        perf-stat.ps.context-switches
> > > >       0.67 ± 15%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp._Fork
> > > >       0.95 ± 15%      +0.3        1.26 ± 11%  perf-profile.calltrace.cycles-pp.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > > >       0.70 ± 47%      +0.3        1.04 ±  9%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary.common_startup_64
> > > >       0.52 ± 45%      +0.3        0.86 ± 15%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > > >       0.72 ± 50%      +0.4        1.12 ± 18%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
> > > >       1.22 ± 26%      +0.4        1.67 ± 12%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events
> > > >       2.20 ± 11%      +0.6        2.78 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> > > >       2.20 ± 11%      +0.6        2.82 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
> > > >       2.03 ± 13%      +0.6        2.67 ± 13%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> > > >       0.68 ± 15%      -0.2        0.47 ± 19%  perf-profile.children.cycles-pp._Fork
> > > >       0.56 ± 15%      -0.1        0.42 ± 16%  perf-profile.children.cycles-pp.tcp_v6_do_rcv
> > > >       0.46 ± 13%      -0.1        0.35 ± 16%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
> > > >       0.10 ± 75%      +0.2        0.29 ± 19%  perf-profile.children.cycles-pp.refresh_cpu_vm_stats
> > > >       0.28 ± 33%      +0.2        0.47 ± 16%  perf-profile.children.cycles-pp.show_stat
> > > >       0.34 ± 32%      +0.2        0.54 ± 16%  perf-profile.children.cycles-pp.fold_vm_numa_events
> > > >       0.37 ± 11%      +0.3        0.63 ± 23%  perf-profile.children.cycles-pp.setup_items_for_insert
> > > >       0.88 ± 15%      +0.3        1.16 ± 12%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
> > > >       0.37 ± 14%      +0.3        0.67 ± 61%  perf-profile.children.cycles-pp.btrfs_writepages
> > > >       0.37 ± 14%      +0.3        0.67 ± 61%  perf-profile.children.cycles-pp.extent_write_cache_pages
> > > >       0.64 ± 19%      +0.3        0.94 ± 15%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
> > > >       0.38 ± 12%      +0.3        0.68 ± 58%  perf-profile.children.cycles-pp.btrfs_fdatawrite_range
> > > >       0.32 ± 23%      +0.3        0.63 ± 64%  perf-profile.children.cycles-pp.extent_writepage
> > > >       0.97 ± 14%      +0.3        1.31 ± 10%  perf-profile.children.cycles-pp.__sched_setaffinity
> > > >       1.07 ± 16%      +0.4        1.44 ± 10%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
> > > >       1.39 ± 18%      +0.5        1.90 ± 12%  perf-profile.children.cycles-pp.seq_read_iter
> > > >       0.34 ± 30%      +0.2        0.52 ± 16%  perf-profile.self.cycles-pp.fold_vm_numa_events
> > > > 
> > > > 
> > > > 
> > > > 
> > > > Disclaimer:
> > > > Results have been estimated based on internal Intel analysis and are provided
> > > > for informational purposes only. Any difference in system hardware or software
> > > > design or configuration may affect actual performance.
> > > > 
> > > > 
> > > 
> > > This patch (b4be3ccf1c) is exceedingly simple, so I doubt it's causing
> > > a performance regression in the server. The only thing I can figure
> > > here is that this test is causing the server to recall the delegation
> > > that it hands out, and then the client has to go and establish a new
> > > open stateid in order to return it. That would likely be slower than
> > > just handing out both an open and delegation stateid in the first
> > > place.
> > > 
> > > I don't think there is anything we can do about that though, since the
> > > feature seems to is working as designed.
> > 
> > We seem to have hit this problem before. That makes me wonder
> > whether it is actually worth supporting the XOR flag at all. After
> > all, the client sends the CLOSE asynchronously; applications are not
> > being held up while the unneeded state ID is returned.
> > 
> > Can XOR support be disabled for now? I don't want to add an
> > administrative interface for that, but also, "no regressions" is
> > ringing in my ears, and 92% is a mighty noticeable one.
> 
> To be clear, this increase is for the "App Overhead" which is all of
> the operations between the stuff that is being measured in this test. I
> did run this test for a bit and got similar results, but was never able
> to nail down where the overhead came from. My speculation is that it's
> the recall and reestablishment of an open stateid that slows things
> down, but I never could fully confirm it.
> 
> My issue with disabling this is that the decision of whether to set
> OPEN_XOR_DELEGATION is up to the client. The server in this case is
> just doing what the client asks. ISTM that if we were going to disable
> (or throttle) this anywhere, that should be done by the client.

If the client sets the XOR flag, NFSD could simply return only an
OPEN stateid, for instance.


-- 
Chuck Lever

