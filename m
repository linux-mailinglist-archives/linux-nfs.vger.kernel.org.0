Return-Path: <linux-nfs+bounces-4033-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B2590DEAA
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 23:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA364B209FF
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE39215EFBD;
	Tue, 18 Jun 2024 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bjqhplTL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yJCBr/Bi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DC482DA
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747200; cv=fail; b=u2Qp6LVbVlZ2RMwlI/7uhFE7+LGNoVHpZiY3PqQRps79zygxSUcfkAeAoFncRyXFEPxP0gzA48jS4U0lwPK4q8sLC9QbLznD93VLdtC2m6F4kC91rChqqMcPGJLNl65wWPlPgHNLk/7rtSLL3y5QSuYidcal3GLC+7UDRolgEQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747200; c=relaxed/simple;
	bh=aUIl/RSSV6vmtSHFNs0KYEqYtKFDJC+C+pskow+C1Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSL1OJh2BNetrAwFfu9H7eIEH3CFWXLJ3XxpVXMz4KZPdStMZOgaWGV8VGfqpeLM+WJEQuZPOKDg37n1MYq3F1u00cZ4ICUmnXiEevRGAqxgcUINkFUBUhMQH/vuAJ3L770YXSP8Ld52O7CCCKEmvZWXKzugW895IhZdebS1Xto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bjqhplTL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yJCBr/Bi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILZoRT014082;
	Tue, 18 Jun 2024 21:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=SSQt4xZlHSTdIb+
	+A+PnLJeCwqgb+wh2/n5ip/V64gg=; b=bjqhplTLOflRdVaI1c3w86/JJvDGb34
	HCDeQz7cfpyOAlgsiRDjpQ3834gvSGNjggblg/5/ugodBWpRPi2s+Ke9c1YbRMXZ
	IcNmXpKGZIgN83Sep2GyR5z6TvAPLmiunSJ0yaR5o2w9PqWKz6n7IGFHcCcseWBo
	oiF99/3691SsCH8p8TSLIBnEMOSELXOeW4GG99q7sLNIM18FvIy0fImQQOzrmM+7
	kLCFMm5NgPxERxDW4Q049Z2Mqk+lms7kyZQ+SKvOCplmdKHUnhp7xzhkTFNMfIlR
	AJAP4/OmP5+a3dWkwCXabfBCn3U+VR0PYaKWM/L9oJOB+AmgOC2vjWw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9r00cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 21:46:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IKT8CF034602;
	Tue, 18 Jun 2024 21:46:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1df12r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 21:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7hs46R/Xl8dYNzYF9+QIellsWmQixAfuY3LfDCsPON8Ry7cVhBgooGmnMNM6AuBjHRmkJgt6o0pRCpk3WwztUyg8D4hpd/h3lMM1ucCrn+EsBvmk4m7ovK3iNXXIdnGQHQ43RPQj6OnXQM1UOkL4zIO5SsOvCreg8FAu/JDfnr+8NOuAILmMEcyhP/OiTSKuubc1Dx0sr5uBROqDwr/p+GyyzaEBrlZ0woRhikYIrZncdNZc68pk2Z+9X1eKwg4lnYSjsRlTn8RlpuoQYK7eDX3KbySOtUa1pSl+l+9puyJesYiQLuLzyQ2ZZyppMYcvPfIVr3omL4mgALGV4H09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSQt4xZlHSTdIb++A+PnLJeCwqgb+wh2/n5ip/V64gg=;
 b=SVH0rESzb3RZYV1msoKYZTdYdpDGKk1no3JDjJIJQxBmm2krfRZoziA3WMB3KnkVdK9zMg4Lx8W51oFnfEkqB5EKkR7ricXymNn9rpCloZIgnZLD5OQpw1OJmg3G4OVF1f9wBt3/gHHUJn3NuUajomz7bGiKjRgoMJKTBwCnRyWJzA61Ml5EIYXqtUNBYzwZ23Tw1YQOqNTIKdo//DeeMhPsvv04GfPMdSIJqQKurZRorcWuBUJg86LIWrV9QFGrKmUqYXYirJAJYKqck8I3pnoAvk0PlFOm9M6a0wowA4kGf4UoZ6Ji6jl8cHAmbr/YFuoIptKctd8GMDmi7O70aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSQt4xZlHSTdIb++A+PnLJeCwqgb+wh2/n5ip/V64gg=;
 b=yJCBr/Bi49AU3Fze7cecHmV4waa4kyOAKCq1IkEyryeaJlFox89XOdScaVcTN461r1KSONY6bvuVQ0naUgaSWQRIPTLSFYTVl7LJ69oRWzLrrZiDTzPHGfshQE4dm+jTd8sYnLxf7bttHbYtBt63syLUw2bMEax7yUvajcFkL1s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4327.namprd10.prod.outlook.com (2603:10b6:610:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32; Tue, 18 Jun
 2024 21:46:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 21:46:27 +0000
Date: Tue, 18 Jun 2024 17:46:24 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v5 19/19] nfs: add
 Documentation/filesystems/nfs/localio.rst
Message-ID: <ZnIAMJ0wqjcTBszm@tissot.1015granger.net>
References: <20240618201949.81977-1-snitzer@kernel.org>
 <20240618201949.81977-20-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618201949.81977-20-snitzer@kernel.org>
X-ClientProxiedBy: CH2PR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:610:5b::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3eebaf-ce00-4071-7e6d-08dc8fe01b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KuC7xNaN5DQ4qZ1i1BBMFh2qAMLGsijwG3W748z+YXjDdo7/0T3vmCQTsjua?=
 =?us-ascii?Q?X8nlg53EFFvixfw+znwokX8aUTyZckGsVaDEf25D2aHuHmueOkO/WhAKbeQw?=
 =?us-ascii?Q?9O1fOk3uWC6lOcll9NdJi+ImneGolETjQuV8zFpHuvZzGfcrScusmBwPE0IO?=
 =?us-ascii?Q?seV4A9KjGfQjwa14OkWNR6h01QTQSzTSkvJcQxKA43i5oXl9X02dNqYj4Ka9?=
 =?us-ascii?Q?1Fog7t1RUpdyMYm4WgfhVOZkpvsrNRmxz8PixoN+PgKVy9WEb2waxTDhHkKp?=
 =?us-ascii?Q?I9dvgQx3ePMrJilG/qQ1lLhf7ZqsRX3uo+Cz/VI86OOJscHmOX66Nv27SzB0?=
 =?us-ascii?Q?C5gIXwIP4Kl6SYTJ+D9hi41uxcrBoppNfTHDXXxA0LI0HCPQDmQazOPLD6Z5?=
 =?us-ascii?Q?YFUnQChUgIjX1xS8rb+A57meolsks2qSSR/sccMj2MsN3z0VP79Q+4cScZ0+?=
 =?us-ascii?Q?HxNn0DDNwBoqz93yWX3UOq64kiAQqqbO9juqbUxC3sUwgfSeRPNy/oJ4aWoD?=
 =?us-ascii?Q?Z6f84PBGhvKZ67+rubOQfhHt8XXJXlab+73T8Yq2AgWOWBgCx/cJYIpsarhG?=
 =?us-ascii?Q?QjGTlke0Tl5ZOcggx2Hv9CW2yVkN+u9eEqmsY34U6kgZJhoKJN/+Rz89n9Sa?=
 =?us-ascii?Q?EdqQjYf7KKruJkyHs/Df4dHkEW/0+w1izA5oDndKSTjPjOXh+zjYa3ygbD/t?=
 =?us-ascii?Q?opaB+gnnouZ0tqZZgunV2y8i9P+B814+ZXmrGA1TYyAtAoBi9BCb7BS1xeS1?=
 =?us-ascii?Q?D4FudMeTsuwarRYXDEUTfJEQ2Wt3L9mAuhC9oDCmuXXmQA5s0YC6wFFGND0u?=
 =?us-ascii?Q?FVr5CjVMMMeIWMT0uYXUFU1KToR1GMMRT6jNwxQm7afuavl7OcnYZZK1HIux?=
 =?us-ascii?Q?FTVWlaGM/0HxHUZIDFv+Cen2kuHyVPcBgOkmHKB+HtjDtQzNCMBewmnWAzck?=
 =?us-ascii?Q?CggornXpL9Le2KEnpH0EWU13WrJ6SSkrtzjQEgOcNXOkaiob0hVGLAmRTxod?=
 =?us-ascii?Q?c9EipkQlUPxWe3bU7OnnlmiJcWeE+2j7FvsOjf3St59DzjxfiqgThL1bg9/B?=
 =?us-ascii?Q?qz/IEZknJbUkftTg6lsGJ+IXmiy7ZRa29fu1UGmPO0JNQzX920RzoKTjOnAe?=
 =?us-ascii?Q?0GMQsV7O6xNqIokw3zQ2VdjIV+/o8R/BsfIDr/r6cJw/Z9Vd5L4iCoXBbKaB?=
 =?us-ascii?Q?C8y4l+dA5hLqnTTaBeGvIe5L/pw5RlIhOSPWGeo96IKY/E/1LJ1vSKAQgKGx?=
 =?us-ascii?Q?vFSNba1zg0bujDS2sowQFTUYufl/GT9vQV131VO/5X62xm0fXuX+08Iys+SN?=
 =?us-ascii?Q?UxoYqtFw60A1hxaBzJCWaXNS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I1BKeUxt/AahlJJ939SblphFwfryckEAZyju7ZOkw4Auc6BxO/DW3tjipwJc?=
 =?us-ascii?Q?LF7geKVDPu0zLDlsNB/JqSV5p86Tc+pxNAuC6Yx22GiDguqGne86XTtfaS8U?=
 =?us-ascii?Q?vuwSujQqWm/D8dJkUKgPcR92ziq3+/TiopJGoorLl7oLi96OZguWsRzJhgNt?=
 =?us-ascii?Q?wK7Azmp/UNtvqsqDGOGxocHUTLlxJZxdxBZV35WEm5r85/n9JNHH7qod7g22?=
 =?us-ascii?Q?yQSGGaoBDg8LpCFsTAdO0CwfRIwbxx6qY7J7ujoEye/DQw66HXvk/5Yh1O81?=
 =?us-ascii?Q?weBjuWhmKVIlTo77DHLPs0GAh+QaTyYmzVvAegZjz6ZICSypxNckm4g4iDh+?=
 =?us-ascii?Q?YOZ3cWxsrTjZXqvR9WdxgqBgXNb4g/NlkheoTO5SO5s3ca8Rljj1G/kV+xKW?=
 =?us-ascii?Q?S4Qg5dETw/7AxINIpZOokkf0XAW3RlJuPJOSF/5hTA4E4zC9wauKfgZIHxg1?=
 =?us-ascii?Q?13R8LgdasMhOkqYt67TDcd6lOBRsrxVSMrZm0YSP/aQFiiENkRW/tIC7O5pk?=
 =?us-ascii?Q?s2uwfo5N9Tdl1Fyx/SbnKfhR3n3IKz0jvoChFs3qDq5U6vARWW4ZPNI9ny6B?=
 =?us-ascii?Q?JMmLxB0gdUT4701nz3jNviyehhKaN/3yBZgL1dm8WhMtCGVwgLwR8zPR94iO?=
 =?us-ascii?Q?5gGryPbnRmjTwi9cXITTLtm5gfVjpWBXIwWRF5VNP/cu8kQbsDMd7+rQpo41?=
 =?us-ascii?Q?AZeu71bUFXFVWNk/w4gv4dtv8gK6BCxx+PoF/LobtmNGDBp6maz8fExxGCfk?=
 =?us-ascii?Q?amC9J90z8kZzIS+LKKaO4tNQZde2FestmoL3VIYgkwuI4vgDm5U3669KxFwV?=
 =?us-ascii?Q?2C8A0pFN9euTUAN6da8rmxv22x651nL5wFl8bFul/zDXgOj5lqhdlChaZ+r/?=
 =?us-ascii?Q?eSYTElywVDtvxBEPQuYVkhqVOPhX9eWEexK24CpttUSDkHYm9IEPCGcGb7tE?=
 =?us-ascii?Q?cr5MUjag4FyXXvMpMsyAJ9+2bUh9p14S6dKLKubm5cSgkYbDQfbmldmyGgNY?=
 =?us-ascii?Q?BEcx+HTOwBQFZibZqXqXxqGUP2taFYz1+S2TD7yIEMd0q9t9YqQ7t/D+wTHf?=
 =?us-ascii?Q?6xnj3GLjMD2p8FrQfiLG0AiLTVXiAgcVY9rAC5gmoFKEOd0kvqBf6JWEo+dM?=
 =?us-ascii?Q?dfqqT/91S4xALTqeOJCra+HpgOcEKwMxAJuRffvkjyeCzqTfEi85uc0HT0fa?=
 =?us-ascii?Q?sAT4r6ZahI4u0QkR07gTZH6chghCxsAp1JhDuv+VQc+sNH9Lgf+oUOHmYdXO?=
 =?us-ascii?Q?N80QthvX7FwWJrUR5Xw5n7vvk0DqpJTZR3Wc1gcBQ4tGJXOeU/TCvy47KJwN?=
 =?us-ascii?Q?/wKQPXKEfkyGIkaJigZSfbWl3z9YnwWhXpsyEQQi9+1VFeltNvzl9G8r9qch?=
 =?us-ascii?Q?Ui//Dj/0UXdLGKVuR7+Jm4VTg5cBjs+Ye71KEFe/MTEJkcC/Yz87wDXLnSAv?=
 =?us-ascii?Q?QYQrnNWiSbyytq1AqAMrFPAwEn9shGFVMvCJSb+YZP+/7ozRmxbgv7leaK+p?=
 =?us-ascii?Q?naJSEQV1rSQAlBjARM2ORLofP8o8dLXNKfOqYuS8bnrzARtC+Sv0qBY/T0oU?=
 =?us-ascii?Q?uryPmWphwALbZLMujU1Uu+3QAdZODOYA7IJke1+jxcSOfy2CcIvI1huze+17?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	P0vjVcEchyIJ8t/LOk+v2tAVLtMBSFrCjmbY8ELY8kg3vuyhfAB/EUP9uicrsw9SWpY+PBBUabOD8JaZf4PBEfCb0bCG05Nn//xd0jo8GP0ASxP7XpSpC2Q4YsaP1B4fqIwh3GX4CRZLGEzsFnb/oMEVptODhWgk7p8unGa15IVPtn8KQXeoaWJ6Ki0lAahXh82PsvaHTg/j89NeFMLiWPwlVECZDtkpR2BfVPtEAur4+vo/JcZH/B54A29+kcRBN5YOJx4UdLs4Zih5Dc/NqR6sDpTJ8DEG9+la7QmyyCykPunh5jAk3/I987RIdVVh3M/zcJa64ktEkM0N4XNVT845a5QvSJxm6yCovv/O+M2VB8Ckbq/wxRGfl4fTykiLVfyHbOtRiLiwXqth66F28lLAGWy9XJOzKtPwJQa0ZhDZ49IZ7vrW69WcDQlRDLlZdM6I/i/J9ikolC2EEuwM2pgkP4Qi1m14w9JrxScBohp3WLd8/ucOrrQiRyMhImlbpQHRAifEnaSnNxIg+LMPQk5pXlklIiOFxvEZaxCeYDPZaeT6z/OeNj0ZSGjRrl++Sm1myC3ecv6xJjmbjZYYRaHfxHerPdl7TKb2gWCbtOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3eebaf-ce00-4071-7e6d-08dc8fe01b80
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:46:27.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YAIRmyyr4HUABmBWXuMJkPu5hPPl5QAruHDQUiJdQhXbAxKPFt3/Tsj4z4Zs72cFJsCiy8EfNBMMhR3avtpYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=877 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180159
X-Proofpoint-GUID: ajG61Nyhv3ne09hq-3tmJtYeTdsQZ46B
X-Proofpoint-ORIG-GUID: ajG61Nyhv3ne09hq-3tmJtYeTdsQZ46B

On Tue, Jun 18, 2024 at 04:19:49PM -0400, Mike Snitzer wrote:
> This document gives an overview of the LOCALIO protocol extension
> added to the Linux NFS client and server (both v3 and v4) to allow a
> client and server to reliably handshake to determine if they are on
> the same host.  The LOCALIO protocol extension follows the well-worn
> pattern established by the ACL protocol extension.
> 
> The robust handshake between local client and server is just the
> beginning, the ultimate use-case this locality makes possible is the
> client is able to issue reads, writes and commits directly to the
> server without having to go over the network.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  Documentation/filesystems/nfs/localio.rst | 101 ++++++++++++++++++++++
>  include/linux/nfslocalio.h                |   2 +
>  2 files changed, 103 insertions(+)
>  create mode 100644 Documentation/filesystems/nfs/localio.rst
> 
> diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
> new file mode 100644
> index 000000000000..4b4595037a7f
> --- /dev/null
> +++ b/Documentation/filesystems/nfs/localio.rst
> @@ -0,0 +1,101 @@
> +===========
> +NFS localio
> +===========
> +
> +This document gives an overview of the LOCALIO protocol extension added
> +to the Linux NFS client and server (both v3 and v4) to allow a client
> +and server to reliably handshake to determine if they are on the same
> +host.  The LOCALIO protocol extension follows the well-worn pattern
> +established by the ACL protocol extension.
> +
> +The LOCALIO protocol extension is needed to allow robust discovery of
> +clients local to their servers.  Prior to this extension a fragile
> +sockaddr network address based match against all local network
> +interfaces was attempted.  But unlike the LOCALIO protocol extension,
> +the sockaddr-based matching didn't handle use of iptables or containers.
> +
> +The robust handshake between local client and server is just the
> +beginning, the ultimate use-case this locality makes possible is the
> +client is able to issue reads, writes and commits directly to the server
> +without having to go over the network.  This is particularly useful for
> +container usecases (e.g. kubernetes) where it is possible to run an IO
> +job local to the server.
> +
> +The performance advantage realized from localio's ability to bypass
> +using XDR and RPC for reads, writes and commits can be extreme, e.g.:
> +fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
> +-  With localio:
> +  read: IOPS=691k, BW=42.2GiB/s (45.3GB/s)(843GiB/20002msec)
> +-  Without localio:
> +  read: IOPS=15.7k, BW=984MiB/s (1032MB/s)(19.2GiB/20013msec)
> +
> +RPC
> +---
> +
> +The LOCALIO RPC protocol consists of a single "GETUUID" RPC that allows
> +the client to retrieve a server's uuid.  LOCALIOPROC_GETUUID encodes the
> +server's uuid_t in terms of the fixed UUID_SIZE (16 bytes).  The fixed
> +size opaque encode and decode XDR methods are used instead of the less
> +efficient variable sized methods.

I'm reading between the lines ("well-worn pattern established by
the [NFS]ACL protocol"). I'm guessing that the client and server
will exchange this protocol on the same connection as NFS traffic?

The use of the term "extension" in this Document might be atypical.
An /extension/ means that the base RPC program (NFS in this case)
is somehow modified. However, if LOCALIO is a distinct RPC program
then this isn't an extension of the NFS protocol, per se.

A protocol spec needs to include:

o The RPC program and version number

o A description of each its procedures, along with an XDR definition
  of its arguments and results

o Any related constants or bit mask values

And any details about a fixed destination port, or that
implementations should expect this RPC program to appear on the same
connection or transport as some other RPC program.

If this is a real extension of the NFS protocol, then I think the
usual rules apply of requiring standards action before we can merge
a Linux implementation of the extension. But I don't think that's
what you're doing...? That needs to be made more clear.


> +
> +NFS Common and Server
> +---------------------
> +
> +First use is in nfsd, to add access to a global nfsd_uuids list in
> +nfs_common that is used to register and then identify local nfsd
> +instances.
> +
> +nfsd_uuids is protected by the nfsd_mutex or RCU read lock and is
> +composed of nfsd_uuid_t instances that are managed as nfsd creates them
> +(per network namespace).
> +
> +nfsd_uuid_is_local() and nfsd_uuid_lookup() are used to search all local
> +nfsd for the client specified nfsd uuid.
> +
> +The nfsd_uuids list is the basis for localio enablement, as such it has
> +members that point to nfsd memory for direct use by the client
> +(e.g. 'net' is the server's network namespace, through it the client can
> +access nn->nfsd_serv with proper rcu read access).  It is this client
> +and server synchronization that enables advanced usage and lifetime of
> +objects to span from the host kernel's nfsd to per-container knfsd
> +instances that are connected to nfs client's running on the same local
> +host.
> +
> +NFS Client
> +----------
> +
> +fs/nfs/localio.c:nfs_local_probe() will retrieve a server's uuid via
> +LOCALIO protocol and check if the server with that uuid is known to be
> +local.  This ensures client and server 1: support localio 2: are local
> +to each other.
> +
> +See fs/nfs/localio.c:nfs_local_open_fh() and
> +fs/nfsd/localio.c:nfsd_open_local_fh() for the interface that makes
> +focused use of nfsd_uuid_t struct to allow a client local to a server to
> +open a file pointer without needing to go over the network.
> +
> +The client's fs/nfs/localio.c:nfs_local_open_fh() will call into the
> +server's fs/nfsd/localio.c:nfsd_open_local_fh() and carefully access
> +both the nfsd network namespace and the associated nn->nfsd_serv in
> +terms of RCU.  If nfsd_open_local_fh() finds that client no longer sees
> +valid nfsd objects (be it struct net or nn->nfsd_serv) it return ENXIO
> +to nfs_local_open_fh() and the client will try to reestablish the
> +LOCALIO resources needed by calling nfs_local_probe() again.  This
> +recovery is needed if/when an nfsd instance running in a container were
> +to reboot while a localio client is connected to it.
> +
> +Testing
> +-------
> +
> +The LOCALIO protocol extension and associated NFS localio read, right
> +and commit access have proven stable against various test scenarios:
> +
> +-  Client and server both on localhost (for both v3 and v4.2).
> +
> +-  Various permutations of client and server support enablement for
> +   both local and remote client and server.  Testing against NFS storage
> +   products that don't support the LOCALIO protocol was also performed.
> +
> +-  Client on host, server within a container (for both v3 and v4.2)
> +   The container testing was in terms of podman managed containers and
> +   includes container stop/restart scenario.

This isn't what I meant by a section on testing.

I meant "How would I go about testing this myself? What tests are
publicly available or part of existing NFS test suites we commonly
use?"

So, this Documention needs a recipe for setting up a client/server
with LOCALIO and some details about how it can be tested.

What you wrote is appropriate for the series cover letter.


> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index c9592ad0afe2..a9722e18b527 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -20,6 +20,8 @@ extern struct list_head nfsd_uuids;
>   * Each nfsd instance has an nfsd_uuid_t that is accessible through the
>   * global nfsd_uuids list. Useful to allow a client to negotiate if localio
>   * possible with its server.
> + *
> + * See Documentation/filesystems/nfs/localio.rst for more detail.
>   */
>  typedef struct {
>  	uuid_t uuid;
> -- 
> 2.44.0
> 

-- 
Chuck Lever

