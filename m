Return-Path: <linux-nfs+bounces-2010-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFDC8592F5
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 22:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CE11F221B9
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069047C083;
	Sat, 17 Feb 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MRfbn4UD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aCeH1PQX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71A7F7C7
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708205245; cv=fail; b=C9F3Sc+KQxNTm1jah/hMuRPUKtn5Xwvym9qEFx1X6oScRdd9Xc+zupEvUyepX6NbmZpxPWkEFo1v1NSwJIXwyrZvMI40Moo69takwu8Fi4LNhli3a00iiHzxBpV2FBHk08lzN5MUdJITfKVG0PyYtojzz8VwVD8Atvu8TvbUAQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708205245; c=relaxed/simple;
	bh=K3gZM/qZhfcVblI2nNmzFcLKCskGsjuZdR3b10wYde8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O6pSSsu1uoNLRdbzi7s7ktyCkNDCvxv1YsHtt+SyQLwDGcPaFxQtCpweuOMstCyYS7ikrnHZo2OZCJKdfJHyUvuTIwfDDOD+Heoe2Xp+DrjTry/132nSlzy+M3+xsvWNlCllLGXg/rSUUa+idZYERcSez2XsK5+zmc/EOEkaNMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MRfbn4UD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aCeH1PQX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41HCERq0004888;
	Sat, 17 Feb 2024 21:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oE2Drld0nqfYEizH/z1hJdzxHy2t5ZMafmAyuaw37do=;
 b=MRfbn4UDzTT4MBfFTJHdzqbimrLmVU9zAeKQCOTuiak30tfV+BUhUoay8xGlPMYsn+/O
 Mu3vLUDj93hQJ/5Rmgrr8HM/ndblmIdeUbLZGUhwSFO1Yy/EWif6yZrvl9xsHlnci6/B
 XKKn5hxvfKGQqeiOVEOg/pD7VhHI6UYs7X/9O7BMUcWMLxtkyKBwLy2pEFv+OwC2SiFj
 G+8/gSEKuR8yJfEkndzsrJqpwzfpKo/dP8p/bJyW1NhxczJ3r1IifiHOdfGfr9yUt/bt
 KTsHvVO+Hj9xb8GWBi1LDGkVu4rDH2g6aYVI20etVa0r6uXhby6wYoGLl62+L1N8cZJV YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wampas52m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 21:27:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41HKOKV5016265;
	Sat, 17 Feb 2024 21:27:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak84919m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 21:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjm0DsRd/A9b7pEE0RGWJcdpzJmdUFF1SDDbXRSyjCXj84ocI504TNZ5+95XGIFp9hYPo9jiKcSzGGpBQDBHyKjY+0HZd6oanLjyrd0NaBoHFIQEgLdXLmRaQSoaba4qRgR6PP0mPC6pVDoR1uZRZetRs+QMC7PZNMlDoRrACB+/npm4i7Hw5ztPk5nuRSsiEeD/GL3sfQDa9XJ5g8MdpbvEZHKEGayHyQDJPVnmd8Zg7yx9/hTnzq7p9Q0QtMXLgCWnxTAdvpr0Kra3ja7DV7qQW6XXdRNIKqUuDDLQ0P8hMd/Wv9MMfgfIL83Nr+TZhTC2qB6us65dci3dDKLrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE2Drld0nqfYEizH/z1hJdzxHy2t5ZMafmAyuaw37do=;
 b=mnTU8UYPGd/hZuXbN3o77a+myY1XSGPrAK7nUOowNi0dsy+uoGQlFcWCiLtHdnNhZV+wUPLb15yV6F++35YiyABxTyxZyAhQa6Upi4LKMhyyJ8BgtEs4OZWdxT5ZrTfYN+2GKoDrCJAK/zqCD1Qoc0hsWeX2nCVcQawcaCq6jNPl8ZH9foUcIYu6P+oOpTdRaJayNb6kKB1LcMsn6o5mdjPvNgN+BFNcZWJiNinfn79IzM0yCbvuPWfspKmDWfVYCqmUK6Zx1IEXqAstYD9gR9nPRz0Rqu2XNSdwlgBMhBm3Nscy0n/Dpf0iM9TMAwumOBq0EIUDOEWTUpbXMKiCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE2Drld0nqfYEizH/z1hJdzxHy2t5ZMafmAyuaw37do=;
 b=aCeH1PQXfYUyxiAZi4mr3RfTa9gRdojgBYY7wGw8MpiUlW7ILgUdUtyJyEu+sbdPzqXc7WquI4erw39eNvEf6sBDPivae84FYDnIklwbmgzslhONTQNz6oU0zZkYF1RCaQnk7NLccq5rb3KHghGnAGAr7k96NGOQKMce7k1P2xk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA0PR10MB6745.namprd10.prod.outlook.com (2603:10b6:208:43f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 21:27:17 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::9a8e:88e2:8d1:d51c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::9a8e:88e2:8d1:d51c%6]) with mapi id 15.20.7292.033; Sat, 17 Feb 2024
 21:27:16 +0000
Message-ID: <9d3c4355-3a71-4127-90a9-73d3122f92a3@oracle.com>
Date: Sat, 17 Feb 2024 13:27:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number of
 delegations reach a threshold
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1708192859-25002-1-git-send-email-dai.ngo@oracle.com>
 <ZdEgpStNxUc94j01@klimt.1015granger.net>
From: dai.ngo@oracle.com
In-Reply-To: <ZdEgpStNxUc94j01@klimt.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA0PR10MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: db2bee81-ca80-4e23-d97b-08dc2fff3710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QkCJCp/wRX1QAdbLwN3wgpWe6Lif5lZ7O2SyFeHqQ+2t03q0/LCv0hVgqni/qbeaCNP30MdPFO8Tf15IX2FS7i4uKOw1kU1mxg/R8QMsL7tfohMjD8lnXbhBwyNcba2lj4uL9ehSFVaUYX0sFYOqSdpfQF0qtFxFV3kODTXFRhddoWmak/h8NGWQ7S9+ruVehvuTw0eyd4lRmdys8lTlmIa7ysQJe6SmuQ0W8io1e+MVbw6j2MvNdV3aXx2ywUzV/0n9S5BMcKPCRyylDA68ActykMQq8AkHPiDZftAcco0llIXitXptD5x1hFA+IYoEhk35KGOvPaxHMTMh3EzcH5O3peDdAkY+M/MXlU+xmxb885R/Q2brXjD2SjSNC2SWBp/T+WNE5if1ftuKLuLfBw6XmRdfGBsFB+Rw5R4d1OpjLOEZx/yy9sTORuBGjxofeT8yIMywWv6Bo0QWpeoEmZQ+ranjHq9CturITjG0Ldnmqwj1/c+bdfq+q1W7aZSqlUFnyCLso92LZwF9NBB3+x+Svrhowaz/gMkASlI5jGM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(36756003)(86362001)(31696002)(31686004)(41300700001)(5660300002)(66946007)(66476007)(8936002)(6862004)(4326008)(8676002)(2906002)(66556008)(38100700002)(83380400001)(53546011)(6506007)(37006003)(6486002)(316002)(45080400002)(26005)(9686003)(2616005)(6512007)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTlZNzBEMzN6T3lBampCd2hvZGpHNmpQZG5DUHBZdWtXNk0zMC8xaTUzVEdF?=
 =?utf-8?B?MDB5ZnZHejVUUEo3K3FLckdTVnZxdWJpdXhUdnIyQTF2MzFhdVIzZ3dPQ090?=
 =?utf-8?B?SWsxSEpJV210cW1CWEZBeEsyMzBkUjFaYXBBajY3aG8ySDVUaFBCVXVIVFFQ?=
 =?utf-8?B?ZCtFUVFlb0trNENmNkd0S3hXcCtzd3B4SzZ1SGt4UFRqWFI5dFU2Y0RlN2dN?=
 =?utf-8?B?clpPdEFrcE8ydzREandsK05LS3RnelcxYnhrTU9HdHhSNnEvTFJZNHNuV1I5?=
 =?utf-8?B?cUR0VUdEWWI2OGN5VXZOVjNMVytBMm9LbE4vV1JzUVRtRXFSV0labys4emsv?=
 =?utf-8?B?alJjeDZyb1d4c3JDdGVYZkxJNlFnWHBCckZ5Q3QxWjdZcGVJbFBNTGQ0NDRR?=
 =?utf-8?B?dERNdDc3bWVKZXlzem93NnU3ZmdQSzMzWFNJT3JuQVRjYlJuWDFLbUhXSEEv?=
 =?utf-8?B?WU43T081RlRFZis4N2JaTnZHVlpiSzA0Wnk5UkIzb0IwcGwyN29Tb044em9y?=
 =?utf-8?B?UjM1V0VuVmpKT3FmQ3h5b2RyRG43TWVCV3JSQkY1ZnY4WEs2VXhZMW0wZ0Vo?=
 =?utf-8?B?NGpMZmdGLzRtcGFhcFpQRnorMEN1dzB5VkhtR0tMeDdyT2w0VEJtTm9JWHBI?=
 =?utf-8?B?NWNDQUZJUmZqdXRMWG0vNzVzcTNERDNhL21zYWhEeStzZFcwTWVOU2U1WlYv?=
 =?utf-8?B?Y1RGRFE4VDluMTAvSkVybk9MQUlEQzMvSUhvT1o4U1pSaU5OVHpGaDAwVmsy?=
 =?utf-8?B?RVYrcFBHNjFWYmw5aWk1b05SaHhiUndqcVdxNW9ML3ZLb08vWURNa3VOZ0s0?=
 =?utf-8?B?em9hdERCRGMwMEZ1WmRjS2h4d1U4ekdxV3czM2tnRFppcWkvcEtzMlZocmxL?=
 =?utf-8?B?QWF1eFRSVERocDNnUzlsSXdtWDhXZElhSlRNeDdUNnM1ZjNwblU1cDVxOUk3?=
 =?utf-8?B?bktpUGF6eFRUa2l5dm0rRnZSL3RaK2RsL25welpJQ21hMHRaUHZkWEdtWVll?=
 =?utf-8?B?aC9vcGd2V3JKM2Q2TjcwOGduK204OEp2ZW1RWUkxNVlEY1BqTy9JKzVCOGpm?=
 =?utf-8?B?TWdnZ0RpbmVLeUVvWms0ZGFnTktucy9pSE1aNzE4VksraGZqMHgwTTNqUUFx?=
 =?utf-8?B?cDhzTnRDQnNoSlBCTkFKOXZmU1o0c1NETC9JVCs4dmV0eDBhM2Nzc1VLMCtI?=
 =?utf-8?B?dHN5Y2FLTVFwTCtyTGloQUpaNkY1VGprMzFBWW9hNmN0bXVpbUhtY3p1VFNn?=
 =?utf-8?B?RE5sUEdYVEErNEVCeW8wcm0wbWdvMldSS2QzV2xnRjU5dWIwdXhXRmhyd3M4?=
 =?utf-8?B?QlBERHNnemd4Qkt4T3Z5VUZIZHlXd0lnd2xObSt1a0tjZXpjM3NNZjNDUzRU?=
 =?utf-8?B?Rk9mU2h1ZVdhVXJDazZGSWlyTEV4N0JsNWZyaWEzejhWMFpUa0oybHdlQ3oy?=
 =?utf-8?B?NXNWeDJEZnVUa2tubVVCSWM1UDNya1ZiRFZVNUFFNmxqcGxMQW1ya3hqdk5F?=
 =?utf-8?B?RXZFdVJZdzV0TFhjbit0M2NJanJpdFNMbXNuNUtRNnRuY1NXRDFPb3luYkZC?=
 =?utf-8?B?LzJzMHExUWtBZ0V5Y25XblNKbjB0NncrcXo5OEdQWjJIVFFaZ3hDdHNBb29k?=
 =?utf-8?B?eHR3Q0dPdGszdnZVTGl6aFkwdjl4THdEcXlXWFR6YTlJMzY4K2tCZ3dnNW5E?=
 =?utf-8?B?RnhJSkM5dFVQYUVVZUREL0hmdEVxU1FJWjZ3cE85L3Q2MllwMEl6M0Z6MWJZ?=
 =?utf-8?B?Tm82aDJ2Q3duU2F1U3RKUVMxM0VxNklmZ25oVGh2RmF6TFNKTTdOa3RIM0d6?=
 =?utf-8?B?NXdnOXJaaWdVZ0JyWm9ubWxvakJBdEVCdlNsdDNhd0NkaFUvenhxUmxjb1FP?=
 =?utf-8?B?d01kS3Zna3M4MlI4WVhXcllKUHB5OG5ocDJveHppQWNXSTd2bTdzeDlNMWRQ?=
 =?utf-8?B?SlhyQmNMUkFNeUg2L3JDdkVOWGxlMFZaSDE4NCtsV3NVajZvbFFxMlJ0THlw?=
 =?utf-8?B?eC9qbmpMbXB3RzZwMDFpcE9qMm9ZSC9WZ2p1R2xGenZXVEM3VnVXUW9SRXk0?=
 =?utf-8?B?VDExeUNBaW0xSkVvVHcyL1Z1S01qTE4xV0NPUG5VdjArd3c1WS9udDJyQlYz?=
 =?utf-8?Q?RelA5kko/M8RFZbCUj01RD5uz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2XFv7DhAdTAzpamytD64nDbhi6QF1WFGuHy23CVPH/2aQ5seidNjzPY6PPTgooEi4JWR1FxjBDmNn2V2U1Yd3tFRac8/mIpSvHDQBfKdUn0M5GUXLi/NP3KKTkOcG7cL/W9+P20F9SZWmJrEVJGFde7hJNrLELydfb2nf2GBcZ6FaWc40rOXnD2z+PjJ80Qdn3gohJ+6Ly9WbimWAk+hiSc/leUkkX7ljWWMM2ERmjYSyoQxfl2vGJBAvLWHV+5ZX+/AvkVALT4LlNwAkFo96j6LQ2DsU8SnZvKtyE4NFgOyKEFUaRY/QUKSR2Hg+Zrf5p3x6ZIF1+o6eLgusTCDfiWTejCHdoklj2SFwrs+N0mLD4nUMqCLlAdTPRdsWeaw/sREfLsXwyuzWF8eUfKH77Ntj93tM8DQaIpyPPhJ0NSoUjd3zYJTMbMUXpg+6Llbjnh+Zsh0u6pbsv7k0fI6CQRDjxpEOpVZsX9VKZgpc28NWehQoeHGr8ArRmvQhquyqPB/rLTNlHgwbT+FNzworhprYo6T6Zlh0DWeuiIIRwhaGk95xADIhi99uYjyKXPfqE5Am8Nx388QkUCH36QCynwEVasMuDY+QAJKOaB/M5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2bee81-ca80-4e23-d97b-08dc2fff3710
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 21:27:16.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K35qQDv/xwalXnCahCWPmFLN20w0csGy5cg+vd4BgwSrSrd7oupdACgFfFsDtF1jeK4pC8VbiSxg77bAcp+paQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402170177
X-Proofpoint-GUID: 1gf2h2eUqqk9kX4zxQ3fDMnBGuq9PdxK
X-Proofpoint-ORIG-GUID: 1gf2h2eUqqk9kX4zxQ3fDMnBGuq9PdxK


On 2/17/24 1:09 PM, Chuck Lever wrote:
> On Sat, Feb 17, 2024 at 10:00:59AM -0800, Dai Ngo wrote:
>> When the number of granted delegation becomes large, there are some
>> undesire effects happen on the NFS server. Besides the consumption
>> of system resources, the number of entries on the linked lists of the
>> file cache can grow significantly.
>>
>> When this condition happens, the NFS performace grounds to a halt as
>> reported here [1].
> That was a v5.15.131 kernel. The LRU problems were addressed in
> v6.2. This doesn't seem like a clean rationale for adding this
> reaper behavior in, say, v6.9.

Do you know what commits in v6.9 fix this problem?

Regardless, I think when the number of delegations is getting large,
it's good to ask the clients to release unused delegations. The
Linux client keeps unused delegations for about ~90 secs before
returning them.

>
>
>> This patch attempts to alleviate this problem by asking the clients to
>> voluntarily return any unused delegations when the number of delegation
>> reaches 3/4 of the max_delegations by sending OP_CB_RECALL_ANY to all
>> clients that hold delegations.
> I don't have a strong sense of how big max_delegations can get. Is
> there evidence that CB_RECALL_ANY has enough impact, reliably, to
> reduce the size of the filecache?

I don't have any numbers for this. But in my testing, the Linux client
returns unused delegations immediately when receiving the CB_RECALL_ANY
instead of keeping them ~90 secs.

>
> More below.
>
>
>> [1] https://lore.kernel.org/all/PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index fdc95bfbfbb6..5fb83853533f 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -130,6 +130,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>   static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>>   
>>   static struct workqueue_struct *laundry_wq;
>> +static void deleg_reaper(struct nfsd_net *nn);
>>   
>>   int nfsd4_create_laundry_wq(void)
>>   {
>> @@ -696,6 +697,9 @@ static struct nfsd_file *find_any_file_locked(struct nfs4_file *f)
>>   static atomic_long_t num_delegations;
>>   unsigned long max_delegations;
>>   
>> +/* threshold to trigger deleg_reaper */
>> +static unsigned long delegations_soft_limit;
>> +
>>   /*
>>    * Open owner state (share locks)
>>    */
>> @@ -6466,6 +6470,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	struct nfs4_cpntf_state *cps;
>>   	copy_stateid_t *cps_t;
>>   	int i;
>> +	long n;
>>   
>>   	if (clients_still_reclaiming(nn)) {
>>   		lt.new_timeo = 0;
>> @@ -6550,6 +6555,9 @@ nfs4_laundromat(struct nfsd_net *nn)
>>   	/* service the server-to-server copy delayed unmount list */
>>   	nfsd4_ssc_expire_umount(nn);
>>   #endif
>> +	n = atomic_long_inc_return(&num_delegations);
> I don't think you want to modify the number of delegations here.
> atomic_long_read() instead?

Right, it's a typo, it should be a read.

>
>
>> +	if (n > delegations_soft_limit)
> This introduces a mixed-sign comparison: n is a long, but
> delegations_soft_limit is an unsigned long. I'm always suspicious
> about whether an atomic counter can underflow, and then we have
> real problems when there are mixed-sign comparisons.

Yes, n should be unsigned long.

>
> But I'm also wondering if, instead, this logic should look directly
> at the length of the filecache LRU.

Is there a quick check; counter? otherwise if we have to walk the
list then it just compounds the problem.

>
>
>> +		deleg_reaper(nn);
>>   out:
>>   	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>   }
>> @@ -8482,6 +8490,7 @@ set_max_delegations(void)
>>   	 * giving a worst case usage of about 6% of memory.
>>   	 */
>>   	max_delegations = nr_free_buffer_pages() >> (20 - 2 - PAGE_SHIFT);
>> +	delegations_soft_limit = (max_delegations / 4) * 3;
> I don't see a strong reason to keep delegations_soft_limit as a
> separate variable.

Just to save some CPU cycles for not to recompute the soft limit every time.
However, since this is done in the laundromat then it probably not that
critical. Also recompute the soft limit will work correctly if the max_delegations
is changed dynamically.

-Dai

>
>
>>   }
>>   
>>   static int nfs4_state_create_net(struct net *net)
>> -- 
>> 2.39.3
>>

