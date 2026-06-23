Return-Path: <linux-nfs+bounces-22795-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1YlnANj7OmoBNwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22795-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 23:34:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E428D6BA45F
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 23:34:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=FGr45Aco;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=bMNwYM4z;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22795-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22795-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1147301DB35
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 21:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78AF2E7389;
	Tue, 23 Jun 2026 21:34:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB2C8EB
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 21:34:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250450; cv=fail; b=L6WRtXhkYhUcHxs069QbjAIy65WVkjW8w0HpSeVBHdtpZgNrfBaSmzYCBFNKHdI1tLloCEQnfNkeN0IHobBhkF/1FOc3yhcQvwCfkDEew4ZW/6XepDyQbv2yME+YQ/74Xlm4OdtyHjSFkYgabYujfGKicMYVz4oibXGzDkXE3vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250450; c=relaxed/simple;
	bh=z9pc2FTyik5OHfJhOTVXZtPYBqE9T4u7vrvPCwQ9b8Y=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+GQdMQnXfrUlQ9jfeGo6wo+uztsYaTJ26kTarHic4bDEiI3Sh5TOeZvLPlfHD3W2R8zV7RTX6kkn9OOoWchdp3ti31fFfHt4SLb+PYOC/3q8sMfF11m9SoV7Uv45jBiyaK/8hadCpdek6G3uc1YMvuUKIRCWdLupJ7F0eK98HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FGr45Aco; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bMNwYM4z; arc=fail smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NEBk5o031347;
	Tue, 23 Jun 2026 21:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m7cgfiAt2dXYvul5Jt9RqZjxwQHM7eLZHXNFRf5hhGk=; b=
	FGr45Aco2S/tjGcuwiOpIgjzd61rVRuu52+plYujWbH1fg6V8RW/M4IEzJHyXP7c
	P+KlQIcyqTVVd2oQcP8syk3FJvuknv+gqMUX9Q7iBxZbzN5Crr2fqeIECCi0uXRw
	jRFCRU0t8xvXoPzfHyqDZz5DaMVtXs6EnnZiMAWJuuokt+q1jQN3K+o0Tm/t8sOL
	lTtSIV4fOEM/PdKt001NuQdlAFiPXWQYEwEi3D0eR6ItVeJ+Q5yJaNukvougtnfo
	rtHdtQ6kQCme/L6OSI4DaZQCIXiOQKGTGzriCO10B56eeovQTfIyeIluQCTFaBQI
	xAy60X1teQ9hdlzmLbGH1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhn2vgww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 21:34:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65NLS34j030887;
	Tue, 23 Jun 2026 21:33:59 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhacmhp6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 21:33:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2uhssKVjwlBmAFcXalK5H5er1GmIJIzaAc5ZNuFZMN/ahQbxYviFubvfDbv32jEWKUyuY8UoYv1cRGzU685aCw2H28M0QE7bZ6wmwuip2VzsSF170YTvP71uxSxiKyLz+kgtSbuTu4g5M/97JvqKCxPCVtZnly4DsPAnlIYOzQMFF+I+R0mFJe3tfoqMbqseO6BuPYesEnheuMQOttLrhHS2Ik5gDoEYv24GT1YK/t3E3RHkAId+7ZIq0dSVhPSPA94L6+Nf+AKXYbNhE9Zki0V2y6BMinZOQPkMxIaZYRDwsg287IpxcW5R0QBhfifEXz9RJsJQ+3eOoeO3ElOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7cgfiAt2dXYvul5Jt9RqZjxwQHM7eLZHXNFRf5hhGk=;
 b=cxMnogWcPFmtG/XLMZYX3RyJrIRh58UoSzF5x/MpSGC1WUGKmofEz373EhYBeBYrpAI9MbROmJHelnaVwu50Ip0FGMkdRJBsl6uT5vUI1PFlg5Z158TMuDBMdMBSa0d/SDUw+c9LlQsgqgd2qDIbeYNnLf56FPoq8HO5UGAZe2Tp30RlVZPJtzMNBpKr0z29g7oX+ujeh6bNvOnT6WvUWWSELfBYH2xcjz8TEM2rQd0EVOiECCfZMZXxTzhpB2Ynvu7opWMsN6SR2LKsP45HC/BqvMRJsYSCJ5JcKuwlcSFSt0TdAY6btv00+9sG3y+mvLLXBI6yfrIQd6JxvCDBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7cgfiAt2dXYvul5Jt9RqZjxwQHM7eLZHXNFRf5hhGk=;
 b=bMNwYM4z2S1DbNMtM8gYM5C/eHY5aRHoj3/P1Ltzql5428ppWfVoujJ6OjsoeVwxIAB6YuoJ1QFr0L9Y7/AwML1EKB9AhsSJV8u1XfJFs+chEmHJIkpzgxSuuQQ5//TyumurLav8VEMt02iLdtrxnmT159+2N7Il2Fgqm7JkHRE=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by IA4PR10MB8658.namprd10.prod.outlook.com (2603:10b6:208:562::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 21:33:54 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 21:33:52 +0000
Message-ID: <ebb03dbb-df8c-4270-9bd1-9a2fa64b7e18@oracle.com>
Date: Tue, 23 Jun 2026 22:33:48 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs v3 00/26] nfs4.1: add some directory delegation
 testcases
To: Jeff Layton <jlayton@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::16) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|IA4PR10MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: e08f24bb-61d7-4ee4-43aa-08ded16f1ef4
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 Vgfto/IpNB+JUsBZEfzWOW96gJZT+3EdLDfv2LMANS2oLkI49OxRC4Zn62lyx8Anpa5/25ZLuFFSy30OgDJ1WZgY+pqbPgPVKIgrF53kPJXa26trjvNh48uMdr+cHFSi0+cnYMBdwNyZ0JL/pjgPK76L2bS6fRDXoAIXz+t05SmDDf4ooGu1fvey0b6ZJwXsDIYUFsJXcr+t3UGNYp8BQaKW2pEiqbu5xHApHsbPZNOPyFxyZTGCOOK1qzXBzJ0DrJbvIRsZUnXHUzUgmH/g4B3FblSZXZYSLwFPxwVLKCGcGklsiceIgjU2pGQLxc5Pr3H1vW6JO8ElraiUXMDvvEef5D83tPqlblPLqz/1QuhERaWNfovclsCt3fAZRdsTBMiFUudpoaJ3UWXnyZJ/Fsyw22xQcRZ665pcOJKXqAOksDaI0kgq6U09WKcG902UEezRJCVAhmAJWfX7AmZxKBKSi7XCVKWrHKuaQ859biPS16WGFOj0cXNLh3uXHXyBCSbk4V3CHtnisoehrZBFI9aNQqA2z2T9r5VMj4dthXTc25gWFIJC9KkpAsN44KhJ6BM47hN1mlcSwozRcniYte4RxdLR0yGucnQXi3QUQzjAE/t2bQp9EEJ4Yd2g3zMH0q7KBADeD4ER7rPAa0qYyZDDIrp6whyg+F/7c4F1RZM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(3023799007)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Sm9ya3ladFFEWWpmbml1c3grRkl5TFBRa2wxZWtMUDQ2MDZzS0R5SmFMSTZ5?=
 =?utf-8?B?ODNFRWo4RGtaNkFhWmsvUStXdmRydG9tWWZMaDVTZFk5UDlXWnZSbk14MDN5?=
 =?utf-8?B?MjNSWHlTRklpbUNEYy8wZnlmaUI1bFdzWXdHTW1SeWlCeUFGdzdGYVNZK2N6?=
 =?utf-8?B?bkFjLy9qOVZTb3RhT295Sm0vTjZMMWU0SlE1bzI1aE5QQkc0NnZ6MmE4RHpY?=
 =?utf-8?B?Q2NqVFZnL20rejlIR3hYM0MrRUZSSTVSV0tvb3FGUUNBT1R0c2RubE1JanFq?=
 =?utf-8?B?Z3NVZTZER20wRCtPaEhvNEg1UGVGd2czUGdZUUl1eUV4S1dKV1lyMVpQTGM4?=
 =?utf-8?B?eFU1NFFNWkdITkxRZHlnZXNSNnJjRFQ2cHlhNTJLcWdnaWdqQVI5L0JVQThO?=
 =?utf-8?B?bmMvY1lHdzVPclorRnNmbmNHdW1qSkhvNFFWRi9KTFJieEo5NktOYXYxTDNa?=
 =?utf-8?B?cjNFNXdDUW94MkJTWnJZUXNIWmtaalp3ZDhNMXJod1hkaXRRM2RWeGJqZU9W?=
 =?utf-8?B?TmdwU0FRWldrSkpadUk3d25aTUhOeTBiQ1UxdXhRM3NiclA4MGNPY2EwYVdB?=
 =?utf-8?B?ZEJrWGlrK3M0WUNQaG5SODZsdGVFdEZlN0M1VUpYZ0NoeHlNajRjSGdwREdo?=
 =?utf-8?B?QlYwTXIvanZ1emlyV04yWHBEN1VXVFpXeE40Zm1kcGdNWXhWbW5iaUlYWExB?=
 =?utf-8?B?T3B1UXFjNnhnMDdtVDVkZHovM1lrYmFRbW4xa1dNV3RGSlFQSmZtVkY1NHNN?=
 =?utf-8?B?cXdYRldjYm9RTnB2YTM4enJaUjkrWEhPc3VtdkVvb3diaDNOZFQrQ3BnanhL?=
 =?utf-8?B?RWhEdGcrSjRiaGJuOTI4ZFI4TUxtT3JxcFFXa2hINXdacU1uTHVrVWJ2V2Za?=
 =?utf-8?B?QzVzU2p2Qys3NDB2QnBqcjNoTW51QSt1N1JwTDgrRWM1TFNqRmdmK1ZuYkxo?=
 =?utf-8?B?S2RhZzZpN3ZONGVnL2ptOVVwZVBjc2phbVRzMlo4OG9RK3cwblNEMlpxTVZV?=
 =?utf-8?B?STU4OTJHZ0pTMm5UMW5LaUlvaklYNDRsN0xkdE9NVWFKajNqTGpsZTNXWHAw?=
 =?utf-8?B?ek9NTGFUc0lSR0RpRW05ZElSVklTakZlenppWDlVN1dyUWx0ZVdhbXliRjJO?=
 =?utf-8?B?aWVxdG1LMUlZSVorQnViTlRjZkYvQWM4QXFuSWtiVHhWNWN0WTBWa24yVXVB?=
 =?utf-8?B?QlhCaXhDeUI5V1hDL2R6L1hyTHpJY3JCUWM4UnROejZ0ZUltSnd5SjE1blJR?=
 =?utf-8?B?NVNlMm4zdE9aL1RrUStubGtCMVovNjA1K29JYnJhNUVPdkVSNEJlSTNXaGY1?=
 =?utf-8?B?Nml6eTJPaUFqU0dnajZIZXoxY045YTlHUzB0THppNFlWMmVrbHhGNHJZTldY?=
 =?utf-8?B?aml5OFlhMnk3VXFVcE5MYm96VjJ4L010US9pMWJmaUI1ZmdtTGZseEF0eWxH?=
 =?utf-8?B?aU5nN0xvczNiam1pR3pZMWt4bm1kQzJoU1FGRGFvNmY0OXJvbjgvUlhyN1NH?=
 =?utf-8?B?cHE4RFpoRU9uNExmL1N1NWxXZHhLdExGY2h2d2tzeDBMSlFIMEEwTzhVSE9u?=
 =?utf-8?B?aFFSQlpHR1FMajRKcWVHM3RqZmlwRExMcmxTeTVWallJRGNBNzdGS0ZSalNC?=
 =?utf-8?B?bmEvNzg3RmUzakV0NUlOVDRUMUJGZm5HZ3NBZ1EzbTVVV1dkTnBMT1hpZnpD?=
 =?utf-8?B?Um0vRkhpNTVxTjcrdFpRd0U5WFc0Y3VrbG8rV2VEWGxIS09jYm5WSCtnd20y?=
 =?utf-8?B?WnpJVmgxYmxnR2cvY2hhTGdGY0dQZE9mN0NHcFc2d1lONHgweHllYmU4MlRz?=
 =?utf-8?B?dWxMUXlKNzIyYkt5aWhCbllNTklpWUZjQ3N3QkFGMitYTDI2eHNoNkdLYWF5?=
 =?utf-8?B?RFRIeHFQK2Y0NkdnSTEydklSZ1EyRUdpSDZ5TVpyMFRMN3prYXIwcUc0b0lI?=
 =?utf-8?B?UTdIMWVMdWhtY0wvWjY5VTJNNEd1c0k1aEJMQm1CckJkeWVhZVd5MWhQcDNk?=
 =?utf-8?B?T3daVTIxMlBNNVlTUGxma2x5WndjUFBCUFB1Wm91S0JvNkxwQXJGRVY3bHZ2?=
 =?utf-8?B?SnQ2Ujh6NnJnSk5GeUZsR2ZnUWgvWVYvUkg3UlNHdGNOcmZ4Mm1EMExybGJ3?=
 =?utf-8?B?WGlxakdoTTNwV2lLZTNEdDh4YTRGaWZiV1JNbGxEWTlkOTNYaEhuOStKQ2ZW?=
 =?utf-8?B?cDJiUTdtZFh2c21JbGZPQ1Vkak9lQzNEYmhkZlFSL3JNRlpydVhhajBuUmZR?=
 =?utf-8?B?YkZ5MjlRM1lIdHcwdEFNOUpvaURySEZXZThrODRGd2Z0L2ZENlo0dXpVbE13?=
 =?utf-8?B?YlBMbXFWRmdTUGRodXJwVU8xY1NIYjdMelQreE9LRzBBWWJ5QjgwVjF3Y2hQ?=
 =?utf-8?Q?TaM7xOi5y3loqho8=3D?=
X-Exchange-RoutingPolicyChecked:
	Vv+rMBUUB89nf1kRLnRGw3/0yyZEBg0/2ERzlsq7913C/9C79q+7x/AFJPqnGZExq7p+nvkdlN+Ukl6dBM6S4WcDsi7dscydvLTEYIGnYTfwWi327FLrWeZIVBfZ5UmhkCqUiW33wQxdhWmrS+3R/XteKNJw/SLWwmct+hM2nM8lL0NleDAtGmTKyyd4opsHhZQ5M6DwHwYPgPXGbHYEYzwifLb1BQoG+Vt/qBUzR+Tkl3UMJ7R2FTOqUJlTBHm5GEmgyzAHw1lxShQ7lS0qJJxE4y+yOINpPtKu1N5jQGBSktIAgM+kL1KewEeat+iN8a8dfiwn+W/MXufP7N1lQg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hz3nu0Z9nexDX3f7fG4QPT22I/qpdA7pPXpIDjgQ+xfOB8WVH/XntrGeBT1NGtTiZ902B9xQrXEackfFe+kfurbqUsz3opn05j2fHld6ufmWiRwugx2pezyAah9/hqsWJ7HRzuTTEofOrK2E/8HnOtBCQAsGC+3ypsUxCstDQ+m17JJ5L5AoxcXH386fpv8CVuOgluxZ8yUQo/mp3guVN9TLB+kYu4Uwg5asXVEqXaOwWjGSajukaWownif7HhwrJ8OlT86CJQeSza/kT+nelhHAaksJfotT4CKjtxqOItxKLda/BkJ8KvZfdnXsi1qPGgjCc8kKQtR4N9WN5O5LOhL85z+Qdfjg69x7dDgR+Lmodf3569Zbpses0X4VWEb2f55l+kETPoKnb6oPoYpf9Z+65pgZeLmlZ1xehE2bjzP3ceVht5MOrtr4+KfZsOs6cf+KMRd20JRDFdfhkznqpbQEO8VAiHMHM5DE1gnLVeAxoFUaupOGukNI59huenTGpUoOv5YWHoifQWg57cPTMm5CaoEbd3K4oLbmvpaeHNrYMuB+SeYu/79VFTsfCKGGEBJ3ytE+BsJ/wzA8EYydHFWaGJhysfS6/DupydMjqHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08f24bb-61d7-4ee4-43aa-08ded16f1ef4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 21:33:52.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtAsnKU/X4gUDKflZCLKjkh7UvHw6ww+E/tM4gsxfFxA2RP3l8NvR7s9Jzm5c9fhfMB4JyAE5kzco9mTrA2TAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606230177
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE3NyBTYWx0ZWRfXzEOO6tr5uOuM
 eXmMyaVSEmf755EMYUPoDDU+hxugdovv4bXcqCJvJI/RfT6ZIRucvYKEnzRUFAQwTJLe6vsnh9u
 SZkqGJZEmD3y1ugHjd+cwTsqM6nCTP0WSdNORGOTcM3xLJE3V2xLzzxOf56RKjN+Xev6uGSCzYW
 g3nfBjAEMgEBpRnjFiMtIbUYD+r4Tf5hzkOgmkuClto5SgH6zMGp+Of7wmHE6/eaiOIm8RM3Dmp
 0Fa/ox6rGgVu/j5yXBHr8cE1LsdI0o0ZVN/wRJPbaBP9xvaOJiO05Ombvbv74dtWznj0jbol2us
 4pcaUO267MV1cIOPKZRfRY8DRDQSJX2cJwQVlo+wFfoHPPupANFB8QiFD5zKpdUzAdBhiq1Jdi0
 x3rmfs1MedBUJTuu9peWJlgfADY76tkaZLKj7jbAFVMeUWb5CPcu1CK/y2uZIstrPwPhT0VCh3o
 takh8AA2sjHtUpPKmqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE3NyBTYWx0ZWRfX+W5VrJqXiPYQ
 LfOi0UioXeH1rAa0XKjO3urp791EK6Zp4r1m5Ev2+jX0MbEThKQKh2U+8UdLcVbc+sZNXRkdaqM
 3m6VVZNmrD3yl4B1+1fqzRcB3KQCjUcPZOCwHnf+gB793aHijnum
X-Proofpoint-GUID: O8g4DJc0aevAWvJCJJL5Bz_9VyjnqYn3
X-Authority-Analysis: v=2.4 cv=E479Y6dl c=1 sm=1 tr=0 ts=6a3afbc8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=AMAtRpaIAAAA:8 a=gK6SmPdR1VoLhKv-qecA:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22 a=cjGL-luK6gfjHbM0xfYt:22
X-Proofpoint-ORIG-GUID: O8g4DJc0aevAWvJCJJL5Bz_9VyjnqYn3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.15 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:smayhew@redhat.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22795-lists,linux-nfs=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid,oracle.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E428D6BA45F

Thanks very much Jeff,

I have a bit of a backlog, again, but will get to these asap.

cheers,
c.


On 19/06/2026 8:22 pm, Jeff Layton wrote:
> Long delay since v2, but the CB_NOTIFY patches only recently got merged
> into Chuck's nfsd-testing branch. They're currently slated to make v7.3.
> This version of the series fixes some potential state leaks that Scott
> pointed out, and adds a patch to make the output a bit less chatty with
> normal settings.
> 
> Original cover letter follows:
> 
> ---------------------8<-------------------
> 
> This patchset adds some new testcases for directory delegations.
> 
> DIRDELEG1-7 should pass on current mainline kernels, with recall-only
> support. The rest require CB_NOTIFY support. If the server doesn't
> offer notifications, then the tests pass_warn (so there should be no
> failures in those cases):
> 
>      https://lore.kernel.org/linux-nfs/20260416-dir-deleg-v2-0-851426a550f6@kernel.org/
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> ---
> Changes in v3:
> - Ensure we clean up state after tests
> - Demote some extra-chatty messages to debug level
> - Link to v2: https://lore.kernel.org/r/20260416-dir-deleg-v2-0-fad510db5941@kernel.org
> 
> Changes in v2:
> - Added more tests for CB_NOTIFY behavior
> - Link to v1: https://lore.kernel.org/r/20260407-dir-deleg-v1-0-54c998eab72b@kernel.org
> 
> ---
> Jeff Layton (26):
>        nfs4.1: add proposed NOTIFY4_GFLAG_EXTEND flag
>        nfs4.1: add a getfh() to the end of create_obj() compound
>        server41tests: add a basic GET_DIR_DELEGATION test
>        server41tests: add a test for duplicate GET_DIR_DELEGATION requests
>        server41tests: pass_warn() when server doesn't support dir delegations
>        server41tests: test remove triggers dir delegation recall
>        server41tests: test rename triggers dir delegation recall
>        server41tests: test mkdir triggers dir delegation recall
>        server41tests: test link triggers dir delegation recall
>        server41tests: test no notifications without GFLAG_EXTEND
>        server41tests: test unrequested notification type triggers recall
>        server41tests: add a test for removal from dir with dir delegation
>        server41tests: add a test for directory add notifications
>        server41tests: add test for RENAME event notifications
>        server41tests: verify child attributes in ADD notification
>        server41tests: test CHANGE_DIR_ATTRS notification
>        server41tests: test mkdir triggers ADD notification
>        server41tests: test DELEGRETURN stops notifications
>        server41tests: verify filehandle in ADD notification
>        server41tests: test cross-directory rename REMOVE notification
>        server41tests: test cross-directory rename ADD notification on target
>        server41tests: test link triggers ADD notification
>        server41tests: test same-client changes don't trigger notifications
>        server41tests: test cross-directory rename-over nad_old_entry
>        server41tests: test within-directory rename-over nad_old_entry
>        nfs4.1: move a lot of log/log_cb.info messages to log/log_cb.debug
> 
>   nfs4.1/nfs4client.py                  |   42 +-
>   nfs4.1/server41tests/__init__.py      |    1 +
>   nfs4.1/server41tests/environment.py   |    6 +-
>   nfs4.1/server41tests/st_delegation.py |    3 -
>   nfs4.1/server41tests/st_dir_deleg.py  | 1117 +++++++++++++++++++++++++++++++++
>   nfs4.1/xdrdef/nfs4.x                  |    3 +-
>   6 files changed, 1147 insertions(+), 25 deletions(-)
> ---
> base-commit: cd4701827a8261fedbfb4c6e39029fb9671321a6
> change-id: 20260331-dir-deleg-a1b3475f8385
> 
> Best regards,



