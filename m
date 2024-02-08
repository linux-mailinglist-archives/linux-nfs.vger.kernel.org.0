Return-Path: <linux-nfs+bounces-1867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75584EB2A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 23:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1C21C21A43
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 22:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB84F898;
	Thu,  8 Feb 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hdd0yhVk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rNmbbS3G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E864F602
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429973; cv=fail; b=cyCj64jrd8DQ0zMPmdxTeNBo626/U6VjVs9Nn/94QG6aq5HtIqrzBeYoaI6ClvCDI8BTBomvAVgar23/1veaOCqbk6MpL7t3zyyjFqxQpMBDzAjoVU45qsfnZAmRhQtkhdNNPdqIaIkYya9EnpfUl2L/VoT8e5cUAvd1dxPE4ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429973; c=relaxed/simple;
	bh=znBMM6j4Coi6ECQ1mbe+VzJCnde51At8+YKGN0lmw0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T1fNkHkCiMOlZA/6tEwlxHTevCgo6f/kOdlYacguHhhbZgyxea6invUctoqhabQ3u9wUBrsgDuaOsO2HxBGN8n0CghTrY8Md3RBuFyvbEXOaJGom3sNmExPMEwLzfC+jy4H09rI5VntYKG16IuFZzM3nCHDC/2jDT3/CUGxXzIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hdd0yhVk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rNmbbS3G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LSjEg015665;
	Thu, 8 Feb 2024 22:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=znBMM6j4Coi6ECQ1mbe+VzJCnde51At8+YKGN0lmw0g=;
 b=Hdd0yhVkrUHadWWzY5mfvUSFWz6be0dany94bxB0GytqYiOcVH8laRQHXdvDBtBXJsAy
 HLLpF/uI5+2nkOojuCO8d1EMLUVaYcha7hzXG1jynHGD570Yh2JAoIly3pOSrVMTslSW
 DbVXUgjyBX9E24ObnfgeW69SKmDjRZo2lV6oNXTxyBJ8/ZHXOr92cHZd3+3V7a1aX4C9
 zXVWjzOUMmAgbYSrDrIbsPdhPQnryxIcVd1TuQd7G0Ui8edeAZPqy7N1tWrgzBfMIX9S
 NKNsRji08GvFkdl6yAHE73Qqd9X6iBykw5NBfaZ2XtcVEY1c/5jv5uao71NUwAZ0rHrx zQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdp4t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 22:06:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418LwWhe036816;
	Thu, 8 Feb 2024 22:06:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxbbkm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 22:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHjMPFdwo8yFuROVC25B8XRO6OXUMALAkr3L69KBEKvtkblkNcFuWx0Ma5oeB2dOUyqNJ0V96dQuZIaZfDCdbASgcZ1oebkqN5tmoBYG9NRNaY0XA7MWRVtVb1snjldDWfuAR4WFW3idUsUPNMCWsNJMdWrb7YCJF7lnwcc5KKwrJ7KWh3tSBMjjgWytpkX/TNZsMaSHi7P9N94F8/lKdZeE8ZJOohE/RqMpA9pfxTOnT0tInHcz0+++sD+7yb/ZIhTXXdbn0cr56e1iusmMr38eZnoVj3B2ytCeEDDBHoQm5OZZAmM60ekxbrKfHr9gBcYT/f3DgF1sdeEbgF4x9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znBMM6j4Coi6ECQ1mbe+VzJCnde51At8+YKGN0lmw0g=;
 b=HKCV6eO88L1jmiK7gwUXp2ii/ZkR3exyZxRMnb7/8gvIQUkE3QWClTU7EEeJnUMB7QRtmqpaEvR3B4NsG43TiUeZNApRdrv7IJLlKZKhA4NOxDkV8rT6ZkqXy0rHI4m8UkFPq2w4E8XE7b+dCsQKy5zrKiygu1qjLTIquXiTV9NfHczY+EBcteTZHVQeeCilPL1WKrvu1VuBPq/zK677j8MEpR9qtLpiQXzLv/dyEbwc6eTc1LIqik2OcBI/UfGX8UZ8APYvj7LYax6Cq3REcfnLwTOhyFLbdHqIBhjnU/cvGQZNyvZh1uYVUnaBBnETuyc3pwm04NCDuRY0CHdcyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znBMM6j4Coi6ECQ1mbe+VzJCnde51At8+YKGN0lmw0g=;
 b=rNmbbS3GrlxBnpHY5CworXO9WONtrnXfX0zf/o8BPdY6O1F1J9NxAIwiOOG/LpoXjcBohP/KzUGhYhLYhCoU267iZdR7Mrx7xtk7HXE0rRoa8jeQEFxfjjeit6ZVECEz20kjaT1SsZK+m4o1wV0ZKl9Ys5QFB4FGpzL9WTTvC/g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6292.namprd10.prod.outlook.com (2603:10b6:510:1c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 22:06:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.037; Thu, 8 Feb 2024
 22:06:05 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Charles Hedrick <hedrick@rutgers.edu>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: apparent scaling problem with delegations
Thread-Topic: apparent scaling problem with delegations
Thread-Index: AQHaWstcr/sBhJW1c0inPGg6Tk9HQbEA8OqAgAAGWvOAAAkegA==
Date: Thu, 8 Feb 2024 22:06:05 +0000
Message-ID: <A14BC53D-18C7-43CB-B64E-3B215EB12D04@oracle.com>
References: 
 <PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com>
 <1AF9A62E-55BE-4A08-95D6-26784218C940@oracle.com>
 <PH0PR14MB5493D4DF2877FDD93BB49AF4AA442@PH0PR14MB5493.namprd14.prod.outlook.com>
In-Reply-To: 
 <PH0PR14MB5493D4DF2877FDD93BB49AF4AA442@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6292:EE_
x-ms-office365-filtering-correlation-id: a2ecfa27-bd06-4302-cc3c-08dc28f225ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nG/qxAScpwEY1G3ViLF3jq4CcheOYeHVeAqld7M9WLLlDZrw5ATPHLbh+e2TEJ39aZS98q95QgSWp9HtdXh/09LtjZtNVT6Hd9WzoXizcYaPz9SAGdXYNb2yzvTnqcFERU5nKPz2M5tiOPxr+BXng1Fc9w/ztUVOI/NKqTp6V3FHq7o1mRACDl5C1AIJGSfOgTAacXjT3yTO0cgXxcZxWRA09zNVa+pgsd46ODpGP0P70WCfiDbWa3vbQGZTG6eD0tiB3P4XpHzvEHsyowz2DJhMh48CwrsJtIomYs4aw7S4EtyIxZErBIjqQAnjzjiYY2QdZXDBycadfiRf45S6OkIKnaF5gLIGYh2OzXYHGM0Do10Vo1BnhRKKmISYNN8NhJZ2X0pjZ/y2N5hXmpIwR5wZE4V296t/SDIp9VCxpm0TjpH0bEyW068C5FOhVqxoYbC5UuCtTlESTUv3oFV4a9cNNrYn3sJn+wj3pTe7TDX8LH8+znBcULclvMHxcxFc17VTVnlM0xPBPvmjaRV95SIyvdsbtTSG0hMSeh6/gQtHpxJHOl2l7tcbakD0hvt1Vp41LNQCcFeX/wVwiOEx1+UBywZx74RgHmurmTqDXj1kDl/XYblod4grCjlRkvpG
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(33656002)(122000001)(5660300002)(26005)(2906002)(38100700002)(66446008)(86362001)(6512007)(316002)(71200400001)(6506007)(53546011)(83380400001)(38070700009)(2616005)(66946007)(76116006)(66556008)(36756003)(66476007)(64756008)(8676002)(4326008)(8936002)(6916009)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VXBUb1pmMXVvL0VMaWR1STVnbG1BWjIrdkdqM0F5U2o3dzlWUFIxNXhEOU1k?=
 =?utf-8?B?U25hVEV0eHlEQS83MkNzYkR0THhmN1NMUXpMOGtYZEdsd1F0Qnlva1BMUTV5?=
 =?utf-8?B?R2NDamJTQlpTNE9IakowbWRwaHJ0OVJvb1NZUWw5bDNZVkR6eEw2c2xpZFBN?=
 =?utf-8?B?YlYxR3JQTGhyRXNvRWVET1hoUmx1amNzcGVHVktoT0NuRSs2M1oyTmJGeTlY?=
 =?utf-8?B?QlFHUHpmbmpINHhpYnA5M0FmRWsvYlpsL3V5K1pYcS9teHRMd01LSlBON200?=
 =?utf-8?B?cEhHdHlsQklsSGZsSG1KbENsdmp6VGo3Ykt3cXRFUFY2aVBqL3RXc0xiTWZ0?=
 =?utf-8?B?QlRhS0krSFhNSFFISFBvT3ZGTlJhU2JTU1M3VUJsYzk1eWg0YVZVcy9GZllS?=
 =?utf-8?B?VVd5TlJFZlpaYStRQ1ljSkdURlFEc0FTQjF2YmZrVFdmdFBZODNqNlA0YjlZ?=
 =?utf-8?B?U2hadFU4TWdlLy9uNHhoMmllc3BVMTZCVU1YTkNqa0pjODNrWFZrQ2VYU2RQ?=
 =?utf-8?B?ME5CSFB5c2FFOHZvNmVvQmtMZDRtNC9aZTFyZ1BYWXYrTkc2ei8ycGJTT0NR?=
 =?utf-8?B?dkFGMElIL002SFR4ajNocFJlNnVqTmNhbkMvTnk0NFVDTkZTOUQ5ekl2SXJ2?=
 =?utf-8?B?UFE1eFI1SXF3RUpaK2k4UFlCNVY1dnBsdU92anZoUmY2QmpWOUlzaU5wVitK?=
 =?utf-8?B?MXhIVjVzUW9jU013dThwZ2VkdEZFUkw0dTRSbXpuR2lsbExaeFd1bVJkNGky?=
 =?utf-8?B?M2JnV1dvTUVRSVVsUTAzdDIvT003YXBtOExzVVF4bHkvUDJ6dXZHbjFaWlhv?=
 =?utf-8?B?QldFcjZNbjhzYlRMYUVNc3MwbjdzVVRSandlTU9QdzRRMndUZC82VE00di9U?=
 =?utf-8?B?bk45TnZ6T25SVzJHZGFvQ3hMUGtnMVI3QlJUTWc5QzdLT1dDVkJEYkdnWEZo?=
 =?utf-8?B?ZE5mVUJsMm1FT1JlelI2RjlZQmNMNmhaTFpNaDhQUTAwSVlYSndJTFEzRFVS?=
 =?utf-8?B?LzdzSmN3anUvbnppS3F4dVl3S2ltcHdyRlBBb290TldqQW9sdHNvZXJjNFFE?=
 =?utf-8?B?R21TNTRpblZjWERMelRobHFJZmV2VHVEdERTckZ4Y0kyYVV6Q1lGeVJLSC8x?=
 =?utf-8?B?NWVvVGxBQW85bHhuaDdaM2I2cUVmbDdBSkdDWlNMUXU2dDBxVTBOUUN0VnJU?=
 =?utf-8?B?dmc0TlFVckhSTG93Mzd4UFp1S2FUWEpYcXVaU0Q0UnNoajhIaTRUSk9UY3Jk?=
 =?utf-8?B?bXNRTUNrVGVwL3NEdWxKcXlKdGx1V0U4YktyVGNMTXFhOXZYQnJnSFRZWTJP?=
 =?utf-8?B?MUtxWTdnVXN1bm0zekFEREdoLy85MlhLMXJFZDgzTys3ZDM2N2JGM2h2TW84?=
 =?utf-8?B?bk9RbU96UGEyajV1eVNEV2tzaEwvclZXc3YzUkNBU1RNVngvdUoxZThQMENk?=
 =?utf-8?B?UFBKdDQvL0tPMVFaWEViM0ZmaTFOSEN3MXNSU0VJSXc5Z2RsUlZ6QklsTVVZ?=
 =?utf-8?B?WnJvbFdPeEdkb3ZZRHV1MFBWNmtUY25BUXROcENYeUVnanIxL0FPd1REMi9J?=
 =?utf-8?B?Qmc4L1F3SHhrcG9KcXY1ZkVDYnE5TnJzUVk3SGMrb3JVcVA2SUFKYlFFVzND?=
 =?utf-8?B?b3pESURhdXZKdk9JTlZzVSt0M0hTeEN4TThzQWFoazZNcjNuSmQxejdodkJM?=
 =?utf-8?B?RWhUUFlOMHhDbm1yS0grQW04VVN6aUVFT0xLNC9RcnFMNk1Bbk96ak1oaDhk?=
 =?utf-8?B?c2VlaWlxTlhRb1VadHZ5QUN4WUV3RUVTeUkrSmtJSExFcTRudDZ0bDhJRkhU?=
 =?utf-8?B?Y0RQVDNNVSsyLzFmYVhLOU1SSE9raW1nZ2lJeVVXb0F1Ri9OWkIxZHQxak1I?=
 =?utf-8?B?aFBWNWxEL0J1djNHaG9ybWtwQUdLRzhJZWVMR3ZyRUtrYlM0dzk4dDBlaEZj?=
 =?utf-8?B?QWpTUkJtdHNmUHVTbzErR3lOaUNwallrV2FJV1YwQmh5ck4rM21tcC84R2l1?=
 =?utf-8?B?YktVMDJIYU9DWnBYWGFGUVlNclFKZXZFQ2xMeHY1SGoyQlViSUZtcTZTa2Vr?=
 =?utf-8?B?VzIrcXVESkd4dncvekRpeUo4c3M1WjFjeVZ2N1Yya0pRSGc3S0NoY2NvWmNz?=
 =?utf-8?B?Y2FWemFYcjR3bWtYUUdJN2RFMjh2WVhXS2RKMkhiWkc4cjIzU1NZZ2xKK2hv?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F59C5742E125A43A899B370F82C2880@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qWFQtwAjbf0pu/LDVBroGgKZf/MnH1MM64hOc1sSmsOvvvFHAQ80Z/IayqR5mnRiqwI5g+hEyvmrK0I/Qt0Z4D2H0liZieTVv4oTkgv8y/SNz1YZIyLqdlBCJ6YhvMBsvENVJg1LtEVQSXv2wWd5ZjEQdxB3DTgncx2PMFsph0xJHHtieogf14Dxpe+UX/9zyd0Oq5KWrRcdT8vxmVP/fhAFlXYeZxgYK4v/IXecE4OWvDM/mfaDa5CRkc5GXGzUF3QWeix4lnbeoeiDsP7cCcM3QCBj1Du5lRfU1XGaEYBPRxZbr/0gpHEu/wFpYq0hN0TuuIq60kLiEHCev92tLYc2GqiCqpSoP90o49EuaDiVHfkfsfycb7mwhCELuvPzeJudGOZ/kETP5MXAP5qQmtBrf9etxP6DIqRSKdlsMIJVlDWBcimv2xMnBFUG6HgJJ5M9iIQJzYGhrJUwthxcK2XKCpfozj/leASc7iTTcU3Xjo6gR6BrKiaxlBl8AqguPOEOV6HzkQlh6tenLj+7JT+O1lmdBGtY1KcIiLgQQHI/9wpivZniVRNhxyDbujD2wGG+qPKjFjpXZy4XZEXFaDpCZWgAHoYujk2A7ZF5brI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ecfa27-bd06-4302-cc3c-08dc28f225ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 22:06:05.8854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+XOZ2o3mMCDQCZ3vLzjnpiu2DwcvRSPlcshzJaC7cuJ2k70NrjwPHBqNK7Env0Av/OKv5N93MooexzUCVgTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080122
X-Proofpoint-GUID: yjbzDtnNfnSbrd9dsMY5Tv4lwrh8DgFK
X-Proofpoint-ORIG-GUID: yjbzDtnNfnSbrd9dsMY5Tv4lwrh8DgFK

DQoNCj4gT24gRmViIDgsIDIwMjQsIGF0IDQ6NDXigK9QTSwgQ2hhcmxlcyBIZWRyaWNrIDxoZWRy
aWNrQHJ1dGdlcnMuZWR1PiB3cm90ZToNCj4gDQo+PiBGcm9tOiBDaHVjayBMZXZlciBJSUkgPGNo
dWNrLmxldmVyQG9yYWNsZS5jb20+DQo+Pj4gT24gRmViIDgsIDIwMjQsIGF0IDM6MjbigK9QTSwg
Q2hhcmxlcyBIZWRyaWNrIDxoZWRyaWNrQHJ1dGdlcnMuZWR1PiB3cm90ZToNCj4+PiANCj4+PiBX
ZSBqdXN0IHR1cm5lZCBkZWxlZ2F0aW9ucyBvbiBmb3IgdHdvIGJpZyBORlMgc2VydmVycy4gT25l
IGNoYXJhY3RlcmlzdGljIA0KPj4+IG9mIG91ciBzaXRlIGlzIHRoYXQgd2UgaGF2ZSBsb3RzIG9m
IHNtYWxsIGZpbGVzIGFuZCBsb3RzIG9mIGZpbGVzIG9wZW4uDQo+Pj4gDQo+Pj4gT24gb25lIHNl
cnZlciwgQ1BVIGluIHN5c3RlbSBzdGF0ZSB3ZW50IHRvIDMwJSwgYW5kIE5GUyBwZXJmb3JtYW5j
ZSBncm91bmQgDQo+Pj4gdG8gYSBoYWx0LiBXaGVuIEkgZGlzYWJsZWQgZGVsZWdhdGlvbnMgaXQg
Y2FtZSBiYWNrLiBUaGUgb3RoZXIgc2VydmVyIHdhcyANCj4+PiBzaG93aW5nIGhpZ2ggQ1BVIG9u
IG5mc2QsIGJ1dCBub3QgZW5vdWdoIHRvIGRpc2FibGUgdGhlIHNlcnZlciwgc28gSSBsb29rZWQg
DQo+Pj4gYXJvdW5kLiBUaGUgc2VydmVyIHdoZXJlIGRlbGVnYXRpb25zIGFyZSBzdGlsbCBvbiBp
cyBzcGVuZGluZyBtb3N0IG9mIGl0cyB0aW1lIA0KPj4+IGluIG5mc2RfZmlsZV9scnVfY2IuIFRo
YXQncyBub3QgdGhlIGNhc2Ugd2l0aCB0aGUgc2VydmVyIHdoZXJlIHdlJ3ZlIGRpc2FibGVkDQo+
Pj4gZGVsZWdhdGlvbnMuIEhlcmUncyBhIHR5cGljYWwgcGVyZiB0b3ANCj4+PiANCj4+PiBPdmVy
aGVhZCAgU2hhcmVkIE9iamVjdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFN5bWJv
bA0KPj4+ICAgIDQ0Ljg3JSAgW2tlcm5lbF0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFtrXSBfX2xpc3RfbHJ1X3dhbGtfb25lDQo+Pj4gICAgMTMuMTglICBba2VybmVsXSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2tdIG5hdGl2ZV9xdWV1ZWRfc3Bp
bl9sb2NrX3Nsb3dwYXRoLnBhcnQuMCANCj4+PiAgICAgNy4yNCUgIFtrZXJuZWxdICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBba10gbmZzZF9maWxlX2xydV9jYg0KPj4+ICAg
ICAyLjYxJSAgW2tlcm5lbF0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtr
XSBzaGExX3RyYW5zZm9ybQ0KPj4+ICAgICAwLjk5JSAgW2tlcm5lbF0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFtrXSBfX2NyeXB0b19hbGdfbG9va3VwDQo+Pj4gICAgIDAu
OTUlICBba2VybmVsXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2tdIF9y
YXdfc3Bpbl9sb2NrDQo+Pj4gICAgIDAuODklICBba2VybmVsXSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgW2tdIG1lbWNweV9lcm1zDQo+Pj4gICAgIDAuNzclICBba2VybmVs
XSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2tdIG11dGV4X2xvY2sgDQo+
Pj4gICAgIDAuNjUlICBba2VybmVsXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgW2tdIHN2Y190Y3BfcmVjdmZyb20gICANCj4+PiANCj4+PiBJIGxvb2tlZCBhdCB0aGUgY29k
ZS4gSSdtIG5vdCBjbGVhciB3aGV0aGVyIHRoZXJlJ3MgYSBwcm9ibGVtIHdpdGggR0MnaW5nIHRo
ZSANCj4+PiBlbnRyaWVzLCBvciBpdCdzIGp1c3QgYmVpbmcgY2FsbGVkIHRvbyBvZnRlbiAobWF5
YmUgYSB0YWJsZSBpcyB0b28gc21hbGw/KQ0KPj4+IA0KPj4+IFdoZW4gSSBkaXNhYmxlZCBkZWxl
Z2F0aW9ucywgaXQgaW1tZWRpYXRlbHkgc3RvcHBlZCBzcGVuZGluZyBhbGwgdGhhdCB0aW1lIA0K
Pj4+IGluIG5mc2RfZmlsZV9scnVfY2IuIFRoZSBudW1iZXIgb2YgZGVsZWdhdGlvbnMgc3RhcnRp
bmcgZ29pbmcgZG93biBzbG93bHkuIA0KPj4+IEkgc3VzcGVjdCBvdXIgc3lzdGVtIG5lZWRzIGEg
bG90IG1vcmUgZGVsZWdhdGlvbnMgdGhhbiB0aGUgbWF4aW11bSB0YWJsZSANCj4+PiBzaXplLCBh
bmQgaXQncyB0aHJhc2hpbmcuIFRoZSBzaXplcyB3ZXJlIGFib3V0IDQwLDAwMCBhbmQNCj4+PiA2
MCwwMDAgb24gdGhlIHR3byBtYWNoaW5lcy4gIFN5c3RlbXMgYXJlIDM4NCBHIGFuZCA3NjggRywg
cmVzcGVjdGl2ZWx5LiANCj4+PiBUaGUgbWF4aW11bSBudW1iZXIgb2YgZGVsZWdhdGlvbnMgaXMg
c21hbGxlciB0aGFuIEkgd291bGQgaGF2ZSBleHBlY3RlZA0KPj4+IGJhc2VkIG9uIGNvbW1lbnRz
IGluIHRoZSBjb2RlLg0KPiANCj4+IFdoZW4gcmVwb3J0aW5nIHN1Y2ggcHJvYmxlbXMsIHBsZWFz
ZSBpbmNsdWRlIHRoZSBrZXJuZWwgdmVyc2lvbg0KPj4gb24geW91ciBORlMgc2VydmVycy4gU29t
ZSBsYXRlIDUueCBrZXJuZWxzIGhhdmUga25vd24gcHJvYmxlbXMNCj4+IHdpdGggdGhlIE5GU0Qg
ZmlsZSBjYWNoZS4NCj4gDQo+IE15IGFwb2xvZ2llcy5VYnVudHUgNS4xNS4wLTkxLWdlbmVyaWMg
LCB3aGljaCBpcyA1LjE1LjEzMS4NCg0KVGhhdCBrZXJuZWwgaXMgbGlrZWx5IHRvIGhhdmUgZmls
ZSBjYWNoZSBpc3N1ZXMgd2l0aCBzeW1wdG9tcw0KdmVyeSBtdWNoIGFzIHlvdSBkZXNjcmliZWQg
YWJvdmUuIFRoZSBpc3N1ZXMgYXJlIHRob3VnaHQgdG8NCmJlIGFkZHJlc3NlZCBieSBrZXJuZWwg
cmVsZWFzZSB2Ni4yLg0KDQpJIGNhbid0IHN1Z2dlc3QgYSBzcGVjaWZpYyBwYXRjaCwgYXMgdGhl
cmUgd2VyZSBhIGxvbmcgc2VyaWVzDQpvZiBmaXhlcyB0aGF0IHdlbnQgdXBzdHJlYW0gdG8gYWRk
cmVzcyB0aGUgZmlsZSBjYWNoZSBwcm9ibGVtcy4NCkJlc3QgSSBjYW4gc3VnZ2VzdCBpcyBmb3Ig
eW91IHRvIHN3aXRjaCB0byBhbiBVYnVudHUga2VybmVsDQpiYXNlZCBvbiBhIG1vcmUgcmVjZW50
IGtlcm5lbCByZWxlYXNlICg2LjIueSBvciBsYXRlcikuDQoNCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0K

