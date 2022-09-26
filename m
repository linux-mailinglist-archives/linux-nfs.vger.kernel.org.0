Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC65EB06C
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 20:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIZSpE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 14:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiIZSoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 14:44:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8850BF586
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 11:43:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QHY1Xn029640;
        Mon, 26 Sep 2022 18:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=p5vNCz3KlCPzQVR9slzS4GWCYRck88kfEAzXz/PlgbU=;
 b=NuVlrOs4vLV947DrWrTXTdOive/tD+aDmhnU3OxWed2XEnnIZ4maV8+sG7t9bJoez0YT
 4B2IN7RvS1dAbuBfvuGp7AqNnCcstdTQQUVfDQYs9gyv9udGJ6zSCjXsbs0j/TtbVlHy
 wGUJNwzQg3P1JtFSHQuF9I0XYW5NHWxmR3+1M5/lrHIjYZN1I1pMdKCM9WfrUV4guaGt
 nLhe/sI0tOMkc81HXFY7A25o2KdrxfEd69roRBEfFstZRNqF6tLyn+kY2ZT30PAZG4hG
 Pywjn8Ds83y34FoV889c1NUyRvniL+AsO8HU/rsCpiObxd11Ta9mAbfcloeF/mTQN2Sm tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpmfdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 18:43:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28QHasMc027932;
        Mon, 26 Sep 2022 18:43:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtps4h1bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 18:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0zmAcvX/WnK9y5EfV89sa0dEIJ+MiL/pRXjsNuA+lasP1evAsNecXr5WaBbRCN9+I7Ar01ZtS/mJdBh8Qly1YmVsVTW25puITrJOKJUjtRnNX1iHeojrMpey8iJW4RtiOXW17SbmQ/2mGFehfAQyMlQhsKWDX5tgZWzhM/TkoxzUIdpv5yGMwWDGpU+sZcksav/4p/hD5S0+7opv4Z9RLS9DLpRQx+XZjjoajy50148RxjQwokZZU5sQTSWlxptzaM8ELcw31vMDfaulxeVAkc32y5m8TKAnbt6d82ldV8babQOa5T/EzdLoydppPkIoUQyyolnGVRgLNjz6pC/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5vNCz3KlCPzQVR9slzS4GWCYRck88kfEAzXz/PlgbU=;
 b=EciTJrmyQgTmYH2fNHIJC/h1WuduY2phlgERMhLCVO0N6BgHTAcE9Bjhts/g/T/qrte2M+oDYEce6ZQP4wjXGATTAsC0tt9yPoFbe8521YvuEkM2S0qsfpx4qFDOG3SrJ4pTQaiFT+E+6Y6DS+0a2g5WeL5TxUGv3n70LlVbSFdhXXPIZ1erzQ+ZuPE0oPHTexuDSvA+49jMCe43qcsKiF/kPhxhGBSIYmgRzzqHekdp4GxJ1I9QE9tUQ6CgNSoGuxEF4uy8m+8Un7EEuu/LJOhFAKmzOtW2lFAF21/D6jDkpbEtDfLAgs3cM7lxWNWkAaTwdRtCmUUXwe5g7t2diw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5vNCz3KlCPzQVR9slzS4GWCYRck88kfEAzXz/PlgbU=;
 b=EYNnYsdy5QLEe6PPw0xQayPrHoFteB3tO5OrMoQZadFpb8KCI8V2nn2v1BfeHI3Ahz0mdETCbnCzrF8h+MN3LA8dztMZpDadZJW8CCqarLNsLptEIDlS4eTyWeuf8gIQmTIZwUNvX7VIDz3KXsP3MvO7cWoF2PkBn3xDUBr165c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 18:43:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 18:43:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/1] NFSD: fix use-after-free on source server when
 doing inter-server copy
Thread-Topic: [PATCH v3 0/1] NFSD: fix use-after-free on source server when
 doing inter-server copy
Thread-Index: AQHY0dG1BPDkNSPzskKQxMgnv7vEhK3yDBmA
Date:   Mon, 26 Sep 2022 18:43:29 +0000
Message-ID: <A6371482-E1B0-4F93-B7DD-5EC5B468C67B@oracle.com>
References: <1664215156-9970-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1664215156-9970-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4446:EE_
x-ms-office365-filtering-correlation-id: 4bb88895-14cb-4eb7-0fba-08da9fef017b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aw9dTQwTi3CMscOBb+f1vrDdQn4RvRtHmir8lf7dkTlWqJFj/l37xhXJmuNYaPowcs3rs3v05d8uOU/um1TXA1+RYckuoMTJ3D4xKvxnx6ZN7JwcwOD6j0oXgKlqdqEle1dvnwxTIsDctRKxBkhbyTsGSStvfm2or1CuB8e96tVJV3Ag7UC0mAp2YfezbZNiMs6ZPvzFTj0T7q9zazIKIdYgMsblSVOLr9NtNzvSCQInyydxFMc2Y300z/6AijJjl4gMMZK0uqAQR1Ygf+NOLGN5NQg0vTVl7rEGdAjxKy1V4p1YOHtbQJ4iZlHId7WAj/QWe2e4fSmrhALoIM++kEBkmFF+DXd0U2RUZhOFQtXMn0n8eqpvtpQq5Ait9XjHRVHiQXhD9KoQ0V9jFLcEF7r5Bp0Z379y53oFHKJQlJAJ9UE9pkw1U4TvLCoumPFdl3ioAWg+NTzQSN8FRxq2Z/q0plvsZKypwIrpPLG8jo0pOkq/bk0bRe+YEj+HWfBQ3Xz56mi5Ub9S7W/9hp7R6jvKrMwMccd3sbwsHfB/pqvw2kgyYry3h5+e23tE4Mgn769O3W4hqLsX52x1GktCJI5Gqn13RAc43JUei31qbwsBmDAHU5y8ZahwplT2GHB4nZcZtasK5rCZ4H03WlaZHJFEqqnNMF/75i43HprGsyZGSwucPAP7kWxsKiutEidX5RvZC683AW+HLlAZnDs6ZqAwKyys4FzML48JmcSy4/SK1Tk4zSfCwhkMaRfTNXUzdoyzMlMqb0MSfkkaY7tcXCRkC0PSgWvmW6KK4FBiaR8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(38070700005)(36756003)(33656002)(38100700002)(86362001)(6862004)(4744005)(2906002)(5660300002)(71200400001)(2616005)(26005)(6506007)(6512007)(122000001)(53546011)(186003)(4326008)(91956017)(316002)(6636002)(37006003)(478600001)(66556008)(64756008)(66476007)(41300700001)(66946007)(76116006)(8676002)(66446008)(8936002)(6486002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c4TtPlfLGirg2WnQekCU8oYwJ1Rb77wfz4x8oeYsyohJg3QGV/J9B20QjiGW?=
 =?us-ascii?Q?qnG0hRUFxKhYhvN3ITf3Qv4NPj+iVHOHnQtwTeI1zNwHUGc1hDCyL6INhLI+?=
 =?us-ascii?Q?a74l8IClQyewVi8+2qpC5bGrh9/lwqClvugj1wLPJOAWCJeoZKYXYlCt1wq0?=
 =?us-ascii?Q?lqR52FXiYYsnydEmpToKdXfAyI3IlgC/Kcbrf47i7jKHdg7XBbwCgDCdcTjo?=
 =?us-ascii?Q?c//ZBO7FN/bMHUx3VmUCnQGNoEgMX0uNDuBuW+SFp4xoEmvF3tBXYeekhVrS?=
 =?us-ascii?Q?OBC4aN7ZAekXra8p4Esy1mBTjiPzQq4r3R9p9WxYBmhLCfsdWzdOXfMTw2OD?=
 =?us-ascii?Q?ME+icdiW1T30UUX3aZndauuGqUQd/QD5b5g/ouQP8Juk98EzVEjal7ww/b/s?=
 =?us-ascii?Q?dbgtJkL5dwya/Iul2lAscNccf1z29VZIR1IwfBkSlBVEJM6fVe5oBCA8j8rB?=
 =?us-ascii?Q?IYsyYKdP777wpMGthQiU4trH22lzCozX1b1yGmLlNkn8CAAC0rblo65QmflP?=
 =?us-ascii?Q?C6H7+lukoNK8rZhIpETsPCQrG4AcNXXGFNDuOfTlWa2Na2Hhj3wPwUslah1x?=
 =?us-ascii?Q?vm8w/6WZJcrX1QNBWEAyQqefd8llNO49LLTNhF+yCgYVKJKQOL5ZKMVsOzZm?=
 =?us-ascii?Q?9/OeIcpkvbPIctAUEVlUsJzewOn9U2DsVtyeU8OamDXOYvydWlqHL+fXlSWU?=
 =?us-ascii?Q?/yFToQ3I2/OAw5nFXBjbM7K/39gEfJhMdJqzT+y850lmfjAs142JRVTLMcXH?=
 =?us-ascii?Q?YmKs+N1c71Snfn8/hZN1LTJK6WVoDGHmvfi9EP9XzT0LERhNA4w2bnUz3BNN?=
 =?us-ascii?Q?esJNO1qjQalAlX8rRZbDQRyaQO3ZONY3UCXs3OrJp0+TOp9xWdlZkm66DGQq?=
 =?us-ascii?Q?5sJloyfmglGpkmQGMJUdeyAAGku4Cg4KNntqGvc9TDRzpYMroJNVQGbzLnVa?=
 =?us-ascii?Q?OSNQxyA9IkKxu9CZ7UtMcI+owsKxxihvc4I7zvZMwM7rpjPC34NoMSXaLJy5?=
 =?us-ascii?Q?3y6ohex5oe1ZphJJ8rYUcFV1sILFkMocUywml/+7IXTKHFEyeCK1viYF5SKY?=
 =?us-ascii?Q?aMR2EofIB0tUYoDMhzcCxfwEHP4vuH3fqhPia7v5bpOrViFQmIV4T0e6Gu0I?=
 =?us-ascii?Q?LLZHgCSfVevt2A8SuP9JxTdxLjyIoagrKMGaOS/f6V2ESHRrxGC27dvQubDV?=
 =?us-ascii?Q?hpJ56jl4cXuEda4mb2WEm9smsUJ5ayUpWB1VS01ggEWZ+sgPclz+4CT6ezDT?=
 =?us-ascii?Q?6fLx7zp+kGhOF+i/JSVJMd+9cAEglDpJ7Rf+ZvgwInJVz2LQn0EPBdEiGelK?=
 =?us-ascii?Q?Ov4yj+PQL0nY2ZXoZATNswyX4fAud+moGWwzMGvLDovSsmy4OXkVKMqXmBaZ?=
 =?us-ascii?Q?mgabaoPfg/XU1zlzxEn3N68o1/be4sPohMfPsJ3WQfKdCByBXh/CSqj9d2x7?=
 =?us-ascii?Q?MO54LK082kjVqrmWIqkcBxisdAZV0hSx8NT/7gQCXug1nVMUjsFlI72lPmtX?=
 =?us-ascii?Q?7Pf1P3Kdg4DMMQKLNGGLW/loyP8ApVfWDKsO6BGt6DCU1Tpla2C0gQ4AgveT?=
 =?us-ascii?Q?qFdT+GppcoAawAB11SgV7pW0Ko04emUJcKL1kPgEHrgwf8x+KLTJhNY5iRkF?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0B8251359DF674891DEE7B4F14C2FC9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb88895-14cb-4eb7-0fba-08da9fef017b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 18:43:29.6563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KyADEpl4OyO2wPLAe4AXAJeVe4aCHCK+plH2WI4ZncCzRli5uSbXo/AC/GlFYK7aPSRPIjIt5pJQBOe64sNDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260116
X-Proofpoint-ORIG-GUID: JRktM9-HBUQr25IKPzfX8f7yRbq2V4tn
X-Proofpoint-GUID: JRktM9-HBUQr25IKPzfX8f7yRbq2V4tn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 26, 2022, at 1:59 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Hi Chuck,
>=20
> The v3 version simplifies the check for sc_cp_list empty in
> nfs4_free_deleg and nfs4_free_ol_stateid, as Jeff pointed out.
>=20
> Thanks,
>=20
> Dai Ngo (1):
> NFSD: fix use-after-free on source server when doing inter-server copy
>=20
> fs/nfsd/nfs4state.c | 5 +++++
> 1 file changed, 5 insertions(+)

Thanks, Dai. (Re)applied to nfsd's for-next.


--
Chuck Lever



