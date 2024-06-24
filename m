Return-Path: <linux-nfs+bounces-4279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377D915677
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD20B212C2
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030991A00FA;
	Mon, 24 Jun 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TqMgQAzk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KgUPaagt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69C19FA8D
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253621; cv=fail; b=nqzNJ/zv0e3ik2Ha1qAOKgVi3z3cinfXv0IRUJYPCl0XeHuhyXNtmJ2jy4C04Mj8uuODRbZbXXSTJupRrCz1+ExjZyMylH84zCeb7Af1DlPV1M0jK133GVdqftij+EP/P0Wz8k2Ke213CQSJivZwkBBl8rIdyz8cIjBjSohNJng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253621; c=relaxed/simple;
	bh=YhPoP6LnNcTE/1Wjr4fkYFiCLmSrMYEIMGqctHxV4a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fveefo2WxuJpb+dG9rfnc6Wte8auftVUe0vTB6cP9noBXv2L8kZrun/vnvi2U0VrIpc8AdMt8t/wKXWVZLREC6le61he08MXuB5Z8ZyV3lqKe1qrPZ8r5DjXLZqYvA19h8xy6pJ/eBEcqIOZkwubrGjkrewBUybdRmBHl+DmgT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TqMgQAzk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KgUPaagt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OHURXH030850;
	Mon, 24 Jun 2024 18:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=dXaZ2n4Pw7uZ/an
	VD7vQJHvg7w8SdQlOvhy1swXQmu4=; b=TqMgQAzkIVg7E03HXbot2qtR8xYF3Sq
	X+zwcFffyXhmXx8NAGCL7DiOyw2gN5q5ZCtkfCwF8qcx3NO6FUdI+aHGwXSgm863
	amgdtxKJIw/vQZ8A28MZK5kmOpecEbs79IItVG20mt1r6PiWEIY4zkLA5SC0dHB/
	9wr3dIIHCjwE/ty/MSpoNR5p4mvPI+OXkunbxfAdUtECWu+3mEGRVsmEHxkDvP+P
	7URF/gXuf01UZej6dKn0KYrcIcYDHojytkaqUi2qfmbUE9JLL5godZH9i2nceQ2h
	ZFfRANxHILUWEJQbq46a2WgeSKBYRN5Dr+Dtmhq0DmolyvHK6nuXFBA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg94mhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 18:26:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OHVA0M021561;
	Mon, 24 Jun 2024 18:26:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys3axu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 18:26:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDIPRBYWJbWYv8j4PrGVkMoMKR0WN9TE65yRltKpGZrsx1rrmrn0rRxzZP9hEblqJKkuiqMctMVjEHDcSObaTF3TLjb52qjE5XkmRw4wjACXDcRpa+t3lfeCYCUsuyq2JXXY2q5eFAXg/eLUyog6U73wYnE5x0PDYGferyYCcJeVXl5pjq4VSx8kRGS57FU6f2o0ZmOlN5jUlYq43Dr30tbbyM0TdkNSMbGHyj7Iy2akOND+hXHsX3s4sDeUd1CaZrg/ThJ3ddzvjxTHHOTJ/3ejkdHB7oFhd0ZJnzh10Lj/C+08iqbcR7S3K00puSbeO+8+mAhbaezxOE+kOY/Ghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXaZ2n4Pw7uZ/anVD7vQJHvg7w8SdQlOvhy1swXQmu4=;
 b=QPSroxXfvx4+rfdQpEpaB8LCenzKTDP6H9zxEMOm7t6/QguQeRrrTZzjeXyvtfdA+gLhpxaqZ6JjPZ292kz8ddugVDZXdRmVtTjquSvKYHKGtNjMAE+RG2pMdNWatzKtk6MyJ0JE1/2uq77ajanAxf3IHhlwNc4fsQ8T6pvVJF/BfuiPNMz2fUQNxGae6gGDw0bEnDQiNL1F0vEnUe2XKEnkbUxmet8pnSbZbwBHRRJC/fWQ27Hjqp5ohdDnA/JbVOdesUU65+V45H15ZqCpmby0Gg3zPI4WP1X0bF4dEin61FQxWcPHKUzDt0Y2nGoWJ9PngfQ3FMQpKlzUC0fvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXaZ2n4Pw7uZ/anVD7vQJHvg7w8SdQlOvhy1swXQmu4=;
 b=KgUPaagtQWAIg5l47aqlZxVnbWSgj/a/xbITaqiZq6+Q4brqEua5N2ORWvyT4kgGdSvTLwHcbgxLgLQIvw+b6h0OicMG5cTQWYPhtKm6teABu1TkJ9KPEQpmD62/BMUptan+KrO4SXU4qxteSwpmgTS8DJiFRavqhiQUg7Mxda8=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CH4PR10MB8170.namprd10.prod.outlook.com (2603:10b6:610:247::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 18:26:45 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 18:26:45 +0000
Date: Mon, 24 Jun 2024 14:26:42 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v7 06/20] nfs/nfsd: add "localio" support
Message-ID: <Znm6YjFetA6pG/5W@tissot.1015granger.net>
References: <20240624162741.68216-1-snitzer@kernel.org>
 <20240624162741.68216-7-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624162741.68216-7-snitzer@kernel.org>
X-ClientProxiedBy: CH2PR18CA0038.namprd18.prod.outlook.com
 (2603:10b6:610:55::18) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CH4PR10MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a8566c-4026-415f-40bc-08dc947b33c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HfTZKqT/xNGCDrkph7rmkUD8rCXj/s4QcT/zoJ0HSvMt8Sp07QGordp+/omU?=
 =?us-ascii?Q?JRoLPj/TW+blVQy+IC5BiJz0cGWNIZaufDcJfdy6PYLjVluHjtoQcax3KPIn?=
 =?us-ascii?Q?tdsDgIWQNHxeTSzKRg6Qjfn1FOwjqzet8LTM38vlmhpN5TsPlb09yF+7xycC?=
 =?us-ascii?Q?Knna6Un5nRZi5Mibu8nJGwl/IQ2UuYy95KBHiTSQ5M0Nz48rrbyPXORQTQw2?=
 =?us-ascii?Q?yJRzwM6omlk7OLoHzt/BkVQfVZz8Ksw5tSRbcQKHiOjYmj2ay4ExxxidymGx?=
 =?us-ascii?Q?zqHxEXs9qqtZ4xg5MGE7oVbrzTCalAncBZmRTFdDRwftlcgx7wFQ8QEcbhWZ?=
 =?us-ascii?Q?0XybAQPebXs/jKwQBfkH249hncEQmlMxtoXrpuZCJrD8GO9xsSdc/J+XcJoE?=
 =?us-ascii?Q?UbuseAOWKY2peddnkEwX4cfNeJm8N5JWbZdqoruFloQZZs/gGME741TDzL5K?=
 =?us-ascii?Q?MObUtVScoM2RaSSjbZtzGm4n831u04wTdmOLDFujVWwV1KzVZ9M6aLQtPKQ0?=
 =?us-ascii?Q?Bb0OZjtXIz4WcsFAqXEUw95JAvRS3Drs0k+BdMBAS+AiZ5Ym35KkmsbF+gP7?=
 =?us-ascii?Q?Ka+zxIYham4GRgeUqYVgzpm5ywKW65ANaLfUiErMZH88y81rcI0ChCl5h/OZ?=
 =?us-ascii?Q?eFbaanpTOc9wCJ6pt3guKqAS0K+PdMJZ6DElZDanQYVYpanAwwUzQPaOdwsH?=
 =?us-ascii?Q?SXnCJz4d3yYvImvS2z/sTqmu5YwSnYjVfyAuF4YpZ/+GrFpI+k7RmZP6gZIK?=
 =?us-ascii?Q?ijtfnuC3Am0TbtzEiei3D/9gIcxLdmYLwaNy3Z3zxUoSC3yHK+69ciFTsreH?=
 =?us-ascii?Q?W3MmffUlMU1SRDYmRj4xxQJtFE2HUyPo5AXU3WzB5ws2RCurudX+bM/1TOPS?=
 =?us-ascii?Q?bI1YMiKaJV+f4DQxLtosFHszuvWdezWPHCp4ppycWSBiSXaBCDMMbORMhfKE?=
 =?us-ascii?Q?cHwYTr35Igy5pypPP9Z17q04z9eMz3yAPrIy3tcProGbJZJs6oy+fQFH9GB0?=
 =?us-ascii?Q?59ObkGVnjOEnCukvWsupeq1Nen4Qzs1hwCNkmsHa8suJ+hYcFX1uBLRnfg4s?=
 =?us-ascii?Q?qU0PLLnnUIr1rbqm8i4pxg+qcj83l5Ufz2qWgJrFmzk+BddTEaIpol9OgaIK?=
 =?us-ascii?Q?sVuoiiVQJFB02KNMe5f9HirDF8AYoGnh8OFehPU/aBH0m8Dv34hiOFGxv6Fx?=
 =?us-ascii?Q?mfOKFHEYXAefGNraLTeVVCllxo0RIeFwprHIuhjMaRrcU/smbN7JVJ+In7sG?=
 =?us-ascii?Q?xRAcW8fQBHt4Ps/lJAbjin+FMQmx9K2IWF7wC/+2n6aKef18NuHIqYWahZXU?=
 =?us-ascii?Q?Dqzpvr6sKe6ssR/50u53lceC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?36OxPCZdA5YKwBpBQNXG0sRKs7S74ffQH5wWd0ocAAZgtuIbRqPN3bQFwUSl?=
 =?us-ascii?Q?FrQD3PrYeg1byW2VMNgtIhc+KjWWMAm9VKiBcZ3GmZbZsqXgwi4ujsxFrfGZ?=
 =?us-ascii?Q?BK50aiMrQkmLl2bhX1A3K76sWCzfK2HslZi5ax3xNOoY4/4zt2K0LLk+waBs?=
 =?us-ascii?Q?Z6my8Idxl0K1tZv0rdHwcGKs6Xr+wFLnw9t2prPL/n3fr4+nrl4X60zx5kmF?=
 =?us-ascii?Q?9eJtMwD+gjnMMdbJSQKs0PuvbpvQPvqVuCL/jHA1PpOSRboYTiDHv8Mk1w/b?=
 =?us-ascii?Q?3Ez1iF0+3/wJPKSKCo0ScBmZsj60UUcWjXBmPX1gu63QQdkzGv+8nUFPkjU0?=
 =?us-ascii?Q?o9ga+FXuSf2z4GqKqayDo5JuHXv0X+JFfyNqU40usIN/ITD4xcQvpqoDQsB5?=
 =?us-ascii?Q?7MuiqKt43+WJAE1i6JA1tufyKAkb+gAT5X/V35CKcM2PD4ubR22k03SmkWVc?=
 =?us-ascii?Q?G6u1XBC3T4XHdu5oBswvWQ2aP8Prn2pHgzrhp/OI4Na3dU3ts3YmljGXhKC5?=
 =?us-ascii?Q?WUbHMVNDJou+FIJecP7kg0lpozcLfgWpEUvU6ElPHoM38VCjuvSe/IBCZAeH?=
 =?us-ascii?Q?0N9aMHm0dJ4ZxwQ2/yI8kwqbJYaJ4NYjuTX2htph72Dnn3Igp0vAdbMbEFSE?=
 =?us-ascii?Q?Tv2XI5ElyQ4DJoBW6dxf+GXf76pz+c6ldalZb4Hv6+K1OtVhiJ80ehVAlYGb?=
 =?us-ascii?Q?mozEdTOWfp+hx5hYy09KdkjA4DUP+X4PFdCBg5L5gedzc4DZa79MBRqZwbay?=
 =?us-ascii?Q?T59evBX9Cc6QS5lEoexDy907KpWCEYRshifuYUn2oajBjGqevxnRLcpVyUZJ?=
 =?us-ascii?Q?GYHeuXo5gp88eik0HCLwU2xeqKA/HWWpqzO0Nu+KQRpojypIrOYKcste6IS0?=
 =?us-ascii?Q?PPNTTIld5sMIYqDiExEHLfIPD6ptBtx7aUwZtoXjvAHR+wPJcyhGd9wqM8oD?=
 =?us-ascii?Q?ENFKGT/3eJujcURyVlMf8KBi630sOBxjPUrQ/k6u40/cEajZMnDsiwyzt+YC?=
 =?us-ascii?Q?DyqqORn9ZNsW2AYlDAawsEa6lsNv3j2ZAu0NyeMsyTZEfQrsBQF0pPKAb+KY?=
 =?us-ascii?Q?MwuYGpZow7ZtixwOQkK2xLeSpmTlDcST4dnFUePtYaIx8zXYNsm2Sy1UeRDp?=
 =?us-ascii?Q?+N5iOUkM+YHdDAJaWpM8QigS4CDt0lL1ctUAWGrTvejchNIh6StphvYz/Iw2?=
 =?us-ascii?Q?zS+E9lgaFh7NvXbd6JoXUEiE23etDaOyslKMRfHrYFrJxUABs31yjDukIzpv?=
 =?us-ascii?Q?zUxgS2+tojcX07pVc/PDaWfVzmfUBfvJ3MsHnBJCzKQMGavlOOLVj66iyMSQ?=
 =?us-ascii?Q?nyeaeCj+wfBKHfnc1159jh5j7mgelpv9J05F8HWIIMWspTWTI9bl6wW40WaH?=
 =?us-ascii?Q?cI+ZUUqkKZCt+VjY6T/d5S/Zh9FKMbh4csJ4aLvtbbSoUZphzhwr18b0+IsR?=
 =?us-ascii?Q?ilJWdY1GOPRty9QXHLYfqpQEjbZPO9Kkpsil8nuo/SCeSum9mTLD0W0mhplp?=
 =?us-ascii?Q?ZaPQMRV9Q13Safp9IY7egUA3fWJQodnX+hTHKx0SNeeuaJTrBF8efbpdkpgR?=
 =?us-ascii?Q?4yMYevNgYp91eYBSI6jRAp9WMqYeae4aFB3uxp2Y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UUJ5lCHmkGjGhldyc/0waGcrnrEs628sNekNm22OMKrcN90JwzO8NbT58VjgGLM9kv/g2YusKcWv7Yaa+T2yMsLffn0WMwrV0VcuCP04Fu7gTFQvJ7BUAmkoBkM4DCCX+pDCqwsxP8LWxI5L9iipwChAR2pWypQr2r9g3+NVsQSUuJOUq0g0mknkBgIlt6oOZw/3ntvgozHpqLD3T4BVkMz8qzhyczMm40UJySxwaV4+4s0qHkdDBhVnoxRtb0oRIQIGLHxWS3HAyTSi+GGzfrE1xaWQBZCBhjRICdMnmsYpIOyFvsa45mVEjoMfW6VA4kpZA97w7EVvTZ3MhjjhDY41+XJrB6pT2mJdjdkyFS6R83FzMdo5d/uQmE5UGpNUGn9bluITQDKym/z+95yjRb6TIe19toC7AD/F/J0tXap4+DTOoHtiDM/QkKikPXzhSGoErtiRCDLUfqkn+vCHoO+sFJzgVzMvTrBmilEHgITEFYCus6IJRVrM4q+6DqNkYSAuDoj8A5RDX03aEkSRD+2v504YTW2P4eA78YHS2yMowFsvsMvSEyk/t13oNThe5Qr7Fpk1602Nuel46A2U1i7htOPSkw/tfQj+vuZfUlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a8566c-4026-415f-40bc-08dc947b33c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:26:45.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYfXGefsAJd4ydLsG6n22femS+xiwQbFoXs+CL+iPW6Z9HBer671SJiXWCmSWf+0qi5mjeruK5Yg4QQEDotw2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_15,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240147
X-Proofpoint-ORIG-GUID: Uh6Q6jrSeKVEFqBHrMpN149Xujuq2VQC
X-Proofpoint-GUID: Uh6Q6jrSeKVEFqBHrMpN149Xujuq2VQC

On Mon, Jun 24, 2024 at 12:27:27PM -0400, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
> 
> Add client support for bypassing NFS for localhost reads, writes, and
> commits. This is only useful when the client and the server are
> running on the same host.
> 
> nfs_local_probe() is stubbed out, later commits will enable client and
> server handshake via a Linux-only LOCALIO auxiliary RPC protocol.
> 
> This has dynamic binding with the nfsd module (via nfs_localio module
> which is part of nfs_common). Localio will only work if nfsd is
> already loaded.
> 
> The "localio_enabled" nfs kernel module parameter can be used to
> disable and enable the ability to use localio support.
> 
> Tracepoints were added for nfs_local_open_fh, nfs_local_enable and
> nfs_local_disable.
> 
> Also, pass the stored cl_nfssvc_net from the client to the server as
> first argument to nfsd_open_local_fh() to ensure the proper network
> namespace is used for localio.
> 
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/Makefile           |   1 +
>  fs/nfs/client.c           |   3 +
>  fs/nfs/inode.c            |   4 +
>  fs/nfs/internal.h         |  51 +++
>  fs/nfs/localio.c          | 654 ++++++++++++++++++++++++++++++++++++++
>  fs/nfs/nfstrace.h         |  61 ++++
>  fs/nfs/pagelist.c         |   3 +
>  fs/nfs/write.c            |   3 +

Hi Mike -

I'd prefer to see this patch split into two patches, one for the
NFS client, and one for the NFS server. The other patches in this
series seem to have a clear line between server and client
changes.

One or two more remarks below.

>  fs/nfsd/Makefile          |   1 +
>  fs/nfsd/filecache.c       |   2 +-
>  fs/nfsd/localio.c         | 244 ++++++++++++++
>  fs/nfsd/nfssvc.c          |   1 +
>  fs/nfsd/trace.h           |   3 +-
>  fs/nfsd/vfs.h             |   9 +
>  include/linux/nfs.h       |   2 +
>  include/linux/nfs_fs.h    |   2 +
>  include/linux/nfs_fs_sb.h |   1 +
>  17 files changed, 1043 insertions(+), 2 deletions(-)
>  create mode 100644 fs/nfs/localio.c
>  create mode 100644 fs/nfsd/localio.c
> 
> diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
> index 5f6db37f461e..9fb2f2cac87e 100644
> --- a/fs/nfs/Makefile
> +++ b/fs/nfs/Makefile
> @@ -13,6 +13,7 @@ nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
>  nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
>  nfs-$(CONFIG_SYSCTL)	+= sysctl.o
>  nfs-$(CONFIG_NFS_FSCACHE) += fscache.o
> +nfs-$(CONFIG_NFS_LOCALIO) += localio.o
>  
>  obj-$(CONFIG_NFS_V2) += nfsv2.o
>  nfsv2-y := nfs2super.o proc.o nfs2xdr.o
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index bcdf8d42cbc7..1300c388f971 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -241,6 +241,8 @@ static void pnfs_init_server(struct nfs_server *server)
>   */
>  void nfs_free_client(struct nfs_client *clp)
>  {
> +	nfs_local_disable(clp);
> +
>  	/* -EIO all pending I/O */
>  	if (!IS_ERR(clp->cl_rpcclient))
>  		rpc_shutdown_client(clp->cl_rpcclient);
> @@ -432,6 +434,7 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
>  			list_add_tail(&new->cl_share_link,
>  					&nn->nfs_client_list);
>  			spin_unlock(&nn->nfs_client_lock);
> +			nfs_local_probe(new);
>  			return rpc_ops->init_client(new, cl_init);
>  		}
>  
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index acef52ecb1bb..f9923cbf6058 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -39,6 +39,7 @@
>  #include <linux/slab.h>
>  #include <linux/compat.h>
>  #include <linux/freezer.h>
> +#include <linux/file.h>
>  #include <linux/uaccess.h>
>  #include <linux/iversion.h>
>  
> @@ -1053,6 +1054,7 @@ struct nfs_open_context *alloc_nfs_open_context(struct dentry *dentry,
>  	ctx->lock_context.open_context = ctx;
>  	INIT_LIST_HEAD(&ctx->list);
>  	ctx->mdsthreshold = NULL;
> +	ctx->local_filp = NULL;
>  	return ctx;
>  }
>  EXPORT_SYMBOL_GPL(alloc_nfs_open_context);
> @@ -1084,6 +1086,8 @@ static void __put_nfs_open_context(struct nfs_open_context *ctx, int is_sync)
>  	nfs_sb_deactive(sb);
>  	put_rpccred(rcu_dereference_protected(ctx->ll_cred, 1));
>  	kfree(ctx->mdsthreshold);
> +	if (!IS_ERR_OR_NULL(ctx->local_filp))
> +		fput(ctx->local_filp);
>  	kfree_rcu(ctx, rcu_head);
>  }
>  
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 958c8de072e2..d352040e3232 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -451,6 +451,57 @@ extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
>  extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
>  extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
>  
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +/* localio.c */
> +extern void nfs_local_disable(struct nfs_client *);
> +extern void nfs_local_probe(struct nfs_client *);
> +extern struct file *nfs_local_open_fh(struct nfs_client *, const struct cred *,
> +				      struct nfs_fh *, const fmode_t);
> +extern struct file *nfs_local_file_open(struct nfs_client *clp,
> +					const struct cred *cred,
> +					struct nfs_fh *fh,
> +					struct nfs_open_context *ctx);
> +extern int nfs_local_doio(struct nfs_client *, struct file *,
> +			  struct nfs_pgio_header *,
> +			  const struct rpc_call_ops *);
> +extern int nfs_local_commit(struct file *, struct nfs_commit_data *,
> +			    const struct rpc_call_ops *, int);
> +extern bool nfs_server_is_local(const struct nfs_client *clp);
> +
> +#else
> +static inline void nfs_local_disable(struct nfs_client *clp) {}
> +static inline void nfs_local_probe(struct nfs_client *clp) {}
> +static inline struct file *nfs_local_open_fh(struct nfs_client *clp,
> +					const struct cred *cred,
> +					struct nfs_fh *fh,
> +					const fmode_t mode)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +static inline struct file *nfs_local_file_open(struct nfs_client *clp,
> +					const struct cred *cred,
> +					struct nfs_fh *fh,
> +					struct nfs_open_context *ctx)
> +{
> +	return NULL;
> +}
> +static inline int nfs_local_doio(struct nfs_client *clp, struct file *filep,
> +				struct nfs_pgio_header *hdr,
> +				const struct rpc_call_ops *call_ops)
> +{
> +	return -EINVAL;
> +}
> +static inline int nfs_local_commit(struct file *filep, struct nfs_commit_data *data,
> +				const struct rpc_call_ops *call_ops, int how)
> +{
> +	return -EINVAL;
> +}
> +static inline bool nfs_server_is_local(const struct nfs_client *clp)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_NFS_LOCALIO */
> +
>  /* super.c */
>  extern const struct super_operations nfs_sops;
>  bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> new file mode 100644
> index 000000000000..724e81716b16
> --- /dev/null
> +++ b/fs/nfs/localio.c
> @@ -0,0 +1,654 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NFS client support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/vfs.h>
> +#include <linux/file.h>
> +#include <linux/inet.h>
> +#include <linux/sunrpc/addr.h>
> +#include <linux/inetdevice.h>
> +#include <net/addrconf.h>
> +#include <linux/module.h>
> +#include <linux/bvec.h>
> +
> +#include <linux/nfs.h>
> +#include <linux/nfs_fs.h>
> +#include <linux/nfs_xdr.h>
> +
> +#include "internal.h"
> +#include "pnfs.h"
> +#include "nfstrace.h"
> +
> +#define NFSDBG_FACILITY		NFSDBG_VFS
> +
> +struct nfs_local_kiocb {
> +	struct kiocb		kiocb;
> +	struct bio_vec		*bvec;
> +	struct nfs_pgio_header	*hdr;
> +	struct work_struct	work;
> +};
> +
> +struct nfs_local_fsync_ctx {
> +	struct file		*filp;
> +	struct nfs_commit_data	*data;
> +	struct work_struct	work;
> +	struct kref		kref;
> +	struct completion	*done;
> +};
> +static void nfs_local_fsync_work(struct work_struct *work);
> +
> +/*
> + * We need to translate between nfs status return values and
> + * the local errno values which may not be the same.
> + */
> +static struct {
> +	__u32 stat;
> +	int errno;
> +} nfs_errtbl[] = {
> +	{ NFS4_OK,		0		},
> +	{ NFS4ERR_PERM,		-EPERM		},
> +	{ NFS4ERR_NOENT,	-ENOENT		},
> +	{ NFS4ERR_IO,		-EIO		},
> +	{ NFS4ERR_NXIO,		-ENXIO		},
> +	{ NFS4ERR_FBIG,		-E2BIG		},
> +	{ NFS4ERR_STALE,	-EBADF		},
> +	{ NFS4ERR_ACCESS,	-EACCES		},
> +	{ NFS4ERR_EXIST,	-EEXIST		},
> +	{ NFS4ERR_XDEV,		-EXDEV		},
> +	{ NFS4ERR_MLINK,	-EMLINK		},
> +	{ NFS4ERR_NOTDIR,	-ENOTDIR	},
> +	{ NFS4ERR_ISDIR,	-EISDIR		},
> +	{ NFS4ERR_INVAL,	-EINVAL		},
> +	{ NFS4ERR_FBIG,		-EFBIG		},
> +	{ NFS4ERR_NOSPC,	-ENOSPC		},
> +	{ NFS4ERR_ROFS,		-EROFS		},
> +	{ NFS4ERR_NAMETOOLONG,	-ENAMETOOLONG	},
> +	{ NFS4ERR_NOTEMPTY,	-ENOTEMPTY	},
> +	{ NFS4ERR_DQUOT,	-EDQUOT		},
> +	{ NFS4ERR_STALE,	-ESTALE		},
> +	{ NFS4ERR_STALE,	-EOPENSTALE	},
> +	{ NFS4ERR_DELAY,	-ETIMEDOUT	},
> +	{ NFS4ERR_DELAY,	-ERESTARTSYS	},
> +	{ NFS4ERR_DELAY,	-EAGAIN		},
> +	{ NFS4ERR_DELAY,	-ENOMEM		},
> +	{ NFS4ERR_IO,		-ETXTBSY	},
> +	{ NFS4ERR_IO,		-EBUSY		},
> +	{ NFS4ERR_BADHANDLE,	-EBADHANDLE	},
> +	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
> +	{ NFS4ERR_NOTSUPP,	-EOPNOTSUPP	},
> +	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
> +	{ NFS4ERR_SERVERFAULT,	-ESERVERFAULT	},
> +	{ NFS4ERR_SERVERFAULT,	-ENFILE		},
> +	{ NFS4ERR_IO,		-EREMOTEIO	},
> +	{ NFS4ERR_IO,		-EUCLEAN	},
> +	{ NFS4ERR_PERM,		-ENOKEY		},
> +	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
> +	{ NFS4ERR_SYMLINK,	-ELOOP		},
> +	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
> +};
> +
> +/*
> + * Convert an NFS error code to a local one.
> + * This one is used jointly by NFSv2 and NFSv3.
> + */
> +static __u32
> +nfs4errno(int errno)
> +{
> +	unsigned int i;
> +	for (i = 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
> +		if (nfs_errtbl[i].errno == errno)
> +			return nfs_errtbl[i].stat;
> +	}
> +	/* If we cannot translate the error, the recovery routines should
> +	 * handle it.
> +	 * Note: remaining NFSv4 error codes have values > 10000, so should
> +	 * not conflict with native Linux error codes.
> +	 */
> +	return NFS4ERR_SERVERFAULT;
> +}
> +
> +static bool localio_enabled __read_mostly = true;
> +module_param(localio_enabled, bool, 0644);
> +
> +bool nfs_server_is_local(const struct nfs_client *clp)
> +{
> +	return test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags) != 0 &&
> +		localio_enabled;
> +}
> +EXPORT_SYMBOL_GPL(nfs_server_is_local);
> +
> +/*
> + * nfs_local_enable - attempt to enable local i/o for an nfs_client
> + */
> +static void nfs_local_enable(struct nfs_client *clp, struct net *net)
> +{
> +	if (READ_ONCE(clp->nfsd_open_local_fh)) {
> +		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> +		clp->cl_nfssvc_net = net;
> +		trace_nfs_local_enable(clp);
> +	}
> +}
> +
> +/*
> + * nfs_local_disable - disable local i/o for an nfs_client
> + */
> +void nfs_local_disable(struct nfs_client *clp)
> +{
> +	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> +		trace_nfs_local_disable(clp);
> +		clp->cl_nfssvc_net = NULL;
> +	}
> +}
> +
> +/*
> + * nfs_local_probe - probe local i/o support for an nfs_client
> + */
> +void
> +nfs_local_probe(struct nfs_client *clp)
> +{
> +	bool enable = false;
> +
> +	if (enable)
> +		nfs_local_enable(clp);
> +}
> +EXPORT_SYMBOL_GPL(nfs_local_probe);
> +
> +/*
> + * nfs_local_open_fh - open a local filehandle
> + *
> + * Returns a pointer to a struct file or an ERR_PTR
> + */
> +struct file *
> +nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> +		  struct nfs_fh *fh, const fmode_t mode)
> +{
> +	struct file *filp;
> +	int status;
> +
> +	if (mode & ~(FMODE_READ | FMODE_WRITE))
> +		return ERR_PTR(-EINVAL);
> +
> +	status = clp->nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_rpcclient,
> +					cred, fh, mode, &filp);
> +	if (status < 0) {
> +		dprintk("%s: open local file failed error=%d\n",
> +				__func__, status);
> +		trace_nfs_local_open_fh(fh, mode, status);
> +		switch (status) {
> +		case -ENXIO:
> +			nfs_local_disable(clp);
> +			fallthrough;
> +		case -ETIMEDOUT:
> +			status = -EAGAIN;
> +		}
> +		filp = ERR_PTR(status);
> +	}
> +	return filp;
> +}
> +EXPORT_SYMBOL_GPL(nfs_local_open_fh);
> +
> +static struct bio_vec *
> +nfs_bvec_alloc_and_import_pagevec(struct page **pagevec,
> +		unsigned int npages, gfp_t flags)
> +{
> +	struct bio_vec *bvec, *p;
> +
> +	bvec = kmalloc_array(npages, sizeof(*bvec), flags);
> +	if (bvec != NULL) {
> +		for (p = bvec; npages > 0; p++, pagevec++, npages--) {
> +			p->bv_page = *pagevec;
> +			p->bv_len = PAGE_SIZE;
> +			p->bv_offset = 0;
> +		}
> +	}
> +	return bvec;
> +}
> +
> +static void
> +nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
> +{
> +	kfree(iocb->bvec);
> +	kfree(iocb);
> +}
> +
> +static struct nfs_local_kiocb *
> +nfs_local_iocb_alloc(struct nfs_pgio_header *hdr, struct file *filp,
> +		gfp_t flags)
> +{
> +	struct nfs_local_kiocb *iocb;
> +
> +	iocb = kmalloc(sizeof(*iocb), flags);
> +	if (iocb == NULL)
> +		return NULL;
> +	iocb->bvec = nfs_bvec_alloc_and_import_pagevec(hdr->page_array.pagevec,
> +			hdr->page_array.npages, flags);
> +	if (iocb->bvec == NULL) {
> +		kfree(iocb);
> +		return NULL;
> +	}
> +	init_sync_kiocb(&iocb->kiocb, filp);
> +	iocb->kiocb.ki_pos = hdr->args.offset;
> +	iocb->hdr = hdr;
> +	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
> +	return iocb;
> +}
> +
> +static void
> +nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
> +{
> +	struct nfs_pgio_header *hdr = iocb->hdr;
> +
> +	iov_iter_bvec(i, dir, iocb->bvec, hdr->page_array.npages,
> +		      hdr->args.count + hdr->args.pgbase);
> +	if (hdr->args.pgbase != 0)
> +		iov_iter_advance(i, hdr->args.pgbase);
> +}
> +
> +static void
> +nfs_local_hdr_release(struct nfs_pgio_header *hdr,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	call_ops->rpc_call_done(&hdr->task, hdr);
> +	call_ops->rpc_release(hdr);
> +}
> +
> +static void
> +nfs_local_pgio_init(struct nfs_pgio_header *hdr,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	hdr->task.tk_ops = call_ops;
> +	if (!hdr->task.tk_start)
> +		hdr->task.tk_start = ktime_get();
> +}
> +
> +static void
> +nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
> +{
> +	if (status >= 0) {
> +		hdr->res.count = status;
> +		hdr->res.op_status = NFS4_OK;
> +		hdr->task.tk_status = 0;
> +	} else {
> +		hdr->res.op_status = nfs4errno(status);
> +		hdr->task.tk_status = status;
> +	}
> +}
> +
> +static void
> +nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
> +{
> +	struct nfs_pgio_header *hdr = iocb->hdr;
> +
> +	fput(iocb->kiocb.ki_filp);
> +	nfs_local_iocb_free(iocb);
> +	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
> +}
> +
> +static void
> +nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
> +{
> +	struct nfs_pgio_header *hdr = iocb->hdr;
> +	struct file *filp = iocb->kiocb.ki_filp;
> +
> +	nfs_local_pgio_done(hdr, status);
> +
> +	if (hdr->res.count != hdr->args.count ||
> +	    hdr->args.offset + hdr->res.count >= i_size_read(file_inode(filp)))
> +		hdr->res.eof = true;
> +
> +	dprintk("%s: read %ld bytes eof %d.\n", __func__,
> +			status > 0 ? status : 0, hdr->res.eof);
> +}
> +
> +static int
> +nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	struct nfs_local_kiocb *iocb;
> +	struct iov_iter iter;
> +	ssize_t status;
> +
> +	dprintk("%s: vfs_read count=%u pos=%llu\n",
> +		__func__, hdr->args.count, hdr->args.offset);
> +
> +	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_KERNEL);
> +	if (iocb == NULL)
> +		return -ENOMEM;
> +	nfs_local_iter_init(&iter, iocb, READ);
> +
> +	nfs_local_pgio_init(hdr, call_ops);
> +	hdr->res.eof = false;
> +
> +	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
> +	if (status != -EIOCBQUEUED) {
> +		nfs_local_read_done(iocb, status);
> +		nfs_local_pgio_release(iocb);
> +	}
> +	return 0;
> +}
> +
> +static void
> +nfs_copy_boot_verifier(struct nfs_write_verifier *verifier, struct inode *inode)
> +{
> +	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
> +	u32 *verf = (u32 *)verifier->data;
> +	int seq = 0;
> +
> +	do {
> +		read_seqbegin_or_lock(&clp->cl_boot_lock, &seq);
> +		verf[0] = (u32)clp->cl_nfssvc_boot.tv_sec;
> +		verf[1] = (u32)clp->cl_nfssvc_boot.tv_nsec;
> +	} while (need_seqretry(&clp->cl_boot_lock, seq));
> +	done_seqretry(&clp->cl_boot_lock, seq);
> +}
> +
> +static void
> +nfs_reset_boot_verifier(struct inode *inode)
> +{
> +	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
> +
> +	write_seqlock(&clp->cl_boot_lock);
> +	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
> +	write_sequnlock(&clp->cl_boot_lock);
> +}
> +
> +static void
> +nfs_set_local_verifier(struct inode *inode,
> +		struct nfs_writeverf *verf,
> +		enum nfs3_stable_how how)
> +{
> +
> +	nfs_copy_boot_verifier(&verf->verifier, inode);
> +	verf->committed = how;
> +}
> +
> +static void
> +nfs_get_vfs_attr(struct file *filp, struct nfs_fattr *fattr)
> +{
> +	struct kstat stat;
> +
> +	if (fattr != NULL && vfs_getattr(&filp->f_path, &stat,
> +					 STATX_INO |
> +					 STATX_ATIME |
> +					 STATX_MTIME |
> +					 STATX_CTIME |
> +					 STATX_SIZE |
> +					 STATX_BLOCKS,
> +					 AT_STATX_SYNC_AS_STAT) == 0) {
> +		fattr->valid = NFS_ATTR_FATTR_FILEID |
> +			NFS_ATTR_FATTR_CHANGE |
> +			NFS_ATTR_FATTR_SIZE |
> +			NFS_ATTR_FATTR_ATIME |
> +			NFS_ATTR_FATTR_MTIME |
> +			NFS_ATTR_FATTR_CTIME |
> +			NFS_ATTR_FATTR_SPACE_USED;
> +		fattr->fileid = stat.ino;
> +		fattr->size = stat.size;
> +		fattr->atime = stat.atime;
> +		fattr->mtime = stat.mtime;
> +		fattr->ctime = stat.ctime;
> +		fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
> +		fattr->du.nfs3.used = stat.blocks << 9;
> +	}
> +}
> +
> +static void
> +nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
> +{
> +	struct nfs_pgio_header *hdr = iocb->hdr;
> +
> +	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
> +
> +	/* Handle short writes as if they are ENOSPC */
> +	if (status > 0 && status < hdr->args.count) {
> +		hdr->mds_offset += status;
> +		hdr->args.offset += status;
> +		hdr->args.pgbase += status;
> +		hdr->args.count -= status;
> +		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
> +		status = -ENOSPC;
> +	}
> +	if (status < 0)
> +		nfs_reset_boot_verifier(hdr->inode);
> +	nfs_local_pgio_done(hdr, status);
> +}
> +
> +static int
> +nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	struct nfs_local_kiocb *iocb;
> +	struct iov_iter iter;
> +	ssize_t status;
> +
> +	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
> +		__func__, hdr->args.count, hdr->args.offset,
> +		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
> +
> +	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
> +	if (iocb == NULL)
> +		return -ENOMEM;
> +	nfs_local_iter_init(&iter, iocb, WRITE);
> +
> +	switch (hdr->args.stable) {
> +	default:
> +		break;
> +	case NFS_DATA_SYNC:
> +		iocb->kiocb.ki_flags |= IOCB_DSYNC;
> +		break;
> +	case NFS_FILE_SYNC:
> +		iocb->kiocb.ki_flags |= IOCB_DSYNC|IOCB_SYNC;
> +	}
> +	nfs_local_pgio_init(hdr, call_ops);
> +
> +	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
> +
> +	file_start_write(filp);
> +	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
> +	file_end_write(filp);
> +	if (status != -EIOCBQUEUED) {
> +		nfs_local_write_done(iocb, status);
> +		nfs_get_vfs_attr(filp, hdr->res.fattr);
> +		nfs_local_pgio_release(iocb);
> +	}
> +	return 0;
> +}
> +
> +static struct file *
> +nfs_local_file_open_cached(struct nfs_client *clp, const struct cred *cred,
> +			   struct nfs_fh *fh, struct nfs_open_context *ctx)
> +{
> +	struct file *filp = ctx->local_filp;
> +
> +	if (!filp) {
> +		struct file *new = nfs_local_open_fh(clp, cred, fh, ctx->mode);
> +		if (IS_ERR_OR_NULL(new))
> +			return NULL;
> +		/* try to put this one in the slot */
> +		filp = cmpxchg(&ctx->local_filp, NULL, new);
> +		if (filp != NULL)
> +			fput(new);
> +		else
> +			filp = new;
> +	}
> +	return get_file(filp);
> +}
> +
> +struct file *
> +nfs_local_file_open(struct nfs_client *clp, const struct cred *cred,
> +		    struct nfs_fh *fh, struct nfs_open_context *ctx)
> +{
> +	if (!nfs_server_is_local(clp))
> +		return NULL;
> +	return nfs_local_file_open_cached(clp, cred, fh, ctx);
> +}
> +
> +int
> +nfs_local_doio(struct nfs_client *clp, struct file *filp,
> +	       struct nfs_pgio_header *hdr,
> +	       const struct rpc_call_ops *call_ops)
> +{
> +	int status = 0;
> +
> +	if (!hdr->args.count)
> +		goto out_fput;
> +	/* Don't support filesystems without read_iter/write_iter */
> +	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
> +		nfs_local_disable(clp);
> +		status = -EAGAIN;
> +		goto out_fput;
> +	}
> +
> +	switch (hdr->rw_mode) {
> +	case FMODE_READ:
> +		status = nfs_do_local_read(hdr, filp, call_ops);
> +		break;
> +	case FMODE_WRITE:
> +		status = nfs_do_local_write(hdr, filp, call_ops);
> +		break;
> +	default:
> +		dprintk("%s: invalid mode: %d\n", __func__,
> +			hdr->rw_mode);
> +		status = -EINVAL;
> +	}
> +out_fput:
> +	if (status != 0) {
> +		fput(filp);
> +		hdr->task.tk_status = status;
> +		nfs_local_hdr_release(hdr, call_ops);
> +	}
> +	return status;
> +}
> +
> +static void
> +nfs_local_init_commit(struct nfs_commit_data *data,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	data->task.tk_ops = call_ops;
> +}
> +
> +static int
> +nfs_local_run_commit(struct file *filp, struct nfs_commit_data *data)
> +{
> +	loff_t start = data->args.offset;
> +	loff_t end = LLONG_MAX;
> +
> +	if (data->args.count > 0) {
> +		end = start + data->args.count - 1;
> +		if (end < start)
> +			end = LLONG_MAX;
> +	}
> +
> +	dprintk("%s: commit %llu - %llu\n", __func__, start, end);
> +	return vfs_fsync_range(filp, start, end, 0);
> +}
> +
> +static void
> +nfs_local_commit_done(struct nfs_commit_data *data, int status)
> +{
> +	if (status >= 0) {
> +		nfs_set_local_verifier(data->inode,
> +				data->res.verf,
> +				NFS_FILE_SYNC);
> +		data->res.op_status = NFS4_OK;
> +		data->task.tk_status = 0;
> +	} else {
> +		nfs_reset_boot_verifier(data->inode);
> +		data->res.op_status = nfs4errno(status);
> +		data->task.tk_status = status;
> +	}
> +}
> +
> +static void
> +nfs_local_release_commit_data(struct file *filp,
> +		struct nfs_commit_data *data,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	fput(filp);
> +	call_ops->rpc_call_done(&data->task, data);
> +	call_ops->rpc_release(data);
> +}
> +
> +static struct nfs_local_fsync_ctx *
> +nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data, struct file *filp,
> +		gfp_t flags)
> +{
> +	struct nfs_local_fsync_ctx *ctx = kmalloc(sizeof(*ctx), flags);
> +
> +	if (ctx != NULL) {
> +		ctx->filp = filp;
> +		ctx->data = data;
> +		INIT_WORK(&ctx->work, nfs_local_fsync_work);
> +		kref_init(&ctx->kref);
> +		ctx->done = NULL;
> +	}
> +	return ctx;
> +}
> +
> +static void
> +nfs_local_fsync_ctx_kref_free(struct kref *kref)
> +{
> +	kfree(container_of(kref, struct nfs_local_fsync_ctx, kref));
> +}
> +
> +static void
> +nfs_local_fsync_ctx_put(struct nfs_local_fsync_ctx *ctx)
> +{
> +	kref_put(&ctx->kref, nfs_local_fsync_ctx_kref_free);
> +}
> +
> +static void
> +nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
> +{
> +	nfs_local_release_commit_data(ctx->filp, ctx->data,
> +			ctx->data->task.tk_ops);
> +	nfs_local_fsync_ctx_put(ctx);
> +}
> +
> +static void
> +nfs_local_fsync_work(struct work_struct *work)
> +{
> +	struct nfs_local_fsync_ctx *ctx;
> +	int status;
> +
> +	ctx = container_of(work, struct nfs_local_fsync_ctx, work);
> +
> +	status = nfs_local_run_commit(ctx->filp, ctx->data);
> +	nfs_local_commit_done(ctx->data, status);
> +	if (ctx->done != NULL)
> +		complete(ctx->done);
> +	nfs_local_fsync_ctx_free(ctx);
> +}
> +
> +int
> +nfs_local_commit(struct file *filp, struct nfs_commit_data *data,
> +		 const struct rpc_call_ops *call_ops, int how)
> +{
> +	struct nfs_local_fsync_ctx *ctx;
> +
> +	ctx = nfs_local_fsync_ctx_alloc(data, filp, GFP_KERNEL);
> +	if (!ctx) {
> +		nfs_local_commit_done(data, -ENOMEM);
> +		nfs_local_release_commit_data(filp, data, call_ops);
> +		return -ENOMEM;
> +	}
> +
> +	nfs_local_init_commit(data, call_ops);
> +	kref_get(&ctx->kref);
> +	if (how & FLUSH_SYNC) {
> +		DECLARE_COMPLETION_ONSTACK(done);
> +		ctx->done = &done;
> +		queue_work(nfsiod_workqueue, &ctx->work);
> +		wait_for_completion(&done);
> +	} else
> +		queue_work(nfsiod_workqueue, &ctx->work);
> +	nfs_local_fsync_ctx_put(ctx);
> +	return 0;
> +}
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 1e710654af11..95a2c19a9172 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -1681,6 +1681,67 @@ TRACE_EVENT(nfs_mount_path,
>  	TP_printk("path='%s'", __get_str(path))
>  );
>  
> +TRACE_EVENT(nfs_local_open_fh,
> +		TP_PROTO(
> +			const struct nfs_fh *fh,
> +			fmode_t fmode,
> +			int error
> +		),
> +
> +		TP_ARGS(fh, fmode, error),
> +
> +		TP_STRUCT__entry(
> +			__field(int, error)
> +			__field(u32, fhandle)
> +			__field(unsigned int, fmode)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->error = error;
> +			__entry->fhandle = nfs_fhandle_hash(fh);
> +			__entry->fmode = (__force unsigned int)fmode;
> +		),
> +
> +		TP_printk(
> +			"error=%d fhandle=0x%08x mode=%s",
> +			__entry->error,
> +			__entry->fhandle,
> +			show_fs_fmode_flags(__entry->fmode)
> +		)
> +);
> +
> +DECLARE_EVENT_CLASS(nfs_local_client_event,
> +		TP_PROTO(
> +			const struct nfs_client *clp
> +		),
> +
> +		TP_ARGS(clp),
> +
> +		TP_STRUCT__entry(
> +			__field(unsigned int, protocol)
> +			__string(server, clp->cl_hostname)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->protocol = clp->rpc_ops->version;
> +			__assign_str(server);
> +		),
> +
> +		TP_printk(
> +			"server=%s NFSv%u", __get_str(server), __entry->protocol
> +		)
> +);
> +
> +#define DEFINE_NFS_LOCAL_CLIENT_EVENT(name) \
> +	DEFINE_EVENT(nfs_local_client_event, name, \
> +			TP_PROTO( \
> +				const struct nfs_client *clp \
> +			), \
> +			TP_ARGS(clp))
> +
> +DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_enable);
> +DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_disable);
> +
>  DECLARE_EVENT_CLASS(nfs_xdr_event,
>  		TP_PROTO(
>  			const struct xdr_stream *xdr,
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 57d62db3be5b..b08420b8e664 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -879,6 +879,9 @@ int nfs_initiate_pgio(struct nfs_pageio_descriptor *desc,
>  		hdr->args.count,
>  		(unsigned long long)hdr->args.offset);
>  
> +	if (localio)
> +		return nfs_local_doio(clp, localio, hdr, call_ops);
> +
>  	task = rpc_run_task(&task_setup_data);
>  	if (IS_ERR(task))
>  		return PTR_ERR(task);
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 267bed2a4ceb..b29b0fd5431f 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1700,6 +1700,9 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
>  
>  	dprintk("NFS: initiated commit call\n");
>  
> +	if (localio)
> +		return nfs_local_commit(localio, data, call_ops, how);
> +
>  	task = rpc_run_task(&task_setup_data);
>  	if (IS_ERR(task))
>  		return PTR_ERR(task);
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..78b421778a79 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
>  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> +nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ad9083ca144b..99631fa56662 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -52,7 +52,7 @@
>  #define NFSD_FILE_CACHE_UP		     (0)
>  
>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
>  
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> new file mode 100644
> index 000000000000..e9aa0997f898
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NFS server support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/exportfs.h>
> +#include <linux/sunrpc/svcauth_gss.h>
> +#include <linux/sunrpc/clnt.h>
> +#include <linux/nfs.h>
> +#include <linux/string.h>
> +
> +#include "nfsd.h"
> +#include "vfs.h"
> +#include "netns.h"
> +#include "filecache.h"
> +
> +#define NFSDDBG_FACILITY		NFSDDBG_FH

I think I'd rather prefer to see trace points in here rather than
new dprintk call sites. In any event, perhaps NFSDDBG_FH is not
especially appropriate?


> +
> +/*
> + * We need to translate between nfs status return values and
> + * the local errno values which may not be the same.
> + * - duplicated from fs/nfs/nfs2xdr.c to avoid needless bloat of
> + *   all compiled nfs objects if it were in include/linux/nfs.h
> + */
> +static const struct {
> +	int stat;
> +	int errno;
> +} nfs_common_errtbl[] = {
> +	{ NFS_OK,		0		},
> +	{ NFSERR_PERM,		-EPERM		},
> +	{ NFSERR_NOENT,		-ENOENT		},
> +	{ NFSERR_IO,		-EIO		},
> +	{ NFSERR_NXIO,		-ENXIO		},
> +/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> +	{ NFSERR_ACCES,		-EACCES		},
> +	{ NFSERR_EXIST,		-EEXIST		},
> +	{ NFSERR_XDEV,		-EXDEV		},
> +	{ NFSERR_NODEV,		-ENODEV		},
> +	{ NFSERR_NOTDIR,	-ENOTDIR	},
> +	{ NFSERR_ISDIR,		-EISDIR		},
> +	{ NFSERR_INVAL,		-EINVAL		},
> +	{ NFSERR_FBIG,		-EFBIG		},
> +	{ NFSERR_NOSPC,		-ENOSPC		},
> +	{ NFSERR_ROFS,		-EROFS		},
> +	{ NFSERR_MLINK,		-EMLINK		},
> +	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> +	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> +	{ NFSERR_DQUOT,		-EDQUOT		},
> +	{ NFSERR_STALE,		-ESTALE		},
> +	{ NFSERR_REMOTE,	-EREMOTE	},
> +#ifdef EWFLUSH
> +	{ NFSERR_WFLUSH,	-EWFLUSH	},
> +#endif
> +	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> +	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> +	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> +	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> +	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> +	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> +	{ NFSERR_BADTYPE,	-EBADTYPE	},
> +	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> +	{ -1,			-EIO		}
> +};
> +
> +/**
> + * nfs_stat_to_errno - convert an NFS status code to a local errno
> + * @status: NFS status code to convert
> + *
> + * Returns a local errno value, or -EIO if the NFS status code is
> + * not recognized.  This function is used jointly by NFSv2 and NFSv3.
> + */
> +static int nfs_stat_to_errno(enum nfs_stat status)
> +{
> +	int i;
> +
> +	for (i = 0; nfs_common_errtbl[i].stat != -1; i++) {
> +		if (nfs_common_errtbl[i].stat == (int)status)
> +			return nfs_common_errtbl[i].errno;
> +	}
> +	return nfs_common_errtbl[i].errno;
> +}

I get it: The existing nfserrno() function on the server is the
reverse mapping from this one, and you need to undo the nfsstat
returned from nfsd_file_acquire().

The documenting comments here confusing in the context of why this
function is necessary on the server. For example, "This function is
used jointly by NFSv2 and NFSv3"... Maybe instead, explain that
nfsd_file_acquire() returns an nfsstat that needs to be translated
to an errno before being returned to a local client application.


> +static void
> +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> +{
> +	if (rqstp->rq_client)
> +		auth_domain_put(rqstp->rq_client);
> +	if (rqstp->rq_cred.cr_group_info)
> +		put_group_info(rqstp->rq_cred.cr_group_info);
> +	/* rpcauth_map_to_svc_cred_local() clears cr_principal */
> +	WARN_ON_ONCE(rqstp->rq_cred.cr_principal != NULL);
> +	kfree(rqstp->rq_xprt);
> +	kfree(rqstp);
> +}
> +
> +static struct svc_rqst *
> +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> +			const struct cred *cred)
> +{
> +	struct svc_rqst *rqstp;
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	int status;
> +
> +	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */

What's your plan for addressing this FIXME?


> +	if (unlikely(!READ_ONCE(nn->nfsd_serv))) {
> +		dprintk("%s: localio denied. Server not running\n", __func__);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
> +	if (!rqstp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rqstp->rq_xprt = kzalloc(sizeof(*rqstp->rq_xprt), GFP_KERNEL);
> +	if (!rqstp->rq_xprt) {
> +		status = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	rqstp->rq_xprt->xpt_net = net;
> +	__set_bit(RQ_SECURE, &rqstp->rq_flags);
> +	rqstp->rq_proc = 1;
> +	rqstp->rq_vers = 3;
> +	rqstp->rq_prot = IPPROTO_TCP;
> +	rqstp->rq_server = nn->nfsd_serv;
> +
> +	/* Note: we're connecting to ourself, so source addr == peer addr */
> +	rqstp->rq_addrlen = rpc_peeraddr(rpc_clnt,
> +			(struct sockaddr *)&rqstp->rq_addr,
> +			sizeof(rqstp->rq_addr));
> +
> +	rpcauth_map_to_svc_cred_local(rpc_clnt->cl_auth, cred, &rqstp->rq_cred);
> +
> +	/*
> +	 * set up enough for svcauth_unix_set_client to be able to wait
> +	 * for the cache downcall. Note that we do _not_ want to allow the
> +	 * request to be deferred for later revisit since this rqst and xprt
> +	 * are not set up to run inside of the normal svc_rqst engine.
> +	 */
> +	INIT_LIST_HEAD(&rqstp->rq_xprt->xpt_deferred);
> +	kref_init(&rqstp->rq_xprt->xpt_ref);
> +	spin_lock_init(&rqstp->rq_xprt->xpt_lock);
> +	rqstp->rq_chandle.thread_wait = 5 * HZ;
> +
> +	status = svcauth_unix_set_client(rqstp);
> +	switch (status) {
> +	case SVC_OK:
> +		break;
> +	case SVC_DENIED:
> +		status = -ENXIO;
> +		dprintk("%s: client %pISpc denied localio access\n",
> +				__func__, (struct sockaddr *)&rqstp->rq_addr);
> +		goto out_err;
> +	default:
> +		status = -ETIMEDOUT;
> +		dprintk("%s: client %pISpc temporarily denied localio access\n",
> +				__func__, (struct sockaddr *)&rqstp->rq_addr);
> +		goto out_err;
> +	}
> +
> +	return rqstp;
> +
> +out_err:
> +	nfsd_local_fakerqst_destroy(rqstp);
> +	return ERR_PTR(status);
> +}
> +
> +/*
> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @file
> + *
> + * This function maps a local fh to a path on a local filesystem.
> + * This is useful when the nfs client has the local server mounted - it can
> + * avoid all the NFS overhead with reads, writes and commits.
> + *
> + * on successful return, caller is responsible for calling path_put. Also
> + * note that this is called from nfs.ko via find_symbol() to avoid an explicit
> + * dependency on knfsd. So, there is no forward declaration in a header file
> + * for it.
> + */
> +int nfsd_open_local_fh(struct net *net,
> +			 struct rpc_clnt *rpc_clnt,
> +			 const struct cred *cred,
> +			 const struct nfs_fh *nfs_fh,
> +			 const fmode_t fmode,
> +			 struct file **pfilp)
> +{
> +	const struct cred *save_cred;
> +	struct svc_rqst *rqstp;
> +	struct svc_fh fh;
> +	struct nfsd_file *nf;
> +	int status = 0;
> +	int mayflags = NFSD_MAY_LOCALIO;
> +	__be32 beres;
> +
> +	/* Save creds before calling into nfsd */
> +	save_cred = get_current_cred();
> +
> +	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred);
> +	if (IS_ERR(rqstp)) {
> +		status = PTR_ERR(rqstp);
> +		goto out_revertcred;
> +	}
> +
> +	/* nfs_fh -> svc_fh */
> +	if (nfs_fh->size > NFS4_FHSIZE) {
> +		status = -EINVAL;
> +		goto out;
> +	}
> +	fh_init(&fh, NFS4_FHSIZE);
> +	fh.fh_handle.fh_size = nfs_fh->size;
> +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> +
> +	if (fmode & FMODE_READ)
> +		mayflags |= NFSD_MAY_READ;
> +	if (fmode & FMODE_WRITE)
> +		mayflags |= NFSD_MAY_WRITE;
> +
> +	beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> +	if (beres) {
> +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> +		dprintk("%s: fh_verify failed %d\n", __func__, status);
> +		goto out_fh_put;
> +	}
> +
> +	*pfilp = get_file(nf->nf_file);
> +
> +	nfsd_file_put(nf);
> +out_fh_put:
> +	fh_put(&fh);
> +
> +out:
> +	nfsd_local_fakerqst_destroy(rqstp);
> +out_revertcred:
> +	revert_creds(save_cred);
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 1222a0a33fe1..a477d2c5088a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -431,6 +431,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
>  #endif
>  #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
>  	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
> +	nn->nfsd_uuid.net = net;
>  	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
>  #endif
>  	nn->nfsd_net_up = true;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 77bbd23aa150..9c0610fdd11c 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
>  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
>  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
>  
>  TRACE_EVENT(nfsd_compound,
>  	TP_PROTO(
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 57cd70062048..af07bb146e81 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -36,6 +36,8 @@
>  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
>  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
>  
> +#define NFSD_MAY_LOCALIO		0x800000
> +

Nit: I'd prefer to see NFSD_MAY_LOCALIO inserted just after
NFSD_MAY_64BIT_COOKIE. Is there a reason the value of the new flag
should not be 0x2000 ?


>  struct nfsd_file;
>  
>  /*
> @@ -158,6 +160,13 @@ __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
>  
>  void		nfsd_filp_close(struct file *fp);
>  
> +int		nfsd_open_local_fh(struct net *net,
> +				   struct rpc_clnt *rpc_clnt,
> +				   const struct cred *cred,
> +				   const struct nfs_fh *nfs_fh,
> +				   const fmode_t fmode,
> +				   struct file **pfilp);
> +
>  static inline int fh_want_write(struct svc_fh *fh)
>  {
>  	int ret;
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index ceb70a926b95..64ed672a0b34 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -8,6 +8,8 @@
>  #ifndef _LINUX_NFS_H
>  #define _LINUX_NFS_H
>  
> +#include <linux/cred.h>
> +#include <linux/sunrpc/auth.h>
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/string.h>
>  #include <linux/crc32.h>
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 039898d70954..a0bb947fdd1d 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -96,6 +96,8 @@ struct nfs_open_context {
>  	struct list_head list;
>  	struct nfs4_threshold	*mdsthreshold;
>  	struct rcu_head	rcu_head;
> +
> +	struct file *local_filp;
>  };
>  
>  struct nfs_open_dir_context {
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index e58e706a6503..4290c550a049 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -50,6 +50,7 @@ struct nfs_client {
>  #define NFS_CS_DS		7		/* - Server is a DS */
>  #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
>  #define NFS_CS_PNFS		9		/* - Server used for pnfs */
> +#define NFS_CS_LOCAL_IO		10		/* - client is local */
>  	struct sockaddr_storage	cl_addr;	/* server identifier */
>  	size_t			cl_addrlen;
>  	char *			cl_hostname;	/* hostname of server */
> -- 
> 2.44.0
> 

-- 
Chuck Lever

