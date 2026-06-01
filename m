Return-Path: <linux-nfs+bounces-22192-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULXLJHThHWqefgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22192-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 21:45:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E97AB624C25
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 21:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B32ED3011C70
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3936F8F7;
	Mon,  1 Jun 2026 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TBcVRdWW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zOGIkFb0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B43377EA2;
	Mon,  1 Jun 2026 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780343006; cv=fail; b=Gg0fa1QuRY4UZ2TQ+tGzQSPE50JmPXsIfqt2jNBg68Xlgs5a8UtrQ8y8XwX9Dd7fzTqPpvLHj0cOJxi7JNwqcHm9gS5KuAmBNRAfvrNl6dJ+wN9uX1ZaBiBd2O+LRIIkIaVjB519T0Q1lGUGi+OuQqeuJLHKVJ1xehAMEtBRMG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780343006; c=relaxed/simple;
	bh=Lw8YJDQSFsIXx7Xh8hpW9DRiSALTu3vIHf6tAu8+c/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HhcGWM3swz9W68uEBUFtszvWjMlXoUjABBl5pUeqsgBAxBuwqpPOKyIU4ntcvlwQqb2x2vzpf5ScDsvvs4dTjlORQFcgZZoahXvLqXanWeQrhGK3xBskb8dgHb0UJYyd1fqZwJKnEplyDPeZKvP0UGwnNWikB8NN90rPgS9q5Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TBcVRdWW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zOGIkFb0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Gtces664299;
	Mon, 1 Jun 2026 19:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=75q2B74PwgbGZbfjct8Mo65/+iy/Jon/Zn384h2kTVs=; b=
	TBcVRdWWJndRszfZP+29TptqBYXIFqoBFVPZ37UlKSifEYBs6hcX80olkk+++CeO
	cDTr9d2bPpzSjhoGxW0wQ/S454312QE/2o3DQrZ8rfB3yA3d54Z3X7DVy3Pu86a9
	x0bZ3e9EBoe6EAfjvSproAMsKR545IyBjoA/y2BVbJ+SNubh9TbytXpR6lehfSm0
	7+XwXlWlAbMwOd9rm6ktxzMgdifr8MK6g/HfN3cuQSIsfvLTKfYUyXeYsZX0WR8Z
	faNqA8JCwGS3+zMPcCFKmx2Jg02XZdB9bdyFVlg1Q3X6T/56T13RHjsPJ5C6ij8b
	wVgjO4eztQk3SfYpvBcipQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efpaatv9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jun 2026 19:43:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 651JeM9F034339;
	Mon, 1 Jun 2026 19:43:18 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4efpbqa4bq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jun 2026 19:43:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKAtp/yaYcQ3ffi0FJEBRotDrfONgjzho1qOvxSGrnbiuAzv716xOR4EZ9kHYtE8XdSy96tADvlKn8krZTEt9d6hOuMWoG+GcQJ6IzwooogaaGv1q/BYppL0dpqHgNtPDNzxCl27H92KMcMtLV8S+2liEdM2tkI4ZZBxXkHAzRCgXTZvQAcJjtTZwFafPQnBGZvGPSd/3eEhiZNdDBXee+k1i+aDbi+Frc3sMhrCahceZBJm4LLiodGIMfbm1y30OsFd2oQz8elyBSG6y6diLsZSf4u8XafVIuFdUSgM+gDbGnig3spRkYTXdJfBQosEiqQkqfc34w/6fEA+cG4s+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75q2B74PwgbGZbfjct8Mo65/+iy/Jon/Zn384h2kTVs=;
 b=xarTOSMlCeaPb7ATRZZFSzQnf96qrD2uJ39BjcQUIDLeUzAgjUNVHQ4epoNPZaZWbArobmFr+MvzweilTXcu+0F7eh+iMsBzRKiJle63muKrMEDFRYZUlg6uT8ryw8w+bUaP065wvuuxAQ+Iyz+wi8kywCErq8YdykdtiHPUSvV3H289nY9Olx/1hCmoZpc/32z5RCvAjvhf3qipbE9CbV7XNcXwCMxXivVrN08CHALh55JamCMXm5ELolJstjLr5aZmZtLGdKbsQEEJsBdv4kuBJwMuLdiDD7t/2S0xEO50RFUt9rVqWELa2u6gTOeEjwiVZhAkvO/apUgGxldC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75q2B74PwgbGZbfjct8Mo65/+iy/Jon/Zn384h2kTVs=;
 b=zOGIkFb031xvb4OvNJ72pi7z6tEYOWP4Ub6q+cfi5IEmg77xYO6YQ8thBMFTrO/3w9qakFxWyxBFaCRGCZkoM3sp6eYKs+52bROJ0+Rz1MU4vy9ea8BXxwX6bcIjxMIuHt4r1uKGNdJ5w3xQuZb31uWPDrALNxB8Mhkt2tbYhOk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPF0A8D5CDB5.namprd10.prod.outlook.com (2603:10b6:518:1::788) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:43:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%3]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 19:43:14 +0000
Message-ID: <ba5047f3-c24f-4005-9468-9c08a9d653e2@oracle.com>
Date: Mon, 1 Jun 2026 12:43:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] nfsd: release path refs on follow_down() error
To: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        David Howells <dhowells@redhat.com>,
        Rick Macklem <rmacklem@uoguelph.ca>, Chris Mason <clm@meta.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
 <20260531-nfsd-testing-v1-2-7bfa481b0540@kernel.org>
 <20260601184715.GJ2636677@ZenIV>
 <8080069f52abd6d6c6dc199c52e6b14e961f3cc8.camel@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <8080069f52abd6d6c6dc199c52e6b14e961f3cc8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:a03:333::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPF0A8D5CDB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 3145d42c-c138-425f-5b12-08dec01604f6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
 5y+v3CPgc5RXsl+Su6yXrK5fDIYUb6+zxurJ0pKhQ4ZwBrX3S7JhSAXCrmLQUZPARthHc9HGlAw3G6ttUu+gt5JkCj+yJ4ma/t2UaTNd2ewLDkgk6q+laV6ARzD2DIY2LdZ4l/Qlx+XYkXi7yhe6IMrhsys0NpdfJazi+cPNrV2X9BDYvHiBYEefrBbb3Kd2Rusmf+ab5JiY8g5XsVvIdADLJ/NJbUqiw+9cEHCksOFJfs+pgRlMCuvuHsqBZCH/t9HUjF5di6XfSwrpW6DINQKSYp7GaxYnAhfcC8jze3/WgaceRtrt3eLuvOz0O5Wmx5rG9yujxoArNAcCKATvLCU1vbZSCqbsaZt3CWycfNC0Zz+VCruSBFmAic7ghQWnNUFGFDhfh9DQGo9WJY3aOopSeVC3Ib55oU7/tdTlBJken6+7FVqlTwj+wmxHSvhGhaMJ7ffq4Uh3/04zgejMHHA+GNFJKcDEea27u11krUnEzwDRO+K6jrzgXlCw1CHPcKob22MNMKt7wt3KaDvzfDJdFH4aKRqMdtar64xLqWW95Iskj83Kzc/hPRiGGj/9gh+MNNzci+dR3v25drT/3ovvKWPAP07tkBX82i9kwI5Wkmskb32Tg1SnNO/dK+OfjS5NVZXBUH3JusOcwMKr3DAiRxM9hB7w/HmuiXrCIQYNRaMsw2cxmAqajxdf5o4E
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YlFITWluRzBtWEpka3NoajlnS1VDWVFqUGI0OElOSDRlWmw5OUZwSEF4M2Ju?=
 =?utf-8?B?Y1YzOGtiWWhZUExtcGJDMUdUWnloRER1by83QTFFT3A1QnVMdHhralp0ZThp?=
 =?utf-8?B?YkR3N2Mrd3JPRXU0MEpUQ24wMUNKNUs5dC9CZ2VZbVZVUDcvblIvL3RtamxR?=
 =?utf-8?B?RXIvZWNPc21pUmFFdndBdlhQZW1naE9Va2JTWEF0cTVDRFlNMzdhOHVnRENp?=
 =?utf-8?B?SXRpVnoxTTJkemRnUHZBVzBBU0FMWUtOSEpZMzVLRjNPaDdITlo1NHZ3VjMx?=
 =?utf-8?B?a0pUTGNJdXlwaUp3QjRUVXMycW51NU4vZDBYckFTdm9UNzRpVmhSMjdqS2hQ?=
 =?utf-8?B?MDRmWHdmY0xvOGFYSjB3Rk1SQUNWbVVCaUVFN1liWCtWWDgrcHZmemVFVXVM?=
 =?utf-8?B?ZFB3VFJMaUxISnk5ZjY0cDhHL3ErcTRkOVM0RjdrZ0szbzQ1NitPQ01BSER4?=
 =?utf-8?B?eG10QXZlTEFlMFMwODRybGV0dE9nekhTdVRURmVYdWdzQlNHRmtOSFkvd21W?=
 =?utf-8?B?ZTZtektvTHZ0Zmc1TkI2Q1UvL1RlblBWc2IvMy9KWmFiZENMN3pJN0g0M0JC?=
 =?utf-8?B?bkYvRFhsZC9EZ0NpaVdUVmZOdnRqVTg3aWtJdHFhUkNCMm1manlhTUpsOS9a?=
 =?utf-8?B?bjNCaDBNcTdleENnVzZYajdEUW1mYTB4bk5TeUloNVg2d0NMWDRKbk44VXI0?=
 =?utf-8?B?M25FWFJsOVRmU25UYlpveFMzOVVLZE9kRXRkYmxVbGxGaGJFeExKNFdsTWJJ?=
 =?utf-8?B?aHJ1SytaMUE5cnlNZUhJNmJERnQyWUUyYVUvYk5pY2ZzTkIvT2loZ1BaZitV?=
 =?utf-8?B?REZ3R252WVVyVFhrRHRsamJvZXVoLzliWElmQnZ0M1pVUThSOFJwUVRpVndl?=
 =?utf-8?B?ME5Idk82blZ6Zm1vZkJSakh3R2xPbFNmN0V3T2lKTVNFTkZ5V2tqUjZ3NVNk?=
 =?utf-8?B?eXZjUnc2VWwxMU1vTlRoVnI0MDFqeUVDb1V3YzdNUGpyS3M5dHY2eHkvZFhJ?=
 =?utf-8?B?MjdPTkQ5U2JTOWliZ0Fkck5SczlKV3F4VjNPbDJKTTFKa09XVFJlWThLK2FZ?=
 =?utf-8?B?cGhQUmZDVGFzQnltU0xtUU9GL2FSM09OOW8zYWRhbDFQcXBOM0tNSFJuVWM1?=
 =?utf-8?B?cy9FdXNIOG5WT0pzMFVySFNmaldwd0Z6VS9ZREhyR2w3ZmhLaUM5SUhUTVlj?=
 =?utf-8?B?ZFVQTmJKTzFSVlFqT1dlUFozNHJZWEd2dkovWHZYOHNVU3R0MlBoaHgvSkIz?=
 =?utf-8?B?akpLUFFtdjN4NnM5TytMM3RHVzMvV0RDeEtuN1BWZ2d3cTBJTUhOcW00dVl1?=
 =?utf-8?B?a21HZzUxSlBzNmZ2dDRmeHdabG5KQkRUY203OWFWYWhNZHhtQURWLzVCZExm?=
 =?utf-8?B?Y3c2a3JyMnZOR1R3NnpreEdPM0xRamMycDlyUnYwSU5DNGs1TFo0SjdHajdB?=
 =?utf-8?B?OFlhaXpiZmJ5UE51enp5K1lQUVlZekQrdlcrdmcyVWV3Y3R4dmNtOXJtbkJ0?=
 =?utf-8?B?dTdnTVhld2pUaWF6RFg2Vnp1S3lYZE5mTXo0SkZQbWp5SlNJV0RpbmlLbGpx?=
 =?utf-8?B?S3o1WnkwUkwvOWluZzRGOTBlcm9ieE5xaTVyS2RwTjAzQW43WWVjS3BnWnFv?=
 =?utf-8?B?T0RZbk03cGlkS1dVNjZUT3V1Vk1ER0FkMEtCWDdteFdUTU9kQ3pPaDBTTnVS?=
 =?utf-8?B?R2wvVG1zVXlRbjRWZ2lQQ09Wcjk3UDF1Zmh6SlBnd1BHQUNiakdPdWFobXNq?=
 =?utf-8?B?L3JtNHVxc29mQktzMWY3MjVaY3hqTXFOS2UvSndaTHFpNEl4WGg3UEtsOGI2?=
 =?utf-8?B?cmhzQ29zd3lMdWZPQ0R6TXhpdWQ0WlZueHNZWktOOFc5Mlh5NzBCQUhXVlow?=
 =?utf-8?B?SW9sRXFjUStoN3hhSDBUbzBmK1E5SnBoUXRGSmpRUzJ4TEg3U1IzNGliYS9k?=
 =?utf-8?B?WklFRndBYnNzRVhoSXpQcmZRUTQ0Nm8rSitCSkJaU05PdWtZZm03cGtPR2Fi?=
 =?utf-8?B?SHlWMHRrZE1URkJsR0NTNnVYckYyNXZ0dUkyOWtJT1AwTHZqS2VoS2lobUNu?=
 =?utf-8?B?bHR4djNWME8xR1lCL0FiODNWQWQvVUN3akcrUVplTmcvZWk1WHkyakxodnU5?=
 =?utf-8?B?ZVpmeE5HWnFUR1hpTGY0QTI0NzcyZXRHMUFwSTVGdUwxTVBscTJtOUdMdy9S?=
 =?utf-8?B?UHJ2akk2TDBtN0gzLzVnOTZVNHMwVTdTZkJ1V1ZxS3REMHEwMFJTWThoZTVG?=
 =?utf-8?B?b0w1azVPTENDZDFBLzZmOFpNZEExS3BEeklwRWp1U29UcmNxb0JiZmVxUzFt?=
 =?utf-8?B?dnNhYy9qZ016ZWROYXhTaXg1dUV2TTI5K1ZlQnVZMjdMRnN2R05Rdz09?=
X-Exchange-RoutingPolicyChecked:
	VkwKBzuGa9ht5Mlc48d3OsSSKxYUyo3rjTXku87D5jQLFxqrJmfQ7Ud8VVM794YGbeGr47dqy+1vAu3hR/evuFKXaf5ALeYgQZ5WUOmh+744hT5dOQ6TYfoILEfO2fQ2zsRaE3wdyoDAjaaZHxyuXVAZaEYvLCeZjK/DrEfkWvrKuHyfEocCWhAPdM8hzd2OW3A2qI6HuGOJt11GkRXmNYIV26d+ePK82cslzdV6RypHE4g3hNrtgi8i7EBdYYydpOxg7C0j0kAoQLA2xemNonKkVmYr7QAsIZtZpcCM4733vNsr8B14Mu33iam6rpFO+a+wAP5kITZhPjrEnIlY+g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wg0UdLuT3BrAAzYlrfxpVps9x2Y4sUpdr7fkKxRiDQsMtr8my7JVsf0hLosGJG3o+HWYO9CHCh1l1I+A6oE3/jOgYnzm6XKcDX1sXPxyaY1WzES6QNc3Ca8wv1EjTwh5ni4ecwA6gnB54BPqTJQOCbc5/PYN/Abpmxax9PEGnkcvqyEtEFzM2DcGhvCbC2A4PfK8VR2mdQSxbBFRRZDJudMa0QspzzG9OvKKshB1uwEl2zUkKHpIVvdsuNOA0FWeKAShMVi2rq4XHflTZHUiwjgLNmMm5NtHCa1Hgfolqyl07/MQui6BQr0pX4eGNAnZYn9akQc0Jdz+7LyBhEbeYUmYvgLZBe6VPhdHvh8ZC9lAT9vxX5LJB8hKeP438gfmWG60hRHwyVsi8BFUy6jvfnJzXq9SttAv1FGcvlfBpMulsmqHNsysSda4iSxIxxaYEu6Af0VPg4e/ckku3lGVxuXdczZYrU+IpiXvTIX0kZb1xZ6Vtf7wdlU4jbi3ZRWRbN9XF5cnWQPDp8gDoy4iLcdaCbYe8GD7eBSBRiPqFKbqih4v+enNKsCSLxlGO7xu4Lsr8+eLmY+HoXaSqhu8HZpnL2sG5po3W1HBA6DdAcQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3145d42c-c138-425f-5b12-08dec01604f6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:43:14.0614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siJ8Gob7vIxSLg3VyDySKvnNj1htI3Krvo5xsKWkUrGQWlMS8rL8fgc0/PiJ3YNKfqVVvM1AR2Kr+xmIfAX7Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0A8D5CDB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606010192
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a1de0d7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=1B6vc46oedwOM9NOlo8A:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13714
X-Proofpoint-ORIG-GUID: WMO-0nMLcRfW-3dY2RL5bXCvuy74U6cX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE5MiBTYWx0ZWRfXwq7UZtSTKGnJ
 dEN1yqlclRfmI+/u5rDoWt/3fWn9EmLbqUFy6GSHpI0Rtuc3ANHhtfPe3COxHJpcwbFZAXCmhRg
 fb7aJNFaH2Y8y4791TuLhVQE7+U84HQPKtvN7v32y6U+saBf4iMl9pcY6G5nbXeSmcb0sSxf3xS
 LHBQdhcQqcEyDIpl5ZPtQUx+lv08+cbM47kY+NntRwPcTxWXTos04lnAbgmkXH8gQpmxjAfuNaz
 Rhu8mDo/Y2jHRT5RxKeQ0ReFr9bBBvvKebRtNvKgXcaMffmlQ4aEKAFP/S7fytAH3k+VClsu09Y
 SOUVF6UTKo0meLOo5PEFwmN/xR3eAENCMptug4wqt7SxDRWDQS7/0Qahab5K089O24UOB1YuHmI
 Ig3p4yPgORVsDXbf4MFWAXLp+2xABLVJFz2Rv3blGn0rfwwdTWdeTsquRD0lTEqhZWlPGMDhfYD
 h1TQoBmqQvlWoMY+m0W4sB/R1tfQH0oU9MzEDnZ8=
X-Proofpoint-GUID: WMO-0nMLcRfW-3dY2RL5bXCvuy74U6cX
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22192-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:mid,oracle.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E97AB624C25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/26 11:57 AM, Jeff Layton wrote:
> On Mon, 2026-06-01 at 19:47 +0100, Al Viro wrote:
>> On Sun, May 31, 2026 at 08:06:59AM -0400, Jeff Layton wrote:
>>
>>
>>> Fix by calling path_put(&path) before the goto out in the err < 0
>>> arm so the entry-time refs are released on all follow_down() error
>>> returns.
>>
>> Might be better to unify all those path_put()...  Something like this,
>> perhaps?
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index eafdf7b7890f..bdcd78f49112 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -141,13 +141,13 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
>>  	if (path.mnt == exp->ex_path.mnt && path.dentry == dentry &&
>>  	    nfsd_mountpoint(dentry, exp) == 2) {
>>  		/* This is only a mountpoint in some other namespace */
>> -		path_put(&path);
>>  		goto out;
>>  	}
>>  
>>  	exp2 = rqst_exp_get_by_name(rqstp, &path);
>>  	if (IS_ERR(exp2)) {
>>  		err = PTR_ERR(exp2);
>> +		exp2 = NULL;
>>  		/*
>>  		 * We normally allow NFS clients to continue
>>  		 * "underneath" a mountpoint that is not exported.
>> @@ -157,10 +157,7 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
>>  		 */
>>  		if (err == -ENOENT && !(exp->ex_flags & NFSEXP_V4ROOT))
>>  			err = 0;
>> -		path_put(&path);
>> -		goto out;
>> -	}
>> -	if (nfsd_v4client(rqstp) ||
>> +	} else if (nfsd_v4client(rqstp) ||
>>  		(exp->ex_flags & NFSEXP_CROSSMOUNT) || EX_NOHIDE(exp2)) {
>>  		/* successfully crossed mount point */
>>  		/*
>> @@ -174,9 +171,10 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
>>  		*expp = exp2;
>>  		exp2 = exp;
>>  	}
>> -	path_put(&path);
>> -	exp_put(exp2);
>>  out:
>> +	path_put(&path);
>> +	if (exp2)
>> +		exp_put(exp2);
>>  	return err;
>>  }
>>  
> 
> Looks reasonable. Chuck has already taken this patch into his tree, but
> we could do a cleanup on top. Want to send us an "official" patch?

We can replace any of the patches already in nfsd-testing, it's a topic
branch.


-- 
Chuck Lever

