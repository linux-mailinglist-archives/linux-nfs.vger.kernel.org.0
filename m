Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E5543929
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jun 2022 18:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245629AbiFHQfS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jun 2022 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245714AbiFHQfR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jun 2022 12:35:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92E6374EC7
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jun 2022 09:35:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258DxSEo014885;
        Wed, 8 Jun 2022 16:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MtKASHJ/GHs2qoirUyRYPQUc14kjo46QocjKnicJ8os=;
 b=NQgkO7Tixiu0a/lNge/8Fmm1qVdBcgjYgYD9gwcw4Sw9pifpvmI6EyfBsOTvhYRKjCqt
 1pVfXxr8ujSR+wdAhGh6e88Gh6muNvqKusHJy9zjIEOKSBWNbLAODkIEryuInFAb8FFV
 tojPJpsPt/sN2cTxAU86KpTlqrDEJDFKTLXEfhnMdZKc1w/i6EGV2cITyFK910E+SCJB
 DIu32J8s3Y/2i1EcI2ithq4emoEj9dnCMdCoksTCcU1G4TMaeuEkbheC1NX/RgPRemeQ
 XBM9waV6LoR4tSCODyK/K6ALxEHYwB6fa2RWLhIVBCb6UYFa/nA1x6kuEV0FIuL4Bq1H bA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghvs3ccex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 16:35:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 258GAXN1035847;
        Wed, 8 Jun 2022 16:35:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu4780s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 16:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV77QKT4x7q+umbkBDHyt2G8TVC7T7SqQr85ElFUaIS+dxaPYUnb0ZbDTMVNCKght87HmR6ndbKFL4fLk4eb9q7Bu7QZ+41eFF6phL+PU1evkmdOt8J7wZN8bF/ucu6+/l9CkAhMMXpGVICyl3TaxCUVSFb+6oXJMfSAJDz9lVFnV+CC0xf+NjuEO1/AQ/kmctAcFMKFZbyHscSqSG7TkwjLiBttFcAdN9aGIoAtqwoDxlEwEXmLdSD6vzeeOBtJVJrQp5qj3EgLmNgEDbxksh8GFw/1frPHhWF6KW3zfaO0AXqXJnlpRSWAfT8RMMqEmc4ocv3fVute9JGs1jgpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtKASHJ/GHs2qoirUyRYPQUc14kjo46QocjKnicJ8os=;
 b=FYX+idxM7Uw80ZuLK0JFswW0Id7+Z59JGOFQVMXAu5RqSn5KwqD/2IhC+AzLURK7KQ/bagJeK2ghHDr5doGP54hjErDjwTfZXNaRDs+iL3FiSfxUWF85uAJ7DyFM3u9mwcLTRWHW5Ko528K7UduCmu1/548DS+jRLB140MY3mPYRzrlGjHFkZbQ5+zM3I3Zw++hte6U8BAaUuh2TVMzeE71IgErAD2tfJRL9K8uU50+Cn8agaLnpKLWvQ80UC5G/Rm95VoviwAgUr37WDlh+7nwbufS82SsK5ZwkLwBOzzuerIDWn0bi7U6FVDgVSVrKRUjbrE0aka8C9f9jjPG4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtKASHJ/GHs2qoirUyRYPQUc14kjo46QocjKnicJ8os=;
 b=LFygAafsEXoBkhR/99CldP5ZB9weCdXrD0bj5vZKndLr30kc9gKhCPRuov6SKhSv7LovDAz2k1sjfZKLNujVDG8s02vLaiXhCy26AGLVjNirWiN4LfECzgZpjdCnOiosbxCBmt+rwHNXOgxdGGqf6IP83iIl9uxTGvia8DJZTfc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1303.namprd10.prod.outlook.com (2603:10b6:903:28::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Wed, 8 Jun
 2022 16:35:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:35:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 0/5] Fix NFSv3 READDIRPLUS failures
Thread-Topic: [PATCH v2 0/5] Fix NFSv3 READDIRPLUS failures
Thread-Index: AQHYetYGj/3jDvrME0iRnh1HU/dRZK1FtL4AgAABBYA=
Date:   Wed, 8 Jun 2022 16:35:09 +0000
Message-ID: <BFC4A686-A0FF-43A5-BBBE-8CDC7A809FD9@oracle.com>
References: <165463444560.38298.18296069287423675496.stgit@bazille.1015granger.net>
 <20220608163130.GB16378@fieldses.org>
In-Reply-To: <20220608163130.GB16378@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 637e9423-1fc1-421b-9db0-08da496cda82
x-ms-traffictypediagnostic: CY4PR10MB1303:EE_
x-microsoft-antispam-prvs: <CY4PR10MB13032A4E0D709C964166083D93A49@CY4PR10MB1303.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1seEmjjO3KQRX6e11+2PRNZWCWkNH7JIeW6ORl7kQZsjjEbpXL3RuyAvnFgso16SEsn7o/4l6yGFefMFv0n6kxnKAVgkFnDMnyud6o4x/tsVtH1Xp5uP3MQdHgs3WfWI9mvEmYD4Eub+cS4DbzZ+JuhAj/OqPFl7CiTCS980C4UgLTd0+VzgnmH9Ji0kwggBTXarT06CqpOOQsUlZMHM5orFnmkyTKOSPvkkOouo38nMYv3a8RQ+PrTwWDkl1GBk+3cEkeQCqfi3qnoq+Eb7lCZOEkIXSEBPWE+tiJy5ZVqvxT1sIEYfC8SQQNRHd1+ym4aMFf5+GpYN36eMjBnwt5nx//XvqFSM7R9Nhv0CQ303z9YtGJCyZaeLT11AlQjkes4cTvAiRuaqQqSICpLiKmgKK8WH6MymZPekQKRNMJBt99zaOK9eFGn4jRKJ+0W04+d8YNcCJrOVq0h4nbLj4q53C8RerVSxzkc8SEMqQcjDvZ2+jqQej1ojEFLu3pE6EB83+8RRH2tWjn/VEmCORP4th4OElYd6/O9VpiJzJoFLCRMhA3vdKX2zL/rh5njctNk3DOOFIMbg2KuQSR2wrpyETNqjNaIeGff0SQSw6xoKq2MpyD/kmcOJhOQuskiMgLJ6+M0Ti0nG0F/pO24I+lfR8lvsQLJopteVJQu01LHSOPvFdctvLi4Z+hVA/mZ61OIYauvbdnFOcluDcX8IeBjLX9H8EkFg/W4l4x+xms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(6506007)(5660300002)(122000001)(38070700005)(91956017)(66946007)(76116006)(86362001)(2906002)(66446008)(66476007)(64756008)(71200400001)(83380400001)(508600001)(8936002)(6512007)(36756003)(66556008)(8676002)(4326008)(186003)(6486002)(53546011)(316002)(6916009)(54906003)(38100700002)(33656002)(26005)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fr3KbGUMK9nMdLsOG5sg59sbaCYMkKOe6y7yrmhBzjCSzQkZUw3ATSU69Ug8?=
 =?us-ascii?Q?9K+Ggjh0u306+EER+6pbbIVwSi7PYvAifuo5ajG2ehialaeM9yxtPaHBacJL?=
 =?us-ascii?Q?qRRE5bik3j7tNQiuM/pVkma09rHzMBGkZS1XS6T00mwWtochN6lQSCe7jMVV?=
 =?us-ascii?Q?+PurY3Xi45oziUDdfh2kEsTj4gZuwYp5XyGSkHBxIPX2d5/Gxn9UsWPVqy+L?=
 =?us-ascii?Q?wyr2BuoJGfl30Vhd36uw7GwJAibH8kgOW02hzfC2PsqCOv37jJPo72tmSKm8?=
 =?us-ascii?Q?Yc0uDR3mZbLK6TNxJ1He3hx4APo5h3g0iu6vHFLaQsxuSQqCkWYvcptUmYub?=
 =?us-ascii?Q?WA9zRhdyo2WcW6xYuiQwdFUqvl8gNnCIgpWXHawxNrPEwYKWCmIEX1l3ULie?=
 =?us-ascii?Q?nfsKy/EB6dPJHp3oQJp1CnE9XSfXT3h4mL52K66rH75PDNkvfSyEL7sPPTMD?=
 =?us-ascii?Q?MZwa4KaT6kcSFpqDMfMp0ar2hjVjEUkRRWoYB1a9k+FYbXC1Wvz33hJ072H8?=
 =?us-ascii?Q?FF0UMWnfJRLjcgsdHTvhv8GABafBqpgfnvyIS3VPtaZ8tgJzbSyTUeLOWzhQ?=
 =?us-ascii?Q?9l4VCmxZK+7KeLg1s+CK12cU5bQ9MOJXu7BAR0psSU5qx8UZnpF4rRt4vt1i?=
 =?us-ascii?Q?khVL+tfpFXkd8hZqeL7j+pnanPhfi2Z0t6CmOAs5d8gnEC90AqNNr/FzWuJO?=
 =?us-ascii?Q?1JRx9mHDrcPSncwxoZH5BU3yfKb5Fl0AKPmkq320xLKypabHy/Uumm3QbFG5?=
 =?us-ascii?Q?Og7yEun26kshAkT2HhbXeOyDFj1Oa5hDUF/LasgBXrRchK5X4DlPJAO1dFZM?=
 =?us-ascii?Q?tbc3A2GXZYXvq3aI3JnaXdRRa0/iJpqbGRQSrnMUWZiXiTVD4T1kxk+NRWWr?=
 =?us-ascii?Q?FxHRwO+5ZW0KS0EO9YKWUxA+jvzcoMg0ZHXjkmv3d2K9TfoePBLctVIo0xHu?=
 =?us-ascii?Q?eVj1WIZXqWFOXmQoper/jdY/xTwK/JIV6s/sqTxd7N1HC+tLhqZt2Sq8AoIg?=
 =?us-ascii?Q?rPMDsIdITTyOH2tDuwG2iSbxsZbjyGPGdf2C2H5lpF+MtR12cNuiIc0OG9Gp?=
 =?us-ascii?Q?KQDZYW6vhz5MIUtSZv1ioDiQKHiLlR/ig38FsoasNwGAM6/X08tmZLoZTWnk?=
 =?us-ascii?Q?dU9+EdwQXUu3A0hEL5Amb13pv7NN4VSO1XvURNn5ClJ5odWEa3qH6dEWR3sC?=
 =?us-ascii?Q?Bb9SZKbHteUfrKCwx0BJ7LsC8h5soTKEAr4G52fqg2MOOT26q3zmAf7CmavR?=
 =?us-ascii?Q?H4eG6iJ2pVymoLYPpHhB5dugAIeo3MYGgb14NaKr9pAHLCAu5guFgVUOlyIh?=
 =?us-ascii?Q?MYh1SHBhjDA3SaQwcL6qibv5aBtvKBXqUXaN/GHSohUSJHGUSJ/FKQJGryO/?=
 =?us-ascii?Q?TE2nuf/mBAd2TDV8B7Wa4qLIES0aOCVEy2z2OxVyzVbo6Id/R+8qVYe7MoqF?=
 =?us-ascii?Q?RPfWuVKqtiFpVa/xxk7bV6LaD362/bgCaJxQyx1fEhT8ykbD+lqPxmxdHr4V?=
 =?us-ascii?Q?x10kUU107iBZO/bWkau4WMp8eOtTqPvsbxrk00qUMSrgR+TSP11KpwU5CNVE?=
 =?us-ascii?Q?xBB7oYS02Myjb2QIPn1D9XVweOiwg7GHHRD3bsyrVgNzm3QOKhzBxU/LvsVn?=
 =?us-ascii?Q?LCTnbWxabopk31ZugKjifYDNybSSffg/5biZ4+KITp0qnbektvb9RaEXWzrC?=
 =?us-ascii?Q?nactypJOUATmoieRBlADis6HhgKalkHyvp2Pvpeit6DtK1JK4Q/Vo4PhADIl?=
 =?us-ascii?Q?Jvv8r+DLZjme0AwL8sWSACT1caUde98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A4DC4113093A84685FBF6DB202938B3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637e9423-1fc1-421b-9db0-08da496cda82
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 16:35:09.7166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyfP87PNUKESB3hv/XSACX7r95sCKVKJ01lN3NUAVNdF6C0nN6vg2cCVeaGm0bsE2y6/gFYVfx8fBOyuKmTHbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1303
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-08_04:2022-06-07,2022-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206080067
X-Proofpoint-ORIG-GUID: Ba0v5wPoXfGOKMga3ymg027TNJylOWBm
X-Proofpoint-GUID: Ba0v5wPoXfGOKMga3ymg027TNJylOWBm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 8, 2022, at 12:31 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> Looks good.  Feel free to add my reviewed-by:.

Thanks!


> Do we have a test that reads a large enough directory?

Yes. I've been using a script that downloads and builds git, then runs
its unit test suite. That generates multi-page directory entry payloads.


> Seems like that
> plus the right kernel debugging options should have caught the original
> bug.

Yep, it triggered svcrdma_small_wrch_err.


--
Chuck Lever



