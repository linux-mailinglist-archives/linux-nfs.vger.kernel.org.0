Return-Path: <linux-nfs+bounces-1925-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0546A855200
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 19:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F7C1C222BF
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 18:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8083D84FC8;
	Wed, 14 Feb 2024 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HpH8gfew";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ofEbjq2p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665BD127B75
	for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934941; cv=fail; b=l3borgEr5b6VvNxjJr1s0pZS2rWtXlaoUF/jUknT6PpmuLfL71EC8SHlJDjADAHS/EfuddVxT8AhNydrBBMZxS6AkFYYXQlp6UjHbxAo6WagAzKL/r76VXm4emS3dlsGyT2MJl0c5kqo3N/QDKn98lEi3zKvWPiF0dkc0nul7XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934941; c=relaxed/simple;
	bh=dBqw3lyPujy2tNImAolh3sJUNib6YtgQ1QsJf0j5Vv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TD8OMcp1P4JGWI7dn2eTYsR2IP4geSugy5FXJRfQ7hoIvDAdiDPxPYf8VEj9NNomyyoTJU1smx247Me0iwhdgDZDJIuVS3RUinb+gEkEwtha5pfRaMZLNLkXqk/sqF2DQCGEQI2Amn4UdK1oNF5USAOh0vrylwmsPA1zeAzdu4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HpH8gfew; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ofEbjq2p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EHOrSZ004390;
	Wed, 14 Feb 2024 18:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6/mcrbtufERU1lVayOL4SXWqNA962EyDiqZ8Bcmetds=;
 b=HpH8gfewic6qqqMQRdQ83lIn/Fw3AkROgjVTZqmAXiiRQ9vh0B0Q7M5CPnwwr69v8avc
 fmTtPMZ1o9ot8dgua4RcAZNht3IyxawoFdtPPDqGd+5yHKtKIB+rYM+kGEfdRmwJk6LS
 tw1aJh1khiR7gqgoftU+lO/2GtFN29S79IyOxdvdJ1ICZK4X84kwQZMlM8EnkruKTBtn
 mfgn8qQJeejSp8E9nbMvv7SplZYwOe4KVWEiiNguReB8U9ht9/sPV636wQzxpd+33tCl
 B5MhDGLqQr8RL3qwmTicVUODcIC8RDFXKNXQ/M/DxxzIRktJmsuMDhvgPFD/XGvWPPwK wg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91vur4v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 18:22:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EH9Coh014942;
	Wed, 14 Feb 2024 18:22:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk92f6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 18:22:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEx3wCQpiOZX/S/OLU1aojoSQ+GyyNfQZUkHjnnVdNQftW0XYE/dhl1401eHtn2zXDnBeTMPb1+8sXwedqCiESOpzoLVVOhyWBcExV0TMrwXNIcRXtvDQrFdS21vWlareYe3wB35nQOPPDtuTCFAh04D5D0ZjoN4KCs+3P+mPIkQQsJTdcjHx0CVRGY7e/+jJfDVy3wWGj08AG3M8i+kVkoefvS7Kv5X8u0mB5UzJ1Poga2QOcrlsQh7gtuAszCYihvET7HpbHA61QDaSNXPsEf3OQb4hL+ROwjGy8Oanexh3Mpk2DUqd+bByjSTAWuTtR/sYBpuotP+Oe2MxuCCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/mcrbtufERU1lVayOL4SXWqNA962EyDiqZ8Bcmetds=;
 b=UZkXq1MehxmuQz2iKCcFj8SgWsuclwW/Rm9vq7S2+moGCltiIndxanpvy39NWnzalvvbwSckcE4ghdf0mgMy6U1pVExT7a9f3GfBawJS2BkZCtnlaBxrhoImX2qOEgmMKy+0xe70MHpYkHzz4YdKoVjltuxV0GV7mOguAbzHLqOqvsJ4tXNMD9Ed/WsF3Op0xpRKFo2ANf69DYsiaKvl5jeRxR4M3PK0TCCNShZqB+XA+z3qbWofqi9BXTkikzhiVmRfk6CH/rv4RH0XdwjW+lI6YE+j0CBZFBC5FB+pvxJ2ovNr6MsozJ+/xUYzWC2M/mxypLhnXRBYAjtnsdkjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/mcrbtufERU1lVayOL4SXWqNA962EyDiqZ8Bcmetds=;
 b=ofEbjq2pi4cMFpBN4LKATWJXRrc6MPgEill//boYFkc9juAYTdmawGFvi+983fh/gctSE8J5xjeJQ17InTt+VQbOFU0NfzSKxFLn7GNnPzIU00/ayMQYtqdeiqquyBXaq7wZ6OWMLd3U9KqF39RgT9tAJ/xnuPsCW2FtYuFj30I=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4735.namprd10.prod.outlook.com (2603:10b6:a03:2d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 18:22:09 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d3e2:9997:f223:71fd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d3e2:9997:f223:71fd%4]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 18:22:08 +0000
Message-ID: <3c26b22d-5b9f-4a8d-bb03-ddfe802e87c1@oracle.com>
Date: Wed, 14 Feb 2024 10:22:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NFSD: handle GETATTR conflict with write delegation
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1707846447-21042-1-git-send-email-dai.ngo@oracle.com>
 <1707846447-21042-3-git-send-email-dai.ngo@oracle.com>
 <ZczTPSSCmKSmdSnB@tissot.1015granger.net>
 <7994e006-b2e7-4c9b-9644-52225e1d9594@oracle.com>
 <Zc0DEuJ+jYevKc3Y@tissot.1015granger.net>
From: dai.ngo@oracle.com
In-Reply-To: <Zc0DEuJ+jYevKc3Y@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:208:23c::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: 811120e7-df04-4d08-c22f-08dc2d89daef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RtyV1Rn+yinzGa0ZWQ8e/C7MYfabh5d9GRSg116KR+XpvfZNncxpaSks7M+GkSm+/kiGDM0P98lBa7yZXRfFQuFsGg6syo0pdm/JaN8vrOINVysBwb9p+KLEDuWp0fHn9LV/XFHmcDFXxYfCs8lZpE+ScHL4QDdJKdavQ2TLL1bZNV3Wb4IXuZMbmIEQYNLBgklIJkYSvHX+jxEa1rvNUTNR63Brll+kZIIPNEKJTnCC7tfS/uHqN/gFTAFCbzAoPyWEhCjtQswM20FxPG6WRktkOys/IVYnhkBoDFjwIYUX42o+gWHon3z7/9/GTgemtrMelRbSwb60w8xQ+nZtK4dFdeeA+UGXcngNdpd/wD/4EcEDybCnES0VpDVkYQsSmk7GZ0xIL5mc4R4JGJdnio3YvnHsBHe5ohWpVE+Gjt55+FSV+ox0LBi3ruHBbU3Mk9Y57q1r8LK+Fcs6fM2EiP6N92X4XeGqJItJLWRZWkbhqj/Ym4ED6XY70gJnVIBXamDvXkbNkxfmBIqidup2anyuh0HmZTtKYvng1sj8ZQ1nuJKU+XBRGNC2nZMwlR3j
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(36756003)(2616005)(83380400001)(478600001)(8936002)(66556008)(6862004)(6506007)(66946007)(26005)(5660300002)(66476007)(8676002)(4326008)(6512007)(6666004)(37006003)(31696002)(6486002)(316002)(38100700002)(9686003)(86362001)(41300700001)(53546011)(2906002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXM0clh6ZG9rQmthcy82K01VL1gwTnpKb3M3VFNsZ004STJBRzVKcURzOXJD?=
 =?utf-8?B?UXY2U011S0hiVUFZS1dwNzZKazUzaDFOUUd3MG80MG1uNTAvZEt2RmJ5Y2Y3?=
 =?utf-8?B?alVwY21NdXU5TFQ0bUJwMlA3dWhiRExXREFTMVhwOXYvV1lxNXcxdjZwVlNj?=
 =?utf-8?B?TGRucnlXN0tHY1MyYmhKSlVkNmJwdTU1Q245SmVEQm40a3ZiczFLcnIwYVBC?=
 =?utf-8?B?N1FIa01seENWUFZTcHlVTFl3V2VvcEQzZThwVnBJaFgwenp2Ynk5Q3BLUkxP?=
 =?utf-8?B?bTYrTWtHakJOOXhZUUY0WUhEcWtHSXdEaFcwQzdSQkQreFJzZlJpL05IUGwv?=
 =?utf-8?B?T24vNnFPdGp0eEF2SE5rMEZtNmxoTjB5UXJtM05NdHhqaVp1cDZzelVTV3hM?=
 =?utf-8?B?UEROYXJNV1JrYjYwT2laSVhDYlpMY0FTcW5DUEJPVkd2THlWT1ZHcmlISWlB?=
 =?utf-8?B?azU0Vk5ucDllOFNBSVBtTXFsTkdkTjkwSmVtZXNLOEtvTy80VXIvaE4yREp6?=
 =?utf-8?B?OXZkdit0SlZKZ0FJcGFkS05wTnFSREdVRUtKeTJna1FGVGpTUmxLRE1hNmVB?=
 =?utf-8?B?N3E3d3JqQ0Y0Q1pYWkNSTVpOWjBuMy9jemVxbXB1SktSQ2F4eEZVeTF0ZzB4?=
 =?utf-8?B?RGhzVi81dTBFeGFaTVg3azhuZTlHOEEvQmpJODAweGphZWsvWnNkQU91ekJR?=
 =?utf-8?B?SWVWR3FGV204ZnZNaHlDaUMwckk3R2VZWHVpeG5EM2NtNTg2cHM5QVdQYVln?=
 =?utf-8?B?NlVOSk9BaEhIbUpDMGNuMDl5bGZHY04rWU5wTDZEOEE1bVNGcHJGcmpvWG5k?=
 =?utf-8?B?c2EwZDBveFBDaFBWQ1BlNTBJVnJTcEgyYzNHbEhRTExlbDVRV3BWVHQ0N0pW?=
 =?utf-8?B?YWhoLzYwQmVaRjZZcXUxbURLRWg2b28zeHlrOFpKb3V5T0UzVXk4TVBjREt1?=
 =?utf-8?B?YlZ4N3Y4RDFiWUJzcW04UkhLN2J0WWp4QmtuaTV2K1ZvSjZFTkttWGp5MkJ1?=
 =?utf-8?B?R2k4N1R5aC9uMkJ4MnFaM1pucnJOMDJOVk54Qisyb2JiR2NFdmVTVWtHY3VU?=
 =?utf-8?B?TTFVaFJycWkxTlRodFZsbGZXeC9hYVh6bU5KQ2x2N1ZkYkdORnFCdUJKVUtH?=
 =?utf-8?B?Sk5KWUlaZklVRmRhd2tTam16RWlZZlVQMjJzZjhUM1FRRGxLNWswTm5GanpL?=
 =?utf-8?B?SStGVXJzZ2QvMWYwbmFIOFNtQUwxQ0lsME1Dczd5aklwaFFERnp3dGpoYmdk?=
 =?utf-8?B?N2RTWTBEL0Ztb0JnOFBxYU92c3BKRVh3Q0RtaWNoenI1cThHMjN1SFhJcStB?=
 =?utf-8?B?QnQ4S1NuNjlBK2VyeUQyTCtmMFpiVmxoenBKMWtMOEUzS0NvdzA5UDhXSFZD?=
 =?utf-8?B?VUQvV3ZNMi8vZm4rOWgxeGQ1QWhJWCtSOEpXK2Y2bjVqdVNCdkZMM2lTQWww?=
 =?utf-8?B?V0RBaE5MQ2w3TTF5TnZ5cVROVGs2aUpKbFA4ZWtST3F6dDJrRE00VnFKbHZN?=
 =?utf-8?B?MzhaYlJEcHhwOWpnT2ZOWGZSTG9RdnZ1NklJQ1R0TXQrTmdLQzFmL2hyTzFk?=
 =?utf-8?B?dHBGS0ZtMHVJSEpDRU9XNGkzWm81eFdtQ241VG5nQTc1NGNsbmNZMzFDcG5i?=
 =?utf-8?B?KzZkcUFQZFBiekNBRjNhRXROZ2tHczFjdXBKUmxHR3VLWDRPSXhZc0g5eG9V?=
 =?utf-8?B?OVNyWlY1OWFhYWowT2hNc1dVQWg0N0tKOVVEa1pESmpKd1FOTDEzTUNSdERT?=
 =?utf-8?B?VnlRbnVNYmFsYnc5aHJZQ0RPNWNyWGRSMVRzUkxtOCs5QTFkbU55bENpbmFP?=
 =?utf-8?B?cUhEYlRxYk1GQit1ZXRtZXVPWEgzUWpnSEh1OWJ3V29qTmFKZlRBd0lqNWF5?=
 =?utf-8?B?SU1Zb29NTzdaM1dCZ0l3Mk5PQnQvY3YyclZubTRyVzVNb1IzRFBEWmgwZkJG?=
 =?utf-8?B?aDM4TG1ud0RIQVhUdFdNbTJJN1ZHRVNKTS90dkZFYXpqb1FpUURtQ0NTNHJk?=
 =?utf-8?B?a0k4clhmeFVWdkRweXgyejBOeEFFcmRXM2IyblhEV3VnSVNyaTJIY3k3a1R1?=
 =?utf-8?B?ZzQ3bVhhWkx3UVB6ZVg3MmRZTWlXQjVKYWtaTitOTzdPeldxQmNqSms3b2F5?=
 =?utf-8?Q?prJri7uvoYfOy5LUt/yeLIFMq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WRd1MlKqHSlCHQNFLdhPhwoNZVqQhyB80Kkq2bHznZ5cQ8vcK3BzlQpu08Gw6AvD+IRJuXc2ATPfOL3PnQRA7q2il4glBrOcaPWjYJApkg7CPfbNZozSkGTGIGQWtL61mXEHcYUk3pEYyoLkuFmLUw6Ddnzjh1Vh/Bsj6kYGKer2aWmT+DSiYIaVzbkYwjhpYRvgo/+ZDh2x33u3pttj9MQlZuXUjEqBFSZWIyh49LSAQsrMaxMzdV6YOisHGiMcPaOHXSXNFc52lzfiJaihnpJ9itUzu5iJ3d/9wZZ6Dc5uXt1jeHMowfFMUfoQqNM0ACP8shi4w2jPegLuqEOLrokqytY8++eW5dWC8/11N1jwsyRMhS2hQ2EdD+6RKv6gpkMidLKDvlKVPZlTCFrpLFNuAQRR3WqYaBwjXht/pk6VlPv9Si6wTRFEogM7kzVORHZXFdysYbeA/xlOiTfjGvm2KVFP820iuiBhiLXtbDC8KUS0N64bOdW8oUBhf/rqQF6hpXXeUFX+E7G3M0lcz4lkXkSZpkXlAFBOzI0e3RXcw12EJphrOmnA8tFGgs6+48yO2CyM3YVtDImBQocGiAaLbHpXxAAgcRuz3jQwemU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811120e7-df04-4d08-c22f-08dc2d89daef
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:22:08.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2ah7QRWRarfg8JotZwhoKXtWF3Rwy90ViN9jexY2ITGURdp/Prm+1Q6yM7jJtQf1JEH3RWNcDXuBbAnR3Hs4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140143
X-Proofpoint-GUID: Xf8BWkgEDLbwjaCXUJppn0JKWwvOtmHk
X-Proofpoint-ORIG-GUID: Xf8BWkgEDLbwjaCXUJppn0JKWwvOtmHk


On 2/14/24 10:14 AM, Chuck Lever wrote:
> On Wed, Feb 14, 2024 at 10:10:50AM -0800, dai.ngo@oracle.com wrote:
>> On 2/14/24 6:50 AM, Chuck Lever wrote:
>>> On Tue, Feb 13, 2024 at 09:47:27AM -0800, Dai Ngo wrote:
>>>> If the GETATTR request on a file that has write delegation in effect
>>>> and the request attributes include the change info and size attribute
>>>> then the request is handled as below:
>>>>
>>>> Server sends CB_GETATTR to client to get the latest change info and file
>>>> size. If these values are the same as the server's cached values then
>>>> the GETATTR proceeds as normal.
>>>>
>>>> If either the change info or file size is different from the server's
>>>> cached values, or the file was already marked as modified, then:
>>>>
>>>>       . update time_modify and time_metadata into file's metadata
>>>>         with current time
>>>>
>>>>       . encode GETATTR as normal except the file size is encoded with
>>>>         the value returned from CB_GETATTR
>>>>
>>>>       . mark the file as modified
>>>>
>>>> The CB_GETATTR is given 30ms to complte. If the CB_GETATTR fails for
>>>> any reasons, the delegation is recalled and NFS4ERR_DELAY is returned
>>>> for the GETATTR from the second client.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4state.c | 119 ++++++++++++++++++++++++++++++++++++++++----
>>>>    fs/nfsd/nfs4xdr.c   |  10 +++-
>>>>    fs/nfsd/nfsd.h      |   1 +
>>>>    fs/nfsd/state.h     |  10 +++-
>>>>    4 files changed, 127 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index d9260e77ef2d..87987515e03d 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
>>>>    static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>>>    static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>>> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>>>>    static struct workqueue_struct *laundry_wq;
>>>> @@ -1189,6 +1190,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>>>>    	dp->dl_recalled = false;
>>>>    	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>>>>    		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
>>>> +	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
>>>> +			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
>>>> +	dp->dl_cb_fattr.ncf_file_modified = false;
>>>> +	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
>>>>    	get_nfs4_file(fp);
>>>>    	dp->dl_stid.sc_file = fp;
>>>>    	return dp;
>>>> @@ -3044,11 +3049,59 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>>>>    	spin_unlock(&nn->client_lock);
>>>>    }
>>>> +static int
>>>> +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
>>>> +{
>>>> +	struct nfs4_cb_fattr *ncf =
>>>> +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>>>> +
>>>> +	ncf->ncf_cb_status = task->tk_status;
>>>> +	switch (task->tk_status) {
>>>> +	case -NFS4ERR_DELAY:
>>>> +		rpc_delay(task, 2 * HZ);
>>>> +		return 0;
>>>> +	default:
>>>> +		return 1;
>>>> +	}
>>>> +}
>>>> +
>>>> +static void
>>>> +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
>>>> +{
>>>> +	struct nfs4_cb_fattr *ncf =
>>>> +			container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>>>> +	struct nfs4_delegation *dp =
>>>> +			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
>>>> +
>>>> +	nfs4_put_stid(&dp->dl_stid);
>>>> +	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
>>>> +	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
>>>> +}
>>>> +
>>> What happens if the client responds after the GETATTR timer elapses?
>>> Can nfsd4_cb_getattr_release over-write memory that is now being
>>> used for something else?
>> The refcount added in nfs4_cb_getattr keeps the delegation state valid
>> until it's released here by nfs4_put_stid.
> If the client never replies, does that pin the stateid?

Won't RPC timeout on waiting for reply?
This is the same behavior as when recalling a delegation,
nfsd_break_deleg_cb and nfsd4_cb_recall_release.

-Dai

>
>

