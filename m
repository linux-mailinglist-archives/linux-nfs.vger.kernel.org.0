Return-Path: <linux-nfs+bounces-10464-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D369A4EAA4
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 19:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27CF42484B
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E494B27CB1F;
	Tue,  4 Mar 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HrPnW/gW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J8FLq0BB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0081A27BF90
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110112; cv=fail; b=cfz1bFHrQqlPp/m9I2jrQ1cGZml6Nf4Ys6hAILNIv0pTxaj5vlc3feDmQ8Bre2Y20bKPH6Habmq3D8YuNAlOVs9Y5e1wkl/x8Kg8sOqvMXDPfgQDNlM92EeINbvWXp2eXARhYtIGM7VVWTp3npA4SJx056wX0g7L6iNC8xBDcs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110112; c=relaxed/simple;
	bh=ciALv3Ush8fkV8VN4dEkVon4GsPar6KLlO24mLydL9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SbM3PG1opFTj/zre8PFH56b5BMPmRQifB5tAp3RB2SgOrZtMHJuUmAqJ+5XuUU9qWQksdbyB2N96ZxhrVHc7ZaSA+RozdlgK6Jjgd63UD9+os369q26BQS3BGe8+MrhgUfwg+QDGRk1v1ps/fYMmyBkliVUloY8QZiqBL5O0gMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HrPnW/gW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J8FLq0BB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524HNBoN012418;
	Tue, 4 Mar 2025 17:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QnU/vxa/N7w7V3GssnyCrJLkpMlFMW5/SkAAkTQXgPQ=; b=
	HrPnW/gWRB/XAVlbvjrubPC9NQfOzQ9WTKdbtFw+7yXzdEeQGgZSKKMIcF7F4Yks
	qYr5a8azCmJ2WUjQrLmKRn19TYl4BjgtAXGse4ZiLPY+XL1AyBKp/QMyYldOc/7p
	JcgaNdRSb/RKTaqoT5VDIF2MdGxZ0t2VRYThJhiPvAS2oTKD60JsmXc+jCJpdkCp
	0ywvD4VxFC5wqnWXPJr8fOm9JuiWM6DqOnnfm5E5eDop8DzktOeVhAYOnyeFbf7R
	MXpMI8B7wccQf3RMfs5JKaDpBEamZ7MsBWe2fSmrLle7MsD2DacEx3oKY3x62i/A
	4GsbA7x4qYswkDpWMkzwwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub75rqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 17:41:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524GK8fa015758;
	Tue, 4 Mar 2025 17:41:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpag1t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 17:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brom5aYrHik0sJRPs4xIZQ0UyyRlSQmCLVwes+GQGIIA/3S/Fo03spreRVAQ+/eTSH29fHT3l9vUu+NyZLDMXZYuAlQ9kpjfShhCjUy1Sv2eQtEzDrMK5U0JGStE2Y+ouS6CgtgE16khh72GvOMz2+oUdas4EB1o0PaG7ifTIgCUcnIvKPQiOknB5vI3iRFVCn4DvBXgzeSk/8ZchnuXSW6Qnmmz5ieltGiMFVTCqPHNbouDfOTF+CyUHhZe+iIYviG/hPmiKIsYEVg0oubENJ/nDQhBj1ciq09D15etojUg8wS46es8bjxrt5YBcXMspDRYmLEtiB77tHCol3jO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnU/vxa/N7w7V3GssnyCrJLkpMlFMW5/SkAAkTQXgPQ=;
 b=o1asd96I8kwGUBzLnqZOj6VbofaaoWRrh9epcF61KZuR6MiJZ+4PS39zrDxFWeBZl3tmUF1F0TRt9kTYVRk2JZAZypIGmmwWFzdr0L/zLMJomZEPsbKzOm8rHyFs6+c+DlFckAG6CazlJP6M2ckc7XdQeOP6p/xRXm6+HN/6H4L017ZA9dinzLQ7WeVtDIPA+r3qYDQAjSOfuEi6ubbt7z3AWdgeBof6+/IRWi3NoL1ouoZqbo3obzvL3f1OKBE5exU5dk4LVXTjitHf/SkewqqKPHjWMYMGeI5AfGfo+NU9eVSi0toyYUvfQjSJZG3XdnPbeIv+vKXmMn89cujKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnU/vxa/N7w7V3GssnyCrJLkpMlFMW5/SkAAkTQXgPQ=;
 b=J8FLq0BBrGGYW/FMGc3m6h8UApsYsvYI0f5xVLWin7+vSmLyC0ppeAwzZLUzh3APwLInpQDIx77trozTMOiW+L+fhsY+fgFlbfVGgxCN3VKvSRQRIymrNLhZe91Z8X8wwUov2lX0M2UqPevHTzL8sJcUhyXsoWe62ZZjfeb79ko=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MW4PR10MB6324.namprd10.prod.outlook.com (2603:10b6:303:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Tue, 4 Mar
 2025 17:41:19 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 17:41:18 +0000
Message-ID: <c2575706-ec9f-4020-b147-679af40998c0@oracle.com>
Date: Tue, 4 Mar 2025 09:41:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741059224-4846-1-git-send-email-dai.ngo@oracle.com>
 <1741059224-4846-3-git-send-email-dai.ngo@oracle.com>
 <f26b62d5e7b55c42ab1d523c989a883917dae71b.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <f26b62d5e7b55c42ab1d523c989a883917dae71b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::24) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MW4PR10MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d34f38-aae6-4fc1-123d-08dd5b43c516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bCsrUTNrTGliSG1uWVdieUdpNVNzZDk1TkliWTNiVDZtWjRSUkdzM1lnYnYy?=
 =?utf-8?B?ZDdsVXdPYjZySEdDTWNKZTVXckp1dXk3SUFUcEJKemJGaUJQZTkwdXFBNkda?=
 =?utf-8?B?WUFEd1pqQzJQS0Nyc1FPVzFOUWtKRUVxVCs4TGJYeEJmOExST3p0QmR6aUgw?=
 =?utf-8?B?L1NyVmxDaEpGZ0hENXNOdHNReUJPUVc0Mm1GdE9tcG81YXZjY0RIY0gzWVVX?=
 =?utf-8?B?R2pvS0F5WFJicGorZ1lqdTVrOGdxTVdIdEN0OE1ZbmEzaHNhNCtHeEJuSmpW?=
 =?utf-8?B?eEhsS29wSjY1MzJnSDBGS0NCVjZaU29GcFJLQzdPWmVjSzk5MGtVK2dNMDJY?=
 =?utf-8?B?SHFXOEc5MjhpaE9ITU10Umc0aXdrMmU3ZE1JTERucVJVWTgyanM5bTRaTHhx?=
 =?utf-8?B?ZlZlc2hQUXUzWDV6WVMzS0VXbGlKZUZQOEJFS0ZSS3Y5R3cwK0lsWmtrTE9B?=
 =?utf-8?B?MEh5VG9sS3NPUTRLMTJtRVB1ZEkxTGNQNTFrWEpEekdMSkNpVGdoSVpKc1Qx?=
 =?utf-8?B?anFuMUgxM0RndkNWMGpmNU5Pa0tja0dxQjE3dEF3eTdUWWp2dGt6QjhpWmJK?=
 =?utf-8?B?Ty8xMG5HdFZhVm1aWEN4SEV5bWF2eWx1aTVROFJNeHordjdlaTU5bnJHOG9a?=
 =?utf-8?B?cXRWM0RTTDF3NlBlTVVWN1hNVG1lMi8rdXJaZWtpNkg4dWRjb2h6eSt1ZmRK?=
 =?utf-8?B?MFpDOWN2MUttc0xZc1kwRWpPeGgwa3FYMjBZMzd5b1I5UXdZdDcxTHVJdFVu?=
 =?utf-8?B?cHVxVWJBNEUyMUZBN3ZmTEdENDRJYVQwc09FUEVleVM1b1RWVUZSM1pUSHdp?=
 =?utf-8?B?QTEyMHhZd1V0KzNjV0xYM2dWQkQ0VSs1OVRiUW4rS0VGOGQvWGJocElRMzFa?=
 =?utf-8?B?bTFXaHAzN1ZvMFpzSlVlb0ZuUWFuLzcvam9XbmRYN0ZVa2pSSS85RDhvVHlP?=
 =?utf-8?B?dmdzV0thaFo3Sk92NlRwb2l0am1nTFlQYTNFY1pZRW1hN21yZDQrRm5aRm9r?=
 =?utf-8?B?blVRRStDeklUN0VnV3hGZDZSRDRURGxYOTJCOUJjaXdxMFVtc2UybloxaFdD?=
 =?utf-8?B?ckozV2EwTnlFbDFrb2dqOVhnWXdCZFV5eUNwcGVoUVlJeDZiaW5uMStNVUJp?=
 =?utf-8?B?UThwZWhmQWYwT2lVa0k0cFRiZDNHbExKcUIydlZzNUx1NWplQ1V2anZVTllF?=
 =?utf-8?B?STVwbjJwV2FaR3p0QUlEREtXRnpkMmdJWG1xeTQ1R0VLZVl0VVhZcWh3V21x?=
 =?utf-8?B?cFlMMFpRN3BCMnVEOGpQNm10b1MwaW1OcUtKREcxN2xTbXhua2NNTkpWTzNw?=
 =?utf-8?B?ZTgrckRDMWFZOU5RVTZUb1B5TEttRlpNbGtTZXU5Y3QxUTMvV3JJSmE0Tklj?=
 =?utf-8?B?N1grRWt0UzdFUFFCdHNwQUFFTWlONHhVTjd2T2F2eWxDYitSSmdaclJLZTJU?=
 =?utf-8?B?V05sQzR5ZTlwUllkRUJPYnNVdy9CU2tSc29YQzd5am5wWmx6UmNVamNQOS9x?=
 =?utf-8?B?aTM4czRDQm9VV2sydGFRazdBWlBrMTJrOWgydTZQczF0eUZYaTIrSklKSFZz?=
 =?utf-8?B?b2lMVTRnU0pHNWpOdk0xcXl5S2hPZ2pqcTZBSER4anZ1aGR3QWJMb1JjaDcv?=
 =?utf-8?B?TUxjb2ZNZzl2K3dkNENQdXhLS1JvbVVKbXlPclYybHZONXQybnhPT0kzU21H?=
 =?utf-8?B?SDhHb1pBNDV3Ri9CQTdKR052U0hoSUlXTmNSL0psc0M2NmZiekI1a3A3QktQ?=
 =?utf-8?B?SzN2U1ZrWTNZZEFTVEVVTngzbWlnQ3FXb0FEaGV3a2hrWTFtTGwwR0F1UjJa?=
 =?utf-8?B?WlA4MFZzUTlBRVpqcGk2RDdmMXl5VFFOREJuMGFyWTZSSzR1dy8rM2tDNkpn?=
 =?utf-8?Q?opit+tSOVuOrN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1IyNGdHa21saDJoTG14eFFCVHdQWkJRTkxYOWJOb25CV0pmL0ZEMXZLQjVh?=
 =?utf-8?B?d3Vkalp2WmNFR2xEeDJWS2JNTkh3eTFUcnhhRkhRYmtHRTlUc0NvSkR6YzNt?=
 =?utf-8?B?aklzaDRRQzNHVVV1ZjNjNThSMmFhRkhyUEZkdDRtNkZsdGhrYkJqUWlBK1Z1?=
 =?utf-8?B?b3FLUFFMZGdkTFBObUF2UkZyNmlFdWpwSHZJNVRhR0ZKTCtFVmcvZzhaOFdz?=
 =?utf-8?B?Zm5qbEpxdGF3RWhVQVp2NTRFc3FodFZ1Y1V5S0V0RDk0cGx1ajNGRHBsRUdy?=
 =?utf-8?B?bVFQQWNQTlpwN3JVKy9nM3dlSTRsWDhZQW1ZVFlQT1h2cTJjMUlPenFkeTg5?=
 =?utf-8?B?MUNKcnRBNUhIQ3NqNnJyanlmbmxDQ1JkcUVGTUdwVXY3cGp2VDVhQkxUS05C?=
 =?utf-8?B?N215TEFMTzBGR1YwSFlzdXZFTXJCd2R1YXZSSWdCbzNxdVF0eWc4OWdncFU2?=
 =?utf-8?B?VEFlcEV2aFlsTzJOOXNibHJndHBFalVoT2tqLzFSeW1uQllHc2NFczhENjl3?=
 =?utf-8?B?Y2hHckFJa2hBbno5a21xRXA5ZDhPZEVsb2t0RFNuRjhiZlZqT0JNcXpCUFFX?=
 =?utf-8?B?STRiT1FXZ3JPeTYzTXpKUkQ2SGtja3NGWEdZUlUxTDdZZGdmSUFFd0FTdW1W?=
 =?utf-8?B?R2c4cWFPS0I3NUc5SVMyVnFYSU5iRS82czgwclhKeFJlVkxGOFFMRkVDNVZp?=
 =?utf-8?B?b3E1YlUrTGZ6d3NmNFFoOElKUXcvMUpFaVMvcFJRTm1NZElXRUJpbm9KeTB4?=
 =?utf-8?B?UXBHT0ZmVDV6eVZFTzlRNXRybnRobGMxWmE1UWZZdTdFRkNHeDJvMHNDd0ll?=
 =?utf-8?B?WXNOZVZ2YXp1WlA1NzFpZEp3OFpzam81cUFsN2ZpNEx6SHczckxiRnNQYTdE?=
 =?utf-8?B?cTNlSFdGcGVVSDR1bWZxR0d4TlgzalhkR1BhRmpRWDZueHFobm9jWktMVVNl?=
 =?utf-8?B?SC9GM1l4MVNGeUJ6bXNkVWlrRUsySXdEODhuRUVXdVY1NUNFYlowS0pQK0w1?=
 =?utf-8?B?SHRRZ3NORXBIVU5tTFdqbnZCS1NMQ1JtU0U5UmhrOVg3cm5kTkJuNk5EV0lW?=
 =?utf-8?B?dzhoVWFxeDdkL1FyTnBKVHFrVmxZYjZubkRhUDh1TE9ONlNqekFRemY5b0Uv?=
 =?utf-8?B?VklERStFRmtoZlVQR0F0VFJqS1l4TllzY294Tng5amF3dklVZ09aQksvazhR?=
 =?utf-8?B?SS9XbXNRMW9NTzdmWmxkVncxbDgwSmQxTnlwM2dhUlM1K3B5Y05aZ0V4V2N2?=
 =?utf-8?B?U1BmdFFvZkZ1a3N0bENWcnN2NG01NUJWM3A1c2hZVHc5VFkxQWNKSEFoM2Fs?=
 =?utf-8?B?TmlOakxodmNSM29uUVA0UTZrdE9TQTNRWCtXQTMwdEFGenhtZ0xhWkdRczZo?=
 =?utf-8?B?VG5oNWRVUGpJSVllS0JjZ2l0elJYQWNCVFZhNHNPTzJaeVpYT3QwSjFpYWp0?=
 =?utf-8?B?WmRqTG1ONkhEVml2TVgwdjRIUExtanp0VWdjTjZCUVNJSUkwNnFRdGNUc0RD?=
 =?utf-8?B?Yy9PMW5EZ21NcjQwNGRzUmdrQkpvRzlNTWMyQXBQRUpkQXBxWU1TVXUzbS9I?=
 =?utf-8?B?WkRYdENIdUJuNHRXUjkzcWNsby82SzllaE4wZDRnNnB3N0VPVHhuSFVDUFRn?=
 =?utf-8?B?L3dZYWNKZjh1T2p2MnBhaUpVbnQrblk1aU84eGh0SElLYTQzeTM5Y1B1U1FL?=
 =?utf-8?B?TUFsaUthdExwZ251UWM4YzczSG9wOTRzZzd2VUoxd002eTZscEtyTTRPb0Y3?=
 =?utf-8?B?SGptU2ZJdzVWRHJFakNtMGtPZTFUdWZBWUNvTGxNWm11eHl1VDFGZ09ZTE9t?=
 =?utf-8?B?NVlXNjh2OU42V0JhdXp6K2grZVdYcGEyUVN4SUk1YmhnR3dvdXVUcFc2eWFn?=
 =?utf-8?B?cFRyS2hOWWR3TUl5WGdIdFppOEsrcHFITFRYWnJMMEhEVnB6SWZpM0t0aFJt?=
 =?utf-8?B?dkM4SWJYamRFM3FjN21vRFFFNGxyUEZvTDA0U1BFRmNINnN6SzRIN2t6SFFZ?=
 =?utf-8?B?RzVqa1MvV1RhWkVrZ20rNU9zU3NHQXRmT0s4WEFrNmRlYnhtYkdxSVB3V3dT?=
 =?utf-8?B?ckRUakRMU1F5NnpFMVQzalZtNnNuR1haNWRtQUNhejdzWDIrZDdHcE5RR2tw?=
 =?utf-8?Q?MimJc1PW+6+d/Ps2vABFmcwXC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mWlJ9PAEKb8AyH8lQhvm7/soWEJgSS/06EDOlaspnH6hye32fLxJFkhq0Os+gPZFyfLnAabG5y05eOnzeX23FRs7etQR5T1/Zt6bjcn31ZEgC6Zx0NhDIuSlF2GqqZWrzHmMMeAUDYJab1QU9QvEb/8Ha6sjRXJDM2r2sOdSGmtuCP6HVc+WtBOLjy54iOQYJ6tbp/N6RbQW/3Kw5VHCp2hSST/fXH+vObzRY5EsE6mAhbWmAs5l+6nEF64ya3uMjU70Bu9puSjKguYaBXZJbUNMe1jLzZAmPpxdhBvn2TzmnxUzbcH1AOX+zpNjlQmNggW0MoJVt+VFZ1524CWt3EXZ26x1M4VPTLe4yrMzKFpM317AP9jVD90XOtS786Wg42sJg8XF3hJIwU3dt9Ckki/OiKIx0z7bkzjapOb/v7GkzCnx4BT9ypKZTuI0F2bX1dftigQtstS14vp3OnWahz/QlcAIHaunE9FXYXSamIgS9Tn/Yka+4LF1Wk6GSyK6GWYURApOolqqTJoUuKo5cVVyiqZLwGxv9XSZ8wr2/ub8RolG67ZNJ8Bw05F86EsH4TYg4qBnFFr59iCiGpLLlOou3fFQdPdSLIdnYd4Ttkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d34f38-aae6-4fc1-123d-08dd5b43c516
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:41:18.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brs5m5mx5fsmPVJLxL85hH5y9dOq8ZWucV50iIboIG8o8hikjzN1LtGjE/jsGZX6vL5kemjelaW9N6mlPSbMqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040141
X-Proofpoint-GUID: O8UByYRk9n6Pf-Lnotvqz2jbbX4PGsrL
X-Proofpoint-ORIG-GUID: O8UByYRk9n6Pf-Lnotvqz2jbbX4PGsrL


On 3/4/25 4:27 AM, Jeff Layton wrote:
> On Mon, 2025-03-03 at 19:33 -0800, Dai Ngo wrote:
>> Allow READ using write delegation stateid granted on OPENs with
>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>> implementation may unavoidably do (e.g., due to buffer cache
>> constraints).
>>
>> When a write delegation is granted for OPEN with OPEN4_SHARE_ACCESS_WRITE,
>> a new pair of nfsd_file and struct file are allocated with read access
>> and added to nfs4_file's fi_fds[]. This is to allow the client to use
>> the delegation stateid to do reads.
>>
>> No additional actions is needed when the delegation is returned. The
>> nfsd_file for read remains attached to the nfs4_file and is freed when
>> the open stateid is closed.
>>
>> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 41 ++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 34 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b533225e57cf..d2c6c43b5d0c 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6126,6 +6126,30 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>   	return rc == 0;
>>   }
>>   
>> +/*
>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
>> + * with NFS4_SHARE_ACCESS_READ by allocating separate nfsd_file and
>> + * struct file to be used for read with delegation stateid.
>> + *
>> + */
>> +static void
>> +nfs4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct svc_fh *fh,
>> +			     struct nfs4_ol_stateid *stp)
> Let's call this nfsd4_add_rdaccess_to_wrdeleg().

Okay.

>
>> +{
>> +	struct nfs4_file *fp;
>> +	struct nfsd_file *nf = NULL;
>> +
>> +	if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
>> +		return;
>
> This function should return an error if nfsd_file_acquire_opened()
> fails, and the caller should not give out the delegation in that case.

Okay.

>
>> +	fp = stp->st_stid.sc_file;
>> +	spin_lock(&fp->fi_lock);
>> +	__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>> +	set_access(NFS4_SHARE_ACCESS_READ, stp);
>> +	fp = stp->st_stid.sc_file;
>> +	fp->fi_fds[O_RDONLY] = nf;
>> +	spin_unlock(&fp->fi_lock);
>> +}
>> +
>>   /*
>>    * The Linux NFS server does not offer write delegations to NFSv4.0
>>    * clients in order to avoid conflicts between write delegations and
>> @@ -6151,8 +6175,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>    * open or lock state.
>>    */
>>   static void
>> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> -		     struct svc_fh *currentfh)
>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
>> +		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>> +		     struct svc_fh *fh)
>>   {
>>   	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>   	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>> @@ -6207,6 +6232,10 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>>   		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
>>   		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>> +
>> +		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>> +					NFS4_SHARE_ACCESS_WRITE)
>> +			nfs4_add_rdaccess_to_wrdeleg(rqstp, fh, stp);
> nit: I'd also move the if statement above into
> nfsd4_add_rdaccess_to_wrdeleg().

Okay.

>
>>   	} else {
>>   		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
>>   						    OPEN_DELEGATE_READ;
>> @@ -6353,7 +6382,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   	* Attempt to hand out a delegation. No error return, because the
>>   	* OPEN succeeds even if we fail.
>>   	*/
>> -	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>> +	nfs4_open_delegation(rqstp, open, stp,
>> +		&resp->cstate.current_fh, current_fh);
>>   
>>   	/*
>>   	 * If there is an existing open stateid, it must be updated and
>> @@ -7098,10 +7128,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>   
>>   	switch (s->sc_type) {
>>   	case SC_TYPE_DELEG:
>> -		spin_lock(&s->sc_file->fi_lock);
>> -		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>> -		spin_unlock(&s->sc_file->fi_lock);
>> -		break;
>>   	case SC_TYPE_OPEN:
>>   	case SC_TYPE_LOCK:
>>   		if (flags & RD_STATE)
>> @@ -7277,6 +7303,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>>   		status = find_cpntf_state(nn, stateid, &s);
>>   	if (status)
>>   		return status;
>> +
>>   	status = nfsd4_stid_check_stateid_generation(stateid, s,
>>   			nfsd4_has_session(cstate));
>>   	if (status)
> I think this approach looks valid though.
>
> Nice work!

Thanks for your review.

-Dai


