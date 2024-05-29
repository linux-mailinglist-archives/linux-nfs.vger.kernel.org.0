Return-Path: <linux-nfs+bounces-3472-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD038D375F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 15:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6B71C23927
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D011185;
	Wed, 29 May 2024 13:16:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39811184
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988614; cv=fail; b=ijW/Z7J3U6zycbEf5YjkDWFujnyfx5mQLfYIgc0eY3MRPmtcAh571ZAvsYMLDUK+JY3WDRG1e6zT2cbR1o6zXfB9Ib4p/lYkjpwUdfp229ueMU2+XhLAjmn4tpIzbgDZM4/Jq65N1Z4OlPjOhIpH9fowyGuTdm1dg2VbnXXtWrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988614; c=relaxed/simple;
	bh=lxwmCttbebA6PDuHSa+5bZDD1KomuwVkmc3aiuKWrqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ltL15sGK7m/Cw8gijxzFenRWFCdJ7W8hAN6FZiIcCtIKK5yuQ/HKrH6oPI/JutBLsr/Y8gSwKOAJh7vrxPYq18apGUZpf5/0PRitJxe6mhHfY1Tr7r4tZTSYrwe9ZdtzM20OB2vryHHIhGhauQ5zzuDSQPBOCTqMdnsObJnXbV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44T6IGin011876;
	Wed, 29 May 2024 13:16:29 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-id:content-transfer-encoding:content-type:date:fr?=
 =?UTF-8?Q?om:in-reply-to:message-id:mime-version:references:subject:to;_s?=
 =?UTF-8?Q?=3Dcorp-2023-11-20;_bh=3DlxwmCttbebA6PDuHSa+5bZDD1KomuwVkmc3aiu?=
 =?UTF-8?Q?KWrqg=3D;_b=3DnIjDIXSHk2inma5eXuXE4UhliFJraFOzkucIzIhUooT9OEMDt?=
 =?UTF-8?Q?I2QqzAWbs8r+cKedUIT_k1ov8b2PT1ExF5Ey9qtc8P8/D37Cmsqp+uVdCDwzg8H?=
 =?UTF-8?Q?eQVlaMVSjOj3v6exEwFlkeQHp_lnzZnzJamjj6D0srEeAQw7Z0wd3WwVMPR63Bi?=
 =?UTF-8?Q?uB1zgLxWPy6IODPiOLxn6kyI0F+Yz1A_KIEvMWkEr0n1FMDeJRVhLmkg5fXUj7l?=
 =?UTF-8?Q?Isp+1BmtGktgjrOx+TBFhnlobYU08EvS5a0Ry_qFieBaVeDGbmhaM9ZTc+cSeWF?=
 =?UTF-8?Q?aL451EUbE27l/F5OJLLLPzmXhIVuVGZNO7zGlznzF03_Xw=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fcen8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 13:16:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44TBmOi6014916;
	Wed, 29 May 2024 13:16:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc536rh0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 13:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg6Di0c0hFFNq/wFx2i9cjYnVisGUZO8lN+O7IG2zVc8+IAT4CujXrTtI8LJpvgqyNPJEn3wFV/mv55V8uhy53rCdrWaxekzkAaCJgiPw+bo1qPjv9tScYiaWc8C0qEDJhlTGNgs8APNDvGrAzVm5TVpewKG7HvNld6LK6+wm3u00rv/wbxUFi7JIyF/HXs1LsqJc778b6xArzXRmyAjUj2ubXMiS/wRzGDlRQ/A4y8qPsTAUrPv4Pa2+oNQXwvb/b+KQ1WcpaaRSeqmXpjenYuzyxhKc0qndnhQf4bY8QyC/7HfJnB5IhHmjSvTtUSSBU60YPQpLgP34pfNcxPSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxwmCttbebA6PDuHSa+5bZDD1KomuwVkmc3aiuKWrqg=;
 b=RBizj+bGGi30TdqpTIAWS+KO7PXwHb4OqAtoxFa0smOhZklyJqk99N27rhEd6ZexMHhBKXdZY4idtAei/PW0D9U8Mq/xzTuPUGv2OBxKeUDOzcVoLyeXjoH5DNUwOQQ5S0VwKo1DFwsaJ8sGVYLFrgoG5vk/jkFosng1LErUIgHEBhAlADFvc8llTUD2uGM6iHjejvOA9GOi+SGkEiWnYKdKuH/QLwq6WiQrSH3UKoNcmSHBuBVCScejIAkhDijmTuM0RCVWzsEXncs/7DpiviszNoYZ4VNSB8UcliiSAg+nr9v7NVFjk4k1q8wPNg6ackyWbuEaDW6q9NayA6diqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxwmCttbebA6PDuHSa+5bZDD1KomuwVkmc3aiuKWrqg=;
 b=AVg/oYoNuww9oqo1GLhnnqxI8W5IEjEsDcX6zRQUYafGE7ND4SmGZ0dn3bdhgb3FQXVoxP9h94wEDdbjweJezffykNkenNa+0nmvG3i8zo6stI0Q+sIKeprZpoQdNO+JMPzCNuD/Ko3VlzNxcPdX7mgEMirddN8EMkWAIN8f9H8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7212.namprd10.prod.outlook.com (2603:10b6:610:120::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 13:16:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 13:16:25 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Linux regressions mailing list <regressions@lists.linux.dev>,
        Paul Menzel
	<pmenzel@molgen.mpg.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "it+linux-nfs@molgen.mpg.de" <it+linux-nfs@molgen.mpg.de>,
        Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: Re: NFSD: Unable to initialize client recovery tracking! (-110)
Thread-Topic: NFSD: Unable to initialize client recovery tracking! (-110)
Thread-Index: 
 AQHaknnPaXSa5g+Zzk6CqrxcsNUIVLGhpRgAgAABwACABMvJgIAAUdUAgAeqfgCAAADbAA==
Date: Wed, 29 May 2024 13:16:25 +0000
Message-ID: <459FD302-6EDC-47FD-A703-B0E2916E269C@oracle.com>
References: <aaeae060-2be0-4b9f-818c-1b7d87e41a5f@molgen.mpg.de>
 <e8ab863e-18a5-4c16-b0c8-a3ab6440a9f6@molgen.mpg.de>
 <5096230634b5bab2e5094c0d52780ffe2fa75bb9.camel@kernel.org>
 <90700421-4567-4e28-ae71-8541086b46e2@leemhuis.info>
 <5360A648-8236-466C-A9D8-82F2BBE6F059@oracle.com>
 <fcec2a033773a2129e0271c870d1116681feccfb.camel@kernel.org>
In-Reply-To: <fcec2a033773a2129e0271c870d1116681feccfb.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7212:EE_
x-ms-office365-filtering-correlation-id: 4c74a941-1ef3-49d4-41fd-08dc7fe18b1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UU1LdGQ0THRsRnpzb0dzUEhLWTZLemNxVzRkVktoV1I3R2lXYVE4QjFhOGNk?=
 =?utf-8?B?T0FSYU1ZNjJJdm55b1RabUJzb3VVa2pnVjlWcnZCKzFYU1N4UUJmU0U3aDIy?=
 =?utf-8?B?RVVDVWVTbzEyb0ZBZkhiR0NEeE0wa3diVlpFTklXWHNxVCtaZUt4L05ZOFRJ?=
 =?utf-8?B?TlpUKy9scTNLNGo2TmhhZXEzcXRCZGFJbG5IZEkyNmM5T2VETk00aGRJbzFL?=
 =?utf-8?B?Q0daNjFXeGk3VnQzSVlSZW1VeVcwcmVHUENhYXY4Yld4ZDFCK2VxTTVkQ1Uy?=
 =?utf-8?B?WkpTbWpWOStoVTRjQzBIMkM2MW9tZndZY3hicDFJOUVvREFNQTRtOHI0dXhF?=
 =?utf-8?B?YWd2WnZ6UW9wRFhxQldBRFlzTHlZWVNwVjJwYmpESlB5amc0T2xXcEZqMTk1?=
 =?utf-8?B?UjEydFZEK0U5YlhleTZNM3plUkxUWEo0UGRKS1BMOHhSZG5xcUw1bGI2dHNz?=
 =?utf-8?B?bitMeDJSWVBOMTFNQjhSYTlRZHUrVXJ5eU5iM2N1UEU3akYvc0pGR05wYWxh?=
 =?utf-8?B?eUh5YVJ4amc5WS9ING81bXRBYS9BZmFPT3VGdWRBSXFGekRTZ2k3azJDLzhx?=
 =?utf-8?B?bEVxUHp6bXZhRGhWNWpKekZCN05NRlR1QWJDb0pjc3J3ZGhiaGhKYmkrbkVR?=
 =?utf-8?B?ZXQySGVRaFN3dUdISGR1U01XTGo4Vlh2ZUpESlBGamN5cjYvVjdtcnZWTlBr?=
 =?utf-8?B?L0VmcGUvUGRzRkNPK2xNdTVadk1LSlRBRjZHekVyOW9uU054dlczMFJ3bExi?=
 =?utf-8?B?REZiMEI5VnFvS1VVUjFDb3I0NFU4bk5DeWpWOWtvNnlWRitEWDRWMGU3YTZ3?=
 =?utf-8?B?MkRmSWZSVHNLbng0blFaM3Q3NThCRE9qbU0wcWQweDBnaXVLcmw4WHNvQVMx?=
 =?utf-8?B?NG9nY3BXcGovSGpmMVY2dW9iaVNyUlNkRi9tUEMwL1ZOWEdNek5oc1FCb1VE?=
 =?utf-8?B?ZFBQZW95UFh2NXZwUUJwOTF0UU55KzJTVmloZU12OGh0VHgwNEhtdGN6b3BZ?=
 =?utf-8?B?MkVnZ0ExVHU5ais1QnI3a2FrMFlUaloyOHAyNk9GUnFoV1VETlAvODVZOGpa?=
 =?utf-8?B?WDJlMlFPcHRhN3hOUTlpOEM5dW5OYW0yNUtsZmFhM2Z4ZEVXNHk5MytSNDBL?=
 =?utf-8?B?cXJ2blNBNWNJR255amFpUXJCdmUwc1BrWnpTd2NzRERtRXVjckxUczQ4dEIr?=
 =?utf-8?B?QkZhQmlnajNFNzdFSThDaHhFSTM3a0JkdUNUY3NWcWZUT0lrQ3Z2bk9DZk54?=
 =?utf-8?B?cDMwY1RCL1p0R1ZnakhJUzJkT2YvMFVNQ0VodFlIVDVqN3FNaUxPMEN4RFg0?=
 =?utf-8?B?ZmJRQXMwc2x2eVRmeHFxZ0VFaTM0QzFSWjg3ajhzZW1oeUFDK2FvNExkR0Rx?=
 =?utf-8?B?TWx1K3cwZTFHTk5hNG9EWW5LU1NpbW96dGtGWnRoNVA2b0NHbVNtSnp1WmpJ?=
 =?utf-8?B?djh3T3BJUDlIZHFtRGtZUXJ6RXE2WHN2YVIyeVlEOHFJenZSSkdQL2ZPR21D?=
 =?utf-8?B?RHZhZGd5a2NRZ3c3S3RJWFQ1dFJNbm1rNjdLWkJsN0lPK2JxQU4vQ3hjd296?=
 =?utf-8?B?bHFGR2tTWS83bUFSTFlZckdldWZVUVEzOGdMSkJoNGxyTzZjRHRicE9aV2Nz?=
 =?utf-8?B?K3ZQQlNSRm9wc0xpS1V3NnBkMTBPZkFlTjhTNWpRN2FIVGRpbklrYWdXZisz?=
 =?utf-8?B?NytON00vNGdIU212T2hPSG5ORkM3S2Y1K3dZQlhSSnhia3hlVHRoZ3cvdEZM?=
 =?utf-8?B?a1RyOExUTVZUK1luRS9kcG43Wm1xS0pTbDIyUExxY2V2UGcwRGlBT21lWTlC?=
 =?utf-8?B?b25RZmx6TzR0SXdzZFYyQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S0xGaktlOUgzTFY1TGhxeDJEeWl2ZmxUMi9HbnZNek5mdVE5Qm5HMDY0UVNq?=
 =?utf-8?B?OEUzZnVVMHJZNDJxd0NHM3c1RnpuTU1laTNkVHBWVFZ0NzFFQnU1UEp6aHdt?=
 =?utf-8?B?ZHlEc296OWpDZ0MzdUVTblgwcThqanN6Z0c4Q3BEa3hFR0xlQlAvSGxBemM0?=
 =?utf-8?B?WVNzNlNaNU9FNU1EbWRacCtOeUdmYmxLZHNFTzM3L0VheGVIZHZtWVZiNTFn?=
 =?utf-8?B?YXNoVHlxcTJ1Y2tMT0hsKzNxUUZoeDlxQmtEQnNKZzZSaDhaaExEOVl2YnZv?=
 =?utf-8?B?Q2RWTmRBVlN3d2NvTU4vRm9UTDFqTkplMlU1aTN4cWhtTGs3ZHdxT1MrQWkr?=
 =?utf-8?B?OXFnRTdrSDdnYmNvandMZ2lkSkpYSGtlVExoNS9JaGE2R0xMQ0ROU0JWajcz?=
 =?utf-8?B?eklSQUdNbmJTbHdZa3dYQ3R4R2ovdjI2WnRFTGd0VGxOckdtMHp4SGRhaWE0?=
 =?utf-8?B?S2M3WU9ZOWx5U2RteU1zbHN2MEhJbUlnSGRRdWZKSUZZT1NBTm1LV3VMemdY?=
 =?utf-8?B?QlA4Mk1QZW9ZbTAzbGkzWm1mc1QzWmFTS3V4Y1prdzNNTk1VMi9keGgxem9o?=
 =?utf-8?B?OTNwQXh5OFR6UUdJa3k4em1xSkRzMEtqWE1JcklEQjNPdG1iUm5Hek1tRWNY?=
 =?utf-8?B?RjN4RitTQndGWDMrNHBHeWF2VGVzM2lBS0tKKzJsZG5VQVRxeFdLOWMvZi9a?=
 =?utf-8?B?bURQcWQwb2tWa3VEM2RkcDFqUUFDYmc0M3hzS1FoMjlsWEVWakN4M2RmUEkr?=
 =?utf-8?B?cUpiNnFWRmhTQ1F0bXpSL292ZEs1VHoxc2FUcHhHczVVQzhpS2h4K1ZsclVK?=
 =?utf-8?B?aGtlZlJZZ1JkcnhDUWkvNjlka0NKUnZzNlRYUE5IYVV4Y21vakZTNk5kUFdq?=
 =?utf-8?B?V3ZjdzB6QXdPMUc3Z09vQ3dXS0MyYlpicG9FYkdhSng2UXVlaWlTRXVqVXh2?=
 =?utf-8?B?OXplSXF0LzA0cjRpU1VWazMvZE1pVVJyWlorb0JKbkt4K2xvcnRUazc5Q2Iv?=
 =?utf-8?B?MTNQMEFUcFZtMmRxRWV2L3lGWmtkVWFRM1E2eW9qN016QTNuVm5ITXdmOXFN?=
 =?utf-8?B?KzdrM1ZYZW9kNjV2cXhIYTcvdzBEZDY0UjBsRlBhZ3IzSjdKUysrTHJqOE94?=
 =?utf-8?B?U21TcGtCSFZ3Y0puaUx6MFFjT3Z5cGZleEhTRTZ5dURtZTdlV1ZHNmFPQXFZ?=
 =?utf-8?B?VGVvaXVhK2p6N3lMTjNHTGo4bEw3djZlb3ZTTWZvbUlMVjNJaklJRzYyT0xj?=
 =?utf-8?B?dEU5aFEzbkJqZUJ4T1ZyYkRUSURSU3BBcVFaL3JSeENxMXAwL0grQTJVNVJ2?=
 =?utf-8?B?MnVDQko5Z3g0OVVtUFV0bjhmSjJqRFRsbHdIM2Z5THJWN1ZSTERmSGJCVHNv?=
 =?utf-8?B?bTFUQ0VEbjlxWFNTYXhZalZpTzFvU2ZrQytyV3VXYk9nbllDTWl6L3VsY0lJ?=
 =?utf-8?B?Zm5VWm5KaUloYXVzTXJpQlhCaHdLYkFXYzFpOE9zcWVhMUhMM3QwbmQyWkNa?=
 =?utf-8?B?ZElxUVh5ODlUUFJza1U2L3hUR2lCSFRHdGE3NjdScEpuWHRIY2x4T2V6eUpX?=
 =?utf-8?B?MFV2UDVVZ3FxcHJjWjNxRHhsZllndW5LaEd6cXVHb0pnaDFrdnN2eHhrZzdO?=
 =?utf-8?B?ZGFDZXVIU3pyUUFKcExENWx5K0cxcGNOZDJqb2NWclhoR2VTbVN3ZUxvaW1T?=
 =?utf-8?B?ODhCSktaVzVjd0RhcFhDUi9Qck5zTmRCNGNDSCtyUDFXaFNQQ2tkYko0bU8x?=
 =?utf-8?B?bkpUekk3NVlRVzA5MHBUTEZLa3d6cklMQmNZcVZWR3JLaEE5MDI2eUE5L0dF?=
 =?utf-8?B?SFpKWUV5T3Vad3pOV3dHanNiZzNmR2RqMDRwQytmMHRKRzZaZzloZFZQMXda?=
 =?utf-8?B?UXhCUkFpeTNGS2NKRTJxY2N2aWM1OVpDK3dKWFQrQ1owM014dC9Ca2R5TllB?=
 =?utf-8?B?REEzenMrNHlGNTdDY2E0OFJONWFGYytlQ2tic2NabVFaK2ttNU1BYVFFL3pq?=
 =?utf-8?B?VGlCY0FCMndKMXB6V250NjBSQ09LN1IraFlUaFZja1NFaVgrZjZEMlRKZ3Vr?=
 =?utf-8?B?akhlOFlqUm1RdnhRTDloMWJIK3RUMW9vRDhOWjQ0QW53bkdNWmF5L2RSVFdJ?=
 =?utf-8?B?dlVGQVh6OXpiNmt4WWU2L2l3TS9BSVIzcGwyOHJSZ0pZSm9ZWlJCb3ZXdDFh?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46E7CE3ABE6C8D469C329A202C3699CC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XrRvacEya9ckU1QngidUlLnb6+auJcCorUO2/pNE+KoCmNIYj9OEYEvKWswqvTy1Vj19w2HaWWjQhbBuPVs16iGkEMaVevqZNC/VplRxsRpaUwDfdz7CpniKid/V2tXtZygBnTLJ9Y3XLbUi4Ux3Yl1/x1udWwl4a435EPNO0Zm5G1GqyuwMUSKQeEitYDEhsKWvVLu/St7NhDzbmgUiK5wuPKXKoX5Kj1L/gI4Z9pRpoaX42lKJQkacNz3i8i0KzeQ8xoLCKQYpOyo/48RKn1XDY2x0qnj0Yqb7kn//pUcTU/F6igkzjFmk51pp20/mcjQeS3ESd7O1JaYsO4LMVFQVqOxHwaAVA2VD80hexQv4ZXmSo22lf+mjbxRdUgBxkUUPOSwZITx2HJR7DBHjeJr7M6mHBSf/4pZ0Ix0u9ieLuLcrmVQavF+AtsBj9jr0HS5OpHp/fk3SjxntwIcTS+qd2bdD5BuLevFghWNbFXKLDuzmCZfr0ZOn/0uax5TzMjfG/ZTda8J+puvJNo9Qcgz6rwpVHGxA9tdLzhMwgN6KfY2SOniqVmsjotq5SRYsKG/n7cAqyc3k7sQzDt9I7RENxJcHR7F5hbJis9JaOCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c74a941-1ef3-49d4-41fd-08dc7fe18b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 13:16:25.7479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAzmLxO7Gs/+CtYcj8tCd4bBdr3sMWzmuqxzLXpDJXrkA0lO0gFsiMurZC36zzI99WephwScpTss9291wEkCRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_10,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290090
X-Proofpoint-GUID: Y13xDxBehw2w_MxHXdRl7L4OGlMJY1xM
X-Proofpoint-ORIG-GUID: Y13xDxBehw2w_MxHXdRl7L4OGlMJY1xM

DQoNCj4gT24gTWF5IDI5LCAyMDI0LCBhdCA5OjEz4oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMDI0LTA1LTI0IGF0IDE2OjA5ICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIE1heSAyNCwgMjAy
NCwgYXQgNzoxNuKAr0FNLCBMaW51eCByZWdyZXNzaW9uIHRyYWNraW5nIChUaG9yc3Rlbg0KPj4+
IExlZW1odWlzKSA8cmVncmVzc2lvbnNAbGVlbWh1aXMuaW5mbz4gd3JvdGU6DQo+Pj4gDQo+Pj4g
T24gMjEuMDUuMjQgMTI6MDEsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4+PiBPbiBUdWUsIDIwMjQt
MDUtMjEgYXQgMTE6NTUgKzAyMDAsIFBhdWwgTWVuemVsIHdyb3RlOg0KPj4+Pj4gQW0gMTkuMDQu
MjQgdW0gMTg6NTAgc2NocmllYiBQYXVsIE1lbnplbDoNCj4+Pj4+IA0KPj4+Pj4+IFNpbmNlIGF0
IGxlYXN0IExpbnV4IDYuOC1yYzYsIExpbnV4IGxvZ3MgdGhlIHdhcm5pbmcgYmVsb3c6DQo+Pj4+
Pj4gDQo+Pj4+Pj4gICAgIE5GU0Q6IFVuYWJsZSB0byBpbml0aWFsaXplIGNsaWVudCByZWNvdmVy
eSB0cmFja2luZyEgKC0NCj4+Pj4+PiAxMTApDQo+Pj4+Pj4gDQo+Pj4+Pj4gSSBoYXZlbuKAmXQg
aGFkIHRpbWUgdG8gYmlzZWN0IHlldCwgc28gaWYgeW91IGhhdmUgYW4gaWRlYSwNCj4+Pj4+PiB0
aGF04oCZZCBiZSBncmVhdC4NCj4+Pj4+IA0KPj4+Pj4gNzRmZDQ4NzM5ZDA0ODhlMzlhZTE4YjAx
Njg3MjBmNDQ5YTA2NjkwYyBpcyB0aGUgZmlyc3QgYmFkDQo+Pj4+PiBjb21taXQNCj4+Pj4+IGNv
bW1pdCA3NGZkNDg3MzlkMDQ4OGUzOWFlMThiMDE2ODcyMGY0NDlhMDY2OTBjDQo+Pj4+PiBBdXRo
b3I6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+Pj4+PiBEYXRlOiAgIEZyaSBP
Y3QgMTMgMDk6MDM6NTMgMjAyMyAtMDQwMA0KPj4+Pj4gDQo+Pj4+PiAgICAgbmZzZDogbmV3IEtj
b25maWcgb3B0aW9uIGZvciBsZWdhY3kgY2xpZW50IHRyYWNraW5nDQo+Pj4+PiANCj4+Pj4+ICAg
ICBXZSd2ZSBoYWQgYSBudW1iZXIgb2YgYXR0ZW1wdHMgYXQgZGlmZmVyZW50IE5GU3Y0IGNsaWVu
dA0KPj4+Pj4gdHJhY2tpbmcNCj4+Pj4+ICAgICBtZXRob2RzIG92ZXIgdGhlIHllYXJzLCBidXQg
bm93IG5mc2RjbGQgaGFzIGVtZXJnZWQgYXMgdGhlDQo+Pj4+PiBjbGVhciB3aW5uZXINCj4+Pj4+
ICAgICBzaW5jZSB0aGUgb3RoZXJzIChyZWNvdmVyeWRpciBhbmQgdGhlIHVzZXJtb2RlaGVscGVy
DQo+Pj4+PiB1cGNhbGwpIGFyZQ0KPj4+Pj4gICAgIHByb2JsZW1hdGljLg0KPj4+PiBbLi4uXQ0K
Pj4+PiBJdCBzb3VuZHMgbGlrZSB5b3UgbmVlZCB0byBlbmFibGUgbmZzZGNsZCBpbiB5b3VyIGVu
dmlyb25tZW50Lg0KPj4+PiBUaGUgb2xkDQo+Pj4+IHJlY292ZXJ5IHRyYWNraW5nIG1ldGhvZHMg
YXJlIGRlcHJlY2F0ZWQuIFRoZSBvbmx5IHN1cnZpdmluZyBvbmUNCj4+Pj4gcmVxdWlyZXMgdGhl
IG5mc2RjbGQgZGFlbW9uIHRvIGJlIHJ1bm5pbmcgd2hlbiByZWNvdmVyeSB0cmFja2luZw0KPj4+
PiBpcw0KPj4+PiBzdGFydGVkLiBBbHRlcm5hdGVseSwgeW91IGNhbiBlbmFibGUgdGhpcyBvcHRp
b24gaW4geW91ciBrZXJuZWxzDQo+Pj4+IGlmIHlvdQ0KPj4+PiB3YW50IHRvIGtlZXAgdXNpbmcg
dGhlIGRlcHJlY2F0ZWQgbWV0aG9kcyBpbiB0aGUgaW50ZXJpbS4NCj4+PiANCj4+PiBIbW0uIFRo
ZW4gd2h5IGRpZG4ndCB0aGlzIG5ldyBjb25maWcgb3B0aW9uIGRlZmF1bHQgdG8gIlkiIGZvciBh
DQo+Pj4gd2hpbGUNCj4+PiAoc2F5IGEgeWVhciBvciB0d28pIGJlZm9yZSBjaGFuZ2luZyB0aGUg
ZGVmYXVsdCB0byBvZmY/IFRoYXQgd291bGQNCj4+PiBoYXZlDQo+Pj4gcHJldmVudGVkIHBlb3Bs
ZSBsaWtlIFBhdWwgZnJvbSBydW5uaW5nIGludG8gdGhlIHByb2JsZW0gd2hlbg0KPj4+IHJ1bm5p
bmcNCj4+PiAib2xkZGVmY29uZmlnIi4gSSB0aGluayB0aGF0IGlzIHdoYXQgTGludXMgd291bGQg
aGF2ZSB3YW50ZWQgaW4gYQ0KPj4+IGNhc2UNCj4+PiBsaWtlIHRoaXMsIGJ1dCBtaWdodCBiZSB0
b3RhbGx5IHdyb25nIHRoZXJlIChJIENDZWQgaGltLCBpbiBjYXNlIGhlDQo+Pj4gd2FudHMgdG8g
c2hhcmUgaGlzIG9waW5pb24sIGJ1dCBtYXliZSBoZSBkb2VzIG5vdCBjYXJlIG11Y2gpLg0KPj4g
DQo+PiBUaGF0J3MgZmFpci4gSSByZWNhbGwgd2UgYmVsaWV2ZWQgYXQgdGhlIHRpbWUgdGhhdCB2
ZXJ5IGZldyBwZW9wbGUNCj4+IGlmIGFueW9uZSBjdXJyZW50bHkgdXNlIGEgbGVnYWN5IHJlY292
ZXJ5IHRyYWNraW5nIG1lY2hhbmlzbSwgYW5kDQo+PiB0aGUgd29ya2Fyb3VuZCwgaWYgdGhleSBk
bywgaXMgZWFzeS4NCj4+IA0KPj4gDQo+Pj4gQnV0IEkgZ3Vlc3MgdGhhdCdzIHRvbyBsYXRlIG5v
dywgdW5sZXNzIHdlIHdhbnQgdG8gbWVkZGxlIHdpdGgNCj4+PiBjb25maWcNCj4+PiBvcHRpb24g
bmFtZXMuIEJ1dCBJIGd1ZXNzIHRoYXQgbWlnaHQgbm90IGJlIHdvcnRoIGl0IGFmdGVyIGhhbGYg
YQ0KPj4+IHllYXINCj4+PiBmb3Igc29tZXRoaW5nIHRoYXQgb25seSBjYXVzZXMgYSB3YXJuaW5n
IChhaXVpKS4NCj4+IA0KPj4gSW4gUGF1bCdzIGNhc2UsIHRoZSBkZWZhdWx0IGJlaGF2aW9yIG1p
Z2h0IHByZXZlbnQgcHJvcGVyIE5GU3Y0DQo+PiBzdGF0ZSByZWNvdmVyeSwgd2hpY2ggaXMgYSBs
aXR0bGUgbW9yZSBoYXphcmRvdXMgdGhhbiBhIG1lcmUNCj4+IHdhcm5pbmcsIElJVUMuDQo+PiAN
Cj4+IFRvIG15IHN1cnByaXNlLCBpdCBvZnRlbiB0YWtlcyBxdWl0ZSBzb21lIHRpbWUgZm9yIGNo
YW5nZXMgbGlrZQ0KPj4gdGhpcyB0byBtYXRyaWN1bGF0ZSBpbnRvIG1haW5zdHJlYW0gdXNhZ2Us
IHNvIGhhbGYgYSB5ZWFyIGlzbid0DQo+PiB0aGF0IGxvbmcuIFdlIG1pZ2h0IHdhbnQgdG8gY2hh
bmdlIHRvIGEgbW9yZSB0cmFkaXRpb25hbA0KPj4gZGVwcmVjYXRpb24gcGF0aCAoZGVmYXVsdCBZ
IHdpdGggd2FybmluZywgd2FpdCwgZGVmYXVsdCBOLCB3YWl0LA0KPj4gcmVkYWN0IHRoZSBvbGQg
Y29kZSkuDQo+PiANCj4gDQo+IEkndmUgbm8gb2JqZWN0aW9uIGlmIHlvdSB3YW50IHRvIGRvIHRo
YXQuDQo+IA0KPiBJJ20gbW9yZSBjb25jZXJuZWQgYWJvdXQgUGF1bCdzIHNldHVwIHRob3VnaC4g
UGF1bCwgd2hhdCBkaXN0cm8gYXJlIHlvdQ0KPiBydW5uaW5nIHRoYXQgc3RhcnRzIG5mc2QgKGFu
ZCBwcmVzdW1hYmx5LCBtb3VudGQsIGV0Yy4pLCBidXQgZG9lc24ndA0KPiBib3RoZXIgc3RhcnRp
bmcgbmZzZGNsZD8NCj4gDQo+IFJlZW5hYmxpbmcgdGhpcyBmb3Igbm93IGlzIGFuIE9LIHdvcmth
cm91bmQsIGJ1dCB3ZSBuZWVkIHRvIHVuZGVyc3RhbmQNCj4gd2hlcmUgdGhlc2Ugc2V0dXBzIGFy
ZSBjb21pbmcgZnJvbSwgYW5kIHByb2JhYmx5IGRvIHNvbWUgc29ydCBvZg0KPiBvdXRyZWFjaCB0
byBnZXQgdGhlbSB3b3JraW5nIHByb3Blcmx5Lg0KDQpHZXR0aW5nIGEgcm9vdCBjYXVzZSBmaXJz
dCBzZWVtcyBwcnVkZW50LiBJIHdpbGwgaG9sZCBvZmYgY2hhbmdlcw0KZm9yIGEgYml0Lg0KDQoN
Ci0tDQpDaHVjayBMZXZlcg0KDQoNCg==

