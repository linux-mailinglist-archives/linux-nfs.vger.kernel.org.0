Return-Path: <linux-nfs+bounces-2486-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B801E88D429
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 03:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EC2B21501
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817521CF92;
	Wed, 27 Mar 2024 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B/CvoZzc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="snD/qfjk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EB81CD2B
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504801; cv=fail; b=PMaWriy+m37qvMTpSBF74srcdCvybueB2wc2px0g3gAGpDuoRzB3kawqDHuSNigCKMH7BRVDa9UOvh+bhdrBtnMpQjdapvnX0R+ljG1VXUAP0EIHG6fsdP8torPuglFCpjKQm2WedjzjrhOonOmRMhM58YyH3VGSvTtVdEQXaMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504801; c=relaxed/simple;
	bh=MOKE9zazhjx2L8qtrso/ohx2D6dA7PaZ+3g8SnfdRKk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YHqr7Lx1dPf1UKw+LufkM20k1Ci002NafhNyFX5kc2BhIJqOcqHQOzmpX0DgXHmhV4E/fmFJsIK6WUXxHDFkCFDvW+zVeVwFCMCFihKvin3vEqQl7QMa4GlJPcJkOzyxOnz1zxRIfXkUW0KGXSz9EElfnwseMpko+Pn3bDEQuQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B/CvoZzc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=snD/qfjk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42R0xwvj029753;
	Wed, 27 Mar 2024 01:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SXO1p/niLu0J4kzLj4Vd3XYCwk2eJeyS+P54ZaWfQGk=;
 b=B/CvoZzcrSheW+FRr+AJbiOpyCCUBWbuNJncJBOhsTDg80uQQx/eVllhj5iZgx5I/bvl
 2ZGqRtqMPy9kkxrUVGV7wfDxvdSBNSTyB5HOq9rY7HJmhvYdrLm2p/qoYPXSpnIuMlwp
 Mm3uZkM4WvDuc+fPG3mCxn/cGSJrcKR0Bt5u9cDuqB58e90A5CVNnpoDxeT7iTOMAUj9
 JYPKew2WehXp57hgPzJEzGz+OHGXKQzMAhur7PHqiJRDDdGOZQCnOdJ6N/LM0bnv8jMM
 xHrLyH9DwzieGJ0h+oSEN2ZrLRgmqDQDQwxnS4o+31a2JAtJ7zqswASWz8/KbwPEQGx4 /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1np2eeya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 01:59:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42QNvwc6011674;
	Wed, 27 Mar 2024 01:59:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh7v4cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 01:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH71ZhfJB5XktYtcUx1J+um0zcbzylPETh4a6bZ98fyzcjnHrHA0inarmTFcVUJlWJdbpyLVlu4on73EfzStYn3Ez8PxRzlTJNi20zTgqHmKg5srT73aNhtKI2YM1qMl9LA4briya6dD1QKwFcae8Wg9iN4HhLBpm5fg0aJeVnkxfN/HgCuDe6cK8YyQUiMR028VztbO1ACjc1Sv1tVNGSvVtRk59LOdsmFUbA9b6T56Fh4cJtiJ81tKwGIQC97AI+ydjzIQUCXFemXZBNGdDIEtb6I5Adwe6QHpb0ZrVEpvYBgxC4SnBfN/Audi3F8ZJ1+f6nvOLF32jih1rHjmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXO1p/niLu0J4kzLj4Vd3XYCwk2eJeyS+P54ZaWfQGk=;
 b=FPjSONQLIgJFkYZhIKVK2jo4YLXFPOXxFbDSYo9DaEZ0+ScP5lyBzSse7nONeCVvskzT350HzazxmAw9LM5gxkHUT5CcWcBAoK28/v9nX3yzemHmtD6mHmwBD3c5/dX2WUmU4If5mprVYa9LBErthAxzYTL/+/WeTIT4k6/SQX/Mji0BkolNfiU5qHDY3edK7fleAjvnhX35A8oehRpGw5FtN1NjZWUqnAvg6eZ+XxAlNjclUhOelyDsSr6SZTh8o2m7mPHISqSrEGS5dgmqbvO2Qp3vb2fmHk+VDWxujmhrcQHZUsPEuPv8q8ccHLIlKUItE9yxtpl5zGSYC3taig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXO1p/niLu0J4kzLj4Vd3XYCwk2eJeyS+P54ZaWfQGk=;
 b=snD/qfjkam242zxnNDsXMkhJeKmVktCcWmMqosPGwvxKLeZksUdjidocdj9oyaIySv/Q2CaZnqxr/Gpt6kjFiVQm0B4rJ5kvK0JaeTXvalPEK4FVs5N/Y8lPo51Il7000ISEFKL3OQ81S0so7Gr26HtO5slHc9h2hVJQLZsIN/s=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS0PR10MB6994.namprd10.prod.outlook.com (2603:10b6:8:151::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 01:59:43 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 01:59:43 +0000
Message-ID: <530ec24d-c22d-4fea-a9f7-7a462ab1af9d@oracle.com>
Date: Tue, 26 Mar 2024 18:59:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: WARN_ONCE from nfsd_break_one_deleg
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>,
        Donald Buczek
 <buczek@molgen.mpg.de>, linux-nfs@vger.kernel.org,
        it+linux@molgen.mpg.de
References: <5b63ad24-1967-4e0c-b52b-f3a853b613ff@molgen.mpg.de>
 <39c143cd-c84b-47b8-945f-bd0bbe8babfc@oracle.com>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <39c143cd-c84b-47b8-945f-bd0bbe8babfc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0027.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS0PR10MB6994:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HbHxn/G9FyQPgHHf0x5nKYyuMXRiSpnIXTPARMlewa7W86e0+V0xctFcGOxN7fb8CxipvM48pSdkQucrymMruWLW+FNpwoFrKcCSDDTOhVSSQXCnr5GbhomTJpWe9tsFsTjz38soiu1SNnBS+FNujIR8OpaJufVgw56GiQYodx+SkdOb7mduX/9OiP4aQwEjejGC1UdKaYWRH9srBTw54TYHsfcRmg0IRbqpC8SEB8erR5KYTeu+PHFfgQgObeVx+9oLCJI/kGiWrAY6EDTFe5V4uLzRaGyD+FHy0BzDhQRmzPdxTztaC+rBxdlA6r/pCLif3TvMOjS3hX1TM9ga/kq3uNGSOXP1+GNPGRzTlzJ6Jzpj56cByOFX+kDXruj087d5ZSOH6wmNzfi6iqUPksnXNCSylSSmcF+659JrR4eQDl/6+D/aE2sGzWt9wATGqtyfpm0HrKNGA2W9YUMM+xFlT4WOObFdFRjCOn9kkzSnJbMJrdYosU89UNvXc0jRfSC1Fb/SV8aT53HGj8I6iefh+o4fVVvRkSe3WuNKo2cGGcCAHvA3jaOJDXz9JSZLogzhyxblgbB8Q6zuvs/HbUNqjCP5asI/3vvrrNkVwV6/hj6ZG2yXEB9CknJdKyx0K46SMDd9OD/xTVBQ3bRFoYwihhMu5WzICNOqkLtp58U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y1lZNmxSVDJkeS9zUVg3bnV4V1RxS3JiczlRTWdyWEd3dTF3L3ZOUVozNlp3?=
 =?utf-8?B?V2l4NFdhcmtWQ3NrRGxhM2QrVER0T2VWWGFUYktIV0JSQ1pwd1J0WkZrdnlv?=
 =?utf-8?B?SXY5bkRUcGRIaUUzelNQTTlod1dPaXhJdUloOGZYYlNHM1l0T0lXVVc5azFG?=
 =?utf-8?B?UkpFWkhHQjV2MUdnWUhTZWc5UG5Vc3BHdDEyeEd3bXdyc3haRW1nY1ZhWitr?=
 =?utf-8?B?OW0ySlZ0bC96RzVvYmduYnNiVUlJbGtaU1haQ2hXandUMllLYUx2cThKajFV?=
 =?utf-8?B?N2dVekIyamNPZGRvcnM2b0VUeHRkb2JqdFNuZjVMZnhBOEd0S1c0aXlxRnl2?=
 =?utf-8?B?bUI0bzZ6VzhVYWJUOXVuTVc1THVzOEtEZlNlTTZVTlZFT2xLM1FSV2lDeitJ?=
 =?utf-8?B?Y0s5Tm9HNW5SclBVSnpSSEVkU3Exd2EzWTR6bEs4ZlZtSjF5NjJCMitwd1pE?=
 =?utf-8?B?VHBLREl5c2lIK0M1VmF6Nkw2dmxWYmY4Y3BoSjdpWUl2eFEwWXhVV0JFY2F6?=
 =?utf-8?B?aDlGREVuMERMS3FzcU9JbmlVUkRHVXJEclRVSkNqdTl6U25Td0FTVEYyVDlq?=
 =?utf-8?B?aWV6SC9oN1QvNE4xbjN0Rm5xMUYyOHJUcFhXc2lzc2kvUkdHUUVKeFJvNFZm?=
 =?utf-8?B?UklPVkJDN2d3ZmtyNXZmZTM3bjVTOTlBenNMMGt5dFR6UzRocC9BNGJYMmYx?=
 =?utf-8?B?eWJHbklBYXFBb1VtOHdLOUdCOXplNmNiZkR5OTZyZTRvQ1BuaGFpZTd6WTRC?=
 =?utf-8?B?U3BnQlJtREQ2SHBIcVF6R0JkQjNCbDY0ckFKRFVwVnBPRXlVOHVSUGFBZmdZ?=
 =?utf-8?B?Z1VjV3l1R1o2NFZxVlpFVHhkWURyYzk2Ukx2VFpaNVRPV0gycjYzZldyYkMx?=
 =?utf-8?B?OUFGYXplZk4wblo5OVc5NEs5K1g1ZjAvVWV0dkxvMkdUTmFFRzh5REVNV1FC?=
 =?utf-8?B?RytGNUtwUkZiTWRHWDRSMEdLWU0vY3RnWlh4SnZvVEc1NVh1R2g3UGJ6SHNx?=
 =?utf-8?B?YWxTOUFYWUduMFRMc2JZb1pJZHFONFlJVVZuVkFNYmZ4aWFBcEl4aUs3ZEE5?=
 =?utf-8?B?ejR6blVTd3krWjdGUWtuNEVoaDBYQkxuQlVOR0tlSUExSG15NURpMWxpdnJG?=
 =?utf-8?B?SC9WdU1CTE1Ba25ZKzRFbmNpRnJXVUZuVzUrRnVvLzJzNVlNNnpjK0hZY1pv?=
 =?utf-8?B?MkpCR2ZMeXpscjhMNnJjdXRWNjBEczF2V2I4dVlKaG5DU1VTTWF3MWtpbWxC?=
 =?utf-8?B?blZseUE2YTBDYWZENXZmRnV1OHkzTFJOMnMwN2xRYUNzaVdxdTNFeVpyTzhp?=
 =?utf-8?B?dk9VeFhLMWRBKzJjUmI4dzZ6REJZblZ1WU13b0Z6WmRuMXNodFF0TllmamNE?=
 =?utf-8?B?ekpUczcxeHE3Z2N4dk8ydmQ0VDFpUjF6NEtRS3R3a0pyeXFYaWNwcXpNc0hQ?=
 =?utf-8?B?S2piSnVzUndySk9tb0x6Y0I2V1NMQUNSSGpPTXVVQVQ2ZnMwTnV6QjhqSDdT?=
 =?utf-8?B?WkVxODlmK0xpRkxnbVpSYU1wZDF5SUF0UTRCakxzbHFKbHhjdm1BSktxYTFw?=
 =?utf-8?B?N1RIMldxWlg2OUtOUGROR2E0TlZFOXoxRVdjZFAzdjNTQ1lkK1BvUGtqODl1?=
 =?utf-8?B?MkozV3NrN1ExSjJyYUwzZTJDTGQyQXpaSE5UYjNpcVBwUFZKVGl0bXVHWjAv?=
 =?utf-8?B?QTEyUkEzOHI3VzlneVZNVEhlVXdIQkJEaW5WWENBWEpEMGdVWEVQSlZLR295?=
 =?utf-8?B?WW5CaXJPWmFMRWZYOTJzOUQwZnMxbGxaS0xWZXEvWDFUbG9FY0ZUbHlXYjdx?=
 =?utf-8?B?VVNEeEpYckw4bjYxQW1aSHYzOHN6OHhUbUtYNGNTM21KTHRXSkdsVTMwcnFz?=
 =?utf-8?B?TmRTNzdBZ082ZTZ2SDJCN1c0TjBja01TdzllRzNtanVZaU9ySEptaFhSYis2?=
 =?utf-8?B?bm1oMXdkU1JzUUtUK1RJSDJUN3Y0Yjg0bnFMUFJPU3AyY1l4c1pyRnZCNXZr?=
 =?utf-8?B?U0ZtN3J0VUZzbkRaQTRtM3FQK0U3K1R6OHkvZTFLS3hYcUVmLzh4eTF1M2k3?=
 =?utf-8?B?M0JsYTM3cVVoQTFXd25LbHdORjdOcS9kYy9RRlV4dlRJSHd4dlFuQVhBK2lP?=
 =?utf-8?Q?bv9KREsDfO2fP1rmIjVhrAtWs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oHl3abrvEkfeYB1cuKoAeIVd/FpeMkQgMmq4Pm1LSVbHzgoBSTHh0xznVzTbyRkIjGjB9VhDNFA0qMoJR3FI4ohTtvNEWpOC7xUMFwZ9fjMdgJ/7AyhNImTRfsVY0ypGcvo+2U9CIIZxtFGxOP2KzcI7YKNkGPgPBCn8TUEZph63gXKLuF5IOY/yUM8GKRIXBj7a0+7UuloBjX5ii2O4aS8i4vCQv7+I2I1jFSzAPZQzSgdqQSW3+aCwiLGRPacc4m15F2SUC+2xeVeMIvp08NS+WjAsx85ZsJ397ArX/BpgsMjPNXo7Y0OV1xtFQUdu29Jh5zq9JumFBWU8DUGZaBAcZRrwCJDWm5hje1je5053WbhAJTjW3t7N1HF84jUeDNBGPZ2NjGl8YxDjlTl0P1nNumLsRGb78AAlpD9hjpKADu8pcD046ujJelPFD3zn93bTZ2UnU+49UY3Iu8KbpWkEGCmVDiM0352AC5U7G0k8uWWAYJTRsfwbcJQ5pVVm++tyKoOfCYgytdsA6IR68EvxcVMHUKfGdZIaiv2manPqKOeOUK+di/9FuSX2ta66NCmpJw6C/EaPm/TDToluA/OR+KLDXV/6fqZdkRkDSm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9cbc98-a062-4b89-a560-08dc4e0191cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 01:59:43.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDo772h5/YsFLuqy/5P0a/CxFRPNcBJ95cMMk2viVuet4rLd+PQM2auX7v59sgTlSjaztsi2xoaohKdDlcB7CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270012
X-Proofpoint-GUID: 0TtY-qz91T3DRY_zW6tBGnbPFVegRyvL
X-Proofpoint-ORIG-GUID: 0TtY-qz91T3DRY_zW6tBGnbPFVegRyvL


On 3/26/24 9:42 AM, Chuck Lever wrote:
>
> On 3/26/24 11:04 AM, Donald Buczek wrote:
>> Hi,
>>
>> we just got this on a nfs file server on 6.6.12 :
>>
>> [2719554.674554] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 00000000432042d3 xid c369f54d
>> [2719555.391416] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 0000000017cc0507 xid d6018727
>> [2719555.742118] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 000000008f2509ff xid 83d0248e
>> [2719555.742566] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 00000000637a135a xid 7064546d
>> [2719555.742803] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 0000000044ea3c51 xid a184bbe5
>> [2719555.742836] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 00000000b6992e65 xid ed3fe82e
>> [2719555.785358] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 0000000044ea3c51 xid a384bbe5
>> [2719588.733414] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 000000008f2509ff xid 89d0248e
>> [2719592.067221] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 00000000b6992e65 xid f33fe82e
>> [2719807.431344] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 00000000fd87f88f xid 28b51379
>> [2719838.510792] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 00000000432042d3 xid fa69f54d
>> [2719852.493779] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 00000000ac1e99fe xid a16378bb
>> [2719852.494853] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 0000000017cc0507 xid 0f028727
>> [2719852.515457] receive_cb_reply: Got unrecognized reply: calldir 
>> 0x1 xpt_bc_xprt 0000000017cc0507 xid 10028727
>
> These clients are sending NFSv4 callback replies that the server does 
> not have a waiting XID for. It's a sign of a significant communication 
> mix-up between the server and client.
>
> It would help us to get some details about your clients, the NFS 
> version in use, and how long you've been using this kernel. Also, a 
> raw packet capture might shed a little more light on the issue.

This warning has has no effect on the server operation and was remove.
See commit 05a4b58301c3.

-Dai

>
>> [2719917.753429] ------------[ cut here ]------------
>> [2719917.758951] WARNING: CPU: 1 PID: 1448 at 
>> fs/nfsd/nfs4state.c:4939 nfsd_break_deleg_cb+0x115/0x190 [nfsd]
>> [2719917.769208] Modules linked in: af_packet xt_nat xt_tcpudp 
>> iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
>> rpcsec_gss_krb5 nfsv4 nfs i915 iosf_mbi drm_buddy drm_display_helper 
>> ttm intel_gtt video 8021q garp stp mrp llc input_leds 
>> x86_pkg_temp_thermal led_class hid_generic usbhid coretemp kvm_intel 
>> kvm irqbypass tg3 libphy smartpqi mgag200 i2c_algo_bit efi_pstore 
>> iTCO_wdt i40e crc32c_intel wmi_bmof pstore iTCO_vendor_support wmi 
>> ipmi_si nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc 
>> efivarfs ip_tables x_tables ipv6 autofs4
>> [2719917.818740] CPU: 1 PID: 1448 Comm: nfsd Not tainted 
>> 6.6.12.mx64.461 #1
>> [2719917.825777] Hardware name: Dell Inc. PowerEdge T440/021KCD, BIOS 
>> 2.12.2 07/09/2021
>> [2719917.833781] RIP: 0010:nfsd_break_deleg_cb+0x115/0x190 [nfsd]
>> [2719917.839911] Code: 00 00 00 e8 3d ae e8 e0 e9 5f ff ff ff 48 89 
>> df be 01 00 00 00 e8 8b 1f 3d e1 48 8d bb 98 00 00 00 e8 ef 10 01 00 
>> 84 c0 75 8a <0f> 0b eb 86 65 8b 05 0c 66 e0 5f 89 c0 48 0f a3 05 d6 
>> 1a 75 e2 0f
>> [2719917.859303] RSP: 0018:ffffc9000bae7b70 EFLAGS: 00010246
>> [2719917.864962] RAX: 0000000000000000 RBX: ffff8881e2fd6000 RCX: 
>> 0000000000000024
>> [2719917.872520] RDX: ffff8881e2fd60c8 RSI: ffff889086d5de00 RDI: 
>> 0000000000000200
>> [2719917.880050] RBP: ffff889301aa812c R08: 0000000000033580 R09: 
>> 0000000000000000
>> [2719917.887575] R10: ffff889ef63b20d8 R11: 0000000000000000 R12: 
>> ffff888104cfb290
>> [2719917.895095] R13: ffff889301aa8118 R14: ffff88989c8ace00 R15: 
>> ffff888104cfb290
>> [2719917.902625] FS:  0000000000000000(0000) 
>> GS:ffff88a03fc00000(0000) knlGS:0000000000000000
>> [2719917.911094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [2719917.917236] CR2: 00007fb8a1cfc418 CR3: 000000000262c006 CR4: 
>> 00000000007706e0
>> [2719917.924760] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>> 0000000000000000
>> [2719917.932285] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>> 0000000000000400
>> [2719917.939833] PKRU: 55555554
>> [2719917.942971] Call Trace:
>> [2719917.945834]  <TASK>
>> [2719917.948344]  ? __warn+0x81/0x140
>> [2719917.951983]  ? nfsd_break_deleg_cb+0x115/0x190 [nfsd]
>> [2719917.957470]  ? report_bug+0x171/0x1a0
>> [2719917.961562]  ? handle_bug+0x3c/0x70
>> [2719917.965459]  ? exc_invalid_op+0x17/0x70
>> [2719917.969715]  ? asm_exc_invalid_op+0x1a/0x20
>> [2719917.974317]  ? nfsd_break_deleg_cb+0x115/0x190 [nfsd]
>> [2719917.979820]  __break_lease+0x24b/0x7c0
>> [2719917.983991]  ? __pfx_nfsd_acceptable+0x10/0x10 [nfsd]
>> [2719917.989495]  nfs4_get_vfs_file+0x195/0x380 [nfsd]
>> [2719917.994740]  ? prepare_creds+0x14c/0x240
>> [2719917.999164]  nfsd4_process_open2+0x3ed/0x16b0 [nfsd]
>> [2719918.004570]  ? nfsd_permission+0x4e/0x100 [nfsd]
>> [2719918.009618]  ? fh_verify+0x17b/0x8a0 [nfsd]
>> [2719918.014243]  nfsd4_open+0x6ae/0xcd0 [nfsd]
>> [2719918.018777]  ? nfsd4_encode_operation+0xa6/0x290 [nfsd]
>> [2719918.024524]  nfsd4_proc_compound+0x2f2/0x6a0 [nfsd]
>> [2719918.029922]  nfsd_dispatch+0xee/0x220 [nfsd]
>> [2719918.034619]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>> [2719918.039144]  svc_process_common+0x307/0x730 [sunrpc]
>> [2719918.044551]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>> [2719918.049883]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>> [2719918.054404]  svc_process+0x131/0x180 [sunrpc]
>> [2719918.059171]  nfsd+0x84/0xd0 [nfsd]
>> [2719918.063012]  kthread+0xe5/0x120
>> [2719918.066539]  ? __pfx_kthread+0x10/0x10
>> [2719918.070664]  ret_from_fork+0x31/0x50
>> [2719918.074611]  ? __pfx_kthread+0x10/0x10
>> [2719918.078735]  ret_from_fork_asm+0x1b/0x30
>> [2719918.083018]  </TASK>
>> [2719918.085563] ---[ end trace 0000000000000000 ]---
>>
>> nfsd_break_deleg_cb+0x115 is the 
>> `WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall))` in 
>> nfsd_break_one_deleg() in our compilation
>>
>> I think that means, that the callback is already scheduled?
>>
>> One nfs client hung trying to mount something from that server.
>>
>> Best
>>
>>    Donald
>>
>

