Return-Path: <linux-nfs+bounces-1278-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EA3837799
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 00:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888681C24DF3
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB694BA85;
	Mon, 22 Jan 2024 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cNjj/S5G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="maTs8HKv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD444B5BB
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965293; cv=fail; b=EZ4QYY+LcpdHNVR9kZuO2omKwVNvK/jYs+N5Cg5faCDt+kt8TlmB8jN+OfWMSpWSmZ6xbCReFKzHxkkoVOZt1xGlOV5YkreQ/WjHdDr5uKsCqyT342VUWHcUtB4mDZD1GBIAiDJAYjGunEOoSCn1H1e6/ph1XyUcXgoPbgN4Ots=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965293; c=relaxed/simple;
	bh=5t8vKfnM8SxKfQdq7jTuhP7N3Ibg6Qpo9/qHiJ57fp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PtzhFck4F2Eplk7Vicma64e/N1kH+tNc2R3nfcnQcPt+M8rFgkAwUmYzq8y4x1HA+VJ++VcIj14KXyduBW4Gya56o7OuwsCGjdC6Hxm34MEIqnqKB9RTAJuoqxRi7Yhoge+CN81GanSNBZUQetNq32jfNEobHI4CO8GaOlSMtWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cNjj/S5G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=maTs8HKv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMoq27026501;
	Mon, 22 Jan 2024 23:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5t8vKfnM8SxKfQdq7jTuhP7N3Ibg6Qpo9/qHiJ57fp0=;
 b=cNjj/S5GPm2kFhQp4oeV1sZ9udjW+R4UJf7TIF6CQ+uQTgigCvS+kS8QtW9M0dOqdbFu
 e8QATNbqfBC+tsNe6Ftgp0Q+t0knnkvPPlF5DjmAU2VTvgv/fcMKpJ1Nar6eXpC+jdxz
 aVBzy+Xw6yb1mHtMgZxopljGLnQsupJX5iKBRipMipkx3SOLZ5sI9MoRPCEsCNt9Jn0M
 zVikjIM0uMYw7+CQC52+yioDAN+nWKtwSSl0BRLKfKaqzLoiULrM9ZotfFE+3eBmTCGd
 kVUQkpQK3+4XTminRGITmathdKxdETPGt4Zg6GGoW/R8zvmp0h/2NmlYEpRLJMO2AzP5 9g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79vvwuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 23:14:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MN1jaM016086;
	Mon, 22 Jan 2024 23:14:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs321eg89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 23:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR5V0289Dyu+nEoobxHvybuqlSjJs/s1qi0MjqQG+VkXOuvpNTEhbsgY+FAnmcMtmWbredcSiMMFFvB0Bb/ti0bctITiV8JYHjJq1OKgLbkdvHtVbe+cu+YpoiF9caMQ7gqQ+IQR5wPm86d8Lycp1aZ+2B8QDk/jsUWnTNAtL2pbS3NstZBe56pZExqC3OcMagn8OoWHD/2N5Qx9XO6JP8iUUFc3DAtlbILmqbtKm4q04F/CDs3e2j4BAQ+H66ZO5WK46/sg+zoPGS/e92IrnX0FQvSN6DInuetjbynXJthbt/9IhPDZaueH6omfjIRnTbM68Nc//d7HlAFHMur/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t8vKfnM8SxKfQdq7jTuhP7N3Ibg6Qpo9/qHiJ57fp0=;
 b=h6d86hz1fc/0YZqlNkqBXS1Ufbaw3QctSuTFt6/KRrsblJa1q4lPYUiMEuWoOzZR8egelBcHj/aNsoZEYC+XABKuY4jIRft2vIIugQ2vUNG52OQXNLxpsotgfa4eSC4Y1s+LhnmeolCfyWjJKWXjkJ7vbArbA0YFDXJkxuxBlfNMhd+0Px31b7F/cygzlWFPHscdYNCzNWsHvc84dNxJCPWcegmvlaa7HHHCZTigzstjIv9CitdaUhRNG0V+jy3WxX8s4lhoYvXb8nhiZWD98Olp669Eww2NT2LsOY+y7cS+z/eASVDiUSL5JDjvdY+3QQy21c0cddZSOlWI9ATjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t8vKfnM8SxKfQdq7jTuhP7N3Ibg6Qpo9/qHiJ57fp0=;
 b=maTs8HKv14U/55f2IbtrWrWZwge5PlIlSHbh5jVuuud/iKoDsnsAPa8dx2mmv8zOodfKxN/pNprJLdmad7kgSW8FB0xyP45mzX5R59LyZdQd5Eru40SFI+clKUml4yng7haBGCgPMLSwCXptlRUccrcZZkL/LlN0Hs3WMNCS56A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6573.namprd10.prod.outlook.com (2603:10b6:510:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Mon, 22 Jan
 2024 23:14:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%6]) with mapi id 15.20.7202.035; Mon, 22 Jan 2024
 23:14:37 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Olga
 Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix RELEASE_LOCKOWNER
Thread-Topic: [PATCH] nfsd: fix RELEASE_LOCKOWNER
Thread-Index: AQHaTOdBtLll/fA4n0ueXAr70m4RmrDl5I+AgAB9jYCAABWSgA==
Date: Mon, 22 Jan 2024 23:14:37 +0000
Message-ID: <3162C5BC-8E7C-4A9A-815C-09297B56FA17@oracle.com>
References: <170589589641.23031.16356786177193106749@noble.neil.brown.name>
 <Za57adpDbKJavMRO@tissot.1015granger.net>
 <170596063560.23031.1725209290511630080@noble.neil.brown.name>
In-Reply-To: <170596063560.23031.1725209290511630080@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6573:EE_
x-ms-office365-filtering-correlation-id: dba0d8ca-21d6-4428-cc5e-08dc1b9fe73f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 I8nDHAl2TAlYoZEcKFCEINL1GmpYUZz1dqvgXoS+nvXrItb+Db2RsqF4cTb9N/a704FKAKNw3M/dthL9xqtdkIpGEMaSiaISa4LWvJ2oXN46/GeX7MHJH28ScuApDT4AQuIw4iJp5Lhrnfm42QW3LQGzdgfy0Ll2xtQVpZ806XVCWHc1Vg7QHjcYJUzsUOTdwv4LbowyQT0XNBBmXAY1coBtWfMqTbErQBqTbI9jvG9kJmT4qdHQxKuSt69/XT1K/YOYHVP9yxXB2EaZSlE4mvCfjSdRDL/EEvYeYs6lqRP6Ab597wzvTuxoUK1dkxykR9c/7Vyq5oSEYdOUGMXxXYDotOK1OsrXquDWc6cFPIt1yvsujN2+XE2locTyFfepve3Pe/pCRXnsK76DHel26xmWCF3QamTVHjIAfKU7MMzKHl8hWAjUk9ecpZyiW5FuX7DQvmHJshnFyJBVl8Bqa0BwW1DQLbOwU4JT4H+8DT52HddHzvzaIJjtzRq3WieEKqfHjf101iViyT3/iDomXt1WIk/IYD3q03pIoGXXu+CbhHk85MtYnLH74nwsZfEbLUFsURjOUDTHTZcbZh96wo6L47djjEb1QP0fKCU9N0ktlRgYDrabzDNriiD6h0s3tevNT+s1PFw8GFzLDNaXAg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(33656002)(86362001)(38070700009)(38100700002)(122000001)(36756003)(26005)(2616005)(83380400001)(66556008)(66946007)(64756008)(66446008)(76116006)(66476007)(6916009)(6486002)(53546011)(8936002)(8676002)(6506007)(6512007)(71200400001)(54906003)(316002)(91956017)(478600001)(4326008)(5660300002)(2906002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N1MyMzNCU21Hc3BJREowR2VGbnU0djB4SmxadmxsbHptYmtYUi9SWVdDQTls?=
 =?utf-8?B?T29vdU9WOXhjbmVFZXVRK1ZpdzRnRzR5U28yM0dkSHNIOHlBekRwaWRmeWxx?=
 =?utf-8?B?RVd1ekNOdjdUUzhLMXB4dEUyNGFJSmU0U3V0dUowMk8wT3ZrenpWNUkycC9X?=
 =?utf-8?B?RGRxVlg5eGhwSGZ0NkE1cndsRjJvNTg5bDRPbW1YS2hqaldOVElPSE5JelpC?=
 =?utf-8?B?YWkzTDEwb3V1d24ybHRMSlE3YnVtRHhTd2p3YmJIRlhyVkRIRU4yMXloeUgx?=
 =?utf-8?B?Y0RYaCtjdXgwVWRoWUIrVnhsZmNQMGFQcm9zd010Y0FQMU82Tnd4Ti9uNjMx?=
 =?utf-8?B?ZWQ0bkRNRStzc1gzaXA0TmtCK05ub2dOUXJaMTFKQmpGY0ZBQm1YNG1XZmRv?=
 =?utf-8?B?ZWQrOXBac2JCRFp6amd4YkwzTjJUWU9waGtSVEIwYXUxRzBtdjhXaFFZRzBh?=
 =?utf-8?B?VGlmazUzMUpyb21HYjRjQnNsOXVLanlCcURVZ0NFYnBsVWZOT3Rhb1MwLzZ6?=
 =?utf-8?B?VWplUGNLa1NMeTJCTFdUcUgwQVl3WmxaZGZTSXRjQVA3QVE1Q1BDaU9WeWg5?=
 =?utf-8?B?UWZ5UXNuc3ZsdjZnU0JVbEwvSDBHOFFiMmpwWGhCQlR4emZPS25kNERYL1JM?=
 =?utf-8?B?WEVqWnFLbUF0eTN5L0tZQ0VDbVV0RlI4L0hLbFh2SkR1NTd1dTlCRldZVTdx?=
 =?utf-8?B?eEZNZVNuTHgxMFY4Q3FhT3pzT1pqV3orK2hIWjFsS2V3UEZiQW9VV1diQ3hK?=
 =?utf-8?B?SzdmeExkYmpMR0ZtU0JuMWcyRjZXU0YwMzI5clQvSVFVUFVzalJ4QUFyNmVP?=
 =?utf-8?B?eUVoblI5YnJxaDBwenpFZVF5L2o2WVF2M2RXRGpCS1MxQVF5RjF2eEJPc3R3?=
 =?utf-8?B?eDVJK1pnMVF1b0lIaTRPNkdHME5xZ1hoQWZlQ3pEUXVyQXRselFzb1VJd0to?=
 =?utf-8?B?SXRwODdOSmNOV2lXV0poU1dpZHAzV2RkVWp2OTIyelZxSUsxcFk5bVJYZkxx?=
 =?utf-8?B?TXlJZEdYN3VSaUxQS3d3NXlOVmZzR3ZHUWxqaXVzODR1a1ZhNkVHQkJLZ0U4?=
 =?utf-8?B?ZTlacHFhYUl3THphejF0SVJFYmxpUkJpWGx6eGFseUF4MUx4NXN0bzJqUGxn?=
 =?utf-8?B?QU8ydUx3NEtZRzdvejN0T1RQd3JwMlFWRy8vdjNkQWx1bm5XWjNTSkdGU3FB?=
 =?utf-8?B?L2RhakJWNUFCMnBPbW10OXhRSWtzaGY1QTVxNnVsOE9ISzYrOG1sKzlzZVg2?=
 =?utf-8?B?RHZmRGNWYnJ1MVQ2NHJ1NlBZd1lraXNFbVY0RGhralB2TlVuRlFrby9yeWwx?=
 =?utf-8?B?RzFheFJ5cVU3ZlcxbkQrcG10Nnk1UWx4S1dRanNhTzkzSDk4Zlh2M1F4Z254?=
 =?utf-8?B?dURGRDhOWkRRdFFJN1FHcGhGcTJGV2dNSXVJM0hlaUpoeFJuNllNY2NmV1pO?=
 =?utf-8?B?QkJLVXNRWG5uYXNmUkFnV256dExvU1dCZzl2KzJEQ00xdGhwTXAvQUh1L1Ax?=
 =?utf-8?B?aHJBeDFvczdxengvMTJmTHFVYzJRczZDZnJYRGRlMHNXOWVwVFhCRlFtWnVn?=
 =?utf-8?B?QVNZTU8rUnRWTUlLNHJwTkthckFrbk9ZYWVlUE9lNlJISkRSU1ptQVBxYlFF?=
 =?utf-8?B?NFdwRTdJbHE4NjFxemxDbER1eUFrbUlxTTRmNWJxb01QRTV2MURlM1hJQTc5?=
 =?utf-8?B?UUFVcTNaUTF3Q3BmQUk4VDRVaFc3cmlpaU5qMXUwT3hVb1JGenlpeWlGeHFo?=
 =?utf-8?B?YXU3dGE2TlZkR2JIL2l1emltTmdqblVSZkMyMUFrdmJGRHFkUFlDZDEyVFR0?=
 =?utf-8?B?Y2p1eTdpMXBqK0FJVVA0ajBZNndmT1Nyd2hvZ1JSWmFHVG1VRTlPSzFibmxS?=
 =?utf-8?B?TTBLckFBbjJGR0FqZ1VVbWw1dndFK2ZPQjBNVmpYMGh4U0JPeVhleHZXcHNh?=
 =?utf-8?B?UWJ2SjZBbGxHVHBiNFViQmZLbWNqN25UYkc3MHpUdFBJYlNMVnZ4Z3hBVndM?=
 =?utf-8?B?SmEvYmtFY3RpOTh5RlNaTHpqNURVb01TUzBpNlE0ZUlSa2N3eDNJb3NhTnV1?=
 =?utf-8?B?di9neHdXbyt6aDRRR2tCakRyRHoyNXBqdEx1L1dnTEVmWGd1Y2ZuczdzZi96?=
 =?utf-8?B?SVZoQWVHZDl1clczTTNyOHJ5bW9YblRzNnVIUkF0a2xFNy83YS9KUDNHOXps?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E20D734882E9674CB9C18E62348C6EBB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RPgnu9TvfgPnyl22oiDoZkxBCRZ8m1kzYQkKPuj2cpussWhs7QkyZNNdssk+IMutvfbnMzgBa9c/YYr7hTteeMYnMujSa1bmCZW+uCqcc9CcB0GVFnJpmVE9wFu9nhVpc9y1IuaW29UqeEQ2BhUQTe7A29dDohC/aeCD+roCRifABqkXZAzBXvra7QSJrLgo+rClk2kHg2sqEXcAU6VqdYPy387Bt+wgfbKGRQv57zQxIEe6YC/1hOHA2I/gHgwWun2uFERfqYKJOM+BIu/4QcD8lica3RZaovGPCu+ClAxsSleVZcD3rFp+H5SsIuJViQ1qvRJws/EFSy6ZX7mn3Y1Cc7HmPs3y6OBgxrBrve7GraqSvlB1/Y5NAIZ/l9B9TDWRqBr7jd+3sVVwKMqO+VWs2v5brxMF5bKjMjiOGbcpOBqqd501nHRXmaWGcE93juOJdD8dcD+rvkj/a+WwLMCS7ZgyROxToi7st35DQShveF08rja7NmG6FzfwbPgoZi7zfqM8cuQq6Z+eeuZZAvUBScIPnyVDKSifzwdF2gQ6E6wxga0jdI4a3/I6Qh1tqwOcNpSLrIdQsxqIOtqikhcXqgvuEGwySEYv/7zHy+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba0d8ca-21d6-4428-cc5e-08dc1b9fe73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 23:14:37.2821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqPeM/S5VX2u8qqqvz8HASXsOD61Uh8W20Dr/uQ8wFZbbG3Nh/xLn93ugMNpV0x8oNQoNFD+Ye3rF/8WpmIacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220166
X-Proofpoint-GUID: M7S_643PYoy1NOnTeGASXRuX4mnAGdH_
X-Proofpoint-ORIG-GUID: M7S_643PYoy1NOnTeGASXRuX4mnAGdH_

DQoNCj4gT24gSmFuIDIyLCAyMDI0LCBhdCA0OjU34oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDIzIEphbiAyMDI0LCBDaHVjayBMZXZlciB3cm90
ZToNCj4+IE9uIE1vbiwgSmFuIDIyLCAyMDI0IGF0IDAyOjU4OjE2UE0gKzExMDAsIE5laWxCcm93
biB3cm90ZToNCj4+PiANCj4+PiBUaGUgdGVzdCBvbiBzb19jb3VudCBpbiBuZnNkNF9yZWxlYXNl
X2xvY2tvd25lcigpIGlzIG5vbnNlbnNlIGFuZA0KPj4+IGhhcm1mdWwuICBSZXZlcnQgdG8gdXNp
bmcgY2hlY2tfZm9yX2xvY2tzKCksIGNoYW5naW5nIHRoYXQgdG8gbm90IHNsZWVwLg0KPj4+IA0K
Pj4+IEZpcnN0OiBoYXJtZnVsLg0KPj4+IEFzIGlzIGRvY3VtZW50ZWQgaW4gdGhlIGtkb2MgY29t
bWVudCBmb3IgbmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIoKSwgdGhlDQo+Pj4gdGVzdCBvbiBzb19j
b3VudCBjYW4gdHJhbnNpZW50bHkgcmV0dXJuIGEgZmFsc2UgcG9zaXRpdmUgcmVzdWx0aW5nIGlu
IGENCj4+PiByZXR1cm4gb2YgTkZTNEVSUl9MT0NLU19IRUxEIHdoZW4gaW4gZmFjdCBubyBsb2Nr
cyBhcmUgaGVsZC4gIFRoaXMgaXMNCj4+PiBjbGVhcmx5IGEgcHJvdG9jb2wgdmlvbGF0aW9uIGFu
ZCB3aXRoIHRoZSBMaW51eCBORlMgY2xpZW50IGl0IGNhbiBjYXVzZQ0KPj4+IGluY29ycmVjdCBi
ZWhhdmlvdXIuDQo+Pj4gDQo+Pj4gSWYgTkZTNF9SRUxFQVNFX0xPQ0tPV05FUiBpcyBzZW50IHdo
aWxlIHNvbWUgb3RoZXIgdGhyZWFkIGlzIHN0aWxsDQo+Pj4gcHJvY2Vzc2luZyBhIExPQ0sgcmVx
dWVzdCB3aGljaCBmYWlsZWQgYmVjYXVzZSwgYXQgdGhlIHRpbWUgdGhhdCByZXF1ZXN0DQo+Pj4g
d2FzIHJlY2VpdmVkLCB0aGUgZ2l2ZW4gb3duZXIgaGVsZCBhIGNvbmZsaWN0aW5nIGxvY2ssIHRo
ZW4gdGhlIG5mc2QNCj4+PiB0aHJlYWQgcHJvY2Vzc2luZyB0aGF0IExPQ0sgcmVxdWVzdCBjYW4g
aG9sZCBhIHJlZmVyZW5jZSAoY29uZmxvY2spIHRvDQo+Pj4gdGhlIGxvY2sgb3duZXIgdGhhdCBj
YXVzZXMgbmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIoKSB0byByZXR1cm4gYW4NCj4+PiBpbmNvcnJl
Y3QgZXJyb3IuDQo+Pj4gDQo+Pj4gVGhlIExpbnV4IE5GUyBjbGllbnQgaWdub3JlcyB0aGF0IE5G
UzRFUlJfTE9DS1NfSEVMRCBlcnJvciBiZWNhdXNlIGl0DQo+Pj4gbmV2ZXIgc2VuZHMgTkZTNF9S
RUxFQVNFX0xPQ0tPV05FUiB3aXRob3V0IGZpcnN0IHJlbGVhc2luZyBhbnkgbG9ja3MsIHNvDQo+
Pj4gaXQga25vd3MgdGhhdCB0aGUgZXJyb3IgaXMgaW1wb3NzaWJsZS4gIEl0IGFzc3VtZXMgdGhl
IGxvY2sgb3duZXIgd2FzIGluDQo+Pj4gZmFjdCByZWxlYXNlZCBzbyBpdCBmZWVscyBmcmVlIHRv
IHVzZSB0aGUgc2FtZSBsb2NrIG93bmVyIGlkZW50aWZpZXIgaW4NCj4+PiBzb21lIGxhdGVyIGxv
Y2tpbmcgcmVxdWVzdC4NCj4+PiANCj4+PiBXaGVuIGl0IGRvZXMgcmV1c2UgYSBsb2NrIG93bmVy
IGlkZW50aWZpZXIgZm9yIHdoaWNoIGEgcHJldmlvdXMgUkVMRUFTRQ0KPj4+IGZhaWxlZCwgaXQg
d2lsbCBuYXR1cmFsbHkgdXNlIGEgbG9ja19zZXFpZCBvZiB6ZXJvLiAgSG93ZXZlciB0aGUgc2Vy
dmVyLA0KPj4+IHdoaWNoIGRpZG4ndCByZWxlYXNlIHRoZSBsb2NrIG93bmVyLCB3aWxsIGV4cGVj
dCBhIGxhcmdlciBsb2NrX3NlcWlkIGFuZA0KPj4+IHNvIHdpbGwgcmVzcG9uZCB3aXRoIE5GUzRF
UlJfQkFEX1NFUUlELg0KPj4+IA0KPj4+IFNvIGNsZWFybHkgaXQgaXMgaGFybWZ1bCB0byBhbGxv
dyBhIGZhbHNlIHBvc2l0aXZlLCB3aGljaCB0ZXN0aW5nDQo+Pj4gc29fY291bnQgYWxsb3dzLg0K
Pj4+IA0KPj4+IFRoZSB0ZXN0IGlzIG5vbnNlbnNlIGJlY2F1c2UgLi4uIHdlbGwuLi4gaXQgZG9l
c24ndCBtZWFuIGFueXRoaW5nLg0KPj4+IA0KPj4+IHNvX2NvdW50IGlzIHRoZSBzdW0gb2YgdGhy
ZWUgZGlmZmVyZW50IGNvdW50cy4NCj4+PiAxLyB0aGUgc2V0IG9mIHN0YXRlcyBsaXN0ZWQgb24g
c29fc3RhdGVpZHMNCj4+PiAyLyB0aGUgc2V0IG9mIGFjdGl2ZSB2ZnMgbG9ja3Mgb3duZWQgYnkg
YW55IG9mIHRob3NlIHN0YXRlcw0KPj4+IDMvIHZhcmlvdXMgdHJhbnNpZW50IGNvdW50cyBzdWNo
IGFzIGZvciBjb25mbGljdGluZyBsb2Nrcy4NCj4+PiANCj4+PiBXaGVuIGl0IGlzIHRlc3RlZCBh
Z2FpbnN0ICcyJyBpdCBpcyBjbGVhciB0aGF0IG9uZSBvZiB0aGVzZSBpcyB0aGUNCj4+PiB0cmFu
c2llbnQgcmVmZXJlbmNlIG9idGFpbmVkIGJ5IGZpbmRfbG9ja293bmVyX3N0cl9sb2NrZWQoKS4g
IEl0IGlzIG5vdA0KPj4+IGNsZWFyIHdoYXQgdGhlIG90aGVyIG9uZSBpcyBleHBlY3RlZCB0byBi
ZS4NCj4+PiANCj4+PiBJbiBwcmFjdGljZSwgdGhlIGNvdW50IGlzIG9mdGVuIDIgYmVjYXVzZSB0
aGVyZSBpcyBwcmVjaXNlbHkgb25lIHN0YXRlDQo+Pj4gb24gc29fc3RhdGVpZHMuICBJZiB0aGVy
ZSB3ZXJlIG1vcmUsIHRoaXMgd291bGQgZmFpbC4NCj4+PiANCj4+PiBJdCBteSB0ZXN0aW5nIEkg
c2VlIHR3byBjaXJjdW1zdGFuY2VzIHdoZW4gUkVMRUFTRV9MT0NLT1dORVIgaXMgY2FsbGVkLg0K
Pj4+IEluIG9uZSBjYXNlLCBDTE9TRSBpcyBjYWxsZWQgYmVmb3JlIFJFTEVBU0VfTE9DS09XTkVS
LiAgVGhhdCByZXN1bHRzIGluDQo+Pj4gYWxsIHRoZSBsb2NrIHN0YXRlcyBiZWluZyByZW1vdmVk
LCBhbmQgc28gdGhlIGxvY2tvd25lciBiZWluZyBkaXNjYXJkZWQNCj4+PiAoaXQgaXMgcmVtb3Zl
ZCB3aGVuIHRoZXJlIGFyZSBubyBtb3JlIHJlZmVyZW5jZXMgd2hpY2ggdXN1YWxseSBoYXBwZW5z
DQo+Pj4gd2hlbiB0aGUgbG9jayBzdGF0ZSBpcyBkaXNjYXJkZWQpLiAgV2hlbiBuZnNkNF9yZWxl
YXNlX2xvY2tvd25lcigpIGZpbmRzDQo+Pj4gdGhhdCB0aGUgbG9jayBvd25lciBkb2Vzbid0IGV4
aXN0LCBpdCByZXR1cm5zIHN1Y2Nlc3MuDQo+Pj4gDQo+Pj4gVGhlIG90aGVyIGNhc2Ugc2hvd3Mg
YW4gc29fY291bnQgb2YgJzInIGFuZCBwcmVjaXNlbHkgb25lIHN0YXRlIGxpc3RlZA0KPj4+IGlu
IHNvX3N0YXRlaWQuICBJdCBhcHBlYXJzIHRoYXQgdGhlIExpbnV4IGNsaWVudCB1c2VzIGEgc2Vw
YXJhdGUgbG9jaw0KPj4+IG93bmVyIGZvciBlYWNoIGZpbGUgcmVzdWx0aW5nIGluIG9uZSBsb2Nr
IHN0YXRlIHBlciBsb2NrIG93bmVyLCBzbyB0aGlzDQo+Pj4gdGVzdCBvbiAnMicgaXMgc2FmZS4g
IEZvciBhbm90aGVyIGNsaWVudCBpdCBtaWdodCBub3QgYmUgc2FmZS4NCj4+PiANCj4+PiBTbyB0
aGlzIHBhdGNoIGNoYW5nZXMgY2hlY2tfZm9yX2xvY2tzKCkgdG8gdXNlIHRoZSAobmV3aXNoKQ0K
Pj4+IGZpbmRfYW55X2ZpbGVfbG9ja2VkKCkgc28gdGhhdCBpdCBkb2Vzbid0IHRha2UgYSByZWZl
cmVuY2Ugb24gdGhlDQo+Pj4gbmZzNF9maWxlIGFuZCBzbyBuZXZlciBjYWxscyBuZnNkX2ZpbGVf
cHV0KCksIGFuZCBzbyBuZXZlciBzbGVlcHMuDQo+PiANCj4+IE1vcmUgdG8gdGhlIHBvaW50LCBm
aW5kX2FueV9maWxlX2xvY2tlZCgpIHdhcyBhZGRlZCBieSBjb21taXQNCj4+IGUwYWE2NTEwNjhi
ZiAoIm5mc2Q6IGRvbid0IGNhbGwgbmZzZF9maWxlX3B1dCBmcm9tIGNsaWVudCBzdGF0ZXMNCj4+
IHNlcWZpbGUgZGlzcGxheSIpLCB3aGljaCB3YXMgbWVyZ2VkIHNldmVyYWwgbW9udGhzIC9hZnRl
ci8gY29tbWl0DQo+PiBjZTNjNGFkN2Y0Y2UgKCJORlNEOiBGaXggcG9zc2libGUgc2xlZXAgZHVy
aW5nDQo+PiBuZnNkNF9yZWxlYXNlX2xvY2tvd25lcigpIikuDQo+IA0KPiBZZXMuICBUbyBmbGVz
aCBvdXQgdGhlIGhpc3Rvcnk6DQo+IG5mc2RfZmlsZV9wdXQoKSB3YXMgYWRkZWQgaW4gdjUuNC4g
IEluIGVhcmxpZXIga2VybmVscyBjaGVja19mb3JfbG9ja3MoKQ0KPiB3b3VsZCBuZXZlciBzbGVl
cC4gIEhvd2V2ZXIgdGhlIHByb2JsZW0gcGF0Y2ggd2FzIGJhY2twb3J0ZWQgNC45LCA0LjE0LA0K
PiBhbmQgNC4xOSBhbmQgc2hvdWxkIGJlIHJldmVydGVkLg0KDQpJIGRvbid0IHNlZSAiTkZTRDog
Rml4IHBvc3NpYmxlIHNsZWVwIGR1cmluZyBuZnNkNF9yZWxlYXNlX2xvY2tvd25lcigpIg0KaW4g
YW55IG9mIHRob3NlIGtlcm5lbHMuIEFsbCBidXQgNC4xOSBhcmUgbm93IEVPTC4NCg0KDQo+IGZp
bmRfYW55X2ZpbGVfbG9ja2VkKCkgd2FzIGFkZGVkIGluIHY2LjIgc28gd2hlbiB0aGlzIHBhdGNo
IGlzDQo+IGJhY2twb3J0ZWQgdG8gNS40LCA1LjEwLCA1LjE1LCA1LjE3IC0gNi4xIGl0IG5lZWRz
IHRvIGluY2x1ZGUNCj4gZmluZF9hbmRfZmlsZV9sb2NrZWQoKQ0KDQpJIHRoaW5rIEknZCByYXRo
ZXIgbGVhdmUgdGhvc2UgdW5wZXJ0dXJiZWQgdW50aWwgc29tZW9uZSBoaXRzIGEgcmVhbA0KcHJv
YmxlbS4gVW5sZXNzIHlvdSBoYXZlIGEgZGlzdHJpYnV0aW9uIGtlcm5lbCB0aGF0IG5lZWRzIHRv
IHNlZQ0KdGhpcyBmaXggaW4gb25lIG9mIHRoZSBMVFMga2VybmVscz8gVGhlIHN1cHBvcnRlZCBz
dGFibGUvTFRTIGtlcm5lbHMNCmFyZSA1LjQsIDUuMTAsIDUuMTUsIGFuZCA2LjEuDQoNCg0KPiBU
aGUgcGF0Y2ggc2hvdWxkIGFwcGx5IHVuY2hhbmdlZCB0byBzdGFibGUga2VybmVscyA2LjIgYW5k
IGxhdGVyLg0KDQpJIGNhbiBhZGQgYSBDYzogc3RhYmxlICN2Ni4yKw0KDQoNCi0tDQpDaHVjayBM
ZXZlcg0KDQoNCg==

