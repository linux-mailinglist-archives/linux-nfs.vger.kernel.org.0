Return-Path: <linux-nfs+bounces-2794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C08A37F4
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 23:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEC91C2168D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 21:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9115217B;
	Fri, 12 Apr 2024 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LdSnKOrZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ivt7s/wG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01170152160;
	Fri, 12 Apr 2024 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957710; cv=fail; b=ExEGhjFy2nXYT4a1LjacSps9i1vjlZILFUBkQtSz0LoD/tqA0fzW/56tEPXrgAQNLnQssDZQzXAhytcoHVCLCL4UbnDp3qRVtnqEVyE5/3BS4SKXvpZXx2m4vjbU07rlHVHzID5gbqx+Un7/4rfkQ15A06e8SYQtRnAQkL7fEnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957710; c=relaxed/simple;
	bh=a8LxAgMYm6X6DOr+ztZy+Ia97YVO9QNBE/fMtHrySHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KgO8/Y2EKv5HhEZwL2rQEiITAJ8jdWCQyGg+DtQWekAmphkzd4SkUnQVBkEX+QEmjwwSwRO96XvO7czVMBpl+yLDQ+V1L/+IZeZJGwC+ePLx5Sl7rK7wFaY92kmBSHClpi1/5x9vcs6P5jRjzHFiw6taEJYsvs3S+S7CRi+sHN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LdSnKOrZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ivt7s/wG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CL9ALD031654;
	Fri, 12 Apr 2024 21:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=DG2FXoohrX9y+H7GenDID+JgzGxT4iyUIJehFveCJ8s=;
 b=LdSnKOrZzDMupUFCCt1Df3OPArpQHCIVJapwvHb/b2MP8r7VR+alOmgvxlaNQulLn6LJ
 aBEWjuM4BanvET4l2fJxyclXxBiYTv6fTU1BNdiLuVLVjBvRetSWQEM2OgOXx1XyDdEp
 kPXdt4AKoN1jWDZdVMmUCw/1nBmxFg99JAihSLuxji5A3MS+OGzrF67KhY6P6mnwwC3I
 eqjOgX84pi+ZsDsdgDxc5F1bCK2hrkstnbcCOpzVdhWNwiXOwG71cBZJFzAkEBUglp45
 Jh0uZgvtliTMOjl9mWjRlSsnUUdgKTyiPWOA0wjQoJkQJukApYR/jAAPcJ9XO3BvXzau sQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtfcmm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 21:34:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CKRuaE026408;
	Fri, 12 Apr 2024 21:34:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrsumuaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 21:34:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qug536Z5h2QWaL8pVQIyEADIVwYv58DQEqp6KFHkIlCZgNwi4bB9r2zZOeOESSRdc4NNOKFn92jmCtSVSyMVY2kcFaiOsJuY2mnVFNQkd+9oBOTY+M1MIwzfoNmBThvx2ImNrHB9PBrpWvmHoRiZuH18WSOJV8/yySDuBdAxb0GOpypW/7poZtTsps2PcQ8cV/oR8oy09HyRG0NHMKiZNYRydDKq1ifGxjfZnPob4Gj/z9ETnNsVBJyUu9MW1ajfvp9LXF9KJrgnkQx6K7fr5Fu7oz01hhIGSaLeExvcP30QuWBtxwI0gR8IZVrv0jrHeMZZ6cOt2beMRpVppJycPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG2FXoohrX9y+H7GenDID+JgzGxT4iyUIJehFveCJ8s=;
 b=KCmmj1U+rxhWt7VCruCoOv6decxAEg68avQru5kzKyGT5PqAYSKRDD+eGZ4YQjEszB2E6EB4ggyZCoaqiBqWSg0k9ufYJC/o8JfkODPFMLJtkQF6/5sLA9coGQwS7PFLO6U9F+pcOCkYhmtFFszzEIcjmMEgMaaNUrHQLSrHYHttLC2Sbw8B2T45sDoSnn4ZbM5UjkwLFHlU1k3eIRiOkOFivwB1Hp6BUk+fTu4KV15lxpOjLmAgkZdN89v96QQjqSP2SZw1weCaKQqKFJNMwqdve4Ig34GYpPTjrwQI//vfO1xR02VvQxLc3/IARWc3OY8RBjRNrm38C/M196Micg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG2FXoohrX9y+H7GenDID+JgzGxT4iyUIJehFveCJ8s=;
 b=ivt7s/wG+hrFOchjtLGbPz1TPUHLoKmtBjio3P4Q2hqWONtxWZgA6oKse8y7i4ArMrt6b7loe6yuUQfBDRgIyNA6RQOlVlqFX5q4l01tQJWWOBzhX8Y8r0Ipnk2qID20/Muv8dP8LOMvJR12IiDsW9riuiQPPv6E/NBUAmCfUmA=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB7586.namprd10.prod.outlook.com (2603:10b6:806:379::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 21:34:34 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 21:34:34 +0000
Message-ID: <11019956-95c4-4c35-b690-b8515b439eb2@oracle.com>
Date: Sat, 13 Apr 2024 03:04:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
To: Chuck Lever <chuck.lever@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-stable <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com"
 <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Calum Mackay <calum.mackay@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20240411095407.982258070@linuxfoundation.org>
 <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
 <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
 <21c9bcf9-2d44-4ab2-b05c-a1712ac1a434@oracle.com>
 <ZhmYS9ntNbDZvkKE@tissot.1015granger.net>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <ZhmYS9ntNbDZvkKE@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c21c93-ad0f-42ea-48b8-08dc5b38587d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	D4TRT7q4lj3QTmXIRVtO6qe5Xx8kG7yy0yKduqmI394DVxclaFI4blSjI7JZQa+1CarrFE+H2k19CDXK30DpJX9Ax4WIS2FXwSZbpmaMoOt+amWue12jvweWwOCWzGH9ZHAr2fp41drrf+oTfD9VAYvTa5Wyi9PUlvxAsg7co1LC7nMPB+fCD6mKKpgaADYI1D5pGTcMg8vTkjblpPlM7sWnMwNsEkm6k63K4QVRMAKO1zj1uizAkJMwGDVTipl2/vdwL/WeMHdL/a7P2qIkuf6hLum1fJXK+ueTf2hrZtdLZI5SPVk8dN5pwTK9d6XKOscGKtcq/hr6K8T9ZNCo/KqoSnqryMm4jJNmiEsUpT0xOCYYaNkEezbHraki6cAZwErg0xnwGk1bZ3lho7nqj+/0p6dzsVnI4R1yZBTOtdRCIRmotPoLwUloVVW4BKCmgVS1ar1kh+MTKMUbO6jDfPhwK7pU62ymy9xITnJR6v6+hIa2i+HJYbqKdgQRHg1TCGW7z6a0p0IsAuqAcb+fpqpOijYRP+7vqk6ucuZ6iUxpe55ZJzqwfaHhjl28HtT7ImrDcILreXlfEpC8ySjPhwHYL6RXfpvdZHv/A/+RAnrexvXo8HA4gZtqwBtAJqVhUBq7w/vf4I1mKBGBj5RQyHutXz4OplJxj/vQYm9Vdeo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SFdqRmVzc29VK2F5TVFxenJBWEY1eWNtLzQzT3lYd3QrYitMV0R3UlZtUmpO?=
 =?utf-8?B?VEdhd0JLT2xGVVFSb2pxK01UUmxrejJnUUUxcDlKOG5LelAyd1MyVmg2V3Vl?=
 =?utf-8?B?Ri9sZmRxL0dVdFB2MmttY2VYbWl2VzVZZStmdVd3SDgxdU9XYStwdzI3QnB6?=
 =?utf-8?B?ZFRiQ3I1d0g2bUZLSklyeEorL0R1L0hrVzVmT3BsL01xYjBQZXJISThQTk1S?=
 =?utf-8?B?MWRyRitqdHVmUUY2WVBIL0F5c1U5UEo4K0YzVGozK3hJZGM2RjdVN2ovb1A5?=
 =?utf-8?B?MTJQTk1JQ0lDemVIbTk2aFo1cytpUnVKRFlYNHRRVmx6bXMxQzFDTmJkbndj?=
 =?utf-8?B?UzQwWHFETDhpQnpVbWlya0NTbjdDeGkyaU1vVzYzdjh3cWZqdkJ0YUloMmFO?=
 =?utf-8?B?Nit4UUpidENjdUlDTi82THIvUEJjUlVZeWJTNzBFUzhuVVdzVXJURjBETlJD?=
 =?utf-8?B?RDRuZTVQSis4REJzajBOcU4zMWRHazFoU2FhSk85SkpRQVdVaHlqa25KQkV0?=
 =?utf-8?B?SEdkK0ZqRHM5ci93VHZra1VLZm82RWU5RW02WG9KWlQ2enN4U3luQ0Nqcm9m?=
 =?utf-8?B?dUg4RktYWjgrQSthQ3plQ3N1R052M2h3OVhmOEJRZnQyMTVWZmR1ZWlVTWRH?=
 =?utf-8?B?ck91UlB6Uk5jdTRPcmlHMWFuVFRvbWJ6R1NvWHBPNlhlS2ppeTR3UUxQSkxr?=
 =?utf-8?B?L2QwOXAvQ1NwZmpmRlZqKzh5NEZGZHdraWV0VUU3a1dxelplL1FvL2NzVVN3?=
 =?utf-8?B?R0F1QjhMakNuczNOenU4bVZ3TXo0WEFJNzZYZ08zVWQ1dlYxY0k1cmMxdkpy?=
 =?utf-8?B?a2t2NDdKT1hzYll0aExVYnI0RHh6VnBFWjVvZnY0T2lLampPak1odFJOdmNu?=
 =?utf-8?B?bGZvZG9vcFA3T205blFaajJmUjJGc3lnTlFCZlk2emdLVjZuTUdCZU9MSkxm?=
 =?utf-8?B?Q3ZVR0htN1RZamxRa242cEMwanZRRm5rMklENVBlcVBFTzMvSi84UDNzNmZn?=
 =?utf-8?B?NUtZM2tsNDZNMXZFeWQ0WVpZeHUrWlEwaW1OYWh6WW5pdkMrcUozTnhZMUJE?=
 =?utf-8?B?d0RHVFliMXA2MWlzb0N1R3dzcXN3UFRhRDk1a3Rsbzl3UkdOMTl3UCtEcG5P?=
 =?utf-8?B?eFBsbE1VWU56Qm9DY2doZjdGNEswMkdLdGJGNUxSVStJZ2FLU01zQ2x6Z0w1?=
 =?utf-8?B?QSthVjRKcDNPWEdHaXBaVWxQdEdtWUpKa05lVzJsWU82bkVjWE85OXpkV3VH?=
 =?utf-8?B?a3B0cVVoVkFMeG44MUFxNy90ck91YUZZSjVKWTdmcmFsTkJnejhPQXNJVW0r?=
 =?utf-8?B?eEFaUWVHQlEzdXcvRVpuUjIvY285WkxYYUpqN2NrNEtDeE1EOUdXY3VyN3J6?=
 =?utf-8?B?RjVLQzJyRHJHcTRmM1RUcVUyQkRSSUV6M0h6T08xNVVTLzlISkpWUXhFaS8y?=
 =?utf-8?B?MndhVlMvRG1kbVBKMFJpLysvVHE3MlVyNTU2cjB4eG43aHVHaU9xc21NUUFx?=
 =?utf-8?B?dzhjeDVUVjVNRkhsVkY0YzJ2YzRuWFY4Qkl1QlZPYno1N1NoejlFbDBBN2JF?=
 =?utf-8?B?bEV1L0Ntelh0Vktnei9oWG10di9pZ0FDTG1zZVhTUUc0UHNzNXdVRHpjSXdr?=
 =?utf-8?B?MXR4Z1E1UFJUOUVzQVhkSVhIWHlMOUxhclFzeXlGcDVBbDRoalFBMC9HdVB4?=
 =?utf-8?B?RnpoUzZZNjN1dXYyWkNYM3RNL3ZJQWhUNHpDT0R2MU9Ja3E2TTd0dHFxMSs1?=
 =?utf-8?B?TTNYZFdURXMxMWtQWitOcXMveldvaGE0TURVb0FkS1NXMUI0K2diODFyZ29F?=
 =?utf-8?B?aDYrRlVySU5pa0hJbk51Y3N1MEhWV1FLblhOd2psZzdaMEh0WjJhcVFBeVQ0?=
 =?utf-8?B?T0JsQ1dTOVliYTBxbGp4c095RjFtelg3QWsrVjBUeHNHZG9QWkU0ejRNNFdS?=
 =?utf-8?B?T3B6aDlZOFVmd0JFbmYyRkRZczI5WkVtZnpqZS92eDZVRnhaa0pFbW5qczR1?=
 =?utf-8?B?WnpseXlXQWdBb1VZSkYvbytSVTloQW1DRS8rUmpkMGlYanVoTTN1TnljU3p6?=
 =?utf-8?B?V0d6b291cyt4RHRSNTllWFBEU2Z3QytETytLV1l3S052QlJLMTY0Ym80ejZ1?=
 =?utf-8?B?SHRYdmpLVW1wTWZwUG9LUjR3YWFwNnpMNGxYQ2dvc2VPYmozL3FaZFZsdlJn?=
 =?utf-8?Q?3PzC7wcqtZONFVUavtz1lPI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Q5mTDoCfE7VGYJktzKiLg2yMehW3/bK/CujQ3XdZmlrcEU2QnVtA66Y2zqwkVI/ImTbBjC5P9kY7Epnxccigozc93iALLqD88vKPOZP8GVCtYhdTi3S9DI8npQqUUl6xlmLoakxPM9PYEB7DlFl7WIwgjiKtgbNNd1lV+2uxO50a7tu9PuQ4vM03thQY014M4JVTEfN9lTImt2aJwXKMLB3RgGxIfnN1L/Ib0WF1MeeuIB5/9eva2rvq9B8U57KNfmFCkEW9A/0g+mLoNKlQf+VbluGCH29A91uszJyuda/tLUI+Tv9lcZahR5sqsYyrUD8G6sxF8hW86zS/4fvWO4BgoMMPh9cqlwC0L/cBleg3TBZ67JTtAycO4DOteu7s7+Ipx5MDU43wempLEDSWcZmpF4DEllmstn2BbVsugTcg1WpsdBsYbzxUHp2svUq0ss2TR/NK4802IDqAufM1RMWz3RWDHoaRPw+/KCtwNxRNVFK6CfiYorzWS5hkKAH2w7zC6Lnu6qtc6OVI2v1cMeIsy/NjLbi4y26BW3+FZP5DZQ9wsDjfIFYP/nQQblmnEV5Bjgf7Rw3gfTZrxfB9EawNisCVrrC1eRSpw1mgbRM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c21c93-ad0f-42ea-48b8-08dc5b38587d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 21:34:34.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FErazKT31jUtFfTUlNk4Es+EjgQLLoHuIkxOTdWO1ljKD3rmJIXG2/JCKRoWFWcuRWOctVTwd3PX29qyILLJT5NfMMJY3ayWHWf/7k2bRBRyuES1lVZssHXriz3rZ+rU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_18,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120155
X-Proofpoint-GUID: ZGiaZ8aMv6ejbpUKCgFDIL89OnKMtx-W
X-Proofpoint-ORIG-GUID: ZGiaZ8aMv6ejbpUKCgFDIL89OnKMtx-W

Hi Chuck and Greg,

On 13/04/24 01:53, Chuck Lever wrote:
> On Sat, Apr 13, 2024 at 01:41:52AM +0530, Harshit Mogalapalli wrote:
>> # first bad commit: [2267b2e84593bd3d61a1188e68fba06307fa9dab] lockd:
>> introduce safe async lock op
>>
>>
>> Hope the above might help.
> 
> Nice work. Thanks!
> 
> 
>> I didnot test the revert of culprit commit on top of 5.15.154 yet.
> 
> Please try reverting that one -- it's very close to the top so one
> or two others might need to be pulled off as well.
> 

I have reverted the bad commit: 2267b2e84593 ("lockd: introduce safe 
async lock op") and the test passes.

Note: Its reverts cleanly on 5.15.154

Thanks,
Harshit

> I expect this is due to a missing pre-requisite commit.
> 
> 


