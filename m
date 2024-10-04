Return-Path: <linux-nfs+bounces-6867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A59990AC9
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 20:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DB81F21AFB
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DA057880;
	Fri,  4 Oct 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="iVLmM/0g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2130.outbound.protection.outlook.com [40.107.96.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E81C7612
	for <linux-nfs@vger.kernel.org>; Fri,  4 Oct 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065647; cv=fail; b=QbvC7rEP6ukcIMpNQSZ1SeUun1YHC4V19/Zw3ereMviTWFyYqcu4uAWaVxxcQYUVaf3m73geCdzWC0c+czJ6m3/Aox3WXxTZGK8qocCxT/wIGANjhQEatM8NKtEXSeQW7JUGlw9dyuqUBJ2As2W0Xg3QZGHXc3L776FOqpwaKmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065647; c=relaxed/simple;
	bh=n4DzB6bmwG3LTQO5QHC4HWw19U9pYfVYSIIZ44v47Hw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KKroTI1WQLgRd4ARK6Bns0+6rbw4sPmAl9XYqGM11UdyjFsmeA729dXXoejdkNoBRzjiIrIvet3fwxK8iRiEXVgJ+y251GzhVQctVkiXFR3IGwtjD0NaOo/FYkS+nGzTQHLgSZXq55XDrVsuA8BRxCd5Gppgcp6WdDMM3FbNkvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=iVLmM/0g; arc=fail smtp.client-ip=40.107.96.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzMiM4hR+sHsY6+XkgHg+k6HOIYE5JxqG7HFnSG4IdHqBeMj2qrJlNu5hLyIh8qXZXKyKIMB+5vCDWDMJNQ6cWIzyuJSkzz0dlW4rNdj+M9RnxVU4wMs57lS9uFBZuXqCvDEnBl+cYUuaBvbAg+fbOv2bUJgQ0CJiF32dx0HwRRu7jfTNHM8tlPS4btydMAqqV79r1gKJb61C3Q94/4TKjfuy3l2Da+qePWmpkE7zInAchF0J9ubTsKd3bZoEDsOlXUPv75MuWIuTf5WN7rC6Th8oW6thxegQhkd3QDmheOdAOZC2PGKJ/unu7gt6IxxTXY9MLIZsbJschYFS0cx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4DzB6bmwG3LTQO5QHC4HWw19U9pYfVYSIIZ44v47Hw=;
 b=P6TQyZ5mKnCF2zFu2fC391761+4tIqlSuQz8qfYwZ/1ubfDJ0bo/YXF5E6Nkn6ckBh4ylSXIgbTNovE7r6+YukRhhY1++X90vk5y2RChjkYynGXgVhSKlLdG1xGGN8Ma2rlP1YppTJMQqRSJz6molaUKRfBbJDj2xotcvE/HT0W6kWpRwSIuBvrlguGMyOvn/MWe4kCyVh9jUY9PNlcizWZbOeaYOrzi09kx4wHUvjWKa00+FWYBg+vkkerOEPqBRsX7Y3uNaRSGkT8ZaI7su69BugmoOtGXyy6HK8IvsPj5p+3Oy7PeLnJFXY9IOXQbJpWPwy7ojglPyKwnA69x9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4DzB6bmwG3LTQO5QHC4HWw19U9pYfVYSIIZ44v47Hw=;
 b=iVLmM/0gFfZuRWBNQUgcUmGw+ftizVZ2wZ3uwGIBRpxu/XVF/QEdAXf2wsbk240oLWjwIVgc4S3hEqCwEeAVjzeof4gfX6QK2dDrfGE6nK3sms2r8pgch+kTFmW/dBeMyIZgHTZAX3ozT9Jm9NXt/xvHpim2qECMlHtqXc7mxZGe6A+uOQQzMx/114KfdynFhraGwFVMnMt93lLEVmUGssYwGnRZN9tCAsRxcN4tEZYIUFycbdXW3T3guPCP0bR1kFcKB1cWHJyB8ztMaiIsKGwqBxOL43Sghif6DfoCUZkuCmLJffjkSwQ0wgVBQaLvjIVfbLTHQfBHmHehxnaioQ==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by MN2PR14MB4207.namprd14.prod.outlook.com (2603:10b6:208:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:14:04 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 18:14:04 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: probable big in nfs-utils
Thread-Topic: probable big in nfs-utils
Thread-Index: AQHbFokAo5kdJoNLBUCDSplB1qnHwg==
Date: Fri, 4 Oct 2024 18:14:03 +0000
Message-ID:
 <PH0PR14MB5493F5F79BCAE03BF2C25ED6AA722@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|MN2PR14MB4207:EE_
x-ms-office365-filtering-correlation-id: 3a0ea404-fcbd-4f82-a965-08dce4a0544e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?t101KnwPu8KySppom1oAi6xnRENLPj+np+hDw6xyfuNQg7pAUu4aKBUBDt?=
 =?iso-8859-1?Q?zzPXE4rHmWmDVyV/HGd1U9hoN4RHNdvcywz40sYf6WEfF7imrz7rhx35ST?=
 =?iso-8859-1?Q?2kp5V9v7dXFyTIP3iZGVRgUtp8Gkafnw80SXlp8ux08osj5TQ4WZHHc/ag?=
 =?iso-8859-1?Q?qhNkkP+jqI4WRZeK/zMjH34410H7oM1n/Ux3l3nxQr2wqbTBG0jIN+bmbS?=
 =?iso-8859-1?Q?m7lGCh7QPc/+jsg+1qIIRlmSKsgCsVADk7ra2PP5PWU0g0BvNOWoWG4oM8?=
 =?iso-8859-1?Q?v3iiWWlDA3h/j9Be2s0X9AvJhhJS+jzBTBdQ9t8Jbw7Mqz59S9tDGlQip1?=
 =?iso-8859-1?Q?/8PzY50gop5cHhaBWwnkJP0E7N9HPVUifUd0nbSjAgDR2bUDTMZAM7tL+/?=
 =?iso-8859-1?Q?ID4rs+otuxiqOVzszeNfU3LCgE1jVmPpyHI6n5KrPc9M8sZhYFvTZ+TW1D?=
 =?iso-8859-1?Q?U9hQc7jLIaxd0zxNoWgLUh2I+mb3GjHZ+JbiygJZFxTokx/ghCyhe3rhFW?=
 =?iso-8859-1?Q?Hg8oLMO0IZBHtZXK4pT2216PO2NrHs2mfZU4v8HBknKtsuxM8iCN7k5dbD?=
 =?iso-8859-1?Q?s2C32S/qaVFX0bNBOgblPCX3psNgr8k4MK63ySop/3qAsdveugbTw+DoRq?=
 =?iso-8859-1?Q?QKWNfzFmetNmrMZJZY3YBB1lVvZ0FwjxafAuYoXoQuXFAOMP247o3AUdSr?=
 =?iso-8859-1?Q?hm4+ysyycispp0m1r5kq4zv/OeL+Thlv3fCEvC7yCHMEEUoqhAbVNO+A0U?=
 =?iso-8859-1?Q?i2JZ9fVlxq4bJmucNMu/v8YZdY50sFMIZxlrvlvJFdqh6BTMw2ypWyhGil?=
 =?iso-8859-1?Q?h51EYw9kCGCh952kw7DvNzbTJHOMUu2VYJHEra+x6tF4R7ubyP2DvpliiJ?=
 =?iso-8859-1?Q?JDClMSUbdx+VaFGaOB79t6ue2198uMGSmaderdIVMolFwDls8RNRW9onni?=
 =?iso-8859-1?Q?vGhQLotLDKBZyTPiroIP0+AOiiXz2od5ba0dwKtaJw2ehnxvGCUnWDKtsK?=
 =?iso-8859-1?Q?SvKW2wr6kPfExlDvBunUsmyOU99yu0TjrOxz7zzVW5/mPTvgiWcvR1NHxq?=
 =?iso-8859-1?Q?weWmRYZjsfuBnNBRB40fVaWgH9A8i9DOquQH2kTls9X0EQ36ruyMl6yYB6?=
 =?iso-8859-1?Q?GnhFwqFu1jjDXwBsyuQN+llcl+xxk+PnRcLGJEA3FjXmHvI3OOACTv/js+?=
 =?iso-8859-1?Q?e5QIt8TZypzT/iky5+rknHejEROB5qHEO3DlrqeoTG8qVe3l6oPYd1JIOC?=
 =?iso-8859-1?Q?heQUj/DzVfZqsLfG5UoBbLt1j6D72I1AO3zZ3KfJCEzrSxN/TDAeyjRm7J?=
 =?iso-8859-1?Q?mzaFufbfMZzBts2Y0BdqwrjOi6/m76cC6EXT9APVDF46dqKX18CgHg87rZ?=
 =?iso-8859-1?Q?APKSxl2yd1hSvWzdZMeB4cbIdB5vKkVg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?W7HGA2MKrqQar0GgneC0uGADRXjgsUTqLgjCeFq+ucsP1jgdZp/BWzyh9U?=
 =?iso-8859-1?Q?UISstsrw9XOyPoLVwbTjX4WHkt4Fag71qAkBzRtYm4QjaJZP0V5JywWPiV?=
 =?iso-8859-1?Q?u7oikA/M4L7Ak0WWK4sHT4fUsxwlss/EnMuZd4fpBs+ZPvCw2VZkMjrNpN?=
 =?iso-8859-1?Q?s1mFTNF84+mStw1gDFUp55XrprVeI570uUsO1nF2kh6y4zSTSCTb3istxY?=
 =?iso-8859-1?Q?J7L2Dplpq6MrLuCWzrzz8xzKGQCtSM2K2jW+UpiqyfBlB58DymVdaYQ4mn?=
 =?iso-8859-1?Q?wh9p0/aWP0Jr7zIojF7+l2iW9UeRRz1eAJOntQd72PERpevDAqCWGoytkX?=
 =?iso-8859-1?Q?8Wlouijf/m2PtbG5wnHFnsAy7YNiAW+oxrz1T3ippmngCsL7GTmdvb6GIq?=
 =?iso-8859-1?Q?EqXpi20/WxIlIgr6lUR1WbUHQjjT2DKFxbkOzmEj4OVjnDqMZybRVpr6aQ?=
 =?iso-8859-1?Q?SSL3p29tcZHzZQcozdDyUZlTEV1cjwkqyTBapgKjuwVWIiakZYUAP3UPck?=
 =?iso-8859-1?Q?khHIqixexxZ84jJpx7/QzzyiECJ46H++L8x7q9QWUI8NTVFnQLIwXdL0id?=
 =?iso-8859-1?Q?wEzk4OWjLEuSGQLfmmBhYey6WLvLyH164Bs+q5U6NirTw0kHbhkQW9dPtP?=
 =?iso-8859-1?Q?y5RTgzSrZgASN4ryGh8x6OeNBRg/cLU6tzKamZPiH73h25d0cMWPd/fBfI?=
 =?iso-8859-1?Q?a7AKAhHQY5Fw7XhiDZ4D+bzQu5nmldRxDTo2yFiwD2JzZL4ES2/56NzWgI?=
 =?iso-8859-1?Q?OtEqvKdOiio5KvkMMbXHrVJm5XeOsTKtKiIyjUzPyiuyGKLiXcev/CpWCu?=
 =?iso-8859-1?Q?+ndjaPzkN1JREN/MdJbnbUXWZiYpglFB3oEXFQXCkWfjeHPKWl4uGVtdVn?=
 =?iso-8859-1?Q?OdYj2ARKKvwZPmSN0PorEZi50SZpONx21rSzFVLPo1hM9lNY2io1/7vnN/?=
 =?iso-8859-1?Q?qjOH6B93LRO/4MSrHfpAInS9VkrSbB1nYwF3v3DxgxHsoBVEzK+aU8usAD?=
 =?iso-8859-1?Q?8+BZUngaTjQj0E6ACu9GTWJd4tc5sB/KY/cDSRZhqZqfiTLVe5WSy0OA4w?=
 =?iso-8859-1?Q?VBSC7uDR9xNzCagJJvIilg752OJBaC0x6MpnQmuYWZWNSmYVZ0YS/pxhUE?=
 =?iso-8859-1?Q?Bk0w3/sZlNsXAzqE6y3EtawFHfLGd3DafpE+fahbwmiRAZ2bAa3tJo0Bsh?=
 =?iso-8859-1?Q?BRr5BebZdSbNZfocRir7RTWW/3G85q4MvetiXZhvKr6ONbN05FnjNx++x0?=
 =?iso-8859-1?Q?NMSlL9RfbOblAaVy26a/BCvmjsg0ZafI1bPMYkWtuXRVaZQPXOlOBw1m26?=
 =?iso-8859-1?Q?48ciRJvr+RAYwWwPmxO255j8cAm2hF36Qf0ARv3VkwyOXmSJVmspoLy2Zy?=
 =?iso-8859-1?Q?+RXbfMlzQlDjQ3RHR2ZsjmFrlzvcqy8/GgZ7kLZQX64Vq+4YrL8lr+RLk1?=
 =?iso-8859-1?Q?9xFRwSC54dOpvUJ+f9FeKKU7wNzB/Rh8WuY6Q7zy2G1y1JkvcQ65yWcO6f?=
 =?iso-8859-1?Q?fNhAXUjCU9ZTRVkgAKc2ev5tmTc5wNjo6dlfNpgB3lNJQCRnkVyOtmzPK8?=
 =?iso-8859-1?Q?k8vwQwXJTcYFVCQzSMTlQHPl8/pt0ws+GFlJw1Csl25qfoqe1nY5NeIAU6?=
 =?iso-8859-1?Q?8wHrZ8oduB2xqZ1uLO1kI6Xa2AoMh5/fwcGWSNJH4W0hw2hL/J3siG+w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0ea404-fcbd-4f82-a965-08dce4a0544e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 18:14:03.9608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiD9C5vfprwRYQ3Ku++1Cmm/3p2733VyTrYgRdyC7IR52O94pcW05khENFJEc1B+h+YbyMat7FqqmWfahBb5KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB4207

While looking into a problem that turns out to be somewhere else, I noticed=
 that in gssd_proc.c , getpwuid is used. The context is threaded, and I ver=
ified with strace that the thread is sharing memory with other threads. I b=
elieve this should be changed to getpwuid_r. Similarly the following call t=
o getpwnam.=0A=
=0A=
Is this the right place for reports on nfs-utils?=0A=
=0A=

