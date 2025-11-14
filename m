Return-Path: <linux-nfs+bounces-16398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC0C5D947
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 15:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DC5E3654D5
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783D2F2619;
	Fri, 14 Nov 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JZzAx9qF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OUCxBowJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076941D90AD;
	Fri, 14 Nov 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129974; cv=fail; b=NpFp5GEZY+rPhBiCqbFA8KCOdpJsZ7WET926fKdq1mGbRHNY5oQASyWxtYxQP400Y03ZrkGzRUtA6774HoBIUBZzH1q4Bd5Wu7iP9cjwFT/S3KOdsdEk4AYWlncZ7XvrjzsOAPvN7yejP5HURAdZS38pRi6EI0c7F207815JMmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129974; c=relaxed/simple;
	bh=ApwkHjTmQsBvYMNC9fvF7sUz2ajW5HNaTbTorYkJ1vE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcvraNcti0Fw93eUIWhcOisotuY77WvUQbo0JnD03nLn4R6mvtRYUTl6xyg4K442CGdAx8ZyEnOVE5Dc6ELknIb0oLLJNUuDIILvgdgfHeCbZFQki4GdQIcmuclWsm47igsMi3iBW7EwYKWJu99awo5yEwzB037h5oJep2UyaXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JZzAx9qF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OUCxBowJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuMhv008116;
	Fri, 14 Nov 2025 14:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vuaGcHgxrgTR+CngMks5QCRxQs6bdNwlxDH+b1jGlFI=; b=
	JZzAx9qFfLx3/I4hA3VV2ddCWsZ7LsA+3F+zp5/TZKseqvTcxkALkwrtP6svVek5
	H8NSOQGn34/MIdrjCFSpMSEmZLQRxvcOazDXBs8m3tco5tRJbXhNbugE5hmuvlYv
	nCUJJH9nksMwa6sQfa7kzXOSp/icZ1NWvfu/VbaA5hMdeXkbWesJT5yxEAz0dwcS
	sRg2n/02n5IUa10a1IgqH5arE2GGIc2xWKJKYw5eKEkbx8X+KZSPr+KeH7WbFGUJ
	sfT26nUckpP7e5tGxAH5ad/wxKf/Ooc7Vk9YztZuGb3MhDNBmwJgay2SsWxR7JQA
	l/dslxSlI676ReUzM/qZIQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adrdjh7hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 14:19:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEDp8ca000434;
	Fri, 14 Nov 2025 14:19:11 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vah4uqp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 14:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W58qizPR7+Y5g8mQa1/WcSFGyqxelZM+2/EvtX7sJ8rI1YaRwqXVQqqX0eps9yWZ7go0AltsgkxpTuC8LoFFl9HTyGxm8glZFg+IfnVcMgJNcEVkM1SjSQEh151eCDbBXOuORqKpHDrM/ZDNtpkrs8hPKKw+QRM7CoiP2jBUev3g6/RH5ut1FGE9zeSb/CMM7oqCGE5ch2o5fuqVA4Ua1oiyr+E8RcOpbKptMSmKPwnitsa3rh33ne/jWXcrCt3Xaz8bIehMeh6I8xaIirL6gKDusyyVD634T0S5ShHLoWzKw6hcNAywgjAeOejufNfcKo0l+5H+U7+koK1Qpd1irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuaGcHgxrgTR+CngMks5QCRxQs6bdNwlxDH+b1jGlFI=;
 b=TPE9YY3dKJV7Ov1AX+F1FSRxdWtpaKKtMx3VYLf5p/Mx2mtEnW+IY8ahox76+1qoZMkjXzWzEaIGPMiyS84YanycwQWalu/0ug678nmdNER7VITnLPNZMTxyeNAZUY76/HDmAZoZ1glTGNIgLeAqRIU5m0DXBIRIUqGgynEdokNJPp3PTnuErKoTh69qAeFHVqXSresm/79p0NmaIgLxngZZvz/u1q52ANdXHliOAeRn/gB3nflqqvUoA2Fc0Uxx4/JAjOjmsb8sb+i9F59ZNcudoRvwQKYHrjzHxAmchZh00b10wELSvIH/yiDqPZXLLGBTQ16O4gUFme5o0RbIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuaGcHgxrgTR+CngMks5QCRxQs6bdNwlxDH+b1jGlFI=;
 b=OUCxBowJsOp33QcDYW/eNwxXB9p9DXlQEUgq55ZdCrEc5NwheuPXEnFoNiT9ALJMJjvCIXJ7VACJeVQZaEC3zGsavd8ZfinBUI4i14BnTITiqqjs0bcnnfzFmuC2u5S1iu1GNJBQfuP9+kBlx5vA7s7UsKsSmNx8nsckMl1klBA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 14:18:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Fri, 14 Nov 2025
 14:18:36 +0000
Message-ID: <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
Date: Fri, 14 Nov 2025 09:18:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
To: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
        "1120598@bugs.debian.org" <1120598@bugs.debian.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
 <aRVl8yGqTkyaWxPM@eldamar.lan>
 <8d873978-2df6-4b79-891d-f0fd78485551@oracle.com>
 <c8-cRKuS2KXjk19lBwOGLCt21IbVv7HsS-V-ihDmhQ1Uae_LHNm83T0dOKvbYqsf4AeP5T8PR_xdiKLj5-Nvec-QVTLqIC4NGuU2FA0hN5U=@tylerwross.com>
 <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
 <aRZL8kbmfbssOwKF@eldamar.lan>
 <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com>
 <aRZZoNB5rsC8QUi4@eldamar.lan>
 <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com>
 <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com>
 <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:610:e4::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: ca29d84d-8cf1-4301-cb84-08de2388b37c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|159843002;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?U25NMFhxcGpScmpqVzBTa2ZOYkpna05GUEprVnRPUUN0UWRyUGRlbWlQL3Vk?=
 =?utf-8?B?anNOazIvZDJwcTVzNzM5cmJWdEVrdnh5ekRZRWphS3lSRThQYzRLZTh5TTRK?=
 =?utf-8?B?T2ZOOG9BcHNYektzVm9FNmNiWmtkNUNCUmdkS3hPdnNLcUlyOXV6ZzZhZ0Er?=
 =?utf-8?B?WVZjbTV4MStCbE0wVk51QUlyQnFnbXFIMnVTVkpISEMzeEdXYURyWUVJdUt4?=
 =?utf-8?B?dFdLS21aNzFWMTh2aWpEZWdEdWFPQkZrOG9LUjFZbXV0enc1dDNVTGRiNzlq?=
 =?utf-8?B?QkVxYm52a0pSVjhqNmo3cjdzZTNEMklaemJDeHJkWXJTdW1ld2ducDBHdC9i?=
 =?utf-8?B?R0RjUzJFcU4vbWJ6dU45ZEhIeWQ4dWFrSi9icXNvbzJHYnI4SFh0djVWeHh0?=
 =?utf-8?B?Zm9iYWkzdU1TdUlIM3QyZ1kwcTBaZHl6VGVRV1J0ejRkZlhxaWdhb0lnNlJs?=
 =?utf-8?B?R1hiKzY2WForSDg0T1l2aGhjV1lhYVJpZDd2c2RzYjYwTE8vL3hVa1g1VXR2?=
 =?utf-8?B?bFBXV2p2SFc1VHhqN200aUYrTGRUbnVHWUxaN3V3UGZ3M3ZxNEZQWVU1aWxr?=
 =?utf-8?B?eHpHSGJHZlMrTkFkV0dRdUZHVDFTN1E2MldWWlJ5anVnMWNLWnpxS0ZaTU9t?=
 =?utf-8?B?WjdDR0s2OWNXK3lwSWs1dkpBd2pLNWwrTEhOUjMzdVc4cmJuQUVsZDBsbTFl?=
 =?utf-8?B?V0FoVjVYU3hISC9tRFlSTWRPZW13QWVsYWlBbEQvV3NWd0tvRm15TzlXNjJ6?=
 =?utf-8?B?d0cycURiNTBDZThtTXZjc1kvS1VyRGJ5ZHFQZTFPWXllSW5NN0ZnV3czZmp4?=
 =?utf-8?B?cVlURW52SWYrWER3aVZYTThIOTlRMktNelR3ODJ2RUtsT2VOa2hRRElxaER5?=
 =?utf-8?B?UHhGLzVod3kzK2F5cVRETS80b1cySEhKK2lmU0NCbzhCSjYrNTJjTHFOd2hx?=
 =?utf-8?B?ZGw0bEUyTzJKZWtQUFQ2cTRiaU9NUW1ieDVKbE83Y3ZmOFNLK2NrZEtTQm1k?=
 =?utf-8?B?QWNJcm4rcXBuUWZNTjNSOWFhYXZaQytYenY0TmRTeHpKOWxhbUhQWnBYOCta?=
 =?utf-8?B?MVhQa1ZUUi9FYzlIbXpUQ2pCUzBXY0hRSWFjdDJITERyNUFBZk93aXc0Q1M3?=
 =?utf-8?B?OHRlbmlNeXdKUVhhZ1lMUkI1cWtOZGFtS3FNZkV0QStFWDc2OWdRQmhBT0Z2?=
 =?utf-8?B?c3dTUFdoTkw0dGlvRU95Mzlxemh0bTlmdjZ0azB0UENiNmdsZ2xqMnB6dE85?=
 =?utf-8?B?VDBRTVhvdlhMaS9YSnVwMTJkZkdjQiszdWJSNTRoZzBCdWdDZ0wvaEZKeU9J?=
 =?utf-8?B?TENJNHdpZlJzTjQvSVA3MlduNWEvQ0dpZjhDNXg2eG84V280bFpLSHhYNUF6?=
 =?utf-8?B?QWZwRG9MdDNKUUZRU0t6UVE2MHJnekVaK3lUYWs2UUx4NVZhNkdhVnV0MXBw?=
 =?utf-8?B?NmtBTk5oUWlPbERSVDFHU1c3MkVuY05Ec2Z5QnJaT1F0Mzk3V1Y4R3pDTTlU?=
 =?utf-8?B?TUVDNnBFVk1OWjByYTZCQmlRQXJKTExIOHUvSDZvS1JsV0xoZ3pYZzg1Y2Vy?=
 =?utf-8?B?TlAxK21HSXo5R1YxQ010WFh6MVRpeTdaTHJpUjJNa0NoMnlHNGQ5dVBROEtC?=
 =?utf-8?B?Y09SdytLR2xtK3VTY2ZUa2VUWCtQT2R0QSs0V3JWUHNHOWxLK3VtK21QUjA0?=
 =?utf-8?B?T2xXN0plOWY3QWNzelNHR20zSjZDR0J0VnV2Y2pBMXY3MTlacVVwbkFKbGw0?=
 =?utf-8?B?N25DTk52WE5vbngvWTM4UUVmQTRyZUVKNTlpZmJqdFRNQWhlOUdWY0dmeG0x?=
 =?utf-8?B?SW5sZEt2U0pTUkRNbVhnZnpickNsM0N3VE55VDQ0Vk9sNDVINjNlQlAzUHZ4?=
 =?utf-8?B?bCtNRkpEeWNjQk8wOGEzYmd5Wk1IK0drYi8vNWlaRjIyc1VTa3YrSFBWNGU4?=
 =?utf-8?B?TTZYZDluaFVYWDVhbTAvRlpkM3lRWjRWTnZQVXNBSEUraG1helZWYjdnajVx?=
 =?utf-8?B?cVpBNWFPVlF4eXpqWVUvbkNwVUo1ZVVScHJWcUhhZGdxMmtsUVE5dTY3SEFr?=
 =?utf-8?Q?yS6UkH?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(159843002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?N3BvbmRUNTh4empySVZhc3puU01JZHhjcXM0YnFvZmJDYTdyeGliN0J1UDll?=
 =?utf-8?B?WWJ5OWcvN3JNaTlzKzZGdHNQVlhFZGt3eE4zK1ZORmQxZFFIUVZzWWNXUjBH?=
 =?utf-8?B?OVF4U2lKblBQeG5mOGpPSSszdmtTc2VDVy95MFg4ZnplMnB3MW40d2JERGM3?=
 =?utf-8?B?b0FwNnZoeXk2NktjOW9lTDBMbENPREkwb1BTYzdRaUtES2xSZWFvOTgrNE9w?=
 =?utf-8?B?YzZTYm9FcG1xY2o4TDFMa1g5UVpZaE02R3JqT1N0eG9yNmltdERqUm9FUTNI?=
 =?utf-8?B?WGcwT0tTL0Fla2xITTZ4RHNZT08rN2RkellsVk5xNGxwNnVtSDhtYmo1d205?=
 =?utf-8?B?ZE5aMVdRdEw5a09SQ2Z5aENnb2JWRXV2S1U1TUxITEZndmF3ZEpWcHdYOGxN?=
 =?utf-8?B?UmJMK2pVWkgxa2phTW1FNGJjQUp1M0Z4NlBENWpnUUJkL016WkhTd1BXZlNO?=
 =?utf-8?B?cXBzU1VxVXQzN3B2enFQSnZSWUdaSkRqU0NwVlFsVk1mUlZvK0taMDJPbTY2?=
 =?utf-8?B?ME50YWlYbVlnZllnN0dBMlRZTWxYUStMYlZBWExiMjlQOWQvT2dWRkRwUVZH?=
 =?utf-8?B?ajVDWEZCYUd4UDlXV0cyT2I2eFpGVWo0UzJmVDJvVU1aRWFXZkROcDZTR0Vv?=
 =?utf-8?B?UDM3alhGdHF2ZnVWTldnUGpXVWFjS01BTEt3OUR6STVnNjB3NnozYUJxV2xU?=
 =?utf-8?B?Zk9jS0MrVmltd21jWnZYc0xpRkQyL2R1N1k3TTJoeGJQSzJhM3VrTDl6MDRs?=
 =?utf-8?B?MWUya3VNSnZJNXRoUVI3MHp2Y0NYSmlrV2VBZUlNQkN2YTBwQmVhMzdaVVdS?=
 =?utf-8?B?bzF3VkpSSmNNK0pmRXFzaUlTZlE3V010YzhOSDRlY2dxMHYveDRQcmZ2VFVW?=
 =?utf-8?B?TjI0RjJaalpFbytNS3hIWUR6b3FhYW9ZeXR3UzB0ZS8wSTNiZCt0MDRwYnV4?=
 =?utf-8?B?RUhTS1A1M2VOOEIrbWtPV3YrZjFZa0ovUXpneUNscERZL0hZQlJpcnZuSWcy?=
 =?utf-8?B?UzhXVlBUVU9XUFNNZUVsZTZEVDh3VmxsblB2Sk9NelBRQ3pTais5SGVTWXov?=
 =?utf-8?B?TEQreUFQTXAveTVLYklNVmdPRCtCSnpaV0V1d3FFVmJxME1ydXR1ZXlXWEp3?=
 =?utf-8?B?SDZyYlJpc2UxTTFyd092UVFJSXBrM0xKK2YyUDNCc0dJQ25aYTljc1J4Z3pS?=
 =?utf-8?B?QXdJQlN3Wk9kc2tlMmt5byt3N3B0VzNrYWZMamlpU0FWcmpyWG9tUFhhdnN3?=
 =?utf-8?B?SUJPSzhmVkIvYVN5ZmIwRi9RL1lzU0JmUWpSQ1laVlRxdmxWeWUxVEFJM3Ez?=
 =?utf-8?B?MkoyUmNrcnlORnJlZmkrTVZGNFdmSHlhMkV1Rk56MlJ0VGk0VzVvbCtQYW1a?=
 =?utf-8?B?blJXVmFiNmZ5cFo4V1prWWlzZ1g5a0Zqcnl5ZWlJdHVxYkh5MWpkRWYrdzVi?=
 =?utf-8?B?ekJYMHpCV2FLQ2E1VVRpZjA2bjRON2lBak5PUGhJS3lDdkhiUkU0d3R2Wmps?=
 =?utf-8?B?WVpNNjVNVEJ6cHlsTXMybHM4NUh1bUdLSkhpTFdrM2lUT0pqYUdtdUx5cmx1?=
 =?utf-8?B?OU1oMUNJWWx5Ny9vcGlycnoxM2JEZ0VOdGQrSHRFbHNaMjNXVHRweGNCWU1t?=
 =?utf-8?B?V1d2dlQvRWd4OTk4aU5oVnFYaytDR3NmcHNyN2Y4bjQyZTBDaVlIZnBEQ3lW?=
 =?utf-8?B?M0dLRUhBQm0wSDJjeHAwa3NnNkNXeUlwcUY4cmVqOVNQMGJ5dUk3U0M1cWVN?=
 =?utf-8?B?YzYrSEgwbllRSldUem5BMlp3OWdLZHc2d0FIZnZOQTkxK1p1Rm1tR2YzQ2FZ?=
 =?utf-8?B?UnBNN1B5Y2N4Ty9mbDJOYWpxODE1akgrMkZaL0syMmVQUDI5R2hhckF4MXZh?=
 =?utf-8?B?aUFFZDd4MEhMeHNnYTNBVDRka25OU3ltY0NtbnpWb0kxd2M4QVFIdHZHVTRF?=
 =?utf-8?B?cmZuSlQ1bmR4ckpYUld2b2ROZE5WZUF3T0dTWHl4VjZ3RlhIcURDTDRiL3g2?=
 =?utf-8?B?U2ovU3MrZGZ6MzN6cmNBWVhFYnAydmtMc0xYVGpxSkxoblNYR1R2WjIxUEsx?=
 =?utf-8?B?R2d4MkJYVUMvU3RYUm5sTnU0M3V3ckJFc0hvQjg0L1B2YVZpOGFTMy9lN28y?=
 =?utf-8?B?ejlzVnlSaGhyYjBmbnpTRjhuMFNuNzI0V00yOFY3ZWFqT2kzWnFNeDZwSEoz?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o45/+zmDfHg+KaGWCfq5O0rd/3iwcDEjGKf0m0AqIeyY2WF/llwvVvKm8jc0ikzwn0DlwlkqY6k/bzFrIIMchP/JHkpBk0Nat6pOu6xzmJlQgAvnMd3GbOW/oAqqLY2P27Z30tQ1gZM3+6vbii+ca3naQqJIz8UpOKUb8TK6t2mGWgsM40SJZIJew2UnFCrZVxqZX+KBi9aZG/gGjMRgdjjtkZBwv6J6V+QNKUA+81b4MSJaAlXNqZkTfPocyehOdze55SeDCnFCVSS6Ff8C8UYtNi5vCWXlc99Lv6hefh6TBY1/AgKsT41t2uvJVE5OrNmXfzayftXE6zp88+gs/w1PcwYtHEWacjdzXuGyNxJ/oJBzmQGoZlB0P5xt6qu6Xk3yrRKzIjuzx8EmxC/c36XjdV6sJhrjlnA4vMd6FjKASB5owxphX+afe3mj3psJKJp5bZc2BMsvJDhYZv9AE62s9+cV91PCAGZl6rgFsmTIM/Ws6jfg88Ht0oNHXOrergo5t/RDQiMcSqhROpjfYw/ATbrUsl9CW32PlKgJic4E6Xxfnqip6hg9WFALr6+AGEvW508XW0EfTYV7cKoGgvwDYgx99CKIVuA9Ifhu3ag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca29d84d-8cf1-4301-cb84-08de2388b37c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 14:18:36.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sEhchupqQ17wxlg8x9ZJGUvOAfD1LF4W05DKk2uUCWakzfr33O4F69nlpCwQGtPFPo26KW3QN/BpKtmoXnrfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511140115
X-Authority-Analysis: v=2.4 cv=L9oQguT8 c=1 sm=1 tr=0 ts=69173a60 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ZYV8scBFAAAA:8 a=UpWlY88HVqI4M27sjY0A:9 a=QEXdDO2ut3YA:10
 a=qUSo9U4VsO0qumkL3Uiz:22 cc=ntf awl=host:12098
X-Proofpoint-GUID: pF5jRoln0a7szeIM77S36gnVmXTuD7ZG
X-Proofpoint-ORIG-GUID: pF5jRoln0a7szeIM77S36gnVmXTuD7ZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfX/TF6/HHLksqA
 8ED5fAHOW0BQJf8Apf3PO/cpCDf7YbT91Hr5Ue7yQcS/8J9I6fZIAEFawraulKixT+cJC+ezmEY
 swXeDalm5AInObJu8Gb+MoctR5gscjzFS9RZHeSq7FL9e8sYugZqzKSWJO8PxaPPB7VIdncjt87
 GpbXvRUl7bOJ0twuPUygxk2YVyPkfkEIktK+z5pMb0ZpBGqhibLfEFau/5qIQ5C5MuhKVPgQy4m
 4WAf7Keux7QBiuzPTe6ylpm/k5gkD6O9WZ2FRD4aV8QNDI9QWWEFQZp/SmC0x9oP1TIAx5wepa9
 egAwxPcTXcvuBOMvoxddH4DYQLuZwofg+F6DamTrxrYLXjnxC3fKLMxGV+Zr6LBRxbUHkQtAmyB
 DrEoEXla2bHwJzPn3PvbToaZxjZnO56M5ZUy5oPDdBNhia2ZiWE=

On 11/14/25 12:09 AM, Tyler W. Ross wrote:
> On Thursday, November 13th, 2025 at 9:35 PM, Tyler W. Ross <TWR@tylerwross.com> wrote:
> 
>> I tried a couple vanilla/stock kernels today, without success.
>>
>> Most notably, I built 6.17.8 from upstream using the Kconfig from the
>> working Fedora 43 client in my lab ("config-6.17.5-300.fc43.x86_64").
>>
>> Unfortunately, the rpc_xdr_overflow still occurs with this kernel.
> 
> Quick addendum:
> 
> I had not tried Debian 12, because CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2
> was not enabled in the shipped Kconfig.
> 
> I just spun up a Debian 12 VM and installed the aforementioned
> upstream 6.17.8 with Fedora 43 Kconfig kernel and confirmed the issue
> also occurs on Debian 12.
Then I would say further hunting for the broken commit is going to be
fruitless. Adding the WARNs in net/sunrpc/xdr.c is a good next step so
we see which XDR data item (assuming it's the same one every time) is
failing to decode.


-- 
Chuck Lever

