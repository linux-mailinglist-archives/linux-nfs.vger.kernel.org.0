Return-Path: <linux-nfs+bounces-1577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861448412AD
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 19:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D861C23A78
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82BE29D03;
	Mon, 29 Jan 2024 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ElwXruaJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OfSfMx34"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCCE13D51E
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553718; cv=fail; b=Xv+u+FzYK9JNd+VmiPLoarVmJXOwsu3LKRj/imCJbvUuRBb+iz0cdMOrfEofAUnmNy//pd1OLBeVk22DoFU7scsswDtJ56vtOvhmqMjNeFul1Ioqy5G0lxhEFR+TZdtZX1zOTEGAbTkqDCbisp7fC/zzSTGlWcedllN87UEtqd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553718; c=relaxed/simple;
	bh=H7TrV5ZaDM092WJUibMoQDXZX1wSd6FRwIE6qyyrXhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRv25SgXOMI4/99IcFaOeupGeGS+bqAQsXgZoUd/slko1NaAqeRgu0QWm4nOEGYjrZ0FYFUyM3A/1fKglI4Z5gFY7Gx5xkRjSX89ANByXsL+3lGuIIzetU6oaZVPLKicVbyvmy6Be8y38uXR19IoSGZ15b/eS2mhLs70BnnpIGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ElwXruaJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OfSfMx34; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TGnjAc026073;
	Mon, 29 Jan 2024 18:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=H7TrV5ZaDM092WJUibMoQDXZX1wSd6FRwIE6qyyrXhU=;
 b=ElwXruaJl19UIDk+7iMG5jzkBVoBi7CWkfsVf72iiGH1Kenl5+bw4cP8Ff4HD9mS9Ejd
 iq2Rq+7SC/6AWMy3nkKaHPz47FLFGYAJqrKCZ2I+YCD9o6WqqcoIw+6wjG0baDbVTHZq
 tj9aAq0Dkh4fxXljicTjexesad67C1TRTA/7p75gOF9Fqh2XZiHtWa/93mxo0qXFcGuG
 wGAbvhtepPbgCbJMnmrxV9jMyXqGgbhIAd/F5LJsBWKiX2VKEOQP6JJh2dkZeqEh3YKB
 Q1aShQjr841XR82hrmt/TfliBukxNyHKXxT3SB3WpljA3wDUOJMSOW+1Xr2z/E3T+HeX IQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2crsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 18:41:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TIbWsu040100;
	Mon, 29 Jan 2024 18:41:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr965jy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 18:41:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW/3AVgPVoGkN1ZX1qOnYZsuWI8G14t/a50m4PBPcfSU31ISEnMxLfMkpwnOmBqvsyzaXFj8PKGV/6pkOerpOj/f2lwa0lF2/+8xPTploFTWvhCuLeIp/0d42lwaKRjKROr6f1zK4IugkSEwXhn3HnBXen1um/QPUV5HW2u9VSpqEo6BZlVPCMgYJPDn/F31ULmAZvlWIWaK56Rwofreu8A0c/M9oOSZScrL5KxepNDrHS32gHGWtEdAsiwFQWVEvLLQoDVnMqLmw6gDKh/lWbjO7kRhlEEinggH65i7z5tMbXvqsNb+cEKtV5KDgH6GOaTHZON8oPEYv4QATyUsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7TrV5ZaDM092WJUibMoQDXZX1wSd6FRwIE6qyyrXhU=;
 b=JNhmkV0fMATuWQuiOhQc1d/KuyhNZ3iQWkzC1gQRPzc/zOje+r6AhFesz+J6fQcO2249rJascStkNrYkiOzqzEKqNtpgI7rymyZWtvJxh2KPUjWvS9J0sKEtjd8NduFdC/0V8xlyk6pY4mcqbml7FDLSEjkiFXasGf93T3oTur5kJSH9ZXnWigG3cPxW3SB90ieYrfIVWM0ev4tE4K/ZiJVOBK+iM4MPtl1U6g8cAFmopslFbZyU1UXpRNOJbSfQUQH3ceUl/p3kLn2egi0j632WxfutScfG/F0ffNtTezc2fmOskYksltZrwqWAmIa9kgPHx/0dstqD9GUx0yx3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7TrV5ZaDM092WJUibMoQDXZX1wSd6FRwIE6qyyrXhU=;
 b=OfSfMx34osNy+1BJTOeF9OSPouJ2bAbal8vqA5vGZRdD6KZKr8CIRwLBcz3GdzYXwN6n703A8zeHJx1truWwb2rGKWwHnpMjE/byuHdeV0a+vji6KxG1zC3A2yaUWRKpPWtbQNsheFyx+muvcIXpkMJuuv+Q4DKYrBM6TTw62k8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6110.namprd10.prod.outlook.com (2603:10b6:8:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 18:41:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 18:41:45 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
        Trond Myklebust
	<trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Benjamin
 Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH  1/1] NFSv4.1: Assign the right value for initval and
 retries for rpc timeout
Thread-Topic: [PATCH  1/1] NFSv4.1: Assign the right value for initval and
 retries for rpc timeout
Thread-Index: AQHaTb37YKXGBRNghUS8q5tNhp9fPbDxDt+AgAAbN4A=
Date: Mon, 29 Jan 2024 18:41:45 +0000
Message-ID: <75BED47C-298C-46A2-B085-3A3E8689FCE5@oracle.com>
References: <20240123053509.3592653-1-samasth.norway.ananda@oracle.com>
 <40ff24fdebb70792c7a714186f74bcd51b8c7a79.camel@kernel.org>
In-Reply-To: <40ff24fdebb70792c7a714186f74bcd51b8c7a79.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6110:EE_
x-ms-office365-filtering-correlation-id: 41aab00b-420a-44cb-c0fc-08dc20f9f206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ctlZ+I01cr9J+Gf60QMHWuILjRkkxDpWw8ymNlzo/RCNOOQSW3Nat0enmtW0QPgjDP/3JuLcv99+zAVFGAIkPDcR9xOWN2ofscKmQooyrtYyb7/iaupTdS0UPVuqQJNm6mGn4CGv0H72BA6xXlOZYPfbBKZ30/5JFh3/b/lf9zkQf8urjyxUWNoiBUUZfN97PBhJcYus5+jFa38+YHhCUcBSwPjcNZn57RopwMY/b0Q6uKnhuxyQgWrJWDgO34X2DF/CCSXI9zWO5aZXdaMdS6iJ+edZYCawgfjNq0+0wlYjCWMqI0rPvZMsWxXn9hh8e3B5Tv1UfnkklE3JroFxQuCbPcTXdczMW/e496yBFI2/JhlJPrgX9pMz7+T5yAc/YjE/gcRqZPXfF+/I5g2r/AGmDLq/T8nG04hBzofkx+AMR9JkNF1qnHvjRih0EQtGrjlaN42FQjS0qSMCwKmivZQVNhJc8ojq7ZcVAuJOiWntiN4WE2cX5anfFyejLmByjbmr0zh9ZVUyFP9ACvxsReUzmDuDlo/mEePnpJtE+xM8m87a9pCny1+LkEAlM4CiOmg2vxQaF4etF0mHQURfLUkFK87r7WBRrMWizXxaI/armCisw++gTlXZiuATDdqZL15iZQj+i25bjsbXa9efpA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(66556008)(316002)(6916009)(66946007)(66476007)(64756008)(76116006)(8936002)(54906003)(66446008)(4326008)(83380400001)(26005)(478600001)(71200400001)(6486002)(86362001)(2906002)(33656002)(38100700002)(122000001)(6512007)(5660300002)(2616005)(6506007)(53546011)(36756003)(38070700009)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QTdiZ0l6cEExclJzNG5lUmtXRVoyUEdmb0lqdE9xbGhhbmpyVTRkMFYrZFV5?=
 =?utf-8?B?bGZGZGw2Zml2VTBCd0RZaVR6SkxZSUJRWFhIY3NtYUNLNUtOV1RGdi9kZlVC?=
 =?utf-8?B?OCsrSEdyeXJLZE44OWd5OWFZU1k3UWdMNE5aaTNpOEVuN3Nsa3o1UVg2YUNN?=
 =?utf-8?B?UEt2cGplTitNVTVKcERraWlOazAyRjQzd2RDc3dNQWpqU3NhTy9FR1o1S0dm?=
 =?utf-8?B?eEd2c1JKZGRXMFBzaHdUOVFXSFQ0SXBkbUFJNUhXdGxhRkliSEZxQ2k0REcr?=
 =?utf-8?B?Uzh2ZG00K2ZUZ0Z2Y2hhTE5aWi81YkpxaWxrOE5iNERSblFZQStlcENLR0VT?=
 =?utf-8?B?RzlnUFcxUGdnNTZLL1Ywd1YxVEM2Y3BuNXZXL2x4UUJ2aFFSOHJqUmZOdE9P?=
 =?utf-8?B?ZDdxZDN1dWluZXFIVTQwNitBSzB2UHZXNG1ERC9kZWJwZEtwRnNDaHN6MFBq?=
 =?utf-8?B?NnFqOFQxbExKVzJUVjd4Y2xlMTNJZno2WWhqd2NWSVlxckVEczNYUUlWZWdD?=
 =?utf-8?B?K1lEWXIzSnN1eWl3aGZxSzd4MFduVFp4cVVLb081UDhoSURZYlNKK25FSVFH?=
 =?utf-8?B?YThRZVdxT3R4YnFaaUsvUUZScC9aNnpLTEhESWRzcEJneVUvSThyc3hycjJF?=
 =?utf-8?B?Qm5UV3MwenFPazBReDV6MDlBdVV2c1lsamt2V1pMR2RNTzVrR2xPWW1SUDFM?=
 =?utf-8?B?bHdaSGg3Ym9sZ3JzU21mVU02ckpHeW12N3lRb1d0WVRXYi8vbDFPMStFQnBJ?=
 =?utf-8?B?aStYTWNleFJKbHBnU3FyTGprRVV6c1pZcjNKTHQyWVFaVlhXbnFFSTU5L1Q5?=
 =?utf-8?B?bnZOWEJzamZZa1R3NlJuVkYyWDg0M1ltNTBtaE1uMmlidW56YUNCNUM3eGpt?=
 =?utf-8?B?RXpkeGFDQWZjdlFpKzhDck9OdERmSE9vb1NuV2RRSGhwSWREc3VxUlhxVnVN?=
 =?utf-8?B?R2lhWTA2OHJUMmtHNVJnWkhXVmlEeFljZ1ZGK3NFRTVFcnpqVWJTS2VFdWha?=
 =?utf-8?B?NXRMLzJVbCtQRUNhOU5LS0IyMGZMSGxBNWZ2aEdFUHlsRmhYZXRkRElrczNp?=
 =?utf-8?B?MEo2Skh1Vnh0dFpFN1ByV21zdGQ1UUQ0OUlLbHFHSE80L3BBSDdkMWRqZ2hG?=
 =?utf-8?B?VVNwalpGR1RRcUN5bGJCWUttUDFIdXNTeGkrNnRqOFZ2cTBTQXNwNDdrMG55?=
 =?utf-8?B?ZWRueVpsbE5RTFZONVlvcWhwSXFoSndMVk10SkpVYlQwa1UycitaSmdBRnJs?=
 =?utf-8?B?WVZIMWY1WVJaWkszSmVmaERoZTJkRG1kNU9DY1p1b3crS1dWTXFHQkp4YmV3?=
 =?utf-8?B?MEMvM2VZYVJuTTRCdm9peEgzQXhkRmJpTUxGdFZDNDJTdTI4d1kwZlRnZWxV?=
 =?utf-8?B?cGhUVTR2V2c4L2dkRkZxNTJUZ25TZFZENjJkRzdQWUdwQW15V09FMHR5RGxK?=
 =?utf-8?B?bmpuOGNHdU1wOEJ4UXoxd3RHQXltSm9QZkpvNWtiRW9uYVVJQ0FIQWlLRkVG?=
 =?utf-8?B?cUtXOUxoSzRjQzdDWnk1THF4SkxEMjBvUzhlM0xzdkZYSTk5MTZ0cXRreHRw?=
 =?utf-8?B?S3RTdHhtbVdoWUNjbUY1VGp6dWlXNnc4bHdXTm1LcWJrRUZHNWg2cWU2Rks5?=
 =?utf-8?B?TEtWbHArUm16dnpjYlV1RVVRbkZxSmo2WDM2ZmhxVmZ0YTdmNlZpc3BIR1Bi?=
 =?utf-8?B?V05PR0VIYmo4S21IMjVJNUVXNjZtUjF3TDg1Wk5ZeWo4RjdhU3FpUnk5eVUr?=
 =?utf-8?B?Tm5HSWhiSEhTZTFYSGpBWDQ2WVR3T01sTTVGRUVuQXpQN1pPZFZ0MjBpMnli?=
 =?utf-8?B?M1hYYjZ1Tzl6cG9KUlVaOWFQdFJtdDZIZjZxY1BmbWpkR1JzWlk1KzNXcytK?=
 =?utf-8?B?V3VQbHlFUnVZUWlDN1g5UzhwakE1TGlNOVdNakRYajNwQnRMYXFLUitWK3FL?=
 =?utf-8?B?Q3A1MDRzNFVVcm9LeFVIem5iMlBMTUhjMXdSWmNBOGJyWHpna08zZEJ5MDhB?=
 =?utf-8?B?Z2dFMjc5VDlNbmxJU0oyVitiay83cG10UHV0Z0hUeUkrZlVpdWh4cVBLSWJo?=
 =?utf-8?B?cFE1VUQzbHhCWGlZOHpRYXhTRERoT1BuNlBzN3JMTkM1cnBIUFRhZ2NmRUJ1?=
 =?utf-8?B?M2xGQWxPdmJTVlliMG85enUrZkFFL2svWmE5M2FyZUhSUjZ5YTgvRHk5STFB?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE3D5CAD9B5692469E09B8DF8797FCB9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bHX0HPbFnBVlHXpX9soTVfr9GgwxjQw9fjBO69JMfCYOYelLcM7Y1j9g+FvOgqVF/oyk8LnDocEkNxkDYkHKoYYlr7CDMDksqlEL3NUOTGvzaTJGBTsE9mEbCyG82eFUMDUBxQe7rLd3SJpHi62E/8Y/56xoX7E9vXa4bxh1JbuNjlkDGgDAn5yVJHcObwEA8C/tlNkzavXUsB960Y3a1Xj6weI+zvvYQevwcrUmEo8Y5g9bbxQF17TyETaTk/fUCOJj2kYEXdjQoPMAafGGtxSXpGA0mK+kAbmw3jKcdyJmmaXSV51QRwntEc28J4KXXtLXmbl3veaGt5Es+/jvCrPETADxEfGYHBjy7reUXH0ybB5u1hPREwPA6VOx0dTc3zZu2kxrI6PJhjYF7xY3MatUKlZSRwbPrGzApb3TeqRIPiuPG96YKG9qNu6mUw1HKpUNBS/ZCSxotvB2ThiV1NbNVGcd7GY/ID3w5HXFNEbuQvQ42l1JnZh3Tgxp9meXWaYvZz5rrzS4O8DqwQB5lXJI9ROZ5L9qN9hCfJxco370Zbniz2a5Ibc5VBQ/k3jWJ0Bi+PoykXRTf9LbrG7lGp985sDAJQiPFV4/mbfyxgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41aab00b-420a-44cb-c0fc-08dc20f9f206
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 18:41:45.8727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbIDiU75qTCX23Hgfusm+tMVzxWcrTP/LdpCV8EPUvoH5fEVQV7iI0Qu/xbWlqTdxaEzeAr6Icto/J9kOBzCmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_12,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290138
X-Proofpoint-GUID: rvRt1S71563igxkeoXBEBOwCKQxEH-_S
X-Proofpoint-ORIG-GUID: rvRt1S71563igxkeoXBEBOwCKQxEH-_S

DQoNCj4gT24gSmFuIDI5LCAyMDI0LCBhdCAxMjowNOKAr1BNLCBKZWZmIExheXRvbiA8amxheXRv
bkBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgMjAyNC0wMS0yMiBhdCAyMTozNSAt
MDgwMCwgU2FtYXN0aCBOb3J3YXkgQW5hbmRhIHdyb3RlOg0KPj4gTWFrZSBzdXJlIHRoZSBycGMg
dGltZW91dCB3YXMgYXNzaWduZWQgd2l0aCB0aGUgY29ycmVjdCB2YWx1ZSBmb3INCj4+IGluaXRp
YWwgdGltZW91dCBhbmQgbWF4IG51bWJlciBvZiByZXRyaWVzLg0KPj4gDQo+PiBGaXhlczogNTcz
MzFhNTlhYzBkICgiTkZTdjQuMTogVXNlIHRoZSBuZnNfY2xpZW50J3MgcnBjIHRpbWVvdXRzIGZv
ciBiYWNrY2hhbm5lbCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBTYW1hc3RoIE5vcndheSBBbmFuZGEg
PHNhbWFzdGgubm9yd2F5LmFuYW5kYUBvcmFjbGUuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEJlbmph
bWluIENvZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+IG5ldC9zdW5y
cGMvc3ZjLmMgfCA0ICsrLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3N2Yy5jIGIvbmV0
L3N1bnJwYy9zdmMuYw0KPj4gaW5kZXggZjYwYzkzZTVhMjVkLi5iOTY5ZTUwNWM3YjcgMTAwNjQ0
DQo+PiAtLS0gYS9uZXQvc3VucnBjL3N2Yy5jDQo+PiArKysgYi9uZXQvc3VucnBjL3N2Yy5jDQo+
PiBAQCAtMTU5OCwxMCArMTU5OCwxMCBAQCB2b2lkIHN2Y19wcm9jZXNzX2JjKHN0cnVjdCBycGNf
cnFzdCAqcmVxLCBzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwKQ0KPj4gLyogRmluYWxseSwgc2VuZCB0
aGUgcmVwbHkgc3luY2hyb25vdXNseSAqLw0KPj4gaWYgKHJxc3RwLT5iY190b19pbml0dmFsID4g
MCkgew0KPj4gdGltZW91dC50b19pbml0dmFsID0gcnFzdHAtPmJjX3RvX2luaXR2YWw7DQo+PiAt
IHRpbWVvdXQudG9fcmV0cmllcyA9IHJxc3RwLT5iY190b19pbml0dmFsOw0KPj4gKyB0aW1lb3V0
LnRvX3JldHJpZXMgPSBycXN0cC0+YmNfdG9fcmV0cmllczsNCj4+IH0gZWxzZSB7DQo+PiB0aW1l
b3V0LnRvX2luaXR2YWwgPSByZXEtPnJxX3hwcnQtPnRpbWVvdXQtPnRvX2luaXR2YWw7DQo+PiAt
IHRpbWVvdXQudG9faW5pdHZhbCA9IHJlcS0+cnFfeHBydC0+dGltZW91dC0+dG9fcmV0cmllczsN
Cj4+ICsgdGltZW91dC50b19yZXRyaWVzID0gcmVxLT5ycV94cHJ0LT50aW1lb3V0LT50b19yZXRy
aWVzOw0KPj4gfQ0KPj4gbWVtY3B5KCZyZXEtPnJxX3NuZF9idWYsICZycXN0cC0+cnFfcmVzLCBz
aXplb2YocmVxLT5ycV9zbmRfYnVmKSk7DQo+PiB0YXNrID0gcnBjX3J1bl9iY190YXNrKHJlcSwg
JnRpbWVvdXQpOw0KPiANCj4gDQo+IFRoZSBvcmlnaW5hbCBwYXRjaCB3ZW50IGluIHZpYSBBbm5h
J3MgdHJlZSwgYnV0IHRoaXMgaXMgbW9yZSBhIHNlcnZlci0NCj4gc2lkZSBSUEMgcGF0Y2guIFdo
bydzIHBsYW5uaW5nIHRvIHBpY2sgdGhpcyBvbmUgdXA/IEluIGFueSBjYXNlOg0KPiANCj4gDQo+
IFJldmlld2VkLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KDQpJJ3ZlIHB1
c2hlZCB0aGlzIHRvIG5mc2QtZml4ZXMuIEkgY2FuIGRyb3AgaXQgaWYgQW5uYSBvciBUcm9uZA0K
d2FudCB0byB0YWtlIGl0IGluc3RlYWQuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

