Return-Path: <linux-nfs+bounces-13589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2C8B2398A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 22:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFF01889A4F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 20:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCBF2D0601;
	Tue, 12 Aug 2025 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SlD01iLl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RUfqcwWW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01F2D0602
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028870; cv=fail; b=uJZZ3Wxl9elxpk9kpyVNvQHmg/ZmBPU9OfkbUEUU5/y431loZHhM2bbGvzaw8X6ssiQQj+gBXZtZiGZ3d64a61U+IcEt8Tc6sqIndmGShHjsfv900B+TAAAZitMAS1bBI7AsCxBs1iMUV7uXDJzZlMf82a9G+MsAKZcIruOHV2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028870; c=relaxed/simple;
	bh=Mp3HE4z1hVACN2apa037NyvhDFfqfgXrpfw8YdjsMVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYvNYNZaz2V2XQLrO5TDaB2HYDz923WqIZL9FniFx3l3Xkx3OncqgNYrqxyqSX/CGzyOYYs1jJlaCld6VN4sML5sq7pD9JRLChugS6vk7t6+sYltqs81iYfZmmLM4A+GyncOdgyryt2tkzbi/wRPqyllkeZrg11DYVys75XOljM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SlD01iLl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RUfqcwWW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJC20L004717;
	Tue, 12 Aug 2025 20:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jb8drhQ0aqyHWYUeeAeZQY3RS79JUJIRVjYf2aDUEAE=; b=
	SlD01iLl/FZiOzdS+0IpqZSoF2HFaC/OIMVi4LAyLjhtbVDhe1qHRd8VPomEmn/h
	2nsc/o4Z2ZJkv6yauTf7p96ZoihO5jdevYhWvOLau5Aj1lFkEyC9/mh92/ylSdJs
	eSlw72QaXVBKWpql8Ai70HIQ067EpF0b2dqz9IL6XJSYcn6/SPDIjXoqX5Im01W+
	JbTsS2nNWjHpnwv1vZUcDTkcoY+lTwy7PoPTSR7hEcQKn/A7FAd0FFjuFZX57CwI
	nJhAlq5coHbJ10Zy5oDxCaERzU8C1ArIiZdwg0zydfCCGKnyBxaGifJN+AnvHxG0
	As2Zedbw2R4l4Kh3GT3arg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv5j11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 20:00:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CIpcvt006485;
	Tue, 12 Aug 2025 20:00:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa7xk5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 20:00:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW+cLYQnTz7Fk/LQftYdu3I4wXwB67AwAQgBNsfd0PW8O4IbF95BtZQd7CxEReBcXDRw0i37EN+zHTe6aNfxEUJ+EPxIIyjH4R1RK+a53RF3Ukcb/ZkEsy64KacVqggVQUt8zb0ukp3zS4aKtNadWnd9SQoCom44IDeYrAaZOkjV2qZ3hD1V4pusbp43Df39Mq+9wZ90QL1yi7VqxyS0jrp4zehdjqnjAJsupbeE0YCBWtzpZlEFFxOZKhG91pSFI9c6pQhyHC00urt+TC83XsP2uj/gAp1I4ZqzHKkqKWL5pkSDbZSEsHEccNjlV0z69uZasLuAnuL3hHAAnUbMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb8drhQ0aqyHWYUeeAeZQY3RS79JUJIRVjYf2aDUEAE=;
 b=lRvgjsg20HAwedQsIcnUqkMNFKKN1UeJPl+hfW9ojqPxVVfqyZQ6ErneILI38K/YPZ4X6byxFEKt1j2XEKahmz/RXqbER+izIyQIqSn5L9H7Dj2GaXxx4gYbzDhDx2r5pwkvQHbLrfuqE7PbzXJi3DLqcF86siMEH3O04a67dOsbfEoccYOjOGC6yYoqLH0jHHY0lxVA814npokASlmxuvUCFCCBfC35RzcpBqOvrCzU2z66roIA138b8gtbQX9xtnNfqMlU2YIwN0Mu2el6Kh2EEzK5p2QPCkHtPD1AgCYG0JrYtIeN9qdPPyZ53ZFUUifChp+J3LKNCwbfwCxizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb8drhQ0aqyHWYUeeAeZQY3RS79JUJIRVjYf2aDUEAE=;
 b=RUfqcwWWqgCh1qjVKiXB6GCQ/5bkgJsdcCch/euCIuy5BUEkuvDOvMBWWgjzp+81+0pzvAmazGTocysdi1trmQRUP49sL4vRMy7STsH5cS1e6a67FT9KUQm2ejY89HrtoCPpYpHE7iFBFgJA4kcW10OsBJTQP+JqeSVmKB+dYL4=
Received: from BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7)
 by IA3PR10MB8639.namprd10.prod.outlook.com (2603:10b6:208:575::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 20:00:52 +0000
Received: from BLAPR10MB5124.namprd10.prod.outlook.com
 ([fe80::eb17:e79d:5975:fa79]) by BLAPR10MB5124.namprd10.prod.outlook.com
 ([fe80::eb17:e79d:5975:fa79%5]) with mapi id 15.20.9031.014; Tue, 12 Aug 2025
 20:00:51 +0000
Message-ID: <b45634b4-6074-4255-ae59-835bd597c6af@oracle.com>
Date: Tue, 12 Aug 2025 16:00:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when removing listener
To: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
        neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
References: <20250812190244.30452-1-okorniev@redhat.com>
 <2a024899-6be0-4349-aed0-ee05e196fc1f@oracle.com>
 <CAN-5tyEpg=vZGXkGYqjq3RLC_h=rt3akXGvnqKzddtLJ8Q0O4A@mail.gmail.com>
 <07bb55026499e120c2057429beece2638f4e9256.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <07bb55026499e120c2057429beece2638f4e9256.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:610:57::19) To BLAPR10MB5124.namprd10.prod.outlook.com
 (2603:10b6:208:325::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5124:EE_|IA3PR10MB8639:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c43b6d8-cdc6-4888-4c32-08ddd9daf05a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UGk0OXNuSVRvWlZiaGdCa0Z3MFdrMG1RVUV3VUZxMkxtdEJzM20yRDM3b1Er?=
 =?utf-8?B?eVNpNm42N1ZkZTlYZHZaOG5MYUtyaFhncS9ITForOXl6YThBemtXYnRDVWlI?=
 =?utf-8?B?L04ydlZIV1FEUWZpNDJtTitXZmlGZmFHZWZPekVta0FkZGR3ZDhKWndRMk5N?=
 =?utf-8?B?dkhYUVJTWHdkd2VmRVdyYTFzOTRCdDBMbDkvcDZjbGt3T2dFKzB2aWJqZDBH?=
 =?utf-8?B?a2lPdy81MTJ5U0kzQTIvcGp4cFNhWHZTSklZU2Q4TUx3Y1c5cmVEVUsyTExl?=
 =?utf-8?B?akxRZ0hROUE4cy8weGZlYVI5YTFFTjgwOTJyT1VQWWxRcmg3Q0NhTlRLT0NY?=
 =?utf-8?B?SnBrWFY0NTkveStCR0dVaWZCbkJFUG1yQUVGb2ZtVzk4dFB5RGxvWkg0OHdL?=
 =?utf-8?B?Mkt5OFFFL1B2NlkvK3ZzRXNqTXIyTWloVTJnNXpFcUhLdzk4eGZIL1Z0aE5w?=
 =?utf-8?B?SnU3S1FJZFFRMlpTNHBHRkU2SXVtbTk4VnJOZHR3M29uN3ZLYTV6bjlQSHdX?=
 =?utf-8?B?bElNZG1DRjdxN2h3ZUs5UHpzWmdNNGJtTmcvcERqcGFEZXhkanM5RS9sb2VL?=
 =?utf-8?B?UzdIN3gxSTBTZ0hYVEZhZkRFVlJCS3MyRERGbVFzTzd2TGJEUmp3OGFhaWtu?=
 =?utf-8?B?WEkvWVpSUXhRazJwM0VtNXFKekhnWlh5UFFONFRvYjFnN0FOOW1UeUZKT3Bz?=
 =?utf-8?B?Uzl0bEovc1p4WU1iaU44NEl4RTkzQk9LNGJGUkdUOUFyWWhDWGF4azl2MFow?=
 =?utf-8?B?VUJhQ2VNeTErQU9oM2ZoSExrOWQ3bERFWjRxVmkvZEZlLy9YakdnOUt0RDUv?=
 =?utf-8?B?UVJid2MwWmZ1ektvUnZ3K0JmbmpWQWsrK2VqVjhtazhuWXBnaGdjMWVIUHRh?=
 =?utf-8?B?d0M4dFRzMDJpc0pUUFhWS212bUZRVjY0QjdRbHd6N1pvSUliQTNEb0QwTHYy?=
 =?utf-8?B?RURiN1FXczh3U3J6T3Jyd3UwWlFSN0dSVld0VEZMQ2hhMXFaaS9IM1VjN0JU?=
 =?utf-8?B?cEpWeVBiWDRxckxya0NrTzkvZ3l6ZnhVUitJM1VVcEdpbWc2bFBRWDN3WGdZ?=
 =?utf-8?B?c3NCdE96MVZ0eWhhbHgrdnhKZHkwSXByRE1MWlVGMlpYZW05Si9DNmtkS1Ny?=
 =?utf-8?B?U1NRaXd2Y3RoUy82bnpnYjBsVU9hcjJqbW9xUVVJOWU4ZllWK1VWVG96a0Rt?=
 =?utf-8?B?SUl2amZ2bkU3WlhyU3ltQ09ab1VWamNINVBvSEVLbVNsajFObkRUSUFqZXhm?=
 =?utf-8?B?WUdnZXpZNDMycFVtUnduOVNKVUl6eWlMaWVsZm9VcjY1U2hxWjlzbUpVNldG?=
 =?utf-8?B?QW1CdmtFYU80ZkZZVlQyOTFPUFJJNWMzV0xJWm81N2VRWjg5aXBuMEF3MlJC?=
 =?utf-8?B?QnZNQkI4b1RWb3NVM1dRamd0bFQ2eTJOYm10dSt4cVpqdTgxWm9TdXJsUmxO?=
 =?utf-8?B?WHIxYkZ1enZQdnMxSHNFWkFYNkVpalZLNU5nMHlISmJYVytxN0dYR282VU5Q?=
 =?utf-8?B?YjNXVEFJZDNCcDZKVllVa25PYlh6cE1SRkZWZ3ZxV3ZxM1lhczRoTHR6R2hD?=
 =?utf-8?B?R3hYM0szK05GZy9oMVZGbmlUZE4wOGVhTUdrQzRHd1hVbXlWbUpFUTlrTHVR?=
 =?utf-8?B?UUdDblFrcHJEQkEyekZpK3B3OGdLZ1RhaSs0eWVzSjQ3TzFPb3UvNUlNbFRL?=
 =?utf-8?B?SUZ3U2FDTGlHOWZaWHhlckNTTW5hTjBpRmNYeWs4bDgyWExCUW0ydDEwdVNM?=
 =?utf-8?B?cDI5dHhUR1ZxelV0dzlFSy9uZUhwcGllWm0zRjJ6YWVJbnZRZ0RvczBxblFN?=
 =?utf-8?B?cXVMUjhDUmdNWldzWndONmpGTFZRenl0aHVFVmNGQlQ0TlphUW1COGVyNEEz?=
 =?utf-8?B?b1NFdkovT01PWkpzSkh6eUdyR2poaVM4dXg2b0dPNHg3U0lLQWVXYWtScWYw?=
 =?utf-8?Q?ySjWLWYMk2k=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5124.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?clVKbGQ5QkgvTDlpZXdhdXI2ZnVWMFZTUHNBenIxeEx0ejB1VnZTOGkwY0NS?=
 =?utf-8?B?bU5RZWluam44cTZTQUFtUzZXT0l6ckV2Sjk2bjFtNnVraXJUbmZkODQ4dm5l?=
 =?utf-8?B?T0VldXZvMHluMjJMMEdFalJWbWdrOE05OWFneDRvYUFUdk9oRThyT3J1OHhZ?=
 =?utf-8?B?WW5Ob1ZHUGwrTEJPYU4wVWdMQVJjSzRXVHlncXo2NWMzTUdRVXpNZG9EaU1s?=
 =?utf-8?B?UFVUdUJpTFFqTnh2VjZGemRTb2txYzk1RDBhTmIxcTJLUU1oZXliM1FLTXhU?=
 =?utf-8?B?QUQ1c2FOL3NiNXZJSDAxVjgxdExtUlJDMi9ydmtZRnVoV0dhR2ZIYlN0TzRC?=
 =?utf-8?B?T3hHVVZtREkyWWZUNWkwR2QwcUJHTXJYek9mTmJKak1NZDZjNHVQMjJ4WlRP?=
 =?utf-8?B?NllNa01vWWVnNzBleFFKK21LSVFWSnl6ZVBUMFZON1NBekx4ZkZHcityVEc5?=
 =?utf-8?B?U3NjT3BiNTRaczliZHhVMTRwdUpzOUg1OWl5bmQ1YllsUnJjWGJPV3B1QXJR?=
 =?utf-8?B?ZlNmeGYybU9lS0xTUDhXUWpaRzhJL0ZRQXk0VjJldXVyaEdvZURYdFA1cW5K?=
 =?utf-8?B?eHp5MkZsS3Y1Y0E4YTBBQmRWWTU4UXk5R01KdndnTXNCV3ZYN3pMamZtbWNm?=
 =?utf-8?B?Z3UvalJVQ0JDV0ROMTdYK3hBV01SeVlTdm1yUTVoTlNMeWVWaDgrcUxLVUZC?=
 =?utf-8?B?WWpORGtuQlI2VmlOK2dpYlo3ODUvQmlSYTZoQWZGM2RCSmVLNStheFhsMW5s?=
 =?utf-8?B?YnIwcjFMazEveDdLem9UR0pFMGw4UmNCQWVBQmg5aS9zczFUQU5UNnlocTNT?=
 =?utf-8?B?Y2NlS2ZRWmlCOGo2TE56aHJvaGg0S3BPT250ZWtKZ1l2cGtDMjRRUlFhS3FI?=
 =?utf-8?B?c1hqTDh2aENuRnJPd1M0cmdMY2h0MllTSTR0R0lsY3ptU2JZZ0xZOGpZNGVD?=
 =?utf-8?B?b3lUY2I0N3V5M0l0QyttVXkxSndoYlhvRHFkbnZLZmJUQitsVE5GWEhvZ2JE?=
 =?utf-8?B?dUdlRFByNXFDYlpBWW4zNWl6akI4YTgvQlRydG5SVjRwR1lPRFNkN0lMc05z?=
 =?utf-8?B?WTVOWFNyc3JFOFV1Q2R4NWcvUFJnUWRteU1mU2IxcGZDMS84OUoxWDRFRWh4?=
 =?utf-8?B?L1ZUR1BVNmo1VjZjR1Y5dW8zakY3bWlqVUJzK09ZMUEwd2ZNMHd5bFNGNGFx?=
 =?utf-8?B?NG1kRkNxRnZEQ2FMMmpUZWdFWFBmSVREaGVKS2kveW1CZU4zSDJFY2NKT05G?=
 =?utf-8?B?aHNmdmZ1dDJRcDhBVGVjRi9RWDRwY0tvS05tZlpQeURsUUZaV2wrRUVtay84?=
 =?utf-8?B?UzZMZEdvbTZGUHdPMnduWW1SY1BzZjVMTjN3eXpMRUx2c2RPQVVsY0IvNXQv?=
 =?utf-8?B?STcxcFRmMXc4QlRFL1Y3bjNtUGZTazRWWVJHOG91bGZ3enNTcVBvWnBZclQ5?=
 =?utf-8?B?VjlTWEJHMmw2Z2ZUUUtyeWYzYVJqVk5kOUZ2WFFPalJFY2JxVzFSRGhGTXov?=
 =?utf-8?B?OG1zZFB1b0tYN1EwU0trNUJmcEdJSkZ4a25NWWlUdzJMRXZYU1A4OG1CbWR2?=
 =?utf-8?B?M0FXbkQ3NWZuT2pFMlppZk05M29aK25hcjJKeGZvSGM0U2paT0VGRkhpSDRi?=
 =?utf-8?B?cmxqTFBGWkRQZjlBN3RsQnNvWjNIeDhJc1FvN0pqU2J3a0ZNN2JxaThFQnBC?=
 =?utf-8?B?TnR3cnN0Sml0RE9FcmVXR3pHVUJNMy82VlJEUkp6NTdYZDkvL2RjTkpSZlF3?=
 =?utf-8?B?dlRvL0ZaSjFaNDRiU1JNc1VHZ0JDUUV2K1hISXB6RGNHODJ2NkNuZzBpVXNG?=
 =?utf-8?B?L0l0RW5EK1BDYlhQUzNOa3VDeW1qaFdvamlZbHpoT3RHOXVNM3JqcjBTR3hW?=
 =?utf-8?B?Zks4VDVMTHYrRGlKWUY2N0dJVWhhZ1lTUEFzWktnRjdsMDFqL08rUWRKSU9Z?=
 =?utf-8?B?K090elVkOG1wdUlhajVuSk0zdmFtZ3hIR3FYWE9KTEREWmpqNmIwdEdYMmU0?=
 =?utf-8?B?THB6VlFEako5aVJXcjJBSXZaUnA4cUNOMEJBWkNTL1IwUnhObFpKdHZlRWE0?=
 =?utf-8?B?M09XTkhtK3NvVHBQRGlLWHJ5Uy9KZEFxSEx4OFgwN1gzODY1SFVsbFV0Wncw?=
 =?utf-8?B?WVltUTFEaUhZUjRMR0VUbk1CdFpneERVd3dvS2VEQko1Yy9pcmlHTmpXMTFo?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+2QHayIFsQA5b5de4UFCVC97RJAyEg2NWpqXaJPbIobdgh0G0aD/VIhz1Mpt0ew0y90lSMSwLp91KTsEob6Ggb85Id15m7o4kp8yCoLV4htS0+RNC9+cmbSnr5t8N3DMyRg/Oo81FWpycnyzHmUZ7OJsQTV3IoAQ7OXW03bV4aiieA9bpgg7zn/Q/mYvNiqaVweSqCSF4UQo5wmmyfE/MdPicAVoh9pRONSLngNYPqXlIXspPMjwhqRGxdjFo8ew0DUwkclTuKt7poa4pJ1Z5qLpCCmapGZy185BR23ZOGDShJgbvjjdis2HFB1qGkHSkA1xwNjBgX2xHdkBaimJd40TLK93PSI/2i/rXM12GsiCGNPzSFoVYjVejZQtqJ7izjPWluA+BKNadmDUGj0bciV00Avnp+5XUgKPFTMt56qm44kZ8CgXTFrw+1EZPqewrafH6GhEIvY6kA/Xn2Ho4gVw6hmF9No+JppcR8gcZN+OA5uIlyqZ6p/Zv9SikkJvj35zNzXoKRcdg/G4dXHj352TTvwbmG6w0gRifI2tJ4zwqs205kdx80hJF7nOzZCb50Gqt3o9/tG6mlNpkK6QUZoJWODGx+iH75CRymqa7BA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c43b6d8-cdc6-4888-4c32-08ddd9daf05a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5124.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 20:00:51.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TH/2EIKmN5sZFKGZi5Fo8zhlRPCcQMlEUn9BRA8xUEPAkuDd1kahSyMQGTCA7tbS09zeyFBy3rLulmNz6ptouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120191
X-Proofpoint-GUID: CCpBOi23fIey7ICAxS-bpiOMrPteYZ2m
X-Proofpoint-ORIG-GUID: CCpBOi23fIey7ICAxS-bpiOMrPteYZ2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE5MSBTYWx0ZWRfX8YCD9a3mvOyY
 0jy8l6lh/kcINYtj+0gGaGtZVAyYIAE2K6NYz4uUNubqpdpr+fjacNXHPnLorWDkNWIXtsk4pz2
 6YqH4In+NcVFITxtfybn/DuX4tcPe8OZoG5oCeCA+mHzyqAf/ybMVMhg3+n1Ay9OxVkcpFV8/RJ
 KJcz7UHFBqm8djAZOTC9taViDhkFrYESZVyljwjVZ/WGvsaCqQjvxzSHHGgLzeEWghlsE/PmR//
 A2Ik/4nvEkCKcRGpJVtwvLvFpJAv67FwUhTpEXDUNYqxuSqyLkagfzRvZKrcnQKrHMvJNzAZI/4
 bWFpA0+5ucJBwN+RsBLnd2i660aBxRsK6G9lBiqE7Z+36SZrCLkUDqtu2i6Kncz+tZw0E3F355/
 00SZzWX924Pi0Sk2eGcgMYhH1/3BkbvnAR/GDlvfUiFSNclJCUZP0Qikf35AU7w3/BMIeNon
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689b9d79 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=hAsHhUpnx7TeXPWVd2AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13600

On 8/12/25 3:57 PM, Jeff Layton wrote:
> On Tue, 2025-08-12 at 15:13 -0400, Olga Kornievskaia wrote:
>> On Tue, Aug 12, 2025 at 3:08 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>
>>> On 8/12/25 3:02 PM, Olga Kornievskaia wrote:
>>>> When a listener is added, a part of creation of transport also registers
>>>> program/port with rpcbind. However, when the listener is removed,
>>>> while transport goes away, rpcbind still has the entry for that
>>>> port/type.
>>>>
>>>> Removal of listeners works by first removing all transports and then
>>>> re-adding the ones that were not removed. In addition to destroying
>>>> all transports, now also call the function that unregisters everything
>>>> with the rpcbind. But we also then need to call the rpcbind setup
>>>> function before adding back new transports.
>>>
>>> Removing all rpcbind registrations and then re-adding them might
>>> cause an outage for clients that attempt to mount the server right
>>> at that moment.
>>
>> Ok I'll take a look at unregistering elsewhere. But to note, removing
>> a listener is only allowed when no threads are running. Thus no mounts
>> are possible.
>>
> 
> Right, which is why I think this is fine.

I think Olga's proposed solution is "fine for now" but IMO it adds a bit
of technical debt that we don't want, long term.

A better solution is to make NFSD listener creation and destruction
complementary, if that's possible.


> There is a small chance a
> client might see the bogus rpcbind registration, but that's still
> better than the status quo.
> 
>>>> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>> ---
>>>>  fs/nfsd/nfsctl.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index 2909d70de559..99d06343117b 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -1998,8 +1998,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>        * Since we can't delete an arbitrary llist entry, destroy the
>>>>        * remaining listeners and recreate the list.
>>>>        */
>>>> -     if (delete)
>>>> +     if (delete) {
>>>>               svc_xprt_destroy_all(serv, net);
>>>> +             svc_rpcb_cleanup(serv, net);
>>>> +             svc_bind(serv, net);
>>>> +     }
>>>>
>>>>       /* walk list of addrs again, open any that still don't exist */
>>>>       nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>>
>>>
>>> --
>>> Chuck Lever
>>>
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>


-- 
Chuck Lever

