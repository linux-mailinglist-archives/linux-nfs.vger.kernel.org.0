Return-Path: <linux-nfs+bounces-4374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9191AE8F
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 19:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7777E281E43
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E0119A2BB;
	Thu, 27 Jun 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XulQtSOR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iaAx758l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21519A28A
	for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510681; cv=fail; b=Nsy9I9fnd/gJivh+KYaW3ZUNAf2PrY6U4jq9xAQRIE2veAArYYqt9xseYhXyHgHhWNZnjEItF/OcrxnGPyI+UwW9CB8XTzu4VlThROBuEYUbJ71apjwfNd9bLKlTpSi+ChQjSQFBJDK9q8SLYOqlZwxEY3i/2STMx/UJTxN/kFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510681; c=relaxed/simple;
	bh=By8Rq14F3QVnomSh4a2QJX+rDHGX0lIN3AYDfAGqnw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jlodPPO6TYCYxcNaFCGJfK6TyHFBPQFgUJosZ2g1bvI4A9SjffOPs618CI5o3gbmu1sSb2xVZoCunsOwOuU8VGi19whUxzlEp90xmklUJ5BYahRBDuYLE3J+8uc9RJtdavSQbDhwNgJs1rTLeCZMdxT+yY5XNUtZdztbMSxA9QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XulQtSOR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iaAx758l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtXqp027178;
	Thu, 27 Jun 2024 17:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=By8Rq14F3QVnomSh4a2QJX+rDHGX0lIN3AYDfAGqn
	w0=; b=XulQtSORz0THbrTAXJv17Wtvd9gaYnogEA++XTbLg0Hs/uICecwv7dLue
	VjLrmhxpaP9kd21RMA1lxJiVBF43NDkj59XYFUxdnkaYkldYnNlCLFNuPAEwtIxj
	Yx1xPp2EKEF+RyrpVZASwXh5JJ8bEDVFfXsOWUkhmz6CkSByIO7bujKbdOaXRVWu
	SjWz9cOamxt9ALh9AhJffN5jhTKwV0xwdpuaHWeXshKltjECJ828a6uNYy9GOICR
	gzUYErC/ZcazWavlFn8MtXc8HUyZOQ34CWqgaQWC0J/w2Oc2mjR1PJ2mIhFy0Hbb
	7G9WcWTrGAPSqqQIsoylrOHV2kKYA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg9ebe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:51:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RH5Cuu021843;
	Thu, 27 Jun 2024 17:51:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys7p9bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8KGon7PRHhNEA++6kihUum7H0xCLwTVSlHpXINf1Fw/W4rr7zO0ihN7jaqPvmWzBHpgz4uFdD/UIFweksmfgSj1WNfuNZnUUYxrHqU932dYogVeHgd5y19wzmSdI0dSIhAlFfRDGPVv9UoVAjC7KXqo7ctc/USOddO603h+lVyZxPEVaBe5SFlbjmXG1FqPMeWOzprAnRI8fWmMQ0OHM130wzXLjntLzFcfwqRZdhMhbS/EkyDm9stAamfaorR61cBr1JAwj4vV6REulJ6SK44zKXyCxGV+5RGDzzv33m40b8PaxJG1QNnPpXoD4/7fWjVwIG7IYydfnrHJjBAGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=By8Rq14F3QVnomSh4a2QJX+rDHGX0lIN3AYDfAGqnw0=;
 b=IJgjmkzuSNN3uT0+JiO5rbEIdDmyU78HCNHliXyw7M6DqVI1QZQRSXM+VgZGpr8ycVttuzex8lVLkTsetrSDicFfzg8TykaKGLj59yCn1hgIOj9YuuLRHf7UlMPD8NuWQEJnB/cuUBfcFqzc7QCKgClZywm1kTYf+QCMW4pqkzvF8PH3s0s/reCU+lqG2dxMzSO72Ba/nd0BbYTz7IAS2jhr4CDl8NqD9FnNQl0ZeQsAweA/Z8JLsJpvqhSa7Pc4vpLLLgeqMogbAPP9tUJPEtdiKNMSAsSkkvTJeNogeFjgV6tQTF62+dkA3FKDJxOG4iOlp4ASkYsjeWj8yQkDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=By8Rq14F3QVnomSh4a2QJX+rDHGX0lIN3AYDfAGqnw0=;
 b=iaAx758lx+N8SqgmnF4P7n+sLc7Hwj8QJ4eDNkxzyGWaWtXuDIzkxkcNFWpdw7p59OwzjFS9zXmgwbdRYfI+8eteHb5c4Tuj3FO/Os0pyZ997GkcgAUPxN9WviAn2/D0ys+Otf0QdR9GZeDXxFo7lKOpVkkGBJ8kuawy8hIAYwE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6355.namprd10.prod.outlook.com (2603:10b6:510:1b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 17:50:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 17:50:57 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, Neil
 Brown <neilb@suse.de>,
        "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v8 07/18] nfsd: add "localio" support
Thread-Topic: [PATCH v8 07/18] nfsd: add "localio" support
Thread-Index: AQHax/Yk8qbCJnBvfEikS8P31EOgBbHbwuSAgAAFSICAABaDgIAABngA
Date: Thu, 27 Jun 2024 17:50:57 +0000
Message-ID: <639F4CEB-04FD-44D1-A781-06D3223B01B2@oracle.com>
References: <20240626182438.69539-1-snitzer@kernel.org>
 <20240626182438.69539-8-snitzer@kernel.org>
 <618117cfff2c4581cdcda15586f3f771e37faebc.camel@kernel.org>
 <Zn2OJ5UynQmwMGEA@tissot.1015granger.net> <Zn2hCU59Zxze79yW@kernel.org>
In-Reply-To: <Zn2hCU59Zxze79yW@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6355:EE_
x-ms-office365-filtering-correlation-id: 7a8f5e5f-76c7-4053-d6fb-08dc96d1b309
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UWR6dmZEWFFYMmRPNTlYTlNpZWVWQ2JhZVNhdVF0Q0tqSHAxVTdEWE5IWW1U?=
 =?utf-8?B?TlhFNHRqeFQxa01RQmxtT2tkdVpkb1dnUlRjY2lZYTd1Qm5TanA3QW9hYXhL?=
 =?utf-8?B?WWs0ZFVXeWpScWQxMDRDcloyM2NTV2pjMTNKQjNvbWk5SXJUbmQ4blZPaFV6?=
 =?utf-8?B?R0hMT1k3elNvS0JwdCsweHIxckhYZC9WQ2xhVGk2ZUZ0WERhWmJ1L2crdk8x?=
 =?utf-8?B?UkJyWnY1ZWlsRGYzQVpPY2NleW40K3JUWUlYWVZhQnVaUWU5ZDBRYndmaGov?=
 =?utf-8?B?ZThWdVhsQ0ZFejZmQ2NLUFVvb01wbXNHTnppTVVuVHRmTUhMQVJEL29YZU9N?=
 =?utf-8?B?MXV5Z3lwOVdtVlc5cjRBcUE4c0pJUmJ0TVFKY1habjNnNnQ4MnlRS0tzN1RU?=
 =?utf-8?B?S2s5ellHRTUyOTRzUlgzQ2JYSVB0ZjJNY3NzUE0vS3M1VjhwZjQySDl0Q0g4?=
 =?utf-8?B?QllFNUdSUGtnbmVQdC9LWTkxbThOaHVLOUthUVR3SncvTkM5ckh0ek91NnZz?=
 =?utf-8?B?d1ZKN2ZHZGFScFdiZ25SNXU4ZFdyUGRqeUFTbEd5ZitTcW1rMjZDS2VQZWM5?=
 =?utf-8?B?VUZmTGFqa1k0cHhvNmlxSVViYzRJYzREZWVQVWkwL1YvKzdHN3R1bjZmS0Np?=
 =?utf-8?B?QStLNkpTZ0d3SFFSSDlkQzRDRnBPZjF1VERORG1MaFlPMWJzYm9adTNsZzJn?=
 =?utf-8?B?VytCdlBIVkIxR0tMNVpYV3Y5MUJZOVgrVU91SE1DMm9sY2g0VWgvVHg2ak5k?=
 =?utf-8?B?NVc2WXJGNUs5Zy9QL0Q2ajExTDF3dHpSemFQUlh1QWdEayt3SW1seE9MS29w?=
 =?utf-8?B?OExBbVE2REhFWE9SNk9tZ0JKY1J1UC9zeHlpWlBQWGtpNHZEZDNlWURjcnhN?=
 =?utf-8?B?RVRvOU9tcVMzUjJ5ekYvaFE0VFZ5WFpqQS9QZFNpNStod0ZIaktMOEVYeUU4?=
 =?utf-8?B?YkNSakVjdk5vdVU4aVdtZ0tVYis5cnVPTTFXclllenpwbzhsRE5GcXlpczF2?=
 =?utf-8?B?S3lzaGxEUnIzUTJuNXc1Qy9pVE1BVTlQMzdIVEZPOEFqaFJVRnBuRzNPdHBt?=
 =?utf-8?B?ekFXSHE3MzFaYnpEeVhScGs1MlJXaFkzWG1YZDlDSkJrWjlsRnRwNUJaUDcv?=
 =?utf-8?B?UkNLdzRmMmZKbXMzTEE3RSt5RGhRU2U2YUsyWHl3R3dhVVgwd1ZEZEluVzAz?=
 =?utf-8?B?ZmtvbkdXalM0SnowTnBWTXhTck9ydStuajUyREE0RnZHVnkyVFpzUnVjZk00?=
 =?utf-8?B?QkxSRWp0UWc4VDBaTVMraUJubEZDT0xQWXRYRlkwZ2d0NkJBSjRVSjhJWnow?=
 =?utf-8?B?MUc5d3FQZTNCNmdpWjhxV01LNHBONzIzQ0RpbkVLbWk2cGNRZEVKcDRqR3Q5?=
 =?utf-8?B?TmJNS0V6NndBUXpkNG9kd3k1NCtzUXY0S2ZMK0ZLU2VCbW5mamhiUWpBMmwx?=
 =?utf-8?B?VzREYkU3OE1KUUUzYW41UkFkWEpKQXU4aE5INlZsTGhmUXlkQkhvV2lRaU1H?=
 =?utf-8?B?UGhyVDdTYzk1UWljSEtNcmNpQkVPTVFTV1RjQ2hKVy9kczZvNUc3UFNXZG81?=
 =?utf-8?B?cXBseXord0hQRy9MWTE0ZTYvNjB0T3JKWi84UzB3WXZ6Zm5rNU4yQ1gzRmk0?=
 =?utf-8?B?NW44RzJISmV5ejE3ZGI5ZFpaMGFibUJZSEw4S1gvSVBFelNWa3FBRDVtRHBE?=
 =?utf-8?B?ejM2TDRqZVNHeTJ1ZjYrQlhZOVY4ekdOUDk4KzQ0M3ZGQzNDZnRPRFFDZkZr?=
 =?utf-8?B?aCtrOEpnRXBaUE1Ya3Bka1QyYzU3ZldkTDk4bldRbTJLWThrV2tLajg2ZVZo?=
 =?utf-8?B?QTBKQnZkaWlEaFd1Y2JUcS95ZVkyOVplQ3M3VWtMWWZzVFUwbUhLV3p3WEhp?=
 =?utf-8?B?b05INmhWVlRoWHVqSnZ3US9Qd0lrZVpOekRhSWlNc21sRHc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RlVJdEFneStTa3RXSURxcUJQejdmYTZOQWRTVlVHUFJ6WG1ZdGRUSVlUL2lU?=
 =?utf-8?B?U1g4UUxROHh6aXk0L0JmaDYxN2dkVkxSZ1R1L0syTVJEMnZ0alFwUzR2TnA5?=
 =?utf-8?B?bzdQaUxrV1pXR3RhNHhJenlWdyt1cUxNUDg4OVVpTXc2eHorZm9OOFNYa21D?=
 =?utf-8?B?Z2c1bDhkNy9pL3lEZVFXRG5pa0ZJeUdNSS9wNlJORlFXdVJIMURKQjViZHRK?=
 =?utf-8?B?U0ZyVlRtNVdrL3ZLejdSak1LY0MwQnBwVU9haUdIQ1ppanVMZU4waTdsanZo?=
 =?utf-8?B?VVNWN29IYnR1ZXFvOWNPSUhrV1U2cHhGbzhrVXJvYnFNc2tuRnFCZUlTYnRL?=
 =?utf-8?B?THZ3U1BZUkV1U1h5Q243eUJldTZCT0dYUURGLy9iczN3RnhCSkl0OUd0TWZI?=
 =?utf-8?B?aTh4RE5vbWhBS3JSU3d0Zm9ZT2gzbnFWUVluMzdrbmkvNFRqL2ZjTm1KTXI1?=
 =?utf-8?B?TFI2RDBkdnhLQ0Y5em1aTm1uU2FWN2ZENzFXZkZMSXpQTnpxZU5tSmY2cU9J?=
 =?utf-8?B?U0NuVkg5VS9uR2NMMjI3WTV1MHJNcnZTOXFFdXQxdlArNmhlNWt0Q2l2MGhH?=
 =?utf-8?B?NEVYa3VreWI2T3ltTXNaOHpJSDVnSTJxZEpjVWlpcDZrQ0YxM2hXdmlNR1JB?=
 =?utf-8?B?ZSttenRleGxIN2orRTY4YmpaU2s5VG1ZMG0zRGI1NFFxcUZJSC85NmVKK3JD?=
 =?utf-8?B?cG5SWnRsUFZGTWhNY2xGQmsvZWY5V25sb1VkOTl5K0tnR3JjbzZ2ZDgyaFc4?=
 =?utf-8?B?WGNSc2xlOU5LMm9PSDVtVkhvb1NoalhyMXRQMEVDVGFrRUhhSUcxMG9GdXBz?=
 =?utf-8?B?Zk50enM2bmowNzhLTTVuaXIzYW0zeXZFMTN0TS9vVlpUQ1ZtU1YxWWVKSmRh?=
 =?utf-8?B?d3NnM01OMjhZNzRYZE5UcVNMYjJtRHprVldFRmJPa0dlQU5QOERsaEk5STVC?=
 =?utf-8?B?M2xnVzU4cVlDQ1VUL2pPV20zTXZ0VzFldmg3TTBMVXNDdXhMVkV1QWtPdjlK?=
 =?utf-8?B?N1VrSmtBb3JrT250T0ZJUS9JaGNrTjFTeW50aTZrU0pQM0t6aWhJWUxucXJk?=
 =?utf-8?B?bEJaTzNaSzhIKy9QMnpTRWc3UndicWw0NGxhYmlLNUlBVEpmOFJCNFdUd3Zl?=
 =?utf-8?B?TjRRY3Jlb2RXYTYyNnVhcmNNVDVoTVBkRTZ6dm9iQzZVanlWMnFZM0xHZVlV?=
 =?utf-8?B?VFVZcFFEMmwvTjJJNFcvVnZXb3VCbm9Yd1B6VXJuTS9NZDd5L3FyK24rdjg2?=
 =?utf-8?B?NWhTYjIxVXljeUdZcXZEY2x4TnlKRnpTcXlzZkdLbld5NUsxODc5S2hpUmtS?=
 =?utf-8?B?U0xEQllwMmF0RVlXMG5LK1pORlFvNjVPRVBTcWNEazExeDZwVmdBdE1EK0dp?=
 =?utf-8?B?VVdrYTZiUG5oemdBa3R0SmlsTklGK2hYTXlEaFdEdmJieXJxUUJSVWNmSGlB?=
 =?utf-8?B?cUloei9KZXowMjFCcjh1WWIySnRZTEl5N2t6bkNLOU83RDhOYjdsWk5Bakl1?=
 =?utf-8?B?Z3NFY1AwTUpCZFh3MWhOL2F3dVNTWHdvZXBrR3plcm5LT3hRUTg5a2tqUUIy?=
 =?utf-8?B?Rk1zaXA4NFlac0hCWm53NUorN1JlRUhhYXc5SHJHRlpKUVQrcEpLdGsyZzJv?=
 =?utf-8?B?WkxPcjBHUUQrZE9uR1RpK2FxNTFEbm1TTmY4ZXVmVVh0OGpWWVBmV2dxRHJM?=
 =?utf-8?B?M2ZJQWZ0UjBsQkJFcUF1MHJ2WnJsVUJXUlhvZHB4bVY1d2JtUGJOTW5oakNv?=
 =?utf-8?B?eE9wVVNPVGRFZmYzK3k1RWVJYXc1L1FzK1BjRTZhcTNHV1B2T3VaOGtGOThE?=
 =?utf-8?B?YmJ3MXRxSTFlMEh4dEtXOUU1bmsrdmlNSmdCQzJ4Qng5N3hwL0VvUnBiRWpk?=
 =?utf-8?B?b3czTWJZd3pYanNzQ3laL0t2VGNSMVlISkdzY3NOdU5aUTI4czFPWjVpdWxI?=
 =?utf-8?B?bVRRbVh3NW1USFNEUlMvaTA5bkc5YXErKzV3ZmdmQmFFVUIvWGVqMHNMZ1RY?=
 =?utf-8?B?K3htSHpNYVpneHpYMVNvcHlpOHp0aTR6cmt4TmhZZWIva2xnM05NdjV3RExG?=
 =?utf-8?B?YTdWU2NoZzExRlR5TktHenFnTDV6MmMzVElNVnFUdmVJUVgvaTg5Ukg2Q0J1?=
 =?utf-8?B?TGNJMlZuU0dFR054U0daS1BheHQ1V3dJQkhIcE44T2d5SjAxdVBFTmV6L0pC?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8CE60B6AF0519489507FC5DFEB28674@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vMnljyxdj/4SRB4byy38G/HJxcDwdviBf/xYnEfYYYMzWDgetjObndz7UPXo4VMkGk9pm8MkOvo1SBNouk/nj6w/hlFwRf20sbXg6H7+sw65DOXh5rQcWgwDALNKqGpLpLOiIW2quwJZ+owbgYIef7mJyQquc6ErNU1I23OxR1pbbH2IfwN9RpisdpaF1vmwdoiCXPJnttpOcNMqMFtbmbFP2PRX+T0x4TVlfJctdojoUi9aw8CJsrDa5Nm24aj9mBw6eq1mGTIRJarBLG9jzhakLT0aQnNW2fiPPffkpzNDt6Nl1WVdmEDjOHaABtMLFOoda+pdU1DAx5lgfCHD2GFbct6OpcY0wAKQXWqv0Du9SkNh+s9uXNXB/zEiEt2J1w6KuH0neSBc4YpQLicCWq5QDMOVeWQiBjnMM43DPloVo6kaS5jXIQK0J4bUfK68KzHohW6auW0pg/meibv6OLWvicsRdP9sF6nJq+BX6wTrFiwuKvERIkroO12kTstYpD3xwolFw+/0OBKeklHdHUctEIMIsty7Ag2as8+28aAS64NP57J1pM55wqID3bc+e76FzF3B1JAKojH/cZ3IPLArDDZgb4gUvYCHhvbxYzU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8f5e5f-76c7-4053-d6fb-08dc96d1b309
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 17:50:57.5561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gef0YOZOa5LiqxDGXeggiM4dKAb/+Rq/MysGZY7+O1zP7QALohxuhLBzD0pdG3n11Rc/Ic57ucIGa1oY620gRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_13,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270133
X-Proofpoint-ORIG-GUID: 27qEoTSnapW9SsCuypVaoGvPpXY2tD8Y
X-Proofpoint-GUID: 27qEoTSnapW9SsCuypVaoGvPpXY2tD8Y

DQoNCj4gT24gSnVuIDI3LCAyMDI0LCBhdCAxOjI34oCvUE0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVuIDI3LCAyMDI0IGF0IDEyOjA3
OjAzUE0gLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4gT24gVGh1LCBKdW4gMjcsIDIwMjQg
YXQgMTE6NDg6MDlBTSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+Pj4gT24gV2VkLCAyMDI0
LTA2LTI2IGF0IDE0OjI0IC0wNDAwLCBNaWtlIFNuaXR6ZXIgd3JvdGU6DQo+Pj4+IFBhc3MgdGhl
IHN0b3JlZCBjbF9uZnNzdmNfbmV0IGZyb20gdGhlIGNsaWVudCB0byB0aGUgc2VydmVyIGFzDQo+
Pj4+IGZpcnN0IGFyZ3VtZW50IHRvIG5mc2Rfb3Blbl9sb2NhbF9maCgpIHRvIGVuc3VyZSB0aGUg
cHJvcGVyIG5ldHdvcmsNCj4+Pj4gbmFtZXNwYWNlIGlzIHVzZWQgZm9yIGxvY2FsaW8uDQo+Pj4+
IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBXZXN0b24gQW5kcm9zIEFkYW1zb24gPGRyb3NAcHJpbWFy
eWRhdGEuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIFRhbyA8dGFvLnBlbmdAcHJpbWFy
eWRhdGEuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMYW5jZSBTaGVsdG9uIDxsYW5jZS5zaGVs
dG9uQGhhbW1lcnNwYWNlLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0
IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBN
aWtlIFNuaXR6ZXIgPHNuaXR6ZXJAa2VybmVsLm9yZz4NCj4+Pj4gLS0tDQo+Pj4+ICBmcy9uZnNk
L01ha2VmaWxlICAgIHwgICAxICsNCj4+Pj4gIGZzL25mc2QvZmlsZWNhY2hlLmMgfCAgIDIgKy0N
Cj4+Pj4gIGZzL25mc2QvbG9jYWxpby5jICAgfCAyNDYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+Pj4gIGZzL25mc2QvbmZzc3ZjLmMgICAgfCAgIDEgKw0K
Pj4+PiAgZnMvbmZzZC90cmFjZS5oICAgICB8ICAgMyArLQ0KPj4+PiAgZnMvbmZzZC92ZnMuaCAg
ICAgICB8ICAgOSArKw0KPj4+PiAgNiBmaWxlcyBjaGFuZ2VkLCAyNjAgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBmcy9uZnNkL2xvY2FsaW8u
Yw0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvTWFrZWZpbGUgYi9mcy9uZnNkL01h
a2VmaWxlDQo+Pj4+IGluZGV4IGI4NzM2YTgyZTU3Yy4uNzhiNDIxNzc4YTc5IDEwMDY0NA0KPj4+
PiAtLS0gYS9mcy9uZnNkL01ha2VmaWxlDQo+Pj4+ICsrKyBiL2ZzL25mc2QvTWFrZWZpbGUNCj4+
Pj4gQEAgLTIzLDMgKzIzLDQgQEAgbmZzZC0kKENPTkZJR19ORlNEX1BORlMpICs9IG5mczRsYXlv
dXRzLm8NCj4+Pj4gIG5mc2QtJChDT05GSUdfTkZTRF9CTE9DS0xBWU9VVCkgKz0gYmxvY2tsYXlv
dXQubyBibG9ja2xheW91dHhkci5vDQo+Pj4+ICBuZnNkLSQoQ09ORklHX05GU0RfU0NTSUxBWU9V
VCkgKz0gYmxvY2tsYXlvdXQubyBibG9ja2xheW91dHhkci5vDQo+Pj4+ICBuZnNkLSQoQ09ORklH
X05GU0RfRkxFWEZJTEVMQVlPVVQpICs9IGZsZXhmaWxlbGF5b3V0Lm8gZmxleGZpbGVsYXlvdXR4
ZHIubw0KPj4+PiArbmZzZC0kKENPTkZJR19ORlNEX0xPQ0FMSU8pICs9IGxvY2FsaW8ubw0KPj4+
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9maWxlY2FjaGUuYyBiL2ZzL25mc2QvZmlsZWNhY2hlLmMN
Cj4+Pj4gaW5kZXggYWQ5MDgzY2ExNDRiLi45OTYzMWZhNTY2NjIgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2ZzL25mc2QvZmlsZWNhY2hlLmMNCj4+Pj4gKysrIGIvZnMvbmZzZC9maWxlY2FjaGUuYw0KPj4+
PiBAQCAtNTIsNyArNTIsNyBAQA0KPj4+PiAgI2RlZmluZSBORlNEX0ZJTEVfQ0FDSEVfVVAgICAg
ICAoMCkNCj4+Pj4gIA0KPj4+PiAgLyogV2Ugb25seSBjYXJlIGFib3V0IE5GU0RfTUFZX1JFQUQv
V1JJVEUgZm9yIHRoaXMgY2FjaGUgKi8NCj4+Pj4gLSNkZWZpbmUgTkZTRF9GSUxFX01BWV9NQVNL
IChORlNEX01BWV9SRUFEfE5GU0RfTUFZX1dSSVRFKQ0KPj4+PiArI2RlZmluZSBORlNEX0ZJTEVf
TUFZX01BU0sgKE5GU0RfTUFZX1JFQUR8TkZTRF9NQVlfV1JJVEV8TkZTRF9NQVlfTE9DQUxJTykN
Cj4+Pj4gIA0KPj4+PiAgc3RhdGljIERFRklORV9QRVJfQ1BVKHVuc2lnbmVkIGxvbmcsIG5mc2Rf
ZmlsZV9jYWNoZV9oaXRzKTsNCj4+Pj4gIHN0YXRpYyBERUZJTkVfUEVSX0NQVSh1bnNpZ25lZCBs
b25nLCBuZnNkX2ZpbGVfYWNxdWlzaXRpb25zKTsNCj4+Pj4gZGlmZiAtLWdpdCBhL2ZzL25mc2Qv
bG9jYWxpby5jIGIvZnMvbmZzZC9sb2NhbGlvLmMNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5iYTkxODc3MzU5NDcNCj4+Pj4gLS0tIC9kZXYvbnVs
bA0KPj4+PiArKysgYi9mcy9uZnNkL2xvY2FsaW8uYw0KPj4+PiBAQCAtMCwwICsxLDI0NiBAQA0K
Pj4+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPj4+PiArLyoN
Cj4+Pj4gKyAqIE5GUyBzZXJ2ZXIgc3VwcG9ydCBmb3IgbG9jYWwgY2xpZW50cyB0byBieXBhc3Mg
bmV0d29yayBzdGFjaw0KPj4+PiArICoNCj4+Pj4gKyAqIENvcHlyaWdodCAoQykgMjAxNCBXZXN0
b24gQW5kcm9zIEFkYW1zb24gPGRyb3NAcHJpbWFyeWRhdGEuY29tPg0KPj4+PiArICogQ29weXJp
Z2h0IChDKSAyMDE5IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbT4NCj4+Pj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBNaWtlIFNuaXR6ZXIgPHNuaXR6ZXJA
aGFtbWVyc3BhY2UuY29tPg0KPj4+PiArICovDQo+Pj4+ICsNCj4+Pj4gKyNpbmNsdWRlIDxsaW51
eC9leHBvcnRmcy5oPg0KPj4+PiArI2luY2x1ZGUgPGxpbnV4L3N1bnJwYy9zdmNhdXRoX2dzcy5o
Pg0KPj4+PiArI2luY2x1ZGUgPGxpbnV4L3N1bnJwYy9jbG50Lmg+DQo+Pj4+ICsjaW5jbHVkZSA8
bGludXgvbmZzLmg+DQo+Pj4+ICsjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+DQo+Pj4+ICsNCj4+
Pj4gKyNpbmNsdWRlICJuZnNkLmgiDQo+Pj4+ICsjaW5jbHVkZSAidmZzLmgiDQo+Pj4+ICsjaW5j
bHVkZSAibmV0bnMuaCINCj4+Pj4gKyNpbmNsdWRlICJmaWxlY2FjaGUuaCINCj4+Pj4gKw0KPj4+
PiArI2RlZmluZSBORlNEREJHX0ZBQ0lMSVRZIE5GU0REQkdfRkgNCj4+Pj4gKw0KPj4+PiArLyoN
Cj4+Pj4gKyAqIFdlIG5lZWQgdG8gdHJhbnNsYXRlIGJldHdlZW4gbmZzIHN0YXR1cyByZXR1cm4g
dmFsdWVzIGFuZA0KPj4+PiArICogdGhlIGxvY2FsIGVycm5vIHZhbHVlcyB3aGljaCBtYXkgbm90
IGJlIHRoZSBzYW1lLg0KPj4+PiArICogLSBkdXBsaWNhdGVkIGZyb20gZnMvbmZzL25mczJ4ZHIu
YyB0byBhdm9pZCBuZWVkbGVzcyBibG9hdCBvZg0KPj4+PiArICogICBhbGwgY29tcGlsZWQgbmZz
IG9iamVjdHMgaWYgaXQgd2VyZSBpbiBpbmNsdWRlL2xpbnV4L25mcy5oDQo+Pj4+ICsgKi8NCj4+
Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgew0KPj4+PiArIGludCBzdGF0Ow0KPj4+PiArIGludCBl
cnJubzsNCj4+Pj4gK30gbmZzX2NvbW1vbl9lcnJ0YmxbXSA9IHsNCj4+Pj4gKyB7IE5GU19PSywg
MCB9LA0KPj4+PiArIHsgTkZTRVJSX1BFUk0sIC1FUEVSTSB9LA0KPj4+PiArIHsgTkZTRVJSX05P
RU5ULCAtRU5PRU5UIH0sDQo+Pj4+ICsgeyBORlNFUlJfSU8sIC1FSU8gfSwNCj4+Pj4gKyB7IE5G
U0VSUl9OWElPLCAtRU5YSU8gfSwNCj4+Pj4gKy8qIHsgTkZTRVJSX0VBR0FJTiwgLUVBR0FJTiB9
LCAqLw0KPj4+PiArIHsgTkZTRVJSX0FDQ0VTLCAtRUFDQ0VTIH0sDQo+Pj4+ICsgeyBORlNFUlJf
RVhJU1QsIC1FRVhJU1QgfSwNCj4+Pj4gKyB7IE5GU0VSUl9YREVWLCAtRVhERVYgfSwNCj4+Pj4g
KyB7IE5GU0VSUl9OT0RFViwgLUVOT0RFViB9LA0KPj4+PiArIHsgTkZTRVJSX05PVERJUiwgLUVO
T1RESVIgfSwNCj4+Pj4gKyB7IE5GU0VSUl9JU0RJUiwgLUVJU0RJUiB9LA0KPj4+PiArIHsgTkZT
RVJSX0lOVkFMLCAtRUlOVkFMIH0sDQo+Pj4+ICsgeyBORlNFUlJfRkJJRywgLUVGQklHIH0sDQo+
Pj4+ICsgeyBORlNFUlJfTk9TUEMsIC1FTk9TUEMgfSwNCj4+Pj4gKyB7IE5GU0VSUl9ST0ZTLCAt
RVJPRlMgfSwNCj4+Pj4gKyB7IE5GU0VSUl9NTElOSywgLUVNTElOSyB9LA0KPj4+PiArIHsgTkZT
RVJSX05BTUVUT09MT05HLCAtRU5BTUVUT09MT05HIH0sDQo+Pj4+ICsgeyBORlNFUlJfTk9URU1Q
VFksIC1FTk9URU1QVFkgfSwNCj4+Pj4gKyB7IE5GU0VSUl9EUVVPVCwgLUVEUVVPVCB9LA0KPj4+
PiArIHsgTkZTRVJSX1NUQUxFLCAtRVNUQUxFIH0sDQo+Pj4+ICsgeyBORlNFUlJfUkVNT1RFLCAt
RVJFTU9URSB9LA0KPj4+PiArI2lmZGVmIEVXRkxVU0gNCj4+Pj4gKyB7IE5GU0VSUl9XRkxVU0gs
IC1FV0ZMVVNIIH0sDQo+Pj4+ICsjZW5kaWYNCj4+Pj4gKyB7IE5GU0VSUl9CQURIQU5ETEUsIC1F
QkFESEFORExFIH0sDQo+Pj4+ICsgeyBORlNFUlJfTk9UX1NZTkMsIC1FTk9UU1lOQyB9LA0KPj4+
PiArIHsgTkZTRVJSX0JBRF9DT09LSUUsIC1FQkFEQ09PS0lFIH0sDQo+Pj4+ICsgeyBORlNFUlJf
Tk9UU1VQUCwgLUVOT1RTVVBQIH0sDQo+Pj4+ICsgeyBORlNFUlJfVE9PU01BTEwsIC1FVE9PU01B
TEwgfSwNCj4+Pj4gKyB7IE5GU0VSUl9TRVJWRVJGQVVMVCwgLUVSRU1PVEVJTyB9LA0KPj4+PiAr
IHsgTkZTRVJSX0JBRFRZUEUsIC1FQkFEVFlQRSB9LA0KPj4+PiArIHsgTkZTRVJSX0pVS0VCT1gs
IC1FSlVLRUJPWCB9LA0KPj4+PiArIHsgLTEsIC1FSU8gfQ0KPj4+PiArfTsNCj4+Pj4gKw0KPj4+
PiArLyoqDQo+Pj4+ICsgKiBuZnNfc3RhdF90b19lcnJubyAtIGNvbnZlcnQgYW4gTkZTIHN0YXR1
cyBjb2RlIHRvIGEgbG9jYWwgZXJybm8NCj4+Pj4gKyAqIEBzdGF0dXM6IE5GUyBzdGF0dXMgY29k
ZSB0byBjb252ZXJ0DQo+Pj4+ICsgKg0KPj4+PiArICogUmV0dXJucyBhIGxvY2FsIGVycm5vIHZh
bHVlLCBvciAtRUlPIGlmIHRoZSBORlMgc3RhdHVzIGNvZGUgaXMNCj4+Pj4gKyAqIG5vdCByZWNv
Z25pemVkLiAgbmZzZF9maWxlX2FjcXVpcmUoKSByZXR1cm5zIGFuIG5mc3N0YXQgdGhhdA0KPj4+
PiArICogbmVlZHMgdG8gYmUgdHJhbnNsYXRlZCB0byBhbiBlcnJubyBiZWZvcmUgYmVpbmcgcmV0
dXJuZWQgdG8gYQ0KPj4+PiArICogbG9jYWwgY2xpZW50IGFwcGxpY2F0aW9uLg0KPj4+PiArICov
DQo+Pj4+ICtzdGF0aWMgaW50IG5mc19zdGF0X3RvX2Vycm5vKGVudW0gbmZzX3N0YXQgc3RhdHVz
KQ0KPj4+PiArew0KPj4+PiArIGludCBpOw0KPj4+PiArDQo+Pj4+ICsgZm9yIChpID0gMDsgbmZz
X2NvbW1vbl9lcnJ0YmxbaV0uc3RhdCAhPSAtMTsgaSsrKSB7DQo+Pj4+ICsgaWYgKG5mc19jb21t
b25fZXJydGJsW2ldLnN0YXQgPT0gKGludClzdGF0dXMpDQo+Pj4+ICsgcmV0dXJuIG5mc19jb21t
b25fZXJydGJsW2ldLmVycm5vOw0KPj4+PiArIH0NCj4+Pj4gKyByZXR1cm4gbmZzX2NvbW1vbl9l
cnJ0YmxbaV0uZXJybm87DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyB2b2lkDQo+Pj4+
ICtuZnNkX2xvY2FsX2Zha2VycXN0X2Rlc3Ryb3koc3RydWN0IHN2Y19ycXN0ICpycXN0cCkNCj4+
Pj4gK3sNCj4+Pj4gKyBpZiAocnFzdHAtPnJxX2NsaWVudCkNCj4+Pj4gKyBhdXRoX2RvbWFpbl9w
dXQocnFzdHAtPnJxX2NsaWVudCk7DQo+Pj4+ICsgaWYgKHJxc3RwLT5ycV9jcmVkLmNyX2dyb3Vw
X2luZm8pDQo+Pj4+ICsgcHV0X2dyb3VwX2luZm8ocnFzdHAtPnJxX2NyZWQuY3JfZ3JvdXBfaW5m
byk7DQo+Pj4+ICsgLyogcnBjYXV0aF9tYXBfdG9fc3ZjX2NyZWRfbG9jYWwoKSBjbGVhcnMgY3Jf
cHJpbmNpcGFsICovDQo+Pj4+ICsgV0FSTl9PTl9PTkNFKHJxc3RwLT5ycV9jcmVkLmNyX3ByaW5j
aXBhbCAhPSBOVUxMKTsNCj4+Pj4gKyBrZnJlZShycXN0cC0+cnFfeHBydCk7DQo+Pj4+ICsga2Zy
ZWUocnFzdHApOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgc3RydWN0IHN2Y19ycXN0
ICoNCj4+Pj4gK25mc2RfbG9jYWxfZmFrZXJxc3RfY3JlYXRlKHN0cnVjdCBuZXQgKm5ldCwgc3Ry
dWN0IHJwY19jbG50ICpycGNfY2xudCwNCj4+Pj4gKyBjb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZCkN
Cj4+Pj4gK3sNCj4+Pj4gKyBzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwOw0KPj4+PiArIHN0cnVjdCBu
ZnNkX25ldCAqbm4gPSBuZXRfZ2VuZXJpYyhuZXQsIG5mc2RfbmV0X2lkKTsNCj4+Pj4gKyBpbnQg
c3RhdHVzOw0KPj4+PiArDQo+Pj4+ICsgLyogRklYTUU6IG5vdCBydW5uaW5nIGluIG5mc2QgY29u
dGV4dCwgbXVzdCBnZXQgcmVmZXJlbmNlIG9uIG5mc2Rfc2VydiAqLw0KPj4+PiArIGlmICh1bmxp
a2VseSghUkVBRF9PTkNFKG5uLT5uZnNkX3NlcnYpKSkgew0KPj4+PiArIGRwcmludGsoIiVzOiBs
b2NhbGlvIGRlbmllZC4gU2VydmVyIG5vdCBydW5uaW5nXG4iLCBfX2Z1bmNfXyk7DQo+Pj4gDQo+
Pj4gQ2h1Y2sgbWVudGlvbmVkIHRoaXMgZWFybGllciwgYnV0IEkgZG9uJ3QgdGhpbmsgd2Ugb3Vn
aHQgdG8gbWVyZ2UgdGhlDQo+Pj4gZHByaW50a3MuIElmIHRoZXkncmUgdXNlZnVsIGZvciBkZWJ1
Z2dpbmcgdGhlbiB0aGV5IHNob3VsZCBiZSB0dXJuZWQNCj4+PiBpbnRvIHRyYWNlcG9pbnRzLiBU
aGlzIG9uZSwgSSdkIHByb2JhYmx5IGp1c3QgZHJvcC4NCj4+IA0KPj4gUmlnaHQ7IHRoZSBwcm9i
bGVtIHdpdGggZHByaW50aygpIGlzIHRoZXkgY2FuIGNyZWF0ZSBzbyBtdWNoIGNoYXR0ZXINCj4+
IHRoYXQgdGhlIHN5c3RlbWQgam91cm5hbCB3aWxsIGF1dG9tYXRpY2FsbHkgdG9zcyB0aG9zZSBt
ZXNzYWdlcyBhbmQNCj4+IHRoZXkgYXJlIGxvc3QuIE5vIGRpYWdub3N0aWMgdmFsdWUgaW4gdGhh
dC4NCj4+IA0KPj4gQWxzbyB5b3UgcHJvYmFibHkgd29uJ3QgZmluZCBpdCB1c2VmdWwgaWYgbG90
cyBvZiBkZWJ1Z2dpbmcgaW5mbw0KPj4gZ29lcyBpbnRvIHRoZSB0cmFjZSBsb2cgYnV0IGEgaGFu
ZGZ1bCBvZiB0aGUgc3R1ZmYgeW91IGFyZQ0KPj4gbG9va2luZyBmb3IgaXMgZHVtcGVkIGludG8g
dGhlIHN5c3RlbSBqb3VybmFsOyB0aGUgdHdvIHVzZSBkaWZmZXJlbnQNCj4+IHRpbWVzdGFtcHMg
YW5kIHNvIGFyZSByZWFsbHkgaGFyZCB0byBsaW5lIHVwIGFmdGVyIHRoZSBmYWN0Lg0KPj4gDQo+
PiBXZSdyZSB0cnlpbmcgdG8gdHJhbnNpdGlvbiBhd2F5IGZyb20gZHByaW50aygpIGluIE5GU0Qg
Zm9yIHRoZXNlDQo+PiByZWFzb25zLg0KPiANCj4gT0ssIEkgdW5kZXJzdGFuZCB3YW50aW5nIHRv
IG5vdCBhbGxvdyBuZXcgZHByaW50aygpIHRvIGJlIGFkZGVkLg0KPiANCj4gTWVhbndoaWxlOg0K
PiAkIGdyZXAgLXJpIGRwcmludGsgZnMvbmZzZC8qLltjaF0gIHwgd2MgLWwNCj4gICAgIDE4MQ0K
PiANCj4gU28gSSdtIHN0cnVnZ2xpbmcgdG8gZ2V0IG1vdGl2YXRlZCB0byBjb252ZXJ0IHRvIHRy
YWNlcG9pbnRzLiAgRmVlbHMNCj4gbGlrZSBhIG5lZWRsZXNzIG1ha2Utd29yayBodXJkbGUsIHRo
ZXNlIGNvdWxkIGJlIGNvbnZlcnRlZCBieSBvdGhlcnMNCj4gbW9yZSBwcm9maWNpZW50IHdpdGgg
dHJhY2Vwb2ludHMgaWYvd2hlbiBuZWVkZWQuDQo+IA0KPiBNYWtpbmcgZXZlcnlvbmUgaGF2ZSB0
byBiZSBwcm9maWNpZW50IGF0IGRldmVsb3BpbmcgZGVidWdnaW5nIHZpYQ0KPiB0cmFjZXBvaW50
cyBzZWVtcyBtaXNwbGFjZWQgKGJ1dCBJIGFsc28gdW5kZXJzdGFuZCB0aGF0IGZvcmNpbmcgb3Ro
ZXJzDQo+IHRvIGZpc2ggZW5hYmxlcyAib3RoZXJzIiB0byBub3QgYmUgZG9pbmcgdGhlIGNvbnZl
cnNpb24gd29yaykuDQoNClRyYWNlIHBvaW50cyBhcmUgcGFydCBvZiB0aGUgY29zdCBvZiBjb250
cmlidXRpbmcgdG8gTkZTRCwNCmp1c3QgbGlrZSBYRFIsIFJDVSwgbG9ja2RlcF9hc3NlcnQsIGFu
ZCBkb3plbnMgb2Ygb3RoZXINCmtlcm5lbCBmYWNpbGl0aWVzLiBOb3QgYSBodXJkbGUsIGFuZCBJ
IGRvbid0IGFzayBmb3IgYnVzeQ0Kd29yayBjaGFuZ2VzLg0KDQoNCj4gVGhpcyBpcyB0aGUgZW5k
IG9mIG15IG1pbGQgcHJvdGVzdC4uIEknbGwgc2h1dHVwIGFuZCBlaXRoZXIgY29udmVydA0KPiB0
aGUgZHByaW50aygpcyBvciBraWxsIHRoZW0gYWxsLiA7KQ0KDQpJTU8sIGlmIGEgZHByaW50ayBp
cyBraWxsYWJsZSAob3IgeW91IGRvbid0IGtub3cgaXRzIG5lZWRlZA0KeWV0KSB0aGVuIGl0IHNo
b3VsZG4ndCBiZSBpbmNsdWRlZCBpbiB0aGUgcGF0Y2ggc2VyaWVzLg0KDQoNCi0tDQpDaHVjayBM
ZXZlcg0KDQoNCg==

