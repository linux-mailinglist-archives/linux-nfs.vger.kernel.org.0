Return-Path: <linux-nfs+bounces-1286-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37909837F7D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 02:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DD928D6F3
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 01:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB469627E5;
	Tue, 23 Jan 2024 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XCIfj8io";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZqMpzkt/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C986169E
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971163; cv=fail; b=UnVTGMoKrVGbHOXorPkof6qCdvxoYboR6aOPEezWSMuQvlAqMDZj3sqy6MnQKiJ+Xdez9Da8Zf1iRQ+FwgazwpktnGbTEn2WOxebjXsjgvqwb5Gr0OYWUclZMfoimxlnqBDxE8SqVM6dl7WrO3/6uBVmhKyvjJOfHjUFFxY6Ldo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971163; c=relaxed/simple;
	bh=w+BufwRrcuHQnPE3HNsMyvko74kyc8nm4eOxNsRzIFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCvSjXJJH5AvDIphP9EsLHbO/gXp1ZYfw1V1j//lw8K3Lsa64zVJyu04VumXvrJpJqUmGzP/li3rYqF6Wnb2R2w6VxN7uwZADaUMYMQAer5fwPboAf+ejslkIT9tfz1XOU4cNiZuC7BQeTbsquKFvBVjRRi6Da6O7QXvqFWe14E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XCIfj8io; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZqMpzkt/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMogNj022182;
	Tue, 23 Jan 2024 00:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=w+BufwRrcuHQnPE3HNsMyvko74kyc8nm4eOxNsRzIFI=;
 b=XCIfj8ioXkpg6eiKxTNZaxpsDUBIbJD+noLO+5G8t4fRDdHTjHdabpOhs++pjLuDAq7Q
 QeOyAugsKPcJ3zGcxgdoS82KAqonckJivs0ZgcY9O/4FhQoeDSx0vI46mw60/XQgbJaH
 a+HCEm5Wp+YCtcr32JgH4wmJCcrCXqu8gFtfUQxkPakHaQg86n1oCP5QZyjamkVRCPFg
 shEqbhLLY3AqSuNtw/h9In9vX+f92VVlCnJ3APEIrac2ojb4OqeiJTB1M1E6lwwwSXbN
 yXE5yDs4m6K6+zK2gZABgOr83spvZmNLt5jAt/Li0GKADwAaqiXhfMS60KolNOanXz35 Dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7n7w0um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 00:52:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MN0BIN016231;
	Tue, 23 Jan 2024 00:52:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32q1jeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 00:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNfW7QHDVjSlstPPR6IbpUGktj3ch+S8zW6uYnrLqRNQ/Gdab6Gr+18VSarYkOMcBsAgbbxuYYASH7nBfLZufNeN7/w9kebamci8icSg9+9GCfxGEoZyscXFbKkr3bacF4Xsd6Jf42JPpkr+vGuk5nhIXSJtU8SobKoKk+zF0tAfZdynupARUz7nzXgKdDlWeXZQT1eR2zjdH76ophDrmlaUCqxlb+7CwJKB/8gMBZu8Pht/goIn9jR43nZQW2aC7hvb25idmVgtLMeSp9ZzEe8G8TKPnxq1H13FPZOf5Ji1oOGnOusmKHLLST7luPUf6xZQ+isQ1elh6IgeVR/NQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+BufwRrcuHQnPE3HNsMyvko74kyc8nm4eOxNsRzIFI=;
 b=i/u0r1uA0XEWvIDeRgrr3jGibbY3c6omBBX5dDKJIbnRrAjCQo2IHNEgmIaib6+Rmi0QZ3WlozDjbLGpGUtCUC8sPdIpYZeGOgaBNlpuOhVrvBsH0YbKr6MzV1jciLOSOR109vYp1/GxrrJ8LCB5sqGDHe7kXdod3SMz41uG6G63N8+N7MN6kD0Peq3p83PSUQKiy7Jh3L04n5AwBSky/b2pADc2/UaNoJIpRF8xfp5dLR/u4GPc6BuR5w93WcIiAZNF3qGuPtKwDxyeuNLQVr6S4NypaWV4NcClIdhoiBuQryehfoo3Wcq6gFicn4c8XZla0xuY3xazEwovPT8DSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+BufwRrcuHQnPE3HNsMyvko74kyc8nm4eOxNsRzIFI=;
 b=ZqMpzkt/3j0JsbsTiwjTGXDFeDWEZtmAz5VveG8zF7cmz4sIqtuooIhQs9cCY1pnKGnZvZITYCK0ZrQSc+Lz2aFlsZztfxZrTzm9RRAEo1CnWm4/ADCXZaG9n2b5NaVWrG/IoLZCcuk1Db9CwPBP4C4ER9Jv5Q5zQA9/wTjf340=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5775.namprd10.prod.outlook.com (2603:10b6:303:18f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 00:52:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 00:52:21 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Olga
 Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix RELEASE_LOCKOWNER
Thread-Topic: [PATCH] nfsd: fix RELEASE_LOCKOWNER
Thread-Index: 
 AQHaTOdBtLll/fA4n0ueXAr70m4RmrDl5I+AgAB9jYCAABWSgIAABNOAgAADnACAAAmEgIAACVoA
Date: Tue, 23 Jan 2024 00:52:21 +0000
Message-ID: <9F7F2E11-B859-44BA-B286-3605633623E7@oracle.com>
References: <170589589641.23031.16356786177193106749@noble.neil.brown.name>
 <Za57adpDbKJavMRO@tissot.1015granger.net>
 <170596063560.23031.1725209290511630080@noble.neil.brown.name>
 <3162C5BC-8E7C-4A9A-815C-09297B56FA17@oracle.com>
 <170596630337.23031.332959396445243083@noble.neil.brown.name>
 <D841692A-1D9D-49F9-B497-AA40B975C5E9@oracle.com>
 <170596912197.23031.1418374526012433512@noble.neil.brown.name>
In-Reply-To: <170596912197.23031.1418374526012433512@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5775:EE_
x-ms-office365-filtering-correlation-id: 91e6691a-acf2-4d18-4615-08dc1bad8e93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 iGtSbrOx5fK1ZY/Kp4Skfx/L7eOF8eLDrG7qpoyK2a0fikc+V3pIWBPQZkDszsTVuvdXoo0v4plXvKM8xZ4hyFTdjoWgCtB1RR3FrUorBGf8va6Gc2thxr34pIprdw3cOIE9tIF43L0jtaBj3NqN8ufvZPLTwAmk0YHcMHMvM6CqVQLily6sad8rdYTYuCFCyUK5yUG5YNqEZtKAhiNjiN/zIJINyNJU4Rl/u07rEe8sfLZf/BtyleD+xrGC6k5kCusEgQOjYSIHJ7Bs2nghipDjXIg0cH6ZGWkcoNRXL63kGPYYMoMS8LW4c8w3eye3ull4S50LzUJ6qfRInk2P9o545Ra5uzuxZm3bEYdqFH8R1j3/YHrvfu9oEtNd6aoTVRaaFOHwFTa7TXhWmRHhnOWsil4ebkBy990ikFYEOicKwbwMmWG38lgTNV5ECi2+x1JGdxT8q4WGNaoMxPlLt6u9NO3ZFDyeiIg2Iue5summuG296Kqiyz3HZPqilms393fOhS6zYLPINEFhEBntk2E5TJu/qv5OjWnD2unzW1s62lIFn0aMp2uXH4xXHGXgtSnFC5HiJ2J4SMqdZKoTHC/rgzoZe6HY1n/NijjfzL7P+oWg74NHpGMskh01BAj6SKUBzIQPpc4hln4IkAFqIA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(71200400001)(6512007)(6506007)(53546011)(86362001)(83380400001)(38100700002)(33656002)(38070700009)(122000001)(36756003)(2616005)(4326008)(8676002)(8936002)(5660300002)(2906002)(41300700001)(966005)(6486002)(478600001)(64756008)(6916009)(316002)(54906003)(91956017)(76116006)(66446008)(66476007)(66946007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N3k3dmJMaUhTTGpqQWdhNzR2UGhrYzhaZjg0cHVKaFJSME13SnZIeFN3Mmww?=
 =?utf-8?B?Y2lDVC9KSDRuWTVNU2llYWM0MHN6b3NtUVoxWXg1UkYwQWNRUmhUcWdlM21O?=
 =?utf-8?B?TTlWc1MvcCt6MDJZV3kya0ZWSkVva3JuRG8xMFgrc1JKdm9SVS9BWjVaaWl3?=
 =?utf-8?B?RUxUUUFOdjNWdkpNeXo5ZWY1UUxhN1dQUEdvQ1dDVlNwcFFvQ096YnZoTk0w?=
 =?utf-8?B?a2dkaWQ5Uk1FY3Z3cndWd2FtNzRQb0VScnVlRzBJNG16NmlXZVVHRnJ2QXJN?=
 =?utf-8?B?Qm9OY0lwZWgvdVQrczlJMnVxYWlPZ0NzNDM1aDRKdjdnalUyNFpIbGx5TmdZ?=
 =?utf-8?B?VjFNVGlaaElQQXJVUDllaEtqU2JOcmcvc0MwV0YvUml1Vk44UkhvUDZKc0hN?=
 =?utf-8?B?Y0l4eFZUUFNxRWRjRWJ3a1djazVxQUxYV1I1WWp5dklXVHhtNk1pY1ZueWht?=
 =?utf-8?B?ZWhQT3dYK0dJa2Yxc1pxZjF5bjFUU3Yvbko3R3h4Z0VRcUlnMFNQeTdvMkMz?=
 =?utf-8?B?VVpFUEplUEE0RGJXRG1HOWp3cUlPdW9wSnUyZjMwNEZPYW9tdG1xd054U2xu?=
 =?utf-8?B?K2tHQ1NZdVF0M21RQjJUNm80bUQ3cFd6VGQ5akpyQmlZK0tKZ1F2d0tPZXZi?=
 =?utf-8?B?SmtLeHJLWjFuRnR1UjV5STh4UkUwTWFjMWRRREZYNkcvR1hmZ1dVTTMvcG9i?=
 =?utf-8?B?UlNxMjlGS3FZYjBUZHZ1QVdQVTJlSElCc0ZNb2s3QTRUL3oxOTZEVkJiTUR1?=
 =?utf-8?B?OVZ4b1A0MFdIOU1BWm9kVTRSWldQNWNQOUY4SUJpVXVNTkpCNElMWGw3MTJs?=
 =?utf-8?B?VGd6SG8vQjRRaTdyNzFXa0ZXaXFuRnF5eVpPZUVML2lvQmxQckllc0paR21l?=
 =?utf-8?B?MUhuR21nWkJhVGE1RWE0YzIySnpFbjhyZzZWMjJIdWlPcHRsZ3FTMDZlQzg4?=
 =?utf-8?B?ZCtvV3ZBQzd6UFV5L2xCMzZTdHZKcnJVRUMyT3JJelRQYWJaT3pWNWlZT2Fm?=
 =?utf-8?B?SllEWW91d3kzU0o5K3N1TFMxUmthYnZjU29ESm9VYlJmb29kU1dPWlBvZnEv?=
 =?utf-8?B?cndYbU91OThVQWhNY1RHekF3citaVVBLTHJncU5CWWp6WHZzYUNxWDdjeGpv?=
 =?utf-8?B?ZVB4bnV1N25DV0hvWjVrOFRGeUsvd3BicTZuWmJseEp5QTFnRDg3V2x2bG1q?=
 =?utf-8?B?eGF1TUVJUStkMVhEbDNjQ25KZTRRSnU1WFZ5SWNybUZBYTJrLy9PY0tqV2E0?=
 =?utf-8?B?RnhROTZBRDRCcjI0Wm13b1Q4QkdwOFBmYUJtYUxrVTk4SGY1aWJxdm5FNHV6?=
 =?utf-8?B?bk5NV3ErYkZvK0Faa2NhRlpLTmxiY2lGWGY2UmdHWTY3VDRwR1JGWEdCTmlZ?=
 =?utf-8?B?NE5pUXAvS0h0aEU3UlI4NFY5Rk9rODYwRGx6K2tKVmFCL0xNOWN4VUhZZy9k?=
 =?utf-8?B?QUZ0dzhsWjZmN001cEUzckRoWjh6U2QzTytPM2lXbksvK1ZSQ2RJT2M3T2JJ?=
 =?utf-8?B?SnJNV1VXOTJuQ3g0ZUxQeWx5a0JuWmduNlRCUDVqV2ZOL2lJRlRBVXkzaTgx?=
 =?utf-8?B?cDlwalBPNWhjMlQyYi84cHl3Q3kvUlUrV3J0Q2Rpb0N6TW5UcjlBM1VJZDlk?=
 =?utf-8?B?SlpFR2FmellSQjdydWY5MWtrWDBWVE1DQzR3RmxVM0hxZy82M0xXZHpNK3FR?=
 =?utf-8?B?cmZHUURQcE9iNURORjZGU25xTkw1djJqTWptbFZCWlU2QXo3S012WUZoSXNv?=
 =?utf-8?B?RTByNDlwcG5IZUZUMmRmWWpoeUxmQWowM3ZoZllWWlphbkNhRHI0bVVUVXVr?=
 =?utf-8?B?dGlwOFkrb3JMUkhrMlVGRWhBRTVoU2dQend4NmVsVDgwbGJNcks2NG5tV1Rj?=
 =?utf-8?B?c2pxdE1leHI1S1g5OUZIZGRid1ZsYlRqVmlPa0c1ZWpjR1VoN3Z2QjJ3N2lj?=
 =?utf-8?B?Yk5vZDk1MWlBb3hLUThweWhadHlyWEI5WjZwVkpVc2JZK2tHSTF6ZVZXejl3?=
 =?utf-8?B?OHBnOEdhZ1RvNEh2NXZWN1JBRFFuK0lJcUtkQ2E2OW5OYnVicFdvNkg2cFhV?=
 =?utf-8?B?NUlpYkxSUkp3ZjZjTkZndzUzOU54SnlSd3dXZ0d1SklCbWFxRGc0Nk9QMFFv?=
 =?utf-8?B?MktXR1pJSWVJSHVqbTNOVTFKWFVnSDFJNmg1UWRBS2Y1YkRubmZFU2VvM0Jl?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EEDCF1C7BF4524D9E266120C221C13F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mq884CxauTJ67rM0EaLfuUb4rtRMA/OZpVFxZiKE8zYUL6O9d8/5h981inK6OilLjc44eny4V3N1jsDZlqhNHbrC6Fb5+gfLxEtbnQ0IjDb536BPjU50Y14g4LQy28xy4nYu1bpGBgSooHCQKFf91Mz/dOq+4VZ35gmEvcCUuq3Ao3v1puednwyAu4JC+xRf6XoPgz4gNZ98po1cAnHrc3fnNLXPitvmDiuncJdK2DQUSna66n2Rc3/2hE98bgzP5BJpGp2Tn31Lpx0bJUJKPE13UxUevpPJqOMSDoAYsuwnQvjKGHtgHRrJXQRQ531zsIAA9zWQrAPeXzFdRF+tkyAC/Ra8APh5dX2L7KZPdVKXwLJ3CBa71BEqWvZDlnXjfHPP9yvD8asUx6F3KcbujV8rff7n3ZlMnPs60mAt1jpbA4YQHJ8Q185UVEnXamBw33+Izsp7zXXc3WBA/z7I0L8hMIzfn6gEnExwYGKKPwFlp5PHPHAVpUchmuaz32XxRtUumq5Eh8WQmnkDK+2ckmJOuvONhswRVcK98CG77dGT9a1/f6bHeF5y8MyIsGqncshYMz9bXANO56U1OVR/aoRIjFZsqvQUOaHb+pGbhrI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e6691a-acf2-4d18-4615-08dc1bad8e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 00:52:21.4836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRfWFYYvj54zjHwN6nRDbqurywDQHiXBYZVFx06nIMN2pqfDhsiL35+gbXS4Ls6w1eYc7dQZc1jQP26+xZR32g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230005
X-Proofpoint-GUID: AOg03EFKUO-LVxcGk6iAAS3dTJ7UFGRj
X-Proofpoint-ORIG-GUID: AOg03EFKUO-LVxcGk6iAAS3dTJ7UFGRj

DQoNCj4gT24gSmFuIDIyLCAyMDI0LCBhdCA3OjE44oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDIzIEphbiAyMDI0LCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEphbiAyMiwgMjAyNCwgYXQgNjozMeKAr1BNLCBOZWls
QnJvd24gPG5laWxiQHN1c2UuZGU+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFR1ZSwgMjMgSmFuIDIw
MjQsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gSmFuIDIy
LCAyMDI0LCBhdCA0OjU34oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4gd3JvdGU6DQo+
Pj4+PiANCj4+Pj4+IE9uIFR1ZSwgMjMgSmFuIDIwMjQsIENodWNrIExldmVyIHdyb3RlOg0KPj4+
Pj4+IE9uIE1vbiwgSmFuIDIyLCAyMDI0IGF0IDAyOjU4OjE2UE0gKzExMDAsIE5laWxCcm93biB3
cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoZSB0ZXN0IG9uIHNvX2NvdW50IGluIG5mc2Q0X3Jl
bGVhc2VfbG9ja293bmVyKCkgaXMgbm9uc2Vuc2UgYW5kDQo+Pj4+Pj4+IGhhcm1mdWwuICBSZXZl
cnQgdG8gdXNpbmcgY2hlY2tfZm9yX2xvY2tzKCksIGNoYW5naW5nIHRoYXQgdG8gbm90IHNsZWVw
Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gRmlyc3Q6IGhhcm1mdWwuDQo+Pj4+Pj4+IEFzIGlzIGRvY3Vt
ZW50ZWQgaW4gdGhlIGtkb2MgY29tbWVudCBmb3IgbmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIoKSwg
dGhlDQo+Pj4+Pj4+IHRlc3Qgb24gc29fY291bnQgY2FuIHRyYW5zaWVudGx5IHJldHVybiBhIGZh
bHNlIHBvc2l0aXZlIHJlc3VsdGluZyBpbiBhDQo+Pj4+Pj4+IHJldHVybiBvZiBORlM0RVJSX0xP
Q0tTX0hFTEQgd2hlbiBpbiBmYWN0IG5vIGxvY2tzIGFyZSBoZWxkLiAgVGhpcyBpcw0KPj4+Pj4+
PiBjbGVhcmx5IGEgcHJvdG9jb2wgdmlvbGF0aW9uIGFuZCB3aXRoIHRoZSBMaW51eCBORlMgY2xp
ZW50IGl0IGNhbiBjYXVzZQ0KPj4+Pj4+PiBpbmNvcnJlY3QgYmVoYXZpb3VyLg0KPj4+Pj4+PiAN
Cj4+Pj4+Pj4gSWYgTkZTNF9SRUxFQVNFX0xPQ0tPV05FUiBpcyBzZW50IHdoaWxlIHNvbWUgb3Ro
ZXIgdGhyZWFkIGlzIHN0aWxsDQo+Pj4+Pj4+IHByb2Nlc3NpbmcgYSBMT0NLIHJlcXVlc3Qgd2hp
Y2ggZmFpbGVkIGJlY2F1c2UsIGF0IHRoZSB0aW1lIHRoYXQgcmVxdWVzdA0KPj4+Pj4+PiB3YXMg
cmVjZWl2ZWQsIHRoZSBnaXZlbiBvd25lciBoZWxkIGEgY29uZmxpY3RpbmcgbG9jaywgdGhlbiB0
aGUgbmZzZA0KPj4+Pj4+PiB0aHJlYWQgcHJvY2Vzc2luZyB0aGF0IExPQ0sgcmVxdWVzdCBjYW4g
aG9sZCBhIHJlZmVyZW5jZSAoY29uZmxvY2spIHRvDQo+Pj4+Pj4+IHRoZSBsb2NrIG93bmVyIHRo
YXQgY2F1c2VzIG5mc2Q0X3JlbGVhc2VfbG9ja293bmVyKCkgdG8gcmV0dXJuIGFuDQo+Pj4+Pj4+
IGluY29ycmVjdCBlcnJvci4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoZSBMaW51eCBORlMgY2xpZW50
IGlnbm9yZXMgdGhhdCBORlM0RVJSX0xPQ0tTX0hFTEQgZXJyb3IgYmVjYXVzZSBpdA0KPj4+Pj4+
PiBuZXZlciBzZW5kcyBORlM0X1JFTEVBU0VfTE9DS09XTkVSIHdpdGhvdXQgZmlyc3QgcmVsZWFz
aW5nIGFueSBsb2Nrcywgc28NCj4+Pj4+Pj4gaXQga25vd3MgdGhhdCB0aGUgZXJyb3IgaXMgaW1w
b3NzaWJsZS4gIEl0IGFzc3VtZXMgdGhlIGxvY2sgb3duZXIgd2FzIGluDQo+Pj4+Pj4+IGZhY3Qg
cmVsZWFzZWQgc28gaXQgZmVlbHMgZnJlZSB0byB1c2UgdGhlIHNhbWUgbG9jayBvd25lciBpZGVu
dGlmaWVyIGluDQo+Pj4+Pj4+IHNvbWUgbGF0ZXIgbG9ja2luZyByZXF1ZXN0Lg0KPj4+Pj4+PiAN
Cj4+Pj4+Pj4gV2hlbiBpdCBkb2VzIHJldXNlIGEgbG9jayBvd25lciBpZGVudGlmaWVyIGZvciB3
aGljaCBhIHByZXZpb3VzIFJFTEVBU0UNCj4+Pj4+Pj4gZmFpbGVkLCBpdCB3aWxsIG5hdHVyYWxs
eSB1c2UgYSBsb2NrX3NlcWlkIG9mIHplcm8uICBIb3dldmVyIHRoZSBzZXJ2ZXIsDQo+Pj4+Pj4+
IHdoaWNoIGRpZG4ndCByZWxlYXNlIHRoZSBsb2NrIG93bmVyLCB3aWxsIGV4cGVjdCBhIGxhcmdl
ciBsb2NrX3NlcWlkIGFuZA0KPj4+Pj4+PiBzbyB3aWxsIHJlc3BvbmQgd2l0aCBORlM0RVJSX0JB
RF9TRVFJRC4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFNvIGNsZWFybHkgaXQgaXMgaGFybWZ1bCB0byBh
bGxvdyBhIGZhbHNlIHBvc2l0aXZlLCB3aGljaCB0ZXN0aW5nDQo+Pj4+Pj4+IHNvX2NvdW50IGFs
bG93cy4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoZSB0ZXN0IGlzIG5vbnNlbnNlIGJlY2F1c2UgLi4u
IHdlbGwuLi4gaXQgZG9lc24ndCBtZWFuIGFueXRoaW5nLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gc29f
Y291bnQgaXMgdGhlIHN1bSBvZiB0aHJlZSBkaWZmZXJlbnQgY291bnRzLg0KPj4+Pj4+PiAxLyB0
aGUgc2V0IG9mIHN0YXRlcyBsaXN0ZWQgb24gc29fc3RhdGVpZHMNCj4+Pj4+Pj4gMi8gdGhlIHNl
dCBvZiBhY3RpdmUgdmZzIGxvY2tzIG93bmVkIGJ5IGFueSBvZiB0aG9zZSBzdGF0ZXMNCj4+Pj4+
Pj4gMy8gdmFyaW91cyB0cmFuc2llbnQgY291bnRzIHN1Y2ggYXMgZm9yIGNvbmZsaWN0aW5nIGxv
Y2tzLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gV2hlbiBpdCBpcyB0ZXN0ZWQgYWdhaW5zdCAnMicgaXQg
aXMgY2xlYXIgdGhhdCBvbmUgb2YgdGhlc2UgaXMgdGhlDQo+Pj4+Pj4+IHRyYW5zaWVudCByZWZl
cmVuY2Ugb2J0YWluZWQgYnkgZmluZF9sb2Nrb3duZXJfc3RyX2xvY2tlZCgpLiAgSXQgaXMgbm90
DQo+Pj4+Pj4+IGNsZWFyIHdoYXQgdGhlIG90aGVyIG9uZSBpcyBleHBlY3RlZCB0byBiZS4NCj4+
Pj4+Pj4gDQo+Pj4+Pj4+IEluIHByYWN0aWNlLCB0aGUgY291bnQgaXMgb2Z0ZW4gMiBiZWNhdXNl
IHRoZXJlIGlzIHByZWNpc2VseSBvbmUgc3RhdGUNCj4+Pj4+Pj4gb24gc29fc3RhdGVpZHMuICBJ
ZiB0aGVyZSB3ZXJlIG1vcmUsIHRoaXMgd291bGQgZmFpbC4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IEl0
IG15IHRlc3RpbmcgSSBzZWUgdHdvIGNpcmN1bXN0YW5jZXMgd2hlbiBSRUxFQVNFX0xPQ0tPV05F
UiBpcyBjYWxsZWQuDQo+Pj4+Pj4+IEluIG9uZSBjYXNlLCBDTE9TRSBpcyBjYWxsZWQgYmVmb3Jl
IFJFTEVBU0VfTE9DS09XTkVSLiAgVGhhdCByZXN1bHRzIGluDQo+Pj4+Pj4+IGFsbCB0aGUgbG9j
ayBzdGF0ZXMgYmVpbmcgcmVtb3ZlZCwgYW5kIHNvIHRoZSBsb2Nrb3duZXIgYmVpbmcgZGlzY2Fy
ZGVkDQo+Pj4+Pj4+IChpdCBpcyByZW1vdmVkIHdoZW4gdGhlcmUgYXJlIG5vIG1vcmUgcmVmZXJl
bmNlcyB3aGljaCB1c3VhbGx5IGhhcHBlbnMNCj4+Pj4+Pj4gd2hlbiB0aGUgbG9jayBzdGF0ZSBp
cyBkaXNjYXJkZWQpLiAgV2hlbiBuZnNkNF9yZWxlYXNlX2xvY2tvd25lcigpIGZpbmRzDQo+Pj4+
Pj4+IHRoYXQgdGhlIGxvY2sgb3duZXIgZG9lc24ndCBleGlzdCwgaXQgcmV0dXJucyBzdWNjZXNz
Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gVGhlIG90aGVyIGNhc2Ugc2hvd3MgYW4gc29fY291bnQgb2Yg
JzInIGFuZCBwcmVjaXNlbHkgb25lIHN0YXRlIGxpc3RlZA0KPj4+Pj4+PiBpbiBzb19zdGF0ZWlk
LiAgSXQgYXBwZWFycyB0aGF0IHRoZSBMaW51eCBjbGllbnQgdXNlcyBhIHNlcGFyYXRlIGxvY2sN
Cj4+Pj4+Pj4gb3duZXIgZm9yIGVhY2ggZmlsZSByZXN1bHRpbmcgaW4gb25lIGxvY2sgc3RhdGUg
cGVyIGxvY2sgb3duZXIsIHNvIHRoaXMNCj4+Pj4+Pj4gdGVzdCBvbiAnMicgaXMgc2FmZS4gIEZv
ciBhbm90aGVyIGNsaWVudCBpdCBtaWdodCBub3QgYmUgc2FmZS4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+
IFNvIHRoaXMgcGF0Y2ggY2hhbmdlcyBjaGVja19mb3JfbG9ja3MoKSB0byB1c2UgdGhlIChuZXdp
c2gpDQo+Pj4+Pj4+IGZpbmRfYW55X2ZpbGVfbG9ja2VkKCkgc28gdGhhdCBpdCBkb2Vzbid0IHRh
a2UgYSByZWZlcmVuY2Ugb24gdGhlDQo+Pj4+Pj4+IG5mczRfZmlsZSBhbmQgc28gbmV2ZXIgY2Fs
bHMgbmZzZF9maWxlX3B1dCgpLCBhbmQgc28gbmV2ZXIgc2xlZXBzLg0KPj4+Pj4+IA0KPj4+Pj4+
IE1vcmUgdG8gdGhlIHBvaW50LCBmaW5kX2FueV9maWxlX2xvY2tlZCgpIHdhcyBhZGRlZCBieSBj
b21taXQNCj4+Pj4+PiBlMGFhNjUxMDY4YmYgKCJuZnNkOiBkb24ndCBjYWxsIG5mc2RfZmlsZV9w
dXQgZnJvbSBjbGllbnQgc3RhdGVzDQo+Pj4+Pj4gc2VxZmlsZSBkaXNwbGF5IiksIHdoaWNoIHdh
cyBtZXJnZWQgc2V2ZXJhbCBtb250aHMgL2FmdGVyLyBjb21taXQNCj4+Pj4+PiBjZTNjNGFkN2Y0
Y2UgKCJORlNEOiBGaXggcG9zc2libGUgc2xlZXAgZHVyaW5nDQo+Pj4+Pj4gbmZzZDRfcmVsZWFz
ZV9sb2Nrb3duZXIoKSIpLg0KPj4+Pj4gDQo+Pj4+PiBZZXMuICBUbyBmbGVzaCBvdXQgdGhlIGhp
c3Rvcnk6DQo+Pj4+PiBuZnNkX2ZpbGVfcHV0KCkgd2FzIGFkZGVkIGluIHY1LjQuICBJbiBlYXJs
aWVyIGtlcm5lbHMgY2hlY2tfZm9yX2xvY2tzKCkNCj4+Pj4+IHdvdWxkIG5ldmVyIHNsZWVwLiAg
SG93ZXZlciB0aGUgcHJvYmxlbSBwYXRjaCB3YXMgYmFja3BvcnRlZCA0LjksIDQuMTQsDQo+Pj4+
PiBhbmQgNC4xOSBhbmQgc2hvdWxkIGJlIHJldmVydGVkLg0KPj4+PiANCj4+Pj4gSSBkb24ndCBz
ZWUgIk5GU0Q6IEZpeCBwb3NzaWJsZSBzbGVlcCBkdXJpbmcgbmZzZDRfcmVsZWFzZV9sb2Nrb3du
ZXIoKSINCj4+Pj4gaW4gYW55IG9mIHRob3NlIGtlcm5lbHMuIEFsbCBidXQgNC4xOSBhcmUgbm93
IEVPTC4NCj4+PiANCj4+PiBJIGhhZG4ndCBjaGVja2VkIHdoaWNoIHdlcmUgRU9MLiAgVGhhbmtz
IGZvciBmaW5kaW5nIHRoZSA0LjE5IHBhdGNoIGFuZA0KPj4+IHJlcXVlc3RpbmcgYSByZXZlcnQu
DQo+Pj4gDQo+Pj4+IA0KPj4+PiANCj4+Pj4+IGZpbmRfYW55X2ZpbGVfbG9ja2VkKCkgd2FzIGFk
ZGVkIGluIHY2LjIgc28gd2hlbiB0aGlzIHBhdGNoIGlzDQo+Pj4+PiBiYWNrcG9ydGVkIHRvIDUu
NCwgNS4xMCwgNS4xNSwgNS4xNyAtIDYuMSBpdCBuZWVkcyB0byBpbmNsdWRlDQo+Pj4+PiBmaW5k
X2FuZF9maWxlX2xvY2tlZCgpDQo+Pj4+IA0KPj4+PiBJIHRoaW5rIEknZCByYXRoZXIgbGVhdmUg
dGhvc2UgdW5wZXJ0dXJiZWQgdW50aWwgc29tZW9uZSBoaXRzIGEgcmVhbA0KPj4+PiBwcm9ibGVt
LiBVbmxlc3MgeW91IGhhdmUgYSBkaXN0cmlidXRpb24ga2VybmVsIHRoYXQgbmVlZHMgdG8gc2Vl
DQo+Pj4+IHRoaXMgZml4IGluIG9uZSBvZiB0aGUgTFRTIGtlcm5lbHM/IFRoZSBzdXBwb3J0ZWQg
c3RhYmxlL0xUUyBrZXJuZWxzDQo+Pj4+IGFyZSA1LjQsIDUuMTAsIDUuMTUsIGFuZCA2LjEuDQo+
Pj4gDQo+Pj4gV2h5IG5vdCBmaXggdGhlIGJ1Zz8gIEl0J3MgYSByZWFsIGJ1ZyB0aGF0IGEgcmVh
bCBjdXN0b21lciByZWFsbHkgaGl0Lg0KPj4gDQo+PiBUaGF0J3Mgd2hhdCBJJ20gYXNraW5nLiBX
YXMgdGhlcmUgYSByZWFsIGN1c3RvbWVyIGlzc3VlPyBCZWNhdXNlDQo+PiBjZTNjNGFkN2Y0Y2Ug
d2FzIHRoZSByZXN1bHQgb2YgYSBtaWdodF9zbGVlcCBzcGxhdCwgbm90IGFuIGlzc3VlDQo+PiBp
biB0aGUgZmllbGQuDQo+PiANCj4+IFNpbmNlIHRoaXMgaGl0IGEgcmVhbCB1c2VyLCBpcyB0aGVy
ZSBhIEJ1Z0xpbms6IG9yIENsb3NlczogdGFnDQo+PiBJIGNhbiBhZGQ/DQo+IA0KPiBVbmZvcnR1
bmF0ZWx5IG5vdC4gT3VyIGJ1Z3MgZm9yIHBheWluZyBjdXN0b21lcnMgYXJlIHByaXZhdGUgLSBz
byB0aGV5DQo+IGNhbiBmZWVsIGNvbWZvcnRhYmxlIHByb3ZpZGluZyBhbGwgdGhlIGRldGFpbHMg
d2UgbmVlZC4NCj4gVGhlIGxpbmsgaXMgaHR0cHM6Ly9idWd6aWxsYS5zdXNlLmNvbS9zaG93X2J1
Zy5jZ2k/aWQ9MTIxODk2OA0KPiB0aGF0IHdvbid0IGhlbHAgYW55b25lIG91dHNpZGUgU1VTRS4N
Cg0KV2VsbCwgdGhhdCBsaW5rIGRvZXMgc2hvdyB0aGF0IHRoZXJlJ3MgYSByZWFsIGJ1ZyByZXBv
cnQgYmVoaW5kDQp0aGUgZml4LiBUaGF0IHBhcnQgd2Fzbid0IGNsZWFyIGZyb20geW91ciBsZW5n
dGh5IHBhdGNoDQpkZXNjcmlwdGlvbiwgd2hpY2ggSSBvdGhlcndpc2UgYXBwcmVjaWF0ZWQuDQoN
Cg0KPiBCdXQgZGVmaW5pdGVseSBhIHJlYWwgYnVnLg0KDQpVbmRlcnN0b29kLiBUaGF0IG1ha2Vz
IGl0IGEgcHJpb3JpdHkgdG8gYmFja3BvcnQuDQoNCg0KPj4+IEkndmUgZml4ZWQgaXQgaW4gYWxs
IFNMRSBrZXJuZWxzIC0gd2UgZG9uJ3QgZGVwZW5kIG9uIExUUyB0aG91Z2ggd2UgZG8NCj4+PiBt
YWtlIHVzZSBvZiB0aGUgc3RhYmxlIHRyZWVzIGluIHZhcmlvdXMgd2F5cy4NCj4+PiANCj4+PiBC
dXQgaXQncyB5b3VyIGNhbGwuDQo+PiANCj4+IFdlbGwsIGl0J3Mgbm90IG15IGNhbGwgd2hldGhl
ciBpdCdzIGJhY2twb3J0ZWQuIEFueW9uZSBjYW4gYXNrLg0KPj4gSXQgL2lzLyBteSBjYWxsIGlm
IEkgZG8gdGhlIHdvcmsuDQo+IA0KPiBUaGF0J3MgZmFpci4gIEknbSBoYXBweSB0byBjcmVhdGUg
dGhlIG1hbnVhbCBiYWNrcG9ydCBwYXRjaC4gIEknbSBub3QNCj4gZ29pbmcgdG8gdGVzdCB0aG9z
ZSBrZXJuZWxzLg0KDQpUZXN0aW5nIGlzIHRoZSByZXNvdXJjZS1ib3VuZCBwYXJ0LCBmd2l3Lg0K
DQoNCj4gSSBnZW5lcmFsbHkgYXNzdW1lIHRoYXQgc29tZW9uZSBpcyB0ZXN0aW5nDQo+IHN0YWJs
ZSBrZXJuZWxzIC0gc28gb2J2aW91cyBwcm9ibGVtcyB3aWxsIGJlIGZvdW5kIGJ5IHNvbWVvbmUg
ZWxzZSwgYW5kDQo+IG5vbi1vYnZpb3VzIHByb2JsZW1zIEkgd291bGRuJ3QgZmluZCBldmVuIGlm
IEkgZGlkIHNvbWUgdGVzdGluZyA6LSgNCg0KU3RhYmxlIGtlcm5lbHMgZG9uJ3QgZ2V0IGFueSBz
cGVjaWZpYyB0ZXN0aW5nIG9mIHN1YnN5c3RlbSBjb2RlLA0KdW5sZXNzIHdlIGRvIGl0IG91cnNl
bHZlcy4gSSB3aWxsIHRyeSB0byBnZXQgdG8gaXQgc29vbi4NCg0KDQo+IFRoYW5rcywNCj4gTmVp
bEJyb3duDQo+IA0KPiANCj4+IA0KPj4gTW9zdGx5IHRoZSBpc3N1ZSBpcyBoYXZpbmcgdGhlIHRp
bWUgdG8gbWFuYWdlIDUtNiBzdGFibGUNCj4+IGtlcm5lbHMgYXMgd2VsbCBhcyB1cHN0cmVhbSBk
ZXZlbG9wbWVudC4gSSdkIGxpa2UgdG8gZW5zdXJlDQo+PiB0aGF0IGFueSBwYXRjaGVzIGZvciB3
aGljaCB3ZSBtYW51YWxseSByZXF1ZXN0IGEgYmFja3BvcnQgaGF2ZQ0KPj4gYmVlbiBhcHBsaWVk
IGFuZCB0ZXN0ZWQgYnkgc29tZW9uZSB3aXRoIGEgcmVhbCBORlMgcmlnLCBhbmQNCj4+IHRoZXJl
IGlzIGEgcmVhbCBwcm9ibGVtIGdldHRpbmcgYWRkcmVzc2VkLg0KPj4gDQo+PiBJdCdzIGdldHRp
bmcgYmV0dGVyIHdpdGgga2Rldm9wcy4uLiBJIGNhbiBjaGVycnkgcGljayBhbnkNCj4+IHJlY2Vu
dCBrZXJuZWwgYW5kIHJ1biBpdCB0aHJvdWdoIGEgbnVtYmVyIG9mIHRlc3RzIHdpdGhvdXQNCj4+
IG5lZWRpbmcgdG8gaGFuZC1ob2xkLiBIYXZlbid0IHRyaWVkIHRoYXQgd2l0aCB0aGUgb2xkZXIg
c3RhYmxlDQo+PiBrZXJuZWxzLCB0aG91Z2g7IHRob3NlIHJlcXVpcmUgb2xkZXIgY29tcGlsZXJz
IGFuZCB3aGF0LW5vdC4NCj4+IA0KPj4gDQo+PiAtLQ0KPj4gQ2h1Y2sgTGV2ZXINCg0KDQotLQ0K
Q2h1Y2sgTGV2ZXINCg0KDQo=

