Return-Path: <linux-nfs+bounces-2790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A38A32FB
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C911F2143C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C9D84A35;
	Fri, 12 Apr 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QYh21pxg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mpCNpzrV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05882127E00;
	Fri, 12 Apr 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937516; cv=fail; b=SO1Xhknv78ft8Q86gHbXwZ3Dw6CMq2y2qRJar+KXX298DTFTxgqEuXCU3TcAWD+HLiGzaOqllS+ygDU5jmCGwwH0aSTHtabjMcVRilcmwhOMWIL7TDYr04c2WBsn+YBNHSfKlbQjGyrG97h+3NocRpuaiecXPXcGj/Q4pcgZA5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937516; c=relaxed/simple;
	bh=XNShAzlSfK1TTSnGunQMvF1r+jlXFOdGtMI+SB3BVU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b7lkOrArvpl4l+gbEIcLz5pfOTgoNivVZWp7O31xdE7NUKrkLD6Zszu8MCwO3EfNYcNWnvzEUfnRzvqCf9PzKdPOPiZRoKxlHUey1FJM119ORTwIGX162vqwXS74hibS/UlNgxZpevtmI4cCYXIBUIm4lgvHiuSTnif7Deqztdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QYh21pxg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mpCNpzrV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CFSxNZ025458;
	Fri, 12 Apr 2024 15:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XNShAzlSfK1TTSnGunQMvF1r+jlXFOdGtMI+SB3BVU0=;
 b=QYh21pxg9hbyzlzymhy438lY3Et+aGzjO+XbK60AkwAkeFiMFraFittatrBQcQhIX19p
 GgL7um5Sn3xwQpwekYDLQRqr7P0EiS1VOmxpOntdU6BOowDW2zBkGhHrdQccBO87rW/5
 /UbyqaDJaJ49YVJpNUwQFHR3DTT1GwU7Y5D9t6oUU1bjaiR/o3dFNLnWVQwcFpg0Gqs/
 Iup+uPGLwWtGDINsAZsWHezWmcetpbyzxXX9mblNa3fyBVtMn4dGlrfdOmK3A7y3dVWC
 p+jNxzPoAmo9T0ABJLS8W/qx5eX7YPdm6ZLGymoNo63KcXMrZZQQhBcdjazf/k2Ce+4A TA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0uv8fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 15:57:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CEtG44032527;
	Fri, 12 Apr 2024 15:57:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavubveu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 15:57:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2ydndQxFCqIZT0ub9vqjXsgdO2GKKgHNRlLuvn96V1/ghfUVgLyecCJBh+fDgXronOJyDmZIAnjQ/nf0x0UIFeXVTso2zC9RHmO7++H+yu684RDRji4t6C3YRBRAY4oAPVI/Sd+SeW/eJlqDscmrrPS+tfeaQfiAATqkz7KTdMszckRYJ8gB/qUK1kpk7yhKp2pZVNXgM9PlSDfpoes8mzdHPG/onzSJwC47IbYlMlxTY96nsD51eneXxmqfNWEKaWv63HsU5sWvj3xsqD0f0cF5Jy6tuJMXSxPNt0bfdfF/ncRcVhmiOdJCpSEUp2h2fNFdiDqp1fZK362Oz8s5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNShAzlSfK1TTSnGunQMvF1r+jlXFOdGtMI+SB3BVU0=;
 b=ErN16k/ygPEgoUWEmF7JveF5GIoquKVV+W/hoOBTUWW8kuQ5IMSCFGT8Td3VFCjHB4tLdZcWvzX1aOi8QI9pO5paiyAdAGmJg32u2zCQ4lhd40v60xukEe6mmJd4sSST4xUQz57lqXupsGyCPHxUbKcwq6T4Jnvu7/pD2/IBKMBwEmnUVLv/rUsg0NsOn86nnxhhuV9g58/KG8uhdejENySBs6JZwOCOWnU7G4JAOqOhkeKsJKtrRlLPXF3MZjF/nEpmZyXACYzo7xMWN7abuEQz4/RdZlp8AOiKGOERqIhgaVb0gBDYjvgnbwcUq9dCJYSiHwIgmsfH8LYbMv+SOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNShAzlSfK1TTSnGunQMvF1r+jlXFOdGtMI+SB3BVU0=;
 b=mpCNpzrVjen8FDVGQVRTgD0XOwNAt7I9wObo5ebrA+jIUP5+j9OzJbWbHLcge5HnVc2TgNo1ey3hVbKNxX//oK6dfrguSNUjR33njLkm/rHkUpfY0C6EwKo0QLd+nOPLCqt8RgUTRGUXMYKzP3SSEDLsIADXBhrgVYlWaRKfYkc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6911.namprd10.prod.outlook.com (2603:10b6:8:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 15:57:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 15:57:41 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stable
	<stable@vger.kernel.org>,
        "patches@lists.linux.dev"
	<patches@lists.linux.dev>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org"
	<lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com"
	<sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "broonie@kernel.org"
	<broonie@kernel.org>,
        Calum Mackay <calum.mackay@oracle.com>,
        Vegard Nossum
	<vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Ramanan
 Govindarajan <ramanan.govindarajan@oracle.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
Thread-Topic: [PATCH 5.15 00/57] 5.15.155-rc1 review
Thread-Index: AQHajMPIFIcgDdJbIEGjTzdT8pNNkLFkyriA
Date: Fri, 12 Apr 2024 15:57:41 +0000
Message-ID: <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
References: <20240411095407.982258070@linuxfoundation.org>
 <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
In-Reply-To: <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6911:EE_
x-ms-office365-filtering-correlation-id: d64dd5bc-787f-4613-2493-08dc5b0948fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IK+Sg5VOdC1EeNnOa3jI73C94Oww3rqawtWmLFGQXZEalpVv5CHS0iSNWMd1a9iim9I2tx92GlyfvcbnG0NYD4ACHzDiKUwcMfFEx+B3OtcN/6HMW7prxGQ6YDMAwN6aG/8Nuix7ps716fzyu6ejYc49TL2yw85+ajufHMSboXQg4GepMcxHw7ckW38EZpM9+GZTV6WMhyTJuesXAfiI5gxT9bTbtww24Npq7ShYmFMk9Q9cqJqKJI7QQasLl+H/LR56tZkRNXaDbwJQSHLfqMFDYfcQ7AXBvpJTXfIquHE+ajYsEG7KnBHhtiSXr2m3+W9IjEDTExnzoXsraFyPWYJ7Ub9czY+qGl0AmjPnMRFEtb4ZqSCZ3c5CNSJViswTaUQbVN0srfsRsQXCzGuh95v/AoJPOq1uCN7rRwsmdtEIoNPMkCt+Kcjk4SxlfwKoKjhE885VPP+dNV0ZUDS6jt91a6aNau9hKcF/jMWQuGfZDutjp7ETsh1zCGWcOA56GhWyWKNI1bkr0hoNhiZ1zYFePuaWMB10SXKYSlJDT+/pv1E0L4+98Jzq6NkMqJK6KIFCQCMUhsYx3wgPwoxrEeLE17uusRzl19wHiM5pz7eFxmgput3g7WmI+enD6A8XLxWI/2+nxmwch7fiFrwRusQADiDE8Y8S6o/jcMduq5csVj/2JNzvl0g9O4Xz5D7NTO95X75uBS9MObE9Z6k7kT9XevI+uMlUpIKG7EHLpZg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N3VJUjc3U09XUGhaSXVyTm5kdUZoQWoxRUR2T01aazJya0xMZ3ZBTmZnVDdQ?=
 =?utf-8?B?cVk4VXZ5bmUzSjN3eWZWK2EzVGhjOXIyOWpnUEVDVmFwcHlUajVuNTV1TlVE?=
 =?utf-8?B?Tmt0bzlibEFEZDFSS1FkMjc4TzRqVktEV24rZDhIakRGU2FERTZPbVZDMVh5?=
 =?utf-8?B?ZWlDTjRXbmtudGZrVTRsRlkxSXQwMVdiV3hIMzl4Z2d2TmhwUmx6REt4OG0x?=
 =?utf-8?B?Q0x5SllOUG0xSXRiYUs1b0NNUVJCUTh2SE5CMysrVlJtdEZjUXJ3ZERhWERx?=
 =?utf-8?B?MnIrMjNqUXdkSzhjVGhFNHBjZmR2bnU1eHRkc3NqKzlYQkNhMUVDOXg0a1Ro?=
 =?utf-8?B?cFVvNlo0TkxTUkhIVlBkRVlvVlBLWFl4UlloeXd4emtlWlAwVVpzNGloS3RZ?=
 =?utf-8?B?SlBKdzE5YTk2SjZQS2h0UVRDdDVhL1hjbDJnNEVPaStwWmFKMk5VdEVxanBp?=
 =?utf-8?B?UzY0SzFjRXNRcklqTSs2VmFYNy85MCtiWUtNd1BDajhUZ2VGMXUyMG1UMlgr?=
 =?utf-8?B?MUhmcDEwUXRoSnY0Z0E5MXltaGlMaDNmOWhwMHN2b0xkaVdoMnBWWDg5a2pr?=
 =?utf-8?B?cFZML0E5bEFwVGU0V0FaaWZFREE0dmY3K0QrVm5GSGw1eXJLZU1laEpRZGZn?=
 =?utf-8?B?V3lXQjBSTUNiZXp2amdWajRHemZhQWwvVDFpZEdieGltSUJDaUEyZ2cxVkNH?=
 =?utf-8?B?d2JreVk4djczSWRaaWtwWUJGNmEvY09MS0FUeTFlSlNQMEJ1UFJqY3dXSExJ?=
 =?utf-8?B?Y2VnV0xaWGdTeWw0aEVuOG9wWFEyRHVrd3VqdjFlRmVtVlFlNFlGWkhWenov?=
 =?utf-8?B?N2RqRmtIMXNTY0d1emtGZHFySTJsZHNVNUFWd2RTRmlVUzZWdUZaOUNpeXZB?=
 =?utf-8?B?cDdLUEk5OVgwZVNsQ1BpczdwMVN6dWlCS1Nxd1J0NWlWTjc0VTZrSkU5WElB?=
 =?utf-8?B?em1SMGlPaWpGTEFQREFQUUM2S3BxZ0FjcklKUWpXR2lEMGRHMmNpNlBmNThG?=
 =?utf-8?B?MzF6N1dqeUcvQ2F1TGZieWYvTkkyZnkrZER1ZEQzTkMwci9Nd0wxNEw3UHVj?=
 =?utf-8?B?WnZnSkh6QkRsVDMxUUxLYkszYnBrZmVzcGl3L1N1RUJWRFRpMVBPVnZtTnlD?=
 =?utf-8?B?bDRzNXp2ck5WM2tXMWNvNzlTSDRaUVhCU2tWSXFxdnpxcCtWdEtwOFM3d00z?=
 =?utf-8?B?QXV0cll0eThZeTVrTnZPeXJwb01ZbG9FSk9YNzhVM1RLQlcxRCtGMW9BZzNT?=
 =?utf-8?B?dlc1MnorVHNkWEFrRDRLVDRkZk0xR01kMW1BMTB3TlEvQWxMc2lONDdnTDZo?=
 =?utf-8?B?ZHBodVFLYytxKzRtSVU0Y0xoNlg0TmhxQkU2bjJaVlRFd25uZlVRdWF5UlNa?=
 =?utf-8?B?RnA4SFkrVGl4VHpUVEQzSzRhOGlLWFBBY05IWjJRV3FzaCs5b05RdGNGWHBn?=
 =?utf-8?B?bDBsY1YwYjZROVQ4VlRMaFlXRVpjT2tpcjg1WjJjWXlQUmREV3Z6aVV4UlNT?=
 =?utf-8?B?d0V3QkJSSHdQV0p3aUt2VWwvUUFvL2ZjM2lqVVdWbGh1QnU0aXZkZTlnaFFS?=
 =?utf-8?B?RTZPZDVRVU5LSUFrREJGK3NoZnh3Wm5qYW1IL0pBSS9FZkN4VHROb005czlY?=
 =?utf-8?B?dHM1L3k1TDN4UWRsdXVKTmw1QmFMUlp5OHhOSDNENGR4RUFsYVdYeVU1dGhy?=
 =?utf-8?B?QXNDSnFNMnkySUxQb1BvdGlLaGN6ZVBHM2FqaUx6d2xUNDdFbGNGUWtKUmw3?=
 =?utf-8?B?NklqQlRoRDhIQ2xIR293OHlVcjhFY1QwRklWTE13OTJRSS9OVi96Q3JjQmVH?=
 =?utf-8?B?VmdPRmhPdmVPU2E3SFlTcUxBcUJzQXJVQStKR2o4cUJ3Qkh0VEFmbElZV3lq?=
 =?utf-8?B?bHFyUVNHU2hKeGFkeFd6YXJuWmthUzgyeVhvOXNXNVltMGlZaWdxblArNWRU?=
 =?utf-8?B?UDhPT0ZXd25ZbDF1L0xQTFh5TFFGdm5xSGhocjdaRHEzNWpmR09maGttd1lH?=
 =?utf-8?B?VHc1NkJ1c2dpSTdMS2tubUhHWm02QWxHQnJka3pIYWZTVG5iKzEvenNxbXhy?=
 =?utf-8?B?aVRIVktmcWI1dFBJOU5wRVU5b2E5UUZwbDR6WXBpNHdaWnYvUEpTaTB2TFRO?=
 =?utf-8?B?TlhoZGJ0aWZDbVZaUUxVeWFYdUJvK0JwTG1QVEhFcU1hckFXQi95bXM3cmNT?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1748FE4BA78C954A925E62B484D06D51@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ni4QvIlBwgR5IVqEAWIXmqoI3UpyY85rvCsA53039/hiooK0vQVrorEgiF2eNRQjYUCoXzt9TAQ2MJ6zmjZK5M3wAOqfNlqRbQ7oCxAsEcKHRyYrmlgfBJ1LmdhprqfQ0ldNQu80hV7h1+bEwea+YoDmILQ/opunogj06xKyZvghWJr1luqKVqF880xcreGWdMXa7XlFFTWxPiHZRYob73NLjRWiqUODIGi5OfIXMooqUd5Ut1lNXSq9NoOK6o0WKVCwMPn+VyQlYBXZS8lBbEbdFWkHjgDK+68JIykJ/K1qNh19mJWWycJtISGWHbBpzQx13xuHWj1OMvRPm5yalGpF9IqgjiHM55wQjB8oUhYjrXjmujDgWhLtwkin2cycWttllQxkhe2GxNxwcGmtVgp8HOXNGCOR3NwSMapOUAqNqyKqaaAacxrS2qQJmBT7eBMblF7wbncRsBWRkE/uB29ds1cWQhfZ+iYOm9dvkJRPu96X17uPXbRfbenV3ruKNnzrEBONWG3JQd9JeuvSSKqSt1IEBsGdkj6ebnffGFCk/wJj3uiLiN84sM2dr4swKAJ58Xzyc3QtBnVNqfbkjmDJjzKrBH4Ugu6WVeeRSG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64dd5bc-787f-4613-2493-08dc5b0948fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 15:57:41.6719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8irjk0VVfLoKIZhXcbE/TGNg9Srga4UUcGx3YGp2Oud9N1QqArfeRLgwhpLT2spe1f46syJp5Kg9h4zZy5+jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120116
X-Proofpoint-GUID: 9oauUWDxR6DhJHRPbzRwulVStzoVxAGB
X-Proofpoint-ORIG-GUID: 9oauUWDxR6DhJHRPbzRwulVStzoVxAGB

DQoNCj4gT24gQXByIDEyLCAyMDI0LCBhdCA2OjI14oCvQU0sIEhhcnNoaXQgTW9nYWxhcGFsbGkg
PGhhcnNoaXQubS5tb2dhbGFwYWxsaUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IEhpIEdyZWcs
DQo+IA0KPiANCj4gT24gMTEvMDQvMjQgMTU6MjcsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToN
Cj4+IFRoaXMgaXMgdGhlIHN0YXJ0IG9mIHRoZSBzdGFibGUgcmV2aWV3IGN5Y2xlIGZvciB0aGUg
NS4xNS4xNTUgcmVsZWFzZS4NCj4+IFRoZXJlIGFyZSA1NyBwYXRjaGVzIGluIHRoaXMgc2VyaWVz
LCBhbGwgd2lsbCBiZSBwb3N0ZWQgYXMgYSByZXNwb25zZQ0KPj4gdG8gdGhpcyBvbmUuICBJZiBh
bnlvbmUgaGFzIGFueSBpc3N1ZXMgd2l0aCB0aGVzZSBiZWluZyBhcHBsaWVkLCBwbGVhc2UNCj4+
IGxldCBtZSBrbm93Lg0KPj4gUmVzcG9uc2VzIHNob3VsZCBiZSBtYWRlIGJ5IFNhdCwgMTMgQXBy
IDIwMjQgMDk6NTM6NTUgKzAwMDAuDQo+PiBBbnl0aGluZyByZWNlaXZlZCBhZnRlciB0aGF0IHRp
bWUgbWlnaHQgYmUgdG9vIGxhdGUuDQo+IA0KPiBJIGhhdmUgbm90aWNlZCBhIHJlZ3Jlc3Npb24g
aW4gbHRzIHRlc3QgY2FzZSB3aXRoIG5mc3Y0IGFuZCB0aGlzIHdhcyBvdmVybG9va2VkIGluIHRo
ZSBwcmV2aW91cyBjeWNsZSg1LjE1LjE1NCkuIFNvIHRoZSByZWdyZXNzaW9uIGlzIGZyb20gMTUz
LS0+MTU0IHVwZGF0ZS4gQW5kIEkgdGhpbmsgdGhhdCBpcyBkdWUgdG8gbmZzIGJhY2twb3J0cyB3
ZSBoYWQgaW4gNS4xNS4xNTQuDQo+IA0KPiAjIC4vcnVubHRwIC1kIC90bXBkaXIgLXMgZmNudGwx
Nw0KPiANCj4gPDw8dGVzdF9zdGFydD4+Pg0KPiB0YWc9ZmNudGwxNyBzdGltZT0xNzEyOTE1MDY1
DQo+IGNtZGxpbmU9ImZjbnRsMTciDQo+IGNvbnRhY3RzPSIiDQo+IGFuYWx5c2lzPWV4aXQNCj4g
PDw8dGVzdF9vdXRwdXQ+Pj4NCj4gZmNudGwxNyAgICAgMCAgVElORk8gIDogIEVudGVyIHByZXBh
cmF0aW9uIHBoYXNlDQo+IGZjbnRsMTcgICAgIDAgIFRJTkZPICA6ICBFeGl0IHByZXBhcmF0aW9u
IHBoYXNlDQo+IGZjbnRsMTcgICAgIDAgIFRJTkZPICA6ICBFbnRlciBibG9jayAxDQo+IGZjbnRs
MTcgICAgIDAgIFRJTkZPICA6ICBjaGlsZCAxIHN0YXJ0aW5nDQo+IGZjbnRsMTcgICAgIDAgIFRJ
TkZPICA6ICBjaGlsZCAxIHBpZCAyMjkwNCBsb2NrZWQNCj4gZmNudGwxNyAgICAgMCAgVElORk8g
IDogIGNoaWxkIDIgc3RhcnRpbmcNCj4gZmNudGwxNyAgICAgMCAgVElORk8gIDogIGNoaWxkIDIg
cGlkIDIyOTA1IGxvY2tlZA0KPiBmY250bDE3ICAgICAwICBUSU5GTyAgOiAgY2hpbGQgMyBzdGFy
dGluZw0KPiBmY250bDE3ICAgICAwICBUSU5GTyAgOiAgY2hpbGQgMyBwaWQgMjI5MDYgbG9ja2Vk
DQo+IGZjbnRsMTcgICAgIDAgIFRJTkZPICA6ICBjaGlsZCAyIHJlc3VtaW5nDQo+IGZjbnRsMTcg
ICAgIDAgIFRJTkZPICA6ICBjaGlsZCAzIHJlc3VtaW5nDQo+IGZjbnRsMTcgICAgIDAgIFRJTkZP
ICA6ICBjaGlsZCAxIHJlc3VtaW5nDQo+IGZjbnRsMTcgICAgIDAgIFRJTkZPICA6ICBjaGlsZCAz
IGxvY2t3IGVyciAzNQ0KPiBmY250bDE3ICAgICAwICBUSU5GTyAgOiAgY2hpbGQgMyBleGl0aW5n
DQo+IGZjbnRsMTcgICAgIDAgIFRJTkZPICA6ICBjaGlsZCAxIHVubG9ja2VkDQo+IGZjbnRsMTcg
ICAgIDAgIFRJTkZPICA6ICBjaGlsZCAxIGV4aXRpbmcNCj4gZmNudGwxNyAgICAgMSAgVEZBSUwg
IDogIGZjbnRsMTcuYzo0Mjk6IEFsYXJtIGV4cGlyZWQsIGRlYWRsb2NrIG5vdCBkZXRlY3RlZA0K
PiBmY250bDE3ICAgICAwICBUV0FSTiAgOiAgZmNudGwxNy5jOjQzMDogWW91IG1heSBuZWVkIHRv
IGtpbGwgY2hpbGQgcHJvY2Vzc2VzIGJ5IGhhbmQNCj4gZmNudGwxNyAgICAgMiAgVFBBU1MgIDog
IEJsb2NrIDEgUEFTU0VEDQo+IGZjbnRsMTcgICAgIDAgIFRJTkZPICA6ICBFeGl0IGJsb2NrIDEN
Cj4gZmNudGwxNyAgICAgMCAgVFdBUk4gIDogIHRzdF90bXBkaXIuYzozNDI6IHRzdF9ybWRpcjog
cm1vYmooL3RtcGRpci9sdHAtalJGQnRCUWhoeC9MVFBfZmNucDdscVBuKSBmYWlsZWQ6IHVubGlu
aygvdG1wZGlyL2x0cC1qUkZCdEJRaGh4L0xUUF9mY25wN2xxUG4pIGZhaWxlZDsgZXJybm89Mjog
RU5PRU5UDQo+IDw8PGV4ZWN1dGlvbl9zdGF0dXM+Pj4NCj4gaW5pdGlhdGlvbl9zdGF0dXM9Im9r
Ig0KPiBkdXJhdGlvbj0xMCB0ZXJtaW5hdGlvbl90eXBlPWV4aXRlZCB0ZXJtaW5hdGlvbl9pZD01
IGNvcmVmaWxlPW5vDQo+IGN1dGltZT0wIGNzdGltZT0wDQo+IDw8PHRlc3RfZW5kPj4+DQo+IDw8
PHRlc3Rfc3RhcnQ+Pj4NCj4gdGFnPWZjbnRsMTdfNjQgc3RpbWU9MTcxMjkxNTA3NQ0KPiBjbWRs
aW5lPSJmY250bDE3XzY0Ig0KPiBjb250YWN0cz0iIg0KPiBhbmFseXNpcz1leGl0DQo+IDw8PHRl
c3Rfb3V0cHV0Pj4+DQo+IGluY3JlbWVudGluZyBzdG9wDQo+IGZjbnRsMTcgICAgIDAgIFRJTkZP
ICA6ICBFbnRlciBwcmVwYXJhdGlvbiBwaGFzZQ0KPiBmY250bDE3ICAgICAwICBUSU5GTyAgOiAg
RXhpdCBwcmVwYXJhdGlvbiBwaGFzZQ0KPiBmY250bDE3ICAgICAwICBUSU5GTyAgOiAgRW50ZXIg
YmxvY2sgMQ0KPiBmY250bDE3ICAgICAwICBUSU5GTyAgOiAgY2hpbGQgMSBzdGFydGluZw0KPiBm
Y250bDE3ICAgICAwICBUSU5GTyAgOiAgY2hpbGQgMSBwaWQgMjI5MDkgbG9ja2VkDQo+IGZjbnRs
MTcgICAgIDAgIFRJTkZPICA6ICBjaGlsZCAyIHN0YXJ0aW5nDQo+IGZjbnRsMTcgICAgIDAgIFRJ
TkZPICA6ICBjaGlsZCAyIHBpZCAyMjkxMCBsb2NrZWQNCj4gZmNudGwxNyAgICAgMCAgVElORk8g
IDogIGNoaWxkIDMgc3RhcnRpbmcNCj4gZmNudGwxNyAgICAgMCAgVElORk8gIDogIGNoaWxkIDMg
cGlkIDIyOTExIGxvY2tlZA0KPiBmY250bDE3ICAgICAwICBUSU5GTyAgOiAgY2hpbGQgMiByZXN1
bWluZw0KPiBmY250bDE3ICAgICAwICBUSU5GTyAgOiAgY2hpbGQgMyByZXN1bWluZw0KPiBmY250
bDE3ICAgICAwICBUSU5GTyAgOiAgY2hpbGQgMSByZXN1bWluZw0KPiBmY250bDE3ICAgICAwICBU
SU5GTyAgOiAgY2hpbGQgMyBsb2NrdyBlcnIgMzUNCj4gZmNudGwxNyAgICAgMCAgVElORk8gIDog
IGNoaWxkIDMgZXhpdGluZw0KPiBmY250bDE3ICAgICAwICBUSU5GTyAgOiAgY2hpbGQgMSB1bmxv
Y2tlZA0KPiBmY250bDE3ICAgICAwICBUSU5GTyAgOiAgY2hpbGQgMSBleGl0aW5nDQo+IGZjbnRs
MTcgICAgIDEgIFRGQUlMICA6ICBmY250bDE3LmM6NDI5OiBBbGFybSBleHBpcmVkLCBkZWFkbG9j
ayBub3QgZGV0ZWN0ZWQNCj4gZmNudGwxNyAgICAgMCAgVFdBUk4gIDogIGZjbnRsMTcuYzo0MzA6
IFlvdSBtYXkgbmVlZCB0byBraWxsIGNoaWxkIHByb2Nlc3NlcyBieSBoYW5kDQo+IGZjbnRsMTcg
ICAgIDIgIFRQQVNTICA6ICBCbG9jayAxIFBBU1NFRA0KPiBmY250bDE3ICAgICAwICBUSU5GTyAg
OiAgRXhpdCBibG9jayAxDQo+IGZjbnRsMTcgICAgIDAgIFRXQVJOICA6ICB0c3RfdG1wZGlyLmM6
MzQyOiB0c3Rfcm1kaXI6IHJtb2JqKC90bXBkaXIvbHRwLWpSRkJ0QlFoaHgvTFRQX2ZjbjlYeTRo
TSkgZmFpbGVkOiB1bmxpbmsoL3RtcGRpci9sdHAtalJGQnRCUWhoeC9MVFBfZmNuOVh5NGhNKSBm
YWlsZWQ7IGVycm5vPTI6IEVOT0VOVA0KPiA8PDxleGVjdXRpb25fc3RhdHVzPj4+DQo+IGluaXRp
YXRpb25fc3RhdHVzPSJvayINCj4gZHVyYXRpb249MTAgdGVybWluYXRpb25fdHlwZT1leGl0ZWQg
dGVybWluYXRpb25faWQ9NSBjb3JlZmlsZT1ubw0KPiBjdXRpbWU9MCBjc3RpbWU9MA0KPiA8PDx0
ZXN0X2VuZD4+Pg0KPiBJTkZPOiBsdHAtcGFuIHJlcG9ydGVkIHNvbWUgdGVzdHMgRkFJTA0KPiBM
VFAgVmVyc2lvbjogMjAyNDAxMjktMTY3LWdiNTkyY2RkMGQNCj4gDQo+IA0KPiBTdGVwcyB1c2Vk
IGFmdGVyIGluc3RhbGxpbmcgbGF0ZXN0IGx0cDoNCj4gDQo+ICQgbWtkaXIgL3RtcGRpcg0KPiAk
IHl1bSBpbnN0YWxsIG5mcy11dGlscyAgLXkNCj4gJCBlY2hvICIvbWVkaWEgKihydyxub19yb290
X3NxdWFzaCxzeW5jKSIgPi9ldGMvZXhwb3J0cw0KPiAkIHN5c3RlbWN0bCBzdGFydCBuZnMtc2Vy
dmVyLnNlcnZpY2UNCj4gJCBtb3VudCAtbyBydyxuZnN2ZXJzPTMgMTI3LjAuMC4xOi9tZWRpYSAv
dG1wZGlyDQo+ICQgY2QgL29wdC9sdHANCj4gJCAuL3J1bmx0cCAtZCAvdG1wZGlyIC1zIGZjbnRs
MTcNCj4gDQo+IA0KPiANCj4gVGhpcyBkb2VzIG5vdCBoYXBwZW4gaW4gNS4xNS4xNTMgdGFnLg0K
PiANCj4gQWRkaW5nIG5mcyBwZW9wbGUgdG8gdGhlIENDIGxpc3QNCg0KVGhlIHJlcHJvZHVjZXIg
dXNlcyBORlN2MywgYnV0IHRoZSBidWcgcmVwb3J0IHNheXMgTkZTdjQNCmF0IHRoZSB0b3AuDQoN
Ckkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIHRoaXMgb24gbXkgbmZzZC01LjE1LnkgYnJhbmNoDQp3
aXRoIE5GU3YzLg0KDQpBIGJpc2VjdCB3b3VsZCBiZSBtb3N0IGhlbHBmdWwuDQoNCg0KPiBUaGFu
a3MsDQo+IEhhcnNoaXQNCj4gDQo+IA0KPiANCj4gDQo+IA0KPj4gVGhlIHdob2xlIHBhdGNoIHNl
cmllcyBjYW4gYmUgZm91bmQgaW4gb25lIHBhdGNoIGF0Og0KPj4gaHR0cHM6Ly93d3cua2VybmVs
Lm9yZy9wdWIvbGludXgva2VybmVsL3Y1Lngvc3RhYmxlLXJldmlldy9wYXRjaC01LjE1LjE1NS1y
YzEuZ3oNCj4+IG9yIGluIHRoZSBnaXQgdHJlZSBhbmQgYnJhbmNoIGF0Og0KPj4gZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC1zdGFibGUt
cmMuZ2l0IGxpbnV4LTUuMTUueQ0KPj4gYW5kIHRoZSBkaWZmc3RhdCBjYW4gYmUgZm91bmQgYmVs
b3cuDQo+PiB0aGFua3MsDQo+PiBncmVnIGstaA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

