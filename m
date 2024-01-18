Return-Path: <linux-nfs+bounces-1201-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F017831BD8
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 15:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB1FB26C33
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A921DA44;
	Thu, 18 Jan 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZetjptT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lM3ICajI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F81DDC0
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jan 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589619; cv=fail; b=J4ATvhYh0+IfRlEMSTW3I+dMlBFTdyHP8tMGTrcURo/2Ke8TDED2fD+cNTGdxWsdZsRwQDJ7UyM5u0WvoHAwCb1ubK4eXwjyLhoNAnhgL1inUNMZ09bVPb5kdkjyTyClkSeFhP41xBNzDS2ebkH6w0VLsLZ6jgbZtTkYbyXpFrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589619; c=relaxed/simple;
	bh=tnYc1WEIWJMF4MhkUFh9M7nvg3Fx24i1frRbqNLSkvI=;
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
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=sX6Zq63VkFzbj19ZFMUVMdzzYD11LhgDuAQ36YXU7EZUPKCoC81+V10cJwU1hkGfg+y/qcsXL4VEbGlKF7llRdhq1BVd3fcMgq+zbYIJ9iANJkw/1nXsY5mn3Z5b/JcZFJZRlJ3bamgqgy+WGE4YHES7LDjWPxzWpzkziHy8hVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NZetjptT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lM3ICajI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40IEhnPk032239;
	Thu, 18 Jan 2024 14:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tnYc1WEIWJMF4MhkUFh9M7nvg3Fx24i1frRbqNLSkvI=;
 b=NZetjptTW6fOEjgIHVhr3TDRYRDVioqVMXQ4D+2aNzZUp7wtIGWDvwTM4XJRepL6YQny
 Mwm6onfQIJ36Dkp4p+VxzODuWRbma2XMVhD225G2MMzD+aKEmBOUB+uyDgG3xx96dYUE
 NAPbNQgnHUPotrbezP6q75c1Lr2d0F8cxUCxAXkANWzKDDnx/bojfHCrz/ThveijEvnz
 HGYpdqeM9miZdQfhb3/CWUSdEej2MtyjTyngVA3gcvlISwcUwb9x00iTtsiDh6MPuDY0
 TXmourwYL3hnbope/l/WteZtUEb0BIdR+mm6BRRXZ1xCgZ5yHOKr12oWUuruCLWQGd2c jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkm2htxpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 14:53:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40IERdUi009453;
	Thu, 18 Jan 2024 14:53:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyctwg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 14:53:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfVItLGMnmFTzjnmENeUDXtEuyJ8Qd8BoKbxfU5jVXH9JMMDCD463BCsnQe7EM6ugSRuogBEBa1zMHixl5F/s09NWkhXA9kmzDYSMreojn6U5abSMUw8T3LktmWxe9HftpT/ZPpz0T3SLvUWY3e9AyrGhfUsL1UBCEDJFQCnVyFFF9loed/XFepmZWDK1n2U6bDjYtWc1aM0u2/F7zUKaFFyhlneKV/f5LojrKdnM6VUr5YIZ8jS8A0+0cxoTzmfCfU670J8MYnWhUWce7JL+2KZHVuoW52oJ3NEzzzXnx5daH+cmJBWKHs6Cf+HF4PRZIF0FCOxUr5DAEcsXRUyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnYc1WEIWJMF4MhkUFh9M7nvg3Fx24i1frRbqNLSkvI=;
 b=Bq8/4pTIqj9wswkThq2wlnM7OAXqBCYyB+Cy3j4C1VD8A2gyYa7YHnj5t+ml6pd1KOiMO1QM3fSXqC83BK5J67EBu/81AFySUbzRSBf0ypfseOIoMZnMlI/OkOO6/Jtq4NxtlDXxKZevrCZ2QRmRDDEgIc04YEVRQW47uGLsAQwPMGgHz3GfFCmmMqJR4wOSAMzIdd2fXoObCu4L4QNbUQJGiykSTjY+6Mst0E8oAMrKh5hB0onf445cNlJiqySVcRpgfUonysg0Fv/Ds0nuyWbUEfWHtXnpZlWz9VrxxYoJVKQWXb08tPhGNCd2Jq1uXSi5TwkAH+nBxa30n4Ms2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnYc1WEIWJMF4MhkUFh9M7nvg3Fx24i1frRbqNLSkvI=;
 b=lM3ICajImTWrNBmm6o2P8+Rfo9XdiS5EFM6oX84QMlqcZJJzlk2gnbL7i31PnFc1WXccmbP7NoxZfFfzBtpiInImd/Aj8VLGTUUDvGPansfQJFES+rPMMesg/HxmzREOemoF05jHVzyg98pfRize1OZNnYJQYn7i7Xpg3ydnTsw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4189.namprd10.prod.outlook.com (2603:10b6:208:1de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:52:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4fce:4653:ef69:1b01]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4fce:4653:ef69:1b01%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 14:52:55 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Martin Wege <martin.l.wege@gmail.com>,
        Roland Mainz
	<roland.mainz@nrubsig.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>
Subject: Re: RFE: Linux nfsd's |ca_maxoperations| should be at *least* |64|
 ... / was: Re: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into
 tuneables ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
Thread-Topic: RFE: Linux nfsd's |ca_maxoperations| should be at *least* |64|
 ... / was: Re: kernel.org list issues... / was: Fwd: Turn NFSD_MAX_* into
 tuneables ? / was: Re: Increasing NFSD_MAX_OPS_PER_COMPOUND to 96
Thread-Index: 
 AQHaRbZPBYb+SPTdz0iA03bgLbzGobDX06gggAAF7ACAABEfgIAG7OYAgACC5ACAAFYTgA==
Date: Thu, 18 Jan 2024 14:52:55 +0000
Message-ID: <470318C6-3252-445F-94F3-DDB7727F84C7@oracle.com>
References: 
 <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <65a29ca8.6b0a0220.ad415.d6d8.GMR@mx.google.com>
 <CAKAoaQkZ+b7NfrVi=gu1vCJBvv10=k85bG_kZV9G3jE45OOquw@mail.gmail.com>
 <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org>
 <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com>
 <CAKAoaQny6G=JcKpJTYeLmNBEMgNkkc--T0Uvs1YbEX+JUD-PoA@mail.gmail.com>
 <CANH4o6NcMbcNKxARcqhthXWkKk6_r31iKGjnS-RhFBB_AJFaJg@mail.gmail.com>
In-Reply-To: 
 <CANH4o6NcMbcNKxARcqhthXWkKk6_r31iKGjnS-RhFBB_AJFaJg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4189:EE_
x-ms-office365-filtering-correlation-id: ce69a8e3-6266-4502-0073-08dc18352794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 D4obkfzQDaIKSs31CuVxuuN8yWA7/KuQGiR7TLkZu9nm6qdKJFdk8FXSr1GCwPoN8HJoHygOONqBEiu6tQlXKsB5eB1yM97l8BjZaHo2hyl/FQof/6hz0+Muyhqu5mp/D589bji+PG5/0zerktQiQToj7T+nba8KBTo8tnSy7HN2uPgD83qKMbDCL54q43qiIBzPdU/8jAaAFjeT2eX03THvHzb7xehS4+Jov4zoBBBq3mN/hpZEIhrVydlI445Jvfgg4T4D+jiZ7VMV1iqsQcSxmTEq7yl6mJ66dnFWxEsOC8/rRk3DL3SMCn0gq2GXgIP3JgSZk20st7hdA4Vd9NRH5mSHnYULbgSnvvDHkrjygfFqxpPCzUH9+wVOGadw0ZxevQQ3nVoe8aR7PSGUCkaqPkD8om6Mqz8ux6bNopciFeM2JvKffZwsdSFTYgDxC/T03y95g+pFmgBWczycygg4LG63rKBKTTuaYI9lYqbgOub5K21WciT9a7wPp+QtPYo409n2xr3l/74RU4hqHiYcYqIoCuU8fYjmCRrW4MCE6BIyNKCCWxUsrz9H2WRhGnkMb2lfw3MQBE1GaCZ08tadgZHrKssm/+N4p0C5jCFIaVlAVuTeluNIm1WjbuCsHmCRPnucRhUbY7UNDqX20Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66899024)(38100700002)(2906002)(122000001)(5660300002)(36756003)(41300700001)(38070700009)(86362001)(33656002)(6486002)(966005)(478600001)(26005)(6506007)(53546011)(6512007)(71200400001)(2616005)(8936002)(4326008)(8676002)(83380400001)(316002)(110136005)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cVJ1QnF4UXdmNkRONTZIYi9tbWV5K2EyNHVZY1AvNnppWFcxTG1KdXluK1E5?=
 =?utf-8?B?cU1mektaTXE0UVV0aGRFYVplY0VjVm9KQlluQURwQUpFWUFodThZYnRqTkFk?=
 =?utf-8?B?Y3gvcmtVVTJGcWdTNHhaZjIzbHlsMmh4RXByOUVvSGM3bEpLd3JkbU9GUlhV?=
 =?utf-8?B?YnhQY3R4QjBpYzNuNnBMWlB1ZmVhbXpia1hNRmpKbmkrZitGaStvQ0tGdWZu?=
 =?utf-8?B?a1pWRW1vanNmM0ZZMWltcWhjM0NzaUdldGNxZVFENUJXdVorRVlRcWhabDI3?=
 =?utf-8?B?NDBqSmUwMmprcWs0RG5QUU1NbHIzY0RtR0FOMnMvOTVVaGdIQWdnME9VL3Rj?=
 =?utf-8?B?MEVPRWp4UjZLMjI1eWk5ZmJnVGlBZk4zR0o0b3dDTC9nMjRUWVR3YnQ5aTV4?=
 =?utf-8?B?a2xJbGc1bStRZTBCdG42UlVDYk5wRzc1aGViSnR6bXdIV0RhZ3kwY0pMUXBY?=
 =?utf-8?B?bFk2RG8wdDgxZjE0T0creFRteVFoWjRCK1RSRGtvZTRzaElSQjVTSG91a3FZ?=
 =?utf-8?B?RVNHWGRQbENxMThJT0oxQmIrUVF0UWVwR0JOZkUyNHVSOFVRc2trSGpQWG1Z?=
 =?utf-8?B?dnFYTVVIRVJ1a1VwVlEvUFZWTGxVVzZMdnoxY2dzQTV1aXBoNi9IQlBzam1D?=
 =?utf-8?B?SFU5MUpiNkJOWUIrZGJWamwxQUhpbkRaNXJwcC9aL245ODJkVVg2V0owZXFK?=
 =?utf-8?B?V2NFbmQ4MkVNTkhxQ3RaYlB1dEJ5Z0pBMWJsb0hsWTRTYjZyVE9vZXJGc1ps?=
 =?utf-8?B?b3hqa2VLank0WlhtQ3FWdmowRHQ1MHNoTDVYRVdEU3RqaXBTblRDS1A0WC9u?=
 =?utf-8?B?SmFiUjloUGE5eCtmWkVLY3JBOC9iMWUvM1EybDhvcGE4bllacHMzQ2J1RS8v?=
 =?utf-8?B?RFN1akw5RUpBdWNWakdhZ3ZMbWg1dXJ0Z2g4eDdCOUIzNDdQVUVQbE9hVzNM?=
 =?utf-8?B?V0NjS3BreUVxSTZMY21BWFpRMXdwZ3gvMWFIb09vWkUvTThYNjRSUEpoUnNS?=
 =?utf-8?B?enhKVmFsbDYxYzBTNklvdGRac3pOYU80ejdTWHBZM1Q5RHRWUlZVVzNQY0c5?=
 =?utf-8?B?QWdnalNOK2IxWWd0SHE4OWV5bDBQQ2ZEQ052OUFlWGswR1Fha1YvOG4xZnN4?=
 =?utf-8?B?bTkzc21TOTdGeUxEMjhBNDl2cFZ4ZXovcFlzMXpYNWNOSzFZQnJnMU1TSzU4?=
 =?utf-8?B?TzFRaGpMbldWYXBDSkw2Z0dLUGRWRWVhK3E1NHNYL3RkQW1LOXdMYWJhODh0?=
 =?utf-8?B?ZlNUUDhjZXVGRnhITzZWR2t4T0UzRyttRXJ6NXFnTk9DL2tLb2p1VjZKVDRE?=
 =?utf-8?B?KzF0L0JQNzJpT3gzNXdRaFI4YUV1Q1dyOHoxTCs0dHVZaVlRTk03Sk04ak5W?=
 =?utf-8?B?Tjh0UXlvT3Y2L2hBb0g3TDFnOTE0RnVWeWZHaDZVQ0JOdmozR3ZOY0RvK2gy?=
 =?utf-8?B?VWtac1FLcVVlS2kvUkw0YnNLaFpEeUVLaG9ZZHd0a1A0U2hkWlh2SU1rRzJK?=
 =?utf-8?B?eXQwTXBNYTJuVmRGNE9UTHV4Q0RVNEtrNnFwdjAwWUEyQmIwRm1nR2xOellu?=
 =?utf-8?B?RndhMHQrSTQxQXZnb25xQ09lS0pmZTVTQzBmRHkrRFUvbERPMjcrcEhWNTF0?=
 =?utf-8?B?ekxqb2Mxd0tRRTh3MlpIUDVXOXQ2cys0SGNndko4YnlJVkxrVkNldlpndVdy?=
 =?utf-8?B?YnpLTjZTT3hYaFZ3cXQycmY3VjVwTFl6Y3R6amRrZmhkSHJ6WVJLZDU1UFUx?=
 =?utf-8?B?bXF0YmYvVDA2SS8vU0xEYnEwZnRvN0QxSU0ySndST0dFdU9nd0NWSStaZWtP?=
 =?utf-8?B?T2NSUHA1ZGdidnhSc3BuWjJwNFUxdGVKdVo4U2ZhQkRHc3BuMnR1MlJ5aDlL?=
 =?utf-8?B?WjgyR1BMcWRCZTFKR0krRXVlUU5yZ0tOMzc0czRjY09ZVVVZWHV2RnZsZjdG?=
 =?utf-8?B?Y213OFU0emJPdXdFOFIveFVpSzNWOWtMMnd5RFFXeW4vc0NodDBTMHF2UXBx?=
 =?utf-8?B?dTZmMlNrVmVIR0UzNmRJVlF1REh6MnZTV1RzcTFld3Z6NWx1dkNLb3QycjNh?=
 =?utf-8?B?WU5zRjJCVHVhelM3aWNYYkRIcXBSTk9iZE9BNTdzZk5LYUREcW91cktOTlJh?=
 =?utf-8?B?UHpKY0RPZEwxY1gya2ZKOFVQd3I0K2VaK2dtOGFDTHRpc0F4K2paOExaQTVv?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D21DC1995FE68469C9122DBEB9D19E8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hj/d8KtplTTCssF/YoY+nwDxGDLG0cVUQ7sK3a5VaMO2HyOOwsjZy6vMsTuYx41tGy854/Smj2KVmpC8iPWcTvS/ZUANnQI4RPvZz+kdNj90iconIs0uzJdDVw7sYu35SHuoVAwZyg5coY4ZEA2cet4Ktr4VlJNr6BpTzXHBf+IseQTMzugl0css3iXhPyRCgdnZxsnCDqYuZn2f8bZQqoKv28Ybvkst1F6cio9Bj3j9htohr8EsUm2gYpwMt1blqOvD7AhEkCrd8OJUuHI1Iy8dFnlihzDlyQcXbv3bdOsj7QE3rnisbxDYzweVry23ATexM2qVWLgGui5M6T1E24UeTDbP0+WgVKrMNwTfYUf7A8LJVK5GnkTUtmNdxtVIAUwjKVf+vmg0M7+STQGweiRYOZvjkwe8nsxiAI3e2UO5FGVkAiYiRKxwS6fj7JXP5kxMKqi84xyhnannpKb23nnurYw5URjPFpv7oBqOKhpx0O+EUfudxpcHMMw15Feu4TG8DZSxjGtORwze5N+Rpj6XpZp4Ux4tESbnXhUNozs8Ld8D12KZ+RlrAwHdTOvKlIvuN0i2CqK54Osm896vHkPUVCoGvDMbVRB+t7E6fBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce69a8e3-6266-4502-0073-08dc18352794
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 14:52:55.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCLOpfejkjU/T2GWuOk8fzmW7PX3kYtKs81r4HBxjvmpGbXT19t1Y1dSVFIKHWtvSWPt5KUBuS/mFe+eZo+aOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180108
X-Proofpoint-GUID: S85mAmLPuImRuuyK9rAj1UpKYJ6-8lYO
X-Proofpoint-ORIG-GUID: S85mAmLPuImRuuyK9rAj1UpKYJ6-8lYO

DQo+IE9uIEphbiAxOCwgMjAyNCwgYXQgNDo0NOKAr0FNLCBNYXJ0aW4gV2VnZSA8bWFydGluLmwu
d2VnZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKYW4gMTgsIDIwMjQgYXQgMjo1
N+KAr0FNIFJvbGFuZCBNYWlueiA8cm9sYW5kLm1haW56QG5ydWJzaWcub3JnPiB3cm90ZToNCj4+
IA0KPj4gT24gU2F0LCBKYW4gMTMsIDIwMjQgYXQgNToxMOKAr1BNIENodWNrIExldmVyIElJSSA8
Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+IE9uIEphbiAxMywgMjAyNCwgYXQg
MTA6MDnigK9BTSwgSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+
IE9uIFNhdCwgMjAyNC0wMS0xMyBhdCAxNTo0NyArMDEwMCwgUm9sYW5kIE1haW56IHdyb3RlOg0K
Pj4+Pj4gT24gU2F0LCBKYW4gMTMsIDIwMjQgYXQgMToxOeKAr0FNIERhbiBTaGVsdG9uIDxkYW4u
Zi5zaGVsdG9uQGdtYWlsLmNvbT4gd3JvdGU6DQo+PiBbc25pcF0NCj4+Pj4+IElzIHRoaXMgdGhl
IHdpbmRvd3MgY2xpZW50Pw0KPj4+PiBObywgdGhlIG1zLW5mczQxLWNsaWVudCAoc2VlDQo+Pj4+
IGh0dHBzOi8vZ2l0aHViLmNvbS9rb2ZlbWFubi9tcy1uZnM0MS1jbGllbnQpIHVzZXMgYSBsaW1p
dCBvZiB8MTZ8LCBidXQNCj4+Pj4gaXQgaXMgb24gb3VyIFRvRG8gbGlzdCB0byBidW1wIHRoYXQg
dG8gfDEyOHwgKGJ1dCBob25vcmluZyB0aGUgbGltaXQNCj4+Pj4gc2V0IGJ5IHRoZSBORlN2NC4x
IHNlcnZlciBkdXJpbmcgc2Vzc2lvbiBuZWdvdGlhdGlvbikgc2luY2UgaXQgbm93DQo+Pj4+IHN1
cHBvcnRzIHZlcnkgbG9uZyBwYXRocyAoWzFdKSBhbmQgdGhpcyBpc3N1ZSBpcyBhIGtub3duIHBl
cmZvcm1hbmNlDQo+Pj4+IGJvdHRsZW5lY2suDQo+Pj4gDQo+Pj4gQSBiZXR0ZXIgd2F5IHRvIG9w
dGltaXplIHRoaXMgY2FzZSBpcyB0byB3YWxrIHRoZSBwYXRoIG9uY2UNCj4+PiBhbmQgY2FjaGUg
dGhlIHRlcm1pbmFsIGNvbXBvbmVudCdzIGZpbGUgaGFuZGxlLiBUaGlzIGlzIHdoYXQNCj4+PiBM
aW51eCBkb2VzLCBhbmQgaXQgc291bmRzIGxpa2UgRGFuJ3MgZGlyZWN0b3J5IHdhbGtlcg0KPj4+
IG9wdGltaXphdGlvbnMgZG8gZWZmZWN0aXZlbHkgdGhlIHNhbWUgdGhpbmcuDQo+PiANCj4+IFRo
YXQgYXNzdW1lcyB0aGF0IG5vIHByb2Nlc3MgZG9lcyByYW5kb20gYWNjZXNzIGludG8gZGVlcCBz
dWJkaXJzLiBJbg0KPj4gdGhhdCBjYXNlIHRoZSBwZXJmb3JtYW5jZSBpcyBhYnNvbHV0ZWx5IHRl
cnJpYmxlLCB1bmxlc3MgeW91IGRldm90ZQ0KPj4gbG90cyBvZiBtZW1vcnkgdG8gYSBnaWFudCBj
YWNoZSAod2hpY2ggaXMgbm90IGZlYXNpYmxlIGR1ZSB0byBjYWNoZQ0KPj4gZXhwaXJhdGlvbiBs
aW1pdHMsIHVubGVzcyBzb21lb25lIChwbGVhc2UhKSBmaW5hbGx5IGltcGxlbWVudHMNCj4+IGRp
cmVjdG9yeSBkZWxlZ2F0aW9ucykuDQoNCkRvIHlvdSBtZWFuIG5vdCBmZWFzaWJsZSBmb3IgeW91
ciBjbGllbnQ/IExvb2t1cCBjYWNoZXMNCmhhdmUgYmVlbiBwYXJ0IG9mIG9wZXJhdGluZyBzeXN0
ZW1zIGZvciBkZWNhZGVzLiBTb2xhcmlzLA0KRnJlZUJTRCwgYW5kIExpbnV4IGFsbCBoYXZlIG9u
ZS4gRG9lcyB0aGUgV2luZG93cyBrZXJuZWwNCmhhdmUgb25lIHRoYXQgbWZzLW5mczQxLWNsaWVu
dCBjYW4gdXNlPw0KDQoNCj4+IFRoaXMgYWxzbyBpZ25vcmVzIHRoZSB1c2UgY2FzZSBvZiBXQU4g
KHdpZGUtYXJlYS1uZXR3b3JrcykgYW5kIFdMQU4NCj4+IHdpdGggdGhlIHR5cGljYWwgaGlnaCBs
YXRlbmN5IGFuZCBldmVuIGhpZ2hlciBhbW91bnRzIG9mIG5ldHdvcmsNCj4+IHBhY2thZ2UgbG9z
cyYmcmV0cmFuc21pdCwgd2hlcmUgdGhlIHNwbGl0dGluZyBvZiB0aGUgcmVxdWVzdHMgY29tZXMN
Cj4+IHdpdGggYSBIVUdFIGxhdGVuY3kgcGVuYWx0eSAoeW91IGNhbiByZXByb2R1Y2UgdGhpcyB3
aXRoIG5ldHdvcmsNCj4+IHRvb2xzLCBqdXN0IGV4cG9ydCBhIGxhcmdlIHRtcGZzIG9uIHRoZSBz
ZXJ2ZXIsIGFkZCBhIHBhY2thZ2UgZGVsYXkgb2YNCj4+IDQwMG1zIGJldHdlZW4gY2xpZW50IGFu
ZCBzZXJ2ZXIsIHVzZSBhIHBhdGggbGlrZQ0KPj4gImEvYi9jL2QvZS9mL2cvaC9pL2ovay9sL20v
bi9vL3AvcS9yL3MvdC91L3Yvdy94L3kvei8wLzEvMi8zLzQvNS82LzcvOC85IiwNCj4+IGFuZCBj
b21waWxlIGdjYykuDQoNClRoZSBtb3N0IGZyZXF1ZW50bHkgaW1wbGVtZW50ZWQgc29sdXRpb24g
dG8gdGhpcyBwcm9ibGVtDQppcyBhIGxvb2t1cCBjYWNoZS4gT3BlcmF0aW5nIHN5c3RlbXMgdXNl
IGl0IGZvciBsb2NhbA0Kb24tZGlzayBmaWxlc3lzdGVtcyBhcyB3ZWxsIGFzIGZvciBORlMuDQoN
CkluIHRoZSBsb2NhbCBmaWxlc3lzdGVtIGNhc2U6DQoNClRoaW5rIGFib3V0IGhvdyBsb25nIGVh
Y2ggcGF0aCByZXNvbHV0aW9uIHdvdWxkIHRha2UgaWYNCnRoZSBvcGVyYXRpbmcgc3lzdGVtIGhh
ZCB0byBjb25zdWx0IG9uLWRpc2sgaW5mb3JtYXRpb24NCmZvciBldmVyeSBjb21wb25lbnQgaW4g
dGhlIHBhdGhuYW1lLg0KDQpJbiB0aGUgTkZTIGNhc2U6DQoNClRoZSBmYXN0ZXN0IHJvdW5kIHRy
aXAgaXMgbm8gcm91bmQgdHJpcC4gS2VlcCBhIGxvY2FsDQpjYWNoZSBhbmQgcGF0aCByZXNvbHV0
aW9uIHdpbGwgYmUgZmFzdCBubyBtYXR0ZXIgd2hhdA0KdGhlIG5ldHdvcmsgbGF0ZW5jeSBpcy4N
Cg0KTm90ZSB0aGF0IHRoZSBORlMgc2VydmVyIGlzIGdvaW5nIHRvIHVzZSBhIGxvb2t1cCBjYWNo
ZQ0KdG8gbWFrZSBsYXJnZSBwYXRoIHJlc29sdXRpb24gQ09NUE9VTkRzIGdvIGZhc3QuIEl0DQp3
b3VsZCBiZSBldmVuIGZhc3RlciAoZnJvbSB0aGUgYXBwbGljYXRpb24ncyBwb2ludCBvZg0Kdmll
dykgaWYgdGhhdCBjYWNoZSB3ZXJlIGxvY2FsIHRvIHRoZSBjbGllbnQuDQoNClNlbmRpbmcgYSBm
dWxsIHBhdGggaW4gYSBzaW5nbGUgQ09NUE9VTkQgaXMgb25lIHdheSB0bw0KaGFuZGxlIHBhdGgg
cmVzb2x1dGlvbiwgYnV0IGl0IGhhcyBzbyBtYW55IGxpbWl0YXRpb25zDQp0aGF0IGl0J3MgcmVh
bGx5IG5vdCB0aGUgbWVjaGFuaXNtIG9mIGNob2ljZS4NCg0KDQo+PiBBbmQgaW4gdGhlIHJlYWwg
d29ybGQgdGhlIExpbnV4IG5mc2QgfGNhX21heG9wZXJhdGlvbnN8IGRlZmF1bHQgb2YNCj4+IHwx
NnwgaXMgYWJzb2x1dGVseSBDUklQUEVMSU5HLg0KPj4gRm9yIGV4YW1wbGUgaW4gdGhlIG1mcy1u
ZnM0MS1jbGllbnQgd2UgbmVlZCA0IGNvbXBvdW5kcyBmb3IgaW5pdGlhbA0KPj4gc2V0dXAgZm9y
IGEgZmlsZSBsb29rdXAsIGFuZCB0aGVuIDMgcGVyIHBhdGggY29tcG9uZW50LiBUaGF0IG1lYW5z
DQo+PiB0aGF0IGEgZGVmYXV0IG9mIDE2IGp1c3QgZml0cyAoMTYtNCkvMz00IHBhdGggZWxlbWVu
dHMuDQo+PiBVbmZvcnR1bmF0ZWx5IHRoZSBzdGF0aXN0aWNhbCBhdmVyYWdlIGlzIG5vdCA0IC0g
aXQncyAxMSAobWVhc3VyZWQNCj4+IG92ZXIgZml2ZSB3ZWVrcyB3aXRoIDgxIGNsaWVudHMgaW4g
b3VyIGNvbXBhbnkpLg0KPj4gVGVjaG5pY2FsbHksIGluIHRoaXMgc2NlbmFyaW8sIGEgZGVmYXVs
dCBvZiBhdCBsZWFzdCAxMSozKzQ9Mzcgd291bGQNCj4+IGJlIE1VQ0ggYmV0dGVyLg0KPj4gDQo+
PiBUaGF0J3Mgd2h5IEkgdGhpbmsgbmZzZCdzIHxjYV9tYXhvcGVyYXRpb25zfCBzaG91bGQgYmUg
YXQgKmxlYXN0KiB8NjR8Lg0KPiANCj4gKzENCj4gDQo+IEkgY29uc2lkZXIgdGhlIGRlZmF1bHQg
dmFsdWUgb2YgMTYgZXZlbiBhIGJ1ZywgZ2l2ZW4gdGhlIGNpcmN1bXN0YW5jZXMuDQoNClRoaXMg
aXMgbm90IGFuIE5GU0QgYnVnLiBSZWFkIHRvIHRoZSBib3R0b20gdG8gc2VlIHdoZXJlDQp0aGUg
cmVhbCBwcm9ibGVtIGlzLg0KDQpIZXJlIGFyZSB0aGUgQ1JFQVRFX1NFU1NJT04gYXJndW1lbnRz
IGZyb20gYSBMaW51eCBjbGllbnQ6DQoNCiAgICAgICAgICAgICAgICBjc2FfZm9yZV9jaGFuX2F0
dHJzDQogICAgICAgICAgICAgICAgICAgIGhkciBwYWQgc2l6ZTogMA0KICAgICAgICAgICAgICAg
ICAgICBtYXggcmVxIHNpemU6IDEwNDk2MjANCiAgICAgICAgICAgICAgICAgICAgbWF4IHJlc3Ag
c2l6ZTogMTA0OTQ4MA0KICAgICAgICAgICAgICAgICAgICBtYXggcmVzcCBzaXplIGNhY2hlZDog
NzU4NA0KICAgICAgICAgICAgICAgICAgICBtYXggb3BzOiA4DQogICAgICAgICAgICAgICAgICAg
IG1heCByZXFzOiA2NA0KICAgICAgICAgICAgICAgIGNzYV9iYWNrX2NoYW5fYXR0cnMNCiAgICAg
ICAgICAgICAgICAgICAgaGRyIHBhZCBzaXplOiAwDQogICAgICAgICAgICAgICAgICAgIG1heCBy
ZXEgc2l6ZTogNDA5Ng0KICAgICAgICAgICAgICAgICAgICBtYXggcmVzcCBzaXplOiA0MDk2DQog
ICAgICAgICAgICAgICAgICAgIG1heCByZXNwIHNpemUgY2FjaGVkOiAwDQogICAgICAgICAgICAg
ICAgICAgIG1heCBvcHM6IDINCiAgICAgICAgICAgICAgICAgICAgbWF4IHJlcXM6IDE2DQoNClRo
ZSBjYV9tYXhvcGVyYXRpb25zIGZpZWxkIGNvbnRhaW5zIDguDQoNClRoZSByZXNwb25zZSBmcm9t
IE5GU0QgbG9va3MgbGlrZSB0aGlzOg0KDQogICAgICAgICAgICAgICAgY3NyX2ZvcmVfY2hhbl9h
dHRycw0KICAgICAgICAgICAgICAgICAgICBoZHIgcGFkIHNpemU6IDANCiAgICAgICAgICAgICAg
ICAgICAgbWF4IHJlcSBzaXplOiAxMDQ5NjIwDQogICAgICAgICAgICAgICAgICAgIG1heCByZXNw
IHNpemU6IDEwNDk0ODANCiAgICAgICAgICAgICAgICAgICAgbWF4IHJlc3Agc2l6ZSBjYWNoZWQ6
IDIxMjgNCiAgICAgICAgICAgICAgICAgICAgbWF4IG9wczogOA0KICAgICAgICAgICAgICAgICAg
ICBtYXggcmVxczogMzANCiAgICAgICAgICAgICAgICBjc3JfYmFja19jaGFuX2F0dHJzDQogICAg
ICAgICAgICAgICAgICAgIGhkciBwYWQgc2l6ZTogMA0KICAgICAgICAgICAgICAgICAgICBtYXgg
cmVxIHNpemU6IDQwOTYNCiAgICAgICAgICAgICAgICAgICAgbWF4IHJlc3Agc2l6ZTogNDA5Ng0K
ICAgICAgICAgICAgICAgICAgICBtYXggcmVzcCBzaXplIGNhY2hlZDogMA0KICAgICAgICAgICAg
ICAgICAgICBtYXggb3BzOiAyDQogICAgICAgICAgICAgICAgICAgIG1heCByZXFzOiAxNg0KDQpU
aGUgY2FfbWF4b3BlcmF0aW9ucyBmaWVsZCBhZ2FpbiBjb250YWlucyA4Lg0KDQpIZXJlJ3Mgd2hh
dCBSRkMgODg4MSBTZWN0aW9uIDE4LjM2LjMgc2F5czoNCg0KPiBjYV9tYXhvcGVyYXRpb25zOg0K
PiAgICAgVGhlIG1heGltdW0gbnVtYmVyIG9mIG9wZXJhdGlvbnMgdGhlIHJlcGxpZXIgd2lsbCBh
Y2NlcHQNCj4gICAgIGluIGEgQ09NUE9VTkQgb3IgQ0JfQ09NUE9VTkQuIEZvciB0aGUgYmFja2No
YW5uZWwsIHRoZQ0KPiAgICAgc2VydmVyIE1VU1QgTk9UIGNoYW5nZSB0aGUgdmFsdWUgdGhlIGNs
aWVudCBvZmZlcnMuIEZvcg0KPiAgICAgdGhlIGZvcmUgY2hhbm5lbCwgdGhlIHNlcnZlciBNQVkg
Y2hhbmdlIHRoZSByZXF1ZXN0ZWQNCj4gICAgIHZhbHVlLiBBZnRlciB0aGUgc2Vzc2lvbiBpcyBj
cmVhdGVkLCBpZiBhIHJlcXVlc3RlciBzZW5kcw0KPiAgICAgYSBDT01QT1VORCBvciBDQl9DT01Q
T1VORCB3aXRoIG1vcmUgb3BlcmF0aW9ucyB0aGFuDQo+ICAgICBjYV9tYXhvcGVyYXRpb25zLCB0
aGUgcmVwbGllciBNVVNUIHJldHVybg0KPiAgICAgTkZTNEVSUl9UT09fTUFOWV9PUFMuDQoNClRo
ZSBCQ1AgMTQgIk1BWSIgaGVyZSBtZWFucyB0aGF0IHNlcnZlcnMgY2FuIHJldHVybiB0aGUgc2Ft
ZQ0KdmFsdWUsIGJ1dCBjbGllbnRzIGhhdmUgdG8gZXhwZWN0IHRoYXQgYSBzZXJ2ZXIgbWlnaHQg
cmV0dXJuDQpzb21ldGhpbmcgZGlmZmVyZW50Lg0KDQpGdXJ0aGVyLCB0aGUgc3BlYyBkb2VzIG5v
dCBwZXJtaXQgYW4gTkZTIHNlcnZlciB0byByZXNwb25kIHRvDQphIENPTVBPVU5EIHdpdGggbW9y
ZSB0aGFuIHRoZSBjbGllbnQncyBjYV9tYXhvcGVyYXRpb25zIGluDQphbnkgd2F5IG90aGVyIHRo
YW4gdG8gcmV0dXJuIE5GUzRFUlJfVE9PX01BTllfT1BTLiBTbyBpdA0KY2Fubm90IHJldHVybiBh
IGxhcmdlciBjYV9tYXhvcGVyYXRpb25zIHRoYW4gdGhlIGNsaWVudCBzZW50Lg0KDQpORlNEIHJl
dHVybnMgdGhlIG1pbmltdW0gb2YgdGhlIGNsaWVudCdzIG1heC1vcHMgYW5kIGl0cyBvd24NCk5G
U0RfTUFYX09QU19QRVJfQ09NUE9VTkQgdmFsdWUsIHdoaWNoIGlzIDUwLiBUaHVzIE5GU0Qgd2ls
bA0KcmV0dXJuIHRoZSBzYW1lIHZhbHVlIGFzIHRoZSBjbGllbnQsIHVubGVzcyB0aGUgY2xpZW50
IGFza3MNCmZvciBtb3JlIHRoYW4gNTAuDQoNClNvLCB0aGUgb25seSByZWFzb24gTkZTRCByZXR1
cm5zIDE2IHRvIHlvdXIgY2xpZW50IGlzIGJlY2F1c2UNCnlvdXIgY2xpZW50IHNldHMgYSB2YWx1
ZSBvZiAxNiBpbiBpdHMgQ1JFQVRFX1NFU1NJT04gQ2FsbC4gSWYNCnlvdXIgY2xpZW50IHNlbnQg
YSBsYXJnZXIgdmFsdWUgKGxpa2UsIDExKjMrNCksIHRoZW4gTkZTRCB3aWxsDQpyZXNwZWN0IHRo
YXQgbGltaXQgaW5zdGVhZC4NCg0KVGhlIHNwZWMgaXMgdmVyeSBjbGVhciBhYm91dCBob3cgdGhp
cyBuZWVkcyB0byB3b3JrLCBhbmQNCk5GU0QgaXMgMTAwJSBjb21wbGlhbnQgdG8gdGhlIHNwZWMg
aGVyZS4gSXQncyB0aGUgY2xpZW50IHRoYXQNCmhhcyB0byByZXF1ZXN0IGEgbGFyZ2VyIGxpbWl0
Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

