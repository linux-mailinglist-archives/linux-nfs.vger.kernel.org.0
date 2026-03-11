Return-Path: <linux-nfs+bounces-20049-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPk7EF7gsWm2GgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20049-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 22:36:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7A326A7A7
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 22:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6AE83040329
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 21:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1091B324716;
	Wed, 11 Mar 2026 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ogAEJaGl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="piYwxxBz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80930F7F3
	for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2026 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264985; cv=fail; b=fBvUhZOwHRVG0lTeAt72kcNePt+BBHCs+xOrFrAMOuct0zIsUQpjezWA808sgIuuSFkqqZ7teON9KHO9YVGqz9+GecovNAaGPRiskUrNkLGmTtoVeS+68Ip+VB2c1iJikBeC/N+LsBxH/dL9Px51l1ieOfwLakXJRDQfS4+2q8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264985; c=relaxed/simple;
	bh=jf9Ur5jVGcPOxdo7G2lFqN9ROrYr3lOYzeQ95imJ+N8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pe/n566x6gqn57hnonhUg0wEreBhWNm5sYQxQk8yzzRK37U+DuNyGgosOVqluZb9bL3rlR66kbmUvcU4bh4AaDzv8OKOOiaNR9eFrrIetgCBBF0yPIaIp5Nwd9P7AppWnmpGdkUKsyBAhy8Z0PEpjD+PMj0fDHNMjzWipC4rYZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ogAEJaGl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=piYwxxBz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BHMc7q2334236;
	Wed, 11 Mar 2026 21:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qEcYatUnp96/855bcYnlXUA5ppoc7PZGi7eI0kyxQos=; b=
	ogAEJaGlEydBCU3xJyQEwO5Pu7eAV1f6AVEI2BFu29fO/ids3F9fD5XTxFCAMmWG
	hOkX6dP0LivatpY2NMXLe/IJWCk4vWPD82GDF/0shuU9Ti75gHSqZqhXi/PjqLtj
	bRzGDzrJ5QcNSG1uT9NSnZZYACInnDGrBUUGiJ2dtgQWkzDJFAX1Zhtt7qv+1zLZ
	ROmftR6O6ktXLl1AwKDY5EYTwaeYnGx9UP8kM9NA0Ixy36BndWJZ8G81cJZv7UMP
	mmFMGz6aO+QrpZ5vvedopPkWS+E7JSo0mY+fcVujUVZjRRESdjesffOmS/hO8wGy
	Zm+aRx6XpYhR1gCocYAgmg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu4stsb01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 21:36:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62BJjS0B007955;
	Wed, 11 Mar 2026 21:36:15 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4crafc3hna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 21:36:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/DFv3s9AvueBeDwxOAgmJhcsyQaiEzzgjdoxqWZFivUiUz+7SSVjXcFOpt4TSl51y625rnLzVyHeh+3j+M3fijc34BWKHmJv++nC7qUl6gV0IYCUpfz5R8BiqX0XGKwpj/8rad0bzL7hLvO/INsMMuZutxkEckYPR2BH4rJTiQITg8O6Spjo7MypftFgU4oM/l/Y4ELbEEGuj4atB8nGXEu6lLt4rTkh+QAHFGGKyrxgP6LrQbBudqqAhJfP2+6Rn3qsG9TChFFsQd/Ep766jX9efpPEe74nOjNBaepCgn2hj2HRYvfdrcmArLyD/nsxAG0ehlPVJSQo/nhyDWnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEcYatUnp96/855bcYnlXUA5ppoc7PZGi7eI0kyxQos=;
 b=LdQYS5vfzmqX5S4TBSfJ9l6vGKgmVUTxrI3y2F8kZ0BgiGBQiTTPaKvOtGSBn62ERkwY0mr+0HafguLy3UGs0cz0HxcrHkHThTfxRf53UKEMC6nP+VRe/41CCxDQ2VSETw/+JgyWfXXRGSF7An8CajEl4V7znxCHfGnVKqzTVpHFxnZxVIWq81MAhITdT5fvvAdOND64tJ++zwPtjhL7HkeYu0ptJOYSg7fCNrA2AiFmCPnpcBXj6aSvAPF6JRwNKARxXG8dA/0K0+9Bco++xpSYgOzk1jLEIaMQtGF0x4Q3DNMIsrSNjg8vpclUXyVfYGqvMk64qW1lTvdiw4LUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEcYatUnp96/855bcYnlXUA5ppoc7PZGi7eI0kyxQos=;
 b=piYwxxBzeDdV65PR7uonPUJelnyV6AcPFlS6aCjQ8TfIOBinfSlqncD86w6I+iq783sHQFLGl4n/iYAKXzLt0XXi20SEc4NrS0voX7mgRwxidCeaBX9iSD5iXow4dlt4Ox6yKne2T5DIw+Rfcu8rhi61FmZ9LM2xX8Qs3gdRh00=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SJ5PPF07759F8B1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::787) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Wed, 11 Mar
 2026 21:36:12 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 21:36:12 +0000
Message-ID: <780e05c1-f790-41e5-a0e5-cf7484e31a92@oracle.com>
Date: Wed, 11 Mar 2026 21:36:09 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: pynfs tests for set-acl-on-file/dir/dev creation time? Re: [PATCH
 v1] NFSD: NFSv4 file creation neglects setting ACL
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>,
        Chuck Lever <cel@kernel.org>
References: <20251119005119.5147-1-cel@kernel.org>
 <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
 <aSMsb350kJgqysbz@morisot.1015granger.net>
 <CA+1jF5rKuZhjj3POSrgFO8=uNS06gB2y5X+jmDhApDdXW_eLsQ@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <CA+1jF5rKuZhjj3POSrgFO8=uNS06gB2y5X+jmDhApDdXW_eLsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::23) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SJ5PPF07759F8B1:EE_
X-MS-Office365-Filtering-Correlation-Id: 08af0de0-4f56-4ce0-b10a-08de7fb63733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UGvLVxWjU4fxiWI0OIwFKd4tHjh0E7UFjHcMwpu1tDIAxXVL4JJGscatYB7zLDjDAfJ6vS69FpDa8vgUv+wMroaO/flI4a15juAMMEzgYbyk3NfOmGjhu0Lsj9J0c6e1TTpC06TzOzHWfwxwbBaDPpNYkyRFM+YT/ypDs0F2yrtdPGBrhCHHPNX7JOG1S1T+DwzMBz9iBirIjFywg/OQERtMqfFhiZ11g6roC0L4Tn2VaKuQxWbMOBRHwbsYO3cci3c4NgfOZvpxAT9YMEMDUPJOI9K1f67kUx6lOljtPcIvcK0c99TUzsoMLm5N8ThnFvwCzRVucsiX3F586Azt/USIodURTLvnU4tnuTn11yy4yLfKDSu5FVd1ryaftENWMPayXYZDUJYifUY+xjb+/KFNmKYqcM6731w+iss7tcI13+NeXb0qz31clLq+jx1G0lNxcyoyspQwhXrXZJyG5gnAzWBoqnR4VzsCu0N3feUNY1n4i7WWHzBNxF5icYsLD6NkLvVgxPanxc4Pk33RLK9vMhlUe92oxYcaxzCItjFqBcdcrza+wGELjPygf7avhPZvnxpbsQ8k2fn6XevxRtxg5RYlUomvDdKJ/T7tB+ji62WBPy24noOErYMMXgbL3QtKRhdh1vt77DFOnPfAuWmSAt+NnaCDbL5hTrRARebM9bFQp0/yJCBBSjRHdZnL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxwUHcwTTNVYXJpdVJ4M0N1ZUswYVJFTlc0a0xFbFZCV1h4eklOMnNqWlNJ?=
 =?utf-8?B?RTVXYVpndGYzRDFHeks3eEpQcHNWRXNQQXZLMDhuaUR3cHh5MEo3djhCUHRH?=
 =?utf-8?B?NmpneFdWWEhRWVo5cUFOQzl3UUxUZmw4RlU1WVZBQTlON0IxejFVMnhGOGN6?=
 =?utf-8?B?aGNJblBMbTNONGhidG8xNmJJd2JhL1VZWnIyYUNQaEY3dUEzVU12TDl0YjdB?=
 =?utf-8?B?cWpodnJQRitvSFkvVnkxSTl5RG1oSTdEYUZiSkhQY3MwTHdlUFBLTEowR3B3?=
 =?utf-8?B?THpIUkgrR0dVSDdrQmh1OGZ5YnRzdW9qZTVhaUxJT1h1M1hRaXQzL3pEM1V6?=
 =?utf-8?B?M1JUV0RpK1lHTmpEOXB4aGVEWnhWVE5tVGt3MjVhV3Rxa3RBdVc1dGRaemxT?=
 =?utf-8?B?bWR6WDVKQm5FaktYWGJMYzc4Qm9DUUFrNXdZcXJibFB3dmxucUsxVkZkYmpN?=
 =?utf-8?B?U0Y0V2xBYUtDRFQ1cnhjRGd3clJFT29nMGk3M2V6UUJRUDhacXN2RW9BdnQx?=
 =?utf-8?B?WDlmUkVBTWVmUzA4cmFOZDJRMlVaUk5SS2JBOEIzemduYTlMWTM0VWRZdS9x?=
 =?utf-8?B?M2cyV1RHejBWa3lpclc3MjRNZlU4OTZ5RmJvZGI3YXEveFFyL1JGQ1luSGFO?=
 =?utf-8?B?aklTOGJLbXFsYzI1MFllYkdlaWNpTHBhUHJuTzA3Nk0zU1dtRElocG1vUksy?=
 =?utf-8?B?T0JIcmxINGdEaFN0bjJLZ3pyVWdjQjErVERQV3lkdlhPV3g5RkE0cjdvUXc3?=
 =?utf-8?B?QW5Jb3FZWGtyYmpsZGtVUC9kbWhzbHdNZjZKYUZNOUxvemJKbHI3UkxoODFK?=
 =?utf-8?B?T2liaTJ5TWdSSWx1cTFIeWx0WDNXNDJvSFlzMUQ5ZUtHUVdwT1ZCendKdXJh?=
 =?utf-8?B?VEV1YzV0cktsenNrR0RvdFU4dGlwUDRTbkRvNTI0c0svRUpSakVXUzFacDUx?=
 =?utf-8?B?cmdzaEJpWGIyTkFYTEZ0Ym9BSWNoNUJ5L3VOYXU5MjMwVWNhajBvNE5DNU1u?=
 =?utf-8?B?eWRneDN4ZFBRbjl2UmNOOHc4b2ZUYkt2UHk5VituRzROSGhiZjNlRWp4Qzcx?=
 =?utf-8?B?UXpWc3JtUjBGdURrdE1HWC94ODg0WW9rVnl3azZKT3FuV2taWUhObC9ldU5i?=
 =?utf-8?B?ak5yQXYzWXpzM3dNWG1RL1lwT1Y0NWRzTXNDd2h3OXRjNzMwYXY0VUlDN2lx?=
 =?utf-8?B?c0s1WDhndlZUR1BPOFB4OVFueDlzcUwzZ0NHSlRxOEFVSzZnMjQ4Mm9USGNG?=
 =?utf-8?B?djJQQUJlM0tIaWc1K3FLOHNCNmZFNEt3SzFlN1JJY0ZNREZMSDBMQ2FOSW0v?=
 =?utf-8?B?SDlNcU5McGNXUG94MkVlZ1psd0JzS0ZjeGZwWnhmOW1aaS9UQWdra2ViSWh4?=
 =?utf-8?B?OTBVeXBRSnBVN2JvVTBsYlFRVE9sMmpjRktoTGVKUGNkdlcwdHpiL3hHYjFN?=
 =?utf-8?B?WFZWdEF1UDd5bjdIWlhJZEdETkk2VWZENlM1b1UvTTBUelFLZTFZMDczbVlH?=
 =?utf-8?B?YlhvUktQdFJjY2NPNXpwV3dRNXFjOG0zc3FoTm11SUM4OUZ3Vm5EYXVaY1ht?=
 =?utf-8?B?NVRLOWgvc1hEaVZBRXB2ZXhyMWtWdG5PNlk2WkkyeTJkRjZhbExHWm1ya3kw?=
 =?utf-8?B?bEZIQ1Z4Q3BQWXJvOHFyVnlPaU1Hek44MnhOUkhsRXBtVVA4alpKVUtmUVdK?=
 =?utf-8?B?ci95ei8xK2tTR2t2ejVYck05YkdSM3pkV3FFaTZtNHgwZENlWFVEdWo3NFY3?=
 =?utf-8?B?ZUR1ZzA4Q3B1SDJ0bWtSUVhaSEZicG9nWkoxaWR0SnhQWHRRS0JEYng3T2s3?=
 =?utf-8?B?enFqRytaUVVzQ3RzcXo3bWNRZ1pjQ2g0dW9lcGFXditzbmxxTlJuREZrelpq?=
 =?utf-8?B?U3JOaGtFUkU3ZXJVdkdJSVRoTDA2YlJpNW10cDBIYlZjc0J2MDZZcUY0M3gx?=
 =?utf-8?B?d0twZnplRGVnd253a0JOdlFzMStkR2hSZ1czWk5WVVhTRHp3WWk5ekJURDVa?=
 =?utf-8?B?TzFuNVB4UE55OHJRUGlQVFZ0WFJiTmx2YkpEOXdhM2hob0NjTTZpQUs0STZP?=
 =?utf-8?B?VGZLWDRRNkxlcHNSM0s0UFA4MUZaUGV6Rk1pWDU5S0djZGlWblpqcGJIc29W?=
 =?utf-8?B?NG5OeUNYZmNTOGUzeURGNXRKTzVwcnFZdUVOWHE2UjY1OTVyN1hjemlJbWJE?=
 =?utf-8?B?UlFEYjlwa0h6TmxCWGJPaUNLb1NOWm1aWXA2SUg4VFBkUTRnVGsxc0oyK1kz?=
 =?utf-8?B?VDgxWU1zMFhwR00vd1l3c1pVdXhWay9uUmtBNGgwSFNMYVl4NjBYZXk1aGwz?=
 =?utf-8?B?WkxHcFZGTW9kKzQvNHlqRmlqMDdIa1BtTFkzbnVpK0VPYTJVZkZoZz09?=
X-Exchange-RoutingPolicyChecked:
	Zdszti21jWf2PHuXMMnzArVbCUUMky7nzIJyqBrmnyoaFQJKyXiWYfyxSuUoGN8r4BymHaZOs/5Dnm5aKl0J/IPfOH8HXq+E2mCBp7g1xQ9UGS0VeIvjglR8Fx5o8A4IIrdOnBg+yLcGTTJ7+iNAHh6gdkI0JdyOHjzPcvOmlnl6VCX8wAck1KSDJyPG0kIzTCF7z/pr5EsYk0IixCSoTpvtAoDb8gpmXi2fqbic6303AzV8Z534LIoZ3byzvMjO0o714lA7719l6lwBNgSegj2/Mus8gLUnXGlrReAz8po7tjTLd6Awq4A3XMCCcM/mE9/k+0uD+DjQBYwczF8ZSQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ah938Gl0xU5mdVK8z+RUXUXYbMonbAe19VsUTD6KtxgczTGidBryndxRsQBi+lmnNZQPfzj7dEbwOY+JGIpg+zdWbHd9mzIU1zmTQOyCYtMU7mAjybbSb16SnDdtvTixnIoyxP1OA0yiCMtzpiDSgFIPG+JfpxjwVSq8emjnErkFKxWy4DijJ6qSQJ8JZ7ibfxNb7vYYdBfn42j9GqLEaQnYcwsmsvs58xauLvgbk8aNk0kFc6UuibcqiLUcWhIc1ishg8Zwre6h4szc3OulzPUSA+5WoSfQIRA/Qdhp8U+PEDqOmllUR9sIsvavP75pet5yxPKySeWMIGdvOrJ236GP3ZMAHLmdvbHli2gIO7XGxGr0THly7By2ehCnUvBzSxPaF+oHWNjGkcA/lr5Z5VRfg8NmIl71U6iZP2k1zm84NDy1rDy9THoYWWdtiKa58hhxvr/EFQMwR1GtnB2LbZycMPiILARZfX4f9E1AupxLtVUhTye42UzxJL3I2RSLLzJhXDVyqpbpb+XxwH104nBo6p2MUYcTHUBzTwctyJSii92tD+hN/YE2A1nmmPU1UeK6qIJV4lYOQNO7jpq0b3/989hPGEHmQ7lGZUpXyMA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08af0de0-4f56-4ce0-b10a-08de7fb63733
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 21:36:12.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2mzywox6bM4myu/Xt7mIkxpgGu2CJups2xr73TTg6b7ovK8GNoQlh+gAM2mRxIZNa/ftACdt7u8MTm3huTbBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF07759F8B1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=983
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110183
X-Authority-Analysis: v=2.4 cv=Fv8IPmrq c=1 sm=1 tr=0 ts=69b1e04f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=P6JkxrBpAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=iT4ZeSVlAAAA:8
 a=SecHs0ATYQCUYRD9DQgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EBa_rOYxF3VBboPlVeQ_:22 a=dwOG0T2NmQ8MtARghG3a:22 a=B1tqfP-ccRqU1F-Hp2K2:22
X-Proofpoint-GUID: Ux5nWFwa0h6ADkKSHs-UvCTsCgPHwPjw
X-Proofpoint-ORIG-GUID: Ux5nWFwa0h6ADkKSHs-UvCTsCgPHwPjw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE4MyBTYWx0ZWRfXwlBHbEdU5Vus
 TnuT+RJhqQURgwF/DBXjAR7MuKaXohM4BK0gv6yB6uAt3IVQZRO9QG+LLvFk/5AnlvC7y+dh+Id
 5YBD7o2SwVjRuS04X6GyZfM6ypEGtoqGw2QD6FSI8svfmS5b7kaZUKA19XQ1PiCDHLt9b8i1eYM
 A2I1ypQGYWYQaibf4I0dMSQbdJU2UrUvRDi2tJ9/autG+pnyVMrVwLTD/FZLkdo5aDUjoD1dz4u
 A5kZsvp3ivoN4dtY6GimFz3Lnb1ZTIPJ61ENGEfeAtPbirFlZ+5yejg9m7Cz/LLfrw7EEfcSJX3
 GiKDxAx456ZGDjPti6HJpxFjVMth0U2paKG+JKy22z8YjHYi5RRmB5yOBMlVGCQaDpB90KIevvY
 ycdbfvdFm85Wo+jkAEv3LgMB1rlxwDomwZstYUIJwO8Xr9rQtAWc/pMjdUT5EZYgLogfKuQLcLC
 omy0Z1L2JkK8nYW+Big==
X-Spamd-Result: default: False [1.35 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-20049-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid,linux-nfs.org:url];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: AD7A326A7A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apologies; I have a number of patches queued up that I need to push out. 
Will do that asap.

best wishes,
calum.

On 01/03/2026 12:29 pm, Aurélien Couderc wrote:
> On Sun, Nov 23, 2025 at 4:46 PM Chuck Lever <cel@kernel.org> wrote:
>>
>> On Sun, Nov 23, 2025 at 03:54:48PM +0100, Aurélien Couderc wrote:
>>> On Wed, Nov 19, 2025 at 1:51 AM Chuck Lever <cel@kernel.org> wrote:
>>>>
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> An NFSv4 client that sets an ACL with a named principal during file
>>>> creation retrieves the ACL afterwards, and finds that it is only a
>>>> default ACL (based on the mode bits) and not the ACL that was
>>>> requested during file creation. This violates RFC 8881 section
>>>> 6.4.1.3: "the ACL attribute is set as given".
>>>>
>>>> The issue occurs in nfsd_create_setattr(), which calls
>>>> nfsd_attrs_valid() to determine whether to call nfsd_setattr().
>>>> However, nfsd_attrs_valid() checks only for iattr changes and
>>>> security labels, but not POSIX ACLs. When only an ACL is present,
>>>> the function returns false, nfsd_setattr() is skipped, and the
>>>> POSIX ACL is never applied to the inode.
>>>>
>>>> Subsequently, when the client retrieves the ACL, the server finds
>>>> no POSIX ACL on the inode and returns one generated from the file's
>>>> mode bits rather than returning the originally-specified ACL.
>>>>
>>>> Reported-by: Aurélien Couderc <aurelien.couderc2002@gmail.com>
>>>> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
>>>> Cc: Roland Mainz <roland.mainz@nrubsig.org>
>>>> X-Cc: stable@vger.kernel.org
>>>> Signed-off-by: Chuck Lever <cel@kernel.org>
>>>
>>> As said the patch works, but are there any tests in the Linux NFS
>>> testsuite which cover ACLs with multiple users and groups, at OPEN and
>>> SETATTR time?
>>
>> I developed several new pynfs [1] tests while troubleshooting this
>> issue. I'll post them soon.
>>
>> --
>> Chuck Lever
>>
>> [1] git://git.linux-nfs.org/projects/cdmackay/pynfs.git
> 
> https://git.linux-nfs.org/?p=cdmackay/pynfs.git;a=summary was not
> updated since 10 months. Are the patches stuck, or something else
> happened
> 
> Aurélien



