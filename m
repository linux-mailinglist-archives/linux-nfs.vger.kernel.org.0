Return-Path: <linux-nfs+bounces-15177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DEABD336F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 15:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7874534AEEB
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476132FD7AA;
	Mon, 13 Oct 2025 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CsILT2O/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wqwZsxUt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3B2BCFB;
	Mon, 13 Oct 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362356; cv=fail; b=I67oaP3VbnJwFYX13a/TXrIxXRhOv0e01tDp+GNjssoFtWp/8gk8PxyjIOA/E1kq1556Yc9zCFpcuSvLWaVyLhigr92nSaHxYzByBr0/QxNQQs0VgRRztWZRh6rfV9SvxJsYT4JJPnRJ0BVNo6ak8/Mb5mhhBvUA5lhg2ILkToU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362356; c=relaxed/simple;
	bh=0qETdPahjkAUHZ1eIti0iSUwO8eKWIbaxh2uoK+PxNk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HRPfd6iwyAwBXIsTEiyXaMJMyb/EKDJ8bYdcCdJPaoXUaFC+G/MhIfx99+1exnSWahcYDhO940ZqI2g04Iqk/Rmb9p8DQUZgwOKpVHKTOCXmsgwlGwAfCL4EBVKxCP1PaghMDmL/PKuqDOaCgROy93OabSiYxLu1nhLQQvDsvhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CsILT2O/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wqwZsxUt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DDQeWh007014;
	Mon, 13 Oct 2025 13:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Q37b0IhVaNybJnHMhssegLmOlHvo7Av++awbLp+SLwg=; b=
	CsILT2O/U1/dlXtHHYYIcuAQuxxhrsDDLjAnOklEcYRZqGNLMQQ0rIcqPH4BSszt
	FmsSM3ZiHt0y0XgN76hP0YneuDjRa6nfoqm0PIRarw20DQ1oyjgoXDzuJ5MFdF9Q
	+WgT8eEIIzdz2ifCbTn7f3GXgtHvAVb7Hp7kPeKY2BRepYmEcAgiV5hlRBsNqIYv
	RR7pwbCrAaO7VfEoXTx+hwmuRAbqr4B2ogB/D9MQ+8K30knRYtWEC32p2YOUSIP6
	GJCAIii/Yw9lPp7SEuOlenhYYXQh7hzmVts4a2L6A2Fkl3f/QdbimQUNh8EwX/Jb
	/DblSpzIpZ+5yP6Z7b+QVg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59aa69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 13:32:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DCfx1L009880;
	Mon, 13 Oct 2025 13:32:23 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpdjgbs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 13:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktYlstF1v0hOS8SkJkJwpvceLMYzdcM9MxttyboWf2RdBXwghE7E4JUP/JMEV2TazfrZuFUqPuN7LYc305XQxVwgeB5MOoB1KqvYFLUbxRA1ZZF/SGMWAZsk02zAhyrJ1etnMWsuT33hdLVvG50QZ20evzBDsz5Q7Ppvr2ScdErcWHG0GND/SI2KQgQmVCa15qOo/UH+hb+ygWyjQEp6u3LQyeoqgryiN/bZH1XWiokpw0UlbDYTOhmqWPzDyIYBslMC5sk1PoteYAvhxwO/Qq16VTCUhroCcbWcA4nW2Gcrn46nFDwhjDHLn02ICZaDusyY8VLSR4TJ+LhqLosIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q37b0IhVaNybJnHMhssegLmOlHvo7Av++awbLp+SLwg=;
 b=lQ6mSWT28+ibbM/1TgXAB8fJ85odTsuVx5veSZQpWUSzS9V0x6+reZ1Vy4SXj2eY2fQ1oqLiVSllyNShuhDzN0YSCbFm3uwK4OwMM1yfPf+OeQFTF+HyfpD4G75EsdzwcV2wtzEWtOld3nZQG8j1AnmIVocSQj+FcOKpKneBEjLaMOnHh8H5mN7MEtnYyNJHTx5oULehsZBmlMujXKXxNsoerpfNzbH/6ADvJH3MZisxCr1JGnqcB5Kah2k/EXJsBHtRMX3mmlwZB1N1bt1cnAQQaxz9X2+0NeAiHuW++Vy2B4ORj/H0bWW0G3s76Y4KJj7t7hyQgxpkAI49iUvImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q37b0IhVaNybJnHMhssegLmOlHvo7Av++awbLp+SLwg=;
 b=wqwZsxUtJ5eef0NciP5JFWxyWGNintTlZOblBNAh4auYVIwjBPs1za3kFNYuEtVxaFMFdGnOLwI8wQhlvJSIEk7PxzwmI7+a6a2qNj3JzV1FC26QQSefsrtvIVKvNf8wt76uOmIAvEle87+O0zbpaxL4BuX8otgv+l2PGufQYHk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4724.namprd10.prod.outlook.com (2603:10b6:303:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 13:32:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 13:32:20 +0000
Message-ID: <04b83f7f-8dff-4b1a-a85d-c44a6c517e5a@oracle.com>
Date: Mon, 13 Oct 2025 09:32:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Use MD5 library instead of crypto_shash
To: Scott Mayhew <smayhew@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20251011185225.155625-1-ebiggers@kernel.org>
 <5f405581-e7e2-4e77-8044-0496db85aa27@oracle.com> <aOzYoh6hgXRGvTWV@aion>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aOzYoh6hgXRGvTWV@aion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:610:52::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 715395c7-9ea5-4428-f145-08de0a5cef20
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NysrUTIxSDNWYXVrNUJqWG8xdXhIb0hXd3ZNb2pQZEl5OW9rVFVkanB6ZDBw?=
 =?utf-8?B?dWp1elE5YU8yaTBjb2lRNTFUT1RSUTRucC9vRFc4UWZhek5mSURMKzNtcUY2?=
 =?utf-8?B?bXBxNHpPalVCWEZ4SU02R0NEM1NWY21IQ200aENXWnVGZ1c4M2JnbnBtamtn?=
 =?utf-8?B?aFZZNkMyeGFkWXBoT0F2ajJ5bWRYRjBlOUVGYmhUbmFJNWdmWEtCRnNVTTdh?=
 =?utf-8?B?bEZDSlZvMGtMTUJ3SlYrOUcvY2RTRXNkOUNkRXcyYncwQ3pTSTA0emljWmFH?=
 =?utf-8?B?b2ZmRDVLZVo5dlJZeWxpUnZoRUV2THJ1TEpXcEZjUVo3cm50WnB4dlFFcnlm?=
 =?utf-8?B?dWVGdWh3cXpKNm42T0FkRW4vSy9oeFdzdzhvN2tFay9hL0E1NE1HQlIrQitp?=
 =?utf-8?B?Z3ZCRUNUbkZOVkFHaWhiNXFoWjlBbnR5bEVNUm5BakVFeWV1VXYwNDhYblYz?=
 =?utf-8?B?TXVhNkNJRFh1T3g2bVhxb0JQT3Q2bzVvMjdQZzUreWwxTzUvR2JhMi9pVlM1?=
 =?utf-8?B?V0owT1NyeDZ1RTdpK0pOOFlSRHlDNEw0enlJSVkvUTNjVXZ2STllVGRNNmFI?=
 =?utf-8?B?R3JXQkgwRXN5VWg2ellaU2ExM3g4SXl5aVVSVFpEbUhJd0tUMVA1YzlNQURL?=
 =?utf-8?B?TzhNUlJnbkYxT2dBQUJkMVJzeDU1U1RRZlczUnRQd24vSFlyMFVUc2xmak1j?=
 =?utf-8?B?ejA2UjVxRmFKdDZwVURRbzN6ZEVDV0R1QVR2MEluTUtGS1pTVmNjNjBWMWND?=
 =?utf-8?B?MWZxOXBSNGU4SXFtc0ppZHFCV2g2Si9qUzE5WFpFVUNxRjJ3ZkVMV2RBTUdt?=
 =?utf-8?B?T0JhL0pnSHBWVTg0RHBxK1RxQzl0UVE5NFpWL1ZaYWR4Z2pHaDlqYmVUZEQ2?=
 =?utf-8?B?SG1hSEJnb3V3bDVHQ09LTE5JMFdDUUY5UE91WjJ4VVZPVS9RTlFrZW4zRStR?=
 =?utf-8?B?Wk1UZnBROFRLM2dQREdrWTd0c3lGVlRuS2YvL3pJdWtNQ1BiYno3U0JmYmdK?=
 =?utf-8?B?djNZVHBIT1NGSXhkdjZHc0p1S05ib1JBZnRNUlBhVFFOK2ZhTXV6dVVTay9r?=
 =?utf-8?B?Z0hqaVRmaENuWGxVVXV4cjBXLzZYdHlnYXBVbGZPVWNabWtqTnhuVlpzVXl5?=
 =?utf-8?B?dGNTMncvQm5TdTZFa1pZYjlUK2ZTUTBEWDV4ZmR4dVd5WFFoUFpOVVZjUXZq?=
 =?utf-8?B?SEpPUjBqRzFUZWtxbGl5ejJ4L3RKSTNaTFJDR2p5L1ZpcjBuRWoyNHlkVTQv?=
 =?utf-8?B?WXY5Tkl4QVhUQ0N2ZXlhekVaMmtyT3ljZFJrVVBWTXVnei9Ga3p2WGxqRGZa?=
 =?utf-8?B?Vy9CZXhkdFRyS3FJalZUbnRHeWdHaDZUOXpkeVljU09NZkhaNlptSDI5Z01r?=
 =?utf-8?B?L3JpOWZJbHBlaGtGVWdVTXFwbDR6QzNWZllicDk5OEpGckhUSzhUbVU1TlNk?=
 =?utf-8?B?bS9xOGhTblpxMVY5T2p3NjBLYlhHYmZYcFY5WUpVelRXSUxrak9hNDNhNzZS?=
 =?utf-8?B?QXRXdWhPbDJvUUdxeDFzVEVHZlM5a2ZLRE1EVGptY3pZWHZ0SUppS3JQdGdu?=
 =?utf-8?B?dkp0cXZwa3F1MmVIdFBieHVCam1PR2ZYUlZNQnY5bDZISWx4ejhaVWkwR0Ft?=
 =?utf-8?B?Zmo5WG5KSUc4SFd1NzRMTUFGeU8wd1c1N0pmNVgrUzFMSmUyQmlxVEcxMXdB?=
 =?utf-8?B?eC9SQ2UzRS9CT3A0bWZpdkF6RkZTWjdBYXYzbitLeG1yOEhJbE1DellKUUk3?=
 =?utf-8?B?c3RjdS9WRExvSFdoYUtGRkhnbHd4UWdSM2NVOU9mT09LdVIyMTl0d2M3eWgw?=
 =?utf-8?B?cEoyd2Y4TVJRbU9zaXc4dTd2ZG5FY29xYnhnOVUxQ2phOHFMZ0VacDlPQ09D?=
 =?utf-8?B?Zm5aWmdudUpkNzVwTWNwd0RBc1lkUDJUOG03anoxeEQ1U2JZWEZVN0g0bnpD?=
 =?utf-8?Q?5ZE0HEIiDqPJsnRoZIaRI6GdAq7jRIlY?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WU9MS1dFNkphTytrZnZObGZNWU01dkptSmVVRkUrMmVMQWt5aTl1UU1RUFR1?=
 =?utf-8?B?SlBmUFVGWGVmN2h0R3RiV2trOWRWQzFyRkJxOXdncURSNnZMM29OT3M4NHJX?=
 =?utf-8?B?MzFndWQrb3BuMjhoOTVZanFZa0lDUDJVWStPMG1hc2R2b1dsTVpLU1JYeFg4?=
 =?utf-8?B?bE8wang3U2tVK0hGb3JZTHgyUW01WktMRnNHRGRnR0NsQ0cxNGdpMElUKzhw?=
 =?utf-8?B?QUFjSWxBMFFNU21MeEZ3R29hYkx4eXRXN3JaSUtrWHBZYytEUEpxaFpZaklr?=
 =?utf-8?B?T0ZvZFM3T0hTRlJwN05DdCtpQklJWmU4MjYwcmFHWjlqSHBHTThTc3gxemZ6?=
 =?utf-8?B?bUpFNUpDdkM0eXRGK1R0Rk9xdGpnbnBubDJhR09VZlZDNHV2QnhPTHo3Z0k5?=
 =?utf-8?B?ZENYWkF3dzlteldFWWNiRDgxYnZqUHMwckg0RG5VbndLcGdiZ1VIaEdSa2Y2?=
 =?utf-8?B?QlVIU292eGNMbi9lQU5DZlBCOXJ3bEVhbjMzWEM1Z1FpVlFYdG12U01tQmtR?=
 =?utf-8?B?b3V6QVRaZzMwR09DaEtqR0FOSWo2dUExYnlTSTkwMzY1SHpOTC8yV0Z2RkxJ?=
 =?utf-8?B?T0UwMHRMZm1DaDBUZWVyWGYrUDVlVDRuZDI5b1lydFA3dlEvNGVuc2xYL2t5?=
 =?utf-8?B?UVZxcTU3SWtQM3hDdk1WYlF6N0NGMXBLNlNZWlFYVzAwYit5eVgyS3g3eUVs?=
 =?utf-8?B?MFpsMWJ1dndmVGRENlRuK0Q3bFhUb1QzcTFCajhPaHlTcEV3VGJwdERtRXJv?=
 =?utf-8?B?MUFqOHIzZlhXekZtU3FtMDFtekVXcXRZVmY3RWprcklZcDE5ZHZxdkFqanFo?=
 =?utf-8?B?ZWdLa0c5VHJKaUNjTm5EYW5xanQ3SXVOVjNxd2s0ZXgrdVBha0VMVzIwWWU1?=
 =?utf-8?B?SzROZmFyNHhNdFVqVHNnMlVUWjlwU2pab25VdUd0ZjZqL2djNnArUHgyMmZr?=
 =?utf-8?B?L2pibGgxU2daUzFQcytnTjZJYURNaVlXaExsL2RzcjBqTWZ6YXFTbzdPQXRH?=
 =?utf-8?B?NUFuOGRsS29xSjc5WTBpOWNkVGRWSmJoZG1MVVVIWURUYXRnRm1KazZBTU1C?=
 =?utf-8?B?bk5hZFFiL0x1QW4vUVluUXpZNUl2U1ZRQnlPa2JtL2wwSnZtUlk0Tk9BQjN1?=
 =?utf-8?B?aWlwazk5TUFZckw4U29UNkRSaXhBN0wwYk0yN1NHempKVkVmRC92NmxiNUhl?=
 =?utf-8?B?OTJTYlY3dnJ1VldEcURtWGNSRFlyQ21SVHlIVEtMV1BRMVp4MHlOTjEwMy9K?=
 =?utf-8?B?WG1iNnRPZTUvSW4xdUNhNlBwVnNWeUx6N01LVWhTMDZXZmkrM0NWQkF1cFQ1?=
 =?utf-8?B?WHd1MU1GZnZqVlYvcjN3NVpXTlpPK1Vja240VFoxSHVUNmsvOUdYMXpEWlR3?=
 =?utf-8?B?aGVrZFFQYUkvWXlZa2MyWlp6TTRJaGoxMkVWRzR5MVAzVXdCYWk3b2wxQjZC?=
 =?utf-8?B?dW1ud2t0Um5Xa3ZHZ290VWxVNGhCcDlkTVNHN1QxQkRrdHJHSzRqdWx0NlZo?=
 =?utf-8?B?ZWdJTUxkMEh6QXB6Qi9aSk1JVkdwdEZpRjdGd01VYkFQNmJuOEhHVjd4enR6?=
 =?utf-8?B?dXlDQ2RGLzV4dEZaZWVMNjBadWVJU09ES29Cb1JSVUJTMDRqdjlUOTh5OUty?=
 =?utf-8?B?RFRiSFZ3bUgvOFJSbk90SE5ObHNwaS9sT2ZiVWk0L3RnNks1ejk5T0wrWENC?=
 =?utf-8?B?WjR2cmU4dzMzOEJYVTAvVnR1OWNRKzZ4YTBMVWw0OXBRL1JqWUNpNm9vRmx6?=
 =?utf-8?B?V0tXUFVVMkN6QU84bVdueUtnSjlpTG5LZDZhd1MzaWpqYm9GNzhmelVndGx5?=
 =?utf-8?B?TWVId0lBbEVxWFo3MnMzNU9hanV2dUl4UkVlQU05SWZsMlNxRGs0MHY4TDBP?=
 =?utf-8?B?YU1HeWpXajF0aHI1TG9KcTI3bXo4ck5zb0tqckRER1gxUXo0RC85SmJiMG5W?=
 =?utf-8?B?ek9YVnI1MFpMZC9yaUJHZE5YWHBSVVQyQnlDSFpHbC9LcUNsQWJvVnFyYnZu?=
 =?utf-8?B?dU9MVGFXRCtFUzVybDlGVWRmd1Bna3pnOUltZTJQaFZubmsxcUNxV0ZjNHoz?=
 =?utf-8?B?dEN3Vm83WDZKRzJXck5DUE5QeFVwNTcrMlRXQnpZUHRNUUtFd0ZRSkZ4MzhL?=
 =?utf-8?Q?YOnNJRuFGXmvVCNmbycebJM43?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fXwVMDF8NelGll7KGDefZ48LN3jlLAl8zyo4S2twedCeB/MzVhkYsJbVcoaLXJ8ysglza2VJDfIXbqfWX4rfupFf7yV7zPMHaYM/ex7G1rukZRkvasEL/MUk+w/nd8GIcN64BAqYDZBHddioDmHQEFBPpfGyXpSlz2sv/NdlW/+35Hr6su1EZUJc5i0Gl+4qwwYBNf7MP7Kq4C/k6UpWztelA1LJUz1iZ5uXEUtm93r1E5GkOb0mn6IWJQ2jq4Cf6tQRyEkjVRA+pPq6VQkCfZkWbemHtOpVvrt9EDGdEwNvCK9Ixvva/EyNRyqkvLaPUeQB8wM0DQRvPXbuAk0895Sl15yM32E8WjJ52bymE2VlJfArpj7Iid9xHzUaGZVAZzYtBf0QQbqqgHaAqGdUv3k6p4ml4mlxp/gY6p5F2CCXsohuICwNLGOBHyp3/YtDhNUYBlVuRckbNhALM7+pSlDGzXOOuiNKc2gap5CjHhHo7bgIKbDBJEL6+q4yAOmEfVR2x7/tYijdIgDs1FyjJfTbYmlfw7z2K0IJ+cAYtfon2zkw1sgv24MebY1XYybikNaFgzYuaINzewln7WjWaw8lnMuEkQfk7dHmOXbCKK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715395c7-9ea5-4428-f145-08de0a5cef20
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 13:32:20.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AD3qXckzHw3pEHnLmY+OVbnUTVFQ+Q3uBuHZEwoJAvnAlto4C2V8WE0HDCT46UbwEyEqcyfd8IXe8GMC3EbFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510130060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX2HPAXtnXtrq/
 KhLcYF5L5V9+5P8GfxgkeCPQvf7ae1V8pb8zbOztP2OVG/0XWT0B+DLqsYI8j4VkuWS8GbUatJD
 HEx0TTy5DFowooT+RcdklDmVQ1xiididLkgVOvzBuHpdVedb45bvgWm77HXL7nYHAm8OYdXG6ud
 VP6kC9J4g93DtpX0vgyYx5JVlNEswpnqHUasBTGojadSBTFAvWUL9c6s9xAOhSt0dBmwGloNvX4
 cEwEkFOqhxasPWs4OORU4ZkFIRqVNA3DXMt30G4vrbBfO704XjC9LEP4zOdDupxdRS/59tl1eLO
 3q32q4XLe0fW1F1tkruSiflCr1B8XLJzKkbHXrnc+pCwoKaEi5wvPl2iPWozIvW/A0J4UMSTv3u
 1NWvZ8vQHfcgAKRCXMgHtlRBhShnA2gdsiVBdGpMA+8bHrNsGJ0=
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68ecff68 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=RSTd7hbTSoFbcTnEsRAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: aCfOmvzzli5nmzUwRLv8dvSCIqNvWw8d
X-Proofpoint-GUID: aCfOmvzzli5nmzUwRLv8dvSCIqNvWw8d

On 10/13/25 6:46 AM, Scott Mayhew wrote:
> On Sun, 12 Oct 2025, Chuck Lever wrote:
> 
>> On 10/11/25 2:52 PM, Eric Biggers wrote:
>>> Update NFSD's support for "legacy client tracking" (which uses MD5) to
>>> use the MD5 library instead of crypto_shash.  This has several benefits:
>>>
>>> - Simpler code.  Notably, much of the error-handling code is no longer
>>>   needed, since the library functions can't fail.
>>>
>>> - Improved performance due to reduced overhead.  A microbenchmark of
>>>   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
>>>
>>> - The MD5 code can now safely be built as a loadable module when nfsd is
>>>   built as a loadable module.  (Previously, nfsd forced the MD5 code to
>>>   built-in, presumably to work around the unreliablity of the name-based
>>>   loading.)  Thus, select MD5 from the tristate option NFSD if
>>>   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.
>>>
>>> To preserve the existing behavior of legacy client tracking support
>>> being disabled when the kernel is booted with "fips=1", make
>>> nfsd4_legacy_tracking_init() return an error if fips_enabled.  I don't
>>> know if this is truly needed, but it preserves the existing behavior.
>>>
>>> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
>>
>> No objection, but let's cross our t's and dot our i's. Scott, when you
>> have recovered from bake-a-thon, can you have a look at this one?
>>
>> Thanks!
> 
> Looks fine to me.
> 
> Reviewed-by: Scott Mayhew <smayhew@redhat.com>

Thank you, sir.


> I agree with Jeff - it would be nice to just remove the legacy tracking.

We're following the common deprecation process. The default setting for
LEGACY_CLIENT_TRACKING is now N.


> I'm guessing it's still used in smaller/embedded setups?  RHEL and Fedora
> haven't had it enabled for years.  Looking at a few other distros... it's
> not enabled in OpenSUSE Leap or Tumbleweed.  It's not enabled in Debian
> Sid (but it is enabled in Trixie).

Hard to say with certainty who still needs it until it is removed. We
could decide here and now to accelerate the deprecation process and pull
it out of v6.19.


>>> ---
>>>  fs/nfsd/Kconfig       |  3 +-
>>>  fs/nfsd/nfs4recover.c | 82 ++++++++-----------------------------------
>>>  2 files changed, 16 insertions(+), 69 deletions(-)
>>>
>>> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
>>> index e134dce45e350..380a4caa33a73 100644
>>> --- a/fs/nfsd/Kconfig
>>> +++ b/fs/nfsd/Kconfig
>>> @@ -3,10 +3,11 @@ config NFSD
>>>  	tristate "NFS server support"
>>>  	depends on INET
>>>  	depends on FILE_LOCKING
>>>  	depends on FSNOTIFY
>>>  	select CRC32
>>> +	select CRYPTO_LIB_MD5 if NFSD_LEGACY_CLIENT_TRACKING
>>>  	select CRYPTO_LIB_SHA256 if NFSD_V4
>>>  	select LOCKD
>>>  	select SUNRPC
>>>  	select EXPORTFS
>>>  	select NFS_COMMON
>>> @@ -75,12 +76,10 @@ config NFSD_V3_ACL
>>>  config NFSD_V4
>>>  	bool "NFS server support for NFS version 4"
>>>  	depends on NFSD && PROC_FS
>>>  	select FS_POSIX_ACL
>>>  	select RPCSEC_GSS_KRB5
>>> -	select CRYPTO
>>> -	select CRYPTO_MD5
>>>  	select GRACE_PERIOD
>>>  	select NFS_V4_2_SSC_HELPER if NFS_V4_2
>>>  	help
>>>  	  This option enables support in your system's NFS server for
>>>  	  version 4 of the NFS protocol (RFC 3530).
>>> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
>>> index e2b9472e5c78c..dbc0aecef95e3 100644
>>> --- a/fs/nfsd/nfs4recover.c
>>> +++ b/fs/nfsd/nfs4recover.c
>>> @@ -30,13 +30,14 @@
>>>  *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
>>>  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>>  *
>>>  */
>>>  
>>> -#include <crypto/hash.h>
>>> +#include <crypto/md5.h>
>>>  #include <crypto/sha2.h>
>>>  #include <linux/file.h>
>>> +#include <linux/fips.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/namei.h>
>>>  #include <linux/sched.h>
>>>  #include <linux/fs.h>
>>>  #include <linux/module.h>
>>> @@ -90,61 +91,22 @@ static void
>>>  nfs4_reset_creds(const struct cred *original)
>>>  {
>>>  	put_cred(revert_creds(original));
>>>  }
>>>  
>>> -static int
>>> +static void
>>>  nfs4_make_rec_clidname(char dname[HEXDIR_LEN], const struct xdr_netobj *clname)
>>>  {
>>>  	u8 digest[MD5_DIGEST_SIZE];
>>> -	struct crypto_shash *tfm;
>>> -	int status;
>>>  
>>>  	dprintk("NFSD: nfs4_make_rec_clidname for %.*s\n",
>>>  			clname->len, clname->data);
>>> -	tfm = crypto_alloc_shash("md5", 0, 0);
>>> -	if (IS_ERR(tfm)) {
>>> -		status = PTR_ERR(tfm);
>>> -		goto out_no_tfm;
>>> -	}
>>>  
>>> -	status = crypto_shash_tfm_digest(tfm, clname->data, clname->len,
>>> -					 digest);
>>> -	if (status)
>>> -		goto out;
>>> +	md5(clname->data, clname->len, digest);
>>>  
>>>  	static_assert(HEXDIR_LEN == 2 * MD5_DIGEST_SIZE + 1);
>>>  	sprintf(dname, "%*phN", MD5_DIGEST_SIZE, digest);
>>> -
>>> -	status = 0;
>>> -out:
>>> -	crypto_free_shash(tfm);
>>> -out_no_tfm:
>>> -	return status;
>>> -}
>>> -
>>> -/*
>>> - * If we had an error generating the recdir name for the legacy tracker
>>> - * then warn the admin. If the error doesn't appear to be transient,
>>> - * then disable recovery tracking.
>>> - */
>>> -static void
>>> -legacy_recdir_name_error(struct nfs4_client *clp, int error)
>>> -{
>>> -	printk(KERN_ERR "NFSD: unable to generate recoverydir "
>>> -			"name (%d).\n", error);
>>> -
>>> -	/*
>>> -	 * if the algorithm just doesn't exist, then disable the recovery
>>> -	 * tracker altogether. The crypto libs will generally return this if
>>> -	 * FIPS is enabled as well.
>>> -	 */
>>> -	if (error == -ENOENT) {
>>> -		printk(KERN_ERR "NFSD: disabling legacy clientid tracking. "
>>> -			"Reboot recovery will not function correctly!\n");
>>> -		nfsd4_client_tracking_exit(clp->net);
>>> -	}
>>>  }
>>>  
>>>  static void
>>>  __nfsd4_create_reclaim_record_grace(struct nfs4_client *clp,
>>>  		const char *dname, int len, struct nfsd_net *nn)
>>> @@ -180,13 +142,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>>>  	if (test_and_set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>>>  		return;
>>>  	if (!nn->rec_file)
>>>  		return;
>>>  
>>> -	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
>>> -	if (status)
>>> -		return legacy_recdir_name_error(clp, status);
>>> +	nfs4_make_rec_clidname(dname, &clp->cl_name);
>>>  
>>>  	status = nfs4_save_creds(&original_cred);
>>>  	if (status < 0)
>>>  		return;
>>>  
>>> @@ -374,13 +334,11 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
>>>  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>>>  
>>>  	if (!nn->rec_file || !test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>>>  		return;
>>>  
>>> -	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
>>> -	if (status)
>>> -		return legacy_recdir_name_error(clp, status);
>>> +	nfs4_make_rec_clidname(dname, &clp->cl_name);
>>>  
>>>  	status = mnt_want_write_file(nn->rec_file);
>>>  	if (status)
>>>  		goto out;
>>>  	clear_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
>>> @@ -601,10 +559,15 @@ nfsd4_legacy_tracking_init(struct net *net)
>>>  	if (net != &init_net) {
>>>  		pr_warn("NFSD: attempt to initialize legacy client tracking in a container ignored.\n");
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> +	if (fips_enabled) {
>>> +		pr_warn("NFSD: legacy client tracking is disabled due to FIPS\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>>  	status = nfs4_legacy_state_init(net);
>>>  	if (status)
>>>  		return status;
>>>  
>>>  	status = nfsd4_load_reboot_recovery_data(net);
>>> @@ -657,25 +620,20 @@ nfs4_recoverydir(void)
>>>  }
>>>  
>>>  static int
>>>  nfsd4_check_legacy_client(struct nfs4_client *clp)
>>>  {
>>> -	int status;
>>>  	char dname[HEXDIR_LEN];
>>>  	struct nfs4_client_reclaim *crp;
>>>  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>>>  	struct xdr_netobj name;
>>>  
>>>  	/* did we already find that this client is stable? */
>>>  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
>>>  		return 0;
>>>  
>>> -	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
>>> -	if (status) {
>>> -		legacy_recdir_name_error(clp, status);
>>> -		return status;
>>> -	}
>>> +	nfs4_make_rec_clidname(dname, &clp->cl_name);
>>>  
>>>  	/* look for it in the reclaim hashtable otherwise */
>>>  	name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
>>>  	if (!name.data) {
>>>  		dprintk("%s: failed to allocate memory for name.data!\n",
>>> @@ -1264,17 +1222,14 @@ nfsd4_cld_check(struct nfs4_client *clp)
>>>  	if (crp)
>>>  		goto found;
>>>  
>>>  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>>>  	if (nn->cld_net->cn_has_legacy) {
>>> -		int status;
>>>  		char dname[HEXDIR_LEN];
>>>  		struct xdr_netobj name;
>>>  
>>> -		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
>>> -		if (status)
>>> -			return -ENOENT;
>>> +		nfs4_make_rec_clidname(dname, &clp->cl_name);
>>>  
>>>  		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
>>>  		if (!name.data) {
>>>  			dprintk("%s: failed to allocate memory for name.data!\n",
>>>  				__func__);
>>> @@ -1315,15 +1270,12 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>>>  
>>>  #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>>>  	if (cn->cn_has_legacy) {
>>>  		struct xdr_netobj name;
>>>  		char dname[HEXDIR_LEN];
>>> -		int status;
>>>  
>>> -		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
>>> -		if (status)
>>> -			return -ENOENT;
>>> +		nfs4_make_rec_clidname(dname, &clp->cl_name);
>>>  
>>>  		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
>>>  		if (!name.data) {
>>>  			dprintk("%s: failed to allocate memory for name.data\n",
>>>  					__func__);
>>> @@ -1692,15 +1644,11 @@ nfsd4_cltrack_legacy_recdir(const struct xdr_netobj *name)
>>>  		/* just return nothing if output will be truncated */
>>>  		kfree(result);
>>>  		return NULL;
>>>  	}
>>>  
>>> -	copied = nfs4_make_rec_clidname(result + copied, name);
>>> -	if (copied) {
>>> -		kfree(result);
>>> -		return NULL;
>>> -	}
>>> +	nfs4_make_rec_clidname(result + copied, name);
>>>  
>>>  	return result;
>>>  }
>>>  
>>>  static char *
>>>
>>> base-commit: 0739473694c4878513031006829f1030ec850bc2
>>
>>
>> -- 
>> Chuck Lever
>>
> 


-- 
Chuck Lever

