Return-Path: <linux-nfs+bounces-1194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C37830F0B
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 23:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8541C21962
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 22:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47D125630;
	Wed, 17 Jan 2024 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K4BmTcJ2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MFMmzuuQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE238288DC;
	Wed, 17 Jan 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705529021; cv=fail; b=ReeGHe04qtwkSj26RorRV6+WJk94C0tLX6I+9ozVIuTxmkX4jfaiXIkDgkFyrJAVfakXhcjJ9OenOh9yhazK74ELp4D5MW1NXwBQ4jsomXfgAQ69r2/Xbnd/HHlXebdThYuktavO1CA7gmhhH1SGNLBLLTkPQsQFsjL6t2Z0wf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705529021; c=relaxed/simple;
	bh=VbPgfNOT1z9xDMbJOX1O4/VjdQyU9zb+Ob0cJf1q0aQ=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=hAiRIxRFzN5Fjo3C5A+USmMWhRPAvLGNyVz+1qJSrwxzPd8Zkmkx5k0Om0Gwh1k0gd83aYSBZIJwkhHHNncrMIi1OlhwYnqk1T9CbEdHvsOcxkd72mqHHfNT3kJ2JncaoaRDAaognMItswoh8nfvjOAvqFWhfa0zLbmFf1gIVbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K4BmTcJ2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MFMmzuuQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJcnvf021415;
	Wed, 17 Jan 2024 22:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=woRbETK6IOr220IGq/cjIJnHJxpaccffSHnp3vARvn0=;
 b=K4BmTcJ2C+ON+vjB/Q6jEijWs3zOBRMHFpzIQoQv6wjsSkP5uKOBHr/j2e53Yb+5ny+b
 9iNBR2evYVKO213dFK5pzoAcykWtV7pjdtr2Uj9IkHGq+vgkWzFnctQj65rzSoQgWz9F
 uHTZbb4XpjCjq05MHrwJwTzUNitsbypH0de+a00njNsHmQFe3Ya9FhALXD+eFR6qAbNH
 pF7UCWgUsaN3EPXhQrOO23NQelxZbCBzt6wxDiWE9MWJIJLM4R/o7PuJQ8JiyMlZtEHc
 LehgRvaoQ+r9zr4Jvi1NBRSyz5q34emYKEb6bmzyIIUE+7s9+SpNl5UEXqc9rMpl4rAz 2w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkha3h5g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 22:03:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HKecIO023306;
	Wed, 17 Jan 2024 22:03:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb7a2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 22:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc0sc09+EwOhO7qXx1Juqxn55sSe4OfpkJPrORth2Zq8hs2nddK3O38pb8yW5vRpT+GZ7Ln/njCUlNnQsm9WD7oLKeUIOXlsnX6XTEdD2N0Y89qX9EF4robPcpLspiB0eJxchGAkp46wrORqbuWbvMa6YDC/sqk0291M708wQ+TSUvbvkG95mrgf0xzkJS9qJODkB2DWF7H6Opw9KroSOtaCHNLSOGdw97lWkHOvSh1sesQ43D/UzqpEGPJ5ibrbSp9gqd+rbLjAU5wLQcrIN4LIou2JbuNZfKuonHrNjox1wNLSlY02be3MRGbhwGHkKDcadDI9x29adkNM6aAEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woRbETK6IOr220IGq/cjIJnHJxpaccffSHnp3vARvn0=;
 b=ngr2d60Zj/kzhYjwBXdZKciCuGwClHfZQR47x3bbbZY+K7a93Zh2Ht8hTIAFz92UvErAxuUZJEDKV1h1jyQ5fMUJlmj6mnvC4/yyqxqSSdC+pSu/JGV2V6QBBEGZ9Tf33RcUcZe2tI5YP+PXyYn5IcDRLEzOy2DuuPq3WEsC6nt+vXy62e0d0FTS031ViJmzGxBXe3q83jHBVoVn1wWLalY2WuOdxdC5f4LO07AYd3cDuudFEBjp068t8xcz+OfaKzqUCiqroP/b5r5sfbP1CYcjgy+OX8907cVmxJogg2ohT9/OnNGQ0onTkW8kivIX86wIAIM0n56shl0xAUFbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woRbETK6IOr220IGq/cjIJnHJxpaccffSHnp3vARvn0=;
 b=MFMmzuuQ1C9oECMb4eMBnSoADGc05kp3WIrHSYpnOoZWSo2oARJX2xdJbOsv8RH81NW+pUg+ieAfnFPUmQZ//S5kTrSlRshB967faLwnwSBSzIakYMquHcXFvN2jbLCptac/r8T/2O855HEM/YA6QUh7NgJHLMaxO5556KFZ1g4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5554.namprd10.prod.outlook.com (2603:10b6:303:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Wed, 17 Jan
 2024 22:03:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4fce:4653:ef69:1b01]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4fce:4653:ef69:1b01%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 22:03:11 +0000
Date: Wed, 17 Jan 2024 17:03:06 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH] SUNRPC: use request size to initialize bio_vec in
 svc_udp_sendto()
Message-ID: <ZahOmmMZxHcK8Amn@tissot.1015granger.net>
References: <20240117210628.1534046-1-l.stach@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117210628.1534046-1-l.stach@pengutronix.de>
X-ClientProxiedBy: CH2PR18CA0058.namprd18.prod.outlook.com
 (2603:10b6:610:55::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5554:EE_
X-MS-Office365-Filtering-Correlation-Id: 34aa22bf-8e42-4cb7-5f47-08dc17a817af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ThyejC5KYMHCQwTaqtSa96JsI+xGHnrP5Wme225+6IuBEh4MkJh6dSGobqAHUMVCKugj/VSeRAE67hPxOxJ/s03QhvMs9tO0hp+1fG+CJP17JAK9qFFBONAUIC/QCbF2kS9cOJygr6c+d80Ji6NHKc1M7HynieGXsw8+2k7esNn1B//nD8xhKjLhgcorF4jr6mks9dMszEf6NaKEmj3aZciW47SMVmj/rYD2zvnVqBGmqBdbRdBLFvCF7dc0Gfxdw0WA2AfX6pCZYrQI3WaGqfpRJatijJWRE/+LSevKUuBFM0Q7svUa4CJobBLcgvsH5YUbtF7YB0FPUcImYb656MirHx84SrfMLAb8EVPrVQkn8kkfq2/XeWgfEmqdwFdus2pxk0fMotIxXtpRhBK4C/mKmJcQ666wuiMCoVeljRyjiWn07Z7dJyJPalvS4wo+rerMuHmmBUGdkGg/YK77VyfkYQZILxR+Bv8UdBwgAyF/aOl+WaPEzNu2Y8JLyraoqeh8Or3sfjnJRKKi7AHs36s1ohhhsp8ka+rzeGqfi44tIAa6pmVVT9CsxBa2tOzp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(38100700002)(83380400001)(86362001)(44832011)(54906003)(66476007)(66556008)(6916009)(66946007)(316002)(7416002)(2906002)(5660300002)(8676002)(8936002)(4326008)(26005)(6506007)(6486002)(9686003)(6512007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rb8tJzEjFdanSIYlaKtgyKNnhSwSBt/BuMLKhWFL/tITCrqCp6xvYjOCPnpJ?=
 =?us-ascii?Q?bhc44HjrzHFXNKVsULJ5p6xh3NMyq6RCCIQ0m0Y7uclYokSu9b064gyn6dke?=
 =?us-ascii?Q?SgjSn6MDa2pzJvj8TtdOV+IkYVYwAfQrnTvy/dAu3au8Y1q4ihcTqKbZOtpq?=
 =?us-ascii?Q?AiawNcTvaOcLSXtOwsBaLhmD5oOpq/l7jAChvvZEXqDE4vIqlDZIJladcr5N?=
 =?us-ascii?Q?05N9e1kAQWl7+9e2kwuyVUzZVAKqVFJ2drWG/okssOWRsoeiT8i1tNLddklm?=
 =?us-ascii?Q?UvxSn+kGMmbfzw+/y2xmxvdj6LX8wR5fUteLclRDBueusSO38fdUlYASe/zo?=
 =?us-ascii?Q?cKoQczLncitq82aNXmj3fcqpwCJUOyGSUAx0gsTZBc/IDNlW/xbya99lLFdd?=
 =?us-ascii?Q?N4ZRT0Au+fHVTwVRn5SF8s7Pop565B3+HNbwlMZRhYddKos3qlRRUoLyK95p?=
 =?us-ascii?Q?gaaWz/IC4Vh8tFvvH4lDQ/2Lx6k08eUEbS8xwjbWssTRirdUZemyYRIBwDfO?=
 =?us-ascii?Q?4ceov/foj1a3d9PGucUDOBoonB+xcrH5V0IkpDVjmUtAqQoiBbKfMaeTt7md?=
 =?us-ascii?Q?M9rktyvQT4dmbqosX6Nu0qxh5JQtGS7KZUr8rCvDfTTvSSd+t5p7V8MfHgRk?=
 =?us-ascii?Q?bxXAVDvqjSmU3k1id1DG6av/q6LuJm8S22RVxiMfgB+muocm1+6MYbEi6mYi?=
 =?us-ascii?Q?zlcqPuz85JDw+av74v6mkjOXBTbO/mZ8LUrVPM0WYRbYjy8R2gzXvAkbpBa9?=
 =?us-ascii?Q?fdLcqwXfQKVOwQymTNygLKfhyY4eP9HfDSMhyCpv2DKFNESQOQIzY8MIJFbc?=
 =?us-ascii?Q?WfzDq6m2oob2kohkdLwF8O/E5CsQS7+nGn4nqXGxp57q5MhgeMcOwUBpMfaS?=
 =?us-ascii?Q?zgiEViU/uX0+9mq5ZKVpeSOql/6arVRK3I+3XbVkfXhwbJWGpuMTT/Eik9zE?=
 =?us-ascii?Q?MwA5mFAX8rjH/GawLNNESnCpmtL8iRTVkEgcyl+gBk2npFrijKZkTMH3vtKz?=
 =?us-ascii?Q?XVPm6P/jn/Nq5Iy3rjwlLuG1SvNi5GS+00ZQABvnbQOt2YIw1eL2pNXL5Bmj?=
 =?us-ascii?Q?Xzbx39xQWALeIKYFUcQB06VIpmnBocnvBPXA6Jgq2BqPRP8EHfmJmEBm30Iw?=
 =?us-ascii?Q?03LzXL0UoFNyMjOCR1s8HMH7WkkbCP8ff8TLGcW1gRqWtvKOHGtA9lWzO8Ap?=
 =?us-ascii?Q?ExmT7vt4twXVNjaMYgiwbw6AktGxZU7gBQDLGxy95EbHxniAniwoUQmsnsrG?=
 =?us-ascii?Q?iZNcrntaQUdZCVdlPbd8awN3W/npKEf5GdQcg7aukUN6BqA8L6y1l9hZnFd5?=
 =?us-ascii?Q?fncaUisQtdz+Jh9SiY/hVLIYJcMqaGebJ/pMNYKyB/+9AoAG7Jc0GTogrSkd?=
 =?us-ascii?Q?G8kktx7loiPBHt/DRUKIIKR5pF8++xYHrHnCpKZ2zRNbmOFVL1hLk7ilfZN7?=
 =?us-ascii?Q?k8M1N7xbsiS+5uGtKZlB9f0hcgpWzMV6G4wPrxrakHWJFP3mwucVYkb6CMA1?=
 =?us-ascii?Q?ICGNfMq+roweS4BdmKherLXWUPMxMhBLLe5TDdsq9HiLWik4Spu1GXdAaMxA?=
 =?us-ascii?Q?zZW80rU3udD702DPGMv+aZ2SeVg0QK4pMGIZxaRXUfjVbIqg+F6/n4Cj+LYm?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WXmfHjDnGiaESCJ9Y37yHwB1osM/JcZ+01hsJczMZmKiG+zcQD2IbIAnMX+O6IFTwxZEE3C9A4YhNau9+yt36rlZxrmaTKUr41vC1oEdFYx2Il8rBnVRimkW2NV53wPn7CcCc389ayNa6BOxfKHZIYiRY9IJQwh+B0gF66vD/ROBBtRZCoE69dNMdGyVKzXJKmH6nIwwRgChA2eKKNaU1/kSzVdC8m9zmgDJe7Y27RgAWHfRZsIh8u88ionk7tWhwA2dMYM6WIq6q4De9Q4hP3ArBbuMuTJProWA5Ba9cu9XoQIXf4mL/8AfaJ1rzpj6VRVqqEIPXzIiRHHkOQY4ndfEfTM4LdzVNIFMwuJ+YUM2KzPHb+mGjDNKcJjx0RIHv2T6hXk98tXdO9ApKkg7S+avE51zg8smfRdjFR/HxOuiF8nS2JpG+XYWManm2QHryiDGnStnLFhukR3hCxGfZG+gWjdZkGSjghoTwp5E1QVk+x7E1/wn6ZvQAbI+TQCuYYNgh+282B4aQVZw4KDzSFjSKC6HNyngrF9eQuJ4wRicsS5yMyfUTXheO5X50TKfhN0+30DtTxFGQpLz7dpfSZ5ueJ/kBR/2A12GRdMGUXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34aa22bf-8e42-4cb7-5f47-08dc17a817af
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 22:03:11.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RQ2qBE4Kmb8CPfPZqrJRTzALAjvxH8QFSImi6B16SLU3WUTqa+wUe2DPSuXgzbxKaC438Wz/qqvFVGUp0KRng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170157
X-Proofpoint-GUID: TBkASv73nCLxUWmQIPeAwI889Z2gGf4g
X-Proofpoint-ORIG-GUID: TBkASv73nCLxUWmQIPeAwI889Z2gGf4g

On Wed, Jan 17, 2024 at 10:06:28PM +0100, Lucas Stach wrote:
> Use the proper size when setting up the bio_vec, as otherwise only
> zero-length UDP packets will be sent.
> 
> Fixes: baabf59c2414 ("SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec array")
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  net/sunrpc/svcsock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 998687421fa6..e0ce4276274b 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -717,12 +717,12 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  				ARRAY_SIZE(rqstp->rq_bvec), xdr);
>  
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> -		      count, 0);
> +		      count, rqstp->rq_res.len);
>  	err = sock_sendmsg(svsk->sk_sock, &msg);
>  	if (err == -ECONNREFUSED) {
>  		/* ICMP error on earlier request. */
>  		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> -			      count, 0);
> +			      count, rqstp->rq_res.len);
>  		err = sock_sendmsg(svsk->sk_sock, &msg);
>  	}
>  
> -- 
> 2.43.0
> 

I can't fathom why I would have chosen zero for the @count argument.

We currently have zero test coverage for UDP. I'll look into that.

I've applied this to the nfsd-fixes branch. It should appear in
v6.8-rc if I can get it tested.


-- 
Chuck Lever

