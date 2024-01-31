Return-Path: <linux-nfs+bounces-1627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260F7844307
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 16:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28A02876CC
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F0F82862;
	Wed, 31 Jan 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lbBdeXDJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jowCsCbQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6B84A2E
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714928; cv=fail; b=q167i42DhW4+ghgndkYClbSNzbPtCHdBriuXWUeC+ezvClACY7a0bM+0sWRmoLP2ARqGSkC1a9EVuvlRIwMXMJHmEn1lYM6WdtkNBGcfSTwcNYu2ZKJ09vKV7UIBcqGM6LF7k15Mvh7VF7h9nKHsDPI6AuT1QL4DTFFTal18X7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714928; c=relaxed/simple;
	bh=sanWaLAi3CEPnHJWdm6EqZ6eFWXCp2W1U0u1il0gGpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UTtHxt/0X8xXFhRPfhImKPDBlYvNOuOKgRd/jip307DZ3AWZLfAkn7Qxzkt4b8OMcj+6R3IRXDPV9A8W8UfS0CTTvTGQIvnvfO0FDqKftPvmKWccGkw7YJ1Rw36NirtwNxTC2/vit+hYgxXbbq8fk/ZiFnFXs7C9qzZ9/dKS3DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lbBdeXDJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jowCsCbQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEwwkh026746;
	Wed, 31 Jan 2024 15:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=sanWaLAi3CEPnHJWdm6EqZ6eFWXCp2W1U0u1il0gGpA=;
 b=lbBdeXDJCYDPKMAP0wojcRC/uPMU11I7bv/D3IpjnIwHqL3yO8qeUDHsT7safNCNAZ7/
 l2yYRhr9DLaR00rCWYMxhNxyPanOIB7jguNB5v/WQHdX330XJt9f3coV/wqEDpQyQWW5
 QTNEUEVRa2FoXWSk4gZJEeRLjYn0ZcmoTHu2a1ORYmyZPXrdMVqF5Jgw6nw9ZBq3uwtO
 xXVndYJ9VaIsytK5V3fBdHOzloWa0AlyHdnYHjuHnwuPqMEJsayCKmtcVFerVhWZ6x/b
 1Ymnfv2a7uix0qGlvfFbgJ4iNvds+EwIQ+kdiim/aZKh0x79IF0n8hlXecQ9zyD8dcCq yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseuj23h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 15:28:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VE8V12016227;
	Wed, 31 Jan 2024 15:28:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9f80c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 15:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqGajfgH8naogw6GjOeuf471pMcKgJtFh1PvKlmj7f4/uY5Ted5nZlHFXHbYR04rLg9alKHpB428oCvrZWec0sWflgYEW5uzhREFEXOerHt2pkl6fBmwe0Riijrz95qq5dNdYhsVUd4JlTMwDwosaqzGolMXYad9FL1hvFrRrPgH7dLwlziyyAXTb2pocyW1Id6UW1JnfZOI9vhsNIWPlE9ieOow4BZkaeiDA6crf2ewJEm3VyvvqU5GR0GMGVA+4MeAaX5lDS9R5hAHb2YeXLggBASSiBH2KrLuPyrcElIgt6TSW/Pd/gcuDz0QB8RFnTyDJAS5S2UFL7uFg6/vHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sanWaLAi3CEPnHJWdm6EqZ6eFWXCp2W1U0u1il0gGpA=;
 b=NobN63JHTPVEAOJqnLBfU4NOrS9vYVqDVgvKLFUTR9H8FYE7PmYRen10SKO32pawxWHcH2y3Gbi7fm8S7CdH5m7k1O6QaCcyLue6VTHy6NgAZUUWtbye4rZG5hZ1SriUdUo+vSVevfGSLSXnI3z2naBmk1eEooHEcPU04aVtsyE43IzGkUDvINS+/ydVKH6oZjzhH2oHGS3+OMai4EUarivLohIvzY6Jfj6tCqLc+ewFYe+tZg3JY2AuUPI5W0tczN6keRwlhgaItNdZvpg85UWAWsXHrHQdGxBB9qqrNtxbmOzi9kgB9I9zRHFwC+l2h+scuSQ3BxpQd7NRA1tSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sanWaLAi3CEPnHJWdm6EqZ6eFWXCp2W1U0u1il0gGpA=;
 b=jowCsCbQoXr7R+l7onV348Ub4lxiqhjq6a85N4j5R7hkDVp86HrFxwLnYYWKdlaUUPw7IOS/0ANKuSXEun065EsETyKOy6aYUqWhiW3Vw2joQwDIiERjJ1zw6NjsH2XOC9s9mvi0Aq8lPrp+z2gv18pvNaRvEEHRqSZ5e4pgavk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4241.namprd10.prod.outlook.com (2603:10b6:a03:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 15:28:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 15:28:12 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Christoph Hellwig
	<hch@lst.de>,
        Tom Haynes <loghyr@gmail.com>
Subject: Re: [PATCH 00/13 v5] nfsd: support admin-revocation of v4 state
Thread-Topic: [PATCH 00/13 v5] nfsd: support admin-revocation of v4 state
Thread-Index: AQHaUxk7wGN7tvGXvUKqh2ZOM3rmurD0DfUA
Date: Wed, 31 Jan 2024 15:28:12 +0000
Message-ID: <8E9CBF06-BB68-4498-A4C4-B46FF60F6438@oracle.com>
References: <20240130011102.8623-1-neilb@suse.de>
In-Reply-To: <20240130011102.8623-1-neilb@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4241:EE_
x-ms-office365-filtering-correlation-id: f56f720e-a147-4678-420f-08dc22713cf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 O9VtL4xaCNVmsfiBi6V6cMkDXHKrjc9oBMrW/YgygNiBMInPkqHcgU6yLRJ8PU3BhjGmw/+XiY/ZtXeM/zv991PULcbm9uXLabCLDMYT+Dza/y5KyRM21qbaP2UOo8feCE46M2sCMcwfdTCQlqLyXoS08KPJy8UaxKQIibnBdmwv+vUJWW5eBbsDVsEeRP2Ige8AAXT59Njy6dps/4kvAKZZLn3nfqMlGH0zpNCKeTNZfRoKytkokqnAvBloLRvg9Ced0Zho2s+hmGb3uuxFv0CkG+DzNoGnFXg4Vi5CeLvOMWeu2Z/ZRBZ0hOglJu5cXQPAdJzEgxAuqF9xMoHjQrGum/MoFEvUJNNytmR+tLOuNexrqXxE2hiDf5OGpCrb79w5EvVAmGBndejPjKqS/M33ui6EMu35zrkzctaZOCts7sI3xbH8Dbg5/rvibRd4artNDkgPEK6wYslPZjHKacr/aIzbbOmH8FBm87NqcNbM6kqwmr67XzljWwjZMw6TrG5+q/hXgiTrwC7JWp2VcWAL0zKllAqtjBElDlNgohRJH6vszsOfSKaTCVmFs4gy7pOksfDFE/WQcOrhWjBoxacP2wxwJXU99zhl987G7zEuch174E8zPaK6dGDGIFbSjb8IzZtikG5sbwYLMUJUfw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(26005)(41300700001)(6512007)(38070700009)(316002)(54906003)(66446008)(66476007)(64756008)(36756003)(66556008)(83380400001)(478600001)(6506007)(53546011)(6486002)(71200400001)(38100700002)(66946007)(6916009)(122000001)(66899024)(33656002)(5660300002)(8676002)(2906002)(76116006)(86362001)(4326008)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MnNmcTRQNGZrRUh0VTZaV2dwMXdQOXJHZHpmU3pYVDRsMlpKaU9lR1c5UXFu?=
 =?utf-8?B?cXpSQTFNYlozejUrSUpaSmFnQnhZM1ZaaGU4b0FMV3JiZ3cxSXRjMkIrbzRv?=
 =?utf-8?B?c2NZVDd4V0UxczZ0Z0duVmJ2RGlWRHNWVEdmNFk4WVZEK1dHWjBWSmlJMHda?=
 =?utf-8?B?clJQTlo4QjE0bUg3VHBBdGhuNWo4V1FCbjJTd2kwNWdHcXZ1d1VuNHFidnJW?=
 =?utf-8?B?QnZnRWNCaGZXbjRvZFh6M1FJMERmaFAyOFlWZkxZaUFXL0hFMVlqcnVrL2pa?=
 =?utf-8?B?ZmY5NENUSTlHcU9oL0cvbTBxYU5uY1JZSWdGOHRyelZyZElRSDVBbG5SUE9X?=
 =?utf-8?B?VkJyM0gyRXZwZGwxUTgzckFGbmNuN0FYSGVJSk5HUWlmanUyY1phSFFxWnRp?=
 =?utf-8?B?MWdrcUtOVTRIRTZ5OFBibjBIeGt5eExzNnVJa0Zmcm1EbHkxRVhSOHBPMzVt?=
 =?utf-8?B?bmpwWUFPSkFva0pLTXNoSVh5U3BrYXNkcEw1bHJlNmx5b01zd0JuUUE2dnFy?=
 =?utf-8?B?ZVBPb3Z0WmEzbFNVbldoZUZQaFIvZjhlN3RxUjJOeVJwcERQYk4zamM5aGxm?=
 =?utf-8?B?M1hkaVRPTzRoRDVJbkVJSHFmWHlMTCtMcGFlMGUwUmZNODRUNnNFcDdheWhS?=
 =?utf-8?B?ZzlIL2JRZlBOTUhQNGxmbW9jL3dWZmF2Q3ErNFdZQUtwZlMvclVjbWQ3Mlk3?=
 =?utf-8?B?R1B3U1RWeENxUXhYUFcwdGVTNXFYNjBGZ21lSmd0NUhJTmtaUit0MmRtME1y?=
 =?utf-8?B?ejBKcHBmdkQ5SWU2eWdONDFFeWk2N1BEdUZzQ25VMTA0QURITm9UWFVjTU5a?=
 =?utf-8?B?MGZiUXY5ZkV3Z3VLM05RMGsyNmsyTGw3N214RnBmRVlwbWU4Y2JCWHFXQ2JQ?=
 =?utf-8?B?TE1WRDRpWjM2T1VtQm4zdmJacllSaHhTUU42a0dNODVveVI4bGRiY2g2QVRJ?=
 =?utf-8?B?cTQzbFMyZk5oSENNc0lzL3JMV1Bndk0xVTY5SmZhSWlZdmNUMjg4ZXUzZDBj?=
 =?utf-8?B?Q0FwdFJ4WVR6L004K2ErWmFBUTJ3N1FuSzR0Q1l5dG5iQkNScWZpR0Fza3M3?=
 =?utf-8?B?c0xUUkZGYUd4eUg4U3VLRTM5WkdVMmhrOTJORitKbWJtN3VPVWpVN1ZjZGpz?=
 =?utf-8?B?OTd2OVBNMWRzMzZJTXZxbG1WVGVDVHlQT25jMG55SVBPWVdYM2hpSDJMVUpv?=
 =?utf-8?B?b3ZTZmlCYmJSZy9Bb0tsZVNhcVpKaWl5amdyRUFaTE5xUmhEa0l6N2I5ZVli?=
 =?utf-8?B?ZEhDbk5RYzNTbUU3ajZreVluL285U1VESnBhTGcvais1bmV4SnpmYVB6QVl3?=
 =?utf-8?B?Z0h0TFArTlpPZnZNQ1l1dktmam81K0g0VEJKN2psQnVkK1JkRm9RN3VPTHUv?=
 =?utf-8?B?ejVEUmRMN1NYY1BkVndNQUtiNzY5TUVKZGFxcGhzcklJalZVRWw1Zm5nVDlS?=
 =?utf-8?B?cXNFRjZLcmhtT3dmbytRTENGTm9wQWFCaElVRVMyem1mVGZRN3h0elFyVGdi?=
 =?utf-8?B?Z1g5Y3gydE5mOEYxTW5UQUVDVW5Bd21vVmFSbEE5TXNBYU82cEgxR2hPdjh6?=
 =?utf-8?B?RFRWOWdWNXBrV3RxQ1MxT21VcUpFOVNIYkkwZmJNam42d00wZWJoQjA3MWpq?=
 =?utf-8?B?Qmp5MHJiWmVtZllRbEYvVkpGK1pRM3BXMXhaTWQ0TWhaQkRNcmlJQ1pMTnlZ?=
 =?utf-8?B?TndsbllHSzNaaHIxSTNHUS93Nkh5blpYbUxMMG8vVVQwYS9hQk1EbXcxdWs2?=
 =?utf-8?B?azU0NkhrODRFdzJCbDlaM1lsSlYzSnJDZ1l5bUdDdkNTRDkvWkRjeDdqUHpC?=
 =?utf-8?B?TVIvSy8rN3lpd29SeDIrc2JUUFVUN2J5eGxGZ1M2RHpWaGRNZUNQV0xRWm5u?=
 =?utf-8?B?WTlEbjc1My8vdXdyQk8xOUdFZ3VjZzFhUUN5TVduaU1RaEhsQ1pGMzM0Rnl6?=
 =?utf-8?B?Z1RkZUIxem1EMTYxdnB2a2tQTlFpQThJOG5hMnIvd1FraDRhM2lCVXFCWWJh?=
 =?utf-8?B?WC9pNi9IUFlWRDl6NFpMbW5OQkZwSHVHVmVvbDFKYzduMnNJemlTOGl4azJs?=
 =?utf-8?B?SjRrQ1hIVW5UU0drTDFQYjRuVXVReTNUZmgwTUQ4eU14M3hFYlQ5cHozVFZZ?=
 =?utf-8?B?TFZjOGt4VXd2LzRBWGNXbzZlcXZpVWRBeW5rZHM1dHhuSTlFcEh2ZnFORUJR?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D01B7E4C7D4EC1489B36D05766D7F547@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Nr+JTVhgx4UUlqPg6EEoSXWWHMq0la2VemfbgEdKvrbHOW7aWTYDczxY13RP6p4Soz6/rVDS9eKCFw7brvBj+IRyVHwV3OaoJwkpYYjDNyO0Yz7rLwVIjxVU0C7GhVSDQvZDjOzw2rP/kb2/PKwcCv/iR8pzzqLL1f5stWQTb1cV339VqPrntDkBasWY5/oOARjNTEfzJmHW00+dlGAOSA/pUxZPG8XPaJyYbZ0uwy9k7Gobyfj0EgRHVpfZLSD61VRYdggz6HT6MZftnEpK8Ru331JVkSkEgFPcXnVSZXCxVBp75o9Aajo6w5IyfRM+U/Qi+jlI9D8pI/ac8r3spGFjzXABoULwAx4paRhStF9BAuYXizD0x/ZHBtfPVn6LZOpsrjTGvH1d+BDHUDqqjJN17k7MWbDnk/kmJ1l84A8fUadbpyYICmjVFShWMpP5UJ99to1PDE35S/yv+ZWdZKyW1G04VBOY1eaFGRnHpvh2cM4MxK8SMc1IOkMKsRGpdPFDwmI7JgtYfWdjTVm/AnO4/wrbl84awn7zERgEqhfOmHfsA6/OnLHsIxsz4txmDEc78y0N/jxiCb/s/gR51GebQeJt9nnUkKt1nq70g9c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56f720e-a147-4678-420f-08dc22713cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 15:28:12.9063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nE2m9D0u0IB8hN3WwBqRUpUCA0/p+Frl72mxp8X68YWK4gLQ/x1W+/TU+GLMebOsh5lqCGFSwsSWiiUkvPPEEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=844 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310119
X-Proofpoint-ORIG-GUID: F3HrZOS5kfy5LXZeAw2tch8D3jF1k3hw
X-Proofpoint-GUID: F3HrZOS5kfy5LXZeAw2tch8D3jF1k3hw

DQoNCj4gT24gSmFuIDI5LCAyMDI0LCBhdCA4OjA44oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBDaGFuZ2VzIGNvbXBhcmVkIHRvIFY0Og0KPiAtIHJlYmFzZWQg
b24gbmZzZC1uZXh0LiAgVGhlcmUgd2FzIGEgbmV3IHRyYWNlIHBvaW50IHdoaWNoIGNhdXNlZCBh
IGNvbmZsaWN0DQo+IC0gYWRkZWQgc29tZSByZXZpZXdlZC1ieSBmcm9tIEplZmYNCj4gLSBGaXgg
dGhlIG5ldyBrZG9jIGNvbW1lbnQgLSBrZXJuZWwgdGVzdCByb2JvdCByZXBvcnRlZCBJIGhhZCB0
aGUgd3JvbmcgDQo+ICAgc3ludGF4IGZvciBkb2N1bWVudGluZyBmdW5jdGlvbiBwYXJhbWV0ZXJz
Lg0KPiANCj4gVGhhbmtzLA0KPiBOZWlsQnJvd24NCj4gDQo+IFtQQVRDSCAwMS8xM10gbmZzZDog
cmVtb3ZlIHN0YWxlIGNvbW1lbnQgaW4gbmZzNF9zaG93X2RlbGVnKCkNCj4gW1BBVENIIDAyLzEz
XSBuZnNkOiBob2xkIC0+Y2xfbG9jayBmb3IgaGFzaF9kZWxlZ2F0aW9uX2xvY2tlZCgpDQo+IFtQ
QVRDSCAwMy8xM10gbmZzZDogZG9uJ3QgY2FsbCBmdW5jdGlvbnMgd2l0aCBzaWRlLWVmZmVjdGlu
ZyBpbnNpZGUNCj4gW1BBVENIIDA0LzEzXSBuZnNkOiBhdm9pZCByYWNlIGFmdGVyIHVuaGFzaF9k
ZWxlZ2F0aW9uX2xvY2tlZCgpDQo+IFtQQVRDSCAwNS8xM10gbmZzZDogc3BsaXQgc2Nfc3RhdHVz
IG91dCBvZiBzY190eXBlDQo+IFtQQVRDSCAwNi8xM10gbmZzZDogcHJlcGFyZSBmb3Igc3VwcG9y
dGluZyBhZG1pbi1yZXZvY2F0aW9uIG9mIHN0YXRlDQo+IFtQQVRDSCAwNy8xM10gbmZzZDogYWxs
b3cgc3RhdGUgd2l0aCBubyBmaWxlIHRvIGFwcGVhciBpbg0KPiBbUEFUQ0ggMDgvMTNdIG5mc2Q6
IHJlcG9ydCBpbiAvcHJvYy9mcy9uZnNkL2NsaWVudHMvKi9zdGF0ZXMgd2hlbg0KPiBbUEFUQ0gg
MDkvMTNdIG5mc2Q6IGFsbG93IGFkbWluLXJldm9rZWQgTkZTdjQuMCBzdGF0ZSB0byBiZSBmcmVl
ZC4NCj4gW1BBVENIIDEwLzEzXSBuZnNkOiBhbGxvdyBsb2NrIHN0YXRlIGlkcyB0byBiZSByZXZv
a2VkIGFuZCB0aGVuIGZyZWVkDQo+IFtQQVRDSCAxMS8xM10gbmZzZDogYWxsb3cgb3BlbiBzdGF0
ZSBpZHMgdG8gYmUgcmV2b2tlZCBhbmQgdGhlbiBmcmVlZA0KPiBbUEFUQ0ggMTIvMTNdIG5mc2Q6
IGFsbG93IGRlbGVnYXRpb24gc3RhdGUgaWRzIHRvIGJlIHJldm9rZWQgYW5kIHRoZW4NCj4gW1BB
VENIIDEzLzEzXSBuZnNkOiBhbGxvdyBsYXlvdXQgc3RhdGUgdG8gYmUgYWRtaW4tcmV2b2tlZC4N
Cg0KQXBwbGllZCB0byBuZnNkLW5leHQgKGZvciB2Ni45KS4gUmV2aWV3IGNvbW1lbnRzIHN0aWxs
IHdlbGNvbWUuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

