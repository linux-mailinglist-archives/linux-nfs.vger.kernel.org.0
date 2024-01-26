Return-Path: <linux-nfs+bounces-1462-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B883DB46
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 14:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3CBB26464
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4DA1C684;
	Fri, 26 Jan 2024 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bbmf3hXp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rtk01PYW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AD1CD11
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277373; cv=fail; b=Rw1iB0FjbAYc+Qkoygy3iDAeKj2TxudsLoHleBfe//rfhRFke7KVcdI+vhEZ3uzKXJGsgZ71gJ01W19vZ5rc/MS/8ut0kR+8wLBbzBEb6cD9FcmN2Z3PTw7D1aj+w0HdtIL7XOBrGsvGrJwxrZnV0ni9sgSEnwDkp3ycS0JvCLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277373; c=relaxed/simple;
	bh=XR+kRTYohtZuR/qUHXOorC0NC8y1gdPe8JjL21/X1rU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tdCtUbek2j6N/ls8AT2hgoBVndvJB90z6PnOCTxBHX0C1mToJqy0wNiZtMqi+z+Fk3wqVTy2dR1n+Ny/5gyDMQupxGaLvn4J3AwGY9mJl4UZhHpxf84P6Yh8ZHvgk4LlkVH1a5a2wf1ptA+2NrAyP8Vp/6Hn76hKlYyjiFYp5fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bbmf3hXp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rtk01PYW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QD5fWq029409;
	Fri, 26 Jan 2024 13:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XR+kRTYohtZuR/qUHXOorC0NC8y1gdPe8JjL21/X1rU=;
 b=Bbmf3hXpDTjTLFMbRF4hu6hpj4/9vyB0YueEUYOcjvV5cfddyyjVBb0bMINYnpHg/+MU
 WfjFaeEIwBVzKTTdeQ509UZdCUsaJXVCKyVfBEuRgvhiX9bOC3/1JL6y5s0+k1dtu8GI
 eeT94i5kr6nZSCbE9I4XfzVQwDtYXytQtZ8BzCfYVnDB2UZkFczpEP/P5UvieRuQxJT5
 tq5S+jMKVrRGqSAzS22h/hFHQNZTJ/BrO6TKdn+sdW7qzuRkKJ0unMw3wlpjFXlUgb1w
 prQwSI8gaXfknBcDaZ7PdMvVM8EHOn9pvEYzA2rMWuRrWrctsy/0WPLdFLY9EtGGuLXB 6g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79ntc5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 13:56:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QCmMmW029531;
	Fri, 26 Jan 2024 13:56:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33y8x8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 13:56:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS47GZpkLjrvtRsfOfHatLiDHoZhBO0AteOjWZfN3IcLRfL/kB452fxBWa77mYw4DSwhzKzsnufmeo0slNeZRauFvzkRc4gmFOlrfHRkw9jWe3k1Y12vaIPczUBzPPGTF8DfSmVpkAkfnMjX55ubuVfzjHppMNaqWQc9lciP2uchUFdbH7ERJMvaq23lEhpIUHdVPLE1SU58kjgY4tDK8N2ZT/zBQ589NCZamGCik1ZJ6iiVWU2ButtCz5EFQG00UzfeuXGgJaghFwQ3Q4+gOD9ToyHz8Ap8z3r4tPWSfqYm8tE0tClq0eDldQFnvQhMoBBa4MqtUdpQFix4VQmKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR+kRTYohtZuR/qUHXOorC0NC8y1gdPe8JjL21/X1rU=;
 b=O/sX43EhEpPfQYRw52lKKhMEZUfejcWSNxwQk57AUI8RRUIfNAJPoAEDSGIrZ/qsd4RLk/QYjxVEslLpb+DnZvVCgFTnpf+UxRd/bPop77APa3bFTtSK+QDrmBs9nZ5DHVm51hFbtCf7eSe31GdwuE3tOaxZ11MAhgFraKaUA2nHq9ER6OXc/PPp1lSYE2Rju1x48ax++tsrECvRI7eH7uMOclXuSUrjeW89d+pAUGDPd0x6Nb6yXz5LUyWlIYmchrj2HxLPRautY+sYvkN7qeSPC7BnYqY2Ic4QVak96Q4eKPRFZ0N0lkmHblDMHEy5tnp5JLIJ/3ZT4ZXDrh6ZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR+kRTYohtZuR/qUHXOorC0NC8y1gdPe8JjL21/X1rU=;
 b=Rtk01PYWYi2xWuesujNs/e6CjX67HV/s/IJ9ft+idKjgJ6Lq3SuuVh0GAMExqCecDa3+W3VORjuRtWSuHzRNzBVrp4cGe8tmsNPB3urv1HYJV4TSFJXMo1VLfyoLZ+FDmtD1Lr5+HLO3nrSq+FlbImz2R3ZrynVQekWIzzKrZ/o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5366.namprd10.prod.outlook.com (2603:10b6:408:12b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 13:56:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 13:56:01 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 00/13] NFSD backchannel fixes
Thread-Topic: [PATCH RFC 00/13] NFSD backchannel fixes
Thread-Index: AQHaT6uNhpjMaVIjgUuiShZ8ML+4urDrFvuAgAEIawA=
Date: Fri, 26 Jan 2024 13:56:00 +0000
Message-ID: <185A3262-97EE-4637-A169-05F01B7FFBA4@oracle.com>
References: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
 <0DCE1190-19FA-46BD-822D-6984F0B5B296@redhat.com>
In-Reply-To: <0DCE1190-19FA-46BD-822D-6984F0B5B296@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5366:EE_
x-ms-office365-filtering-correlation-id: 7b01ac87-8990-4879-0131-08dc1e7687a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CW3zo9E/LQaPMwVNEFr4YIg3EXqnQ79/td0bezXu1zboo6r96pOvehL03TxeKnqOqDPcZzdwuGdJ2xio3byS6jpcqIJMA7vi1GN2cudPOKGdHP/ixcNcLY9e+63lHg+ZXTUmb4XsbCO5CW1xblE60El1QKhB+BWR0EUIs1FYr5vGYg8jddYV6v7OkyLNJriwEKY3ziWpn8YNniB7sxq4Pssbcg8VGlMIsN6x3nzYhhAPDwixUgsI+mJt8cPK/VzuQJOVJS/qabwiKDQ386xa3tAh0oo4d/R4DMPKbR7RgQ64SW5PdjhvUvva1Ob0X/K/Tk29V/Tw9I6b9Jrza06FQkEh0OHOng7JtqhCSgBSyH1dsmYZfWmw5Trk4qdfKRaj2G0VWRiXz0FEjVSBu2LllLau6kDBvaCNVUvb6gUa+2qQOQyV9OIXIMgbL6oO4b22JPavQRS/u4IGIVe2O8YXXQGIoDr8lN9AclldeKQ7UI4/2Z7tQTqERyHw5y+aYV57olmyOqS9vv2V3yX3e7dnxNZ0lN343pKVXCx/c1w+Ox0oRGGkXwed0PYsQXwsZ6JFBc5oNuY2GaDfOKhlyJ3QTzqmtGsKKQ/zAnn2Mn02aQh1F9weOfW1jpshnh6LKIpPavatmUUOENOic5uWKnrnMw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(8936002)(33656002)(54906003)(5660300002)(4326008)(64756008)(6486002)(6916009)(316002)(91956017)(66946007)(66556008)(76116006)(2906002)(38070700009)(66476007)(36756003)(478600001)(83380400001)(122000001)(66446008)(38100700002)(6512007)(71200400001)(26005)(53546011)(86362001)(6506007)(2616005)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UlBoU01QS05tNG05OUZPdmJCWUdoODZnTDUyWkVlYkE2YjhOMkRReEw3d3lI?=
 =?utf-8?B?M3VBL1R5ZndjT2xscTZKTjY0VGhld2xCUHBFSElDZm5VbjVYSW1nWW1IRHd5?=
 =?utf-8?B?b3A3TlE4RnFVNU1qSzVGTkR5b0t4a1VUYitFZlBuY3pOWjdhemMxU2FicUhK?=
 =?utf-8?B?MnI4SmQvTXlkdUt6VnNjRXhNSFUzTzNnMFZMVmZQZFJ3dmJDRWFQK3VKTm9I?=
 =?utf-8?B?N21hT2M4clo5OXBHUHV3YWpkeFgzZXQ5NzBkdHRkaXRlb3JMTzJFZkhiYXds?=
 =?utf-8?B?elJ5VWt3VjdZclhOenAxbXVvTGhRdHVKSG1QMDJmM1NqNGRkQU1NYXBqVWpZ?=
 =?utf-8?B?ZC9teDcvQVZpQy9MS3FyRFpHNXU5SXd3V3dXTzEyV0hYR2Y4eFhZU1NQTzE3?=
 =?utf-8?B?Rll4eFFJNmtueE5BbEY5bkJpZ3RmUUtRdlFxWWRQNFpSMDVxTzJaRjNncGY4?=
 =?utf-8?B?aThNcjh5bjBBR0NmOWRsTXBocWd1WEN1UXJrSFNXS1JlZWIyYnZ5UU5FTTFW?=
 =?utf-8?B?N0pDRTgyUnByREpxUVVBS1FwOFVNdHVDU1I4TnJqcHJaZ0M3T0x1Y3E1Umds?=
 =?utf-8?B?djAybkFmNjZOZzhSNm82Rk9SMnF4SzhPcGgrUFREVkVhOUZtcTNFK3c1MTBi?=
 =?utf-8?B?cWhPRXdCNTdnaEVOSnZKbnI3SmVjRGVqRjJxS3oveUNuTjRJQ3NxN3l2WVBv?=
 =?utf-8?B?OVZBR3FNbU11N0RuY0VyZDZjbWdHUzU5Sk1KRXZ6WC9QZktTM0YvZGtQRmVy?=
 =?utf-8?B?TTY2VTA1N2JuY09KalNyWGF2dVU5YmF4dzVraGx2YzBBUnAxcllTUm50U0d2?=
 =?utf-8?B?Ym12T05OaHk3YnNGLzBOVUt0SWIzUi9YMUF6VVQ0U1lRVlE5MEV5NlpEVVpV?=
 =?utf-8?B?VHBzUFZwN2FMOWFENFBYSERHKzJqMlROdnpka2FPcStTWHdNcXRRMVozcXVN?=
 =?utf-8?B?ZjZ0cXQ5WW93YVVvVllSeVpRdmovVjZ1Q2dZNzJUd1BjZHBiRVR0ZjZQd1dJ?=
 =?utf-8?B?T0xHMVB5bElwakdNZ3JFamhSV2tCY01IcUZQOVg0TGwvK2VxYTZtdzNBSUZi?=
 =?utf-8?B?M0M2U1Q2Z1lEYXRNSTFJSlhXQi9LMEVLMk1hYVl3V0tqWWMrUFBCZW4wMkgy?=
 =?utf-8?B?V1h1YXV0NTdrZ00zRVEwSE1Fc2Y4YXBZdmZaVk5zdGFZSnNLQjBEWkZiMVho?=
 =?utf-8?B?UU42OVc2N2gxOVpRS01vaE80cmx6cnorcjFSZ3gvQi8vei83QXc2eDA1dzV6?=
 =?utf-8?B?WG9HTmxteUMrMVRuWXlhRjNJUmhxYUZXMi8yRDYrS3pTSW9ZcHl1Lzlla1RU?=
 =?utf-8?B?Z1FsUTFhckdKUDdvMTJUdEtjUGN0b204cXdrUi9JY1dHTFF4dnhUQStvMnhK?=
 =?utf-8?B?TkY0VU1tSXBrREUyU1oxMDZtNmZsK3dnSlhtYnlreE1NK0hKdEVkbmhITUpW?=
 =?utf-8?B?SVlIalVjYU5NU0xoQTBoWWxNNTc0UDJldE1IMTlIQVZHMTRzYzlDM1JUcys5?=
 =?utf-8?B?VnpzMGNpUDQvTXY3Mi8ydEZpMXA2VGgvbzhSSEoxaDhlYWtDYkpRaWx4emtl?=
 =?utf-8?B?c0VGbmNFcVdYU0psczB0a0UyZDhtWllubGpVT3BuMHZmN0d4bjRMei9ZWldY?=
 =?utf-8?B?MEFkSnR4RGlJTENHQi96aFVCZEZIejZpMHJXbys0WldvaW9Oajhva0VzbUxw?=
 =?utf-8?B?WFBJN3dveGhNVFNLUEhiakVTOEFpdVcwalRLaFlKL3A1VVVpQi9CcSttSzVh?=
 =?utf-8?B?aFF0aTJLb29jUUhRNkd6Tkp3QlhaV2FQcEdSMU8yVDZJYmRLYlR1N0w0SWhw?=
 =?utf-8?B?ZFVWM1ZocFhIdnNlQkdzUmlTNEVGdDdMUy9SQ0d6Q0U2ZG1YeCtNeTZTUXhr?=
 =?utf-8?B?ZXFKdCtCOTNCWnNnRXp4VHNpdTU2Q295dCs3MWpaNithdlBYaE9mZ2VoUVY2?=
 =?utf-8?B?ODc5d3JrY2N2aTVzRUgxd25zU0hWQnNFTW9pMWh4VGRnZXltakU4NllZaytU?=
 =?utf-8?B?cFdlOElNQ2hCQ2tTbFlHaW5Sbi9jQmhUMUtzU05iN3dSMUFNTVg0SEFDYVJZ?=
 =?utf-8?B?Y0tvL0RRQmp6QlM3RjFhQXNkNC9mK0gyN1BidEgyZkJMY2ZCT0pUQmx5TmRL?=
 =?utf-8?B?RkhCZ1haWG1yUmpHQ2l1ZW1DVTQ5VHJZeG1ma2RQRDhlQTdMRSs4OHg1bnor?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31610EB0CA5CD0459A6673F8508BA215@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qpehwwHeCt+XfN226wQVspp73gTiuAwrCBni4irAETpmgdncYF/xU7wDF9tHgzwFjzNsru7ePo9LhyJGaa6hXKxaakuXdU6l1RaxuEuxpUpk8PMmAtz1NmHyzJCAbfTV72lOw5//QZyBq8zzgsJImt46Ha/PTUr8gLGBitVLMJy48rjlMiS5JmmjBPD+UyRFi7DC76nFwa96Dl7XP3FxS/SroOqRwNQ/YsNxvm/LiDd0dMMmpvB/aXvZfHZ/wcIBj1SrWwK6gEJgUxeGFwoeGPawPHPXqkx5fAL78UdXHBXr+1ug+nslWj/WorSCiAuBek9R+QgKl/HFEJtKTPf+Wuy5z3hywG4c70LuWgNRo8+2XOaewfncSMqemo2HxSt42g924WPLwB0uR3N5W801E7X7NqY01KNlSpP3A4EoDOwL3IH+5Q5bskNZpnxocdJGesTFddmqK4FTwO1x54b7aTUa6UN2lI+MlslURPwyOKe2UHDqRT/Ado3HgOv7mZAom4eZ/ET719fpXa0TGz8jYMPAl/2FcSuFjZBPUyw5oPw0FL1mu3QB9leLX5ju7l+l672tEYJ3wGSp3OUpStVcw0uWhDZ2TYc3OpXpZc4S/cM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b01ac87-8990-4879-0131-08dc1e7687a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 13:56:01.0054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFUoKcMmhOQRE+qO56x38p/0XJ5wGAdLkoax6RUpbxT/THO6f9M8Qp9mmrdjJ7doOpT5SPMPuTN0p9rwMmkKmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401260102
X-Proofpoint-GUID: 1TZT3CEiB2HfuGdap9SmdsYjHth5vvGE
X-Proofpoint-ORIG-GUID: 1TZT3CEiB2HfuGdap9SmdsYjHth5vvGE

DQoNCj4gT24gSmFuIDI1LCAyMDI0LCBhdCA1OjA54oCvUE0sIEJlbmphbWluIENvZGRpbmd0b24g
PGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMjUgSmFuIDIwMjQsIGF0IDEx
OjI4LCBDaHVjayBMZXZlciB3cm90ZToNCj4gDQo+PiBUaGUgZmlyc3QgdGhyZWUgcGF0Y2hlcyBm
aXggYnVncyB0aGF0IHByZXZlbnQgTkZTRCdzIGJhY2tjaGFubmVsDQo+PiBmcm9tIHJlbGlhYmx5
IHJldHJhbnNtaXR0aW5nIGFmdGVyIGEgY2xpZW50IHJlY29ubmVjdHMuIFRoZXNlIGZpeGVzDQo+
PiBtaWdodCBiZSBhcHByb3ByaWF0ZSBmb3IgNi44LXJjLg0KPj4gDQo+PiBGb2xsb3dpbmcgdGhh
dCBhcmUgc29tZSBuZXcgdHJhY2UgcG9pbnRzIHRoYXQgbWlnaHQgYmUgaGVscGZ1bCBmb3INCj4+
IGZpZWxkIHRyb3VibGVzaG9vdGluZy4NCj4+IA0KPj4gVGhlbiB0aGVyZSBhcmUgc29tZSBtaW5v
ciBjbGVhbi11cHMuDQo+PiANCj4+IEkgYW0gc3RpbGwgdGVzdGluZyB0aGlzIHNlcmllcywgYW5k
IHRoZXJlIGlzIG9uZSBtc2xlZXAoKSBjYWxsIHRoYXQNCj4+IG5lZWRzIHNvbWUgdGhvdWdodC4g
VGhvdWdodHMsIGNvbW1lbnRzLCBvcGluaW9ucywgcm90dGVuIGZydWl0PyBZb3UNCj4+IGtub3cg
dGhlIGRyaWxsLg0KPj4gDQo+PiAtLS0NCj4+IA0KPj4gQ2h1Y2sgTGV2ZXIgKDEzKToNCj4+ICAg
ICAgTkZTRDogUmVzZXQgY2Jfc2VxX3N0YXR1cyBhZnRlciBORlM0RVJSX0RFTEFZDQo+PiAgICAg
IE5GU0Q6IFJlc2NoZWR1bGUgQ0Igb3BlcmF0aW9ucyB3aGVuIGJhY2tjaGFubmVsIHJwY19jbG50
IGlzIHNodXQgZG93bg0KPj4gICAgICBORlNEOiBSZXRyYW5zbWl0IGNhbGxiYWNrcyBhZnRlciBj
bGllbnQgcmVjb25uZWN0cw0KPj4gICAgICBORlNEOiBBZGQgbmZzZF9zZXE0X3N0YXR1cyB0cmFj
ZSBldmVudA0KPj4gICAgICBORlNEOiBSZXBsYWNlIGRwcmludGtzIGluIG5mc2Q0X2NiX3NlcXVl
bmNlX2RvbmUoKQ0KPj4gICAgICBORlNEOiBSZW5hbWUgbmZzZF9jYl9zdGF0ZSB0cmFjZSBwb2lu
dA0KPj4gICAgICBORlNEOiBBZGQgY2FsbGJhY2sgb3BlcmF0aW9uIGxpZmV0aW1lIHRyYWNlIHBv
aW50cw0KPj4gICAgICBTVU5SUEM6IFJlbW92ZSBFWFBPUlRfU1lNQk9MX0dQTCBmb3Igc3ZjX3By
b2Nlc3NfYmMoKQ0KPj4gICAgICBORlNEOiBSZW1vdmUgdW51c2VkIEByZWFzb24gYXJndW1lbnQN
Cj4+ICAgICAgTkZTRDogUmVwbGFjZSBjb21tZW50IHdpdGggbG9ja2RlcCBhc3NlcnRpb24NCj4+
ICAgICAgTkZTRDogUmVtb3ZlIEJVR19PTiBpbiBuZnNkNF9wcm9jZXNzX2NiX3VwZGF0ZSgpDQo+
PiAgICAgIFNVTlJQQzogUmVtb3ZlIHN0YWxlIGNvbW1lbnRzDQo+PiAgICAgIE5GU0Q6IFJlbW92
ZSByZWR1bmRhbnQgY2Jfc2VxX3N0YXR1cyBpbml0aWFsaXphdGlvbg0KPj4gDQo+PiANCj4+IGZz
L25mc2QvbmZzNGNhbGxiYWNrLmMgICB8ICA4MSArKysrKysrKysrKysrLS0tLS0tLQ0KPj4gZnMv
bmZzZC9uZnM0c3RhdGUuYyAgICAgIHwgICAxICsNCj4+IGZzL25mc2QvdHJhY2UuaCAgICAgICAg
ICB8IDE2MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+IGluY2x1
ZGUvdHJhY2UvbWlzYy9uZnMuaCB8ICAzNCArKysrKysrKw0KPj4gbmV0L3N1bnJwYy9zdmMuYyAg
ICAgICAgIHwgICAxIC0NCj4+IG5ldC9zdW5ycGMveHBydHNvY2suYyAgICB8ICAgOSAtLS0NCj4+
IDYgZmlsZXMgY2hhbmdlZCwgMjUwIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gDQo+IFRoZXNlIGFyZSBncmVhdCwgbG9va2luZyBmb3J3YXJkIHRvIHNlZSBob3cgMDIvMTMg
d2FpdHMgZm9yIHJlY29ubmVjdGlvbi4NCj4gU2VlbXMgbGlrZSBhIHdhaXRfb25fYml0IG9yIHdh
aXRfb25fdmFyIHRyaWdnZXJlZCBmcm9tIG5mc2Q0X2luaXRfY29ubigpDQo+IHdvdWxkIGRvLCBi
dXQgdGhhdCdzIGp1c3QgbXkgd2lsZCBzcGVjdWxhdGlvbi4NCg0KVGhhbmtzIGZvciBoYXZpbmcg
YSBsb29rIQ0KDQpXZWxsIEplZmYgcG9pbnRlZCBvdXQgdGhhdCB3ZSBkb24ndCB3YW50IHRvIHB1
dCBhIHdvcmtxdWV1ZSB3b3JrZXINCnRocmVhZCB0byBzbGVlcCwgc28gd2FpdF9vbl8qIHdvdWxk
IHdvcmsgYnV0IGlzIG5vdCBhbiBhcHByb3ByaWF0ZQ0KbG9uZy10ZXJtIHNvbHV0aW9uLg0KDQpJ
J2QgcmF0aGVyIHByZWZlciB0byBoYXZlIGEgbWVjaGFuaXNtIHdoZXJlIHRoZSBjYWxsYmFjayBS
UEMgdGFza3MNCmNhbiBiZSAiaGFyZCIgYW5kIHRoZW4gdGhleSB3b3VsZCB3YWl0IGluIHRoZSBS
UEMgY2xpZW50IGZvciB0aGUNCnJlY29ubmVjdC4gVGhlIGlzc3VlIHRoZW4gaXMgaG93IGNvbm5l
Y3Rpb24gZXN0YWJsaXNobWVudCBpcw0KaW5kaWNhdGVkIHNvIHRoYXQgdGhlIHdhaXRpbmcgdGFz
a3MgYXJlIHdva2VuIGF0IHRoZSByaWdodCB0aW1lLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoN
Cg==

