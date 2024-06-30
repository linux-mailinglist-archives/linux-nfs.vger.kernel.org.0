Return-Path: <linux-nfs+bounces-4449-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3191D49E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 00:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0298328143B
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 22:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2174079;
	Sun, 30 Jun 2024 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hQJBEOEQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WUqhD8vv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49E74047
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786887; cv=fail; b=ncmLAbD0oGjgSXHwoVeqp3UcpeUgWf1fS0R+kS70nmuZMatqHCQ3LlxrxX06AK8ueFWfXjCI9PwTCdqTqiO3Kwe/0R+Oe5g36KHMO388BuvB9yAXk9W9hRiExa+DCRhKNhGtKt4spWPkizr5skGAdEUjdR4JBpXrdC9D90MZGO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786887; c=relaxed/simple;
	bh=yjonCtWlaMPNGzyKCmdyrK+JnW6pQJ2EtEqgITKptUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Puib2L2oa4cU+rWUepZ2fSdxaLOx65uEPkz08JFoHXHPV5Cn3rq2F98HWQT461gYV+8OQg7UMZIawgdSwc4STc/YUUglIry84Zv5pBBBum57VbpJ9BlJE8j+36N1ukPRWJcXrRRu76CoHkH/4ppyjixfbYo2dmnYgv7f93nx7eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hQJBEOEQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WUqhD8vv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UKlvxg015369;
	Sun, 30 Jun 2024 22:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=KAKam5hmnrmriw8
	yC4vmMtAVpsW+HcPMTyvgOaXT7Tg=; b=hQJBEOEQGqel7NwpM9+U/Lnx0kv240/
	pgxcl9LQufYcXOZvraR3yVSdJY32Qc7GvHpZq9hkfF3vVU56agkyAZwUwCWmaypF
	Yhb8nLYnsTs7JiPBtrNwfD1zQbrOh5tBFo2EH+/dnh4HQ/Y8kK5kMEbTnfSItKRe
	9cY27zj/gpL9boN4Jpca6UGapXopSKJHGE4SWEw926AeEJRK9ngAzEDgnYskaTO3
	sBYueuEEJxafTwoSIpurS5fGhT5LMuhDvVdbmf3wN5zedKTiXdQYT5qnYx4CBITT
	6af6mGsFOtYen0jLsbPiTOf7EtHcZVSiX+2ynsWsPYC1Js22dUbqr5Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028pchk0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 22:34:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45UK5B0C022912;
	Sun, 30 Jun 2024 22:34:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q5jeje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 22:34:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQK9fMDzb1l7fljtIena35JuJzAYHoobHPDih6YJHlvTn1ddkkW3VOEOppJ5DOXvj3n+2+gi5Kj6Tb5rQAmooJRK0yiIaAZ97SD8Q5SIGneFo+X37IbmBz6ECpzOw42EOLy4KrQfW3Qv9R11EHII6BVhPVZMJydFm5WRZ1CjrJJNyFN73OP9+52siCQXvcFIlQzyWx0XqtyoNV7mYOH2CgaEpKNrdLGWVNEtNJ8Kg/Cq+h4HuBpixLfyqVyuQf9ubQzGlYmG4nN3u1YxoT4oqWtFOdf8glrtexV1DrQa6yo99eZkaqN2gZRBagSyRIJZm9oezZf3eX0W6dez4pI5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAKam5hmnrmriw8yC4vmMtAVpsW+HcPMTyvgOaXT7Tg=;
 b=kVywsLUM2QDjBz1f5vEzr002KP9qcxR2Q5bI7SRJJZOJWj76HEtXt2uXnJ5wHfzHPMnm0yvucyzdb2cDcTKoRTbjN+EB5G2tZYOzNp0m/hQa4i8NVEqr+n9r7nBQJJa4KgaorxCxI0Jx41yQ/QAYt4y6ezPSFMUrQ8q+JHF1cA+hIv3fQ+4N/duQECWh8JXuol4PE4B6USdwtJmFqanHABoXMPDFEa1fhV+chJZ2fZYc6xRU/8ztLgKvf5pL7nrxNXH9JbPTwO2BimpuB4aXjKLnALZG0G9m5fjiLTBT3oOhDLeYOwyrGwob91cuLjSYk5j4mrCDrUQW9XPHlCGJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAKam5hmnrmriw8yC4vmMtAVpsW+HcPMTyvgOaXT7Tg=;
 b=WUqhD8vvi2I0mYj7MLfNz5RKBA/5XRU6mEH7UWpOGlVL63MMWGhEui/u0ZJxsYRuYOgvo57xS+Uf4bymv4jMaNXK01m9LND2fzc0fxMCYSycBLm6Gi6MmzLVdTy36wAX+xBp4f3WEe/S4gJMQ4VfZl9MD/WZKWCvuUaRBRPlP5w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 22:34:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 22:34:30 +0000
Date: Sun, 30 Jun 2024 18:34:27 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v9 13/19] nfsd: add "localio" support
Message-ID: <ZoHdc7rQZSuTj17Z@tissot.1015granger.net>
References: <>
 <ZoCIQjxougYwplsp@tissot.1015granger.net>
 <171978617639.16071.17212237728640634496@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171978617639.16071.17212237728640634496@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:610:4e::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 580a6cbf-67f1-4d77-2533-08dc9954cef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?x/PFPhXYfVIvOANDO9AsXfv9PW2DsyHt31VXk43OvQMLyKMdsbHMXUSwAFGW?=
 =?us-ascii?Q?In7/2Hli1iy7emH4M5+en4fAgZiEOl2Mru2zAfNuDLbLBtVui/WmO8IKZbSi?=
 =?us-ascii?Q?MLVuAD3ma5Q8W2QFXTwTSHBYJXQKybYVe41L3VvBebYIlteVWX7Ss4d9EgVF?=
 =?us-ascii?Q?67UEHBaSJGoZSdQ36Cc+ZTwWSrE5HMo7zA7EXSn1VmUtucg1SF2/BAUfcBYm?=
 =?us-ascii?Q?OJSZlAF3tY8nCOplom8cxsT9WoPi3CW3OarhDmg4yU9e/SIJj/hY4slIvyS+?=
 =?us-ascii?Q?qCTlS2Q68bc9iOkTL3WI866qUSJfAcYZnlmDi7vCEW2KLTjnPwTFbcP63cUD?=
 =?us-ascii?Q?UX2CA8KtMZXBVvAh4b2GkPNIis5JPzdpOoDfhktP+RdT+7OetZFTao/h2Jh3?=
 =?us-ascii?Q?nNXe2Q33qWZWMlTSL/H4KsWnbX+RrDpwwyzYRsheiFoG7P71OioOOZ831Y+j?=
 =?us-ascii?Q?ekqxe/clRFdhzYlmZndCO8ppzlimbOFsD2FR7GaR8js2zC83FrVf5k6QILM+?=
 =?us-ascii?Q?Pd5q9lqaocG6652f9JoW9RFQ3+6pQhmRZdCd/SXcWacgz6PM+A5+JJZYXNuM?=
 =?us-ascii?Q?8iM7awjLausEWUTQmEBshLXzo0fj1QEjdPSaxILSURUjCgVtMvPBJjqnt3cs?=
 =?us-ascii?Q?z79XTaWO688lpk438c6ATUHjGH7UgNPnW/IE8CZBZzS0nf4hZ2pAP739TmbF?=
 =?us-ascii?Q?HH326LOJmOBbV2SmBdzRg757YwH3GEEXo6J8iTh7p3pbn7lbJ+xdVqYzETVJ?=
 =?us-ascii?Q?NHGH9m7lX2JTlgHS2yEj+aXg2YrE0UwD6ANGHaz70h8YLdrrFbj0PQddXqcf?=
 =?us-ascii?Q?MEYgxyaIqCQbrav3NDZ6Wgrprbuh6i4hxglFyS5OcBNp0IIFpguxkl/flvfI?=
 =?us-ascii?Q?WpvISxOL3dJC0AcWHZxhQe5zwedMN+vbVK3mABhiBxRasGFL0Vpn4xFsyAh3?=
 =?us-ascii?Q?e7ZfCtDQteLvMy4jOo08SnghjRxeMGUVxLc++KFmunfJURf8GFVhx6esrvv8?=
 =?us-ascii?Q?7zNMmle4QiGwbwG1jhquF7szN5aVBmof/473V8FYXu/IPLLEKqMXmlMIP+gz?=
 =?us-ascii?Q?Upme10apOlT3okYeo/n0z9Io/5Ty2TcFPkNSwdppSYyBSOORGVotDGQ+GX8Y?=
 =?us-ascii?Q?79xPVDRk71vZG1xan68gype2GtYJz8llTMZ+mNJLn8H98CBttvgY7gpK6xXV?=
 =?us-ascii?Q?DfuUvquRbxKPM8zZRa/fTdQApU8+t+6+GpHAaLpsg271QWFhuXjANSsMeLEu?=
 =?us-ascii?Q?b4Djo264zxtaf1HpOv0U8TkytxKGvR2iZoWESpFp2I6X3Np8AUKwULMnDoWH?=
 =?us-ascii?Q?IK9xwEJ/MXxRiZNLr3OCUCdqW2iFcb9s5UG0JM2DnWTmdg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jLfbEFKDj1kNw3peR9CDI08dV82pEIJB58JZiekToQqpZLMMpO53wSyHQO+X?=
 =?us-ascii?Q?SLnpJ1lTtK4sy4wt4ga4bmEM7GfocL0nXmzscgPhUmfjYjg1PQTYgFt6gXBo?=
 =?us-ascii?Q?xF2amnj3yTl03R3ibaFSrWl+RzlXQc0LuLGWg2qNOIzbiir3nEDZZBHSByXu?=
 =?us-ascii?Q?R1+bCDr8F6jxjFdALRzXUeDPFSUq+C1Pz/JZyZA9jCn792U7U40VHGqi0k2n?=
 =?us-ascii?Q?FExK+HsF8VXRdWrhB3PgiBBAQomwXVTp65Oj4VcQ0DZfnmhW/YNcPqxuyKHs?=
 =?us-ascii?Q?Hcp2mxZ9vI197ltiWoFdwsds9OMc7idW0Fd1CzX5tyoU8mOkZGaw2Mf7NN74?=
 =?us-ascii?Q?1usiIlS8+V3RskrkNPyQafhIRK4FY02vmweWWUJ36k9IhSe8mFot+xOrwfr+?=
 =?us-ascii?Q?h0ClqWINZxT6x7GmNYMequtnaAS4cNAXlhmqndmINFNw1Z+ZXhS7WP3yrVnp?=
 =?us-ascii?Q?tnMlak59ylX8+15dCzmfHeJJAQWZXbDUhytlcwS1IPlJvGsMDAOZ6ZvLHhhE?=
 =?us-ascii?Q?gPgBonYiVs8fjD9tlpaY9rKtg6i8xmSbFMAfxlgbY9geAque47wAaXGC4T0B?=
 =?us-ascii?Q?/TX163RmngcUK7nOjFX0c/43s2DCN6puMtYSDgexo/wiGrGd8oVAIfhhGs5b?=
 =?us-ascii?Q?6lXEaxS68l9zDXU5pKvzK2wa1U3wvuhayBBX3eV8AUYLYiM7PTMLKSoYKjDE?=
 =?us-ascii?Q?brfUPd2dKn6bMmPubbCOr00jQpksVefH9NT238WcqYr8ijeYZSfb2CEs82tm?=
 =?us-ascii?Q?At6jknV3lrZjyAeAIttq+k6vnGjZbE8gYmUa966atDNNluPXe0qDnAksuCm3?=
 =?us-ascii?Q?0v67Uq6yuUJihhmBfv+TWKwJSEQgLTkyXkwp8uzijfxJl7UAadvRzDMX2lzV?=
 =?us-ascii?Q?IXGxXU4uXJUK1HuGhnMkfIMscACAffmDPw20ZZEl6XxGguI+WCgbmnfJxB1a?=
 =?us-ascii?Q?/6HUE6QGXbHbj7xLsfBDfo7pos2Qasgcn6IlHz+jnbmAhjGifGc3ayGYNUvB?=
 =?us-ascii?Q?djzLT6L6B21JW0qAdBeg2PrheYqHDFNP6+wd+EcS+fI8uuHPOounZKNWiQbD?=
 =?us-ascii?Q?i14VOP77DobsqBhxyoo8HBb9G1Ebc0JnQeBIJOGoy0+8cPkd8kODclvYU3Zn?=
 =?us-ascii?Q?0FV8hOtJ9IR5bjiilAMAM8Zx9QKC1ajMwnYBSINrt1EwTte5ahUNzzWFeTZn?=
 =?us-ascii?Q?bBbtiawdWPnBoNbbjFNmEAi44g5UA+5gPq4QR+3xLzCtdpwBhYXaJeBKIBMU?=
 =?us-ascii?Q?HTxS4AUguORUNRNaV3NR1XIi7NOeWv+L4QjyIoQTfDTxzj3LdeR+4G5e6RQN?=
 =?us-ascii?Q?2F41I02QI2kXY5nVbRGx7xvakV5tcCjxWbpn/wpX0nneYBrqFS6wQxFzQMzB?=
 =?us-ascii?Q?/M/VHci1utDulPT8SzDOkMUhD2GIWKK5w3yOSFnarP1HBFC35SDLnTy7tvlP?=
 =?us-ascii?Q?Icr1+7ARm11mVVsV5qie0+g9Fg+pI1rV0ExxVft5uZNUbkSwk/D9qo8nMeCH?=
 =?us-ascii?Q?I7uTqLGaz+/hovlk3e/OrTTZ4A8/rYovDrJRbOEzLX7o6z8IzkMII7QcaZ7+?=
 =?us-ascii?Q?y8pEEi3rGGXU96RteGFLvJDN9lTrMmqlB/1IBkzN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FYSGfYSDUe7528+rgmKLu90SfycpshND1nc7HnGZwpskFXAZP6wdn0rgvOEnLv0OeByHjfCWasN9v2t6DcqpjFpse0XlnpFxo0aTtzWx3ED+yerGWwlIYunbAtwc4PGXSUsXivOn1i1WRgCkNzomb0Tk/iMRZfm6/HQUIhsUqJz3pK6+s4BapP+Ub/bAsD6UvkxyOIJud38yO7D8eySNTktAF4KjHtJpaB0UK71FuAhtciPVBiLrGJzYmLSncvh6ESBKKi2YfrwYzjQvWqu2lNUwmEbLIOPHsAmyKIM1SEZwcy2KG3n+HMJdVBrGj35sGK7BzTIOWUtqKJQLT7Kkg6yklqIaPlIcrt9E6InQ7aewOWWtDYbBtAYvkQn3bq9xk1zFrtoy52HeaZkQnIRylXBed2mFr1y63ssvghWUenxXGzVAGximTfwy+uRHWXPQJ/dJYOvPYgGFhQvjiz2nPEWYr86hhmDdtwxGnkf4AAq10uNO6KWmbxvKyBZFemoxN9U+Ke/lvZj/CP/8TP/wKjEo+iq6GmtVhPKgAHrHl2JjBVC7yK3n8c1l2JJXYQvZ1cC3M+3vDZa9UJI/7SP2sFHg1VJZ9FXgqUCd0oE0sZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580a6cbf-67f1-4d77-2533-08dc9954cef3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 22:34:30.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQXUiQBuMiO3FneXH6gffRFtFAxjpR3mVRgkrHiu+c9of5A7fY8zI2ZUQd0Ht6XpD0uzakKUQPWImuBlS3xJHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406300182
X-Proofpoint-GUID: P9N8OUg0dAe8vgjYKqYbsSlmf_MSDuGt
X-Proofpoint-ORIG-GUID: P9N8OUg0dAe8vgjYKqYbsSlmf_MSDuGt

On Mon, Jul 01, 2024 at 08:22:56AM +1000, NeilBrown wrote:
> On Sun, 30 Jun 2024, Chuck Lever wrote:
> > Sorry, I guess I expected to have more time to learn about these
> > patches before writing review comments. But if you want them to go
> > in soon, I had better look more closely at them now.
> > 
> > 
> > On Fri, Jun 28, 2024 at 05:10:59PM -0400, Mike Snitzer wrote:
> > > Pass the stored cl_nfssvc_net from the client to the server as
> > 
> > This is the only mention of cl_nfssvc_net I can find in this
> > patch. I'm not sure what it is. Patch description should maybe
> > provide some context.
> > 
> > 
> > > first argument to nfsd_open_local_fh() to ensure the proper network
> > > namespace is used for localio.
> > 
> > Can the patch description say something about the distinct mount 
> > namespaces -- if the local application is running in a different
> > container than the NFS server, are we using only the network
> > namespaces for authorizing the file access? And is that OK to do?
> > If yes, patch description should explain that NFS local I/O ignores
> > the boundaries of mount namespaces and why that is OK to do.
> > 
> > 
> > > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > > Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> > > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfsd/Makefile    |   1 +
> > >  fs/nfsd/filecache.c |   2 +-
> > >  fs/nfsd/localio.c   | 239 ++++++++++++++++++++++++++++++++++++++++++++
> > >  fs/nfsd/nfssvc.c    |   1 +
> > >  fs/nfsd/trace.h     |   3 +-
> > >  fs/nfsd/vfs.h       |   9 ++
> > >  6 files changed, 253 insertions(+), 2 deletions(-)
> > >  create mode 100644 fs/nfsd/localio.c
> > > 
> > > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > > index b8736a82e57c..78b421778a79 100644
> > > --- a/fs/nfsd/Makefile
> > > +++ b/fs/nfsd/Makefile
> > > @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
> > >  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
> > >  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
> > >  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> > > +nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index ad9083ca144b..99631fa56662 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -52,7 +52,7 @@
> > >  #define NFSD_FILE_CACHE_UP		     (0)
> > >  
> > >  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> > > -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> > > +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
> > >  
> > >  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> > >  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > new file mode 100644
> > > index 000000000000..759a5cb79652
> > > --- /dev/null
> > > +++ b/fs/nfsd/localio.c
> > > @@ -0,0 +1,239 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * NFS server support for local clients to bypass network stack
> > > + *
> > > + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> > > + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> > > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > > + */
> > > +
> > > +#include <linux/exportfs.h>
> > > +#include <linux/sunrpc/svcauth_gss.h>
> > > +#include <linux/sunrpc/clnt.h>
> > > +#include <linux/nfs.h>
> > > +#include <linux/string.h>
> > > +
> > > +#include "nfsd.h"
> > > +#include "vfs.h"
> > > +#include "netns.h"
> > > +#include "filecache.h"
> > > +
> > > +#define NFSDDBG_FACILITY		NFSDDBG_FH
> > 
> > With no more dprintk() call sites in this patch, you no longer need
> > this macro definition.
> > 
> > 
> > > +/*
> > > + * We need to translate between nfs status return values and
> > > + * the local errno values which may not be the same.
> > > + * - duplicated from fs/nfs/nfs2xdr.c to avoid needless bloat of
> > > + *   all compiled nfs objects if it were in include/linux/nfs.h
> > > + */
> > > +static const struct {
> > > +	int stat;
> > > +	int errno;
> > > +} nfs_common_errtbl[] = {
> > > +	{ NFS_OK,		0		},
> > > +	{ NFSERR_PERM,		-EPERM		},
> > > +	{ NFSERR_NOENT,		-ENOENT		},
> > > +	{ NFSERR_IO,		-EIO		},
> > > +	{ NFSERR_NXIO,		-ENXIO		},
> > > +/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> > > +	{ NFSERR_ACCES,		-EACCES		},
> > > +	{ NFSERR_EXIST,		-EEXIST		},
> > > +	{ NFSERR_XDEV,		-EXDEV		},
> > > +	{ NFSERR_NODEV,		-ENODEV		},
> > > +	{ NFSERR_NOTDIR,	-ENOTDIR	},
> > > +	{ NFSERR_ISDIR,		-EISDIR		},
> > > +	{ NFSERR_INVAL,		-EINVAL		},
> > > +	{ NFSERR_FBIG,		-EFBIG		},
> > > +	{ NFSERR_NOSPC,		-ENOSPC		},
> > > +	{ NFSERR_ROFS,		-EROFS		},
> > > +	{ NFSERR_MLINK,		-EMLINK		},
> > > +	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> > > +	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> > > +	{ NFSERR_DQUOT,		-EDQUOT		},
> > > +	{ NFSERR_STALE,		-ESTALE		},
> > > +	{ NFSERR_REMOTE,	-EREMOTE	},
> > > +#ifdef EWFLUSH
> > > +	{ NFSERR_WFLUSH,	-EWFLUSH	},
> > > +#endif
> > > +	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> > > +	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> > > +	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> > > +	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> > > +	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> > > +	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> > > +	{ NFSERR_BADTYPE,	-EBADTYPE	},
> > > +	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> > > +	{ -1,			-EIO		}
> > > +};
> > > +
> > > +/**
> > > + * nfs_stat_to_errno - convert an NFS status code to a local errno
> > > + * @status: NFS status code to convert
> > > + *
> > > + * Returns a local errno value, or -EIO if the NFS status code is
> > > + * not recognized.  nfsd_file_acquire() returns an nfsstat that
> > > + * needs to be translated to an errno before being returned to a
> > > + * local client application.
> > > + */
> > > +static int nfs_stat_to_errno(enum nfs_stat status)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; nfs_common_errtbl[i].stat != -1; i++) {
> > > +		if (nfs_common_errtbl[i].stat == (int)status)
> > > +			return nfs_common_errtbl[i].errno;
> > > +	}
> > > +	return nfs_common_errtbl[i].errno;
> > > +}
> > > +
> > > +static void
> > > +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> > > +{
> > > +	if (rqstp->rq_client)
> > > +		auth_domain_put(rqstp->rq_client);
> > > +	if (rqstp->rq_cred.cr_group_info)
> > > +		put_group_info(rqstp->rq_cred.cr_group_info);
> > > +	/* rpcauth_map_to_svc_cred_local() clears cr_principal */
> > > +	WARN_ON_ONCE(rqstp->rq_cred.cr_principal != NULL);
> > > +	kfree(rqstp->rq_xprt);
> > > +	kfree(rqstp);
> > > +}
> > > +
> > > +static struct svc_rqst *
> > > +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> > > +			const struct cred *cred)
> > > +{
> > > +	struct svc_rqst *rqstp;
> > > +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > > +	int status;
> > > +
> > > +	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */
> > > +	if (unlikely(!READ_ONCE(nn->nfsd_serv)))
> > > +		return ERR_PTR(-ENXIO);
> > > +
> > > +	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
> > > +	if (!rqstp)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	rqstp->rq_xprt = kzalloc(sizeof(*rqstp->rq_xprt), GFP_KERNEL);
> > > +	if (!rqstp->rq_xprt) {
> > > +		status = -ENOMEM;
> > > +		goto out_err;
> > > +	}
> > 
> > struct svc_rqst is pretty big (like, bigger than a couple of pages).
> > What happens if this allocation fails?
> > 
> > And how often does it occur -- does that add significant overhead?
> > 
> > 
> > > +
> > > +	rqstp->rq_xprt->xpt_net = net;
> > > +	__set_bit(RQ_SECURE, &rqstp->rq_flags);
> > > +	rqstp->rq_proc = 1;
> > > +	rqstp->rq_vers = 3;
> > 
> > IMO these need to be symbolic constants, not integers. Or, at least
> > there needs to be some documenting comments that explain these are
> > fake and why that's OK to do. Or, are there better choices?
> > 
> > 
> > > +	rqstp->rq_prot = IPPROTO_TCP;
> > > +	rqstp->rq_server = nn->nfsd_serv;
> > > +
> > > +	/* Note: we're connecting to ourself, so source addr == peer addr */
> > > +	rqstp->rq_addrlen = rpc_peeraddr(rpc_clnt,
> > > +			(struct sockaddr *)&rqstp->rq_addr,
> > > +			sizeof(rqstp->rq_addr));
> > > +
> > > +	rpcauth_map_to_svc_cred_local(rpc_clnt->cl_auth, cred, &rqstp->rq_cred);
> > > +
> > > +	/*
> > > +	 * set up enough for svcauth_unix_set_client to be able to wait
> > > +	 * for the cache downcall. Note that we do _not_ want to allow the
> > > +	 * request to be deferred for later revisit since this rqst and xprt
> > > +	 * are not set up to run inside of the normal svc_rqst engine.
> > > +	 */
> > > +	INIT_LIST_HEAD(&rqstp->rq_xprt->xpt_deferred);
> > > +	kref_init(&rqstp->rq_xprt->xpt_ref);
> > > +	spin_lock_init(&rqstp->rq_xprt->xpt_lock);
> > > +	rqstp->rq_chandle.thread_wait = 5 * HZ;
> > > +
> > > +	status = svcauth_unix_set_client(rqstp);
> > > +	switch (status) {
> > > +	case SVC_OK:
> > > +		break;
> > > +	case SVC_DENIED:
> > > +		status = -ENXIO;
> > > +		goto out_err;
> > > +	default:
> > > +		status = -ETIMEDOUT;
> > > +		goto out_err;
> > > +	}
> > 
> > Interesting. Why would svcauth_unix_set_client fail for a local I/O
> > request? Wouldn't it only be because the local application is trying
> > to open a file it doesn't have permission to?
> > 
> 
> I'm beginning to think this section of code is the of the sort where you
> need to be twice as clever when debugging as you where when writing.  It
> is trying to get the client to use interfaces written for server-side
> actions, and it isn't a good fit.
> 
> I think that instead we should modify fh_verify() so that it takes
> explicit net, rq_vers, rq_cred, rq_client as well as the rqstp, and
> the localio client passes in a NULL rqstp.

Nit: I'd rather provide a new fh_verify-like API -- changing the
synopsis of fh_verify() itself will result in a lot of code churn
for only a single call site.


> Getting the rq_client is an interesting challenge.
> The above code (if I'm reading it correctly) gets the server-side
> address of the IP connection, and passes that through to the sunrpc code
> as though it is the client address.  So as long as the server is
> exporting to itself, and as long as no address translation is happening
> on the path, this works.  It feels messy though - and fragile.
> 
> I would rather we had some rq_client (struct auth_domain) that was
> dedicated to localio.  The client should be able to access it based on
> the fact that it could rather the server UUID using the LOCALIO RPC
> protocol.
> 
> I'm not sure what exactly this would look like, but the 
> 'struct auth_domain *' should be something that can be accessed
> directly, not looked up in a cache.

I'd like to mitigate the possibility of having to wait for a
possible cache upcall, and reduce or remove the need for a phony
svc_rqst. It sounds like you are on that path.

Further, this needs to be clearly documented -- it's bypassing
(or perhaps augmenting) the export's usual IP address-based
authorization mechanism, so there are security considerations.


> I can try to knock up a patch to allow fh_verify (and nfsd_file_acquire)
> without an rqstp.  I won't try the auth_domain change until I hear what
> others think.

-- 
Chuck Lever

