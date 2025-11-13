Return-Path: <linux-nfs+bounces-16356-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE7C5970C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 19:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53AFD4EC229
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6F2D8767;
	Thu, 13 Nov 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KjU01qb8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wpY4rp/D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD82264C8;
	Thu, 13 Nov 2025 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056072; cv=fail; b=E00cn7KduTdLmFd98zGmV7G7v//Oghfc5qmFMp1cCd8fcDIy3ZbgaRW+5eAHrBYDfT5h79xyQ3qBaMguXncbiZ13NBfTyctuPBxu+Am5ut+kq+U6K0/dZmWTo4hCXnZeDkFWZDIUJNp6WoiyfTyfZVh5c5s8WjbKrE9bBX2iots=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056072; c=relaxed/simple;
	bh=9gxMdvK2nC9wVwNizKOVZWqaXCByQu+EiFqDT8UF29c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1FFKFAmN+LuPLwr0bauBw+E5gBVCNcR5zAuHdtvZd63BqBAgrTq1NcD0UgF3Ts5AbwKpQVmpfXbCGr9PW4/mwhgt75UJzHK3NrxHyghbRjMSFyPr1IC3TDVnW2K0Byxngul1MKWeJ61XAcB9dG9w1L7whPyIuw1NGVHZpS97dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KjU01qb8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wpY4rp/D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9wBX024392;
	Thu, 13 Nov 2025 17:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RfXk+sfoECvjrIfmuhfs3yDaM58OVTputXt2d31GOB8=; b=
	KjU01qb8pc9D8GxYDl4F9nkf8uoTHeuKTCqEtk1F/SSjLlpNw9q+JHVQtFyqwGgh
	r2YJQXxgCDU2ToKA3T8pegk3j0gx+33af4CLDuHWuynw0NG0idoVMc79Ep9Zz5Eb
	F1R7KESeJLVMlXVwpn0pXrUyNemlymyOu9FiIWTGd5SJKHXWt4xZOKm0miC6pdOK
	GIOZU3j63M1ybg6qsBxRHaLwCdfwOojW2FNqxGJa+mUUZNu9QPebnWwpW0G6Cpso
	uMNcHIk6riANMpvPH66w5M/bk0YzgElRp6BOnnfJ1+2DgJ7C2EkxeTr3BPaOu5Qv
	7pKdFsQuSt6IlW9/5m8e/g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjta8cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 17:47:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADHEr6P027760;
	Thu, 13 Nov 2025 17:47:29 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vagh477-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 17:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fqa8mub7VTCKjQFoFZwW5B1bSINl1r6267gxiTO2Ih++jKoEiQXZOmqFqJEum8BOdTpoR9cQvbWLxFZZfD0wy1i1tMAocK307I9Et/71wA3yR4PXxTfRVTwOecpvMjN5fuJHdossUqfxEkgFcDGwe1ByiQtnAlrCO3EMqUkg8AMzfNOqsHaQM6DASmmmtVaplwx285XqKoT2CELV4Q9/mXX4yYwftM8ydb61RZFsO9o6y51oREPLP6bEyy5JKQaSNOMW5mna/F02eDPsnNMECsY/QRwIFwSu5/AficLq1QZzsWb1PWWjDtlQQoY6VEHYnwGmzOTaDbq44L3HZeMa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfXk+sfoECvjrIfmuhfs3yDaM58OVTputXt2d31GOB8=;
 b=dsSLlw9DFsJ8639a4OEJfTtp+JEcywrL51Y/s+E3QlNB1RtikrLt79dTCdTrAhoWzdmEXojARUt4kTWQeZeDVm0XaxB4dbP4Wk/4PUIKdz0+fDMgiU1sh+uD9DMIrHMD4Y3oKYEFZw9Tbhp/1mTvtSLuUC4Vbqr5uhhzghyYAOP/5ZHRQ8si0fDeXrHw20VZI8EWYGjgXlzotb1xK0fFO2ecL9+XjI+/klgw0MToZ9KD0tRbIvtl0AiWGNuy35gbIRRnjIeyd+tRAjRLrYSxJHDlkwevY3uBo+WrGp0XyTSJvnIGaOi4c3ack3HwYx58w/6LAnO9bJclGLXFbCvsnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfXk+sfoECvjrIfmuhfs3yDaM58OVTputXt2d31GOB8=;
 b=wpY4rp/Dc57viWwl0JkEkMd/sYlft5kqjpOrpT2OTTdUuq6Zn8uzlyEYuK6Y+rZvUCnOuwDiNCXcZpCENe6kuwcxyBa2tKYLRYfgvPUfJ7n5xF4O61zezCFYlrvMTHi0ls5hvvv79q8Zt5s3Y4F3xt5T1RXeFRCDyOSy2l0hKlk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH5PR10MB997692.namprd10.prod.outlook.com (2603:10b6:610:2f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 17:47:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 17:47:25 +0000
Message-ID: <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
Date: Thu, 13 Nov 2025 12:47:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
To: "Tyler W. Ross" <TWR@tylerwross.com>,
        "1120598@bugs.debian.org" <1120598@bugs.debian.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRVl8yGqTkyaWxPM@eldamar.lan>
 <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
 <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:59::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH5PR10MB997692:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adaf001-929c-4417-487f-08de22dcb49b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|159843002;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?a1VvUnZpWXM5dFM5TlNhaEZTeE1XYis5a0MwMm5XUGJLYk11c3NNN0Ixd0FD?=
 =?utf-8?B?RW5HajVoVHlkY3ZCZTRQejlRRk4wMWR2dU1vbTNCMlB3SkNOMGhMVlRGaFh5?=
 =?utf-8?B?dW5TVFhHUU5KcEhiQTFFZVJsRWI4dmVXczBIdXN6VEpxdGdGMG8xNEFrN0pq?=
 =?utf-8?B?OTZQTlZKRmFnMTNHMTkzNXdReDAvT2hvYlprSFNrazVXdXE1OEtXMksvbGpG?=
 =?utf-8?B?eGx1eGZSclRCZEhPU0dOU3IrM041QVloMXRsSzcvMS9xYm9wcGRrZkJjWWo2?=
 =?utf-8?B?ai9NdlpJS01QSXNQNHY1ZnZ5bTk5UWhrNXV1ek9zVThCU1laRGFpcmx5Q2x2?=
 =?utf-8?B?dk1ydkkxcEVqKzRaTXRCaHpiUk9hT1Z4V0c5K3hxR3c5NFdhTXZBb1FrWXNE?=
 =?utf-8?B?QW9DVmI3SFNldHB5NUdtT2pjV1RqS3V4SnE3YWQvcktlZUlwNytqRnc3dk4y?=
 =?utf-8?B?NnloMFJOTW9jQ1JXZkpOVkRTVzFxbUZzTDFJbWN2NThLRE9SdGdRYnNmVVVV?=
 =?utf-8?B?MnlZcWtrSmY4MlBZSTNobjIvSldwSWJmN1RBUXJNeDcrQk4zaHNISWcvSUFs?=
 =?utf-8?B?M0MyVUdpNWRVbU5ENVlEd1NhTSsrSVM3YUpxc1dHZk00WGVYQzN5UXl5OUNk?=
 =?utf-8?B?TmNMWUJoQ09yazlDM1VXRFB1d1hWZU1OQ0puYko0Snllbzg2UVlwOXNLb1d5?=
 =?utf-8?B?QlFGMGV6cWxtOHhzcjB1OXlQTThmazB2c0N4SkhRakQvdU5kOCtsNlJCTzZl?=
 =?utf-8?B?RXNtMjBsNUtYQnJhS0s0KzFoT0M2b2M5T250RW5ucDNHdG9GeVE4dlBZOWZH?=
 =?utf-8?B?ZUdsVlBqNmVPL3FPOHJLUEFaNDZuWTFYdlBoQmw1b0tJY0dmdTlHckJlaERZ?=
 =?utf-8?B?Y2trclpsZVJsdUpYUEtuanFJYVROUC9NWUtnbFFHMW01NSttTGkzUTlDRFJp?=
 =?utf-8?B?LzE3dkNkQlJVbXJRWW1KUXY5TnhzbHhleTRMM1FSTmEvQ0hJV3ZYOWkxaDZv?=
 =?utf-8?B?WFJaa0NwR25PYngxK2lmbWFZcUp4QUdiK2dLM011YTFORm9VVFlFQkRpS0xs?=
 =?utf-8?B?bktyKy8vQWUrZFJEY2lFeXNqVkE1ajVMY1JmTzVmZTNJSmFSSVdWeXRYd3Nn?=
 =?utf-8?B?eFhkd3pFcUlORWxHSTdGREF3aEgrUVVqUUlVSkp0RUxmbFdnZG82cmdrQVY1?=
 =?utf-8?B?ZU9sbFh5d0J5MWRaT0hRVklMNHdyZUUzUFowck5sVlpPR2o3UUl2WjV0ellX?=
 =?utf-8?B?VVlZZGZnUTAxZlJWNGo3UWh0ZFV5d3RHWGhuOEVqRjRETjc3eVdLa1BSdGM3?=
 =?utf-8?B?Y1MwOGxBL3lzaEJhTy8raHNvbVRTbGtJdWpVb1RSUWlLcUxIeFB1WGNUeFdL?=
 =?utf-8?B?Rzlyb1poYVRBSDQrK1dqdHU0MGd5aERiKzFVcGZickdxYUx4WVpsL0czQkJu?=
 =?utf-8?B?ZEVRRFZISnJ2K0pQTFhEaW1sbFNoSnpaQURjN3A1bDgyazh6bjV5SnFtQ2s3?=
 =?utf-8?B?UEpDV2U4MzlPd3RmTlFjTmZ4Wjl6MU9VaHNBTDhnOFFWUXdTaDVCOXE1V2xm?=
 =?utf-8?B?RjJnYlRPSzl4cllqUXA5UUhRQWt0L2pZTjhDRk1XRVpaNmhJdHJsTk01SFVT?=
 =?utf-8?B?QmpueVVEc2NFRmUwSi9kb21yRkRkalkzMHlOUXhSRk5mL1BFZENYQTJoU09n?=
 =?utf-8?B?Mk84dXhSb3NIRW5ubVBIakM0ZnRrN1dEcW9xQ3VjcElMWGxIajJ0MGY4SFBu?=
 =?utf-8?B?OWNBWlV1WjRNSUQ5Sy9HVnZicnphR1ZTNFNmNVRRNngyUFc5SHBGQTVDQVRT?=
 =?utf-8?B?UE9Fc3A0U1JlMzZwc3dsdXppZmJ0ZkVKWjM4c3dYZWJSa3RDd3lvMTFFTjBB?=
 =?utf-8?B?NjRPeTF1eE1oOHREWjl4bnREdDVwRzdydTZLWCtHNjNSQndUNTUwV2lZTFRv?=
 =?utf-8?B?R1JSVUZUVW8rQlk1Lys4TzV6TCs1cW9QZ0VCOUlFNzN0VG56bWxjcHFqdVkx?=
 =?utf-8?B?NW4wYS9hVDhlTGxlV0w5OWloQzJRU2JOWTQ1V1hVY0hlYUNzVnNwakIwUzgw?=
 =?utf-8?Q?23x7F9?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(159843002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q0VUeEtXWnEveHhGUlFGeGtsaG9NZkhMNUlIQk5nKzc4anhwUVRaQTNtNFR2?=
 =?utf-8?B?Qk9KdzVaMGNlUGZLSjA1VEZPdkJ5akZvWE5BOEh5NExQaStZRnVIY3I1Ui9n?=
 =?utf-8?B?eGp2VGliSitnRWZEYVZsYlRJeFczWC9uYzhDYmdxN05TSkZ4WUY2UThsaThR?=
 =?utf-8?B?alpPSGo2ZFR5OHJ3bVgxa0RnT3Y3WGR3bk8rVTI1UW5TSzFWL0ZPT0ZpUk5w?=
 =?utf-8?B?QmJUakVrYmQ3YnFkdXk1N0NTc3FCUm1FcE96L05HUHBvY1h1NlprM1A4aVRD?=
 =?utf-8?B?RnFjMWtpc2pBQ0t6MlFuYkZBaU1Rb0VUZ0lQZmVsZ0gydHBxdS9lQXhYWnhD?=
 =?utf-8?B?T0FiTGVicWN3M3ZqZEdheUdHb0tyZVV0ZVl0enlTOVJTVW9ZM1BJamo5TnJm?=
 =?utf-8?B?VXBXOEhDMlk4dkt6eSt2S1lZeG13V25WMmdwYS9UcWw1dHNIdnNGdm1DdnVl?=
 =?utf-8?B?Zkl4RDlwdzQ1QXhQYW43dmhOOURxZXZwOWxsOERQa2dWZDdNSjc4Y0RmTnJ0?=
 =?utf-8?B?Mm0raTZxRTBFdjZyT2w5ekdDb09QTVBxemQxRVhyRTg5MVJjTkV0ek1lcU95?=
 =?utf-8?B?Z0tQT3hvNmM0aXpUd0VmTUVOZWRNZHlIS0hQVUNTN251SkdmdWFQZldLNDRr?=
 =?utf-8?B?OEFjQzhEdVVQYTBEbXI5M0dBSzRMZHRZTjJCS1QwL0ExRmdwZlNpR0NIRFNT?=
 =?utf-8?B?dVpsY2VuRTRIdXd2ekc2OXRNQ2ZBdHd3THlwakkyU01Uc0h4dy8ydkQwU09V?=
 =?utf-8?B?TUIyZk5BaEFSOGk0bEFTZ3NJT2JCclVpTUlsQlNGcXpSbW9DSWJlUGREVUgw?=
 =?utf-8?B?RE5VU25XWi82cVBzWnhLRWlWMG12a21KNzhZZlJwZHJrb3lqT0I1bVJPeEdm?=
 =?utf-8?B?YmNUM2RqbXVxRjVDNUsvbUlHcTBkKzBJYVZ4SDVpWmtOdG9ROVpDbit5aVJ5?=
 =?utf-8?B?R2VsT21EMnpnalk3UDlwNWlpeEtCKyswRW9hNmlDZnB6YU9yRzBpRHlrMWpQ?=
 =?utf-8?B?QjZiaVlMU1NndWgyb3RYNy8vZk5LNVI0ZjRvSWRmbHYxRzNtdzRRNFZaZ215?=
 =?utf-8?B?ZzFMd012RklWa1ZHWXBUZDloWEFxNW5MNUU5OFpyWThKNnVRNm1CUEI3UXpI?=
 =?utf-8?B?OVo0NzRJTXUyQm9DQzJLNHZGTm9LY1ZCSUZLRDdGcy9nZ1lYeDdqOEhHWWll?=
 =?utf-8?B?LzljZ2RuSUpzZmgvVk0vQXVmdSttSktrZng5elprY25Cb0gzSUJmZTB1Qm9F?=
 =?utf-8?B?aGxWL09HWlh0dHBJajlteXkxT0NoSHBnaC9IellHYzJSRnFWVzdGandSczhW?=
 =?utf-8?B?Yzk5Y0JwUy95TTdZYUtSOXlvVy82dnVhZk8ybUpvZUlJNC9UWGhvc0MrVmQr?=
 =?utf-8?B?VVpQTFJsejJCM1FwanJHd3VhemNpSnBiRnhtcHNERHh0TnUvMzRzbGxiWkRi?=
 =?utf-8?B?R1U5OFZRWHBwK1RqMVdnM1VEUndUL3RucEdKbVB2OFJXWWZrNWYwencyaHpm?=
 =?utf-8?B?dHdVeEZJTUZ1cSs4Q1lUblFaN1Brc1Jwd09CN0s0TjBFRnpacUkwMWo0Q0Vk?=
 =?utf-8?B?ZGNuSWM1em9GZ3FnQWNFQUwvcitJS1JXaFI3ZjFoU25JampxODdROXQzZWtP?=
 =?utf-8?B?WFVpcHVyK3NBWnlpYW9Ldk1ieFRMVVRGajN2eisxSzIzbHdHbjhGeTlGUDVx?=
 =?utf-8?B?NldCMW55N0tYTEdiSUdsbXpWUWxYN2lUVE1qdTNUMlM2VTlwRWFVSk5tLys1?=
 =?utf-8?B?N29ZQmdUREYyV2YrSTdnNGNINlM0UGc3ZkVJNUhSZEtDdmtiNjhvNTlObG9k?=
 =?utf-8?B?R3NyenVtYm1Cc0hEMWVPNzZ1cXBXV0IrOXR6TG10alk3akZuV3hjdlFES1Rj?=
 =?utf-8?B?eUpqT3Y4d3JUMWczOHJoWEhvZm50UnlLd2pyMTEwcGZFRTVkWHYxSVo4ajJO?=
 =?utf-8?B?eWhKTUorQlk2bWg1TGdCMlg3WXlBc2xQSFhMTjQ1NmIzOWhXbDNqTG1nQ1BK?=
 =?utf-8?B?ZDhOQmx4eXlmdFB6cWp6SW5uMjdMQlptMXVpdkxtNTk0c0U2YndZZmJGVjFv?=
 =?utf-8?B?NUlub2k0QjBMUy9yNG5FT1dYSWdBd2drZS85cXhBUkxzNDRzRFZuV3FZekl2?=
 =?utf-8?B?Tm1ab2U0RGNjSWlqQ01mNXBrOStTYmV6dlFndkd1RmNCQlJ2QWtlczU0Zkc3?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fc0phWdRwBCwaWFy4jdAsM6au1YiUbj3CNTnj44qOoqvusJjFY1nsElNSXaLylYMl6j6C5M8BWeKHaUUO/cYpHr9gAia/6kcazpQhk5bdztSzu78s4LXf5EGYV1woQPaReJKS3NwFLw6q07AKV1xPVwqwzVnPxg9IqcH886Bc5aFMPJLWEq3GsmKAvNAXendcprG1KCDVLAO/h4cRBtv5xXLDP7fRTbeiuPoq1IBRRK64nzFTmAWaU4CgqggmgwFWPu8rAGqHODcvrvuMZW5zbbSkZJq6tL0iwF4gTkhr1xI0wWM0CUuwq+pEfjwtglmn0nqgR46PrsimNUaKFJpbJU+/I7AwK77gxZPdXDMsMQYG61WpCg42uFAy0nFkimN0o8bhuNk9LAWGWQLiYuVplKo5YSLuhjvNCXI/+65rF3mSWELNqdpIfotMTfQ9eOjWJyN3e+R6kw6Xyr3aFG1aFvp8O5TXwpqeuFoiNQXpTREYsrI80lgjAssmZb1abgq8XYWooP8hw9otvEOV3P3ZsTu61Tvmy5HkO5lDR4B/hrLbLcAl9priBMKUZZlWWnT+zNiHUQLuPq4ayy8HOdthy+XUnTLYiNUI/Mzf4RtXDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adaf001-929c-4417-487f-08de22dcb49b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 17:47:25.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHSFg2daWBOFKaB3anzOT4o0JwJbJS2ZqoUVjgj+299djCVX2KFPFu4yoC33iPTpfc5tnpE9elxBhvKYazOfgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX36oGYRO77JBJ
 v0C6Cw9vZxy58GGzI9eZQk5TFgrkSMOOaJ+snvHwbnUQsRmP41fs1jp9ZIREaEasCQ4BQOb5hfe
 HneeILLiERXHgbDyehH4koxltAb2cimd8SY0SOqwdTJVMH1qFGoh9GZApsD6350EXN6kY9GtzTM
 hDIb4mBGrr/0eEViLDmZ1gUr9viO89BDsKmUUDst91dUZ7jqv46XLRagEupivb+6SoMNbV0B9NO
 YvcIk4rrJYv8qmxec/vwR0PFrYNiAfXS/lJOZXxZsLZ7oblokPQ156hXSQBJhjY1KcaC8HV7yaa
 OGqE7MmigenFF4kOgmKOn+MlxpWLs2mhs2p9SRXJ7Wys8Q6XmkBbJ40vtxVQIiv3xkgqFpMCZcZ
 e4C0TQXpSnnis+l73LO0QxCGBevxfdDAkhy7w5HdLFCzh3x6sU0=
X-Authority-Analysis: v=2.4 cv=S6/UAYsP c=1 sm=1 tr=0 ts=691619b2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BR0z2RyBM-fMX0CtonEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13643
X-Proofpoint-ORIG-GUID: n3znvStZ6wPTAudT71KZNuT8fVRCh2jo
X-Proofpoint-GUID: n3znvStZ6wPTAudT71KZNuT8fVRCh2jo

On 11/13/25 12:16 PM, Tyler W. Ross wrote:
> Thanks, Chunk.
> 
> Suggested trace-cmd report from the client follows. Last 3 lines appear salient, but I've included the full report just in case.
> 
>           <idle>-0     [001] ..s2.   270.327040: xs_data_ready:        peer=[10.108.2.102]:2049
>    kworker/u16:0-12    [001] ...1.   270.327048: xprt_lookup_rqst:     peer=[10.108.2.102]:2049 xid=0x7b569c7a status=0
>    kworker/u16:0-12    [001] ...2.   270.327050: rpc_task_wakeup:      task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=0x6 status=0 timeout=15000 queue=xprt_pending
>    kworker/u16:0-12    [001] .....   270.327054: xs_stream_read_request: peer=[10.108.2.102]:2049 xid=0x7b569c7a copied=988 reclen=988 offset=988
>    kworker/u16:0-12    [001] .....   270.327055: xs_stream_read_data:  peer=[10.108.2.102]:2049 err=-11 total=992
>               ls-969   [003] .....   270.327062: rpc_task_sync_wake:   task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_status
>               ls-969   [003] .....   270.327062: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=xprt_timer
>               ls-969   [003] .....   270.327063: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_status
>               ls-969   [003] .....   270.327063: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=0 action=call_decode
>               ls-969   [003] .....   270.327063: rpc_xdr_recvfrom:     task:00000008@00000005 head=[0xffff8895c29fef64,140] page=4008(88) tail=[0xffff8895c29feff0,36] len=988
>               ls-969   [003] .....   270.327067: rpc_xdr_overflow:     task:00000008@00000005 nfsv4 READDIR requested=8 p=0xffff8895c29fefec end=0xffff8895c29feff0 xdr=[0xffff8895c29fef64,140]/4008/[0xffff8895c29feff0,36]/988

Here's the problem. This is a sign of an XDR decoding issue. If you
capture the traffic with Wireshark, does Wireshark indicate where the
XDR is malformed?

If it doesn't, then there is some problem with the client code. Since
Fedora 43 is working as expected, I would guess there's a misapplied
patch on Debian 13's kernel...?


>               ls-969   [003] .....   270.327068: rpc_task_run_action:  task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=-5 action=rpc_exit_task
>               ls-969   [003] .....   270.327068: rpc_task_end:         task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=-5 action=rpc_exit_task
>               ls-969   [003] .....   270.327068: rpc_stats_latency:    task:00000008@00000005 xid=0x7b569c7a nfsv4 READDIR backlog=7 rtt=110 execute=137 xprt_id=1
>               ls-969   [003] .....   270.327068: rpc_task_call_done:   task:00000008@00000005 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|0x4 status=-5 action=nfs41_call_sync_done
>               ls-969   [003] .....   270.327068: nfs4_sequence_done:   error=0 (OK) session=0x5988ad3c slot_nr=0 seq_nr=26 highest_slotid=63 target_highest_slotid=63 status_flags=0x0 ()
>               ls-969   [003] ...1.   270.327069: xprt_release_xprt:    task:00000008@00000005 snd_task:ffffffff
>               ls-969   [003] ...1.   270.327070: nfs_set_cache_invalid: error=0 (OK) fileid=00:2d:262146 fhandle=0xad8c294c type=4 (DIR) version=31 size=4096 cache_validity=0x4 (INVALID_ATIME) nfs_flags=0x4 (ACL_LRU_SET)
>               ls-969   [003] .....   270.327070: nfs4_readdir:         error=-5 (EIO) fileid=00:2d:262146 fhandle=0xad8c294c
>               ls-969   [003] .....   270.327071: nfs_readdir_cache_fill_done: error=-5 (IO) fileid=00:2d:262146 fhandle=0xad8c294c type=4 (DIR) version=31 size=4096 cache_validity=0x4 (INVALID_ATIME) nfs_flags=0x4 (ACL_LRU_SET)


-- 
Chuck Lever

