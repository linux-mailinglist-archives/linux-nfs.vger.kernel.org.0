Return-Path: <linux-nfs+bounces-2433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10440885B8E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 16:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8681F2122F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC7586134;
	Thu, 21 Mar 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DM78XeJ4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bCn9K4cn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447ECA947
	for <linux-nfs@vger.kernel.org>; Thu, 21 Mar 2024 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034603; cv=fail; b=siH4g32s6HiglJ7QEH0qUAjIKTAI8aqirjvZWJqVstMaKK6Q9i8EUcn3dVkaFUwyT8U2zfPdosQt4PBaVfrebSbRh3ei3yMqE9h6kqeJPimGtKoWRwxx8VsTbmhbGb5qLqiRGZHgPgv1PUBstuTN2bCt+GLR17PipV8ms/feDXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034603; c=relaxed/simple;
	bh=ql+a+6Vt6sRZPoSWooas62AA1LIbov5ZrIjT3IH0PYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oteGih9aO67ASUkPQraPntONn381Y1RBalv86cN1fpcJ3TyOppIF+6C8oZr/HeCHp8OJUuTcshyLX2HtTU3AGNcTwawvlWbRKrq0U4Uky9NEmdFrm0XDZiSGVZvOl916U/14kkSEMEA7MobrkSA1L/vx5hIe5yuaW9dpaG7culM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DM78XeJ4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bCn9K4cn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LCmnV6011137;
	Thu, 21 Mar 2024 15:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ql+a+6Vt6sRZPoSWooas62AA1LIbov5ZrIjT3IH0PYg=;
 b=DM78XeJ4nX7eh1KilMWNT+SqvanmzdJxSNQmvWf9SrxVMR8YDekYZdtySK+StsYJKyJi
 9jM+jE6dhyS2ZseMtFBVa+ckp+rOJIvKRQ2wgjCOJokQClukK7USHbSMmX/EN/gkNMJA
 BCcghb1JC8tLZ9Ee2T1aoFxrSnGmx+tzu+Bdi1+ANLskKqXBnjewSMkF1xNKvLvLKzGQ
 u4Mpln1FgSwVuhmGJVgVWTIntC4/1heRXT+TWdtNS4g1I4MAUv6MP1YSDnPJO8OCH751
 uZifK5axR0ophAO9LS3Gv3mqxbfSXGhr+1GdQGhYMK3RAF727mfj4UKLLX2K4UsrYq1G uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aajkjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 15:23:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42LFGOuc005979;
	Thu, 21 Mar 2024 15:23:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v9np08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 15:23:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD6++deYTCtQHxMg794l555Kn1kQYQvJdHrtgjohsy5CzvlwaMY8t/CoyGdFjD3FeUYnk7MrdG8Y6iiVh9pmIS1Tz9O58v3jx1YUx0scbD1fj/PQuTPeo2eBN5IvoPUv5Ay53Hfl98eckcicDzeI4P9UF31o8EIULJcmi6O9651vOp2w+oAB013DZBmW2JwVUbhSjaT/yTizv7fdB6cJl5dgkMduVQvXSelTW6dZPfKOdXr4K1pea3syfBJM6dO6iI7XYgr3RH3mxO9Vsc+j4YZlNuIdtsXm9rhbbinV5OrQNtSvwXhBsLaM1eMc44yF5vJqzlsDFLAqmqTcju+ikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql+a+6Vt6sRZPoSWooas62AA1LIbov5ZrIjT3IH0PYg=;
 b=bH5CULKPL6+G6z4Ge7zI/uOe3y8RJY7AARjwUamV8nlEjGxX+eeMKQKAO9iu8ptCuGIXAKb5NnvnHt++bz8OQq11h3RAgN0dSmWJoXobPsASiYIskyAy7KfYWeKZZ01AQTegrdZSReK+HvdsiShBU2e6vbALQF0OBnqa/08uaath7adF7TBvznkemJMlmA8LEvcUoJiezqaHGQFxEjdHv9qCvurhXJJs1vqnaUaHaVTRx9cBUJGpJLo3pbWah6Pvnz/X2f6WCqkaAgiVWLX8o3Xt8jHcTsSYkew03PRYZbIDI3lQPgyDomoAtrB23DDw8Hy4yb1Ze5meNm4ZTu+S1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql+a+6Vt6sRZPoSWooas62AA1LIbov5ZrIjT3IH0PYg=;
 b=bCn9K4cnYj7lx3jXTT8ZBteaMU93NASn6yLPHoe5Nsa3cJG69dieLhTcKViKwcrc470Cvpaw0HKmiA8RSp0Ug5HdyGq2kWAdUpskq0CR+C7R27UFvcXJX2A8i+hJTl5WJjQKJa/0yow8usmKJ+Iqj3AwYDTTrI1QRuH1vtL6tF4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7801.namprd10.prod.outlook.com (2603:10b6:510:308::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 15:23:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 15:23:07 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Scott Mayhew <smayhew@redhat.com>
CC: "npache@redhat.com" <npache@redhat.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: Problem with the RFC 8009 encryption test
Thread-Topic: Problem with the RFC 8009 encryption test
Thread-Index: AQHae59BP+S2B0Zs+kKU7c8YYnGu4LFCUA0A
Date: Thu, 21 Mar 2024 15:23:07 +0000
Message-ID: <ABE757BD-D131-4774-AE22-2C93C90E09DE@oracle.com>
References: <ZfxJZFwXqqurfet0@aion>
In-Reply-To: <ZfxJZFwXqqurfet0@aion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7801:EE_
x-ms-office365-filtering-correlation-id: 0f748d2a-4b80-4c75-07fe-08dc49bacfc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FtEJzGZ2H0UKOvB2eLOLjTPv1lUEEyLPbCpR4rtVomYreE2oVmPMcj9RZVfgOedfT4nnvypc4yAKXDDXpTsa2nPzumvarSUAaUnalBdSQBF1LaFlJ18u16GCZfLcRvYFRmT1G9aip98oLMWfcq93FbIMN6+WQfgPnuSW93M+5BrYgn/7bw5URWlOniOUfljHVmVV223Vo6+EmZgZAnBDi4owp7Hzbo5JNVBR/SwnU5mjV84Iiv0MOXTcaNJk0tHJ97CQVHD+z4LdUXYy3gCPIWVfi7iRq+Uu65dwrnL5QK4ZpkLWbUoKzJkL8F1ESwa0ScFPyR+q2S3cHKIofFIFOGnVV2TMDIOwyqXe/fe3kFWgATumJpD9EKdVMdjjPAGdyplFKduAz+kWLYgyxUFJHjxicDSruY1AZy15BWzkYiL4UiADtR9LCs4CKDo5v08bh39UpQPxUIzAim3lIYo9CgXO0P4pfLm4jN4Izq4qV3g4D8dPFizIpyLSys3np/E8BRJ9u1iQz8Vvx1pbpBKfSHubZgjUE6YMnDp97SoddCF+5mWq2Nk0l1zAvcRiDqkDjd2acBOIe7pZX1oqGKaqBhzU+J73QCXocPNwYeL0t5RAbzUM3DXKme6Q2fhYNA4KD3711nXwGdxSIsNnPdfgL6fBmhvIzMQzTDeQrg+rWYo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cWlsZ0Q2cGhPM3ZCRFlwYlQ5OXo0eGdmUGtmbXVwS2JLczFiTm5KRlE3RUlT?=
 =?utf-8?B?WkgzYW1jcTE0MWVHR2FtVGNrMjU4MXQrOWxDSVNBQU9JM1dLRWJJMjFSQ3dK?=
 =?utf-8?B?ajVMVk15cW5pNVF5bkU4R3ZHdDNKVmhoQSsrSmVOOWdlSVYyejMzbWJlSTVo?=
 =?utf-8?B?a2dVeEJtWDZNUE5KTUtTSHhWK3k5N2g3aWZEalcxWXdieHZScWR3dkdxU2Ex?=
 =?utf-8?B?WjFESDlaVHhCemFFanBLNlJhczE4NGhDTmkrNzJ4SDJJRkJiaDE5V2liU0s3?=
 =?utf-8?B?RmtYb0ZnLzJuaHA4em9pbjVPdWFvYlV2VHZZenZLNVhlVk5wVWFHZ0xucXJz?=
 =?utf-8?B?TUgzWHdUWGswVTZkWnRac1hHU1BzR3lkY1FYZlZzQ2ZVNE5zSEhNNzhGR2Qv?=
 =?utf-8?B?TkF5RjFBTnUzZVhFc3J1WlltUEVuYXgzdng4OE9wTUZmZlRwRGk5UlRjcVBq?=
 =?utf-8?B?WUJmUElmTkFacDFIbmNKWEdYdnk0a2UxaUVCNTRWS2lPem00cDduZE04b1NO?=
 =?utf-8?B?cTJ6UWd0MVlTY1VpcUNjeDJCc2x3QUx4TVBPVVpKbWpGcnlLOWtXU0g0NW1u?=
 =?utf-8?B?SGF5Wm5CKzFwSlBzV2kybitnMVJmMW90Y01uRkg4VlBqckxDV05OSGpUbmdw?=
 =?utf-8?B?NDdnaitwdW11eG9tL1VOQlBMblpqdktpdkkyemI0UUVTSWxPbndCYTVBVENL?=
 =?utf-8?B?N3dEazNZVHVGNlg0NHhSUjk4bkdQNU9pTkxFZUZISXNpK2pzRHFtVUFzWmtx?=
 =?utf-8?B?dndUaEE0a3BkVEZ0bTJtRzBjUmdXMDdRUzZwM1ZFS29rV2lqZ3VtZGtmZ3Nl?=
 =?utf-8?B?aTBVWFlhaStvdnF4SE1WSGR4Tm9jYXNVNlRIb1g2OWFxRmJFL2VsOGZTMzBN?=
 =?utf-8?B?NlpmMVpab2Z3NHc2UVpENENGbXdHZnVtSVZLNjV3ZjRCbmtnZlRMWFR3MjZy?=
 =?utf-8?B?bjFsWlFxUmxmNGhPVkpaNjUyR1QxZVdHRGxwUGxGdEN0VkF0VERKZGZGVEto?=
 =?utf-8?B?TnNqNnpjKy9FV09nM3Z4MVpXWDE3VjlFQ1JPcEZkV3J6R3pLNEJLb1pGNzc3?=
 =?utf-8?B?clc3RXRjTGhkc3F5SHMvUDdYZ3A1ZEZFeTNIY3NaWXU0STcwTjV2QkpybWV1?=
 =?utf-8?B?OVpRVUJxOEpGV1FUYXZ3R25lUWpjNDExbXIraU12cnNTYnFTYnhxVThKMEo5?=
 =?utf-8?B?UlE5OWdpVUVkU3VDR1IrNTFzYlYrUlpKeWV5M0h3K0JnVGxsTVhiM29YUGxn?=
 =?utf-8?B?ZHdzMGF4VXpQZktRb3pNVzRGWXZJUlM3Wk9JNTlwS3RZS0l3cm1ENUdmZU9H?=
 =?utf-8?B?R245cU5oVnJpeWd3MXRacWpUcVg1QW15c1JTc2swUzdYSXZuS1k3elNDYTJL?=
 =?utf-8?B?SzRZdGw0Tk04Z2pZcVdDNTJDVXJkYmFaZzRYYXIydXJ0VU5Rb2c4UXVQbWxt?=
 =?utf-8?B?MWNtUU9vakg4Q2pIM1J4K3luNGMzeG5jZHJhZnlUVXJOdUhpWE5XckpMeU1a?=
 =?utf-8?B?SmREY0krWTZWR2Zmck9NNVhyRUVIaWVBVTlNbTkyYVI0NWxaeS93QzZVNFBx?=
 =?utf-8?B?VW9PYjdWa0s5Ymk1c2ErS3NmeW95bTNKczFKL1hyNWZkbnc2WXFqQ3BhbXRP?=
 =?utf-8?B?RE1pcy9VdEZ0bXB1T0drVDZjbjhnZDJRSjdRUUFmWHJiTW5MOWppZzJUZ0wx?=
 =?utf-8?B?aXZVK0NyWDFxN2xxSHNaVjZLNkFxdkp2eDJ2eXZlU2JqaE4wajd1NFlOUFBo?=
 =?utf-8?B?UHJlRm5TTXJUcyszbERHbGg2cmtDWTYrZGJoYjhEUHdYSWZXQlUyYkJ5SEli?=
 =?utf-8?B?UTBIWENGVzc2bUE3NERyN3FMcWlScWlhRGY3WFBrV3A1WVRCLzJnRkFOS2ph?=
 =?utf-8?B?YjVvQS9FckZtTTZpUTBDd2R5dTNZVStBOHZ3Mk8zeURqTmxoclhlRzlueGtj?=
 =?utf-8?B?N3N4eFJ6ZEZqaDhiKzBLVHE5VURvSzFia2JWSkJwdWtrRjFiRHQxSzcrSW9w?=
 =?utf-8?B?eWk1L2RGYjd1Q2Jad01BVzEzZ3EzWUNocFA3cXgza3VqZVVDU1pyK0Vtcmcx?=
 =?utf-8?B?TW1zeXpzb0FPNzFHVUNMK2lvWmZtWThtTUE0SlF5dlFrM0hoemo1OWg3SWdz?=
 =?utf-8?B?Ri81Zm03QUs5c0FUR2R2TjAzcEt2R240WUV2WTR0NFl3Sm1UUTZVSDVveEZM?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2CD8EB88C131F4BAC6E9AFFE280123C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	m8ilULmha340fywI59j+ORg9x8vPO+x6FBQ10EQLEwjKyQrwNkk8vmDkTHlbTHU0dadI6kNEIa+ivp3lFb8/BcIbnzNOzxhWHrPAcx4+O1K/VSAf2N6uGlGeIdDuXC9JkdS9rFoptWNiAVyDzWX8R6lgEzPu6P/nSmx/N/XyxwX0xhWuyEEHwSjFYN/jlWGr6myFKKZPmVEc7/hmm412zG0vyn6VH4ZB1+NqyiNutms3XTDoOt1FwlHS+2OiZLurlQDEAcnUkoxPKaBj+N2cLVtGpMH/QSTnJWgHfQDyHSOl2H6xltpdM25KLsM1nb3C/DbfAmeO4JTxZkiFO2KvB5hLzryTKroV5TpNjP1kUcAl7vA25LyX1saJQgw4UipXwc1QUlIom1JcTCLCMVUJ5GJi9RVuvc/hzBX4D2lqMYJiZ67TfGYgd1p9HtPtBfXDd37avDNFBrlTQeaOpzsob8VFD7frf1iZNbTwbVz7U9aYLMZCAngbGbQgD1E1uvGrcvT/X0sPsBb2zW6A60CqXKoeNVgTAnpIJ1EgA1qqDAq66EEOY7C4BkMReAvL1CQhmzfQmxX/o/Qwp+IZgQA6yhI8gXda7HKptWRA7rKbxpI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f748d2a-4b80-4c75-07fe-08dc49bacfc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 15:23:07.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t14fg+5aR4NrXprwXpVX/d+jKwL3NNlgsC+Eol2nfbDXhgyLfyvMWph2g/rFJIXm5AjHlUnSXI7HcZ52R8SWXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210111
X-Proofpoint-ORIG-GUID: FbEB8w8T5KIVL-kvL_p72cCWFqMw5gJf
X-Proofpoint-GUID: FbEB8w8T5KIVL-kvL_p72cCWFqMw5gJf

DQoNCj4gT24gTWFyIDIxLCAyMDI0LCBhdCAxMDo1MeKAr0FNLCBTY290dCBNYXloZXcgPHNtYXlo
ZXdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBDaHVjaywNCj4gDQo+IFdoZW4gdGVzdGlu
ZyBhIGZpeCBmb3IgdGhlIHByb2JsZW0gdGhhdCBOaWNvIHJlcG9ydGVkIFsxXSwgSSBmb3VuZCBz
b21lDQo+IG9kZG5lc3Mgd2l0aCB0aGUgUkZDIDgwMDkgZW5jcnlwdGlvbiB0ZXN0LiAgU29tZXRp
bWVzIGl0IHdvdWxkIHBhc3MsDQo+IHNvbWV0aW1lcyBpdCB3b3VsZCBmYWlsLCBhbmQgb3RoZXIg
dGltZXMgaXQgd291bGQgb29wcy4gIEkgYmlzZWN0ZWQgaXQgdG86DQo+IA0KPiA1NjExNDFkZDQ5
NDMgU1VOUlBDOiBVc2UgYSBzdGF0aWMgYnVmZmVyIGZvciB0aGUgY2hlY2tzdW0gaW5pdGlhbGl6
YXRpb24gdmVjdG9yDQo+IA0KPiBJZiBJIGJ1aWxkIGEga2VybmVsIHdpdGggQ09ORklHX0RFQlVH
X1NHPXksIEkgZ2V0IHRoZSBmb2xsb3dpbmcgb29wcw0KPiANCj4gWyAgIDQwLjQxNzIyMF0gLS0t
LS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+IFsgICA0MC40MjE4ODRdIGtlcm5l
bCBCVUcgYXQgaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oOjE4NyENCj4gWyAgIDQwLjQyNDQ5
MF0gaW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBQVEkNCj4gWyAgIDQwLjQy
NzUxMV0gQ1BVOiA0IFBJRDogMzY4OCBDb21tOiBrdW5pdF90cnlfY2F0Y2ggS2R1bXA6IGxvYWRl
ZCBUYWludGVkOiBHICAgICAgICAgICAgICAgICBOIDYuOC4wKyAjMTMNCj4gWyAgIDQwLjQzMDAy
NV0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJ
T1MgMS4xNi4zLTEuZmMzOSAwNC8wMS8yMDE0DQo+IFsgICA0MC40MzIyOTFdIFJJUDogMDAxMDpz
Z19pbml0X29uZSsweDg1LzB4YTANCj4gWyAgIDQwLjQzMzIzOF0gQ29kZTogNTEgNWIgMzcgMDEg
ODMgZTEgMDMgZjYgYzMgMDMgNzUgMjAgYTggMDEgNzUgMWUgNDggMDkgY2IgNDEgODkgNTQgMjQg
MDggNDkgODkgMWMgMjQgNDEgODkgNmMgMjQgMGMgNWIgNWQgNDEgNWMgYzMgY2MgY2MgY2MgY2Mg
PDBmPiAwYiAwZiAwYiAwZiAwYiA0OCA4YiAwNSAzZSAyNiA5ZiAwMSBlYiBiMiA2NiA2NiAyZSAw
ZiAxZiA4NCAwMA0KPiBbICAgNDAuNDM3MTkxXSBSU1A6IDAwMTg6ZmZmZmFiMmFjMmQ4N2NmMCBF
RkxBR1M6IDAwMDEwMjQ2DQo+IFsgICA0MC40MzgxMjldIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBS
Qlg6IGZmZmZmZmZmYzBjZTg3NDAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgICA0MC40Mzkz
NTldIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiAwMDAw
MDAwMDQwY2U4NzQwDQo+IFsgICA0MC40NDA1NjZdIFJCUDogMDAwMDAwMDAwMDAwMDAxMCBSMDg6
IDI1ODE0M2FlNDNjMzc1Y2IgUjA5OiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgICA0MC40NDE3NDFd
IFIxMDogZmZmZmFiMmFjMmQ4N2QyMCBSMTE6IDdlNmY0NTVjNDhmZjUwYjcgUjEyOiBmZmZmYWIy
YWMyZDg3ZDIwDQo+IFsgICA0MC40NDI5MjBdIFIxMzogZmZmZjkwZGUwYTNlMTQwMCBSMTQ6IDAw
MDAwMDAwMDAwMDAwMjAgUjE1OiAwMDAwMDAwMDAwMDAwMDEwDQo+IFsgICA0MC40NDQxNDJdIEZT
OiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOTBkZjc3YzAwMDAwKDAwMDApIGtubEdT
OjAwMDAwMDAwMDAwMDAwMDANCj4gWyAgIDQwLjQ0NTQ5OF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVT
OiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiBbICAgNDAuNDQ2NDg1XSBDUjI6IDAwMDA3
ZjY0NTg2ZGM5OTggQ1IzOiAwMDAwMDAwMjNmMjIwMDAzIENSNDogMDAwMDAwMDAwMDc3MGVmMA0K
PiBbICAgNDAuNDQ3NzQzXSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAw
MDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAgNDAuNDQ4OTYyXSBEUjM6IDAwMDAwMDAw
MDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPiBb
ICAgNDAuNDUwMTk2XSBQS1JVOiA1NTU1NTU1NA0KPiBbICAgNDAuNDUwNzAwXSBDYWxsIFRyYWNl
Og0KPiBbICAgNDAuNDUxMTU1XSAgPFRBU0s+DQo+IFsgICA0MC40NTE1NDRdICA/IGRpZSsweDM2
LzB4OTANCj4gWyAgIDQwLjQ1MjA5MF0gID8gZG9fdHJhcCsweGRkLzB4MTAwDQo+IFsgICA0MC40
NTI2OTBdICA/IHNnX2luaXRfb25lKzB4ODUvMHhhMA0KPiBbICAgNDAuNDUzMzYxXSAgPyBkb19l
cnJvcl90cmFwKzB4NmEvMHg5MA0KPiBbICAgNDAuNDU0MDI5XSAgPyBzZ19pbml0X29uZSsweDg1
LzB4YTANCj4gWyAgIDQwLjQ1NDY3MV0gID8gZXhjX2ludmFsaWRfb3ArMHg1MC8weDcwDQo+IFsg
ICA0MC40NTUzNThdICA/IHNnX2luaXRfb25lKzB4ODUvMHhhMA0KPiBbICAgNDAuNDU2MDA5XSAg
PyBhc21fZXhjX2ludmFsaWRfb3ArMHgxYS8weDIwDQo+IFsgICA0MC40NTY3NzZdICA/IHNnX2lu
aXRfb25lKzB4ODUvMHhhMA0KPiBbICAgNDAuNDU3NDA4XSAga3JiNV9ldG1fY2hlY2tzdW0rMHgx
MTQvMHgxZDAgW3JwY3NlY19nc3Nfa3JiNV0NCj4gWyAgIDQwLjQ1ODM3Ml0gIHJmYzgwMDlfZW5j
cnlwdF9jYXNlKzB4Mzk3LzB4OGYwIFtnc3Nfa3JiNV90ZXN0XQ0KPiBbICAgNDAuNDU5MzYwXSAg
PyBfX3NjaGVkdWxlKzB4M2U4LzB4MTUyMA0KPiBbICAgNDAuNDYwMDI3XSAgPyBfX3BmeF9rdW5p
dF9nZW5lcmljX3J1bl90aHJlYWRmbl9hZGFwdGVyKzB4MTAvMHgxMCBba3VuaXRdDQo+IFsgICA0
MC40NjExODBdICA/IGt1bml0X3RyeV9ydW5fY2FzZSsweDkzLzB4MTkwIFtrdW5pdF0NCj4gWyAg
IDQwLjQ2MjA0M10gIGt1bml0X3RyeV9ydW5fY2FzZSsweDkzLzB4MTkwIFtrdW5pdF0NCj4gWyAg
IDQwLjQ2Mjg4MV0gIGt1bml0X2dlbmVyaWNfcnVuX3RocmVhZGZuX2FkYXB0ZXIrMHgxNy8weDMw
IFtrdW5pdF0NCj4gWyAgIDQwLjQ2MzkyOV0gIGt0aHJlYWQrMHhjZi8weDEwMA0KPiBbICAgNDAu
NDY0NDk4XSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPiBbICAgNDAuNDY1MTY1XSAgcmV0
X2Zyb21fZm9yaysweDMxLzB4NTANCj4gWyAgIDQwLjQ2NTgxMF0gID8gX19wZnhfa3RocmVhZCsw
eDEwLzB4MTANCj4gWyAgIDQwLjQ2NjQ3N10gIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0K
PiBbICAgNDAuNDY3MTczXSAgPC9UQVNLPg0KPiBbICAgNDAuNDY3NTkzXSBNb2R1bGVzIGxpbmtl
ZCBpbjogY2FtZWxsaWFfZ2VuZXJpYyBjYW1lbGxpYV9hZXNuaV9hdngyIGNhbWVsbGlhX2Flc25p
X2F2eF94ODZfNjQgY2FtZWxsaWFfeDg2XzY0IGdzc19rcmI1X3Rlc3QgcnBjc2VjX2dzc19rcmI1
IGF1dGhfcnBjZ3NzIGt1bml0IG5mdF9maWJfaW5ldCBuZnRfZmliX2lwdjQgbmZ0X2ZpYl9pcHY2
IG5mdF9maWIgbmZ0X3JlamVjdF9pbmV0IG5mX3JlamVjdF9pcHY0IG5mX3JlamVjdF9pcHY2IG5m
dF9yZWplY3QgbmZ0X2N0IG5mdF9jaGFpbl9uYXQgbmZfbmF0IG5mX2Nvbm50cmFjayBuZl9kZWZy
YWdfaXB2NiBuZl9kZWZyYWdfaXB2NCByZmtpbGwgbmZfdGFibGVzIHN1bnJwYyBpbnRlbF9yYXBs
X21zciBpbnRlbF9yYXBsX2NvbW1vbiBpbnRlbF91bmNvcmVfZnJlcXVlbmN5X2NvbW1vbiBpc3N0
X2lmX2NvbW1vbiBrdm1faW50ZWwga3ZtIGlUQ09fd2R0IGludGVsX3BtY19ieHQgaVRDT192ZW5k
b3Jfc3VwcG9ydCBpMmNfaTgwMSByYXBsIGkyY19zbWJ1cyBscGNfaWNoIHZpcnRpb19iYWxsb29u
IGpveWRldiBsb29wIGZ1c2UgbmZuZXRsaW5rIHpyYW0geGZzIGNyY3QxMGRpZl9wY2xtdWwgY3Jj
MzJfcGNsbXVsIGNyYzMyY19pbnRlbCBwb2x5dmFsX2NsbXVsbmkgcG9seXZhbF9nZW5lcmljIGdo
YXNoX2NsbXVsbmlfaW50ZWwgc2hhNTEyX3Nzc2UzIHNoYTI1Nl9zc3NlMyBzaGExX3Nzc2UzIHZp
cnRpb19ibGsgdmlydGlvX25ldCBuZXRfZmFpbG92ZXIgdmlydGlvX2NvbnNvbGUgZmFpbG92ZXIg
c2VyaW9fcmF3IHFlbXVfZndfY2ZnDQo+IFsgICA0MC40Nzg2ODRdIC0tLVsgZW5kIHRyYWNlIDAw
MDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiANCj4gTG9va2luZyB0aHJvdWdoIHRoZSBnaXQgaGlzdG9y
eSBvZiB0aGUgYXV0aF9nc3MgY29kZSwgdGhlcmUgYXJlIHZhcmlvdXMNCj4gcGxhY2VzIHdoZXJl
IHN0YXRpYyBidWZmZXJzIHdlcmUgcmVwbGFjZWQgYnkgZHluYW1pY2FsbHkgYWxsb2NhdGVkIG9u
ZXMNCj4gYmVjYXVzZSB0aGV5J3JlIGJlaW5nIHVzZWQgd2l0aCBzY2F0dGVybGlzdHMuIA0KPiAN
Cj4gSSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBiZSByZXZlcnRlZC4NCg0KT2ggYm90aGVyLg0K
DQpZZWFoLCBJIHJlY2FsbCB0aGF0IHBhdGNoIGlzIGEgY2xlYW4tdXAsIGFuZCBkb2VzIG5vdCBm
aXggYSBidWcuDQoNCg0KPiAtU2NvdHQNCj4gDQo+IFsxXSBodHRwczovL2dyb3Vwcy5nb29nbGUu
Y29tL2cva3VuaXQtZGV2L2MvUURLMVBnV0pFZFENCj4gDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoN
Cg==

