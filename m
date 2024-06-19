Return-Path: <linux-nfs+bounces-4085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39190F5B0
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFAB283142
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D737A15667E;
	Wed, 19 Jun 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PWi2Cnh4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I9cHOEcU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BB6155A5B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820303; cv=fail; b=LbsomOL6AVbPGOefoiheNw1ygp6BiLy4ABNTVfx0mTKWMIu55tZnSvxRBKtHdxAQIPxw9S3gGae4QQNdeLLATHYq29v0xIAQVGzT5DRtXgqpFl/gslTaZUpDfoPINVDtLM/KGe44vWgAv+fzbZ2JtyoYZEFlOQRuWDMvw8F3Lig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820303; c=relaxed/simple;
	bh=wLo3NIIr2//IbuAOTzOgJzNNE0aUqR9BJ02E32AJZO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hjf7cP6LJlE3v3BSO6o1gAiawz81tZjy7K+BkdATseenj3L9qeIYkznCP4h+0El6VoIMMkniAGw28eHJ4vN5P/ompW9sS+FOc65sNo5Gnv2mZU5G3gXAo/bt+v0q+l5wao9pVW2aOsg6rJggGgLhLNvz8bemfVro9UJqxH2s0lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PWi2Cnh4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I9cHOEcU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JFBUHN000838;
	Wed, 19 Jun 2024 18:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=wLo3NIIr2//IbuAOTzOgJzNNE0aUqR9BJ02E32AJZ
	O0=; b=PWi2Cnh4ixa0O4kCdYDUWMulrDL0ow3/thUzt/+VORX0NKpze0xxIQ1Vg
	fHD7IG7z2x52tHy5ZG3g5rWp6rx4aYT70tgdJf27mmh/Y6JH9zqPO3AJN7Epjjny
	nhx9iA+H3z0cJV+xkmBEPA7ScdHHjt2J/PixNTG8uD2RMPsdbSRSdawtAuNi++UO
	O7J6CKMJ2cGy+dJFL2+SeMznW7zGo3/laun3sl5tHfbUvZYJJgU3s50S/17W49Yb
	E1lGeYbi1qVX/W6VQAtqvN+wLwLP5wEb279015f3lykXyQya/31MpwH/VZPcuUmW
	OqQgY3u9KlOXNHsgmC4hpMpAFPHHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9jsrc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 18:04:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45JGmKZR030664;
	Wed, 19 Jun 2024 18:04:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d9jxde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 18:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+/Mer6UyfhM1Ee43c7NnvM9QEUURm1FWE/kI4/4ONXX9X2QNdQy4qaTGcnZ4JrIxrxuQ4nB2U8OtE3HT3Y2uJTXjboaCcIWXQbBLqyUxpe4U2BCnXDmJUDn1uYT2hM+1fqVlmQLGswoapyKxctKrHBC5hh05eV+a3ZVW3Gmiy+DWsT5Je829te2x0NZEduL4jKKyhhNGuFv8QQ2xpW3H7rBIjVrokCMWZonqRKQ8ZREmGcdyA1TEpwi5mArM6Cxph69Wjki61tg1wSORMWIsHV5D6Y7u0SeMB2JLhViafg1ZnDzjmgqdz/eEZq46T4i9s0njdfc8hT08hdIOhnUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLo3NIIr2//IbuAOTzOgJzNNE0aUqR9BJ02E32AJZO0=;
 b=KS8ClBvnJzkLqYw4I1qRHxqBYKzfnvS340OoKj2X4wAy/4lrNe8pFX8jVOFRNkKKaEkZ9OioCueJoxIDBlSRfijGcion0nYWKVvrdG/yRaRlyy0a37ajI2npNc0E+WKl0heE5BeC2kNevSNiRGWcy2i0asy+jpfL0su2/ZryadMNf7pay1AO+pMAOrBLMZkuIAiK/kH2UsHaMA077sfI16MmXZ1dPvNn+9Fv70XPFNyyhEVNU7uSMmZJQtUZr6+5zNCaY5jqjyOr4Fbm0JIBTzMtX7MOefNnyEqr3uGiPFegWexzEgGp0WlcoTX27fm74lzhOHdTVv9hFulVrNOBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLo3NIIr2//IbuAOTzOgJzNNE0aUqR9BJ02E32AJZO0=;
 b=I9cHOEcUnv4BrVGtwhH08U0kJp/qgsbTTDYnc+n1FMAfeFSNV3ryCe8xMOmrYruU3zHveSo4Ui94AnXsLsBjowZmciAMo7RrUrOc9Ist1mgkE3A/mcTcVN1GKwffJdiru9q9En3HekRgks0cs0WI+WCnBwRyh0DakNnBXJ7LpXU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4335.namprd10.prod.outlook.com (2603:10b6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 18:04:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 18:04:46 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Neil Brown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v5 00/19] nfs/nfsd: add support for localio
Thread-Index: AQHawbzkA6q2NL13ck+t/s2/VqCfZ7HOlUwAgAAWqwCAALS5AIAAAhyA
Date: Wed, 19 Jun 2024 18:04:46 +0000
Message-ID: <D1A3A43F-757A-43D6-BB71-AFAF2E17C060@oracle.com>
References: <20240618201949.81977-1-snitzer@kernel.org>
 <ZnJxTsUuAkenmvWP@infradead.org>
 <171878101003.14261.1089014272023335768@noble.neil.brown.name>
 <ZnMb7NxuXnIikSQK@kernel.org>
In-Reply-To: <ZnMb7NxuXnIikSQK@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4335:EE_
x-ms-office365-filtering-correlation-id: a6c0791c-da4e-4aa9-d934-08dc908a4df4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?d0R5UzVBMmxsdVZzNlZXc1I2OS9hYjF0Nm5xTkM3aTB0OHdOb1lTb3NLdEpJ?=
 =?utf-8?B?bDhKN3NObkFjWFZ6RG91U3BPeCtVbC90WGs4TEZ1QjI0QWxzTzIrYlVGazR3?=
 =?utf-8?B?Z0lvalJXVTNJTTRQZWZnYjh0TXljdlhSeWpwRGVtU0FVVGRoallPNFRmWmpR?=
 =?utf-8?B?cE9RN0Z0ZXRDVXF6M08zSFNCYS90Qk1JVHVQbi9UTFp6dGdUWUpTclRmNkVE?=
 =?utf-8?B?TmpucTRTVEcxRmdTV3pkNVVZSzFCUTh6RjRUNEUzaDQwODJvQ09NVXpaeTRs?=
 =?utf-8?B?QWhHb3pkOUpQMWV2Vk11VG1CeXpFbXhOY3lOQXRHdzZYalNJM3pidm5rZHFH?=
 =?utf-8?B?amZiTHZBS1lsa1JiSmx1SVFDZ1lxaUZJYkF4cWRDTW5jYWg4cTdiYUdiaFBx?=
 =?utf-8?B?L0pzQzFlbSs0QzdrTjVtMERWZTZIb3VmNk4wTE55T3VUMjAyOVUwSCtVcjdF?=
 =?utf-8?B?TFF2b0hMNkYvQ2NwYThSNXFHTC9xalZDMSsxMmgwNXNGdGhGZXpRa1JwRitR?=
 =?utf-8?B?L240RnU2dDQ2LzFiZE9weE1YbDBMUy91bDJsbk54WVdXd0lxQml1b1hGM0p2?=
 =?utf-8?B?cXFEMTBoRHBiUFNwRDF2WWNQdGhUSUlzU2FWTEYwVUp2T0JZTEw3YUtwZlMy?=
 =?utf-8?B?Wm8vaXhLSzhmQkt0ekF6QXRPWnJYVmVwNTNnc1pTQkgrSERGTy8vMStiemx5?=
 =?utf-8?B?R2p3K2Q2R3FSZEVJdGVuTjUxYmtSUDB3YlRHR1dIZTgwdEZmaWl1Y3ZvTDgv?=
 =?utf-8?B?V2hZZEJzcFYzN3JzNDNidGpObzdqOFVzUXkwcUdFd1h3ZDBhSXg0QXhEZXF5?=
 =?utf-8?B?VytSSXQrejZ4T1lZNjRZUGhYOVgyUGQzYjF6a2tzVUgya042U1FodW5JWXh3?=
 =?utf-8?B?VmFvb2FrVGYybzBqTmtVWS95SlVLaFJvRjZSamZwb1U3Nkl1MWxPellCUVY2?=
 =?utf-8?B?ZlVqUGVEQ2FpSnVoM1FsSFpQT0xXVUMvd0xQVnBuRUhGeW1JQWUyR3hzc0py?=
 =?utf-8?B?ajBaSFRSM09qRVEwNnhoVno2TkJIV0xQeEpuMjNCQW51UEN5L3JTeVV3Ym9F?=
 =?utf-8?B?SHpmbFhlOUJPck80VWFUanFycmpOLy9pYzR3YTRVYjNrWU44VFUvNWhhNjJE?=
 =?utf-8?B?UjlqL1ROQ1ltZC9jSWZWQ0l4eVc1RWFwdG0rTmM3K1BVYmFTaXZ2eGo3cE1K?=
 =?utf-8?B?MTBjVjBhSEYybWdCWXRtVTEwRjRyeVZCbkNEaHpmdEl1N2c4ZWtmUFlmZkU5?=
 =?utf-8?B?Q1RBM3oyUGJHQ2FlN1p1Y0RyRVNOR0s3U3Y3VXR6aE1wamJ5eUxpK0dBSGRs?=
 =?utf-8?B?SDRDK1VueFBRWnluMjBOWXIyTStFVk1OTTFpalRhczZrVFR0SEdnRHN2VDRZ?=
 =?utf-8?B?VFpiRlczRUZ6WE9PZGxYYnplRjU0aTJrZzRIQVBOdWxnYVROd2Q5cThzZGZS?=
 =?utf-8?B?SVlJZDhUZFJzbmN2Nms1SDdYYzM2NEJQRnNOWUEvSUQ5ZjJha1o3VDFZU3NE?=
 =?utf-8?B?T2VCRjZsVVRiQ2ZNZTUzR0FDVkx1ZjhJMG1XSFZYRnNxK1E2SlU3c3dIRk1q?=
 =?utf-8?B?M3QvTkQ3NHVVY2hUeFpjei9IU1YrbFlTR2JOQTNQaVNqbFZCVHhKaTJ4R1pv?=
 =?utf-8?B?SlZodmd0QmIyOWRtTDdydEdBUXVOS3NWVndsbDFJbmRzS0FVWXk1K2tiSTdM?=
 =?utf-8?B?ak5rZWI2NG1PaXZ0TTI0ZmxTNnRncDZHbHVFaklkbS83d293S3I3cVBMMnU3?=
 =?utf-8?B?Q3EyKzM2V2g5TmtQUlpqUjlSSXR1dkJvRnNvZ3RZMllmNHI0Z2FBR0QwT01U?=
 =?utf-8?Q?d9G3KvVottFHvbTSDnCV1nSRFd+C8MYNvHMvc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SlpWazFIdE53SGpCdE1OL3FpbWZMTHRXMVB1SlVtUkVNbWFJZFRtQWpiVEZV?=
 =?utf-8?B?SHVCSW8xRVlKdE50c3hhc3d4aW50VVNVL0NGK1hRWjZyaWVSdTZNbjJGVnYr?=
 =?utf-8?B?emY4Wm5YNzhjbC9BT0xLZEp0elBqWXVFK0lqMytqT2dXcjNlcjlJdFBMTFlw?=
 =?utf-8?B?NVVBOGl4SSt4eXNWSHRXMzNSOFpISlJXRWhyakxzbHVlUUR2ZmJtYWlMQ0dj?=
 =?utf-8?B?SGJ2cGdsTTQzSzY5NFg2NXh1U1hwRWFDN2ptdXhHZy9IZlJiSXBjRHQ2amdO?=
 =?utf-8?B?Wmo1dnI3Q0ZhMDcycmU1R3lFSFF0T0QwUGE2VXdpTjVoTFNGUzhJOHlRaXdF?=
 =?utf-8?B?UStEcDE1S2FGd3loUWthK3VraEEzTkhiVmNpbU9JOUFzVHZTazQ2ZjBsM2VV?=
 =?utf-8?B?ak9ESGtzRzdEZXVDUWRxTWdZalh4SGF6WHpkNk1QUm1qc2xoYTlqcTV1amVL?=
 =?utf-8?B?eVIvNGhFNzhYN00xUEJrekhWNXpZVU9QRGVlUTltckEzNXVkNDlNcHZqZENj?=
 =?utf-8?B?OWN4dzNMRUpyTXc5Z1orUHhieTZQK0QzSXBENUhobWV4Lzk3clh6VlRQNFNQ?=
 =?utf-8?B?Z0RvaU1nT0NERzdOSmllbW5kR3NxOENFdzh5REtYR0pXWFV3ZU41eUZNMTdQ?=
 =?utf-8?B?bFdJZE5EOG5aK0RLdDg4KzE1WHpFTldLUDdmKzlyd01reXBmVGozWTRaWUlq?=
 =?utf-8?B?TVByc201OUpHSVIrK3hKMUtRbWx1elNxcnM0blFkZVB6Z3cvQ0VaS08xSHpC?=
 =?utf-8?B?VnhuTTB4RmVCVU11Z002VE9JcklKOTZ3THhKVUp2N3FKWnNtMS9tY010S096?=
 =?utf-8?B?aDVzSDRNNi9qQ1YzVUdzOTdPZFdDZEVmdHFoeDFKeC9LTWpYbGpSSGRvMjlM?=
 =?utf-8?B?UCsrT1k1K1ZnbVg5RVd0S2ZYSStWTHhSekF4eThlZEFSVnlmaUJUMlV1bnJn?=
 =?utf-8?B?RlBWYThCdTNPRWpZdUc2bmdvSXpueEN1WmdyaXR4WXVVcGJXUzVxam8vN21H?=
 =?utf-8?B?ek1Zdk9CelYrV0E2eFJ4c3V2ME8yaDBNS2pZMWRiVmJJY3lxZVpYTGJGRFA3?=
 =?utf-8?B?anAvcXM2cXdWQVhTdnM0T2NtMnM3dWhsMTJ0ek1UcUZDUDUzSURZV2lrS1F1?=
 =?utf-8?B?MFhmM2xvNzRpTUNhWE41UEd0Ym1FakNUWEFPK2ZaT01Tb2Z2OXJzZjU2NVRq?=
 =?utf-8?B?cmgyaTRaT0k3ZXJwRHYwT3hsaFRxdWtZSDBiV3JTTWJnY1lTVzVJTC8xUWx2?=
 =?utf-8?B?eHpnckxCVG1NdC8wMmZGK0dHV3pUN1dGNzZ2azM5K3dkME1Kd1VibUJ0SENT?=
 =?utf-8?B?b1NKRkZrVm9pWGFrdWY3a2VzVHN5Z0RFcW1LeXpvREMyYmhnYVgyaHRtRndx?=
 =?utf-8?B?cGlON3Avb2tDOHNMbStsQUxQRld5R0c1S25NbEw5RDdWMVQyZnlQSGI1eElz?=
 =?utf-8?B?RExJQVFoTkxSQzJFMlZxRlhqbXlGNUY1RWl0YURFMXhyNEVsQm9EMk1UTUww?=
 =?utf-8?B?dk1DOFA4OWQ2LzMwMkpTZTloN3g1SW9zbmhiTHl5ZC9IVWlKNSt3QXNtemQx?=
 =?utf-8?B?K0Y2ek83MVlPRS9vTlVjRzVNS2ZoVnE1SUgwWTVnOUVBYXJjSi9qZ0FidHBD?=
 =?utf-8?B?azcyRmpzbHBGb01Qa3E3WE9tamhEb0Q2dDAxU0RjazhWL0NBYlhPenlLQ1hu?=
 =?utf-8?B?ZzZOcXhKNythUGhaTG03UzM1YXI1QW00YUNZZmR1dnYxejVuTmFqc2lJdzZR?=
 =?utf-8?B?QUZybm8xUDloTDJpQnRwUmxlTUZwZ2ZKNmZpVDdnU2tWTThSR09zREQvcWh5?=
 =?utf-8?B?T2JXMktwUlQxVG1tS1ZlSWo3cEdjMU9OM0JueDJsQVJyWWVnU0pIVzhGNUlV?=
 =?utf-8?B?ZmU3SmpvMzRkTmRUMkJrWTE2STVHL3FPR2JGZkkrN05md2s3Z3VVYkl1UXYy?=
 =?utf-8?B?QjNYMWFXeHVUeVpnZlg4aE5CTHd6TUpiRGx1aTdQZEdleEwxMTNYcHFZZklT?=
 =?utf-8?B?RjRUS0xoR29mQzNFSlZDWWFOYmdjSTBhaGJ6R1hhTE5RMmtQbEtyYjk2YVJL?=
 =?utf-8?B?V2JuL2UwaUt1RWVJNmVYZ3BPMEJKWG9xcS9OQ2RTem05Zkd2VTFYMU9kU1pk?=
 =?utf-8?B?TGpBQUhVK3FkVmFPT0dmcW45ZDdlVlhkNDRHTWhxY0U4WFpFUzNYOXlJRDNX?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <646E89C78C97BD4899D79B7D0C6C603D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rc6U8u+GnB9qGXA76m4hA0pYLN10SQHbv+hErqHWeN74AatnLkUTvsXxfXwQ1lCs29eYd65KKd5ezlou6YWG1bDOO4vmHNOf62KqQ/b9pYpuLYKbuMUIah7itK5vjYOo+c4xhzTp7wWAi3ZIM1uvL9dPYl2ReuewVt2nF00A/EQ3+Kv2qV8PRVvWbdIN2/arIs7r627QaZPL5Z+sYryEj6w2BmLRHKOY4Xs4L9Az/RQt9LoKYw1rgD8A4bNovA8BbCPPK+rRW7JtplFxQuWLnS81+RAdaTKdVP1hu1qYGTlwCr5wWYbDNfP9/u2I7pg3c88q/l/0n93jQiFuq2s2FvHJtZLfEudx2hRVr6w0Chv0iffs4wD6Wl/hbEhVSEXm5uqj1RMwftSGDbjoRi3eN5NEer2AQErCAMt276bRAy8yMKq7sSm/9T5ycUgjTJHI2H8TH7nqGNPbhq4vVs5iHQN3v8rdi4Mue+/yy+7akHEAODzL3EzPsdeiimO78f1EqFavlJ5SUti5CM7+6ZERKJCFEVrLt0leDtuO4Bq5MHQGNPSAFptmkR2L5dX4UE9uQO1nEH5zDkXBh4rMYaQaZbzEKGwqNXDh8e4wkyrIIgE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c0791c-da4e-4aa9-d934-08dc908a4df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 18:04:46.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFfX9SX+fYgiBu9PIPw7V8Ett56/fxHT79AgmMI7J8PRr11zno6LUIF7ctXxoJrdZWBJ59H/PrjZEgkWaDDKyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=893 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406190135
X-Proofpoint-ORIG-GUID: M-P3_9OqwmzXUhZIQi_zQpEWzn3HyiWJ
X-Proofpoint-GUID: M-P3_9OqwmzXUhZIQi_zQpEWzn3HyiWJ

DQoNCj4gT24gSnVuIDE5LCAyMDI0LCBhdCAxOjU34oCvUE0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgSnVuIDE5LCAyMDI0IGF0IDA1OjEw
OjEwUE0gKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4+IE9uIFdlZCwgMTkgSnVuIDIwMjQsIENo
cmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4+IFdoYXQgaGFwcGVuZWQgdG8gdGhlIHJlcXVpcmVt
ZW50IHRoYXQgYWxsIHByb3RvY29sIGV4dGVuc2lvbnMgYWRkZWQNCj4+PiB0byBMaW51eCBuZWVk
IHRvIGJlIHN0YW5kYXJkaXplZCBpbiBJRVRGIFJGQ3M/DQo+Pj4gDQo+Pj4gDQo+PiANCj4+IElz
IHRoYXQgcmVxdWlyZW1lbnQgZG9jdW1lbnRlZCBzb21ld2hlcmU/ICBOb3QgdGhhdCBJIGRvdWJ0
IGl0LCBidXQgaXQNCj4+IHdvdWxkIGJlIG5pY2UgdG8ga25vdyB3aGVyZSBpdCBpcyBleHBsaWNp
dC4gIEkgY291bGRuJ3QgcXVpY2tseSBmaW5kDQo+PiBhbnl0aGluZyBpbiBEb2N1bWVudGF0aW9u
Lw0KPj4gDQo+PiBDYW4gd2UgZ2V0IGJ5IHdpdGhvdXQgdGhlIExPQ0FMSU8gcHJvdG9jb2w/DQo+
PiANCj4+IEZvciBORlN2NC4xIHdlIGNvdWxkIHVzZSB0aGUgc2VydmVyX293bmVyNCByZXR1cm5l
ZCBieSBFWENIQU5HRV9JRC4gIEl0DQo+PiBpcyBleHBsaWNpdGx5IGRvY3VtZW50ZWQgYXMgYmVp
bmcgdXNhYmxlIHRvIGRldGVybWluZSBpZiB0d28gc2VydmVycyBhcmUNCj4+IHRoZSBzYW1lLg0K
PiANCj4gTXkgZmlyc3QgYXBwcm9hY2ggd2FzIHRvIChhYil1c2UgRVhDSEFOR0VfSUQuIEl0IHdv
cmtlZCwgYnV0IGl0DQo+IHJlcXVpcmVkIGV4cG9ydGluZyBhIHN5bWJvbCB0byBxdWVyeSB0aGUg
aGFzaCB0YWJsZSBsb2NhbCB0bw0KPiBuZnM0c3RhdGUsIGV0Yy4gIEl0IHdhc24ndCB2ZXJ5IGNs
ZWFuLi4gY291bGQgaXQgaGF2ZSBiZWVuIG1hZGUNCj4gY2xlYW4/OiBJIGd1ZXNzLi4uIGJ1dCBp
biB0aGUgZW5kIEkgZWxlY3RlZCB0byBzb2x2ZSBib3RoIHYzIGFuZCB2NC54IGluDQo+IHRoZSBz
YW1lIHdheSB1c2luZyBMT0NBTElPIHByb3RvY29sLg0KPiANCj4+IEZvciBORlN2NC4wIC4uLiBJ
IGRvbid0IHRoaW5rIHdlIHNob3VsZCBlbmNvdXJhZ2UgdGhhdCB0byBiZSB1c2VkLg0KPj4gDQo+
PiBGb3IgTkZTdjMgaXQgaXMgaGFyZGVyLiAgSSdtIG5vdCBhcyByZWFkeSB0byBkZXByZWNhdGUg
aXQgYXMgSSBhbSBmb3INCj4+IDQuMC4gIFRoZXJlIGlzIG5vdGhpbmcgaW4gTkZTdjMgb3IgTU9V
TlQgb3IgTkxNIHRoYXQgaXMgY29tcGFyYWJsZSB0bw0KPj4gc2VydmVyX293bmVyNC4gIElmIGty
YjUgd2FzIHVzZWQgdGhlcmUgd291bGQgcHJvYmFibHkgYmUgYSBzZXJ2ZXINCj4+IGlkZW50aXR5
IGluIHRoZXJlIHRoYXQgY291bGQgYmUgdXNlZC4NCj4+IEkgdGhpbmsgdGhlIHNlcnZlciBjb3Vs
ZCB0aGVvcmV0aWNhbGx5IHJldHVybiBhbiBBVVRIX1NZUyB2ZXJpZmllciBpbg0KPj4gZWFjaCBS
UEMgcmVwbHkgYW5kIHRoYXQgY291bGQgYmUgdXNlZCB0byBpZGVudGlmeSB0aGUgc2VydmVyLiAg
SSdtIG5vdA0KPj4gc3VyZSB0aGF0IGlzIGEgZ29vZCBpZGVhIHRob3VnaC4NCj4+IA0KPj4gR29p
bmcgdGhyb3VnaCB0aGUgSUVURiBwcm9jZXNzIGZvciBzb21ldGhpbmcgdGhhdCBpcyBlbnRpcmVs
eSBwcml2YXRlIHRvDQo+PiBMaW51eCBzZWVtcyBhIGJpdCBtb3JlIHRoYW4gc2hvdWxkIGJlIG5l
Y2Vzc2FyeS4uDQo+IA0KPiBJIGhhdmUgdG8gYmVsaWV2ZSBDaHJpc3RvcGggZGlkbid0IGFwcHJl
Y2lhdGUgdGhpcyBMT0NBTElPIHByb3RvY29sIGlzDQo+IGFuIGVudGlyZWx5IHByaXZhdGUgaW1w
bGVtZW50YXRpb24gZGV0YWlsIHRvIExpbnV4ICh0aGF0IGFsbG93cyBjbGllbnQNCj4gYW5kIHNl
cnZlciBoYW5kc2hha2UpLiAgSSd2ZSBjbGFyaWZpZWQgdGhhdCBpbiBEb2N1bWVudGF0aW9uIChm
b3IgdjYpLg0KDQpFdmVuIHRob3VnaCB0aGlzIGlzIGEgcHJpdmF0ZSBwcm90b2NvbCwgeW91IGRv
bid0IHdhbnQgc29tZQ0Kb3RoZXIgTkZTIGltcGxlbWVudGF0aW9uIHJlLXVzaW5nIHRoYXQgUlBD
IHByb2dyYW0gbnVtYmVyDQpmb3IgaXRzIG93biBwdXJwb3Nlcy4NCg0KSSB0aGluayByZWdpc3Rl
cmluZyB0aGUgUlBDIHByb2dyYW0gbnVtYmVyIGFuZCBuYW1lIHdpdGgNCklBTkEgaXMgZ29pbmcg
dG8gc2F2ZSBldmVyeW9uZSBzb21lIHBvdGVudGlhbCBoZWFkYWNoZXMNCmFuZCB3b24ndCBiZSBh
biBhcmR1b3VzIHByb2Nlc3MuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

