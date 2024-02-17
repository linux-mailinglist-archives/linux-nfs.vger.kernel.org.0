Return-Path: <linux-nfs+bounces-2000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7122C858CB6
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 02:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6C2B21506
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6B111CAB;
	Sat, 17 Feb 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ejX/zLYG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T9RNIm/L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2E3D68
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133112; cv=fail; b=fHsiR6BQDh0cy/ADx+BExMVE1yxiv0a8lPuip4xUkratFwBQz7ha7qFBmpnAiR7ujNCRrUkdpHhBr8cv/dcK4/Z/HqZtBvdGkbQHuqJU+hmc4FUtM4k7fQBc2sMSPA6NJOp5GSAH/+vhmhjpafWLExf8Sjn4Ig+34H0JmShKtaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133112; c=relaxed/simple;
	bh=gocFP36ivWd4nvSenBXeSgDd0hAx3xl1syTvBqhX9+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X/eS5AzZQHNXygMpOBtmDhluPz2LcwMdVR98FRsQzdgwwjpfjeI5F5SKeCW069so0mQgVG0ny3QbYQibzaJCooVmHTlMZwwsPzqMbJgzEePXjLeNTOVsCe9p6DfescUjZtNr1Zsr9xEbmPrEYpC0qzzTHRTcfpnuUrTZ0D2ueRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ejX/zLYG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T9RNIm/L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKEWIa014792;
	Sat, 17 Feb 2024 01:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=8rGy4Dx4PAZ9mbNQBchWGYt1TdoeCvKmwxU1zEjC9WA=;
 b=ejX/zLYGHpCdl1P1aWFXI1F+zLSv2gkMR3x/1beqN/N+100ZpCdOf6UVNSp4OiqktvtI
 RNy7OB2oxTXn18nDNfxSpM4sHvBbIpjvg7qyRllme8OpEyWaG1rgHEkypgyWQpOPTaDO
 us90VbT8ghVDNsVyFJUaLDQBwJFCokAnMX7xW3c3gp8RNQ6U7FIKsle3lD076ChvWsFs
 F4Ss5CmRKVYy1NsgdeWwoNujsODTYvkAaElYxWkfW6xf0OzL6CXpt7U2uLWH7nna5v1c
 CIS31UUwS+sGPzQhvxOUfBO1TsIydP/4fYdbifxyLxDbHt7LgBe2q9WO5tcM0cdZGl8x BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91w6xqkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 01:25:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41H0ftKa013767;
	Sat, 17 Feb 2024 01:25:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apfwscr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 01:25:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI6qNXcDo0VVUDTRJE2Ir7hiJ/kAry3gHyQB5fRbTq9Tt2qkL1A3AMcOaPVFaz/KXyUEi3NPgzJfhR2gxNF0NeK+sIDVGPs23sLP5wjFGhVjYxeBEPI97G3uXLl+uEQUbb/ZUmIXrzpXUcNtzkslPumgkACXor7zmBXrTs5/OUnRbOuvZrjusha0/I3mwiYZNbae6ZRSygcDIr9cJR7LSz9reubxyFb5ZiRPnuCZPvbTeaz38tkgM9SAmkaYlxzhO/mJBEVgevL/XSITAyjF7hUXwvnvXBRWfwasMUlWEUarCdnYg6ED8PqlVMMoxnQM0/eBPkG1H6f5YsStSxH06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rGy4Dx4PAZ9mbNQBchWGYt1TdoeCvKmwxU1zEjC9WA=;
 b=l9/Lk660yNxarwMgqFZgOS/wvNHp/dTl90GMAKTNEwSSRna4zRGqXRRmtc56OWwGtFpwxEr4QRg0PAfApfP8OgcLS6TM1z2bsX2Xax3Ugi+GfYw8bLP66giI1oP3v7uF3ju3miJecKFON7ynhJULt6jp0Gtxz7kKVFmXuTy2AaSkmS/y9ybJSu8zgVkUYMQVZVgr7YpzKK3QdzipXamngYvm6taZ67ytvrUYiCY3IH2dkHYlSJhm5ykJBHSyzfXtpV004NHMgP0ZhKUzxzgGymps3H5X41u8mIrqBPxj5FRO60QyKD/ekQ9JgDaTuAPySN2wIbq6zDMaqR+yuKV4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rGy4Dx4PAZ9mbNQBchWGYt1TdoeCvKmwxU1zEjC9WA=;
 b=T9RNIm/LT03jv1lWbTINHzAt89or8hmVgYuDT6Rrbom7zhiQD5rfLgD1WYvFZe1SCSmhlVwFzXp36oKDFrwoHG7rxLTGfM3qjxS2Xu+KGyiPa+ulUf0WJcZ+7bYAoDUgg1Pyqa21cTIOfY7Wi/ApfH/eoe7nrEZdKqUHrm87ibc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6520.namprd10.prod.outlook.com (2603:10b6:806:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.30; Sat, 17 Feb
 2024 01:25:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 01:25:05 +0000
Date: Fri, 16 Feb 2024 20:25:02 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: apparent scaling problem with delegations
Message-ID: <ZdAK7hx1B2VrNjp1@manet.1015granger.net>
References: <PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com>
 <1AF9A62E-55BE-4A08-95D6-26784218C940@oracle.com>
 <PH0PR14MB5493D4DF2877FDD93BB49AF4AA442@PH0PR14MB5493.namprd14.prod.outlook.com>
 <A14BC53D-18C7-43CB-B64E-3B215EB12D04@oracle.com>
 <CAAvCNcCo1phpMqLsVz_GtrKrVb4Pgv_UfTXtokvqpSLFjVJKoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAvCNcCo1phpMqLsVz_GtrKrVb4Pgv_UfTXtokvqpSLFjVJKoA@mail.gmail.com>
X-ClientProxiedBy: CH2PR05CA0036.namprd05.prod.outlook.com (2603:10b6:610::49)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: aafcfd1e-ef95-4227-21a6-08dc2f574534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k6W4o+jh7th6fPD5DWmh9xgPSnXKHDfbco0Xgrwy9PMCJZ1N1/w04/mbhezggGdiFtrM8eGNY2Av2Y/oFn5/qQ98Gtb6X+6OEvH1JEChpLGpZXQVNq0JDdsVYSACdruAG+dXMdtRietg8U+liUceTbjC4wYM8Gk0rxXqrw82IfZRFknOffDkP1VmbmXgPPATMSP12g4sW+wJXxbUKN2DcoyYBdm7p3haqkFooOaxnkGb0RkP/RgiLAYwG8cz0g/AJXeDbRvvhB+8GQowYtzn18fwac7FRkcIGXjPcw15T5jPbch7YCQYF1K8XpjSdV+J0BSjC7D/CJNFqaKG0gKdSTLvN2fWdjhRxTWMt7m/mO56Xa6ixT5Kavc0ARf6Domrx8riss7c/26ttiu9+2MBo49237FexacwKwbwFrs5eif4eT43dIawSONL4sdiM99aUOdZC8+F7o+vRXVWHZR70rppeQDa6u3b+rqv+IOhpM/9LfyoLcdIxRxswJTTXLop1b1IRXMR5EbgQOUMLu5F/agyEs79hfwtooGcWRRuAh49wnky8igqPXzHCE6iSzAn
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(2906002)(44832011)(41300700001)(6916009)(66946007)(8936002)(53546011)(66556008)(9686003)(66476007)(8676002)(26005)(83380400001)(6512007)(6666004)(4326008)(6506007)(6486002)(316002)(478600001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTFPL244UkxwNjhwS095TEEydlBUblk2VFpYNlQ1RFB0NmxvaDdnZnY0dTRW?=
 =?utf-8?B?ZWx3NDlXcE9uOGs3NmtHNHBTT3Z4TEc4bERrZisxU1dtc2xWS1FXL2JkRU9x?=
 =?utf-8?B?Q2pPdTU0R0RYbHNMM1JKb0FLOUwvOGR2bVFqTVRtZ29RQ3lFZDUrdDJwd0p3?=
 =?utf-8?B?M0FJcnoyN0RWam5ML0dKTnpDREEvSURHQXhOL1dWVjhTZE8zQXFjY2d0Wmxk?=
 =?utf-8?B?WUt4c1lYeDg2cDJMWUJzRVZxQlM1TG9iZk9UclFPa0U5aFl4RlUxT3h1OHJa?=
 =?utf-8?B?UmRtZEZ5by9RY2pjNzd1TGpubEtuWHlXaXB0Zm5KZDRWK2M0cVF4NzFhRjBL?=
 =?utf-8?B?QSs2aS9mRlFhWk84bllGaVFhdjdnTGV0U0JZQjAwei9pb2kyVURlY3ZSaXRm?=
 =?utf-8?B?Z3UwNkpMbDlvcWhDNExGMnhEbEJvT2lnMno4TzE0eFlwZExQUFMzZEZOZCs4?=
 =?utf-8?B?MHBTZTd2ZElyejdBcUcyUFU0WHFOcDUzNnl0UUhrWmhOQXdEVmpuOWlaaEZ5?=
 =?utf-8?B?VFdvdjJ5NzdEam9FRmNkSmxydVA3RS9TTEJ6YnJWclJoRzNNT2dBUEFSbFkw?=
 =?utf-8?B?UVpXWWtOQmJqOUxrM2I1N1RQcXptV0xPbklsMDdKdS9iaUtxNDczME5pbXBI?=
 =?utf-8?B?V0NHMlA0NVZQTUk5OHRNczBDK2EzdCtMR2ZXWGNsLzFlWEo2Q0owWDdOK1Z4?=
 =?utf-8?B?RXg3MFRHNHFWeWFRVU02Z2RYMVNJNVpKd1VXRXlqbUlTMEV4VnRvQ0VHdlQ2?=
 =?utf-8?B?c2gvQTFhMEF1djN1T1hmSWZvV1Y5NXpYSFcrbW1jb0hOTWc2ZkNCeFhIRTNs?=
 =?utf-8?B?TWtiZjFBSTAzbU1JQUs1Mjh1aCtVVmcxSWhmMGoxVTU0dStCS21ueTJGK2Qw?=
 =?utf-8?B?RGtVS1VJY0pUbXRwZk56R1ZFQU1RQWJERmNKNEQxU2lWaEdrSzAzNVlVRVI5?=
 =?utf-8?B?NXFhamUvVjVmWDN2SGlmd0lnWTdsTVRncjFOU1FUQXhvdmw2V2pBREtFejQx?=
 =?utf-8?B?Q2hqNFl0L3ExdUFUNXNTMEorR00wUDdjT2pIVEZ5SzYwZXFyK0NneEd2ZE1q?=
 =?utf-8?B?SFhLUzNZYXU3MVcvUXo4WXJISEZNOGp4eTJSc0IzM2dFMTRGVVdXcHNpTThW?=
 =?utf-8?B?eEo1S2ZndGcrRHFobTR6TjZoSlYybzhIdWhpYjJ2ck1tcmZpWi9ZTEVUSUJo?=
 =?utf-8?B?NkI1Uy81NTEyMEE2RHJDT3g1WGZ6UzB6WkNibzNxNGt6R3FtOFRjUzFmTEF3?=
 =?utf-8?B?eGJNNDF2YWVkRlV5S2JOU2lHZVc3bGVVaXNaTmFiWHY5ZHF5UytXSFA0NHdJ?=
 =?utf-8?B?MWlZd2RwYWhoeTVYV0JRenpweFh4akwrczM4bHB2VW94KzJRMHUwZ2kwYVVW?=
 =?utf-8?B?aG1hOHJxZUs0dUFnM3FZTmNkVk8xaTh6cDZ6emtIU0lLMzJkQytucUF0dEs2?=
 =?utf-8?B?MXpwaFFLc2x3K1pjUHhqUHJvYW14dHM5UHQ3Vk1TTGM3RkZGVnNjL0lCRnYr?=
 =?utf-8?B?ZnJKWUV6b1VSbEg2UC9mbFVkTEMwakFpcjRXa2o5UlZYajlVclppK3pZeDN1?=
 =?utf-8?B?KzUzUEZxTENtdGxBMVo1dFgvSEVuRXVjZTdmcGJiUm5NZERqYzIzZ2hleWV2?=
 =?utf-8?B?dmZHcnAzNXNTdXhPWXpRcTVOL05pMXdsU1JvcHBQN1N5WjMySVY3ZWRNMTdj?=
 =?utf-8?B?ajdITVZKK0R1eUZmdzAvSmx2Z1dnNkl1SFNpLzhSNGlLTFlSTFVWYkRPRk1M?=
 =?utf-8?B?eUNBdGtFWG1kdnRYVElLV051dDFQYkc5K1h4eXFIWEtmTDF2eHNnZDYxWGk3?=
 =?utf-8?B?MUUwdzRqSkFXSHczV2N4bXBWWDBUK1c3VTNyY3RmVWp1QmxGeHkveDdHRGth?=
 =?utf-8?B?bXMwMUd3MEo4NEtlRkJNMUZ2cVkwZTRuR000LzdXc0RwY1g2N1pmVWNPWTU3?=
 =?utf-8?B?ZzRaVmdQWkdwamNVYytsMmhrQ29sU3F6TlZkR3BNeWVrS3RUSjI1NzhMZ0o4?=
 =?utf-8?B?dGNRMFM1Q2tIVzdjdVRtbFR0TDhZM1lhOGVTWldxL2liNmVRNkM3SnNKQ004?=
 =?utf-8?B?cDJQMDBrUi9scU4xZ3pocG9vS2EvOU5zazlHVVZHWkIzdjZhQnBDY0FCajdT?=
 =?utf-8?B?SHJJbXV0dFplQnptWHpzVG1aK2R2NDFsd0pnbFhVVjBETlUxdE9GMnc5N0lz?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z0fOEAKCY/XhfmZn4vHCTNDV/RD5auN9VPuxkAJYrNAt8vYo+9+H8yEH0MHzZnUGjqF1oOAFDNhhnDL644JLRm4f7QfjHT+1uVVDHsspbqHo9QdJnwg9r8cTpesF3dhPvO8etFxWTjvE+rZw8AVI51hLBSWlDenEr08YQlIALZSlB8ZLvEg3oxyPc1ctsIja0GENfOCgwNQzcjlsN0QPU/0zSObyMaqNy0hpSa1NdIExtwY6bt6lQg0eONVfRZt1j+htfel0BxtBhCwj8jX1k6Yk5JcPYBFEaSGlobrrS7YFe3smUqxkaivjwOwK0kSpxckZfIzPb2BXllKZUZRM/fhp8IK2IOTj0IIM28q8xvaF7VSOuicQxpxTw4BmVB4zJcevzguYqKAtspRAr5PzXqVL2m0MmPC11HUAP82PuHJ7YvT9N46vBJOyNoeptfzoLxsKRwj4CcgL9sP+HdZBl9thyKdTu8ErzNvCmT7JlPRMjSwyM/HO6VaMGfs3Ifuy0coj8WzWbOp4FXNEqp8vvMUeUXyBwfORItDQelcFuS/6pYydolKIjKzRFcvcUmWNSt5Zj2lLyL+FZmKx0KEb0H1zFJKHdn5jXYgXnrTFUpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafcfd1e-ef95-4227-21a6-08dc2f574534
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 01:25:05.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVBPzGC+2sSf5dhRh/xCP2vwZP7mbTgsIJhT86sbJTVyLaqJSnkUPK+GrMrT10M2vSdz/ZdkTG5+XMGH1vdXFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_25,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402170007
X-Proofpoint-ORIG-GUID: k_F1ITZgrafdU5zKBj-xsjv5K0xRlxGU
X-Proofpoint-GUID: k_F1ITZgrafdU5zKBj-xsjv5K0xRlxGU

On Sat, Feb 17, 2024 at 12:31:34AM +0100, Dan Shelton wrote:
> On Thu, 8 Feb 2024 at 23:06, Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> >
> >
> > > On Feb 8, 2024, at 4:45 PM, Charles Hedrick <hedrick@rutgers.edu> wrote:
> > >
> > >> From: Chuck Lever III <chuck.lever@oracle.com>
> > >>> On Feb 8, 2024, at 3:26 PM, Charles Hedrick <hedrick@rutgers.edu> wrote:
> > >>>
> > >>> We just turned delegations on for two big NFS servers. One characteristic
> > >>> of our site is that we have lots of small files and lots of files open.
> > >>>
> > >>> On one server, CPU in system state went to 30%, and NFS performance ground
> > >>> to a halt. When I disabled delegations it came back. The other server was
> > >>> showing high CPU on nfsd, but not enough to disable the server, so I looked
> > >>> around. The server where delegations are still on is spending most of its time
> > >>> in nfsd_file_lru_cb. That's not the case with the server where we've disabled
> > >>> delegations. Here's a typical perf top
> > >>>
> > >>> Overhead  Shared Object                                 Symbol
> > >>>    44.87%  [kernel]                                      [k] __list_lru_walk_one
> > >>>    13.18%  [kernel]                                      [k] native_queued_spin_lock_slowpath.part.0
> > >>>     7.24%  [kernel]                                      [k] nfsd_file_lru_cb
> > >>>     2.61%  [kernel]                                      [k] sha1_transform
> > >>>     0.99%  [kernel]                                      [k] __crypto_alg_lookup
> > >>>     0.95%  [kernel]                                      [k] _raw_spin_lock
> > >>>     0.89%  [kernel]                                      [k] memcpy_erms
> > >>>     0.77%  [kernel]                                      [k] mutex_lock
> > >>>     0.65%  [kernel]                                      [k] svc_tcp_recvfrom
> > >>>
> > >>> I looked at the code. I'm not clear whether there's a problem with GC'ing the
> > >>> entries, or it's just being called too often (maybe a table is too small?)
> > >>>
> > >>> When I disabled delegations, it immediately stopped spending all that time
> > >>> in nfsd_file_lru_cb. The number of delegations starting going down slowly.
> > >>> I suspect our system needs a lot more delegations than the maximum table
> > >>> size, and it's thrashing. The sizes were about 40,000 and
> > >>> 60,000 on the two machines.  Systems are 384 G and 768 G, respectively.
> > >>> The maximum number of delegations is smaller than I would have expected
> > >>> based on comments in the code.
> > >
> > >> When reporting such problems, please include the kernel version
> > >> on your NFS servers. Some late 5.x kernels have known problems
> > >> with the NFSD file cache.
> > >
> > > My apologies.Ubuntu 5.15.0-91-generic , which is 5.15.131.
> >
> > That kernel is likely to have file cache issues with symptoms
> > very much as you described above. The issues are thought to
> > be addressed by kernel release v6.2.
> 
> Is there a way to turn the file cache off for nfsd?

It is integrated into the operation of NFSD, so it cannot be
disabled.


-- 
Chuck Lever

