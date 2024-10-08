Return-Path: <linux-nfs+bounces-6925-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362C0995027
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BDB1C24F35
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491531DEFED;
	Tue,  8 Oct 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WNjhdvpi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TT3xqgiY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFD1DEFD7;
	Tue,  8 Oct 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394361; cv=fail; b=PQLshsJiQJJWqAACsDpoQnypfCu7d3Rd1zAPohyUQ6zhJp1mipY6YWr1CrTpwrjMrxbk6ZL/LnvPAeU+5P0HzgGqtsjz1q9SGONe8ooKZR4KVvtMXp+90Tzg1PQFUGLMmxOZH3k2xG4iaf/uZxK/rPpAK768tg52Ol3tZub6eI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394361; c=relaxed/simple;
	bh=+8Pgvra0J7iYh/95w2UPDAHP7Bh0YT7d5UnU5ZKuWPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aAlNP83G8nz/s54l8sC7oUoomvc/I5txhXzKdch7AVXDccuJ/Dd5CaMMRpEi9X316RjWiDsYsJpINH+T9kDUE2WIrNYzjeJce0GfmHpALB2Iz7MnuSgHenKhMTPC5+kRGH/WSQ12FkPH9frqaSXQCLWjUX/Ezd7luBwuCn4jLkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WNjhdvpi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TT3xqgiY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Ctclb024799;
	Tue, 8 Oct 2024 13:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+8Pgvra0J7iYh/95w2UPDAHP7Bh0YT7d5UnU5ZKuWPg=; b=
	WNjhdvpiTnvKBdTs5+zxpYhL82ZeFItiuIgLbJeaWbKz0PV1buTJO1NPLEobajQn
	duvUQcDeyLKjh8VjAtDlwIJL+gRCub+QJPEZy1BO8XL7n7nORH2SCyMEWSxaaoFq
	xcRatKm/K7v6QgO7S3ySVIq5vAHhMF/vqlmtQT0ZXy8QvSMVRrEwADIO3hVq5G/y
	sdAmfJ0SwQZWtr3S0kIpbs3pOJkmPiwFcouMz47p+5Cdln31UsuY+pC1fS9tRdZ8
	tbt+1J6eUY+RqFIBCIYgDwZWIOoQsoINCeQ+g4xTZtDSqYsmzJ7SLXWyeWzg0idz
	SGn+JJ594X+INGsM97cg+Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ydt6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 13:32:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498DT8eD003150;
	Tue, 8 Oct 2024 13:32:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwdf6gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 13:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSYJ3HMfqu7HvI9PtUEyNN/fX/gbVuDxSdMBlfpUG0Xo+fH4dWLH8AA+UstGILFzaYymR09PQiZ905avPLgJb9pAKUVzkimhg0NCt0qKKNje5XB+2441rkA38Q1/RBeEz2Fn+IkQ/UUyIBNj2mOnRCPzdbeFZNemj2qxt6GVQy958qfYVJ+M/UJUstKF96ut+TwyAlxajZL/AXO2T+5jtPrrI/new9QOMn+DYFh3LhrIBeUxcd6FV0KXpR0Hpv9eserfQ0yq/sC8b8fXXMLePPAutv6fRZnAJDPA8IrkfHJRzZlA1MNbf7eS018HuwxgQeoUQWRYOfkx9eqCXjWktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Pgvra0J7iYh/95w2UPDAHP7Bh0YT7d5UnU5ZKuWPg=;
 b=fjAbkhgtdAxrclehzcwVnWWBi41+SUmQSE1xE91mU2XCrb2mtqVv5tOaXOgdziEcQZA47yFEllkkTU6w/xxCfspE+IuUColgR+4TcjVCx1USV4aZNj8aFQ6ps/N4sQ228FhzJ/9RwVZOV68zaDGyvsio8ZCU/Vd1UcOr5wC4JXl2f5sGOv7iVVbsdeoJjc+qqSr6PsIte/rwe1kZfHJClpOnQh+X+qYyFHK6qKk9N/N57e4J+LPpFWE3gmyqqZBsFbXEpfaNlqvtmpb5Y94UUjZSN5XG9FbwpW/b/4eYp4C34ysFKPeogXl1GhHvJCLfj+H3aEUiPpNVPT6jNx2yGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Pgvra0J7iYh/95w2UPDAHP7Bh0YT7d5UnU5ZKuWPg=;
 b=TT3xqgiYiMiB2bMMIHheWO22cAJ5f28CmEQR7Zex9/sd0c+xDAFLtU6c14RRlozz7J9FtLWS2x2ESWKV7PVoQH6ZSkFjNyCeYdz/tck4nvbQ0N++uzXYcDD2D/FngXBxDHdV7VArVBBe+Ip12WUoq2quUuAsR8a/RJAGidHXP2U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6565.namprd10.prod.outlook.com (2603:10b6:806:2bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 13:32:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 13:32:22 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>, Olga Kornievskaia <aglo@umich.edu>
CC: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: fix possible badness in FREE_STATEID
Thread-Topic: [PATCH 1/1] nfsd: fix possible badness in FREE_STATEID
Thread-Index:
 AQHbFqldlJOEKcWGtkiU/nXHfsxForJ4P1kAgAAYZwCAABrdgIAANFQAgALGR4CAAK7hAIAAw4oA
Date: Tue, 8 Oct 2024 13:32:22 +0000
Message-ID: <D0729DB9-6F47-48D6-A030-71C9D09079E2@oracle.com>
References:
 <CAN-5tyE=XkZ9hfGOortUapxCc43_YkgSeN9+7oFf=M8xRFFxTw@mail.gmail.com>
 <172835234057.3184596.16273347722668350379@noble.neil.brown.name>
In-Reply-To: <172835234057.3184596.16273347722668350379@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6565:EE_
x-ms-office365-filtering-correlation-id: 423c1260-0e79-43a0-5a9e-08dce79da3e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVVrUHRJTnJzKzM3QmM1WjVqU0NhZHZhN1pZZG5pWXU0c3RVZG95Q0NvWFVY?=
 =?utf-8?B?MXpzWGN4UDUwRnVKQzhLUEtkdnJyWXRnM1l2allCSk82cXQrMHlTaS8xZkJS?=
 =?utf-8?B?TEVHdlJGTFd6V2VUdy9POEczZm1KWHBEKzU3YjNJWUtEaGtiTVAwNzR2aWlV?=
 =?utf-8?B?d3BudTdxQ0RmQzBHSkRoZmpub1hJZThHM1dmbTZ1MHdhMC9FMEtWRmxNdGg4?=
 =?utf-8?B?WmswMitLbTZraFZkSVpKTUpITXZpdWZYYnU3UUVmekd3VDhzWHB3S0RTOUFk?=
 =?utf-8?B?TUNHV3YzMzFIWDhOWlRBalhFTXZCdHI3KzVLc25LSURYRjh0SkxYMlNLVjlw?=
 =?utf-8?B?TzdlK2swanVid1JqNkVlOW9QRWx3SFliNFZOSDlOQ0FlVWNwWVRnVjI1UTVD?=
 =?utf-8?B?dWUxS0xISTBjTGJTWXlnSTMzNVVJYVBNUEdEaTlNSlg0L3hGL3VONmFQTDFF?=
 =?utf-8?B?ZVNaalYySGVHYThHZ2s1MnBiQjgvWnI1a0piUHBkb1h3aGUvN2VLU1ErZnJY?=
 =?utf-8?B?d3Z1VE1yVUJxTkVIcXZrbnIzSnd4THl6c1ZERVRvRGpNVWVYbFhoQkNYQ0pi?=
 =?utf-8?B?ZnJkTTNFWFVJQWtHeXR2NldjRFFZSWh6ZjlMRzlRTVE5SjVJUWFPTTYrZHdC?=
 =?utf-8?B?WGgxeVBFVWZYTVJHUEFCdlVkSm4rclcxeGt5MkdrV04waW91MUlEbWo2QmUw?=
 =?utf-8?B?alhiRUNzcm8vUktxcDNaMGxsR0xSMVNLVWwyOXlnUnlwWmdpbzg2aFNhR3cz?=
 =?utf-8?B?YmFLOHM3UHh0L1VnRTlLSEE3UmlHWHJna3ZBZEw4TUNDUlZuQlIxU1NsVDgx?=
 =?utf-8?B?SWVTUGRYdm44WE4rTHNHeU5GTGRTRkp1UDVMQlF1UVJrTnpzTkxYKzNicy9C?=
 =?utf-8?B?UWpVcGxhVlJqdEJQWmM5amhSdmd1S2M4aWZvcC83ZlVHOHg3UmVyWUhEeE5T?=
 =?utf-8?B?OGYzMjd3d3Fha2RXTWtuWm5GUEZCRUJBRnBRTHA3WkN1N0RacU5VRXVoMXlY?=
 =?utf-8?B?b1F1aXhidVh0TmE2N25BUUN2MWJ6QnRGRS84aTQ1aGsvQTV1bzNudlhDanR6?=
 =?utf-8?B?SVVVdDBFRGtiNFhLdnBTeXdFQ05PdlRyV3NLRG5kNUZuWjZ2RTB6SDZia01x?=
 =?utf-8?B?STQxUmVJT3psbUVjeCs4d3ZmVUdqOGs1UmhCd0xCcjFGNlRGeFFDOVgyTGJK?=
 =?utf-8?B?cHRMLzNJSC9TR21YMURwZVBVcmxaME9uaUh2VW1xYVdpY3A4OHFMQWduU09U?=
 =?utf-8?B?Q2RnZEwyem5WSFR0SWlvaFlMQ2E5TGxaR0pXQjFBak55NUZDbmlEbGsyUnIx?=
 =?utf-8?B?NXpJRWhUKzgwcHN3bFI5TEtmaU1GMSthUmJuZk9mdHNFSjZvTWVqcHhLOHdq?=
 =?utf-8?B?VnpMOWlVSmFnWmpjODk0cUdxMjRFS00xWFFWZ3A1S2JnUTczYUVTTzNJNnBW?=
 =?utf-8?B?TWV2YkNld3RLOG9MbFBqRkVGQTNRVHNENGcrL1k3VnpIZUpYM1VzMS9mUVJz?=
 =?utf-8?B?V3k4d1A2TW82T2RudzZaSE5qVmVodG02VHFnMXh5V3laYmpTSXRtZG5qa1dW?=
 =?utf-8?B?RjJkb0w5djgzVDRpM2NYdDN5MWl3c1I0YTdhRk9MYVVCR0dUQXNBZE5nVE9o?=
 =?utf-8?B?Q2J1Z0d5T0wzak1reEoxUHFibFJKMUs2TE42K25IM3NEaVZUak5GOTNBWEtU?=
 =?utf-8?B?V2hsV0xPQjhNR3JIM3liZ2RsazhldDBsMjJRZWdVTXdzYWorV2FmSWdveGtt?=
 =?utf-8?B?ZGk4N040SFAzdjNVV1V4aEgvMXRzTHFLbEkzY2xIbnd4dzM4REpOQ3Q4QzJn?=
 =?utf-8?B?TVIyLzA1ckFhZVNTMVlkUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTVhZUJlUkkxcFl0V1Z2bEhad3Qwd1JQelJqRGtkdnZGby9Vc0lCZzBZOTZV?=
 =?utf-8?B?Y1A5RDNDS1RIcVB3RUNPQ0M3MmhOdGcxb2gxYjJhUjJUbStKYlphVzZoRGp2?=
 =?utf-8?B?YUx4aEFDSkZXeFRZdE1FYm5tZVV5WlE4OURQQXdFdlR5dUxGWCsvRlpOVUFw?=
 =?utf-8?B?WmxzNHFUeWRTM005RW1YQ3BmS3hXUGtGN043c2U3V3lsOFMvb0JSWE8yTExE?=
 =?utf-8?B?aGZZMWRld1NlZW9EODFIR200KzNmUEY3Vm9BRlBxZWFMZ1JwL3NtL2xyOFA2?=
 =?utf-8?B?eXNhNEV1OXNVZlRoQUFYdUdwMy83Z1p3NEtmcXdwQU5CQzZ1MEhnM0hVeHR2?=
 =?utf-8?B?d1N5dUdNWVlnRmdjOWNEVytkZmNScWNrZkQvWE4rVlNyVUlIK0ovaUFjeXBm?=
 =?utf-8?B?RnFUSGhMNlpRZFRqOWQvWWVQRXk2bzNkUU84MjZvblpNcFhiREFnRDcwenRL?=
 =?utf-8?B?L0syam96Ukx0eU0yVlZsT0hOTGlxZDZvVzZFSWF1Q3F3NFFWZkVWeC9MY09T?=
 =?utf-8?B?dG5iTEZzZlJwUGpWQk4zM09kbDRHai9GNjExZlB2aERDV05QcmtWTTlyOW9u?=
 =?utf-8?B?dzJ6ZkZOQnJYWS84Y1EwRko4QVk0cGFva041aXdiSnhzWlNFRVBlUlpXZFRp?=
 =?utf-8?B?ZThkS1M4U2dSNEZaOW8xeVhIaUd5a3dRMHpvTHBkVDJIV1NET2Q5YnZtaGwx?=
 =?utf-8?B?YkZtblpocktVc1FFT3hUOWgzK01VUTlHY3hBNkczQUVWYzBZTjBQVmtoQ1FQ?=
 =?utf-8?B?ZmpQN3g1NE9nRG4wa1dLVFY1T2Q3VVB2N0ZqWkl2YjRSc244NXZpWU0vOUY2?=
 =?utf-8?B?bzlKT2Vad010YnY2VEZYZ2JUaGpVT3BrZ2l0Q0NpU0hrQmV6MkFtK2h3NE95?=
 =?utf-8?B?ZnUxSnFNMWo1cVpyYVBWd2c5WWpUSkdOaUVybXczcFhpTXRQMmxpZk45MFgv?=
 =?utf-8?B?cFR0aktMekZHVHhoNm1DUFFyR0ZXRUZEWnB6SzdNcFVyazFZVjFQYnR4S21D?=
 =?utf-8?B?ZEJrb0FSR0x0M2ZZN2xoc3l5eWZPSWpFVWlkUVhldW8zZElKcHZJYTEySHFP?=
 =?utf-8?B?Sk5sUjdFNkNoalprYlNNNVZtVGdJbVRvU2JHN3V3ODJjcWNocENsQXpGZXFm?=
 =?utf-8?B?RXluMXdFQXVhZDhpYkdXcDJON0loU3YycTkrazZFRW5CaWNkNWtqK3h6NVpq?=
 =?utf-8?B?Zzd3UlVuaU40K3pIV1NYRndsa0lGcWkyTWVLSFFDTjJFd1Y5VWo1WnhnM2Vn?=
 =?utf-8?B?a0VleUI1Z09HL0x6LzBJMmZzZytTc3gya2lxTnhXKzgyR2lVNy9NMXRtc0VY?=
 =?utf-8?B?T0FIWkxycXB6OFZwbHFoM1NmQ1YybmMzTnBJbm1NRHJQeEd0aFBaK29vSEZS?=
 =?utf-8?B?UHRaZkxRWjJ4RzVZZCtqMEt4VEVtVmNzNnBVWmJHVDE4N2pxV1dHa0JBRk84?=
 =?utf-8?B?WnpoVFREcnlkOWU4dGpScmJ6UFJqUUtTWGJTUHRLa1VqTHViZ1diSDUzek1F?=
 =?utf-8?B?VEQ0NDBLZ3laOXNpS0Y2bGtEQkd4QmViZTEwcTB3TnN2QlFCMklqY3lZeVpa?=
 =?utf-8?B?dGd1VGZNWEY5R1JIY2ludGthTnhVdktlbU1XbEIxYTNPZDlLQ3VIMzUvL1JS?=
 =?utf-8?B?eUpJUUMrdFEzdGlSTFUvcyt0WHkxNzdOencvclhkalNWbmhmbThSamNtM01Y?=
 =?utf-8?B?MXpsa2NFMFpScVU4eEZLbUhoS1FOekxrNS9TaWtTVllmOUhWL0NBcTFyTFRQ?=
 =?utf-8?B?UUJhN3FhYmJ4UHBYemg5TlByNmRDb3ZlQnllZjhta3JTd0xUUUtjQk4wMWs0?=
 =?utf-8?B?SU80MkhzTjh4c3BJaVZRR3dMZXM2aE9hRjVrbUNlb1dZSHcxbDRhM0dTOGxr?=
 =?utf-8?B?L1pqU25FSWxzQ2I5MHRBa244cmtnS3VHZDErWGlxdkkrRjc4VUxqTGNLc3B5?=
 =?utf-8?B?RUhnSWtwZ1ZiV1c3YWZwclZEMW9DVkZQRW1nLzB1ZmV5a0VEbzBaK3F4YllK?=
 =?utf-8?B?SFNjdlFlendxbDNwSy93WVpxSFplTUNRREpIV0dYdHo3U0ROalpKSUNFR09F?=
 =?utf-8?B?RU9wdTBTQU9EcVlEK3dGMmg2bWVtTyswd1FRdzBUYU1lTTVsVmhqVDJWYnFD?=
 =?utf-8?B?ellaQmUySTZ6WUQyV1prQ01DaWxQK2tEdmN1TjVublBxU1lHN2NSdjlkL1pS?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FAD2F7D9476F542B556602826881EF0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZHeMg7unpxhe96xwlmGHBGcx6JNohxQrRidY95/H0Ml4PhuisPOyNKm91mnZHprk3xGVHp2SV9MZcmymfstdJvdIr4VjcFyHGfUeyqRptAoei4GpIqLMPbof2AaFkTtedPtIDpvFj2iySXYwZUrRA0fxrNs9Y0nqU7mKPM2nBD3Mpw1IjQwDE+TvDacboywvRneYkNbcbSSX3YfE/+wEENAl5Yg+PaJq0CXDfvBj15w7AL3qDFrKKf8O6OEGX7vqtOBCRTQ++lhM9wVUcgikDXEbxXpZxldqG6IaW7sR3R067KtXBk0zcEs8yS1/06gt7DDaOH4V0b3WThOv9tIPD5DiDy/dXpxA7OL9P5+DiltFWoDVhS+7fxLsmFmcv9I/pWFaRD6oMR+VL6MRIJBrjkTv0jK2TimYIJ0BZisbjophurQPM0c5/2GBwSgg9pHK7pXk+79ItQ/UcuWVoU0UP4tL23kqx1appD45QQUunTf1Qy2NaUonskpm8yjppwPBv2xcROl5FgCx8uXC9igrP0KAB3OINMbtqa6ST3jVBpIaagdc36idF109xB64BXjiJEaWlOFiIte6+MNq76zlbRD4KeVaJzPi6UWtrUOfumU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423c1260-0e79-43a0-5a9e-08dce79da3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 13:32:22.4984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1ORg/M5wXDziwbJMdcTaJXYI/TlWdCGCWcxAFIvmC8qa/1foih7rlJcfXFUUyqEFHsVwzNEAiRyOMtJ1egelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_11,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080085
X-Proofpoint-ORIG-GUID: i2v-S4gODEuWBw3ZOP5cW5HUYBAAQVhB
X-Proofpoint-GUID: i2v-S4gODEuWBw3ZOP5cW5HUYBAAQVhB

DQoNCj4gT24gT2N0IDcsIDIwMjQsIGF0IDk6NTLigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNl
LmRlPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMDggT2N0IDIwMjQsIE9sZ2EgS29ybmlldnNrYWlh
IHdyb3RlOg0KPj4gT24gU2F0LCBPY3QgNSwgMjAyNCBhdCA1OjA54oCvUE0gTmVpbEJyb3duIDxu
ZWlsYkBzdXNlLmRlPiB3cm90ZToNCj4+PiANCj4+PiBPbiBTdW4sIDA2IE9jdCAyMDI0LCBDaHVj
ayBMZXZlciB3cm90ZToNCj4+Pj4gT24gU2F0LCBPY3QgMDUsIDIwMjQgYXQgMTI6MjA6NDhQTSAt
MDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+Pj4+PiBPbiBTYXQsIDIwMjQtMTAtMDUgYXQgMTA6
NTMgLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4+Pj4+IE9uIEZyaSwgT2N0IDA0LCAyMDI0
IGF0IDA2OjA0OjAzUE0gLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPj4+Pj4+PiBX
aGVuIG11bHRpcGxlIEZSRUVfU1RBVEVJRHMgYXJlIHNlbnQgZm9yIHRoZSBzYW1lIGRlbGVnYXRp
b24gc3RhdGVpZCwNCj4+Pj4+Pj4gaXQgY2FuIGxlYWQgdG8gYSBwb3NzaWJsZSBlaXRoZXIgdXNl
LWFmdGVyLXRyZWUgb3IgY291bnRlciByZWZjb3VudA0KPj4+Pj4+PiB1bmRlcmZsb3cgZXJyb3Jz
Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSW4gbmZzZDRfZnJlZV9zdGF0ZWlkKCkgdW5kZXIgdGhlIGNs
aWVudCBsb2NrIHdlIGZpbmQgYSBkZWxlZ2F0aW9uDQo+Pj4+Pj4+IHN0YXRlaWQsIGhvd2V2ZXIg
dGhlIGNvZGUgZHJvcHMgdGhlIGxvY2sgYmVmb3JlIGNhbGxpbmcgbmZzNF9wdXRfc3RpZCgpLA0K
Pj4+Pj4+PiB0aGF0IGFsbG93cyBhbm90aGVyIEZSRUVfU1RBVEUgdG8gZmluZCB0aGUgc3RhdGVp
ZCBhZ2Fpbi4gVGhlIGZpcnN0IG9uZQ0KPj4+Pj4+PiB3aWxsIHByb2NlZWQgdG8gdGhlbiBmcmVl
IHRoZSBzdGF0ZWlkIHdoaWNoIGxlYWRzIHRvIGVpdGhlcg0KPj4+Pj4+PiB1c2UtYWZ0ZXItZnJl
ZSBvciBkZWNyZW1lbnRpbmcgYWxyZWFkeSB6ZXJvZCBjb3VudGVyLg0KPj4+Pj4+PiANCj4+Pj4+
Pj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+Pj4+PiANCj4+Pj4+PiBJIGFzc3VtZSB0
aGF0IHRoZSBicm9rZW4gY29tbWl0IGlzIHByZXR0eSBvbGQsIGJ1dCB0aGlzIGZpeCBkb2VzIG5v
dA0KPj4+Pj4+IGFwcGx5IGJlZm9yZSB2Ni45ICh3aGVyZSBzY19zdGF0dXMgaXMgaW50cm9kdWNl
ZCkuIEkgY2FuIGFkZA0KPj4+Pj4+ICIjIHY2LjkrIiB0byB0aGUgQ2M6IHN0YWJsZSB0YWcuDQo+
Pj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IEkgZG9uJ3Qga25vdy4gSXQgbG9va3MgbGlrZSBuZnNkNF9m
cmVlX3N0YXRlaWQgYWx3YXlzIHJldHVybmVkDQo+Pj4+PiBORlM0RVJSX0xPQ0tTX0hFTEQgb24g
YSBkZWxlZ2F0aW9uIHN0YXRlaWQgdW50aWwgM2YyOWNjODJhODRjLg0KPj4+Pj4gDQo+Pj4+Pj4g
QnV0IHdoYXQgZG8gZm9sa3MgdGhpbmsgYWJvdXQgYSBGaXhlczogdGFnPw0KPj4+Pj4+IA0KPj4+
Pj4+IENvdWxkIGJlIGUxY2ExMmRmYjFiZSAoIk5GU0Q6IGFkZGVkIEZSRUVfU1RBVEVJRCBvcGVy
YXRpb24iKSwgYnV0DQo+Pj4+Pj4gdGhhdCBkb2Vzbid0IGhhdmUgdGhlIHN3aXRjaCBzdGF0ZW1l
bnQsIHdoaWNoIHdhcyBhZGRlZCBieQ0KPj4+Pj4+IDJkYTFjZWM3MTNiYyAoIm5mc2Q0OiBzaW1w
bGlmeSBmcmVlX3N0YXRlaWQiKS4NCj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4gTWF5
YmUgdGhpcyBvbmU/DQo+Pj4+PiANCj4+Pj4+ICAgIDNmMjljYzgyYTg0YyBuZnNkOiBzcGxpdCBz
Y19zdGF0dXMgb3V0IG9mIHNjX3R5cGUNCj4+Pj4+IA0KPj4+Pj4gVGhhdCBwYXJ0aWN1bGFyIGJp
dCBvZiB0aGUgY29kZSAoYW5kIHRoZSBTQ19TVEFUVVNfQ0xPU0VEIGZsYWcpIHdhcw0KPj4+Pj4g
YWRkZWQgaW4gdGhhdCBwYXRjaCwgYW5kIEkgZG9uJ3QgdGhpbmsgeW91J2Qgd2FudCB0byBhcHBs
eSB0aGlzIHBhdGNoDQo+Pj4+PiB0byBhbnl0aGluZyB0aGF0IGRpZG4ndCBoYXZlIGl0Lg0KPj4+
PiANCj4+Pj4gT0ssIGlmIHdlIGJlbGlldmUgdGhhdCAzZjI5Y2M4MiBpcyB3aGVyZSB0aGUgbWlz
YmVoYXZpb3Igc3RhcnRlZCwNCj4+Pj4gdGhlbiBJIGNhbiByZXBsYWNlIHRoZSAiQ2M6IHN0YWJs
ZUAiIHdpdGggIkZpeGVzOiAzZjI5Y2M4MmE4NGMiLg0KPj4+IA0KPj4+IEkgYmVsaWV2ZSB0aGUg
bWlzYmVoYXZpb3VyIHN0YXJ0ZWQgd2l0aA0KPj4+IENvbW1pdDogYjBmYzI5ZDZmY2QwICgibmZz
ZDogRW5zdXJlIHN0YXRlaWRzIHJlbWFpbiB1bmlxdWUgdW50aWwgdGhleSBhcmUgZnJlZWQiKQ0K
Pj4+IGluIHYzLjE4Lg0KPj4+IA0KPj4+IFRoZSBidWcgaW4gdGhlIGN1cnJlbnQgY29kZSBpcyB0
aGF0IGl0IGFzc3VtZXMgdGhhdA0KPj4+IA0KPj4+ICAgICAgICBsaXN0X2RlbF9pbml0KCZkcC0+
ZGxfcmVjYWxsX2xydSk7DQo+Pj4gDQo+Pj4gYWN0dWFsbHkgcmVtb3ZlcyBmcm9tIHRoZSB0aGUg
ZGxfcmVjYWxsX2xydSwgYW5kIHNvIGEgcmVmZXJlbmNlIG11c3QgYmUNCj4+PiBkcm9wcGVkLiAg
QnV0IGlmIGl0IHdhc24ndCBvbiB0aGUgbGlzdCwgdGhlbiB0aGF0IGlzIHdyb25nLg0KPj4gDQo+
PiBJJ3ZlIGFjdHVhbGx5IGJlZW4gY2hhc2luZyBhIGRpZmZlcmVudCBwcm9ibGVtIChhIFVBRikg
YW5kIEJlbiBub3RpY2VkDQo+PiBhIHByb2JsZW0gd2l0aCBkb2luZyBhIGRvdWJsZSBmcmVlIChi
eSBkb3VibGUgZnJlZV9zdGF0ZWlkKSB3aGljaCB0aGlzDQo+PiBwYXRjaCBhZGRyZXNzZXMuIEJ1
dCwgdGhpcyBwYXJ0aWN1bGFyIGxpbmUgbGlzdF9kZWxfaW5pdCgpIGluDQo+PiBuZnNkNF9mcmVl
X3N0YXRlaWQoKSBoYXMgYmVlbiBib3RoZXJpbmcgbWUgYXMgSSB0aG91Z2h0IHRoaXMgYWNjZXNz
DQo+PiBzaG91bGQgYmUgZ3VhcmRlZCBieSB0aGUgInN0YXRlX2xvY2siPyBUaG91Z2ggSSBoYXZl
IHRvIGFkbWl0IEkndmUNCj4+IHRyaWVkIHRoYXQgYW5kIGl0IGRvZXNuJ3Qgc2VlbSB0byBoZWxw
IG15IFVBRiBwcm9ibGVtLiBBbnl3YXkgd2hlcmUNCj4+IEknbSBnb2luZyB3aXRoIGl0IHBlcmhh
cHMgdGhlIGd1YXJkICJpZg0KPj4gKCFsaXN0X2VtcHR5KCZkcC0+ZGxfcmVjYWxsX2xydSkpIiBp
cyBzdGlsbCBuZWVkZWQgKG5vdCBmb3IgZG91YmxlDQo+PiBmcmVlX3N0YXRlaWQgYnkgZnJvbSBv
dGhlciBwb3NzaWJpbGl0aWVzKT8NCj4gDQo+IGRsX3JlY2FsbF9scnUgaXMgYSBiaXQgY29uZnVz
aW5nLg0KPiANCj4gU29tZXRpbWVzIGl0IGlzIG9uIG5uLT5kZWxfcmVjYWxsX2xydSBpbiB3aGlj
aCBjYXNlIGl0IGlzIHByb3RlY3RlZCBieQ0KPiBzdGF0ZV9sb2NrLg0KPiBTb21ldGltZXMgaXQg
aXMgb24gY2xwLT5jbF9yZXZva2VkIGluIHdoaWNoIGNhc2UgaXQgaXMgcHJvdGVjdGVkIGJ5DQo+
IGNscC0+Y2xfbG9jay4NCj4gQW5kIHNvbWV0aW1lcyBpdCBpcyBvbiByZWFwbGlzdCB3aGljaCBk
b2Vzbid0IG5lZWQgcHJvdGVjdGlvbi4NCj4gDQo+IFNvIGl0IGlzIGltcG9ydGFudCB0byB1cGRh
dGUgdGhlIHN0YXRlIG9mIHRoZSBkZWxlZ2F0aW9uIHdoZW4gaXQgaXMNCj4gbW92ZWQgYmV0d2Vl
biBsaXN0cyBvciByZW1vdmVkIGZyb20gYSBsaXN0LiAgSSB0aGluayB3ZSBub3cgZG8gdGhhbmtz
IHRvDQo+IHlvdXIgcGF0Y2gsIGJ1dCBpdCB3b3VsZG4ndCBodXJ0IHRvIGF1ZGl0IGFsbCBhY2Nl
c3NlcyBhZ2Fpbi4uLg0KPiANCj4gTmVpbEJyb3duDQo+IA0KPiANCj4+IA0KPj4gSSB3YXMgd29u
ZGVyaW5nIGlmIHRoZSBuZnNkNF9mcmVlX3N0YXRlaWQoKSBzb21laG93IGNvdWxkIHN0ZWFsIHRo
ZQ0KPj4gZW50cmllcyBmcm9tIHRoZSBsaXN0IHdoaWxlIHRoZSBsYXVuZHJvbWF0IGlzIGdvaW5n
IHRocnUgdGhlDQo+PiByZXZvY2F0aW9uIHByb2Nlc3MuIFRoZSBwcm9ibGVtIEkgYmVsaWV2ZSBp
cyB0aGF0IHRoZSBsYXVuZHJvbWF0DQo+PiB0aHJlYWQgbWFya3MgdGhlIGRlbGVnYXRpb24gInJl
dm9rZWQiIGJ1dCBzb21laG93IG5ldmVyIGVuZHMgdXANCj4+IGNhbGxpbmcgZGVzdHJveV9kZWxl
Z2F0aW9uKCkgKGRlc3RveV9kZWxlZ2F0aW9uIGlzIHRoZSBwbGFjZSB0aGF0DQo+PiBmcmVlcyB0
aGUgbGVhc2UgLS0gYnV0IGluc3RlYWQgd2UgYXJlIGxlZnQgd2l0aCBhIGxlYXNlIG9uIHRoZSBm
aWxlDQo+PiB3aGljaCBjYXVzZXMgYSBuZXcgb3BlbiB0byBjYWxsIGludG8gYnJlYWtfbGVhc2Uo
KSB3aGljaCBlbmRzIHVwIGRvaW5nDQo+PiBhIFVBRiBvbiBhIGZyZWVkIGRlbGVnYXRpb24gc3Rh
dGVpZCAtLSB3aGljaCB3YXMgZnJlZWQgYnkgdGhlDQo+PiBmcmVlX3N0YXRlaWQpLg0KDQpJIGFt
IHByZXBhcmluZyBhbiBuZnNkLWZpeGVzIHB1bGwgcmVxdWVzdCBmb3IgTGludXMuDQpUaGlzIGZp
eCBpcyBpbiB0aGF0IHNlcmllcy4gTGV0IG1lIGtub3cgaW4gdGhlIG5leHQNCmRheSBvciB0d28g
aWYgYW55IGNoYW5nZXMgYXJlIG5lY2Vzc2FyeSBvciB0aGF0IGl0DQpzaG91bGQgYmUgZHJvcHBl
ZC4NCg0KDQo+Pj4gU28gYSAiaWYgKCFsaXN0X2VtcHR5KCZkcC0+ZGxfcmVjYWxsX2xydSkpIiBn
dWFyZCBtaWdodCBhbHNvIGZpeCB0aGUNCj4+PiBidWcgKHRob3VnaCBhZGRpbmcgU0NfU1RBVFVT
X0NMT1NFRCBpcyBhIGJldHRlciBmaXggSSB0aGluaykuDQo+Pj4gDQo+Pj4gUHJpb3IgdG8gdGhl
IGFib3ZlIDMuMTcgY29tbWl0LCB0aGUgcmVsZXZhbnQgY29kZSB3YXMNCj4+PiANCj4+PiBzdGF0
aWMgdm9pZCBkZXN0cm95X3Jldm9rZWRfZGVsZWdhdGlvbihzdHJ1Y3QgbmZzNF9kZWxlZ2F0aW9u
ICpkcCkNCj4+PiB7DQo+Pj4gICAgICAgIGxpc3RfZGVsX2luaXQoJmRwLT5kbF9yZWNhbGxfbHJ1
KTsNCj4+PiAgICAgICAgcmVtb3ZlX3N0aWQoJmRwLT5kbF9zdGlkKTsNCj4+PiAgICAgICAgbmZz
NF9wdXRfZGVsZWdhdGlvbihkcCk7DQo+Pj4gfQ0KPj4+IA0KPj4+IHNvIHRoZSByZXZva2VkIGRl
bGVnYXRpb24gd291bGQgYmUgcmVtb3ZlZCAocmVtb3ZlX3N0aWQpIGZyb20gdGhlIGlkcg0KPj4+
IGFuZCBhIHN1YnNlcXVlbnQgRlJFRV9TVEFURUlEIHJlcXVlc3Qgd291bGQgbm90IGZpbmQgaXQu
DQo+Pj4gVGhlIGNvbW1pdCByZW1vdmVkIHRoZSByZW1vdmVfc3RpZCgpIGNhbGwgYnV0IGRpZG4n
dCBkbyBhbnl0aGluZyB0bw0KPj4+IHByZXZlbnQgdGhlIGZyZWVfc3RhdGVpZCBiZWluZyByZXBl
YXRlZC4NCj4+PiBJbiB0aGF0IGtlcm5lbCBpdCBtaWdodCBoYXZlIGJlZW4gYXBwcm9wcmlhdGUg
dG8gc2V0DQo+Pj4gIGRwLT5kbF9zdGlkLnNjX3R5cGUgPSBORlM0X0NMT1NFRF9ERUxFR19TVElE
Ow0KPj4+IHdhcyBkb25lIHRvIHVuaGFzaF9kZWxlZ2F0aW9uKCkgaW4gdGhhdCBwYXRjaC4NCj4+
PiANCj4+PiBTbyBJIHRoaW5rIHdlIHNob3VsZCBkZWNsYXJlDQo+Pj4gRml4ZXM6IGIwZmMyOWQ2
ZmNkMCAoIm5mc2Q6IEVuc3VyZSBzdGF0ZWlkcyByZW1haW4gdW5pcXVlIHVudGlsIHRoZXkgYXJl
IGZyZWVkIikNCj4+PiANCj4+PiBhbmQgYmUgcHJlcGFyZWQgdG8gcHJvdmlkZSBhbHRlcm5hdGUg
cGF0Y2hlcyBmb3Igb2xkZXIga2VybmVscy4NCj4+PiANCj4+PiBOZWlsQnJvd24NCj4+PiANCj4+
Pj4gDQo+Pj4+IA0KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8b2tv
cm5pZXZAcmVkaGF0LmNvbT4NCj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+IGZzL25mc2QvbmZzNHN0YXRl
LmMgfCAxICsNCj4+Pj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pj4+Pj4+
IA0KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZz
NHN0YXRlLmMNCj4+Pj4+Pj4gaW5kZXggYWMxODU5YzdjYzlkLi41NmIyNjE2MDhhZjQgMTAwNjQ0
DQo+Pj4+Pj4+IC0tLSBhL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4+Pj4+Pj4gKysrIGIvZnMvbmZz
ZC9uZnM0c3RhdGUuYw0KPj4+Pj4+PiBAQCAtNzE1NCw2ICs3MTU0LDcgQEAgbmZzZDRfZnJlZV9z
dGF0ZWlkKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdCBuZnNkNF9jb21wb3VuZF9zdGF0
ZSAqY3N0YXRlLA0KPj4+Pj4+PiAgICAgICAgc3dpdGNoIChzLT5zY190eXBlKSB7DQo+Pj4+Pj4+
ICAgICAgICBjYXNlIFNDX1RZUEVfREVMRUc6DQo+Pj4+Pj4+ICAgICAgICAgICAgICAgIGlmIChz
LT5zY19zdGF0dXMgJiBTQ19TVEFUVVNfUkVWT0tFRCkgew0KPj4+Pj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICBzLT5zY19zdGF0dXMgfD0gU0NfU1RBVFVTX0NMT1NFRDsNCj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICBzcGluX3VubG9jaygmcy0+c2NfbG9jayk7DQo+Pj4+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgZHAgPSBkZWxlZ3N0YXRlaWQocyk7DQo+Pj4+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgbGlzdF9kZWxfaW5pdCgmZHAtPmRsX3JlY2FsbF9scnUpOw0KPj4+
Pj4+PiAtLQ0KPj4+Pj4+PiAyLjQzLjUNCj4+Pj4+Pj4gDQo+Pj4+Pj4gDQo+Pj4+PiANCj4+Pj4+
IC0tDQo+Pj4+PiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPj4+PiANCj4+Pj4g
LS0NCj4+Pj4gQ2h1Y2sgTGV2ZXINCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

