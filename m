Return-Path: <linux-nfs+bounces-1470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F384083DD3E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371E91F25E10
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA31CF87;
	Fri, 26 Jan 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FYTO/wvt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EhpFM7sx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C751CD3F
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282187; cv=fail; b=E2zdut//Z7oBVOYPVyrrmkJHI04NxieZmNnTxEIN51fY73TMILQlbgojg1JLB4byUX6/DT0LjLXfWEDOBQnwOGy+FXE/IReA11j2cyBXRzULvy9XzfPzkcz5yWN4lZP22I06uOMlJwD2kM3gNmzGp+cnWLy49g+TaUgPXHkVC6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282187; c=relaxed/simple;
	bh=89Inwf71P4BZDuvuSFovkd8l2RX7veEH6Up4YM4Zkqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T09gLfKm/gjkhdfifBOI5329EMKet64jKbfZ76Yxu9RrBReYSIWBpVNNmrKY/YaFntPMxWmRhUi0yXhKtNUdXMZiBQgx5SHTd7DEMfxmoWBAcrEk1sKbMJaiG5io9Fj4ABaSrXlQoYGLmK3wdjYuxoiN5njOaM7HQQXxkYEEpFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FYTO/wvt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EhpFM7sx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QEi7Ao025012;
	Fri, 26 Jan 2024 15:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=89Inwf71P4BZDuvuSFovkd8l2RX7veEH6Up4YM4Zkqk=;
 b=FYTO/wvtK0j6jEC+rLLbOjX/q4vFZqmEOeRSQO9UJWOMej9SqL7MapshATjec+6v1tlR
 voe2eZCBdq4XPxMoKPVnPZ5E79yvFeH1yNq/OKGUEt/D2KXIP9O9YXx/ewwWxku2JyU9
 e+hfkNT5KPLdkGqxVuZ10JOQ65LUIgyb+9JaLN763AYtOmG5nAl8EgtOuC8zyer8QxSq
 f5fua0/3ciDFw0o3ASZXVw6SpPtKmRINonJQwaaMrD39FR8McFsF6GCAqaQHm5bwl/1O
 +Qxc0ejavr+RxQmLbfRu8CHpC7dB6A/KibhxvefHKsmDLzZZHLXSixTdUJQXgjPnikBo Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy9p9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 15:16:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QF4S4g011914;
	Fri, 26 Jan 2024 15:16:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs327gjws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 15:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/xJTp49xpyvwXZ2mdUNiJ0nE3Vv1OpTnlwmH4/Ig/bDcHloEDSApvWFwBsHjqBeWsJDhBVGx5LM1Q/882ayN19CE9oA/pt3twwtT7q/ULdUWKLyR5fQFup8ghxK+yHKXW3tZNwebIBTQWZAk54bekn2uQcuKr1tKBsC0ZEQPTLhC4yYi2JLMvfluCcngQ+BxYMfjDRo/14ebNIwPOfjvlsp7IqWfWw26gsOG/O1HyWBkYvumHwLZjleUQ5q2TpBJ3Kl5vlo7e0bD/WBtw1e6sotDTTv1Fku5pLbZ3ZNCrw1EUpp7PjsZLX9wmD34mcx908Zt2QxTXMA0EiaPec8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89Inwf71P4BZDuvuSFovkd8l2RX7veEH6Up4YM4Zkqk=;
 b=gidUo8m/2ufvoJgcuufcdFOxAtXY4wBL0kMLVZIYBLMXs/uGahjMuwRSIKSxtR/BbvWvoIlVnbwgTPbj/Hp6f3WnlOLrle1LL9nfeH+fEGS6svOv6wbMvNs573wbaU5smG7VlnTBmBVVOXzr8yraSbT5Fbgne02A7+RZMIHc0QasZAnWL8eETdj1q44+fOIwhXqm5VG7aTWnh3DoDc2UvdPFMZY4mmyC7aV1hGnAruyLUe9AOb6PwYkomToZTU60r8T6gam2NIuwbw6ZyvnThNkJUdtQiVzjJgonMojtiNnOTAcc9n/XEr1lMAFoYDsCdmaqqJyqX+1FT+RlcMrHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89Inwf71P4BZDuvuSFovkd8l2RX7veEH6Up4YM4Zkqk=;
 b=EhpFM7sx0aIPcjucoidYxBD5R0p+tJ9H08JLtvd7u67hJSGjEIiI6O47Q9QDzjv5btxzx81YmS/14uGOq10mMvvVISbMv6s3cS6JMS1uMab/BubNXGQpjxqtZ36i9t6aPa+zYUIpJvXed8/wvKb1QCkLwsSE/uK4OxHwBiYDDKM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6891.namprd10.prod.outlook.com (2603:10b6:208:431::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 15:16:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 15:16:14 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Josef Bacik <josef@toxicpanda.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 10/13] nfsd: move th_cnt into nfsd_net
Thread-Topic: [PATCH v2 10/13] nfsd: move th_cnt into nfsd_net
Thread-Index: 
 AQHaT8hEq8/wrLWuZk2tTHK6HjPCr7Dqr/QAgABjIQCAAPz2gIAADPMAgAAFtgCAAAVGgIAACiQAgAADeIA=
Date: Fri, 26 Jan 2024 15:16:14 +0000
Message-ID: <94064421-2EBA-45E7-8ECD-5BBCA6BB081C@oracle.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
 <0fa7bf5b5bbc863180e50363435b5a56c43dc5e3.1706212208.git.josef@toxicpanda.com>
 <ZbLMJxLWIvomQIzO@tissot.1015granger.net>
 <20240125215618.GB1602047@perftesting>
 <889ecfaa124883cd99e40d457562af45b5e97e7d.camel@kernel.org>
 <1E87E98E-EA7B-4BBD-A9FA-EF4B217141E0@oracle.com>
 <3b20db588e31be6f39415aa18b5ffb13214c759d.camel@kernel.org>
 <52460FD0-34B8-4D07-8063-EA4BA5CB3D0B@oracle.com>
 <c1f798d6cac7299e33b23ba54148ad985263845e.camel@kernel.org>
In-Reply-To: <c1f798d6cac7299e33b23ba54148ad985263845e.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB6891:EE_
x-ms-office365-filtering-correlation-id: 32f4b2e8-6d74-4ce1-dea6-08dc1e81bcb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KXuc+3Zi/HCc7IjqMuZl10g2Jd1NRgZiH1Y3coDR43rFSj+YGjvvISPb5ey0m4qoUiCPlFZozmOh6tFOF92nBFE5LxhMUh1vJIQ087Ga4M51C+x6naWfeDehDShft1ZDGM1LDdfX/bQ8vu/QGH1vs0ebXXUREq2ZIWfSZs1LwrWrukhdx7roiN7k3loz2IJo/Zo/j3loS9NpJg1Qlgom+QmsmyhnWAGGSJigDxwkEXH8PBS1TCxltACGVmaRq3JpIvNCd0HREsn5KLum/i5ZpG/oqL+ZhBKG2jsh8gJStyUiRje4xbStZFYVOKzOA5NLZY3j+6cdW+xEHdIxUMOMHTLjr61sod+TiKRqwOUH8SXmfI95W2k0rbf8PfcfEem1d4y+/kEgRWuSQjsOiOVJSzjsowxonTAK+l9KEsQceLvDhLiNeRmrLYeXQmyk77PxrWJzUGiF+k4Yc0XPp7pZSm39zk5nS07NC8r9+jj6kY4c+/clFZX8t81a97HzyjkwDp5UycCk6mRLPrtMxLD701u6F30uwvjl4L2nr8Z9aQm9ZYjHXj2N2GZv0OWl1inIMXq8uemu30lIbkefhLh0HyX9qCNq2ZxHFfawrHaZzOdyU3jLgkdsbOhu568gRxZ/xnv8R2981P7p5fEdjUVM2A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(91956017)(54906003)(66446008)(6916009)(6506007)(64756008)(76116006)(38100700002)(66556008)(53546011)(316002)(66946007)(8676002)(66476007)(41300700001)(6512007)(8936002)(26005)(6486002)(478600001)(2616005)(71200400001)(86362001)(122000001)(2906002)(5660300002)(4326008)(33656002)(83380400001)(38070700009)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?alNsQWZNYTQzOW9FT1JCanh4UDA4b3NxL0NCYTduanpheC81Rm5CNnZIRUVy?=
 =?utf-8?B?OFRjSElibFlEWjhKQk1CR2FRUW5TWnFlalB4V3B6L2g5UkFGVW5uRWN5R2dS?=
 =?utf-8?B?SjM1dDlSemkwVnBSZHl6QnBmWlNXMVdYUEpvM2gwR2hCRGo1aS9IMm5DS3lL?=
 =?utf-8?B?RUlKV085Q1Ava1dHdWs0dDZ5MWRUM0Z3TEdwL3VpeVBPZVFwM3NqNXRRVE5V?=
 =?utf-8?B?U3haUEtPUHJSaEdnclRJV3BJNjhJMlIvSUdGYVFVMzluWUNOUmhpZ3FiWVVS?=
 =?utf-8?B?L2RLN2VlUEdXK1hNd2M5bC81d0lmTndXZFR1MzBEc2NtNkVwUFdqMUZkUGNO?=
 =?utf-8?B?ZlFvTDlVbjNzckNrWGN3Tkg0T0MzMk9WaHNFWWl2U25FaGhHcVNMc3NRT0pC?=
 =?utf-8?B?b3FCNk83ZmJRR3V1QlNrY2pkR0g0V0htdVVDWGhjSnBqOTVlbkxRcmFxRDhH?=
 =?utf-8?B?MjM0VXdMYTcrVkdWZGNsb0wrcW9keVNzamxrTGZnc2dJbTdmMmhrZExRZGZE?=
 =?utf-8?B?U29WVjl3ZlNGdE41UHR3NCtvNVdlUGZFdWZjSSs2dzlqanpoMndTWHNzMGo5?=
 =?utf-8?B?NzRYeHBaaGMrWGh6UEZMaTdWRitMK210QWJ1REhQZ09taHpEYVljNUp2dWNK?=
 =?utf-8?B?enRDTGxtN2EwVXlZMEpDQnNhaHkyNTdvTkpudS83SlhveDJRUjg1bnFNVXF5?=
 =?utf-8?B?SVlCVlFnNzNrSWhrMi9pSTJRa3pnV0lldHg4aDIrdkhrZHlaREREbEprRG9V?=
 =?utf-8?B?S0s2WmtWUEpDWlBtQVlRdUJkMHZlanhqaWp0SDAzdHZWdXFNYVpYWmlhM1dO?=
 =?utf-8?B?Q1JFV2lhRXNHbVMwZVYrRm5EQ0pTNHg1T2VMV3poT1M5SHo1Z1kyTGE5bm04?=
 =?utf-8?B?YXhTZGlGQVpwUVA0RjlnTk1SVFkwRzdOamhsL0lZTkNrM0Q4bkNHcVpvbFdw?=
 =?utf-8?B?azg1VUZRZy9FSjdjZVlWb2F3a0p1Wi9nV2dUT3QvUUFlaHpOTEcwRkNnZVFU?=
 =?utf-8?B?SUVFMGVMV3B2S3VwKzFOanlvMWN0NlA4b3FLZDh3U3c2Z1UySGV3UGQ4WHZW?=
 =?utf-8?B?ODdINzlxQWp1M1JGQytwSlJDMDNTa2hUNjB1VUpCZkZnSTc0dUk3UDBBQkZB?=
 =?utf-8?B?YlJiNWMxUjlWaFJQVUtWcVJwZm5CL0dYMHErTXB4a2lDb2V4dEROMnBYcGJK?=
 =?utf-8?B?WVFQM1d3MFJCUjBnUDRrbHY3aSthZkphM09ZNmdmc3NHQTFMR0d0YnRsSzF5?=
 =?utf-8?B?MDdJYVZLbVV0L0oyN0ZDTUxCMHcySUNyRFlld3lZbm9taCtFTkRsWVVIVVhm?=
 =?utf-8?B?dHhZZnUvek5mTUpUblArcGhCWTdlYzI0KzA2UlhXeXpxK2UySHBUU2lGV1dR?=
 =?utf-8?B?VDlBcC9QM2x6WEEzZmxRY203bUJYMHFLKy95NWZzRDNVTG1pSXAwcnIwYUtL?=
 =?utf-8?B?SDN1MFhLajhNb2RTc0JmeG54SXJmOTJyN0FHcnlnSEV5cHFlM1FMMGNkbVEz?=
 =?utf-8?B?a1pCSVJrN1JRVk1tRUl3KzM5NW5RbzR2aUU4YjlZNEVRd2lwa3o2TlZieWNR?=
 =?utf-8?B?YWcxK0xQNXkrdU1pVDIxbk9LalcvQVJkWmJFbm96U2JTWWtIU2FJYS92WkJr?=
 =?utf-8?B?cW4xa1NzT2xHMWRFRGZEeXdyekc4S2YvNHlQTU1Nb00zUnZ1bHcwU25jbG9I?=
 =?utf-8?B?UWMzd1J0Q3Z0RDQrbjIwTS9PcFBXMUZ5d0kwTUROVkYyK244djYycmZRMVhJ?=
 =?utf-8?B?TTlkRU94SXVCZFlnL1RkQlFQM08vNW5hR0dDSWtmTFgyYXc2LzZyZnpzbytG?=
 =?utf-8?B?Rll3VzJxbjVLUUF2NmVRUG1BY1M4U3RndzQ5MEJCaEFUZUt4cjJUWnREMlpU?=
 =?utf-8?B?c3VRRkQzYVIyWWE4eUJEcjBHUHFvTjViVjUySTlMZ3I1R1YwcWlSSHA4M291?=
 =?utf-8?B?MWY5dGZVdzZSdUZYckF4ZWR4b0pid3BSQW9UaTU2WmZkcjZGWXpzY25DTlhl?=
 =?utf-8?B?Y3FYZWRiYlBwSW5nQ25PelNTY09JQ2gzNlhNQnJiS2IycUN3d0VBUVBMbmE4?=
 =?utf-8?B?a1VlUklmNFRqMXE3bXdEUVd2K2YvYnZ0NHR6SUNIVTlYNWN4UUo5U0ROTTY0?=
 =?utf-8?B?NWhKZXEzTlFxbDVoT1NOQ0ZMVHBFYlNDZFVkSFk5NWRMVnRvYW9LdFJvSE5q?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2323DB55D70559479835BD018DBDFBA7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8a8lJClQ1hk1j98L4VN7olVSrmnsecxiO8a3oO1+JzL+eCWt/Z3AeC1Q0JdQfaJgbhfPise7z0oA3c0Tu3vbo+Qu6vBbbTrt/KmaHmF91fSjr2mu/WEwqvjHfn9NWMdIQDt8biRffvYZX3vRhsVMUlAkg5RI1ewe/wZGH93qQ7+w0MJWWL/y8ETKks5Av+IMImWmebvX1Iz/nN/haGcSGrOyYvb5eR26vqf7LHldpyzeIqv23kuOCl7v7+PJyENj50QS3QU2dp4ZrAszTB/Vshf9UQtkCegXfg32PXur7W+8whxYNODpiERai6ReEeq/10ITmiMh7gtHyn3W7Rrz1k3p7VVn2kFbCto/6Zcz8tu+n/0rqegkRB/N8RAW3ic3atGNbG1EPqtZKKGW6Vd1Z7B3BHtSXLcFoVzD5IakYvkf+bMOP8/FyLWhuLALUrZWyIJxmnI1J4dDG5qvmvmCT/gLH6TMka8bm6B6sN1dwp7S6NNsIDJaITr8WzG2hdj+Gw73nVHcxIl7deX7B3lypl/0MYv8bp31IWek59knA6Z64IeSN0Zgow3ChA9AELWvzTT0+fLpN0WGASow7aPRkGqBeMX7N4hfGWgTB9qpIvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f4b2e8-6d74-4ce1-dea6-08dc1e81bcb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 15:16:14.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgDHjnt+lKWHzg8ELVb4tFDMBtwPfeVYvC0km9jG7u0PeqwR8S+uiBiJ/PmJS/zsBwO7rkWj/wpH5nwypOWiAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260112
X-Proofpoint-ORIG-GUID: NK7sCwF7dTSLIlT_tlq9xq63AE4Nw8jB
X-Proofpoint-GUID: NK7sCwF7dTSLIlT_tlq9xq63AE4Nw8jB

DQoNCj4gT24gSmFuIDI2LCAyMDI0LCBhdCAxMDowM+KAr0FNLCBKZWZmIExheXRvbiA8amxheXRv
bkBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjAyNC0wMS0yNiBhdCAxNDoyNyAr
MDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gDQo+Pj4gT24gSmFuIDI2LCAyMDI0LCBh
dCA5OjA44oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IE9uIEZyaSwgMjAyNC0wMS0yNiBhdCAxMzo0OCArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJ
IHdyb3RlOg0KPj4+PiANCj4+Pj4+IE9uIEphbiAyNiwgMjAyNCwgYXQgODowMeKAr0FNLCBKZWZm
IExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gVGh1
LCAyMDI0LTAxLTI1IGF0IDE2OjU2IC0wNTAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4+Pj4+PiBP
biBUaHUsIEphbiAyNSwgMjAyNCBhdCAwNDowMToyN1BNIC0wNTAwLCBDaHVjayBMZXZlciB3cm90
ZToNCj4+Pj4+Pj4gT24gVGh1LCBKYW4gMjUsIDIwMjQgYXQgMDI6NTM6MjBQTSAtMDUwMCwgSm9z
ZWYgQmFjaWsgd3JvdGU6DQo+Pj4+Pj4+PiBUaGlzIGlzIHRoZSBsYXN0IGdsb2JhbCBzdGF0LCBt
b3ZlIGl0IGludG8gbmZzZF9uZXQgYW5kIGFkanVzdCBhbGwgdGhlDQo+Pj4+Pj4+PiB1c2VycyB0
byB1c2UgdGhhdCB2YXJpYW50IGluc3RlYWQgb2YgdGhlIGdsb2JhbCBvbmUuDQo+Pj4+Pj4+IA0K
Pj4+Pj4+PiBIbS4gSSB0aG91Z2h0IG5mc2QgdGhyZWFkcyB3ZXJlIGEgZ2xvYmFsIHJlc291cmNl
IC0tIHRoZXkgc2VydmljZQ0KPj4+Pj4+PiBhbGwgbmV0d29yayBuYW1lc3BhY2VzLiBTbywgc2hv
dWxkbid0IHRoZSBzYW1lIHRocmVhZCBjb3VudCBiZQ0KPj4+Pj4+PiBzdXJmYWNlZCB0byBhbGwg
Y29udGFpbmVycz8gV29uJ3QgdGhleSBhbGwgc2VlIGFsbCBvZiB0aGUgbmZzZA0KPj4+Pj4+PiBw
cm9jZXNzZXM/DQo+Pj4+PiANCj4+Pj4+IEVhY2ggY29udGFpbmVyIGlzIGdvaW5nIHRvIHN0YXJ0
IC9wcm9jL2ZzL25mc2QvdGhyZWFkcyBudW1iZXIgb2YgdGhyZWFkcw0KPj4+Pj4gcmVnYXJkbGVz
cy4gSSBoYWRuJ3QgYWN0dWFsbHkgZ3Jva2tlZCB0aGF0IHRoZXkganVzdCBnZXQgdG9zc2VkIG9u
dG8gdGhlDQo+Pj4+PiBwaWxlIG9mIHRocmVhZHMgdGhhdCBzZXJ2aWNlIHJlcXVlc3RzLg0KPj4+
Pj4gDQo+Pj4+PiBJcyBpcyBwb3NzaWJsZSBmb3Igb25lIGNvbnRhaW5lciB0byBzdGFydCBhIHNt
YWxsIG51bWJlciBvZiB0aHJlYWRzIGJ1dA0KPj4+Pj4gaGF2ZSBpdHMgY2xpZW50IGxvYWQgYmUg
c3VjaCB0aGF0IGl0IHNwaWxscyBvdmVyIGFuZCBlbmRzIHVwIHN0ZWFsaW5nDQo+Pj4+PiB0aHJl
YWRzIGZyb20gb3RoZXIgY29udGFpbmVycz8NCj4+Pj4gDQo+Pj4+IEkgaGF2ZW4ndCBzZWVuIGFu
eSBjb2RlIHRoYXQgbWFuYWdlcyByZXNvdXJjZXMgYmFzZWQgb24gbmFtZXNwYWNlLA0KPj4+PiBl
eGNlcHQgaW4gZmlsZWNhY2hlLmMgdG8gcmVzdHJpY3Qgd3JpdGViYWNrIHBlciBuYW1lc3BhY2Uu
DQo+Pj4+IA0KPj4+PiBNeSBpbXByZXNzaW9uIGlzIHRoYXQgYW55IG5mc2QgdGhyZWFkIGNhbiBz
ZXJ2ZSBhbnkgbmFtZXNwYWNlLiBJJ20NCj4+Pj4gbm90IHN1cmUgaXQgaXMgY3VycmVudGx5IG1l
YW5pbmdmdWwgZm9yIGEgcGFydGljdWxhciBuZXQgbmFtZXNwYWNlIHRvDQo+Pj4+ICJjcmVhdGUi
IG1vcmUgdGhyZWFkcy4NCj4+Pj4gDQo+Pj4+IElmIHNvbWVvbmUgd291bGQgbGlrZSB0aGF0IGxl
dmVsIG9mIGNvbnRyb2wsIHdlIGNvdWxkIGltcGxlbWVudCBhDQo+Pj4+IGNncm91cCBtZWNoYW5p
c20gYW5kIGhhdmUgb25lIG9yIG1vcmUgc2VwYXJhdGUgc3ZjX3Bvb2xzIHBlciBuZXQNCj4+Pj4g
bmFtZXNwYWNlLCBtYXliZT8gPC9oYW5kIHdhdmU+DQo+Pj4+IA0KPj4+IA0KPj4+IEFGQUlDVCwg
dGhlIHRvdGFsIG51bWJlciBvZiB0aHJlYWRzIG9uIHRoZSBzeXN0ZW0gd2lsbCBiZSB0aGUgc3Vt
IG9mIHRoZQ0KPj4+IHRocmVhZHMgc3RhcnRlZCBpbiBlYWNoIG9mIHRoZSBjb250YWluZXJzLiBU
aGV5IGRvIGp1c3QgZ28gaW50byBhIGJpZw0KPj4+IHBpbGUsIGFuZCB3aGljaGV2ZXIgb25lIHdh
a2VzIHVwIHdpbGwgc2VydmljZSB0aGUgcmVxdWVzdCwgc28gdGhlDQo+Pj4gdGhyZWFkcyBhcmVu
J3QgYXNzb2NpYXRlZCB3aXRoIHRoZSBuZXRucywgcGVyLXNlLiBUaGUgc3ZjX3Jxc3QncyBob3dl
dmVyDQo+Pj4gX2FyZV8gcGVyLW5ldG5zLiBTbywgSSBkb24ndCBzZWUgYW55dGhpbmcgdGhhdCBl
bnN1cmVzIHRoYXQgYSBjb250YWluZXINCj4+PiBkb2Vzbid0IGV4Y2VlZCB0aGUgbnVtYmVyIG9m
IHRocmVhZHMgaXQgc3RhcnRlZCBvbiBpdHMgb3duIGJlaGFsZi4NCj4+PiANCj4+PiA8aGFuZCB3
YXZlPg0KPj4+IEknbSBub3Qgc3VyZSB3ZSdkIG5lZWQgdG8gdGllIHRoaXMgaW4gdG8gY2dyb3Vw
cy4NCj4+IA0KPj4gTm90IGEgbmVlZCwgYnV0IGNncm91cHMgYXJlIHR5cGljYWxseSB0aGUgd2F5
IHRoYXQgc3VjaA0KPj4gcmVzb3VyY2UgY29uc3RyYWludHMgYXJlIG1hbmFnZWQsIHRoYXQncyBh
bGwuDQo+PiANCj4+IA0KPj4+IE5vdyB0aGF0IEpvc2VmIGlzDQo+Pj4gbW92aW5nIHNvbWUgb2Yg
dGhlc2Uga2V5IHN0cnVjdHVyZXMgdG8gYmUgcGVyLW5ldCwgaXQgc2hvdWxkIGJlIGZhaXJseQ0K
Pj4+IHNpbXBsZSB0byBoYXZlIG5mc2QoKSBqdXN0IGxvb2sgYXQgdGhlIHRoX2NudCBhbmQgdGhl
IHRocmVhZCBjb3VudCBpbg0KPj4+IHRoZSBjdXJyZW50IG5hbWVzcGFjZSwgYW5kIGp1c3QgZW5x
dWV1ZSB0aGUgUlBDIHJhdGhlciB0aGFuIGRvaW5nIGl0Pw0KPj4+IDwvaGFuZCB3YXZlPg0KPj4+
IA0KPj4+IE9UT0gsIG1heWJlIEknbSBvdmVybHkgY29uY2VybmVkIGhlcmUuDQo+Pj4gDQo+Pj4g
DQo+Pj4+IA0KPj4+Pj4+IEkgZG9uJ3QgdGhpbmsgd2Ugd2FudCB0aGUgbmV0d29yayBuYW1lc3Bh
Y2VzIHNlZWluZyBob3cgbWFueSB0aHJlYWRzIGV4aXN0IGluDQo+Pj4+Pj4gdGhlIGVudGlyZSBz
eXN0ZW0gcmlnaHQ/DQo+Pj4+IA0KPj4+PiBJZiBzb21lb25lIGluIGEgbm9uLWluaXQgbmV0IG5h
bWVzcGFjZSBkb2VzIGEgInBncmVwIC1jIG5mc2QiIGRvbid0DQo+Pj4+IHRoZXkgc2VlIHRoZSB0
b3RhbCBuZnNkIHRocmVhZCBjb3VudCBmb3IgdGhlIGhvc3Q/DQo+Pj4+IA0KPj4+IA0KPj4+IFll
cywgdGhleSdyZSBrZXJuZWwgdGhyZWFkcyBhbmQgdGhleSBhcmVuJ3QgYXNzb2NpYXRlZCB3aXRo
IGEgcGFydGljdWxhcg0KPj4+IHBpZCBuYW1lc3BhY2UuDQo+Pj4gDQo+Pj4+IA0KPj4+Pj4+IEFk
ZGl0aW9uYWxseSBpdCBhcHBlYXJzIHRoYXQgd2UgY2FuIGhhdmUgbXVsdGlwbGUgdGhyZWFkcyBw
ZXIgbmV0d29yayBuYW1lc3BhY2UsDQo+Pj4+Pj4gc28gaXQncyBub3QgbGlrZSB0aGlzIHdpbGwg
anVzdCBzaG93IDEgZm9yIGVhY2ggaW5kaXZpZHVhbCBubiwgaXQnbGwgc2hvdw0KPj4+Pj4+IGhv
d2V2ZXIgbWFueSB0aHJlYWRzIGhhdmUgYmVlbiBjb25maWd1cmVkIGZvciB0aGF0IG5mc2QgaW4g
dGhhdCBuZXR3b3JrDQo+Pj4+Pj4gbmFtZXNwYWNlLg0KPj4+PiANCj4+Pj4gSSd2ZSBuZXZlciB0
cmllZCB0aGlzLCBzbyBJJ20gc3BlY3VsYXRpbmcuIEJ1dCBpdCBzZWVtcyBsaWtlIGZvcg0KPj4+
PiBub3csIGJlY2F1c2UgYWxsIG5mc2QgdGhyZWFkcyBjYW4gc2VydmUgYWxsIG5hbWVzcGFjZXMs
IHRoZXkgc2hvdWxkDQo+Pj4+IGFsbCBzZWUgdGhlIGdsb2JhbCB0aHJlYWQgY291bnQgc3RhdC4N
Cj4+Pj4gDQo+Pj4+IFRoZW4gbGF0ZXIgd2UgY2FuIHJlZmluZSBpdC4NCj4+Pj4gDQo+Pj4gDQo+
Pj4gSSBkb24ndCB0aGluayB0aGF0IGluZm8gaXMgcGFydGljdWxhcmx5IHVzZWZ1bCB0aG91Z2gs
IGFuZCBpdCBjZXJ0YWlubHkNCj4+PiBicmVha3MgZXhwZWN0YXRpb25zIHdydCBjb250YWluZXIg
aXNvbGF0aW9uLg0KPj4+IA0KPj4+IExvb2sgYXQgaXQgdGhpcyB3YXk6DQo+Pj4gDQo+Pj4gU3Vw
cG9zZSBJIGhhdmUgYWNjZXNzIHRvIGEgY29udGFpbmVyIGFuZCBJIHNwaW4gdXAgbmZzZCB3aXRo
IGENCj4+PiBwYXJ0aWN1bGFyIG51bWJlciBvZiB0aHJlYWRzLiBJIG5vdyB3YW50IHRvIGtub3cg
ImRpZCBJIHNwaW4gdXAgZW5vdWdoDQo+Pj4gdGhyZWFkcz8iDQo+PiANCj4+IEl0IG1ha2VzIHNl
bnNlIHRvIG1lIGZvciBhIGNvbnRhaW5lciB0byBhc2sgZm9yIG9uZSBvciBtb3JlDQo+PiBORlNE
IGxpc3RlbmVycy4gQnV0IEknbSBub3QgeWV0IGNsZWFyIG9uIHdoYXQgaXQgbWVhbnMgZm9yDQo+
PiBhIGNvbnRhaW5lciB0byB0cnkgdG8gYWx0ZXIgdGhlIE5GU0QgdGhyZWFkIGNvdW50LCB3aGlj
aCBpcw0KPj4gY3VycmVudGx5IGdsb2JhbC4NCj4+IA0KPiANCj4gd3JpdGVfdGhyZWFkcyBzZXRz
IHRoZSBudW1iZXIgb2YgbmZzZCB0aHJlYWRzIGZvciB0aGUgc3ZjX3NlcnYsIHdoaWNoIGlzDQo+
IGEgcGVyLW5ldCBvYmplY3QsIHNvIHNlcnYtPnN2X25ydGhyZWFkcyBpcyBvbmx5IGNvdW50aW5n
IHRoZSB0aHJlYWRzIGZvcg0KPiBpdHMgbmFtZXNwYWNlLg0KDQpPSy4gSSBtaXNzZWQgdGhlIHBh
cnQgd2hlcmUgc3RydWN0IHN2Y19zZXJ2IGlzIHBlci1uZXQsIGFuZA0KZWFjaCBzdmNfc2VydiBo
YXMgaXRzIG93biB0aHJlYWQgcG9vbC4gR290IGl0Lg0KDQoNCj4gRWFjaCBjb250YWluZXIgdGhh
dCBzdGFydHMgYW4gbmZzZCB3aWxsIGNvbnRyaWJ1dGUgInRocmVhZHMiIG51bWJlciBvZg0KPiBu
ZnNkcyB0byB0aGUgcGlsZS4gV2hlbiB5b3Ugc2V0ICJ0aHJlYWRzIiB0byBhIGRpZmZlcmVudCBu
dW1iZXIsIHRoZQ0KPiB0b3RhbCBwaWxlIGlzIGdyb3duIG9yIHJlZHVjZWQgYWNjb3JkaW5nbHku
IEluIGZhY3QsIEknbSBub3QgZXZlbiBzdXJlDQo+IHdlIGtlZXAgYSBzeXN0ZW13aWRlIHRvdGFs
Lg0KPiANCj4gV2hhdCBfaXNuJ3RfIGRvbmUgKHVubGVzcyBJJ20gbWlzc2luZyBzb21ldGhpbmcp
IGlzIGFueSBzb3J0IG9mDQo+IGxpbWl0YXRpb24gb24gdGhlIHVzZSBvZiB0aG9zZSB0aHJlYWRz
LiBTbyB5b3UgY291bGQgaGF2ZSBhIGNvbnRhaW5lcg0KPiB0aGF0IHN0YXJ0cyBvbmUgbmZzZCB0
aHJlYWQsIGJ1dCBpdHMgY2xpZW50cyBjYW4gc3RpbGwgaGF2ZSBtYW55IG1vcmUNCj4gUlBDcyBp
biBmbGlnaHQsIHVwIHRvIHRoZSB0b3RhbCBudW1iZXIgb2YgbmZzZCdzIHJ1bm5pbmcgb24gdGhl
IGhvc3QuDQo+IExpbWl0aW5nIHRoYXQgbWlnaHQgYmUgcG9zc2libGUsIGJ1dCBJJ20gbm90IHll
dCBjb252aW5jZWQgdGhhdCBpdCdzIGENCj4gZ29vZCBpZGVhLg0KPiANCj4gSXQgbWlnaHQgYmUg
aW50ZXJlc3RpbmcgdG8gZ2F0aGVyIHNvbWUgbWV0cmljcyB0aG91Z2guIEhvdyBvZnRlbiBkbyB0
aGUNCj4gbnVtYmVyIG9mIFJQQ3MgaW4gZmxpZ2h0IGV4Y2VlZCB0aGUgbnVtYmVyIG9mIHRocmVh
ZHMgdGhhdCB3ZSBzdGFydGVkIGluDQo+IGEgbmFtZXNwYWNlPyBNaWdodCBhbHNvIGJlIGdvb2Qg
dG8gZ2F0aGVyIGEgaGlnaC13YXRlciBtYXJrIHRvbz8NCg0KSSBoYWQgYSBidW5jaCBvZiB0cmFj
ZSBwb2ludHMgcXVldWVkIHVwIGZvciB0aGlzIHB1cnBvc2UsDQphbmQgYWxsIHRoYXQgZ290IHRo
cm93biBvdXQgYnkgTmVpbCdzIHJlY2VudCB3b3JrIGZpeGluZw0KdXAgb3VyIHBvb2wgdGhyZWFk
IHNjaGVkdWxlci4NCg0KSSdtIG5vdCBzdXJlIHRoYXQgcXVldWVkIHJlcXVlc3RzIGFyZSBhbGwg
dGhhdCBtZWFuaW5nZnVsDQpvciBldmVuIHF1YW50aWZpYWJsZS4gQSBtb3JlIG1lYW5pbmdmdWwg
bWV0cmljIGlzIHJvdW5kDQp0cmlwIHRpbWUgbWVhc3VyZWQgb24gY2xpZW50cy4NCg0KDQo+Pj4g
QnkgbWFraW5nIHRoaXMgcGVyLW5hbWVzcGFjZSBhcyBKb3NlZiBzdWdnZXN0cyBpdCBzaG91bGQg
YmUNCj4+PiBmYWlybHkgc2ltcGxlIHRvIHRlbGwgd2hldGhlciBteSBjbGllbnRzIGFyZSByZWd1
bGFybHkgb3ZlcnJ1bm5pbmcgdGhlDQo+Pj4gdGhyZWFkcyBJIHN0YXJ0ZWQuIFdpdGggdGhpcyBp
bmZvIGFzIGdsb2JhbCwgSSBoYXZlIG5vIGlkZWEgd2hhdCBuZXRucw0KPj4+IHRoZSBSUENzIGJl
aW5nIGNvdW50ZWQgYXJlIGFnYWluc3QuIEkgY2FuJ3QgZG8gYW55dGhpbmcgd2l0aCB0aGF0IGlu
Zm8uDQo+PiANCj4+IFRoYXQncyB0cnVlLiBJJ20ganVzdCBub3Qgc3VyZSB3ZSBuZWVkIHRvIGRv
IGFueXRoaW5nDQo+PiBzaWduaWZpY2FudCBhYm91dCBpdCBhcyBwYXJ0IG9mIHRoaXMgcGF0Y2gg
c2VyaWVzLg0KPj4gDQo+PiBJJ20gbm90IGF0IGFsbCBhZHZvY2F0aW5nIGxlYXZpbmcgaXQgbGlr
ZSB0aGlzLiBJIGFncmVlIGl0DQo+PiBuZWVkcyB1cGRhdGluZy4NCj4+IA0KPj4gRm9yIG5vdywg
anVzdCBmaWxsIGluIHRoYXQgdGhyZWFkIGNvdW50IHN0YXQgd2l0aCB0aGUgZ2xvYmFsDQo+PiB0
aHJlYWQgY291bnQsIGFuZCBsYXRlciB3aGVuIHdlIGhhdmUgYSBiZXR0ZXIgY29uY2VwdCBmb3IN
Cj4+IHdoYXQgaXQgbWVhbnMgdG8gImFkanVzdCB0aGUgbmZzZCB0aHJlYWQgY291bnQgZnJvbSBp
bnNpZGUgYQ0KPj4gY29udGFpbmVyIiB3ZSBjYW4gY29tZSBiYWNrIGFuZCBtYWtlIGl0IG1ha2Ug
c2Vuc2UuDQo+IA0KPiBJdCB3b3VsZCBiZSBnb29kIHRvIHN0ZXAgYmFjayBhbmQgZGVjaWRlIGhv
dyB3ZSB0aGluayB0aGlzIHNob3VsZCB3b3JrLg0KPiBXaGF0IHdvdWxkIHRoaXMgbG9vayBsaWtl
IGlmIHdlIHdlcmUgZGVzaWduaW5nIGl0IHRvZGF5PyBUaGVuIHdlIGNhbg0KPiBkZWNpZGUgaG93
IHRvIGdldCB0aGVyZS4NCj4gDQo+IFBlcnNvbmFsbHksIEkgdGhpbmsga2VlcGluZyB0aGUgdmll
dyBpbnNpZGUgdGhlIGNvbnRhaW5lciBhcyBpc29sYXRlZCBhcw0KPiBwb3NzaWJsZSBpcyB0aGUg
cmlnaHQgdGhpbmcgdG8gZG8uDQoNCkkgYWdyZWUuIEkgd291bGQgbGlrZSB0byBnZXQgSm9zZWYn
cyBwYXRjaGVzIGluIHF1aWNrbHkgdG9vLg0KDQpTaG91bGQgdGhhdCBtZXRyaWMgcmVwb3J0IHN2
Y19zZXJ2Ojpzdl9ucnRocmVhZHMgaW5zdGVhZCBvZg0KdGhlIGdsb2JhbCB0aHJlYWQgY291bnQ/
DQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

