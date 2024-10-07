Return-Path: <linux-nfs+bounces-6910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3B993202
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 17:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D3C2822A8
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4E71D7E25;
	Mon,  7 Oct 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f7x/VtuT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cqwSg86C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C91EB25;
	Mon,  7 Oct 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316252; cv=fail; b=r4ArNj+nCxvQo6MVlfAn+fbqXmDXWOwbLkkBYxH7jub4ohs6ySMohIYxxgK0m1hxcQCHN236SxmyGIWjs/7JAsTZPit7/ENpfjow3JFrE+Gap2wpWUogR3BtmkfzlMFBIvrRgW/p9XNTzHOc94CPVKhhUStZ2KbE9B0smVJxqZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316252; c=relaxed/simple;
	bh=Oru0vkVBsdL86icT8837DlV4xiAYtbVfLHrz0CvnP6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u2x35u/1GpqMlsbFK+0vRFBXnWJ3XhZktZw2gpxDKpXmWaW7wRdNH/IKnh23EmUOAK6ShNA95V5soojzSCH/Gq89kraAdDZ0yT52+fR4h81cVoy+6ANlcmAd9L8UwcfvB6S8kv68T0TeAe9BsNjG8hx7QV+elf1yzwYN7rQbXvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f7x/VtuT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cqwSg86C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMer4022302;
	Mon, 7 Oct 2024 15:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Oru0vkVBsdL86icT8837DlV4xiAYtbVfLHrz0CvnP6U=; b=
	f7x/VtuTHgH750B4rfW5UAeXQuHz3bkPGeoEzAgOYu6HN5mVyCoIU8s9u5j/79nz
	ccyv8jA+mnt33KKMxLR45DQbe5VlbLSfXVym0UPQFEvQszw0j7zvuPtfPupWVwGw
	MSg+77xWAzS5ZeqqhNyHGX34ClwDxvYp1oWiPJv7XHeoRXXcDKckDgtvcyCxWYbn
	baMInnWwNPcFO98bQY7lreT//Al+7PderalydQeR1NRU8DL7Fr2kIGC9VFUZbhzR
	8Y8dNeld3lYHekkg2uVDshCjeg2X4C3NQ58tB0oI8uYjriy56+7q03ELmBIYV+wm
	1okgr4/0TIK7FKCuXxSTJg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034kv3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 15:50:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497Ek5VO012643;
	Mon, 7 Oct 2024 15:50:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw5yqw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 15:50:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbQK99KlrlGlsefC0R/AF7f2ttrFC8HEWmfTdpi28DP4GoL7qmskxeAdD78ei17526R+C9BoOmofQEPXwXtS+7tvGxKCg50QU1QSoxfDgak8FInQhS+X1xpYySfzI2tRy/zVWAck7PVJfOTYrWMyRB4BXN9DAngP7t+Zdggrthj4GL1qyj/bLN9rkwmIAIeGkzji2/HVu0IzAVdX1FH422hTPWHAxKxrmCgcU18gDLWkLA7T1SNosy3yhn36RJavWSFpxe6STj5DmAJUvH/SYEWZuvYxep/HK0Uo+Ygfx1Z+UAavOLe39SuLckJymyIc7H3bIyl+BHnpsdXh39cWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oru0vkVBsdL86icT8837DlV4xiAYtbVfLHrz0CvnP6U=;
 b=VkZcgw51CrZfVxYfwtkYfZjt5Vk8ZD4jJVTQsXh46sa11vJt83LZDCrU6N8skZ2rUrQp2+y+7fEcwbq2T3x8cScIhB1R02aSgvXlgVOEtZkgEB/DgQLMlqf/WOzHuDJp/hNHds4gxq1udYIv+tn5qrtzBeF4k+sV4h7tEtXt8E6+GwztnHqdorE4Ns3YUTLkmVrdJaxbNBCdMpd5DYtLBMbUzKrJxypn+vQYAEQ3GIQU2ewcG4i4c2RLKXnvKSKph0vtYdvu8bfxLXftDc5jw83f0LBEjs/Yf+bw6t48CeQ5OdjlNEcvjtIX8pawOnj2aPMHvTbSUd8EgGaPHrSZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oru0vkVBsdL86icT8837DlV4xiAYtbVfLHrz0CvnP6U=;
 b=cqwSg86CdL1WT8cBxd/+sWC0mYw16A4RUX5ItSfYog24IMI/S6FkLC2fu1AVkWp/aGl13+THTZVj0AGQIoZAyMw+eh30S9x91elLAlf53Z0frMMBoyCV9xLSEIgnpOli9xBaxBSz5MKD22ILiZ+ca86yvYn5m7TaeAdRR/c35pE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SN4PR10MB5592.namprd10.prod.outlook.com (2603:10b6:806:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 15:50:35 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:50:35 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Thread-Topic: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Thread-Index:
 AQHbBWH4I3P32Fqeh0Sy+qADx3c2LLJUwhQAgCVjo4CAAElogIAABHoAgAAIIwCAAAqRgIABEC0A
Date: Mon, 7 Oct 2024 15:50:35 +0000
Message-ID: <A247373D-46F3-46F1-8C8C-996A95B1A49B@oracle.com>
References: <EEC2DC14-EBE9-4F41-9BBE-47F9DDD110C7@oracle.com>
 <172825777599.1692160.7897699757454912990@noble.neil.brown.name>
In-Reply-To: <172825777599.1692160.7897699757454912990@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|SN4PR10MB5592:EE_
x-ms-office365-filtering-correlation-id: aae2b03e-be86-4fc9-82e0-08dce6e7c89a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?akd2eUwwRFZoaU5qZ3lua052clprdG5wZllGRWdMWDVYVWZ1YXhQZXdLdjBG?=
 =?utf-8?B?TDcyeDR6Q0doTitnMDM3YWJMOWo3amFpbU5jN0huOWVkNkcrR1IrckdiN1BI?=
 =?utf-8?B?Z0FCKzB5SjIxaDdxWFExeWhMZHJkbnhVaVAzSkdoKzMzQ1U3TDZVTFNpelVM?=
 =?utf-8?B?QnFCcVZIbG1BNmk1UzJvb2hGdWhKSnUvYW93S0VRU0JBc3Z1VlpTSllndGJH?=
 =?utf-8?B?RGQ3L0QzSnZWWlgyd0I1V3RYQ3Z2enRSS0RqQyt2aW9hcHZVbkJJeksyN05V?=
 =?utf-8?B?dzZsd3VzRUhtd21sYmd2OFNiRGZ6VWEvRTd5R1Q2QXU1U21QZXJJVW5iS0xn?=
 =?utf-8?B?TEgvdDhwUXFjY1RZYXA4a1lpcUc5VXBIY21EVkF4Q3QzMXNMK0g3SUFKY1Qw?=
 =?utf-8?B?Z3VlYXJHc2gycStOaEREZjNRandYbjRFOExZUE9kbW5lVE9ITmVkRmlzOERm?=
 =?utf-8?B?NUpZS2RjQXVza1J0cjFpVHd3WHBGU1ZpejhmT28rVFp5dzRMT2t3cXZ5cjR3?=
 =?utf-8?B?ditZMVRnMlFUSFNuUmlUdkszWFphcXJDZkFzd3dQV2pSNjluUGExVmpHaUs3?=
 =?utf-8?B?OStZY2djcU5hR1RuNWd1blRCOXJueTZ4ZmR0eDB4V1ErUXl6VnBZQ09rQVFI?=
 =?utf-8?B?dkc2VUw4eUVKNDU2NnVNNXhiK0svdVI5N0NnU1FpajdxNjFrY3djNW8ydGk0?=
 =?utf-8?B?cFNQbG8vaXRuUjlDczliL2M1UFFlcFhCcmM5N2hhV0gxcmVVZnJmY0czRFJE?=
 =?utf-8?B?bTNYSm1WaUZlN3c0L29BRnhhTkxURU15Z1VYbGtkcnMwN1lFQy94clhEbllQ?=
 =?utf-8?B?MmRacG94UzJyRnFKNzRvaVZqUXdpOUdNUWdFQmRZZG9RR1JITFJBbDdpakFx?=
 =?utf-8?B?UExVNjJVSDIwb3kzNldVK3gxNk9XdHNQazlGU0FMczg0NHRjVjZPS00vZS81?=
 =?utf-8?B?N3VpUENOVzlueWJqRXh1K2Q1TmhQMmV6b3VnRGNKbjRubjZzNUF3WmxRaE84?=
 =?utf-8?B?Q1drMDRCdzBOTG9kWGNHcVRMdFNKcXIySjZkMDA5ZC9tT2NuZGJSQVVtSXdn?=
 =?utf-8?B?ekVQaWpncXhwUkdCaVA5UlZRQzVVb0x0dGtLUUJUQnluYkU5clVaVyt1M1R3?=
 =?utf-8?B?akhvK2o4dVgxVjNZQjFONE9IVUFvMGNCbVFxOGZ3S1AxL0ZabUR1V1lyRmpj?=
 =?utf-8?B?WlVpcmo3MWo0OGptSkJYSS9jbStRT1FmRUxqUHM3b21ndHQ0Zjhkc0Zydi9B?=
 =?utf-8?B?emZET0o1NDFOTExmQk9FdHdDak1TbGZRWVZJZDNGVlN5WXZLeHlVUWVXalYy?=
 =?utf-8?B?c0l1MEkrZVcxam9HM2kra3IzUWJLK0JIcnA3WUZFUk1RdzJzYlM2NlgrU2Qy?=
 =?utf-8?B?ZXVkMkJxTUE0dmRyYXZBWXpCMkZsVnEvWWRJeDZ2QW5HdGZOVHV2Y1EyVzlo?=
 =?utf-8?B?akxmalZFNm9DTUFFUnpBQzlXZ0ZSY0d6SzV3Z1JwbUxzblA3SURHcVU1bmdy?=
 =?utf-8?B?cUhzMUE5dVRLU1ljdWxua3NtMFl2ekhOZHpKckUwSUhudGZtZ0V4dURkODVG?=
 =?utf-8?B?aGVFZTBFSlp6WnhoOWhNdU95MjJBN0o0dEg0UEw1MkNXR3E2R3U5ZWczR1F6?=
 =?utf-8?B?RnpmNUxGVHYrTUY3Y1JlaERWOFU2TUh5UEFhSGErRmsrSExQLzkvcU5zT0pL?=
 =?utf-8?B?L3d3OXdEaUtnVFI3TnowQmR1S0lLTmtnMjdaYXc3QkZxdjM3WlpMVDdRcG1V?=
 =?utf-8?B?TUJGR29VdjhsL1ZKQWREWWtGSVQzU20wc2xKakZlaUIrMThaOFRCMTlDYXlv?=
 =?utf-8?B?N1NneUR0amZSTFRneGNuZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWozYmNxaEZ0dEFzaEgwaWl2MVpQMU9zYVRYL0dxOGxkcmlCOEs4ZElrNU9H?=
 =?utf-8?B?TWFSdWVRclFVei9mYVBHMnVjVlNKaCtURVR5V29GWVQ2MzU2bEpPMUU4VnRw?=
 =?utf-8?B?cHdzU0hVTGNMOXVUcExxOFVBcG8yQy9ZNlplUjhGczkyYlovQzFZdHRTZ0VU?=
 =?utf-8?B?RmtzRWFUR0lnd3dpYjlOUnFwT2hxVlNMWStiSVRlcVExekVLSWdmRGVsREVr?=
 =?utf-8?B?N0hwVXRYMWRESFA2WTBnMDcvQXVZVyttbzBJQmdvcmhvZkZVd1lQZndIeHVn?=
 =?utf-8?B?KzdxeTIvRUtveUZ1emF1WFlST0NMWjh2cno1UStHL2dvdGZaVmlReU9uY0NL?=
 =?utf-8?B?cElNMk51WVhaWnNFV0ZRZVZ5TUFUT0EzSTRlM2Zyc25XbE1qVCtGeXRGOWRq?=
 =?utf-8?B?WEJBWFpMQnpPZGR5WGwvTlpwNUJrWW9HYUYzL1JkeW9tMlVZM3RaU3BsRFkw?=
 =?utf-8?B?cHNYeUJqb0I1N2dOL3FmSVoxbXlkZHVTbmhzVDJ0Uk5QOEVINks3N2dTSWdJ?=
 =?utf-8?B?R0cxazhtVG1FRGxkUWtnMU1kZ3paSEY2d2YrZGNFTVRTSzlLTVMrSVZvUVNw?=
 =?utf-8?B?TkRJUUJCNnh4T1NUNlIvNlg5Q1BVSkhKMG1ZRjFvbm5rUEgybVVnclJnWmd3?=
 =?utf-8?B?Mk1WelVJMXh5STlIYkJJbFNET0N2Wlk1TG9tdGdObGVqSTZ2cTQzWGFtcEhj?=
 =?utf-8?B?MG9NRHZJY2hjY2NtS0lncHQvalMycTRwMTdrQ2FVWCtTNFlnVnhIZ2g2U1Br?=
 =?utf-8?B?V2VJY0lPVUJwcVNDQzF2KzBUbzAyMElnMWZlTm82U005RFM1NmZpUDdkaElJ?=
 =?utf-8?B?cWpKM1R5VW45cXFLQ3g2ZUVFRnhhZ01MRVY3Nk4yOWY4NlJ4ZHhPbUZsK0kv?=
 =?utf-8?B?UmgzME9yMXZrSlhlWC9lNU5WbXpEN3UxcmloVHlsbDkxWG4yTENDVDRrSnM3?=
 =?utf-8?B?c1MrN09kZGdBK0FyK0xmTkJ3T0RPOU85d2xudTFVUlZmZStSeHlYMXBwUWtj?=
 =?utf-8?B?cHZJV3M0cFI1QUJiQXNESHhPeFdQaWtzK2s3NW80a3U1NUU4Zy9RMWFOZXFm?=
 =?utf-8?B?SE5JTFkwYmsrRS80dlRiT1IxQS9sQnQ3QmdOcXFVMFI4dE9zUDFEVmN6VnQv?=
 =?utf-8?B?a3VuMnU0NUpsS2pGMlcxVG5xRFdtdzExZG5OVklXT29INmF6QWFzTUdzNytB?=
 =?utf-8?B?TXBoUml0cEY3OWJuK1ZXVkQ5anlNMUZsb045UDhsaWgyZUFxaVBrL3B1Q045?=
 =?utf-8?B?dk9OU2hPdXhxVGlWUGtQUU8wdUQvSFVNNUJ5cXg1bEhZZDZEZEpSTzJnMm9x?=
 =?utf-8?B?TTh3UnM3aXBuMWdPOE04MlkwS2ZSYWtEYnRpNnh4NjdBaU5wNmloSDBsNjFp?=
 =?utf-8?B?cVJteXlleDlzNlFrTHZEa1BLUjZBbnBrWTRlcjU1cEE2b0lTcTZUMDVEdFF5?=
 =?utf-8?B?TGZxaWpIQmVMR1pwcTUyNVVzdjdlVGllNUtNdDZhNjlKcWRGUVllWExXUmE5?=
 =?utf-8?B?NnMxdDQzV01lM1JIbTdhNGowa0E4YVU2UzFWT211UDJEL3hXOTcwd0NKMnlx?=
 =?utf-8?B?OWNqQkxTUXFNSWY5dWhoYlVCS1daWDBxamRXQnIvcXkzWDFudTVkUWlURkF4?=
 =?utf-8?B?azNUc084WVFqbFZtLzZlRkdzakRNVTVwVXJvNGxGN1lvUi8rT2l4c1JiTStS?=
 =?utf-8?B?N0JDeGFJZGwybEhiRnJiUXhabW8rTHZEbXp6K3laOXNtbUhCSU5BMktucmwx?=
 =?utf-8?B?akpybjYrelU5YlZSV1hUQ2Q1LzA1QnV4c1NXZzA4TWRwQVVYTStaMVFuQ0cw?=
 =?utf-8?B?RlNXQ3F2TWtXQ3krTFE4WUljQzBadXV6aTkwaFlUV25yWUtoM3VENG5TOU8z?=
 =?utf-8?B?ZEdINlpJV2IzSklQcU9JRVJpUXBBV2JGbUZhWGJES0hvdnBRMGtmR2tCeTM1?=
 =?utf-8?B?ZDN3U2pYUHZsdEsyamtGT284VGlsVTdQejRiK2hjSEVCMEtRUWxZeUdpWExs?=
 =?utf-8?B?RGd2eVRNcVRwSDdzS0RWUFNDT1hIUThTdU81anBvSFVmcTVoSWUrMGpVektG?=
 =?utf-8?B?UWdVWHNGMzgzeHBGVmhLNGVQTjVoM1lvYjdEQ281VExHc0U1RFpzR0NDUHFj?=
 =?utf-8?B?dThTTDNia0FIS09QWVRlanEyUDl4cCtkb3FuaDZvNWVMTHB1YjNwOVNzT3VU?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E3FED538B95B74D8450C5AAEF2B3974@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8ElwEJ4bbWQCLFb2geuy+3juLpDvvOmliMkcI35ivDZvWezAIhtDKAXDugxaPi8YfF6jpEyQQ6UCTTiLhDeFI6yjEWGMZI02YHi6GdUkrnqWe3/8GIKwqVLN9kwoarxoTHL92I6+IFP8zuDtCinoRXXJqqVlZHRvz5kXxClIWDo1s6yiovNiD2Bu69UoO4zynkXO3QzLpuhE6wqY7OKcXF+aqFLsu3vrvYhtRtkT5ssyvP8g3V6TZHjGRA21RyJg/d7Up844I8X7caPC46fb/eAjQQ7dGGn+tdfCsUfyja6/N5ydRP7Ny7cWM6eE11TBs0xwWAJ+6ztDBC0jarO8lxts6rtbyN+LLHeE+7SY/IkvRQ5aOdQIh4bWCMZF8QM5TVS3YYF9IGY25RQi3Hm+/XjKn31ihZPn9PjChlPdgnU9QmcPLEmKfQp4skkeRznyqz/fi+x/KskXpq3f68vqRQIOXdd6gP83/ww809I29UdriW308NtmNjhRy2yDjU4ed/HAnvCbMHQVzCb13VUOtjyOnEWCHsc4vMWSTER4uerTx6lAkAxi+o0eL9VOrqd9Q6d0tsDgyArSCSnr0J5BiCRtyjz8qpJfJHeqGGmAm8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae2b03e-be86-4fc9-82e0-08dce6e7c89a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 15:50:35.6665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjtKUBxow9uCgWvdUuR/nVxJcpjwk6m0ZrlnGEsgT1f/Pj49whJYfZzykbcs0ZBSIZ2HMVM48u6FvOnq4eLnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070112
X-Proofpoint-GUID: _BQzkdGs8MMjkaIbBrc5edhQwuNPv_yh
X-Proofpoint-ORIG-GUID: _BQzkdGs8MMjkaIbBrc5edhQwuNPv_yh

DQoNCj4gT24gT2N0IDYsIDIwMjQsIGF0IDc6MzbigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNl
LmRlPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgMDcgT2N0IDIwMjQsIENodWNrIExldmVyIElJSSB3
cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gT2N0IDYsIDIwMjQsIGF0IDY6MjnigK9QTSwgUGFsaSBS
b2jDoXIgPHBhbGlAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gTW9uZGF5IDA3IE9j
dG9iZXIgMjAyNCAwOToxMzoxNyBOZWlsQnJvd24gd3JvdGU6DQo+Pj4+IE9uIE1vbiwgMDcgT2N0
IDIwMjQsIENodWNrIExldmVyIHdyb3RlOg0KPj4+Pj4gT24gRnJpLCBTZXAgMTMsIDIwMjQgYXQg
MDg6NTI6MjBBTSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4+Pj4+IE9uIEZyaSwgMTMgU2Vw
IDIwMjQsIFBhbGkgUm9ow6FyIHdyb3RlOg0KPj4+Pj4+PiBDdXJyZW50bHkgTkZTRF9NQVlfQllQ
QVNTX0dTUyBhbmQgTkZTRF9NQVlfQllQQVNTX0dTU19PTl9ST09UIGRvIG5vdCBieXBhc3MNCj4+
Pj4+Pj4gb25seSBHU1MsIGJ1dCBieXBhc3MgYW55IGF1dGhlbnRpY2F0aW9uIG1ldGhvZC4gVGhp
cyBpcyBwcm9ibGVtIHNwZWNpYWxseQ0KPj4+Pj4+PiBmb3IgTkZTMyBBVVRIX05VTEwtb25seSBl
eHBvcnRzLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gVGhlIHB1cnBvc2Ugb2YgTkZTRF9NQVlfQllQQVNT
X0dTU19PTl9ST09UIGlzIGRlc2NyaWJlZCBpbiBSRkMgMjYyMywNCj4+Pj4+Pj4gc2VjdGlvbiAy
LjMuMiwgdG8gYWxsb3cgbW91bnRpbmcgTkZTMi8zIEdTUy1vbmx5IGV4cG9ydCB3aXRob3V0DQo+
Pj4+Pj4+IGF1dGhlbnRpY2F0aW9uLiBTbyBmZXcgcHJvY2VkdXJlcyB3aGljaCBkbyBub3QgZXhw
b3NlIHNlY3VyaXR5IHJpc2sgdXNlZA0KPj4+Pj4+PiBkdXJpbmcgbW91bnQgdGltZSBjYW4gYmUg
Y2FsbGVkIGFsc28gd2l0aCBBVVRIX05PTkUgb3IgQVVUSF9TWVMsIHRvIGFsbG93DQo+Pj4+Pj4+
IGNsaWVudCBtb3VudCBvcGVyYXRpb24gdG8gZmluaXNoIHN1Y2Nlc3NmdWxseS4NCj4+Pj4+Pj4g
DQo+Pj4+Pj4+IFRoZSBwcm9ibGVtIHdpdGggY3VycmVudCBpbXBsZW1lbnRhdGlvbiBpcyB0aGF0
IGZvciBBVVRIX05VTEwtb25seSBleHBvcnRzLA0KPj4+Pj4+PiB0aGUgTkZTRF9NQVlfQllQQVNT
X0dTU19PTl9ST09UIGlzIGFjdGl2ZSBhbHNvIGZvciBORlMzIEFVVEhfVU5JWCBtb3VudA0KPj4+
Pj4+PiBhdHRlbXB0cyB3aGljaCBjb25mdXNlIE5GUzMgY2xpZW50cywgYW5kIG1ha2UgdGhlbSB0
aGluayB0aGF0IEFVVEhfVU5JWCBpcw0KPj4+Pj4+PiBlbmFibGVkIGFuZCBpcyB3b3JraW5nLiBM
aW51eCBORlMzIGNsaWVudCBuZXZlciBzd2l0Y2hlcyBmcm9tIEFVVEhfVU5JWCB0bw0KPj4+Pj4+
PiBBVVRIX05PTkUgb24gYWN0aXZlIG1vdW50LCB3aGljaCBtYWtlcyB0aGUgbW91bnQgaW5hY2Nl
c3NpYmxlLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gRml4IHRoZSBORlNEX01BWV9CWVBBU1NfR1NTIGFu
ZCBORlNEX01BWV9CWVBBU1NfR1NTX09OX1JPT1QgaW1wbGVtZW50YXRpb24NCj4+Pj4+Pj4gYW5k
IHJlYWxseSBhbGxvdyB0byBieXBhc3Mgb25seSBleHBvcnRzIHdoaWNoIGhhdmUgc29tZSBHU1Mg
YXV0aCBmbGF2b3INCj4+Pj4+Pj4gZW5hYmxlZC4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoZSByZXN1
bHQgd291bGQgYmU6IEZvciBBVVRIX05VTEwtb25seSBleHBvcnQgaWYgY2xpZW50IGF0dGVtcHRz
IHRvIGRvDQo+Pj4+Pj4+IG1vdW50IHdpdGggQVVUSF9VTklYIGZsYXZvciB0aGVuIGl0IHdpbGwg
cmVjZWl2ZSBhY2Nlc3MgZXJyb3JzLCB3aGljaA0KPj4+Pj4+PiBpbnN0cnVjdCBjbGllbnQgdGhh
dCBBVVRIX1VOSVggZmxhdm9yIGlzIG5vdCB1c2FibGUgYW5kIHdpbGwgZWl0aGVyIHRyeQ0KPj4+
Pj4+PiBvdGhlciBhdXRoIGZsYXZvciAoQVVUSF9OVUxMIGlmIGVuYWJsZWQpIG9yIGZhaWxzIG1v
dW50IHByb2NlZHVyZS4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoaXMgc2hvdWxkIGZpeCBwcm9ibGVt
cyB3aXRoIEFVVEhfTlVMTC1vbmx5IG9yIEFVVEhfVU5JWC1vbmx5IGV4cG9ydHMgaWYNCj4+Pj4+
Pj4gY2xpZW50IGF0dGVtcHRzIHRvIG1vdW50IGl0IHdpdGggb3RoZXIgYXV0aCBmbGF2b3IgKGUu
Zy4gd2l0aCBBVVRIX05VTEwgZm9yDQo+Pj4+Pj4+IEFVVEhfVU5JWC1vbmx5IGV4cG9ydCwgb3Ig
d2l0aCBBVVRIX1VOSVggZm9yIEFVVEhfTlVMTC1vbmx5IGV4cG9ydCkuDQo+Pj4+Pj4gDQo+Pj4+
Pj4gVGhlIE1BWV9CWVBBU1NfR1NTIGZsYWcgY3VycmVudGx5IGFsc28gYnlwYXNzZXMgVExTIHJl
c3RyaWN0aW9ucy4gIFdpdGgNCj4+Pj4+PiB5b3VyIGNoYW5nZSBpdCBkb2Vzbid0LiAgSSBkb24n
dCB0aGluayB3ZSB3YW50IHRvIG1ha2UgdGhhdCBjaGFuZ2UuDQo+Pj4+PiANCj4+Pj4+IE5laWws
IEknbSBub3Qgc2VlaW5nIHRoaXMsIEkgbXVzdCBiZSBtaXNzaW5nIHNvbWV0aGluZy4NCj4+Pj4+
IA0KPj4+Pj4gUlBDX0FVVEhfVExTIGlzIHVzZWQgb25seSBvbiBOVUxMIHByb2NlZHVyZXMuDQo+
Pj4+PiANCj4+Pj4+IFRoZSBleHBvcnQncyB4cHJ0c2VjPSBzZXR0aW5nIGRldGVybWluZXMgd2hl
dGhlciBhIFRMUyBzZXNzaW9uIG11c3QNCj4+Pj4+IGJlIHByZXNlbnQgdG8gYWNjZXNzIHRoZSBm
aWxlcyBvbiB0aGUgZXhwb3J0LiBJZiB0aGUgVExTIHNlc3Npb24NCj4+Pj4+IG1lZXRzIHRoZSB4
cHJ0c2VjPSBwb2xpY3ksIHRoZW4gdGhlIG5vcm1hbCB1c2VyIGF1dGhlbnRpY2F0aW9uDQo+Pj4+
PiBzZXR0aW5ncyBhcHBseS4gSW4gb3RoZXIgd29yZHMsIEkgZG9uJ3QgdGhpbmsgZXhlY3V0aW9u
IGdldHMgY2xvc2UNCj4+Pj4+IHRvIGNoZWNrX25mc2RfYWNjZXNzKCkgdW5sZXNzIHRoZSB4cHJ0
c2VjIHBvbGljeSBzZXR0aW5nIGlzIG1ldC4NCj4+Pj4gDQo+Pj4+IGNoZWNrX25mc2RfYWNjZXNz
KCkgaXMgbGl0ZXJhbGx5IHRoZSBPTkxZIHBsYWNlIHRoYXQgLT5leF94cHJ0c2VjX21vZGVzDQo+
Pj4+IGlzIHRlc3RlZCBhbmQgdGhhdCBzZWVtcyB0byBiZSB3aGVyZSB4cHJ0c2VjPSBleHBvcnQg
c2V0dGluZ3MgYXJlIHN0b3JlZC4NCj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IEknbSBub3QgY29udmlu
Y2VkIGNoZWNrX25mc2RfYWNjZXNzKCkgbmVlZHMgdG8gY2FyZSBhYm91dA0KPj4+Pj4gUlBDX0FV
VEhfVExTLiBDYW4geW91IGV4cGFuZCBhIGxpdHRsZSBvbiB5b3VyIGNvbmNlcm4/DQo+Pj4+IA0K
Pj4+PiBQcm9iYWJseSBpdCBkb2Vzbid0IGNhcmUgYWJvdXQgUlBDX0FVVEhfVExTIHdoaWNoIGFz
IHlvdSBzYXkgaXMgb25seQ0KPj4+PiB1c2VkIG9uIE5VTEwgcHJvY2VkdXJlcyB3aGVuIHNldHRp
bmcgdXAgdGhlIFRMUyBjb25uZWN0aW9uLg0KPj4+PiANCj4+Pj4gQnV0IGl0ICpkb2VzKiBjYXJl
IGFib3V0IE5GU19YUFJUU0VDX01UTFMgZXRjLg0KPj4+PiANCj4+Pj4gQnV0IEkgbm93IHNlZSB0
aGF0IFJQQ19BVVRIX1RMUyBpcyBuZXZlciByZXBvcnRlZCBieSBPUF9TRUNJTkZPIGFzIGFuDQo+
Pj4+IGFjY2VwdGFibGUgZmxhdm91ciwgc28gdGhlIGNsaWVudCBjYW5ub3QgZHluYW1pY2FsbHkg
ZGV0ZXJtaW5lIHRoYXQgVExTDQo+Pj4+IGlzIHJlcXVpcmVkLg0KPj4+IA0KPj4+IFdoeSBpcyBu
b3QgUlBDX0FVVEhfVExTIGFubm91bmNlZCBpbiBORlM0IE9QX1NFQ0lORk8/IFNob3VsZCBub3Qg
TkZTNA0KPj4+IE9QX1NFQ0lORk8gcmVwb3J0IGFsbCBwb3NzaWJsZSBhdXRoIG1ldGhvZHMgZm9y
IHBhcnRpY3VsYXIgZmlsZWhhbmRsZT8NCj4+IA0KPj4gU0VDSU5GTyByZXBvcnRzIHVzZXIgYXV0
aGVudGljYXRpb24gZmxhdm9ycyBhbmQgcHNldWRvZmxhdm9ycy4NCj4+IA0KPj4gUlBDX0FVVEhf
VExTIGlzIG5vdCBhIHVzZXIgYXV0aGVudGljYXRpb24gZmxhdm9yLCBpdCBpcyBtZXJlbHkNCj4+
IGEgcXVlcnkgdG8gc2VlIGlmIHRoZSBzZXJ2ZXIgcGVlciBzdXBwb3J0cyBSUEMtd2l0aC1UTFMu
DQo+PiANCj4+IFNvIGZhciB0aGUgbmZzdjQgV0cgaGFzIG5vdCBiZWVuIGFibGUgdG8gY29tZSB0
byBjb25zZW5zdXMNCj4+IGFib3V0IGhvdyBhIHNlcnZlcidzIHRyYW5zcG9ydCBsYXllciBzZWN1
cml0eSBwb2xpY2llcyBzaG91bGQNCj4+IGJlIHJlcG9ydGVkIHRvIGNsaWVudHMuIFRoZXJlIGRv
ZXMgbm90IHNlZW0gdG8gYmUgYSBjbGVhbiB3YXkNCj4+IHRvIGRvIHRoYXQgd2l0aCBleGlzdGlu
ZyBORlN2NCBwcm90b2NvbCBlbGVtZW50cywgc28gYQ0KPj4gcHJvdG9jb2wgZXh0ZW5zaW9uIG1p
Z2h0IGJlIG5lZWRlZC4NCj4gDQo+IEludGVyZXN0aW5nLi4uDQo+IA0KPiBUaGUgZGlzdGluY3Rp
b24gYmV0d2VlbiBSUENfQVVUSF9HU1NfS1JCNUkgYW5kIFJQQ19BVVRIX0dTU19LUkI1UCBpcyBu
b3QNCj4gYWJvdXQgdXNlciBhdXRoZW50aWNhdGlvbiwgaXQgaXMgYWJvdXQgdHJhbnNwb3J0IHBy
aXZhY3kuDQoNClJQQ19BVVRIX0dTU19LUkI1SSBpcyBLZXJiZXJvcyB1c2VyIGF1dGhlbnRpY2F0
aW9uIHBsdXMNCktlcmJlcm9zIGludGVncml0eSBwcm90ZWN0aW9uLg0KDQpSUENfQVVUSF9HU1Nf
S1JCNVAgaXMgS2VyYmVyb3MgdXNlciBhdXRoZW50aWNhdGlvbiBwbHVzDQpLZXJiZXJvcyBjb25m
aWRlbnRpYWxpdHkuDQoNClNvLCBib3RoIG9mIHRoZXNlIHBzZXVkb2ZsYXZvcnMgc2VsZWN0IEtl
cmJlcm9zIHVzZXINCmF1dGhlbnRpY2F0aW9uICh2ZXJzdXMsIHNheSwgUlBDX0FVVEhfVU5JWCwg
d2hpY2ggZG9lcw0Kbm90KS4NCg0KDQo+IEFuZCB0aGUgZGlzdGluY3Rpb24gYmV0d2VlbiB4cHJ0
c2VjPXRscyBhbmQgeHBydHNlYz1tdGxzIHNlZW1zIHRvIGJlDQo+IHByZWNpc2VseSBhYm91dCB1
c2VyIGF1dGhlbnRpY2F0aW9uLg0KDQpObzogeHBydHNlYyBhdXRoZW50aWNhdGlvbiBpcyAvcGVl
ci8gYXV0aGVudGljYXRpb24uIFVzZXINCmF1dGhlbnRpY2F0aW9uIGlzIHN0aWxsIHNldCB2aWEg
c2VjPSAuIFNlZSB0aGUgZmluYWwNCnBhcmFncmFwaCBpbiBTZWN0aW9uIDQuMiBvZiBSRkMgOTI4
OS4NCg0KDQo+IEkgd291bGQgZGVzY3JpYmUgdGhlIGN1cnJlbnQgcHNldWRvIGZsYXZvdXJzIGFz
IG5vdCAiYSBjbGVhbiB3YXkiIHRvDQo+IGFkdmlzZSB0aGUgY2xpZW50IG9mIHNlY3VyaXR5IHJl
cXVpcmVtZW50cywgYnV0IHRoZXkgYXJlIGF0IGxlYXN0DQo+IGVzdGFibGlzaGVkIHByYWN0aWNl
Lg0KPiANCj4gUlBDX0FVVEhfU1lTX1RMUyAgc2VlbXMgdG8gbWUgdG8gYmUgYW4gb2J2aW91cyBz
b3J0IG9mIHBzZXVkbyBmbGF2b3VyLg0KPiANCj4gQnV0IEkgc3VzcGVjdCBhbGwgdGhlc2UgYXJn
dW1lbnRzIGFuZCBtb3JlIGhhdmUgYWxyZWFkeSBiZWVuIGRpc2N1c3NlZA0KPiB3aXRoaW4gdGhl
IHdvcmtpbmcgZ3JvdXAgYW5kIHBlb3BsZSBjYW4gc2Vuc2libHkgaGF2ZSBkaWZmZXJlbnQNCj4g
b3BpbmlvbnMuDQoNClllcywgdGhlc2UgYXJndW1lbnRzIHdlcmUgZGlzY3Vzc2VkIHdpdGhpbiB0
aGUgV0csIGFuZA0KSSBldmVuIHdyb3RlIGEgZHJhZnQgKG5vdyBleHBpcmVkKSB0aGF0IHRyZWF0
ZWQgdGhlDQp2YXJpb3VzIGNvbWJpbmF0aW9ucyBvZiBUTFMgYW5kIHVzZXIgYXV0aGVudGljYXRp
b24NCmZsYXZvcnMgYXMgdW5pcXVlIHBzZXVkb2ZsYXZvcnMuIFRoZSBpZGVhIHdhcyByZWplY3Rl
ZC4NCg0KDQo+IFRoYW5rcyBmb3IgaGVscGluZyBtZSB1bmRlcnN0YW5kIE5GUy9UTFMgYSBiaXQg
YmV0dGVyLg0KPiANCj4gTmVpbEJyb3duDQo+IA0KPiANCj4gDQo+PiANCj4+IA0KPj4+PiBTbyB0
aGVyZSBpcyBubyB2YWx1ZSBpbiBnaXZpbmcgbm9uLXRscyBjbGllbnRzIGFjY2VzcyB0bw0KPj4+
PiB4cHJ0c2VjPW10bHMgZXhwb3J0cyBzbyB0aGV5IGNhbiBkaXNjb3ZlciB0aGF0IGZvciB0aGVt
c2VsdmVzLiAgVGhlDQo+Pj4+IGNsaWVudCBuZWVkcyB0byBleHBsaWNpdGx5IG1vdW50IHdpdGgg
dGxzLCBvciBwb3NzaWJseSB0aGUgY2xpZW50IGNhbg0KPj4+PiBvcHBvcnR1bmlzdGljYWxseSB0
cnkgVExTIGluIGV2ZXJ5IGNhc2UsIGFuZCBjYWxsIGJhY2suDQo+Pj4+IA0KPj4+PiBTbyB0aGUg
b3JpZ2luYWwgcGF0Y2ggaXMgT0suDQo+Pj4+IA0KPj4+PiBOZWlsQnJvd24NCj4+IA0KPj4gDQo+
PiAtLQ0KPj4gQ2h1Y2sgTGV2ZXINCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

