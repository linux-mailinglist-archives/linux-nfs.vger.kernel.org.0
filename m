Return-Path: <linux-nfs+bounces-2274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A3879944
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 17:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F981C20FBC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F348D7E578;
	Tue, 12 Mar 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gRyD5ELK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FVHHiHUu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36297E567
	for <linux-nfs@vger.kernel.org>; Tue, 12 Mar 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261994; cv=fail; b=EPewKHasn73ru30VZ7IefD0B2l3vMRpHRG0tk3knFZFqG1IFLsSsEm4ZVVYXhFIfjMSTeQf9nqk7KZtDsd0VzFnqrHO8Mp/55ngqJ/4n+HvJnkmg9iHBZZ5SzgDw3/AsTm4vcggZaHsnS2tqmbxSqJ2r5rOGu6ifcPlPpphpcSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261994; c=relaxed/simple;
	bh=ACuOAG60Uu1DXV1D2VMgqwpvaQS5ZsF1Q/sXZEynkX4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+aGIrhZTvoT+0GIbh6zIDDQRPrmQPiM2x4R7Wnj13bFIaXieKza9nFCJkxDj0pOdqMjLM9WR9A3oxdCJHDyDkiKVZZ6hTSG8w7O5Xw9BafN57/G/ztDij1UT2HgDjQ7oQ859jXGm011LvAYzzLZ2qRr+tf/eaE+NC6Agqa9WmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gRyD5ELK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FVHHiHUu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CE6VO5006854;
	Tue, 12 Mar 2024 16:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WCQjQorcCoOmwEPKn2rrnSGVUDSVvu8HVJo7yPC93Qc=;
 b=gRyD5ELKPjc9VocKJ9duGJjVfTnY8Xt8ds0e8SNxIKh9P5nLjpP6ZMNa8ymiUp5yXwpQ
 bW8AWJvGFjbb/WfmfRguKARireZzeuuDkuODgcIt79PjDuimOrt5J53eZxxEs39jf69a
 pwoJ+UHO/gq/nuY+UooXpC0KlqusBIZ3LP6nIsJswKMoj+qfJv7ob6pYuZnVC8wHALS/
 8CXkPgBaJ3fY5Gqxmph5Gjh7bDZTF4G8sxSPLzv7Tf+pi0V1F+x/AWDVhianxIZQLZ8T
 H5xf7FoE5NIWCmLk/R3kNTJEgVQjdWgJxKsL0yNgrPAkDfXgQpnDTsstyoPdaETeK+bo Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrec2eg26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 16:44:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42CFdWFj037417;
	Tue, 12 Mar 2024 16:44:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre77gnu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 16:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfuqXV8dxMgZThmPHsbV/QoB8uCrmCC37dnwe2JGMEjQDJoP5qyfEvcmqkAln4gkFhKrNqtsMWX//+el0Mw05Hij6mTXtWmw39JdOxsu0QxFkA74+RAZXsuTSH4yCzyXs3diRpc4cuFzvzzcxEwvAjoKU4ONNlqzJgFZN5ju1vnMs4WLZQCZu1eO6I/Q5BHVXMx8eobHvkbjAphsm9HAbBaIEZkNDtqAv5A1pYnBLvsTN4xtRWZ6xgb2d8tKj67JM6Xs+a/pFA24jltYsOTQKrCQMPpe7vrtEnQP4ajaWr/Fq3xI+1gKsPT8EAar/ZeBzUYAQCAtmw9G03tdRCbWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCQjQorcCoOmwEPKn2rrnSGVUDSVvu8HVJo7yPC93Qc=;
 b=PUxWl1P3nZ/FTsSOiVmlIPMWP3EYPgLavfTddaKZXTBYNVoQdlxTQM+173k8qqt1lcdKos6qLjor6pJSE9Jqfj7Ysm0QaijPump9/J/ivAcoFb/rXcdcFyzvtFj36Mt6WJsLYx7eY3Z+jXQSdAKnsprkS7aRREcMstDL/NeYzS+Qwl1OQ3x5B7brotTb1TTu2NoeZZgYQkWUIuo3/a3BrlYuSBgpjLmA2s8w/IW9XEPPVv018z7IzqZUiIVPA5Dqj33eXcEW5IQe7Hjh8v9sUi2c4vohj7EPI+aJzaEe+tfUikUyZQ0imzRyBjy5Cn9zu8E8y7EUcNcNLaSnbT50FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCQjQorcCoOmwEPKn2rrnSGVUDSVvu8HVJo7yPC93Qc=;
 b=FVHHiHUuFrG+sBfsHErW+YS8Gqskb4bByq7FND7D/askJMhVThp9rUSvYefoisI0g9xdUmY4+w7McBD6bD7thlkZz0uPc0/pUEy/TAXargfF/eu/oGhO28mbh9IUXql8nOCZwXWRdb/x37Jaa51ZTq0eIs/a17psxqL2scO7j3k=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY5PR10MB5940.namprd10.prod.outlook.com (2603:10b6:930:2b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 16:44:08 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 16:44:08 +0000
Message-ID: <df8cc19c-f12c-4f7b-947a-4e21f8b97685@oracle.com>
Date: Tue, 12 Mar 2024 09:43:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, Rik Theys <Rik.Theys@esat.kuleuven.be>,
        Linux Nfs <linux-nfs@vger.kernel.org>
References: <55366184-94bb-4054-8025-1125db3788ff@esat.kuleuven.be>
 <aeb9e7b96161ac247c247b90c143935e80c7faf8.camel@kernel.org>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <aeb9e7b96161ac247c247b90c143935e80c7faf8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CY5PR10MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: f714602d-a5b1-4c19-4ba9-08dc42b3a30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fUVhkgDN+JWDvxEFlprwuHouJW1xGNZX5tefOWqLpZtjrowSXrlShnW2qfKK2kfuR6zamhsHsz+jClnBVknk8zNVVTu0s59nduqKiZqBgiBiY6nS7PtKJcu/78N/Sttk21uAdegDcj26wn8oig1xC6LQTYv9tHFcp/bpYb6jxcFMi6taV6y+49waS0afemihxd0oscAGfsg3o3v1r/NeRP70XuEvr1VqCspwFSBfPsic78GMPbNLA911LVCRJ97bkTs6G6x0mEB1fJBR8r3Ovs04nVJOFpLh8+tFcXNxLv6nW6G2vucfcnLsHV9YzN266r8datQETi8TDJo8b7uTYYSLmvTCfqEVVs0VBDpJRWMZHSaNZA53RKmVPtjQkYv447ybifvYUboT6ND6Tmu5G5bU03CMcmq1A28BgcQw379mIwFolXqStjbdqBks37jSxoqHS26Ju+YdP990fi2NEFy/r0XjUdrTOQwQskyp23ELBBGQ+TaucaQvZPTNrBzjD4Ok9wyse8lB7kmPXZBFPED8O6SXArERvfNXv/AhUnQIusbxoeMkwt04w5G+8yold2Ni+oFyrZLBuLfpIKw5e2GeLdBOfugIUfbCsu6r0mMEf3LuaEvP7qXx2WBm+K985bXIGR7h7iYjWX1g9T9DyLL9+MHit6fXVviTDJIG6k0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDN0NlhyNWNyTStGT2pKVU83ODEzTmVQN09vTHgxbmoybWVTQ2tjcnQ1Tzcy?=
 =?utf-8?B?OWNJYjBmVHYyOG5LYkJvUTJXTzlnRzVCVXJmU291WTdyL3lJMlZqVW1ZV3RC?=
 =?utf-8?B?ZGw0NHdVNXFtUlFlaEthM1doMlhmaU9TQlRuL0xIeU95WjJ4WGtRaEZFcVVY?=
 =?utf-8?B?WFkyb3pmZFU5VVJOVzBqc3NPMDdlVVZMRjNMV3pXd1FUN3JBdklHL1J3L01t?=
 =?utf-8?B?cWFzUDMzUVFMVi9QeTlvZE9DMWVkZmJhSFlhSElZNjk0K0NFano0SkRsZDI4?=
 =?utf-8?B?L0h3OWNuUU9od1RpVmFZTHo5N204cElGdU1wU3dlYVFORHJWb1RNcG1rWjZo?=
 =?utf-8?B?R0pmbnJvdVRLVGpkcFJJR2QwSXFzYjZIM1hYZnU1dWZVVlJuMTk3MTBkTldM?=
 =?utf-8?B?dER6SkNhWDhaSlFSdGJmQkl6ckFtSGk0NGZ4Qk1ibno3ditwZGxKRzlNeEFD?=
 =?utf-8?B?dndIVkFGcko3UEpua1hNMTlxeXdUa3FpRjZlaUkzN1doa3RsaDNmbXhZL0hk?=
 =?utf-8?B?TFNHRUhTSGNqV2g2ajBDQ1JjOUJLSkFEZnoybmNDWm5zUmt3SW1vSm5Ecm95?=
 =?utf-8?B?dk9mbnIyM2RUWWlXT3lkTTZ4OE1EV3hPcHV4ZHBUa0VyZ09WbGxQc0RvQmYv?=
 =?utf-8?B?UG5YM3dkT3RQbUorbVUrcHB3Y2tTSjNCdzBoVmt0VGxySzBXRjJXYXl6S0Va?=
 =?utf-8?B?Z25waHZ0YTdWVnBmQkRSMzU0cmM3M00xOWdsTmFRa0lKQnM5ZktNc2lkT213?=
 =?utf-8?B?NTI0ZUFGcE9QcWVGVStBWlBDNnFnaDZwSmpiSHpZTjM5dzJTTGZCbVZiZDlC?=
 =?utf-8?B?UkdxVWY4cmJuSGRPSjFvVFhkeHoyNHFKejF0a3hadUtrSzNXa0NGTVE0NS9t?=
 =?utf-8?B?cGtUMVRHRmdOMm1hcG94WmUzRkVjNG4yUWcyL3F2U3dGbmc3R3JRYW91UjVt?=
 =?utf-8?B?TXRDU1krcGYxOEVJaFpmY1FJYVZZVmlrZ3lHakhpYkNoZzlIOS94VG52U05t?=
 =?utf-8?B?S3dtUFh2R0NDc1kzMGtLVnlsV3hxREozTmJMZDZtTzNNSyt6NFMvUWxQV1h2?=
 =?utf-8?B?aW5NcnJvRWRocVJUWGZNYlM4U3dQS2FyRFVnYzRQbDV2ZjZUSnFCWVdBVmNo?=
 =?utf-8?B?cDNwZTZza2F6c3A5d0RQaFhvV01RVUp3T2prR2k1TitxY2czaHJLRTdYM0cy?=
 =?utf-8?B?TzZKeXdZNWhOS2lKb0tGNHRmYUxCWlBZR2QrN3huV2p4eFEvaVpvNkRFRnJW?=
 =?utf-8?B?cFF2WlhSdjd2ZVhad1JZb3FQVHRnN3I3RzRnSThnR0xSU2VjOTV1Z1NnWjVX?=
 =?utf-8?B?NDV6UGZ5Ynl0OHBEeXBZaGVIZERVMVhFRGtXS2ZpaGZ3bk9DOFgvZU91UStC?=
 =?utf-8?B?bUsvdFlGTktpcUZlUnNPQ3N5a2RWeEJvM0dGQXh5L3JLRk5SdnQxZkpWdk0y?=
 =?utf-8?B?RXdLWXltMGhFc1kwdWxEV2NWR0JjUUlPUWV1WDlCVTNtcERNSE4xdEd5azZo?=
 =?utf-8?B?RnJPMXAxQUthZldnWDJUUjAxR3puNTliVkt3UzZmenVrL0VXaENEdHNlWmpE?=
 =?utf-8?B?M1A5QUFoVnpXNHdQUVo5WmpaNkNsNURZZmVrbjM5WmdiSk9nR1VmdGc4NVFm?=
 =?utf-8?B?TVk3VGVCQTN2eTNsODJmZ2k1M2Zha25nTVVjL2N4cWo4VFZEQ1lPVFI2VTdv?=
 =?utf-8?B?RU1kbzlpVllJWnRpN0xsZzlNbUxEVk9lWm9ReHJsaFVUWm8xeXBKd1hHNGxY?=
 =?utf-8?B?ZE1vVCtqaWd2TTdhclZNK3hOTGQycDd6Qzl4dWFUa200RHdQazQ4RjNHM05q?=
 =?utf-8?B?aXBZOVN4Y3g2Z1JaUENWQ0NtSGlrVkVvUC9HU0pmaEpKQ3U5Y1dyYU9DQmgy?=
 =?utf-8?B?RHhsWTlXQ09ndkVlbjJhY2RKYVZUUDVWL0Z1d2I4R1R4dGc4Z0JuQjlWUm1u?=
 =?utf-8?B?VkpZSndmNSt1bWQ0VElTRUZSSXpOOTNnWElBbVdVK3JTMXFwS2dvVlEvZHVE?=
 =?utf-8?B?SnkyYTlsY29BUmVDTlZwUjRoQUU4THZJcThDR09KS2ZvRzNFY2EwbnprUkZm?=
 =?utf-8?B?VWxVeHQ3UHdsWkVpazkzQ0wrQWZvM1g1NDkrZjBiWFpvZm9qcHFMc3luYUNO?=
 =?utf-8?Q?gOyydjm0xO6EKOhv87REbHR7c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yBy4p2XNXIv9ODd3nFvjHUQXz63OJMMD2JWDIeMZYaSuRZtEWpR42uOqGJTicTX6zSkT6YwdpXjBgnVX1um3N9WBMnL9kj8KN0nLvRXHdi+Ce1gAY5gg+EsqFpU524g3Q+lJ3achC39fiLjYMcx7d2m8sooSsK1ZiptsQwJLXC7ajFaJfdFGsuLYH4aooG3tf40wHi04G+K1qhe6JCK72tUzRYfbUw59t0w3T2LzTL5xJsDJdLsa4cqWYk4lf9TGCi9P8QVbGbBnIfZB4WehuSOHALZg9nJdx9PCJ8gY9j0Mq+QzXrogf65pEq/fZHro1i5R5U4cfdhqvXUrTKjnhQiN/e1HEXjPzAg4U+FC/KJf91dLShRB/ISxRl8GesVV4ifkQJJL8q8faYpyfYf/hF3iRULiqmxC+RBPw0mkxuizUX0OKPKh/TcXdxLo3wzymof+Qnaqh/ZIvPtRW1WjmfZxU6HUjXu5Bj/M+xCXMk6Z6FxnUbjA0pJ9tpW2X7amimYR5L32iCeGiQyA0X/905ebTOl/bJZwjpYyjyfdi77TDZhecI1gz981ev03DutcmJBX8S8DooFk1rkvkrihMLGBMmdRmOtt0CgqOlU9ER8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f714602d-a5b1-4c19-4ba9-08dc42b3a30b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:44:08.3050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIxWfgppv/FJt6oSwqsakX0hBwMSSsiWgEPSy5x4fn/QF90ceQoyqWbuGFg34s59kLtE5d5FBfnscotb1PB2Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120126
X-Proofpoint-ORIG-GUID: yV54oYiGXe68TbijVCS6NiU7yAIxVxNa
X-Proofpoint-GUID: yV54oYiGXe68TbijVCS6NiU7yAIxVxNa


On 3/12/24 4:37 AM, Jeff Layton wrote:
> On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
>>   
>>
>>
>>
>> Hi,
>>   
>>
>>
>>
>> Since a few weeks our Rocky Linux 9 NFS server has periodically logged hung nfsd tasks. The initial effect was that some clients could no longer access the NFS server. This got worse and worse (probably as more nfsd threads got blocked) and we had to restart the server. Restarting the server also failed as the NFS server service could no longer be stopped.
>>   
>>
>>
>>
>> The initial kernel we noticed this behavior on was kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've installed kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same issue happened again on this newer kernel version:
>>   
>>
>>
>>
>> [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>   [Mon Mar 11 14:10:08 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0     pid:8865  ppid:2      flags:0x00004000
>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>   [Mon Mar 11 14:10:08 2024]  nfsd4_shutdown_callback+0x49/0x120 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_cld_remove+0x54/0x1d0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  __destroy_client+0x1f3/0x290 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  nfsd4_exchange_id+0x75f/0x770 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_decode_opaque+0x3a/0x90 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>   [Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for more than 122 seconds.
>>   [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>   [Mon Mar 11 14:10:08 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0     pid:8866  ppid:2      flags:0x00004000
>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>   [Mon Mar 11 14:10:08 2024]  ? tcp_recvmsg+0x196/0x210
>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>   [Mon Mar 11 14:10:08 2024]  nfsd4_destroy_session+0x1a4/0x240 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>   
>>
>>
>>
>>   The above is repeated a few times, and then this warning is also logged:
>>   
>>
>>
>>
>> [Mon Mar 11 14:12:04 2024] ------------[ cut here ]------------
>>   [Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>   [Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4 dns_resolver nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm ib_core binfmt_misc bonding tls rfkill nft_counter nft_ct
>>   nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio l
>>   ibcrc32c dm_service_time dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm ipmi_ssif x86_pkg_temp
>>   _thermal intel_powerclamp coretemp kvm_intel kvm irqbypass dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper dell_smbios drm_kms_helper dell_wmi_descriptor wmi_bmof intel_u
>>   ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt acpi_ipmi mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_meter
>>   nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4 mbcache jbd2 sd_mod sg lpfc
>>   [Mon Mar 11 14:12:05 2024]  nvmet_fc nvmet nvme_fc nvme_fabrics crct10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c_intel ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
>>   el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror dm_region_hash dm_log dm_mod
>>   [Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not tainted 5.14.0-419.el9.x86_64 #1
>>   [Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 2.20.1 09/13/2023
>>   [Mon Mar 11 14:12:05 2024] RIP: 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>   [Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff ff 48 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 c8 f9 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
>>   02 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
>>   [Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 EFLAGS: 00010246
>>   [Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX: ffff8ada51930900 RCX: 0000000000000024
>>   [Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI: ffff8ad582933c00 RDI: 0000000000002000
>>   [Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08: ffff9929e0bb7b48 R09: 0000000000000000
>>   [Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11: 0000000000000000 R12: ffff8ad6f497c360
>>   [Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14: ffff8ae5942e0b10 R15: ffff8ad6f497c360
>>   [Mon Mar 11 14:12:05 2024] FS:  0000000000000000(0000) GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
>>   [Mon Mar 11 14:12:05 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   [Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3: 00000018e58de006 CR4: 00000000007706e0
>>   [Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   [Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   [Mon Mar 11 14:12:05 2024] PKRU: 55555554
>>   [Mon Mar 11 14:12:05 2024] Call Trace:
>>   [Mon Mar 11 14:12:05 2024]  <TASK>
>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>   [Mon Mar 11 14:12:05 2024]  ? __break_lease+0x16f/0x5f0
>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  ? __warn+0x81/0x110
>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  ? report_bug+0x10a/0x140
>>   [Mon Mar 11 14:12:05 2024]  ? handle_bug+0x3c/0x70
>>   [Mon Mar 11 14:12:05 2024]  ? exc_invalid_op+0x14/0x70
>>   [Mon Mar 11 14:12:05 2024]  ? asm_exc_invalid_op+0x16/0x20
>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  __break_lease+0x16f/0x5f0
>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_file_lookup_locked+0x117/0x160 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  ? list_lru_del+0x101/0x150
>>   [Mon Mar 11 14:12:05 2024]  nfsd_file_do_acquire+0x790/0x830 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  nfs4_get_vfs_file+0x315/0x3a0 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  nfsd4_process_open2+0x430/0xa30 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  svc_process+0x12d/0x170 [sunrpc]
>>   [Mon Mar 11 14:12:05 2024]  nfsd+0x84/0xb0 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  kthread+0xdd/0x100
>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_kthread+0x10/0x10
>>   [Mon Mar 11 14:12:05 2024]  ret_from_fork+0x29/0x50
>>   [Mon Mar 11 14:12:05 2024]  </TASK>
>>   [Mon Mar 11 14:12:05 2024] ---[ end trace 7a039e17443dc651 ]---
>>   
> [Mon Mar 11 14:29:16 2024] task:kworker/u96:3   state:D stack:0     pid:2451130 ppid:2      flags:0x00004000
> [Mon Mar 11 14:29:16 2024] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
> [Mon Mar 11 14:29:16 2024] Call Trace:
> [Mon Mar 11 14:29:16 2024]  <TASK>
> [Mon Mar 11 14:29:16 2024]  __schedule+0x21b/0x550
> [Mon Mar 11 14:29:16 2024]  schedule+0x2d/0x70
> [Mon Mar 11 14:29:16 2024]  schedule_timeout+0x88/0x160
> [Mon Mar 11 14:29:16 2024]  ? __pfx_process_timeout+0x10/0x10
> [Mon Mar 11 14:29:16 2024]  rpc_shutdown_client+0xb3/0x150 [sunrpc]
> [Mon Mar 11 14:29:16 2024]  ? __pfx_autoremove_wake_function+0x10/0x10
> [Mon Mar 11 14:29:16 2024]  nfsd4_process_cb_update+0x3e/0x260 [nfsd]
> [Mon Mar 11 14:29:16 2024]  ? sched_clock+0xc/0x30
> [Mon Mar 11 14:29:16 2024]  ? raw_spin_rq_lock_nested+0x19/0x80
> [Mon Mar 11 14:29:16 2024]  ? newidle_balance+0x26e/0x400
> [Mon Mar 11 14:29:16 2024]  ? pick_next_task_fair+0x41/0x500
> [Mon Mar 11 14:29:16 2024]  ? put_prev_task_fair+0x1e/0x40
> [Mon Mar 11 14:29:16 2024]  ? pick_next_task+0x861/0x950
> [Mon Mar 11 14:29:16 2024]  ? __update_idle_core+0x23/0xc0
> [Mon Mar 11 14:29:16 2024]  ? __switch_to_asm+0x3a/0x80
> [Mon Mar 11 14:29:16 2024]  ? finish_task_switch.isra.0+0x8c/0x2a0
> [Mon Mar 11 14:29:16 2024]  nfsd4_run_cb_work+0x9f/0x150 [nfsd]
> [Mon Mar 11 14:29:16 2024]  process_one_work+0x1e2/0x3b0
> [Mon Mar 11 14:29:16 2024]  worker_thread+0x50/0x3a0
> [Mon Mar 11 14:29:16 2024]  ? __pfx_worker_thread+0x10/0x10
> [Mon Mar 11 14:29:16 2024]  kthread+0xdd/0x100
> [Mon Mar 11 14:29:16 2024]  ? __pfx_kthread+0x10/0x10
> [Mon Mar 11 14:29:16 2024]  ret_from_fork+0x29/0x50
> [Mon Mar 11 14:29:16 2024]  </TASK>
>
> The above is the main task that I see in the cb workqueue. It's trying to call rpc_shutdown_client, which is waiting for this:
>
>                  wait_event_timeout(destroy_wait,
>                          list_empty(&clnt->cl_tasks), 1*HZ);
>
> ...so basically waiting for the cl_tasks list to go empty. It repeatedly
> does a rpc_killall_tasks though, so possibly trying to kill this task?
>
>      18423 2281      0 0x18 0x0     1354 nfsd4_cb_ops [nfsd] nfs4_cbv1 CB_RECALL_ANY a:call_start [sunrpc] q:delayq

I wonder why this task is on delayq. Could it be related to memory
shortage issue, or connection related problems?
Output of /proc/meminfo on the nfs server at time of the problem
would shed some light.

Currently there is only 1 active task allowed for the nfsd callback
workqueue at a time. If for some reasons a callback task is stuck in
the workqueue it will block all other callback tasks which can effect
multiple clients.

-Dai

>
> Callbacks are soft RPC tasks though, so they should be easily killable.

