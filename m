Return-Path: <linux-nfs+bounces-1082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F582D20E
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jan 2024 21:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08945281AB9
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jan 2024 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B51101D2;
	Sun, 14 Jan 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UPbIgDb4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Og++dstt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0209C8FF
	for <linux-nfs@vger.kernel.org>; Sun, 14 Jan 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40EIUKQN031674;
	Sun, 14 Jan 2024 20:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BS0xqpvsN0swo9J9kYtTneGyltIFV2YZ3cHWvKcZ+Xg=;
 b=UPbIgDb4mUYRgzmMkxkr9C+37//mEaH3Vf4IsRAtKpPaeVavXMlO6stlpe/GTFotmufw
 qjA2KGBiR2QZM6L2TQE6+CCI2q80FOwBT65Qu9xfbXhU4LOCBZ/uRy1j3Nn1zSBdJBIh
 pzbcuf5LD4JuwOe5LeT1uBg3BvaxCXMS7XNBwC/HjYopi7xTrTgdX3QcD3dSUsjyIkFI
 vdIFgh5kItg9tPo5gZBp8kDiqXjjrpby0WJiPcM7HXZwKmcN9vpZXu3GJ6ZNK9oKqMpj
 K34cOyaFenMszT3kuLzUQ4UvcMiyzL59IGxa4B6Si6gVj5VovoFgIOyaK1YFoYFsAYmH tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkq3gs5mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jan 2024 20:23:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40EH2Xbl020048;
	Sun, 14 Jan 2024 20:23:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy509wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jan 2024 20:23:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYE+GNWSxU2yI7vN6LTVuv5kGtvOINHbZHEwhKZ7S5KwFa5dNwH1G1HTKCAlE1236D8J3CYKxTxJRTEqJ1nHW0aqutIQfOd03MxzSSDhK2gcDA+bnnRyfHq5HM4b8IcFihe6jLk9PsQTaLH/lj1Aa4nDnKn5UdmiUMQs+lkNiGMqByRYtfI1ZKkB0OCKDkxmk8QszikuSK4kv7hr/13jGgrfqEq70t8F2jyELMCHNeKGQdCmL/WY+Q/skEYSqNFaAaFaxs/8d8hmB2gFbmeypdPdlGuc9dCv2siLdJXW280zBqvOnMbYjr+NKibPFqu/dP1uapMyrResKpNJIJyAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BS0xqpvsN0swo9J9kYtTneGyltIFV2YZ3cHWvKcZ+Xg=;
 b=PVzT3IH28+1GVRQeXfRlHwAuHE/hQHmZf5IfRvtCFmhm5gVAcdfjskOoMnCooqSJscMBrYsrFXzG0Ow2iJsGfDp2T2bEDa66mN/2UyonOTN+rAGtHAU8bVGsCfy7P6c1sfgF6ATGqdaNZU53mJrLBwXUe5G3O5YYaP7l+6SANiIylxHm33cKvuTgI+STSBcNARXvY5NQoZypVthhmo/HAtu1srCcNiFsuAgwCPVzYcUzgJOI6pw0NQw5Wq+SKgH/FCXBmkSu0nrnTG+BvsUcJYt/AVEPeW9xJ4Ei0yCghfi0qbXd9eg9GK4Y4rqZt+uC/ipM/XasikjyBrgDQnJxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BS0xqpvsN0swo9J9kYtTneGyltIFV2YZ3cHWvKcZ+Xg=;
 b=Og++dsttWoMdIIUmkN7NIu3Td+c52FTKSxnvvmtKarn5L3N1/2F8C+Cc6fnmES2EgYkIvixTEnjwsYW2hIjs01jgBIAXrhvrpkd3kiS6bqINU0t3t0wypBiGeSIRv7EW9OrozNx6O9f6l1Dqsq0MvlASPjNSBzwzePpPo6MxGsc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5346.namprd10.prod.outlook.com (2603:10b6:208:332::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.22; Sun, 14 Jan
 2024 20:22:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f%5]) with mapi id 15.20.7181.026; Sun, 14 Jan 2024
 20:22:54 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into
 tuneables ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
Thread-Topic: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into
 tuneables ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
Thread-Index: AQHaRbZPBYb+SPTdz0iA03bgLbzGobDX06gggAAF7ACAABEfgIABrjWAgAAqhoA=
Date: Sun, 14 Jan 2024 20:22:53 +0000
Message-ID: <2020F210-7A99-4615-9FF4-42DB789E4D28@oracle.com>
References: 
 <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <65a29ca8.6b0a0220.ad415.d6d8.GMR@mx.google.com>
 <CAKAoaQkZ+b7NfrVi=gu1vCJBvv10=k85bG_kZV9G3jE45OOquw@mail.gmail.com>
 <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org>
 <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com>
 <CALXu0UeyKvDNx7uM5RDynT=V8YXa27AZ1YNH_A9bBCvBsjrXxw@mail.gmail.com>
In-Reply-To: 
 <CALXu0UeyKvDNx7uM5RDynT=V8YXa27AZ1YNH_A9bBCvBsjrXxw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5346:EE_
x-ms-office365-filtering-correlation-id: 4794171c-5026-44f2-dff2-08dc153e96b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 y/RjuUKYUD0VO+supV/acE1YJoDcWAudL4Pb6KBdDFZsOE2TqHuyZjRC9uoCqgblCi3SDV/xd/2NBqwW55kXtyFSd5gk7yDoEDaOflpje9isxRr9WoZ4ivZYoWxB1aCx9xEj/EcKcKyVnqpa8PwmzTPySdzJnvLXjG+bs2GLNgZL5tIEO9iylHj3iTDt8d+ygcQV5CQAN5gQb6bDJf5ImleUCgvBXGwKQaKWg+1Ri9nvctPcfMzpFeMcGE6c7Eep8oUnPCWl3G1cjnBy4bNV2WNFUqmzUG9RXhSh3ryL9WGEpdZ77KyM2qbQRdJCMUvC+50BYIW+8/x0EDfb6HDfUw/vCYWuRDQlN+fM001eFL0LFnlv1MGGlSvVzhehkbGxVxR/23Agn5iJX0GG8+4ra1+8nOLGFeSMfOJNDgOTysQNw3vhDKsjNzbnuF2sgHTNhSbdMUpRSEshHq5jalABWaQRu/Rj59qgyeRjMjimEiwvl+m/+balSKbgucq8CSL/I62VGCg10gVTiDQxYNha6+GZ7tf1KTI78I+fiOrBM7tswIBbhy9V3mrSJrOOf6qdrM5DjolZFJzJlOjOoBVphzx6HStV3hSg0f9AU8kQZ+lDE6I5EqWgJa1kXMch4q/yO7fB0Ps9OurVRJcL/x5yIw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(5660300002)(6512007)(478600001)(26005)(2616005)(38100700002)(66946007)(122000001)(8676002)(4326008)(6506007)(8936002)(66556008)(6486002)(6916009)(53546011)(71200400001)(64756008)(66446008)(66476007)(2906002)(54906003)(316002)(76116006)(91956017)(41300700001)(33656002)(36756003)(86362001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U1U1ZTJuRjFMVzB0aXdYTWI1dG1BNlMzWjBhZzRrOUdjV3dqK29nZytoa204?=
 =?utf-8?B?STNPYUZrMXpSY0Y4cFdXOHd0am5ielNHbmZNRDh1UmcvbWxEZDduOG5mWkZo?=
 =?utf-8?B?QjVQWDJpMTZzM0dQd1BKclpOUC9mVEhBRlpqYUVxR3d3NWprTE1mRlFLc250?=
 =?utf-8?B?eXFQbjUzQXl5MkdqRTFRRUpqRERwa2tTQ0h3V3BjVlR2ZTJIYXk2R040SmpL?=
 =?utf-8?B?bmt5LzBLL3BlTjFzek1NL1FLY2FlYUIxUmRUV0EwTkprWWJMb2J3c01wRTND?=
 =?utf-8?B?VUhTY1Y4RTlPUmpySXRkajgwaHdiSk0xZUljZEVqdDVsQ0MraUcyVm9ELytP?=
 =?utf-8?B?U0VuZjlRMWJ1cG9VR3dhZi9XVVMvNVFHUmhOVHQzQVhhY0xYME96azI3Nmc5?=
 =?utf-8?B?ekVvcG5Mc2g4aDRWdkJUOTRqSEJQQzl4NE5GRnNZeXB2SkFXU01vN2hJbHc5?=
 =?utf-8?B?VVE2THhQbk45QXV0a0JsWmlzZFhOMUdjMmlSTGxkMmtUV0dMNVhjdEUvSktz?=
 =?utf-8?B?dmlqVUFsM2Y0cW56R2txNWU0aXR4NEpkZ0F2RERTdXd5azk4ZG5IdzZVVkF5?=
 =?utf-8?B?VHZkMW01d1VBZ0RBWDZHVjNzZGJGSFJmRklXRkJuOHZRd0pEWVJvUFBWTlZU?=
 =?utf-8?B?WlI4MU53NkdMMWRBRFc4REFkdTZ1RjF0UjNXbjJpZSt3SGlqUm9HdlZZY09a?=
 =?utf-8?B?NnIxRE94dDluNCtUbWlIMUw2Q1FCakxmZFhyUWkxWU5SbThGTk82STEwa0Iy?=
 =?utf-8?B?ckRnam16SjZCeDdBMFZxQ2JtM3U4N1RWMkJsR2w5dFVGL2FIbk5mM0Y4U3RV?=
 =?utf-8?B?aEpIQW1hYU5GZkljL0NZYW0wU3BxY1dCM1k5MXJ5RjUvR3dxSXRBVUFrV0JR?=
 =?utf-8?B?S2doNEtPUDZpY211QzU1ZW1VWEJLRzY2Q0NIWmEwbVJoODJjSUtvS0ZOTXdn?=
 =?utf-8?B?M3dReE1yd1RFREtTd2R4c244bko1dkEvQXR2YXFnTmcwc1dCMklXa2FhRml3?=
 =?utf-8?B?ZU9TWFhVdE9jRW5zNUpuZnJIakx4ZkNkMEdNYUptaEx1V1ZLWHBSWk14UVJ0?=
 =?utf-8?B?eWN0SlFRTi9VZ0w5emowUFo3R29TZTI4dlZyZldEbEV4SkkwdjA1Ymt5SmVB?=
 =?utf-8?B?dTYwOU1kUkR5Y1NpdVExSEZpNzNHMXNpaDcvRi96VFpxUDRYRERSdVdMQTRV?=
 =?utf-8?B?WXZsbmk1QUhwUjBVYkE3RTA5M1lLZVA5b2ZZUmM0bndZOWtaTmdsdVgvZkJT?=
 =?utf-8?B?c2NrN1hwdjZPU1k3MEpJM2IrNXR0eW8wV0d4cWFVVW1NNFEyTEIzcmt3YVZs?=
 =?utf-8?B?K2tlblZoUXF6QkJZbUd2WWQ3RU01M3AyV3A4U09rU1Z3ZVFqVllvU0VWV3M4?=
 =?utf-8?B?eXkvYkVUdG0rbkhaN3ZkaEttYzlZWFRGckVvQUE1aGV1enZFYldkSkJrRHNT?=
 =?utf-8?B?c2x0TTRIcEZtMXBaRXplQ0dPWEk2czRwWU5sL0lSeEpyYXk2ejhGa1hBbUEr?=
 =?utf-8?B?dVNDbGNFaXAzN0hYaTZKNmpjMXUzSU51aHFDOHBtSU1pb3l4TkFFa0k1YXpR?=
 =?utf-8?B?MThkMnd4MC94SkxodzhTQUVrNU5XdmR3dzkyRVVTd2dKYnhDUlVaYVc3SCtl?=
 =?utf-8?B?b3hBTGtac0hqVmJRSDNQUGFzTU1KOXpOd21BRkZIdjlNQyt0a2plK2FRdXRR?=
 =?utf-8?B?SVNaU2RLcVZrR3JYRjRFak1tSWd3bFc2RUVzRWsrNi9DemxvMnVVSHhyRnlP?=
 =?utf-8?B?ZFJOckNaTy84OGxncnZlSm5PaDlVNXIzN01ZMk9ld29Gd3locWJzeWRNTmpB?=
 =?utf-8?B?ZDNScStRTlFnMlB4UVlKTGU0VEJTK3FLVHdOUEFPa0pDTUI3NXVsLzY0azhR?=
 =?utf-8?B?NStXTjRIbERlTVFqdUZreDE4bW5xZ3BJVEJMY2laWWExemM5L05aMjJDeTFs?=
 =?utf-8?B?bSs0WHVZSEIyaUNGaWMxVjZjT1NDL0c4dXFCUDZveWM3ZHhzSytwaUpWOXNS?=
 =?utf-8?B?TC9sRTRwQ3BCMjNGa2lOS1k3Ni9JMzN3OXR6ZWZKNm1QQkFFN3BFckxBZ1Nj?=
 =?utf-8?B?dy9zK29hVWF0eDBFTWlZTDI1aWR1dzgvalZhTHYxbkY3bDhvMmJQS2o3MmJi?=
 =?utf-8?B?OGZ4elJCcGNTMHJuakJJWVpLMzNxMWpHT2U0OTgwem5rZi9xRUVvUDdETkJD?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49BA5278BE84CF4BADB7937D6A5E0122@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ydikxfc+muL1BKMXauQ49jFWXQbiwM+njljUQkJ84RXgXFGOTEU6bpDm8ueDOe7yYKpRDsfIptGknJ4K/3ZWUFTxzXPrjrwBfPTylZ4gM35e7Wa4Cng+ggs1XXbUtem3yOXCXXgC12aauDjHs2Pipn2ej6RYPMmzYkjEjgkDiE2pnVJdk2CQn6oywud7b87DE/mPZ3fHe2tlalwxnbr+YrHzko2lkRgVXnc0XqIvtv0df4EW+LPWRYFP2c5Alo0GEfstoAO16RFVMTo+F4SXuYvpgnsMV9Xp/77s92dgdTfRDc22NjcHr/OmqwqKtWt/PszdTguFvYPqRTCwzIACuh+F4ERtXhRSGShFwRpsKwx4fe3ghIjBsIQ9+zJezOyy3MWVmGTs1vEPhtxf4xVrW6R1lS4zyGUcCofdWpiAcOH6+PTDTnU5EulkJemCAbG6JnGx+gXUi9vVzZPZKvfrdU2K4yysM0untP8zqwdoZSXWCKF7BGE4mfNZBWg1eGAkLPJ4tEyOOTyiF1JjFjyppG768DdxTHmvxlmShywTbwWiykfVwGISu9BfcrjRS3WiNX/KDirwWdDs89zw6nbHVmhLtMy/OApSax9hSxuvvCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4794171c-5026-44f2-dff2-08dc153e96b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2024 20:22:53.9890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5U4SmTNypBdBigLw4/dy+R1hv1OAZujiohnsEIo/8oyHOW+7MTv7dYGJg+JOEDNWwftQI78C4rsKj6rfwgXNig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-14_12,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401140161
X-Proofpoint-GUID: iAugX9JY_jdFFMOvsnM0gUs6ljr3dog-
X-Proofpoint-ORIG-GUID: iAugX9JY_jdFFMOvsnM0gUs6ljr3dog-

DQo+IE9uIEphbiAxNCwgMjAyNCwgYXQgMTI6NTDigK9QTSwgQ2VkcmljIEJsYW5jaGVyIDxjZWRy
aWMuYmxhbmNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgMTMgSmFuIDIwMjQg
YXQgMTc6MTEsIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6
DQo+PiANCj4+IA0KPj4+IE9uIEphbiAxMywgMjAyNCwgYXQgMTA6MDnigK9BTSwgSmVmZiBMYXl0
b24gPGpsYXl0b25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gU2F0LCAyMDI0LTAx
LTEzIGF0IDE1OjQ3ICswMTAwLCBSb2xhbmQgTWFpbnogd3JvdGU6DQo+Pj4+IA0KPj4+PiBPbiBT
YXQsIEphbiAxMywgMjAyNCBhdCAxOjE54oCvQU0gRGFuIFNoZWx0b24gPGRhbi5mLnNoZWx0b25A
Z21haWwuY29tPiB3cm90ZToNCj4+PiBJcyB0aGVyZSBhIHByb2JsZW0gd2l0aCB0aGF0IChhc3N1
bWluZyBORlN2NC4xIHNlc3Npb24gbGltaXRzIGFyZSBob25vcmVkKSA/DQo+PiANCj4+IFllczog
dmVyeSBjbGVhcmx5IHRoZSBjbGllbnQgd2lsbCBoaXQgYSByYXRoZXIgYXJ0aWZpY2lhbA0KPj4g
cGF0aCBsZW5ndGggbGltaXQuIEFuZCB0aGUgbGltaXQgaXNuJ3QgYmFzZWQgb24gdGhlIGNoYXJh
Y3Rlcg0KPj4gbGVuZ3RoIG9mIHRoZSBwYXRoOiB0aGUgbGltaXQgaXMgaGl0IG11Y2ggc29vbmVy
IHdpdGggYSBwYXRoDQo+PiB0aGF0IGlzIGNvbnN0cnVjdGVkIGZyb20gYSBzZXJpZXMgb2YgdmVy
eSBzaG9ydCBjb21wb25lbnQNCj4+IG5hbWVzLCBmb3IgaW5zdGFuY2UuDQo+PiANCj4+IEdvb2Qg
Y2xpZW50IGltcGxlbWVudGF0aW9ucyBrZWVwIHRoZSBudW1iZXIgb2Ygb3BlcmF0aW9ucyBwZXIN
Cj4+IENPTVBPVU5EIGxpbWl0ZWQgdG8gYSBzbWFsbCBudW1iZXIsIGFuZCBicmVhayB1cCBvcGVy
YXRpb25zDQo+PiBsaWtlIHBhdGggd2Fsa3MgdG8gZW5zdXJlIHRoYXQgdGhlIHByb3RvY29sIGFu
ZCBzZXJ2ZXINCj4+IGltcGxlbWVudGF0aW9uIGRvIG5vdCBpbXBvc2UgYW55IGtpbmQgb2YgYXBw
bGljYXRpb24tdmlzaWJsZQ0KPj4gY29uc3RyYWludC4NCj4gDQo+IFRoaXMgaXMgbm90ICJnb29k
IGNsaWVudCBpbXBsZW1lbnRhdGlvbiIsIHRoaXMgaXMgYmFkIGRlc2lnbiB0byBmb3JjZQ0KPiBz
aW5nbGUgb3BlcmF0aW9ucyBpbnRvIHNtYWxsZXIgcGllY2VzLg0KDQpORlN2NCBjbGllbnQgaW1w
bGVtZW50ZXJzIGhhdmUgaGFkIDIwKyB5ZWFycyB0byBmaW5kDQp3YXlzIHRvIGlubm92YXRlIHVz
aW5nIGNvbXBsZXggQ09NUE9VTkRzLCBhbmQgaGF2ZSB5ZXQNCnRvIGRvIHNvLiBJIGFtIG5vdCBm
b3JjaW5nIGFueSBkZXNpZ24gY29uc3RyYWludCBvbg0KTkZTdjQgY2xpZW50cyAtLSBjbGllbnRz
IGFscmVhZHkgd29yayB0aGlzIHdheSwgYmVjYXVzZQ0KdGhlaXIgVkZTIGxheWVycyBoYXZlIGFs
cmVhZHkgYnJva2VuIHVwIHRoZSBvcGVyYXRpb25zDQpiZWZvcmUgdGhlIE5GUyBjbGllbnQgbGF5
ZXIgZXZlbiBzZWVzIHRoZW0uDQoNCllvdSBjYW4gYmxhbWUgdGhlIGRlc2lnbiBvZiBWRlMgZm9y
IHRoYXQuIEl0IHJlYWxseQ0KaXNuJ3QgdGhlIHJlc3VsdCBvZiBORlN2NCdzIENPTVBPVU5EIGFy
Y2hpdGVjdHVyZS4NCg0KTm93LCBmb3IgRGFuJ3MgaXNzdWU6DQoNClRoZSBtZWFuIHNpemUgb2Yg
TkZTdjQgQ09NUE9VTkRzIG9ic2VydmVkIGluIHBhY2tldA0KY2FwdHVyZXMgaXMgbGVzcyB0aGFu
IDEwIG9wcy4gQSA1MCBvcGVyYXRpb24gbWF4LW9wcw0KbGltaXQgaGFzIHplcm8gZWZmZWN0IG9u
IHRoZSB2YXN0IG1ham9yaXR5IG9mIG9uLXRoZS13aXJlDQpvcGVyYXRpb25zIGZyb20gdGhlc2Ug
Y2xpZW50cy4gRG91YmxpbmcgdGhhdCBsaW1pdCB3aWxsDQpoYXZlIG5vIGltcGFjdCBvbiB0aGVz
ZSBvcGVyYXRpb25zLg0KDQpXZSBhbHJlYWR5IGtub3cgdGhhdCBTb2xhcmlzIGFuZCBGcmVlQlNE
IHNlbmQgbGFyZ2UNCkNPTVBPVU5EcyBhdCBtb3VudCB0aW1lLiBBbmQgaW4gcGFydGljdWxhciwg
U29sYXJpcw0KYW5kIEZyZWVCU0QgY2xpZW50cyBkbyBub3Qgd2FsayBwYXRoIG5hbWVzIGFzIHBh
cnQgb2YNCk9QRU4sIFJFQUQsIG9yIFdSSVRFIG9wZXJhdGlvbnMsIHNpbmNlIGJvdGggaGF2ZSB2
ZXJ5DQpjYXBhYmxlIGRpcmVjdG9yeSBuYW1lIGNhY2hlcy4gU28gSSBob25lc3RseSBmZWVsIHRo
YXQNCnRoZSBwYXRoIG5hbWUgd2FsayB0aGluZyBpcyBhIHJlZCBoZXJyaW5nIGZvciBEYW4ncw0K
aXNzdWUuDQoNCklmIHRoZSB3b3JrbG9hZHMgaW52b2x2ZSBjb21wbGV4IHJlYWR2KCkgYW5kIHdy
aXRldigpDQpzeXN0ZW0gY2FsbHMsIHRoZXNlIGNsaWVudCBpbXBsZW1lbnRhdGlvbnMgL21pZ2h0
LyBiZQ0KYnVpbGRpbmcgY29tcGxleCBDT01QT1VORHMgdG8gaGFuZGxlIHRob3NlIGNhbGxzIGlu
DQphIHNpbmdsZSBSUEMuIFdlIG5lZWQgdG8gc2VlIHBhY2tldCBjYXB0dXJlcyB0bw0KdW5kZXJz
dGFuZCB3aGF0J3MgZ29pbmcgb24uDQoNClRoYXQgaXMgd2h5IElNTyBpdCdzIHVud2lzZSB0byBp
bmNyZWFzZSB1cHN0cmVhbSdzDQpORlNEX01BWF9PUFNfUEVSX0NPTVBPVU5EIHZhbHVlIHdpdGhv
dXQgYSBwcm9wZXINCnJvb3QtY2F1c2UgYW5hbHlzaXMuIFNvIGZhciBJIGhhdmUgbm90IHNlZW4g
YW55DQpjb252aW5jaW5nIGhhcmQgZGF0YSB0aGF0IHN1Z2dlc3RzIHRoYXQgaW5jcmVhc2luZw0K
bWF4LW9wcyBpcyBkb2luZyBhbnl0aGluZyBidXQgbWFza2luZyBhIGRlZXBlcg0KcHJvYmxlbS4N
Cg0KRm9yIFJvbGFuZCdzIGNsaWVudCwgYXMgSSBzYWlkLCBORlN2NC4xIGNsaWVudHMNCmhhdmUg
dG8gc3RheSB3aXRoaW4gdGhlIGJvdW5kcyBvZiB0aGUgc2VydmVyJ3MNCm1heC1vcHMgYW5kIGNs
aWVudHMgaGF2ZSBubyBjb250cm9sIG9mIHRoYXQuIE5GU0QNCm1pZ2h0IGJlIGNoYW5nZWQgdG8g
cHJvdmlkZSBhIGxhcmdlciBtYXgtb3BzLCBidXQNCnlvdSBndXlzIGhhdmUgbm8gY29udHJvbCBv
dmVyIG90aGVyIHNlcnZlcg0KaW1wbGVtZW50YXRpb25zLiBUaGUgYmV0dGVyIGFwcHJvYWNoIGlz
IHRvIG1hbmFnZQ0Kd2hhdCB5b3UgZG8gaGF2ZSBjb250cm9sIG92ZXIuDQoNCg0KLS0NCkNodWNr
IExldmVyDQoNCg0K

