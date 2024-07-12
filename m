Return-Path: <linux-nfs+bounces-4867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2695392FC0C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 16:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B13B1F21BD2
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222F16C69E;
	Fri, 12 Jul 2024 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nH67vYS6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d+U2pMSJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8015DBAE;
	Fri, 12 Jul 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793026; cv=fail; b=oq3HOuq4h5yDDeqaj3DIcisny2fTMbhRMrkIgE0KKcef0pkv+8iruaMSez1VILGL+7KNkDVJv98L6V/1HcVZ/XoFCgWKnMNIY9o/Ta80ejGR2iikrQDWaxldGnlTzkYLtWdAGkOHWyZMlMqDIRvi79MuqrNzccg8FMYRFP8vGoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793026; c=relaxed/simple;
	bh=EYdqFPe8zvEOab0md6vDQk+qHv4sNsacnyroFz2hEUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EJZT1aeS/mwPkIm8jH3cubF5xlvn7b9NeTj+xSbjDVlg9T2HUlwX1GKCaIcC9kbG2RPsNt1I8z1Bo+oifYHkQqDXGMKTlHkDH7wx+RBEj2e0M1N0BVEuMF5vKidTOraPZnMzaPXw9bf1Smcby0ZB2egOmcSBBbmCcYWxSNMqtTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nH67vYS6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d+U2pMSJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIhge023482;
	Fri, 12 Jul 2024 14:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=EYdqFPe8zvEOab0md6vDQk+qHv4sNsacnyroFz2hE
	UQ=; b=nH67vYS61kIfZmHAh+6l/vxOqmTlQD0Tjw4muxi2gZvNiTn5Y3JX55M/l
	MIUxMUQFK0cx4x8/+5fh25cJuLAfMWMm30nbhHhZEh6s02cMjsFpjxfbb7XbV4Bs
	kQofsLvPbo0VDOXVfG3Chx2Hp/IsqZlHb6GcG6H75vDOLhICtiwC95ftG3si8gPb
	knq2aGz9Qfa2v1gQc0cmUIrgHRfmLODaYcFT7jNyFUMEq17VsBDqpIrmviG5myDS
	R+9jzONZR3iHycuJkjVwpIRi04uEwVdOSVx9wG+lxR0c1oSQ7K2FNNAFa+qQC6xn
	3J610MnQ5/5VzL6xGZojfbfEEtevA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq41wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 14:03:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CDUrUM010954;
	Fri, 12 Jul 2024 14:03:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv74m9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 14:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtAO2FoGncgFsMzcT2685eu76Sr7JQEVMAmlYLZdgdjNr7xovB7SX8aiWADaVkr3jpReVqaS2BtUjtGgUo7D2VW8zg1LiMIJYlfhoozzeHDHIWvQvjMd9gfUciTG3qpjh+zzPkpiY0Eykze117r3TsaDHFq1wTeNRTR+HFPQz7ilfEByhIQ1k9w4aXvzqIQh1MYGeM2myEX76l1+a+mAjv4EmbyS+5B3LGPgtFVgbJb+z6D2MTB9RR4lNxy3sr48PyYxbsQBQGW1XB9dfcdGsbjxWGqDBxmLak897LoReq44Ip7L4JI89Kd4QtoCSc+A8867qQ60ddXJ6nFYv4JysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYdqFPe8zvEOab0md6vDQk+qHv4sNsacnyroFz2hEUQ=;
 b=RzCrGDXgCxGnUr1ol0l/vt0FNQV/MJVWu3/F+IwOulJU5EazHTukgZjw1ZN1phOlzf+Dx4xr/9gXWSbV1+504MXYnfuKxlmBxqZy0Asp3WTh/CSl/wvyyWjubJVoVjKStbq9VJ0lC+Tb1UXJRRKExVRm7Yn3sOmNS1Gk9+uXIpLb2rrar1toMLCka5N0suD7w9+blOBtmeDGtjf+2+wG6JkCQab0HohSSfWzrbQ6z4tjGUPEGPQj0EM8rvwLt1udt7rY/l5I6Gk6MqIutLnh2QnqQlxbje32Hf7ZICAoZmvBnidAR62X966XOVYvJheuQBuhlQjmy+aFM+UObLYwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYdqFPe8zvEOab0md6vDQk+qHv4sNsacnyroFz2hEUQ=;
 b=d+U2pMSJKaoV2RUfZnPqIOvTW9ecccwImFvJD2Rbu821CyZiEHkA7zjuzBr+pig3gJVJq0kiCTFO+U+ICPXd3DRN7wRamDyR/Qd7Y6d9gc/q0j6kpEmdt3pFuzaASqqICp/i3YPeAHfNHsk5GDfKmcFRCPITyVGK9akbSbewyUQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7213.namprd10.prod.outlook.com (2603:10b6:208:3f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 14:03:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.024; Fri, 12 Jul 2024
 14:03:09 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Petr Vorel <pvorel@suse.cz>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Greg KH
	<greg@kroah.com>, Sherry Yang <sherry.yang@oracle.com>,
        Calum Mackay
	<calum.mackay@oracle.com>,
        linux-stable <stable@vger.kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-team@fb.com"
	<kernel-team@fb.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Avinesh
 Kumar <akumar@suse.de>, Josef Bacik <josef@toxicpanda.com>,
        "Linux regression
 tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Thread-Topic: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Thread-Index: 
 AQHazKCp5HoPbCA8x0icX5uCFQ/MP7HkDKAAgAQmtoCAARq9gIAACdiAgANUOoCAAHkFAIAE8XQAgAAbvoCAABy1AIAAXJcAgABEQACAAA4ygIAAMQoA
Date: Fri, 12 Jul 2024 14:03:08 +0000
Message-ID: <4E783F34-7638-439A-AEAD-4F2E6EAB1CC2@oracle.com>
References: <d8e74e544880a85a35656e296bf60ce5f186a333.camel@kernel.org>
 <172076474233.15471.345629269384872391@noble.neil.brown.name>
 <f74754b59ffc564ef882566beda87b3f354da48c.camel@kernel.org>
 <20240712110727.GB118354@pevik>
In-Reply-To: <20240712110727.GB118354@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7213:EE_
x-ms-office365-filtering-correlation-id: f9528dd3-dc83-426a-20a2-08dca27b5c22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?M3UzNjNrelJ0a0tWRHZvS000cWkvSlFrNS9vQmRlcXQ2N296S1FycXp1WXlj?=
 =?utf-8?B?TzhWWWpEUU5aUHZHTTBDOFNEYUZWTlRtdmRvdTNTc2xybklJZ2lhQ1FiT2Vj?=
 =?utf-8?B?UStuV1pEYTJZS3dPcXFqclk1YmFleERyVDdrQXQ2Zi9BRE5iZ295MGk5N3pq?=
 =?utf-8?B?ODBRMXNCWXlmVXRydGxnYmFjd25KNGRkRUlqYnZ0eXpkRFFoQnFDM2JiRzlY?=
 =?utf-8?B?UUVyNE9TditJTllSRmhNUkhnd2VDbVVIQXliRVVZT1JzMVN2SitoeXpNREcy?=
 =?utf-8?B?UWlOOVZiZ3c2TjZFUGQ3b0JqT3lUbUdJS281VjdpeWV4Mmtmd1VzU2pPMXVV?=
 =?utf-8?B?YUhjaFl4bkwzb1RRdnE5MWY0MkNScUgrN3pKT1NzdjFSL0VhRnQxTGpaVzdj?=
 =?utf-8?B?ZFhmQ0h4TGRPVEE1MlJYMUEzcVlHWlZsWXJWTEpkLzNsRjZGTkllQ0xNTmQw?=
 =?utf-8?B?cWdCZ1RSNmcvNk9CMGovRjkxQkNyKy94cjY4d2pSOUhsS2Z0cmZncFAvTHFu?=
 =?utf-8?B?MFlGbTNwRzR1ZFAwV2QxN05ZbHRGeHJwOFZNS21MUGJESnZHVnZOOU1hYi9z?=
 =?utf-8?B?c1F5Qkl5V1JiaEFrU3ZiZEpTRjlkNXBaVnQzeUlLWDg4d1d1dGZJVENhcjZE?=
 =?utf-8?B?ZitUa0ZjTXB3RGJIMzNNSVhIQXVBdm1KS0JOMGQ5ellKd1ltYUlZOEZidEI0?=
 =?utf-8?B?YWY3cXRDVHh2WjdmblhnVnFaZGlUNHRVdm84RG9FOTdlTzFGbjQzdVJzaVdk?=
 =?utf-8?B?OTZZMGJLV2tZcm9Kd0lMN0xjMnNsWU0zVW01MUl0Z2wyT0hrRGNYTHBlaW5O?=
 =?utf-8?B?aFhtTG9mQWd5aHRVdWI2TEZMUW9CNS95eGhKYlZ5Rll0QkRsOHJES0d2bnJv?=
 =?utf-8?B?VGVqWCtVVEIxNTdxU1lSd25MRUNBWGFVQW9rZEl3M3NKdmFwRDZGRkI5eVM1?=
 =?utf-8?B?WjdLY3BqT1c0SE9OQlVlaUpyTWRzcmFoZ3JmT0srZWd1ZS9ONzRLL2MzMUI3?=
 =?utf-8?B?UjRXRm1NMElWU0pIdUFtSkQyQ1VjNjZqQWdQNXJIQmNXZi9FaHVETGhkZHVN?=
 =?utf-8?B?SXdqdC8rNWxzZURXSzVDellGclNxU3BhU2NRbWE0cC9hZFNaNEpsSnlrYUNY?=
 =?utf-8?B?NHkxZEx2ZmUwQmdmOXY4TXdVOVJwVHBJUG1IdTBiN1Zhamt5UUcrOUFMZnNn?=
 =?utf-8?B?c1lTM0lVSkdTUDlMb1hvcm5EalpVK0djUHhjbUxEaGlORGhyRmxRcHRvU1NT?=
 =?utf-8?B?Ry9GZ2hmMkFzSERGTDBlZGsvZmlFbVpjOEZaQmV6TEdhaGkyUmxWY2tlVVNr?=
 =?utf-8?B?ditmazgyVkdvV3RmOEx0RTZEdGExNXlsUWlKMkxrUnJQS2diNkh0OCtyNW9U?=
 =?utf-8?B?TFI2YzBGcVdhdDd6a0M2bEtQV0lqVHppSXE2cktmSElKUm9UdmZ3RzFRU0My?=
 =?utf-8?B?MEw1NU5YbGhYM1RSa2wwZWNQc0FEazhqUTBvemc1UVphYkNXd0g0bDdEOUhK?=
 =?utf-8?B?OFlzWkJSZ29KM3JmQm5TbFhSY21DWFg2dDBKZGZSakZhM0JRMFJzUWRjdW5z?=
 =?utf-8?B?dHdXQkE1SEE1UlpCdTgzaEdxVkNrazlJcjk3NzJ2bXFKQ2J5cllRRytFakJN?=
 =?utf-8?B?dVE3aDBmcEhjSTFrWE44VG5SZFlBbVZPUFc5eUQvdVJMUWNvQm0yK3hGdkZy?=
 =?utf-8?B?RUduNXBJSmVlejZTcGpxNFVGT0pYUVJ3eWYzenFCN1EwTG5IdTdkWTZONk45?=
 =?utf-8?B?WDJvT3dwbnNxeDZmc2pzc28yeVhra2NzVkZpUUI5V1ZCWk9aRnRTaCtPb3RT?=
 =?utf-8?B?RFdLOGVDMFdzd2tMaFU0cFJWdW1aQXNheVJ6bElVcllOUCtUc2d0QlNMSXJR?=
 =?utf-8?B?S0JJWndvUnJsMnNaZWQzWS90TDFjUjhIekx4VTFxd3ZmRGc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q3JuZXIvdm12cHVucHBrd2trTjlza1BDb2EvREVHYmFQQlhWdjJ0d0lQTVFz?=
 =?utf-8?B?OVg1dGJ4WldGOUhDeDdxTzRvL05PbnpFdktFKzFISW1Bd0l6VXI2aUpJYnNW?=
 =?utf-8?B?MjdUV0V4SU5LcmRXQzBnbGMvbERDMWlqSmE3aWZvRENqTlRBajlDcGFwK0tN?=
 =?utf-8?B?UzhGVTNLb0tUV0JMMjBnMHVGb1VRMWZGeW95eGdnL1J6cW1mVHhudU4wWHQv?=
 =?utf-8?B?TGYyV1pMRHBHREo4clY2VzNCVDVQdnlmRnB5VnpNK3EvMHo2N3BzSTJ0TDRI?=
 =?utf-8?B?ZG05dlhwbGdwK3dzb2hCQldaQ1FYSEFOL1BPYndYcXo4LzVJY3NuVDhiMGla?=
 =?utf-8?B?aXp6VnQ1c1YxOWtKS2ZDbmNTR1J0UlBEZzNKbk15eTNwZzd4VTJqT2dudjJU?=
 =?utf-8?B?YlJzSWY5dFVZc1MxeVp1T1FVYXBUbHplcjJ4aVpGVjlVNWRZa0FBajBiaEFQ?=
 =?utf-8?B?RWtxSnhPVFVNSjlRaW9vbHRZRVEyNnY1clFaMldabzN2cG5XTEdUR3FyM0Ir?=
 =?utf-8?B?enFyeG50bDVhK0J1c1VLUXBzZTd6TndvUDNhclE2eCsrVGtPdHNnWDgzdjRG?=
 =?utf-8?B?UUV6enI4MGJxTTVkT1d2cGVjRkJmUzhiNTA5UlhYYUR2LzVqQkN1emNqS3lG?=
 =?utf-8?B?SDBTbHQralptWURHKzhnc2lBa1VQMVJtY2hCSldNeVFhV25qVUpuRDQyNUxD?=
 =?utf-8?B?ZVZFSFhOMXlQcFdYL0pXU2pSc3VycVVldjZIQ2lOM01NVStZZDcxWkp5NEhY?=
 =?utf-8?B?MG1DeU9JY3JKdHlRU0pNU2grOEFLbStwT1o1ajZnUlpEMTZ0R0pZUjdIOHNh?=
 =?utf-8?B?L05jcVI0UU1RRFh1U1NyUjBCaS8zN3NWSEZTQytHd1hzU2VDZ3dFQ2thMThY?=
 =?utf-8?B?aUNIK2Vra0lkbUYvdUU5MEhuVWF6dVQ0NFJoTTJSd1Y2TURzV0xvNmg1QjlE?=
 =?utf-8?B?M2Z5RnVoRVgrdnM4V1F4UG1ieDJ2eStTVmpaSWZ3NmcrK0FCY2xGaG52MWNL?=
 =?utf-8?B?Vmp1OFJBaHBPdGw1WktjT3daN1NvaDZWdDNTZStBZHIyK2VBVXBRS3d4Wjc0?=
 =?utf-8?B?M0VRcHpsQmg2L0RvQnZsdEtkaTY1aUhFeE45cHBGK3ZKRkhnSVlBNk10MXFD?=
 =?utf-8?B?enF6ZUtzMG5oaUZGOHNoMHRoQys1SW5EaXR6MXlHWHd3R3plcWNJZnhYVG5N?=
 =?utf-8?B?Qkl0NE1YNHJqWW5yRWpzUkRCL1ppcGVUWGlHQUVlQU9CQURGamUyaUZoRGFS?=
 =?utf-8?B?enhvMlZzQzVLeVBBckRBWU5oTWpmeUpkSlY2NXpHWWQzUnZlYTkxbWZsaEhj?=
 =?utf-8?B?dmhGcFMrU0p1R3ZZdGlGRm1zQ0lFZEhwZlZSYlBxQTAzZS9mcmY3N2dVRnh2?=
 =?utf-8?B?L2VQMXdCLzJqVmRWQWRNZ3Fmbm9kbzZrWjlFWE8zbkw4SGVYblFQRVY0V3FV?=
 =?utf-8?B?c2RGTy9ySUJJRktlKzJoWHZyZk1aYXd4amc3aUdqMVhHaStjMU1LZzdyaUZN?=
 =?utf-8?B?S2lnUENVYmYvbkFsc3ZFdVArU2Y1WHA1dFNRc0tBUWRvdUg4SllRRnJsaFg4?=
 =?utf-8?B?VThZOHdQL0lPWTBYdXgzWHlxSWhXV3ZJUGhyY1EweXZjUkxVRU9rMDJDWThM?=
 =?utf-8?B?MVZ4MGdJU1JYS3FMbzRFeXc5TDQ2MEJyR0RTMUNUZFcyZGxRdW1HaktqNU5J?=
 =?utf-8?B?d3lsTUhNWkZQcEk2U0FFcS9RaEFJTmR4SGlDVjFOMFplaFJsbHJYeWRKQjFp?=
 =?utf-8?B?NE9SRVBrT3RoVHVlTjdwbmwwWmRybW55cXRXUXE2WE0rN3U0Z0hXZUVzelRN?=
 =?utf-8?B?bHEvVGZhMk5ILzVRWlNtOXBIK2kzdGI1VWJjRElZYzZnUlY0QVRBaGV4Z2kr?=
 =?utf-8?B?L0Z1SElERi90azNxWVJxYTJ2dkRzWFhrZ1QraXEzeCtPamlVWmJNWkl2cjlD?=
 =?utf-8?B?NUdSZUozL1R1N3B1WUQ0MVdLcnhPZlNkN2RaemtPU1dORWdxWHFuT2gxRDRO?=
 =?utf-8?B?dTJiT1BNOEYrRHdRN3V3TVVNS1dsUzBqeldJbjhaQVAvNmlrR21LNWpEV0FR?=
 =?utf-8?B?c1ZoVlJpQ0RPbm9JOHI3MnRvWVAxcERWaWJPcmE4bUoyMTZDcWo3ZGYvd1Jk?=
 =?utf-8?B?cDU0Z3R6eXRQRDF2aTI5eWhLSnBWS3JqTWwwb0s0aHQySExFcHFxeG15R1hh?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C23169CD8266DE4DBD744D4562ADD577@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RPwRQApsGUFnPveikdopKQMoNN6DDb8trJtMuooOV0+7ze/mYqBW8zDHRu4SrZj28dvjfd6afLLf7M8SiLrzWeckscySQ7VKH1gho8s8WmgdD+86RgENqp7AOtOQU2jGXa4nI/eC2DbO3JLoxfzfU3Jzq1iFDFur9Mxz5+qxH+7lH+/BwNaqB16mrZ5QDcwCL/hLWQFp3ntxlYhlIjYndmQVnuzF4QjVI89hb5Kz5Fj5XVwL1toaPE9kIUYzARVOC9uz2XB6HXi0zKHiic13NQSJtODy0DRP5shjYC789+TdZ9O9BvX6MVcTwmASKDzsC2ALLJyZBuM6jF3VZfBReTeVPJmob84N9a/HtfmI6cT0HMHuCmds3NVOj+y3SBoYJhx/8w5FeIV2GV/3VCAbZK6CjvC7WGST+H9PEpmvN6n3M8trpIdX7zEnNeavQwSe/bZ3xyEB2dAgIOirlMhiZnJ0CAwAf+Jy7gJyFO43Ejd1m7Urc23hs4aJJoAfbgiZa02Nnoe43qgVmPHkbJsJfVzPgX2PnsT0XiZ1jqEHNOFtq1Kzfo4S8Qadm4UDngO4aJG/EoaAyStCcWBL3ZLEZrJ4ngbTDGaPDgGGTDvqHVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9528dd3-dc83-426a-20a2-08dca27b5c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 14:03:08.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+IQcvKlT5BoJkA0I8Ruh+78FyWv8t8Qy9mnBhGaxhe6Zoy4VPR2rfn583HUmdAIZe3CwCzYLliEE1Jscft/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120095
X-Proofpoint-ORIG-GUID: Cu_GDPnMkVDdLQNdvwCvbR213jBdv-cd
X-Proofpoint-GUID: Cu_GDPnMkVDdLQNdvwCvbR213jBdv-cd

DQoNCj4gT24gSnVsIDEyLCAyMDI0LCBhdCA3OjA34oCvQU0sIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToNCj4gDQo+IEhpIGFsbCwNCj4gDQo+PiBPbiBGcmksIDIwMjQtMDctMTIg
YXQgMTY6MTIgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4+PiBPbiBGcmksIDEyIEp1bCAyMDI0
LCBKZWZmIExheXRvbiB3cm90ZToNCj4+Pj4gT24gRnJpLCAyMDI0LTA3LTEyIGF0IDA4OjU4ICsx
MDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+Pj4+PiBPbiBGcmksIDEyIEp1bCAyMDI0LCBKZWZmIExh
eXRvbiB3cm90ZToNCj4+Pj4+PiBPbiBNb24sIDIwMjQtMDctMDggYXQgMTc6NDkgKzAwMDAsIENo
dWNrIExldmVyIElJSSB3cm90ZToNCj4gDQo+Pj4+Pj4+PiBPbiBKdWwgOCwgMjAyNCwgYXQgNjoz
NuKAr0FNLCBHcmVnIEtIIDxncmVnQGtyb2FoLmNvbT4gd3JvdGU6DQo+IA0KPj4+Pj4+Pj4gT24g
U2F0LCBKdWwgMDYsIDIwMjQgYXQgMDc6NDY6MTlBTSArMDAwMCwgU2hlcnJ5IFlhbmcgd3JvdGU6
DQo+IA0KPiANCj4+Pj4+Pj4+Pj4gT24gSnVsIDYsIDIwMjQsIGF0IDEyOjEx4oCvQU0sIEdyZWcg
S0ggPGdyZWdAa3JvYWguY29tPiB3cm90ZToNCj4gDQo+Pj4+Pj4+Pj4+IE9uIEZyaSwgSnVsIDA1
LCAyMDI0IGF0IDAyOjE5OjE4UE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gDQo+
IA0KPj4+Pj4+Pj4+Pj4+IE9uIEp1bCAyLCAyMDI0LCBhdCA2OjU14oCvUE0sIENhbHVtIE1hY2th
eSA8Y2FsdW0ubWFja2F5QG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4+Pj4+Pj4+Pj4+PiBUbyBj
bGFyaWZ54oCmDQo+IA0KPj4+Pj4+Pj4+Pj4+IE9uIDAyLzA3LzIwMjQgNTo1NCBwbSwgQ2FsdW0g
TWFja2F5IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+PiBoaSBQZXRyLA0KPj4+Pj4+Pj4+Pj4+PiBJIG5v
dGljZWQgeW91ciBMVFAgcGF0Y2ggWzFdWzJdIHdoaWNoIGFkanVzdHMgdGhlIG5mc3N0YXQwMSB0
ZXN0IG9uIHY2Ljkga2VybmVscywgdG8gYWNjb3VudCBmb3IgSm9zZWYncyBjaGFuZ2VzIFszXSwg
d2hpY2ggcmVzdHJpY3QgdGhlIE5GUy9SUEMgc3RhdHMgcGVyLW5hbWVzcGFjZS4NCj4+Pj4+Pj4+
Pj4+Pj4gSSBzZWUgdGhhdCBKb3NlZidzIGNoYW5nZXMgd2VyZSBiYWNrcG9ydGVkLCBhcyBmYXIg
YmFjayBhcyBsb25ndGVybSB2NS40LA0KPiANCj4+Pj4+Pj4+Pj4+PiBTb3JyeSwgdGhhdCdzIG5v
dCBxdWl0ZSBhY2N1cmF0ZS4NCj4gDQo+Pj4+Pj4+Pj4+Pj4gSm9zZWYncyBORlMgY2xpZW50IGNo
YW5nZXMgd2VyZSBhbGwgYmFja3BvcnRlZCBmcm9tIHY2LjksIGFzIGZhciBhcyBsb25ndGVybSB2
NS40Lnk6DQo+IA0KPj4+Pj4+Pj4+Pj4+IDIwNTdhNDhkMGRkMCBzdW5ycGM6IGFkZCBhIHN0cnVj
dCBycGNfc3RhdHMgYXJnIHRvIHJwY19jcmVhdGVfYXJncw0KPj4+Pj4+Pj4+Pj4+IGQ0NzE1MWI3
OWUzMiBuZnM6IGV4cG9zZSAvcHJvYy9uZXQvc3VucnBjL25mcyBpbiBuZXQgbmFtZXNwYWNlcw0K
Pj4+Pj4+Pj4+Pj4+IDE1NDgwMzZlZjEyMCBuZnM6IG1ha2UgdGhlIHJwY19zdGF0IHBlciBuZXQg
bmFtZXNwYWNlDQo+IA0KPiANCj4+Pj4+Pj4+Pj4+PiBPZiBKb3NlZidzIE5GUyBzZXJ2ZXIgY2hh
bmdlcywgZm91ciB3ZXJlIGJhY2twb3J0ZWQgZnJvbSB2Ni45IHRvIHY2Ljg6DQo+IA0KPj4+Pj4+
Pj4+Pj4+IDQxOGI5Njg3ZGVjZSBzdW5ycGM6IHVzZSB0aGUgc3RydWN0IG5ldCBhcyB0aGUgc3Zj
IHByb2MgcHJpdmF0ZQ0KPj4+Pj4+Pj4+Pj4+IGQ5ODQxNmNjMjE1NCBuZnNkOiByZW5hbWUgTkZT
RF9ORVRfKiB0byBORlNEX1NUQVRTXyoNCj4+Pj4+Pj4+Pj4+PiA5MzQ4M2FjNWZlYzYgbmZzZDog
ZXhwb3NlIC9wcm9jL25ldC9zdW5ycGMvbmZzZCBpbiBuZXQgbmFtZXNwYWNlcw0KPj4+Pj4+Pj4+
Pj4+IDRiMTQ4ODU0MTFmNyBuZnNkOiBtYWtlIGFsbCBvZiB0aGUgbmZzZCBzdGF0cyBwZXItbmV0
d29yayBuYW1lc3BhY2UNCj4gDQo+Pj4+Pj4+Pj4+Pj4gYW5kIHRoZSBvdGhlcnMgcmVtYWluZWQg
b25seSBpbiB2Ni45Og0KPiANCj4+Pj4+Pj4+Pj4+PiBhYjQyZjRkOWEyNmYgc3VucnBjOiBkb24n
dCBjaGFuZ2UgLT5zdl9zdGF0cyBpZiBpdCBkb2Vzbid0IGV4aXN0DQo+Pj4+Pj4+Pj4+Pj4gYTIy
MTRlZDU4OGZiIG5mc2Q6IHN0b3Agc2V0dGluZyAtPnBnX3N0YXRzIGZvciB1bnVzZWQgc3RhdHMN
Cj4+Pj4+Pj4+Pj4+PiBmMDk0MzIzODY3NjYgc3VucnBjOiBwYXNzIGluIHRoZSBzdl9zdGF0cyBz
dHJ1Y3QgdGhyb3VnaCBzdmNfY3JlYXRlX3Bvb2xlZA0KPj4+Pj4+Pj4+Pj4+IDNmNmVmMTgyZjE0
NCBzdW5ycGM6IHJlbW92ZSAtPnBnX3N0YXRzIGZyb20gc3ZjX3Byb2dyYW0NCj4+Pj4+Pj4+Pj4+
PiBlNDFlZTQ0Y2M2YTQgbmZzZDogcmVtb3ZlIG5mc2Rfc3RhdHMsIG1ha2UgdGhfY250IGEgZ2xv
YmFsIGNvdW50ZXINCj4+Pj4+Pj4+Pj4+PiAxNmZiOTgwOGFiMmMgbmZzZDogbWFrZSBzdmNfc3Rh
dCBwZXItbmV0d29yayBuYW1lc3BhY2UgaW5zdGVhZCBvZiBnbG9iYWwNCj4gDQo+IA0KPiANCj4+
Pj4+Pj4+Pj4+PiBJJ20gd29uZGVyaW5nIGlmIHRoaXMgZGlmZmVyZW5jZSBiZXR3ZWVuIE5GUyBj
bGllbnQsIGFuZCBORlMgc2VydmVyLCBzdGF0IGJlaGF2aW91ciwgYWNyb3NzIGtlcm5lbCB2ZXJz
aW9ucywgbWF5IHBlcmhhcHMgY2F1c2Ugc29tZSB1c2VyIGNvbmZ1c2lvbj8NCj4gDQo+Pj4+Pj4+
Pj4+PiBBcyBhIHJlZnJlc2hlciBmb3IgdGhlIHN0YWJsZSBmb2xrZW4sIEpvc2VmJ3MgY2hhbmdl
cyBtYWtlDQo+Pj4+Pj4+Pj4+PiBuZnNzdGF0cyBzaWxvJ2QsIHNvIHRoZXkgbm8gbG9uZ2VyIHNo
b3cgY291bnRzIGZyb20gdGhlIHdob2xlDQo+Pj4+Pj4+Pj4+PiBzeXN0ZW0sIGJ1dCBvbmx5IGZv
ciBORlMgb3BlcmF0aW9ucyByZWxhdGluZyB0byB0aGUgbG9jYWwgbmV0DQo+Pj4+Pj4+Pj4+PiBu
YW1lc3BhY2UuIFRoYXQgaXMgYSBzdXJwcmlzaW5nIGNoYW5nZSBmb3Igc29tZSB1c2VycywgdG9v
bHMsDQo+Pj4+Pj4+Pj4+PiBhbmQgdGVzdGluZy4NCj4gDQo+Pj4+Pj4+Pj4+PiBJJ20gbm90IGNs
ZWFyIG9uIHdoZXRoZXIgdGhlcmUgYXJlIGFueSBydWxlcy9ndWlkZWxpbmVzIGFyb3VuZA0KPj4+
Pj4+Pj4+Pj4gTFRTIGJhY2twb3J0cyBjYXVzaW5nIGJlaGF2aW9yIGNoYW5nZXMgdGhhdCB1c2Vy
IHRvb2xzLCBsaWtlDQo+Pj4+Pj4+Pj4+PiBuZnNzdGF0LCBtaWdodCBiZSBpbXBhY3RlZCBieS4N
Cj4gDQo+Pj4+Pj4+Pj4+IFRoZSBzYW1lIHJ1bGVzIHRoYXQgYXBwbHkgZm9yIExpbnVzJ3MgdHJl
ZSAoaS5lLiBubyB1c2Vyc3BhY2UNCj4+Pj4+Pj4+Pj4gcmVncmVzc2lvbnMuKQ0KPiANCj4+Pj4+
Pj4+PiBHaXZlbiB0aGUgY3VycmVudCBkYXRhIHdlIGhhdmUsIExUUCBuZnNzdGF0MDFbMV0gZmFp
bGVkIG9uIExUUyB2NS40LjI3OCBiZWNhdXNlIG9mIGtlcm5lbCBjb21taXQgMTU0ODAzNmVmMTIw
NCAoIm5mczoNCj4+Pj4+Pj4+PiBtYWtlIHRoZSBycGNfc3RhdCBwZXIgbmV0IG5hbWVzcGFjZSIp
IFsyXS4gT3RoZXIgTFRTIHdoaWNoIGJhY2twb3J0ZWQgdGhlIHNhbWUgY29tbWl0IGFyZSB2ZXJ5
IGxpa2VseSB0cm91YmxlZCB3aXRoIHRoZSBzYW1lIExUUCB0ZXN0IGZhaWx1cmUuDQo+IA0KPj4+
Pj4+Pj4+IFRoZSBmb2xsb3dpbmcgYXJlIHRoZSBMVFAgbmZzc3RhdDAxIGZhaWx1cmUgb3V0cHV0
DQo+IA0KPj4+Pj4+Pj4+ID09PT09PT09DQo+Pj4+Pj4+Pj4gbmV0d29yayAxIFRJTkZPOiBpbml0
aWFsaXplICdsaG9zdCcgJ2x0cF9uc192ZXRoMicgaW50ZXJmYWNlDQo+Pj4+Pj4+Pj4gbmV0d29y
ayAxIFRJTkZPOiBhZGQgbG9jYWwgYWRkciAxMC4wLjAuMi8yNA0KPj4+Pj4+Pj4+IG5ldHdvcmsg
MSBUSU5GTzogYWRkIGxvY2FsIGFkZHIgZmQwMDoxOjE6MTo6Mi82NA0KPj4+Pj4+Pj4+IG5ldHdv
cmsgMSBUSU5GTzogaW5pdGlhbGl6ZSAncmhvc3QnICdsdHBfbnNfdmV0aDEnIGludGVyZmFjZQ0K
Pj4+Pj4+Pj4+IG5ldHdvcmsgMSBUSU5GTzogYWRkIHJlbW90ZSBhZGRyIDEwLjAuMC4xLzI0DQo+
Pj4+Pj4+Pj4gbmV0d29yayAxIFRJTkZPOiBhZGQgcmVtb3RlIGFkZHIgZmQwMDoxOjE6MTo6MS82
NA0KPj4+Pj4+Pj4+IG5ldHdvcmsgMSBUSU5GTzogTmV0d29yayBjb25maWcgKGxvY2FsIC0tIHJl
bW90ZSk6DQo+Pj4+Pj4+Pj4gbmV0d29yayAxIFRJTkZPOiBsdHBfbnNfdmV0aDIgLS0gbHRwX25z
X3ZldGgxDQo+Pj4+Pj4+Pj4gbmV0d29yayAxIFRJTkZPOiAxMC4wLjAuMi8yNCAtLSAxMC4wLjAu
MS8yNA0KPj4+Pj4+Pj4+IG5ldHdvcmsgMSBUSU5GTzogZmQwMDoxOjE6MTo6Mi82NCAtLSBmZDAw
OjE6MToxOjoxLzY0DQo+Pj4+Pj4+Pj4gPDw8dGVzdF9zdGFydD4+Pg0KPj4+Pj4+Pj4+IHRhZz12
ZXRofG5mc3N0YXQzXzAxIHN0aW1lPTE3MTk5NDM1ODYNCj4+Pj4+Pj4+PiBjbWRsaW5lPSJuZnNz
dGF0MDEiDQo+Pj4+Pj4+Pj4gY29udGFjdHM9IiINCj4+Pj4+Pj4+PiBhbmFseXNpcz1leGl0DQo+
Pj4+Pj4+Pj4gPDw8dGVzdF9vdXRwdXQ+Pj4NCj4+Pj4+Pj4+PiBpbmNyZW1lbnRpbmcgc3RvcA0K
Pj4+Pj4+Pj4+IG5mc3N0YXQwMSAxIFRJTkZPOiB0aW1lb3V0IHBlciBydW4gaXMgMGggMjBtIDBz
DQo+Pj4+Pj4+Pj4gbmZzc3RhdDAxIDEgVElORk86IHNldHVwIE5GU3YzLCBzb2NrZXQgdHlwZSB1
ZHANCj4+Pj4+Pj4+PiBuZnNzdGF0MDEgMSBUSU5GTzogTW91bnRpbmcgTkZTOiBtb3VudCAtdCBu
ZnMgLW8gcHJvdG89dWRwLHZlcnM9MyAxMC4wLjAuMjovdG1wL25ldHBhbi00NTc3L0xUUF9uZnNz
dGF0MDEubHo2emhnUUhvVi8zL3VkcCAvdG1wL25ldHBhbi00NTc3L0xUUF9uZnNzdGF0MDEubHo2
emhnUUhvVi8zLzANCj4+Pj4+Pj4+PiBuZnNzdGF0MDEgMSBUSU5GTzogY2hlY2tpbmcgUlBDIGNh
bGxzIGZvciBzZXJ2ZXIvY2xpZW50DQo+Pj4+Pj4+Pj4gbmZzc3RhdDAxIDEgVElORk86IGNhbGxz
IDk4LzANCj4+Pj4+Pj4+PiBuZnNzdGF0MDEgMSBUSU5GTzogQ2hlY2tpbmcgZm9yIHRyYWNraW5n
IG9mIFJQQyBjYWxscyBmb3Igc2VydmVyL2NsaWVudA0KPj4+Pj4+Pj4+IG5mc3N0YXQwMSAxIFRJ
TkZPOiBuZXcgY2FsbHMgMTAyLzANCj4+Pj4+Pj4+PiBuZnNzdGF0MDEgMSBUUEFTUzogc2VydmVy
IFJQQyBjYWxscyBpbmNyZWFzZWQNCj4+Pj4+Pj4+PiBuZnNzdGF0MDEgMSBURkFJTDogY2xpZW50
IFJQQyBjYWxscyBub3QgaW5jcmVhc2VkDQo+Pj4+Pj4+Pj4gbmZzc3RhdDAxIDEgVElORk86IGNo
ZWNraW5nIE5GUyBjYWxscyBmb3Igc2VydmVyL2NsaWVudA0KPj4+Pj4+Pj4+IG5mc3N0YXQwMSAx
IFRJTkZPOiBjYWxscyAyLzINCj4+Pj4+Pj4+PiBuZnNzdGF0MDEgMSBUSU5GTzogQ2hlY2tpbmcg
Zm9yIHRyYWNraW5nIG9mIE5GUyBjYWxscyBmb3Igc2VydmVyL2NsaWVudA0KPj4+Pj4+Pj4+IG5m
c3N0YXQwMSAxIFRJTkZPOiBuZXcgY2FsbHMgMy8zDQo+Pj4+Pj4+Pj4gbmZzc3RhdDAxIDEgVFBB
U1M6IHNlcnZlciBORlMgY2FsbHMgaW5jcmVhc2VkDQo+Pj4+Pj4+Pj4gbmZzc3RhdDAxIDEgVFBB
U1M6IGNsaWVudCBORlMgY2FsbHMgaW5jcmVhc2VkDQo+Pj4+Pj4+Pj4gbmZzc3RhdDAxIDIgVElO
Rk86IENsZWFuaW5nIHVwIHRlc3RjYXNlDQo+Pj4+Pj4+Pj4gbmZzc3RhdDAxIDIgVElORk86IFNF
TGludXggZW5hYmxlZCBpbiBlbmZvcmNpbmcgbW9kZSwgdGhpcyBtYXkgYWZmZWN0IHRlc3QgcmVz
dWx0cw0KPj4+Pj4+Pj4+IG5mc3N0YXQwMSAyIFRJTkZPOiBpdCBjYW4gYmUgZGlzYWJsZWQgd2l0
aCBUU1RfRElTQUJMRV9TRUxJTlVYPTEgKHJlcXVpcmVzIHN1cGVyL3Jvb3QpDQo+Pj4+Pj4+Pj4g
bmZzc3RhdDAxIDIgVElORk86IGluc3RhbGwgc2VpbmZvIHRvIGZpbmQgdXNlZCBTRUxpbnV4IHBy
b2ZpbGVzDQo+Pj4+Pj4+Pj4gbmZzc3RhdDAxIDIgVElORk86IGxvYWRlZCBTRUxpbnV4IHByb2Zp
bGVzOiBub25lDQo+IA0KPj4+Pj4+Pj4+IFN1bW1hcnk6DQo+Pj4+Pj4+Pj4gcGFzc2VkIDMNCj4+
Pj4+Pj4+PiBmYWlsZWQgMQ0KPj4+Pj4+Pj4+IHNraXBwZWQgMA0KPj4+Pj4+Pj4+IHdhcm5pbmdz
IDANCj4+Pj4+Pj4+PiA8PDxleGVjdXRpb25fc3RhdHVzPj4+DQo+Pj4+Pj4+Pj4gaW5pdGlhdGlv
bl9zdGF0dXM9Im9rIg0KPj4+Pj4+Pj4+IGR1cmF0aW9uPTEgdGVybWluYXRpb25fdHlwZT1leGl0
ZWQgdGVybWluYXRpb25faWQ9MSBjb3JlZmlsZT1ubw0KPj4+Pj4+Pj4+IGN1dGltZT0xMSBjc3Rp
bWU9MTYNCj4+Pj4+Pj4+PiA8PDx0ZXN0X2VuZD4+Pg0KPj4+Pj4+Pj4+IGx0cC1wYW4gcmVwb3J0
ZWQgRkFJTA0KPj4+Pj4+Pj4+ID09PT09PT09DQo+IA0KPj4+Pj4+Pj4+IFdlIGNhbiBvYnNlcnZl
IHRoZSBudW1iZXIgb2YgUlBDIGNsaWVudCBjYWxscyBpcyAwLCB3aGljaCBpcyB3aXJlZC4gQW5k
IHRoaXMgaGFwcGVucyBmcm9tIHRoZSBrZXJuZWwgY29tbWl0IDU3ZDFjZTk2ZDc2NTUgKCJuZnM6
IG1ha2UgdGhlIHJwY19zdGF0IHBlciBuZXQgbmFtZXNwYWNl4oCdKS4gU28gbm93IHdl4oCZcmUg
bm90IHN1cmUgdGhlIGtlcm5lbCBiYWNrcG9ydCBvZiBuZnMgY2xpZW50IGNoYW5nZXMgaXMgcHJv
cGVyLCBvciB0aGUgTFRQIHRlc3RzIC8gdXNlcnNwYWNlIG5lZWQgdG8gYmUgbW9kaWZpZWQuDQo+
IA0KPj4+Pj4+Pj4+IElmIG5vIHVzZXJzcGFjZSByZWdyZXNzaW9uLCBzaG91bGQgd2UgcmV2ZXJ0
IHRoZSBKb3NlZuKAmXMgTkZTIGNsaWVudC1zaWRlIGNoYW5nZXMgb24gTFRTPw0KPiANCj4+Pj4+
Pj4+IFRoaXMgc291bmRzIGxpa2UgYSByZWdyZXNzaW9uIGluIExpbnVzJ3MgdHJlZSB0b28sIHNv
IHdoeSBpc24ndCBpdA0KPj4+Pj4+Pj4gcmV2ZXJ0ZWQgdGhlcmUgZmlyc3Q/DQo+IA0KPj4+Pj4+
PiBUaGVyZSBpcyBhIGNoYW5nZSBpbiBiZWhhdmlvciBpbiB0aGUgdXBzdHJlYW0gY29kZSwgYnV0
IEpvc2VmJ3MNCj4+Pj4+Pj4gcGF0Y2hlcyBmaXggYW4gaW5mb3JtYXRpb24gbGVhayBhbmQgbWFr
ZSB0aGUgc3RhdGlzdGljcyBtb3JlDQo+Pj4+Pj4+IHNlbnNpYmxlIGluIGNvbnRhaW5lciBlbnZp
cm9ubWVudHMuIEknbSBub3QgY2VydGFpbiB0aGF0DQo+Pj4+Pj4+IHNob3VsZCBiZSBjb25zaWRl
cmVkIGEgcmVncmVzc2lvbiwgYnV0IGNvbmZlc3MgSSBkb24ndCBrbm93DQo+Pj4+Pj4+IHRoZSBy
ZWdyZXNzaW9uIHJ1bGVzIHRvIHRoaXMgZmluZSBhIGRlZ3JlZSBvZiBkZXRhaWwuDQo+IA0KPj4+
Pj4+PiBJZiBpdCBpcyBpbmRlZWQgYSByZWdyZXNzaW9uLCBob3cgY2FuIHdlIGdvIGFib3V0IHJl
dGFpbmluZw0KPj4+Pj4+PiBib3RoIGJlaGF2aW9ycyAoc2VsZWN0YWJsZSBieSBLY29uZmlnIG9y
IHBlcmhhcHMgYWRtaW5pc3RyYXRpdmUNCj4+Pj4+Pj4gVUkpPw0KPiANCj4gDQo+Pj4+Pj4gSSdk
IGFyZ3VlIHRoYXQgdGhlIG9sZCBiZWhhdmlvciB3YXMgYSBidWcsIGFuZCB0aGF0IEpvc2VmIGZp
eGVkDQo+Pj4+Pj4gaXQuIFRoZXNlIHN0YXRzIHNob3VsZCBwcm9iYWJseSBoYXZlIGJlZW4gbWFk
ZSBwZXItbmV0IHdoZW4gYWxsIG9mIHRoZQ0KPj4+Pj4+IG9yaWdpbmFsIG5mc2QgbmFtZXNwYWNl
IHdvcmsgd2FzIGRvbmUsIGJ1dCBubyBvbmUgbm90aWNlZCB1bnRpbA0KPj4+Pj4+IHJlY2VudGx5
LiBXaG9vcHMuIA0KPiANCj4+Pj4+PiBBIGNvdXBsZSBvZiBoYWNreSBpZGVhcyBmb3IgaG93IHdl
IG1pZ2h0IGRlYWwgd2l0aCB0aGlzOg0KPiANCj4+Pj4+PiAxLyBhZGQgYSBuZXcgbGluZSB0byB0
aGUgb3V0cHV0IG9mIC9wcm9jL25ldC9ycGMvbmZzZC4gSXQgY291bGQganVzdA0KPj4+Pj4+IHNh
eSAicGVyLW5ldFxuIiBvciAicGVyLW5ldCA8bmV0bnNfaWRfbnVtYmVyPlxuIiBvciBzb21ldGhp
bmcuIG5mc3N0YXQNCj4+Pj4+PiBzaG91bGQgaWdub3JlIGl0LCBidXQgTFRQIHRlc3QgY291bGQg
bG9vayBmb3IgaXQgYW5kIGhhbmRsZSBpdA0KPj4+Pj4+IGFwcHJvcHJpYXRlbHkuIFRoYXQgY291
bGQgZXZlbiBiZSB1c2VmdWwgbGF0ZXIgZm9yIG5mc3N0YXQgdG9vIEkgZ3Vlc3MuDQo+IA0KPj4+
Pj4+IDIvIG1vdmUgdGhlIGZpbGUgdG8gYSBuZXcgbmFtZSBhbmQgbWFrZSB0aGUgb2xkIGZpbGVu
YW1lIGJlIGEgc3ltbGluaw0KPj4+Pj4+IHRvIHRoZSBuZXcgb25lLiBuZnNzdGF0IHdvdWxkIHN0
aWxsIHdvcmssIGJ1dCBMVFAgd291bGQgYmUgYWJsZSB0byBzZWUNCj4+Pj4+PiB3aGV0aGVyIGl0
IHdhcyBhIHN5bWxpbmsgdG8gZGV0ZWN0IHRoZSBkaWZmZXJlbmNlLi4ub3IgY291bGQganVzdCBt
YWtlDQo+Pj4+Pj4gYSBuZXcgc3ltbGluayB0aGF0IHBvaW50cyB0byB0aGUgZmlsZSBhbmQgTFRQ
IGNvdWxkIGxvb2sgZm9yIGl0cw0KPj4+Pj4+IHByZXNlbmNlLg0KPiANCj4+Pj4+IEkgZG9uJ3Qg
dGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gcHJlc2VudCBhIHNvbHV0aW9uIHdoaWNoIHJlcXVpcmVz
DQo+Pj4+PiBMVFAgdG8gYmUgbW9kaWZpZWQuICBJZiB3ZSBhcmUgd2lsbGluZyB0byBtb2RpZnkg
TFRQLCB0aGVuIHdlIHNob3VsZA0KPj4+Pj4gbW9kaWZ5IGl0IHRvIHdvcmsgd2l0aCB0aGUgcGVy
LW5ldCBzdGF0cy4NCj4gDQo+Pj4+PiBJIHRoaW5rIHdlIG5lZWQgdG8gY3JlYXRlIGEgbmV3IGlu
dGVyZmFjZSBmb3IgdGhlIHBlci1uZXQgc3RhdHMsIHRoZW4NCj4+Pj4+IGRlcHJlY2F0ZSB0aGUg
b2xkIGludGVyZmFjZSBhbmQgcmVtb3ZlIGl0IGluIChzYXkpIDIgeWVhcnMuICBUaGF0IGdpdmVu
DQo+Pj4+PiBMVFAgdGltZSB0byB1cGRhdGUsIGFuZCBtZWFucyB0aGF0IGFuIG9sZCBMVFAgd29u
J3QgZ2l2ZSBpbmNvcnJlY3QNCj4+Pj4+IG51bWJlcnMsIGl0IHdpbGwgc2ltcGx5IGZhaWwuDQo+
IA0KPj4+Pj4gQWxsIHdlIG5lZWQgdG8gZG8gaXMgYmlrZXNoZWQgdGhlIG5ldyBpbnRlcmZhY2Uu
DQo+Pj4+PiAgbmV0bGluayA/DQo+Pj4+PiAgL3Byb2MvbmV0L3JwYy1wZXJuZXQvbmZzZCA/DQo+
IA0KPj4+Pj4gVGhpcyBtZWFucyB0aGF0IHdlIHN0aWxsIG5lZWQgdG8ga2VlcCB0aGUgY29tYmlu
ZWQgc3RhdHMsIG9yIHRvIGNvbWJpbmUNCj4+Pj4+IGFsbCB0aGUgcGVyLW5ldCBzdGF0cyBvbiBl
YWNoIGFjY2Vzcy4NCj4gDQo+IA0KPj4+PiBIb3cgbXVjaCBvZiB0aGlzIGZ1bmN0aW9uYWxpdHkg
d291bGQgd2UgbmVlZCB0byByZXN0b3JlPw0KPiANCj4+Pj4gUHJpb3IgdG8gSm9zZWYncyBwYXRj
aGVzLCB5b3Ugd291bGQgZ2V0IGluZm8gYWJvdXQgZ2xvYmFsIHN0YXRzIGZyb20NCj4+Pj4gcmVs
ZXZhbnQgc3RhdHMgcHJvY2ZpbGVzIGluIGEgY29udGFpbmVyLiBUaGF0IHNlZW1zIGxpa2UgYW4g
aW5mb3JtYXRpb24NCj4+Pj4gbGVhayB0byBtZSwgYnV0IGZpeGluZyB0aGF0IGlzIHByb2JhYmx5
IGdvaW5nIHRvIGJyZWFrIF9zb21lYm9keV8uDQo+Pj4+IFdoZXJlIGRvIHdlIGRyYXcgdGhlIGxp
bmUgYW5kIHdoeT8NCj4gDQo+Pj4+IExUUCBpcyBqdXN0IGEgdGVzdHN1aXRlLiBBc2tpbmcgdGhl
bSB0byBhbHRlciB0ZXN0cyBpbiBvcmRlciB0byBjb3BlDQo+Pj4+IHdpdGggYSBidWdmaXggc2Vl
bXMgZW50aXJlbHkgcmVhc29uYWJsZSB0byBtZS4gSWYgc29tZW9uZSBjYW4gbWFrZSBhDQo+Pj4+
IGNhc2UgZm9yIHJlYWwtd29ybGQgYXBwbGljYXRpb25zIHRoYXQgcmVseSBvbiB0aGUgb2xkIHNl
bWFudGljcywgdGhlbg0KPj4+PiBJJ2QgYmUgbW9yZSBvcGVuIHRvIGNoYW5naW5nIHRoaXMsIGJ1
dCBJIGp1c3QgZG9uJ3Qgc2VlIHRoZSB1cHNpZGUgb2YNCj4+Pj4gcmVzdG9yaW5nIGxlZ2FjeSBi
ZWhhdmlvciBoZXJlLg0KPiANCj4gKzEuIEFsc28gcGVvcGxlIHdobyB0ZXN0IHdpdGggTFRQIGFy
ZSBhZHZpc2VkIHRvIHVzZSBhdCBsZWFzdCB0aGUgbGF0ZXN0IHJlbGVhc2UNCj4gKHdlIHJlbGVh
c2UgZXZlcnkgMyBtb250aHMpIG9yIHRoZSBjdXJyZW50IG1hc3RlciBicmFuY2ggKGxpbnV4LW5l
eHQgYW5kIGtlcm5lbA0KPiByYyB0ZXN0ZXJzIHNob3VsZCBwcm9iYWJseSB1c2UgbWFzdGVyIGJy
YW5jaCkuDQo+IA0KPj4+IElmIGl0IGlzIE9LIHRvIGFzayB0aGVtIHRvIGFsdGVyIHRoZSB0ZXN0
cywgYXNrIHRoZW0gdG8gYWx0ZXIgdGhlIHRlc3RzDQo+Pj4gdG8gd29yayB3aXRoIHRvZGF5J3Mg
a2VybmVsIGFuZCBkb24ndCBtYWtlIGFueSBjaGFuZ2UgdG8gdGhlIGtlcm5lbC4NCj4+PiBNYXli
ZSB0aGUgdGVzdHMgd2lsbCBoYXZlIHRvIGJlIGZpeGVkIHRvICJQQVNTIiBib3RoIHRoZSBvbGQg
YW5kIHRoZSBuZXcNCj4+PiByZXN1bHRzLCBidXQgdGhhdCBwcm9iYWJseSBpc24ndCByb2NrZXQg
c2NpZW5jZS4NCj4gDQo+Pj4gTXkgcG9pbnQgaXMgdGhhdCBpZiB3ZSBhcmUgZ29pbmcgdG8gY2hh
bmdlIHRoZSBrZXJuZWwgdG8gYWNjb21tb2RhdGUgTFRQDQo+Pj4gYXQgYWxsLCB3ZSBzaG91bGQg
YWNjb21tb2RhdGUgTFRQIGFzIGl0IGlzIHRvZGF5LiAgSWYgd2UgYXJlIGdvaW5nIHRvDQo+Pj4g
Y2hhbmdlIExUUCB0byBhY2NvbW1vZGF0ZSB0aGUga2VybmVsLCB0aGVuIGl0IHNob3VsZCBhY2Nv
bW1vZGF0ZSB0aGUNCj4+PiBrZXJuZWwgYXMgaXQgaXMgdG9kYXkuDQo+IA0KPiANCj4+IFRoZSBw
cm9ibGVtIGlzIHRoYXQgdGhlcmUgaXMgbm8gd2F5IGZvciB1c2VybGFuZCB0ZWxsIHRoZSBkaWZm
ZXJlbmNlDQo+PiBiZXR3ZWVuIHRoZSBvbGRlciBhbmQgbmV3ZXIgYmVoYXZpb3IuIFRoYXQgd2Fz
IHdoYXQgSSB3YXMgc3VnZ2VzdGluZyB3ZQ0KPj4gYWRkLg0KPiANCj4+IFRvIGJlIGNsZWFyLCBJ
IGhvbGQgdGhpcyBvcGluaW9uIGxvb3NlbHkuIElmIHRoZSBjb25zZW5zdXMgaXMgdGhhdCB3ZQ0K
Pj4gbmVlZCB0byByZXZlcnQgdGhpbmdzIHRoZW4gc28gYmUgaXQuIEkganVzdCBkb24ndCBzZWUg
dGhlIHZhbHVlIG9mDQo+PiBkb2luZyB0aGF0IGluIHRoaXMgcGFydGljdWxhciBzaXR1YXRpb24u
DQo+IA0KPiBJIGFsc28gdGhpbmsgdGhhdCBmcm9tIGNvbnRhaW5lciBQT1YgaXQgZml4ZWQgYW4g
aW5mb3JtYXRpb24gbGVhay4NCg0KSSB3b3VsZCB2YXN0bHkgcHJlZmVyIHRoYXQgdGhlIGluZm9y
bWF0aW9uIGxlYWsgaXMgZml4ZWQNCm5vdCBvbmx5IGluIHVwc3RyZWFtIGtlcm5lbHMsIGJ1dCBh
bHNvIGluIExUUyBrZXJuZWxzLg0KDQpOZWlsJ3Mgc3VnZ2VzdGlvbiBvZiBpbnRyb2R1Y2luZyBh
IG5ldyBrZXJuZWwvdXNlcnNwYWNlDQpBUEkgaXMgdGhlIHVzdWFsIGFwcHJvYWNoIGZvciBBUEkg
Y2hhbmdlcywgYnV0IGRvZXMgbm90DQphZGRyZXNzIHRoZSBpbmZvcm1hdGlvbiBsZWFrIGF0IGFs
bCB1bnRpbCB0aGUgb2xkIEFQSSBpcw0KcmVtb3ZlZCBpbiAyKyB5ZWFycy4NCg0KV2hhdCBJIHdv
dWxkIGxpa2UgdG8gc2VlIGhhcHBlbiBpczoNCg0KIC0tIGxlYXZlIEpvc2VmJ3MgcGF0Y2hlcyBp
biB0aGUgdXBzdHJlYW0ga2VybmVsDQoNCiAtLSBiYWNrcG9ydCB0aGUgbWlzc2luZyBwYXJ0cyBv
ZiB0aGF0IHNlcmllcyB0byBMVFMNCiAgICBrZXJuZWxzIChhbmQgSSB2b2x1bnRlZXIgdG8gaGFu
ZGxlIHRoYXQpDQoNCiAtLSBUYWtlIE5laWwncyBhZHZpY2Ugb2YgZml4aW5nIGx0cCBpbiBhIHdh
eSB0aGF0DQogICAgZG9lcyBub3QgcmVseSBvbiBrZXJuZWwgcmVsZWFzZSBpbmZvcm1hdGlvbg0K
DQpJIGNhbiB3YWl0IGZvciBQZXRlciB0byBhY2tub3dsZWRnZSB0aGF0IE5laWwncyBhZHZpY2UN
CndpbGwgd29yayBmb3IgbHRwIChhbmQgb2YgY291cnNlLCBhbnkgb3RoZXIgdGhvdWdodHMNCmZy
b20gdGhlIFRvOiBvciBDYzogbGlzdCkuDQoNCg0KVGhvcnN0ZW4gc2F5czoNCj4gU28gbWF5YmUN
Cj4gcHJvdmlkaW5nIHRoZSBuZXdlciBmb3JtYXQgaW4gYSBkaWZmZXJlbnQgZmlsZSBhbmQgYWxs
b3dpbmcgdG8gZGlzYWJsZQ0KPiB0aGUgb2xkZXIgb25lIHRob3VnaCBhIEtjb25maWcgc2V0dGlu
ZyBtaWdodCBiZSB0aGUgYmVzdCB3YXkgZm9yd2FyZC4NCg0KDQpUaGF0IGlzIHRoZSAiaWRlYWwi
IHNvbHV0aW9uLCBidXQgdGhlIGRvd25zaWRlIGlzIGhvdw0KbG9uZyBpdCB3b3VsZCB0YWtlIHRv
IHJlYWNoIGFsbCBrZXJuZWxzIGFuZCBkaXN0cm9zLg0KDQpJJ20gaGFwcHkgdG8gcmVjb25zaWRl
ciB0aGlzIGFwcHJvYWNoIGlmIHdlIHJlY2VpdmUNCm1vcmUgdGhhbiBhIHJlcG9ydCBvZiB0ZXN0
IGNhc2UgYnJlYWthZ2UuLi4gdGhhdCB3YXMNCmNyaXRlcmlhIEkgZGlkIG5vdCBoYXZlIGVhcmxp
ZXIuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

