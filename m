Return-Path: <linux-nfs+bounces-779-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 102DB81CF34
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Dec 2023 21:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD9E1F21BFD
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Dec 2023 20:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C599C2E83B;
	Fri, 22 Dec 2023 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QjfaTNdS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XFmmu31e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB82E83C
	for <linux-nfs@vger.kernel.org>; Fri, 22 Dec 2023 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BMJZidG007181;
	Fri, 22 Dec 2023 20:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=yJIjlAdgIS8RjqFHG0K3vLi4/IqOSyq6B7UitLJjBcw=;
 b=QjfaTNdS6WOQG5vOZhwNOanZ9+WUmqW99FVmWja0IN0gBF2oN4c5dGYvRq1ojytGA6GU
 1T2BG06/hvuCjozWQ/4EIOGgEu7s0a8e13wtDsBLYwte7xnXAW2rOiSKROJsoIdawzKZ
 qlYQFrY3SD2oiPkCwJdU2J5Bc6tglrEjsnInkNJY/nPhVd4zOjqnw22fKdSQHNzgjjfl
 OYkQ925H7YNRjj/6FdQJOx5CsxSYaDhLcI8EMhjMEmwryP55XN8DQU4fajuMgxfFidgN
 K/CsOqRVRG4m6j0Q6YID4yAnaLa6EfkoPpOg8CXMLwusghzLKNi79qXjIbAWG3p/YzCI +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v4b48cnjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 20:15:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BMIgXiH001079;
	Fri, 22 Dec 2023 20:15:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bef8ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 20:15:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJgpwPvwWz5nf1p694OO92JwVdP9u0kP6HcZlTNzB0s2veJlq01TsykrHLRzw+n5g02WBoaEMFMjPtCt9vxpVxAu2H+gagKyTYacxt1BPvmz2pc0N8EqVwXisn+aTtDBsyWfcew9tNLPt0KobYFAkuyBhLBY62ZdSpRkp6HeA6w/Yw5uEstEQ8octzLmv26n+R8YTg9f4Uqv7yeGxMpMg2jhv5+VSR9njr1dPHGJwCPWIo9csGmZ/SGvszImkro4o7W7mO2rF6sTKJII2aB/AeVa1wQf+RjWB1WMWPkSq37SfBbB0KFJcmCsrgDX9AW/1UD1XWg+O9u005sRwVr3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJIjlAdgIS8RjqFHG0K3vLi4/IqOSyq6B7UitLJjBcw=;
 b=BwMuFhGq97pV6H02cpyenYSrjUhcsm5BPqi5D+nx2g1ZqcK2BKbFwCph7poN3gWG6Ba8Se91cfbNRNCjFIbUKCGTda2t4dmrED2Xk6ku9ac8SiQWsZ1xVPPI3vjYoWWOGUNCEN3kORvTAzFt6qy1LPdZ9beXTcXMQz77a2YF9yY330MCT5rx/lE+20YoOz7vGm/akfa8lmx1NVE01uevMMlH+WHE3Rb0Ah44OjqyvkzdXmiq7aIloDxsRx0eI6N0MnaOp20nIG/a3YD/Eek+8Gwc97ruUVIl59bu8rjFh1HV2befAe1gKrkykOhUeLOd1ICf0VSpQlCHmJd7tuMw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJIjlAdgIS8RjqFHG0K3vLi4/IqOSyq6B7UitLJjBcw=;
 b=XFmmu31emTDlwoIub2ZgqzAmBHc/pYO+epuSJS1aQ2sC1q4TgxMA67LMMmtW/F7x1Oem5k4ttfjQ6fp7mYqx9N72ezuPkemReqiDiv9w2+6ptpGf6wrJEK0MEEuQ+UOor5TYbinKLvkUV/kYx4gmTxk8gRovNmUyZ3fxdvfZfzg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 20:15:17 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 20:15:17 +0000
Message-ID: <eab63c76-6425-40c9-a078-ab6c4bdf10f8@oracle.com>
Date: Fri, 22 Dec 2023 12:15:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: drop st_mutex and rp_mutex before calling
 move_to_close_lru()
Content-Language: en-US
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc: Olga Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <170320926037.11005.9834662167645370066@noble.neil.brown.name>
 <170321113026.11005.17173312563294650530@noble.neil.brown.name>
From: dai.ngo@oracle.com
In-Reply-To: <170321113026.11005.17173312563294650530@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0176.namprd05.prod.outlook.com
 (2603:10b6:a03:339::31) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 8beb8612-1b43-49c0-beeb-08dc032ab6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O1ZS/OBqbNhXrDK/vchPf5k1sKB8yvV35jea6ySXb8oivKqmPuG2f6A/nFcq3Lg+b28zuj+1aqS/PqT5vuGA1+EAgS6T+eRSUfSGQ2nmUI2tJv6O6Dt0Be6ovLeNZjbENJO0Dt2QtKoGQuqQBpxA6Ez3Rzzlp2TsEOJsEWfndzNyiXNuhISMiN49Wgx/xA4IboFDGG4WaP/gEdJjNmF8WFRyP+xf+C3FGj1MDh0Oc/9AFzyKydioZZdbbQzd/dDUMTxeOtan/o6V77EHDY9uCbNXBtoJkmQq6wm/oCpGWGTriNe4y77iOqTgkfSrx3Mj4kEnYFXJFnO/1CwbaQlq6bN9un151iik0KNLbwuMw98FOugLd9jYDa2q7f4DEvMKJsAfu3Dkl7yPAqP2IecLXYypWw9EUC0mNvixWKy2mVbBSpJtkBYbsKJMB/2rkw9CMeB69yPHy51Ar/81FlCbOd6qZRzeapsmnqT5nRnRRe0ZNnuzVLit//88Bncb+uxobkD4Cj8Fna1n607sPm0IL+WKo2mNT/WtBtUVt7ANsbuNYOFUznpoTyZteu9WzAb2Hl5tVyU9S70Jd0qgwsVRFT28EoW4652IV+PpJHV6Jl0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(6512007)(26005)(2616005)(6506007)(8676002)(8936002)(478600001)(966005)(66556008)(9686003)(53546011)(54906003)(66476007)(316002)(66946007)(4326008)(110136005)(2906002)(38100700002)(6486002)(41300700001)(86362001)(31696002)(36756003)(83380400001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aFdYOW5BVW1mRnlLSGpRYUxyOUMvU0o3Wi9IVzhpVjhJNE9jMm4zcGFjd2Jr?=
 =?utf-8?B?Vk9EdTJDWk0rWFBVWEs2YVAxTENJbWNrUjRjaW5MRkZMaTJlc2FXazR0SnNR?=
 =?utf-8?B?K3haeUtCclF4cUdIa2p0OGNLd0dNanNWV2hNaWMvVWxsa2hzUlIvdy9iMGYv?=
 =?utf-8?B?MHVva1hhUXBkRXFTcXFwNWdmeXI5U2RkcW8zbjFUSDZMN1R2enNLaXovNDlK?=
 =?utf-8?B?anhhc2NDcVJiVnRsY1d1a3dydFlnejVGK2FtenUwekl4d1NvbmFhKzRtVG5q?=
 =?utf-8?B?aWV3Y1JtTlUwNTlBZ1BRL2EwYnN4WElaYk8yUEt2c21ZR3RnN2paV2hKYkxq?=
 =?utf-8?B?VVpiNkQ5TnVvd0dESTBFMEZ4TVY2ck13elJ1d2lCM2NvcGFBcHVZWUFpbnRr?=
 =?utf-8?B?bEJiNXBOR01jakxkbnViZm5yYmtFei9LS3AyUkdkQ2dtb01JZUtGUWRGeG5G?=
 =?utf-8?B?SlR3cjlCTnl4NVhjUGI5TUJCN214T252Mkk5Z0ladmZNUGkzUGFabTZweEk0?=
 =?utf-8?B?aWVTR09LZEw1cWErMTdNVXoyRyszWENuMStZKzFZNExONkZZZzF2WXpyMWxR?=
 =?utf-8?B?eVhUS1czaFBMbU0vYUtjakdZYWxxM1hITUJ3NWIxcThRQkcwSUVBcXd1QkZv?=
 =?utf-8?B?aWhla1A5MktFMXZDMno4ZFpuSXdDUDE1d0w5U3hiNU5zSmpwMnJYMlk5bm9i?=
 =?utf-8?B?QkRIYzNUK3F5V2t1c0c3d3FSRUtPMm92RFNSakdoVjYrQ0pUVGkvd2RZRng2?=
 =?utf-8?B?cDlPekdTMjBhVXlCU0YvVzRpbllnWEVwT2dIR01mVFRGemoxY1drSExjajc0?=
 =?utf-8?B?MlFkQjU0dFNMVmZiQkkveUpQZU5kZysrb0dKcjlTZG9KTkJFaytwRnN5cTYw?=
 =?utf-8?B?NW15SzVVYmFIOVM4M0lFZU5maS93TGpzdUxKdmlaVXJKTE5EZkI4dXZRWjE2?=
 =?utf-8?B?aUJMQzN1OFVON2pTSkNzaE1jemdqcFNraWlZRVpscVlPWW92YUZWdlJ0NS9V?=
 =?utf-8?B?U3kzRkpFdVNpS3g4cmVOUXhWMk52SHJMOTBnSDNVMEVlcUVyTmxnd0t5bDIz?=
 =?utf-8?B?U3pPS0YvbU9PRkRodk1vcGVkM0NlejU2OG1yNkh5a2RKNVgxWWQ0NkQwU2dX?=
 =?utf-8?B?aTlYeDh4UTUxRHg3alc1MlRnMERiNFo4ZkhiZTJrSS9nWHEraHE2bktlbkFw?=
 =?utf-8?B?TmlrMlhqejZYbzd1cWw2Zm8vZ21hSzBieWp1U1pxZmdNMjJ0L0ZGNlcwaVNo?=
 =?utf-8?B?YUhGalJoMDd2elUzaDJYZklEWXFmdytwNTRseGI5NGQ5Z3MrK2xjd0kxbEVk?=
 =?utf-8?B?aXhvbmVDTHV2VUxLKzdNZXZFc1l6dmY3KzRLTExVbUUxbUpFL3JKcEFiQlNh?=
 =?utf-8?B?TjFKVG05ditCWFFJS3dCK2o3UEtTbW8ycUVVMnAvUVl6b1ZITkRMNlVVY2FE?=
 =?utf-8?B?cGRxaFlFL1Y4MlVmRzZYZ2YzdjVUM3R0a3Vya0RQSWlhUHhwM3JFdDMzNjlw?=
 =?utf-8?B?d01JNkVuaXlJbjlBc0l4c25JVGtXR24rVzNXQlYxY1NJaU1XamNWbGFBK3NH?=
 =?utf-8?B?TzMzOVZCcDVHU2xVYXF6dWN6aGlrMEJUSmhhUHI3eW96Tit6bSs3Uk91STJk?=
 =?utf-8?B?RnE1VEh2ZURPK0RqMFZDTGg2UDFEWkZMNmtmUVdDREJJYUxGUzZQMEY2aG9O?=
 =?utf-8?B?VVkrdkQyOVFUSktzbmVwNWdJSGZlQWlBY2JYamVjTzRpaW9BTnFyU0I0QUlN?=
 =?utf-8?B?dUFsNkYzbXZTK0gvcnFsdjEzeGNneE9EZHdNcllVQkVTWTNsdG9MTk1GMEpV?=
 =?utf-8?B?eHBWbFl5MXdjZUkyWFZnbXRoYmNUeW4zQzVWRDVNR0R6M2w1K1h6S1hhZm9T?=
 =?utf-8?B?WVZxdXBzM1UvOFpFWmtHb05TVTd6RnIvRVcwQ0U2cHFUYkMyZ1l5OEdQU3ZK?=
 =?utf-8?B?MzBRVit6ZVR5YVpQKzg0Q29rNkpWRDdxOGQ5dmREa3R2Q3FVZ0xEemplbGEv?=
 =?utf-8?B?aTRWTDVuN2tTdHA0ZzVDcHZLSXF1Y0tZV1ZnNEVEVHNRaUhaUmVld0t0cEVv?=
 =?utf-8?B?Q1NGd3M4WldSbFdBc3JrRkZEc0JsUU9lTEgzNWowa0NnbHFWa1hjWFlNekw4?=
 =?utf-8?Q?EsH7FyjLnuJDnsA8zTPypJIoA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pZb11feU02wMOO8FUpdSkLt2V9U/6eqVCx7PUpkwC85d+T6PD7FNlivrpzNFRf72yE2/cuTCo2yTTVHieLTS/Xi8mGEh9UDIQOUAiLx6xlICiYWRQXelrnS58ht+iRx+dYsdBZ5ZBdzSS1P2HlZOXcI2Q8BktG2WRcaEx44gtg2tuqUI/eARjxgbpkSXvDqq6tVB/5rDj+/Q7Mp9jJQLFgykxqKY3UHVnKgcwc2htVR8SmDZY88/9gxNe0PDjENGKs6Z+s5zmX5Sm6zVk0AQ3bhc5gYL5nDGK5ZOPLw6RTcuRn1sswKtKGb/HnqeY1kNCjf2+kDLK3otx3fUy3d/qhMeKCuV9JS1qkpckwbdr48FXe5KSXIGPunlz57K3v8+RSiPuL8CcQu8C4NikFc6Z1sxkqrPaCHBxMZtEs4E9UnMPZRVdnJxNCKdGbxQ2IH3iBu5ALt6uXU3j/S+zYhyOEImz5f+cKsg26+pAt7dPoY15Hakx+E2bDkuPZ7RYoRHQGEwDAOfc5S3O5IScQmAMGJQhukJy2J2F3r/L/fVAKi0NCtEVDLYVpUgEYa6or6hPlfWDKjN3eFauGUvaVp4Pm8hPDUa6UwOJjQy8nV3vK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8beb8612-1b43-49c0-beeb-08dc032ab6d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 20:15:17.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +77JACsvKMqTTrf4DWQI59v4npMNL+sZKeRaN5Q5ARo73FiGE4CItJix2HnR4SsVfJ+WMFYt6f0j/1PlhREXrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_13,2023-12-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312220148
X-Proofpoint-GUID: E3eZXcF0cWTrkw8wC20EqpqF7HPZGgK4
X-Proofpoint-ORIG-GUID: E3eZXcF0cWTrkw8wC20EqpqF7HPZGgK4


On 12/21/23 6:12 PM, NeilBrown wrote:
> move_to_close_lru() is currently called with ->st_mutex and .rp_mutex held.
> This can lead to a deadlock as move_to_close_lru() waits for sc_count to
> drop to 2, and some threads holding a reference might be waiting for either
> mutex.  These references will never be dropped so sc_count will never
> reach 2.

Yes, I think there is potential deadlock here since both nfs4_preprocess_seqid_op
and nfsd4_find_and_lock_existing_open can increment the sc_count but then
have to wait for the st_mutex which being held by move_to_close_lru.

>
> There can be no harm in dropping ->st_mutex to before
> move_to_close_lru() because the only place that takes the mutex is
> nfsd4_lock_ol_stateid(), and it quickly aborts if sc_type is
> NFS4_CLOSED_STID, which it will be before move_to_close_lru() is called.
>
> Similarly dropping .rp_mutex is safe after the state is closed and so
> no longer usable.  Another way to look at this is that nothing
> significant happens between when nfsd4_close() now calls
> nfsd4_cstate_clear_replay(), and where nfsd4_proc_compound calls
> nfsd4_cstate_clear_replay() a little later.
>
> See also
>   https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
> where this problem was raised but not successfully resolved.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>
> Sorry - I posted v1 a little hastily.  I need to drop rp_mutex as well
> to avoid the deadlock.  This also is safe.
>
>   fs/nfsd/nfs4state.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 40415929e2ae..453714fbcd66 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7055,7 +7055,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
>   	return status;
>   }
>   
> -static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
> +static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>   {
>   	struct nfs4_client *clp = s->st_stid.sc_client;
>   	bool unhashed;
> @@ -7072,11 +7072,11 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>   		list_for_each_entry(stp, &reaplist, st_locks)
>   			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>   		free_ol_stateid_reaplist(&reaplist);
> +		return false;
>   	} else {
>   		spin_unlock(&clp->cl_lock);
>   		free_ol_stateid_reaplist(&reaplist);
> -		if (unhashed)
> -			move_to_close_lru(s, clp->net);
> +		return unhashed;
>   	}
>   }
>   
> @@ -7092,6 +7092,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	struct nfs4_ol_stateid *stp;
>   	struct net *net = SVC_NET(rqstp);
>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	bool need_move_to_close_list;
>   
>   	dprintk("NFSD: nfsd4_close on file %pd\n",
>   			cstate->current_fh.fh_dentry);
> @@ -7114,8 +7115,11 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	 */
>   	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
>   
> -	nfsd4_close_open_stateid(stp);
> +	need_move_to_close_list = nfsd4_close_open_stateid(stp);
>   	mutex_unlock(&stp->st_mutex);
> +	nfsd4_cstate_clear_replay(cstate);

should nfsd4_cstate_clear_replay be called only if need_move_to_close_list
is true?

-Dai

> +	if (need_move_to_close_list)
> +		move_to_close_lru(stp, net);
>   
>   	/* v4.1+ suggests that we send a special stateid in here, since the
>   	 * clients should just ignore this anyway. Since this is not useful

