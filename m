Return-Path: <linux-nfs+bounces-5438-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97719956C20
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 15:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D551F23845
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058716C86F;
	Mon, 19 Aug 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AeUpF03/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iKNDTf2c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8216B749;
	Mon, 19 Aug 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074134; cv=fail; b=FA/KEqke7FtWkEXCbVDxg+88j5rdSGZg7TxgFPXvXqcbFEP+3/+NoZ7nkN9eJlM/USN/nzp29CEvDmUHFYu2LrFp5SnCkOiMPzlpS05WJHN5MaHzUo3E26+vr/kHysCkZpFYGvQTVG/2rmEj11hX1qDjhTh9WEOAs++Egg7L5f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074134; c=relaxed/simple;
	bh=RNdYGMen3CA4eqSM7mpwmHYDJxh2pQF1CZRZQqmmHWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WhkA0ZLR00Bd4XFH4WhKM/RN0gQ8D8GoUYI/a1yKkQARVSVurnA3o1o6RoTVXByCBtwDMM56X/zADESffiikx4zI4z50duWikMRAwMbh8DVkMGnfPCNjghw2AxDS71nT4HpG++3PJVBGvpVn1EazJ/7gfcm+GMyxnO31DyQztuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AeUpF03/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iKNDTf2c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6tlN013285;
	Mon, 19 Aug 2024 13:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=RNdYGMen3CA4eqSM7mpwmHYDJxh2pQF1CZRZQqmmH
	WI=; b=AeUpF03/X3YC6X6hh3JalGn0fMxSlsQb1iPIDhuIYZOC3Dqz+s3Nbzfkk
	lHuzxtXwwF3Booqd5Uwjxa2LVsbIlD1muCcok1nKs/8k1SASnS717JUhMMdJ3F9U
	9E9y2qq5xVzb/tLP9gaAoYUP8661UjvCekRduaW+i72xYnkywSTHUXC4pSRfvqIp
	1oALuTFXqEHsLKPBqAA2Q787Ny1Sm79KaEXk2R6j9rZMaLtQFBEun87rBjbcgmp2
	grjDT/DkCyuQaa/rwiB+daqVq0NBiXrq8VyGuVBvoHZlSlqjSF3lKBdUnJm6toEw
	cfjF14rATdYx2sSEMB63IrcO+OZdA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67ajbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 13:28:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.17.1.19) with ESMTP id 47JCMZAu029849;
	Mon, 19 Aug 2024 13:28:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h3p524t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 13:28:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQgpAt9pk0866dA3K8d3IRdNgt07gBwCVO8iKocO8zgq7sNlfbo43XVLwx1uAyb8Qm7OnGu7OMXxZtvMoce0/vhhPGudR4n2Rs1SQERhUKWh9daGbkHyLX8wpBLJpYE58HR/YkRkT57DJXDsOv1KNQTeX8cOKeWgLAp/aTvTLYB+AYxIbHPecVZ7tvKSb0FGydcsbjx+I7KQ0FJHkJolv85SWQ/NtixN1DJGs8NaJBsfm2aFDLhlN8DLJed+n5H3qxlaRTjriMGwpab45usLCZ9asebzNLuduINemvApONIxHUW4NaEQ2lqJcgyoHUEwI8gEaiLT3dDuygo6IzCgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNdYGMen3CA4eqSM7mpwmHYDJxh2pQF1CZRZQqmmHWI=;
 b=tSYUNUI+czhcVFcXvTsCE65UAgCqg4S8bIzC5/wdtveGhmdZrUDR3tHhgUrUBrls/H/gKoWf7XTzhPP129vTQ1GjdMuO6tsU8UcMM2cTnvlKQFXpCaWVI+qjkbRc1TEhb+/hsmDpp9YcRjpQ7DnsvG94VeclI5Bb1veANeptny0d5ZPo6fR/2CHS0TKOQ877IIUHUS72h7AGgDG8+8YOQwuSBo/tUICpZK5+iEQ4OIwmuTWGBwt26tuSSf0Mcc/kpJUcz9QN4INm0oVM2oOnnhleUqkrm85hebf0xkkOFFthuuyWdQ6wc2HQgi+UiQzdtTZzwY1CskcvudBVfECtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNdYGMen3CA4eqSM7mpwmHYDJxh2pQF1CZRZQqmmHWI=;
 b=iKNDTf2cGOb5qK5w+FCv2mR/bdJvaVOmVD6bX8FlX3l/kqXkWOLuj7sRnDesoJ0aojK92TXFhoHW044/AcilUsD5ZHWCvk8tOnBrNyIOhVuAwNqCMFW8LH+n1Nzu2fek1dFmR6WpQpAOnPDziNsl/EfyiQnLZah04oXOAdF5GJc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4224.namprd10.prod.outlook.com (2603:10b6:208:1d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Mon, 19 Aug
 2024 13:28:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 13:28:35 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>,
        Olga
 Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Trond
 Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Tom Haynes
	<loghyr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] nfsd: bring in support for delstid draft XDR encoding
Thread-Topic: [PATCH 1/3] nfsd: bring in support for delstid draft XDR
 encoding
Thread-Index: AQHa79nI8OZMU5h3VEKSAxjt3QjJK7IttuIAgADDuYCAABsBAIAAAXqAgAAAkYA=
Date: Mon, 19 Aug 2024 13:28:35 +0000
Message-ID: <67E54CBA-CC53-4BA6-A62D-3F594102AE6C@oracle.com>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
 <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
 <172402584064.6062.2891331764461009092@noble.neil.brown.name>
 <6c5af6011ea9adfd45abe4b5252af7319a3dbc94.camel@kernel.org>
 <E7E5447E-AD50-437D-8069-C77FFF516DCE@oracle.com>
 <f0ac4b0489da5f6198cb7c70f312e2889e97ea4e.camel@kernel.org>
In-Reply-To: <f0ac4b0489da5f6198cb7c70f312e2889e97ea4e.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4224:EE_
x-ms-office365-filtering-correlation-id: 3c916e94-38ca-451a-3095-08dcc052d419
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWRDWHgxTnpZelJMNnI4bm9NSm5pcjhPT1B2VE9iVnBuMVRaSkYzZHlCb3R0?=
 =?utf-8?B?aXNiMzBtdDlBVFA5UUlqenN6bFNaSmhNS3BYaStBMEJyMUxsSEdCKzIwd0l6?=
 =?utf-8?B?UlBpMDBPUThlYWxISnJ6WVZEWXlDV3pBRzMvSWFkTGdsaEF3VWtYVjZKejdr?=
 =?utf-8?B?d3lPY29TUTlDMWhJcU8zUjUyWDVHWmpPeXdaNE1SVkJUSW1VWWdIUnFkTzRa?=
 =?utf-8?B?cDZORmw0dWJmT2swdXJWaVY4UmVGNlovOFZrelRFaUQzRE9vWlFJNklxNWJu?=
 =?utf-8?B?ZWNZRFIzT1MzU0c3OTNMUmNNeElrQmF5enhSOTgvRWpWWVFmeEp3Q2lxeEVF?=
 =?utf-8?B?ek9uVytVSzFyY2ZwbUJpVkwxb1A2VGR2am9UYXBUdmlMUmJCRnF6ZnBIdDVk?=
 =?utf-8?B?NWppVzQ0c3FsNXFjbXZLSFNGRjZQcnRtazFVWHo1YWxFOUF3SzlqaEw1RllV?=
 =?utf-8?B?NUJ5SVZyeUFBb29wTWU0NUpZQ0NGalo4Rk9nNkhPWXBDbGQvMEpXa0lzaWRl?=
 =?utf-8?B?c2lCcC9xYzZFWWROc3JEK0diOEFGTFhlYWxzcFJnN09EL2VRcmUxTElta2hS?=
 =?utf-8?B?d0swSXZmajBYTU9ZL0lnQmxrMU5yOHN4V1VHZnBPY0pCTmFKT0hQMldFK3VO?=
 =?utf-8?B?SDErR09vcTE5bHY2NUlMWG5zWlVxRXlUckhGN1hKWWpqRTZFdzJrUmwzaTZs?=
 =?utf-8?B?bkhraGpDYjNnZm5jdEs2dHg5QkxHbFNFTDVrQXhMdkx3QkVGV0RYbmJJaVNy?=
 =?utf-8?B?bThEWXE1cXhWZG16Nk5XQ0wxZDJ5Y1JBRGo4V1F5TkowblpPLy9YS0hrR3Z6?=
 =?utf-8?B?UUt6WlVMZUQwemJPMnkvR0lZNXl1WWtLRzZzM1VpWmpjZ2Q5VkFSL3Q1N0NC?=
 =?utf-8?B?cFk2dnB3ellYV0U1dVdLRWdOd0haZ0tGUm4zRkhwdFBSUjc3N1BoeVo2RFU0?=
 =?utf-8?B?dGVMN2gyM0FMbSsrV0dCRk5FZlhPVGlCVURHOFRzSnBzK3RNMTk5NThBaDBk?=
 =?utf-8?B?U1pmL2xnNU1CNVQ3R2ZLQWM2UDJVMDc2NGxCcmhwUXhKcThDbjcxSFBBL1k1?=
 =?utf-8?B?Y2QvOGdRTjU0NFFrOTNFOWJUR3lqeHB4TVVSY0ZEM0dnekxPZExHS3krcHhD?=
 =?utf-8?B?akhOeS9WUlBkamJTZlI5OEh3MSt3VDdwUEFoRVoyN21YN1BJcHRjdG1oUGdw?=
 =?utf-8?B?S1BidnBzc0dMbVk1K09nWWZTYzJJbXZpYlVlalYwd3RPL2FGT09zTGI4NEVz?=
 =?utf-8?B?MWwrRGJTa2QvOVA3NE10R1JNVTdWbWpENklMQlhRZmkxK0EzNDZlaU9xcWVR?=
 =?utf-8?B?UGZqY1pqQlZLVTRONGFZWlY5dER1MWlvR1dDZkpsL3VZdzFJMXlTNVZ1TWJn?=
 =?utf-8?B?YUptdVpXTGNKUmhxYU5IZFJTNUpsL3VOQ3JNY25wd1c3eEs4elF1bHd6Y25o?=
 =?utf-8?B?bWxsdU1NSDY4SlRFSWZiUlZoNFl3RVNMZmpZMzg1RDZDSkZBejhkZWRRc0xz?=
 =?utf-8?B?NUliYUNqVDVGbzRLUXBrM2d5RVM2ZU5xOGN4eDRWNGdvNGFXOXJoeHczK0Fx?=
 =?utf-8?B?ZlF0U0QwRjE0NFhZY3E4dlJoMWdlaFFVY21rRDdnTG82TXZtald3Y0poNFQr?=
 =?utf-8?B?Q3pZWnJaZmY2TEN3OEJVamRtYXBFQURSS1JBd1FnSU9UWEFKZnNnN05oaTRy?=
 =?utf-8?B?UHp3d3A5NmpwYlhOdFdUN3ZQUFdpeHBZZDI3TStxaUFOSFpRWlQ5YlBHZm9l?=
 =?utf-8?B?bTNpVDBIMXFRZTlEbVNZYlg5WnJoS2d2ZWdRb01QTzBycWFhSjFTS3hoTXY4?=
 =?utf-8?B?QXVkRktIYkJxMEFZNTJMd3VkMFFTWGZScGpCT0hQamtsMU9RYlJCT1R4MGE3?=
 =?utf-8?B?cXowN09SdEY5aURvNlIwdU9UaSs5eWwyYmlDNkhTV2xwV0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0VCZzlGaWd6MXhTSHZsQWJLbk1qRHA2bkRjQnZWMmFQODRhK3VXMkxwczhh?=
 =?utf-8?B?dmxqS0tJZnRxOU51MVhqUU9aL0tWdS93c3FRQ2p1QjlIdXJZU29xM2xrL2t6?=
 =?utf-8?B?R3hmK2svbnJDMDRYT2VkWmRiY3B3N09xOVEzTmltTlQ4NFpzTk9rcEhZa2Y0?=
 =?utf-8?B?UGtkWEVtdzhHM3I1eDZjaG5JR0RwWFpMUE56a3JJeWV0dzYvSGJ1cjV0bEEz?=
 =?utf-8?B?K2Q3bGphRXlBZjlmanEvQTJrMFp2MHpyUUtoRTk4Yk5YZDlGRHI4aHFSdWZv?=
 =?utf-8?B?WnhKYTg5bFRQb3VHZkllcjVzRzRVSkIvVVJSN21yck5NVmpJTzNLVHA3dDM3?=
 =?utf-8?B?Q3NRT01pYW4rbml0TjlNSTJiRUpicTRSUW12T0taK1NqcTlKK3BoNE5JYmFW?=
 =?utf-8?B?cGlndzM5ZEp3YjVMb0lXVlpBbmRjNVhpVE1tdDN4ZlkwKzZtYSt4Y1NKTm5D?=
 =?utf-8?B?bkNmOXcxb0kxRUwwNkl1U3BXM3EvNGREWEpYNzJRSGtMaDlhS2J6L3NRb2Vn?=
 =?utf-8?B?TGlrbjdmNVZIUWZxa0VDTUFVNFdFaW5jUlJzQWt3a3ZjUXJIZGdSWkhTNWNN?=
 =?utf-8?B?Y0h6aVNhOUc4TTRaeWJ5c2tGU3JKKy9Wc3ovczJyOUtZYmVUa1BrN0VJaS9Q?=
 =?utf-8?B?eGFXOUtkZGE4ci9pMmVpVlFhc2hPYUxHTTZMbkliYk1CN2lDWThhUXJMamdQ?=
 =?utf-8?B?aTVkOWUxMi9IQVd2VThGZ2plN3NzbzNGUklObFFTVlBKM3NtZzA5VlZCNllN?=
 =?utf-8?B?ZzdDZm00TDlNZ2xkcmtOcmtQS3RSUE15aDI1N0U4RElSR2R5c2U0V0M1dnUz?=
 =?utf-8?B?ZHhxeFhtNExmSE1KSncwK2dSRHZ6Wk5MYTNhQzM0aEU4anFjQjFEVFhrNGlr?=
 =?utf-8?B?YjlQSHh1UmtLaXZlVGtZTVlPMml4bGtzTlFDMGNSY0UwMjRWWkVCYTJacjhD?=
 =?utf-8?B?RmZhYklKK3FqV3BJVFNvVVlmbnlRanFYMzFqTDh2LzI3NUpMTnpaVmVSQUxt?=
 =?utf-8?B?empScGpJaHlaWEkrSEQ2Z1Znc3NuYm9PRzNYVzFZQUcwM1ZvZk81a016VUxm?=
 =?utf-8?B?TEF1NFVqWVNTMktZZE94RkFsTkRjQW5UczhIenErQXRLelY1Q2FnSEV1bEpm?=
 =?utf-8?B?K2h5RzdnZUhDQ1ZiZHhNZWVzQmlIbStSaUxSQW5LUk1FRFVYZ0VaVnNDbllo?=
 =?utf-8?B?TGhHT2RsRjFOaW9rM2w4U1I3aDh1cndJWWdvdExVZ1hIOFNJTVNBOHQ3d3Zr?=
 =?utf-8?B?amIxLzgwS0RUNDgwa2V6cXJnbk9tUDFTa0tBZytzSVdYU3NBQ2JOd2FtaitE?=
 =?utf-8?B?My9CQXRsNkd2ckRPR1BNcTZsa1BYTk9COFgycTBERndtN01rbWRnSEU4TS9V?=
 =?utf-8?B?ZE0yWExDdUdRUWJ2b0g5c2tyNGxOcTNhaGVaVFZka1NraDhsVTFtTmtNN2dK?=
 =?utf-8?B?US9rNllKYjRqbHRheXQ0NDBqOUJjKzhEOGxQaGpnQlpwL2RSTHpZZmtINThK?=
 =?utf-8?B?bHFtVmNYUUdCMUlOakZEU09HWGR6bG5EbkxNRXc1ZTBteWRXeklzd2ExMUtC?=
 =?utf-8?B?ZU94VkF3RVkyYlZVOWpWSTRJNXEwS1lMVC9tbzVVNjQ3NFZPM3BoaHFkOXZI?=
 =?utf-8?B?TU1XaEJvRCsrOGdOR3ZPZkY0eU1JREpnTnVxK29Lb0JQdm52M0pWUHJpVjls?=
 =?utf-8?B?eFNtdjd6Q3VJcWI3dnZmYUNKenRaWVBwMjljT2VtZW9SRHZFc1VSc21qUmxn?=
 =?utf-8?B?Um8wTG9obUxCaFQ2SllSVC9Jb2dOR3ZKMkpLd0x2K1d3RU85WWpJL08rNFVF?=
 =?utf-8?B?b2ZkVHA5S0ZTYXdqQisxUitxcXF1OGxHK0pkRnIwbTV1YzhmY2xmME5ZMnl0?=
 =?utf-8?B?L0hOejhnMTh0Y3ZDQy83YmdydnZuK2l2enlBSG8wdStjNnUyWnVrZmxhQkZJ?=
 =?utf-8?B?b0E0SEdWeHhWeGdMMWZXaGQwcW5vemNibm04d3gwdkxYVHN5NzJ5QWVEblpw?=
 =?utf-8?B?aDN0bkNNR1VnK1RaUjZiRUx3UW5jZThkTUJpck1BVzJGQ1MrS3h1M0lwdG9q?=
 =?utf-8?B?SUd5d1F2MHhGZ0NlVWZKaU1rdE9pTlJGT3pyOE50ejVEVTdlK1pvSk00T05t?=
 =?utf-8?B?T09VQkprZ1N0ZGNFb2YvT25ONU5OVTZqOWNSVStvMVlSMFZvZGs0WTNsK0Fr?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64EF571885435043B061C10DBCF4775C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p6KepagAHm18PA3krF4EJpVy2uoN61nWYSiP22iemc36ZpxkO/Q1SlqxMCwDhPAHI6AV5IZxileImAkMU5t2iRM5GA/Ag44juz+d3iJha9pN/PN8R879WIqisuU4/gRkfoDWpyLKAnuUrlCvEhxtFkubpzpycxvZZPQNMTF1kAvpTLMZg8ruo2iQgtB+W4ymX7an+LOxT927yf1moibPOiDAWCc35e40f9rSjrvKse293LtKkfoOvZe4LqCTuF1+KaXs9PkDqOcDLVht49DPQpm1yVMzw50W4zA8gEXhipihWO6kRB8GU94layyy30DylE23aml46WW3u7Ba34+wfGae90jyfi09Wt+TkSwj+hQMJCXhTFAxa5X4DEBL5eT/m14SxAc0vRY8OxhUKnU00RYMIPN4Ni5Vka7ENgJFzuNkj8DdkgGaiFgNFi3EnFve4XsONTBHwllfOix7vi/8eYB6iEP7XrqfcXMzPWLeKvF39coX8wLdD+NKoSa1Whqa2EwOiwLRM81ORMSf0kptaP7rP2uiRsc8r38TawRXCI3bbAGNzQp17TrYuUQ/WHApNZ9Jkr/VZJ7XUPoEvhP0e9aqQz0rvmVaSxoaTcsrOn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c916e94-38ca-451a-3095-08dcc052d419
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 13:28:35.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+yLgDTgtqkqMz7Kz7Adp6Cws4ooJkJROwOAAmI8G7uf9BMiEVZTl5uHAlQXuRvdovQOSrgH+dvdiAHkbjeFfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408190089
X-Proofpoint-ORIG-GUID: aUO_ZqULPMYmvYeKveli3rBPTpzGgDm2
X-Proofpoint-GUID: aUO_ZqULPMYmvYeKveli3rBPTpzGgDm2

DQoNCj4gT24gQXVnIDE5LCAyMDI0LCBhdCA5OjI24oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyMDI0LTA4LTE5IGF0IDEzOjIxICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+PiBPbiBBdWcgMTksIDIwMjQsIGF0
IDc6NDTigK9BTSwgSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4g
DQo+Pj4gT24gTW9uLCAyMDI0LTA4LTE5IGF0IDEwOjA0ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6
DQo+Pj4+IE9uIEZyaSwgMTYgQXVnIDIwMjQsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4+PiANCj4+
Pj4+ICsvLyBHZW5lcmF0ZWQgYnkgbGt4ZHJnZW4sIHdpdGggaGFuZC1lZGl0cy4NCj4+Pj4gDQo+
Pj4+IEkgKnJlYWxseSogZG9uJ3QgbGlrZSBoYXZpbmcgY29kZSBpbiB0aGUga2VybmVsIHRoYXQg
aXMgcGFydGx5DQo+Pj4+IHRvb2wtZ2VuZXJhdGVkIGFuZCBwYXJ0bHkgaHVtYW4tZ2VuZXJhdGVk
LCBhbmQgd2hlcmUgdGhlIGJvdW5kYXJ5IGlzbid0DQo+Pj4+IG9idmlvdXMgKGxpa2Ugc2VwYXJh
dGUgZmlsZXMpLg0KPj4+PiANCj4+Pj4gSWYgd2UgY2Fubm90IHVzZSB0b29sLWdlbmVyYXRlZCBj
b2RlIGFzLWlzLCB0aGVuIGxldCdzIGZpeCB0aGUgdG9vbC4NCj4+Pj4gSWYgd2UgY2Fubm90IGZp
eCB0aGUgdG9vbCwgdGhlbiBpbmNsdWRlIHRoZSByYXcgb3V0cHV0IGFuZCBhDQo+Pj4+IGh1bWFu
LWdlbmVyYXRlZCBwYXRjaCB3aGljaCB0aGUgbWFrZWZpbGUgY29tYmluZXMuDQo+Pj4+IA0KPj4+
PiBJZGVhbGx5IHRoZSB0b29sIHNob3VsZCBiZSBpbiB0b29scy8sIHRoZSAueCBmaWxlIHNob3Vs
ZCBiZSBpbiBmcy9uZnNkLw0KPj4+PiBhbmQgdGhlIG1ha2VmaWxlIHNob3VsZCBhcHBseSB0aGUg
b25lIHRvIHRoZSBvdGhlci4gIFdlIGFyZSBnb2luZyB0bw0KPj4+PiB3YW50IHRvIGRvIHRoYXQg
ZXZlbnR1YWxseSBhbmQgSSB0aGluayBpdCBzaG91bGQgYmUgcHJpb3JpdHkuICBUaGUgdG9vbA0K
Pj4+PiBkb2Vzbid0IGhhdmUgdG8gYmUgYnVnLWZyZWUgYmVmb3JlIGl0IGxhbmRzIChub3RoaW5n
IGlzKS4NCj4+Pj4gDQo+Pj4+IEEgcGFydGljdWxhciByZWFzb24gZm9yIHRoaXMgaXMgdGhhdCBJ
IGNhbm5vdCByZXZpZXcgdG9vbC1nZW5lcmF0ZWQNCj4+Pj4gaGFuZC1lZGl0dGVkIGNvZGUuICBJ
dCBpcyB0b28gbm9pc3kgYW5kIEkgZG9uJ3Qga25vdyB3aGljaCBwYXJ0cyBhcmUNCj4+Pj4gd29y
dGggY2xvc2VyIGluc3BlY3Rpb24gZXRjLg0KPj4+IA0KPj4+IEZhaXIgcG9pbnQuIENodWNrIG1h
ZGUgc29tZSBzaW1pbGFyIGNvbW1lbnRzIHRvIG1lIHByaXZhdGVseSwgYW5kIGl0DQo+Pj4gbG9v
a3MgbGlrZSBoZSBoYXMgdXBkYXRlZCBoaXMgeGRyZ2VuIHRvb2wgYXMgd2VsbC4NCj4+PiANCj4+
PiBJJ2xsIHBsYW4gdG8ganVzdCByZXNwaW4gdGhhdCBwYXJ0IGZyb20gc2NyYXRjaCBhbmQgcmVn
ZW5lcmF0ZSBmcm9tIHRoZQ0KPj4+IC54IGZpbGVzLiBJJ2xsIGFsc28ga2VlcCBteSBoYW5kLWVk
aXRzIGluIGEgc2VwYXJhdGUgY29tbWl0IGZvciB0aGUNCj4+PiBuZXh0IHZlcnNpb24uDQo+Pj4g
DQo+Pj4gSXQnbGwgcHJvYmFibHkgdGFrZSBtZSBhIGZldyBkYXlzLCBidXQgSSdsbCB0cnkgdG8g
aGF2ZSBzb21ldGhpbmcgdG8NCj4+PiByZXNlbmQgd2l0aGluIHRoZSBuZXh0IHdlZWsgb3Igc28u
DQo+PiANCj4+IE1lYW53aGlsZSwgSSdsbCBwb3N0IHRoZSBjdXJyZW50IHhkcmdlbiB0b29sIGZv
ciByZXZpZXcuIEl0DQo+PiBhbHJlYWR5IGxpdmVzIHVuZGVyIHRvb2xzLyBhcyBOZWlsIHN1Z2dl
c3RlZCBhYm92ZS4NCj4+IA0KPj4gSSdtIGhvcGluZyB0aGF0IGJ5IHByb3ZpZGluZyB0aGUgLngg
c25pcHBldCB1c2VkIHRvIGdlbmVyYXRlIHRoZQ0KPj4gc291cmNlLCBhbmQgYnkgYWRkaW5nIG9u
ZSBvciB0d28gInByYWdtYSIgYW5ub3RhdGlvbnMgdG8gdGhlIHRvb2wNCj4+IHRvIGhhbmRsZSBj
ZXJ0YWluIGV4Y2VwdGlvbnMsIG5vIGhhbmQtZWRpdHMgb3IgZXh0cmEgcGF0Y2hpbmcNCj4+IHdp
bGwgYmUgbmVlZGVkLg0KPj4gDQo+PiANCj4gDQo+IEknbSBwbGF5aW5nIHdpdGggdGhlIG5ldyB2
ZXJzaW9uIG5vdyBhbmQgaXQgc2VlbXMgdG8gYmUgbXVjaCBpbXByb3ZlZC4NCj4gT25seSB0d28g
cmVhbCBidWdzIEkndmUgaGl0IGF0IHRoaXMgcG9pbnQ6DQo+IA0KPiAxLyBTb21lIG9mIHRoZSBz
dHJ1Y3Qgc3BlY2lmaWNhdGlvbnMgbmVlZCB0byBiZSB0eXBlZGVmcyBhcyB3ZWxsLiBGb3INCj4g
aW5zdGFuY2UsIHRoZSBkZWxzdGlkIGRyYWZ0IHJlZmVycyB0byAibmZzdGltZTQiLCBidXQgdGhl
IGF1dG9nZW5lcmF0ZWQNCj4gc3RydWN0IGRlZmluaXRpb24gZG9lc24ndCBoYXZlIHRoZSB0eXBl
ZGVmIGZvciBpdC4gSXQgbWF5IGJlIGJlc3QgdG8NCj4ganVzdCBhZGQgdHlwZWRlZnMgZm9yIGFs
bCBvZiB0aGVzZSBzb3J0cyBvZiBzdHJ1Y3RzLg0KPiANCj4gMi8geGRyZ2VuX2VuY29kZV9uZnN0
aW1lNCB3YW50IGEgcG9pbnRlciB0byB0aGUgbmZzdGltZTQsIGJ1dCB0aGUNCj4gYXV0b2dlbmVy
YXRlZCBjb2RlIGZvciB4ZHJnZW5fZW5jb2RlX2ZhdHRyNF90aW1lX2RlbGVnX2FjY2VzcyBhbmQN
Cj4geGRyZ2VuX2VuY29kZV9mYXR0cjRfdGltZV9kZWxlZ19tb2RpZnkgdHJ5IHRvIHBhc3MgaXQg
YnkgdmFsdWUgaW5zdGVhZC4NCj4gDQo+IFRoZXNlIGFyZSBtaW5vciBhbmQgZWFzaWx5IGZpeGVk
LCBvYnZpb3VzbHksIGJ1dCBpdCB3b3VsZCBiZSBuaWNlIHRvDQo+IG5vdCBuZWVkIHRvIGRvIHRo
YXQuDQoNClRoYXQgbWlnaHQgYmUgYSBidWcgaW4gdGhlIHNwZWMsIGFjdHVhbGx5LiBJJ2xsIGhh
dmUgYSBsb29rLg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

