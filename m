Return-Path: <linux-nfs+bounces-10204-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE160A3DCE6
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 15:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CDC27A697E
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E071E32BD;
	Thu, 20 Feb 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hMEKBL+r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aLOsKx8C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0D1BC4E;
	Thu, 20 Feb 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062018; cv=fail; b=LTQa9e1eia3j0PcS1vPnQorgX5PPDINo8O8Hzs+BC4hdmzNXgmOs/N/PTKiiq1YxOLh5sl4LMlBuI4s1iWICiqp0WhaNhhSH9YrfUPNo8TcHim8QNm+p8gClJsWd0FL3ZWCIotwq7br1tU7Q72SAJPl7yFkwEaKCt/KMd5XLFs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062018; c=relaxed/simple;
	bh=1kYS3KYGE1MZvNAiKdi9PPEkPGnmFYlIITNT1huJ0Oo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AOuQzMIp2V26DGjZexs0PI/1B4uLon1S0rONlitiq3ih4os2uHxgIGTIuQAeV61rMnHaXPTjZyo32L/Fy8hFH3iHc5XBpRuA/3u86VhvkTcYBn52kTgvK5v/iOA5b5ri4UP692yJz/8dTLTwRasEZ0EKujgSNgOXOw2Es4CBV8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hMEKBL+r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aLOsKx8C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9fXbh020876;
	Thu, 20 Feb 2025 14:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UoMa6u34073oDCIgts3pR4G4alwLJ6kM2cpXfYOVq1k=; b=
	hMEKBL+rq2JJuwyorsPWLbSnW6sCHJFkcTAhM2FrQJYk0u9eFSiv+ihP6vxConnB
	/IrEL7EV0CjPyvUsc78AeKoNhx3OMqZiQdxO44I3oGJDcF+rLTeVAZe8OKiMILuC
	9v9Xh/d3NdU9+J7fLAKet+uSpXRldAVl6CppK1r/I1x3cHeZsNwgytHQTrjnnt7Y
	X1xz52MWnlTg4cArgsSfR3f4tBkRRK12nwZpZqfACGFgGgV3fazt+Byihrh7bQd4
	WzvtMRq2VOkYh6LgBkSPX0vkSh/YLCP3CxUvFeAUWgSXtZJg6bR5Xv8eGUwRJaeR
	nQwwrWC5KeMsCkPUWQ+O1Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n4846-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 14:33:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KE6UCb025346;
	Thu, 20 Feb 2025 14:33:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w08xyhw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 14:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7wp+kgorAXne0IWkBqeoS9WcZiqp88BmEWq9xmqThr0lY0didZ9+ytqzCOlDaiKlA+NTmWYTLyHP30YC9Z/0WHfprHR4jpg9kpJT8LuIto+B2D7UzNpB+6KUtgjsGSmZPKchB8YePltvrfAricZBwAce3rSY5tBUJnlXMeJ0JyaGR2r655qWH2s9fHvwxbVaZHP//3nV1jrmWxNlDI4C3IKJTF0AaHrYkiuLi3Fz73EtD4fbuH44zgBkMu1t270Otn5gv8wRhRAAicB+Swp6WdY59W/bu2KisfyPHbcrWRhA4YAajtjc3u45kJ6/p6JtBSyvNBTVljDajyR3CVt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoMa6u34073oDCIgts3pR4G4alwLJ6kM2cpXfYOVq1k=;
 b=fVjE6ma3uNvES7nh8ySvkDOzkB5SqiSFGls1hJUo3Jn2UgY8AzlpHsjWe2OrihQolHLCNDdArQ8e5obMLURJHUjCjd33cX6sMnn2fWM+knHX0/JR/Ity2GWHYUtpaohzYXOV++b4ZXVhqVjhCC7tWJL66BrrdkHaxb0TMH/ccS22Tbs/WXUsRBZsIq3Z/21NNHAlvOBtXjm5B4KzIvN9PDnEEznHdPw7gUx0PN3/k6sSrdBjVBuyb23FhF/AS0EPMVQdh5TzwtjV6+V4si5c8ThT4ZiZ8hjcsNqzzhj60z/Q9sWt/f0RQhRW8hAMLv7dnseakeA6kcuBMhAUHDev3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoMa6u34073oDCIgts3pR4G4alwLJ6kM2cpXfYOVq1k=;
 b=aLOsKx8CKZSfXbHTOEfp1RgAiuzKIesl8VLFR9tD4k7kncRuWInkQ6hTZhn0EJ+H7oe35MBuztMHztQdKxDvJVvMwP4bHf0hBQu+WeJX+3zZWUlGiHTJAgX9NTxCF4iaw1jy+m8COaqnwNtfjPfVn6DphLZuVvWs0zDxzaGuGpg=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CY5PR10MB6046.namprd10.prod.outlook.com (2603:10b6:930:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.24; Thu, 20 Feb
 2025 14:33:25 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 14:33:23 +0000
Message-ID: <1bc9dcfb-8c60-459f-8a07-f3649ffcf64d@oracle.com>
Date: Thu, 20 Feb 2025 09:33:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd 6.14-rc1 __fh_verify NULL ptr deref
From: Chuck Lever <chuck.lever@oracle.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc: SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeffrey Layton <jlayton@kernel.org>, Paul Moore <paul@paul-moore.com>
References: <CAEjxPJ64Nt6OHzi3V-reGnyxujGJpw4ZoH6f3H=4XV2QmHWnwQ@mail.gmail.com>
 <b0e214ad-ead9-43c1-b9ec-cf8f365079e0@oracle.com>
Content-Language: en-US
In-Reply-To: <b0e214ad-ead9-43c1-b9ec-cf8f365079e0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:610:118::12) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CY5PR10MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c66e3c-9e16-4f3a-fe6e-08dd51bb8775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDZWdEw1T0hRRitSZCtjd01qWmFabjA4R1diVEVGdnE5SXE1LzUyRjVtbkd4?=
 =?utf-8?B?ZUxjeVpZalZsd3o0SDExdmRyREF3UjZhV3MybnR5NTZaSk1NcWVuL0J5WEtK?=
 =?utf-8?B?MVVlb1hFNXlPOHBOSXFNSHZ2dUhTN2pYZnZSMnZjdytWV2Vyd0d6cEhzQk40?=
 =?utf-8?B?WXMybWJ5eSs4Zi9hY3JaM05iYjBUcHBRWDUrZFhHZTNJaDJocXhVYjhEVnRF?=
 =?utf-8?B?UU5ldEsrRnpSQ3luc21VbG5yU3FvQzZXSkF2SWhCRURIeWF1ZWdJMVlTSTFn?=
 =?utf-8?B?a2pGV0JpdVNodUxSV2JrYnl5NFNYaDkzakVTdkNxTlViTkVVbkVoWXFFblhQ?=
 =?utf-8?B?S1J6cVovNU1mcm9oeDNsc0psbU14a3NwQmxnTm5sMjlJb1BiK1Z0TDJWTUN4?=
 =?utf-8?B?elZhdWgrd1pJRENFRDBJT1hnM09BYlRBbXdZM245WVJPa3Vlc29qb2ZsdFZm?=
 =?utf-8?B?LzZuUlQxMTAvcnArMk51TkJKeHZaM2RkR2xJcmxSL1J3bmFqRmZpdkZaUTBk?=
 =?utf-8?B?WXhKaDdMVldPOXlyVU9xRk0rWHZIWXM0aFBiY1V1NFAxOUM0SU5CazFzcUJn?=
 =?utf-8?B?V1NqMVpPNU9YalEzNTJjbWRnckJTUDNpckdFbkdLWlFmOWJDeWtST2JQTnha?=
 =?utf-8?B?YlBZSWhOOGVSSmlpZEZTTkFTTWVNNnA5R015M0c5Nk9TVXZxQUpRaitqb1Bk?=
 =?utf-8?B?UGJRMFZjL0JsNU5TcmZrU3ZJVGZTRGVaQlBTWlF6Y0VUWXNoUUFTWXZSbkgw?=
 =?utf-8?B?ZlBPbzk1Z0lHRXN6RnZuRkU5K290KzBMKzg0WUFHcU9OS3FZUHFNdnRMeE50?=
 =?utf-8?B?ZU1JRGFOOHppSXhrTU5nc0I1eFJmbTk0dXgrYVZHK0F6aWNXV3J6VnZXdTdU?=
 =?utf-8?B?cnVxK1l3NmdsVzR4bFlOQUtKYzJKaW5vWWU2eUVyeGFZU3E1NXBUMUNlaW1T?=
 =?utf-8?B?eE5tRTRFNjdEZW1peGFucVhRNTFxNTRWUWhFVCt5Qzh2Q1ZCY2cwcm9Ka3RY?=
 =?utf-8?B?a2NhaUY3bkhrc0RDa1ZGMGdLL2x2OWplNHc3amJ2TFVVczRHN0o0bTVqNW9z?=
 =?utf-8?B?M0twaWl1TnY2a3JEUkZBelVyMW8rUUJ2N3hLV3Q2ekJyUm15a1RTMFE3MUZ2?=
 =?utf-8?B?L0JObzdNQm1IL3hxZERHd0Q5V3JTZkRSMlNhRG1mMDd3aHFEZngyVkhURVBU?=
 =?utf-8?B?QXNJelh3WnY5VzN0VUNnbzVicm5hUi95YTdsTkIxWER5Tnl2Rm5YQWVMNExz?=
 =?utf-8?B?bkRSL0FUaDBQVmxUVlRCRGREZlhZSytQN1M4a2lvYTd0YXlFUzdEVk4zaTBE?=
 =?utf-8?B?QXBhMHJyQmNrOUpOeXdWUkFJanovZHk0RXIvQmlONGgrZkRNRHdyU1l4bGps?=
 =?utf-8?B?bjB1TlNBRHhzUDhwRGpSMDFJTFAwMXZHbHpKVFUrdXVkc2dPK3JvV002U2wr?=
 =?utf-8?B?VTFTZGZ4bnVMOU5Xc0wwRWpLVW1VOHZxZkx0RmNCOGtzSWVqYkNRVi9nNnJn?=
 =?utf-8?B?MW1vNWd2RnQ0dCtnZXZlOUxwRkJ0eVNZTmd3R0IweEFwZU9yc3Z6UTNYWXAr?=
 =?utf-8?B?cTlnSmhVWEN3T0htTmQxVnFTODdMYjc0czZ6SHZud2dLZlNpa0s3OHExSmVa?=
 =?utf-8?B?K3RmWTN5dk5aaGNacCtrTk9kK3Y2dndlUENVeTVhcWczbTd1Z05KL2M1T1ZF?=
 =?utf-8?B?ZW1UUWtwcUEvcUpVeEdWYlN6MzF0MzVoeEpqTW1mdWEzZDE2UjhSamhrS0xu?=
 =?utf-8?B?SllkV0xaeDAxZmw5cTdzejV1MmFjaVlpd0tpcXBOVW0xcS9XcktMSDhnZXBR?=
 =?utf-8?B?Q1YyUG11WUUweWw4cGhoTEJVVW1zMFB1dnN6aWZ4M3h6S0t4bVZtVkFJWExi?=
 =?utf-8?Q?b1NkP8gh6s/0U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHB0dVl4ZXhtS3JqM0JrTXdhYTFZUFhZZW5VbHJZTHdRSnQ3a2tMOUdyMnpE?=
 =?utf-8?B?OUJVM2tOOEZBaDhSc1hsbm4rS0hhdEFhNGl1SW1CRmVSRndwMEVCcHRGMVY5?=
 =?utf-8?B?bnNlcjlQemloM1hXQUMzRks4ODkzVmZ6bVBrNndWRWlJSFV3WVhaT1FkdTdD?=
 =?utf-8?B?YlVPdEdDVDJzMHFpeEJ5Q3VuWFI0b05iNUltS3R0Q0xTMGpFdFJndHR5NWJr?=
 =?utf-8?B?WUxHdGQ5d1VNZGxJOTJoZnZvQjVaN2VnaDlEdnhuL2JhL2ZkRjhqUTU1cy9p?=
 =?utf-8?B?NTU4Unl2dWs3ejJhSEFZM04yUFl2cVZId3E3QnRnaXF2ZkNUS0FEL20rTGMw?=
 =?utf-8?B?dDlJWFU2SU5vdzNORUhFbEhoV2VXb2pVZmxUQjlWb0VGS0p1SzZObXpZY0lV?=
 =?utf-8?B?UzRKYmpscEpscmRCbmFONmNmdnFCeGhkdkVwS0R1MDVKWkRZSmM1QVFYbE9L?=
 =?utf-8?B?M0k4V3R0ZmNxYVlWaHZ0N2htQzNjc1g1bDNHK2h6Z3d3TWpiNldyY2VVQU1F?=
 =?utf-8?B?YTFyUkt5RzZiK2d0ZWUrbVBIY3g0YXNPR1c4YklVQVRTK2FnRjVPQ2o4THoy?=
 =?utf-8?B?cG10ZmFVQmszT1liNS9oeEZoNW55YlcvSWhSR3NORThNdzM2VUlpV2hsaGd4?=
 =?utf-8?B?TzM5MU9rdzZzSXZldUhaM1FXWkVmQU4wenJ5dTV1YkRpNVkya085c0hGU2pO?=
 =?utf-8?B?L041RWhXd2I2bmFTWm9neDdHSGg2cHpZOGVrZ1dPNlRlR1cyeGUwc2dDNFVV?=
 =?utf-8?B?MHJaejRrdTlNOFkrWDhWSEZadzB6ZnltRUhaNWxQK0t3b1MxUldJWENuT2E1?=
 =?utf-8?B?aEg3NllWNkpVUjZJZHlnNSt5SEwrMDU5R0R2REFjaHR6c2RQak9sb2IxMEpr?=
 =?utf-8?B?MDBlaW5Hc0FnT1JkZWRSWi8vbFN0Y2g5bnVvRVZNWS9mQ2tKVWkxQkdkZ2pN?=
 =?utf-8?B?bUp2eGUySXdXMkcvTU9CVzYvd1FYNXFGVm10dHRHY0NMOXFGVHZqMUpXOWtm?=
 =?utf-8?B?OVRadFBOWEUwYWJNTlBFZDRGZW5iUWRMc3dLMjdndGlFU0JRMkU0Nnl0Nnl0?=
 =?utf-8?B?aG0yNHh6Wm5pU1B1MlFYUlNJOXpJeWQvQ2VhcHYxbU1KMzBvSEJ0YTZ6SnNs?=
 =?utf-8?B?M0YrZjhLTTdBWDFyczRxOWVoaU83ZEJvVzNBNlhsQ0JtWlN4eWx1Rjh4ckFq?=
 =?utf-8?B?MzZvK0Z1algyQndkenBoY0FFVWVFZFRUN2J1WmcxSXJWUVBobktlTDRTZjBE?=
 =?utf-8?B?K0dUZjhlUUxkZWY3QVZGd1F5Um9RZjlNYzdUL2NaSUh0Tlg5RVVHanMrMVBK?=
 =?utf-8?B?ODhDNDFibDRhOStXZW9LaDBKTG5wU24zeDFRUFU5R0dzOS81aFFmSDFnaW01?=
 =?utf-8?B?MEpJd0NRRDJWWUptYlJsWkswTGZ3Wk90c1ZBc1NQUnQvMHBNdG05djFRa0Vz?=
 =?utf-8?B?a29WUC9DdEk4UGU5NVhjdUhxTUt4cWU4R2lLUDd2aldrcElrWmgxdmRHVW95?=
 =?utf-8?B?WXhhRTJ4SDZPSldDdGdibDR4RXh1akNiWGRJcktxRGViRXVpMTcvYUduTUZs?=
 =?utf-8?B?MzNOZGxFbTdUdUtMc3Z6T1luTU5RWTJVL29QS00rV2tXck1Lc0o3S0RkMURr?=
 =?utf-8?B?MWxnUHdlRW9WanVzNHh1a0xFaWxZbVFoTG1DSGd3a1RDOTR3aGFrelBsUVJI?=
 =?utf-8?B?dmhhSWRKeHdIa3NvalJTR2VQQXNqUm1qVVg3UWtmemFhL0dEdklkVTFOOVUv?=
 =?utf-8?B?eERaV1VIL1ovbkVSNEhzOHBJekI2VG5WVUZOMjNuSFAva0h5RXdSSGI0RjFu?=
 =?utf-8?B?eWFDVWFRUWRYajVZTUcxdDEyeGlodE1nVkpUVDh6Z1VPekN5VytqYlVDbHdR?=
 =?utf-8?B?RzhLVy9JK3ZiWEE5dS9xTFZwVy94cGhXMTRBK3Eya1BtTTZaNk1rN20zYTYw?=
 =?utf-8?B?aW9RbDNWOXhuODl5V0I3L3N1OFgvMHZPNW5mdHZ2NGlRVzdiT2xvTjhLN25P?=
 =?utf-8?B?dWNrRnpJNGc5QTA3cjB5UFVlWFNnSmk2NDBsanYxS0xHZEFTWUdZK0FUVlZH?=
 =?utf-8?B?a2dRRnhVNVF5UDFRaU9qYzU3WlFvQ1pwU2ovaFhjV2E1dmdzOEJMU3lTWE1Q?=
 =?utf-8?B?LzFqQTlySm9ZaFlydHJzc2ZNL2xtRUdtTXhXT1V3YUxNWDBnREQzSkRtaCto?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DOwGa14aKF6/5cDzbZ3gTyWmjdhQ4gc8gexJy57+xn6PDpT0BhKgqVd/Bi4jjeGtcandHl7tdjP98LHq87NEnGUmooOY9y23FniBD8wOi9ZimE2Xc+l8MYQkUQgcWG/oMDufc0hKrWkkm74VcnEx1U6p4QE8y/T+gRMmpaLkl+a9mf2kjQw8ODHBV36Mu2OkbVOmbfD+6g73JdOTxG57mMDG7gQgaLj4SIVBJX7hlcOgxs0qH5zwxDfSsUCPvAsAD+saKJuprFKuQZG6ykoiBJQ1wgE5mwFv0mA2oLdF9aX07r8tiHNqu7KDpam5rU/NZy/5+eOu1/F9o0ykDbytLrSyQ/lXNigJdblP6DWbdEWwY2DFuP5wX4R07M/oM+n30g9IlevnbfPvmfsQezAfXtJx1k9OaxnbRxUWOIzqmwV9xUrGPdzE5CU94yEBTbsLyvkCk2T6MnHk4RqeI11DpnQzEWkOPhAM8WyvCa3OQdN3SX/tqQpmPvBaae7NsnztSBderc65lyDqhwNw1TXg63ByA3xrAcuVcfaJF1MhRen5Kqofj5jMwqVn/GQLLDQ4ccOzKHvvd+nqnpdIP/mTAGJw7/QQUCHIwUK4VDU0yFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c66e3c-9e16-4f3a-fe6e-08dd51bb8775
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:33:23.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXSiZ4t/E17JKtopKGGJoM5HHsaQmZxHymKrEf6lzlYm9YSWTZcdPzNUDK1XqXfwjtRiuU8ydaoIYUeVCcHdpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200105
X-Proofpoint-ORIG-GUID: iyKT1G74Dgm60R8QOl1YhCa6V1FB5TPM
X-Proofpoint-GUID: iyKT1G74Dgm60R8QOl1YhCa6V1FB5TPM

On 2/20/25 9:31 AM, Chuck Lever wrote:
> On 2/20/25 9:27 AM, Stephen Smalley wrote:
>> This was on selinux/dev so I will retry with nfsd-next too but I don't
>> believe we have any nfs-related changes in the selinux tree. Config
>> attached.
>>
>> Reproducer:
>> (enable SELinux)
>> git clone https://github.com/selinuxproject/selinux-testsuite
>> install dependencies as per README.md
>> sudo ./tools/nfs.sh
>>
>> [   55.726787] NFSD: all clients done reclaiming, ending NFSv4 grace
>> period (net f0000
>> 000)
>> [   55.754588] BUG: kernel NULL pointer dereference, address: 0000000000000028
>> [   55.754608] #PF: supervisor read access in kernel mode
>> [   55.754617] #PF: error_code(0x0000) - not-present page
>> [   55.754625] PGD 0 P4D 0
>> [   55.754633] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>> [   55.754642] CPU: 4 UID: 0 PID: 2720 Comm: make Not tainted 6.14.0-rc1+ #254
>> [   55.754669] RIP: 0010:__fh_verify+0x473/0x7b0 [nfsd]
>> [   55.754755] Code: 01 f6 44 24 71 01 74 09 4d 39 75 48 0f 94 c0 09
>> c2 0f b6 d2 48 89 ee 4c 89 ef e8 b8 80 00 00 41 89 c4 85 c0 0f 85 48
>> fc ff ff <48> 8b 45 28 48 8b 50 30 83 e2 10 74 2c f0 48 0f ba 68 30 11
>> 72 23
>> [   55.754781] RSP: 0018:ffffa12a410eb358 EFLAGS: 00010246
>> [   55.754791] RAX: 0000000000000000 RBX: ffffa12a410eb508 RCX: 0000000000000000
>> [   55.754802] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90590e38e400
>> [   55.754812] RBP: 0000000000000000 R08: ffffa12a410eb200 R09: 0000000000000000
>> [   55.754823] R10: ffffa12a410eb260 R11: 00000000ffffffff R12: 0000000000000000
>> [   55.754833] R13: ffff90590e38e400 R14: ffff90592be77080 R15: 0000000000008000
>> [   55.754844] FS:  00007f2eb9c1b740(0000) GS:ffff9067ff800000(0000)
>> knlGS:0000000000000000
>> [   55.754856] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   55.754865] CR2: 0000000000000028 CR3: 000000010c262006 CR4: 00000000007706f0
>> [   55.754897] PKRU: 55555554
>> [   55.754904] Call Trace:
>> [   55.754913]  <TASK>
>> [   55.754920]  ? __die_body.cold+0x19/0x27
>> [   55.754933]  ? page_fault_oops+0x15c/0x2f0
>> [   55.754944]  ? exc_page_fault+0x7e/0x1a0
>> [   55.754955]  ? asm_exc_page_fault+0x26/0x30
>> [   55.754966]  ? __fh_verify+0x473/0x7b0 [nfsd]
>> [   55.755023]  ? __fh_verify+0x468/0x7b0 [nfsd]
>> [   55.755069]  fh_verify_local+0x27/0x30 [nfsd]
>> [   55.755116]  nfsd_file_do_acquire+0x59b/0xc50 [nfsd]
>> [   55.755167]  ? get_page_from_freelist+0x17d7/0x1bd0
>> [   55.755180]  nfsd_file_acquire_local+0x4e/0x90 [nfsd]
>> [   55.755229]  nfsd_open_local_fh+0x121/0x190 [nfsd]
>> [   55.755285]  nfs_open_local_fh+0x96/0x120 [nfs_localio]
>> [   55.755590]  nfs_local_open_fh+0xb1/0x200 [nfs]
>> [   55.755908]  nfs_generic_pg_pgios+0x96/0x110 [nfs]
>> [   55.756190]  nfs_pageio_doio+0x3b/0x80 [nfs]
>> [   55.756450]  nfs_pageio_complete+0x7d/0x130 [nfs]
>> [   55.756727]  nfs_pageio_complete_read+0x12/0x60 [nfs]
>> [   55.757000]  nfs_readahead+0x244/0x2a0 [nfs]
>> [   55.757255]  read_pages+0x71/0x1f0
>> [   55.757488]  ? __folio_batch_add_and_move+0xbe/0x100
>> [   55.757712]  page_cache_ra_order+0x272/0x390
>> [   55.757934]  filemap_get_pages+0x140/0x730
>> [   55.758176]  filemap_read+0x106/0x460
>> [   55.758397]  nfs_file_read+0x93/0xc0 [nfs]
>> [   55.758638]  vfs_read+0x29f/0x370
>> [   55.758855]  ksys_read+0x6c/0xe0
>> [   55.759083]  do_syscall_64+0x82/0x160
>> [   55.759334]  ? set_ptes.isra.0+0x41/0x90
>> [   55.759567]  ? do_anonymous_page+0xfc/0x940
>> [   55.759799]  ? ___pte_offset_map+0x1b/0x180
>> [   55.760028]  ? __handle_mm_fault+0xb6c/0xfc0
>> [   55.760287]  ? __count_memcg_events+0xc0/0x180
>> [   55.760526]  ? count_memcg_events.constprop.0+0x1a/0x30
>> [   55.760751]  ? handle_mm_fault+0x21b/0x330
>> [   55.760972]  ? do_user_addr_fault+0x55a/0x7b0
>> [   55.761188]  ? clear_bhb_loop+0x25/0x80
>> [   55.761426]  ? clear_bhb_loop+0x25/0x80
>> [   55.761619]  ? clear_bhb_loop+0x25/0x80
>> [   55.761806]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [   55.761993] RIP: 0033:0x7f2eb9d05991
>> [   55.762188] Code: 00 48 8b 15 81 14 10 00 f7 d8 64 89 02 b8 ff ff
>> ff ff eb bd e8 20 ad 01 00 f3 0f 1e fa 80 3d 35 97 10 00 00 74 13 31
>> c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48
>> 83 ec
>> [   55.762615] RSP: 002b:00007ffd23dd62b8 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000000
>> [   55.762826] RAX: ffffffffffffffda RBX: 000055939883d6d0 RCX: 00007f2eb9d05991
>> [   55.763034] RDX: 0000000000002000 RSI: 000055939883da40 RDI: 0000000000000003
>> [   55.763241] RBP: 00007ffd23dd62f0 R08: 0000000000000000 R09: 0000000000000001
>> [   55.763452] R10: 0000000000000004 R11: 0000000000000246 R12: 00007f2eb9e05fd0
>> [   55.763671] R13: 00007f2eb9e05e80 R14: 0000000000000000 R15: 000055939883d6d0
>> [   55.763880]  </TASK>
>> [   55.764085] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
>> nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfs_acl lockd grace
>> nfs_localio vfat fat jfs nls_ucs2_utils nft_fib_inet nft_fib_ipv4
>> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
>> nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle
>> ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
>> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
>> iptable_security ip_set rfkill nf_tables ip6table_filter ip6_tables
>> iptable_filter ip_tables qrtr binfmt_misc intel_rapl_msr
>> intel_rapl_common intel_uncore_frequency_common isst_if_mbox_msr
>> isst_if_common skx_edac_common nfit libnvdimm rapl vmw_balloon pktcdvd
>> pcspkr vmxnet3 i2c_piix4 i2c_smbus joydev auth_rpcgss sunrpc loop
>> dm_multipath nfnetlink vsock_loopback
>> vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock zram
>> vmw_vmci lz4hc_compress lz4_compress xfs vmwgfx polyval_clmulni
>> polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3
>> sha1_ssse3 vmw_pvscsi
>> [   55.764153]  ata_generic drm_ttm_helper pata_acpi ttm serio_raw
>> scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkcs8_key_parser fuse
>> [   55.766222] CR2: 0000000000000028
>> [   55.766500] ---[ end trace 0000000000000000 ]---
>> [   55.766813] RIP: 0010:__fh_verify+0x473/0x7b0 [nfsd]
>> [   55.767165] Code: 01 f6 44 24 71 01 74 09 4d 39 75 48 0f 94 c0 09
>> c2 0f b6 d2 48 89
>>  ee 4c 89 ef e8 b8 80 00 00 41 89 c4 85 c0 0f 85 48 fc ff ff <48> 8b
>> 45 28 48 8b 50 30
>>  83 e2 10 74 2c f0 48 0f ba 68 30 11 72 23
>> [   55.767785] RSP: 0018:ffffa12a410eb358 EFLAGS: 00010246
>> [   55.768119] RAX: 0000000000000000 RBX: ffffa12a410eb508 RCX: 0000000000000000
>> [   55.768434] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90590e38e400
>> [   55.768751] RBP: 0000000000000000 R08: ffffa12a410eb200 R09: 0000000000000000
>> [   55.769089] R10: ffffa12a410eb260 R11: 00000000ffffffff R12: 0000000000000000
>> [   55.769408] R13: ffff90590e38e400 R14: ffff90592be77080 R15: 0000000000008000
>> [   55.769726] FS:  00007f2eb9c1b740(0000) GS:ffff9067ff800000(0000)
>> knlGS:00000000000
>> 00000
>> [   55.770069] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   55.770393] CR2: 0000000000000028 CR3: 000000010c262006 CR4: 00000000007706f0
>> [   55.770756] PKRU: 55555554
>> [   55.771111] note: make[2720] exited with irqs disabled
>> [   55.771477] ------------[ cut here ]------------
> 
> Stephen, bisecting would help us immensely.
> 
> Mike, are you free to have a look at this one?

Rrrrrrrrr. Why does my brand new email client think you still work at
Red Hat?


-- 
Chuck Lever

