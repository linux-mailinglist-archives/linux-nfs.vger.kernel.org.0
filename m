Return-Path: <linux-nfs+bounces-15366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686FEBED806
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 20:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B735845DB
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA0243387;
	Sat, 18 Oct 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AdalYD20";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ijamxk+n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C24924293C
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760813952; cv=fail; b=E6anPu7AjDSGwegO0LdTqMrizJtR9WL46vpq1U1H/armaDphxMvpYTsTEqU52gpl780Rd+QXOErWyOcKEP0kKp0ApYca4k6wVKMS1E9KifNmNqA7NzYIA06WcxDztW5VKJDXa6C2fhGXwlj81b3CGij8NWM4FHDOJEXDyBUG7MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760813952; c=relaxed/simple;
	bh=VnlKjsE+Fk+CvyI8O2PwH2q/A0WWmbssGlLeMqdziZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PcU9Xrr/nZ/uCpGevy4Xeu0HXgisPhrEV4bCJ85q19BZ+8uW6yXZRxgI/NqQVS3cYcR8aZOzHF6G64vof51pgbks3xShL5X8y878PwoSfyCo0RILQ9ZMevzKKhaMrORkSRTxUFcbIotmuNF+sKx97dgKjuxPrO9qMSEFCh7LR9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AdalYD20; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ijamxk+n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IFdhNp023365;
	Sat, 18 Oct 2025 18:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3pBxCzDpxS/JvH6skmiWL79u3MHHNbwi/vyLJMchtK8=; b=
	AdalYD20DpA0LjDAo6uSSE/h6aYu+OZzA8aeiUVT73rkkz9FUu361nLCvycJKzZq
	nK+7+Kis4zYoIFR2FWJULbHbFCkAIE3IY3SThNVg91AJKrCT3ORivzP3EpzJNqUa
	IXilKH8kl5hqzn99KcvdT4htRYWarSHFNcyOTYJgSImYOFonRO5rQIbCwHeYbgmi
	wl5/2zzy4OexK9q8OSwKKoYQfX8VjUss0ndUJ2Y5NudOCNs29/qVZWJgiYS2ojWD
	YKR7xy6eo6od/L2tHNQj9oQIR/xD6aQZpegD1i0SrYJhmDxbfsfq8V4MuAdKMf0Q
	3Sg8WDDeYyK8LfuK7x4JKg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d0fmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 18:59:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IIGlqb035288;
	Sat, 18 Oct 2025 18:59:04 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bafcyv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 18:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVukIeXxUTDkYJ6y8omPbg6obB+rSWOSt31WN76ChUpJWtFtOh0Hg+ZqiJPJKod4gUwDzJvcU3vAPmlWt1iFD0bvUupHb2Nt8BGhU7cqAiecVIZSCKgfHCyorTQ9cS74ZjfnBtoEkHdnKj9tG0ZNlBLtGZaEe84f9EFCRDA17w2tSu326MTWQP2gyEWNK/aYf1qzq+IK0MUfZAKB/lOlmp5OB1ePccMkViIdNahYZR37v/dAjbuJ1PIG0+kvenkki2h3kbwq4vR4uiZcVJ1y+KXCf4sUxfcHu1/b1Z5Yd+PUcX1hIn4WzE7X9iiRHeAcsSJxDzJU7y5l27ZRO+KUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pBxCzDpxS/JvH6skmiWL79u3MHHNbwi/vyLJMchtK8=;
 b=q6XTBSQ8Ipv47R+MyHgyILSKRE66vRHCbmzXcT1fGIvJPnag1YdRoovEvb/H/t/XAonhoViWz9XSGMblFX4DgqpZe7EpCcJyQUOgPW6qJUcEysHx9kwuVXmqjiTnHzLAE8ffqTudAscQ6HciqooUn6FIh8PobzdjU2kIJBrq2B4Rv50psWSKl7w6H1RYdHpbSCcn7M1kboRAgd/Ge4CsJPb/FPzxtiDTp46VKXfF6OJkYZ9L/cnYNi07D2xhsQniyinkYJJVZrYRm9jUAndMWYQhFgVkVw4+YXtCSuAkdrH1rmLGcbH2XRyxR+XU3AxAxIE2InfahXZWrzx2gQJ8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pBxCzDpxS/JvH6skmiWL79u3MHHNbwi/vyLJMchtK8=;
 b=Ijamxk+nxAruyQGMDqusx+5ttsKBsM1iNzt8CS8uEjWdsqeu3CtobKsFMoplq1rECwgsfjtsiBwZxe0O5n2H7GnRgS29VHUd5CJdHmKGF2yUIE1Zl4lK7Cr2MLpgacrh59qvaIMzu0TxLLdtpzlTd7Q6lgZsO3HOM9XcsRO920U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7299.namprd10.prod.outlook.com (2603:10b6:8:ea::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.14; Sat, 18 Oct 2025 18:58:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 18:58:59 +0000
Message-ID: <88778ac6-b616-4a1b-9607-4112a059bf1e@oracle.com>
Date: Sat, 18 Oct 2025 14:58:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] nfsd: discard ->op_set_currentstateid()
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251018000553.3256253-1-neilb@ownmail.net>
 <20251018000553.3256253-4-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251018000553.3256253-4-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:610:54::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2eb556-c7f7-4b19-c6db-08de0e78659a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?a2Y1MHFKYzA1L0RxTTNZUmUwWXlzcFBLVElhL1E1cktxUTFLTFZIN0psN1NL?=
 =?utf-8?B?RlVEbjM0SXlLWWF5ZUlrTzZxeWx2cmkyWnJkQzB3aFBQOGEzSGg0cUtJLzBz?=
 =?utf-8?B?bEpuak9pbTZQb0ZXVG9iRjVvN0dFRTJFSEphdGErZFVkTENBY2d2WUF3emgw?=
 =?utf-8?B?UG9HVlBjdzJkVzdNcnBKakNKSVFsYU9pTGRsNmVEdEVPRUxKdG1TU3BLVFEx?=
 =?utf-8?B?cWxjY3pneCtxU0czejltN1FnYjdSU2JlOGJqQmRxZEFsaXRZYklKVUdvNjEx?=
 =?utf-8?B?eWtrWlkxRlFyeTZIVWhlUkljN0tZdU9wY2NOZzA5WmlNdmlYRTNwcWViUUh6?=
 =?utf-8?B?S1ZzWXdRVUxwN0tFQzM4ZXIvaWZkcHc5dXByM0h3U2pCU0hVZVMwMWpJS1lh?=
 =?utf-8?B?RmxtbEsreGpzWEg4VTRhRk5GVGV5VDFFdHRUbWQ5MGpYSXMwUThIYUx1aEN6?=
 =?utf-8?B?YnNNa2t1QVBMait6QVpBM1dJQko0b2MzQm9uUXdaTXlwMkVIbU5oRFpMTnBB?=
 =?utf-8?B?QVJOMHlRZXBYNXVKb21HT3IrTDd2UVJnQ2dnYll1Q1NaSmxkeDNkbVVqRXl3?=
 =?utf-8?B?QjV4ZWtYTlRBYUJjVmdkRFdVM0dFYk5HZ25EQzNoZUdjcTE4dWJUT211a2VE?=
 =?utf-8?B?SW14cEFYVmEyWXpraGFMb3EzM1M5dE1DTlRPZVBpZXhKSCtsUmZNQ0R5V1pD?=
 =?utf-8?B?bHpTai9rSHd5bU85S1dWNnRTQk1wWkc2MzFYR1NMWEVjUy8zWjl3REdzNzZ3?=
 =?utf-8?B?clVHUVVjRERzRVZUMWw0d1pvam1CR0VQeUxGTjhUYStnLzZpRjJ2emlGQmNi?=
 =?utf-8?B?MmVta05qS25EdVpwdEt3cC9Cd05mNHR4aHozSlhmVXY3RUd6ejU1ejBhdnls?=
 =?utf-8?B?aGNtMDkxQ3VHdndpcXdzWC9kMjFWTGxlYktlOGxlTEpOZ29IVFEyK2RQaW91?=
 =?utf-8?B?VHQ2akJxd1NLeThFdmlsUS81SVZWMExla0loRTdMaHR3T09jWTY2QlNNZzBv?=
 =?utf-8?B?SGVxOHUzRGI2cC95L1BLSWQ5UXN1L09NU3lkMWMvK3NrMWVEQlBwWWQrWkYy?=
 =?utf-8?B?MitGVlpmOG9rTURpeHowam9XSy9tSmVVRFVPQldmOURwVk9FM1Y4eDRCdi9o?=
 =?utf-8?B?Tm5KMmtxTENlQ1dYN05hc2Zqd1puSGg1dGEyb2x1V254QktOZU1GNko3TVVs?=
 =?utf-8?B?RFJnNVQwRUVRWm0vUklDcDNCWGxEYTdkZDdCamllM3VjNWZ0anYrL09kcW0x?=
 =?utf-8?B?SlZ0QzhKSlZtZDFSaE8wYm9zZlZVOGhtYnZraDU5cUlTVEJQd3drVVJyUVpW?=
 =?utf-8?B?V3JrU3VpUWw3cUY5R1lsUytXT0RDa3NPK0RIczhxZjhaN2YwdWYrNmxmY2k4?=
 =?utf-8?B?SVB3UWtsamx1SDQ3SmdjV0x1MzVkTklxMVE3aGgxek5lOFZCb0prZmFndFpE?=
 =?utf-8?B?ZlVDZUhHVGR6V1RRbXFiU2NYQ3Bjbms2QlYydXFlbWNvaDd5UHN0ZkY0M3Fk?=
 =?utf-8?B?ZUNYRmZYeURyZWVlR1Jiekd1UHd2VHNvTDM2SFpGbmFNL01NUlFNclFGb0Qx?=
 =?utf-8?B?K1NBTEJnMmZYdEFQNXdlQU5JRVhSWlJ2em5rTjl4RGl2WlNXZzd6eVdScXc5?=
 =?utf-8?B?dlgvd29pdGlwQ01QSWJGZkY0TEdxa1NWY2Jzdjk0YnhybGJWeUZ6eVJ5NURB?=
 =?utf-8?B?NTZ1WUFPZXlOTXFHdVg0cmYwZHU1RktOWEZIaUF1QmpuOWRYekdlMzdWeVUx?=
 =?utf-8?B?aFdyU2ZhOVYvYXhaczZGM2xZQWR2MmR1UDNkRTVKT3g1OXh5ZmgzNXA3TVFn?=
 =?utf-8?B?SkVQUm9kMHRlcGRiZVhySTBacjBIc3J4WWx2bkNId205djk3ZmNKdFZsOVhL?=
 =?utf-8?B?TGtDVFJrUWNEdUY5aVk2Q3UzRG4veDE2WHErYllOKysvSXBVdHJJQVhEaEFm?=
 =?utf-8?Q?amJbaorfWZTpL50GviFJUfGJ7O0pERAM?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b1hDbHM3ZHVEckg2OGFJMHNhR0h0WjdtbGFobzFjRm5FZkszMmU3NTIyb2dL?=
 =?utf-8?B?UUFvbWRMNms4d2F4c0UwL0xGNE5wUHE2aVEwV2pCUnJHdklldXp3MjV2b2VG?=
 =?utf-8?B?Tk9SUE5idGw5ZWNhcTlCYzJRL1YvanliRnpmSlRqQUFRVndHNlBScWNpdVpj?=
 =?utf-8?B?Q0Zjb2V3SzdkZUYrWGZrN3FWNXV1MXRkMkUzRmVxN0plb0pXaGRvRXcwTHpk?=
 =?utf-8?B?OFo3WW54dlRoRlpBTTJTN3lDS0ExM2ZoMzE4OWJQUmRWblhMTWYrYTg1bXhT?=
 =?utf-8?B?MjN5cWtMck9pd0dCLzlmdVI2dDNJZHc2c05ScVNPM24zdlZENnNYN295Y3Ev?=
 =?utf-8?B?UjQrUW5pRUp2VXJMa3V0dU95L08xYkRnWWRXOGZxd1pYeW9zMlM5Y21MVkVE?=
 =?utf-8?B?OExzUVM4RVJrcENJZHhJdFY2N0pVMXNLOGd5ekxzQXZXdGU4MUVaOXR4cTZt?=
 =?utf-8?B?LzdNRTIwanV4MSt4NFE1cjNndXhOWHhnNTErL0ZJdnNFZXdyY2NjaXVZeGQ2?=
 =?utf-8?B?U1kwZDZkNk9Qb0c2WjFsbm4weCtuMEtCa1BiUEw4UGROT0ZKYTRndHNhcnEr?=
 =?utf-8?B?Z1BrU3BSaEh0YW5EQmE5Q2craWE1dFpVMTcrbWpROFFacTJuQmY1ZFUyUnI3?=
 =?utf-8?B?clIzNGhlUU9JREZ4SW9xSGlYOUhmVnRDS3JZZnNYSVFsREZ5K2FNaXBQSi9K?=
 =?utf-8?B?ZnF6TUVhbnJPWTFtL3k2eGMzY3dURkNBaDNDOFFQQmxIWTZJbWVTTjU1NjdI?=
 =?utf-8?B?UzVTaGgwcitMbXFjRmVYWFgyd0JTbWdYQnJoZnhURGxsT1NHYnd6cFBteUd6?=
 =?utf-8?B?eG1mOEJFTFZIUkFTOWtBeVZ1dmVCamo3TkZma0Z2aWVobCtPdXRVRFpYaW1a?=
 =?utf-8?B?R2FzbDFjSVd5bzBtaTNxN292VlcybDRnMnlpKzFGRnVkc3g2YVA0NzRScTN3?=
 =?utf-8?B?bGs2SElKOUJwNjN3Q3c0K1h2OUFNT3cyQ05OaGUzN1A3T1RmNFhub2tXOGFT?=
 =?utf-8?B?RzNpdFRGTmttaC85dU9zdXBjQ2owUGorZHFwRUplSzlKQlh3OFpnQXQ1QmEx?=
 =?utf-8?B?TllKNXJnZk9IM1lmTDZ0VUlnb3FuaHZmcm5pNURWdFQ3MnFReGdWalNYcjZC?=
 =?utf-8?B?VGNYVnJ4ako5ajFvaHRBNisrUTQ1M0N0VHN3THNidVNnRnU3dWQwOWM4bkRj?=
 =?utf-8?B?Z1FqZ0plZHZDbk1qbVQybkpVeEdqaVhxTVlzT0hrcWJnUWRDNTFzV2xyWnBj?=
 =?utf-8?B?R3ZpM1RDUzVEemQ1ZkZqLzh5SjNEWFk2a2VrNG5uUGRmSi9sR1RScUI1cG1P?=
 =?utf-8?B?dkJKdlo3dkp1ejg1d004dGhQRkpjeCthMldwWjY3NmM2cUNRa2NLV2J3TWNI?=
 =?utf-8?B?Nld6ZEpyeHpsY1JMeWt4a29rSnV1NitnTlZBcUNBaWR5d0p0S2RPSmltUmlk?=
 =?utf-8?B?VUVHSjRWR2pCZGhiRVhaTUdxRWpQYkYvdTRVeVdEanh5L3pZa1FhaXE1Mk1Q?=
 =?utf-8?B?MHQzUHh5cGo4VWJIZ1kzV0ZzZ25vWEhmUFZXbWJpc1NvR3ZKVk1jbnhWV0g3?=
 =?utf-8?B?aXpYMDBhRUxiVCs0d2tPUTk5Vi9FSkFRZTAvbDRINzJodzR1N3pIOFMxUlZD?=
 =?utf-8?B?ditDNk9BcXZBUjdnQzYvbGZJczBxd050aWhmV3ZLWUpvaVRyMFF4czBFVkJr?=
 =?utf-8?B?K1o3Z0V6emJvcFFXTHNRd2d0MVh6RisvVFhiMjNyZHYwZnBCUXBETlgzUWxF?=
 =?utf-8?B?dHNaUG02R1NobWhBQUVSbVlrWkhFL2lkRlR1bnJuSGJIc0dRVnpOemttMWxT?=
 =?utf-8?B?WitrWTF3WEJVT3d1cTlyQ24ybkxaem4rMWszSGFCNGx0dTd0d1R0aGFvcWl6?=
 =?utf-8?B?MXZRczBFNVAzY1BrZEhWUWk0TFRQMStaQ3d1VkRDMlQ5bzJXSkg0UmNIYU41?=
 =?utf-8?B?OG5qeWk0WE8vYTFkS2NtcldrWjRFLzFWdnRrYUNYSS9GTmdIdVhQNGRTT1lj?=
 =?utf-8?B?VlU2bG44TTI4TnV5S0pYUHhEVXQrZ3diVDMyT0RhdGhwT1JzUk84VitlV0ZL?=
 =?utf-8?B?TmZUU2FhRTNaZ2dNRHp3SmVIQWZUVVNlVTgxNjZVbkpjYTlpNWcyQnltOGVJ?=
 =?utf-8?Q?BSQkXg3fNvVOwOBuCZsSsnK/H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HvVllPJac8Q5L8yIJIqRbpVL3Cp0cg/QOUAoQsjY+FRbbqtAmlVHVTT1NGgAuWRtxq/BtIMxCErv12Mfv7uYmx+ELYMRN6ypvIi6UI19kw9AAkJgFz/YAv1EtXFS+RXncz4t7xWkltVTVKcoT24AKElfUvORbcfuf4mkVTur39PxNrJsSLEXf8kb7JyKtavTugMJP7JT7GcyY45ERTC5dvZ1OBMe5XI1JGCdsXonTQg2lFa8gwbcS0oF2LV4UtneU7xOSh1PBlqO7xVP4Hw2mLEaRd3cLPsOscXOMZGiOEViabu9aewemDzPGBJ0lII+v1wiYvOi2AuQHraJXW+jP6C0zovA1mK0XbHqJ+Cqycu6lU+uKytXd1+H3SDq+Tlg4S+wQhSj7SJLj7+2gK5oLMEVpznUGTbppaZAonY9mXyJNApC8WHN7C0mPEWs3ycc4HqChag1djMpyTLC53LY+f6qgA3k7EH7oNoMkhQBelVNoqSkhrm1K1W/5eCG5pP5KzOZcFkOXj1pfA7GPnZK2dOqKQLVPMJO10aKwz+ckSDLyq6uk/nx05VumGMZ9G8P8rt/t8wxW0ka+XX5ByeGSgG0uqxG59HdhrAm1Wh/T0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2eb556-c7f7-4b19-c6db-08de0e78659a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 18:58:59.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NewARswKKf3pbEaRVHcsDfS5h4gMMI9as/GQZERxw9nrEohKnjgoDC9sSFO0IdbclB4kk0nFyhGSBc8+Vt8pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXzbuLhOaYUgGn
 Kc4LKHuUlQeFngEMhWQGoRb9nF272gquJrfbe2UXDHd0m5l1hDUNOCLuCd8++Y6xVF0y0fSmwlf
 bYXLov5fonv37V4e+jY0+nRHlhKNt+Kn/90CJ5vDgD5nJBwDyVj2SbrEIcT3hsFBwCOFWErcVAT
 pcXb6AzCt52N6GHStHv0IfnKhn3x7PknIbTYx1odLDBRsoSE0E79zUJ80P76uCAi3wGYJQZLECc
 /jHqaihJWmf3mJnN0nttljZIkUWnjvaHnqhEG2Kfj14VICMQxJ1Nyxe6STWd/EUSk3SVJzBz/bi
 TKKJFM9pJnT1sZZlWeYGWgtT+BWHOb1bYrQzTeqMqh5NM/rff57+mdByONG4h8JB64KuuiFj6q9
 gO29mx/fZa1RslJgpGLDminBASml6FCND5kCH+CkUH1PgpI2Ys8=
X-Proofpoint-GUID: DwDmvhMxNYZhacHbNJS8dNLqW9ckaZf4
X-Authority-Analysis: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=68f3e379 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AAPDuCGAUpwqD5ExMoIA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: DwDmvhMxNYZhacHbNJS8dNLqW9ckaZf4

On 10/17/25 8:02 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> It is not clear that the indirection provided by op_set_currentstateid()
> adds any value.
> It is only called immediately after the only call to ->op_func() if that
> function call returned 0.
> 
> This patch discards op_set_currentstateid() and instead interpolates the
> contents (each a single call to put_stateid()) into each relevant op_func()
> 
> Previously the put_stateid() call was only made on success.  While it is
> only needed on success it is not harmful do make the call in the error
> code.  It simply copies a stateid (which could be invalid) into a place
> from where it will never be used, as after and error, no further ops are
> attempted.
> 
> So the new code calls put_state() without checking 'status'.

What kind of testing can be done to ensure this part of the refactoring
is safe to do?

One more comment below.


> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/current_stateid.h | 12 +----------
>  fs/nfsd/nfs4proc.c        |  8 +-------
>  fs/nfsd/nfs4state.c       | 43 +++++++--------------------------------
>  fs/nfsd/xdr4.h            |  2 --
>  4 files changed, 9 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
> index 7c6dfd6c88e7..8eb0f689b3e3 100644
> --- a/fs/nfsd/current_stateid.h
> +++ b/fs/nfsd/current_stateid.h
> @@ -7,16 +7,6 @@
>  
>  void clear_current_stateid(struct nfsd4_compound_state *cstate);
>  void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
> -/*
> - * functions to set current state id
> - */
> -extern void nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -extern void nfsd4_set_openstateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -extern void nfsd4_set_lockstateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> -extern void nfsd4_set_closestateid(struct nfsd4_compound_state *,
> -		union nfsd4_op_u *);
> +void put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
>  
>  #endif   /* _NFSD4_CURRENT_STATE_H */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 41a8db955aa3..5b41a5cf548b 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -644,6 +644,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	}
>  	nfsd4_cleanup_open_state(cstate, open);
>  	nfsd4_bump_seqid(cstate, status);
> +	put_stateid(cstate, &u->open.op_stateid);
>  	return status;
>  }
>  
> @@ -2928,9 +2929,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  			goto out;
>  		}
>  		if (!op->status) {
> -			if (op->opdesc->op_set_currentstateid)
> -				op->opdesc->op_set_currentstateid(cstate, &op->u);
> -
>  			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
>  				clear_current_stateid(cstate);
>  
> @@ -3367,7 +3365,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_flags = OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_CLOSE",
>  		.op_rsize_bop = nfsd4_status_stateid_rsize,
> -		.op_set_currentstateid = nfsd4_set_closestateid,
>  	},
>  	[OP_COMMIT] = {
>  		.op_func = nfsd4_commit,
> @@ -3411,7 +3408,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  				OP_NONTRIVIAL_ERROR_ENCODE,
>  		.op_name = "OP_LOCK",
>  		.op_rsize_bop = nfsd4_lock_rsize,
> -		.op_set_currentstateid = nfsd4_set_lockstateid,
>  	},
>  	[OP_LOCKT] = {
>  		.op_func = nfsd4_lockt,
> @@ -3447,7 +3443,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_flags = OP_HANDLES_WRONGSEC | OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_OPEN",
>  		.op_rsize_bop = nfsd4_open_rsize,
> -		.op_set_currentstateid = nfsd4_set_openstateid,
>  	},
>  	[OP_OPEN_CONFIRM] = {
>  		.op_func = nfsd4_open_confirm,
> @@ -3460,7 +3455,6 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  		.op_flags = OP_MODIFIES_SOMETHING,
>  		.op_name = "OP_OPEN_DOWNGRADE",
>  		.op_rsize_bop = nfsd4_status_stateid_rsize,
> -		.op_set_currentstateid = nfsd4_set_opendowngradestateid,
>  	},
>  	[OP_PUTFH] = {
>  		.op_func = nfsd4_putfh,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 18c8d3529d55..59abe1ab490d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7738,6 +7738,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
>  	nfs4_put_stid(&stp->st_stid);
>  out:
>  	nfsd4_bump_seqid(cstate, status);
> +	put_stateid(cstate, &u->open_downgrade.od_stateid);
>  	return status;
>  }
>  
> @@ -7822,6 +7823,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	/* put reference from nfs4_preprocess_seqid_op */
>  	nfs4_put_stid(&stp->st_stid);
>  out:
> +	put_stateid(cstate, &close->cl_stateid);
>  	return status;
>  }
>  
> @@ -8457,6 +8459,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	nfsd4_bump_seqid(cstate, status);
>  	if (conflock)
>  		locks_free_lock(conflock);
> +	put_stateid(cstate, &lock->lk_resp_stateid);
> +
>  	return status;
>  }
>  
> @@ -9082,13 +9086,11 @@ get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
>  }
>  
> -static void
> +void
>  put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  {
> -	if (cstate->minorversion) {
> -		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> -		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> -	}
> +	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> +	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);

I'm not following why the above change is needed or safe ?

I'm OK with removing op_set_currentstateid, but let's dig into these
two issues to ensure that this patch handles all the corner cases
properly.


>  }
>  
>  void
> @@ -9097,37 +9099,6 @@ clear_current_stateid(struct nfsd4_compound_state *cstate)
>  	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
>  }
>  
> -/*
> - * functions to set current state id
> - */
> -void
> -nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	put_stateid(cstate, &u->open_downgrade.od_stateid);
> -}
> -
> -void
> -nfsd4_set_openstateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	put_stateid(cstate, &u->open.op_stateid);
> -}
> -
> -void
> -nfsd4_set_closestateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	put_stateid(cstate, &u->close.cl_stateid);
> -}
> -
> -void
> -nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
> -		union nfsd4_op_u *u)
> -{
> -	put_stateid(cstate, &u->lock.lk_resp_stateid);
> -}
> -
>  /**
>   * nfsd4_vet_deleg_time - vet and set the timespec for a delegated timestamp update
>   * @req: timestamp from the client
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index b94408601203..368bad2c7efe 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -1043,8 +1043,6 @@ struct nfsd4_operation {
>  	/* Try to get response size before operation */
>  	u32 (*op_rsize_bop)(const struct svc_rqst *rqstp,
>  			const struct nfsd4_op *op);
> -	void (*op_set_currentstateid)(struct nfsd4_compound_state *,
> -			union nfsd4_op_u *);
>  };
>  
>  struct nfsd4_cb_recall_any {


-- 
Chuck Lever

