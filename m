Return-Path: <linux-nfs+bounces-317-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF1804144
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 23:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3057F1F21272
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 22:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E56381D9;
	Mon,  4 Dec 2023 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PkFrz3QM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xtYuGEf1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8C9101;
	Mon,  4 Dec 2023 14:05:30 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4LnuTB019687;
	Mon, 4 Dec 2023 22:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=invrbxQpf8P68RHJgicOg1YulTXnzvQK2baOM8KCEak=;
 b=PkFrz3QMVZQJPPjeIarg+zAnKb4mc4ZLTyWgsbva+sGVu7U0QFmQg52nKuzYIO9IuCMO
 3b2j4OHB9ierfY++hQ/BAcrgNKUpI/dOQWkCl7js5jG8188FCvXSPQUg93QLxgvkbtgD
 MBFkNnugGE2Q6SG/5mdKHrD9hSmXaXfwVglM1wOH3RIrXLKeh2T7LSLbnGmZkWhBxiz3
 1unuxkzvoG55yT50Mjy/KiJeU626sU2qwdDtXRhjty6rtdZ7+8facF7Qd67uRoI65T4w
 0AAYyAvNScZJ0/M0cH2cCdhlO2OlrzpxzAbL2JEk00P7vVH0tpYf28N6yU0tGXLyVtf3 EQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uspm703xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 22:05:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Kjbce020707;
	Mon, 4 Dec 2023 22:05:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu16hkdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 22:05:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beWKceIUnDeG9mdfUhUJKOveiyIr7CTzy/AsMqvYc9PgjdXNJ/BOYzfeXKh2E6NOyfxwgbD67W6AAuGBbP/htHSTpLcVScsiSdbErG7iXej1JcSto92zfITGpjctPUMdCrlPSt4vxkGYwOjwBY4cVBa1DneVen/4uGDpuLUF1lP63n0v//0maqrDPDfFP9kf7+9+DsU60hJ3w3cjRK2zIbwDlj9DFWe8YwRN7q+dVTJHSBdJpQmOH66vxxowMvnFNTryuEq9z7ze9rInAmvBLHb6TR0qoYsjCzDfr48T0RpGjE6TOl/Zm60aUq9esr0P+kPh6grQTtvnE+ase3qB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=invrbxQpf8P68RHJgicOg1YulTXnzvQK2baOM8KCEak=;
 b=cSnV0h4hiyOtBWBNyQhyoHc+kJIIsx0EK1ASmKf/lH56hsmTU0vCWpGb7JptpWNPoo8ggCsud6jCDRAObgCr1VPyNJcNVOv0zpkITUnbf541CHPHioa56lIesBsVyY8Eo9X0wEnox+QqcgGFOXg0LkKg1qD7GIRa7FlqjReWMAYWNmuRW62vpMD48v22hXyrrr5ez8/z5Y70/n6ah5MIv3DkDJ0D9oIJOnnjU6IAs/Scd6dgPwezwkKbnsrdC1RUihCjog++YUfJlLXCwUdWdXPi60cTVzWv/6a1AZjzeAHjUpdOPDhtj9jR5a5lMZotzwWRKybG6503UAX+ajhExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=invrbxQpf8P68RHJgicOg1YulTXnzvQK2baOM8KCEak=;
 b=xtYuGEf10lUETwDbMKREN8m+P7nMgwiiDUhaC3qAAxek9qUk7pZXnpBsQngJ3cDq3R9smm4iW7ssWEftsWcemt3gIj43EDnb+cb5BVd1iHu5oiljKDV4uQuxF2uS6lKMHps0TncRUIE9EdL4DyYLKfWUipDb54lw7AwPWkB3x+4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 22:05:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 22:05:05 +0000
Date: Mon, 4 Dec 2023 17:05:01 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Anna Schumaker <anna@kernel.org>
Cc: chenxiaosongemail@foxmail.com, trond.myklebust@hammerspace.com,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenxiaosong@kylinos.cn,
        liuzhengyuan@kylinos.cn, huhai@kylinos.cn, liuyun01@kylinos.cn
Subject: Re: [PATCH] NFSv4, NFSD: move enum nfs_cb_opnum4 to
 include/linux/nfs4.h
Message-ID: <ZW5NDYCmJtEWSEB4@tissot.1015granger.net>
References: <tencent_03EDD0CAFBF93A9667CFCA1B68EDB4C4A109@qq.com>
 <ZWy7ob2HhNRX7Z1b@tissot.1015granger.net>
 <CAFX2JfmrGLmEsXccUGZ5drAJ9oxaqjTUxO0tPVgz_mf9YXZN+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFX2JfmrGLmEsXccUGZ5drAJ9oxaqjTUxO0tPVgz_mf9YXZN+Q@mail.gmail.com>
X-ClientProxiedBy: CH5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: c8012aea-229b-4272-f086-08dbf5151239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aGzAkuQFwFQ1l2lp5EDZEon8q2W0/8aT8p5SSMynpXZ1EZ6dwweC+fkSRfgtZmXvIIihWOTIYoxbJEBjb+LRUcllUutoCurlVCsjcWPaUpMnhkpYcr7JIYmXHaw02jrelvAPtPtOYu5+uz5G4Xr1yLstoPOmsREmUopWcLwG8jms7BrFX18IGOVEeZdR4tv3eKCGoDhoSW2sJcZUt66R02MTfoHUnexcs5RwHTsOn9BXawmx94KHmVG/HYaZIU522I7T6wKKdqCHbF7NgmoyQIshxZ5m7Oyv/QSmtCr8Yn+6ctFgKCFyfv4qcBIrlvnbMKQfBZ1VdizA/ftqWbSJPGJW966DDXKHoGeJpWtDIzD3DsoTvaJ6rW7mCw5SkaHbdTSmOhL1vgn7WwwBqUZ2k1+FdQreMRZ7Zz5POdukXOq6p70gsMvXrDh3mpwz4knaYZnT2/6/yzJeM9Y1UMIxOnh/+xYvkU5RI22s2SHOTwMztzOHa0jb6r1H9oGWLWQR2skPcRK8GYe6sMX0Ky01gBn0gmPO5gT2TFfzKW/Kk9ICSkbbUGRB1mRNKL2v58hFmvHvRya5rzX/vL6IpfNnkXfrTl+ssxMCwqcxlNAWjvTj/2cTI51jmGvMjNwd95iZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(2906002)(83380400001)(5660300002)(7416002)(26005)(53546011)(9686003)(6512007)(478600001)(44832011)(6486002)(6666004)(86362001)(6506007)(4326008)(8936002)(66556008)(66476007)(8676002)(316002)(6916009)(66946007)(48020200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dFRmVU9USk41VVVzdmxHYUN0ZmNoUnBZeFFjUlRHclV5K293YmU0dW5ZcVBn?=
 =?utf-8?B?aHFtTnlJZVFGRVFCdTVidk1qN0xqSWpERHE1aEp0bFR0UTh0ckwzaTRwWThN?=
 =?utf-8?B?M0pXbDRraWRmNzRVcUNyOWk3MnRmRlpFOHpqYzJ6V1RzTDQwdnIwNXFWVWNB?=
 =?utf-8?B?K2xjUVBHQ3E2ZWQ5blhyeWd0cWJRckZwaDFuc0JlU1JrdVlrLzFGOUJKZ3hV?=
 =?utf-8?B?bVpDWHNYZnkyVHo4S1RQK1ZjeXMzQnE3TjRpbTdWY2QxMW9BNGpyeXlPYkdv?=
 =?utf-8?B?VVpJUWtXTy9vZUJCQlBvL3JKWlM3MDNUZVZrSXVtKzgwbU1SK0toYW5vc0U1?=
 =?utf-8?B?NUdBYlFPbWl0WGRwdGpieEdoOFhJYkw4Q0pIUFJkbUZwMnIwTUl1ejVLV1RC?=
 =?utf-8?B?T0ZtWnJNUkM4MktabmNwc2hQempoTkxERkkrZEpPbVg2UiswdFpodTRKSDYw?=
 =?utf-8?B?OHNncTR1WlBIVFpteEcxTjJNODgvY1l5UERVUDA3QThuUmJxZzFvZm9OVlJG?=
 =?utf-8?B?SzBRRGxyQUZvQnBydEFqYzY1cGR3MGE1aGlub2huYUd6bXBZMkYvS1VxN0ty?=
 =?utf-8?B?OVZqMzA0OVhsR0luekxvcHM1WVY1RU9PK05JQ0tNS2NvSVMzTzRqa0M3Qm9V?=
 =?utf-8?B?b3ZUN3lxUG8rQzVQdmN3WldaLys3SXFWdmxKMDNUQkIvSEpZbEJzZjEreEtO?=
 =?utf-8?B?NE9VazJEWEwxZ3c3UVNEdE1NMy9taEJDTzBkYjlTa3lXNEdOOCtKek5jVFQ4?=
 =?utf-8?B?YUE4MUNJdUZ6QjJFd3crTnBLOTVXdjhONnZSM09GUnd2OVlFcW0zWFRrNzdS?=
 =?utf-8?B?ZlpJbjUyZjAxMU9adXB3bjA3eWgvaXhnOGZmMVNBR1BUOXl6NkVTenVaYWpP?=
 =?utf-8?B?VDBibmZYTEVVOU1xNUEyZERvRTNwK1NNMmhubkR1UmZ3ZllDMmVvUG5SdE03?=
 =?utf-8?B?NVEyVUEwWjJLTSs2MUJNaGZjOE9yS2JMS3dDUVdPVlA4dXB2cHRBQTU3RHV3?=
 =?utf-8?B?c3FDRmpsZnpWV2orOCtmeGVING5MRlA0b1VZNk9hWG5OcTJIY1llOWl4Y3hW?=
 =?utf-8?B?djdoY3cyd3Nva0o0TENKOWR3SVBKOEhGei8zVk9FYWZ1ZkhOL0VnZ0JWdzlM?=
 =?utf-8?B?eUVLOS9uNkRmYlpTbTFGaE9zb2F3Si93cHJNRjR5alhRTDMxYVhNNEVjcG1V?=
 =?utf-8?B?QjMrUldxYWtNY2NMRnpMWUV4SGJFNFNXaUh5dm9lbnB4TXZiNTBZcDdlcTlz?=
 =?utf-8?B?RTVwcHlJSmxOMTNsb3hWWUdXSEVaSVBERVE5TFQzbnhNUWNHeUtNREpFdEh4?=
 =?utf-8?B?ejFsQkE2WVcvaVpkMFZzdXFvZGw2SHVaZU9xN1NuSVhJQ29xNk1tVi9Ycld6?=
 =?utf-8?B?cWJ6UmF3c3U1LzRGR01hU2dMc3hYZkMwYitpTkxESDVwK08yY3Yxb0k2dWN1?=
 =?utf-8?B?WTBMZkJRVHppRnVLQkE4ZjVrSXJiWE0wK2pvSUlWbUZPdi9hS21zUmpYSUdm?=
 =?utf-8?B?ekk3OVY3TDNWUDROb2hEVlBPcHVLTFZFTjVrbDlrMHIxcXR6d2ZXN3hsdDd3?=
 =?utf-8?B?RkM0bEJJQlh1TlpFdWR6dk9RbUpORTRBVW9PL0lPV0FuL3JrTDBldVdnV3Vs?=
 =?utf-8?B?M2lVSUZRUFBadnlhM2l1ZkhwL0pSdCtwaEZiYUhIVWk0U2RtK3ZoWlk5SFhi?=
 =?utf-8?B?dEh6T3hHZ0dVc3FhK2RSRWoyM2xvdWtrMkFPR0p5ZzVVeVc4eGZ1QWlQREU3?=
 =?utf-8?B?cXh4K0xSZ3FxcFZYejF1aGw5Tmh1ZkZjS1A5TWczVlZodmNQeUtZbWVWWTFq?=
 =?utf-8?B?TEhxK0l2YThzUitKTnFPemUwa0FFanpEU3R6M0dHYnhlamUzb2I4aVVUUzdD?=
 =?utf-8?B?b1pMTGZ1OW13Q0U1Z3hYSys1NXp1MllLUFBFZHd3Qy91OHJBZlNIZm9ZRDlm?=
 =?utf-8?B?ZnI2WDI5azg0LzlITFdoZFlhM2VSQU5rNjdPWS9ucmFPVlplWVhyeUR0ajE3?=
 =?utf-8?B?NmR1WDlEVXJqTGhhMHdqT1ZMVVkzcGFubEtxSm9OalBuK0IweHpBUkptUXhW?=
 =?utf-8?B?TzZ5WUtzd2J1WHFOOEZWSWJ5YXI2OUJLTDFQd1djMkJKZk1BUHp6RWhrLzlr?=
 =?utf-8?B?Q3M3UXZob0Z2MkNpbkdpcjlZdk04b2xWVU42VGxDcVl6R1pyVFJtZW43cnc2?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?YTB3c3NKSDBsZnRLMlhxUFQ4TDRqZkFPZTNUTjNWNEZDSVp0NzMrRUdZcDc3?=
 =?utf-8?B?cit3WkppNWhzQjlhV3N1TWtvQmswZ0piZkdTbENoOEx6L2ZjMG9ycGtjSVFY?=
 =?utf-8?B?cjJnUlhYeThpcnFwdU0vMFlERHFuaVFUY3djRHRQMkFtR2RFN0lvWlQwMmVX?=
 =?utf-8?B?U1QzNC9uS0ZNZE1OaXhkOFZUdmhuTTVjWnlNcGcvL2YvejBVRzNIUENCWnBa?=
 =?utf-8?B?MEF5Um5DM2pXWHZnTHB2clFHeVovTzBUSEZZYUhmTVBTbEQ4dHdENlk4OHB6?=
 =?utf-8?B?RHRMWHR6WFBmblNSWXlCZVVXM1M3Vnp5WWhQKzVncXJML2R0Wkw0eWpuamo4?=
 =?utf-8?B?U3FVMkp3ZlNiZTJTTGQ5alVQb1Fzc2VONjc1dEIxNXFCekhPNy9QUjB5bkpL?=
 =?utf-8?B?UmdUckg4b214NExjaDd5Qzlxcm1KcDl0bGhOOHBtOUZqenU0MVFWSFZKZmto?=
 =?utf-8?B?WWdoditkeWJjTmhha01HWXBiUDNzVkRjYmZXRSs3bUJCZ09LL3F0b2k5VGxU?=
 =?utf-8?B?a0o3V3JxcS8yTjZOL2tZWnpoMVJ0ajNNNXNlWVE4bUp2K0hnVXk2N25tNlZJ?=
 =?utf-8?B?aGppLyt5VWxJbEZSVWRTem9KN0JkMlp6UDB0a25nVWRFOUV0eWpyVjJJbWdq?=
 =?utf-8?B?V3QySlFud2F6NGgvVlBSbGZTMW94d1FqK3gvQWdKQ0ZtOHpJbUpXWDhoc2xk?=
 =?utf-8?B?U3BvY2ZpamhYN3lIZWQvSlN2VWRNMitjOU56ZFRIbDBXczA0aW1kaGtVbUla?=
 =?utf-8?B?TmQwOHBJaXp1TFFiZ2tWYmdCamxtRGFCY25ReVY4K1UzNWlXOUZOZk9qcnJM?=
 =?utf-8?B?ZmQ2TW1zb0JpVm0zS1dPQVZxanRkZW1IK3VBYnNnenZFYkUwaDNKVXN2b3dt?=
 =?utf-8?B?eHJWZWVFL1ZlK0Y5Z1hLeVkvWUhiVnRvTWZ4dXh0VmQvcDBNUDU5b3hTMHZj?=
 =?utf-8?B?MUN0NnN3QzFadzNzZEtlYUJDV2luOFgvN29OcUI5dVZJUHhnTjdPL2VwWTNM?=
 =?utf-8?B?Y1JWbTczK1VXbXRXZ3BNVlVJUnU2SkgwTlh2Qk1iQUFHTUdiVzM0dGlWWXhH?=
 =?utf-8?B?ZytwbDczTzFGeE9Jcm9iNVV6a3VxTlFGYWIyNnB4a3JnRS9Qa1N2RUJWbW41?=
 =?utf-8?B?c2xNZmNmUEFkWGdtdFFScEtVaVRpRXZuSjRYeklxVk5FaGJHZE1kb1FCRTk1?=
 =?utf-8?B?UlgwOHIrWGZBTzdjOWRPYWZCcXhjLy9naW5rM21PWHZNaWNkcE5QaVlKRTlS?=
 =?utf-8?B?eXpJM0xrY1VMYWpBeENOQk1mWC94VVhNWmluVGFIcTdDMnJGSnB0bzZLbEZT?=
 =?utf-8?Q?J/gr3eZxZuz6A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8012aea-229b-4272-f086-08dbf5151239
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 22:05:05.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4c1dIFUI1zhUepSaExeSjk0Ui4acoJ8i9LpEOISvgfgVm2fV7fp/C8ynLUbsMtz9fMJ6+D6Ffc22pQpnlUckAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_20,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040173
X-Proofpoint-ORIG-GUID: hmSvyMEzG1P2B0zK5s771pr4vysQYLK9
X-Proofpoint-GUID: hmSvyMEzG1P2B0zK5s771pr4vysQYLK9

On Mon, Dec 04, 2023 at 03:31:44PM -0500, Anna Schumaker wrote:
> On Sun, Dec 3, 2023 at 12:32 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > On Sat, Dec 02, 2023 at 09:07:25PM +0000, chenxiaosongemail@foxmail.com wrote:
> > > From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> > >
> > > Callback operations enum is defined in client and server, move it to
> > > common header file.
> > >
> > > Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> >
> > LGTM.
> >
> > I can take this through the nfsd-next tree if I get an Acked-by:
> > from the NFS client maintainers. If they would like to take this
> > through the NFS client tree, let me know, and I will send my
> > Acked-by.
> 
> Looks fine to me, and I'm okay with you taking it:
> 
> Acked-by: Anna Schumaker <Anna.Schumaker@netapp.com>

Thanks, everyone! Applied to nfsd-next for v6.8.


> > > ---
> > >  fs/nfs/callback.h      | 19 -------------------
> > >  fs/nfsd/nfs4callback.c | 26 +-------------------------
> > >  include/linux/nfs4.h   | 22 ++++++++++++++++++++++
> > >  3 files changed, 23 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
> > > index ccd4f245cae2..0279b78b5fc9 100644
> > > --- a/fs/nfs/callback.h
> > > +++ b/fs/nfs/callback.h
> > > @@ -19,25 +19,6 @@ enum nfs4_callback_procnum {
> > >       CB_COMPOUND = 1,
> > >  };
> > >
> > > -enum nfs4_callback_opnum {
> > > -     OP_CB_GETATTR = 3,
> > > -     OP_CB_RECALL  = 4,
> > > -/* Callback operations new to NFSv4.1 */
> > > -     OP_CB_LAYOUTRECALL  = 5,
> > > -     OP_CB_NOTIFY        = 6,
> > > -     OP_CB_PUSH_DELEG    = 7,
> > > -     OP_CB_RECALL_ANY    = 8,
> > > -     OP_CB_RECALLABLE_OBJ_AVAIL = 9,
> > > -     OP_CB_RECALL_SLOT   = 10,
> > > -     OP_CB_SEQUENCE      = 11,
> > > -     OP_CB_WANTS_CANCELLED = 12,
> > > -     OP_CB_NOTIFY_LOCK   = 13,
> > > -     OP_CB_NOTIFY_DEVICEID = 14,
> > > -/* Callback operations new to NFSv4.2 */
> > > -     OP_CB_OFFLOAD = 15,
> > > -     OP_CB_ILLEGAL = 10044,
> > > -};
> > > -
> > >  struct nfs4_slot;
> > >  struct cb_process_state {
> > >       __be32                  drc_status;
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index 92bc109dabe6..30aa241038eb 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -31,6 +31,7 @@
> > >   *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > >   */
> > >
> > > +#include <linux/nfs4.h>
> > >  #include <linux/sunrpc/clnt.h>
> > >  #include <linux/sunrpc/xprt.h>
> > >  #include <linux/sunrpc/svc_xprt.h>
> > > @@ -101,31 +102,6 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
> > >       return 0;
> > >  }
> > >
> > > -/*
> > > - *   nfs_cb_opnum4
> > > - *
> > > - *   enum nfs_cb_opnum4 {
> > > - *           OP_CB_GETATTR           = 3,
> > > - *             ...
> > > - *   };
> > > - */
> > > -enum nfs_cb_opnum4 {
> > > -     OP_CB_GETATTR                   = 3,
> > > -     OP_CB_RECALL                    = 4,
> > > -     OP_CB_LAYOUTRECALL              = 5,
> > > -     OP_CB_NOTIFY                    = 6,
> > > -     OP_CB_PUSH_DELEG                = 7,
> > > -     OP_CB_RECALL_ANY                = 8,
> > > -     OP_CB_RECALLABLE_OBJ_AVAIL      = 9,
> > > -     OP_CB_RECALL_SLOT               = 10,
> > > -     OP_CB_SEQUENCE                  = 11,
> > > -     OP_CB_WANTS_CANCELLED           = 12,
> > > -     OP_CB_NOTIFY_LOCK               = 13,
> > > -     OP_CB_NOTIFY_DEVICEID           = 14,
> > > -     OP_CB_OFFLOAD                   = 15,
> > > -     OP_CB_ILLEGAL                   = 10044
> > > -};
> > > -
> > >  static void encode_nfs_cb_opnum4(struct xdr_stream *xdr, enum nfs_cb_opnum4 op)
> > >  {
> > >       __be32 *p;
> > > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > > index c11c4db34639..ef8d2d618d5b 100644
> > > --- a/include/linux/nfs4.h
> > > +++ b/include/linux/nfs4.h
> > > @@ -869,4 +869,26 @@ enum {
> > >       RCA4_TYPE_MASK_OTHER_LAYOUT_MAX = 15,
> > >  };
> > >
> > > +enum nfs_cb_opnum4 {
> > > +     OP_CB_GETATTR = 3,
> > > +     OP_CB_RECALL  = 4,
> > > +
> > > +     /* Callback operations new to NFSv4.1 */
> > > +     OP_CB_LAYOUTRECALL  = 5,
> > > +     OP_CB_NOTIFY        = 6,
> > > +     OP_CB_PUSH_DELEG    = 7,
> > > +     OP_CB_RECALL_ANY    = 8,
> > > +     OP_CB_RECALLABLE_OBJ_AVAIL = 9,
> > > +     OP_CB_RECALL_SLOT   = 10,
> > > +     OP_CB_SEQUENCE      = 11,
> > > +     OP_CB_WANTS_CANCELLED = 12,
> > > +     OP_CB_NOTIFY_LOCK   = 13,
> > > +     OP_CB_NOTIFY_DEVICEID = 14,
> > > +
> > > +     /* Callback operations new to NFSv4.2 */
> > > +     OP_CB_OFFLOAD = 15,
> > > +
> > > +     OP_CB_ILLEGAL = 10044,
> > > +};
> > > +
> > >  #endif
> > > --
> > > 2.34.1
> > >
> > >
> >
> > --
> > Chuck Lever

-- 
Chuck Lever

