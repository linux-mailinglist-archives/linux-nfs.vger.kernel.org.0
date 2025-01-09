Return-Path: <linux-nfs+bounces-9030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C906A07D01
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 17:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57C318844BA
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 16:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C321C174;
	Thu,  9 Jan 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ke0o+cN1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bhaHFd0z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323522069A
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438995; cv=fail; b=F0voNfpAzp50/zkoAHy/9UCwRUuTU/JH6EicycH0qx0jCUO0jbxsvVLUzp4r1T6YkBy2mAEoi+6rj6CI+zLeju5s/dxV8cAP+Bp5JxOzOxS72AyY/lSQ2tQVKUK5fwK0QMlWS3U7P+a0nkRekR3qeXlnuj63Xgjfn8iBzBoj+XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438995; c=relaxed/simple;
	bh=MoABrPkY4pQ+3QQEtB0Szx3L08yVPeWEvTt0L2yn+MI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mnaL/tjXq8FyC1P+Mt03lZRYtUS/wZ0rNz2rPabKVW8uexXztWqF5XadxRdRm3e6dwPjPHc446vAjQC4WzgnG9idEQ2z1u6xfAheJo7LPaentJ+JIsHl1vAB++OHMh/xrTsM6Mtlw5DGExCpoql2yHqI0F4e4bO7QpaQMyKA7as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ke0o+cN1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bhaHFd0z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509FtlJ6017238;
	Thu, 9 Jan 2025 16:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AswiMzP9885ICNPstcY9bp3pE8c/D52tGr9itnuG4vQ=; b=
	Ke0o+cN1DOhsonukJQznjU6ARRmkeQAgFx5x6ovY+ufJHGnmk9KU20FsqbmHtGQj
	s5DZlToe5ax5vClwBlG5wYAiUZ20t017ba08yKD+4M/C7dwzXx4gEpEzXRA8CFcD
	i8J3Xybn0stCi7JQn5Ojphmh7u36TiOXXhvFoaG/GJyZJMECtGOSnxPxHMsrfLNK
	pNL0lH4srI7q7QojtslZyNQOyyh0ZtLlLEWsPECyJSbrA9+7/B2rhYCBAdNkxhS/
	4Ll9kkAoy/4HSUhK3Twe/ZVU+1Yfn1BpZieRCbyKFCnxhV1vsfBMlf8/plmlaSsE
	5v+XMmxBv4d6o550voOzPw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442b8ugrhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 16:09:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509FUgS5027615;
	Thu, 9 Jan 2025 16:09:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuebh22x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 16:09:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxMY83cmHjI5N07zhAWyx3FJ3aTAD4HVYKSt179zwgZsqkMPooahdq57EmIVtRMQNfsakMuayuwXV7g/eyaYQSoFyy7dynfvOcVjXFpFpk0skIDiu44e7/AiV1+WvToyuIkdTNRQG7y1TKS7N9dt2JZvTczLo6xYlxKCQj/sI5wktlihmNCuKc37qagp1UhzStPgIACWKUK+ppASkCZQferdC4MAjeeCh7ES1mrJOVdPfN9nCrpioRwEfQwpSkgWjPxtLW6vvmh/thekmrdLH4HISg4ulMzf/D7j8xNfxS4EjG9Ohz8axy5od9NRdgctR1T+CMQR7YhfXu3JURXu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AswiMzP9885ICNPstcY9bp3pE8c/D52tGr9itnuG4vQ=;
 b=LgipUPYd54fYqtHFCyd5PnudhL6Pg1g4iFOWJV85jAb7u6ymWTdJjOP5G69V79eFguWWlkSdwv6rM4OCH/U+rVErFXZgH35XDhTibrj4d6PS77/5sE9/Ngwxuo7rHqHIA9uPZgryJLNfjZ6RoPWWbAGqJQCJhbN+naKAI2KOnXeq3agbM/1MlHrILm69qfpe8Gyd5HitLkJIwnPcljgTfxWLJhTlw7+m7SpWhBTd62t6fGRG2B6Qh7qchP0RKIBJ0wkBXYX2mPyPI+4R17YtrpTm/hifWrDiE1bhbZ4a5/gndoMpA5ZJAPpSSNRjO6IM78c1vw4uL4TEbeee3BRmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AswiMzP9885ICNPstcY9bp3pE8c/D52tGr9itnuG4vQ=;
 b=bhaHFd0zALpqB1fig0I1iWn8KPwET65Zy0a/KQ8w35BN7RfshSDjtq4JYAk/P61viJaV8Qy/rBbnMXgniw6xitLst4FY4MunEYbsLFpYF4ZP5PY6k7/4p+ujNsrxd5IevGI9A7GDMbdqQAnIla/ovvmd5sZ2vE4OCcM49lrJYyI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6326.namprd10.prod.outlook.com (2603:10b6:a03:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:09:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 16:09:28 +0000
Message-ID: <08f157a9-69fa-46ac-9282-87fd7cc74684@oracle.com>
Date: Thu, 9 Jan 2025 11:09:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
To: Christian Herzog <herzog@phys.ethz.ch>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Harald Dunkel <harald.dunkel@aixigo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Martin Svec <martin.svec@zoner.cz>,
        Michael Gernoth <debian@zerfleddert.de>,
        Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
 <Z32ZzQiKfEeVoyfU@eldamar.lan>
 <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>
 <Z36RshcsxU1xFj_X@phys.ethz.ch>
 <7fb711b1-c557-48de-bf91-d522bdbcc575@oracle.com>
 <Z3-5fOEXTSZvmM8F@phys.ethz.ch>
 <da2be7f1-3c05-4de7-ac22-fb4cbd4e52fb@oracle.com>
 <Z3_yQlGPLFoqY_Wl@phys.ethz.ch>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z3_yQlGPLFoqY_Wl@phys.ethz.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 805cd97b-3f9d-441c-c8b6-08dd30c7fe73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXZCdGFRVWFSTjhvNDNVY2hmZ2ZWM3hwTk9UT2IyNnVtalp0Tk5tWVdDTVlC?=
 =?utf-8?B?T3llYjExQWppZGl1YXZ6Wkw5cHdvSEtJRlVzbndobDlBenUzdWdWWjFramVZ?=
 =?utf-8?B?NnVrelRPM1FWTTQ0QlZmcjJUdzBSY0xLbEZ5TS94SExIbXBSNEUyeHZCeWN6?=
 =?utf-8?B?QXh4V3hMb1lsR0lCTnpubjlMNXp2QzNFanNpZndVd3lhZGc5OHd3SU03SWdP?=
 =?utf-8?B?RWl3d3o1UVVpYjNJWmMxNzUwODJVQndQTUpKd1VuVVRsMXIyeGplUzNKUUts?=
 =?utf-8?B?S0Z4L2lRU2hrZFpVNzVyWGUzcjNZeDUxY2hMOWs0Tys4ZHYwcmFkdVZaWXo1?=
 =?utf-8?B?RCt6UC85MU9hb0JyQ0NDbXUrR29lWkpTaG9IeWtmMVlaMkhDK1NLbVI0VW5Z?=
 =?utf-8?B?UTJOUEU3QitJRlg4M3lkaVVITnNSZjFIVDBCZ2Z3dHVtQmozT3cwS2lCMk1W?=
 =?utf-8?B?bzY4TmhCMFBmRVJ2eUcvOFRyVjdBbEZ4TDJVNG12VmlOQTg2VXU5NTEzSHYz?=
 =?utf-8?B?cHgvYWhUZU5iUHZsRDFyeEpiQnVPQXFoY0g5NVNBL2M1cUtZTE03dXErYkln?=
 =?utf-8?B?TkptUnlQTG10d1ptMUJWanYxeDhYMnB4cWlSTThsYXJOVjNNeUVzeklEN2J2?=
 =?utf-8?B?SGFFeXZzamdwQ0F5c3V6aVQxOG9nYUdwak5KR1VrUEhUQkRmTDJXWGwxS2s4?=
 =?utf-8?B?SXR2TjBOcU1ySnZvZ1Z5ZHlaL3IvLy91L2E5dlBab1RkK3hrMVZiUXgvTjN3?=
 =?utf-8?B?d1JvTW1jeDE3LzBGVU9yL0l1c01OK3hyOXBHTi9ra0VhN1lOd3pQNnU4ZGFi?=
 =?utf-8?B?Sk9MTGQ5NWt0QUt4SkMzTGgwZWQ5MUM2VGhmSG9hNlQ3dHJyZTV3M3RzN012?=
 =?utf-8?B?U2JrVW93cnVUV0M2TGp0MDh4NEVzbm1HUGxrZWN4Y1BFNFl1SVRpdWJHcHhy?=
 =?utf-8?B?K0l0aGRTd09NczBzbWJtQWRZUXJ1bzhxS0dXZ3JxYTk4SEtRTlc2cGk1aE5j?=
 =?utf-8?B?anB3aTl2UTB1UmdlR2hsT0QzS2pGb2NwMWlNRGM4N0xMQkJQbzA5d0cwcDVS?=
 =?utf-8?B?eGxNRG4xLzJaeSsrNXJ1SGU5dk5xWHZXZVJwb0N3cmJVZUJRRnVTdERRangv?=
 =?utf-8?B?WWY2bWFEYi9XTHhmWk4zU3JNbTRVbzlCRiswWVNYamtrRWsvcHpUblAySUcr?=
 =?utf-8?B?R1FCN3lmaGxkV2xVRWgzTXFybSsxNmpNWVorVEsxcW9aQnFVamFYVzVBbkZE?=
 =?utf-8?B?YWVOV3pncUVRS0ZnaS8xdC90UHg1bk42SEwyb3l2NmhUQ2J3Z0s4WWI4bVVO?=
 =?utf-8?B?MXdPeG94TDBVOWNuL05FVEl4R3RoeFlqRHFiZnMva3FGcGFWZk9sNHZyNjJP?=
 =?utf-8?B?ZGJiQ3MvRmRNZ0NKVU81R1RzWm90cGw5bmM3NklPZHFZYWpFU2wyUUw4cXVP?=
 =?utf-8?B?dHhwdER5ekdVQ2lUT0xmdG1wT0kwZ2V1L1hDT0NGeEdPL2pZa3RXUzJ4d293?=
 =?utf-8?B?aHR1NFFtRU5IbGppSnp0b0grajFBckh2T0wyQmZDVHFXT2ZmSmhyMTRvbytK?=
 =?utf-8?B?QVlqcWtjR1FBV0RoY1lzY0wwVTVENm9EVkZOSEJRVkxXTjg5Q0JJdURqQmEw?=
 =?utf-8?B?aUZkNFhHVDlCSE1ud0QvL2NqczJJV210b1BSclJuWnhhOW80ZG1wTkkxODJI?=
 =?utf-8?B?NXJOeVFvQjRNd3NNZlBLOTIrSmZNdWRXc3ZxemJLQUhtUjdHMnZ2ZmhybFR6?=
 =?utf-8?B?V09VKzk2WDIvaE9XNCtkeDhPYitETUNrTFBMQnY4RlFDZTZoM2ZIYUFsM2tv?=
 =?utf-8?B?QWlWRkJWMW5wWDlHVGhCQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGwvVVA1MFBnSmpwZlNTK0pUcDVQa0tITXhOUmJIVkZlUXlZREVpMCs1SmlB?=
 =?utf-8?B?MkNIRzNSRXduQVZDdVpVS3FJbnBiNFhFUkdlOTZXV1IzNUp0WlBHQWhQOWtO?=
 =?utf-8?B?TW1EcDhMZUxDamovMVk0RWw0cUIzZnJpcnh5VXpXdW41cjFvS3lFYUd2WVBW?=
 =?utf-8?B?R1cyZ1ljcVRiWkY0U3BRcFdYQ1o2cFhMa1hBQm1EaTNPQlJlT1ZUTjJFM25P?=
 =?utf-8?B?MHdBbjMreTd0cnFlRG96ZmtHclQ0L0srdE1nbGtBdUZsc2luMFJ0dTFpYVVr?=
 =?utf-8?B?WSsvcWJUNlg3aVFPZTFqekN5NmUwOUlyMkVsZkxRT1FiWEV1dTl5d3U0Sitp?=
 =?utf-8?B?ZlRWZURoWTRCdDBlanhPS3R3R3ZkZHB0TGlFaWl3dTU1ZW9NdTI4QVNBVnBU?=
 =?utf-8?B?NDlsQWtmS3VqVnltTHkyZFgveVJsc2duNkhhTi9Md0FYeW96UFcwYlBxWFpZ?=
 =?utf-8?B?OVJ5VVAzVkFhMHBMTFlKampaVkJPNWJ3MkFJY0tCV1hzWlpIQWkrS1J6Ui84?=
 =?utf-8?B?Z0pvRGZ3cGF3N1VDeW5zdUNobVVIWjhYNlhwSnkwVklOOVU5RWhXZmZYZ3Bp?=
 =?utf-8?B?YXRNVHBUN0xJL2tCUmoreFovd29FUkpNTzBmWWV3Q1hWa0hXRWhvNTJ6b0Fq?=
 =?utf-8?B?S0U2YURDRmdaUVFpZ0czTVQzMjVrNVE1QjZUWnBWbWFLYzNRRFp6dEphMHda?=
 =?utf-8?B?VVJkTDNvbHpCTGg4NDdQUHZmRCs4S2xqV1RQZlduQy9iZExsTUs2dEJacHdw?=
 =?utf-8?B?NTJzcEY3cDIyNWE5VG1mNk8raW9sdU1SOXRCdmQ1NFRacGVZZ3hxeGFOY09o?=
 =?utf-8?B?SU5UVE9ZUG5RR0t4alozcUU0VDRZYXVPcjFlcUZFZDJzOWI3SDdxWUoySUpv?=
 =?utf-8?B?dmZtTWRMOWhHR09JYUVZdHBLQTFSNlN2ZkhqdG5RZXd0UnIyV0Z6RHBwbWQ2?=
 =?utf-8?B?R2t0ZnNoS0wzbE1UZE1UVnZxS2RpZjNZZEtpTEIxQjFmb0I3akpsU3Y4WEE1?=
 =?utf-8?B?ZzJ6a0twbWJnZGhqNUJqVWxTbk9aR3d6cXJ5cWdFQ3lZVEZvTUlDTjhHUllB?=
 =?utf-8?B?UUFKMFl2TklGdVlZaHgxTmNMeURvNkp3NkNMZm02b08reDBZU1FraW9TUGZw?=
 =?utf-8?B?ei9seWlRV2cwSWQ4TXhrUmZ3ZGNoSTZZTXc1SnFnR0dmY1NITkpscW5ZajBE?=
 =?utf-8?B?a24yS241RVA0Mk1lZnV2MXpZbXI1MWUyeW9WclMwRmpGVU9GSjcwUkgzMWlP?=
 =?utf-8?B?djkrTFYzUTZRcHFUb2RsN29TUTY4VTNFekI0ZkJBSWxkMEZQRVJ1UXEyL08y?=
 =?utf-8?B?aFdJNmYwK2w3NHJRcFJsdUVqMkh6UDQ4c1IweVJ2Q0haRzF3bWN3cnNTOEtU?=
 =?utf-8?B?V0dTazVIa0dqd1ZyK3pXbzY0S1dVV2lFbXcvSU5ORW9SODN2MFp6YlNEd0E0?=
 =?utf-8?B?aFdKSFpLczFjS0lIbHMwQTJQenB0R203bzlXSlc2K0tjTU1Ra2tuelNFTUdC?=
 =?utf-8?B?bzdBVEN4MkJBTWk4L0UyeHZLS00zQTV1OHVhY2lUVVUxR0tsSVJydk5iaVZ1?=
 =?utf-8?B?MHo2K1VZeVBOaDdSMEVVTmZJd09Od3dmcEdHT2phVTYzWkxhTU14R1ZmejA5?=
 =?utf-8?B?U2wvVXRkQ0lzMW1BNjFsK0poSjV6U0FyUlZ4WERnZHV5SHl4Njk3eVVuU3RO?=
 =?utf-8?B?OVArWlBGeldtMEprTFpaS3FwR0FkVEJKV0F1M2lpMWV2SDAvUlFxYnFqZXky?=
 =?utf-8?B?ak8vZlRxN1BwTnlQbitMSXJHeXNJMStCUmR2bEVETng2NWwwNG0rQWEvUmZp?=
 =?utf-8?B?R1MwTWpBQlIxaEwzejFVSGc5YktkeXl1aXNiNTdmRzhiUUFGcHRpcjRzclh5?=
 =?utf-8?B?Zlg1R0p2cEMwcC9NVDRLYjEvaDZKVHRnQUxLamFzdHVRRHpqQnNPVXk3cUtB?=
 =?utf-8?B?Qk4xOU54dnVKWStGbkFMK1V3VDg4TVFMRm1lSnhlL0k0MnR0T3h4L0lwWkJl?=
 =?utf-8?B?WVhKdlFVZi9BM3F6c09IRFhxTklsRkIzWmpGN1RUZlY2R3lCUjlLbHBqNUFr?=
 =?utf-8?B?U0U0K3ZWS29wV3c2TmMyZlMvNmpOaVZBb3lrYW4xY1Zvdks1OGZnVDYySjRB?=
 =?utf-8?B?Q01iR1JEZHlCeFI4S2tzWk5ERllpa01RcTVMeWhVbkowZ0hQSzFFMW12amVx?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RnpYwyCUwvPCoXkPyk1H1U13NKLYtwHaP900pTVnX5sbcYUPPd6GgKG4uS1NyLfsM89L00UUBxteu/sr/RF4tMcmaTDCyjwACgGCN3HF+vwt/npfNU4tCmuzFeq8FpgBLTLznV7oGs6VfEK0I0SW1OoqG630XkN8nG5ricmi4WfBfJchkLch91CfW3IggMmVQtIkpoIPHLA10OhY8FfN+2iqX9yozegedH8k9f9q8epOyAkpPPWyHC3omsfe/YruIImXiqXnoroEtS9TKi9MZS0HmpZuCQBD/Rld7bcSIQA/Yr2BqQQa9fKhzKBzxusFUt4OgLTiD96OQliOwqp0GTDkLFakLg3ezkMrX+ffssomO882K24SCNOk5HvgPbRcIUvEmKmfiGq3bRkH9AE3xD+IHNPcsX6rBJyuu6/ebgP2OFA75tCrkX6UCWX9PzQS4ik+GSKf7br46A4IXkivtTM5CaDAKa7W6XFGXRL7Z3BCbWV+x1CUr1qiFfTZ5BTPseonbHxg/na8hTaAkIalj1ICcpIlE8xpZxXxAIONRzNL6OvSn0mFLhmCLCyfBZAt1G1b+t5HEkWkDAANKeHlUPox8KkTTL13CAcN7NWq/1c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805cd97b-3f9d-441c-c8b6-08dd30c7fe73
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:09:28.4262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yKC+9l77gClfXGjFc4AMDMfkkVnM0PwIG/Li4ilC5G8uvoZqyLaH+SdzqYQOR7zYV3v/3o7v+aNXlQc9XoRhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_07,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090129
X-Proofpoint-ORIG-GUID: IM06bIQrTJrnxLOnW-pJIfaO5rb-lb5S
X-Proofpoint-GUID: IM06bIQrTJrnxLOnW-pJIfaO5rb-lb5S

On 1/9/25 10:58 AM, Christian Herzog wrote:
> On Thu, Jan 09, 2025 at 10:49:37AM -0500, Chuck Lever wrote:
>> On 1/9/25 6:56 AM, Christian Herzog wrote:
>>> Dear Chuck,
>>>
>>> On Wed, Jan 08, 2025 at 10:07:49AM -0500, Chuck Lever wrote:
>>>> On 1/8/25 9:54 AM, Christian Herzog wrote:
>>>>> Dear Chuck,
>>>>>
>>>>> On Wed, Jan 08, 2025 at 08:33:23AM -0500, Chuck Lever wrote:
>>>>>> On 1/7/25 4:17 PM, Salvatore Bonaccorso wrote:
>>>>>>> Hi Chuck,
>>>>>>>
>>>>>>> Thanks for your time on this, much appreciated.
>>>>>>>
>>>>>>> On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
>>>>>>>> On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
>>>>>>>>> Hi Chuck, hi all,
>>>>>>>>>
>>>>>>>>> [it was not ideal to pick one of the message for this followup, let me
>>>>>>>>> know if you want a complete new thread, adding as well Benjamin and
>>>>>>>>> Trond as they are involved in one mentioned patch]
>>>>>>>>>
>>>>>>>>> On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi folks,
>>>>>>>>>>>
>>>>>>>>>>> what would be the reason for nfsd getting stuck somehow and becoming
>>>>>>>>>>> an unkillable process? See
>>>>>>>>>>>
>>>>>>>>>>> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
>>>>>>>>>>> - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
>>>>>>>>>>>
>>>>>>>>>>> Doesn't this mean that something inside the kernel gets stuck as
>>>>>>>>>>> well? Seems odd to me.
>>>>>>>>>>
>>>>>>>>>> I'm not familiar with the Debian or Ubuntu kernel packages. Can
>>>>>>>>>> the kernel release numbers be translated to LTS kernel releases
>>>>>>>>>> please? Need both "last known working" and "first broken" releases.
>>>>>>>>>>
>>>>>>>>>> This:
>>>>>>>>>>
>>>>>>>>>> [ 6596.911785] RPC: Could not send backchannel reply error: -110
>>>>>>>>>> [ 6596.972490] RPC: Could not send backchannel reply error: -110
>>>>>>>>>> [ 6837.281307] RPC: Could not send backchannel reply error: -110
>>>>>>>>>>
>>>>>>>>>> is a known set of client backchannel bugs. Knowing the LTS kernel
>>>>>>>>>> releases (see above) will help us figure out what needs to be
>>>>>>>>>> backported to the LTS kernels kernels in question.
>>>>>>>>>>
>>>>>>>>>> This:
>>>>>>>>>>
>>>>>>>>>> [11183.290619] wait_for_completion+0x88/0x150
>>>>>>>>>> [11183.290623] __flush_workqueue+0x140/0x3e0
>>>>>>>>>> [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
>>>>>>>>>> [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
>>>>>>>>>>
>>>>>>>>>> is probably related to the backchannel errors on the client, but
>>>>>>>>>> client bugs shouldn't cause the server to hang like this. We
>>>>>>>>>> might be able to say more if you can provide the kernel release
>>>>>>>>>> translations (see above).
>>>>>>>>>
>>>>>>>>> In Debian we hstill have the bug #1071562 open and one person notified
>>>>>>>>> mye offlist that it appears that the issue get more frequent since
>>>>>>>>> they updated on NFS client side from Ubuntu 20.04 to Debian bookworm
>>>>>>>>> with a 6.1.y based kernel).
>>>>>>>>>
>>>>>>>>> Some people around those issues, seem to claim that the change
>>>>>>>>> mentioned in
>>>>>>>>> https://lists.proxmox.com/pipermail/pve-devel/2024-July/064614.html
>>>>>>>>> would fix the issue, which is as well backchannel related.
>>>>>>>>>
>>>>>>>>> This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
>>>>>>>>> again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
>>>>>>>>> nfs_client's rpc timeouts for backchannel") this is not something
>>>>>>>>> which goes back to 6.1.y, could it be possible that hte backchannel
>>>>>>>>> refactoring and this final fix indeeds fixes the issue?
>>>>>>>>>
>>>>>>>>> As people report it is not easily reproducible, so this makes it
>>>>>>>>> harder to identify fixes correctly.
>>>>>>>>>
>>>>>>>>> I gave a (short) stance on trying to backport commits up to
>>>>>>>>> 6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this quickly
>>>>>>>>> seems to indicate it is probably still not the right thing for
>>>>>>>>> backporting to the older stable series.
>>>>>>>>>
>>>>>>>>> As at least pre-requisites:
>>>>>>>>>
>>>>>>>>> 2009e32997ed568a305cf9bc7bf27d22e0f6ccda
>>>>>>>>> 4119bd0306652776cb0b7caa3aea5b2a93aecb89
>>>>>>>>> 163cdfca341b76c958567ae0966bd3575c5c6192
>>>>>>>>> f4afc8fead386c81fda2593ad6162271d26667f8
>>>>>>>>> 6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
>>>>>>>>> 57331a59ac0d680f606403eb24edd3c35aecba31
>>>>>>>>>
>>>>>>>>> and still there would be conflicting codepaths (and does not seem
>>>>>>>>> right).
>>>>>>>>>
>>>>>>>>> Chuck, Benjamin, Trond, is there anything we can provive on reporters
>>>>>>>>> side that we can try to tackle this issue better?
>>>>>>>>
>>>>>>>> As I've indicated before, NFSD should not block no matter what the
>>>>>>>> client may or may not be doing. I'd like to focus on the server first.
>>>>>>>>
>>>>>>>> What is the result of:
>>>>>>>>
>>>>>>>> $ cd <Bookworm's v6.1.90 kernel source >
>>>>>>>> $ unset KBUILD_OUTPUT
>>>>>>>> $ make -j `nproc`
>>>>>>>> $ scripts/faddr2line \
>>>>>>>> 	fs/nfsd/nfs4state.o \
>>>>>>>> 	nfsd4_destroy_session+0x16d
>>>>>>>>
>>>>>>>> Since this issue appeared after v6.1.1, is it possible to bisect
>>>>>>>> between v6.1.1 and v6.1.90 ?
>>>>>>>
>>>>>>> First please note, at least speaking of triggering the issue in
>>>>>>> Debian, Debian has moved to 6.1.119 based kernel already (and soon in
>>>>>>> the weekends point release move to 6.1.123).
>>>>>>>
>>>>>>> That said, one of the users which regularly seems to be hit by the
>>>>>>> issue was able to provide the above requested information, based for
>>>>>>> 6.1.119:
>>>>>>>
>>>>>>> ~/kernel/linux-source-6.1# make kernelversion
>>>>>>> 6.1.119
>>>>>>> ~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_destroy_session+0x16d
>>>>>>> nfsd4_destroy_session+0x16d/0x250:
>>>>>>> __list_del_entry at /root/kernel/linux-source-6.1/./include/linux/list.h:134
>>>>>>> (inlined by) list_del at /root/kernel/linux-source-6.1/./include/linux/list.h:148
>>>>>>> (inlined by) unhash_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:2062
>>>>>>> (inlined by) nfsd4_destroy_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:3856
>>>>>>>
>>>>>>> They could provide as well a decode_stacktrace output for the recent
>>>>>>> hit (if that is helpful for you):
>>>>>>>
>>>>>>> [Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for more than 6883 seconds.
>>>>>>> [Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 Debian 6.1.119-1
>>>>>>> [Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>> [Mon Jan 6 13:25:28 2025] task:nfsd            state:D stack:0     pid:55306 ppid:2      flags:0x00004000
>>>>>>> [Mon Jan 6 13:25:28 2025] Call Trace:
>>>>>>> [Mon Jan 6 13:25:28 2025]  <TASK>
>>>>>>> [Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
>>>>>>> [Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
>>>>>>> [Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
>>>>>>> [Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
>>>>>>> [Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
>>>>>>> [Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/build_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/build_amd64_none_amd64/fs/nfsd/nfs4state.c:3861) nfsd
>>>>>>> [Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/build_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
>>>>>>> [Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
>>>>>>> [Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
>>>>>>> [Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/build_amd64_none_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
>>>>>>> [Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:983) nfsd
>>>>>>> [Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
>>>>>>> [Mon Jan 6 13:25:28 2025] svc_process (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1474) sunrpc
>>>>>>> [Mon Jan 6 13:25:28 2025] nfsd (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:960) nfsd
>>>>>>> [Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
>>>>>>> [Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
>>>>>>> [Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
>>>>>>> [Mon Jan  6 13:25:28 2025]  </TASK>
>>>>>>>
>>>>>>> The question about bisection is actually harder, those are production
>>>>>>> systems and I understand it's not possible to do bisect there, while
>>>>>>> unfortunately not reprodcing the issue on "lab conditions".
>>>>>>>
>>>>>>> Does the above give us still a clue on what you were looking for?
>>>>>>
>>>>>> Thanks for the update.
>>>>>>
>>>>>> It's possible that 38f080f3cd19 ("NFSD: Move callback_wq into struct
>>>>>> nfs4_client"), while not a specific fix for this issue, might offer some
>>>>>> relief by preventing the DESTROY_SESSION hang from affecting all other
>>>>>> clients of the degraded server.
>>>>>>
>>>>>> Not having a reproducer or the ability to bisect puts a damper on
>>>>>> things. The next step, then, is to enable tracing on servers where this
>>>>>> issue can come up, and wait for the hang to occur. The following command
>>>>>> captures information only about callback operation, so it should not
>>>>>> generate much data or impact server performance.
>>>>>>
>>>>>>      # trace-cmd record -e nfsd:nfsd_cb\*
>>>>>>
>>>>>> Let that run until the problem occurs, then ^C, compress the resulting
>>>>>> trace.dat file, and either attach it to 1071562 or email it to me
>>>>>> privately.
>>>>> thanks for the follow-up.
>>>>>
>>>>> I am the "customer" with two affected file servers. We have since moved those
>>>>> servers to the backports kernel (6.11.10) in the hope of forward fixing the
>>>>> issue. If this kernel is stable, I'm afraid I can't go back to the 'bad'
>>>>> kernel (700+ researchers affected..), and we're also not able to trigger the
>>>>> issue on our test environment.
>>>>
>>>> Hello Dr. Herzog -
>>>>
>>>> If the problem recurs on 6.11, the trace-cmd I suggest above works
>>>> there as well.
>>> the bad news is: it just happened again with the bpo kernel.
>>>
>>> We then immediately started trace-cmd since usually there are several call
>>> traces in a row and we did get a trace.dat:
>>> http://people.phys.ethz.ch/~daduke/trace.dat
>>
>> I'd prefer to have the trace running from before the first occurrence
>> of the problem. Even better would be to get it started before the
>> first client mounts the server.
>>
>> But I will have a look at your trace soon.
> before you invest significant time in the trace: there is a chance it's a
> false alarm: we do see nfsd in D, but they're not spreading like they used to.
> And since someone is pulling 400 Mb/s from that server via globus gridftp,
> it might just be real IO overload. We're still trying to figure out what we're
> dealing with...

6.11 is going to behave a little differently, IIRC. It should allow
other clients to continue working normally after one client hits this
issue.


>> It would be extremely helpful if we could reproduce this problem in
>> our own labs.
> easy: just hire 700 physicists and let 'em loose

Yeah, that's the problem. I ain't got 700 physicists in my back
pocket who would put up with NFS server outages ;-)

Jeff and I have discussed a potential pynfs-based reproducer,
but no guarantee it's the same issue as yours.


-- 
Chuck Lever

