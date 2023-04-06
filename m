Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC446D9D68
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 18:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbjDFQUG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 12:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbjDFQUE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 12:20:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABAB55A3
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 09:19:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336ElPnr009832;
        Thu, 6 Apr 2023 16:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FzUBJbZUw8uBAABRV/bLudvRjdYdeCVCK15aHkzgvDk=;
 b=JWf/Gkif/bxm9pc1bLQwCc3ZOyyOI3uGVfCDFdCFtc/lDIyYptunU0J4c98LdihpBwLq
 pUQHxjoOIBMARi4Ayh8OyGJayrNEdjEfiq47r8xz9xGmMDSD8Rdxc582wM27g/2sVuJe
 F23ML4NBHnVoM6apt/X3IiCzAyG4pP/n2B5mK0JL1q5aDueh/KMxUltOA2N5Johl5ShJ
 DfHEGsFy6JnT2u1WPZKb5rmzJWCte1FHNMm5BJU6BIMb8edJvhkyXFxVh4na3cVpP6BK
 pWUg1NhEAqCmtOmG4Qn3YaGXANFBOSH1wKTgBF4JruW8GYNEejzLu0G87cDDU4YFV3LJ JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnd3byy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 16:19:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336FDiem008914;
        Thu, 6 Apr 2023 16:19:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3k7fhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 16:19:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwOObIh4J48Xng0Ls7eD0QnxVBjbcZ4i0MzkXded2OE8QGSA324/SIusc6w77eXuREmS2W99FbT/idhu7Wh5Q0Mmy47E41FHTNcALL3KJPvg5dEjA0WrKjUVPBVjqWIjMawaklzP1zRWaBa10flHv6+YDxrqBH6ct+OWg2FOhWVmgYDue8+ae0yt6HqIFcLoYNiTsz2opugSjMVBPwSe+04Di89PJxbi44VMD0UJd4JZdoOsLBxP8bz+TVDPcA2Kvn16D6JiywvkKGCvYo7AlkYFnHpBzG3uvrUp09qPQwJS0WRcBIvs6aPQNez6wwu+9dhFoQ0MlyBP8TqGOmGTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzUBJbZUw8uBAABRV/bLudvRjdYdeCVCK15aHkzgvDk=;
 b=d28EIsuKta98vVpNg45rq2Ai8msitcLpA375gloIg3DUsgYAaYjI8VL8nIw0+ZPkgIPvJxgBbOpU6gr0HXd68kggw1JfLZ/bbHnaflwl+fYTthmVfq1lo+EOR3n7rclZTmLrJuZd69FSGSr51JnpVetmGZlgh8ab2TDJZGXjz9cV6r0eS0hNgB05SpIxMEjL8YInZXXOBoOoSnyk6QLaT2V6A0PvdIDCopNhsADzbKpG2FiY3Q2Isu1KeaolzvQeKhJVDHu1ba7+4kaOUCztvfKaSymFGcX2rSoq9/1p5zQHiTAnpAz1rTwr0TWwkwdyJKGOR+WVuLNPTdTllkxjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzUBJbZUw8uBAABRV/bLudvRjdYdeCVCK15aHkzgvDk=;
 b=E9Nu+WR6tj69OR/xgkj4Z8QxyLsNfUvAHVqDFrH0VdNoCX+NNm6yNiqxx0gsx90rSmsoIP77MbVPTC7nTClzEUIQ5TXdcx4npO8RFXDKHTqyEgDsmIBwBVCyUsYCP4Fm++6QawVW3cKyPKww5LZckTfDyaUrq28kxfvBXWi3HmA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6285.namprd10.prod.outlook.com (2603:10b6:806:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 16:19:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 16:19:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Herzog <herzog@phys.ethz.ch>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: file server freezes with all nfsds stuck in D state after upgrade
 to Debian bookworm
Thread-Topic: file server freezes with all nfsds stuck in D state after
 upgrade to Debian bookworm
Thread-Index: AQHZaHlTRrbt4X56/UeV6X78Hvk59K8eS9UAgAAdagCAAAIMAIAAA86AgAAHIwA=
Date:   Thu, 6 Apr 2023 16:19:52 +0000
Message-ID: <ED825E99-1934-4F88-986E-2F1358D2D75A@oracle.com>
References: <ZC6oX7FxdJd86rF7@phys.ethz.ch>
 <6785EFE7-2CE1-45CD-8643-C40CCCDADEB8@oracle.com>
 <ZC7mOH4I3roIM4xr@phys.ethz.ch>
 <478CD009-C11B-46F2-AD13-689953D612ED@oracle.com>
 <ZC7rIWmrxTKSvFAi@phys.ethz.ch>
In-Reply-To: <ZC7rIWmrxTKSvFAi@phys.ethz.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6285:EE_
x-ms-office365-filtering-correlation-id: 3b3c49be-c644-4682-3d55-08db36bac0ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XnIXxxlDdXDEValnqVOVwzuwMlFpKKwpS6J72FQ7cIuwJ9VmvltSIasr4QctZVTlhrALVTfg62F0bytMMA4wCgr1kec8c+axGXcPg0wHEjsFtrck/VeseJO8F3Cc9BeyjnegOA+diBhsMEpPcSfnQpKbj5zyBKtmTQzHrvQHF4CmkeJng5sDFZAqSiaS67v3oKvcr9My4dTR31TDmZ58FhClDa0OWQs8z6Ol1tYARof/KCcTwy1PoxllrLSoSwdbE/Pg7XlmW11Ob2MFgqcf+P1HQ9nLS4ByPiyy4mXv4JMJSIIILq2Ng2HfHKJi7JPYRk1v9xMhDvvN+lcOqtpPigqFCuMHcVWE0j2Zg4bb8DijirG9PgPrlqPdFj/1pmR4Ajw3OODHE3gqLDvC125v4NoqutaoNhChCy9JlTIWsC3MFoEf4SjptzL91g1hZnoYTiH1ZXY3Y5rfKy9LPKVfnixrRvQYF8BppStmMYvw0b6RX3oL8rhHrs92E8bAwPet0atE4z9jhkJF1TGUwQo/ZpC8bf/2O9R9Hu2wuxc1udQgF4/5u+OWc6hYTir+OX8JTB7Le0NQRpzaHkyWLSMvdx9WLSsA6itWQ9TDZlHrdFaFKIW+6sLX86NrfkHVOj/tS3KM/KX/FoRiYmmKNUAz4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(478600001)(53546011)(91956017)(316002)(76116006)(64756008)(66946007)(8676002)(66446008)(66476007)(66556008)(6916009)(41300700001)(6486002)(2906002)(71200400001)(122000001)(4326008)(38100700002)(8936002)(5660300002)(86362001)(38070700005)(2616005)(33656002)(26005)(6506007)(6512007)(186003)(83380400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I5dpMvpcYnoAa3LRs+LBN32+7AW5g7aAFZK7JRKhxZVSt0J6b8SBuYQtRPHZ?=
 =?us-ascii?Q?4nCVu0aWwKZ5G2f00oCZ6tzGPWA/5VICdsoyo6PwMl0aCpPqdCd1h6SzXSPL?=
 =?us-ascii?Q?WWeJARxKIPuphNvxWVApDROoFDh1DsPjcrm4GdHK3h6BRx9uSjbYFoFkZynX?=
 =?us-ascii?Q?s322LFNUtP/6qUcFS24gSj+C0XstN71RsZPE4GxlkRqHiUGO67+6goTcfk3+?=
 =?us-ascii?Q?EOK+VPxFwqsaBglLLDVarcgVx2TqxXkeKpUKAHVMkXbcTOKkfimLvwABZAUR?=
 =?us-ascii?Q?gUWyuMZ0RUHH5cpo+kuPu4bHIm9zkTLn12bA2unhdA7s+AgZwHqPVp8R0Oom?=
 =?us-ascii?Q?6RZaGk6WM6qICg6RNb4f3EyguJmj8LC4kLTi6TN2sIbunA3WJUY8G/a6ZgDt?=
 =?us-ascii?Q?C9ccdC1Elly+q3Kha7twiVc9clJLx0Op3dFMW2uPD+inpbInXDoX16cXznKC?=
 =?us-ascii?Q?Jg+QcBK/RQ+MfGRNXpiJWhOley7VRQTxUbsYt8NdrrcqeMxu+ASxMAdj5Cdc?=
 =?us-ascii?Q?EFkYDhmIl6PvXe4hwsNgAR4YJid2/QbZ3LdZ4OB1x6sKs4eF8ArGAq98z9D3?=
 =?us-ascii?Q?808PyGkdp9Ebrle55smJCVst3aVxBnuK+33petoaFZ5h0yZsBzo8v1rT5URq?=
 =?us-ascii?Q?nGAk64IFpHq92j3CabyDIAr71s7aJapJqefKy4WoAJohgYLskj1IeYkwxsxE?=
 =?us-ascii?Q?0VAAGQIX7Nm+pkoqcBaI4VnUW0+yRoCh0Vb/yEWSZ114wE6yR1XfH7Kc87L2?=
 =?us-ascii?Q?5TxuJjH5kDTnxoZvB9Z/Hh+wL1LiXzQahCusItU94RYwlxk3ujdkp1qCuCr9?=
 =?us-ascii?Q?0STDWDOQuN9K7zJkew6Qmu7PfgZQYQ4exJeIhJzvfNYtjYezHLO16GSRRdXl?=
 =?us-ascii?Q?if2GWP3MyIhQabbmtVqyC0J0yRG7ifEKAsa6D1TCy5fr4xXUX7j1++GzG4JW?=
 =?us-ascii?Q?1T8RUHD78Hq0+oy/SOzrCNDv1h0JxXa0T1cAicssEPPoWkBUkV6RyAfdSv9g?=
 =?us-ascii?Q?RBrHMqEACs41Zr1KbtvrxWbma0aFL5HuX6rTkjId2/+UrW7LUZBKu+TeGIRF?=
 =?us-ascii?Q?PaV/XyRZZgb2GnMWd2P452u3cXHLpOKRGSR9VvH/7Ie3mvpAMvvAYGAtJ7hV?=
 =?us-ascii?Q?wsimMdHQXFinbCPMqtUmpqfX5nVTGRsmDbdcIIq6gvc0Za1JEWZx5Uz5+7vj?=
 =?us-ascii?Q?1+kTqPTPZV7TaVlryRHrMhvFCaEQQB7dCztNoOuA1k8GIW35xNEUOHlNLxiP?=
 =?us-ascii?Q?ytgaxnfAY088EYsqTcEp+X5StEb1p95aAXMKZL4sk1Z5QDlSdb9AYOUKtqgw?=
 =?us-ascii?Q?3u25tKmDGG9qhzi6vi9KXmMp5Q7Y0+hqDQZHqJoJ2p27UWupRsb4J+eV6m1z?=
 =?us-ascii?Q?jjlgYdB+EII4LBBuEeDAoYpf7p9biXganWmkAyt4hcOt67LtPRUw+DVU36Zo?=
 =?us-ascii?Q?JHcedz00ckWmRYv/DffFmHBNaZhA3V7H/2C51ORi1qsz2O31hg79nZGPqkfS?=
 =?us-ascii?Q?4TS21e1D3gw2cpVw5vZo5+3txeFJ94ltRWXbPCFB2eFoKWffvKIHtWCN3l81?=
 =?us-ascii?Q?yNjHcu3tEtPY7GPSZGOyBOfF/AsXit4VAKMTaezuFh7NYDWB7m/g17lp0nwG?=
 =?us-ascii?Q?qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FAA8AD0040B3684E97D65F5F092DEF80@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VmPIgJfBRThbvlbmDv6uFsLaINbGdHX3sz9Q1ssk7fLxEkVR0RMztJDRZC3HYmKwmJiZhyyEuO01X1sxqR/UNhe4REDQa6KjcJpJ7m5ZnYn5iprJFrwXXnNQ/RWGs0Z4Q4qkfz3f6+K6limRXY+esghwj+FTK75jBGywY8KgJmJ7UKB+jzq1Rzw1hpN1OR/XHAVOrWpmjn5equ0QY42diLwafhfVS7aLhPCzM6kjrzbQSytkrze0qTelOGkdIh/8iWw1UbTj1GGFoMviK7YBunjnR3dSsntCUULu5p+GtrACMNhYDhVlFhIugmkqjutsqVeJBx87HxsErfDy0fMuRwiuZrkHHsnssl9geBSZdVP+5uXmTnKU06dSNvpX/LlCSNmM752RZefDaC8mBV0GgQWA/le5LrZ8aHRtiiYoWDSjV3KFRYZcXT7XrTuymf5ASPhpj7cJn1s7A2PbKMWIaOXEu1Uu/sZlRwcGqJBw52j7aR2Or80N53HsA2qzjSE2E6F/jeQBWNtYntSWJiaPNAeqw0r6YH7EuLA7tX6sKIcdjXhtOs/+6+w2Z+HdvoIHORZapHTSBpp5wXzdGrOg/oDF/3Fdv0y7EWE32hjhytI7UaRghhZ/H4A582gzDKlA+UBM6ZojUvXixVitkTEkU9WrZJFiN0YGB20s7p3fu1ORZPCmydrcpUnRQptJNsfsHOmuSbYLnM/V1JJ/B9lozXhrYIe5DrGw6pxAu6oRTh59TcSxTRVRHMKyZbQOhjsCM2xSL23lXYrxxYUvZPwelqAIkrEUyEAiLSbCHpyIJjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3c49be-c644-4682-3d55-08db36bac0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 16:19:52.7831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvDaoGF2urwL+0ywuodCymZeEI7lX3fQXuppZWUa0cdFXrDOC4t7lqly/iyQ97Hiqh28I+QHPC1aXtQOw/hhFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060145
X-Proofpoint-GUID: 5wyavGe2JfKfeEnlVKv2dBKRtEBMmfRl
X-Proofpoint-ORIG-GUID: 5wyavGe2JfKfeEnlVKv2dBKRtEBMmfRl
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 6, 2023, at 11:54 AM, Christian Herzog <herzog@phys.ethz.ch> wrote=
:
>=20
> Dear Chuck,
>=20
>>> That was our first idea too, but we haven't found any indication that t=
his is the case. The xfs file systems seem perfectly fine when all nfsds ar=
e in D state, and we can
>>> read from them and write to them. If xfs were to block nfs IO, this sho=
uld
>>> affect other processes too, right?
>>=20
>> It's possible that the NFSD threads are waiting on I/O to a particular f=
ilesystem block. XFS is not likely to block other activity in this case.
> ok good to know. So far we were under the impression that a file system w=
ould
> block as a whole.

XFS tries to operate in parallel as much as it can. Maybe other filesystems=
 aren't as capable.

If the unresponsive block is part of a superblock or the journal (ie, share=
d metadata) I would expect XFS to become unresponsive. For I/O on blocks co=
ntaining file data, it is likely to have more robust behavior.


>> I'm merely suggesting that you should start troubleshooting at the botto=
m of the stack instead of the top. The wait is far outside the realm of NFS=
D.
> thanks, point taken. So next time it happens we'll make sure to poke in t=
his
> direction during the few minutes we have for debugging before we get tarr=
ed
> and feathered by the users.

I encourage you to discuss debugging tactics with Jens and the block folks =
-- you can probably capture a lot of info during those few minutes if you h=
ave some expert guidance.

Good luck!


--
Chuck Lever


