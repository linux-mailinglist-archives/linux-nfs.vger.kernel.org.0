Return-Path: <linux-nfs+bounces-18-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B07F345D
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 17:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073FC282897
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B8754FB1;
	Tue, 21 Nov 2023 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kU3f57+V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VZrFakOn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB5992
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 08:59:51 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALGx5EA029299;
	Tue, 21 Nov 2023 16:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9zFCCvCm3HrOBr9HPTpwVKmApAXV5ROY9m7p8ihj6m8=;
 b=kU3f57+VER3+uRGZEltr6qqDPlKzmoZwhjhm6ynx1H9ehjy6+ioXh+qhI18ss5CxgOM6
 5ng/tY+TykOhXAAMHAdKqfdWSL7b4npk+hq3hu7skVkRF0zcZ1n8dLVYeLQWN4mK0Fp/
 aAoIdSF8d+yzgICkYeqfmJ1lp4+e4miK72aEvyMOQy/GYyj9NgZU3qgIYXvqzpOZLxwY
 WTwZFwlQaGxtkoon2kLbSUBiqjh8uXpBFY+y7kCE2mhcFyard5UJQXFtEtSHGgXp/OXB
 vgvxNnwfSTnCsVoa4z2GRysXfN85RrUO6QiQv/DwaLVbF7BWSEdQo7ht8lPkT3mlDGnj Fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uenadnjv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 16:59:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALGLVmL037587;
	Tue, 21 Nov 2023 16:59:47 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq7afpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 16:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXlY0V7baiwB0udLCcmGli/Vf5gQclTOsGrlkq/Yg9Bxna3BBvxeTXUYF+3XYhWvgvzHZSRLYuaiPVffiLXd/+QNFqojOpNn4pgiyKl3WyE8nNio/F0JD640ryj5CAoR7I2VkQ2Bt6yFAX4KFm11J+/wKFoXXrNvY9NKgXrWwOY3jxRsQRKQR3roqmtOYzWChv4kGVVQIAeVcgkZpEnDxGHDSH+J1UG4JbykB+qBUlg6raA665ExV5c2sMShDiwao+PbmLw1RzmQ78Mwsv9dAfqb/d1dZJYUVX7ykOYJQJLpNReBNyZnyu44pZ45sTy0RMliF5BJCgb0E07Zt11Kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zFCCvCm3HrOBr9HPTpwVKmApAXV5ROY9m7p8ihj6m8=;
 b=TJtdOMTDwZh6qAcLidHA9k3ZLzkJTT0zKcCKR02CZYGlWMNlQL+1hWu5IKck5DRrck0ojqkatkT0bYT9ZgxTiGQ/A2N9JW7QHdS2rNrmLklibpnGUiIWine2kq+8fJvj0OXhJDcIuMX/aGHE+yixxhoFZtmxUyDrHrz5ltzEjfv5sqITV9MnAR+h0jMQ9vnyo5sePb0DnViVoF38cKTJeMANcjgTcbJDWf0TxKLPJ9eX9KWJaI+k6t8bD5BEqDmtSNHzwYzQMhNUm+WmJyy5R0PwZfeNsAdd1FVOieQEyi8k/WU0p56k6eFsLr0GDUcFXokD1f/a6b7gwet/TGu2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zFCCvCm3HrOBr9HPTpwVKmApAXV5ROY9m7p8ihj6m8=;
 b=VZrFakOnSdmz8pTIr4r4bnMUnpda5IilCTVYKjDYQQbSLY5lV84t1Av48U8e5WmNUgMuqfID3hRZ+suWS1DM4C8NzahWDYthqcMGfnpXyoMIdivSMjMZLB11quUIMq2hB0ML2UoAjohiAfZ4PYSSbZswC3rk/hE0TNDnCHw/f3w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4945.namprd10.prod.outlook.com (2603:10b6:208:324::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 16:59:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 16:59:44 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <kolga@netapp.com>
CC: Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: changes to struct rpc_gss_sec
Thread-Topic: changes to struct rpc_gss_sec
Thread-Index: AQHaHJwgTh02jJAHvU6pH+6SDi4DSw==
Date: Tue, 21 Nov 2023 16:59:44 +0000
Message-ID: <97AE695C-8F9F-4E9C-9460-427C284FBD32@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4945:EE_
x-ms-office365-filtering-correlation-id: a767303d-3aea-4893-08ee-08dbeab34302
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MkGgIqnftjlgyTB2YKLMHkVyif5f7KbbuPltqIcPWXIHoLeMX2ISYsn1VTnETBCPSTMoADCJrl79IEj2IK49bDZjFrsOqg5IITfQW7vaIlqxyfgsT9pfqNN4uAChwpqp6Oq6SozZZpyWhMo93iRRbrjP5zT9XJVRgbxwcNa0yjM20TIAUmETsfd+01drSqVAiFkcjOdzpHN4p0FDq2vLMcX1j/hIk+ThEvGzx9SghBj8jB/XVQq5yRxlU2++K296wqo2FR+rFOChJH7z1qZ+Wr4qPvcHNGMdixTUs/HUghdZyXXUHVJGIqDVfjph6vevwt97q+STQFN9OxcNrD6sm/0eh8jRb/gMgQhVDCEscjkJqW4whjTwXGTfAt4QzBB0PIr6rWFSKkGUZnaM/nu1MyVdO/6glCjoHhhPbnetHgEdkglLD88vJH+qQy+3omS7y6VWYwLCl74HXxl+A8V5vub3yrEQRor4u0P/0giFtDhjWAIRUEoGl3tfYBHCRoo2REEBEj+T0M2xHBg/Jyb9EEB5T8/kTrKXVoS8/+NF86tL8vLnPdNrLKcfJRd3cr86yevrCorrpxt9UVhqhEXgMX2ULxK1Smnk8bTaNVYX7CkkCwmiPUkfsra3Th8HAP+VquzYSxCj1GbpyuA9PmIJjw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(33656002)(5660300002)(86362001)(4744005)(2906002)(8936002)(8676002)(4326008)(76116006)(66946007)(91956017)(54906003)(66556008)(66476007)(66446008)(64756008)(6916009)(316002)(36756003)(38070700009)(41300700001)(6512007)(26005)(2616005)(71200400001)(6506007)(38100700002)(122000001)(478600001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?80+PUb+m/hsxCiV1YyMw/kqwks8dLAP00wSbp5Qz8XkQmXCWewVZkjM3hd7d?=
 =?us-ascii?Q?a3IWBhS5PgHliMANNx2fNCN+FnUfQ2+RwGKdmCKgzmo+ZiAX1oUmI1ygvDza?=
 =?us-ascii?Q?VoAxv7ZPTpfwj/MM5mVs/6Gwl7tQjdZfS6rO0vBbLOQBUoyNKfFava9rkoN6?=
 =?us-ascii?Q?kLc/6QWCNe2vQsTDBiHnY2DQ2KLq377ml/7XJOIpEYPDOZ50g2R6K+Mj5GJh?=
 =?us-ascii?Q?+FR8EsrqmGyyepGcqUJ7pePISOMMo0jsUUBsGo1Xc1ZPLQMesExEBVDj7yNO?=
 =?us-ascii?Q?9wa480kNCBYLTzIk4T8JIQwwJAFW8va+9mZz0aMznk/XKTNWDvebwX6StqYP?=
 =?us-ascii?Q?0D/U7JEJT0r1R2pwFhDvA4HcmgO25fDUTX+4nw1gZFYiZZvtdgmJUcy/4uQ3?=
 =?us-ascii?Q?gDnK7pyEI0qsX03dX/YrnzlhSVAhqIngaJDxhrK9pGCFHVW09a3TDawAJCE8?=
 =?us-ascii?Q?9xt1hTi0i2cSzMQ563dbW5qmDz7VHe1MhIJEHJ2SCZue4zNlA+XcNAQy6HFk?=
 =?us-ascii?Q?ehLrBKvUZQKQjolkzS5TiV7mT5Lb/ozDnMPx0Fx23IyyCv09IyP2eZ+52toQ?=
 =?us-ascii?Q?zzDTOYS9mFZ385zDhEFTXKtMvEwZZvp+a2nd1XKtWTh42bTKb2h3j0kXrV3z?=
 =?us-ascii?Q?doHvQtK/RFEcMNSQyEB4VRRoMR7wNiIgYJOf/amlWa4W3b0j33Gu5LXCj7ld?=
 =?us-ascii?Q?2juDPjC678l7+uLQnB4NklObcj5k0kvGtoCzBY4NL4XIhtoWO4IhrQhaE938?=
 =?us-ascii?Q?wuKbeCwjTEqS0ngzLm1hkKelLY9TVGvyfL26KJ6P/Uon7rHX1zX5SMHl1uOa?=
 =?us-ascii?Q?P4u4A1tnBmFkHWB6L2SZWYjR7C41sErfqsDj8FeZ9tmW5yWi9hlmgBH0flgO?=
 =?us-ascii?Q?Y8COsRsYare8X+iF6m4+Bt0CJJjYt1mA0G6gTNkIY++v4fNaU3UXd4yXYxhr?=
 =?us-ascii?Q?YqJCE2B733ONuv8wwZQLq/IRtDWjGP0SFpubjjiIGozfwD1cATZKo7QYd8hb?=
 =?us-ascii?Q?we0c8Gg8UnCHnUC9qkZZlmQdll9fescpn1GbSWppNm1kPrXSjhEHx6NQbjBt?=
 =?us-ascii?Q?CdesAhTlKDJC4/XlTIBpGQ6OGTkpWj90j7674STip/w+6PzgkNxiBa9ouHL7?=
 =?us-ascii?Q?P8p8WfXtGAJ8GeoaTba84aAa4g+y93WU5oh2oAJ6s4cOKgQQB7Rg91vH7leB?=
 =?us-ascii?Q?aBV4QyUmb8MkaDvSWk5z3miGCfN896uYgrtYkvyXSKDT3lZ0iWVm9BUEZR+I?=
 =?us-ascii?Q?mPzE8UwoBXcVBeOByPJA1L9wsKjbhOtDufacos0/SVKytFpQgs56PIX7xlnK?=
 =?us-ascii?Q?8bCmz8/p5hIh9ggZLy7Cfg/YHXMyM6IjPStMAZL/I46youZlaxSiICsxln01?=
 =?us-ascii?Q?17zVj4J4hxrJDkPxiqxgHWTcQXndmgMXtnrmCi+1BB5e6BFsiIm0wV5B4nPv?=
 =?us-ascii?Q?wIwgPqENzi+AKiEnfEok7J36OD/qZPr3DLx1P1VzPxp2KMQHfODI0zW9FmVL?=
 =?us-ascii?Q?WocXHHf2ia0FsCdsN3dH8p/NnKJbtOZ6iyJXL6Ev/SuUcIkK+XwBYKj1CUW2?=
 =?us-ascii?Q?B6Jp8A/qMmilJ4HAHbWCqfpibMmeMa5bMcqxkBj3bXhhXV5btuCwqiBVWF7W?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3243292FE27AC94BB5EA7BF4A02C8240@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pY9IpaSclUCw9YJ4VvcMUewOYtt01brbWzVXXPweV6zbkKGafPBKnAiVVo7/iJexnz9/sRHORMUdi2T4HxpxucVlVas0ECSuplBF9sFHhix79YxW0vyOQ9Z9kLaG4BrK3uID/LSDXlSZvX9vQpvq1U96RL6xAwVF+bhiK4l12zoT8keNUyg/909ENlcAqznugaPgghA9hLMe8AQJdemrXjIRq2BI1P7kHbXfg+L8LK62jVWxYdW7488rrUvRaDgp5DWZmV1sLfoc1K24kQBy90rZDQ6gdIjuosU4BM7q5DCUGyqKjwpgEbVxEvkR6SRG/9GgFxsKsg5f4lVkrdUef0zLK2CcUQNTw3Ko3nv9v5YErrEBMANN1hi8ooTHZ+UxHGswQKWeCsI/Prv4dHoL7pwKEMaYeHHMUZSRkLZ/FElhP8y4nH24wVhmH+hVZtbFohoWpRUUw7zHGVj4ax6Rf9uEIrDdTLj2++j1I0tvyAXVElztdp1PI6ybYxAE0ZIsYNLLBUkjO4U6VB/IfD5+gEsXUgt7xdU1qX78Vhl+RmLUqRIlXP2+adql2F76eakRYEsdVQxtT/ukXryr6rTTxt5x/b3ndZibIjV5dwPblteqX5iB2HlsdnGyFv78JRPyZaRpJShONIcqUSB19UT33zqaXhJ7zyudxDe1aGDlBKkJlq2JP2MWWVxhQShreOCRIBDxo+x96plnrgKmLCsbUfSbR/vo0wb3ZK5gA1SN53E2hYUxiKIgPTosnuxv7mwqPAdFkYSFjMHL8bI/u+3i3wwzzbIwhyyB0qMbOQEIafDnzjpNB460BNdyx5lzqXS9
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a767303d-3aea-4893-08ee-08dbeab34302
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 16:59:44.7276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBAR9NiQfqSHxOOk91wBHjE42B2CGOV3/ATy+dvUruf4CVRn0y6SLHWPzuuxgypiDZTXH6JOa6dAls/bkn/Pkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210134
X-Proofpoint-GUID: xcRRkxLdAfJ48oBCg1PDOT8zWqUnu91P
X-Proofpoint-ORIG-GUID: xcRRkxLdAfJ48oBCg1PDOT8zWqUnu91P

Hey Olga-

I see that f5b6e6fdb1e6 ("gss-api: expose gss major/minor error in
authgss_refresh()") added a couple of fields in structure rpc_gss_sec.
Later, there are some nfs-utils changes that start using those fields.

That breaks building the latest upstream nfs-utils on Fedora 38, whose
current libtirpc doesn't have those new fields.

IMO struct rpc_gss_sec is part of the libtirpc API/ABI, thus we really
shouldn't change it.

Instead, if gssd needs GSS status codes, can't it call
rpc_gss_seccreate(3), which explicitly takes a struct
rpc_gss_options_ret_t * argument?

ie, just replace the authgss_create_default() call with a call to
rpc_gss_seccreate(3) ....


--
Chuck Lever



