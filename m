Return-Path: <linux-nfs+bounces-20854-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMDgGqKN4GnNjgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20854-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 09:20:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F155740AF4E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 245A13015E2F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 07:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8E3890FD;
	Thu, 16 Apr 2026 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="qIXYakoU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9637C91F;
	Thu, 16 Apr 2026 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776323913; cv=fail; b=YmJdDRtGZG6Npk/znCjX15+MPv7vbqJTBncsmIYT4PXNWEmBKTC5HV8Rm3y6RCMfAbYYxwTbLywVADWsGVeCi2pmWL1Gn0Pcg8fJUJHONSwcpnOWqc6vvlPWDUeJgKrUBbuBlCM+GoqJcRqYyrs3yUO3f+izX9MJymAg3MICFvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776323913; c=relaxed/simple;
	bh=uKsuJc/KyOoqoWGIBR78amvcVhm4THSj2betve0njCA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PXQNAsn4niJezDheDLL7+rmJWb91ucctMFK5hT3Cg9gJxsyB9IUIhgg16Qy+8GdIEVziOiwXmzuH24KQdGoKxE1ZQR2LENXdGuT6sLCGxqAKT0vhTcFkYFt4xjT8RRWdqF3zX6ekQB5NRBIteaTrPaBXGz7Wo6cWI/ARIuoVbpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=qIXYakoU; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Received: from pps.filterd (m0464638.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G5SPKp2188595;
	Thu, 16 Apr 2026 07:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM202306; bh=02Yppb1ixlkjFhoWrZk1O
	XTxKMu1HOVAlid0XC+4CW8=; b=qIXYakoUqHLZ8IuoQurWAZb2X5KqzxK7JfW3o
	1SKn8bs15OeMJrYdJY+JCrU07i7e5+dSQUUgV1nfNHpmNdZPQ47v4lDzGYuN2kXe
	e6glTg3qru73pbjXQkStnJikWNtW7+F4cyo78jLv92UzVsj7Dm/b1CVT83bpGREi
	DFjeyB3Sxxy8AO+44l074Bw01vyQz3Cc98gbNKGYIaN+FJEaKrkYozLyB+6ATZ0W
	aa2mjDMULW32qmaGlFlBzmKRzV4DPl9DQ3QXuQZSKycyetb4lSmt42fOR7mAihCE
	wB0lv1yB1aNETRM96au8RvmFrjEjzWSU/WcX0r46AzDx3c8YQ==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013005.outbound.protection.outlook.com [40.107.44.5])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 4dh85uq7k4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 07:18:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/22G5iNwisU1rbMu7dcLjJUYwGf9kVTPRJFHwyjDSYQGRi2Qs7neh0fnt0Pr7hHW7KO2I2GT58aIDWA83S7pt2bZXa+n5uZ/2wDAP+OWGocPQ5eyCU8/eCg05Uk6uj0BGdd/qznrg2TMzeUAuapdr4XhicK5yQtJEjorPsyX10lpayyKX9z2AQptmpKY/wwhe05r1Y2+OjBb5ytVn0RAAPB2k3K8jP6QGN6MkKqFmnzK1QbdRKJdvbwbk+bBVk0rHptLA4iwsXacX+HUza0csr95HIRZ0idTBTx1idOQekfqrJDgWge9zVXfp9g4dC82KfYarLx6X8hNPfxp+hWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02Yppb1ixlkjFhoWrZk1OXTxKMu1HOVAlid0XC+4CW8=;
 b=gSJpW6phZq3lHZ5rXog0yM25nYGn8+eUTa9F6+wLzfMD8tUDuIL++aGmogCwG06fB0owrD6DjuQnkqN3kSH/St1BPQRLP21Tq8WJri0d4PzEs2p2RW5xIES3IkYVxYjoO36A9/0OqIxGn0Qhxd5IORk/LGhp604+qXZz61PjLWwNyObzHjKwntl71Jd7UL8bYXkqJXbdvYX1NjzlNzg8Crs+X+T1LlE9mM9aS0IL+QWfneafl1ebMErTHhQD7Ub3dOyyVbmnnmhOShPn4AEaVbMZSp6XdApXxzN5cg7JbK3mXR0mEZRY0+5TdARybET3eBpYQ0dcSuhykbbe+xwAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from PUZPR03MB5990.apcprd03.prod.outlook.com (2603:1096:301:b5::10)
 by KUZPR03MB9759.apcprd03.prod.outlook.com (2603:1096:d10:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 07:18:16 +0000
Received: from PUZPR03MB5990.apcprd03.prod.outlook.com
 ([fe80::15b1:fccd:e3ae:f89f]) by PUZPR03MB5990.apcprd03.prod.outlook.com
 ([fe80::15b1:fccd:e3ae:f89f%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 07:18:16 +0000
From: Lei Lei2 Yin <yinlei2@lenovo.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] NFS: pnfs: cache data server entries for a short grace
 period
Thread-Topic: [PATCH 0/1] NFS: pnfs: cache data server entries for a short
 grace period
Thread-Index: AdzNcL++Bl5Ar7R/QFWuhB0YzEgSmw==
Date: Thu, 16 Apr 2026 07:18:16 +0000
Message-ID:
 <PUZPR03MB5990BECB40673CC6A22C021388232@PUZPR03MB5990.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5990:EE_|KUZPR03MB9759:EE_
x-ms-office365-filtering-correlation-id: 968012c5-9f78-4128-b0ab-08de9b88540c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 nIcMcTpm6s9lFpDdimES0wU7dKFGNwG6yAv0yoS4FOrs4ng+m3a1HiS56wlBXy7rd/ROD6cxy5aDb3cFMMkTjUXzk6fNPUx0EhtY0IF3wTXn47AR89RGJH4xmJ8qgsEsWk419zRtvcV2YNXddVbTlLlwuxbBr9gI0HdOuWWYvQ2IYHkC2tyJpmhtaL46jSz+yHUwHajsH9s3XLalzvDJuLVN9tcZbTn6ebdF4xM8Zc7R66Li0iI6Glz2cNteLxS0lRj4EhyiZR52mkB95DKM1Wn+IgO20bTpkXw/gCiTuLVa402zGD7vvCU1536eM+RZkmjFNicBDLqihLpzx0xqErQMJIFtlTqut4ylFoBHH3dqz1LXDle6p6WOdDSwKGQKSNou1hCpCo/D1useeHRADApNy21dNa1PX6NqoAcvEQbrmz6BA112TY6yR/n8+1ilLn2NJZ4xh41Auw2eeD2bUjCC65TC4kyynC/5G9uALBeBp3Fjl4su1GC3ZNAaMPMeHZdb/I5UD0/3jwTme5JHVJqDKOkDnEHM9Xw0ED/GRiugmDUjVY0VTIQuNGLNtFIJqw61Vfp1S5Ao4wCIgnKuT+DjefClj+XqFZwLbHRVy1F/Hof1gf9AhMlFb7WCkDGLrMy9vmOPDOqoJZfFNh5Du3kMoZxmLWPRLI39VRuoVQ0beZPufS67i9muxa4xhRIq25HuKaDK4U8NmKiwRjdX+EPRqZC05YkiGJwoGA0L3rDXGRA5VDX7EoDVL2dHtHhBsJ4sp4HrzmO6G5wCzjYOL9RcqvLxPqgXCaL9gwXgqRs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5990.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rL/WYKo6Kra72epCd7Fomz0cNu8CubRbzNr4kPnrSAO/StkqZYS4yHuToJSC?=
 =?us-ascii?Q?E2P+1KsfDy9AWFJFjP3q93ciuDnuagxW6iW1lf+15dd6jeOkBwXCm/AVQsWF?=
 =?us-ascii?Q?AjS+Ng3eybJuCTm4ibm9gi2wp2A4HCA5YVGQXqFnoyAYzfWDbrwdQBB/sEN3?=
 =?us-ascii?Q?cHqJh24+A+uUREd06ABFSKwZfEDMsnNhiyZjLdW2C3GR/zCYpfKOhUYQ22cT?=
 =?us-ascii?Q?dKPfcTVCvdWxRbaK0PqXrrn1f3CM1Gr1KyaruK4iAl9AWctOsLmTkG01s6S2?=
 =?us-ascii?Q?IaRPGbNLw4gSg9gUNb32s6oi/vVe5y2sgQV0I/Qhe/1lNZWlbFizj1ID08eZ?=
 =?us-ascii?Q?az1m4dR2U7OU+8BqXXpzlzfUyBwTtKgIvfLo7uTaY71oBNZfxupR+MVH2si8?=
 =?us-ascii?Q?lymWv7w/uvB/B7G6H2fl+TTG7xdGpmdMmOVWKttWpxE9h8kkIcl9JERToeuO?=
 =?us-ascii?Q?MRZDZIA3wsnpR/UHnWfErtplFYw+XfvjgAL9jBgjxoK5Nl57uNZiZGlpf9/d?=
 =?us-ascii?Q?tRGiYwk94hCDtsvsq+lSjLHHcGHyNgQqPWv3XetXXqwR7fFbrIMRoFzsjkIH?=
 =?us-ascii?Q?Cf/rnQokyM8bL4SrU1sLUn6Mcnhq77Nj3/DJNiWxHNeeMp5oDi3UJ1bbL4+u?=
 =?us-ascii?Q?Q9l8/cs4Ou/BJPpoKHw8FD6HqZT1wVbwQ/KyDcb5dwDocDuMx0BKiVMJeM8+?=
 =?us-ascii?Q?jgsnbpy71yQ1TDoOgHdIOPO6KDa9MXLorxwjdzg/XHLw6dMwW5Ie7f5+pePz?=
 =?us-ascii?Q?mtSSmTYgkV+agxMfwsW3c1jDjeB5VtkE+HgTXSQU794S/MtTN+80ACOfY6Xk?=
 =?us-ascii?Q?Xres4CN1AWpxKIu4Wzf+DsqM7EOb95tC9i32IFRzMlVyK6UIGR7FhSP8W6si?=
 =?us-ascii?Q?E5nBOMkZHSyA3P9hpsOD7OBD85eZwn3xGOhZ3zNHLXe5rFS/x0EI0ot1krcJ?=
 =?us-ascii?Q?K83prIcKSc227lJ236hO0t58H0/ggonz3H0rS8PEYJx+C/PvZ3xuw8HzP7xr?=
 =?us-ascii?Q?D2zcEMHPaUxLG1e1tzGPrxERhztQgbLBoDzY3qej16mtoy2ytlsk+ztBzHT3?=
 =?us-ascii?Q?chm80dlbwk1NqfeTm70ldmK+rWWlm7UBXL4KsmRAlSy7L2wxVV3xgqoTlrLe?=
 =?us-ascii?Q?tlpSPrm7m1DE/Yo1vN9OLU9iiStWgKm2PdoZ0a07K6cUXyUIlpZ7AOqtFS2O?=
 =?us-ascii?Q?dGtH1C0cmrUCD3larScmE7a8jGopuwE1NcX+7k7KDD/H9kYpngU8a0dyb49l?=
 =?us-ascii?Q?SpVYiT5P2bqT0je2yF/SaTZqsCRl8n3sJpN4qNzhYlPG4MJAnUQT9+3dFCY0?=
 =?us-ascii?Q?K0S0ZsQJwqq9qUGMs2dOVjGVmVShlFEP2yX2oAQH0F11o/JoaSGk/Obzg//V?=
 =?us-ascii?Q?fhMrMZsAxJQoKEjJSwrMrFzeaeHVQLFgnfOWM+GOqJjPEANFABTwvBKtuzpO?=
 =?us-ascii?Q?voSUfsYygWDK5KwXY801amtqiE0y093nuCRusoKoYjyVytLoRrMEBzlejy2C?=
 =?us-ascii?Q?HFFzO3nk+z5HiqZ4XlbavS5fuoyyVqu5/+XRYKazzonTdA+02Q0iY2msN9qM?=
 =?us-ascii?Q?NhZOXHfW40yUWHo9G8KpieepAypdKyfssuUsQzj2F0ZFoOVn8hdAl+qM9xim?=
 =?us-ascii?Q?78/CLi5r2kasA9E9G9xztJNCE4vgURDkT/v2B5KuIqKm/P98ywSAWkz4YVPo?=
 =?us-ascii?Q?gIgF4YMkVxvGb8wy1PBUAMn9p54xFuy3lYPNv3EvO8q4tAHq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lS/f958zm8HxupjjSeEaeeRDxXFzi2EPJt2yg+F7sNrJF9VNj04KBGCSu8sGp+LO8BCdCWNnnmcER9hKHWRNWA8++kBfl8qDxcshHTCZ5IZ3XSKCvAzJmhggU5MtLJspJb65w7B5JC4w+oTKyhkieVq6Xpxxq0fhNWuQ6fpt3NAx1nP7fBsFP2LxB4AMrEK7CeppXazSbX1FjLR0wZGtA3xfKvNRqvoaxnwfcxIxXZxsrOQCM0W/Hn8IiV0WnqOp/h1TkLRVnhGPSK4U+8P3RcdD+5/2WBztq3SNW6b+Q/PjjKCjkz5G3IycQt4FWH8bTVYX7zSyQydUtpL+2qUTBg==
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5990.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968012c5-9f78-4128-b0ab-08de9b88540c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 07:18:16.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C82g5kernmSoPvYkLn0aD2OjpB1VrM9ZlBMXxOPvfL51ZTDuO5BDainIB+TrY2tTRx7rgQpsfNnaStTXP0UmEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9759
X-Proofpoint-ORIG-GUID: mRVxcNzKQwJU5QZACrMa8pZIE90ouG1T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA2NyBTYWx0ZWRfXzFqVq5iXwnnA
 5HDTLHn+XuMk1i6RJYrUqFgaVMNhb+XctzVtNzhPZXoYh/O0b00GKTiPDlSIEfLSw+4ASP/0OcG
 uqFsPShZJrITSCPlUzF9oXX4NnoC1uuaTxoapAhxDZ24M7bKGmr19v9dt39sas24XzV+V4QYd6R
 OmHK5YMNhu6AOpQmtIzQRmUrwT/JXk+X4B2hlBh9FoKhvaTQ3juFHp5GvGgB4TOH56dZ/5jIcX4
 APccyWRUrWkkK0Pt/k40/jhvWjgrPUB6Ze/4XfMGU9muTMGrF1vtdNtSexpU8gV8OXqIiVyFdsj
 jPbnutykJrVpbcpzHWP56h8VkjLCIGXAiibuzdUQ9pbt39SQM440SVD+eP0maC7MgNPAimISgWH
 DBCSFRLeLj3EsPSC6iYFLBCFNIQ6zAaAD7pRLMdBZvnlhaA4uhO7kYuQnY1u2+ccS+0GPxH12Cm
 hU5VevXw1d96Tk/Zdng==
X-Authority-Analysis: v=2.4 cv=VNXtWdPX c=1 sm=1 tr=0 ts=69e08d3b cx=c_pps
 a=cs3pSOWwGIniS7uFNYxq3Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=2RTuljz969oO5usasWGy:22
 a=QJilI6ASod0cdCKXAsqI:22 a=HMC-qbmgOC4xS-NmnbUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: mRVxcNzKQwJU5QZACrMa8pZIE90ouG1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=-20
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160067
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[lenovo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lenovo.com:s=DKIM202306];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	DKIM_TRACE(0.00)[lenovo.com:+];
	TAGGED_FROM(0.00)[bounces-20854-lists,linux-nfs=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yinlei2@lenovo.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lenovo.com:dkim,PUZPR03MB5990.apcprd03.prod.outlook.com:mid]
X-Rspamd-Queue-Id: F155740AF4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patch keeps pNFS data server cache entries alive for a short grace
period after the last reference is dropped.

Today, a data server cache entry is destroyed immediately when the last
reference goes away. In open/close-heavy workloads, that can lead to
repeated teardown and re-creation of the same data server cache entry
when the same data server is reused again shortly afterwards.

This patch defers destruction for a short time and reuses the existing
entry if the same data server is looked up again before the timeout
expires. Since destruction is deferred, it also reaps scheduled destroy
work during netns teardown.

In testing with workloads that repeatedly open and close files, the
additional read/write latency associated with repeated data server cache
churn dropped from a few milliseconds, and in some runs tens of
milliseconds, to under 100 microseconds.

Thanks,
Lei Yin

Lei Yin (1):
  NFS: pnfs: cache data server entries for a short grace period

