Return-Path: <linux-nfs+bounces-4994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D309378F4
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5486328188B
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BC314532F;
	Fri, 19 Jul 2024 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DVSn7jAl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tVce0CRo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E1B1448EE;
	Fri, 19 Jul 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398177; cv=fail; b=sMAfDQjuvMsidIy9OOySfZGVTkYceSJSackYcbbejq39F3GXobocqtl8xoDN7qmMcq8bJE2kjXFaYKEWeegJqoJf5UklFH4UCpIcNqDEzyIeCA4tArISV9qXh1qHsQoixwOKLQnlq0SO1o1IyDJj490/wuD8tlA3tRBu5krg7Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398177; c=relaxed/simple;
	bh=0SseJaOIPvoJz0NYYvguGQE6s+Uu8cVaWAOQfk1FQwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BLBxifmsCpAU3z++7QsdrpBWHecYhG3JkRV5XC5mBPeQwhKMk+1mBT1EGLVDveJxqdaFzQstFIDWCPNp5ryTloeESnPFAyYf5yVzA17+9mPRZsPtBy9WNbI/Kx7B+Jlz1Gt1gLm6dJIX4NQtU/wdYo/GpyuaTHaA40mxX894U9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DVSn7jAl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tVce0CRo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JE18FH003201;
	Fri, 19 Jul 2024 14:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=tpBGH1Kp6Wu8Fk4
	oIRNIbKNgZRxvtxDmdYOSD0FOIB0=; b=DVSn7jAlOEsvlOp5m3BVad7FATPfx4U
	W3gPIoEKcbcpaUwnS/2BIqyjLq+hvfi40evOdEyzHKAtjjrQ1yDVB1oxUv4SHSbU
	PXh92Js06JnaN+1Q+4u0xaIN3qkrU9Xe2ceFH33XyoOMb+KjhzelQLqWYZbVgbiU
	4Q0oBgWpR9OWyUUdap+EWOxGqdTnMqIU4tTp4MZppmWoyJma7JAWrkmil79Ujmhy
	fqQyH8n8LKiO+LoD/FeDN1WnrYXF/dnWtKO7xF5qtw8h+5jVbIPDG9vbPIBrkXMs
	52ZCUMSIJCJGjrZEPVjU/ZbFWiJL4OwAgvK0F/fV5Xmiz7uzpnqbPWg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fsh981v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 14:09:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JDZVCa020224;
	Fri, 19 Jul 2024 14:09:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf1srwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 14:09:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O76aj4mj7+6F6c2TXSXGmUhQ5T6LU+F1dPgsXkGCzQKM4m7ym+ohECpRkXAyuzoPo739668sjq43DDPYJ86EVr0hUOFdL6kTBNsXf123SiF4Y45cauWJHs938yuKbwwic9ghZ0mYTqRJhOkZVIYSEXQuvwm4/6WG2bQP4pbATf1ib+ETS+QowCByFKy0joCcpaiid5xhAh3iytaB1QoQRWSSgZN0YVU/3El3acNtn5u+fsOWKGLEtZW+Ib8qkpFi2yM2TV2VdiEgs8Lzy6z15WO2M9t8aVjJm78rcB9MJZyIvyB9zm3nNbjW4BbLHkU0LWL+RIUoLz/Bfv5XlEnrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpBGH1Kp6Wu8Fk4oIRNIbKNgZRxvtxDmdYOSD0FOIB0=;
 b=ZRVdADXjHy5CFj7a3Gigj75KQKPaKSg2DWVOUrC24SrETORDpM2K3AdIRxGKmGloHtaIbmMd4IUJYQQNuOcG+MLGRrxPDD1rPGKggpp19HNv1JeRY4aVBdsQDY+wxAnEoJr3/lffd66EmLR8EaWzoV7zXCSR6EMdRA4/IDTwEmmMqp8TEKiqvV3o+eMMEJxblVA8M+8WsEa3L8mJpRFxnRsSqxCBjCg2wDjYGWUrr0QGCnQyvJGWJ75e85r08fypMYnurXlJJ5G8YpYcnDfft/NHvfLIlmpMBz2cAFBK/cieq8FeJYEUCkBFkFPcYpfrGyWb24jeIAxI/ooKQcWDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpBGH1Kp6Wu8Fk4oIRNIbKNgZRxvtxDmdYOSD0FOIB0=;
 b=tVce0CRov7cZIMgPnBrYPf97v6D61vk2apOwe+JKBOv9TghLtGINxtHv37PLbh8kOql0lOYjP2zk6mYp6HatigUgpn2BLgQmWMgisx+2Zb/GVWCcnw4FcTlBLrfl/KCorwgFR0L/EgsYS+QjS8xnckILy9lYgg7vfgvcTCX7Ra8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6903.namprd10.prod.outlook.com (2603:10b6:610:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 14:09:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 14:09:03 +0000
Date: Fri, 19 Jul 2024 10:08:59 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: avoid -Wformat-security warning
Message-ID: <Zppze/qB2m9O0MH4@tissot.1015granger.net>
References: <20240719105504.1547187-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719105504.1547187-1-arnd@kernel.org>
X-ClientProxiedBy: CH2PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:610:58::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 83efab57-216e-47a0-d31c-08dca7fc57e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PIg5b4LCxQG+IsiI3BoT9qOL6PpQPU/T2QjH+1YJAnv78adDAdDrgF0Rfy4p?=
 =?us-ascii?Q?B2xwGJW0aRxtGmuEzclcRD82G8DV83CSmhVd6kHuOv6dlEAvo1vedrShdeAZ?=
 =?us-ascii?Q?aDadp4ZItcAKTATGN/UcQ8qruUcSCg8tJOvkDTkZal7YkW+pGiNHTntO8xl8?=
 =?us-ascii?Q?KvjWvDeqBO3AUmbLGnzhhdpkpZLH62xcQZdbjGRl3LxCmF7QTBwqc/Mc36xb?=
 =?us-ascii?Q?jRIZAyldZuzKHQ/VcV6iRSC6XHoncqiV4q34UgnPVHwEMQkYwG+zwNR8M+qd?=
 =?us-ascii?Q?CF1JVK95nP/qYe+9LKDyl36OO3MlIyqVYTo9CGr4Mld5I1jh2HiCvySw7vsM?=
 =?us-ascii?Q?/XWurN1y2uVhGRCJ9C5wgnSrPCNqRSv+AaCf6L76tCkJ22iUPxtxo40w0X6n?=
 =?us-ascii?Q?AY+9w4VMIX4bv8EBE/wIxad74Y+nqDLClfG4TQDwLhLxVcJ6iWqXe5jNhiGE?=
 =?us-ascii?Q?WiASFSyJngMqdVTFArmZSv+PDbjoFh5GioUR6eVQ+XDhoopZpqdwBU9HbLwI?=
 =?us-ascii?Q?IpZ6T+1jG/B3+mdPmbnZtCA4N/YkcSHFmkkGrGv9DBEsGQ4EtK0/X/YCGgWz?=
 =?us-ascii?Q?kq/Na+5oC61u9f7AXhF65paOrdH9WHIxHAmKhgcjmv9njX4/DMNrhM35T5Pj?=
 =?us-ascii?Q?lnLKpnIs3Ai9hOxZ47pPHIi0VsOWEccdDF7PTijVWK6d2vSIKdh48MawicYm?=
 =?us-ascii?Q?QF3sxeABevz9eJnHRjCga6vjAD8fEUNXJ8xhMwmJPJP5umVbja+qxT33sGeb?=
 =?us-ascii?Q?10HP356nO+keqVscQxqIXj4gw2pwS34sbxaOokThZ6j2H3FuvwSWWpO3eutV?=
 =?us-ascii?Q?AYPeeWje6r0L3RoLyer0EjoogDKhNbT6DcM0FCYGI+ja/tjzdxoxxlricDFL?=
 =?us-ascii?Q?MzH+UULt4xG5lhdh85FYXx61s1deRPEbVzk7swKuRup++5y5dHopbpCqpQ2X?=
 =?us-ascii?Q?C3a0WB5LaSBkq2RmIgpCyKxjtGnrYYnx07KPTe75hFbACsXup1Jv29EYWJwJ?=
 =?us-ascii?Q?0ls+pOR98oxGcQVSa/S6NURFaxeH7xKzHnJog6B7+BlrW11bSMRfztzCRVwP?=
 =?us-ascii?Q?b1xi4Gd9lfVcKWALSX0CRkU0C7dGXb8QZsdhzAUmy+HxP26nKmdPdMZvISWX?=
 =?us-ascii?Q?0AtxNWk1AJVgSDE5iSemz/r8W/SayetpUm6ENJRI68LXoOqg2Ajg31ekzjka?=
 =?us-ascii?Q?ODO+j4KZZiZPubd4trFYOzwLae19FmywXmdkyim6zBjkV0iZHk8ZV5JpomWM?=
 =?us-ascii?Q?m5hTp/VHjJ8Kpop8o9RQ11qxQ+SZ6XeEovIjCrTA10Mq8rnXUXAY5DQ7OQfD?=
 =?us-ascii?Q?BXrL1Ymk2dOu9i+VdHXbWl7QV7/Z1+uoOgV2Ckp4VqLe2A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YioufPgaUrdtDqLfJkT2S1i6YS0Us//bAxzBcBhwTabqnEgB0wYVqyPvZmKk?=
 =?us-ascii?Q?qlqirAkBC3MpjBbYUvBs+TqfI2hFAiGrktXeRP16mDbRNopZBVWW745dxnit?=
 =?us-ascii?Q?xKdplgr0YJSWksH6P5Xinwhb8+VFIFn5MYh7SBM2L3/r08RFaBJGxX7gdrIO?=
 =?us-ascii?Q?whroawL0z/yVPHpAeO7bMeVDm9e0Hl+ngY1eAyllAUwkjTCJ8wFHXl/dHUk6?=
 =?us-ascii?Q?ER4HoPAXE8K3wyX2lBhWCXd05M/wz3DnlCvCxdpe887zsYVGA/EYB7JT4keF?=
 =?us-ascii?Q?oI7yWZx06uDl73Xs4qRni4XDb4vxwsLofOsvYb3I5p+t4WnmS/2o1pbahmix?=
 =?us-ascii?Q?7UtebDX9gkOdwznaZSU7sSfEdcGZevDEdRFw8lVzW1g/iTt+5DuVQXXV9Nc2?=
 =?us-ascii?Q?h0vzoec6XDLI1ZS5OJb/CXmjMKUgjQ9ZuumasLsroEbOxM0VwMvHLPxQNxrk?=
 =?us-ascii?Q?NezU3fkkGQJ4hR9HZvt7SbvNcMneX9UGJ8fEhMpclvGGpKh8Rbdq9hfPuY86?=
 =?us-ascii?Q?szrxAt2NPlwODd+yepXlL4Et9d1YfsO4HxaKqQkmWkcQBqdehiO7tsp8Fvng?=
 =?us-ascii?Q?TPSSUzfdFdqwVE/t8+NOIqADhDIFHRLrz8jdTPWoHN8m2wu7hARbYrYDwcQq?=
 =?us-ascii?Q?kV/tLI+3kzpL4RFJmY4vWGRTJ7lNEmuM4S17w+/bsajxJE4JE7EaMzbpvQS1?=
 =?us-ascii?Q?teuKBIdf8/Xfz42mTPVMAXCAEJh5O+KPhujs0QwdMXjBGS1/XNGmhBg+LLtc?=
 =?us-ascii?Q?vMedw1SVH4PJD+K+Q6OlkZ8nbhs4GRiYDIZJRiQfp41WudKgkDWlZsSnS0P4?=
 =?us-ascii?Q?N9g86rgLMcDXu++oJ9y/hE+FAEfs/BUaRqIYwuTjN84R+h3rWqDcKH1gK/7V?=
 =?us-ascii?Q?ENxvCYvov/sJoFjlJYqyrAes7tU7R/gAUuduytOexznH/oTLnbm5Tx8fuNyn?=
 =?us-ascii?Q?VXKhs9MCi6aMMztxBcGE3gDiEn3aw3rLFj0tH2q65J4BcmzEGzybtseptFiu?=
 =?us-ascii?Q?RJ6V8Kjfea2kFPVJvcipNfh/D+M5X/Qv+CdOOk5+vNE6InjnTy9COTpYVHW9?=
 =?us-ascii?Q?gKi38snJP//PtL580Vo29Q654dORUoYst18CjVuH67BS6hIlZjju4WhU7snA?=
 =?us-ascii?Q?cnEw554oHGASk6L94MT+fU1ix1fgblTk1vSsTsdY9imauU70EPWNrS1K71yI?=
 =?us-ascii?Q?PsYDnWq2Sytzcy+2eafyoxVXvvzZhF+GsJrfebh2eoUAhoAwIxmjxb2q0zTw?=
 =?us-ascii?Q?gw9oVvrq/qh+V9SWeOZ398VxOi+Eu0wznu/zhqmT3LdVWaoRQ+A45Fa7O/A3?=
 =?us-ascii?Q?6vDXmgLJm8N53fy1nIaGjut8JaC1onDgnhPTaOOFE/lLAXuxtCdK74BmHwUa?=
 =?us-ascii?Q?qAPO7mO5TfypSYjtpsepKe91SkTBozOiMo+UIyVBef7ft2C5RVQpYv7nwK6X?=
 =?us-ascii?Q?gYxJk3TqLeKG81HALdPLxg+/KHU/RTYvii2WFebuoQtelHMG2EwBpfQteBW9?=
 =?us-ascii?Q?Z1rGWfP5VhGj8GO3rH+ywAqnmHlBsqC2F12GCgafvjKlvT4QfVChrf1IrNjw?=
 =?us-ascii?Q?f33mthuCGA1xwHka2YGhryvmJQoty4LbtFJ3ml3P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uA6piPZxFmSsNE8PoDM7OsjALCSZvSUzB46j+JfzIcfCPDfinbA2kCg/ZnS5FRrCRZ5g18nbj9kmwmLaKB2a9Uy6ZR1XhhdjB0G6QIk8SeHuP5VrECo32XqKcEf78WsE7bpcjmiPR8GI1e2/I0xXDWXhDTbElNZsZsbWrtjwH/aml97cX50gUVQV/naLh4fNYvwNw7tstFmQn/CY/HZL01HkczKYpJltT5KeohngqlhUglivYqohvFY8EJRO/X4AvtUK/kCGpLIooSW84aokh9mglV3sSxLRQmsZyj+LS4Kcyq6VlCInc6SFP2D5C5hWAwqnDzyx95+o2nEu2PLZLrtmouN5F0fSj3cs/fG2ujJpz/Z4CzTDw1wQWchHM06MyOOPUIaGRF8nos41VRLPrgaqlDwWDE6ogmcB8c4VzGmoOz8AX6GFe25R/6GwrnUOQGmwnrtqhzZi8skYpOZ8NeNHwaaoVVT7xj/G1LYHBC4daNUBHfkmMOBcakBnPi6zZX3fpaj2kHuAv4K8BoEB4quqDv3PZOU9useNwWbzS7xwlhlmsFyy+CyGZgacIzO7nunIq0R9ZzHYAHAfXLZoTqshzXRuPgS5J3J66A26B0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83efab57-216e-47a0-d31c-08dca7fc57e9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 14:09:02.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFrjbBrgclywCFbEucuXEa3gp8u6IplsUB2WpszV/8lxpVICqy+i3URnvst0LEkdQAUr9wUprhpJEpYakKuurA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190108
X-Proofpoint-ORIG-GUID: 0zX6s-mNwbTQMMaoRQR8dq0bqLkOH_KZ
X-Proofpoint-GUID: 0zX6s-mNwbTQMMaoRQR8dq0bqLkOH_KZ

On Fri, Jul 19, 2024 at 12:54:22PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using a non-constant string as an sprintf-style is potentially dangerous:
> 
> net/sunrpc/svc.c: In function 'param_get_pool_mode':
> net/sunrpc/svc.c:164:32: error: format not a string literal and no format arguments [-Werror=format-security]
> 
> Use a literal "%s" format instead.
> 
> Fixes: 5f71f3c32553 ("sunrpc: refactor pool_mode setting code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/sunrpc/svc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index e03f14024e47..88a59cfa5583 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -161,7 +161,7 @@ param_get_pool_mode(char *buf, const struct kernel_param *kp)
>  	str[len] = '\n';
>  	str[len + 1] = '\0';
>  
> -	return sysfs_emit(buf, str);
> +	return sysfs_emit(buf, "%s", str);
>  }
>  
>  module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
> -- 
> 2.39.2
> 

Applied to nfsd-fixes (for v6.11-rc). Thanks!

-- 
Chuck Lever

