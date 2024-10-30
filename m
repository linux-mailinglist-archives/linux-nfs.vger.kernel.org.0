Return-Path: <linux-nfs+bounces-7569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE42E9B62D5
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 13:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312AC1F20F42
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F201E260D;
	Wed, 30 Oct 2024 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="imqFA5jg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w36UUdYq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C441E492D
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290775; cv=fail; b=byOT6s9tOig+tLMjv7Q/q05/PPWQnNRqkdwex5YtE71LbpBNfaLIs8GNFWrnRELpTvNs3ER+N4lvLmEht9yP4g4ucv4JGC02OgFcm/ugcwWng5/HoCTkW9YosDAp2UZO26auwT+04sekfTN95Ecat2g86GpHZrdBVAtfGbLaWgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290775; c=relaxed/simple;
	bh=SYfZAReHDYPLo85Ri53dUG7M/zoEo60njqYtWXKtl4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lrOcK/AsfF9pdbnuVkGzLRTwVf6YZpxSGqpWoXz+veQetEarTSB976o69wQkxhY2CtvRaZ5Jp0CViq6x7KKzwfO2rH4JnuWEraaK7cSfiAR6WT930z+NXlhCxb66PYPs8RC8W1liHZs8i9/tJOBm1yAFw1ogd59CM16bAYitHf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=imqFA5jg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w36UUdYq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U1feeg002241;
	Wed, 30 Oct 2024 12:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SYfZAReHDYPLo85Ri53dUG7M/zoEo60njqYtWXKtl4A=; b=
	imqFA5jgIkmXk84SiJlL+n087v9vE/TKNxty7+5HwJpzVUfo4WzOVJrqsO5H41Sf
	BynavoWjFHWWkvO6TfpikFZZIOcTcknvFP1FfurqhKBS4ep/RijuUIUbm3Cr77OP
	vfox2rCK67O6gfPn2dqOgoZSLlBvPMaLvii2X+kRqPuyrrIv9LoHCfs8L2bV+njl
	+cuLQzsrtInQjNh7dHZRNDFPhZvaeKMWo3g2ZxvTGVfCZu4ELMaPoRAnj+1Gl9lr
	q9gE9elabfo6G62+3SnK2XutUV2F3Gv2UZjUowXqky2HoAPw5tjiT3CBlf/Lu1Pu
	ne7+Jq/JJhRd9OWlTJMCCw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgmfx3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 12:19:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UAjPXt010273;
	Wed, 30 Oct 2024 12:19:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8y7bn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 12:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yidjxQaJq40SMUa51lxNepru0i8RQoqrw6clajRrOs+nw3yn3Kg7jx+joNWbfB90lg0nlnrvlWRzzTwfaS2NuDUr/hHDMkxxY5XG/dvCTU2I3eYOQwpMmNjmZdiJp03lWYS3/pHUTrW59qUZ34gfoDDnNPqZQ8UjQPn5Bb3nNqTHUISk0ygwcHUU5HhHG3noZwzIbGiHcKCgSK45Jywyk+y+r/Mp+wgm/6R/ccjc+KIazDhYRG08934lrOJLhomFWpfrG27GzYepyEntYH4EpyXNfJ5zbvCWPYNhMw2T/AUygw86oeAFj13GE9AMB3EwS6ccbmuIDQZRsGamQjlUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYfZAReHDYPLo85Ri53dUG7M/zoEo60njqYtWXKtl4A=;
 b=iow5mvJFTo1QMJcV+GXcRTtLK7oCDPM6vlSJx831FhjpY6hcuM65GUHIwrmLUsVlDoqILagEm22giqLoM5S223VFSOd5/Vw0nKwFwWpCuizcF+7bCJlwPOMc9o/jvKD2eJIGxRiRwVGJQLw6UM5DQ7uLvqWRqx6A5PbUoTRTmero2QiKiwcbYhZjrX/Wo3Dm0SsxxuPtPPsntOpKD4Sv+IflJo8zjSHBYrNvKBaR15TPykeS3EChb9LN21Rvdqeb7vasNVAxpGPGaKDHDO3Om0fj5U1Y5N6IYI1/LB1xaxXjLGTJHdYYSiNsG17d0ieF6mrsj2ecrGSDCrYRcVM53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYfZAReHDYPLo85Ri53dUG7M/zoEo60njqYtWXKtl4A=;
 b=w36UUdYqiIoWBPHEGr5uOGpzP80Nrb/I22a06nuM+5AIZTGvZom1z1dssGoOFN17qatH3gdXBH2y5flrNMSw+gRpB9CZpVztSKGq2+MBC/3iCBi4B7igNdQ5kH1QuOh+SLeg3bkdNu5FfWra0GAFPyY3tDE8h61vTMIt3jDOj7o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5666.namprd10.prod.outlook.com (2603:10b6:303:19b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 12:19:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 12:19:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Rick Macklem <rick.macklem@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC: handling (or not) VERIFY for POSIX draft ACL attributes
Thread-Topic: RFC: handling (or not) VERIFY for POSIX draft ACL attributes
Thread-Index: AQHbKnWGdmGTeCY/aEuesKrAq1S3XrKfNvIA
Date: Wed, 30 Oct 2024 12:19:24 +0000
Message-ID: <45988263-042D-4A3A-A236-3B2AD786A0C9@oracle.com>
References:
 <CAM5tNy4xVcJa+qrfuze5s61rO_-tXkY60gF5WHGAvzJQ=9ZXmw@mail.gmail.com>
In-Reply-To:
 <CAM5tNy4xVcJa+qrfuze5s61rO_-tXkY60gF5WHGAvzJQ=9ZXmw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5666:EE_
x-ms-office365-filtering-correlation-id: 0769aa5f-2705-4982-5de2-08dcf8dd1794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REpDcy9IVUFVZmIyM2d1Z3hva3JYV2E1aW8zeUdLbXJzWGJJeGNobVZaZW96?=
 =?utf-8?B?KzZBSWg1eVRUM1V0MHkrK0liQXNBejVJV04rM3cvZ1RoUENKc1owTVYyM2lB?=
 =?utf-8?B?aGpQMGRkUU82Z29jelJFTzMwdFZHdGtLVTZRM1lZZFdMSTR5U0t1VVZ0QmVU?=
 =?utf-8?B?WFlpcTU3SkoyYkZMWFA3anRoZFNaa0RwWWprN1RZUG9xSkpEYlBOK1pFS3dS?=
 =?utf-8?B?UHdqeFVmaUM5b0FtTGRmUDJXOStwWjlWQ3RtQXRycUVhZk1oOHM1UTllaDhO?=
 =?utf-8?B?YkVlMG9nL0F1YkhubDdQNUR2VFhJSHVKZk9vNnZFdXd2OTNCd2VzSWlyTDBx?=
 =?utf-8?B?VUNKZTJFZWdUZlJMSzB0RklvT1RnYmtkZGdSOVlJU1pFSGVJc2tLNEdlblhy?=
 =?utf-8?B?Z2psTEpTQVd3RDJxYjZaY05IejBzZnI5bUZIVytKem54UjgrRjJGcHgyUkl3?=
 =?utf-8?B?ajhad2l5eVBZOG1kSWI0S2I0UXNwQUhmdFhhQ3NyYm9LUmNRRFFLQ0YvQk5i?=
 =?utf-8?B?UUxlWGs0VjJUUm4vSjhUNlVYN2NrbXk4MmgzNThkK2UrWEFXWnJTZEg5V1hq?=
 =?utf-8?B?aUN6QllDYjEzUnBHUU5nSGhqSEdQaVpXVklrcnZaWTI5NW05ZHdocCsrR0d0?=
 =?utf-8?B?d3R2NGkyRGxEMUl0a1lCNWU0TkxzL3h4SENCS2N5OXkwcmhxS25KVVNvOHVT?=
 =?utf-8?B?OUF3VHJvUldCdTdvOWpOWWJiZVZPSlJXNHlYOU80UmF3cjVqUXZlQm9wWitU?=
 =?utf-8?B?elhiQlhDYWM0ZmZqN0xTV3N5SmN5Ym11MDRFQm9Fc2Zzd3J6cndMa1l6Y2U5?=
 =?utf-8?B?NjVpdFNUZUVHQkJxc1Zpa3RVWkpOZkVwQ09ZRHMxTUxrVzR2WDFyWWJwWlRy?=
 =?utf-8?B?NUYxNWltcHRtSUlqZTRJWjBwQ0VqVy9YT1RlcnlnVTlwQ3gvMHIxbEZ0REFr?=
 =?utf-8?B?QVQ5R0pzRTExUGxzaEpRS2dsMEZ3ZVY0TGwxZTlEa2pNdHQwbWczeThCY3FT?=
 =?utf-8?B?d1MzNHdjRzkrSnhvd2UwMU4zUE44am9jRXFMcWNJdUN6SzJaY1FvQ3JiYzFW?=
 =?utf-8?B?YVptcE5IcWo5YWlYaGl1Yk5tTDAyRCtFMElya01raThVZWc4TWRTckZjUy85?=
 =?utf-8?B?eHl2d2pSOXZxWVJaYjlaVkYveW9uR2tlOFZ2TkhKd0dhVFZJb3ZYdDI2Tldy?=
 =?utf-8?B?RkZ4VWsvTmdENUZ5Z3QzQWpoejRPcytOUUc1K1VpNkphQ1YzeStaVW0waG9k?=
 =?utf-8?B?S0I2NC9zYkpmbHZLQmVDZjhYczlYQm41VEs0TDU1QnpZYVRCblduWGlUaHdV?=
 =?utf-8?B?NHhmKzZDQWo5ZU9nQWtXZURxRFZjTWMvblVDNVU3ZWlDQlFkTEJacnJuY2s2?=
 =?utf-8?B?ZFlabHdvOGdGWFhodU5vSjU4dXJtSVdqWmM4V09tODBPZ0RWejFKNmNSU2Js?=
 =?utf-8?B?QWp6a0VjY05KODVuU3V0ajNHai9hWFhwT1VCZ0hPQlBjKytoRnVCd0NjcFdP?=
 =?utf-8?B?S0txeFYzNnZ1U2g1U2MzSXBiSjRsVkpUSnI0SzVzdk5TUXNUL09mMitxTmky?=
 =?utf-8?B?Wi96UHplUHgyMlZKWk4vOEwydzBLK0tVNktxOGtOS0VZMnJpSm9KWldQWGtC?=
 =?utf-8?B?Ty9GeStjcVFsMldoeGJramNyQ2J4ZmVwS0VjRGovUXU1dWxHazdkVnJ3a0kv?=
 =?utf-8?B?QjRQcURXQkllb2srMGllb0JNKzlWK0ZmZlJwMFJzckpHOUFNSWRWa3g0ek9L?=
 =?utf-8?B?L21meGg1V3VhOGNjOWFJQ01ndjBpc2g2ZjllVXUzMWQzSTdzWjdZTG9ZZWIr?=
 =?utf-8?Q?9mp+tB8fkQdGFsQwfvqLTyY09r6vnV93Vb5HU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nk1ZRmFZcDF1U3hQQ1lqM3NmaEF5ME50cWQwTnljRnByUnNjZVZFempSdEdr?=
 =?utf-8?B?Yjk0NURaUHdLRVJIdndnSFRzSDlTVStqdFkrS0k2aEJXbCtJcTFpdlQydmdP?=
 =?utf-8?B?TWNraERUZWlYcTIwZ3JJMmdjeHBMQ0cvUHFUVW9yaVlOUEdYTE95RVUzbmdL?=
 =?utf-8?B?QzJOcCtUMWFIYnM3eURkMUJ0aTYzWjVWaHJHZHdZZjJKWDFvWU9CN2NUaXIr?=
 =?utf-8?B?Mm9lRTZER3NkdWtmT0IySHd5L1p0UkpjUkE2THNBN1Q2NkY5eFZDbjhMMlpE?=
 =?utf-8?B?S0lKbGlpbk9BM2FpZzMvekY1MEpHS2o3em03OVVKTjhtanJCM24yRHNkcEZt?=
 =?utf-8?B?b0pMaHNXK3piZitOSnpjR1lTWE45UGY3aWJXMWxodSthY05YamQ5aUJIdExE?=
 =?utf-8?B?TjRPVStCTUNJdE1VQmU4RVNlWTRNSzhlMVl2VTJWOXJGTVJjQk5FYmZZejB2?=
 =?utf-8?B?QVZzNlNZazF4eVpKdTZXWXFxb0tmS05TaWpNdEI3THR4Lzc5RWpnQnlXN1cv?=
 =?utf-8?B?R2pZeTVqU21ZRThqZHJOMGZVSUZ2azZzR0UzTSsvVmUwLzJFU1RCamVTelBR?=
 =?utf-8?B?OVp5KzhUdVRMeU9TbXprZ2J6R2I4LzQ0dWVObW1Qc1NEenZRRGt0cWwzV1d1?=
 =?utf-8?B?ak9SaU5zV2xLZE5GWFNQeC9YcWtlNDlYMllYTWkrY3ZGQXh1eWtvcUVCSyty?=
 =?utf-8?B?N1RKR3pzMHlzK0g0ZHVKU3EyUnNvWXk2clAxSHJVakFIUmJXQ1lsOEdQb29z?=
 =?utf-8?B?N2lIcDBXd1VXditaODQ5SDlDY2hoRzNob1RqdWF2cXoraHFjUXJualhTNXo2?=
 =?utf-8?B?d240UTJocWRTTUsyZGZjZlF2QzNTdEhYZUsxZHhFSFQ5dHpVakV0L1V0Wm5h?=
 =?utf-8?B?VU1ZVHhaWnZrWE93dk5LMVpoQzhFQ0d3L05GbkxVdmtBLysvZzRZREFTSUd4?=
 =?utf-8?B?ajJ0OVpISmt1M3gwWnNJdGFBQ2FRbzgvNVBLK0M4ZXB3ckZocWxJUGl4M04r?=
 =?utf-8?B?MnZtZjVPMG1yV2NKYWxTVmJsSzZOcEZQRkZwRm1tdzRWNzV6Vjg3bDZuQ1VO?=
 =?utf-8?B?Q1piYS9KMS9YSC92dHpxS1lFQnFNSjJ2SHN5VURYdHRvRTgyL0IyblJ4WW9t?=
 =?utf-8?B?dUVhSUxicXBhdjgwWitXNzBUM1BSVmIrRmRBT0NIdTdVUVBtZTRPanAyT24r?=
 =?utf-8?B?Qi94ZEpSY2UveGxiaWJGRnc2akVLS0hrZDN2azVYbDJremJvWG5HTXJneWdX?=
 =?utf-8?B?Y0Zpd1JZZXBCeEQ5SHBxOXNFeHFScVU4ZThOemJpZFBTU0NrZGxLWm5FS2VP?=
 =?utf-8?B?VWRSMWYySnZvcEhSZHdSUG1GZjJVMi9jMGhObUtpSzNPY3NPT09uYWRMYUFL?=
 =?utf-8?B?QUFSNEFhcnl2cHRhRjdjVWJrMkVFcjdKUjVHZHlrVlpuUUZqNGhJS1JSaWlU?=
 =?utf-8?B?b053eDRtNlNaYUI4SnRGdVZwcWJBc3VnNXpLMnQ0UTQweHVIMGNsaW11aFRk?=
 =?utf-8?B?bXpkaFJQUXhvQVA0QkJUSk5tbXF2dGJIWjZTRmFoWUoyUVFxYmIzbzJqUkx6?=
 =?utf-8?B?c29LYkZwbDBZODJkRVlFL0t3VnlEYUx2Qi81c01OaTNuMDhKNkxsV3FvVlVC?=
 =?utf-8?B?UFZTbEpiNzVtWTNBN1drQzBJMFA3T3htM05oeXJBQnZHanB5ZFp1aXR6bVJl?=
 =?utf-8?B?dkxCcTlFazhlZSsySUVnb3MzekFLeDRIZ01LaEVvMFBvYjZiZ0UwWi9xN0ox?=
 =?utf-8?B?SWYzUEFwSFV3anM1ZEJiWFBnYkxEN0ZSRC9UR3V4QWVtS0ZxZGdLWlZyWFZp?=
 =?utf-8?B?bFlZSDRWSXJpZUEzQnZNUGswYWw4YXgxZllQb2tLNzhWUDZDR1YxM1dZdUxt?=
 =?utf-8?B?SDBOdUJyaG1sQ1EzN0Jqd3ZNbnVMVkJkQXMxNGtjUFFEQVc3dW9lMFRWeDZs?=
 =?utf-8?B?S0dHYXB5UXVSVVQ2ZlNIdUpUb2YvYVBDSndMWlJTNWVncTZxc3Y2T1VCVTNu?=
 =?utf-8?B?S3JEQ3lQaGg3eWowZWhIRFhJQytzaFBEOTVwR1hoVVo0VjZGZS9zdmd3SThq?=
 =?utf-8?B?Q1o4K1pKVkVIczZkeGFybzdQR255d2s5R3FHRkNWbXJUMFd1K0E1MVNYOWl6?=
 =?utf-8?B?eXFBeEg2UjJiVkZQazBjWWpvdU56WWdmbWEzSng1aVBFOUNRcXNEUlN4LzRt?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1D8E96172CFB444B59828F469A9453F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6A68cKc/IDBzoe0I+Ad+EzxWyiJ6cIxyDZLP3yuu5rrdUTJNcs3cbbDEp4znAj2v5RYDpI96I+0DJjbPbnevZLTjA0uyk2+kdM8VenD8JlPob+dWEspogsivSabJ8Q+5cod1JmZsgwqZDId/WZk7xahYGlAlALQsMWvvYJzLDSW8j4Gwgbc4rE3ssRsen7eJ7pvYMo5UnBeXKgMLQ7g4Bh5gI1ZZp0GQfiegKUP49noQnLeoIuzkE80iyRxzZqsL18izP5OPlWUf3RIaU4vdMzgcKD3Rm8BZyvo1XQLBHL+tasBqotY0OpUW+LPz7KBbG+fthvJt7Mrn5f2ziycwCEPmA2WVDv7OWQAOMEW4KfjrlXo4DftamCUPF3XnPPUZbgDD9S8eaEuEzF/9VyQOPhYOs9WIj6Bo2T9Q0LclnZMdTFMHM6oivW5EpSBf7n2r2tV/JUX0UZsCdhpiTYiYRFT/n7+dL+/P/iBhbz3V/1xeocD5calUJfBeyMUobta6pvtYf6gT526Vm3Brc+Vbb0KbO2xCNwL0Rk2KZA8FSBwKZdtUWHtOJVB6tlgF56c/kyCInqW9gwx1ATQnrRdv6XpotmyDrx22+1SRrCArUZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0769aa5f-2705-4982-5de2-08dcf8dd1794
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 12:19:24.6311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtnrzB1yiXFEkMgSVi+v2q6JS/q1bCPL+ZLRfl2RcfWXn3zuRvhcTjEneNHwKPDtpDVwURs//TFQRFw8uIbLlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_10,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300095
X-Proofpoint-GUID: VbtbjBajTYqon5IAFRpwi5DIIjof2UZV
X-Proofpoint-ORIG-GUID: VbtbjBajTYqon5IAFRpwi5DIIjof2UZV

DQoNCj4gT24gT2N0IDI5LCAyMDI0LCBhdCAxMDo0M+KAr1BNLCBSaWNrIE1hY2tsZW0gPHJpY2su
bWFja2xlbUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBJJ3ZlIHJ1biBpbnRv
IGEgcm91Z2ggcGF0Y2ggKG5vIHB1biBpbnRlbmRlZDstKSB3LnIudC4gdGhlIHNlcnZlcg0KPiBz
aWRlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBQT1NJWCBkcmFmdCBBQ0wgYXR0cmlidXRlIGV4dGVu
c2lvbi4NCj4gDQo+IChOKVZFUklGWSBvcGVyYXRpb25zIG5lZWQgdG8gY29tcGFyZSBhdHRyaWJ1
dGVzIGZvciAiZXF1YWwiIGFuZA0KPiB0aGF0IGlzIG5vdCBlYXN5Lg0KPiANCj4gRmlyc3QsIHRo
ZSBjdXJyZW50IHNlcnZlciBjb2RlIGNvbXBhcmVzIHJhdyBYRFIgYW5kIHRoYXQgd2lsbA0KPiBv
bmx5IGNvbXBhcmUgImVxdWFsIiBpZiB0aGUgQUNFcyBhcmUgaW4gdGhlIGV4YWN0IHNhbWUgb3Jk
ZXINCj4gYW5kIGFsbCB0aGUgIndobyIgc3RyaW5ncyAod2hpY2ggcmVwcmVzZW50IHVzZXJzIGFu
ZCBncm91cHMpDQo+IGFyZSBpbiB0aGUgZXhhY3Qgc2FtZSBmb3JtYXQuDQo+IA0KPiBJdCB3b3Vs
ZCBiZSBhIGxvdCBvZiB3b3JrIHRvIHJld3JpdGUgVkVSSUZZIHNvIHRoYXQgaXQgZG9lcyBub3QN
Cj4gY29tcGFyZSByYXcgWERSIGFuZCwgZXZlbiB0aGVuLCBhbnkgZGlmZmVyZW5jZSBpbiB0aGUg
d2F5DQo+IHRoZSAid2hvIiBzdHJpbmdzIGFyZSBleHByZXNzZWQgb24tdGhlLXdpcmUgdnMgd2hh
dCBpcyBnZW5lcmF0ZWQNCj4gZnJvbSB0aGUgc2VydmVyJ3MgY3VycmVudCBBQ0wgKGEgbnVtYmVy
IGluIGEgc3RyaW5nIHZzIHVzZXJAZG9tYWluDQo+IGZvciBleGFtcGxlKSB3b3VsZCBiZSBkaWZm
aWN1bHQgdG8gY29tcGFyZS4NCj4gDQo+IFRvIGF2b2lkIHRoaXMgcHJvYmxlbSwgSSBhbSBjb25z
aWRlcmluZyBub3QgYWxsb3dpbmcgdGhlIFBPU0lYDQo+IGRyYWZ0IEFDTHMgdG8gYmUgdXNlZCBm
b3IgKE4pVkVSSUZZIG9wZXJhdGlvbnMgaW4gdGhlIEludGVybmV0DQo+IERyYWZ0Lg0KPiANCj4g
RG9lcyB0aGlzIHNvdW5kIHJlYXNvbmFibGU/DQoNCklNSE8geW91IHNob3VsZCBhc2sgdGhlIFdH
IGZpcnN0LiBXb3VsZCBORlN2NCBBQ0xzIGhhdmUgdGhlIHNhbWUNCmlzc3Vlcz8NCg0KLS0NCkNo
dWNrIExldmVyDQoNCg0K

