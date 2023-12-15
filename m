Return-Path: <linux-nfs+bounces-645-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F14C8150FD
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 21:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1553A1F2444E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7A45976;
	Fri, 15 Dec 2023 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eKMivjvQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uIciGxZo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D345974
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK7tkR020309;
	Fri, 15 Dec 2023 20:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ayoHb1mrjOTXNIxU0IY3H0O4a9CnPv6Ux3E/naY5adI=;
 b=eKMivjvQOBU7TKsWqglnv76pbNaZTykUieZUDIqEuSs8fSepOZ62yYknKv6d1iRA8VfJ
 1ZX/iar6NCWMnYEFdu/7C44Tj9Prh+/LjCqYjZsEGRHhUrj1uZUHHD5kzvw4K66dUV7L
 eTxsCwuTWuqmgJx9R3eEHISy20RHEE/7zKXhITYhjsSkuWzfgpSzY0hFGcTPTTAiYLgn
 qdX/K69HNPs7noglcKbmRnwQ4d/t9vvgJPENa7HWJLpvxi2nwADfEN2H/U609vgojlUa
 mZXcxjSfzUu059Thw1+pk25DT1WFfrw0B3y/FL6H+SWhwSZvQ/BiMB4ZiQTPEgMFbF1L NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu2e6bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 20:19:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK57Pe030738;
	Fri, 15 Dec 2023 20:19:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepce4r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 20:19:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6XOh+3n0HGn0VPNSwO/l/N1l6jRt89zHumKV3iEll7oX444eLUvNS67LQhtBNVmgRakP5wN6W2rqfZc0HjxAu1GsSjML9sMKYnw7YXX7u8Yf5oz9csarjqCG+JTvnkV7qMt1k3zbC7FTjC1s6EaR2HHnYaWkWDOYLM1ke+YBbVhLTcaPCumAiuTREpexuJ4YUtmtkXfNDK7yiD0z1fBzPuMWitN3TGmBrsXS6SDDIhHGCoJnEG8/9jAAVG836s3NuH3Od9gl921DRAVYPPv15UnITrsWajm/Fi3sU8I6aYMudBWtJxVN1FAWyYIdE+G5hf7gUFJYZrCXD2A6Qingg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayoHb1mrjOTXNIxU0IY3H0O4a9CnPv6Ux3E/naY5adI=;
 b=jYlt5mS2jj3Fc6CotVBwrvjqKANzs2vowpaq2WWQJXuDg3vC17Q43N9zEWgpBrSQKAK4lPweC4mPurhsN5Ic5mvEvBtZq2IaZfROnXGoVz18vkoPmpJ97kevPUmPDnMU5aUu58KL9zKLkR9LyXDfU1deK4F5VEIfWu7u4lN8+4UVEDpjT1TNfoTL4cfdHwZjLrksOoWSrck1gXdHLhhM6h3CCjNXjJBdzHlwDNEJkfzkDWPyqEjcgwe56JiMZeVHNXiApNmhfe8M9Jf7+A8yX4RSLqR6mAZpe8NSXBgtIcQEbQGDFeaES1ZgdOkYAUq+VSFbomM0T2w5/5lS6vPyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayoHb1mrjOTXNIxU0IY3H0O4a9CnPv6Ux3E/naY5adI=;
 b=uIciGxZo0hUgXLUJ5jPEjXC5sY8L+aNRyt27s41MB3nkFuovtQobaCxipGeVwys5KBOvW+ZHFpMZtGqEap0mUef0EBcb4rIS9a9RxbqJUs76xpmaR08OUo2EhGWTRkpSN64bD/op1hx/ROvENvG6M+FaUIfPL2PlI7idP2u2HrA=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BL3PR10MB6162.namprd10.prod.outlook.com (2603:10b6:208:3bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 20:19:01 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 20:19:01 +0000
Message-ID: <eb949f89-6133-4922-9015-0dced4ee5c06@oracle.com>
Date: Fri, 15 Dec 2023 12:18:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org, linux-nfs@stwm.de
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
 <c9e8608d0cb2562c645d1f31043fcbc90cf53d52.camel@kernel.org>
From: dai.ngo@oracle.com
In-Reply-To: <c9e8608d0cb2562c645d1f31043fcbc90cf53d52.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:334::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BL3PR10MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: db40d2a8-9ada-4c89-3bfc-08dbfdab13bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZjVDmCVYa2LN/Ze2jUU4Vk2UvPj0GcMaiW3N/xlqmqHtyBYtwaybw9Q7iNvpsJBPotOCGqV0ajCY5h0QJJ0Is9KR2wQvyjMuGPfpjB86Q5sySBjmOW/O+rnxKfJX8H8a/SFI6NYGlTPwWTdRGVr5F+IIvW2h67Pvrrqrb9yrrCRY1M+ldIirtFQmIwKLMa2qMUkeEBi4uE3aPOQWAty40Pka+KNGAWJw9TDS6d4UDvG+iXOorPK/Gx4gjZtX4oC+pfrfzywEVOUwUImhd+Hq7NqmQUfh9lCJik+z1yY+t05c6c3pTlUAkzWE94USy9g/6xASn3/eRpr+CE8QM/T8MqeWsDP6dhoF5IRSRVDlDC07e+gtaYXeM77EoMZ0/Z4iTdBZ9XsxP5843/j+qx3PamKVr4qh1k6xpsjHslHciicJ8E1on0Mk1F1roUZ+OdJU+1AmUCbMoEjZ2g7tFkeqVlJc5R3reMjAYS9OzKZDi3yOE/YALJgUgBqsO5k1a0Gihae1zzV6IEwJ9Gjo6PgemA8klD37wKCMXnWMerYkbpo78W0DCn7pWJSzSdmesKx3uHrtvWL7W5g/t5lZN+PdElIpqs5gBK6KAc5mAxp+O3wc93BxlsiKXJb5L8H56RRQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(4326008)(4001150100001)(5660300002)(2906002)(8936002)(6506007)(6486002)(6512007)(478600001)(9686003)(53546011)(66476007)(66556008)(316002)(66946007)(41300700001)(38100700002)(31686004)(86362001)(36756003)(31696002)(2616005)(83380400001)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGZtZzlRVEpuUWdMV1JweG9LeklXVmRWZVUzc2J4UXV2cDlwUmZ3NmU3cVJo?=
 =?utf-8?B?YnhyWW1QUTZZdUNScVd6bDNNZFZBUnZHWWxkTDZYdlBnUGVKRVhFd0txZWx2?=
 =?utf-8?B?SVkwdmpEWUVLSWgrYlZBNElmNTVHMEFqTVFhNmpJekliMER3SWpwMWVXTm4y?=
 =?utf-8?B?cFAxTzJ4NTcrZTBSZ1hDaWVwbU1GNzRNbGpEcEFXL0k4N0Z6dTBQZmtSREV2?=
 =?utf-8?B?MVNOTVFlSGpoTzd1UU1Ha01DZlFadVQyRXhDQ29FaHpXNnYrVkc0SjA3WnNH?=
 =?utf-8?B?NURydGllMlVZdENKL3Z3Y0lDQ3FVQmVQWWFYNXhQbm12RzllR2Z3NytucHV4?=
 =?utf-8?B?RU8zSVIwT050MGFmclNaNFZEdlYxZGJKZXZMUk9yNitobTJPOTZHaHhXK05r?=
 =?utf-8?B?dXJxbURvejMzNklONVhhWWRxSnkxTVJtU1ViS010OXU3c1FCT3Y4RHV4ZnVG?=
 =?utf-8?B?NkhkMDQ2Qkg2Qm5Jcyt6ZjV5cXF0bThtMHJVYjUrOGdwM3ppWlE1WlpwWTV5?=
 =?utf-8?B?MTNCNVQzOVBMMzNEY0pzRUNwWU1Vb09LbXYzZHRub0gzZTZFTU1EN21NK2Nt?=
 =?utf-8?B?QkFYbzNDR1k2YjQ1dE1sSFpIK1FZYUVaRWxvZEJ4eTI0ZGtsL0l0RG8rQi9m?=
 =?utf-8?B?Yk9zSjQzaGVHYW5hRFFzVlhhSVlwSndNSDY1aVBWS3BrUG0rL2VFOWF0aXM2?=
 =?utf-8?B?d2hqWmlSSll4ejFCVHFsUDlYTC95Yk5HOEdTV2liS3dqN2tlT0gvQXM3Ulpz?=
 =?utf-8?B?b1Qyd1dwMjVsMnVqSUJxYW1RVTJDN1hoaVNPUFYxSzZ0SGIrbEd1REhMcnpE?=
 =?utf-8?B?dEI4MkRvajFRTFVOV2k2R04vWCs3Y1M3OVh1SThITzc1ektYV3V0NWp2aU1L?=
 =?utf-8?B?TmMrY2VieXpJMVhiTDlLcFFzaDhRUE01aFFjdzJhbXZKRjkyaXd4SFNsSUlZ?=
 =?utf-8?B?eE5WU2ZGWnVGbXVBNEJ0d3kvbng5d1NmN2NRdlpMcGc4T1NwZDE4T0FRdExy?=
 =?utf-8?B?am9mUFJJbitJQUUvMHRhcVMvSDk3MWlzUTlCbG5aZ1hwYlJXbExBUUR0WVNU?=
 =?utf-8?B?aG9hZGQrTDJmMU5uTW45enY0NUpMWTRKb09ENTluTDEzWmhDSWhjaEVQSlF4?=
 =?utf-8?B?YW5ZM3lna3Eza2hwMlJRWmR0VXd0SzZvNEtYYVZ3eHNRcWZEdkZxU2NWeDkv?=
 =?utf-8?B?d3VzempTOWxCdUFNZEpLbTZ4NVBpNWlRVlNLTVowWjhyNFQwN2lhRlFMYVFI?=
 =?utf-8?B?TnNOc1d1ZUNyK3ZXQmtOdXVhSWJFVDNETVRySjYwUmloNXFuK2VpREwwVW9o?=
 =?utf-8?B?ZzRxQmVWUjMwM0xBd0E3bnQ3Z2NqTlNFOENSR0hhUFRWZjN5ZGZneDNVZmdS?=
 =?utf-8?B?WDlWQWs0dFB6Rk5vQ05XU3BYUWZZMTIrM3NkcndPV3BxbW5ZWkt4eGtXUktQ?=
 =?utf-8?B?MWh3L1pER3doTmVBaG5JNlY4K25lL1pBQWJLRXFWTlhlcjhabGlBampEYVRv?=
 =?utf-8?B?bmcvRHFPbURDcUF5WG9obExNL3VRUG0xSXJDRUh2ZFd6bldzZkltdFJJN0c2?=
 =?utf-8?B?MU1XakhnT01kRGlQMzU4K2phREN6T0RnZmJ5cEtWQ0FMajJrbU9zT2x3Skx5?=
 =?utf-8?B?REdQN1JBQnQzd0JzV0tPSEdKa25QM3ZobUtmbDV3aEQyekt6a0crU256a3Zp?=
 =?utf-8?B?YURXN21tRVVheTFMbERoYmNiaEVpeXQrTW9Gc3YyZlFYY0RFRzZpUjNGMUM1?=
 =?utf-8?B?dytlYVp0OG5zWFJDZ2ZEcWt3WjhWWTdwd3IrNEtKRzg0TjRFb2VhVXVRUkNF?=
 =?utf-8?B?OEZrWHV4SXlyQlRmekdBVUhyRGF1VEx6ZzlWUW9pQVFhVlIyWEs2ZFZOQUhG?=
 =?utf-8?B?RlIvcFVVaDBrMDNKeWVCNVB0cCtQUDQyU1ViRVZUVFg2aHU5ZWoyR3Z6ZHdt?=
 =?utf-8?B?R2hNRUl0VkhrdlV5MEdMaDFTN1BjUVBRTUlPUHBoVEV0MTEvMnYvRmZrbFZH?=
 =?utf-8?B?WlRFU0wrQ3dmaklwa0s5eTZkcURUNTVPR2NUVUtvVUtrZTh3dE9TZ0xNM0N4?=
 =?utf-8?B?SjVjaUtWYkoyS3dGdDVpMU5oc1pZVko5L3JBaXJNRE1RNkthTHQ0SElIWkFw?=
 =?utf-8?Q?xPxso8XaXXCcV+XZyXtYh4+f2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lB8S0heCYclFQcauedDcAOqeDyFPksLwIvCKTAcIfiQBZiPqQ6Fd+tSVfjDQ9TGSnA1XnbVLwOCm8LzSJwDX5MeqEo3drtSDwWhqKrqEq+gsFlZmYF33RlvDsFUbwiUn1lJ7148sCVfjRtKC0abrdMakYP+YbERdQo2RK15w0mySZnen+Q+mHK/o0U8xSKzVIG1t7weJU1g3gVlw807t3NzYxo+Q7eJV3nq0s33b/zqIz3JM/7uQxWkKXGlMlAuZUdOcYus2jLTy++RBunj8GWKZ5TnNr1ZQX9jeyl4PFSJVe3slFXCVatOT+3VO1rq5+T0X+QSQpp+RT/VfkXbgW4yfgD9IPOB3IoNbFBo8KZW/lg1RPERPyAPWjZIEPFR9zPjfA0pH0go9kjEle9nIjKi5DYoJlAY/0flaEpCRGSo/iEsbkNobdumTk00TUh/ubZgle0kIGx1xIWVKLffI4DehIuCOVAEajZ9pYLqRZFYhKvVdGtie2olJA7rkX0DkR8pXjHdAf/1Um2D9OztcIE3BA1mjIyu2b4uFKzhlLabyJVyE+DxmObpmx9SSd6B4NkXiYu2RkWT8ukrs7YTTgaeIRZv9DFe97oWGpts1dwc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db40d2a8-9ada-4c89-3bfc-08dbfdab13bc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 20:19:01.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJOHfgoPXAQBncOkcS2FzDkP8k0j+w5vdmbU0DZBFXtqTCW3xGo8w+eK3I1FdRVTGtjFN8SgVDWDXAtLy+gdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150142
X-Proofpoint-ORIG-GUID: I0QydNyofb7LbSzJ2VPCQci-8-VzdcGR
X-Proofpoint-GUID: I0QydNyofb7LbSzJ2VPCQci-8-VzdcGR


On 12/15/23 11:54 AM, Jeff Layton wrote:
> On Fri, 2023-12-15 at 11:15 -0800, Dai Ngo wrote:
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
> The RPC won't necessarily have timed out at this point, and it looks
> like ncf_cb_status won't have been set to anything (and is probably
> still 0?).

The timeout was added to handle the case where the callback request
did not get queued to the workqueue; nfsd4_run_cb fails. In this case
RPC is not involved and we don't want to hang here. Note that this patch
sets ncf_cb_status to NFS4ERR_IO before calling nfsd4_run_cb so we can
detect this error condition.

>
> Don't you need to check whether the wait timed out or was successful?

ncf_cb_status is set to tk_status by nfsd4_cb_getattr_done. If the request
was successful then ncf_cb_status is 0.

> What happens now when this times out?

Then we go through the normal logic of nfsd_open_break_lease which will
also get timed out but eventually the lease, delegation state, will be
removed by __break_lease after 45 secs (lease_break_time).

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
> Why 20s?

RPC will time out after 9 secs if it does not receive a callback reply.
This time out value needs to be greater than 9 secs. I just be generous
here, we can reduce it to any value > 9 secs.

-Dai

>
>>   /*
>>    * Represents a delegation stateid. The nfs4_client holds references to these
>>    * and they are put when it is being destroyed or when the delegation is
>

