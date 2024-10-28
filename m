Return-Path: <linux-nfs+bounces-7544-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE69B3CB5
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 22:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177391F223BD
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 21:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BE18E74D;
	Mon, 28 Oct 2024 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W6Sog0tM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i/QMzlkg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B0188904
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151060; cv=fail; b=KvF8L9jycE2iu2qGUo/TKlu0c6K3NtAZZtZfwW/Bg5MIlfKKjf5zCvtTEUVNg+FJwExssFkFyE+9Bx85M1wl90pHTZnSm6w9jQ9MZVBSekn7IzDviVB+WfglVg2a+hIThKQVMlWDv84W4/iODoJdoccKrh9tZ9mMnI5QbM/P9Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151060; c=relaxed/simple;
	bh=Glpn50+Ran3KhQwCiJufbe0rs///QjvORL0dVzqXE7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C+7Eb9nolLyNUD0bhkfHR+I6Aq1Qpq4/xbQ7kkOY1c7A8Ur+XeOOxTyu7MOLvz0vKup00clox3bBa3JQoIl8JYjIiNqjk6ve6zUwfiWckry2VQ1PQfRAdnx6z4ZPWeJm0zEbN8Eur2aFhJ/8O8Yvc95ETQwIcRSW/VXDplB2ZM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W6Sog0tM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i/QMzlkg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKtbBw024413;
	Mon, 28 Oct 2024 21:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Glpn50+Ran3KhQwCiJufbe0rs///QjvORL0dVzqXE7E=; b=
	W6Sog0tMe73OsZChNyvq8Pua+CF1x1EFIWfkA8YMf9/IpNhQkwiCwvSuxmL+9OdV
	eJuB2CAWnm1T7aoeM3egkD7QhUOvb/0SBopM7IGV6SR5saA6EpU6567mEybvVU9F
	pKhCuJPouglq7Q7IBSYv/6rNAMVIxrJcVze35mWSVQUlWxYMOAEMvF/E2QUID9tT
	1sOPBEYcAcUff84q2oQw3miG0KR+l7shpqqFu94zmDIfOvV7zbqLORXx9QD5//P/
	sz1UpGWri8LnNYqu518cmhymmep5eZK+J3Yldk+tawHGOnvXhP11X8NcMNFgc+jx
	zBfaxk3KPI8ljYVaC9JPCA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqbys2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 21:30:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKqoga040237;
	Mon, 28 Oct 2024 21:30:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnan3p1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 21:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo/9UGbRb0durOpOjWJwNg+94kPN6ps6buolty6teOyItpyhDSMbBQVZTJCYTEgf/gRhQ1BzmRVyA+8I5ICfrrhUFYFTO8ZwBXattWp+CVD0Eoc5LcytJVcNuRdk6iEd4h5ZmCnaI/r9DtLkuRpnYLZ9x1a/8zERlzlG/B014lzDpkC1lJ+NII2NtwLLAIksneQyLgddQn7DaFoU2faO7RVpCMxy0vLYWxWxsgATwmByWUN0XNSiun+B/VHl7rQb9MX2SuxJVrsfAlCmgAsjPk5s5WhWAcXGDfEiKZTpKAvdkQ8sQXvomTxnQf+1sFvLP8COT5IzYSKUJcmwGiDJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Glpn50+Ran3KhQwCiJufbe0rs///QjvORL0dVzqXE7E=;
 b=ELdDfb658WfI4aI3SDrlscg69X6E06V1fc6DTIQM2BBflsj0pGrISFBypysWz8X2A+bSDC8w/VsnP32KiqXxiRxvdkyHxD5UbBoIMf+NjYs1VVrR7+tlN6Uhv7LaSXDe+sNw1ubVituNEJdr8uw8WpafuxUlYm9yOwqiE0R+DQ2jDUIYIeRTULetC2RN/2tQIoJw7lsZbV3owWhrPYIMJ0ei4qS8zyoujvJmZwH+8TKHtGhgFmvCVyDo8nBcGLGHvip40URcGZQILBwmIZw5WbjFa86fnoCCCbTciqmO1w+VN8eij+3gP8+A7lICIoz0Mrf9/AFmAWNApZ1k8mR0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Glpn50+Ran3KhQwCiJufbe0rs///QjvORL0dVzqXE7E=;
 b=i/QMzlkgAybbKJ3hZQZiak/Vp5BZ00LJz609VujXtytMO6GvnewVDGr1n5S1yDIIREW2qjUCobhKyEVErxM4Xtil/Wd/kmki+Z+NRAhbKkiTbjxmcHQNBaWoscKojnc18JA9er+eKda/kArBLP93YDbU8z3fZKgE4gz5NhvbKPk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 21:30:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 21:30:47 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Rick Macklem <rick.macklem@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: posting POSIX draft ACL patches
Thread-Topic: posting POSIX draft ACL patches
Thread-Index: AQHbJy/nx1Qi+Q5QsEWJRnYY3dKpK7KatAuAgAHqSgCAABSLAA==
Date: Mon, 28 Oct 2024 21:30:47 +0000
Message-ID: <9FD91AF0-313A-4479-A805-77DF46913581@oracle.com>
References:
 <CAM5tNy4RY-vMZU5zP=-X4F9ahPYHbAAyLkWKBbJc01jB_LD2jA@mail.gmail.com>
 <FF23731E-7672-4933-8261-04EA2E6B488E@oracle.com>
 <CAM5tNy48nGKcQZ+-hegvweGVbrzKQGw444-gxe4zzx9S+UMmZA@mail.gmail.com>
In-Reply-To:
 <CAM5tNy48nGKcQZ+-hegvweGVbrzKQGw444-gxe4zzx9S+UMmZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB7045:EE_
x-ms-office365-filtering-correlation-id: 8cd62b8e-d6d1-4e7b-f9fc-08dcf797c96d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXp2R1pBT2kvWVg0S0JBNkVFdHNlUjVrOUlLbGF4QmtwUUUxMHh6M0sxV3U0?=
 =?utf-8?B?Z3ljQTc5d0p6UkxyNFExVUFwU0lSOHI0MjlINGEwdEw4UlA2Z2lOc2pmTHlK?=
 =?utf-8?B?dHJicDBIZ29FeU4zRU1HZXRNYWdPWUorMXlMNGpJWk9MQ0tBbHRBRW1rNjBm?=
 =?utf-8?B?NFBJMS9yVHlIN1UyektLSk5BcWhzbzZDU25xNHJrVGRWVlZ4OVNTZlZCSlNM?=
 =?utf-8?B?c0dzVUJiRW1tQ21PRTQ2Vy8zVVVRbjdXQWpBVDdkOWVsT1JPQ1BzMmdCU1VF?=
 =?utf-8?B?Q3BIUjFnbExkdDhCb2x1TUthbUFkR2YyNkxTc2diSGNJclBGNkJMYmNpMFEw?=
 =?utf-8?B?eHFpaTZsVVRDakd5c0FoR0Qya2dYOWNhZ3QyTlJkeHlUWDJXNzdmdm9pcS81?=
 =?utf-8?B?SzBMa0xhSERkc1AxZzg3eDJrdEcxM2NpZVp2UHVidXhjN0swSzVCazhMTlV0?=
 =?utf-8?B?emRoS0dhdHNOTklMdVFqVkRBUGFRcXRYdW80My80SnZOalR3bW03NDExT1la?=
 =?utf-8?B?SVRGc0k3T3JCK0NOYmdMZ2wrbll3MUE2L0FGTHVnWmpaMVRSdVhNUUZkN1VT?=
 =?utf-8?B?cHljQS9EZmFYRlZ2NGZPQTMyL3hCOU5WNEY2Rkt5ZEtqaWZrQXI1OVNvcExm?=
 =?utf-8?B?NTcwcFRSbEhIeWFEM0Rtb2U2ZHk3WVBxNFk3eXVvL2JsY1hicVpVaUtCVFNV?=
 =?utf-8?B?NmtJdWNtdE42bXVVQ2tmbVc2QVNLVVJpZ3FkVHZ2TmZ3SEZIdWVOUjNZckJU?=
 =?utf-8?B?dWtvaHZlRnN6bUxNemRUNG50UkFpbi84TVVIZFhnNG16S1ZXME4yUjZ0UmZs?=
 =?utf-8?B?eTVoQWZvb2k4K3poc0R4M0U4SkFLaVplZG1VaGg1d0hFTEk5RldNdllTUVYx?=
 =?utf-8?B?NTZZdUZYZVYyUU1rcmtybEdZZlRTUm81dDFZcnJqbjQrUWxvcVZzUlJsUk1k?=
 =?utf-8?B?YmppOGM1TjRYWEI1NkNIWVRISGs4cjFTbENSV1RoWXhLbFAySUNqZGtrTVZs?=
 =?utf-8?B?TWNkSVhTWDBwTmVUZWVlSXFxS2s2dDRiWThZSkdQRm1HdFpZaUVNcTBONXgr?=
 =?utf-8?B?Y3JacEw4V01IdGtSSWg2RWNwdkZHMUNqWkZhbndwQVg1MVozNy85blpzbXN5?=
 =?utf-8?B?eGNHYmFYbENuR2UzN2FDR284QTdGdWJYV2FXaDZvSFk5TEpKcEVhSGsveU1n?=
 =?utf-8?B?eC9RRHVqUlVVUmI4Y2FXTXlBRXY5UCtPRXQxaTRNalFIdEM2Tzg2Z3U3Wm9F?=
 =?utf-8?B?ZThFODRLRVMxYTUwTC9LeGhReERGYlhZSW1WMmo5TFZLQ0U0eXh0S09hT3Rp?=
 =?utf-8?B?bUZkNTlabkplUTBTQTRRNG5OUDltUGs2SGpJWHFoSmpiQ0lkcWJHcnc0dGJi?=
 =?utf-8?B?VHY3U3h1dm1QV0czMkhnRmlWT3pyMThwaU0xOFFNamlEdW0xclhHREZKcGN6?=
 =?utf-8?B?eHo1M2FObCtYdUoxUTlKOGtleGZnRWptYlYzc29BemdsUDA2WVBxR2dEVnFa?=
 =?utf-8?B?cERTY2djSmVPeG9LNWVIcGlPcDJyc2xjZm1odk0wNTR3eWhHV2V3V3YySGZW?=
 =?utf-8?B?R3Q1aUIwK2FRODZnRWpQWGNlS2hOd3l6d0thNG9peUpYazAzQzBHNWxrR0Vn?=
 =?utf-8?B?VGVacWRnZmNqQXhlQWlIWnhrY0w0QU4yTmNISXhweUV5NDZBRis0dG1qdFp4?=
 =?utf-8?B?RnRIQlRFc3JZTFhtcjJxRkEzcVVRdnZnRXM3YXp4bHZUemNtZVFKZDA1ZFpT?=
 =?utf-8?Q?83QkZqP/naPquSW2CMOH/fl2tEIaLdCRtIMB82o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkIrNmwwaFRSeFpoNktEZjZXZENxT1VGZmczbzhweUpDZzh6eEVmMjBBSmY4?=
 =?utf-8?B?a1hMS3NNUnJCWlgxc09GTFc4bDVxbTN6R3VxMG15Y3Buanl2Y0dpL3Jsd1Vs?=
 =?utf-8?B?WEU1cWdYYlIvTkVJWEhEWnNjbG50KzMzdVR6blRDVy9JeFRDaXcyU0xNWURU?=
 =?utf-8?B?dFI3ZjRHU3FXWjI3VE8zcllEQU1MRnZrem1VSWpVa0s3MGFpMzR4K1N6UXpW?=
 =?utf-8?B?b0ptUXpGUW1laHJ0VldOTFdkUzA0eERlVDZnRDI4OTgyVzJvZ1VpSmZmbDZa?=
 =?utf-8?B?a1IrNWg2SVFLdkpKMTViZFdPM0RMS1VrRDFvS3NKOXJmR3ZjT1R2Ym15eC9P?=
 =?utf-8?B?VGhLR2IrUTd0bktFTUFHNUtKYzEyL3NWVEttMkkrQnZla0kxYmRTWTBHaUVV?=
 =?utf-8?B?elJycEtwZytxb09WbzJ4a1N0K1lRNlhiYkNHZm5pS1dsYkgzSlA1emtBTkd0?=
 =?utf-8?B?UktvVzFwN0NjRW1mUjJGK094NlllNkRyMmRJdVlnSURWM3B3OHlXVUJuYlpy?=
 =?utf-8?B?VmNEYnFyQnJ2VVA2eUp4R2ZDQ2ZjbGZubHV4eW94QUt4M29laVFzODU0UGox?=
 =?utf-8?B?b1NwTGtJRkcxV1ZWcHBPL0gwdWpablNldUE4Vm1PMGpnY2VjN0I4UFF1ZUU3?=
 =?utf-8?B?YU1TclV6NUtZK05DTkgwcTlpVm9iTVdMaHRlOUc0S1VmR05ISitGcE5NWkNZ?=
 =?utf-8?B?ZFRDZFZGbEhBVzI5RDdjbHBDejZFNkMwK1RvbDhycHRYQUM5TlVQYnpwaHlv?=
 =?utf-8?B?RS92cXRuTHhGREs1QVhvT0xXSHYyaGYvaktxYm94a0MxcnM2UlVmeFF1UFlI?=
 =?utf-8?B?VUF5OUxnSlFISDNLcnMyN1M1MnVNNDZMcHhJODZUY0ZRdnBqc1ZPTWFYTGN2?=
 =?utf-8?B?V25XVlg5VGIyNzRmdDVobnBHbjRYREM2a01vYVZ5ckRMK21lb05sMEUwNEtF?=
 =?utf-8?B?NnVOeFhoaFZMKzVRSXp5QVdYQlRuZEFBYUlnQWs0anFoZWRaWlNzNmRRT1h2?=
 =?utf-8?B?cFUvNDYxbXVDQ3kyS1kydGdIQURZL1R2MDdzbnhKS1pLR2ZzVStxV3d0WUNL?=
 =?utf-8?B?M3BlRmJ3amFNZnJmZjRyUFhwOEk5eHFaWWZOT0lJdjZyT1JLMzNwamJoSVBH?=
 =?utf-8?B?VVZBM3dJWmx4dFQzVHc0QzIwWUQzTHNrUit3bkN2amYyUUswZFIwTlhQZVlo?=
 =?utf-8?B?ZHVad0V0QjBnR0h6TkY3NGwvODV5WG12dDN2MGVKclg4cVg4ZUdsSDVNZXB5?=
 =?utf-8?B?VnBhS2FzZy84TjdMaHk0YVp1MHpaQVJiRW8wQktjbG9ONmNvR3g5NTFsSzhw?=
 =?utf-8?B?UjR6ZURCaTBkUVRUblZKTzBhdlRUNm42K1h2M1k0MUYxNmJoUTlNOWE2ZDVU?=
 =?utf-8?B?dXN2ZGxaaXp3dXRwNkoxZHVzdkdnaFZlT294dzBWcHBpOU91VmF6ZndXY2Ra?=
 =?utf-8?B?c054dEx4Slc1bGNraEFna3ZLMnp3aVN0Z3EvZDRMdUtwMGJKNlBEU1dRQzcw?=
 =?utf-8?B?MlJoaEt0THpxdEdRODYwMmcyaFVwOHVMa0ZLL0NEVnhhNzErMUw0Rks0clpW?=
 =?utf-8?B?ZjVMQWZubWNZTzBJSWI2dkZKSDFFN3Z6bnlzSmduSXNPcDBVQzNSV204bmJU?=
 =?utf-8?B?bEw2a3JHS2FoZjJMUzNseVVVd0U0ZmtZVWRLRHplY1pkdnlIRFp2NDgvVW1D?=
 =?utf-8?B?b2tFUDc1bWh4Y2tJTG1yc2FVTXRVaDQxaC9TdlJkbStqQ2tLUkVRT0VXcVh2?=
 =?utf-8?B?WlBPcHF5alhkWmxzZVk3bW84czQ5VnZsaDRjQWZxOU1WVVNvajNuZTFxU2ty?=
 =?utf-8?B?dmJUd3VkQ3h4WHZJazE1NHg1RldDZ2VONTdjYWlFNjJ0Z3JnL0Z2NUFleFBP?=
 =?utf-8?B?YzlTNUMrczNzUUwvbmVpVlR3aWk2UTZKQ25KZS9raWc2Z1R6bVhtY0JPK0h2?=
 =?utf-8?B?eURVVXhQekczVnJac29kYmxwY1dKQU85cHN2ZjZhdEZSR2NtYlA5SnNoMHFy?=
 =?utf-8?B?aDJXL2lxbC9PaFBEQnRYYzZSWTUxUHB2M3NwczBUQ1hvU2EycnQrRWZaWTZv?=
 =?utf-8?B?YlBBNURQU1hQWkswb1NPaEdKNnBNWXM0b0dLQXVFWVh2NG9aRnpPVElaRGhr?=
 =?utf-8?B?VGo0N0ZEUnRvdmcxKzg3cTF2Nm1FOS92Y0YvdzV6UzVOZzhsbHgvaktESjVu?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <781EAA62589336478F4A2FED28045514@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J8KeOPbsnUYi4lWsh6u/LyYBfoDxGrc+UYzhFkWN3rn1VDacbv5IEnBOyWWypgvK3Cl/GK8FjTgoDFZSPwDEX4SBB7/G6kNX77CZaBPLSy1e8soMDuAl8nCfAE+A0vVl8YOpAthlZfJK+sFOkCEt06CFr3OYHRqC/qshLr0f24TtHO/i15CiTgDj/2PWA+nVIEc9k4fcPNeTPFBkZ1vKlwhwVRGveEGrM6rmJXo/2B1u/pT9gd9jP4tN6G2tcisZA0zfvV6pNRYli3LNJOtsCcfi96ZQj82uV9p6maQ+BvCXgBkBtbI2lM9vOH48WnG6txENP+wvFuHhOhIw/6zIISw+ClIYMjRD+2DOZ/3vUqb9RLENi0wOvhOxwVVDCqZfQBVHM3Sv8fiod+RzYH0/48HycmF7wQlxjsTLLsEtwHvSbkOp7WvuTSV0CRThG1xsiy6bZs7vRoYdJZmVWieBi77iqzn50I9wKJOlyCMXTnYG4UCmAh99+nDFhpFBm1tBYhCe5WKVXWD8wabePNmZGeJgo+UbT96bvJyiwQouyBlNiYNuLxjKZrSpmvLroqnZJDxxRJDMnYanbQ8ZmaxAE7+9XNT14I6fXMWcOrl0HHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd62b8e-d6d1-4e7b-f9fc-08dcf797c96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 21:30:47.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cPlXguCIlwXV7n6yPELjyDY4JDEE35FFjyrCURtRd62GqRysb/EyWr7NB7Y4vEcWSk4l3zJXZBJpvHznFOYaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_10,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280167
X-Proofpoint-GUID: KYbJrwHBh8CuUySDtpPI1G3bAawjv8qu
X-Proofpoint-ORIG-GUID: KYbJrwHBh8CuUySDtpPI1G3bAawjv8qu

DQoNCj4gT24gT2N0IDI4LCAyMDI0LCBhdCA0OjE34oCvUE0sIFJpY2sgTWFja2xlbSA8cmljay5t
YWNrbGVtQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBTdW4sIE9jdCAyNywgMjAyNCBhdCA4
OjAy4oCvQU0gQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+IA0KPj4gDQo+PiANCj4+PiBPbiBPY3QgMjUsIDIwMjQsIGF0IDY6NDfigK9QTSwgUmljayBN
YWNrbGVtIDxyaWNrLm1hY2tsZW1AZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBTbywgSSd2
ZSBmaW5hbGx5IGZpZ3VyZWQgb3V0IGhvdyB0byB1c2UgZ2l0IGZvcm1hdC1wYXRjaC4gSXQgdG9v
aw0KPj4+IG1lIGEgbG90IG9mIHRyaWVzIGJlZm9yZSBJIGRpc2NvdmVyZWQgYWxsIHlvdSBkbyBp
cyBzcGVjaWZ5ICJtYXN0ZXIuLiINCj4+PiB0byBtYWtlIGl0IHdvcmsuIChJIHN0aWxsIGhhdmVu
J3QgdHJpZWQgdG8gZW1haWwgdGhlbSB2aWEgZ21haWwsIGJ1dA0KPj4+IEkndmUgZm91bmQgdGhl
IGRvYyBmb3IgdGhhdC4pDQo+Pj4gDQo+Pj4gQXQgdGhpcyBwb2ludCwgdGhlIHBhdGNoZXMgYXJl
IHN0aWxsIGluIG5lZWQgb2YgdGVzdGluZyAoSSBoYXZlIHlldCB0bw0KPj4+IHRlc3QgdGhlIG5m
c2QgY2FzZSB3aGVyZSBmaWxlIG9iamVjdCBjcmVhdGlvbiBzcGVjaWZpZXMgYSBQT1NJWCBkcmFm
dA0KPj4+IEFDTCwgc2luY2UgbmVpdGhlciBGcmVlQlNEIG5vciBMaW51eCBjbGllbnRzIGRvIHRo
YXQuKQ0KPj4+IA0KPj4+IElzIGl0IHRpbWUgdG8gcG9zdCB0aGUgcGF0Y2ggc2V0cyBmb3Igb3Ro
ZXJzIHRvIHRyeSBvciBzaG91bGQgSSB3YWl0IGEgd2hpbGU/DQo+PiANCj4+IE15IG9ubHkgaGVz
aXRhdGlvbiBpcyB0aGF0IHRoZSBkcmFmdCBoYXNuJ3QgZ29uZSB0aHJvdWdoIFdHTEMNCj4+IHll
dC4gVGhlIHByb2JhYmlsaXR5IG9mIGNoYW5nZXMgdG8gdGhlIHdpcmUgcHJvdG9jb2wgZGVjcmVh
c2UNCj4+IG92ZXIgdGltZSwgYnV0IGFmdGVyIFdHTEMsIHdlIGNhbiBiZSBwcmV0dHkgY2VydGFp
biB0aGF0DQo+PiB0aGUgcHJvdG9jb2wgaXMgc3RhYmxlIGFuZCB3b24ndCBnZXQgYW55IGZ1cnRo
ZXIgY2hhbmdlcw0KPj4gdGhhdCBtaWdodCByaXNrIGludGVyb3BlcmFiaWxpdHkuIFRoZSBjbGll
bnQgZm9sa3MgbWlnaHQgYmUNCj4+IE9LIHdpdGgganVzdCBhIHBlcnNvbmFsIGRyYWZ0LCB3aGlj
aCB3ZSBoYXZlIG5vdy4NCj4+IA0KPj4gTWF5YmUgd2Ugc2hvdWxkIGNvbnNpZGVyIG1lcmdpbmcg
dGhpcyB3b3JrIG5vdyBhbmQgaGlkZSBpdA0KPj4gYmVoaW5kIGEgS2NvbmZpZyBvcHRpb24gdGhh
dCBkZWZhdWx0cyBOLiBUaGUgcmlzayB0aGVyZSBpcw0KPj4gdGhhdCBmb2xrcyBub3QgZGlyZWN0
bHkgaW52b2x2ZWQgbWlnaHQgZW5hYmxlIHRoaXMgYW55d2F5LA0KPj4gYW5kIGlmIHRoZSBwcm90
b2NvbCBjaGFuZ2VzLCB3ZSdkIGJlIHN0dWNrIGhhdmluZyB0byBzdXBwb3J0DQo+PiBvbmUgb3Ig
bW9yZSBwcmUtc3RhbmRhcmQgdmVyc2lvbnMuIE9wZW5pbmcgdGhlIGZsb29yIGZvcg0KPj4gY29t
bWVudHMuDQo+PiANCj4+IEZvciBub3csIHVzdWFsbHkgdGhlIGRldmVsb3BlciBjYW4gbWFpbnRh
aW4gYSBwdWJsaWMgZ2l0IHJlcG8NCj4+IHRoYXQgY29udGFpbnMgdGhlaXIgcGF0Y2hlcyBzbyB0
aGF0IG90aGVycyBjYW4gcHVsbCB0aGVtIGZvcg0KPj4gdGVzdGluZy4gWW91IGFyZSBmcmVlIHRv
IGNvbnRpbnVlIHBvc3RpbmcgbmV3IHZlcnNpb25zIG9mDQo+PiB0aGUgc2VyaWVzICh3aXRoIGEg
Y292ZXIgbGV0dGVyIHRoYXQgY29udGFpbnMgYSBjaGFuZ2UgbG9nKS4NCj4gT2suIFJlYWRpbmcg
YmV0d2VlbiB0aGUgbGluZXMsIG15IGludGVycHJldGF0aW9uIG9mIHRoaXMgaXMuLi4NCj4gMSkg
RG9uJ3QgcG9zdCBwYXRjaGVzIHVudGlsIHRoZXkgYXJlIHJlYWR5IHRvIGJlIGNvbnNpZGVyZWQN
Cj4gICAgIGZvciB1cHN0cmVhbWluZy4NCj4gICAgIChJIHdhcyByZWFsbHkgYXNraW5nIGFib3V0
IHBhdGNoZXMgZm9yIHRlc3RpbmcsIGJ1dCBmYWlsZWQgdG8NCj4gICAgICBtZW50aW9uIHRoYXQu
KQ0KDQpZb3UgY2FuIHBvc3Qgc3VjaCBwYXRjaGVzLCBidXQgdGhlaXIgU3ViamVjdDogc2hvdWxk
IHN0YXJ0DQp3aXRoICJbUEFUQ0ggUkZDXSIgdG8gc2hvdyB0aGF0IHlvdSBhcmUgbm90IGludGVy
ZXN0ZWQgaW4NCm1lcmdpbmcgdGhlIHdvcmsgaW1tZWRpYXRlbHkuDQoNCg0KPiAyKSBJZiBJIHB1
dCB0aGUgcGF0Y2hlcyBzb21ld2hlcmUgb3RoZXJzIGNhbiAiZ2l0IHB1bGwiLCB0aGF0DQo+ICAg
IGlzIHByb2JhYmx5IHRoZSBiZXN0IGJldCBmb3IgcGF0Y2hlcyBmb3IgdGVzdGluZy4NCj4gDQo+
IFNvLCBJIGp1c3QgcHV0IHRoZSAiY29tbW9uIiBwYXJ0IGluIGEgZ2l0aHViIHJlcG9zaXRvcnkg
Zm9ya2VkDQo+IGZyb20gbGludXgtbmV4dC4NCj4gaHR0cHM6Ly9naXRodWIuY29tL3JtYWNrbGVt
L2xpbnV4LmdpdA0KPiBJdCBoYXMgdGhyZWUgYnJhbmNoZXMgKGNvbW1vbiwgY2xpZW50IGFuZCBz
ZXJ2ZXIpLCBhbHRob3VnaCBJDQo+IGhhdmUgb25seSBwb3B1bGF0ZWQgImNvbW1vbiIgYXQgdGhp
cyBwb2ludC4NCj4gKEJ0dywgaWYgc29tZW9uZSBpcyBpbnNwaXJlZCB0byB0cnkgYSBwdWxsLCBq
dXN0IHRvIHNlZSB0aGF0IGl0DQo+IHdvcmtzLCB0aGF0IHdvdWxkIGJlIGFwcHJlY2lhdGVkLikN
Cj4gDQo+IEknbSBub3QgYSBnaXQgZ3V5LCBzbyBtYXliZSBzb21lb25lIGNhbiBleHBsYWluIGhv
dyBJIGNhbg0KPiBtb3ZlIGEgYnVuY2ggb2YgcGF0Y2hlcyBmcm9tIGEgbG9jYWwgY2xvbmUgb2Yg
bGludXgtbmV4dCB0bw0KPiB0aGUgY2xvbmUgb2YgdGhlIGdpdGh1YiBvbmUgKHNvIEkgY2FuIHRo
ZW4gcHVzaCB0aGVtIHRvIGdpdGh1YikuDQo+IC0gRm9yIGNvbW1vbiwgSSBqdXN0IGRpZCBlYWNo
IHBhdGNoIGJ5IGhhbmQgd2l0aCBhIGZyZXNoIGNvbW1pdCwNCj4gIGJ1dCB0aGVyZSdzIGVub3Vn
aCBvZiB0aGVtIGluICJjbGllbnQiIGFuZCAic2VydmVyIiB0aGF0IHRoaXMNCj4gIHdpbGwgdGFr
ZSBhIHdoaWxlLg0KPiAgLSBJcyB0aGVyZSBhIGJldHRlciB3YXkgdmlhIGdpdD8NCg0KV2UgY2Fu
IGVtYWlsIHByaXZhdGVseSBhYm91dCB0aGF0Lg0KDQpJIHRoaW5rIHRoZSB3ZWIgVUkgYWxsb3dz
IHlvdSB0byBjcmVhdGUgYSBicmFuY2ggYmFzZWQNCm9uIGFub3RoZXIgYnJhbmNoIGluIHlvdXIg
dHJlZS4gWW91IHNob3VsZCBiZSBhYmxlIHRvDQpjcmVhdGUgYSAiY2xpZW50IiBhbmQgYSAic2Vy
dmVyIiBicmFuY2ggb24gdG9wIG9mDQoiY29tbW9uIiwgZm9yIGV4YW1wbGUsIHNvIHRoYXQgYm90
aCBicmFuY2hlcyBjYW4gc2hhcmUNCnRoZSBzYW1lIGNvbW1vbiBwYXJ0cy4NCg0KDQo+IEFueWhv
dywgb25jZSBJIGdldCBhbGwgdGhlbSBpbnRvIGdpdGh1YiwgSSdsbCBqdXN0IGxlYXZlIHRoZW0g
dGhlcmUNCj4gYW5kIHRyeSBhbmQgY29heCBvdGhlcnMgaW50byB0cnlpbmcgdGhlbSBmb3IgdGhl
IG5leHQgdGVzdGluZyBldmVudA0KPiAoaW4gdGhlIHNwcmluZywgbWF5YmU/KS4NCg0KV2UncmUg
bG9va2luZyBhdCBNYXkgMTIgLSAxNiBpbiBBbm4gQXJib3IgZm9yIHRoZSBuZXh0DQpCQVQsIGJ1
dCB0aGF0IGlzbid0IGEgc29saWQgZGF0ZSB5ZXQuDQoNCg0KPiBJJ2xsIGFzc3VtZSBXR0xDIGhh
cHBlbnMgc29tZXRpbWUgYmV0d2VlbiA2bW9udGhzLT5uZXZlciwNCj4gc28gdGhhdCBzaG91bGQg
d29yayBvdXQgb2ssIEkgdGhpbms/DQo+IA0KPj4gDQo+PiBXZSBwcm9iYWJseSB3YW50IHRvIHNl
ZSBzb21lIHVuaXQgdGVzdGluZyAoaWUsIHB5bmZzKSBidXQNCj4+IHRoYXQgY2FuIGJlIGRldmVs
b3BlZCBzZXBhcmF0ZWx5Lg0KPiBZZWEsIEkga25vdyBub3RoaW5nIGFib3V0IFB5dGhvbiwgc28g
aG9wZWZ1bGx5IHNvbWVvbmUgZWxzZQ0KPiB3aWxsIGJlIGluc3BpcmVkIHRvIGRvIHRoaXMuIEkg
d29uZGVyIHdoYXQgaXMgb3V0IHRoZXJlIGZvciB0ZXN0aW5nDQo+IHRoZSBORlN2MyBORlNBQ0wg
cHJvdG9jb2w/DQoNClRoZXJlIGlzIGFsbW9zdCBub3RoaW5nIGZvciBORlNBQ0wsIGFzIGZhciBh
cyBJIGtub3cuDQoNCg0KPj4+IEEgY291cGxlIG9mIHF1ZXN0aW9ucy4uLg0KPj4+IFRoZSBwYXRj
aGVzIGN1cnJlbnRseSBoYXZlIGEgbG90IG9mIGRwcmludGsoKXMgSSB1c2VkIGZvciB0ZXN0aW5n
Lg0KPj4+IFNob3VsZCB0aG9zZSBiZSByZW1vdmVkIGJlZm9yZSBwb3N0aW5nIG9yIGxlZnQgaW4g
Zm9yIG5vdz8NCj4+IA0KPj4gVGhlIHVzdWFsIHBvbGljeSBvbiB0aGUgc2VydmVyIGlzIHRoYXQg
ZHByaW50aygpcyB0aGF0IHdlcmUNCj4+IHVzZWQgZm9yIGRldmVsb3BtZW50IGJ1dCBoYXZlIG5v
IGRpYWdub3N0aWMgdmFsdWUgZm9yIHVzZXJzDQo+PiBvciBhZG1pbmlzdHJhdG9ycyBzaG91bGQg
YmUgcmVtb3ZlZCBiZWZvcmUgbWVyZ2luZy4gV2UgYWxzbw0KPj4gZG9uJ3QgbGlrZSB0byBrZWVw
IGRwcmludGsoKSBjYWxsIHNpdGVzIGluIGhvdCBwYXRocy4NCj4gWWVhLCBJIHdhcyByZWFsbHkg
anVzdCBhc2tpbmcgdy5yLnQuIHRlc3QgY29kZS4gVGhleSBhcmUgbm90IGluZGVudGVkLA0KPiBz
byB0aGV5IGFyZSBlYXN5IHRvIHJlbW92ZSBhdCBzb21lIHBvaW50Lg0KPiANCj4+IE9ic2VydmFi
aWxpdHkgaW4gaG90IHBhdGhzIGlzIGRvbmUgd2l0aCB0cmFjZXBvaW50cywgYnV0DQo+PiBpZiB5
b3UgZG9uJ3Qgd2FudCB0byBhZGQgdGhvc2UsIGp1c3QgbGVhdmUgYSBjb21tZW50IHdoZXJlDQo+
PiB5b3UgdGhpbmsgZWFjaCB0cmFjZXBvaW50IG1pZ2h0IGJlIGJlc3QsIGFuZCBzb21lb25lIGNh
biBhZGQNCj4+IHRoZW0gbGF0ZXIuDQo+PiANCj4+IA0KPj4+IFRoZXkgYXJlIGN1cnJlbnRseSBi
YXNlZCBvbiBsaW51eC02LjExLjAtcmM2IChsaW51eC1uZXh0IG9mIGEgZmV3DQo+Pj4gd2Vla3Mg
YWdvKS4gV2hhdCBkbyB5b3UgZ3V5cyBkbyB3LnIudC4gcmViYXNpbmcgdGhlbT8NCj4+IA0KPj4g
V2hlbiB0aGVzZSBhcmUgcmVhZHkgdG8gbWVyZ2UsIHRoZSBzZXJpZXMgc2hvdWxkIGJlIGJhc2Vk
DQo+PiBvbiBuZnNkLW5leHQgKHNlcnZlciBzaWRlKSBvciB0aGUgLW5leHQgYnJhbmNoIGZvciB0
aGUNCj4+IGNsaWVudCBzaWRlIChUcm9uZCBhbmQgQW5uYSB0YWtlIGV2ZXJ5IG90aGVyIHJlbGVh
c2UsIHNvDQo+PiBhc2sgd2hpY2ggaXMgcHJlZmVycmVkKS4NCj4+IA0KPj4gUHVsbCB0aGUgYmFz
ZSBicmFuY2ggaW50byB5b3VyIHJlcG8gYW5kIHVzZSAiZ2l0IHJlYmFzZSIuDQo+IEkgZm9ya2Vk
IHdoYXQgd2FzIGNhbGxlZCBsaW51eC1uZXh0IGluIGdpdGh1Yiwgc28gaG9wZWZ1bGx5IHRoYXQN
Cj4gc2hvdWxkIGJlIGl0Pw0KDQpJIGxvb2tlZCBhdCB5b3VyIHJlcG8sIGl0IG5lZWRzIHNvbWUg
YWRqdXN0bWVudC4gTGV0J3MgYmUNCmluIHRvdWNoIHByaXZhdGVseS4NCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

