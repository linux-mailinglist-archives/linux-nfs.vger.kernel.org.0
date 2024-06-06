Return-Path: <linux-nfs+bounces-3574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593608FE80D
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2024 15:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE36A1F25CAB
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2024 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F84195F1C;
	Thu,  6 Jun 2024 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ajx96UxD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lQwVA2fl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F113E048;
	Thu,  6 Jun 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681256; cv=fail; b=LxF8jRFbZpKpljdsf72zYv18NQ30FnW5vURMSjID/Fwb0Ic1g2xP9p5YP6+sfpXP11itOtH6UwpMfYa0bubZUCT4psakJiODt2KNdOw5oqNqVhdVBkdHKnArTK6j6lLysgas03P3WHo/rC9trVDv/6puNulShgJTzDZ9sMrFd00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681256; c=relaxed/simple;
	bh=mCMIBPJrbUYuDhD7YocjPvJsLUakXFgq+Hu+bvT+bLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rEeGslc9aEzLtzF/QphFEORtzkOXpWCwwcku7fHaDa1qr51g2mxPJm0VRH+8RWdGNfgwvp98rHrcSV4Dws5t0wKyFEUSfXQyddHk5MqoaHGzsksIsD1cU7yO2eK0Nk7tVmcPK4rZRjbjcoa0qEhN4QDkkulyquxeAHFaOFQAQ80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ajx96UxD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lQwVA2fl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568iMfk016280;
	Thu, 6 Jun 2024 13:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-type :
 date : from : in-reply-to : message-id : mime-version : references :
 subject : to; s=corp-2023-11-20;
 bh=4tCx7xJ8Wdx4Fnwo1cFpw8cuahtN0zKP1tZnqN22cCI=;
 b=Ajx96UxDQWDTlQvn0Ms/xzyuWZ5U2mD8cXeNV/N/YXXVQ6zD3cjJgm5u/BxftYTEx1cN
 87Ot+taaDQq1N1E7d3aFmXkg9ytwyc5kEg1YqUqNgSKIzKAPSwASCLy76f+MiOCcZlb2
 ciYTeoX+NDB0eOi6bXpcf175Hw0d32vsfuGWkHtdYcV/oB6xxFuAOkcFjw2R9Vk7yf86
 lZup9gXQ9NbB4W/G7v6hdHPqJgHinop1/Q19p/JF6L3qFqy3HPo+uBSWZnTTs7GPIjbH
 4YokzMwHUHF7AiK1qzX3cmzytg9ms64MQxnFxvcpLApN4udfIiqw/N4Z/jnQyKZK9k0I jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhbj4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 13:40:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456D9OIY005463;
	Thu, 6 Jun 2024 13:40:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmggtm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 13:40:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6nJbYNIBEBKT1ioNCcBggZOqPLF2ZuQ0dANOjml4H86I+4qqWwhZ8UyFT6AyuXhDaM+9LuPGSmj6/SNBUBkQlAkjs/rH5WvWu8VBlTaYwkfRqUxJe6l4CYwHWIHiGAhY8+EUDYjonP9yUjWxfSsOX3V1TPGhkz+uMp7leMNV7vLPxt23Og3rV1HfK+FDgyTKD1WAhSHwqD/Hl4c9cMxab1jNceSydMSosAUUKMhVK6ePRMkLpGN3Um6lrT/x/EfuIfXXsaPMYaMslr708F0IxCcYZSmzMQ/SRq+BprsRmTJR/OTXkWJbB5tHLXnkYjakQBBKBcN2vSBxAjW4VZqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tCx7xJ8Wdx4Fnwo1cFpw8cuahtN0zKP1tZnqN22cCI=;
 b=k37Z3BYriAJQVLrix5mYj5Mx3nHquEBIbNOucWVgn4m943Fnj1g/RTeiRC8NHJZSJGkajq+u7TDPsbAoBFN2ULJUFXwjvIWx4c6uOTPVyKnLTnUWlhEbhSHEjnEFwdvWF7L4J9lcyS1W5SH3ySgmQUOoSGHPwXh2TwokFzXGaLq3kRIDr8h4VGyO6En4ig6K9jmtZVUP9FuX+9glJcKUNY7HgWrUVPNhCR0LjdqdGh6z0IctHRA675D3tdQn5KEibjoP5Y7SFWFgvyy/HJTZOnM14JUQK8a+1Sa9zSJ3rMMjynxEOq3DDI7hpBlPey9qpT7f2JHxAPhF3+vPCiBWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tCx7xJ8Wdx4Fnwo1cFpw8cuahtN0zKP1tZnqN22cCI=;
 b=lQwVA2flTvmwt1HnvZfJK8d5u3XucmidkyHN3nouqeXe3GCbggOS+Q7RG3QXSxcjQIV7iqUeKG5UyOfq1SFLUpBY3zGSu76oMS2BbPgkGZXx0Qj45MVbnn4IgCBYX/R2j8+Zl+Qec7LTApuYg51T0gmRzV0neSuzG8wX+b72c50=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7596.namprd10.prod.outlook.com (2603:10b6:806:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Thu, 6 Jun
 2024 13:40:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 13:40:39 +0000
Date: Thu, 6 Jun 2024 09:40:36 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v1 1/1] lockd: Use *-y instead of *-objs in Makefile
Message-ID: <ZmG8VDyH6XHBU1zq@tissot.1015granger.net>
References: <20240508151951.1445074-1-andriy.shevchenko@linux.intel.com>
 <ZjuijMla78l+sl5S@tissot.1015granger.net>
 <ZmDU3q1Vfv9xkipa@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmDU3q1Vfv9xkipa@smile.fi.intel.com>
X-ClientProxiedBy: CH3P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b9d4d7-ec0c-453a-8db8-08dc862e40f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tnUa5lQI6WmI23e4f4i1Gh577XpuPJmtbMSiUVxD0qPcGtuA24fb5T2ujTfY?=
 =?us-ascii?Q?ette0MaGc88LYlAZhnIRA4NjLlF5bCvJMln7jv4X4oB7XagKSJ0DLTq+xtz9?=
 =?us-ascii?Q?N2ssh09LOkjolNy+g5ACvBeMs81HsgI3Lp7o8QU55dcLrdayj2+NtCl8gZpt?=
 =?us-ascii?Q?eTairG9CvRW+r1u1HDiN0oJLINrdep5/eyT5PJR7h5FOAVVnSRxaukFnTRRC?=
 =?us-ascii?Q?Y0El4w+E4xa6V/gRU3OvAe9cN9RscNWumO044TmmcAwPpFdOv7T8NR4PqM3W?=
 =?us-ascii?Q?dLofAbxs+EeYg3xcZ9zVLGx0JQS7ODKyrOuO22m6eTUIYDwRf181axjBlLBy?=
 =?us-ascii?Q?bKJ4XXxXG89gReBUnacObTKc8wUwALht8PRbCtK4kyiyLBUSyHPZO61OT1Gg?=
 =?us-ascii?Q?EwBTF/TKnd3QQC8Pl8nml5tU/8sK7G8iVTGAEYs9HMEsPlI6l9n9au0N21Hp?=
 =?us-ascii?Q?kXWkoGezfm/ZZAcXHzAvGG7ouvMV3bSkvqcyePxDTRqoVhwB4PDtdpN8ldVD?=
 =?us-ascii?Q?iDnFMWi/kq0qswHX3kW7N/hKLa2P+v1RZFkDMarrMyM/qGA0GVggjF2GWji1?=
 =?us-ascii?Q?J6i9R73lKjr0LjlOXIWBqhUC6Zwx9EATQMG92F+2yHre48Ii4boBD3JrUcLz?=
 =?us-ascii?Q?nX9F/MdzJzwhFf4aFOJy+0qe0hpqOIOx/p3OtIFvV5LBMtxLwwhcqxn/N4sq?=
 =?us-ascii?Q?UyrZawOH+VoX3mAL/A/XyaWLfYykMVw6jSRPX9ooHjDMbT4TVMgTNu+ZUt8v?=
 =?us-ascii?Q?9tbjcNVbNodpp9mrIx9EbmapwF0CkKEH3/OV60TIswD5cv5RXThPdqphRtDW?=
 =?us-ascii?Q?dLPBX5yZ61BzIh6PKJWP/8+Pf35e7d6+8LqsqM7mdQnqRXRR/yI2SNF5dfD5?=
 =?us-ascii?Q?t5ONswC4LfQiJiPNqqdaQDkbaFlAaQzRqtN2lvpCDhBGPnkZltlAPQvxhg9v?=
 =?us-ascii?Q?Yif8ST27iPQp8kcYl1tszBPE7+NzIQaL8erJ/QDTkb7e6KPQSM2kaoGw5afB?=
 =?us-ascii?Q?z+zulu+vVQJgBqyyiACVWsdnu5evkW7zN1o6NTWg/61pWr7uq+1f1q3fK2ue?=
 =?us-ascii?Q?fceLR7DUvoiiA5Qhp39NX4GmGMWYN5qKAN26jUzUQ/SdFb7gosHGLbXqXvVC?=
 =?us-ascii?Q?iVhb51dCNUMI6OdW1Kx9bFYvVO6SKP9kEXhirvZVPuHeq0TFchAp4TF+C4i7?=
 =?us-ascii?Q?3mWbkNWmZvQb530NHihGs7Sgg9czAvoD2Xmch+5OlPGdjdfNEeCsKzsOuubY?=
 =?us-ascii?Q?C9QCuoC1DwfnmCYXsuMgddHrr4YjLtJslzzNSUPCWrO6gSu3DWTdb5udVOf6?=
 =?us-ascii?Q?z8kPUbRfusdPl/5rgknLSENk?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2bSndOagacpd8OdXfO0biWX00Nt8iqvJuCslSrTH9zVNKT5wpaRsUFDaKXaq?=
 =?us-ascii?Q?CiVP/Oq7hdMLr41bowfMqxKxFjA6epODeiL5MiVvBc9Ef1O+DV6BsUZHu+eY?=
 =?us-ascii?Q?NNTP2K5tuW/eTP2YZznY7lwptWd9/MdqBCyMk8xcOEGPTQUfklbSCp5lPA9b?=
 =?us-ascii?Q?DOngAOVVWrbzlxj3UVb83xRfOGQAVifaX388HJjuulwXpi3arXjKMzDBfL7G?=
 =?us-ascii?Q?6PAo53pj9n6TEBm3zL5D9UZ9rMYFrnhEVoaCdOJ1IjcOeKV6FCultNSDafAH?=
 =?us-ascii?Q?V/oqJPWWcgQwsUsBNeOq1fY1i1hBe3VmQHwW1jxCfAuxND7pvtkvpuDa72sf?=
 =?us-ascii?Q?7SwWfMGljDmoI9VyouyQcN9iT0Hv2bXudKt9m8nZk1yXJDp3cxE95MF6WXX+?=
 =?us-ascii?Q?h937ucbT0iD5H9ocjV9CmL76VP067jsbPqcGw/lpFBVrG+F0Bevv/3Gli87R?=
 =?us-ascii?Q?7uRxPeBwzFlMx38F7qIS8F36MdWkFLv2VxnwAzkfuU7oxGBCJ12yIwnZ67Zh?=
 =?us-ascii?Q?oIOYI1B5gk8PwJZSaVURRT9xDhcfkMXbndn7U2Hp08ifhvCxRwZetTbr7CWh?=
 =?us-ascii?Q?ZchDvQe9ml72Y+oLuP6Lku8qCMv84BJ1gdlRzcHtjKeVGrL6nzWXeTq8384x?=
 =?us-ascii?Q?sq8zbTv5Ky1bSpOD/Hayo/wL/GxlXgma4gj13SY1jzj5s548DS7BL7YL/TVq?=
 =?us-ascii?Q?D4Gqq6fZX054HX2aWUgXGJvh55JWcq76/2MyFEll1DmVaBn/l/vtbnWQJXMa?=
 =?us-ascii?Q?I1iNRmZzAKSCJ7tewO5eoIDUBe4BZxreGHG4QY0bRDmPBj7F/KdDDglj2Fk6?=
 =?us-ascii?Q?5xd/rzC2YWtT8Yy5+AaN2UiBz/tnfEUobeLpotEldPN/EHk0BDYajPm05seh?=
 =?us-ascii?Q?q9oBnGfIiCDZYas+H8v2hmVBgPXICuMYGb1AiXZsC+G4WcXT1yEomoe4Y3uA?=
 =?us-ascii?Q?waymXkbQ3WnV66YaCKCF0N67VOPm81WuRQ44jw/otsKhuvLm6t9VgIk7G4+d?=
 =?us-ascii?Q?4k4F9XxLjqDqTJnXOnkV/UJlWXcNqn2IhhQ3EexmrAwVUvIoDho50P4wkYvc?=
 =?us-ascii?Q?v8d5WEvMjpPBp/OqdbH39e6dlMREoP2QqiH8gTJUQ5i658M3egJvyH6OMEZS?=
 =?us-ascii?Q?VBLcKkswevNj7Gn1Ccdc0lY3VDA2oba8FmQOJxKfuWAF7js1tRWeRTRaEwRp?=
 =?us-ascii?Q?gUREaxJcViDAHyxhMlT81AxCHe5gQBsNKKUteu9iFRMV/amnuFUhHewe4JgI?=
 =?us-ascii?Q?l92xpbxXWBK549avyydC2RzjsTVZvRXQVMZGJL1j18KWxtQACJeT65Ob5f0r?=
 =?us-ascii?Q?ZbaRVpJ5JXvu8BZBsLzCk7Oea5vTa8QSm08iL/6fW0Qv8Jpw2KEyCVFPuFKd?=
 =?us-ascii?Q?LsT6AMvmF+SgPi3WrE7xdLeHpnrQrCxI5f0nMWXVSBH9mI6F5OGOs1f/Nh6r?=
 =?us-ascii?Q?hks5+ehAD4QDXeClEa9M7kkkq4tDbNFsyt9DEjm9wzEk5qtbuKlbJB4sxJxp?=
 =?us-ascii?Q?pMp/z0JQL7Vx//UUnsENNXhPH2w1LJXHmvQ5oiQCiouhIQ6lYHefCgK1L6Ol?=
 =?us-ascii?Q?SMK7GRQGndzh6bblg0zf57XkYAFQB4xd5SNbhdvwsmLKuD6hAuWwjLYDmjTD?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+6PwKhelMB8apmxrKPJcFeWpW+6sFK/q7HcFTpoMgxaRjuJtuFBJ0WYe6SA9qBvAGWlWxFer79foqMRXdyPdzMcMbOPn+oFG2flcineKEuHaykA8QPKYTvpFQiXaZjW4dTYOpWMjIpygU0YXXnTbyMbCA2pOI8bJV4suRNAG8EXULxr3JQ7dc2JNp3txDFYKFNRgnVfCY8kny46L3Py4u93tEQ7F94qn4+r0idPoGNxzeQhTVqwFQ+Lhybwm9VfMbmXL5oy0EhSkgh9rvU3UPrwNwPeFqkN73WkKYRKOfZvsMEzpRUi5bL9GG2OfZ46mcfxu+D5Pb3Qg4RCSYbB3QeVMJEJT6Yx0A5oghWLg+sGT6mZ2Y8C9OhPw39Z0tTDKgXkFrWOvcRzSSOP9My5lNdThSfHCw0EFx79nY/6unHYKVm1TA0zupUYsRx5mB3U+Tf5u/HvQD4O+5avDK8l3d6cBWwxb2IaZ54mx+2xG9IpLPMOKw9pOA9zwlNgyGZXSgeWMQEUmowCEYtXLIb8OuVFFo4OAK/COwFv6QOqOEfAd7b/13d8mI7RzYiQj/7PzDdSQ5X5IzX6aJtmy7nJKD1rBZ91sVHjcnavroyZHM6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b9d4d7-ec0c-453a-8db8-08dc862e40f8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 13:40:39.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8085BveYV+/OHZ6lyVlzUOUbSqYsiBQEhHggk2EwPug3qZMbpBLLbLmscol5/mbF2c5QUNxoZ61gSTnoK5QcIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060099
X-Proofpoint-GUID: BlUb-e-oODnw80D5U-Om-JtkjdAFY5JN
X-Proofpoint-ORIG-GUID: BlUb-e-oODnw80D5U-Om-JtkjdAFY5JN

On Wed, Jun 05, 2024 at 05:13:02PM -0400, Andy Shevchenko wrote:
> On Wed, May 08, 2024 at 12:04:28PM -0400, Chuck Lever wrote:
> > On Wed, May 08, 2024 at 06:19:38PM +0300, Andy Shevchenko wrote:
> > > *-objs suffix is reserved rather for (user-space) host programs while
> > > usually *-y suffix is used for kernel drivers (although *-objs works
> > > for that purpose for now).
> > > 
> > > Let's correct the old usages of *-objs in Makefiles.
> 
> ...
> 
> > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Unless, of course, you'd like me to take this through the nfsd tree.
> 
> Why not? Otherwise it seems nobody have taken it so far.

Applied to nfsd-next (for v6.11). Thanks!

-- 
Chuck Lever

