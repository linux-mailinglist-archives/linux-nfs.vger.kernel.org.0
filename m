Return-Path: <linux-nfs+bounces-768-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2EC81B9A1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Dec 2023 15:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343CA1F21AEC
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Dec 2023 14:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3A1D69C;
	Thu, 21 Dec 2023 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OFznI+7r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aeG3nkwl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30797816
	for <linux-nfs@vger.kernel.org>; Thu, 21 Dec 2023 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLDOkLo028555;
	Thu, 21 Dec 2023 14:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=/74Dbz2CdL4aaZWe0NE+i4ia1tjFZinUC2aP4mKQ3N4=;
 b=OFznI+7rsB9kgW87amPGqEERzVE9TJG/YmGxFr6HUk6U3GsR7zyy4inpJwiX2igvRevd
 JZAoG8iEqs5aF8itYceIuuv5BrrPPwkKvgnjviytrV5jZPp73d/Zs7tVGigbXGafdNhG
 p87K4x4mWx66xBIsGFsFgW2e8KX8EO5O08BqLF8qu4FaKdoyF24ho8YBuzmiArrMfRk9
 5faH4MD1G1AFEqHCzq2BgQ5MLP+hs7/NfrCqiHh1g0PlVdD/xzmcS+Kxvpx04OBoa3CI
 QiW2af0fuRR4ErYpORZ5uvoi1WN99jCE6ZV5mTcrHpbJLNE9T+7spiZdjcJ861uXwMFb EA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v4atx1axc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 14:33:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLDYjwP024087;
	Thu, 21 Dec 2023 14:33:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bb7rx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 14:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYnqHkQ3SC7tdp/IKtbxLceVw59H6dl21Mlr4x9wwYtTtfr3SjEtrzuNqXPRZlUCOuGgfhjJTgE7WPR8U+BzBcnfCxHuRH1RWl0KqvloJJ+Sv17bQ14ZWLC5mKwVvcrS1Yxw8gP/KAvzq37Z3q3S7L+ZOT1dosmXBtUoKPxW28HYAdf+0hQxqRpD0PY1HO5rpp75rwIXoTHYRqpPiNxhhRhXZjPwJ2lLaIlzNXlNtOu9IfTN7bVXjLrQLWnPJu30uGVA4MRu6zV/nl6aSsc3po4N0jV1qIwPfZP62LW2VODQ6lsnRnJm9XT9wgI5nse/KXLtVNqFn7F8piDe4P20lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/74Dbz2CdL4aaZWe0NE+i4ia1tjFZinUC2aP4mKQ3N4=;
 b=hFTlOC5QgVk4l7T1aEWoj2qyg+2qTapEKx3f0oHLdRW/38+5VdFybWBJ5CZkUmcH4ZnYRT2IBQ/6Hzf6rXArcce9yO8a7s+1rB4DPD5pl8P9kvTw0cH8xoXwT6wElxm/eYDL1Mfq+9DHGAFwqDgGeIjzGJ9sLhBEDj2s1LQOK244nPvNaqyCMYSDSO2G/OAFfqHRceGbl3ywnM6+57Iy9QyVi41S9h1JxCeLoZPhlifolkFG1/YMdDDFzNVPV80JAS9yRb0YSPynZdLYo0jc7C41vR+Rtdow2WnJx4VzFIWnEAxZw+8OV+xWnSRVlJvNhSGVfsTNzFVZj752ke8m+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/74Dbz2CdL4aaZWe0NE+i4ia1tjFZinUC2aP4mKQ3N4=;
 b=aeG3nkwllRTWti9v/a3k9JYcx1TfbGLC+JYzMEXxTZ3vtGOmEt6rlxX+cxmshnw0GZ2NUhYL5v/H6TjLIO4Og9umZAgZz9U8PMWRPjhgyV6eA01DrFYOWoe7WPKgVlQZTKAoTYJDP2QmS9FYdx2dWlasCoV1sdD86ZY0u1MNwzs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4730.namprd10.prod.outlook.com (2603:10b6:806:117::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 14:33:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 14:33:44 +0000
Date: Thu, 21 Dec 2023 09:33:41 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 alternate data streams?
Message-ID: <ZYRMxTWAdtXbe6in@tissot.1015granger.net>
References: <CANH4o6PeiV+ba0uLVzAnbrA3WtG8VSkvjA1_epfLCVyH-r-pJw@mail.gmail.com>
 <DBD9B468-6FF2-4806-8706-EE679BF69838@oracle.com>
 <CANH4o6MGLTCYuDBZfyrDn7OpD=HcUG9KcY8Qhhv5mzHj4Jr03Q@mail.gmail.com>
 <3DF544D4-EFBD-4C0B-9856-91A3092A26B0@oracle.com>
 <CANH4o6OQgAVVs8chSxgw9mWsn9SC9_B8tZzTNDPNvGnT4naeFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANH4o6OQgAVVs8chSxgw9mWsn9SC9_B8tZzTNDPNvGnT4naeFQ@mail.gmail.com>
X-ClientProxiedBy: CH2PR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:610:56::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: adeb1675-39dc-4cb7-42bc-08dc0231d583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5+5BOdFVHj5exSqXKKrp/HFUbRf24aV3oxsZykyZfF7oErFxQ6NK01Rz6ecG/MVWAo/nfO6/6VmRqa3t7EI6GX+ra/1wcZ5OuQhRiSvEvkntQdCPQUX5V6G7OYk78Xbr5gUn+h7BPrZ+JaRo+FsmECTqCI3eV5mVJOG0I8KjvPZXI05/4pBkah/6r8RDKf+Kki2rjSZ+RAuc48Y+4pl3ROlXYhZ+V3GW1GsiuyP0yaBsSTsizzW7+G2YQp5JlMNmaSAl2NoaJb7+sGvwxdhpjTVe9XAWRhOYrwA/7amLRIcv5rhBqUJ8y8pL/oiY77L0vpK+Nr9hh5APi0vu070Q0MN8ZIZhULYU8+5Hk4QzMCtusGXVvLkx8m6dA+F3LH1esfGJAagg+439CgSyVLQpZiFwd2WHPDA9/79IHHL/9SN9kzNtlWg2K5QZwQGiYCnuQtVx8EEdA3lwCK+iOlrnvTpkBRnPbqWEDf9uHpguFSAneThs8kSrfvEvBCFC4iZgpnvv/pfH1syHgjRDvcGlYKj4TyXaH0KZcdmtM9ZuXS8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6512007)(41300700001)(38100700002)(6666004)(2906002)(86362001)(9686003)(966005)(66476007)(6916009)(8676002)(66946007)(66556008)(8936002)(26005)(5660300002)(6506007)(6486002)(4326008)(83380400001)(53546011)(316002)(478600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzY3alNQTzBITFpXL3A0ajl2VUIvYXQ3cGk1blg3UTAyODVwMnlvelBTcENr?=
 =?utf-8?B?WlRFeDFHWTMxa3FrZHJyd242WDUrdEYyY1JOSmV1ZEN0aVYxaWgxUlhNdmU0?=
 =?utf-8?B?NnFOVFBvdURtbk9UUkxGZ0tSWExmS0t6ZEJjNm5nRzRGbDhRNnMrdjY4WUM2?=
 =?utf-8?B?RmFTYko4Ymw3V3ZzM0tjeUk3dXdWR2Y2d3pmdW8rWEp6ZGp1QWF2YThpSWw3?=
 =?utf-8?B?UEN6ZEZ4ekpUdVUweE9IMTdabFpOczd0d2dacUZNM25CeGhyN25vaXY2SW9U?=
 =?utf-8?B?NXdpc3oxU0dONHlwdWdzNE5nT24vUUFmOXdrb05IUUdVM3Z3Q1B6bjAyNWF2?=
 =?utf-8?B?VUtaK3BUaS9yUWdJVDZacTlvQmVsTE8zeWYrSkRHS05tNzRBekVmeDJDb0ph?=
 =?utf-8?B?VCt0dUgzL3NPaEhadlVDVTZPYU9yQ2JVbjlrWndCVDVsYUNQeG9UcDBLNk1n?=
 =?utf-8?B?ZGhBdStyeFFaMFNkeWJMdjRhWUhNL2Rvem1sQVEyaUsyOTVjVXVnNjFsdTVS?=
 =?utf-8?B?TDZaL1ovaUdIVzA5Y2VBcndOYmg5RTVvcDZnb2M5NGwzU2NXYzZTUWpzLzlR?=
 =?utf-8?B?V1E4OVNRM1dFU2p4YXYwSkxWWCtXYkplZkpIUXFoZVJuWHlYamJiYTFFVk80?=
 =?utf-8?B?NVhUSTBiMzRaTC93ZkxoYXRDdVpXZldNb0RMS3VIc3B0d252dzZXbnNST3J0?=
 =?utf-8?B?azNCYjNuR0t6MzlNS0Q0ODFqYVEwd2xCdDdCRkJCQnJGTGF0c1Z0dUhiVW1D?=
 =?utf-8?B?MC93cWUzZE1GWFVKb09rVm00M0hhT0NoVWRGenRCN3lNQWpqbmU3ZWdZcGxo?=
 =?utf-8?B?bXdtV2tlb1o5NEMzWFVYWVdhZmpwM1dhNEpUQlRQZzZVd0lwa1d1MnNxN2Rv?=
 =?utf-8?B?OTI5K1VNaWltYm1xRWN1SWlwNm9qNy9OcHRkOURMV1RUd2VVcHpNdmg0RGg2?=
 =?utf-8?B?Ny9tbEJ6ZjRaMk9tYkZwTDFBMVY0MkhwR3hkRm5GY1RIb0k4Y2Ixc0V1M1dW?=
 =?utf-8?B?QTAxSk1Ba2diOGphSE9UblZiRWhSRTRNdG9JOXF5R1U4c1ltNk1taXRBUWIz?=
 =?utf-8?B?TElNMDBJZVczNlBIN2FScm9sZlM0OXV4cTU3Y2N6YUJYOHhPNFZFRTdFTkZO?=
 =?utf-8?B?MU01cU42TVlsb2dyMWwvNHB4V1p1KzZzWUwxK0QzcGhpeVBXenV6MGhwN3BM?=
 =?utf-8?B?Rkd5Zkk3WTV4SFVQcWtYUmhtTWNwWFlnaUJTVG9zZzRuck5GdEVXZ2lPYk9S?=
 =?utf-8?B?emFqYVBMWjh6elUydjIxL3lXZFZWb090dHZxczFEM1N1ZzdPbGh6eEp5YTlZ?=
 =?utf-8?B?aVJpamVVdE8yVmJSam1aTWZMMGRER1FSNEJnbjhuU21JV3YwYlB3RjNqelo1?=
 =?utf-8?B?aHFlUFRQNWpMWW94VXJnb3ZmS0lwZlUvQ3RLbVIzVFJXWmxYbzc0R3NpZmUy?=
 =?utf-8?B?Zno3NWFWNnRTUkg1MDAyUHovWWFha2hqSkdjb0twcVdLMllYWUFCeUdMZnpW?=
 =?utf-8?B?d2F0dFJvaXZHRWE0WXhXbzdsSmNkRU5pNmRWSkROeUhjWk9vQlhaMzU1UEhG?=
 =?utf-8?B?WXRnamtnNlArSnZxaVJvYkZBWVhpUDE1U2l3UXZZUWsrY2lqTEgzK01rU2lt?=
 =?utf-8?B?M25VQzM2NXRIMmhyMGRXbDFQbDdrRzZGNU56Z29Qb3VpYWlGSmZKNk15azdq?=
 =?utf-8?B?ajhBYXN6amRsTHJVSytRSmNuMCtTMXgwN3dkRkRMWGVMSVhXYUlUeW9jNjFY?=
 =?utf-8?B?a3Q3QWR5QkFpK0syckpNU00yZUFsS0hJVDNiTW8rVWhBOEpqeklOV29SVVV4?=
 =?utf-8?B?aDRsK2hwSTVqVWlSb2VzQ2dXTzdoTGJkdDFqdStoTDJPUkFWdjZKd3JuUW9z?=
 =?utf-8?B?bXRFVlV2bGdFdmpOVzMwMGw5VWNneFdaVVBYR2ljbnNVOEcrL052c1JnNG1C?=
 =?utf-8?B?RlNYTWRpOG1nTExWTHJvbUdycmhseHhCUWdoSS9OQWhIMzZLZG1UYm9SNU1X?=
 =?utf-8?B?L3BkNmJCMjhsb0tKNHZDQ1lyQUEyTTZOWVJwV1Z1MFpreHhVRVJDcmg1eHly?=
 =?utf-8?B?Nnh5YmZiSFNycGMzQUJRUmpEM3lUcUN6L0tqSFZ4cjRlY3FZazFpTmV0U216?=
 =?utf-8?B?akIvc3BpT2V0aDVTTFRTb1BKMkR0WWxMMzNSeHhkTmVnanNSMVFuTlZVVmla?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vnhKjub8qw0nB1FOnCaGXUF9KOcMuxkwhw2M0RH/5cS+5lUDl598Ajow/qvXT8mMSNCfju+24C+YG6vdtSoJmnKRTFN/KJ/4PYbmz8PzO8CIVhNJ/oFKVJS0C3pTOsSV7eoMhwtvp+Cy7qz9KHppcc2jsXOPEb+tQk/Y4Gu0ivnjQWq1TShgFFHHoEAYzePs9oJibkqv08bvbDwK3e7PcLO1JsO4f1T5fSfSJQoGva/HQa4OvW7LqyVP6P+ZSvc/4WWY4MD7wluJRLAoECLCufwAipLf4jgAZMj0CHZtqLoFliqQymb0HloJWjwT1EZO3/h710/wTRmuYr3TOl7peJlW7fJXUa3153KmzQIJx81UTLJubXkLTIDMVM3c6YUUY8GW377kxdvKdVFeH4L+7RgDWVxl0mkkTDk9tJUpeR+hwtr7RSQFxOV08dqTWEQZ5Xp76LpP7NwAhVSBi7YDc5Op9Ct0o2pLvwixEj4LflIhlYCf2tolj5eg6b/y/zl88s8x+dG5CYMEHlBOs+U41mjQfCO1FDj8oh8xyUh6plBuVjbOBvbaK76v/iJNRn7vsYv1JKcdS4uIKT1VUG7/AlgGhZl2G2Vd3CBKMxbBKbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adeb1675-39dc-4cb7-42bc-08dc0231d583
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 14:33:44.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkUohjv5qS6gEldY8JWXT5VkU2rpsRH2jupls1jbExrUYiY36FCGOXk1uMSLtweP5c1Q0PqLZXcGXQLiTsWxAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_07,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=922 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210110
X-Proofpoint-ORIG-GUID: aJt5B3m8ZAsBasVrQEckMcS_9ziVr93s
X-Proofpoint-GUID: aJt5B3m8ZAsBasVrQEckMcS_9ziVr93s

On Thu, Dec 21, 2023 at 01:26:31PM +0100, Martin Wege wrote:
> On Mon, Dec 18, 2023 at 3:49 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> >
> > > On Dec 18, 2023, at 3:33 AM, Martin Wege <martin.l.wege@gmail.com> wrote:
> > >
> > > On Thu, Nov 30, 2023 at 3:03 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > >>
> > >>> On Nov 29, 2023, at 10:59 PM, Martin Wege <martin.l.wege@gmail.com> wrote:
> > >>>
> > >>> Hello,
> > >>>
> > >>> does the Linux NFSv4 server has support for alternate data streams?
> > >>> Solaris surely has, but we want to replace it. As our Windows
> > >>> applications (DB) rely on alternate data streams the question is
> > >>> whether the Linux NFSv4 server can fully replace the Solaris NFSv4
> > >>> server in that respect.
> > >>
> > >> Hi Martin -
> > >>
> > >> Linux NFSD does not support alternate data streams because none of
> > >> the underlying file systems on Linux implement them. Very much like
> > >> the HIDDEN and ARCHIVE attributes.
> > >>
> > >> I believe Solaris and their storage appliance are the only
> > >> implementations of NFS that do support them, since they have
> > >> implemented streams in ZFS.
> > >>
> > >> Instead, Linux NFSD implements extended attributes (that's what
> > >> our native file systems and user space support). I realize that
> > >> the semantics of those are not the same as stream support.
> > >
> > > SMB server on Linux supports Alternate Data Streams -
> >
> > I was not aware of that support. I need more information about
> > how that is done.
> >
> >
> > > why can't the same be done for NFSv4?
> >
> > I mean, yes the standard NFSv4 protocol provides a way to access
> > these, and NFSD can be made to support that. But where would it
> > store that content?
> >
> > NFSD can support what is readily available from the VFS API. If
> > alternate streams were to become a premier part of the Linux
> > file system stack, it would be straightforward for NFSD to
> > support them.
> >
> > IOW first NFSD needs the communities responsible for the VFS and
> > file systems to implement them. Everyone has to agree on how
> > these are stored, we can't just make something up. Otherwise
> > there is no hope for interoperation between local applications
> > and applications that access these via SMB or NFS.
> 
> Yeah, that's a good one(TM). Seriously? You try to pull on a 'John
> Reiser' on me?
> for those who do not remember, or are too young. Once upon a time
> there was ReiserFS-NG, which had support for that, and the VFS people
> dragged him and his project through the mud for religious reasons.
> 
> The 'religion' here being that Alternate Data Streams are from
> WIndows, and therefore this is BAD(TM), EVIL(TM), and SATAN(TM).Even
> if someone would come up with a serious, technical sound patch they
> would just bicker at the patches so long and so often that they just
> rot. Death by a thousand cuts (or nasty review comments). Remember,
> for faith people will do anything, just look up the "dark ages" in
> Europe.
> And just the tip of the iceberg, I bet someone will deliver the
> argument that John Reiser murdered his wife, children and family dog,
> and that's why Alternate Data Streams will never be part of VFS.
> 
> So back to the topic: SAMBA people just support ADS by sticking a :
> between filename and stream name on the SAMBA server side
> ("filename:adsname"), and are happy with that.
> Why can't NFSv4 do the same?

IIRC ":" is the SMB filename separator.

NFS can't use ":" to denote an alternate stream because ":" is a
character that is legal and valid to use in POSIX (and NFS)
filenames. Therefore...

... the NFSv4 protocol /does/ support alternate data streams as
a separate protocol element. They are referred to in the standard
as "named attributes". See:

https://www.rfc-editor.org/rfc/rfc8881#name-named-attributes


Named attributes are an optional feature of the protocol. That means
that a standards-compliant NFS server implementation is not required
to implement them, and there are mechanisms in the protocol for NFS
clients to detect when that support is present or absent on a
server.

Linux file systems do not implement named attributes. Rather, they
implement extended attributes, which are different enough that they
cannot substitute. For instance, you can use read(2), write(2), and
lseek(2) on a named attribute. Extended attributes have to be read
or written in a single operation, and are thus limited in total
size, and xattr I/O always starts at byte position zero.

There's also no VFS plumbing for named attributes in Linux, and
no user space API (for applications to use with the NFS client).

There are two file system implementations on Linux that can store
named attributes: NTFS and ZFS (which is out of tree). But the
practical matter is that the Linux NFS implementation cannot support
NFSv4 named attributes until the Linux VFS does.

I'm personally agnostic about named versus extended attributes.
There's no good-vs-evil here. If the VFS were to grow support, I
don't have a problem with implementing NFSv4 named attributes in
NFSD.


-- 
Chuck Lever

