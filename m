Return-Path: <linux-nfs+bounces-2983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0168B0BDC
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 16:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11B51C2193B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CDC15D5CF;
	Wed, 24 Apr 2024 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="njIJuh8W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fQ2ijlbC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69215D5A3;
	Wed, 24 Apr 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967443; cv=fail; b=DzGLcVgaTfMkN2z6buUhz5LrsXZsoqmjvw7iXPoZaSFGbkFH+dj8vy5bqXvXIIxnFySY8yhpgE5t+VNaOPr3+nDvaRL7U1QZD4DTWFGi/ZVoPtI4I6hLL52/6UvUR3VbmUjs+ag5hEqCnN72zCoKjsjmeuP3NvkuxZ7dDRM2HPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967443; c=relaxed/simple;
	bh=MV99YruOD686itc//fBVUR5v3xDfOiu9y9nKsAGNkso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W9SiXjfb4rGV6M4Vd/0vbQ1zRaClIszDpKpkJ5rHtnonYY4TWdD1NuiSS0AHRGOH6Bz2xoQ+QcomMdR3qR/s7RSGsie+P09xGLqEUFf7p5GrwBy5Kkb/D406dQl/dDWMFWN6fZV2FCFWWq24oMBHGS1CnLjH8FYiH41Ym4hi23A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=njIJuh8W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fQ2ijlbC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43O9iXGK010220;
	Wed, 24 Apr 2024 14:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=MV99YruOD686itc//fBVUR5v3xDfOiu9y9nKsAGNkso=;
 b=njIJuh8W/V5GIZedu5vvY02Lo0imfQyDU90wY4boh9ZvafDnFSVVnLjqGqLTPN4MFwvC
 ZO3VDHArposDau7bl8PlH/XFtOYB7BwHYeycM0HosVhHOIO+TGhaKR4kAVPni7KOmU90
 ojSNfsNoVmePnalfBZn+oErfooQriMx5VJPt7RbX8HU0XMyWGvmp1cYHia8WyMo/q6S3
 GdziTB8Dc4zaROYq9Lmqk86AwHUlj6sNRn/kCyU8zWdwlQaQJrscv/wuFQI4lONqTiOA
 D1BFD1aSKdzhb+4tRtehJ1QLZk/W0bOaNohBkNHTbbLJU055fQijOzci+MatmrNOBYcn bQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vgp1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 14:03:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ODoMQE035593;
	Wed, 24 Apr 2024 14:03:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm458vdsr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 14:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/165a750qNdThr16QGDIb8trQXDEgEHe6x+cOUUgac284e9PIBahMD60LaRckHJfm65yKeJju6Ml8cqCEBKsvmsiHY55GWNrdsBKTN1cQCwBwRUejzNdJC+sNdadKvk0i/Yk0qILnir7Z5UlNC/aXA/q5mEeh8+i1FPT0b2zX2AWPyeMfmb1SYAjBMSULcJ4ode0tWINcdywOHXHPjV1o3CR1va5wdQSfD842ENgx5Ka8+WakCgnBXEiP1WTOxAm5DZAcYjDO6rBc+m7g4wqZQrDcBHucwYZl5QfnUeBYkgnHXeWUtjR0Q37/s1iPPZi8s6CI+ow4mGgLw/kOr4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV99YruOD686itc//fBVUR5v3xDfOiu9y9nKsAGNkso=;
 b=OZ8kayykwaZAm0M8te/ntglur6ilpVhYbXpaLqqXV0+YkvoMGWAN9SDwlW1cQyGb5CGKhxMMRRE18qbxADgNvPyN8JeLMdhLAq9M6G2+our+yo0ALQthN5Q6kQhrAoKXBe8todu5nndhaq6/KUFub91q0h0qh2A0QqSc4dUtYPooItQ6OMkUIMkWpLlXi2TBsoXHh2ruMA5v5gZMc5tpvcUxv4jsPcFNdnB7FnuNaRPCZLKNLZci0FdR1AeFckcbSrbOtdc7NGeOJhFiabiSRtxkICKQXbXVw3FBoao//x8SEHGSrwcoVJV4LbKG7vyw4Csf2/mPOzJ826NvguN7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV99YruOD686itc//fBVUR5v3xDfOiu9y9nKsAGNkso=;
 b=fQ2ijlbC1CNW+6wiBJ56jVnS7TUqa6sa58hnTtEWobIuY0uA5W51xFLh2TfDMlVx8ZI7AclUm5+stcMgKjNjROHrlvP66FZAwGhlea1cM7yncP1miaon+PCjNt29fmvWLgZPnY1cR9yQFiZ+BEeW5/gl1YCECDGpY7Bwo1iZm1U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6811.namprd10.prod.outlook.com (2603:10b6:610:14c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:03:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 14:03:22 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Neil Brown
	<neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Topic: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Index: AQHaleHzc3oveYbGkkq3WWVD/cih7bF12zkAgABlswCAAStOgIAACEqA
Date: Wed, 24 Apr 2024 14:03:22 +0000
Message-ID: <5D19EAF8-0F65-4CD6-9378-67234D407B96@oracle.com>
References: <b363e394-7549-4b9e-b71b-d97cd13f9607@alliedtelesis.co.nz>
 <0d2c2123-e782-4712-8876-c9b65d2c9a65@alliedtelesis.co.nz>
 <06de0002-c3c6-4f13-9618-066cb9658240@alliedtelesis.co.nz>
 <1235583F-8299-435B-A8C3-41DEB917D6CA@oracle.com>
In-Reply-To: <1235583F-8299-435B-A8C3-41DEB917D6CA@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6811:EE_
x-ms-office365-filtering-correlation-id: d761eb1c-b47d-4de8-0173-08dc64674d77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TEgzUHI0NkcwTTdMNWFqektNUndCOVhscHoxZW9PNkVYZ3lTaW1PUHpSa0l6?=
 =?utf-8?B?aWhHckRodzFlQW5aVkk4T3IzUnlieXVZVGJuWVpBVnZQNDRZNGp3ZFFoalJi?=
 =?utf-8?B?dy9ieStIQUFsM2dwU2xBNTYrSHV3ZThJa1BoMjlXTUt6Q0NVTXVUVHNlWTdy?=
 =?utf-8?B?eFZGSGU2blFQZjdvcFJNaElBd210aFE1ZUlLUVdzQlc4L0hUb2FId3RFcHRl?=
 =?utf-8?B?ZklDWTVIeVhCdmdtMFNxbWtHdmxYSXBRVEVwSXZzOVpZbU9FNmY5YXlQdEFs?=
 =?utf-8?B?RXBCWjhFY3QrRmNzTmlnRG9VZkJKaWdnNTlhbjI2RDhUSUUxNHEwRmRrMkVH?=
 =?utf-8?B?WkRDNk83TmM3QmJhOUE0K3c0SXhHcm5hNTdsWklFY1ozNUNPeXBQZ083K3h0?=
 =?utf-8?B?WTBSY21sOUxiZ0JybmhuODZ1Z2YvTlNTMDVPT2dScVh1SXRsMnlIU2FyU2NO?=
 =?utf-8?B?RWJSeHNod1phSnU1YnpkcFIrUXFCRzU4Wk9OSzlpL0tnNlRMOEM1bHZiaDZp?=
 =?utf-8?B?dmQ2c0tEcjZTMWx5dDdoc29iZS9HQk1BMWFzcVhiMFI2d3JiMjZ5ejA0bExN?=
 =?utf-8?B?VSsxMllsZ3ZtdSs2MDN5ajJoL0trY1hmMmNwSUZIazg0UHNxQ2FXeTRQbHVU?=
 =?utf-8?B?V2d6dmp3Y3ZsM3lpUS9GdG51M0ErNmYvd3BEd0s2akFkWEtLNTdVWHpwMWpT?=
 =?utf-8?B?TFI0cFdNUmJyOUJnZ1ZaYks0UEpPbFVSdm1iTXA1M3c3Ym1nNEdNZW5lM0dS?=
 =?utf-8?B?WjIxbzNLLzFnamxweWFsWlZQQTVsSEVyMnVmVEU0T0E5Ri9rUm9seE9jMHF2?=
 =?utf-8?B?cjNjL2tjY0VZS09VdHFac0IrQ1h3SU15dVZJR3JSOHlIZk03Vkdyc0dQcmk1?=
 =?utf-8?B?NXAzTGExWFR2UnFqeUVjcmtrYnRUTFF1VENrcjFtV1plS2ZITXB2dXlJNGh3?=
 =?utf-8?B?QUs3RGR4emVOdmtqMzdGdGpsZDFyRGJ2akI1bXdnTGdoYWFWa1QwdGk5Ym5Z?=
 =?utf-8?B?VGZQb25QRFh2OWRROXNxQkowVkNlN0plZk1lOXFlZCtzVUVRWVpsQ2Y3ZVVI?=
 =?utf-8?B?TDViZ3FxLzVWb1d4bmlFcWNVR1VRTDIrcWk4TkV2Nm1wMXFFbksyUzlYNnlv?=
 =?utf-8?B?UzE4NXdlOHBxVkZ1UWRzQmFhaXk5VzROTUlrbTVRTkZmZjdmSGpiTkNyekNy?=
 =?utf-8?B?Mk1jMStKdFA2cWNUYlZBNzJCR2NmejEzd0VQU0JRZzJYVUJGUmpXcGpZdmVL?=
 =?utf-8?B?L0N6dEtvK0hnTUhBN20vb3BVWjE0K3lRVStYVi9qL2Y0NStZRWtLcUFqd2s2?=
 =?utf-8?B?VUJiNFcyY2ZLQytndnRhWFdZMEdtQ0Z6MUVIVndobFZaVWJIMlEwUjhEY1Nh?=
 =?utf-8?B?eFA5NDFLV2FtMEYycXUyTXgwUVM0Uzd4MVF1UExIMlJRZS9QdlJNSXI0K1RR?=
 =?utf-8?B?U08xc0dFKzlucndRRVgvUzVwWmFmcFN5QngxQ21nRWJndnRpdVZJMzEyQnov?=
 =?utf-8?B?OXdjWXpablduKzk2WUVCcURENWxuU0JQV3QxZUZ2anluK3RvOHUxN05Rc3V1?=
 =?utf-8?B?OFZaRFB0VXo2dmZvOWFZUXFaRTV6U1VXMWt0amphR3B4aFV4Umg4eEllWW94?=
 =?utf-8?B?K0NHWkk4aGhoV1haUEVjbVJTREhtQStsU3BibmlqK1RrK1dRaGxObXFGMG9z?=
 =?utf-8?B?YnBRL21mT3JCdyswT25MdUp4N2xoRmJqandwQ1NYQ1QzTUNkUGk0TGM5aXZ6?=
 =?utf-8?B?aDQrQzN3SnF2SFRQaCtPQWt4aHV5WjYzT29iQ3paUjhNL1M2UDhCZWo0aFBv?=
 =?utf-8?B?Yjd4dWJTNEZTVFJRYU04UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cFY5bHhpbHN3QnU1RG5GWndHV09SdUxuK0dGMDlYa1I0STdsMG03c2NUbFNF?=
 =?utf-8?B?dWZVdzZKSVNGekdheVdOOW9qenpXbjZzRHprUjU1UUF0SE1uOWg1OUVnbjh3?=
 =?utf-8?B?SUN1WGlGd2J2NW1zOGZ5ZjB0b2hYYWlhTUxDb1lOZUFmNGR2YmZSbi9QRm9M?=
 =?utf-8?B?QmpBRFRKZEptd2NRKzM1cWttclJxTzZNMFphUmgxVkgwNk1wR1U1YU4rNktM?=
 =?utf-8?B?ck5RT3Z2NzJZLzl0NFpnMndobmYrdW9mdlFhTzA0SDhXZlIrUHJhU2pZUjNE?=
 =?utf-8?B?bDU4clNEMGpmMlBDRnBiQ3NEODhxaXhQOUNXWXQyVENLaVhITnNFRHh0TWFE?=
 =?utf-8?B?NEtWd0VLYkpuYWNOREpSNU01dVBFSFlZZTJTYjJidnVCR3JwNXdhNkFDU3Fz?=
 =?utf-8?B?TFJWd1FUamxHajNtdXM1WnFrQURJNjdCamFVRmc3bkRYMGR5M0lQaWx6YXVL?=
 =?utf-8?B?a21mRVpOTnFQakZIVWc4QlZwK2VRYWluTDkvTXRiQXcyZkpIek5ESGdBNU55?=
 =?utf-8?B?WlhjVzJJRzRveHViY2hiTlNQSS9kZzc4Q2RvbzNXN0tQZ0VxN0lkSWdjV1FR?=
 =?utf-8?B?QkIrSWRxdERuTUNEOFpsS25ZMmtoYUpwWEg1d0lQYy9BaTQzdXZFdVlrQmZ3?=
 =?utf-8?B?Rk1ua0lsWXFMVmlDOUowTzlqZ01UdmRCWWJzei9iZDNpTVVFeGFDTW1Mdk4w?=
 =?utf-8?B?bHptQ01jenBlemxHVUoxYjRYZWcxeHArc3lWK0ZzRWViMEg4eVhYR1M5MEJw?=
 =?utf-8?B?U043bzBYY3Y3QnBGUVVTdDN3Q2RWNk5GYk55UXJhMFpTOGNxM2ZBK0FMTDJ6?=
 =?utf-8?B?VUpPZ3RPNGFQUy9uOTV5L2J4ZVpRdXZ5dDM2NmNJYW16TTU4d0xhNnFKZEh6?=
 =?utf-8?B?V1k3d3hXSmpLL3phMEhhTEZISVlFR2xBL2g0ZXhqMUZObXVxMjBOTnQ3dndu?=
 =?utf-8?B?TzFhcjZrVkVYYU42UlZiRmliWUVzRy9sdzB6L1JaY1RBRnZvdzdnOHFLcXN4?=
 =?utf-8?B?S3UzRlp0RnEyWmdhMHUvSkFoTGw4NFg4Yy9aMGEyT0ZuaXB6TFFPcnNjN3pp?=
 =?utf-8?B?OEhIcExJbHVaUUVoSGxpeUduK0wreCtmZk5kMkE4QXBMTkdadENiSlUrUmV5?=
 =?utf-8?B?bTdDenNSdFdaY2JseWJmNGlWUDlCZnZiWWdSWmVyTm9zWFhkeXVuQW0yS3B1?=
 =?utf-8?B?V0FwSDBFUUJkSFBQUVJ1ODcrVUdCeDlPY1dVcXVEMVVaQUFUK2pLSmlYVDZa?=
 =?utf-8?B?QlIvTTZxR3E3L0Vsemwvd2lrR0Y2NThiVnpLRzY0N3lBakJFRDRLRzlzRHhS?=
 =?utf-8?B?dXBzSkJ0UVZnSks2dnN4ZndmSDVkOVhFVWc1MzF2dU83SWswb2lRVkFDaG45?=
 =?utf-8?B?TGhmUUc0SVB3TjB4R3FVclIvZjdhNkZVL1dYZ0gxODlmanV2MHprb2QyeWFs?=
 =?utf-8?B?WHV2MHFib2RtUStmTmJaYUFzUWZsbkIzclhHN21Oa0ZoY2pmRDVoUDZONTZq?=
 =?utf-8?B?aUFTSVBod0xQeHpnQWZJYTgrSEk2ZUR5RVc1VTk4K2VpUGU4R1lKY3B5b0cv?=
 =?utf-8?B?QUNwKy92UmgxT0gxVW1LOFMrR0ErdktZZGlsWlF5ZmhaanB1ZUNKU2ZST2lk?=
 =?utf-8?B?UnZGN3RzaXFHYVBBMzhPbE5pTEZJQ0lrYUptVnZQME9WM0NJNDBaRzYwU3Jx?=
 =?utf-8?B?cTR3d1N2SjN6YnVGUEpjN3dhOEY5MlBvMGlzbU44KytNQmRBSjRyM05DNnNF?=
 =?utf-8?B?R1U0TUgyRWp4bThDanhFSi96Tm9tYjhtajIydktmVitvdU9pbkpOSlpqbHFU?=
 =?utf-8?B?ZWdZODhKOWw1NS9rYzRlZzJucTI3WEY4L3NhUDdwWnF0YmRtcmd0Skt5dU9p?=
 =?utf-8?B?RDkrUVBkSElnSjhCTHhEdnBoSDhLdm05OUNSQmJmVVkyb0k3Q0dhSFVDL2FO?=
 =?utf-8?B?bXVkanV5VFFpb3BDRmRKeVh3d2Z1T2xaTEhIandxaWxuVDl5dEhFV0JFTUFH?=
 =?utf-8?B?TVVWa2hXd2twekJSTWl1bU5LZS9oc2R2cWVMWUxsZVhKMnRqYTFnR09GVGF2?=
 =?utf-8?B?Uk1VU3FYQmFuM2lLNG5iR3JBMXpOLzJyYjhxV3FoczJwQmVrajNZTHlqdzRz?=
 =?utf-8?B?YnNXOGFFdE1lYkRWcFVkbE1BRDB1QjVLSWFpQnRBMW1OcEp4TWdia0NsVXg1?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9154F9053DA60F43B302F66A295714FF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aU5d32H+KWgyfbrL4TADeU98VZH+2D5NcRGfSNfFeDnB0/rAs6uEMrmjGDey42lc2vAFr/aA4CcV2CfjdAt4xuUp8LEQj/cBFzGoyAAcLerNtlQVESg7HoA+7NkP5jV8GLr4fhS/KR7TVgAZtSEhZ5sf6QRsTNWcVa8tEzy9xvslARCfJVFUQUfXtkzPNvPf7PHXypZIvkPs5eYwDFtSwATXIHoZ/BV/P+QD75zYF2jTQsjXG1hU/UKu1a+8K3SRDVYDyJiNkWhGHG5pEHUS2iaCMSdDDpnnibi6gPc6+RcPHb4DiA9s0pWItIFxna4VDRy//rnOVnaFUZeWfL1sPIMIBVh20BCIsFKhyCFcmm6giOTvPT23w4Rl3HqyR05CbcRC3oiSuqyiOGmu/O1jg9JN+/mYxg/PuVD6RC46V9eKzewTClc+DJU8mGXlH2/QMPIzvVTp0YRPCKoIVIYvWLwk3geRQxiQMdDGN4el+pn5W6cepbEUySHvfJ07ANAMBCAwjurhThZiZfg30vzbL22kDD3iuNS3PHPLykAnWQHj1ca6cd2ts9shLQ4o4gNAQAHs3ISJYwInIuC7r5WqNgKJL+DnNZyu18ZvZXu3Nxk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d761eb1c-b47d-4de8-0173-08dc64674d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 14:03:22.3731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnRNmPU43RWSHDdLSzSOmwu0BPI27bamTlP0AjWWeYVSVqAmx2ka9x4GIcadZwgR04AbDIk/WR/p+87OZ0L4YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240049
X-Proofpoint-GUID: ePiOh9s8d6fMVF_L99unJpIqwpcmmFvz
X-Proofpoint-ORIG-GUID: ePiOh9s8d6fMVF_L99unJpIqwpcmmFvz

DQo+IE9uIEFwciAyNCwgMjAyNCwgYXQgOTozM+KAr0FNLCBDaHVjayBMZXZlciBJSUkgPGNodWNr
LmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIEFwciAyNCwgMjAyNCwgYXQgMzo0
MuKAr0FNLCBDaHJpcyBQYWNraGFtIDxDaHJpcy5QYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+
IHdyb3RlOg0KPj4gDQo+PiBPbiAyNC8wNC8yNCAxMzozOCwgQ2hyaXMgUGFja2hhbSB3cm90ZToN
Cj4+PiANCj4+PiBPbiAyNC8wNC8yNCAxMjo1NCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+Pj4g
SGkgSmVmZiwgQ2h1Y2ssIEdyZWcsDQo+Pj4+IA0KPj4+PiBBZnRlciB1cGRhdGluZyBvbmUgb2Yg
b3VyIGJ1aWxkcyBhbG9uZyB0aGUgNS4xNS55IExUUyBicmFuY2ggb3VyIA0KPj4+PiB0ZXN0aW5n
IGNhdWdodCBhIG5ldyBrZXJuZWwgYnVnLiBPdXRwdXQgYmVsb3cuDQo+Pj4+IA0KPj4+PiBJIGhh
dmVuJ3QgZHVnIGludG8gaXQgeWV0IGJ1dCB3b25kZXJlZCBpZiBpdCByYW5nIGFueSBiZWxscy4N
Cj4+PiANCj4+PiBBIGJpdCBtb3JlIGluZm8uIFRoaXMgaXMgaGFwcGVuaW5nIGF0ICJyZWJvb3Qi
IGZvciB1cy4gT3VyIGVtYmVkZGVkIA0KPj4+IGRldmljZXMgdXNlIGEgYml0IG9mIGEgaGFja2Vk
IHVwIHJlYm9vdCBwcm9jZXNzIHNvIHRoYXQgdGhleSBjb21lIGJhY2sgDQo+Pj4gZmFzdGVyIGlu
IHRoZSBjYXNlIG9mIGEgZmFpbHVyZS4NCj4+PiANCj4+PiBJdCBkb2Vzbid0IGhhcHBlbiB3aXRo
IGEgcHJvcGVyIGBzeXN0ZW1jdGwgcmVib290YCBvciB3aXRoIGEgU1lTUlErQg0KPj4+IA0KPj4+
IEkgY2FuIHRyaWdnZXIgaXQgd2l0aCBga2lsbGFsbCAtOSBuZnNkYCB3aGljaCBJJ20gbm90IHN1
cmUgaXMgYSANCj4+PiBjb21wbGV0ZWx5IGxlZ2l0IHRoaW5nIHRvIGRvIHRvIGtlcm5lbCB0aHJl
YWRzIGJ1dCBpdCdzIHByb2JhYmx5IGNsb3NlIA0KPj4+IHRvIHdoYXQgb3VyIGN1c3RvbWl6ZWQg
cmVib290IGRvZXMuDQo+PiANCj4+IEkndmUgYmlzZWN0ZWQgYmV0d2VlbiB2NS4xNS4xNTMgYW5k
IHY1LjE1LjE1NSBhbmQgaWRlbnRpZmllZCBjb21taXQgDQo+PiBkZWM2YjhiY2FjNzMgKCJuZnNk
OiBTaW1wbGlmeSBjb2RlIGFyb3VuZCBzdmNfZXhpdF90aHJlYWQoKSBjYWxsIGluIA0KPj4gbmZz
ZCgpIikgYXMgdGhlIGZpcnN0IGJhZCBjb21taXQuIEJhc2VkIG9uIHRoZSBjb250ZXh0IHRoYXQg
c2VlbXMgdG8gDQo+PiBsaW5lIHVwIHdpdGggbXkgcmVwcm9kdWN0aW9uLiBJJ20gd29uZGVyaW5n
IGlmIHBlcmhhcHMgc29tZXRoaW5nIGdvdCANCj4+IG1pc3NlZCBvdXQgb2YgdGhlIHN0YWJsZSB0
cmFjaz8gVW5mb3J0dW5hdGVseSBJJ20gbm90IGFibGUgdG8gcnVuIGEgbW9yZSANCj4+IHJlY2Vu
dCBrZXJuZWwgd2l0aCBhbGwgb2YgdGhlIG5mcyByZWxhdGVkIHNldHVwIHRoYXQgaXMgYmVpbmcg
dXNlZCBvbiAgDQo+PiB0aGUgc3lzdGVtIGluIHF1ZXN0aW9uLg0KPiANCj4gVGhhbmtzIGZvciBi
aXNlY3RpbmcsIHRoYXQgd291bGQgaGF2ZSBiZWVuIG15IGZpcnN0IHN1Z2dlc3Rpb24uDQo+IA0K
PiBUaGUgYmFja3BvcnQgaW5jbHVkZWQgYWxsIG9mIHRoZSBORlNEIHBhdGNoZXMgdXAgdG8gdjYu
MiwgYnV0DQo+IHRoZXJlIG1pZ2h0IGJlIGEgbWlzc2luZyBzZXJ2ZXItc2lkZSBTdW5SUEMgcGF0
Y2guDQoNClNvIGRlYzZiOGJjYWM3MyAoIm5mc2Q6IFNpbXBsaWZ5IGNvZGUgYXJvdW5kIHN2Y19l
eGl0X3RocmVhZCgpDQpjYWxsIGluICBuZnNkKCkiKSBpcyBmcm9tIHY2LjYsIHNvIGl0IHdhcyBh
cHBsaWVkIHRvIHY1LjE1LnkNCm9ubHkgdG8gZ2V0IGEgc3Vic2VxdWVudCBORlNEIGZpeCB0byBh
cHBseS4NCg0KVGhlIGltbWVkaWF0ZWx5IHByZXZpb3VzIHVwc3RyZWFtIGNvbW1pdCBpcyBtaXNz
aW5nOg0KDQogIDM5MDM5MDI0MDE0NSAoIm5mc2Q6IGRvbid0IGFsbG93IG5mc2QgdGhyZWFkcyB0
byBiZSBzaWduYWxsZWQuIikNCg0KRm9yIHRlc3RpbmcsIEkndmUgYXBwbGllZCB0aGlzIHRvIG15
IG5mc2QtNS4xNS55IGJyYW5jaCBoZXJlOg0KDQogIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L2NlbC9saW51eC5naXQNCg0KSG93ZXZlciBldmVuIGlmIHRo
YXQgZml4ZXMgdGhlIHJlcG9ydGVkIGNyYXNoLCB0aGlzIHN1Z2dlc3RzDQp0aGF0IGFmdGVyIHY2
LjYsIG5mc2QgdGhyZWFkcyBhcmUgbm90IGdvaW5nIHRvIHJlc3BvbmQgdG8NCiJraWxsYWxsIC05
IG5mc2QiLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

