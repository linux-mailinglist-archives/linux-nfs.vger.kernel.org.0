Return-Path: <linux-nfs+bounces-2052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BC585FFFB
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 18:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6521C228B6
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E39156964;
	Thu, 22 Feb 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QMkPUUua";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ro2h2nwE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D315531B
	for <linux-nfs@vger.kernel.org>; Thu, 22 Feb 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623934; cv=fail; b=bqZonZtDx19l3UFhgyWdHK8xnmP9lU0BmN4hHwG5FHl0xOGzTKf9qXzm8bt73WUqJ+tD5h2o2zm78QlmfK8+SmcdhJOz1lAUH5DKP8ttDJr5F5yHXJCqrht7HRSFxFo0Sg39PDqH/ysixusoSHdbOOyois6biPuEnsogFeldwX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623934; c=relaxed/simple;
	bh=hpWaYjmrLyDJd8tCejRxDYyfiKgZv6lBRcjlirQgunw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MjRHVtVZt3Wc3TW3NA35TgCOLi9kT7Zsu2UQjmOBWXeFZ+PCwI0ttkPFWEqJqAZl9n90ri41sp1ACnMlSqH1RqeWnbILZLZUoxzMc9tKakRscaxqvxrwghx5q67AyTzabyrO8XJbYxBTQZ7t/TsayY2QwtoL3e4OXBgDe9fELtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QMkPUUua; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ro2h2nwE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MH90WT025984;
	Thu, 22 Feb 2024 17:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IoLDClYj/Bx8jvjZjtO1OaE2Z0G9REQRcIPMgzL7YNw=;
 b=QMkPUUuadpHoxJ9iKNFbKKzDXJOPw+6nVMyAGXXPWPp79RKyYEIU3B/DLQB9j0zcjT5l
 FZsKxXD95gjZX6lIoPqmq10aU6An7aDGdoACV5brYEpHSzBDLMMkZpjl01pG6I6RtVTZ
 szMpMFkYdB59DxdjE84dUY6BszBs3++RmP0DFhXEIlozgcwoJEIiKT9aV4D7e/YC1Lgo
 jySo3thhhXTe0AmfvPBQqxH6BvAdk5BcRx5C6QuPWBNv97NKsJieIbbeV6fHnrwgbt+B
 VCCN3b958aytvtlw41O2F2LjbbSyqdQrq/czUzGFkujTIAnOebURjvfILMVWF2ixhHWg sA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk45ea9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 17:45:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MHQjmc037713;
	Thu, 22 Feb 2024 17:45:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8b05a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 17:45:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THNMJz2C6wRSNU9G+tGqNMwcNkU0m4JYF7h+ILxREnDnA6MOSzL1E7NtKJ9W9mGuABW5Wd+XBLs2sDps2yknx+VNyNbLE0CRGIS4MJyi/5xvQ2fO5zjOwSEwKGVmZHh3x3jiuwhAOJweYMLfVSsAh6jXMKS9+mvP0NS1N3zr7Rozr9ED8aeHDlqxuWY8oRT2dnrpp2XXMIB37O5DRW1RS/gNh7A+4efEy60pcYuvYhoeutoZqe6REeTCtTPScN9X1pcsNooe/dMVwhrc5LlCNXnJ3rr+qGgo5bW7/KHzlgbcit9XvtI0MsmDJ7tkkX0Sjl/sJllCE/3Q40vZ0rXtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoLDClYj/Bx8jvjZjtO1OaE2Z0G9REQRcIPMgzL7YNw=;
 b=F5Dx8IjRch9d2jQCMQcSYZSxbCs+8F721GhogMFOPakgUce+V7kjc5Spzy88nVNOYQtDxLdG1+7e1KTfKg9J3B2uGlxvyN6IR1eIhHrd5qKV8t16iHpImuey0Bg2nJ8aJhgwBhGe5tYBD96i7nDxgcIbFtCZa6aRajfdge5UZUvU6L+zQtAqUt24TfgZ9j0cJwQhvdyOlDgm383OiuBN5h2UFGI65l3niFsQYsdcHGOw3FSBczECu9DqWJXaNMYxyY+QcnlhJucXsITSFJDlWl9Gm+FH6d0C+rzu9H/BOBMdlz5sJx/PoKiY+XYbVHyh3XMUOhDU/vzhCsPBB3nPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoLDClYj/Bx8jvjZjtO1OaE2Z0G9REQRcIPMgzL7YNw=;
 b=Ro2h2nwEBmOmU3tlPk7Sr6djV286Fy7OFkMxHaaHt1QQTDsbYop6PqVk4P41D0ztv2aKaE1gOs6T/x0ji+Z2Di/IyirvYQt06s7qkfNPSBebBlPiBHacWqXEkKeK6d/iujAvsuPppZ1f7QrgpEva3SIkrJ92eXx9+M2q1Tbn3WU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA0PR10MB7370.namprd10.prod.outlook.com (2603:10b6:208:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Thu, 22 Feb
 2024 17:45:17 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::9a8e:88e2:8d1:d51c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::9a8e:88e2:8d1:d51c%7]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 17:45:17 +0000
Message-ID: <49b734fd-db5f-42bf-8a9e-7eaaef6ee004@oracle.com>
Date: Thu, 22 Feb 2024 09:45:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfstest_posix: add check for EINVAL when open(2)
 called with O_DIRECTORY|O_CREAT
Content-Language: en-US
To: "Mora, Jorge" <Jorge.Mora@netapp.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>
References: <1705514501-2098-1-git-send-email-dai.ngo@oracle.com>
 <60d031c8-fd34-4093-9ffd-0e661de306df@oracle.com>
 <CO1PR06MB80415138C46D80C7E1E313EDE1562@CO1PR06MB8041.namprd06.prod.outlook.com>
From: dai.ngo@oracle.com
In-Reply-To: <CO1PR06MB80415138C46D80C7E1E313EDE1562@CO1PR06MB8041.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA0PR10MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc6bbaf-3f09-4f98-cf0e-08dc33ce0839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3ipMx6z/LNpycHZ2lVzfVmprZO4NG7G6cGv2kVCpHN8nAgWh47RfCnjBon7reuDFRoVy/zYUttd7O4LaRkDghBbAnKCJehfyQApAkc/Qiw8/xFE6Oss6yUdBdDrTyoUJ4VIS5sgBTiR1h6K2qc+SroUdVQL3EE7B5S13cmHtCEcV+aOn7nhvPlY5fXnh5qCHGS3aVH9RebijSXMeOW7JLB3myr3MUxr7KLyswkNXXPAWPRIT24mVAlj9y90ptBxXMxGR/8PKaSwMHAQ/oW2ahpomilb94AvKnMQQNhkX8GR3EJ2l/VmFEYmEq1PtS6rHVR1PqqYczh0iBvlkRFoVUHYhSz/3G48fmLg+kyIJ3rTem23Xn8AjOZ5fHzvYFqmiAO4DGaXjT0lRdBW86S/NPc05t8tE/413AqsyZ4fJzcrUJJ/s3iUOiddt8wy1mMYgLnaXSRVnEUsWATWdrgcW+Ws/3qgn9bVHFbfp8O+7H9S55ucCOn3zMgCBAcyfx2vskHyTxltaCChePQZK1geYSr0zt/SnqNtHQkDPcrln1liJcNylQWaI7CSOHopiRh5T
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFVWMTBjQmlNMTg2b0R3VTEvai9GK0JCVC8wbi8yT0QxWHVSVEZlUUNIQkE1?=
 =?utf-8?B?M3Irb2dNNGVoejZ1QUY2MHBxbyt6cENhTDIrOFpkMDFreHJscHp1U0J5Q0tU?=
 =?utf-8?B?Z2g1SWhwek1WTWNYR2x2bHpITEU0L3BHSVMzM3ZMajlVQ0xZWmYvRHZTbmZT?=
 =?utf-8?B?UllSZk1oME1SQ2R3enQxU256Nm96YWZhT2NmZGgxaVN3SFZvUHdzMDdDMjF2?=
 =?utf-8?B?MkRWU1JUNjhYUHloeWx5ZUMxeFNFWmV3SGxQUllkc3BSWFdNbDNYenZ4VklP?=
 =?utf-8?B?OHB2alN1TWNXL0RJUVhtb1NKZFdqVmRrazNwbHdJaGN5clB0UFBCZmlZTHc2?=
 =?utf-8?B?SG1KMXRzWjh2S0RsMnU4RStCMUZtWk8razViTWppeDJTSzVWZmx4ejh2MWIw?=
 =?utf-8?B?WG1jWWZvR1hNNWFKK1FnZEZqbWVPN0pmSGYxQlVaRFNBQUNkTmlEdkFWelJM?=
 =?utf-8?B?R1NUa0c0RGxORElxSTN4SFRoZmkzaHVTTVVFZCt0TVpCZXUyZGxMRVZCMGpi?=
 =?utf-8?B?VHl6cGNqY2dtcXVKakFJWUwvSDNSQytqVjA1VkFDSC9DaCt1eHN3N3NiRDFI?=
 =?utf-8?B?Sk5kWTBGektLNEJWWTlLOWJKbWVMWXU2ZUpXNk4zekdITE9GM1hsQnFTalk3?=
 =?utf-8?B?bW4yOUppckhJTytrWDhTREFEY0JoOU1VbmlXd0pKVFV4TGlhdnA5VVFIcHFR?=
 =?utf-8?B?M3V2ZFAyTEZwNjE4blBYWDU5WEVMaE5BNTk3bUowdzl6Tk9kMXpRbVNpOE5q?=
 =?utf-8?B?bURWVTJYZWl3cUxHT0tBTmZUOVhIS3V5UkU3QS9Zb1ZXTTVSTVNtVWFYY1ov?=
 =?utf-8?B?K0diL05aQjJWcmVNeWZjSGRsUUpXWVM1WVlPUFc3SWVZcEo4WHBSS3FSZFVn?=
 =?utf-8?B?dFhhS0d5czNpdTJEaGNrYlBwMkhnK1VVTTNybGQvNlFxait1VThhS3h2REUr?=
 =?utf-8?B?TnRpVUoyazdJWUVpMnRhVGZEU2tIejRGM1FNVVpiV3JzakFXaEkvUjl3U1ZM?=
 =?utf-8?B?NDBuUHRaTDltR3FiVk9kN25jQ2dnTkZUTEZtRTlFUXZyTEYwR25xejU2SWlF?=
 =?utf-8?B?YlErR29VOHJkdUQ1SVVkbVh0cHIvV3EzN25MTnh1UnUvV25QcEZPaFFlNTVH?=
 =?utf-8?B?MHRuMEg2YnRtYzM1ekluR0EvN1BuYzNxOWpoQm9VTHRaK3JEV3Roa2dNaEVS?=
 =?utf-8?B?alhYK0g5ZEVHenNYZ0UzOGloc0RmNTJVN3ZWZ0diODY1OVFPVmJCT3VTVnVG?=
 =?utf-8?B?clJRQVBmYkxHV0NZT25OdDl6cloyZEFMZHU4Ly9YWGZUajlKeVJUNVk0ejI1?=
 =?utf-8?B?MlhFaCtmc2NNeWxzaHFEaHZCR1RObk9HUDZqWjIxMGJQdTRvWnlXL1UvSG1o?=
 =?utf-8?B?T09PQUtPQjNDaXdWWUxJTHZGbnQ2YkNuMTQ4aWVnRUNlbzVZTnB1c25HZFho?=
 =?utf-8?B?YTdNczMzanJObm4yTlBidXRnNFdqSnhWaThONENWNWhDUmRGOCtqbUtpNXNG?=
 =?utf-8?B?RmdKbGptckNoeE1xaU9kWk9WY0RSUTk0Z0hucWRMZUpIUGdQdE9CTjVmU3dN?=
 =?utf-8?B?REZEaXA5UFFXZGdFYXhxdG5ZU1ZWZ0dXaUlBdDc0SndRTi9INUtjOG44VGhZ?=
 =?utf-8?B?anh6L3RlSGJpM25EWkJLZFdqR0xnbW4yQjMxV3FkSVkweVdTK2JNZnNvaS9u?=
 =?utf-8?B?c1pJUUZjRDFLekZvdjJBNlFuUENuMzlVSkV0ZG05V2xQeWZ3M3NPZVQ2aCt0?=
 =?utf-8?B?RmxHRGhCS2R5MzhHVTZNcEUwT0VzSk9RS2hDcUlGbjFDOENHNmJGcmxsQ1d5?=
 =?utf-8?B?T1JZWm5sN0ZOSlBUL1ZwSENta2xiWDFpRFkxLzI5Rko3MlU3VXdCWWI1b2dz?=
 =?utf-8?B?UFN0TzNZNEhzTEJJVUd0dFZENU90ejV3U3oxL2ZjUEdKQTA0SGJoZ283aFBJ?=
 =?utf-8?B?eUdUMTcyS2xvYkR4aE5Mb0dUSW9jYzFCMG5MMDRxWkRkdHRwcDhXalRjMTVh?=
 =?utf-8?B?TnpsaWNtSnY1WGdIK3VxZi9nQXBFa0pXME9ET3kxRWxjRGMwQkNmK01Sell4?=
 =?utf-8?B?OGZzZ3NPZTBnWDAraWJ3L09icEZYRHFSQkp3ZmdIcndkYllRZVJvcW9sblRX?=
 =?utf-8?Q?dJEJfxzSTsaDGksv97pdmCDPt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fh42wyyUMqWXnlLs3cKcaI4gToLl9Fk1+bZIP9CNBJW22Hp48AkUY3HAWIyWW11rTA6Ta05DHcn10F2n6HE9WMDLPEaDJTwNwTpYpNF8paZEWXA8TGnn9VxeW7Vcwe3iviPxFsQKVFFkLhYMGD90rtjVN9tl9KhAtcUNBe9JAZZm1xwMjbEW1u3Fx3iINfcMTQ50AdttD61mY7frzHoAQ5BfUT71lZClqHQtlqDx/M8JK+opm+SzrRs4xpeenRJmZNpd1wwgPbsh7iu4X70dXVn1NfvMDKXLoLwtlHzXRkOaHRduzs5uoeAaTuAD1hMLR697fvxAAFOTRe9t1g0sO1U4p/8NHx/bVhF4Krma18WZcUt7jPmZ3SEtQYJk9mxf+XVqc+nQDPs30uty131sEY1slfmlQZ1JzWwQv/6wC20raMkLim7ufIztmEv87404AsvcIFzASrPSK/cFCA8Pw7eCGFAzvJuPHcHLTde+kvqwusBIc6yoVbIjzrPDA+r7P11+KnROMX1nxtR95ZF75VkHqmg+D+D5OPRVWIbxB26xOhadM2ihn32HNPhM43PXGutvB3RdjnH+zEBIawFrJWHnaMg60C6wsMS0/vPJAPA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc6bbaf-3f09-4f98-cf0e-08dc33ce0839
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 17:45:17.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UeFjmeAJUhKk0ROvk+iiAA69W0JgKdwep2Q6nWW2iM0GfQBatKJHw+AGE6vT+OdyLwd7+UCKsH6t+317cR00g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220140
X-Proofpoint-ORIG-GUID: kdt-J0INA0w5briN09rZuvQmYuecUJEK
X-Proofpoint-GUID: kdt-J0INA0w5briN09rZuvQmYuecUJEK

Thank you Jorge!

-Dai

On 2/22/24 8:13 AM, Mora, Jorge wrote:
> Hello Dai,
>
> Looks good, I have pushed it upstream.
>
> Thanks,
>
> --Jorge
>
> ________________________________________
> From: dai.ngo@oracle.com <dai.ngo@oracle.com>
> Sent: Tuesday, February 20, 2024 2:25 PM
> To: Mora, Jorge
> Cc: linux-nfs@vger.kernel.org; brauner@kernel.org
> Subject: Re: [PATCH 1/1] nfstest_posix: add check for EINVAL when open(2) called with O_DIRECTORY|O_CREAT
>
> EXTERNAL EMAIL - USE CAUTION when clicking links or attachments
>
>
>
>
> Hi Jorge,
>
> Have you had a chance to take a look at this patch?
>
> Thanks,
> -Dai
>
> On 1/17/24 10:01 AM, Dai Ngo wrote:
>> The 'open' tests of nfstest_posix failed with 6.7 kernel with these errors:
>>
>> FAIL: open - opening existent file should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
>> FAIL: open - opening symbolic link should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
>>
>> These tests failed due to the commit 43b450632676 that fixes problems
>> with VFS API:
>>
>> 43b450632676: open: return EINVAL for O_DIRECTORY | O_CREAT
>>
>> This patch fixes the problem by adding a check for EINVAL when the
>> open(2) was called with O_DIRECTORY | O_CREAT.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>    test/nfstest_posix | 7 ++++++-
>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/test/nfstest_posix b/test/nfstest_posix
>> index 57db5d69b072..6d5fd0dfffee 100755
>> --- a/test/nfstest_posix
>> +++ b/test/nfstest_posix
>> @@ -1232,7 +1232,12 @@ class PosixTest(TestUtil):
>>                            fstat = posix.fstat(fd)
>>
>>                        if ftype in [EXISTENT, SYMLINK]:
>> -                        if posix.O_EXCL in flags and posix.O_CREAT in flags:
>> +                        if posix.O_CREAT in flags and posix.O_DIRECTORY in flags:
>> +                            # O_CREAT and O_DIRECTORY are set
>> +                            (expr, fmsg) = self._oserror(openerr, errno.EINVAL)
>> +                            msg = "open - opening %s should return EINVAL error when O_CREAT|O_DIRECTORY is used" % fmap[ftype]
>> +                            self.test(expr, msg, subtest=flag_str, failmsg=fmsg)
>> +                        elif posix.O_EXCL in flags and posix.O_CREAT in flags:
>>                                # O_EXCL and O_CREAT are set
>>                                (expr, fmsg) = self._oserror(openerr, errno.EEXIST)
>>                                msg = "open - opening %s should return an error when O_EXCL|O_CREAT is used" % fmap[ftype]

