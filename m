Return-Path: <linux-nfs+bounces-1171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6BB82FEFD
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 03:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD8FB24F3D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 02:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D17465;
	Wed, 17 Jan 2024 02:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y0RgTMTo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GtBEiInA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7E7491
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jan 2024 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460055; cv=fail; b=MjY/fxiF8YPKm8iapjZm03uxZ0YY02ru06TwH3BjR6CR71HW0+UbtTNKnvW4ad60f9uXs0qr6HSx9TsWgq3cZUBKC1wN+4FtwzJkHWEzqFJVc5VxOA7xatRcHvQURByqFP0zlWXmvMPVLGP36bEtkAN/KnsgMRbAnZ6W3U350Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460055; c=relaxed/simple;
	bh=sFk+bD4KAYPx8m53t2F07u5RyY9SkRf5gOhGsEs7u8Q=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:x-mailer:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID; b=KFi0fpCiluZtzJHfL5CWhSxT/0EBOGG6jH8LWTdz7xJSKCxvCMafDQ6FX097sQ0Tp9w+381e98wNa+yQ3Px09gpZmv2DqkNxYKnZySjCvu24JmyzRttD6Rb1MhAgAeSgBgFdjFiW/sMIMJBIj0WDT+MzQFsDPgeVEGrnWZCAKaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y0RgTMTo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GtBEiInA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40H1NuNP016438;
	Wed, 17 Jan 2024 02:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=sFk+bD4KAYPx8m53t2F07u5RyY9SkRf5gOhGsEs7u8Q=;
 b=Y0RgTMTo44kWSDXOZqEGLVb+9n548bP+tjLmsk2T1T1AhBQHJROH5SlSftuovZiAxD5H
 FInIHZSRHsidjweBxM0BniLfWZ573I0Xp+oOrspApui0dh3nQCA4nCsMBwlmFxD+lzDA
 sF9fXsf0L30Zpy/zTm+ZDOWptF7Kdx95dUyc+ZDMFsz37XvVhT5qT7PX1S5DDWkqUpY9
 MfZWH3+xK/j3alLgkCnn1TVcHcRID5qiH3zJbHE4I6rUbwUoJrp1sPFeSUiUqkOalpjM
 N9Wx4S8jrY3CPRRun2O6/OZqfSpzA6AHTN2XSDq/STP8LZdqD6JmPS3Xk/LUqP9jaLtv gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjjeepke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 02:54:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40H1kGCE023192;
	Wed, 17 Jan 2024 02:54:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy9admm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 02:54:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O//E1ZFKOXfTooEured9gCL6dqrJ8DKzfcpDfnoW3LNsJjM42daX/7YwCVqGJtv5Mr0XRKCl04pRXAhBQnNe5llXzXAKCOStMGnltep1x7XVL/2ZUV/86szoxmwylMso6k/KLCyCJ3TKrbGSmuRy+SCIyMgNWi33p+UkVz9DvEUxDjh7Tx57M1jfaeDSzMSkRfgRK0D+0ppcVnRraJUf2RjSJMHgG7ATySMLnQP6RDYfYnSVTBj/u/t8BP7tFRyWN8KfBjy1trTSMJfeuyKZ1L4Yx3e3TQs/Wr3J4aPm6AUe54Q4jKRaBhVkrGedV1205dS5h9ZURWextlJ+osmMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFk+bD4KAYPx8m53t2F07u5RyY9SkRf5gOhGsEs7u8Q=;
 b=MO2LURLXQIRHt7Qmv8bMmp4Nli+/s9Y1bc99hdVeeQN8X3plgoM6MJXImvwJotrkpuGT9aNgtDRBzBR7/7C6zXUEF7ciGQWVMyjauemAYYdD0Kps8gyL5ZYAE9OHjgc22ztyjLdO3NIna8GorLGK5nSg9+Fm3WSV1RRYkA5hvo6/57FuWL3/inqywRrYcdjjUZSqPaSlZNIxx1vxEyDfWcguFIUnY/rFsu0lAlB0SKqlvkUJXHDZbjG3mrVO111G06LiHmi5ojm+TVpB7pT1JkPrHaUVSppZpMjXjB/Bvk7+m1alWGaM6MAnBwT/gixtD6g+c2mCLe7Bll4X6w1rCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFk+bD4KAYPx8m53t2F07u5RyY9SkRf5gOhGsEs7u8Q=;
 b=GtBEiInAiHFjTgIcbx5MB8m8XUbNU3ObAyRRz8O9rsMGIFlp6+R3xcpkMFkeEVpPHVoDHU4XI99jDanXUuhJr67BC6YyRPUbB/1RYsgadj0+3zkYY7xS0vG8fx2MQimXUMSxlLGk+MA/s3LeY3oucb+wZBoEOT18RBJbJL45BbA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5904.namprd10.prod.outlook.com (2603:10b6:8:84::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.26; Wed, 17 Jan 2024 02:54:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f%5]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 02:54:08 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsv4: Add support for the birth time attribute
Thread-Topic: [PATCH] nfsv4: Add support for the birth time attribute
Thread-Index: AQHaR31Cz2V9CqEb6UGW6ZcWCZJOpLDboD0AgAALfgCAATdZgIAAbsWA
Date: Wed, 17 Jan 2024 02:54:07 +0000
Message-ID: <0A8A7C46-F59D-4635-A4A9-55D297A9D01C@oracle.com>
References: <20240115063605.2064-1-chenhx.fnst@fujitsu.com>
 <CAAvCNcDxZF-ftqb1dRnjUW-q-1m2kyqN-MAGNXUd+i1r_b_vSQ@mail.gmail.com>
 <0CDB9C6D-5BC7-4E99-8B08-825424D0DD4F@oracle.com>
 <CAAvCNcCZ=uGxUN=9ztF6iOPsxdYUDYc2JeRrZxC4XPYOPW22uw@mail.gmail.com>
In-Reply-To: 
 <CAAvCNcCZ=uGxUN=9ztF6iOPsxdYUDYc2JeRrZxC4XPYOPW22uw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5904:EE_
x-ms-office365-filtering-correlation-id: e15be46f-d80f-4e26-1bdc-08dc17079323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BM6HfUxaJDDdVdylj9jy5ZTaAtwttpLEab2E6rPGLskLJpCkGNleWKsrJ6mfRz2trWxnD4pmCNnUqzkb++MPZqFXTN+pUED4VAZ/dmXnoh8TS/cK4a2baoaedGegIJhUzZKS7/j8g9WvSoJoz+sIlQ0O0Rb3lijZQ84/l0guaIlO17Q2X1q118b2IXUz/odsn0Lcuqq/g6vT0GIBz7CPxYyAh6igkhQgFMursoHNzcjgQ4EJU8RN3Hqv1YUQ4tLYS+VLNBm73efFKUDr19v+MXLz1I905HeqeX+zNip2q+fVzdcrIJowkVHPLIO6wCJ1v7U02ZuSF08RW0lDZH6tSpa0OWbcI707jR0A8lZTBOKRg76cxz3kCODwtMKHnm5hNneHHc745Rnl+ZY4+koSp9wwGcTeBqE3Y6nUfEFuN2ckI6EtlxFouOixbfNNSB2TZphZHWpMh9BCRCVFX9V+xMri3/8JtNj7DQyozAAa7igQ5fmAmheUdCayaNqFcmSW8T1qhWaimpjo1PSWkLMrldQ1IYT/cR5U0nA/j8tA8qUVclSi/ANxRU5NuyNBtfRxWbmNkiFisbMh/oU4i924dyCibeOfG2Vwx6oENt7P5UfR680C2ZHrg5bVO8GSpPTSGGmrvi3c2/G3g7W5G8AsHg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(4326008)(8676002)(478600001)(6486002)(36756003)(6506007)(33656002)(91956017)(316002)(66476007)(6916009)(66946007)(26005)(41300700001)(64756008)(83380400001)(2616005)(66446008)(53546011)(66556008)(86362001)(38100700002)(76116006)(122000001)(71200400001)(8936002)(6512007)(38070700009)(2906002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UEtERXZBTmZTbjNRcjdwVlhCQ3hhak9JK2ZFL1FodU40WmZHV1ZnbEJ4NmFS?=
 =?utf-8?B?cCtxbFRJMUlDWktBK3hqN21wSENWOTNHclFCc2FwbjNCYUdJcm9sVUFvTzl6?=
 =?utf-8?B?Qmw2SUZHTTE1Z2dpbVkyQmUyclY2QXNXTUhHNDE4SVE4ZzVBRWlRbnVCMlNv?=
 =?utf-8?B?M0gwRC96K05iYkNrNURWY3RVL2NvQVcvMHBjYkF4MTlGVUF1aEJ0TWFja0Vw?=
 =?utf-8?B?cktXR25pUWlLYzFabVhNR1FpWHBwSVlEQUFVZHBmajhWeHhVOGlmMThFNEJQ?=
 =?utf-8?B?aHZ3Qkowb0RPUlJoYlhSdlVwd1hmdEVPUUN6YVNHdFBkckNWR3VMd3pNcGZj?=
 =?utf-8?B?Sm5BMUM3MktLa05DUnlFSis5eXFXNWx0bVp4TVVncUFDTHNSNGRvT1pyNnNG?=
 =?utf-8?B?bkRDcGtYbm5YSVNxb1lTTElWc2VnNzZpbTRRbVliT2N3Vm5KNWd2TVdkUmN1?=
 =?utf-8?B?OUNpaG1LZ3JwU2wzZ2lXVDhIUmpoT0VMODVzY2xBNi9EdWZvNThNYm5vNDZh?=
 =?utf-8?B?MDFqNHM5Zkt0WSthOUdrL0VmMFdUV3pxVVROWSs4cUFpVzBueVp4SUtEWnhR?=
 =?utf-8?B?aGtuUk9tVmVURDdhVitndEoyTDZNZ0M0MkI5cVQ2ZjJLd2oxUFlxUm5GU1pa?=
 =?utf-8?B?b1ZRbEhrbXFBM1Rwd3lTQUc5MmthZGJ0Rk4zNGxJZXo2S2xqQXQxRCtLODVF?=
 =?utf-8?B?elg2ZWk2MkJndXdtWDNQN0IyaTF1MFZoTHFBeGlhVG1VWDZ5TlhiYzkwQ2tM?=
 =?utf-8?B?QXlmRFNDNHBvQVB6N2xIVlM5VnpBNXR2OWVRVk1KZkNwM2krUEJvSnVKUU8z?=
 =?utf-8?B?T0FXenZjWHJ1bk9wMWdNS0RtRjk3L1Rwd0NLd2JzanUzRXNWZmpaS2dMbXZ5?=
 =?utf-8?B?T0FZQVpTZmFnaVYvQkgrNjQwYWxuamJDSHdocnRFWE9aSUJLWC9rb1lSbmV6?=
 =?utf-8?B?VEw4eExpMm1LVm80cm9BdEI5a2p1RFVKYjNKV2FoT2RURVlRTEhhcSt6ZVc0?=
 =?utf-8?B?Q3RnQUFWSUR6emJ5RjNJeGZhUDJlRmEvY2J1b0hTQmVobVVMVkpkbktYUDla?=
 =?utf-8?B?ZVY0S05YUUZPb3o1TmFxMmJDUUdtVHU2WHZMdk9DK01teEhHT0pKbnY3TUc2?=
 =?utf-8?B?SVNKWVpaRlppeDU2M1VsMCt2cGNoZjZJREY4cVFyaytrMzFtMmgxb2dWR1dR?=
 =?utf-8?B?OVBkKzcrUUl6Q3JtMW14TFprSitpUWZmVkM5L1RIZ2pVK0VnTkJKckIycERv?=
 =?utf-8?B?T1dIOHIvalB5a1A0R2xrdlMycjlrK29XbVNLZDVqU3ZjUmMvVHJncnBUYmx0?=
 =?utf-8?B?ZUFXd0ZoY1lqYXFsNWlDU1JLbTVadmM3SER5cEhDei9BR0FaV3ZNQUNoZTJU?=
 =?utf-8?B?eXpIV05xbWlpcjJMeExoT2xkajVGQTRQZTBuL0xpMGhIb2xVcjloaTZSUWla?=
 =?utf-8?B?czdPNUlkRDlyb2tSeWR1UjV6WmNiZUUzTXRNTU52bitpS2xWUGpWdFExSnE4?=
 =?utf-8?B?MUZ6N3lKL3ZMeTcyVkRtQlpMZEZhVUc2N2dtdEJ1eTl0djNlZ0FDbkVRUWdu?=
 =?utf-8?B?cDBKejdqVHBESkxHM1lGdHZrWGFiMTViQjlyYXlqNHFQcTd1V0tBb1R4cmNN?=
 =?utf-8?B?WHEraDZzUS9qVExtSjdPNXB6VmR5d1QwcVlhM1Y3dFBueXBtNXhheFdqWVVU?=
 =?utf-8?B?WlNUd1VONWU1Q25RODhqdlFzOGhDTUJZVUgzY2twODlub1hWZEltbHNSL0Rs?=
 =?utf-8?B?dlRPMmgrZlBNMHpVOHVKRGdmTVV6Q0JlL2hTWHg1NS9yZjdTQXdOQ0VCcG4z?=
 =?utf-8?B?bzF6S1p3Y2NjWVJqZUxDV21oVGI0T3VCVlo2V1VHRVNXTHQrU0lsOXphbmtO?=
 =?utf-8?B?S3pVMEN5bnJGMGxCeXo2UXM2RmdMYVZTZUxEbHZnLzhGL3RUVzVUVDhseVhK?=
 =?utf-8?B?bjhGUVdObzVSZForRmNlTUsvcDR1bStnL1lsNUNLQWs4M2JSYUpIRHRmcytH?=
 =?utf-8?B?NmVnVjFEb3hXdnJLaThsQXJvcUd2Y1pmckJWZWgxWEZVNVVPN3hPQ0JUZlpv?=
 =?utf-8?B?eWkzcHhUajVvMGdZbzQ2eGR2L1Q4d3hYZ2NrMFFnMEZjUHNSL3BEeTRUcm82?=
 =?utf-8?B?ZUxzeE5sNWVwR0tVQzExcE9rM3Bxd2pRMGFWMzFXdElRYWpJQytmanNtdEMy?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C5DF903CB56F44085AF19E966E4B5CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oqkJP6fOabbn1vhJaVTrgtNSSBq4FhfZk6IZv7IXQcK6kmT0v2fO1wad5klp87cN+xSMxtdMcYs4fUm+6oMB4Xs/Re/2hPuAgN5odgTkWrxPEI4XZJlt07aRBj50kEr1Hwx1T5wbCerpnXhrVUG5il4dl1cZoFVGFupm89LhPoUt3Oe9bBTYhpdt2Ch97ZflEfaZJtVCwcTukt/wypCFFIrKFYGSN7Tq1xSj6dBiC6mVDG/Srf34ayZ2gphmvFRUh4T63hJK+ATlpSv/Sp4ig73rpAMWffEeIhGC88VphG8PEY/smCQbFEyRS+QpN5bhtNuahhLQUPe3reWCvg/MMobJCjutI01kJydcpi3vAN5L9NWy7G+21EBaFiSPsD4LLtAsT7gI5h9wGzxBpBL1Y7MKEWD05Yu0CCYhYX8Vfj66tW/ZhHYMSLfOSR0j6K7iD7mmTQuzjGWbkYt4OseBQGBlaXE43m0W08ae6EGksSHh0iQTeGqYQGiDH0qhbtKJbs81sysmIZV/tf4bYqu5RWGYKk3wFiqXhJq2/MhorV65uY0vLyu7e6cToR4+NHSKtr/ObY4DxXVR3+E0j8qx6M4XPkS1zDI7CuJQP3kyhUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15be46f-d80f-4e26-1bdc-08dc17079323
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 02:54:08.0068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGBSo7w4/oV4OKWTqxPvg/QV4sCS7pCWm+ImVNSvBW8PyTDCE3Ao5tlfeXKZfUp4LH5txnUmZ4GEi6k0B+/Ctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170019
X-Proofpoint-ORIG-GUID: MEK0_HNOUWogIYukck-CXfpN5oPElF60
X-Proofpoint-GUID: MEK0_HNOUWogIYukck-CXfpN5oPElF60

DQo+IE9uIEphbiAxNiwgMjAyNCwgYXQgMzoxN+KAr1BNLCBEYW4gU2hlbHRvbiA8ZGFuLmYuc2hl
bHRvbkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAxNiBKYW4gMjAyNCBhdCAwMjo0
MywgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0K
Pj4+IE9uIEphbiAxNSwgMjAyNCwgYXQgODowMuKAr1BNLCBEYW4gU2hlbHRvbiA8ZGFuLmYuc2hl
bHRvbkBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIE1vbiwgMTUgSmFuIDIwMjQgYXQg
MDc6MzcsIENoZW4gSGFueGlhbyA8Y2hlbmh4LmZuc3RAZnVqaXRzdS5jb20+IHdyb3RlOg0KPj4+
PiANCj4+Pj4gVGhpcyBwYXRjaCBlbmFibGUgbmZzIHRvIHJlcG9ydCBidGltZSBpbiBuZnNfZ2V0
YXR0ci4NCj4+Pj4gSWYgdW5kZXJseWluZyBmaWxlc3lzdGVtIHN1cHBvcnRzICJidGltZSIgdGlt
ZXN0YW1wLA0KPj4+PiBzdGF0eCB3aWxsIHJlcG9ydCBidGltZSBmb3IgU1RBVFhfQlRJTUUuDQo+
Pj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIEhhbnhpYW8gPGNoZW5oeC5mbnN0QGZ1aml0
c3UuY29tPg0KPj4+PiAtLS0NCj4+Pj4gdjE6DQo+Pj4+ICAgRG9uJ3QgcmV2YWxpZGF0ZSBidGlt
ZSBhdHRyaWJ1dGUNCj4+Pj4gDQo+Pj4+IFJGQyB2MjoNCj4+Pj4gICBwcm9wZXJseSBzZXQgY2Fj
aGUgdmFsaWRpdHkNCj4+Pj4gDQo+Pj4+IGZzL25mcy9pbm9kZS5jICAgICAgICAgIHwgMjMgKysr
KysrKysrKysrKysrKysrKystLS0NCj4+Pj4gZnMvbmZzL25mczRwcm9jLmMgICAgICAgfCAgMyAr
KysNCj4+Pj4gZnMvbmZzL25mczR4ZHIuYyAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKysr
KysrKw0KPj4+PiBpbmNsdWRlL2xpbnV4L25mc19mcy5oICB8ICAyICsrDQo+Pj4+IGluY2x1ZGUv
bGludXgvbmZzX3hkci5oIHwgIDUgKysrKy0NCj4+Pj4gNSBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKSMNCj4+PiANCj4+PiBIZWxsbw0KPj4+IA0KPj4+IFdo
ZXJlIGlzIHRoZSBwYXRjaCB3aGljaCBhZGRzIHN1cHBvcnQgZm9yIGJ0aW1lIHRvIG5mc2Q/DQo+
PiANCj4+IFN1cHBvcnQgZm9yIHRoZSBiaXJ0aCB0aW1lIGF0dHJpYnV0ZSB3YXMgYWRkZWQgdG8g
TkZTRCB0d28geWVhcnMNCj4+IGFnbyBieSBjb21taXQgZTM3N2EzZTY5OGZiICgibmZzZDogQWRk
IHN1cHBvcnQgZm9yIHRoZSBiaXJ0aA0KPj4gdGltZSBhdHRyaWJ1dGUiKS4NCj4gDQo+IFdoaWNo
IExpbnV4IHZlcnNpb25zICh0cnVuaywgTFRTLCBSVCkgaGF2ZSB0aGF0IGNvbW1pdD8NCg0KZTM3
N2EzZTY5OGZiIHdhcyBtZXJnZWQgaW4gdjUuMTguIFlvdSdsbCBhbHNvIG5lZWQgdGhlc2UgdHdv
IGZpeGVzOg0KDQo1YjJmM2UwNzc3ZGEgKCJORlNEOiBEZWNvZGUgTkZTdjQgYmlydGggdGltZSBh
dHRyaWJ1dGUiKSAodjUuMTkpDQpkN2RiZWQ0NTdjMmUgKCJuZnNkOiBGaXggY3JlYXRpb24gdGlt
ZSBzZXJpYWxpemF0aW9uIG9yZGVyIikgKHY2LjUpDQoNCkFsbCB0aHJlZSBvZiB0aG9zZSBjb21t
aXRzIHNob3VsZCBiZSBpbjoNCg0KdHJ1bms6IHY2LjUsIHY2LjYsIGFuZCB2Ni43DQpzdGFibGUv
TFRTOiBvcmlnaW4vbGludXgtNi42LnkNCg0KSSBkb24ndCBrbm93IHdoaWNoIGxvY2FsIGZpbGUg
c3lzdGVtcyBzdXBwb3J0IGJpcnRoIHRpbWUuIEkgdGhpbmsNCm1heWJlIGV4dDQgYW5kIHhmcyBk
bz8NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

