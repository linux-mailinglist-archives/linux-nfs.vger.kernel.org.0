Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6016C5B3C13
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiIIPe6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Sep 2022 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiIIPe2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Sep 2022 11:34:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAEE77E8A;
        Fri,  9 Sep 2022 08:33:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289Dxhl4006358;
        Fri, 9 Sep 2022 15:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0JG5yvfzgkCAisU88/kY9KnHw/EWEesxBgipgsXFXVo=;
 b=wLZGhU7obtbJRKtP9dEhqICfW0x/aIoIE6b5NRM2wRv42hwixarskX75XMW2kh/Szj4D
 6vuZA+HexEHDivtNWfLJkpYv61vphz7+Ph+N2vQ5ButVkDJJEdEt5cWPOacQsdK/qzrU
 yWA8sOqU28FiVASkE7dhS7PyWwE5pwWptG/lt737Pl0VIkVWM1hjdKb9h+faTC3KuM6g
 5FVp68zcXfjADFqggWRbO46XUHPdMGfQPT5mp1hox9OtngPIbZ3TJuNDRg552G9JvX0u
 N2GbV6AmotJFbV8/gWty5dZt+NF92mMc6CXr373H92JYtRH13Mx5NsrELf4Ni6YFo1+e gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2qqja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 15:32:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289Dfts0005947;
        Fri, 9 Sep 2022 15:32:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcegguf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 15:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jukJN2HoijPzrmEmfiavexwheQWQCdTfOD063lGfa4LzS77aITaAZG8A/dv3BbeR5FVlvWbmib7K/NOVe4tSxDA7q2NZISFw60aiNYPJMbbg2Bfh4amuoIrxZX6Als+q0A9aKyepwGAnmmAyLHv3M9v9pIj3wTBeIsv4jlLD4pECIox2/+tem3wme2NPIZ+x1HagUfZUjMN8Ix+WExdjXENWTl00c4rga3MgU0a0a39gxGGXrRX/GroZJz0UG8W2O11itnsXGlzDlTz0uhHlb5uE9+rhB6ggvNHsxIKYsYuZ0z6pAXESwa1tymgYGfawwXTyFK++0qrIuTylT9EEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JG5yvfzgkCAisU88/kY9KnHw/EWEesxBgipgsXFXVo=;
 b=P0LHFAxj83OvQ0EnJfBU1hyUZ0zgEd/3Eu5DFjkt783N7EvuhhExOSOWuruSYWmTK0QC2/lrf/Ixc7MjpE1oREIuoiRpFlJUdLltEeEpTHS5+jqMJbbP1AQFeXbWfS+502/WF9yoAJSBlCfFkjbhyWaCheGXqQUONZJduDemZRBUDPPl1QkHPNPQ1fQ4Gw/7gGm2TKoEEnM51PCm9iwxwOnBRGQi+PUdfyf71LKKdIHFdxfDrAp31al6EmjrtGzn6/nj0ZJcnBn+XOPSpR6Y413IPkeM3pdSWdd6qRf/uJrCccuJQIB5dlZvXjrP821tPXUt5gsNvI08QlS8lSLcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JG5yvfzgkCAisU88/kY9KnHw/EWEesxBgipgsXFXVo=;
 b=fPg9/PXEtMDPfbc+n5Lcus59U+j75EY9VVsvuWgu9/8cuUAVKVoiQzyixH24J5l7MiyiI8C0taNVdRGE+YHYjnhSwWMb18HdHwg3Dm0GI5sP9RWqDlAj67mPhdYH5mWRf/zZuDcsur0wzUjHJ3/NXBBJZMG5rVprSeIR3dzPaiA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4405.namprd10.prod.outlook.com (2603:10b6:510:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Fri, 9 Sep
 2022 15:32:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.021; Fri, 9 Sep 2022
 15:32:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
CC:     Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: remove nfsd4_prepare_cb_recall() declaration
Thread-Topic: [PATCH] nfsd: remove nfsd4_prepare_cb_recall() declaration
Thread-Index: AQHYxBmuud+etxCPsUCTUhGQnt4ZPq3XOoCA
Date:   Fri, 9 Sep 2022 15:32:22 +0000
Message-ID: <D2116287-4A49-4CED-87C4-AC447901385F@oracle.com>
References: <20220909065910.1157954-1-cuigaosheng1@huawei.com>
In-Reply-To: <20220909065910.1157954-1-cuigaosheng1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4405:EE_
x-ms-office365-filtering-correlation-id: 87115e0e-e2dc-4b1f-a0a0-08da92787d9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kW+8+/DRdIoYOSbkXd8b6CGELyRSzQeZqOVIKbwehSXAQezN9wejzQyYxGOizKP5vzGfH49gMjhXCuq2Q+mpe1gNXbGOdHeCwhuPVZFp4fmopXDWwRWHGrWq6JfnT8SPBf6rAnP3Ki1A2UMs4XJKpTTebcqll35sJ7NeBy/FYa/qFyHOwwQ2yX/YiK9d7MDPkhU/R1/GtdFy/I7radC0SW6le26zen+gl/CldV0mFPN0u8MucNTDxZDeOXSw1uCjfB4XG+Frbp9p/SJZpqU56n82egg3aTVqOubiJqNbg1iij99YuKGtMJWgDyZSSEa4sEr8753tga5tk8n+IFv1mmsvhaOi8JSt3yCYewpO+T05PyEHcoHunKrgEOotCqLDB7lnVWrrnvQIC+gsY23dAKgdSSMAn/0dDPnhgxTwWJDD9Hk1lPfKmSDYztj3kz6lTKhE/peyKO/dZAVQ1NoeFNHM/dZGtg7+yuweVYaXbNxHNx2a5204AibO4vof3Sn6qeTQ+xnzAuFTk9XLHrDFkXCcQ9+Lueeuu3swmc2GWRpSXwZSbK8aqhiYbITzZhRa5v8gcKHOW1vuu5XZN9d/6UiQ0Z8/gL+W9zDtJE1hLro+igoyvFXItXk58fhJWHFUSa+JsLkPzMUW2PD73ub9lJUrnd3wIhEtanC2a5WfAGwmN4G4yB3J2/Po7v4E8SQrCVTx7SGmELNBAXo0CieoSa6CSY+UfK61hXIUigb1myth7tecOazC/e2fnPy2z983K5YSSdb2GBM7rjUkME6PV1af9oqwkdqeGGpiJIhF0g0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(136003)(346002)(366004)(316002)(478600001)(6916009)(54906003)(83380400001)(186003)(8936002)(71200400001)(6486002)(2616005)(6512007)(26005)(86362001)(33656002)(2906002)(38070700005)(36756003)(8676002)(66476007)(66556008)(64756008)(66446008)(91956017)(4326008)(41300700001)(66946007)(6506007)(53546011)(76116006)(5660300002)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q0UtBaS3DXNK5Hi9jUg+J1hp/lEwvjTqXOjXGzIEEoGYYUtARstH9FsaBTtj?=
 =?us-ascii?Q?t/leVNp3nDTifDw2x3B7uAOHGFKkOYyQENvLcfM9OeCMIkCy4NpuPq/k1Bpw?=
 =?us-ascii?Q?7568ncAGJAOwBjPkX5tTjV9bkcjJJu84m4/qH0QjZc/5mwA4ISmC3dSOXlbA?=
 =?us-ascii?Q?2YgTD9wPFoBLmrj+ZOEnpHRMn+F1DKTAweb/T7uPAkxmsdDQUUbrEhbaVvdR?=
 =?us-ascii?Q?Zrm6xVScWor31BwlCfLG+JK9VFB7wfNJQDSnEc+j6eYiWn3JgZSBAZ6OOM46?=
 =?us-ascii?Q?+O9ES3hvrjqdxr4dBoBms/PbSlSz7WGq4E50oef8e3N+xtY+6xuRQQnITnj/?=
 =?us-ascii?Q?fc3KLq4iXL7+fO/Tq4VoQEFx6AFK47Unm8YZguXvmbB5Y+QAbDThOgUWx1X5?=
 =?us-ascii?Q?shSmH9mhR9Md++Dgr60iUdgRUY7rjwRipNQnZvpIucyJxsidcNCo9mi4M4eZ?=
 =?us-ascii?Q?jbGwJcfDnC87I9T0myU/j62fJTGVsVwC9wLFW28LS1GztPd2LUdPfK3J7Yd/?=
 =?us-ascii?Q?uaGdA9K4laD5FtNa6ltXbQmpuo6GjzNFePcY77u5jOBSsExNg9WowgdWIpHs?=
 =?us-ascii?Q?65lc1VqSf9pYfNQFs18v0Gii4qnmk3OZkIv6bUG1BOS6g0mfRY2sol64zKhl?=
 =?us-ascii?Q?O/OxFcjkSOjqQ+/C5nSirLm8ZkMbSkOTzLkC9rJEcHJrxvmSgP2F3q+XMQMg?=
 =?us-ascii?Q?+fYBLVFB6d1i1ObOerMrQGuVwclYArK7+AT5lkJmuuzwHVgZMaz65VWjMTkR?=
 =?us-ascii?Q?ah0NU+3/dTwLbHpvQCAWVW7t7ywDrrebku3BLY5kzU1dOdG1LoNCza2WjfbK?=
 =?us-ascii?Q?L25rjtvO+IuBsBR4mLJhiQ0+iAccNM3tMQ1687wiMzGy5HU635czQfKNxIOs?=
 =?us-ascii?Q?9JEjFJ17Jqdbl7vgVRexp3mQ7VvKmUVZyNO/XpFveHrJlBERTFQ0x5bbRFI1?=
 =?us-ascii?Q?LHyNtnu6nKTAAiodX+CjReqHnLUJOH+mZbqkYmb+4vGkBEeRryO4CvgLihfa?=
 =?us-ascii?Q?YtOJEQlWJkLt3vqBOrmjIxMSN16gUT0xZP4PtcRopsbA8sYMHFDM7/G6sncP?=
 =?us-ascii?Q?GEnHV/Q852QDsDeydV88RiCArCNQ35/wADyHSxQFB/2X60SdjKOd5x6+90Pc?=
 =?us-ascii?Q?DhWisidrFiUyh5CjPt8NRTyMKzd15/hhT4mqNVrqQeA4GC8cD6+0pVU89YpS?=
 =?us-ascii?Q?rDDGlvBFCAqhJcPvMX+J2uwEuq/bjfEE5ret8zOBYZVOFwfeVGGwQ0Zs50iU?=
 =?us-ascii?Q?PiDthKFyJegKInfuOK4ZQBQELpnWshyjmZJC0DofV0CtO13uP/YdawJfZtxm?=
 =?us-ascii?Q?pBXUfp+aa9xyXhC3lCQsQ1VVyDj5HiEDyLdovQQAUI1GCtArFVn5Qg1AcAcz?=
 =?us-ascii?Q?NXrHSeybC0i1IaLm0KaLm03Ds/oXW7NaQeElC24LoLgGMGxwy+md1rnYtOII?=
 =?us-ascii?Q?DoJHvacWXYXaW0Mi6ml4QJgnOoFXUjmgvbt4ONNb53X20dNRY0Z23iRNYkia?=
 =?us-ascii?Q?Q/7frLMy4T/eG9Iszwr09x8ffja9ZGy8KtdTDeYfFxZJttp/jr0TeCdwuNMV?=
 =?us-ascii?Q?raZtAvM7EGzB+h6sy5UTPWgSL1kZuh8xDzBztfJG40ZbHYVq3mHxYusuTs7A?=
 =?us-ascii?Q?nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63DA7646BAC68E468841F49B2A006A81@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87115e0e-e2dc-4b1f-a0a0-08da92787d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 15:32:22.6803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xN0UQfbRUSRz1IfjgjzFOZAr4uFR9Zoqz/XUd53rag+epEoDaa8Y6PDlblBkmMoCtVEARcjfE0FzSZbx8Hyp5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090054
X-Proofpoint-GUID: J8qaCJpEPWRlLe9xzcffsmxDujA2JJ0g
X-Proofpoint-ORIG-GUID: J8qaCJpEPWRlLe9xzcffsmxDujA2JJ0g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 9, 2022, at 2:59 AM, Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>=20
> nfsd4_prepare_cb_recall() has been removed since
> commit 0162ac2b978e ("nfsd: introduce nfsd4_callback_ops"),
> so remove it.
>=20
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Applied to for-next (6.1). Thanks!


> ---
> fs/nfsd/state.h | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 5d28beb290fe..4155be65d806 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -697,7 +697,6 @@ extern int nfsd4_create_callback_queue(void);
> extern void nfsd4_destroy_callback_queue(void);
> extern void nfsd4_shutdown_callback(struct nfs4_client *);
> extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
> -extern void nfsd4_prepare_cb_recall(struct nfs4_delegation *dp);
> extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_neto=
bj name,
> 				struct xdr_netobj princhash, struct nfsd_net *nn);
> extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_=
net *nn);
> --=20
> 2.25.1
>=20

--
Chuck Lever



