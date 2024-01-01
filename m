Return-Path: <linux-nfs+bounces-852-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEFE82148B
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jan 2024 17:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1D51C20BE0
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jan 2024 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6A63D9;
	Mon,  1 Jan 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="efiHHx8z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tTpBjOPy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23563C1;
	Mon,  1 Jan 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4014Tfns028391;
	Mon, 1 Jan 2024 16:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=j2NN6ZST2fYCFeWZ4XUxSxQByNfu539jkMhzBP9J3Rk=;
 b=efiHHx8zcAhLB0y0tFDsGQgU/HtSegq0tMV9W4Aptr49QgMJtJ6gojWJfXIaLyRmyrx9
 zk+qgh06IYtLbSxt6A20tlDXLegD1lPKcRs4fe5k0/WKlb8wj6K0+M7axYbLtKBylFRN
 zIFUX0eKdXEjaM22nfejJp0ozA2tmFACA9FDzKjIRBd1s/yO0VrzQ20M55hjdShmjBhQ
 fqLmbWnZZcBdhldKbKqpd8LorlV/KAMAQsv40/tTkbT17//U1jD4pAKQCSqDlteJPA+0
 mjRyD4ZdDnJ9FjuUuIGw978ZRoUfmYdEMu4apondeviUgROJoPKhbphKsTEkLg6/ILcs NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa4ca060-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jan 2024 16:55:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 401DPE2Y035959;
	Mon, 1 Jan 2024 16:55:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3va9n605s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jan 2024 16:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvIFu73978zsFsNSBeidQRMk8NlakbQypc5m3pNjaOiDJ127d7rLWpXlCddNnYwKzYt034vzic0HpVjtPStaIwW7YBLjWsOjgqNoExzg2aAydQc6Zpt8hPM/b5/AC8Rhtbes4+HgTxU1YTukNZZdcAv+7D2TXdJc5B/LGkwJE9bpedObtWLMVDQWfwFMg2zW7SGkJ39gYO6uadO2mQooiW3Kq27dXC9e+Fg648t9rv47V4gvK729AMHNX95VWwpBwhky290jz8D0Ypi2SZqGBTVNFS716ArtIaUibXkVN5pIi9ToIvPCkkZ6ukPt8CSKyPe48B/9GsH0d5M25G8TMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2NN6ZST2fYCFeWZ4XUxSxQByNfu539jkMhzBP9J3Rk=;
 b=b0S7ojvZ1omcBpaj2qQosn8e9W7BUjdP3ahiNk9nqzrz+/XhqRpH36NY2pSBcKF/mR9O+mtj5tDd6+45pasiSuW93YzauGetvTz8Htr6r47ASB89Smp16GYMyH0Wy502c2INYsK0vkr4K8DwaMS80kQeOjZweI5O58w/bi5KWcquEs02Z8cy7AKaKGnx3dnUBKFvU0FPwcMEXipo7JWCGsfSXYu4qmJHFrcnytcFzjUX7fSpU7Zv5r8PcBv+eAb5/uNDkCwNWoynOPhRZu9lKR3ljVGIywWGuOpZvb1n14kuiWBHA30oWSctEI7SLAuWf6wPmW9Effh240HvhRkHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2NN6ZST2fYCFeWZ4XUxSxQByNfu539jkMhzBP9J3Rk=;
 b=tTpBjOPy8rZBzAJ471uxxx8hy60fB9k5enjIw1VV2wa1eQFM92Es6/quLA+4QkLR5KJhN3Xs3Qe6Wmjy3ruIrGEcc//Z9lUfD0ChSeu/7BN/lIgL452KW92pDEbctPsMYhhP1Be6SeRKfoa+HzDZrb1oblWgm3Iafy3vTfEn8qY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6725.namprd10.prod.outlook.com (2603:10b6:8:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Mon, 1 Jan
 2024 16:55:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7135.023; Mon, 1 Jan 2024
 16:55:09 +0000
Date: Mon, 1 Jan 2024 11:55:05 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Paolo Abeni <pabeni@redhat.com>, Simo Sorce <simo@redhat.com>,
        Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: Improve exception handling in krb5_etm_checksum()
Message-ID: <ZZLuaRwSZI16EKdP@tissot.1015granger.net>
References: <9561c78e-49a2-430c-a611-52806c0cdf25@web.de>
 <ZZIhEJK68Sapos2t@tissot.1015granger.net>
 <4307bce9-ccbd-4bc5-aa8e-b618a1664cbe@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4307bce9-ccbd-4bc5-aa8e-b618a1664cbe@web.de>
X-ClientProxiedBy: CH2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:610:57::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: b88f797f-2273-486f-9b35-08dc0aea6992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sHbDHyN5sGFAoUy6wjvgCOVKKva+Ue7TmJJJV/z6ZXNwHqKW38vd7asGAgOM5RNgyliSrCvKnJRUWrWhAPAwcnU+2l2S3R9g8pY+QrDdXe5ceYsrffqeRDNcE3Ok0GndwKBaoHl+g6tN17j7BsWLe4BjSpQkS39ScczlFZnusIuD1tv8ZV2Q2Qc2oznqBSdXNtRERyy/XtP7nGE4/9b687a/t/JV5baW4QXaIezu5lXD6ScYCyVWYfH17Wi6pJKC96ijLnUrHJoTGjbApSg05Y+k9T8YpiKkU3akoE8nAAGyTs6ModozlogxF0BINx3Q7GyQdFVLCwNMdHHDAFB1/fh0WoijOO7Ikl7r4KYPW96jkuvcjq3ON1YgvTnhxENttw39sfGWWB2U2DfUx5yD7jw9DRLCAXwukWMYnG73tviyxJPLePxskAMHEZNgTWuKrMweHSZlRCuKtpo0MO8OfpiTM+kk5jt4XtDHSOlYtM3KUiIj5gSCI+Uv43FDdvqrG0CiLFnUv14I8JvgemGXUCUZFJyj6Y7Bzj5vCDNDdps=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(83380400001)(6506007)(6666004)(6512007)(9686003)(44832011)(7416002)(5660300002)(4326008)(966005)(41300700001)(2906002)(6486002)(478600001)(316002)(8676002)(8936002)(66946007)(54906003)(6916009)(66476007)(66556008)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cG1VcG93WDQ3ZG9yeGUxaWU4dTFqSHNaYTRvU0NUcjBDT3lWVWVWU3BDTE56?=
 =?utf-8?B?dDRMb050aldPQitsT3RLVStTRVVOd21nUXBGN3NRRk1GcFVwNjIxZ3o5U2Rl?=
 =?utf-8?B?d3NNVWRlaHI4T29naHcyVGhoZ3hXcmFPQWVydlI3VnE0K0YvZTBHN3BMVlZo?=
 =?utf-8?B?ZGEzWWhjczBZRTczekN5YzJ5b1AzMGRzWGhDWkhETlo4MlJiUzBDNkxMeTBw?=
 =?utf-8?B?cmtKQWJ2NG84dWN4U0lhUGJzcTZCbno3UDlJcjRRajNxQ1JJSW1GN3Y5b2wx?=
 =?utf-8?B?SXpBWm1xYzA3SG5RejBNVVIvZVFhTStlWm92ekEyUmg4aG9NNktqb2QxWHVl?=
 =?utf-8?B?dE9VeXBZSFhsZk1QR1RzSHZTWjM3bWFqUVUrZDJ1ZTEramNJZERhOHRBYkR0?=
 =?utf-8?B?UHJLM0xkb1NPYjBXUXU1RStmSURaQ3dINk1YbjJGWG53azlyd0V4MUtLUmVE?=
 =?utf-8?B?eFc0Q0p6YXkxQlhRemJhTWJ3cDRXOHhrbmlNNGVkKzZDZDlpbU1waVhpcS9W?=
 =?utf-8?B?VzFXb0NzU1cwWERpdk5WL0RJbXlJWW02UHBQTjUzeG94NmJUSE1lb2RibzFo?=
 =?utf-8?B?SElHWHZWYTNRTnBxRTBUVkE1aHBDMUU1cFFKNWl5Y09PMytqeW1MUnEwVnhl?=
 =?utf-8?B?RXJyTlAvd3pPTUw3RXNwazdibTViT1RvVW9IWGZSRk9OZ1daYUI1VDZHTUkw?=
 =?utf-8?B?ZnVZc0FCcUI1U1I0Yzc2cTVDOGFubU44MENxV2lDUkE4d3lieFBmekl0VW5L?=
 =?utf-8?B?Rjh4OUFmZ3hBYzFKY3pIV0M2T3dxK2VNdDhGRUtxQ0I5V2FjclhFOTFIV0Zl?=
 =?utf-8?B?a2xxOGZ6dUx4YkhIUzIyTnF0OWlGNWl6WTRXcUk1RUcwbCtwSEdva2NOT3NG?=
 =?utf-8?B?Z2ZrMTRnVFZiWVBPSXV6UG95N3N4eTZqb3ZwaUl1ek1senhHT1g3a1VLRHZH?=
 =?utf-8?B?Z01jVGgzc045Zlp5WVg4WElZRGpxaHBMUnVwdEpxZy9TYmNjaEY1c2ZtN1hE?=
 =?utf-8?B?c1hhV2ZVanNRS24raXhTVXpyLys3RTdqNk5aT1VYeGthTjFCZkM5UHhPY20r?=
 =?utf-8?B?OUNlSU5xMjlPRy9rTkZnd0kzanArWUxDSUVMNXRKRFhueEZuYTYvaHNwVTRl?=
 =?utf-8?B?WnZCVHRKcGxIZXhiVThjTnA1RUl2MjEyWFp4SmJOMzVnWEQxYW5vZTJtS2xH?=
 =?utf-8?B?YmxwakRmQk1hd1hScG9FMElld002MHc2dkZsQi9mTkhtMWt3dGQ0VHFnU0dU?=
 =?utf-8?B?b05wbC9EN0xueEZzS2VKZmc0NFlWQklKTFk3dUhPWXYyNmR5eVdSWHhmL1hx?=
 =?utf-8?B?TUJIYStVM3EvVWRYTlVRNU9INFVpYk8rbXR5TmZxbHF2clU4cG5jc1RPZ1Jm?=
 =?utf-8?B?U0NqUUxrRW1uQWwraGFnTlNBRlpEQWRPeXlvMEJiWGpzSTVFS2FYTjBnS3ly?=
 =?utf-8?B?Ukw3UzZUUXo3SENZY1o3dWpleDk0RHRHdGlEMHRBZVd0Rk5hKzYrN2g3OHJo?=
 =?utf-8?B?RHNEMkl5c1U5TFdVb2RlUDQ5WWs1VjZsZjRJdy9OeDB3ay9LT2tyR0RjdUZE?=
 =?utf-8?B?enI5NnNicHdNS1JnNjBCbW9RcU1JM0lFV2VOekgyNE5RMlphZWFyemMwTVR2?=
 =?utf-8?B?QTEycFFvdXdnOVNoSE9uUWNPbm85emVieEdNTVpXaTI2aXpiKzU3a2JGcXVi?=
 =?utf-8?B?OFpoYmxUckM5em4yUU5PZDU1NEpRaU5YMWNQNkVFUnA0dkRUSFkxL0xhdk1L?=
 =?utf-8?B?TmU1T2NiZnRMV1I3Q3VIKytzWUZKbXF6eHFubHgzbDZ1Zk9FaGMvYW5seHFD?=
 =?utf-8?B?WnBXdnBkNkZ3Z3RxaXlZKzlzRU9wZkttSEpjZnNJSHl1VkdJM2E3clNaSTVB?=
 =?utf-8?B?eGlxcHcwdTE4Q1VpV0hBQ2dSUGgvbHRYTGNuc083RTN4YUhGY1k4ZUlUc1VJ?=
 =?utf-8?B?ajZ3OTIvUnE5cjI2dlRpK0pHZW5zeWVEaTYzSHgrenZiOTJsS3l0UkpqSmZO?=
 =?utf-8?B?aG90c2l1ekpHRFNLMWFMRk51am1oLy84blh0N1lnN3QxbTJOMTU0YXZpZkY5?=
 =?utf-8?B?UFIwUXlrQjdmOXFScUN5b0p4RFpnVWFHS2pMTFZIcXBvSE1SZW1LWGFnYWMw?=
 =?utf-8?B?dWQ4OHFFTXppMHh2b3EreGNZaHFiQW9NV2VPT2NlSVdmS0x1U0xPSG90bm8y?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	acY18RApFGccI8nWmNNy3r6S1fZx/sXdgprvHREWWzj58bH+wEHpE+I2y59DuCY2F7ci1PyOteiZAUAzucJxEXPvEjqZ2F9ZUjemzAA1SX7LoLZf8ykx3uUE1BjDH5mrW0v7tUe1H8EQ4oV8+vRVksyZmRTATajAG71xwvj4yrhMkFxZ0kiJjXCOV/nRLehsl7F8TPPjrYUMF9wYmNoKaPwQIc4l7ulM9jZWXNOtXkCxMz/Ly0GrOkYn2Z7ZFSIjDlM4Amh3hLjVvHDAgzD+kjZ8lsNVOws2ueOI0pDZsRTvMHiUIGfTwgbQ2uNucgSJSYv/4jaJmBbDWHLj0qziYUWIm5uNqT1qgSWmlWr248wtovUFmzFl72/u+/vsbuiBaqynJSMabOBtwApQ0J0VdB3pjaZkgyhkXMSuFFzjyYORvgdiE95IxHHGt1hNxq4P4+67Sqz/fUYpUVz1IFzLvsS0ywHNZItcCnydbUeuf7BVgGBjq5Pww++SVaVHvt8nuTt+djQRifTkAhFwNlvkZgbrJN/qe4x8Ukh/YReubzB1cJzTjU0CvU+x/wgMwi8J6e7cxkRAs//iDn5/PuXu5PN2gUO95/m11n+Deirkoek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88f797f-2273-486f-9b35-08dc0aea6992
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2024 16:55:09.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3vNron6MGpS5g+IkTczdX7LBG9crsfQ+RtZBhKj4AEpqjQ+7N5B6g7XQzp3Yyym9rD+Aiow4BzHHBo72z8OLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-01_08,2024-01-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401010137
X-Proofpoint-GUID: 19UfTR0ZdClceyJ7rWp80gtNwJq6ujAz
X-Proofpoint-ORIG-GUID: 19UfTR0ZdClceyJ7rWp80gtNwJq6ujAz

On Mon, Jan 01, 2024 at 12:24:59PM +0100, Markus Elfring wrote:
> …
> >> Thus use another label.
> …
> >> ---
> >>  net/sunrpc/auth_gss/gss_krb5_crypto.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> …
> > As has undoubtedly been pointed out in other forums, calling kfree()
> > with a NULL argument is perfectly valid.
> 
> The function call “kfree(NULL)” is not really useful for error/exception handling
> while it is tolerated at various source code places.
> 
> 
> >                                          Since this small GFP_KERNEL
> > allocation almost never fails, it's unlikely this change is going to
> > make any difference except for readability.
> 
> I became curious if development interests can grow for the usage of
> an additional label.
> https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resources
> 
> 
> > Now if we want to clean up the error flows in here to look more
> > idiomatic, how about this:
> …
> > +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> …
> > @@ -970,8 +970,9 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
> >
> >  out_free_ahash:
> >  	ahash_request_free(req);
> > -out_free_mem:
> > +out_free_iv:
> >  	kfree(iv);
> > +out_free_cksumdata:
> >  	kfree_sensitive(checksumdata);
> …
> 
> I find it nice that you show another possible adjustment of corresponding identifiers.

I got curious, and tried using a static const buffer instead of
allocating one that always contains zeroes. The following compiles
and passes the SunRPC GSS Kunit tests:

commit 52d614882af007630072857b6b95a6d0fda23c1c
Author:     Chuck Lever <chuck.lever@oracle.com>
AuthorDate: Mon Jan 1 11:37:45 2024 -0500
Commit:     Chuck Lever <chuck.lever@oracle.com>
CommitDate: Mon Jan 1 11:47:06 2024 -0500

    SUNRPC: Use a static buffer for the checksum initialization vector
    
    Allocating and zeroing a buffer during every call to
    krb5_etm_checksum() is inefficient. Instead, set aside a static
    buffer that is the maximum crypto block size, and use a portion
    (or all) of that.
    
    Reported-by: Markus Elfring <Markus.Elfring@web.de>
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index d2b02710ab07..82dc1eddf050 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -921,6 +921,8 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
  * Caller provides the truncation length of the output token (h) in
  * cksumout.len.
  *
+ * Note that for RPCSEC, the "initial cipher state" is always all zeroes.
+ *
  * Return values:
  *   %GSS_S_COMPLETE: Digest computed, @cksumout filled in
  *   %GSS_S_FAILURE: Call failed
@@ -931,22 +933,19 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
                      int body_offset, struct xdr_netobj *cksumout)
 {
 	unsigned int ivsize = crypto_sync_skcipher_ivsize(cipher);
+	static const u8 iv[GSS_KRB5_MAX_BLOCKSIZE];
 	struct ahash_request *req;
 	struct scatterlist sg[1];
-	u8 *iv, *checksumdata;
+	u8 *checksumdata;
 	int err = -ENOMEM;
 
 	checksumdata = kmalloc(crypto_ahash_digestsize(tfm), GFP_KERNEL);
 	if (!checksumdata)
 		return GSS_S_FAILURE;
-	/* For RPCSEC, the "initial cipher state" is always all zeroes. */
-	iv = kzalloc(ivsize, GFP_KERNEL);
-	if (!iv)
-		goto out_free_mem;
 
 	req = ahash_request_alloc(tfm, GFP_KERNEL);
 	if (!req)
-		goto out_free_mem;
+		goto out_free_cksumdata;
 	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
 	err = crypto_ahash_init(req);
 	if (err)
@@ -970,8 +969,7 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
 
 out_free_ahash:
 	ahash_request_free(req);
-out_free_mem:
-	kfree(iv);
+out_free_cksumdata:
 	kfree_sensitive(checksumdata);
 	return err ? GSS_S_FAILURE : GSS_S_COMPLETE;
 }

I haven't tested this with an actual sec=krb5[ip] workload yet.



-- 
Chuck Lever

