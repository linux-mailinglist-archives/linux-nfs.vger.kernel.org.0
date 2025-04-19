Return-Path: <linux-nfs+bounces-11191-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A43A944E9
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A8A3AB14F
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1B51A2658;
	Sat, 19 Apr 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EntOLW8X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dC7mHP5R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A942647
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745085178; cv=fail; b=mGAXwGK5O1ifOsByOQ+TAyFVau0C9i1wmlahKY+f4g8Hu+sdGA5+q6pUGkWR+zunMs6YX4K1FHI3lrMyzcjwZg10Tcvx1Hb5vBl9G7gKfoE0cH1kuTqsfdUIfrN0McpGAnlLvWF6+l2OvP6IJfk5zOHoEWowDjaaNfOyMgX4T6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745085178; c=relaxed/simple;
	bh=I7/MGBYB5kNvHEZvJ4sq48nuxwvJ2lLQ5aKBCtzu1I0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3HvXTM1lY0fiD9GdehqZASc1+jJZ7tlMTvHlgwBC274guMAIcukELknDIl//CSUqQNId2rA7OacyzKne5c7JkB3zkPp3hRINuPbkmDzLCpehXatVpROFIFha4jHSn5RZVS7fupSXXRtGSfO9uVzrkN2dbqDvL1aVP4NLDzQd6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EntOLW8X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dC7mHP5R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JFkCMF000922;
	Sat, 19 Apr 2025 17:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JQYrRMt0YIZz3g2tGZVmKRblEhKX88Xbc4NJWTFN/mM=; b=
	EntOLW8XJL4fAhNz1QoMM/xUY0Kc1joknYJPtNKV5erhkvFhKNLE5LK/EIzI7orw
	fYveLS39287TTGdyDP3I94UWqCAGomHyXuihVkwrhBAfbqXbaJAhuW5RGlSZu6Iz
	hEByuPEe46rRUKFpsyYZy2ooOFDQKLcRR76sNPI2dbJV95LE1XlMQr0dSCRwCCbV
	CN/0jwckFg3PiST1hjbJr7nXJccjGbqRjGyjaBpkpPNg6L/o+dPg8Ns4TO9QdvvS
	rcwt1dAeNrMqk0mk6nZPR8DhII1UnLnwwqH5vKVcKEvAmeEs35ClzGDC0rpAQK7z
	4fe9xw91aOMxowi6tJGWPA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642m1rfpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 17:52:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53JH0Z7b003036;
	Sat, 19 Apr 2025 17:52:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464296nx6h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 17:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4thEMjKWeioTkqgrFSVbvS6RRzJLfpwHDQQzdKl+Gtm7yOD0nukuu+aiEBFhCDFK5rjfF+V/y6tBREdKsALxzboXFq1G1f+2foTyrI/P0DY+P3ewy027g2YE4+EbI2In2QvtuGRyXKFX9eQCN/z7pfhqIr4mk2GmFhJl5cltZCmkaJuJZmQ5oO7ws/Cebjo8eI1X3rhIQgYmxE+dO80nN1N/gDTRPyGP4s/bOqYLp8FyzBqyN8thesZUxznOcGyzzSkxDrFw2/82IhHj+PDgp75T9TXwOe9hX+SxEdUuy+M16V0wDlivUq0m5nVSezpNUarnBX8os7cNAZT9vblrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQYrRMt0YIZz3g2tGZVmKRblEhKX88Xbc4NJWTFN/mM=;
 b=KEq/t9z2OUsPWLWyj7Ipn12KBJOSiejwhjGBQsKIusa4Jz6a3D3vItff0fekMoymErn6d7vg2jZ6WZiYHHvhqeyZIxdzspL4wLNfPEjT7GUT7gozKAdDHt4l37b9iSoLD7/26hOXuXZzdF7o5FR1DvvkOomGshOLgEeqqe7B7POh9PNjLddOQjB6lSYzapTiFqR3Rx+0XJnGwyk2iW6BlORZEJnbkxIlJstSxwA9H+uCxS+9w5vvZnuZbF5IWj/iWcUQB+u6BUSXkAUs5h4MvKJjfdlItKWRWMEXZVPRuzRokssP+ye3Ac7uHhBDpYq+cm/ol3Oy3Hhg3x2mvLHh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQYrRMt0YIZz3g2tGZVmKRblEhKX88Xbc4NJWTFN/mM=;
 b=dC7mHP5R3EPVcrpkK3rQaTbDBD5rcQa7mW4RpJc9SJh7akYaWdzekqatsPVK3dv7OLd72Ll44NtJGzvltpM4IXYpXQrWRC3L6mgw6nnP+L5KB0wdnfEVuQDI5BXeZDU7kEm6gaWc80K77TqZkh2bKcoygLfC/iICx7MsDoW5gu0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8162.namprd10.prod.outlook.com (2603:10b6:208:513::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Sat, 19 Apr
 2025 17:52:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8655.025; Sat, 19 Apr 2025
 17:52:34 +0000
Message-ID: <a3ff6c97-3ea5-4baf-aeaa-77e29e1d7216@oracle.com>
Date: Sat, 19 Apr 2025 13:52:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
To: Mike Snitzer <snitzer@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Anna Schumaker <anna.schumaker@oracle.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>,
        linux-nfs@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
References: <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali> <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
 <3911d932-5ad3-4cc9-98c9-408818cdb4cf@wanadoo.fr>
 <Z_coQbSdvMWD92IA@kernel.org>
 <738e994b-1601-4ae0-a9a2-f74a6b797f23@wanadoo.fr>
 <425a2e7c-6d42-451b-b8f8-7c923ac0ed03@oracle.com>
 <aALFdnEGTxF03uQd@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aALFdnEGTxF03uQd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:52::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ccc950-0684-4edb-b550-08dd7f6af69e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?R3FHTStpc2xYdk1rd2o5ekxleCtRRkQ0dWVvZm01ckhNUWYvWWhHWlQ3Vm9r?=
 =?utf-8?B?WE5qNlJjcXJDblFQZXJpMHVMR1NRVHJsb3B3U3JXMno2Rk1YRnJBTW5CY3Zh?=
 =?utf-8?B?T3dDR2d2ZmpCT0pDSjkvRy9JSWNSZ0MyWTFjbFV1MWlialBRVU1ieTdyb3pm?=
 =?utf-8?B?TVREZmNjckZHQVd6RE8rTVRXVGJQWHZPalBkMG1IUks1dXBjQUI4VlErUFI1?=
 =?utf-8?B?am5LOU1HaWV1L0JOWVBXQkgvQ1VLZ2hwSzJMVkhkQVZSa3FZdkY5dThDSDZo?=
 =?utf-8?B?bmUvMmdXQ2RHRGxCZ3hQMEV5RGs3blZUZExsU1VFYk4xc1dZWEN2d1E3ZlFy?=
 =?utf-8?B?eWUrSTNHWW1TOVlJQzczZVAwLzEvSVhwdTd6UWZSbDk1eE1UWDN5QjhPN25i?=
 =?utf-8?B?Wk9RV1FmdS9SU056SFNWUU93VCtKV0NWWHhHS1VHYmdRRVl2dmVZbjhKNzZJ?=
 =?utf-8?B?Qm4rSDNER241STNvdk1ucEkzSzlkQnFZQTk3VzZtNVdSSUJuWk9sZzRuSzI0?=
 =?utf-8?B?TEg0d3lpbEZ4T2RjZGdHSmFOR012U0ROS0VVZlozQ1Y4YWZoei9EVXNmaGFK?=
 =?utf-8?B?d2pmVGdxVGZCYmoxRTZFZ0JtN1o1K21FY0ZsSWd2bytBUE5jNkJvQTNwRlZO?=
 =?utf-8?B?N09aR0Ezd0t3N01QMjRPQnVDZElZTldFUGYrZXZkMHlMeGRRcjRPV0VSUmdR?=
 =?utf-8?B?WjEzRDE5SHhDOFZ2V3lIVVVhUmMwSDdmbE91LzF3YlNLNDc5TWJTMDQyem9r?=
 =?utf-8?B?c004OHFZUXFIMDF5WmhHZkpqbUJma1ZrdjdKWW1VbkEzYjB3b2VYTUc3UE5j?=
 =?utf-8?B?SjFpWVdnblVNU3BaRkdFTnJqR3FYdi9qdEhBVUJleW81NzFMWE1SZFZUeGdO?=
 =?utf-8?B?Q2QxZlNQblNTTUNhVmxyNEd2WngyeVVsaVdBblcrMG5kUGN4S0VyTlQzN210?=
 =?utf-8?B?NjBNcVFuUWV6ZHhMQVNFZ09lbnN5OXFPSGFuR2dNOE1OM1pRemRRdEpBNlpk?=
 =?utf-8?B?K0ZRbjI0N3krdm54Z3M3YmJzUlpnZURSeWJQSmN5MExFODNtMWlKQ3pWelph?=
 =?utf-8?B?M2oxL0hia2FjWDZtWGpMWThZMlF0aTRrVEwxT1pmMGY5UTZqSjgwOVNPbDRp?=
 =?utf-8?B?a3F6V09CWFhVMVl1SGswem82aytCQXIxRnp0bVQwODRCdGlnd05jYS9FMGo2?=
 =?utf-8?B?dEtzSGdEV0hmMjVORE5CbmMrUEhUYmdRdE9kUVMydkF3VnEvdVhKcDYzNy9H?=
 =?utf-8?B?aWlFRml5Z3VZWnpKMU9PS1l1YWdoakZqbXIwSEc5YU4wWmkySnA4NHNRS0Yx?=
 =?utf-8?B?SkNFb1dBU0NRaEptSjJrRm11TmdreUg4SDZKWE5mSkNDcDJUNjRuTzRmdVJj?=
 =?utf-8?B?a29jMjRWL2MvbHNya2xxUlFyMFJVTnpWM0dBVUdDTjNQRitmSEV0N00vYUtV?=
 =?utf-8?B?VmZtNmxKTG5LWU5sdGVjYmFqRnN3eWpuNEMzRjJrVUpva2JkVVZtZVRCMkNO?=
 =?utf-8?B?SFlIWUpEWWtRMlpMSGwxeGdiclo5TytYbnJRdnNLUUpsODVDcEtFUGFqdTVF?=
 =?utf-8?B?eUU2NzkvVDA5Wm1icll1YW1DRlpVdS9vRHVXVW5adWVrdUR1ZldONnZTZm5D?=
 =?utf-8?B?cnVtbWJPUjhrTTFsK2hIMiszbEJ3aThwVXQ5WEtIditJbUlVSmJQakhHN0k4?=
 =?utf-8?B?L0xLUjdnRVpMaE92Uk9GTWl5YnBkcU9WMFRXMFpIemlmdlhyS2JUU2VDYWhG?=
 =?utf-8?B?TDRSUk53REFaSTNwU21FQkF6dlRRYVRsVFFoakJBbW9VbE1rYjhoblY2Vjd4?=
 =?utf-8?B?cjgvU2VRc3FqRzIrR0dkMlFLWll5WDAzUmUydFJjeTRtcnM4ZXJGZDlqZUFt?=
 =?utf-8?B?b29EQVBwMU5KWTdld0ZXNUs3RlE3d2VpTi9pYW5iWXZ1Y05SOTl5UEdSYWNQ?=
 =?utf-8?Q?+bXlR2P6E34=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?V01tOTZxK0c2UWFsaWRwMGhLZ2kyWWR5Smtidk5oemZoTXNBMnRZVnJvcFVo?=
 =?utf-8?B?Qkk4cml5Tmh1S0lqTWIrQjU2bzA0ZVFhTXZuMFd5eE5yM0dXYlQ1YWdiMDN1?=
 =?utf-8?B?NElSc0U1RzczNjZlV2haUzI2RXR4a1Ayc2g3VVVTVGJ2WUpLY1E4QUtOREc4?=
 =?utf-8?B?YnhaUHRjOU9zQVhnRzdNNk00VVBQYzNzWkVHZFZMRFVLSkFBMXBFdndxU0RF?=
 =?utf-8?B?eVQ3aFZVT3hYazBnb0Y3NEptN1crUnBzK25pSGFLckRGMWFIRG43TC9ndWtG?=
 =?utf-8?B?N2JsS2Z6TGJUN3ZXSUY4WHYvdUJNajV2Ym1reXloNW1SNHNvUG1FMUtXNjlT?=
 =?utf-8?B?cGdXeC82ci92MWt5U1pHeDdMQVVtUE9TWXhoek9ISitkeUhXZm0zQUdpMFVq?=
 =?utf-8?B?WHNFajBORWNDbGZzZW5Zb0h4T2I5UTJ1Uy90SDVJUTB1MEU3VldQVFZjdVN5?=
 =?utf-8?B?WG54b291R1NFOENuK3duWWIvSGMwNWNyZFhkZkhqclBuL2wwRThXUzhCczBj?=
 =?utf-8?B?MjRuWWJ3VnMyQ3dzUzNSV29qMmVFMXNiUE54ck5jbVJpS29wRlhQd291M2tV?=
 =?utf-8?B?WDE0UnZHbGxEMUlTc1dua0ZweWRKQmovd1BTbHRkenBVcEN0QUJtS3ZZWGxu?=
 =?utf-8?B?c3Bsc0V0dGlCSERhUDQ2Vmx0dEdONjBOQVlSS0drSmw3VmVjd2RlOFZqNDlR?=
 =?utf-8?B?NTVBZURCR09pUHNzZTdsYTRkNnVRL0g2YVdXWWRIM3h1QUl2ZWV3bnBpVjJu?=
 =?utf-8?B?ZkFrL05QZDlBQm94MDFqWWx0Nm8rT0RRblVaRStNcnpUY1BsdExidGxrbW0r?=
 =?utf-8?B?SG9YNWpGWXpyNkl6WHRXeFhiaVdGcUFKK3BrTDVrYTkxUEZyT051c0l5SkNi?=
 =?utf-8?B?Q1dsbFg4THExcXRnOFRhVUhmTUcwZVpNQlB5ekM1a3Y2akI0eDExNG1zalJt?=
 =?utf-8?B?czd2OU1SVEpsM2c2S3I2MmtBd01Va0FBUDM5T2hyKzNTZzNBTmh2ajVDU0VU?=
 =?utf-8?B?aVQwNDdKTEtmOHg3NVF2VVBQSS94b2x2L3d1MjJtUXNmSUFHMWpCVUtpeTBF?=
 =?utf-8?B?TTFpdkZCOTRHb2dLSEh5UVc0VUhiRHJOQ1ZMVnREWnpCZERHTGFHMklFeVN4?=
 =?utf-8?B?UzJLRi92ZnNKK1ZySFZXR1pYV2RNdzRSUVFLOGdUOFNYVzFiSnc0cHg0UG9x?=
 =?utf-8?B?OVExOGY1RlZSaE5MbG1Kdy9xR3FnOVlzajRYY1NhYXVaZXE5cHFUWGR3cExJ?=
 =?utf-8?B?eDJiTGZiMHZlUXZPOWtwVmsyWXZZYTVpdGsvYnJVS01kS0JHdHZZUlh1UEtW?=
 =?utf-8?B?c2VQeE4zVHFEbEx3aGR5azRvb3B4U29UODFyTWxKSGNOc2dYN0xCVUg4djI1?=
 =?utf-8?B?Vnl2VUxxVjBYSkFucVhncWpZOENsRHFBOEtST2hkQmJocS9OdTVCL09oUUJx?=
 =?utf-8?B?VmtBVFZEL3grY0x2dmNrcngydkxOai9jWDJVbGswWXI3eVB0NnhtUDhHaWpV?=
 =?utf-8?B?K3pxSkM0Z3BvSW1PeTRuZlVVaHRtdjJHa3oyaWxDc2xycy9vSVpqbmNwOEFK?=
 =?utf-8?B?NHNOT1hDMzdwSzQ0cTJsS2gwODc4dGh1V0FKUURpSXFIL3F6dHFWSC82TWsw?=
 =?utf-8?B?M1pSZDlsbm92WnpHazdSTXRBTFY1NmErUTN1eC96bzF3cFFqZFZhOER4aHRI?=
 =?utf-8?B?VnhqWGpTRDJpNWlNVTkzR1lJamp3ZDlQOWJoRmI2K0tCOTFTV0lia2NXaGVm?=
 =?utf-8?B?VkRoRUVHTXNtNUFENi93bDRDbEEwTjZvSGliQStOUlBvS3ZDenFMVTE1KzJL?=
 =?utf-8?B?bUI2eUZZMzY0R2lMeDVTTWU3UVpUdDNVZ1RHUzJzdkNOMkxpaEpDcDRMYnlj?=
 =?utf-8?B?VzBsSzNjK0VjalU3VUoyVU5CbWYwalFXL0tKQ2g0aGpqWVlQSFVWTkxsYmR0?=
 =?utf-8?B?V0hCcEJ0bmNINlFZSFNvOUZtODViUEpqam1VMjBKYWlTTnBjU0xNQ1FiYmhK?=
 =?utf-8?B?UHRWenA5aloreXNldDl5Y3U4WlVSUHA3ZDZnVTk2NU1yRmxYZXRXUUpCUnQ4?=
 =?utf-8?B?QW9oazlGL3lsRGF2RWxsQklIb0Y0M1pydG51NHU0RWJvRlZGSFZpbnZjbWt2?=
 =?utf-8?Q?5hw4jHEP7Cxj+iG1k1gOPt72k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0OflAu6lkDgkoNc1ug5x2VjK1a9MC1G7P3z2t0u9JxGxRByXhI34gxhIlMniEZ3X+L+3OIhrrrpOHOIKQsL4BWEM+ZY49TRqKiQlF4b0P3Fm+fIbrGsIHBcFuoMDX8QewmBkjMXz4iFmHEeAS4LtikHH9Sr+p7BvmAIToQH+mTiXp1RoiL3ijyRitVOsqlW46Zkin7TO9Lx/MSXx2MavUOEt1mXQAZi7MZ5+rxGZvj3uCxaxvBj4l42E0VUtG5XR7b/r5stBGLVSgqgN7HQQJgu9uk0K88kbzgfNEORL7GoOsVU0JtoMHG1xDYNlcgTigrzshTIfg0vbc7mY9he3/oC9vs1RigUDMcZtruuNh2Fp1qYsZXWmLvshtjWyLUD+PCdQWmz4m4kQmagHI0wip2ajaGtT+BKdwryD21OZiy/5trM9iqmZHAbZr3BYgPr+yIkOJNCctDPwxLbi0QriCqh3fgPVUHELMbg/tpA4v4RdxK6JWzjAAUaxhqROKTUfjw+Y7I0K7j8OUQ9T7rpAzAvY4G4fWZizruNj98b6kalP0n5oAAiIPZ8SmyKud8wf8N/RBMqoP6aCRPo2+keXdp+7h3Nj7QhKb9TmS/5GR+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ccc950-0684-4edb-b550-08dd7f6af69e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 17:52:34.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/Hd8vsCvMC8VkGE2dIPOa3AHwB81t0/8Q5qF0qQil84gepgaSx7PRyeq/HKfc9ZWYSnfHTpCiCrPbm3gSY2qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504190148
X-Proofpoint-ORIG-GUID: VvIcXnNSHJILIuCWp2JIOb126NfUhUGy
X-Proofpoint-GUID: VvIcXnNSHJILIuCWp2JIOb126NfUhUGy

On 4/18/25 5:34 PM, Mike Snitzer wrote:
> On Wed, Apr 16, 2025 at 09:31:55AM -0400, Chuck Lever wrote:
>> On 4/15/25 10:41 PM, Vincent Mailhol wrote:
>>> +CC: Neil Brown
>>> +CC: Olga Kornievskaia
>>> +CC: Dai Ngo
>>> +CC: Tom Talpey
>>> +CC: Trond Myklebust
>>> +CC: Anna Schumaker
>>>
>>> (just to make sure that anyone listed in
>>>
>>>   ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c
>>>
>>> get copied).
>>>
>>> Here is the link to the full thread:
>>>
>>>   https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/
>>>
>>>
>>> On 10/04/2025 at 11:09, Mike Snitzer:
>>>> Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
>>>> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. Otherwise
>>>> RCU code (rcu_dereference and rcu_access_pointer) will dereference
>>>> what should just be an opaque pointer (by using typeof(*ptr)).
>>>>
>>>> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
>>>> Cc: stable@vger.kernel.org
>>>> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>>>> Tested-by: Pali Rohár <pali@kernel.org>
>>>> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>>
>>> Hi everyone,
>>>
>>> The build has been broken for several weeks already. Does anyone have
>>> intention to pick-up this patch?
>>>
>>> (please ignore if someone already picked it up and if it is already on
>>> its way to Linus's tree).
>>
>> I assumed that, like all LOCALIO-related changes, this fix would go
>> in through the NFS client tree. Let me know if it needs to go via NFSD.
> 
> Since we haven't heard from Trond or Anna about it, I think you'd be
> perfectly fine to pick it up.  It is a compiler fixup associated with
> nfd_file being kept opaque to the client -- but given it is "struct
> nfsd_file" that gives you full license to grab it (IMO).
> 
> I'm also unaware of any conflicting changes in the NFS client tree.

Hi Mike -

I just looked at this one again. The patch's diffstat is:

 fs/nfs/localio.c           | 8 ++++++++
 fs/nfs_common/nfslocalio.c | 8 ++++++++

Although fs/nfs_common/ is part of both trees, fs/nfs/localio.c is
definitely a client file. I'm still happy to pick it up, but technically
I would need an Acked-by: from one of the NFS client maintainers.

My impression is that Trond is managing the NFS client pulls for v6.15.


-- 
Chuck Lever

