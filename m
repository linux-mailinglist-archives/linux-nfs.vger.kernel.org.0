Return-Path: <linux-nfs+bounces-2297-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109C187C69C
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 00:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0FFB203F0
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Mar 2024 23:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058811185;
	Thu, 14 Mar 2024 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PlW/74j8";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="eCUkvD4a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272210A2B;
	Thu, 14 Mar 2024 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710460268; cv=fail; b=FpBMq7yR/yDt/uHVojKsevHc376kCbuZUO6v6Tt1kotHkEFrjxr4Z8ltcwLtJJkLxSsZM5K8SmKY4NzxtAQCrtUTZgqQ+xnhoxcV2/y8jrfqgdI+DL2IENpsHwQcsszqMaaPZabPVOaAxNMF7YhU8oPrwfZ+mNmkCI9v5Q83+kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710460268; c=relaxed/simple;
	bh=sok2APe2uZ4iOZX3HOgT/VXglPEEfYGblT8jWPFQIdc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g7sNPUVumkOnGExFMQYI6Ar7ZnAspDRM/HSW5IqYdRy61amZCQvuehPTzFogpKxfa1fonPtPF5t89uRbL6nqA6c9ba5GSbkkx4+elxN9gL0kRWPLhztma5LT7liyyDevCGWHx7XPTwtbLM5CyRqw+VzgYHGEseoy5uI5ZWtiNWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=PlW/74j8; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=eCUkvD4a; arc=fail smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=594; q=dns/txt; s=iport;
  t=1710460266; x=1711669866;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=sok2APe2uZ4iOZX3HOgT/VXglPEEfYGblT8jWPFQIdc=;
  b=PlW/74j8snSU4o8gPfOwG+xYjSqdZY3kiH4DuPMz+YQfKy99S6E5upCI
   d/tVLO0RJSHcIpDO4Il0/VmnqaK7CmScgJYpjHUzetHYJ5+pkN354dzp1
   OiuD7aCSCB5I+zSCteRaB1BdZyLc/UHA83hnWGDdfXa+ku1Q1oDbQOpJy
   k=;
X-CSE-ConnectionGUID: 2RJnAPA4SEufgwz7l/0QmQ==
X-CSE-MsgGUID: TVuAl+MTT9iyqatogXPh9Q==
X-IPAS-Result: =?us-ascii?q?A0BIAQDci/NlmIQNJK1agQklgSqBZ1J6AoEFEkiIIAOFL?=
 =?us-ascii?q?YhOhhqMZ4smgSUDVg8BAQENAQE7CQQBAYUGiAMCJjQJDgECAgIBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEGAQEFAQEBAgEHBRQBAQEBAQEBAR4ZBQ4QJ4VsAQyGURYoBgEBN?=
 =?us-ascii?q?wERAT4gIScEDg4Zgl4Bgl8DARCoEwGBQAKKKHiBNIEBggoBAQYEBbJ4CRiBM?=
 =?us-ascii?q?IgmAYVZGoQ+JxuBSUSBFYZJAgKBRoZbhVKWNYdVgVMcA4EFaxsQHjcREBMNA?=
 =?us-ascii?q?whuHQIxOgMFAwQyChIMCx8FEkIDQwZJCwMCGgUDAwSBLgUNGgIQLCYDAxJJA?=
 =?us-ascii?q?hAUAxsdAwMGAwoxMIEWDFADZB8yCTwPDBoCLw0kIwIsSgoQAhYDHRowEQkLJ?=
 =?us-ascii?q?gMqBjYCEgwGBgZdIBYJBCUDCAQDUgMgchEDBBoECwc6PoM/BBNHgUSHXYJFg?=
 =?us-ascii?q?0IqgXeBEWoDRB1AA3g9NRQbBiKjHgGDaCuBRmcPP8UoCoQSogeDX6Y8g1KHM?=
 =?us-ascii?q?o1bIKgzAgQCBAUCDgEBBoFkOi2BLnAVgyIJSRkPjjmDYYUUimV4OwIHCwEBA?=
 =?us-ascii?q?wmKaAEB?=
IronPort-PHdr: A9a23:dFdyABcSZWHxf5Bqi2zkUgaYlGM/eYqcDmcuAtIPgrZKdOGk55v9e
 RGZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NBsdA97wMmXbuWb69jsOAlP6PAtxKP7yH9vehsK22uSt8rXYYh5Dg3y2ZrYhZ
 BmzpB/a49EfmpAqar5k0BbLr3BUM+hX3jZuIlSe3l7ws8yx55VktS9Xvpoc
IronPort-Data: A9a23:eOdol6rVfbdGbsR+LNxB4jOiE/deBmICZRIvgKrLsJaIsI4StFCzt
 garIBmFbquMa2Twedl2Odm1pEpS7cKDn9FgTAFq/yEzFi4R9ePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7wdOCn9T8ljf3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYADNNwJcaDpOt/rY8U835pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86rIGaRpz6xE78FU7tJo56jGqE4aue60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/yxWZcV7FLH7zXeX6/axyWT+WifX7uhgA14kYolfot9yODQbn
 RAYAGhlghGrjuayxvewTfNhw517asLqJ4gY/HpnyFk1D95/HsuFGPuMvIQehWxq7ixNNa62i
 84xZTNpbRnEfBRnMVYMA5V4l+Ct7pX6W2cC+Q3M9ftmvAA/yiRN7qXENJnwRuDbRNRMl1qfq
 VL+/zXAV0Ry2Nu3kmfdrSn22YcjhxjTXIMUCa398PBxqEOcy3ZVCxAMU1a/5/6jhSaWQN9bK
 koJ6gIwoqUosk+mVN/wW1u/unHsg/IHc9NUF+t/4waXx++Nu0CSB3MPSXhKb9lOWNIKqSICj
 GWrmfrRLGBUnaCbRm2PqbPT9Qq3AH1ARYMdXhMsQQwA6tjlhYg8iBPTU9pueJJZaPWrQ1kcJ
 BjU9kADa6UvsCId60msEbn6b9+Er5zNSEs+4R/aGzv9qAh4f4WiIYev7DA3DMqszq7HFTFtX
 1Bdx6ByCdzi67nWy0Rhp81WQdmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 xaL5V8IvMAJYCf3BUOSX25XI5l7pUQHPYm1Ps04kvIQCnSMXFbeo3EwPxL4M57FwBF9+U3AB
 XtrWZ3xVSlBU/sPIMueTOYG2rhj3TEl2W7WXtj6yR/huYdyl1bLIYrpxGCmN7hjhIvd+V292
 48Ga6OilU4FOMWgOXa/zGLmBQ1QRZTNLcqo+5U/my/qClcOJVzN/NePmul9INE/xPs9eyWh1
 ijVZ3K0AWHX3BXvAQ6LcXtkLrjoWP5CQbgTZETA4X7AN6AfXLuS
IronPort-HdrOrdr: A9a23:xJxHEaDne0dA3zHlHejqsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskdvZJhBo7y90KnpewKkyXbsibNhcotKLzOWxldAS7sSo7cKogeQVxEWk9Qtt5
 uIHJIOdeEYYWIK6voSgzPIUurIouP3jJxA7N22pxwCPGQaD52IhD0JcjpzZ3cGPjWucqBJb6
 Z0iPA3wQZIUE5nHviTNz0uZcSGjdvNk57tfB4BADAayCTmt1mVwY+/OSK1mjMFXR1y4ZpKyw
 X4egrCiZmLgrWe8FvxxmXT55NZlJ/K0d1YHvGBjcATN3HFlhuoTJ4JYczAgBkF5MWUrHo6mt
 jFpBkte+5p7WnKQ22zqRzxnyH9zTcV7WP4w1PwuwqgnSW5fkN+NyNyv/MfTvLr0TtngDi66t
 MT44utjesSMfoHplWk2zGHbWAwqqP+mwtSrQdatQ0tbWJZUs4QkWTal3klTavp20nBmdoaOf
 grA8fG6PlMd1SGK3jfo2l02dSpGm8+BxGcXyE5y4eoOhVt7TlEJnEjtYQit2ZF8Ih4R4hP5u
 zCPKgtnLZSTtUOZaY4AOsaW8O4BmHEXBqJaQupUBnaPbBCP2iIp4/84b0z6u3vcJsUzIEqkJ
 CEVF9Dr2Y9d0/nFMXL1pxW9RLGRnm7QF3Wu4tjzok8vqe5SKvgMCWFRlxrm8y8o+8HCsmeQP
 q3MII+OY6UEYIvI/c/4+TTYegnFZBFarxmhj8SYSP6nv72
X-Talos-CUID: 9a23:qMDCIG5pK4nT0T9Sd9ssrnQ2HOkdWyHm4WreLFCqVmIuEISQcArF
X-Talos-MUID: 9a23:qp0RYgTEGEu3UxL9RXTQuixLMIRN35j/CVEUmIkBtPm8NX1JbmI=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by alln-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 23:49:56 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
	by alln-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id 42ENnuV5019108
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 23:49:56 GMT
X-CSE-ConnectionGUID: 6HbF0S5wQ3eqP1qVftk6nA==
X-CSE-MsgGUID: nhcq3V+ITpC1VKWEtqaRMw==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,126,1708387200"; 
   d="scan'208";a="5733102"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 23:49:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtaAcNN4N0ZAzOsvrPBsT5MnAkkXXyi8aUpry3x88PXhEd0A6rKh70CyLJVYk6qPMLo25WWz9ImJZ70B+nM2O2HfuYte3ZZPcplo+vrSN73yywFJHlMYOL6XhjVtZWc3v+jAiXHFS77PeQ/ESIOaK/+yuq6iV9vsY30ujv0YRzfcizvAzxTudmeeIgTr693+A+qR7rJnwQM9z26ggVhkoRLT+iZ8hvvbMKRJN8BA8FXmKkzrJItgogL3e2wTwI8XBiDc44l+VvX2LNyJapaJ6TD6EP4nyik840JAk4VIyp88chzYWIJzUYpqLh3IxxUsyI1p5X+M3Qeem67lyb4Rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sok2APe2uZ4iOZX3HOgT/VXglPEEfYGblT8jWPFQIdc=;
 b=b80YAJxXDAkkSFC2aygW+9/YcjlMexhMHp5V/6ozRlfu9A6K4X9rltRv4vHkCJjutp/K2XtDF5qglrCmdJbWyIcGy9kGq3AWelL505H+Me9OKuuvol6/D/ODZvFNlXdlzMDvTfieWnCa5Ryv6ecGm1vF5Ko8ccqrF1ndTEBWbjoyXXA05uHxYTkiAyvj4nLxckMjYPK2+iMa9/PoEW6AcQTboYoWy9Dm5we+DLcjh3ZVIm7Zk2RxtDyn2zUD545skMSaUSm6cBkHkOIcOowxyVOeR2erlW5QM+ac3MH8VGycNT6U0IiAWuLkxaoKLVk4dbpDdE79Drz1IL+Qj/XfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sok2APe2uZ4iOZX3HOgT/VXglPEEfYGblT8jWPFQIdc=;
 b=eCUkvD4aFm3k26MzylgZHYSDd0EbUwZSbc8X78Axz8QVJOJXVcTanSE0SBJVb+Nx3+Ure2IER4HQBAVftv+53njb19a25He2GxqMCEf9LON3G9i1o5jvJwEdRMbtJdbCSy/e3MYjMgN7zM3rVina+nmEHqLN6VYjKFnWd+MAW8Q=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 23:49:54 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::22f4:4617:117:7a44]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::22f4:4617:117:7a44%6]) with mapi id 15.20.7386.015; Thu, 14 Mar 2024
 23:49:53 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
CC: "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: nfs client uses different MAC policy or model 
Thread-Topic: nfs client uses different MAC policy or model 
Thread-Index: AQHadmpPdLuamV23IU6d6aCv68CZjQ==
Date: Thu, 14 Mar 2024 23:49:53 +0000
Message-ID: <ZfONIThp2RIfmu1O@goliath>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|CH0PR11MB5316:EE_
x-ms-office365-filtering-correlation-id: ff164007-1068-4042-9eae-08dc44817231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SVt1R5xTHXwl9cD5gMZxrO9hksehLrm68o+2YNa+7fjGr3ljcaSkBe7RbTdBvc+63bTYbmXaZfBlGi2RG1KfHWKVJzpgrzRsxrpwsaGZ99LYqnxYPzEQVLmI8M5HwVyBIkiYlE5GHmA1e82EoBJ/yQDPpHaGxkiPT/zAGaV4M1Tkg7B28CnjspkaqzBVUBATDceXBukQiBWg+g3xrRvQeT/U73lumMTfDE4fd3q39PuK95BoLKh7E3cDVs8CuWjXBmmvncvJxr8WDwPbQZsK9/obsGrsrmBqq9dCMPd0igv0UPzL0tSycIfEYdl7M4TNudeIpNTYvazp3O2Vhgf/QxTNop10L76AiCFoTyDS0vCP9Jvx6X7hjC0AF8fO+Sb7PXf0icWSPg2qW7+KnsOL0FUXzBPJt/U/cSaT9bBmoZkXN+FJVUII9PnCwCqzINUkHmVA1QjOQ66wFJJVspRvw++O5LAd7UR3LagQ0MVTV7dlwzZ7Fsihr7ILLRj9561y02tjeloLpuccI/aFdJadAiy1TUlybXAa5Cryv0KjzRByJDZnQgOAGWa3Vn21L3M5Q9+GOr3lF1S++6zURkVxOI6/vGHvYRYac130vAto3tZ20MuwWpJ6mf7clBO+tEwwcDEfSaI+1ZvEU+JkDIUyxEO7IolmE1qfJqZ+IvO9keU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W0+DlWLSRpOYYo5lulwL48HKW6ZePzg7o3qpJlQ0+oKmLSJXhRuj+t2a5BLo?=
 =?us-ascii?Q?ejMxLFG9PVexet26FGiet/lrLO51XsU8YV5/0v/K0y7M+WV3oJwYD9CObcdc?=
 =?us-ascii?Q?YHL/C7tkUSFdhsmC+KfgEhZw7LzgROqFsheLBGGZHdPKpV89w6Ijv18WDPCt?=
 =?us-ascii?Q?ay6nb37f7TitUcNeplOccCWaozcOeAPp1vwv8c8HIWeLvkn6L9JhxLFzXSPG?=
 =?us-ascii?Q?mBanC5b8tXVmwzuh8i8DECpcKBHP6GLnEAPZfjGw7nJKNiOgDKDdVMgnaq/g?=
 =?us-ascii?Q?FdsW51JlJlnu84n3I0WpKRRj73CRo+c79vKPRtOLETRTzSoxoaIGB7iv/v/H?=
 =?us-ascii?Q?nzcZClRQf+FfFC/xiv6Vfbag2a0qGdfaP2cKe6OtJOQC4rK88OIMndfRINxU?=
 =?us-ascii?Q?iarGZGnleJ6PE2/y7gNkvPYKjB97q6ttsEpyCdx3Y4ZSJmZhgxUgjnN5Ouah?=
 =?us-ascii?Q?zKNK5mB+48CAIKgKy7YekwYMfrwQaQ664asgRLtRnpIvgsmoaZXVBVHD9h6O?=
 =?us-ascii?Q?eM0Rk9nnJ6YwYwgwr4Yjs+/VORA89ehzE7VabLSNDGigJucQrWfTnUQFeWmG?=
 =?us-ascii?Q?GsaHzmbIm/MLyXzZv78gZyRNMLVlXN4VV2ubE7vAh34tclYXssezaa8zFwMn?=
 =?us-ascii?Q?qEnuXjYApprb6bambg6Ze32pTTq+fSKpfxMiel0iS/RVpSnlu6vjyXe+9zkM?=
 =?us-ascii?Q?0artFd8oVsFfPirApYhlgpnQkCElu+iJtcsqH9Gc7oBeesk1FM+ody+7ouXv?=
 =?us-ascii?Q?mu8xQ/CYu+goPpqGZmTz0XQQ0NhIVPUT+7YqfZaaxuWyF+OruupddYCgEX+W?=
 =?us-ascii?Q?4nFPSdIWpH3HEljYyBvly4mgr2fN8yp/gUgNkx+Yfx97LZD01Ew88UscW+Fk?=
 =?us-ascii?Q?J/S6G7TWfcj+iSdl7lswAXKT3ASpIGpLkApHW5jyVFkV8tWodGd4draQu5gI?=
 =?us-ascii?Q?nGM5bkN0QO1MgDb6YytuWaU8gw1NlQaN4NGqcE/ixH28/ZYpM4j+wA+lx27k?=
 =?us-ascii?Q?Ssk5yVHZvUE8uYSZb6Zy1IJ+3vCb1LUbOkSWlNMoAldLefwya0qQNuTUHBVs?=
 =?us-ascii?Q?MRgsqfHdk8kIvbMmYmDQENHYxjLNJLjsAVAQDUeIG55PT1zsyLfXeYNreC54?=
 =?us-ascii?Q?a2FzyQj4uO07+zBbAFEr0JnoB3iAk+gSBX7zf+BM3uQ8K/qLKINJrymc8/PY?=
 =?us-ascii?Q?Af5kKIQkGJxrBF2K/sQn1x8364LtbK2qADL9G1pT17q3tNEaZpE8NGMPIHW5?=
 =?us-ascii?Q?plMd+fvJ1qdHNhSfFkmNpivE7fnCbIU71p2Rq9NEJW8FIIBy4eC7894/yBZx?=
 =?us-ascii?Q?HfqL5yGE/qHa6UF0SLNQjFsHMQxQKTo7r4m0CqYzMxnmhJY3x11NKQE6zWwC?=
 =?us-ascii?Q?c+BCuezH8YqQyz7530m/AWJAjnNRMCcfSHUNxaHInZCLwSCPIF10b2GDL5iR?=
 =?us-ascii?Q?UgHz4n/3crax5XlT0Bmzof1+Ep3W9gJTti82/46l8yEZvBYEcFRPmWYGI2R1?=
 =?us-ascii?Q?ia/HnCmPt4MYGjRkbBSmXxM+WI6qX0uOpwHACA3GFXL8A1iDC68feh6t8RZS?=
 =?us-ascii?Q?0FXEv5IJWycLmTNel9ddYIEPeLzx2bxSEalLKzoW?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2A5410F7557464C86D6A82D0989A516@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff164007-1068-4042-9eae-08dc44817231
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 23:49:53.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8by/onizw86Mr9fbiBwOBjVmkkh2LYVNlu62e7EKwDC+xn1auVFG6G8J6zZuxvCU++TaviZyhu/SMXkO53C71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: alln-core-10.cisco.com


Hi,

It seems there is/was a problem using NFS security labels where the server =
and client use
different MAC policy or model.=20

I was reading this page,

http://www.selinuxproject.org/page/Labeled_NFS/TODO#Label_Translation_Frame=
work

It seems like this problem was known in 2009 when this page was written. Is
there a way to accomplish having extended attributes shared over NFS to a c=
lient
with different selinux policies ?

Maybe it's possible to allow the client to write local file context without
writing that down to the remote filesystem.

Thanks,
Daniel

