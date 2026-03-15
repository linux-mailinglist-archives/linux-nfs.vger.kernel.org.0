Return-Path: <linux-nfs+bounces-20179-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AhmKr3ptmlRKQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20179-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 18:17:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB93291AD3
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAFA93007B98
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F28974BE1;
	Sun, 15 Mar 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VSUv/u2y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nHRdpSL4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6741D6195
	for <linux-nfs@vger.kernel.org>; Sun, 15 Mar 2026 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595067; cv=fail; b=LaOdEDJlnqDagIIgKNcjCy/OZ6ez7ZZo8vVhhXbk1HlZ5j0f5IOM4wGkdyWfR1ZzevXXC//5hnEWIXIGH5AEn+KW01pScLfmZSUHzDR9sLhZyWDRjtwOAf0WWhvgljOX0kNx2dQTtQNnNPBV+gbbwSXB0d4uoBI7uZfN5P5/AHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595067; c=relaxed/simple;
	bh=Mxx7CSFqVbVgA4vnAyKoqjLrff6EqJhAgA1j4g6w0cs=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GR8+3AApE14MIKl2a1wqOnhCyfXl0/V3i4vF5CB/4Jm/QBZbVREdf9Qx62Zq3i6l+R7sIDSL4ht74e1sWAbUrSwtidthsCpNhHAlZwqo0MUbIPQfFoNgLT9jD9HHu6UaiZW4ykWndGmTefQkykVLutX2wVVpAoln4N07UgDCnMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VSUv/u2y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nHRdpSL4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FGn6nl211130;
	Sun, 15 Mar 2026 17:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Mxx7CSFqVbVgA4vnAyKoqjLrff6EqJhAgA1j4g6w0cs=; b=
	VSUv/u2yx/f68DYnHN2zq7m5wXk1uVAFS1AD6qYhghHC+QT9TQmWBgF4Uc555q/0
	N+tyWJXsDy1/Y/nLnt4ZTCNTdAVshrB57KaRVWcG7sD8sMwhygyWm90rT5e4Hsu7
	tuQOVfnn+hsDH1wbWnMpkHPQMYhxce8JpWzS3QuIbxqIC8PFyjOMejLOHamXCni1
	H3vd1Ikcq52CyfzaBWpuQzdFMGhThcFqFCCzIMMSn1ecmZWjn0Vg55mQ504czH4N
	0tGHip9THhV1C13/7WKi02z0pugU4or4TPyaWtEVY7LaxMpwJ/ftC09EOyLoXG5B
	UNYNfOaHK2LBSBqIObS2cQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk893wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Mar 2026 17:17:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FFLhZm031370;
	Sun, 15 Mar 2026 17:17:40 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx47sf17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Mar 2026 17:17:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kfzt5w+B8btB6fJkhcBw/xni3S2sdT9LYOzMS1TF5e8VACWXiVqX66ZOeF0KBdrer2Czw7EcTFnlBh+nnMNQ/vr+r4g6BuWpboVIA2NXHRaUofoMHiLun5IKQHbyRg22yQHelDJ8hcxZ7ZJ8gyi+FatDH4T8TeObqLyHJBVrLtoky5RD3Ex/GJZ4Yw3v6fU0mdP0wtmAthhj6RozsBXnjxlFQN0OCtUha0KGzQ3DwIDgTjvTFw2RyII415OuEyrsv3ONtLwMNHi3O9tnLVrVhFZwToJFUzL6j+zLgKtI+zZdlfRlKMCRq9CWLoLfaetfGQ0u3OL0tufbMdnCVTNlJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxx7CSFqVbVgA4vnAyKoqjLrff6EqJhAgA1j4g6w0cs=;
 b=aO4sBGFu6IFECF3O87aXL4P8i/4Xn5W7E+UhnIKnqyz9ZuOPauuCdjvmrlGZEP4oFNcdqxaewE0d+BU6vqtnZHVBFFY4yuLDa/lRWPC1ng4V0IbCOLgrvnBbs0jBud/FKOxvHf4V5eBC/9nBFsY2UCkVqsvrYpjbeKhT5HZbqq0bwJZfLRZNiBxK4aOuwl4x9iQB2cSq6/faf4qI9vuPglE81y36CSJH+uSVCF5/VYy2xrbE5Rzfkn5QLMCQNCK7ogqXw6VgS7/MQkb02YRkyBYj6B0QQn7dtBn6CHoNjnstatmcdIkHtCgdK2Wy+c78t52lHzA7LN99/jZZPOIP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxx7CSFqVbVgA4vnAyKoqjLrff6EqJhAgA1j4g6w0cs=;
 b=nHRdpSL4QFuhyalHf7ow3hBs1hvu4IBmI0Vc6L4oLRra+wVVFOdtUYT0vTBt4hqWeMjsYusgTet0CUy/d9xh8WwVSgbzJCcTrFEsU3+U0RsUcC/f7H5bs1BeaYvOos30YheS2PqeccGzw6EMQtXqi8Y7TcucbbQi1an+pamprrc=
Received: from DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18)
 by DS5PR10MB997752.namprd10.prod.outlook.com (2603:10b6:8:340::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Sun, 15 Mar
 2026 17:17:38 +0000
Received: from DS7PR10MB5151.namprd10.prod.outlook.com
 ([fe80::4ae:1ca9:6ccd:7525]) by DS7PR10MB5151.namprd10.prod.outlook.com
 ([fe80::4ae:1ca9:6ccd:7525%4]) with mapi id 15.20.9700.022; Sun, 15 Mar 2026
 17:17:38 +0000
Message-ID: <78d6db00-929a-4431-8474-a9858dff074f@oracle.com>
Date: Sun, 15 Mar 2026 17:17:35 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: pynfs tests for set-acl-on-file/dir/dev creation time? Re: [PATCH
 v1] NFSD: NFSv4 file creation neglects setting ACL
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20251119005119.5147-1-cel@kernel.org>
 <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
 <aSMsb350kJgqysbz@morisot.1015granger.net>
 <CA+1jF5rKuZhjj3POSrgFO8=uNS06gB2y5X+jmDhApDdXW_eLsQ@mail.gmail.com>
 <780e05c1-f790-41e5-a0e5-cf7484e31a92@oracle.com>
 <CA+1jF5rBpt60L3=j=t_msPj_4wMcUXxZW6X0k3sTKQ3mnMb3YQ@mail.gmail.com>
 <ca5ee0dc-9f44-49d9-a55f-d980ba57da68@oracle.com>
 <CA+1jF5o85HKW=7BbZcukedLbA67meyWj6jMrZaOe+sczqg8t0Q@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <CA+1jF5o85HKW=7BbZcukedLbA67meyWj6jMrZaOe+sczqg8t0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: LNXP265CA0094.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::34) To DS7PR10MB5151.namprd10.prod.outlook.com
 (2603:10b6:5:3a4::18)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5151:EE_|DS5PR10MB997752:EE_
X-MS-Office365-Filtering-Correlation-Id: a8441c9b-e3b8-4084-945e-08de82b6c1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DwrqkgvZYsPOg5tOZyr208g1wvvwes489nnlBDJnRZUUTeS/YIS8JQA2WIxDItAO7Ki5kLH5wvDxJsLorogtQsSGl8rJhvYmq0rWMDSR+kN5OyZ9PYUIiWZFypZVjd7N17dBudvkgLjD8r9ihv5OoBC5LEu+EFjIV7WRk8QDDAyUsJGWuK3AUvda7/ENyam2tUnoS/gaJUwjz+WDo2L/eDKBmCBfTveCZCDe+2E+TgD6EPCtKMXnI8Gndi7m3VYYgFmosmY6X187d/ZqaOFBLuZ3Dt7UxlgqUU8b+jZ2XDikrIb0aCXOUg1UncqEV6dGTMVcP3IUnmEF4O+XV1aFllwIzZDTw2EhrvWjO+OQ/jW8KM6KUC/abEgAXZ4tE8YAjbBvanF9SysBvQ0mxzcUdHmSYEot2WjLZTm18aXyA/L2caccKzlFmRccEv2Re3YK8q4wkpXoGYBqycCPuElTfBEjEI0bmGcbFHpqqLYepC2OpvuS/NgN9Opq0nMoBi/m77+mXpURHnz4RK8jvXVACrHw+qbZI2p2f8LR9pNeaTpehmIMAsgLuUUshEtwd5/W/P+bcuFvIUHHKxL6ONEwuWmsTuk9p9QGDdyRrsSbOpP+/zALylYhvXgjKwsLTFGHmtriUL0dyjHFYMIH62Wc7Ti4Kecf4Bwt/F8vNLo2PJ5iJyMdic1SjnaGYcYr8nWv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5151.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YStFSjlWSUlPWVZFN09Md1QzaE9CWUl1QVR2SXF3Z0N0TFdob1pLUS9YYjhv?=
 =?utf-8?B?eGd5MmdjOUhkeEJpVDZXc1JIOFk0S0M2Y0c0Q0pYUnB6Z1hTVHFLRSs5SnF1?=
 =?utf-8?B?V09FenJPVlFleU4zMEJFYlhDcHordFlXanhpSDAyaTdSS0FVano5RU5iSU5r?=
 =?utf-8?B?ZGVXZDlycERqdVc5UDY1dTBvRkUyM0FPak5FK3ppMXZ1VjhCVDZ5dUJzMHFB?=
 =?utf-8?B?NFdhOGV0WWRWWHd4SEV5QlJSQVFDcW9UY0ZUSnlDNGZQVEYwblN3NW11dWxu?=
 =?utf-8?B?R0ZBZ2dIbEQwQ2RrWDIyYW1LRUJ6ZmZNUGNNTGM4UDNmUllMMnZFYWoyVG15?=
 =?utf-8?B?REtEMzlxUWZwUzhxV0V0NkhwY2ZHZWdWYms0SGc3MkZ4b1hJeHVvb1dQWnRq?=
 =?utf-8?B?cEx0NXVHZExUNFYvdVpJeHlnTzBnM1k5YzJJR1BxQmthd0ZVaXFtenh5RUQ4?=
 =?utf-8?B?MDRNUFNiVVZ5N0JQS25kQjdlOG95UVdMQjJib0pLUHJnZGsxc3piSVdrNnYr?=
 =?utf-8?B?ZG5WNVNqaXRScGs1K0UwbUJMOE00WDUzQU41b3czak5zUzFMMjhLYjRVeE82?=
 =?utf-8?B?NWNoN0RDemdZVDRYK0ZZTmphQ0p2MDdjaHpxc3lwbGNnY1BLWFEwbkNFNlBn?=
 =?utf-8?B?NVdVMjRDeW80b1c4bTJ3SFV1SGtyK1ZhbU9iMCs3NnVNbHpHZkJiZGQvRUtX?=
 =?utf-8?B?ZEd5eVprWmdXWHNBVFBIUHZuSEVLWExMQjhxSTJNUGI2ZXM3OHAzbFZrbU8y?=
 =?utf-8?B?MlpqTjB2enpCbVBvVjh4V2szSXdqaXpITzJ5d0xmdUwvMmUvNUg5RDJKcWY5?=
 =?utf-8?B?VERteFpXQ0RrZDJuVGJIUnozVTdjOW5VTTNpVXFTUkxiazMzM1VQcngvSGVt?=
 =?utf-8?B?ZzFnc1JTTDNpZktmUXhhTmtqdklzOEh4aSt0dERFYUw1dFB1MVNLcjBZbk50?=
 =?utf-8?B?QUJ6Z1Vma09jOE4xekVXRDZ4RHN4WkZ1NWhZRllON1k5T2JrUnZBNU5qUUN3?=
 =?utf-8?B?ZVExZGdSRzc0MXNtck5HOUo2dmhLdGpSdCt0UEs4T09SMjJmUCtPS3M4amRQ?=
 =?utf-8?B?MUZsZysvYzY1Rlk0TzloeFI4MmxWMktVMkJnU1E1OEsrYTN5MGxsNTBuYWZh?=
 =?utf-8?B?eXhtMi9qOXJMVktJUEUwS2p4cVdjWm5Da3BWZXhpaFp4UXljbkUzMGJ5dk5G?=
 =?utf-8?B?WTZEaXFmQitOM29UcVd6VUF3WXdnaXpOSkNDTWdVeWx2Wlo5R05FWExzUVYz?=
 =?utf-8?B?dmU1NmZ0SEVXYjN4aVB2TzZlNk94c1JuU1ZvS2ZCMHY4Q0NuaHR5Sjd5d1Yr?=
 =?utf-8?B?WUkrZWJIcVREdlI5Z2RUVEdxblJnQk1obm9SNnFEajBqZ3cxdWFVQTJ2bkhz?=
 =?utf-8?B?MjNaZ3hobjMvRTJnZG1EeWptM2V3TWVkZGlDc3ZmdGpTZU00ZWJzZUtEbHZU?=
 =?utf-8?B?MFRJdDNNektKUTBOaWo1WHphVlNoRXFUTmUzMk5jNlVIcXNRQkhSMGh6WTNQ?=
 =?utf-8?B?ampnT1hOVytxSlI0WjhqV2Zzb1JKUkY5UDQ0bXhDb3F5dEtOY2RmdURUL3lm?=
 =?utf-8?B?cjhjN1VYeVVzNzVKSVhWNFVkRGZoQlVGVEk4ZGgvRUlmQi9DdEVmMHNCRWMy?=
 =?utf-8?B?RjdjeDFCc21hTUkxRTBCMjZuVTRFajhsSWU1b2NsZVRJdklKOXRHSFNEckJC?=
 =?utf-8?B?eHVyallibFBNTjR5Rjg2bnhwSk44eVJiU3BuVXR5QjYwUEdCMEkydG9uRVBO?=
 =?utf-8?B?TURGL29XWittSFBZR3U1cFJmRFhJbHRBakVCVnBCRHYrcjVlMEJvL3dkYlFS?=
 =?utf-8?B?a0dIYUxRVHF2a0VDcVY4SUFkVzdtV2lmMEFseVZzU1VBdWVlR0VSd1FQdWRV?=
 =?utf-8?B?MkJJME1FT1ZGVzkybW5LRWFTOTQ1emRhaHoyREk1N2YrZTJ6Z3N1SGJyb29w?=
 =?utf-8?B?VWxhTm5rOCtKRFdxemlsS2hRaTEyWUtXb21rMURoNjcxS0hxUjBCTjljQXNX?=
 =?utf-8?B?S0R2ZUlSWitGcGFIeVdYaldVZkhOUlBNK2R6VmJ6RHl0NVdPUVB1MDA1cDBj?=
 =?utf-8?B?Wll3MitEVlVqeHQ5cWhlTWtBUGJHNmU3N1oveGMrYWtaOFM1ZWdJNC9xckZW?=
 =?utf-8?B?MWVKZHYyNkUzK0wxOEt1YzRsRDdLbjZaVWZnZWxUWXl1aGprMkZZdUhoLzdw?=
 =?utf-8?B?Zjd5WnhuNkNPZWRQRDV1cmlhT3MvYVA0L05KZnkxd3A1aTFJWVVvUHZaMFAw?=
 =?utf-8?B?VkI2YUNSSVNwZmVDL05lQlVLZVJObEtmUURKSHp5cUp0bW84czU4bmI2SUxr?=
 =?utf-8?B?VVc5WjhPVUpvOE1XUVFxZ0xQYWVnNmFnMUxnM3RLRnJzNmNTZFZQQT09?=
X-Exchange-RoutingPolicyChecked:
	I4PhQJ3VqWcLZJQf/32BOkKKs9Gqr0T5HhEmvMuAlpnursoRr3KoDUgxzL9y/vDmMK1Zl/uvo+v+itBxZrzs6b7AcARvW9DoHe0UdsNHS9bD27uxQmu/ONxYb+8Zm6BDK03phfw7E3CyS4KTGR9mt4JDKcmc+q3gcNnHDM78ShYMITInbe5gdrNfJsY/tuPrTdcPvIgzmX4f9H5fbzcp9XWVwjfSmuZzTV5565UhIVbGYRasBlgkibKaAj5Q4Q5iu81zO8ekKNHbuufx29GZ1BalCUjViF9/w+bA4/HhCyG0XPD11t0E/QjqtJ+neaOcoB+gMkPN4G3L43mZ7hrqPw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iH4qk+L0kBqmvJCgFAdz67MsMkQGL4LW0qhEo+2zC/tWHLxUguGcXl88pBC29HtLc3hhJYxmr1qc8pymaoWs4VhnXKSDhIblfxf059w0MdDiGzixfIfeLPjq/ZFnmIj+kc/lW2rvhnOJd/OCou/uu4h9QfpfFuKulM1anfsAfnG05bfAy5+QaxeFdixiqxcX9AI4tpdx4OGeisnucSufN39b7UtxE+/YIOn0Y9xa0NDX924ddsTF8ZBLvm8jWnI+CjbZnD51IPpziKzWhvYB3fWOOKDD8pZ9abRbhqwMujp0aqRiiohJuzoAM3qSkz87ScU9PfzUrv0p6MTyiqDRsIjxbZhbRjrxSKSwSB+cBUrMfT8dETG5GDVlS0eZU6VvK5SL2Pmkelm1QsfQoKIdZwUK0xfmkOKsLBxr5pkaIskFQMPF8qzFE1OAA4yzqgXo0YyNBt9TiPsqIoODUFpWeKN+C0IrJavcILZ3haSmWFAHheI2mLchd9QGHwAXqk2ZxJf4zq+uyH3Y25sJPl8ZdkbZ2+7MNtjSyA7pgqOhPATR1c3+UFNOS6Px7GIryf7sI1QNgSiuiqGcJvB0Vkiw6jjsR7chgVbGMUvpa91kTqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8441c9b-e3b8-4084-945e-08de82b6c1d3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5151.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 17:17:38.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhsStg48J6NwctwXsS0kTReU28gqqN8juei9mmTcfh04zgv9oZzYKpahaXBSXx18vu3Lg/zKsgWBiHz6XXudgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603150136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDEzNiBTYWx0ZWRfX4goIHQkzHkd6
 ij59/L2LJuNtekWuh6T/PEEutJOMv9/0AMRG+fsmo54kf0XU9fbV5hkMCWExb49ajWvIOVtbVTB
 IEvpkEF4d782H+2JzRDMMoKtZNIZqSt6DmG5Wtr24Q/siI3UiRtx2lz+bzTHQBv3ZlPA/DfotvP
 t5JRJ065a30e1yzggMu1u+0kAhDWx015WE9/2+WHn/e3JzEMTYUqrJgmAPQyTLGSN4GRRjbF8qm
 7Y67/FKlCn9QPzPFiztKSufs7Fl2HkvxC0b95V0VQ+JtWoJ4OS7r+/BlNIaWcKXkq8BNx6gtFNX
 zfSmRosGzfUVL8LbuT/IVJI8a5YnLOtWLENGBR/SFDKFHyThj9N/WkVyUiHtYzq1HLkKOg8cqXr
 xPDo6s2AEyPNezEEauxehxcQLJ4PTR5EAvOE1ER9zK8sHdV9IWD2rOdcXGXY88rxhe6Y5UHYpiH
 U04PoZBOwH9opoL3r7Q==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69b6e9b5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=P6JkxrBpAAAA:8
 a=yPCof4ZbAAAA:8 a=odoDgl3bXc-44a97RawA:9 a=QEXdDO2ut3YA:10
 a=EBa_rOYxF3VBboPlVeQ_:22 a=dwOG0T2NmQ8MtARghG3a:22
X-Proofpoint-GUID: Dqmt69QiQsnkXVWubDIViCUqJo81kOUD
X-Proofpoint-ORIG-GUID: Dqmt69QiQsnkXVWubDIViCUqJo81kOUD
X-Spamd-Result: default: False [-0.05 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-20179-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid,oracle.onmicrosoft.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 4FB93291AD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMTUvMDMvMjAyNiA4OjMzIGFtLCBBdXLDqWxpZW4gQ291ZGVyYyB3cm90ZToNCj4gT24gRnJp
LCBNYXIgMTMsIDIwMjYgYXQgODoyOOKAr1BNIENhbHVtIE1hY2theSA8Y2FsdW0ubWFja2F5QG9y
YWNsZS5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIDEzLzAzLzIwMjYgNzo0OCBhbSwgQXVyw6lsaWVu
IENvdWRlcmMgd3JvdGU6DQo+Pj4gaHR0cHM6Ly9naXQubGludXgtbmZzLm9yZy8/cD1jZG1hY2th
eS9weW5mcy5naXQ7YT1zdW1tYXJ5IGFwcGVhcnMgdG8NCj4+PiBiZSBkb3duIGF0IHRoZSBtb21l
bnQuIENvdWxkIHlvdSBwbGVhc2UgcG9zdCB0aGUgVVJMIG9mIHRoZSBjb21taXRzDQo+Pj4gb25j
ZSB0aGUgc2l0ZSBpcyB1cCBhZ2Fpbj8NCj4+DQo+PiBoaSBBdXLDqWxpZW4sDQo+Pg0KPj4gVGhl
IHNpdGUgc2VlbXMgdG8gYmUgdXAgYXQgdGhlIG1vbWVudCwgYWxiZWl0IHJhdGhlciBzbG93IHRv
IHJlc3BvbmQuDQo+Pg0KPj4gSSBkb24ndCBsb29rIGFmdGVyIHRoZSBzaXRlIGl0c2VsZiwgc28g
SSdtIG5vdCBzdXJlIGlmIHRoZXJlIGFyZSBvbmdvaW5nDQo+PiBpc3N1ZXMuDQo+IA0KPiBJdCB3
b3JrcyBhZ2FpbiBmb3IgbWUsIGJ1dCB0aGVyZSBhcmUgbm8gbmV3IGNoYW5nZXMgZm9yIDIwMjYu
IERpZCB5b3UNCj4gcHVzaCB5b3VyIHBhdGNoZXM/DQpOb3QgeWV0LCBidXQgSSB3aWxsIHNvb24s
IGhvcGVmdWxseSB0aGlzIHdlZWsuDQoNCnRoYW5rcywNCmNhbHVtLg0KDQo=

