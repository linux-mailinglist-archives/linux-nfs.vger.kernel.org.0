Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A637BFBA5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Oct 2023 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjJJMkM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Oct 2023 08:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjJJMjp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Oct 2023 08:39:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3A0122
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 05:39:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ABic3B016300;
        Tue, 10 Oct 2023 12:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Rk4/SyMOiJvWz/aGrPaU/Ucl3q/ExmP0zQWveQTvdOU=;
 b=GoYW9mnmjRBGdFFrF7A334Ge73CiOUs1vDhvicnIZcr821HrZYBmW71mcSEhVZfk+jHg
 7y9n7lRbhsR+jQRSweVAXoDxtRL996KIW95iTdAwL0sHQxT1egV75vnfkKmK1PZtEi2h
 2XI8tKaxu4472gNZlb4ZVSX6b0kmSWxuviZwOKw8f4dCRIBE8H5JecvM8y1k8HtAycJk
 rsmyDnVQ62o0ZJYD47lnFrGnBGavVHyjlIDD3uMA3c3rs9Xdy/d7XecYNeGqB54U4Y9S
 zXZZ9dTeGumEbiWiAZC5XmyBUII4di2lVkS0GDjUCP41aQzl6lb6+kA8n1RNujGVnCOf RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx24w0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 12:39:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ABe9l2014448;
        Tue, 10 Oct 2023 12:39:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsc43yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 12:39:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr1o/chEONGCax2w87c/L1cyRApg8gtJqfYuEZGOzoc5RYJJ1Ddpjr+RK7HuwDe0AaAS0jmQ0lvKluxEv2RIegGzbEL/fYFQhFPDLGDgEHgXZ9FXDueUts+iq0S4EZWzDl07p+OGUj5i0603ypkEVF8H9UF30Uj2vbISdWhUBH2STD10n2k/K+XoF86AuVfzr8qSV6legvvFBhuJ96J3X6UKCYYceUkB2SPpmKt5yuZWkb+tKar1WsM1NE8VZRPuqpxNzij8TefUqySNaH0HbE3FfpNFFu642uhQ29MQ2Npw4O4cPs4KVtsG19LvvzYMoGAwL8rcms2KH6dxzYciQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk4/SyMOiJvWz/aGrPaU/Ucl3q/ExmP0zQWveQTvdOU=;
 b=StRewDL6tfPANx2WUeHQRMgh9I7YWisHAWzhAO0M3WvvMuu70SPJYTIEDuSDa3A77YkQf2U/g7FiEK63E71uCeWC07Fs4+vT5sgVP1ff4iNkh0L0knxLzNh/DrDNm/ghvTqptPFvVSqBNyeXgSKRlS9HAxFR90M2U0JhTUS5abZFFDvG88ppZVt/bE+2pZVwJIdkWJUkpPP2VRc7LuD/5uda/VxbDLLlsJpI48zRrulmV0ucRk2YKSU6cQYiTBm2HkrNIgbPTBHHHTRUBwH3CaicWYo+Uow4v6mo98HsJ/UtQHVl42fXGUAcsAO4Lu24Y9AlBHhrBvyIAASW4SCkUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk4/SyMOiJvWz/aGrPaU/Ucl3q/ExmP0zQWveQTvdOU=;
 b=ZGGAAYoeiL+b7jbDGxNBEgCqTRdei4GqgyW0ptq5zdO7elvQlSK7M34LOX2iZZEa6ni1hsXnj0Ks7w7LwOvALcyj65+1W0ccUidOBW3m2Gr29fe3dyJQl9GeM1t+FpeVnkGKu0u0XW3rawKGKSm2dShsMGZCliKHZd5i40fSaFc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Tue, 10 Oct
 2023 12:39:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 12:39:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH] lockd: hold a reference to nlmsvc_serv while stopping
 thread.
Thread-Topic: [PATCH] lockd: hold a reference to nlmsvc_serv while stopping
 thread.
Thread-Index: AQHZ+wlZQQI+ju6EmkWAayUDxKVMCbBC93oA
Date:   Tue, 10 Oct 2023 12:39:24 +0000
Message-ID: <834A724C-4A44-4277-AFB5-D639FCF2900B@oracle.com>
References: <169689454310.26263.15848180396022999880@noble.neil.brown.name>
In-Reply-To: <169689454310.26263.15848180396022999880@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5293:EE_
x-ms-office365-filtering-correlation-id: 153a457c-8cc2-444f-c98a-08dbc98def78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oRJxtcuQwUznKTGoh6llxFag1wjZDLyHHl8u2msQf82rfb15xxIng1OO1YB7VzL2+H1sCyNs+qt0OExL3Plu+AfNJf7c5pnOPWWH234c1DmVgi5P1qp90TPYSCH+HSCSheysBBdz5D0Fz6YSTw3+e8iSAJYHGPuu8qFwwZU5oK+XWhUoxLxZGSn7bmSbmimc+VLIvOu8r+7DybX8yoUK3IrULcOe+Dt8wBbKfww4UiX3w5ZoLhqvnaN0vZj71ZpgxIfmoKRFC1Aw47vV2IuQ/fq7alhiBAEByY5TGuMx2swhoIMnpZj2s6ZH0aJH8SqQmNvF65QGvfjRp9r2I3xXUEeAvypgAfMlYjKnR8JDE9Cvo9noGu8uB/4DVlbBi46AiU51s0ypGLjzXUwhoFy3hHDO298+yt9cyxK/NvIHS5H7kq0HL/59pKaX5qI2QFSYgnFdKg9Tb00vKEk81aH9fh8HEvMG69jib0rjRvUWY9hknRVkSbk9bDsQL0TgunmZC+fyywJgl3NkBQmpURJqatIuM5PESBo97Z+Ehwby2ra2tYROclbtkuxNib6VcF+MFKPMztfkhXbMXcTiPmjVP+BsKG39aBD+aybEC3dAW6w0XQjSCEekpvDNO+yHaX5PN9o6IgvYv/lfpByLIpmOwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(6512007)(6506007)(33656002)(36756003)(86362001)(38100700002)(38070700005)(122000001)(26005)(2906002)(83380400001)(6486002)(71200400001)(2616005)(478600001)(6916009)(8936002)(8676002)(4326008)(316002)(41300700001)(5660300002)(91956017)(66446008)(66476007)(66946007)(76116006)(64756008)(54906003)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iaokK6MlR8vJLExXCHZp2NQN7NC8yo1NgDER+8lt+OUPHXLJ47jjpfbgSLeK?=
 =?us-ascii?Q?KxbiMgKyRjbCnD/b4Qf3b44194yyOxWAo2+K58Z0U/x795pwaEh3vITxK2TU?=
 =?us-ascii?Q?ZrGL33PJz1Q1AM/GScQisGtamhX4TEBW2VKUD9ttg62kDRmgOw9w7DAE6VTZ?=
 =?us-ascii?Q?NTq2u/ClFR3LJzo2I44JOeKi6h0GYYsBu6QWVh+Zyrwvu5r96lyR+HByM2bm?=
 =?us-ascii?Q?MzRbHdDYj45YH2HsiGb5Jbk7gdGTR9KWvkHWPjg4f01yR6NM/ydzrSR2OZTd?=
 =?us-ascii?Q?GSv/I6/KGm2nzRQo8suAdNn/lBlFvRbnBMNIcHMrBn0KBXUR1cf8iAD3L7Hk?=
 =?us-ascii?Q?5tL6AVo79TK8tEZS24OCZQpCDjN8H3HmrrmpxRrQHQaHTCApOms3kJZOE4QU?=
 =?us-ascii?Q?rsDGK42eiMBftlH0wa+ZlFY+/Zx3zYlNHqQLwsGUv/nvfNEBPhmoCjpM5dFK?=
 =?us-ascii?Q?mk2nuzc+IXeOit1GYR5CAVZRIqcMccdqBZmJxEETW1Xia68E7oCnZq5UyM5M?=
 =?us-ascii?Q?ybFDhhEzddvi71QmC2hYH1nsFfhs8xAUgOGTjNTkYn1uBgktZ5f/5u0iEafN?=
 =?us-ascii?Q?Jd7VkFuSWY9o5Zxe9c9Nx8lqr3fPUILJLQlhlP0B0w1x79+0AG3kUum6+hfA?=
 =?us-ascii?Q?Wfzp9Y2/p+jCfhgse/bb7HGr52nfKkO7W5aCzIRcowQcGkGWIlH4ODDZQeTk?=
 =?us-ascii?Q?1eAnRUYu21N9bN+L6IfOjdRuqeSbC28icdSbO8sVTglymkAoXI9yzWW+HC7E?=
 =?us-ascii?Q?pqzSE2+XUIpEODC14EK2YiUoVHunMDs3/rsglxX/jtFvFXn8pZNFmSucOIJC?=
 =?us-ascii?Q?tS47Dusyzk7OJNwW9ynJq7TnDJotP/TbZtWcC7lT+wGoPtcU/k338yT1lwYl?=
 =?us-ascii?Q?8g5DRavHOEE0BPJ6BtEyE59B9xbWdhEy8H95E2DvLKomPslRm/EqQsTgjR99?=
 =?us-ascii?Q?f2IRN9Yka8Kz2lmhM3U0LBdCK+Hb5IB3Xtei1lthHQ2L6iHZrjEmdiDeXB07?=
 =?us-ascii?Q?FiNz0qqhfrscxyatkLlWMQT/SZqm/No52M6s0a0ID3pCgecz8DyEdqNRSkLA?=
 =?us-ascii?Q?XziuspNhcGVwwRh1omU2SsEOnYwO40Xg3vBSsr8KCImojBdQOrIZ13FYkiHU?=
 =?us-ascii?Q?iljaQXIyhvitR7S9T4U/bi3u8tqAuDIp3YQU0pJA9vnePQn2wOnfgPd+UKeg?=
 =?us-ascii?Q?qpZjs8dQ0AGwrQkMVyU49Y8aKhGLmeCKmh5Qw3f/wehN8whZWMMTnbBhKNcT?=
 =?us-ascii?Q?SEroj9DcPhqHGP9BkqydNueoEvV+Hu5saRHTBIJx8ImywKVJWVqrRviTYpSL?=
 =?us-ascii?Q?d7nyQ6XETTCdkDIp20Zpx/6riJCpv0FGy+tohxQEDPKIZy06GS4Pk0uVoMis?=
 =?us-ascii?Q?2YHd+qPoa3M2rhAqD/VVeSesp9dBykCwEkGWV2/PWNKvegiqm2AZksrDGucN?=
 =?us-ascii?Q?ewA6J1RrZ9I8sdOjLeMIE83JrZsxdml0W8K8y1f9ePuojnzx+7woEQYgnIbB?=
 =?us-ascii?Q?qbgzIa/EDNM/R3m9J8RmS8lJwpF/uKtQ19VT6KgCgNrUiT2gh9j1II7k1zsV?=
 =?us-ascii?Q?b5PO1P2LZpOLitgBDi+rxMZnYqZHjcd+OlqoVwoiTf9Do9DItKJMnBjLYhiq?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EAE82D10463544B935E9A5C0511CFF5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CoiSu/BAiz4pBnJhjQTdTRRkYkXkrhRxNUtW6qbJwSoW+G+96zWYYDrbPEnUy/XjwT/Wsp8kRaQbGoeGMy71UZxLU9xQgG1gW+iTxhUiBYtF6Eudd+0pdhaaC1t4wvxUmEViqxsRQ5L6q0xOkE/IIqF9hJwoToHYwoxJoRb2kmu8KJCSF/EOKTQM7uS6vz3MMbPJu7wY1WLi6jqwcwOC+K1P3cqpfjpeEATl1CctxnEcmqapDOjfVJj+Brp+0gCyYSRPNzlz69fyDcc7B+m6FQxSA4YZ8W3Ugx0g+BV+YAJ7vDIglmtGcARlt/IW8eeXyheQz+jPBzsdNcLB2Awy/d3X3bAid6/zLIQjEpdBbaxV1SHKlTpkL6EZRQmYBS3A8Tz+BtvhxLRXRDl4aq53WfkTMHTkJQwHd+rxK3A/KNNWPdIM1r5Gji78jrWjKrF8Qrk+kRXtsMAKBYVtp7oDdyz5Cmt2i4dD6TLCnVox/Ze8mOdjxzqfNByAua5Tq11BJlADM/Qp6q/4yA8asd7rr7XfDbh3egHqLxJFmFFRV1NfSVvSt0MzR6o0GLmY0js10zUYo4TGvMSJ6uuI3mdVSzc/xvskzfVVgygmo8XMOAr21CIGdFxZkpBDkwbY9R8IbGqoTkCKADNJS3MZ4UDY1DbxldUM2HHLCJ0gO44ADw2FCMrxkdKUH6kf/BMWv8EJKPaGLDyAj+eQYuafcgTNnUdKUV+NU4VbS6zj0EheLUZXyTqkIe6JlSlXXiIoUAMf/KRD3HZkoWDxH1i38sXXHop/RqnbjaEJeXtSYED/MbxyT6m0nYLMGmRfjMtl+cHg4VQs6Jb/w3qc13SuVvQrQRHoLkrhxtgsOWXbbLcRn2WBLqqVNQwcmNdHuY5rbIkb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153a457c-8cc2-444f-c98a-08dbc98def78
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 12:39:24.8084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/ENhqmJrHhpJ8rV0x8Q7GxUw/B3E0h2EjqSM0v3C5rZ0fC61NTtVUzqRcG9dSiCZpohhV+AlLcsxPGr4Mg1Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_08,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=878 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100092
X-Proofpoint-GUID: CKGF15627rxCsf-nLVHQ1Ba3YVUQW2Wo
X-Proofpoint-ORIG-GUID: CKGF15627rxCsf-nLVHQ1Ba3YVUQW2Wo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 9, 2023, at 7:35 PM, NeilBrown <neilb@suse.de> wrote:
> We are required to hold a reference to the svc_serv struct while
> stopping the last thread, as doing that could otherwise drop the last
> reference itself and the svc_serv would be freed while still in use.
>=20
> lockd doesn't do this.  After startup, the only reference is held by the
> running thread.
>=20
> So change locked to hold a reference on nlmsvc_serv while-ever the
> service is active, and only drop it after the last thread has been
> stopped.
>=20
> Note: it doesn't really make sense for threads to hold references to the
> svc_serv any more.  The fact threads are included in serv->sv_nrthreads
> is sufficient.  Maybe a future patch could address this.
>=20
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Fixes: 68cc388c3238 ("SUNRPC: change how svc threads are asked to exit.")
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks for the fast response!

Should I squash this into 68cc, or apply it before? I would
like to ensure that bisect works nicely over this series of
commits.


--
Chuck Lever


