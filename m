Return-Path: <linux-nfs+bounces-4108-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2690F7B9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10871C22A16
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAB15A846;
	Wed, 19 Jun 2024 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="faE4+BJJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="utt9CQTh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1E15ADB0
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829948; cv=fail; b=WvOq5H7ViALPhItQuk3Yr4jRsSxeTAm3ZEytAFDMIfnAodYWXkwuw0rlYrt4wlx4t2YLV6If9ktd4jFHCzBTDvwuuz2S1rp2b2YlczbYARdFM4+Qdc8co+V8FnQqiJI8W8i7RMzaUI2tJz5PdaguOdfW6XOHIRy53b85McagtXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829948; c=relaxed/simple;
	bh=nL7aA+OIn5rwyl2qWIMIrH3MVExQa1vv2tXpBcNZOGQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=luOPgoTtC+3hkS6oyJH0WzLjTfXVBAZ6W/Ncb5skOYJxDfQPU8gTTgCxpLbgfgHUQFGA2EaIK+LB/O/hiB94aHehetc0zDeKvgrIF9ihfKFuJAs1dXMAW/iUYC/NCc5lIBU/UnjlhmOhHkwjsZyvMAMLBFogmnWStRxjRfx0Jow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=faE4+BJJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=utt9CQTh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JFBUDi014174;
	Wed, 19 Jun 2024 20:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-type:content-id
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=+
	sBxn8ynJ7dlRcwFW8Xyaj4/6wbDq9mO8LEOKbTZa/s=; b=faE4+BJJgHR4jSvjv
	msQngMrA2VsSpdiZ9QfsfFItbMnO1FCS9ELRRdhEdECXwI2zwQAxeKYLbsIG6iNz
	kG7r2vhhP+JcO+iZmPHclhX3MB3Eu1grJ/fLwZ6h9bxQgnkvkir60xcXExcDAcAR
	wVPEywVnfw7XSi6a5FhG75Bu8pbqp0o0XrJJtjPpZ3u5n5i9be32Za/iBwl3N9T/
	7CdS2xS8Xln/LmrAWKZ3ZwxI49ZKHoHUMDPvuKJiQ7FweSB6xyhHVxwe+eeHlv2X
	oTXUpwU1+kFLIhPKpbM3khNDMAP9OBGNr2Rf4gPj+XIGtGUZ0UtqWiMDPW/PRUU/
	Gfakg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yujc09xyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 20:45:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45JK8eeT030610;
	Wed, 19 Jun 2024 20:45:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d9pghu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 20:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpNRmF8e7CGdeWlLjXtHqca1jpNt/6V1wcVGIfB6s+fNBCs+lwEwHL1HUo5z0uVZuYsd+mX3li5wtUsTiDTwUZZs9rctMluGJaBWKSceBM2YnsTAizvKoZcz+40PSTbeQTWxm0d2rg8B/6lgxFuy2ZAhQjdf7UwPgNMJofRhmHndxh3b2B4T63n34SxCDAVCJYYKE4/WNHGIf8YQZRPDJUEIkb06ApnXhI4TbkJeKyrvm+IDr+iBcMeK0Vs3GS6fjKO+scvQFbSjiW66EW7mxNtd2+CLzRAzeoMOkwgNiV2hVaMsQG6LEgd6vNgnn3awFpaNaenyvO2TQYHmdrJczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sBxn8ynJ7dlRcwFW8Xyaj4/6wbDq9mO8LEOKbTZa/s=;
 b=j8moXdgBQRSSZNwVJ9mG4Xf1BfMa/ZWD3ZKu4ry06X6eFI8gz2JvrzosQLckclD53C9auEpVhJiBMst3WpPhoFqhDjdOkhrs+8ZdKC4NaANt3N3xnuFUfyuKejZPs/SZHfiFo1RiUS0rV8JBFYtoSgFw9nPd3n8KQxtomroHNO+mgI6x+/ave5xcoCB6sk+BDOu0my+lgFQ/wQ89qT68PPHFlmJhRdIqEkmj4WyvWeu9+3eTg9qTufk7fVO2gVa2G5WVi3K0jPMrKvpyENL5qprsMBYT2N2ZhXH99oIYvWB4eChjbaAi4nLVNHj57ZSnM7zP8/u8hbtaiBNeUO4b/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sBxn8ynJ7dlRcwFW8Xyaj4/6wbDq9mO8LEOKbTZa/s=;
 b=utt9CQThNSiAGDia9lp+YAM9BW46edSkBLITiNg3AYoTPu9Cnn+7xGVJ9J/IryWenftP2mm8FG9CVdcu2I6D9+ZPsGFpEISElJXfbjze4i7XO05ZdA4h2F28nr7EGGxyr6TsBVXWH9idR3kJ+SKJuW9aR8zxEa7V858c7RDn2io=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32; Wed, 19 Jun
 2024 20:45:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 20:45:39 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dave Wysochanski <wysochanski@pobox.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: BUG in nfs_read_folio() when tracing is enabled
Thread-Topic: BUG in nfs_read_folio() when tracing is enabled
Thread-Index: AQHawomk+qTQ2SfYS0a3K/cZZHamhQ==
Date: Wed, 19 Jun 2024 20:45:39 +0000
Message-ID: <C225EF84-ED3A-435F-B90D-7A5EF6AC8430@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5590:EE_
x-ms-office365-filtering-correlation-id: ff807a95-1809-4a77-09f5-08dc90a0c763
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?jDbp4F+h+NG16ZooxtkNuFz8Lw2uB/DmKg3IcWC1CyfYZLkKz4uw5q+ZtAzU?=
 =?us-ascii?Q?y9uQmqSb/rrQxwnFRISIF2SWhjgD5l9OYeMM4148OqoyRBjcRUYJM2eaYY18?=
 =?us-ascii?Q?8l3iSqo2oMayOtQokzaKzoz1dw1DCjXCR2SdchidYZjzq46FVm71nSyItDD4?=
 =?us-ascii?Q?e92jz9A+wzvGgMplhnsXLVZ2X2U05klWzORqmNHnA1pfd3uUahXH9JGEjbNd?=
 =?us-ascii?Q?9rDuBCONs7B8k+iuhhcJ2JYqYCguaY2t3v/NP7NI1btK52iJcHPux3FpzApn?=
 =?us-ascii?Q?H21M5T2mKj3ul+l0nt4yCCiuNVpftzWhMdOMuarFI+xrqbRg0UMT13ucPoSx?=
 =?us-ascii?Q?vTI3S6ge8aUJKkQ7Ld7nDgX+W6ihKrctnJiGv8tpoOz44rSGS0R6S0WIb9jl?=
 =?us-ascii?Q?a6hrmq46DMaUkwRy4bnFP+iLVPTioqGDobBr1SZqJZc/iW4tiAt8Af8JXArk?=
 =?us-ascii?Q?uYxEhA+EsMYQZji/79SBzqBGe1pCUUbUAGm+vaAah/iNeO7JPfMf5RWjSwt2?=
 =?us-ascii?Q?KfLA1ejpybbqFJtp2cn8AjSeVTyt9xOpuUmGllsGNMCg6jhxOr7YdVkHe0Fu?=
 =?us-ascii?Q?bf/QZq8UmbseNrv5nCvS18aBxTlBxEhNaGcQmgWStz/3woHuQLGoeBrQfBJj?=
 =?us-ascii?Q?bsnfDbkvBLoQARPeyOQs2KujwSJkySzKwu6z7sWEYfkFarul//C58AoEV4Q/?=
 =?us-ascii?Q?BzRU+QAreMbUWwe4dw/C6PpHqCfyaEyYQtgyOm4ZOV8A0e6+CTI8HEy0XbUz?=
 =?us-ascii?Q?y07eDGAFuYCWSAVrBifrzB1fvkXPj+JhJ1OlEMmIJozYvxfGOoWJ3ZbDv/0a?=
 =?us-ascii?Q?CsfaHdLpXzxeceGCC4I/G9wOpxotmJBOFcy+7blRhYcsBMjbejOFeWiGO9Z2?=
 =?us-ascii?Q?b2vm+vY4LZkgGC/pa9+FkkwdVEb7Y5U00KRQizCOts9oUB10vyKAeOIkfTZa?=
 =?us-ascii?Q?GVHj9BzltnF0UbvYSD41VpT7bdp8B2vHlROASe/PfEHoC5Y8wWKzU95APFX7?=
 =?us-ascii?Q?dn76TjXk/LxQldF8l2fzkdm2NuqK8meatBYV5p5qVm1B/Ko2W24FwRMq1z8F?=
 =?us-ascii?Q?U0zzAHWZ+dO8jCFZS5mcgHpCY8JbR9Lcd1nDlViwrIYmbkoyjMKWWv9K4sot?=
 =?us-ascii?Q?BHpeph0QVrAtLdUCSgGNsz7WAPqjps+X8W0QwdzsyjlHmYoS8aiGCpKCUh+H?=
 =?us-ascii?Q?9YYj7FYHnIBbGKF1/a0vUPK4Ccu0FsjPw9HYD0J2njVnO9bGrPwGYrqBDBp0?=
 =?us-ascii?Q?TBNq86cCke8DbArBikoxd/3eq7dKOOizP6pfh0zcyP5+vlSrntNe0aqJ9a3x?=
 =?us-ascii?Q?Da371blkZVVqxrh7L+bvkjiLQX5fAR9MAHgHft4x9qGi+msjdxzey62nWL1P?=
 =?us-ascii?Q?SM0XVd8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?RhSWdB5oN3SE/LJXjHFRrNNg6+v5TNvMhRornxuBO/y5erdNyPM2HPtCusS1?=
 =?us-ascii?Q?MSjPvb+cY+E9wQA/4gcPWOWjvQWmd3yQPea5ZJVMVzKQqR6YkvT4Aqrc/LVa?=
 =?us-ascii?Q?ve7BISfGBej176hG+vHfq3CA1pzw0yFkkWwgnTHu4FHAnAfX28wvMRG84a83?=
 =?us-ascii?Q?x1dKKfGlBucnLjmVcdnuJeYHI1aqzKM3hFqCoT65WaqjJX+MaH21K+yO9ise?=
 =?us-ascii?Q?Pjii4GBMLXsa8akj0+vO7M1JRo2r6KRrtztrcOK60JiO+be1K8bd64GUJXPO?=
 =?us-ascii?Q?CPIljTP85tkBxWWBvo9V1uLPD65xUkwGTiyC8UI4iORBfwGK+K4MjfyO3C4O?=
 =?us-ascii?Q?SOyBvqoJ86ZOffKv6xpeJc/xjmpvFkQRDhSkhMUAlyaZL/S5Qxr3ez3WjmnP?=
 =?us-ascii?Q?4ndYgO6KXMHiarLCvNNSg3NDRyvol3ysrILxxY18Wor1sS6h+dK2FUVkkWg9?=
 =?us-ascii?Q?4PbsOVaIM/1WLe+klIIs5QpEVP5WMFg41JBKwdk/TCYbaI/WXQ9HnBp7gO1X?=
 =?us-ascii?Q?XOlwprPZV59BSmBphbxZS0h4MffhRZHnVQr/gy4spAP1kGanuDK9GXCyzpZA?=
 =?us-ascii?Q?ESleNtLKEe4UisrjGe2u/ExPRkLh5N1vxyYr81L07xSSGtt2MO6nf8KF3oB1?=
 =?us-ascii?Q?ZtE6IvaduC3i763QQi8lqR3im81SOMcV+qr66jr7WyZppQBC0BEE9T7HIxG3?=
 =?us-ascii?Q?Qgv2dy5pTtMIDpTd2R3P/+adraMyGIFs6p1monsWfzI330E5oX/+kfXhLtPC?=
 =?us-ascii?Q?/10AfNRgTTBPr8yHF7JiaWE4BPWh+5SNVf5YA7KutN/7HYkORNH47qolfQh2?=
 =?us-ascii?Q?AE/vH7RQ/EKjUCIzigvVbaq7jmhfD08tAkp6P4fsJ61Gd+P161WR5p+xIYLt?=
 =?us-ascii?Q?1btj8n4kCEKd9j4RGk48Fwk7DgXCb03S3+n7UKXZwAlN1Uhix5W3fq4SKmYQ?=
 =?us-ascii?Q?cyulaXSEWk51r00xUQqn/9VEHlE2vAS295/2LZUX4MUVnxcYWJcDcFS8qItw?=
 =?us-ascii?Q?uUxAh4wpIZSW8SK0vtBMlspjP7Z6DmumombRdPhepha+wlxCOoCtAgXdyank?=
 =?us-ascii?Q?thj0Rk25emQKOgWSDwPgDbwHIvLC6VnTUO0wPo9wpp1AaZTmlz9fZdepB1Sb?=
 =?us-ascii?Q?3qB1wxa2GwdrBJDfaZs+EK+EQhn81ZLLlhZqs87/1c1fCMq3fQKV7aj40DTi?=
 =?us-ascii?Q?8chE+GBdUUEBxZwzKJcJc92bjHs3YIXjgIRYuA8AChIvrCZOCmPOapwexSpM?=
 =?us-ascii?Q?koUFXgfowfIX5PRHg9K3iOAB6Cy0hzTUQd+fRNsks5pQMmJck4h1zE3fuaO3?=
 =?us-ascii?Q?q1tL30XiuKMT5t/bnlFhCPH2p0qHop+qQtA54mbNXnZkx+2egqqDZJOIGVo8?=
 =?us-ascii?Q?Y4houM9CR+O2Erdk/vU6qhS9zBWdnj2YFaVVxByRnV3MglSu934j1bmzLPYp?=
 =?us-ascii?Q?c3Xx8aWuE7G9Eien3wyDEbOX0QyGeT70qO93mxPOTulDgPg26ZRWOMbDiqyp?=
 =?us-ascii?Q?rF+RwHt5xp7cK26GFd5Dl5G8hLfTWwx+lp4HO972imIGeHh6Rw3XcZPzoW1D?=
 =?us-ascii?Q?DksD5Gu5qcxvahrGXG/cFNPJcBYG/0CnLW/y0cFsZP18u4Yc4w2NWJdSkIek?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5469536C23C3C144BBAFF1A39280ED54@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nbi3oBZxiX/rbeBpxdeb4+6WTgZxAf2CkBT0TDmr7369RY7quoFrCCe1VhOP7rz5gtSpUSxroNBHKp5uc5i2gG7OSyjK0jAndhrharhereRomEJy+YQFzXIYp1C4penyH/i8FS+fEGL9uNClsWrJA/4Sebuu15i9ZoeJsP85OmTRBPB/ZeTdMvw550mt/BmFe4NR7VeiGAFtxwWb448b4ugJR+26u62aQ8OICPjuxKM/Z3W3GJK3OxWeVPdM8JN9/iCazYJHY7/gkUGpSBTeFEICB7zWzyyTcGQpKJi3cTFBnzAVX1wXZDkWeuPtR26ipF65UK6CV1U2l7SLzVqWoIDb+P1LbjkY5lofx1WlzXPUWPYoNZ7+lAVr98TAWLTr7z/37U16nOxH1YmH0AYIRolQYVdqYlzMLd2uhIzFWn7Qrkwd4odGB8tFbZoIAkfkM68GGF42j4fzxGUi20bQw1SObdZNt933vA4i8dHOpy42kRFjEv5pzqoVaqfBN7E3+VNBbOuUB1BFdp1XnB3CQbg4ELZvRzkwtgu/IGt4inoY/FaNCAyxeO6Ue+iM/P06OrDdbFoKn/l6mpwKxaaq+HZKnCUAFb8zoNUSZNCl0Yc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff807a95-1809-4a77-09f5-08dc90a0c763
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 20:45:39.3670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HEsvd75CzSgP/N8yZFpgLV3m/wtws+APgE68xhzfr/1uxO2BbQPevLGLu2UinSOo73SXahAawd+u7/W5gEesqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406190158
X-Proofpoint-ORIG-GUID: AqyxCFrvYxP6xesCeH3VDT1QxUrAPvWW
X-Proofpoint-GUID: AqyxCFrvYxP6xesCeH3VDT1QxUrAPvWW

Hi Dave-

I'm testing pNFS SCSI layouts with tracing enabled on the
client, and I hit this BUG twice today:

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 52230 Comm: fio Not tainted 6.10.0-rc4-g9f1e0e495093 #5
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/0=
1/2014
RIP: 0010:nfs_folio_length+0x29/0x170 [nfs]
Code: 90 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 08 48 8b 07 a9 00 00 04 =
00 74 0c 48 8b 07 f6 c4 08 0f 85 89 00 00 00 48 8b 43 18 <48> 8b 00 48 8b 6=
8 50 48 85 ed 7e 66 48 8b 03 a8 40 74 7c 4c 8b 6b
RSP: 0018:ffffb0800c2abb28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffe5d8c44f4a00 RCX: ffffffffa8525000
RDX: 0017ffffd0000028 RSI: 000000000000004e RDI: ffffe5d8c44f4a00
RBP: ffff9871911501b8 R08: ffff987191150020 R09: 0000000000000003
R10: 0000000000000006 R11: 0000000000000000 R12: ffffe5d8c44f4a00
R13: ffffb0800c2abb60 R14: 0000000000000000 R15: ffffe5d8c44f4a00
FS:  00007f1d25d6f080(0000) GS:ffff987277c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000013cce0005 CR4: 0000000000170ef0
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x27
 ? page_fault_oops+0xca/0x2a0
 ? search_module_extables+0x19/0x60
 ? search_bpf_extables+0x5f/0x80
 ? exc_page_fault+0x7e/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? nfs_folio_length+0x29/0x170 [nfs]
 trace_event_raw_event_nfs_folio_event_done+0xdc/0x170 [nfs]
 nfs_read_folio+0x16d/0x260 [nfs]
 ? __pfx_nfs_read_folio+0x10/0x10 [nfs]
 filemap_read_folio+0x43/0xe0
 filemap_fault+0x70d/0xd00
 __do_fault+0x35/0x120
 do_fault+0xbb/0x470
 __handle_mm_fault+0x7e9/0x1060
 ? mt_find+0x21c/0x570
 handle_mm_fault+0xf0/0x300
 do_user_addr_fault+0x217/0x620
 exc_page_fault+0x7e/0x180
 asm_exc_page_fault+0x26/0x30
RIP: 0033:0x7f1d25ecedb7
Code: 7e 6f 44 16 e0 48 29 fe 48 83 e1 e0 48 01 ce 0f 1f 40 00 c5 fe 6f 4e =
60 c5 fe 6f 56 40 c5 fe 6f 5e 20 c5 fe 6f 26 48 83 c6 80 <c5> fd 7f 49 60 c=
5 fd 7f 51 40 c5 fd 7f 59 20 c5 fd 7f 21 48 83 c1
RSP: 002b:00007ffd92df7f58 EFLAGS: 00010203
RAX: 00007f1d1d0e6000 RBX: 000056211867f6c0 RCX: 00007f1d1d0e6f60
RDX: 0000000000001000 RSI: 0000562118699ee0 RDI: 00007f1d1d0e6000
RBP: 00007ffd92df7f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000562118688f30 R11: 0000000000000001 R12: 00007f1d1d16aac0
R13: 00007ffd92df8030 R14: 0000000000000001 R15: 0000000000001000
 </TASK>
Modules linked in: blocklayoutdriver rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_=
resolver nfs lockd grace iscsi_tcp libiscsi_tcp libiscsi scsi_transport_isc=
si nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject=
_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_c>
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:nfs_folio_length+0x29/0x170 [nfs]
Code: 90 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 08 48 8b 07 a9 00 00 04 =
00 74 0c 48 8b 07 f6 c4 08 0f 85 89 00 00 00 48 8b 43 18 <48> 8b 00 48 8b 6=
8 50 48 85 ed 7e 66 48 8b 03 a8 40 74 7c 4c 8b 6b
RSP: 0018:ffffb0800c2abb28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffe5d8c44f4a00 RCX: ffffffffa8525000
RDX: 0017ffffd0000028 RSI: 000000000000004e RDI: ffffe5d8c44f4a00
RBP: ffff9871911501b8 R08: ffff987191150020 R09: 0000000000000003
R10: 0000000000000006 R11: 0000000000000000 R12: ffffe5d8c44f4a00
R13: ffffb0800c2abb60 R14: 0000000000000000 R15: ffffe5d8c44f4a00
FS:  00007f1d25d6f080(0000) GS:ffff987277c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000013cce0005 CR4: 0000000000170ef0

cel@renoir:linux$ scripts/faddr2line fs/nfs/nfs.ko nfs_folio_length+0x29
nfs_folio_length+0x29/0x170:
nfs_folio_length at /home/cel/src/kdevops/cel/linux/fs/nfs/internal.h:824 (=
discriminator 1)

Which in my version of the source code is:

822 static inline size_t nfs_folio_length(struct folio *folio)
823 {
824         loff_t i_size =3D i_size_read(folio_file_mapping(folio)->host);

I'm pinging you first about this because you changed the
code around the trace_nfs_aop_read_done() call site in
commit 000dbe0bec05 ("NFS: Convert buffered read paths to
use netfs when fscache is enabled").


--
Chuck Lever



