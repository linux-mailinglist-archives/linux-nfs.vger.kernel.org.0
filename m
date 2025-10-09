Return-Path: <linux-nfs+bounces-15101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D30BCA692
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 19:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75A3C4E206C
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82021DC9B5;
	Thu,  9 Oct 2025 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sY+dmusY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ECFS7mYu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F2246762
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031835; cv=fail; b=QQ/ZD1FWXr2CnAQ2v5P3QBMSJCIK6VhnEPhXYeYIH5BAm8Vr8ggBVaJaMMeYTT+hFNUo27efmWm8jQ9qxEHQYNytnRHppA8eiRPGIWqeNg3Z+mp8m1b7rSIowArMX+RJoZQs4skkEaMpMYoL/te7AkEFMiQAyO5SIewChz6+SwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031835; c=relaxed/simple;
	bh=rf9ZvMLfXyTYea4Jq2xfrk7EKistjEj4g8MwuzsGHts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=skIHmoYm7DWhg6scUPQwza1/WaU3kZshvuNsANgMjeZ0n1LwV+mKI/hsRBR8nBEUHg4yoogi+uL8z+s2ELXaH7cLAsTz0j6KsxXAcCNp4JcgqpmXzsXzzCMXQNFoTt6f6cuCGcvBkFpTLb1kLzMlP4XQqfRgrur5besDjh5EePg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sY+dmusY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ECFS7mYu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599GCKqG005622;
	Thu, 9 Oct 2025 17:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sT3URuMx93ieYxqBe1lRCumLmGItpb0Xqp0JJyo9Qlc=; b=
	sY+dmusY68P/uJ3OGYdMetvt65NzTUeRHLpZBwIYI0bOJXdIvla5Cdl7fa7vKWpr
	PsfJFBORMkiaE0jjMKEJb9YH82TARKhYsf17rMDux0AhPTh0BiZqBeOQWFtWRlcC
	OCDVWz4o2V8Tf2jziwukmRlxmvpv19mtYRx++MovFy+YW4Cl9y8zCAw/nHWrfYNd
	k90kD7nCeI5cXQYSujZqdfyt/DlRRF62olVFXxtBeIExyK2HGw94E578ReN5Sfby
	iM74GEdwdyecvcvXXgV3dnjcKgehlyX8GYtzxaoxx2I1Gg165NuyksGnAL/c7itA
	MOAmkI3mK2oa3fBveATlGQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6d267k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 17:43:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 599GJkTL013888;
	Thu, 9 Oct 2025 17:43:39 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49nv67r22a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 17:43:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaMnK3XLDkM3GHx3ODMkewa9/6/vi718P73WRFZgMd9dOQy2+KkDuvs6BZ1LcdZ+jcrE+u8qWjHfT9VoS50eYYuf2Nwed+RLHrgjRhEE3EfKFPrkLzAYxL0UQuhkS6RNawCZhU5I/d7xBlnnr0Kpa6yQcYeuPgBBL/B2aVOzmNBzaP57paz/J9pcG0cchIZGGBWCQF0qJbO4hsS3WOQiD46xVY7YtjEf7SGTHmL/SDTvHXKKnZPg9RBdslGfuUXP8Kv87wdDMOdMjwuZeAvQhvfULth+0GnBZ1ld8tYOTBILFbcqs/8IV+Vzd57NY+YOu0gOqP3AvUvJISH/oiIC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sT3URuMx93ieYxqBe1lRCumLmGItpb0Xqp0JJyo9Qlc=;
 b=sxWp6f0NyybaA8jjTsBgPf0ZIhjve5kF7jrzRKJci+moEcTMTiQSOQHQBeJc341FwBERUT5qNd+aWEVDiRE1q9S1aeWy9DKXn/soydFWqYYvq545UB+IqlLJY8g8vAup5wausWLFlu4VtkZWTbRtAuotxhamsULCqsuUZ0AVjaNtoegwp1bb1SqL0yH9BdYOtp6j9Y9lyi+9cUMEUvrrUGvNTUVmfxHKpkRIaouqJS+hPjxuNhxjEY+G2LYDh71HJ2IQ9MMs/X9Ov9e6QsyWVexjqy8Inxe8xbkKwp2UiByjEx/5iFdSGvqSCXk2Zc+6FFEs8AuLJGkwucNTk2ggzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT3URuMx93ieYxqBe1lRCumLmGItpb0Xqp0JJyo9Qlc=;
 b=ECFS7mYuNr/iqeladulR2GBdxfuk74x6lzFGS/x5qt6HAIWuc0B0vUD/tOlAmyVMHIJvboRDmRm9x/PlG+M2HlQMsDDNXJA0VJfd9lvil1IrtdndURWtqVTNJIo3rBPZoHbtCh9PN73zjNiBmSEN1ctbeWJIzWx9/RQ/uKAL/+8=
Received: from SJ2PR10MB7618.namprd10.prod.outlook.com (2603:10b6:a03:548::11)
 by DS7PR10MB4957.namprd10.prod.outlook.com (2603:10b6:5:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 17:43:09 +0000
Received: from SJ2PR10MB7618.namprd10.prod.outlook.com
 ([fe80::480e:bc8c:36c7:493b]) by SJ2PR10MB7618.namprd10.prod.outlook.com
 ([fe80::480e:bc8c:36c7:493b%7]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 17:43:09 +0000
Message-ID: <2cbf10c7-d434-4490-9e1a-8455e004d595@oracle.com>
Date: Thu, 9 Oct 2025 10:43:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
To: Benjamin Coddington <bcodding@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com, hch@infradead.org,
        linux-nfs@vger.kernel.org
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
 <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
 <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
 <AFF0E6AD-F593-4CCE-89E3-AA72E1650D99@redhat.com>
 <c0dced8a-29d1-4b5c-9fe6-47d065aa7255@oracle.com>
 <ddb63ff3-80cc-40b1-8e8e-f61575e85828@oracle.com>
 <B3F0921A-C9FE-462E-B3E2-D8D0E6B3521E@redhat.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <B3F0921A-C9FE-462E-B3E2-D8D0E6B3521E@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:510:33d::35) To SJ2PR10MB7618.namprd10.prod.outlook.com
 (2603:10b6:a03:548::11)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7618:EE_|DS7PR10MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e34d69-79cc-4e75-c0c1-08de075b4f6f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OWoybmpJWGFvNXVBRFZmVmczTkdvVFJzTlBJNUpKNjFxUytGUEZLOXd3b3lm?=
 =?utf-8?B?U29VQ0pjeUFibHlPcWxFM2VZd1VreklEdTVycWsyWmVIaFpGaGtwRFBpWXUr?=
 =?utf-8?B?TXJXM1NPYStwbmcvb202MC83czN5RU8zazJsNkY1OW9TRXB1YVIwZ09kNTZW?=
 =?utf-8?B?TVRvRWJ6TGVmQWJYNytNcVpvamVadERsV1puRVJlVDlFZmR1UUpLalNUNzZQ?=
 =?utf-8?B?UW8yNWR3M2tzWitUcTVUd2daWWZKVURrNDdzZm1sS1Nab3VmV0NTYm5tOVRh?=
 =?utf-8?B?UFBDMmpJNkFVMFBIYm9VczBNOXFiakhzMjVKb2ZucTlmaDh3Sm54Q1hmOEJV?=
 =?utf-8?B?eGNyNW5iTExYMlJQenhaalhUcmU1by9MUGY2OUx0aE92czZKWjRIZzFIUnhT?=
 =?utf-8?B?ZnkvTUxIWHB1cU9XdnJIdVVMYkw4b1Q4UkcwdEJxZFFqNDcyeGxSSElYUWpM?=
 =?utf-8?B?c3hXcHJrN2dhL2xvWGhqV0RHTlBvVjhrUFpxcUtSbEtKZ2ZRajhIb2lsbUF6?=
 =?utf-8?B?bGZYdTNwaGYxYXJBVllLOTNSQTROZmoxMitwY1VCbGt0VmJXeGJZQkNXYlY4?=
 =?utf-8?B?WFI4RHYyYkRTY0tRWm5XL3ZzUm95TVRlaVo4VlBrSjkzcjZIMGg3WVoxUlMw?=
 =?utf-8?B?MGo2NVMxTCsxK3VmZzZyNHRrV1ZpUWlkQ1hlSFFCVWNXVU95VVZEYXU1elFp?=
 =?utf-8?B?NE5SL2VyVlN4Z1V5VFdhWmlWanVLR0VrM2ZzN3lia0dvQ1YySU1Nb0dnbVps?=
 =?utf-8?B?RXdEbVFOTGRKanlsTzRhR2x3QS9veVpWdUdYN0lDZStaQ3NVQ3BHeHg2UEcw?=
 =?utf-8?B?a0E4WGR6RnBuMFVrZ3hucFU5WEdaTllJUE0yM1l6aDRDOVh2aGZEejdzcTdj?=
 =?utf-8?B?eHZxM1hqbVNjQUplZWNIdTJvVi9LSDdwU1lWa0QyZU9lUFcwTGFpZzBxU3hw?=
 =?utf-8?B?OEpXL2E5UG1ZSE5NWGM5OHc3TW9SbG8xMjdoR29YVUQwYjcrWUFFSEs3enBx?=
 =?utf-8?B?TXBzQUhYayt0RmlOZjNlUjRKRHozd1FoUEl1dmwrZkJXWjNjUU1WckpiR2xU?=
 =?utf-8?B?MjFQWG1nYUlLR1ozanIwQXd1OGdOUFFHRGtKUmlza0xoSkh0Tzh0V1FFa1cw?=
 =?utf-8?B?Zit5U2pmYi9rVVVWeGdHWFJZbzViM3FNTlNITUxTdmVwNDh4LzA4SXlpblZh?=
 =?utf-8?B?YTJ1dURML3g2TXFFR3BCYVdKcDNLVHdDY1YvVTlpckphQkJ3cnd5M2FVQURT?=
 =?utf-8?B?UjJYbXl3NmZJcDFsTFRpODhkNDdFQ3lrZVlZQlFzdTc4L21GSFJ1MEd2anp6?=
 =?utf-8?B?OFo3ZnVjQitmS2JFQVhZSExDR1BWMUhuUzhTSWE3dnhUaHpIbjFESUtSeU9y?=
 =?utf-8?B?TlEzRzV1V3BZKzRzYjI5YnFJSHl4YWJPRjJhaHBFQk02cHllS2xKREVrdHVL?=
 =?utf-8?B?QW0yY3pNTzBWOCtPbnRoWWdQTWlrZGhQZ2RhUjNWWm9ORno0ekhYby9HOWJV?=
 =?utf-8?B?WEszNW81MGhyM3VseHJVQlVPZWdNcnd3RmdUQ1pydCtTTGswNW9GOUFHdVlZ?=
 =?utf-8?B?eDk4MXlyWHo0WmZDWTdPR3NuaHFkLy9Mb2d5TDNiVk1HWVhHeVZMdmlEd1Ez?=
 =?utf-8?B?d096UzhtcEQycENwdEJ6UXJvYkU0a2Z1YjVISytBL0Z6WlpveEs1KzdDYjdO?=
 =?utf-8?B?TDBZR2orOXdHcE9zd2pkSGxYSGxJNmVJb2ZiSGNpa3VYclRxY3VFOWQyWkxL?=
 =?utf-8?B?MTVHZnFuTHRmY1FxckNDMW82Z3pPTXpFTWpKZGkwbDdtUlpaM1hHdU95RDRZ?=
 =?utf-8?B?eFpTT1NuNHY2UlNwRC9ka0tidVpCTDBIdkdsK2xmZnhUK2swMHBsdmszSUVS?=
 =?utf-8?B?QSsrcm0rdlU3VzREMURLdzVnc2tIK0FNaVZOVzkrVklSbVlrdDdJdlpJUDlq?=
 =?utf-8?B?a0RJcGxHNWhPM29lUG9ZbTA1dy90TmxyeUE0Vmw1cTVOOHN2M2pPcDgvKzgz?=
 =?utf-8?B?SUVCK1RaZUNnPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7618.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TGxMT3ZKekcwamYyOFMwZ09oeU5laTRlRXFYaGtNcVlHZUlWUUtKWlh3Ylhk?=
 =?utf-8?B?M3pNSE5sN3Fxa0RSUDhIcTJlMHFSUE92NklFSDJYYlhYU2tZQW9iUDhUZHRi?=
 =?utf-8?B?RTAzRVBCbGNjMTVsVXVTOVN1RHB0ZGc0YjdBb043WENjOXI1UVA5KzVvdHBo?=
 =?utf-8?B?dnkzVys2Syt2ZVQvM2QzWGhiQzJDdmpDbVIyZUpza3lEeHl6Qjg2eGhNVW95?=
 =?utf-8?B?L2hxQkFWejM5L0g5eTBLd3dWMVFzbUFFODVOaERad1l0QmRwcVBvZTFaK3VJ?=
 =?utf-8?B?RDMyS0l1RFdFUm9mbHRURTQ5WGlTd2hEYzRoZW1uc2FrTS9DamJhbTNuckIy?=
 =?utf-8?B?WENPVThqc1hPa1pVTGJJdHFkMStndjMrVzNwWTEydWFOM2gvM1pON0pTRDg2?=
 =?utf-8?B?amF1MytIQUJ5UmE5My8xMXpDT3BRU1Y0eGxITTdBSjVGY2sra3NwVE5Za0RL?=
 =?utf-8?B?YnJZZWR2NzhHcE5qeXRyTmdpNlR4ZEdOL2dZaXZZcXUycHEvZkNBRUhxLzFL?=
 =?utf-8?B?TWxaRkdKSVh6L1NFand6djVpS2Z3RnJJRmowQ2dLeWtaZS9yd3JGbGJjK21o?=
 =?utf-8?B?TXM0K2VDY0t2cEdXVUFheFJiQ0NlcGhpbEluN3Z0SHF5UzdrTGJWM3FEcTJ3?=
 =?utf-8?B?K0xwQm4vdjhVdVVwQWhIQUJyU2lzUVRHL2hNQjZ2a04rNWRUSXdUNkdibENI?=
 =?utf-8?B?SXRxeXIwTlVvdzRlTnRlbzY3a3U2L2FOdzl5UlRmeEZKd1lhSjdTYmxtektn?=
 =?utf-8?B?cEdIMVVHY2UrNnlMdUEzU0VrYnFRSklwOWJ3OFhQVFdDZ3pNc05rVXAzS1VH?=
 =?utf-8?B?VTVDVXNTNW56ZFFVNDdzUGhxb1pQUjMyRGZYQS8xWmdqSEdoVDMyWnFtU3kr?=
 =?utf-8?B?eDNRQVBvZjBVc2ZPSnBkUm0zbC9ZT3RPOWFpRlJOUjhTTGxOY3lRbFhlbjN3?=
 =?utf-8?B?ZUlMalM5N1MyK2laUmJ6Y0RxZFhFR0c4TXBTTVFHdUpKaGxPRkhzeklhOGtP?=
 =?utf-8?B?TThyeERjZmRodmdkY3BNeHVHMW5CY2ZRZDhLMWJ4Q2J6eE9kcUFkTGlCUTJU?=
 =?utf-8?B?MzIrK0d0VDVZeCtRMGY1UGNkTmFyc2tTdENSMk00c2x4em1RODMvcmdBdTMw?=
 =?utf-8?B?ZmQ0bCtxZ2dSQnRGbHQzbE5lTHNldTA5alZVN0VsZkwrWTlHSWlQYnAwNFBT?=
 =?utf-8?B?QUcvblpXQTYrNDVEbUVCa0ExWXNSNGdtMGh1RXl4TFQyMm1jR2lsaU9QYnU1?=
 =?utf-8?B?ektOOGU5eTFra0lOdGtSQmRqSlF6TDl4V1ZoN2pFSm1Icy9rL0YraDlkV3hX?=
 =?utf-8?B?Y3QvdUgzRkM2QmgrRk5LMjJjajlVeVhnT0dQTU5YMjRpOVdMNlRIVUJNU0VV?=
 =?utf-8?B?MjlQOTRNMzdsd2kvWFBoMVd3MHdFb2xzY2JsOTByMkxuZTZ0NEdFQmsvVXJi?=
 =?utf-8?B?SVJpM3dtbXVPZkVFakVIYjJqQWVUemMwZEttZ1AvaG9jODU1bGJ2dHM0SnBW?=
 =?utf-8?B?dTVDQVFPUjROQkl5eWlscmhmWnpjQkxIcy80VzdlZTBSdXhNSUZkNWhtbGI5?=
 =?utf-8?B?dENVNmRuTUQ5SGZDazRzeC9GbVF2bnV6ckE0Ty9jZUNNVE5TZUpCNU1aWDYr?=
 =?utf-8?B?aE9ncEg0K20xd29Tc0FNZndnL09sc2NCU0hBTTU1Z1pWZWdNcFVzVk4vYnBV?=
 =?utf-8?B?R3NSdVJsVlNQL3RYazd5bVFKMjdFQnlrazk0a2VBbHNIa1hoeE84RVV6RFBn?=
 =?utf-8?B?OE5GR3B0VnFCWExJQzVzQXVaS01Rc1EwQlZ3UjEyNHFhR0FpaFVOSlU0aWdS?=
 =?utf-8?B?dVYxN0F4K3Q4NFJqM0pNVEtXYkVhR3AwK2E1b3NiN1RvYnN4aGhhdmVBMWFt?=
 =?utf-8?B?N3NZRWIzV3p1Zm0xV3RMZnlnNUdFcEVrblpYWm93LzZ0Tkp6SWJxcDZ5Q0NT?=
 =?utf-8?B?SmphWC9pK1VYY3p5RmZTYU1IaXo4Zy83cjVLUGFwb1M1WVVlVU5RcXhZdHlS?=
 =?utf-8?B?cCt2YUpYVm91SWdJRE9oNHFuV2JMQUJRMFVIMlpoUHVzdDZrWUE4ZjhZU2xy?=
 =?utf-8?B?eTlMVGxhM3pZU1dLRnhvNVl2UWJZQzNYb2g2SFZSSnpWU0EyZms4b2NNT2ht?=
 =?utf-8?Q?HnnCYHml/O1AMtJDmbiDAnQmn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MhRuNW+ZdMYHvI4s+9fincrnDI3WQqxM7NheDKJBd25Z6Xbesi8KpxalT6zqb9euxNe4cQWTxr6vE+DSDYEzBlAXH/cnDU6rHAB+0+IpwJPNsKLzIWdQVIKe1Ztzeu87/qgX1Qz3zlIefp6NDcOWoatPkkh7L12dm26mpGbgyKlNhNezSSX5LheLkFwcTs8Y3/2CCbfRxPqAfhZ0ibbP1nCHPbMrBiLgSnqxPScb9S/9GS4Wh/h1bSYlGz8wVY9uMXiSCxrVs9t85Q3DvEqavGwQdKhJKvHrSvqN3xEXXB73T4OUtcX4wBXGAlF8ZazmpwEFCcucIeF4nanND9fc5aLqw5ZDaKmB+FqlNP0KUCs0wOqMIKj6oQIRnolmsNDAumjxDuUVwV1tDFUinkgylzXTEWc/ajjQha7gsOKZKjhmRICfytcFZTHakl9GfsivwWr+KRur2vjOeH1XRcj7g67GwBEUuWX0xcGelDeKKWS6hsfGTN4ud+2ajad16LN22Oq4GDQPtx7KTQh+ntt2my2oBbNph2vbrKHKNm+EnBbu4T5RujNP68NaJaHR5Q0cAfZWRZLYPbyg8exoCGTNQtfc5xP56ESb60uioyZSuew=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e34d69-79cc-4e75-c0c1-08de075b4f6f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7618.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 17:43:09.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j56hj3frUBktbxLIxEGvWfdYsmi+Vb2Jymeq7RkIK802+iVxvVvvmbhE7bU5gFFaAH+Q23fZeb4xv4gHrf/bmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090108
X-Proofpoint-ORIG-GUID: yJDJfsXZ01jDN8pbqO26q-n4xrEhMU_u
X-Authority-Analysis: v=2.4 cv=bK4b4f+Z c=1 sm=1 tr=0 ts=68e7f44c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=JLDxV_SaAAAA:8 a=cTMn-MkfAAAA:8
 a=20KFwNOVAAAA:8 a=DAVv2BV587m5Yaj1JSIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_uzX4oWg-uDLJ6b6Md12:22 a=07REm91lqynEFC2MfXjm:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: yJDJfsXZ01jDN8pbqO26q-n4xrEhMU_u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4fWMbSuGl7O+
 XRHOKRTnJLAnOCj+ae+Sci/zQiaTAAAdGLYNzaHssogeuyK7NO4RIZ0C8Q9lMIhVC0/fTNvUS53
 vmGOge3vsmSvnrDWB+rvU+Fb8tB6GxLs6LZcfyazLXX+RngI2BsSm0xK6An3X6QuR1R5n0BybWt
 lcsslSf5NWOPRQdfAOoK/7iNBP4MVWc7FcO7kpM+qgvWgLVnLqTpwoRw5ZRViR0Ls9xhu6cBnj2
 SuGxyCV4GBHhLel2bkkhoRom/PJOC/SeNd84meqHRmXP1sXNmr4xcFtYtu0cq+gfMNnb1ylF/OU
 YDEoyx0aLzyLanIJX4TWZNAPg3YpG9A5eAZBYK+hJb/rGsFOJuXgEmDzCxZma4PpFk6VcQW/Gub
 KJv0EohrMwGPtBe+XdqHcKLm9GQf1A==


On 10/7/25 1:37 PM, Benjamin Coddington wrote:
> On 7 Oct 2025, at 11:59, Dai Ngo wrote:
>
>> On 10/1/25 10:36 AM, Dai Ngo wrote:
>>> On 10/1/25 3:54 AM, Benjamin Coddington wrote:
>>>> On 30 Sep 2025, at 17:41, Dai Ngo wrote:
>>>>
>>>>> Hi Ben,
>>>>>
>>>>> On 9/30/25 12:15 PM, Benjamin Coddington wrote:
>>>>>> Hi Dai,
>>>>>>
>>>>>> On 30 Sep 2025, at 12:28, Dai Ngo wrote:
>>>>>>
>>>>>>> When servicing the GETDEVICEINFO call from an NFS client, the NFS server
>>>>>>> creates a SCSI persistent reservation on the target device using the
>>>>>>> reservation type PR_EXCLUSIVE_ACCESS_REG_ONLY. This setting restricts
>>>>>>> device access so that only hosts registered with a reservation key can
>>>>>>> perform read or write operations. Any unregistered initiator is completely
>>>>>>> blocked, including standard SCSI commands such as READCAPACITY.
>>>>>> SBC-4, table 13 shows that READ CAPACITY should be allowed from any I_T
>>>>>> nexus, no matter the state of the reservation on the LU.
>>>>>>
>>>>>> Is it possible that your SCSI implementation might be out of the spec?  Also
>>>>>> possible that SBC-4 has been updated, I haven't been following the SCSI
>>>>>> specification updates..
>>>>>>
>>>>>> Ben
>>>>> I don't have access to SBC-4 spec, t10.org does not allow guest access
>>>>> to their docs. Can you please share the content of table 13 here?
>>>> The document's licensing prohibits me from doing this, I'm sorry to report.
>>>> I have a single-user copy that prohibits me from copying or transmitting any
>>>> part or whole.  Looks like you can get SBC-5 from the ANSI webstore for $60:
>>>>
>>>> https://urldefense.com/v3/__https://webstore.ansi.org/standards/incits/incits5712025__;!!ACWV5N9M2RV99hQ!N4FtetrpMVBPf88WPTlz6EuwsK0kPhNqw04MXvtXGUwMzzAf0NPkCYhL5HYx32ZZVogW2MKS0Jr8P8M$
>>>>
>>>> The reason your patch caught my eye was because we'd previously fixed the
>>>> same problem in the SCSI LIO target.
>>> Thank you Ben, I'll get the spec from the ANSI webstore.
>> You're right Ben! The SBC-4 spec says read capacity is allowed in this
>> case.
>>
>> The problem was caused by the DS was running an older version of the
>> kernel that did not have your fix:
>>
>> 28c58f8a0947f scsi: target: Enable READ CAPACITY for PR EARO
>>
>> This fix did not include the SERVICE_ACTION_IN_16 with Service Action
>> READ_CAPACITY. However, the Linux client tries SERVICE_ACTION_IN_16
>> three times then switches to READ CAPACITY (0x25).
>>
>> Thank you for pointing this out.
> Would you be willing to test this patch for SERVICE_ACTION_IN_16?
>
>  From d7fa5d5f593dcfe39b7456dd6f23eb042fb2636f Mon Sep 17 00:00:00 2001
> Message-ID: <d7fa5d5f593dcfe39b7456dd6f23eb042fb2636f.1759869410.git.bcodding@redhat.com>
> From: Benjamin Coddington <bcodding@redhat.com>
> Date: Tue, 7 Oct 2025 16:34:37 -0400
> Subject: [PATCH] scsi: target: Fixup two more cases for PR EARO
>
> Allow READ_CAPACITY_16 and REPORT_REFERALS for SERVICE_ACTION_IN_16
> in the SCSI target driver.
>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>   drivers/target/target_core_pr.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
> index 83e172c92238..0b6803754422 100644
> --- a/drivers/target/target_core_pr.c
> +++ b/drivers/target/target_core_pr.c
> @@ -465,6 +465,13 @@ static int core_scsi3_pr_seq_non_holder(struct se_cmd *cmd, u32 pr_reg_type,
>                          return -EINVAL;
>                  }
>                  break;
> +       case SERVICE_ACTION_IN_16:
> +               switch (cdb[1] & 0x1f) {
> +               case SAI_READ_CAPACITY_16:
> +               case SAI_REPORT_REFERRALS:
> +                       ret = 0;
> +               }
> +               break;
>          case ACCESS_CONTROL_IN:
>          case ACCESS_CONTROL_OUT:
>          case INQUIRY:

The patch worked fine for READ_CAPACITY_16.

The REPORT_REFERRALS got a Check Condition with sense code 0x2000
(Invalid command Operation code), whether there is a PR or not,
because the SCSI target does not support Referrals as reported by
'sg_vpd' command.

Thanks for doing this, Ben.

-Dai


