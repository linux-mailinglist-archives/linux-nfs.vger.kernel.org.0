Return-Path: <linux-nfs+bounces-8630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C709F5166
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 17:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427A51684BF
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D321F4E3A;
	Tue, 17 Dec 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="K4+qM0G+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2116.outbound.protection.outlook.com [40.107.96.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E51F471A;
	Tue, 17 Dec 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454287; cv=fail; b=J/QVKLd4Z8BGl1j9Ypr6dpuPqvnknVrgscFDvuj5nfv07XVRn8A3sIYHDU8w+bOD1Uv9cr7qaSkPpfMT79hYkbqLipyCTMnxQKm5DmxcJEVih6DlOr6AzjT/vhK3X1URGd9tZsPHj6CesjxZeqnB6LNcDj/n67W1c/gP2KB0mlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454287; c=relaxed/simple;
	bh=nYCTkWPLbivPBujx2+va+kkKYdUoxpetyoI3xXUFYak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X8BSsojvSwQXtfKEuc+pisN6cvlxHxjp1S3sBhLzIoIkrdWD5amtcN9TnAgOcX9vD06Vv/mO+BUYxN8WnUD/0IhZXtldVURzRRYmPCi68GkUXLRf0B1M/NKtVO7mUxAv8tDzjYZa36kHOKiR5tV2Yy8CXVEbAgDX96pbE9emJ3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=K4+qM0G+; arc=fail smtp.client-ip=40.107.96.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJ7IITNA6QCuPJvD+AIffoQ/PNxPo9fpWFySfRKIDFn5PomlmewEeskcq4FDy1a8qCP/lVe/Z37bhcoyAguxdlnHuIBJOAWfo2JBZY9doamo7iZx1EiPp7ipe/Kukp7jm2Qawi9hai7WuZWz3i7vzyLZ0whZyJ/MCd8Dz6imXcT8/y4t4U4Kp152ygT7lWmCtK2idNY3e4b/a+n9IxZWuQPNwLXlIul7IEnCWDQmP0/SHaELeITC6EeiHTqQMZqD1U7gAF87w35Os8l0Hj6hUMGzoLqP3xQSUDR+Q6IXZD9yY0QQSkfSKTYXOcUtjN2faUdIz/PD42qN2ru4PllhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYCTkWPLbivPBujx2+va+kkKYdUoxpetyoI3xXUFYak=;
 b=IwRVA5g00DPwQvt9WThzHVAxzMV0yg5ppHFjq4RQKnQTHza3UtFEW/ZFFJj43+1pIOUimGJIDEl/VAowFZI1V7jI+dY6E1PwODTX1xcro5lKpVVtc9w1NWTGNvaX6gZ1vrQ9tHWa+bq+7RaFK0Luc3gzn7xDCU56s0GzqtE7K6mhhKCweFCJL/qiNanc4ll6SWDTb4Nb5VYgZdCDbqaLVvrbGQaiqdDeIRGdeKVHagFrkszp75E9OVDZUbabt4vfRNCAWX+agg6479uW51YNxQfKCce4YJaS0CfkREuKhlWkBEefJWSoVyQ6kXfqSOru4qpgjibtH8cmENVkxkhrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYCTkWPLbivPBujx2+va+kkKYdUoxpetyoI3xXUFYak=;
 b=K4+qM0G+KHYcI3HeaphpruqL/VNI+csGWxMhkRzJdiDs+pq5aiS6dpNkRolFBfcYe2hwZXt8+fViyEF7q4te1KbvRvA5yPwE9cp/98eE8fpRLscW2iAQcL0B6c+Q8eKakNFw9MD/Czd9caBBcd0FYCb+kyXY1BZJ0KxoY4sWs0U=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5232.namprd13.prod.outlook.com (2603:10b6:408:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 16:51:21 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 16:51:21 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "zichenxie0106@gmail.com"
	<zichenxie0106@gmail.com>, "bcodding@redhat.com" <bcodding@redhat.com>
CC: "zzjas98@gmail.com" <zzjas98@gmail.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "chenyuan0y@gmail.com" <chenyuan0y@gmail.com>
Subject: Re: [PATCH] NFS: Fix potential buffer overflowin
 nfs_sysfs_link_rpc_client()
Thread-Topic: [PATCH] NFS: Fix potential buffer overflowin
 nfs_sysfs_link_rpc_client()
Thread-Index: AQHbUJ+1kwLLMgq7iUmD2RyOCngpdLLqpoqA
Date: Tue, 17 Dec 2024 16:51:21 +0000
Message-ID: <41572d6005dfb2042482f98177a9b295433c8a5f.camel@hammerspace.com>
References: <20241217161311.28640-1-zichenxie0106@gmail.com>
In-Reply-To: <20241217161311.28640-1-zichenxie0106@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB5232:EE_
x-ms-office365-filtering-correlation-id: 3adaf668-530c-48ee-22a8-08dd1ebb08c7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmk4NEhibW1aVGdaV082K1NZemQvSFBiVlZEZXpqOGtsY2VVTDhyaTRLL3ZG?=
 =?utf-8?B?STJaaVVEdUhGZnBZYjZFTlN3cVV1SXpxSm13NDlwSGUvcmdweVd0TEx2TDJH?=
 =?utf-8?B?djlaeHNITHN6UmhxK3ZubFNIU1E2dmVCNWRxZ3ZXdlBWTGhOcWFTMlEvaHRk?=
 =?utf-8?B?RnhkR0NHbDFCN0ZTbWFHMWZRUXQxZGRSUFRjWVgvWEVRZVJFclVNSnhTSkRS?=
 =?utf-8?B?VXJpU1ZGQnRLb0ZCZG5iTktRSVZGTjdQWWMzSEFqdm9rSTlXRHZaNFhYaTdi?=
 =?utf-8?B?VUJaMi9zbXdBQlA2UHNDRk5BdkozNmNTRFRtZ1FkaWIzdnF2TjNZT3pkdmx1?=
 =?utf-8?B?bHJmZGdpMnVLU0JyWnhCdHNyT2tHc21SZ0dPK293c2NFS2ZCQ1JJRStWc2Na?=
 =?utf-8?B?MnI4SlNScXpRcCs3Q081aWlyQ0ZzWVE2clpNYlpFUmgrcC9GUGdmZkpITzRw?=
 =?utf-8?B?TTd5OWZPZjZpRVg3YnN2WVBsUzJ3UURINnY1VlVNamZOckN0MEtod1lrUTRM?=
 =?utf-8?B?bUpBR09yTHo0ZjlPL2RXbnQ3MU8vWEc5U0NDMEVoY1Bqc1ZDS2RYM0pyTFN4?=
 =?utf-8?B?U1RqWmpXVzFvTU9uRU13VUtRUnlUNVY4YWMxcmxBZVU3bUpBVmx2UGd0YVNo?=
 =?utf-8?B?dzh0YlpnM25RdWc3T09LTzhuUi9QMVh1Zy9UYVVYNDltZU5PWWM0Y1k0V29k?=
 =?utf-8?B?UlA0OGZLeVhtWGgzenBaelNoUENKQXNuUC8ybkdJQW9wL2RYVHlRbkR2NVlT?=
 =?utf-8?B?RFR1QzZmSndUcnBtTUhwLzhUM3YrZHZaRytyWHFOYldTZkE4NGtXZTNZNmtx?=
 =?utf-8?B?R1c1SDZGTmhJRVNIcUJkWm5jd0t3Q2FuK1krV1dQMHVhRjQ3YlFCdUgxSFBv?=
 =?utf-8?B?U1pPM1RtNWJtMXROSUwzbmRmUE52UmtoVUNKcXMzOUprc2laSkcvd1licHEv?=
 =?utf-8?B?SU42dFdHeHQxRjRRL3IwMm5ZN1UyN2NJSEtKNnJNekFKWThTVlBld051aVM1?=
 =?utf-8?B?NjVGSFQ1ekhUZUFCdTFaVVNsVXZ3a2tUaFNqWC9VelZMdkZSRlhSVnpVMlds?=
 =?utf-8?B?dWhSSmw5TVFFMmdaVTh4K0dlQXZLYlBrSE5tNzI3VUYzYyt2Qy9PeDJ2YkI0?=
 =?utf-8?B?SWJYb0EwQ291Y2VzNzd6aGxXc1B0Ums2VEQ0ZktOWm95ejdnUlhmTVY3bFdv?=
 =?utf-8?B?cWc5YWZuUnNHQXFtNHdlcWppbkxTVlhQbGpFdVVvMEJwZGMyOEZNcWRTZVZQ?=
 =?utf-8?B?OHl0OXVaVEhMN1RBTWZyTHVLeGd2N1JVQysvalJIdG9TSFhPcHZhZEVjaDlU?=
 =?utf-8?B?NGZxWEVXQWhnbE1kVlVweXVjOHU3RFRvdWErUzNQSjlvTFQzR1IrWWxRUE0y?=
 =?utf-8?B?a3lmRTlHUHlHaHVDVERLQWJlS3BhbzIzdU9ERVl2Wk5rTFdqUG5TZ0NMQ1kr?=
 =?utf-8?B?UG13U0t2ajQ1TWcySnhiN1RPbFRKQ2FqL296cE1CUWlXZGJZeGFhZzBveWcr?=
 =?utf-8?B?dHgvRFVQU1hmR2JSaVR0RGJOTFJPZ0o1S1F1ZUVPSnhJUTlYb0drZ3JQdzQ2?=
 =?utf-8?B?dytmUjFCZEJndDF5WkJIZHV5VGNVVWRuK1BteS9yU3hwS2dzRkN6ajl6M1Z4?=
 =?utf-8?B?aFplbFA3NWhXUzh1Mk11dUVaV0I4UXpsYjVPbW1MMGpsR3k5ZFM2emEwaWIy?=
 =?utf-8?B?S0F4Ky9LNytiSU4wbnNNVmkxK0lETkZvWkxCWXVuRWRKOFYwd09WanBVcm9W?=
 =?utf-8?B?NDAvUGMzTUxibUV4QU5kNXNwSmNHNFNtZWEzdmpUSXFYUTRMU3dsN0dLR21D?=
 =?utf-8?B?UFkrbHVDZ1d6am44QjhFcUVqdndLanNNZGIxK3Jla3FkOTRtaHpwWnoxNzJZ?=
 =?utf-8?B?RVVvQTZEUTdrajlMWEdoUTlYT3RUUUNhQTZXbk43N1BvVnFyL2gvUzhaS3FH?=
 =?utf-8?Q?cCP+OZMog7BBPVyyyw3CBi4XZS3exgli?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmczR3FuaWdudlljSng2SDgvVUlhTlV0cFZOekp6QUhMNFZ5Q09xdEgvenVJ?=
 =?utf-8?B?Zk96MmNiYUZFRkVkLzZJVE05THRwOVFBNUtRbWZPcmxHdFc2Ylc5YTFGdnps?=
 =?utf-8?B?Y0lhRnRiTk8vT1pWOGk5T3BmQU1STENGamZnQnA4bHdtUnlWckN1MDNRd2xl?=
 =?utf-8?B?NW0yZmlyV2xkWndWcFhZYW9KVzdlQnEvQy9iMit3QmFCWGZ3d0U5dzMram9w?=
 =?utf-8?B?Y3F3cVpObjJUdnJRSkZRcG1wU2ZVSmpLQzlMemdkdThtdWM2TFE3NHd4QkNu?=
 =?utf-8?B?cFBXWUxXVmNQUlNHV0tTSUV1eGg0WTA1M1JRSXdNYjNxb1Z5cUgvVkFvM2xC?=
 =?utf-8?B?UFlxZmY1VVJpYXJmLytLVzRTSWlna0ZIb3ZNL1RaTmpoTDd1QVhucEd3LzBy?=
 =?utf-8?B?UVhMVEtRTmdEYTh6bDZOb1ZTRnpuR25kZDM4Z1ROTCsvNnd0QStZdWVQUE1R?=
 =?utf-8?B?VG5YTzdSR096bXlOb1B2NlBLUUhCYmcxR3prQklVVjVMaGpPVDhOdGY4MXdN?=
 =?utf-8?B?KzQvL0xUSWN3V1RaUWJ0TmlYL1RnQ3RRZWJDQjMrbWpoN0RZY0VveXQ3WUxy?=
 =?utf-8?B?dnppdTY4T0FoZWVpVTZ3b1dsdnZKWXBhaVJ4aWlJVmk5N1hSV0RTb25ycC9U?=
 =?utf-8?B?ZVdqdHc5NVJpbUZ5TmlHbnZJaXZxZkhvMTNlZzdkQ0lDUXUxS3BHZDM1bUhs?=
 =?utf-8?B?QThxNE4vcjlnUFBjQ3NlSGdwS0t2Uk84TjNNVUIzeGJ6LzhyRVJnTzB5RTlx?=
 =?utf-8?B?R3MxNWgzTlI4dnBxZjV2RnRrTCtmTFpma05wT0h6dHdRZnJ2aUk0elE2eVNx?=
 =?utf-8?B?SzBoQllZWk85UEFvVlBwQU9zQXF6M3ozUVFoZjZwdDhCZEFhL3ZMeXBGTDha?=
 =?utf-8?B?cGtTcHNWTEU5RGZTdkF2eEo5S25ORUdRZjRMK2xZQjlRY2hJdmpnQ1JOQml0?=
 =?utf-8?B?OHZxZ2RPaXk2Yi83eW1HLzl2bTBNaW9lMCtIOFNVWFR5RU1VbHk5cytQMEpp?=
 =?utf-8?B?MzdXMXNIYVIxVHM3VkNaMGx4dEhUdnprei9mOEhoRlpsTmJpOWo1NTlUVmlF?=
 =?utf-8?B?ZEpIdkRYN2toK2RFeERYdGx2c0VEbGZqQ1NnN3JLSWRjNXhJQzdKd1RGSXho?=
 =?utf-8?B?Rm5sa2hYUlpBeWptTkxySXVkTWp0UXM3Sk81bE1YdlRDQnR2dmZQaHVleXY0?=
 =?utf-8?B?UW9LaVcvQklvbVZzeXIzZ0ErV1hCQjJXRUkxc29qUHJZajNyblk0NWk3SVZQ?=
 =?utf-8?B?eDhLc1hXQm9CT3M0QWg3NDFmTGdQYU5kbHVPYTZJWEpEbkdjcnJtNkFYT3lJ?=
 =?utf-8?B?NU9tM1dJdzBkTUtZWFNGNjJzclpwQ0xmUjdCTkxXUzhkUFNvSFI2TERIN29X?=
 =?utf-8?B?enhPVHgvek1ya3NCNHVBWHBhRFpQamU4Qm92ZXh3anl4cm1XNTJsZGdMa0Fy?=
 =?utf-8?B?ZHV0YUpzYXBuMkladWhNN0xPVk9UeU15WHNzejlJNW1oNXFldVlQWnZ1alhq?=
 =?utf-8?B?ek1idTJTMGx2SW00dExpWk9tUGU4UXM3U055Mk1OaVVvcjk4MkVqVW1zWlI4?=
 =?utf-8?B?S3cvT1VRU1QwekNRK1RiTmxFenQrTjlLY3NMRTIvZHlORURQbVhBbUdKNHoy?=
 =?utf-8?B?bTV5RFU4WnFDaGsvWG5pMDg2dDhMRHZNaHhSQzFSQUxCcUxvUVBCQWRFSjd3?=
 =?utf-8?B?V2VZMXNOOVliM1RyOEJrTHE4d0FsbjJ3K3VTYk5wWjhYWUJKY0JwaytsaVJ3?=
 =?utf-8?B?TStEU1c5dDBGMUlJWjFDYTBWbCtiUHoweWNVU1NEWTNQNHdMN2RoLzk2UTg5?=
 =?utf-8?B?c1Zrb1VybTZYZFNDNklCT2tkRWhKQjdBcVBaQ2kvYWk4YkRkWG80RFhvcGIr?=
 =?utf-8?B?UzQrOCtzUWhQWG9QL3V3ekZNR2RqdVBrUXM0M0tjUUV2Q0ZMMzFtQU9VWlZr?=
 =?utf-8?B?SVNNS1FNY0pnc3k4U3RJRVBZUE9yQnNKSVFjQXZDR0tXelIxaHJWWXBYY2Yx?=
 =?utf-8?B?YXhiQnlVMVF3aWlVcWY0dDlzNFpRaWhLQnJOOTZOZUpCM0pqM0RielBWR0Rp?=
 =?utf-8?B?NVVISERDaDBWYnNjakRsTGwreFhFaE9mZFV0TnFxa1FMMHVIaVdLMUo2UnR3?=
 =?utf-8?B?YUEwYWZhNnIyYVdZY0o2YUZQWENKbUo3alYrc0hTMElUZHR6MmpYeHMvQVl4?=
 =?utf-8?B?eG50SnE5eWVWMnQ4VXhkZWxHR1RqNG5GZllIRlpEQi9yRUVYMXVLMW13NGtI?=
 =?utf-8?B?SVFlZDJ4WlNYWGc2YzZ2U0NIWVhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E07EAE9892578C488D1413F220C80266@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adaf668-530c-48ee-22a8-08dd1ebb08c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 16:51:21.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C314OGmD6Bji1W7NnQJoKa7v58XD1NSwvWG68XppS1Hx+pUN1ctLF/UjU/f+DALxhRwBGeyrFa8kKN+XVq16LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5232

T24gV2VkLCAyMDI0LTEyLTE4IGF0IDAwOjEzICswODAwLCBHYXgtYyB3cm90ZToNCj4gRnJvbTog
WmljaGVuIFhpZSA8emljaGVueGllMDEwNkBnbWFpbC5jb20+DQo+IA0KPiBuYW1lIGlzIGNoYXJb
NjRdIHdoZXJlIHRoZSBzaXplIG9mIGNsbnQtPmNsX3Byb2dyYW0tPm5hbWUgcmVtYWlucw0KPiB1
bmtub3duLiBJbnZva2luZyBzdHJjYXQoKSBkaXJlY3RseSB3aWxsIGFsc28gbGVhZCB0byBwb3Rl
bnRpYWwNCj4gYnVmZmVyDQo+IG92ZXJmbG93LiBDaGFuZ2UgdGhlbSB0byBzdHJzY3B5KCkgYW5k
IHN0cm5jYXQoKSB0byBmaXggcG90ZW50aWFsDQo+IGlzc3Vlcy4NCg0KV2hhdCBtYWtlcyB5b3Ug
dGhpbmsgdGhhdCBjbG50LT5jbF9wcm9ncmFtLT5uYW1lIGlzIHVua25vd24/DQoNCkFsbCBjYWxs
cyB0byBuZnNfc3lzZnNfbGlua19ycGNfY2xpZW50KCkgdXNlIHdlbGwga25vd24gUlBDIGNsaWVu
dHMgZm9yDQp3aGljaCB0aGUgY2xfcHJvZ3JhbSBpcyBwb2ludGluZyB0byBvbmUgb2YgbmxtX3By
b2dyYW0sIG5mc19wcm9ncmFtIG9yDQpuZnNhY2xfcHJvZ3JhbS4gU28gd2Uga25vdyB2ZXJ5IHdl
bGwgdGhlIHNpemVzIG9mIGNsbnQtPmNsX3Byb2dyYW0tDQo+bmFtZS4NCg0KPiANCj4gRml4ZXM6
IGUxM2I1NDkzMTlhNiAoIk5GUzogQWRkIHN5c2ZzIGxpbmtzIHRvIHN1bnJwYyBjbGllbnRzIGZv
cg0KPiBuZnNfY2xpZW50cyIpDQo+IFNpZ25lZC1vZmYtYnk6IFppY2hlbiBYaWUgPHppY2hlbnhp
ZTAxMDZAZ21haWwuY29tPg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4g
wqBmcy9uZnMvc3lzZnMuYyB8IDYgKysrLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvc3lzZnMu
YyBiL2ZzL25mcy9zeXNmcy5jDQo+IGluZGV4IGJmMzc4ZWNkNWQ5Zi4uN2I1OWE0MGQ0MGMwIDEw
MDY0NA0KPiAtLS0gYS9mcy9uZnMvc3lzZnMuYw0KPiArKysgYi9mcy9uZnMvc3lzZnMuYw0KPiBA
QCAtMjgwLDkgKzI4MCw5IEBAIHZvaWQgbmZzX3N5c2ZzX2xpbmtfcnBjX2NsaWVudChzdHJ1Y3Qg
bmZzX3NlcnZlcg0KPiAqc2VydmVyLA0KPiDCoAljaGFyIG5hbWVbUlBDX0NMSUVOVF9OQU1FX1NJ
WkVdOw0KPiDCoAlpbnQgcmV0Ow0KPiDCoA0KPiAtCXN0cmNweShuYW1lLCBjbG50LT5jbF9wcm9n
cmFtLT5uYW1lKTsNCj4gLQlzdHJjYXQobmFtZSwgdW5pcSA/IHVuaXEgOiAiIik7DQo+IC0Jc3Ry
Y2F0KG5hbWUsICJfY2xpZW50Iik7DQo+ICsJc3Ryc2NweShuYW1lLCBjbG50LT5jbF9wcm9ncmFt
LT5uYW1lLCBzaXplb2YobmFtZSkpOw0KPiArCXN0cm5jYXQobmFtZSwgdW5pcSA/IHVuaXEgOiAi
Iiwgc2l6ZW9mKG5hbWUpIC0gc3RybGVuKG5hbWUpDQo+IC0gMSk7DQo+ICsJc3RybmNhdChuYW1l
LCAiX2NsaWVudCIsIHNpemVvZihuYW1lKSAtIHN0cmxlbihuYW1lKSAtIDEpOw0KPiDCoA0KPiDC
oAlyZXQgPSBzeXNmc19jcmVhdGVfbGlua19ub3dhcm4oJnNlcnZlci0+a29iaiwNCj4gwqAJCQkJ
CQkmY2xudC0+Y2xfc3lzZnMtDQo+ID5rb2JqZWN0LCBuYW1lKTsNCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

