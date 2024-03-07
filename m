Return-Path: <linux-nfs+bounces-2236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF878755E9
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 19:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6B1C213BE
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63DF130E59;
	Thu,  7 Mar 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f2D+T+20";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YWudDUTA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CC21A14
	for <linux-nfs@vger.kernel.org>; Thu,  7 Mar 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835286; cv=fail; b=tOaaqxNQ0U7+o28Og+nsu7UBvbnBWGbosIBAT7BTIv/Uuar86EkNvK8g1UM3APNJvVqqoWM1gj6s1GaKZ47An28ngBGbyeJfeF2wIk6fgt83+MiQKvRNzEntiw8BuxpzEgH07Ewsqs1RnT9ExrXYhGE4oMisr6jZQo4PJ2Hvl3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835286; c=relaxed/simple;
	bh=Uev2uF0TRwDk6i9H2j20qDdlqRqgA4wFh51sE66sGlU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f3NnP/Dg6jnWCciAi8kNRNrnKsjFJCsmDeo2W63cFMVRD88eDTY3fnnzb2dpuDMmH7eM5Y7HxOoZFMbaAfGp6wsj1M1qOifigXcCloAIGgMFA1dor8265+H6RN6YyZeYlhyL594JjowqkvRddiL12o4w42rQe4OFKIX2agMD+Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f2D+T+20; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YWudDUTA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427HQVJT002587;
	Thu, 7 Mar 2024 18:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZTGK3NqYrbHFKTYF43M3ORnttXhufMdPkTgqgk69R+w=;
 b=f2D+T+20Qd7KRZhFTUfmpDH6tJ2ipworv+TG5x7VG+b/ZCMZL2M1WlJG3tj5Y8w0SRjz
 TWPsRtE7OicHMIc/rUB9/wCA1XLlzRHz3XE5ZlvwKtYVSen9I0GyYsOMxSTmy+whtmWt
 TGMuMaCbB2LygAsUzdmcWf7bDzGwZqI/yXcJXhEChNuacS0hcvSbzymweAzx10M8+3ZZ
 q7c7QD3CMX1jOx39cbSyxXdrBxhIfVQzG9Ki56nRBhdcBTNzcexSAdVI96Qc0wo7zeZ9
 dj8MYdCCfSpoGY6eeFXCIVGNIbTatEGIgPAts5BjwK5tH0qyO6tZPLSCNY0VtkdVogHA 7Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnv44c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 18:14:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427GwL5J005194;
	Thu, 7 Mar 2024 18:14:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7nu67wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 18:14:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYVoaeqtuHjwDIbZkQhQQVRA1kLmWbqVthM5FR54GLZKO5V6L/99EoxFUf1uj77srTa0GE0eoJ6RR/FMERJKEhOTTnYgjr+y4+cK96ZPPfzfvMo3s/pOkee83D+EzQfEtvEXECnObwkwAWpjf1fIJX14LN3sIOF0Gl+AmT8xUzVNjmwf/gQPL0pGx27Bp931jZfbWaglSjOnaA09MUHtBDFNB40mN+FBawRFRA7ov6eCmy57aBapXE/fCWBi65QkAk+cvPV6KDSL0vTulnRvAv9MMJga0feA7cULfOv60yyi1RMmHTR+LLSHTqR4l5mdoGwhkRrmBEEiPJCMXUC1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTGK3NqYrbHFKTYF43M3ORnttXhufMdPkTgqgk69R+w=;
 b=U/uVd2oNiS6S/OvQh6PsTfxI2RuTZt3Azzdbl7HsE5lTlgabUayYx3wMtnO/sYjrQuxWiqAulGBhtbQ4IOJV4Oc3sb7pwJLxy2BVyQ+TBPeyXk1RAWkGg0m/a7VYYPB8liaNv5sZWv/IbpLlNhJ2ll4Vw4ik+2vbvNV/Z5iaF1uUO32EKVrgzdDIyRCYtVxuC33/jYPbirsSPcNyIcSN4UgXcB0LFv2oAVxEIZV2HElBbXb/SuIi26ZqVVkz0JlgJeL9PoJDoMZsZ4d8jfRw4hy+Vf9qUxa9p4nm4t7RLuQYBfSG9MQpyuSycm76LUqQtoRNjTghjCk4THCCImNOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTGK3NqYrbHFKTYF43M3ORnttXhufMdPkTgqgk69R+w=;
 b=YWudDUTAg9MNKp+g2oStqjCAiJOd223pAHrLu4rUXyBQdU0KdWkvpv5Eo487jmqibYjGTvEWrfCBBTDUQmm/d35Qgk/0gkeuSZ6SKxGnf4ccNYglDKGDqUpBBx42fYhbMDyHFMKcAjjkRbz4JH5Kwvk05B3GJizaY5ZNDVga4Ms=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB5872.namprd10.prod.outlook.com (2603:10b6:510:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 18:14:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 18:14:40 +0000
Message-ID: <5772a8a3-57d2-4885-a61c-fb1db252b2a9@oracle.com>
Date: Thu, 7 Mar 2024 10:14:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number
 of delegations reaches its limit
Content-Language: en-US
To: Cedric Blancher <cedric.blancher@gmail.com>, linux-nfs@vger.kernel.org
References: <1709504582-8311-1-git-send-email-dai.ngo@oracle.com>
 <CALXu0UeJ-s4hOmjOa=SndBx15a1VmEXmGcdhhbouMrSPTMni9A@mail.gmail.com>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <CALXu0UeJ-s4hOmjOa=SndBx15a1VmEXmGcdhhbouMrSPTMni9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH0PR10MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4441ea-f581-4bf6-b38c-08dc3ed27463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YPcDlVzvmcsCriB9UJIR6sAm9mnegCOLyGgqrJ4edjkxsiIXyUvTnYp0WkoRX1UMHUvAmC6ACwyv4h1Q+Adr2LHn6va+NpfPHbJgv8xz4x6sagKsY+WLqsaWXO5zYKxlOaCYXle6Q4dfx5lNxmZGWA2t6BZa5laEcU4tYSCU4+FR07k1kiX27ivJF8YvzKlBLTW+P5dT1vUNi16kljQlragHCQ5mYUqoBHPPBLQmxpxd8XmKZR5KBF/sba+J3pJGsVdJLIJGwlUZzp9n6rCU8So2OEHnx/AnFla+Awm15amsR9P+AQEDyL/ZjHH5jfmugbTqp7AT/Z33aIKLOEans9IHSfHzu0Ka1SLEwNPVc5HyyiWWXj5AytXC8gbJJ41AM8ON205Qg1+jtYqke6IrwNgftTfE8fItnjOLf5WivW8L5p7e8JkZk7fIuJIgbo/P6M82AXHPNr8amv13YLW/nZKBI0mr7vbILvAQRJcA034MOsI8406u1ajFWlEEii1S1NSGEWzJxtKtb7NLSE/ob59V32w2u42928W/GNgORC1+POGMaBx6Fm5OTNa0EqmZyClhCzyaLGMhs4Kn0FEUNZ89GIgvl6SEM89LLvVPLtAKaQfBwfmzvF7mpvIB4bu9OZ01G2wigOEsquByVFO6pt6pD5PubeuF/5SAewQ4ozQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDlINWZFNGdNbzNQc2M3dUN6MlJZZHVnSXByUVNqclgzZmpramZDRVk3SEZB?=
 =?utf-8?B?S2RFQzhpSVhWd29GOW9ieWZ6UTBjRGtmUkdxTzBJdGhvTHQ1eHJ1Z3IzL09x?=
 =?utf-8?B?aFJRUWNwZU1qTENvdmc0Q1VVSVFFWi9XWUVqRGRLTlRRQUNKdTV5bTVXMnAw?=
 =?utf-8?B?ODBkS0UyMDJBQmhYMndCZlk5YWxQTzFYWG9MR3V6b09ZNmZ6U3BwRGZwMTZU?=
 =?utf-8?B?MWgyekxhVGhwTVk4cTlyN2tsNTJTbmh4Uzh3MitqMXJwekpvU29KZElTbTVy?=
 =?utf-8?B?ZG9rQzFzSnJnM3JBOVJvQ1pCbTZYeVd3YU51KzMwUC8wanpObXdlWFk4UFBH?=
 =?utf-8?B?Mm1QeEczTi95dnF1SlpXNy9ZVU56UlU1QU84M0Jxc05OVG9ibHlwZFJ2Mzlt?=
 =?utf-8?B?R0JLeTNFMnRLbmh2NWlEM1E1SDJ4QUkzUFZpNVRjaEFtY1RoUFNvR3hxSEx5?=
 =?utf-8?B?L2RBZ1VQM09FbzZBckt5c2hOV050akVFOTI5QVgrR3R6cUs4VHd1Ykg0S0ps?=
 =?utf-8?B?bGh4U0E1R2lHbU9CRWIzRExmbUdRSERBUGVQd3BwVjNseTMvSTNXM3RxOUNt?=
 =?utf-8?B?Qng0d2kwQU5tbTUwOFNiZEc2TTgvMGswL2REL3ZETDd2eUcyM2JUUGF0SnVv?=
 =?utf-8?B?VldYcFFWMlVMVUt4NUtFemZjY0Rjc25USkZNQ3hEck5XSjE5aDUwZzBoUStQ?=
 =?utf-8?B?MmVOeUszVllZem5qc0ZDLzhjTzA2MTVwU3lmNWxoelIrT2lBWEw3ODhLU0Nj?=
 =?utf-8?B?ckZzUjEzTi8vTFlKeFVoUWRGMCtRZU44T3Bib0JPNW5jWWNmbTZyVjlIWDFG?=
 =?utf-8?B?QkdrWDdIUktPczdkcE5ERHpNY2VvdG50RG1kSi90RmsxZTlWRndzNkRySnVl?=
 =?utf-8?B?TnY4Z2h5eGtWUVR2MkNnS0c4MDZXS3k1enIxVVlSVzBVaitkbHp4eHNUVkhm?=
 =?utf-8?B?M3BOaXVJampjSVdlQVFjQXBMdlQwbld1Mkk1dFVuOFdkOGpJRG5sRERsWjJk?=
 =?utf-8?B?YUtVejNYbjk2MVdsbW9MZ0JDaW5PQWc1R3l3ZXlyTTJtdm1GVElxck5VWjdI?=
 =?utf-8?B?OUh1TmdlQ21iVGlTS3FKdHc5bE9idXlKVE1mQWxjWVVuWXcyOTFocko0RHhQ?=
 =?utf-8?B?OXlDRzl5eklacHdzaW03TEF5Zk5uWVdtVXlzSTRUcjFsZXRqRGxPYWFHUjJX?=
 =?utf-8?B?SVVHUlQyOUoybUZKaUZSNitoOFZxYzJEVkhmb3dWY0c3K2hGRmFJUUVRTXYz?=
 =?utf-8?B?ckcrS0FLTTA5VEp5aDFKS3N1U3ptK1FPcGV0V0EyT0ZibVk2RGE0V0NCUUpj?=
 =?utf-8?B?b2JqQVFXQm0zQ0NMdEVpb0U4Zkp0MGFJY0IvL2VHN3VBcGE0SnpwUHpTcXo1?=
 =?utf-8?B?VEdJV3hFbC9KQklUdGIvWkY0Ungwa0JVaEVlRDFIeTBrWjYxY0tHc1hZM290?=
 =?utf-8?B?Yi81TUxsaEZ5WlFZVWpXQi9SUkI2SFJnN3RlUHkwSDl5akJRY0l2S1NyczdV?=
 =?utf-8?B?Qk9DV2cvUEpTREVvcUVFS01ia3pRQXNpWFpGWEhLSUhoNlhRd2Nwd0dpYjdG?=
 =?utf-8?B?dWkwS0tuU3grK05BQzNuaXBYazVaTXhVZ3grbXdGM2wwTjR1cVBUWnRIQm5Y?=
 =?utf-8?B?REpud0ZndUtRb3RzK1docFFDMzJudkMzaFViWEk3KzdLU3lOekU5aEJsdml3?=
 =?utf-8?B?ZDg5dUc3My9KRnZPcSs1SlFZdDNKVGhDajY4QWc1VlU2Kzl5WTV1K25UeFY5?=
 =?utf-8?B?UWx3bmVsSEoxZWtpbDlLcGtJdmVFUElpRlJJUklHNDdPMTdFVlBXYjJXaTVC?=
 =?utf-8?B?UHpLcHJvZXBCd281Q2VTNFBGN2IwMEx4MDZPRkgyc3JEOVdRVnhnb1VhSjcr?=
 =?utf-8?B?SU5ZVk1IZ2wydVFEb3Y1Qm1OTk80RVNmbFk5ZjJQdEhwakIwMmJrNGx4NEhj?=
 =?utf-8?B?dTFiY3FtODlEU0Q5c1VydnE0Tm92UGowS0V2bFBwK0loMi92NU5yZ1ZDK2ZI?=
 =?utf-8?B?eFdUUjBxRHJ0NHdDRjk3K0kvckF2S1h5WS8rMG83SlNBcU1VRm1DU0dobFVZ?=
 =?utf-8?B?K2UrTm9VMm5Oa0Mzc0tua29UMWUwaUZRdXBZU05rQytBcHczZUlSVmNxN0Nr?=
 =?utf-8?Q?WWAtzhYQrDqhoA3HoAGbdZvgk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7nJplbN6U6/WXYzv13KNU+bexDykCAPXttHO3WJY6jNevYKiSyYhZDUW1EM5oMBAIIPOjgkoRrrWllf2Psy9scy77p4QSdnnYDoStiZSs8IzfyJEjn0BFUT4amWstAj0qnZt7wKQkEStN3CsfyWXVmtP8FIjqVxMEA/DqOc6L1AjOQfyIqkdpv8AyxgIhc9TwkOGEidMmBdI5UPYX0NLpQ533YB0u0k4NcpESea66VIJF8fesHXHjBLXaq3sUBx/xkbBMiBL2Kyt0bs3kXyhVdwyJK5EhiBfG6AG7amxTXB4FgowhoRdEjh8yKZff1o0oIfvlthKqe4yxvsuqWsay5WNtOhS7ZxzOG47GSeyaItdEEdu2w5js41QewqgNOI7kGgmIvQPtpJRxkqu4+7Dh9RLcdemy0WVShKVCeP0KpnppUhU2s1tOgYYetCYwmrIpigdatwDWje2JbEtVK1NbLYaJdpOJX5iamfU8f85O3eaLxBYBpwZdgK2MaPlJhI5/KuDAJc+xWSIeCtqH/8D2KNli6V/2gnF+W6eaxw0c8FG5+vH6XHIJiHZRScWVpICjFyVQu53GzMQXJQlJxqS+BtYY2BybiXt/fNYSF0gutM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4441ea-f581-4bf6-b38c-08dc3ed27463
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 18:14:39.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nrrThjt0GTynzoJtLu52eicyoJlpC2J5Ng4f1i3L7UUVhpgjYZ8SGUaHcuAf1NSfU+0h1xNq4XUAMctAjB/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070126
X-Proofpoint-ORIG-GUID: fvxFnKiSjd1P1eNTgiDPIme6tMICsm9X
X-Proofpoint-GUID: fvxFnKiSjd1P1eNTgiDPIme6tMICsm9X


On 3/5/24 12:49 AM, Cedric Blancher wrote:
> On Sun, 3 Mar 2024 at 23:23, Dai Ngo <dai.ngo@oracle.com> wrote:
>> The NFS server should ask clients to voluntarily return unused
>> delegations when the number of granted delegations reaches the
>> max_delegations. This is so that the server can continue to
>> grant delegations for new requests.
> What is this limit max_delegations?

4 delegations per megabyte of available RAM.

>   Where is it set,

when nfsd starts up.

>   and where can an
> admin alter it at runtime?

There is no admin tool to change this setting. But if you want to
play with it then you can poke the memory and change its value,
The code uses max_delegations dynamically.

-Dai

>
> Are you aware that for example the msnfs41client Windows NFSv4.1
> driver easily uses a few hundred delegations, as required by the
> highly multithreaded nature (i.e. every Win32 syscall is async) of the
> Windows kernel?
>
> Ced

