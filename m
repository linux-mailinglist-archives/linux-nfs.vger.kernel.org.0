Return-Path: <linux-nfs+bounces-1324-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1671783B5BB
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 00:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839EEB231BE
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90256137C24;
	Wed, 24 Jan 2024 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AAJtPOaq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Iisnub2u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05D135A68
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140057; cv=fail; b=YhtTFIpT1J/SRq666M1I6DtzN0iHpZxV9g9vAUoZxis3eskpxRH0WplQqF1sSV3MIsu/kGXkrLfMSxJWlIQH878VuSI1E+o9vkPXytJl5b9Je/oHTOTDOql19O+bgkmolGYCcMKdYOgIbkJhih6xURHSyKFo9V04AEWNauCZxpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140057; c=relaxed/simple;
	bh=mlt8ZBFcjhFMr5MrEnGg29XKYvAWuQl+HGr09Mp+8eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YZ1Ti/l0DAPwsA0mPV0i1Ipyh4A8aW9ItW8AP3cN2m4lRtH42TM3A9+2PzR/DV/r6hCzlFYFUAsOv6OyP0KERzcD0dvhkOoLdwhYpd/bDfnjJ+yF7XQbtwrDLjEwdmvzv8tOLQSGoFDn6iE3q6JTY1VlQcuuuNPZgrToPZKCP2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AAJtPOaq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Iisnub2u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OLcG1S008839;
	Wed, 24 Jan 2024 23:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=TQVWQl98KarX1WEMor5Wv93Qv8gxPGkZ30c3CiPbclY=;
 b=AAJtPOaqbwbRvBRTdNno9SETdE7DWXpJjCPmyXZgq17VdCvxnfvH8Djjk+8v0DSExgxo
 EABuqznT8xECGnWiuEX2Mg3bvhRKvDhCJA7+p/8uSWvojn/+rKAifTDRsoZG/6Xg0IM3
 E++xkWf/6b/Lfv48QxDFHUIzIofdhSnisGm1y2NCazoEnT/AoTmronXHKKy/CvHYM+re
 AY7mbCtXOsf1taQLuhx/ShzW1fZj3yUV2AA9rlUY3WiKKrSsFR5iIc19F/JlSjc8fMPo
 BjFRn59QNG2OqVXjFkYvmcdvXB8OSWnBmdRVCZF+ZJpR2oPLobuIl2ekjGMZvbbJBiLL CA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwnk5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 23:47:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40ONFxQo015441;
	Wed, 24 Jan 2024 23:47:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs373hnbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 23:47:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVjtQBUmT4fp/X7zZK33vuaAOMGXF/i4Ye8zzLJ50C5NpFX8xZuTzIA0lrIZt2PstiFdr64uXumk2YYpXS5FTwnR01mkaXRHg+DOb+IgEUdqQcjodENMTJ4ny1JTGixL9vD8RHhSHBg2SBjmJyg+R7fN5ODDWYfCK8O/eSv/puiQ8hAISyFNdpMNXIYkNJabHCjw9haJik8PswdvHWwC8fgEWXda9xi2aB+fPtvhc1hk4VLyuXAzurgzjRDtKqphgndqciFkPxiogXVihsUlP5bhoCQNXCZ70LadnrL4HmDhN5lqYD6p0oO3PSmcqxoKfLtQfkKQ7YyM3K633v8KaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQVWQl98KarX1WEMor5Wv93Qv8gxPGkZ30c3CiPbclY=;
 b=Wbou9u4sqYRyTbYYKiASeiJD8jue5llD43llQ1o513hswLrIeLeUTbDDl6VvBYfDpF4TfO/DLW5jPUIVUoQJ4mwaVIX1cVykgn1ZaQ+VUoREQ5NzC7YMiBmdIvLs9UeL7pyd/AhIfMUndZ/2X8rPdVA8Ho3ZJL5eYyN0NAK031b2rm3Xc60WAvvF0KlRAvMO9xSkbQKWYGjAI/z9TgwsAUJeDo0rVDhS+Hlp7Blxn5JAtJ3/PeLk+KNXQhg0iQmrm9R0xBisM0Zv97i9afYqaWQPxyYUbCHUc+8NIkfRNNRY8nqxgYfBlNvUBwvKNU0tnKOFEjsXoCLNLF/AOACzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQVWQl98KarX1WEMor5Wv93Qv8gxPGkZ30c3CiPbclY=;
 b=Iisnub2uWU3zCwcX2B13475t23/XmJUbWOqc02r+LCb7SiDO7rQOrH4yJcMQJhoeCx/UR3ffi5DqsnyfEfjCV/vEPs7AkMW21KcMiBPDFlVBcnnmKYGlTcUd6wZM1lxHFxKBi+HoYisbQ5OhJlRE85gKL1esspNXBf63ruzdp1A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4530.namprd10.prod.outlook.com (2603:10b6:303:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 23:47:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Wed, 24 Jan 2024
 23:47:23 +0000
Date: Wed, 24 Jan 2024 18:47:20 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-nfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Message-ID: <ZbGhiCxgpeSNi+Fw@tissot.1015granger.net>
References: <cover.1706124811.git.josef@toxicpanda.com>
 <71058c29683d44644aba8ab295fa028ee41365a8.1706124811.git.josef@toxicpanda.com>
 <ZbFzxmV6zgi/TACb@tissot.1015granger.net>
 <20240124221258.GA1243606@perftesting>
 <e724a63a63f30f927f1780ad9018811bc45bf4e1.camel@kernel.org>
 <20240124231811.GA1287448@perftesting>
 <5f264d8d506835c424d5cccfc55980fa2893337e.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f264d8d506835c424d5cccfc55980fa2893337e.camel@kernel.org>
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: 1250caa1-700b-4dab-1e4b-08dc1d36cfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rkPWd8IS9CmMb8a5LsSYShF7sGyzoJyjDZ+xtjDpmerVUSy2DARM/6lKSlf3+dbZehpbplE8j2RJ9N06hHlzm0QbL7A6DNG59xr3fLmxYbnSIhBYpFIxOFZ1nl2RWJL2ugC6LNLrqqoie9Lvpr7/BKWI7ho2QqXy0iErVobHk90HqZ1Wd5PHxLNxr2Wn60oSlANMFeClRJ/tSNmLqIC9fUw7o/oGurltgR9L9Me0nYQJjowCIP+841YAxn3OWI26xZKsahE842OQG3bCPx3K9z0CsXeX5jghLKXAI9CO+A0lUuOdiavIXMRfh5aIvd3CbONfPz+3k1TH2K+K6VnQEUDvSTzKuBX1ePyfA4puRQPJJasr9chWV3jAkUGeCq1ZU0ek+/Zcl06JF1ue5HN96M2REWnQUJFKAHfI898emyC0jSgU46wnd2w/kw2vHKp1+GHb/IqokbKWv0unSSsF9X4SK4vp+SytJ3k5DrBZvkPi7ndP3YMqf7klQ1YJiySJoq5B6LzTXRMr8CYJETOBEDVAa+9lsTdFvGxiGYYBMrAR/7wGRRFao1ju+qlV4KHZGqQFTonHfpTftp0cwMXZ9zZcXJxp76vC3FM/wk4aXvM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(5660300002)(4326008)(44832011)(8936002)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6486002)(478600001)(6512007)(86362001)(9686003)(26005)(83380400001)(38100700002)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/Dw/Q5qQN/V31eUbv9PZrah6Wal3FUvQHe6u/7CDJ5up68dZIKR4RVQFvak2?=
 =?us-ascii?Q?vkG6GIAcwyFELiFooZ1xnA0qWQiKuiUrejGywAjCMDkJ1UR2pHbWdsdbhkG+?=
 =?us-ascii?Q?OTZzLn5KH/H2rt0Yy1K0uNQtf90oyjXDLZLB3yCSbLQDylUx9SgQr2AKP3SX?=
 =?us-ascii?Q?z4uhtnyB+frgyc8rx4V1rya5plNrrSXWvno5jqYQM354gGYGilYkFRSwGAds?=
 =?us-ascii?Q?ESpd1sjIZw9OAiM1C8XgrEIIs7QEiB6dNjXB/8K7YZxdbWVZ/uXagInODt9D?=
 =?us-ascii?Q?x95+yK1P3cfPfU+id3fjT2dUV2PSuWsNvB+yqHtd1SJrgJMMBJX/YgETJBQp?=
 =?us-ascii?Q?zpxc2OW3qjAH2vF+lUl0iRAOE9PNa9lX0dK48nEG6sKTgRNDvRC6B9ZCoXIF?=
 =?us-ascii?Q?+78FXH3tJ5/iE/tCx6/s3aQ5TgMZ/uW1M77Mxu4VAHIdEln1ldSNFouNI67Q?=
 =?us-ascii?Q?8KZmYbp2u6oWDdNevyoKkmSJuRubWwqVIQZi7aMgF1AGrkKUMlEy28yeYz+a?=
 =?us-ascii?Q?P5eCD/5Ep1p1zOwet+Ghu8CepjV2OIrZlR5DcMFU054526RsbJ11Zn1booSq?=
 =?us-ascii?Q?WU8Q/YsfiwVJe1RO5N061ujnqzWlnSlnS+V7vIJeft8963dXUWXqM2hN2y+b?=
 =?us-ascii?Q?UwusuFoJFYsZeqvtgZLVZmxl55xNcPfBUCQiAtS8bo/WvFaiNGVJtUckmtfF?=
 =?us-ascii?Q?828GGm2ePqVpf+UhZBs6cicDCxopcNcEGovKblq7k5NNsGrGalB1Jv1ib0QS?=
 =?us-ascii?Q?zTUg71KUzYf4GeTZpIdiJCCNQ29SIoDIDNBRkToGEVK2ONTA5LaKelBe0l8n?=
 =?us-ascii?Q?3XfczdB7B6hGXiwUgT7Y3bZnABqMrm7XBgOb7ffevOqGFdOkuf1c1YCJ7UZl?=
 =?us-ascii?Q?7KSZURzTAh7V9dCe05u54fRkYzkoRg7W4h2idFAtYCtQjX7YveEM+qIq9+C1?=
 =?us-ascii?Q?Rb2Fsip4VAa2b44pRMClFHQqRk82rfJHFqdef/DwhST6VUPjy/Gq+rH8tNP+?=
 =?us-ascii?Q?KBzZcP+QWMZ/Sa6WtOGLxaHBJWRKiBsutZywdn172iyQ52gOM5nncn6j5xF7?=
 =?us-ascii?Q?eVnMOqCWfwXQEsPgFQNSK4R05WkXVYH/s8X9I/87mb9XQ4FrgMKiw3RPYQBS?=
 =?us-ascii?Q?MKCLAtjWGYpdx3/b0Huo/jpBwczIhY5maGx8RrMLuil90R2+RERxaY/GrcUB?=
 =?us-ascii?Q?mQ1jHifLkQfJY9mmG4pRmii5piw/bkiLr14aCC+uoFhh09gJySwl3/1Rxto+?=
 =?us-ascii?Q?0lmwXaV7NnBhVhgN2AoxIp6lQ0L8WJ9byKF3QlbXXeOWwcKtf71YdEabHIrL?=
 =?us-ascii?Q?esrUgbYBrKK2iS756j8EDRtPzHVZPBfmq8ffJGmhfr3ww8MEGOZOk42ywaBN?=
 =?us-ascii?Q?mKZpzyNHV8OaLzsts1YDNrnfIIKF/rJIq5Q5cQyh6RZ6au6Auaa0OLtn6ZA+?=
 =?us-ascii?Q?SqZjELZ2Ki5vH0cPqCUArB5/Xcz0K/NQRKZqJ/YdRpLYN99zH+rmB7Ika9Kg?=
 =?us-ascii?Q?n/pHkHe2wWbuZUwbw+df+oBvXJu0pASqgsN/5/KN5cfIw4e/WU0m1sHzgYR2?=
 =?us-ascii?Q?19YsrijlcynvY2v2oGQwUI0/aj8oBd+d5LtXjE6l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eONgvhBxaGw+AFOKLe2uPNcOJklQu6d7kJmcNkTTlFvqwWa8u3620R7oEeV5rZ4bjFtna5QvQSzaQHa1aO6EqjWSo2Cuncy9BoqWREyfTpMlymky75pkHx5+5WYMiZ8nPH5hO4rx3M37CG/cD370QsjPhMEzmKH4xia7LMljDE/LaaR6fCgm0SlHWxDVPgljirc8b3ZEGygUswltRmETm6AZ3asESPer3DEYrmZRmrCH0H5RzW+wdKHOyMlwneRXt/JdJfvLMJJRdLSNftRj0o6Tjw3s3rdqbZwRmVfspXdk4t84xck4s1qYp+vORA2xn+0X38cQlwia0Xkh6N3VGt5ZczV2RRRVCESnTpfWnPwCkX9qlz82Wo42kLu99MyiFLsMV4r46iOEyL8Th8NKebatyizrxAFBXMatDel3zY9NlkcjckYV3cx6tUxz1ALneONxDRhkkxoRTwcue4Voa78I7a2Z3aPEXmSEs6BLpvJ09hcOZ/bL4wupohPKv63fSg839xNyEHcFDvGKTqjGuNfCbkNdNSjdGmbJKgXskoltVoHdn5rRRJdPAvIK6n4lc1qtwm+5Dhwr5Ud3BciorJc1tFs0tI6lMdqhclpZRWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1250caa1-700b-4dab-1e4b-08dc1d36cfc9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 23:47:23.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEFhl381alUPHieG7NvqI7LqCWf+zFs47B0TRj3IBtX/JmDqvgLkSju4L7f3dp7FrvGZRCNQkoe1phd0NvI6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240172
X-Proofpoint-ORIG-GUID: hIc0H0ZJQarqSvfsvXFmpcmfxQDiVHSU
X-Proofpoint-GUID: hIc0H0ZJQarqSvfsvXFmpcmfxQDiVHSU

On Wed, Jan 24, 2024 at 06:41:27PM -0500, Jeff Layton wrote:
> On Wed, 2024-01-24 at 18:18 -0500, Josef Bacik wrote:
> > On Wed, Jan 24, 2024 at 05:57:06PM -0500, Jeff Layton wrote:
> > > On Wed, 2024-01-24 at 17:12 -0500, Josef Bacik wrote:
> > > > On Wed, Jan 24, 2024 at 03:32:06PM -0500, Chuck Lever wrote:
> > > > > On Wed, Jan 24, 2024 at 02:37:00PM -0500, Josef Bacik wrote:
> > > > > > We are running nfsd servers inside of containers with their own network
> > > > > > namespace, and we want to monitor these services using the stats found
> > > > > > in /proc.  However these are not exposed in the proc inside of the
> > > > > > container, so we have to bind mount the host /proc into our containers
> > > > > > to get at this information.
> > > > > > 
> > > > > > Separate out the stat counters init and the proc registration, and move
> > > > > > the proc registration into the pernet operations entry and exit points
> > > > > > so that these stats can be exposed inside of network namespaces.
> > > > > 
> > > > > Maybe I missed something, but this looks like it exposes the global
> > > > > stat counters to all net namespaces...? Is that an information leak?
> > > > > As an administrator I might be surprised by that behavior.
> > > > > 
> > > > > Seems like this patch needs to make nfsdstats and nfsd_svcstats into
> > > > > per-namespace objects as well.
> > > > > 
> > > > > 
> > > > 
> > > > I've got the patches written for this, but I've got a question.  There's a 
> > > > 
> > > > svc_seq_show(seq, &nfsd_svcstats);
> > > > 
> > > > in nfsd/stats.c.  This appears to be an empty struct, there's nothing that
> > > > utilizes it, so this is always going to print 0 right?  There's a svc_info in
> > > > the nfsd_net, and that stats block appears to get updated properly.  Should I
> > > > print this out here?  I don't see anywhere we get the rpc stats out of nfsd, am
> > > > I missing something?  I don't want to rip out stuff that I don't quite
> > > > understand.  Thanks,
> > > > 
> > > > 
> > > 
> > > nfsd_svcstats ends up being the sv_stats for the nfsd service. The RPC
> > > code has some counters in there for counting different sorts of net and
> > > rpc events (see svc_process_common, and some of the recv and accept
> > > handlers).  I think nfsstat(8) may fetch that info via the above
> > > seqfile, so it's definitely not unused (and it should be printing more
> > > than just a '0').
> > 
> > Ahhh, I missed this bit
> > 
> > struct svc_program              nfsd_program = {
> > #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> >         .pg_next                = &nfsd_acl_program,
> > #endif
> >         .pg_prog                = NFS_PROGRAM,          /* program number */
> >         .pg_nvers               = NFSD_NRVERS,          /* nr of entries in
> > nfsd_version */
> >         .pg_vers                = nfsd_version,         /* version table */
> >         .pg_name                = "nfsd",               /* program name */
> >         .pg_class               = "nfsd",               /* authentication class
> > */
> >         .pg_stats               = &nfsd_svcstats,       /* version table */
> >         .pg_authenticate        = &svc_set_client,      /* export authentication
> > */
> >         .pg_init_request        = nfsd_init_request,
> >         .pg_rpcbind_set         = nfsd_rpcbind_set,
> > };
> > 
> > and so nfsd_svcstats definitely is getting used.
> > 
> > > 
> > > svc_info is a completely different thing: it's a container for the
> > > svc_serv...so I'm not sure I understand your question?
> > 
> > I was just confused, and still am a little bit.
> > 
> > The counters are easy, I put those into the nfsd_net struct and make everything
> > mess with those counters and report those from proc.
> > 
> > However the nfsd_svcstats are in this svc_program thing, which appears to need
> > to be global?  Or do I need to make it per net as well?  Or do I need to do
> > something completely different to track the rpc stats per network namespace?
> 
> Making the svc_program per-net is unnecessary for this (and probably not
> desirable). That structure sort of describes the nfsd rpc "program" and
> that is pretty much the same between containers.

Maybe we want per-namespace svc_programs. Some RPC programs will
be registered in some namespaces, some in others? That might be
the simplest approach.


> I think making having a different sv_stats per-namespace makes sense.
> It'll be a departure from the way it works today though. Looking at
> nfsstat in the init_ns will no longer show global counters. I don't
> think it's a bad change, but it will be a change that we'll need to take
> into account (and maybe document).
> 
> This is all really old, crusty code, and some of it like the sv_stats
> code originates from the 90s. Right now, sv_stats is only assigned in
> svc_create and it comes from the svc_program. You'll need to do
> something different there.
> 
> Now that I look too, it looks like we're just doing bare increments to
> the counters without any locking, which seems a bit racy. I wonder
> whether we ought to be doing something percpu there instead?

Yes, it needs to be made into a vector of per-cpu counters. I've
had this on my to-do list for some time, but every time I look at
it, I try to find something else to do.


-- 
Chuck Lever

