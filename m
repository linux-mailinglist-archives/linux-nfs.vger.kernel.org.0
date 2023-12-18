Return-Path: <linux-nfs+bounces-695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA2C817BE1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 21:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA0B23B5B
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C073467;
	Mon, 18 Dec 2023 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ShzI6fGF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kjVPgSOu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7C48784
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIHXpBR012905;
	Mon, 18 Dec 2023 20:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=e4kNUMMjXRBjbGvVSUKv1rDt1CT0p4GdRKASMSHk1Mg=;
 b=ShzI6fGFqEAHBQ7LapvxA/rv93oKHkhM97kfiK3GlE+kqfKXbjFiVrMz05nxKcGuShaA
 9MnfnqJf9R0nRcVgBalDIlY/VQLhdo56YesQXLyBfB08OFrmWs8oVSg7l1ulfWeyztmT
 /6cbtHBKpDnUEt0ZI+ykQASmCvuXrAgCvEjA7VU6FK37ILJQlO+r84Ndi+7Np64I2YOP
 yytTQcIOf0u+FGDnZfWfp5u9KWwJY8wmuV7VsvHrjMtKymyIaNSRNSyC6u1Qd88Dszo9
 bHWo3AF2mamDF9386Jcnnbj8IFSvzznITzqR1NlN7sQEaMVwkMx1lg8NDRqjast+z6Ms IQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12aec7n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 20:27:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIJ2Bgb029100;
	Mon, 18 Dec 2023 20:27:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b5nf2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 20:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSZSQxpYVXVCYoEpld0wPd4FJBQHHk1T1MZBQ34UvAQdyBhk/F2S+B9AQ5r+3hoQwY6T1iM7B4iOXYZ6VEyv/KSITAXV7F5CCvOZg2Wssfuxiyo3PJX+G3fkcYo1wHxneitFqd888+1izf4oW8JG5GYrQ4rU0BZv4JF8tWLfggYDeS+u+jkqGnf7zmS9m2DP+CA1SnfyTeO4pvy0SFjkXq6nbZFU4r86EAJNU++yJsDwBicnKY4Zq9CSk1KU0OCuS5UD7Td9RZrMnzXHwGvCtvaXYExkdd1+flWAHv+01Tpvcn74+LcYn7orh1rSaj4ySpnup1+9jW+sNukkw2X9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4kNUMMjXRBjbGvVSUKv1rDt1CT0p4GdRKASMSHk1Mg=;
 b=R3cvY6GNSdIbk/AZ0nK5OWYBnR7UC2NcCF0fvU/i71LmvSJVSCNYtIW7oH50kCoDnTPW0x7c/S9H79o/FHAbsjJc2BCqydoe6zz/HrcVutJ2FPaznxcCX74xcjv+0OdJxrgRfl2EJUi5rjaSiWuJSBeBOKrABvOQddOspPyXzADVQ9qQUKG4n/5FjDHG6y916jSjlUaT4XL8P7TAqeIIK8hD7Wd6YrlUZG7BLToMSrbIqATu+gMMTaNzl5+m7uFSiw+v7efioJQX5rLh0fvVqfuYgwq04qtesV0jXsAoM86TTbgdxPMyrZaRgW8nz+P7fnChZUJImgE3RFmR2MOvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4kNUMMjXRBjbGvVSUKv1rDt1CT0p4GdRKASMSHk1Mg=;
 b=kjVPgSOuwRf39Zjov9on5HqjXdOVtiyyqEZw6nM0l3Zchdkxf6T5I4O8VEP/8hIoLSjvJZx5CLGFyL/pHUWlt8LjSG6XwoR2lu8ypNS+mE09N3GnfabTrR3inFlVy8UQw0khjM67QFhVkwjqtSSoNSHfww+EBoCefIPWfKl2/G0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY5PR10MB5914.namprd10.prod.outlook.com (2603:10b6:930:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 20:27:34 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 20:27:34 +0000
Message-ID: <f68e2a10-4bb0-4b46-966d-d7806a10faea@oracle.com>
Date: Mon, 18 Dec 2023 12:27:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
References: <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
 <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
 <ZXzIGmhDZp7v87aZ@tissot.1015granger.net>
 <aef15e6d-20c2-461d-816b-9b8bc07a9387@oracle.com>
 <ZXz7nxzlPfJ+06QI@tissot.1015granger.net>
 <1a988fe4-a64c-48c2-9c2c-add414294e07@oracle.com>
 <ZX0gOlqGbIES5RtB@tissot.1015granger.net>
 <88802128-3ae8-4f91-aeeb-69693b137981@oracle.com>
 <ZYBtEs7JfMCi0TCl@tissot.1015granger.net>
 <11b384fc-413b-45e8-8592-1f736de6a3de@oracle.com>
 <ZYCZQYK9jM2dhiag@tissot.1015granger.net>
From: dai.ngo@oracle.com
In-Reply-To: <ZYCZQYK9jM2dhiag@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0360.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::35) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CY5PR10MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 976ace8a-2076-4821-efb0-08dc0007c464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GjyZR0vtwuGfd/8/ZHB/14PdA+Jz3D7BfAd6lu79p4eGTfeC5ileLn3XDb90v8mlmCJhR993iNFvFqWLS5HUjovxp5NyPm5jDPdKedaSUCrXlLQV0YsXvOtAjg8FSqGTGcQjigwq4LOKRnco70OqelFlmmLUZ3uu+WqR/UTHma6Z6CERXlLKa5UeCGl3mTK0TMWoA3a3WVULe+pKQrX97QdEwe4FgSgKcIpQwQeYunl1xU5jeQXDp1vKFHC2taOvwJGJhk2Jt7ZO0DVMnJ7lQtPRgQzu1Eyr3MiaPBaxVvkNcoKiq+3i/C0+smueccCsOvHxI/7Wo2wflGwRahWj1jNwt1JYCTF1enBWtaIQrKd8Ec1bY4T3Zu4Ivv12+za4MrOZMDda6xSX9nwXb6vetEiYk6GaznQJId1VOnlsUOa+gKfkkcbUnT3YYv4/lhdAfbYoXF8GE8FxQCoA5OtvM2eL2QoNUl2JTz6FIEa+WCdHzHwtmjYxle7oJJip5rDPsOdThAppkZMnFQv+IDDDxc/X4a1t3NhUH4Y7iyRFGc69pCnf3eSP/5bbFR2Ym8969diK0TqQfCSXv+geP8YkWM2TKiOHAJczof3OcfDwYu1ltB8xhRUbVzxqb0HFYNIl
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66556008)(9686003)(8676002)(53546011)(8936002)(66946007)(66476007)(37006003)(6512007)(6666004)(4326008)(6506007)(316002)(6862004)(2616005)(26005)(83380400001)(31686004)(478600001)(6486002)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(31696002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2NHTTdsektEYzg0VVNkUlVXaCtsOXIyY242a08wSzJVaFprTzhFYU1pcld1?=
 =?utf-8?B?QUVJS1hodjJGMDViVW9iUTRnY1pSR0VWeUQvSGl5SGh1OXpVSmY0YjFUT0RW?=
 =?utf-8?B?dGZxeFFURUNnb0hVMlRSN0xSTVZqTlJaRkFjVkdpRlZmc3NmRmZtcDBSSDlX?=
 =?utf-8?B?aW9xN1FVZ0VQbzdCR1VpdElScmxCZDUwWDR1bDJLQW1nL3FtZnJLcWlFY1Nh?=
 =?utf-8?B?Z1BWWFp0UERJQ3cySFRGV1pzZnVyeWxycUREa0NtSUtuaURoVTEvTG1ETHdZ?=
 =?utf-8?B?NUEvU2o3Mjlud2NZVGgyUmhpdEd0WndXNFZ1NXBBVlFKYnFTMm9PcFYxWFJu?=
 =?utf-8?B?WE5HdVBUaVg5Z3hMVkk1SFdZaDZRRDJISXlmZlNQOFBISGVlUU1QZ0ZTVVJ6?=
 =?utf-8?B?YkFGbFVKZDNyS0RXQ1VVVjRxdWl2ME83WXNBVXZ4TldRUXhyM1NiR1YrbUl3?=
 =?utf-8?B?YXNFTmMrMm1qaU1sTUw5aWMrRDZ1VDFmLzhVdWpKN3hJeFRXeFNKSVpWTzRI?=
 =?utf-8?B?dmJGS2F5UGtkQ2RMR3NWdThzMmxIUGhnYU5qYnBBaEpLalZITEJtMXNzN0tE?=
 =?utf-8?B?V2IyMks1Vm5kYkowT0l3cFFQVnliYWhYNmxMTnh5UVkzM2FlQWlIKzREOFlS?=
 =?utf-8?B?SHZ2ZzR6MkxtSVAvM1pDTUZFVU1odDB4bmRscjBHMmx5YjAvMXZ1My9MVGFI?=
 =?utf-8?B?RTFJblEvK1M2UDREM1c1aTBWRC9BZ242eGNTMlVUaU9VcmJFOGtlbjE1a1Rn?=
 =?utf-8?B?Uys1TDE2NFUyRysvWU9uZEU3c21oYk1nT2pNazZKVk0zZFpGNXowS0tSWi96?=
 =?utf-8?B?aDRmVFVIQ3g1Mi9CMW9HMWZ0V1VDa3p5c0lLemJ1MWc3UGVjYVdhQ2wyQzBH?=
 =?utf-8?B?SHkxL0ZkaFJwZDg0cHNqSTJMZmdyV2ZPUUFERTJoTFBFM2I4em5ZRGNwbkVm?=
 =?utf-8?B?Yy9oZlNTak1IQVo3bm9RcHBKZEE3aUJYVUdXUGFRTTZVSDVQVFQ4STJKY2Rq?=
 =?utf-8?B?bzVzSjVta0hYMTJxZWZNUE5kR1QrUi80UU9TdjI0SVhjeXdvOE4yWklRQi9V?=
 =?utf-8?B?U0JhMi9UYTVkaTErdEVkM0JhSzNqWmRYcVNhZnpMd0s5Vks4Y2VpcERUak1n?=
 =?utf-8?B?UGM4alluYk1iTzZIYUFjYkJubnVhT3ZKS2pmUWlPZkM1QWdUZGdQdWdXcWhr?=
 =?utf-8?B?aEljcENGU1pncVo0bFFIQVc3REs5RXFOYS81bFBuOG5DRXFtd3haRjk1T0hD?=
 =?utf-8?B?eEdHVnRibjR1WUhkYjRoUlVHSVhxdGZDdEp2ZkROME9nNlJYYmZSSUpwWUlp?=
 =?utf-8?B?NHpqcUxTUjMxSGRqZTVaR3kxeEdmR0xkUW1yL3F3SUozZ2Z0dlRCbzlVbm9C?=
 =?utf-8?B?ck1XYlpyODVib1lqVkNwUmsyT1BsSlExTElnaFJKV2diUldpQkRQb2h0MzVF?=
 =?utf-8?B?SHNzZlg3RnZaYWxDdlpFOGxwU0lLLzllbzRtR3F4eEk5Y0JlNDV2Y1JRVWl5?=
 =?utf-8?B?ZkFmNHhBS25hUDVkZHYrNTdRVU1QYjBpVERZSkhFbVc2cVlvUGMzUjc1ZHEw?=
 =?utf-8?B?VjB2TE1oYWY0TzFwRE1aZjI3TnpkdzhOZXJXNkp4L2pNZ2EvUkhGMmtlOHU1?=
 =?utf-8?B?VVEyd1dWSDVzTXFzVzJnVnR1R2JFRFNjTG9oOE5YQ042TjJlNnB5cDN4cmpJ?=
 =?utf-8?B?aUNwd3BiN3diK0NqdEU0MWIyTDdrNmlhdEltaU44ZjNKdlFKdmdpOUdDM2FW?=
 =?utf-8?B?Q1dYQUg5QzVDakRUdXI2Z01lWnhhZ3RzK2xIR2ZIemtmNldrSDdWV1QzNnVQ?=
 =?utf-8?B?UElzYkNETmE0amNpTjZQZHo0ZE0yV3l6NzVNSDZVVGdycTVPbjhyT0NHWUNH?=
 =?utf-8?B?UmZIbTB1ckxVN1h6VHBnZTk0ckFaUm1ZU003RTB3VTYxb2txTGRrVG43ellE?=
 =?utf-8?B?UUxwZEN5RUl5eVFseS9EV083ZXRCZ2tUSmJaVVU4cDRydXlrTGVRMzNpMXlU?=
 =?utf-8?B?elYycDUrbWl2dXRNOVhPdW1jSnF6SU5ydmdtdVI5bHJidzE2c1I5ejllN1lo?=
 =?utf-8?B?NXBLOUI1ZHhIUGZlaGRYbExjbWJXV0VGek5Xc1VTWVF0VkFBOTFIQUE4VW8v?=
 =?utf-8?Q?xmFDY31hYiowm4xLgCFaPrMaH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RBj4beLwEeoyjOOsmug7aqGTIUV2h2er8MEAChsAHEzfK/55mavzhCrE/dfSF5oy0thXQAMgrO/vJvtLN75Uk4stDbaCYWlN5Tu+k7OL78zTl/PhZL89BOI8Lyj6iL8jc2XihePOzl/kVSPqDKo44a2/cmbn70h6u7vqLNMPfhGuLyf5wgB/4Ka9IA4NK/hkKwm+lXXJ6ZCzNlkglDrieNQqwuMaPow+XgVLc6AJpVZt+pSsXJ921G8OJ6ON+T+NWUfuCvDszmYMf4rTggo5TTfRcZjR88JWqge50wSYW9jyQssMScko3xYzBS1u9qD+nkMSr1dn0Ok6eqFx7C0kpiLD8G9ZjH2nM8RTeQ7Z8xVvR+E8kM+3gXS6Nni0FswNUQq9Rwpez9WBgHTVFT6SMBcNVJ8efVTtdDJPOxXhvHR0yQ2XqCBqt2CT2PaJFPs6983phhlHxZAZHZuVRDC3XakQ3o5bk3jXeLzVwjqPt/u8DLDwou8G+F0idrLmguUM5u5wRMxPAX5vEsZD6inNyFFKSvFZpap33DzvJ9FQduyGcxK1qhUnokzP6mX+gP14CAw9UbRwpEYYN+yoYAVUTjcaOy5vSIaw5v3ISRqCXbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976ace8a-2076-4821-efb0-08dc0007c464
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 20:27:34.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qa7Q+udSY9zHmz6VykVmVGPVHqu5CxYmq22PwEezrVTuqn0IWxw3gZnbeqcptM4ULV00cJSJiMWzFx8vSjO6nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_13,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180152
X-Proofpoint-ORIG-GUID: x-mqpCmmgFSJZLpn-8MNo_hHFRe8y7tx
X-Proofpoint-GUID: x-mqpCmmgFSJZLpn-8MNo_hHFRe8y7tx


On 12/18/23 11:10 AM, Chuck Lever wrote:
> On Mon, Dec 18, 2023 at 10:17:49AM -0800, dai.ngo@oracle.com wrote:
>> On 12/18/23 8:02 AM, Chuck Lever wrote:
>>> On Sat, Dec 16, 2023 at 02:44:59PM -0800, dai.ngo@oracle.com wrote:
>>>> On 12/15/23 7:57 PM, Chuck Lever wrote:
>>> What we don't know is why the callback was lost.
>>>
>>> - It could be that queue_work() returned false because of a bug.
>>>     Note that there is a WARN_ON_ONCE() that fires in this case: if
>>>     it fired several days before the hang, then we won't see any
>>>     log messages for more recent misqueued work items.
>> The WARN_ON_ONCE came from nfsd_break_one_deleg which is a delegation
>> recall and not from nfs4_cb_getattr. I suspect this is because of a
>> possible bug in __break_lease as question for Jeff above.
> OK, so there's no indication at all if nfsd4_run_cb() fails when
> NFSD queues CB_GETATTR? No wonder it's a silent failure.

This patch adds a WARN_ON_ONCE just in case, but I don't this condition
will ever happen since we already had the test_and_set_bit on CB_GETATTR_BUSY
bit so the same CB_GETATTR will not be submitted to workqueue more than
once.

>
>
>>> - It could be that nfsd4_run_cb_work() marked the backchannel down
>>>     but somehow did not wake up any in-flight callback requests.
>>>
>>> Let's get more details about what's going on.
>>>
>>>
>>>>> I can add patches to nfsd-fixes to revert CB_GETATTR and let that
>>>>> sit for a few days while we decide how to move forward.
>>>> The simplest solution for this particular problem is to use wait with
>>>> timeout.
>>> The hard hang was due to an uninterruptible wait, which has now been
>>> reverted.
>>>
>>> Going forward, if there's no wait, there can be no timeout. The
>>> only approach is to handle errors properly when dispatching a
>>> callback.
>> not even wait for 30ms for well behave client, same as nfsd_wait_for_delegreturn?
> 30 milliseconds is acceptable. It's very brief and can never result
> in a shutdown hang. I just don't want a long timeout.

Thanks! I will submit v3 patch with timeout of 30 milliseconds.

-Dai


