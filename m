Return-Path: <linux-nfs+bounces-1708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2C8471A9
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 15:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A8EB20F9D
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767397CF10;
	Fri,  2 Feb 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G+jdO4Mb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g+Ei8U/b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008477654;
	Fri,  2 Feb 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883149; cv=fail; b=GM6NAu4w8s/LQgUmwZaudtakGKa3Ua3VQPWCFMSEwsSokZGw5+j+CqryayOxXmTj4Ndq/8VBjEn06tWrUkCkUcu4yMjjpLVGFtAyeGLZkHmN9Mym5gBarzOSmlPgtNn1FmtbDKINJAu6QwwRZyDuV9EK+LHFW31esQSX2T3eMWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883149; c=relaxed/simple;
	bh=K1LDjNNi+AnNLN9evW+y5nW4t6ePk/jjntxdKDGMsqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S4EsHTnE2iTt0s4E5Djde/4ypMBqDIRVFsBefwwvErQuhhi5aaSkBt+AlzOqR3Ji9Zdj5y/1bAcv/9yMZHacy80k6ijECCfzT1Pvp9ChuD4XecKYQ8QHx7qer6gYTqLv3ca0y5bbPVWua55dJtmTrzCMaHKoY1c8EBZSuj4jcew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G+jdO4Mb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g+Ei8U/b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DQu8I016571;
	Fri, 2 Feb 2024 14:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=K1LDjNNi+AnNLN9evW+y5nW4t6ePk/jjntxdKDGMsqI=;
 b=G+jdO4Mb1WOm1YZTXrlwuBLWgg7UPsWDQb1W9AIEGxWnN5zj1e0w6FMYeeq7f/HpkBTt
 tF3MD1AYfkkjrCIhBgegO0p1sSUwY7t3Ly/4X03HJQtG49llolV/jp9Xkjd9s8Pv/KvN
 PxyV/KkZD4S8eQududdo6OAt5oLPYsNnlKndXYHA8RPjVsnBAU+Bu51sLgR+0vrP25Zp
 BeAFXUMy/mF7mwywR160Yitz2amxefI6rmip73/CsjbJeIJHLuZcY2DeWu9ctlcBAywG
 6kMq38FBuIPPbVLFGVZDiI3nFEpQVHDrrdf9UnIgvmpXeJQ+2B+38QZKSnmbdprsxGKo Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseuqj0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 14:12:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412Ddq5r012419;
	Fri, 2 Feb 2024 14:12:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9jf5pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 14:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGVy6eSALY7mxXMdYprPIoZXCtaq6/7a3Ti7gdrnVhgas7IE2EGTzIbd8kSAuXlSCa7OMDafcfs8HgUJ0kHQLNx5o2c74fVL0mtDuuuLIKVIPts78kIHBcMEDC1Jv8Lf3IpisPKTnsp/uGELN4Q57HJ4BqQ8FknLdXnXQD5lj/y2E9TsWX85B5A1iA7zCKd1oHzORVHdsul9XQ5DIgNAKKb81QiCLjbX5irX+gEWXVJGVQK95+x2pw5lYlAmR1wFopsoZXV/VL0JWBmfxhWKVFcXQWi+2eyGS3sZAbjuxtFglcv+9qQEVLPJqRiAA0ZuADVbSD3gDQCjxKH3/0lLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1LDjNNi+AnNLN9evW+y5nW4t6ePk/jjntxdKDGMsqI=;
 b=Pk6e7tVEy6EE4R4+8ZOk32wCzSLIDSkC6kiX6w7561mOIhBwDoH9jyZ7njSolemivic7SAdS5Lj+YAPI8WAYycfFelUO+s4heXMaJUT/N0H4cWxVg7Gam5kg+QHGLTuAMnd2OORqHn8dvLKJAEQgcaDVCSxYiB7rgf2YhQWt/Cz376P+APhqy95kjw2Xvozy3Tkyr054wJ5Xa/ZgLtnqh5vNzhY8fz18KhyTIysBdm8xe/D44oLpSyLl8RIyafhbm7P2Nu21N8F4I9dJCWDTmS3WWgQq7NmT4NhYBKN28zwbSF1+SwAt/XGWuDwXMnhGh3aEblwvyfEHxFAaIQN1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1LDjNNi+AnNLN9evW+y5nW4t6ePk/jjntxdKDGMsqI=;
 b=g+Ei8U/biTkyk8dKBrcaMjR3VypO26isV/OjLSimJF+sTpdCjfyIlbLXGuMIxpOvhqvSlFkbacSsbPXyH8PkNvife/OKoB0a5c27HgsubDnOg1+yqrec61MokCgbMYdzNZxYIBcNyRgJF3fS8mb5d1jeNFPfNL93SiZcE4r0mNc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5013.namprd10.prod.outlook.com (2603:10b6:408:120::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 14:12:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:12:11 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: linux-stable <stable@vger.kernel.org>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 0/3] Fix RELEASE_LOCKOWNER
Thread-Topic: [PATCH 0/3] Fix RELEASE_LOCKOWNER
Thread-Index: AQHaVUHX31DjrREGIECKix3zT1lNDrD2EGmAgAEIp4A=
Date: Fri, 2 Feb 2024 14:12:11 +0000
Message-ID: <FF7C90E0-251D-48D2-908B-E2145B0B9BAE@oracle.com>
References: 
 <170681433624.15250.5881267576986350500.stgit@klimt.1015granger.net>
 <170682628772.13976.3551007711597007133@noble.neil.brown.name>
In-Reply-To: <170682628772.13976.3551007711597007133@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5013:EE_
x-ms-office365-filtering-correlation-id: d8a01ad3-f05f-42a7-e32b-08dc23f8f2df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NSIJI1xV845lVLDQLAZ+fTp29Uk2fxFLzXzCiuSsqSrtSshODtpcgoQKt0CzjnJ2ZsfeG81TegwIKJRY4Y9449i6yjBLEjaaDWJ8UvfK6CB/rdP0+bZj8sql19v/GNGoo7ffbMu98d1FuKlaSj2QHakBZEScWf4Uj+RfyN5FoE3TgEKbvovxE80pJKzMXu03Jx1bZNjkD7MI9hVNPE9vjYkny4rKMne6KnHqskEVB5bNJZa2Ic17Nqy/xhNPb+fIxolUxBJsNZ/CLiGdi1aXDjTtTXoc5PYheWAdyD4jrhsBW3VTfAG93R2xvGH2Oa2MHSWvWHdj7eM4nWVj8P8CkRMXeDUWP9CN7VYCa2Agw2xO3BXk7LedlkY5DV/+0LJq/iGIodliRRjdz0gngM0H4AWFVfHqndRLhqgIKTQdW+T5osWPtE9rbIsie1nxzLMyftOf5dVEvbK/QUKGtFbnvuxzDFSvRt4XiVTpFPSxqAIzCA+0NIyANIR9WcMeBOizraPyNSTylNsVN4pcPT74IG2UbaGRBRIcGVGp/CNz7N3xL2snLXYQ2Y0t1Viq5O8z3axCDae7gkKzbdv4ywJYdeOHYk+iaINKrMBERL774cj29kYYqN7bvzQNLoRzdrzqhNCXEZqenSMaBPTyjIrjwA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6916009)(316002)(8936002)(8676002)(6486002)(478600001)(4326008)(66476007)(66556008)(54906003)(64756008)(66446008)(66946007)(76116006)(86362001)(2906002)(38070700009)(36756003)(41300700001)(5660300002)(33656002)(2616005)(122000001)(6512007)(38100700002)(83380400001)(26005)(6506007)(53546011)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c1BsZ2E1TzJycGZkelBmMnNIcC9XcVJ2ZGVFWW9Yb2JpTUN2M1lxMXdoQjlT?=
 =?utf-8?B?YlAyUDRWdmVlMnZwcVFHczNPSE5FNHNYSVBOM1QxZWQ1RC9TNmtNcnZHc1ZM?=
 =?utf-8?B?Z2xCdnlGSFY0ZFcrUHVoVjg5WmtsMU5CMXpLSmc4eCtJM0d3WHFJQkQwWS90?=
 =?utf-8?B?ZUZlclBSWGtnQUN0UVRXNi9JK3J0NnJjUDM2SHFoQndPQzdxdTVUanE2YVE0?=
 =?utf-8?B?MDVvZ2JFalVFSUkwSmxwdWpTemJBMCtNc2VieE00MU5UQ3FyOUhiazhDa1pk?=
 =?utf-8?B?RmZGYjY1bnVER2pNRHZaUFV3RzZZWm9tNWJFZHRjMnVuZ21MTENUaWZVUUFI?=
 =?utf-8?B?Q0NpV1UwQTAyL0FEUHBzc2kvdmZKTTBVYUo2ekFYUjJ4RjVhcDNqblRkd0Vo?=
 =?utf-8?B?b1NJOVh2bXFDbkx2a2pXUG5SUkdVOWhYbWRxV2xNeFRLajRxdDRJdFBFMVJu?=
 =?utf-8?B?THp5N1l6bTVXTE1iSDFERmh2VVhRbEc4RU4zamdSdndJc3Yyd0dPMHl0Ui9k?=
 =?utf-8?B?dU1ENjk5NG02cThJV1EvVUQ2ZlA1bm14a2tSRStwMmg0RHJMOUZsaS9qRTFI?=
 =?utf-8?B?ZUFlM2FRZUpRYXY3TGRyeitMMm11WGgyMFB5UTJ2eFExTUpuRUhiczRTZlBm?=
 =?utf-8?B?TTFYTFljd1J6UXJ1OVRFNEo1VHUwcFJMeFcrU3BLZXNZSEVvSUVMaG1WaDYv?=
 =?utf-8?B?bjI2bU1QdW9xa0wzRkpnVE9lQ3NRSTZ5blV1dGhncjdRYlBlVy8rNVFyRS9W?=
 =?utf-8?B?Qm5GNDBOS0xXV09MZkVBTEFGVG14UXAxOERMVkk4QWlYc2RmajBNRmFXenRY?=
 =?utf-8?B?Vzg5K2FaZWJIMHdHTFMrYzc1RDFkUHpsS1d6S012elQ2SHB2alNnUkhFNWV6?=
 =?utf-8?B?ZzhDNTF0cDRoODllb3lCRElubWxFMWtHRmZNejRBMkh3SUg5d041ekhqR1dY?=
 =?utf-8?B?SHptbW5DUE5rejJSb29pbTUzU3hLUkJxTjhCd0pJMlZNSHlTbFNmbXQ3RUtj?=
 =?utf-8?B?Mm1iT2dBS3R6NGh2VkdLeGNwaFFsWUkwTTNSVVJBNDBadVhsRnZLR09GSEYx?=
 =?utf-8?B?YUdnK09OWVVsbnVwVjJHWE51MUJ3R2gzV1pFWEVWbmh6cUlqQlUxNTJZVzJw?=
 =?utf-8?B?aDhYNkE2a3ZxbzdLM05hajFpQW5Jc3RER1IwN3ZZcCsrTlc2dDl6RG5iNjVN?=
 =?utf-8?B?bU00VlRmQnlTUG1nekJYeC9DM1lEOUNPMVpPaUxkMUI4cUhCZUJGOWZ3OGsv?=
 =?utf-8?B?RFoyQnVBT1NxbzdsZFUxWituNXVWWFo1dmdVUkp5VkNscXd0TUdGNjVZSGQv?=
 =?utf-8?B?c2dScGUxUURPKzlseG1pekdWL2JGNHVvQldoRWE1eDdLLzNuT0VJUlRRTS8v?=
 =?utf-8?B?amZQQi9KbzM4dFc4M2t5UWJXb2ZVcGluajhxSWVmcGZ3R0tObWhsR0FXYitB?=
 =?utf-8?B?bWM4L0RUTEUrUWxvZUw3SUtISDVMM2xvdENOR0gzR3UrUGhIb1RUOVk3SWk1?=
 =?utf-8?B?ckdNbEVYYS8xVFRQeVRDNUlJNFlXbmZHNzJiL0ptcm9UN2tjRkhqbTc4V2cr?=
 =?utf-8?B?TjdKMGVaSUpDOWsxbExsRjhDM3UwSVNMbk9MNGFHa1F2M1QrdGNhUmtVbkNZ?=
 =?utf-8?B?UFYvakQxbllDNnM2WWJSYU1HSk1UT0FSUUlTOVNwY01qUHFZcnRQTDl5ckZy?=
 =?utf-8?B?OHZtNmJmaG1hZE5FVEw1YmR6WVZ5cWJGRjlrMjdoS2padHpJaG1kM3FjNzYr?=
 =?utf-8?B?QXIxdnVRMjBHVzdQbDdtTDJ4SC90dUlSZmdpUjBFOWtZSm50SFU5ZWhCZjhr?=
 =?utf-8?B?bTQxMDVja2RvQnlLNVB5MWtYTys0aXJaNGFBdW0rak5pV01BNTAramxFQTNL?=
 =?utf-8?B?R012akFjSjZFNk8rQlNFczFjcGc3QkJ1Zm5xZlJaUEgyNWppUi9RaGwzRDNi?=
 =?utf-8?B?OXB3cTJ0VTlLRng2Q25lNlZRaUtQMytLRmZEOHVPSTBZZjAxSW0zVHZJUS9w?=
 =?utf-8?B?ZWJWSHpUOUY3TUUzL2ZJZlQ2c09KeVVCNU5obHZHQnl6amtBUEoxSll5eVIv?=
 =?utf-8?B?VENWeHdMbUhuc0tJTUNvUnVpbnNDcXEyT2tQZTJsUis4TkVoWEJTR2QzYUJs?=
 =?utf-8?B?alJCMTVUT0Q2K3daN1ByVGdXaFNiYnR2bm1ZM1JCSU1IRXN6K1lLTTlYTzhr?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD47E0A1C44C3B4CAB121FF3BE5BFAEE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ta9ta7jn5moW5dFxpzHzCEv5LSkW5jZQIF9jReHkHxMQDpPe4IawIk2s19egDA94j+VEOceSw8DaMOjqncyezUKscCFrvtYjV7HkCmBbLvZZzIAq38dFNfNDYxTZCxcviSO9+gwNMP/lXLJt9JxPlx9792WH90FsVeq8MBk5AY7AVADH1CnWe/9sHrbgyz67MuxI8N4A1puVSg5yBPq8WRnds0fo4EI2xboogPoCZgAWlGzKWX3RICLsGz5ZkQ18Nz7Wt22jTdlcTonBAWFfM7BjJ1X93cki5EeVxeY1tD8A8keOgcdoFoYynzbEZbVNJFjvKTXz03FVc93oIlh7/wELLzopIkGde95vxIczKUfkkDteMHlf2RNA4jtR5FNj29Ez5GdqutV+7eRAWsrLG0qwuWzRHaBWElITQ3qS5T8MP0tcHG6xa6DVrjXuJrSNXKG6xT2PLiHQ/+QW4LJZadvuSG1xtpbmoOIozSk7pCIu8MbYBLE9NCwgsHbLDzvpgeJ+LoznB4dRCVmPWYblwChOTPxVl4A7e65OgwPdY2vfwuun9JgIbv1HA/LTfn2Si23YsnhT1e7+7/6FI0UortUKRWQZnjl0c+JZv+AT8Qw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a01ad3-f05f-42a7-e32b-08dc23f8f2df
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 14:12:11.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSeIM3NZCfEUYqk8wcL+Kpm7ymLKyC2/NwXEFhmGVFIi1UPKMEEIY8UOvym0loaWFv0ChzJ7By/f8vZRT49Rhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020103
X-Proofpoint-ORIG-GUID: -KHU2O_jeoRDbltx6Q50yWzqoHKK-f1U
X-Proofpoint-GUID: -KHU2O_jeoRDbltx6Q50yWzqoHKK-f1U

DQoNCj4gT24gRmViIDEsIDIwMjQsIGF0IDU6MjTigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNl
LmRlPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMDIgRmViIDIwMjQsIENodWNrIExldmVyIHdyb3Rl
Og0KPj4gUGFzc2VzIHB5bmZzLCBmc3Rlc3RzLCBhbmQgdGhlIGdpdCByZWdyZXNzaW9uIHN1aXRl
LiBQbGVhc2UgYXBwbHkNCj4+IHRoZXNlIHRvIG9yaWdpbi9saW51eC01LjQueS4NCj4gDQo+IEkg
c2hvdWxkIGhhdmUgbWVudGlvbmVkIHRoaXMgYSBkYXkgb3IgdHdvIGFnbyBidXQgSSBoYWRuJ3Qg
cXVpdGUgbWFkZQ0KPiBhbGwgdGhlIGNvbm5lY3Rpb24geWV0Li4uDQo+IA0KPiBUaGUgUkVMRUFT
RV9MT0NLT1dORVIgYnVnIHdhcyBtYXNraW5nIGEgZG91YmxlLWZyZWUgYnVnIHRoYXQgd2FzIGZp
eGVkDQo+IGJ5DQo+IENvbW1pdCA0NzQ0NmQ3NGYxNzAgKCJuZnNkNDogYWRkIHJlZmNvdW50IGZv
ciBuZnNkNF9ibG9ja2VkX2xvY2siKQ0KPiB3aGljaCBsYW5kZWQgaW4gdjUuMTcgYW5kIHdhc24n
dCBtYXJrZWQgYXMgYSBidWdmaXgsIGFuZCBzbyBoYXMgbm90IGdvbmUgdG8NCj4gc3RhYmxlIGtl
cm5lbHMuDQoNClRoZW4sIGluc3RydWN0aW9ucyB0byBzdGFibGVAdmdlci5rZXJuZWwub3JnOg0K
DQpEbyBub3QgYXBwbHkgdGhlIHBhdGNoZXMgSSBqdXN0IHNlbnQgZm9yIDUuMTUsIDUuMTAsIGFu
ZCA1LjQuIEkgd2lsbA0KYXBwbHkgNDc0NDZkNzRmMTcwLCBydW4gdGhlIHRlc3RzIGFnYWluLCBh
bmQgcmVzZW5kLg0KDQoNCj4gQW55IGtlcm5lbCBlYXJsaWVyIHRoYW4gdjUuMTcgdGhhdCByZWNl
aXZlcyB0aGUgUkVMRUFTRV9MT0NLT1dORVIgZml4DQo+IGFsc28gbmVlZHMgdGhlIG5mc2Q0X2Js
b2NrZWRfbG9jayBmaXguICBUaGVyZSBpcyBhIG1pbm9yIGZvbGxvdy11cCBmaXgNCj4gZm9yIHRo
YXQgbmZzZDRfYmxvY2tlZF9sb2NrIGZpeCB3aGljaCBDaHVjayBxdWV1ZWQgeWVzdGVyZGF5Lg0K
PiANCj4gVGhlIHByb2JsZW0gc2NlbmFyaW8gaXMgdGhhdCBhbiBuZnNkNF9sb2NrKCkgY2FsbCBm
aW5kcyBhIGNvbmZsaWN0aW5nDQo+IGxvY2sgYW5kIHNvIGhhcyBhIHJlZmVyZW5jZSB0byBhIHBh
cnRpY3VsYXIgbmZzZDRfYmxvY2tlZF9sb2NrLiAgQSBjb25jdXJyZW50DQo+IG5mc2Q0X3JlYWRf
bG9ja293bmVyIGNhbGwgZnJlZXMgYWxsIHRoZSBuZnNkNF9ibG9ja2VkX2xvY2tzIGluY2x1ZGlu
Zw0KPiB0aGUgb25lIGhlbGQgaW4gbmZzZDRfbG9jaygpLiAgbmZzZDRfbG9jayB0aGVuIHRyaWVz
IHRvIGZyZWUgdGhlDQo+IGJsb2NrZWRfbG9jayBpdCBoYXMsIGFuZCByZXN1bHRzIGluIGEgZG91
YmxlLWZyZWUgb3IgYSB1c2UtYWZ0ZXItZnJlZS4NCj4gDQo+IEJlZm9yZSBlaXRoZXIgcGF0Y2gg
aXMgYXBwbGllZCwgdGhlIGV4dHJhIHJlZmVyZW5jZSBvbiB0aGUgbG9jay1vd25lcg0KPiB0aGFu
IG5mc2Q0X2xvY2sgaG9sZHMgY2F1c2VzIG5mc2Q0X3JlYWxlYXNlX2xvY2tvd25lcigpIHRvIGlu
Y29ycmVjdGx5DQo+IHJldHVybiBhbiBlcnJvciBhbmQgTk9UIGZyZWUgdGhlIGJsb2Nrc19sb2Nr
Lg0KPiBXaXRoIG9ubHkgdGhlIFJFTEVBU0VfTE9DS09XTkVSIGZpeCBhcHBsaWVkLCB0aGUgZG91
YmxlLWZyZWUgaGFwcGVucy4NCg0KT3VyIHRlc3Qgc3VpdGUgY3VycmVudGx5IGRvZXMgbm90IGV4
ZXJjaXNlIHRoaXMgdXNlIGNhc2UsIGFwcGFyZW50bHkuDQpJIGRpZG4ndCBzZWUgYSBwcm9ibGVt
IGxpa2UgdGhpcyBkdXJpbmcgdGVzdGluZy4NCg0KDQo+IFdpdGggYm90aCBwYXRjaGVzIGFwcGxp
ZWQgdGhlIHJlZmNvdW50IG9uIHRoZSBuZnNkNF9ibG9ja2VkX2xvY2sgcHJldmVudHMNCj4gdGhl
IGRvdWJsZS1mcmVlLg0KPiANCj4gS2VybmVscyBiZWZvcmUgNC45IGFyZSAocHJvYmFibHkpIG5v
dCBhZmZlY3RlZCBhcyB0aGV5IGRpZG4ndCBoYXZlDQo+IGZpbmRfb3JfYWxsb2NhdGVfYmxvY2so
KSB3aGljaCB0YWtlcyB0aGUgc2Vjb25kIHJlZmVyZW5jZSB0byBhIHNoYXJlZA0KPiBvYmplY3Qu
ICBCdXQgdGhhdCBpcyBhbmNpZW50IGhpc3RvcnkgLSB0aG9zZSBrZXJuZWxzIGFyZSB3ZWxsIHBh
c3QgRU9MLg0KPiANCj4gVGhhbmtzLA0KPiBOZWlsQnJvd24NCj4gDQo+IA0KPj4gDQo+PiAtLS0N
Cj4+IA0KPj4gQ2h1Y2sgTGV2ZXIgKDIpOg0KPj4gICAgICBORlNEOiBNb2Rlcm5pemUgbmZzZDRf
cmVsZWFzZV9sb2Nrb3duZXIoKQ0KPj4gICAgICBORlNEOiBBZGQgZG9jdW1lbnRpbmcgY29tbWVu
dCBmb3IgbmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIoKQ0KPj4gDQo+PiBOZWlsQnJvd24gKDEpOg0K
Pj4gICAgICBuZnNkOiBmaXggUkVMRUFTRV9MT0NLT1dORVINCj4+IA0KPj4gDQo+PiBmcy9uZnNk
L25mczRzdGF0ZS5jIHwgNjUgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25z
KC0pDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KPj4gDQo+PiANCj4+IA0KPiANCg0KLS0N
CkNodWNrIExldmVyDQoNCg0K

