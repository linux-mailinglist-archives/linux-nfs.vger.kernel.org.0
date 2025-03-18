Return-Path: <linux-nfs+bounces-10671-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA9DA68107
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 01:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAC9424DBA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 00:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791891C2324;
	Wed, 19 Mar 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PC3cS4eo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2117.outbound.protection.outlook.com [40.107.212.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822452054EF
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342413; cv=fail; b=PMeHA59qDBXnNEyks4W+l213u+mlGIjDZ+ex+Wc8mUnznNC9kRdih3i8GlRL+DDyqFpbYqUGTA1QKbf5Qcvgm5uSNfAqQ7Jku0pvxHCCGG95ae0vkWzbdCpxQn0IOi16UDGKZKVqHSOED4Xo7uV0fRSnoUTXaLEoD2FSVv9ygsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342413; c=relaxed/simple;
	bh=sy+Z0lUWUYVAzZMBcUkvMrPCOhrNf55DR3iw0jUKFL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EpwR0o8KRt51gcJiU1wN73LSLOGC5QCjZPjCX2ptttMtkc/iP510CSIHmAYPboII2LPu6raxS9sO60r74KmsXSU0du+Aqcpa7kBV5UzhSoXYuc2SxMwXA9QgYwiV0pTt5bW7z4TYGBTaP0guBktTKCfOR5aBtSF9qgZdpiBeYvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PC3cS4eo; arc=fail smtp.client-ip=40.107.212.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6pNseEz6Hqce4slbd1lceGl+AIS6ZdU8aUoDR0HKymAP7sJNRcIdD1zeIwYPfZN6ze8Ux1k8uPo8onp901BBohvCJb2b3EKNWWx8kupIjDpS8vSRcrLtdexlqK41W7DS1zXkhr1RCGCzL4RKu0u+DrxRRv9J2d72MNhWq9r+wLzXWBGbA7g7nBg1+5L+9NsfVhnQqmiV2DTqTnNGithl5aPcgaVD8SRkPcimTc695ddrK6YoHYIwjZO+2GKHiK0y5aVs7vGA86gTeZHfu22ECyD1Bg+gdcor6kSD5VVYj2uE1DM4ZkxfbmrluE/ZVz0EgEcKqXUeN1uzzTR3Z1SrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy+Z0lUWUYVAzZMBcUkvMrPCOhrNf55DR3iw0jUKFL0=;
 b=j0iwv9ik2toHCWWiAjTnMugZblGNdA+k94ONr1KVMI5jCbWUj5etsOv5yGYCqX7B8O1tYk/DvcMXtjE5SrE0KXQ9N+F86T02HBV2quhjBsrlD6uB2EjjM3XOprb8KhK5DKo9sVjX1hxtQCCkFjkMXqioPvv+WuJR1evmNTBEH02OHV4uXWKiU4WToet6zY89UQPMuj/kF15fCFDeV7n75J+rdmjfuNK/9g6wEQJ6A4tBPvjQD6JVNyu7IAAo7r/dCIu2L3ZcDPoruxyzfr6yLX64TvjHDsJjL5eIkblSqkDW59V7KFMxtdFraYKijf29vDobXwOiwoJl0B4lEO5pAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy+Z0lUWUYVAzZMBcUkvMrPCOhrNf55DR3iw0jUKFL0=;
 b=PC3cS4eoGe2MbvqWlGmE6SmJUqq0lGDl0KWwMjNtVfm83Ndomx1SOi2Y1QnaEvCrEPqDD15NNm+agowR3tGXAvpTU59W0fAR6N9uUxkEFxE9wyrUyaQfTU6fnnF0qu58PZ/WnsoGGupcQG3RMfZ1IqEV809/9XFzzIgbTXe+CDQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4088.namprd13.prod.outlook.com (2603:10b6:208:262::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 23:59:50 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 23:59:50 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "rick.macklem@gmail.com" <rick.macklem@gmail.com>
CC: "lionelcons1972@gmail.com" <lionelcons1972@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>,
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Topic: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Index:
 AQHbmBa5xy/j3c2GaUCylZ3htsCWqbN4/18AgAAOAgCAAFTsgIAAA8+AgAAWQoCAABGcAIAAA2sAgAACFgA=
Date: Tue, 18 Mar 2025 23:59:50 +0000
Message-ID: <09c573463b19a1d1f4b1e50484faa657d3c3aa28.camel@hammerspace.com>
References:
 <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
	 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com>
	 <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
	 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
	 <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
	 <CAPJSo4WrOnWfLzmfoCcj1MuYQQBHo434vTK=9qx+rh_FCVck=w@mail.gmail.com>
	 <e21645871fd6249d93f9bb33b154c3663eaf0a70.camel@hammerspace.com>
	 <CAM5tNy5ZA5MKuCsFQHXE_uBkmMv3eBH7dgonaTrk9Rk-p2jA0g@mail.gmail.com>
In-Reply-To:
 <CAM5tNy5ZA5MKuCsFQHXE_uBkmMv3eBH7dgonaTrk9Rk-p2jA0g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB4088:EE_
x-ms-office365-filtering-correlation-id: 69de1f8f-e1db-40ab-bbb7-08dd6678f822
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d09yYlEvc1lkcGZydVpqdDVGcUV1Wng1SStYMDBuR0lyWDZNRWNXdkZIUlVk?=
 =?utf-8?B?N2ljcDg5TlpWL1U5bHRuczJWN2UvTmF6cVQ4OVk5c0ZDUFNjZDg5dG95aGJn?=
 =?utf-8?B?b2dPcW5qLzZsbWptMk9nZGt4am5VVnZWdFBRenhOSlZLVHowekNZSGo2M3hG?=
 =?utf-8?B?YWFOMGZtdWNjek5BQWhLcEl1ajFHWS92aW9kNHJ2dFBmWHdxNGxyWXliNUFQ?=
 =?utf-8?B?UGFrazJsUWtoQ3VGNHZMY2FBcEswenlmRk5EWkJhUStZdHZUeGRJUzBCUktB?=
 =?utf-8?B?Y0cvVVE3ejRLRlNRdW1YSnE0bmpGNldybENHK1huNld6WjVmdnZpMEl2dzVH?=
 =?utf-8?B?MGdhY2lhOHQxdEpQd25Wd2Zac0FYK2JEU2ZqbjNCQzdLTWxGR3ppWTRiaUpC?=
 =?utf-8?B?V3I4L1pnQWg4Z3g3eU9mdTFrd1hJN2Y3SUhoVG1FRG1xbUhvVVdMKzhQUlQy?=
 =?utf-8?B?eWpjaDhWeE9kWjF2dDlFZGRUNEphWUE5aTcvMHh4cndieVNYNWhSK0xUdU5q?=
 =?utf-8?B?UGV4UHN5S0pJWDFvWU5MbTdLTFNPbHdmcG0xclpTbEo3aHlpQ2JJdUY0VDZh?=
 =?utf-8?B?UGhvVFM3enZZcGlPWVpmL3BMN1l4MC9WbG9JNnpBeWMyTHFQU0dkZEhOcFlZ?=
 =?utf-8?B?cTJmZFc0dmhZcWQ4U0gwc0JtQ3VyR1V4ZnhMYnBnVWxVVHJXTlpLZ2NsOGcv?=
 =?utf-8?B?VUhhUjJWTTBRa2VvVXVyVmZVWkIxZGlsbkwwb2svQkEzaUlDM2VyT1VoZERD?=
 =?utf-8?B?ZUZMSkkxYUR6U0tveUJmL3UzQUlEd1Znb25jUkxCVkZwYTd2dFU3NkpvKzFo?=
 =?utf-8?B?MngyVWNjeU9LOHdsUWNOUkRZemtQODdNbWQ5bjFRUi9kQUwzaTZKU2s0Tldu?=
 =?utf-8?B?L2gxQXFqM0FjRjl5YXhIMWNhV3ZwMUM0Rk82TVBwTHZySWVPc2JmRWwybit5?=
 =?utf-8?B?VXpoOTA2TmU4RTVBY0ZmQ3ZCamNSbllVelh1SjlldFpGR0RXSGw5S3prcGtv?=
 =?utf-8?B?YllMOXowcnVodTgzTkdscW9BZEdLejZybXBvV0dBYm9vbjBuR0luTHgxNzVG?=
 =?utf-8?B?cFZDR1VvNHY1dyttbHRSRnJYMkhEeFoxYmRiTU5qejdpV0htaSsxcEJqbmN6?=
 =?utf-8?B?ZHp3bnB6ZHp0UUtwajVYNmRZaDdzNkNQWlVpS1puUGEyRDBaSWVFZGxVTDFP?=
 =?utf-8?B?L2ZlSzFvL1MwOUs1Mjc2eHU2OVJ4UURBeFJYd0sxbllSWGtQcEZXaHhUYlZZ?=
 =?utf-8?B?Yno5MnNNTDl0R1F0MHhicjQ3SHZpbHNBZThmdVo4cjQ2YWMvNU9YYUZpTnR2?=
 =?utf-8?B?RFZwbGlvWG1ub0YzNHhjSUgrcXBjeEM4di9qeFZZMDNzb3d1YWRzSVpVbmdD?=
 =?utf-8?B?OHJJb1NlQkxlZi96cFJ5R1RKYXcxRGZlQmZKcWhKdGpJakpZU3cxd2p2V04x?=
 =?utf-8?B?TU1EZTRaOXpmMjlrdXlvdzhDYk5UcVVRUXhMM2NYK25oUEJqNkxHQzV0amds?=
 =?utf-8?B?OTNuZHBJTU5mRlpvUDFpcXpJdG83OEg0YXRESzQ5a2RMYlB3bkVCNlBzYU5j?=
 =?utf-8?B?d1lKb20zbVZQVDlXMGVvSWdOblJDM0hJWS9mUnA1SDQ5RkpvUHEya3hZLzZT?=
 =?utf-8?B?bENWUUw4MTlBTDVyQ1Z2Njh3MmVoVWxCNEhyVHgvaGJ6R1lPYUVpQmxxWS93?=
 =?utf-8?B?OUwyTi82NTIzRHhUZGdXWkZVTS8zRGZpQ05Kb01rRS94WVI3QUZGaGpnbkNt?=
 =?utf-8?B?b2NxQ2RtbVExRlVPNnVGU3lqUWNGTVRndHl3aGlYWEZvRDNLUmQ3VmRoUlBX?=
 =?utf-8?B?aExYQzNVaStsTlczZnhmMm0raGZ6dGViZnVEZWRwNkgyUWNkbXZXZ3NTTHVQ?=
 =?utf-8?B?VHVlZmdXaVFxaHlGbXVIZUVocThSWGxWS2xaeGhFK0JqS3c1dmg5L044ZDI4?=
 =?utf-8?Q?6AhQt9QlgUsv5DaCKP7XHPcEGJEcY+GP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RThnOEFlRVZRYzdKMlFCaElHaVFpVUduK2pZUER3cDh5STRQK1VLZGpJMHBK?=
 =?utf-8?B?T1JMdUtZaWJQclN1amxoZi9HU1JOdUxmT21heTcwNlA0Ni8vWllsLzBjQTlF?=
 =?utf-8?B?U3R5L2RyYzZaeFlMRmE0aEZRK1FiSTMxb2c2dUVtZ1pockJCMEE2YzBPUVVM?=
 =?utf-8?B?Q1pqaXJpVWNzZmZrbklEWVJueTgyeCttNFFMNjRHV0JPeDlYVmoyc1lwSWZk?=
 =?utf-8?B?ajJNOHJIOGRMbUJyU3BBcllsdG1HZDZKRElhYTBqeUZZdStScEYxM01kZWx0?=
 =?utf-8?B?cGVDV2JpenhEOXdvQ1RudUc0MEM3Njg1WlBlc0VkYnB5QlFuZXNESzNPMzNs?=
 =?utf-8?B?eDh2Y1RoR0g1Ukp0TXV6RElVMHZkQzlLRHFEenV4bW16S2pBVW5SRlhZUGZ3?=
 =?utf-8?B?WFlzTUZQTW1vWVhhOTJyWVJlWm1MbFMrTGFSamJqOUR6YmlIaGtBVWo5dkdG?=
 =?utf-8?B?dEhLSldIK09mWnVCZVlSbzlycmVIdm9FeEdmV2o3aXJsc0RKWnFUSUZtbU4z?=
 =?utf-8?B?RytuR2pSM01kVEVjeGxlQnRNd0tZQjQwMUxETmJ2dlNHT0hKc1BCN2Rucko0?=
 =?utf-8?B?MFZGYkFldUtsL0hEQzg3U1ZhR3VlNFpKQTNCYk1KUi9xOFZkZWl5QStPT3JE?=
 =?utf-8?B?WDh3eGVNMHp3UXRVczYvcnF2SVNEcUlTamlSUXZ0THZnZ3IrUzRZdC9wOE5q?=
 =?utf-8?B?RnRZaVhCWW5xeDZ2SlRzdmZHaUxHVytuZnNrbFNHQllGUUkwQ01Kdyt5WFpk?=
 =?utf-8?B?QTFaY2ZINmRWVzAwa1kzVFRTY1VhbTg2TzZLellzRXdzMlVhYVFWVXRWZDhw?=
 =?utf-8?B?MGNjT3M2bGVCZG14OVF2MThBUTZkTC9vUnYvMDZKUlVkczRCUUpGclVCZ2tZ?=
 =?utf-8?B?MUl2MFdTaTZ5STJZUXQwTktzQk1FNTF4amkyWXYwd3dGanBUKzl0ZlJvQnIz?=
 =?utf-8?B?RTRzSzZuVkE5OUdxYWhsMGt4bkhkSUw5ZkNQZlhDbmdCaWQxdjlhb2NOSDlW?=
 =?utf-8?B?TmVzeUFKRllUeXEzZHYyM0owdzdRVW1zYnY2cEZiWUhlczdSYnJ3aFIxWWZ1?=
 =?utf-8?B?a2FZY3U2R0VVUlBOL3BaaWZ4WlBXbS85QnprMkg2cGhTbUg1Mkh1emt3aXR1?=
 =?utf-8?B?M0xpbWQzS09zVklpbEFJeGVMR3RWUmNOUGdFT1UxbUVvd05SemJmSzkwaURY?=
 =?utf-8?B?YTg0ek1IQ2FOa1c5NDhTZDZWME5pV2ZDa1djYUhJemg0MUl2UEo2ZmlzNUNT?=
 =?utf-8?B?R1o4Z3pHWU9vaGtLQU5QOEY0aWFvQXlpcXQxam9ERTJiekRtclpMMTBacXM2?=
 =?utf-8?B?WS9HZ2tjQi9HbnBabjVpRDY3enZ5UW8zdlE1eTdhbVVVNmk2d0hrUXJJV0dC?=
 =?utf-8?B?STJYZmZaSGQwSk5DOXl3UUw2bEF3VUpRUDhXQWE4ZnpWRFNDRkhiUklNeSsr?=
 =?utf-8?B?a0Y2NVBLTUY1UmYweERUWEVsVkRjNDd0cFF6bHBuUjBieVZIdW5HajhLdGhq?=
 =?utf-8?B?NERKbzdMZXJjU2E0UWZvV2J4QXJHREV2SDFocFgyMjZlN1hvbzQxNzdKajJH?=
 =?utf-8?B?RVc1eVZEMWhPMGRMc0lIZmJQVnhPYW12akZoZlF6SzNTSVNKa0s2ZzJsb3Jy?=
 =?utf-8?B?dk85S3l0Zk5CL09EaW5iS2FwUEZwQXBGeC9xQ1k2Yk9Ba050VEVaWFYrei9T?=
 =?utf-8?B?b081Smdyb3h6SFZRQXI5b2IvKy90T0xzVGlieHBxSTdjODM4QlQwdkN3Tkxu?=
 =?utf-8?B?N3hlYmEzT2gvMlFpT0JOWm4yMjRFaitRbitpMU8yT291NDBEeWMwcXhHcmlL?=
 =?utf-8?B?Wm9VSUROOTVJUUF4SlJsNXYrazhPNFViZk10RUFwRnE2NzN5QVR3c2MvZS9i?=
 =?utf-8?B?ZkEzeEdBNlUvQjBPYjVQblA0MC9vTjU3MXRrYjZpQXpsQm4rZXFrVktrckFF?=
 =?utf-8?B?YzZYYXJvZXFEbXlwSnVReXFsQVFCWThXQmtGTmZTeFVoeWYrZU1hNURMOHRa?=
 =?utf-8?B?MU1UYk9vcmE2bHNKaitnOEkyb0Z5Nkp2dkhORlJyUjIySFBFdDVZN3FPNWVU?=
 =?utf-8?B?cGtoRlU0ekFaRFpqWVRGRGJmZVFXdTdkNXkzcGlZUnFYWFUzaDFsZG9rN1lG?=
 =?utf-8?B?ZFBhYXZqbWgyUHNETTFMMXZhVVFrZnVINUFPZVFDOWhvZ21aaVlCa1pUallV?=
 =?utf-8?B?eHFsNjdwZDJPTzMvRXQxSE4vYmc1SytMUjhOdVB0M2JRY200Z2dOMDJCVURI?=
 =?utf-8?B?MVZ2OUdDUlJyenhZc09LVWk3UnZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC21162F5D9C74D904AA73A2314883C@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 69de1f8f-e1db-40ab-bbb7-08dd6678f822
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 23:59:50.1580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YQtjtSCTBpbV7+YfRv1zExH/0zijAOqFmaV/1OoZDRcpdRKbCledtVza2Agtk6ZejrAKvYcAqpctX3vX3ptzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4088

T24gVHVlLCAyMDI1LTAzLTE4IGF0IDE2OjUyIC0wNzAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IE9uIFR1ZSwgTWFyIDE4LCAyMDI1IGF0IDQ6NDDigK9QTSBUcm9uZCBNeWtsZWJ1c3QNCj4gPHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjUtMDMt
MTggYXQgMjM6MzcgKzAxMDAsIExpb25lbCBDb25zIHdyb3RlOg0KPiA+ID4gT24gVHVlLCAxOCBN
YXIgMjAyNSBhdCAyMjoxNywgVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA8dHJvbmRteUBoYW1tZXJz
cGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24gVHVlLCAyMDI1LTAzLTE4IGF0
IDE0OjAzIC0wNzAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
VGhlIHByb2JsZW0gSSBzZWUgaXMgdGhhdCBXUklURV9TQU1FIGlzbid0IGRlZmluZWQgaW4gYSB3
YXkNCj4gPiA+ID4gPiB3aGVyZQ0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IE5GU3Y0IHNlcnZl
ciBjYW4gb25seSBpbXBsZW1lbnQgemVybyduZyBhbmQgZmFpbCB0aGUgcmVzdC4NCj4gPiA+ID4g
PiBBcyBzdWNoLiBJIGFtIHRoaW5raW5nIHRoYXQgYSBuZXcgb3BlcmF0aW9uIGZvciBORlN2NC4y
IHRoYXQNCj4gPiA+ID4gPiBkb2VzDQo+ID4gPiA+ID4gd3JpdGluZw0KPiA+ID4gPiA+IG9mIHpl
cm9zIG1pZ2h0IGJlIHByZWZlcmFibGUgdG8gdHJ5aW5nIHRvIChtaXMpdXNlDQo+ID4gPiA+ID4g
V1JPVEVfU0FNRS4NCj4gPiA+ID4gDQo+ID4gPiA+IFdoeSB3b3VsZG4ndCB5b3UganVzdCBpbXBs
ZW1lbnQgREVBTExPQ0FURT8NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9oIG15IGdvZC4NCj4g
PiA+IA0KPiA+ID4gTkZTdjQuMiBERUFMTE9DQVRFIGNyZWF0ZXMgYSBob2xlIGluIGEgc3BhcnNl
IGZpbGUsIGFuZCBkb2VzIE5PVA0KPiA+ID4gd3JpdGUgemVyb3MuDQo+ID4gPiANCj4gPiA+ICJo
b2xlcyIgaW4gc3BhcnNlIGZpbGVzIChhcyBjcmVhdGVkIGJ5IE5GU1Y0LjIgREVBTExPQ0FURSkN
Cj4gPiA+IHJlcHJlc2VudA0KPiA+ID4gYXJlYXMgb2YgIm5vIGRhdGEgaGVyZSIuIEZvciBiYWNr
d2FyZHMgY29tcGF0aWJpbGl0eSB0aGVzZSBob2xlcw0KPiA+ID4gZG8NCj4gPiA+IG5vdCBwcm9k
dWNlIHJlYWQgZXJyb3JzLCB0aGV5IGp1c3QgcmVhZCBhcyAweDAwIGJ5dGVzLiBCdXQgdGhleQ0K
PiA+ID4gcmVwcmVzZW50IHJhbmdlcyB3aGVyZSBqdXN0IG5vIGRhdGEgYXJlIHN0b3JlZC4NCj4g
PiA+IFZhbGlkIGRhdGEgKGZyb20gYWxsb2NhdGVkIGRhdGEgcmFuZ2VzKSBjYW4gYmUgMHgwMCwg
YnV0IHRoZXJlDQo+ID4gPiBhcmUNCj4gPiA+IE5PVA0KPiA+ID4gaG9sZXMsIHRoZXkgcmVwcmVz
ZW50IFZBTElEIERBVEEuDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgYW4gaW1wb3J0YW50IGRpZmZl
cmVuY2UhDQo+ID4gPiBGb3IgZXhhbXBsZSBpZiB3ZSBoYXZlIGZpbGVzLCBvbmUgcGVyIHdlZWss
IDcwMFRCIGZpbGUgc2l6ZQ0KPiA+ID4gKDEwMFRCDQo+ID4gPiBwZXINCj4gPiA+IGRheSkuIEVh
Y2ggb2YgdGhvc2UgZmlsZXMgc3RhcnQgYXMgYSBjb21wbGV0ZWx5IHVuYWxsb2NhdGVkIHNwYWNl
DQo+ID4gPiAob25lDQo+ID4gPiBiaWcgaG9sZSkuIFRoZSBkYXRhIHJhbmdlcyBhcmUgZ3JhZHVh
bGx5IGFsbG9jYXRlZCBieSB3cml0ZXMsIGFuZA0KPiA+ID4gdGhlDQo+ID4gPiBwb3NpdGlvbiBv
ZiB0aGUgd3JpdGVzIGluIHRoZSBmaWxlcyByZXByZXNlbnQgdGhlIHRpbWUgd2hlbiB0aGV5DQo+
ID4gPiB3ZXJlDQo+ID4gPiBjb2xsZWN0ZWQuIElmIG5vIGRhdGEgd2VyZSBjb2xsZWN0ZWQgZHVy
aW5nIHRoYXQgdGltZSB0aGF0IHNwYWNlDQo+ID4gPiByZW1haW5zIHVuYWxsb2NhdGVkIChob2xl
KSwgc28gd2UgY2FuIHNlZSB3aGV0aGVyIHNvbWVvbmUNCj4gPiA+IGNvbGxlY3RlZA0KPiA+ID4g
ZGF0YSBpbiB0aGF0IHRpbWVmcmFtZS4NCj4gPiA+IA0KPiA+ID4gRG8geW91IHVuZGVyc3RhbmQg
dGhlIGRpZmZlcmVuY2U/DQo+ID4gPiANCj4gPiANCj4gPiBZZXMuIEkgZG8gdW5kZXJzdGFuZCB0
aGUgZGlmZmVyZW5jZSwgYnV0IGluIHRoaXMgY2FzZSB5b3UncmUNCj4gPiBsaXRlcmFsbHkNCj4g
PiBqdXN0IHRhbGtpbmcgYWJvdXQgYWNjb3VudGluZy4gVGhlIHNwYXJzZSBmaWxlIGNyZWF0ZWQg
YnkNCj4gPiBERUFMTE9DQVRFDQo+ID4gZG9lcyBub3QgbmVlZCB0byBhbGxvY2F0ZSB0aGUgYmxv
Y2tzIChleGNlcHQgcG9zc2libHkgYXQgdGhlDQo+ID4gZWRnZXMpLiBJZg0KPiA+IHlvdSBuZWVk
IHRvIGVuc3VyZSB0aGF0IHRob3NlIGVtcHR5IGJsb2NrcyBhcmUgYWxsb2NhdGVkIGFuZA0KPiA+
IGFjY291bnRlZA0KPiA+IGZvciwgdGhlbiBhIGZvbGxvdyB1cCBjYWxsIHRvIEFMTE9DQVRFIHdp
bGwgZG8gdGhhdCBmb3IgeW91Lg0KPiBVbmZvcnR1bmF0ZWx5IFpGUyBrbm93cyBob3cgdG8gZGVh
bGxvY2F0ZSwgYnV0IG5vdCBob3cgdG8gYWxsb2NhdGUuDQoNClNvIHRoZXJlIGlzIG5vIHN1cHBv
cnQgZm9yIHRoZSBwb3NpeCBmYWxsb2NhdGUgZnVuY3Rpb24/IFdlbGwgaW4gdGhlDQp3b3JzdCBj
YXNlLCB5b3VyIE5GUyBzZXJ2ZXIgd2lsbCBqdXN0IGhhdmUgdG8gZW11bGF0ZSBpdC4NCg0KPiA+
IA0KPiA+ICQgdG91Y2ggZm9vDQo+ID4gJCBzdGF0IGZvbw0KPiA+IMKgIEZpbGU6IGZvbw0KPiA+
IMKgIFNpemU6IDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJsb2NrczogMMKgwqDCoMKg
wqDCoMKgwqDCoCBJTyBCbG9jazogNDA5NsKgwqAgcmVndWxhcg0KPiA+IGVtcHR5IGZpbGUNCj4g
PiBEZXZpY2U6IDgsMTfCoMKgwqAgSW5vZGU6IDQxMDkyNDEyNcKgwqAgTGlua3M6IDENCj4gPiBB
Y2Nlc3M6ICgwNjQ0Ly1ydy1yLS1yLS0pwqAgVWlkOiAoMC8gcm9vdCnCoMKgIEdpZDogKDAvIHJv
b3QpDQo+ID4gQ29udGV4dDogdW5jb25maW5lZF91Om9iamVjdF9yOnVzZXJfaG9tZV90OnMwDQo+
ID4gQWNjZXNzOiAyMDI1LTAzLTE4IDE5OjI2OjI0LjExMzE4MTM0MSAtMDQwMA0KPiA+IE1vZGlm
eTogMjAyNS0wMy0xOCAxOToyNjoyNC4xMTMxODEzNDEgLTA0MDANCj4gPiBDaGFuZ2U6IDIwMjUt
MDMtMTggMTk6MjY6MjQuMTEzMTgxMzQxIC0wNDAwDQo+ID4gwqBCaXJ0aDogMjAyNS0wMy0xOCAx
OToyNToxMi45ODgzNDQyMzUgLTA0MDANCj4gPiAkIHRydW5jYXRlIC1zIDFHaUIgZm9vDQo+ID4g
JCBzdGF0IGZvbw0KPiA+IMKgIEZpbGU6IGZvbw0KPiA+IMKgIFNpemU6IDEwNzM3NDE4MjTCoMKg
wqDCoMKgIEJsb2NrczogMMKgwqDCoMKgwqDCoMKgwqDCoCBJTyBCbG9jazogNDA5NsKgwqAgcmVn
dWxhcg0KPiA+IGZpbGUNCj4gPiBEZXZpY2U6IDgsMTfCoMKgwqAgSW5vZGU6IDQxMDkyNDEyNcKg
wqAgTGlua3M6IDENCj4gPiBBY2Nlc3M6ICgwNjQ0Ly1ydy1yLS1yLS0pwqAgVWlkOiAoMC8gcm9v
dCnCoMKgIEdpZDogKDAvIHJvb3QpDQo+ID4gQ29udGV4dDogdW5jb25maW5lZF91Om9iamVjdF9y
OnVzZXJfaG9tZV90OnMwDQo+ID4gQWNjZXNzOiAyMDI1LTAzLTE4IDE5OjI2OjI0LjExMzE4MTM0
MSAtMDQwMA0KPiA+IE1vZGlmeTogMjAyNS0wMy0xOCAxOToyNzozNS4xNjE2OTQzMDEgLTA0MDAN
Cj4gPiBDaGFuZ2U6IDIwMjUtMDMtMTggMTk6Mjc6MzUuMTYxNjk0MzAxIC0wNDAwDQo+ID4gwqBC
aXJ0aDogMjAyNS0wMy0xOCAxOToyNToxMi45ODgzNDQyMzUgLTA0MDANCj4gPiAkIGZhbGxvY2F0
ZSAteiAtbCAxR2lCIGZvbw0KPiA+ICQgc3RhdCBmb28NCj4gPiDCoCBGaWxlOiBmb28NCj4gPiDC
oCBTaXplOiAxMDczNzQxODI0wqDCoMKgwqDCoCBCbG9ja3M6IDIwOTcxNTLCoMKgwqAgSU8gQmxv
Y2s6IDQwOTbCoMKgIHJlZ3VsYXINCj4gPiBmaWxlDQo+ID4gRGV2aWNlOiA4LDE3wqDCoMKgIElu
b2RlOiA0MTA5MjQxMjXCoMKgIExpbmtzOiAxDQo+ID4gQWNjZXNzOiAoMDY0NC8tcnctci0tci0t
KcKgIFVpZDogKDAvIHJvb3QpwqDCoCBHaWQ6ICgwLyByb290KQ0KPiA+IENvbnRleHQ6IHVuY29u
ZmluZWRfdTpvYmplY3Rfcjp1c2VyX2hvbWVfdDpzMA0KPiA+IEFjY2VzczogMjAyNS0wMy0xOCAx
OToyNjoyNC4xMTMxODEzNDEgLTA0MDANCj4gPiBNb2RpZnk6IDIwMjUtMDMtMTggMTk6Mjc6NTQu
NDYyODE3MzU2IC0wNDAwDQo+ID4gQ2hhbmdlOiAyMDI1LTAzLTE4IDE5OjI3OjU0LjQ2MjgxNzM1
NiAtMDQwMA0KPiA+IMKgQmlydGg6IDIwMjUtMDMtMTggMTk6MjU6MTIuOTg4MzQ0MjM1IC0wNDAw
DQo+ID4gDQo+ID4gDQo+ID4gWWVzLCBJIGFsc28gcmVhbGlzZSB0aGF0IG5vbmUgb2YgdGhlIGFi
b3ZlIG9wZXJhdGlvbnMgYWN0dWFsbHkNCj4gPiByZXN1bHRlZA0KPiA+IGluIGJsb2NrcyBiZWlu
ZyBwaHlzaWNhbGx5IGZpbGxlZCB3aXRoIGRhdGEsIGJ1dCBhbGwgbW9kZXJuIGZsYXNoDQo+ID4g
YmFzZWQNCj4gPiBkcml2ZXMgdGVuZCB0byBoYXZlIGEgbG9nIHN0cnVjdHVyZWQgRlRMLiBTbyB3
aGlsZSBvdmVyd3JpdGluZyBkYXRhDQo+ID4gaW4NCj4gPiB0aGUgSEREIGVyYSBtZWFudCB0aGF0
IHlvdSB3b3VsZCB1c3VhbGx5ICh1bmxlc3MgeW91IGhhZCBhIGxvZw0KPiA+IGJhc2VkDQo+ID4g
ZmlsZXN5c3RlbSkgb3ZlcndyaXRlIHRoZSBzYW1lIHBoeXNpY2FsIHNwYWNlIHdpdGggZGF0YSwg
dG9kYXkncw0KPiA+IGRyaXZlcw0KPiA+IGFyZSBmcmVlIHRvIHNoaWZ0IHRoZSByZXdyaXR0ZW4g
YmxvY2sgdG8gYW55IG5ldyBwaHlzaWNhbCBsb2NhdGlvbg0KPiA+IGluDQo+ID4gb3JkZXIgdG8g
ZW5zdXJlIGV2ZW4gd2VhciBsZXZlbGxpbmcgb2YgdGhlIFNTRC4NCj4gWWVhLiBUaGUgV3JfemVy
byBvcGVyYXRpb24gd3JpdGVzIDBzIHRvIHRoZSBsb2dpY2FsIGJsb2NrLiBEb2VzIHRoYXQNCj4g
Z3VhcmFudGVlIHRoZXJlIGlzIG5vICJvbGQgYmxvY2sgZm9yIHRoZSBsb2dpY2FsIGJsb2NrIiB0
aGF0IHN0aWxsDQo+IGhvbGRzDQo+IHRoZSBkYXRhPyAoSXQgZG9lcyBzYXkgV3JfemVybyBjYW4g
YmUgdXNlZCBmb3Igc2VjdXJlIGVyYXN1cmUsIGJ1dD8/KQ0KPiANCj4gR29vZCBxdWVzdGlvbiBm
b3Igd2hpY2ggSSBkb24ndCBoYXZlIGFueSBpZGVhIHdoYXQgdGhlIGFuc3dlciBpcywNCj4gcmlj
aw0KDQpJbiBib3RoIHRoZSBhYm92ZSBhcmd1bWVudHMsIHlvdSBhcmUgdGFsa2luZyBhYm91dCBz
cGVjaWZpYyBmaWxlc3lzdGVtDQppbXBsZW1lbnRhdGlvbiBkZXRhaWxzIHRoYXQgeW91J2xsIGFs
c28gaGF2ZSB0byBhZGRyZXNzIHdpdGggeW91ciBuZXcNCm9wZXJhdGlvbi4NCg0KPiANCj4gPiAN
Cj4gPiBJT1c6IHRoZXJlIGlzIG5vIHJlYWwgYWR2YW50YWdlIHRvIHBoeXNpY2FsbHkgd3JpdGlu
ZyBvdXQgdGhlIGRhdGENCj4gPiB1bmxlc3MgeW91IGhhdmUgYSBwZWN1bGlhciBpbnRlcmVzdCBp
biB3YXN0aW5nIHRpbWUuDQo+ID4gDQo+ID4gLS0NCj4gPiBUcm9uZCBNeWtsZWJ1c3QNCj4gPiBM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQo+ID4gdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KPiA+IA0KPiA+IA0KPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

