Return-Path: <linux-nfs+bounces-2580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E0893BD2
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 16:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8BC1C21448
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BA2405E6;
	Mon,  1 Apr 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aco6fDLh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qI9ieCDh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52DE43AC2;
	Mon,  1 Apr 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980523; cv=fail; b=RF4/wD1sSkFV7ClCi4yqmQ4oOsOxByInHgNcYK1N7jJr3aTk/M4XlK9+u8ypv1usNRvTBxAgMNKsQeizfKLCzXsk8tp3yypRAlLrvGywcrTk2M5FGUygAVhET8eQQbkI2tUhVUi0XH4NZ5ZAcHO2L7VB7Kd8oS7h5A4c+SqT/7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980523; c=relaxed/simple;
	bh=GThGT1V4mjaZp7ALreASwx80pbzexD4fJOIiq37zY90=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vb70A5xeY88ylUu8e9aWZNDsxv2rkZh7qCUt54rxGGlEJIgvPgEUFrQ0VaGHRQlXaKy3xe8fT/zmD8lhEea2gc2R9BGsgNt7lj/5+30YvM0MHoqmLkdbonYiUC1+GIjkiaaHzqPycoXoqGRhEL3EJPCqxCR8n6Y3e+0XjpDOeF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aco6fDLh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qI9ieCDh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4318j3C2009927;
	Mon, 1 Apr 2024 14:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GThGT1V4mjaZp7ALreASwx80pbzexD4fJOIiq37zY90=;
 b=aco6fDLhgftD7nyrMMLYog5Hn+ClC9zASzG6u6BIqvuy1PRUvJU5X2bYh8/7e4B1Geiq
 GMl5u+N/pGoFsrsRbasXPrhppiyHyBL/mvjfnOSNt4ozpNlK9japdsi89QxXl5g5FKpb
 2t69xXbHegZMBnkeWBw6fZ8aaDcQRZkFJBDT1iRvS0Q1YLcdP4D08gbZbOGHSJ8Zyozq
 vgGOwJ6dD7KFf45kO32BQrR22YM1AIHSQz2+b76s1aSDDkey40dG3HsKu2q1Y7p2UGPM
 2n8Ldwuzpq/BbhLXZm08r8qhwRv1K1Kh6fVNeFc3Cl8SyVTs/QDVhVZhr5TIr68Wz7Js WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69b2jfpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 14:08:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431CUZ2Z028051;
	Mon, 1 Apr 2024 14:08:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6965dmnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 14:08:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc9Z4wL7/j5qS9W2qim/IPQDjmjfHDEqGf9dGmfDSXgYWBii0hO3WspElWBKAmqzuvpBF1k37Rl/6F/sUe49idhyMX7KBzcPORuGnXV7PwQEWtaYRO3XzgAbCTpRDBZS51ewrp+809WS4axZX6yehjVulDnG90cw35Od1hEAuWb0TUewLYqOHbtFIH4jakBi3fJwbluj5u3mapY9fre/aLylnDl5Z6bRvNF+q9rtU1ZhX9y99mv/P+I5+DPjLvuWCHcUEoo5AC05+lP9vuFDYjzPT+MWV9t0gIA3uzUxa2pML6CxhRw+jW3ckyRyQLpHvlhhVwL5MRJdzZO0RqF00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GThGT1V4mjaZp7ALreASwx80pbzexD4fJOIiq37zY90=;
 b=jN6I7MBaMsCmYwLIZzUHBWanwBskUxSl2pHxWLcT0B0Zq8iKGq4HZHJrPGJ4tzL8gkIc4OVOMNV8Q6cKDuLnphsWXWrPgI/fOySBzt+20u2KSEpq4l1HLjstg8R+kn0Ua2aJZ8IIjitkBJVdU71EykpIw3fdjXvdaBoOohEn3jE5WFCbgDjzfy5Img7gYILJ8VjCMc2TiCUU11bRMfRdXiJJi//Aa4IoNq0PWZ9hT+HUo6WBBVDUjPLg1pyH6bF56gpoWOqH6lyz3hKfSx0yT7ocj11nxsaGmEgIFD3byAC/dS3PbW9bmdEtUcdgxtPV6aamgrbZYgI7042Ep2DyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GThGT1V4mjaZp7ALreASwx80pbzexD4fJOIiq37zY90=;
 b=qI9ieCDhRyKbE61x0tOA7zRbahbzX66bkXf7wh6CJT3q2+lglx1wgFx0Or/+g0wnUHTH8B9sWA90xVHGT4c8DraaJ7P4BgZYwh/4yqPZ6kelNhcFqVmBno5I+SPyaFxmFh0HEmMKOAKXnlRQGAwEPBBVsiWW0+hTtUVNCWYamIQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6448.namprd10.prod.outlook.com (2603:10b6:806:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 14:08:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 14:08:08 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jan Schunk <scpcom@gmx.de>
CC: Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton
	<jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells
	<dhowells@redhat.com>,
        Linux regressions mailing list
	<regressions@lists.linux.dev>
Subject: Re: [External] : nfsd: memory leak when client does many file
 operations
Thread-Topic: [External] : nfsd: memory leak when client does many file
 operations
Thread-Index: AQHahD4Fjq/cniD0CUOCpHqbautP9A==
Date: Mon, 1 Apr 2024 14:08:08 +0000
Message-ID: <308BAEFD-8CAE-4496-8146-8C05DD78FB37@oracle.com>
References: <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
 <trinity-77720d9d-4d5b-48c6-8b1f-0b7205ea3c2b-1711398394712@msvc-mesg-gmx021>
 <51CAACAB-B6CC-4139-A350-25CF067364D3@oracle.com>
 <trinity-db344068-bb4b-4d0b-9772-ff701a2c70dd-1711663407957@msvc-mesg-gmx026>
 <C14AC427-BD99-4A87-A311-F6FB87FFC134@oracle.com>
 <trinity-157de7e0-d394-47fa-bb44-2621045a5b6e-1711812369391@msvc-mesg-gmx004>
 <Zgg9OzeFZUTc4hck@tissot.1015granger.net>
In-Reply-To: <Zgg9OzeFZUTc4hck@tissot.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6448:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Die2RWJHQGCDP4VadxYf/LZlsMPKo9/cwkRtahV5NA5g2FrybVsSfv5ketYMBGjegPyrlv3OHwJjXxOGE8rpvJV2P2U90demPuocellppv+TMlX2PuWJb7ruXTegPYUJPQ8nYD9n+P89vZg+anf/ksrCScLCQTfASaNtBkCAOlCkcWHe5q1T8jiva7LCx6l35a8YehKZ9vhCj4zd+WjZBuc5rBaqiK4TujjPqnRVgmiwQjn4mvSWsdrPVh67xsqX02e6VmsLTmwMt5HmZSdwthS3LjMpsdsOmkqD9wYXPzhdhB79t2CEqRCYAxGwbhHXMdhPS7zellnvzlDNjGjyGuFMPX95HP8UyQXyQ7QXvKzZRmeGaaBEdL0mFQkNCLGWE35RIV8UarLNJsaPutDRsitKBvZMVcgkENDzSE002W7z7Yv27zuvziLlOGuT/Bto2era3PQcgbR3A4uLRQt2kVIxCsxrKnE+24k1CYJDNqwgnzHSo19crAOUAeb+ZHZenKiTTG3OvaNyCuXv23WTnkLQWifO+wjrHsiHggsA4lKd4yqQT2wgu9AXZVBO6oGASZSU/NwaP7P0ePt+O1GNG56d24RQPQB+nFufvnfiM3o=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c0Fqdm9remEyODlvbSt6T21kQnVhQVlXeEp4WnZoMmxMNkIrQVdmTGlZR3B5?=
 =?utf-8?B?ZGVsSGtUanN4ekhEcXFKN2lwMktuZHdVYlF2RnlOejFBRVlEU2NGejlhNHNu?=
 =?utf-8?B?ZU1UZi9yRDRIeHdBMUp2K2FoM1BSOVVjZXo1ZExPVUZJQXo5d1ZlQ2xIcmJC?=
 =?utf-8?B?VDFHUjBTWWU2b2YySG1MQ1kvVEMvdENoK2J2MEE3T0hZanFvM091NEU1a0tQ?=
 =?utf-8?B?WnMwTmFhRTJHa242OElWSTU4czRuV2dXVmZMazl1QUVLcFhEb0sxbTg5cjZx?=
 =?utf-8?B?SFM2ODZ4NnJYMEpVVU1JV041R24vWmhQNm50ZHhSSzVCVzdTZWUrcktONFFp?=
 =?utf-8?B?UjJuV2lsRVZ5ano2SXlMR210ekR6ZXBMNDBPQjFCQUdLcGlTeEtzSzloSGZP?=
 =?utf-8?B?VlNQM1Q2MG5DZkJWTzE0Q2Q4UUdVNGNjV3lhcWlLMDU2cWQzMVZ2NXJxbmw2?=
 =?utf-8?B?OS9tSWdiMlVlSkIzWEljTFJqNzF3dEtOa1RtRVByUnVLdjliYTc3M1hhN1M5?=
 =?utf-8?B?ak5hRytJV25lTVRvQTl3TXU4S1RJT0pkaE0yMEd0ZjcwRzhFTExNSVcrVVNl?=
 =?utf-8?B?a0pjV3pVQ1Mrc05lNitNZEpialdBeHdXeVhFNEpOdmQ0bTZlNWkraGdRWEUw?=
 =?utf-8?B?Z1NFbC9DSGM2K2Uvb1NCaGo5VGJmT20zYmF1RG5UWktuOEJjYVJzTHV5aW1Q?=
 =?utf-8?B?YmY5TVA2WjRONlNYZHBjY0llWXFFTjMwMkNId1hQSU04dlhxQTFaZ3FLaDIv?=
 =?utf-8?B?WlYrR3A5V2ZwUGw2eFgxM2VrazM3aDdsOWh2QWk3YXYzQXVuUkhqdlY1YzVS?=
 =?utf-8?B?MmZNd3Q5ajgrWUkvVXozb1IvOHRPV0I5UmVuaDhaZUU5bFhpRUxlVlFyNGQv?=
 =?utf-8?B?eUo3RFVZMmdDNGhPenlCTklwUkxrQTlJRUt1bnJJamVoMG4wTHl4azVDQkdh?=
 =?utf-8?B?cnB6SE1rS2JVNFlJY3FoR2JBcXY4WldCbXI1MEtCVVh0aU95bkhHbG5Cdlds?=
 =?utf-8?B?WG9UZ3JTekxzN1NaWmRNbVdibDBNWVIzNVZpOXpzNEVLTXhYVnV5Q0ZuVXdL?=
 =?utf-8?B?Vzh3SWFJU2RFbG5ndUdnL01PNVVhRVVrQXVHbzhJWHdGSDdQeG9UbEhJL2V1?=
 =?utf-8?B?cGdmTUMzZzdHQzV1ZWJJclJTRnhDbVZuRllFL0dJMnNvRGZMYjJQdDgyWit0?=
 =?utf-8?B?cDBCaWZpN0lBeUFIOVA5RThvSzFMNWZiYW9yZmlFbnNlSGVIS1U4LytZdzRH?=
 =?utf-8?B?N0F4ZXVIajlBbThMVVovb2F4UlJiamhzVkMrQlFkQWJIQnFqVHJnVXdVeXBR?=
 =?utf-8?B?SS9sVDlJdmloYXdZbVdoU25rK1FLellzcW8vZVIxOWdROTl2UEpTT01KaStC?=
 =?utf-8?B?V2gvYTRUeDg2aUV0V0dBY1dXcWZzZ3JMb2EvUDg3UzlWd0RTYjJuME1wS0da?=
 =?utf-8?B?ZERvbFIwRnlRQXJWYUhkSG1lRHU2VnUrU0c5VVFKak9FSzE5MzdDckdtdS9j?=
 =?utf-8?B?Z05PNlFFU2VPNExOOFVaV2w1ZUxIMHlIemdkSUN6TGdWSTFlTzdjdjNnRHI3?=
 =?utf-8?B?OVBkK1hObll2aUJxOHdWclY1bGhOWCtlVzIwNmhsM09VWFVQZW9FSDk5RjdQ?=
 =?utf-8?B?YjM4akZ2emRmaTdpWWpMZDl1ckNWc2FyNW8zUHNWd1pjcEtEYk9iQjgzTTRo?=
 =?utf-8?B?WFRVV2ZIZWFtbmtMNVZJYTNJRldSYWczamE2SG5RVHpjVGRQdXFWdW81K29V?=
 =?utf-8?B?U2JCNjA0cE53OTBDMThyTEhwc2VoMEF6UHpEK0MrOFVqdytINkdyRWQyMVBR?=
 =?utf-8?B?Y3IxdDJuL1grQlZGdm1QMzFXVWZWS0g0cTZQMGdEaGRoZFJhb2UwNWFSeWp5?=
 =?utf-8?B?NE1wemJ5WTFrNGh2WTlQOUhaWDRTdldWVEYzMjd0cXllS2d2bzFJSDd3Z3pM?=
 =?utf-8?B?dWVBM3hIcUZXdFNaVk5lUS8zNHl0bklYQlV6NWxZY2VySVhONG5pVld5RUdh?=
 =?utf-8?B?MFRLenFkSFhKR1NXVENVZVpES3lxUERPSTF2SERmZllRR2Y3S01vbGNGVTBJ?=
 =?utf-8?B?bkI1clBwTURaL3p2c1psRVdqd1dCTkhRZVl0clEvbUVHMnQ1ZmhpQ0FuMWgx?=
 =?utf-8?B?RDNYZThEM0l4NS81VmUwSFpGdDhGYWRHamhSV1l6WUZkc3ZFU0dQbk9NSUk5?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C0292ECADA78E428E4C2BC04F079AA1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+01WeDvfS92oqx4PvmHXWc7uZUIXntWkUFe6QsShpB06BP1HrEeVo+QuPuBNeCHrvoM8Z5DRBqyvSx8j1a/cl64N/3hPxOAc+0WX1LRzzDjp794uAofhc3tTh5qghR9FALU4mbzGSnAD/i5+ejHdYi/3wrgUfPRhatgFpkIHPxt6Xs7OGs3dS9V8ldhnL66W75V50UcS/md1wTO/7C3eIv3gQkFabG6QmzFz1VRRYBmB4QZ4qOckhvSboxZseknFL8lMljLCaQN5ViuMG2sXn5dWnkL08i4cYJhbjz5SOXtTTMbNgS+K2Q+2Si+Ub8ONEQe2O9eydDso+z4HFqFF8LF9+7KpT0zLpAn+qaD6u1HRvj1DebqRQPKmez1xBvxmLnMl3sigSujsQV9XYzyCAwbgbZOVy0RWlnTPJUowhRWy4E9XZ3/JofzBvGX/Ege9QavGh7mF/DM4r04pFbGrI1s/tZS+aNJPq+Pg6Fiis1XepHpmiwLOkCYdG2+h568bwelmjl3WOuPEYkkUN9Hn780L674zcnSAl5W9/2hRrLYBuAK2cxNtCj9gM2IsRkK/bdXwRdO4932X4I6W5nha1Fl7C34KHtHxGNd6Ixb/YFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d044fe0-269e-4aa6-2b52-08dc52552847
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 14:08:08.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2fPVnMb8YRRycrim7/Y2t8M1tnBrNlAYBcpEW/gKcIKu8rkbcHjRgX7eqHsRLi4aYSDuPB8ZS0lf1HfRH0aqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404010100
X-Proofpoint-GUID: Fj5aS5-ptTVt3ycRqsCrlFd4rRxQQ6r2
X-Proofpoint-ORIG-GUID: Fj5aS5-ptTVt3ycRqsCrlFd4rRxQQ6r2

DQoNCj4gT24gTWFyIDMwLCAyMDI0LCBhdCAxMjoyNuKAr1BNLCBDaHVjayBMZXZlciA8Y2h1Y2su
bGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIE1hciAzMCwgMjAyNCBhdCAw
NDoyNjowOVBNICswMTAwLCBKYW4gU2NodW5rIHdyb3RlOg0KPj4gRnVsbCB0ZXN0IHJlc3VsdDoN
Cj4+IA0KPj4gJCBnaXQgYmlzZWN0IHN0YXJ0IHY2LjYgdjYuNQ0KPj4gQmlzZWN0aW5nOiA3ODgy
IHJldmlzaW9ucyBsZWZ0IHRvIHRlc3QgYWZ0ZXIgdGhpcyAocm91Z2hseSAxMyBzdGVwcykNCj4+
IFthMWMxOTMyOGExNjBjODAyNTE4NjhkYmQ4MDA2NmRjZTIzZDA3OTk1XSBNZXJnZSB0YWcgJ3Nv
Yy1hcm0tNi42JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvc29jL3NvYw0KPj4gLS0NCj4+ICQgZ2l0IGJpc2VjdCBnb29kDQo+PiBCaXNlY3Rpbmc6IDM5
MzUgcmV2aXNpb25zIGxlZnQgdG8gdGVzdCBhZnRlciB0aGlzIChyb3VnaGx5IDEyIHN0ZXBzKQ0K
Pj4gW2U0ZjFiODIwMmZiNTljNTZhM2RlNzY0MmQ1MDMyNjkyMzY3MDUxM2ZdIE1lcmdlIHRhZyAn
Zm9yX2xpbnVzJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvbXN0L3Zob3N0DQo+PiAtLQ0KPj4gJCBnaXQgYmlzZWN0IGJhZA0KPj4gQmlzZWN0aW5nOiAy
MDE0IHJldmlzaW9ucyBsZWZ0IHRvIHRlc3QgYWZ0ZXIgdGhpcyAocm91Z2hseSAxMSBzdGVwcykN
Cj4+IFtlMDE1MmU3NDgxYzZjNjM3NjRkNmVhOGVlNDFhZjVjZjlkZmFjNWU5XSBNZXJnZSB0YWcg
J3Jpc2N2LWZvci1saW51cy02LjYtbXcxJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvcmlzY3YvbGludXgNCj4+IC0tDQo+PiAkIGdpdCBiaXNlY3QgYmFk
DQo+PiBCaXNlY3Rpbmc6IDk3NSByZXZpc2lvbnMgbGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJv
dWdobHkgMTAgc3RlcHMpDQo+PiBbNGEzYjEwMDdlZWIyNmIyYmI3YWU0ZDczNGNjODU3NzQ2MzMy
NTE2NV0gTWVyZ2UgdGFnICdwaW5jdHJsLXY2LjYtMScgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2xpbnVzdy9saW51eC1waW5jdHJsDQo+PiAtLQ0KPj4g
JCBnaXQgYmlzZWN0IGdvb2QNCj4+IEJpc2VjdGluZzogNDc2IHJldmlzaW9ucyBsZWZ0IHRvIHRl
c3QgYWZ0ZXIgdGhpcyAocm91Z2hseSA5IHN0ZXBzKQ0KPj4gWzRkZWJmNzcxNjllZTQ1OWM0NmVj
NzBlMTNkYzUwM2JjMjVlZmQ3ZDJdIE1lcmdlIHRhZyAnZm9yLWxpbnVzLWlvbW11ZmQnIG9mIGdp
dDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9qZ2cvaW9tbXVmZA0K
Pj4gLS0NCj4+ICQgZ2l0IGJpc2VjdCBnb29kDQo+PiBCaXNlY3Rpbmc6IDIzNyByZXZpc2lvbnMg
bGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkgOCBzdGVwcykNCj4+IFtlN2U5NDIzZGI0
NTk0MjNkM2RjYjM2NzIxNzU1M2FkOWVkZWRhZGM5XSBNZXJnZSB0YWcgJ3Y2LjYtdmZzLnN1cGVy
LmZpeGVzLjInIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC92ZnMvdmZzDQo+PiAtLQ0KPj4gJCBnaXQgYmlzZWN0IGdvb2QNCj4+IEJpc2VjdGluZzogMTQx
IHJldmlzaW9ucyBsZWZ0IHRvIHRlc3QgYWZ0ZXIgdGhpcyAocm91Z2hseSA3IHN0ZXBzKQ0KPj4g
WzhhZTVkMjk4ZWYyMDA1ZGE1NDU0ZmMxNjgwZjk4M2U4NWQzZTE2MjJdIE1lcmdlIHRhZyAnNi42
LXJjLWtzbWJkLWZpeGVzLXBhcnQxJyBvZiBnaXQ6Ly9naXQuc2FtYmEub3JnL2tzbWJkDQo+PiAt
LQ0KPj4gJCBnaXQgYmlzZWN0IGdvb2QNCj4+IEJpc2VjdGluZzogNjEgcmV2aXNpb25zIGxlZnQg
dG8gdGVzdCBhZnRlciB0aGlzIChyb3VnaGx5IDYgc3RlcHMpDQo+PiBbOTlkOTk4MjVmYzA3NWZk
MjRiNjBjYzljZjBmYjFlMjBiOWMxNmIwZl0gTWVyZ2UgdGFnICduZnMtZm9yLTYuNi0xJyBvZiBn
aXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy9hbm5hL2xpbnV4LW5mcw0KPj4gLS0NCj4+
ICQgZ2l0IGJpc2VjdCBiYWQNCj4+IEJpc2VjdGluZzogMzkgcmV2aXNpb25zIGxlZnQgdG8gdGVz
dCBhZnRlciB0aGlzIChyb3VnaGx5IDUgc3RlcHMpDQo+PiBbN2I3MTllMmJmMzQyYTU5ZTg4YjJi
NjIxNWI5OGNhNGNmODI0YmM1OF0gU1VOUlBDOiBjaGFuZ2Ugc3ZjX3JlY3YoKSB0byByZXR1cm4g
dm9pZC4NCj4+IC0tDQo+PiAkIGdpdCBiaXNlY3QgYmFkDQo+PiBCaXNlY3Rpbmc6IDE5IHJldmlz
aW9ucyBsZWZ0IHRvIHRlc3QgYWZ0ZXIgdGhpcyAocm91Z2hseSA0IHN0ZXBzKQ0KPj4gW2U3NDIx
Y2U3MTQzN2VjOGU0ZDY5Y2M2YmRmMzViNjg1M2FkYzUwNTBdIE5GU0Q6IFJlbmFtZSBzdHJ1Y3Qg
c3ZjX2NhY2hlcmVwDQo+PiAtLQ0KPj4gJCBnaXQgYmlzZWN0IGdvb2QNCj4+IEJpc2VjdGluZzog
OSByZXZpc2lvbnMgbGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkgMyBzdGVwcykNCj4+
IFtiYWFiZjU5YzI0MTQ1NjEyZTRhOTc1ZjQ1OWE1MDI0Mzg5ZjEzZjVkXSBTVU5SUEM6IENvbnZl
cnQgc3ZjX3VkcF9zZW5kdG8oKSB0byB1c2UgdGhlIHBlci1zb2NrZXQgYmlvX3ZlYyBhcnJheQ0K
Pj4gLS0NCj4+ICQgZ2l0IGJpc2VjdCBiYWQNCj4+IEJpc2VjdGluZzogNCByZXZpc2lvbnMgbGVm
dCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkgMiBzdGVwcykNCj4+IFtiZTJiZTVmN2Y0NDM2
NDQyZDhmNmJmZmJiOTdhNmY0MzhkZjI4OTZiXSBsb2NrZDogbmxtX2Jsb2NrZWQgbGlzdCByYWNl
IGZpeGVzDQo+PiAtLQ0KPj4gJCBnaXQgYmlzZWN0IGdvb2QNCj4+IEJpc2VjdGluZzogMiByZXZp
c2lvbnMgbGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkgMSBzdGVwKQ0KPj4gW2Q0MjQ3
OTcwMzJjNmUyNGI0NDAzN2U2YzdhMmQzMmZkOTU4MzAwZjBdIG5mc2Q6IGluaGVyaXQgcmVxdWly
ZWQgdW5zZXQgZGVmYXVsdCBhY2xzIGZyb20gZWZmZWN0aXZlIHNldA0KPj4gLS0NCj4+ICQgZ2l0
IGJpc2VjdCBnb29kDQo+PiBCaXNlY3Rpbmc6IDAgcmV2aXNpb25zIGxlZnQgdG8gdGVzdCBhZnRl
ciB0aGlzIChyb3VnaGx5IDEgc3RlcCkNCj4+IFtlMThlMTU3YmI1YzhjMWNkOGE5YmEyNWFjZmRj
ZjRmMzAzNTgzNmY0XSBTVU5SUEM6IFNlbmQgUlBDIG1lc3NhZ2Ugb24gVENQIHdpdGggYSBzaW5n
bGUgc29ja19zZW5kbXNnKCkgY2FsbA0KPj4gLS0NCj4+ICQgZ2l0IGJpc2VjdCBiYWQNCj4+IEJp
c2VjdGluZzogMCByZXZpc2lvbnMgbGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkgMCBz
dGVwcykNCj4+IFsyZWIyYjkzNTgxODEzYjc0YzcxNzQ5NjExMjZmNmVjMzhlYWRiNWE3XSBTVU5S
UEM6IENvbnZlcnQgc3ZjX3RjcF9zZW5kbXNnIHRvIHVzZSBiaW9fdmVjcyBkaXJlY3RseQ0KPj4g
LS0NCj4+ICQgZ2l0IGJpc2VjdCBnb29kDQo+PiBlMThlMTU3YmI1YzhjMWNkOGE5YmEyNWFjZmRj
ZjRmMzAzNTgzNmY0IGlzIHRoZSBmaXJzdCBiYWQgY29tbWl0DQo+PiBjb21taXQgZTE4ZTE1N2Ji
NWM4YzFjZDhhOWJhMjVhY2ZkY2Y0ZjMwMzU4MzZmNA0KPiANCj4gVGhpcyBpcyBhIHBsYXVzaWJs
ZSBiaXNlY3QgcmVzdWx0IGZvciB0aGlzIGJlaGF2aW9yLCBzbyBuaWNlIHdvcmsuDQo+IA0KPiBE
YXZpZCAoY2MnZCksIGNhbiB5b3UgaGF2ZSBhIGJyaWVmIGxvb2sgYXQgdGhpcz8gV2hhdCBkaWQg
d2UgbWlzcz8NCj4gSSdtIGd1ZXNzaW5nIGl0J3MgYSBwYWdlIHJlZmVyZW5jZSBjb3VudCBpc3N1
ZSB0aGF0IG1pZ2h0IG9jY3VyDQo+IG9ubHkgd2hlbiB0aGUgWERSIGhlYWQgYW5kIHRhaWwgYnVm
ZmVycyBhcmUgaW4gdGhlIHNhbWUgcGFnZS4gT3INCj4gaXQgbWlnaHQgb2NjdXIgaWYgdHdvIGVu
dHJpZXMgaW4gdGhlIFhEUiBwYWdlIGFycmF5IHBvaW50IHRvIHRoZQ0KPiBzYW1lIHBhZ2UuLi4/
DQo+IA0KPiAvbWUgc3RhYnMgaW4gdGhlIGRhcmtuZXNzDQo+IA0KPiANCj4+IEkgZm91bmQgdGhl
IG1lbW9yeSBsb3NzIGluc2lkZSAvcHJvYy9tZW1pbmZvIG9ubHkgb24gTWVtQXZhaWxhYmxlDQo+
PiBNZW1Ub3RhbDogICAgICAgICAzNDY5NDgga0INCj4+IE9uIGEgYmFkIHRlc3QgcnVuIGluIGxv
b2tzIGxpa2UgdGhpczoNCj4+IC1NZW1BdmFpbGFibGU6ICAgICAyMTA4MjAga0INCj4+ICtNZW1B
dmFpbGFibGU6ICAgICAgMjY2MDgga0INCj4+IE9uIGEgZ29vZCB0ZXN0IHJ1biBpdCBsb29rcyBs
aWtlIHRoaXM6DQo+PiAtTWVtQXZhaWxhYmxlOiAgICAgMjE1ODcyIGtCDQo+PiArTWVtQXZhaWxh
YmxlOiAgICAgMjIxMTI4IGtCDQoNCkphbiwgbWF5IEkgYXNrIG9uZSBtb3JlIGZhdm9yPyBTaW5j
ZSB0aGlzIG1pZ2h0IHRha2UgYSBsaXR0bGUNCnRpbWUgdG8gcnVuIGRvd24sIGNhbiB5b3Ugb3Bl
biBhIGJ1ZyByZXBvcnQgb24NCmJ1Z3ppbGxhLmtlcm5lbC5vcmcgPGh0dHA6Ly9idWd6aWxsYS5r
ZXJuZWwub3JnLz4sIGFuZCBjb3B5IGluIHRoZSBzeW1wdG9tb2xvZ3kgYW5kIHRoZQ0KYmlzZWN0
IHJlc3VsdHM/IEl0IHdpbGwgZ2V0IGFzc2lnbmVkIHRvIFRyb25kLCBhbmQgaGUgY2FuDQpwYXNz
IGl0IHRvIG1lLg0KDQpUaGUgcHJvYmxlbSBsb29rcyBsaWtlIGhvdyB3ZSdyZSB1c2luZyBhIHBh
Z2VfZnJhZ19jYWNoZSB0bw0KaGFuZGxlIHRoZSByZWNvcmQgbWFya2VyIGJ1ZmZlcnMsIGJ1dCBJ
J20gbm90IHN1cmUgd2hhdCB0aGUNCnByb3BlciBzb2x1dGlvbiBpcyB5ZXQuDQoNCiNyZWd6Ym90
IF5pbnRyb2R1Y2VkOiBlMThlMTU3YmI1YzgNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

