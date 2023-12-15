Return-Path: <linux-nfs+bounces-648-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2A81515A
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 21:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7E0284550
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 20:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102C547F52;
	Fri, 15 Dec 2023 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U26V4hF4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lxGhdu4d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E747769
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK88Li020841;
	Fri, 15 Dec 2023 20:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JVgXslA0pMBqBZJotCKpYhckw1831Dne+JhiL8VyF9I=;
 b=U26V4hF4Agwdeq+1Hynb6U5+OsLqZqWnwS1MTZREqvyZU+JMPbRA8Vggb9rQ65ek6Vfr
 sFyQ1I92+5I/xPM+jysnRIIavqtaQ2GAeAoF+Z8hgluVd6tkSLQAbrr8yjJBPuiGM/CU
 cku6WAhdE/dZCYjwH76TH0CYAomlMSDSYq0nwuruky8XLmUZzZNRZG1t6qCQWJ+4JcFN
 Zrf85yM5NjlnurszkSb28UcqRljfrSoDKVyrQ134ugw55Ii2SjVgRkUMkb8I9MPl8Pdp
 xbjgmKL4c4GkegLwTQxK7R4eiFnjLdLXBjb2vn+eSeXif9evHTQi84rRvh12bTMFNjIK uw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuue8un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 20:40:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFKJGU1024776;
	Fri, 15 Dec 2023 20:40:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepcbw8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 20:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbeQBWn6E+PpbZj268u850Om5pd94vKKa0MON92HqBTo9cSKJ6/oJb/FUIRtCkcPVdIxery3tLDk86KxqwToshdEOcbQ6FC8z7KpR2IOLHwvTyJyieTrZPMsEbxLR49APlXL5rAJGmW7e+EYmHwEcrIbHbcUc0IhS0e0fb2zFuDAxbu9A4+Dahz9FJEiVuRNDBY+doIAj7H7rBazAap0C8idkDb6mxJf/qMzLW4KZENUiyClZqCMo9yLcYDI+v/41Pgim/RHHf1JBVYET0Qqd34gJ8tqLOR6mopXM87gb9zGFPjmqrV7cOuBc/65Er/qC9c9ThTwCS+JXoXFkxdFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVgXslA0pMBqBZJotCKpYhckw1831Dne+JhiL8VyF9I=;
 b=nA+Zk1mMEuDbdUWG5mW9D8m9SiZjDKtGliCmOLZak9jWSmKsec1sVPyPrrKvLuiGSY/+VfMJwXG7eFJt5ZJsrJV/9aOK7DMy+XSofTCKP9jdYDeAVTCiwTE01qvnml3kIB/zvrG5N4gnmHnkYYB71cxM1V5Vp9JqpXjdD25VOpX1w8JmUj67DOerg6i0IzNumTdJjr+AHUY0oLIPR/KGlWKDhCMjVu79ZHI7xfHSarULflqT+W3B74WL+hr7x8ejcR+WFACybnaB66ld/vkogh7q7bH2Eb6tFIRu+x/bjkbQKOeYsuSpQZRQyBWgl48fwS1j6RNfUMUQChu0CJXGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVgXslA0pMBqBZJotCKpYhckw1831Dne+JhiL8VyF9I=;
 b=lxGhdu4dhfbd2hT53gI1Okpdg6KtnElbTCoHxR8Pw8WZqi2HoQP9RGCezhJt2u0N69szM0+YeGPJfCf2Dyh54EiLAkV6uCnUj7OviNR+TCDunMevcMwlhqefqDW73NnEZzB+1gHAOg6vAS0VR58nx830DNZ2oTv9Z8fIdISUVOg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 20:40:14 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 20:40:14 +0000
Message-ID: <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
Date: Fri, 15 Dec 2023 12:40:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
 <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
From: dai.ngo@oracle.com
In-Reply-To: <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0306.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::30) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CO1PR10MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: f7026102-4173-4fe5-18cb-08dbfdae0a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	998Nd8wagGlzGGPBjlAa2erHq5Lt6quydmPxz2uL4o09R4w+ezqOY9+6xJyH4bYbMQezqDFlOsHYcfEjBIk5R1QIR75TJvd1cAW7eZiHvnSlZoxt/W5DBMdGyjBxicHUV6X7Pq0kvYlnQh1SMG6jW3HbfttnqJDMX6GU1hLUKxRYj3XFU/2+ouo+AlHMuEWEVxkhGG6dUElGYv3ui7B9trVM3eaJyOGVNacKRqKhe+3JQ5IrejAVgFxMem6+zaRjVI0lUYxZTV+qauD0A/yGqFTUrNsurrPLQUSP/P55cIEdGNQqFkrFnB1m4R+6Jgxi7wgvL3Sbtfr/RMm9ham6gaIpniApmxf5157ruDn4ZQ0tvLr4hNvarkPdkpUEnHvDmVPQOmAgQYD60KdtbAF1AwEILYsI0nznJw7tIt7zR7YtF2XdmY5HzAxvsDKyqtRaC0dsXkjQ3Up/Mq9IjyAtZq65Tu4EE2f4Qx4g0SbPtVr8XDrpI63shmfHGfGmF8SletlHOJzqhPsj/3n0SCMSHan4T2tjJNmhSK+nJiVDkz6JuxSuMIfJM96AQzYnW0fYYGB8zv7wXoaUkMcTlqUIquauJrFyRhahQc3JwoybxbY4AxJbS+pB/yN3HVPFeYl4
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(9686003)(53546011)(6506007)(478600001)(66946007)(37006003)(316002)(38100700002)(41300700001)(6862004)(8936002)(6486002)(8676002)(6666004)(4326008)(31686004)(26005)(2906002)(5660300002)(66556008)(66476007)(2616005)(83380400001)(31696002)(86362001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFBLVXV0ZHY2WGJrUjc5bmVRbXg5anVyWjF3OE84cUZnUjRtNU84UEdLV2VE?=
 =?utf-8?B?WFE2YkdtNnJKVEJIOEtyRWs5S3ZROC8xeUNvdzllYUluMGc1bDdvUUc5bFNl?=
 =?utf-8?B?S1M5ZFBuZlAvWnJWZ2o3Mm1QUmZHTHpTbllqWEMxems2MzZSMy9wZ2dCY0Fi?=
 =?utf-8?B?OCtaMGIrS2JzTDBPNmErZzJRRHVzMlpjK25lVnh0VzVhRmV0R0ZvRElZZHNT?=
 =?utf-8?B?cWNrdzJaZnJVc0NZaFJsYmhhcllRMXBMTm55TEhwaUZYUkdPYWZ1SjZ3aEZM?=
 =?utf-8?B?MUM1UjlLYVQ0dFZUUkdTMlArcklnRGNRSGZtOVFxN205SS9uVzRyM1gxeEQ5?=
 =?utf-8?B?QjF4ZFFMWFZUaUpIdDJMd1oxUnF1cC9Eak9aZ2Z1V2tEWEJzUGtXTFVsZzdx?=
 =?utf-8?B?ZUJQdWtxOVdKMmxMOFNmRXVzeDB3UnhHWW9Qb216eFRxNW5lVVZVaTYxeEk5?=
 =?utf-8?B?b2w3Um5pd0ZYclozVTZYZ2ROZHlPc3JpQmNTaUc5MXRHMHdENDlvcld5MC9Y?=
 =?utf-8?B?Z1N6dm54Q3dDdWE5MjgwWWY4RVRra2lkK1ByclpzeThDZFFHc2FRMExjT2xz?=
 =?utf-8?B?ZUtPRTRuekYrZnE0dzliTW01T25PdGJoQzNLR2Jsd1krelY3Y25ibHJLK1NI?=
 =?utf-8?B?ck1zSk5SMGUrc290NVF5TDRyZURCRGQrY0drck5GemZxamVWLzJqY0lnYVIz?=
 =?utf-8?B?ZkxKcUVqQXdnbDgwMHgyc2Z3aFlZUlFoY3ZXTHE3S1E1Z2kvM1Y1VGtncWJO?=
 =?utf-8?B?NlpuN2hUWVdJVUVzM0dYK0NHbjJINHlycGNsK1UzM2lNUWVwMDhwUGdZdUJa?=
 =?utf-8?B?amFld3RaSW4yaEV4b08xS3JkSHVycWlpZEw0R0E2TENHSG9iZUFHR1lsdyt4?=
 =?utf-8?B?c3o0REZNbTJNY1JqVXkyVENPek1MVmJzbUVyN1NDUm9RS0Z0RW40KzA4TXpV?=
 =?utf-8?B?Nk9xeHJsVzVkUVlsMXFybEVRV0c3Y3FoVjY0M1dqQ045bll1eFJhcVRCN0dy?=
 =?utf-8?B?dmQwMEVDU1RFZTB2cnlvbVJvVVJydW5iVTR0MDIwaStNbFZYQVJrSWZDVWxu?=
 =?utf-8?B?L2REVU1uaWVlaTdqK3RQYmJjMXN3ajh2RlFSOEdtMjA5ZkhJUWZHTnh6MTNz?=
 =?utf-8?B?UGF4L1IxakJ5cnljYmFEbzhaNlVYUHYwMWRETlNUcWt0SCtvNzFYNTEwQmdo?=
 =?utf-8?B?b0lNMC8zMHVZVEMzNzQ2enc1WTRXa2FldkJJVVR1amdpcUZYNXFUWXczbFNL?=
 =?utf-8?B?bEhEMWo2SVZtbTl5ejdhOEFrNFlsa0hyQkhteCtMR2kybmxwTUYrYkFzd010?=
 =?utf-8?B?cmV5T3JrOFhpQldlYVJ3L0hTcjcyQVpjYlRjSVkyMmk4dE5hdS95bGcrczZx?=
 =?utf-8?B?VUkzSllkbXdZcE5ZMXkwYllRMXRkYTB3OG5VUUtpNnIxaUsrbFJYVUo3YmE3?=
 =?utf-8?B?cmZuczl2VndIM1I2L3lTWHZ4aEI3ZEprc3dNK2x2RlZLY25YTEhoRmZNaFlM?=
 =?utf-8?B?REU2YmlIdjdOS1NzTmUrcDZkWmU3a3ZZNEJCekFpM2RMVlg5MlZwTTdYQlhq?=
 =?utf-8?B?U0RFU29jdlBSUU9TN1hqaXRSS05oNnlBUTdPVUVkMDdXY244eDVkV21BMUtW?=
 =?utf-8?B?MkQyVFpueGZPMStCYW1lS3NUbzFBTEdmREEvam9yWEE5cnpUSFZPSEEwcGRj?=
 =?utf-8?B?a1lraEZhQWQ4N0RmYXVjUFMrY1VJeC9MVnlWQmFmRFVsZmtoenhZRlJaOGI1?=
 =?utf-8?B?R25QSDZZRjZiNm11K28yVTZkMHFGQ2N0WmhDODh6a2prTU8rVXg4YjJLSjZ0?=
 =?utf-8?B?YUN5RkF1YlBOTEhnWmNYV05WbDJPek01OWxpY2tCMHFGWldpZlN0WXV5Vitt?=
 =?utf-8?B?TXhKenBuVHVla1g4KzJEWWVxc3ZWV2FiUjM0eWNrUkZmZldjM1BrZ1NRelpy?=
 =?utf-8?B?WHh1bnZnak1tU0tqZFl1U2thQjZCZksxYW4xMHFGL2RFcXpjdzBhTm1JMzls?=
 =?utf-8?B?dVY4MjBZSlhXMVExNUhkN2t5SkpmVjE5Z1JVOUNGZ1lSWWxmQ1YyNExoM3pI?=
 =?utf-8?B?UFFHMFEwMHZyakh1NEk0Z2hwMjROMitCUEtFQmVweTBpVEozUkgvWmpXalhY?=
 =?utf-8?Q?tgB6OaUezSygtLipqvF4lyMsO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NlK+qG26VW9Ngu7wVApKPe1pTKRme7JYAuNWpOAx7TQrQr9S+HQxAm8Ewvj9t7yGIHcoOxQByzG57WQ30NQWkDj4Hd+ZbQeZKM59SOLXoLmLVhG9dIicVnSBn9CCXhemnKCBq65frN1gPRoaTQO5niBvIDJhfXS7ZB0qMVv2wStOmZqyPjBs76JrGYZ90eiOYT/2RbFDXzCYhT/1TNGeIsxs1aE3EAOxJBhVR8eqTWFaROzVKN3KP+WQyqRYxpEl2ejL7l/ZVhGhiVYu0N/istqFcbll23VgQv9A1fqwecrrBLelTuFXP9ean8WW0HbqW/wT5aePyywESPC3M8HKGheB/DohVzC8WJhF2b7lKIGprapPr8lb4k4TB+ZKFNSWe9ahlde4PUDJ47PAUYHcQK6xikls5e+pZZtzSvlAqRQ96+xZytCkmfCaqC/wVKZQgZc1VbjQugZ8dggILFxY0JPDDiruy3c30QSAbqA4Av4c/blVEL5MDmZVk+OBMoVi3BmaA26WWheS343c81Hodxgpe8tCPulsMyg9pf6ZTzX2Yy/2qjW16YHiYKEBKLexwy7fnHDZMMlVdzXdjcGySup4+gl0ZXoWD9YQZt6iuuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7026102-4173-4fe5-18cb-08dbfdae0a72
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 20:40:14.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubP/aHDQCIdFZauCMT5TrNzJLxlsUfDHJ2Z29eDX6fmws6OTv1jO6CKMbFk4ZcR8UD7kNh3RlnBG9gA3n5/XEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150144
X-Proofpoint-GUID: A1DEENFa5t3fNYHxT94HEXTjtbv517ch
X-Proofpoint-ORIG-GUID: A1DEENFa5t3fNYHxT94HEXTjtbv517ch


On 12/15/23 11:54 AM, Chuck Lever wrote:
> On Fri, Dec 15, 2023 at 11:15:03AM -0800, Dai Ngo wrote:
>> If the callback workqueue is stuck, nfsd4_deleg_getattr_conflict will
>> also stuck waiting for the callback request to be executed. This causes
>> the client to hang waiting for the reply of the GETATTR and also causes
>> the reboot of the NFS server to hang due to the pending NFS request.
>>
>> Fix by replacing wait_on_bit with wait_on_bit_timeout with 20 seconds
>> time out.
>>
>> Reported-by: Wolfgang Walter <linux-nfs@stwm.de>
>> Fixes: 6c41d9a9bd02 ("NFSD: handle GETATTR conflict with write delegation")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 6 +++++-
>>   fs/nfsd/state.h     | 2 ++
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 175f3e9f5822..0cc7d4953807 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2948,6 +2948,9 @@ void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
>>   	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
>>   		return;
>>   
>> +	/* set to proper status when nfsd4_cb_getattr_done runs */
>> +	ncf->ncf_cb_status = NFS4ERR_IO;
>> +
>>   	refcount_inc(&dp->dl_stid.sc_count);
>>   	if (!nfsd4_run_cb(&ncf->ncf_getattr)) {
>>   		refcount_dec(&dp->dl_stid.sc_count);
>> @@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>   			nfs4_cb_getattr(&dp->dl_cb_fattr);
>>   			spin_unlock(&ctx->flc_lock);
>>   
>> -			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
>> +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
>> +				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
> I'm still thinking the timeout here should be the same (or slightly
> longer than) the RPC retransmit timeout, rather than adding a new
> NFSD_CB_GETATTR_TIMEOUT macro.

The NFSD_CB_GETATTR_TIMEOUT is used only when we can not submit a
work item to the workqueue so RPC is not involved here. We need to
time out here to prevent the client (that causes the conflict) to
hang waiting for the reply of the GETATTR and to prevent the server
reboot to hang due to a pending NFS request.

-Dai
  

>
>
>>   			if (ncf->ncf_cb_status) {
>>   				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>>   				if (status != nfserr_jukebox ||
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index f96eaa8e9413..94563a6813a6 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -135,6 +135,8 @@ struct nfs4_cb_fattr {
>>   /* bits for ncf_cb_flags */
>>   #define	CB_GETATTR_BUSY		0
>>   
>> +#define	NFSD_CB_GETATTR_TIMEOUT	msecs_to_jiffies(20000) /* 20 secs */
>> +
>>   /*
>>    * Represents a delegation stateid. The nfs4_client holds references to these
>>    * and they are put when it is being destroyed or when the delegation is
>> -- 
>> 2.39.3
>>

