Return-Path: <linux-nfs+bounces-3004-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66668B23FC
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 16:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4C11C21D81
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3974114A4FC;
	Thu, 25 Apr 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aRXJ7BHQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BF7ihrfT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4A14A0A9;
	Thu, 25 Apr 2024 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054818; cv=fail; b=qQsN6vw/sI3NXpoAMzyKuM5wNHTYf9IWJitD+zrzwjq8c0KrI9x2xAZZJhtMzzV6V2W7xvdnvq2Xnb2/7+vJba5DEDs+ktWMjCWxfwSLEmxBsZ1ZvOCYy6X3rGagvpC1Hi6IhhrWZ+4hAxMm+LWNAyXAY9YfFGUew8Tz+GOuU9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054818; c=relaxed/simple;
	bh=ej1yyq7mYPZJ8rY1QpfTAOUWh5ZnJUN+YHRgr2BS80g=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bNqYNzbRnEBPCwqDTmmejuZ8YssFsGwZxSCHG0tCl388lKj9I5bBdpK3XXHpRv3J3kojiKbGQ8H+dB+mPAALqDHXfO8/hJeS+bRInXQBTKQy74L3Hu2wdYAFe5OxG1D87ZcA8JYbZulBqHyNOLq87msUvqogPKh9bC3yRU+p6Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aRXJ7BHQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BF7ihrfT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PEDrn9026154;
	Thu, 25 Apr 2024 14:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=fbqDD1Ky1CWuIMOuPK9TxD+2xQe86v9KyEnno8vOdY0=;
 b=aRXJ7BHQ9hWwH/lAD6YgcxScT8FFU0iBRpv9fv3RJwW+hAikzdaHkJ9D3sHpSR9cFL+m
 w1wo6oBuddYMKRJWYYpWTyO+WOxtdb0Qy8VHy7AyYseV4CF8rAptQCTStKc8zff2ZNR4
 erAoOGfCzYmx/jaMglnEDbYVO0ers4f1SG2I3CIfme9sakXxkhfF09aJ/1DPMvcmYKOC
 FjSCL5lEPdKixD0fe3VBhSSUNRfiEr3ppxbAociCziobb9SIES37vwFg1YPUIpcY5GOY
 dz7TvFNL3p66XCbCAirvee1RRyfeGHcThKT16sWnTk2WowsnksO5r1yaB6GH3z0AUSqI fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5re2p8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 14:20:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PDmvBp001866;
	Thu, 25 Apr 2024 14:20:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45b308j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 14:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk3sPEsFNj49zkfNT2l5i9pt8dpQW4ifXwkjHLVWYXTPqbTSCh09KwC+9Ks90sQQkGV5pApDmKixvjRnGmRtCaY76nL/47chhWbnOvFwu1x4YFnbcTiwqvX7z19gQVaxR88g/yeE7w4u813qcrQWzouM7H2+Pqus0lyJW/f7b1gOt6/kmk9CvlADz0dYapIHmttdiFJr+7mrUMG51Z5o+o5VCB3w+98/K6epzZ6q9csWXt4TimU700Gjla97psTa4Oq+UhlmrZIanyCru79M+65nc9LaA5MYCx8mX7GVTPv/UtHx6BxoXnnZkUo1Y0GDAZVv8365AQfqoLfrQtGmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbqDD1Ky1CWuIMOuPK9TxD+2xQe86v9KyEnno8vOdY0=;
 b=JnbMgHlB6lq97v9sopCFX2RX3uZyJRHqyH/EnNeU8c69dbNyvFz02HH0nvwxN7ZKlRF95MSc3pdbR4roNs9fqF0VgHiDFmlsh2J0S53Y31EuDN/hcs1+sD34EjnaCcQzk9DIqarlFyv1qytVVjkHsVvhYr751ahV+tlNIdFdJLY0FUsl0u8kai0Hf25WA02qvJ/5NL1tqkJAoAk2gWbr3IFpJQXW4bQ8qGn9fqWk1tGejyqfE0yst2aHw/v1KQkFtjpwoHGUFQBUdLGMg0ZmyxHf838uSjVU1WV9p9PYKj37+jExUMmHu2fdWTuSZ7lh3DGE1aSl87OO4P3qY3uCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbqDD1Ky1CWuIMOuPK9TxD+2xQe86v9KyEnno8vOdY0=;
 b=BF7ihrfThLXZuFO8d/i9As1+vfK03vNOQXFrWpVNDAkFhSK0hyrKQCqMzfy5tU6LBN9ArrKdKZTfdPQMtFOKpTPVdtWX/yHAlNNlx8TP8TLQZ5kMTzOyr8gBpgIrC2XgimqIWVnBPuWsR8KuHfJpAw0l2s155JE2TjboIsjXYI4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4487.namprd10.prod.outlook.com (2603:10b6:510:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 14:20:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 14:20:01 +0000
Date: Thu, 25 Apr 2024 10:19:59 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] 5th round of fixes for nfsd-6.9
Message-ID: <Zipmj7eGXGHMMDC5@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:610:54::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: e69b7d01-afc3-41aa-90d8-08dc6532cb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tPhfvlDybYR62vJEdjvqiDsGvnKiywmhMsZ1byfaNjtdFj5mimdaMh7psCZv?=
 =?us-ascii?Q?SvUToKz6Pf0XKK0Uh83t8GJjbUIyv89An7XVjg3JldZxyoRtgfjb26ZIPo1V?=
 =?us-ascii?Q?BVh6nukxGIOVJMDH+LXI4KcaYAokcVVpJpIEODmoRFZhkucBBqxzdocPa2re?=
 =?us-ascii?Q?m4peODnUQFyA1yS9uvBiWOFpDz45ShOsg/Me/HWmHWldaeENtmUCGNI1HmJO?=
 =?us-ascii?Q?lWcMw8pyKQEq43vctUfx8dDpI09F7xex0TJ9RaLJ0zYpUerBTqwGp+CibKPp?=
 =?us-ascii?Q?nsicebFs12UZ5WJZC9FzXfDR4e27wBqdf7eQ/VzQL8nkNZzzLHYIGGwB3J4j?=
 =?us-ascii?Q?0NgGgddjcXkqokYFkKGmQjjkC0Eow3X5SgepP+mYIieGY4aV2JFsyvN4Dyll?=
 =?us-ascii?Q?gmWFFMj6WajgYLK/MUBlm66DxJt1hspMr3uk30XLtBneyyCcGMLrQcUfGLWl?=
 =?us-ascii?Q?oz/r/4mo/MUiG+o00ztuqSstQwgUPtqGZLWaFBPM5foSbHukBt+mFKeUI5QI?=
 =?us-ascii?Q?nCXRm4akqXrmEEKXGLrKtHTJNJlqP+U7eZREj6A7AR7pUfAcyaW1FuYAmDUO?=
 =?us-ascii?Q?z/dfRdahFKU8Q6Cxm4h+QOOFK/bH0w76/9fhtvnMe3NchlLctatNSMf6hVQC?=
 =?us-ascii?Q?Givccx7Eczn1us9b1VXocUFgW7Nx8M69HJPkHVLMixGOjSl6z0P0EBw0DivX?=
 =?us-ascii?Q?/q1Bu4MjRJgSYCiX256+WGslk/EBWolMBM2AOEobPVK8P3PSo2z9/oQzn81F?=
 =?us-ascii?Q?u15O4lmOCL/rF+oLgkeWbXKXhURKX2IsvSS5/Sia+uIrcau4+DqsIkkShXE9?=
 =?us-ascii?Q?MUKBvQQABciaLzAdnOjUy7G3w90ap6gMa8gs3SxJ5UoHC6OeRR6oWEQgdJIl?=
 =?us-ascii?Q?y3KCWzSmvlJ77hGuT6O3bPcdSwJyk9zIqw0vWaJwfs0HDJhlngOozOmt5p49?=
 =?us-ascii?Q?1ENsDjp2Z8TcRga1toqVKgff+Oa82xaR6dGGJ7m4jbrEv1FeNDH6f2COZW14?=
 =?us-ascii?Q?/juIntip2sqN9Hut9qz0zsoIysU9qHditJop1cg5IpVnbM4llq9rtmjK7ZgT?=
 =?us-ascii?Q?RNj/KgweHWRJMEYu7en1hIblB0864pFWSj/Ectl1wBf6A798/ktu7/UAtbFb?=
 =?us-ascii?Q?8GWuuyjcCYXfaVcp8sCNO/pSCfhDO1gprlLWtYU9kiYvSNjHyupjE1Jmr3mj?=
 =?us-ascii?Q?AKYqtWI2zcbYIsrJQP6YRTIdFV9kY1DGWhQrIsBX5MYHaqf1dEJRu18+37QJ?=
 =?us-ascii?Q?IPxTp30G8LYXnHn4bSwTEgNXdeX0V5MueHLyEGOX/w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ab/MdxbzNzxziwL89AedOpfgWbdKXbsHk/qel4d9jNO2zcUuLvpCFo1a3mvZ?=
 =?us-ascii?Q?0RiPnWQ1NqV6zyU7Z/Yu6GvbdC2IadugCfLoxwzlidlE8XdH8Kis8glkUR9o?=
 =?us-ascii?Q?LBCmd5teioZsvD6/pR7WOwZ8c1ADrDxq3L7PDNJbbxfANDfYwgaBFM064hvu?=
 =?us-ascii?Q?SsRd0TBH1sL8hYzGyNcs3FADYa6PabKCz1gzYSVil2v8fs/dxZw4S7Qx76HA?=
 =?us-ascii?Q?IZo0IU2of3MCJOmZJ8xblNdxpkyp6R6+obJKU8ISvIUWBPtEjPjlnAfBV1Uk?=
 =?us-ascii?Q?KmXQxR+alv3/ncrweF576Jm3KlpD9OMrM5CuJiXmnoC8V2T1122AYsnIOX9r?=
 =?us-ascii?Q?voUzWuJKYzmYwUZ38Xz4/l3py6Y43C28hsYiD1O/0Voth0gYC9KGNzfBkOLq?=
 =?us-ascii?Q?B7DsXPZuyVDAyLog1rgDISzf4v95zPIMQ3INA+MIhL1HWNpLMo6jcMR0w0AQ?=
 =?us-ascii?Q?x0FzfEb3/q8TPIszLooPP2ArzV19mZY+WYHF7Wiq+KI74Gw+ILvUg6hm7fov?=
 =?us-ascii?Q?HnUm/ri5zPGRcyvccgNedB+Y4n0JjyJfLAhSdbR0Z7Khcp1aP9DV3BNt+LQ9?=
 =?us-ascii?Q?PiQ4gX7qo2zi5JsU6/XfgYZiM8WhU+7doeQLwWpwvAckTggfkjvmbFKE08Xf?=
 =?us-ascii?Q?dQ8TwST4E2+Ql9bB1mIyLTOIHco/M6Vhu6mbxJUSEnDWVKKN1Y1ZEHUW2Uct?=
 =?us-ascii?Q?Xlk++ETuq1dUANnknCrxbMOl8i4RItkzlOW+viVP00occ5fUbvl5x1mFtAVQ?=
 =?us-ascii?Q?pF0yYYQMBOJP2y2uCyvF52PrY5C86pB1IAXfKRXOi3x8GtV2GYhYuUXqLhmk?=
 =?us-ascii?Q?p8oIwxZ2wyafQIDU5H4xn4F7570nkuY/M8jirs1+HGqdhJ6UikjWrZGS6GL7?=
 =?us-ascii?Q?EXeMX8R++O8+faZbrig9RK9WCKHxFtumFXcFFSWsR0kY3HASHp1X+pgYr9Qo?=
 =?us-ascii?Q?Nh+HYUqaOAE8/Cn9b+HzD2XJb/1+Z1Bp7NuudsqH95lCvB8MQCNz4ubvbfQF?=
 =?us-ascii?Q?hBd+/XDceOn/Vw+9KGqMyBX0s3CgJwG/WH9R1C6qGZa1Rqqct7ZJwILkM+vl?=
 =?us-ascii?Q?pSxr1lTI7MFB2p8ubwRoI914+91L7RgiWGCxbUukPsedEoqQpDHNLwt7oEk0?=
 =?us-ascii?Q?Df2CtBmH7WnDJuaZs4iikNAmmuNenps4HJ7Ek7XekZaNYgAa4IWX+MKthMrB?=
 =?us-ascii?Q?QdarcrkFRd+UYPYhrJZJIOTYi8Ad1pNGVWcMagQ1aoXSVsqKWX3lKemhg3I7?=
 =?us-ascii?Q?v9nBhpQkfgDofyXyqYt2mavvpQXE7E/6rgIf9lHVTDU0cOML+9qgHFyRSjMW?=
 =?us-ascii?Q?UlNzOUk8tPzL2bOaq1E79Ehfro73vPD7C9RNRZU4/WCqGgR7V5VdsTG8GW1n?=
 =?us-ascii?Q?GVw6fiGrDr1CbRzVa30HxC3GgN7Yz1ffxawWn8YaJ6zWsNbmduQkRUdFaFIQ?=
 =?us-ascii?Q?Xe6tK6jOueANvIHz2R0jtCdO8Uve7e0FQopnFura/aEfPUSYRdQQCPORh4Y0?=
 =?us-ascii?Q?r8V1tJ/JkJ8JSHMlAtGS7t2WU1Z+iFxn7fC4dsYhtEqQYBdTGvX6iILHl4Ty?=
 =?us-ascii?Q?enx593l+6pjGbpLmRT7+dc8Cd8s2dBKJ2hw0L5TiOuuwLOq17nwYI4HIjUwY?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sFlx4b+ZTZJ1rwFaqWhtOkXGL+VuCPJk9sFNk5nt/2zrn8ZZWp3JzTcAsynCPMowQpI9QaHN+7U+1zDC0CubBDbGPUdTOQrkbhIx0qVIteP8FIl+wuxZc9+EJ45iGoQupcSiWym99aYFVq4+mgH2mTDgP1Io7Zv7grO4FwlDxZVcmvfHcdu9q3H0kn0wwCULcJNxbKpd5rnCJXI1mbYAQMX53vLXGizG9AMKFwC5b+HUGo04KBdV2iy8J+b8VL8topnrRf90f4QOAXaPLCixXfnOZFZZ+uMBrqVMHD40W3CgW5ry6g9l8jlZydpfQiK+pb7RNU38T9lxVSVneUTKY2KQwP/07E4iBX0pXU78ds0vK65A0i7gOL1co4QWSm3U6p8mhtIXH9gCQnefVIcgEI2CvO624wuRDwdpaJcOr2ii5dSho3EVh12bgt5+fw/UkbOVqxWe2xdP2HXV2CSd9VeYA7KkZgyOaT4IHCpfu3GGvKzsdHpYoeTUwN1ZPCltPWJQbw7SjuyQx7M6acX1sWh4z6xEbrDu985tVb84rFfB6OE4WVbWeu8u+I4X8y/sMV5d+dF7vz/yR3Ls3HjBGGNIYrDrxZj+Puds+iKv3Sg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69b7d01-afc3-41aa-90d8-08dc6532cb8c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 14:20:01.8218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFm5fyxXX0iUTOxrOHFMET4sKlqNmOD2CyCggelIi4jfff2AoovLv0W0t9E0KfLvkq0YrIpTGFze4x6DGracDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_14,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=768 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250104
X-Proofpoint-ORIG-GUID: ZPM0_F_TreOCQCd7i6shCfiOOGf7EMJO
X-Proofpoint-GUID: ZPM0_F_TreOCQCd7i6shCfiOOGf7EMJO

Hi Linus-

The following changes since commit 32cf5a4eda464d76d553ee3f1b06c4d33d796c52:

  Revert "svcrdma: Add Write chunk WRs to the RPC's Send WR chain" (2024-04-20 11:20:41 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-5

for you to fetch changes up to 8ddb7142c8ab37371c6fd167a8aded97922c6268:

  Revert "NFSD: Convert the callback workqueue to use delayed_work" (2024-04-23 20:12:41 -0400)

----------------------------------------------------------------
nfsd-6.9 fixes:
- Revert some backchannel fixes that went into v6.9-rc

----------------------------------------------------------------
Chuck Lever (2):
      Revert "NFSD: Reschedule CB operations when backchannel rpc_clnt is shut down"
      Revert "NFSD: Convert the callback workqueue to use delayed_work"

 fs/nfsd/nfs4callback.c | 26 +++++---------------------
 fs/nfsd/state.h        |  2 +-
 2 files changed, 6 insertions(+), 22 deletions(-)

-- 
Chuck Lever

