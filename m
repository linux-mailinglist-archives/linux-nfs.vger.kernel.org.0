Return-Path: <linux-nfs+bounces-2695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03F789ACBE
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CFE281A04
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF64CDEB;
	Sat,  6 Apr 2024 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jGP4tx1X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ChjaYueT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB172FE0F
	for <linux-nfs@vger.kernel.org>; Sat,  6 Apr 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712431761; cv=fail; b=h5W8oHE2LRpc61JY+5wlCW7h7sRP5fsFDaBnZIWnv84ySwmfnjstLsBURgFovv9oKt64sEcuwdYIdYn0UEQ02sun0Inuqs9zxS1PvGS7MYm8301+EhrG7i/tyA1G9LVslkpCANGETBlqQmx8HTl6Lm31MRNvPdadxVFYbciqtlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712431761; c=relaxed/simple;
	bh=PC+5P6fQDGfpUuvtU69iX8GqSGLR1e+R5xC1jOnzOSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C/UQo5ct8hnucvL9NfNdcmR//pm3NirpkQjzdoBdzCd7NW7opnaztdaGfs593KGVHq+pBZjFV0QPwynqqwgF4u+CmgaplTz8oKE6J0+rKtXOmf4CqAJnzLWhvZs6lIGFOvreAJT1CvOG5IO2orMX8t2U0IylwixCzs0CwhG1B4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jGP4tx1X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ChjaYueT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 436IdcLg026471;
	Sat, 6 Apr 2024 19:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=PC+5P6fQDGfpUuvtU69iX8GqSGLR1e+R5xC1jOnzOSw=;
 b=jGP4tx1XpNDsXhYsXkhkR6GZUkoZXq6Id9nNC0Iu8odT4no7mEBoh0g1QArM+dsvWpeN
 rmB5xtqFrZuJXTJnI8yyGtKLi6zfonnXK2lezFUV3YwOdJGUMFT+ZHIMnmol6wfPLR06
 ssnAEmkFsjdxvJVHsjEQHYfebVzHEh4Zx6l9whsH9jAFkgIki0PhD12VwM6Tw6OzzLKK
 IWCchqYZ2v+/m/fdhfXdDBq0Lk8kl0IKvoaejtmX089SLfdsYuov/oON72O8M10HLYWc
 DW4Wp9HOLdkr5pE+OEGtKe6qg0BNJtknvjAIekPTJ3vrH+RUsJwwh4W9uGejLd4bfPQG 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedghqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 19:29:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 436EaTxK017931;
	Sat, 6 Apr 2024 19:29:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavua1v82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 19:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0zrbF3PSSORHaW8KnXWDR47IuavL8WdBRIs49RfpyFu+DgkVUWFToQqjz/9CQUaMR0+S8H3xmqTOxWj3USN5lasZNrn3qwORTMKHk2VOeGSMuvBzegnsB5W2GZllJ6rxbb9Z+7laq3ffQH28Fk+Lakd5BOyDoLgWcq3BG031bJU3hJsT63653qh/lE4s+EQOVs6U2Eo/sr0Sui8k97r37En4/TPVeTjPa2C7xvJaMSWv8ic83b7dUG9qLfb/+qK9sn5XU78dpIVc8dRTGiDIVh48iMMrcmsyQwlZLXQJYFpzIO0mNUWUF7Yy+b/2WvmzpzCJi42+KaDjBFA1ZEAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PC+5P6fQDGfpUuvtU69iX8GqSGLR1e+R5xC1jOnzOSw=;
 b=d7VDZhLtvgqhAE8C3xDTEmpmfeyNjB0Apg4XTC3n00MSZdUSeNq4ThkVX5tl5ipPAkuJJyaN6g9a+omIxkqy54mX+sH0Tt2b4zc/5R+hU8rC4J2lTbQheygI9Kf4estf7mW+lg3K2vZW4xkpHfvqewLMTWd1htGRLPwRA8lmxeYEwHxBX/axWdFLrhGEvCszuMY1w8GGk/zix0ZdhayvrHZhzCBSo4c1scxk6fBAoUCNmVRsocfY44lZWQ6YDxGg+iT/sQ+UPcyAO6AzfXiO40VlEH/KFy0UYETxD7ULOCLxUBi7CA4T9SSkVq/5PNCca3tLQ1lIoMRszppkfwJNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC+5P6fQDGfpUuvtU69iX8GqSGLR1e+R5xC1jOnzOSw=;
 b=ChjaYueTSWk18h5Pv9ajKyroyJskb727dgHc/Cwt8vQZBz23hkmTe6VEfisq5/zVH1gfm6vRvm7K9SK7D0HsA4458PnftHcIgg+93rZJLLBzfRy8peWXZuDIJQsda8J+oxv0I54m+MWBgMWH1TCh6Ty/dG+DHq9n//NieWNly/M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 19:28:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 19:28:58 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Salvatore Bonaccorso <carnil@debian.org>,
        Steve Dickson
	<steved@redhat.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "1067829@bugs.debian.org" <1067829@bugs.debian.org>,
        "1067829-submitter@bugs.debian.org" <1067829-submitter@bugs.debian.org>,
        Vladimir Petko <vladimir.petko@canonical.com>
Subject: 
 =?utf-8?B?UmU6IEZhaWxzIHRvIGJ1aWxkIG9uIGFybXtlbCxoZn0gd2l0aCA2NGJpdCB0?=
 =?utf-8?B?aW1lX3Q6IGV4cG9ydC1jYWNoZS5jOjExMDo1MTogZXJyb3I6IGZvcm1hdCA=?=
 =?utf-8?B?4oCYJWxk4oCZIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSDigJhsb25nIGlu?=
 =?utf-8?B?dOKAmSwgYnV0IGFyZ3VtZW50IDQgaGFzIHR5cGUg4oCYdGltZV904oCZIHth?=
 =?utf-8?B?a2Eg4oCYbG9uZyBsb25nIGludOKAmX0gWy1XZXJyb3I9Zm9ybWF0PV0=?=
Thread-Topic: 
 =?utf-8?B?RmFpbHMgdG8gYnVpbGQgb24gYXJte2VsLGhmfSB3aXRoIDY0Yml0IHRpbWVf?=
 =?utf-8?B?dDogZXhwb3J0LWNhY2hlLmM6MTEwOjUxOiBlcnJvcjogZm9ybWF0IOKAmCVs?=
 =?utf-8?B?ZOKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg4oCYbG9uZyBpbnTigJks?=
 =?utf-8?B?IGJ1dCBhcmd1bWVudCA0IGhhcyB0eXBlIOKAmHRpbWVfdOKAmSB7YWthIA==?=
 =?utf-8?B?4oCYbG9uZyBsb25nIGludOKAmX0gWy1XZXJyb3I9Zm9ybWF0PV0=?=
Thread-Index: AQHaiFbRQcASsj03ME6Y1APUWMzh57FboJyA
Date: Sat, 6 Apr 2024 19:28:58 +0000
Message-ID: <A3AAF9FA-95BE-461C-8E7A-C0ED02526519@oracle.com>
References: <ZhGfUpXclZeoZ_az@eldamar.lan>
In-Reply-To: <ZhGfUpXclZeoZ_az@eldamar.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6966:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4hEGPzooYcUob/JZ53C4t+ht+n9HRk8m7k0joVBShD4x14dOfBYxztSDIo7KZtGZtrAuEcVpMS6zHv0Ufei3DpZaai8m7Yz2zkU67arCR1xFBAbN9obbeNRgPCcJtcZ18x6K1rj9oGIjOLX3HgDyjB0FqOH/HZGRh10K5uX9m2+/GssgeMwRwE6NRRq9W0b0PS0eLUvZlUmqe06/lPDOIdVOkq+wx+u/hstwNic0Rs7+dPX5KmzOQpzyn7Mhu8GGBqOhVXgoDW/eufIDdE30dh5FMZwcjG3VkGRk540ZijLx2nPXcbvQV6/TRoBk9R99XsJSpzl19Jk4MR8brU1hR2PK+N9mca8qEdk+WjsJ6okGrFa6C9ByDIA6eAnFJK+4v9b6kjkr3a6HLYNbfFgYm7Ze49ly+nDnuwaMcBRNc3S1kgLoc/LwnP9Oc1mMji2s8w5D1hS3uCOCdW7P/r0hW0jGEXkTEZ3O8vxeCtHT8ZPlsLboqYxoZCT4hP+gSV4Li5CkCS0YUQu64Av7CFNu3ZG6qAnyqsuPhJcK6TdY+YBqgPZ4yQH4NnjLKkTlzNM6UNRGRbUYDJR0JUpbgeHmLqASwMb9DN03hd9afo15XeekGptlbl9zy3CH3S6mKqrj
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Zjc5cmRYdUZHWnJXaSt2M1o2bjJxTFp3b3QySEFRNHhUa0FHb1RPSHpCczNq?=
 =?utf-8?B?elo3UzhMSGlzU0FYZHhSQk9BTG51WTZiL0NtMVBNTEdJdjZkUkQyU3MzL21K?=
 =?utf-8?B?bmFjdkx4TzJXZDFTMnFNQ0llU0tmc1orWmtOY3htQ2gzRy82bVFYUUl6SGM4?=
 =?utf-8?B?SVo4QUNrS0hrL0ovYUIrMTJHR09JbnpydHkzZVVwMlhmQ0xDTVZDS1R3ZlNZ?=
 =?utf-8?B?bGJtYWZFaFdBQlFYdW5FQmhLb1Jrd25tUTBoRlNOcE1LWDlkaWQza3paWElX?=
 =?utf-8?B?Z2N3ZHUvekplR1NXOWFwWEQ2dWMxUWtYcWV0N1FvRmZSOUpXbDNVMk5UemZ3?=
 =?utf-8?B?SUhMclhkNGNUOGlNd2pVOVpndVpWSi93b24vT00rcnQxY0xPSGZ1WExDS0ha?=
 =?utf-8?B?VHp0Z3kwMW1uUjJPZXZIbU44S3RFejUvNWR4TXg2clV1Z2Q3MHp5dHo2dFZI?=
 =?utf-8?B?Qng0N2t5cE1qckVCUForR1hkV0ZjcjVmbVIvUHdJTW8vKzVwS0U4NnZCZmV4?=
 =?utf-8?B?cWlRZitFaGtUQ0lwMFRXWnNPd1ZHaDlHQUg3cHFjNnFYd2NNb3NpZnpXMWJK?=
 =?utf-8?B?Y05ad0FTN1dHbXBqemtDeUI2NGM4KzcvYjl5SzZLZkZBYUZKZ0FYK2J5OUtJ?=
 =?utf-8?B?WGVDaDFQdlE1TG5YMThtWEt6MlFaTzl5am5LR0tnYzBLN2xia3I4dEw3VEdv?=
 =?utf-8?B?TkY0UlBpV0pNdzVobHVSRDVuSlJRRGY1M3JCZ05VS3RBWU5jeVMvMDJlbDFx?=
 =?utf-8?B?c29mSGNKK1N4N05neW1aMC9VNGptZnFtOCt5YlNVU3F6blFsVlN5SHFKNWw0?=
 =?utf-8?B?NmlCQllZbEtHZkhZQktzQTJIN25IVWdnRy8rQzdINTRHaURtd3FSc1BvNjdO?=
 =?utf-8?B?SVJmWlU5Vmg3VTZUR1NqYmpBMXFhWEh3THUyYWRrMkFKaG5xTVFzcHk5RmEv?=
 =?utf-8?B?MEpNNklUckJxVzdLd21XNnUzU25Bb0hCdkw1RGEwZjBycjBzR2JWc0QwRzZW?=
 =?utf-8?B?U0Q4TlNOeXFwTFVXYzg1WG8wUUMrc2NKVWpqSGg0SGNZQ2tEZEwyd2xtODNi?=
 =?utf-8?B?c1UrbUN1MHFLREVtd3o0YUhBZGdKTGs5UWFXejFWaFdMUzZBSWZYTi8vMlVI?=
 =?utf-8?B?a29xTWUrYmhyTVAxem9QZ0tyMTcxMzJuN1gxZ09tRnJFWVdtcXU1NTdYTVkr?=
 =?utf-8?B?ZVltT0NKcGx4OWJSK3drV0F1MlRweW1icG4zVWJaVDh3cmF1WGo0U2c1Nkw5?=
 =?utf-8?B?Z0VqY2pPWDByWDlQUzZVem9FUTBaOWNMZ3lCLy9udGxXMGhEeTZ1ZU9HeDhh?=
 =?utf-8?B?TmNHRkRDQVFkTVhWRGYrQW5GSDZnUU5RN290M0tLMVJSQW94Zm9hQkJJdmM4?=
 =?utf-8?B?bmZuSUVKbVpXSk1MNUtDK1piRVdxblVZU3MyNUVtNm9yQnNpZjVGRzNWcEkz?=
 =?utf-8?B?RFlMcGZGaEVrL3VsNU1xa3k2ODB6K2x3djh2ZS85Z012L2ZVVkJSS3R1Zk9B?=
 =?utf-8?B?RjM0Yngrb2gvUnF0REVUSlU2TTFsQmNYbDNPY1dLd0RFR0lBRzBtanZuM1Yw?=
 =?utf-8?B?Yys3TC8yS2psQ255REFrNUR2cTdTUis2ekFiNzZISnZBZUlUMmNLa0w4ZFZL?=
 =?utf-8?B?SmMwR205OGwrSlBpMVpNV1h2YjFHWlk4MHBqbmZ5TkFQWTlQK21KVERRd2RE?=
 =?utf-8?B?L3B1enNuU0cyWGQ0djFmclRVRlJnQ2diUWF6OHVCME1zYWFybHVQUXJ5am5K?=
 =?utf-8?B?Snk3NUNXS2trSUpqdTczQ3RtY1hzcDdhYTFVU296akhNaGhRTUl0TlVDYSt4?=
 =?utf-8?B?UjVRYTQ2VmY3NG5hc2RQTU9BTjZDSG9ySXdJNFh3OHVRUGZCTW5FUGJvdkJY?=
 =?utf-8?B?aWVUelcwZFhLeStHQ0JsclhGV0t4ajUwNHAzVUJDMEgxekU1cnVXY0NxeGhL?=
 =?utf-8?B?K083NWJsNitaQzNydWxmbTU5VHJmNXZaaHp3SEx0S2hwRHZhQkZrdjdWektj?=
 =?utf-8?B?U29DbG5TTXlVN3VDL09vaFRVWDJ3bTZZeTdXenlPRnJoWERpSjJkL21wVDQw?=
 =?utf-8?B?bjl1OHJLYzNBSXh6TStvWmFTOVdJbGNOZEMvcG1iNVRxTzJKTUV6SmNNL055?=
 =?utf-8?B?MUxScjhHTCtvTGxKQ0d2Y2hPMHgvbzlXdnNSVTFXNGtXTHhFanc5YXNoRG1h?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE5A11A9860CB844948FDEE2A3B65C0D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ba0sLByElvgOQFvxiokgotNW9Vxv+/hiwiCAYujt8IXqP+f3Tnj9Tgzz3yBm9AWZwzoTZlDBASftxvTY2/U20WviwNMtkabO6YWlov0R6ARRWDP7xSfmnutbwgn/N4mFajwq3NwihTxKI8SoMhKwuU03ARnBwT2XFnDzbuPfQ7ShAJ7l8DIxh6TnGHDvR8tYYQutRsC94phnxOEPtsdBlvjEv7DAsUxy6luaaz/gT41yDv26imKNDeyKgQ3plIZ1ny2E8b8YhJGU6godzSpdaPQ5MGJZ/LkQUDrlbZL467TBgu6q60kk4pcfmoMpNV98E5wV38EbBM0v+b0hkGP2EtgLhXnSP6atDuX23TI8iijWHJh2/24+29x53CzfKD0Fbmq5sqp9WhN7BUwXTC2jqzteKDl3FBvrQ5z7ELs+pvsxNg7eRs8r1nGxxR5KiF13fDG2RvnBXPGzPEKN1zaxh66XiBHrPBscIXSeXrX2Lbve3hKdld0CK2gN0cu7zbi2aKknQ7X/NcdRpjA/xq4YLdb/CWb0Dgs7tHmhqBoMt9VsG0D1nmdA+i4ppXZ4bV5BDZSgqg3aOjI7ItzW50K0k2FWWBYRiIphTz+VBouruxQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb02e5cf-86af-48a5-a8ec-08dc566fce3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2024 19:28:58.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoQJXGQWosibKvdn/BJMz5FQGzdpevoTtjnrtojsj06KErjPcXtHwD53zjwCAZnht6NkOghPMntriIHv3fVL5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-06_16,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404060155
X-Proofpoint-GUID: U4vGSdiNe7ZAzBwuVj88DUbHi2TFvAmj
X-Proofpoint-ORIG-GUID: U4vGSdiNe7ZAzBwuVj88DUbHi2TFvAmj

DQoNCj4gT24gQXByIDYsIDIwMjQsIGF0IDM6MTXigK9QTSwgU2FsdmF0b3JlIEJvbmFjY29yc28g
PGNhcm5pbEBkZWJpYW4ub3JnPiB3cm90ZToNCj4gDQo+IEhpIENodWNrLCBoaSBTdGV2ZSwNCj4g
DQo+IEluIERlYmlhbiwgYXMgeW91IG1pZ2h0IGhhdmUgaGVhcmQgdGhlcmUgaXMgYSA2NGJpdCB0
aW1lX3QNCj4gdHJhbnNpdGlvblsxXSBvbmdvaW5nIGFmZmVjdGluZyB0aGUgYXJtZWwgYW5kIGFy
bWhmIGFyY2hpdGVjdHVyZXMuDQo+IFdoaWxlIGRvaW5nIHNvLCBuZnMtdXRpbHMgd2FzIGZvdW5k
IHRvIGZhaWwgdG8gYnVpbGQgZm9yIHRob3NlDQo+IGFyY2hpdGVjdHVyZXMgYWZ0ZXIgdGhlIHN3
aXRjaCwgcmVwb3J0ZWQgaW4gRGViaWFuIGFzIFsyXS4gVmxhZGltaXINCj4gUGV0a28gZnJvbSBV
YnVudHUgaGFzIGFzIHdlbGwgZmlsbGVkIGl0IGluIFszXS4NCj4gDQo+IFsxXTogaHR0cHM6Ly9s
aXN0cy5kZWJpYW4ub3JnL2RlYmlhbi1kZXZlbC1hbm5vdW5jZS8yMDI0LzAyL21zZzAwMDA1Lmh0
bWwNCj4gWzJdOiBodHRwczovL2J1Z3MuZGViaWFuLm9yZy8xMDY3ODI5DQo+IFszXTogaHR0cHM6
Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTg1NDANCj4gDQo+IFRoZSBy
ZXBvcnQgaXMgZnVsbC1xdW90ZWQgYmVsb3cuIA0KPiANCj4gVmxhZGltaXIgUGV0a28gaGFzIGNy
ZWF0ZWQgYSBwYXRjaCBpbiB0aGUgYnVnemlsbGEgd2hpY2ggSSdtIGF0dGFjaGluZw0KPiBoZXJl
IGFzIHdlbGwuIElmIHRoaXMgaXMgbm90IGFuIGFjY2VwdGFibGUgZm9ybWF0IGR1ZSB0byBtaXNz
aW5nDQo+IFNpZ25lZC1vZmYncyBJJ20gYXR0YWNoaW5nIGEgdmFyaWFudCB3aXRoIGEgU3VnZ2Vz
dGVkLWJ5IGZvciBWbGFkaW1pcg0KPiB0byBwcm9wZXJseSBjcmVkaXQgdGhlIHBhdGNoIG9yaWdp
bi4NCj4gDQo+IExldCBtZSBrbm93IGlmIHRoYXQgd29ya3MuIEkgY2hhbmdlZCBpdCBzbGlnaHRs
eSBhbmQgb25seSBjYXN0aW5nIHRvDQo+IGxvbmcgbG9uZywgYW5kIG1hZGUgaXQgYWxtb3N0IGNo
ZWNrcGF0Y2ggY2xlYW4uDQoNCkkgc3VwcG9zZSBzdHJmdGltZSgzKSBtaWdodCBiZSBuaWNlciwg
YnV0IHRoaXMgd29ya3MuDQoNClJldmlld2VkLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJA
b3JhY2xlLmNvbSA8bWFpbHRvOmNodWNrLmxldmVyQG9yYWNsZS5jb20+Pg0KDQoNCj4gUmVnYXJk
cywNCj4gU2FsdmF0b3JlDQo+IA0KPiAtLS0tLSBGb3J3YXJkZWQgbWVzc2FnZSBmcm9tIFNlYmFz
dGlhbiBSYW1hY2hlciA8c3JhbWFjaGVyQGRlYmlhbi5vcmc+IC0tLS0tDQo+IA0KPiBGcm9tOiBT
ZWJhc3RpYW4gUmFtYWNoZXIgPHNyYW1hY2hlckBkZWJpYW4ub3JnPg0KPiBSZXNlbnQtRnJvbTog
U2ViYXN0aWFuIFJhbWFjaGVyIDxzcmFtYWNoZXJAZGViaWFuLm9yZz4NCj4gUmVwbHktVG86IFNl
YmFzdGlhbiBSYW1hY2hlciA8c3JhbWFjaGVyQGRlYmlhbi5vcmc+LCAxMDY3ODI5QGJ1Z3MuZGVi
aWFuLm9yZw0KPiBEYXRlOiBXZWQsIDI3IE1hciAyMDI0IDExOjAyOjI1ICswMTAwDQo+IFRvOiBE
ZWJpYW4gQnVnIFRyYWNraW5nIFN5c3RlbSA8c3VibWl0QGJ1Z3MuZGViaWFuLm9yZz4NCj4gU3Vi
amVjdDogQnVnIzEwNjc4Mjk6IG5mcy11dGlsczogRlRCRlMgb24gYXJte2VsLGhmfTogZXhwb3J0
LWNhY2hlLmM6MTEwOjUxOiBlcnJvcjogZm9ybWF0IOKAmCVsZOKAmSBleHBlY3RzIGFyZ3VtZW50
IG9mDQo+IHR5cGUg4oCYbG9uZyBpbnTigJksIGJ1dCBhcmd1bWVudCA0IGhhcyB0eXBlIOKAmHRp
bWVfdOKAmSB7YWthIOKAmGxvbmcgbG9uZyBpbnTigJl9IFstV2Vycm9yPWZvcm1hdD1dDQo+IERl
bGl2ZXJlZC1Ubzogc3VibWl0QGJ1Z3MuZGViaWFuLm9yZw0KPiBNZXNzYWdlLUlEOiA8WmdQdXNm
bmtDQ3ZoYWx2ZUByYW1hY2hlci5hdD4NCj4gDQo+IFNvdXJjZTogbmZzLXV0aWxzDQo+IFZlcnNp
b246IDE6Mi42LjQtMw0KPiBTZXZlcml0eTogc2VyaW91cw0KPiBUYWdzOiBmdGJmcw0KPiBKdXN0
aWZpY2F0aW9uOiBmYWlscyB0byBidWlsZCBmcm9tIHNvdXJjZSAoYnV0IGJ1aWx0IHN1Y2Nlc3Nm
dWxseSBpbiB0aGUgcGFzdCkNCj4gWC1EZWJidWdzLUNjOiBzcmFtYWNoZXJAZGViaWFuLm9yZw0K
PiANCj4gaHR0cHM6Ly9idWlsZGQuZGViaWFuLm9yZy9zdGF0dXMvZmV0Y2gucGhwP3BrZz1uZnMt
dXRpbHMmYXJjaD1hcm1lbCZ2ZXI9MSUzQTIuNi40LTMlMkJiMiZzdGFtcD0xNzExNDUyNTUyJnJh
dz0wDQo+IA0KPiBsaWJ0b29sOiBjb21waWxlOiAgZ2NjIC1ESEFWRV9DT05GSUdfSCAtSS4gLUku
Li8uLi9zdXBwb3J0L2luY2x1ZGUgLUkvdXNyL2luY2x1ZGUvdGlycGMgLUkvdXNyL2luY2x1ZGUv
bGlieG1sMiAtRF9MQVJHRUZJTEVfU09VUkNFIC1EX0ZJTEVfT0ZGU0VUX0JJVFM9NjQgLURfVElN
RV9CSVRTPTY0IC1XZGF0ZS10aW1lIC1EX0ZPUlRJRllfU09VUkNFPTIgLURfR05VX1NPVVJDRSAt
cGlwZSAtV2FsbCAtV2V4dHJhIC1XZXJyb3I9c3RyaWN0LXByb3RvdHlwZXMgLVdlcnJvcj1taXNz
aW5nLXByb3RvdHlwZXMgLVdlcnJvcj1taXNzaW5nLWRlY2xhcmF0aW9ucyAtV2Vycm9yPWZvcm1h
dD0yIC1XZXJyb3I9dW5kZWYgLVdlcnJvcj1taXNzaW5nLWluY2x1ZGUtZGlycyAtV2Vycm9yPXN0
cmljdC1hbGlhc2luZz0yIC1XZXJyb3I9aW5pdC1zZWxmIC1XZXJyb3I9aW1wbGljaXQtZnVuY3Rp
b24tZGVjbGFyYXRpb24gLVdlcnJvcj1yZXR1cm4tdHlwZSAtV2Vycm9yPXN3aXRjaCAtV2Vycm9y
PW92ZXJmbG93IC1XZXJyb3I9cGFyZW50aGVzZXMgLVdlcnJvcj1hZ2dyZWdhdGUtcmV0dXJuIC1X
ZXJyb3I9dW51c2VkLXJlc3VsdCAtZm5vLXN0cmljdC1hbGlhc2luZyAtV2Vycm9yPWZvcm1hdC1v
dmVyZmxvdz0yIC1XZXJyb3I9aW50LWNvbnZlcnNpb24gLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9p
bnRlci10eXBlcyAtV2Vycm9yPW1pc2xlYWRpbmctaW5kZW50YXRpb24gLVduby1jYXN0LWZ1bmN0
aW9uLXR5cGUgLWcgLU8yIC1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb24gLWZm
aWxlLXByZWZpeC1tYXA9Lzw8UEtHQlVJTERESVI+Pj0uIC1mc3RhY2stcHJvdGVjdG9yLXN0cm9u
ZyAtZnN0YWNrLWNsYXNoLXByb3RlY3Rpb24gLVdmb3JtYXQgLVdlcnJvcj1mb3JtYXQtc2VjdXJp
dHkgLWMgeG1sLmMgIC1mUElDIC1EUElDIC1vIC5saWJzL3htbC5vDQo+IGV4cG9ydC1jYWNoZS5j
OiBJbiBmdW5jdGlvbiDigJhqdW5jdGlvbl9mbHVzaF9leHBvcnRzX2NhY2hl4oCZOg0KPiBleHBv
cnQtY2FjaGUuYzoxMTA6NTE6IGVycm9yOiBmb3JtYXQg4oCYJWxk4oCZIGV4cGVjdHMgYXJndW1l
bnQgb2YgdHlwZSDigJhsb25nIGludOKAmSwgYnV0IGFyZ3VtZW50IDQgaGFzIHR5cGUg4oCYdGlt
ZV904oCZIHtha2Eg4oCYbG9uZyBsb25nIGludOKAmX0gWy1XZXJyb3I9Zm9ybWF0PV0NCj4gIDEx
MCB8ICAgICAgICAgc25wcmludGYoZmx1c2h0aW1lLCBzaXplb2YoZmx1c2h0aW1lKSwgIiVsZFxu
Iiwgbm93KTsNCj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIH5+XiAgICAgfn5+DQo+ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgIHwNCj4gICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgdGltZV90IHtha2EgbG9u
ZyBsb25nIGludH0NCj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbG9uZyBpbnQNCj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICVsbGQNCj4gbGlidG9vbDogY29tcGlsZTogIGdjYyAt
REhBVkVfQ09ORklHX0ggLUkuIC1JLi4vLi4vc3VwcG9ydC9pbmNsdWRlIC1JL3Vzci9pbmNsdWRl
L3RpcnBjIC1JL3Vzci9pbmNsdWRlL2xpYnhtbDIgLURfTEFSR0VGSUxFX1NPVVJDRSAtRF9GSUxF
X09GRlNFVF9CSVRTPTY0IC1EX1RJTUVfQklUUz02NCAtV2RhdGUtdGltZSAtRF9GT1JUSUZZX1NP
VVJDRT0yIC1EX0dOVV9TT1VSQ0UgLXBpcGUgLVdhbGwgLVdleHRyYSAtV2Vycm9yPXN0cmljdC1w
cm90b3R5cGVzIC1XZXJyb3I9bWlzc2luZy1wcm90b3R5cGVzIC1XZXJyb3I9bWlzc2luZy1kZWNs
YXJhdGlvbnMgLVdlcnJvcj1mb3JtYXQ9MiAtV2Vycm9yPXVuZGVmIC1XZXJyb3I9bWlzc2luZy1p
bmNsdWRlLWRpcnMgLVdlcnJvcj1zdHJpY3QtYWxpYXNpbmc9MiAtV2Vycm9yPWluaXQtc2VsZiAt
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uIC1XZXJyb3I9cmV0dXJuLXR5cGUg
LVdlcnJvcj1zd2l0Y2ggLVdlcnJvcj1vdmVyZmxvdyAtV2Vycm9yPXBhcmVudGhlc2VzIC1XZXJy
b3I9YWdncmVnYXRlLXJldHVybiAtV2Vycm9yPXVudXNlZC1yZXN1bHQgLWZuby1zdHJpY3QtYWxp
YXNpbmcgLVdlcnJvcj1mb3JtYXQtb3ZlcmZsb3c9MiAtV2Vycm9yPWludC1jb252ZXJzaW9uIC1X
ZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXMgLVdlcnJvcj1taXNsZWFkaW5nLWluZGVu
dGF0aW9uIC1Xbm8tY2FzdC1mdW5jdGlvbi10eXBlIC1nIC1PMiAtV2Vycm9yPWltcGxpY2l0LWZ1
bmN0aW9uLWRlY2xhcmF0aW9uIC1mZmlsZS1wcmVmaXgtbWFwPS88PFBLR0JVSUxERElSPj49LiAt
ZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcgLWZzdGFjay1jbGFzaC1wcm90ZWN0aW9uIC1XZm9ybWF0
IC1XZXJyb3I9Zm9ybWF0LXNlY3VyaXR5IC1jIGRpc3BsYXkuYyAtbyBkaXNwbGF5Lm8gPi9kZXYv
bnVsbCAyPiYxDQo+IGNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0K
PiBtYWtlWzNdOiAqKiogW01ha2VmaWxlOjQ4OTogZXhwb3J0LWNhY2hlLmxvXSBFcnJvciAxDQo+
IG1ha2VbM106ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQo+IA0KPiBDaGVl
cnMNCj4gLS0gDQo+IFNlYmFzdGlhbiBSYW1hY2hlcg0KPiANCj4gLS0tLS0gRW5kIGZvcndhcmRl
ZCBtZXNzYWdlIC0tLS0tDQo+IDxhcm1oZi10aW1lLXQtZm9ybWF0LWVycm9yLnBhdGNoPjwwMDAx
LWp1bmN0aW9uLWV4cG9ydC1jYWNoZS1jYXN0LXRvLWEtdHlwZS13aXRoLWEta25vd24tc2kucGF0
Y2g+DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

