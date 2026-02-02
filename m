Return-Path: <linux-nfs+bounces-18647-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPQDCATYgGnMBwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18647-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Feb 2026 17:59:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C44CF485
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Feb 2026 17:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F39D33006086
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Feb 2026 16:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B52798ED;
	Mon,  2 Feb 2026 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HLSNaveM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020089.outbound.protection.outlook.com [52.101.193.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4037FF45
	for <linux-nfs@vger.kernel.org>; Mon,  2 Feb 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051574; cv=fail; b=ej6DH+Uw843/w7sRPkyURP76AX8kep3jdD3QsAgwz7Wq3p3OAfKeNhKIsPYPeUoaO2NyDi3tOrmDkeHlBCRiT7o7uKBlPu9dwDehY/1iFp+uP3j3k1NiHHzaCuCSpA1RdOCTG/ChQU5nOMs0RoTERmfuvgX5bMZY7OEFYK4jqKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051574; c=relaxed/simple;
	bh=bQ1nSKrz2QGeKKfjYvERhbokRvgaST2cupmC6iMLrLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZeb+OmeP47PVkqNayz/q+polX+Vwr+het+a1Bmw1N92c6zCUqK4oNYdc0mEa7GLdqsxH1Mwi+fgIQrUR0WW0H8iczNbkMAUpGtzfLXvRthvBHXoYRnyAIPcGabwojTNsVYhlE7LcAPHXk8bv4y1oMbWTuJlP/PVvIOHil6aBuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HLSNaveM; arc=fail smtp.client-ip=52.101.193.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pf5iF6HHe67SZuQ5gy844fRPx18/N14zI2kNAnTNjVRbyHvRl1fQqe0mGg1WUI7KD5LL25CVawXtpfiqv07evEa5gao2nKHedchnJSFILUy/SIkilgUVPRb/zbLPENQS29imSpyNGCjMHIAHweAZzZ6/PCWYp6iToxrsznK8a73GHVDGD4hlMq/RHLiv+ZYQSSGazTS+dNzzCGmCN6e5x/HABHMQjWHtMeFZvOQ6iNPxmU7QzdXLDhgb4wMpyY/YAAMEmyrARrr7eK1lXDJ5bEb755ptv2CFmWir+jiKTlAArAZNkSgTCG//Swti27CLI+wNn+sJdBj3jayf5JPXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2P9Z3K0crUPtvX/UEG6DM+7Tm2Jdmh+wE5PP0WuZbmU=;
 b=o1NImtpHdNtf3BvwvYELGrqE1MXen35J7UEiZq8hZM7JUgtT7QEdOrja/9FnWsTShpVO1nMaJfr8OJ1VLuEXFvZPq4sCZ8icfNSxrQQ9BTlLU7h0avgBSiNdR2yrG7DSnPLaoCTpbWmK4IXpfqvZxTrcbBX8dR//VZH3z+BRUsBdfS+fCj0kr3wpW3LktZK/fX4Un6y6ecg18nNIeKMfyR/G2r66xKubYrDuIeFk1Pk419Q51Nml/zWAoR+tNoCHX0wFQtn9jZyF3WIRDjMAmbePAhYOmWE0I7Ue6xQRXxnXE/SnHp4YTf+x0Lm7sdfvza5NFzgZ3gNzNCtxHELTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P9Z3K0crUPtvX/UEG6DM+7Tm2Jdmh+wE5PP0WuZbmU=;
 b=HLSNaveM6RWK4C+ImBjwJq/Mothq9QS0T2BSoGLwf/vim9U6U+0kEUHStF0QW1jKrzca7rYxYMnPymKn1lOzjMACadKY7s2QbOguzLgXX5XzKEeaMdx6rwQGZgquDsTj8+1+1WzKONyDlhvU/4dhbMG6x/cg9Hs1W1EiO5ZITH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 MW5PR13MB5488.namprd13.prod.outlook.com (2603:10b6:303:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Mon, 2 Feb
 2026 16:59:29 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:59:29 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 1/2] exportfs: Add support for export option sign_fh
Date: Mon,  2 Feb 2026 11:59:21 -0500
Message-ID: <60b48050a0998ca214526bbfec406ed084305617.1770051230.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770051230.git.bcodding@hammerspace.com>
References: <cover.1770051230.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:40::34) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|MW5PR13MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ab79f5-0673-46d9-5986-08de627c6ce6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HOB5JstkpuKnHCgct+e5WCk8GSo+TXTjxCFHUGjD8Q4lBtNX124R3JAXnwqV?=
 =?us-ascii?Q?s0pc0Cu12niNRLlhF2iNx+k5AXjXD1aBnvkNLI0orVl10ZCE/GA1Q/STxAEN?=
 =?us-ascii?Q?uEJEGQWTuKukawfEmQSZg/BAfDwS9+XlmG8uVC+KW8qJRBaIH3TXHrc2w9DI?=
 =?us-ascii?Q?vp5LWkWwS1vfS8gby4bmCUZSqOCOVMdYFTJhlD32ky4I+ZUYMdzJRr5hpeEm?=
 =?us-ascii?Q?fY3gSrKP0JYc6JvB1Kp1NdqGR6twPntX/bcT8TF95/+GPYLGXMAWtyQMv6ii?=
 =?us-ascii?Q?3CwkASC2NXnnvWKI48A3igQ3e31uyTGLmiw60rKnD4Lwi1UUZO9Hl66uWfpi?=
 =?us-ascii?Q?W3yTIgAz6oWK3C40eVUJeTDy4a907ggaoP5qCFnHkzf1DbPJZ4tSenUeE3wf?=
 =?us-ascii?Q?pJgUh10Rc54Q3WmOi5JOgRex7ezM08HcHuHVzpd7moo/6FY3LkY0Iy0VlR0q?=
 =?us-ascii?Q?G5qPXSBzz7l40W+yqcT+eNqL+Kf2TjqWTwmCOwV68mCHE3kR9F+pumZVp1My?=
 =?us-ascii?Q?YvooVRh02gaVX2vKUvAySO/3bNHn37KQRmS4GU/FdbyKucer51VZaZQ4FBhX?=
 =?us-ascii?Q?Trs4vSfw/xArbbGsldjqHuLX4e9QC89X3MWxfPeJKkEmo1ycgL2KPXFTg8qL?=
 =?us-ascii?Q?MFdyHzDCVG2eHBWREKzVb7PKwDHqvHFl8OksFvQtCQyvo/ltRgIRmoznI/tW?=
 =?us-ascii?Q?AhuCP+0m2pPw9kiSFAjLMuud9X3nQgzLJ8y8T5EARHKoDxNE0zoG9rk4Lqjv?=
 =?us-ascii?Q?/jcDi0h7PcLkEiagoKl0fY/dy7RgVACrEmEHgr/u6KiuDYKHH5L1TveC7XHU?=
 =?us-ascii?Q?7hUBVgKI12hoNNtOmy86bkXhFW52WeXoPNVOZYjfne0D4TSypL2g97YwM3r3?=
 =?us-ascii?Q?1VQObJWobNVSNa9cYdeVqGqKBQ6LbLuKapCM/27gS6sYGYZGyyTCT2L3gUeh?=
 =?us-ascii?Q?FoF0/68utnIoQhK28fygtPMWGvoHOIlJK/u42ohXy66NHGW3K4SvVX0qJyH7?=
 =?us-ascii?Q?N6yRtpDyu19H4uc7PqQzhC1nlJbHT8u93eimyk55XSoAXCv27yGHyYw6vBpy?=
 =?us-ascii?Q?lDcdEvbV5Eazt5+gI31CMYr0TlMCmCeTcyRtIOl21xw7ftW/uG/Mk3sqMZax?=
 =?us-ascii?Q?c4/5RdgM66Jm5kTCLA+7ITx/XlU3IGVV/FqCh3R+JiU6scwhqtZzDxUppSvO?=
 =?us-ascii?Q?8fJ79PCewVEZKdvgVkDGYMq0bRhpS5jEmvmFJKQa9HNIOE8M/gRbF9SLaIsS?=
 =?us-ascii?Q?s4pVUqgFtPW/0h/yN+H9xB3PS0zDogg5EqKJY5+tKurKwBkwcCAH3hfzx3Dc?=
 =?us-ascii?Q?Ix5KjUG/avyZYG8dE0Z0uP8EhZ/RNeUWa52wiMU+eXiuqy49rqLH0jFXt0xi?=
 =?us-ascii?Q?ioHOW3o5BS3nzlGBMlg4GHQAZ85V7f1H06vzRcOlE4Rz9TjbLn8ltcYfl6pK?=
 =?us-ascii?Q?n+D7MthB7TL8/NNba8wrXsq/sz0KmIcS1evYnV+NjBku0sVfnGI0n4YBV9wP?=
 =?us-ascii?Q?cT+puBKQgKvDDb3Zgy5f+gH+KOKq7u2665q4OluTddPxI5IQ5/xuKKCTkra9?=
 =?us-ascii?Q?yoYMFmQfCkR7cHzO+2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YS3ZLTc0+xP7iNJfDnc7CLNRULqK14YdTZ4JcXkyd+sF28mbcl8NcEfM7wIE?=
 =?us-ascii?Q?gNzMEIn8iBXijYJrxTz5zCL6K8QbGOcXFfj/JBTMxFKBJ7IwXPoKImdQv2uv?=
 =?us-ascii?Q?uClUACLfJevwMdamJ/Hk062HRbtTUwigCCrXXFxIdKAHCS5VT2CUXktTyWwI?=
 =?us-ascii?Q?aV8mjhJwiKKtTOwSKNiyxhRk7su+rPdOTBnPF8LbAdmKy46rqREOisy4Mjxx?=
 =?us-ascii?Q?xIRyh2BNi8+DV3s5quEvCztgSAD0QqBpz3uFobJRexL0Ik00BJ291yKdWT8D?=
 =?us-ascii?Q?q7Heh3GYmGTXOmsCusFKQFcO8GADWAoZJocs865ZRkDMQCuoAp/p2i1FNkeh?=
 =?us-ascii?Q?LdN9l3fE7duBPzyYhSrng+2r6jxlgpSMJi7Yzr/P1/QkHnzCmLSKz+5Wob/K?=
 =?us-ascii?Q?wdxGXqdMSwTy0dS+uYy6dbuTCbX88yRLpNcW9HPkDVjWjqWkGvWw5PqDFKOG?=
 =?us-ascii?Q?w9b7iHLo8UFx+zhgxTTd3BGNWCzEOe5qimt52rmFcUIAMM2KhyGCDgIQVZhe?=
 =?us-ascii?Q?jySLHwBnRm7eyIF6Nr7YFjIVNZ5PVT3LAuqppIguIghMovnIdD1O1zuzwsos?=
 =?us-ascii?Q?C6WGlcWT9hPs/HHixkgyxNf2SgzYMK7HwGZOQmQrtpTFLNBL1yZoyD/kn0i/?=
 =?us-ascii?Q?awUJhVUWOUmpd4vyJqz2Pu45jWcD3VwwphOoPUA7JUM5sFGWwb9BOzpUfEn8?=
 =?us-ascii?Q?yeer/PyTapuW5ecie0/ftnlEc3yv5vuyE5aKdecLRjohI28ATu9G1uL3h10S?=
 =?us-ascii?Q?sZibs8WyLQc9zKNDX3286AJOtZVTBPB3gMAQrYXAGdSivtsf/atV/mugtKu1?=
 =?us-ascii?Q?k/i+IdxmyhT0tTiAQy8JHcng8Svy6TOLMWXlzA+oUtl8usQWKRCa9h5twsBS?=
 =?us-ascii?Q?k9kdKZvVXI5g1Rzv28VGO8K3t1vyOrBieE08yt740lrqP78qln/zeFDTM6Ey?=
 =?us-ascii?Q?RhIDiz0VyOac67CGK30djTM/30d4ZRd+kYCarE0E4vobmPXyMBmTu6oTUvJ0?=
 =?us-ascii?Q?8/xEBXiHs3DU/Vrjsby92P+JU2NORpU0s0uH2qfxZhGxgpamUb3efc25ykzB?=
 =?us-ascii?Q?kiyWBdhdgPOKyn7ZZUA5tyGjrna6WPKOwX3afmj7QcCkgKvGlW6+AjH38wFj?=
 =?us-ascii?Q?tQliznbMG1IJqrJixkiPUoQn/gT8wB9puOkNI+b379L1Hzq39WwPBraTqxQ5?=
 =?us-ascii?Q?xCw4KFjmKHIuNU8S5b/8XLyc4cbaplJkr6CRBddGTcrkNM05xjWCRqPA7EQS?=
 =?us-ascii?Q?W5LaMCf00uKA//4m8DwqXi4nldvdvJfL/w906iTVlOd2jgxRgwBZshJ/9ljL?=
 =?us-ascii?Q?M80sYijJMWhMkmnRfdzTQzjINQO0QmJBPhAm1wm0BEqQ1HOoEVsPUYfcWgw3?=
 =?us-ascii?Q?82fwHw7u0Ylj96g1Q1rJkYKcEmuUcfZ2hYycA9+MJ2Lhg7Gk/cqGIaCGbQcX?=
 =?us-ascii?Q?8ERUIpcGmtgHvnwZIKFzbbBaHUTDNfLnCLjoBOcbliTwBPaf4K2r0+PoPvxI?=
 =?us-ascii?Q?XuOiU6C1PZdhNJSE1bYQQLmDoZiUVyXGhhP3V0CpG2gDTjC9lxUNrFmrCOoW?=
 =?us-ascii?Q?qp3mWwqD+HnxJHyQIslmFtVb8G/TGfgNylDYHkx7aY7fcjOmvLJg1bObnS+M?=
 =?us-ascii?Q?ORMTUO+04ZRs60v/tGyumpRYRa7as5fhuvKBS3ME0Vaw/XqF1/jv1w5N/kzl?=
 =?us-ascii?Q?Ki0OmLdNMvbRCx9jVXQuf2Bo2Tp2chJgCwptmss7sznSpLyIskAH2vrELtJJ?=
 =?us-ascii?Q?UDMpid9sMtgnSy0tuvayCClkUqBmjpo=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ab79f5-0673-46d9-5986-08de627c6ce6
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:59:27.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f41hJUPHYjjvQHZwTii6wGv09kT7tbpGjuFz/jnNb8O2Afc5PNqJKy2yjarlkgZmUOaQMq/3wGJPLa2i7c9GpeXshJSNZksyEtATCroVrgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5488
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18647-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: 38C44CF485
X-Rspamd-Action: no action

If configured with "sign_fh", exports will be flagged to signal that
filehandles should be signed with a Message Authentication Code (MAC).

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 support/include/nfs/export.h | 2 +-
 support/nfs/exports.c        | 4 ++++
 utils/exportfs/exportfs.c    | 2 ++
 utils/exportfs/exports.man   | 9 +++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
index be5867cffc3c..ef3f3e7ea684 100644
--- a/support/include/nfs/export.h
+++ b/support/include/nfs/export.h
@@ -19,7 +19,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS	0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define NFSEXP_NOAUTHNLM	0x0800
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 21ec6486ba3d..6b4ca87ee957 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -310,6 +310,8 @@ putexportent(struct exportent *ep)
 		fprintf(fp, "nordirplus,");
 	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 		fprintf(fp, "security_label,");
+	if (ep->e_flags & NFSEXP_SIGN_FH)
+		fprintf(fp, "sign_fh,");
 	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
 	if (ep->e_flags & NFSEXP_FSID) {
 		fprintf(fp, "fsid=%d,", ep->e_fsid);
@@ -676,6 +678,8 @@ parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
 			setflags(NFSEXP_NOREADDIRPLUS, active, ep);
 		else if (!strcmp(opt, "security_label"))
 			setflags(NFSEXP_SECURITY_LABEL, active, ep);
+		else if (!strcmp(opt, "sign_fh"))
+			setflags(NFSEXP_SIGN_FH, active, ep);
 		else if (!strcmp(opt, "nohide"))
 			setflags(NFSEXP_NOHIDE, active, ep);
 		else if (!strcmp(opt, "hide"))
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 748c38e3e966..54ce62c5ce9a 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -718,6 +718,8 @@ dump(int verbose, int export_format)
 				c = dumpopt(c, "nordirplus");
 			if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 				c = dumpopt(c, "security_label");
+			if (ep->e_flags & NFSEXP_SIGN_FH)
+				c = dumpopt(c, "sign_fh");
 			if (ep->e_flags & NFSEXP_NOACL)
 				c = dumpopt(c, "no_acl");
 			if (ep->e_flags & NFSEXP_PNFS)
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 39dc30fb8290..bd6669f431ba 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -351,6 +351,15 @@ file.  If you put neither option,
 .B exportfs
 will warn you that the change has occurred.
 
+.TP
+.IR sign_fh
+This option enforces signing filehandles on the export.  If the server has
+been configured with a secret key for such purpose, filehandles will include
+a hash to verify the filehandle was created by the server in order to guard
+against filehandle guessing attacks which can bypass path-name based access
+restrictions.  Note that for NFSv2 and NFSv3, some exported filesystems may
+exceed the maximum filehandle size when the signing hash is added.
+
 .TP
 .IR insecure_locks
 .TP
-- 
2.50.1


