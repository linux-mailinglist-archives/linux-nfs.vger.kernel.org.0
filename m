Return-Path: <linux-nfs+bounces-5966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C849647CD
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 16:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EB1B28672
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7D91AD418;
	Thu, 29 Aug 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j+m2zrs8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CuGOssQq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795BA19005B;
	Thu, 29 Aug 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941010; cv=fail; b=uWh0IGbWKJZzw8KnNmTODgbit33RHuD/qoFjb6Vh0iU4RvW76F2jeeaby4GhGUrYPqCxhZZEngMa/ZU7nycqohKyeuwhGjSpFJxoxEB29te8bMjk3/IPFhE9yOKIUOeEKsk7JHXBvTRkQWwD8MSJMpu1l58iCJdLaNomDol3Ij4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941010; c=relaxed/simple;
	bh=X8pqS9mXEjiBvElklt0uX6iF9A+3Lip1MAJFQDTtkbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/Ckvly1XpCm03mhNM+uQbNPOdpYiKxoDytq9Ode1M/40qIcms4NGGbLyE5sNNpXh12fpZ9cccoDdFEPrZvcseKyayYjYS4BiCcIo++yRg2xwmwikoZE8ozuI/jMwiSpc+zB+lachEys+kLbh91DQeLdpaPcVAw/2xOYhxS+VhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j+m2zrs8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CuGOssQq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TC6AoV030195;
	Thu, 29 Aug 2024 14:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=X8pqS9mXEjiBvElklt0uX6iF9A+3Lip1MAJFQDTtk
	bk=; b=j+m2zrs8K+OjCzKnZmv9w71nu+McmYbe+Zi+qlZF2qBMtUqqHXVOLtZ30
	B56cXtCiXgSlbnQBXrW7OAoqiLmPzlGJnnwPbM2GriSdjWWMHAGZMGHJSTfGzpeG
	hOnRw4WJVVyV/IZbtHuALSwYpPdWGBWrm1uOseZKWkr+Ggbf9uT2fwEW7mDYhFEH
	UOnA5CZt2+dl1XJ0NsN1OrxOEtWtvT6ZL/Ai2stZfXHTbO2FZLebwKiCZ1bS1GA+
	Bxsfi/V+O3v/4dkmQXpU252ulqPDVK7LdoNT+JFW0V4N7IgoI5uBBPX+gSltm/wT
	h0czCoNJnal7eqUE0u+C9bfNcF4dA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pup4eap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:16:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TDcZWm034741;
	Thu, 29 Aug 2024 14:16:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sw1xmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDiPE4nkeFWhO4h2KkXe9Emr8iUkCo/kowB2T8znRIi6Jqub/RneSnQfNwpZQ0Z7fQXtB7CrkVVq7GLuu9A4GdFyAIAoyqRnlDF6lhQgF9o7Y0eZSsuVPY0qL5zIDVzhAZhbFpshQB14BLRVPxUTESmM57XFafD5XoBqma8d60cacdB5Xgh1TCm0HO6Fi7MtVwv1wc8Wy3MyjQPnbObZQh8AMYaquF6Cs1hap1y7mQug8s1nApEG4OWUtpC5Oc/8Dt9dg78QVYHnX107Y3VxGv2QMZtrXf8rs0vUgF+bqEQ++mJ44Gzu2I0EGNxZM7Jp4fOCMLh5GBPMBWZaF/IXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8pqS9mXEjiBvElklt0uX6iF9A+3Lip1MAJFQDTtkbk=;
 b=EmliXrzvCSY+NOuzs1z8echo+cefBy/4lIexIqPPnPhq8SSePUUPVjphW8A3q1usvjWwGZCfT/1M6vbe1fdSynJRLeMaU7FR8hiY6/rUWh0pPqoQxdnEzVHukfS3FnTHAIxbnR4P2GxfPbpDbsetyg1XbcanKnaAluj4v9si9a+Pf57wQKrlmCEdgcbwWh8BGOUXVZ6oRx5wGF+DgkdzF9jMF+K98Xj05VXfDOU6h+boy4a1b9WNMAkdZTwEda7r4Yaqs/u8jgavbFj95Z6cXNTgmiMVg/awPCh+c6rWJy1oZ9+F6bZsggUXs9WT9H4X/x1nuWOrIqlmDsNsLgn1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8pqS9mXEjiBvElklt0uX6iF9A+3Lip1MAJFQDTtkbk=;
 b=CuGOssQqJhAm6UAXMVF5kOpKkmR4TFr7qtpk1U8eHqeqj9uk5ea+PyrOVMddApjvR2i6HU7UcUe/5EIUNMRNxSka/EQQXmYt/yeAsIklip3v9WxUkldPBUsnWzQOIsIcOWFfgAoOX6Ycu7JegZK0NVvRTOzsOCpjtaoZKeP64z0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 14:16:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 14:16:30 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Paul Moore <paul@paul-moore.com>
CC: Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley
	<stephen.smalley.work@gmail.com>,
        "casey@schaufler-ca.com"
	<casey@schaufler-ca.com>,
        "marek.gresko@protonmail.com"
	<marek.gresko@protonmail.com>,
        "selinux@vger.kernel.org"
	<selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] selinux,smack: don't bypass permissions check in
 inode_setsecctx hook
Thread-Topic: [PATCH 1/1] selinux,smack: don't bypass permissions check in
 inode_setsecctx hook
Thread-Index: AQHa+YO+FiYn2JkgXUygpbjdsmqOW7I9KPKAgAAlmACAAPp4AA==
Date: Thu, 29 Aug 2024 14:16:30 +0000
Message-ID: <288CD342-1534-4FF3-9B2D-7E824FF4AA20@oracle.com>
References: <20240828195129.223395-1-smayhew@redhat.com>
 <20240828195129.223395-2-smayhew@redhat.com>
 <CAHC9VhTCpm0=QrvBq_rHaRXNqu7iRcW7kqxjL8Jq9g=ZypfzsQ@mail.gmail.com>
 <CAHC9VhS3yhOxZYD1gZ-HF5XkGq0Qr8h4n+XrttUBsHL4cg0Xww@mail.gmail.com>
In-Reply-To:
 <CAHC9VhS3yhOxZYD1gZ-HF5XkGq0Qr8h4n+XrttUBsHL4cg0Xww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7336:EE_
x-ms-office365-filtering-correlation-id: 147f88d7-f26d-405c-5bb7-08dcc8352db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFhyZis5VTViRVdqTGpyUzEvd1pMWEZzZVJYc1lzSW9MOGxFeStYcTZuS2Rj?=
 =?utf-8?B?UW9rRHlRalZESFRwanJzYVZNS2xXWVozTTZFR0NHNEYzaVhGUnlaVFgvZC83?=
 =?utf-8?B?T2Zxc0dJV2xXQlF5OTlWL2hOeUVDSVppSWhpQ3BJelZ4WGNaSi93V2dHZjl0?=
 =?utf-8?B?NnJjTUlyODVRbGNRVnBlaTNGenpqUjJJL3pwb3pvWUpPOHVSN1cvWmEyN0dF?=
 =?utf-8?B?OEhES3lsUWJYZHVab0dDMkZ2R05rdnV5TEdKdlBNcjFmblhRZlVvY1FXOUQ2?=
 =?utf-8?B?WnJVZ01yam5HZ2tSakVHOTdabkN5UHNEZFdNWW85dWl4RnNqSkVJaWI1QTJt?=
 =?utf-8?B?elVxRE9qZHBPK0xHbzJ0bUxXUVQ4UTNsQmJXTGhpVXRVUGRrZW9nUGhVMTBH?=
 =?utf-8?B?UThKUDQwUlMvVVEvcnMzUjFNWFBpd09FTkdVVnMyc0NwbS9Da3RXUHUyWmox?=
 =?utf-8?B?L1ZYaFNIZCtMZDBueFh4eGE2WVA3UEhScENML1JoWUozSjBzc3hUV1VRZUlv?=
 =?utf-8?B?WjBpcCtMS0F3NUY3YnJ0UVNNRW1NVS9vd00vTFFYcDV3RDd2QmplemFPNUJ4?=
 =?utf-8?B?ZW12VGxHc3JMYitDU2M4RWlQeDd5QkppTUlqSG1NUWN4cU1ZdzB3WkI4bHN1?=
 =?utf-8?B?QjNZRGw3aWtGaFNOdHFkcENHdVVlU2ViMER4TmtNR21RN1ZoZ1NUbDN5WkJ3?=
 =?utf-8?B?ejl6NEFkR1VUcnBzUUtQa0M1Uzd2K1hSaDNmNFQxWDBINDFkZEp4Tkw3cGFJ?=
 =?utf-8?B?NU4vSkpjWkxzbnJNNUlCcm9pTFhtTWZua0M4U05vVU1ZaW9BWThVVE52V2ZB?=
 =?utf-8?B?U3lvL3VBUjhhOWFwbEdvSVlkWDM1UUdnYUJ2anZDN050VjNhYWpUblRKT0NO?=
 =?utf-8?B?aXNXcis1a0w0SzF3R01uS25WMW1mVTJrcWdtSTdXL002NitHakRCS2s0M1ZC?=
 =?utf-8?B?TUFlMlc0MlBNQlU3WHY2YTVVZjFzNENUdTltMWZoRkptUGZlc3FVc2hUQVAw?=
 =?utf-8?B?ZytDd296YWd1S0kxSHdNdUtiTkJ3WFFFeDJ0cXBGRXl6RTBKNlpiVUZ6L2wx?=
 =?utf-8?B?UExzN3o4WXZ6aTFxR3NEYVVJUTJuMVdVYU5lZUQ3UXBqYW1ocktGZm5vMU80?=
 =?utf-8?B?YytJMERFdXdoQXdvbU9RaUtrbE9WWjNWSHZYT1F3KzhONmRaWllNeWxlYVFM?=
 =?utf-8?B?OEl1VWViSUNsWVdpTm9wL0QvVUlYN1hpKytsMnIwdE9qQjZHZk5FU1FxR2kv?=
 =?utf-8?B?aVVzMWplNU1uLzVibXpKYyt1a1RNY01QamFOZ1Q3N2Y1NXpYaG5zZnN5MTha?=
 =?utf-8?B?M2Fxd01tVHAvQ2FDT05QQjlQUVlBdE5MTUgvaWc0dXVLUDhUWWx1dmhqQUxH?=
 =?utf-8?B?UWlPdHRrVVZPTm1ZaFExaUQwM2p2MlF0VkNKZXAxTnRWanJEVVBKQkN5YXV5?=
 =?utf-8?B?UXBMQkw1SXdXbXl2Tkh0eGptWGNKdDFxQXhhR3IzNm0rdHJKZzBzcDNybkJD?=
 =?utf-8?B?TzJIUnVQREZQRzI3cmtNT0dOME5EU0JOK1N0UzZKajdGZW5jOFQvb2tVbG1E?=
 =?utf-8?B?RDBPWlRYWk9kaWFiNkZYeXliYXpTTFhSeW5RSWk5UkxkUk1wdVRieExTMk5J?=
 =?utf-8?B?QzVxdlBMUmJCazNNWHk0RFJ6STdYZXhYU0QrZnBGLzBQUjFnYUY1emxHNEVR?=
 =?utf-8?B?K1dCMjNXTThBbkdWS1VkYXA2ZUhLVWVrQlBza25SV1R6ZzhWYkRjemN4RnhX?=
 =?utf-8?B?djBVUDNxYUM5a3I4QVNvUmZzVkp2Wm1EYUlucUpPbmFtSE9DSGIzRmt2N1pT?=
 =?utf-8?B?SHoxRElnOWpkREE2bGpENGkybHFLSnJFeDhpUStZVjNLMlFCNzNRUjF4ZmVW?=
 =?utf-8?B?RHUwaFRxbFlJVndmMy9rTGVLS3pjcllkbXY1SzJweXhJMkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vi9KYncwc0c3MkVkYmxiWGgwL1QzQUpENHMrMjBJQlhMVWVPREIxYlkzZzBr?=
 =?utf-8?B?SHc4eEZPeUwwck8xeEduUmExaWVsUnBtTURQNmpNNjNRcERPbnlGRFo2eHJV?=
 =?utf-8?B?Sm1XcVZ0QmI0OGJ3WGc2TUIwai84VUpaSVZ6bGdNNFFnVnVoc0NibmtxNjIz?=
 =?utf-8?B?WWphR093ZCt2V2E5Ync1VU90b0RhVnJHZUcxeWdHN215UTRpTFFwRFViTHM2?=
 =?utf-8?B?bmxqODdYQ1BRM1FEN2JuWi9hSEg4YnUyZUJOR2h0RE0wa09TUURrb2RsSlVB?=
 =?utf-8?B?VzB6a3Y1akV2NWhnVGY2MEhQZVRlUnE4TUxqZWpMMUJaZDlqWEpPZnMwK0cv?=
 =?utf-8?B?UklRLzk0K1AwUlFBS2tqUG5sWnl3TXcyU0xzU3d1WGtkMm9sazFDRGtpMndH?=
 =?utf-8?B?WklUVFZGazBaTktUY1lwb3ZBbzg0amNuUk5JTTdvS28yRFRTV1ZDSEgwZ1FO?=
 =?utf-8?B?L0M0eHQ0ZGdIM1dzZENid2hrNEI1QXJRL1hEWTJjME11YWN1Qk5PSVo5RC90?=
 =?utf-8?B?eDZycDNNeGZRbFhiL2x1MG1vNTJLZzU3U0tCZzRTWmo0dzhxWnB4Zm5CaWhq?=
 =?utf-8?B?ejJGYldENG9lbFZzTEQxNk9aQkU3bWlQcjE4NkZ0R1BHc2hqQ0FLWWE4My83?=
 =?utf-8?B?eFpYUDlVR3lZbW8yaEp4WUJWUGp4TnZXZSs3c3ptWkFGR3FkV1JoTEdDVmxJ?=
 =?utf-8?B?ZnREZ3pYaEVReDZFblVWdFRTeFJFRU1zc1dkdE9BQ2Y1Sk9Gem9yazF1MUcv?=
 =?utf-8?B?QXJNVFhxQWkvN0RaRlhhY0JrcVdBZUlwdCtkK1JCUTFGVi9IT3o2cFB6RUh4?=
 =?utf-8?B?cjIyQzFCOVZ1eXM1SVN3NnkwWG5xZXBOZVhaNlkzaHFlUitoZnVOclpuajQv?=
 =?utf-8?B?WHNpemJKQzJqL1Mzbjh0L25ER1hoeVlvOHFhekJwekwxWFN4U1VqVks1TkN3?=
 =?utf-8?B?S2dCaVk1OTBHSlNSOGJxUWl2VVFsWXRjK2d4ZFdDemw2WkwvaTFrYkVzMWVU?=
 =?utf-8?B?V2UzakFpSURQN3FtaFhJNjVidEdOZ2NtZ1ErM2V4SXJHWS9aZW16TkJ2VG1R?=
 =?utf-8?B?NjZ3V000bnVuQ3hQU2dFZGEwTGd0Q21kVjhzUkJXRTJ2WTlqTksrSDlPU3Mr?=
 =?utf-8?B?TmlNUERPUVNMS0JvalVaNHVKekI2SkFVM0ROVFFGb0tEVmVTOVBPV3ZjbDUx?=
 =?utf-8?B?ejl4b0pEQTdpaXBnUGdrOW1zOVJuN1prWmZBOVJzZ2UzU2NKV2Z0UFlNN3ll?=
 =?utf-8?B?aUFqN3pXMGpLekw0TjdpelFFQWNhR05ONExkWlIxU0VkbEtqU2l5Q090ZFha?=
 =?utf-8?B?VUY5TjFzd0JLWmszNnlRbTJidjUyeXhheXNRZ2Q2RW1ManpWeEdOMEUyREl1?=
 =?utf-8?B?Zy9LVy96TnR2cmVKcWUwTjg5SlovckJMcUx2dzFab2RjNEUyZnRQaGlJRHp6?=
 =?utf-8?B?ZVBDWmFYT1NsYktZSUtlUGpQNEpLUjZwK0Y4S3VFN2ZqSWtzOXBRNmEvaTc1?=
 =?utf-8?B?MmYrS3RLd2M4RkVYYUhzb1dMaEV3NjBhUFQ4bUVWMGxFekRBc3FBc3hXSzB6?=
 =?utf-8?B?R1piYW5YY2lCaitmdzNRQWJtd1NxdzlUb1Z0cGZteFdUc2trUUM5Wmo0ZlJZ?=
 =?utf-8?B?aTVCSXY0QkJ1SE5Gb0xacGhsQzlrSWZnQXFoV1dyZitXdDFEWEVvM1BzL2lR?=
 =?utf-8?B?M216U1E1R1BaNDZUd0tlUHJrNU5oVkRCMVRsWFhjenNtVVZhcFF5SHR1OHFa?=
 =?utf-8?B?ejlwOEsxdHhPNDhDUGVWN1F5NjB5QkFmbHdkanZ0Z2kyQTVJQjlHRWRrL01Z?=
 =?utf-8?B?aWhJUXlZd2hqbHZBSGh2d3gvNW93L0lqd2NYUUVTaFhpazVld1NQN2NpTkRS?=
 =?utf-8?B?T3VRRTROWm5ZWHM1Zm1KZTh5L04zNVNEQzNNVDNmYXppUFAwQ1FIVXMrTEFo?=
 =?utf-8?B?Y0Z3R1ZUSnZ0Yk44YUUza3NWSFFyTndaVDA5ekZoQ2lSOTFrUlQ3blVabm5v?=
 =?utf-8?B?aWRRYkRrSDR6STI5dWxPT0ROeHF1TGZMZVBKRFJPc3g3TXFDN2R4YlpuYTJL?=
 =?utf-8?B?empna3Q3ZUpEeXpUdkxObi93NnFoVzBpaWFPOWsxR2h4UGUzWUlzUXM0elIv?=
 =?utf-8?B?VXNHSksyUTJkdzdUWS9zNjliMFBFVXIxLzl3VkZTdDJ1Q2VieHZuR1BRT29a?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <440567C7018ED84EB3BA9B3BBB9D46F9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yfHs9pQIRDZg6pvOGgpGgHat98e6PbACovAYIuX/DkdPUDbLDZYthT34WgMeHVrLNqQLpmu+OJ+QuQcOXXtUNHe+4eFFCy803fh8TPg7SEeTHwEDyYJRllHMSvyW70x2wjRr3cxHFr9IQ4FDPdeXJXB2l6k4uLAsnBO8cjFdX4FRqFbu5zHUscyrYsODgPYoJJxhR+eNToQnqf6vNrssyjkhld5hKTqhzq55dt8KjIkUTXXLG2fOtZshF418Z45ZJ2He4qFT21fdR5hFT/bFLSqB7W/0aglnGgTL1J6/6pV/Wbz37QTAgCVF/vUR4rQLgrpIkzjiUUL8kCUA9+cvp3Nrpg/J7uadsXIzOPAYCgR18mPWHMiBH/JtABOaWhLoBxe3NjrUMK9dhYRlucQB/3eFKWKDJaNEyer3+pwmbZvTkeb2LA2ggzIGiBCK9hoUeSdzbxLo+6X7yBW7KJhnvyc7Pz+gYrNMVkRxVKfGwV/ezuNAJ32kzJqVHTwpW55T2v1IpaKNReZom74tEzXGHJhzS83MJRQJJWFrrRKjIzKZOGEjrm1Fs0M4S/X2oZ8qEKE+H4EtrKFc3/rGlU/nliZtC3QfpHYTlTd8emHGgow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147f88d7-f26d-405c-5bb7-08dcc8352db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 14:16:30.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BsGbRp22PAb0Er3mn1RbXWw44gv5IgpGEVYIG8YXbpFqZPO/G05NBGw6ALDRDKzS6txHTIpw5a/5cHwSnjGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290098
X-Proofpoint-ORIG-GUID: GXi16zoE2GiNww4VDU13GGiR4O7AFX1s
X-Proofpoint-GUID: GXi16zoE2GiNww4VDU13GGiR4O7AFX1s

DQoNCj4gT24gQXVnIDI4LCAyMDI0LCBhdCA3OjE54oCvUE0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1
bC1tb29yZS5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBBdWcgMjgsIDIwMjQgYXQgNTowNeKA
r1BNIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+IHdyb3RlOg0KPj4gT24gV2VkLCBB
dWcgMjgsIDIwMjQgYXQgMzo1MeKAr1BNIFNjb3R0IE1heWhldyA8c21heWhld0ByZWRoYXQuY29t
PiB3cm90ZToNCj4+PiANCj4+PiBNYXJlayBHcmVza28gcmVwb3J0cyB0aGF0IHRoZSByb290IHVz
ZXIgb24gYW4gTkZTIGNsaWVudCBpcyBhYmxlIHRvDQo+Pj4gY2hhbmdlIHRoZSBzZWN1cml0eSBs
YWJlbHMgb24gZmlsZXMgb24gYW4gTkZTIGZpbGVzeXN0ZW0gdGhhdCBpcw0KPj4+IGV4cG9ydGVk
IHdpdGggcm9vdCBzcXVhc2hpbmcgZW5hYmxlZC4NCj4+PiANCj4+PiBUaGUgZW5kIG9mIHRoZSBr
ZXJuZWxkb2MgY29tbWVudCBmb3IgX192ZnNfc2V0eGF0dHJfbm9wZXJtKCkgc3RhdGVzOg0KPj4+
IA0KPj4+ICogIFRoaXMgZnVuY3Rpb24gcmVxdWlyZXMgdGhlIGNhbGxlciB0byBsb2NrIHRoZSBp
bm9kZSdzIGlfbXV0ZXggYmVmb3JlIGl0DQo+Pj4gKiAgaXMgZXhlY3V0ZWQuIEl0IGFsc28gYXNz
dW1lcyB0aGF0IHRoZSBjYWxsZXIgd2lsbCBtYWtlIHRoZSBhcHByb3ByaWF0ZQ0KPj4+ICogIHBl
cm1pc3Npb24gY2hlY2tzLg0KPj4+IA0KPj4+IG5mc2Rfc2V0YXR0cigpIGRvZXMgZG8gcGVybWlz
c2lvbnMgY2hlY2tpbmcgdmlhIGZoX3ZlcmlmeSgpIGFuZA0KPj4+IG5mc2RfcGVybWlzc2lvbigp
LCBidXQgdGhvc2UgZG9uJ3QgZG8gYWxsIHRoZSBzYW1lIHBlcm1pc3Npb25zIGNoZWNrcw0KPj4+
IHRoYXQgYXJlIGRvbmUgYnkgc2VjdXJpdHlfaW5vZGVfc2V0eGF0dHIoKSBhbmQgaXRzIHJlbGF0
ZWQgTFNNIGhvb2tzIGRvLg0KPj4+IA0KPj4+IFNpbmNlIG5mc2Rfc2V0YXR0cigpIGlzIHRoZSBv
bmx5IGNvbnN1bWVyIG9mIHNlY3VyaXR5X2lub2RlX3NldHNlY2N0eCgpLA0KPj4+IHNpbXBsZXN0
IHNvbHV0aW9uIGFwcGVhcnMgdG8gYmUgdG8gcmVwbGFjZSB0aGUgY2FsbCB0bw0KPj4+IF9fdmZz
X3NldHhhdHRyX25vcGVybSgpIHdpdGggYSBjYWxsIHRvIF9fdmZzX3NldHhhdHRyX2xvY2tlZCgp
LiAgVGhpcw0KPj4+IGZpeGVzIHRoZSBhYm92ZSBpc3N1ZSBhbmQgaGFzIHRoZSBhZGRlZCBiZW5l
Zml0IG9mIGNhdXNpbmcgbmZzZCB0bw0KPj4+IHJlY2FsbCBjb25mbGljdGluZyBkZWxlZ2F0aW9u
cyBvbiBhIGZpbGUgd2hlbiBhIGNsaWVudCB0cmllcyB0byBjaGFuZ2UNCj4+PiBpdHMgc2VjdXJp
dHkgbGFiZWwuDQo+Pj4gDQo+Pj4gUmVwb3J0ZWQtYnk6IE1hcmVrIEdyZXNrbyA8bWFyZWsuZ3Jl
c2tvQHByb3Rvbm1haWwuY29tPg0KPj4+IExpbms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9y
Zy9zaG93X2J1Zy5jZ2k/aWQ9MjE4ODA5DQo+Pj4gU2lnbmVkLW9mZi1ieTogU2NvdHQgTWF5aGV3
IDxzbWF5aGV3QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gc2VjdXJpdHkvc2VsaW51eC9ob29r
cy5jICAgfCA0ICsrLS0NCj4+PiBzZWN1cml0eS9zbWFjay9zbWFja19sc20uYyB8IDQgKystLQ0K
Pj4+IDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4g
DQo+PiBUaGFua3MgU2NvdHQsIHRoaXMgbG9va3MgZ29vZCB0byBtZSwgYnV0IHNpbmNlIGl0IHRv
dWNoZXMgU21hY2sgdG9vDQo+PiBJJ2QgYWxzbyBsaWtlIHRvIGdldCBDYXNleSdzIEFDSyBvbiB0
aGlzIHBhdGNoOyBpZiBmb3Igc29tZSByZWFzb24gd2UNCj4+IGRvbid0IGhlYXIgZnJvbSBDYXNl
eSBhZnRlciBhIGJpdCBJJ2xsIGdvIGFoZWFkIGFuZCBtZXJnZSBpdC4NCj4+IFNwZWFraW5nIG9m
IG1lcmdpbmcsIHNpbmNlIHRoaXMgdG91Y2hlcyBib3RoIFNFTGludXggYW5kIFNtYWNrIEknbGwN
Cj4+IGxpa2VseSBwdWxsIHRoaXMgaW4gdmlhIHRoZSBMU00gdHJlZSwgd2l0aCBhIG1hcmtpbmcg
Zm9yIHRoZSBzdGFibGUNCj4+IGtlcm5lbHMsIGlmIGFueW9uZSBoYXMgYW55IG9iamVjdGlvbnMg
dG8gdGhhdCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+IA0KPiBNZXJnZWQgaW50byBsc20vc3RhYmxl
LTYuMTEgc28gd2UgY2FuIGdldCB0aGlzIGludG8gbGludXgtbmV4dCBhbmQgdGhlDQo+IGF1dG9t
YXRlZCBTRUxpbnV4IHRlc3RpbmcsIGFzc3VtaW5nIGFsbCBnb2VzIHdlJ2xsIEknbGwgc2VuZCB0
aGlzIHVwDQo+IHRvIExpbnVzIGxhdGVyIHRoaXMgd2Vlay4gIFRoYW5rcyBhbGwhDQoNClBhdWws
IG1heSBJIHJlY29tbWVuZCBhZGRpbmcgQ2M6IHN0YWJsZSBvbmNlIHlvdXIgdGVzdGluZyBwYXNz
ZXM/DQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

