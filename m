Return-Path: <linux-nfs+bounces-12476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F0CADB1A0
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 15:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F9C188A819
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E4285CAF;
	Mon, 16 Jun 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iRn86gKX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nJZ540Kr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C67292B24;
	Mon, 16 Jun 2025 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080104; cv=fail; b=gYFNqLBNgnUBeSH0Plxtjjbg1vwU5oYoN2+4qpjsTs9PY2dUAkhMSyYyzDffNCIRqbc6vHJ+cnu9dU/6E5OtHq6c/tfYTCVDlWKPen2BO2HSpnt/wzKT5My1DzhAudcrLa4ga/5K5QaU+uNCwLDpMQ/kFKX9K+sVTbBq+uzz4S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080104; c=relaxed/simple;
	bh=CI/a0KJAUb3bUWNdBv4wVaoEcuZ2v8T+s/ZfXYtz6oM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N5a3Hic5pFi+HgR8XB8nEl90Y4JOLYAnuGVhQe+F17eVXpeNRRgg9u7WJWZ6v46iXgaOsBtoeXKPYza7gvLfqMpy0eSDXbGqt2JQTYzrBlYhymPrPrJzzoBEOBI05omhYsygHsYP/0a59KXWksMmxzudEZ/PJZS8Hrf0cCQtIrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iRn86gKX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nJZ540Kr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G7fbwE023294;
	Mon, 16 Jun 2025 13:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=l2e5Zumx2je2WVFBbZomchTL4X5k6Q8dp+fOtX8Ymew=; b=
	iRn86gKXFwwwPZ2F52A6jG9BXoTWvxBtw5+e3W7OFS6GDBUyryraIm9/vA3deBX1
	HSeWESlxtZbbXU26fdcClFsRwNQizTPQnTYHGKPuYohUDq5h5ij6POHgJI+6hxkV
	Ydtn0vpjWjsFrwHe5AJ965F8P/Y1GqybI9K8LHoZYFIgqI53g033A5dz7+2vp4kD
	w3roZkM7QaxDTNCH8ZW8+E40/Kagz6BKKf6XpmLqRHbhwke4MfbMl4f4GJX2h1gJ
	ZXBQIC6zwsrLCY7ZCZsEHsPd+mM1lUhJ/XdCQButdEzVVCQylsOum5gEhTvLFejH
	YkoAvAk/u5GH+6DuyisuVw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv52gaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 13:21:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCUUVi026039;
	Mon, 16 Jun 2025 13:21:32 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhe5kyx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 13:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCcP0YdojsADzoIUPzhRuUjSzsL43Ywg/DDNhNzUXOrPPSh1ZjvLu+7cVVr/LyclSiQiiRblXc+dRa7559FHnHKQjoZ39EQYClJmY12Frux9/xBqlz6CCummU//OoGTGvrGiJRDlVAAtuRWjTvgWtqIwafRAj7FEqqeU1GAOcSSRWWyVl0G2/2rRi7IfPKrzpgETT1883WsofgEXV2gie14hLdXKFoFJTfHB5Yx6CUAQT1bKFy+N0vJR2F172f/wIuNu0C0nGHTQGUc4wyXClbD+AjPIk0oiD1QS1K8fvPuRb8/pbsEcOvZnKFwknEpL0hwOrsqjV6HtY1CSEwq/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2e5Zumx2je2WVFBbZomchTL4X5k6Q8dp+fOtX8Ymew=;
 b=oLjVF4JDSP/tca2Rv3N0IP7bluqQbSl45R9wYOFwXLbPryMwboBdRtqFy3wkmg2sxJTNeCcVgSTpOTqUatt62Qvbw6Fh+O6iNGEjtvBbTSomiqn4arn1AQ13b7UQmS9VIEQrYIYzUQtcnvevaXTh+hXn3EsLxG/4B8ACp5hCFcuLyy1R48evdfa7ybOX1CUdWCsNKGBnqoTiVHViwHvoD1gYbjE8m2TDnfWNiTfAPdN/8W+cJyotfEnJUhVmISn3WOiOMn/GMZ4jJD7H5VpAka9JANS1/WtgePNMWBnsHvAJ16qPQJaCeAVhXyG/eaB8R21MLrwrTdJ7ltfFn4mxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2e5Zumx2je2WVFBbZomchTL4X5k6Q8dp+fOtX8Ymew=;
 b=nJZ540KrvC95WjfaaZ6yyXbkCWMUvGVuGWIo0v4gvgW+j/jLO4tFmz7hJrDULvmcIWHI0GaNCY90tDXvZ8lxs7SuWqBe5lhp75j8g7qu8vWYbF1gRf1X8lYxHuKu2SSRS48/Y9Hp5V4TSvzlmYvGEAttUvrdTzurvaySsy3qdzE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4760.namprd10.prod.outlook.com (2603:10b6:510:3b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 13:21:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 13:21:29 +0000
Message-ID: <0b8605e2-ff29-4996-b74e-24b9097cc9de@oracle.com>
Date: Mon, 16 Jun 2025 09:21:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Use correct error code when decoding extents
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250611154445.12214-1-sergeybashirov@gmail.com>
 <5c8c207c-0844-492f-99e0-48b874b5404a@oracle.com>
 <2eq26bzisytieyfvad46uz5lr55msw6fdzs57lp5lcjmguuod2@nr2aryd6qaau>
 <b6ba7275-ceab-4619-9e5b-a886daf34689@oracle.com>
 <aFAQTwpSSJtDUmu8@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aFAQTwpSSJtDUmu8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0396.namprd03.prod.outlook.com
 (2603:10b6:610:11b::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4760:EE_
X-MS-Office365-Filtering-Correlation-Id: b8eed2ca-0967-480a-f493-08ddacd8b410
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TWgrNnNRQVBuUSs4RE9EL1JIMUljbTgwTU5iVGVQS3RZcVROcDMvTFRUeFJQ?=
 =?utf-8?B?SjlJeFN2dkZzYjBTY1phclI1bWk2d1JBcDRsMUJjcXlmdEcrQWphdjd5T3FM?=
 =?utf-8?B?cERHZU5Db0M0RnFtdUpxNC9ZTzZDVTZkTTEyYVNPN1BVVkhReHRyVjBLVlZp?=
 =?utf-8?B?aDVmZGwraUxGSFZjMjVkMm5iYjN0THRjRUFwMlpRWmRZcExlcjNoNnpHcjBi?=
 =?utf-8?B?cWIwWFEzWFQxd0Z2NmdaeEJ6bTgrQURkeWVNTWMzNmhDTzZBV0RQWUpPdGtt?=
 =?utf-8?B?QlRnbis3NFVqUWpYdC9qUFE0RkpWT05uNUQ5RzFRazdYNWpJMEFNVHlYYWd3?=
 =?utf-8?B?VEZzZVR0Y1JJK2tiVzJBMldOZzd3MWJ5enR1eXJaSm9jTDZKamx6ak0vMkNr?=
 =?utf-8?B?V1Y4aG9xNmwvZnJBYVZobXBtRUxuZWZZWUtkcXMxenY5MjJJdUt6U01UZzIr?=
 =?utf-8?B?U2JSZC9ib1lsU1dRS3IyMmVzOG9PWmh3QmhxQjdIZ2tzVlBnVHpnRTQ1U3ZQ?=
 =?utf-8?B?UFROMGV6TkZjV1ZKcmk1cVpJZmR6alNiSitZaUNyOERlV1ltOGVxRC9wb280?=
 =?utf-8?B?ZjFyNTlORDRyWVJFemNFMThFUm9jQ2c1c0htWTlsTk9tbUR1bmRHeFVFU3pj?=
 =?utf-8?B?WUE3cGFlamNjQm1BYW5ZOE8zUEZqd0kzSFpmNGFyVFZvS3FseWtDVWtKeUxS?=
 =?utf-8?B?Z1RmbXBZYVB0aG0vbUF1M2xUMFZLa3ZJV3pzSS9ZOTJRRmdPdHYrdVBrQ3g5?=
 =?utf-8?B?dERsQ1R2dGZtbnd1STh4MmtlaU5vaWtLc1NkSFl0M1EybTBhOGZ6MTQyTzBx?=
 =?utf-8?B?NXIxaWNXK0VqdHAxS0VmSlNJS015N2wrT0d2aGJRVlkwT1JHbkVtdmtNQytW?=
 =?utf-8?B?eFYvKzhVdGJmUzR4djhqeXQ3WWlTSldYNEFUb2g3eXM1Z1lhUFpGa1UvWEJ2?=
 =?utf-8?B?U0psaExCWlUxUUg1ZWdJckxZY01YWCtuUFU4cWl5OVhLVkN1RDRDNFVVVXNs?=
 =?utf-8?B?cTJyckpuWWpTKzIxRDRqQjBqQ1pCamFsMUlCdEdWWUJaOFlyeTNjQ0hJN29G?=
 =?utf-8?B?Q2NMTzRtSmxOV21wUEgzS0F4ZzRaeGpCMkJKWHVlSGMybmNyY21paktkQ1Jj?=
 =?utf-8?B?aUx2dnA1SENGV0M1M29pWHZ0ZWl4WmZJRUt5Vy9Wbkpabktmdzdrb0JuQ2Yy?=
 =?utf-8?B?b2czY1NscDhUZW9oQStoSWd1MkYrbGFvWEsweC9SOUF0eGhoc2JVbFdBamNk?=
 =?utf-8?B?ellhaElvN1ZKQ2hMT2ZUOFlndStvcGtDMDJNSkxOTzR1cXNlNUd6TWVnVjRz?=
 =?utf-8?B?MHEyUXkyWXE5UEVTZ0UyRXJkRDJ2SUNBOUVhUVY2elBNb3JPUlAxTk1KOEtt?=
 =?utf-8?B?dUNDUzRRRUtDNUF2R3V6QVo2aVJCM3p0Vm03UXNvaWNuN3cwWTlBMW9CbVdU?=
 =?utf-8?B?ejlKUmNSSTNEQnJYN2l5bEdCWldOc2xCclRtZWY1SHZLZUxaL0JOUk4xUjdB?=
 =?utf-8?B?VndZWkpYc2RpeWN2bStoRkpaemJRVHlFQmhaZVd4NzBTekFvcFNoS2NoWTZW?=
 =?utf-8?B?MVRxeDRvU0ZURnZKbzZxMFBoUEo2ZjJubEhGN0prbHVEZnhjYStrakt2UnhD?=
 =?utf-8?B?cGhEVWdrMmxObkFOVno4QkhFVXNWYWZWVFhaMHUrZTZhSUdoS2pmVllmMkln?=
 =?utf-8?B?QW1GdXgrTkFHY0ZiTkVya0pnc1NJQndnUGt1dnRTNUw0bFlwclJCOWpMK2Jr?=
 =?utf-8?B?UUpwTGw0SjZoc2J1bStzeitGT2lMSVdDWlZXZHp6L2hqN2ozU0N4ekhFaUZL?=
 =?utf-8?B?MTQzMlREV1p0blBsN0lLcXhMK0Q3clpDNjdMWTkwMElOOE1XZEVCVVNjd0l1?=
 =?utf-8?B?VkVtQiszcW5oTkJYK3VyekZ4UExrcHZNTWtXcmdGM3JsYkE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M0s0Q1QxR2ZtaUQxUGcwUWtvTjgxWFhvU0pBWG9iZnQ4Q3NVMFlBZGNyVzJW?=
 =?utf-8?B?TlJNLytQK0tvdmdPVlhOV0d6WC9FUWczY1F5NWt2U3ZNS0x0dXRKVmRqUTNO?=
 =?utf-8?B?RXMvR2thZEhyY0JVcVJ2b2x5dFBKY2NiSjdRN1BoMDJhVVpxZHVBU3MrTmdh?=
 =?utf-8?B?OHRyM2JpNW5rb1NLdFpuNWpsN3BPQk5mbkdDMnpyV254SkN0L2k1TXU3NjF1?=
 =?utf-8?B?TEIrL0pHcUY2WUNkNFZHWkVjdWc0bmE2aHhMck52V0tOOXlvNEorWkNITmJV?=
 =?utf-8?B?QWVYbGNRd3pJYitKK1ZxdHlFRk16dDZwNlB4MXA0RnpPbGVic0JLSEFRNW54?=
 =?utf-8?B?UnZITFlvZHRML1hSUDk5Q3N5N001d2Z4eFlJQWNBMW90aXY0NG5pdUp2UUl5?=
 =?utf-8?B?K0ZwTHI3UHJYUVdQUGlQZ1QvL2h5dm5kN2dUZm5valR5cFpDd2ZnaHZlMVZa?=
 =?utf-8?B?RmJKejNkRXBuZEp1VDQ2R1ZYbjFWek8wVDQ4RCs2VEE4dC9UNktKZ1NlOVd2?=
 =?utf-8?B?VzhpVFFVY0dDc2ovbnhVVjJyT0xzaklYazJUcVFMc0RQUGVpZStvWmpWNmpl?=
 =?utf-8?B?WEhFWWpQcFUwbTBXNDNPaGdYamQ0dmJqN3NnRUxWY0p5MXRBUUpUTFc3VVJ4?=
 =?utf-8?B?MEk0UDNZTHdYcWlESzhaVk0za213RVFNcEVtYjlYdSt5Q0F3bFU2eDJHTnA1?=
 =?utf-8?B?dE5TbWdZZ3V3SVNpRzdlM0RoUGt6QU1UcDNZRGN4WUlsQzdXM0pQTHhUSS93?=
 =?utf-8?B?WFh3Nk5LbEYrTUZVbnpzaUE3MDRyVkhMWmUrUU56VGV4MTloL0VkNXhETnM1?=
 =?utf-8?B?NndZZFZ4ZzhHT3RaQ3QwOVRRNHo2ZVZJaXN5RkhocGFaSmg0WFNwTzBHVjdB?=
 =?utf-8?B?a0tEUmFiU2xiS2VOT05PUnF5NTY5dXEzUmU2L0Q0OHNFeEM2ZFNkQnc4NnYx?=
 =?utf-8?B?MzlSbEs4MmpnOXBRL3Z5VWdTSTFFaysveFNCTXJHYkdCQnBxY29McFQxNUV5?=
 =?utf-8?B?NHRwZ2lFS1NoMW9XQURBSzFJMVVpRGpvRVdhRUxQOXhVS25jWHQrdzVsTjQ1?=
 =?utf-8?B?SGZLRWczeWQ1UnFTelhWQTNQUFlGbUhoa05CMEtWOUMwUUhGbjdUSHV6Z3lj?=
 =?utf-8?B?SmVjTGFnZHk3ZXBHd1FHamlkN2J6Zk5FODJFK0NGNGhxK1huYVBXdFoxQXo3?=
 =?utf-8?B?dmYwTHMrK0lDQ3Y1a0RGZFRreXk5MENqNmN3RzI2WFpMTXJyR1lqS05kM0g5?=
 =?utf-8?B?RktBd2dnY0lUZHlaNFZGYVdYUFpCSG1CSi81ZG1WUlBRUmZuWjRQbUpPQW4y?=
 =?utf-8?B?SVllT1FuRGNGRWdzb2tuVXhQVHAxZHBTUkREMnUya0NkaFRCVVlGRitsWllW?=
 =?utf-8?B?Y2JpN0t2TFRiUEpPVEQ5b1U5NjRNVFZIWDZlWU5CMGNGRkhuRFFlaFpmQktS?=
 =?utf-8?B?ZTYwRTg4a1JveG5NWTNHT2VPWG83cjJwekJmTVVZRXVQd3kvZ2ptdld6OGdJ?=
 =?utf-8?B?TDk1YS9QbTJhRzdRaWFSMm5MVHc0aDdNTkpoOEpjYmVzVTEzU3BWandEa09x?=
 =?utf-8?B?bGlFeWNFeDVVcTBjU1VFRzhFOHhiRm1pdmhPVHRZZjluZGZvVy9nZGlmRHc4?=
 =?utf-8?B?Y201dDlMazFYSE9Oc05ndmpJOHZpcFEzeWlQN1pNaUwrLzdhNzhDL24xcTNr?=
 =?utf-8?B?TzVwL2FBMVRqMFlVSis4OUp3MHFwb3JCV2JBNDBiR2F2UzFwY1pSWlFTM3hB?=
 =?utf-8?B?eGcwUlBQQWtONStlQ0o5eWRuRytIQVlkTnVIWXZXMGZDMlBlczQrK0NSR0Yz?=
 =?utf-8?B?cE8vN3FlMXZkWkljTHVhZmdrK0k2Z2RhZWE4QnpjZEpFUTdrT3ZiRDJrbVli?=
 =?utf-8?B?OHpjRU92QlFGOFZTSWV5cExzMFRQcy92SmZqTXkxcXRuaEV4S2pVUWZqd1lJ?=
 =?utf-8?B?SWJQT1RiRlgvbUNta3d1TG4wN2RjaEJRNmRqaXVwbnNOZkxrc1FkbnBaaTAv?=
 =?utf-8?B?WlZvNS85cGw4OFVwWFJFNEdLZCszc2dKR3dPdkR4d2dXM3pTNlRhM09mMEZi?=
 =?utf-8?B?ZS9WTG93SmYzR3lyYWw4Rmk0L3VOMHlIQ21nTVRYYVZOWUZjOFo0d09lbDNo?=
 =?utf-8?Q?9REPYKPmbfW+yR6JiVoDhcHmC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p0wlKbgv5IwaJNbD8B+6NkyOX0VnVzNf4gc+1xCnQpJQ/mkszcuZPjYsN1Vh6uRecQAgMpXTSd0QkiOSPG0xHuQn3rCwHauFL5cZD00aI+jBngP9kRQWgvbn8frExDDuhOtP0Pv+TESXgCuuxKGCBG4QUGFC43CLPiS0/Zi3EcIEYIJxJddG9QLU9LjSkEQSkLZX/5pzek1X0VdLubkYBEiP1tyxZN9/+zUtaKHBVOGQWW1cqmJxFB3qRzEgTKB3sELRHhNdiXL++1xzLZRPiZEHJBqcpomS3XcbZQNggJxj7rUmTrI4nlVTz1IAQj1Ei3gUTbT/NsHE5WF8gvAUt1t/lBFX5PeV4N93qFGkqLm/hp4tDD+Xigd+jCPP66V4xWIkG6ee0ibZRQZeQmTS4oGCrnO1hp0SernCKOWhe4gOzfxjL+4Zko+z+HKNGvrAockaErInxn+WWeAs9Q6VbYYe4aHSPqCojR8ff7tL0JATdfwTRU/RwPcZrGkcgwuXX6vqlLW8ByTq+fBH+e6ZU0w1VUaJkrE8Gq7vs5lULW1YPUAzKX1sFoUKN4QWdP6AwA2X0JmgEDsjgszhRu5xQpeNsZnBQ3s/+2vejr5ZuPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eed2ca-0967-480a-f493-08ddacd8b410
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:21:29.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kbks+nFh8yHVHvFyIlS+r+wqfXuZcdTcdE+a80Y7Q6030vfq7yr+ARzDRf2FRa7P3peW6beurMkIFM0HMNTsWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_05,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=832 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4NCBTYWx0ZWRfXwylzt1Zzhhxy N5DXtAM/kle6i7HptVID9io0iztx/8VIm4szXLidZAKScE24Kgs+QDin9bUKskWLbKKlPF2PK32 em1Zocwiw48JduZDQFcEDY0U8GIKIsCvCpaQde8euCp+c0EboIwAPLdaB4BNvO8jJb/Dg7TkDwF
 CdiwbzTyVam8rZAQMuti0qR24eIY1AW5V9O7F8Tpz2wC7qeoCNF0v3bMyWIGFCK9yS2DWCkpjYw uIrSh5+xUjEhjG0lR/riI2Jy4Fsvm5j1Ylf/KzVISQrJI9yS81BY8bOnvnTP4XBzW1S/1c5ERbr R+syu+hB6NixwXz9anVCRpgvujDFHT39gZvTavdgkwVE6KslS9x3FpSbRw4G7TUpYEPEmKPbIMp
 ksWuB7LUrQhc9/5TiJU3c7xpmi3d2c6kWW50GivmqNQLlTL+T6c9DoTO+sTfHhNRlfcGo1ye
X-Proofpoint-GUID: mipAOpZfHj7RCqIraXZW17I6irD8Emx3
X-Proofpoint-ORIG-GUID: mipAOpZfHj7RCqIraXZW17I6irD8Emx3
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=68501a5c b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VGxov8SuNYE1kKqQEEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207

On 6/16/25 8:38 AM, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 12:29:51PM -0400, Chuck Lever wrote:
>> On 6/11/25 12:24 PM, Sergey Bashirov wrote:
>>> I also have some doubts about this code:
>>> if (xdr_stream_decode_u64(&xdr, &bex.len))
>>>         return -NFS4ERR_BADXDR;
>>> if (bex.len & (block_size - 1))
>>>         return -NFS4ERR_BADXDR;
>>>
>>> The first error code is clear to me, it is all about decoding. But should
>>> not we return -NFS4ERR_EINVAL in the second check? On one hand, we
>>> encountered an invalid value after successful decoding, but on the other
>>> hand, we stopped decoding the extent array, so we can say that this is
>>> also a decoding error.
>>
>> On first read of Section 2.3 of RFC 5663, there's no mandated alignment
>> requirement for bex_length. IMO this is a case where the implementation
>> is deciding that a decoded value is not valid, so NFS4ERR_INVAL might be
>> a better choice here.
> 
> Section 2.1 of RFC 5663 says:
> 
> Clients must be able to perform I/O to the block extents without 
> affecting additional areas of storage (especially important for writes);
> therefore, extents MUST be aligned to 512-byte boundaries, and writable
> extents MUST be aligned to the block size used by the NFSv4 server in
> managing the actual file system (4 kilobytes and 8 kilobytes are common
> block sizes).  This block size is available as the NFSv4.1 layout_blksize
> attribute.
> 
> While it would be nice to state this again in 2.3, the language looks
> normative enough (TM) to me.

No argument from me.

Passing in a non-aligned bex_length still doesn't seem to me to be an
XDR issue. Failing with NFS4ERR_INVAL seems like the correct server
response for this situation.


-- 
Chuck Lever

