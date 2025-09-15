Return-Path: <linux-nfs+bounces-14454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5210B5866D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 23:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FE03B2951
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FB82C0262;
	Mon, 15 Sep 2025 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DVM0aJNB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KMaw8K6x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F8295516;
	Mon, 15 Sep 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970747; cv=fail; b=B98mVKPNUB3gfEvRVmU89hNqnATAvCkxSmcd3ysU71l/k/JCzRel6RavaN8hXhwWlIjHcNUlWQnX8sZKBo/chhOG1naM9FTUXRZl63iCKkegJn3jwiMewjZlB9ng7fd05yurhNrvyUUWVXaj5ee5Ql5l06+fjmLr3XKX21qnLJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970747; c=relaxed/simple;
	bh=hQaLhR+Pw8Kl2MrsANSeBu5jm2Vpb1WUfYtIB3HrCNQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AU9WyyG+Z63ErB+dWQTwyjOaUWu0/S282OiD7+7+PfIRhjiu9c33dNZdJDMid+qqV1NLtRPDy9V9zximPIlvCGSOK2iFQwPixPCBcM5Q0Wss9DxYG3mjEhkDnxjGXC0JaimnZumzIkwzc4EwPPAFuXgvV5fYJvUJxdjWyYxaPp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DVM0aJNB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KMaw8K6x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FK7QJr002309;
	Mon, 15 Sep 2025 21:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3ZXMsbaG6qJhjD1pYOH8J1kb4jmWvGTnlwDVfJzOUCc=; b=
	DVM0aJNB1AzY2+iyjALo0VHWls8P5snDrUID+Y1a39gKi95sfCKU1bEm63OGido1
	x1Mh7ts2qK0slxLaT5I3abBwQTiXWw99QC7l4h3ULJtJCob9VE2GwkMUfiUSJcin
	C+RYwY2be9y91FId4VhTJNS1j5xQtBlyAmN0N4GzlGD+LnRuZhfFe63IeUX+iqLq
	JBb3lJnbUl6PmLGgEV8r0avT/mZPzZJ49GJ4P5MKyP+Zl2ObeGVii+um0cLYIA+E
	jslaHqY8fnGLYFkX0yGp/f3IimEMZxlzcbxScmD5BG4pSZsKGaqoFNerhXM8ZQ0s
	vTS6nxRhVmquqB9JuF/f1Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y1fka9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 21:12:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FL94Hv011201;
	Mon, 15 Sep 2025 21:12:18 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2bhurh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 21:12:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwwZxy3f0cwHzVt5R2W5qUF3LMY6ZI8LFAtqvPZbypb63KwtelELXNTGA8hV+lMtqvgmZPHQ9hPdbVYWmh1ETuZbuQOsnqtzFwlltp1s12bR2lMjURRrmf+DFlvNXuIitiN/b2A3RQcJD+eT5aGlQwrsY6Dyh54gMf3/tsTN5BjeyLbKnGgLJLtnMPtWtMggkLRryCWRtT/9jnsodiSUa8jyK4U4bHVeV/w9L96KTbd44RzEN1Qhs2K4i454+bI4jdQdZieJbxX5B2GNnDgKGPhRY/d/ON/9lZLGqKdVylrmYjE/ytNERiGGhRuyp/pbs9/yrITBL2jMAtq8pANmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZXMsbaG6qJhjD1pYOH8J1kb4jmWvGTnlwDVfJzOUCc=;
 b=DOJruCYObAf7q/LILZivPEee+7F+QYwq+ZuYn4WWSDj+F8EMFsh+mUJ96uMlkR+8VqF8Sv82iJxWjFi/zEvOGOeIKjBu1Zt6iwfTO7V+BmQbFWadwEuMkoFyxwhHbrhdSMf6+Egb8KYQ+K+3wmqJCDfEzZFD11ZdajSM4ZWewEeS79Tq3c3xDq1vvFvYHctukVc8t11PX8wYEF/OS7YcV9zqyXjjgeJRWfmXvfQCEN1v+Nvvh9dcDj2kNgEnFtgbcAozHd2IN0LMkWsZxzoYbN0qPTW/qH7nC9Hxyb3YHf2lNwIUR/9PspALIM4vd3eWcuOECddOzNmH8Xb2IeJYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZXMsbaG6qJhjD1pYOH8J1kb4jmWvGTnlwDVfJzOUCc=;
 b=KMaw8K6xIQIiEOaCvsbMg0Mc5Tve9Eb/amP12GhJPx4d+ZnaClsaTSqC+iE8aERqQkGY7Cxx2VmQcDzk9/TkYk/++ABHlYitw0hZRucz9hpPHWkUNZAvMC+2yRpUusnnFgGL/jKAJ25XXjKmkIYH1Mu4xwbLYI187jbeBozxCL8=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 21:12:14 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 21:12:14 +0000
Message-ID: <d3ca6542-94b2-48c3-aba2-c08328f2aa28@oracle.com>
Date: Mon, 15 Sep 2025 14:12:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Impl multiple extents in block/scsi layoutget
To: Sergey Bashirov <sergeybashirov@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>, Tom Talpey <tom@talpey.com>,
        Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911160208.69086-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20250911160208.69086-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:a03:54::45) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ecbafc-41cd-49d3-0d76-08ddf49c8b41
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M2FSZWdyUlV3LzN4K1BKUmVjRzFmZDNnYnhlU3pBU0ZlVk9WRlZzcEw5WTUw?=
 =?utf-8?B?WkN3K2lJU2FGMlNyejdoa1cydU44M1o4QkZUQmNpTVJ4WGN2UFNuM1ZmM3dK?=
 =?utf-8?B?TkFvRXcrcy9Yd3dMODR4aDlkakR5WFZySmJIM2IwcUF1Njhoc0xydFd1MnpX?=
 =?utf-8?B?VEFLeUxHTXR2MW1yU0t6R1IrQklNTnBXRlFuZWkrS0xxZlNQM2ZsNkF6Uzhn?=
 =?utf-8?B?VWw5ekkrUTRsUUZJMERTOGxQSW96Y0JJQ1NCZmFzSDdDVEc5bVNVTnAyak4w?=
 =?utf-8?B?MEg5ZjM5MVhibW9rSHF6TVJDckJTTVB1c0VyblZtSjcrbHZwY010OVhLVnBt?=
 =?utf-8?B?bmFHU2JVVXVOL01pVUlpRDEwTitxcElzb1JqL2ZrRzI5cTJyU1ExYjRuQi9Y?=
 =?utf-8?B?eDVubzU3VkFFOXg1dTNpUVo3TUwrREtacmsxdWU4S2dJUlQwalFWQ2d1MW9w?=
 =?utf-8?B?WTRPNXBiQTcvN0hCRjRUMS95SnhNR3NRckRoYU9CZEZYOWxiYWRrNS94Y3lH?=
 =?utf-8?B?eXlPeTdJYkNOcndQZWNQOGJQdFEvRFBlemVUSHA4N3FSbFlxT0IzVlhpaURa?=
 =?utf-8?B?WENYeTF2S2d1REpnZFhRbXlUanJmOW1wbDVHbnd5bU1QdzBFZitCQlNzT3hs?=
 =?utf-8?B?L2pvTXEra3lhYklDU2hKVUxzL1FiTU51RkRwVkhJTFhzVGZrRkVOR21FRmdS?=
 =?utf-8?B?bnExY3AyNnhOM2pHTlhsYUJUMWFhZTQxYmtwTnArUlFEM2VvVnJmcEVTV3hJ?=
 =?utf-8?B?TS9KVitPcVBNeTA4THo4LzdGVTdtUUxwd2pCTi9ESDFkemlSTnduMWdVOWhj?=
 =?utf-8?B?WXR4WFNsWGtJdUovUWM1NFovU2lLc2JubXBMOG1ZZWVoaWZxanI2R0dxSXB0?=
 =?utf-8?B?V1dXY3ZoMEdVSUR6V0VTUGd4K3UxdFBoWmpjY0dwR3lkcXlVa0tQZC9EU3ZE?=
 =?utf-8?B?NDZjbDZTZGpMbHVDUTZSTFZBTDUyNUl6NEkwdXlVUjlyKzRjWDB3eHVmUnR1?=
 =?utf-8?B?TXQwcENHRmQ5VkxINUhqdmhGd281Z1A5ODVGdUVpU0daWGcyaVdlYlpHaDRl?=
 =?utf-8?B?ai9UbFhSVU1mNDZqc2ZNdE94UEJmOXRBaHlyUGp0SlY0STUwc21HQjFIZ3Rs?=
 =?utf-8?B?MlgzNzEzRENkZnRJMzYweGR4K2RlM20wc1R4WERJOHgyMktJWWhWc0FTeGsy?=
 =?utf-8?B?ajRKSmZ4ZTJrdkdscVZTZ29HclR4UmtFckY3RFNOOS84YUVVTXRKMkRIRW1m?=
 =?utf-8?B?UTlzdXNYUEI4QmpHUVRLZU1FVUxwSUY0WWcyQWFGOUwxc0VjYlJVSmt5S3ZU?=
 =?utf-8?B?RkVMTTlvUkdsbHNJdm5CRUV6NFZ1emR6WW43Qy8ycHpUT2x3Q1dQUStlV1dq?=
 =?utf-8?B?bGd5eGxZV2J1VXhYY0Fla205TVlzQWMyZWc0czA5YWw4OWFXbDVYU0krNmIz?=
 =?utf-8?B?enhWYkRTYzNMa2tRMm91VmtqWGVnc1VuejlLMjJVYnBhQjNuL0JQQWx1UHNh?=
 =?utf-8?B?aERZVlI5RTNwVnhoRWlINklwOWppUUh2NU1sMXprUEIrZXJqWUNZRFRFbENm?=
 =?utf-8?B?d3RIeFFmai9TbFRyUy9hODBwNlVFRWhRVmFFUGIrYWVKWDNsWnRmTXgwcDFP?=
 =?utf-8?B?azNweC9tNElKamRGYmNRUUx0Z0tnZ3EyNzVtelh6VUNZM1pkZURKM2ZUa1BI?=
 =?utf-8?B?U1NvZGVtdEdUeGxyeThka01vbUMvOUUrRmJIaE5PQmF4RUhUTCtuZ1UxZVE2?=
 =?utf-8?B?cVVzckdMUmpyTWsrR1phVXRhN29BQ0I2a0RaZmd5TmptMEVkVmMrM0ZocVQw?=
 =?utf-8?B?dUprcFNCdWdOT3lJN0c5ZlBYZXhZalhKaHdOLzQzOW5HUytrMVNxMkh3V0hN?=
 =?utf-8?B?OFFtSi9lYU5ZOTZkcEM5N3hodXhjbTZ1MWszaEtydTNlczJWKzRzN3BFWGtX?=
 =?utf-8?Q?05xzlAwOfq8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NnI0bTQvOHc4OEVUWnBKNWpocXZYZnNBVVJxZXQ1TldCOVJvak1IWDhOcGVM?=
 =?utf-8?B?cFZQT1QzSzBpTmlNUm54eW1tbDVSOERTRzcrUDVwMDNYWEdEUGlTMGYxekxy?=
 =?utf-8?B?aEhTUEdJMk5XcUtQaHpCbnVoTUlsRW00NnVhZVVDeXF5aUR0Q0NBRWRzOEVp?=
 =?utf-8?B?cmRVc2M5WE0vY2lHUDA1K2ZXV1lWOXlQU2R2NGFJY1ZGSmVrYU5yWjh3MUQv?=
 =?utf-8?B?UFlISUhHaDkrU09yL3pDMWNaQVRadlZNRFJGandnSjkrY3R1REo4b0svQ0FZ?=
 =?utf-8?B?bjVGOTdNbER3cEZsK3BPc3YrQTJLV1cvVmJ6SEttbEdQTk9qT3hIaGE1d3gw?=
 =?utf-8?B?VnFBbklDSVZvZmppY0YrVWdTOEFNU01GNnQwbi80akcza1B5WFNJTWY0djZh?=
 =?utf-8?B?Y2hXRXd5L2x1dnQ0NzNCdS9VWnNGa25tTmp5OEZEb1BPMmVESmZLYWZISE1t?=
 =?utf-8?B?TGRZVnZHUW13K0lVajNPUVZGc21XQmU3UENsMGdtb0RJaWRnYm5CTHF2ZGZZ?=
 =?utf-8?B?U1Y3LzVnVUtuRm1uSXpVRG50WmVPUTdOZWVqcS9MTmRTK3lMOWFPS0s1eUQx?=
 =?utf-8?B?bUpHWUpyeFBXUEpCUzdES0ZQalVrMjREMG9oTkwxSGhnLzhoQTdpcGJlNjZm?=
 =?utf-8?B?dWNrNGhlN0JmeGFHK0VqMHZqSDBsYnZYbklOdmZIWVpkcEUxbFRqMFpDYXc0?=
 =?utf-8?B?OEJWYWFBazhjUUVUUGNMdTFtYmxON0NGQzFYRlBLQU9lS2VXM01xRTBOaDRJ?=
 =?utf-8?B?eE14dXdWbDFXbWpmUWxhUHU4aHlLYWtFWlF4ZDFocGlzVHp2WkZ0SEd0ZGMv?=
 =?utf-8?B?RXpvNXAzK2RIZ25UeHAvVmF1MjZpZGhFNG5BN1BZbnFNRHEvRXBzOFhmY3ZR?=
 =?utf-8?B?VDdaUUZTc2ZGSWdJWXNGWTNqWFhXRWxJYzBybHYrVnBHbVlhQ21LQXZ4a0w5?=
 =?utf-8?B?LzNBZWM3QmVqUWRTYy9FRjNrN3hkeFFGQmxucTF1eU5XRFp2S3BGQ2ZwTjNj?=
 =?utf-8?B?cmdRWWhIZGphdkRBb3VaMVc5NktScFdkc2xlUVdRSFc5dm1FTkhKblkrV2pE?=
 =?utf-8?B?eFVYaGRyMUpOZHVhemdiQmVUQktxQkZ6YXN0KzNmU2E2Ky9sR05VRE9nME9T?=
 =?utf-8?B?Wi9Ic1Z0U2RROUcxbnUvQk5MM2MzVlFvdXcxRGRnUWNwMGNrdXp4dFByM0t5?=
 =?utf-8?B?ci9BUkhERndhTitIYk9MR3FFMVRhTDU4aUFzSXl5ZjNnYi9INVRVYk0xSVdO?=
 =?utf-8?B?aVI3RGZ5d2hOdmpURlJOOFVmTFMzN0Z6RlFBVlRIM0c4ZGJYU1F0eHd0S0Jr?=
 =?utf-8?B?T2lZdVVpcW9DMGcwT2dLZFBlNDdGRHgxS0NTR3JjNUFNUndIejlSN05BTlMr?=
 =?utf-8?B?OERMMlpqNW1jWVNYYnYwSzNaUUhUUkhwa0hRMEp5andFRDB1Q1Y1VGxicFNq?=
 =?utf-8?B?Mm0vTHBUam9JWkw5V1lyL2tqNkR4YWo3QTg5MDA1Z2FOV3JCSWliMWJrQmw4?=
 =?utf-8?B?UnVwcmdFNW51eFRqVWt0Q3Y2aGVnTW43UGVCQ1hYOU5CSEpXSVdYd1hwK215?=
 =?utf-8?B?dTBuOFpabjNjdUFyRXJzTEhNdHdxWDRpWVd4NEthSjc1bUZVVnhxSmI5T0JM?=
 =?utf-8?B?RGRZTkpyc3A5QkVOOURXaCtQNCtKREFnOThOQndJVndiL2tmWHBiSE1qWTN1?=
 =?utf-8?B?VnRZUVFnNWtQb1EvaHYwQ2J4SnhzYWJSM3pLMjMrcEplTlVDQ1RLVmNibWlX?=
 =?utf-8?B?Z1hkdGdDbzJNUVZBd0tiNGVlM08wUWJ4Y2lKam9QS0hXcllmMHBlVzBRWnBJ?=
 =?utf-8?B?QzUyM2M2MXA0L3hzaE5NdnoxbkJ3ZlRmdzRLQXhyNFFaQ0ZJTzFMa1MzdnhM?=
 =?utf-8?B?YUwyOE1QblVPcFRQNTBXejNEVWFWMFBGbndjYlFvQUdjUTdXY0lRQkMrRm1I?=
 =?utf-8?B?c0d6My9mcGdrREdtMzFKdC85Vk4yRWtkK0syS0hkc0Q4RFgyQytjbkVPd0Ey?=
 =?utf-8?B?aGNkUXNRQmZNQS9YbjVZdzRwQkVhcmV4RGRJWHB2dHRuOVVxaGtvZGRpQXgz?=
 =?utf-8?B?amhDcWg2RGs5cys1YW1RYWtGc01GREhHdUVrd3FQMWJHbGgwaFNkVS9xaHND?=
 =?utf-8?B?QTJDeHNFcXRaTHpkYy9iM3ZIbkFWOTFxTTIwczd4TlRPL2VLTm1hMkJFNm4x?=
 =?utf-8?Q?l4i6Okl48QShg4XSk/n4fGfhadxLAmb60IpEVru6vBlr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y0+Cd+eFN+0eo+J0HWqa2OyJVfi7jY2F4WiYKzpHwQmJwzvvMYgeCr5wL5CxqGMYC6qNJT4l4XRbJYG42MZTQfu3V5v58Lp9XQy4mRrOzwi+ByGXTfGyyr955eDI+jEI5QSi8/nabaRQp/sa6XxIrjyebkN3XGJwUNNx4w02BFyKyWTWQMW8G/Y6+XcEU2fpORQUQhqRaDibOWgHicYtwJcTmc1xUNfs9U/hosl3c+KM4mytyqdF8KhiyMnzdBAkVmDAlBy7Zfo0HMwgfWPzCymbe2+f3JbiqNHlVVKeYaq+8VfBbzonPGE1WSuihcr7wuQ/h0ww4WlF2tJaOb+KfoiIpVYwvu1EdcrHO9lckn1ZmbfTOiTnqMvAsEP73NvbIudTD42gdaQiymmVuqRQHAwAYEYtXFPWFhqUpyx2aljTXu/mi7v5D2CesWJyhepwsGjSFcCPp3Hz5VNcF53df5R769aKC7WxRYlzLiCtNApEVPSK1pxUZIo/opq6KRcc/4AbayGo3hoPX+GEAnjhT7PJ9c9U3MLQ2jzMmKlbti8mJA1iyGz7XIwvQpuMNpUBgQkL5wDPDxiSxWAZB6M9eBgghGDmr1CqC4YrkV5EJck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ecbafc-41cd-49d3-0d76-08ddf49c8b41
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 21:12:14.7137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvXzNVz9NnGRmgVU+4gUaLfAHTIsVrgORCwt3MbwOMRCzQjcE89fK9spWmVEuXYp2uoCsrwYBpy4CBS2z+UzfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150198
X-Proofpoint-ORIG-GUID: O8X7bxStvgHT9Ns6GBYEVLiHuZIwx_tc
X-Authority-Analysis: v=2.4 cv=KNpaDEFo c=1 sm=1 tr=0 ts=68c88133 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=ypoEEkdHHJkKuKLl5EwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: O8X7bxStvgHT9Ns6GBYEVLiHuZIwx_tc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMiBTYWx0ZWRfX7NLq1BtkfzGo
 TCzXxotI7mlhdFz3RYRDdtywOZVwuR06X2kBZg+cLPdNWFxTTexNVBPbH8jiHrzcLpd4usp1BPj
 p75m1HOB1lqA+0Ni2XmJA4tHlRvw0ErdvCTGm3JhE8jfuv45j8WvakelBTDFBDTMaG/H2Vn4qQE
 sYDAaR7ysrOsnQwK5Crm5cydhBPk6RgJpY31equ8+ySJKv66nakuyso3si1VERjQFtDGWiDjj1G
 hzHMDQrsM+Zx/hifJQFD7MNpUfVrV8YMOGqiFiC4Cp2Zf3pIyA8ngBSJSH1GGO/DrJckdx7r/nv
 l5tGCTNJajg8Fnw7S2WPu0szJmb3ySTJBU+BAzGP9DPaoaDZClwn55W3D6vUIH1pm/yeV1iYFvE
 WYVcqw54


On 9/11/25 9:02 AM, Sergey Bashirov wrote:
> This patch allows the pNFS server to respond with multiple extents
> in a layoutget request. As a result, the number of layoutget requests
> is significantly reduced for various file access patterns, including
> random and parallel writes, avoiding unnecessary load to the server.
> On the client side, this improves the performance of writing large
> files and allows requesting layouts with minimum length greater than
> PAGE_SIZE.
>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
> Checked with smatch, tested on pNFS block volume setup.
>
>   fs/nfsd/blocklayout.c    | 167 +++++++++++++++++++++++++++++----------
>   fs/nfsd/blocklayoutxdr.c |  36 ++++++---
>   fs/nfsd/blocklayoutxdr.h |   5 ++
>   3 files changed, 157 insertions(+), 51 deletions(-)
>
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index fde5539cf6a6..d53f3ec8823a 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -17,48 +17,39 @@
>   #define NFSDDBG_FACILITY	NFSDDBG_PNFS
>   
>   
> +/**
> + * nfsd4_block_map_extent - get extent that covers the start of segment
> + * @inode: inode of the file requested by the client
> + * @fhp: handle of the file requested by the client
> + * @seg: layout subrange requested by the client
> + * @minlength: layout min length requested by the client
> + * @bex: output block extent structure
> + *
> + * Get an extent from the file system that starts at @seg->offset or below,
> + * but may be shorter than @seg->length.
> + *
> + * Return values:
> + *   %nfs_ok: Success, @bex is initialized and valid
> + *   %nfserr_layoutunavailable: Failed to get extent for requested @seg
> + *   OS errors converted to NFS errors
> + */
>   static __be32
> -nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
> -		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
> +nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
> +		const struct nfsd4_layout_seg *seg, u64 minlength,
> +		struct pnfs_block_extent *bex)
>   {
> -	struct nfsd4_layout_seg *seg = &args->lg_seg;
>   	struct super_block *sb = inode->i_sb;
> -	u32 block_size = i_blocksize(inode);
> -	struct pnfs_block_extent *bex;
>   	struct iomap iomap;
>   	u32 device_generation = 0;
>   	int error;
>   
> -	if (locks_in_grace(SVC_NET(rqstp)))
> -		return nfserr_grace;
> -
> -	if (seg->offset & (block_size - 1)) {
> -		dprintk("pnfsd: I/O misaligned\n");
> -		goto out_layoutunavailable;
> -	}
> -
> -	/*
> -	 * Some clients barf on non-zero block numbers for NONE or INVALID
> -	 * layouts, so make sure to zero the whole structure.
> -	 */
> -	error = -ENOMEM;
> -	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
> -	if (!bex)
> -		goto out_error;
> -	args->lg_content = bex;
> -
>   	error = sb->s_export_op->map_blocks(inode, seg->offset, seg->length,
>   					    &iomap, seg->iomode != IOMODE_READ,
>   					    &device_generation);
>   	if (error) {
>   		if (error == -ENXIO)
> -			goto out_layoutunavailable;
> -		goto out_error;
> -	}
> -
> -	if (iomap.length < args->lg_minlength) {
> -		dprintk("pnfsd: extent smaller than minlength\n");
> -		goto out_layoutunavailable;
> +			return nfserr_layoutunavailable;
> +		return nfserrno(error);
>   	}
>   
>   	switch (iomap.type) {
> @@ -74,9 +65,9 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
>   			/*
>   			 * Crack monkey special case from section 2.3.1.
>   			 */
> -			if (args->lg_minlength == 0) {
> +			if (minlength == 0) {
>   				dprintk("pnfsd: no soup for you!\n");
> -				goto out_layoutunavailable;
> +				return nfserr_layoutunavailable;
>   			}
>   
>   			bex->es = PNFS_BLOCK_INVALID_DATA;
> @@ -93,27 +84,119 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
>   	case IOMAP_DELALLOC:
>   	default:
>   		WARN(1, "pnfsd: filesystem returned %d extent\n", iomap.type);
> -		goto out_layoutunavailable;
> +		return nfserr_layoutunavailable;
>   	}
>   
>   	error = nfsd4_set_deviceid(&bex->vol_id, fhp, device_generation);
>   	if (error)
> -		goto out_error;
> +		return nfserrno(error);
> +
>   	bex->foff = iomap.offset;
>   	bex->len = iomap.length;
> +	return nfs_ok;
> +}
>   
> -	seg->offset = iomap.offset;
> -	seg->length = iomap.length;
> +/**
> + * nfsd4_block_map_segment - get extent array for the requested layout
> + * @inode: inode of the file requested by the client
> + * @fhp: handle of the file requested by the client
> + * @seg: layout range requested by the client
> + * @minlength: layout min length requested by the client
> + * @bl: output array of block extents
> + *
> + * Get an array of consecutive block extents that span the requested
> + * layout range. The resulting range may be shorter than requested if
> + * all preallocated block extents are used.
> + *
> + * Return values:
> + *   %nfs_ok: Success, @bl initialized and valid
> + *   %nfserr_layoutunavailable: Failed to get extents for requested @seg
> + *   OS errors converted to NFS errors
> + */
> +static __be32
> +nfsd4_block_map_segment(struct inode *inode, const struct svc_fh *fhp,
> +		const struct nfsd4_layout_seg *seg, u64 minlength,
> +		struct pnfs_block_layout *bl)
> +{
> +	struct nfsd4_layout_seg subseg = *seg;
> +	u32 i;
> +	__be32 nfserr;
>   
> -	dprintk("GET: 0x%llx:0x%llx %d\n", bex->foff, bex->len, bex->es);
> -	return 0;
> +	for (i = 0; i < bl->nr_extents; i++) {
> +		struct pnfs_block_extent *extent = bl->extents + i;
> +		u64 extent_len;
> +
> +		nfserr = nfsd4_block_map_extent(inode, fhp, &subseg,
> +				minlength, extent);
> +		if (nfserr != nfs_ok)
> +			return nfserr;
> +
> +		extent_len = extent->len - (subseg.offset - extent->foff);
> +		if (extent_len >= subseg.length) {
> +			bl->nr_extents = i + 1;
> +			return nfs_ok;
> +		}
> +
> +		subseg.offset = extent->foff + extent->len;
> +		subseg.length -= extent_len;
> +	}
> +
> +	return nfs_ok;
> +}
> +
> +static __be32
> +nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
> +		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
> +{
> +	struct nfsd4_layout_seg *seg = &args->lg_seg;
> +	u64 seg_length;
> +	struct pnfs_block_extent *first_bex, *last_bex;
> +	struct pnfs_block_layout *bl;
> +	u32 nr_extents_max = PAGE_SIZE / sizeof(bl->extents[0]) - 1;
> +	u32 block_size = i_blocksize(inode);
> +	__be32 nfserr;
> +
> +	if (locks_in_grace(SVC_NET(rqstp)))
> +		return nfserr_grace;
> +
> +	nfserr = nfserr_layoutunavailable;
> +	if (seg->offset & (block_size - 1)) {
> +		dprintk("pnfsd: I/O misaligned\n");
> +		goto out_error;
> +	}
> +
> +	/*
> +	 * Some clients barf on non-zero block numbers for NONE or INVALID
> +	 * layouts, so make sure to zero the whole structure.
> +	 */
> +	nfserr = nfserrno(-ENOMEM);
> +	bl = kzalloc(struct_size(bl, extents, nr_extents_max), GFP_KERNEL);
> +	if (!bl)
> +		goto out_error;
> +	bl->nr_extents = nr_extents_max;
> +	args->lg_content = bl;
> +
> +	nfserr = nfsd4_block_map_segment(inode, fhp, seg,
> +			args->lg_minlength, bl);
> +	if (nfserr != nfs_ok)
> +		goto out_error;
> +	first_bex = bl->extents;
> +	last_bex = bl->extents + bl->nr_extents - 1;
> +
> +	nfserr = nfserr_layoutunavailable;
> +	seg_length = last_bex->foff + last_bex->len - seg->offset;
> +	if (seg_length < args->lg_minlength) {
> +		dprintk("pnfsd: extent smaller than minlength\n");
> +		goto out_error;
> +	}
> +
> +	seg->offset = first_bex->foff;
> +	seg->length = last_bex->foff - first_bex->foff + last_bex->len;
> +	return nfs_ok;
>   
>   out_error:
>   	seg->length = 0;
> -	return nfserrno(error);
> -out_layoutunavailable:
> -	seg->length = 0;
> -	return nfserr_layoutunavailable;
> +	return nfserr;
>   }
>   
>   static __be32
> diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
> index e50afe340737..68c112d47cee 100644
> --- a/fs/nfsd/blocklayoutxdr.c
> +++ b/fs/nfsd/blocklayoutxdr.c
> @@ -14,12 +14,25 @@
>   #define NFSDDBG_FACILITY	NFSDDBG_PNFS
>   
>   
> +/**
> + * nfsd4_block_encode_layoutget - encode block/scsi layout extent array
> + * @xdr: stream for data encoding
> + * @lgp: layoutget content, actually an array of extents to encode
> + *
> + * This function encodes the opaque loc_body field in the layoutget response.
> + * Since the pnfs_block_layout4 and pnfs_scsi_layout4 structures on the wire
> + * are the same, this function is used by both layout drivers.
> + *
> + * Return values:
> + *   %nfs_ok: Success, all extents encoded into @xdr
> + *   %nfserr_toosmall: Not enough space in @xdr to encode all the data
> + */
>   __be32
>   nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>   		const struct nfsd4_layoutget *lgp)
>   {
> -	const struct pnfs_block_extent *b = lgp->lg_content;
> -	int len = sizeof(__be32) + 5 * sizeof(__be64) + sizeof(__be32);
> +	const struct pnfs_block_layout *bl = lgp->lg_content;
> +	u32 i, len = sizeof(__be32) + bl->nr_extents * PNFS_BLOCK_EXTENT_SIZE;
>   	__be32 *p;
>   
>   	p = xdr_reserve_space(xdr, sizeof(__be32) + len);
> @@ -27,14 +40,19 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>   		return nfserr_toosmall;
>   
>   	*p++ = cpu_to_be32(len);
> -	*p++ = cpu_to_be32(1);		/* we always return a single extent */
> +	*p++ = cpu_to_be32(bl->nr_extents);
>   
> -	p = svcxdr_encode_deviceid4(p, &b->vol_id);
> -	p = xdr_encode_hyper(p, b->foff);
> -	p = xdr_encode_hyper(p, b->len);
> -	p = xdr_encode_hyper(p, b->soff);
> -	*p++ = cpu_to_be32(b->es);
> -	return 0;
> +	for (i = 0; i < bl->nr_extents; i++) {
> +		const struct pnfs_block_extent *bex = bl->extents + i;
> +
> +		p = svcxdr_encode_deviceid4(p, &bex->vol_id);
> +		p = xdr_encode_hyper(p, bex->foff);
> +		p = xdr_encode_hyper(p, bex->len);
> +		p = xdr_encode_hyper(p, bex->soff);
> +		*p++ = cpu_to_be32(bex->es);
> +	}
> +
> +	return nfs_ok;
>   }
>   
>   static int
> diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
> index 7d25ef689671..54fe7f517a94 100644
> --- a/fs/nfsd/blocklayoutxdr.h
> +++ b/fs/nfsd/blocklayoutxdr.h
> @@ -21,6 +21,11 @@ struct pnfs_block_range {
>   	u64				len;
>   };
>   
> +struct pnfs_block_layout {
> +	u32				nr_extents;
> +	struct pnfs_block_extent	extents[] __counted_by(nr_extents);
> +};
> +
>   /*
>    * Random upper cap for the uuid length to avoid unbounded allocation.
>    * Not actually limited by the protocol.

Tested-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Dai Ngo <dai.ngo@oracle.com>

-Dai


