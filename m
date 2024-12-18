Return-Path: <linux-nfs+bounces-8642-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787519F5C77
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 02:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B300E1641AE
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 01:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A949435968;
	Wed, 18 Dec 2024 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AYniBV6x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FodN82aQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24ED1DFF7;
	Wed, 18 Dec 2024 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734486949; cv=fail; b=CjO7+NlzhQP+3yyaXTzL/EU2WmwTmM4s1RHLjK17sxQOSg87oevtD+e2WP/SIEqrZbpasMd8Viv0GXqjOSDlhQ6Iw9CL3XdE3nr7MFSqajBxT9Ga4EPY3TttctNPTH3rb8bCtKGNLCu8lG4ZY947Y1uCOwwqXdJ+CZPYyQ0kB8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734486949; c=relaxed/simple;
	bh=CwputhbyPqFta6LZAJ/xsqLSqUI6eLprdPOJymS9HrM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tm42DtJo7fZq8VB81zU/OKgz+fFa5h0ZzpbuaCqKBHY8Lp/ilzapMgeBjoRhLYGJ/VlmQ3Ec17A6Bks2VfKZdmn9JoNY3W0CPrxffCFueiqbM8OPgXW5ANSu+VWYH98kWk1uwlvnyhJWREGAwZi7zf4E0kpcnFX3OBJtq0DqFAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AYniBV6x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FodN82aQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI1Mn5T028067;
	Wed, 18 Dec 2024 01:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=V+oMLiLK98zBr9TL0WnPmMjDbG6N+5Q8C25y1uOABg8=; b=
	AYniBV6x2nhsz2nUQ+076DcI91mdw7pBvtuUKKwoNFmDC4nAYyZIO0N5qHE58Jes
	MMJcXNKMVW4GwxevDEyy7wA0iL5uMR9CDGSM4D4K7dqCfMQUHWpNGARFCyQNfsrm
	PYLsFTSyoFhlmC3H3z2Ug46W7xOMWGIkDJzYs0FgOQunE3eLX1UMJgcZ2htXKXSl
	I04ehlDgfh0Vt82XJ895FqhGmdtJooHmTVPLJBjkRV+qOvx/wtnG0vplZmW7eiy6
	oENuDA5X25NJL2OXzWcKmSY/reHN2h+hcRQoZQsSOtKrXxwQPCGnGu6fsVkB0mhJ
	ktkQMhisg/HvKoEsglfChA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec7e68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 01:55:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHNJCTR000584;
	Wed, 18 Dec 2024 01:55:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f9cvw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 01:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGH92nZfmnTnPanpwOcPIInp9rVXuEW2TEdTvjfEqRFdUpJt0csPCZgJ9nM+aIK/rUIPQquvOlNwJP5HIwpupmJZu170K/lZ3oUp1FLEuYbKQYqd2TlpsqpFgQ29l/XUtUMxu89Ao5xd1NKlhmK0hEFroeNOOQrhn2NVXT4uv1A2vkoGEZ+99F406/QMY5EjBJ10efhvSODXCpuJX8aICChqWx0n2zkIdSuwKFXlFeB0OMWmh7v/1jRLo1Zt3ECn0lA6H3W5G6ZWLkOnVS0k1PQsCEteaReZ/1YHvcf5eGq+fqYCFS/1lOgUahfdvXDSkIcxrzPpPaMSFrqYupGyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+oMLiLK98zBr9TL0WnPmMjDbG6N+5Q8C25y1uOABg8=;
 b=myBJGcpmjyP+40vZU6zLET05shkYGKrc0IXfhHiGxK6egjSR25/FxXKdK/r+cCuTA+eH3WRM/8uy1sJ57n9u2nRrDIRquo/BY7Qlaah3E279HR/z+wJyX/d0YGDlhVpHBG6fvnA0GP4iNKQtmA2G5bzZb9XkXSXFfNuruuducVaEvYVUlg17qUDIctKWXWG5/8N1p6R+lBD6je5OKr1Z2FUeFoQuaUJTy3kj8GDH0vDtwluts3FB6bTbF3603sUXYD/r4YRhegjTVzK1BgVBDBW+4O7yPIg1e3OAZJC8Lc96Aw/DWGeu4T8Hj0UxK7JABFk+ImImRLQat7Vbr8Uflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+oMLiLK98zBr9TL0WnPmMjDbG6N+5Q8C25y1uOABg8=;
 b=FodN82aQrog9OA++Stn0wABFZ2l7Yeogaz7wyK0/ydW4TkgmbL6gUW4UVUhPX4vlSJKvdqdTXFCZPXhaVVwia9cE9gH7EvpATeYUslKD4LxeBv/6+cmHxiUy2MGW9xxYdOjM0UxuSveCgYP8DdI1ZEnvBXG1lqZp3tkGnAYv5rg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6828.namprd10.prod.outlook.com (2603:10b6:930:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 01:55:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 01:55:23 +0000
Message-ID: <e6bc81ec-4536-44e4-983a-28b8bc0f3979@oracle.com>
Date: Tue, 17 Dec 2024 20:55:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-50106: nfsd: fix race between laundromat and
 free_stateid
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Lingfeng <lilingfeng3@huawei.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
        linux-cve-announce@vger.kernel.org,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
        yangerkun <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
        Hou Tao <houtao1@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        ZhangXiaoxu <zhangxiaoxu5@huawei.com>
References: <2024110553-CVE-2024-50106-c095@gregkh>
 <ef9774e3-572b-427f-99e9-c6a456ffe4fc@huawei.com>
 <2024121713-reproduce-rippling-73cc@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2024121713-reproduce-rippling-73cc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: de4dfa57-1db4-4665-ab26-08dd1f0708bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0ZaS2wxVjFLUzdjSGNURFlpYUo3eEtqUWN5OElHb1dsK1Y3dFc3SWZEa3hO?=
 =?utf-8?B?UDRqS2Q4cHlyVjJCcWhteFNrSGVxTnFvUFlVRk45WFlFcXlzVFk4M1NJWDIz?=
 =?utf-8?B?YnpLT2h5aDRVK21MQitmSmJxaHdpbTc1WUhqWlFPQVR3ZWZiMFhZRGFGY05B?=
 =?utf-8?B?bEVEd3pZWXJUUEJMVVRqOE1YWWplclpScm9xNlMySHBwTjZJRmdPT2k1Qkpp?=
 =?utf-8?B?QkxyaHc1VG5haFdoT0M0R2xHYjRQanFlK2toNityWCtzRWhtYzVJaDdMWk94?=
 =?utf-8?B?MzNBSlBRYytJR2ZqbzJEeCtuMDBVQW9qYWZYR3FnZGFJSVF6NWNSSHlIWkEr?=
 =?utf-8?B?SEZ1VXlsbE1RQ1lSaVgveTJiZjBnRW5MMXJGamRVRXh0czBXSkl0NnFMZEVx?=
 =?utf-8?B?cHFyOWxGK281eCttWllwZkVsbC9nNnJucXpXZ2VCdWUweVYzQmNady9OOFJ4?=
 =?utf-8?B?NHIyOFZ0WUVQSU1TVkRGSHFmWkxiWXpFVERIdGtQRlljS3NpRkZsSHZhQm5I?=
 =?utf-8?B?UHVqVEYwdXdiekt1TmxlbnAyWWxxZEYvYVNJQXFiek8yZVU3cjFzcUxnREFS?=
 =?utf-8?B?N0d1ZUNDZWZYR1dMdzdGT0traW4vUG9yMWZ5dnUxQk5ZMmpDb3hvS3B5NWRk?=
 =?utf-8?B?USt6bGNSNkVCRjZCeGxyczFtT2paT25ScFBHNkFVQ2tueWpOM2xuRHNsUFhQ?=
 =?utf-8?B?SkNOWjgxc1AwR1VZNzA3UERveWZmTUZTdmpDODgzeG5wSkh4VFBaeDRPcVBC?=
 =?utf-8?B?cjBuMjZWRGYrV1FBSGl5NUg4ZWxkcy9FTE5pS0NwK0Fwdk1hUElwQVhpRzVo?=
 =?utf-8?B?RW1jbkwxRnhXWkxuM0NBMmdkSGlaT3JUdEVMekVDckZMRUNBR0FXYVB0T1Nj?=
 =?utf-8?B?dlZRWlZqaVYwN28vaGQ3cVhISkZzVHRSZ1Y5bloxdU9pcThGSnh6eTZUVXpT?=
 =?utf-8?B?OWhqVW5PeVdmR09hczYxV25OMEJkNzZXNng4eURaRDhhNUx0by9uU1hBc3N2?=
 =?utf-8?B?bTQ4STMxd3hUS25FZGFHYTR3R3dKTnZFbUwwTU9vS0NWbUFpaGtpdUdhNDdq?=
 =?utf-8?B?VlRFcDR3Wk9HQ1Y3V2Jrenp2WnZ4Zk5KWlZCUU5PT1o4THprTE1zMkJrM1E0?=
 =?utf-8?B?U1NXZTNTc0d4UVAxdy9RWFl6aUQ1Z1hIYUlUVlJKa1FITGZWRXBNbHJTSHF5?=
 =?utf-8?B?MTZ2TTNEK1J5aDRCZ1dlTm54U3JZL2l4WkY2Mmxrd0ZzR0JYZDBpbDJoU2FT?=
 =?utf-8?B?c0JYVTJoUVZneVdlSUpyL2MzR1RVYnhSNnJhT1FVbWo5YnY2M2JxZkRwWFVv?=
 =?utf-8?B?MkhZL1F3aXRLOG93bDFZRGdQY0NWa29RZkJZeEFxamlOUExMTFFwcE5PWGRX?=
 =?utf-8?B?L1IrSkVaMm05UldyVSs4Z2VKNkZMY0J4OFRYak9waC81bVZ0a1FmaXZsVmRp?=
 =?utf-8?B?aUJncVF0MFpualpOZFZVd3FiYldRdWcwZThaNWRaeTFmUzM3Z1hYVzVCV2lU?=
 =?utf-8?B?UWZGcXlHeWxoRnJhZ0ZXWXJ4N1MxczlLODQzVWZFRTJjVS9ETk5NQnh5NC8v?=
 =?utf-8?B?amg4SElGcDVrNGNxaFA3WUIvWDE0NkVIUzh3Z0FySjJ1KytpbVdCbk1lc05p?=
 =?utf-8?B?VlUveUZVaUtXaG1zS1VmWjRtT1BINHJ3RGNrdnhWQ0xXcGRBVnhaTlJYSC92?=
 =?utf-8?B?cGpMSlRIOUozRGcveFVZOHAxUWZCVjN5d1FpeUZOVzdDNUFkK3NYejFodEI0?=
 =?utf-8?B?L2Qxa3kvRHlNdUVVbitsWkg1NGlwYjlsdFhWNFhKNUhldGppb0liUUZmb1Ri?=
 =?utf-8?B?UFVrSGgvRHlod2wxcktyLy9salp4Y3BTeTFLZnBBWDZ2dkVLZ0NiNUZtc3E4?=
 =?utf-8?Q?foyLPgCudP/dy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmxkVm90S0t3RGppUWV5TnN2VStYM0JWVjhiVkFFYm8yd1l3Z0tOL3lRazdy?=
 =?utf-8?B?Ym1ocmZnUnBHVC9ESHNKSnJlK0JPaW5ocGJoc01MazNQdVAyTUs4aW1kZlk0?=
 =?utf-8?B?dkxrL2tGSEoxcHRWeUFBeW12aGxGNEw5YVhjK2ZGYWNqUjZpdTFEWnNQTGRZ?=
 =?utf-8?B?TXFKa2NObzhaY0loSElHV3dYeXJuVXZud2ZOQjlLUmdrMk4yNDBzODNvNEp2?=
 =?utf-8?B?R2h3eWI3Z0lNdEJ1dGRFRGdKaWc1c0YremVjZjV2cmNzdC93YWNyVEZnQ0la?=
 =?utf-8?B?SEhpVUJNcTcwTWVjaXQ1dHpEYk0yUkpDNlJiTnordXBITGxjR2NQT2lnWWR1?=
 =?utf-8?B?N2p1Z2R6ZXorZm03MlBpWW1PQm8yT2pMZ3h0bUpGS3NTM0g1bno1M0dTRkZX?=
 =?utf-8?B?c2I2cjdhRFRFSTRPeTFVQy9wVDVsaERIdXJ1dWp4VTBEcEE2K1FBVjdudnpB?=
 =?utf-8?B?ZFlIcERNaEo2QzNKeGtvMEswWVdNcVNIY3RQWHhlWEo4Q09VcVh6RklRMzZy?=
 =?utf-8?B?Y1NVcVEvZkJhWEtBcnZvdE03NVNDMnk0Ky8rVzF2bXh0M0g1RjlWeFBnQ1A2?=
 =?utf-8?B?ZFliRWlId2U5emFoR1FYNWtHaG1Fc2tBZlZIbUE1aHFNelNtdzRRK3EwcGNC?=
 =?utf-8?B?bGloMmR3eVJUSHgrTEZhMGF6OE9ZWmRnQXkvVzJUWExQNnVhRE4wM2FZeXBX?=
 =?utf-8?B?eVhVRDNTVlN5dkJYOVBjS0pIaVJwMm5pSURxYkoxdzh0NEpuenFITklyRWta?=
 =?utf-8?B?T3lQTDJhT2o4Vy9wenJCTjQyQmlIWm1vV3RRODhLVE90N3A0U01KVXUxcm5W?=
 =?utf-8?B?RDRzWkFWdk5Ic3o4d1Z4ZXBNRVZabUVDNVJ4T3duUW9CY1N4TElpK3BuK3RO?=
 =?utf-8?B?MTJLeDZlSlJTS29xbFpFK1VYd1pMQ0x0RVlFUTVhQTNlMlc1cTBEdzRMZDY1?=
 =?utf-8?B?L1M3MkpKZTBOZE55ampUQlNIbE9PelN1eVRhR1lrSXNWTHVabGdac0ZHZ3A0?=
 =?utf-8?B?elA3SlZGT05OVGxKdGR2NzJjcGtxaUpvVys3RzdlS2hJRUVpckh0R3pqbkZB?=
 =?utf-8?B?NXNWeGVldU0yU0FMWFhXNFdBVFRENS9PZ2JaZ29IM3B0NWhHYmcvZmZRcXFB?=
 =?utf-8?B?UVQ0aDZZc1hJNFlFVHg3eWROU0gvUllCQndsUnF2TUNUVXNGa0FtSWhQMkd5?=
 =?utf-8?B?TENkSVUyc2FQbkxyZU80cUI2cEdPb0x6RDN4dmk3MnQyT1R6RUxNbjZqVzkw?=
 =?utf-8?B?SHAxby90UC91dXkyRlRza3pKZjhuNjl6UmVQVStKMjNuMGtLQUlPamhlVnI5?=
 =?utf-8?B?MVkrZVdEQ1Fxak5sRXZjZG1ReGlTd0pFUk8yaFZMNWJEdHR0REJONnBtRmhG?=
 =?utf-8?B?V2doK0x5K0VhUkgySUI5by9PRjhzNlkyc1hGNnBxUXQwVFJTODdiQjQyTWR4?=
 =?utf-8?B?ZlpBQW15OStSYlhJT3BvNDlFMlFacGtGWnJLUzdmcTBSajdLcXRSYktOT2FF?=
 =?utf-8?B?Y0RuS0hPL2FKWDJBTThySXA0dWw5Yzl5cXg4NEtDQmx1eWZSa1FORW4xWTBt?=
 =?utf-8?B?d1ZrbGRYNk9ac2dRc3lFN1pORlFlaVozaG1SekpKZEYyeFpUUXdFOTh1Z040?=
 =?utf-8?B?Sno1YUpxUkIxSEtneGt2ZndNaUFFVUdPOTg0eExEWkxvTDRTUkc4ZkZvNnVw?=
 =?utf-8?B?Uzg2N0tjQXd6SktPaUFPOWtWcmduTkNlcHFuczdIQ2F2Q3RPc1ROMDdVeW5X?=
 =?utf-8?B?Kzc5Wkg3SUNjeDBZYmI0aXAyRk9KcHU2dUkzVlRoRE5vbytVWW5PTWhtbEs4?=
 =?utf-8?B?YWw5MjYrNTFReTZaQ0dLUDcweXZWaHR0cWRIQ2pkcnlQczcwTzJtMkVjTWsw?=
 =?utf-8?B?YWFES3JCbWNFaFlNU3M2bFdKMERaWDZoS3JFYUZUMW9JR1FZU1hnU29FVHc4?=
 =?utf-8?B?WjlYT0QwYzVkV3ltUjJvTThSc1NLNmdSV1VSRXE5SDYzc0pKZU1STksxUHpZ?=
 =?utf-8?B?R0g0VEVQdUZBT1pmcWZJRGsxSGcvbWNRRlhXdXhvOEJtNFMweEpsd1pJYkZD?=
 =?utf-8?B?K3RXWVBCT3Q1REhPaStpb3hYZitqbGZuUXdUY243dFJsN2Z4YmpUQlpLb1d6?=
 =?utf-8?B?WXVHV3k0eGpBMlpzbjdFcWVYQ1IxRjJsa0R1SjFKTmVtUHd1V2hkcnJ3M0xu?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YXf4DfRcIBiZFXO3piWBxmcWX6tNEyvxF+QDngolSkNdQmgMOVwt9SeK7yp8w8U4FHCPAL3VyUmTl6kaVZtd8qY6MLPydyzJvj0gq3Ojjb4eMknjOwPeJ3Hiy8bW2x0U4E5PUQv+ZvVjsShQ9hC5chFqSvvqtIw8E5MuWMc8f3I93N3pMsZVqFrSHp8PL8NP8pHgGN3DNC65iNQtwDg2eL9Nm3MKbqDwnbvWnd3tbQEgRa8oy4m1wfNL0RWoZCbY79WB1y0xGP+nrE61tZCO2c1LScW5J3T8L7lztbYksXY+avy7hbxmcQ6v5aA5K9PsUf52Oa994Be8Xvk+Yl8/PIHrTKV2FV2KCgfqjFYca1PCl5lB660vZvs8upGQuzY4csMPHXWHPlYdIKlLp/cSRRK6wGqueaJoCKHiHL3i2AeeG4BX+XbQVV8HWNUWJ5sWqqeGdxfH8oHTlEFfpV9saGYO32urEVdQqQjfr9GaeLa7K3EuwFmWQM137B7ledRCPsTmSiCtMUGC/NnYAkqxjwvKBgrC4FlUBnu/M/t91ZaA4Etj6Gt9sCHYDiZXXNIrYdCnFjQDaRWDbFOkPuJgWZDdYwOYXp2XkU22LzWBZP4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4dfa57-1db4-4665-ab26-08dd1f0708bb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 01:55:22.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wA1/fBXAyiStQZZLDbl6HMQicXzQ3NlvEbjukymq/bPk8tSIpyxYj7Nyd8fjcbJ8PAcVnEfe4nznSnkBVL40g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_01,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412180012
X-Proofpoint-GUID: 75ON2d9xVLj4YDyQg4Md059Wwm-KlHJU
X-Proofpoint-ORIG-GUID: 75ON2d9xVLj4YDyQg4Md059Wwm-KlHJU

On 12/17/24 10:59 AM, Greg Kroah-Hartman wrote:
> On Tue, Dec 17, 2024 at 11:30:41PM +0800, Li Lingfeng wrote:
>> Hi,
>> after analysis, we think that this issue is not introduced by commit
>> 2d4a532d385f ("nfsd: ensure that clp->cl_revoked list is protected by
>> clp->cl_lock") but by commit 83e733161fde ("nfsd: avoid race after
>> unhash_delegation_locked()").
>> Therefore, kernel versions earlier than 6.9 do not involve this issue.
>>
>> // normal case 1 -- free deleg by delegreturn
>> 1) OP_DELEGRETURN
>> nfsd4_delegreturn
>>   nfsd4_lookup_stateid
>>   destroy_delegation
>>    destroy_unhashed_deleg
>>     nfs4_unlock_deleg_lease
>>      vfs_setlease // unlock
>>   nfs4_put_stid // put last refcount
>>    idr_remove // remove from cl_stateids
>>    s->sc_free // free deleg
>>
>> 2) OP_FREE_STATEID
>> nfsd4_free_stateid
>>   find_stateid_locked // can not find the deleg in cl_stateids
>>
>>
>> // normal case 2 -- free deleg by laundromat
>> nfs4_laundromat
>>   state_expired
>>   unhash_delegation_locked // set NFS4_REVOKED_DELEG_STID
>>   list_add // add the deleg to reaplist
>>   list_first_entry // get the deleg from reaplist
>>   revoke_delegation
>>    destroy_unhashed_deleg
>>     nfs4_unlock_deleg_lease
>>     nfs4_put_stid
>>
>>
>> // abnormal case
>> nfs4_laundromat
>>   state_expired
>>   unhash_delegation_locked
>>    // set NFS4_REVOKED_DELEG_STID
>>   list_add
>>    // add the deleg to reaplist
>>                                  1) OP_DELEGRETURN
>>                                  nfsd4_delegreturn
>>                                   nfsd4_lookup_stateid
>> nfsd4_stid_check_stateid_generation
>>                                    nfsd4_verify_open_stid
>>                                     // check NFS4_REVOKED_DELEG_STID
>>                                     // and return nfserr_deleg_revoked
>>                                   // skip destroy_delegation
>>
>>                                  2) OP_FREE_STATEID
>>                                  nfsd4_free_stateid
>>                                   // check NFS4_REVOKED_DELEG_STID
>>                                   list_del_init
>>                                    // remove deleg from reaplist
>>                                   nfs4_put_stid
>>                                    // free deleg
>>   list_first_entry
>>    // cant not get the deleg from reaplist
>>
>>
>> Before commit 83e733161fde ("nfsd: avoid race after
>> unhash_delegation_locked()"), nfs4_laundromat --> unhash_delegation_locked
>> would not set NFS4_REVOKED_DELEG_STID for the deleg.
>> So the description "it marks the delegation stid revoked" in the CVE fix
>> patch does not hold true. And the OP_FREE_STATEID operation will not
>> release the deleg.
> 
> Thanks for the research.  If the maintainers involved agree, we'll be
> glad to add a .vulnerable file to our git repo and regenerate the json
> entry to reflect this starting point for the issue.

Hi Greg,

As mentioned earlier, our reviewers felt that this bug would indeed be
difficult or impossible to reproduce before 83e733161fde, and there
have been no reports of similar crash symptoms in kernels before v6.9.

No objection to updating the CVE to reflect that.


-- 
Chuck Lever

