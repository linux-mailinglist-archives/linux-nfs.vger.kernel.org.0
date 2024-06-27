Return-Path: <linux-nfs+bounces-4370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA2E91AC43
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 18:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580351C228DD
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320121991C3;
	Thu, 27 Jun 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EJBznJGY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ehwP6kGz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E43197A96
	for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504445; cv=fail; b=ByvhYHgZ89EIHnNUY1tHB+rLc6WdvBMQsr/cSpE+S32fudgKV7fm0jjjcQonWfB/Vf9yVvpidnAN6Fj/+v0JuDVy2aEPcEzK/Vnx+gXvvOyb6v0/2J2MjhfVkMNVps8jMSnjmaivM7d24kQrpfrKiGopewiuY4xMrjgQllOIIZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504445; c=relaxed/simple;
	bh=mi32+jDItliEjGWHnec+gg67+aO6ATkfvMqSA8n9fOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oD6E+evd1ZpZE2LGmafEWTcjf6BwS4CivfxmBn9XqgfR/tQsDfDapf7/QGuaLMFZ/LYPAXadRKFE5qXU5fNpR8vYhXgU6iQZwmDHpK1yr60V1xotSt6QjjAEtP5gp9uDG4mvwz/eC+WF5dbY0s/DqV6SkRLSvb8JBpItQIN8h9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EJBznJGY; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ehwP6kGz reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtmmP018552;
	Thu, 27 Jun 2024 16:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=b/LJMgRFWJVMlYHXeq5nVJP1QWeVDUJYDjg0UMVFBY4=; b=
	EJBznJGYmfW9QhCTmgAbtPEYCb4Xj+xrc7/SeBXgbiVZenc2pNKt4LCuAmw2MOQg
	WGphklt4TQo3jE1+EgO6PY4jiLFsuQzs1lDh9Dzu5owQkg0xZB9zhXvh+FR0HlnO
	PYohDw5RNlyuflIq7VclxPY6JRpq6essvT+ISnXTwjY0tOdOkxSaYgAqtuw5rhjJ
	eIoJ2/ykbEwq518tH9SFJvfT37kQK0HbLg+fmYbo+fmiZ5+J+idrZ1BV+bVO/cxU
	S6P7+wLyE6RsJPcqdbpDPD5Wp8omrVB88i//wJUJXKjH05a+4ZRsxUD5rhLaT/De
	L3osPeAlGMHeMtjcW4FDpQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn70edvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 16:07:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45REfi4j010721;
	Thu, 27 Jun 2024 16:07:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2h49x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 16:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbiA5UOzADBrwXBBtRaJ9mnYV9B+G+vMIg5oFbR5sdteOoEAjv+ts7DaQjmictvLc0JHC82ftO053rTbwzT5G0M66N2aGt7zLglhm1jhG0DAYJrK5uhV9/EtqfrP09zlmg8knPBY+COTEBwkibJo7A2rblLjJPh01U8t1O38GrSJKMmA3h+R5NfmHXRxJti4lLBXBXp+T+SqpKpcpWNVqC/bSdxLIMYgipcqQIVrJGjTUk8TuV/cG7egx6H+Nlj5bk/sj2kYIPvz+v5Tw/ia+pYsrGMucs/w9liR6GoUkyv4v7eSKykDfFBHMG439JujoPPrVHKvi9JEK1XBigBPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exFx1v6bsOE3o0Jwvc74R/bgfkcoqjCxB9LrrlZoeKo=;
 b=Rrl8gsCm2tUlHDAkAViKft8CpUcJCRole9IEna3FZOm+W6EpIjbE2/ZaMyNoa3aMyhpiUO5NGo/e851gLenEKmIJW68mFFGIo96V39t7e5l12C1bz0gfPbiNaR0rvHOG6TmDivimLNwTlxFp+6D4nEgZdzWUaIp3e2AGgJ+silpNUFVUpPjySX8xcaYs+sQB8Nkalreh5dMzosvJw7eA/afwKsEhYe4DSV0kDcFAml8911aECPphUEllRJM2d73M4FnpsYYKzTlRFh3X6VSwxgdJ9286yupPT7x3c+s7N6rWFyQ5O9KNwMiX99yg8W4wFWbSUG1oVNK+qBh/5WPuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exFx1v6bsOE3o0Jwvc74R/bgfkcoqjCxB9LrrlZoeKo=;
 b=ehwP6kGzJJWju965EzueQudQNi1yHsGSF2evfG9Be/d8uqmPsOjCCwZAmzRDZY+Auna9Zca8EN2QbBKV6NihinksPo3dFhL7I7HIzApn2jNamle0X7D9hxnONX6MSI/rYZr3wlnAmuFJYWNf4x4SjSzl+tfotwryYNEth+OzDyg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7679.namprd10.prod.outlook.com (2603:10b6:610:169::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 16:07:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 16:07:07 +0000
Date: Thu, 27 Jun 2024 12:07:03 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v8 07/18] nfsd: add "localio" support
Message-ID: <Zn2OJ5UynQmwMGEA@tissot.1015granger.net>
References: <20240626182438.69539-1-snitzer@kernel.org>
 <20240626182438.69539-8-snitzer@kernel.org>
 <618117cfff2c4581cdcda15586f3f771e37faebc.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <618117cfff2c4581cdcda15586f3f771e37faebc.camel@kernel.org>
X-ClientProxiedBy: CH0PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:610:77::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: fb225a83-0d4d-4631-8dc5-08dc96c3314c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?iso-8859-1?Q?GW7QgiLlfI6rAKjXS1X8pjqWFMDxDlll73ze77yzkNpYwEhVOxUXG91sh4?=
 =?iso-8859-1?Q?LuhujF8lh3aEwezeN53EZM4cO6a3yq+MCvhgP2xy49p6ywNKZV8lrfieTG?=
 =?iso-8859-1?Q?Ide9a3jrAp8A80OUnwjOaGY0/dhnAddpFZ7Ccpru09Vzytu96xbwJdrbow?=
 =?iso-8859-1?Q?8LnCv717w2eNOUz4PzcSgqjm29ptjtt8J4KSxI9u6hiLzgrtKot5INhxdc?=
 =?iso-8859-1?Q?VgdQafV7UXquhDgxCi8Ai+GfnqHO6zBNm1Q9iGphBER5AHlp+Q++QKUkgv?=
 =?iso-8859-1?Q?ttQxcFK/2GhMu1dCtcWti46U4oT9rUBzmm0XCtNXd0lgUJ5/H8vBqA2Uda?=
 =?iso-8859-1?Q?BcUdmSq1iehKYmtf2erZEYIshq5m5w1Kfk/iiiWLTt0uWEEtKSycObqGNU?=
 =?iso-8859-1?Q?4F7HO85h/8v6BylMrU5dpIUo/Sbp4ykzclMHb/hiRTG9d+s5qDyeIgsUAv?=
 =?iso-8859-1?Q?byIu5i4Ydzhg2Ymn2fYAK+AzV074ZMeshb9p/LuMi1w+17ofBRsE4j9gw9?=
 =?iso-8859-1?Q?evKdNqNuOL4HMSvHtqRe9PS9aHhCWx93AZJJjTkWx74iBEUDLzTQEAAYsj?=
 =?iso-8859-1?Q?6OYP3ktrwcLJWiOiEsHoYR9Ssg/xVcFVt5gbveNvY09hxW80whNhAeRt5+?=
 =?iso-8859-1?Q?1VLzyTPbB8eZzk5cdya39llFRDFwJIRRSUBeHcLiiwf40DZL5bYRlKfIlH?=
 =?iso-8859-1?Q?4PJeh40O6Did0Yls7uyWL4xKcU6SpcTYN3AKrGepRb7xSQEIwckuMbeMFA?=
 =?iso-8859-1?Q?USsUaLh8TaR7aDuYuZ2e3ICb99pR/HYOlOkW6q9Aoo4OuujtJ90SX0ipHp?=
 =?iso-8859-1?Q?6nM/Ei1jGQXEDKbJIrXDWJ+s6rG0PNqyZ6+NTzQ/IZg5vRiCM5zBpXl0lJ?=
 =?iso-8859-1?Q?wGmr8vcRxuXHMNDQdpnKiEj0LkRhYtGxPvh2umR0F0aGyqMBrYTGpvvOCM?=
 =?iso-8859-1?Q?jRBDoPNIPvU+SFCfUPMj6VxF96sEbaTacR8O1uVka2f9HJpBfxO/yVIPzE?=
 =?iso-8859-1?Q?v/dO6zLCBk/G4wyFhPlfJfMUKc7u8Q30s1EfeHJqWwRMb8L14moL3IY+Re?=
 =?iso-8859-1?Q?aPo8peBdJ9iaNBkJ+U/13iva8bH4FZ/Xhrza+Y0b8P3M1y/0Otxo2DTqnY?=
 =?iso-8859-1?Q?lxaCbyf027AKsjAIum/Szgb1+pfGcumuuWT9HWo7TRNvqLrRf4S1x65qUN?=
 =?iso-8859-1?Q?Iz9getPOm3ATdv7TFevCxnCFehOxtNAp5JwzSro4Wltgeyk8x0pgLyuY3q?=
 =?iso-8859-1?Q?i5t6dPd1J0V+G6iQc1kRbUrjzUBwyhUfMVsMCneD2hJhFj9bBAbbZhjlhS?=
 =?iso-8859-1?Q?G61yA7dz4UJy2tsdsD28/OSMsuEr7uGMVy7u2QmYEBRs0cKJwhNpLpuNvg?=
 =?iso-8859-1?Q?UGFRGvqLVApESF4XQQNsR6RCWaURxPqA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?Oq2BtQRfw8z3u5hlNmOOSKkNkTt3pS6pjJNfIFPHolmy03mEXabcApuisA?=
 =?iso-8859-1?Q?srlY/z71c7+Pi4THJ8vocaerGBE07opVn1cud/xVCiqy5xQKbkDa11c8k+?=
 =?iso-8859-1?Q?Eh8kz9e5iM+uu3nd/PPrxCzFkVYcGPOfNftXVBcyT1NCWqTt0l2l9r1/a0?=
 =?iso-8859-1?Q?cKKOLIvVLPgDQMeA16+kKbz4nZXlfaX+egWVdVSAbaqK/pRIpMjtCjEu3s?=
 =?iso-8859-1?Q?zZ0wHCO7qYVHEsxxYriyo1jd7sxd3BkaRhq3PZoj4FYUikR2NkPcZJj+gm?=
 =?iso-8859-1?Q?d6x1QaW7Gb0I/LL56FwJgA4TvmaAtBmL4+SX3/PNCR7S/mXKJSsy9h/ymL?=
 =?iso-8859-1?Q?5KvPizw+q50buF0xaKBPSx8Z02hnt0jWOjmAJOEqxWF3coR9vvYwQdO7vp?=
 =?iso-8859-1?Q?ds+iCzxaMDMs8yuzi+pIHXSAWvE08MIYrSV4Lt/NeGusOTZ1BZuv0CzIz8?=
 =?iso-8859-1?Q?U2ZNHK5WbAxxcWARAP4ADkJB2HyL0V5Jo9YAf8l17e4nHAmbzCsiL4mMjs?=
 =?iso-8859-1?Q?JaMrrsa855ZLh1ETxEUbXJbbrMCqi/mnsSBviFfT/UPP+GO6RmKMlBFLEo?=
 =?iso-8859-1?Q?Na4lDbMQQNiGYWrh+uNJS1IeHb4Rnywos/9jpp+0GLt4KFHlQUF2/X+BAG?=
 =?iso-8859-1?Q?FClklfCRFXkMb0OLsZOClMxX1bIaFBJ4BVTQ7eFlgpZq9+pkidPufMjzl+?=
 =?iso-8859-1?Q?Dpnpb1LCD2Pc9j4d56C7fxqH27nS+FIinhTyzXhjeocYExkjh6X6ugASV5?=
 =?iso-8859-1?Q?mejWx/z0FnXfqwbhlrTI9/CUS5mer473rzfGjlYK9lS01wA8DUA+cyGiCB?=
 =?iso-8859-1?Q?KnksxovjXZ41k/5G92yDxJP8BxRrTcEEDVc90SzNUApnNxUQaqVPx9KJic?=
 =?iso-8859-1?Q?UCwH4oEMeqINz0IBNLO9cDblrFGhW8Vvg67vjOjfAgjKYLHAVGgqtXUeKb?=
 =?iso-8859-1?Q?8cGInLLRQa4onZZQcY24e2SGg0V1E9cQbNaDuq4flfoEJWCYKNBAwWHbG3?=
 =?iso-8859-1?Q?hmJ8rh7soPr9Zq3bWce2nJ7/upPiDevlLI2ZOwEoWIPJledV8RBe3uBco5?=
 =?iso-8859-1?Q?Bn14Wj0Y91XMaW4iIRnP2VfVZkpK3c31S9DvqgjCKRmJl/0txL5L5/BRJO?=
 =?iso-8859-1?Q?18Klcj0U89su9jgABCJDlsemgdn1Uy+cholxsHmgvRtzffP9W522JAlOtH?=
 =?iso-8859-1?Q?lXj4M79ZMfvid49LpKE8TUAHylcePwK6uoZ4ouor8R7V2R2Rw0T67fZfTt?=
 =?iso-8859-1?Q?7NmZ4yTnuoIfiJ0WFq25lyMgBzmxBjXoSa1C6x25Jb74aJ0OsAGEhAscl5?=
 =?iso-8859-1?Q?ifS23P7gYQ/g8ecz8WMhwVDaOjEqlRMtPgRA+n5V3jFZcF3eJ6MxtDc+vW?=
 =?iso-8859-1?Q?Mevj2OxHYioJExOmiRpAthsmn6oN0tzQqwppKXPjwEJ+RRfnCv69dfXlli?=
 =?iso-8859-1?Q?wFOrrEZwkZXGvq/GhhQgLbKOeQ5myslwP4u461QKhy9DooxoVdbujeTgVj?=
 =?iso-8859-1?Q?jReojXxZUciOLfMO3QvHBdCKFJk6PyyaKeWIwyZFLzgnxDoUNpn9XLrsAl?=
 =?iso-8859-1?Q?jL1yQ4sgtabqWJQwc5TgEsjkm02i/oZg6O4Nq65+yUM1qaHOcYsgeEKv5G?=
 =?iso-8859-1?Q?R+JKdKJm7LDNAJq0oR7h4UtsiZlGXU9iTo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EaAN6+wFM7uGIGsImh9ptcxLLsivGj/j+kBDdRjna5ho3yTaTg49kChWJMezu7gHgISVmllSUMY92nf1KQo2+stqOuRngpmmZsNGYJyvtBEP2AA3X3CRebjwKYkINPKKDLkmpJXxN3zCUxz5uxda7Z/dIEkAFyvkKfrs/COItAERRdK696qSBac90ThSdYH4IvE99Zc8HcaWE0D/2Tx6u72/8Yak38rfKehPM4P93ojZ6VnDVzMx8LN1NmNa4QejBFZELyF1EXM2BsZ/DrBV0brazh8Eb1252GxBYJ0osXNPRsdglenZyU3w4Z1iH7hDgDdWobbXUlx/DNSdSaW2yxX9fFiNnqFpbh4kbgnQw6ldlak5eb0s0Kvl4bN1tVyWuEIMOCZuxCdeXSsgZ/M90353khW+g8QYptmiTgKbdWCxsqQY+WNyLl/Jg8Frrp0FKFLsh8dPY3aKjV++3hCWaY3eD7DOdGYUyzs5gLaa8d/UTb2XJHjI08ej3eJVg4shXClWF1cu14T04uvJmpWjyQcaR1H2SuYgNjnY16qkR9DkNowclski5CZeWdgh/R4wdolAwDygCWAdZuNE0ir6djzw2oymid+m7DYa/Y5yC3k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb225a83-0d4d-4631-8dc5-08dc96c3314c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 16:07:07.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFH06vQDwLJnYJ/GWMl5LeaRflSSxB2RcPx6bLYGZoQABro/L2n+7ZQlg1tTrFWvgrI/3CaTFMOhd7ZMIe2tIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_12,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406270122
X-Proofpoint-ORIG-GUID: m2xU4hpR2yBc6Jz4IOiaTHqxOKyLwABA
X-Proofpoint-GUID: m2xU4hpR2yBc6Jz4IOiaTHqxOKyLwABA

On Thu, Jun 27, 2024 at 11:48:09AM -0400, Jeff Layton wrote:
> On Wed, 2024-06-26 at 14:24 -0400, Mike Snitzer wrote:
> > Pass the stored cl_nfssvc_net from the client to the server as
> > first argument to nfsd_open_local_fh() to ensure the proper network
> > namespace is used for localio.
> > 
> > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/Makefile    |   1 +
> >  fs/nfsd/filecache.c |   2 +-
> >  fs/nfsd/localio.c   | 246 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/nfssvc.c    |   1 +
> >  fs/nfsd/trace.h     |   3 +-
> >  fs/nfsd/vfs.h       |   9 ++
> >  6 files changed, 260 insertions(+), 2 deletions(-)
> >  create mode 100644 fs/nfsd/localio.c
> > 
> > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > index b8736a82e57c..78b421778a79 100644
> > --- a/fs/nfsd/Makefile
> > +++ b/fs/nfsd/Makefile
> > @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
> >  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
> >  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
> >  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> > +nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index ad9083ca144b..99631fa56662 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -52,7 +52,7 @@
> >  #define NFSD_FILE_CACHE_UP		     (0)
> >  
> >  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> > -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> > +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
> >  
> >  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> >  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > new file mode 100644
> > index 000000000000..ba9187735947
> > --- /dev/null
> > +++ b/fs/nfsd/localio.c
> > @@ -0,0 +1,246 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * NFS server support for local clients to bypass network stack
> > + *
> > + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> > + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > + */
> > +
> > +#include <linux/exportfs.h>
> > +#include <linux/sunrpc/svcauth_gss.h>
> > +#include <linux/sunrpc/clnt.h>
> > +#include <linux/nfs.h>
> > +#include <linux/string.h>
> > +
> > +#include "nfsd.h"
> > +#include "vfs.h"
> > +#include "netns.h"
> > +#include "filecache.h"
> > +
> > +#define NFSDDBG_FACILITY		NFSDDBG_FH
> > +
> > +/*
> > + * We need to translate between nfs status return values and
> > + * the local errno values which may not be the same.
> > + * - duplicated from fs/nfs/nfs2xdr.c to avoid needless bloat of
> > + *   all compiled nfs objects if it were in include/linux/nfs.h
> > + */
> > +static const struct {
> > +	int stat;
> > +	int errno;
> > +} nfs_common_errtbl[] = {
> > +	{ NFS_OK,		0		},
> > +	{ NFSERR_PERM,		-EPERM		},
> > +	{ NFSERR_NOENT,		-ENOENT		},
> > +	{ NFSERR_IO,		-EIO		},
> > +	{ NFSERR_NXIO,		-ENXIO		},
> > +/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> > +	{ NFSERR_ACCES,		-EACCES		},
> > +	{ NFSERR_EXIST,		-EEXIST		},
> > +	{ NFSERR_XDEV,		-EXDEV		},
> > +	{ NFSERR_NODEV,		-ENODEV		},
> > +	{ NFSERR_NOTDIR,	-ENOTDIR	},
> > +	{ NFSERR_ISDIR,		-EISDIR		},
> > +	{ NFSERR_INVAL,		-EINVAL		},
> > +	{ NFSERR_FBIG,		-EFBIG		},
> > +	{ NFSERR_NOSPC,		-ENOSPC		},
> > +	{ NFSERR_ROFS,		-EROFS		},
> > +	{ NFSERR_MLINK,		-EMLINK		},
> > +	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> > +	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> > +	{ NFSERR_DQUOT,		-EDQUOT		},
> > +	{ NFSERR_STALE,		-ESTALE		},
> > +	{ NFSERR_REMOTE,	-EREMOTE	},
> > +#ifdef EWFLUSH
> > +	{ NFSERR_WFLUSH,	-EWFLUSH	},
> > +#endif
> > +	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> > +	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> > +	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> > +	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> > +	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> > +	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> > +	{ NFSERR_BADTYPE,	-EBADTYPE	},
> > +	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> > +	{ -1,			-EIO		}
> > +};
> > +
> > +/**
> > + * nfs_stat_to_errno - convert an NFS status code to a local errno
> > + * @status: NFS status code to convert
> > + *
> > + * Returns a local errno value, or -EIO if the NFS status code is
> > + * not recognized.  nfsd_file_acquire() returns an nfsstat that
> > + * needs to be translated to an errno before being returned to a
> > + * local client application.
> > + */
> > +static int nfs_stat_to_errno(enum nfs_stat status)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; nfs_common_errtbl[i].stat != -1; i++) {
> > +		if (nfs_common_errtbl[i].stat == (int)status)
> > +			return nfs_common_errtbl[i].errno;
> > +	}
> > +	return nfs_common_errtbl[i].errno;
> > +}
> > +
> > +static void
> > +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> > +{
> > +	if (rqstp->rq_client)
> > +		auth_domain_put(rqstp->rq_client);
> > +	if (rqstp->rq_cred.cr_group_info)
> > +		put_group_info(rqstp->rq_cred.cr_group_info);
> > +	/* rpcauth_map_to_svc_cred_local() clears cr_principal */
> > +	WARN_ON_ONCE(rqstp->rq_cred.cr_principal != NULL);
> > +	kfree(rqstp->rq_xprt);
> > +	kfree(rqstp);
> > +}
> > +
> > +static struct svc_rqst *
> > +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> > +			const struct cred *cred)
> > +{
> > +	struct svc_rqst *rqstp;
> > +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > +	int status;
> > +
> > +	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */
> > +	if (unlikely(!READ_ONCE(nn->nfsd_serv))) {
> > +		dprintk("%s: localio denied. Server not running\n", __func__);
> 
> Chuck mentioned this earlier, but I don't think we ought to merge the
> dprintks. If they're useful for debugging then they should be turned
> into tracepoints. This one, I'd probably just drop.

Right; the problem with dprintk() is they can create so much chatter
that the systemd journal will automatically toss those messages and
they are lost. No diagnostic value in that.

Also you probably won't find it useful if lots of debugging info
goes into the trace log but a handful of the stuff you are
looking for is dumped into the system journal; the two use different
timestamps and so are really hard to line up after the fact.

We're trying to transition away from dprintk() in NFSD for these
reasons.


> > +		return ERR_PTR(-ENXIO);
> > +	}
> > +
> > +	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
> > +	if (!rqstp)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rqstp->rq_xprt = kzalloc(sizeof(*rqstp->rq_xprt), GFP_KERNEL);
> > +	if (!rqstp->rq_xprt) {
> > +		status = -ENOMEM;
> > +		goto out_err;
> > +	}
> > +
> > +	rqstp->rq_xprt->xpt_net = net;
> > +	__set_bit(RQ_SECURE, &rqstp->rq_flags);
> > +	rqstp->rq_proc = 1;
> > +	rqstp->rq_vers = 3;
> > +	rqstp->rq_prot = IPPROTO_TCP;
> > +	rqstp->rq_server = nn->nfsd_serv;
> > +
> > +	/* Note: we're connecting to ourself, so source addr == peer addr */
> > +	rqstp->rq_addrlen = rpc_peeraddr(rpc_clnt,
> > +			(struct sockaddr *)&rqstp->rq_addr,
> > +			sizeof(rqstp->rq_addr));
> > +
> > +	rpcauth_map_to_svc_cred_local(rpc_clnt->cl_auth, cred, &rqstp->rq_cred);
> > +
> > +	/*
> > +	 * set up enough for svcauth_unix_set_client to be able to wait
> > +	 * for the cache downcall. Note that we do _not_ want to allow the
> > +	 * request to be deferred for later revisit since this rqst and xprt
> > +	 * are not set up to run inside of the normal svc_rqst engine.
> > +	 */
> > +	INIT_LIST_HEAD(&rqstp->rq_xprt->xpt_deferred);
> > +	kref_init(&rqstp->rq_xprt->xpt_ref);
> > +	spin_lock_init(&rqstp->rq_xprt->xpt_lock);
> > +	rqstp->rq_chandle.thread_wait = 5 * HZ;
> > +
> > +	status = svcauth_unix_set_client(rqstp);
> > +	switch (status) {
> > +	case SVC_OK:
> > +		break;
> > +	case SVC_DENIED:
> > +		status = -ENXIO;
> > +		dprintk("%s: client %pISpc denied localio access\n",
> > +				__func__, (struct sockaddr *)&rqstp->rq_addr);
> > +		goto out_err;
> > +	default:
> > +		status = -ETIMEDOUT;
> > +		dprintk("%s: client %pISpc temporarily denied localio access\n",
> > +				__func__, (struct sockaddr *)&rqstp->rq_addr);
> > +		goto out_err;
> > +	}
> > +
> > +	return rqstp;
> > +
> > +out_err:
> 
> The two above can probably be turned into a single tracepoint here,
> though it might just be best to have a single tracepoint that always
> fires when this function exits.
> 
> > +	nfsd_local_fakerqst_destroy(rqstp);
> > +	return ERR_PTR(status);
> > +}
> > +
> > +/*
> > + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @file
> > + *
> > + * This function maps a local fh to a path on a local filesystem.
> > + * This is useful when the nfs client has the local server mounted - it can
> > + * avoid all the NFS overhead with reads, writes and commits.
> > + *
> > + * on successful return, caller is responsible for calling path_put. Also
> > + * note that this is called from nfs.ko via find_symbol() to avoid an explicit
> > + * dependency on knfsd. So, there is no forward declaration in a header file
> > + * for it.
> > + */
> > +int nfsd_open_local_fh(struct net *net,
> > +			 struct rpc_clnt *rpc_clnt,
> > +			 const struct cred *cred,
> > +			 const struct nfs_fh *nfs_fh,
> > +			 const fmode_t fmode,
> > +			 struct file **pfilp)
> > +{
> > +	const struct cred *save_cred;
> > +	struct svc_rqst *rqstp;
> > +	struct svc_fh fh;
> > +	struct nfsd_file *nf;
> > +	int status = 0;
> > +	int mayflags = NFSD_MAY_LOCALIO;
> > +	__be32 beres;
> > +
> > +	/* Save creds before calling into nfsd */
> > +	save_cred = get_current_cred();
> > +
> > +	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred);
> > +	if (IS_ERR(rqstp)) {
> > +		status = PTR_ERR(rqstp);
> > +		goto out_revertcred;
> > +	}
> > +
> > +	/* nfs_fh -> svc_fh */
> > +	if (nfs_fh->size > NFS4_FHSIZE) {
> > +		status = -EINVAL;
> > +		goto out;
> > +	}
> > +	fh_init(&fh, NFS4_FHSIZE);
> > +	fh.fh_handle.fh_size = nfs_fh->size;
> > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > +
> > +	if (fmode & FMODE_READ)
> > +		mayflags |= NFSD_MAY_READ;
> > +	if (fmode & FMODE_WRITE)
> > +		mayflags |= NFSD_MAY_WRITE;
> > +
> > +	beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > +	if (beres) {
> > +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> > +		dprintk("%s: fh_verify failed %d\n", __func__, status);
> 
> This should also be a tracepoint.
> 
> > +		goto out_fh_put;
> > +	}
> > +
> > +	*pfilp = get_file(nf->nf_file);
> > +
> > +	nfsd_file_put(nf);
> > +out_fh_put:
> > +	fh_put(&fh);
> > +
> > +out:
> > +	nfsd_local_fakerqst_destroy(rqstp);
> > +out_revertcred:
> > +	revert_creds(save_cred);
> > +	return status;
> > +}
> > +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> > +
> > +/* Compile time type checking, not used by anything */
> > +static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 1222a0a33fe1..a477d2c5088a 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -431,6 +431,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
> >  #endif
> >  #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> >  	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
> > +	nn->nfsd_uuid.net = net;
> >  	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
> >  #endif
> >  	nn->nfsd_net_up = true;
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 77bbd23aa150..9c0610fdd11c 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> >  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
> >  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
> >  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> > -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> > +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> > +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
> >  
> >  TRACE_EVENT(nfsd_compound,
> >  	TP_PROTO(
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index 57cd70062048..5146f0c81752 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -33,6 +33,8 @@
> >  
> >  #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
> >  
> > +#define NFSD_MAY_LOCALIO		0x2000
> > +
> >  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
> >  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
> >  
> > @@ -158,6 +160,13 @@ __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
> >  
> >  void		nfsd_filp_close(struct file *fp);
> >  
> > +int		nfsd_open_local_fh(struct net *net,
> > +				   struct rpc_clnt *rpc_clnt,
> > +				   const struct cred *cred,
> > +				   const struct nfs_fh *nfs_fh,
> > +				   const fmode_t fmode,
> > +				   struct file **pfilp);
> > +
> >  static inline int fh_want_write(struct svc_fh *fh)
> >  {
> >  	int ret;
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

