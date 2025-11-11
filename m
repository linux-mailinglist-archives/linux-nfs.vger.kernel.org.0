Return-Path: <linux-nfs+bounces-16265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09D5C4E760
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 15:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1524B1891D2C
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDBD2FFFA4;
	Tue, 11 Nov 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AvogiCKW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ilz6TYYx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4481DF258
	for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870881; cv=fail; b=sLK2vHtrnMiJBjrDLu0HtDftr8E71QirYk0X/1Nrbj3/P8GgJfg74ys3U39vRBCVYj/In1ygyX51SRgL+rHKS8TbIr5Vpbk7Qhrq2WgdM1lddhmzjChNb4EVG0M3rbAJmzXpdKHESmJc8kt+56t99LBB4MSOP/C0z7I5LdZrA14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870881; c=relaxed/simple;
	bh=ohADZfMw+LELeNjmW8z2jt12CsPXqJzWe0CKS2Lr6Wk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QE+kybTVsvn6y2oiKDZwkyHVT31jHO9YJV8KCCNGL42t9+LLIn9L1Ozc3TFsTTKSwM58D7kwioAEwSSrBcpo2O4ogfGbK47urS0/yojzSWpKugyR4rT8JkSTKlvDED4xdpyh2ibhn5SKCAXPx2o7AefCF117joUII48JZNdcXHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AvogiCKW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ilz6TYYx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABEGmUK018307;
	Tue, 11 Nov 2025 14:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6pE3iqpaCA69IPeolSuoBKUGJb1yWCW0HXHlebfnCds=; b=
	AvogiCKWlXJPSHdbRxdVMQVURW/q8ihzHU4L+WqAQHmkCzSMypOdrCObHXEPt6L2
	j/uAy4Fi4aPiq7fsQEZrmJITTgTNNDsVBuMg5tzwaQKNWdI+vjrZeI/9CWhx2j1X
	9NFaWbDheHO3CsgUeNT3znvyvru7x1GeQAbsusL+C7xW25Vj8ws3L5moK/cZZGiV
	kVlmze+j2EIMDMeGmUc+sLkITXnKbdTL8V+/Xa4SPX+wpWrID7r3jVeCehHbcCD7
	zp41eVJ9pu0A1ftGKRwb0NjR/wW1ovdtTQehiYX4iQRSf9KMafmwt3KE8czaoyjo
	c5ZbT7kS1f50ABiQagZWlg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac500r79k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 14:20:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABDcUtj000743;
	Tue, 11 Nov 2025 14:20:57 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vadkbcp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 14:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVWD/7EtlEjqFLI1knYpX8mpnJrVs1gQlxiyuOSRMLOrRUl8lQ//NBOBqZksyg0rQcZyhwXIsPzuTTP2uTRKP6C1UWAZz/oVHSJ0gJEIQV91KAEsc+rLAKLP7OiLmtNwl/zLUw+VjlQTSLwSYFWgAJm5UzHfW6QXg0pto9HaWn5YM6nM28qzV9izS+y/aMEjEgd0Vt1+Kh9dvuTEANyiVy8dUT3Y485kUtpE1ewh6ICnSK8JaPBIJ3IU0Uc+6bfmSKgdnq+OBtIlnIes8esUSvmJf1EarE5f3OAQqZayr29/IsvFuH0FIHvalQZV4As0E7XrWAMZKElIXEpwGCm+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pE3iqpaCA69IPeolSuoBKUGJb1yWCW0HXHlebfnCds=;
 b=U1OyBVJzyXERAqTWMn178wgB22+8+909FhRy23sGfob6AU6I9OE/FNy3H0E4A1ub9Ous/p8xRG/K2RXxjvVnTmej7jatqACYhDLrh4xGb1vBMBG4V/3AUZBQmrYmqeEdQ794t/Oujd54t3Z654i5lA1AnTu0R7BZskCwgqotu+kmIpchtzcRLI6BUBQix7T8xniNdJbMxDKLTLJG1Hok11R6EuhWT54nchNF2S16So0oCQzolapcO9LxxSo3jYFpAXzfbforQAAVwacVU9+ljM/QEYKkwS7KRB4oUtAXxpSwOp9nTaLxeikpwf6DlGpjERiqilU+qbDnkmCnHrFIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pE3iqpaCA69IPeolSuoBKUGJb1yWCW0HXHlebfnCds=;
 b=ilz6TYYxYv0Hq5Okdbg2CmLY2ph8O26oaO9QFI3ps1SM2Lc2kTr7o9skCp74kWVyqbGyL5m6VOiWR5I/2xyPYzqbQ5yTClBWnRpGbJA3V60WISJxfuzE++WypHNEjWzdqvi8TxTT70EUhkGU3QS9u5DuGPoY64V1QL8zCpZ1QUk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6713.namprd10.prod.outlook.com (2603:10b6:610:143::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 14:20:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Tue, 11 Nov 2025
 14:20:54 +0000
Message-ID: <e0798cbc-87ce-4ba3-ae9c-d1ff669dcf75@oracle.com>
Date: Tue, 11 Nov 2025 09:20:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <aQ4Sr5M9dk2jGS0D@infradead.org>
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
 <aQ5Q99Kvw0ZE09Th@kernel.org>
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
 <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
 <aQ6kkd74pj2aUd8b@kernel.org>
 <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
 <aRL5EPMD9VsG1n3D@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aRL5EPMD9VsG1n3D@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfbabbd-3324-4268-10c7-08de212d861c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L1V4cm5MbVExdXFvYVBnZVdldEY0MEU3QXRaNUVsR1U0SFV3cUJYZ1BjNmJQ?=
 =?utf-8?B?S2wwYndBQ05oeW5VL1o1NFkyRzVDbmk0S0RCZUhiSjk1Y2QwTVBnNmlHYVJK?=
 =?utf-8?B?c1VyMnIwdUJ6a0s1ZG5PS3RoL25ZWFFKOUE0aWhiQnBIdUI0S3RzRjYzYTR0?=
 =?utf-8?B?OS8yU3hidC8wRGNVVDJ6U3hTSGhSbkdQQ1BGTGkxdElSMDBhU0xtSkVkZHVo?=
 =?utf-8?B?OEE1cHhWb3paZVNFNE00dUhTM1JhTi82dUdOR2MxVkExbk1LdmpZWGJleUpl?=
 =?utf-8?B?d0ZieDhyY3Z1YmFzYnRDMDF0UytPRmRnaU4yTE40U3AvYVUvYzU2b0tKVHRR?=
 =?utf-8?B?UUhIeFkzM3ZEZHVOZkp1MFNUK1VCRHllVHNpMnZ4SGlWVGRQSVZGZ2lvUG5X?=
 =?utf-8?B?bmhQQ21jVGVlM1E2d0tndUU5SXVVZmVzUjA1YlBmVG1tN0xacEVTK2NYQ0dV?=
 =?utf-8?B?UVVUREh0U3l1WEZCUnNmczg2eXdMdGFwRGFlVWZzM2NnL2NhY1BlSFhXcWdZ?=
 =?utf-8?B?cGNoTjhwa2RrV1MvMm5HSVl6b3JZdmdoTm5oR0lSVi9sRGtZWEFZY2xVeVI1?=
 =?utf-8?B?TmV4SERzbFdpTHNDNmpFcVh1bFRXREZHYkJKVHJtVDNxVGQ4Q3dOeHhWOWpF?=
 =?utf-8?B?cHo0YjNCREdYTE8vSXMyYy8wWXVTUENncnZOb1RyZmRaR2NwRmFVMS9wNlNT?=
 =?utf-8?B?cjBkRE1wMHhaa3VFNG1zMmpLeUZySEJxdFJrV3h6SUhuTytaL1QrTmUvU01m?=
 =?utf-8?B?bTF2QnVBQktoeTIrc0x1aDFwTEtKOHlUNFlacTVQbi9tSUQxTHBPcXVHd3ZF?=
 =?utf-8?B?RlNncG5BWU4vMkhMTWNJa2hPN1BOUVpQTXB3RVBITDhRYXZhQXZ0OGlyWXZU?=
 =?utf-8?B?V2pnSzlaUXpIOUVGS1FGbE9zQTF0MU9vKzNYaHJvVktOdE5WQ29ncnRYTUZ4?=
 =?utf-8?B?UHhyOXk3bDV2KzBnUE0xMU94dXRQNkpGdENWdnBmNnVwME1iS3pkbnJ1RXBR?=
 =?utf-8?B?Z2c2SHMxOW9XRjQ4YUFEZkE0UkkxRXpEQU1BQXoycGoyV1ZscFhkMnlqQnMx?=
 =?utf-8?B?bnBIN0loaUFUNWJXcXBnQUJ3TUIrWHlsdEtwQmdRYlc3QnprU0QxcWhoVkdY?=
 =?utf-8?B?VHVEZmJGemxkTDkvSmFiQ2RMK3VDTmF6MkZ0MzhhRXBYWm9zazBXNFQ4b2RR?=
 =?utf-8?B?QmYyU0EyQTZJNEN1ZkF0ZE5iZ1JCeTlpU3lCMkRSZDA1N0xOR3U1TlhVRERy?=
 =?utf-8?B?Ris5Rk5WcVZtNS9rcGE1OWJZR1VKTWNmUHpDUzFqWTZDVnZnM1Q3Vkw5dVFZ?=
 =?utf-8?B?VGR5dFZrVHYxV1Y0VVRvR3RxUFFaR3lBc3ViZVZ2NHpxcER4Y2E0bGNCRDhJ?=
 =?utf-8?B?VnBQUm5nd1pISG91UjNSOWZBMEkvMk9sSHN4dWZpL3VyOEFWc2hYN1NYbWVm?=
 =?utf-8?B?VkNDNnd5SDdET25adUcwOUZ3NU51WVgybXNXV2wweWh3aGlJcjRHTjhEbmZG?=
 =?utf-8?B?VTVsc0lBNDlhSGxiZ1JOcG9FM05pYjRsbG9pMXpBL1ErMiswemh5YlptWE1B?=
 =?utf-8?B?NERCS2JsMG0rUmVrNm5hdlJuY2dFQ1VWK3hDT2lMdG55NGttbUJGTVJRQStY?=
 =?utf-8?B?QlRDQWdOY3oxdXA1OC83eDFpcStzY0pBbHZaT1BXMElUUTFsUTI2dnJmM2lk?=
 =?utf-8?B?ZTBscGpBQXhad29sd1pYVmZSZldpRWZvVDBZSVZtOHVFVkZGckxKOHdZUVVl?=
 =?utf-8?B?Uk9VL1BjamM5bS9qT3BBQ3J4bWJhb05WWE1VZzYxZ1RFbFkwc2lhOXp0eUdS?=
 =?utf-8?B?T05KN1lkTXpDTXZxczlPM0x6VzBSOXp3U1lGMWRGZXNBbk9ybGViQ0k4Z01V?=
 =?utf-8?B?Uzk2UlZxT2ZBMTk2U0I5ODJTblk0aUNkSUpQbWkrZVFVN2xwWXRxYm13VmQv?=
 =?utf-8?Q?xf5cbiv/8qJux3LnC7ntfglP2itpAbhS?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NTMvVW5ITW9QNUw2cjNKa2ViaDBNSFVkSkxiRlVsVmY5Rmt5RDAwanBkUUUr?=
 =?utf-8?B?bVFBL0ZmSEt4QlJMS2JKcE5scElNM1pHY21XVFZMMC83Q25CMU1JVTBvNmY1?=
 =?utf-8?B?NWJQOWtDYzllNVpvL3ZjWHp5S2tmZ3VaZzBZc0VtbmtyR2FBUnR2S3FiUCtu?=
 =?utf-8?B?TzNyS1FicjNRYUxoV2dGVzVkbjI4ZzNoWjdjYkZLd1ZFSFRML2txUkxnUHU4?=
 =?utf-8?B?RkZmQitpMiswQmw1bkxXQzJqUnExTzA3Z0RsWVpSb3hHWW0xMTlNbW50K1o0?=
 =?utf-8?B?L3VtZzcrMmplMEc5Um9sOTlVZVRSSFlsS0ZJOUczKzBiVGRvV1oyTWJMTkZi?=
 =?utf-8?B?NGVTRzlBb1BqTHFEcEgrM2ZGOUZLTVk0YmNnb3M4RDNqVTk3TXBnRllTTUJa?=
 =?utf-8?B?WFRjSVp1WTc3R3lzUS9oU1labURKczNzeWZuTUJvSyt5ZGhROGpsVWEwdSto?=
 =?utf-8?B?dENpaU5rdGxyUVg0bGMvU2E4ZmVwTG5vSmtLclZZdGorRFM3UlRVTEd6YTNh?=
 =?utf-8?B?YkFueXpRejVMNWhCOEhIUUtkWHZxVCtCOFdUM0F6QWl5OHpYSkRVNjA0MHZ4?=
 =?utf-8?B?c3VKZ0tsZjA5ek9DT0ZpZ1MvRjJiT1lsTTRtR3plM0s3c0EzeUhpZHozeDVO?=
 =?utf-8?B?c1hJcU5JWTdFRGJSM3JEZHFVSTM2RS85NTJURnhuTzZiVkpYdDlKTlNFU1RO?=
 =?utf-8?B?STVNUHNPMExSZWlTMFhnUThFSVhGZUtRQ0hxRG9hZnViUnZEbHp2bjJESHZ4?=
 =?utf-8?B?RUdCYTJKbG9yOEJmTHpFbWZZRDZyQllpbVk1c3RLTStrR0gva0xkUDJ4eHY5?=
 =?utf-8?B?bTVkRXR6SkNiTWU3NlFzS0kvVU9oOEZVK3l3NVVFSFBDaDBDcTlaaDBWZWZ3?=
 =?utf-8?B?a1c4Qmw3NWtJTXBqcjN4aFZ0QkMvMTFWSmF4RlBhWFRmeFRQVGhndGpONGl0?=
 =?utf-8?B?M3pEOEtLaGJXZnQ0ZzFCQ3EzYnAxZXRneXd6ZUpiK1V2UkREelRnYkoyTlVj?=
 =?utf-8?B?T0xBaGFLV2VYb1JjeVVkdHZlTWRXRjVKZFhtc1BibldzSHd5Yzc0NEgvNlpY?=
 =?utf-8?B?ZmMyK3ppcVNtMm90d2pwbGx5MVVBS3dieVdnMk1HWEpqRDlORDdEdVNrM0Zr?=
 =?utf-8?B?TE5uajZkankzTTB6SnkwSUxiUHQ1NFBCVS9uVXNmaytyK2JyQ0FzbUJFemxk?=
 =?utf-8?B?OTlhQjRvc3l3OVVyRGFTSUk4ZHg1VE1NWW9waDUrd3hzVlUxYStseDRkL0t0?=
 =?utf-8?B?UkE3M3FmN2NPMnhrRmhObkd3bmFlWXF3TUV2Q01CeVRvQzQzRVUyRGdLeDNI?=
 =?utf-8?B?SU1wdWl3UlJCQVNhcmVCNE45Sk5JKzc5VFh4OVZpMlBtKytiMmJXTjhpeW50?=
 =?utf-8?B?L0I2bks3amVBNW16K1F3UXhlUzU1RnhVelFYeVoyaFNtM2NGOFFkNWoxdFps?=
 =?utf-8?B?bWhLcFEvU3g4RjdvclJZRElHdUV1bEo0YkI5K1J0Wk04MUhiOUtKZ1ptRVgv?=
 =?utf-8?B?RjlkWGk2bExKcTJLNFdvM1Y1dTUxSGJvVFVMK283UWxsaVVwQkM0dVloOGMw?=
 =?utf-8?B?R2RjejE5UGdIUGJqMWMrSkRiNHkzeDBRVEROdDNycEh3L00yajZUako3U25V?=
 =?utf-8?B?bGNSRlZsTHRDeEpjUzFCMGdhU0s1MTRyRloxQXc5WnRCeVMrQkNtNzhIeDBn?=
 =?utf-8?B?Nm41dFB0eTVmallLMC9pOVNZMGNRWkNVU2tBRmFNRGdCaHp6c2JFWkJQWndR?=
 =?utf-8?B?M3Y1VjJSQk9JbnBsSUxiNHVPbmtJLy9jRTRLSnlTS29ib0dQM2NIZjdhUzZu?=
 =?utf-8?B?NUhwRWt4VlROb2tyL0ZyUTJHUFo2aFlnY0t1bjNpMmNSQ0pLeWFkME5iNTNz?=
 =?utf-8?B?bSszcWhXa0E0cUhPeW1ZbDlDWVM4UllqOGErdE5EV2VZSlNXNDNGMmhpWXNW?=
 =?utf-8?B?Z1VFWDA3L3pFZ01kWXB0WGxOMzZUcmZaRXZscmZXQ3h5YTAzWTdaZVNmUTN5?=
 =?utf-8?B?VTNTM0k5dlA3c2k0VExMUGZHZE1RZ1pqQW00WEtNeVoxMDBjZWs3YXFwMVZE?=
 =?utf-8?B?ZG84a2RBcnZ6SURxVzh1V2dBSExmWjZIMDhHcjNibnAvQ3R3NnVIY3dTTE8w?=
 =?utf-8?Q?Zl65OoVr5HHbx16Tz8Iht5t/c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XccZmi+j+hHdfPi2IGdCH6m/2JNYnSCDW71/gNLEmcXD1/DiYUFFBDfAkuc3ePInG7XSLfbaiufUJktJThxEU0ToGPKXyLh9oHaEwmtjYViuAsjqdbtWUYxqcQL/9GBVzJM0SUJOoPVwtd64y1i0Vd53A4px8geIkImStulQGuIuRgj3VZ2cC72scwB6TpBGRDnN9woSAdONhV+cRoqnKU6kxWZ7GLRP6+In630f5yCUoocgeoVifkuHCpwU2OnXc8vOG/PVYji3crQ308+1JsdhwHlBDFOdiJL1T85lkpMw28GyNdoGWVSyTsGzKbfAyeKsq3dTXASw4ELyBAqzhcKLowhGEM119h/9jSC73TCtnlkM5ouWrYf/Wavn3ccDEUEsmxJ3Jc68K80WhT1+Pa0G3DcUT5W6VeWwsg3Ax38xeCLerHb8XfzW1hExf0YFUnRbLSjNvNEDFo/cRXoRoin3hyQollcc/mQuo30FrWgFceInWZ2BIJ4GnUDAkvPKyYYhqxaBmRMHjrjAvTquUyh5VBeGiEZE/Hyg5mv3RwgfNOOu5Zd91mcEYVPESaaABqhelJZHgGKQ0SmSgppOqVmfJWbcsF+PvR0KZk3Hrxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfbabbd-3324-4268-10c7-08de212d861c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 14:20:54.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bjtel54pMke8jV+rs/DqHzV5KUGxlgt773ClUDrrG1XTOlZFhGSrvzzRjgHUlH+zjwunZN/FPhv2IQ/mIoXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=978 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511110115
X-Proofpoint-ORIG-GUID: Tk2MYuznKe27U8FkCO6_5QOI91DLonAY
X-Authority-Analysis: v=2.4 cv=WuYm8Nfv c=1 sm=1 tr=0 ts=6913464a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CwAErSL-LLb0EiMAUAQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13634
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5NyBTYWx0ZWRfX4+RXdakhxWIF
 iAjn4U4AywPZSYj4jH6r3URWNgPflH3EiztRqVyicyCAnQfozWnjxNWALjbG9gijn6/n4u3kL7q
 zCXl3KK7gKBrajjAf6HtrPc1zwh8Ud096Y1wXRwEh3JPRRkbs0m6kkCZasGEgTHyFSO/1IuJ+45
 khVMTiha9jg+4OitQpe6l4LgVfeTZmSqsBsgSaGmAcSt5CDjLpIX4QWbNfl4/Ap3wTCp79IB7m1
 MOFbZrLewmU8OyyrwJV8ZjiT183d/4dtQ3Nn3sAxstu9ZGaHQK3Ls6YWjMeP38V8SM1vjA3uIzG
 xPo9Ych6s7jIOYialC2pW3XhXDbATsaN+BwXrfOGILI5vFCgx+bWy7Kt/32BxiCHrVGfOn5i4Pn
 dXsdfkQd+oO2HzPdqu2ZsOb9AS86I08W7tpRjKD/HbhudhO86FE=
X-Proofpoint-GUID: Tk2MYuznKe27U8FkCO6_5QOI91DLonAY

On 11/11/25 3:51 AM, Christoph Hellwig wrote:
>> What we still don't know is exactly what the extra cost of setting
>> DONTCACHE is, even on small writes. Maybe DONTCACHE should be cleared
>> for /all/ segments that are smaller than a page?
> I suspect the best initial tweak is for every segment or entire write
> that is not page aligned in the file, as that is an indicator that
> multiple RMW cycles are possible.  At least if we're streaming, but
> we don't have that information.  That means all of these cases:
> 
>  1) writes smaller than PAGE_SIZE
>  2) writes smaller than PAGE_SIZE * 2 but not aligned to PAGE_SIZE
>  3) unaligned end segments < PAGE_SIZE
> 
> If we want to fine tune, we'd probably expand case 2 a bit as a single
> page cache operation on an order 2 pages is going to be faster than
> three I/Os most of the time, but compared to the high level discussion
> here that's minor details.

To move forward before it is too late to hit v6.19, what I'm thinking
is this:

* I'll reset the patch to leave DONTCACHE set for all unaligned
  segments, as it was in the original logic

* I'll post a final version of the series to be merged

* We can resume this discussion after the series is merged, as an
  opportunity for optimization


-- 
Chuck Lever

