Return-Path: <linux-nfs+bounces-2582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8AA893E32
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 18:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D8E1F21349
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9545BE4;
	Mon,  1 Apr 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X1Epw3IW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MhsQWzM/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01549383BA
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987235; cv=fail; b=dHmwyT28u4p/BOgisC1JhLZU3DUSh2kHRwlRwS60a6ec04YYZjPb7NaLfe/dQbObU3rujQdFhbv54nV11Qu+b5rsyN818q7PXuH4qb9BI4iWWgfI76okODjyDyGSidHEXtVhANQNwPnFP1h7l+Dts1xlH9ySbd72/ykR3Hdckv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987235; c=relaxed/simple;
	bh=SLLJeF3h31KWK+yKRIyTcbZE+VAvuxNz6BzSms2Ee1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6RavUpnkGxk2ZP+3Ixg/iYwJ3yu+wz68EVzZpoqYi30SsrIq5fgwyYyEDmA+AsCkpwt+a9U1oXV42QrG1JurBQnmYScqVup8vsn9V86FBNboaBr/KXUag6DVMYV+CCUyeuHKTh5Sd0Hv/pigiGEYU8qHVry7FwPnKgheuvd1RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X1Epw3IW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MhsQWzM/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4318iBie027623;
	Mon, 1 Apr 2024 16:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7W5HjJMN5y1TgGWwI1N4M3bptCaY2A1YWyJZp3IXLi4=;
 b=X1Epw3IWvT074hNjStVBvdnc6F6aLwC6A6f7B6PwJMUBVKoGhsIpyD97Vje2TB4KDujC
 OU0A6OxcRYiujLSGmValPKr9s1UGneNTHql+ohvzW2hlrOrOMluZxY2AbDumExmvEohu
 kikVzUYev7vlya72D2qGar3B9Wdlv1r0npgkCwPNyMm4gWUKO7CJItfZnS9G8B04Dxkk
 qCfojAgx+I2dUB8tJlsH+IoWK+cP4iWJmoMSZwDUoKvEmhgjhi8PLEALccRpifGCF7ag
 BEfBlSBiKovWpIkKl6doKV+ezp5IKlIKAVQcfJ4aB5yXpbCwc+5K+ucb1M/XiT0bxF3g 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abuanjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 16:00:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431FMNdE021324;
	Mon, 1 Apr 2024 16:00:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x6965t1b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 16:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0QVlJPpkQdB7XskVsQihPRXfJ76mq23AkHoMYIyfFJ3++23S7/jyDbn2vf//UrwIh8zq+l6ZT3ci6L0HJX51G+A6yuahPkDJsd2ryYj2/yspRiAsEyWx8UjzMgZ+rWw8KKFkKDvmeWtJBHz8i/p73i1MvM/doTpXskeSiaewpZ3YZx1QGlEtnrQI/UVqgaYgL/jnDNwTxdXU/U0tI7FD3EreDplNH6zui2VCTsX3ho/GEEnYzAiIRqSRxmnE139BASh3yYJbs5o+5qZCSNtbsKQ2BlwrXP+SbaBh+FshaJi1Z9g7Z1xospecFA2y7f6gKkYy0YXBPIW9JzxCfcsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W5HjJMN5y1TgGWwI1N4M3bptCaY2A1YWyJZp3IXLi4=;
 b=DDkPlzfrVP2+ErHhsoyntSa4FZAUI3dtazjw1GuBLagUeVMIbFjON9xdXqE6w/L00Cu2NXdy2MScjpD4YU3KQYggm31Qd5aGLqd7Casm9GDD5HdQFV3MliNoHpj/YjAqqPeijZvQgz6a/k2AsVdthyZ5bt2HigkOvVv3wAx1SeUn/Xc72Ncwehb9AYg2tgDq/KTpJIpL14hrDFbtDyFN2BerubuDASmT2ogBMjWuMFkZrGA34/tC6DsUuuqGJ/lJkKiGRfn8fOIXO1gJDyxU1ahTVu9EpBTjqABCLU5op+mH8Ynz4JBOWulVW1LsjjOdkmsUQCz49c/EWyvaSGl+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W5HjJMN5y1TgGWwI1N4M3bptCaY2A1YWyJZp3IXLi4=;
 b=MhsQWzM/cs1+hCH51t8bW0fNFTbysIvaRCJLrwKPRXSNYsyde4n8TcW85fBxMIN4so/TIQqpxN9DMZ3caoGHJrRmDofGJu/3pUpYMWVWWazT/trjdaAnpLO/DChTrSTHWYCxqtODgNmbc0pRy2kgdErjOWckCGnx76g8fJEU90w=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Mon, 1 Apr
 2024 16:00:25 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 16:00:25 +0000
Message-ID: <5108ca5a-b626-4ae9-a809-ae3fffb50cab@oracle.com>
Date: Mon, 1 Apr 2024 09:00:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
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
 <Zgq365RJ9M5qsgWY@tissot.1015granger.net>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <Zgq365RJ9M5qsgWY@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::34) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA2PR10MB4412:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hg5+2GUHzq3O3mDWPxur1nqT0wIZFaeujmJYjeEIuRlQ8ZQ7ozwKtJsNGF/7RWR8PZT2ps8LrkamZhgRkyylBwNlizP1qsba4OOj6nsQIC+qbXIQd5WwxxdnSNiJ0FLu0iTzV2XFnZ7oVF/RHVddmG1ngMmUa6FdYWbgH+jjDbV5QMf4LCdHM+FO7e30KyWKp2tybAkE25lpXVEVVTJJH2wpgPwVEY0ERc3wI97x/o6jY+5PUFH203pOcCz7iHdez9MnqbAlev6bIFWzukmTNzvlrcXm2oVbtUQsVK0EKF8XUJ6Mqm2VvemqueEFFO/VkfEsmA69TZzhFsIi7IofZlajcDlRVe8xqxMU4pe0lLpzWjcjqptZdNI5arcNLKtneiX0Kaqj3u793slFLtB9M9jU7o7aOjYDvD6TZpodBym4HPQ6Xwgsa07dxHiSu8ECDSoq6qUeMvQxWjkZp0InJ4Gif76R62C8RJwjEZuWz5Fu9eYyxbPFp3vxynTCK2/nvEWLDSqzVJlnGeTdSPSsu6NgCG2uvGNXtOge/PqgLaYEotBbEMm1/J5+SI7L1dYaTqlz81uxgoNst4cj6zW9+/IWU13AoIZPK5HnmBUn7KEJhOkOviazD/fv6Gd8tXUZmSZn2X0NrF4t4gMs+L55L/slFv5tiJEoTjtllTkk/Bs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2lnOUl1ODdUd1NUWGhYMkZDY1R1TFZaUFEzUDVVRXVzYjNadnpjTmY5clVJ?=
 =?utf-8?B?M3hxTTZhbjRqTHJYZnkyVFRCdHI2UFZZUVVJRUdxQzRuSnFrWEVjZ2h1N2Ft?=
 =?utf-8?B?RHlRMXdwYzgxWWk3VFhCU09LT1NxdzdDVVk2Y2Y3aGg2RU9JSlIxOE9paVRU?=
 =?utf-8?B?SmRIUVBCTjNPNm9Wb2ZHZzJFWnlFZVdqeGJHUklWZ2JONk05UXhOeVhkK3JD?=
 =?utf-8?B?c1VOVWxmZHBDSjhIaVp2b08yZzc4WkNOM3pwdC9tQWczamd5WUpEa3N2c3c3?=
 =?utf-8?B?NEpJMzJCZ1FpVjRhbFdRK0V3ZXR5Unk2cjV2THJKNmxYK2VIdG9tNzErNjhR?=
 =?utf-8?B?aWRETG9VdXMyN1pRc3doQ3NvMVI5ZXdrd1grcWZCd2dHUVBtMGZrcjNkWGlX?=
 =?utf-8?B?cTBZSVRhREd4ZTF0NkltaWNRb3NaWCtCRzVKejN3b0E0Vm5VRk1Md1JoeFlS?=
 =?utf-8?B?YmV4YWhIWVdKeDlGNC80Q05CR2R0cVE0RVR1UEJHVmV4ZXNZR0I4bk5uOXB0?=
 =?utf-8?B?L05FdGhMZHNMeDZMTFBIWEN2blFDVjUzc3BTKzhOQUtoNlQzRnhMZnBqSVBS?=
 =?utf-8?B?UHRhaE1EVWNpUm5kdzhwMWdhZVh2emY5Vzkvc2hNZ2dwRGdDeU5vTnJmVlBU?=
 =?utf-8?B?em1vdmlJN2JuUVVocUx4Q0VCTXgxcmFRUlVESGx2cUprdWNrRElPaHhwOVFR?=
 =?utf-8?B?TFF5alRHZlY2b1dpQm9EdmJrR1l5NFFYZi9jQUtwN3FWVWI3Zm1wUWRrNVFz?=
 =?utf-8?B?SEJzT1JDRGNhUGFkTHBudDd3dkVNbW1GVzJwQklJMjV5eXBCMFhsY2pGM2hT?=
 =?utf-8?B?ZnpwRzZKTVZBcytFZFZxdnJQN0M1VTNTT1NMQk01ZFY2NUFackFHazVyQUY5?=
 =?utf-8?B?SG1JTGFKK0hBTEVJa1Rtc0lmaWYxNU96K0FoeUFvbVB1OFBaTmJDQW1MbXB2?=
 =?utf-8?B?enpQNjhsamlLS2hVM3QvMlIxK1FhbWNyT2dFVzFtajI1UEdiQXJRNEgxeEVy?=
 =?utf-8?B?TFJjOUx5YkEyVTV3ZUJaek1PWHF1Slc4QkY2Y1ZWeTc3QnlTRThnYmwyWDJX?=
 =?utf-8?B?eVEwQ1hUVVE3dkhNQzVSWjNBcHJBbmxXS0RWbWJrYUJMLzZIOFp1cXFUZ25H?=
 =?utf-8?B?eURlM0YzcnFCVFl1c2hzYWwwYm5qVlV6bXlBMml3NnlOVmhBUWlhRGVyV1la?=
 =?utf-8?B?dVVtWmhKSWpDaXBEakczcjZTaXNlZlJaTmMyRkpYNmpScG5aVE9uR0xkWXRo?=
 =?utf-8?B?SkNpTUMvcVRHRXl3Z0duOHVad3VKQ0krRTdqbkhJa2dNTVh3dDR5eXMwa09E?=
 =?utf-8?B?SW52YmJaNWtGQmZiaFNIVjlDTFFJNE8ybTE0MHZWNFFHM3FtYkZRbmhGdzVJ?=
 =?utf-8?B?OEQzMFhnRnlHeEpqMyszMVZmYkhCTzg4VG9WdDlEMTlGTXJhanc4dFhtWkw0?=
 =?utf-8?B?RjlBUGpzd2syekpKOXI2QjdTUUxIQUIrY1IzbnBuWXc0UnJSaDlzZ2dja1J3?=
 =?utf-8?B?d1VYQmEyYUtDTEFJVm1JeWNvcHNYVFdBWm5QRTJuUHZmRFBSNGs0REhOWkZD?=
 =?utf-8?B?Q1UzMGFKd042L3dCSjFrSmlXY2lCT2xHVU5WUmtRM3ZmbEtkUmN4aHdtdmxw?=
 =?utf-8?B?TEFUMHRrTlZORGVyNzl3RGxXdGh0S0hKY1RyUzM4dnBwSm1NOFVmUG5FVXZI?=
 =?utf-8?B?VzMyM0FmT2Fxdy85YVRyUXZGVWk4WHd3aFMxRFFsdWJpanRRMG1KMnhLcEox?=
 =?utf-8?B?ZUVpdU0wVFk3eHl0akh6SHI2NHlGQ0lmS09Vbkprbi9TSEJsL21MUWMxTDdC?=
 =?utf-8?B?Wkp1U1QrZ08xK1VPWlptYy9PS2l5dVlpNkpPdjZJc1Rkd3NlY1V6Uk5CK0ZF?=
 =?utf-8?B?VUNDQ3d3TUNNSlU5L2huaG1DejN2MjdLMStWSkNieXB6aEZ0THFFTFZyeFJU?=
 =?utf-8?B?NmQ0TG53NHgvTnlVOGVtcitQbjJURUIxVUNHSFlmdEVha2lDWTVYMUcrdUhN?=
 =?utf-8?B?cmpEWi92Z1NRTmpWSWxaQmRuWE1UM2taM0VJa1RTZ2k2K2haZzFZaEI5YUNz?=
 =?utf-8?B?ZlpQY3prQVNyQkxCYm0yOU1xWU8rMldLaStOdXRVK3VQZTlzL3JQVzFyYkw3?=
 =?utf-8?Q?MhNUWHVvX3fdjordXfz97gi0e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nOy2opOmv1uAQ7c2Tdj9vm+FX7+9ZBsJHOlJ8B1Bnb0GPIPCBUXGP58hzSOh/nI4NGpvrXNjrLTCjLfFJ8cLRG2DJlwqF5rnpt14k3SbcMCja7YKm9z1VV9AviDQEgDRt0qRl8ShvjiAupgiWpBIecxlP4zmm/IppboJ4dtG7hANZ/gF7I4MDddlBlNoBXu5J1T/M9p6svxSLt/KeymSiZWEnE91XdxCzP5HTk3i/LPNrEue1p8JdjYAUtkq3iDk9kufcD03Lc+paT5rzFovUpWfkriXqKCMRXWDAWq/Zik/hwCzTVY+69AtUFgPaGqoUkuteGWZMHms/MOsPpnkN7do/8BUlGfxFXftdUwqR4NMjs4O4MQ0EBeUrhLS+RyCQmZF+SD+eLwKaQPEYI7y64DLYuHZ9wVa+SqhF8cl4vVo5643jF+puXElGa/j7IMtZ3QbNKk/Y+WzV+4uLq4WOBt58INdW1tFopSOYwUWs7YRhuHucVSF8Mw/h0+iWwWNP02o3Ku4+L8BGpa9YHhjGD+Hsi+O9nGgCcMTRmUMoAUfKYMdn9YqmEEqzrg+2HzUxQizPhLvuMGevwnafCnrj9GtNmokZdsuUCYqgNARAFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26379ef-ebc2-4757-28e8-08dc5264d813
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 16:00:25.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1gTctlEJla8QQ4t9oMIjFhhYHlIp0395SErEOEEZ4PC3CSwA3fwnwOZd/3jfveh5aFvt41QFD0Y00q36dxRTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_11,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010113
X-Proofpoint-ORIG-GUID: 6cU5SgWdmrUiYaSBskbELDOvBFN_7Tci
X-Proofpoint-GUID: 6cU5SgWdmrUiYaSBskbELDOvBFN_7Tci


On 4/1/24 6:34 AM, Chuck Lever wrote:
> On Mon, Apr 01, 2024 at 08:49:49AM -0400, Jeff Layton wrote:
>> On Sat, 2024-03-30 at 16:30 -0700, Dai Ngo wrote:
>>> On 3/30/24 11:28 AM, Chuck Lever wrote:
>>>> On Sat, Mar 30, 2024 at 10:46:08AM -0700, Dai Ngo wrote:
>>>>> On 3/29/24 4:42 PM, Chuck Lever wrote:
>>>>>> On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
>>>>>>> On 3/29/24 7:55 AM, Chuck Lever wrote:
>>>>>> It could be straightforward, however, to move the callback_wq into
>>>>>> struct nfs4_client so that each client can have its own workqueue.
>>>>>> Then we can take some time and design something less brittle and
>>>>>> more scalable (and maybe come up with some test infrastructure so
>>>>>> this stuff doesn't break as often).
>>>>> IMHO I don't see why the callback workqueue has to be different
>>>>> from the laundry_wq or nfsd_filecache_wq used by nfsd.
>>>> You mean, you don't see why callback_wq has to be ordered, while
>>>> the others are not so constrained? Quite possibly it does not have
>>>> to be ordered.
>>> Yes, I looked at the all the nfsd4_callback_ops on nfsd and they
>>> seems to take into account of concurrency and use locks appropriately.
>>> For each type of work I don't see why one work has to wait for
>>> the previous work to complete before proceed.
>>>
>>>> But we might have lost the bit of history that explains why, so
>>>> let's be cautious about making broad changes here until we have a
>>>> good operational understanding of the code and some robust test
>>>> cases to check any changes we make.
>>> Understand, you make the call.
>> commit 88382036674770173128417e4c09e9e549f82d54
>> Author: J. Bruce Fields <bfields@fieldses.org>
>> Date:   Mon Nov 14 11:13:43 2016 -0500
>>
>>      nfsd: update workqueue creation
>>      
>>      No real change in functionality, but the old interface seems to be
>>      deprecated.
>>      
>>      We don't actually care about ordering necessarily, but we do depend on
>>      running at most one work item at a time: nfsd4_process_cb_update()
>>      assumes that no other thread is running it, and that no new callbacks
>>      are starting while it's running.
>>      
>>      Reviewed-by: Jeff Layton <jlayton@redhat.com>
>>      Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>>
>>
>> ...so it may be as simple as just fixing up nfsd4_process_cb_update().
>> Allowing parallel recalls would certainly be a good thing.

Thank you Jeff for pointing this out.

> Thanks for the research. I was about to do the same.
>
> I think we do allow parallel recalls -- IIUC, callback_wq
> single-threads only the dispatch of RPC calls, not their
> processing. Note the use of rpc_call_async().
>
> So nfsd4_process_cb_update() is protecting modifications of
> cl_cb_client and the backchannel transport. We might wrap that in
> a mutex, for example. But I don't see strong evidence (yet) that
> this design is a bottleneck when it is working properly.
>
> However, if for some reason, a work item sleeps, that would
> block forward progress of the work queue, and would be Bad (tm).
>
>
>> That said, a workqueue per client would be a great place to start. I
>> don't see any reason to serialize callbacks to different clients.
> I volunteer to take care of that for v6.10.

Thank you Chuck!

-Dai

>
>

