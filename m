Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44183555326
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jun 2022 20:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377556AbiFVSQ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jun 2022 14:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377566AbiFVSQ4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jun 2022 14:16:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D73E0E8
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 11:16:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MFQZCL003129
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tyy5YYkos1bXTy1Co2a5akkoRnEVU2Oz73YUBaA+RW4=;
 b=sM000yQWokfpeI+QdbI+PhXk0llGDYNSEavv6besElRJrzBcZljDrOU4pW6lltJ0JPuW
 Pz0HdigvRConmFPxdVfSIWd93ZCHlW7Rx6G0AAkoA9WyEGj8mes3eX2+8zYgIKCusnfS
 Jds+PZI7qenr+YALohmxYSdZJ+aijoq5jD1c8yKP0+8AdK+ccei2YkbND0c3B7P4ddPD
 zPJZnmCzDq2FWdwd4orKXNAsZXXPLtBzyIDZN4Wh2zrVym0aOtJMADqUZ8I9Fl0g9Xle
 ZfZUi6jDkPg7LaVRX2KRzNrWxinh+75cZvCsGSwF4fpxOtfYg+SV5ODModWLlizeclZN pQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u16v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:16:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25MIAebE009227
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:16:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3wnvtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:16:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwFZFLOH1ZlVfSJ3zmwVkux/0DHWjZXxo4xNU27DmeB5TOG4hQj++m+ueQSuLTozzN6Xm3+t/mkxIgcJDFmaL27nmdHTAzN8oCKQ8fSLrfE2MQ0hif1k77xsg+Y3iczT/dgAYWicQy4ugnhdZHMSSYgnXpxUIGHCQXS4MsXp28gatJw/3TcRyz4YJOpUwvNHtalQSK9H5VS1uEQdRNaPSb8iPxnaaZjRt5qPQ/Vb3Tcsl2L/OTnKLmAxM1yHYSEbsOj0b7/wl5mU7KYhYvIDcDGn2JyD+c4HW7zwsHd2xu3Hoxb8DEdaOp9qtJHRK0zZRnKP820475bE/6hRldah1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyy5YYkos1bXTy1Co2a5akkoRnEVU2Oz73YUBaA+RW4=;
 b=P93e3xd3tBQn6SNJppjF+sa4G7joqfbI1oeOmlu+NFF6QmebL8kfWr7teLY0XryCEg100tSI4WThDIXJEV8Xy4uKdJ2ennqrhlmEXTd4Te8sS514QeQwWV9WqlFCwXJN71k2CUGjgpttrbXqAn6ofWIAveOhmAlcRbY/8gloPE/mmPPiBJ7IHWxu5wuggB6NIWNJHtKvhzIKw9DsdO/kxgE3HSTDDU/2nNdtsi93UaPUgmYHC2FUdkIgHLx5m2U81EIXptoIuTLf8qVsrX9c5nZ3QHdx6ITThDF0/InaysiPnXL4o8y388w4Yh6pn159r9oQRewTf7JFNozLsq5uWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyy5YYkos1bXTy1Co2a5akkoRnEVU2Oz73YUBaA+RW4=;
 b=Ix+H1eO0w/etKjB7aGNOxk+SwJONbaiMS4BGJKdpf9DiBy0UfwOnjhC5SnEj19QqocrKgtCATgXdSTR1str6oMHxKFCFSUzA/LHBiEwJsCyE8Bbzpgq+m9IWu4oihbYZaO3OVTns4Tg0RIpyzu7uguDkbIHfv0xAJsU2vjRvzaE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4339.namprd10.prod.outlook.com (2603:10b6:a03:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 18:16:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 18:16:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: Fix memory shortage problem with Courteous
 server.
Thread-Topic: [PATCH 1/1] NFSD: Fix memory shortage problem with Courteous
 server.
Thread-Index: AQHYhmQKbJxYdZBYMEmMSAfehpjGQa1bu7KA
Date:   Wed, 22 Jun 2022 18:16:50 +0000
Message-ID: <27586B46-7926-46A7-AFF0-4E0F322B4225@oracle.com>
References: <1655921718-28842-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1655921718-28842-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74f04086-95b0-4ebe-c39d-08da547b608a
x-ms-traffictypediagnostic: BY5PR10MB4339:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4339C0E45CB1ABB74AD951C593B29@BY5PR10MB4339.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGxyzbAR9LtddnpFYU5fn330EKJKQWR9y9fcuAEq/g2lb+lWCHs2LrKHrYv2wrKkwACnU18XFnw05c8pgVPgZR2sPZCBiiTofz+F4ry75MhIZMcfUt+/sSOJvv/79cQqp9rsuGdJBJBk5YZBDCsEfhTMRKV0c/yvbaSxVrSlwEMQO8KMTcaQu8oL46EMmQAtpUn6nFMQRI+Hgnwft8y5sA9aMF2QUgS+IY9DoN14WLeUyXgZ3yyxLLGGos/hXQ2pUjvbym3PEwOk1StSDuiT7JELc15DB5T8Grj7Gc2sXa2oMit5uC/gwgkUHgdDQ+oiGuntyBFYtocxuh0agYK/GDOPn2x7cuTzVNtwXPbOVB52PPToEEOeAzlSXEbKUHP97cyk0PDyNsGxkBII3RV4J2hNhUg0I2FcjKqsy7yWv1rKqQqvRA6Re56ocImAhU7K2yoUbLYkutrD9Qvy/4QQ35y5qbAZO5cU2CGuAkKI/CFaqGnO+xZKFIOgOHKuJVvQfth3G7Rf7VlpMw1X0IB55CQs3swxCPlh4aPGssWTJSroYIZ0fUlsuBgGAkCwQxiK2abvIuwDKDyUDrRv2EfHUQxnG1XocKlBPvZZGRDVfQ/kQujNIUconhsQ86O8f2jdjETP53pxMzn9s62V1UlJZHu6iLKZDoDhMPmeJZT4xOgqqTfaAfy2acn9eLIr4449dJPCDEe2uZN2O0YiSfj0VZce5SdHpsru3gZ80o/Z5xoRo7v2zKZWS3l6l+qVcG1f2NUtVCTfjpVuY1shZ9URJG8qO+XDJMBSwxWWvwqnyxc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(396003)(346002)(376002)(6512007)(6636002)(53546011)(38100700002)(122000001)(41300700001)(5660300002)(86362001)(6506007)(33656002)(26005)(2616005)(6862004)(478600001)(2906002)(83380400001)(316002)(66476007)(36756003)(8676002)(91956017)(76116006)(66946007)(66556008)(8936002)(71200400001)(4326008)(66446008)(6486002)(186003)(38070700005)(37006003)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sJOu+/skD+9G9w2BJqDi77DPkpTOLH1LzRZKryhR0CzBKm3yIhGt84gfW/u2?=
 =?us-ascii?Q?xxpyqf8PElhDSGGIUszZEHXy/ghNui4gFBX4qAkS7mxMhcEhWywaeuVvqM6g?=
 =?us-ascii?Q?93TYcxbL79udq/TGLIux6tNGPivH8h4pPqCpuCa81Hj6CKiAWyDVNVEbmB29?=
 =?us-ascii?Q?/5cVyiwIzdbGW7l8XW+jD4G4JJHfPGMSXmHKyHQS9Fry7AWa4b9mnFm9Kxdh?=
 =?us-ascii?Q?0ImPttjaDsStRUxs60Q5L6lP4hOVv7qm+hpr8z9nMDPXPBA95wMZb/Zya8kM?=
 =?us-ascii?Q?I+ysC/+mdvJ4B9GPgY4Aonr0uNxBBVtGdNsryzDC+L04hAi/SbDmkxkc69HK?=
 =?us-ascii?Q?ctM0EflQgCgDgb1EkpQBcdHVlNSJezfb5f0e1QnHPtCDdpvBeNJFTujGxr6U?=
 =?us-ascii?Q?wg2MhBU/Hi6DtVzLbrQdhxKhQbwnPA2Al7t+w4+ZJCjWxojyHRmkOz0uqG78?=
 =?us-ascii?Q?R6ZTRBHedhbvVdj6Nrg7/7C3eAIxxQ61lLtJIVF0qx/59PT4WLRQbgAieNnw?=
 =?us-ascii?Q?3yxN7iOUfcmAf5/IasJJeV2g3b3hZPKEvFqZYeYHn6LhCvz2zmdfOmzYDXjA?=
 =?us-ascii?Q?9aVJIHJOmdAuDvUEYdK8cPxn+72lSplchd2GYnEYkoS1QLTkP+YOsMnGit9K?=
 =?us-ascii?Q?GqjusZY3H10Voqb6HE7t3aQcHtrhdJ9t81eDqCMieCDMT7RswAj66bKSR9+6?=
 =?us-ascii?Q?0qAiy1Cfq4t5bUKirLIVcODqS+ErpMTxcdq0dZVjsNp+h6kW1pJb36/wGJbR?=
 =?us-ascii?Q?8ktWhF+wy764e6GYZLeWp7ufDNMLbjjWuRE8X4zzvwoa+biynSxDfqhoDXLM?=
 =?us-ascii?Q?kwCvdh0fwI4Gu0ocd/7GyHQRmWJg3CSVo7HQZ1ixS5IyWcXkvfPW0Z20K92j?=
 =?us-ascii?Q?XoAUpaKDU4HYJahtEXtNAyUWq9UM5+FWOmFPNJZ6db1PdOepNzZzb5DRXaFd?=
 =?us-ascii?Q?hmbBa8ALIdJ+RiBjNB9bKvhJCmPaanfHa1N8mF5K0cnIFHo7IAj+lBciG8Ji?=
 =?us-ascii?Q?5lB1btaNo1lxYsFt9wlVcumZnrP2QE4LcbTS43LZEwBe4doYdw0TcT3kH/TX?=
 =?us-ascii?Q?z7np2Val1xV2ksG2ykW5aAB94nX8Oy+TTz/WoDHmVIhgyAPu60pI0OBzAIRD?=
 =?us-ascii?Q?X+L6sYorBSRcrSeMA5LkPpkKq5E/VbbciWoVutnPdRpzR7M4qwM9IOKUZIsq?=
 =?us-ascii?Q?wxX3ICVXavIWDLkG8/V1ulg7tofwzGJykuxstIJILc0uqmuGz5usD/rn3nLJ?=
 =?us-ascii?Q?eQo5gP8m4jTGZ8YiwQH2mW9s9GV7RJ6sXpbC+4cXORvCv0tngCWmyWwFvOxr?=
 =?us-ascii?Q?RPME2KlN9z3FkNHQ6AN6m+XDadFxpOJcrLTfBfaFEPzXMpafnyGeuEPhj9Ct?=
 =?us-ascii?Q?sgAR90HtWEErNYa5AQ7CiXwydmBHOn1Vaj1+wL24O9tMhKoZc0syOLuOU9pb?=
 =?us-ascii?Q?2gn4j6OLDxrqG/SkIQde77bLghM3Pw7Yq5H/FW6Qr46oDbpXC/5Vgwm3SIPF?=
 =?us-ascii?Q?vRmsRi/xShrL6pkjCl2EFMMwhIjqYzZcpkKWPRQzUyRBqeJ0a6EKpMOiVCxT?=
 =?us-ascii?Q?uG+D7nQyux/YAHMcvdCK7MEY5N6RT4l86qV9R9LycprP2fwgPZRQTku89l4g?=
 =?us-ascii?Q?eAdAfDqgg+16HSUNB6zhVFaHXNa/miPYKIq4YucpU4FYw+G/xjimqVZFdLf0?=
 =?us-ascii?Q?nyzmBR7rfNKd8oSHA2PMxdX4tKWDzMYlf7yqT0aHz7uXjVKqFmZQdHD6C5DL?=
 =?us-ascii?Q?ZHH14vwLA5D+u78vB/ofhRa6qYznr9w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <846CD5D035213048A3DBABA92D037AD2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f04086-95b0-4ebe-c39d-08da547b608a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 18:16:50.3126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a05K8uKIDVc5+4QHuxnApyti4ffqWuA/gLa48uDAt9DQkAJCfzgieIjrQmRViDxJ2XZLH2p85fnk5PUCC8KCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4339
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-22_05:2022-06-22,2022-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220086
X-Proofpoint-GUID: EiNLXs2wG2PtgRLHosEn1-J22FT1_AF2
X-Proofpoint-ORIG-GUID: EiNLXs2wG2PtgRLHosEn1-J22FT1_AF2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 22, 2022, at 2:15 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently the idle timeout for courtesy client is fixed at 1 day.
> If there are lots of courtesy clients remain in the system it can
> cause memory resource shortage that effects the operations of other
> modules in the kernel. This problem can be observed by running pynfs
> nfs4.0 CID5 test in a loop. Eventually system runs out of memory
> and rpc.gssd fails to add new watch:
>=20
> rpc.gssd[3851]: ERROR: inotify_add_watch failed for nfsd4_cb/clnt6c2e:
> 		No space left on device
>=20
> and also alloc_inode fails with out of memory:
>=20
> Call Trace:
> <TASK>
>        dump_stack_lvl+0x33/0x42
>        dump_header+0x4a/0x1ed
>        oom_kill_process+0x80/0x10d
>        out_of_memory+0x237/0x25f
>        __alloc_pages_slowpath.constprop.0+0x617/0x7b6
>        __alloc_pages+0x132/0x1e3
>        alloc_slab_page+0x15/0x33
>        allocate_slab+0x78/0x1ab
>        ? alloc_inode+0x38/0x8d
>        ___slab_alloc+0x2af/0x373
>        ? alloc_inode+0x38/0x8d
>        ? slab_pre_alloc_hook.constprop.0+0x9f/0x158
>        ? alloc_inode+0x38/0x8d
>        __slab_alloc.constprop.0+0x1c/0x24
>        kmem_cache_alloc_lru+0x8c/0x142
>        alloc_inode+0x38/0x8d
>        iget_locked+0x60/0x126
>        kernfs_get_inode+0x18/0x105
>        kernfs_iop_lookup+0x6d/0xbc
>        __lookup_slow+0xb7/0xf9
>        lookup_slow+0x3a/0x52
>        walk_component+0x90/0x100
>        ? inode_permission+0x87/0x128
>        link_path_walk.part.0.constprop.0+0x266/0x2ea
>        ? path_init+0x101/0x2f2
>        path_lookupat+0x4c/0xfa
>        filename_lookup+0x63/0xd7
>        ? getname_flags+0x32/0x17a
>        ? kmem_cache_alloc+0x11f/0x144
>        ? getname_flags+0x16c/0x17a
>        user_path_at_empty+0x37/0x4b
>        do_readlinkat+0x61/0x102
>        __x64_sys_readlinkat+0x18/0x1b
>        do_syscall_64+0x57/0x72
>        entry_SYSCALL_64_after_hwframe+0x46/0xb0
>        RIP: 0033:0x7fce5410340e
>=20
> This patch adds a simple policy to dynamically adjust the idle
> timeout based on the percentage of available memory in the system
> as follow:
>=20
> . > 70%    : unlimited. Courtesy clients are allowed to remain valid
>             as long as memory availability is above 70%
> . 60% - 70%:  1 day.
> . 50% - 60%:  1hr
> . 40% - 50%:  30mins
> . 30% - 40%:  15mins
> . < 30%:      disable. Expire all existing courtesy clients and donot
>              allow new courtesey client

I thought our plan was to add a shrinker to do this.


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++++++++++++++++++--
> fs/nfsd/nfsd.h      |  5 ++++-
> 2 files changed, 43 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9409a0dc1b76..a7feea9d07cf 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5788,12 +5788,47 @@ nfs4_anylock_blockers(struct nfs4_client *clp)
> 	return false;
> }
>=20
> +static bool
> +nfs4_allow_courtesy_client(struct nfsd_net *nn, unsigned int *idle_timeo=
ut)
> +{
> +	unsigned long avail;
> +	bool ret =3D true;
> +	unsigned int courtesy_expire =3D 0;
> +	struct sysinfo si;
> +
> +	si_meminfo(&si);
> +	avail =3D (si.freeram * 10) / (si.totalram - si.totalhigh);
> +	switch (avail) {
> +	case 7: case 8: case 9: case 10:
> +		courtesy_expire =3D 0;		/* unlimit */
> +		break;
> +	case 6:
> +		courtesy_expire =3D NFSD_COURTESY_CLIENT_TO_1DAY;
> +		break;
> +	case 5:
> +		courtesy_expire =3D NFSD_COURTESY_CLIENT_TO_1HR;
> +		break;
> +	case 4:
> +		courtesy_expire =3D NFSD_COURTESY_CLIENT_TO_30MINS;
> +		break;
> +	case 3:
> +		courtesy_expire =3D NFSD_COURTESY_CLIENT_TO_15MINS;
> +		break;
> +	default:
> +		ret =3D false;			/* disallow CC */
> +	}
> +	*idle_timeout =3D courtesy_expire;
> +	return ret;
> +}
> +
> static void
> nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
> 				struct laundry_time *lt)
> {
> 	struct list_head *pos, *next;
> 	struct nfs4_client *clp;
> +	unsigned int exptime;
> +	bool allow_cc =3D nfs4_allow_courtesy_client(nn, &exptime);
>=20
> 	INIT_LIST_HEAD(reaplist);
> 	spin_lock(&nn->client_lock);
> @@ -5803,11 +5838,13 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, str=
uct list_head *reaplist,
> 			goto exp_client;
> 		if (!state_expired(lt, clp->cl_time))
> 			break;
> +		if (!allow_cc)
> +			goto exp_client;
> 		if (!atomic_read(&clp->cl_rpc_users))
> 			clp->cl_state =3D NFSD4_COURTESY;
> 		if (!client_has_state(clp) ||
> -				ktime_get_boottime_seconds() >=3D
> -				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
> +				(exptime && ktime_get_boottime_seconds() >=3D
> +				(clp->cl_time + exptime)))
> 			goto exp_client;
> 		if (nfs4_anylock_blockers(clp)) {
> exp_client:
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 847b482155ae..9d4a5708f852 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -340,7 +340,10 @@ void		nfsd_lockd_shutdown(void);
> #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>=20
> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
> -#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
> +#define	NFSD_COURTESY_CLIENT_TO_1DAY	(24 * 60 * 60)	/* seconds */
> +#define	NFSD_COURTESY_CLIENT_TO_1HR	(60 * 60)
> +#define	NFSD_COURTESY_CLIENT_TO_30MINS	(30 * 60)
> +#define	NFSD_COURTESY_CLIENT_TO_15MINS	(15 * 60)
>=20
> /*
>  * The following attributes are currently not supported by the NFSv4 serv=
er:
> --=20
> 2.9.5
>=20

--
Chuck Lever



