Return-Path: <linux-nfs+bounces-2005-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A885915E
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 18:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1371C2029F
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136547D40E;
	Sat, 17 Feb 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j/kWvSzL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CgiD3Wpe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC086519E
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708191787; cv=fail; b=QYEUSkr5YKcG4tOyOQmzYZ0iddH/ykXj+7u6E1fr8a2juJGoaIS35a3ujiby5+BVy84v3P0U/Y1jo75azndY8MupT1aPOMM94a0Il+5Ek6Cx0+qz86FXDkTDH1FfZB8GOXdT1wKb82berkTRc9z2IMzIHSABY9tqi+CTNxdhVzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708191787; c=relaxed/simple;
	bh=JIMgyL7lbij7ipBFEyUefJQi6F7vQs3QnzEU4ToTA64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nVYZzHuJYJOBM59zo6IF1EVeIV+Jngo3f99mEmgOZozLca8OBg2ELr7ca3Xt/V7UagNPzIVfjXfH8TPSrIR44mXGmHf5mi0S3hL/G9hZ6gOypaMfbe5pv2LBOluTO1toJ8tfVQclTFeCld1pHyUso5QU8t4k8UEbQ7nJMtMV2y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j/kWvSzL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CgiD3Wpe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41HCEW5U001402;
	Sat, 17 Feb 2024 17:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ucSZ+QtspAkhymgjYbJiBdKw3arjkn0GZOiU9NBUpEw=;
 b=j/kWvSzLLP64rjsSt2EOCYKgPtU1XV9Ig70Nn1fAK4a0sNKnmQABiC1Roz/EanAYSmY/
 /T+TdTm9WLByb+dcTvG8US+GA5mdgaTnTuYUcTMXQCCuK683EHTT2FoGt7P76QphUsPT
 Oghn/XDeUU5zTi/xLkJaakaY1+VRQhuuHwuDtI09dJLy5jKoMqlZhKgIrak4C3QujRux
 MqRYmoSy2qx5cOKrRVV6Q4isidibVfAZfMRf3D3aR24v7SVLjjfaWhwUCA52bXFMxe3X
 e0X93QVSQZq6yr+d1VkHshOUyxUNvAe53/DlsCEzEDr0NelKTX0bysWIa85F+W7rQGdy Gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd212cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 17:43:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41HFUe5E027299;
	Sat, 17 Feb 2024 17:43:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak843yka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 17:43:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7ASe/JmXmCDPGSB2YcVI/MrPdaiG4mRw3TSTASyNaa/3RrWSrrlVRGAe7fH20L46dT77Y984vgyhjPWQDD4ThGLeR7QkQN3M1uP1ZsnAeI6tiYr6sBblXGVTL/SaCsyc2N91rodL/OKML08dgy+gXT/UslHqeV7AZB/N3uFmNN9urXxl/af71tuNRbrHhV7hbTnxUlFbKqjz1iVfObKSc0LW9gd941a6sAluwPAiYmSqaGYymPSTpQlNVIzKwd31V3taix20cn3EUrJ0Ri6SqrkPB8n8BVtjcKNf5xmDQyRSf6JWK5YFR8xJOgX/sI305MSLIihZylYFU4csSTw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucSZ+QtspAkhymgjYbJiBdKw3arjkn0GZOiU9NBUpEw=;
 b=iqauZ4xj0WhsJIcrwOO+4mEOkWTO2euqXYMLk6elAy26n9ljpSegRwULfmbPRLNimCsRFqep7IpnVHzAi6S5gIKOqfj7il+c0ZhK+RQtfHzJ53BzghCV3zSZF8F8e19Q8FqLtQHYWYXhmzUAb934z0Av6t+c58ywdP9k/q1rhK1T+xK9fb1j8lb799kUbEm4weqOdYH7d6ByzN9BhGCCHjhhfNysziofrmEgJUi6JFGi2C1PS3QsLCVB8Umj+xrNOKVZP3U5jrnSMWLywq51Kx6AFaUacr59/QhgWNxABI1QkdvnBSTEeBDxiMNCo8YLIEWaL2ctHEm7XEfqL6IDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucSZ+QtspAkhymgjYbJiBdKw3arjkn0GZOiU9NBUpEw=;
 b=CgiD3WpeJ5OwX7VEZxBW99I0fiKzc/+6hSHf/fBcdzP/yI/Wlw5s1JOUON103b9zFohQVqojkRZ9M2kLpdolLJ7AgZqHfBgxwQfquBXWmHjKxRkQhD9kH02zDG5G1qHOnp0TQylpel3nbw8dXU3HJQ2TJ+npyIHgR9CQi6257a8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW4PR10MB6608.namprd10.prod.outlook.com (2603:10b6:303:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Sat, 17 Feb
 2024 17:42:59 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::9a8e:88e2:8d1:d51c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::9a8e:88e2:8d1:d51c%6]) with mapi id 15.20.7292.033; Sat, 17 Feb 2024
 17:42:59 +0000
Message-ID: <7a7f678a-eda7-4360-aeb1-67129af2b1f5@oracle.com>
Date: Sat, 17 Feb 2024 09:42:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH [v3 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict
 with write delegation
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>,
        Dan Shelton <dan.f.shelton@gmail.com>
Cc: linux-nfs@vger.kernel.org
References: <1708034722-15329-1-git-send-email-dai.ngo@oracle.com>
 <CAAvCNcDDb4L2tcbBCcufFg=TLeFSrui4MHFuEeNUA+1VZyXLxQ@mail.gmail.com>
 <ZdAXI1oAJx0atlch@manet.1015granger.net>
From: dai.ngo@oracle.com
In-Reply-To: <ZdAXI1oAJx0atlch@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MW4PR10MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: c60a9d5c-8c26-4ec9-872f-08dc2fdfe18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NQIM/7K6c6Z2Pd25G3aVdC6fNLcl5PKXPtVzlCJ1PPC0XjGlUji7iL6/9J7vxCY7Kg1RsVDqAc6Mp/EshBRU9lTHE1ZqxefNwaIiO2gZQKkOSa+wl5DnVLcWsIATPmpmdhoR3pszplS3diNqHE5mJfB6w3nJXunOXjDg0uZDe8gdv4+bUB1tR6FL3Nb7s2XpXptYU3LeIAC6XdrmgUgCWn1FvssuDP/8LUILHKGwr9lR+tM8P8OP1WX9bpT/NeDZ1MhO7po5kyzhdmD/n6wIwhCQZ9It8o4bqTBQGknGUEHHVWoPxxvB2TTh2+I8RNzjIwlacgOibzL44rz+dqPMXUUH6PcBIkEM+EEP3QqpE6Kh+1D71BBNnOx6RuNzjAYwQhNSGKE+wWdeXhBjieKffPUC7r4OIISRDJhQeLHWHcPd68HzysUulMSzjNLX3KlyY0vaR6pmznHAaX1Sc3RD86rs3q0fSMblKocN/0xZEsfJxjwug4mb5GduhjAYXTJDp9iaqLQRG0qx7g4shKHSqGpR3nWILT4upI97krshu1x3vYyZxwwnPVk7H9LJDUwR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(5660300002)(2906002)(66899024)(8676002)(83380400001)(6506007)(53546011)(41300700001)(6512007)(66476007)(66946007)(9686003)(2616005)(4326008)(66556008)(8936002)(26005)(316002)(110136005)(36756003)(6486002)(38100700002)(86362001)(31696002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SldEZlozQmJMQlhyckVNa29sOTlST0hraFFzWHJuQmgvK3hXTy8xVUxCS1VH?=
 =?utf-8?B?amxsSzFUTWc0QmJmdXhtQ0tFMEZBMERmQ0NhZ3pTejgxNmQrRSt1ZTRrZGNv?=
 =?utf-8?B?Rm8xT1ZaelNub0lTRWFZM09sbVpJczJYMEwxdGw2bXZZOEZTTVArMlBxZkZo?=
 =?utf-8?B?WGhuVmdmcWN5aEdOTHorRTFXcjMrdTI5MExVeDZyYkF5eWh2L0VFaFhrbk0y?=
 =?utf-8?B?UHlDTGpPTjlVZHdiYjBTRkNYLzRjMGpPR3JQOU5XODhTRERKTTNpT2RpRkNx?=
 =?utf-8?B?OUFta1NOT0JPZmdyZERiK1BaVWdaL2tqVm01aTZleWZJc3h6c3N0THplSEJN?=
 =?utf-8?B?YTIyRzFmazNaV2FnN0h1SUwvS2pVQW10ZGJKc1Rxdkh6eUQ5RldSSVM4R25v?=
 =?utf-8?B?VGJyQnluWFMzUTNWNGFxc256ck5FMEFlYVY5bDIxQzdZWk51MTh2SDVWMStI?=
 =?utf-8?B?a01yYTZ3T29jTkVPcGFkQjFIMnBCaXlDTWFXeUppRVQrYW1rR0loUTc1em5h?=
 =?utf-8?B?VDlTL1pjVmpxbUJ6QS9sUStucUlUTXFEdXBaMHFZNDJWZTZKZ0gveGJpVUph?=
 =?utf-8?B?OGp6eEVTVXdOb1BScXIzenVYeitnUGhvMHlRZlF6bk5YZzdrQmZ6c0pqem0w?=
 =?utf-8?B?b1Iya0ZxMW45NlpQRlBpK1QwSE8wWTUrejNhY3J0ZWdZNjZSby95VndyOGR5?=
 =?utf-8?B?S0hpOGJYdjYrVXRaTExmOUg4cFh6b2lSVW1LeHFoSDRyczFrRjQxV2hBQlEv?=
 =?utf-8?B?SytaS2V3akxuTDIxeU1pQjRoM1ZUNTNEKzlhT1hDNUM0My9kRXQ2QTBKN2VT?=
 =?utf-8?B?T2lCR1lldWFIWHFtY1I5SmNjL2gxOXoxNGNYWFlYeCtaSXdMOXlPbmZGTXhR?=
 =?utf-8?B?c3ArZm13bFE2MDdCTHgrOGF0RE9sSE8vdGZNRE9HN0F0Wkc1ak52NXpVOFhQ?=
 =?utf-8?B?bUtSbkplVkZ3bGkxZHdXUVpnaEJxT1pVVVVWL2UyYVBzOFlLMGNxMnVhWmI4?=
 =?utf-8?B?S3RMSmVxZ1hWTU9RMDlVZHhUUWtNbWw4OGxZbkZsOGFWSEU2eC83Q3c1VHNW?=
 =?utf-8?B?UGwySHlhYnAyTjRUMzRRam1vL2o2Sm1ITmlWVnFNVTloOFc1QTA1TUpDeGRh?=
 =?utf-8?B?TmR6YzBCWHEyN2MzR0JuL2I4emdhenp3a3k5di8vckNnbGRjSEF4ak9NQUEz?=
 =?utf-8?B?b2xkbzlZV1ZxNlNiVllBSnpNaXNucmdQV0ZlTnVQM0c5VUkvRVlvVmNQZmN5?=
 =?utf-8?B?MEN3bEtOREJEaDFpS0V1b2xsakhQNGFFNGJkYVgwTW0yZjB6ZEpoRzJEZUsw?=
 =?utf-8?B?UzhvenhnS0tvbTZ2YTdkdFNOaEJJVVlkYi9pUWtxVVg5eDcyVlorei96MjRl?=
 =?utf-8?B?dWx0NzN5dmJRdzk5K21nRTdkQXJsRjJIbnYxTkpiMHNrYjNDalFiMW5yZVJH?=
 =?utf-8?B?QTUxaGJxU2VvY3JJZ0kveTRpYmdmZnc4WTczZ0dHNjZPUiswTFJVZ1JVYXI2?=
 =?utf-8?B?bEplRm9ieHgvOG9hd0xCTEN2Q01iQkhwZko1SVh0UzE4RVJiNnVIaHJ3M3Iw?=
 =?utf-8?B?amlYZXh1SlVENStvM3ExSDJBbEZDMlVRNitOb0xEdFFpYjNsNng1SERNT085?=
 =?utf-8?B?Rm1VOUxDKzhVR0huanpxMy9mQUhoWVlFMEpPLytTVjcrWStqUWlScVJKTExM?=
 =?utf-8?B?cy92NnBJV0s0bmJHNnBmNGxRRXlyZ21nWGpXVVNudnViOVhaSWtsWUhITlN4?=
 =?utf-8?B?SVd3THhlN1FiZjFWVUp5NGFqb1J5N2lvVmxtUzlub3FZMlRYVXI5R0ZhS05Z?=
 =?utf-8?B?QXVkTWVxMWNsUDJ5NWMyVEdQRDV6VDRlTTVLKys0Ni80NDZpWnBmU3pYQzRQ?=
 =?utf-8?B?bEtlTDIvNExTS3Z5QkxsS25RclJZYkdCZ2pUc01sdDMzbUpCUmVRRVNSQ0Fk?=
 =?utf-8?B?bW11UWpRRzFncVdhMWtINk01R2tTY09zVG16WW1BSzUvdjZuVFVmVWNQUEg5?=
 =?utf-8?B?NXFObmhxTW4rQWh4dFNhaEk5eFlWK04vU0dZQXVpYXlkYUZoWUpHeW9mZitC?=
 =?utf-8?B?cGsxNkZ1NzVuSmMzeW03Wkd3YzluREd3UlBOUWRWWEM1bTU0akNXVFN5cXhv?=
 =?utf-8?Q?YuiesBdLHqbxmyFu4k7BJSWII?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aSBtW5PrYa49GOtcLWRs1vpl700ggNPTh8FbjxEFSDD+6RI037rAITU/9I2mhofWYN1eQhCaTPl7w75HuK4v76shPaNBcXppkdW8o5Xz8sgX5t27A5lTSdIvTrlLsECy2ielP/B9h2ZMQEYBWxOjxSN5KLt71uOcwPvBFdc57LZPHH6wyV/ZntusT/loAM+Ozq7j3oFYxpxJ8Z5hvi1e8RAFbFRPFMk8wjRAqpXOcvSN55wIewncL5za6z4GN1OXScuRdb2wtqp6FvJmLuthb2RmhCiH0FNMq/bcXaldppkVdakCke1IGtG+Ad1JbGqX+Y95+0oz+bRmBU0vyRiA7goEvqmxtcSFmkTKH594ovwNJ284oKwE2YomtSWhPyy+9ICj1Ag+6hEO/tiFviD/yvCT1j16rmp5//F1cJHEA1tdXjKCcOh2MbAvCIqTQo4Kq2FvXMtUcT1Y/FMgH/a3QDEgRfSnrpxsGOGPn/v68t0Mz1GjBvcLCv46/ZneSKv3xBMqSxnlqvO2RurJzEamF20mvsJrcBLnmtUkBoRVzq4TwM7QTw2QjtAM3BZFDTarf/DSX3A+IG5ZOw7t2i/hqbQOMJXZeXvrMSGeKBwA4+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60a9d5c-8c26-4ec9-872f-08dc2fdfe18d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 17:42:59.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPis27oc672YKUKao1sW1xhTlbQiRr7cUs0+sdaSeRgv6ci0RROURN2jGK7SkF3743Z9ZD3IKJZKs9thCUeabA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402170145
X-Proofpoint-GUID: arbY2o5jGrDZqhqG0oI8JQwxD199PAEJ
X-Proofpoint-ORIG-GUID: arbY2o5jGrDZqhqG0oI8JQwxD199PAEJ


On 2/16/24 6:17 PM, Chuck Lever wrote:
> On Sat, Feb 17, 2024 at 12:34:45AM +0100, Dan Shelton wrote:
>> On Thu, 15 Feb 2024 at 23:11, Dai Ngo <dai.ngo@oracle.com> wrote:
>>> Currently GETATTR conflict with a write delegation is handled by
>>> recalling the delegation before replying to the GETATTR.
>>>
>>> This patch series add supports for CB_GETATTR callback to get the latest
>>> change_info and size information of the file from the client that holds
>>> the delegation to reply to the GETATTR from the second client.
>>>
>>> NOTE: this patch series is mostly the same as the previous patches which
>>> were backed out when un unrelated problem of NFSD server hang on reboot
>>> was reported.
>>>
>>> The only difference is the wait_on_bit() in nfsd4_deleg_getattr_conflict was
>>> replaced with wait_on_bit_timeout() with 30ms timeout to avoid a potential
>>> DOS attack by exhausting NFSD kernel threads with GETATTR conflicts.
>> I have a concern about this static and very tiny timeout.
>> What will happen if the ICMPv6 latency is well over 30ms, like 660ms
>> (average 250mbit/s satellite latency)?
> CB_GETATTR is an optimization for write delegation. Without
> CB_GETATTR, or if the client does not respond within 30ms, the
> server recalls the delegation. We expect no impact on clients
> that connect on a high bandwidth-latency product link.
>
> To lengthen that timeout would require the implementation of a
> mechanism for NFSD to defer requests without tying up an NFSD
> thread. So for the moment, the proposed CB_GETATTR implementation
> will help fast local clients but should not negatively impact
> remote clients, and we cannot in good faith provide a tunable
> to extend that timeout beyond a few dozen milliseconds.
>
>
>> Would that not ruin delegations?
> As stated above, it should not impact write delegation, and Dai can
> correct me if I'm wrong, but I believe CB_GETATTR is not used if the
> server has offered a read delegation.

Yes, CB_GETATTR is only used for write delegation.

>   NFSD implemented only read
> delegation until very recently.
>
> IIRC, there is instrumentation in v6.6 or v6.7's NFSD to measure
> how often a CB_GETATTR might have been beneficial. I can provide
> more detail when I'm in front of my desktop computer.

# cat  /proc/net/rpc/nfsd |grep wdele

-Dai

>
>

