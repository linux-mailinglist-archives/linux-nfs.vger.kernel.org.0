Return-Path: <linux-nfs+bounces-1467-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDA583DBDD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C74B25282
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE9A1C2A8;
	Fri, 26 Jan 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="byJIlinR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ot925YbP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8C1C2A5
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279269; cv=fail; b=hqI43s0Wc4sAnBP94ppgr1cQcrxW1eVWdNs3o83hQtn6XWcr3vEuwmubOOyZJB0mA+j6ewHYEYQivGs6WOU+w1BCl8Ff4bChRGeivg+aU3uCj/T10adOhGIqan9Lj8QoY1rN0zJwp22wWzMkNhw0RDtSH70Lp95IaCmq+SgL5lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279269; c=relaxed/simple;
	bh=Ez/vHrz04EDopLWwy50/V9pD1T1MNBu38dZDHwmtF/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxkG3Pzt/VWs09gN9/IsYigPz7w6NqjKt6IBEzcDHJlCc46W4NndF7NFUf5damuOe4knuNZxpeni5J7L2cN84dObMDc/tq1Mwtkxo2F9uYmroI3lwLnGm3gIRqyp+mC3wTVSgqc7GIsqJ/jijUtc2KqUzV52G6sAoSy027ev7PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=byJIlinR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ot925YbP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QD5UHs010919;
	Fri, 26 Jan 2024 14:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ez/vHrz04EDopLWwy50/V9pD1T1MNBu38dZDHwmtF/4=;
 b=byJIlinRg5GcjWuw7Ui070Kt1QjbqgUiePbOobVeZBC4Y2uJKLqWSLCBAWOwXBHBJqYA
 V5SgC1Q6ftCfJ8xaypVdd08B1NLO5x0J6sbdH2foUXZY5FUK++yr7xs56MiatkLdKyE2
 OLczAEVoae+D+5HAgJq6ThAiwzbjoT6XNBNaPxwIuvvD7qWF8ciH92zfcfPffeTMjAoi
 /tpEyJiKC6XYcIiGloCasen6FRpi0bPPf6Lew/JyBm1Rd+axmca7gSwtR03pDPROFIx3
 ETk9QEpBMhfT99z4nMHjABGuujFKuYWVPaKXFvKNaoL8oG8lYIN3Y8Ua8bvbFS25s62e 9g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79wa9cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:27:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QDehkt014163;
	Fri, 26 Jan 2024 14:27:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs375xxdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:27:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhOUJqGvvCUpfPfQfj/WSOXMWftf5Hx0RQz30GnA62tTgMVJSGbM/XXlQ2dHXpMfYmaW0MJYOQKo2mjFFmFMdvkSFkFEDmyHd6HunDkDhqYUBCGhA99l60bZhHWcybcezBHnUrE39oazNiVSYCmredQvjWEpzPFMoBreSyt8AtXXq+JCvoPypQdNLISMHUQ4dRhaiswWsPsFjzH1jTDQnQAW54gqt1MZQrHq95D4x6eRr75VQHK08ZmteswTFqSBZeIugycLs+ik3yKILVm/IXSCcBexbNK1k+4wD6vi13GtlOrGWHmluhAIHyT9KC5QZTHeJywrokT10Rd/BQewew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez/vHrz04EDopLWwy50/V9pD1T1MNBu38dZDHwmtF/4=;
 b=LZ40Q5jauxRJa/T0Hsmiy4eUy0f5Y1W+nOB+27O8A75dhd8hnv+zZ27HOPl4TMpGjnyuHx9L4umv0lcyLxuE5wmeR0uXm+xZkUICFEBfouObwU8ftBmKATxp5IV0yV8Pdk8l+hvFR70r3nvVz6kfh28hYQAM4sHNQaF11J+I8a6dSLqMyVW3ntoogSI5hSwRQTM4zckSqWW9Ea1zGq3Fg048oqZ8zJJHGHQUX9GWQGSSwZzfQo2jEHzp5nIMOUbjeTVeLnP8Sp6I9C778L7VGLrfoXQOlYtLRCDJQUVo90DS6hCPhmkM2V2DWWgS7zkEyAgS83vwGyfUoLInIHwicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez/vHrz04EDopLWwy50/V9pD1T1MNBu38dZDHwmtF/4=;
 b=Ot925YbP/lWJThDG+6u90oamB9V59gdR1F/n772zJPWLESEVShyIsq7L9rs5CqQgNvzEbUYRcclW56vMRIwPrrrK4cBeD5UIH7O8HSLVgyppkmv7VYl7+X8by3otwp+HQmNKxTuzIUU2NoxjUy+LOgS7KLzyvy+Uzy5hzdCxCRI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7431.namprd10.prod.outlook.com (2603:10b6:8:15a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 14:27:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 14:27:31 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Josef Bacik <josef@toxicpanda.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 10/13] nfsd: move th_cnt into nfsd_net
Thread-Topic: [PATCH v2 10/13] nfsd: move th_cnt into nfsd_net
Thread-Index: 
 AQHaT8hEq8/wrLWuZk2tTHK6HjPCr7Dqr/QAgABjIQCAAPz2gIAADPMAgAAFtgCAAAVGgA==
Date: Fri, 26 Jan 2024 14:27:31 +0000
Message-ID: <52460FD0-34B8-4D07-8063-EA4BA5CB3D0B@oracle.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
 <0fa7bf5b5bbc863180e50363435b5a56c43dc5e3.1706212208.git.josef@toxicpanda.com>
 <ZbLMJxLWIvomQIzO@tissot.1015granger.net>
 <20240125215618.GB1602047@perftesting>
 <889ecfaa124883cd99e40d457562af45b5e97e7d.camel@kernel.org>
 <1E87E98E-EA7B-4BBD-A9FA-EF4B217141E0@oracle.com>
 <3b20db588e31be6f39415aa18b5ffb13214c759d.camel@kernel.org>
In-Reply-To: <3b20db588e31be6f39415aa18b5ffb13214c759d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7431:EE_
x-ms-office365-filtering-correlation-id: c6ad6399-76c3-4d9d-7368-08dc1e7aeeb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MvSvdpmEturS5PNeDDBOldpk14KXRttUpOqydfb8mGed2A0ytqj442GY7e9/oPZd0+uFC5eOiEYHDjgvEQJ2C7mE3o4ijIcK9lZ7RAuElNYA5ij2WUqZWb8Gu9RKp4Wq3n8sZXYbglMd9tL3l4nIF4W2lHEoHdoXH3HnAnJ6b3dg+23pHSG5CNexNi1kt1JX3u9cgZ7fscbSse2PToPNJL1wfV1Asnd0v5EjkQMnSyMPTyfS+53F5vBSMzCEa7N4jl3kElnu675JpFnEU2Lcfit9zXT78IJuVY+gTWfZza/cYxal+RU7NvlVcDKFCcR1GG3a9n5ee8CUuzxJ67XkLNHp9Yj5p8nvrogohm9lGL7BeRKzSUFAeVA4otk6l2fE3c6bVS/5IpdFid0gakoaAlTnvd6XcnEd999xQEGA9klkw+1zyKEetPwEI8EjSJYKhoKmowPs8Z/LQPMpAnmgs9w5XeFE0ARmYi0YtLHcjsQPL9MfZD6WiVtxepy6pFN2/DkqMCDltRMAAviE68EuCrZCXXsOqRuJHFBTEqamsy2PbIgmHv/3hfVh841PEwZ4xisWdB4T5N5dvi2LbSVm/krB40HikoewiAUaIXCZrWIbOkk5/mlfjqBnSOi3eEuNRYlLPOPI91vJXspY55zwqg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(122000001)(4326008)(6512007)(316002)(6916009)(6486002)(86362001)(66476007)(54906003)(53546011)(91956017)(64756008)(66446008)(66946007)(66556008)(76116006)(38100700002)(8676002)(71200400001)(478600001)(6506007)(8936002)(5660300002)(2906002)(26005)(38070700009)(36756003)(83380400001)(2616005)(33656002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Si9tdlBCY0xuSEpUbFNWdDRPVms3ZXBBWVpuaXFsb2I2WTdKVlNtUmJLWC95?=
 =?utf-8?B?WGJSdHNNOVU5T2kyam0ycVgxZHdjSzQ0S3VkaStqVnJaLzdHaVFLc1NJbWls?=
 =?utf-8?B?R1k4MUNjR0FvL21nV1hmTHF6ekRsM1FzWXl5bWxOektnZnJ3SDIxN3EwRDJY?=
 =?utf-8?B?T2dmSFJnVW1qYTlsZXlOQ1BNWnE0aWpDUzBEMTdXMEVYVDJ2U0xJYkZpeFNK?=
 =?utf-8?B?WDVNNFhoeUp1YVpjZDBqaXorVEhNRVg5bHVpMEpUd29BUEh5SlpjUkx1YXQx?=
 =?utf-8?B?YnJZaGQ3c1hEeW9xUUp3UWlObmpOS1paaG5CbkhNQWVjYS9qQlpxZkMrMkZS?=
 =?utf-8?B?V1A3L0t3WkN6QlVlYm5hSUpBT3VxQnQzVU5acG1qRWRhRFJpVVpqR3hiRVR2?=
 =?utf-8?B?NW9tUFNKOGpMVytRdzRNYldKbjUrbWlwZGEwRExYN1FQU1ZyM1RTd21tci92?=
 =?utf-8?B?WllOa1dqZzlPUU5wR0J6MVc5Z2MyMC9TaU4rYnBDbFp2RFk0aWVkWTFJUFRL?=
 =?utf-8?B?TzB1VjdHMVFsV002ZDRkWkVQTVBkRUw1eFJLblEyWGYvbWwxbmh4ZllZUFhv?=
 =?utf-8?B?ZUljQUFXdTV2dVZzQktjejlDbUZFQ1hnZkZ5RmRrYWZKaEltZHoveHJsODAv?=
 =?utf-8?B?M01GNVpGZ3BHU3gzTStjVWJ4eC9iYjdITC85emtsaDJCaXI5M09VRUlIVFlN?=
 =?utf-8?B?ZGZibytDdW8raGhPMC95OXppSTJwT2lBQTZmYm5WUmZQNm4xNWpzY3VEb0tT?=
 =?utf-8?B?bFBnV2xmV1BiOUlGcHpxejI2M3BPdzhuQkZxenlRN2hHcUdDY2VZNnN5ZU11?=
 =?utf-8?B?NTRpaHB5Z1ZlQmNLU2NXcHB2TkJsSWxxTjNCSUtZd1YydlBSNjk0eXZtYjM4?=
 =?utf-8?B?WTlXR1gwRFpKcC9lYVcwVG9nVVlEUEQwMk9ic0pjWnFIQzJGa1gxOWg5N3lq?=
 =?utf-8?B?UVg2Nnl1N1owMG5sd2RRTCsxSkk0Y0xRMG55THVGc21GYW9qNkNLdk9YcHdk?=
 =?utf-8?B?VlJ0QzRqV2hIZG8xTSttNmRiYkJ0QzFLbnpML0QxN1FDTVhXaVJld0ZQekpi?=
 =?utf-8?B?K0pYNEpVdlhnU0tMRk5CVUtFbnVUM21DeXN1QTJLZmFrTlpQNmRTM3c3T3Vo?=
 =?utf-8?B?UjhSeDdwM1BoaGZCRnpLQ2JUOWpJV0JvNXFaeDlhbjNuYzVabngvaHhPSjFt?=
 =?utf-8?B?VURsajJVYXlHUGxjUFFXRHlmN3Z4QzJ3MHRjcHVqQkxZNkpsOWhZSGwwK2Yv?=
 =?utf-8?B?dmhucmhuaFlDS1NTUzJwcUN5dHNmc3NVcTdLdDdnYXhyMk5aSEYydnhmak9v?=
 =?utf-8?B?MGdocnpsTUxjNXpSQ0xTOGVYMXhDRDY3UUhoVUFjWC8rQWVNcW0yTnhEeG5Q?=
 =?utf-8?B?NnE5b0s0K2cwV2UvWVUzUGpOaXV4Q0x5Y3MvYmtZMFpDMHpXNnltZHNGTU9l?=
 =?utf-8?B?K3pWMlBWbzVtSzFsNFE2TkJUN0J4UGl1RXFJMStOdWlxdzdoQUY3Z0Q3d3hi?=
 =?utf-8?B?eENlaGRVM3ZVYzJEQjlmTUM5R0IyOGM5Q2ZQUEJuKy95bmRublg5ZmNEWkZR?=
 =?utf-8?B?UEovQlZ1SGo2VjZ1U2EveC9Tckl6dDlZQ1hoM2FScnl2ZEZPQVNLbkZweFZi?=
 =?utf-8?B?Q0hocGQwOXZtTHdLZ2FQRllqQ09kaGJ3MnZiRlJFZlU2OTM5eFQ5QUxaK2kw?=
 =?utf-8?B?a0J6QXk0SmpHQnhOQmFMaWp1TU5kcVNxVnNsNmhIdUJadGdaYXIwQXU2OFJD?=
 =?utf-8?B?U3B4R2ZCcFpOeHVqWHhiN0QxbDJYSWxmRmpzMHZNS3hIQ3h2SHJnM2FSNFNO?=
 =?utf-8?B?NGw0TTJQTVQ0UEFCeCs5MmJnemlLTG04K3lWVXNlc3RoVG82bjlWQ21IUlRk?=
 =?utf-8?B?bWpWQW4yVExWaWxKR1ovUkhtSFVmREVOL0V4OFhnOTVNdmxTUDhtMU44d2N3?=
 =?utf-8?B?VXVXZFB0ZFV0UmJQQTQzUnBmRktPejZkc3UxLzgxRVRPUWlFNGluRnZOTW4z?=
 =?utf-8?B?NlhMYWZZQ3JhNUc3UW9nN0E0ZEhETm5ETjNweksvVG9xM1BZamQ5UVNVcVp6?=
 =?utf-8?B?WFBqZjcxdXk1aWtYeGlUOTlDZXgvZ2FTYUdodndHQzRpck1YMkZ0T2VNUG9I?=
 =?utf-8?B?UkQwODVSZU1nR0NQMHA0YVBGTk9lb0EydGtNcUdRck1VZTgrdUd1MjROM0JU?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00405700CF86354880BA033291139FF7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JqCwR3GZgZ9tRf0S+RLhXHNI1M2m8qzk/ElQlOIYYhGy/AJEXYrb9DLcwH4wOcjpRmPxLaMvKzFuR4WoHZutmFZTjULG7OBcSicp+n75QCHP4cDqEQnQkxuCEnkpDeCW2KPzCQTZWQOvQvT3dfgv+5MXUChEM0jekgjuYRucGRf6q9qweBzSoBY0KYVmv7nIGkT4LO64cleRTBfwf9p5OAVv3JtF5+2jk3qAQOipUF62903Z9z2GA+1zPt7d8M9tfbFFskY/1fwlBFpGBBdDNoFB73gAOiDCxyDE5Mlcn+SGLW9Z03ns5htV/FgXed4N4o4e7dy7EonZYmc+zbfctIeSB1hfzPO13j1aEeaRlfl/ABIlb5/FBq3ZdDORXMUSkxXRILJ34z/AcI4/vnvp8KcxH4d81hxZuNrmBQClWRd9iPEeIr2n0luYfYoNHN8d1mCFdd2mIod7pckW2G9pUK3QoUpKeeMaFO/Ll9aDuxrhWYLlqGjyWaCmQBG6kaK4vDau2xsHtPl0QgU+F906AqId79IBFnkPey3pD2dXhiPOrmECjRPmMHRHYxsQ9G+qrJNs8fg8iRrNKiZo0vDhbT1JAsm1NjPKBWvOp7ru9gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ad6399-76c3-4d9d-7368-08dc1e7aeeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 14:27:31.9130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyZolb+HohlTT58CDkA8RzC6syQl1mYtKSPL//Lb5YYF0PlpA0lNfDTeBH5IINaruD2G0TuD3x4daLwXTUBvSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260105
X-Proofpoint-GUID: laKJB-k5a3GgTB4H_BlUNAsKvzrUP0oa
X-Proofpoint-ORIG-GUID: laKJB-k5a3GgTB4H_BlUNAsKvzrUP0oa

DQoNCj4gT24gSmFuIDI2LCAyMDI0LCBhdCA5OjA44oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMDI0LTAxLTI2IGF0IDEzOjQ4ICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+PiBPbiBKYW4gMjYsIDIwMjQsIGF0
IDg6MDHigK9BTSwgSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4g
DQo+Pj4gT24gVGh1LCAyMDI0LTAxLTI1IGF0IDE2OjU2IC0wNTAwLCBKb3NlZiBCYWNpayB3cm90
ZToNCj4+Pj4gT24gVGh1LCBKYW4gMjUsIDIwMjQgYXQgMDQ6MDE6MjdQTSAtMDUwMCwgQ2h1Y2sg
TGV2ZXIgd3JvdGU6DQo+Pj4+PiBPbiBUaHUsIEphbiAyNSwgMjAyNCBhdCAwMjo1MzoyMFBNIC0w
NTAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4+Pj4+PiBUaGlzIGlzIHRoZSBsYXN0IGdsb2JhbCBz
dGF0LCBtb3ZlIGl0IGludG8gbmZzZF9uZXQgYW5kIGFkanVzdCBhbGwgdGhlDQo+Pj4+Pj4gdXNl
cnMgdG8gdXNlIHRoYXQgdmFyaWFudCBpbnN0ZWFkIG9mIHRoZSBnbG9iYWwgb25lLg0KPj4+Pj4g
DQo+Pj4+PiBIbS4gSSB0aG91Z2h0IG5mc2QgdGhyZWFkcyB3ZXJlIGEgZ2xvYmFsIHJlc291cmNl
IC0tIHRoZXkgc2VydmljZQ0KPj4+Pj4gYWxsIG5ldHdvcmsgbmFtZXNwYWNlcy4gU28sIHNob3Vs
ZG4ndCB0aGUgc2FtZSB0aHJlYWQgY291bnQgYmUNCj4+Pj4+IHN1cmZhY2VkIHRvIGFsbCBjb250
YWluZXJzPyBXb24ndCB0aGV5IGFsbCBzZWUgYWxsIG9mIHRoZSBuZnNkDQo+Pj4+PiBwcm9jZXNz
ZXM/DQo+Pj4gDQo+Pj4gRWFjaCBjb250YWluZXIgaXMgZ29pbmcgdG8gc3RhcnQgL3Byb2MvZnMv
bmZzZC90aHJlYWRzIG51bWJlciBvZiB0aHJlYWRzDQo+Pj4gcmVnYXJkbGVzcy4gSSBoYWRuJ3Qg
YWN0dWFsbHkgZ3Jva2tlZCB0aGF0IHRoZXkganVzdCBnZXQgdG9zc2VkIG9udG8gdGhlDQo+Pj4g
cGlsZSBvZiB0aHJlYWRzIHRoYXQgc2VydmljZSByZXF1ZXN0cy4NCj4+PiANCj4+PiBJcyBpcyBw
b3NzaWJsZSBmb3Igb25lIGNvbnRhaW5lciB0byBzdGFydCBhIHNtYWxsIG51bWJlciBvZiB0aHJl
YWRzIGJ1dA0KPj4+IGhhdmUgaXRzIGNsaWVudCBsb2FkIGJlIHN1Y2ggdGhhdCBpdCBzcGlsbHMg
b3ZlciBhbmQgZW5kcyB1cCBzdGVhbGluZw0KPj4+IHRocmVhZHMgZnJvbSBvdGhlciBjb250YWlu
ZXJzPw0KPj4gDQo+PiBJIGhhdmVuJ3Qgc2VlbiBhbnkgY29kZSB0aGF0IG1hbmFnZXMgcmVzb3Vy
Y2VzIGJhc2VkIG9uIG5hbWVzcGFjZSwNCj4+IGV4Y2VwdCBpbiBmaWxlY2FjaGUuYyB0byByZXN0
cmljdCB3cml0ZWJhY2sgcGVyIG5hbWVzcGFjZS4NCj4+IA0KPj4gTXkgaW1wcmVzc2lvbiBpcyB0
aGF0IGFueSBuZnNkIHRocmVhZCBjYW4gc2VydmUgYW55IG5hbWVzcGFjZS4gSSdtDQo+PiBub3Qg
c3VyZSBpdCBpcyBjdXJyZW50bHkgbWVhbmluZ2Z1bCBmb3IgYSBwYXJ0aWN1bGFyIG5ldCBuYW1l
c3BhY2UgdG8NCj4+ICJjcmVhdGUiIG1vcmUgdGhyZWFkcy4NCj4+IA0KPj4gSWYgc29tZW9uZSB3
b3VsZCBsaWtlIHRoYXQgbGV2ZWwgb2YgY29udHJvbCwgd2UgY291bGQgaW1wbGVtZW50IGENCj4+
IGNncm91cCBtZWNoYW5pc20gYW5kIGhhdmUgb25lIG9yIG1vcmUgc2VwYXJhdGUgc3ZjX3Bvb2xz
IHBlciBuZXQNCj4+IG5hbWVzcGFjZSwgbWF5YmU/IDwvaGFuZCB3YXZlPg0KPj4gDQo+IA0KPiBB
RkFJQ1QsIHRoZSB0b3RhbCBudW1iZXIgb2YgdGhyZWFkcyBvbiB0aGUgc3lzdGVtIHdpbGwgYmUg
dGhlIHN1bSBvZiB0aGUNCj4gdGhyZWFkcyBzdGFydGVkIGluIGVhY2ggb2YgdGhlIGNvbnRhaW5l
cnMuIFRoZXkgZG8ganVzdCBnbyBpbnRvIGEgYmlnDQo+IHBpbGUsIGFuZCB3aGljaGV2ZXIgb25l
IHdha2VzIHVwIHdpbGwgc2VydmljZSB0aGUgcmVxdWVzdCwgc28gdGhlDQo+IHRocmVhZHMgYXJl
bid0IGFzc29jaWF0ZWQgd2l0aCB0aGUgbmV0bnMsIHBlci1zZS4gVGhlIHN2Y19ycXN0J3MgaG93
ZXZlcg0KPiBfYXJlXyBwZXItbmV0bnMuIFNvLCBJIGRvbid0IHNlZSBhbnl0aGluZyB0aGF0IGVu
c3VyZXMgdGhhdCBhIGNvbnRhaW5lcg0KPiBkb2Vzbid0IGV4Y2VlZCB0aGUgbnVtYmVyIG9mIHRo
cmVhZHMgaXQgc3RhcnRlZCBvbiBpdHMgb3duIGJlaGFsZi4NCj4gDQo+IDxoYW5kIHdhdmU+DQo+
IEknbSBub3Qgc3VyZSB3ZSdkIG5lZWQgdG8gdGllIHRoaXMgaW4gdG8gY2dyb3Vwcy4NCg0KTm90
IGEgbmVlZCwgYnV0IGNncm91cHMgYXJlIHR5cGljYWxseSB0aGUgd2F5IHRoYXQgc3VjaA0KcmVz
b3VyY2UgY29uc3RyYWludHMgYXJlIG1hbmFnZWQsIHRoYXQncyBhbGwuDQoNCg0KPiBOb3cgdGhh
dCBKb3NlZiBpcw0KPiBtb3Zpbmcgc29tZSBvZiB0aGVzZSBrZXkgc3RydWN0dXJlcyB0byBiZSBw
ZXItbmV0LCBpdCBzaG91bGQgYmUgZmFpcmx5DQo+IHNpbXBsZSB0byBoYXZlIG5mc2QoKSBqdXN0
IGxvb2sgYXQgdGhlIHRoX2NudCBhbmQgdGhlIHRocmVhZCBjb3VudCBpbg0KPiB0aGUgY3VycmVu
dCBuYW1lc3BhY2UsIGFuZCBqdXN0IGVucXVldWUgdGhlIFJQQyByYXRoZXIgdGhhbiBkb2luZyBp
dD8NCj4gPC9oYW5kIHdhdmU+DQo+IA0KPiBPVE9ILCBtYXliZSBJJ20gb3Zlcmx5IGNvbmNlcm5l
ZCBoZXJlLg0KPiANCj4gDQo+PiANCj4+Pj4gSSBkb24ndCB0aGluayB3ZSB3YW50IHRoZSBuZXR3
b3JrIG5hbWVzcGFjZXMgc2VlaW5nIGhvdyBtYW55IHRocmVhZHMgZXhpc3QgaW4NCj4+Pj4gdGhl
IGVudGlyZSBzeXN0ZW0gcmlnaHQ/DQo+PiANCj4+IElmIHNvbWVvbmUgaW4gYSBub24taW5pdCBu
ZXQgbmFtZXNwYWNlIGRvZXMgYSAicGdyZXAgLWMgbmZzZCIgZG9uJ3QNCj4+IHRoZXkgc2VlIHRo
ZSB0b3RhbCBuZnNkIHRocmVhZCBjb3VudCBmb3IgdGhlIGhvc3Q/DQo+PiANCj4gDQo+IFllcywg
dGhleSdyZSBrZXJuZWwgdGhyZWFkcyBhbmQgdGhleSBhcmVuJ3QgYXNzb2NpYXRlZCB3aXRoIGEg
cGFydGljdWxhcg0KPiBwaWQgbmFtZXNwYWNlLg0KPiANCj4+IA0KPj4+PiBBZGRpdGlvbmFsbHkg
aXQgYXBwZWFycyB0aGF0IHdlIGNhbiBoYXZlIG11bHRpcGxlIHRocmVhZHMgcGVyIG5ldHdvcmsg
bmFtZXNwYWNlLA0KPj4+PiBzbyBpdCdzIG5vdCBsaWtlIHRoaXMgd2lsbCBqdXN0IHNob3cgMSBm
b3IgZWFjaCBpbmRpdmlkdWFsIG5uLCBpdCdsbCBzaG93DQo+Pj4+IGhvd2V2ZXIgbWFueSB0aHJl
YWRzIGhhdmUgYmVlbiBjb25maWd1cmVkIGZvciB0aGF0IG5mc2QgaW4gdGhhdCBuZXR3b3JrDQo+
Pj4+IG5hbWVzcGFjZS4NCj4+IA0KPj4gSSd2ZSBuZXZlciB0cmllZCB0aGlzLCBzbyBJJ20gc3Bl
Y3VsYXRpbmcuIEJ1dCBpdCBzZWVtcyBsaWtlIGZvcg0KPj4gbm93LCBiZWNhdXNlIGFsbCBuZnNk
IHRocmVhZHMgY2FuIHNlcnZlIGFsbCBuYW1lc3BhY2VzLCB0aGV5IHNob3VsZA0KPj4gYWxsIHNl
ZSB0aGUgZ2xvYmFsIHRocmVhZCBjb3VudCBzdGF0Lg0KPj4gDQo+PiBUaGVuIGxhdGVyIHdlIGNh
biByZWZpbmUgaXQuDQo+PiANCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhhdCBpbmZvIGlzIHBhcnRp
Y3VsYXJseSB1c2VmdWwgdGhvdWdoLCBhbmQgaXQgY2VydGFpbmx5DQo+IGJyZWFrcyBleHBlY3Rh
dGlvbnMgd3J0IGNvbnRhaW5lciBpc29sYXRpb24uDQo+IA0KPiBMb29rIGF0IGl0IHRoaXMgd2F5
Og0KPiANCj4gU3VwcG9zZSBJIGhhdmUgYWNjZXNzIHRvIGEgY29udGFpbmVyIGFuZCBJIHNwaW4g
dXAgbmZzZCB3aXRoIGENCj4gcGFydGljdWxhciBudW1iZXIgb2YgdGhyZWFkcy4gSSBub3cgd2Fu
dCB0byBrbm93ICJkaWQgSSBzcGluIHVwIGVub3VnaA0KPiB0aHJlYWRzPyINCg0KSXQgbWFrZXMg
c2Vuc2UgdG8gbWUgZm9yIGEgY29udGFpbmVyIHRvIGFzayBmb3Igb25lIG9yIG1vcmUNCk5GU0Qg
bGlzdGVuZXJzLiBCdXQgSSdtIG5vdCB5ZXQgY2xlYXIgb24gd2hhdCBpdCBtZWFucyBmb3INCmEg
Y29udGFpbmVyIHRvIHRyeSB0byBhbHRlciB0aGUgTkZTRCB0aHJlYWQgY291bnQsIHdoaWNoIGlz
DQpjdXJyZW50bHkgZ2xvYmFsLg0KDQoNCj4gQnkgbWFraW5nIHRoaXMgcGVyLW5hbWVzcGFjZSBh
cyBKb3NlZiBzdWdnZXN0cyBpdCBzaG91bGQgYmUNCj4gZmFpcmx5IHNpbXBsZSB0byB0ZWxsIHdo
ZXRoZXIgbXkgY2xpZW50cyBhcmUgcmVndWxhcmx5IG92ZXJydW5uaW5nIHRoZQ0KPiB0aHJlYWRz
IEkgc3RhcnRlZC4gV2l0aCB0aGlzIGluZm8gYXMgZ2xvYmFsLCBJIGhhdmUgbm8gaWRlYSB3aGF0
IG5ldG5zDQo+IHRoZSBSUENzIGJlaW5nIGNvdW50ZWQgYXJlIGFnYWluc3QuIEkgY2FuJ3QgZG8g
YW55dGhpbmcgd2l0aCB0aGF0IGluZm8uDQoNClRoYXQncyB0cnVlLiBJJ20ganVzdCBub3Qgc3Vy
ZSB3ZSBuZWVkIHRvIGRvIGFueXRoaW5nDQpzaWduaWZpY2FudCBhYm91dCBpdCBhcyBwYXJ0IG9m
IHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQpJJ20gbm90IGF0IGFsbCBhZHZvY2F0aW5nIGxlYXZpbmcg
aXQgbGlrZSB0aGlzLiBJIGFncmVlIGl0DQpuZWVkcyB1cGRhdGluZy4NCg0KRm9yIG5vdywganVz
dCBmaWxsIGluIHRoYXQgdGhyZWFkIGNvdW50IHN0YXQgd2l0aCB0aGUgZ2xvYmFsDQp0aHJlYWQg
Y291bnQsIGFuZCBsYXRlciB3aGVuIHdlIGhhdmUgYSBiZXR0ZXIgY29uY2VwdCBmb3INCndoYXQg
aXQgbWVhbnMgdG8gImFkanVzdCB0aGUgbmZzZCB0aHJlYWQgY291bnQgZnJvbSBpbnNpZGUgYQ0K
Y29udGFpbmVyIiB3ZSBjYW4gY29tZSBiYWNrIGFuZCBtYWtlIGl0IG1ha2Ugc2Vuc2UuDQoNCg0K
LS0NCkNodWNrIExldmVyDQoNCg0K

