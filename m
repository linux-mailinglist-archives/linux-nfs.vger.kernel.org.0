Return-Path: <linux-nfs+bounces-2577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA392893B7B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 15:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C341F21C9A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404FF3F8F4;
	Mon,  1 Apr 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JmJa7SxJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IXhQR9Pg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511AF9DF
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978494; cv=fail; b=KWwBhmsAxWhGyWxuLs1m6saPdYUpPK2WGbJ3MHZQf6OeEX/G79B2PGQhQMTLSmXpyASlfNs3aCVTtzO63Fg6ZwiC9NtDSZ679TZDsBD3mNYJy9huausGEhJ3xmc2Ms8bY2y8EPHez7kdUEdIxtz8EG0I9VBWTfI4ATXtS3VK6+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978494; c=relaxed/simple;
	bh=kq3bkaezIuP1UTnXsK+Obj4U3HCWCavF5a6Ca7ck2+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tIPdFd1BRKrgJz/7WocseePC6U6kfdt3cwezPRaoPh2dLTwgZr6O1hri+YH5j1I+xgfMgZgUiCseMPwCw0kctZZZt3ja+6vkZWSIADqi5VL+KaCYaaO0KaNkMP/d3I/iro4kbq19D0HcWKbd03CajdNj1zwRcCV+vCO7Ts+7wek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JmJa7SxJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IXhQR9Pg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4319TVtu009753;
	Mon, 1 Apr 2024 13:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=x7G7B9QnMPsTrWCwx6KYD05seGP+LL27ATOQhan2iI8=;
 b=JmJa7SxJCeo1tw5DOrLIJzfJ8ZXtqUnEOzhchXmamLaBBMURj6iJUk5xLyGnzpr0BMKW
 c5xTYoQfqHzUl82pReKFt2FWxQLLDLgta78Rdwap/0agmoRrtXU17iJ4EElLiZ/8q6xK
 QPGzuJ82uA2NeZiHw7pzA/CiRFenaQicBmSsw/4FsgynLjMpYnjYBq4wwBANgVgbKHJn
 gANgKJJrrCr9V7bEI7xqnNhfPNUtUQOtenvn8n0gOhzgZNyi6H9ibYB3Jo9xYkXUy7y0
 sG2Bc9YVTPVjLsoPx8TzrrZ/X72B8C74KqRIX4D6T/NK/JA9cAgnwbkATvfQDRpMRYLr sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x7tb9raxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 13:34:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431CCKsD028073;
	Mon, 1 Apr 2024 13:34:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6965c8h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 13:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxqR2oPm8QEeOZop34iZZXG/bmp89iWeOcX7+uIrScvcAkCZREIFtkV4MzZv46IHS0x8/Nbo2TtpTAC7CwgO+CT0EHW9tzlyDHXKxtSL+FQipbraoC2xBdGMK/8jbkmRSCN2KQFOw82HOruH7XkGr/Tj87s+bKznWFptuHghHNhq2hEu17aZbARBhW+kTMOpXA/wnKsv5g5ebPtqoJcclMQCdYiOzS6ntq81ONjoobgD5sDvBkni1JaQLqR5oUkladzHhGyfyxrPkKN8B4JO7b71cuUtARjjrxPiwUMwq/JY+zS8/TAQoGNvwQT5syDRS2WGz7B9p97DMtEqzHjqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7G7B9QnMPsTrWCwx6KYD05seGP+LL27ATOQhan2iI8=;
 b=BgieT9HhjFsokXxqed49xtjOjn/OR5plBpl98HeQ7NLakrAiDmjyx58Uxbbs5GRQfi5l+b58mkcvi/SxpXqSXZKHv+HHYtd+PXjQGVonX7/SQwrCvaUpLLpSpN/O6fQ6eE7XZDpVGeHU2LnDYrEkePAulEUtTCOlInGomTNuJ422qcI2tCw1zmNlHPBMh8Y+JCNxIamlcz4KFsqQ3JvJ+HfEJ8RVmNE90Xe0gibB56xvSvHoR/ltbWV2oelflxxKOGx1Y+lhOteuqUm15m7wk5CChnwcDFioVM+gcrSSB5YKOPhb8sXzn7c02CpO/cUNGlyL3iUCNU70+YyVXoQsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7G7B9QnMPsTrWCwx6KYD05seGP+LL27ATOQhan2iI8=;
 b=IXhQR9Pglt6BvRL7G4CrakiIp5fZy0E7SE5HbUqtnrO9hd7caVXfD7CgekIp2CueBx4kNmJdnLaO3WQLmp6W2apbioa6ZcWKrZIQSlExHlBKkAQGb//Ah7FmpU0bZlrp2r1GqeaQOyIECXO9KJkztkvg/OSIpPpfCqLeNxSqFGc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5859.namprd10.prod.outlook.com (2603:10b6:a03:3ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 1 Apr
 2024 13:34:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 13:34:38 +0000
Date: Mon, 1 Apr 2024 09:34:35 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Message-ID: <Zgq365RJ9M5qsgWY@tissot.1015granger.net>
References: <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
 <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
 <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
 <ZgbWevtNp8Vust4A@tissot.1015granger.net>
 <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
 <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
 <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
 <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
 <84d6311e-a0a3-4fc6-a87e-e09857c765b3@oracle.com>
 <039c7e38b70287541849ab03d92818740fdf5d43.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039c7e38b70287541849ab03d92818740fdf5d43.camel@kernel.org>
X-ClientProxiedBy: CH0PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:610:cc::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5859:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	phZfCmoLkzCEQhzTdCTeoh/FYzmiL4fb4amSqRuqcse12H9YVOoB3OBjZj6vBAzq6D9Fv10FAHpTlIte3gcwiTXJZE/twEFG6a7gBby6KklxOF4Xar2e/9qj1WUtaKNZ5wvYZiejPCudDVkNJQ/qJY3YFcGKbJgI/JBAenSy/M4AxTQVoAg5eVMqME6ZJH+nxlQOAD7m0RjiVVRvaLkTirQAgCD8yXGD8qEA62i6TCye9GOgrBELQkAfq8eXK7roya1MWD4KxksXg+rqsirUr6E0RPlqNR5zl1apFm3c7kIKlliOY6sbysDjXIGP2xGq1uB7CEetMeIkhy9VcJbFeFvhXV1BIlv3UjpBpKQ2cofw+Qpd/psJ/QiMSfgKvmnbPIs647F3CWutm2N+84NxIW80FzCNtK5luVLmy1XH5kTxDiCz6CuO997hf5zT+RXUov/kuhvvGLVXHrgH7c1MVO1oesScZpVnMiz2lTIcL7REwuPIgFl7KX2Rdf/V23NPduwwJg7M17Dduq3vXTQWJ035WM4J3uXdzrn8vd9b1AaZMZjkq3De2EfDHfQyOf10wrxskLKFAWcUR9UFCW+BDwUjb5rm5/zFkE0IahEpRJnQQH1YtNvu6A07KlUqmmfLQnuXrXjcx7FUEbK2YlFjUMZ5PgLrALLAUWpnb6SIzbk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+OdjCICsFZfKXRhBbZ9RHhE+bsrtAg7+wL7fa54HBQI7tVVVrCS1pkHm0aeQ?=
 =?us-ascii?Q?tA9L1y26njnM/imiDLuTeCdzcpbpboxZkAMLIeuqP6lMBqlQCgxTjyol8Qn/?=
 =?us-ascii?Q?tYNuSyjWWhuhJfCSbt7fxb8vR8yF7Iwn+0/sIUO8xqRlnf1kM1jpwIog6+0c?=
 =?us-ascii?Q?CdYQ4O5pt9cJddV9kGmXelE260xxaVAzsI9nzp7hmNHf1j3/Xu6i1a6O6YWV?=
 =?us-ascii?Q?4vzIdIWv7wWkscBsIGjykVAGW/nlQ7aFzvMSDimrzC8CMpJvd3tCM6UA1e3m?=
 =?us-ascii?Q?DT6pu6huC/UYS1XmfHCZZOjxcpd9CGfKvQNENkOwkrQvFO6Lrqv4C25q/l8P?=
 =?us-ascii?Q?Xk1+9/t5V0KFuleBooMA4/67cOa3gLv8RrSzF7Rd9VhIFcm6UxyjVy04KBJm?=
 =?us-ascii?Q?7S4SWr5P+Tm25bSH0KKB+8KLAum20dMGgYknTdrqVDF3ea2rIybB4j0ao6eS?=
 =?us-ascii?Q?vVR8SVXPe3lAawBTriF1M8t2+GGSz2NXeeiY9kUXK6yvyMx2XLKgFQktVF8D?=
 =?us-ascii?Q?A46lKUJbJqK6xFG/0wE4yOlHPF0OqtJV5sBWhPULo7sWqI1lmeK/9Cf4nsYl?=
 =?us-ascii?Q?Sa6HT1il4wgziBUvpSg4XGp+0ojbNysBPjuM75m13Za4x8aKhUtCyJvDW96m?=
 =?us-ascii?Q?yIhetET3GI5OUbO+vdQnFZ8qpbyidI8BhXIoVCGjJLGWgS5qqOBno4OQm4Gw?=
 =?us-ascii?Q?yp+7OZG51otrW6uo2Ny2R5+hVlDDlEawieYgRXagjiKvT4v6y8q1QZ+O1SFa?=
 =?us-ascii?Q?4NazRvYKqsciBcYOv1KIDSxRlkjUpDkKCJTeCR6o/z0v6LzcVvcKDo7VZwzN?=
 =?us-ascii?Q?7yrFRSG1ZHa18aIedDUF0WvNwS6VPFRRPUDAX8XwzknOuevwjjWiO3EM5JLg?=
 =?us-ascii?Q?55ISV5xrcxbKox3cWk28uUhcSOUREKD6X5AbCL//PoLryca1+pdZq71OeZ3A?=
 =?us-ascii?Q?3X7RdWI58zH7D4OejKfRe+v+RzjvGlDikPSrAzvWyCdSQomKpz5kZW9Zb8mB?=
 =?us-ascii?Q?Cs77ibAxRAtKVr2Bmuz7mgAL0ggphY11du8F1Rl+5leDafmbTIDgYHZpNqsd?=
 =?us-ascii?Q?TojGxApgNxnpjaiDOQxjfCLhBZiUapI7x1FTJhstRze/xkH/oOhRnPBpO6UI?=
 =?us-ascii?Q?OL9tTE8uyPNy+A0kyL5jCop9iMYIlmXFeMKfl0oSGHzqXfNWvxxTqUsRcVnm?=
 =?us-ascii?Q?JCPIbwcq8LC9F7DhKLuxkG7PDeRnTM0+iBIFjJPV6oU3k1iLNpETEM8dSjZV?=
 =?us-ascii?Q?T2iT2icavpP7APeaGw1hOJsodQ5mWjCiNY421j0VgeYud2qOBdFMLHOZ3Tl8?=
 =?us-ascii?Q?0Jh5M+4ExzPY15VhetRDAq1kQbI4ZPIHlxvJqbRet9wwGNS7ZuwvgCdC1fCg?=
 =?us-ascii?Q?bfQFAfLeB31pK7mf7ezH/NCYZGstqCOZTUFPR4aq7zUfAygRSNRmcU2H52ne?=
 =?us-ascii?Q?7sZ+8iIDWFjAsq4o/D9jen1+UtR3xUOUkLAfGabROpC6xkRDnEctJ3xQ7BEZ?=
 =?us-ascii?Q?Ybb2mMaOsTQxthIVyeLg5Biy8c0J5BQkIVjoSrSZ3ceftVck2szaiI6VXUaq?=
 =?us-ascii?Q?uQOOp51pHYoiYT53fW+rqbNHXtCNTU6g83lAjruPb7nRgZQlOtdiLns1rO2I?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OuEhFCCxCnyjYqTDecP8BxbSMAxd3IYBxFbkZeFIOEMkYnnFGXg9gaKHa3LZDcg0TmSZrLNWySqj7479G9N7UlyfdhJSoZq6deOMmwdJxCA09DiS6dU7rHZ7EiBFiELwKoeL/wXNW6DvQ5hByuu//lJGY1OgLNtzzvTzmTmdy+FySE0NNJvCraIcrIC6SpYCtVE5ELkz0AsC1M0BnDehAQ9SetnZl87/DXGVj46Th8iICuRVC3pr4t0Sun7Y4h/xC7VPjCCBk637Os9s7Wx3vMz4y4Jef3KJ3fgy4U7fghQk9JSLmnejlB4L+BGl8Pen2Z/hmQKT8xav6S3IQfeVAJ/wwfQaXTvCdtXZ6Hl0CRR78p5HHmq+hU0tj8wsVMAWQUoVe7QwmchPOHj6OlfOxEZDezTOKnpkU051UaCYc08v11yQ6xXBxpbqNYcPC7jlxoUiJY8xndKeFoN3kA4Z4k22XYz/XyRTujNUFybgUdj5EExA9V80N9srcwvrz4Hz1faFqglQqsQwr8qZtBLvFaPMZ1AFK24bhrwiZ90RWQAWr7Nv30h2PnV3+AjU3Y5ddq0Zk9/b8GSB9UcEz/siExj0BYLR39of6m/CBVlqNUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df62681b-05f9-4d4d-c0e0-08dc52507a0a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 13:34:38.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LX0GW4RRPF9bv2vJRcs4uXmY28eJ+O0NVY1Zb0PCGFiaJ7NApEu6X8Mga/q8p0AlOKJNyMbDOC7QPTx/DpmdTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404010096
X-Proofpoint-GUID: hS9V8ipQgoBOKynAhZJWSleXfJigRvcJ
X-Proofpoint-ORIG-GUID: hS9V8ipQgoBOKynAhZJWSleXfJigRvcJ

On Mon, Apr 01, 2024 at 08:49:49AM -0400, Jeff Layton wrote:
> On Sat, 2024-03-30 at 16:30 -0700, Dai Ngo wrote:
> > On 3/30/24 11:28 AM, Chuck Lever wrote:
> > > On Sat, Mar 30, 2024 at 10:46:08AM -0700, Dai Ngo wrote:
> > > > On 3/29/24 4:42 PM, Chuck Lever wrote:
> > > > > On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
> > > > > > On 3/29/24 7:55 AM, Chuck Lever wrote:
> > > > > It could be straightforward, however, to move the callback_wq into
> > > > > struct nfs4_client so that each client can have its own workqueue.
> > > > > Then we can take some time and design something less brittle and
> > > > > more scalable (and maybe come up with some test infrastructure so
> > > > > this stuff doesn't break as often).
> > > > IMHO I don't see why the callback workqueue has to be different
> > > > from the laundry_wq or nfsd_filecache_wq used by nfsd.
> > > You mean, you don't see why callback_wq has to be ordered, while
> > > the others are not so constrained? Quite possibly it does not have
> > > to be ordered.
> > 
> > Yes, I looked at the all the nfsd4_callback_ops on nfsd and they
> > seems to take into account of concurrency and use locks appropriately.
> > For each type of work I don't see why one work has to wait for
> > the previous work to complete before proceed.
> > 
> > > But we might have lost the bit of history that explains why, so
> > > let's be cautious about making broad changes here until we have a
> > > good operational understanding of the code and some robust test
> > > cases to check any changes we make.
> > 
> > Understand, you make the call.
> 
> commit 88382036674770173128417e4c09e9e549f82d54
> Author: J. Bruce Fields <bfields@fieldses.org>
> Date:   Mon Nov 14 11:13:43 2016 -0500
> 
>     nfsd: update workqueue creation
>     
>     No real change in functionality, but the old interface seems to be
>     deprecated.
>     
>     We don't actually care about ordering necessarily, but we do depend on
>     running at most one work item at a time: nfsd4_process_cb_update()
>     assumes that no other thread is running it, and that no new callbacks
>     are starting while it's running.
>     
>     Reviewed-by: Jeff Layton <jlayton@redhat.com>
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> 
> ...so it may be as simple as just fixing up nfsd4_process_cb_update().
> Allowing parallel recalls would certainly be a good thing.

Thanks for the research. I was about to do the same.

I think we do allow parallel recalls -- IIUC, callback_wq
single-threads only the dispatch of RPC calls, not their
processing. Note the use of rpc_call_async().

So nfsd4_process_cb_update() is protecting modifications of
cl_cb_client and the backchannel transport. We might wrap that in
a mutex, for example. But I don't see strong evidence (yet) that
this design is a bottleneck when it is working properly.

However, if for some reason, a work item sleeps, that would
block forward progress of the work queue, and would be Bad (tm).


> That said, a workqueue per client would be a great place to start. I
> don't see any reason to serialize callbacks to different clients.

I volunteer to take care of that for v6.10.


-- 
Chuck Lever

