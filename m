Return-Path: <linux-nfs+bounces-7464-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7562C9B0330
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CA51F2383C
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1482064E7;
	Fri, 25 Oct 2024 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SgQQt+Ei";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MVnbw7Fs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB821BC5C
	for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860776; cv=fail; b=OZchXrS987XxAMMw/gIS1MBMZMnrAy1+Wi4e3zSNtBI9uUgLQl5A0bLmeh+8T2fSBDi1C06dFDOgZkQaGRnsiUghLywUtWzfVG7+I9DAcu6RX3F3muixsyGkwei/0bBOMl+I9GwR8NtVf5jRDPZ5wEo2wm8nqO3crnp2x+DaBb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860776; c=relaxed/simple;
	bh=dIbdlYS0NOVIToy+wm19WFTGlhW/52MCGHXOswhWZfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nzqKRvAm4LHcaLk+in9enZ9dc5caYm4d5473hA+en7MSol7SLViLthCLz8Vg/XGrCaZswk+jyjByec5u3tL45xpP976cggN+ZYWPDt3J184sypBYgwW62nwJVhM7fpYckgzJb2yqiSO4Hw+Q7Odd5Uew0j8w9skInGuA1DWss8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SgQQt+Ei; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MVnbw7Fs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCTcuo000520;
	Fri, 25 Oct 2024 12:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dIbdlYS0NOVIToy+wm19WFTGlhW/52MCGHXOswhWZfc=; b=
	SgQQt+Ei+NIwciQHJVbuolycb8TanXWdm0hRdmec0crOjs3kKQ5SOqMExLjx+OAP
	1vEoiNtAH1IIiVdqGWRUQg+To+5L+JDEjego6FUjwFfWiPLI2oYBe4B//DuWoq8v
	XMA3pEoGZr7NjPk11H8vVAbcbfoWf40YsT8G40LUE/cHw3piepS5RTc4eMYok6aN
	OJoH6qOO/5L/RoeYwhwIicVuhp65c1diQ1wQGNv0G3FbGw9iTccD9h9sX+IW0HRG
	3Dn6o/LtQGQnl06r2Q3dbuhcm/kkC8y4rQ3+EljCma6CcZGE+sO+33R+TjtL0l1t
	Tb2ZaDLrCPu91xxSmU7qXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qmv98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:52:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBvSxN021033;
	Fri, 25 Oct 2024 12:52:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhnb9fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:52:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu5fipBt27hM/nC1Q+/7Qs3q2ij81UTT097NDfUr3w0Sd2S212QGp9tpiRqiP21O+z4onFaWhXjlgg7iHFTQa9SntieAzH0QCAkalFxc5QpxvK3dD+DXSTskuegh6mKb55dCc1eBgbO0lzL3HJ4IYKB5DXha9rIJufa0SZ+HN3y80XI7TzVR+ES5MpafCobC+Gt3cBcsMt9FnnrD1Tl3S10OG0IY3dBmGQgtVyGV3gC1ah6BSYu9FEFZH2c+BNJcpRg8wIXbceXLpOEU05A/wPHB2Qpqj2Q0m/bvJOor+Ks9mTRTCA6Qbn+wI4eetOdedCYWtCkFzTbS53Yk0yDptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIbdlYS0NOVIToy+wm19WFTGlhW/52MCGHXOswhWZfc=;
 b=uMXMMpNGXH513odg/D3ShkY2nsACH7JRpjBufBj6+NMeH5ZiizH/jiQ2/A960tJCa9aAGeVKa2rvWx8Fc8uzXBhC3pPHK8TtZmu8BO4x9gGe58tDORT3l0xZ4iyyC+cXEa+WQZLc0enGuKYi+qgRHiAUsrE4EScCFXFhk76Q4KTbapoANx5nEmjXUK4QPs242ejIaNkNssVuvwmXYNsDlYIVZoHJKfpnxkv3nwc96u2G/eFVeiseoBI1s+2SEvkwTMrB/Eyd9Tqp5kVVYRdf7G0rm+1Q79JP8xvB6cx3xhXLiSyuzCi2Jqd3PGfsL5dL1xdAhJaUJOO0q9Ml9IrJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIbdlYS0NOVIToy+wm19WFTGlhW/52MCGHXOswhWZfc=;
 b=MVnbw7FsJzELZkQHkGZvDBm3jpXBSh8q1lorC1IOaphi8baePE3WfyGRZ9YNq7sFFAPXHso90oBb+OV0WBQwI/pq3smDXcGo/n246aiHDvRJmawNxPlrvAIXkX8r8nFievNW1/HsKFBryXtcKhJg4pq5VLrhrOFPtkWvsSi/1VI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6238.namprd10.prod.outlook.com (2603:10b6:930:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:52:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 12:52:43 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Mike Snitzer <snitzer@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd/filecache: add nfsd_file_acquire_gc_cached
Thread-Topic: [PATCH] nfsd/filecache: add nfsd_file_acquire_gc_cached
Thread-Index: AQHbJkZRJKeBbZMiH0yQ9Zrq2PLSGLKWx6wAgAClS4A=
Date: Fri, 25 Oct 2024 12:52:43 +0000
Message-ID: <4EDD901C-1CB9-4F99-A35C-3FCBE6F115B6@oracle.com>
References: <20241024185526.76146-1-snitzer@kernel.org>
 <172982525650.81717.5861053414648479623@noble.neil.brown.name>
In-Reply-To: <172982525650.81717.5861053414648479623@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB6238:EE_
x-ms-office365-filtering-correlation-id: c6a914c4-fa7a-4dc4-b632-08dcf4f3eb05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXprQ3JGYlYxZFlIb29EM2svOS9JQ3NzRCtMQUdhcmZoYkZVak40ODVjTmRa?=
 =?utf-8?B?UjhWZGJhSG5DTG1INGQ3SXJKOTlyaDNoRjRHOXlQS2gyTFlpSXpmNlYxT0k0?=
 =?utf-8?B?WVBxdUNHT0xVMllkUWtxRzNUZVZHQm9rd1g0R2hibXIyNkZ3UHlCZWdSVzdW?=
 =?utf-8?B?RDdxWFkxVkdyZTBuTVR6a2dUTk9XckgzTFp0Vzhzdi8vTUQzLzBjNHJUZG9t?=
 =?utf-8?B?VU1MTGdFT1gvajNvVW45NjAwNTNzOXIxTStVQTJhZ25WUloyc2hYd2N4MW8y?=
 =?utf-8?B?K0RXbW80b0QvRVltV3Q4VUFpKzBNeGVxM0lKNG5kWEJMMzVjOGVTdytMWUMx?=
 =?utf-8?B?b25DVGEwWFJvWVNUMlJwRjh4eUp0cGJ4VTlLV0JkYngvQWtJdmpvYmNpWlJt?=
 =?utf-8?B?cXJGYjI2d0RKRjRMQW1rOVlOODEzbU03cm1hMjdXZHZMcDdIQ2lBVGtVU1dK?=
 =?utf-8?B?Rmd5YkgvblBJZEl5S0lZNHdkUnM0VGs2dXRhWkRDZmh2K3V2SzdkM1A1MkJF?=
 =?utf-8?B?ZDkyVnE3Zm54M2RtVVA4RFpVSTZlS3VUNHlSQzhwNTVVcG9sTEs3bzFmazJP?=
 =?utf-8?B?MjBrTURpSFdFMnpwRzlGaHFmSVZ1U3NOeCtuenhHSm5XWDVPNVU2aUNVMGU0?=
 =?utf-8?B?L3lCbEpoS0syYXppSjMwTFBUTnY2Z25lSXd2OW5ERGl3VlBCWTdxSHBQZldD?=
 =?utf-8?B?Ny9Eb1lhZ0tEL1B4ZXdCdFZNNUFwaUN2TDJHRksyNXA5VWJBWmU3RHQ3Tjlo?=
 =?utf-8?B?U2JOcEU4a2g3aHI5UDZTSCt5TFI1ZVZSRys1anZHTmtsd2R1QjFTaEYxUW51?=
 =?utf-8?B?UVZEMGtRbVc4c0t4NzUxRFRWVjlxZTVrc1ZIY3dQbXVEQTdzajVKd0VmMkl3?=
 =?utf-8?B?Tk9KUWdnajhsUDFFc3JZSkhWa1NoYkhBc0NyOHZLQ0R2RXJ0ZHNPc3N4ZWR3?=
 =?utf-8?B?b3dzVkkrMHZlRTBpbU5FdU5BV1FoRW8wZ0RZR1NpQkxMRC8yMjZBbVg3bnVT?=
 =?utf-8?B?cDh1dzlLQnpSNHdSdDdMOEtkbTk2Nm1zcUl2OUF2RksxdnV3WHhYbXYzYzJC?=
 =?utf-8?B?M2QwNXBhWlFqYjhZSi9XOWhxRmpXMHgwRy9YaDUzNWlXM056QTJUNFRUTS9t?=
 =?utf-8?B?QTlqV2g5UWM5UmZLeUt5SkVzYVB4MTRFN0RGK1dLd2FlQ2VvYW1qQ1JXa2Ew?=
 =?utf-8?B?eVFkV2NCTnpzSG5IcGU2cGZTRUFDU0tIdXgvaUd0ZEo4dU9OeFU5Vllpd21n?=
 =?utf-8?B?bGlQYXJsTjZ2ckJOcXF2SHhPbTd1cFpxSzd1RFlvZFI0NlNEMk9wZUJlVjQ2?=
 =?utf-8?B?T3NQSVV6cVhSYTdhZXE0SENQaEF6WE5OWmtBYk93OTdnZUNSTmlHaXR3WXRL?=
 =?utf-8?B?b2tGWC90T1NBcUhaK2hNcVNYcW1DWE1leWI5dGc3cU5scjZsT2dtSHdyNlVN?=
 =?utf-8?B?ODdwTXMwSG5CL0xzeExjaGN5ZnJoQlUrN2RBaWFDVldJY3dHcjlQU25EeTZD?=
 =?utf-8?B?ZDhiQVVqZ3hjMXJYZGhIcU53d3dpUy9WUDFSWlk4clhxUWVnUVMrYXhZbmhQ?=
 =?utf-8?B?U3VKZE1ldHdFSHAwTCtsdUs0RGRLT2RhYVV3ck41aGp5VDkzNlMxVkpqdEZT?=
 =?utf-8?B?b2RZNHc5VjdhUzk3RUMwNGxMZXBVODkrclh1YXh3TnBhcGtwTTduN1RaQ1pR?=
 =?utf-8?B?dlhCWHVibWh4MlZUajlRdkVSNWIxcm15MEQzQzYvVy9qN1hxTzUrOUp3OEha?=
 =?utf-8?B?ZlhETWdKTzRiOGhIR3NVK2ExbUpxUHRKNjk2RVJUcFN6NmtlRWVYMFl2eDJ1?=
 =?utf-8?Q?nJiyVUPpGtpSnAgAqK7ppp7+HTDkhNZMTBvao=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sjl4K2laeWZHdnZremIrck5YKzJWd3pWOUdBWG5Rb1hpWEx1eUlLVklEa3pp?=
 =?utf-8?B?TlR3NW9mcXNnWXluVXd0Z0VLTXF3NHBrMlpOVkh2cHdQVzVPdXc4Zk56bE5W?=
 =?utf-8?B?RENsM1JFZXdodWhXYzJCSUVBYmVjVEZZeFo5MVpaZEs4OUJkVDhuVHBvZkcx?=
 =?utf-8?B?ZDV0RE5DUTVNNmJUZmlwVzBUYzZvcFY5SkFsbERzSi9zMlJtZDlqb0ZQNm5w?=
 =?utf-8?B?ZmI4TW00c3NKcUc3dnZFNFpZS2h1a3FwLy9vQnB2QjdReS9odFd1bjlQREs4?=
 =?utf-8?B?ZjJFdWpCOEx5QWg1OTRRUU9Fak1BYXJYQ0kwai85Y0MrWTVpU3p2b0NYSDdU?=
 =?utf-8?B?bXh1U08xNzE5TXRrU1BBVGs5MnVkMnMzWVdpR1hUK1BHL2t3amEreHRobjhM?=
 =?utf-8?B?NDQrc00vdWQ3S0J2SHlkQVJwNklWMU40MysxeHVVa216ZW82U3dOZVFESUMr?=
 =?utf-8?B?YkQ3c2w4N3BZZTZlRGpUc1JRUWVLZTZyVnBnTFFLbnA3OTJJL1BnODBZaXh3?=
 =?utf-8?B?NEFkdWtqU3d6bE8wWEpWWDM2WEx5OGprUDZJQXhrU04rRUxWMUtSYm5aejNn?=
 =?utf-8?B?SFA0cUZMb1ltcGVYWHVZRFVCakVoMUwrQitOYVN0YmpmNmNXbk9zOVVmM1o1?=
 =?utf-8?B?RUtLeW9kQWk0c1lHbkZWN0NuMHJWRVFNclc5bmhyT01RTkJPUXh2QldOYkZ1?=
 =?utf-8?B?Mzc2aW0vbnFZYVBZanZYYzF4YVcrM1Z5UXdFdU14SUw5NjRXSTMxTEEwQkwv?=
 =?utf-8?B?UlNsNFJ3U1Y0S0tZekNUdFZEWkRTU1Jqdi9IUW5FUUhWb0NudXd1K2t0WFYv?=
 =?utf-8?B?S1BOSEdiK2ltakpOR1ZSaDFYSWx5cWtZcXRWM0RGbWU1ZmtwbmNEVXhWNFhE?=
 =?utf-8?B?MmlHa3YyemhSSWc4NkhIYmowVUFBWWp3VHpRVlBiSVY3bDFyZmdkcFdmeGt4?=
 =?utf-8?B?VExTMmQvU2lzbEU0MXBYaW5PZDJ6N1NMZFhvOGJra2FnVkhmeUhCKys5c0hJ?=
 =?utf-8?B?cHA5eUd3KzNyRzNMVEZxK3pLU1Y0UEMrMHAyT3RRdnQvV1Z6QUlkVGUvMWly?=
 =?utf-8?B?c3ZYRWxyZW9SNnd2WFB1dzlhb1VFUlRXZWdFTzJoODhOekhZWHMxVFM1Tm5q?=
 =?utf-8?B?NFkvRzNSNk5HVWFzcFlCK3JHaVRQeFJFTGVoOUh5ZU95SHZMQTZMSUFPcU5m?=
 =?utf-8?B?VXdIeVZiL0dTWU92U0JOYmM2V1pTTld1VVh0VUIyYnE3WGRsRVNXbTFxdWZS?=
 =?utf-8?B?OXVNSFdidWRoQkkrSEpBbTc1a0Q4YXFLQktRQTRONjRIZjUvaTk4a3lCU1c3?=
 =?utf-8?B?Y3p1RlhYVGk3N2NUa1k4cTN2eDFSVFBVQ0V2NEp2bWNVNXdvRU5sSmtGNGtF?=
 =?utf-8?B?WTJxZU80WEJnQWpndDN3MU0yQWc1c042TGNqdzB2VTlEcXJyV1dYNG5NdTJU?=
 =?utf-8?B?TnExaFZaUk1MditTS3QwbDcvUHRubmV6ZGVacmhXekFZTVhWN0sveTFZZkNN?=
 =?utf-8?B?d3JqWnpTS0g4U1ZBL2U3VnIzMjNibkJkYUUwQWVhOVlnRFF2bTM1RisvdlNp?=
 =?utf-8?B?ek9IYm1yQ1d5WUxmbk1sSXdZRWJqR0hPZ0JYNFpkQ0xQUG04SXBpczF4N2pC?=
 =?utf-8?B?OWdVd0l0SHRXZ2JxQ1A4V3VJZk4yV1hkUk1EdzZqZS9sTG45S2NIU0VFRlFm?=
 =?utf-8?B?MGp0NWpOSnN3Zi9yY0pUUDI2STBOZ3YrWlY1My9Ld2FlK1d0VnFBRWVPYUtV?=
 =?utf-8?B?THVDWkludjZpUVVkN2c5ajVPR2tCVUdBcWdyQXIvcnVJQmc2RSttQWZTOVEr?=
 =?utf-8?B?Y1dhL2J3K2h0MmVoM0lpeWtldGhmM1ZxVlBDSERTcDVBMzBCQTNIeTVqNVVU?=
 =?utf-8?B?NTFpTHh3bzZVN0ZsTXNMc21LcG9VOWh0dXR1aVZLWmh0NWs3MW5TeGVBM282?=
 =?utf-8?B?VzVZZzJhQXJVczRNNHF3VjVlVHRDSVdkWXdSK0lKcVBmL09VNXhwUllhcHRn?=
 =?utf-8?B?NFdYKys3akJKc0ErRHRFUEhUNEdZRlAyTXdja1FKalNINE05OVNtQUd5bVVa?=
 =?utf-8?B?OE8zQURpYXBuZ0d2MjZGaUIwUmRpLytsaXhoQ1VybTRZR25rYSt4cVo2Ukhk?=
 =?utf-8?B?QzNoYzUyY24yT2thYWdZUXNjRzVQZXBGb2plcXJBcndTMFZCbHh2cW00YjBO?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCD3F7F7566BE54AB18FC686C7D51F97@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vl9bFOOap2ebn8ga6i7C5PuB/BM6N0uwnRVzgBWo1yKXuWE1GOqJXAStfqfJSKqRGj6tL+u6RmspZYaPwwp/T3XN721aVrLOPsSTIb+CDjpqw/LuC74cIii90w5UrKLYHfoHePhocfGG9YHBgG4uViX7ohDbh+Vs/2wqAUMpMfn+SV9ZEdL+ui8cnQgOE8GdG6SVWMxTRNJoTFlE2AQ9U1TSUt4fLG+vc3C9ljfLuAdOW0KzBI6E5IdGlxsuiqTnvVe5oJrGpYEpCKbmCfoLvyQ64Utu4uU5y6E69TkFNczXgiQ2DZNOlsLwi5wMXgnScLAddmQRXmHtM0MBTtX5+ZsGke68qC/oTatiBG4xGQ1WBZPbOA5hpFSyDVn9Vt+67XvoWMu2ann5Z7RpRXvcYoG7Vj2G56C31T3VIk4lg4z79VqBK0eDrk0vNPMJqq923Kw44EOLISMjZBfwBdIFmHxTjxFFjswFR3+8374WzvbH6tS/kdvLfIdJjRHt+hoO9yk9cuZsj3nl/dj60/yoG2JKuFk5DM1C6iR0NNb1P0wL1J6CS1ELyD5rH+7Sb/NZvlUB7YJ9/4UIOz8zaSXdIsOQ3EozOF8j9xQLULHKTtE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a914c4-fa7a-4dc4-b632-08dcf4f3eb05
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 12:52:43.6908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0Zd1O0FdxVQFyhfPfaNPc7jgJAC1/YqOc7nVCBXI3YEWe44lgsl0RLLBNM2TF2RrRYbaCMYwlPchfZPVEyV0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250099
X-Proofpoint-ORIG-GUID: frFBwyWEGN2lCxjuMGeiNlXxyVlD1hs7
X-Proofpoint-GUID: frFBwyWEGN2lCxjuMGeiNlXxyVlD1hs7

DQoNCj4gT24gT2N0IDI0LCAyMDI0LCBhdCAxMTowMOKAr1BNLCBOZWlsQnJvd24gPG5laWxiQHN1
c2UuZGU+IHdyb3RlOg0KPiANCj4gSSdtIHdvbmRlcmluZyBhYm91dCB0aGUgcmVxdWVzdCBmb3Ig
YSBnYXJiYWdlLWNvbGxlY3RlZCBuZnNkX2ZpbGUNCj4gdGhvdWdoLiAgRm9yIE5GU3YzIHRoYXQg
bWFrZXMgc2Vuc2UuICBGb3IgTkZTdjQgd2Ugd291bGQgZXhwZWN0IHRoZSBmaWxlDQo+IHRvIGFs
cmVhZHkgYmUgb3BlbiBhcyBhIG5vbi1nYXJiYWdlLWNvbGxlY3RlZCBuZnNkX2ZpbGUgYW5kIG9w
ZW5pbmcgaXQNCj4gYWdhaW4gc2VlbXMgd2FzdGVmdWwuICBUaGF0IGRvZXNuJ3QgbmVlZCB0byBi
ZSBmaXhlZCBmb3IgdGhpcyBwYXRjaCBhbmQNCj4gbWF5YmUgZG9lc24ndCBuZWVkIHRvIGJlIGZp
eGVkIGF0IGFsbCwgYnV0IGl0IHNlZW1lZCB3b3J0aCBoaWdobGlnaHRpbmcuDQoNCkkgZG9uJ3Qg
dGhpbmsgdXNpbmcgYSBHQydkIG5mc2RfZmlsZSBmb3IgTE9DQUxJTyBpcyBhIGJ1Zy4NCg0KTkZT
djQgZ3VhcmFudGVlcyBhbiBPUEVOIHRvIHBpbiB0aGUgbmZzZF9maWxlLCBhbmQgYSBDTE9TRQ0K
KG9yIGxlYXNlIGV4cGlyeSkgdG8gcmVsZWFzZSBpdC4gVGhlcmUncyBubyBkZXNpcmUgZm9yIG9y
DQpuZWVkIGZvciBnYXJiYWdlIGNvbGxlY3Rpb24uDQoNCk5GU3YzIGFuZCBMT0NBTElPIHVzZSBl
YWNoIG5mc2RfZmlsZSBmb3IgdGhlIGxpZmUgb2Ygb25lIEkvTw0Kb3BlcmF0aW9uLCBhbmQgdGhh
dCBuZnNkX2ZpbGUgaXMgY2FjaGVkIGluIHRoZSBleHBlY3RhdGlvbg0KdGhhdCBhbm90aGVyIEkv
TyBvcGVyYXRpb24gb24gdGhlIHNhbWUgZmlsZSB3aWxsIGhhcHBlbiB3aXRoDQpmcmVxdWVudCB0
ZW1wb3JhcmwgcHJveGltaXR5LiBHYXJiYWdlIGNvbGxlY3Rpb24gaXMgbmVlZGVkDQpmb3IgYm90
aCBjYXNlcy4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

